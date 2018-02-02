--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: genre; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN genre AS character(1)
	CONSTRAINT genre_check CHECK (((VALUE = 'M'::bpchar) OR (VALUE = 'F'::bpchar)));


ALTER DOMAIN public.genre OWNER TO postgres;

--
-- Name: identifier; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN identifier AS character(20)
	CONSTRAINT identifier_valids CHECK ((VALUE = ANY (ARRAY['CI'::bpchar, 'PASS'::bpchar, 'NIT'::bpchar])));


ALTER DOMAIN public.identifier OWNER TO postgres;

--
-- Name: status; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN status AS character(8)
	CONSTRAINT status_valids CHECK (((VALUE = 'Active'::bpchar) OR (VALUE = 'Inactive'::bpchar)));


ALTER DOMAIN public.status OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actor; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE actor (
    actor_id integer NOT NULL,
    name_actor character varying(256),
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone,
    status status
);


ALTER TABLE public.actor OWNER TO postgres;

--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.actor_actor_id_seq OWNER TO postgres;

--
-- Name: actor_actor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE actor_actor_id_seq OWNED BY actor.actor_id;


--
-- Name: bond; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bond (
    bond_id integer NOT NULL,
    quantity double precision,
    seniority integer,
    start_date date,
    end_date date
);


ALTER TABLE public.bond OWNER TO postgres;

--
-- Name: bond_assigned; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE bond_assigned (
    employee_data_id integer,
    bond_id integer,
    start_date date,
    end_date date,
    status status
);


ALTER TABLE public.bond_assigned OWNER TO postgres;

--
-- Name: bond_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE bond_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bond_id_seq OWNER TO postgres;

--
-- Name: bond_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE bond_id_seq OWNED BY bond.bond_id;


--
-- Name: buy_detail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE buy_detail (
    buy_amount integer,
    buy_price double precision,
    master_detail_id integer,
    copy_movie_id integer,
    price_id character varying
);


ALTER TABLE public.buy_detail OWNER TO postgres;

--
-- Name: copy_movie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE copy_movie (
    copy_movie_id integer NOT NULL,
    amount_initial integer,
    amount_current integer,
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone,
    movie_id integer
);


ALTER TABLE public.copy_movie OWNER TO postgres;

--
-- Name: copy_movie_copy_movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE copy_movie_copy_movie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.copy_movie_copy_movie_id_seq OWNER TO postgres;

--
-- Name: copy_movie_copy_movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE copy_movie_copy_movie_id_seq OWNED BY copy_movie.copy_movie_id;


--
-- Name: employee_data; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE employee_data (
    employee_data_id integer NOT NULL,
    date_of_hire date,
    address character varying(100),
    job_id integer,
    enable_rent boolean DEFAULT false NOT NULL,
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone
);


ALTER TABLE public.employee_data OWNER TO postgres;

--
-- Name: employee_data_history; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE employee_data_history (
    employee_data_id integer,
    date_of_hire date,
    address character varying(100),
    job_id integer,
    enable_rent boolean DEFAULT false NOT NULL,
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone,
    status status
);


ALTER TABLE public.employee_data_history OWNER TO postgres;

--
-- Name: genre_movie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE genre_movie (
    genre_movie_id character varying(10) NOT NULL,
    genre_name character varying(120)
);


ALTER TABLE public.genre_movie OWNER TO postgres;

--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE job (
    job_id integer NOT NULL,
    job_name character varying(20)
);


ALTER TABLE public.job OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.job_id_seq OWNER TO postgres;

--
-- Name: job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE job_id_seq OWNED BY job.job_id;


--
-- Name: master_detail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE master_detail (
    master_detail_id integer NOT NULL,
    amount_total integer,
    price_total double precision,
    create_date timestamp without time zone,
    modifier_date timestamp without time zone,
    modifier_user integer,
    renter_user integer,
    create_user integer
);


ALTER TABLE public.master_detail OWNER TO postgres;

--
-- Name: master_detail_master_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE master_detail_master_detail_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.master_detail_master_detail_id_seq OWNER TO postgres;

--
-- Name: master_detail_master_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE master_detail_master_detail_id_seq OWNED BY master_detail.master_detail_id;


--
-- Name: movie; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE movie (
    movie_id integer NOT NULL,
    movie_name character varying(256),
    director_name character varying(256),
    movie_year integer,
    oscar_nomination integer,
    genre_movie_id character varying,
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone,
    status status
);


ALTER TABLE public.movie OWNER TO postgres;

--
-- Name: movie_movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE movie_movie_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_movie_id_seq OWNER TO postgres;

--
-- Name: movie_movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE movie_movie_id_seq OWNED BY movie.movie_id;


