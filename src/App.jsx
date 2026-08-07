import React, { useState } from 'react';

// Context
import { ExpenseProvider } from './context/ExpenseContext';

// Auth Components
import Login from './components/auth/Login';
import Register from './components/auth/Register';
import ForgotPassword from './components/auth/ForgotPassword';

// Layout & Dashboard Components
import Sidebar from './components/layout/Sidebar';
import Navbar from './components/layout/Navbar';
import SummaryCards from './components/dashboard/SummaryCards';
import QuickAddForm from './components/dashboard/QuickAddForm';
import CategoryChart from './components/dashboard/CategoryChart';
import TransactionTable from './components/dashboard/TransactionTable';
import EMITracker from './components/dashboard/EMITracker';
import Cards from './components/dashboard/Cards';

export default function App() {
  // Authentication State
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem('auth_user');
    return saved ? JSON.parse(saved) : null;
  });
  const [authView, setAuthView] = useState('login'); // 'login' | 'register' | 'forgot'

  // Navigation & Layout State
  const [activeTab, setActiveTab] = useState('dashboard');
  const [isCollapsed, setIsCollapsed] = useState(false);
  const [isMobileOpen, setIsMobileOpen] = useState(false);

  // Logout Handler
  const handleLogout = () => {
    localStorage.removeItem('auth_user');
    setUser(null);
    setAuthView('login');
  };

  // -------------------------------------------------------------
  // 1. UNAUTHENTICATED VIEW (Login / Register / Forgot Password)
  // -------------------------------------------------------------
  if (!user) {
    return (
      <div className="min-h-screen bg-slate-100 flex items-center justify-center p-4">
        {authView === 'login' && (
          <Login
            onLoginSuccess={(userData) => setUser(userData)}
            onSwitchToRegister={() => setAuthView('register')}
            onSwitchToForgot={() => setAuthView('forgot')}
          />
        )}

        {authView === 'register' && (
          <Register
            onRegisterSuccess={(userData) => setUser(userData)}
            onSwitchToLogin={() => setAuthView('login')}
          />
        )}

        {authView === 'forgot' && (
          <ForgotPassword
            onSwitchToLogin={() => setAuthView('login')}
          />
        )}
      </div>
    );
  }

  // -------------------------------------------------------------
  // 2. AUTHENTICATED VIEW (Full Dashboard Application)
  // -------------------------------------------------------------
  return (
    <ExpenseProvider>
      <div className="flex min-h-screen bg-slate-50 text-slate-900 font-sans">
        
        {/* Responsive Sidebar */}
        <Sidebar 
          activeTab={activeTab} 
          setActiveTab={setActiveTab}
          isCollapsed={isCollapsed}
          setIsCollapsed={setIsCollapsed}
          isMobileOpen={isMobileOpen}
          setIsMobileOpen={setIsMobileOpen}
        />

        {/* Right Content Area */}
        <div className="flex-1 flex flex-col min-w-0">
          
          {/* Top Sticky Nav */}
          <Navbar 
            activeTab={activeTab} 
            onMobileMenuToggle={() => setIsMobileOpen(!isMobileOpen)}
            isMobileOpen={isMobileOpen}
            user={user}
            onLogout={handleLogout}
          />

          {/* Main Dashboard Views */}
          <main className="flex-1 p-4 sm:p-6 md:p-8 overflow-y-auto">
            <div className="mx-auto space-y-6 sm:space-y-8">
              
              {/* Dashboard View */}
              {activeTab === 'dashboard' && (
                <>
                  <SummaryCards />
                  <div className="grid grid-cols-1 lg:grid-cols-3 gap-6 sm:gap-8">
                    <QuickAddForm />
                    <div className="lg:col-span-2">
                      <CategoryChart />
                    </div>
                  </div>
                  <TransactionTable />
                </>
              )}

              {/* Transactions View */}
              {activeTab === 'transactions' && (
                <div className="space-y-6">
                  <TransactionTable />
                </div>
              )}

              {/* EMI Tracker View */}
              {activeTab === 'emi' && <EMITracker />}

              {/* Cards View */}
              {activeTab === 'cards' && <Cards />}

              {/* Analytics View Placeholder */}
              {activeTab === 'analytics' && (
                <div className="bg-white p-8 rounded-xl border border-slate-200 text-center text-slate-500">
                  Analytics view ready for implementation!
                </div>
              )}

              {/* Settings View Placeholder */}
              {activeTab === 'settings' && (
                <div className="bg-white p-8 rounded-xl border border-slate-200 text-center text-slate-500">
                  Settings view ready for implementation!
                </div>
              )}

            </div>
          </main>
        </div>

      </div>
    </ExpenseProvider>
  );
}
