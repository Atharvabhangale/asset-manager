import React from 'react';
import { useNavigate } from 'react-router-dom';
import { FiMapPin, FiUsers, FiTruck, FiLayers, FiSettings, FiPlus } from 'react-icons/fi';

const Dashboard = () => {
  const navigate = useNavigate();
  
  const handleAddAsset = () => {
    navigate('/assets?action=add');
  };

  const menuItems = [
    {
      title: 'Locations',
      description: 'Manage office locations and sites',
      icon: <FiMapPin className="h-8 w-8 text-blue-500" />,
      path: '/locations',
      color: 'bg-blue-100',
    },
    {
      title: 'Departments',
      description: 'Manage departments and teams',
      icon: <FiUsers className="h-8 w-8 text-green-500" />,
      path: '/departments',
      color: 'bg-green-100',
    },
    {
      title: 'Employees',
      description: 'Manage employee information',
      icon: <FiUsers className="h-8 w-8 text-purple-500" />,
      path: '/employees',
      color: 'bg-purple-100',
    },
    {
      title: 'Vendors',
      description: 'Manage vendor information',
      icon: <FiTruck className="h-8 w-8 text-yellow-500" />,
      path: '/vendors',
      color: 'bg-yellow-100',
    },
    {
      title: 'Asset Types',
      description: 'Manage asset categories and types',
      icon: <FiLayers className="h-8 w-8 text-indigo-500" />,
      path: '/asset-types',
      color: 'bg-indigo-100',
    },
  ];

  return (
    <div className="py-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h1 className="text-3xl font-bold text-gray-900">Dashboard</h1>
        <p className="mt-2 text-sm text-gray-600">
          Welcome back! Manage your IT assets efficiently.
        </p>

        <div className="mt-8">
          <h2 className="text-lg font-medium text-gray-900 mb-4">Master Data Management</h2>
          <div className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-3">
            {menuItems.map((item) => (
              <a
                key={item.path}
                href={item.path}
                className="bg-white overflow-hidden shadow rounded-lg hover:shadow-md transition-shadow duration-200"
              >
                <div className="p-5">
                  <div className="flex items-center">
                    <div className={`flex-shrink-0 rounded-md p-3 ${item.color}`}>
                      {item.icon}
                    </div>
                    <div className="ml-5">
                      <h3 className="text-lg font-medium text-gray-900">{item.title}</h3>
                      <p className="mt-1 text-sm text-gray-500">{item.description}</p>
                    </div>
                  </div>
                </div>
              </a>
            ))}
          </div>
        </div>

        <div className="mt-12">
          <h2 className="text-lg font-medium text-gray-900 mb-4">Quick Actions</h2>
          <div className="bg-white shadow overflow-hidden sm:rounded-lg">
            <div className="px-4 py-5 sm:p-6">
              <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                <button 
                  onClick={handleAddAsset}
                  className="inline-flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-colors"
                >
                  <FiPlus className="mr-2 h-5 w-5" />
                  Add New Asset
                </button>
                <button className="inline-flex items-center justify-center px-4 py-3 border border-transparent text-sm font-medium rounded-md text-gray-700 bg-gray-100 hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500">
                  <FiSettings className="mr-2 h-5 w-5" />
                  View Reports
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
