import React, { useEffect, useState } from 'react';
import DataTable from '../components/DataTable';
import Modal from '../components/Modal';
import { useDisposed } from '../hooks/useDisposed';
import { FiArchive, FiFilter, FiRefreshCw, FiSearch } from 'react-icons/fi';
import useLocations from '../hooks/useLocations';
import DateRangePicker from '../components/DateRangePicker';

const DisposedPage = () => {
  const { disposedAssets, fetchDisposed, loading } = useDisposed();
  const { locations, fetchLocations } = useLocations();
  const [isViewModalOpen, setIsViewModalOpen] = useState(false);
  const [selectedAsset, setSelectedAsset] = useState(null);
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({ location: '', type: '', startDate: '', endDate: '' });

  useEffect(() => {
    fetchDisposed();
    fetchLocations();
  }, [fetchDisposed, fetchLocations]);

  const handleView = (asset) => {
    setSelectedAsset(asset);
    setIsViewModalOpen(true);
  };

  const closeModal = () => {
    setIsViewModalOpen(false);
    setSelectedAsset(null);
  };

  const columns = [
    { key: 'asset_id', header: 'ID' },
    { key: 'asset_type_name', header: 'Type' },
    { key: 'make', header: 'Make' },
    { key: 'model', header: 'Model' },
    { key: 'serial_number', header: 'Serial' },
    {
      key: 'disposed_date',
      header: 'Disposed Date',
      render: (item) => item.disposed_date ? new Date(item.disposed_date).toLocaleDateString() : 'N/A',
    },
    { key: 'location_name', header: 'Location' },
    { key: 'department_name', header: 'Department' },
  ];

  // Filtering logic
  // Get unique asset types from disposedAssets
  const assetTypes = Array.from(new Set(disposedAssets.map(a => a.asset_type_name).filter(Boolean)));

  const filteredAssets = disposedAssets.filter(asset => {
    let match = true;
    if (filters.location) {
      // Compare as strings in case of type mismatch
      match = match && (
        String(asset.location_id) === String(filters.location) ||
        asset.location_name === filters.location
      );
    }
    if (filters.type) {
      match = match && asset.asset_type_name === filters.type;
    }
    if (filters.startDate) {
      match = match && asset.disposed_date && new Date(asset.disposed_date) >= new Date(filters.startDate);
    }
    if (filters.endDate) {
      match = match && asset.disposed_date && new Date(asset.disposed_date) <= new Date(filters.endDate);
    }
    return match;
  });

  const [searchTerm, setSearchTerm] = useState('');
  const finalFilteredAssets = filteredAssets.filter(asset => {
    if (!searchTerm) return true;
    const lower = searchTerm.toLowerCase();
    return (
      (asset.asset_type_name || '').toLowerCase().includes(lower) ||
      (asset.make || '').toLowerCase().includes(lower) ||
      (asset.model || '').toLowerCase().includes(lower) ||
      (asset.serial_number || '').toLowerCase().includes(lower) ||
      (asset.location_name || '').toLowerCase().includes(lower) ||
      (asset.department_name || '').toLowerCase().includes(lower) ||
      (asset.remarks || '').toLowerCase().includes(lower)
    );
  });

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-2xl font-semibold text-gray-800">Disposed Assets</h2>
        <div className="flex gap-2 items-center">
          <div className="relative w-full max-w-xs">
            <FiSearch className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
            <input
              type="text"
              value={searchTerm}
              onChange={e => setSearchTerm(e.target.value)}
              placeholder="Search disposed assets..."
              className="w-full pl-10 pr-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <button
            className="flex items-center px-3 py-1 border rounded text-gray-700 bg-gray-100 hover:bg-gray-200"
            onClick={() => setShowFilters(v => !v)}
          >
            <FiFilter className="mr-1" /> {showFilters ? 'Hide Filters' : 'Filters'}
          </button>
          <button
            className="flex items-center px-3 py-1 border rounded text-gray-700 bg-gray-100 hover:bg-gray-200"
            onClick={fetchDisposed}
            disabled={loading}
          >
            <FiRefreshCw className={`mr-1 ${loading ? 'animate-spin' : ''}`} /> Refresh
          </button>
        </div>
      </div>

      {showFilters && (
        <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200 mb-6">
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Location</label>
              <select
                className="w-full p-2 border rounded-md"
                value={filters.location}
                onChange={e => setFilters(f => ({ ...f, location: e.target.value }))}
              >
                <option value="">All Locations</option>
                {locations.map(loc => (
                  <option key={loc.location_id} value={loc.location_id}>{loc.location_name}</option>
                ))}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Type</label>
              <select
                className="w-full p-2 border rounded-md"
                value={filters.type}
                onChange={e => setFilters(f => ({ ...f, type: e.target.value }))}
              >
                <option value="">All Types</option>
                {assetTypes.map(type => (
                  <option key={type} value={type}>{type}</option>
                ))}
              </select>
            </div>
            <div className="flex flex-col">
              <label className="block text-sm font-medium text-gray-700 mb-1">Disposed Date</label>
              <DateRangePicker
                startDate={filters.startDate}
                endDate={filters.endDate}
                onChange={({ startDate, endDate }) => setFilters(f => ({ ...f, startDate, endDate }))}
              />
            </div>
          </div>
          <div className="flex mt-4">
            <button
              className="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300 text-gray-700 w-full md:w-auto"
              onClick={() => setFilters({ location: '', type: '', startDate: '', endDate: '' })}
            >
              Reset
            </button>
          </div>
        </div>
      )}

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        <DataTable
          columns={columns}
          data={finalFilteredAssets}
          loading={loading}
          onView={handleView}
          emptyMessage="No disposed assets found."
        />
      </div>

      <Modal isOpen={isViewModalOpen} onClose={closeModal} title="Disposed Asset Details" size="lg">
        {selectedAsset && (
          <div className="space-y-4">
            <p>
              <strong>ID:</strong> {selectedAsset.asset_id}
            </p>
            <p>
              <strong>Type:</strong> {selectedAsset.asset_type_name || selectedAsset.asset_type_id}
            </p>
            <p>
              <strong>Make/Model:</strong> {selectedAsset.make} {selectedAsset.model}
            </p>
            <p>
              <strong>Serial Number:</strong> {selectedAsset.serial_number}
            </p>
            <p>
              <strong>Disposed Date:</strong>{' '}
              {selectedAsset.disposed_date ? new Date(selectedAsset.disposed_date).toLocaleDateString() : 'N/A'}
            </p>
            <p>
              <strong>Location:</strong> {selectedAsset.location_name || selectedAsset.location_id}
            </p>
            <p>
              <strong>Department:</strong> {selectedAsset.department_name || selectedAsset.department_id}
            </p>
            {selectedAsset.reason && (
              <p>
                <strong>Reason:</strong> {selectedAsset.reason}
              </p>
            )}
            {selectedAsset.description && (
              <p>
                <strong>Description:</strong> {selectedAsset.description}
              </p>
            )}
          </div>
        )}
      </Modal>
    </div>
  );
};

export default DisposedPage;
