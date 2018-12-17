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
    sub_category integer NOT NULL,
    categorie character varying(100) NOT NULL,
    nom character varying(50) NOT NULL,
    adresse character varying(50) NOT NULL,
    code_postal integer NOT NULL,
    ville character varying(50) NOT NULL,
    usage_principale text,
    date_de_construction text,
    nombre_de_batiment text,
    nombre_de_niveaux text,
    surface_totale character varying(50),
    compacite text,
    periode_de_occupation_des_locaux text,
    hauteur_sous_plafond_moyenne text,
    zone_climatique character varying(50),
    temp_exterieure_de_base integer,
    orientation_principale text,
    detail_des_surfaces text,
    chauffage text,
    ecs text,
    renouvellement_d_air text,
    remarques text,
    plan character varying(100),
    image character varying(100),
    lat numeric,
    lon numeric,
    geom public.geometry(Point,4326)
);


ALTER TABLE public.building OWNER TO postgres;

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


SET default_with_oids = false;

--
-- Name: knex_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knex_migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.knex_migrations OWNER TO postgres;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.knex_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knex_migrations_id_seq OWNER TO postgres;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.knex_migrations_id_seq OWNED BY public.knex_migrations.id;


--
-- Name: knex_migrations_lock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.knex_migrations_lock (
    index integer NOT NULL,
    is_locked integer
);


ALTER TABLE public.knex_migrations_lock OWNER TO postgres;

--
-- Name: knex_migrations_lock_index_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.knex_migrations_lock_index_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knex_migrations_lock_index_seq OWNER TO postgres;

--
-- Name: knex_migrations_lock_index_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.knex_migrations_lock_index_seq OWNED BY public.knex_migrations_lock.index;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    message character varying(255) NOT NULL,
    sender_id bigint,
    receiver_id bigint,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: user_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_types (
    type_name character varying(50) NOT NULL
);


ALTER TABLE public.user_types OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    email character varying(50) NOT NULL,
    password text NOT NULL,
    type character varying(50)
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
-- Name: building_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.building_type ALTER COLUMN id SET DEFAULT nextval('public.building_type_id_seq'::regclass);


--
-- Name: knex_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knex_migrations ALTER COLUMN id SET DEFAULT nextval('public.knex_migrations_id_seq'::regclass);


