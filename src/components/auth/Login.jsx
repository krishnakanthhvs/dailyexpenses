import React, { useState } from 'react';
import { Mail, Lock, Eye, EyeOff, LogIn, ArrowRight } from 'lucide-react';

export default function Login({ onLoginSuccess, onSwitchToRegister, onSwitchToForgot }) {
  const [formData, setFormData] = useState({ email: '', password: '' });
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    setError('');

    if (!formData.email || !formData.password) {
      setError('Please fill in all fields');
      return;
    }

    setLoading(true);

    // Simulated Auth Logic (Replace with Express/Postgres API call)
    setTimeout(() => {
      setLoading(false);
      // Simulate successful login
      const mockUser = {
        id: 1,
        fullName: 'Krishna Kanth',
        email: formData.email,
        token: 'mock-jwt-token-xyz'
      };
      
      // Save session
      localStorage.setItem('auth_user', JSON.stringify(mockUser));
      onLoginSuccess(mockUser);
    }, 1000);
  };

  return (
    <div className="w-full max-w-md mx-auto p-6 sm:p-8 bg-white rounded-2xl border border-slate-200 shadow-xl">
      <div className="text-center mb-8">
        <div className="inline-flex p-3 rounded-2xl bg-indigo-50 text-indigo-600 mb-3">
          <LogIn className="w-7 h-7" />
        </div>
        <h2 className="text-2xl font-extrabold text-slate-900">Welcome Back</h2>
        <p className="text-xs text-slate-500 mt-1">Sign in to access your dashboard and expense tracking</p>
      </div>

      {error && (
        <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-600 rounded-xl text-xs font-medium">
          {error}
        </div>
      )}

      <form onSubmit={handleSubmit} className="space-y-4">
        {/* Email Input */}
        <div>
          <label className="block text-xs font-semibold text-slate-700 mb-1">Email Address</label>
          <div className="relative">
            <Mail className="w-4 h-4 absolute left-3 top-3 text-slate-400" />
            <input
              type="email"
              placeholder="name@example.com"
              value={formData.email}
              onChange={(e) => setFormData({ ...formData, email: e.target.value })}
              className="w-full pl-9 pr-3 py-2.5 text-xs border border-slate-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:outline-none"
              required
            />
          </div>
        </div>

        {/* Password Input */}
        <div>
          <div className="flex justify-between items-center mb-1">
            <label className="block text-xs font-semibold text-slate-700">Password</label>
            <button
              type="button"
              onClick={onSwitchToForgot}
              className="text-xs font-semibold text-indigo-600 hover:text-indigo-700 hover:underline"
            >
              Forgot password?
            </button>
          </div>
          <div className="relative">
            <Lock className="w-4 h-4 absolute left-3 top-3 text-slate-400" />
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="••••••••"
              value={formData.password}
              onChange={(e) => setFormData({ ...formData, password: e.target.value })}
              className="w-full pl-9 pr-10 py-2.5 text-xs border border-slate-300 rounded-xl focus:ring-2 focus:ring-indigo-500 focus:outline-none"
              required
            />
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              className="absolute right-3 top-3 text-slate-400 hover:text-slate-600"
            >
              {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
            </button>
          </div>
        </div>

        {/* Submit Button */}
        <button
          type="submit"
          disabled={loading}
          className="w-full py-3 px-4 bg-indigo-600 hover:bg-indigo-700 text-white text-xs font-bold rounded-xl shadow-lg shadow-indigo-600/20 transition-all flex items-center justify-center gap-2"
        >
          {loading ? 'Signing in...' : 'Sign In'}
          {!loading && <ArrowRight className="w-4 h-4" />}
        </button>
      </form>

      {/* Footer link */}
      <div className="mt-6 pt-6 border-t border-slate-100 text-center text-xs text-slate-500">
        Don't have an account?{' '}
        <button
          onClick={onSwitchToRegister}
          className="font-bold text-indigo-600 hover:text-indigo-700 hover:underline"
        >
          Create an Account
        </button>
      </div>
    </div>
  );
}
