import React, { useState, useEffect, useMemo } from 'react';
import { Formik, Form } from 'formik';
import { useSearchParams } from 'react-router-dom';
import * as Yup from 'yup';
import { FiPlus, FiEdit2, FiTrash2, FiSearch, FiX, FiFilter, FiInfo, FiCalendar, FiMapPin, FiDownload } from 'react-icons/fi';
import { useAuth } from '../context/AuthContext';

const getStatusBadgeClass = (status) => {
  switch (status) {
    case 'in_stock':
      return 'bg-green-100 text-green-800';
    case 'assigned':
      return 'bg-blue-100 text-blue-800';
    case 'in_maintenance':
      return 'bg-yellow-100 text-yellow-800';
    case 'retired':
      return 'bg-gray-200 text-gray-800';
    case 'disposed':
      return 'bg-red-100 text-red-800';
    default:
      return 'bg-gray-100 text-gray-800';
  }
};
import { useAssets } from '../hooks/useAssets';
import DataTable from '../components/DataTable';
import Modal from '../components/Modal';
import { FormField } from '../components/FormField';

const statusOptions = [
  { value: 'in_stock', label: 'In Stock' },
  { value: 'assigned', label: 'Assigned' },
  { value: 'in_maintenance', label: 'In Maintenance' },
  { value: 'retired', label: 'Retired' },
  { value: 'disposed', label: 'Disposed' }
];

const assetSchema = Yup.object().shape({
  assetTypeId: Yup.number().required('Asset type is required').typeError('Asset type is required'),
  make: Yup.string()
    .required('Make is required')
    .max(100, 'Make must be less than 100 characters'),
  model: Yup.string()
    .required('Model is required')
    .max(100, 'Model must be less than 100 characters'),
  serialNumber: Yup.string()
    .required('Serial number is required')
    .max(50, 'Serial number must be less than 50 characters'),
  hostname: Yup.string()
    .max(100, 'Hostname must be less than 100 characters'),
  status: Yup.string()
    .required('Status is required')
    .oneOf(statusOptions.map(opt => opt.value), 'Invalid status'),
  purchaseDate: Yup.string().required('Purchase date is required'),
  warrantyExpiry: Yup.string().required('Warranty expiry is required'),
  purchaseInvoiceNumber: Yup.string().required('Purchase invoice number is required'),
  orderNumber: Yup.string().required('Order number is required'),
  locationId: Yup.number().required('Location is required').typeError('Location is required'),
  subLocationId: Yup.number().nullable(),
  sectionId: Yup.number().nullable(),
  departmentId: Yup.number().required('Department is required').typeError('Department is required'),
  employeeId: Yup.number().nullable(),
  description: Yup.string().max(500, 'Description must be less than 500 characters'),
  specification: Yup.string().max(500, 'Specification must be less than 500 characters'),
  sapReference: Yup.string().max(50, 'SAP reference must be less than 50 characters'),
  blankField1: Yup.string().max(500, 'Field must be less than 500 characters'),
  blankField2: Yup.string().max(500, 'Field must be less than 500 characters'),
  blankField3: Yup.string().max(500, 'Field must be less than 500 characters'),
  remarks: Yup.string().max(1000, 'Remarks must be less than 1000 characters'),
});

const AssetsPage = () => {
  const { profile } = useAuth();
  const isSuperadmin = profile?.role === 'superadmin';
  const isAdmin = profile?.role === 'admin';
  const isElevated = isAdmin || isSuperadmin;
  const [searchParams, setSearchParams] = useSearchParams();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isViewModalOpen, setIsViewModalOpen] = useState(false);
  const [viewingAsset, setViewingAsset] = useState(null);
  const [editingAsset, setEditingAsset] = useState(null);

  // Get assets and other values from hook (single declaration)
  const {
    assets,
    assetTypes,
    locations,
    departments,
    employees,
    subLocations,
    sections,
    loading,
    fetchError,
    fetchAssets,
    fetchAssetTypes,
    fetchLocations,
    fetchDepartments,
    fetchEmployees,
    fetchSubLocations,
    fetchSections,
    createAsset,
    updateAsset,
    disposeAsset,
    deleteAsset,
  } = useAssets();
  // Alias for legacy code: sectionsData is used throughout
  const sectionsData = sections;
