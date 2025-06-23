import React, { useState, useEffect } from 'react';
import { Formik, Form } from 'formik';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2 } from 'react-icons/fi';
import { useAssetTypes } from '../../hooks/useAssetTypes';
import DataTable from '../../components/DataTable';
import Modal from '../../components/Modal';
import { FormField } from '../../components/FormField';

const assetTypeSchema = Yup.object().shape({
  name: Yup.string()
    .min(2, 'Asset type name must be at least 2 characters')
    .max(100, 'Asset type name must be less than 100 characters')
    .required('Asset type name is required'),
  description: Yup.string()
    .max(500, 'Description must be less than 500 characters')
});

const AssetTypesPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingAssetType, setEditingAssetType] = useState(null);
  const [error, setError] = useState('');
  
  const { 
    assetTypes, 
    loading, 
    error: fetchError, 
    fetchAssetTypes,
    createAssetType, 
    updateAssetType, 
    deleteAssetType 
  } = useAssetTypes();

  useEffect(() => {
    fetchAssetTypes();
  }, [fetchAssetTypes]);

  const handleAddAssetType = () => {
    setEditingAssetType(null);
    setError('');
    setIsModalOpen(true);
  };

  const handleEditAssetType = (assetType) => {
    setEditingAssetType(assetType);
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteAssetType = async (assetType) => {
    const result = await deleteAssetType(assetType.asset_type_id);
    if (!result.success && result.error) {
      setError(result.error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setError('');
    setEditingAssetType(null);
  };

  const columns = [
    {
      key: 'asset_type_name',
      header: 'Asset Type',
    },
    {
      key: 'description',
      header: 'Description',
      render: (item) => item.description || 'N/A',
    }
  ];

  const initialValues = editingAssetType
    ? { 
        name: editingAssetType.asset_type_name || '',
        description: editingAssetType.description || ''
      }
    : { name: '', description: '' };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Asset Types</h1>
        <button
          type="button"
          onClick={handleAddAssetType}
          className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          <FiPlus className="-ml-1 mr-2 h-5 w-5" />
          Add Asset Type
        </button>
      </div>

      {fetchError && (
        <div className="bg-red-50 border-l-4 border-red-400 p-4 mb-6">
          <div className="flex">
            <div className="flex-shrink-0">
              <svg className="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
              </svg>
            </div>
            <div className="ml-3">
              <p className="text-sm text-red-700">{fetchError}</p>
            </div>
          </div>
        </div>
      )}

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        <DataTable
          key={assetTypes.map(a => a.asset_type_id).join(',')}
          columns={columns}
          data={assetTypes}
          loading={loading}
          onEdit={handleEditAssetType}
          onDelete={handleDeleteAssetType}
          emptyMessage="No asset types found. Add your first asset type to get started."
        />
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingAssetType ? 'Edit Asset Type' : 'Add New Asset Type'}
      >
        <Formik
          enableReinitialize
          initialValues={initialValues}
          validationSchema={assetTypeSchema}
          onSubmit={async (values, { setSubmitting, resetForm }) => {
            try {
              setError('');
              let result;
              
              if (editingAssetType) {
                result = await updateAssetType(editingAssetType.asset_type_id, values);
              } else {
                result = await createAssetType(values);
              }
              
              if (result.success) {
                handleCloseModal();
                resetForm();
              } else {
                throw new Error(result.error || 'An error occurred');
              }
            } catch (err) {
              setError(err.message);
            } finally {
              setSubmitting(false);
            }
          }}
        >
          {({ isSubmitting }) => (
            <Form>
              {error && (
                <div className="mb-4 bg-red-50 border-l-4 border-red-400 p-4">
                  <div className="flex">
                    <div className="flex-shrink-0">
                      <svg className="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                        <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                      </svg>
                    </div>
                    <div className="ml-3">
                      <p className="text-sm text-red-700">{error}</p>
                    </div>
                  </div>
                </div>
              )}
              <div className="space-y-4">
                <FormField
                  label="Asset Type Name"
                  name="name"
                  type="text"
                  placeholder="e.g., Laptop, Monitor, Phone"
                  required
                />
                <FormField
                  label="Description (Optional)"
                  name="description"
                  type="textarea"
                  placeholder="Add a brief description of this asset type"
                  rows={3}
                />
              </div>
              <div className="mt-5 sm:mt-6 sm:grid sm:grid-cols-2 sm:gap-3 sm:grid-flow-row-dense">
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:col-start-2 sm:text-sm"
                >
                  {isSubmitting ? 'Saving...' : 'Save'}
                </button>
                <button
                  type="button"
                  onClick={handleCloseModal}
                  className="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:mt-0 sm:col-start-1 sm:text-sm"
                >
                  Cancel
                </button>
              </div>
            </Form>
          )}
        </Formik>
      </Modal>
    </div>
  );
};

export default AssetTypesPage;
