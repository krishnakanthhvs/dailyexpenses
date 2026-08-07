import React, { useState, useMemo } from 'react';
import { 
  Search, 
  Trash2, 
  Plus, 
  ArrowUpRight, 
  ArrowDownLeft, 
  Calendar as CalendarIcon, 
  Filter,
  TrendingUp,
  TrendingDown,
  Wallet,
  Loader2,
  Building2
} from 'lucide-react';
import { useExpenses } from '../../context/ExpenseContext';
import { CATEGORY_COLORS, DEFAULT_CATEGORIES } from '../../utils/constants';
import { formatCurrency } from '../../utils/formatters';

const POPULAR_BANKS = [
  'HDFC Bank',
  'ICICI Bank',
  'State Bank of India (SBI)',
  'Axis Bank',
  'Kotak Mahindra Bank',
  'Jupiter Money',
  'Paytm Payments Bank',
  'IndusInd Bank',
  'Federal Bank',
  'Other'
];

export default function TransactionTable() {
  const { expenses, loading, addExpense, deleteExpense } = useExpenses();

  // Search & Filter States
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('All');
  const [transactionType, setTransactionType] = useState('All');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');

  // Add Transaction Modal State
  const [showAddModal, setShowAddModal] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [newTx, setNewTx] = useState({
    note: '',
    amount: '',
    category: DEFAULT_CATEGORIES[0] || 'Food',
    type: 'Debit',
    paymentMethod: 'UPI',
    bankName: 'HDFC Bank',
    date: new Date().toISOString().split('T')[0],
  });

  // Handle Add Transaction Submit to DB
  const handleAddSubmit = async (e) => {
    e.preventDefault();
    if (!newTx.note || !newTx.amount) return;

    setIsSubmitting(true);
    await addExpense({
      ...newTx,
      amount: parseFloat(newTx.amount),
    });
    setIsSubmitting(false);

    setShowAddModal(false);
    setNewTx({
      note: '',
      amount: '',
      category: DEFAULT_CATEGORIES[0] || 'Food',
      type: 'Debit',
      paymentMethod: 'UPI',
      bankName: 'HDFC Bank',
      date: new Date().toISOString().split('T')[0],
    });
  };

  // Filter Logic
  const filteredExpenses = useMemo(() => {
    return expenses.filter((exp) => {
      const matchesSearch =
        exp.note.toLowerCase().includes(searchQuery.toLowerCase()) ||
        exp.category.toLowerCase().includes(searchQuery.toLowerCase()) ||
        (exp.paymentMethod && exp.paymentMethod.toLowerCase().includes(searchQuery.toLowerCase())) ||
        (exp.bankName && exp.bankName.toLowerCase().includes(searchQuery.toLowerCase()));

      const matchesCat = selectedCategory === 'All' || exp.category === selectedCategory;

      const matchesType =
        transactionType === 'All' ||
        (transactionType === 'Debit' && exp.type !== 'Credit') ||
        (transactionType === 'Credit' && exp.type === 'Credit');

      const expDate = new Date(exp.date);
      const matchesStart = !startDate || expDate >= new Date(startDate);
      const matchesEnd = !endDate || expDate <= new Date(endDate);

      return matchesSearch && matchesCat && matchesType && matchesStart && matchesEnd;
    });
  }, [expenses, searchQuery, selectedCategory, transactionType, startDate, endDate]);

  // Utility helper function
  const formatDate = (dateString) => {
    if (!dateString) return '';
    
    // Extract just the YYYY-MM-DD part if it's an ISO string to avoid UTC shift
    const cleanDateStr = dateString.includes('T') ? dateString.split('T')[0] : dateString;
    const [year, month, day] = cleanDateStr.split('-');

    // Create date object using local year, month (0-indexed), and day
    const dateObj = new Date(year, month - 1, day);

    return dateObj.toLocaleDateString('en-GB', {
      day: 'numeric',
      month: 'short',
      year: 'numeric'
    }); // Output: "6 Aug 2026"
  };

  // KPI Metrics Calculations
  const metrics = useMemo(() => {
    let totalDebit = 0;
    let totalCredit = 0;

    filteredExpenses.forEach((exp) => {
      const amt = Number(exp.amount) || 0;
      if (exp.type === 'Credit') {
        totalCredit += amt;
      } else {
        totalDebit += amt;
      }
    });

    return {
      totalCredit,
      totalDebit,
      netFlow: totalCredit - totalDebit,
      count: filteredExpenses.length,
    };
  }, [filteredExpenses]);

  return (
    <div className="space-y-6">

      {/* KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Debits (Spent)</p>
            <h3 className="text-2xl font-extrabold text-red-600 mt-1">{formatCurrency(metrics.totalDebit)}</h3>
            <p className="text-xs text-slate-400 mt-1">Total expenses filtered</p>
          </div>
          <div className="p-3 bg-red-50 text-red-600 rounded-xl">
            <TrendingDown className="w-6 h-6" />
          </div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Credits (Income)</p>
            <h3 className="text-2xl font-extrabold text-emerald-600 mt-1">{formatCurrency(metrics.totalCredit)}</h3>
            <p className="text-xs text-slate-400 mt-1">Total inflows filtered</p>
          </div>
          <div className="p-3 bg-emerald-50 text-emerald-600 rounded-xl">
            <TrendingUp className="w-6 h-6" />
          </div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Net Balance Flow</p>
            <h3 className={`text-2xl font-extrabold mt-1 ${metrics.netFlow >= 0 ? 'text-emerald-600' : 'text-red-600'}`}>
              {formatCurrency(metrics.netFlow)}
            </h3>
            <p className="text-xs text-slate-400 mt-1">Inflow vs Outflow</p>
          </div>
          <div className="p-3 bg-indigo-50 text-indigo-600 rounded-xl">
            <Wallet className="w-6 h-6" />
          </div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm flex items-center justify-between">
          <div>
            <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Records</p>
            <h3 className="text-2xl font-extrabold text-slate-900 mt-1">{metrics.count}</h3>
            <p className="text-xs text-slate-400 mt-1">Matching transactions</p>
          </div>
          <div className="p-3 bg-slate-100 text-slate-600 rounded-xl">
            <Filter className="w-6 h-6" />
          </div>
        </div>
      </div>

      {/* Main Table Container */}
      <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        <div className="p-5 border-b border-slate-200 flex flex-col lg:flex-row lg:items-center justify-between gap-4">
          <div className="flex items-center justify-between w-full lg:w-auto">
            <h2 className="text-lg font-bold text-slate-800">Transaction History</h2>
            <button
              onClick={() => setShowAddModal(true)}
              className="lg:hidden bg-indigo-600 hover:bg-indigo-700 text-white px-3.5 py-1.5 rounded-lg font-semibold text-xs flex items-center gap-1.5 transition-colors"
            >
              <Plus className="w-4 h-4" /> Add
            </button>
          </div>

          <div className="flex flex-wrap items-center gap-3">
            <div className="relative flex-1 sm:flex-none">
              <Search className="w-4 h-4 absolute left-3 top-2.5 text-slate-400" />
              <input
                type="text"
                placeholder="Search notes, category, bank..."
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
                className="w-full sm:w-56 pl-9 pr-3 py-1.5 text-xs border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
              />
            </div>

            <select
              value={transactionType}
              onChange={(e) => setTransactionType(e.target.value)}
              className="py-1.5 px-3 text-xs border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white font-medium text-slate-700"
            >
              <option value="All">All Types (Debit & Credit)</option>
              <option value="Debit">Debit (Expenses Only)</option>
              <option value="Credit">Credit (Income Only)</option>
            </select>

            <select
              value={selectedCategory}
              onChange={(e) => setSelectedCategory(e.target.value)}
              className="py-1.5 px-3 text-xs border border-slate-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 bg-white text-slate-700"
            >
              <option value="All">All Categories</option>
              {DEFAULT_CATEGORIES.map((cat) => (
                <option key={cat} value={cat}>{cat}</option>
              ))}
            </select>

            <div className="flex items-center gap-1.5 bg-slate-50 p-1 border border-slate-200 rounded-lg">
              <CalendarIcon className="w-3.5 h-3.5 text-slate-400 ml-1.5" />
              <input
                type="date"
                value={startDate}
                onChange={(e) => setStartDate(e.target.value)}
                className="bg-transparent text-[11px] text-slate-600 focus:outline-none"
              />
              <span className="text-slate-300 text-xs">-</span>
              <input
                type="date"
                value={endDate}
                onChange={(e) => setEndDate(e.target.value)}
                className="bg-transparent text-[11px] text-slate-600 focus:outline-none"
              />
            </div>

            <button
              onClick={() => setShowAddModal(true)}
              className="hidden lg:flex bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-1.5 rounded-lg font-semibold text-xs items-center gap-1.5 shadow-sm transition-all"
            >
              <Plus className="w-4 h-4" /> Add Transaction
            </button>
          </div>
        </div>

        {/* Table View */}
        <div className="overflow-x-auto">
          <table className="w-full text-left text-xs text-slate-600">
            <thead className="bg-slate-50 text-slate-700 font-semibold uppercase tracking-wider border-b border-slate-200">
              <tr>
                <th className="px-6 py-3.5">Type</th>
                <th className="px-6 py-3.5">Description</th>
                <th className="px-6 py-3.5">Category</th>
                <th className="px-6 py-3.5">Method & Bank</th>
                <th className="px-6 py-3.5">Date</th>
                <th className="px-6 py-3.5 text-right">Amount</th>
                <th className="px-6 py-3.5 text-center">Action</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100">
              {loading ? (
                <tr>
                  <td colSpan="7" className="px-6 py-12 text-center text-slate-400">
                    <div className="flex items-center justify-center gap-2">
                      <Loader2 className="w-5 h-5 animate-spin text-indigo-600" />
                      Loading transactions from database...
                    </div>
                  </td>
                </tr>
              ) : filteredExpenses.length > 0 ? (
                filteredExpenses.map((exp) => {
                  const isCredit = exp.type === 'Credit';

                  return (
                    <tr key={exp.id} className="hover:bg-slate-50/80 transition-colors">
                      <td className="px-6 py-4">
                        <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-[10px] font-bold ${
                          isCredit 
                            ? 'bg-emerald-100 text-emerald-800' 
                            : 'bg-red-100 text-red-800'
                        }`}>
                          {isCredit ? (
                            <><ArrowDownLeft className="w-3 h-3" /> Credit</>
                          ) : (
                            <><ArrowUpRight className="w-3 h-3" /> Debit</>
                          )}
                        </span>
                      </td>

                      <td className="px-6 py-4 font-semibold text-slate-900">{exp.note}</td>
                      
                      <td className="px-6 py-4">
                        <span
                          className="px-2.5 py-1 rounded-full text-[11px] font-medium"
                          style={{
                            backgroundColor: `${CATEGORY_COLORS[exp.category] || '#6B7280'}15`,
                            color: CATEGORY_COLORS[exp.category] || '#6B7280'
                          }}
                        >
                          {exp.category}
                        </span>
                      </td>

                      <td className="px-6 py-4 text-slate-600">
                        <div className="font-semibold text-slate-800">{exp.paymentMethod || 'UPI'}</div>
                        <div className="text-[10px] text-slate-400 flex items-center gap-1">
                          <Building2 className="w-3 h-3" /> {exp.bankName || 'Default Bank'}
                        </div>
                      </td>

                      <td className="px-6 py-4 text-slate-500">{formatDate(exp.date || exp.transaction_date)}</td>
                      
                      <td className={`px-6 py-4 text-right font-bold text-sm ${isCredit ? 'text-emerald-600' : 'text-slate-900'}`}>
                        {isCredit ? `+ ${formatCurrency(exp.amount)}` : `- ${formatCurrency(exp.amount)}`}
                      </td>

                      <td className="px-6 py-4 text-center">
                        <button
                          onClick={() => deleteExpense(exp.id)}
                          className="p-1.5 text-slate-400 hover:text-red-600 hover:bg-red-50 rounded-md transition-colors"
                          title="Delete transaction"
                        >
                          <Trash2 className="w-4 h-4" />
                        </button>
                      </td>
                    </tr>
                  );
                })
              ) : (
                <tr>
                  <td colSpan="7" className="px-6 py-12 text-center text-slate-400">
                    No transactions found in the database.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>

      {/* Modal: Add Transaction */}
      {showAddModal && (
        <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl max-w-md w-full p-6 sm:p-8 shadow-2xl border border-slate-200">
            <h3 className="text-xl font-bold text-slate-900 mb-1">Add New Transaction</h3>
            <p className="text-xs text-slate-500 mb-6">Log an income or expense transaction into your database.</p>

            <form onSubmit={handleAddSubmit} className="space-y-4">
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Transaction Type *</label>
                <div className="grid grid-cols-2 gap-2">
                  <button
                    type="button"
                    onClick={() => setNewTx({ ...newTx, type: 'Debit' })}
                    className={`py-2 rounded-lg text-xs font-bold transition-all flex items-center justify-center gap-1.5 ${
                      newTx.type === 'Debit'
                        ? 'bg-red-600 text-white shadow-md shadow-red-600/20'
                        : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                    }`}
                  >
                    <ArrowUpRight className="w-4 h-4" /> Debit (Expense)
                  </button>
                  <button
                    type="button"
                    onClick={() => setNewTx({ ...newTx, type: 'Credit' })}
                    className={`py-2 rounded-lg text-xs font-bold transition-all flex items-center justify-center gap-1.5 ${
                      newTx.type === 'Credit'
                        ? 'bg-emerald-600 text-white shadow-md shadow-emerald-600/20'
                        : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                    }`}
                  >
                    <ArrowDownLeft className="w-4 h-4" /> Credit (Income)
                  </button>
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Description / Note *</label>
                <input
                  type="text"
                  placeholder="e.g. Swiggy food, Monthly Salary, Grocery"
                  value={newTx.note}
                  onChange={(e) => setNewTx({ ...newTx, note: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  required
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Amount (₹) *</label>
                  <input
                    type="number"
                    placeholder="450"
                    value={newTx.amount}
                    onChange={(e) => setNewTx({ ...newTx, amount: e.target.value })}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none font-bold"
                    required
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Date *</label>
                  <input
                    type="date"
                    value={newTx.date}
                    onChange={(e) => setNewTx({ ...newTx, date: e.target.value })}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none bg-white"
                    required
                  />
                </div>
              </div>

              {/* Payment Method & Bank Name */}
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Payment Method</label>
                  <select
                    value={newTx.paymentMethod}
                    onChange={(e) => setNewTx({ ...newTx, paymentMethod: e.target.value })}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 bg-white"
                  >
                    <option value="UPI">UPI / Google Pay</option>
                    <option value="Credit Card">Credit Card</option>
                    <option value="Debit Card">Debit Card</option>
                    <option value="Net Banking">Net Banking</option>
                    <option value="Cash">Cash</option>
                  </select>
                </div>

                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Bank Name *</label>
                  <select
                    value={newTx.bankName}
                    onChange={(e) => setNewTx({ ...newTx, bankName: e.target.value })}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 bg-white"
                  >
                    {POPULAR_BANKS.map((bank) => (
                      <option key={bank} value={bank}>{bank}</option>
                    ))}
                  </select>
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Category</label>
                <select
                  value={newTx.category}
                  onChange={(e) => setNewTx({ ...newTx, category: e.target.value })}
                  className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 bg-white"
                >
                  {DEFAULT_CATEGORIES.map((cat) => (
                    <option key={cat} value={cat}>{cat}</option>
                  ))}
                </select>
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
                  {isSubmitting ? 'Saving...' : 'Save Transaction'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

    </div>
  );
}
