--
-- PostgreSQL database dump
--

-- Dumped from database version 14.6 (Ubuntu 14.6-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.6 (Ubuntu 14.6-0ubuntu0.22.04.1)

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
-- Name: Priority; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Priority" AS ENUM (
    'NULA',
    'BAJA',
    'MEDIA',
    'ALTA',
    'URGENTE',
    'INACTIVO'
);


ALTER TYPE public."Priority" OWNER TO postgres;

--
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'USER',
    'ADMIN'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- Name: Tracing; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Tracing" AS ENUM (
    'ACEPTA_CARGO',
    'ACTO_PERICIAL_REALIZADO',
    'PERICIA_REALIZADA',
    'SENTENCIA_O_CONVENIO_DE_PARTES',
    'HONORARIOS_REGULADOS',
    'EN_TRATATIVA_DE_COBRO',
    'COBRADO'
);


ALTER TYPE public."Tracing" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Court; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Court" (
    id integer NOT NULL,
    name text NOT NULL,
    city text,
    judge text,
    address text,
    "districtId" integer
);


ALTER TABLE public."Court" OWNER TO postgres;

--
-- Name: Court_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Court_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Court_id_seq" OWNER TO postgres;

--
-- Name: Court_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Court_id_seq" OWNED BY public."Court".id;


--
-- Name: District; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."District" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."District" OWNER TO postgres;

--
-- Name: District_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."District_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."District_id_seq" OWNER TO postgres;

--
-- Name: District_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."District_id_seq" OWNED BY public."District".id;


--
-- Name: Note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Note" (
    id integer NOT NULL,
    name text,
    text text NOT NULL,
    "recordId" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Note" OWNER TO postgres;

--
-- Name: Note_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Note_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Note_id_seq" OWNER TO postgres;

--
-- Name: Note_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Note_id_seq" OWNED BY public."Note".id;


--
-- Name: Office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Office" (
    id integer NOT NULL,
    name text NOT NULL,
    "courtId" integer
);


ALTER TABLE public."Office" OWNER TO postgres;

--
-- Name: Office_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Office_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Office_id_seq" OWNER TO postgres;

--
-- Name: Office_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Office_id_seq" OWNED BY public."Office".id;


--
-- Name: Record; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Record" (
    id integer NOT NULL,
    name text NOT NULL,
    "order" text,
    tracing public."Tracing" DEFAULT 'ACEPTA_CARGO'::public."Tracing" NOT NULL,
    priority public."Priority" DEFAULT 'NULA'::public."Priority" NOT NULL,
    archive boolean DEFAULT false NOT NULL,
    favorite boolean DEFAULT false NOT NULL,
    defendant text[],
    prosecutor text[],
    insurance text[],
    "officeId" integer,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."Record" OWNER TO postgres;

--
-- Name: Record_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Record_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Record_id_seq" OWNER TO postgres;

--
-- Name: Record_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Record_id_seq" OWNED BY public."Record".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    email text NOT NULL,
    name text,
    verified boolean DEFAULT false NOT NULL,
    role public."Role" DEFAULT 'USER'::public."Role" NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Court id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Court" ALTER COLUMN id SET DEFAULT nextval('public."Court_id_seq"'::regclass);


--
-- Name: District id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."District" ALTER COLUMN id SET DEFAULT nextval('public."District_id_seq"'::regclass);


--
-- Name: Note id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note" ALTER COLUMN id SET DEFAULT nextval('public."Note_id_seq"'::regclass);


--
-- Name: Office id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Office" ALTER COLUMN id SET DEFAULT nextval('public."Office_id_seq"'::regclass);


--
-- Name: Record id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Record" ALTER COLUMN id SET DEFAULT nextval('public."Record_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Court; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Court" (id, name, city, judge, address, "districtId") FROM stdin;
2	JUZGADO CIVIL 1	Oberá	Ricardo Alfredo Cassoni	Calle Salto Bielakowicz y calle Salto Zinas | Primer piso	1
3	JUZGADO CIVIL 2	Oberá	Mónica Viviana Drganc Fernandez	Misiones y Bolivia	1
4	JUZGADO CIVIL 3	Oberá	Ecaterina Donchenko	Misiones y Bolivia	1
5	JUZGADO DE FAMILIA 1	Oberá	José Gabriel Moreira	Calle Salto Bielakowicz y calle Salto Zinas | Primer Piso	1
6	JUZGADO DE PAZ	Oberá	Gladys M. Sanchez	Ecuador 1465 PB	1
1	JUZGADO LABORAL	Oberá	Silvio Marcial Amarilla	Rivadavia N° 1142	1
\.


--
-- Data for Name: District; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."District" (id, name) FROM stdin;
1	Segunda
\.


