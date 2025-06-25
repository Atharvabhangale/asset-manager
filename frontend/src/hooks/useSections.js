import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useSections = () => {
  const [sections, setSections] = useState([]);
  const [departments, setDepartments] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchSections = useCallback(async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('view_sections_with_departments')
        .select('*')
        .order('department_name', { ascending: true })
        .order('section_name', { ascending: true });

      if (error) throw error;
      setSections(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching sections:', err);
    } finally {
      setLoading(false);
    }
  }, []);

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
      setError('Failed to load departments');
    }
  }, []);

  const createSection = async (sectionData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('sections')
        .insert([{
          section_name: sectionData.name,
          department_id: sectionData.departmentId
        }])
        .select();

      if (error) throw error;
      await fetchSections();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating section:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateSection = async (id, sectionData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('sections')
        .update({
          section_name: sectionData.name,
          department_id: sectionData.departmentId
        })
        .eq('section_id', id)
        .select();

      if (error) throw error;
      await fetchSections();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating section:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteSection = async (id) => {
    try {
      setLoading(true);
      const { error } = await supabase
        .from('sections')
        .delete()
        .eq('section_id', id);

      if (error) throw error;
      await fetchSections();
      return { success: true };
    } catch (err) {
      console.error('Error deleting section:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  return {
    sections,
    departments,
    loading,
    error,
    fetchSections,
    fetchDepartments,
    createSection,
    updateSection,
    deleteSection
  };
};

export default useSections;