--
-- Name: participate; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE participate (
    movie_id integer,
    actor_id integer,
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone,
    status status
);


ALTER TABLE public.participate OWNER TO postgres;

--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE person (
    person_id integer NOT NULL,
    type_identifier identifier,
    identifier character varying(30),
    last_name character varying(50),
    first_name character varying(50),
    genre genre,
    birthday date,
    create_user integer,
    modifier_user integer,
    create_date timestamp without time zone,
    modifier_date timestamp without time zone,
    status status DEFAULT 'Active'::bpchar
);


ALTER TABLE public.person OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.person_id_seq OWNER TO postgres;

--
-- Name: person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE person_id_seq OWNED BY person.person_id;


--
-- Name: phone; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE phone (
    employee_data_id integer,
    number_phone integer NOT NULL,
    create_user integer,
    create_date timestamp without time zone,
    modifier_user integer,
    modifier_date timestamp without time zone,
    status status
);


ALTER TABLE public.phone OWNER TO postgres;

--
-- Name: price; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE price (
    price_id character varying(5) NOT NULL,
    price_name character varying(20),
    price double precision
);


ALTER TABLE public.price OWNER TO postgres;

--
-- Name: rental_detail; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE rental_detail (
    rental_amount integer,
    return_amount integer,
    return_date timestamp without time zone,
    rental_price double precision,
    rental_amount_official integer,
    employee_receive integer,
    master_detail_id integer,
    note character varying(250),
    copy_movie_id integer,
    price_id character varying,
    penalty double precision,
    rental_price_official double precision
);


ALTER TABLE public.rental_detail OWNER TO postgres;

--
-- Name: salary; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE salary (
    employee_data_id integer,
    net_salary double precision,
    bond double precision,
    liquid_salary double precision,
    end_date date,
    status status
);


ALTER TABLE public.salary OWNER TO postgres;

--
-- Name: actor_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY actor ALTER COLUMN actor_id SET DEFAULT nextval('actor_actor_id_seq'::regclass);


--
-- Name: bond_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bond ALTER COLUMN bond_id SET DEFAULT nextval('bond_id_seq'::regclass);


--
-- Name: copy_movie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY copy_movie ALTER COLUMN copy_movie_id SET DEFAULT nextval('copy_movie_copy_movie_id_seq'::regclass);


--
-- Name: job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY job ALTER COLUMN job_id SET DEFAULT nextval('job_id_seq'::regclass);


--
-- Name: master_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY master_detail ALTER COLUMN master_detail_id SET DEFAULT nextval('master_detail_master_detail_id_seq'::regclass);


--
-- Name: movie_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie ALTER COLUMN movie_id SET DEFAULT nextval('movie_movie_id_seq'::regclass);


--
-- Name: person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person ALTER COLUMN person_id SET DEFAULT nextval('person_id_seq'::regclass);


--
-- Data for Name: actor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY actor (actor_id, name_actor, create_user, create_date, modifier_user, modifier_date, status) FROM stdin;
1	Richard Hendricks	1	2018-01-16 10:20:18.678	\N	\N	Active  
2	Jared Dunn	1	2018-01-17 11:50:43.027	\N	\N	Active  
12	Andrew Lincoln	2	2018-01-18 11:37:56.323	\N	\N	Active  
13	Jon Bernthal	2	2018-01-18 11:37:56.323	\N	\N	Active  
14	Sarah Wayne Callies	2	2018-01-18 11:37:56.323	\N	\N	Active  
15	Patrick Wilson	2	2018-01-18 11:50:00.103	\N	\N	Active  
16	Ron Livingston	2	2018-01-18 11:50:00.103	\N	\N	Active  
17	Lili Taylor	2	2018-01-18 16:02:48.853	\N	\N	Active  
18	Tobi'n Bell	2	2018-01-31 11:38:17.663	\N	\N	Active  
19	Cary Elwes	2	2018-01-31 11:49:31.315	\N	\N	Active  
20	Danny Glover	2	2018-01-31 11:49:31.315	\N	\N	Active  
\.


--
-- Name: actor_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('actor_actor_id_seq', 20, true);


--
-- Data for Name: bond; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bond (bond_id, quantity, seniority, start_date, end_date) FROM stdin;
1	1	2	\N	\N
2	5	3	\N	\N
3	5.5	4	\N	\N
4	0	0	\N	\N
\.


--
-- Data for Name: bond_assigned; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bond_assigned (employee_data_id, bond_id, start_date, end_date, status) FROM stdin;
1	4	2018-01-31	\N	Active  
2	4	2018-01-31	\N	Active  
4	4	2018-01-31	\N	Active  
88	4	2018-01-31	\N	Active  
\.


