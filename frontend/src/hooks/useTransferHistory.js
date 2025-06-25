import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useTransferHistory = () => {
  const [transfers, setTransfers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchTransfers = useCallback(async (filters = {}) => {
    try {
      setLoading(true);
      setError(null);

      let query = supabase
        .from('view_transfer_history_enriched')
        .select('*');

      // Apply filters
      if (filters.assetId) {
        query = query.eq('asset_id', filters.assetId);
      }
      if (filters.fromEmployeeName) {
        query = query.eq('from_employee_name', filters.fromEmployeeName);
      }
      if (filters.toEmployeeName) {
        query = query.eq('to_employee_name', filters.toEmployeeName);
      }
      if (filters.fromDepartmentName) {
        query = query.eq('from_department_name', filters.fromDepartmentName);
      }
      if (filters.toDepartmentName) {
        query = query.eq('to_department_name', filters.toDepartmentName);
      }
      if (filters.fromLocationName) {
        query = query.eq('from_location_name', filters.fromLocationName);
      }
      if (filters.toLocationName) {
        query = query.eq('to_location_name', filters.toLocationName);
      }
      if (filters.startDate) {
        query = query.gte('transfer_date', `${filters.startDate}T00:00:00`);
      }
      if (filters.endDate) {
        query = query.lte('transfer_date', `${filters.endDate}T23:59:59`);
      }

      // Order by transfer date descending by default
      query = query.order('transfer_date', { ascending: false });

      const { data, error } = await query;

      if (error) throw error;

      setTransfers(data);
      return data;
    } catch (err) {
      console.error('Error fetching transfer history:', err);
      setError(err.message);
      return [];
    } finally {
      setLoading(false);
    }
  }, []);

  const transferAsset = useCallback(async (transferData) => {
    try {
      setLoading(true);
      setError(null);

      // 1. Get the current asset data
      const { data: assetData, error: assetError } = await supabase
        .from('assets')
        .select('*')
        .eq('asset_id', transferData.assetId)
        .single();

      if (assetError) throw assetError;
      if (!assetData) throw new Error('Asset not found');

      // 2. Create the transfer history record
      const { data: transfer, error: transferError } = await supabase
        .from('transfer_history')
        .insert([{
          asset_id: transferData.assetId,
          make: assetData.make,
          model: assetData.model,
          from_employee_id: transferData.fromEmployeeId || null,
          to_employee_id: transferData.toEmployeeId || null,
          from_department_id: transferData.fromDepartmentId,
          to_department_id: transferData.toDepartmentId,
          from_location_id: transferData.fromLocationId,
          to_location_id: transferData.toLocationId,
          notes: transferData.notes || null,
        }])
        .select()
        .single();

      if (transferError) throw transferError;

      // 3. Update the asset with the new location/department/employee
      const { error: updateError } = await supabase
        .from('assets')
        .update({
          employee_id: transferData.toEmployeeId || null,
          department_id: transferData.toDepartmentId,
          location_id: transferData.toLocationId,
          status: transferData.toEmployeeId ? 'assigned' : 'in_stock',
          updated_at: new Date().toISOString(),
        })
        .eq('asset_id', transferData.assetId);

      if (updateError) throw updateError;

      // 4. Refresh the transfers list
      await fetchTransfers();
      
      return { success: true, data: transfer };
    } catch (err) {
      console.error('Error transferring asset:', err);
      setError(err.message);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  }, [fetchTransfers]);

  // Function to get transfer history for a specific asset
  const getAssetTransferHistory = useCallback(async (assetId) => {
    try {
      setLoading(true);
      setError(null);

      const { data, error } = await supabase
        .from('view_transfer_history_enriched')
        .select('*')
        .eq('asset_id', assetId)
        .order('transfer_date', { ascending: false });

      if (error) throw error;
      return data;
    } catch (err) {
      console.error('Error fetching asset transfer history:', err);
      setError(err.message);
      return [];
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    transfers,
    loading,
    error,
    fetchTransfers,
    transferAsset,
    getAssetTransferHistory,
  };
};

export default useTransferHistory;
