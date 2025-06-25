import React, { useState, useEffect } from 'react';
import { Formik, Form, Field } from 'formik';
import * as Yup from 'yup';
import { 
  FiPlus, 
  FiEdit2, 
  FiTrash2, 
  FiPhone, 
  FiMail, 
  FiUser, 
  FiBriefcase, 
  FiMapPin,
  FiShield
} from 'react-icons/fi';
import { useEmployees } from '../../hooks/useEmployees';
import DataTable from '../../components/DataTable';
import Modal from '../../components/Modal';
import { FormField } from '../../components/FormField';

const employeeSchema = Yup.object().shape({
  employee_name: Yup.string()
    .min(2, 'Name must be at least 2 characters')
    .max(100, 'Name must be less than 100 characters')
    .required('Name is required'),
  email: Yup.string()
    .email('Invalid email address')
    .max(100, 'Email must be less than 100 characters')
    .required('Email is required'),
  phone_no: Yup.string()
    .max(20, 'Phone number must be less than 20 characters'),
  department_id: Yup.string().required('Department is required'),
  location_id: Yup.string().required('Location is required'),
  role: Yup.string()
    .oneOf(['admin', 'manager', 'employee'], 'Invalid role')
    .required('Role is required')
});

const EmployeesPage = () => {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editingEmployee, setEditingEmployee] = useState(null);
  const [error, setError] = useState('');
  
  const { 
    employees, 
    departments = [], 
    locations = [],
    loading, 
    error: fetchError, 
    fetchEmployees,
    createEmployee, 
    updateEmployee, 
    deleteEmployee 
  } = useEmployees();
  
  // Debug logs to check data loading
  useEffect(() => {
    console.log('Departments:', departments);
    console.log('Locations:', locations);
  }, [departments, locations]);

  useEffect(() => {
    fetchEmployees();
  }, [fetchEmployees]);

  const handleAddEmployee = () => {
    setEditingEmployee(null);
    setError('');
    setIsModalOpen(true);
  };

  const handleEditEmployee = (employee) => {
    setEditingEmployee(employee);
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteEmployee = async (employee) => {
    const result = await deleteEmployee(employee.employee_id);
    if (!result.success && result.error) {
      setError(result.error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setError('');
    setEditingEmployee(null);
  };

  const columns = [
    {
      key: 'employee_name',
      header: 'Name',
    },
    {
      key: 'email',
      header: 'Email',
    },
    {
      key: 'department_id',
      header: 'Department',
      render: (item) => item.department?.department_name || 'N/A',
    },
    {
      key: 'location_id',
      header: 'Location',
      render: (item) => item.location?.location_name || 'N/A',
    },
    {
      key: 'role',
      header: 'Role',
      render: (item) => (
        <span className={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${
          item.role === 'admin' 
            ? 'bg-purple-100 text-purple-800' 
            : item.role === 'manager'
            ? 'bg-blue-100 text-blue-800'
            : 'bg-green-100 text-green-800'
        }`}>
          {item.role.charAt(0).toUpperCase() + item.role.slice(1)}
        </span>
      ),
    },
  ];

  const initialValues = editingEmployee
    ? { 
        employee_name: editingEmployee.employee_name || '',
        email: editingEmployee.email || '',
        phone_no: editingEmployee.phone_no || '',
        department_id: editingEmployee.department_id || '',
        location_id: editingEmployee.location_id || '',
        role: editingEmployee.role || 'employee'
      }
    : { 
        employee_name: '', 
        email: '', 
        phone_no: '', 
        department_id: '',
        location_id: '',
        role: 'employee'
      };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold text-gray-800">Employees</h1>
        <button
          type="button"
          onClick={handleAddEmployee}
          className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
        >
          <FiPlus className="-ml-1 mr-2 h-5 w-5" />
          Add Employee
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
          key={employees.map(e => e.employee_id).join(',')}
          columns={columns}
          data={employees}
          loading={loading}
          onEdit={handleEditEmployee}
          onDelete={handleDeleteEmployee}
          emptyMessage="No employees found. Add your first employee to get started."
        />
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingEmployee ? 'Edit Employee' : 'Add New Employee'}
      >
        <Formik
          enableReinitialize
          initialValues={initialValues}
          validationSchema={employeeSchema}
          onSubmit={async (values, { setSubmitting, resetForm }) => {
            try {
              setError('');
              let result;
              
              if (editingEmployee) {
                result = await updateEmployee(editingEmployee.employee_id, values);
              } else {
                result = await createEmployee(values);
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
                <div className="relative mb-4">
                  <label htmlFor="employee_name" className="block text-sm font-medium text-gray-700 mb-1">
                    Full Name
                  </label>
                  <div className="relative rounded-md shadow-sm">
                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <FiUser className="h-5 w-5 text-gray-400" />
                    </div>
                    <Field
                      type="text"
                      id="employee_name"
                      name="employee_name"
                      placeholder="John Doe"
                      className="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-3 py-2 sm:text-sm border border-gray-300 rounded-md"
                      required
                    />
                  </div>
                </div>

                <div className="relative mb-4">
                  <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-1">
                    Email Address
                  </label>
                  <div className="relative rounded-md shadow-sm">
                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <FiMail className="h-5 w-5 text-gray-400" />
                    </div>
                    <Field
                      type="email"
                      id="email"
                      name="email"
                      placeholder="john.doe@example.com"
                      className="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-3 py-2 sm:text-sm border border-gray-300 rounded-md"
                      required
                    />
                  </div>
                </div>

                <div className="relative mb-4">
                  <label htmlFor="phone_no" className="block text-sm font-medium text-gray-700 mb-1">
                    Phone Number
                  </label>
                  <div className="relative rounded-md shadow-sm">
                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <FiPhone className="h-5 w-5 text-gray-400" />
                    </div>
                    <Field
                      type="tel"
                      id="phone_no"
                      name="phone_no"
                      placeholder="+1 (555) 123-4567"
                      className="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-3 py-2 sm:text-sm border border-gray-300 rounded-md"
                    />
                  </div>
                </div>

                <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                  <div className="relative mb-4">
                    <label htmlFor="department_id" className="block text-sm font-medium text-gray-700 mb-1">
                      Department
                    </label>
                    <div className="relative rounded-md shadow-sm">
                      <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <FiBriefcase className="h-5 w-5 text-gray-400" />
                      </div>
                      <Field
                        as="select"
                        id="department_id"
                        name="department_id"
                        className="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-10 py-2 sm:text-sm border border-gray-300 rounded-md"
                        required
                      >
                        <option value="">Select Department</option>
                        {departments && departments.length > 0 ? (
                          departments.map((dept) => (
                            <option key={dept.department_id} value={dept.department_id}>
                              {dept.department_name}
                            </option>
                          ))
                        ) : (
                          <option value="" disabled>No departments available</option>
                        )}
                      </Field>
                    </div>
                  </div>

                  <div className="relative mb-4">
                    <label htmlFor="location_id" className="block text-sm font-medium text-gray-700 mb-1">
                      Location
                    </label>
                    <div className="relative rounded-md shadow-sm">
                      <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                        <FiMapPin className="h-5 w-5 text-gray-400" />
                      </div>
                      <Field
                        as="select"
                        id="location_id"
                        name="location_id"
                        className="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-10 py-2 sm:text-sm border border-gray-300 rounded-md"
                        required
                      >
                        <option value="">Select Location</option>
                        {locations && locations.length > 0 ? (
                          locations.map((loc) => (
                            <option key={loc.location_id} value={loc.location_id}>
                              {loc.location_name}
                            </option>
                          ))
                        ) : (
                          <option value="" disabled>No locations available</option>
                        )}
                      </Field>
                    </div>
                  </div>
                </div>

                <div className="relative mb-4">
                  <label htmlFor="role" className="block text-sm font-medium text-gray-700 mb-1">
                    Role
                  </label>
                  <div className="relative rounded-md shadow-sm">
                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <FiShield className="h-5 w-5 text-gray-400" />
                    </div>
                    <Field
                      as="select"
                      id="role"
                      name="role"
                      className="focus:ring-blue-500 focus:border-blue-500 block w-full pl-10 pr-10 py-2 sm:text-sm border border-gray-300 rounded-md"
                      required
                    >
                      <option value="employee">Employee</option>
                      <option value="manager">Manager</option>
                      <option value="admin">Admin</option>
                    </Field>
                  </div>
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

export default EmployeesPage;
