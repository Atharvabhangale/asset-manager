import React, { useState, useEffect } from 'react';
import { Formik, Form } from 'formik';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2, FiLayers } from 'react-icons/fi';
import { useSections } from '../../hooks/useSections';
import DataTable from '../../components/DataTable';
import Modal from '../../components/Modal';
import { FormField } from '../../components/FormField';

const sectionSchema = Yup.object().shape({
  name: Yup.string()
    .min(2, 'Section name must be at least 2 characters')
    .max(100, 'Section name must be less than 100 characters')
    .required('Section name is required'),
  departmentId: Yup.string().required('Department is required')
});

const SectionsPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingSection, setEditingSection] = useState(null);
  const [error, setError] = useState('');
  
  const {
    sections,
    departments,
    loading,
    error: fetchError,
    fetchSections,
    fetchDepartments,
    createSection,
    updateSection,
    deleteSection
  } = useSections();

  useEffect(() => {
    fetchSections();
    fetchDepartments();
  }, [fetchSections, fetchDepartments]);

  const [initialValues, setInitialValues] = useState({ 
    name: '',
    departmentId: '' 
  });

  const handleAddSection = () => {
    setEditingSection(null);
    setInitialValues({ name: '', departmentId: '' });
    setError('');
    setIsModalOpen(true);
  };

  const handleEditSection = (section) => {
    setEditingSection(section);
    // Make sure department_id is a string for the select input
    setInitialValues({ 
      name: section.section_name || '',
      departmentId: section.department_id ? String(section.department_id) : ''
    });
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteSection = async (section) => {
    if (window.confirm(`Are you sure you want to delete "${section.section_name}"?`)) {
      const result = await deleteSection(section.section_id);
      if (!result.success) {
        setError(result.error);
      }
    }
  };

  const handleSubmit = async (values, { setSubmitting }) => {
    try {
      setError('');
      const sectionData = {
        name: values.name,
        departmentId: values.departmentId
      };

      if (editingSection) {
        await updateSection(editingSection.section_id, sectionData);
      } else {
        await createSection(sectionData);
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
      key: 'section',
      header: 'Section Name',
      accessor: 'section_name',
      render: (item) => item.section_name || 'N/A'
    },
    {
      key: 'department',
      header: 'Department',
      accessor: 'department_name',
      render: (item) => item.department_name || 'N/A'
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
              handleEditSection(item);
            }}
            className="text-blue-600 hover:text-blue-800"
            title="Edit"
          >
            <FiEdit2 />
          </button>
          <button
            onClick={(e) => {
              e.stopPropagation();
              handleDeleteSection(item);
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
        <h1 className="text-2xl font-bold">Sections</h1>
        <button
          onClick={handleAddSection}
          className="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md flex items-center"
        >
          <FiPlus className="mr-2" /> Add Section
        </button>
      </div>

      {(error || fetchError) && (
        <div className="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
          <p>{error || fetchError}</p>
        </div>
      )}

      <DataTable
        columns={columns}
        data={sections}
        loading={loading}
        emptyMessage="No sections found"
      />

      <Modal
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)}
        title={editingSection ? 'Edit Section' : 'Add New Section'}
      >
        <Formik
          initialValues={initialValues}
          validationSchema={sectionSchema}
          onSubmit={handleSubmit}
          enableReinitialize
        >
          {({ isSubmitting, values }) => (
            <Form className="space-y-4">
              <FormField
                name="name"
                label="Section Name"
                type="text"
                placeholder="Enter section name"
                required
              />
              
              <FormField
                name="departmentId"
                label="Department"
                as="select"
                icon={FiLayers}
                required
              >
                <option value="">Select a department</option>
                {departments.map((dept) => (
                  <option key={dept.department_id} value={String(dept.department_id)}>
                    {dept.department_name}
                  </option>
                ))}
              </FormField>

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
                    : editingSection
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

export default SectionsPage;