--
-- Name: bond_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('bond_id_seq', 4, true);


--
-- Data for Name: buy_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY buy_detail (buy_amount, buy_price, master_detail_id, copy_movie_id, price_id) FROM stdin;
20	260	1	6	BP
2	26	10	9	BP
\.


--
-- Data for Name: copy_movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY copy_movie (copy_movie_id, amount_initial, amount_current, create_user, create_date, modifier_user, modifier_date, movie_id) FROM stdin;
9	50	48	2	2018-01-25 09:27:03.082	88	2018-01-25 11:29:35.402	11
6	100	42	2	2018-01-17 19:55:27.114	88	2018-01-25 11:46:07.345	1
7	100	100	2	2018-01-17 19:59:04.274	88	2018-01-25 11:46:07.345	1
8	15	0	2	2018-01-22 11:58:54.093	88	2018-01-25 11:46:07.345	10
10	15	10	2	2018-01-25 11:44:58.041	88	2018-01-25 11:46:07.345	10
11	50	50	2	2018-01-25 17:17:18.216	\N	\N	11
12	10	10	2	2018-01-25 17:21:25.675	\N	\N	11
13	10	10	2	2018-01-25 17:23:23.453	\N	\N	11
\.


--
-- Name: copy_movie_copy_movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('copy_movie_copy_movie_id_seq', 13, true);


--
-- Data for Name: employee_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employee_data (employee_data_id, date_of_hire, address, job_id, enable_rent, create_user, create_date, modifier_user, modifier_date) FROM stdin;
1	2012-12-20	Av. Siglo XX	1	t	1	2017-12-13 14:53:30.984	\N	\N
2	2012-12-25	Av. Republica	2	t	1	2017-12-13 14:53:30.984	\N	\N
4	2015-12-25	Av. America	3	t	2	2017-12-25 14:53:30.984	\N	\N
88	2018-01-13	Av. Santa Cruz	4	t	2	2018-01-13 17:20:24.652	\N	\N
\.


--
-- Data for Name: employee_data_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY employee_data_history (employee_data_id, date_of_hire, address, job_id, enable_rent, create_user, create_date, modifier_user, modifier_date, status) FROM stdin;
1	2012-12-20	Av. Siglo XX	1	t	1	2017-12-13 14:53:30.984	\N	\N	Active  
2	2012-12-25	Av. Republica	2	t	1	2017-12-13 14:53:30.984	\N	\N	Active  
4	2015-12-25	Av. America	3	t	2	2017-12-25 14:53:30.984	\N	\N	Active  
88	2018-01-13	Av. Santa Cruz	4	t	2	2018-01-13 17:20:24.652	\N	\N	Active  
\.


--
-- Data for Name: genre_movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY genre_movie (genre_movie_id, genre_name) FROM stdin;
HOR	Horror
COM	Comedy
SF	Science Fiction
SUSP	Suspense
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY job (job_id, job_name) FROM stdin;
1	ADMIN
2	MGR
3	CSHR
4	CC
\.


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('job_id_seq', 4, true);


--
-- Data for Name: master_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY master_detail (master_detail_id, amount_total, price_total, create_date, modifier_date, modifier_user, renter_user, create_user) FROM stdin;
1	50	440	2018-01-23 16:33:38.671	\N	\N	3	\N
9	5	44	2018-01-25 11:29:35.402	\N	\N	86	\N
10	5	44	2018-01-25 11:29:35.402	\N	\N	86	\N
11	30	180	2018-01-25 11:46:07.345	\N	\N	86	\N
12	30	180	2018-01-25 11:46:07.345	\N	\N	86	\N
\.


--
-- Name: master_detail_master_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('master_detail_master_detail_id_seq', 12, true);


--
-- Data for Name: movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY movie (movie_id, movie_name, director_name, movie_year, oscar_nomination, genre_movie_id, create_user, create_date, modifier_user, modifier_date, status) FROM stdin;
10	The Walking Dead	 Frank Darabont	2010	0	HOR	2	2018-01-18 11:37:56.323	\N	\N	Active  
1	Silicon Valley	Carrie Kemper	2000	0	SF	1	2018-01-16 09:51:30.963	1	2018-01-26 10:56:34.565	Active  
11	The Conjuring 2	Frank Dar	2013	2	HOR	2	2018-01-18 11:50:00.103	2	2018-01-31 11:38:17.663	Active  
12	Saw	 Leigh Whannell	2004	0	HOR	2	2018-01-31 11:49:31.315	\N	\N	Active  
\.


--
-- Name: movie_movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('movie_movie_id_seq', 12, true);


