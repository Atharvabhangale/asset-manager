import { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';

export const useSubLocations = () => {
  const [subLocations, setSubLocations] = useState([]);
  const [locations, setLocations] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchSubLocations = async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('view_sub_locations')
        .select('*')
        .order('location_name')
        .order('sub_location_name');

      if (error) throw error;
      setSubLocations(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching sub-locations:', err);
    } finally {
      setLoading(false);
    }
  };

  const fetchLocations = async () => {
    try {
      const { data, error } = await supabase
        .from('locations')
        .select('*')
        .order('location_name');

      if (error) throw error;
      setLocations(data || []);
    } catch (err) {
      console.error('Error fetching locations:', err);
    }
  };

  const createSubLocation = async (subLocationData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('sub_locations')
        .insert([{
          location_id: subLocationData.location_id,
          sub_location_name: subLocationData.name
        }])
        .select();

      if (error) throw error;
      await fetchSubLocations();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating sub-location:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateSubLocation = async (id, updates) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('sub_locations')
        .update({
          location_id: updates.location_id,
          sub_location_name: updates.name
        })
        .eq('sub_location_id', id)
        .select();

      if (error) throw error;
      await fetchSubLocations();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating sub-location:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteSubLocation = async (id) => {
    try {
      setLoading(true);
      const { error } = await supabase
        .from('sub_locations')
        .delete()
        .eq('sub_location_id', id);

      if (error) throw error;
      await fetchSubLocations();
      return { success: true };
    } catch (err) {
      console.error('Error deleting sub-location:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchSubLocations();
    fetchLocations();
  }, []);

  return {
    subLocations,
    locations,
    loading,
    error,
    createSubLocation,
    updateSubLocation,
    deleteSubLocation,
    refetch: fetchSubLocations
  };
};

export default useSubLocations;
