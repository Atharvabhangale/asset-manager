-- Exide IT Asset Manager - Supabase Schema
-- Master Data Tables

CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL
);
CREATE TABLE sub_locations (
    sub_location_id SERIAL PRIMARY KEY,
    location_id INTEGER NOT NULL REFERENCES locations(location_id) ON DELETE CASCADE,
    sub_location_name VARCHAR(100) NOT NULL
);
CREATE OR REPLACE VIEW view_sub_locations AS
SELECT
  sl.sub_location_id,
  sl.sub_location_name,
  sl.location_id,
  l.location_name
FROM sub_locations sl
JOIN locations l ON sl.location_id = l.location_id
ORDER BY l.location_name, sl.sub_location_name;


CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_sub_locations TEXT
);
ALTER TABLE departments
DROP COLUMN department_sub_locations;
CREATE TABLE sections (
    section_id SERIAL PRIMARY KEY,
    section_name VARCHAR(100) NOT NULL,
    department_id INTEGER NOT NULL REFERENCES departments(department_id)
);
CREATE OR REPLACE VIEW view_sections_with_departments AS
SELECT 
    s.section_id,
    s.section_name,
    s.department_id,
    d.department_name
FROM 
    sections s
JOIN 
    departments d ON s.department_id = d.department_id;


CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INTEGER NOT NULL REFERENCES departments(department_id),
    location_id INTEGER NOT NULL REFERENCES locations(location_id),
    phone_no VARCHAR(20),
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'manager', 'employee'))
);

CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    vendor_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT
);
ALTER TABLE vendors
ADD COLUMN remarks TEXT;

CREATE TABLE asset_types (
    asset_type_id SERIAL PRIMARY KEY,
    asset_type_name VARCHAR(100) NOT NULL,
    description TEXT
);

-- Asset Table
CREATE TABLE assets (
    asset_id SERIAL PRIMARY KEY,
    asset_type_id INTEGER NOT NULL REFERENCES asset_types(asset_type_id),
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    purchase_date DATE,
    warranty_expiry DATE,
    purchase_invoice_number VARCHAR(50),
    order_number VARCHAR(50),
    location_id INTEGER NOT NULL REFERENCES locations(location_id),
    department_id INTEGER NOT NULL REFERENCES departments(department_id),
    employee_id INTEGER REFERENCES employees(employee_id),
    description TEXT,
    blank_field_1 TEXT,
    blank_field_2 TEXT,
    blank_field_3 TEXT,
    specification TEXT,
    sap_reference VARCHAR(50)
);
ALTER TABLE assets
ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'in_stock'
CHECK (status IN ('in_stock', 'assigned', 'in_maintenance', 'retired'));
ALTER TABLE assets
ADD COLUMN sub_location_id INTEGER,
ADD COLUMN section_id INTEGER;

ALTER TABLE assets
ADD CONSTRAINT assets_sub_location_id_fkey
FOREIGN KEY (sub_location_id)
REFERENCES sub_locations(sub_location_id);

ALTER TABLE assets
ADD CONSTRAINT assets_section_id_fkey
FOREIGN KEY (section_id)
REFERENCES sections(section_id);

-- Stock Table
CREATE TABLE stock (
    stock_id SERIAL PRIMARY KEY,
    asset_id INTEGER UNIQUE NOT NULL REFERENCES assets(asset_id),
    asset_type_id INTEGER NOT NULL REFERENCES asset_types(asset_type_id),
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    purchase_date DATE,
    warranty_expiry DATE,
    purchase_invoice_number VARCHAR(50),
    order_number VARCHAR(50),
    location_id INTEGER NOT NULL REFERENCES locations(location_id),
    department_id INTEGER NOT NULL REFERENCES departments(department_id),
    description TEXT,
    blank_field_1 TEXT,
    blank_field_2 TEXT,
    blank_field_3 TEXT,
    specification TEXT,
    sap_reference VARCHAR(50),
    status VARCHAR(50) NOT NULL DEFAULT 'in_stock' CHECK (status IN ('assigned', 'in_stock', 'in_maintenance', 'retired')),
    notes TEXT
);