--
-- Data for Name: participate; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY participate (movie_id, actor_id, create_user, create_date, modifier_user, modifier_date, status) FROM stdin;
1	1	1	2018-01-17 11:52:21.148	\N	\N	Active  
1	2	1	2018-01-17 11:52:55.14	\N	\N	Active  
10	12	2	2018-01-18 11:37:56.323	\N	\N	Active  
10	13	2	2018-01-18 11:37:56.323	\N	\N	Active  
10	14	2	2018-01-18 11:37:56.323	\N	\N	Active  
11	15	2	2018-01-18 11:50:00.103	\N	\N	Active  
11	12	2	2018-01-18 11:50:00.103	\N	\N	Active  
11	16	2	2018-01-18 11:50:00.103	2	2018-01-18 16:02:48.853	Inactive
11	17	2	2018-01-18 16:02:48.853	\N	\N	Active  
11	18	2	2018-01-31 11:38:17.663	\N	\N	Active  
11	16	2	2018-01-31 11:38:17.663	\N	\N	Active  
12	19	2	2018-01-31 11:49:31.315	\N	\N	Active  
12	20	2	2018-01-31 11:49:31.315	\N	\N	Active  
12	18	2	2018-01-31 11:49:31.315	\N	\N	Active  
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY person (person_id, type_identifier, identifier, last_name, first_name, genre, birthday, create_user, modifier_user, create_date, modifier_date, status) FROM stdin;
1	CI                  	1234567	Telleria	Claudia	F	1992-11-13	1	1	2017-12-13 14:53:30.984	\N	Active  
2	NIT                 	88334567	Arnez	Morris	M	1990-11-13	1	1	2017-12-13 14:53:30.984	\N	Active  
3	CI                  	6634564	Parra Montanio	Juan	M	2002-12-13	2	1	2017-12-25 14:53:30.984	\N	Active  
4	NIT                 	77788655	Zeballos	Jhon	M	1992-05-25	2	2	2017-12-25 14:53:30.984	\N	Active  
68	CI                  	21212100	Claure Arnez	Marcelo	M	1991-11-30	1	\N	2017-12-25 14:53:30.984	\N	Active  
88	PASS                	SSS123457	Gozales Mena	Sheyla	F	2000-01-12	2	1	2018-01-13 17:20:24.652	2018-01-13 18:53:46.461	Active  
89	PASS                	JJJ435343	Patsi	Marleny	M	1983-01-13	2	\N	2018-01-25 19:13:15.67	\N	Active  
87	PASS                	SSS123456	Mamani Paredes	Belen	F	2000-01-14	2	2	2018-01-13 16:23:47.322	2018-01-13 16:41:06.782	Active  
86	PASS                	SSS435343X	Gonzales Mamani	Jacie'el	M	2000-01-13	2	1	2018-01-13 14:53:30.984	2018-01-13 15:00:17.993	Active  
\.


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('person_id_seq', 92, true);


--
-- Data for Name: phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY phone (employee_data_id, number_phone, create_user, create_date, modifier_user, modifier_date, status) FROM stdin;
1	671111111	1	2017-12-13 14:53:30.984	\N	\N	Active  
1	761111111	1	2017-12-13 14:53:30.984	\N	\N	Active  
2	67222222	1	2017-12-13 14:53:30.984	\N	\N	Active  
2	76222222	1	2017-12-13 14:53:30.984	\N	\N	Active  
4	67444444	2	2017-12-25 14:53:30.984	\N	\N	Active  
4	76444444	2	2017-12-25 14:53:30.984	\N	\N	Active  
88	67888888	2	2018-01-13 17:20:24.652	\N	\N	Active  
88	76888888	2	2018-01-13 17:20:24.652	\N	\N	Active  
\.


--
-- Data for Name: price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY price (price_id, price_name, price) FROM stdin;
R	Rental	6
B	Buy	10
BP	Buy premier	13
\.


--
-- Data for Name: rental_detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rental_detail (rental_amount, return_amount, return_date, rental_price, rental_amount_official, employee_receive, master_detail_id, note, copy_movie_id, price_id, penalty, rental_price_official) FROM stdin;
30	\N	\N	180	30	\N	1	\N	6	R	\N	\N
3	\N	\N	18	3	\N	10	\N	6	R	\N	\N
5	\N	\N	30	5	\N	12	\N	6	R	\N	\N
20	\N	\N	120	20	\N	12	\N	8	R	\N	\N
5	\N	\N	30	5	\N	12	\N	10	R	\N	\N
\.


