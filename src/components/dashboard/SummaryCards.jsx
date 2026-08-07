import React, { useMemo } from 'react';
import { TrendingDown, Wallet, PieChart as PieIcon } from 'lucide-react';
import { useExpenses } from '../../context/ExpenseContext';
import { formatCurrency } from '../../utils/formatters';

export default function SummaryCards() {
  const { expenses = [], monthlyBudget = 50000 } = useExpenses();

  const todayStr = new Date().toISOString().split('T')[0];

  // Safely calculate today's debit outflow
  const totalSpentToday = useMemo(() => {
    if (!Array.isArray(expenses)) return 0;
    return expenses
      .filter((exp) => exp.date === todayStr && exp.type !== 'Credit')
      .reduce((sum, exp) => sum + (Number(exp.amount) || 0), 0);
  }, [expenses, todayStr]);

  // Safely calculate total monthly debit outflow
  const totalSpentMonth = useMemo(() => {
    if (!Array.isArray(expenses)) return 0;
    return expenses
      .filter((exp) => exp.type !== 'Credit')
      .reduce((sum, exp) => sum + (Number(exp.amount) || 0), 0);
  }, [expenses]);

  // Identify top category by spend
  const topCategory = useMemo(() => {
    if (!Array.isArray(expenses) || expenses.length === 0) return 'N/A';
    
    const counts = expenses
      .filter((exp) => exp.type !== 'Credit')
      .reduce((acc, curr) => {
        const cat = curr.category || 'Uncategorized';
        acc[cat] = (acc[cat] || 0) + (Number(curr.amount) || 0);
        return acc;
      }, {});

    const sorted = Object.entries(counts).sort((a, b) => b[1] - a[1]);
    return sorted.length > 0 ? sorted[0][0] : 'N/A';
  }, [expenses]);

  // Safe percentage calculation preventing NaN
  const safeBudget = Number(monthlyBudget) || 50000;
  const rawPercent = (totalSpentMonth / safeBudget) * 100;
  const budgetUsagePercent = isNaN(rawPercent) ? 0 : Math.min(Math.round(rawPercent), 100);

  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
      
      {/* Spent Today Card */}
      <div className="bg-white rounded-2xl p-5 shadow-sm border border-slate-200 flex items-center justify-between">
        <div>
          <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Spent Today</p>
          <h3 className="text-2xl font-extrabold text-slate-900 mt-1">{formatCurrency(totalSpentToday)}</h3>
          <p className="text-xs text-slate-400 mt-1">Date: {todayStr}</p>
        </div>
        <div className="p-3 bg-amber-50 rounded-xl text-amber-600">
          <TrendingDown className="w-6 h-6" />
        </div>
      </div>

      {/* Monthly Outflow & Budget Progress Card */}
      <div className="bg-white rounded-2xl p-5 shadow-sm border border-slate-200 flex flex-col justify-between">
        <div className="flex items-center justify-between">
          <div>
            <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Monthly Outflow</p>
            <h3 className="text-2xl font-extrabold text-slate-900 mt-1">{formatCurrency(totalSpentMonth)}</h3>
          </div>
          <div className="p-3 bg-indigo-50 rounded-xl text-indigo-600">
            <Wallet className="w-6 h-6" />
          </div>
        </div>

        <div className="mt-4">
          <div className="flex justify-between text-xs text-slate-500 font-medium mb-1">
            <span>Budget: {formatCurrency(safeBudget)}</span>
            <span>{budgetUsagePercent}%</span>
          </div>
          <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
            <div
              className={`h-full transition-all duration-300 ${
                budgetUsagePercent > 90 ? 'bg-red-500' : 'bg-indigo-600'
              }`}
              style={{ width: `${budgetUsagePercent}%` }}
            />
          </div>
        </div>
      </div>

      {/* Highest Category Card */}
      <div className="bg-white rounded-2xl p-5 shadow-sm border border-slate-200 flex items-center justify-between">
        <div>
          <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Highest Category</p>
          <h3 className="text-2xl font-extrabold text-slate-900 mt-1">{topCategory}</h3>
          <p className="text-xs text-slate-400 mt-1">Based on total transactions</p>
        </div>
        <div className="p-3 bg-purple-50 rounded-xl text-purple-600">
          <PieIcon className="w-6 h-6" />
        </div>
      </div>

    </div>
  );
}
