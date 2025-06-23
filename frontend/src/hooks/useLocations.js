import { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';

export const useLocations = () => {
  const [locations, setLocations] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchLocations = async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('locations')
        .select('*')
        .order('location_name', { ascending: true });

      if (error) throw error;
      setLocations(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching locations:', err);
    } finally {
      setLoading(false);
    }
  };

  const createLocation = async (locationData) => {
    console.log('=== useLocations.createLocation called ===');
    console.log('Input locationData:', locationData);
    
    try {
      setLoading(true);
      console.log('Calling Supabase insert...');
      
      const { data, error } = await supabase
        .from('locations')
        .insert([{ location_name: locationData.name }])
        .select();

      console.log('Supabase response - data:', data, 'error:', error);
      
      if (error) {
        console.error('Supabase insert error:', error);
        throw error;
      }
      
      console.log('Insert successful, data:', data);
      console.log('Calling fetchLocations to refresh list...');
      await fetchLocations();
      
      return { success: true, data };
    } catch (err) {
      console.error('Error in createLocation:', {
        message: err.message,
        name: err.name,
        stack: err.stack
      });
      return { 
        success: false, 
        error: err.message,
        details: err
      };
    } finally {
      console.log('createLocation completed, setting loading to false');
      setLoading(false);
    }
  };

  const updateLocation = async (id, locationData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('locations')
        .update({ location_name: locationData.name })
        .eq('location_id', id)
        .select();

      if (error) throw error;
      await fetchLocations();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating location:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteLocation = async (id) => {
    if (!window.confirm('Are you sure you want to delete this location?')) {
      return { success: false, error: 'Cancelled' };
    }

    try {
      setLoading(true);
      const { error } = await supabase
        .from('locations')
        .delete()
        .eq('location_id', id);

      if (error) throw error;
      await fetchLocations();
      return { success: true };
    } catch (err) {
      console.error('Error deleting location:', err);
      return { 
        success: false, 
        error: err.message.includes('violates foreign key constraint') 
          ? 'Cannot delete location as it is being used by other records.' 
          : err.message 
      };
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchLocations();
  }, []);

  return {
    locations,
    loading,
    error,
    fetchLocations,
    createLocation,
    updateLocation,
    deleteLocation,
  };
};

export default useLocations;
