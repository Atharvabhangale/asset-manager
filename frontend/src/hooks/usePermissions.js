import React, { useState, useEffect, useCallback } from 'react';
import { supabase } from '../supabaseClient';

const TABLES = [
  'departments',
  'employees',
  'locations',
  'vendors',
  'asset_types',
  'assets',
  'stock',
  'disposed',
  'transfer_history',
  'sections',
  'sub_locations',
];

export default function usePermissions() {
  const [users, setUsers] = useState([]);
  const [permissions, setPermissions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Fetch all users
  const fetchUsers = useCallback(async () => {
    try {
      console.log('Fetching users...');
      const { data, error, status } = await supabase
        .from('profiles')
        .select('id, full_name, username, role');
      
      console.log('Users fetch status:', status, 'Data:', data);
      
      if (error) {
        console.error('Error in fetchUsers:', error);
        throw error;
      }
      
      setUsers(data || []);
      return { data, error: null };
    } catch (err) {
      console.error('Error in fetchUsers:', err);
      setError(err);
      return { data: null, error: err };
    }
  }, []);

  // Fetch all permissions
  const fetchPermissions = useCallback(async () => {
    try {
      console.log('Fetching permissions...');
      const { data, error, status } = await supabase
        .from('table_permissions')
        .select('*');
      
      console.log('Permissions fetch status:', status, 'Data:', data);
      
      if (error) {
        console.error('Error in fetchPermissions:', error);
        throw error;
      }
      
      setPermissions(data || []);
      return { data, error: null };
    } catch (err) {
      console.error('Error fetching permissions:', err);
      setError(err);
      return { data: null, error: err };
    }
  }, []);

  // Grant permission
  const grantPermission = async (userId, tableName, permission = 'all') => {
    try {
      setLoading(true);
      setError(null);
      
      const { error } = await supabase
        .from('table_permissions')
        .upsert(
          { user_id: userId, table_name: tableName, permission },
          { onConflict: 'user_id,table_name' }
        );
      
      if (error) throw error;
      await fetchPermissions();
      return { error: null };
    } catch (err) {
      console.error('Error granting permission:', err);
      setError(err);
      return { error: err };
    } finally {
      setLoading(false);
    }
  };

  // Revoke permission
  const revokePermission = async (userId, tableName) => {
    try {
      setLoading(true);
      setError(null);
      
      const { error } = await supabase
        .from('table_permissions')
        .delete()
        .eq('user_id', userId)
        .eq('table_name', tableName);
      
      if (error) throw error;
      await fetchPermissions();
      return { error: null };
    } catch (err) {
      console.error('Error revoking permission:', err);
      setError(err);
      return { error: err };
    } finally {
      setLoading(false);
    }
  };

  // Initial data load
  useEffect(() => {
    const loadData = async () => {
      setLoading(true);
      await Promise.all([fetchUsers(), fetchPermissions()]);
      setLoading(false);
    };
    
    loadData();
  }, [fetchUsers, fetchPermissions]);

  return {
    users,
    permissions,
    tables: TABLES,
    grantPermission,
    revokePermission,
    loading,
    error,
    refetch: () => {
      fetchUsers();
      fetchPermissions();
    },
    fetchUsers,
    fetchPermissions
  };
}
