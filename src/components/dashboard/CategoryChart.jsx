import React, { useMemo } from 'react';
import { ResponsiveContainer, PieChart, Pie, Cell, Tooltip } from 'recharts';
import { useExpenses } from '../../context/ExpenseContext';
import { CATEGORY_COLORS } from '../../utils/constants';
import { formatCurrency } from '../../utils/formatters';

export default function CategoryChart() {
  const { expenses } = useExpenses();

  const categoryChartData = useMemo(() => {
    const counts = expenses.reduce((acc, curr) => {
      acc[curr.category] = (acc[curr.category] || 0) + curr.amount;
      return acc;
    }, {});

    return Object.keys(counts).map((cat) => ({
      name: cat,
      value: counts[cat],
      color: CATEGORY_COLORS[cat] || CATEGORY_COLORS['Others']
    }));
  }, [expenses]);

  return (
    <div className="bg-white p-6 rounded-xl shadow-sm border border-slate-200 flex flex-col justify-between">
      <h2 className="text-lg font-bold text-slate-800 mb-2">Category Breakdown</h2>

      {categoryChartData.length > 0 ? (
        <div className="h-64 w-full">
          <ResponsiveContainer width="100%" height="100%">
            <PieChart>
              <Pie
                data={categoryChartData}
                cx="50%"
                cy="50%"
                innerRadius={65}
                outerRadius={90}
                paddingAngle={4}
                dataKey="value"
              >
                {categoryChartData.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={entry.color} />
                ))}
              </Pie>
              <Tooltip formatter={(val) => formatCurrency(val)} />
            </PieChart>
          </ResponsiveContainer>
        </div>
      ) : (
        <div className="h-64 flex items-center justify-center text-slate-400 text-sm">
          No data available
        </div>
      )}

      {/* Custom Legend */}
      <div className="grid grid-cols-2 sm:grid-cols-3 gap-2 pt-4 border-t border-slate-100">
        {categoryChartData.map((item) => (
          <div key={item.name} className="flex items-center gap-2">
            <span className="w-3 h-3 rounded-full flex-shrink-0" style={{ backgroundColor: item.color }} />
            <span className="text-xs text-slate-600 truncate">{item.name}</span>
            <span className="text-xs font-semibold text-slate-800 ml-auto">{formatCurrency(item.value)}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
