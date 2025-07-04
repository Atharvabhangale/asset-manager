import { useState, useCallback, useEffect } from 'react';
import { supabase } from '../supabaseClient';

export const useEmployees = () => {
  const [employees, setEmployees] = useState([]);
  const [departments, setDepartments] = useState([]);
  const [locations, setLocations] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchDepartments = useCallback(async () => {
    try {
      const { data, error } = await supabase
        .from('departments')
        .select('*')
        .order('department_name', { ascending: true });

      if (error) throw error;
      setDepartments(data || []);
    } catch (err) {
      console.error('Error fetching departments:', err);
      setError(err.message);
    }
  }, []);

  const fetchLocations = useCallback(async () => {
    try {
      const { data, error } = await supabase
        .from('locations')
        .select('*')
        .order('location_name', { ascending: true });

      if (error) throw error;
      setLocations(data || []);
    } catch (err) {
      console.error('Error fetching locations:', err);
      setError(err.message);
    }
  }, []);

  const fetchEmployees = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);
      console.log('Fetching employees with related data...');
      
      // Fetch employees with related department and location data
      const { data, error } = await supabase
        .from('employees')
        .select(`
          *,
          department:department_id (*),
          location:location_id (*)
        `)
        .order('employee_name', { ascending: true });

      if (error) {
        console.error('Supabase error:', error);
        throw error;
      }
      
      console.log('Fetched employees with related data:', data);
      
      // Transform the data to flatten the nested structure for easier access in the UI
      const transformedData = data.map(emp => ({
        ...emp,
        department: emp.department || null,
        location: emp.location || null
      }));
      
      setEmployees(transformedData || []);
      return transformedData || [];
    } catch (err) {
      console.error('Error in fetchEmployees:', err);
      setError(err.message);
      return [];
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchDepartments();
    fetchLocations();
    fetchEmployees();
  }, [fetchDepartments, fetchLocations, fetchEmployees]);

  const createEmployee = async (employeeData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('employees')
        .insert([{
          employee_name: employeeData.employee_name,
          email: employeeData.email,
          phone_no: employeeData.phone_no,
          department_id: employeeData.department_id,
          location_id: employeeData.location_id,
          role: employeeData.role || 'employee',
          employee_tag: employeeData.employee_tag
        }])
        .select();

      if (error) throw error;
      await fetchEmployees();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating employee:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateEmployee = async (id, employeeData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('employees')
        .update({
          employee_name: employeeData.employee_name,
          email: employeeData.email,
          phone_no: employeeData.phone_no,
          department_id: employeeData.department_id,
          location_id: employeeData.location_id,
          role: employeeData.role || 'employee',
          employee_tag: employeeData.employee_tag
        })
        .eq('employee_id', id)
        .select();

      if (error) throw error;
      await fetchEmployees();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating employee:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteEmployee = async (id) => {
    if (!window.confirm('Are you sure you want to delete this employee?')) {
      return { success: false, error: 'Cancelled' };
    }

    try {
      setLoading(true);
      const { error } = await supabase
        .from('employees')
        .delete()
        .eq('employee_id', id);

      if (error) throw error;
      await fetchEmployees();
      return { success: true };
    } catch (err) {
      console.error('Error deleting employee:', err);
      return { 
        success: false, 
        error: err.message.includes('violates foreign key constraint')
          ? 'Cannot delete employee as they are associated with other records.' 
          : err.message 
      };
    } finally {
      setLoading(false);
    }
  };

  return {
    employees,
    departments,
    locations,
    loading,
    error,
    fetchEmployees,
    fetchDepartments,
    fetchLocations,
    createEmployee,
    updateEmployee,
    deleteEmployee
  };
};

export default useEmployees;
