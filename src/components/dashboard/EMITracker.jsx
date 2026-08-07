import React, { useState, useMemo, useEffect } from 'react';
import { 
  Plus, 
  Trash2, 
  CreditCard, 
  CheckCircle2, 
  Loader2,
  Car,
  Home,
  User,
  GraduationCap,
  Smartphone,
  Bike,
  Layers,
  Lock,
  Coins
} from 'lucide-react';

const formatINR = (amount) => {
  if (amount === undefined || amount === null || isNaN(amount)) return '₹0';
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0
  }).format(amount);
};

// Helper to map loan types to distinct visual icons
const getLoanIcon = (name = '') => {
  const lower = name.toLowerCase();
  if (lower.includes('car') || lower.includes('auto')) return <Car className="w-5 h-5 text-blue-600" />;
  if (lower.includes('home') || lower.includes('house') || lower.includes('property')) return <Home className="w-5 h-5 text-emerald-600" />;
  if (lower.includes('bike') || lower.includes('two wheeler') || lower.includes('scooter')) return <Bike className="w-5 h-5 text-orange-600" />;
  if (lower.includes('education') || lower.includes('student') || lower.includes('college')) return <GraduationCap className="w-5 h-5 text-purple-600" />;
  if (lower.includes('phone') || lower.includes('mobile') || lower.includes('iphone')) return <Smartphone className="w-5 h-5 text-pink-600" />;
  if (lower.includes('personal')) return <User className="w-5 h-5 text-indigo-600" />;
  return <CreditCard className="w-5 h-5 text-slate-600" />;
};

// 1. Calculate Fixed Monthly EMI based on full original tenure
const calculateMonthlyEMI = (principal, annualRate, totalTenureMonths) => {
  const p = parseFloat(principal);
  const r = parseFloat(annualRate) / 12 / 100;
  const n = parseInt(totalTenureMonths, 10);

  if (isNaN(p) || p <= 0 || isNaN(n) || n <= 0) return 0;
  if (isNaN(r) || r === 0) return p / n;

  const emi = (p * r * Math.pow(1 + r, n)) / (Math.pow(1 + r, n) - 1);
  return Math.round(emi);
};

// 2. Calculate Outstanding Balance after paidMonths payments
const calculateOutstandingBalance = (principal, annualRate, totalTenureMonths, paidMonths) => {
  const p = parseFloat(principal);
  const r = parseFloat(annualRate) / 12 / 100;
  const n = parseInt(totalTenureMonths, 10);
  const k = parseInt(paidMonths, 10);

  if (isNaN(p) || p <= 0) return 0;
  if (k >= n) return 0;
  if (isNaN(r) || r === 0) return Math.max(0, p - (p / n) * k);

  const balance = p * ((Math.pow(1 + r, n) - Math.pow(1 + r, k)) / (Math.pow(1 + r, n) - 1));
  return Math.max(0, Math.round(balance));
};