-- Scrap Table
CREATE TABLE scrap (
    scrap_id SERIAL PRIMARY KEY,
    asset_id INTEGER UNIQUE NOT NULL REFERENCES assets(asset_id),
    asset_type_id INTEGER NOT NULL REFERENCES asset_types(asset_type_id),
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    purchase_date DATE,
    warranty_expiry DATE,
    purchase_invoice_number VARCHAR(50),
    order_number VARCHAR(50),
    location_id INTEGER NOT NULL REFERENCES locations(location_id),
    department_id INTEGER NOT NULL REFERENCES departments(department_id),
    description TEXT,
    blank_field_1 TEXT,
    blank_field_2 TEXT,
    blank_field_3 TEXT,
    specification TEXT,
    sap_reference VARCHAR(50),
    scrap_date DATE NOT NULL DEFAULT CURRENT_DATE,
    reason TEXT
);

-- Transfer History Table
CREATE TABLE transfer_history (
    transfer_id SERIAL PRIMARY KEY,
    asset_id INTEGER NOT NULL REFERENCES assets(asset_id),
    make VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    from_employee_id INTEGER REFERENCES employees(employee_id),
    to_employee_id INTEGER REFERENCES employees(employee_id),
    from_department_id INTEGER NOT NULL REFERENCES departments(department_id),
    to_department_id INTEGER NOT NULL REFERENCES departments(department_id),
    from_location_id INTEGER NOT NULL REFERENCES locations(location_id),
    to_location_id INTEGER NOT NULL REFERENCES locations(location_id),
    transfer_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT
);
CREATE OR REPLACE VIEW view_transfer_history_enriched AS
SELECT
  th.transfer_id,
  th.asset_id,
  th.make,
  th.model,
  th.transfer_date,
  th.notes,

  -- Employee Names
  e_from.employee_name AS from_employee_name,
  e_to.employee_name AS to_employee_name,

  -- Department Names
  d_from.department_name AS from_department_name,
  d_to.department_name AS to_department_name,

  -- Location Names
  l_from.location_name AS from_location_name,
  l_to.location_name AS to_location_name

FROM transfer_history th
LEFT JOIN employees e_from ON e_from.employee_id = th.from_employee_id
LEFT JOIN employees e_to ON e_to.employee_id = th.to_employee_id
LEFT JOIN departments d_from ON d_from.department_id = th.from_department_id
LEFT JOIN departments d_to ON d_to.department_id = th.to_department_id
LEFT JOIN locations l_from ON l_from.location_id = th.from_location_id
LEFT JOIN locations l_to ON l_to.location_id = th.to_location_id
ORDER BY th.transfer_date DESC;

CREATE OR REPLACE FUNCTION move_asset_to_disposed()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.status = 'disposed' THEN
    INSERT INTO disposed (
      asset_id,
      asset_type_id,
      make,
      model,
      serial_number,
      purchase_date,
      warranty_expiry,
      purchase_invoice_number,
      order_number,
      location_id,
      department_id,
      description,
      blank_field_1,
      blank_field_2,
      blank_field_3,
      specification,
      sap_reference,
      reason
    ) VALUES (
      OLD.asset_id,
      OLD.asset_type_id,
      OLD.make,
      OLD.model,
      OLD.serial_number,
      OLD.purchase_date,
      OLD.warranty_expiry,
      OLD.purchase_invoice_number,
      OLD.order_number,
      OLD.location_id,
      OLD.department_id,
      OLD.description,
      OLD.blank_field_1,
      OLD.blank_field_2,
      OLD.blank_field_3,
      OLD.specification,
      OLD.sap_reference,
      'Obsolete machine'
    );
  END IF;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE VIEW view_disposed_assets_full AS
SELECT
  d.*,
  at.asset_type_name,
  l.location_name,
  dept.department_name
FROM disposed d
LEFT JOIN asset_types at ON d.asset_type_id = at.asset_type_id
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN departments dept ON d.department_id = dept.department_id
ORDER BY d.disposed_date DESC;

