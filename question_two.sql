--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.8
-- Dumped by pg_dump version 9.5.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: farm_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE farm_details (
    id integer NOT NULL,
    plot_size character varying(100),
    harvesting_date date,
    sampling_date date,
    spacing character varying(100),
    stand_count_at_harvest double precision,
    "no_of_ plants_harvest" double precision,
    "total_biomass_fwt_(kg)" double precision,
    "total_grain_fwt_(kg)" double precision,
    "total _stems_and_shelled_pods_fwt_(kg)" double precision,
    "stems _shelled_ pods_ sample_ fwt_ (g)" double precision,
    "stems_shelled_pods_ sample_oven_ dwt_ (g)" double precision,
    "field_grain_sample_fwt_(g)" double precision,
    "field_grain_sample_oven_dwt_(g)" double precision,
    "total_stems _shelled_pods_oven_dwt_(kg)" double precision,
    "total_grain_oven_dwt_(kg)" double precision,
    "total_biomass_oven_dwt_(kg)" double precision,
    farmers_name character varying(100),
    variety character varying(100),
    farm_managemnent_category character varying(100),
    crop character varying(100),
    cropping_system character varying(100)
);


ALTER TABLE farm_details OWNER TO postgres;

--
-- Name: average_harvest; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW average_harvest AS
 SELECT avg(farm_details."no_of_ plants_harvest") AS avg_harvest
   FROM farm_details;


ALTER TABLE average_harvest OWNER TO postgres;

--
-- Name: farm_details_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE farm_details_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE farm_details_id_seq OWNER TO postgres;

--
-- Name: farm_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE farm_details_id_seq OWNED BY farm_details.id;


--
-- Name: highest_and_lowest_total_biomass_fwt_kg; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW highest_and_lowest_total_biomass_fwt_kg AS
 SELECT farm_details.farmers_name,
    farm_details."total_biomass_fwt_(kg)"
   FROM farm_details
  WHERE ((farm_details."total_biomass_fwt_(kg)" = ( SELECT min(farm_details_1."total_biomass_fwt_(kg)") AS min
           FROM farm_details farm_details_1)) OR (farm_details."total_biomass_fwt_(kg)" = ( SELECT max(farm_details_1."total_biomass_fwt_(kg)") AS max
           FROM farm_details farm_details_1)));


ALTER TABLE highest_and_lowest_total_biomass_fwt_kg OWNER TO postgres;

--
-- Name: order_by_harvest_date; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW order_by_harvest_date AS
 SELECT farm_details.id,
    farm_details.plot_size,
    farm_details.harvesting_date,
    farm_details.sampling_date,
    farm_details.spacing,
    farm_details.stand_count_at_harvest,
    farm_details."no_of_ plants_harvest",
    farm_details."total_biomass_fwt_(kg)",
    farm_details."total_grain_fwt_(kg)",
    farm_details."total _stems_and_shelled_pods_fwt_(kg)",
    farm_details."stems _shelled_ pods_ sample_ fwt_ (g)",
    farm_details."stems_shelled_pods_ sample_oven_ dwt_ (g)",
    farm_details."field_grain_sample_fwt_(g)",
    farm_details."field_grain_sample_oven_dwt_(g)",
    farm_details."total_stems _shelled_pods_oven_dwt_(kg)",
    farm_details."total_grain_oven_dwt_(kg)",
    farm_details."total_biomass_oven_dwt_(kg)",
    farm_details.farmers_name,
    farm_details.variety,
    farm_details.farm_managemnent_category,
    farm_details.crop,
    farm_details.cropping_system
   FROM farm_details
  ORDER BY farm_details.harvesting_date;


ALTER TABLE order_by_harvest_date OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY farm_details ALTER COLUMN id SET DEFAULT nextval('farm_details_id_seq'::regclass);


