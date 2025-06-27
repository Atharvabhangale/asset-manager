-- Create table_permissions table for per-user/table access control
CREATE TABLE IF NOT EXISTS public.table_permissions (
  id SERIAL PRIMARY KEY,
  user_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE,
  table_name text NOT NULL,
  permission text NOT NULL CHECK (permission IN ('read', 'write', 'all'))
);

-- Enable RLS on table_permissions and only allow admins to modify it
ALTER TABLE public.table_permissions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admins can manage permissions" ON public.table_permissions
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND p.role = 'admin'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p
      WHERE p.id = auth.uid() AND p.role = 'admin'
    )
  );

-- Example: Allow all authenticated users to read data from main tables, but restrict write to admin/master or users with table_permissions
-- Repeat for each table as needed

-- Departments
ALTER TABLE public.departments ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.departments
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.departments
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'departments' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'departments' AND tp.permission = 'all'
    )
  );

-- Repeat the above for each table:
-- employees, locations, vendors, asset_types, assets, stock, disposed, transfer_history, sections, sub_locations

-- Employees
ALTER TABLE public.employees ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.employees
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.employees
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'employees' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'employees' AND tp.permission = 'all'
    )
  );

-- Locations
ALTER TABLE public.locations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.locations
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.locations
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'locations' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'locations' AND tp.permission = 'all'
    )
  );

-- Vendors
ALTER TABLE public.vendors ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.vendors
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.vendors
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'vendors' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'vendors' AND tp.permission = 'all'
    )
  );

-- Asset Types
ALTER TABLE public.asset_types ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.asset_types
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.asset_types
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'asset_types' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'asset_types' AND tp.permission = 'all'
    )
  );

-- Assets
ALTER TABLE public.assets ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.assets
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.assets
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'assets' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'assets' AND tp.permission = 'all'
    )
  );

-- Stock
ALTER TABLE public.stock ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.stock
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.stock
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'stock' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'stock' AND tp.permission = 'all'
    )
  );

-- Disposed
ALTER TABLE public.disposed ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.disposed
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.disposed
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'disposed' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'disposed' AND tp.permission = 'all'
    )
  );

-- Transfer History
ALTER TABLE public.transfer_history ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.transfer_history
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.transfer_history
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'transfer_history' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'transfer_history' AND tp.permission = 'all'
    )
  );

-- Sections
ALTER TABLE public.sections ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.sections
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.sections
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'sections' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'sections' AND tp.permission = 'all'
    )
  );

-- Sub Locations
ALTER TABLE public.sub_locations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow read for authenticated users" ON public.sub_locations
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid())
  );
CREATE POLICY "Admin/master or permitted user can modify" ON public.sub_locations
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'sub_locations' AND tp.permission = 'all'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('admin', 'master')
    )
    OR
    EXISTS (
      SELECT 1 FROM public.table_permissions tp WHERE tp.user_id = auth.uid() AND tp.table_name = 'sub_locations' AND tp.permission = 'all'
    )
  );

-- Permissions for profiles table itself (admins only)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow admin to manage profiles" ON public.profiles
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role = 'admin'
    )
  ) WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role = 'admin'
    )
  );

-- End of RLS and permissions setup
-- Allow any authenticated user to read their own profile
CREATE POLICY "Users can read their own profile" ON public.profiles
  FOR SELECT
  USING (id = auth.uid());

  -- Allow admins to read all profiles
CREATE POLICY "Admins can read all profiles" ON public.profiles
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles p2
      WHERE p2.id = auth.uid() AND p2.role = 'admin'
    )
  );

-- Allow every authenticated user to read ONLY their own permission rows
CREATE POLICY "User can read own permissions"
ON public.table_permissions
FOR SELECT
USING (user_id = auth.uid());

-- 1️⃣ Helper: returns TRUE if the given uid is an admin
create or replace function public.is_admin(uid uuid)
returns boolean
language sql
security definer               -- ← runs with table owner privileges
as $$
  select role = 'admin'
  from public.profiles
  where id = uid;
$$;

-- Make sure both anon & authenticated can call it
grant execute on function public.is_admin(uuid) to anon, authenticated;

-----------------------------------------------------------------
-- 2️⃣ Reset the profiles policies to remove any recursive queries
-----------------------------------------------------------------
alter table public.profiles enable row level security;

drop policy if exists "Users can read their own profile" on public.profiles;
drop policy if exists "Admins can read all profiles"      on public.profiles;
drop policy if exists "Allow admin to manage profiles"    on public.profiles;

-- Users can read ONLY their own row
create policy "Users can read their own profile"
on public.profiles
for select
using ( id = auth.uid() );

-- Admins can read ALL rows
create policy "Admins can read all profiles"
on public.profiles
for select
using ( public.is_admin(auth.uid()) );

-- Admins can insert / update / delete
create policy "Allow admin to manage profiles"
on public.profiles
for all
using   ( public.is_admin(auth.uid()) )
with check ( public.is_admin(auth.uid()) );

-- Allow users who already have 'assets' write/all permission
-- (or are admin / master) to INSERT into transfer_history
create policy "Assets editors can log transfers"
on public.transfer_history
for insert
with check (
      -- admins / masters always allowed
      exists (select 1
              from public.profiles p
              where p.id = auth.uid()
                and p.role in ('admin','master'))
   or -- users who have the asset permission
      exists (select 1
              from public.table_permissions tp
              where tp.user_id   = auth.uid()
                and tp.table_name = 'assets'
                and tp.permission in ('write','all'))
);