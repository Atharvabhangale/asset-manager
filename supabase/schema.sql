

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE SCHEMA IF NOT EXISTS "auth";


ALTER SCHEMA "auth" OWNER TO "supabase_admin";


CREATE SCHEMA IF NOT EXISTS "public";


ALTER SCHEMA "public" OWNER TO "pg_database_owner";


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE TYPE "auth"."aal_level" AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE "auth"."aal_level" OWNER TO "supabase_auth_admin";


CREATE TYPE "auth"."code_challenge_method" AS ENUM (
    's256',
    'plain'
);


ALTER TYPE "auth"."code_challenge_method" OWNER TO "supabase_auth_admin";


CREATE TYPE "auth"."factor_status" AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE "auth"."factor_status" OWNER TO "supabase_auth_admin";


CREATE TYPE "auth"."factor_type" AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE "auth"."factor_type" OWNER TO "supabase_auth_admin";


CREATE TYPE "auth"."one_time_token_type" AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE "auth"."one_time_token_type" OWNER TO "supabase_auth_admin";


CREATE TYPE "public"."user_role" AS ENUM (
    'admin',
    'manager',
    'user'
);


ALTER TYPE "public"."user_role" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "auth"."email"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION "auth"."email"() OWNER TO "supabase_auth_admin";


COMMENT ON FUNCTION "auth"."email"() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';



CREATE OR REPLACE FUNCTION "auth"."jwt"() RETURNS "jsonb"
    LANGUAGE "sql" STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION "auth"."jwt"() OWNER TO "supabase_auth_admin";


CREATE OR REPLACE FUNCTION "auth"."role"() RETURNS "text"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION "auth"."role"() OWNER TO "supabase_auth_admin";


COMMENT ON FUNCTION "auth"."role"() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';



CREATE OR REPLACE FUNCTION "auth"."uid"() RETURNS "uuid"
    LANGUAGE "sql" STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION "auth"."uid"() OWNER TO "supabase_auth_admin";


COMMENT ON FUNCTION "auth"."uid"() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';



CREATE OR REPLACE FUNCTION "public"."auto_set_asset_status"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    -- If status is explicitly being set to 'disposed', don't override it
    IF NEW.status = 'disposed' THEN
        RETURN NEW;
    END IF;

    -- Otherwise, proceed with automatic logic
    IF NEW.employee_id IS NOT NULL THEN
        NEW.status := 'assigned';
    ELSIF NEW.employee_id IS NULL AND OLD.employee_id IS NOT NULL THEN
        NEW.status := 'in_stock';
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."auto_set_asset_status"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  insert into public.profiles (id, full_name, avatar_url, role)
  values (
    new.id, 
    new.raw_user_meta_data->>'full_name', 
    new.raw_user_meta_data->>'avatar_url',
    coalesce((new.raw_user_meta_data->>'role')::text, 'user')
  );
  return new;
end;
$$;


ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"() RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    AS $$
  SELECT is_role('admin');
$$;


ALTER FUNCTION "public"."is_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin"("uid" "uuid") RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    AS $$
  select role = 'admin'
  from public.profiles
  where id = uid;
$$;


ALTER FUNCTION "public"."is_admin"("uid" "uuid") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_admin_or_manager"() RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    AS $$
  SELECT is_role('admin') OR is_role('manager');
$$;


ALTER FUNCTION "public"."is_admin_or_manager"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_manager"() RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    AS $$
  SELECT is_role('manager');
$$;


ALTER FUNCTION "public"."is_manager"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_role"("role_name" "text") RETURNS boolean
    LANGUAGE "sql" SECURITY DEFINER
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM auth.users
    WHERE id = auth.uid() AND raw_user_meta_data->>'role' = role_name
  );
$$;


ALTER FUNCTION "public"."is_role"("role_name" "text") OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."log_asset_transfer"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  -- Only insert if any of the fields have changed
  IF (OLD.employee_id IS DISTINCT FROM NEW.employee_id OR
      OLD.location_id IS DISTINCT FROM NEW.location_id OR
      OLD.department_id IS DISTINCT FROM NEW.department_id) THEN

    INSERT INTO transfer_history (
      asset_id,
      make,
      model,
      from_employee_id,
      to_employee_id,
      from_department_id,
      to_department_id,
      from_location_id,
      to_location_id,
      transfer_date,
      notes
    ) VALUES (
      NEW.asset_id,
      NEW.make,
      NEW.model,
      OLD.employee_id,
      NEW.employee_id,
      OLD.department_id,
      NEW.department_id,
      OLD.location_id,
      NEW.location_id,
      CURRENT_TIMESTAMP,
      'Auto-logged via trigger'
    );
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."log_asset_transfer"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."move_asset_to_disposed"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.status = 'disposed' AND OLD.status IS DISTINCT FROM 'disposed' THEN
    -- Insert into disposed table
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

    -- Delete from assets table
    DELETE FROM assets WHERE asset_id = OLD.asset_id;
  END IF;

  RETURN NULL; -- Returning NULL skips the update
END;
$$;


ALTER FUNCTION "public"."move_asset_to_disposed"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."setup_rls_policies"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
DECLARE
    table_name text;
    tables text[] := ARRAY[
        'employees', 'locations', 'vendors', 'asset_types', 
        'assets', 'stock', 'disposed', 'transfer_history',
        'sections', 'sub_locations'
    ];
