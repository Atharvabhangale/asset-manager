import React, { useState, useEffect } from 'react';
import { useSearchParams } from 'react-router-dom';
import { FiRefreshCw, FiFilter, FiPlus } from 'react-icons/fi';
import DataTable from '../components/DataTable';
import Modal from '../components/Modal';
import Button from '../components/Button';
import useTransferHistory from '../hooks/useTransferHistory';
import useEmployees from '../hooks/useEmployees';
import useDepartments from '../hooks/useDepartments';
import useLocations from '../hooks/useLocations';

const TransferHistoryPage = () => {
  const [searchParams, setSearchParams] = useSearchParams();
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({
    assetId: '',
    fromEmployeeId: '',
    toEmployeeId: '',
    fromDepartmentId: '',
    toDepartmentId: '',
    fromLocationId: '',
    toLocationId: '',
    startDate: '',
    endDate: '',
  });

  const { 
    transfers, 
    loading, 
    error, 
    fetchTransfers,
    transferAsset 
  } = useTransferHistory();

  const { employees } = useEmployees();
  const { departments } = useDepartments();
  const { locations } = useLocations();

  useEffect(() => {
    fetchTransfers(filters);
  }, [filters]);

  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const resetFilters = () => {
    setFilters({
      assetId: '',
      fromEmployeeId: '',
      toEmployeeId: '',
      fromDepartmentId: '',
      toDepartmentId: '',
      fromLocationId: '',
      toLocationId: '',
      startDate: '',
      endDate: '',
    });
  };

  const columns = [
    { field: 'transfer_id', header: 'Transfer ID' },
    { 
      field: 'asset', 
      header: 'Asset',
      render: (row) => `${row.make} ${row.model} (${row.asset_id})`
    },
    { 
      field: 'from', 
      header: 'From',
      render: (row) => {
        const empName = row.from_employee_name || 'Unassigned';
        const fromDept = row.from_department_name || 'N/A';
        const fromLoc = row.from_location_name || 'N/A';
        return (
          <div className="text-sm">
            <div>{empName}</div>
            <div className="text-gray-500">{fromDept}, {fromLoc}</div>
          </div>
        );
      }
    },
    { 
      field: 'to', 
      header: 'To',
      render: (row) => {
        const empName = row.to_employee_name || 'Unassigned';
        const toDept = row.to_department_name || 'N/A';
        const toLoc = row.to_location_name || 'N/A';
        return (
          <div className="text-sm">
            <div>{empName}</div>
            <div className="text-gray-500">{toDept}, {toLoc}</div>
          </div>
        );
      }
    },
    { 
      field: 'transfer_date', 
      header: 'Transfer Date',
      render: (row) => new Date(row.transfer_date).toLocaleString()
    },
    { 
      field: 'notes', 
      header: 'Notes',
      className: 'max-w-xs truncate',
      render: (row) => row.notes || '-' 
    },
  ];

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-semibold text-gray-900">Transfer History</h1>
        <div className="flex space-x-3">
          <Button 
            variant="secondary" 
            onClick={() => setShowFilters(!showFilters)}
            icon={<FiFilter className="mr-2" />}
          >
            {showFilters ? 'Hide Filters' : 'Filters'}
          </Button>
          <Button 
            onClick={fetchTransfers} 
            loading={loading}
            icon={<FiRefreshCw className={`mr-2 ${loading ? 'animate-spin' : ''}`} />}
          >
            Refresh
          </Button>
        </div>
      </div>

      {error && (
        <div className="mb-4 p-4 bg-red-50 text-red-700 rounded-md">
          {error}
        </div>
      )}

      {showFilters && (
        <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200 mb-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Asset ID</label>
              <input
                type="text"
                name="assetId"
                value={filters.assetId}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
                placeholder="Filter by asset ID"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">From Employee</label>
              <select
                name="fromEmployeeId"
                value={filters.fromEmployeeId}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Employees</option>
                {employees.map(emp => (
                  <option key={emp.employee_id} value={emp.employee_id}>
                    {emp.first_name} {emp.last_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">To Employee</label>
              <select
                name="toEmployeeId"
                value={filters.toEmployeeId}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Employees</option>
                {employees.map(emp => (
                  <option key={emp.employee_id} value={emp.employee_id}>
                    {emp.first_name} {emp.last_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">From Department</label>
              <select
                name="fromDepartmentId"
                value={filters.fromDepartmentId}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Departments</option>
                {departments.map(dept => (
                  <option key={dept.department_id} value={dept.department_id}>
                    {dept.department_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">To Department</label>
              <select
                name="toDepartmentId"
                value={filters.toDepartmentId}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Departments</option>
                {departments.map(dept => (
                  <option key={dept.department_id} value={dept.department_id}>
                    {dept.department_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Transfer Date From</label>
              <input
                type="date"
                name="startDate"
                value={filters.startDate}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Transfer Date To</label>
              <input
                type="date"
                name="endDate"
                value={filters.endDate}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              />
            </div>
            <div className="flex items-end">
              <Button 
                variant="secondary" 
                onClick={resetFilters}
                className="w-full"
              >
                Reset Filters
              </Button>
            </div>
          </div>
        </div>
      )}

      <div className="bg-white rounded-lg shadow overflow-hidden">
        <DataTable
          data={transfers}
          columns={columns}
          loading={loading}
          searchFields={['asset_id', 'make', 'model', 'notes']}
          defaultSortField="transfer_date"
          defaultSortOrder="desc"
          emptyMessage="No transfer history found"
        />
      </div>
    </div>
  );
};

export default TransferHistoryPage;