--
-- Data for Name: Note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Note" (id, name, text, "recordId", "createdAt", "updatedAt") FROM stdin;
1	\N	11/15: Salió Regulación $ 9.000.- 	5	2022-11-27 04:28:24.038	2022-11-27 04:28:24.039
2	\N	Notificación de 06/17: Regula 2 SMVM	4	2022-11-27 04:28:58.082	2022-11-27 04:28:58.083
3	\N	¡SALIÓ SENTENCIA Y REGULACIÓN! 3 SMVM	3	2022-11-27 04:29:08.889	2022-11-27 04:29:08.89
4	\N	¡DANGER! ¿Hice la pericia?	6	2022-11-27 04:31:15.381	2022-11-27 04:31:15.381
5	\N	04/19: Regulado $ 5.000.- 	7	2022-11-27 04:32:03.248	2022-11-27 04:32:03.249
6	\N	REGULADO $ 5.000.- Accionar	8	2022-11-27 04:54:17.499	2022-11-27 04:54:17.5
7	\N	Regulado $ 5.000.- 04/19: ¡A moverse! 	9	2022-11-30 18:23:12.806	2022-11-30 18:23:12.806
8	\N	25/04/16: Salió regulación de honorarios: $ 9.000.- 	10	2022-11-30 18:25:29.692	2022-11-30 18:25:29.692
9	\N	Visto en 10/18: Hay SENTENCIA del 2015 – Pido Regulación (¿Incobrable?) 	11	2022-11-30 18:26:45.726	2022-11-30 18:26:45.726
10	\N	Regulación //04/19: Regula 1 SMVM – Hay que notificar y EJECUTAR	12	2022-11-30 18:29:42.525	2022-11-30 18:29:42.526
11	\N	 04/19: No hay movimientos  - Ver con Judais 	13	2022-11-30 18:32:35.295	2022-11-30 18:32:35.295
12	\N	11/18: A Carísimo – Ejecutar	15	2022-11-30 18:38:33.056	2022-11-30 18:38:33.057
13	\N	Regulado: $ 9.000.- 11/18: Está archivado – A Carísimo	16	2022-11-30 19:14:43.406	2022-11-30 19:14:43.406
14	\N	Está archivado – A Carísimo – FIRME -  Regulado 2 SMVM  (A)	17	2022-11-30 19:17:04.635	2022-11-30 19:17:04.636
15	\N	11/18:SENTENCIA Regula $ 15.000.- A COBRAR	18	2022-11-30 19:18:16.272	2022-11-30 19:18:16.273
16	\N	ESTÁ PARA SENTENCIA	19	2022-11-30 19:20:07.274	2022-11-30 19:20:07.274
17	\N	Solicito regulación	20	2022-11-30 19:21:00.63	2022-11-30 19:21:00.631
18	\N	LA CAJA-ART – EXPERTA    	21	2022-11-30 19:26:01.305	2022-11-30 19:26:01.306
19	\N	 06/17: Hay SENTENCIA – Sale Regulación (bajo): REVOCATORIA Y APELACIÓN	22	2022-11-30 19:28:53.956	2022-11-30 19:28:53.956
20	\N	12/18: Regula 7.928	23	2022-11-30 19:30:37.947	2022-11-30 19:30:37.947
21	\N	11/18: En Apelación	24	2022-11-30 19:34:18.414	2022-11-30 19:34:18.415
22	\N	11/18: Pido nueva regulación	25	2022-11-30 19:37:21.038	2022-11-30 19:37:21.039
23	\N	¡¡¡¡ ATENTI !!! salió regulación: $ 7.000.-	26	2022-11-30 19:43:05.429	2022-11-30 19:43:05.43
24	\N	12/19: SENTENCIA Regula como Perito a Dr. José M. Valdez - VER	27	2022-11-30 19:44:10.133	2022-11-30 19:44:10.134
25	\N	Regula $ 19.990.- Notificado 01/06/18 ¡¡¡DANGER!!!	28	2022-11-30 19:45:25.296	2022-11-30 19:45:25.296
26	\N	08/18: SENTENCIA – Regulación $ 7.009,85.-	29	2022-11-30 19:46:10.307	2022-11-30 19:46:10.308
27	\N	03/18: SENTENCIA  - Regula: 2SMVM	30	2022-11-30 19:47:08.653	2022-11-30 19:47:08.654
28	\N	11/18: HAY SENTENCIA – Regula 2% de monto actualizado    	31	2022-11-30 19:48:05.713	2022-11-30 19:48:05.714
29	\N	02/18: SALIÓ SPI – Regula 2 SMVM – FIRME – A COBRAR	32	2022-11-30 19:51:53.425	2022-11-30 19:51:53.425
30	\N	08/20: En Cámara	34	2022-11-30 19:53:51.887	2022-11-30 19:53:51.888
31	\N	SENTENCIA 12/17: 2 SMVM	36	2022-11-30 19:56:49.002	2022-11-30 19:56:49.002
32	\N	APELADO	38	2022-11-30 19:59:12.407	2022-11-30 19:59:12.408
33	\N	06/16: Solicito Regulación de Honorarios	39	2022-11-30 20:00:05.05	2022-11-30 20:00:05.051
34	\N	05/20: Sale sentencia y Regula 2 SMVM – Firme. Paso a Carísimo	40	2022-11-30 20:03:52.348	2022-11-30 20:03:52.348
35	\N	 04/19: Regulado $ 18.446,73 - APELADO	41	2022-11-30 20:08:37.472	2022-11-30 20:08:37.472
36	\N	Recibí de la Demanda: $ 1.800.-	42	2022-11-30 20:09:54.392	2022-11-30 20:09:54.392
37	\N	02/07/15: Entrego recibo por $ 3.000.- Recibí de ART $ 3.000.- (Saldo $ 200.-)	43	2022-11-30 20:11:54.668	2022-11-30 20:11:54.668
38	\N	09/18:  SENTENCIA REGULADO – 3-SMVM	45	2022-11-30 20:21:38.757	2022-11-30 20:21:38.758
39	\N	09/17: SPI: 2-SMVM	46	2022-11-30 20:23:47.547	2022-11-30 20:23:47.548
40	\N	Sol. $ 3.500.- (Mortimer) ¡¡¡¡ ATENTI !!!	47	2022-11-30 20:25:17.806	2022-11-30 20:25:17.807
41	\N	Presento escrito invocando tema La Segunda 	48	2022-11-30 20:26:55.126	2022-11-30 20:26:55.127
42	\N	06/20: Regulado $ 7.000.- Pido libre testimonio – A Carísimo	49	2022-11-30 20:28:45.719	2022-11-30 20:28:45.72
43	\N	11/15 Solicitado Regulación de Honorarios 	50	2022-11-30 20:30:46.539	2022-11-30 20:30:46.539
44	\N	COBRADO a Letrado Actora: $ 2.000.- (¿)\n	51	2022-11-30 20:32:00.606	2022-11-30 20:32:00.606
45	\N	Realizada Actor abona $ 800 + $ 950.-	52	2022-11-30 20:33:37.126	2022-11-30 20:33:37.126
46	\N	06/17: Hay arreglo: PIDO REGULACIÓN	53	2022-11-30 20:35:57.766	2022-11-30 20:35:57.766
47	\N	COBRADO (16/12) – Actor abona: $2.500.-	54	2022-11-30 20:38:30.877	2022-11-30 20:38:30.877
48	\N	 Sol. $ 3.500.- SI	55	2022-11-30 20:42:47.742	2022-11-30 20:42:47.743
49	\N	11/18: SENTENCIA – Regula 6%	56	2022-11-30 20:44:02.404	2022-11-30 20:44:02.404
50	\N	Acuerdo Homologado. En fecha 02/17 solicito regulación – Regulado 1- SMVM	57	2022-11-30 20:45:53.817	2022-11-30 20:45:53.818
51	\N	Recibido de Let. actor: $ 2.500.-	58	2022-11-30 20:47:00.471	2022-11-30 20:47:00.471
52	\N	Demandada abona $ 2.250.-	59	2022-11-30 20:47:45.909	2022-11-30 20:47:45.91
53	\N	En fecha 02/17 solicito regulación Regulado 1 SMVM	60	2022-11-30 20:48:32.56	2022-11-30 20:48:32.561
54	\N	Actor abona: $ 1.750.- Realizada	61	2022-11-30 20:52:30.218	2022-11-30 20:52:30.219
55	\N	Sentencia: Rechaza Demanda y regula	62	2022-11-30 21:20:47.219	2022-11-30 21:20:47.22
56	\N	ARREGLO HOMOLOGADO	63	2022-11-30 21:24:12.107	2022-11-30 21:24:12.108
57	\N	(03/17) PEDIDO DE REGULACIÓN – REGULADO 2 SMVM	64	2022-11-30 21:26:24.735	2022-11-30 21:26:24.736
59	\N	Actor: Emilse (Abona: $ 2.500.-)	66	2022-11-30 21:31:08.984	2022-11-30 21:31:08.985
60	\N	04/17: HAY SENTENCIA- Regulado: 2 SMVM	67	2022-11-30 21:31:53.125	2022-11-30 21:31:53.126
61	\N	12/20: Sentencia regula 6%	68	2022-11-30 21:38:49.933	2022-11-30 21:38:49.934
62	\N	Sentencia: Rechaza Demanda y regula 	69	2022-11-30 21:43:07.091	2022-11-30 21:43:07.092
63	\N	(03/17) PEDIDO DE REGULACIÓN: REGULADO 1 SMVM	70	2022-11-30 21:45:45.503	2022-11-30 21:45:45.504
65	\N	Ojo al piojo: no hubo acto pericial	72	2022-11-30 21:50:41.748	2022-11-30 21:50:41.749
66	\N	03/18: SALIÓ SENTENCIA – Regula 3 SMVM	73	2022-11-30 21:57:35.899	2022-11-30 21:57:35.899
68	\N	Ultimo movimiento en Agosto del 2020 la parte actora denuncia nuevo domicilio	72	2022-12-22 11:47:22.025	2022-12-22 11:47:22.117
69	\N	Pedir vinculación	71	2022-12-22 11:49:09.63	2022-12-22 11:49:09.631
71	\N	Sentencia de Noviembre /22, Regularon el 6% del capital de sentencia.	75	2022-12-22 12:09:25.214	2022-12-22 12:09:25.215
72	\N	Con movimientos de apertura de cuenta y notificación de la sentencia	75	2022-12-22 12:10:07.438	2022-12-22 12:10:07.438
73	\N	24/11/22 Salio sentencia Rechazada. Regularon $24.842,16 de honorario.	76	2022-12-22 13:51:03.061	2022-12-22 13:51:03.062
74	\N	14/12/22 sentencia a favor del actor. Figura el Dr. Zampa como Perito Médico. \nEn fecha 09/10/21 figura que se presento el informe pericial. y 20/12/21 se corrió Traslado.\nHay que pedir que corroboren el nombre en la sentencia o solicitar le Regulen los honorarios.	77	2022-12-22 14:51:05.72	2022-12-22 14:51:05.721
70	\N	Hay depositado 16.500 pero no dieron lugar para librar orden de pago ya que corresponde al anticipo por parte de la demandada  y es extemporáneo.	74	2022-12-22 11:57:12.861	2022-12-29 18:00:55.698
99	\N	En enero del 2021 abonaron a la parte actora $225.687,57.\nActualizar planilla y hablar con Vazquez? o pesarla a Villaverde?	89	2023-01-04 13:42:37.343	2023-01-04 13:42:37.344
100	\N	Falta notificar los honorarios para que quede firme.\n\nPase fotos de la resolución al Dr. Villaverde (18/11)	90	2023-01-04 13:48:46.953	2023-01-04 13:50:18.01
101	\N	Hay acuerdo x $170 mil, se le abono al actor.\n	37	2023-01-04 14:42:03.23	2023-01-04 14:42:03.231
102	\N	Hay que notificar la R.H.	37	2023-01-04 14:42:30.009	2023-01-04 14:42:30.009
103	\N	Saque fotos de la sentencia donde regulan los Honorarios, y las respectivas notificaciones.	26	2023-01-04 14:44:20.021	2023-01-04 14:44:20.021
218	\N	Solicito estudio complementarios.	227	2023-02-06 11:45:22.21	2023-02-06 11:45:22.21
219	\N	Con movimientos de etapa probatoria.	228	2023-02-06 11:56:14.018	2023-02-06 11:56:14.019
104	\N	Hay depositado en la cuenta 5 mil, correspondiente a los adelantos de Gastos periciales.  Hay que adjuntar constancia de titularidad de caja de ahorro y CBU.\n	92	2023-01-04 14:54:38.312	2023-01-04 14:54:38.312
105	\N	El 21/12 salio con Regulacion de Honorario x el monto de $72 mil + $ 15.120 correspondiente al IVA.	93	2023-01-04 15:01:08.361	2023-01-04 15:01:08.361
106	\N	Hablar con el abogado de Prevención para apurar el pago? o pasar a Villaverde para que notifique la regulación?	93	2023-01-04 15:03:01.427	2023-01-04 15:03:01.428
107	\N	Esta depositado el IVA $ 9.174,33. Volver a preguntar por la transferencia? Angélica dijo en su momento que era automático después de que volvía de auditoria, y todavía no transfirieron.	95	2023-01-05 11:31:48.169	2023-01-05 11:31:48.17
108	\N	Hay depositado 6 mil, el cual corresponde 3 mil, ya que según el secretario del juzgado habías manifestado en un escrito la percepción de los honorarios de manera extrajudicial	96	2023-01-05 11:53:42.454	2023-01-05 11:53:42.455
109	\N	Hay que presentar un escrito y solicitar la transferencia, manifestando el N° de cuenta y CBU.	96	2023-01-05 11:54:54.341	2023-01-05 11:54:54.342
110	\N	Se tiene que notificar de la regulación y notificar a las otras partes para que quede firme.	25	2023-01-05 12:02:35.861	2023-01-05 12:02:35.862
111	\N	Regularon 3 SMVM, en el expediente figuran las cédulas a todas las partes menos a usted. \nVer en el bibliorato si no esta la cédula, sino habría que notificarse.  	97	2023-01-05 12:14:42.354	2023-01-05 12:14:42.355
112	\N	Esta para dictar sentencia	98	2023-01-05 13:39:46.004	2023-01-05 13:39:46.005
113	\N	En fecha 08/01/23 subo al SIGED solicitud de intimar a depositar los fondos y librar orden de pago	97	2023-01-08 17:39:38.55	2023-01-08 17:39:38.551
114	\N	En fecha 08/01/23 REITERO solicitud de librar orden de pago por IVA	95	2023-01-08 17:40:21.652	2023-01-08 17:40:21.653
115	\N	En fecha 08/01/23 solicito libre orden por AG	96	2023-01-08 17:40:47.018	2023-01-08 17:40:47.018
116	\N	08/01/23: mando w-ap a Maxi Acosta para facturar. Esperando...	93	2023-01-08 17:52:32.563	2023-01-08 17:52:32.563
117	\N	En diciembre/22 hice planteo verbal ante proveyente para la corrección del nombre del perito.	77	2023-01-08 21:21:50.908	2023-01-08 21:21:50.909
118	\N	Enero/23: Atenti la bocha, recordarme en marzo para hablar con Dr. Pradier y solicitar el pago	76	2023-01-08 21:25:03.879	2023-01-08 21:25:03.879
119	\N	Atenti!!! Recordarme en febrero este caso	75	2023-01-08 21:41:51.348	2023-01-08 21:41:51.349
121	\N	Regularon $80.154,90 en 11/21. La demanda salio rechazada. \nEsta para ejecucion de honorarios	102	2023-01-21 20:58:02.333	2023-01-21 20:58:02.333
122	\N	Regularon el 4%. Esta para ejecución de Honorarios.	103	2023-01-21 20:59:43.124	2023-01-21 20:59:43.125
123	\N	El 16/11/21 Regularon el 6% de 350mil que es el monto del acuerdo celebrado entre las partes.	104	2023-01-21 21:02:59.554	2023-01-21 21:02:59.554
124	\N	Se había hablado con los abogados de Prevención, pero quedo en la nada.	104	2023-01-21 21:04:30.313	2023-01-21 21:04:30.314
125	\N	ver fs. 635 punto II del fallo, para saber el porcentaje o monto de la regulación de  honorarios.	105	2023-01-21 21:09:39.585	2023-01-21 21:09:39.585
126	\N	16/11/21 Regularon 5% de lo que resulte la actualizacion del monto total a fs 550 que es la sentencia 9/4/19	106	2023-01-21 21:20:19.4	2023-01-21 21:20:19.401
127	\N	Por último el abogado de la parte actora solicito se libre testimonio. Habría que solicitar también para realizar ejecución de Honorario. Pero primero corroborar que todas las partes esten notificados de dichos honorarios 	106	2023-01-21 21:26:50.548	2023-01-21 21:26:50.548
128	\N	Expte. de San Vicente.  Se encuentra en cámara de apelaciones.\n regularon honorario en 6%  del monto actualizado de la sentencia	107	2023-01-21 21:34:01.934	2023-01-21 21:34:01.934
129	\N	En febrero/22 Regularon honorario x el monto de 55mil y quedo en eso.\nHabría que pasar a unos de los Dres. para que notifique la regulación/ o hablar con el Dr. Judais para ver si se da un arreglo.	108	2023-01-21 21:43:20.243	2023-01-21 21:43:20.243
130	\N	En mayo/22 salió Regulación por el monto de 13.629,00. Habría que pasar a alguno de los doctores para que realice la notificación.	109	2023-01-21 22:02:03.215	2023-01-21 22:02:03.216
131	\N	Expte. de San Vicente. Se solicito en mayo/22 que se regule honorario, salió providencia que expresaba que pasaban los autos a resolver y no se movió mas. Volver a reiterar Solicitud	110	2023-01-21 22:12:13.139	2023-01-21 22:12:13.139
132	\N	En agosto/22 R.H. x el 2.5% que equivale a 30.000 \nHay convenio de por medio x el monto de $1.200.000	111	2023-01-21 22:17:41.279	2023-01-21 22:17:41.28
133	\N	Hay que notificar la regulación para que quede firme.	111	2023-01-21 22:18:52.179	2023-01-21 22:18:52.18
134	\N	EL 31/10/22 ratificaron convenio x 900mil. Solicitar regulen los honorarios.	116	2023-01-22 12:08:16.423	2023-01-22 12:08:16.424
135	\N	Hay depositado 5mil, correspondiente a anticipo de gastos.\nAdjuntar constancia de titularidad de caja de ahorro y CBU	117	2023-01-22 12:11:41.593	2023-01-22 12:11:41.594
136	\N	Con solicitud de estudios complementarios.	119	2023-01-22 12:24:34.753	2023-01-22 12:24:34.754
137	\N	Se regulo honorarios en el convenio ratificado el 28/09/22 x el monto de 24mil correspondiente al 6% del convenio.  + 5mil de IVA	120	2023-01-22 12:32:18.854	2023-01-22 12:36:42.236
138	\N	Hay depositado 5mil, puede ser que corresponda a los anticipos de gastos o en su defecto al IVA, pero no veo movimiento de orden de pago librado a su nombre de ningun tipo	120	2023-01-22 12:37:40.452	2023-01-22 12:37:40.453
140	\N	Las partes  tiene que notificar a  BERKLEY INTERNATIONAL ART S.A para que suba a cámara y asi resolver el recurso de apelación. 	123	2023-01-27 23:37:45.618	2023-01-27 23:37:45.618
141	\N	Demanda rechazada, R.H. x  $ 19.990,24 en fecha (31/05/18)	123	2023-01-27 23:39:29.876	2023-01-27 23:39:29.877
142	\N	05/19 SENTENCIA RECHAZADA. R.H X $8.772 (6%)	54	2023-01-28 01:23:50.296	2023-01-28 01:23:50.296
143	\N	(03/19) R.H. en SENTENCIA x el 6%.  	58	2023-01-28 01:32:53.597	2023-01-28 01:32:53.597
144	\N	VERLO PERONALMENTE. Solo me figura la R.H. del Dr. rito (apoderado de la parte demandada)	59	2023-01-28 01:48:00.587	2023-01-28 01:48:00.588
145	\N	Solicito se libre testimonio, el cual se encuentra proveído. Pasa para ejecución?	60	2023-01-28 01:50:15.09	2023-01-28 01:50:15.091
58	\N	05/10/17 Regulado 1 SMVM. Solicitaron se libre testimonio, x lo que habrán echo un embargo. 	65	2022-11-30 21:27:44.844	2023-01-28 02:05:09.107
146	\N	SENTENCIA 19/04/2018 regularon 2SMVM. Demanda rechazada.	66	2023-01-28 02:08:58.004	2023-01-28 02:08:58.004
147	\N	Hay depositado $35.067,81. Pero me parece que este ya se encuentra abonado. Libraron orden de pago 06/22	124	2023-01-28 12:50:22.134	2023-01-28 12:56:00.578
148	\N	Solicitar nuevamente vinculación, porque no figura en el SIGED. \n	131	2023-01-28 14:31:21.339	2023-01-28 14:31:21.339
149	\N	Recibido del letrado del actor $4500	131	2023-01-28 14:31:42.238	2023-01-28 14:31:42.239
150	\N	R.H. X el monto de $30.609,99 el 07/08/19. Abonaron al actor en diciembre/19. ¿Hablar con los de Prevención?	135	2023-01-28 14:41:58.051	2023-01-28 14:41:58.051
151	\N	12/18 SPI C/ Pericia Impugnada. R.H. x el 2% $7515. a cargo de la Dra. Martin. Solicitar vinculación nuevamente	137	2023-01-28 14:47:46.341	2023-01-28 14:47:46.341
152	\N	Convenio, regulan 3 SMVM.  (18/08/17) Lo ultimo que figura es el cheque librado a la parte actora.	140	2023-01-28 15:00:24.835	2023-01-28 15:00:24.836
153	\N	Solicitar nuevamente Vinculacion. Sentencia regula 1 SMVM (02/19)	142	2023-01-28 15:11:49.388	2023-01-28 15:11:49.389
154	\N	Salio sentencia Rechazada.  Regularon  $55.024,56 equivalente al 6% de\nla base arancelaria fijada.	143	2023-01-28 15:13:53.659	2023-01-28 15:14:05.75
155	\N	Se encuentra sin movimiento desde el 2018, se habia solicitado regulen los honorarios, volver a presentar escrito.	144	2023-01-28 15:17:12.398	2023-01-28 15:17:12.399
156	\N	En la sentencia se R.H. x el 6%. Volver a solicitar la vinculación del expt.	145	2023-01-28 15:20:40.1	2023-01-28 15:20:40.101
157	\N	Hay depositado $ 38.522,29. Se realizo prorrateo de los honorarios 11/22 y el monto regulado quedo en 22.535,4, solicitar el IVA. 	146	2023-01-28 15:31:42.464	2023-01-28 15:31:42.464
158	\N	Intiman a adjuntar\nCONSTANCIA de cuenta bancaria de su titularidad, informando Nº de\ncuenta, CBU de la misma, e institución bancaria a la que pertenece	146	2023-01-28 15:32:13.953	2023-01-28 15:32:13.953
159	\N	Paso para el dictado de Sentencia en diciembre/22	147	2023-01-28 15:37:42.655	2023-01-28 15:37:42.655
160	\N	Sentencia regula en 6% $9.075,35 , al parecer no estamos notificados. No se visualiza cedula. hay que adjuntar CONSTANCIA DE CBU de caja de ahorro	148	2023-01-28 15:53:53.398	2023-01-28 15:53:53.399
161	\N	Solicitar el IVA	148	2023-01-28 15:54:01.238	2023-01-28 15:54:01.238
162	\N	09/20 SENTENCIA REGULA EL 6%. SOLICITAR NUEVAMENTE VINCULACION	153	2023-01-28 22:03:25.584	2023-01-28 22:03:25.585
163	\N	26/07/22 Sentencia R.H. X  7% del capital actualizado. En diciembre hicieron la transferencia del capital al actor. Hablar con BOSCHETTO de los honorarios? 	154	2023-01-28 22:10:26.662	2023-01-28 22:10:26.663
164	\N	Ultimo movimiento con relevancia es la solicitud del dictado de sentencia en 09/11/21	157	2023-01-28 22:21:14.056	2023-01-28 22:21:14.057
165	\N	En mayo/19 R.H. x el monto de 12mil. Hay que notificar los honorarios\n	158	2023-01-28 22:27:31.551	2023-01-28 22:27:31.552
166	\N	Hay depositado en la cuenta 6mil. Hablar con algunos de los doctores para notifiquen RH.  y así intimar realicen el depósito restante de los honorarios.	158	2023-01-28 22:29:12.927	2023-01-28 22:29:12.928
98	\N	Regularon Honorarios en la sentencia, la misma del  6% del capital actualizado. Se encuentran todos notificados de la R.H.	89	2023-01-04 13:40:17.635	2023-01-28 22:48:40.92
167	\N	06/20 R.H. en sentencia. El 01/21 se abono al actor y quedo con eso.	160	2023-01-28 22:54:10.58	2023-01-28 22:54:10.581
168	\N	En FEBRERO/18 se había solicitado Regulación de honorarios. Volver a reiterar vinculación de honorarios.	162	2023-01-29 00:07:38.585	2023-01-29 00:07:38.585
169	\N	Regularon honorarios x el monto $13.699,18. Hay depositado en la cuenta $ 39.925,95	166	2023-01-29 00:26:03.261	2023-01-29 00:26:03.262
170	\N	Demanda rechazada. Lo último que figura es la R.H. x el monto de $7000 (12/19) faltaría notificar los honorarios, ver a quien se pasa la causa para la notificación. 	169	2023-01-29 00:56:59.602	2023-01-29 00:56:59.602
171	\N	Sentencia Rechazada R.H. x el 6%, apelaron y quedo en eso, en 07/22 último movimiento	174	2023-01-29 01:31:21.612	2023-01-29 01:31:21.613
172	\N	Demanda con sentencia rechazada. ver en la fs. 107 donde regulan el porcentaje de honorario.	176	2023-01-29 01:40:00.855	2023-01-29 01:40:00.856
173	\N	Sentencia con demanda rechazada, regulan honorarios por el monto de $42.844,57 	177	2023-01-29 02:03:31.014	2023-01-29 02:03:31.014
174	\N	Solicitar Vinculación. Ver en qué estado se encuentra. 	178	2023-01-29 02:06:55.23	2023-01-29 02:06:55.231
175	\N	Sentencia 09/21, honorario regulado x el monto de 62.315,40.  Demanda rechazada. Bajo de camara 10/22. quedo en casillero.	182	2023-01-29 02:24:25.346	2023-01-29 02:24:25.347
176	\N	Demanda rechazada. Sentencia regula $7.074,04 de honorarios. Se elevo a cámara y en julio/22 bajo, no tiene mas movimiento.	186	2023-01-29 17:09:47.187	2023-01-29 17:09:47.188
177	\N	Fecha de cobro 15/07/22 	187	2023-01-29 17:11:09.969	2023-01-29 17:11:09.969
178	\N	Se regula el 6% de honorario en sentencia de 11/2020. 	189	2023-01-29 17:27:26.454	2023-01-29 17:27:26.455
179	\N	El actor y su apoderado ya cobraron. Hablar con pastor? o pasar para ejecutar? 	189	2023-01-29 17:29:03.782	2023-01-29 17:29:03.783
180	\N	fecha de cobro 03/21	190	2023-01-29 17:30:31.185	2023-01-29 17:30:31.186
181	\N	Demanda rechazada. Sentencia regula honorario por el monto de $8mil.	192	2023-01-29 17:33:25.675	2023-01-29 17:33:25.675
182	\N	Solicitar vinculación. 01/20 Sentencia- Regulan el 6% 	194	2023-01-29 17:45:05.148	2023-01-29 17:45:05.148
183	\N	Después de haber echo la pericia acepta cargo otro p. medico traumatólogo. y quedo ahí, no hay más movimiento. 	195	2023-01-29 17:53:16.35	2023-01-29 17:53:16.351
184	\N	Solicitar R.H.	195	2023-01-29 17:53:29.859	2023-01-29 17:53:29.859
185	\N	Hay depositado $ 13.164,33. Se le había pasado a carísimo la causa.	198	2023-01-29 18:51:57.792	2023-01-29 18:51:57.793
186	\N	Demanda rechazada, último movimiento cedulas diligenciadas de la sentencia. 	202	2023-02-02 12:59:21.33	2023-02-02 12:59:21.331
187	\N	Sentencia regula el 6% (06/20)	202	2023-02-02 12:59:47.083	2023-02-02 12:59:47.084
188	\N	Sentencia 20/10/21 regula el 6%, abonaron al actor el 22/12/22. Hablar con los de Prevención?	203	2023-02-02 14:09:02.225	2023-02-02 14:09:02.226
190	\N	Cobrado el 17/12/2022	206	2023-02-02 14:17:46.357	2023-02-02 14:17:46.357
191	\N	Cobrado el 17/12/22	207	2023-02-02 14:19:00.917	2023-02-02 14:19:00.918
189	\N	A la espera de que transfieran la plata	205	2023-02-02 14:16:32.18	2023-02-02 14:32:36.519
192	\N	Cobrado 	205	2023-02-02 14:35:38.232	2023-02-02 14:35:38.232
193	\N	Demanda rechazada. Sentencia regula honorario x $41.865,81.  (21/09/20)	208	2023-02-02 14:44:11.117	2023-02-02 14:44:11.117
194	\N	Subió a cámara de Apelaciones el 14/12/22	208	2023-02-02 14:44:47.158	2023-02-02 14:44:47.159
195	\N	En etapa de clausura.	210	2023-02-03 14:26:31.148	2023-02-03 14:26:31.149
196	\N	Corre plazo para la presentación de pericia	211	2023-02-03 14:31:36.876	2023-02-03 14:31:36.877
197	\N	Agregaron estudios complementarios, le tienen que notificar para que presente la pericia.	212	2023-02-03 14:38:12.288	2023-02-03 14:38:12.289
198	\N	La parte actora realizo el desistimiento de la acción. SOLICITAR R.H.	213	2023-02-03 14:46:59.155	2023-02-03 14:46:59.155
199	\N	Esta sin movimiento relevante por parte del actor desde agosto/2019, demandada presento nuevo domicilio. SOLICITAR R.H. ya que por lo visto no va a ver mas movimiento.	214	2023-02-03 14:56:37.768	2023-02-03 14:56:37.768
200	\N	Esta para dictar sentencia.	215	2023-02-03 15:02:11.761	2023-02-03 15:02:11.762
201	\N	02/23: Se rechaza demanda. Incidencia de la PMO en la sentencia. Recordarme para hablar con la Boschetto o ejecutar	68	2023-02-04 15:49:24.939	2023-02-04 15:49:48.181
202	\N	12/22 Se le solicito estudios complementario	216	2023-02-04 16:39:31.558	2023-02-04 16:39:31.558
203	\N	Sentencia (07/22) R.H. x el monto de $92.446,91\nequivalente al 3% de la base arancelaria.	217	2023-02-04 16:52:32.181	2023-02-04 16:52:32.181
204	\N	Están por elevar a cámara de apelaciones. (30/01/23)	217	2023-02-04 17:18:38.131	2023-02-04 17:18:38.131
205	\N	Acepto cargo, subio escrito denunciando N° de CBU	218	2023-02-04 18:03:35.773	2023-02-04 18:03:58.652
206	\N	Salió sentencia 01/02/23 Demanda rechazada. R.h. x la suma de $7.068	147	2023-02-05 13:31:20.852	2023-02-05 13:31:20.853
207	\N	03/02/23 se agregó cedula diligenciada a prevención de la r.h. 	203	2023-02-05 13:35:13.975	2023-02-05 13:35:13.975
208	\N	Con pedido de estudios complementarios	219	2023-02-05 13:37:35.367	2023-02-05 13:37:35.368
209	\N	Pradier Impugna pericia. (03/02)	220	2023-02-05 13:40:11.835	2023-02-05 13:40:11.835
210	\N	Regularon honorario en sentencia del (14/12/22)  en el 6% del capital de sentencia actualizado. 	221	2023-02-05 13:45:05.344	2023-02-05 13:45:05.344
211	\N	Se agrego cedula diligenciada de la sentencia (02/02/23)	221	2023-02-05 13:45:58.406	2023-02-05 13:45:58.407
212	\N	Sentencia (06/06/22) se regulo 1 SMVM.\n	222	2023-02-05 13:50:08.202	2023-02-05 13:50:08.202
213	\N	Intiman a fija nueva fecha de pericia medica	223	2023-02-05 13:54:36.776	2023-02-05 14:11:50.426
214	\N	Sentencia 01/02/23 regulan honorario en 7% de la base aprobada. Controlar movimientos de pagos	224	2023-02-05 14:16:51.57	2023-02-05 14:16:51.57
215	\N	09/01/23 Regularon honorario x la suma de Pesos Veintiún Mil ($21.000) + ($4.410) en concepto de IVA.	225	2023-02-05 14:20:41.756	2023-02-05 14:20:41.757
216	\N	Hablar con los abogados de la aseguradora? o pasar a alguien para que notifique la regulación. 	225	2023-02-05 14:23:15.258	2023-02-05 14:23:15.259
217	\N	Sentencia (02/12/22) Regula Honorario x $19.980,57. Demanda rechazada.	226	2023-02-06 11:40:33.652	2023-02-06 11:40:33.653
220	\N	Hay depositado $1.500 corresponde al anticipo de gasto (19/08/20) adjuntar constancia de titularidad de caja de ahorro y CBU a efecto de proceder a la transferencia correspondiente	229	2023-02-06 12:06:46.813	2023-02-06 12:06:46.813
221	\N	Sentencia (03/02/23) regula honorario en el 3% del capital actualizado de sentencia. En proceso de notificación.	229	2023-02-06 12:09:56.583	2023-02-06 12:09:56.584
222	\N	21/04/22 Regularon honorario por la suma de 15 mil. Falta notificar resolución o hablar con RIOTORTO/FEVERSANI al respecto.	230	2023-02-06 13:20:26.542	2023-02-06 13:20:26.542
223	\N	Hay convenio x 250 mil. (Abonaron ya al actor 02/05/22)	230	2023-02-06 13:20:38.881	2023-02-06 13:20:38.882
224	\N	Hay depositado $16 mil en concepto de adelanto de gastos periciales. INTIMAN  a ACOMPAÑAR constancia de CBU emitida por entidad bancaria fin\nde hacer efectivo el pago 	231	2023-02-06 14:16:40.986	2023-02-06 14:16:40.987
225	\N	Sentencia (08/06/22).\nRegula honorarios en 6% del capital actualizado de sentencia. 	232	2023-02-06 14:24:35.612	2023-02-06 14:24:35.613
226	\N	Se encuentra en Camara de Apelaciones. (03/02/23)	232	2023-02-06 14:25:12.168	2023-02-06 14:25:12.168
227	\N	Acepto cargo, pero al parecer no realizo la pericia, fue al CMF.  Tienen fijado fecha de audiencia de conciliación para marzo. ATENTI POR POSIBLE ARREGLO.	233	2023-02-06 14:42:54.896	2023-02-06 14:42:54.897
228	\N	03/02/23 Se transfirió el total de $36.145,19 (Honorarios $29.872,06 + $6.273,13 IVA) 	234	2023-02-06 14:48:50.963	2023-02-06 14:48:50.963
229	\N	HAY DEPOSITADO en la cuenta $56.622,95 correspondiente a los honorarios regulados después del Prorrateo.	235	2023-02-06 14:56:09.077	2023-02-06 14:56:09.077
230	\N	Interpusimos  RECURSO DE APELACIÓN PARCIAL. Hay que notificar para que se eleve a cámara. (03/02/23)	235	2023-02-06 14:58:51.555	2023-02-06 14:59:10.288
231	\N	Enero/23 solicito regulación de honorarios, por labor desplegada (PERICIA FICTA por convenio anticipado). Regula el 3% sobre 700mil. Atenti al cobro	237	2023-02-06 15:45:36.774	2023-02-06 15:45:36.774
232	\N	Salió regulación (07/02/23) $42.050,63. Hay depositado \t$ 876.054,86.	77	2023-02-07 23:40:13.795	2023-02-07 23:40:13.796
233	\N	Sentencia (16/03/22) regula honorario de 6% del capital de sentencia actualizado. En fecha 07/02/23 proveyeron el recurso de apelación presentado por Pastor. 	240	2023-02-08 00:05:03.031	2023-02-08 00:05:03.031
234	\N	Sentencia (14/09/22) R.H.  6% de la\nbase aprobada. Se encuentra en Cámara de Apelaciones.\n	242	2023-02-08 00:16:01.432	2023-02-08 00:16:01.432
235	\N	Sentencia 30/11/22 R.H. 8% del capital de sentencia actualizado. Hay depositado en la cuenta $ 1.010.162,14	243	2023-02-08 00:31:31.632	2023-02-08 00:31:31.633
\.


