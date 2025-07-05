import React, { useState, useEffect } from 'react';
import { Formik, Form } from 'formik';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import * as Yup from 'yup';
import { useAuth } from '../context/AuthContext';
import { FormField } from '../components/FormField';

const Register = () => {
  const [error, setError] = useState('');
  const [success, setSuccess] = useState(false);
  const { signUp, user, profile, loading } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const from = location.state?.from?.pathname || '/dashboard';

  // Redirect if already logged in
  useEffect(() => {
    if (user && profile && !['admin','superadmin'].includes(profile.role)) {
      navigate(from, { replace: true });
    }
  }, [user, profile, navigate, from]);



  const handleSubmit = async (values, { setSubmitting, setFieldError }) => {
    try {
      setError('');
      // Use service role key for admin user creation (hobby project only)
      const { createClient } = await import('@supabase/supabase-js');
      const serviceSupabase = createClient(
        'http://127.0.0.1:54321',
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU'
      );
      const { data, error } = await serviceSupabase.auth.admin.createUser({
        email: values.email,
        password: values.password,
        user_metadata: {
          full_name: values.full_name,
          phone: values.phone,
          role: values.role
        },
        email_confirm: false
      });

      if (error) throw error;

      setSuccess(true); // Only show success message, do not update auth context or navigate
      // Do not navigate or update user/profile here
    } catch (err) {
      console.error('Sign up error:', err);
      const errorMessage = err.message || 'Failed to create account';
      setError(errorMessage);
      setFieldError('password', ' '); // Force error state on password field
    } finally {
      setSubmitting(false);
    }
  };

  const validationSchema = Yup.object().shape({
    full_name: Yup.string()
      .min(3, 'Full name must be at least 3 characters')
      .max(64, 'Full name too long')
      .required('Required'),
    email: Yup.string()
      .email('Invalid email address')
      .required('Email is required'),
    password: Yup.string()
      .min(8, 'Password must be at least 8 characters')
      .required('Password is required'),
    confirmPassword: Yup.string()
      .oneOf([Yup.ref('password'), null], 'Passwords must match')
      .required('Please confirm your password'),
  });

  if (loading || profile === null) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="text-gray-500">Loading...</div>
      </div>
    );
  }

  if (profile && !['admin','superadmin'].includes(profile.role)) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-50">
        <div className="bg-white p-8 rounded shadow">
          <h2 className="text-xl font-semibold text-gray-800">Not authorized</h2>
          <p className="mt-2 text-gray-600">You do not have permission to access this page.</p>
        </div>
      </div>
    );
  }

  if (success) {
    return (
      <div className="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
        <div className="sm:mx-auto sm:w-full sm:max-w-md">
          <div className="text-center">
            <svg
              className="mx-auto h-16 w-16 text-green-500"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
            <h2 className="mt-4 text-2xl font-bold text-gray-900">
              User has been added.
            </h2>
            <div className="mt-6">
              <button
                type="button"
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                onClick={() => {
                  setSuccess(false);
                  if (window.resetRegisterForm) window.resetRegisterForm();
                }}
              >
                Add another user
              </button>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div className="sm:mx-auto sm:w-full sm:max-w-md">
        <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
          Create a new account
        </h2>

      </div>

      <div className="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div className="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          {error && (
            <div className="mb-4 bg-red-50 border-l-4 border-red-400 p-4">
              <div className="flex">
                <div className="flex-shrink-0">
                  <svg className="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-11a1 1 0 10-2 0v4a1 1 0 102 0V7zm-1 8a1.5 1.5 0 110-3 1.5 1.5 0 010 3z" clipRule="evenodd" />
                  </svg>
                </div>
                <div className="ml-3">
                  <p className="text-sm text-red-700">{error}</p>
                </div>
              </div>
            </div>
          )}
          <Formik
            initialValues={{ full_name: '', email: '', password: '', confirmPassword: '' }}
            validationSchema={validationSchema}
            onSubmit={handleSubmit}
          >
            {({ isSubmitting, isValid, dirty, resetForm }) => {
              window.resetRegisterForm = resetForm;
              return (
                <Form className="space-y-6">
                  <div>
                    <FormField
                      label="Full name"
                      name="full_name"
                      type="text"
                      autoComplete="name"
                      placeholder="Enter full name"
                      required
                    />
                    <FormField
                      label="Email address"
                      name="email"
                      type="email"
                      autoComplete="email"
                      placeholder="you@example.com"
                      required
                    />
                    <FormField
                      label="Password"
                      name="password"
                      type="password"
                      autoComplete="new-password"
                      placeholder="••••••••"
                      required
                    />
                    <FormField
                      label="Confirm Password"
                      name="confirmPassword"
                      type="password"
                      autoComplete="new-password"
                      placeholder="••••••••"
                      required
                    />
                  </div>
                  <div>
                    <button
                      type="submit"
                      disabled={isSubmitting || !isValid || !dirty}
                      className={`group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white ${
                        isSubmitting || !isValid || !dirty
                          ? 'bg-blue-400 cursor-not-allowed'
                          : 'bg-blue-600 hover:bg-blue-700'
                      } focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500`}
                    >
                      {isSubmitting ? 'Creating account...' : 'Create account'}
                    </button>
                  </div>
                </Form>
              );
            }}
          </Formik>

        </div>
      </div>
    </div>
  );
};

export default Register;
