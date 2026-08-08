import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { User, Lock, Bell, Save, CheckCircle, AlertCircle, Smartphone, Mail, Send, Loader2, AtSign, ShieldCheck } from 'lucide-react';

export default function Settings() {
  const [loading, setLoading] = useState(true);
  const [savingSection, setSavingSection] = useState(null); // 'profile' | 'username' | 'password' | 'preferences'
  const [testingEmail, setTestingEmail] = useState(false);
  const [statusMsg, setStatusMsg] = useState({ type: '', text: '' });

  // 1. Profile State
  const [profile, setProfile] = useState({
    fullName: '',
    email: '',
    phone: '',
    username: '',
    usernameChangeCount: 0
  });

  // Dedicated Username Input State
  const [newUsername, setNewUsername] = useState('');

  // 2. Change Password State
  const [passwords, setPasswords] = useState({
    currentPassword: '',
    newPassword: '',
    confirmPassword: ''
  });

  // 3. Preferences State
  const [preferences, setPreferences] = useState({
    emailAlertsEnabled: true,
    emailAlertFrequency: 'Monthly',
    emiReminderTime: '2 Days',
    whatsappAlertsEnabled: false
  });

  useEffect(() => {
    fetchUserSettings();
  }, []);

  const fetchUserSettings = async () => {
    try {
      // 1. Get token from standalone key OR auth_user object
      let token = localStorage.getItem('token');
      if (!token) {
        const storedUser = localStorage.getItem('auth_user');
        if (storedUser) {
          const parsed = JSON.parse(storedUser);
          token = parsed.token;
        }
      }

      // 2. Fetch user settings
      const res = await axios.get('/api/settings', {
        headers: { Authorization: `Bearer ${token}` }
      });

      if (res.data) {
        if (res.data.profile) {
          setProfile(res.data.profile);
          setNewUsername(res.data.profile.username || '');
        }
        if (res.data.preferences) setPreferences(res.data.preferences);
      }
    } catch (err) {
      console.error('Error fetching settings:', err);
      if (err.response?.status === 403) {
        showNotification('error', 'Session expired or invalid token. Please log in again.');
      }
    } finally {
      setLoading(false);
    }
  };

  const showNotification = (type, text) => {
    setStatusMsg({ type, text });
    setTimeout(() => setStatusMsg({ type: '', text: '' }), 4000);
  };

  // Send Test Email Handler
  const handleTestEmail = async () => {
    if (!profile.email) {
      showNotification('error', 'Please enter a valid email address first.');
      return;
    }

    setTestingEmail(true);
    try {
      const token = localStorage.getItem('token');
      await axios.post('/api/settings/test-email', { email: profile.email }, {
        headers: { Authorization: `Bearer ${token}` }
      });
      showNotification('success', `Test email sent to ${profile.email}! Please check your inbox.`);
    } catch (err) {
      showNotification('error', err.response?.data?.error || 'Failed to send test email. Check your SMTP settings.');
    } finally {
      setTestingEmail(false);
    }
  };

  // Profile Save
  const handleProfileSubmit = async (e) => {
    e.preventDefault();
    setSavingSection('profile');
    try {
      const token = localStorage.getItem('token');
      await axios.put('/api/settings/profile', profile, {
        headers: { Authorization: `Bearer ${token}` }
      });
      showNotification('success', 'Profile details updated successfully!');
    } catch (err) {
      showNotification('error', err.response?.data?.error || 'Failed to update profile.');
    } finally {
      setSavingSection(null);
    }
  };

  // Username Save (Allowed ONCE)
  const handleUsernameSubmit = async (e) => {
    e.preventDefault();
    if (profile.usernameChangeCount >= 1) {
      showNotification('error', 'You have already changed your username once.');
      return;
    }
    setSavingSection('username');
    try {
      const token = localStorage.getItem('token');
      const res = await axios.put('/api/settings/username', { username: newUsername }, {
        headers: { Authorization: `Bearer ${token}` }
      });
      showNotification('success', res.data.message || 'Username updated successfully!');
      setProfile({ ...profile, username: newUsername, usernameChangeCount: 1 });
    } catch (err) {
      showNotification('error', err.response?.data?.error || 'Failed to update username.');
    } finally {
      setSavingSection(null);
    }
  };

  // Password Save
  const handlePasswordSubmit = async (e) => {
    e.preventDefault();
    if (passwords.newPassword !== passwords.confirmPassword) {
      showNotification('error', 'New passwords do not match!');
      return;
    }
    setSavingSection('password');
    try {
      const token = localStorage.getItem('token');
      await axios.put('/api/settings/change-password', {
        currentPassword: passwords.currentPassword,
        newPassword: passwords.newPassword
      }, {
        headers: { Authorization: `Bearer ${token}` }
      });
      showNotification('success', 'Password updated successfully!');
      setPasswords({ currentPassword: '', newPassword: '', confirmPassword: '' });
    } catch (err) {
      showNotification('error', err.response?.data?.error || 'Failed to update password.');
    } finally {
      setSavingSection(null);
    }
  };

  // Preferences Save
  const handlePreferencesSubmit = async (e) => {
    e.preventDefault();
    setSavingSection('preferences');
    try {
      const token = localStorage.getItem('token');
      await axios.put('/api/settings/preferences', preferences, {
        headers: { Authorization: `Bearer ${token}` }
      });
      showNotification('success', 'Preferences saved successfully!');
    } catch (err) {
      showNotification('error', 'Failed to save preferences.');
    } finally {
      setSavingSection(null);
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[300px] text-slate-500 font-medium text-sm">
        Loading settings...
      </div>
    );
  }

  return (
    <div className="mx-auto space-y-6">
      
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold text-slate-900 tracking-tight">Account Settings</h1>
        <p className="text-sm text-slate-500 mt-1">Manage your profile, username, password, and notification preferences.</p>
      </div>

      {/* Global Toast / Alert Banner */}
      {statusMsg.text && (
        <div className={`p-4 rounded-xl text-sm font-semibold flex items-center gap-3 shadow-sm border ${
          statusMsg.type === 'success' 
            ? 'bg-emerald-50 text-emerald-800 border-emerald-200' 
            : 'bg-rose-50 text-rose-800 border-rose-200'
        }`}>
          {statusMsg.type === 'success' ? <CheckCircle className="w-5 h-5 text-emerald-600 shrink-0" /> : <AlertCircle className="w-5 h-5 text-rose-600 shrink-0" />}
          <span>{statusMsg.text}</span>
        </div>
      )}

      {/* 2-COLUMN GRID FOR PROFILE & USERNAME/PASSWORD */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        
        {/* CARD 1: PROFILE DETAILS & USERNAME */}
        <section className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6 flex flex-col justify-between space-y-6">
          <div>
            <div className="flex items-center justify-between pb-4 border-b border-slate-100">
              <div className="flex items-center gap-3 text-slate-800">
                <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
                  <User className="w-5 h-5" />
                </div>
                <div>
                  <h2 className="font-bold text-slate-900 text-base">Profile Details</h2>
                  <p className="text-xs text-slate-400">Update your basic account information</p>
                </div>
              </div>
            </div>

            {/* USERNAME SECTION (Allows only 1 change) */}
            <form onSubmit={handleUsernameSubmit} className="pt-4 pb-4 border-b border-slate-100">
              <div className="flex items-center justify-between mb-1.5">
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500">
                  Username
                </label>
                {profile.usernameChangeCount >= 1 ? (
                  <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-amber-700 bg-amber-50 px-2 py-0.5 rounded-md border border-amber-200">
                    <ShieldCheck className="w-3 h-3 text-amber-600" /> Locked (Changed Once)
                  </span>
                ) : (
                  <span className="text-[11px] font-medium text-slate-400">Can be changed once</span>
                )}
              </div>

              <div className="flex gap-2">
                <div className="relative flex-1">
                  <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-slate-400">
                    <AtSign className="w-4 h-4" />
                  </div>
                  <input
                    type="text"
                    value={newUsername}
                    onChange={(e) => setNewUsername(e.target.value)}
                    disabled={profile.usernameChangeCount >= 1}
                    className="w-full pl-9 border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all disabled:bg-slate-50 disabled:text-slate-400 disabled:cursor-not-allowed"
                    placeholder="username"
                  />
                </div>

                {profile.usernameChangeCount < 1 && (
                  <button
                    type="submit"
                    disabled={savingSection === 'username' || newUsername === profile.username}
                    className="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-4 py-2.5 rounded-xl transition-all shadow-sm disabled:opacity-50"
                  >
                    {savingSection === 'username' ? 'Saving...' : 'Set Username'}
                  </button>
                )}
              </div>
            </form>

            {/* FULL NAME, EMAIL, AND PHONE FORM */}
            <form id="profile-form" onSubmit={handleProfileSubmit} className="space-y-4 pt-4">
              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Full Name</label>
                <input
                  type="text"
                  value={profile.fullName}
                  onChange={(e) => setProfile({ ...profile, fullName: e.target.value })}
                  className="w-full border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all"
                  placeholder="Krishna Kanth"
                />
              </div>

              <div>
                <div className="flex items-center justify-between mb-1.5">
                  <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500">Email Address</label>
                  
                  {/* TEST EMAIL BUTTON */}
                  <button
                    type="button"
                    onClick={handleTestEmail}
                    disabled={testingEmail || !profile.email}
                    className="inline-flex items-center gap-1.5 text-xs font-semibold text-indigo-600 hover:text-indigo-700 bg-indigo-50 hover:bg-indigo-100 px-2.5 py-1 rounded-lg transition-colors disabled:opacity-50"
                  >
                    {testingEmail ? (
                      <Loader2 className="w-3.5 h-3.5 animate-spin" />
                    ) : (
                      <Send className="w-3.5 h-3.5" />
                    )}
                    <span>{testingEmail ? 'Sending...' : 'Test Email'}</span>
                  </button>
                </div>
                <input
                  type="email"
                  value={profile.email}
                  onChange={(e) => setProfile({ ...profile, email: e.target.value })}
                  className="w-full border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all"
                  required
                />
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Phone Number (WhatsApp Alerts)</label>
                <input
                  type="tel"
                  value={profile.phone}
                  onChange={(e) => setProfile({ ...profile, phone: e.target.value })}
                  className="w-full border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all"
                  placeholder="+91 9876543210"
                />
              </div>
            </form>
          </div>

          <div className="pt-6 border-t border-slate-100 flex justify-end">
            <button
              form="profile-form"
              type="submit"
              disabled={savingSection === 'profile'}
              className="inline-flex items-center gap-2 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-5 py-2.5 rounded-xl transition-all shadow-sm active:scale-[0.98]"
            >
              <Save className="w-4 h-4" />
              <span>{savingSection === 'profile' ? 'Saving...' : 'Save Profile Details'}</span>
            </button>
          </div>
        </section>

        {/* CARD 2: CHANGE PASSWORD */}
        <section className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6 flex flex-col justify-between">
          <div>
            <div className="flex items-center gap-3 pb-4 border-b border-slate-100 text-slate-800">
              <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
                <Lock className="w-5 h-5" />
              </div>
              <div>
                <h2 className="font-bold text-slate-900 text-base">Security & Password</h2>
                <p className="text-xs text-slate-400">Update your account password</p>
              </div>
            </div>

            <form id="password-form" onSubmit={handlePasswordSubmit} className="space-y-4 pt-5">
              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Current Password</label>
                <input
                  type="password"
                  value={passwords.currentPassword}
                  onChange={(e) => setPasswords({ ...passwords, currentPassword: e.target.value })}
                  className="w-full border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all"
                  required
                />
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">New Password</label>
                <input
                  type="password"
                  value={passwords.newPassword}
                  onChange={(e) => setPasswords({ ...passwords, newPassword: e.target.value })}
                  className="w-full border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all"
                  required
                />
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1.5">Confirm New Password</label>
                <input
                  type="password"
                  value={passwords.confirmPassword}
                  onChange={(e) => setPasswords({ ...passwords, confirmPassword: e.target.value })}
                  className="w-full border border-slate-200 rounded-xl px-3.5 py-2.5 text-sm text-slate-800 focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:border-transparent transition-all"
                  required
                />
              </div>
            </form>
          </div>

          <div className="pt-6 border-t border-slate-100 mt-6 flex justify-end">
            <button
              form="password-form"
              type="submit"
              disabled={savingSection === 'password'}
              className="inline-flex items-center gap-2 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-5 py-2.5 rounded-xl transition-all shadow-sm active:scale-[0.98]"
            >
              <Lock className="w-4 h-4" />
              <span>{savingSection === 'password' ? 'Updating...' : 'Update Password'}</span>
            </button>
          </div>
        </section>

      </div>

      {/* CARD 3: FULL-WIDTH NOTIFICATIONS & ALERTS */}
      <section className="bg-white rounded-2xl border border-slate-200/80 shadow-sm p-6">
        <div className="flex items-center gap-3 pb-4 border-b border-slate-100 text-slate-800">
          <div className="p-2 bg-indigo-50 text-indigo-600 rounded-xl">
            <Bell className="w-5 h-5" />
          </div>
          <div>
            <h2 className="font-bold text-slate-900 text-base">Alert & Notification Preferences</h2>
            <p className="text-xs text-slate-400">Configure how and when ExpenseFlow alerts you</p>
          </div>
        </div>

        <form onSubmit={handlePreferencesSubmit} className="pt-5 space-y-6">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* 1. Email Summary Settings */}
            <div className="bg-slate-50/70 rounded-xl p-4 border border-slate-200/60 flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <Mail className="w-4 h-4 text-indigo-600" />
                    <span className="font-semibold text-sm text-slate-800">Email Reports</span>
                  </div>
                  <input
                    type="checkbox"
                    checked={preferences.emailAlertsEnabled}
                    onChange={(e) => setPreferences({ ...preferences, emailAlertsEnabled: e.target.checked })}
                    className="w-4 h-4 accent-indigo-600 rounded cursor-pointer"
                  />
                </div>
                <p className="text-xs text-slate-500">Get periodic summary reports delivered to your email.</p>
              </div>

              {preferences.emailAlertsEnabled && (
                <div>
                  <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1">Frequency</label>
                  <select
                    value={preferences.emailAlertFrequency}
                    onChange={(e) => setPreferences({ ...preferences, emailAlertFrequency: e.target.value })}
                    className="w-full border border-slate-200 rounded-lg p-2 text-xs text-slate-800 bg-white focus:outline-none focus:ring-2 focus:ring-indigo-600"
                  >
                    <option value="Daily">Daily</option>
                    <option value="Weekly">Weekly</option>
                    <option value="Monthly">Monthly</option>
                    <option value="Yearly">Yearly</option>
                  </select>
                </div>
              )}
            </div>

            {/* 2. EMI Reminders */}
            <div className="bg-slate-50/70 rounded-xl p-4 border border-slate-200/60 flex flex-col justify-between space-y-4">
              <div className="space-y-2">
                <div className="flex items-center gap-2">
                  <Bell className="w-4 h-4 text-indigo-600" />
                  <span className="font-semibold text-sm text-slate-800">EMI Reminders</span>
                </div>
                <p className="text-xs text-slate-500">How many days before due date should we alert you?</p>
              </div>

              <div>
                <label className="block text-xs font-semibold uppercase tracking-wider text-slate-500 mb-1">Lead Time</label>
                <select
                  value={preferences.emiReminderTime}
                  onChange={(e) => setPreferences({ ...preferences, emiReminderTime: e.target.value })}
                  className="w-full border border-slate-200 rounded-lg p-2 text-xs text-slate-800 bg-white focus:outline-none focus:ring-2 focus:ring-indigo-600"
                >
                  <option value="1 Day">1 Day Before</option>
                  <option value="2 Days">2 Days Before</option>
                  <option value="1 Week">1 Week Before</option>
                </select>
              </div>
            </div>

            {/* 3. WhatsApp Alerts */}
            <div className="bg-slate-50/70 rounded-xl p-4 border border-slate-200/60 flex flex-col justify-between space-y-4">
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <div className="flex items-center gap-2">
                    <Smartphone className="w-4 h-4 text-indigo-600" />
                    <span className="font-semibold text-sm text-slate-800">WhatsApp Alerts</span>
                  </div>
                  <input
                    type="checkbox"
                    checked={preferences.whatsappAlertsEnabled}
                    onChange={(e) => setPreferences({ ...preferences, whatsappAlertsEnabled: e.target.checked })}
                    className="w-4 h-4 accent-indigo-600 rounded cursor-pointer"
                  />
                </div>
                <p className="text-xs text-slate-500">Send direct WhatsApp notifications for upcoming EMIs.</p>
              </div>

              <div className="p-2 bg-indigo-50/70 rounded-lg text-[11px] text-indigo-700 border border-indigo-100">
                ⚡ Free messaging enabled via CallMeBot integration.
              </div>
            </div>

          </div>

          <div className="pt-4 border-t border-slate-100 flex justify-end">
            <button
              type="submit"
              disabled={savingSection === 'preferences'}
              className="inline-flex items-center gap-2 bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-xs px-5 py-2.5 rounded-xl transition-all shadow-sm active:scale-[0.98]"
            >
              <Save className="w-4 h-4" />
              <span>{savingSection === 'preferences' ? 'Saving...' : 'Save Preferences'}</span>
            </button>
          </div>
        </form>
      </section>

    </div>
  );
}