--
-- Name: knex_migrations_lock index; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knex_migrations_lock ALTER COLUMN index SET DEFAULT nextval('public.knex_migrations_lock_index_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building (id, type_id, sub_category, categorie, nom, adresse, code_postal, ville, usage_principale, date_de_construction, nombre_de_batiment, nombre_de_niveaux, surface_totale, compacite, periode_de_occupation_des_locaux, hauteur_sous_plafond_moyenne, zone_climatique, temp_exterieure_de_base, orientation_principale, detail_des_surfaces, chauffage, ecs, renouvellement_d_air, remarques, plan, image, lat, lon, geom) FROM stdin;
1	1	1	Mat et Elem	Groupe Scolaire HenriI ARNOULD 	 5 rue Leon Lemaire	2100	Saint-Quentin	Ecole maternelle et primaire |	NC	3 (dont 2 bвtiments accolйs) |	2	1987 mІ	0.7	NC	3,2 m	H1a	-7	Est - Ouest	\N	Chauffage au gaz |	Ballons йlectriques dйcentralisйs |	Ventilation naturelle par bouche d'extraction |	\N	\N	\N	49.83516264	3.317452669	0101000020E61000003510FB9F248A0A400DD2009CE6EA4840
2	1	1	Mat et Elem	Groupe Scolaire Quentin BARRE	Impasse Jacquard  et 59 rue Quentin Barr??	2100	Saint-Quentin	Ecole maternelle et primaire |	Construction en 1910 - Rйhabilitation en 1921 |	3	3 (Sous-Sol, RDC, 1 йtage) |	2114 mІ	Ecole maternelle: 90 enfants et 4 enseignants |Ecole primaire: 161 enfants (enseignants non communiquйs)	NC	RDC: 2,8 m en moyenne	H1a	-7	Orientation principale: Sud Ouest |	Ecole Maternelle: 847 mІ |Ecole primaire filles 638 mІ |Ecole Primaire Garзons: 629 mІ	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |VMC pour les sanitaires de la cour	\N	\N	\N	49.8486184	3.298704028	0101000020E6100000398CFBEFBE630A40556419879FEC4840
3	1	1	Mat et Elem	Groupe Scolaire PAUL BERT 	66 rue du Fleming	2100	Saint-Quentin	\N	\N	\N	\N	\N	\N	\N	\N	H1a	-7	\N	\N	\N	\N	\N	\N	\N	\N	49.86296777	3.305342495	0101000020E610000015D5F06757710A4076D356BA75EE4840
4	1	1	Mat et Elem	Groupe Scolaire FRAN??OIS COLLERY 	88 rue Henry Dunant	2100	Saint-Quentin	Ecole maternelle et primaire	NC	3	3	3075 mІ	1.83	De 8h00 а 18h00, les lundi, mardi, jeudi et vendredi |	Primaire: 3,15 m |Maternelle: 3,25 m |Gymnase: 7m	H1a	-7	Bвtiment principal: Nord-est / Sud-ouest |	\N	Chaudiиre GAZ |	Chaudiиre GAZ |	Ventilation naturelle par infiltration	\N	\N	\N	49.85433756	3.305114508	0101000020E61000003A290BE0DF700A40E3F8E3EE5AED4840
19	1	1	Mat et Elem	Groupe Scolaire Jean MACE 	Rue du Commandant Charcot 	2100	Saint-Quentin	\N	\N	\N	\N	\N	\N	\N	\N	H1a	-7	\N	\N	\N	\N	\N	\N	\N	\N	49.84628869	3.266630173	0101000020E6100000694B09000F220A402943133053EC4840
5	1	1	Mat et Elem	Groupe Scolaire CORRETTE 	39 rue Briatte 	2100	Saint-Quentin	Accueil d'enfants	1962	4	2	2453 mІ	0.72	De 7h30 а 18h00, | du lundi au vendredi	Salles: 3,1 m	H1a	-7	Nord / Sud	\N	Chauffage au gaz |	Production йlectrique |	Ventilation naturelle par dйfaut d'йtanchйitй	\N	\N	\N	49.83278038	3.308386803	0101000020E610000055390B8093770A40DC6C288C98EA4840
6	1	1	Mat et Elem	Groupe Scolaire CAMILLE DESMOULINS 	2 rue Louise Hugues et 109 rue Camille Desmoulins	2100	Saint-Quentin	Ecole maternelle et primaire |	NC	4	1 а 2 niveaux	2196 mІ	Ecole maternelle: 123 enfants - 8 enseignants |Ecoleйlйmentaire: 187 enfants (enseignants non renseignйs)	NC	RDC: 2,9 m |R+1: 2,9 m	H1a	-7	Entrйe principale: Ouest |	Bat. Principal: 550 mІ |Bat. Primaire: 690 mІ |Bat. Maternelle: 650 mІ |Restaurant: 89 mІ	Chauffage au gaz	Ballons йlectriques dйcentralisйs |	Ventilation naturelle par infiltration |	\N	\N	\N	49.85425456	3.295085728	0101000020E6100000F835FAE7555C0A4056D4A23658ED4840
7	1	1	Mat et Elem	Groupe Scolaire LES GIRONDINS 	Place des Girondins - 40 rue des Girondins	2100	Saint-Quentin	Ecole primaire et йlementaire |	1921	9	3 (Sous-sol,RDC et йtage) |	3061 mІ	Ecole maternelle: 120 enfants et 5 enseignants |Ecole primaire: 291 йlиves	NC	RDC: 2,9 m	H1a	-7	Ecole йlйmentaire filles: Sud Est |Ecole йlйmentaire Garзons: Nord Ouest |Ecole йlйmentaire: Ouest	\N	Chauffage au gaz	Ballons йlectriques dйcentralisйs |	Ventilation naturelle par infiltration |	\N	\N	\N	49.83824021	3.307804763	0101000020E6100000B01AF55762760A40331288744BEB4840
8	1	1	Mat et Elem	Groupe Scolaire d'Isle. Ecole  POLVENT 	1 rue d'Ostende	2100	Saint-Quentin	\N	\N	\N	\N	\N	\N	\N	\N	H1a	-7	\N	\N	\N	\N	\N	\N	\N	\N	49.83884912	3.298915923	0101000020E61000002A4F0C082E640A40D55670685FEB4840
9	1	1	Mat et Elem	Groupe Scolaire Pierre LAROCHE 	2 rue Andr?? Godin	2100	Saint-Quentin	Ecole maternelle et primaire, Gymnase et logements |	1965	3 (maternelle, primaire et gymnase)	Maternelle: 1 (RDC) |Primaire: 4 (RDC, R+1, R+2, et R+3) |Gymnase: 1 (RDC)	6141 mІ	NC	NC	Maternelle: RDC: 3,40 m |Primaire: RDC, R+1, R+2: 3,40 m ; R+3: NC |Gymnase: RDC: 14m	H1a	-7	Maternelle: Nord / Ouest |Primaire: Sud / Ouest |Gymnase: Sud / Ouest	\N	Chauffage urbain / sous station | dans le bвtiment maternelle	Maternelle et primaire: Electrique |Gymnase: Centralisйe en chauffage urbain	Maternelle: Ventilation naturelle par infiltraation |Primaire: Ventilation naturelle par infiltration dans les salles de classe, et ventilation spйcifique pour la zone de cuisine avec 2 hottes d'extration |Gymnase: Pas de ventilation dans les vestiaires, et deux aйrothermes avec caissons d'air neuf et d'air mйlangй dans la grande salle de sport	Le gymnase а йtй rйhabillitй rйcemment |Les 7 logements faisant initialement partidu groupe scolaire ne font plus partie de ce dernier, ils ne sont plus gйrйs par la Ville.	\N	\N	49.8622364	3.298060298	0101000020E6100000092B01706D620A40DCB529C35DEE4840
10	1	1	Mat et Elem	Groupe Scolaire METZ 	2 rue de Metz	2100	Saint-Quentin	Ecole maternelle et primaire |	1954	1	3	1253 mІ	0.35	de 7h45 а 18h00	3,2 m	H1a	-7	Nord / Sud	\N	Chaufferie gaz |plancher chauffant	Electrique	Ventilation naturelle par infiltration |extracteur dans la piиce d'eau	Le bвtiment est rattachй au collиge, appartenant au conseil rйgional, qui approvisionne l’йcole primaire/maternelle en |chaleur. |L’йcole a йtй rйnovйe en 2002 : remplacement des fenкtres, mise en place de rideau, indйpendance йlectrique |(compteur bleu).	\N	\N	49.84921162	3.290957808	0101000020E6100000BC01EFAFE1530A403FA463F7B2EC4840
11	1	1	Mat et Elem	Groupe Scolaire Marcel PAGNOL 	127 rue du G??n??ral Leclerc	2100	Saint-Quentin	Ecole йlementaire	NC	2 (dont 1 pour le prйau couvert)	2	854 mІ	133 йlиves et 7 enseignants	NC	RDC: 3,2 m |R+1: 3,2m	H1a	-7	Faзade sur cour intйrieure: Sud Est |Faзade sur rue: Sud Ouest	\N	Chauffage au gaz |	Ballons йlectriques dйcentralisйs |	Ventilation naturelle par infiltration |	\N	\N	\N	49.83832497	3.302746117	0101000020E6100000440CFC27066C0A40FCC88C3B4EEB4840
12	1	1	Mat et Elem	Groupe Scolaire Robert SCHUMAN 	Rue Berthollet	2100	Saint-Quentin	Etablissement scolaire	NC	3	1 а 4	3578 mІ	1.86	\N	RDC (logements): 3 m |RDC (autres bвtiments): 3,3 m |R+1: 2,6 m |R+2: 2,6 m |R+3: 2,5 m	H1a	-7	Est/Ouest	\N	Rйseau Urbain	Rйseau urbain + ballons ECS  |йlectrique dйcentralisй	Ventilation naturelle par infiltration | et ventilation mйcanique	Le groupe se divise en trois structures : |La maternelle et les logements |L’йcole йlйmentaire  |Le gymnase	\N	\N	49.85955634	3.295260072	0101000020E6100000D56F0850B15C0A404AAF30F105EE4840
13	1	2	Maternelle	Groupe Scolaire XAVIER AUBRYET 	10 rue Xavier AUBRYET	2100	Saint-Quentin	Ecole maternelle	NC	2	3 |(Sous-sol: Chaufferies |RDC |1 йtage: logement non occupй)	1135 mІ	137 йlиves et  |6 enseignants	NC	RDC: 2,8 m |R+1: 2,7 m	H1a	-7	Entrйe principale: Sud Est |	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.84194029	3.274043798	0101000020E61000002EA7F0DF3D310A400C5E0DB3C4EB4840
14	1	1	Mat et Elem	Groupe Scolaire Georges BACHY 	146 Rue d'??pargnemailles	2100	Saint-Quentin	Ecole maternelle et primaire |	NC	2	3	3074 mІ	0.67	NC	RDC: 3,15 m |R+1: 2,95 m |R+2: 2,95 m	H1a	-7	Sud-Ouest / Sud	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.85243183	3.272858262	0101000020E610000001DEFD4FD02E0A40B0F5777C1CED4840
15	1	1	Mat et Elem	Groupe Scolaire Ferdinand BUISSON 	80 Rue Henriette Cabot  et 82 Rue Henriette Cabot 	2100	Saint-Quentin	Ecole maternelle et primaire |	NC	3	2	2005 mІ	2	De 8h00 а 18h00, les lundi, mardi, jeudi et vendredi |	Primaire / Maternelle / CDDP: 2,95 m |	H1a	-7	Bвtiment Primaire: Est / Ouest |Bвtiment Maternelle et CDDP: Nord / Sud	\N	Chauffage au gaz |	Production йlectrique |	Ventilation naturelle par infiltration	\N	\N	\N	49.86134076	3.272359371	0101000020E61000000FA2F9BFCA2D0A40B574FD6940EE4840
16	1	1	Mat et Elem	Groupe Scolaire Alfred CLIN 	99 Rue de la Claie	2100	Saint-Quentin	Ecole primaire et maternelle |	1912	2	3 (Sous-Sol: Chaufferies et restaurant, RDC: Ecole, Etage: Ecole) |	2075 mІ	Ecole maternelle: 91 йlиves et 4 enseignants |Ecole йlementaire 143 йlиves et 9 enseignants	NC	Sous-sol: 2,5m |RDC: 2,8m |R+1: 2,8m	H1a	-7	Entrйe faзade Sud	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	Restauration en 1921 |	\N	\N	49.85645419	3.287315369	0101000020E610000004F20B006C4C0A403D49784AA0ED4840
17	1	1	Mat et Elem	Groupe Scolaire Ernest LAVISSE 	218 route de Paris	2100	Saint-Quentin	Ecole maternelle et primaire |	NC	2	1	2420 mІ	2.57	De 8h00 а 18h00, les lundi, mardi, jeudi et vendredi |	Primaire / Maternelle: 2,5 m	H1a	-7	Bвtiment principal: | Nord / Sud	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.83672999	3.265975714	0101000020E6100000314809E0B7200A40F350E3F719EB4840
18	1	1	Mat et Elem	Groupe Scolaire Lyon JUMENTIER	3 Rue des Glatiniers	2100	Saint-Quentin	Ecole maternelle et primaire  |	NC	1	3	2467 mІ	1.99	NC	RDC: 4 m  (salle de motricitй: 5,12 m) |R+1: 4m |R+2: 3,2 m	H1a	-7	Orientation multiple: |Bвtiment principal: Est/Ouest |Ailes adjacentes: Nord / Sud	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.84561068	3.284826279	0101000020E61000005EC50A0053470A40C9DF83F83CEC4840
20	1	2	Maternelle	Groupe Scolaire MONTPLAISIR	53 rue de la 3??me D.I.M	2100	Saint-Quentin	Ecolle maternelle	NC	1	2	807 mІ	0.85	NC	RDC: 3,5 m 	H1a	-7	Nord / Sud	\N	Chauffage au gaz |	Ballons йlectriques dйcentralisйs |	Ventilation naturelle par infiltration	Le bвtiment a йtй rйnovй (Aoыt 2011) |	\N	\N	49.85091514	3.275696039	0101000020E61000004922F91FA0340A4052FC8CC9EAEC4840
21	1	2	Maternelle	Groupe Scolaire MONTESSORI	1 rue Fran??ois Adrien Boieldieu	2100	Saint-Quentin	Ecole maternelle	NC	1	2 (RDC et SS)	707 mІ	62 enfants + 3 enseignants |	NC	Sous-sol: 2,5 m |RDC: 2,6 m |Etage logement: 2,5 m	H1a	-7	Entrйe principale: Est	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.85284688	3.269489408	0101000020E6100000C4D30F10EA270A403E0C29162AED4840
22	1	3	El??mentaire	Groupe Scolaire AMEDEE OZENFANT	61 rue des Patriotes	2100	Saint-Quentin	Accueil d'enfants 	NC	1	3 (Sous-sol, RDC et R+1) |	1074 mІ	0.52	De 7h30 а 18h00, du lundi au vendredi |	Salles: 3,8 m	H1a	-7	Sud - Nord	\N	Chauffage au gaz |	Production йlectrique |	Ventilation naturelle par infiltration	\N	\N	\N	49.84287089	3.290448189	0101000020E6100000DA7F0780D6520A4074A67D31E3EB4840
23	1	3	El??mentaire	Groupe Scolaire PARINGAULT	1 rue de la 3??me D.I.M	2100	Saint-Quentin	Ecole йlementaire	NC	3	2	1381 mІ	1.1	NC	RDC: 3,7 m |R+1: 3,8 m	H1a	-7	Orientation multiple  |Bвtiment principal: Nord Ouest / Sud Est	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.84875503	3.276940584	0101000020E61000009CB8F99F2C370A402F153C01A4EC4840
24	1	2	Maternelle	Groupe Scolaire des PATRIOTES	38 bis et 40 rue des Patriotes	2100	Saint-Quentin	Accueil d'enfants	NC	1	1	797 mІ	0.63	De 7h30 а 18h00, du lundi au vendredi |	Salles: 3,7 m	H1a	-7	3 faзades: |Sud, Est, Ouest (le Nord est mitoyen)	\N	Chauffage au gaz |	Production йlectrique |	Ventilation naturelle par infiltration |	\N	\N	\N	49.84382655	3.288887143	0101000020E6100000E85BFB0FA44F0A408EDF258202EC4840
25	1	1	Mat et Elem	Groupe Scolaire Jacques PREVERT	Rue de l'Eglise (Oestres)	2100	Saint-Quentin	Ecole primaire et maternelle |	NC	2	3 (Sous-sol: Chaufferies |RDC |1 йtage: logement non occupй)	752 mІ	Maternelle: 26 enfants |Primaire: 63 enfants |Enseignants: 3 professeurs	NC	RDC: 2,9 m	H1a	-7	Entrйe principale: |Ecole maternelle: Nord |Ecole йlйmentaire: Nord Est	Eole maternelle: 408 mІ |Ecole primaire: 344 mІ	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	\N	\N	\N	49.82885813	3.257902265	0101000020E610000023EA0D102F100A40D6AFF00518EA4840
26	1	3	El??mentaire	Groupe Scolaire THELLIER DESJARDINS	1 rue de Flandre 	2100	Saint-Quentin	Ecole йlйmentaire	NC	2	2 (4 pour la partie logement) |	2083 mІ	1.08	NC	4 m	H1a	-7	Sud-Ouest / Nord-Ouest |	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration et ventilation simple flux dans les sanitaires |	\N	\N	\N	49.84070523	3.274092078	0101000020E61000004AD2F82F57310A408C369E3A9CEB4840
27	1	3	El??mentaire	Groupe Scolaire DAVID et MAIGRET 	106 rue de Normandie	2100	Saint-Quentin	Hйbergement d'associations |	NC	2	2	582 mІ	2.86	De 8h30 а 17h45 |	RDC: 3,5 m |RDC bвtiment prй-fabriquй: 2,5 m |R+1: 3,5 m	H1a	-7	Bвtiment principal: Sud-ouest / Nord-Est |	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration |	Prйsence d'un bвtiment en prй-fabriquй sur la parcelle abritant une ancienne classe, d'une date de construction postйrieure au groupe scolaire.  |Le groupe scolaire fait office aujourd'hui de local d'hйbergement pour diffйrentes associations	\N	\N	49.85619048	3.271028996	0101000020E6100000A4B31040112B0A408F5F4FA697ED4840
28	1	4	Dessin	Groupe Scolaire Maurice-Quentin de la TOUR	1 rue Gabriel Girodon	2100	Saint-Quentin	\N	\N	\N	\N	\N	\N	\N	\N	H1a	-7	\N	\N	\N	\N	\N	\N	\N	\N	49.85619048	3.271028996	0101000020E6100000A4B31040112B0A408F5F4FA697ED4840
29	1	2	Maternelle	Groupe Scolaire Benjamin Rouche	284 rue Jacques Blanchot	2100	Saint-Quentin	Accueil d'enfants	1980	1	1	680 mІ	0.78	De 7h30 а 18h00, du lundi au vendredi |	Salles: 2,6 m |Prйau: 4,9 m	H1a	-7	4 faзades йgalement orientйs |	\N	Chauffage au gaz |	Production йlectrique |	Ventilation naturelle par infiltration	\N	\N	\N	49.85619135	3.271028996	0101000020E6100000A4B31040112B0A401EAF9BAD97ED4840
30	1	2	Maternelle	Groupe Scolaire Pauline KERGOMARD	Rue Charles Gomard	2100	Saint-Quentin	Ecole maternelle	NC	1	3	795 mІ	2.11	De 8h30 а 16h30 |	RDJ: 2,9 m |RDC: 2,9 m |R+1: 2,9 m	H1a	-7	Sud / Nord	\N	Chauffage au gaz |	Ballons йlectrique dйcentralisй |	Ventilation naturelle par infiltration	L'йcole va fermer dans un futur proche, ce bвtiment devrait intйgrer les effectifs du centre de Loisir Plein Air situй rue de Phalsbourg. |Le logement situй au-dessus de l'йcole maternelle n'est pas occupй. Son йtat actuel le rend inhabitable	\N	\N	49.85438598	3.278622329	0101000020E61000003EECF7579E3A0A40662111855CED4840
31	1	5	Musique	Ecole nationale de Musique - Conservatoire	51 rue d'Isle	2100	Saint-Quentin	\N	\N	\N	\N	\N	\N	\N	\N	H1a	-7	\N	\N	\N	\N	\N	\N	\N	\N	49.84444836	3.291486204	0101000020E61000004C520BB8F6540A4030AE44E216EC4840
32	1	5	Spectacle	La Manufacture	8 rue Paul Codos	2100	Saint-Quentin	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	49.85443095	3.270347714	0101000020E6100000496DF10FAC290A4059784DFE5DED4840
\.


--
-- Data for Name: building_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.building_type (id, name, comments) FROM stdin;
1	Schools	No comments
\.


--
-- Data for Name: knex_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knex_migrations (id, name, batch, migration_time) FROM stdin;
1	20181029122036_messages.js	1	2018-10-29 14:51:35.598+01
\.


--
-- Data for Name: knex_migrations_lock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.knex_migrations_lock (index, is_locked) FROM stdin;
1	0
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, title, message, sender_id, receiver_id, created_at, updated_at) FROM stdin;
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
-- Data for Name: user_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_types (type_name) FROM stdin;
admin
user
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, type) FROM stdin;
6	Sheyar	sheyar@gmail.com	$2a$10$PsoveFZPWZhcRc/KsGUDHOcBrbBmnzhBRzmENoPQEVpAG.SeQwKwi	admin
3	Jamil	jamil@gamil.com	$2a$10$cmfIla27yqdm2dn1xD3dQ.31EjQ8ZqpV/3LmFCYdEK81XdTzBMHFG	user
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
-- Name: building_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.building_type_id_seq', 1, false);


--
-- Name: knex_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.knex_migrations_id_seq', 1, true);


--
-- Name: knex_migrations_lock_index_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.knex_migrations_lock_index_seq', 1, true);


--
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


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
-- Name: knex_migrations_lock knex_migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knex_migrations_lock
    ADD CONSTRAINT knex_migrations_lock_pkey PRIMARY KEY (index);


--
-- Name: knex_migrations knex_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.knex_migrations
    ADD CONSTRAINT knex_migrations_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: user_types user_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_types
    ADD CONSTRAINT user_types_pkey PRIMARY KEY (type_name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: building_gist; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX building_gist ON public.building USING gist (geom);


--
-- Name: messages_receiver_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_receiver_id_index ON public.messages USING btree (receiver_id);


--
-- Name: messages_sender_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX messages_sender_id_index ON public.messages USING btree (sender_id);


--
-- Name: users fk_user_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_user_type FOREIGN KEY (type) REFERENCES public.user_types(type_name);


--
-- Name: messages messages_receiver_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_receiver_id_foreign FOREIGN KEY (receiver_id) REFERENCES public.users(id);


--
-- Name: messages messages_sender_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_sender_id_foreign FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

