--
-- PostgreSQL database dump
--

\restrict mt2knAHSlYRU9fSyax5ADaflnsJ6b6egqoUAegLcPOs0HNHwd7JMUuvoehEbYA3

-- Dumped from database version 16.14 (Debian 16.14-1.pgdg13+1)
-- Dumped by pg_dump version 16.14 (Debian 16.14-1.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Expenses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Expenses" (
    "Id" uuid NOT NULL,
    "UserId" uuid NOT NULL,
    "Description" character varying(500) NOT NULL,
    "Amount" numeric(18,2) DEFAULT 0 NOT NULL,
    "Category" character varying(100) DEFAULT 'Outros'::character varying NOT NULL,
    "DueDate" timestamp with time zone NOT NULL,
    "IsPaid" boolean DEFAULT false NOT NULL,
    "PaidAt" timestamp with time zone,
    "CreatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: Users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Users" (
    "Id" uuid NOT NULL,
    "KeycloakId" character varying(255) NOT NULL,
    "Email" character varying(255) NOT NULL,
    "MonthlySalary" numeric(18,2) DEFAULT 0 NOT NULL,
    "ReservedAmount" numeric(18,2) DEFAULT 0 NOT NULL,
    "CreatedAt" timestamp with time zone DEFAULT now() NOT NULL,
    "UpdatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Data for Name: Expenses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Expenses" ("Id", "UserId", "Description", "Amount", "Category", "DueDate", "IsPaid", "PaidAt", "CreatedAt", "UpdatedAt") FROM stdin;
d73a0cc7-e3a5-42af-bfa3-e1cee44cd4f5	adf454a8-9092-41f3-a733-65d6f55a4cc6	Aluguel	2600.00	Moradia	2026-06-03 00:00:00+00	f	\N	2026-05-23 08:16:57.194818+00	2026-05-23 08:16:57.194822+00
53e89661-b6c7-49a9-9030-5bbffebc6c77	adf454a8-9092-41f3-a733-65d6f55a4cc6	cartão de credito santander	580.00	Lazer	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:18:23.673195+00	2026-05-23 08:18:23.673195+00
f79c313c-08c4-4f4e-acbb-10a2cee9453b	adf454a8-9092-41f3-a733-65d6f55a4cc6	cartão de credito banco pan	1200.00	Lazer	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:18:58.795238+00	2026-05-23 08:18:58.795238+00
78e36faf-5292-4914-a709-e7ba83e727a2	adf454a8-9092-41f3-a733-65d6f55a4cc6	cartão de credito nubank usei da minha irmã	1677.00	Lazer	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:20:47.920891+00	2026-05-23 08:20:47.920892+00
27ff6bcb-10b2-4994-878d-73bd5489c3a1	adf454a8-9092-41f3-a733-65d6f55a4cc6	Contas que usei no cartão do meu pai	1475.00	Contas	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:27:59.75269+00	2026-05-23 08:27:59.75269+00
779f710f-ab95-4164-9348-95d575154d56	adf454a8-9092-41f3-a733-65d6f55a4cc6	Parcela da Moto	1230.00	Contas	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:30:14.217082+00	2026-05-23 08:30:14.217083+00
fc3e1a84-7c13-46ec-8d50-2e7f20f6fe4d	adf454a8-9092-41f3-a733-65d6f55a4cc6	Curso de inglês	669.00	Educação	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:36:01.531036+00	2026-05-23 08:36:01.531036+00
97569824-c920-4543-aae4-5fccdaf9d077	adf454a8-9092-41f3-a733-65d6f55a4cc6	meu cartão de credito ITAU	491.00	Lazer	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:47:10.924353+00	2026-05-23 08:47:10.924353+00
bbdd752d-9450-4a8d-b8cc-c53f7ab34c19	adf454a8-9092-41f3-a733-65d6f55a4cc6	Contadora 	260.00	Contas	2026-06-01 00:00:00+00	f	\N	2026-05-23 08:49:10.491533+00	2026-05-23 08:49:10.491533+00
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Users" ("Id", "KeycloakId", "Email", "MonthlySalary", "ReservedAmount", "CreatedAt", "UpdatedAt") FROM stdin;
adf454a8-9092-41f3-a733-65d6f55a4cc6	a8506192-c274-449a-b7dc-a5d7964d81cb	admin	15000.00	7000.00	2026-05-23 08:15:24.753475+00	2026-05-23 08:15:24.75348+00
\.


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
74d54e3e-da4d-4b71-93bb-afb03fff0acc	\N	auth-cookie	f3ec96da-52ff-4e0c-97c3-b10293c3178a	bed257a7-cdce-4d79-a563-0373b98b6f90	2	10	f	\N	\N
73276a51-7272-4650-96b2-0d988c9c80da	\N	auth-spnego	f3ec96da-52ff-4e0c-97c3-b10293c3178a	bed257a7-cdce-4d79-a563-0373b98b6f90	3	20	f	\N	\N
16c7b01e-37d6-43e5-986b-94be8876d911	\N	identity-provider-redirector	f3ec96da-52ff-4e0c-97c3-b10293c3178a	bed257a7-cdce-4d79-a563-0373b98b6f90	2	25	f	\N	\N
f82b96a8-0a64-42b9-bb13-76d552dd4e7c	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	bed257a7-cdce-4d79-a563-0373b98b6f90	2	30	t	49f29c56-aea0-4d57-b63c-f0ff1fda39e4	\N
6ee46d55-33cc-41b4-8bd4-a340025ef012	\N	auth-username-password-form	f3ec96da-52ff-4e0c-97c3-b10293c3178a	49f29c56-aea0-4d57-b63c-f0ff1fda39e4	0	10	f	\N	\N
35d3783c-29b1-4df7-a656-a8b19f82343a	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	49f29c56-aea0-4d57-b63c-f0ff1fda39e4	1	20	t	bf305af2-d00e-4ebe-807b-6c04a3813cd2	\N
2f30b876-9aea-4efe-9bad-a62980ef575d	\N	conditional-user-configured	f3ec96da-52ff-4e0c-97c3-b10293c3178a	bf305af2-d00e-4ebe-807b-6c04a3813cd2	0	10	f	\N	\N
148d58ba-368b-4ec2-9b24-f3ce14793ec8	\N	auth-otp-form	f3ec96da-52ff-4e0c-97c3-b10293c3178a	bf305af2-d00e-4ebe-807b-6c04a3813cd2	0	20	f	\N	\N
622b16e2-f675-49d8-a38f-e45b5dd9f5bf	\N	direct-grant-validate-username	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e98b5229-fb28-49e5-8881-377451281e0a	0	10	f	\N	\N
14be8d71-68f8-48b5-995f-1041cc5967de	\N	direct-grant-validate-password	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e98b5229-fb28-49e5-8881-377451281e0a	0	20	f	\N	\N
5e23acd3-d1fd-4013-a0ee-96fd4b3cea65	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e98b5229-fb28-49e5-8881-377451281e0a	1	30	t	f91f0f2b-2095-4f22-90f4-8e2db7b3beef	\N
43ce2299-b033-46e4-8606-1fc4df516b09	\N	conditional-user-configured	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f91f0f2b-2095-4f22-90f4-8e2db7b3beef	0	10	f	\N	\N
c67dd3a3-1baf-416a-bcf0-2b62608e2376	\N	direct-grant-validate-otp	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f91f0f2b-2095-4f22-90f4-8e2db7b3beef	0	20	f	\N	\N
35511b6e-f04d-4a7f-af08-3c48e0be8b27	\N	registration-page-form	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3bc9b61c-c75f-4697-81aa-a9e75b1f84d1	0	10	t	f4d0e9be-62d2-43c5-b83f-e0044def4a5b	\N
971d3b6a-2e8b-422f-b88e-a9193f2a2efc	\N	registration-user-creation	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f4d0e9be-62d2-43c5-b83f-e0044def4a5b	0	20	f	\N	\N
a6e82991-7ed6-40c0-866f-39ae38f11a9d	\N	registration-password-action	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f4d0e9be-62d2-43c5-b83f-e0044def4a5b	0	50	f	\N	\N
1f2c3d35-4cf8-4519-9e30-a082f709fc30	\N	registration-recaptcha-action	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f4d0e9be-62d2-43c5-b83f-e0044def4a5b	3	60	f	\N	\N
c29a505c-acb8-40e5-8362-c4421386cef2	\N	registration-terms-and-conditions	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f4d0e9be-62d2-43c5-b83f-e0044def4a5b	3	70	f	\N	\N
3ca94db5-2888-4210-a350-8122837a2f44	\N	reset-credentials-choose-user	f3ec96da-52ff-4e0c-97c3-b10293c3178a	d284799a-9967-406b-8b4d-4e12be31672e	0	10	f	\N	\N
dde5cb4d-4d7d-42e0-a2fc-954058ff8b41	\N	reset-credential-email	f3ec96da-52ff-4e0c-97c3-b10293c3178a	d284799a-9967-406b-8b4d-4e12be31672e	0	20	f	\N	\N
bb2052c7-b491-4968-b5be-7a0ceb46b14a	\N	reset-password	f3ec96da-52ff-4e0c-97c3-b10293c3178a	d284799a-9967-406b-8b4d-4e12be31672e	0	30	f	\N	\N
89acd6c1-e926-442a-a27f-f3b7a58730dd	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	d284799a-9967-406b-8b4d-4e12be31672e	1	40	t	08f363bc-08be-4159-8651-b884742171b9	\N
3aee6e1d-1d6c-453c-811c-a8c973ec68a6	\N	conditional-user-configured	f3ec96da-52ff-4e0c-97c3-b10293c3178a	08f363bc-08be-4159-8651-b884742171b9	0	10	f	\N	\N
cc4a8c76-6213-4c60-b856-09e9d6d19b56	\N	reset-otp	f3ec96da-52ff-4e0c-97c3-b10293c3178a	08f363bc-08be-4159-8651-b884742171b9	0	20	f	\N	\N
c1e5036e-8cd1-4219-8255-d99bf69ea3f8	\N	client-secret	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f68b9f26-a31b-41cc-a0c7-a93115863f46	2	10	f	\N	\N
99da5b8a-1e79-460f-b084-eeac38e97eae	\N	client-jwt	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f68b9f26-a31b-41cc-a0c7-a93115863f46	2	20	f	\N	\N
32bacabb-51ba-4771-a890-65ceeffea9ac	\N	client-secret-jwt	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f68b9f26-a31b-41cc-a0c7-a93115863f46	2	30	f	\N	\N
5fa26111-2b99-43b0-ba09-87d864ecff37	\N	client-x509	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f68b9f26-a31b-41cc-a0c7-a93115863f46	2	40	f	\N	\N
551693b7-a1a4-4493-b249-b9762ee69e07	\N	idp-review-profile	f3ec96da-52ff-4e0c-97c3-b10293c3178a	65107760-e3da-4db0-872d-d535bef34e81	0	10	f	\N	d1397468-cb3a-407b-baa8-6ad12cdd0efa
56c02a3d-18a1-4888-ae0a-f6c0ddd15a9f	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	65107760-e3da-4db0-872d-d535bef34e81	0	20	t	0ce680fd-b123-4b9e-be6d-706bce19af8b	\N
d2235667-a6bd-40ff-b7a6-f16fe75542c4	\N	idp-create-user-if-unique	f3ec96da-52ff-4e0c-97c3-b10293c3178a	0ce680fd-b123-4b9e-be6d-706bce19af8b	2	10	f	\N	bc1bb414-8292-4731-a5d0-41431bfdcb18
a4bf546c-880e-4123-9e96-389c6b629581	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	0ce680fd-b123-4b9e-be6d-706bce19af8b	2	20	t	1756879f-9002-4036-8c19-11a8ffa63b48	\N
cdbbc66b-60dd-44b7-be9a-a0d954f79627	\N	idp-confirm-link	f3ec96da-52ff-4e0c-97c3-b10293c3178a	1756879f-9002-4036-8c19-11a8ffa63b48	0	10	f	\N	\N
2b1def6d-4f99-4155-9106-a79b99d3624a	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	1756879f-9002-4036-8c19-11a8ffa63b48	0	20	t	8d00a902-6f6b-4b62-85a6-c1e813d0a98d	\N
94a0aa62-88a2-4ae0-8676-09703c093fb7	\N	idp-email-verification	f3ec96da-52ff-4e0c-97c3-b10293c3178a	8d00a902-6f6b-4b62-85a6-c1e813d0a98d	2	10	f	\N	\N
a3d369b4-ac89-4a23-8757-3518989b4e41	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	8d00a902-6f6b-4b62-85a6-c1e813d0a98d	2	20	t	02dd8305-1f41-4598-8d6c-28032151bc6e	\N
4b26f7d8-f1cb-43b0-a83b-e2dcdc4598c8	\N	idp-username-password-form	f3ec96da-52ff-4e0c-97c3-b10293c3178a	02dd8305-1f41-4598-8d6c-28032151bc6e	0	10	f	\N	\N
d3d453ec-f103-455a-8161-39ed465b1b81	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	02dd8305-1f41-4598-8d6c-28032151bc6e	1	20	t	4146f3ec-f199-405f-b9fe-91a2a2b40618	\N
70fe4d74-c352-4975-abbc-f3829051ec66	\N	conditional-user-configured	f3ec96da-52ff-4e0c-97c3-b10293c3178a	4146f3ec-f199-405f-b9fe-91a2a2b40618	0	10	f	\N	\N
3cdd3f46-f4f7-44cd-9515-4200255afe47	\N	auth-otp-form	f3ec96da-52ff-4e0c-97c3-b10293c3178a	4146f3ec-f199-405f-b9fe-91a2a2b40618	0	20	f	\N	\N
571b1e4f-735d-43be-9f6b-e2901d7c08cc	\N	http-basic-authenticator	f3ec96da-52ff-4e0c-97c3-b10293c3178a	8dcc8531-65cf-406e-8613-10f26c1bc8c5	0	10	f	\N	\N
5e5d87b5-7227-441b-b8c4-7da2ab25528b	\N	docker-http-basic-authenticator	f3ec96da-52ff-4e0c-97c3-b10293c3178a	c9d93933-0df6-468d-8aa8-011bd3b38193	0	10	f	\N	\N
b08ae60f-b2d8-45c4-b414-32660b62e4cd	\N	auth-cookie	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	971aa8b4-4db8-4234-8e5d-8ff6c7e608e3	2	10	f	\N	\N
7b76786c-83b0-48e1-bc4d-bf8d6a18a937	\N	auth-spnego	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	971aa8b4-4db8-4234-8e5d-8ff6c7e608e3	3	20	f	\N	\N
de16047a-9bf0-4d7b-b508-5a69fe241c72	\N	identity-provider-redirector	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	971aa8b4-4db8-4234-8e5d-8ff6c7e608e3	2	25	f	\N	\N
cfec2813-283e-4df8-b7ae-e79e50899b7d	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	971aa8b4-4db8-4234-8e5d-8ff6c7e608e3	2	30	t	f47129c7-fee0-43ad-8b15-f5d98c28e1df	\N
fc898102-d4f8-4aaf-bf37-745952c8df4a	\N	auth-username-password-form	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f47129c7-fee0-43ad-8b15-f5d98c28e1df	0	10	f	\N	\N
fb87d45b-ad04-477a-a969-ec840de4ac91	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f47129c7-fee0-43ad-8b15-f5d98c28e1df	1	20	t	edc82ef0-cc82-436c-90d8-e68255e38f40	\N
3e53e048-9150-4e05-b181-9089e03bf8c1	\N	conditional-user-configured	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	edc82ef0-cc82-436c-90d8-e68255e38f40	0	10	f	\N	\N
9c6e788f-3d07-426e-b236-37bf459aefc1	\N	auth-otp-form	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	edc82ef0-cc82-436c-90d8-e68255e38f40	0	20	f	\N	\N
c368b95d-f1bb-4de8-ba00-adf1a1a5ba9d	\N	direct-grant-validate-username	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	291f1132-ee3b-4909-a654-10add63e45e4	0	10	f	\N	\N
eaf2da18-fd59-4110-9b5e-6990e4e3b66a	\N	direct-grant-validate-password	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	291f1132-ee3b-4909-a654-10add63e45e4	0	20	f	\N	\N
dee762d8-36ac-435c-9faa-dcf2ee3baeac	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	291f1132-ee3b-4909-a654-10add63e45e4	1	30	t	4d28a8c8-d7a6-4ee1-b3e9-413ea2ff88bc	\N
72e5dc7f-a1e0-450a-a698-73160052a442	\N	conditional-user-configured	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	4d28a8c8-d7a6-4ee1-b3e9-413ea2ff88bc	0	10	f	\N	\N
b48d81be-b62b-42d8-867f-dbcb88910607	\N	direct-grant-validate-otp	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	4d28a8c8-d7a6-4ee1-b3e9-413ea2ff88bc	0	20	f	\N	\N
e7c7de34-d1ff-43fd-810d-2c852fe586ba	\N	registration-page-form	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	46146890-653a-4851-9c0e-7136ce92bfa8	0	10	t	9054b931-cbc2-4b29-9f00-384501d1c0ca	\N
79588a35-2af6-44dd-895a-f28640b2c6ee	\N	registration-user-creation	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9054b931-cbc2-4b29-9f00-384501d1c0ca	0	20	f	\N	\N
0bd068fb-fc35-4c9c-9a68-855119b5deb7	\N	registration-password-action	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9054b931-cbc2-4b29-9f00-384501d1c0ca	0	50	f	\N	\N
350ffb09-f81c-4a49-83be-031bbd2defa5	\N	registration-recaptcha-action	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9054b931-cbc2-4b29-9f00-384501d1c0ca	3	60	f	\N	\N
f8b003b8-9284-4b02-96dc-25698614f0c2	\N	reset-credentials-choose-user	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	b44dcb42-c843-494e-8221-7885f67cee6d	0	10	f	\N	\N
d74ccb2f-a4d2-4452-ac8c-27e78569a4a6	\N	reset-credential-email	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	b44dcb42-c843-494e-8221-7885f67cee6d	0	20	f	\N	\N
7c15cbb4-9954-4a8c-b5c5-0c79a4ade200	\N	reset-password	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	b44dcb42-c843-494e-8221-7885f67cee6d	0	30	f	\N	\N
ba67e727-0f7e-4fdf-9d97-701e196fca0f	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	b44dcb42-c843-494e-8221-7885f67cee6d	1	40	t	9cecbe54-9077-4675-ab06-9b30fb6cbc80	\N
5aa5c826-8f0e-4225-8b82-4aa5c3f99972	\N	conditional-user-configured	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cecbe54-9077-4675-ab06-9b30fb6cbc80	0	10	f	\N	\N
6c18f620-6554-4868-b805-6ef807f4cf49	\N	reset-otp	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cecbe54-9077-4675-ab06-9b30fb6cbc80	0	20	f	\N	\N
f0698a72-c8f3-41b6-b5bc-a3e61fb4e512	\N	client-secret	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	1359f6d4-0faf-413e-955e-697082781878	2	10	f	\N	\N
521c229d-a2e3-4375-a1fb-01fe6296a058	\N	client-jwt	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	1359f6d4-0faf-413e-955e-697082781878	2	20	f	\N	\N
0ec93d17-65e5-4b4b-be2c-34f3e0943aee	\N	client-secret-jwt	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	1359f6d4-0faf-413e-955e-697082781878	2	30	f	\N	\N
6e33c669-afd8-4d23-a196-0da0b43906c8	\N	client-x509	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	1359f6d4-0faf-413e-955e-697082781878	2	40	f	\N	\N
3839d362-762f-4e10-a339-84dbd1332af4	\N	idp-review-profile	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	48dbd1f3-b14c-4c27-bbec-c4eeb43cb466	0	10	f	\N	cc94ffc7-b945-4512-9468-13659d372b43
63bba5d7-093f-4bc7-8cb9-2394d7a4dffb	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	48dbd1f3-b14c-4c27-bbec-c4eeb43cb466	0	20	t	9a98d34e-da1d-4e43-98d7-f4449b638890	\N
2bfe38cd-770a-45ae-8f92-0e881708bb30	\N	idp-create-user-if-unique	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9a98d34e-da1d-4e43-98d7-f4449b638890	2	10	f	\N	aafe3dd3-ef28-49d1-b0f4-f4839b54703f
ef977706-f82d-4137-b3ca-fd4bded95421	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9a98d34e-da1d-4e43-98d7-f4449b638890	2	20	t	0b16ebad-ec9d-4f00-a97d-d9b80608df3e	\N
4c8f6e77-b997-45d0-9dbd-06ad7a051917	\N	idp-confirm-link	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0b16ebad-ec9d-4f00-a97d-d9b80608df3e	0	10	f	\N	\N
74dbf816-4b83-41fe-99ca-5961c5a097ef	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0b16ebad-ec9d-4f00-a97d-d9b80608df3e	0	20	t	8283f8e1-38a6-43c5-b539-cdb46aea3adb	\N
25fd53fc-f5ab-4fc4-aec2-1f515f634131	\N	idp-email-verification	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	8283f8e1-38a6-43c5-b539-cdb46aea3adb	2	10	f	\N	\N
19b8d325-13ce-4b91-b138-2ed5f83d0961	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	8283f8e1-38a6-43c5-b539-cdb46aea3adb	2	20	t	0c0a5af8-a3bd-4115-9360-1989cb2e00f9	\N
0fc3c0d0-0b3e-42c2-94b0-58ad17133d7c	\N	idp-username-password-form	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0c0a5af8-a3bd-4115-9360-1989cb2e00f9	0	10	f	\N	\N
af159e5e-03f6-4386-8741-383f7448ba47	\N	\N	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0c0a5af8-a3bd-4115-9360-1989cb2e00f9	1	20	t	b3c83441-9e68-4899-8127-1906c5aa8d42	\N
d18cf4b8-4d0f-4667-89ea-5aea9ca1ab05	\N	conditional-user-configured	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	b3c83441-9e68-4899-8127-1906c5aa8d42	0	10	f	\N	\N
4d7a6158-87f9-47d5-a4b8-28274b6cc7b2	\N	auth-otp-form	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	b3c83441-9e68-4899-8127-1906c5aa8d42	0	20	f	\N	\N
49ba6d9f-9d7a-45bd-a394-38c7ad4dda27	\N	http-basic-authenticator	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	97a4efb0-cc40-47ac-abcb-4a8754b1352f	0	10	f	\N	\N
bb7cade5-2aab-4cd0-aa93-e7e594cfc26a	\N	docker-http-basic-authenticator	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	48884360-926c-44f7-ad35-e2520efdc8b5	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
bed257a7-cdce-4d79-a563-0373b98b6f90	browser	browser based authentication	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
49f29c56-aea0-4d57-b63c-f0ff1fda39e4	forms	Username, password, otp and other auth forms.	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
bf305af2-d00e-4ebe-807b-6c04a3813cd2	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
e98b5229-fb28-49e5-8881-377451281e0a	direct grant	OpenID Connect Resource Owner Grant	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
f91f0f2b-2095-4f22-90f4-8e2db7b3beef	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
3bc9b61c-c75f-4697-81aa-a9e75b1f84d1	registration	registration flow	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
f4d0e9be-62d2-43c5-b83f-e0044def4a5b	registration form	registration form	f3ec96da-52ff-4e0c-97c3-b10293c3178a	form-flow	f	t
d284799a-9967-406b-8b4d-4e12be31672e	reset credentials	Reset credentials for a user if they forgot their password or something	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
08f363bc-08be-4159-8651-b884742171b9	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
f68b9f26-a31b-41cc-a0c7-a93115863f46	clients	Base authentication for clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	client-flow	t	t
65107760-e3da-4db0-872d-d535bef34e81	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
0ce680fd-b123-4b9e-be6d-706bce19af8b	User creation or linking	Flow for the existing/non-existing user alternatives	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
1756879f-9002-4036-8c19-11a8ffa63b48	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
8d00a902-6f6b-4b62-85a6-c1e813d0a98d	Account verification options	Method with which to verity the existing account	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
02dd8305-1f41-4598-8d6c-28032151bc6e	Verify Existing Account by Re-authentication	Reauthentication of existing account	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
4146f3ec-f199-405f-b9fe-91a2a2b40618	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	f	t
8dcc8531-65cf-406e-8613-10f26c1bc8c5	saml ecp	SAML ECP Profile Authentication Flow	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
c9d93933-0df6-468d-8aa8-011bd3b38193	docker auth	Used by Docker clients to authenticate against the IDP	f3ec96da-52ff-4e0c-97c3-b10293c3178a	basic-flow	t	t
971aa8b4-4db8-4234-8e5d-8ff6c7e608e3	browser	browser based authentication	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
f47129c7-fee0-43ad-8b15-f5d98c28e1df	forms	Username, password, otp and other auth forms.	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
edc82ef0-cc82-436c-90d8-e68255e38f40	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
291f1132-ee3b-4909-a654-10add63e45e4	direct grant	OpenID Connect Resource Owner Grant	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
4d28a8c8-d7a6-4ee1-b3e9-413ea2ff88bc	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
46146890-653a-4851-9c0e-7136ce92bfa8	registration	registration flow	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
9054b931-cbc2-4b29-9f00-384501d1c0ca	registration form	registration form	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	form-flow	f	t
b44dcb42-c843-494e-8221-7885f67cee6d	reset credentials	Reset credentials for a user if they forgot their password or something	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
9cecbe54-9077-4675-ab06-9b30fb6cbc80	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
1359f6d4-0faf-413e-955e-697082781878	clients	Base authentication for clients	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	client-flow	t	t
48dbd1f3-b14c-4c27-bbec-c4eeb43cb466	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
9a98d34e-da1d-4e43-98d7-f4449b638890	User creation or linking	Flow for the existing/non-existing user alternatives	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
0b16ebad-ec9d-4f00-a97d-d9b80608df3e	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
8283f8e1-38a6-43c5-b539-cdb46aea3adb	Account verification options	Method with which to verity the existing account	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
0c0a5af8-a3bd-4115-9360-1989cb2e00f9	Verify Existing Account by Re-authentication	Reauthentication of existing account	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
b3c83441-9e68-4899-8127-1906c5aa8d42	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	f	t
97a4efb0-cc40-47ac-abcb-4a8754b1352f	saml ecp	SAML ECP Profile Authentication Flow	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
48884360-926c-44f7-ad35-e2520efdc8b5	docker auth	Used by Docker clients to authenticate against the IDP	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
d1397468-cb3a-407b-baa8-6ad12cdd0efa	review profile config	f3ec96da-52ff-4e0c-97c3-b10293c3178a
bc1bb414-8292-4731-a5d0-41431bfdcb18	create unique user config	f3ec96da-52ff-4e0c-97c3-b10293c3178a
cc94ffc7-b945-4512-9468-13659d372b43	review profile config	6cc40e8a-5d10-47ac-ae6d-17dd0f179374
aafe3dd3-ef28-49d1-b0f4-f4839b54703f	create unique user config	6cc40e8a-5d10-47ac-ae6d-17dd0f179374
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
bc1bb414-8292-4731-a5d0-41431bfdcb18	false	require.password.update.after.registration
d1397468-cb3a-407b-baa8-6ad12cdd0efa	missing	update.profile.on.first.login
aafe3dd3-ef28-49d1-b0f4-f4839b54703f	false	require.password.update.after.registration
cc94ffc7-b945-4512-9468-13659d372b43	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	f	master-realm	0	f	\N	\N	t	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ea0eeca3-09be-401e-96f5-de1afe33a003	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
602dc3c7-c130-4c35-8403-b3a2b53a70ee	t	f	broker	0	f	\N	\N	t	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
05fe4b80-4863-4f01-9e25-57230393a8de	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	t	f	admin-cli	0	t	\N	\N	f	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	f	expense-realm-realm	0	f	\N	\N	t	\N	f	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	0	f	f	expense-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	f	realm-management	0	f	\N	\N	t	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
3f75d006-a362-47c3-b3a9-662b7e19cf93	t	f	account	0	t	\N	/realms/expense-realm/account/	f	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	t	f	account-console	0	t	\N	/realms/expense-realm/account/	f	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
933099e8-7248-4f1d-bb1a-78052692eeb5	t	f	broker	0	f	\N	\N	t	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	t	f	security-admin-console	0	t	\N	/admin/expense-realm/console/	f	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
bc09051d-aa1e-47a1-8e87-d1857a93ab51	t	f	admin-cli	0	t	\N	\N	f	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
11165979-5557-433b-80fd-57eb95e7bbdc	t	t	expense-api	0	f	\N	\N	t	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	f	f	f	f
a4626817-1f5a-4f68-89cf-002d648111d2	t	t	expense-frontend	0	t	\N	\N	f	\N	f	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
e5f26731-8a53-47d8-b3b0-a4652e7901bd	post.logout.redirect.uris	+
ea0eeca3-09be-401e-96f5-de1afe33a003	post.logout.redirect.uris	+
ea0eeca3-09be-401e-96f5-de1afe33a003	pkce.code.challenge.method	S256
05fe4b80-4863-4f01-9e25-57230393a8de	post.logout.redirect.uris	+
05fe4b80-4863-4f01-9e25-57230393a8de	pkce.code.challenge.method	S256
3f75d006-a362-47c3-b3a9-662b7e19cf93	post.logout.redirect.uris	+
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	post.logout.redirect.uris	+
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	pkce.code.challenge.method	S256
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	post.logout.redirect.uris	+
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	pkce.code.challenge.method	S256
11165979-5557-433b-80fd-57eb95e7bbdc	post.logout.redirect.uris	+
a4626817-1f5a-4f68-89cf-002d648111d2	pkce.code.challenge.method	S256
a4626817-1f5a-4f68-89cf-002d648111d2	post.logout.redirect.uris	+
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
26e6767f-720c-4ce7-8c16-adb2a7c2362e	offline_access	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect built-in scope: offline_access	openid-connect
1cd05e28-baf2-44e1-af37-61539cf0e8a3	role_list	f3ec96da-52ff-4e0c-97c3-b10293c3178a	SAML role list	saml
6c9240ed-a1fa-4e86-9190-694c9b6f94a9	profile	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect built-in scope: profile	openid-connect
63bb8ee4-7f67-41cd-b5af-d3565a6da605	email	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect built-in scope: email	openid-connect
50613a4d-535e-49a0-83a4-94fb9b801e03	address	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect built-in scope: address	openid-connect
6fde5651-0692-4f64-b2aa-f7792f8d2ef1	phone	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect built-in scope: phone	openid-connect
b408f146-b3d0-4231-b5fb-f826c0a42b2d	roles	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect scope for add user roles to the access token	openid-connect
394cd6d5-6ec7-4372-80e0-f5df04aa76c0	web-origins	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect scope for add allowed web origins to the access token	openid-connect
7523ee8d-3c82-4c61-a10e-eda9f857f0e3	microprofile-jwt	f3ec96da-52ff-4e0c-97c3-b10293c3178a	Microprofile - JWT built-in scope	openid-connect
5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	acr	f3ec96da-52ff-4e0c-97c3-b10293c3178a	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
d038e890-3104-4898-ae6c-f2b11a69ddf2	offline_access	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect built-in scope: offline_access	openid-connect
875e0703-bce3-44a4-a380-3a80e896aa60	role_list	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	SAML role list	saml
46df6e14-4222-4fed-a8e2-b8f6b41e195f	profile	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect built-in scope: profile	openid-connect
e4c2c46b-57ad-4065-95e6-a105606ec84c	email	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect built-in scope: email	openid-connect
c11dc7c2-8afc-436e-ac13-35f73094ee86	address	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect built-in scope: address	openid-connect
28b1b129-1a5e-4bc9-a249-b841ac834087	phone	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect built-in scope: phone	openid-connect
2cb4fba9-6d85-45b5-98a2-4805d6110ca9	roles	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect scope for add user roles to the access token	openid-connect
4770de6d-fc03-4e56-b313-f5bbdc6a4612	web-origins	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect scope for add allowed web origins to the access token	openid-connect
0c335934-736c-4153-99ea-c3899f3462e3	microprofile-jwt	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	Microprofile - JWT built-in scope	openid-connect
8c786c51-3c0c-4e40-8284-2e941a8da6fe	acr	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
26e6767f-720c-4ce7-8c16-adb2a7c2362e	true	display.on.consent.screen
26e6767f-720c-4ce7-8c16-adb2a7c2362e	${offlineAccessScopeConsentText}	consent.screen.text
1cd05e28-baf2-44e1-af37-61539cf0e8a3	true	display.on.consent.screen
1cd05e28-baf2-44e1-af37-61539cf0e8a3	${samlRoleListScopeConsentText}	consent.screen.text
6c9240ed-a1fa-4e86-9190-694c9b6f94a9	true	display.on.consent.screen
6c9240ed-a1fa-4e86-9190-694c9b6f94a9	${profileScopeConsentText}	consent.screen.text
6c9240ed-a1fa-4e86-9190-694c9b6f94a9	true	include.in.token.scope
63bb8ee4-7f67-41cd-b5af-d3565a6da605	true	display.on.consent.screen
63bb8ee4-7f67-41cd-b5af-d3565a6da605	${emailScopeConsentText}	consent.screen.text
63bb8ee4-7f67-41cd-b5af-d3565a6da605	true	include.in.token.scope
50613a4d-535e-49a0-83a4-94fb9b801e03	true	display.on.consent.screen
50613a4d-535e-49a0-83a4-94fb9b801e03	${addressScopeConsentText}	consent.screen.text
50613a4d-535e-49a0-83a4-94fb9b801e03	true	include.in.token.scope
6fde5651-0692-4f64-b2aa-f7792f8d2ef1	true	display.on.consent.screen
6fde5651-0692-4f64-b2aa-f7792f8d2ef1	${phoneScopeConsentText}	consent.screen.text
6fde5651-0692-4f64-b2aa-f7792f8d2ef1	true	include.in.token.scope
b408f146-b3d0-4231-b5fb-f826c0a42b2d	true	display.on.consent.screen
b408f146-b3d0-4231-b5fb-f826c0a42b2d	${rolesScopeConsentText}	consent.screen.text
b408f146-b3d0-4231-b5fb-f826c0a42b2d	false	include.in.token.scope
394cd6d5-6ec7-4372-80e0-f5df04aa76c0	false	display.on.consent.screen
394cd6d5-6ec7-4372-80e0-f5df04aa76c0		consent.screen.text
394cd6d5-6ec7-4372-80e0-f5df04aa76c0	false	include.in.token.scope
7523ee8d-3c82-4c61-a10e-eda9f857f0e3	false	display.on.consent.screen
7523ee8d-3c82-4c61-a10e-eda9f857f0e3	true	include.in.token.scope
5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	false	display.on.consent.screen
5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	false	include.in.token.scope
d038e890-3104-4898-ae6c-f2b11a69ddf2	true	display.on.consent.screen
d038e890-3104-4898-ae6c-f2b11a69ddf2	${offlineAccessScopeConsentText}	consent.screen.text
875e0703-bce3-44a4-a380-3a80e896aa60	true	display.on.consent.screen
875e0703-bce3-44a4-a380-3a80e896aa60	${samlRoleListScopeConsentText}	consent.screen.text
46df6e14-4222-4fed-a8e2-b8f6b41e195f	true	display.on.consent.screen
46df6e14-4222-4fed-a8e2-b8f6b41e195f	${profileScopeConsentText}	consent.screen.text
46df6e14-4222-4fed-a8e2-b8f6b41e195f	true	include.in.token.scope
e4c2c46b-57ad-4065-95e6-a105606ec84c	true	display.on.consent.screen
e4c2c46b-57ad-4065-95e6-a105606ec84c	${emailScopeConsentText}	consent.screen.text
e4c2c46b-57ad-4065-95e6-a105606ec84c	true	include.in.token.scope
c11dc7c2-8afc-436e-ac13-35f73094ee86	true	display.on.consent.screen
c11dc7c2-8afc-436e-ac13-35f73094ee86	${addressScopeConsentText}	consent.screen.text
c11dc7c2-8afc-436e-ac13-35f73094ee86	true	include.in.token.scope
28b1b129-1a5e-4bc9-a249-b841ac834087	true	display.on.consent.screen
28b1b129-1a5e-4bc9-a249-b841ac834087	${phoneScopeConsentText}	consent.screen.text
28b1b129-1a5e-4bc9-a249-b841ac834087	true	include.in.token.scope
2cb4fba9-6d85-45b5-98a2-4805d6110ca9	true	display.on.consent.screen
2cb4fba9-6d85-45b5-98a2-4805d6110ca9	${rolesScopeConsentText}	consent.screen.text
2cb4fba9-6d85-45b5-98a2-4805d6110ca9	false	include.in.token.scope
4770de6d-fc03-4e56-b313-f5bbdc6a4612	false	display.on.consent.screen
4770de6d-fc03-4e56-b313-f5bbdc6a4612		consent.screen.text
4770de6d-fc03-4e56-b313-f5bbdc6a4612	false	include.in.token.scope
0c335934-736c-4153-99ea-c3899f3462e3	false	display.on.consent.screen
0c335934-736c-4153-99ea-c3899f3462e3	true	include.in.token.scope
8c786c51-3c0c-4e40-8284-2e941a8da6fe	false	display.on.consent.screen
8c786c51-3c0c-4e40-8284-2e941a8da6fe	false	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
e5f26731-8a53-47d8-b3b0-a4652e7901bd	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
e5f26731-8a53-47d8-b3b0-a4652e7901bd	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
e5f26731-8a53-47d8-b3b0-a4652e7901bd	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
e5f26731-8a53-47d8-b3b0-a4652e7901bd	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
e5f26731-8a53-47d8-b3b0-a4652e7901bd	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
e5f26731-8a53-47d8-b3b0-a4652e7901bd	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
e5f26731-8a53-47d8-b3b0-a4652e7901bd	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
e5f26731-8a53-47d8-b3b0-a4652e7901bd	50613a4d-535e-49a0-83a4-94fb9b801e03	f
e5f26731-8a53-47d8-b3b0-a4652e7901bd	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
ea0eeca3-09be-401e-96f5-de1afe33a003	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
ea0eeca3-09be-401e-96f5-de1afe33a003	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
ea0eeca3-09be-401e-96f5-de1afe33a003	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
ea0eeca3-09be-401e-96f5-de1afe33a003	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
ea0eeca3-09be-401e-96f5-de1afe33a003	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
ea0eeca3-09be-401e-96f5-de1afe33a003	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
ea0eeca3-09be-401e-96f5-de1afe33a003	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
ea0eeca3-09be-401e-96f5-de1afe33a003	50613a4d-535e-49a0-83a4-94fb9b801e03	f
ea0eeca3-09be-401e-96f5-de1afe33a003	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	50613a4d-535e-49a0-83a4-94fb9b801e03	f
9b6ff566-9abc-4f14-aa1f-3107fbb5f39f	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
602dc3c7-c130-4c35-8403-b3a2b53a70ee	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
602dc3c7-c130-4c35-8403-b3a2b53a70ee	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
602dc3c7-c130-4c35-8403-b3a2b53a70ee	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
602dc3c7-c130-4c35-8403-b3a2b53a70ee	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
602dc3c7-c130-4c35-8403-b3a2b53a70ee	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
602dc3c7-c130-4c35-8403-b3a2b53a70ee	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
602dc3c7-c130-4c35-8403-b3a2b53a70ee	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
602dc3c7-c130-4c35-8403-b3a2b53a70ee	50613a4d-535e-49a0-83a4-94fb9b801e03	f
602dc3c7-c130-4c35-8403-b3a2b53a70ee	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
a37426d1-c5b6-46ad-9e14-166ceb67dd49	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
a37426d1-c5b6-46ad-9e14-166ceb67dd49	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
a37426d1-c5b6-46ad-9e14-166ceb67dd49	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
a37426d1-c5b6-46ad-9e14-166ceb67dd49	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
a37426d1-c5b6-46ad-9e14-166ceb67dd49	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
a37426d1-c5b6-46ad-9e14-166ceb67dd49	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
a37426d1-c5b6-46ad-9e14-166ceb67dd49	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
a37426d1-c5b6-46ad-9e14-166ceb67dd49	50613a4d-535e-49a0-83a4-94fb9b801e03	f
a37426d1-c5b6-46ad-9e14-166ceb67dd49	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
05fe4b80-4863-4f01-9e25-57230393a8de	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
05fe4b80-4863-4f01-9e25-57230393a8de	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
05fe4b80-4863-4f01-9e25-57230393a8de	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
05fe4b80-4863-4f01-9e25-57230393a8de	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
05fe4b80-4863-4f01-9e25-57230393a8de	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
05fe4b80-4863-4f01-9e25-57230393a8de	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
05fe4b80-4863-4f01-9e25-57230393a8de	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
05fe4b80-4863-4f01-9e25-57230393a8de	50613a4d-535e-49a0-83a4-94fb9b801e03	f
05fe4b80-4863-4f01-9e25-57230393a8de	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
3f75d006-a362-47c3-b3a9-662b7e19cf93	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
3f75d006-a362-47c3-b3a9-662b7e19cf93	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
3f75d006-a362-47c3-b3a9-662b7e19cf93	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
3f75d006-a362-47c3-b3a9-662b7e19cf93	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
3f75d006-a362-47c3-b3a9-662b7e19cf93	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
3f75d006-a362-47c3-b3a9-662b7e19cf93	28b1b129-1a5e-4bc9-a249-b841ac834087	f
3f75d006-a362-47c3-b3a9-662b7e19cf93	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
3f75d006-a362-47c3-b3a9-662b7e19cf93	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
3f75d006-a362-47c3-b3a9-662b7e19cf93	0c335934-736c-4153-99ea-c3899f3462e3	f
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	28b1b129-1a5e-4bc9-a249-b841ac834087	f
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	0c335934-736c-4153-99ea-c3899f3462e3	f
bc09051d-aa1e-47a1-8e87-d1857a93ab51	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
bc09051d-aa1e-47a1-8e87-d1857a93ab51	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
bc09051d-aa1e-47a1-8e87-d1857a93ab51	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
bc09051d-aa1e-47a1-8e87-d1857a93ab51	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
bc09051d-aa1e-47a1-8e87-d1857a93ab51	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
bc09051d-aa1e-47a1-8e87-d1857a93ab51	28b1b129-1a5e-4bc9-a249-b841ac834087	f
bc09051d-aa1e-47a1-8e87-d1857a93ab51	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
bc09051d-aa1e-47a1-8e87-d1857a93ab51	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
bc09051d-aa1e-47a1-8e87-d1857a93ab51	0c335934-736c-4153-99ea-c3899f3462e3	f
933099e8-7248-4f1d-bb1a-78052692eeb5	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
933099e8-7248-4f1d-bb1a-78052692eeb5	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
933099e8-7248-4f1d-bb1a-78052692eeb5	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
933099e8-7248-4f1d-bb1a-78052692eeb5	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
933099e8-7248-4f1d-bb1a-78052692eeb5	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
933099e8-7248-4f1d-bb1a-78052692eeb5	28b1b129-1a5e-4bc9-a249-b841ac834087	f
933099e8-7248-4f1d-bb1a-78052692eeb5	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
933099e8-7248-4f1d-bb1a-78052692eeb5	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
933099e8-7248-4f1d-bb1a-78052692eeb5	0c335934-736c-4153-99ea-c3899f3462e3	f
9cd331b6-6b62-49e8-b15d-df355b54d5c1	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
9cd331b6-6b62-49e8-b15d-df355b54d5c1	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
9cd331b6-6b62-49e8-b15d-df355b54d5c1	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
9cd331b6-6b62-49e8-b15d-df355b54d5c1	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
9cd331b6-6b62-49e8-b15d-df355b54d5c1	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
9cd331b6-6b62-49e8-b15d-df355b54d5c1	28b1b129-1a5e-4bc9-a249-b841ac834087	f
9cd331b6-6b62-49e8-b15d-df355b54d5c1	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
9cd331b6-6b62-49e8-b15d-df355b54d5c1	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
9cd331b6-6b62-49e8-b15d-df355b54d5c1	0c335934-736c-4153-99ea-c3899f3462e3	f
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	28b1b129-1a5e-4bc9-a249-b841ac834087	f
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	0c335934-736c-4153-99ea-c3899f3462e3	f
11165979-5557-433b-80fd-57eb95e7bbdc	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
11165979-5557-433b-80fd-57eb95e7bbdc	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
11165979-5557-433b-80fd-57eb95e7bbdc	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
11165979-5557-433b-80fd-57eb95e7bbdc	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
11165979-5557-433b-80fd-57eb95e7bbdc	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
11165979-5557-433b-80fd-57eb95e7bbdc	28b1b129-1a5e-4bc9-a249-b841ac834087	f
11165979-5557-433b-80fd-57eb95e7bbdc	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
11165979-5557-433b-80fd-57eb95e7bbdc	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
11165979-5557-433b-80fd-57eb95e7bbdc	0c335934-736c-4153-99ea-c3899f3462e3	f
a4626817-1f5a-4f68-89cf-002d648111d2	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
a4626817-1f5a-4f68-89cf-002d648111d2	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
a4626817-1f5a-4f68-89cf-002d648111d2	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
a4626817-1f5a-4f68-89cf-002d648111d2	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
a4626817-1f5a-4f68-89cf-002d648111d2	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
a4626817-1f5a-4f68-89cf-002d648111d2	28b1b129-1a5e-4bc9-a249-b841ac834087	f
a4626817-1f5a-4f68-89cf-002d648111d2	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
a4626817-1f5a-4f68-89cf-002d648111d2	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
a4626817-1f5a-4f68-89cf-002d648111d2	0c335934-736c-4153-99ea-c3899f3462e3	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
26e6767f-720c-4ce7-8c16-adb2a7c2362e	2bd03c28-1662-4f73-9f71-6bea3aff6021
d038e890-3104-4898-ae6c-f2b11a69ddf2	0f903ef0-4fef-4b0a-afc8-dd5c05406384
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
e3160239-c886-40b7-a92c-c55485f20ec3	Trusted Hosts	f3ec96da-52ff-4e0c-97c3-b10293c3178a	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	anonymous
2dc0ce90-d4c7-446a-b45d-77600bd39f2a	Consent Required	f3ec96da-52ff-4e0c-97c3-b10293c3178a	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	anonymous
33ca1d8c-df03-4335-874e-8dd3ac94413b	Full Scope Disabled	f3ec96da-52ff-4e0c-97c3-b10293c3178a	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	anonymous
1d12d54c-5fd8-4657-9e83-12edd55de278	Max Clients Limit	f3ec96da-52ff-4e0c-97c3-b10293c3178a	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	anonymous
7b4f3ea8-7598-4084-a1a8-2410848d6820	Allowed Protocol Mapper Types	f3ec96da-52ff-4e0c-97c3-b10293c3178a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	anonymous
f0c50610-93bb-4d0f-a5c5-eed7db25823c	Allowed Client Scopes	f3ec96da-52ff-4e0c-97c3-b10293c3178a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	anonymous
66811d65-0501-4f7e-844a-05c10a815741	Allowed Protocol Mapper Types	f3ec96da-52ff-4e0c-97c3-b10293c3178a	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	authenticated
7f0c7345-16ef-4451-bf0c-ea854dbace79	Allowed Client Scopes	f3ec96da-52ff-4e0c-97c3-b10293c3178a	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	authenticated
2fe5e384-f91c-432f-bb3e-324baaf92f84	rsa-generated	f3ec96da-52ff-4e0c-97c3-b10293c3178a	rsa-generated	org.keycloak.keys.KeyProvider	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N
8d0b5ca8-373e-4855-8fbd-c67a23546612	rsa-enc-generated	f3ec96da-52ff-4e0c-97c3-b10293c3178a	rsa-enc-generated	org.keycloak.keys.KeyProvider	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N
cfc4aa85-d5f4-4c5e-88a9-faae1d0db94b	hmac-generated	f3ec96da-52ff-4e0c-97c3-b10293c3178a	hmac-generated	org.keycloak.keys.KeyProvider	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N
08087614-04d2-4f81-a0ba-1dc09d73db13	aes-generated	f3ec96da-52ff-4e0c-97c3-b10293c3178a	aes-generated	org.keycloak.keys.KeyProvider	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N
45dc8e4b-e30f-46f3-863a-d4384cd36db8	rsa-generated	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	rsa-generated	org.keycloak.keys.KeyProvider	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N
59d902c7-594a-4005-8857-925542274557	rsa-enc-generated	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	rsa-enc-generated	org.keycloak.keys.KeyProvider	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N
957d042a-3e53-4ed0-bde9-6d8f4cf18f36	hmac-generated	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	hmac-generated	org.keycloak.keys.KeyProvider	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N
7e86c254-f710-4501-bd0e-eda0ffd0fa97	aes-generated	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	aes-generated	org.keycloak.keys.KeyProvider	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N
d6206732-e3fb-40c4-ad74-c77de2fd782e	Trusted Hosts	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	anonymous
e5b4e18f-b655-4518-b9f2-24353498c5b9	Consent Required	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	anonymous
91a3b39f-a193-4d0f-9ceb-f28c58f81bd1	Full Scope Disabled	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	anonymous
e08bc0f1-5df6-4900-9251-49e847612b27	Max Clients Limit	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	anonymous
2a9122cf-8b94-454a-ae11-8240b3e49b77	Allowed Protocol Mapper Types	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	anonymous
014dcd57-f139-4939-9c27-37e7c473d93a	Allowed Client Scopes	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	anonymous
2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	Allowed Protocol Mapper Types	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	authenticated
1d7a6af7-bab6-4dc2-9d3a-ee4ebde2d408	Allowed Client Scopes	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
e310ab9b-5078-40a2-9cca-8a391814f264	f0c50610-93bb-4d0f-a5c5-eed7db25823c	allow-default-scopes	true
5930ebce-9617-4393-84f8-d52223143bd1	e3160239-c886-40b7-a92c-c55485f20ec3	client-uris-must-match	true
99769131-cc88-4d70-9431-49647fa8727a	e3160239-c886-40b7-a92c-c55485f20ec3	host-sending-registration-request-must-match	true
29291b11-72e4-44f1-9075-0e12455b27ab	7f0c7345-16ef-4451-bf0c-ea854dbace79	allow-default-scopes	true
d004d769-a145-42f1-836d-29e68be2a0e2	1d12d54c-5fd8-4657-9e83-12edd55de278	max-clients	200
69eabd3c-52e1-4f95-8344-93e412dc7c50	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	oidc-address-mapper
70b301a7-a93e-4281-aab5-de149ab49be0	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
48fc36a1-a0f3-4eb3-b94a-0e31e93105b8	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	saml-role-list-mapper
062bcd0e-04d6-4ef2-9dac-da17770f311a	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	saml-user-property-mapper
19e757a0-1597-473e-8780-19d1cbb45c77	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	saml-user-attribute-mapper
238ad458-7e20-45d3-bb22-0e7dcd8bf6fc	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
5c242e07-f8c5-42f0-bd5c-ed9b32367e66	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	oidc-full-name-mapper
4382b967-a363-4e5b-8497-520d89f28479	7b4f3ea8-7598-4084-a1a8-2410848d6820	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
805b64bd-09f8-4779-ad02-ae0644c75081	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	saml-role-list-mapper
897609cc-0207-44e1-99dc-e8a50203cef1	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	saml-user-attribute-mapper
eee5a695-b5c8-499a-a860-c086cab33ec8	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3693208b-d01e-4682-884c-edca5366dce3	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	oidc-full-name-mapper
6cac2cda-b301-4b4b-8227-33c5efd3d916	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	oidc-address-mapper
958efd67-2697-4a32-8389-aeb9159f2c60	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	saml-user-property-mapper
f17482dd-6cdf-4162-a86d-602b102866e4	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e8a7fc84-13df-4395-8fb8-5355d6d8520b	66811d65-0501-4f7e-844a-05c10a815741	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
38ad79c1-a6cd-4d3b-9e20-3767d6869a7e	8d0b5ca8-373e-4855-8fbd-c67a23546612	certificate	MIICmzCCAYMCBgGeU+DsqDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNTIzMDgwNjUwWhcNMzYwNTIzMDgwODMwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDuPadhNWI26aYeB5LMO1uaLMaS2/s+syNOyZfbpzKXDrr5k/yheLDfx5Jt/1gPalYO6FXrmh0Q8i2/Bt+PV1EC+6eJY8hMAC1pSEFCVBv096Pj9r8d9WNnsryTJk7uMqT/C/xhe1xK6MFsjTljn8YtJqwJKIwD8ZXHyaPM+eCX8QegnkYrb99995xGft7dRsX7BEbsUEuPh48FfRFJ38p6ENzuZ7xfdG+CZmSQZYJ+JExYMO8yXagd/wOwqBVsjVYVgqagiQvNIDtU96lDkNrtf15Z+0KXMDPGNHlY536Sm6Ey/awD0uTb51pM4oFN9DqgQq7VZERG4bFL2xNytiDvAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADVTo98p+GZE9tuhYLK10yRn50KsRCTFLPWm5KoLKOimJ+Y5nEatQMBd3iN9gwjAgi+YSfH79XydWilxo0YPvK8VAJZhHmg+7vEi/ra7arXTR8hy+4f1GLUdga07aVnag7XGQMmTWn5ua2UWay9CrK0VkDESll2oSEVwryG7YT4Id6XqgSez/5kDzvoOgpxwqE63iY5vQphCl/b8czkhGU+RWgfarsVam3k9PwVniSHu8VBaFjDFT1zZFNuxC9bsu2TdAEEprMsTLoS/XHdsyz4rNEbXyuv9ImU8rdD3sIcNOeBZT6DUqFTgTOAzyx3Mx4fITe7hPADcl3kmlG7kMMI=
c44252d0-1359-468c-88a7-8852e458ce72	8d0b5ca8-373e-4855-8fbd-c67a23546612	priority	100
dbf97902-ed1c-4ef1-90b1-3ab3609dac32	8d0b5ca8-373e-4855-8fbd-c67a23546612	algorithm	RSA-OAEP
645ab817-d707-4646-b08b-f459ee4428f8	8d0b5ca8-373e-4855-8fbd-c67a23546612	privateKey	MIIEpAIBAAKCAQEA7j2nYTViNummHgeSzDtbmizGktv7PrMjTsmX26cylw66+ZP8oXiw38eSbf9YD2pWDuhV65odEPItvwbfj1dRAvuniWPITAAtaUhBQlQb9Pej4/a/HfVjZ7K8kyZO7jKk/wv8YXtcSujBbI05Y5/GLSasCSiMA/GVx8mjzPngl/EHoJ5GK2/fffecRn7e3UbF+wRG7FBLj4ePBX0RSd/KehDc7me8X3RvgmZkkGWCfiRMWDDvMl2oHf8DsKgVbI1WFYKmoIkLzSA7VPepQ5Da7X9eWftClzAzxjR5WOd+kpuhMv2sA9Lk2+daTOKBTfQ6oEKu1WRERuGxS9sTcrYg7wIDAQABAoIBAHUf63ePcqsTgF8YExQEBJtN8wwFSUZAdJXJ5zYOQ4FfNQ35MsTBnJdPus4IMGdXvFpU39TV7f9ESLg27Va/syy3wtx5KWIv3iN56ddtmVb8Hl83Eits1gOHrEzdkwVo8ZQP9PKJ3sxXFKzE21d+l8Pf1Mkl3Xwc26memMBvgnq/iirZbNfs3VsuhxS0gI4Tbe3npLTXxgGOULwWKGsw0NolwwcEGeEHTQEm3UvskZ8hpS/0WFCAadkuJLG+tkjitvkyDUQlmSAQJ9d/e5sWfPyWNL+APA+t+xHFfnmw/DwmyI8CBviLO4+lGZnQIpm3kAWzohEgHDWT2iW810neRMECgYEA/6x8JQMwgT8SkVr2LOBOzTjoVJpbAa27M5OuO/lAzL0nHscCooLPQx5Kwq3GgDPQHag3LO/IG0pBE8OmeYWakA3diXQm4xiU2GlpZs00RP7TVR4w7COoLeW9dcufIAsvFwKII9oP9IvAdIitmA7svxma/HBrO2vLoHzfq8S4na8CgYEA7ot5dwR4pR+F13F7hQIQ2FV/YjNpbuGwPmSDEqjLW8XxNMkyL+XQGURAYnpVY7p3K/wyUBCLq8tAkvntKThSeWd4sehV1VgBR0vgXBDvxoO0RuCHTRB6e1pdPqIVlhAfRq6Y4a87eZ7HgYHArFJAh4BxxciKV9s9msoSYxv8wMECgYEAqrCTvP4RHuhl1AbfPPyPf3EToo/eXBOJXBinBMEWItnRSTnhp28fQhbyIGB1mld9BJ+uHmECvj1njvNaq9ynYK7xDPgvkgNyM7zEMm6jC8D4g+YBEVWIzQOI5iCH3pO432rASvclGcVHOkWZZ1/nbHmCwC+pV2VS75UOmpVeD18CgYAe+pAAq9z7HLfl/b/byyPi5F+RojmcA8U+pRD8mF0ogvFLOKHC5KZ80YdHAroaJHobhToHec6ZteCh9cEd7EmRqKVc/V5AQZiQ6MKvUifBcRM1bS1FDdHKOTcIzkXdYiSdqkkCbh5cMgmYwQADoP7uWfjshZmpxTgf5QQ0SMsvQQKBgQCdFqLVz4Wjru9gDpg1Jqowg1kyn2H8CYqyfPdM5WGPm3E+Q4kZDw3H8tngehl8ek9L46aZpornPvcZo+epcMNERnTcV6Pmtd96jNUmh22OUiuLesMFKwqhxxQqtHwp0afCbpu2T8hzELL5+MMiAOqLKeOvh9BiOLEaBUv0e6MTag==
00867012-45ab-42b4-a427-da97da55a90c	8d0b5ca8-373e-4855-8fbd-c67a23546612	keyUse	ENC
ebc78d6a-f9cf-4ad2-9abe-b75e432ffc68	cfc4aa85-d5f4-4c5e-88a9-faae1d0db94b	kid	502812e9-e5b6-48cd-b52b-32bb33c267cb
dde005d4-c3db-4d1f-83ab-d0ffe05727c1	cfc4aa85-d5f4-4c5e-88a9-faae1d0db94b	secret	pVY1z-wp4eHSb-yyULtL-63IO_A6idpWe98dggKt-F3iIcsfdmliAA1ZwcBBvnrLNJCjyvP2vmTozwLUbit2mQ
69ec38eb-ffd9-4d58-8d05-b6f525ef9917	cfc4aa85-d5f4-4c5e-88a9-faae1d0db94b	priority	100
89391ea3-1ddf-4435-8691-c797738bede1	cfc4aa85-d5f4-4c5e-88a9-faae1d0db94b	algorithm	HS256
e4ed577a-3fe5-4a5a-8e1f-39095dc919da	2fe5e384-f91c-432f-bb3e-324baaf92f84	keyUse	SIG
61fe69bb-9fbd-4e6c-9ded-ee591997dd81	2fe5e384-f91c-432f-bb3e-324baaf92f84	priority	100
df5628aa-5b98-4fa0-80e6-704ddddb1887	2fe5e384-f91c-432f-bb3e-324baaf92f84	certificate	MIICmzCCAYMCBgGeU+DrvzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwNTIzMDgwNjQ5WhcNMzYwNTIzMDgwODI5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCd/WC5cz0nSiJmpTvaasB23PtckujMVLEdCJbuaKZu5Z0/Q3ESkoSQzifNxGlS1HU1YGRfGdhTWJaYebXZOwixvfb1YB0Ulzu2YpZVN2MqMYjUiUZhQ0MVqppTCl8IkW8j5e0UlT/yTndHcN2JH1TBPisahvlINKpHaZDNuAxqTdOM484NDpZKBxkkx+YofaW9zKuCBLWDvsvt2tjZfj7Gly+KaGOoLHW4z0VxZhi2TgQiN3BBI0ZIjMW8KlwxLR1s+sb5QiU7P3ybqhtmFI3VF0e1aOUCVAJvIPDPbYNE8hNy7ypBFhnM/97m5REkKegcJGID4tB90wINj4FE1VOLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAsvJcekEVBDJcHtg2S98680i3s5AvbRqKCW34gJ7AZMQ6JUJRsrwc4tLQ1hEo1zY1YsOI/xdQpd+RW6xOu+hg+2qrHUmBQOxCDv3C/smv+ca8I8yt1qQ+t1LyeRx2/KOipvc3iUWun3mCiz56tuhJ/ZsS56QiFHti87lHoXZG1rZgCGQlY5soi69e6uWG4xtRwPyuGXfRGPVOayk1UoGoYJ1Wo4TAwXpFHk4t61fqed5+KTRVgXUafWybMbtHkQjvSb4Fi1cDOdk5JE+zyD5t/fsgbfDKcLCnkIV8b1hwc87uylPaFasZjmQIdsuuWeuOJ6ufrzbcHnlKQUmtnnTWc=
c3a1364a-d2a2-47f3-b274-77b953dd9572	2fe5e384-f91c-432f-bb3e-324baaf92f84	privateKey	MIIEowIBAAKCAQEAnf1guXM9J0oiZqU72mrAdtz7XJLozFSxHQiW7mimbuWdP0NxEpKEkM4nzcRpUtR1NWBkXxnYU1iWmHm12TsIsb329WAdFJc7tmKWVTdjKjGI1IlGYUNDFaqaUwpfCJFvI+XtFJU/8k53R3DdiR9UwT4rGob5SDSqR2mQzbgMak3TjOPODQ6WSgcZJMfmKH2lvcyrggS1g77L7drY2X4+xpcvimhjqCx1uM9FcWYYtk4EIjdwQSNGSIzFvCpcMS0dbPrG+UIlOz98m6obZhSN1RdHtWjlAlQCbyDwz22DRPITcu8qQRYZzP/e5uURJCnoHCRiA+LQfdMCDY+BRNVTiwIDAQABAoIBAAf0jj5IUzf7P6gzgcQJxA84KWAL9bT0Psbbe94dXuQOo9BfsP3iatJvzwlJbpRBJnW9mNBBGOd5envLBSEfG9z3V8wbPtuekd8pL7CyzUd+nwk0sFqNbH9Wy9aKmyZvTE1ecoWqzkGBOfha8ozJCxd/7eO0EDFWlYxrAGObdOSVWk2xdvit77WI6DMb7xhRX07hTVkkwM6MzmosmegehERVbAGbPlM73dH4SKMSewubZ6m6QtmJJqKrQ3hN7kVnvmigetBVPqdNiQe9AY/8vukOvyUdpBK0gWrLhaINmksYHoKzyN2MfPJldYqrv4wRAkSja6OJd/NizNJ3XD2YGiECgYEA3QI0KMonj7t7s/X20Ju8Atr/DPMaEGXzSOwSCfLBs+2SmJBf1vRL6MFLoBQiMe8GhDM7ViipUV1lvPi00DcD4ScQZbBCYllEgD10p2wIN/buhq5wiFFndNCo9OTIEAjG9FpjZsUUGpWJUfLiqLozqvq8Nxrutgfsq8W0jpEm5hcCgYEAtwDt9wPXK4YeWCYeLbvi3iJeM+9B/8dn1GKs3+l/EooR6AqJpBfvXQmorhpO6HpxwfCyg+y5PsjfMDSccfaXaE6wtQEBFMKgCosLdhJiEIfEMzq61HD07AFh61ksZ7MjPUllUc9f0z17hS98zjUqzyfK0o3y5uJK2+xNPWkumq0CgYB81bPUnms+Oq4i9nnVV0IZcs3B6Mb+IDgNJpsB14cmNLkrR9F6vz7pV9V5tCWkgtjxb2bCwfDxrom69dhcC9c7JC+U4Lx+hOG2dgAgWVtDEU2l8X5K4YBIcVweB+QhenO2rh+bexJh+bk4+rKgj5yDpWEO1z2iwFMkq2XTaZXJPQKBgQCm6rIiG96mVC5ZOGtOS5EiCzbhJ9mK8tZBYb9MfCzrPAQZIYNpqGsq8SRpqJVQdl5MBr7MlZ5hJdZsoZAQYlq3SQ7kCYZy6RIQi8Job1wCt9K851SBcIX0vU4S28Mk0r/RpqBDfmJoyitfz3CGpPfm+uSEJ/TlooGlFmNdIBLiAQKBgCyv9ljzS0cZZ7Z1fw6IdgUQ0ZjF5AdC/dodGJhk5OAAFNlWM1QKkaZu4B4Yp2OTogOHVHDDB9OOjek9nm1m8X6eLW2CBXdOL+3V8jl6FDkhceD0J5z7TMIcAIFi6ev+L4gLckajBHoZubBN3lQS9ocD45d/Cy85PYxdG5g03FJv
f8b96ae4-12c3-45b0-a3e8-76dae9c40e29	08087614-04d2-4f81-a0ba-1dc09d73db13	secret	IJmHiPO3fjnmF6gl-wwNUQ
bb54f744-4e74-4914-9961-703563f40ab8	08087614-04d2-4f81-a0ba-1dc09d73db13	kid	d9adb869-31d8-4cd7-a9bf-a900402565cf
a3eddcae-2ed6-4fb3-bcfa-93dd3978829a	08087614-04d2-4f81-a0ba-1dc09d73db13	priority	100
17e395d8-1637-4b8a-8378-6e4f6727286d	45dc8e4b-e30f-46f3-863a-d4384cd36db8	privateKey	MIIEpAIBAAKCAQEA5pHmxhBVtDygp+jrVNkS7OjWi5xVLNBgmxU5p4cfRJiW66nPbLYcWH9sxAqgnK3DvB2kD2tbrGEe/YU12Xkp6f8QIHXNgFwvNid0MALawPKQQx7LSVp+/4XUlGbyYmFYoAt9HJgcizIY6Q6XPpIU/oksjSipxACdn6EZnuXLE4LayKs9pOKNI/HYrJxw7q7vQmOm1g/BgVXVZAIVSem9NsKceNmvYittF7CRLoU49pO2hTZyy8L6YjMpS7ETvMSeIQWKb9O6P8WtjMOtl9/0a+pAGYSxTUQn77PFpq569U/hsLwfMqbyvWIJR6Jv79GzoKeHZfEz7q3yrwyGkeN7CQIDAQABAoIBAFOoG13Avn/bQYU6vuv1qOa5YmKcUdElN+/85wLQRXmLjbKq1Z5Bgw5fCXUlz/mZGHwwGv8XOldUk7xzcULbMeh7SXwlke7hQ6X38bGbz4gTWmFoEmUmhw6qHaPMqGQmotPK51WRIUYl4qDo0Np8gU6LMdVzrAj4Gji5aITdJm4Iq2GCh3B6bj0DhaSlmgX/Lk9mpRyBQqLug7Gnzi7OIOxpKiuhd14EkNWXC2mGoRZot3z70Rx56ASXYH1bjLVwKxEVSgZAcLDxP/gvPr820cLDs1UO3KyLYjOvMnETruHMnqjLGC4+8p42QZTPa0lucgWXVmswffqtqVdTQ1ODEQsCgYEA/laRAGNtBenQHtQCLytEuwdfZl0nPaZLI8kUa5KQrKO83nh4U/4GkrTE9TdytpSsgL6UB+yswZRhINSoyfjbxLPkKFIhb9oE+Kr9wH0kWR3ra6AngrGUVh+hgJpSANrTm4+C7bdVJu4pDkoh4r1bEYijL3kBC2tcEBtkvVvIuVMCgYEA6BOT5r1kxMFqM4AaafJMeGfQhVzMrvBwCHVSmKEbeafb79Qwjfsd33X+YTmUOPqvnCoAaMTWyzz29Ew0ZrcazbtPOU6TGL7tq/1poThzpZR3ApZrXoM5y1o43VSvoluajyl9Llha/0ZVeZZWMQqhyg/zCBWaNLLCRBs7G09jwrMCgYEA0JVH96yStb3KG+49GFgA1u219GpDC1E84E1BPPOHSL5D36Om8yMqWth7iqt9nXUSf8dL+a/FAkDg4x7kijdYbNonLFYm6+c+Gn2I+3rl+1wJPUur+4gNIhBwz9o/lEniLvqkIrYu1G2PKBPt9FjcveV0BzPSgn36k48TsCP82tcCgYEA1o4LBZ6BQ/oAoj5DrUFJ+2MW/8Ssous82EUHKH6BtTY/+ni0rv7DPm2K0P33j7oLkpeuKy4X2muxcGfnZjLQP/V0p+mByrXxazlsZ5WWLTWV1TmVaBpv2xW9TrpVagfAW6yiw68B6dFvgmo/ozVOIE4ghI/cMe419dsrCPObqksCgYAKyeoyMUe1Jo+H3csLOPVreIeHcVPCiNX2WANrIXyEeg4+rKWy+6HRf6Iu+jnuGWPR8wgvhwGAtEx+vUuegGbkF10gjBWZtCW0PpA4A1I0SMp3JxpGa/Z+7g/fJKZpjd6I8LHISe++kt+XNlq5NmnPk/eHQTfkS0bbwa1Uyl1o1w==
95f6ce8c-1b95-40b2-ba95-1da0190896b1	45dc8e4b-e30f-46f3-863a-d4384cd36db8	certificate	MIICqTCCAZECBgGeU+DwMzANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1leHBlbnNlLXJlYWxtMB4XDTI2MDUyMzA4MDY1MVoXDTM2MDUyMzA4MDgzMVowGDEWMBQGA1UEAwwNZXhwZW5zZS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOaR5sYQVbQ8oKfo61TZEuzo1oucVSzQYJsVOaeHH0SYluupz2y2HFh/bMQKoJytw7wdpA9rW6xhHv2FNdl5Ken/ECB1zYBcLzYndDAC2sDykEMey0lafv+F1JRm8mJhWKALfRyYHIsyGOkOlz6SFP6JLI0oqcQAnZ+hGZ7lyxOC2sirPaTijSPx2KyccO6u70JjptYPwYFV1WQCFUnpvTbCnHjZr2IrbRewkS6FOPaTtoU2csvC+mIzKUuxE7zEniEFim/Tuj/FrYzDrZff9GvqQBmEsU1EJ++zxaauevVP4bC8HzKm8r1iCUeib+/Rs6Cnh2XxM+6t8q8MhpHjewkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAjjmRvf34/eNmEyQVL+YR2f1kpI9ndxBGiO7xK7hg/Kb0cG9IpANlR9p3QXa8vx7ZvJ5NupWhN1cCnURVRMQud3V7/lvEIDwzf8U6Yt9FF/teDLuABzMDhojGWmlP6/BD9mTFkRIci+zbhWRrCUJoxk3poVBraINLb6lHsymEHmacai+T0rJYoe9jbaiaDe8KaCwvZg5X8ZC1C6QkURKOzI+dt0896tBqzuDJNjAj2jNw59Zhy2H2xSgzoRCZOu3OCMNbcBNUgkNf5lxlv35LChs4f0wwTYQt9MZfwF90U4FX2BvP+ClsmD+UtJmR/MQJcT+iCRQiCXXM0MnOg2g78Q==
1774bba5-f293-41ea-b4b2-2263cb3ca441	45dc8e4b-e30f-46f3-863a-d4384cd36db8	priority	100
87838325-c267-4fb5-af45-c83280da1320	45dc8e4b-e30f-46f3-863a-d4384cd36db8	keyUse	SIG
741e7734-827e-4bd3-8658-7eae27d42c8c	59d902c7-594a-4005-8857-925542274557	priority	100
bc3fe7a5-d9b6-481a-ac24-a255ab485c9b	59d902c7-594a-4005-8857-925542274557	algorithm	RSA-OAEP
2145a1f9-9936-47ac-b461-7a85075cd507	59d902c7-594a-4005-8857-925542274557	keyUse	ENC
c95028b2-f91c-4169-9905-f5a753884be1	59d902c7-594a-4005-8857-925542274557	certificate	MIICqTCCAZECBgGeU+DxBzANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1leHBlbnNlLXJlYWxtMB4XDTI2MDUyMzA4MDY1MVoXDTM2MDUyMzA4MDgzMVowGDEWMBQGA1UEAwwNZXhwZW5zZS1yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALwybt3SCnXMjub+Wp/KrIsr6W7ENsyt7ikmPZceeH5AOQQEPFiuP9P42YHrGjGUjE70VSBuueaAmM15xURPjceA27A5gR8RTsipDlpdYnyN54sLiykWnVipODeIZBgikny+nprE7kxZ+eVaEWE4MyOFvhqWmaLjGTjhNJ/+rXzlO+Hoxxcne8EWelqQxLMksnSn0nODcul5uPpRCqptkBwKSOibIFEGS7G7zwtRcXh5isnzmsKWavCeZdD0sDLLGv0+TuDqJ2/BU9FnYRQh6RxUedz6qQhNiC4Lx14g0ixmKLUdev8GAO6jLgBHPDdwME9OtSyeKOFPWIp3mumRUjcCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAh2+w2+YPO8mGoEsiE5t85j+6M5aQaLRAFhf+gEFxTPD7c4YUO+1+xkX1uovZdHl8nFW9DXNj+UEaWU3BlUtQnUwKUjo1/hn+j7jA47qMtbxUZbI3nMof/WcB7E87phSImXb4n4lbOxN2fUhlcXz+L4PgajT3feOR3wg1PCnPj6LRakw+PV7Xh3kWdgJWTJztmnc5mRceiM7+bZ6dTEC41cPEee355B7P23KHK+bNmk/Zg1cYOao4FkMV9XIQUriGb9WmhwH3gnShgi/0dCcCZ2u88ZvUg9vLgouoWIRQj4FUOSWUKB9gDAgTTAucxVqYSFDCgurBDKkdcJ1N7eJYGA==
ce3727d9-3b43-4138-93b2-cd4f1d8697fe	59d902c7-594a-4005-8857-925542274557	privateKey	MIIEpAIBAAKCAQEAvDJu3dIKdcyO5v5an8qsiyvpbsQ2zK3uKSY9lx54fkA5BAQ8WK4/0/jZgesaMZSMTvRVIG655oCYzXnFRE+Nx4DbsDmBHxFOyKkOWl1ifI3niwuLKRadWKk4N4hkGCKSfL6emsTuTFn55VoRYTgzI4W+GpaZouMZOOE0n/6tfOU74ejHFyd7wRZ6WpDEsySydKfSc4Ny6Xm4+lEKqm2QHApI6JsgUQZLsbvPC1FxeHmKyfOawpZq8J5l0PSwMssa/T5O4Oonb8FT0WdhFCHpHFR53PqpCE2ILgvHXiDSLGYotR16/wYA7qMuAEc8N3AwT061LJ4o4U9Yinea6ZFSNwIDAQABAoIBAAcTFSfzMhiwil9YCMKkNtfsP7evoVqe7hVIeQCS5mHi0AyLGqncTwZFt84gvVG5QoxUKDkO1di6qny3WTI2PyaNfQLmmu+aUgN3Jhvr2RkaGoNQaw2foyyxcR8r9qmDmduPnqPuOR5ebRINtBobGXQlAcIQq1f1JExqsYLoo+vqqkMwsiO3moV7TZDJLkUijUoGRSK2b1tD2F5Z2QsV+iFsx1qNMPKXGdgKTopZXQCGgLYh/GXT3kuuL7Dnn9UZS61BbYM4PxQash/VskjHvOIsGLNnh/rZ+ycMwXHSdCCSimtCvF4/D+UY/b61ca8YEKRjScR7cYFUPpIo5FVOTSUCgYEA5Hy7cPN1Ef3lYf+/qmLxfiaxi+DlRPcgmwk3PJq5facMxp4ZzdJIlb35p9Z8fZKDTxx3E9ZHoWUGtIHRlWINNleJP8SagWNnvPwpcUOwcYZtK+uMecRyLpKcIYo5dIhX2U4toMi9kIBhjZQG8XxgCgmQnta1W2waswS8nmkAKbUCgYEA0tu6cEDsS+VlsWuROy+kVplp5XZnce5MM1szrD0rNVjeRwJfqROwVgJKXkf3r7/AGs9XZfNCcwWBw1t7Qut1AqNXTs+aQXQPjn/eGYmbdDBarwJB6CYurQdENQdGpy3oQYh5GItI7T9l20S9LVHMBB51lKFlsHvvHFJYAS/ET7sCgYEArhe3/k0SI35QG8ZxNJMlLBixaUIXjt+5cUepVb0SnoH9Aw0N3jxeX/IbWl3cBxXuhQXMWUoI1BmU7U6I8Yh/RquWAQd9Lh8euOltbkbEFwv0/OUB6Pncgk3lNs0KEBee0A14SK0LeyHGsshaLf+1cZBuKAiysJEDGun+Cbk5jY0CgYEAgVh8k6Of0CbWLPG5Uz80ZlMRnMr3RfJSGCbYGc4kFUOAhrq0B7mmL/yTtiYbkFnl9AxApq+EkZ5NLZOOl0xsqMOeKSA8le4mJNnXWn8JN0r6NeUCnO/fLhEJDCZ8ds04bgrTjfTTNYXwa4NNMOG+bsBojFY9VPeRhCQXDBNLL0UCgYAEQkNSzzS/2Ck/1nGmietWME9NdRQPPa89xlsgeLbWwG1zOwQvsrTUu9PtLywCsz7ztDRTKPwhk4xaGP5qbIxj+MpONzpxBO7c6cGyUDgKTkUwRDN3xWyHouHLamehxwSqfdn/wnP6UjPNRPswKeBn+3TJFCBc4cELfiRIdWWvzQ==
32edb884-f6c5-4bfb-8d4d-f6a536205d4c	957d042a-3e53-4ed0-bde9-6d8f4cf18f36	secret	VSmzPCeAAFVJayfa6McZMqsq5CDWZ3F1dNHTP0wIgVaV4vj658ggUjCvwgf9KHfwGokuH-LThEHfyacB9fTA2w
41b84b99-f510-405a-b7eb-c122446503e1	957d042a-3e53-4ed0-bde9-6d8f4cf18f36	algorithm	HS256
465964ab-e4f2-437a-abed-0c0d61bddca4	957d042a-3e53-4ed0-bde9-6d8f4cf18f36	priority	100
6718d8cc-1af1-42f7-b9f2-7756073b0f6c	957d042a-3e53-4ed0-bde9-6d8f4cf18f36	kid	db93dfd4-30e9-48a6-8b80-c80cf40ccf3c
6c26d427-639a-4bcf-9391-c37e9fcbcb34	7e86c254-f710-4501-bd0e-eda0ffd0fa97	kid	c73c0d62-1489-4065-aece-4be5dbef344b
f881ab60-698b-478b-83e8-b766aafbfba8	7e86c254-f710-4501-bd0e-eda0ffd0fa97	secret	ZNR1TLMqND-h6lCtrrlSpQ
ef231880-af7b-4666-95ec-84ef8d8b58c6	7e86c254-f710-4501-bd0e-eda0ffd0fa97	priority	100
d8174273-cdd1-4c73-8bb2-739eb4f0fa8f	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	oidc-full-name-mapper
7046d556-ee6f-4052-806d-d6d9dd9fa5ad	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	saml-role-list-mapper
6f25b293-d5db-4a6e-afca-291ec577cca0	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
be9502f6-a1c2-450e-8271-58e6af297c54	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	saml-user-property-mapper
a4dc234a-9e96-4ac5-837c-1375d6a4eaad	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	saml-user-attribute-mapper
577f9a09-0340-49c9-994e-a5424bd79c29	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9c09788b-18cd-43e9-be9c-3dbd2ecbec27	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9dc9e971-4820-4bc4-aca4-9a1773fb764d	2e4f0e8e-1c23-4811-a595-1eba0d9bf2cf	allowed-protocol-mapper-types	oidc-address-mapper
3b90c3ec-6e12-428f-b554-ee85efa30f9b	d6206732-e3fb-40c4-ad74-c77de2fd782e	host-sending-registration-request-must-match	true
4ffb1d3f-b17f-4971-9de7-739bb0598d3c	d6206732-e3fb-40c4-ad74-c77de2fd782e	client-uris-must-match	true
9a55c281-da51-4800-8d74-6a24cedd31e9	e08bc0f1-5df6-4900-9251-49e847612b27	max-clients	200
89ade8c0-a748-45c0-9548-76737da357ce	1d7a6af7-bab6-4dc2-9d3a-ee4ebde2d408	allow-default-scopes	true
252efacc-a0f9-40a0-b007-2051c8e26df8	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	saml-user-attribute-mapper
d1e3cd6a-aa67-427e-b3d9-b1398e04377b	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
fde2f841-7566-4d90-a4ec-996453218b89	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	saml-role-list-mapper
b67114a4-2ceb-44b7-a8b2-971cb6853fb5	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
87b397e8-f5cf-49ae-9d42-578b1e756862	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	oidc-full-name-mapper
00c9f9f7-57a8-4f64-b5de-ca9c276294e8	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	saml-user-property-mapper
949e5e88-ae24-4f72-8474-8da89701fb12	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
23ba50ae-3cee-408e-9e91-b6d7d32ea886	2a9122cf-8b94-454a-ae11-8240b3e49b77	allowed-protocol-mapper-types	oidc-address-mapper
7740ad80-f4f6-4879-92c5-4670cf5700b4	014dcd57-f139-4939-9c27-37e7c473d93a	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
da7c5567-cfce-4517-9f66-4ca4d900f0f1	cd3bac4c-e636-4625-ba2a-f27fb838d50b
da7c5567-cfce-4517-9f66-4ca4d900f0f1	0562e5b8-f5dd-4a8c-b285-0967a665cb9a
da7c5567-cfce-4517-9f66-4ca4d900f0f1	e0ecf157-c199-472d-875a-f695706f998d
da7c5567-cfce-4517-9f66-4ca4d900f0f1	83c54a4f-8d28-4b36-97b6-6f24799b4797
da7c5567-cfce-4517-9f66-4ca4d900f0f1	f81e7ce4-9239-4f23-a765-4c515117bb2e
da7c5567-cfce-4517-9f66-4ca4d900f0f1	91e8172d-acc8-481c-95ab-d3aa76f6aa06
da7c5567-cfce-4517-9f66-4ca4d900f0f1	1eeaef8f-2a9f-4b42-9dab-d62b23e4f388
da7c5567-cfce-4517-9f66-4ca4d900f0f1	1db902c6-5280-489f-ad86-3bfe4499ca3e
da7c5567-cfce-4517-9f66-4ca4d900f0f1	2aa97346-9669-403e-b5f6-d100685df235
da7c5567-cfce-4517-9f66-4ca4d900f0f1	5acc3105-54f8-4d33-a2f2-02a81bfa02b0
da7c5567-cfce-4517-9f66-4ca4d900f0f1	37271f36-c0fb-40ad-98bb-d229235788cc
da7c5567-cfce-4517-9f66-4ca4d900f0f1	c584b8cd-8655-4756-8a65-ec7f2645f43a
da7c5567-cfce-4517-9f66-4ca4d900f0f1	e648ae50-050e-4a7f-8fff-9201ab24e7f8
da7c5567-cfce-4517-9f66-4ca4d900f0f1	dc0d22f2-1f78-4348-bcc5-3831cf51e3dd
da7c5567-cfce-4517-9f66-4ca4d900f0f1	1be65f44-92ac-4701-a412-37a28d6d6869
da7c5567-cfce-4517-9f66-4ca4d900f0f1	4ea0209a-383d-49b8-97dc-7d195056e023
da7c5567-cfce-4517-9f66-4ca4d900f0f1	8ee029fe-dccc-44b5-8dd7-21accda89566
da7c5567-cfce-4517-9f66-4ca4d900f0f1	8e86724d-b735-4a6f-a52e-d7a558e3bb7d
83c54a4f-8d28-4b36-97b6-6f24799b4797	8e86724d-b735-4a6f-a52e-d7a558e3bb7d
83c54a4f-8d28-4b36-97b6-6f24799b4797	1be65f44-92ac-4701-a412-37a28d6d6869
cd69eb71-2b18-486a-b1f5-ec6438353a3a	5512df9f-7f70-4931-8ddd-4f28d12790f4
f81e7ce4-9239-4f23-a765-4c515117bb2e	4ea0209a-383d-49b8-97dc-7d195056e023
cd69eb71-2b18-486a-b1f5-ec6438353a3a	ec63b673-6217-4f4c-ad34-911cf74c886e
ec63b673-6217-4f4c-ad34-911cf74c886e	82ce0be6-a1af-4fb7-9910-e0e6198a3347
217aff71-a46f-4625-a3cb-3559f3349f5b	43846f6a-0779-433a-ad52-d38645f09475
da7c5567-cfce-4517-9f66-4ca4d900f0f1	bc26926e-4098-4e22-b58c-dce9c0ad1a3a
cd69eb71-2b18-486a-b1f5-ec6438353a3a	2bd03c28-1662-4f73-9f71-6bea3aff6021
cd69eb71-2b18-486a-b1f5-ec6438353a3a	1593193c-64ec-48f8-ab39-fe50ce14d243
da7c5567-cfce-4517-9f66-4ca4d900f0f1	cacc3ada-0e30-478b-89ed-b01c84fe7791
da7c5567-cfce-4517-9f66-4ca4d900f0f1	a72e72ec-d0d2-438a-b848-643ce8b79321
da7c5567-cfce-4517-9f66-4ca4d900f0f1	cd64da4f-6031-45e0-bea6-577e819d7c13
da7c5567-cfce-4517-9f66-4ca4d900f0f1	cf7dc1b4-b6af-4cbc-a74c-2a0d21412418
da7c5567-cfce-4517-9f66-4ca4d900f0f1	52482afe-7ce1-4809-ab67-e62bfaa0baa1
da7c5567-cfce-4517-9f66-4ca4d900f0f1	9868dc10-9514-451a-9904-235772fcd03e
da7c5567-cfce-4517-9f66-4ca4d900f0f1	cde1d390-8d44-4c05-9d71-2967885ae47f
da7c5567-cfce-4517-9f66-4ca4d900f0f1	29d55bf3-feae-4cc0-a8af-abe38bcdc8d9
da7c5567-cfce-4517-9f66-4ca4d900f0f1	3f0288f7-c678-411b-833b-c65d0046dbba
da7c5567-cfce-4517-9f66-4ca4d900f0f1	725431a3-14a3-4dc3-aff1-0162cfbf6fd2
da7c5567-cfce-4517-9f66-4ca4d900f0f1	472dfe60-ba6a-4f13-a577-93b92cd818b2
da7c5567-cfce-4517-9f66-4ca4d900f0f1	ddebfa8f-7fcc-41f1-9913-7e9a6a5cac71
da7c5567-cfce-4517-9f66-4ca4d900f0f1	09c33ebe-cc9d-44e9-9372-d080b963f4fb
da7c5567-cfce-4517-9f66-4ca4d900f0f1	5dccd71a-a4ff-4777-94b0-77927e8e413b
da7c5567-cfce-4517-9f66-4ca4d900f0f1	5314de76-e482-4279-abdf-3785f292c92a
da7c5567-cfce-4517-9f66-4ca4d900f0f1	40e797bc-66f8-4bd0-bb16-65eba0fe1858
da7c5567-cfce-4517-9f66-4ca4d900f0f1	9ff68a58-1b14-49d3-b43a-3ed153ca7e13
cd64da4f-6031-45e0-bea6-577e819d7c13	9ff68a58-1b14-49d3-b43a-3ed153ca7e13
cd64da4f-6031-45e0-bea6-577e819d7c13	5dccd71a-a4ff-4777-94b0-77927e8e413b
cf7dc1b4-b6af-4cbc-a74c-2a0d21412418	5314de76-e482-4279-abdf-3785f292c92a
705584ed-240a-49e7-83f7-239ae2fdb2b8	ce1813b2-6c00-4c84-abd8-9798f63576e7
705584ed-240a-49e7-83f7-239ae2fdb2b8	f5f50eaf-2952-4401-bfb0-fe53cc5bd98b
705584ed-240a-49e7-83f7-239ae2fdb2b8	153e148b-7855-47b7-89a0-24ee29df11cd
705584ed-240a-49e7-83f7-239ae2fdb2b8	ee5c0cb0-57e2-462a-ab85-3f2f6e8e1d7a
705584ed-240a-49e7-83f7-239ae2fdb2b8	cc29d978-5167-4b94-aa62-1f6d8aeff3cf
705584ed-240a-49e7-83f7-239ae2fdb2b8	604b2db6-ecf4-457b-b7e3-7b18f0195e1f
705584ed-240a-49e7-83f7-239ae2fdb2b8	c4408a1d-5950-4c36-872b-961f336901d9
705584ed-240a-49e7-83f7-239ae2fdb2b8	0f03dc7e-1aec-466e-8ac6-2ea912bbb572
705584ed-240a-49e7-83f7-239ae2fdb2b8	9c0355e4-97e7-4148-9fba-49328c6134dd
705584ed-240a-49e7-83f7-239ae2fdb2b8	2dcffc2d-0327-49ee-9c3f-c65c68787fb8
705584ed-240a-49e7-83f7-239ae2fdb2b8	c8e04758-2656-46b0-89a2-f5e5a21382cf
705584ed-240a-49e7-83f7-239ae2fdb2b8	b7d37c6e-0dd6-4a8c-a3f4-8444b3aeb680
705584ed-240a-49e7-83f7-239ae2fdb2b8	23319e9d-9045-49b5-8ced-a3049e200126
705584ed-240a-49e7-83f7-239ae2fdb2b8	9bf6e82d-3724-4029-9cdc-a1f50394a70e
705584ed-240a-49e7-83f7-239ae2fdb2b8	2a8c956a-569e-431a-9cdf-0d7a1bfb8181
705584ed-240a-49e7-83f7-239ae2fdb2b8	17889520-6230-40e9-9fd5-17017cf8841c
705584ed-240a-49e7-83f7-239ae2fdb2b8	802e3c22-fed9-47d5-9bbd-2b59197ba4f4
153e148b-7855-47b7-89a0-24ee29df11cd	802e3c22-fed9-47d5-9bbd-2b59197ba4f4
153e148b-7855-47b7-89a0-24ee29df11cd	9bf6e82d-3724-4029-9cdc-a1f50394a70e
684569f9-94cc-4ccc-b35a-9e5a41622c60	428ac971-1405-420e-b401-331e8d935bc2
ee5c0cb0-57e2-462a-ab85-3f2f6e8e1d7a	2a8c956a-569e-431a-9cdf-0d7a1bfb8181
684569f9-94cc-4ccc-b35a-9e5a41622c60	28778da3-f711-4030-932a-6af4278cacbf
28778da3-f711-4030-932a-6af4278cacbf	c3d2810b-ad6f-4f2b-bf89-3f94defff2e9
ce5c5771-fd4b-44f4-b49c-bb751df4f4c0	a49699ba-9616-47ce-8848-6b2388986029
da7c5567-cfce-4517-9f66-4ca4d900f0f1	df5cea49-f8c4-496c-aab0-535c7c517cc0
705584ed-240a-49e7-83f7-239ae2fdb2b8	c4d380e9-6291-4fc5-85d2-ffe330ec30ed
684569f9-94cc-4ccc-b35a-9e5a41622c60	0f903ef0-4fef-4b0a-afc8-dd5c05406384
684569f9-94cc-4ccc-b35a-9e5a41622c60	1288edc0-eed8-45d8-a5b6-a80ffd60ebe4
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
f5498c42-4ae5-483c-ab9e-d91fad6bdc39	\N	password	a8506192-c274-449a-b7dc-a5d7964d81cb	1779523710903	\N	{"value":"HQOqoz3l85m6WK2pxcgm8h+/5z1gVb3evOBYLjFKjUI=","salt":"uhcPaEQwcDjlyBhdeXFVpw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
91114102-74e2-4f4e-bb75-7bc2bd4d69a3	\N	password	ffc53aff-5578-4a1d-91c2-387d56779cf8	1779523710929	\N	{"value":"lpau+wOHLbLwaSpDqSbOmryZuSPqip8fAuIzjwFDiMo=","salt":"xGnVoLwqUSA0e9zhYo0hPA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
26bc755a-f1d6-4f46-b1f9-83a643100231	\N	password	63a5d56f-8132-41e7-9129-a56a8c876ba7	1779523711592	\N	{"value":"9WKtocf0B2quusEJFzmXxuWNv5ZaGnbgmi0ShqzGFjc=","salt":"bpg7tdg0d5/TbtOKWHruxQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-05-23 08:08:26.556412	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	9523705971
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-05-23 08:08:26.579684	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	9523705971
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-05-23 08:08:26.627633	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	9523705971
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-05-23 08:08:26.634892	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9523705971
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-05-23 08:08:26.764129	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	9523705971
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-05-23 08:08:26.774519	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	9523705971
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-05-23 08:08:26.870352	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	9523705971
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-05-23 08:08:26.88247	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	9523705971
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-05-23 08:08:26.889651	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	9523705971
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-05-23 08:08:27.015421	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	9523705971
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-05-23 08:08:27.076337	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9523705971
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-05-23 08:08:27.082815	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9523705971
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-05-23 08:08:27.095025	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	9523705971
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-23 08:08:27.122408	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	9523705971
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-23 08:08:27.12549	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9523705971
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-23 08:08:27.12951	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	9523705971
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-05-23 08:08:27.133036	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	9523705971
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-05-23 08:08:27.182073	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	9523705971
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-05-23 08:08:27.233995	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	9523705971
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-05-23 08:08:27.240132	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	9523705971
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-05-23 08:08:27.247107	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	9523705971
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-05-23 08:08:27.251977	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	9523705971
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-05-23 08:08:27.268874	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	9523705971
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-05-23 08:08:27.275276	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	9523705971
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-05-23 08:08:27.278692	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	9523705971
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-05-23 08:08:27.340642	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	9523705971
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-05-23 08:08:27.479324	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	9523705971
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-05-23 08:08:27.485324	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	9523705971
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-05-23 08:08:27.607726	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	9523705971
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-05-23 08:08:27.634875	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	9523705971
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-05-23 08:08:27.65727	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	9523705971
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-05-23 08:08:27.662905	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	9523705971
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-23 08:08:27.670247	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9523705971
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-23 08:08:27.673878	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	9523705971
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-23 08:08:27.706276	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	9523705971
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-05-23 08:08:27.712937	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	9523705971
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-05-23 08:08:27.723123	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9523705971
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-05-23 08:08:27.728208	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	9523705971
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-05-23 08:08:27.733237	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	9523705971
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-23 08:08:27.736124	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	9523705971
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-23 08:08:27.739953	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	9523705971
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-05-23 08:08:27.74437	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	9523705971
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-05-23 08:08:28.021632	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	9523705971
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-05-23 08:08:28.031297	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	9523705971
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-23 08:08:28.040129	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	9523705971
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-23 08:08:28.047816	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	9523705971
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-23 08:08:28.051153	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	9523705971
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-23 08:08:28.105033	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	9523705971
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-05-23 08:08:28.11166	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	9523705971
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-05-23 08:08:28.198371	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	9523705971
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-05-23 08:08:28.261374	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	9523705971
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-05-23 08:08:28.267999	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9523705971
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-05-23 08:08:28.272669	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	9523705971
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-05-23 08:08:28.276739	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	9523705971
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-23 08:08:28.288747	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	9523705971
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-23 08:08:28.295984	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	9523705971
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-23 08:08:28.33067	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	9523705971
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-05-23 08:08:28.4492	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	9523705971
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-05-23 08:08:28.485826	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	9523705971
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-05-23 08:08:28.496488	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	9523705971
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-05-23 08:08:28.506777	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	9523705971
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-05-23 08:08:28.518334	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	9523705971
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-05-23 08:08:28.524185	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	9523705971
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-05-23 08:08:28.528632	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	9523705971
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-05-23 08:08:28.533014	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	9523705971
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-05-23 08:08:28.556442	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	9523705971
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-05-23 08:08:28.567221	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	9523705971
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-05-23 08:08:28.575135	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	9523705971
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-05-23 08:08:28.591699	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	9523705971
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-05-23 08:08:28.599207	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	9523705971
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-05-23 08:08:28.606207	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	9523705971
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-23 08:08:28.613983	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9523705971
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-23 08:08:28.620348	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9523705971
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-23 08:08:28.623149	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	9523705971
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-23 08:08:28.635467	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	9523705971
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-05-23 08:08:28.646044	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	9523705971
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-23 08:08:28.651643	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	9523705971
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-23 08:08:28.65453	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	9523705971
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-23 08:08:28.673487	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	9523705971
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-05-23 08:08:28.678114	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	9523705971
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-23 08:08:28.688628	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	9523705971
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-23 08:08:28.691255	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9523705971
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-23 08:08:28.697847	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9523705971
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-23 08:08:28.700716	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	9523705971
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-05-23 08:08:28.710542	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9523705971
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-05-23 08:08:28.716927	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	9523705971
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-05-23 08:08:28.725241	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	9523705971
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-05-23 08:08:28.740545	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	9523705971
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.747497	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	9523705971
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.753889	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	9523705971
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.763825	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9523705971
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.770743	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	9523705971
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.773465	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	9523705971
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.784304	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	9523705971
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.788161	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	9523705971
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-05-23 08:08:28.794641	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	9523705971
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.813287	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	9523705971
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.815868	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9523705971
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.821453	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9523705971
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.832923	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9523705971
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.835554	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9523705971
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.845098	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	9523705971
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-05-23 08:08:28.849204	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	9523705971
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-05-23 08:08:28.855697	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	9523705971
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-05-23 08:08:28.865362	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	9523705971
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-05-23 08:08:28.875049	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	9523705971
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-05-23 08:08:28.879649	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	9523705971
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-23 08:08:28.889567	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	9523705971
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-23 08:08:28.892273	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	9523705971
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-05-23 08:08:28.899082	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	9523705971
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-05-23 08:08:28.903124	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	9523705971
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-05-23 08:08:28.958916	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	9523705971
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-05-23 08:08:28.963768	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	9523705971
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-05-23 08:08:28.968526	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	9523705971
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-05-23 08:08:28.971773	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	9523705971
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-05-23 08:08:28.979225	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	9523705971
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-05-23 08:08:28.984867	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	9523705971
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
f3ec96da-52ff-4e0c-97c3-b10293c3178a	26e6767f-720c-4ce7-8c16-adb2a7c2362e	f
f3ec96da-52ff-4e0c-97c3-b10293c3178a	1cd05e28-baf2-44e1-af37-61539cf0e8a3	t
f3ec96da-52ff-4e0c-97c3-b10293c3178a	6c9240ed-a1fa-4e86-9190-694c9b6f94a9	t
f3ec96da-52ff-4e0c-97c3-b10293c3178a	63bb8ee4-7f67-41cd-b5af-d3565a6da605	t
f3ec96da-52ff-4e0c-97c3-b10293c3178a	50613a4d-535e-49a0-83a4-94fb9b801e03	f
f3ec96da-52ff-4e0c-97c3-b10293c3178a	6fde5651-0692-4f64-b2aa-f7792f8d2ef1	f
f3ec96da-52ff-4e0c-97c3-b10293c3178a	b408f146-b3d0-4231-b5fb-f826c0a42b2d	t
f3ec96da-52ff-4e0c-97c3-b10293c3178a	394cd6d5-6ec7-4372-80e0-f5df04aa76c0	t
f3ec96da-52ff-4e0c-97c3-b10293c3178a	7523ee8d-3c82-4c61-a10e-eda9f857f0e3	f
f3ec96da-52ff-4e0c-97c3-b10293c3178a	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2	t
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	d038e890-3104-4898-ae6c-f2b11a69ddf2	f
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	875e0703-bce3-44a4-a380-3a80e896aa60	t
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	46df6e14-4222-4fed-a8e2-b8f6b41e195f	t
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	e4c2c46b-57ad-4065-95e6-a105606ec84c	t
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	c11dc7c2-8afc-436e-ac13-35f73094ee86	f
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	28b1b129-1a5e-4bc9-a249-b841ac834087	f
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	2cb4fba9-6d85-45b5-98a2-4805d6110ca9	t
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	4770de6d-fc03-4e56-b313-f5bbdc6a4612	t
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0c335934-736c-4153-99ea-c3899f3462e3	f
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	8c786c51-3c0c-4e40-8284-2e941a8da6fe	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
cd69eb71-2b18-486a-b1f5-ec6438353a3a	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	${role_default-roles}	default-roles-master	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	\N
cd3bac4c-e636-4625-ba2a-f27fb838d50b	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	${role_create-realm}	create-realm	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	\N
da7c5567-cfce-4517-9f66-4ca4d900f0f1	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	${role_admin}	admin	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	\N
0562e5b8-f5dd-4a8c-b285-0967a665cb9a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_create-client}	create-client	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
e0ecf157-c199-472d-875a-f695706f998d	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_view-realm}	view-realm	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
83c54a4f-8d28-4b36-97b6-6f24799b4797	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_view-users}	view-users	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
f81e7ce4-9239-4f23-a765-4c515117bb2e	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_view-clients}	view-clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
91e8172d-acc8-481c-95ab-d3aa76f6aa06	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_view-events}	view-events	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
1eeaef8f-2a9f-4b42-9dab-d62b23e4f388	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_view-identity-providers}	view-identity-providers	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
1db902c6-5280-489f-ad86-3bfe4499ca3e	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_view-authorization}	view-authorization	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
2aa97346-9669-403e-b5f6-d100685df235	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_manage-realm}	manage-realm	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
5acc3105-54f8-4d33-a2f2-02a81bfa02b0	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_manage-users}	manage-users	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
37271f36-c0fb-40ad-98bb-d229235788cc	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_manage-clients}	manage-clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
c584b8cd-8655-4756-8a65-ec7f2645f43a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_manage-events}	manage-events	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
e648ae50-050e-4a7f-8fff-9201ab24e7f8	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_manage-identity-providers}	manage-identity-providers	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
dc0d22f2-1f78-4348-bcc5-3831cf51e3dd	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_manage-authorization}	manage-authorization	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
1be65f44-92ac-4701-a412-37a28d6d6869	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_query-users}	query-users	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
4ea0209a-383d-49b8-97dc-7d195056e023	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_query-clients}	query-clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
8ee029fe-dccc-44b5-8dd7-21accda89566	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_query-realms}	query-realms	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
8e86724d-b735-4a6f-a52e-d7a558e3bb7d	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_query-groups}	query-groups	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
5512df9f-7f70-4931-8ddd-4f28d12790f4	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_view-profile}	view-profile	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
ec63b673-6217-4f4c-ad34-911cf74c886e	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_manage-account}	manage-account	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
82ce0be6-a1af-4fb7-9910-e0e6198a3347	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_manage-account-links}	manage-account-links	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
502ee07e-0659-4e40-9f9e-3a70e586a0fe	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_view-applications}	view-applications	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
43846f6a-0779-433a-ad52-d38645f09475	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_view-consent}	view-consent	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
217aff71-a46f-4625-a3cb-3559f3349f5b	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_manage-consent}	manage-consent	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
69ff608b-5ebc-4151-87c4-b3bf6fc637c5	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_view-groups}	view-groups	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
2245259c-def9-4d65-a91d-f5b1b34cb743	e5f26731-8a53-47d8-b3b0-a4652e7901bd	t	${role_delete-account}	delete-account	f3ec96da-52ff-4e0c-97c3-b10293c3178a	e5f26731-8a53-47d8-b3b0-a4652e7901bd	\N
d8d93f55-2264-4edb-9e23-33a484a055f0	602dc3c7-c130-4c35-8403-b3a2b53a70ee	t	${role_read-token}	read-token	f3ec96da-52ff-4e0c-97c3-b10293c3178a	602dc3c7-c130-4c35-8403-b3a2b53a70ee	\N
bc26926e-4098-4e22-b58c-dce9c0ad1a3a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	t	${role_impersonation}	impersonation	f3ec96da-52ff-4e0c-97c3-b10293c3178a	a37426d1-c5b6-46ad-9e14-166ceb67dd49	\N
2bd03c28-1662-4f73-9f71-6bea3aff6021	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	${role_offline-access}	offline_access	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	\N
1593193c-64ec-48f8-ab39-fe50ce14d243	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	${role_uma_authorization}	uma_authorization	f3ec96da-52ff-4e0c-97c3-b10293c3178a	\N	\N
684569f9-94cc-4ccc-b35a-9e5a41622c60	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f	${role_default-roles}	default-roles-expense-realm	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N	\N
cacc3ada-0e30-478b-89ed-b01c84fe7791	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_create-client}	create-client	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
a72e72ec-d0d2-438a-b848-643ce8b79321	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_view-realm}	view-realm	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
cd64da4f-6031-45e0-bea6-577e819d7c13	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_view-users}	view-users	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
cf7dc1b4-b6af-4cbc-a74c-2a0d21412418	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_view-clients}	view-clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
52482afe-7ce1-4809-ab67-e62bfaa0baa1	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_view-events}	view-events	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
9868dc10-9514-451a-9904-235772fcd03e	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_view-identity-providers}	view-identity-providers	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
cde1d390-8d44-4c05-9d71-2967885ae47f	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_view-authorization}	view-authorization	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
29d55bf3-feae-4cc0-a8af-abe38bcdc8d9	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_manage-realm}	manage-realm	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
3f0288f7-c678-411b-833b-c65d0046dbba	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_manage-users}	manage-users	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
725431a3-14a3-4dc3-aff1-0162cfbf6fd2	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_manage-clients}	manage-clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
472dfe60-ba6a-4f13-a577-93b92cd818b2	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_manage-events}	manage-events	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
ddebfa8f-7fcc-41f1-9913-7e9a6a5cac71	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_manage-identity-providers}	manage-identity-providers	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
09c33ebe-cc9d-44e9-9372-d080b963f4fb	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_manage-authorization}	manage-authorization	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
5dccd71a-a4ff-4777-94b0-77927e8e413b	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_query-users}	query-users	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
5314de76-e482-4279-abdf-3785f292c92a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_query-clients}	query-clients	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
40e797bc-66f8-4bd0-bb16-65eba0fe1858	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_query-realms}	query-realms	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
9ff68a58-1b14-49d3-b43a-3ed153ca7e13	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_query-groups}	query-groups	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
705584ed-240a-49e7-83f7-239ae2fdb2b8	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_realm-admin}	realm-admin	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
ce1813b2-6c00-4c84-abd8-9798f63576e7	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_create-client}	create-client	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
f5f50eaf-2952-4401-bfb0-fe53cc5bd98b	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_view-realm}	view-realm	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
153e148b-7855-47b7-89a0-24ee29df11cd	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_view-users}	view-users	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
ee5c0cb0-57e2-462a-ab85-3f2f6e8e1d7a	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_view-clients}	view-clients	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
cc29d978-5167-4b94-aa62-1f6d8aeff3cf	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_view-events}	view-events	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
604b2db6-ecf4-457b-b7e3-7b18f0195e1f	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_view-identity-providers}	view-identity-providers	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
c4408a1d-5950-4c36-872b-961f336901d9	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_view-authorization}	view-authorization	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
0f03dc7e-1aec-466e-8ac6-2ea912bbb572	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_manage-realm}	manage-realm	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
9c0355e4-97e7-4148-9fba-49328c6134dd	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_manage-users}	manage-users	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
2dcffc2d-0327-49ee-9c3f-c65c68787fb8	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_manage-clients}	manage-clients	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
c8e04758-2656-46b0-89a2-f5e5a21382cf	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_manage-events}	manage-events	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
b7d37c6e-0dd6-4a8c-a3f4-8444b3aeb680	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_manage-identity-providers}	manage-identity-providers	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
23319e9d-9045-49b5-8ced-a3049e200126	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_manage-authorization}	manage-authorization	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
9bf6e82d-3724-4029-9cdc-a1f50394a70e	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_query-users}	query-users	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
2a8c956a-569e-431a-9cdf-0d7a1bfb8181	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_query-clients}	query-clients	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
17889520-6230-40e9-9fd5-17017cf8841c	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_query-realms}	query-realms	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
802e3c22-fed9-47d5-9bbd-2b59197ba4f4	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_query-groups}	query-groups	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
428ac971-1405-420e-b401-331e8d935bc2	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_view-profile}	view-profile	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
28778da3-f711-4030-932a-6af4278cacbf	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_manage-account}	manage-account	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
c3d2810b-ad6f-4f2b-bf89-3f94defff2e9	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_manage-account-links}	manage-account-links	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
a8f98ba5-8c11-41b9-81db-2a3972663d64	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_view-applications}	view-applications	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
a49699ba-9616-47ce-8848-6b2388986029	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_view-consent}	view-consent	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
ce5c5771-fd4b-44f4-b49c-bb751df4f4c0	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_manage-consent}	manage-consent	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
d57421cb-7e4b-4783-a7f4-faaa064c3699	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_view-groups}	view-groups	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
55703ed6-8823-4dd0-9c0c-66afb4070638	3f75d006-a362-47c3-b3a9-662b7e19cf93	t	${role_delete-account}	delete-account	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	3f75d006-a362-47c3-b3a9-662b7e19cf93	\N
df5cea49-f8c4-496c-aab0-535c7c517cc0	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	t	${role_impersonation}	impersonation	f3ec96da-52ff-4e0c-97c3-b10293c3178a	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	\N
c4d380e9-6291-4fc5-85d2-ffe330ec30ed	9cd331b6-6b62-49e8-b15d-df355b54d5c1	t	${role_impersonation}	impersonation	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	9cd331b6-6b62-49e8-b15d-df355b54d5c1	\N
f339f04d-c22b-4784-99dd-c32699c04bcb	933099e8-7248-4f1d-bb1a-78052692eeb5	t	${role_read-token}	read-token	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	933099e8-7248-4f1d-bb1a-78052692eeb5	\N
0f903ef0-4fef-4b0a-afc8-dd5c05406384	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f	${role_offline-access}	offline_access	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N	\N
88d96335-7811-4b8f-9f94-d248c50d3cb3	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f	User role	user	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N	\N
1288edc0-eed8-45d8-a5b6-a80ffd60ebe4	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f	${role_uma_authorization}	uma_authorization	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
c7uux	23.0.7	1779523709
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
a883cde9-21bc-4706-bf7d-df4730c3f687	audience resolve	openid-connect	oidc-audience-resolve-mapper	ea0eeca3-09be-401e-96f5-de1afe33a003	\N
dec07131-b227-4d4c-b969-ce0737e2c713	locale	openid-connect	oidc-usermodel-attribute-mapper	05fe4b80-4863-4f01-9e25-57230393a8de	\N
c8d197ab-feca-4f9c-9cec-3ac5eca8963f	role list	saml	saml-role-list-mapper	\N	1cd05e28-baf2-44e1-af37-61539cf0e8a3
f2145440-d00c-4cb8-aaa5-c9d2063a4e8c	full name	openid-connect	oidc-full-name-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
725f5753-12a9-42d0-b581-6a113037d1eb	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
12b78c69-159a-4935-aee7-3d7e0feffcac	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
e24f92d2-ff3d-43b2-842c-109138bf0514	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
5237bc00-71a5-43bf-ad02-c98b7d2e6227	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	username	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
6346d7fa-aab6-43ef-a077-2c7275444aad	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
62f77067-3580-4b48-80a1-3436589d6221	website	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
919fe2ce-be10-463a-a26a-606b9dfe66c9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
ffe7b37d-6c77-4548-8705-0ef5c67c5276	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
041fdb59-d01f-455a-971d-1da754ab9dc9	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	6c9240ed-a1fa-4e86-9190-694c9b6f94a9
6885e7d1-d15f-4321-a8a0-0134cf9349b8	email	openid-connect	oidc-usermodel-attribute-mapper	\N	63bb8ee4-7f67-41cd-b5af-d3565a6da605
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	email verified	openid-connect	oidc-usermodel-property-mapper	\N	63bb8ee4-7f67-41cd-b5af-d3565a6da605
46eec94b-bae4-49f5-b248-feb7dab9cc22	address	openid-connect	oidc-address-mapper	\N	50613a4d-535e-49a0-83a4-94fb9b801e03
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	6fde5651-0692-4f64-b2aa-f7792f8d2ef1
e75189e8-efb6-4028-8dc7-1c0d90735562	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	6fde5651-0692-4f64-b2aa-f7792f8d2ef1
e62a5e05-8032-4832-9531-1210659afae1	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b408f146-b3d0-4231-b5fb-f826c0a42b2d
71eae4ef-e3a6-476a-9011-dc8c6d02e712	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b408f146-b3d0-4231-b5fb-f826c0a42b2d
2e5b5c5f-fe6e-4e4d-a891-cfbf8dd2187b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b408f146-b3d0-4231-b5fb-f826c0a42b2d
fa0f653c-d85e-49b2-8efb-d82f4ddc7a5c	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	394cd6d5-6ec7-4372-80e0-f5df04aa76c0
abd064b9-f651-4c62-b4ca-553761dd7e90	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	7523ee8d-3c82-4c61-a10e-eda9f857f0e3
5eb5b849-0244-4cc3-afec-182e67fb8e32	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	7523ee8d-3c82-4c61-a10e-eda9f857f0e3
c834f104-5b67-4366-8a91-c74c11b8e8aa	acr loa level	openid-connect	oidc-acr-mapper	\N	5b677db1-fc4b-4e4f-8421-7a0dc9757ff2
a784e014-36a2-497c-911d-8b3e9d9c89d7	audience resolve	openid-connect	oidc-audience-resolve-mapper	f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	\N
5622c733-cdf1-4554-8f69-b51d3f70fbf2	role list	saml	saml-role-list-mapper	\N	875e0703-bce3-44a4-a380-3a80e896aa60
310b6954-07b5-4800-ada4-b9fd53e05b25	full name	openid-connect	oidc-full-name-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
36a876a9-5063-4849-8945-e2c5a417dcbf	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
895620d3-8090-4724-b389-829e88140554	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
65e97f65-1fcd-453a-b3af-271cde9e3a44	username	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
6420182f-40f5-4735-9038-fd80a2ae5517	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	website	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
46debbbd-c31c-493f-88ee-e05d39456b66	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
47f9f4ab-96a8-42bd-91a9-10dc617442a9	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
eff66991-1235-4983-808a-a37c430cbb7c	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
b29c6db7-edd6-41c7-aa06-be35f0a51692	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	46df6e14-4222-4fed-a8e2-b8f6b41e195f
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	email	openid-connect	oidc-usermodel-attribute-mapper	\N	e4c2c46b-57ad-4065-95e6-a105606ec84c
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	email verified	openid-connect	oidc-usermodel-property-mapper	\N	e4c2c46b-57ad-4065-95e6-a105606ec84c
7dd74163-2ca4-4831-9987-cdee09643936	address	openid-connect	oidc-address-mapper	\N	c11dc7c2-8afc-436e-ac13-35f73094ee86
cedd0af9-80c3-4fad-8035-a60d91ef42a3	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	28b1b129-1a5e-4bc9-a249-b841ac834087
eaacc593-8f48-44be-a9dc-c6e037ade5fe	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	28b1b129-1a5e-4bc9-a249-b841ac834087
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2cb4fba9-6d85-45b5-98a2-4805d6110ca9
3f8d85a7-829d-41d9-8b35-29efd6a371a5	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2cb4fba9-6d85-45b5-98a2-4805d6110ca9
40835769-83d5-48fd-95e1-df2b5a1b9287	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2cb4fba9-6d85-45b5-98a2-4805d6110ca9
2c954381-1330-4251-93c1-fd7474ebc169	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4770de6d-fc03-4e56-b313-f5bbdc6a4612
076a979a-68e4-4982-b0c9-7ffaff893caa	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	0c335934-736c-4153-99ea-c3899f3462e3
8613d991-f528-45e4-bc6a-3a4aa55fac83	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	0c335934-736c-4153-99ea-c3899f3462e3
acac2399-c7cf-41ed-94fe-b85be8919ecf	acr loa level	openid-connect	oidc-acr-mapper	\N	8c786c51-3c0c-4e40-8284-2e941a8da6fe
ef9fd5de-0760-464f-9565-8d67b702912c	locale	openid-connect	oidc-usermodel-attribute-mapper	2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
dec07131-b227-4d4c-b969-ce0737e2c713	true	introspection.token.claim
dec07131-b227-4d4c-b969-ce0737e2c713	true	userinfo.token.claim
dec07131-b227-4d4c-b969-ce0737e2c713	locale	user.attribute
dec07131-b227-4d4c-b969-ce0737e2c713	true	id.token.claim
dec07131-b227-4d4c-b969-ce0737e2c713	true	access.token.claim
dec07131-b227-4d4c-b969-ce0737e2c713	locale	claim.name
dec07131-b227-4d4c-b969-ce0737e2c713	String	jsonType.label
c8d197ab-feca-4f9c-9cec-3ac5eca8963f	false	single
c8d197ab-feca-4f9c-9cec-3ac5eca8963f	Basic	attribute.nameformat
c8d197ab-feca-4f9c-9cec-3ac5eca8963f	Role	attribute.name
041fdb59-d01f-455a-971d-1da754ab9dc9	true	introspection.token.claim
041fdb59-d01f-455a-971d-1da754ab9dc9	true	userinfo.token.claim
041fdb59-d01f-455a-971d-1da754ab9dc9	locale	user.attribute
041fdb59-d01f-455a-971d-1da754ab9dc9	true	id.token.claim
041fdb59-d01f-455a-971d-1da754ab9dc9	true	access.token.claim
041fdb59-d01f-455a-971d-1da754ab9dc9	locale	claim.name
041fdb59-d01f-455a-971d-1da754ab9dc9	String	jsonType.label
12b78c69-159a-4935-aee7-3d7e0feffcac	true	introspection.token.claim
12b78c69-159a-4935-aee7-3d7e0feffcac	true	userinfo.token.claim
12b78c69-159a-4935-aee7-3d7e0feffcac	firstName	user.attribute
12b78c69-159a-4935-aee7-3d7e0feffcac	true	id.token.claim
12b78c69-159a-4935-aee7-3d7e0feffcac	true	access.token.claim
12b78c69-159a-4935-aee7-3d7e0feffcac	given_name	claim.name
12b78c69-159a-4935-aee7-3d7e0feffcac	String	jsonType.label
5237bc00-71a5-43bf-ad02-c98b7d2e6227	true	introspection.token.claim
5237bc00-71a5-43bf-ad02-c98b7d2e6227	true	userinfo.token.claim
5237bc00-71a5-43bf-ad02-c98b7d2e6227	nickname	user.attribute
5237bc00-71a5-43bf-ad02-c98b7d2e6227	true	id.token.claim
5237bc00-71a5-43bf-ad02-c98b7d2e6227	true	access.token.claim
5237bc00-71a5-43bf-ad02-c98b7d2e6227	nickname	claim.name
5237bc00-71a5-43bf-ad02-c98b7d2e6227	String	jsonType.label
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	true	introspection.token.claim
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	true	userinfo.token.claim
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	updatedAt	user.attribute
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	true	id.token.claim
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	true	access.token.claim
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	updated_at	claim.name
5ac21d19-b5f2-4eaa-9bb2-279dbf42e010	long	jsonType.label
62f77067-3580-4b48-80a1-3436589d6221	true	introspection.token.claim
62f77067-3580-4b48-80a1-3436589d6221	true	userinfo.token.claim
62f77067-3580-4b48-80a1-3436589d6221	website	user.attribute
62f77067-3580-4b48-80a1-3436589d6221	true	id.token.claim
62f77067-3580-4b48-80a1-3436589d6221	true	access.token.claim
62f77067-3580-4b48-80a1-3436589d6221	website	claim.name
62f77067-3580-4b48-80a1-3436589d6221	String	jsonType.label
6346d7fa-aab6-43ef-a077-2c7275444aad	true	introspection.token.claim
6346d7fa-aab6-43ef-a077-2c7275444aad	true	userinfo.token.claim
6346d7fa-aab6-43ef-a077-2c7275444aad	picture	user.attribute
6346d7fa-aab6-43ef-a077-2c7275444aad	true	id.token.claim
6346d7fa-aab6-43ef-a077-2c7275444aad	true	access.token.claim
6346d7fa-aab6-43ef-a077-2c7275444aad	picture	claim.name
6346d7fa-aab6-43ef-a077-2c7275444aad	String	jsonType.label
725f5753-12a9-42d0-b581-6a113037d1eb	true	introspection.token.claim
725f5753-12a9-42d0-b581-6a113037d1eb	true	userinfo.token.claim
725f5753-12a9-42d0-b581-6a113037d1eb	lastName	user.attribute
725f5753-12a9-42d0-b581-6a113037d1eb	true	id.token.claim
725f5753-12a9-42d0-b581-6a113037d1eb	true	access.token.claim
725f5753-12a9-42d0-b581-6a113037d1eb	family_name	claim.name
725f5753-12a9-42d0-b581-6a113037d1eb	String	jsonType.label
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	true	introspection.token.claim
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	true	userinfo.token.claim
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	zoneinfo	user.attribute
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	true	id.token.claim
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	true	access.token.claim
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	zoneinfo	claim.name
76ee5583-2e66-4b35-8e0c-cb83d4a6d247	String	jsonType.label
919fe2ce-be10-463a-a26a-606b9dfe66c9	true	introspection.token.claim
919fe2ce-be10-463a-a26a-606b9dfe66c9	true	userinfo.token.claim
919fe2ce-be10-463a-a26a-606b9dfe66c9	gender	user.attribute
919fe2ce-be10-463a-a26a-606b9dfe66c9	true	id.token.claim
919fe2ce-be10-463a-a26a-606b9dfe66c9	true	access.token.claim
919fe2ce-be10-463a-a26a-606b9dfe66c9	gender	claim.name
919fe2ce-be10-463a-a26a-606b9dfe66c9	String	jsonType.label
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	true	introspection.token.claim
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	true	userinfo.token.claim
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	profile	user.attribute
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	true	id.token.claim
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	true	access.token.claim
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	profile	claim.name
93edcbd1-46c8-41f6-951d-7acfe0b3edcb	String	jsonType.label
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	true	introspection.token.claim
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	true	userinfo.token.claim
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	username	user.attribute
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	true	id.token.claim
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	true	access.token.claim
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	preferred_username	claim.name
dd2dff49-d068-48b8-ab29-26ac04aa4bf0	String	jsonType.label
e24f92d2-ff3d-43b2-842c-109138bf0514	true	introspection.token.claim
e24f92d2-ff3d-43b2-842c-109138bf0514	true	userinfo.token.claim
e24f92d2-ff3d-43b2-842c-109138bf0514	middleName	user.attribute
e24f92d2-ff3d-43b2-842c-109138bf0514	true	id.token.claim
e24f92d2-ff3d-43b2-842c-109138bf0514	true	access.token.claim
e24f92d2-ff3d-43b2-842c-109138bf0514	middle_name	claim.name
e24f92d2-ff3d-43b2-842c-109138bf0514	String	jsonType.label
f2145440-d00c-4cb8-aaa5-c9d2063a4e8c	true	introspection.token.claim
f2145440-d00c-4cb8-aaa5-c9d2063a4e8c	true	userinfo.token.claim
f2145440-d00c-4cb8-aaa5-c9d2063a4e8c	true	id.token.claim
f2145440-d00c-4cb8-aaa5-c9d2063a4e8c	true	access.token.claim
ffe7b37d-6c77-4548-8705-0ef5c67c5276	true	introspection.token.claim
ffe7b37d-6c77-4548-8705-0ef5c67c5276	true	userinfo.token.claim
ffe7b37d-6c77-4548-8705-0ef5c67c5276	birthdate	user.attribute
ffe7b37d-6c77-4548-8705-0ef5c67c5276	true	id.token.claim
ffe7b37d-6c77-4548-8705-0ef5c67c5276	true	access.token.claim
ffe7b37d-6c77-4548-8705-0ef5c67c5276	birthdate	claim.name
ffe7b37d-6c77-4548-8705-0ef5c67c5276	String	jsonType.label
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	true	introspection.token.claim
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	true	userinfo.token.claim
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	emailVerified	user.attribute
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	true	id.token.claim
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	true	access.token.claim
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	email_verified	claim.name
59f7c69c-c31c-4d06-9e9d-0b7cfd29f5b7	boolean	jsonType.label
6885e7d1-d15f-4321-a8a0-0134cf9349b8	true	introspection.token.claim
6885e7d1-d15f-4321-a8a0-0134cf9349b8	true	userinfo.token.claim
6885e7d1-d15f-4321-a8a0-0134cf9349b8	email	user.attribute
6885e7d1-d15f-4321-a8a0-0134cf9349b8	true	id.token.claim
6885e7d1-d15f-4321-a8a0-0134cf9349b8	true	access.token.claim
6885e7d1-d15f-4321-a8a0-0134cf9349b8	email	claim.name
6885e7d1-d15f-4321-a8a0-0134cf9349b8	String	jsonType.label
46eec94b-bae4-49f5-b248-feb7dab9cc22	formatted	user.attribute.formatted
46eec94b-bae4-49f5-b248-feb7dab9cc22	country	user.attribute.country
46eec94b-bae4-49f5-b248-feb7dab9cc22	true	introspection.token.claim
46eec94b-bae4-49f5-b248-feb7dab9cc22	postal_code	user.attribute.postal_code
46eec94b-bae4-49f5-b248-feb7dab9cc22	true	userinfo.token.claim
46eec94b-bae4-49f5-b248-feb7dab9cc22	street	user.attribute.street
46eec94b-bae4-49f5-b248-feb7dab9cc22	true	id.token.claim
46eec94b-bae4-49f5-b248-feb7dab9cc22	region	user.attribute.region
46eec94b-bae4-49f5-b248-feb7dab9cc22	true	access.token.claim
46eec94b-bae4-49f5-b248-feb7dab9cc22	locality	user.attribute.locality
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	true	introspection.token.claim
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	true	userinfo.token.claim
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	phoneNumber	user.attribute
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	true	id.token.claim
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	true	access.token.claim
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	phone_number	claim.name
8168f9ca-6464-4ce0-899c-7b3d0ed9b0d2	String	jsonType.label
e75189e8-efb6-4028-8dc7-1c0d90735562	true	introspection.token.claim
e75189e8-efb6-4028-8dc7-1c0d90735562	true	userinfo.token.claim
e75189e8-efb6-4028-8dc7-1c0d90735562	phoneNumberVerified	user.attribute
e75189e8-efb6-4028-8dc7-1c0d90735562	true	id.token.claim
e75189e8-efb6-4028-8dc7-1c0d90735562	true	access.token.claim
e75189e8-efb6-4028-8dc7-1c0d90735562	phone_number_verified	claim.name
e75189e8-efb6-4028-8dc7-1c0d90735562	boolean	jsonType.label
2e5b5c5f-fe6e-4e4d-a891-cfbf8dd2187b	true	introspection.token.claim
2e5b5c5f-fe6e-4e4d-a891-cfbf8dd2187b	true	access.token.claim
71eae4ef-e3a6-476a-9011-dc8c6d02e712	true	introspection.token.claim
71eae4ef-e3a6-476a-9011-dc8c6d02e712	true	multivalued
71eae4ef-e3a6-476a-9011-dc8c6d02e712	foo	user.attribute
71eae4ef-e3a6-476a-9011-dc8c6d02e712	true	access.token.claim
71eae4ef-e3a6-476a-9011-dc8c6d02e712	resource_access.${client_id}.roles	claim.name
71eae4ef-e3a6-476a-9011-dc8c6d02e712	String	jsonType.label
e62a5e05-8032-4832-9531-1210659afae1	true	introspection.token.claim
e62a5e05-8032-4832-9531-1210659afae1	true	multivalued
e62a5e05-8032-4832-9531-1210659afae1	foo	user.attribute
e62a5e05-8032-4832-9531-1210659afae1	true	access.token.claim
e62a5e05-8032-4832-9531-1210659afae1	realm_access.roles	claim.name
e62a5e05-8032-4832-9531-1210659afae1	String	jsonType.label
fa0f653c-d85e-49b2-8efb-d82f4ddc7a5c	true	introspection.token.claim
fa0f653c-d85e-49b2-8efb-d82f4ddc7a5c	true	access.token.claim
5eb5b849-0244-4cc3-afec-182e67fb8e32	true	introspection.token.claim
5eb5b849-0244-4cc3-afec-182e67fb8e32	true	multivalued
5eb5b849-0244-4cc3-afec-182e67fb8e32	foo	user.attribute
5eb5b849-0244-4cc3-afec-182e67fb8e32	true	id.token.claim
5eb5b849-0244-4cc3-afec-182e67fb8e32	true	access.token.claim
5eb5b849-0244-4cc3-afec-182e67fb8e32	groups	claim.name
5eb5b849-0244-4cc3-afec-182e67fb8e32	String	jsonType.label
abd064b9-f651-4c62-b4ca-553761dd7e90	true	introspection.token.claim
abd064b9-f651-4c62-b4ca-553761dd7e90	true	userinfo.token.claim
abd064b9-f651-4c62-b4ca-553761dd7e90	username	user.attribute
abd064b9-f651-4c62-b4ca-553761dd7e90	true	id.token.claim
abd064b9-f651-4c62-b4ca-553761dd7e90	true	access.token.claim
abd064b9-f651-4c62-b4ca-553761dd7e90	upn	claim.name
abd064b9-f651-4c62-b4ca-553761dd7e90	String	jsonType.label
c834f104-5b67-4366-8a91-c74c11b8e8aa	true	introspection.token.claim
c834f104-5b67-4366-8a91-c74c11b8e8aa	true	id.token.claim
c834f104-5b67-4366-8a91-c74c11b8e8aa	true	access.token.claim
5622c733-cdf1-4554-8f69-b51d3f70fbf2	false	single
5622c733-cdf1-4554-8f69-b51d3f70fbf2	Basic	attribute.nameformat
5622c733-cdf1-4554-8f69-b51d3f70fbf2	Role	attribute.name
310b6954-07b5-4800-ada4-b9fd53e05b25	true	introspection.token.claim
310b6954-07b5-4800-ada4-b9fd53e05b25	true	userinfo.token.claim
310b6954-07b5-4800-ada4-b9fd53e05b25	true	id.token.claim
310b6954-07b5-4800-ada4-b9fd53e05b25	true	access.token.claim
36a876a9-5063-4849-8945-e2c5a417dcbf	true	introspection.token.claim
36a876a9-5063-4849-8945-e2c5a417dcbf	true	userinfo.token.claim
36a876a9-5063-4849-8945-e2c5a417dcbf	lastName	user.attribute
36a876a9-5063-4849-8945-e2c5a417dcbf	true	id.token.claim
36a876a9-5063-4849-8945-e2c5a417dcbf	true	access.token.claim
36a876a9-5063-4849-8945-e2c5a417dcbf	family_name	claim.name
36a876a9-5063-4849-8945-e2c5a417dcbf	String	jsonType.label
46debbbd-c31c-493f-88ee-e05d39456b66	true	introspection.token.claim
46debbbd-c31c-493f-88ee-e05d39456b66	true	userinfo.token.claim
46debbbd-c31c-493f-88ee-e05d39456b66	gender	user.attribute
46debbbd-c31c-493f-88ee-e05d39456b66	true	id.token.claim
46debbbd-c31c-493f-88ee-e05d39456b66	true	access.token.claim
46debbbd-c31c-493f-88ee-e05d39456b66	gender	claim.name
46debbbd-c31c-493f-88ee-e05d39456b66	String	jsonType.label
47f9f4ab-96a8-42bd-91a9-10dc617442a9	true	introspection.token.claim
47f9f4ab-96a8-42bd-91a9-10dc617442a9	true	userinfo.token.claim
47f9f4ab-96a8-42bd-91a9-10dc617442a9	birthdate	user.attribute
47f9f4ab-96a8-42bd-91a9-10dc617442a9	true	id.token.claim
47f9f4ab-96a8-42bd-91a9-10dc617442a9	true	access.token.claim
47f9f4ab-96a8-42bd-91a9-10dc617442a9	birthdate	claim.name
47f9f4ab-96a8-42bd-91a9-10dc617442a9	String	jsonType.label
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	true	introspection.token.claim
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	true	userinfo.token.claim
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	firstName	user.attribute
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	true	id.token.claim
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	true	access.token.claim
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	given_name	claim.name
553f2cfa-126d-4ae0-b9bf-8c2944ad9d8d	String	jsonType.label
6420182f-40f5-4735-9038-fd80a2ae5517	true	introspection.token.claim
6420182f-40f5-4735-9038-fd80a2ae5517	true	userinfo.token.claim
6420182f-40f5-4735-9038-fd80a2ae5517	picture	user.attribute
6420182f-40f5-4735-9038-fd80a2ae5517	true	id.token.claim
6420182f-40f5-4735-9038-fd80a2ae5517	true	access.token.claim
6420182f-40f5-4735-9038-fd80a2ae5517	picture	claim.name
6420182f-40f5-4735-9038-fd80a2ae5517	String	jsonType.label
65e97f65-1fcd-453a-b3af-271cde9e3a44	true	introspection.token.claim
65e97f65-1fcd-453a-b3af-271cde9e3a44	true	userinfo.token.claim
65e97f65-1fcd-453a-b3af-271cde9e3a44	username	user.attribute
65e97f65-1fcd-453a-b3af-271cde9e3a44	true	id.token.claim
65e97f65-1fcd-453a-b3af-271cde9e3a44	true	access.token.claim
65e97f65-1fcd-453a-b3af-271cde9e3a44	preferred_username	claim.name
65e97f65-1fcd-453a-b3af-271cde9e3a44	String	jsonType.label
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	true	introspection.token.claim
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	true	userinfo.token.claim
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	website	user.attribute
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	true	id.token.claim
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	true	access.token.claim
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	website	claim.name
81a2cdb7-2fa9-476c-96c6-4b3fb89ae4bc	String	jsonType.label
895620d3-8090-4724-b389-829e88140554	true	introspection.token.claim
895620d3-8090-4724-b389-829e88140554	true	userinfo.token.claim
895620d3-8090-4724-b389-829e88140554	nickname	user.attribute
895620d3-8090-4724-b389-829e88140554	true	id.token.claim
895620d3-8090-4724-b389-829e88140554	true	access.token.claim
895620d3-8090-4724-b389-829e88140554	nickname	claim.name
895620d3-8090-4724-b389-829e88140554	String	jsonType.label
b29c6db7-edd6-41c7-aa06-be35f0a51692	true	introspection.token.claim
b29c6db7-edd6-41c7-aa06-be35f0a51692	true	userinfo.token.claim
b29c6db7-edd6-41c7-aa06-be35f0a51692	updatedAt	user.attribute
b29c6db7-edd6-41c7-aa06-be35f0a51692	true	id.token.claim
b29c6db7-edd6-41c7-aa06-be35f0a51692	true	access.token.claim
b29c6db7-edd6-41c7-aa06-be35f0a51692	updated_at	claim.name
b29c6db7-edd6-41c7-aa06-be35f0a51692	long	jsonType.label
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	true	introspection.token.claim
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	true	userinfo.token.claim
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	profile	user.attribute
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	true	id.token.claim
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	true	access.token.claim
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	profile	claim.name
d20ea998-dd26-4819-b1e7-b4b26b3df6ec	String	jsonType.label
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	true	introspection.token.claim
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	true	userinfo.token.claim
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	locale	user.attribute
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	true	id.token.claim
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	true	access.token.claim
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	locale	claim.name
d3c844ad-6d7f-47c3-9c52-d80e1766cd4d	String	jsonType.label
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	true	introspection.token.claim
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	true	userinfo.token.claim
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	middleName	user.attribute
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	true	id.token.claim
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	true	access.token.claim
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	middle_name	claim.name
d61c62e3-7dfc-4db2-80ee-e25b03d8c828	String	jsonType.label
eff66991-1235-4983-808a-a37c430cbb7c	true	introspection.token.claim
eff66991-1235-4983-808a-a37c430cbb7c	true	userinfo.token.claim
eff66991-1235-4983-808a-a37c430cbb7c	zoneinfo	user.attribute
eff66991-1235-4983-808a-a37c430cbb7c	true	id.token.claim
eff66991-1235-4983-808a-a37c430cbb7c	true	access.token.claim
eff66991-1235-4983-808a-a37c430cbb7c	zoneinfo	claim.name
eff66991-1235-4983-808a-a37c430cbb7c	String	jsonType.label
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	true	introspection.token.claim
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	true	userinfo.token.claim
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	emailVerified	user.attribute
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	true	id.token.claim
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	true	access.token.claim
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	email_verified	claim.name
86aab39d-74d3-4d9b-ac7b-2994eb7b60b2	boolean	jsonType.label
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	true	introspection.token.claim
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	true	userinfo.token.claim
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	email	user.attribute
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	true	id.token.claim
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	true	access.token.claim
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	email	claim.name
dc7408c2-78dd-48b3-836d-05eeeb69bdb6	String	jsonType.label
7dd74163-2ca4-4831-9987-cdee09643936	formatted	user.attribute.formatted
7dd74163-2ca4-4831-9987-cdee09643936	country	user.attribute.country
7dd74163-2ca4-4831-9987-cdee09643936	true	introspection.token.claim
7dd74163-2ca4-4831-9987-cdee09643936	postal_code	user.attribute.postal_code
7dd74163-2ca4-4831-9987-cdee09643936	true	userinfo.token.claim
7dd74163-2ca4-4831-9987-cdee09643936	street	user.attribute.street
7dd74163-2ca4-4831-9987-cdee09643936	true	id.token.claim
7dd74163-2ca4-4831-9987-cdee09643936	region	user.attribute.region
7dd74163-2ca4-4831-9987-cdee09643936	true	access.token.claim
7dd74163-2ca4-4831-9987-cdee09643936	locality	user.attribute.locality
cedd0af9-80c3-4fad-8035-a60d91ef42a3	true	introspection.token.claim
cedd0af9-80c3-4fad-8035-a60d91ef42a3	true	userinfo.token.claim
cedd0af9-80c3-4fad-8035-a60d91ef42a3	phoneNumber	user.attribute
cedd0af9-80c3-4fad-8035-a60d91ef42a3	true	id.token.claim
cedd0af9-80c3-4fad-8035-a60d91ef42a3	true	access.token.claim
cedd0af9-80c3-4fad-8035-a60d91ef42a3	phone_number	claim.name
cedd0af9-80c3-4fad-8035-a60d91ef42a3	String	jsonType.label
eaacc593-8f48-44be-a9dc-c6e037ade5fe	true	introspection.token.claim
eaacc593-8f48-44be-a9dc-c6e037ade5fe	true	userinfo.token.claim
eaacc593-8f48-44be-a9dc-c6e037ade5fe	phoneNumberVerified	user.attribute
eaacc593-8f48-44be-a9dc-c6e037ade5fe	true	id.token.claim
eaacc593-8f48-44be-a9dc-c6e037ade5fe	true	access.token.claim
eaacc593-8f48-44be-a9dc-c6e037ade5fe	phone_number_verified	claim.name
eaacc593-8f48-44be-a9dc-c6e037ade5fe	boolean	jsonType.label
3f8d85a7-829d-41d9-8b35-29efd6a371a5	true	introspection.token.claim
3f8d85a7-829d-41d9-8b35-29efd6a371a5	true	multivalued
3f8d85a7-829d-41d9-8b35-29efd6a371a5	foo	user.attribute
3f8d85a7-829d-41d9-8b35-29efd6a371a5	true	access.token.claim
3f8d85a7-829d-41d9-8b35-29efd6a371a5	resource_access.${client_id}.roles	claim.name
3f8d85a7-829d-41d9-8b35-29efd6a371a5	String	jsonType.label
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	true	introspection.token.claim
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	true	multivalued
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	foo	user.attribute
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	true	access.token.claim
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	realm_access.roles	claim.name
3fbd2c62-ecca-4b87-a7bd-748f4b1f5d31	String	jsonType.label
40835769-83d5-48fd-95e1-df2b5a1b9287	true	introspection.token.claim
40835769-83d5-48fd-95e1-df2b5a1b9287	true	access.token.claim
2c954381-1330-4251-93c1-fd7474ebc169	true	introspection.token.claim
2c954381-1330-4251-93c1-fd7474ebc169	true	access.token.claim
076a979a-68e4-4982-b0c9-7ffaff893caa	true	introspection.token.claim
076a979a-68e4-4982-b0c9-7ffaff893caa	true	userinfo.token.claim
076a979a-68e4-4982-b0c9-7ffaff893caa	username	user.attribute
076a979a-68e4-4982-b0c9-7ffaff893caa	true	id.token.claim
076a979a-68e4-4982-b0c9-7ffaff893caa	true	access.token.claim
076a979a-68e4-4982-b0c9-7ffaff893caa	upn	claim.name
076a979a-68e4-4982-b0c9-7ffaff893caa	String	jsonType.label
8613d991-f528-45e4-bc6a-3a4aa55fac83	true	introspection.token.claim
8613d991-f528-45e4-bc6a-3a4aa55fac83	true	multivalued
8613d991-f528-45e4-bc6a-3a4aa55fac83	foo	user.attribute
8613d991-f528-45e4-bc6a-3a4aa55fac83	true	id.token.claim
8613d991-f528-45e4-bc6a-3a4aa55fac83	true	access.token.claim
8613d991-f528-45e4-bc6a-3a4aa55fac83	groups	claim.name
8613d991-f528-45e4-bc6a-3a4aa55fac83	String	jsonType.label
acac2399-c7cf-41ed-94fe-b85be8919ecf	true	introspection.token.claim
acac2399-c7cf-41ed-94fe-b85be8919ecf	true	id.token.claim
acac2399-c7cf-41ed-94fe-b85be8919ecf	true	access.token.claim
ef9fd5de-0760-464f-9565-8d67b702912c	true	introspection.token.claim
ef9fd5de-0760-464f-9565-8d67b702912c	true	userinfo.token.claim
ef9fd5de-0760-464f-9565-8d67b702912c	locale	user.attribute
ef9fd5de-0760-464f-9565-8d67b702912c	true	id.token.claim
ef9fd5de-0760-464f-9565-8d67b702912c	true	access.token.claim
ef9fd5de-0760-464f-9565-8d67b702912c	locale	claim.name
ef9fd5de-0760-464f-9565-8d67b702912c	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
f3ec96da-52ff-4e0c-97c3-b10293c3178a	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	a37426d1-c5b6-46ad-9e14-166ceb67dd49	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	bed257a7-cdce-4d79-a563-0373b98b6f90	3bc9b61c-c75f-4697-81aa-a9e75b1f84d1	e98b5229-fb28-49e5-8881-377451281e0a	d284799a-9967-406b-8b4d-4e12be31672e	f68b9f26-a31b-41cc-a0c7-a93115863f46	2592000	f	900	t	f	c9d93933-0df6-468d-8aa8-011bd3b38193	0	f	0	0	cd69eb71-2b18-486a-b1f5-ec6438353a3a
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	60	300	3600	\N	\N	\N	t	f	0	expense-theme	expense-realm	0	\N	f	f	t	f	NONE	1800	36000	f	f	3cd3ffa0-6e01-4708-8246-0a33f92e83cb	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	971aa8b4-4db8-4234-8e5d-8ff6c7e608e3	46146890-653a-4851-9c0e-7136ce92bfa8	291f1132-ee3b-4909-a654-10add63e45e4	b44dcb42-c843-494e-8221-7885f67cee6d	1359f6d4-0faf-413e-955e-697082781878	2592000	f	900	t	f	48884360-926c-44f7-ad35-e2520efdc8b5	0	f	0	0	684569f9-94cc-4ccc-b35a-9e5a41622c60
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	f3ec96da-52ff-4e0c-97c3-b10293c3178a	
_browser_header.xContentTypeOptions	f3ec96da-52ff-4e0c-97c3-b10293c3178a	nosniff
_browser_header.referrerPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	no-referrer
_browser_header.xRobotsTag	f3ec96da-52ff-4e0c-97c3-b10293c3178a	none
_browser_header.xFrameOptions	f3ec96da-52ff-4e0c-97c3-b10293c3178a	SAMEORIGIN
_browser_header.contentSecurityPolicy	f3ec96da-52ff-4e0c-97c3-b10293c3178a	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	f3ec96da-52ff-4e0c-97c3-b10293c3178a	1; mode=block
_browser_header.strictTransportSecurity	f3ec96da-52ff-4e0c-97c3-b10293c3178a	max-age=31536000; includeSubDomains
bruteForceProtected	f3ec96da-52ff-4e0c-97c3-b10293c3178a	false
permanentLockout	f3ec96da-52ff-4e0c-97c3-b10293c3178a	false
maxFailureWaitSeconds	f3ec96da-52ff-4e0c-97c3-b10293c3178a	900
minimumQuickLoginWaitSeconds	f3ec96da-52ff-4e0c-97c3-b10293c3178a	60
waitIncrementSeconds	f3ec96da-52ff-4e0c-97c3-b10293c3178a	60
quickLoginCheckMilliSeconds	f3ec96da-52ff-4e0c-97c3-b10293c3178a	1000
maxDeltaTimeSeconds	f3ec96da-52ff-4e0c-97c3-b10293c3178a	43200
failureFactor	f3ec96da-52ff-4e0c-97c3-b10293c3178a	30
realmReusableOtpCode	f3ec96da-52ff-4e0c-97c3-b10293c3178a	false
displayName	f3ec96da-52ff-4e0c-97c3-b10293c3178a	Keycloak
displayNameHtml	f3ec96da-52ff-4e0c-97c3-b10293c3178a	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	f3ec96da-52ff-4e0c-97c3-b10293c3178a	RS256
offlineSessionMaxLifespanEnabled	f3ec96da-52ff-4e0c-97c3-b10293c3178a	false
offlineSessionMaxLifespan	f3ec96da-52ff-4e0c-97c3-b10293c3178a	5184000
_browser_header.contentSecurityPolicyReportOnly	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	
_browser_header.xContentTypeOptions	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	nosniff
_browser_header.referrerPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	no-referrer
_browser_header.xRobotsTag	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	none
_browser_header.xFrameOptions	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	SAMEORIGIN
_browser_header.contentSecurityPolicy	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	1; mode=block
_browser_header.strictTransportSecurity	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	max-age=31536000; includeSubDomains
permanentLockout	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	false
maxFailureWaitSeconds	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	900
minimumQuickLoginWaitSeconds	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	60
waitIncrementSeconds	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	60
quickLoginCheckMilliSeconds	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	1000
maxDeltaTimeSeconds	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	43200
failureFactor	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	30
realmReusableOtpCode	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	false
displayName	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	Expense Manager
defaultSignatureAlgorithm	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	RS256
bruteForceProtected	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	true
offlineSessionMaxLifespanEnabled	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	false
offlineSessionMaxLifespan	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	5184000
actionTokenGeneratedByAdminLifespan	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	43200
actionTokenGeneratedByUserLifespan	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	300
oauth2DeviceCodeLifespan	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	600
oauth2DevicePollingInterval	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	5
webAuthnPolicyRpEntityName	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	keycloak
webAuthnPolicySignatureAlgorithms	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	ES256
webAuthnPolicyRpId	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	
webAuthnPolicyAttestationConveyancePreference	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyAuthenticatorAttachment	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyRequireResidentKey	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyUserVerificationRequirement	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyCreateTimeout	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0
webAuthnPolicyAvoidSameAuthenticatorRegister	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	false
webAuthnPolicyRpEntityNamePasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	ES256
webAuthnPolicyRpIdPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	
webAuthnPolicyAttestationConveyancePreferencePasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyRequireResidentKeyPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	not specified
webAuthnPolicyCreateTimeoutPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	false
cibaBackchannelTokenDeliveryMode	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	poll
cibaExpiresIn	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	120
cibaInterval	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	5
cibaAuthRequestedUserHint	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	login_hint
parRequestUriLifespan	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
f3ec96da-52ff-4e0c-97c3-b10293c3178a	jboss-logging
6cc40e8a-5d10-47ac-ae6d-17dd0f179374	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	f3ec96da-52ff-4e0c-97c3-b10293c3178a
password	password	t	t	6cc40e8a-5d10-47ac-ae6d-17dd0f179374
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
e5f26731-8a53-47d8-b3b0-a4652e7901bd	/realms/master/account/*
ea0eeca3-09be-401e-96f5-de1afe33a003	/realms/master/account/*
05fe4b80-4863-4f01-9e25-57230393a8de	/admin/master/console/*
3f75d006-a362-47c3-b3a9-662b7e19cf93	/realms/expense-realm/account/*
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	/realms/expense-realm/account/*
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	/admin/expense-realm/console/*
a4626817-1f5a-4f68-89cf-002d648111d2	http://localhost:3000/*
a4626817-1f5a-4f68-89cf-002d648111d2	http://localhost/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
f6829683-4e06-4155-9297-33740e6abd45	VERIFY_EMAIL	Verify Email	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	VERIFY_EMAIL	50
de973f5b-bb85-43f3-8aef-0a6f281ffe94	UPDATE_PROFILE	Update Profile	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	UPDATE_PROFILE	40
fcde4647-e629-4369-8817-e4d63f72b1c9	CONFIGURE_TOTP	Configure OTP	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	CONFIGURE_TOTP	10
b896a73f-704c-47a7-bd56-41f508d062dd	UPDATE_PASSWORD	Update Password	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	UPDATE_PASSWORD	30
d06dd861-2aa8-453b-ab96-fc1e9fb7860d	TERMS_AND_CONDITIONS	Terms and Conditions	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	f	TERMS_AND_CONDITIONS	20
700db268-abaf-4e68-940e-8dca5a8c5027	delete_account	Delete Account	f3ec96da-52ff-4e0c-97c3-b10293c3178a	f	f	delete_account	60
8fa0c2be-b79f-4ed9-a400-0347ab9d0ff2	update_user_locale	Update User Locale	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	update_user_locale	1000
67ed42df-f64f-43b7-a1d4-215fd0d99377	webauthn-register	Webauthn Register	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	webauthn-register	70
5a7ba11f-588f-4f1e-8303-4341d82631fe	webauthn-register-passwordless	Webauthn Register Passwordless	f3ec96da-52ff-4e0c-97c3-b10293c3178a	t	f	webauthn-register-passwordless	80
2dae4a8f-cc90-479d-a7ab-e497f8ac26b5	VERIFY_EMAIL	Verify Email	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	VERIFY_EMAIL	50
2628462c-06d0-4a45-8e29-b9ac6faaad82	UPDATE_PROFILE	Update Profile	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	UPDATE_PROFILE	40
42d275b4-aeb9-4ec1-81da-cc93839de98f	CONFIGURE_TOTP	Configure OTP	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	CONFIGURE_TOTP	10
2f358a4a-7dcb-4cab-9681-7cdfeed06160	UPDATE_PASSWORD	Update Password	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	UPDATE_PASSWORD	30
673a6e0c-4cd1-4b9d-8dca-a39d77ca93bb	TERMS_AND_CONDITIONS	Terms and Conditions	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f	f	TERMS_AND_CONDITIONS	20
5f830d7f-bc60-480b-8b2c-2fee3686da6a	delete_account	Delete Account	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	f	f	delete_account	60
9b1af39f-0d54-4e37-94ae-a3455d514c43	update_user_locale	Update User Locale	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	update_user_locale	1000
d20cab21-78a2-408c-83d0-17bf985eafb5	webauthn-register	Webauthn Register	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	webauthn-register	70
c2911faf-13b8-445f-bc26-68a7f50ef6b1	webauthn-register-passwordless	Webauthn Register Passwordless	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	t	f	webauthn-register-passwordless	80
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
ea0eeca3-09be-401e-96f5-de1afe33a003	69ff608b-5ebc-4151-87c4-b3bf6fc637c5
ea0eeca3-09be-401e-96f5-de1afe33a003	ec63b673-6217-4f4c-ad34-911cf74c886e
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	d57421cb-7e4b-4783-a7f4-faaa064c3699
f2e9e6c2-9c55-4c4b-a98f-73a64f2b304b	28778da3-f711-4030-932a-6af4278cacbf
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
a8506192-c274-449a-b7dc-a5d7964d81cb	admin@expense.com	admin@expense.com	t	t	\N	Admin	User	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	admin	\N	\N	0
ffc53aff-5578-4a1d-91c2-387d56779cf8	demo@expense.com	demo@expense.com	t	t	\N	Demo	User	6cc40e8a-5d10-47ac-ae6d-17dd0f179374	demo	\N	\N	0
63a5d56f-8132-41e7-9129-a56a8c876ba7	\N	73e3b901-6533-4272-8b7d-ab4b6240a059	f	t	\N	\N	\N	f3ec96da-52ff-4e0c-97c3-b10293c3178a	admin	1779523711574	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
88d96335-7811-4b8f-9f94-d248c50d3cb3	a8506192-c274-449a-b7dc-a5d7964d81cb
88d96335-7811-4b8f-9f94-d248c50d3cb3	ffc53aff-5578-4a1d-91c2-387d56779cf8
cd69eb71-2b18-486a-b1f5-ec6438353a3a	63a5d56f-8132-41e7-9129-a56a8c876ba7
da7c5567-cfce-4517-9f66-4ca4d900f0f1	63a5d56f-8132-41e7-9129-a56a8c876ba7
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
05fe4b80-4863-4f01-9e25-57230393a8de	+
2be49f93-88ad-4c0f-92f4-bdbf2a8aa4fd	+
a4626817-1f5a-4f68-89cf-002d648111d2	http://localhost
a4626817-1f5a-4f68-89cf-002d648111d2	http://localhost:3000
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: Expenses Expenses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Expenses"
    ADD CONSTRAINT "Expenses_pkey" PRIMARY KEY ("Id");


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY ("Id");


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: IX_Expenses_UserId; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "IX_Expenses_UserId" ON public."Expenses" USING btree ("UserId");


--
-- Name: IX_Users_KeycloakId; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "IX_Users_KeycloakId" ON public."Users" USING btree ("KeycloakId");


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: Expenses FK_Expenses_Users_UserId; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Expenses"
    ADD CONSTRAINT "FK_Expenses_Users_UserId" FOREIGN KEY ("UserId") REFERENCES public."Users"("Id") ON DELETE CASCADE;


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

\unrestrict mt2knAHSlYRU9fSyax5ADaflnsJ6b6egqoUAegLcPOs0HNHwd7JMUuvoehEbYA3

