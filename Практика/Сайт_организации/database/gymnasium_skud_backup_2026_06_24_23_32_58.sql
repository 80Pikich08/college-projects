--
-- PostgreSQL database dump
--

\restrict gB20BsOreTK5d07mwNwtHpvgmZcqzkMljgAq42pdTrNBlQYYrYotR0e3KtOggHQ

-- Dumped from database version 15.18
-- Dumped by pg_dump version 15.18

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
-- Name: access_cards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.access_cards (
    id integer NOT NULL,
    card_number character varying(50) NOT NULL,
    owner_type character varying(20) NOT NULL,
    owner_id integer NOT NULL,
    issued_at date DEFAULT CURRENT_DATE NOT NULL,
    expires_at date,
    is_active boolean DEFAULT true NOT NULL,
    CONSTRAINT access_cards_owner_type_check CHECK (((owner_type)::text = ANY ((ARRAY['student'::character varying, 'staff'::character varying, 'visitor'::character varying])::text[])))
);


--
-- Name: access_cards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.access_cards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: access_cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.access_cards_id_seq OWNED BY public.access_cards.id;


--
-- Name: access_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.access_events (
    id bigint NOT NULL,
    card_id integer NOT NULL,
    access_point_id integer NOT NULL,
    event_time timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    direction character varying(10) NOT NULL,
    access_result character varying(20) NOT NULL,
    denial_reason character varying(255),
    CONSTRAINT access_events_access_result_check CHECK (((access_result)::text = ANY ((ARRAY['granted'::character varying, 'denied'::character varying])::text[]))),
    CONSTRAINT access_events_direction_check CHECK (((direction)::text = ANY ((ARRAY['in'::character varying, 'out'::character varying])::text[])))
);


--
-- Name: access_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.access_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: access_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.access_events_id_seq OWNED BY public.access_events.id;


--
-- Name: access_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.access_points (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    point_type character varying(50) NOT NULL,
    location character varying(255),
    is_active boolean DEFAULT true NOT NULL,
    CONSTRAINT access_points_point_type_check CHECK (((point_type)::text = ANY ((ARRAY['turnstile'::character varying, 'door'::character varying, 'gate'::character varying])::text[])))
);


--
-- Name: access_points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.access_points_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: access_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.access_points_id_seq OWNED BY public.access_points.id;


--
-- Name: backup_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.backup_log (
    id integer NOT NULL,
    backup_file character varying(255) NOT NULL,
    backup_type character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    finished_at timestamp without time zone,
    status character varying(50) NOT NULL,
    file_size_bytes bigint,
    comment text
);


