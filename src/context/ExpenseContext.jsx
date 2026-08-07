import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';

const ExpenseContext = createContext();

export const ExpenseProvider = ({ children }) => {
  const [expenses, setExpenses] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Helper to extract Auth Header
  const getAuthHeaders = () => {
    try {
      const storedUser = localStorage.getItem('auth_user');
      const user = storedUser ? JSON.parse(storedUser) : {};
      const token = user.token || '';

      return {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`,
      };
    } catch (e) {
      return { 'Content-Type': 'application/json' };
    }
  };

  // 1. FETCH FROM POSTGRESQL (API)
  const fetchExpenses = useCallback(async () => {
    setLoading(true);
    try {
      const response = await fetch('/api/transactions', {
        headers: getAuthHeaders(),
      });

      if (!response.ok) throw new Error(`HTTP ${response.status}`);

      const data = await response.json();
      setExpenses(Array.isArray(data) ? data : []);
      setError(null);
    } catch (err) {
      console.error('Failed to fetch from DB:', err.message);
      setError(err.message);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchExpenses();
  }, [fetchExpenses]);

  // 2. SAVE TO POSTGRESQL (API)
  const addExpense = async (newTx) => {
    try {
      const storedUser = localStorage.getItem('auth_user');
      const user = storedUser ? JSON.parse(storedUser) : {};
      const token = user.token || 'mock-jwt-token-xyz';

      const response = await fetch('/api/transactions', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
        body: JSON.stringify(newTx),
      });

      if (!response.ok) {
        const errData = await response.json().catch(() => ({}));
        throw new Error(errData.error || `Server Error ${response.status}`);
      }

      const savedTx = await response.json();
      setExpenses((prev) => [savedTx, ...prev]);

      return { success: true };
    } catch (err) {
      console.error('DB Insert Error:', err.message);
      alert(`Error saving to DB: ${err.message}`);
      return { success: false, error: err.message };
    }
};

  // 3. DELETE FROM POSTGRESQL (API)
  const deleteExpense = async (id) => {
    try {
      const response = await fetch(`/api/transactions/${id}`, {
        method: 'DELETE',
        headers: getAuthHeaders(),
      });

      if (!response.ok) throw new Error(`Delete failed (${response.status})`);

      setExpenses((prev) => prev.filter((exp) => exp.id !== id));
    } catch (err) {
      console.error('DB Delete Error:', err.message);
      alert(`Error deleting from DB: ${err.message}`);
    }
  };

  return (
    <ExpenseContext.Provider
      value={{
        expenses,
        loading,
        error,
        fetchExpenses,
        addExpense,
        deleteExpense,
        monthlyBudget: 50000,
      }}
    >
      {children}
    </ExpenseContext.Provider>
  );
};

export const useExpenses = () => useContext(ExpenseContext);