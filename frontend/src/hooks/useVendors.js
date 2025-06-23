import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useVendors = () => {
  const [vendors, setVendors] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchVendors = useCallback(async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('vendors')
        .select('*')
        .order('vendor_name', { ascending: true });

      if (error) throw error;
      setVendors(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching vendors:', err);
    } finally {
      setLoading(false);
    }
  }, []);

  const createVendor = async (vendorData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('vendors')
        .insert([{
          vendor_name: vendorData.name,
          contact_email: vendorData.email,
          phone: vendorData.phone,
          address: vendorData.address
        }])
        .select();

      if (error) throw error;
      await fetchVendors();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating vendor:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateVendor = async (id, vendorData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('vendors')
        .update({
          vendor_name: vendorData.name,
          contact_email: vendorData.email,
          phone: vendorData.phone,
          address: vendorData.address
        })
        .eq('vendor_id', id)
        .select();

      if (error) throw error;
      await fetchVendors();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating vendor:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteVendor = async (id) => {
    if (!window.confirm('Are you sure you want to delete this vendor?')) {
      return { success: false, error: 'Cancelled' };
    }

    try {
      setLoading(true);
      const { error } = await supabase
        .from('vendors')
        .delete()
        .eq('vendor_id', id);

      if (error) throw error;
      await fetchVendors();
      return { success: true };
    } catch (err) {
      console.error('Error deleting vendor:', err);
      return { 
        success: false, 
        error: err.message.includes('violates foreign key constraint')
          ? 'Cannot delete vendor as it is being used by other records.' 
          : err.message 
      };
    } finally {
      setLoading(false);
    }
  };

  return {
    vendors,
    loading,
    error,
    fetchVendors,
    createVendor,
    updateVendor,
    deleteVendor,
  };
};

export default useVendors;