BEGIN
    FOREACH table_name IN ARRAY tables LOOP
        -- Read access for all authenticated users
        EXECUTE format('
            DROP POLICY IF EXISTS "Enable read access for all authenticated users" ON public.%I;
            CREATE POLICY "Enable read access for all authenticated users"
            ON public.%I
            FOR SELECT
            TO authenticated
            USING (true);
        ', table_name, table_name);

        -- Full access for admins and managers
        EXECUTE format('
            DROP POLICY IF EXISTS "Enable all access for admins and managers" ON public.%I;
            CREATE POLICY "Enable all access for admins and managers"
            ON public.%I
            FOR ALL
            TO authenticated
            USING (is_role(''admin'') OR is_role(''manager''))
            WITH CHECK (is_role(''admin'') OR is_role(''manager''));
        ', table_name, table_name);
    END LOOP;
END;
$$;


ALTER FUNCTION "public"."setup_rls_policies"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_section_department_match"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  section_dept_id INTEGER;
BEGIN
  IF NEW.section_id IS NOT NULL THEN
    SELECT department_id INTO section_dept_id
    FROM sections
    WHERE section_id = NEW.section_id;

    IF section_dept_id IS DISTINCT FROM NEW.department_id THEN
      RAISE EXCEPTION 'Section does not belong to the selected department';
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."validate_section_department_match"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."validate_sublocation_location_match"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
  sublocation_location_id INTEGER;
BEGIN
  IF NEW.sub_location_id IS NOT NULL THEN
    SELECT location_id INTO sublocation_location_id
    FROM sub_locations
    WHERE sub_location_id = NEW.sub_location_id;

    IF sublocation_location_id IS DISTINCT FROM NEW.location_id THEN
      RAISE EXCEPTION 'Sub-location does not belong to the selected location';
    END IF;
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."validate_sublocation_location_match"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "auth"."audit_log_entries" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "payload" json,
    "created_at" timestamp with time zone,
    "ip_address" character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE "auth"."audit_log_entries" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."audit_log_entries" IS 'Auth: Audit trail for user actions.';



CREATE TABLE IF NOT EXISTS "auth"."flow_state" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid",
    "auth_code" "text" NOT NULL,
    "code_challenge_method" "auth"."code_challenge_method" NOT NULL,
    "code_challenge" "text" NOT NULL,
    "provider_type" "text" NOT NULL,
    "provider_access_token" "text",
    "provider_refresh_token" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "authentication_method" "text" NOT NULL,
    "auth_code_issued_at" timestamp with time zone
);


ALTER TABLE "auth"."flow_state" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."flow_state" IS 'stores metadata for pkce logins';



CREATE TABLE IF NOT EXISTS "auth"."identities" (
    "provider_id" "text" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "identity_data" "jsonb" NOT NULL,
    "provider" "text" NOT NULL,
    "last_sign_in_at" timestamp with time zone,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "email" "text" GENERATED ALWAYS AS ("lower"(("identity_data" ->> 'email'::"text"))) STORED,
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL
);


ALTER TABLE "auth"."identities" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."identities" IS 'Auth: Stores identities associated to a user.';



COMMENT ON COLUMN "auth"."identities"."email" IS 'Auth: Email is a generated column that references the optional email property in the identity_data';



CREATE TABLE IF NOT EXISTS "auth"."instances" (
    "id" "uuid" NOT NULL,
    "uuid" "uuid",
    "raw_base_config" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone
);


ALTER TABLE "auth"."instances" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."instances" IS 'Auth: Manages users across multiple sites.';



CREATE TABLE IF NOT EXISTS "auth"."mfa_amr_claims" (
    "session_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "authentication_method" "text" NOT NULL,
    "id" "uuid" NOT NULL
);


ALTER TABLE "auth"."mfa_amr_claims" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."mfa_amr_claims" IS 'auth: stores authenticator method reference claims for multi factor authentication';



CREATE TABLE IF NOT EXISTS "auth"."mfa_challenges" (
    "id" "uuid" NOT NULL,
    "factor_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "verified_at" timestamp with time zone,
    "ip_address" "inet" NOT NULL,
    "otp_code" "text",
    "web_authn_session_data" "jsonb"
);


ALTER TABLE "auth"."mfa_challenges" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."mfa_challenges" IS 'auth: stores metadata about challenge requests made';



CREATE TABLE IF NOT EXISTS "auth"."mfa_factors" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "friendly_name" "text",
    "factor_type" "auth"."factor_type" NOT NULL,
    "status" "auth"."factor_status" NOT NULL,
    "created_at" timestamp with time zone NOT NULL,
    "updated_at" timestamp with time zone NOT NULL,
    "secret" "text",
    "phone" "text",
    "last_challenged_at" timestamp with time zone,
    "web_authn_credential" "jsonb",
    "web_authn_aaguid" "uuid"
);


ALTER TABLE "auth"."mfa_factors" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."mfa_factors" IS 'auth: stores metadata about factors';



CREATE TABLE IF NOT EXISTS "auth"."one_time_tokens" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "token_type" "auth"."one_time_token_type" NOT NULL,
    "token_hash" "text" NOT NULL,
    "relates_to" "text" NOT NULL,
    "created_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp without time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "one_time_tokens_token_hash_check" CHECK (("char_length"("token_hash") > 0))
);


ALTER TABLE "auth"."one_time_tokens" OWNER TO "supabase_auth_admin";


CREATE TABLE IF NOT EXISTS "auth"."refresh_tokens" (
    "instance_id" "uuid",
    "id" bigint NOT NULL,
    "token" character varying(255),
    "user_id" character varying(255),
    "revoked" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "parent" character varying(255),
    "session_id" "uuid"
);


ALTER TABLE "auth"."refresh_tokens" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."refresh_tokens" IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';



CREATE SEQUENCE IF NOT EXISTS "auth"."refresh_tokens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "auth"."refresh_tokens_id_seq" OWNER TO "supabase_auth_admin";


ALTER SEQUENCE "auth"."refresh_tokens_id_seq" OWNED BY "auth"."refresh_tokens"."id";



