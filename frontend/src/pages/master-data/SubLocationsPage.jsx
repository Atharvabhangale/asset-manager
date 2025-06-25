import React, { useState } from 'react';
import { Formik, Form } from 'formik';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2, FiMapPin } from 'react-icons/fi';
import { useSubLocations } from '../../hooks/useSubLocations';
import DataTable from '../../components/DataTable';
import Modal from '../../components/Modal';
import { FormField } from '../../components/FormField';

const subLocationSchema = Yup.object().shape({
  name: Yup.string()
    .min(2, 'Sub-location name must be at least 2 characters')
    .max(100, 'Sub-location name must be less than 100 characters')
    .required('Sub-location name is required'),
  location_id: Yup.string().required('Location is required')
});

const SubLocationsPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingSubLocation, setEditingSubLocation] = useState(null);
  const [error, setError] = useState('');
  
  const {
    subLocations,
    locations,
    loading,
    error: fetchError,
    createSubLocation,
    updateSubLocation,
    deleteSubLocation
  } = useSubLocations();


  const [initialValues, setInitialValues] = useState({ 
    name: '',
    location_id: '' 
  });

  const handleAddSubLocation = () => {
    setEditingSubLocation(null);
    setInitialValues({ name: '', location_id: '' });
    setError('');
    setIsModalOpen(true);
  };

  const handleEditSubLocation = (subLocation) => {
    setEditingSubLocation(subLocation);
    setInitialValues({ 
      name: subLocation.sub_location_name,
      location_id: subLocation.location_id
    });
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteSubLocation = async (subLocation) => {
    if (window.confirm(`Are you sure you want to delete "${subLocation.sub_location_name}"?`)) {
      const result = await deleteSubLocation(subLocation.sub_location_id);
      if (!result.success) {
        setError(result.error);
      }
    }
  };

  const handleSubmit = async (values, { setSubmitting }) => {
    try {
      setError('');
      const subLocationData = {
        name: values.name,
        location_id: values.location_id
      };

      if (editingSubLocation) {
        await updateSubLocation(editingSubLocation.sub_location_id, subLocationData);
      } else {
        await createSubLocation(subLocationData);
      }

      setIsModalOpen(false);
    } catch (err) {
      setError(err.message || 'An error occurred');
    } finally {
      setSubmitting(false);
    }
  };

  const columns = [
    {
      key: 'sub_location',
      header: 'Sub-Location Name',
      accessor: 'sub_location_name',
      render: (item) => item.sub_location_name || 'N/A'
    },
    {
      key: 'location',
      header: 'Location',
      accessor: 'location_name',
      render: (item) => item.location_name || 'N/A'
    },
    {
      key: 'actions',
      header: 'Actions',
      accessor: 'actions',
      render: (item) => (
        <div className="flex space-x-2">
          <button
            onClick={(e) => {
              e.stopPropagation();
              handleEditSubLocation(item);
            }}
            className="text-blue-600 hover:text-blue-800"
            title="Edit"
          >
            <FiEdit2 />
          </button>
          <button
            onClick={(e) => {
              e.stopPropagation();
              handleDeleteSubLocation(item);
            }}
            className="text-red-600 hover:text-red-800"
            title="Delete"
          >
            <FiTrash2 />
          </button>
        </div>
      )
    }
  ];

  return (
    <div className="container mx-auto p-4">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Sub-Locations</h1>
        <button
          onClick={handleAddSubLocation}
          className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md flex items-center"
        >
          <FiPlus className="mr-2" /> Add Sub-Location
        </button>
      </div>

      {(error || fetchError) && (
        <div className="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
          <p>{error || fetchError}</p>
        </div>
      )}

      <DataTable
        columns={columns}
        data={subLocations}
        loading={loading}
        emptyMessage="No sub-locations found"
      />

      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title={editingSubLocation ? 'Edit Sub-Location' : 'Add New Sub-Location'}
      >
        <Formik
          initialValues={initialValues}
          validationSchema={subLocationSchema}
          onSubmit={handleSubmit}
          enableReinitialize
        >
          {({ isSubmitting, values }) => (
            <Form className="space-y-4">
              <FormField
                name="location_id"
                label="Location"
                as="select"
                icon={FiMapPin}
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
                name="name"
                label="Sub-Location Name"
                type="text"
                placeholder="Enter sub-location name"
                required
              />

              <div className="flex justify-end space-x-3 pt-4">
                <button
                  type="button"
                  onClick={() => setIsModalOpen(false)}
                  className="px-4 py-2 border border-gray-300 rounded-md text-gray-700 hover:bg-gray-50"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 disabled:opacity-50"
                >
                  {isSubmitting
                    ? 'Saving...'
                    : editingSubLocation
                    ? 'Update'
                    : 'Save'}
                </button>
              </div>
            </Form>
          )}
        </Formik>
      </Modal>
    </div>
  );
};

export default SubLocationsPage;
