import React, { useEffect } from 'react';
import usePermissions from '../../hooks/usePermissions';
import { useAuth } from '../../context/AuthContext';
import { useNavigate } from 'react-router-dom';

const PermissionsPage = () => {
  const { user: currentUser, profile } = useAuth();
  const navigate = useNavigate();
  const { 
    users,
    permissions,
    grantPermission, 
    revokePermission, 
    loading, 
    error, 
    fetchUsers, 
    fetchPermissions,
    tables: permissionTables
  } = usePermissions();

  // Check if current user is admin, if not redirect to dashboard
  useEffect(() => {
    if (typeof profile?.role === 'undefined') return; // wait for profile
    if (!['admin', 'superadmin'].includes(profile.role)) {
      navigate('/dashboard');
    }
  }, [profile, navigate]);

  // Fetch data on mount
  useEffect(() => {
    const loadData = async () => {
      await Promise.all([fetchUsers(), fetchPermissions()]);
    };
    loadData();
  }, [fetchUsers, fetchPermissions]);

  const hasPermission = (userId, table) => {
    return permissions.some(
      (perm) => 
        perm.user_id === userId && 
        perm.table_name === table && 
        (perm.permission === 'all' || perm.permission === 'write')
    );
  };

  const handleGrantPermission = async (userId, table) => {
    const { error } = await grantPermission(userId, table, 'all');
    if (!error) {
      await fetchPermissions();
    }
  };

  const handleRevokePermission = async (userId, table) => {
    const { error } = await revokePermission(userId, table);
    if (!error) {
      await fetchPermissions();
    }
  };

  if (loading && users.length === 0) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-blue-500"></div>
      </div>
    );
  }

  if (!['admin','superadmin'].includes(profile?.role)) {
    return null;
  }

  const tables = permissionTables || [];

  return (
    <div className="p-6">
      <div className="flex justify-between items-center mb-6">
        <h1 className="text-2xl font-bold">Manage Table Permissions</h1>
        <button
          onClick={() => {
            fetchUsers();
            fetchPermissions();
          }}
          disabled={loading}
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
        >
          Refresh
        </button>
      </div>
      
      {error && (
        <div className="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6" role="alert">
          <p className="font-bold">Error</p>
          <p>{error.message || 'An error occurred while loading permissions.'}</p>
        </div>
      )}

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  User
                </th>
                {tables.map((table) => (
                  <th 
                    key={table} 
                    className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                  >
                    {table.replace(/_/g, ' ')}
                  </th>
                ))}
              </tr>
            </thead>
            <tbody className="bg-white divide-y divide-gray-200">
              {users.map((user) => (
                <tr key={user.id} className="hover:bg-gray-50">
                  <td className="px-6 py-4 whitespace-nowrap">
                    <div className="flex items-center">
                      <div>
                        <div className="text-sm font-medium text-gray-900">
                          {user.full_name || user.username || user.email || user.id}
                        </div>
                        <div className="text-sm text-gray-500">
                          {user.role}
                        </div>
                      </div>
                    </div>
                  </td>
                  {tables.map((table) => {
                    const permitted = hasPermission(user.id, table);
                    return (
                      <td key={table} className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        {permitted ? (
                          <button
                            onClick={() => handleRevokePermission(user.id, table)}
                            disabled={loading}
                            className="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded text-red-700 bg-red-100 hover:bg-red-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 disabled:opacity-50"
                          >
                            Revoke
                          </button>
                        ) : (
                          <button
                            onClick={() => handleGrantPermission(user.id, table)}
                            disabled={loading}
                            className="inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded text-green-700 bg-green-100 hover:bg-green-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 disabled:opacity-50"
                          >
                            Grant
                          </button>
                        )}
                      </td>
                    );
                  })}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default PermissionsPage;