--
-- Data for Name: salary; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY salary (employee_data_id, net_salary, bond, liquid_salary, end_date, status) FROM stdin;
1	10000	\N	\N	\N	Active  
2	8000	\N	\N	\N	Active  
4	7000	\N	\N	\N	Active  
88	5000	\N	\N	\N	Active  
\.


--
-- Name: actor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- Name: bond_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bond
    ADD CONSTRAINT bond_pkey PRIMARY KEY (bond_id);


--
-- Name: copy_movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY copy_movie
    ADD CONSTRAINT copy_movie_pkey PRIMARY KEY (copy_movie_id);


--
-- Name: employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY employee_data
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employee_data_id);


--
-- Name: genre_movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY genre_movie
    ADD CONSTRAINT genre_movie_pkey PRIMARY KEY (genre_movie_id);


--
-- Name: job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY job
    ADD CONSTRAINT job_pkey PRIMARY KEY (job_id);


--
-- Name: master_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY master_detail
    ADD CONSTRAINT master_detail_pkey PRIMARY KEY (master_detail_id);


--
-- Name: movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movie
    ADD CONSTRAINT movie_pkey PRIMARY KEY (movie_id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (person_id);


--
-- Name: price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY price
    ADD CONSTRAINT price_pkey PRIMARY KEY (price_id);


--
-- Name: bond_assigned_bond_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bond_assigned
    ADD CONSTRAINT bond_assigned_bond_id_fkey FOREIGN KEY (bond_id) REFERENCES bond(bond_id);


--
-- Name: bond_assigned_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY bond_assigned
    ADD CONSTRAINT bond_assigned_employee_id_fkey FOREIGN KEY (employee_data_id) REFERENCES employee_data(employee_data_id);


--
-- Name: buy_detail_copy_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY buy_detail
    ADD CONSTRAINT buy_detail_copy_movie_id_fkey FOREIGN KEY (copy_movie_id) REFERENCES copy_movie(copy_movie_id);


--
-- Name: buy_detail_master_detail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY buy_detail
    ADD CONSTRAINT buy_detail_master_detail_id_fkey FOREIGN KEY (master_detail_id) REFERENCES master_detail(master_detail_id);


--
-- Name: buy_detail_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY buy_detail
    ADD CONSTRAINT buy_detail_price_id_fkey FOREIGN KEY (price_id) REFERENCES price(price_id);


--
-- Name: copy_movie_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY copy_movie
    ADD CONSTRAINT copy_movie_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movie(movie_id);


--
-- Name: employee_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employee_data
    ADD CONSTRAINT employee_employee_id_fkey FOREIGN KEY (employee_data_id) REFERENCES person(person_id);


--
-- Name: employee_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY employee_data
    ADD CONSTRAINT employee_job_id_fkey FOREIGN KEY (job_id) REFERENCES job(job_id);


--
-- Name: master_detail_create_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY master_detail
    ADD CONSTRAINT master_detail_create_user_fkey FOREIGN KEY (create_user) REFERENCES employee_data(employee_data_id);


--
-- Name: master_detail_renter_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY master_detail
    ADD CONSTRAINT master_detail_renter_user_fkey FOREIGN KEY (renter_user) REFERENCES person(person_id);


--
-- Name: movie_genre_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movie
    ADD CONSTRAINT movie_genre_movie_id_fkey FOREIGN KEY (genre_movie_id) REFERENCES genre_movie(genre_movie_id);


--
-- Name: participate_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participate
    ADD CONSTRAINT participate_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES actor(actor_id);


--
-- Name: participate_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY participate
    ADD CONSTRAINT participate_movie_id_fkey FOREIGN KEY (movie_id) REFERENCES movie(movie_id);


--
-- Name: phone_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY phone
    ADD CONSTRAINT phone_employee_id_fkey FOREIGN KEY (employee_data_id) REFERENCES employee_data(employee_data_id);


--
-- Name: rental_detail_copy_movie_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rental_detail
    ADD CONSTRAINT rental_detail_copy_movie_id_fkey FOREIGN KEY (copy_movie_id) REFERENCES copy_movie(copy_movie_id);


--
-- Name: rental_detail_master_detail_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rental_detail
    ADD CONSTRAINT rental_detail_master_detail_id_fkey FOREIGN KEY (master_detail_id) REFERENCES master_detail(master_detail_id);


--
-- Name: rental_detail_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rental_detail
    ADD CONSTRAINT rental_detail_price_id_fkey FOREIGN KEY (price_id) REFERENCES price(price_id);


--
-- Name: salary_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY salary
    ADD CONSTRAINT salary_employee_id_fkey FOREIGN KEY (employee_data_id) REFERENCES employee_data(employee_data_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

