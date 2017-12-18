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
-- Name: status_person; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN status_person AS character(8)
	CONSTRAINT status_valids CHECK (((VALUE = 'Active'::bpchar) OR (VALUE = 'Inactive'::bpchar)));


ALTER DOMAIN public.status_person OWNER TO postgres;

--
-- Name: exist_name(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exist_name(l_name character varying, f_name character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE 
result BOOLEAN;
BEGIN
SELECT CASE WHEN EXISTS ( 
    SELECT *
     FROM (select last_name, first_name
     from  person
       ) names_renter_user 
    WHERE names_renter_user.last_name=l_name AND names_renter_user.first_name=f_name)  
    THEN CAST(1 AS BIT)
       ELSE CAST(0 AS BIT) END into result;   
      
RETURN result;
END;
$$;


ALTER FUNCTION public.exist_name(l_name character varying, f_name character varying) OWNER TO postgres;

--
-- Name: exist_type_idetifier(character varying, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION exist_type_idetifier(t_identifier character varying, _identifier character varying) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE 
result BOOLEAN;
BEGIN
SELECT CASE WHEN EXISTS ( 
    SELECT *
     FROM (select type_identifier, identifier
     from  person
       ) identifier_person 
    WHERE identifier_person.type_identifier=t_identifier AND identifier_person.identifier=_identifier)  
    THEN CAST(1 AS BIT)
       ELSE CAST(0 AS BIT) END into result;   
      
RETURN result;
END;
$$;


ALTER FUNCTION public.exist_type_idetifier(t_identifier character varying, _identifier character varying) OWNER TO postgres;

--
-- Name: insert_renter_user(character varying, character varying, character varying, character varying, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insert_renter_user(identyfier character varying, l_name character varying, f_name character varying, _genre character varying, _birthday date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
 --_result boolean ;
_id int;
_date_create date;
 --res varchar(20) ;
BEGIN
IF exist_name(l_name,f_name)
THEN
    RAISE EXCEPTION 'Ya existen los nombres. No se puede tener nombres duplicados'; 

  ELSE
     _date_create = current_date;
    INSERT INTO person(type_identifier,last_name,first_name,genre,birthday,date_create,user_create,date_modifier,user_modifier,satate)
     VALUES(identyfier,l_name,f_name,_genre,_birthday,_date_create , 2, null,null,'Active') 
    RETURNING id INTO _id;
    --INSERT INTO renter_user(id_person) VALUES(_id);
   --_result=TRUE;
 END IF;
RETURN _id;
END;
 $$;


ALTER FUNCTION public.insert_renter_user(identyfier character varying, l_name character varying, f_name character varying, _genre character varying, _birthday date) OWNER TO postgres;

--
-- Name: insert_renter_user(character varying, character varying, character varying, character varying, character varying, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION insert_renter_user(t_identifier character varying, _identifier character varying, l_name character varying, f_name character varying, _genre character varying, _birthday date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 
 --_result boolean ;
_id int;
_date_create date;
 --res varchar(20) ;
BEGIN

IF exist_type_idetifier(t_identifier,_identifier)
THEN 
RAISE EXCEPTION 'Identifier type already exists'; 
ELSE
  IF exist_name(l_name,f_name)
    THEN
      RAISE EXCEPTION 'Ya existen los nombres. No se puede tener nombres duplicados'; 

    ELSE
        _date_create = current_date;
        INSERT INTO person(type_identifier,identifier,last_name,first_name,genre,birthday,date_create,user_create,date_modifier,user_modifier,state)
        VALUES(t_identifier,_identifier,l_name,f_name,_genre,_birthday,_date_create , 2, null,null,'Active') 
        RETURNING id INTO _id;
    --INSERT INTO renter_user(id_person) VALUES(_id);
   --_result=TRUE;
 END IF;
END IF;
RETURN _id;
END;
 $$;


ALTER FUNCTION public.insert_renter_user(t_identifier character varying, _identifier character varying, l_name character varying, f_name character varying, _genre character varying, _birthday date) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: data_job; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE data_job (
    id_person integer,
    date_of_hire date,
    address character varying(100),
    id_job integer
);


ALTER TABLE public.data_job OWNER TO postgres;

--
-- Name: job; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE job (
    id integer NOT NULL,
    name_job character varying(20)
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

ALTER SEQUENCE job_id_seq OWNED BY job.id;


--
-- Name: person; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE person (
    id integer NOT NULL,
    type_identifier identifier,
    identifier character varying(30),
    last_name character varying(50),
    first_name character varying(50),
    genre genre,
    birthday date,
    date_create date,
    user_create integer,
    date_modifier date,
    user_modifier integer,
    status status_person
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

ALTER SEQUENCE person_id_seq OWNED BY person.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY job ALTER COLUMN id SET DEFAULT nextval('job_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('person_id_seq'::regclass);


--
-- Data for Name: data_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY data_job (id_person, date_of_hire, address, id_job) FROM stdin;
1	1990-11-13	Av. Siglo XX	1
2	2010-11-13	Av. Ayacucho	2
\.


--
-- Data for Name: job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY job (id, name_job) FROM stdin;
2	Manager
3	Cashier
1	Administrator
\.


--
-- Name: job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('job_id_seq', 3, true);


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY person (id, type_identifier, identifier, last_name, first_name, genre, birthday, date_create, user_create, date_modifier, user_modifier, status) FROM stdin;
2	NIT                 	88334567	Arnez	Morris	M	1990-11-13	2017-12-08	1	\N	\N	Active  
3	NIT                 	6634564	Martinez	Jhosmar	M	1992-05-25	2017-12-08	2	2017-12-15	1	Inactive
4	NIT                 	77788655	Zeballos	Jhon	M	1992-05-25	2017-12-08	2	2017-12-15	2	Active  
36	NIT                 	4444332	Montanio Perez	Jaciel	M	1980-11-11	2017-12-15	2	2017-12-15	1	Active  
35	NIT                 	86759465	Parra Montanio	Jhomar	M	2002-11-11	2017-12-15	2	2017-12-15	2	Active  
1	CI                  	1234567	Tellerina	Claudia	M	1992-11-13	2017-12-08	\N	2017-12-12	18	Active  
\.


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('person_id_seq', 36, true);


--
-- Name: job_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY job
    ADD CONSTRAINT job_pkey PRIMARY KEY (id);


--
-- Name: person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- Name: data_job_id_job_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY data_job
    ADD CONSTRAINT data_job_id_job_fkey FOREIGN KEY (id_job) REFERENCES job(id);


--
-- Name: data_job_id_person_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY data_job
    ADD CONSTRAINT data_job_id_person_fkey FOREIGN KEY (id_person) REFERENCES person(id);


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

