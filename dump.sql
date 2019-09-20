--
-- PostgreSQL database dump
--

-- Dumped from database version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.10 (Ubuntu 10.10-0ubuntu0.18.04.1)

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
-- Name: documents; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE documents WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'ru_RU.UTF-8' LC_CTYPE = 'ru_RU.UTF-8';


ALTER DATABASE documents OWNER TO postgres;

\connect documents

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: deal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    deal_type integer NOT NULL
);


ALTER TABLE public.deal OWNER TO postgres;

--
-- Name: deal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deal_id_seq OWNER TO postgres;

--
-- Name: deal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deal_id_seq OWNED BY public.deal.id;


--
-- Name: deal_product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_product (
    id integer NOT NULL,
    deal_id integer NOT NULL,
    product_id integer NOT NULL,
    count integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.deal_product OWNER TO postgres;

--
-- Name: deal_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deal_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deal_product_id_seq OWNER TO postgres;

--
-- Name: deal_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deal_product_id_seq OWNED BY public.deal_product.id;


--
-- Name: deal_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_type (
    id integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.deal_type OWNER TO postgres;

--
-- Name: deal_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deal_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.deal_type_id_seq OWNER TO postgres;

--
-- Name: deal_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deal_type_id_seq OWNED BY public.deal_type.id;


--
-- Name: partner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partner (
    id integer NOT NULL,
    name text,
    surname text,
    patronymic text,
    company_name text
);


ALTER TABLE public.partner OWNER TO postgres;

--
-- Name: partner_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.partner_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partner_id_seq OWNER TO postgres;

--
-- Name: partner_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.partner_id_seq OWNED BY public.partner.id;


--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    name text NOT NULL,
    purchase_price double precision DEFAULT 0 NOT NULL,
    selling_price double precision DEFAULT 0 NOT NULL,
    stock integer
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_id_seq OWNER TO postgres;

--
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- Name: stock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock (
    id integer NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.stock OWNER TO postgres;

--
-- Name: stock_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_id_seq OWNER TO postgres;

--
-- Name: stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;


--
-- Name: deal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal ALTER COLUMN id SET DEFAULT nextval('public.deal_id_seq'::regclass);


--
-- Name: deal_product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_product ALTER COLUMN id SET DEFAULT nextval('public.deal_product_id_seq'::regclass);


--
-- Name: deal_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_type ALTER COLUMN id SET DEFAULT nextval('public.deal_type_id_seq'::regclass);


--
-- Name: partner id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner ALTER COLUMN id SET DEFAULT nextval('public.partner_id_seq'::regclass);


--
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- Name: stock id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock ALTER COLUMN id SET DEFAULT nextval('public.stock_id_seq'::regclass);


--
-- Data for Name: deal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal (id, partner_id, date, deal_type) FROM stdin;
29	1	2019-09-09 13:23:16.249634	1
28	1	2019-08-30 13:20:45.559	2
30	1	2019-09-09 13:23:41.380317	2
33	16	2019-09-13 13:08:15.939035	2
34	2	2019-09-16 10:46:19.84499	1
35	2	2019-09-16 10:46:35.394464	2
36	18	2019-09-16 10:47:36.339183	2
37	2	2019-09-16 11:53:42.275812	1
43	16	2019-09-16 13:29:14.958214	1
44	16	2019-09-16 13:30:59.616429	2
45	29	2019-09-17 19:14:07.389885	2
46	29	2019-09-18 23:57:22.845203	1
47	1	2019-09-20 08:53:59.410435	2
\.


--
-- Data for Name: deal_product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_product (id, deal_id, product_id, count) FROM stdin;
23	28	1	10
24	28	2	100
25	29	1	10
26	29	2	100
27	30	1	10
28	30	2	100
31	33	5	10
32	33	8	100
33	33	3	21
34	33	2	212
35	34	4	100
36	35	7	120
37	36	3	125
38	37	7	12
39	43	5	12
40	44	8	123
41	44	7	133
42	45	11	10
43	45	15	10
44	45	14	10
45	45	13	10
46	45	12	10
47	46	7	100
48	47	12	100
\.


--
-- Data for Name: deal_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_type (id, value) FROM stdin;
1	Покупка
2	Продажа
\.


--
-- Data for Name: partner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partner (id, name, surname, patronymic, company_name) FROM stdin;
16	Алексей	Алексеев	Алексеевич	Четверочка
2	Петр	Петров	Петрович	Шестерочка
1	Иван	Иванов	Иванович	Пятерочка
18	Сергей	Сергеев	Сергеевич	Троечка
22	Александр	Александров	Александрович	Двоечка
29	Сергей	Бобков	Алексеевич	GreenData
\.


--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.product (id, name, purchase_price, selling_price, stock) FROM stdin;
6	Вода	30	60	1
5	Алкоголь	100	200	1
4	Газировка	50	100	1
8	Сигареты	150	300	1
3	Печенье	40	80	1
2	Молоко	60	120	1
1	Хлеб	20	40	1
7	Мороженное	70	140	1
9	Телефон	5000	10000	2
10	Телевизор	50000	100000	2
11	Компьютер	60000	120000	2
12	Микрофон	2000	4000	2
13	Наушники	5000	10000	2
14	Клавиатура	2500	5000	2
15	Компьютерная мышь	1000	2000	2
16	Машина	500000	1000000	2
17	Сок	60	120	1
20	Плита	50000	100000	2
21	Планшет	5000	10000	2
\.


--
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock (id, value) FROM stdin;
2	Склад техники
1	Продуктовый склад
\.


--
-- Name: deal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deal_id_seq', 47, true);


--
-- Name: deal_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deal_product_id_seq', 48, true);


--
-- Name: deal_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deal_type_id_seq', 2, true);


--
-- Name: partner_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.partner_id_seq', 29, true);


--
-- Name: product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.product_id_seq', 21, true);


--
-- Name: stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_id_seq', 2, true);


--
-- Name: deal deal_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_pk PRIMARY KEY (id);


--
-- Name: deal_product deal_product_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_product
    ADD CONSTRAINT deal_product_pk PRIMARY KEY (id);


--
-- Name: deal_type deal_type_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_type
    ADD CONSTRAINT deal_type_pk PRIMARY KEY (id);


--
-- Name: partner partner_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partner
    ADD CONSTRAINT partner_pk PRIMARY KEY (id);


--
-- Name: product product_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pk PRIMARY KEY (id);


--
-- Name: stock stock_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pk PRIMARY KEY (id);


--
-- Name: deal_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX deal_id_uindex ON public.deal USING btree (id);


--
-- Name: deal_product_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX deal_product_id_uindex ON public.deal_product USING btree (id);


--
-- Name: deal_type_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX deal_type_id_uindex ON public.deal_type USING btree (id);


--
-- Name: deal_type_value_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX deal_type_value_uindex ON public.deal_type USING btree (value);


--
-- Name: partner_company_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX partner_company_name_uindex ON public.partner USING btree (company_name);


--
-- Name: partner_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX partner_id_uindex ON public.partner USING btree (id);


--
-- Name: product_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX product_id_uindex ON public.product USING btree (id);


--
-- Name: product_name_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX product_name_uindex ON public.product USING btree (name);


--
-- Name: stock_id_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX stock_id_uindex ON public.stock USING btree (id);


--
-- Name: stock_value_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX stock_value_uindex ON public.stock USING btree (value);


--
-- Name: deal deal_deal_type_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_deal_type_id_fk FOREIGN KEY (deal_type) REFERENCES public.deal_type(id);


--
-- Name: deal deal_partner_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal
    ADD CONSTRAINT deal_partner_id_fk FOREIGN KEY (partner_id) REFERENCES public.partner(id);


--
-- Name: deal_product deal_product_deal_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_product
    ADD CONSTRAINT deal_product_deal_id_fk FOREIGN KEY (deal_id) REFERENCES public.deal(id);


--
-- Name: deal_product deal_product_product_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_product
    ADD CONSTRAINT deal_product_product_id_fk FOREIGN KEY (product_id) REFERENCES public.product(id);


--
-- Name: product product_stock_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_stock_id_fk FOREIGN KEY (stock) REFERENCES public.stock(id);


--
-- PostgreSQL database dump complete
--