// NOTE: Remove ALL other duplicate destructuring of these variables from useAssets() throughout this file. They should only be declared ONCE here at the top of the component.
  // Only superadmin sees all assets; others see only their location's assets
  const visibleAssets = isSuperadmin ? assets : (profile?.location_id ? assets.filter(asset => asset.location_id === profile.location_id) : []);

  // Helper for initial values, using numbers for ID fields
  const getAssetInitialValues = () => {
    if (editingAsset) {
      return {
        assetTypeId: editingAsset.asset_type_id || null,
        make: editingAsset.make || '',
        model: editingAsset.model || '',
        serialNumber: editingAsset.serial_number || '',
        hostname: editingAsset.hostname || '',
        status: editingAsset.status || 'in_stock',
        locationId: editingAsset.location_id || null,
        subLocationId: editingAsset.sub_location_id || null,
        sectionId: editingAsset.section_id || null,
        departmentId: editingAsset.department_id || null,
        employeeId: editingAsset.employee_id || null,
        purchaseDate: editingAsset.purchase_date || '',
        warrantyExpiry: editingAsset.warranty_expiry || '',
        remarks: editingAsset.remarks || '',
        purchaseInvoiceNumber: editingAsset.purchase_invoice_number || '',
        orderNumber: editingAsset.order_number || '',
        sapReference: editingAsset.sap_reference || '',
        description: editingAsset.description || '',
        specification: editingAsset.specification || '',
        blankField1: editingAsset.blank_field_1 || '',
        blankField2: editingAsset.blank_field_2 || '',
        blankField3: editingAsset.blank_field_3 || '',
      };
    }
    return {
      assetTypeId: null,
      make: '',
      model: '',
      serialNumber: '',
      hostname: '',
      status: 'in_stock',
      locationId: null,
      subLocationId: null,
      sectionId: null,
      departmentId: null,
      employeeId: null,
      purchaseDate: '',
      warrantyExpiry: '',
      purchaseInvoiceNumber: '',
      orderNumber: '',
      sapReference: '',
      description: '',
      specification: '',
      blankField1: '',
      blankField2: '',
      blankField3: '',
    };
  };

  const [error, setError] = useState('');
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({
    searchTerm: '',
    status: 'all',
    typeId: '',
    make: '',
    model: '',
    locationId: '',
    subLocationId: '',
    sectionId: '',
    departmentId: '',
    employeeId: ''
  });
  const [activeFilter, setActiveFilter] = useState('all');
  const [allSections, setAllSections] = useState([]);
  const [filteredSections, setFilteredSections] = useState([]);
  const [allSubLocations, setAllSubLocations] = useState([]);
  const [filteredSubLocations, setFilteredSubLocations] = useState([]);
  

  // Filter sections based on selected department
  useEffect(() => {
    if (sectionsData) {
      setAllSections(sectionsData);
      
      // If we have a department filter or editing asset with department, filter sections
      if (filters.departmentId) {
        const filtered = sectionsData.filter(
          section => section.department_id === parseInt(filters.departmentId)
        );
        setFilteredSections(filtered);
      } else if (editingAsset?.department_id) {
        const filtered = sectionsData.filter(
          section => section.department_id === editingAsset.department_id
        );
        setFilteredSections(filtered);
      } else {
        setFilteredSections(sectionsData);
      }
    }
  }, [sectionsData, filters.departmentId, editingAsset?.department_id]);

  // Initialize data and set up filters
  useEffect(() => {
    const loadData = async () => {
      await Promise.all([
        fetchAssets(),
        fetchAssetTypes(),
        fetchLocations(),
        fetchDepartments(),
        fetchEmployees(),
        fetchSubLocations(),
        fetchSections(),
      ]);
      
      // Initialize sub-locations and sections after data is loaded
      if (subLocations) {
        setAllSubLocations(subLocations);
        setFilteredSubLocations(subLocations);
      }
      
      if (sectionsData) {
        setAllSections(sectionsData);
        setFilteredSections(sectionsData);
      }
    };
    
    const loadSections = async () => {
      try {
        await fetchSections();
      } catch (err) {
        console.error('Error fetching sections:', err);
      }
    };
    
    loadData();
    loadSections();
    
    // Set up effect to update filtered sections when sections data changes
    if (sectionsData) {
      setAllSections(sectionsData);
      setFilteredSections(sectionsData);
    }
    
    // Check for action query parameter
    const action = searchParams.get('action');
    if (action === 'add') {
      handleAddAsset();
      // Remove the query parameter after handling
      searchParams.delete('action');
      setSearchParams(searchParams);
    }
    
    // Check for filter query parameter
    const filter = searchParams.get('filter');
    if (filter === 'unassigned') {
      setActiveFilter('unassigned');
    }
  }, [fetchAssets, fetchAssetTypes, fetchLocations, fetchDepartments, fetchEmployees, searchParams, setSearchParams]);

  const handleAddAsset = () => {
    setEditingAsset(null);
    setError('');
    setIsModalOpen(true);
  };
  
  // Filter assets based on active filter and search term

  const handleEditAsset = (asset) => {
    setEditingAsset(asset);
    setError('');
    setIsModalOpen(true);
  };

  const handleDeleteAsset = async (asset) => {
    const result = await disposeAsset(asset.asset_id);
    if (!result.success && result.error) {
      setError(result.error);
    }
  };

  const handleCloseModal = () => {
    setIsModalOpen(false);
    setError('');
    setEditingAsset(null);
  };

  const handleViewAsset = (asset) => {
    setViewingAsset(asset);
    setIsViewModalOpen(true);
  };

  const handleCloseViewModal = () => {
    setIsViewModalOpen(false);
    setViewingAsset(null);
  };
  
  // Filter assets based on active filter and search filters
  const filteredAssets = visibleAssets.filter(asset => {
    // Apply sub-location filter (check both flat and nested properties)
    if (
      filters.subLocationId &&
      asset.sub_location_id?.toString() !== filters.subLocationId &&
      asset.sub_locations?.sub_location_id?.toString() !== filters.subLocationId
    ) {
      return false;
    }
    // Apply section filter (check both flat and nested properties)
    if (
      filters.sectionId &&
      asset.section_id?.toString() !== filters.sectionId &&
      asset.sections?.section_id?.toString() !== filters.sectionId
    ) {
      return false;
    }
    // Apply active filter (unassigned)
    if (activeFilter === 'unassigned' && asset.employee_id) {
      return false;
    }
    // Apply type filter (asset type)
    if (filters.typeId && asset.asset_type_id?.toString() !== filters.typeId && asset.asset_types?.asset_type_id?.toString() !== filters.typeId) {
      return false;
    }
    // Apply status filter
    if (filters.status !== 'all' && asset.status !== filters.status) {
      return false;
    }
    
    // Apply make filter
    if (filters.make && asset.make !== filters.make) {
      return false;
    }
    
    // Apply model filter
    if (filters.model && asset.model !== filters.model) {
      return false;
    }
    
    // Apply location filter
    if (filters.locationId &&
      asset.location_id?.toString() !== filters.locationId &&
      asset.locations?.location_id?.toString() !== filters.locationId
    ) {
      return false;
    }
    
    // Apply department filter
    if (filters.departmentId &&
      asset.department_id?.toString() !== filters.departmentId &&
      asset.departments?.department_id?.toString() !== filters.departmentId
    ) {
      return false;
    }
    
    // Apply employee filter
    if (filters.employeeId) {
      if (filters.employeeId === 'unassigned' && (asset.employee_id || asset.employees?.employee_id)) {
        return false;
      }
      if (
        filters.employeeId !== 'unassigned' &&
        asset.employee_id?.toString() !== filters.employeeId &&
        asset.employees?.employee_id?.toString() !== filters.employeeId
      ) {
        return false;
      }
    }
    
    // Apply search term if present
    if (filters.searchTerm) {
      const searchLower = filters.searchTerm.toLowerCase();
      return (
        (asset.make?.toLowerCase() || '').includes(searchLower) ||
        (asset.model?.toLowerCase() || '').includes(searchLower) ||
        (asset.serial_number?.toLowerCase() || '').includes(searchLower) ||
        (asset.asset_types?.asset_type_name || '').toLowerCase().includes(searchLower) ||
        (asset.locations?.location_name || '').toLowerCase().includes(searchLower) ||
        (asset.departments?.department_name || '').toLowerCase().includes(searchLower) ||
        (asset.employees?.employee_name || '').toLowerCase().includes(searchLower) ||
        (asset.employees?.employee_tag || '').toLowerCase().includes(searchLower) ||
        (asset.sub_locations?.sub_location_name || '').toLowerCase().includes(searchLower) ||
        (asset.sections?.section_name || '').toLowerCase().includes(searchLower)
      );
    }
    
    return true;
  });
  
  // Get unique makes and models for dropdowns
  const uniqueMakes = [...new Set(assets.map(asset => asset.make).filter(Boolean))].sort();
  const uniqueModels = useMemo(() => {
    if (!filters.make) {
      return [...new Set(assets.map(a => a.model).filter(Boolean))].sort();
    }
    return [...new Set(assets.filter(a => a.make === filters.make).map(a => a.model).filter(Boolean))].sort();
  }, [assets, filters.make]);
  
  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters(prev => ({
      ...prev,
      [name]: value,
      ...(name === 'make' ? { model: '' } : {})
    }));
  };
  
  const clearFilters = () => {
    setFilters({
      searchTerm: '',
      status: 'all',
      typeId: '',
      make: '',
      model: '',
      locationId: '',
      subLocationId: '',
      sectionId: '',
      departmentId: '',
      employeeId: ''
    });
    setActiveFilter('all');
  };

  const exportToCSV = () => {
    // Create CSV header
    const headers = [
      'ID', 'Type', 'Make', 'Model', 'Status', 'Serial Number', 
      'Location', 'Department', 'Assigned To', 'Purchase Date',
      'Warranty Expiry', 'Description', 'Specification', 'SAP Reference',
      'Sub-Location', 'Section'
    ];
    
    // Create CSV rows
    const rows = filteredAssets.map(asset => ({
      id: asset.asset_id,
      type: asset.asset_types?.asset_type_name || 'N/A',
      make: asset.make,
      model: asset.model,
      status: statusOptions.find(opt => opt.value === asset.status)?.label || asset.status,
      serialNumber: asset.serial_number,
      location: asset.locations?.location_name || 'N/A',
      department: asset.departments?.department_name || 'N/A',
      assignedTo: asset.employees?.employee_name || 'Unassigned',
      purchaseDate: asset.purchase_date ? new Date(asset.purchase_date).toLocaleDateString() : 'N/A',
      warrantyExpiry: asset.warranty_expiry ? new Date(asset.warranty_expiry).toLocaleDateString() : 'N/A',
      description: asset.description || 'N/A',
      specification: asset.specification || 'N/A',
      sapReference: asset.sap_reference || 'N/A',
      subLocation: asset.sub_locations?.sub_location_name || 'N/A',
      section: asset.sections?.section_name || 'N/A'
    }));
    
    // Convert to CSV format
    const csvContent = [
      headers.join(','),
      ...rows.map(row => 
        Object.values(row)
          .map(value => `"${String(value).replace(/"/g, '""')}"`)
          .join(',')
      )
    ].join('\n');
    
    // Create download link
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.setAttribute('href', url);
    link.setAttribute('download', `assets_export_${new Date().toISOString().split('T')[0]}.csv`);
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  const columns = [
    {
      key: 'asset_id',
      header: 'ID',
    },
    {
      key: 'locations.location_name',
      header: 'Location',
      render: (item) => item.locations?.location_name || 'N/A',
    },
    {
      key: 'asset_types.asset_type_name',
      header: 'Type',
      render: (item) => item.asset_types?.asset_type_name || 'N/A',
    },
    {
      key: 'make',
      header: 'Make',
    },
    {
      key: 'model',
      header: 'Model',
    },
    {
      key: 'hostname',
      header: 'Hostname',
    },
    {
      key: 'status',
      header: 'Status',
      render: (item) => (
        <span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${getStatusBadgeClass(item.status)}`}>
          {statusOptions.find(opt => opt.value === item.status)?.label || item.status}
        </span>
      ),
    },
    {
      key: 'serial_number',
      header: 'Serial Number',
    },
    {
      key: 'departments.department_name',
      header: 'Department',
      render: (item) => item.departments?.department_name || 'N/A',
    },
    {
      key: 'employees.employee_name',
      header: 'Assigned To',
      render: (item) => {
        const tag = item.employees?.employee_tag;
        const name = item.employees?.employee_name;
        if (tag && name) return `${tag} (${name})`;
        if (name) return name;
        return 'Unassigned';
      },
    },
    /*{
      key: 'description',
      header: 'Description',
    },
    {
      key: 'specification',
      header: 'Specification',
    },
    {
      key: 'remarks',
      header: 'Remarks',
    },
    {
      key: 'blankField1',
      header: 'Custom Field 1',
    },
    {
      key: 'blankField2',
      header: 'Custom Field 2',
    },
    {
      key: 'blankField3',
      header: 'Custom Field 3',
    },*/
  ];

  const initialValues = editingAsset
    ? {
        assetTypeId: editingAsset.asset_type_id.toString(),
        make: editingAsset.make,
        model: editingAsset.model,
        serialNumber: editingAsset.serial_number,
        hostname: editingAsset.hostname || '',
        status: editingAsset.status || 'in_stock',
        locationId: editingAsset.location_id.toString(),
        departmentId: editingAsset.department_id.toString(),
        employeeId: editingAsset.employee_id ? editingAsset.employee_id.toString() : '',
        description: editingAsset.description || '',
        specification: editingAsset.specification || '',
        sapReference: editingAsset.sap_reference || '',
        blankField1: editingAsset.blank_field_1 || '',
        blankField2: editingAsset.blank_field_2 || '',
        blankField3: editingAsset.blank_field_3 || '',
        remarks: editingAsset.remarks || '',
      }
    : {
        assetTypeId: '',
        make: '',
        model: '',
        serialNumber: '',
        hostname: '',
        status: 'in_stock',
        purchaseDate: '',
        warrantyExpiry: '',
        purchaseInvoiceNumber: '',
        orderNumber: '',
        locationId: '',
        departmentId: '',
        employeeId: '',
        description: '',
        specification: '',
        sapReference: '',
        blankField1: '',
        blankField2: '',
        blankField3: '',
        remarks: '',
      };

  return (
    <div className="container mx-auto px-4 py-8">
      <div className="mb-6">
        <div className="flex flex-col md:flex-row md:justify-between md:items-center mb-4 gap-4">
          <h1 className="text-2xl font-bold text-gray-800">Assets</h1>
          <div className="flex flex-col sm:flex-row gap-4 w-full md:w-auto">
            <div className="relative flex-grow md:flex-grow-0 md:w-64">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <FiSearch className="h-5 w-5 text-gray-400" />
              </div>
              <input
                type="text"
                name="searchTerm"
                placeholder="Search assets..."
                className="block w-full pl-10 pr-3 py-2 border border-gray-300 rounded-md leading-5 bg-white placeholder-gray-500 focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                value={filters.searchTerm}
                onChange={handleFilterChange}
              />
            </div>
            
            <div className="flex space-x-2">
              <button
                type="button"
                onClick={exportToCSV}
                className="inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm leading-4 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                title="Export to CSV"
              >
                <FiDownload className="mr-2 h-4 w-4" />
                Export
              </button>
              
              <button
                type="button"
                onClick={() => setShowFilters(!showFilters)}
                className="inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm leading-4 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
              >
                <FiFilter className="mr-2 h-4 w-4" />
                {showFilters ? 'Hide Filters' : 'Filters'}
              </button>
              

              
              <button
                type="button"
                onClick={handleAddAsset}
                className="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 whitespace-nowrap"
              >
                <FiPlus className="-ml-1 mr-2 h-5 w-5" />
                Add Asset
              </button>
            </div>
          </div>
        </div>
        
        {/* Advanced Filters */}
        {showFilters && (
          <div className="bg-white p-4 rounded-lg shadow-sm border border-gray-200 mb-4">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Type</label>
                <select
                  name="typeId"
                  value={filters.typeId}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Types</option>
                  {assetTypes.map(type => (
                    <option key={type.asset_type_id} value={type.asset_type_id}>
                      {type.asset_type_name}
                    </option>
                  ))}
                </select>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
                <select
                  name="status"
                  value={filters.status}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="all">All Statuses</option>
                  {statusOptions.map(option => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Make</label>
                <select
                  name="make"
                  value={filters.make}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Makes</option>
                  {uniqueMakes.map(make => (
                    <option key={make} value={make}>
                      {make}
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Model</label>
                <select
                  name="model"
                  value={filters.model}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                  disabled={!filters.make}
                >
                  <option value="">{filters.make ? 'All Models' : 'Select make first'}</option>
                  {uniqueModels.map(model => (
                    <option key={model} value={model}>
                      {model}
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Location</label>
                <select
                  name="locationId"
                  value={filters.locationId}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Locations</option>
                  {locations.map(location => (
                    <option key={location.location_id} value={location.location_id}>
                      {location.location_name}
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Department</label>
                <select
                  name="departmentId"
                  value={filters.departmentId}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Departments</option>
                  {departments.map(dept => (
                    <option key={dept.department_id} value={dept.department_id}>
                      {dept.department_name}
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Assigned To</label>
                <select
                  name="employeeId"
                  value={filters.employeeId}
                  onChange={handleFilterChange}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Assignments</option>
                  <option value="unassigned">Unassigned</option>
                  {employees.map(employee => (
                    <option key={employee.employee_id} value={employee.employee_id}>
                      {employee.employee_tag ? `${employee.employee_tag} (${employee.employee_name})` : employee.employee_name}
                    </option>
                  ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Sub-Location</label>
                <select
                  name="subLocationId"
                  value={filters.subLocationId}
                  onChange={handleFilterChange}
                  disabled={!filters.locationId}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Sub-Locations</option>
                  {subLocations
                    .filter(sub => !filters.locationId || sub.location_id.toString() === filters.locationId)
                    .map(sub => (
                      <option key={sub.sub_location_id} value={sub.sub_location_id}>
                        {sub.sub_location_name}
                      </option>
                    ))}
                </select>
              </div>
              
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Section</label>
                <select
                  name="sectionId"
                  value={filters.sectionId}
                  onChange={handleFilterChange}
                  disabled={!filters.departmentId}
                  className="w-full p-2 border rounded-md"
                >
                  <option value="">All Sections</option>
                  {sectionsData
                    .filter(section => !filters.departmentId || section.department_id.toString() === filters.departmentId)
                    .map(section => (
                      <option key={section.section_id} value={section.section_id}>
                        {section.section_name}
                      </option>
                    ))}
                </select>
              </div>
              
              <div className="flex items-end">
                <button
                  type="button"
                  onClick={clearFilters}
                  className="w-full px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                >
                  Reset
                </button>
              </div>
            </div>
          </div>
        )}
        
        {/* Active Filters */}
        <div className="flex flex-wrap gap-2 mt-2">
          {filters.status !== 'all' && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-indigo-100 text-indigo-800">
              Status: {statusOptions.find(o => o.value === filters.status)?.label}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, status: 'all' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-indigo-600 hover:text-indigo-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.make && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
              Make: {filters.make}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, make: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-blue-600 hover:text-blue-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.model && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">
              Model: {filters.model}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, model: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-green-600 hover:text-green-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.locationId && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800">
              Location: {locations.find(l => l.location_id.toString() === filters.locationId)?.location_name}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, locationId: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-purple-600 hover:text-purple-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.departmentId && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
              Department: {departments.find(d => d.department_id.toString() === filters.departmentId)?.department_name}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, departmentId: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-yellow-600 hover:text-yellow-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.employeeId && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-pink-100 text-pink-800">
              {filters.employeeId === 'unassigned' 
                ? 'Unassigned'
                : (() => {
                    const emp = employees.find(e => e.employee_id.toString() === filters.employeeId);
                    return emp ? `${emp.employee_tag ? `${emp.employee_tag} (` : ''}${emp.employee_name}${emp.employee_tag ? ')' : ''}` : 'Assigned';
                  })()}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, employeeId: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-pink-600 hover:text-pink-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.subLocationId && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-cyan-100 text-cyan-800">
              Sub-Location: {subLocations.find(s => s.sub_location_id.toString() === filters.subLocationId)?.sub_location_name}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, subLocationId: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-cyan-600 hover:text-cyan-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
          
          {filters.sectionId && (
            <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-amber-100 text-amber-800">
              Section: {sectionsData.find(s => s.section_id.toString() === filters.sectionId)?.section_name}
              <button 
                type="button" 
                onClick={() => setFilters(prev => ({ ...prev, sectionId: '' }))}
                className="ml-1.5 inline-flex items-center justify-center flex-shrink-0 h-4 w-4 text-amber-600 hover:text-amber-900 focus:outline-none"
              >
                <FiX className="h-3 w-3" />
              </button>
            </span>
          )}
        </div>
      </div>

      {fetchError && (
        <div className="bg-red-50 border-l-4 border-red-400 p-4 mb-6">
          <div className="flex">
            <div className="flex-shrink-0">
              <svg className="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
              </svg>
            </div>
            <div className="ml-3">
              <p className="text-sm text-red-700">{fetchError}</p>
            </div>
          </div>
        </div>
      )}

      <div className="bg-white shadow overflow-hidden sm:rounded-lg">
        <DataTable
          key={filteredAssets.map(a => a.asset_id).join(',')}
          columns={columns}
          data={filteredAssets}
          loading={loading}
          onView={handleViewAsset}
          onEdit={handleEditAsset}
          onDelete={handleDeleteAsset}
          emptyMessage="No assets found. Add your first asset to get started."
        />
      </div>

      <Modal
        isOpen={isModalOpen}
        onClose={handleCloseModal}
        title={editingAsset ? 'Edit Asset' : 'Add New Asset'}
        size="xl"
      >
        <Formik
          enableReinitialize
          initialValues={{
            assetTypeId: editingAsset ? editingAsset.asset_type_id?.toString() : '',
            make: editingAsset ? editingAsset.make : '',
            model: editingAsset ? editingAsset.model : '',
            serialNumber: editingAsset ? editingAsset.serial_number : '',
            hostname: editingAsset ? editingAsset.hostname || '' : '',
            status: editingAsset ? editingAsset.status : 'in_stock',
            purchaseDate: editingAsset ? editingAsset.purchase_date : '',
            warrantyExpiry: editingAsset ? editingAsset.warranty_expiry : '',
            purchaseInvoiceNumber: editingAsset ? editingAsset.purchase_invoice_number : '',
            orderNumber: editingAsset ? editingAsset.order_number : '',
            locationId: editingAsset ? editingAsset.location_id?.toString() : '',
            subLocationId: editingAsset ? editingAsset.sub_location_id?.toString() : '',
            sectionId: editingAsset ? editingAsset.section_id?.toString() : '',
            departmentId: editingAsset ? editingAsset.department_id?.toString() : '',
            employeeId: editingAsset && editingAsset.employee_id ? editingAsset.employee_id.toString() : '',
            description: editingAsset && editingAsset.description !== null && editingAsset.description !== undefined ? editingAsset.description : '',
            specification: editingAsset && editingAsset.specification !== null && editingAsset.specification !== undefined ? editingAsset.specification : '',
            sapReference: editingAsset ? editingAsset.sap_reference : '',
            blankField1: editingAsset && editingAsset.blank_field_1 !== null && editingAsset.blank_field_1 !== undefined ? editingAsset.blank_field_1 : '',
            blankField2: editingAsset && editingAsset.blank_field_2 !== null && editingAsset.blank_field_2 !== undefined ? editingAsset.blank_field_2 : '',
            blankField3: editingAsset && editingAsset.blank_field_3 !== null && editingAsset.blank_field_3 !== undefined ? editingAsset.blank_field_3 : '',
            remarks: editingAsset && editingAsset.remarks !== null && editingAsset.remarks !== undefined ? editingAsset.remarks : '',
          }}
          validationSchema={assetSchema}
          onSubmit={async (values, { setSubmitting, resetForm }) => {
            try {
              setError('');
              let result;
              
              const assetData = {
                assetTypeId: parseInt(values.assetTypeId, 10),
                make: values.make,
                model: values.model,
                serialNumber: values.serialNumber,
                hostname: values.hostname,
                status: values.status,
                purchaseDate: values.purchaseDate || null,
                warrantyExpiry: values.warrantyExpiry || null,
                purchaseInvoiceNumber: values.purchaseInvoiceNumber || null,
                orderNumber: values.orderNumber || null,
                locationId: parseInt(values.locationId, 10),
                departmentId: parseInt(values.departmentId, 10),
                employeeId: values.employeeId ? parseInt(values.employeeId, 10) : null,
                description: values.description,
                specification: values.specification,
                sapReference: values.sapReference,
                blankField1: values.blankField1,
                blankField2: values.blankField2,
                blankField3: values.blankField3,
                remarks: values.remarks,
                subLocationId: values.subLocationId ? parseInt(values.subLocationId, 10) : null,
                sectionId: values.sectionId ? parseInt(values.sectionId, 10) : null,
              };
              
              if (editingAsset) {
                result = await updateAsset(editingAsset.asset_id, assetData);
              } else {
                result = await createAsset(assetData);
              }
              
              if (result.success) {
                handleCloseModal();
                resetForm();
              } else {
                throw new Error(result.error || 'An error occurred');
              }
            } catch (err) {
              setError(err.message);
            } finally {
              setSubmitting(false);
            }
          }}
        >
          {({ isSubmitting, values, setFieldValue, setFieldTouched }) => {
            // Effect to update filtered sub-locations when location changes
            useEffect(() => {
              if (!subLocations) return;
              
              if (values.locationId) {
                const filtered = subLocations.filter(
                  sub => sub.location_id === parseInt(values.locationId, 10)
                );
                setFilteredSubLocations(filtered);
                // Reset subLocationId if it's not in the filtered list
                if (values.subLocationId && !filtered.some(s => s.sub_location_id.toString() === values.subLocationId)) {
                  setFieldValue('subLocationId', '');
                  setFieldTouched('subLocationId', false);
                }
              } else {
                setFilteredSubLocations(subLocations);
                setFieldValue('subLocationId', '');
              }
            }, [values.locationId, subLocations, setFieldValue, setFieldTouched]);
            
            // Effect to update filtered sections when department changes
            useEffect(() => {
              if (!sectionsData) return;
              
              if (values.departmentId) {
                const filtered = sectionsData.filter(
                  section => section.department_id === parseInt(values.departmentId, 10)
                );
                setFilteredSections(filtered);
                // Reset sectionId if it's not in the filtered list
                if (values.sectionId && !filtered.some(s => s.section_id.toString() === values.sectionId)) {
                  setFieldValue('sectionId', '');
                  setFieldTouched('sectionId', false);
                }
              } else {
                setFilteredSections(sectionsData);
                setFieldValue('sectionId', '');
              }
            }, [values.departmentId, sectionsData, setFieldValue, setFieldTouched]);
            
            return (
            <Form className="space-y-4">
              {error && (
                <div className="mb-4 bg-red-50 border-l-4 border-red-400 p-4">
                  <div className="flex">
                    <div className="flex-shrink-0">
                      <svg className="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                        <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                      </svg>
                    </div>
                    <div className="ml-3">
                      <p className="text-sm text-red-700">{error}</p>
                    </div>
                  </div>
                </div>
              )}
              
              <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div className="col-span-2">
                  <h3 className="text-lg font-medium text-gray-900 mb-3">Basic Information</h3>
                </div>
                
                <FormField
                  label="Asset Type"
                  name="assetTypeId"
                  as="select"
                >
                  <option value={null}>Select an asset type</option>
                  {assetTypes.map((type) => (
                    <option key={type.asset_type_id} value={type.asset_type_id}>
                      {type.asset_type_name}
                    </option>
                  ))}
                </FormField>

                
                <FormField
                  label="Make"
                  name="make"
                  type="text"
                  placeholder="e.g., Dell, HP, Lenovo"
                  required
                />
                
                <FormField
                  label="Model"
                  name="model"
                  type="text"
                  placeholder="e.g., XPS 15, ThinkPad X1"
                  required
                />
                
                <FormField
                  label="Hostname"
                  name="hostname"
                  type="text"
                  placeholder="e.g., LAPTOP-12345"
                />
                
                <FormField
                  label="Status"
                  name="status"
                  as="select"
                  required
                >
                  {statusOptions.map((option) => (
                    <option key={option.value} value={option.value}>
                      {option.label}
                    </option>
                  ))}
                </FormField>
                
                <FormField
                  label="Serial Number"
                  name="serialNumber"
                  type="text"
                  placeholder="Enter unique serial number"
                  required
                />
                
                <FormField
                  label="Purchase Date"
                  name="purchaseDate"
                  type="date"
                />
                
                <FormField
                  label="Warranty Expiry"
                  name="warrantyExpiry"
                  type="date"
                />
                
                <FormField
                  label="Purchase Invoice #"
                  name="purchaseInvoiceNumber"
                  type="text"
                  placeholder="Invoice number"
                />
                
                <FormField
                  label="Order Number"
                  name="orderNumber"
                  type="text"
                  placeholder="Order reference"
                />
                
                <FormField
                  label="SAP Reference"
                  name="sapReference"
                  type="text"
                  placeholder="SAP reference code"
                />
                
                <div className="col-span-2">
                  <h3 className="text-lg font-medium text-gray-900 mb-3 mt-6">Assignment</h3>
                </div>
                
                <FormField
                  label="Sub-Location"
                  name="subLocationId"
                  as="select"
                  disabled={!values.locationId}
                >
                  <option value="">Select a sub-location</option>
                  {filteredSubLocations?.map((sub) => (
                    <option key={sub.sub_location_id} value={sub.sub_location_id}>
                      {sub.sub_location_name}
                    </option>
                  ))}
                </FormField>

                <FormField
                  label="Department"
                  name="departmentId"
                  as="select"
                >
                  <option value={null}>Select a department</option>
                  {departments.map((dept) => (
                    <option key={dept.department_id} value={dept.department_id}>
                      {dept.department_name}
                    </option>
                  ))}
                </FormField>

                <FormField
                  label="Section"
                  name="sectionId"
                  as="select"
                  disabled={!values.departmentId}
                >
                  <option value="">Select a section</option>
                  {filteredSections.map((sec) => (
                    <option key={sec.section_id} value={sec.section_id}>
                      {sec.section_name}
                    </option>
                  ))}
                </FormField>
                
                <FormField
                  label="Assigned To (Optional)"
                  name="employeeId"
                  as="select"
                >
                  <option value="">Unassigned</option>
                  {employees.map((employee) => (
                    <option key={employee.employee_id} value={employee.employee_id}>
                      {employee.employee_name}
                    </option>
                  ))}
                </FormField>
                
                <div className="col-span-2">
                  <h3 className="text-lg font-medium text-gray-900 mb-3 mt-6">Additional Information</h3>
                </div>
                
                <FormField
                  label="Description"
                  name="description"
                  as="textarea"
                  rows={3}
                  placeholder="Asset description"
                  className="mb-4"
                />
                {isElevated && (
                <FormField
                  label="Remarks"
                  name="remarks"
                  as="textarea"
                  rows={3}
                  placeholder="Remarks"
                  className="mb-4"
                />
                )}
                
                <FormField
                  label="Specifications"
                  name="specification"
                  as="textarea"
                  rows={3}
                  placeholder="Technical specifications"
                />
                
                <FormField
                  label="Custom Field 1"
                  name="blankField1"
                  type="text"
                  placeholder="Custom field 1"
                />
                
                <FormField
                  label="Custom Field 2"
                  name="blankField2"
                  type="text"
                  placeholder="Custom field 2"
                />
                
                <FormField
                  label="Custom Field 3"
                  name="blankField3"
                  type="text"
                  placeholder="Custom field 3"
                />
              </div>
              
              <div className="mt-6 flex justify-end space-x-3">
                <button
                  type="button"
                  onClick={handleCloseModal}
                  className="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                >
                  {isSubmitting ? 'Saving...' : 'Save Asset'}
                </button>
              </div>
            </Form>
          );
          }}
        </Formik>
      </Modal>

      {/* View Asset Modal */}
      <Modal
        isOpen={isViewModalOpen}
        onClose={handleCloseViewModal}
        title="Asset Details"
        size="xl"
      >
        {viewingAsset && (
          <div className="space-y-6">
            <div className="bg-white shadow overflow-hidden sm:rounded-lg">
              <div className="px-4 py-5 sm:px-6 bg-gray-50">
                <h3 className="text-lg leading-6 font-medium text-gray-900">
                  {viewingAsset.make} {viewingAsset.model}
                  <span className="ml-3 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                    {statusOptions.find(opt => opt.value === viewingAsset.status)?.label || viewingAsset.status}
                  </span>
                </h3>
                <p className="mt-1 max-w-2xl text-sm text-gray-500">
                  Asset ID: {viewingAsset.asset_id} • {viewingAsset.asset_types?.asset_type_name || 'N/A'}
                </p>
              </div>
              <div className="border-t border-gray-200 px-4 py-5 sm:p-0">
                <dl className="sm:divide-y sm:divide-gray-200">
                  <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt className="text-sm font-medium text-gray-500 flex items-center">
                      <FiInfo className="mr-2 h-4 w-4 text-gray-400" />
                      Basic Information
                    </dt>
                    <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 space-y-4">
                      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                          <p className="text-xs text-gray-500">Serial Number</p>
                          <p>{viewingAsset.serial_number || 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">SAP Reference</p>
                          <p>{viewingAsset.sap_reference || 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Hostname</p>
                          <p>{viewingAsset.hostname || 'N/A'}</p>
                        </div>
                      </div>
                    </dd>
                  </div>
                  
                  <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt className="text-sm font-medium text-gray-500 flex items-center">
                      <FiCalendar className="mr-2 h-4 w-4 text-gray-400" />
                      Purchase Details
                    </dt>
                    <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 space-y-4">
                      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                          <p className="text-xs text-gray-500">Purchase Date</p>
                          <p>{viewingAsset.purchase_date ? new Date(viewingAsset.purchase_date).toLocaleDateString() : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Warranty Expiry</p>
                          <p>{viewingAsset.warranty_expiry ? new Date(viewingAsset.warranty_expiry).toLocaleDateString() : 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Invoice Number</p>
                          <p>{viewingAsset.purchase_invoice_number || 'N/A'}</p>
                        </div>
                      </div>
                    </dd>
                  </div>
                  
                  <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                    <dt className="text-sm font-medium text-gray-500 flex items-center">
                      <FiMapPin className="mr-2 h-4 w-4 text-gray-400" />
                      Location
                    </dt>
                    <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 space-y-4">
                      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                          <p className="text-xs text-gray-500">Location</p>
                          <p>{viewingAsset.locations?.location_name || 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Sub-Location</p>
                          <p>{viewingAsset.sub_locations?.sub_location_name || 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Section</p>
                          <p>{viewingAsset.sections?.section_name || 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Department</p>
                          <p>{viewingAsset.departments?.department_name || 'N/A'}</p>
                        </div>
                        <div>
                          <p className="text-xs text-gray-500">Assigned To</p>
                          <p>{viewingAsset.employees?.employee_name || 'Unassigned'}</p>
                        </div>
                      </div>
                    </dd>
                  </div>
                  
                  {viewingAsset.description && (
                    <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                      <dt className="text-sm font-medium text-gray-500">Description</dt>
                      <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                        {viewingAsset.description}
                      </dd>
                    </div>
                  )}
                  
                  {viewingAsset.specification && (
                    <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                      <dt className="text-sm font-medium text-gray-500">Specifications</dt>
                      <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-line">
                        {viewingAsset.specification}
                      </dd>
                    </div>
                  )}
                  {isElevated && viewingAsset.remarks && (
                    <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                      <dt className="text-sm font-medium text-gray-500">Remarks</dt>
                      <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 whitespace-pre-line">
                        {viewingAsset.remarks}
                      </dd>
                    </div>
                  )}
                  
                  {(viewingAsset.blank_field_1 || viewingAsset.blank_field_2 || viewingAsset.blank_field_3) && (
  <div className="py-4 sm:py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
    <dt className="text-sm font-medium text-gray-500">Additional Information</dt>
    <dd className="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2 space-y-2">
      {viewingAsset.blank_field_1 && (
        <p><span className="font-medium">Custom Field 1:</span> {viewingAsset.blank_field_1}</p>
      )}
      {viewingAsset.blank_field_2 && (
        <p><span className="font-medium">Custom Field 2:</span> {viewingAsset.blank_field_2}</p>
      )}
      {viewingAsset.blank_field_3 && (
        <p><span className="font-medium">Custom Field 3:</span> {viewingAsset.blank_field_3}</p>
      )}
    </dd>
  </div>
)}
                </dl>
              </div>
            </div>
            
            <div className="flex justify-end space-x-3 pt-4">
              <button
                type="button"
                onClick={handleCloseViewModal}
                className="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
              >
                Close
              </button>
              <button
                type="button"
                onClick={() => {
                  handleCloseViewModal();
                  handleEditAsset(viewingAsset);
                }}
                className="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
              >
                <FiEdit2 className="-ml-1 mr-2 h-4 w-4" />
                Edit Asset
              </button>
            </div>
          </div>
        )}
      </Modal>
    </div>
  );
};

export default AssetsPage;
