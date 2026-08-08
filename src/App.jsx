import React, { useState, useEffect } from 'react';

// Context
import { ExpenseProvider } from './context/ExpenseContext';

// Auth Components
import Login from './components/auth/Login';
import Register from './components/auth/Register';
import ForgotPassword from './components/auth/ForgotPassword';

// Public Unauthenticated Page
import PublicAddExpense from './components/dashboard/PublicAddExpense';

// Layout & Dashboard Components
import Sidebar from './components/layout/Sidebar';
import Navbar from './components/layout/Navbar';
import SummaryCards from './components/dashboard/SummaryCards';
import QuickAddForm from './components/dashboard/QuickAddForm';
import CategoryChart from './components/dashboard/CategoryChart';
import TransactionTable from './components/dashboard/TransactionTable';
import EMITracker from './components/dashboard/EMITracker';
import Cards from './components/dashboard/Cards';
import Settings from './components/dashboard/Settings';

export default function App() {
  // 1. CHECK URL PATH FOR PUBLIC ROUTE FIRST (No login required)
  const [currentPath, setCurrentPath] = useState(window.location.pathname);

  useEffect(() => {
    const handlePopState = () => setCurrentPath(window.location.pathname);
    window.addEventListener('popstate', handlePopState);
    return () => window.removeEventListener('popstate', handlePopState);
  }, []);

  // 🟢 IF PATH IS /add-expense, RENDER PUBLIC FORM IMMEDIATELY WITHOUT LOGIN CHECK
  if (currentPath === '/add-expense') {
    return <PublicAddExpense />;
  }

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

  // 🔒 UNAUTHENTICATED USERS: Render Login / Register Screen
  if (!user) {
    if (authView === 'register') {
      return <Register onSwitchToLogin={() => setAuthView('login')} />;
    }
    if (authView === 'forgot') {
      return <ForgotPassword onSwitchToLogin={() => setAuthView('login')} />;
    }
    return (
      <Login
        onLoginSuccess={(userData) => {
          localStorage.setItem('auth_user', JSON.stringify(userData));
          setUser(userData);
        }}
        onSwitchToRegister={() => setAuthView('register')}
        onSwitchToForgot={() => setAuthView('forgot')}
      />
    );
  }

  // 🟢 AUTHENTICATED USERS: Render Main Application
  return (
    <ExpenseProvider>
      <div className="flex h-screen bg-slate-50 overflow-hidden font-sans">
        {/* Sidebar Navigation */}
        <Sidebar
          activeTab={activeTab}
          setActiveTab={setActiveTab}
          isCollapsed={isCollapsed}
          setIsCollapsed={setIsCollapsed}
          isMobileOpen={isMobileOpen}
          setIsMobileOpen={setIsMobileOpen}
        />

        {/* Main Workspace */}
        <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
          <Navbar
            user={user}
            onLogout={handleLogout}
            onToggleMobileSidebar={() => setIsMobileOpen(!isMobileOpen)}
          />

          <main className="flex-1 overflow-y-auto p-4 sm:p-6 lg:p-8">
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
              {activeTab === 'settings' && <Settings />}

            </div>
          </main>
        </div>
      </div>
    </ExpenseProvider>
  );
}