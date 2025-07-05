import React, { useEffect, useState } from 'react';
import { supabase } from '../supabaseClient';
import DataTable from '../components/DataTable';
import Modal from '../components/Modal';
import { Formik, Form, Field } from 'formik';
import * as Yup from 'yup';
import Button from '../components/Button';
import { useLocations } from '../hooks/useLocations';

const columns = [
  { key: 'username', header: 'Username' },
  { key: 'full_name', header: 'Full Name' },
  { key: 'email', header: 'Email' },
  { key: 'role', header: 'Role' },
  { key: 'location', header: 'Location', render: (row) => row.location_name || '-' },
  { key: 'updated_at', header: 'Updated At' },
];

const ROLE_OPTIONS = [
  { label: 'User', value: 'user' },
  { label: 'Master', value: 'master' },
  { label: 'Admin', value: 'admin' },
];

import { useAuth } from '../context/AuthContext';

export default function ProfilesPage() {
  const [profiles, setProfiles] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [selectedProfile, setSelectedProfile] = useState(null);
  const { locations, fetchLocations } = useLocations();
  const { profile } = useAuth();

  const openEditModal = (profile) => {
    setSelectedProfile(profile);
    setIsModalOpen(true);
  };

  const closeModal = () => {
    setIsModalOpen(false);
    setSelectedProfile(null);
  };

  const handleProfileUpdate = async (values, { setSubmitting }) => {
    const { error } = await supabase
      .from('profiles')
      .update({ role: values.role, location_id: values.location_id, updated_at: new Date().toISOString() })
      .eq('id', selectedProfile.id);

    setSubmitting(false);
    if (error) {
      alert(error.message);
      return;
    }
    // refresh list
    await fetchProfiles();
    closeModal();
  };

  const fetchProfiles = async () => {
    setLoading(true);
    setError('');
    // Join locations for display
    const { data, error } = await supabase
      .from('profiles')
      .select('*, locations(location_name)')
      .order('updated_at', { ascending: false });
    if (error) setError(error.message);
    else {
      let allProfiles = data.map(p => ({ ...p, location_name: p.locations?.location_name }));
      // Only filter for regular users
      if (profile && !['admin', 'superadmin'].includes(profile.role)) {
        allProfiles = allProfiles.filter(p => ['user', 'master'].includes(p.role) && p.id === profile.id);
      }
      setProfiles(allProfiles);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchProfiles();
    fetchLocations();
  }, []);

  return (
    <div className="py-10">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">User Profiles</h1>
        <div className="bg-white shadow rounded-lg p-6">
          <DataTable
            columns={columns}
            data={profiles}
            loading={loading}
            error={error}
            onEdit={openEditModal}
            rowKey="id"
          />
        </div>

        {isModalOpen && (
          <Modal isOpen={isModalOpen} onClose={closeModal} title="Edit Profile">
            <Formik
              initialValues={{
                role: selectedProfile?.role || '',
                location_id: selectedProfile?.location_id || '',
              }}
              enableReinitialize
              onSubmit={handleProfileUpdate}
            >
              {({ isSubmitting, values, setFieldValue }) => (
                <Form className="space-y-4">
                  <div>
                    <label htmlFor="role" className="block text-sm font-medium text-gray-700">
                      Role
                    </label>
                    <Field as="select" name="role" id="role" className="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                      <option value="">Select role</option>
                      {ROLE_OPTIONS.map((opt) => (
                        <option key={opt.value} value={opt.value}>
                          {opt.label}
                        </option>
                      ))}
                    </Field>
                  </div>
                  <div>
                    <label htmlFor="location_id" className="block text-sm font-medium text-gray-700">
                      Location
                    </label>
                    <Field as="select" name="location_id" id="location_id" className="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                      <option value="">Select location</option>
                      {locations.map((loc) => (
                        <option key={loc.location_id} value={loc.location_id}>
                          {loc.location_name}
                        </option>
                      ))}
                    </Field>
                  </div>
                  <div className="flex justify-end space-x-3">
                    <Button type="button" variant="secondary" onClick={closeModal}>
                      Cancel
                    </Button>
                    <Button type="submit" loading={isSubmitting}>
                      Save
                    </Button>
                  </div>
                </Form>
              )}
            </Formik>
          </Modal>
        )}
      </div>
    </div>
  );
}
