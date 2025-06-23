import React, { useState, useEffect } from 'react';
import { Formik, Form } from 'formik';
import { useSearchParams } from 'react-router-dom';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2, FiSearch, FiX } from 'react-icons/fi';

const getStatusBadgeClass = (status) => {
  switch (status) {
    case 'in_stock':
      return 'bg-green-100 text-green-800';
    case 'assigned':
      return 'bg-blue-100 text-blue-800';
    case 'in_maintenance':
      return 'bg-yellow-100 text-yellow-800';
    case 'retired':
      return 'bg-gray-100 text-gray-800';
    default:
      return 'bg-gray-100 text-gray-800';
  }
};
import { useAssets } from '../hooks/useAssets';
import DataTable from '../components/DataTable';
import Modal from '../components/Modal';
import { FormField } from '../components/FormField';

const statusOptions = [
  { value: 'in_stock', label: 'In Stock' },
  { value: 'assigned', label: 'Assigned' },
  { value: 'in_maintenance', label: 'In Maintenance' },
  { value: 'retired', label: 'Retired' }
];

const assetSchema = Yup.object().shape({
  assetTypeId: Yup.string().required('Asset type is required'),
  make: Yup.string()
    .required('Make is required')
    .max(100, 'Make must be less than 100 characters'),
  model: Yup.string()
    .required('Model is required')
    .max(100, 'Model must be less than 100 characters'),
  serialNumber: Yup.string()
    .required('Serial number is required')
    .max(50, 'Serial number must be less than 50 characters'),
  status: Yup.string()
    .required('Status is required')
    .oneOf(statusOptions.map(opt => opt.value), 'Invalid status'),
  purchaseDate: Yup.date().nullable(),
  warrantyExpiry: Yup.date().nullable(),
  purchaseInvoiceNumber: Yup.string().max(50, 'Invoice number must be less than 50 characters'),
  orderNumber: Yup.string().max(50, 'Order number must be less than 50 characters'),
  locationId: Yup.string().required('Location is required'),
  departmentId: Yup.string().required('Department is required'),
  employeeId: Yup.string().nullable(),
  description: Yup.string().max(500, 'Description must be less than 500 characters'),
  specification: Yup.string().max(500, 'Specification must be less than 500 characters'),
  sapReference: Yup.string().max(50, 'SAP reference must be less than 50 characters'),
  blankField1: Yup.string().max(500, 'Field must be less than 500 characters'),
  blankField2: Yup.string().max(500, 'Field must be less than 500 characters'),
  blankField3: Yup.string().max(500, 'Field must be less than 500 characters'),
});