CREATE TABLE IF NOT EXISTS "auth"."saml_providers" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "entity_id" "text" NOT NULL,
    "metadata_xml" "text" NOT NULL,
    "metadata_url" "text",
    "attribute_mapping" "jsonb",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "name_id_format" "text",
    CONSTRAINT "entity_id not empty" CHECK (("char_length"("entity_id") > 0)),
    CONSTRAINT "metadata_url not empty" CHECK ((("metadata_url" = NULL::"text") OR ("char_length"("metadata_url") > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK (("char_length"("metadata_xml") > 0))
);


ALTER TABLE "auth"."saml_providers" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."saml_providers" IS 'Auth: Manages SAML Identity Provider connections.';



CREATE TABLE IF NOT EXISTS "auth"."saml_relay_states" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "request_id" "text" NOT NULL,
    "for_email" "text",
    "redirect_to" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "flow_state_id" "uuid",
    CONSTRAINT "request_id not empty" CHECK (("char_length"("request_id") > 0))
);


ALTER TABLE "auth"."saml_relay_states" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."saml_relay_states" IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';



CREATE TABLE IF NOT EXISTS "auth"."schema_migrations" (
    "version" character varying(255) NOT NULL
);


ALTER TABLE "auth"."schema_migrations" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."schema_migrations" IS 'Auth: Manages updates to the auth system.';



CREATE TABLE IF NOT EXISTS "auth"."sessions" (
    "id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "factor_id" "uuid",
    "aal" "auth"."aal_level",
    "not_after" timestamp with time zone,
    "refreshed_at" timestamp without time zone,
    "user_agent" "text",
    "ip" "inet",
    "tag" "text"
);


ALTER TABLE "auth"."sessions" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."sessions" IS 'Auth: Stores session data associated to a user.';



COMMENT ON COLUMN "auth"."sessions"."not_after" IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';



CREATE TABLE IF NOT EXISTS "auth"."sso_domains" (
    "id" "uuid" NOT NULL,
    "sso_provider_id" "uuid" NOT NULL,
    "domain" "text" NOT NULL,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK (("char_length"("domain") > 0))
);


ALTER TABLE "auth"."sso_domains" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."sso_domains" IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';



CREATE TABLE IF NOT EXISTS "auth"."sso_providers" (
    "id" "uuid" NOT NULL,
    "resource_id" "text",
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK ((("resource_id" = NULL::"text") OR ("char_length"("resource_id") > 0)))
);


ALTER TABLE "auth"."sso_providers" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."sso_providers" IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';



COMMENT ON COLUMN "auth"."sso_providers"."resource_id" IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';



CREATE TABLE IF NOT EXISTS "auth"."users" (
    "instance_id" "uuid",
    "id" "uuid" NOT NULL,
    "aud" character varying(255),
    "role" character varying(255),
    "email" character varying(255),
    "encrypted_password" character varying(255),
    "email_confirmed_at" timestamp with time zone,
    "invited_at" timestamp with time zone,
    "confirmation_token" character varying(255),
    "confirmation_sent_at" timestamp with time zone,
    "recovery_token" character varying(255),
    "recovery_sent_at" timestamp with time zone,
    "email_change_token_new" character varying(255),
    "email_change" character varying(255),
    "email_change_sent_at" timestamp with time zone,
    "last_sign_in_at" timestamp with time zone,
    "raw_app_meta_data" "jsonb",
    "raw_user_meta_data" "jsonb",
    "is_super_admin" boolean,
    "created_at" timestamp with time zone,
    "updated_at" timestamp with time zone,
    "phone" "text" DEFAULT NULL::character varying,
    "phone_confirmed_at" timestamp with time zone,
    "phone_change" "text" DEFAULT ''::character varying,
    "phone_change_token" character varying(255) DEFAULT ''::character varying,
    "phone_change_sent_at" timestamp with time zone,
    "confirmed_at" timestamp with time zone GENERATED ALWAYS AS (LEAST("email_confirmed_at", "phone_confirmed_at")) STORED,
    "email_change_token_current" character varying(255) DEFAULT ''::character varying,
    "email_change_confirm_status" smallint DEFAULT 0,
    "banned_until" timestamp with time zone,
    "reauthentication_token" character varying(255) DEFAULT ''::character varying,
    "reauthentication_sent_at" timestamp with time zone,
    "is_sso_user" boolean DEFAULT false NOT NULL,
    "deleted_at" timestamp with time zone,
    "is_anonymous" boolean DEFAULT false NOT NULL,
    CONSTRAINT "users_email_change_confirm_status_check" CHECK ((("email_change_confirm_status" >= 0) AND ("email_change_confirm_status" <= 2)))
);


ALTER TABLE "auth"."users" OWNER TO "supabase_auth_admin";


COMMENT ON TABLE "auth"."users" IS 'Auth: Stores user login data within a secure schema.';



COMMENT ON COLUMN "auth"."users"."is_sso_user" IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';



CREATE TABLE IF NOT EXISTS "public"."asset_types" (
    "asset_type_id" integer NOT NULL,
    "asset_type_name" character varying(100) NOT NULL,
    "description" "text"
);


ALTER TABLE "public"."asset_types" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."asset_types_asset_type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."asset_types_asset_type_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."asset_types_asset_type_id_seq" OWNED BY "public"."asset_types"."asset_type_id";



CREATE TABLE IF NOT EXISTS "public"."assets" (
    "asset_id" integer NOT NULL,
    "asset_type_id" integer NOT NULL,
    "make" character varying(100) NOT NULL,
    "model" character varying(100) NOT NULL,
    "serial_number" character varying(50) NOT NULL,
    "purchase_date" "date",
    "warranty_expiry" "date",
    "purchase_invoice_number" character varying(50),
    "order_number" character varying(50),
    "location_id" integer NOT NULL,
    "department_id" integer NOT NULL,
    "employee_id" integer,
    "description" "text",
    "blank_field_1" "text",
    "blank_field_2" "text",
    "blank_field_3" "text",
    "specification" "text",
    "sap_reference" character varying(50),
    "status" character varying(20) DEFAULT 'in_stock'::character varying NOT NULL,
    "sub_location_id" integer,
    "section_id" integer,
    CONSTRAINT "assets_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['in_stock'::character varying, 'assigned'::character varying, 'in_maintenance'::character varying, 'retired'::character varying, 'disposed'::character varying])::"text"[])))
);


ALTER TABLE "public"."assets" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."assets_asset_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."assets_asset_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."assets_asset_id_seq" OWNED BY "public"."assets"."asset_id";



CREATE TABLE IF NOT EXISTS "public"."departments" (
    "department_id" integer NOT NULL,
    "department_name" character varying(100) NOT NULL
);


ALTER TABLE "public"."departments" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."departments_department_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."departments_department_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."departments_department_id_seq" OWNED BY "public"."departments"."department_id";



CREATE TABLE IF NOT EXISTS "public"."disposed" (
    "disposed_id" integer NOT NULL,
    "asset_id" integer NOT NULL,
    "asset_type_id" integer NOT NULL,
    "make" character varying(100) NOT NULL,
    "model" character varying(100) NOT NULL,
    "serial_number" character varying(50) NOT NULL,
    "purchase_date" "date",
    "warranty_expiry" "date",
    "purchase_invoice_number" character varying(50),
    "order_number" character varying(50),
    "location_id" integer NOT NULL,
    "department_id" integer NOT NULL,
    "description" "text",
    "blank_field_1" "text",
    "blank_field_2" "text",
    "blank_field_3" "text",
    "specification" "text",
    "sap_reference" character varying(50),
    "disposed_date" "date" DEFAULT CURRENT_DATE NOT NULL,
    "reason" "text"
);


ALTER TABLE "public"."disposed" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."employees" (
    "employee_id" integer NOT NULL,
    "employee_name" character varying(100) NOT NULL,
    "email" character varying(100) NOT NULL,
    "department_id" integer NOT NULL,
    "location_id" integer NOT NULL,
    "phone_no" character varying(20),
    "role" character varying(20) NOT NULL,
    CONSTRAINT "employees_role_check" CHECK ((("role")::"text" = ANY ((ARRAY['admin'::character varying, 'manager'::character varying, 'employee'::character varying])::"text"[])))
);


ALTER TABLE "public"."employees" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."employees_employee_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."employees_employee_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."employees_employee_id_seq" OWNED BY "public"."employees"."employee_id";



CREATE TABLE IF NOT EXISTS "public"."locations" (
    "location_id" integer NOT NULL,
    "location_name" character varying(100) NOT NULL
);


ALTER TABLE "public"."locations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."locations_location_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."locations_location_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."locations_location_id_seq" OWNED BY "public"."locations"."location_id";



CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "updated_at" timestamp with time zone,
    "username" "text",
    "full_name" "text",
    "avatar_url" "text",
    "website" "text",
    "role" "text" DEFAULT 'user'::"text" NOT NULL,
    CONSTRAINT "profiles_role_check" CHECK (("role" = ANY (ARRAY['user'::"text", 'master'::"text", 'admin'::"text"]))),
    CONSTRAINT "username_length" CHECK (("char_length"("username") >= 3))
);


ALTER TABLE "public"."profiles" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."scrap_scrap_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."scrap_scrap_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."scrap_scrap_id_seq" OWNED BY "public"."disposed"."disposed_id";



CREATE TABLE IF NOT EXISTS "public"."sections" (
    "section_id" integer NOT NULL,
    "section_name" character varying(100) NOT NULL,
    "department_id" integer NOT NULL
);


ALTER TABLE "public"."sections" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."sections_section_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."sections_section_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."sections_section_id_seq" OWNED BY "public"."sections"."section_id";



