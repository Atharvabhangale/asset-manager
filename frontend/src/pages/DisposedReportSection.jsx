import React, { useState, useEffect } from 'react';
import { FiFileText, FiDownload } from 'react-icons/fi';
import { useDisposed } from '../hooks/useDisposed';

const DisposedReportSection = () => {
  const { disposedAssets, loading, error, fetchDisposed } = useDisposed();
  const [showPreview, setShowPreview] = useState(false);

  // fetch disposed once on mount
  useEffect(() => {
    fetchDisposed();
  }, [fetchDisposed]);

  const [filters, setFilters] = useState({
    id: '',
    type: '',
    make: '',
    model: '',
    serial: '',
    location: '',
    department: '',
    startDate: '',
    endDate: '',
  });

  // unique dropdown values
  const typeOptions = Array.from(new Set(disposedAssets.map(a => a.asset_type_name || a.asset_types?.asset_type_name).filter(Boolean)));
  const locationOptions = Array.from(new Set(disposedAssets.map(a => a.location_name || a.locations?.location_name).filter(Boolean)));
  const departmentOptions = Array.from(new Set(disposedAssets.map(a => a.department_name || a.departments?.department_name).filter(Boolean)));

  const filtered = disposedAssets.filter(a => {
    let ok = true;
    if (filters.id) ok = ok && String(a.asset_id) === String(filters.id);
    if (filters.type) ok = ok && ((a.asset_type_name || a.asset_types?.asset_type_name) === filters.type);
    if (filters.make) ok = ok && a.make?.toLowerCase().includes(filters.make.toLowerCase());
    if (filters.model) ok = ok && a.model?.toLowerCase().includes(filters.model.toLowerCase());
    if (filters.serial) ok = ok && a.serial_number?.toLowerCase().includes(filters.serial.toLowerCase());
    if (filters.location) ok = ok && ((a.location_name || a.locations?.location_name) === filters.location);
    if (filters.department) ok = ok && ((a.department_name || a.departments?.department_name) === filters.department);
    if (filters.startDate) ok = ok && a.disposed_date && a.disposed_date >= filters.startDate;
    if (filters.endDate) ok = ok && a.disposed_date && a.disposed_date <= filters.endDate;
    return ok;
  });

  const reset = () => {
    setFilters({ id: '', type: '', make: '', model: '', serial: '', location: '', department: '', startDate: '', endDate: '' });
    setShowPreview(false);
  };

  const generateCSV = () => {
    if (filtered.length === 0) return;
    const headers = ['ID','Type','Make','Model','Serial Number','Disposed Date','Location','Department'];
    const rows = filtered.map(a => ({
      id: a.asset_id,
      type: a.asset_type_name || a.asset_types?.asset_type_name || 'N/A',
      make: a.make || 'N/A',
      model: a.model || 'N/A',
      serial: a.serial_number || 'N/A',
      date: a.disposed_date || 'N/A',
      location: a.location_name || a.locations?.location_name || 'N/A',
      department: a.department_name || a.departments?.department_name || 'N/A'
    }));

    const csv = [headers.join(','), ...rows.map(r => Object.values(r).map(v=>`"${String(v).replace(/"/g,'""')}"`).join(','))].join('\n');
    const blob = new Blob([csv],{type:'text/csv;charset=utf-8;'});
    const url = URL.createObjectURL(blob);
    const link=document.createElement('a');
    link.href=url;
    link.setAttribute('download','disposed_assets_report.csv');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="bg-white shadow rounded-lg p-6 space-y-6">
      <h2 className="text-xl font-semibold text-gray-800">Disposed Assets Report Filters</h2>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Asset ID</label>
          <input type="number" className="w-full p-2 border rounded-md" value={filters.id} onChange={e=>setFilters(f=>({...f,id:e.target.value}))}/>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Type</label>
          <select className="w-full p-2 border rounded-md" value={filters.type} onChange={e=>setFilters(f=>({...f,type:e.target.value}))}>
            <option value="">All</option>
            {typeOptions.map(t=>(<option key={t} value={t}>{t}</option>))}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Make</label>
          <input type="text" className="w-full p-2 border rounded-md" value={filters.make} onChange={e=>setFilters(f=>({...f,make:e.target.value}))}/>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Model</label>
          <input type="text" className="w-full p-2 border rounded-md" value={filters.model} onChange={e=>setFilters(f=>({...f,model:e.target.value}))}/>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Serial</label>
          <input type="text" className="w-full p-2 border rounded-md" value={filters.serial} onChange={e=>setFilters(f=>({...f,serial:e.target.value}))}/>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Location</label>
          <select className="w-full p-2 border rounded-md" value={filters.location} onChange={e=>setFilters(f=>({...f,location:e.target.value}))}>
            <option value="">All</option>
            {locationOptions.map(l=>(<option key={l} value={l}>{l}</option>))}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Department</label>
          <select className="w-full p-2 border rounded-md" value={filters.department} onChange={e=>setFilters(f=>({...f,department:e.target.value}))}>
            <option value="">All</option>
            {departmentOptions.map(d=>(<option key={d} value={d}>{d}</option>))}
          </select>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
          <input type="date" className="w-full p-2 border rounded-md" value={filters.startDate} onChange={e=>setFilters(f=>({...f,startDate:e.target.value}))}/>
        </div>
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">End Date</label>
          <input type="date" className="w-full p-2 border rounded-md" value={filters.endDate} onChange={e=>setFilters(f=>({...f,endDate:e.target.value}))}/>
        </div>
      </div>

      <div className="flex justify-end gap-3">
        <button className="px-4 py-2 bg-gray-100 border rounded-md text-gray-700 hover:bg-gray-200" onClick={reset}>Reset</button>
        <button className="px-4 py-2 bg-indigo-600 text-white rounded-md flex items-center hover:bg-indigo-700" onClick={()=>setShowPreview(true)}><FiFileText className="mr-2"/>Preview</button>
        <button className="px-4 py-2 bg-blue-600 text-white rounded-md flex items-center hover:bg-blue-700" onClick={generateCSV}><FiDownload className="mr-2"/>Generate CSV</button>
      </div>

      {showPreview && (
        <div className="overflow-x-auto mt-6">
          {loading ? (
            <div className="py-6 text-center text-gray-500">Loading disposed assets...</div>
          ) : error ? (
            <div className="text-red-500">{error}</div>
          ) : (
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">ID</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Make</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Model</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Serial</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-100">
                {filtered.map(a => (
                  <tr key={a.asset_id}>
                    <td className="px-4 py-2 whitespace-nowrap">{a.asset_id}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{a.asset_type_name || a.asset_types?.asset_type_name}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{a.make}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{a.model}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{a.serial_number}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{a.disposed_date?.slice(0,10)}</td>
                  </tr>
                ))}
                {filtered.length === 0 && (
                  <tr><td colSpan="6" className="px-4 py-4 text-center text-gray-500">No matching records</td></tr>
                )}
              </tbody>
            </table>
          )}
        </div>
      )}
    </div>
  );
};

export default DisposedReportSection;
