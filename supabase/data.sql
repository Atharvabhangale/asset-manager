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
	('00000000-0000-0000-0000-000000000000', 'cc3f5113-c25c-49ae-af94-8c7ed524472a', '{"action":"login","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 18:02:46.224228+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b5219274-2f42-4561-854e-2273dcc310df', '{"action":"logout","actor_id":"b2e790bb-baa2-4117-bcd0-31c743168039","actor_username":"atharvabhangale5@gmail.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:03:14.589197+00', ''),
	('00000000-0000-0000-0000-000000000000', '6dcf7c46-6ead-45fb-852b-518848a5371e', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-26 18:15:54.781218+00', ''),
	('00000000-0000-0000-0000-000000000000', '8a61d9fb-59f4-4fa6-b3fc-761ef1600976', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-26 18:16:17.239493+00', ''),
	('00000000-0000-0000-0000-000000000000', '4c945455-5045-42c2-92f3-24c00a009eff', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 08:19:54.282973+00', ''),
	('00000000-0000-0000-0000-000000000000', '2f1125ff-5cdb-4d0c-bfd3-25513f8f69b8', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 08:20:09.403394+00', ''),
	('00000000-0000-0000-0000-000000000000', '67ddb782-df1a-486d-afa3-43637dc654b1', '{"action":"login","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 08:20:12.879583+00', ''),
	('00000000-0000-0000-0000-000000000000', '177eba62-d584-4741-b808-c7f4f59215ff', '{"action":"logout","actor_id":"224601f4-7a17-466d-b4c9-c8d8ce94aa82","actor_username":"user@user.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 08:20:17.325606+00', ''),
	('00000000-0000-0000-0000-000000000000', 'd30b02a1-51c4-4933-a697-7826208ced26', '{"action":"login","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-06-27 08:20:20.509338+00', ''),
	('00000000-0000-0000-0000-000000000000', 'b57d5d92-ed92-4cb4-be28-57908d0e94ad', '{"action":"logout","actor_id":"4aecde7f-c242-4fb7-a6ff-223cae98d684","actor_username":"admin@admin.com","actor_via_sso":false,"log_type":"account"}', '2025-06-27 08:44:49.69705+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', 'b2e790bb-baa2-4117-bcd0-31c743168039', 'authenticated', 'authenticated', 'atharvabhangale5@gmail.com', '$2a$10$fnBg26H.5cprXaaqnSKg9ODESuNFNyFjHhiY3BnhGD9CBA/BEeXG6', '2025-06-26 17:39:19.774672+00', NULL, '', '2025-06-26 17:38:51.397159+00', '', NULL, '', '', NULL, '2025-06-26 18:02:46.225758+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "b2e790bb-baa2-4117-bcd0-31c743168039", "email": "atharvabhangale5@gmail.com", "email_verified": true, "phone_verified": false}', NULL, '2025-06-26 17:38:51.370879+00', '2025-06-26 18:02:46.227637+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', 'authenticated', 'authenticated', 'master@master.com', '$2a$10$4Mp9Qd3nN1MYXQGfV72Jx.dZbpAqpvJGO0.wRMmG8qgxvgPiDfxP2', '2025-06-26 15:49:42.437105+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-26 16:48:04.993139+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-26 15:49:42.415879+00', '2025-06-26 16:48:04.994814+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '224601f4-7a17-466d-b4c9-c8d8ce94aa82', 'authenticated', 'authenticated', 'user@user.com', '$2a$10$PsZHXLnup5idHYWtdyc/muFzfjhRL1FWuXqb.qk43T016XXnaZH0e', '2025-06-26 15:50:16.540122+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-27 08:20:12.880329+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-26 15:50:16.5322+00', '2025-06-27 08:20:12.884989+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '4aecde7f-c242-4fb7-a6ff-223cae98d684', 'authenticated', 'authenticated', 'admin@admin.com', '$2a$10$hf0FpcOkG91JYWSxRIcIdO8dPUpyAjWhvIWHrF3eFMLZID/KquMGG', '2025-06-26 15:50:38.994136+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-06-27 08:20:20.510043+00', '{"provider": "email", "providers": ["email"]}', '{"email_verified": true}', NULL, '2025-06-26 15:50:38.990048+00', '2025-06-27 08:20:20.511777+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', '9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', '{"sub": "9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b", "email": "master@master.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-26 15:49:42.429991+00', '2025-06-26 15:49:42.430072+00', '2025-06-26 15:49:42.430072+00', '9b508c81-a956-4693-94ae-eeb7efcda751'),
	('224601f4-7a17-466d-b4c9-c8d8ce94aa82', '224601f4-7a17-466d-b4c9-c8d8ce94aa82', '{"sub": "224601f4-7a17-466d-b4c9-c8d8ce94aa82", "email": "user@user.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-26 15:50:16.534186+00', '2025-06-26 15:50:16.534241+00', '2025-06-26 15:50:16.534241+00', 'f3885595-33ba-4b82-9876-0ba045ceef85'),
	('4aecde7f-c242-4fb7-a6ff-223cae98d684', '4aecde7f-c242-4fb7-a6ff-223cae98d684', '{"sub": "4aecde7f-c242-4fb7-a6ff-223cae98d684", "email": "admin@admin.com", "email_verified": false, "phone_verified": false}', 'email', '2025-06-26 15:50:38.992199+00', '2025-06-26 15:50:38.992255+00', '2025-06-26 15:50:38.992255+00', '3b106a86-64d0-4bae-9db2-7ab7d3454148'),
	('b2e790bb-baa2-4117-bcd0-31c743168039', 'b2e790bb-baa2-4117-bcd0-31c743168039', '{"sub": "b2e790bb-baa2-4117-bcd0-31c743168039", "email": "atharvabhangale5@gmail.com", "email_verified": true, "phone_verified": false}', 'email', '2025-06-26 17:38:51.390385+00', '2025-06-26 17:38:51.390457+00', '2025-06-26 17:38:51.390457+00', '99a80eb6-9733-4b3c-9e8c-dfe96276a86e');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



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

INSERT INTO "public"."employees" ("employee_id", "employee_name", "email", "department_id", "location_id", "phone_no", "role") VALUES
	(1, 'John Doe', 'john.doe@exide.com', 1, 1, '+91-9876543210', 'admin'),
	(2, 'Jane Smith', 'jane.smith@exide.com', 2, 2, '+91-9123456789', 'manager'),
	(3, 'Raj Patel', 'raj.patel@exide.com', 1, 1, '+91-9988776655', 'employee'),
	(6, 'Anita Desai', 'anita.desai@exide.com', 1, 1, '+91-9012345678', 'employee'),
	(7, 'Rohan Mehta', 'rohan.mehta@exide.com', 1, 1, '+91-9023456789', 'employee'),
	(8, 'Priya Nair', 'priya.nair@exide.com', 2, 2, '+91-9034567890', 'employee'),
	(9, 'Kunal Rao', 'kunal.rao@exide.com', 2, 2, '+91-9045678901', 'manager'),
	(10, 'Meera Shah', 'meera.shah@exide.com', 5, 5, '+91-9056789012', 'employee'),
	(12, 'Sneha Agarwal', 'sneha.agarwal@exide.com', 8, 1, '+91-9078901234', 'employee'),
	(13, 'Manish Verma', 'manish.verma@exide.com', 8, 1, '+91-9089012345', 'employee'),
	(14, 'Divya Reddy', 'divya.reddy@exide.com', 10, 1, '+91-9090123456', 'employee'),
	(11, 'Amit Kulkarni', 'amit.kulkani@exide.com', 6, 4, '+91-9067890123', 'manager');


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

INSERT INTO "public"."assets" ("asset_id", "asset_type_id", "make", "model", "serial_number", "purchase_date", "warranty_expiry", "purchase_invoice_number", "order_number", "location_id", "department_id", "employee_id", "description", "blank_field_1", "blank_field_2", "blank_field_3", "specification", "sap_reference", "status", "sub_location_id", "section_id") VALUES
	(43, 1, 'Dell', 'Inspiron 15', 'SN200001', '2024-01-01', '2026-01-01', 'INV2001', 'ORD2001', 1, 1, 1, 'Laptop for admin use', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2001', 'assigned', NULL, NULL),
	(44, 1, 'HP', 'EliteBook 840', 'SN200002', '2024-01-05', '2026-01-05', 'INV2002', 'ORD2002', 1, 1, 2, 'IT employee device', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2002', 'assigned', NULL, NULL),
	(45, 1, 'Lenovo', 'ThinkPad E14', 'SN200003', '2024-01-10', '2026-01-10', 'INV2003', 'ORD2003', 1, 1, 3, 'Development laptop', NULL, NULL, NULL, '8GB RAM, 1TB HDD', 'SAP2003', 'assigned', NULL, NULL),
	(46, 1, 'Apple', 'MacBook Air', 'SN200004', '2024-01-15', '2026-01-15', 'INV2004', 'ORD2004', 1, 1, 6, 'Creative work', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2004', 'assigned', NULL, NULL),
	(47, 1, 'HP', 'Pavilion', 'SN200005', '2024-01-20', '2026-01-20', 'INV2005', 'ORD2005', 2, 2, 7, 'HR assistant laptop', NULL, NULL, NULL, '8GB RAM, 512GB SSD', 'SAP2005', 'assigned', NULL, NULL),
	(48, 1, 'Dell', 'Latitude 5410', 'SN200006', '2024-02-01', '2026-02-01', 'INV2006', 'ORD2006', 2, 2, 8, 'Management use', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2006', 'assigned', NULL, NULL),
	(49, 1, 'Lenovo', 'IdeaPad Slim 3', 'SN200007', '2024-02-05', '2026-02-05', 'INV2007', 'ORD2007', 2, 2, 9, 'Business analytics', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2007', 'assigned', NULL, NULL),
	(51, 1, 'Acer', 'Aspire 5', 'SN200009', '2024-02-15', '2026-02-15', 'INV2009', 'ORD2009', 4, 6, 11, 'IT backup system', NULL, NULL, NULL, '8GB RAM, 512GB SSD', 'SAP2009', 'assigned', NULL, NULL),
	(52, 1, 'Apple', 'MacBook Pro', 'SN200010', '2024-02-20', '2026-02-20', 'INV2010', 'ORD2010', 1, 8, 12, 'Design laptop', NULL, NULL, NULL, '16GB RAM, 1TB SSD', 'SAP2010', 'assigned', NULL, NULL),
	(53, 1, 'Dell', 'Vostro 3400', 'SN200011', '2024-02-25', '2026-02-25', 'INV2011', 'ORD2011', 1, 8, 13, 'Support team laptop', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2011', 'assigned', NULL, NULL),
	(54, 1, 'MSI', 'Modern 15', 'SN200012', '2024-03-01', '2026-03-01', 'INV2012', 'ORD2012', 1, 10, 14, 'Video editing', NULL, NULL, NULL, '16GB RAM, 1TB SSD', 'SAP2012', 'assigned', NULL, NULL),
	(55, 1, 'HP', 'x360', 'SN200013', '2024-03-05', '2026-03-05', 'INV2013', 'ORD2013', 2, 2, 8, 'Presentation use', NULL, NULL, NULL, '8GB RAM, 512GB SSD', 'SAP2013', 'assigned', NULL, NULL),
	(56, 1, 'Lenovo', 'Yoga Slim 7', 'SN200014', '2024-03-10', '2026-03-10', 'INV2014', 'ORD2014', 1, 1, 6, 'Meetings', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2014', 'assigned', NULL, NULL),
	(57, 1, 'HP', 'Chromebook', 'SN200015', '2024-03-15', '2026-03-15', 'INV2015', 'ORD2015', 2, 2, 9, 'Training device', NULL, NULL, NULL, '4GB RAM, 64GB SSD', 'SAP2015', 'assigned', NULL, NULL),
	(58, 1, 'Dell', 'XPS 15', 'SN200016', '2024-03-20', '2026-03-20', 'INV2016', 'ORD2016', 1, 1, 1, 'Senior admin machine', NULL, NULL, NULL, '32GB RAM, 1TB SSD', 'SAP2016', 'assigned', NULL, NULL),
	(59, 1, 'Acer', 'Spin 3', 'SN200017', '2024-03-25', '2026-03-25', 'INV2017', 'ORD2017', 1, 1, 2, 'Lightweight device', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2017', 'assigned', NULL, NULL),
	(60, 1, 'Asus', 'ROG Strix', 'SN200018', '2024-03-30', '2026-03-30', 'INV2018', 'ORD2018', 1, 1, 3, 'Gaming benchmark', NULL, NULL, NULL, '32GB RAM, 2TB SSD', 'SAP2018', 'assigned', NULL, NULL),
	(61, 1, 'HP', 'Spectre x360', 'SN200019', '2024-04-01', '2026-04-01', 'INV2019', 'ORD2019', 1, 1, 6, 'Presentation unit', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2019', 'assigned', NULL, NULL),
	(62, 1, 'Lenovo', 'Flex 5', 'SN200020', '2024-04-05', '2026-04-05', 'INV2020', 'ORD2020', 1, 1, 7, 'Notebook use', NULL, NULL, NULL, '8GB RAM, 1TB HDD', 'SAP2020', 'assigned', NULL, NULL),
	(63, 1, 'Apple', 'MacBook Pro M2', 'SN200021', '2024-04-10', '2026-04-10', 'INV2021', 'ORD2021', 1, 8, 12, 'Design team', NULL, NULL, NULL, '16GB RAM, 1TB SSD', 'SAP2021', 'assigned', NULL, NULL),
	(64, 1, 'HP', 'ZBook', 'SN200022', '2024-04-15', '2026-04-15', 'INV2022', 'ORD2022', 1, 8, 13, 'Engineering', NULL, NULL, NULL, '32GB RAM, 2TB SSD', 'SAP2022', 'assigned', NULL, NULL),
	(65, 1, 'Dell', 'Precision 5550', 'SN200023', '2024-04-20', '2026-04-20', 'INV2023', 'ORD2023', 1, 10, 14, 'Advanced CAD', NULL, NULL, NULL, '64GB RAM, 2TB SSD', 'SAP2023', 'assigned', NULL, NULL),
	(66, 1, 'Lenovo', 'ThinkBook 15', 'SN200024', '2024-04-25', '2026-04-25', 'INV2024', 'ORD2024', 1, 1, 1, 'Management reporting', NULL, NULL, NULL, '16GB RAM, 512GB SSD', 'SAP2024', 'assigned', NULL, NULL),
	(67, 1, 'HP', 'Notebook 14s', 'SN200025', '2024-04-30', '2026-04-30', 'INV2025', 'ORD2025', 1, 1, 2, 'Documentation', NULL, NULL, NULL, '8GB RAM, 256GB SSD', 'SAP2025', 'assigned', NULL, NULL),
	(2, 1, 'Dell', 'Latitude 7400', 'SN789012', '2023-02-10', '2025-02-10', 'INV002', 'ORD002', 1, 1, 3, 'Unassigned laptop', 'Spare part included', NULL, NULL, '8GB RAM, 256GB SSD', 'SAP002', 'assigned', NULL, NULL),
	(3, 1, 'HP', 'EliteBook 840', 'SN345678', '2022-06-01', '2024-06-01', 'INV003', 'ORD003', 1, 13, 1, 'Damaged laptop', NULL, NULL, NULL, '4GB RAM, 128GB SSD', 'SAP003', 'assigned', 3, 22),
	(13, 1, 'HP', 'UPS111', 'SN78012', '2025-06-05', '2025-06-06', 'INV00e', 'SA121321', 4, 10, 2, NULL, NULL, NULL, NULL, NULL, 'ASXZWX2', 'assigned', 11, 16),
	(1, 1, 'Dell', 'XPS 13', 'SN123456', '2023-01-15', '2025-01-15', 'INV001', 'ORD001', 1, 1, 1, 'High-performance laptop', 'Extra battery', 'Extended warranty', 'Used in project X', '16GB RAM, 512GB SSD', 'SAP001', 'assigned', 4, 2);


--
-- Data for Name: disposed; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."disposed" ("disposed_id", "asset_id", "asset_type_id", "make", "model", "serial_number", "purchase_date", "warranty_expiry", "purchase_invoice_number", "order_number", "location_id", "department_id", "description", "blank_field_1", "blank_field_2", "blank_field_3", "specification", "sap_reference", "disposed_date", "reason") VALUES
	(1, 3, 1, 'HP', 'EliteBook 840', 'SN345678', '2022-06-01', '2024-06-01', 'INV003', 'ORD003', 1, 1, 'Damaged laptop', '', '', '', '4GB RAM, 128GB SSD', 'SAP003', '2025-06-21', 'Damaged beyond repair'),
	(8, 10, 4, 'Lenovo', 'UPS111', 'ABC10121', '2025-06-11', '2025-06-06', '1121SAAAZ', 'ORD00sDD', 1, 2, '500W', NULL, NULL, NULL, NULL, 'ASXZXWX2', '2025-06-23', 'obsolete machine'),
	(9, 9, 2, 'HP', 'EliteBook 840', 'SN345672', '2025-06-03', '2025-06-06', 'INV003', 'SDA121321', 5, 1, NULL, NULL, NULL, NULL, NULL, '1321ES1A', '2025-06-24', 'obsolete machine'),
	(11, 50, 1, 'HP', 'ProBook 450', 'SN200008', '2024-02-10', '2026-02-10', 'INV2008', 'ORD2008', 5, 5, 'Project use', NULL, NULL, NULL, '8GB RAM, 1TB HDD', 'SAP2008', '2025-06-24', 'Obsolete machine'),
	(12, 68, 1, 'HP', 'Latitude 7400', 'SN345677', '2025-06-03', '2025-07-02', 'INV00a', 'ORD00a', 4, 2, NULL, NULL, NULL, NULL, NULL, 'SAP00a', '2025-06-26', 'Obsolete machine');


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "updated_at", "username", "full_name", "avatar_url", "website", "role") VALUES
	('4aecde7f-c242-4fb7-a6ff-223cae98d684', NULL, 'admin', NULL, NULL, NULL, 'admin'),
	('9d9ebd07-c6f6-4220-9fcf-a2130f9fa56b', NULL, 'master', NULL, NULL, NULL, 'master'),
	('224601f4-7a17-466d-b4c9-c8d8ce94aa82', NULL, 'user', NULL, NULL, NULL, 'user'),
	('b2e790bb-baa2-4117-bcd0-31c743168039', NULL, NULL, NULL, NULL, NULL, 'user');


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."stock" ("stock_id", "asset_id", "asset_type_id", "make", "model", "serial_number", "purchase_date", "warranty_expiry", "purchase_invoice_number", "order_number", "location_id", "department_id", "description", "blank_field_1", "blank_field_2", "blank_field_3", "specification", "sap_reference", "status", "notes") VALUES
	(1, 2, 1, 'Dell', 'Latitude 7400', 'SN789012', '2023-02-10', '2025-02-10', 'INV002', 'ORD002', 1, 1, 'Unassigned laptop', 'Spare part included', '', '', '8GB RAM, 256GB SSD', 'SAP002', 'in_stock', 'Stored in Mumbai warehouse');


--
-- Data for Name: table_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."table_permissions" ("id", "user_id", "table_name", "permission") VALUES
	(14, '224601f4-7a17-466d-b4c9-c8d8ce94aa82', 'assets', 'all');


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

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 84, true);


--
-- Name: asset_types_asset_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."asset_types_asset_type_id_seq"', 4, true);


--
-- Name: assets_asset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."assets_asset_id_seq"', 68, true);


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

SELECT pg_catalog.setval('"public"."scrap_scrap_id_seq"', 12, true);


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