CREATE TABLE IF NOT EXISTS "public"."stock" (
    "stock_id" integer NOT NULL,
    "asset_id" integer NOT NULL,
    "asset_type_id" integer NOT NULL,
    "make" character varying(100) NOT NULL,
    "model" character varying(100) NOT NULL,
    "serial_number" character varying(50) NOT NULL,
    "purchase_date" "date",
    "warranty_expiry" "date",
    "purchase_invoice_number" character varying(50),
    "order_number" character varying(50),
    "location_id" integer NOT NULL,
    "department_id" integer NOT NULL,
    "description" "text",
    "blank_field_1" "text",
    "blank_field_2" "text",
    "blank_field_3" "text",
    "specification" "text",
    "sap_reference" character varying(50),
    "status" character varying(50) DEFAULT 'in_stock'::character varying NOT NULL,
    "notes" "text",
    CONSTRAINT "stock_status_check" CHECK ((("status")::"text" = ANY ((ARRAY['assigned'::character varying, 'in_stock'::character varying, 'in_maintenance'::character varying, 'retired'::character varying])::"text"[])))
);


ALTER TABLE "public"."stock" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."stock_stock_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."stock_stock_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."stock_stock_id_seq" OWNED BY "public"."stock"."stock_id";



CREATE TABLE IF NOT EXISTS "public"."sub_locations" (
    "sub_location_id" integer NOT NULL,
    "location_id" integer NOT NULL,
    "sub_location_name" character varying(100) NOT NULL
);


ALTER TABLE "public"."sub_locations" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."sub_locations_sub_location_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."sub_locations_sub_location_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."sub_locations_sub_location_id_seq" OWNED BY "public"."sub_locations"."sub_location_id";



CREATE TABLE IF NOT EXISTS "public"."table_permissions" (
    "id" integer NOT NULL,
    "user_id" "uuid",
    "table_name" "text" NOT NULL,
    "permission" "text" NOT NULL,
    CONSTRAINT "table_permissions_permission_check" CHECK (("permission" = ANY (ARRAY['read'::"text", 'write'::"text", 'all'::"text"])))
);


ALTER TABLE "public"."table_permissions" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."table_permissions_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."table_permissions_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."table_permissions_id_seq" OWNED BY "public"."table_permissions"."id";



CREATE TABLE IF NOT EXISTS "public"."transfer_history" (
    "transfer_id" integer NOT NULL,
    "asset_id" integer,
    "make" character varying(100) NOT NULL,
    "model" character varying(100) NOT NULL,
    "from_employee_id" integer,
    "to_employee_id" integer,
    "from_department_id" integer NOT NULL,
    "to_department_id" integer NOT NULL,
    "from_location_id" integer NOT NULL,
    "to_location_id" integer NOT NULL,
    "transfer_date" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "notes" "text"
);


ALTER TABLE "public"."transfer_history" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."transfer_history_transfer_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."transfer_history_transfer_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."transfer_history_transfer_id_seq" OWNED BY "public"."transfer_history"."transfer_id";



CREATE TABLE IF NOT EXISTS "public"."vendors" (
    "vendor_id" integer NOT NULL,
    "vendor_name" character varying(100) NOT NULL,
    "contact_email" character varying(100),
    "phone" character varying(20),
    "address" "text",
    "remarks" "text"
);


ALTER TABLE "public"."vendors" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."vendors_vendor_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."vendors_vendor_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."vendors_vendor_id_seq" OWNED BY "public"."vendors"."vendor_id";



CREATE OR REPLACE VIEW "public"."view_disposed_assets_full" AS
 SELECT "d"."disposed_id",
    "d"."asset_id",
    "d"."asset_type_id",
    "d"."make",
    "d"."model",
    "d"."serial_number",
    "d"."purchase_date",
    "d"."warranty_expiry",
    "d"."purchase_invoice_number",
    "d"."order_number",
    "d"."location_id",
    "d"."department_id",
    "d"."description",
    "d"."blank_field_1",
    "d"."blank_field_2",
    "d"."blank_field_3",
    "d"."specification",
    "d"."sap_reference",
    "d"."disposed_date",
    "d"."reason",
    "at"."asset_type_name",
    "l"."location_name",
    "dept"."department_name"
   FROM ((("public"."disposed" "d"
     LEFT JOIN "public"."asset_types" "at" ON (("d"."asset_type_id" = "at"."asset_type_id")))
     LEFT JOIN "public"."locations" "l" ON (("d"."location_id" = "l"."location_id")))
     LEFT JOIN "public"."departments" "dept" ON (("d"."department_id" = "dept"."department_id")))
  ORDER BY "d"."disposed_date" DESC;


ALTER VIEW "public"."view_disposed_assets_full" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_sections_with_departments" AS
 SELECT "s"."section_id",
    "s"."section_name",
    "s"."department_id",
    "d"."department_name"
   FROM ("public"."sections" "s"
     JOIN "public"."departments" "d" ON (("s"."department_id" = "d"."department_id")));


ALTER VIEW "public"."view_sections_with_departments" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_sub_locations" AS
 SELECT "sl"."sub_location_id",
    "sl"."sub_location_name",
    "sl"."location_id",
    "l"."location_name"
   FROM ("public"."sub_locations" "sl"
     JOIN "public"."locations" "l" ON (("sl"."location_id" = "l"."location_id")))
  ORDER BY "l"."location_name", "sl"."sub_location_name";


ALTER VIEW "public"."view_sub_locations" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."view_transfer_history_enriched" AS
 SELECT "th"."transfer_id",
    "th"."asset_id",
    "th"."make",
    "th"."model",
    "th"."transfer_date",
    "th"."notes",
    "e_from"."employee_name" AS "from_employee_name",
    "e_to"."employee_name" AS "to_employee_name",
    "d_from"."department_name" AS "from_department_name",
    "d_to"."department_name" AS "to_department_name",
    "l_from"."location_name" AS "from_location_name",
    "l_to"."location_name" AS "to_location_name"
   FROM (((((("public"."transfer_history" "th"
     LEFT JOIN "public"."employees" "e_from" ON (("e_from"."employee_id" = "th"."from_employee_id")))
     LEFT JOIN "public"."employees" "e_to" ON (("e_to"."employee_id" = "th"."to_employee_id")))
     LEFT JOIN "public"."departments" "d_from" ON (("d_from"."department_id" = "th"."from_department_id")))
     LEFT JOIN "public"."departments" "d_to" ON (("d_to"."department_id" = "th"."to_department_id")))
     LEFT JOIN "public"."locations" "l_from" ON (("l_from"."location_id" = "th"."from_location_id")))
     LEFT JOIN "public"."locations" "l_to" ON (("l_to"."location_id" = "th"."to_location_id")))
  ORDER BY "th"."transfer_date" DESC;


ALTER VIEW "public"."view_transfer_history_enriched" OWNER TO "postgres";


