import React, { useState, useEffect, useMemo } from 'react';
import { useAssets } from '../hooks/useAssets';
import { FiFileText, FiDownload } from 'react-icons/fi';
import Select from 'react-select';
import TransferReportSection from './TransferReportSection';
import DisposedReportSection from './DisposedReportSection';

const statusOptions = [
  { value: 'in_stock', label: 'In Stock' },
  { value: 'assigned', label: 'Assigned' },
  { value: 'in_maintenance', label: 'In Maintenance' },
  { value: 'retired', label: 'Retired' },
  { value: 'disposed', label: 'Disposed' }
];

const ReportsPage = () => {
  const { assets, loading, error, fetchAssets, employees, fetchEmployees } = useAssets();
  const [reportType, setReportType] = useState('assets');
  const [showPreview, setShowPreview] = useState(false);

  // Fetch assets on component mount
  useEffect(() => {
    fetchAssets();
    fetchEmployees();
  }, [fetchAssets, fetchEmployees]);

  /* --- ASSET FILTER STATE --- */
  const handleMulti = (e, key) => {
    const selected = Array.from(e.target.selectedOptions).map(o => o.value);
    setAssetFilters(f => ({ ...f, [key]: selected }));
  };

  const [assetFilters, setAssetFilters] = useState({
    locations: [],
    departments: [],
    types: [],
    statuses: [],
    makes: [],
    models: [],
    hostname: '',
    subLocations: [],
    sections: [],
    assignedTo: [],
    purchaseFrom: '',
    purchaseTo: '',
    warrantyFrom: '',
    warrantyTo: ''
  });

  /* Unique filter options derived from assets (handle flat and nested) */
  const locations = Array.from(new Set(assets.map(a => a.locations?.location_name || a.location_name).filter(Boolean)));
  const locationOptions = locations.map(l=>({value:l,label:l}));
  const departments = Array.from(new Set(assets.map(a => a.departments?.department_name || a.department_name).filter(Boolean)));
  const departmentOptions = departments.map(d=>({value:d,label:d}));
  const types = Array.from(new Set(assets.map(a => a.asset_types?.asset_type_name || a.asset_type_name).filter(Boolean)));
  const typeOptions = types.map(t=>({value:t,label:t}));
  const makes = Array.from(new Set(assets.map(a => a.make).filter(Boolean)));
  const makeOptions = makes.map(m=>({value:m,label:m}));
  const allModelOptions = Array.from(new Set(assets.map(a => a.model).filter(Boolean))).map(m=>({value:m,label:m}));
  const modelOptions = useMemo(()=>{
    if(!(assetFilters.makes||[]).length) return allModelOptions;
    return allModelOptions.filter(opt=> assets.some(a=> a.model===opt.value && (assetFilters.makes||[]).includes(a.make)));
  },[allModelOptions, assetFilters.makes, assets]);
  const allSubLocationOptions = Array.from(new Set(assets.map(a => a.sub_locations?.sub_location_name || a.sub_location_name).filter(Boolean))).map(s=>({value:s,label:s}));
  const subLocationOptions = useMemo(()=>{
    if(!(assetFilters.locations||[]).length) return allSubLocationOptions;
    return allSubLocationOptions.filter(opt=> assets.some(a=> (a.sub_locations?.sub_location_name||a.sub_location_name)===opt.value && (assetFilters.locations||[]).includes(a.locations?.location_name||a.location_name)));
  },[allSubLocationOptions, assetFilters.locations, assets]);
  const allSectionOptions = Array.from(new Set(assets.map(a => a.sections?.section_name || a.section_name).filter(Boolean))).map(s=>({value:s,label:s}));
  const sectionOptions = useMemo(()=>{
    if(!(assetFilters.departments||[]).length) return allSectionOptions;
    return allSectionOptions.filter(opt=> assets.some(a=> (a.sections?.section_name||a.section_name)===opt.value && (assetFilters.departments||[]).includes(a.departments?.department_name||a.department_name)));
  },[allSectionOptions, assetFilters.departments, assets]);
  const employeeOptions = (Array.isArray(employees) ? employees : []).map(e => ({ value: e.employee_name, label: e.employee_name }));

  const filteredAssets = assets.filter(asset => {
    let match = true;
    if (assetFilters.locations?.length) {
      match = match && (assetFilters.locations||[]).includes(asset.locations?.location_name || asset.location_name);
    }
    if (assetFilters.departments?.length) {
      match = match && (assetFilters.departments||[]).includes(asset.departments?.department_name || asset.department_name);
    }
    if (assetFilters.types?.length) {
      match = match && (assetFilters.types||[]).includes(asset.asset_types?.asset_type_name || asset.asset_type_name);
    }
    if (assetFilters.statuses?.length) {
      match = match && (assetFilters.statuses||[]).includes(asset.status);
    }
    if (assetFilters.makes?.length) {
      match = match && (assetFilters.makes||[]).includes(asset.make);
    }
    if (assetFilters.models?.length) {
      match = match && (assetFilters.models||[]).includes(asset.model);
    }
    if (assetFilters.hostname) {
      match = match && (asset.hostname || '').toLowerCase().includes(assetFilters.hostname.toLowerCase());
    }
    if (assetFilters.subLocations?.length) {
      match = match && (assetFilters.subLocations||[]).includes(asset.sub_locations?.sub_location_name || asset.sub_location_name);
    }
    if (assetFilters.sections?.length) {
      match = match && (assetFilters.sections||[]).includes(asset.sections?.section_name || asset.section_name);
    }
    if (assetFilters.assignedTo?.length) {
      match = match && (assetFilters.assignedTo||[]).includes(asset.employees?.employee_name || asset.employee_name);
    }
    if (assetFilters.subLocation) {
      match = match && ((asset.sub_locations?.sub_location_name || asset.sub_location_name) === assetFilters.subLocation);
    }
    if (assetFilters.section) {
      match = match && ((asset.sections?.section_name || asset.section_name) === assetFilters.section);
    }
    if (assetFilters.purchaseFrom) {
      match = match && asset.purchase_date && asset.purchase_date >= assetFilters.purchaseFrom;
    }
    if (assetFilters.purchaseTo) {
      match = match && asset.purchase_date && asset.purchase_date <= assetFilters.purchaseTo;
    }
    if (assetFilters.warrantyFrom) {
      match = match && asset.warranty_expiry && asset.warranty_expiry >= assetFilters.warrantyFrom;
    }
    if (assetFilters.warrantyTo) {
      match = match && asset.warranty_expiry && asset.warranty_expiry <= assetFilters.warrantyTo;
    }
    return match;
  });

  const generateAssetCSV = () => {
    if (filteredAssets?.length === 0) return; // nothing to export
    const headers = [
      'ID', 'Type', 'Make', 'Model', 'Status', 'Serial Number',
      'Location', 'Department', 'Assigned To', 'Purchase Date', 'Warranty Expiry',
      'Purchase Invoice', 'Order Number', 'Description', 'Specification', 'SAP Reference',
      'Custom Field 1', 'Custom Field 2', 'Custom Field 3',
      'Sub-Location', 'Section'
    ];

    const rows = filteredAssets.map(asset => ({
      id: asset.asset_id,
      type: asset.asset_types?.asset_type_name || 'N/A',
      make: asset.make || 'N/A',
      model: asset.model || 'N/A',
      status: statusOptions.find(opt => opt.value === asset.status)?.label || asset.status,
      serialNumber: asset.serial_number || 'N/A',
      location: asset.locations?.location_name || asset.location_name || 'N/A',
      department: asset.departments?.department_name || asset.department_name || 'N/A',
      assignedTo: asset.employees?.employee_name || 'Unassigned',
      purchaseDate: asset.purchase_date || 'N/A',
      warrantyExpiry: asset.warranty_expiry || 'N/A',
      purchaseInvoice: asset.purchase_invoice_number || 'N/A',
      orderNumber: asset.order_number || 'N/A',
      description: asset.description || 'N/A',
      specification: asset.specification || 'N/A',
      sapReference: asset.sap_reference || 'N/A',
      custom1: asset.blank_field_1 || 'N/A',
      custom2: asset.blank_field_2 || 'N/A',
      custom3: asset.blank_field_3 || 'N/A',
      subLocation: asset.sub_locations?.sub_location_name || asset.sub_location_name || 'N/A',
      section: asset.sections?.section_name || asset.section_name || 'N/A'
    }));

    const csvContent = [
      headers.join(','),
      ...rows.map(row => Object.values(row).map(v => `"${String(v).replace(/"/g, '""')}"`).join(','))
    ].join('\n');

    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.setAttribute('download', 'assets_report.csv');
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  };

  return (
    <div className="py-10">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">Reports</h1>

        {/* Report Type Selector */}
        <div className="mb-8">
          <label className="block text-sm font-medium text-gray-700 mb-1">Select Report</label>
          <select
            className="p-2 border rounded-md"
            value={reportType}
            onChange={e => setReportType(e.target.value)}
          >
            <option value="assets">Assets</option>
            <option value="transfers">Transfer History</option>
            <option value="disposed">Disposed Assets</option>
          </select>
        </div>

        {reportType === 'assets' && (
          <div className="bg-white shadow rounded-lg p-6 space-y-6">
            <h2 className="text-xl font-semibold text-gray-800">Asset Report Filters</h2>

            {/* Filters Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Location</label>
                <Select isMulti options={locationOptions} classNamePrefix="react-select" value={locationOptions.filter(o=>(assetFilters.locations||[]).includes(o.value))} onChange={vals=>setAssetFilters(f=>({...f,locations:vals.map(v=>v.value), subLocations: []}))}/>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Department</label>
                <Select isMulti options={departmentOptions} classNamePrefix="react-select" value={departmentOptions.filter(o=>(assetFilters.departments||[]).includes(o.value))} onChange={vals=>setAssetFilters(f=>({...f,departments:vals.map(v=>v.value), sections: []}))}/>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Asset Type</label>
                <Select isMulti options={typeOptions} classNamePrefix="react-select" value={typeOptions.filter(o=>(assetFilters.types||[]).includes(o.value))} onChange={vals=>setAssetFilters(f=>({...f,types:vals.map(v=>v.value)}))}/>
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Status</label>
                <Select isMulti options={statusOptions.map(s=>({value:s.value,label:s.label}))} classNamePrefix="react-select" value={statusOptions.map(s=>({value:s.value,label:s.label})).filter(o=>(assetFilters.statuses||[]).includes(o.value))} onChange={vals=>setAssetFilters(f=>({...f,statuses:vals.map(v=>v.value)}))}/>
              </div>

              {/* Make */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Make</label>
                <Select isMulti options={makeOptions} classNamePrefix="react-select" value={makeOptions.filter(o=>(assetFilters.makes||[]).includes(o.value))} onChange={vals=>setAssetFilters(f=>({...f,makes:vals.map(v=>v.value), models: []}))}/>
              </div>
              {/* Model */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Hostname</label>
                <input type="text" value={assetFilters.hostname} onChange={e=>setAssetFilters(f=>({...f,hostname:e.target.value}))} className="w-full p-2 border rounded-md" placeholder="Search hostname" />
              </div>
              {/* Model */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Model</label>
                <Select isMulti isDisabled={!(assetFilters.makes||[]).length} options={modelOptions} classNamePrefix="react-select" value={modelOptions.filter(o=>(assetFilters.models||[]).includes(o.value))} placeholder={!(assetFilters.makes||[]).length ? 'Select make first' : undefined} onChange={vals=>setAssetFilters(f=>({...f,models:vals.map(v=>v.value)}))}/>
              </div>

              {/* Sub-Location */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Sub-Location</label>
                <Select isMulti isDisabled={!(assetFilters.locations||[]).length} options={subLocationOptions} classNamePrefix="react-select" value={subLocationOptions.filter(o=>(assetFilters.subLocations||[]).includes(o.value))} placeholder={!(assetFilters.locations||[]).length ? 'Select location first' : undefined} onChange={vals=>setAssetFilters(f=>({...f,subLocations:vals.map(v=>v.value)}))}/>
              </div>
              {/* Section */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Section</label>
                <Select isMulti isDisabled={!(assetFilters.departments||[]).length} options={sectionOptions} classNamePrefix="react-select" value={sectionOptions.filter(o=>(assetFilters.sections||[]).includes(o.value))} placeholder={!(assetFilters.departments||[]).length ? 'Select department first' : undefined} onChange={vals=>setAssetFilters(f=>({...f,sections:vals.map(v=>v.value)}))}/>
              </div>
              {/* Assigned To */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Assigned To</label>
                <Select isMulti options={employeeOptions} classNamePrefix="react-select" value={employeeOptions.filter(o=>(assetFilters.assignedTo||[]).includes(o.value))} onChange={vals=>setAssetFilters(f=>({...f,assignedTo:vals.map(v=>v.value)}))}/>
              </div>

              {/* Purchase Date From */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Purchase Date From</label>
                <input
                  type="date"
                  className="w-full p-2 border rounded-md"
                  value={assetFilters.purchaseFrom}
                  onChange={e => setAssetFilters(f => ({ ...f, purchaseFrom: e.target.value }))}
                />
              </div>
              {/* Purchase Date To */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Purchase Date To</label>
                <input
                  type="date"
                  className="w-full p-2 border rounded-md"
                  value={assetFilters.purchaseTo}
                  onChange={e => setAssetFilters(f => ({ ...f, purchaseTo: e.target.value }))}
                />
              </div>

              {/* Warranty Expiry From */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Warranty Expiry From</label>
                <input
                  type="date"
                  className="w-full p-2 border rounded-md"
                  value={assetFilters.warrantyFrom}
                  onChange={e => setAssetFilters(f => ({ ...f, warrantyFrom: e.target.value }))}
                />
              </div>
              {/* Warranty Expiry To */}
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Warranty Expiry To</label>
                <input
                  type="date"
                  className="w-full p-2 border rounded-md"
                  value={assetFilters.warrantyTo}
                  onChange={e => setAssetFilters(f => ({ ...f, warrantyTo: e.target.value }))}
                />
              </div>
            </div>

            <div className="flex justify-end gap-3">
              <button
                className="px-4 py-2 bg-gray-100 border rounded-md text-gray-700 hover:bg-gray-200"
                onClick={() => { setAssetFilters({ location: '', department: '', type: '', status: '', make: '', model: '', subLocation: '', section: '', purchaseFrom: '', purchaseTo: '', warrantyFrom: '', warrantyTo: '' }); setShowPreview(false);} }
              >
                Reset
              </button>
              <button
                className="px-4 py-2 bg-indigo-600 text-white rounded-md flex items-center hover:bg-indigo-700"
                onClick={() => setShowPreview(true)}
              >
                <FiFileText className="mr-2" /> Preview
              </button>
              <button
                className="px-4 py-2 bg-blue-600 text-white rounded-md flex items-center hover:bg-blue-700"
                onClick={generateAssetCSV}
              >
                <FiDownload className="mr-2" /> Generate CSV
              </button>
            </div>
          </div>
        )}

        {reportType === 'assets' && showPreview && (
          <div className="mt-8">
            {loading ? (
              <div className="flex justify-center items-center py-8 text-gray-500">Loading assets...</div>
            ) : error ? (
              <div className="text-red-500">{error}</div>
            ) : (
              <div className="overflow-x-auto bg-white shadow rounded-lg">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">ID</th>
                      <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Location</th>
                      <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
                      <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Make</th>
                      <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Model</th>
                      <th className="px-4 py-2 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-100">
                    {filteredAssets.map(asset => (
                      <tr key={asset.asset_id}>
                        <td className="px-4 py-2 whitespace-nowrap">{asset.asset_id}</td>
                        <td className="px-4 py-2 whitespace-nowrap">{asset.locations?.location_name || asset.location_name || '-'}</td>
                        <td className="px-4 py-2 whitespace-nowrap">{asset.asset_types?.asset_type_name || asset.asset_type_name || '-'}</td>
                        <td className="px-4 py-2 whitespace-nowrap">{asset.make}</td>
                        <td className="px-4 py-2 whitespace-nowrap">{asset.model}</td>
                        <td className="px-4 py-2 whitespace-nowrap">{statusOptions.find(s=>s.value===asset.status)?.label || asset.status}</td>
                      </tr>
                    ))}
                    {filteredAssets.length === 0 && (
                      <tr>
                        <td colSpan="6" className="px-4 py-4 text-center text-gray-500">No matching assets</td>
                      </tr>
                    )}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        )}

        {reportType === 'transfers' && (
          <TransferReportSection />
        )}

        {reportType === 'disposed' && (
          <DisposedReportSection />
        )}

        {reportType !== 'assets' && reportType !== 'transfers' && reportType !== 'disposed' && (
          <div className="text-gray-500">Selected report type is not implemented yet.</div>
        )}

      </div>
    </div>
  );
};

export default ReportsPage;
