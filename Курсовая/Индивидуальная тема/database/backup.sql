--
-- PostgreSQL database dump
--

\restrict neIQc7oLaxFVc7RUFsCOSFhc72YX5Q3E7Ue1dBtho717SVl8aLvpmcrpY7AitDj

-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

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

--
-- Name: refresh_client_booking_statistics(refcursor); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.refresh_client_booking_statistics(IN result_cursor refcursor DEFAULT NULL::refcursor)
    LANGUAGE plpgsql
    AS $$
BEGIN
    TRUNCATE TABLE client_booking_statistics RESTART IDENTITY;

    INSERT INTO client_booking_statistics (
        client_id,
        client_name,
        client_phone,
        client_email,
        client_messenger,
        bookings_count,
        last_booking_at,
        calculated_at,
        created_at,
        updated_at
    )
    SELECT
        clients.id AS client_id,
        clients.name AS client_name,
        clients.phone AS client_phone,
        clients.email AS client_email,
        clients.messenger AS client_messenger,
        COUNT(bookings.id)::integer AS bookings_count,
        MAX(bookings.created_at) AS last_booking_at,
        NOW() AS calculated_at,
        NOW() AS created_at,
        NOW() AS updated_at
    FROM clients
    LEFT JOIN bookings ON bookings.client_id = clients.id
    GROUP BY
        clients.id,
        clients.name,
        clients.phone,
        clients.email,
        clients.messenger
    ORDER BY
        COUNT(bookings.id) DESC,
        MAX(bookings.created_at) DESC NULLS LAST,
        clients.name ASC;

    IF result_cursor IS NOT NULL THEN
        OPEN result_cursor FOR
            SELECT
                client_id,
                client_name,
                client_phone,
                client_email,
                client_messenger,
                bookings_count,
                last_booking_at,
                calculated_at
            FROM client_booking_statistics
            ORDER BY
                bookings_count DESC,
                last_booking_at DESC NULLS LAST,
                client_name ASC;
    END IF;
END;
$$;