ALTER TABLE ONLY "auth"."refresh_tokens" ALTER COLUMN "id" SET DEFAULT "nextval"('"auth"."refresh_tokens_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."asset_types" ALTER COLUMN "asset_type_id" SET DEFAULT "nextval"('"public"."asset_types_asset_type_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."assets" ALTER COLUMN "asset_id" SET DEFAULT "nextval"('"public"."assets_asset_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."departments" ALTER COLUMN "department_id" SET DEFAULT "nextval"('"public"."departments_department_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."disposed" ALTER COLUMN "disposed_id" SET DEFAULT "nextval"('"public"."scrap_scrap_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."employees" ALTER COLUMN "employee_id" SET DEFAULT "nextval"('"public"."employees_employee_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."locations" ALTER COLUMN "location_id" SET DEFAULT "nextval"('"public"."locations_location_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."sections" ALTER COLUMN "section_id" SET DEFAULT "nextval"('"public"."sections_section_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."stock" ALTER COLUMN "stock_id" SET DEFAULT "nextval"('"public"."stock_stock_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."sub_locations" ALTER COLUMN "sub_location_id" SET DEFAULT "nextval"('"public"."sub_locations_sub_location_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."table_permissions" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."table_permissions_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."transfer_history" ALTER COLUMN "transfer_id" SET DEFAULT "nextval"('"public"."transfer_history_transfer_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."vendors" ALTER COLUMN "vendor_id" SET DEFAULT "nextval"('"public"."vendors_vendor_id_seq"'::"regclass");



ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "amr_id_pk" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."audit_log_entries"
    ADD CONSTRAINT "audit_log_entries_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."flow_state"
    ADD CONSTRAINT "flow_state_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_provider_id_provider_unique" UNIQUE ("provider_id", "provider");



ALTER TABLE ONLY "auth"."instances"
    ADD CONSTRAINT "instances_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_authentication_method_pkey" UNIQUE ("session_id", "authentication_method");



ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_last_challenged_at_key" UNIQUE ("last_challenged_at");



ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_token_unique" UNIQUE ("token");



ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_entity_id_key" UNIQUE ("entity_id");



ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."schema_migrations"
    ADD CONSTRAINT "schema_migrations_pkey" PRIMARY KEY ("version");



ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."sso_providers"
    ADD CONSTRAINT "sso_providers_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_phone_key" UNIQUE ("phone");



ALTER TABLE ONLY "auth"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."asset_types"
    ADD CONSTRAINT "asset_types_pkey" PRIMARY KEY ("asset_type_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_pkey" PRIMARY KEY ("asset_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_serial_number_key" UNIQUE ("serial_number");



ALTER TABLE ONLY "public"."departments"
    ADD CONSTRAINT "departments_pkey" PRIMARY KEY ("department_id");



ALTER TABLE ONLY "public"."disposed"
    ADD CONSTRAINT "disposed_old_asset_id_key" UNIQUE ("asset_id");



ALTER TABLE ONLY "public"."disposed"
    ADD CONSTRAINT "disposed_pkey" PRIMARY KEY ("disposed_id");



ALTER TABLE ONLY "public"."disposed"
    ADD CONSTRAINT "disposed_serial_number_key" UNIQUE ("serial_number");



ALTER TABLE ONLY "public"."employees"
    ADD CONSTRAINT "employees_email_key" UNIQUE ("email");



ALTER TABLE ONLY "public"."employees"
    ADD CONSTRAINT "employees_pkey" PRIMARY KEY ("employee_id");



ALTER TABLE ONLY "public"."locations"
    ADD CONSTRAINT "locations_pkey" PRIMARY KEY ("location_id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_username_key" UNIQUE ("username");



ALTER TABLE ONLY "public"."sections"
    ADD CONSTRAINT "sections_pkey" PRIMARY KEY ("section_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_asset_id_key" UNIQUE ("asset_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_pkey" PRIMARY KEY ("stock_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_serial_number_key" UNIQUE ("serial_number");



ALTER TABLE ONLY "public"."sub_locations"
    ADD CONSTRAINT "sub_locations_pkey" PRIMARY KEY ("sub_location_id");



ALTER TABLE ONLY "public"."table_permissions"
    ADD CONSTRAINT "table_permissions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."table_permissions"
    ADD CONSTRAINT "table_permissions_user_table_unique" UNIQUE ("user_id", "table_name");



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_pkey" PRIMARY KEY ("transfer_id");



ALTER TABLE ONLY "public"."vendors"
    ADD CONSTRAINT "vendors_pkey" PRIMARY KEY ("vendor_id");



CREATE INDEX "audit_logs_instance_id_idx" ON "auth"."audit_log_entries" USING "btree" ("instance_id");



CREATE UNIQUE INDEX "confirmation_token_idx" ON "auth"."users" USING "btree" ("confirmation_token") WHERE (("confirmation_token")::"text" !~ '^[0-9 ]*$'::"text");



CREATE UNIQUE INDEX "email_change_token_current_idx" ON "auth"."users" USING "btree" ("email_change_token_current") WHERE (("email_change_token_current")::"text" !~ '^[0-9 ]*$'::"text");



CREATE UNIQUE INDEX "email_change_token_new_idx" ON "auth"."users" USING "btree" ("email_change_token_new") WHERE (("email_change_token_new")::"text" !~ '^[0-9 ]*$'::"text");



CREATE INDEX "factor_id_created_at_idx" ON "auth"."mfa_factors" USING "btree" ("user_id", "created_at");



CREATE INDEX "flow_state_created_at_idx" ON "auth"."flow_state" USING "btree" ("created_at" DESC);



CREATE INDEX "identities_email_idx" ON "auth"."identities" USING "btree" ("email" "text_pattern_ops");



COMMENT ON INDEX "auth"."identities_email_idx" IS 'Auth: Ensures indexed queries on the email column';



CREATE INDEX "identities_user_id_idx" ON "auth"."identities" USING "btree" ("user_id");



CREATE INDEX "idx_auth_code" ON "auth"."flow_state" USING "btree" ("auth_code");



CREATE INDEX "idx_user_id_auth_method" ON "auth"."flow_state" USING "btree" ("user_id", "authentication_method");



CREATE INDEX "mfa_challenge_created_at_idx" ON "auth"."mfa_challenges" USING "btree" ("created_at" DESC);



CREATE UNIQUE INDEX "mfa_factors_user_friendly_name_unique" ON "auth"."mfa_factors" USING "btree" ("friendly_name", "user_id") WHERE (TRIM(BOTH FROM "friendly_name") <> ''::"text");



CREATE INDEX "mfa_factors_user_id_idx" ON "auth"."mfa_factors" USING "btree" ("user_id");



CREATE INDEX "one_time_tokens_relates_to_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("relates_to");



CREATE INDEX "one_time_tokens_token_hash_hash_idx" ON "auth"."one_time_tokens" USING "hash" ("token_hash");



CREATE UNIQUE INDEX "one_time_tokens_user_id_token_type_key" ON "auth"."one_time_tokens" USING "btree" ("user_id", "token_type");



CREATE UNIQUE INDEX "reauthentication_token_idx" ON "auth"."users" USING "btree" ("reauthentication_token") WHERE (("reauthentication_token")::"text" !~ '^[0-9 ]*$'::"text");



CREATE UNIQUE INDEX "recovery_token_idx" ON "auth"."users" USING "btree" ("recovery_token") WHERE (("recovery_token")::"text" !~ '^[0-9 ]*$'::"text");



CREATE INDEX "refresh_tokens_instance_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id");



CREATE INDEX "refresh_tokens_instance_id_user_id_idx" ON "auth"."refresh_tokens" USING "btree" ("instance_id", "user_id");



CREATE INDEX "refresh_tokens_parent_idx" ON "auth"."refresh_tokens" USING "btree" ("parent");



CREATE INDEX "refresh_tokens_session_id_revoked_idx" ON "auth"."refresh_tokens" USING "btree" ("session_id", "revoked");



CREATE INDEX "refresh_tokens_updated_at_idx" ON "auth"."refresh_tokens" USING "btree" ("updated_at" DESC);



CREATE INDEX "saml_providers_sso_provider_id_idx" ON "auth"."saml_providers" USING "btree" ("sso_provider_id");



CREATE INDEX "saml_relay_states_created_at_idx" ON "auth"."saml_relay_states" USING "btree" ("created_at" DESC);



CREATE INDEX "saml_relay_states_for_email_idx" ON "auth"."saml_relay_states" USING "btree" ("for_email");



CREATE INDEX "saml_relay_states_sso_provider_id_idx" ON "auth"."saml_relay_states" USING "btree" ("sso_provider_id");



CREATE INDEX "sessions_not_after_idx" ON "auth"."sessions" USING "btree" ("not_after" DESC);



CREATE INDEX "sessions_user_id_idx" ON "auth"."sessions" USING "btree" ("user_id");



CREATE UNIQUE INDEX "sso_domains_domain_idx" ON "auth"."sso_domains" USING "btree" ("lower"("domain"));



CREATE INDEX "sso_domains_sso_provider_id_idx" ON "auth"."sso_domains" USING "btree" ("sso_provider_id");



CREATE UNIQUE INDEX "sso_providers_resource_id_idx" ON "auth"."sso_providers" USING "btree" ("lower"("resource_id"));



CREATE UNIQUE INDEX "unique_phone_factor_per_user" ON "auth"."mfa_factors" USING "btree" ("user_id", "phone");



CREATE INDEX "user_id_created_at_idx" ON "auth"."sessions" USING "btree" ("user_id", "created_at");



CREATE UNIQUE INDEX "users_email_partial_key" ON "auth"."users" USING "btree" ("email") WHERE ("is_sso_user" = false);



COMMENT ON INDEX "auth"."users_email_partial_key" IS 'Auth: A partial unique index that applies only when is_sso_user is false';



CREATE INDEX "users_instance_id_email_idx" ON "auth"."users" USING "btree" ("instance_id", "lower"(("email")::"text"));



CREATE INDEX "users_instance_id_idx" ON "auth"."users" USING "btree" ("instance_id");



CREATE INDEX "users_is_anonymous_idx" ON "auth"."users" USING "btree" ("is_anonymous");



CREATE OR REPLACE TRIGGER "on_auth_user_created" AFTER INSERT ON "auth"."users" FOR EACH ROW EXECUTE FUNCTION "public"."handle_new_user"();



CREATE OR REPLACE TRIGGER "check_section_department" BEFORE INSERT OR UPDATE ON "public"."assets" FOR EACH ROW EXECUTE FUNCTION "public"."validate_section_department_match"();



CREATE OR REPLACE TRIGGER "check_sublocation_location" BEFORE INSERT OR UPDATE ON "public"."assets" FOR EACH ROW EXECUTE FUNCTION "public"."validate_sublocation_location_match"();



CREATE OR REPLACE TRIGGER "trg_auto_set_asset_status" BEFORE INSERT OR UPDATE ON "public"."assets" FOR EACH ROW EXECUTE FUNCTION "public"."auto_set_asset_status"();



CREATE OR REPLACE TRIGGER "trg_move_asset_to_disposed" AFTER UPDATE ON "public"."assets" FOR EACH ROW EXECUTE FUNCTION "public"."move_asset_to_disposed"();



CREATE OR REPLACE TRIGGER "trigger_log_asset_transfer" AFTER UPDATE ON "public"."assets" FOR EACH ROW EXECUTE FUNCTION "public"."log_asset_transfer"();



ALTER TABLE ONLY "auth"."identities"
    ADD CONSTRAINT "identities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."mfa_amr_claims"
    ADD CONSTRAINT "mfa_amr_claims_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."mfa_challenges"
    ADD CONSTRAINT "mfa_challenges_auth_factor_id_fkey" FOREIGN KEY ("factor_id") REFERENCES "auth"."mfa_factors"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."mfa_factors"
    ADD CONSTRAINT "mfa_factors_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."one_time_tokens"
    ADD CONSTRAINT "one_time_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."refresh_tokens"
    ADD CONSTRAINT "refresh_tokens_session_id_fkey" FOREIGN KEY ("session_id") REFERENCES "auth"."sessions"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."saml_providers"
    ADD CONSTRAINT "saml_providers_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_flow_state_id_fkey" FOREIGN KEY ("flow_state_id") REFERENCES "auth"."flow_state"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."saml_relay_states"
    ADD CONSTRAINT "saml_relay_states_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."sessions"
    ADD CONSTRAINT "sessions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "auth"."sso_domains"
    ADD CONSTRAINT "sso_domains_sso_provider_id_fkey" FOREIGN KEY ("sso_provider_id") REFERENCES "auth"."sso_providers"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_asset_type_id_fkey" FOREIGN KEY ("asset_type_id") REFERENCES "public"."asset_types"("asset_type_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "public"."employees"("employee_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("location_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_section_id_fkey" FOREIGN KEY ("section_id") REFERENCES "public"."sections"("section_id");



ALTER TABLE ONLY "public"."assets"
    ADD CONSTRAINT "assets_sub_location_id_fkey" FOREIGN KEY ("sub_location_id") REFERENCES "public"."sub_locations"("sub_location_id");



ALTER TABLE ONLY "public"."disposed"
    ADD CONSTRAINT "disposed_asset_type_id_fkey" FOREIGN KEY ("asset_type_id") REFERENCES "public"."asset_types"("asset_type_id");



ALTER TABLE ONLY "public"."disposed"
    ADD CONSTRAINT "disposed_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."disposed"
    ADD CONSTRAINT "disposed_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("location_id");



ALTER TABLE ONLY "public"."employees"
    ADD CONSTRAINT "employees_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."employees"
    ADD CONSTRAINT "employees_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("location_id");



ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."sections"
    ADD CONSTRAINT "sections_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."assets"("asset_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_asset_type_id_fkey" FOREIGN KEY ("asset_type_id") REFERENCES "public"."asset_types"("asset_type_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_department_id_fkey" FOREIGN KEY ("department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."stock"
    ADD CONSTRAINT "stock_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("location_id");



ALTER TABLE ONLY "public"."sub_locations"
    ADD CONSTRAINT "sub_locations_location_id_fkey" FOREIGN KEY ("location_id") REFERENCES "public"."locations"("location_id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."table_permissions"
    ADD CONSTRAINT "table_permissions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."profiles"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_asset_id_fkey" FOREIGN KEY ("asset_id") REFERENCES "public"."assets"("asset_id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_from_department_id_fkey" FOREIGN KEY ("from_department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_from_employee_id_fkey" FOREIGN KEY ("from_employee_id") REFERENCES "public"."employees"("employee_id");



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_from_location_id_fkey" FOREIGN KEY ("from_location_id") REFERENCES "public"."locations"("location_id");



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_to_department_id_fkey" FOREIGN KEY ("to_department_id") REFERENCES "public"."departments"("department_id");



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_to_employee_id_fkey" FOREIGN KEY ("to_employee_id") REFERENCES "public"."employees"("employee_id");



ALTER TABLE ONLY "public"."transfer_history"
    ADD CONSTRAINT "transfer_history_to_location_id_fkey" FOREIGN KEY ("to_location_id") REFERENCES "public"."locations"("location_id");



CREATE POLICY "Users can view their own profile" ON "auth"."users" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "id"));



ALTER TABLE "auth"."audit_log_entries" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."flow_state" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."identities" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."instances" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."mfa_amr_claims" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."mfa_challenges" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."mfa_factors" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."one_time_tokens" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."refresh_tokens" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."saml_providers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."saml_relay_states" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."schema_migrations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."sessions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."sso_domains" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."sso_providers" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "auth"."users" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "Admin/master or permitted user can modify" ON "public"."asset_types" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'asset_types'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'asset_types'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."assets" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'assets'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'assets'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."departments" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'departments'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'departments'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."disposed" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'disposed'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'disposed'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."employees" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'employees'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'employees'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."locations" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'locations'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'locations'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."sections" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'sections'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'sections'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."stock" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'stock'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'stock'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."sub_locations" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'sub_locations'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'sub_locations'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."transfer_history" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'transfer_history'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'transfer_history'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admin/master or permitted user can modify" ON "public"."vendors" USING (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'vendors'::"text") AND ("tp"."permission" = 'all'::"text")))))) WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'vendors'::"text") AND ("tp"."permission" = 'all'::"text"))))));