export default function EMITracker() {
  const [emis, setEmis] = useState([]);
  const [loading, setLoading] = useState(true);
  const [showAddModal, setShowAddModal] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const [formData, setFormData] = useState({
    name: '',
    lender: '',
    deductionBank: '',
    principal: '',
    interestRate: '',
    tenureMonths: '',
    paidMonths: '0',
    deductionDay: '5',
    startDate: new Date().toISOString().split('T')[0]
  });

  // Fetch EMIs
  const fetchEmis = async () => {
    try {
      setLoading(true);
      const res = await fetch('/api/emis');
      if (res.ok) {
        const data = await res.json();
        setEmis(data);
      }
    } catch (err) {
      console.error('Error fetching EMIs:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchEmis();
  }, []);

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.name || !formData.principal || !formData.interestRate || !formData.tenureMonths) {
      alert('Please fill in all required fields.');
      return;
    }

    try {
      setIsSubmitting(true);
      const res = await fetch('/api/emis', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(formData)
      });

      if (res.ok) {
        setShowAddModal(false);
        setFormData({
          name: '',
          lender: '',
          deductionBank: '',
          principal: '',
          interestRate: '',
          tenureMonths: '',
          paidMonths: '0',
          deductionDay: '5',
          startDate: new Date().toISOString().split('T')[0]
        });
        fetchEmis();
      } else {
        const errData = await res.json();
        alert(`Error: ${errData.error}`);
      }
    } catch (err) {
      alert('Failed to save EMI record.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleIncrementPaid = async (id) => {
    try {
      const res = await fetch(`/api/emis/${id}/increment`, { method: 'PATCH' });
      if (res.ok) {
        fetchEmis();
      } else {
        const data = await res.json();
        alert(`Error: ${data.error}`);
      }
    } catch (err) {
      alert('Failed to update payment status.');
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Are you sure you want to delete this EMI tracker?')) return;
    try {
      const res = await fetch(`/api/emis/${id}`, { method: 'DELETE' });
      if (res.ok) {
        fetchEmis();
      }
    } catch (err) {
      alert('Failed to delete EMI record.');
    }
  };

  const handlePartPayment = async (emiId) => {
    const amountStr = prompt('Enter Part Payment Amount (₹):');
    if (!amountStr) return;

    const amount = parseFloat(amountStr);
    if (isNaN(amount) || amount <= 0) {
      alert('Invalid amount entered.');
      return;
    }

    try {
      const response = await fetch(`/api/emis/${emiId}/part-payment`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ amount }),
      });

      if (response.ok) {
        alert('Part payment applied successfully!');
        fetchEmis();
      } else {
        const data = await response.json();
        alert(`Error: ${data.error}`);
      }
    } catch (err) {
      alert('Failed to apply part payment.');
    }
  };

  const handleForeclosure = async (emiId) => {
    const confirmForeclose = window.confirm(
      'Are you sure you want to foreclose this loan? This will mark it as fully settled.'
    );
    if (!confirmForeclose) return;

    try {
      const response = await fetch(`/api/emis/${emiId}/foreclose`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
      });

      if (response.ok) {
        alert('Loan foreclosed successfully!');
        fetchEmis();
      } else {
        const data = await response.json();
        alert(`Error: ${data.error}`);
      }
    } catch (err) {
      alert('Failed to foreclose loan.');
    }
  };

  // Aggregated Summary Statistics
  const summary = useMemo(() => {
    let totalMonthlyEMI = 0;
    let totalOutstanding = 0;

    emis.forEach((item) => {
      const isForeclosed = item.status === 'FORECLOSED';
      const isCompleted = item.paidMonths >= item.tenureMonths;

      if (!isForeclosed && !isCompleted) {
        const monthly = calculateMonthlyEMI(item.principal, item.interestRate, item.tenureMonths);
        const outstanding = calculateOutstandingBalance(
          item.principal,
          item.interestRate,
          item.tenureMonths,
          item.paidMonths
        );
        totalMonthlyEMI += monthly;
        totalOutstanding += outstanding;
      }
    });

    return { 
      totalMonthlyEMI, 
      totalOutstanding, 
      activeCount: emis.filter(e => e.status !== 'FORECLOSED' && e.paidMonths < e.tenureMonths).length 
    };
  }, [emis]);

  return (
    <div className="space-y-6 mx-auto p-4 sm:p-6">
      {/* Header & Actions */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-slate-900 tracking-tight">EMI & Loan Dashboard</h1>
          <p className="text-xs text-slate-500 mt-1">Track active loans, monthly outflows, part-payments, and settlements.</p>
        </div>
        <button
          onClick={() => setShowAddModal(true)}
          className="inline-flex items-center gap-2 px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white font-medium text-xs rounded-xl shadow-sm transition-colors self-start sm:self-auto"
        >
          <Plus className="w-4 h-4" />
          Add New Loan / EMI
        </button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="p-4 bg-white rounded-2xl border border-slate-200/80 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-medium text-slate-500">Total Monthly Outflow</p>
            <p className="text-xl font-bold text-slate-900 mt-1">{formatINR(summary.totalMonthlyEMI)}</p>
          </div>
          <div className="p-3 bg-indigo-50 text-indigo-600 rounded-xl">
            <CreditCard className="w-5 h-5" />
          </div>
        </div>

        <div className="p-4 bg-white rounded-2xl border border-slate-200/80 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-medium text-slate-500">Total Outstanding Balance</p>
            <p className="text-xl font-bold text-slate-900 mt-1">{formatINR(summary.totalOutstanding)}</p>
          </div>
          <div className="p-3 bg-blue-50 text-blue-600 rounded-xl">
            <Layers className="w-5 h-5" />
          </div>
        </div>

        <div className="p-4 bg-white rounded-2xl border border-slate-200/80 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-medium text-slate-500">Active Tracked EMIs</p>
            <p className="text-xl font-bold text-slate-900 mt-1">{summary.activeCount} Active</p>
          </div>
          <div className="p-3 bg-emerald-50 text-emerald-600 rounded-xl">
            <CheckCircle2 className="w-5 h-5" />
          </div>
        </div>
      </div>

      {/* EMI Cards Grid */}
      {loading ? (
        <div className="flex items-center justify-center py-16">
          <Loader2 className="w-8 h-8 animate-spin text-indigo-600" />
        </div>
      ) : emis.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-2xl border border-dashed border-slate-300">
          <CreditCard className="w-12 h-12 mx-auto text-slate-400 mb-3" />
          <h3 className="text-sm font-semibold text-slate-700">No EMIs Tracked Yet</h3>
          <p className="text-xs text-slate-500 mt-1">Click "Add New Loan / EMI" above to get started.</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {emis.map((emi) => {
            const isCompleted = emi.status === 'COMPLETED' || emi.paidMonths >= emi.tenureMonths;
            const isForeclosed = emi.status === 'FORECLOSED';

            // Fixed monthly EMI calculated on original tenure
            const monthlyEMI = calculateMonthlyEMI(emi.principal, emi.interestRate, emi.tenureMonths);

            // Outstanding balance deducting paid EMIs
            const outstandingBalance = (isForeclosed || isCompleted)
              ? 0
              : calculateOutstandingBalance(emi.principal, emi.interestRate, emi.tenureMonths, emi.paidMonths);

            const progressPct = isForeclosed
              ? 100
              : Math.min(100, Math.round((emi.paidMonths / emi.tenureMonths) * 100));

            return (
              <div
                key={emi.id}
                className="bg-white rounded-2xl border border-slate-200/80 shadow-sm hover:shadow-md transition-all p-5 flex flex-col justify-between"
              >
                <div>
                  {/* Card Header */}
                  <div className="flex items-start justify-between gap-3 mb-3">
                    <div className="flex items-center gap-3">
                      <div className="p-2.5 bg-slate-100 rounded-xl">
                        {getLoanIcon(emi.name)}
                      </div>
                      <div>
                        <h3 className="font-bold text-slate-900 text-sm">{emi.name}</h3>
                        <p className="text-xs text-slate-500">{emi.lender || 'Bank Loan'}</p>
                      </div>
                    </div>
                    <button
                      onClick={() => handleDelete(emi.id)}
                      className="text-slate-400 hover:text-rose-600 transition-colors p-1"
                      title="Delete Tracker"
                    >
                      <Trash2 className="w-4 h-4" />
                    </button>
                  </div>

                  {/* Financial Metrics */}
                  <div className="grid grid-cols-2 gap-3 py-3 my-2 border-y border-slate-100">
                    <div>
                      <p className="text-[11px] font-medium text-slate-500">Monthly EMI (Fixed)</p>
                      <p className="text-base font-bold text-indigo-600">
                        {isForeclosed ? '₹0' : formatINR(monthlyEMI)}
                      </p>
                    </div>
                    <div>
                      <p className="text-[11px] font-medium text-slate-500">Outstanding Balance</p>
                      <p className="text-base font-bold text-rose-600">
                        {formatINR(outstandingBalance)}
                      </p>
                    </div>
                  </div>

                  {/* Details Meta */}
                  <div className="space-y-1.5 text-xs text-slate-600 mb-4">
                    <div className="flex justify-between">
                      <span className="text-slate-500">Original Principal:</span>
                      <span className="font-semibold">{formatINR(emi.principal)}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-slate-500">Interest Rate:</span>
                      <span className="font-semibold">{emi.interestRate}% p.a.</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-slate-500">Deduction Bank:</span>
                      <span className="font-semibold">{emi.deductionBank || 'N/A'}</span>
                    </div>
                    <div className="flex justify-between">
                      <span className="text-slate-500">Auto-Debit Day:</span>
                      <span className="font-semibold">{emi.deductionDay}th of every month</span>
                    </div>
                  </div>

                  {/* Progress Bar */}
                  <div className="space-y-1">
                    <div className="flex justify-between text-xs text-slate-500">
                      <span>Tenure Progress</span>
                      <span className="font-semibold">{emi.paidMonths} / {emi.tenureMonths} Months</span>
                    </div>
                    <div className="w-full bg-slate-100 rounded-full h-2 overflow-hidden">
                      <div
                        className={`h-2 rounded-full transition-all duration-500 ${
                          isForeclosed || isCompleted ? 'bg-emerald-500' : 'bg-indigo-600'
                        }`}
                        style={{ width: `${progressPct}%` }}
                      ></div>
                    </div>
                  </div>
                </div>

                {/* Card Actions Footer */}
                <div className="mt-4 pt-3 border-t border-slate-100 space-y-2">
                  {!isForeclosed && !isCompleted && (
                    <div className="flex items-center gap-2">
                      <button
                        onClick={() => handleIncrementPaid(emi.id)}
                        className="flex-1 py-1.5 px-3 text-xs font-semibold text-indigo-600 bg-indigo-50 hover:bg-indigo-100 rounded-lg transition-colors flex items-center justify-center gap-1"
                      >
                        <CheckCircle2 className="w-3.5 h-3.5" />
                        Mark Month Paid
                      </button>
                    </div>
                  )}

                  <div className="flex items-center gap-2">
                    {!isForeclosed && !isCompleted && (
                      <>
                        <button
                          onClick={() => handlePartPayment(emi.id)}
                          className="flex-1 px-3 py-1.5 text-xs font-semibold text-indigo-600 bg-indigo-50 hover:bg-indigo-100 rounded-lg transition-colors flex items-center justify-center gap-1"
                        >
                          <Coins className="w-3.5 h-3.5" />
                          Part Payment
                        </button>

                        <button
                          onClick={() => handleForeclosure(emi.id)}
                          className="flex-1 px-3 py-1.5 text-xs font-semibold text-emerald-600 bg-emerald-50 hover:bg-emerald-100 rounded-lg transition-colors flex items-center justify-center gap-1"
                        >
                          <Lock className="w-3.5 h-3.5" />
                          Foreclose Loan
                        </button>
                      </>
                    )}

                    {isForeclosed && (
                      <span className="w-full text-center py-1.5 px-3 text-xs font-semibold text-emerald-700 bg-emerald-100 rounded-lg block">
                        Foreclosed & Fully Settled
                      </span>
                    )}

                    {!isForeclosed && isCompleted && (
                      <span className="w-full text-center py-1.5 px-3 text-xs font-semibold text-emerald-700 bg-emerald-100 rounded-lg block">
                        Loan Fully Paid
                      </span>
                    )}
                  </div>
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Add EMI Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-2xl max-w-md w-full p-6 shadow-xl border border-slate-100">
            <h2 className="text-lg font-bold text-slate-900 mb-4">Add New EMI Tracker</h2>

            <form onSubmit={handleSubmit} className="space-y-3">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Loan Title *</label>
                <input
                  type="text"
                  name="name"
                  placeholder="e.g. Car Loan, iPhone EMI"
                  value={formData.name}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  required
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Lender / Bank</label>
                  <input
                    type="text"
                    name="lender"
                    placeholder="e.g. HDFC, ICICI"
                    value={formData.lender}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Deduction Bank</label>
                  <input
                    type="text"
                    name="deductionBank"
                    placeholder="e.g. Salary Account"
                    value={formData.deductionBank}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Principal Amount (₹) *</label>
                  <input
                    type="number"
                    name="principal"
                    placeholder="50000"
                    value={formData.principal}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                    required
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Interest Rate (% p.a.) *</label>
                  <input
                    type="number"
                    step="0.01"
                    name="interestRate"
                    placeholder="10.5"
                    value={formData.interestRate}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                    required
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Tenure (Months) *</label>
                  <input
                    type="number"
                    name="tenureMonths"
                    placeholder="12"
                    value={formData.tenureMonths}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                    required
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Already Paid Months</label>
                  <input
                    type="number"
                    name="paidMonths"
                    placeholder="0"
                    value={formData.paidMonths}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  />
                </div>
              </div>

              <div className="flex items-center justify-end gap-3 pt-4 border-t border-slate-100">
                <button
                  type="button"
                  onClick={() => setShowAddModal(false)}
                  className="px-4 py-2 text-xs font-medium text-slate-600 hover:bg-slate-100 rounded-lg transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="px-5 py-2 text-xs font-semibold text-white bg-indigo-600 hover:bg-indigo-700 rounded-lg shadow-sm transition-colors flex items-center gap-1.5"
                >
                  {isSubmitting && <Loader2 className="w-3.5 h-3.5 animate-spin" />}
                  {isSubmitting ? 'Saving...' : 'Save & Track EMI'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}