--
-- Data for Name: Office; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Office" (id, name, "courtId") FROM stdin;
1	Única	1
2	I	2
3	II	2
4	I	3
5	II	3
6	I	4
7	II	4
8	I	5
9	II	5
\.


--
-- Data for Name: Record; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Record" (id, name, "order", tracing, priority, archive, favorite, defendant, prosecutor, insurance, "officeId", "createdAt", "updatedAt") FROM stdin;
5	MARTINEZ DAVID c/ Sucesores de Federico Klark y/o quien resulte responsable  p/laboral-accidente de trabajo	139/1994	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-27 04:27:51.119	2022-11-27 04:28:01.053
6	RODRÍGUEZ DE OLIVERA SILVIO C/CRISTIAN LUIS SCHER Y/O Q.R.R. S/ accidente de trabajo	123/04	ACEPTA_CARGO	ALTA	f	f	\N	\N	\N	1	2022-11-27 04:29:58.545	2022-11-27 04:29:58.545
42	FLEITAS MARIANO F. C/ ARNDT, ULISES D. S/ DEMANDA CIVIL POR ACCIDENTE DE TRABAJO	1473/2012	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:09:46.69	2022-11-30 20:09:46.691
7	CAMACHO OSCAR ALFREDO C/REGINA S.R.L. Y/U OTRO S/ LABORAL – ENFERMEDAD ACCIDENTE DE TRABAJO	264/02	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-27 04:31:36.599	2022-11-27 04:31:53.527
8	RODRIGUEZ HECTOR LALINDO C/ RODOLFO GERMAN KEHL Y/O Q.R.R. P/ LABORAL	189/05	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-27 04:54:04.228	2022-11-27 04:54:04.229
9	MANGUERA SETEMBRINO c/ ZILLER JAVIER Y/O Q.R.R. P/ INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO Y RECLAMO SALARIAL	1061/2008	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-27 05:33:16.785	2022-11-27 05:33:16.786
10	SCHUVARTZ, JUAN JOSÉ c/ BEKISZ ESTEBAN Y OTRO P/ DEMANDA CIVIL por ACCIDENTE DE TRABAJO	1748/2008	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-30 18:25:17.469	2022-11-30 18:25:17.469
11	DA SILVA MERCEDES C/FARMACIA RODRIGUEZ S.C.S. Y OTROS S/ LABORAL, DAÑOS Y PERJUICIOS	90/2006	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 18:26:35.435	2022-11-30 18:26:35.435
12	Cantero Cesar Anibal c/ Bueno Adrian y otro P/ Accidente de Trabajo (Cuaderno de prueba de la actora)	345/2008	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 18:29:08.63	2022-11-30 18:29:08.631
13	NUÑEZ MARIA YOLANDA C/ MUNICIPALIDAD DE OBERA Y OTROS S/INCONSTITUCIONALIDAD	296/02	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 18:31:33.239	2022-11-30 18:31:33.24
14	GODOY CRISTIAN FABIAN c/ CONSOLIDAR ART S.A. S/ DAÑOS Y PERJUICIOS	710/2009	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 18:34:28.258	2022-11-30 18:34:28.258
15	VIANA ANTONIO C/ GRIPPO GERARDO S/ ACCIDENTE DE TRABAJO	1522/2008	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 18:38:17.95	2022-11-30 18:38:17.95
16	FERREYRA HECTOR JAVIER C/ LA SEGUNDA ART S.A. S/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	175/2009	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:14:11.456	2022-11-30 19:14:11.457
17	ESPÍNDOLA DANIEL OSCAR C/ KUZMICZ ESTEBAN Y OTRO/A  P/LABORAL	3526/2008	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:15:22.537	2022-11-30 19:15:22.538
18	CARISIMO NILDA JOSEFA c/GUGLIELMI GRACIELA BEATRIZ Y OTRO P/ LABORAL	2446/2009	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:18:08.843	2022-11-30 19:18:08.843
19	FIETZ, RICARDO RAMÓN C/ MARTINEZ ROLANDO Y OTROS p/DEMANDA CIVIL POR ACCIDENTE DE TRABAJO	3723/2009	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:19:53.475	2022-11-30 19:19:53.475
20	ARNOLD JOSÉ LUIS C/ IECSA S. A. Y/U OTRO S/LABORAL	2304/2010	EN_TRATATIVA_DE_COBRO	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:20:49.243	2022-11-30 19:20:49.244
21	ALVEZ LEANDRO MARCELINO c/ MARTINEZ ROLANDO y OTRO/A p/DEMANDA CIVIL POR ACCIDENTE DE TRABAJO	1531/2010	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:25:50.411	2022-11-30 19:25:50.411
22	ORTEGA, RODOLFO FABIÁN C/CASINOS DE MISIONES S.A. Y OTRA p/ DEMANDA CIVL POR ACCIDENTE DE TRABAJO	2939/2009	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:28:44.612	2022-11-30 19:28:44.612
23	ANTONIOW JUAN CARLOS C/ ESKIVISKI SEVERIANO SEVERIO Y OTRO S/ INDEMNIZACIÓN P/ ACCIDENTE DE TRABAJO	1873/2011	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:30:29.317	2022-11-30 19:30:29.317
24	BLANCO RICARDO C/ ECIM S.R.L. Y OTRO S/ INDEMNIZACIÓN P/ ACCIDENTE DE TRABAJO	2791/2009	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:34:02.862	2022-11-30 19:34:10.132
25	TABAREZ JUAN CARLOS C/ YASINSKI RICARDO Y OTROS POR INDEMNIZACIÓN P/ ACCIDENTE DE TRABAJO Y RECLAMOS CONEX. EN AUTOS 1388/2009	1390/2009	EN_TRATATIVA_DE_COBRO	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:36:05.415	2022-11-30 19:36:05.416
27	CARBALLO, RICARDO ALBINO C/ CAPITAL DEL MONTE V y T SRL POR/INDEMNIZACIÓN p/ DESPIDO Y RECLAMO SALARIAL	553/2010	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:43:57.207	2022-11-30 19:43:57.208
28	DORETTO HUGO RUBÉN C/ TOTAL DISTRIBUCIONES SRL S /INDEMNIZACIÓN por ACCIDENTE DE TRABAJO	2204/2009	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-30 19:45:10.486	2022-11-30 19:45:10.487
29	FRUTOS LUIS ALBERTO C / SAN MIGUEL S.A. S/ INDEMNIZACIÓN P/ ACCIDENTE DE TRABAJO	3019/2009	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:46:00.771	2022-11-30 19:46:00.772
30	PETTERSSON, DANIEL ORLANDO c/ CONSOLIDAR ART S.A. y OTRO/A P/ DEMANDA CIVIL POR ACCIDENTE DE TRABAJO	2620/2010	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:47:03.005	2022-11-30 19:47:03.006
31	MACIEL ROQUE D. C/ STAUD RICARDO P/ DAÑOS Y PERJUICIOS	725 / 2008	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:47:48.107	2022-11-30 19:47:48.107
32	DA SILVA JUAN ANSELMO C/ NEUMÁTICOS OBERMANN E HIJOS S.R.L. y OTRO/A P/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	3200/2010	EN_TRATATIVA_DE_COBRO	URGENTE	f	f	\N	\N	\N	1	2022-11-30 19:51:44.918	2022-11-30 19:51:44.919
33	BARCELÓ CESAR MIGUEL c/ MORGEN, RICARDO ALFREDO y OTRO/A S/INDEMNIZACIÓN POR DESPIDO Y RECLAMO SALARIAL	1666/2009	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:53:03.2	2022-11-30 19:53:03.201
34	UMFIER PEDRO EUGENIO c/ IECSA S.A. Y OTRO/A P/LABORAL	3312/2010	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:53:44.371	2022-11-30 19:53:44.371
35	OVIEDO JUAN CARLOS C/CELO P/LABORAL	3946/2012	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 19:55:20.568	2022-11-30 19:55:20.569
36	SILVEIRA DA SILVA, ROSENDO C/ HIPÓLITO DADONE e HIJOS S.R.L. S/ LABORAL	551/2012	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 19:56:40.677	2022-11-30 19:56:40.678
38	SEQUEIRA GOMEZ MIGUEL C/ DON LIRIO S.R.L. y otro S/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	2924/2010	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 19:59:06.15	2022-11-30 19:59:06.151
39	DA LUZ ESPÍNDOLA BASILIO C/ LA SEGUNDA ART S.A. y otro S/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	3933/2012	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 19:59:55.814	2022-11-30 19:59:55.815
40	SOSA DANIEL c/ NICKLAS GERARDO P/ LABORAL	08/2006	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 20:03:45.728	2022-11-30 20:03:45.728
45	PESSINI, DELFINO C/ CARVALLO NESTOR HORACIO Y OTRO/A S/ INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	4452/2012	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:21:32.32	2022-11-30 20:21:32.321
43	FRANCO, JUAN CARLOS C/ LA SEGUNDA ART S.A. S/ ACCIÓN ESPECIAL ACCIDENTE DE TRABAJO	3125/2013	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:11:43.475	2022-11-30 20:18:47.132
41	EICH JUAN C/ BOHER VICTORIO BLAS y Otro/a S/ Indemnización por accidente de Trabajo	1640/2012	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:08:14.527	2022-11-30 20:18:30.664
46	MARTINEZ FEDERICO C/ ROGACZEWSKI ULADISLAO Y OTRO/A S/ ACCIÓN POR REPARACIÓN INTEGRAL	905 / 2013	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:23:30.341	2022-11-30 20:23:30.342
47	DOS SANTOS REINALDO C/ ESPÍNDOLA JOSÉ ARIEL Y OTRO/A S/ ACCIÓN ESPECIAL - ACCIDENTE DE TRABAJO	1013/2013	PERICIA_REALIZADA	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:25:10.136	2022-11-30 20:25:10.137
48	ANDINO, SERGIO RAMÓN C/ LA SEGUNDA ART S/ ACCIÓN ESPECIAL - ACCIDENTE DE TRABAJO	279/2013	PERICIA_REALIZADA	MEDIA	f	f	\N	\N	\N	1	2022-11-30 20:26:17.78	2022-11-30 20:26:17.781
49	ANDRADE OLIVIO O. C/ LA SEGUNDA ART S.A. S/ ACCIÓN INDEMNIZATORIA – Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	2799/2014	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:28:31.675	2022-11-30 20:28:31.676
50	MARQUEZ ALBERTO C/ SARMIENTO CONSTRUCCIONES S.R.L. y/o QUIEN RESULTE RESPONSABLE S/DEMANDA CIVIL POR ACCIDENTE DE TRABAJO	1688/2008	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 20:30:38.354	2022-11-30 20:30:38.355
3	CÁCERES REIMUNDO C/OSCAR ROBERTO SEMAÑUK P/ACCIDENTE DE TRABAJO	44/2002	EN_TRATATIVA_DE_COBRO	ALTA	f	f	\N	\N	\N	1	2022-11-27 04:25:36.027	2022-11-27 04:25:55.265
4	FERNANDEZ ENRIQUE c/RAZÓN SOCIAL ECIM S.R.L. Y OTRA y/o QUIEN RESULTE RESPONSABLE p/ACCIDENTE DE TRABAJO	223/05	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-27 04:26:37.944	2022-11-27 04:26:51.222
51	PIÑEIRO, DIEGO ARIEL C/ CONSOLIDAR ART S.A. S/ INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	2903/2012	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:31:53.466	2022-11-30 20:31:53.467
52	SCHUARTZ, HUGO RUBEN C/ LIBERTY ART S.A. S/ ACCIÓN ESPECIAL DE ACCIDENTE DE TRABAJO	289/2013	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:32:58.767	2022-11-30 20:32:58.768
53	GLUSCZAL, JORGE C/RIGO DALCI y OTROS S/ INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	356/2011	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:35:50.241	2022-11-30 20:35:50.242
56	WEGNER CRISTHIAN ARIEL C/ GALENO ART S.A	9530/2015	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-30 20:43:54.834	2022-11-30 20:43:54.834
57	LLANES FABIAN C/ PREVENCION ART S.A.	22710/2015	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:45:02.497	2022-11-30 20:45:02.497
59	PIÑEIRO JUAN DOMINGO C/ CASA FUENTES SACIFI y Otro/a S/ Acción Por Reparación Integral	3747/2013	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:47:39.289	2022-11-30 20:47:39.29
60	PIEK JORGE ELISEO C/ PREVENCIÓN ART S.A	52413/2015	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 20:48:24.931	2022-11-30 20:48:24.932
61	DE LÍAS JONATHAN C/ ASOCIART S.A. Y OTRO/A S/ INDEMNIZACIÓN POR INCAPACIDAD SOBREVINIENTE	708/2013	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2022-11-30 20:52:09.95	2022-11-30 20:52:09.951
62	GRUGER MARCELO C/ GALENO ART S.A. S/ACCIÓN ESPECIAL – ACCIDENTE DE TRABAJO	577/2014	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-30 20:55:44.827	2022-11-30 20:55:44.828
63	ARAUJO SILVANO ANDRES C/ LA SEGUNDA ART S.A. S/ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	27617/2015	SENTENCIA_O_CONVENIO_DE_PARTES	URGENTE	f	f	\N	\N	\N	1	2022-11-30 21:23:55.028	2022-11-30 21:23:55.029
64	CARDOZO JUAN CARLOS C/ SMG ART S.A. S/ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	85707 / 2015	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 21:26:18.319	2022-11-30 21:26:18.319
67	PIRIZ, HECTOR MARTÍN C/ QBE ART S/ ACCIÓN ESPECIAL ACCIDENTE DE TRABAJO	2604 / 2013	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 21:31:42.28	2022-11-30 21:31:42.281
68	DUARTE, MARCELINO GERMÁN C/MIELNICZUK MATERIALES S.R.L. S/INDEMNIZACIÓN POR DESPIDO	2033/2010	HONORARIOS_REGULADOS	URGENTE	f	f	\N	\N	\N	1	2022-11-30 21:38:42.945	2022-11-30 21:38:42.946
69	ENRIQUEZ, ADOLFO OSCAR C/HARISPE LUIS BERNARDO Y OTRO/A S/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	4450/2012	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2022-11-30 21:42:46.512	2022-11-30 21:43:00.05
70	ALVEZ MIGUEL ANGEL C/ LA SEGUNDA ART S.A. S/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	2579/2012	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 21:45:03.779	2022-11-30 21:45:50.435
72	ALMADA ORLANDO C/ GALENO ART S.A. S/ACCIÓN ESPECIAL DE ACCIDENTE DE TRABAJO y ENFERMEDAD PROFESIONAL	574/2013	ACEPTA_CARGO	ALTA	f	f	\N	\N	\N	1	2022-11-30 21:50:30.728	2022-11-30 21:50:30.729
73	ENGER RICARDO C/ CASA FUENTES S.A.C.I.F.I. y OTRO S/ ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	49187/2015	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2022-11-30 21:51:10.622	2022-11-30 21:51:39.551
71	RODRIGUEZ CRISTIAN ANGEL C/ EL CONDOR SRL y otro/a S/ACCIÓN INDEMNIZATORIA DERIVADA DE ACCIDENTE DE TRABAJO y ENFERMEDAD PROFESIONAL	2355/2014	PERICIA_REALIZADA	MEDIA	f	f	\N	\N	\N	1	2022-11-30 21:46:50.465	2022-12-22 11:49:29.995
74	ALEGRE GUSTAVO ADRIAN C/ GALENO ART SA S/ Acciones por Accidentes Laborales Abreviadas	107087/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2022-12-22 11:56:28.707	2022-12-22 11:58:46.7
75	ALVEZ DA SILVA ROBERTO CARLOS C/ GALENOS ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	810/2013	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-12-22 12:07:03.871	2022-12-22 12:07:03.872
76	BIANO ADELINO DANIEL C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	111992/2019	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-12-22 13:48:59.579	2022-12-22 13:49:11.901
90	FIGUEREDO Paola Ines c/ Angel Alberto Lindquist y Otra P/ DAÑOS Y PERJUICIOS	864/2007	HONORARIOS_REGULADOS	ALTA	f	f	{"JUDAIS, CARLOS MARIA"}	{"VUOTTO, WALTER RUBEN ANIBAL"}	{"LIDERAR COMPAÑIA GENERAL DE SEGUROS S.A."}	6	2023-01-04 13:45:16.742	2023-01-04 13:46:32.922
89	MOREIRA MARIA C/ PREVENCION ART SA S/ Art.223 Ley XIII.2 Abrev. por Diferencia en Prestación Ley 24557 26773 Dtos Reglamentarios	122396/2015	HONORARIOS_REGULADOS	ALTA	f	f	{"VAZQUEZ, RAUL JOSÉ"}	{"ARRECHEA, ALFONSO RAMÓN"}	{"PREVENCIÓN ART SA"}	1	2023-01-04 13:36:50.893	2023-01-04 13:38:51.56
37	GREGORIO, SILVIO C/ LA SEGUNDA ART S.A. S/ ACCIÓN ESPECIAL – ACCIDENTE DE TRABAJO LEY Nro. 24.557	2420/2013	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	{"JUDAIS, CARLOS MARIA"}	{"BAREIRO, SERGIO ARIE","CERUTTI, CARLOS DANIE"}	{"LA SEGUNDA ART S.A"}	1	2022-11-30 19:57:41.852	2023-01-04 14:42:40.251
91	FRIEDEMBERG ALCIRA y Otros C/ HEREDEROS DE HECTOR JAVIER AMARAL y Otros S/ Daños y Perjuicios y Daño Moral	128656/2015	HONORARIOS_REGULADOS	MEDIA	f	f	\N	\N	\N	6	2023-01-04 13:53:40.325	2023-01-04 13:53:40.325
26	PESTCH VALDIR C/ PUIJANE ANA MARIA Y OTRO P/ ACCIDENTE DE TRABAJO	321/2010	HONORARIOS_REGULADOS	URGENTE	f	f	{"BOHER, SABRINA","JUDAIS, CARLOS MARIA"}	{"BAEZ, CESAR ANTONIO","KISLO, JUAN CASIMIRO"}	{"MAPFRE ARGENTINA SEGURO DE VIDA SA"}	1	2022-11-30 19:42:59.256	2023-01-04 14:46:38.534
92	DA ROSA CARLOS FABIAN C/ PROVINCIA ART SA S/ Acciones por Accidentes Laborales ORDINARIO	16358/2020	ACEPTA_CARGO	ALTA	f	f	{"HIRCH, MARCOS FABIAN"}	{"JUDAIS, CARLOS MARIA","VILLAVERDE, RODRIGO SEBASTIAN"}	{"PROVINCIA ART SA"}	1	2023-01-04 14:51:36.374	2023-01-04 14:53:20.576
93	RASMUSSEN ALDO JOAQUIN C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales de trámite ordinario	117915/2021	HONORARIOS_REGULADOS	ALTA	f	f	{"RIOTORTO, LISANDRO MARTIN"}	{"BAREIRO, SERGIO ARIEL","LESIUK, HUGO ORLANDO"}	{"PREVENCION ART SA"}	1	2023-01-04 14:58:31.407	2023-01-04 14:59:41.401
54	CARDOZO, ARLINDO C/LA SEGUNDA ART S.A. S/ ACCIÓN DE INDEMNIZACIÓN DERIVADA DE ACCIDENTE DE TRABAJO y ENFERMEDAD PROFESIONAL	53155/2015	PERICIA_REALIZADA	BAJA	f	f	{"JUDAIS CARLOS MARIA"}	{"LEVITT, LEONARDO SEBASTIAN"}	{"LA SEGUNDA ART S.A"}	1	2022-11-30 20:38:21.865	2023-01-28 01:24:45.354
95	WEBER MARCOS LEOPOLDO C/ SWISS MEDICAL ART SA S/ Acciones por Accidentes Laborales de trámite ordinario	99556/2017	COBRADO	NULA	f	f	{"OVANDO PRADIER, MARIO LUIS ARMANDO"}	{"PUCHALSKI, GABRIEL ALEJANDRO"}	\N	1	2023-01-05 11:28:26.334	2023-01-27 07:26:43.157
55	SOAREZ, MARCELO DAVID C/PREVENCIÓN ART S.A. S/ ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	2091/2014	PERICIA_REALIZADA	BAJA	f	f	{"BOSCHETTO, SUSANA DOMINGA"}	{"CANDOTTI, FRANCO"}	{"PREVENCION ART SA"}	1	2022-11-30 20:42:25.806	2023-01-28 01:26:34.465
130	PRESTES MARCELO C/ SMG ART SA s/ ACCION INDEMNIZATORIA DERIVADA DE ACCIDENTE DE TRABAJO	125151/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 13:25:41.379	2023-01-28 13:25:41.379
58	CARBALLO LORENZO C/PREVENCIÓN ART S.A. S/ INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO	3209/2012	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2022-11-30 20:46:51.403	2023-01-28 01:28:23.683
65	HUPAN MARCELO GERMÁN C/ ROJAS HECTOR ACACIO S/INDEMNIZACIÓN POR ACCIDENTE DE TRABAJO Y RECLAMO SALARIAL	2204/2012	HONORARIOS_REGULADOS	MEDIA	f	f	{"Daniel Adolfo Montenegro Niveyro"}	{" Carlos Alberto Buemo"}	\N	1	2022-11-30 21:27:38.605	2023-01-28 02:03:40.815
131	RODRIGUEZ CRISTIAN ANGEL C/ EL CONDOR SRL Y OTROS S/ ACCION INDEMNIZATORIA DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	2355/2014	ACTO_PERICIAL_REALIZADO	MEDIA	f	f	\N	\N	\N	1	2023-01-28 14:30:49.14	2023-01-28 14:30:49.141
96	STRAGEVICH HECTOR RENE C/ DE OLIVERA JUAN ALBERTO y Otro/a S/ Daños y Perjuicios y Daño Moral	8166/2020	PERICIA_REALIZADA	BAJA	f	f	{"BOSCHETTO, SUSANA DOMINGA"}	{"VILLAVERDE, MARIA ESTER","QUIÑONES, MIGUEL RAUL"}	{"SEGUROS BERNARDINO RIVADAVIA COOPERATIVA LTDA"}	2	2023-01-05 11:49:15.499	2023-01-05 11:50:40.186
102	CORREA SILVIA NOEMI C/ SALDAÑA SERGIO ALEJANDRO y Otro/a S/ Daños y perjuicios	2242/2010	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	4	2023-01-21 20:56:43.951	2023-01-21 20:57:58.804
103	GYSIN ERICA C/AMARILLA JOSE LUIS Y OTROS S/DAÑOS Y PERJUICIOS Y DAÑO MORAL	1582/2009	ACEPTA_CARGO	NULA	f	f	\N	\N	\N	5	2023-01-21 20:59:01.202	2023-01-21 20:59:01.203
108	MORALES CELSO JAVIER C/ PIRIZ MARCELO RUBEN Y OTRO/A S/ DAÑOS Y PERJUICIOS Y DAÑO MORAL	64291/2015	HONORARIOS_REGULADOS	ALTA	f	f	\N	{"DAMUS, AMADO JORGE LUIS"}	{"LIDERAR COMPAÑIA DE SEGUROS SA"}	6	2023-01-21 21:39:05.058	2023-01-21 21:40:47.184
109	ANTUNEZ NIEVES MARIA CELESTE C/ DIAZ SAUL HORACIO S/ Daños y Perjuicios	3508/2014	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	4	2023-01-21 22:00:10.776	2023-01-21 22:00:10.776
104	VIERA RUBEN ZACARIA C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	149349/2018	ACEPTA_CARGO	NULA	f	f	{"RIOTORTO, LISANDRO MARTIN"}	{"CHEMES, JULIO GERMAN"}	{"PREVENCION ART SA"}	1	2023-01-21 21:01:22.174	2023-01-21 21:05:41.785
98	SUAREZ JUAN CARLOS C/ GALENO ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	282/2013	PERICIA_REALIZADA	BAJA	f	f	{"VILLALBA, LAURA TERESITA"}	{"LEVITT, LEONARDO SEBASTIAN"}	\N	1	2023-01-05 13:37:50.523	2023-01-05 13:39:42.444
97	BLANCO RICARDO C/ ECIM SRL y Otro/a S/ Indemnización por Accidente de Trabajo Conexidad Solicitada en autos 983/2008 - BLANCO RICARDO C/ MAPFRE ASEGURADORA DE RIESGOS DEL TRABAJO SA S/ Medida Cautelar	2791/2009	HONORARIOS_REGULADOS	URGENTE	f	f	{"ARMANINI, JORGE MARCELO","JUDAIS, CARLOS MARIA"}	{"MEGA, SILVIA SUSANA"}	\N	1	2023-01-05 12:07:08.038	2023-01-08 17:15:33.795
99	ADAMS SILVIO ADRIAN C/ PROVINCIA ART SA S/ Acciones por Accidentes Laborales Abreviadas	105027/2019	ACEPTA_CARGO	BAJA	f	f	{"HIRCH, MARCOS FABIAN"}	{"MARTIN, SILVANA SOLEDAD"}	{"PROVINCIA ART SA"}	1	2023-01-09 23:50:40.43	2023-01-09 23:52:24.591
105	RODRIGUEZ EDUARDO por si y en rep de su hija menor Y. B.R. y Otro/a C/ CROILE NELSI ANELIA y Otros S/ Daños y Perjuicios y Daño Moral	456/2010	HONORARIOS_REGULADOS	MEDIA	f	f	{"JUDAIS CARLOS MARIA"}	{"BOHER, SABRINA"}	{"LIDERAR COMPAÑIA DE SEGUROS SA"}	6	2023-01-21 21:08:10.803	2023-01-21 21:10:46.627
120	TRONCOSO JUAN ERNESTO C/ PREVENCIÓN ASEGURADORA DE RIESGO DE TRABAJO SA S/ Acciones por Accidentes Laborales Abreviadas	109390/2021	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2023-01-22 12:29:53.43	2023-01-22 12:38:00.117
116	SOARES JOSE LUIS C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales de trÃ¡mite ordinario	163745/2019	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-22 12:05:15.339	2023-01-22 12:08:08.867
106	RODRIGUEZ MAXIMILIANO ALBERTO C/ ASOCIACION DE EMPLEADOS MUNICIPALES DE OBERA CLUB AEMO y Otros S/ Daños y perjuicios	1864/2012	HONORARIOS_REGULADOS	ALTA	f	f	{"MONTIEL, MARCO JAVIER"}	{"BILINSKI, JOSE LUIS"}	{"ANTARTIDA COMPAÑIA ARGENTINA DE SEGUROS S.A."}	5	2023-01-21 21:12:13.486	2023-01-21 21:13:29.075
100	BAEZ RAMON C/ PROVINCIA ART SA S/ Acciones por Accidentes Laborales Abreviadas	58810/2021	SENTENCIA_O_CONVENIO_DE_PARTES	INACTIVO	f	f	{"HIRCH, MARCOS FABIAN"}	{"FLOSI, FRANCO GIULIANO","CERUTTI, CARLOS DANIEL"}	{"PROVINCIA ART SA"}	1	2023-01-09 23:58:07.876	2023-01-10 00:13:54.4
101	RAMBO MATIAS JAVIER C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	107681/2017	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-21 20:53:02.736	2023-01-21 20:54:39.921
110	FERREYRA JULIO CESAR Y OTRO C/ FREY RODRIGO FABIAN Y OTROS S/DAÑOS Y PERJUICIOS Y DAÑO MORAL	136439/2017	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	{"ZAMORA, JOSÉ MARIA (H"}	{"HASAN, JUAN JOSÉ","MELNICHUK, ABEL ANTONIO ISAAC"}	{"COPAN COOPERATIVA DE SEGUROS LIMITADA"}	2	2023-01-21 22:10:24.848	2023-01-21 22:14:08.689
111	 DOS SANTOS LUCAS DANIEL C/ DERNA SANTIAGO AUGUSTO y Otro/a S/ Daños y Perjuicios y Daño Moral	2299/2009	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	2	2023-01-21 22:16:20.849	2023-01-21 22:16:20.849
112	DE LA ROSA MIGUEL ANGEL C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	71238/2017	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2023-01-21 22:29:12.772	2023-01-21 22:29:29.448
107	FITZNER ARIEL PASCUAL C/ LA SEGUNDA ART S.A S/ ACCIDENTE DE TRABAJO	124200/2017	HONORARIOS_REGULADOS	MEDIA	f	f	{"JUDAIS CARLOS MARIA"}	{"BONIUK, CARLA PAMELA"}	{"LA SEGUNDA ART S.A"}	2	2023-01-21 21:29:59.272	2023-01-21 21:35:14.321
123	DORETTO HUGO RUBEN C/ TOTAL DISTRIBUCIONES SRL S/ Indemnización por Accidente de Trabajo	 2204/2009	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	\N	\N	\N	1	2023-01-27 22:40:48.937	2023-01-27 22:40:48.96
113	DE LOS SANTOS JORGE DANIEL C/ SMG ART SA S/ Acciones Laborales Abreviada	109688/2018	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-22 11:58:35.593	2023-01-22 11:58:45.763
119	ROTTA RICARDO MAXIMO C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	51008/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	{"FEVERSANI, SERGIO LUIS","RIOTORTO, LISANDRO MARTIN"}	{"DEL PIANO, CLAUDIA NOELIA"}	{"PREVENCION ART SA"}	1	2023-01-22 12:23:38.661	2023-01-22 12:25:46.745
117	DA ROSA CARLOS FABIAN C/ PROVINCIA ART SA S/ Acciones por Accidentes Laborales ORDINARIO	16358/2020	ACEPTA_CARGO	MEDIA	f	f	{"HIRCH, MARCOS FABIAN"}	{"VILLAVERDE, RODRIGO SEBASTIAN","JUDAIS, CARLOS MARIA"}	{"PROVINCIA ART SA"}	1	2023-01-22 12:10:38.4	2023-01-22 12:14:06.854
66	LÓPEZ BALDOMERO FABIÁN C/ EL CONDOR S.R.L. y OTRO/A P/ POR ACCIÓN ESPECIAL ACCIDENTE DE TRABAJO	3148/2013	PERICIA_REALIZADA	BAJA	f	f	{"BOSCHETTO, SUSANA DOMINGA"}	{"BOHER, MARIA EMILSE"}	{"PREVENCION ART SA"}	1	2022-11-30 21:30:48.371	2023-01-28 02:10:25.774
124	AVELLANEDA WALTER JOSIAS C/ FEDERACION PATRONAL DE SEGUROS S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	40185/2015	COBRADO	NULA	f	f	{"PASTOR, CARLOS ALBERTO"}	{"LEVITT, LEONARDO SEBASTIAN"}	{"FEDERACION PATRONAL DE SEGUROS "}	1	2023-01-28 12:47:27.337	2023-01-28 12:56:35.628
115	BUENO DANTE MAXIMILIANO C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	23041/2017	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-22 12:01:24.43	2023-01-27 07:26:55.581
125	CARDOZO RICARDO JAVIER C/ PREVENCION ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	80366/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 12:58:06.178	2023-01-28 12:58:06.178
126	DOS SANTOS AURELIO DEOCLIDE C/FEDERACION PATRONAL SA S/ INDEMNIZACION POR ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	85716/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 13:16:55.573	2023-01-28 13:16:55.573
127	PADILLA CARLOS RAMON C/ LA SEGUNDA ART SA S/  INDEMNIZACION POR ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	26068/2016	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-28 13:18:45.222	2023-01-28 13:18:45.222
128	DE LISBOA NOEL RICARDO C/LA SEGUNDA ART SA S/ ACCION INDEMNIZATORIA DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	2487/2014	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 13:20:28.582	2023-01-28 13:20:28.582
129	DOS SANTOS JOSE OSCAR C/ YERBATERA DEL NORDDESTE S/ ACCION INDEMNIZATORIA DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	849/2014 	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 13:22:02.095	2023-01-28 13:22:02.095
132	GOIZ ROBERTO LUIS C/ ASOCIART ART SA S/ INDEMNIZACION POR ACCIDENTE DE TRABAJO	4654/2012	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-28 14:33:19.308	2023-01-28 14:33:19.309
133	MARTINEZ RUBEN GUSTAVO C/ LA CAJA ART SA S/ACCION INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	42506/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 14:35:13.43	2023-01-28 14:35:13.43
134	ALVEZ YANNINA BEATRIZ C/ BOATINI YANINA MABEL S/ ACCION INDEMNIZATORIA Y DERVIDA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	98113/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 14:36:50.205	2023-01-28 14:36:50.206
173	VIERA ANTONIO DANIEL C/ ASOCIART ART SA S/ ACCION INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	92231/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 01:25:06.646	2023-01-29 01:25:06.647
137	MATOSSO DIEGO ARMANDO C/ ASOCIART ART SA S/ ACCION INDEMNNIZATORIA y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	85712/2015	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	{"THAMES JOSE IGNACIO"}	{"ASOCIART ART SA"}	1	2023-01-28 14:45:56.781	2023-01-28 14:48:39.851
135	ANTUNEZ ARIEL C/ PREVENCION ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	7405/2016	ACEPTA_CARGO	NULA	f	f	\N	{"LEVITT, LEONARDO SEBASTIAN"}	{"PREVENCION ART SA"}	1	2023-01-28 14:38:58.388	2023-01-28 14:39:19.362
136	JARA LEONARDO ANGEL C/ LA SEGUNDA ART SA S/ ACCION INDEMNIZATORIA DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	65683/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 14:43:53.609	2023-01-28 14:43:53.61
138	HOFFMAN MMIGUEL ANGEL C/ FEDERACION PARTONAL ART SA S/ ACCION INDEMNNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	44747/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 14:50:15.934	2023-01-28 14:50:15.934
139	ARRUDA SERGIO OMAR C/ GALENO ART SA S/ ART 223 LEY XIII.2 Abrev. POR DIFERENCIA EN PRESTACION LEY 24.557 DTOS. REGLAMENTARIOS.	61971/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 14:57:25.942	2023-01-28 14:57:25.942
167	GASPAR DA SILVA ISABELINO C/PREVENCION ART SA S/ ACCIONES POR ACCIDENTES LABORALES ABREVIADAS 	136505/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 00:47:03.719	2023-01-29 00:47:03.719
157	DORNELLES LUIS FERNANDO C/ ASOCIART ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	274/2013	PERICIA_REALIZADA	MEDIA	f	f	{"OVANDO PRADIER, MARIO LUIS ARMANDO"}	{"LEVITT, LEONARDO SEBASTIAN"}	{"ASOCIART ART SA"}	1	2023-01-28 22:19:38.437	2023-01-28 22:21:41.76
140	ESCARBAN NILSA C/ BERKLEY INTERNATIONAL ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	94620/2015	SENTENCIA_O_CONVENIO_DE_PARTES	NULA	f	f	{"ZAMORA, JOSÉ MARIA (H"}	{"THAMES JOSE IGNACIO"}	{"BERKLEY INTERNATIONAL ART SA"}	1	2023-01-28 14:58:10.504	2023-01-28 15:01:16.576
141	RIBEIRO MIRANDA JUAN CARLOS C/ QBE ART SA S/ ACCION INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	3804/2014	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 15:03:58.704	2023-01-28 15:03:58.704
142	RODRIGUEZ RAMON C / REVENCION ART SA S/ ACCION INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	49390/2015	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-28 15:11:00.358	2023-01-28 15:11:00.359
143	BALBUENA OMAR ENRIQUE C/ PREVENCION ART SA S/ Indemnización por Accidente de Trabajo	4473/2012	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-28 15:12:48.837	2023-01-28 15:12:48.838
144	SOSA ROGELIO ANDRES C/ ASOCIART ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	273/2013	ACEPTA_CARGO	NULA	f	f	\N	\N	\N	1	2023-01-28 15:15:48.159	2023-01-28 15:15:48.16
145	DA ROSA ORLANDO C/ GALENO ART SA S/ ACCION ESPECIAL DE ACCIDENTE DE TRABAJO	1642/2013	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-28 15:18:38.99	2023-01-28 15:18:38.991
146	GAUTO HORLANDO DANIEL C/ ASOCIART ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	1777/2014 	EN_TRATATIVA_DE_COBRO	ALTA	f	f	\N	\N	\N	1	2023-01-28 15:28:06.47	2023-01-28 15:28:06.47
158	NOLAZCO EMILIO CESAR C/ LA CAJA ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	80378/2015	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-28 22:23:27.946	2023-01-28 22:23:27.947
147	KRAMPE SANDRO ARIEL C/ ASOCIART ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	26073/2016	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	{"LEVITT, LEONARDO SEBASTIAN"}	{"ASOCIART ART SA"}	1	2023-01-28 15:35:39.502	2023-01-28 15:36:21.622
148	CAMARGO HORACIO RUBEN C/ LA SEGUNDA ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	1110/2013	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-28 15:39:32.977	2023-01-28 15:39:32.977
150	RODRIGUEZ MIRTA TERESA C/LA SEGUNDA ART SA S/ ACCIONES ESPECIALES POR ACCIDENTES LABORALES ABREVIADAS	111613/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 21:54:40.733	2023-01-28 21:54:40.734
149	LOPEZ ALEJANDRO JAVIER C/LA SEGUNDA ART SA S/ ACCION ESPECIAL ACCIDENTE DE TRABAJO-LEY 24.557	4329/2012	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 21:52:11.509	2023-01-28 21:55:05.234
151	BRITES GONCALVES JOSE ILMAR C/ LA SEGUNDA ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	2220/2013	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 21:56:16.399	2023-01-28 21:56:16.4
152	NACIMIENTO SILVIO ROSALINO C/ LA SEGUNDA ART S/ Acción Especial Accidente de Trabajo - Ley 24557	850/2013	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 21:59:35.368	2023-01-28 21:59:35.369
159	FERNANDEZ JUAN C/ LA SEGUNDA ART SA S/ACCION ESPECIAL DE ACCIDENTE DE TRABAJO- LEY 24.557	272/2013	HONORARIOS_REGULADOS	NULA	f	f	\N	\N	\N	1	2023-01-28 22:40:26.604	2023-01-28 22:40:26.604
153	TONN GEREMIAS C/ ASOCIART ART SA S/ ACCION ESPECIAL ACCIDENT DE TRABAJO	292/2013	SENTENCIA_O_CONVENIO_DE_PARTES	NULA	f	f	\N	{"LEVITT, LEONARDO SEBASTIAN"}	{"ASOCIART ART SA"}	1	2023-01-28 22:02:18.713	2023-01-28 22:03:48.647
154	SCHWANKE MIGUEL ANGEL C/ PREVENCION ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	40197/2015	SENTENCIA_O_CONVENIO_DE_PARTES	NULA	f	f	\N	\N	\N	1	2023-01-28 22:05:28.338	2023-01-28 22:05:28.338
155	PIRIZ RAMON CESAR C/ ASOCIART ART SA S/ ACCION INDEMNIZATORIA DEERIVADA DE ACCIDENTE DE TRABAJO	3502/2014	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-28 22:15:24.956	2023-01-28 22:15:24.957
164	OLEYNIEZAK CARLOS JOSE C/ FEDERACION PATRONAL SEGUROS  SA S/ ACCION POR ACCIDENTES LABORALES ABREVIADAS (ART. 223 CPL)	77678/2016	COBRADO	NULA	f	f	\N	{GONZALEZ}	{"FEDERACION PATRONAL DE SEGUROS SA"}	1	2023-01-29 00:15:13.042	2023-01-29 00:16:01.679
156	ESPINOLA MIGUEL C/ LA SEGUNDA ART SA S/INDEMNIZACION POR ACCIDENTE DE TRABAJO	4636/2012	COBRADO	NULA	f	f	\N	{"THAMES JOSE IGNACIO"}	{"LA SEGUNDA ART S.A"}	1	2023-01-28 22:17:33.826	2023-01-28 22:18:01.429
165	ESPINDOLA JORGE RAFAEL C/ PREVENCION ART SA S/ ACCIONES POR ACCIDENTES LABORALES ABREVIADAS	123.957/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 00:17:26.545	2023-01-29 00:17:26.545
162	DA SILVA EZEQUIEL ANIBAL C/ LA SEGUNDA ART SA S/ ACCION ESECIAL ACCIDENTE DE TRABAJO- LEY 24.557	303/2013	ACEPTA_CARGO	NULA	f	f	\N	{"LEVITT, LEONARDO SEBASTIAN"}	{"LA SEGUNDA ART S.A"}	1	2023-01-29 00:06:06.453	2023-01-29 00:08:21.581
161	ARAUJO ELEUTERIO C/LA SEGUNDA ART SA S/ ACCION ESPECIAL ACCIDENTE DE TRABAJO- LEY 24.557	309/2013	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 00:04:20.99	2023-01-29 00:04:20.991
163	DOS SANTOS JORGE ALFREDO C/ FEDERACION ATRONAL SEGUROS SA S/ACCION POR ACCIDENTES LABORALES ABREVIADAS ( ART.23 CPL)	103800/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 00:13:04.184	2023-01-29 00:13:04.185
166	KACHI CLAUDIO ALBERTO C/ ASOCIART ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	124935/2015	EN_TRATATIVA_DE_COBRO	NULA	f	f	\N	\N	\N	1	2023-01-29 00:23:17.264	2023-01-29 00:23:17.264
168	BARRIENTOS RODOLFO OSCAR C/ ASOCIART ART SA S/ INDEMNIZACION POR ACCIDENTE DE TRABAJO	4164/2012	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 00:49:33.562	2023-01-29 00:49:33.563
169	BRITES DE MORAIS HECTOR FABIAN C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas (Art 223 - CPL)	92821/2016	HONORARIOS_REGULADOS	MEDIA	f	f	\N	\N	\N	1	2023-01-29 00:54:49.01	2023-01-29 00:54:49.01
170	MACIEL DERLI RAMON C/ GALENO ART SA S/ ACCION ESPECIAL ACCIDENTE DE TRABAJO	308/2013	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 01:01:20.052	2023-01-29 01:01:20.052
171	LA CRUZ RAMON OSCAR  C/ LA SEGUNDA ART SA S/  ACCION INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	64583/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 01:04:09.508	2023-01-29 01:04:09.508
172	SCHUTZ RAMON ALBERTO  C/ FEDERACION PATRONAL ART SA S/ ART 223- LEY XIII  ABREV. POR DIFERENCIA EN PRESTACIONES  LEY 24.557-26773 DTOS REGLAMENTARIOS	24344/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 01:14:47.311	2023-01-29 01:14:47.312
191	FIGUEREDO WALTER HORACIO C/ LA SEGUNDA ASEGURADORA DE RIESGO DEL TRABAJO SA S/ INDEMNIZACION POR ACCIDENTE DE TRABAJO	3947/2012	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 17:31:28.29	2023-01-29 17:31:28.291
195	PASLAUSKI LUCIO GABRIEL C/ BARRUFALDI LUIS ARMANDO y Otro/a S/ Laboral	4062/2012	ACEPTA_CARGO	MEDIA	f	f	\N	{"RAMIREZ, JOSE MARIA"}	{"ASOCIART ART SA"}	1	2023-01-29 17:47:55.636	2023-01-29 17:54:18.477
174	CARVALLO SERGIO VICTOR C/ FE SRL S/ Indemnización por Accidente de Trabajo	454/2012	HONORARIOS_REGULADOS	BAJA	f	f	{"OVANDO PRADIER, MARIO LUIS ARMANDO"}	{"CARISIMO, MARCELO ADRIAN"}	\N	1	2023-01-29 01:27:06.132	2023-01-29 01:30:52.231
175	DA SILVA MARIO CESAR C/ GALENO ART SA S/ ACCIONES POR ACCIDENTE LABORALES ABREVIADAS 	67632/2017	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 01:33:03.892	2023-01-29 01:33:03.893
196	SODE JOSE C/ ASOCIART ART SA S/ACCIONES POR ACCIDENTES LABORALES ABREVIADAS	41916/2017	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-29 18:43:49.788	2023-01-29 18:43:54.568
176	MARUÑAK PEDRO ANTONIO C/ GALENO ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	7370/2016 	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	\N	\N	\N	1	2023-01-29 01:34:55.553	2023-01-29 01:40:21.992
177	DA SILVA MIRTA IRENE C/ PREVENCION ART SA y Otro/a S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	80620/2015	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	\N	\N	\N	1	2023-01-29 01:41:50.272	2023-01-29 01:41:50.273
178	FERNANDEZ MARTIN JUAN RAMON C/ ASOCIART ART SA S/ ACCIONES POR ACCIDENTES LABORALES ABREVIADAS	24185/2017	PERICIA_REALIZADA	MEDIA	f	f	\N	\N	\N	1	2023-01-29 02:05:38.819	2023-01-29 02:05:38.819
179	CORREA MARCOS ROBERTO C/ GALENO ART SA S/ ACCIONES POR ACCIDENTES LABORALES DE TRAMITE ORDINARIO	113247/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 02:12:17.278	2023-01-29 02:12:17.278
180	MITTIL RENE OMAR C/ OMINT ART SA S/ ACCIDENTE DE TRABAJO	105792/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 02:16:51.848	2023-01-29 02:16:51.849
181	CUBILLA LUIS ALBERTO C/ PREVENCION ART SA S/ ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO	52618/2016	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 02:19:36.816	2023-01-29 02:19:36.817
182	CABRIZA BRUNO DAVID C/ ASOCIART ART S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	2189/2014	SENTENCIA_O_CONVENIO_DE_PARTES	NULA	f	f	\N	\N	\N	1	2023-01-29 02:21:21.832	2023-01-29 02:21:21.832
185	 LLANES GUSTAVO JAVIER  C/ PROVINCIA SEGUROS S/ ACCIONES POR ACCIDENTE LABORALES DE TRÁMITE ORDINARIO- ART 219	105845/2016	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 17:03:38.786	2023-01-29 17:03:55.935
184	SANCHEZ RAMÓN C. C/ FEDERACIÓN PATRONAL SEGUROS S/MACCIDENTE LABORALES ORDINARIO ART 219 DEL CPL	85521/2016	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 17:01:27.412	2023-01-29 17:04:02.263
183	LEIRIA DANIEL OMAR C/ LA SEGUNDA ART SA S/ ACCIONES DE ACCIDENTES LABORALES ABREVIADAS	97735/2016	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 16:58:54.981	2023-01-29 17:04:10.313
186	SEQUEIRA GLORIA EPIFANIA C/ PREVENCION ART SA S/ ACCIONES POR ACCIDENTES LABORALES ABREVIADAS 8Art. 223-CPL9	110643/2016	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-29 17:06:03.416	2023-01-29 17:06:03.416
187	GONSALEZ CARLOS C/ OPERAR SRL y Otro/a S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	18213/2015	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 17:10:44.428	2023-01-29 17:10:44.429
188	CARDOZO EMILIO C/ GALENO ART SA S/ ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL.	7353/2016	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 17:13:10.385	2023-01-29 17:13:10.386
160	MELO HECTOR C/ FEDERACION PATRONAL SEGUROS S/ ACCION ESPECIAL Y  DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL 	3269/2014	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	{"LEVITT, LEONARDO SEBASTIAN"}	{"FEDERACION PATRONAL DE SEGUROS "}	1	2023-01-28 22:52:31.721	2023-01-29 17:14:06.907
197	BARBOZA ROBERTO CARLOS C/ EXPERTA ART SA S/ ACCIONES POR ACCIDENTES LABORALES DE TRÁMITE ORDINARIO	34799/2017	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 18:47:22.58	2023-01-29 18:47:22.58
198	GONZALEZ CARLOS ALBERTO C/ LA SEGUNDA ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	7378/2016	EN_TRATATIVA_DE_COBRO	ALTA	f	f	\N	\N	\N	1	2023-01-29 18:50:41.131	2023-01-29 18:50:41.132
192	BRENDEL NORBERTO OSCAR C/ LA SEGUNDA ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	277/2013	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	{"JUDAIS CARLOS MARIA"}	{"LEVITT, LEONARDO SEBASTIAN"}	{"LA SEGUNDA ART S.A"}	1	2023-01-29 17:32:30.293	2023-01-29 17:34:19.371
189	DA ROSA MARCOS DAVID C/ FEDERACION PATRONAL SEGUROS SA y Otro/a S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	3271/2014	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	{"PASTOR, CARLOS ALBERTO","BOSCHETTO, SUSANA DOMINGA"}	{"LEVITT, LEONARDO SEBASTIAN"}	{"FEDERACION PATRONAL DE SEGUROS SA"}	1	2023-01-29 17:16:35.619	2023-01-29 17:27:00.703
190	DE LIMA JOSE C/ FEDERACION PATRONAL SEGUROS SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	3784/2014	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-01-29 17:30:05.631	2023-01-29 17:30:05.632
193	WEIS CRISTIAN RUBEN OSVALDO C/ LA SEGUNDA ART SA S/ ACCION INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL 	3270/2014	COBRADO	NULA	f	f	\N	\N	\N	1	2023-01-29 17:40:39.624	2023-01-29 17:40:39.625
194	GUTKOSKI JOSE C/ FEDERACIÓN PATRONAL SEGUROS SA Y OTRO/A S/ ACCIÓN INDEMNIZATORIA Y DERIVADA DE ACCIDENTE DE TRABAJO Y ENFERMEDAD PROFESIONAL	12684/2015	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-01-29 17:44:16.103	2023-01-29 17:44:16.103
200	FLORES CARLOS GABRIEL C/ LA SEGUNDA ART SA S/ Art. 223- Ley XIII Pto.2	6249/2017	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-02 11:29:08.207	2023-02-02 11:29:54.655
199	STAIMBRENNER LUIS MORENO C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	127.039/2016	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2023-01-29 19:05:00.195	2023-01-29 19:05:06.053
201	OLIVERA JULIO RAMON C/ DON EDUARDO SRL S/ INDEMNIZACION POR ACCIDENTE DE TRABAJO	4255/2011	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-02 11:31:23.482	2023-02-02 11:31:23.483
202	PERREYRA ALBERTO GUILLERMO C/ GALENO ART SA S/ Acción Especial Accidente de Trabajo - Ley 24557	1976/2013	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-02 12:58:33.408	2023-02-02 12:58:33.409
203	LIMA RAMON ESTEBAN C/ PREVENCION ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	7360/2016	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2023-02-02 13:01:53.466	2023-02-02 14:09:10.24
204	MONZON JUAN RAMON C/ BORCOM SA S/ Acciones por Accidentes Laborales de trámite ordinario (Art 219 - CPL)	80749/2016	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-02 14:13:53.897	2023-02-02 14:13:53.898
206	SUAREZ LORINA y Otro/a C/ LOMBARDI JORGE y Otro/a S/ Daños y Perjuicios y Daño Moral	73362/2020	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-02 14:17:26.701	2023-02-02 14:17:26.701
207	MIÑO CESAR ALBERTO C/ LESSE JUAN y Otro/a S/ Daños y Perjuicios	78096/2021	COBRADO	INACTIVO	f	f	\N	\N	\N	4	2023-02-02 14:18:47.402	2023-02-02 14:18:47.402
208	SANABRIA JUAN ALBERTO C/ HOLC RICARDO RODOLFO y Otro/a S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	54574/2015	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	\N	\N	\N	1	2023-02-02 14:42:49.751	2023-02-02 14:42:49.751
205	NUÑEZ ADELINO WALDEMAR C/ ASOCIART ART S.A S/ ACCIDENTE DE TRABAJO	27745/2018	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-02 14:15:55.507	2023-02-02 14:35:43.55
209	KASTNER JUAN MARCELO C/ MIELNICZUK MATERIALES SRL y Otro/a S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	125667/2015	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-02 14:47:35.763	2023-02-02 14:47:35.764
210	BAEZ GERARDO OSCAR C/ LA SEGUNDA ART SA S/ Acciones por Accidentes Laborales de trámite ordinario	155430/2019	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2023-02-03 14:26:06.157	2023-02-03 14:26:06.158
211	BRIZ NESTOR JULIAN C/ LA SEGUNDA ART SA S/ Acciones por Accidentes Laborales Abreviadas	56618/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-03 14:30:39.356	2023-02-03 14:30:39.357
212	DEUTNER HECTOR RUBEN C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	83424/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-03 14:37:32.952	2023-02-03 14:37:32.952
213	DOS SANTOS MIRTA C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales de trámite ordinario	69532/2019	PERICIA_REALIZADA	MEDIA	f	f	\N	\N	\N	1	2023-02-03 14:45:34.148	2023-02-03 14:45:34.149
214	FIGUEREDO JORGE LUIS C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales ABREVIADOS (art.223 CPL)	122110/2016	ACEPTA_CARGO	MEDIA	f	f	\N	\N	\N	1	2023-02-03 14:52:45.214	2023-02-03 14:52:45.215
215	OLIVEIRA JUAN MARCELO C/ DENOKHADE JAVIER ADRIAN y Otro/a S/ Daños y Perjuicios y Daño Moral	122714/2018	PERICIA_REALIZADA	BAJA	f	f	\N	\N	\N	1	2023-02-03 15:01:39.954	2023-02-03 15:01:39.954
216	GALEANO ROMERO MARCELO SENON C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales TRAMITE ORDINARIO	82891/2020	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-04 16:38:50.324	2023-02-04 16:38:50.325
217	GONZALEZ ROSENDO SEBASTIAN C/ FEDERACION PATRONAL SEGUROS ART SA S/ Acciones por Accidentes Laborales Abreviadas	109722/2018	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-04 16:48:32.955	2023-02-04 16:48:32.956
218	KAFER HORACIO REIMUNDO C/ FEDERACION PATRONAL ART SA S/ Acciones por Accidentes Laborales de trÃƒÂ¡mite ordinario	88286/2021	ACEPTA_CARGO	BAJA	f	f	\N	\N	\N	1	2023-02-04 18:02:53.385	2023-02-04 18:02:53.387
219	RODRIGUEZ LICEO EVARISTO C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	123952/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-05 13:37:12.574	2023-02-05 13:37:12.574
220	MACHADO ELIAS C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	136483/21	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-05 13:39:15.734	2023-02-05 13:39:15.734
221	MACHADO JUAN C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	23034/20	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-05 13:43:08.407	2023-02-05 13:43:08.407
222	MACHADO RUBEN ANTONIO c/ SWISS MEDICAL ART SA s/ Accidente de Trabajo p/ Recurso de Apelación Dictamen de Comisión Médica	59917/15	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-05 13:48:37.425	2023-02-05 13:48:37.426
235	ROSCISZEWSKI FABIAN C/ LA SEGUNDA ART SA S/ Acciones por Accidentes Laborales Abreviadas	66060/2019 	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2023-02-06 14:52:55.302	2023-02-06 14:57:17.771
236	SANABRIA DANIEL OSVALDO C/ EXPERTA ART SA S/ Acciones por Accidentes Laborales Abreviadas	46993/2020	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	\N	\N	\N	1	2023-02-06 15:01:15.514	2023-02-06 15:01:15.514
237	Martínez Ruben c/ Prevención ART SA S/ Acciones por Accidentes Laborales Abreviadas	102002/2021 	ACEPTA_CARGO	ALTA	f	f	\N	\N	\N	1	2023-02-06 15:44:12.217	2023-02-06 15:44:12.218
223	MARQUEZ ALBERTO C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	46989/20	ACEPTA_CARGO	BAJA	f	f	{"RIOTORTO, LISANDRO MARTIN","FEVERSANI, SERGIO LUIS"}	{"DEL PIANO, CLAUDIA NOELIA"}	{"PREVENCION ART SA"}	1	2023-02-05 13:54:02.758	2023-02-05 14:13:34.821
224	MARQUEZ JULIO CESAR C/ GALENO ART S/ Acciones por Accidentes Laborales Abreviadas	71220/2019	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-05 14:15:02.308	2023-02-05 14:15:02.309
238	BACK SERGIO FABIAN C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	51009/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-07 23:25:51.523	2023-02-07 23:25:51.523
77	FERNANDEZ VICTOR ALFREDO C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	46983/2020	SENTENCIA_O_CONVENIO_DE_PARTES	URGENTE	f	f	{}	{}	{}	1	2022-12-22 14:44:09.747	2023-02-07 23:40:21.456
225	MARTINEZ RUBEN C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales Abreviadas	102002/2021	HONORARIOS_REGULADOS	ALTA	f	f	{"RIOTORTO, LISANDRO MARTIN","FEVERSANI, SERGIO LUIS"}	{"DEL PIANO, CLAUDIA NOELIA"}	\N	1	2023-02-05 14:19:30.131	2023-02-05 14:21:45.941
226	MAYER WALDEMAR OMAR C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	105625/2020	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-06 11:32:05.933	2023-02-06 11:32:05.97
227	MELGAREJO FRANCO EMANUEL C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	153518/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-06 11:44:08.721	2023-02-06 11:44:08.722
228	OLIVERA GUSTAVO HERNAN C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	57132/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-06 11:55:28.604	2023-02-06 11:55:28.604
229	OLIVERA MIGUEL ANGEL C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales abreviadas (art 223 CPL)	147321/2017	SENTENCIA_O_CONVENIO_DE_PARTES	ALTA	f	f	\N	\N	\N	1	2023-02-06 11:58:23.16	2023-02-06 12:13:07.433
230	ORTIZ VICTOR DANI C/ PREVENCION ART SA S/ Acciones por Accidentes Laborales de Tramite Ordinario	140016/2019	HONORARIOS_REGULADOS	MEDIA	f	f	\N	\N	\N	1	2023-02-06 13:13:02.862	2023-02-06 13:13:02.863
231	POHL SOLEDAD SILVINA C/ LA SEGUNDA ART SA S/ Accion por Enfermedad Profesional	113154/2021	ACEPTA_CARGO	BAJA	f	f	\N	\N	\N	1	2023-02-06 14:14:50.314	2023-02-06 14:14:50.316
232	RIVERO ANIBAL DANIEL C/ LAS TREINTA SA S/ Acciones por Accidentes Laborales de trámite ordinario	12890/2018	SENTENCIA_O_CONVENIO_DE_PARTES	BAJA	f	f	\N	\N	\N	1	2023-02-06 14:20:27.847	2023-02-06 14:20:27.847
233	RODRIGUEZ CARLOS MAURO C/ SWISS MEDICAL GROUP ART SA S/ Acción Indemnizatoria y Derivada de Accidente de Trabajo y Enfermedad Profesional	140800/2015	ACEPTA_CARGO	BAJA	f	f	\N	\N	\N	1	2023-02-06 14:33:19.917	2023-02-06 14:33:19.918
234	ROMERO JOSE DIEGO C/ SWISS MEDICAL ART SA S/ Acciones por Accidentes Laborales Abreviadas	136681/2016 	COBRADO	INACTIVO	f	f	\N	\N	\N	1	2023-02-06 14:46:36.97	2023-02-06 14:46:36.971
239	GARCETE CRISTIAN DANIEL C/ PROVINCIA ASEGURADORA DEL RIESGOS DE TRABAJO SA S/ Acciones por Accidentes Laborales Abreviadas	49867/2021	ACTO_PERICIAL_REALIZADO	BAJA	f	f	\N	\N	\N	1	2023-02-07 23:53:01.415	2023-02-07 23:53:01.415
240	JONSSON JUAN SEBASTIAN C/ FEDERACION PATRONAL SEGUROS ART SA S/ Acciones por Accidentes Laborales Abreviadas	33116/2018	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-07 23:58:29.258	2023-02-07 23:58:29.259
241	KLEÑUK EUSEBIO BENJAMÍN C/ ASOCIART ART SA S/ Acciones por Accidentes Laborales Abreviadas	56651/2022	ACEPTA_CARGO	BAJA	f	f	\N	\N	\N	1	2023-02-08 00:07:43.957	2023-02-08 00:07:43.957
242	MANSILLA MARCELO DANIEL C/ BERKLEY INTERNACIONAL ART SA S/ Acciones por Accidentes Laborales Abreviadas	138620/2019	SENTENCIA_O_CONVENIO_DE_PARTES	MEDIA	f	f	\N	\N	\N	1	2023-02-08 00:10:50.399	2023-02-08 00:10:50.4
243	MONTERO OSVALDO C/ FEDERACION PATRONAL SEGUROS SA S/ Acciones por Accidentes Laborales Abreviadas	160691/2019	HONORARIOS_REGULADOS	ALTA	f	f	\N	\N	\N	1	2023-02-08 00:28:26.006	2023-02-08 00:28:26.007
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, email, name, verified, role) FROM stdin;
2	buzzcutseason73@gmail.com	NoBuzzcut	t	ADMIN
3	gisselsantino1216@gmail.com	GISSELSANTINO1216@GMAIL.COM	t	ADMIN
4	hugomitoire@gmail.com	Hugo	t	ADMIN
1	gastonmm@gmail.com	Gastón	t	ADMIN
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
b73ff811-2650-4171-aa83-39c984994f43	a0a8a632909e82a17473fae36536179359a4f118678deb5c973bcd0f26421655	2022-11-18 22:25:02.73396-03	20221119012457_init	\N	\N	2022-11-18 22:25:01.772032-03	1
\.