CREATE POLICY "Admins can manage permissions" ON "public"."table_permissions" USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text"))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = 'admin'::"text")))));



CREATE POLICY "Admins can read all profiles" ON "public"."profiles" FOR SELECT USING ("public"."is_admin"("auth"."uid"()));



CREATE POLICY "Allow admin to manage profiles" ON "public"."profiles" USING ("public"."is_admin"("auth"."uid"())) WITH CHECK ("public"."is_admin"("auth"."uid"()));



CREATE POLICY "Allow read for authenticated users" ON "public"."asset_types" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."assets" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."departments" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."disposed" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."employees" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."locations" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."sections" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."stock" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."sub_locations" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."transfer_history" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Allow read for authenticated users" ON "public"."vendors" FOR SELECT USING ((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE ("p"."id" = "auth"."uid"()))));



CREATE POLICY "Assets editors can log transfers" ON "public"."transfer_history" FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."profiles" "p"
  WHERE (("p"."id" = "auth"."uid"()) AND ("p"."role" = ANY (ARRAY['admin'::"text", 'master'::"text"]))))) OR (EXISTS ( SELECT 1
   FROM "public"."table_permissions" "tp"
  WHERE (("tp"."user_id" = "auth"."uid"()) AND ("tp"."table_name" = 'assets'::"text") AND ("tp"."permission" = ANY (ARRAY['write'::"text", 'all'::"text"])))))));



