// src/pages/PublicAddExpense.jsx
import React, { useState } from 'react';

export default function PublicAddExpense() {
  const [email, setEmail] = useState('');
  const [isVerifying, setIsVerifying] = useState(false);
  const [userFound, setUserFound] = useState(null); // Stores { userId, email, familyMembers }
  const [lookupError, setLookupError] = useState('');

  const [formData, setFormData] = useState({
    note: '',
    amount: '',
    category: 'Food',
    spentBy: 'Self',
    bankName: 'Cash',
    date: new Date().toISOString().split('T')[0]
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [successMsg, setSuccessMsg] = useState(false);

  // Step 1: Lookup User ID and Family Members by Email (No Auth Header Needed)
  const handleVerifyEmail = async (e) => {
    e.preventDefault();
    if (!email.trim()) return;

    setIsVerifying(true);
    setLookupError('');

    try {
      // Direct call without Bearer token header
      const res = await fetch(`/api/family/public-lookup?email=${encodeURIComponent(email.trim())}`);
      const data = await res.json();

      if (!res.ok) {
        throw new Error(data.error || 'User account not found');
      }

      setUserFound(data);
    } catch (err) {
      setLookupError(err.message);
    } finally {
      setIsVerifying(false);
    }
  };

  // Step 2: Post Public Expense (No Auth Header Needed)
  const handleSubmitExpense = async (e) => {
    e.preventDefault();
    if (!formData.note || !formData.amount || !userFound) return;

    setIsSubmitting(true);
    try {
      const res = await fetch('/api/transactions/public-add', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          userId: userFound.userId,
          ...formData,
          amount: parseFloat(formData.amount)
        })
      });

      if (!res.ok) {
        const errData = await res.json();
        throw new Error(errData.error || 'Failed to submit expense');
      }

      setSuccessMsg(true);
      setFormData({
        note: '',
        amount: '',
        category: 'Food',
        spentBy: 'Self',
        bankName: 'Cash',
        date: new Date().toISOString().split('T')[0]
      });

      setTimeout(() => setSuccessMsg(false), 4000);
    } catch (err) {
      alert(`Error: ${err.message}`);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-100 flex items-center justify-center p-4">
      <div className="max-w-md w-full bg-white rounded-2xl border border-slate-200 shadow-lg p-6 space-y-6">
        <h2 className="text-xl font-bold text-slate-800 border-b pb-3">Quick Expense Entry</h2>

        {!userFound ? (
          <form onSubmit={handleVerifyEmail} className="space-y-4">
            <div>
              <label className="block text-xs font-medium text-slate-700 mb-1">Enter Registered Email ID</label>
              <input
                type="email"
                placeholder="e.g. krishna@gmail.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full p-2.5 border rounded-xl text-xs outline-none focus:ring-2 focus:ring-indigo-500"
                required
              />
            </div>

            {lookupError && <p className="text-xs text-rose-600 bg-rose-50 p-2 rounded-lg">{lookupError}</p>}

            <button
              type="submit"
              disabled={isVerifying}
              className="w-full py-2.5 bg-indigo-600 text-white font-semibold text-xs rounded-xl hover:bg-indigo-700"
            >
              {isVerifying ? 'Verifying...' : 'Continue'}
            </button>
          </form>
        ) : (
          <form onSubmit={handleSubmitExpense} className="space-y-4">
            <div className="flex justify-between items-center text-xs bg-indigo-50 p-3 rounded-xl border border-indigo-100">
              <span>Account: <strong>{userFound.email}</strong></span>
              <button
                type="button"
                onClick={() => setUserFound(null)}
                className="text-indigo-600 font-semibold underline"
              >
                Change
              </button>
            </div>

            {successMsg && (
              <div className="p-3 bg-emerald-50 text-emerald-800 text-xs rounded-xl border border-emerald-200">
                ✅ Expense added successfully!
              </div>
            )}

            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">Spent By (Person)</label>
              <select
                value={formData.spentBy}
                onChange={(e) => setFormData({ ...formData, spentBy: e.target.value })}
                className="w-full p-2.5 border rounded-xl text-xs bg-white"
              >
                <option value="Self">Me (Self)</option>
                {userFound.familyMembers && userFound.familyMembers.map((member, i) => (
                  <option key={i} value={member.name}>
                    {member.name} ({member.relationship})
                  </option>
                ))}
              </select>
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-700 mb-1">Description / Note</label>
              <input
                type="text"
                placeholder="e.g. Dinner with family, Petrol"
                value={formData.note}
                onChange={(e) => setFormData({ ...formData, note: e.target.value })}
                className="w-full p-2.5 border rounded-xl text-xs outline-none focus:ring-2 focus:ring-indigo-500"
                required
              />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Amount (₹)</label>
                <input
                  type="number"
                  placeholder="500"
                  value={formData.amount}
                  onChange={(e) => setFormData({ ...formData, amount: e.target.value })}
                  className="w-full p-2.5 border rounded-xl text-xs font-bold outline-none"
                  required
                />
              </div>
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Date</label>
                <input
                  type="date"
                  value={formData.date}
                  onChange={(e) => setFormData({ ...formData, date: e.target.value })}
                  className="w-full p-2.5 border rounded-xl text-xs bg-white"
                  required
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              className="w-full py-3 bg-indigo-600 text-white font-bold text-xs rounded-xl hover:bg-indigo-700 shadow-md transition-all"
            >
              {isSubmitting ? 'Saving...' : 'Submit Expense'}
            </button>
          </form>
        )}
      </div>
    </div>
  );
}