import React, { useState, useEffect } from 'react';
import { Formik, Form } from 'formik';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2, FiPhone, FiMail, FiMapPin, FiSearch } from 'react-icons/fi';
import { useVendors } from '../../hooks/useVendors';
import DataTable from '../../components/DataTable';
import Modal from '../../components/Modal';
import { FormField } from '../../components/FormField';

const vendorSchema = Yup.object().shape({
  name: Yup.string()
    .min(2, 'Vendor name must be at least 2 characters')
    .max(100, 'Vendor name must be less than 100 characters')
    .required('Vendor name is required'),
  email: Yup.string()
    .email('Invalid email address')
    .max(100, 'Email must be less than 100 characters'),
  phone: Yup.string()
    .max(20, 'Phone number must be less than 20 characters'),
  address: Yup.string()
    .max(500, 'Address must be less than 500 characters'),
  remarks: Yup.string()
    .max(1000, 'Remarks must be less than 1000 characters')
});

const VendorsPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingVendor, setEditingVendor] = useState(null);
  const [error, setError] = useState('');
  
  const { 
    vendors, 
    loading, 
    error: fetchError, 
    fetchVendors,
    createVendor, 
    updateVendor, 
    deleteVendor 
  } = useVendors();

  useEffect(() => {
    fetchVendors();
  }, [fetchVendors]);

  const handleAddVendor = () => {
    setEditingVendor(null);
    setError('');
    setIsModalOpen(true);
  };

  const handleEditVendor = (vendor) => {
    setEditingVendor(vendor);
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteVendor = async (vendor) => {
    const result = await deleteVendor(vendor.vendor_id);
    if (!result.success && result.error) {
      setError(result.error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setError('');
    setEditingVendor(null);
  };

  const [searchTerm, setSearchTerm] = useState('');
  const filteredVendors = vendors.filter(vendor => {
    if (!searchTerm) return true;
    const lower = searchTerm.toLowerCase();
    return (
      (vendor.vendor_name || '').toLowerCase().includes(lower) ||
      (vendor.contact_email || '').toLowerCase().includes(lower) ||
      (vendor.phone || '').toLowerCase().includes(lower) ||
      (vendor.address || '').toLowerCase().includes(lower) ||
      (vendor.remarks || '').toLowerCase().includes(lower)
    );
  });

  const columns = [
    {
      key: 'vendor_name',
      header: 'Vendor Name',
    },
    {
      key: 'contact_email',
      header: 'Contact Email',
      render: (item) => item.contact_email || 'N/A',
    },
    {
      key: 'phone',
      header: 'Phone',
      render: (item) => item.phone || 'N/A',
    },
    {
      key: 'remarks',
      header: 'Remarks',
      render: (item) => item.remarks ? 
        (item.remarks.length > 30 ? `${item.remarks.substring(0, 30)}...` : item.remarks) : 
        'N/A',
    }
  ];

  const initialValues = editingVendor
    ? { 
        name: editingVendor.vendor_name || '',
        email: editingVendor.contact_email || '',
        phone: editingVendor.phone || '',
        address: editingVendor.address || '',
        remarks: editingVendor.remarks || ''
      }
    : { 
        name: '', 
        email: '', 
        phone: '', 
        address: '',
        remarks: ''
      };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800 mb-3">Vendors</h1>
        <div className="flex items-center gap-2">
          <div className="relative w-full max-w-xs">
            <FiSearch className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
            <input
              type="text"
              value={searchTerm}
              onChange={e => setSearchTerm(e.target.value)}
              placeholder="Search vendors..."
              className="w-full pl-10 pr-4 py-2 border rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
          </div>
          <button
            type="button"
            onClick={handleAddVendor}
            className="ml-auto inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
          >
            <FiPlus className="-ml-1 mr-2 h-5 w-5" />
            Add Vendor
          </button>
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
          key={filteredVendors.map(v => v.vendor_id).join(',')}
          columns={columns}
          data={filteredVendors}
          loading={loading}
          onEdit={handleEditVendor}
          onDelete={handleDeleteVendor}
          emptyMessage="No vendors found. Add your first vendor to get started."
        />
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingVendor ? 'Edit Vendor' : 'Add New Vendor'}
      >
        <Formik
          enableReinitialize
          initialValues={initialValues}
          validationSchema={vendorSchema}
          onSubmit={async (values, { setSubmitting, resetForm }) => {
            try {
              setError('');
              let result;
              
              if (editingVendor) {
                result = await updateVendor(editingVendor.vendor_id, values);
              } else {
                result = await createVendor(values);
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
                  label="Vendor Name"
                  name="name"
                  type="text"
                  placeholder="e.g., ABC Suppliers, XYZ Corp"
                  required
                />
                <div className="relative mt-1">
                  <div className="absolute bottom-1 left-0 pl-3 flex items-center pointer-events-none">
                    <FiMail className="h-5 w-5 text-gray-400" />
                  </div>
                  <FormField
                    label="Contact Email"
                    name="email"
                    type="email"
                    placeholder="contact@example.com"
                    className="pl-10"
                  />
                </div>
                <div className="relative mt-1">
                  <div className="absolute bottom-1 left-0 pl-3 flex items-center pointer-events-none">
                    <FiPhone className="h-5 w-5 text-gray-400" />
                  </div>
                  <FormField
                    label="Phone Number"
                    name="phone"
                    type="tel"
                    placeholder="+1 (555) 123-4567"
                    className="pl-10"
                  />
                </div>
                <div className="relative mt-1">
                  <div className="absolute bottom-1 left-0 pl-3">
                    <FiMapPin className="h-5 w-5 text-gray-400" />
                  </div>
                  <FormField
                    label="Address"
                    name="address"
                    type="textarea"
                    placeholder="123 Business St, City, Country"
                    rows={3}
                    className="pl-10"
                  />
                </div>
                <div className="relative mt-1">
                  <FormField
                    label="Remarks"
                    name="remarks"
                    type="textarea"
                    placeholder="Additional notes or comments about this vendor"
                    rows={3}
                  />
                </div>
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

export default VendorsPage;
