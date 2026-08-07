import React, { useState, useMemo, useEffect } from 'react';
import { 
  CreditCard, 
  Plus, 
  Trash2, 
  Calendar, 
  AlertCircle, 
  CheckCircle2, 
  Building2,
  DollarSign,
  ShieldCheck
} from 'lucide-react';

// Indian Rupee Formatter
const formatINR = (amount) => {
  if (amount === undefined || amount === null || isNaN(amount)) return '₹0';
  return new Intl.NumberFormat('en-IN', {
    style: 'currency',
    currency: 'INR',
    maximumFractionDigits: 0
  }).format(amount);
};

// Comma Formatter for Inputs
const formatNumberWithCommas = (val) => {
  if (!val) return '';
  const rawValue = val.toString().replace(/\D/g, '');
  if (!rawValue) return '';
  return new Intl.NumberFormat('en-IN').format(parseInt(rawValue, 10));
};

export default function Cards() {
  // Saved Credit Cards State
  const [cards, setCards] = useState(() => {
    const saved = localStorage.getItem('app_credit_cards');
    if (saved) return JSON.parse(saved);

    return [
      {
        id: '1',
        cardName: 'HDFC Regalia Gold',
        bankName: 'HDFC Bank',
        last4Digits: '4821',
        cardType: 'Visa',
        creditLimit: 300000,
        currentOutstanding: 45000,
        billingCycleDay: 15,
        dueDateDay: 5,
        cardColor: 'from-slate-900 to-indigo-950',
      },
      {
        id: '2',
        cardName: 'ICICI Amazon Pay',
        bankName: 'ICICI Bank',
        last4Digits: '9012',
        cardType: 'MasterCard',
        creditLimit: 200000,
        currentOutstanding: 18500,
        billingCycleDay: 20,
        dueDateDay: 10,
        cardColor: 'from-blue-900 to-slate-900',
      }
    ];
  });

  // Modal & Form State
  const [showAddModal, setShowAddModal] = useState(false);
  const [formData, setFormData] = useState({
    cardName: '',
    bankName: '',
    last4Digits: '',
    cardType: 'Visa',
    creditLimit: '',
    currentOutstanding: '',
    billingCycleDay: '15',
    dueDateDay: '5',
    cardColor: 'from-slate-900 to-indigo-950'
  });

  // Sync with LocalStorage
  useEffect(() => {
    localStorage.setItem('app_credit_cards', JSON.stringify(cards));
  }, [cards]);

  // Handle Form Inputs
  const handleChange = (e) => {
    const { name, value } = e.target;
    if (name === 'creditLimit' || name === 'currentOutstanding') {
      setFormData((prev) => ({ ...prev, [name]: formatNumberWithCommas(value) }));
    } else {
      setFormData((prev) => ({ ...prev, [name]: value }));
    }
  };

  // Add Card
  const handleAddCard = (e) => {
    e.preventDefault();
    if (!formData.cardName || !formData.creditLimit) return;

    const rawLimit = parseFloat(String(formData.creditLimit).replace(/,/g, '')) || 0;
    const rawOutstanding = parseFloat(String(formData.currentOutstanding).replace(/,/g, '')) || 0;

    const newCard = {
      id: Date.now().toString(),
      cardName: formData.cardName,
      bankName: formData.bankName || 'Bank',
      last4Digits: formData.last4Digits || '0000',
      cardType: formData.cardType,
      creditLimit: rawLimit,
      currentOutstanding: rawOutstanding,
      billingCycleDay: parseInt(formData.billingCycleDay),
      dueDateDay: parseInt(formData.dueDateDay),
      cardColor: formData.cardColor,
    };

    setCards([...cards, newCard]);
    setShowAddModal(false);
    setFormData({
      cardName: '',
      bankName: '',
      last4Digits: '',
      cardType: 'Visa',
      creditLimit: '',
      currentOutstanding: '',
      billingCycleDay: '15',
      dueDateDay: '5',
      cardColor: 'from-slate-900 to-indigo-950'
    });
  };

  const handleDeleteCard = (id) => {
    setCards(cards.filter(c => c.id !== id));
  };

  // Total Portfolio Metrics
  const summary = useMemo(() => {
    const totalLimit = cards.reduce((sum, c) => sum + c.creditLimit, 0);
    const totalOutstanding = cards.reduce((sum, c) => sum + c.currentOutstanding, 0);
    const availableCredit = totalLimit - totalOutstanding;
    const totalUtilization = totalLimit > 0 ? Math.round((totalOutstanding / totalLimit) * 100) : 0;

    return { totalLimit, totalOutstanding, availableCredit, totalUtilization };
  }, [cards]);

  return (
    <div className="space-y-8">
      
      {/* Header Banner */}
      <div className="bg-slate-900 text-white rounded-2xl p-6 sm:p-8 shadow-sm flex flex-col md:flex-row justify-between items-start md:items-center gap-6">
        <div>
          <span className="px-2.5 py-1 rounded-full bg-indigo-500/20 text-indigo-300 text-xs font-semibold uppercase tracking-wider">
            Card Portfolio
          </span>
          <h2 className="text-2xl font-bold mt-2">Credit Cards & Limits Management</h2>
          <p className="text-slate-400 text-sm mt-1">
            Track total limits, outstanding bills, statement dates, and credit utilization ratios.
          </p>
        </div>

        <button
          onClick={() => setShowAddModal(true)}
          className="bg-indigo-600 hover:bg-indigo-700 text-white px-5 py-3 rounded-xl font-semibold text-sm flex items-center gap-2 shadow-lg shadow-indigo-600/20 transition-all flex-shrink-0"
        >
          <Plus className="w-5 h-5" />
          Add Credit Card
        </button>
      </div>

      {/* Summary KPI Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5">
        
        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Credit Limit</p>
          <h3 className="text-2xl font-extrabold text-slate-900 mt-1">{formatINR(summary.totalLimit)}</h3>
          <p className="text-xs text-slate-400 mt-1">Across {cards.length} cards</p>
        </div>

        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Total Outstanding Due</p>
          <h3 className="text-2xl font-extrabold text-amber-600 mt-1">{formatINR(summary.totalOutstanding)}</h3>
          <p className="text-xs text-slate-400 mt-1">Current billable amount</p>
        </div>

        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Available Credit</p>
          <h3 className="text-2xl font-extrabold text-emerald-600 mt-1">{formatINR(summary.availableCredit)}</h3>
          <p className="text-xs text-slate-400 mt-1">Ready to use</p>
        </div>

        <div className="bg-white p-5 rounded-xl border border-slate-200 shadow-sm">
          <p className="text-xs font-semibold text-slate-500 uppercase tracking-wider">Credit Utilization</p>
          <h3 className={`text-2xl font-extrabold mt-1 ${summary.totalUtilization > 30 ? 'text-red-500' : 'text-indigo-600'}`}>
            {summary.totalUtilization}%
          </h3>
          <p className="text-xs text-slate-400 mt-1">{summary.totalUtilization > 30 ? 'High (>30% impacts score)' : 'Healthy (<30%)'}</p>
        </div>

      </div>

      {/* Cards Display Grid */}
      <div className="space-y-4">
        <h3 className="text-lg font-bold text-slate-800">Your Credit Cards</h3>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {cards.map((card) => {
            const available = card.creditLimit - card.currentOutstanding;
            const utilizationPercent = Math.min(Math.round((card.currentOutstanding / card.creditLimit) * 100), 100);

            return (
              <div 
                key={card.id} 
                className="bg-white rounded-2xl border border-slate-200 shadow-sm p-6 flex flex-col justify-between space-y-5"
              >
                {/* Visual Credit Card Canvas */}
                <div className={`bg-gradient-to-r ${card.cardColor} text-white rounded-2xl p-6 shadow-md relative overflow-hidden flex flex-col justify-between h-48`}>
                  <div className="flex items-start justify-between relative z-10">
                    <div>
                      <p className="text-xs font-medium text-slate-300 uppercase tracking-widest">{card.bankName}</p>
                      <h4 className="text-lg font-bold tracking-wide mt-0.5">{card.cardName}</h4>
                    </div>
                    <span className="font-extrabold italic text-sm tracking-wider uppercase bg-white/10 px-2.5 py-1 rounded-md border border-white/10">
                      {card.cardType}
                    </span>
                  </div>

                  <div className="relative z-10">
                    <p className="text-xs text-slate-400 tracking-wider">CARD NUMBER</p>
                    <p className="text-xl font-mono tracking-widest mt-0.5">•••• •••• •••• {card.last4Digits}</p>
                  </div>

                  <div className="flex justify-between items-end relative z-10 text-xs">
                    <div>
                      <p className="text-[10px] text-slate-400 uppercase">Outstanding</p>
                      <p className="font-bold text-amber-300 text-base">{formatINR(card.currentOutstanding)}</p>
                    </div>
                    <div className="text-right">
                      <p className="text-[10px] text-slate-400 uppercase">Limit</p>
                      <p className="font-bold text-white text-base">{formatINR(card.creditLimit)}</p>
                    </div>
                  </div>
                </div>

                {/* Billing Details & Utilization */}
                <div className="space-y-3">
                  <div className="grid grid-cols-2 gap-2 text-xs bg-slate-50 p-3 rounded-xl border border-slate-100">
                    <div>
                      <span className="text-slate-400 block">Statement Date:</span>
                      <strong className="text-slate-800 font-semibold">{card.billingCycleDay}th of every month</strong>
                    </div>
                    <div>
                      <span className="text-slate-400 block">Payment Due Date:</span>
                      <strong className="text-indigo-600 font-semibold">{card.dueDateDay}th of every month</strong>
                    </div>
                  </div>

                  <div className="space-y-1">
                    <div className="flex justify-between text-xs text-slate-600">
                      <span>Card Utilization</span>
                      <span className="font-bold">{utilizationPercent}%</span>
                    </div>
                    <div className="w-full bg-slate-100 h-2 rounded-full overflow-hidden">
                      <div 
                        className={`h-full transition-all duration-300 ${utilizationPercent > 30 ? 'bg-amber-500' : 'bg-indigo-600'}`}
                        style={{ width: `${utilizationPercent}%` }}
                      />
                    </div>
                  </div>
                </div>

                {/* Footer Action */}
                <div className="pt-3 border-t border-slate-100 flex items-center justify-between text-xs">
                  <span className="text-emerald-600 font-semibold">
                    Available Credit: {formatINR(available)}
                  </span>
                  <button
                    onClick={() => handleDeleteCard(card.id)}
                    className="text-slate-400 hover:text-red-600 p-1.5 rounded-lg transition-colors flex items-center gap-1"
                  >
                    <Trash2 className="w-4 h-4" /> Delete
                  </button>
                </div>
              </div>
            );
          })}
        </div>
      </div>

      {/* Add Card Modal */}
      {showAddModal && (
        <div className="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-2xl max-w-lg w-full p-6 sm:p-8 shadow-2xl border border-slate-200">
            <h3 className="text-xl font-bold text-slate-900 mb-1">Add New Credit Card</h3>
            <p className="text-xs text-slate-500 mb-6">Enter card details to track limits and statement due dates.</p>

            <form onSubmit={handleAddCard} className="space-y-4">
              
              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Card Name *</label>
                <input
                  type="text"
                  name="cardName"
                  placeholder="e.g. HDFC Regalia Gold, SBI SimplyClick"
                  value={formData.cardName}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  required
                />
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Bank Name *</label>
                  <input
                    type="text"
                    name="bankName"
                    placeholder="e.g. HDFC Bank, ICICI"
                    value={formData.bankName}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                    required
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Last 4 Digits</label>
                  <input
                    type="text"
                    maxLength="4"
                    name="last4Digits"
                    placeholder="4821"
                    value={formData.last4Digits}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Credit Limit (₹) *</label>
                  <input
                    type="text"
                    name="creditLimit"
                    placeholder="2,00,000"
                    value={formData.creditLimit}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                    required
                  />
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Current Outstanding Due (₹)</label>
                  <input
                    type="text"
                    name="currentOutstanding"
                    placeholder="25,000"
                    value={formData.currentOutstanding}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 focus:outline-none"
                  />
                </div>
              </div>

              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Statement Date</label>
                  <select
                    name="billingCycleDay"
                    value={formData.billingCycleDay}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 bg-white"
                  >
                    {Array.from({ length: 31 }, (_, i) => i + 1).map((day) => (
                      <option key={day} value={day}>{day}th of month</option>
                    ))}
                  </select>
                </div>
                <div>
                  <label className="block text-xs font-semibold text-slate-700 mb-1">Payment Due Date</label>
                  <select
                    name="dueDateDay"
                    value={formData.dueDateDay}
                    onChange={handleChange}
                    className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 bg-white"
                  >
                    {Array.from({ length: 31 }, (_, i) => i + 1).map((day) => (
                      <option key={day} value={day}>{day}th of month</option>
                    ))}
                  </select>
                </div>
              </div>

              <div>
                <label className="block text-xs font-semibold text-slate-700 mb-1">Card Theme</label>
                <select
                  name="cardColor"
                  value={formData.cardColor}
                  onChange={handleChange}
                  className="w-full px-3 py-2 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 bg-white"
                >
                  <option value="from-slate-900 to-indigo-950">Midnight Indigo</option>
                  <option value="from-blue-900 to-slate-900">Deep Ocean Blue</option>
                  <option value="from-purple-900 to-slate-900">Royal Purple</option>
                  <option value="from-emerald-900 to-slate-900">Emerald Dark</option>
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
                  className="px-5 py-2 text-xs font-semibold text-white bg-indigo-600 hover:bg-indigo-700 rounded-lg shadow-sm transition-colors"
                >
                  Save Credit Card
                </button>
              </div>

            </form>
          </div>
        </div>
      )}

    </div>
  );
}
