import { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';

export default function useProfiles() {
  const [profiles, setProfiles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchProfiles = async () => {
      setLoading(true);
      setError('');
      const { data, error } = await supabase.from('profiles').select('*').order('updated_at', { ascending: false });
      if (error) setError(error.message);
      else setProfiles(data);
      setLoading(false);
    };
    fetchProfiles();
  }, []);

  return { profiles, loading, error };
}
