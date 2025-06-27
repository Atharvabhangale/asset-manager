import React, { createContext, useContext, useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';

const AuthContext = createContext({});

export const useAuth = () => useContext(AuthContext);

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);

  // Fetch the user profile from the profiles table
  const fetchProfile = async (userId) => {
    console.log('fetchProfile called with userId:', userId);
    if (!userId) {
      console.log('No userId provided, setting profile to null');
      setProfile(null);
      return;
    }
    
    try {
      console.log('Fetching profile for user:', userId);
      const { data, error, status } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
      
      console.log('Profile fetch response:', { data, error, status });
      
      if (error) {
        console.error('Error fetching profile:', error);
        if (error.code === 'PGRST301' || error.code === 'PGRST116') {
          console.error('Possible RLS issue - check if RLS is enabled on profiles table');
        }
      }
      
      setProfile(data || null);
    } catch (err) {
      console.error('Exception in fetchProfile:', err);
      setProfile(null);
    }
  };

  useEffect(() => {
    // Get the current session (Supabase v2+)
    supabase.auth.getSession().then(({ data: { session } }) => {
      setUser(session?.user ?? null);
      if (session?.user) {
        fetchProfile(session.user.id);
      } else {
        setProfile(null);
      }
      setLoading(false);
    });

    // Listen for changes in auth state (Supabase v2+)
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setUser(session?.user ?? null);
      if (session?.user) {
        fetchProfile(session.user.id);
      } else {
        setProfile(null);
      }
      setLoading(false);
    });

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  // Sign up a new user
  const signUp = async (email, password) => {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: window.location.origin + '/dashboard',
      },
    });
    if (error) throw error;
    return data.user;
  };

  // Sign in an existing user
  const signIn = async (email, password) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (error) throw error;
    return data.user;
  };

  // Sign out the current user
  const signOut = async () => {
    const { error } = await supabase.auth.signOut();
    if (error) throw error;
  };

  const value = {
    signUp,
    signIn,
    signOut,
    user,
    profile, // <-- provide profile to consumers
    loading,
  };

  return (
    <AuthContext.Provider value={value}>
      {!loading && children}
    </AuthContext.Provider>
  );
};