CREATE POLICY "User can read own permissions" ON "public"."table_permissions" FOR SELECT USING (("user_id" = "auth"."uid"()));



CREATE POLICY "Users can read their own profile" ON "public"."profiles" FOR SELECT USING (("id" = "auth"."uid"()));



ALTER TABLE "public"."asset_types" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assets" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."departments" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."disposed" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."employees" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."locations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sections" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."stock" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."sub_locations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."table_permissions" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."transfer_history" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."vendors" ENABLE ROW LEVEL SECURITY;


GRANT USAGE ON SCHEMA "auth" TO "anon";
GRANT USAGE ON SCHEMA "auth" TO "authenticated";
GRANT USAGE ON SCHEMA "auth" TO "service_role";
GRANT ALL ON SCHEMA "auth" TO "supabase_auth_admin";
GRANT ALL ON SCHEMA "auth" TO "dashboard_user";
GRANT USAGE ON SCHEMA "auth" TO "postgres";



GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



GRANT ALL ON FUNCTION "auth"."email"() TO "dashboard_user";



GRANT ALL ON FUNCTION "auth"."jwt"() TO "postgres";
GRANT ALL ON FUNCTION "auth"."jwt"() TO "dashboard_user";



GRANT ALL ON FUNCTION "auth"."role"() TO "dashboard_user";



GRANT ALL ON FUNCTION "auth"."uid"() TO "dashboard_user";



GRANT ALL ON FUNCTION "public"."auto_set_asset_status"() TO "anon";
GRANT ALL ON FUNCTION "public"."auto_set_asset_status"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."auto_set_asset_status"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_user"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin"("uid" "uuid") TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin"("uid" "uuid") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin"("uid" "uuid") TO "service_role";



