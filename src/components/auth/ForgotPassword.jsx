import React, { useState } from 'react';
import { Mail, KeyRound, ArrowLeft, CheckCircle2 } from 'lucide-react';

export default function ForgotPassword({ onSwitchToLogin }) {
  const [email, setEmail] = useState('');
  const [isSubmitted, setIsSubmitted] = useState(false);
  const [loading, setLoading] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!email) return;

    setLoading(true);

    // Simulated Reset Link dispatch
    setTimeout(() => {
      setLoading(false);
      setIsSubmitted(true);
    }, 1000);
  };

  return (
    <div className="w-full max-w-md mx-auto p-6 sm:p-8 bg-white rounded-2xl border border-slate-200 shadow-xl">
      <div className="text-center mb-8">
        <div className="inline-flex p-3 rounded-2xl bg-indigo-50 text-indigo-600 mb-3">
          <KeyRound className="w-7 h-7" />
        </div>
        <h2 className="text-2xl font-extrabold text-slate-900">Reset Password</h2>
        <p className="text-xs text-slate-500 mt-1">Enter your registered email to receive reset instructions</p>
      </div>

      {isSubmitted ? (
        <div className="text-center space-y-4">
          <div className="p-4 bg-emerald-50 rounded-2xl border border-emerald-200 flex flex-col items-center">
            <CheckCircle2 className="w-10 h-10 text-emerald-600 mb-2" />
            <h4 className="font-bold text-slate-800 text-sm">Reset Link Sent!</h4>
            <p className="text-xs text-slate-600 mt-1">
              We have sent a password reset email to <span className="font-semibold text-slate-900">{email}</span>.
            </p>
          </div>

          <button
            onClick={onSwitchToLogin}
            className="w-full py-2.5 text-xs font-semibold text-indigo-600 hover:text-indigo-700 flex items-center justify-center gap-1.5"
          >
            <ArrowLeft className="w-4 h-4" /> Back to Sign In
          </button>
        </div>
      ) : (
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-xs font-semibold text-slate-700 mb-1">Email Address</label>
            <div className="relative">
              <Mail className="w-4 h-4 absolute left-3 top-3 text-slate-400" />
              <input
                type="email"
                placeholder="name@example.com"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                className="w-full pl-9 pr-3 py-2.5 text-xs border border-slate-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                required
              />
            </div>
          </div>

          <button
            type="submit"
            disabled={loading}
            className="w-full py-3 px-4 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold rounded-xl shadow-lg shadow-indigo-600/20 transition-all"
          >
            {loading ? 'Sending Request...' : 'Send Reset Link'}
          </button>

          <button
            type="button"
            onClick={onSwitchToLogin}
            className="w-full py-2 text-xs font-semibold text-slate-500 hover:text-slate-700 flex items-center justify-center gap-1.5 pt-2"
          >
            <ArrowLeft className="w-4 h-4" /> Back to Sign In
          </button>
        </form>
      )}
    </div>
  );
}