ALTER PROCEDURE public.refresh_client_booking_statistics(IN result_cursor refcursor) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.booking_items (
    id bigint NOT NULL,
    booking_id bigint NOT NULL,
    service_id bigint NOT NULL,
    tariff_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.booking_items OWNER TO postgres;

--
-- Name: booking_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.booking_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.booking_items_id_seq OWNER TO postgres;

--
-- Name: booking_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.booking_items_id_seq OWNED BY public.booking_items.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    id bigint NOT NULL,
    client_name character varying(255) NOT NULL,
    client_phone character varying(255) NOT NULL,
    client_email character varying(255),
    preferred_at timestamp(0) without time zone,
    comment text,
    status character varying(255) DEFAULT 'new'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    client_id bigint,
    client_messenger character varying(255)
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookings_id_seq OWNER TO postgres;

--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- Name: client_booking_statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_booking_statistics (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    client_name character varying(255) NOT NULL,
    client_phone character varying(255) NOT NULL,
    client_email character varying(255),
    client_messenger character varying(255),
    bookings_count integer DEFAULT 0 NOT NULL,
    last_booking_at timestamp(0) without time zone,
    calculated_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.client_booking_statistics OWNER TO postgres;

--
-- Name: client_booking_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_booking_statistics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_booking_statistics_id_seq OWNER TO postgres;

--
-- Name: client_booking_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_booking_statistics_id_seq OWNED BY public.client_booking_statistics.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clients (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    phone character varying(255) NOT NULL,
    email character varying(255),
    messenger character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.clients OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clients_id_seq OWNER TO postgres;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO postgres;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO postgres;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    short_description character varying(255),
    description text,
    cover_image character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: tariffs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariffs (
    id bigint NOT NULL,
    service_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    price numeric(10,2) NOT NULL,
    old_price numeric(10,2),
    duration_minutes integer,
    photos_count integer,
    description text,
    features text,
    is_popular boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.tariffs OWNER TO postgres;

--
-- Name: tariffs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tariffs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tariffs_id_seq OWNER TO postgres;

--
-- Name: tariffs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tariffs_id_seq OWNED BY public.tariffs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    two_factor_secret text,
    two_factor_recovery_codes text,
    two_factor_confirmed_at timestamp(0) without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: booking_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_items ALTER COLUMN id SET DEFAULT nextval('public.booking_items_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: client_booking_statistics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_booking_statistics ALTER COLUMN id SET DEFAULT nextval('public.client_booking_statistics_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: tariffs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs ALTER COLUMN id SET DEFAULT nextval('public.tariffs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: booking_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.booking_items (id, booking_id, service_id, tariff_id, created_at, updated_at) FROM stdin;
1	4	6	12	2026-05-12 20:36:22	2026-05-13 19:27:21
2	4	4	7	2026-05-12 20:36:22	2026-05-13 19:27:21
3	4	2	3	2026-05-13 19:27:21	2026-05-13 19:27:21
4	5	2	4	2026-05-13 19:34:14	2026-05-13 19:34:14
5	5	6	11	2026-05-13 19:34:14	2026-05-13 19:34:14
6	6	1	2	2026-05-13 19:38:24	2026-05-13 19:38:24
7	6	5	10	2026-05-13 19:38:24	2026-05-13 19:38:24
8	7	2	4	2026-05-13 19:41:25	2026-05-13 19:41:25
9	8	2	3	2026-05-13 19:41:56	2026-05-13 19:41:56
10	8	4	8	2026-05-13 19:41:56	2026-05-13 19:41:56
11	9	7	14	2026-05-13 19:42:22	2026-05-13 19:42:22
12	10	8	15	2026-05-13 19:42:51	2026-05-13 19:42:51
13	11	4	7	2026-05-13 19:43:26	2026-05-13 19:43:26
14	12	2	4	2026-05-13 19:47:54	2026-05-13 19:47:54
15	12	4	7	2026-05-13 19:47:54	2026-05-13 19:47:54
16	13	1	2	2026-05-13 19:48:43	2026-05-13 19:48:43
17	13	7	\N	2026-05-13 19:48:43	2026-05-13 19:48:43
18	14	1	2	2026-05-13 19:50:49	2026-05-13 19:50:49
19	15	1	1	2026-05-13 19:51:37	2026-05-13 19:51:37
20	15	7	14	2026-05-13 19:51:37	2026-05-13 19:51:37
21	16	2	4	2026-05-13 19:52:50	2026-05-13 19:52:50
22	17	2	4	2026-05-13 19:53:58	2026-05-13 19:53:58
23	17	8	15	2026-05-13 19:53:58	2026-05-13 19:53:58
24	18	6	12	2026-05-13 19:55:06	2026-05-13 19:55:06
25	18	2	3	2026-05-13 19:55:06	2026-05-13 19:55:06
26	19	1	1	2026-05-13 19:58:11	2026-05-13 19:58:11
27	19	8	16	2026-05-13 19:58:11	2026-05-13 19:58:11
28	20	1	2	2026-05-13 19:58:55	2026-05-13 19:58:55
29	20	8	15	2026-05-13 19:58:55	2026-05-13 19:58:55
30	21	1	2	2026-05-13 20:00:06	2026-05-13 20:00:06
31	21	7	14	2026-05-13 20:00:06	2026-05-13 20:00:06
32	22	1	2	2026-05-13 20:01:36	2026-05-13 20:01:36
33	22	5	10	2026-05-13 20:01:36	2026-05-13 20:01:36
34	23	8	16	2026-05-13 20:02:37	2026-05-13 20:02:37
35	24	2	4	2026-05-13 20:37:44	2026-05-13 20:37:44
36	24	4	8	2026-05-13 20:37:44	2026-05-13 20:37:44
37	25	2	4	2026-05-14 15:01:01	2026-05-14 15:01:01
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (id, client_name, client_phone, client_email, preferred_at, comment, status, created_at, updated_at, client_id, client_messenger) FROM stdin;
4	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-15 23:36:00	ФФФ	new	2026-05-12 20:36:22	2026-05-12 20:36:22	2	\N
5	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-18 22:34:00	qwe	new	2026-05-13 19:34:14	2026-05-13 19:34:14	2	\N
6	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-05 22:36:00	rty	new	2026-05-13 19:38:24	2026-05-13 19:38:24	3	\N
7	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-08 22:38:00	uio	new	2026-05-13 19:41:25	2026-05-13 19:41:25	2	\N
8	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-22 22:41:00	p[]	new	2026-05-13 19:41:56	2026-05-13 19:41:56	2	\N
9	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-14 22:42:00	asd	new	2026-05-13 19:42:22	2026-05-13 19:42:22	2	\N
10	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-28 22:42:00	fgh	new	2026-05-13 19:42:51	2026-05-13 19:42:51	2	\N
11	Егор	+79254301557	ivanovegor557@gmail.com	2026-05-27 22:43:00	jkl	new	2026-05-13 19:43:26	2026-05-13 19:43:26	2	\N
12	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-11 22:47:00	\N	new	2026-05-13 19:47:54	2026-05-13 19:47:54	3	\N
13	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-18 22:48:00	zxc	new	2026-05-13 19:48:43	2026-05-13 19:48:43	3	\N
14	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-16 22:50:00	cvb	new	2026-05-13 19:50:49	2026-05-13 19:50:49	3	\N
15	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-21 22:51:00	bnm,	new	2026-05-13 19:51:37	2026-05-13 19:51:37	3	\N
17	Никита	+79850636642	Nickitakoz2008@gmail.com	2026-05-19 22:53:00	ghj	new	2026-05-13 19:53:58	2026-05-13 19:53:58	5	@kunzhutnaya_semechka
18	Никита	+79850636642	Nickitakoz2008@gmail.com	2026-05-09 22:55:00	\N	new	2026-05-13 19:55:06	2026-05-13 19:55:06	5	@kunzhutnaya_semechka
19	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-16 22:58:00	kjhgh	new	2026-05-13 19:58:11	2026-05-13 19:58:11	3	\N
20	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-27 22:58:00	dfghbn	new	2026-05-13 19:58:55	2026-05-13 19:58:55	3	\N
21	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-25 22:59:00	dsvchjlk	new	2026-05-13 20:00:06	2026-05-13 20:00:06	3	\N
22	Наталья	+7922098123	Nataliya000@gmail.com	2026-05-28 23:01:00	cvjkfdas	new	2026-05-13 20:01:36	2026-05-13 20:01:36	3	\N
23	Никита	+79850636642	Nickitakoz2008@gmail.com	2026-05-26 23:02:00	sdfgtrhj	new	2026-05-13 20:02:37	2026-05-13 20:02:37	5	@kunzhutnaya_semechka
16	Никита	+79250636642	Nickitakoz2008@gmail.com	2026-05-16 22:52:00	fgh	new	2026-05-13 19:52:50	2026-05-13 20:04:24	4	@kunzhutnaya_semechka
24	Никита	+798506366420	Nickitakoz20080@gmail.com	2026-05-29 23:37:00	dfg	new	2026-05-13 20:37:44	2026-05-13 20:37:44	6	@kunzhutnaya_semechka0
25	Никита	+79850636642	Nickitakoz2008@gmail.com	2026-05-22 18:00:00	sdfghj	new	2026-05-14 15:01:01	2026-05-14 15:01:01	5	@kunzhutnaya_semechka
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab:timer	i:1778798638;	1778798638
laravel-cache-356a192b7913b04c54574d18c28d46e6395428ab	i:1;	1778798638
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: client_booking_statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_booking_statistics (id, client_id, client_name, client_phone, client_email, client_messenger, bookings_count, last_booking_at, calculated_at, created_at, updated_at) FROM stdin;
1	3	Наталья	+7922098123	Nataliya000@gmail.com	\N	9	2026-05-13 20:01:36	2026-05-13 23:38:12	2026-05-13 23:38:12	2026-05-13 23:38:12
2	2	Егор	+79254301557	ivanovegor557@gmail.com	\N	7	2026-05-13 19:43:26	2026-05-13 23:38:12	2026-05-13 23:38:12	2026-05-13 23:38:12
3	5	Никита	+79850636642	Nickitakoz2008@gmail.com	@kunzhutnaya_semechka	3	2026-05-13 20:02:37	2026-05-13 23:38:12	2026-05-13 23:38:12	2026-05-13 23:38:12
4	6	Никита	+798506366420	Nickitakoz20080@gmail.com	@kunzhutnaya_semechka0	1	2026-05-13 20:37:44	2026-05-13 23:38:12	2026-05-13 23:38:12	2026-05-13 23:38:12
5	4	Никита	+79250636642	NikitaKoz2000@gmail.com	\N	1	2026-05-13 19:52:50	2026-05-13 23:38:12	2026-05-13 23:38:12	2026-05-13 23:38:12
\.


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clients (id, name, phone, email, messenger, created_at, updated_at) FROM stdin;
2	Егор	+79254301557	ivanovegor557@gmail.com	\N	2026-05-12 20:36:22	2026-05-12 20:36:22
3	Наталья	+7922098123	Nataliya000@gmail.com	\N	2026-05-13 19:38:24	2026-05-13 19:38:24
4	Никита	+79250636642	NikitaKoz2000@gmail.com	\N	2026-05-13 19:52:50	2026-05-13 19:52:50
5	Никита	+79850636642	Nickitakoz2008@gmail.com	@kunzhutnaya_semechka	2026-05-13 19:53:58	2026-05-13 19:53:58
6	Никита	+798506366420	Nickitakoz20080@gmail.com	@kunzhutnaya_semechka0	2026-05-13 20:37:44	2026-05-13 20:37:44
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2025_08_14_170933_add_two_factor_columns_to_users_table	1
5	2026_05_01_200334_create_services_table	2
6	2026_05_02_154047_create_tariffs_table	3
7	2026_05_03_204814_create_bookings_table	4
8	2026_05_12_200822_create_clients_table	5
9	2026_05_12_200833_create_booking_items_table	5
10	2026_05_12_201120_update_bookings_for_clients_and_multiple_services	5
11	2026_05_12_203118_add_client_snapshot_columns_to_bookings_table	6
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, title, slug, short_description, description, cover_image, is_active, sort_order, created_at, updated_at) FROM stdin;
2	 Мужская фотосъёмка	 muzhskaya-fotosyomka	 Портретная и деловая съёмка для мужчин.	Студийная фотосессия для личного бренда, соцсетей и портфолио.	\N	t	20	2026-05-01 20:20:54	2026-05-01 20:20:54
3	Детская фотосъёмка	detskaya-fotosyomka	Портретная и игровая съёмка для детей.	Яркая и естественная фотосессия для детей в студии или на улице с учётом возраста, эмоций и подвижных игр.	\N	t	30	2026-05-02 15:12:43	2026-05-02 15:18:06
4	Лукбук	lukbuk	Фотосъёмка капсулы и коллекции одежды.	Профессиональная съёмка луков для бренда, магазина или портфолио дизайнера. Чистый фон, продуманный свет и акцент на деталях одежды.	\N	t	40	2026-05-02 15:20:55	2026-05-02 15:20:55
5	Имиджевая фотосъёмка	imidzhevaya-fotosyomka	Создание визуального образа для личного бренда.	Профессиональная съёмка, раскрывающая ваш стиль, характер и статус. Помогает сформировать нужное впечатление для соцсетей, сайта или делового портфолио.	\N	t	50	2026-05-02 15:22:44	2026-05-02 15:22:44
6	Стрит-фотосъёмка	street-fotosyomka	Динамичная съёмка на городских улицах.	Естественная, живая фотосессия в урбанистической среде. Без постановки — только настоящие эмоции, движение и ритм города. Идеально для соцсетей, лукбуков и создания современного образа.	\N	t	60	2026-05-02 15:24:31	2026-05-02 15:24:31
7	Видеосъёмка	videosyomka	Динамичные ролики для соцсетей и бизнеса.	Профессиональная съёмка видео под любые задачи: короткие ролики для Reels, TikTok, Youtube, интервью, презентации или видео для личного бренда. Чистая картинка, качественный звук и продуманный монтаж.	\N	t	70	2026-05-02 15:25:49	2026-05-02 15:25:49
8	Инфографика	infografika	Визуализация данных для блога и бизнеса.	Создание понятной и стильной инфографики для соцсетей, презентаций, отчётов и обучения. Превращаем цифры, процессы и идеи в ёмкие визуальные образы, которые легко читаются и запоминаются.\n	\N	t	80	2026-05-02 15:38:20	2026-05-02 15:38:20
9	Тестовая услуга SQL	testovaya-usluga-sql	Услуга добавлена SQL-командой.	Эта запись создана напрямую через INSERT.	\N	t	100	2026-05-13 11:51:47	2026-05-13 11:51:47
1	Женская фотосъёмка	zhenskaya-fotosyomka	Портретная и имиджевая съёмка для девушек.	Индивидуальная фотосессия в студии с подбором образа, света и фона.	services/01KRMAGQKJAFHKFJAJHCCS3QQN.jpg	t	10	2026-05-01 20:19:06	2026-05-14 22:43:03
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
FH8ogxfSRSVocAGQVjWEe3K1kUcClmslpQoLbN2T	1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 YaBrowser/26.4.0.0 Safari/537.36	eyJfdG9rZW4iOiJNWXJtUUtxbG0yWVQwM1BzSTh5R05qdVkydnRYYnZnUlB5QzVCNmFjIiwibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiOjEsIl9wcmV2aW91cyI6eyJ1cmwiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODAwMCIsInJvdXRlIjoiaG9tZSJ9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX0sInBhc3N3b3JkX2hhc2hfd2ViIjoiMjQ2Mjg1MzU3ZTU3Y2U4MmUxYmVjOWE1OTIzYTBmNDA5OGZmNjRmZGViZjFkNTk2OWIyMzgzNDc1MzhhNmM2MyIsInRhYmxlcyI6eyIyODZiZDQwNTRkNzIwYjkyMjkwMjkzZTUxYTIyNjhjZl9jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImlkIiwibGFiZWwiOiJJRCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjbGllbnRfbmFtZSIsImxhYmVsIjoiXHUwNDFhXHUwNDNiXHUwNDM4XHUwNDM1XHUwNDNkXHUwNDQyIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6ImNsaWVudF9waG9uZSIsImxhYmVsIjoiXHUwNDIyXHUwNDM1XHUwNDNiXHUwNDM1XHUwNDQ0XHUwNDNlXHUwNDNkIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6Iml0ZW1zLnNlcnZpY2UudGl0bGUiLCJsYWJlbCI6Ilx1MDQyM1x1MDQ0MVx1MDQzYlx1MDQ0M1x1MDQzM1x1MDQzOCIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJwcmVmZXJyZWRfYXQiLCJsYWJlbCI6Ilx1MDQxNlx1MDQzNVx1MDQzYlx1MDQzMFx1MDQzNVx1MDQzY1x1MDQzMFx1MDQ0ZiBcdTA0MzRcdTA0MzBcdTA0NDJcdTA0MzAiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoic3RhdHVzIiwibGFiZWwiOiJcdTA0MjFcdTA0NDJcdTA0MzBcdTA0NDJcdTA0NDNcdTA0NDEiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiY3JlYXRlZF9hdCIsImxhYmVsIjoiXHUwNDIxXHUwNDNlXHUwNDM3XHUwNDM0XHUwNDMwXHUwNDNkXHUwNDMwIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH1dLCIxNWMxYTIzYjg2NmY0NTA0MjU4ODExY2MyMjJmYjliMF9jb2x1bW5zIjpbeyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InRpdGxlIiwibGFiZWwiOiJUaXRsZSIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJzbHVnIiwibGFiZWwiOiJTbHVnIiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOnRydWUsImlzVG9nZ2xlYWJsZSI6ZmFsc2UsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6bnVsbH0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InNob3J0X2Rlc2NyaXB0aW9uIiwibGFiZWwiOiJTaG9ydCBkZXNjcmlwdGlvbiIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjb3Zlcl9pbWFnZSIsImxhYmVsIjoiQ292ZXIgaW1hZ2UiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoiaXNfYWN0aXZlIiwibGFiZWwiOiJJcyBhY3RpdmUiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6dHJ1ZSwiaXNUb2dnbGVhYmxlIjpmYWxzZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0IjpudWxsfSx7InR5cGUiOiJjb2x1bW4iLCJuYW1lIjoic29ydF9vcmRlciIsImxhYmVsIjoiU29ydCBvcmRlciIsImlzSGlkZGVuIjpmYWxzZSwiaXNUb2dnbGVkIjp0cnVlLCJpc1RvZ2dsZWFibGUiOmZhbHNlLCJpc1RvZ2dsZWRIaWRkZW5CeURlZmF1bHQiOm51bGx9LHsidHlwZSI6ImNvbHVtbiIsIm5hbWUiOiJjcmVhdGVkX2F0IiwibGFiZWwiOiJDcmVhdGVkIGF0IiwiaXNIaWRkZW4iOmZhbHNlLCJpc1RvZ2dsZWQiOmZhbHNlLCJpc1RvZ2dsZWFibGUiOnRydWUsImlzVG9nZ2xlZEhpZGRlbkJ5RGVmYXVsdCI6dHJ1ZX0seyJ0eXBlIjoiY29sdW1uIiwibmFtZSI6InVwZGF0ZWRfYXQiLCJsYWJlbCI6IlVwZGF0ZWQgYXQiLCJpc0hpZGRlbiI6ZmFsc2UsImlzVG9nZ2xlZCI6ZmFsc2UsImlzVG9nZ2xlYWJsZSI6dHJ1ZSwiaXNUb2dnbGVkSGlkZGVuQnlEZWZhdWx0Ijp0cnVlfV19LCJmaWxhbWVudCI6W119	1778798605
\.


--
-- Data for Name: tariffs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tariffs (id, service_id, title, price, old_price, duration_minutes, photos_count, description, features, is_popular, is_active, sort_order, created_at, updated_at) FROM stdin;
2	1	Расширенный	4500.00	5000.00	120	20	Расширенная съёмка с несколькими образами.	- 2 образа\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	t	t	20	2026-05-02 16:19:11	2026-05-02 16:19:11
3	2	Базовый	2500.00	\N	60	10	Индивидуальная студийная фотосессия.	- 1 образ\n- 1 фон\n- 10 фото в цветокоррекции\n- помощь с позированием	f	t	30	2026-05-02 16:24:00	2026-05-02 16:24:46
4	2	Расширенный	4500.00	5000.00	120	20	Расширенная фотосъёмка с несколькими образами	- 2 образа\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	t	t	40	2026-05-02 16:27:06	2026-05-02 16:27:54
5	3	Базовый	3500.00	\N	60	10	Индивидуальная студийная фотосессия.	- 1 образ\n- 1 фон\n- 10 фото в цветокоррекции\n- помощь с позированием	f	t	50	2026-05-02 16:29:03	2026-05-02 16:30:28
6	3	Расширенный	5500.00	6000.00	120	20	Расширенная фотосъёмка с несколькими образами	- 2 образа\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	t	t	60	2026-05-02 16:31:53	2026-05-02 16:32:23
7	4	Базовый	3000.00	\N	60	10	Индивидуальная студийная фотосессия.	- 10 образов\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	f	t	70	2026-05-02 16:36:57	2026-05-02 16:36:57
8	4	Расширенный	5000.00	5500.00	120	20	Расширенная фотосъёмка с несколькими образами	- 20 образов\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	t	t	80	2026-05-02 16:38:31	2026-05-02 16:38:31
9	5	Базовый	2500.00	\N	60	10	Индивидуальная студийная фотосессия.	- 1 образ\n- 1 фон\n- 10 фото в цветокоррекции\n- помощь с позированием	f	t	90	2026-05-02 16:39:58	2026-05-02 16:39:58
11	6	Базовый	3500.00	\N	80	10	Индивидуальная уличная фотосессия.	- 1 образ\n- 1 фон\n- 10 фото в цветокоррекции\n- помощь с позированием	f	t	110	2026-05-02 16:44:29	2026-05-02 16:44:29
12	6	Расширенный	5500.00	6000.00	160	20	Расширенная уличная фотосъёмка с несколькими образами	- 2 образа\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	t	t	120	2026-05-02 16:46:06	2026-05-02 16:46:06
13	7	Базовый	4500.00	\N	100	\N	Индивидуальная студийная видеосъёмка	- 1 образ\n- 1 фон\n- 60 минут готового ролика в цветокоррекции\n- помощь с позированием и движением\n- запись звука (опционально)	f	t	130	2026-05-02 16:52:43	2026-05-02 16:52:43
14	7	Расширенный	7500.00	9000.00	200	\N	Расширенная видеосъёмка с несколькими образами	- 2 образа\n- 2 фона\n- 120 минут готового ролика в цветокоррекции\n- помощь с позированием и движением\n- запись звука (опционально)	t	t	140	2026-05-02 16:54:37	2026-05-02 16:54:37
15	8	Базовый	7500.00	\N	60	10	 Создание информационной графики на основе ваших данных.	- 10 готовых макетов инфографики\n- до 3 блоков данных / иконок\n- 2 варианта цветовой схемы на выбор\n- до 3 правок в рамках макета\n- финальные файлы: PNG, JPG, PDF, исходник (при необходимости)	f	t	140	2026-05-02 16:57:35	2026-05-02 16:57:35
16	8	Расширенный	10000.00	12000.00	120	20	Расширенное создание информационной графики на основе ваших данных.	- 20 готовых макетов инфографики\n- до 6 блоков данных / иконок\n- 6 вариантов цветовой схемы на выбор\n- до 5 правок в рамках макета\n- финальные файлы: PNG, JPG, PDF, исходник (при необходимости)	t	t	150	2026-05-02 17:00:03	2026-05-02 17:00:03
1	1	Базовый	2500.00	\N	60	10	Индивидуальная студийная фотосессия.	- 1 образ\n- 1 фон\n- 10 фото в цветокоррекции\n- помощь с позированием	f	t	10	2026-05-02 16:15:34	2026-05-06 12:39:49
10	5	Расширенный	5000.00	5500.00	120	20	Расширенная фотосъёмка с несколькими образами	- 2 образа\n- 2 фона\n- 20 фото в цветокоррекции\n- 5 фото с ретушью\n- помощь с позированием	t	t	100	2026-05-02 16:40:50	2026-05-02 17:32:53
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, two_factor_secret, two_factor_recovery_codes, two_factor_confirmed_at) FROM stdin;
1	egor	ivanovegor557@gmail.com	\N	$2y$12$TsVjhgzNc9/H.sgXYCG12uGbHCt29.8dnOJNOBGOrJN7syyOZB9bu	4so0HalVNujFULUacyahpSRLU2rqVjw3u9qFweppEJEKfQ2VPoqKN0djNYKK	2026-05-01 19:18:14	2026-05-01 19:18:14	\N	\N	\N
\.


--
-- Name: booking_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.booking_items_id_seq', 37, true);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_id_seq', 25, true);


--
-- Name: client_booking_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_booking_statistics_id_seq', 5, true);


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clients_id_seq', 6, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 11, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 9, true);


--
-- Name: tariffs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tariffs_id_seq', 16, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: booking_items booking_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: client_booking_statistics client_booking_statistics_client_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_booking_statistics
    ADD CONSTRAINT client_booking_statistics_client_id_key UNIQUE (client_id);


--
-- Name: client_booking_statistics client_booking_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_booking_statistics
    ADD CONSTRAINT client_booking_statistics_pkey PRIMARY KEY (id);


--
-- Name: clients clients_phone_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_phone_unique UNIQUE (phone);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: services services_slug_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_slug_unique UNIQUE (slug);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: tariffs tariffs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs
    ADD CONSTRAINT tariffs_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: booking_items booking_items_booking_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_booking_id_foreign FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: booking_items booking_items_service_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_service_id_foreign FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: booking_items booking_items_tariff_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.booking_items
    ADD CONSTRAINT booking_items_tariff_id_foreign FOREIGN KEY (tariff_id) REFERENCES public.tariffs(id) ON DELETE SET NULL;


--
-- Name: bookings bookings_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_client_id_foreign FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE SET NULL;


--
-- Name: client_booking_statistics client_booking_statistics_client_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_booking_statistics
    ADD CONSTRAINT client_booking_statistics_client_id_fkey FOREIGN KEY (client_id) REFERENCES public.clients(id) ON DELETE CASCADE;


--
-- Name: tariffs tariffs_service_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariffs
    ADD CONSTRAINT tariffs_service_id_foreign FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict neIQc7oLaxFVc7RUFsCOSFhc72YX5Q3E7Ue1dBtho717SVl8aLvpmcrpY7AitDj