const AssetsPage = () => {
  const [searchParams, setSearchParams] = useSearchParams();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingAsset, setEditingAsset] = useState(null);
  const [error, setError] = useState('');
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('all');
  const [activeFilter, setActiveFilter] = useState('all');
  
  const { 
    assets, 
    assetTypes, 
    locations, 
    departments, 
    employees,
    loading, 
    error: fetchError, 
    fetchAssets,
    fetchAssetTypes,
    fetchLocations,
    fetchDepartments,
    fetchEmployees,
    createAsset, 
    updateAsset, 
    deleteAsset 
  } = useAssets();

  useEffect(() => {
    const loadData = async () => {
      await Promise.all([
        fetchAssets(),
        fetchAssetTypes(),
        fetchLocations(),
        fetchDepartments(),
        fetchEmployees(),
      ]);
    };
    loadData();
    
    // Check for action query parameter
    const action = searchParams.get('action');
    if (action === 'add') {
      handleAddAsset();
      // Remove the query parameter after handling
      searchParams.delete('action');
      setSearchParams(searchParams);
    }
    
    // Check for filter query parameter
    const filter = searchParams.get('filter');
    if (filter === 'unassigned') {
      setActiveFilter('unassigned');
    }
  }, [fetchAssets, fetchAssetTypes, fetchLocations, fetchDepartments, fetchEmployees, searchParams, setSearchParams]);

  const handleAddAsset = () => {
    setEditingAsset(null);
    setError('');
    setIsModalOpen(true);
  };
  
  // Filter assets based on active filter and search term

  const handleEditAsset = (asset) => {
    setEditingAsset(asset);
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteAsset = async (asset) => {
    const result = await deleteAsset(asset.asset_id);
    if (!result.success && result.error) {
      setError(result.error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setError('');
    setEditingAsset(null);
  };
  
  const clearFilters = () => {
    setActiveFilter('all');
    setStatusFilter('all');
    setSearchTerm('');
  };

  // Filter assets based on active filter, status filter, and search term
  const filteredAssets = assets.filter(asset => {
    // Apply active filter (unassigned)
    if (activeFilter === 'unassigned' && asset.employee_id) {
      return false;
    }
    
    // Apply status filter
    if (statusFilter !== 'all' && asset.status !== statusFilter) {
      return false;
    }
    
    // Apply search term if present
    if (searchTerm) {
      const searchLower = searchTerm.toLowerCase();
      return (
        (asset.make?.toLowerCase() || '').includes(searchLower) ||
        (asset.model?.toLowerCase() || '').includes(searchLower) ||
        (asset.serial_number?.toLowerCase() || '').includes(searchLower) ||
        (asset.asset_types?.asset_type_name || '').toLowerCase().includes(searchLower) ||
        (asset.locations?.location_name || '').toLowerCase().includes(searchLower) ||
        (asset.departments?.department_name || '').toLowerCase().includes(searchLower) ||
        (asset.employees?.employee_name || '').toLowerCase().includes(searchLower)
      );
    }
    
    return true;
  });

  const columns = [
    {
      key: 'asset_id',
      header: 'ID',
    },
    {
      key: 'asset_types.asset_type_name',
      header: 'Type',
      render: (item) => item.asset_types?.asset_type_name || 'N/A',
    },
    {
      key: 'make',
      header: 'Make',
    },
    {
      key: 'model',
      header: 'Model',
    },
    {
      key: 'status',
      header: 'Status',
      render: (item) => (
        <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${getStatusBadgeClass(item.status)}`}>
          {statusOptions.find(opt => opt.value === item.status)?.label || item.status}
        </span>
      ),
    },
    {
      key: 'serial_number',
      header: 'Serial Number',
    },
    {
      key: 'locations.location_name',
      header: 'Location',
      render: (item) => item.locations?.location_name || 'N/A',
    },
    {
      key: 'departments.department_name',
      header: 'Department',
      render: (item) => item.departments?.department_name || 'N/A',
    },
    {
      key: 'employees.employee_name',
      header: 'Assigned To',
      render: (item) => item.employees?.employee_name || 'Unassigned',
    },
  ];

  const initialValues = editingAsset
    ? {
        assetTypeId: editingAsset.asset_type_id.toString(),
        make: editingAsset.make,
        model: editingAsset.model,
        serialNumber: editingAsset.serial_number,
        purchaseDate: editingAsset.purchase_date || '',
        warrantyExpiry: editingAsset.warranty_expiry || '',
        purchaseInvoiceNumber: editingAsset.purchase_invoice_number || '',
        orderNumber: editingAsset.order_number || '',
        status: editingAsset.status || 'in_stock',
        locationId: editingAsset.location_id.toString(),
        departmentId: editingAsset.department_id.toString(),
        employeeId: editingAsset.employee_id ? editingAsset.employee_id.toString() : '',
        description: editingAsset.description || '',
        specification: editingAsset.specification || '',
        sapReference: editingAsset.sap_reference || '',
        blankField1: editingAsset.blank_field_1 || '',
        blankField2: editingAsset.blank_field_2 || '',
        blankField3: editingAsset.blank_field_3 || '',
      }
    : {
        assetTypeId: '',
        make: '',
        model: '',
        serialNumber: '',
        status: 'in_stock',
        purchaseDate: '',
        warrantyExpiry: '',
        purchaseInvoiceNumber: '',
        orderNumber: '',
        locationId: '',
        departmentId: '',
        employeeId: '',
        description: '',
        specification: '',
        sapReference: '',
        blankField1: '',
        blankField2: '',
        blankField3: '',
      };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex flex-col md:flex-row md:justify-between md:items-center mb-6 gap-4">
        <h1 className="text-2xl font-bold text-gray-800">Assets</h1>
        <div className="flex flex-col sm:flex-row gap-4 w-full md:w-auto">
          <div className="relative flex-grow md:flex-grow-0 md:w-64">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <FiSearch className="h-5 w-5 text-gray-400" />
            </div>
            <input
              type="text"
              placeholder="Search assets..."
              className="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
            />
          </div>
          
          <div className="relative w-full sm:w-48">
            <select
              className="block w-full pl-3 pr-10 py-2 text-base border border-gray-300 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm rounded-md"
              value={statusFilter}
              onChange={(e) => setStatusFilter(e.target.value)}
            >
              <option value="all">All Statuses</option>
              {statusOptions.map(option => (
                <option key={option.value} value={option.value}>
                  {option.label}
                </option>
              ))}
            </select>
          </div>
          
          <div className="flex space-x-2">
            {(activeFilter === 'unassigned' || statusFilter !== 'all') && (
              <span className="inline-flex items-center px-3 py-1.5 rounded-full text-xs font-medium bg-indigo-100 text-indigo-800">
                {activeFilter === 'unassigned' ? 'Unassigned Assets' : `${statusOptions.find(o => o.value === statusFilter)?.label} Assets`}
                <button 
                  type="button" 
                  onClick={() => {
                    setActiveFilter('all');
                    setStatusFilter('all');
                  }}
                  className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-indigo-600 hover:text-indigo-900 focus:outline-none"
                >
                  <FiX className="h-3 w-3" />
                </button>
              </span>
            )}
            <button
              type="button"
              onClick={handleAddAsset}
              className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 whitespace-nowrap"
            >
              <FiPlus className="-ml-1 mr-2 h-5 w-5" />
              Add Asset
            </button>
          </div>
        </div>
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
          key={assets.map(a => a.asset_id).join(',')}
          columns={columns}
          data={filteredAssets}
          loading={loading}
          onEdit={handleEditAsset}
          onDelete={handleDeleteAsset}
          emptyMessage="No assets found. Add your first asset to get started."
        />
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingAsset ? 'Edit Asset' : 'Add New Asset'}
        size="xl"
      >
        <Formik
          enableReinitialize
          initialValues={initialValues}
          validationSchema={assetSchema}
          onSubmit={async (values, { setSubmitting, resetForm }) => {
            try {
              setError('');
              let result;
              
              const assetData = {
                assetTypeId: parseInt(values.assetTypeId, 10),
                make: values.make,
                model: values.model,
                serialNumber: values.serialNumber,
                status: values.status,
                purchaseDate: values.purchaseDate || null,
                warrantyExpiry: values.warrantyExpiry || null,
                purchaseInvoiceNumber: values.purchaseInvoiceNumber || null,
                orderNumber: values.orderNumber || null,
                locationId: parseInt(values.locationId, 10),
                departmentId: parseInt(values.departmentId, 10),
                employeeId: values.employeeId ? parseInt(values.employeeId, 10) : null,
                description: values.description || null,
                specification: values.specification || null,
                sapReference: values.sapReference || null,
                blankField1: values.blankField1 || null,
                blankField2: values.blankField2 || null,
                blankField3: values.blankField3 || null,
              };
              
              if (editingAsset) {
                result = await updateAsset(editingAsset.asset_id, assetData);
              } else {
                result = await createAsset(assetData);
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
          {({ isSubmitting, values, setFieldValue }) => (
            <Form className="space-y-4">
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
              
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div className="col-span-2">
                  <h3 className="text-lg font-medium text-gray-900 mb-3">Basic Information</h3>
                </div>
                
                <FormField
                  label="Asset Type"
                  name="assetTypeId"
                  as="select"
                  required
                >
                  <option value="">Select an asset type</option>
                  {assetTypes.map((type) => (
                    <option key={type.asset_type_id} value={type.asset_type_id}>
                      {type.asset_type_name}
                    </option>
                  ))}
                </FormField>
                
                <FormField
                  label="Make"
                  name="make"
                  type="text"
                  placeholder="e.g., Dell, HP, Lenovo"
                  required
                />
                
                <FormField
                  label="Model"
                  name="model"
                  type="text"
                  placeholder="e.g., XPS 15, ThinkPad X1"
                  required
                />
                
                <FormField
                  label="Status"
                  name="status"
                  as="select"
                  required
                >
                  {statusOptions.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </FormField>
                
                <FormField
                  label="Serial Number"
                  name="serialNumber"
                  type="text"
                  placeholder="Enter unique serial number"
                  required
                />
                
                <FormField
                  label="Purchase Date"
                  name="purchaseDate"
                  type="date"
                />
                
                <FormField
                  label="Warranty Expiry"
                  name="warrantyExpiry"
                  type="date"
                />
                
                <FormField
                  label="Purchase Invoice #"
                  name="purchaseInvoiceNumber"
                  type="text"
                  placeholder="Invoice number"
                />
                
                <FormField
                  label="Order Number"
                  name="orderNumber"
                  type="text"
                  placeholder="Order reference"
                />
                
                <FormField
                  label="SAP Reference"
                  name="sapReference"
                  type="text"
                  placeholder="SAP reference code"
                />
                
                <div className="col-span-2">
                  <h3 className="text-lg font-medium text-gray-900 mb-3 mt-6">Assignment</h3>
                </div>
                
                <FormField
                  label="Location"
                  name="locationId"
                  as="select"
                  required
                >
                  <option value="">Select a location</option>
                  {locations.map((location) => (
                    <option key={location.location_id} value={location.location_id}>
                      {location.location_name}
                    </option>
                  ))}
                </FormField>
                
                <FormField
                  label="Department"
                  name="departmentId"
                  as="select"
                  required
                >
                  <option value="">Select a department</option>
                  {departments.map((dept) => (
                    <option key={dept.department_id} value={dept.department_id}>
                      {dept.department_name}
                    </option>
                  ))}
                </FormField>
                
                <FormField
                  label="Assigned To (Optional)"
                  name="employeeId"
                  as="select"
                >
                  <option value="">Unassigned</option>
                  {employees.map((employee) => (
                    <option key={employee.employee_id} value={employee.employee_id}>
                      {employee.employee_name}
                    </option>
                  ))}
                </FormField>
                
                <div className="col-span-2">
                  <h3 className="text-lg font-medium text-gray-900 mb-3 mt-6">Additional Information</h3>
                </div>
                
                <FormField
                  label="Description"
                  name="description"
                  as="textarea"
                  rows={3}
                  placeholder="Asset description"
                />
                
                <FormField
                  label="Specifications"
                  name="specification"
                  as="textarea"
                  rows={3}
                  placeholder="Technical specifications"
                />
                
                <FormField
                  label="Custom Field 1"
                  name="blankField1"
                  type="text"
                  placeholder="Custom field 1"
                />
                
                <FormField
                  label="Custom Field 2"
                  name="blankField2"
                  type="text"
                  placeholder="Custom field 2"
                />
                
                <FormField
                  label="Custom Field 3"
                  name="blankField3"
                  type="text"
                  placeholder="Custom field 3"
                />
              </div>
              
              <div className="mt-6 flex justify-end space-x-3">
                <button
                  type="button"
                  onClick={handleCloseModal}
                  className="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                >
                  {isSubmitting ? 'Saving...' : 'Save Asset'}
                </button>
              </div>
            </Form>
          )}
        </Formik>
      </Modal>
    </div>
  );
};

export default AssetsPage;