--
-- Name: backup_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.backup_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: backup_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.backup_log_id_seq OWNED BY public.backup_log.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staff (
    id integer NOT NULL,
    last_name character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(100),
    "position" character varying(100) NOT NULL,
    department character varying(100),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.staff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.staff_id_seq OWNED BY public.staff.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.students (
    id integer NOT NULL,
    last_name character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    middle_name character varying(100),
    class_name character varying(20) NOT NULL,
    birth_date date,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;


--
-- Name: visitors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.visitors (
    id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    document_number character varying(100),
    visit_purpose character varying(255),
    responsible_person character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: visitors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.visitors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: visitors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.visitors_id_seq OWNED BY public.visitors.id;


--
-- Name: access_cards id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_cards ALTER COLUMN id SET DEFAULT nextval('public.access_cards_id_seq'::regclass);


--
-- Name: access_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_events ALTER COLUMN id SET DEFAULT nextval('public.access_events_id_seq'::regclass);


--
-- Name: access_points id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_points ALTER COLUMN id SET DEFAULT nextval('public.access_points_id_seq'::regclass);


--
-- Name: backup_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backup_log ALTER COLUMN id SET DEFAULT nextval('public.backup_log_id_seq'::regclass);


--
-- Name: staff id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff ALTER COLUMN id SET DEFAULT nextval('public.staff_id_seq'::regclass);


--
-- Name: students id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: visitors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visitors ALTER COLUMN id SET DEFAULT nextval('public.visitors_id_seq'::regclass);


--
-- Data for Name: access_cards; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.access_cards (id, card_number, owner_type, owner_id, issued_at, expires_at, is_active) FROM stdin;
1	CARD-0001	student	1	2026-06-20	\N	t
2	CARD-0002	student	2	2026-06-20	\N	t
3	CARD-0003	student	3	2026-06-20	\N	t
4	CARD-0004	staff	1	2026-06-20	\N	t
5	CARD-0005	staff	2	2026-06-20	\N	t
6	CARD-0006	staff	3	2026-06-20	\N	t
7	CARD-0007	visitor	1	2026-06-20	\N	t
\.


--
-- Data for Name: access_events; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.access_events (id, card_id, access_point_id, event_time, direction, access_result, denial_reason) FROM stdin;
1	1	1	2026-06-19 08:05:00	in	granted	\N
2	2	1	2026-06-19 08:07:00	in	granted	\N
3	3	1	2026-06-19 08:10:00	in	granted	\N
4	1	1	2026-06-19 14:20:00	out	granted	\N
5	2	1	2026-06-19 14:25:00	out	granted	\N
6	7	1	2026-06-19 12:00:00	in	granted	\N
7	6	1	2026-06-19 18:10:00	in	denied	Карта временно заблокирована
\.


--
-- Data for Name: access_points; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.access_points (id, name, point_type, location, is_active) FROM stdin;
1	Турникет главного входа	turnstile	Холл первого этажа	t
\.


--
-- Data for Name: backup_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.backup_log (id, backup_file, backup_type, created_at, finished_at, status, file_size_bytes, comment) FROM stdin;
6	/home/redos/Рабочий стол/gymasium_skud/backups/gymnasium_skud_backup_2026_06_24_23_32_58.sql	logical pg_dump	2026-06-24 23:32:58.345319	\N	started	\N	Запущено резервное копирование учебной базы данных СКУД
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.staff (id, last_name, first_name, middle_name, "position", department, is_active, created_at) FROM stdin;
1	Смирнова	Ольга	Павловна	Учитель информатики	Учебная часть	t	2026-06-20 22:21:42.541072
2	Кузнецов	Алексей	Игоревич	Охранник	Безопасность	t	2026-06-20 22:21:42.541072
3	Морозов	Дмитрий	Александрович	Системный администратор	ИТ-отдел	t	2026-06-20 22:21:42.541072
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.students (id, last_name, first_name, middle_name, class_name, birth_date, is_active, created_at) FROM stdin;
1	Иванов	Иван	Сергеевич	9А	2010-04-12	t	2026-06-20 22:21:42.541072
2	Петрова	Анна	Викторовна	10Б	2009-09-23	t	2026-06-20 22:21:42.541072
3	Сидоров	Максим	Андреевич	8В	2011-01-15	t	2026-06-20 22:21:42.541072
\.


--
-- Data for Name: visitors; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.visitors (id, full_name, document_number, visit_purpose, responsible_person, created_at) FROM stdin;
1	Николаева Мария Ивановна	4510 123456	Встреча с классным руководителем	Смирнова Ольга Павловна	2026-06-20 22:21:42.541072
\.


--
-- Name: access_cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.access_cards_id_seq', 7, true);


--
-- Name: access_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.access_events_id_seq', 7, true);


--
-- Name: access_points_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.access_points_id_seq', 1, true);


--
-- Name: backup_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.backup_log_id_seq', 6, true);


--
-- Name: staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staff_id_seq', 3, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.students_id_seq', 3, true);


--
-- Name: visitors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.visitors_id_seq', 1, true);


--
-- Name: access_cards access_cards_card_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_cards
    ADD CONSTRAINT access_cards_card_number_key UNIQUE (card_number);


--
-- Name: access_cards access_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_cards
    ADD CONSTRAINT access_cards_pkey PRIMARY KEY (id);


--
-- Name: access_events access_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_events
    ADD CONSTRAINT access_events_pkey PRIMARY KEY (id);


--
-- Name: access_points access_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_points
    ADD CONSTRAINT access_points_pkey PRIMARY KEY (id);


--
-- Name: backup_log backup_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.backup_log
    ADD CONSTRAINT backup_log_pkey PRIMARY KEY (id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);


--
-- Name: visitors visitors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.visitors
    ADD CONSTRAINT visitors_pkey PRIMARY KEY (id);


--
-- Name: access_events access_events_access_point_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_events
    ADD CONSTRAINT access_events_access_point_id_fkey FOREIGN KEY (access_point_id) REFERENCES public.access_points(id) ON DELETE RESTRICT;


--
-- Name: access_events access_events_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.access_events
    ADD CONSTRAINT access_events_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.access_cards(id) ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict gB20BsOreTK5d07mwNwtHpvgmZcqzkMljgAq42pdTrNBlQYYrYotR0e3KtOggHQ

