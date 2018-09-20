--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO postgres;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO postgres;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO postgres;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: address_standardizer; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS address_standardizer WITH SCHEMA public;


--
-- Name: EXTENSION address_standardizer; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION address_standardizer IS 'Used to parse an address into constituent elements. Generally used to support geocoding address normalization step.';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: ogr_fdw; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ogr_fdw WITH SCHEMA public;


--
-- Name: EXTENSION ogr_fdw; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ogr_fdw IS 'foreign-data wrapper for GIS data access';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: pgrouting; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgrouting WITH SCHEMA public;


--
-- Name: EXTENSION pgrouting; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgrouting IS 'pgRouting Extension';


--
-- Name: pointcloud; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pointcloud WITH SCHEMA public;


--
-- Name: EXTENSION pointcloud; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pointcloud IS 'data type for lidar point clouds';


--
-- Name: pointcloud_postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pointcloud_postgis WITH SCHEMA public;


--
-- Name: EXTENSION pointcloud_postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pointcloud_postgis IS 'integration for pointcloud LIDAR data and PostGIS geometry data';


--
-- Name: postgis_sfcgal; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_sfcgal WITH SCHEMA public;


--
-- Name: EXTENSION postgis_sfcgal; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_sfcgal IS 'PostGIS SFCGAL functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building (
    id integer NOT NULL,
    type_id integer NOT NULL,
    nom character varying(50) NOT NULL,
    street_number integer NOT NULL,
    street_name character varying(100) NOT NULL,
    complement_address text NOT NULL,
    code_postal integer NOT NULL,
    ville character varying(50) NOT NULL,
    usage_principale character varying(100) NOT NULL,
    date_de_construction timestamp without time zone,
    nombre_de_batiment integer NOT NULL,
    nombre_de_niveaux integer NOT NULL,
    compacite text NOT NULL,
    periode_de_occupation_des_locaux character varying(50) NOT NULL,
    hauteur_sous_plafond_moyenne text NOT NULL,
    zone_climatique character varying(50) NOT NULL,
    temp_ext_de_base integer NOT NULL,
    orientation_principale text NOT NULL,
    surface_totale integer NOT NULL,
    detailed_surface text NOT NULL,
    chauffage character varying(100) NOT NULL,
    ecs character varying(100) NOT NULL,
    renouvellement_d_air character varying(100) NOT NULL,
    plan character varying(100) NOT NULL,
    image character varying(100) NOT NULL,
    cons_gaz character varying(50) NOT NULL,
    cons_gas_link character varying(50) NOT NULL,
    cons_elec character varying(50) NOT NULL,
    cons_elec_link character varying(50) NOT NULL,
    cons_eau character varying(50) NOT NULL,
    cons_eau_link character varying(50) NOT NULL,
    cons_eau_chaud character varying(50) NOT NULL,
    cons_eau_chaud_link character varying(50) NOT NULL,
    dpec character varying(50) NOT NULL,
    maintenance text NOT NULL,
    geom public.geometry(Point,4326),
    lat numeric,
    lon numeric
);


ALTER TABLE public.building OWNER TO postgres;

--
-- Name: building_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_id_seq OWNER TO postgres;

--
-- Name: building_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_id_seq OWNED BY public.building.id;


--
-- Name: building_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.building_type (
    id integer NOT NULL,
    name character varying(30) NOT NULL,
    comments text NOT NULL
);


ALTER TABLE public.building_type OWNER TO postgres;

--
-- Name: building_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.building_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.building_type_id_seq OWNER TO postgres;

--
-- Name: building_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.building_type_id_seq OWNED BY public.building_type.id;


--
-- Name: building id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building ALTER COLUMN id SET DEFAULT nextval('public.building_id_seq'::regclass);


--
-- Name: building_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_type ALTER COLUMN id SET DEFAULT nextval('public.building_type_id_seq'::regclass);


--
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building (id, type_id, nom, street_number, street_name, complement_address, code_postal, ville, usage_principale, date_de_construction, nombre_de_batiment, nombre_de_niveaux, compacite, periode_de_occupation_des_locaux, hauteur_sous_plafond_moyenne, zone_climatique, temp_ext_de_base, orientation_principale, surface_totale, detailed_surface, chauffage, ecs, renouvellement_d_air, plan, image, cons_gaz, cons_gas_link, cons_elec, cons_elec_link, cons_eau, cons_eau_link, cons_eau_chaud, cons_eau_chaud_link, dpec, maintenance, geom, lat, lon) FROM stdin;
1	1	Ecole élémentaire Marcel PAGNOL	127	Rue du Général LECLERC		2100	Saint-Quentin	Ecole élémentaire	2018-07-23 00:00:00	2	2	133 éléves et 7 enseignants		Rez-de-chaussée: 3.20m, R+1: 3.20m	H1a	-7	Façade sur cour intérieure: Sud Est, Façade sur rue: Sud Ouest	854	Salles de classe 442m2, Salle inforatique 42m2	Chauffage au gaz	Ballons électriques décentralisés	Ventilation Naturelle par infiltration			No information	No information	No information	No information	No information	No information	No information	No information	No information	No information	0101000020E610000090F5D4EAAB6B0A40D921FE614BEB4840	49.838238	3.302574
\.


--
-- Data for Name: building_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building_type (id, name, comments) FROM stdin;
1	Schools	No comments
\.


--
-- Data for Name: pointcloud_formats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pointcloud_formats (pcid, srid, schema) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: postgres
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: postgres
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: building_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_id_seq', 1, true);


--
-- Name: building_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_type_id_seq', 1, false);


--
-- Name: building building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building
    ADD CONSTRAINT building_pkey PRIMARY KEY (id);


--
-- Name: building_type building_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_type
    ADD CONSTRAINT building_type_pkey PRIMARY KEY (id);


--
-- Name: building_type_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX building_type_id_idx ON public.building USING btree (type_id);


--
-- PostgreSQL database dump complete
--

