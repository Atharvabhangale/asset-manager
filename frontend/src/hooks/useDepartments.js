import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useDepartments = () => {
  const [departments, setDepartments] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchDepartments = useCallback(async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('departments')
        .select('*')
        .order('department_name', { ascending: true });

      if (error) throw error;
      setDepartments(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching departments:', err);
    } finally {
      setLoading(false);
    }
  }, []);

  const createDepartment = async (departmentData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('departments')
        .insert([{
          department_name: departmentData.name
        }])
        .select();

      if (error) throw error;
      await fetchDepartments();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating department:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateDepartment = async (id, departmentData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('departments')
        .update({
          department_name: departmentData.name
        })
        .eq('department_id', id)
        .select();

      if (error) throw error;
      await fetchDepartments();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating department:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteDepartment = async (id) => {
    if (!window.confirm('Are you sure you want to delete this department?')) {
      return { success: false, error: 'Cancelled' };
    }

    try {
      setLoading(true);
      const { error } = await supabase
        .from('departments')
        .delete()
        .eq('department_id', id);

      if (error) throw error;
      await fetchDepartments();
      return { success: true };
    } catch (err) {
      console.error('Error deleting department:', err);
      return { 
        success: false, 
        error: err.message.includes('violates foreign key constraint')
          ? 'Cannot delete department as it is being used by other records.' 
          : err.message 
      };
    } finally {
      setLoading(false);
    }
  };

  return {
    departments,
    loading,
    error,
    fetchDepartments,
    createDepartment,
    updateDepartment,
    deleteDepartment,
    fetchDepartments
  };
};

export default useDepartments;