GRANT ALL ON FUNCTION "public"."is_admin_or_manager"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_admin_or_manager"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_admin_or_manager"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_manager"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_manager"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_manager"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_role"("role_name" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."is_role"("role_name" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_role"("role_name" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."log_asset_transfer"() TO "anon";
GRANT ALL ON FUNCTION "public"."log_asset_transfer"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."log_asset_transfer"() TO "service_role";



GRANT ALL ON FUNCTION "public"."move_asset_to_disposed"() TO "anon";
GRANT ALL ON FUNCTION "public"."move_asset_to_disposed"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."move_asset_to_disposed"() TO "service_role";



GRANT ALL ON FUNCTION "public"."setup_rls_policies"() TO "anon";
GRANT ALL ON FUNCTION "public"."setup_rls_policies"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."setup_rls_policies"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_section_department_match"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_section_department_match"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_section_department_match"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validate_sublocation_location_match"() TO "anon";
GRANT ALL ON FUNCTION "public"."validate_sublocation_location_match"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validate_sublocation_location_match"() TO "service_role";



GRANT ALL ON TABLE "auth"."audit_log_entries" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."audit_log_entries" TO "postgres";
GRANT SELECT ON TABLE "auth"."audit_log_entries" TO "postgres" WITH GRANT OPTION;



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."flow_state" TO "postgres";
GRANT SELECT ON TABLE "auth"."flow_state" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."flow_state" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."identities" TO "postgres";
GRANT SELECT ON TABLE "auth"."identities" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."identities" TO "dashboard_user";



GRANT ALL ON TABLE "auth"."instances" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."instances" TO "postgres";
GRANT SELECT ON TABLE "auth"."instances" TO "postgres" WITH GRANT OPTION;



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."mfa_amr_claims" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_amr_claims" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."mfa_amr_claims" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."mfa_challenges" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_challenges" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."mfa_challenges" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."mfa_factors" TO "postgres";
GRANT SELECT ON TABLE "auth"."mfa_factors" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."mfa_factors" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."one_time_tokens" TO "postgres";
GRANT SELECT ON TABLE "auth"."one_time_tokens" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."one_time_tokens" TO "dashboard_user";



GRANT ALL ON TABLE "auth"."refresh_tokens" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."refresh_tokens" TO "postgres";
GRANT SELECT ON TABLE "auth"."refresh_tokens" TO "postgres" WITH GRANT OPTION;



GRANT ALL ON SEQUENCE "auth"."refresh_tokens_id_seq" TO "dashboard_user";
GRANT ALL ON SEQUENCE "auth"."refresh_tokens_id_seq" TO "postgres";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."saml_providers" TO "postgres";
GRANT SELECT ON TABLE "auth"."saml_providers" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."saml_providers" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."saml_relay_states" TO "postgres";
GRANT SELECT ON TABLE "auth"."saml_relay_states" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."saml_relay_states" TO "dashboard_user";



GRANT SELECT ON TABLE "auth"."schema_migrations" TO "postgres" WITH GRANT OPTION;



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."sessions" TO "postgres";
GRANT SELECT ON TABLE "auth"."sessions" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."sessions" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."sso_domains" TO "postgres";
GRANT SELECT ON TABLE "auth"."sso_domains" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."sso_domains" TO "dashboard_user";



GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."sso_providers" TO "postgres";
GRANT SELECT ON TABLE "auth"."sso_providers" TO "postgres" WITH GRANT OPTION;
GRANT ALL ON TABLE "auth"."sso_providers" TO "dashboard_user";



GRANT ALL ON TABLE "auth"."users" TO "dashboard_user";
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,MAINTAIN,UPDATE ON TABLE "auth"."users" TO "postgres";
GRANT SELECT ON TABLE "auth"."users" TO "postgres" WITH GRANT OPTION;



GRANT ALL ON TABLE "public"."asset_types" TO "anon";
GRANT ALL ON TABLE "public"."asset_types" TO "authenticated";
GRANT ALL ON TABLE "public"."asset_types" TO "service_role";



GRANT ALL ON SEQUENCE "public"."asset_types_asset_type_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."asset_types_asset_type_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."asset_types_asset_type_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assets" TO "anon";
GRANT ALL ON TABLE "public"."assets" TO "authenticated";
GRANT ALL ON TABLE "public"."assets" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assets_asset_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assets_asset_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assets_asset_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."departments" TO "anon";
GRANT ALL ON TABLE "public"."departments" TO "authenticated";
GRANT ALL ON TABLE "public"."departments" TO "service_role";



GRANT ALL ON SEQUENCE "public"."departments_department_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."departments_department_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."departments_department_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."disposed" TO "anon";
GRANT ALL ON TABLE "public"."disposed" TO "authenticated";
GRANT ALL ON TABLE "public"."disposed" TO "service_role";



GRANT ALL ON TABLE "public"."employees" TO "anon";
GRANT ALL ON TABLE "public"."employees" TO "authenticated";
GRANT ALL ON TABLE "public"."employees" TO "service_role";



GRANT ALL ON SEQUENCE "public"."employees_employee_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."employees_employee_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."employees_employee_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."locations" TO "anon";
GRANT ALL ON TABLE "public"."locations" TO "authenticated";
GRANT ALL ON TABLE "public"."locations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."locations_location_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."locations_location_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."locations_location_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."profiles" TO "anon";
GRANT ALL ON TABLE "public"."profiles" TO "authenticated";
GRANT ALL ON TABLE "public"."profiles" TO "service_role";



GRANT ALL ON SEQUENCE "public"."scrap_scrap_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."scrap_scrap_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."scrap_scrap_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."sections" TO "anon";
GRANT ALL ON TABLE "public"."sections" TO "authenticated";
GRANT ALL ON TABLE "public"."sections" TO "service_role";



GRANT ALL ON SEQUENCE "public"."sections_section_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."sections_section_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."sections_section_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."stock" TO "anon";
GRANT ALL ON TABLE "public"."stock" TO "authenticated";
GRANT ALL ON TABLE "public"."stock" TO "service_role";



GRANT ALL ON SEQUENCE "public"."stock_stock_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."stock_stock_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."stock_stock_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."sub_locations" TO "anon";
GRANT ALL ON TABLE "public"."sub_locations" TO "authenticated";
GRANT ALL ON TABLE "public"."sub_locations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."sub_locations_sub_location_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."sub_locations_sub_location_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."sub_locations_sub_location_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."table_permissions" TO "anon";
GRANT ALL ON TABLE "public"."table_permissions" TO "authenticated";
GRANT ALL ON TABLE "public"."table_permissions" TO "service_role";



GRANT ALL ON SEQUENCE "public"."table_permissions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."table_permissions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."table_permissions_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."transfer_history" TO "anon";
GRANT ALL ON TABLE "public"."transfer_history" TO "authenticated";
GRANT ALL ON TABLE "public"."transfer_history" TO "service_role";



GRANT ALL ON SEQUENCE "public"."transfer_history_transfer_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."transfer_history_transfer_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."transfer_history_transfer_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."vendors" TO "anon";
GRANT ALL ON TABLE "public"."vendors" TO "authenticated";
GRANT ALL ON TABLE "public"."vendors" TO "service_role";



GRANT ALL ON SEQUENCE "public"."vendors_vendor_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."vendors_vendor_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."vendors_vendor_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."view_disposed_assets_full" TO "anon";
GRANT ALL ON TABLE "public"."view_disposed_assets_full" TO "authenticated";
GRANT ALL ON TABLE "public"."view_disposed_assets_full" TO "service_role";



GRANT ALL ON TABLE "public"."view_sections_with_departments" TO "anon";
GRANT ALL ON TABLE "public"."view_sections_with_departments" TO "authenticated";
GRANT ALL ON TABLE "public"."view_sections_with_departments" TO "service_role";



GRANT ALL ON TABLE "public"."view_sub_locations" TO "anon";
GRANT ALL ON TABLE "public"."view_sub_locations" TO "authenticated";
GRANT ALL ON TABLE "public"."view_sub_locations" TO "service_role";



GRANT ALL ON TABLE "public"."view_transfer_history_enriched" TO "anon";
GRANT ALL ON TABLE "public"."view_transfer_history_enriched" TO "authenticated";
GRANT ALL ON TABLE "public"."view_transfer_history_enriched" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON SEQUENCES TO "dashboard_user";



ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON FUNCTIONS TO "dashboard_user";



ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "supabase_auth_admin" IN SCHEMA "auth" GRANT ALL ON TABLES TO "dashboard_user";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";






RESET ALL;
