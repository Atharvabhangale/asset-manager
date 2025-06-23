import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useAssetTypes = () => {
  const [assetTypes, setAssetTypes] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchAssetTypes = useCallback(async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('asset_types')
        .select('*')
        .order('asset_type_name', { ascending: true });

      if (error) throw error;
      setAssetTypes(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching asset types:', err);
    } finally {
      setLoading(false);
    }
  }, []);

  const createAssetType = async (assetTypeData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('asset_types')
        .insert([{
          asset_type_name: assetTypeData.name,
          description: assetTypeData.description
        }])
        .select();

      if (error) throw error;
      await fetchAssetTypes();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating asset type:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateAssetType = async (id, assetTypeData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('asset_types')
        .update({
          asset_type_name: assetTypeData.name,
          description: assetTypeData.description
        })
        .eq('asset_type_id', id)
        .select();

      if (error) throw error;
      await fetchAssetTypes();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating asset type:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteAssetType = async (id) => {
    if (!window.confirm('Are you sure you want to delete this asset type?')) {
      return { success: false, error: 'Cancelled' };
    }

    try {
      setLoading(true);
      const { error } = await supabase
        .from('asset_types')
        .delete()
        .eq('asset_type_id', id);

      if (error) throw error;
      await fetchAssetTypes();
      return { success: true };
    } catch (err) {
      console.error('Error deleting asset type:', err);
      return { 
        success: false, 
        error: err.message.includes('violates foreign key constraint')
          ? 'Cannot delete asset type as it is being used by assets.' 
          : err.message 
      };
    } finally {
      setLoading(false);
    }
  };

  return {
    assetTypes,
    loading,
    error,
    fetchAssetTypes,
    createAssetType,
    updateAssetType,
    deleteAssetType,
  };
};

export default useAssetTypes;
