import React, { useState } from 'react';
import { Formik, Form } from 'formik';
import { useFormik } from 'formik';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2 } from 'react-icons/fi';
import { useLocations } from '../../hooks/useLocations';
import DataTable from '../../components/DataTable';
import Modal from '../../components/Modal';
import { FormField } from '../../components/FormField';

const locationSchema = Yup.object().shape({
  name: Yup.string()
    .min(2, 'Location name must be at least 2 characters')
    .max(100, 'Location name must be less than 100 characters')
    .required('Location name is required'),
});

const LocationsPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingLocation, setEditingLocation] = useState(null);
  const [error, setError] = useState('');
  
  const { 
    locations, 
    loading, 
    error: fetchError, 
    fetchLocations,
    createLocation, 
    updateLocation, 
    deleteLocation 
  } = useLocations();

  // Remove useFormik, use Formik component instead in the modal

  const [initialValues, setInitialValues] = useState({ name: '' });

  const handleAddLocation = () => {
    setEditingLocation(null);
    setInitialValues({ name: '' });
    setIsModalOpen(true);
  };

  const handleEditLocation = (location) => {
    setEditingLocation(location);
    setInitialValues({ name: location.location_name });
    setIsModalOpen(true);
  };


  const handleDeleteLocation = async (location) => {
    const result = await deleteLocation(location.location_id);
    if (!result.success && result.error) {
      setError(result.error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setError('');
    setEditingLocation(null);
  };

  const columns = [
    {
      key: 'location_name',
      header: 'Location Name',
    }
  ];

  // Debug: log locations to check if state updates after add
  console.log('Locations state:', locations);
  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Locations</h1>
        <button
          type="button"
          onClick={handleAddLocation}
          className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          <FiPlus className="-ml-1 mr-2 h-5 w-5" />
          Add Location
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
          key={locations.map(l => l.location_id).join(',')}
          columns={columns}
          data={locations}
          loading={loading}
          onEdit={handleEditLocation}
          onDelete={handleDeleteLocation}
          emptyMessage="No locations found. Add your first location to get started."
        />
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingLocation ? 'Edit Location' : 'Add New Location'}
      >
        <Formik
          enableReinitialize
          initialValues={initialValues}
          validationSchema={locationSchema}
          onSubmit={async (values, { setSubmitting, resetForm }) => {
            console.log('=== Form submission started ===');
            console.log('Form values:', values);
            console.log('Editing mode:', !!editingLocation);
            
            try {
              setError('');
              let result;
              
              if (editingLocation) {
                console.log('Updating existing location:', editingLocation.location_id);
                result = await updateLocation(editingLocation.location_id, values);
              } else {
                console.log('Creating new location');
                result = await createLocation(values);
              }
              
              console.log('Operation result:', result);
              
              if (result.success) {
                console.log('Operation successful, refreshing locations...');
                await fetchLocations();
                handleCloseModal();
                resetForm();
              } else {
                throw new Error(result.error || 'Unknown error occurred');
              }
            } catch (error) {
              console.error('Error in form submission:', error);
              setError(error.message);
            } finally {
              console.log('Form submission completed');
              setSubmitting(false);
            }
          }}
        >
          {({ isSubmitting, touched, errors }) => (
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
              <FormField
                label="Location Name"
                name="name"
                type="text"
              />
              <div className="mt-5 sm:mt-6 sm:grid sm:grid-cols-2 sm:gap-3 sm:grid-flow-row-dense">
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className={`w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-blue-600 text-base font-medium text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 sm:col-start-2 sm:text-sm ${
                    isSubmitting ? 'opacity-75 cursor-not-allowed' : ''
                  }`}
                >
                  {isSubmitting
                    ? 'Saving...'
                    : editingLocation
                    ? 'Update Location'
                    : 'Add Location'}
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

export default LocationsPage;
