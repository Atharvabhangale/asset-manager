import React from 'react';

export default function DateRangePicker({ startDate, endDate, onChange }) {
  return (
    <div className="flex space-x-2">
      <div>
        <label className="block text-xs text-gray-500 mb-1">From</label>
        <input
          type="date"
          className="border rounded p-2"
          value={startDate}
          onChange={e => onChange({ startDate: e.target.value, endDate })}
        />
      </div>
      <div>
        <label className="block text-xs text-gray-500 mb-1">To</label>
        <input
          type="date"
          className="border rounded p-2"
          value={endDate}
          onChange={e => onChange({ startDate, endDate: e.target.value })}
        />
      </div>
    </div>
  );
}
