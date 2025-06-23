import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useAssets = () => {
  const [assets, setAssets] = useState([]);
  const [assetTypes, setAssetTypes] = useState([]);
  const [locations, setLocations] = useState([]);
  const [departments, setDepartments] = useState([]);
  const [employees, setEmployees] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const fetchAssetTypes = useCallback(async () => {
    try {
      const { data, error } = await supabase
        .from('asset_types')
        .select('*')
        .order('asset_type_name', { ascending: true });
      if (error) throw error;
      setAssetTypes(data || []);
    } catch (err) {
      console.error('Error fetching asset types:', err);
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

  const fetchEmployees = useCallback(async () => {
    try {
      const { data, error } = await supabase
        .from('employees')
        .select('*')
        .order('employee_name', { ascending: true });
      if (error) throw error;
      setEmployees(data || []);
    } catch (err) {
      console.error('Error fetching employees:', err);
      setError(err.message);
    }
  }, []);

  const fetchAssets = useCallback(async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('assets')
        .select(`
          *,
          asset_types(asset_type_name),
          locations(location_name),
          departments(department_name),
          employees(employee_name)
        `)
        .order('asset_id', { ascending: false });

      if (error) throw error;
      setAssets(data || []);
    } catch (err) {
      setError(err.message);
      console.error('Error fetching assets:', err);
    } finally {
      setLoading(false);
    }
  }, []);

  const createAsset = async (assetData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('assets')
        .insert([{
          asset_type_id: assetData.assetTypeId,
          make: assetData.make,
          model: assetData.model,
          serial_number: assetData.serialNumber,
          status: assetData.status || 'in_stock',
          purchase_date: assetData.purchaseDate || null,
          warranty_expiry: assetData.warrantyExpiry || null,
          purchase_invoice_number: assetData.purchaseInvoiceNumber || null,
          order_number: assetData.orderNumber || null,
          location_id: assetData.locationId,
          department_id: assetData.departmentId,
          employee_id: assetData.employeeId || null,
          description: assetData.description || null,
          specification: assetData.specification || null,
          sap_reference: assetData.sapReference || null,
          blank_field_1: assetData.blankField1 || null,
          blank_field_2: assetData.blankField2 || null,
          blank_field_3: assetData.blankField3 || null,
        }])
        .select();

      if (error) throw error;
      await fetchAssets();
      return { success: true, data };
    } catch (err) {
      console.error('Error creating asset:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const updateAsset = async (id, assetData) => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('assets')
        .update({
          asset_type_id: assetData.assetTypeId,
          make: assetData.make,
          model: assetData.model,
          serial_number: assetData.serialNumber,
          status: assetData.status || 'in_stock',
          purchase_date: assetData.purchaseDate || null,
          warranty_expiry: assetData.warrantyExpiry || null,
          purchase_invoice_number: assetData.purchaseInvoiceNumber || null,
          order_number: assetData.orderNumber || null,
          location_id: assetData.locationId,
          department_id: assetData.departmentId,
          employee_id: assetData.employeeId || null,
          description: assetData.description || null,
          specification: assetData.specification || null,
          sap_reference: assetData.sapReference || null,
          blank_field_1: assetData.blankField1 || null,
          blank_field_2: assetData.blankField2 || null,
          blank_field_3: assetData.blankField3 || null,
        })
        .eq('asset_id', id)
        .select();

      if (error) throw error;
      await fetchAssets();
      return { success: true, data };
    } catch (err) {
      console.error('Error updating asset:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const deleteAsset = async (id) => {
    if (!window.confirm('Are you sure you want to delete this asset?')) {
      return { success: false, error: 'Cancelled' };
    }

    try {
      setLoading(true);
      const { error } = await supabase
        .from('assets')
        .delete()
        .eq('asset_id', id);

      if (error) throw error;
      await fetchAssets();
      return { success: true };
    } catch (err) {
      console.error('Error deleting asset:', err);
      return { 
        success: false, 
        error: err.message.includes('violates foreign key constraint')
          ? 'Cannot delete asset as it is referenced by other records.' 
          : err.message 
      };
    } finally {
      setLoading(false);
    }
  };

  return {
    assets,
    assetTypes,
    locations,
    departments,
    employees,
    loading,
    error,
    fetchAssets,
    fetchAssetTypes,
    fetchLocations,
    fetchDepartments,
    fetchEmployees,
    createAsset,
    updateAsset,
    deleteAsset,
  };
};

export default useAssets;
