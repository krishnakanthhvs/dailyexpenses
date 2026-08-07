import React, { useState, useEffect } from 'react';
import { Users, UserPlus, Trash2, Loader2 } from 'lucide-react';

export default function FamilyManager() {
  const [members, setMembers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [name, setName] = useState('');
  const [relationship, setRelationship] = useState('Spouse');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const fetchMembers = async () => {
    try {
      setLoading(true);
      const res = await fetch('/api/family');
      if (res.ok) {
        const data = await res.json();
        setMembers(data);
      }
    } catch (err) {
      console.error('Error fetching family members:', err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchMembers();
  }, []);

  const handleAddMember = async (e) => {
    e.preventDefault();
    if (!name.trim()) return;

    try {
      setIsSubmitting(true);
      const res = await fetch('/api/family', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name, relationship }),
      });

      if (res.ok) {
        setName('');
        setRelationship('Spouse');
        fetchMembers();
      }
    } catch (err) {
      alert('Failed to add family member.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm('Remove this family member?')) return;
    try {
      const res = await fetch(`/api/family/${id}`, { method: 'DELETE' });
      if (res.ok) fetchMembers();
    } catch (err) {
      alert('Failed to delete member.');
    }
  };

  return (
    <div className="bg-white rounded-2xl border border-slate-200 p-5 max-w-md w-full space-y-4">
      <div className="flex items-center gap-2">
        <Users className="w-5 h-5 text-indigo-600" />
        <h3 className="font-bold text-slate-900 text-sm">Family Members</h3>
      </div>

      <form onSubmit={handleAddMember} className="flex gap-2">
        <input
          type="text"
          placeholder="Member Name (e.g. Wife, Son)"
          value={name}
          onChange={(e) => setName(e.target.value)}
          className="flex-1 px-3 py-1.5 border border-slate-300 rounded-lg text-xs focus:ring-2 focus:ring-indigo-500 outline-none"
          required
        />
        <select
          value={relationship}
          onChange={(e) => setRelationship(e.target.value)}
          className="px-2 py-1.5 border border-slate-300 rounded-lg text-xs bg-white focus:ring-2 focus:ring-indigo-500 outline-none"
        >
          <option value="Self">Self</option>
          <option value="Spouse">Spouse</option>
          <option value="Child">Child</option>
          <option value="Parent">Parent</option>
          <option value="Sibling">Sibling</option>
          <option value="Other">Other</option>
        </select>
        <button
          type="submit"
          disabled={isSubmitting}
          className="px-3 py-1.5 bg-indigo-600 hover:bg-indigo-700 text-white rounded-lg text-xs font-semibold flex items-center gap-1"
        >
          {isSubmitting ? <Loader2 className="w-3.5 h-3.5 animate-spin" /> : <UserPlus className="w-3.5 h-3.5" />}
          Add
        </button>
      </form>

      {loading ? (
        <Loader2 className="w-5 h-5 animate-spin text-indigo-600 mx-auto" />
      ) : (
        <div className="space-y-2">
          {members.map((member) => (
            <div key={member.id} className="flex items-center justify-between p-2 bg-slate-50 rounded-lg text-xs">
              <div>
                <span className="font-semibold text-slate-800">{member.name}</span>
                <span className="ml-2 text-slate-400">({member.relationship})</span>
              </div>
              <button onClick={() => handleDelete(member.id)} className="text-slate-400 hover:text-rose-600">
                <Trash2 className="w-3.5 h-3.5" />
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}