--
-- Data for Name: farm_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY farm_details (id, plot_size, harvesting_date, sampling_date, spacing, stand_count_at_harvest, "no_of_ plants_harvest", "total_biomass_fwt_(kg)", "total_grain_fwt_(kg)", "total _stems_and_shelled_pods_fwt_(kg)", "stems _shelled_ pods_ sample_ fwt_ (g)", "stems_shelled_pods_ sample_oven_ dwt_ (g)", "field_grain_sample_fwt_(g)", "field_grain_sample_oven_dwt_(g)", "total_stems _shelled_pods_oven_dwt_(kg)", "total_grain_oven_dwt_(kg)", "total_biomass_oven_dwt_(kg)", farmers_name, variety, farm_managemnent_category, crop, cropping_system) FROM stdin;
1	6x4 m2	2015-08-12	2015-10-22	45×10 cm	367	367	6	3.29999999999999982	2.70000000000000018	124	108	1234	1089	2.35000000000000009	2.91000000000000014	5.25999999999999979	Jane Nyambura	Wairimu	Low	Beans	Sole
2	6x4 m2	2015-09-21	2015-10-23	60×5 cm	222	222	1.10000000000000009	0	1.10000000000000009	338	217	0	0	0.709999999999999964	0	0.709999999999999964	Christopher Macharia	Kifam	Low	Maize	Sole
3	6x4 m2	2015-08-12	2015-10-22	65×35 cm	127	127	8.5	4.59999999999999964	3.89999999999999991	291	257	1046	953	3.43999999999999995	4.19000000000000039	7.63999999999999968	Mary Mbatia	Kifam	Medium	Beans	Sole
4	6x4 m2	2015-07-27	2015-10-23	60×30 cm	148	148	5	2.60000000000000009	2.39999999999999991	266	235	1001	906	2.12000000000000011	2.35000000000000009	4.46999999999999975	Mary Mbatia	KAT B2	Medium	Beans	Sole
5	6x4 m2	2015-07-10	2015-10-23	50×20cm	387	387	8.40000000000000036	4	4.40000000000000036	113	96	644	579	3.74000000000000021	3.60000000000000009	7.33000000000000007	Josphat Kangethe	Gituru Kanini	Medium	Maize	Sole
6	6x4 m2	2015-08-13	2015-10-23	45×20 cm	280	280	4.59999999999999964	1.30000000000000004	3.29999999999999982	163	143	565	506	2.89999999999999991	1.15999999999999992	4.05999999999999961	Joseph Kiarie	Kifam	Medium	Beans	Sole
7	6x4 m2	2015-08-25	2015-10-24	40×30cm	223	223	9.90000000000000036	4.90000000000000036	5	332	284	1444	1383	4.28000000000000025	4.69000000000000039	8.97000000000000064	Francis Karanja	Gituru Kanini	Medium	Beans	Sole
8	6x4 m2	2015-08-15	2015-10-24	40×20cm	252	252	7	2.5	4.5	388	336	1009	912	3.89999999999999991	2.25999999999999979	6.16000000000000014	Francis Karanja	Rose Coco	Medium	Maize	Sole
9	6x4 m2	2015-08-13	2015-10-24	40×15cm	264	264	7.09999999999999964	3.60000000000000009	3.5	234	202	1387	1262	3.02000000000000002	3.2799999999999998	6.29999999999999982	Patrick Mbirwe	Kifam	High	Maize	Sole
10	6x4 m2	2015-08-13	2015-10-23	40×20 cm	247	247	5	2.70000000000000018	2.29999999999999982	172	152	1574	1419	2.0299999999999998	2.43000000000000016	4.46999999999999975	Wairimu Kanyiri	Kifam	High	Beans	Sole
11	6x4 m2	2015-08-12	2015-10-24	60×30cm	129	129	2	1	1	146	128	270	240	0.880000000000000004	0.890000000000000013	1.77000000000000002	George Kahuho	Kifam	Medium	Maize	intercrop
12	6x4 m2	2015-08-13	2015-10-22	75×50cm	189	189	2.29999999999999982	0.800000000000000044	1.5	107	93	314	278	1.30000000000000004	0.709999999999999964	2.00999999999999979	Josphat Kangethe	Kifam	Medium	Beans	intercrop
\.


--
-- Name: farm_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('farm_details_id_seq', 12, true);


--
-- Name: farm_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY farm_details
    ADD CONSTRAINT farm_details_pkey PRIMARY KEY (id);


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

