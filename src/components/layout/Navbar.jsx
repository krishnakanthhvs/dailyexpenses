import React from 'react';
import { Menu, X, Wallet, Bell, LogOut } from 'lucide-react';

export default function Navbar({ 
  activeTab, 
  onMobileMenuToggle, 
  isMobileOpen, 
  user, 
  onLogout 
}) {
  // Extract user initials dynamically
  const getInitials = (name) => {
    if (!name) return 'U';
    const parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return `${parts[0][0]}${parts[1][0]}`.toUpperCase();
    }
    return name.substring(0, 2).toUpperCase();
  };

  return (
    <header className="bg-white border-b border-slate-200 sticky top-0 z-30 px-4 sm:px-8 py-3.5 flex items-center justify-between">
      
      {/* Left: Mobile Toggle & Brand / Active View Title */}
      <div className="flex items-center gap-3">
        {/* Mobile Sidebar Toggle Button */}
        <button
          onClick={onMobileMenuToggle}
          className="p-2 text-slate-600 hover:text-slate-900 hover:bg-slate-100 rounded-lg lg:hidden transition-colors"
          aria-label="Toggle menu"
        >
          {isMobileOpen ? <X className="w-5 h-5" /> : <Menu className="w-5 h-5" />}
        </button>

        {/* Mobile Branding */}
        <div className="flex items-center gap-2.5 lg:hidden">
          <div className="p-1.5 bg-indigo-600 rounded-lg text-white">
            <Wallet className="w-4 h-4" />
          </div>
          <span className="font-bold text-slate-900 tracking-wide text-base">ExpenseFlow</span>
        </div>

        {/* Desktop View Title */}
        <div className="hidden lg:block">
          <h2 className="text-xl font-bold text-slate-800 capitalize">{activeTab}</h2>
        </div>
      </div>

      {/* Right: Quick Actions, User Badge & Logout */}
      <div className="flex items-center gap-3 sm:gap-4">
        
        {/* Notification Bell */}
        <button 
          className="p-2 text-slate-500 hover:text-slate-800 hover:bg-slate-100 rounded-full transition-colors relative"
          title="Notifications"
        >
          <Bell className="w-4 h-4" />
          <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-indigo-600 rounded-full"></span>
        </button>

        {/* User Profile Badge & Logout */}
        {user && (
          <div className="flex items-center gap-3 pl-3 border-l border-slate-200">
            <div className="flex items-center gap-2.5">
              <div className="w-8 h-8 rounded-full bg-indigo-600 text-white font-bold flex items-center justify-center text-xs shadow-sm">
                {getInitials(user.fullName)}
              </div>
              <div className="hidden sm:block text-left text-xs">
                <p className="font-semibold text-slate-800 leading-tight">
                  {user.fullName || 'User'}
                </p>
                <p className="text-slate-400 text-[10px]">
                  {user.email || 'Member'}
                </p>
              </div>
            </div>

            {/* Logout Button */}
            <button
              onClick={onLogout}
              className="p-2 text-slate-500 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors flex items-center gap-1.5 text-xs font-semibold"
              title="Logout"
            >
              <LogOut className="w-4 h-4" />
              <span className="hidden sm:inline">Logout</span>
            </button>
          </div>
        )}

      </div>
    </header>
  );
}