--
-- Name: Court_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Court_id_seq"', 6, true);


--
-- Name: District_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."District_id_seq"', 1, true);


--
-- Name: Note_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Note_id_seq"', 235, true);


--
-- Name: Office_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Office_id_seq"', 9, true);


--
-- Name: Record_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Record_id_seq"', 243, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 4, true);


--
-- Name: Court Court_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Court"
    ADD CONSTRAINT "Court_pkey" PRIMARY KEY (id);


--
-- Name: District District_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."District"
    ADD CONSTRAINT "District_pkey" PRIMARY KEY (id);


--
-- Name: Note Note_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_pkey" PRIMARY KEY (id);


--
-- Name: Office Office_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Office"
    ADD CONSTRAINT "Office_pkey" PRIMARY KEY (id);


--
-- Name: Record Record_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Record"
    ADD CONSTRAINT "Record_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: District_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "District_name_key" ON public."District" USING btree (name);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Court Court_districtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Court"
    ADD CONSTRAINT "Court_districtId_fkey" FOREIGN KEY ("districtId") REFERENCES public."District"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Note Note_recordId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Note"
    ADD CONSTRAINT "Note_recordId_fkey" FOREIGN KEY ("recordId") REFERENCES public."Record"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Office Office_courtId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Office"
    ADD CONSTRAINT "Office_courtId_fkey" FOREIGN KEY ("courtId") REFERENCES public."Court"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Record Record_officeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Record"
    ADD CONSTRAINT "Record_officeId_fkey" FOREIGN KEY ("officeId") REFERENCES public."Office"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

