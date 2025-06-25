import React, { useEffect, useState } from 'react';
import DataTable from '../components/DataTable';
import Modal from '../components/Modal';
import { useDisposed } from '../hooks/useDisposed';
import { FiArchive } from 'react-icons/fi';

const DisposedPage = () => {
  const { disposedAssets, fetchDisposed, loading } = useDisposed();
  const [isViewModalOpen, setIsViewModalOpen] = useState(false);
  const [selectedAsset, setSelectedAsset] = useState(null);

  useEffect(() => {
    fetchDisposed();
  }, [fetchDisposed]);

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

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h2 className="text-2xl font-semibold text-gray-800">
          Disposed Assets
        </h2>
      </div>

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        <DataTable
          columns={columns}
          data={disposedAssets}
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
