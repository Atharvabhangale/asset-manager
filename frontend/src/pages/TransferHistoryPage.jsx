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
    fromEmployeeName: '',
    toEmployeeName: '',
    fromDepartmentName: '',
    toDepartmentName: '',
    fromLocationName: '',
    toLocationName: '',
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

  const { employees, fetchEmployees } = useEmployees();
  const { departments, fetchDepartments } = useDepartments();
  const { locations, fetchLocations } = useLocations();

  // Load initial data
  useEffect(() => {
    console.log('Loading initial data...');
    const loadData = async () => {
      try {
        console.log('Fetching employees...');
        await fetchEmployees();
        console.log('Fetching departments...');
        await fetchDepartments();
        console.log('Fetching locations...');
        await fetchLocations();
      } catch (err) {
        console.error('Error loading initial data:', err);
      }
    };
    loadData();
  }, [fetchEmployees, fetchDepartments, fetchLocations]);

  // Debug log when data changes
  useEffect(() => {
    console.log('Departments:', departments);
    console.log('Employees:', employees);
    console.log('Locations:', locations);
  }, [departments, employees, locations]);

  // Apply filters when they change
  useEffect(() => {
    console.log('Filters changed, fetching transfers with:', filters);
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
      fromEmployeeName: '',
      toEmployeeName: '',
      fromDepartmentName: '',
      toDepartmentName: '',
      fromLocationName: '',
      toLocationName: '',
      startDate: '',
      endDate: '',
    });
  };

  const columns = [
    { 
      field: 'transfer_id', 
      header: 'Transfer ID',
      render: (row) => row.transfer_id || 'N/A'
    },
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
                name="fromEmployeeName"
                value={filters.fromEmployeeName}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Employees</option>
                {employees.map(emp => (
                  <option key={emp.employee_id} value={emp.employee_name}>
                    {emp.employee_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">To Employee</label>
              <select
                name="toEmployeeName"
                value={filters.toEmployeeName}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Employees</option>
                {employees.map(emp => (
                  <option key={emp.employee_id} value={emp.employee_name}>
                    {emp.employee_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">From Department</label>
              <select
                name="fromDepartmentName"
                value={filters.fromDepartmentName}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Departments</option>
                {departments.map(dept => (
                  <option key={dept.department_id} value={dept.department_name}>
                    {dept.department_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">To Department</label>
              <select
                name="toDepartmentName"
                value={filters.toDepartmentName}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Departments</option>
                {departments.map(dept => (
                  <option key={dept.department_id} value={dept.department_name}>
                    {dept.department_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">From Location</label>
              <select
                name="fromLocationName"
                value={filters.fromLocationName}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Locations</option>
                {locations.map(loc => (
                  <option key={loc.location_id} value={loc.location_name}>
                    {loc.location_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">To Location</label>
              <select
                name="toLocationName"
                value={filters.toLocationName}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              >
                <option value="">All Locations</option>
                {locations.map(loc => (
                  <option key={loc.location_id} value={loc.location_name}>
                    {loc.location_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Start Date</label>
              <input
                type="date"
                name="startDate"
                value={filters.startDate}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">End Date</label>
              <input
                type="date"
                name="endDate"
                value={filters.endDate}
                onChange={handleFilterChange}
                className="w-full p-2 border rounded-md"
              />
            </div>
          </div>
          <div className="flex justify-end mt-4 space-x-2">
            <Button 
              variant="secondary" 
              onClick={resetFilters}
              className="px-4 py-2"
            >
              Reset Filters
            </Button>
          </div>
        </div>
      )}

      <div className="bg-white rounded-lg shadow overflow-hidden">
        <DataTable
          columns={columns}
          data={transfers}
          loading={loading}
          emptyMessage="No transfer history found"
          className="w-full"
        />
      </div>
    </div>
  );
};

export default TransferHistoryPage;
