-- ============================================================
-- 1. (Optional) profiles table – adjust columns as you need
-- ============================================================
-- DROP TABLE IF EXISTS public.profiles;
-- CREATE TABLE public.profiles (
--   id               uuid PRIMARY KEY,          -- same as auth.users.id
--   full_name        text,
--   avatar_url       text,
--   email            text,
--   role             text DEFAULT 'user',
--   created_at       timestamptz DEFAULT now()
-- );

-- ============================================================
-- 2. Function: create a profile whenever a new auth.user appears
-- ============================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER           -- required so it can insert into public schema
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url)
  VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data ->> 'full_name', NEW.raw_user_meta_data ->> 'avatar_url')
  ON CONFLICT (id) DO NOTHING;      -- safety if it already exists
  RETURN NEW;
END;
$$;

-- ------------------------------------------------------------
-- Trigger (fires AFTER insert on auth.users)
-- ------------------------------------------------------------
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- ============================================================
-- 3. (Optional) Keep email / name in sync when auth.users rows change
-- ============================================================
CREATE OR REPLACE FUNCTION public.sync_user_update()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  UPDATE public.profiles
  SET email      = NEW.email,
      full_name  = COALESCE(NEW.raw_user_meta_data ->> 'full_name', full_name),
      avatar_url = COALESCE(NEW.raw_user_meta_data ->> 'avatar_url', avatar_url)
  WHERE id = NEW.id;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_updated ON auth.users;
CREATE TRIGGER on_auth_user_updated
AFTER UPDATE ON auth.users
FOR EACH ROW EXECUTE PROCEDURE public.sync_user_update();

-- ============================================================
-- 4. Ensure RLS policies allow the functions to run
--    (functions run as SECURITY DEFINER, but table must allow)
-- ============================================================
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Allow the function’s owner (typically postgres or service_role) full access:
CREATE POLICY "Allow full access for service role"
  ON public.profiles
  FOR ALL
  TO service_role
  USING (true)
  WITH CHECK (true);


  CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url, username)
  VALUES (NEW.id,
          NEW.email,
          NEW.raw_user_meta_data ->> 'full_name',
          NEW.raw_user_meta_data ->> 'avatar_url',
          split_part(NEW.email, '@', 1))
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;


CREATE OR REPLACE FUNCTION public.sync_user_update()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  UPDATE public.profiles
  SET email      = NEW.email,
      full_name  = COALESCE(NEW.raw_user_meta_data ->> 'full_name', full_name),
      avatar_url = COALESCE(NEW.raw_user_meta_data ->> 'avatar_url', avatar_url),
      username   = split_part(NEW.email, '@', 1)
  WHERE id = NEW.id;
  RETURN NEW;
END;
$$;

create or replace function public.auto_confirm_user()
returns trigger as $$
begin
  if NEW.email_confirmed_at is null then
    NEW.email_confirmed_at := now();
  end if;
  return NEW;
end;
$$ language plpgsql;

create trigger auto_confirm_user_trigger
before insert on auth.users
for each row
execute function public.auto_confirm_user();
