SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', '1b17ec4d-fd86-4821-b338-047c847f045a', '{"action":"user_confirmation_requested","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-21 16:33:23.987322+00', ''),
	('00000000-0000-0000-0000-000000000000', '7ec4d698-234c-48eb-a4b0-f8b81ab63b8d', '{"action":"user_signedup","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"team"}', '2025-06-21 16:33:43.380553+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a4ce2aae-dde8-436f-9354-f67d7421cea4', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-21 16:33:57.838295+00', ''),
	('00000000-0000-0000-0000-000000000000', '6af4de8e-e7d9-4d24-a421-f48d5c0bcac8', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 17:32:27.363808+00', ''),
	('00000000-0000-0000-0000-000000000000', '444f785c-83c2-44ff-aa4d-db5a548315c9', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 17:32:27.366003+00', ''),
	('00000000-0000-0000-0000-000000000000', '0056b013-d0ec-4838-930c-f0a69271a8d5', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 18:30:43.941575+00', ''),
	('00000000-0000-0000-0000-000000000000', '6dac197b-2576-4269-b207-55848b85e6e8', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 18:30:43.942419+00', ''),
	('00000000-0000-0000-0000-000000000000', '79135f5e-6209-4e64-9531-8348b49e03b9', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 19:28:47.667822+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a7c185a8-cf65-4ccc-8ba2-7e2b3431859c', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-21 19:28:47.669338+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c84332a9-9620-49be-947d-dbb94cc8ef62', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 06:44:44.756473+00', ''),
	('00000000-0000-0000-0000-000000000000', '5d89ccfa-ae2d-4df0-906d-dfac1e6766bd', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-22 06:47:37.897092+00', ''),
	('00000000-0000-0000-0000-000000000000', '3ab6af7a-d592-4534-86dc-030328b3790c', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-22 06:47:37.897913+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd5939851-6cee-4fd8-bfc5-8ea4c60a4df8', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-22 06:47:47.390018+00', ''),
	('00000000-0000-0000-0000-000000000000', '163bc96a-e14b-46f2-af43-2b41f8b7ceb0', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 06:47:57.206161+00', ''),
	('00000000-0000-0000-0000-000000000000', '817d4250-615b-45f7-b294-6cf5280850fd', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-22 07:50:27.189456+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb69832a-de7a-42d1-a527-fee72b25e24d', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-22 07:50:27.193278+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e6a0f2a-5b0b-4405-93e3-c527373339d3', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-22 08:40:30.407007+00', ''),
	('00000000-0000-0000-0000-000000000000', '8013a4ab-8d25-4b48-bf67-c446168d8e26', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 08:40:36.505078+00', ''),
	('00000000-0000-0000-0000-000000000000', '91224579-4068-4a6a-982a-ed356ecf54b2', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-22 08:40:38.01614+00', ''),
	('00000000-0000-0000-0000-000000000000', 'df00eef2-d68a-40ef-8e86-f0483235efcc', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 08:40:44.827802+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e07b4308-f10b-4fc4-89f2-5a05ec2d632b', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-22 08:40:46.60609+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd81987ad-ee00-4f54-a841-d57f5f05c025', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-22 09:15:07.115363+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b40dd4da-447f-409b-9674-4016218adbf6', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 08:27:16.236295+00', ''),
	('00000000-0000-0000-0000-000000000000', '0402773f-088b-4cda-90b9-e97d9234f52a', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 08:27:16.240191+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fe94e4ec-cee5-45cb-acf3-fbbe885d26f6', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-23 08:27:23.745408+00', ''),
	('00000000-0000-0000-0000-000000000000', '1b3a0b8f-14ed-4459-85d6-690d54602ba3', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-23 08:27:29.10405+00', ''),
	('00000000-0000-0000-0000-000000000000', '0cda504e-9589-4b8d-9100-c086b36ed806', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 10:06:18.370179+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd7a59ca-45a7-418d-a7ad-9a82b55e560f', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 10:06:18.372974+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b45b7f5-bba3-488a-98fa-67a0e314adb8', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-23 10:14:07.420755+00', ''),
	('00000000-0000-0000-0000-000000000000', '31ebab88-ce20-4f2e-9c85-0cdbd022b465', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-23 10:14:33.495525+00', ''),
	('00000000-0000-0000-0000-000000000000', '54ebc7a7-0c98-41ac-81fb-0a96fcf0c237', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-23 10:14:56.696381+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b04284f0-85b2-4943-9d96-a3d103d7a085', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-23 10:15:15.626364+00', ''),
	('00000000-0000-0000-0000-000000000000', '4c64fec2-7ae8-4006-b23f-3c2322a960ee', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-23 10:44:34.090287+00', ''),
	('00000000-0000-0000-0000-000000000000', '27d3975e-a223-41c7-8983-39695ae4f882', '{"action":"user_confirmation_requested","actor_id":"cecd3a40-6398-4b05-992d-54c0b21efc87","actor_username":"ap@exide.co.in","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-23 10:45:57.315112+00', ''),
	('00000000-0000-0000-0000-000000000000', '8ada5cef-c8ea-4f74-871b-24c70f754eb4', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-23 10:48:09.769205+00', ''),
	('00000000-0000-0000-0000-000000000000', '7d8ce749-6889-4ee4-adae-cce99fafbcb3', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 12:32:18.458387+00', ''),
	('00000000-0000-0000-0000-000000000000', '828dbfbc-37dd-4726-8b61-a5394e7c85fb', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 12:32:18.460056+00', ''),
	('00000000-0000-0000-0000-000000000000', '7ca9bc85-2b83-4009-bf9b-22bebf43b7ee', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 16:11:49.579933+00', ''),
	('00000000-0000-0000-0000-000000000000', '0c0cea3c-3300-4093-88b0-2d45dabf80d1', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 16:11:49.582912+00', ''),
	('00000000-0000-0000-0000-000000000000', '97c20730-f73b-4413-a2fc-87a298d54fb4', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 17:19:54.855366+00', ''),
	('00000000-0000-0000-0000-000000000000', '4d0ae3fe-52d7-42f7-9031-8a1a8d5098ef', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 17:19:54.856862+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cb5aca69-bb9b-443e-a3f4-3f51080a426c', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 18:17:59.542032+00', ''),
	('00000000-0000-0000-0000-000000000000', '93635304-1734-4f8d-90ad-b84f79ae4408', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 18:17:59.543432+00', ''),
	('00000000-0000-0000-0000-000000000000', '5438a979-a8b6-4fb9-9def-69eea2c68cb1', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-23 18:20:55.716764+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ee5ee556-7955-46e0-917c-9c5eb05f293f', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 19:16:15.290523+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5abc0f9-253e-44a4-a1e2-e543bd3ddeb4', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 19:16:15.292174+00', ''),
	('00000000-0000-0000-0000-000000000000', '7cb8e881-cc15-43ae-87fd-b54ed45d36c6', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 20:14:38.076256+00', ''),
	('00000000-0000-0000-0000-000000000000', '42121b28-d42d-4b18-93df-696fb0779662', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-23 20:14:38.081064+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ac17a533-64c0-49f6-bebb-a0fc3bc92584', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 08:10:41.950486+00', ''),
	('00000000-0000-0000-0000-000000000000', '1b452a59-7dbf-40d0-9463-b220c69cb982', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 08:10:41.957049+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bca14195-684b-4bfd-96de-2150fa638117', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 10:34:43.19628+00', ''),
	('00000000-0000-0000-0000-000000000000', '6b97eb65-ba09-4ae7-a9b5-cf990cb7e4da', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 10:34:43.199323+00', ''),
	('00000000-0000-0000-0000-000000000000', '4dd48a25-1fd6-4c11-8265-3f952d3a9a2f', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-24 10:34:45.950857+00', ''),
	('00000000-0000-0000-0000-000000000000', '5e9360d9-7477-4be2-834b-ef36204979af', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-24 10:34:57.183947+00', ''),
	('00000000-0000-0000-0000-000000000000', '658905f2-d025-413a-8e85-3e24e9110337', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 12:34:46.329455+00', ''),
	('00000000-0000-0000-0000-000000000000', '8d28b337-6cc0-4089-bceb-fceed07e8398', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 12:34:46.3376+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b4541d4b-e5d4-44da-89b6-35788d897e92', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 16:10:52.257638+00', ''),
	('00000000-0000-0000-0000-000000000000', '957f640f-4011-4891-8215-f453e92e882b', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 16:10:52.260384+00', ''),
	('00000000-0000-0000-0000-000000000000', '803cbff7-b9b4-440d-8a43-a9588e407420', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 17:16:04.60482+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e85a5017-6ef2-472a-9eb0-8a1e3f47c700', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 17:16:04.607751+00', ''),
	('00000000-0000-0000-0000-000000000000', '4455314f-3883-4052-ad51-7ddb9ed0d2fe', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 18:22:56.84435+00', ''),
	('00000000-0000-0000-0000-000000000000', '67cf589c-4704-4c77-a624-35d2db5b80e3', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 18:22:56.846709+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ae108c7a-06c8-4843-946f-9d63891774cf', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 19:27:09.519505+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a4625fd3-ef7c-4e9c-9d1e-3251c3a96533', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 19:27:09.525716+00', ''),
	('00000000-0000-0000-0000-000000000000', '4d441ec9-9be0-4a1b-a00f-d0b924c2980b', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 20:26:33.656399+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c1aaa17-7188-4fb8-8f86-459f10b22a63', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 20:26:33.658562+00', ''),
	('00000000-0000-0000-0000-000000000000', '1694039a-0b00-4ff4-ac49-bdc9fbe2848f', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 21:25:10.893597+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b10ef02-b170-483a-abf5-7e2c632e4d40', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-24 21:25:10.896526+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bbc7c0d3-705b-4c33-b932-e4aa9d361856', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-24 21:38:21.862857+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a5030bc-1266-414c-be72-7aee80e8a27f', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-24 21:38:24.838879+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c81c021b-11ab-4cad-ac9a-c64b7f0c1e9c', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-24 22:24:30.282295+00', ''),
	('00000000-0000-0000-0000-000000000000', '11752283-ce66-40e2-9a6c-d55a8d592010', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-25 09:59:52.956614+00', ''),
	('00000000-0000-0000-0000-000000000000', '53c11e56-573d-47a4-8dcc-a7f69755cf8f', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-25 10:19:06.702736+00', ''),
	('00000000-0000-0000-0000-000000000000', '155c7d90-54bd-4cd6-a5cd-6235cc2204e1', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-25 10:19:15.035599+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e51290d9-6ed4-4454-a4cd-87bb1003fc67', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-25 11:49:16.176824+00', ''),
	('00000000-0000-0000-0000-000000000000', '79994e59-c9a3-471e-b00e-5afb8f49d2ac', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-25 11:49:16.181153+00', ''),
	('00000000-0000-0000-0000-000000000000', '6781202e-7cf4-420a-835d-dc8797863519', '{"action":"token_refreshed","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-26 10:32:07.724701+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eba2e270-1b98-483f-bbf2-f15016b2c51e', '{"action":"token_revoked","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"token"}', '2025-06-26 10:32:07.730408+00', ''),
	('00000000-0000-0000-0000-000000000000', '16aa5c94-f34f-4759-91ae-0d7c19e208b8', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 10:32:10.142392+00', ''),
	('00000000-0000-0000-0000-000000000000', '12c95309-ebb9-4fd1-ba08-2c80ac06d046', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 10:32:13.34039+00', ''),
	('00000000-0000-0000-0000-000000000000', '0f930c3e-7727-4a6c-b7f0-566ccd39dac5', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 10:37:02.331269+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c60ae52-9aa0-4243-b2b6-af58fc603adc', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 10:37:04.700303+00', ''),
	('00000000-0000-0000-0000-000000000000', '22bca166-4513-4bfc-8a3a-63858bb7e4b2', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 10:37:53.663492+00', ''),
	('00000000-0000-0000-0000-000000000000', 'abb5ddc7-7b76-405d-8d47-4b2e587c6b98', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 10:41:50.90688+00', ''),
	('00000000-0000-0000-0000-000000000000', '1c615735-f812-4d11-9cac-1b1523201cc1', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 11:18:23.599166+00', ''),
	('00000000-0000-0000-0000-000000000000', '5ecfbad2-94ee-41bb-99da-c5a6de192e8a', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 11:41:04.775373+00', ''),
	('00000000-0000-0000-0000-000000000000', '05004aaa-1e5e-404d-83ba-60ba7ee37869', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:01:44.554299+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b559d10-ccaf-43fe-a113-24621b25e9cb', '{"action":"logout","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 13:02:21.751301+00', ''),
	('00000000-0000-0000-0000-000000000000', 'def49e88-3057-4a31-a78d-3b93198b91ad', '{"action":"login","actor_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:04:11.882427+00', ''),
	('00000000-0000-0000-0000-000000000000', '20eb0ea9-7c23-4690-8841-9e0b3ea312ca', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharvabhangale5@gmail.com","user_id":"2b4ca7e2-3c6c-41a6-8e9a-997f8dfe4797","user_phone":""}}', '2025-06-26 13:09:26.088289+00', ''),
	('00000000-0000-0000-0000-000000000000', '73b8f87d-fe56-4155-9b36-9deead1c070d', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"ap@exide.co.in","user_id":"cecd3a40-6398-4b05-992d-54c0b21efc87","user_phone":""}}', '2025-06-26 13:09:26.161423+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bafb8dd6-bfd6-4384-ba18-6c95cba968a8', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@admin.com","user_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","user_phone":""}}', '2025-06-26 13:09:46.666867+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb904ef2-6391-4d4a-b6b4-3bb217e63e35', '{"action":"login","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:18:07.363255+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dc4c3272-d762-4949-8022-ac76d62ea124', '{"action":"login","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:31:29.669241+00', ''),
	('00000000-0000-0000-0000-000000000000', '5f36021b-82f6-415f-aa6c-a7349bc9c515', '{"action":"login","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:33:57.26013+00', ''),
	('00000000-0000-0000-0000-000000000000', '16c25b2f-5598-4423-b1fc-7171a63f4d31', '{"action":"login","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:35:57.442355+00', ''),
	('00000000-0000-0000-0000-000000000000', '3796cd11-4d86-44ae-94ab-fba76d43c58c', '{"action":"login","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 13:43:56.125074+00', ''),
	('00000000-0000-0000-0000-000000000000', '429c07e2-4137-44b5-98d1-55516403d13b', '{"action":"token_refreshed","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-06-26 15:37:47.788502+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c3137a6c-105c-42a8-a50c-a20892bfa014', '{"action":"token_revoked","actor_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-06-26 15:37:47.7906+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a43dc536-6055-4d3f-9e96-24132092387a', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"master@master.com","user_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","user_phone":""}}', '2025-06-26 15:49:42.43357+00', ''),
	('00000000-0000-0000-0000-000000000000', '259f40ce-f133-4dd3-9947-7905e08d9ba6', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"user@user.com","user_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","user_phone":""}}', '2025-06-26 15:50:16.536323+00', ''),
	('00000000-0000-0000-0000-000000000000', '39f84284-cbbc-47d8-ae15-baf49fec43da', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@admin.com","user_id":"3ab3b3d3-4463-40e1-804d-f1e0e53099b0","user_phone":""}}', '2025-06-26 15:50:25.061636+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b51df8a0-3d3a-4bf6-a990-a3ae7dd47ec0', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"admin@admin.com","user_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","user_phone":""}}', '2025-06-26 15:50:38.993059+00', ''),
	('00000000-0000-0000-0000-000000000000', '65c5a5ac-991f-4466-8aa0-daeca25d7785', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 15:54:31.002856+00', ''),
	('00000000-0000-0000-0000-000000000000', '58af83b7-7231-4c81-9657-6740b1b1656b', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:21:22.176828+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a5d35341-6993-45af-8ef9-2f9307d3eed7', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:21:24.337448+00', ''),
	('00000000-0000-0000-0000-000000000000', '641171b5-5017-4b49-b180-82de723c7697', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:21:34.945868+00', ''),
	('00000000-0000-0000-0000-000000000000', '3293a56e-f21b-4ddc-8ec5-92ab01db7f4e', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:25:50.419719+00', ''),
	('00000000-0000-0000-0000-000000000000', '772b45c7-1161-4859-9c53-45f45a409224', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:37:30.826122+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b12be36e-9889-4d4e-82fe-81f03ed17e29', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:37:50.713342+00', ''),
	('00000000-0000-0000-0000-000000000000', '2ad49e2c-a5d7-4598-b103-bd86eac78cb7', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:37:54.056244+00', ''),
	('00000000-0000-0000-0000-000000000000', '92edd802-defa-4159-9f05-fdffdcd0606e', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:41:54.808953+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bb46cec6-1307-4c80-b5fa-aa60daafe45d', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:44:21.430259+00', ''),
	('00000000-0000-0000-0000-000000000000', '22e4aa81-5a9a-4186-8820-874986e20336', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:44:23.876762+00', ''),
	('00000000-0000-0000-0000-000000000000', '81cb9a52-d2d5-444b-ad42-fc7819f691f8', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:47:33.913593+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ff046fb2-9f31-4021-95ea-6c0ad0f781a0', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:47:44.468174+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de115341-a4d5-4297-b44c-19608fd157d5', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:47:47.936856+00', ''),
	('00000000-0000-0000-0000-000000000000', '408fc4be-2e53-4902-b0e7-17a944d69b3b', '{"action":"login","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:48:04.991696+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e52443bb-f1ff-41fb-b156-cb2239a59d8d', '{"action":"logout","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 16:48:14.079176+00', ''),
	('00000000-0000-0000-0000-000000000000', '380555fc-29e1-4d38-bc77-4f6f32fdd23d', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 16:54:46.684176+00', ''),
	('00000000-0000-0000-0000-000000000000', '5af1e244-66bc-4c46-9a8b-e030aff66cc0', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:26:15.922461+00', ''),
	('00000000-0000-0000-0000-000000000000', '95a26334-824f-43a3-a8ac-df2e637d3630', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:26:29.405031+00', ''),
	('00000000-0000-0000-0000-000000000000', '9be10318-7f9c-4b8b-b6cb-26ff19db4b9e', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:27:06.591216+00', ''),
	('00000000-0000-0000-0000-000000000000', '4afc3e6a-b966-4406-bcf7-641fb8b076a2', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:27:09.912859+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b452e707-a68b-4c44-90b9-79195a67daa2', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:27:17.842713+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5179b2b-dc63-4559-8e9b-f0cc257d290e', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:27:20.681631+00', ''),
	('00000000-0000-0000-0000-000000000000', '737a6075-1760-4cf4-a578-72ba1e9f7f2e', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:27:26.826977+00', ''),
	('00000000-0000-0000-0000-000000000000', '422da8be-d35d-44a7-8283-1c5eff7e9546', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:27:34.578702+00', ''),
	('00000000-0000-0000-0000-000000000000', '1de1a833-fa3b-4d23-93f4-1dd76cd7a0bc', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:28:10.054946+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f3d10227-4bdb-4b30-9581-f065a806db20', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:28:12.7474+00', ''),
	('00000000-0000-0000-0000-000000000000', '26f7832e-0851-41ee-923f-8a6fed4117cf', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:28:24.234138+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c2d3ea58-ed0f-45d4-9eb5-9c12635e5ead', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:28:28.564173+00', ''),
	('00000000-0000-0000-0000-000000000000', '4f1c943c-847d-4b53-a07a-5d4ef2d4f572', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:37:47.063073+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ceead399-ee2c-4a67-b9fb-ad1bf7c1f7b6', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:37:51.173528+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b766392e-f9d9-44f5-9000-1b517f0c1a47', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:38:14.799369+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a787552e-31d0-45c7-b8d8-2a4f90b4d5a4', '{"action":"user_confirmation_requested","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-06-26 17:38:51.39587+00', ''),
	('00000000-0000-0000-0000-000000000000', '67ddd178-9823-4190-81dc-2c54a3d6d66a', '{"action":"user_signedup","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"team"}', '2025-06-26 17:39:19.772479+00', ''),
	('00000000-0000-0000-0000-000000000000', '17b664bf-fd30-421d-bcb1-e89e58cd1e4c', '{"action":"login","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:39:38.324397+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e8f9fb25-6aa9-4265-9888-177a2b6c39e9', '{"action":"logout","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:48:54.522433+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c6530a32-05d0-4192-93ec-7eef09d849b4', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:48:56.991607+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f15121d8-f6c9-48dc-8bec-082255654f8f', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:49:15.714281+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eb1b95bf-693c-4f45-a65c-b531163ba2d5', '{"action":"login","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:49:19.109437+00', ''),
	('00000000-0000-0000-0000-000000000000', '4bd7fbee-a0c9-4111-8c3c-3f71b1c0efd3', '{"action":"logout","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:51:18.114715+00', ''),
	('00000000-0000-0000-0000-000000000000', '8b3a0b90-aa03-414a-9c44-35e55f208aad', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:51:21.279016+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c140440-b433-45d1-b4cd-88e621cc3b6f', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:52:36.266068+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c22acaaa-044e-4964-964e-41c4d83649c6', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:52:40.163403+00', ''),
	('00000000-0000-0000-0000-000000000000', '75f5f47a-9c61-4b1b-b8a3-3d8abdeef74e', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:52:44.201122+00', ''),
	('00000000-0000-0000-0000-000000000000', 'abd348ed-4963-437d-9f55-082e5c6fdcb8', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:52:46.846646+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f2e8b43b-140b-4ed0-b1b8-246a8208ee9e', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:57:44.22583+00', ''),
	('00000000-0000-0000-0000-000000000000', '841d8e75-fb4f-4fc9-a77d-7f8d7aa4af85', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:57:47.092854+00', ''),
	('00000000-0000-0000-0000-000000000000', '731442af-b4ce-494d-9592-15e22d3af1f9', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 17:57:56.061321+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b32dfbd3-81cf-4d56-a4c2-afa0a308b4f8', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 17:58:00.547663+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f17121a6-07c9-4e93-ade4-b58ae92c9312', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:00:08.804452+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f963e299-52b3-4b19-82cc-69f44a837c5e', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 18:00:11.885931+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd29597dc-35c6-42d2-9ddb-99c48d506ddd', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:02:03.64686+00', ''),
	('00000000-0000-0000-0000-000000000000', '702b1cfc-b3ce-4dac-a6dc-d240365422f0', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 18:02:07.139378+00', ''),
	('00000000-0000-0000-0000-000000000000', '9d714143-ca2b-4eab-9cfd-c10e799c7f71', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:02:43.634262+00', ''),
	('00000000-0000-0000-0000-000000000000', '79f66e8b-7ac6-40b4-8193-f762664af6f9', '{"action":"token_refreshed","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 08:46:14.865367+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc3f5113-c25c-49ae-af94-8c7ed524472a', '{"action":"login","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 18:02:46.224228+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5219274-2f42-4561-854e-2273dcc310df', '{"action":"logout","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:03:14.589197+00', ''),
	('00000000-0000-0000-0000-000000000000', '6dcf7c46-6ead-45fb-852b-518848a5371e', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 18:15:54.781218+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a61d9fb-59f4-4fa6-b3fc-761ef1600976', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:16:17.239493+00', ''),
	('00000000-0000-0000-0000-000000000000', '4c945455-5045-42c2-92f3-24c00a009eff', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 08:19:54.282973+00', ''),
	('00000000-0000-0000-0000-000000000000', '2f1125ff-5cdb-4d0c-bfd3-25513f8f69b8', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 08:20:09.403394+00', ''),
	('00000000-0000-0000-0000-000000000000', '67ddb782-df1a-486d-afa3-43637dc654b1', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 08:20:12.879583+00', ''),
	('00000000-0000-0000-0000-000000000000', '177eba62-d584-4741-b808-c7f4f59215ff', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 08:20:17.325606+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd30b02a1-51c4-4933-a697-7826208ced26', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 08:20:20.509338+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b57d5d92-ed92-4cb4-be28-57908d0e94ad', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 08:44:49.69705+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bdeccc0d-5203-4d63-ade1-10dd7f4d92f9', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 10:21:23.458675+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fb4be947-195a-41ac-97b7-80c8718cf8c0', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 10:21:39.948178+00', ''),
	('00000000-0000-0000-0000-000000000000', 'efa04f0d-361d-4d21-92f7-cc0694237b8b', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 10:27:26.586473+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e32c2861-9d26-416d-89b8-5ba110f28f65', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 10:27:42.145692+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c637679c-bab0-49bb-81c6-0f15d24d401c', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 18:31:28.991697+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ccdd96c0-4b25-4220-9f5e-e7e0290d20e9', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 18:48:32.698773+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fd78244c-800e-4b99-acac-81a475fd7cbd', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 18:48:36.096404+00', ''),
	('00000000-0000-0000-0000-000000000000', '95e5daee-22a8-4e0a-841d-559632efc0de', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:01:30.549694+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fdb052fb-c7d3-4a16-82b9-37324e4168fc', '{"action":"login","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:01:33.157731+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a61556c0-77c8-4d66-925d-8b15753b0351', '{"action":"logout","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:01:35.302161+00', ''),
	('00000000-0000-0000-0000-000000000000', '99641408-3ac5-46dd-96ce-f0a012fe294f', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:01:38.791783+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e420e911-e55e-4f68-bb6f-99a13e177236', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:01:40.625889+00', ''),
	('00000000-0000-0000-0000-000000000000', '89fa5ef9-4c42-45a3-9ea2-e5518fb838af', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:01:43.975212+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b385a901-4c33-438d-9d9d-ca45fb5b9b5d', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:13:10.537031+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e9a1abc6-9176-4c3f-a092-7480819acd62', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:13:27.102152+00', ''),
	('00000000-0000-0000-0000-000000000000', '8d5dd0b0-2f14-478f-ae76-099ca2a3b36b', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:16:17.327735+00', ''),
	('00000000-0000-0000-0000-000000000000', '3a668463-00a7-4216-a18b-b4d49d952051', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:16:21.437734+00', ''),
	('00000000-0000-0000-0000-000000000000', 'acdca94d-60bc-487f-92b3-c4c3dc95ad8e', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:18:16.15157+00', ''),
	('00000000-0000-0000-0000-000000000000', '16759b16-1c1c-4dc3-8d13-c41f2f8c9770', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:18:34.289213+00', ''),
	('00000000-0000-0000-0000-000000000000', '7529c67a-094b-4888-a70e-4d1973b638ec', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-01 19:38:55.455562+00', ''),
	('00000000-0000-0000-0000-000000000000', '00da7602-2522-421c-bc94-c2eb42eb9a83', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-01 19:39:00.000715+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b209b14-52e0-4cca-8e9c-3305ac9f068e', '{"action":"token_refreshed","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 08:46:14.41737+00', ''),
	('00000000-0000-0000-0000-000000000000', '3624d3f7-8753-4d02-a8c6-69d34ed9a0df', '{"action":"token_revoked","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 08:46:14.437222+00', ''),
	('00000000-0000-0000-0000-000000000000', '55b10515-0087-4f3e-94fc-1ac68f8525ac', '{"action":"user_signedup","actor_id":"10d9b2a3-f96b-4100-84fe-4a30eb930e19","actor_username":"atharva@atharva.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-03 08:55:27.692693+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b9b8da44-e653-4c7b-87f3-3b356d8dde64', '{"action":"login","actor_id":"10d9b2a3-f96b-4100-84fe-4a30eb930e19","actor_username":"atharva@atharva.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 08:55:27.704557+00', ''),
	('00000000-0000-0000-0000-000000000000', '4829ed66-bf54-45ae-8a95-8fb90a5a41d4', '{"action":"logout","actor_id":"10d9b2a3-f96b-4100-84fe-4a30eb930e19","actor_username":"atharva@atharva.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 08:55:36.510224+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c5d38a30-e343-455e-8391-25af2f8c3c9d', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 08:55:40.120578+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b7526027-006e-4f19-bcf2-ac4688df048d', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@atharva.com","user_id":"10d9b2a3-f96b-4100-84fe-4a30eb930e19","user_phone":""}}', '2025-07-03 09:01:27.948365+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a42d9e5f-2732-46ed-899d-909569a21458', '{"action":"user_repeated_signup","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-07-03 09:01:47.151101+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dd82943c-ef58-4945-9af7-031213f15538', '{"action":"user_signedup","actor_id":"21874fc5-3ecf-4b28-bb9b-7a5a874c10d9","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-03 09:01:54.144456+00', ''),
	('00000000-0000-0000-0000-000000000000', '954f3ab6-ad7e-479a-a749-5cb6639f0207', '{"action":"login","actor_id":"21874fc5-3ecf-4b28-bb9b-7a5a874c10d9","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:01:54.148676+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a96a3be0-5d6d-44a0-9bb0-d5ec4161c9e5', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"21874fc5-3ecf-4b28-bb9b-7a5a874c10d9","user_phone":""}}', '2025-07-03 09:09:02.344609+00', ''),
	('00000000-0000-0000-0000-000000000000', '81faf612-897a-48c9-8a35-ff69b32433d9', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:09:36.899716+00', ''),
	('00000000-0000-0000-0000-000000000000', '2524fac9-42d2-4922-a821-e781d5c5b3f9', '{"action":"user_signedup","actor_id":"ee8db28d-82e5-4e2d-8b83-c78ed6171f49","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-03 09:10:04.83781+00', ''),
	('00000000-0000-0000-0000-000000000000', '278d42a0-98a1-4af3-b712-50482b3a324e', '{"action":"login","actor_id":"ee8db28d-82e5-4e2d-8b83-c78ed6171f49","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:10:04.842203+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd87b28b1-b9b8-419f-9d9a-ff01ff73afa3', '{"action":"logout","actor_id":"ee8db28d-82e5-4e2d-8b83-c78ed6171f49","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 09:10:09.070215+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b3f86376-4c54-462a-addf-5791ff5c7172', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:10:26.426373+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd5aed59e-89bf-41c1-8520-4668ac6f4212', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"ee8db28d-82e5-4e2d-8b83-c78ed6171f49","user_phone":""}}', '2025-07-03 09:10:35.54095+00', ''),
	('00000000-0000-0000-0000-000000000000', '9614f683-0635-4cb1-a0ff-0a20ea64a4fa', '{"action":"user_repeated_signup","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-07-03 09:10:49.532389+00', ''),
	('00000000-0000-0000-0000-000000000000', '68d5e051-2eaa-4f51-bc11-8466ebeff459', '{"action":"user_signedup","actor_id":"4629fd50-1c2f-4e89-a0e9-e1e968b57d9d","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-07-03 09:10:56.075378+00', ''),
	('00000000-0000-0000-0000-000000000000', 'bd0d1811-afc7-43d5-b6a5-8eab2cd92e1a', '{"action":"login","actor_id":"4629fd50-1c2f-4e89-a0e9-e1e968b57d9d","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:10:56.078751+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a9bad3c2-c351-4697-bf76-bf0a3619c28a', '{"action":"logout","actor_id":"4629fd50-1c2f-4e89-a0e9-e1e968b57d9d","actor_username":"atharva@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 09:12:01.190851+00', ''),
	('00000000-0000-0000-0000-000000000000', '19e27e34-dd07-4357-8d2b-0b473c7f57d3', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:12:04.451961+00', ''),
	('00000000-0000-0000-0000-000000000000', '3d0784e5-717b-406a-b50d-0a390e35c1ac', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"4629fd50-1c2f-4e89-a0e9-e1e968b57d9d","user_phone":""}}', '2025-07-03 09:12:15.447734+00', ''),
	('00000000-0000-0000-0000-000000000000', '8564f5dd-ecbf-41df-ab13-5dcc6a61bbe8', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"c7137dd2-39ce-4f74-8c01-1d4fa83c9f1e","user_phone":""}}', '2025-07-03 09:20:08.940757+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b14c4646-4af2-4c97-874c-bceb7d8670c2', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"c7137dd2-39ce-4f74-8c01-1d4fa83c9f1e","user_phone":""}}', '2025-07-03 09:21:54.338359+00', ''),
	('00000000-0000-0000-0000-000000000000', '6edcc4dd-d6c2-4ed2-9649-1e99f8e49aec', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"a14c2c59-092d-4755-9e63-bdefcd2226bb","user_phone":""}}', '2025-07-03 09:22:34.482816+00', ''),
	('00000000-0000-0000-0000-000000000000', '77e00123-ec5e-48ac-9db6-65effb93e27c', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"a14c2c59-092d-4755-9e63-bdefcd2226bb","user_phone":""}}', '2025-07-03 09:23:59.148942+00', ''),
	('00000000-0000-0000-0000-000000000000', '7eb7d07f-e846-461a-aa14-19c666813fcc', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"5e3af0de-f9f0-40f5-8238-589ef95ab4cc","user_phone":""}}', '2025-07-03 09:24:13.106015+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ca44090a-5a9b-4366-ae25-2ef45cad7000', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"5e3af0de-f9f0-40f5-8238-589ef95ab4cc","user_phone":""}}', '2025-07-03 09:25:39.225284+00', ''),
	('00000000-0000-0000-0000-000000000000', '66ae78b7-0689-4d92-adb4-4097eccc3691', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"c4c0aec3-65cb-4c8e-8558-12ba5811ef61","user_phone":""}}', '2025-07-03 09:26:03.903888+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b6eaae5d-700d-405d-8228-f644574a235a', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 09:28:31.809589+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ad4d7d3c-bc27-4946-83f3-44d9152f931a', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 09:28:34.116351+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de01c3ce-998e-423f-b8dd-e65e1d650dcb', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"c4c0aec3-65cb-4c8e-8558-12ba5811ef61","user_phone":""}}', '2025-07-03 09:28:50.628301+00', ''),
	('00000000-0000-0000-0000-000000000000', '27730212-986b-41b2-a900-365964eaa685', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"50acbf27-b90c-418f-9f82-afdad5736fdd","user_phone":""}}', '2025-07-03 09:29:10.424924+00', ''),
	('00000000-0000-0000-0000-000000000000', '9a484966-eb46-4c76-a77a-a9132f474070', '{"action":"token_refreshed","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 12:34:33.571802+00', ''),
	('00000000-0000-0000-0000-000000000000', '0809b753-8054-42d3-8f77-e7c6b086e6c6', '{"action":"token_revoked","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 12:34:33.583789+00', ''),
	('00000000-0000-0000-0000-000000000000', '0fa3d7f2-02c9-4f9d-81c5-e69933b613ca', '{"action":"token_refreshed","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 16:33:49.616509+00', ''),
	('00000000-0000-0000-0000-000000000000', '817b4a5c-f0bd-42bb-8569-593d7f83add2', '{"action":"token_revoked","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 16:33:49.626869+00', ''),
	('00000000-0000-0000-0000-000000000000', '914903ee-aff5-4654-adae-e33d8ed8feb3', '{"action":"token_refreshed","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 17:55:42.216192+00', ''),
	('00000000-0000-0000-0000-000000000000', '6ebf82b9-fde1-450f-8442-fd9db32e556d', '{"action":"token_revoked","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-03 17:55:42.221363+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e3b88688-98fa-4672-87be-4b6d460aae10', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 18:06:50.688546+00', ''),
	('00000000-0000-0000-0000-000000000000', '25c7ed8d-b239-4f10-af15-9265702f113b', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"pushkar@gmail.com","user_id":"13d869a5-9579-46f5-b6da-e014431e5fa9","user_phone":""}}', '2025-07-03 18:07:13.437157+00', ''),
	('00000000-0000-0000-0000-000000000000', '7dc0fbf4-1006-4f4d-a873-60b963539388', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva2@gmail.com","user_id":"b29ec879-ed7d-4b76-ba5a-77b3204221a6","user_phone":""}}', '2025-07-03 18:13:21.17773+00', ''),
	('00000000-0000-0000-0000-000000000000', '4b13d3c1-81f7-47b8-95f8-1457406aebe3', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 18:37:41.027745+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a799c4d8-b78c-4329-8408-5e2e588b62ab', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 18:38:50.062177+00', ''),
	('00000000-0000-0000-0000-000000000000', '2fe2c1ab-b2c4-43c8-b93b-ed931704e99c', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva@gmail.com","user_id":"50acbf27-b90c-418f-9f82-afdad5736fdd","user_phone":""}}', '2025-07-03 18:45:30.886465+00', ''),
	('00000000-0000-0000-0000-000000000000', '58656a6b-4f05-437b-8632-9ffb3fde6dd8', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharvabhangale5@gmail.com","user_id":"b2e790bb-baa2-4117-bcd0-31c743168039","user_phone":""}}', '2025-07-03 18:45:30.890377+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e433c5cd-c41d-4c71-aef4-4657570827f9', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"pushkar@gmail.com","user_id":"13d869a5-9579-46f5-b6da-e014431e5fa9","user_phone":""}}', '2025-07-03 18:45:30.906281+00', ''),
	('00000000-0000-0000-0000-000000000000', '538430cc-36dc-4baa-a862-dd275b001348', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharva2@gmail.com","user_id":"b29ec879-ed7d-4b76-ba5a-77b3204221a6","user_phone":""}}', '2025-07-03 18:45:30.945604+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b967465a-a3d5-46cc-ba5f-136658a4c895', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharvabhangale5@gmail.com","user_id":"af993ff5-7a1f-41db-b7c3-793a36edd74a","user_phone":""}}', '2025-07-03 18:47:29.160911+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c4893b3b-53ec-46c4-b3d7-74ac344da10a', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharvabhangale5@gmail.com","user_id":"af993ff5-7a1f-41db-b7c3-793a36edd74a","user_phone":""}}', '2025-07-03 18:54:42.831323+00', ''),
	('00000000-0000-0000-0000-000000000000', '08c60735-efec-47a0-992d-f72c4ca94427', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"pushkar@gmail.com","user_id":"9447220d-757c-4bfa-bb1d-bd23e0544cae","user_phone":""}}', '2025-07-03 19:00:41.075478+00', ''),
	('00000000-0000-0000-0000-000000000000', '3120ff96-b78f-4bdc-8da8-398906c963a6', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharvabhangale5@gmail.com","user_id":"bda5088f-31bf-444a-b847-b324ae5f90c5","user_phone":""}}', '2025-07-03 19:03:20.914527+00', ''),
	('00000000-0000-0000-0000-000000000000', 'eb63357b-6a68-4055-bdc0-20049fbcf618', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"pushkar@gmail.com","user_id":"9447220d-757c-4bfa-bb1d-bd23e0544cae","user_phone":""}}', '2025-07-03 19:03:54.877473+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b581ed78-9da2-4fc6-809a-c7c692f1e12c', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"pushkar@gmail.com","user_id":"85a788d6-1d9c-4364-b611-3cf81c8e09c5","user_phone":""}}', '2025-07-03 19:07:35.032478+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cf8d3aa0-84d9-4701-b363-51be4314a350', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"atharvabhangale5@gmail.com","user_id":"bda5088f-31bf-444a-b847-b324ae5f90c5","user_phone":""}}', '2025-07-03 19:08:17.112487+00', ''),
	('00000000-0000-0000-0000-000000000000', '892f7919-6486-401c-9b30-330b9bbbdfbd', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 19:31:38.406066+00', ''),
	('00000000-0000-0000-0000-000000000000', '6d8886dc-868b-4cc0-b665-ef710ab0cbbb', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 19:31:41.799469+00', ''),
	('00000000-0000-0000-0000-000000000000', '244c1ef5-903b-4c2b-9252-aeaa7b1a868a', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 19:32:01.874692+00', ''),
	('00000000-0000-0000-0000-000000000000', '3c869524-7df9-412c-a3fe-506b9b98336d', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 19:32:04.830457+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c0536dd1-8bdb-45d1-b91d-b5f97c125f7a', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 19:35:54.800945+00', ''),
	('00000000-0000-0000-0000-000000000000', '19fc5658-7586-48cc-b3aa-77e7cbbe18af', '{"action":"login","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 19:35:57.402641+00', ''),
	('00000000-0000-0000-0000-000000000000', '13597c24-7e26-445c-bd5b-19c47ef8d069', '{"action":"logout","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 19:37:13.643445+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cbfa9f5e-6193-4c43-b3d8-56b49b754140', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 19:37:26.838132+00', ''),
	('00000000-0000-0000-0000-000000000000', '3b116b9a-ccf2-483a-9b20-0a0f9b32fc9f', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"super@admin.com","user_id":"c0f54937-bb12-4557-91d9-50e91f6f475d","user_phone":""}}', '2025-07-03 20:03:08.742281+00', ''),
	('00000000-0000-0000-0000-000000000000', 'cc9d3c15-e24f-4f1c-9da2-96efadf103c3', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:27:03.632207+00', ''),
	('00000000-0000-0000-0000-000000000000', '16ec3ebe-807b-460f-a856-78c72bb0aa64', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:29:02.699153+00', ''),
	('00000000-0000-0000-0000-000000000000', '2dd042e7-010a-4e43-b9e7-d3f56ff84d04', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:29:21.991472+00', ''),
	('00000000-0000-0000-0000-000000000000', '9e659dc6-ebb2-4ac0-8035-66e265f3ef29', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"super@admin.com","user_id":"c0f54937-bb12-4557-91d9-50e91f6f475d","user_phone":""}}', '2025-07-03 20:29:34.47129+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dc7a225c-b004-4140-a2a4-e7ead8984173', '{"action":"user_signedup","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"super@admin.com","user_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","user_phone":""}}', '2025-07-03 20:29:52.710619+00', ''),
	('00000000-0000-0000-0000-000000000000', '4e58502c-0c23-4530-9838-c6506060f242', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:30:43.704424+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd0e99b3a-e094-4b29-b1bb-f27179165a22', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:30:52.402339+00', ''),
	('00000000-0000-0000-0000-000000000000', '4461973c-5299-4e28-99d0-07f92b960265', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:30:55.621637+00', ''),
	('00000000-0000-0000-0000-000000000000', '16b38863-5bfc-44dd-bed7-18e104811940', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:36:26.187926+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b97a3872-ce4a-4691-88f2-bafd77555fa8', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:36:29.044206+00', ''),
	('00000000-0000-0000-0000-000000000000', '6547fdbc-a3c0-4127-9601-278cc580d210', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:37:18.350418+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e4f70768-d462-44ea-8aeb-7056c1b9b25c', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:37:21.00692+00', ''),
	('00000000-0000-0000-0000-000000000000', '1430842f-44d2-493d-8b22-6b8c2114b174', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:37:46.935119+00', ''),
	('00000000-0000-0000-0000-000000000000', 'aabcaeb5-c505-4f17-82f1-6651201f4c1e', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:37:50.277316+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a27f409c-8301-4803-b359-6a047dc8a236', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:38:03.238476+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c2fb3198-3902-442a-aded-e24baa4875b7', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:38:06.952667+00', ''),
	('00000000-0000-0000-0000-000000000000', '8c9d1e9a-8853-48b0-91eb-ed9168921482', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:38:30.826936+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a4a9630-650d-4600-bc8c-e17f0c5bb502', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:38:33.766822+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b6ed1a67-c496-4a4a-b249-b1f07f7e239e', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-03 20:42:18.885487+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ab8912b0-f09d-460a-9906-68a471a20063', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-03 20:42:21.340572+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c7dfe9f4-41d1-4a24-976f-9296def00792', '{"action":"token_refreshed","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 07:28:14.008105+00', ''),
	('00000000-0000-0000-0000-000000000000', '679c1bda-5895-43b7-a168-d3d542ad99f8', '{"action":"token_revoked","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 07:28:14.023735+00', ''),
	('00000000-0000-0000-0000-000000000000', '3585eb24-6067-4e35-bfc4-6c8caa19fd1a', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 07:28:44.848378+00', ''),
	('00000000-0000-0000-0000-000000000000', '40900583-aa97-4e69-8b7b-97c4f702adc2', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 07:28:53.049622+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e5459b23-9661-40bf-9172-92b41065d3f2', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 07:29:13.768408+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b28a7b05-8edb-4124-a920-a63bb36653a4', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 07:29:17.657078+00', ''),
	('00000000-0000-0000-0000-000000000000', '0e0d296d-3318-40d3-91c4-dc921baeeb77', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 07:34:06.322222+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de45b33b-8874-459d-8e0c-41f6a81c90ea', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 07:34:09.333428+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e0c292a0-5c21-428d-9a80-c2a4732b88be', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 07:35:18.065269+00', ''),
	('00000000-0000-0000-0000-000000000000', '3edb0536-17f8-4776-945e-810ddd2df30e', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 07:35:21.093139+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ba812a01-f8cb-4b72-87b1-3b3b5822110f', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 07:40:39.180769+00', ''),
	('00000000-0000-0000-0000-000000000000', '41d7bb14-7386-4fc7-8332-59182c54e953', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 07:40:41.555441+00', ''),
	('00000000-0000-0000-0000-000000000000', 'de7fb18d-5535-43dd-a86f-b7dfba8ec91f', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 07:42:02.0073+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a016e944-259c-4ed4-895e-8f4fa22634e5', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 07:42:05.68884+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ba115817-f30c-43b4-8781-0da886e4c3b4', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:17:46.238429+00', ''),
	('00000000-0000-0000-0000-000000000000', '146b88ae-665f-4ebe-90da-7e5e86c678c1', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:19:23.007428+00', ''),
	('00000000-0000-0000-0000-000000000000', 'be5245e2-af91-4e3a-9fc2-ee214e2768a2', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:19:54.268927+00', ''),
	('00000000-0000-0000-0000-000000000000', '0401e739-431d-431b-9a5a-33840eae774e', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:19:57.509974+00', ''),
	('00000000-0000-0000-0000-000000000000', '1a463cc9-0b26-4df8-b054-5554638c54a9', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:21:09.555441+00', ''),
	('00000000-0000-0000-0000-000000000000', '14c5a5d6-b940-4cc3-9ab4-6779895f1553', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:21:12.458287+00', ''),
	('00000000-0000-0000-0000-000000000000', '6d23b8bb-a565-4dbb-b9bd-65f7d523f83a', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:21:45.92384+00', ''),
	('00000000-0000-0000-0000-000000000000', '1e49bcbf-e4c6-4064-81bc-975de01b0ca6', '{"action":"login","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:21:49.527383+00', ''),
	('00000000-0000-0000-0000-000000000000', '4b0fb9e8-1ccd-4ce2-9cc6-9bcc406f46fe', '{"action":"logout","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:22:01.71028+00', ''),
	('00000000-0000-0000-0000-000000000000', '697d4848-1737-45ee-8889-4e36f2e6134a', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:22:05.558402+00', ''),
	('00000000-0000-0000-0000-000000000000', '6cf66c0b-48c1-4abc-bb23-4edc680f58c9', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:22:46.080306+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f90cadd3-bdda-4015-a8cc-4737b54990b6', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:32:18.238729+00', ''),
	('00000000-0000-0000-0000-000000000000', '77db4f29-ed9f-4173-9c8b-ebc06c77eabe', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 08:35:38.853303+00', ''),
	('00000000-0000-0000-0000-000000000000', '2ae6e30e-5ccf-49d4-9653-9e339c632acf', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:37:24.798765+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ddbeab95-cc5a-4cea-bb19-03fbfe2cf5fa', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 08:46:21.271504+00', ''),
	('00000000-0000-0000-0000-000000000000', 'dbeb3e27-941d-4930-a695-73a3e6f0652d', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 09:42:22.854262+00', ''),
	('00000000-0000-0000-0000-000000000000', '33488b9e-d471-4302-8811-a565c2b7c5cc', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 09:42:25.565438+00', ''),
	('00000000-0000-0000-0000-000000000000', '52db5bce-2a60-402e-bec5-313f9dfb5d61', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 09:44:57.057436+00', ''),
	('00000000-0000-0000-0000-000000000000', '475b95bd-d91d-40e6-b56f-da5d59f07a6c', '{"action":"login","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 09:45:03.701656+00', ''),
	('00000000-0000-0000-0000-000000000000', '5fd6e3f8-77f5-449d-a24b-6bc606b4bb6f', '{"action":"logout","actor_id":"9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b","actor_username":"master@master.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 09:45:15.905003+00', ''),
	('00000000-0000-0000-0000-000000000000', '9c5094d2-f4a5-416a-b265-038b44509f12', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 09:45:19.010658+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c81a0b90-d52a-4c3d-971e-7d30d643b025', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 09:46:22.819992+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b4fc51aa-cc17-444e-b5d7-a7a8d20c368d', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 09:46:27.776567+00', ''),
	('00000000-0000-0000-0000-000000000000', '74240e4d-6bf5-4ec9-a911-a4c9c3d52d36', '{"action":"token_refreshed","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 10:44:30.470324+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5c62d6b-6770-4604-96fd-acb7b3f1b2f9', '{"action":"token_revoked","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 10:44:30.472659+00', ''),
	('00000000-0000-0000-0000-000000000000', '404388cc-b710-44e8-ab04-cf64c39c4d65', '{"action":"token_refreshed","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 11:42:49.805053+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a8c0fb21-5be0-4920-828b-14a2e595b1c3', '{"action":"token_revoked","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 11:42:49.806578+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b7010248-9572-4667-b667-13f3153507ee', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 12:03:24.856753+00', ''),
	('00000000-0000-0000-0000-000000000000', 'af94aaa3-31a1-421d-bc60-ddc45f9ab05f', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 15:10:58.589914+00', ''),
	('00000000-0000-0000-0000-000000000000', 'ca478ab6-0fcc-44dc-b9e8-344cd563b2f8', '{"action":"logout","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-07-04 15:12:19.60666+00', ''),
	('00000000-0000-0000-0000-000000000000', '1b06458d-3579-4da5-a69f-4876ab434308', '{"action":"login","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-07-04 15:13:30.433766+00', ''),
	('00000000-0000-0000-0000-000000000000', '02b6a7d5-b0c7-4d68-bf98-7d2053f65e95', '{"action":"token_refreshed","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 16:14:29.420077+00', ''),
	('00000000-0000-0000-0000-000000000000', 'baeadb31-7d0f-4aab-8303-19a80a5242fc', '{"action":"token_revoked","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 16:14:29.422178+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e4c9ee99-15fe-4b6f-af31-d4d543bdbd0c', '{"action":"token_refreshed","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:41:39.026851+00', ''),
	('00000000-0000-0000-0000-000000000000', '761b5148-d3e0-43e0-87ce-f9cfe6732612', '{"action":"token_revoked","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-04 17:41:39.029056+00', ''),
	('00000000-0000-0000-0000-000000000000', '0cb1f711-dbb1-4d2c-a8de-9419e8d0f671', '{"action":"token_refreshed","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 12:26:14.389068+00', ''),
	('00000000-0000-0000-0000-000000000000', '0ff8ed5e-8a1f-4956-a0ca-4bde7991a682', '{"action":"token_revoked","actor_id":"bdd57d85-27f2-44e8-a773-a9820fbcc189","actor_username":"super@admin.com","actor_via_sso":false,"log_type":"token"}', '2025-07-05 12:26:14.400977+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', 'authenticated', 'authenticated', 'super@admin.com', '$2a$10$BrkqYo6YPUDb4avr16mlp.jE4W9Maiq3JfVb9xkqXZ6EkjqH8ZBEu', '2025-07-03 20:29:52.711922+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 15:13:30.435533+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-07-03 20:29:52.70198+00', '2025-07-05 12:26:14.421698+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '85a788d6-1d9c-4364-b611-3cf81c8e09c5', 'authenticated', 'authenticated', 'pushkar@gmail.com', '$2a$10$SsTVUNFaQ5DPpDUaDFdUt.kAnWmRcRPQw6/C1gfJlkxES3WIxRsHG', NULL, NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"full_name": "pushkar"}', NULL, '2025-07-03 19:07:35.028877+00', '2025-07-03 19:07:35.033357+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '4aecde7f-c242-4fb7-a6ff-223cae98d684', 'authenticated', 'authenticated', 'admin@admin.com', '$2a$10$hf0FpcOkG91JYWSxRIcIdO8dPUpyAjWhvIWHrF3eFMLZID/KquMGG', '2025-06-26 15:50:38.994136+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 09:42:25.566149+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-26 15:50:38.990048+00', '2025-07-04 09:42:25.568125+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', 'authenticated', 'authenticated', 'master@master.com', '$2a$10$4Mp9Qd3nN1MYXQGfV72Jx.dZbpAqpvJGO0.wRMmG8qgxvgPiDfxP2', '2025-06-26 15:49:42.437105+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 09:45:03.702338+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-26 15:49:42.415879+00', '2025-07-04 09:45:03.704549+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '224601f4-7a17-466d-b4c9-c8d8ce94aa82', 'authenticated', 'authenticated', 'user@user.com', '$2a$10$PsZHXLnup5idHYWtdyc/muFzfjhRL1FWuXqb.qk43T016XXnaZH0e', '2025-06-26 15:50:16.540122+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-07-04 09:45:19.011447+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-26 15:50:16.5322+00', '2025-07-04 09:45:19.013241+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('bdd57d85-27f2-44e8-a773-a9820fbcc189', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', '{"sub": "bdd57d85-27f2-44e8-a773-a9820fbcc189", "email": "super@admin.com", "email_verified": false, "phone_verified": false}', 'email', '2025-07-03 20:29:52.709624+00', '2025-07-03 20:29:52.709682+00', '2025-07-03 20:29:52.709682+00', 'd828e608-4537-4267-a2e2-2f36314ef8b0'),
	('9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', '9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', '{"sub": "9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b", "email": "master@master.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-26 15:49:42.429991+00', '2025-06-26 15:49:42.430072+00', '2025-06-26 15:49:42.430072+00', '9b508c81-a956-4693-94ae-eeb7efcda751'),
	('224601f4-7a17-466d-b4c9-c8d8ce94aa82', '224601f4-7a17-466d-b4c9-c8d8ce94aa82', '{"sub": "224601f4-7a17-466d-b4c9-c8d8ce94aa82", "email": "user@user.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-26 15:50:16.534186+00', '2025-06-26 15:50:16.534241+00', '2025-06-26 15:50:16.534241+00', 'f3885595-33ba-4b82-9876-0ba045ceef85'),
	('4aecde7f-c242-4fb7-a6ff-223cae98d684', '4aecde7f-c242-4fb7-a6ff-223cae98d684', '{"sub": "4aecde7f-c242-4fb7-a6ff-223cae98d684", "email": "admin@admin.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-26 15:50:38.992199+00', '2025-06-26 15:50:38.992255+00', '2025-06-26 15:50:38.992255+00', '3b106a86-64d0-4bae-9db2-7ab7d3454148'),
	('85a788d6-1d9c-4364-b611-3cf81c8e09c5', '85a788d6-1d9c-4364-b611-3cf81c8e09c5', '{"sub": "85a788d6-1d9c-4364-b611-3cf81c8e09c5", "email": "pushkar@gmail.com", "email_verified": false, "phone_verified": false}', 'email', '2025-07-03 19:07:35.031564+00', '2025-07-03 19:07:35.031621+00', '2025-07-03 19:07:35.031621+00', '84b03dea-09c4-41ec-bda9-fa5660e5926e');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") VALUES
	('a18979af-e31c-49ff-a2c8-016a0edd6595', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', '2025-07-04 15:13:30.435615+00', '2025-07-05 12:26:14.427089+00', NULL, 'aal1', NULL, '2025-07-05 12:26:14.427008', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '49.36.33.183', NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('a18979af-e31c-49ff-a2c8-016a0edd6595', '2025-07-04 15:13:30.440491+00', '2025-07-04 15:13:30.440491+00', 'password', 'c3e987a0-4cd1-4902-b375-1d7f3484345a');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 146, 'nwhat2jdytyi', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', true, '2025-07-04 15:13:30.436827+00', '2025-07-04 16:14:29.422676+00', NULL, 'a18979af-e31c-49ff-a2c8-016a0edd6595'),
	('00000000-0000-0000-0000-000000000000', 147, 'nzaovhl7z4es', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', true, '2025-07-04 16:14:29.425572+00', '2025-07-04 17:41:39.032317+00', 'nwhat2jdytyi', 'a18979af-e31c-49ff-a2c8-016a0edd6595'),
	('00000000-0000-0000-0000-000000000000', 148, '2t73bx2yfwaq', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', true, '2025-07-04 17:41:39.033721+00', '2025-07-05 12:26:14.402384+00', 'nzaovhl7z4es', 'a18979af-e31c-49ff-a2c8-016a0edd6595'),
	('00000000-0000-0000-0000-000000000000', 149, '2hvosx66tcnp', 'bdd57d85-27f2-44e8-a773-a9820fbcc189', false, '2025-07-05 12:26:14.413374+00', '2025-07-05 12:26:14.413374+00', '2t73bx2yfwaq', 'a18979af-e31c-49ff-a2c8-016a0edd6595');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: asset_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."asset_types" ("asset_type_id", "asset_type_name", "description") VALUES
	(1, 'Laptop', 'Portable computing device'),
	(2, 'Desktop', 'Stationary computing device'),
	(4, 'UPS', 'Power provider');


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."departments" ("department_id", "department_name") VALUES
	(1, 'IT'),
	(2, 'HR'),
	(5, 'Finance'),
	(6, 'Operations'),
	(7, 'Marketing'),
	(8, 'Sales'),
	(9, 'Procurement'),
	(10, 'Customer Support'),
	(11, 'Legal'),
	(12, 'Research & Development'),
	(13, 'Administration'),
	(14, 'Security');


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."locations" ("location_id", "location_name") VALUES
	(4, 'Chinchwad'),
	(5, 'Pune202'),
	(2, 'Pune War'),
	(1, 'Mumbai');


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."employees" ("employee_id", "employee_name", "email", "department_id", "location_id", "phone_no", "role", "employee_tag") VALUES
	(1, 'John Doe', 'john.doe@exide.com', 1, 1, '+91-9876543210', 'admin', 'A1Z3B'),
	(2, 'Jane Smith', 'jane.smith@exide.com', 2, 2, '+91-9123456789', 'manager', 'K9L2D'),
	(3, 'Raj Patel', 'raj.patel@exide.com', 1, 1, '+91-9988776655', 'employee', 'X5T7E'),
	(6, 'Anita Desai', 'anita.desai@exide.com', 1, 1, '+91-9012345678', 'employee', 'M2Q8F'),
	(7, 'Rohan Mehta', 'rohan.mehta@exide.com', 1, 1, '+91-9023456789', 'employee', 'H6Y9N'),
	(8, 'Priya Nair', 'priya.nair@exide.com', 2, 2, '+91-9034567890', 'employee', 'T7W3A'),
	(9, 'Kunal Rao', 'kunal.rao@exide.com', 2, 2, '+91-9045678901', 'manager', 'C4U9Z'),
	(10, 'Meera Shah', 'meera.shah@exide.com', 5, 5, '+91-9056789012', 'employee', 'V8E1P'),
	(12, 'Sneha Agarwal', 'sneha.agarwal@exide.com', 8, 1, '+91-9078901234', 'employee', 'B7D6L'),
	(13, 'Manish Verma', 'manish.verma@exide.com', 8, 1, '+91-9089012345', 'employee', 'Z2R5J'),
	(14, 'Divya Reddy', 'divya.reddy@exide.com', 10, 1, '+91-9090123456', 'employee', 'F1N3S'),
	(11, 'Amit Kulkarni', 'amit.kulkani@exide.com', 6, 4, '+91-9067890123', 'manager', 'L5G78');


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."sections" ("section_id", "section_name", "department_id") VALUES
	(1, 'Section A', 2),
	(2, 'Infrastructure', 1),
	(3, 'Software Development', 1),
	(4, 'Recruitment', 2),
	(5, 'Employee Relations', 2),
	(6, 'Payroll', 5),
	(7, 'Audit', 5),
	(8, 'Logistics', 6),
	(9, 'Facilities', 6),
	(10, 'Digital Marketing', 7),
	(11, 'Brand Management', 7),
	(12, 'B2B Sales', 8),
	(13, 'B2C Sales', 8),
	(14, 'Vendor Management', 9),
	(15, 'Inventory Control', 9),
	(16, 'Helpdesk', 10),
	(17, 'Technical Support', 10),
	(18, 'Legal Compliance', 11),
	(19, 'Contract Management', 11),
	(20, 'Product Research', 12),
	(21, 'Quality Assurance', 12),
	(22, 'Office Management', 13),
	(23, 'Front Desk', 13),
	(24, 'Surveillance', 14),
	(25, 'Cybersecurity', 14);


--
-- Data for Name: sub_locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."sub_locations" ("sub_location_id", "location_id", "sub_location_name") VALUES
	(2, 4, 'Building A'),
	(3, 1, 'Ground Floor'),
	(4, 1, 'First Floor'),
	(5, 1, 'Server Room'),
	(6, 1, 'Training Room'),
	(7, 1, 'IT Room'),
	(8, 4, 'Manufacturing Floor A'),
	(9, 4, 'Manufacturing Floor B'),
	(10, 4, 'Logistics Area'),
	(11, 4, 'Admin Block'),
	(12, 4, 'Maintenance Bay'),
	(13, 5, 'Reception'),
	(14, 5, 'Accounts Room'),
	(15, 5, 'Lab 1'),
	(16, 5, 'Lab 2'),
	(17, 5, 'Pantry'),
	(18, 2, 'Sales Bay'),
	(19, 2, 'HR Corner'),
	(20, 2, 'Conference Room'),
	(21, 2, 'Tech Zone'),
	(22, 2, 'Backup Room');


--
-- Data for Name: assets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."assets" ("asset_id", "asset_type_id", "make", "model", "serial_number", "purchase_date", "warranty_expiry", "purchase_invoice_number", "order_number", "location_id", "department_id", "employee_id", "description", "blank_field_1", "blank_field_2", "blank_field_3", "specification", "sap_reference", "status", "sub_location_id", "section_id", "remarks", "hostname") VALUES
	(59, 1, 'Acer', 'Spin 3', 'SN200017', '2024-03-25', '2026-03-25', 'INV2017', 'ORD2017', 1, 1, 2, 'Lightweight device', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2017', 'assigned', NULL, NULL, NULL, NULL),
	(58, 1, 'Dell', 'XPS 15', 'SN200016', '2024-03-20', '2026-03-20', 'INV2016', 'ORD2016', 1, 1, 1, 'Senior admin machine', NULL, NULL, NULL, '32GB RAM, 1TB SSD', 'SAP2016', 'assigned', NULL, NULL, NULL, 'mumb-058'),
	(60, 1, 'Asus', 'ROG Strix', 'SN200018', '2024-03-30', '2026-03-30', 'INV2018', 'ORD2018', 1, 1, 3, 'Gaming benchmark', NULL, NULL, NULL, '32GB RAM, 2TB SSD', 'SAP2018', 'assigned', NULL, NULL, NULL, 'mumb-060'),
	(61, 1, 'HP', 'Spectre x360', 'SN200019', '2024-04-01', '2026-04-01', 'INV2019', 'ORD2019', 1, 1, 6, 'Presentation unit', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2019', 'assigned', NULL, NULL, NULL, 'mumb-061'),
	(62, 1, 'Lenovo', 'Flex 5', 'SN200020', '2024-04-05', '2026-04-05', 'INV2020', 'ORD2020', 1, 1, 7, 'Notebook use', NULL, NULL, NULL, '8GB RAM, 1TB HDD', 'SAP2020', 'assigned', NULL, NULL, NULL, 'mumb-062'),
	(43, 1, 'Dell', 'Inspiron 15', 'SN200001', '2024-01-01', '2026-01-01', 'INV2001', 'ORD2001', 1, 1, 1, 'Laptop for admin use', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2001', 'assigned', NULL, NULL, NULL, 'mumb-043'),
	(44, 1, 'HP', 'EliteBook 840', 'SN200002', '2024-01-05', '2026-01-05', 'INV2002', 'ORD2002', 1, 1, 2, 'IT employee device', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2002', 'assigned', NULL, NULL, NULL, 'mumb-044'),
	(45, 1, 'Lenovo', 'ThinkPad E14', 'SN200003', '2024-01-10', '2026-01-10', 'INV2003', 'ORD2003', 1, 1, 3, 'Development laptop', NULL, NULL, NULL, '8GB RAM, 1TB HDD', 'SAP2003', 'assigned', NULL, NULL, NULL, 'mumb-045'),
	(46, 1, 'Apple', 'MacBook Air', 'SN200004', '2024-01-15', '2026-01-15', 'INV2004', 'ORD2004', 1, 1, 6, 'Creative work', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2004', 'assigned', NULL, NULL, NULL, 'mumb-046'),
	(52, 1, 'Apple', 'MacBook Pro', 'SN200010', '2024-02-20', '2026-02-20', 'INV2010', 'ORD2010', 1, 8, 12, 'Design laptop', NULL, NULL, NULL, '16GB RAM, 1TB SSD', 'SAP2010', 'assigned', NULL, NULL, NULL, 'mumb-052'),
	(53, 1, 'Dell', 'Vostro 3400', 'SN200011', '2024-02-25', '2026-02-25', 'INV2011', 'ORD2011', 1, 8, 13, 'Support team laptop', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2011', 'assigned', NULL, NULL, NULL, 'mumb-053'),
	(54, 1, 'MSI', 'Modern 15', 'SN200012', '2024-03-01', '2026-03-01', 'INV2012', 'ORD2012', 1, 10, 14, 'Video editing', NULL, NULL, NULL, '16GB RAM, 1TB SSD', 'SAP2012', 'assigned', NULL, NULL, NULL, 'mumb-054'),
	(56, 1, 'Lenovo', 'Yoga Slim 7', 'SN200014', '2024-03-10', '2026-03-10', 'INV2014', 'ORD2014', 1, 1, 6, 'Meetings', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2014', 'assigned', NULL, NULL, NULL, 'mumb-056'),
	(63, 1, 'Apple', 'MacBook Pro M2', 'SN200021', '2024-04-10', '2026-04-10', 'INV2021', 'ORD2021', 1, 8, 12, 'Design team', NULL, NULL, NULL, '16GB RAM, 1TB SSD', 'SAP2021', 'assigned', NULL, NULL, NULL, 'mumb-063'),
	(64, 1, 'HP', 'ZBook', 'SN200022', '2024-04-15', '2026-04-15', 'INV2022', 'ORD2022', 1, 8, 13, 'Engineering', NULL, NULL, NULL, '32GB RAM, 2TB SSD', 'SAP2022', 'assigned', NULL, NULL, NULL, 'mumb-064'),
	(65, 1, 'Dell', 'Precision 5550', 'SN200023', '2024-04-20', '2026-04-20', 'INV2023', 'ORD2023', 1, 10, 14, 'Advanced CAD', NULL, NULL, NULL, '64GB RAM, 2TB SSD', 'SAP2023', 'assigned', NULL, NULL, NULL, 'mumb-065'),
	(66, 1, 'Lenovo', 'ThinkBook 15', 'SN200024', '2024-04-25', '2026-04-25', 'INV2024', 'ORD2024', 1, 1, 1, 'Management reporting', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2024', 'assigned', NULL, NULL, NULL, 'mumb-066'),
	(2, 1, 'Dell', 'Latitude 7400', 'SN789012', '2023-02-10', '2025-02-10', 'INV002', 'ORD002', 1, 1, 3, 'Unassigned laptop', 'Spare part included', NULL, NULL, '8GB RAM, 256GB SSD', 'SAP002', 'assigned', NULL, NULL, NULL, 'mumb-002'),
	(3, 1, 'HP', 'EliteBook 840', 'SN345678', '2022-06-01', '2024-06-01', 'INV003', 'ORD003', 1, 13, 1, 'Damaged laptop', NULL, NULL, NULL, '4GB RAM, 128GB SSD', 'SAP003', 'assigned', 3, 22, NULL, 'mumb-003'),
	(1, 1, 'Dell', 'XPS 13', 'SN123456', '2023-01-15', '2025-01-15', 'INV001', 'ORD001', 1, 1, 1, 'High-performance laptop', 'Extra battery', 'Extended warranty', 'Used in project X', '16GB RAM, 512GB SSD', 'SAP001', 'assigned', 4, 2, NULL, 'mumb-001'),
	(47, 1, 'HP', 'Pavilion', 'SN200005', '2024-01-20', '2026-01-20', 'INV2005', 'ORD2005', 2, 2, 7, 'HR assistant laptop', NULL, NULL, NULL, '8GB RAM, 512GB SSD', 'SAP2005', 'assigned', NULL, NULL, NULL, 'pune-047'),
	(48, 1, 'Dell', 'Latitude 5410', 'SN200006', '2024-02-01', '2026-02-01', 'INV2006', 'ORD2006', 2, 2, 8, 'Management use', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2006', 'assigned', NULL, NULL, NULL, 'pune-048'),
	(49, 1, 'Lenovo', 'IdeaPad Slim 3', 'SN200007', '2024-02-05', '2026-02-05', 'INV2007', 'ORD2007', 2, 2, 9, 'Business analytics', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2007', 'assigned', NULL, NULL, NULL, 'pune-049'),
	(55, 1, 'HP', 'x360', 'SN200013', '2024-03-05', '2026-03-05', 'INV2013', 'ORD2013', 2, 2, 8, 'Presentation use', NULL, NULL, NULL, '8GB RAM, 512GB SSD', 'SAP2013', 'assigned', NULL, NULL, NULL, 'pune-055'),
	(57, 1, 'HP', 'Chromebook', 'SN200015', '2024-03-15', '2026-03-15', 'INV2015', 'ORD2015', 2, 2, 9, 'Training device', NULL, NULL, NULL, '4GB RAM, 64GB SSD', 'SAP2015', 'assigned', NULL, NULL, NULL, 'pune-057'),
	(51, 1, 'Acer', 'Aspire 5', 'SN200009', '2024-02-15', '2026-02-15', 'INV2009', 'ORD2009', 4, 6, 11, 'IT backup system', 'a', 'b', 'a', '8GB RAM, 512GB SSD', 'SAP2009', 'assigned', NULL, NULL, 'assfcsa', 'chcw-051'),
	(13, 1, 'HP', 'UPS111', 'SN78012', '2025-06-05', '2025-06-06', 'INV00e', 'SA121321', 4, 10, 2, NULL, NULL, NULL, NULL, NULL, 'ASXZWX2', 'assigned', 11, 16, NULL, 'chcw-013'),
	(67, 2, 'HP', 'Notebook 14s', 'SN200025', '2024-04-30', '2026-04-30', 'INV2025', 'ORD2025', 1, 1, 2, 'Documentation', 'Spare part included', 'Extended warranty', 'Used in project X', '8GB RAM, 256GB SSD', 'SAP2025', 'assigned', NULL, NULL, 'ignjm', 'pune-0699');


--
-- Data for Name: disposed; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."disposed" ("disposed_id", "asset_id", "asset_type_id", "make", "model", "serial_number", "purchase_date", "warranty_expiry", "purchase_invoice_number", "order_number", "location_id", "department_id", "description", "blank_field_1", "blank_field_2", "blank_field_3", "specification", "sap_reference", "disposed_date", "reason") VALUES
	(1, 3, 1, 'HP', 'EliteBook 840', 'SN345678', '2022-06-01', '2024-06-01', 'INV003', 'ORD003', 1, 1, 'Damaged laptop', '', '', '', '4GB RAM, 128GB SSD', 'SAP003', '2025-06-21', 'Damaged beyond repair'),
	(8, 10, 4, 'Lenovo', 'UPS111', 'ABC10121', '2025-06-11', '2025-06-06', '1121SAAAZ', 'ORD00sDD', 1, 2, '500W', NULL, NULL, NULL, NULL, 'ASXZXWX2', '2025-06-23', 'obsolete machine'),
	(9, 9, 2, 'HP', 'EliteBook 840', 'SN345672', '2025-06-03', '2025-06-06', 'INV003', 'SDA121321', 5, 1, NULL, NULL, NULL, NULL, NULL, '1321ES1A', '2025-06-24', 'obsolete machine'),
	(11, 50, 1, 'HP', 'ProBook 450', 'SN200008', '2024-02-10', '2026-02-10', 'INV2008', 'ORD2008', 5, 5, 'Project use', NULL, NULL, NULL, '8GB RAM, 1TB HDD', 'SAP2008', '2025-06-24', 'Obsolete machine'),
	(12, 68, 1, 'HP', 'Latitude 7400', 'SN345677', '2025-06-03', '2025-07-02', 'INV00a', 'ORD00a', 4, 2, NULL, NULL, NULL, NULL, NULL, 'SAP00a', '2025-06-26', 'Obsolete machine'),
	(13, 69, 4, 'Dell', 'UPS111', 'SN780122', '2025-07-08', '2025-07-31', 'INV0011', 'ORD0011', 4, 13, NULL, NULL, NULL, NULL, NULL, 'SAP0011', '2025-07-03', 'Obsolete machine');


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "updated_at", "username", "full_name", "avatar_url", "website", "role", "email", "location_id") VALUES
	('4aecde7f-c242-4fb7-a6ff-223cae98d684', '2025-07-03 19:55:18.184+00', 'admin', NULL, NULL, NULL, 'admin', NULL, 4),
	('9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', '2025-07-03 19:55:25.48+00', 'master', NULL, NULL, NULL, 'master', NULL, 1),
	('224601f4-7a17-466d-b4c9-c8d8ce94aa82', '2025-07-03 19:55:30.324+00', 'user', NULL, NULL, NULL, 'user', NULL, 4),
	('bdd57d85-27f2-44e8-a773-a9820fbcc189', '2025-07-03 20:29:52.701652+00', 'super', 'super', NULL, NULL, 'superadmin', 'super@admin.com', NULL),
	('85a788d6-1d9c-4364-b611-3cf81c8e09c5', '2025-07-04 08:49:28.303+00', 'pushkar', 'pushkar', NULL, NULL, 'admin', 'pushkar@gmail.com', 4);


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."stock" ("stock_id", "asset_id", "asset_type_id", "make", "model", "serial_number", "purchase_date", "warranty_expiry", "purchase_invoice_number", "order_number", "location_id", "department_id", "description", "blank_field_1", "blank_field_2", "blank_field_3", "specification", "sap_reference", "status", "notes") VALUES
	(1, 2, 1, 'Dell', 'Latitude 7400', 'SN789012', '2023-02-10', '2025-02-10', 'INV002', 'ORD002', 1, 1, 'Unassigned laptop', 'Spare part included', '', '', '8GB RAM, 256GB SSD', 'SAP002', 'in_stock', 'Stored in Mumbai warehouse');


--
-- Data for Name: table_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: transfer_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."transfer_history" ("transfer_id", "asset_id", "make", "model", "from_employee_id", "to_employee_id", "from_department_id", "to_department_id", "from_location_id", "to_location_id", "transfer_date", "notes") VALUES
	(1, 1, 'Dell', 'XPS 13', 1, 2, 1, 2, 1, 2, '2025-06-21 10:00:00', 'Transferred due to employee relocation'),
	(4, 2, 'Dell', 'Latitude 7400', NULL, 3, 1, 1, 1, 1, '2025-06-22 08:11:57.225655', 'Auto-logged via trigger'),
	(8, 13, 'HP', 'UPS111', 2, 3, 1, 1, 4, 4, '2025-06-23 17:35:58.059572', 'Auto-logged via trigger'),
	(2, NULL, 'Lenovo', 'UPS111', NULL, 3, 1, 1, 4, 2, '2025-06-22 07:35:13.803543', 'Auto-logged via trigger'),
	(3, NULL, 'Lenovo', 'UPS111', 3, 1, 1, 2, 2, 1, '2025-06-22 07:36:32.075044', 'Auto-logged via trigger'),
	(5, NULL, 'Lenovo', 'UPS111', 1, NULL, 2, 2, 1, 1, '2025-06-23 08:27:56.644316', 'Auto-logged via trigger'),
	(9, 13, 'HP', 'UPS111', 3, 2, 1, 1, 4, 4, '2025-06-24 10:47:02.035973', 'Auto-logged via trigger'),
	(6, NULL, 'HP', 'EliteBook 840', 2, 3, 1, 1, 5, 5, '2025-06-23 10:16:10.365749', 'Auto-logged via trigger'),
	(7, NULL, 'HP', 'EliteBook 840', 3, NULL, 1, 1, 5, 5, '2025-06-23 10:26:53.495357', 'Auto-logged via trigger'),
	(10, 13, 'HP', 'UPS111', 2, 2, 1, 2, 4, 4, '2025-06-24 19:56:25.483776', 'Auto-logged via trigger'),
	(11, 3, 'HP', 'EliteBook 840', 1, 1, 1, 13, 1, 1, '2025-06-24 20:30:37.746517', 'Auto-logged via trigger'),
	(12, NULL, 'HP', 'Latitude 7400', NULL, 6, 2, 2, 4, 4, '2025-06-25 10:10:45.211712', 'Auto-logged via trigger'),
	(13, 13, 'HP', 'UPS111', 2, 2, 2, 10, 4, 4, '2025-06-26 17:51:43.896795', 'Auto-logged via trigger'),
	(16, 13, 'HP', 'UPS111', 2, 2, 10, 2, 4, 4, '2025-06-26 18:01:58.521273', 'Auto-logged via trigger'),
	(17, 13, 'HP', 'UPS111', 2, 2, 2, 10, 4, 4, '2025-06-26 18:02:37.596747', 'Auto-logged via trigger');


--
-- Data for Name: vendors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."vendors" ("vendor_id", "vendor_name", "contact_email", "phone", "address", "remarks") VALUES
	(1, 'HP', 'sales@hp.com', '+91-1234567890', '456 Tech St', NULL),
	(2, 'Dell', 'contact@itsolutions.com', '+91-1122334455', '789 IT Park', ''),
	(4, 'Lenovo', 'lenovo@gmail.com', '9876543219', '789 IT Park', '');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 149, true);


--
-- Name: asset_types_asset_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."asset_types_asset_type_id_seq"', 4, true);


--
-- Name: assets_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."assets_asset_id_seq"', 69, true);


--
-- Name: departments_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."departments_department_id_seq"', 14, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."employees_employee_id_seq"', 14, true);


--
-- Name: locations_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."locations_location_id_seq"', 7, true);


--
-- Name: scrap_scrap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."scrap_scrap_id_seq"', 13, true);


--
-- Name: sections_section_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."sections_section_id_seq"', 25, true);


--
-- Name: stock_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."stock_stock_id_seq"', 1, true);


--
-- Name: sub_locations_sub_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."sub_locations_sub_location_id_seq"', 22, true);


--
-- Name: table_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."table_permissions_id_seq"', 14, true);


--
-- Name: transfer_history_transfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."transfer_history_transfer_id_seq"', 17, true);


--
-- Name: vendors_vendor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."vendors_vendor_id_seq"', 4, true);


--
-- PostgreSQL database dump complete
--

RESET ALL;
