import React, { useState, useEffect } from 'react';
import { FiFileText, FiDownload } from 'react-icons/fi';
import { useTransferHistory } from '../hooks/useTransferHistory';
import { useAssets } from '../hooks/useAssets';

const TransferReportSection = () => {
  const {
    transfers,
    loading,
    error,
    fetchTransfers,
  } = useTransferHistory();

  // We leverage useAssets just to get dropdown data (employees, depts, locations)
  const {
    employees,
    departments,
    locations,
    fetchEmployees,
    fetchDepartments,
    fetchLocations,
  } = useAssets();

  // Load dropdown data once
  useEffect(() => {
    fetchEmployees();
    fetchDepartments();
    fetchLocations();
  }, [fetchEmployees, fetchDepartments, fetchLocations]);

  const [filters, setFilters] = useState({
    assetId: '',
    fromEmployee: '',
    toEmployee: '',
    fromDepartment: '',
    toDepartment: '',
    fromLocation: '',
    toLocation: '',
    startDate: '',
    endDate: '',
  });

  const [showPreview, setShowPreview] = useState(false);

  // Helper to trigger preview
  const handlePreview = async () => {
    await fetchTransfers({
      assetId: filters.assetId || undefined,
      fromEmployeeName: filters.fromEmployee || undefined,
      toEmployeeName: filters.toEmployee || undefined,
      fromDepartmentName: filters.fromDepartment || undefined,
      toDepartmentName: filters.toDepartment || undefined,
      fromLocationName: filters.fromLocation || undefined,
      toLocationName: filters.toLocation || undefined,
      startDate: filters.startDate || undefined,
      endDate: filters.endDate || undefined,
    });
    setShowPreview(true);
  };

  const resetFilters = () => {
    setFilters({
      assetId: '',
      fromEmployee: '',
      toEmployee: '',
      fromDepartment: '',
      toDepartment: '',
      fromLocation: '',
      toLocation: '',
      startDate: '',
      endDate: '',
    });
    setShowPreview(false);
  };

  const generateCSV = () => {
    if (transfers.length === 0) return;
    const headers = [
      'Transfer ID',
      'Asset ID',
      'Make',
      'Model',
      'From Employee',
      'To Employee',
      'From Department',
      'To Department',
      'From Location',
      'To Location',
      'Transfer Date',
      'Notes',
    ];

    const rows = transfers.map(t => ({
      transferId: t.transfer_id,
      assetId: t.asset_id,
      make: t.make || 'N/A',
      model: t.model || 'N/A',
      fromEmp: t.from_employee_name || 'N/A',
      toEmp: t.to_employee_name || 'N/A',
      fromDept: t.from_department_name || 'N/A',
      toDept: t.to_department_name || 'N/A',
      fromLoc: t.from_location_name || 'N/A',
      toLoc: t.to_location_name || 'N/A',
      date: t.transfer_date || 'N/A',
      notes: t.notes || 'N/A',
    }));

    const csvContent = [
      headers.join(','),
      ...rows.map(r => Object.values(r).map(v => `"${String(v).replace(/"/g, '""')}"`).join(','))
    ].join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'transfer_history_report.csv');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="bg-white shadow rounded-lg p-6 space-y-6">
      <h2 className="text-xl font-semibold text-gray-800">Transfer History Report Filters</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
        {/* Asset ID */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Asset ID</label>
          <input
            type="number"
            className="w-full p-2 border rounded-md"
            value={filters.assetId}
            onChange={e => setFilters(f => ({ ...f, assetId: e.target.value }))}
          />
        </div>
        {/* From Employee */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">From Employee</label>
          <select
            className="w-full p-2 border rounded-md"
            value={filters.fromEmployee}
            onChange={e => setFilters(f => ({ ...f, fromEmployee: e.target.value }))}
          >
            <option value="">All Employees</option>
            {employees.map(emp => (
              <option key={emp.employee_id} value={emp.employee_name}>{emp.employee_name}</option>
            ))}
          </select>
        </div>
        {/* To Employee */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">To Employee</label>
          <select
            className="w-full p-2 border rounded-md"
            value={filters.toEmployee}
            onChange={e => setFilters(f => ({ ...f, toEmployee: e.target.value }))}
          >
            <option value="">All Employees</option>
            {employees.map(emp => (
              <option key={emp.employee_id} value={emp.employee_name}>{emp.employee_name}</option>
            ))}
          </select>
        </div>
        {/* From Department */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">From Department</label>
          <select
            className="w-full p-2 border rounded-md"
            value={filters.fromDepartment}
            onChange={e => setFilters(f => ({ ...f, fromDepartment: e.target.value }))}
          >
            <option value="">All Departments</option>
            {departments.map(dep => (
              <option key={dep.department_id} value={dep.department_name}>{dep.department_name}</option>
            ))}
          </select>
        </div>
        {/* To Department */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">To Department</label>
          <select
            className="w-full p-2 border rounded-md"
            value={filters.toDepartment}
            onChange={e => setFilters(f => ({ ...f, toDepartment: e.target.value }))}
          >
            <option value="">All Departments</option>
            {departments.map(dep => (
              <option key={dep.department_id} value={dep.department_name}>{dep.department_name}</option>
            ))}
          </select>
        </div>
        {/* From Location */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">From Location</label>
          <select
            className="w-full p-2 border rounded-md"
            value={filters.fromLocation}
            onChange={e => setFilters(f => ({ ...f, fromLocation: e.target.value }))}
          >
            <option value="">All Locations</option>
            {locations.map(loc => (
              <option key={loc.location_id} value={loc.location_name}>{loc.location_name}</option>
            ))}
          </select>
        </div>
        {/* To Location */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">To Location</label>
          <select
            className="w-full p-2 border rounded-md"
            value={filters.toLocation}
            onChange={e => setFilters(f => ({ ...f, toLocation: e.target.value }))}
          >
            <option value="">All Locations</option>
            {locations.map(loc => (
              <option key={loc.location_id} value={loc.location_name}>{loc.location_name}</option>
            ))}
          </select>
        </div>
        {/* Start Date */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
          <input
            type="date"
            className="w-full p-2 border rounded-md"
            value={filters.startDate}
            onChange={e => setFilters(f => ({ ...f, startDate: e.target.value }))}
          />
        </div>
        {/* End Date */}
        <div>
          <label className="block text-sm font-medium text-gray-700 mb-1">End Date</label>
          <input
            type="date"
            className="w-full p-2 border rounded-md"
            value={filters.endDate}
            onChange={e => setFilters(f => ({ ...f, endDate: e.target.value }))}
          />
        </div>
      </div>

      <div className="flex justify-end gap-3">
        <button
          className="px-4 py-2 bg-gray-100 border rounded-md text-gray-700 hover:bg-gray-200"
          onClick={resetFilters}
        >
          Reset
        </button>
        <button
          className="px-4 py-2 bg-indigo-600 text-white rounded-md flex items-center hover:bg-indigo-700"
          onClick={handlePreview}
        >
          <FiFileText className="mr-2" /> Preview
        </button>
        <button
          className="px-4 py-2 bg-blue-600 text-white rounded-md flex items-center hover:bg-blue-700"
          onClick={generateCSV}
        >
          <FiDownload className="mr-2" /> Generate CSV
        </button>
      </div>

      {showPreview && (
        <div className="overflow-x-auto mt-6">
          {loading ? (
            <div className="py-6 text-gray-500 text-center">Loading transfers...</div>
          ) : error ? (
            <div className="text-red-500">{error}</div>
          ) : (
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Transfer ID</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Asset ID</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">From</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">To</th>
                  <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-100">
                {transfers.map(t => (
                  <tr key={t.transfer_id}>
                    <td className="px-4 py-2 whitespace-nowrap">{t.transfer_id}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{t.asset_id}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{t.from_employee_name || t.from_location_name}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{t.to_employee_name || t.to_location_name}</td>
                    <td className="px-4 py-2 whitespace-nowrap">{t.transfer_date?.slice(0,10)}</td>
                  </tr>
                ))}
                {transfers.length === 0 && (
                  <tr>
                    <td colSpan="5" className="px-4 py-4 text-center text-gray-500">No matching transfers</td>
                  </tr>
                )}
              </tbody>
            </table>
          )}
        </div>
      )}
    </div>
  );
};

export default TransferReportSection;
