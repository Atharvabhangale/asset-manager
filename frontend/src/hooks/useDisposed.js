import { useState, useCallback } from 'react';
import { supabase } from '../supabaseClient';

export const useDisposed = () => {
  const [disposedAssets, setDisposedAssets] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  const fetchDisposed = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      // Try view first, fallback to table
      let { data, error } = await supabase
        .from('view_disposed_assets_full')
        .select('*');

      if (error && error.code === '42P01') {
        // view not found, fallback
        const res = await supabase
          .from('disposed')
          .select('*');
        data = res.data;
        error = res.error;
      }

      if (error) throw error;
      setDisposedAssets(data || []);
      return data;
    } catch (err) {
      console.error('Error fetching disposed assets:', err);
      setError(err.message);
      return [];
    } finally {
      setLoading(false);
    }
  }, []);

  return {
    disposedAssets,
    loading,
    error,
    fetchDisposed,
  };
};

export default useDisposed;
