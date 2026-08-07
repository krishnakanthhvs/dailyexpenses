import React from 'react';
import { 
  LayoutDashboard, 
  Receipt, 
  BarChart3, 
  Settings, 
  ChevronLeft, 
  ChevronRight, 
  Wallet,
  X,
  Calculator,
  CreditCard
} from 'lucide-react';

export default function Sidebar({ activeTab, setActiveTab, isCollapsed, setIsCollapsed, isMobileOpen, setIsMobileOpen }) {
  const navItems = [
    { id: 'dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { id: 'transactions', label: 'Transactions', icon: Receipt },
    { id: 'emi', label: 'EMI Tracker', icon: Calculator },
    { id: 'cards', label: 'Credit Cards', icon: CreditCard },
    { id: 'analytics', label: 'Analytics', icon: BarChart3 },
    { id: 'settings', label: 'Settings', icon: Settings },
  ];

  const handleNavClick = (id) => {
    setActiveTab(id);
    setIsMobileOpen(false); // Close mobile drawer on navigation
  };

  return (
    <>
      {/* Mobile Backdrop Overlay */}
      {isMobileOpen && (
        <div 
          onClick={() => setIsMobileOpen(false)}
          className="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-40 lg:hidden"
        />
      )}

      {/* Sidebar Container */}
      <aside 
        className={`bg-slate-900 text-slate-300 min-h-screen border-r border-slate-800 transition-all duration-300 fixed lg:sticky top-0 z-50 flex flex-col justify-between ${
          // Desktop Widths
          isCollapsed ? 'lg:w-20' : 'lg:w-64'
        } ${
          // Mobile Sliding Drawer
          isMobileOpen ? 'translate-x-0 w-64' : '-translate-x-full lg:translate-x-0'
        }`}
      >
        {/* Top Branding */}
        <div>
          <div className="flex items-center justify-between p-5 border-b border-slate-800">
            <div className="flex items-center gap-3 overflow-hidden">
              <div className="p-2 bg-indigo-600 rounded-xl text-white flex-shrink-0">
                <Wallet className="w-5 h-5" />
              </div>
              {(!isCollapsed || isMobileOpen) && (
                <span className="font-bold text-lg text-white tracking-wide truncate">
                  ExpenseFlow
                </span>
              )}
            </div>
            
            {/* Desktop Collapse Toggle */}
            <button 
              onClick={() => setIsCollapsed(!isCollapsed)}
              className="hidden lg:block p-1.5 text-slate-400 hover:text-white hover:bg-slate-800 rounded-lg transition-colors"
              title={isCollapsed ? "Expand" : "Collapse"}
            >
              {isCollapsed ? <ChevronRight className="w-5 h-5" /> : <ChevronLeft className="w-5 h-5" />}
            </button>

            {/* Mobile Close Button */}
            <button 
              onClick={() => setIsMobileOpen(false)}
              className="lg:hidden p-1.5 text-slate-400 hover:text-white hover:bg-slate-800 rounded-lg"
            >
              <X className="w-5 h-5" />
            </button>
          </div>

          {/* Nav Links */}
          <nav className="p-3 space-y-1.5 mt-4">
            {navItems.map((item) => {
              const Icon = item.icon;
              const isActive = activeTab === item.id;
              return (
                <button
                  key={item.id}
                  onClick={() => handleNavClick(item.id)}
                  className={`w-full flex items-center gap-3.5 px-3.5 py-3 rounded-xl text-sm font-medium transition-all ${
                    isActive
                      ? 'bg-indigo-600 text-white shadow-md shadow-indigo-600/20'
                      : 'text-slate-400 hover:text-slate-200 hover:bg-slate-800/60'
                  }`}
                >
                  <Icon className={`w-5 h-5 flex-shrink-0 ${isActive ? 'text-white' : 'text-slate-400'}`} />
                  {(!isCollapsed || isMobileOpen) && <span className="truncate">{item.label}</span>}
                </button>
              );
            })}
          </nav>
        </div>

        {/* User Footer */}
        <div className="p-4 border-t border-slate-800 flex items-center gap-3">
          <div className="w-9 h-9 rounded-full bg-indigo-500/20 border border-indigo-500/30 text-indigo-400 font-bold flex items-center justify-center flex-shrink-0 text-sm">
            HK
          </div>
          {(!isCollapsed || isMobileOpen) && (
            <div className="truncate text-xs">
              <p className="font-semibold text-slate-200 truncate">Krishna Kanth</p>
              <p className="text-slate-500 truncate">Personal Workspace</p>
            </div>
          )}
        </div>
      </aside>
    </>
  );
}
