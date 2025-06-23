-- Sample data for Exide IT Asset Manager

-- Locations
INSERT INTO locations (location_name) VALUES ('Mumbai Office');
INSERT INTO locations (location_name) VALUES ('Pune Warehouse');

-- Departments
INSERT INTO departments (department_name, department_sub_locations) VALUES ('IT', 'Floor 3, Rooms A101-A110');
INSERT INTO departments (department_name, department_sub_locations) VALUES ('HR', 'Floor 2, Rooms B201-B210');

-- Employees
INSERT INTO employees (employee_name, email, department_id, location_id, phone_no, role) VALUES ('John Doe', 'john.doe@exide.com', 1, 1, '+91-9876543210', 'admin');
INSERT INTO employees (employee_name, email, department_id, location_id, phone_no, role) VALUES ('Jane Smith', 'jane.smith@exide.com', 2, 2, '+91-9123456789', 'manager');
INSERT INTO employees (employee_name, email, department_id, location_id, phone_no, role) VALUES ('Raj Patel', 'raj.patel@exide.com', 1, 1, '+91-9988776655', 'employee');

-- Vendors
INSERT INTO vendors (vendor_name, contact_email, phone, address) VALUES ('TechCorp', 'sales@techcorp.com', '+91-1234567890', '456 Tech St');
INSERT INTO vendors (vendor_name, contact_email, phone, address) VALUES ('IT Solutions', 'contact@itsolutions.com', '+91-1122334455', '789 IT Park');

-- Asset Types
INSERT INTO asset_types (asset_type_name, description) VALUES ('Laptop', 'Portable computing device');
INSERT INTO asset_types (asset_type_name, description) VALUES ('Desktop', 'Stationary computing device');

-- Assets
INSERT INTO assets (asset_type_id, make, model, serial_number, purchase_date, warranty_expiry, purchase_invoice_number, order_number, location_id, department_id, employee_id, description, blank_field_1, blank_field_2, blank_field_3, specification, sap_reference) VALUES (1, 'Dell', 'XPS 13', 'SN123456', '2023-01-15', '2025-01-15', 'INV001', 'ORD001', 1, 1, 1, 'High-performance laptop', 'Extra battery', 'Extended warranty', 'Used in project X', '16GB RAM, 512GB SSD', 'SAP001');
INSERT INTO assets (asset_type_id, make, model, serial_number, purchase_date, warranty_expiry, purchase_invoice_number, order_number, location_id, department_id, employee_id, description, blank_field_1, blank_field_2, blank_field_3, specification, sap_reference) VALUES (1, 'Dell', 'Latitude 7400', 'SN789012', '2023-02-10', '2025-02-10', 'INV002', 'ORD002', 1, 1, NULL, 'Unassigned laptop', 'Spare part included', '', '', '8GB RAM, 256GB SSD', 'SAP002');
INSERT INTO assets (asset_type_id, make, model, serial_number, purchase_date, warranty_expiry, purchase_invoice_number, order_number, location_id, department_id, employee_id, description, blank_field_1, blank_field_2, blank_field_3, specification, sap_reference) VALUES (1, 'HP', 'EliteBook 840', 'SN345678', '2022-06-01', '2024-06-01', 'INV003', 'ORD003', 1, 1, NULL, 'Damaged laptop', '', '', '', '4GB RAM, 128GB SSD', 'SAP003');

-- Stock
INSERT INTO stock (asset_id, asset_type_id, make, model, serial_number, purchase_date, warranty_expiry, purchase_invoice_number, order_number, location_id, department_id, description, blank_field_1, blank_field_2, blank_field_3, specification, sap_reference, status, notes) VALUES (2, 1, 'Dell', 'Latitude 7400', 'SN789012', '2023-02-10', '2025-02-10', 'INV002', 'ORD002', 1, 1, 'Unassigned laptop', 'Spare part included', '', '', '8GB RAM, 256GB SSD', 'SAP002', 'in_stock', 'Stored in Mumbai warehouse');

-- Scrap
INSERT INTO scrap (asset_id, asset_type_id, make, model, serial_number, purchase_date, warranty_expiry, purchase_invoice_number, order_number, location_id, department_id, description, blank_field_1, blank_field_2, blank_field_3, specification, sap_reference, scrap_date, reason) VALUES (3, 1, 'HP', 'EliteBook 840', 'SN345678', '2022-06-01', '2024-06-01', 'INV003', 'ORD003', 1, 1, 'Damaged laptop', '', '', '', '4GB RAM, 128GB SSD', 'SAP003', '2025-06-21', 'Damaged beyond repair');

-- Transfer History
INSERT INTO transfer_history (asset_id, make, model, from_employee_id, to_employee_id, from_department_id, to_department_id, from_location_id, to_location_id, transfer_date, notes) 
VALUES (1, 'Dell', 'XPS 13', 1, 2, 1, 2, 1, 2, '2025-06-21 10:00:00', 'Transferred due to employee relocation');
