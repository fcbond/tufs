--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.20
-- Dumped by pg_dump version 8.4.20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO es;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO es;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO es;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_instance (
    id integer NOT NULL,
    targetlanguage text NOT NULL,
    trans text,
    function text,
    pronun text,
    explanation text,
    module_id text NOT NULL,
    xml_file_name text,
    xpath text,
    web_url text,
    usage_id_rel integer,
    selected integer
);


ALTER TABLE public.t_instance OWNER TO es;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO es;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO es;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_usage_classified_rel (
    usage_id integer NOT NULL,
    classified_id text NOT NULL,
    bunrui_no real NOT NULL,
    chukoumoku_no text,
    rui text,
    bumon text,
    chukoumoku text,
    bunruikoumoku text,
    midasi text,
    hontai text,
    yomi text
);


ALTER TABLE public.t_usage_classified_rel OWNER TO es;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_usage_inst_rel (
    id integer NOT NULL,
    usage_id integer,
    inst_id integer,
    disp_priority integer,
    token text,
    token_index integer,
    ptoken text,
    ptoken_index integer
);


ALTER TABLE public.t_usage_inst_rel OWNER TO es;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO es;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO es;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO es;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: es
--

CREATE TABLE t_word_inst_rel (
    word_id integer NOT NULL,
    token text NOT NULL,
    sense text,
    pos text NOT NULL,
    cform text,
    reading text,
    pronunciation text,
    inst_id integer NOT NULL,
    ptoken text
);


ALTER TABLE public.t_word_inst_rel OWNER TO es;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: es
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO es;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: es
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO es;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_bunrui (bunrui_no, chukoumoku) FROM stdin;
1.10	事柄
1.11	類
1.12	存在
1.13	様相
1.14	力
1.15	作用
1.16	時間
1.17	空間
1.18	形
1.19	量
1.20	人間
1.21	家族
1.22	仲間
1.23	人物
1.24	成員
1.25	公私
1.26	社会
1.27	機関
1.30	心
1.31	言語
1.32	芸術
1.33	生活
1.34	行為
1.35	交わり
1.36	待遇
1.37	経済
1.38	事業
1.40	物品
1.41	資材
1.42	衣料
1.43	食料
1.44	住居
1.45	道具
1.46	機械
1.47	土地利用
1.50	自然
1.51	物質
1.52	天地
1.53	生物
1.54	植物
1.55	動物
1.56	身体
1.57	生命
2.10	真偽
2.11	類
2.12	存在
2.13	様相
2.14	力
2.15	作用
2.16	時間
2.17	空間
2.19	量
2.30	心
2.31	言語
2.32	芸術
2.33	生活
2.34	行為
2.35	交わり
2.36	待遇
2.37	経済
2.38	事業
2.50	自然
2.51	物質
2.52	天地
2.56	身体
2.57	生命
3.10	真偽
3.11	類
3.12	存在
3.13	様相
3.14	力
3.15	作用
3.16	時間
3.17	空間
3.18	形
3.19	量
3.30	心
3.31	言語
3.33	生活
3.34	行為
3.35	交わり
3.36	待遇
3.37	経済
3.50	自然
3.51	物質
3.52	天地
3.53	生物
3.56	身体
3.57	生命
4.11	接続
4.30	感動
4.31	判断
4.32	呼び掛け
4.33	挨拶
4.50	動物の鳴き声
\.


--
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_index_char (id, index_char) FROM stdin;
1	A
2	B
3	C
4	D
5	E
6	F
7	G
8	H
9	I
10	J
11	K
12	L
13	M
14	N
15	O
16	P
17	Q
18	R
19	S
20	T
21	U
22	V
23	Y
24	Z
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
155	CLEARED	--------	null	--------	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
457	Venga, levantaos (levantaros), que ya son las ocho y media.	さあ，起きて，もう８時半だよ．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
657	Venga, vamos.	さあ、行こう。	誘う		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1222	Me gusta la comida picante. 	私は辛い料理が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1295	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1323	Me gusta cómo pinta este bolígrafo.	私はこのボールペンの書き良さが私は好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1506			\N		\N	vmod	\N	\N	\N	0	1
1536	¿Qué es Juan?  - Es juez.	フアンの職業は何ですか？―判事です．	\N		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1712	Hay hambre en el Tercer Mundo.	第三世界には飢餓がある．	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1739	Le escribo todas las semanas.	私は彼女［恋人］に毎週手紙を書く．	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1964	¿Tienes hora? - Es la una menos diez.	何時ですか（時計持ってますか）？―12時50分（1時10分前）です．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1965	Ya son más de las cuatro.	すでに4時過ぎだ．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1966	¿A qué hora llegaste? - A eso de las seis y media.	君は何時に着いたの？―6時半ごろです．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]		0	1
1967	Vinieron a las cinco en punto de la tarde.	彼らは午後5時ちょうどにやって来た．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[5]		0	1
1968	¿Cuánto pesas? - Peso 60 kilos.	体重はどのくらいですか？―60キロあります．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1969	¿Cuánto mide usted? - Uno setenta y tres.	身長はどのくらいですか？―1メートル73センチです．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1970	¿Cuánto años tienes? - Tengo 21 años.	何歳ですか？―21歳です．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]		0	1
1971	¿A cuánto están los tomates? - Están a 2 euros el kilo.	トマトはいくらですか？―1キロ2ユーロです．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[4]		0	1
1972	En la nevera hay agua y hielo.	冷蔵庫には水と氷がある．	\N		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1973	Hacer ejercicio todos los días te ayuda mantenerte en forma.	毎日運動をすることは健康を保つのに役立つ．	\N		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
41	CLEARED	--------	null	--------	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
91	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
147	Esta mañana he ido al dentista.	今朝歯医者に行ってきた．	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
229	CLEARED	--------	null	--------	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
311	Jaime es el más gordo de los hermanos.	ハイメは兄弟のなかで一番太っている．	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
479	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[7]/gmod:instance[1]	\N	\N	\N
983	No.	いいえ。	否定する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1408	Pásame la salsa, por favor.	ソースを取ってください。	\N		\N	vmod	\N	\N	\N	0	1
1	CLEARED	--------	null	--------	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2	CLEARED	--------	null	--------	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
3	CLEARED	--------	null	--------	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
4	CLEARED	--------	null	--------	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
5	CLEARED	--------	null	--------	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
6	Yo soy estudiante.	私は学生です．	null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
7	CLEARED	--------	null	--------	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
8	Javier es inteligente.	ハビエルは頭がいいです．	null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
9	¿De dónde sois?  - Somos de Barcelona.	君たちはどこの出身ですか？―バルセロナの出身です．	null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
10	CLEARED	--------	null	--------	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
11	¿Es Vd. profesora?  - No, soy intérprete.	あなたは先生ですか？―いいえ，私は通訳です．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
12	CLEARED	--------	null	--------	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
13	CLEARED	--------	null	--------	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
14	CLEARED	--------	null	--------	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
60	CLEARED	--------	null	--------	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
122	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
168	CLEARED	--------	null	--------	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
188	No hace falta avisarles de antemano.	彼ら［彼女ら／あなたがた］に事前に連絡する必要はない．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
655	Te invito a una copa.	一杯おごるよ。	誘う		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1087	No te preocupes.	大丈夫。	指示する		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1269	El sol sale por el este. 	太陽は東から昇る。	\N		\N	vmod	\N	\N	\N	0	1
1423	¡Levántate!	立って！	\N		\N	vmod	\N	\N	\N	0	1
1432	Té verde	緑茶	\N		\N	vmod	\N	\N	\N	0	1
1483	El niño ha vuelto a hacerse pis en la cama.	子どもはまたベッドでおしっこをした．	\N		\N	vmod	\N	\N	\N	0	1
1563	Buscamos una secretaria.	私たちは秘書を募集しています．	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1639	Ya es tarde.	もう遅い．	\N		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1646	cien mil	10万	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1779	Éstos son mis zapatos.	これが私の靴だ．	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1877	¡Cuánta gente!	なんという人出だ！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
15	CLEARED	--------	null	--------	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
16	CLEARED	--------	null	--------	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
17	CLEARED	--------	null	--------	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
18	CLEARED	--------	null	--------	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
19	CLEARED	--------	null	--------	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
20	CLEARED	--------	null	--------	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
21	CLEARED	--------	null	--------	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
22	CLEARED	--------	null	--------	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
23	Aquí hay un diccionario.	ここに辞書がある．	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
24	Allí no hay agua ni electricidad.	そこには水も電気もない．	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
25	CLEARED	--------	null	--------	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
26	CLEARED	--------	null	--------	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
27	CLEARED	--------	null	--------	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
28	CLEARED	--------	null	--------	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
29	CLEARED	--------	null	--------	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
30	CLEARED	--------	null	--------	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
31	CLEARED	--------	null	--------	\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
32	¿Qué hay sobre la mesa? — Hay un florero.	テーブルの上には何がありますか？　－　花瓶があります．	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
33	¿De quién es el diccionario? — Es de Pepe.	その辞書は誰の？　－　ペペのだよ．	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
34	Hay un puente al lado de la casa.	家の横には橋がある．	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
35	CLEARED	--------	null	--------	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
36	CLEARED	--------	null	--------	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
37	Hay unas revistas sobre el estante.	棚の上に雑誌が何冊かある．	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
38	CLEARED	--------	null	--------	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
39	CLEARED	--------	null	--------	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
40	Hay unas cien casas alrededor de la central nuclear.	原子力発電所の周囲に約１００軒の家がある．	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
42	¿Qué tienes ahí? — Tengo un lápiz, una agenda y un abrecartas.	そこに何を持っているの？　－　鉛筆と，手帳と，ペーパーナイフ．	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
43	CLEARED	--------	null	--------	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
44	CLEARED	--------	null	--------	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
45	CLEARED	--------	null	--------	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
46	CLEARED	--------	null	--------	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
47	CLEARED	--------	null	--------	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
48	CLEARED	--------	null	--------	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
49	La sopa está caliente.	そのスープは熱い．	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
50	CLEARED	--------	null	--------	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
51	La profesora Márquez está en casa.	マルケス先生は家にいます（在宅です）．	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
52	Tengo un ordenador barato. / Tengo una computadora barata.	私は安いコンピュータを持っている．	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
53	Tengo un ordenador grande. / Tengo una computadora grande.	私は大きなコンピュータを持っている．	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
54	Hay hambre en el Tercer Mundo.	第三世界には飢餓がある．	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
55	Roberto es un buen chico.— Sí, es un chico muy bueno.	ロベルトはいいやつだ．―うん，すごくいいやつだよ．	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
56	CLEARED	--------	null	--------	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
57	CLEARED	--------	null	--------	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
58	¿Es buena la película? — No, es mala. Es muy aburrida.	その映画は良い（おもしろい）？　－　いや，おもしろくないよ．すごく退屈だ．	null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
59	¿Cómo son Isabel y Fernando? — Son amables, pero un poco egoístas.	イサベルとフェルナンドはどんな人たち？　－　親切だけど，少し自分勝手だ．	null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
61	CLEARED	--------	null	--------	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
62	¿Está buena la sopa? — Sí, está muy rica.	そのスープはおいしい？　－　うん，すごくおいしいよ．	null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
63	¿Cómo están Isabel y Fernando? —¡Huy, están furiosos!	イサベルとフェルナンドはどんな様子？　－　いやー，怒ってるよ！	null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
64	CLEARED	--------	null	--------	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
65	CLEARED	--------	null	--------	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
66	¿Hablas español? — Sí, hablo español y japonés.	君はスペイン語が話せるの？　－　うん，スペイン語と日本語が話せるよ．	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
67	¿Dónde vivís?— Vivimos en la ciudad de Saitama, al norte de Tokio.	君たちはどこに住んでるの？　－　東京の北にある，さいたま市に住んでるよ．	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
68	¿Qué estudias en la universidad?— Estudio física.	大学で何を勉強しているの？　－　物理学を勉強してる．	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
69	Pedro espera el autobús.	ペドロはバスを待っている．	null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
70	Mamá toma las pastillas.	母さんは薬を飲んでいる．	null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
71	CLEARED	--------	null	--------	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
72	CLEARED	--------	null	--------	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
73	Escribo a mi novia todas las semanas.	私は恋人に毎週手紙を書く．	null		\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
74	CLEARED	--------	null	--------	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
75	CLEARED	--------	null	--------	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
76	CLEARED	--------	null	--------	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
77	Le escribo todas las semanas.	私は彼女［恋人］に毎週手紙を書く．	null		\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
78	Alfonso siempre nos habla en español.	アルフォンソはいつも私たちにスペイン語で話しかけてくる．	null		\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
193	CLEARED	--------	null	--------	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
79	Cuando le escribo, me contesta en seguida.	私が彼女［恋人］に手紙を書くと，すぐに私に返事してくれる．	null		\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
80	CLEARED	--------	null	--------	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
81	CLEARED	--------	null	--------	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
82	Pedro regala unas flores a su novia.	ペドロは花を恋人に贈る．	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
83	Todos los meses Luisa escribe cartas a sus padres.	ルイサは毎月手紙を両親に書く．	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
84	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
85	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
86	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
87	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
88	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
89	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
90	CLEARED	--------	null	--------	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
92	¿Qué quieres? — Yo quiero paella. — Entonces, pedimos una paella para los dos.	何が食べたい？―私はパエリヤが食べたい．　―じゃあ，二人分のパエリヤをひとつ頼もう．	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
93	¿Juegan ustedes al tenis? — Sí, aunque jugamos mal, nos divierte mucho jugar al tenis.	あなた方はテニスをされますか．―ええ，上手ではありませんが，大変楽しくテニスをプレーしていますよ．	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
94	¿Cuántas horas duermes generalmente? —Generalmente duermo cinco o seis horas.	君は普段は何時間寝てるの？―普段は5～6時間寝てるよ．	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
95	CLEARED	--------	null	--------	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
96	CLEARED	--------	null	--------	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
97	¿Qué quieres hacer este fin de semana? — Quiero ir al cine a ver una película argentina.	今週末は何をしたい？―映画館にアルゼンチンの映画を見に行きたいな．	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
98	¿Conoces a Juan? — No, no lo conozco mucho.	フアンを知ってる？―いや，あまりよく知らない．	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
99	CLEARED	--------	null	--------	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
100	CLEARED	--------	null	--------	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
101	CLEARED	--------	null	--------	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
102	¿A dónde vais? — Vamos al despacho del profesor.	君たちどこに行くの？―先生の研究室に行くんだ．	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
103	¿A dónde lleva usted esos libros? — Los llevo a la biblioteca.	その本をどちらへ持っていくんですか？―図書館へ持っていきます．	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
104	¿Qué vas a hacer esta tarde? — Voy a estudiar porque mañana tengo un examen.	今日の午後は何をするの？―明日試験があるから勉強するよ．	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
105	¿Tienes que ir a clase mañana? — No, mañana no tengo que ir.	明日は授業に行かなきゃいけないの？―いや，明日は行かなくてもだいじょうぶ．	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
106	Debéis aprender estos verbos irregulares, porque son muy frecuentes.	これらの不規則動詞は覚えなければいけないよ，とてもよく出てくるから．	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
107	CLEARED	--------	null	--------	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
108	CLEARED	--------	null	--------	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
109	Este libro es muy divertido.	この本はとても面白い．	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
110	Esta silla es muy cómoda.	この椅子はとても座り心地がいい．	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
111	CLEARED	--------	null	--------	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
112	CLEARED	--------	null	--------	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
113	CLEARED	--------	null	--------	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
153	Lo he hecho ya. 	私はすでにそれをし終えた．	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
114	Este bolso es de tela, y ése es de piel.	このカバンは布製で，それ（そのカバン）は革製だ．	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
115	Esta silla es incómoda, pero ésa es muy cómoda.	この椅子は座り心地がよくないが，その椅子はすごくいい．	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
116	Ésta es mi mujer y éstos son mis padres.	こちらが私の妻で，こちらは私の両親です．	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
117	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
118	¿Qué es eso? — ¿Esto? Es un nuevo CD de Paco de Lucía.	何それ？　－　これ？パコ・デ・ルシアの新しいCDだよ．	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
119	Esto es para ti. — Gracias.	これは君にあげるよ．　－　ありがとう．	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
120	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
121	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
123	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
124	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
125	CLEARED	--------	null	--------	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
126	Éstos son mis zapatos.	これが私の靴だ．	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
127	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
128	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
129	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
130	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
131	¿Quién es esa chica? ¿Tu novia? — No, es una amiga mía.	その女の子は誰？君の彼女かい？　－　違うよ，友達だよ．	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
132	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
133	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
134	¿Esta bici es de Pedro? — Sí, es suya. (⇒Sí, es de él).	この自転車はペドロの？　－　そうだよ，彼のだよ．	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
135	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
136	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
137	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
138	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
139	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
140	CLEARED	--------	null	--------	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
141	Aquí están nuestros pasaportes. ¿Dónde está el suyo (el de ella)?	私たちのパスポートはここにある．彼女のはどこだ？	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
142	CLEARED	--------	null	--------	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
143	CLEARED	--------	null	--------	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
144	CLEARED	--------	null	--------	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
145	¿Han estado alguna vez en Venezuela? — No, no hemos estado nunca allí.	（あなたがたは）ベネズエラに行ったことはありますか？　－　いえ，一度もありません．	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
146	¿Ha terminado ya el programa de televisión? — No, todavía no ha terminado.	そのテレビ番組はもう終わったの？　－　いや，まだ終わってないよ．	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
148	Este siglo ha habido muchas guerras.	今世紀には多くの戦争があった．	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
149	Las clases son aburridas.	その授業は退屈だ．	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
150	Las clases han aburrido a los alumnos.	その授業は生徒たちを退屈させた	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
151	¿Ha estado usted alguna vez en Barcelona?	いままでバルセロナへは行かれたことがありますか？	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
152	¿Ha leído Ud. ya este libro?	あなたはもうこの本を読みましたか？	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
154	¿Habéis visto a Víctor? — No, no lo hemos visto.	ビクトルに会った？　―　いや，会わなかったよ．	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
156	Cuando le escribo {a él / a ella / a usted}, me contesta en seguida.	私が彼に（彼女に・あなたに）手紙を書くと，すぐに返事が来る．	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
157	Les mando regalos de Navidad {a ellos / a ellas / a ustedes}.	私はクリスマスプレゼントを彼ら（彼女ら・あなたがた）に送る．	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
158	CLEARED	--------	null	--------	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
159	CLEARED	--------	null	--------	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
160	CLEARED	--------	null	--------	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
161	CLEARED	--------	null	--------	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
162	Pedro le da un beso a su novia.	ペドロは恋人にキスをする．	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
163	Julia les envía un paquete a sus padres.	フリアは両親に小包を送る．	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
164	Todos tus colegas hablan bien de ti.	君の同僚はみんな君のことをほめている．	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
165	Voy a salir de compras con ella esta tarde.	今日の午後彼女と買い物に出かける．	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
166	María ya no quiere salir conmigo.	マリアはもう私と付き合いたくない．	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
167	CLEARED	--------	null	--------	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
169	CLEARED	--------	null	--------	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
170	CLEARED	--------	null	--------	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
171	Me gustan las manzanas.	私はリンゴが好きです．	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
172	Me gustan estos zapatos.	私はこの靴が好きだ（気に入っている）．	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
173	¿Te gusta el vino? — Sí, me gusta mucho.	ワインは好き？―ええ，大好きです．	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
174	CLEARED	--------	null	--------	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
175	CLEARED	--------	null	--------	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
176	CLEARED	--------	null	--------	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
177	CLEARED	--------	null	--------	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
178	A mi hermana no le gusta viajar en avión.	私の姉［妹］は飛行機で旅行するのが嫌いだ．	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
179	¿Por qué no viene Pablo? — Porque a él no le gustan las fiestas.	パブロはどうして来ないの？―パーティーが嫌いだからです．	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
180	¿A ti te gusta la comida española? — Sí, me encanta.	スペイン料理は好き？―ええ，好きです．	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
181	CLEARED	--------	null	--------	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
182	A mi hija le asustan los truenos.	うちの娘は雷を怖がる．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
183	Le disgustaba quedarse sola.	彼女は一人になるのを嫌がっていた．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
184	A los españoles les interesa mucho la política.	スペイン人は政治にとても関心がある．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
185	A los padres les preocupa mucho la educación de los niños.	親は子供の教育をとても心配する．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
186	Faltan dos meses para las Olimpiadas.	オリンピックまであと2ヶ月だ．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
187	Aunque me sobra tiempo me falta dinero.	時間はありあまっているが金がない．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
189	Señora, se le ha caído el pañuelo.	奥さん，ハンカチが落ちましたよ．	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
190	CLEARED	--------	null	--------	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
191	CLEARED	--------	null	--------	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
192	CLEARED	--------	null	--------	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
194	A ti te vieron ayer en el aparcamiento. (× A ti vieron...)	君を昨日彼らが駐車場で見た．	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
195	Anteayer me buscaron a mí en la estación. (× Anteayer buscaron a mí...)	おととい彼らが私を駅で探していた．	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
196	Busqué a Pedro por todas partes. (× Lo busqué a Pedro por todas partes.)	ペドロをそこらじゅう探し回った．	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
197	Buscamos al profesor desde hace una hora. (× Lo buscamos al profesor...)	私たちは先生を１時間前から探している．	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
198	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
199	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
200	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
201	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
202	¿A ti te gusta la comida española? — Sí, me gusta mucho.	スペイン料理は好き？―うん，大好きだよ．	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
203	A ella ya le contesté ayer.	彼女にはもう昨日返事をした．	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
204	Le escribí a él, no a ella.	彼に手紙を書いたのであって，彼女にではない．	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
205	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
206	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
207	A mis padres les mandaré un regalo por sus bodas de oro.	両親に金婚式のプレゼントを送ろう．	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
208	A todos mis colegas ya les mandé tarjetas de Navidad.	同僚全員にもうクリスマスカードを送った．	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
209	CLEARED	--------	null	--------	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
210	¿A qué hora llegaste a casa el otro día? — Llegué a eso de las doce.	この前は何時に家に着いたの？　－　１２時くらい．	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
211	El poeta leyó en voz alta su poema.	詩人は自分の詩を声に出して読んだ（朗読した）．	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
212	Estudié español cuatro años en la universidad.	私は大学で４年間スペイン語を勉強した．	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
213	¿Cuándo te llamó Julia? — Me llamó hace dos o tres días.	フリアはいつ君に電話してきたの？　－　２，３時間前だよ．	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
214	Yo pedí carne y Sofía pidió pescado.	私は肉を頼み（注文し），ソフィアは魚を頼んだ．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
215	¿Qué tal durmió usted anoche? —Mal, dormí muy mal.	昨夜はよく眠れた？　－　ぜんぜんよく眠れなかった．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
216	¿Pudo ver al ministro ayer? — Sí, por fin pude hablar con él.	昨日大臣に会えたのですか？　－　ええ，とうとう彼と話すことができました．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
217	La semana pasada hubo dos terremotos.	先週は２回地震があった．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
218	¿Qué te dijo la profesora? — Que no hice muy bien en el examen.	先生何て言ってたの？　－　私のテストの成績がよくなかったって．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
219	¿Cuántos años estuviste en Buenos Aires? — Cinco años.	ブエノスアイレスには何年いたの？　－　５年．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
220	¿Fuiste a algún sitio el domingo? — No, estuve todo el día en casa.	日曜日どこかに行った？　－　いや，一日中家にいたよ．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
221	La fiesta fue muy divertida.	パーティーはとても面白かった．	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
222	Generalmente me levanto a las siete y media, y me acuesto a las once.	普段私は7時半に起きて，11時に寝ます．	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
223	El abuelo se sentó en el sofá y se puso a leer el periódico.	祖父はソファーに座って新聞を読み始めた．	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
224	La puerta se abre y se cierra sola.	そのドアはひとりでに開閉する．	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
225	A veces me pregunto por qué esto es así.	ときどき私はどうしてこうなのかと自問することがある．	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
226	No me lavé las manos antes de comer.	私は食べる前に手を洗わなかった．	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
227	Como hace mucho frío me pongo el abrigo para salir.	とても寒いので，出かけるためにコートを着る．	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
228	CLEARED	--------	null	--------	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
230	CLEARED	--------	null	--------	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
231	CLEARED	--------	null	--------	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
232	¿Os escribís con frecuencia?	君たちは（お互いに）よく手紙を書くの？	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
233	Pedro se comió una paella entera para cenar.  (cfr. Pedro comió paella para cenar.)	ペドロは夕食にパエリヤひと皿を全部食べてしまった．（cfr. ペドロは夕食にパエリヤを食べた．）	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
234	Ya se han llevado toda la basura. (cfr. Te llevo a casa en coche.)	ごみはもう全部持っていかれてしまった．　（cfr. 車で家まで送ってあげるよ．）	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
235	¿Ya te vas? — Sí, ya me voy. (cfr. ¿Adónde vas? — Voy al supermercado a hacer la compra.)	もう帰るの？―うん，もう帰るよ．　（cfr. どこに行くの？―スーパーへ買い物に．）	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
236	Julia siempre habla de sí misma.	フリアはいつも自分のことばかり話している．	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
237	Paco se llevó consigo todo el dinero guardado en la caja.	パコは金庫にしまってあったお金を全部持っていった．	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
238	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
239	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
240	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
241	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
242	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
243	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
244	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
245	CLEARED	--------	null	--------	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
246	En España se consume mucho aceite de oliva.	スペインではオリーブオイルがよく消費される．	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
247	Se alquilan apartamentos. (掲示)	賃貸アパートあり（アパートが貸し出されている）．	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
248	Se prohíbe fumar. (掲示)	禁煙（タバコを吸うことが禁じられている）．	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
249	CLEARED	--------	null	--------	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
250	CLEARED	--------	null	--------	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
251	CLEARED	--------	null	--------	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
252	CLEARED	--------	null	--------	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
253	CLEARED	--------	null	--------	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
254	CLEARED	--------	null	--------	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
255	Se come bien en este restaurante.	このレストランはおいしい（おいしく食べられる）．	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
256	¿Cuánto tiempo se tarda de aquí a la universidad? — Se tarda aproximadamente una hora.	ここから大学までどのくらい時間がかかる？―だいたい１時間かかるよ．	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
257	¿Se puede (pasar)? — Sí, adelante.	（入って）よろしいですか？　―　ええ，どうぞ．	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
258	Ahora no se respeta a los ancianos como antes.	今は以前ほどお年寄りを大切にしない．	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
259	En este hotel se recibe a los clientes a partir de las tres de la tarde.	このホテルは午後3時からチェックインを受け付けております．	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
260	CLEARED	--------	null	--------	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
261	CLEARED	--------	null	--------	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
262	CLEARED	--------	null	--------	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
263	¿Qué buscas?— Busco las llaves.	何を探してるの？―鍵を探してるんだよ．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
264	¿A quién buscas?— Busco a mis padres.	誰を探してるの？　－　両親を探してるんだ．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
265	¿Cuáles son las ventajas de saber idiomas? — Pues, poder viajar por todo el mundo.	ことば（外国語）を知っていることの利点は何ですか？　－　そうですね，世界中を旅することができることです．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
266	CLEARED	--------	null	--------	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
267	CLEARED	--------	null	--------	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
268	CLEARED	--------	null	--------	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
269	¿Cómo quiere usted la carne, muy hecha o poco hecha? —Normal.	肉はどうなさいますか，ウェルダンですか，レアですか？　－　普通で．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
270	¿Desde cuándo estudias español? — Desde hace un año.	いつからスペイン語を勉強してるの？　－　１年前から．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
271	¿Por qué trabajas tanto? — Porque no tengo dinero.	どうしてそんなに働くの？　－　お金がないからだよ．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
272	¿Qué tal si (Por qué no) vamos al cine esta tarde? —De acuerdo.	今日の午後映画に行かない？　－　いいよ．	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
273	CLEARED	--------	null	--------	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
274	¡Qué hombre más (tan) pesado!	なんてしつこい男だ！	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
275	CLEARED	--------	null	--------	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
276	CLEARED	--------	null	--------	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
277	¡Cómo bailas!	君はなんて踊りがうまいんだ！	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
278	¡Cuánto te lo agradezco!	君にはどれほど感謝していることか！	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
279	¡Cuánta gente! (¡Qué de gente!)	なんという人出だ！	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
280	CLEARED	--------	null	--------	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
281	CLEARED	--------	null	--------	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
282	CLEARED	--------	null	--------	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
283	CLEARED	--------	null	--------	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
284	Nunca tomo café por la noche.	私は夜は決してコーヒーを飲まない．	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
285	Nadie puede hablar bien un idioma sin estudiar.	勉強しなければ誰もことばをうまく話すことはできない．	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
286	A mí no me gusta el flamenco. — A mí tampoco me gusta.	私はフラメンコは好きではない．　－　私も好きではない．	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
287	CLEARED	--------	null	--------	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
288	Los japoneses no usan cubiertos sino palillos.	日本人はナイフとフォークではなく箸を使う．	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
289	CLEARED	--------	null	--------	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
290	Cuando entré en el aula, no había nadie.	私が教室に入ったときには，誰もいなかった．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
291	Yo antes fumaba mucho, pero ahora no fumo nada.	私は以前はたくさんタバコを吸っていたが，今はまったく吸わない．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
292	De niño, vivía en un pueblo muy tranquilo.	子供の頃，とても静かな村に住んでいた．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
293	Cuando era estudiante, me levantaba muy tarde.	学生だった頃，私は朝とても遅く起きていた．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
294	Quería preguntarte una cosa, pero se me ha olvidado.	君に聞きたいことがあったんだけど，忘れちゃったよ．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
295	Sonó el teléfono cuando íbamos a salir.	私たちが出かけようとしていたときに電話が鳴った．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
296	¿Te he interrumpido? — No, no. Ya terminaba.	邪魔したかな？　－　いや，大丈夫．もう終わりかけたところだったから．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
297	Hacía tres años que estudiaba español en México cuando tuvo que volver a Japón.	（彼／彼女は）日本へ戻らねばならなくなったときには，メキシコでスペイン語を勉強して３年になっていた．	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
298	Fernando era tan tonto como Isabel.	フェルナンドはイサベルと同じくらいばかだった．	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
299	Hay tantas chicas como chicos en esta clase.	このクラスには男の子と女の子が同じくらいいる．	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
300	CLEARED	--------	null	--------	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
301	CLEARED	--------	null	--------	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
302	CLEARED	--------	null	--------	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
303	CLEARED	--------	null	--------	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
304	Tiene más de 70 años.	（彼・彼女は）７０歳以上だ．	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
305	Ana es más lista de lo que crees.	アナは君が思うより利口だ．	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
306	CLEARED	--------	null	--------	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
307	CLEARED	--------	null	--------	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
308	¿Diego es mayor o menor que tú? — Ni mayor ni menor. Somos de la misma edad.	ディエゴは君より年上，それとも年下？　－　年上でも年下でもないよ．同い年だ．	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
309	Tu casa es más grande que la mía.	君の家は私のよりも大きい．	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
310	CLEARED	--------	null	--------	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
312	El Teide es la montaña más alta de España.	テイデ山はスペインで一番高い山だ．	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
313	CLEARED	--------	null	--------	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
314	Lo importante es contestarles cuanto antes.	大事なことはできるだけ早く彼ら／彼女らに返事をすることだ．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
315	Me gusta pasear en coche los domingos.	私は日曜日に車で出かける（ドライブに行く）のが好きだ．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
316	Se asomó a la ventana para contemplar el paisaje.	彼／彼女は景色を眺めるために窓から顔を出した．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
317	Encantado de conocerle (haberle conocido).	あなたとお知り合いになれてうれしいです．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
318	Pedro vino corriendo.	ペドロは走ってやって来た．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
319	Yo siempre desayuno viendo la televisión.	私はいつもテレビを見ながら朝食をとる．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
320	Está mal visto hablar con la gente masticando chicle.	ガムをかみながら人と話すのは行儀が悪い．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
321	¿Qué estáis haciendo? — Estamos limpiando la casa.	君たち何をしてるの？　－　家を掃除してるんだよ．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
322	Mamá, ¿estás preparando la cena? — Sí, la estoy preparando.	ママ，夕食を作ってるの？　－　うん，今作ってるところ．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
323	Paseando por la Gran Vía, me encontré con unos amigos.	グラン・ビアを歩いていたら，友達に会った．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
324	Corriendo, puedes coger el tren de las tres.	走れば３時の電車に間に合うぞ．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
325	Siendo joven, tiene canas.	若いのに白髪がある．	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
326	Durante las vacaciones de verano estudiaré español todos los días.	夏休み中は毎日スペイン語を勉強するつもりだ．	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
327	Si no te das prisa, llegarás tarde a clase.	急がないと授業に遅れるよ．	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
328	¿De dónde es María José? — No sé. Será de algún país hispanoamericano.	マリア・ホセはどこの出身？―知らない．どこかラテンアメリカの国の出身だろう．	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
660	Sí, por favor.	うん、お願い。	依頼する		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
329	(¡Ring, ring!) — ¡Huy, el teléfono! ¿Quién será a estas horas?	（リーン！）―おや，電話だ！こんな時間に誰だ？	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
330	CLEARED	--------	null	--------	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
331	CLEARED	--------	null	--------	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
332	CLEARED	--------	null	--------	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
333	CLEARED	--------	null	--------	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
334	Carlos me dijo que me llamaría, pero aún no me ha llamado.	カルロスは私に電話するといったが，まだ電話はない．	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
335	Ya sabía que vendrías a pedirme ayuda.	君が私に助けを求めに来ることはわかっていた．	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
336	Probablemente, el ladrón entraría por la ventana de la cocina y saldría por la puerta.	おそらく泥棒はキッチンの窓から入ってドアから出たのだろう．	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
337	La tierra está mojada; llovería anoche.	地面が濡れている．昨夜雨が降ったんだろう．	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
338	CLEARED	--------	null	--------	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
339	CLEARED	--------	null	--------	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
340	CLEARED	--------	null	--------	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
341	CLEARED	--------	null	--------	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
342	CLEARED	--------	null	--------	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
343	CLEARED	--------	null	--------	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
344	¿Qué tiempo hace hoy?— Hace buen (mal) tiempo.	今日はどんな天気ですか？―いい（悪い）天気ですよ．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
345	Ayer hizo mucho frío.	昨日はとても寒かった．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
346	Este verano ha hecho un calor insoportable.	この夏は耐えがたい暑さだった．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
347	Hoy está nublado.	今日は曇っている．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
348	¿Cuántos años hace que juegas al fútbol? — Hace cinco años que juego al fútbol.	サッカーを何年やってるの（サッカーをして何年になりますか）？―サッカーを5年やっています（サッカーをして5年になります）．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
349	CLEARED	--------	null	--------	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
350	CLEARED	--------	null	--------	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
351	CLEARED	--------	null	--------	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
352	CLEARED	--------	null	--------	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
353	CLEARED	--------	null	--------	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
354	Hay que hacer deporte para mantenerse en forma.	健康を保つにはスポーツをしなくてはならない．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
355	No hay que conducir borracho (bebido).	酔っ払って運転をしてはいけない．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
356	No hay que llevar regalos a todos.	全員にプレゼントを持ってくる必要はない．	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
357	Llaman a la puerta. (× Se llama a la puerta.)	（戸口でベルが鳴ったり，ノックの音がするのを聞いて）誰か来たよ．	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
358	Me han robado la cámara. (× Se me ha robado la cámara.)	カメラを盗まれた．	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
359	En los exámenes me han suspendido en dos asignaturas. (× En los exámenes se me ha suspendido en ...)	試験で2科目を落とした．	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
360	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
361	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
362	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
363	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
364	Comen mucho arroz en Japón.	日本では米をよく食べる．	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1366	¿Sabes escribir letras chinas? 	漢字を書ける？	\N		\N	vmod	\N	\N	\N	0	1
365	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
366	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
367	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
368	CLEARED	--------	null	--------	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
369	Cuando tienes hambre, no puedes pensar.	お腹が減っているときは考えることができない．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
370	Si vives en el extranjero, debes aprender las costumbres del país.	外国に住むのなら，その国の習慣を学ばなければいけない．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
371	El AVE te lleva a Sevilla en dos horas y media.	AVE［スペインの新幹線］ならセビーリャまで2時間半で着けます．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
372	CLEARED	--------	null	--------	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
373	En nuestro país cuando entramos en casa, nos quitamos los zapatos.	日本［わが国］では家に入るとき靴を脱ぎます．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
374	Antes respetábamos más a los ancianos.	以前はもっとお年寄りを敬っていました．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
375	CLEARED	--------	null	--------	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
376	CLEARED	--------	null	--------	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
377	CLEARED	--------	null	--------	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
378	En esta empresa a uno le pagan bien si trabaja mucho.	この会社では，たくさん働けば良い給料がもらえる．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
379	Cuando una es madre, lo sacrifica todo por los hijos.	母親になると子どものためにすべてを犠牲にする．	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
380	Dudo que John hable bien español.	ジョンがスペイン語をうまく話せるとは思えない．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
381	No estoy segura de que los bancos abran los sábados por la tarde.	土曜の午後に銀行が開いているかどうか確信がない．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
382	Es imposible que terminemos este proyecto en sólo una semana.	私たちがこのプロジェクトを一週間だけで終わらせるのは不可能だ．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
383	Puede que el petróleo suba mucho esta semana.	今週石油（価格）が大きく上がるかもしれない．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
384	¿A qué hora quieres que te llame mañana?	明日何時に電話してほしい？	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
385	Espero que nos contesten pronto.	彼ら／彼女ら／あなたがたがすぐに私たちに返事をくれると期待しています．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
386	Es necesario que entreguéis el informe antes del fin de semana.	君たちが週末までに報告書を提出することが必要だ．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
387	El jefe me ha dicho que no use el teléfono para hablar con los amigos.	上司は私に，友人と話すのにその電話を使わないようにと言った．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
388	Eduardo siempre me pide que le deje los apuntes.	エドゥアルドはいつも私にノートを貸してほしいと頼む．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
389	Mi padre no me permite que llegue a casa después de las diez.	父は私が１０時以降に帰宅するのを許さない．	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
390	Me alegro de que me digas eso.	君がそれを私に言ってくれてうれしい．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
391	Siento mucho que no vengas a la fiesta.	君がパーティーに来ないのはとても残念だ．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
392	Me temo que hoy haya mucho tráfico en la autopista.	今日は高速道路の交通量が多いのではないかと不安だ．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
393	Es una lástima que no puedas quedarte más tiempo.	君がもういられないのは残念だ．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
394	¿Te importa que baje un poco el volumen de la televisión?—No, no, claro.	テレビのボリュームをちょっと下げてもいいかな？　－　かまわないよ，もちろん．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
395	Es bueno que ellos se conozcan.	彼らが知り合いになるのはよいことだ．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
396	Será mejor que vayamos en avión.	私たちは飛行機で行ったほうがよさそうだ．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
397	Es extraño que nadie hable de ese asunto.	誰もその件について話をしないなんておかしい．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
398	Es natural que se quejen de ti.	彼ら／彼女らが君に不満なのも当然だ．	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
399	No creo que Eduardo haya viajado antes por el Caribe.	エドゥアルドがカリブ海を旅行したことがあるとは思えない．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
400	Es probable que María no se haya dado cuenta de eso.	マリアがそれに気づいていなかったというのはありうることだ．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
401	Puede que les haya tocado el premio gordo.	彼ら／彼女らは一等賞が当たったのかもしれない．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
402	Me alegro de que hayas venido.	君が来てくれてうれしい．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
403	Os agradezco que me hayáis apoyado en la reunión.	会議で君たちが私を支持してくれたことに感謝するよ．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
404	Siento que hayas tenido que esperarnos tanto tiempo.	君がこんなに長時間待たなくてはならなかったのは遺憾だ．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
405	Es lógico que no hayan aceptado tu invitación.	彼ら／彼女らが君の招待を受けなかったのは当然だ．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
406	Es extraño que se hayan marchado sin avisarnos.	彼ら／彼女らが私たちに知らせずに帰ってしまったとは奇妙だ．	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
407	No creí que pudiera conseguir el visado en tan poco tiempo.	こんな短時間でビザが取れるとは思わなかった．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
408	Cuando me lo preguntaron yo no estaba segura de que pudiéramos ir.	彼ら／彼女ら／あなたがたに聞かれたときには，私たちが行けるかどうか私には自信がなかった．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
409	Esperábamos que te casaras con Victoria.	私たちはお前がビクトリアと結婚することを期待していた．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
410	Tenía la esperanza de que el proyecto se terminara en un par de años.	彼／彼女／私にはそのプロジェクトが数年で終わるだろうという期待があった．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
411	El oculista nos recomendó que descansáramos un poco cada hora.	眼科医は私たちに１時間ごとに少しずつ休憩をとるようにと勧めた．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
412	¿No te dije que volvieras a hablar con ella?	もう一度彼女と話をするように言わなかったっけ？	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
413	Fue una alegría que viniera tanta gente a mi boda.	私の結婚式にあんなにたくさんの人が来てくれたのはうれしかった．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
414	Me sorprendió que el profesor se comportara de esa manera.	先生がそんなふうにふるまうなんて驚いた．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
415	Hace cincuenta años no era raro que los trenes llegasen con retraso.	５０年前には電車が遅れて来るのは珍しいことではなかった．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
416	Al abuelo le gustaba que le acompañáramos a pasear.	祖父は私たちが散歩についていくことを好んでいた．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
417	No me extraña que rechazaran tu propuesta.	彼ら／彼女らが君の提案を拒否したことは驚くにあたらない．	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
418	¿Hay alguien que haya estado en Quito?	キトに行ったことがある人はいますか？	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
419	Estamos buscando una casa que esté cerca de la estación.	私たちは駅の近くにある家を探している．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
420	No habrá nadie que se oponga a tu propuesta.	君の提案に反対する人は誰もいないだろう．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
421	Te llamaré a las seis para que me digas si puedes venir.	６時に電話をするから，来られるかどうか教えてくれ．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
422	Pedro cerró las ventanas para que no entrasen bichos.	ペドロは虫が入ってこないように窓を閉めた．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
423	En caso de que llueva, aplazaremos el viaje hasta el próximo fin de semana.	雨が降った場合は，旅行は次の週末に延期します．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
424	Te paso los apuntes con tal que me los devuelvas mañana.	明日返してくれるならノートを貸してあげるよ．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
456	Sentémonos aquí, que es más cómodo.	ここに座ろう，こっちのほうが快適だから．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
425	Le enviaremos el paquete por avión a no ser que resulte demasiado costoso.	費用がかかりすぎることがないように，航空便で彼／彼女／あなたに小包を送ります．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
426	En cuanto sepa algo de él, te avisaré.	彼のことで何かわかったらすぐに君に知らせるよ．	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
427	¿Por qué no te alojas en mi casa mientras estés de vacaciones?	休暇中は私の家に泊まったらどうだい？	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
428	Aunque llueve, saldremos.	雨が降る(降っている) のだが出かけるつもりだ．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
429	Aunque llueva, saldremos.	雨が降っても（降っていても）出かけるつもりだ．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
430	Aunque es japonés, no le gusta el pescado crudo.	彼は日本人なのだが，刺身がきらいだ．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
431	Aunque sea japonés, no le gusta el pescado crudo.	(断言をやわらげて) 彼はなるほど日本人かもしれないが，刺身がきらいだ．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
432	Quizá {viene / venga} más tarde.	おそらく彼／彼女は遅れて来るだろう．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
433	Tal vez {llueve / llueva} mañana.	たぶん明日は雨が降るだろう．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
434	Si hace buen tiempo mañana, te llevaré al zoo.	明日天気がよければ，動物園に連れて行ってあげるよ．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
435	Si papá vuelve pronto, cenaremos juntos.	父さんが早く帰ってきたら，一緒に夕食を食べよう．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
436	Si hiciera buen tiempo mañana, te llevaría al zoo.	明日がいい天気になるんだったら，動物園に連れて行ってあげるんだけどね．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
437	Si papá volviera pronto hoy, cenaríamos juntos.	父さんが今日早く帰ってくるんだったら，一緒に夕食を食べるんだけど．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
438	Si hubiera hecho buen tiempo ayer, te habría llevado al zoo.	昨日がいい天気だったら，動物園に連れて行ってあげたんだけど．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
439	Si papá hubiera vuelto pronto anoche, habríamos cenado juntos.	父さんが昨夜早く帰ってきていたら，一緒に夕食を食べたんだけど．	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
440	¡Que lo pases bien!	楽しんでね！／（別れ際に）元気でね！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
441	¡Que tengáis buen viaje!	よい旅を！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
442	¡Que te mejores!	（病気などが）よくなりますように！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
443	¡Ojalá no llueva mañana!	明日雨が降りませんように！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
444	¡Ojalá todavía estén en casa!	彼ら／彼女らがまだ家にいますように！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
445	¡Ojalá no se hayan marchado!	彼ら／彼女らがまだ帰ってしまっていませんように！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
446	¡Ojalá estuvieran mis padres aquí!	両親がここにいたらなあ！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
447	¡Ojalá te hubiera conocido antes!	君ともっと早くに知り合っていたら！	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
448	Corre, corre, que se va el autobús.	走れ，走れ，バスが行ってしまうぞ．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
449	Ve a ver quién es.	（来訪者などがあったときに）誰だか見に行ってくれ．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
450	Cerrad (Cerrar) la puerta.	ドアを閉めろ．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
451	No comas tan aprisa y mastica bien.	そんなに急いで食べないで，よく噛みなさい．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
452	Sigan todo recto.	（道案内などで）まっすぐに行ってください．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
453	Chicos, no saquéis fotos en el museo, ¿vale?	みんな，博物館で写真を撮ってはいけないよ，わかったね？	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
454	Siéntense, por favor.	どうぞおかけください．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
455	No os acerquéis más al fuego.	それ以上火に近づくな．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
658	Voy a tomar un caramelo. 	飴を食べよう。	予定を言う		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
458	¿Se puede? — Sí, pase, pase.	（入って）よろしいですか？　－　ええ，どうぞお入りください．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
459	Mira, te voy a decir una cosa. 	ねえ，ちょっと話があるんだけど． (usted に対しては Mire, le . . . )	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
460	No hablemos más de eso.	その話はもうよそう（話さないようにしよう）．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
461	¿Oiga?— Sí, dígame.	（電話で）もしもし．　－　はい．	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
462	¿Han estado alguna vez en Venezuela? — No, no hemos estado nunca allí.	（あなたがたは）ベネズエラに行ったことはありますか？　－　いえ，一度もありません．	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
465	Este siglo ha habido muchas guerras.	今世紀には多くの戦争があった．	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
466	Las clases son aburridas. 	その授業は退屈だ．	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
467	Las clases han aburrido a los alumnos.　	その授業は生徒たちを退屈させた．	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
468	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
469	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
470	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
471	¿Ha estado usted alguna vez en Barcelona?	いままでバルセロナへは行かれたことがありますか？	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
473	¿Habéis visto a Víctor? — No, no lo hemos visto.	ビクトルに会った？ — 会わなかったよ．	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]	\N	\N	\N
474	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]	\N	\N	1
477	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[1]	\N	\N	\N
478	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[2]	\N	\N	\N
480	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[8]/gmod:instance[1]	\N	\N	\N
481	CLEARED	--------	null	--------	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[8]/gmod:instance[2]	\N	\N	\N
484	Estudié español cuatro años en la universidad.	私は大学で４年間スペイン語を勉強した．	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
488	¿Pudo ver al ministro ayer? — Sí, por fin pude hablar con él.	昨日大臣に会えたのですか？　－　ええ，とうとう彼と話すことができました．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
505	Encantado de conocerle.	あなたとお知り合いになれてうれしいです．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
506	Pedro vino corriendo.	ペドロは走ってやって来た．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
514	Dudo que John hable bien español.	ジョンがスペイン語をうまく話せるとは思えない．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
519	Espero que nos contesten pronto.	彼ら／彼女ら／あなたがたがすぐに私たちに返事をくれると期待しています．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
520	Es necesario que entreguéis el informe antes del fin de semana.	君たちが週末までに報告書を提出することが必要だ．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	\N
522	Eduardo siempre me pide que le deje los apuntes.	エドゥアルドはいつも私にノートを貸してほしいと頼む．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
527	Es una lástima que no puedas quedarte más tiempo.	君がもういられないのは残念だ．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
532	Es natural que se quejen de ti.	彼ら／彼女らが君に不満なのも当然だ．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
533	No creo que Eduardo haya viajado antes por el Caribe.	エドゥアルドがカリブ海を旅行したことがあるとは思えない．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
534	Es probable que María no se haya dado cuenta de eso.	マリアがそれに気づいていなかったというのはありうることだ．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
536	Me alegro de que hayas venido.	君が来てくれてうれしい．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
537	Os agradezco que me hayáis apoyado en la reunión.	会議で君たちが私を支持してくれたことに感謝するよ．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
539	Es lógico que no hayan aceptado tu invitación.	彼ら／彼女らが君の招待を受けなかったのは当然だ．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]	\N	\N	\N
540	Es extraño que se hayan marchado sin avisarnos.	彼ら／彼女らが私たちに知らせずに帰ってしまったとは奇妙だ．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[5]	\N	\N	\N
543	Esperábamos que te casaras con Victoria.	私たちはお前がビクトリアと結婚することを期待していた．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
659	¿Quieres uno?	お一ついかが？	希望をたずねる		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
544	Tenía la esperanza de que el proyecto se terminara en un par de años.	彼／彼女／私にはそのプロジェクトが数年で終わるだろうという期待があった．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
547	Fue una alegría que viniera tanta gente a mi boda.	私の結婚式にあんなにたくさんの人が来てくれたのはうれしかった．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	\N
548	Me sorprendió que el profesor se comportara de esa manera.	先生がそんなふうにふるまうなんて驚いた．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	1
551	No me extraña que rechazaran tu propuesta.	彼ら／彼女らが君の提案を拒否したことは驚くにあたらない．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[5]	\N	\N	\N
554	No habrá nadie que se oponga a tu propuesta.	君の提案に反対する人は誰もいないだろう．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
529	Es bueno que ellos se conozcan.	彼らが知り合いになるのはよいことだ．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
558	Te paso los apuntes con tal que me los devuelvas mañana.	明日返してくれるならノートを貸してあげるよ．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	1
563	Aunque llueva, saldremos.	雨が降っても（降っていても）出かけるつもりだ．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
569	Si papá vuelve pronto, cenaremos juntos.	父さんが早く帰ってきたら，一緒に夕食を食べよう．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
571	Si papá volviera pronto hoy, cenaríamos juntos.	父さんが今日早く帰ってくるんだったら，一緒に夕食を食べるんだけど．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]	\N	\N	\N
574	¡Que lo pases bien!	楽しんでね！／（別れ際に）元気でね！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[1]	\N	\N	\N
576	¡Que te mejores!	（病気などが）よくなりますように！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[3]	\N	\N	\N
577	¡Ojalá no llueva mañana!	明日雨が降りませんように！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[4]	\N	\N	\N
579	¡Ojalá no se hayan marchado!	彼ら／彼女らがまだ帰ってしまっていませんように！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[6]	\N	\N	\N
580	¡Ojalá estuvieran mis padres aquí!	両親がここにいたらなあ！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[7]/gmod:instance[1]	\N	\N	\N
581	¡Ojalá te hubiera conocido antes!	君ともっと早くに知り合っていたら！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[7]/gmod:instance[2]	\N	\N	\N
583	Ve a ver quién es.	（来訪者などがあったときに）誰だか見に行ってくれ．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
589	No os acerquéis más al fuego.	それ以上火に近づくな．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
590	Sentémonos aquí, que es más cómodo.	ここに座ろう，こっちのほうが快適だから．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]	\N	\N	\N
594	No hablemos más de eso.	その話はもうよそう（話さないようにしよう）．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[3]	\N	\N	\N
595	¿Oiga?— Sí, dígame.	（電話で）もしもし．　－　はい．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[4]	\N	\N	1
596	Hola, María.	やあ、マリア。	挨拶をする		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
597	¿Qué tal?	元気?	状況(状態)をたずねる		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
598	Bien, ¿y tú Juan?	元気よ。あなたは？フアン。	状況(状態)を述べる、状況(状態)をたずねる		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
599	Muy bien, gracias.	とても元気だよ、ありがとう。	状況(状態)を述べる、感謝する		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
600	¿A dónde vas?	どこへ行くの？	情報を求める（存在と場所）		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
601	Voy a la biblioteca.	図書館に行くんだ。	行動を言う		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
602	¿Para qué?	何しに?	目的をたずねる		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
603	Tengo que prepararme para el examen de mañana.	明日の試験の準備をしなきゃならないんだ。	義務を確認する/肯定する		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
604	Ah, ¿sí?	ああ、そう。	あいづち		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
605	Suerte.	がんばってね(幸運を祈ります)。	励ます		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
606	Gracias.	ありがとう。	感謝する		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
607	Hasta luego.	じゃあね。	さよならを言う		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
608	Hasta luego.	じゃあね。	さよならを言う		\N	dmod	es01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
609	¿Cómo vas con el trabajo escrito?	課題はどんな具合?	状況(状態)をたずねる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
610	Más o menos...	まあまあといったところです…	状況(状態)を述べる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
611	Tengo un problema.	一つ困った事があります。	状況(状態)を述べる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
612	¿Qué pasa?	どうしました？	状況(状態)をたずねる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
613	Es que el libro recomendado no está en la biblioteca...	推薦された本が図書館にないんです。	状況(状態)を述べる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
614	Aquí lo tengo.	ここにありますよ。	状況(状態)を述べる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
615	Si quieres, te lo dejo.	よかったら貸しますよ。	何かを貸す		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
616	Muchas gracias.	どうもありがとうございます。	感謝する		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
617	De nada.	どういたしまして。	どういたしましてと言う		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
618	¿Cuándo se lo devuelvo?	いつお返ししたらいいでしょうか？	情報を求める（時間）		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
619	No hay prisa.	急ぐことないですよ。	状況を述べる		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
620	Muchísimas gracias, profesor.	本当にどうもありがとうございます、先生。	感謝する		\N	dmod	es02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
621	Disculpe.	すみません。	注意をひく		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
622	¿Sí?	はい。	呼びかけにこたえる		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
623	¿Dónde está el despacho del profesor Sánchez?	サンチェス先生の研究室はどこでしょう？	情報を求める（存在と場所）		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
624	Está en el segundo piso del edificio C.	 C棟の3階です。	場所を述べる		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
625	¿Cuál es el edificio C?	 C棟というのはどれですか？	情報を求める（存在と場所）		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
626	Es el de enfrente.	正面の棟です。	場所を述べる		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
627	¿Estará el profesor en su despacho?	先生は研究室にいらっしゃるでしょうか？	状況(状態)をたずねる		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
628	Creo que sí.	そう思いますよ。	意見を言う		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
629	Gracias	ありがとうございました。	感謝する		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
630	De nada.	どういたしまして。	どういたしましてと言う		\N	dmod	es03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
631	Perdona.	すみません	注意をひく		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
632	¿Sabes dónde está el aula 8?	8号教室はどこだか分かりますか?	情報を求める（存在と場所）		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
633	¿Vas a la clase del profesor Sánchez?	サンチェス先生の授業に行くんですか?	行動をたずねる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
634	Sí.	そうです。	質問に肯定/否定でこたえる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
635	¿Tú también?	あなたも？	相手もそうかたずねる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
636	Sí.	ええ。	質問に肯定/否定でこたえる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
637	Vamos juntos.	一緒に行きましょう。	誘う		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
638	Me llamo María.	私はマリアです。	自己紹介する		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
639	Mucho gusto.	はじめまして。	自己紹介する		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
640	Soy Antonio.	僕はアントニオ。	自己紹介する		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
641	Encantado.	どうぞよろしく。	自己紹介する		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
642	¿Eres de aquí?	出身はこちらなんですか？	情報を求める（属性）		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
643	No.	いいえ。	質問に肯定/否定でこたえる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
644	Soy de Oviedo.	私はオビエド出身です。	属性を述べる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
645	Yo también.	私もですよ。	自分もそうだと述べる		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
646	¡Qué casualidad!	奇遇だなあ!	感嘆する		\N	dmod	es04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
647	¡Carlos, llegas media hora tarde!	カルロス、30分遅刻よ!	行動を述べる		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
648	Lo siento.	ごめん。	あやまる		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
649	¿Qué te ha pasado?	どうしたの？	状況(状態)をたずねる		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
650	Hay un atasco terrible.	ひどい渋滞なんだ。	状況(状態)を述べる		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
651	Debes salir más temprano para evitar las horas punta.	ラッシュアワーを避けるにはもっと早く出なきゃ。	義務を確認する/肯定する		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
652	Tienes razón.	君の言う通りだ。	相手が述べたことを肯定する		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
653	¿Me perdonas?	許してよ。	あやまる		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
654	No sé...	さあねえ…	知っている/知らないと言う		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
656	Bueno, vale.	そうねえ、いいわ。	承諾する		\N	dmod	es05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
661	Aquí tienes.	はいどうぞ。	何かをあげる		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
662	Gracias.	ありがとう。	感謝する		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
663	De nada.	どういたしまして。	どういたしましてと言う		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
664	¿A qué sabe?	何の味？	情報を求める（属性）		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
665	A naranja.	オレンジ味。	属性を述べる		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
666	Está muy bueno.	とてもおいしいね。	属性を述べる		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
667	Sí. 	ええ。	相手が述べたことを肯定する		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
668	A mí también me gusta este sabor.	私もこの味が好きなの。	嗜好について述べる（もの）		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
669	¡Y no tiene azúcar!	しかもシュガーレスだよ！	属性を述べる		\N	dmod	es06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
670	¡Fin de semana!	週末だ！	感嘆する		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
671	¡Por fin!	ついに！	感嘆する		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
672	¿Tienes algún plan?	何か予定はあるの？	予定を言う		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
673	Sí.	うん。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
674	Voy a ir a Madrid a ver a mis padres.	両親に会いにマドリードに行くつもりなんだ。	予定を言う		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
675	¡Ah, muy bien!	ああ、それはいいわね！	感嘆する		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
676	¿Y tú, qué vas a hacer?	で、君は何をする予定なの?	予定を言う		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
677	Yo voy a ir de excursión a Cáceres.	私はカセレスにハイキングに行くつもりよ。	予定を言う		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
678	¡Ah, buena idea!	へえ、いいね！	感嘆する		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
679	Que lo pases bien.	楽しんできてね。	相手のために祈願する		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
680	Igualmente.	君もね。	相手のために祈願する		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
681	Nos vemos el lunes.	月曜日に会おう。	さよならを言う		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
682	Adiós, hasta el lunes.	さよなら、月曜日にね。	さよならを言う		\N	dmod	es07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
683	¡Hola!	こんにちは	あいさつする		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
684	Quería un billete para Barcelona para el día de hoy.	今日のバルセロナまでの切符を買いたいのですが。	希望を述べる		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
685	¿De ida y vuelta?	往復ですか？	情報を求める		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
686	Sí.	はい。	肯定する		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
687	¿Lo quiere de fumadores o de no fumadores?	喫煙席と禁煙席のどちらがよろしいですか？	情報を求める		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
688	De fumadores.	喫煙席でお願いします。			\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
689	¿Cuánto cuesta el billete?	その切符はおいくらですか？	経験についてたずねる		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
690	Treinta.	30ユーロです。			\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
691	Aquí tiene.	はい、どうぞ。	何かをあげる		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
692	Muy bien.	はい。			\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
693	Gracias.	ありがとう。	感謝する		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
694	De nada.	どういたしまして	どういたしましてと言う		\N	dmod	es08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
695	Hola, Juan.	こんにちは、フアン。	あいさつをする		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
696	Hola.	こんにちは。	あいさつをする		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
697	¿Qué tal el veraneo?	夏休みはどうでしたか？	情報をたずねる（属性）		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
698	Estás muy moreno.	とても日焼けしましたね。	状態について述べる		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
699	Bueno, es que estuve un mes en Niza.	ええ、実は一ヶ月ニースにいっていました。			\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
700	¡Qué envidia!	うらやましいわ。			\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
701	¿Y has estado en Francia en otras ocasiones?	君は前にフランスにいったことはありますか？	情報をもとめる（経験）		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
702	Sí, sí.	ええ。			\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
703	Ya he ido... cinco veces.	5回行ったことがあります。	経験について述べる		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
704	¿Cinco?	5回？			\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
705	¿Y para qué?	何のために？	理由をたずねる		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
706	Para visitar a una hermana que trabaja en París.	パリで働いている姉を訪ねるためです。	理由を述べる		\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
707	Ah, ¡qué bien!	へえ。いいですね。			\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
708	Pues sí.	そうなんです。			\N	dmod	es09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
709	Hola, Juan.	こんにちは、フアン。	あいさつをする		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
710	Hola, María.	こんにちは、マリア。	あいさつをする		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
711	¿Qué tal?	元気？	あいさつする		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
712	Muy bien.	元気よ。	状態について述べる		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
713	Hoy es el último día del semestre, ¿no?	今日は今学期最後の日だよね？			\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
714	Sí.	ええ。			\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
715	¿Qué vas a hacer este verano?	この夏は何をするつもり？	予定を尋ねる		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
716	Voy a viajar por Perú con una amiga.	友達とペルーを旅行するつもりなんだ。	予定をいう		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
717	¡Fantástico!	素晴らしいわ。			\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
718	¿Y tú, María?	マリア、君は？			\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
719	Pienso pasar dos semanas en Málaga.	マラガで二週間過ごすつもりよ。	予定をいう		\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
720	¡Qué bien!	いいね。			\N	dmod	es10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
721	Buenos días.	おはようございます。	挨拶をする		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
722	Buenos días.	おはようございます。	挨拶をする		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
723	¿Qué le pasa?	どうしましたか？	どうしているかをたずねる		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
724	Toso mucho y no tengo apetito.	すごく咳が出て食欲がありません。			\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
725	Ah...	ああ	状態についてのべる		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
726	Está muy resfriado.	ひどい風邪ですね。			\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
727	Y ¿tiene fiebre?	で、熱はありますか？	状態についてたずねる		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
728	Uf....	うっ			\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
729	Sí, sí.	ええ。			\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
730	Por lo menos tengo 38 grados de fiebre.	38度あります。	状態についてたずねる		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
731	Tome esta medicina, le curará.	この薬を飲んでください。よくなります。	指示する		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
732	¿Con qué frecuencia tengo que tomarla?	どれくらい頻繁に飲めばよいでしょうか？	情報をもとめる（程度）		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
733	Tres veces al día, después de las comidas.	一日に三回で、食後です。	状態についてのべる		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
734	Vale.	わかりました。	了解する		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
735	Gracias.	ありがとうございました。	感謝する		\N	dmod	es11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
736	¡Hola, Antonio!	こんにちは、アントニオ。	挨拶をする		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
737	¿Cómo estás?	元気？	状態についてのべる		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
738	¡Hola, María!	こんにちは、マリア。	挨拶をする		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
739	Estoy bien gracias, ¿y tú?	うん元気だよ。ありがとう。君は？	状態についてのべる		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
740	Bien, gracias.	元気よ。ありがとう。			\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
741	¿Sabes qué día llega Juana?	フアナが何曜日に到着するか知っている？	時間を求める（情報）		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
742	Sí, llega el domingo.	うん。日曜日だよ。	時間についてのべる		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
743	¿Y a qué hora llega?	で、何時に着くの？	情報をもとめる（時間）		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
744	Llega a las 9.00 de la mañana.	朝の9時に着くよ。	時間についてのべる		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
745	Pero ... ¿por qué?	でも…何で？	理由をたずねる		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
746	Voy a ir a buscarla al aeropuerto en coche.	空港まで車で彼女を迎えにいくつもりなの。	予定をいう		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
747	Ah... ¿Puedo ir contigo?	あぁ。一緒に行ってもいい？	許可をもとめる		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
748	¡Claro!	もちろん。			\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
749	Gracias	ありがとう	感謝する		\N	dmod	es12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
750	¡Hola! buenas tardes.	こんにちは。	あいさつをする		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
751	¡Hola, María!	こんにちは、マリア。	挨拶をする		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
752	¿Cómo puedo contactar con usted mañana?	明日はどうすれば連絡がとれるでしょうか？	何でどのようにするかを言う		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
753	Tengo una pregunta.	一つ質問があるのです。			\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
754	Ah... llámame a casa.	あー、家に電話してください。	指示する		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
755	¿Cuál es su número de teléfono?	電話番号は何番ですか？	情報をもとめる（数字）		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
756	204-69-56	204-69-56			\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
757	¿Cómo?	え？	聞き直す		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
758	Más despacio, por favor.	もっとゆっくりお願いします。	依頼する		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
759	204-69-56	204-69-56			\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
760	Vale.	わかりました。	了解する		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
761	Gracias.	ありがとうございます。	感謝する		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
762	De nada.	どういたしまして。	どういたしましてという		\N	dmod	es13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
763	¿Qué pasa?	どうしたの？	状況(状態)をたずねる		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
764	¿Tienes algún problema?	何か問題でも?	状況(状態)をたずねる		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
765	¿Sabes cómo funciona esta fotocopiadora?	このコピー機どうやって動くか知ってる?	何でどのようにするかを言う		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
766	A ver...	どれどれ…			\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
767	Me parece que no funciona.	動かないみたいだね。	意見を言う		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
768	¡Con la prisa que tengo!	すごく急いでるのに！	感嘆する(強調する)		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
769	En la biblioteca hay otra fotocopiadora.	図書館にもう一台コピー機があるよ。	情報を求める（存在と場所）		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
770	Menos mal.	ああよかった。	状況(状態)を述べる		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
771	¿Sabes cómo se sacan fotocopias ampliadas?	拡大コピーってどうやってとるか分かる?	手段についてたずねる		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
772	Sí.	うん。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
773	Es muy fácil.	とても簡単だよ。	情報を求める（属性）		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
774	¿Te importa acompañarme y ayudarme?	一緒に来て手伝ってくれないかな？	依頼する		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
775	Claro que no.	もちろん。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
776	Muchas gracias.	どうもありがとう。	感謝する		\N	dmod	es14.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
777	Este fin de semana Elena y yo vamos a viajar por Galicia.	今週末エレナと私でガリシアを旅行する予定なの。	予定を言う		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
778	¿Quieres venir?	来ない？	招待する		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
779	Sí, con mucho gusto.	うん、喜んで。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
780	Pensamos alquilar un coche.	レンタカーを借りるつもりよ。	予定を言う		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
781	Ah, buena idea.	へえ、いいね。	相手が述べたことを肯定する		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
782	¿Sabes conducir?	あなた運転できる?	技能と能力についてたずねる		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
783	Claro.	もちろん。	肯定する		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
784	Entonces cuando yo me canse, te pones tú al volante, ¿vale?	じゃあ、私が疲れたらあなたが運転してね。	依頼する		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
785	De acuerdo.	分かった。	承諾(了解)する		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
786	Muy bien.	よかった。	承諾(了解)する		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
787	Este viaje me hace mucha ilusión.	今回の旅行、すごく楽しみだなあ。			\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
788	A mí también.	僕もだよ。	自分もそうだと述べる		\N	dmod	es15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
789	Perdone, por favor.	すいません。	注意をひく		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
790	¿Hay algún hotel por aquí cerca?	この近くにホテルはありますか？	情報をもとめる（存在と場所）		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
791	Sí, hay uno en la Plaza Mayor.	ええ、マヨール広場に一軒あります。	存在についてのべる		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
792	Tome la primera a la derecha y luego siga todo recto.	最初の角を右にまがって後はまっすぐ行きます。	指示する		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
793	¿Y cómo se llama el hotel?	で、何という名前のホテルですか？	特徴についてたずねる		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
794	Carlos V.	カルロス５世といいます。			\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
795	Ah... ¿Y dónde está la Librería Fuentetaja?	あぁ、あとフエンテタハ書店はどこにありますか？	情報を求める（存在と場所）		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
796	Lo siento.	すいません。	あやまる		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
797	Eso no lo sé.	それは知りません。	知らないという		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
798	¿Y hay algún banco por aquí?	それからこの近くに銀行はありますか？	情報をもとめる（存在と場所）		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
799	Sí, hay uno al lado del hotel.	ええ、そのホテルのそばにあります。	存在についてのべる		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
800	Muchas gracias.	どうもありがとう。	感謝する		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
801	De nada.	どういたしまして。	どういたしましてという		\N	dmod	es16.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
802	Estás muy alegre ¿no?	うれしそうですね。	状態についてのべる		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
803	Sí, sí.	ええ。			\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
804	Es que acabo de comprar un coche.	実は車を買ったばかりなのです。	理由をのべる		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
805	¡Qué bien!	いいですね。			\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
806	¿Cómo es el coche?	どんな車ですか？	情報をもとめる（属性）		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
807	Bueno, es compacto, es un Mercedes.	ええ、コンパクトですよ。メルセデスです。	属性についてのべる		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
808	¿De qué color es?	何色ですか？	情報を求める（属性）		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
809	Gris metalizado.	メタリックグレーです。	属性についてのべる		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
810	Ah... ¿Como el del profesor González? 	あぁ。ゴンサレス先生の車のような感じですか？	情報をもとめる（属性）		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
811	Sí, sí.	はい。そうです。			\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
812	¿Cuánto te ha costado?	おいくらだったのですか？	情報をもとめる（金額）		\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
813	Eso... es un secreto.	それは…、秘密です。			\N	dmod	es17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
814	Voy a probarme esta falda.	このスカートを試着してみるね。	予定を言う		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
815	Vale.	分かった。	承諾する		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
816	¿Qué te parece?	どう思う?	相手の意見をたずねる		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
817	Creo que te queda mejor la otra.	もう一つの方が君に似合うと思うよ。	意見を言う		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
818	¿No te gusta el color?	色が気に入らない?	嗜好について述べる（もの）		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
819	No mucho.	あんまり。	嗜好について述べる（もの）		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
820	¿Y la talla?	じゃあ丈は?	相手の意見をたずねる		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
821	Creo que para ti es un poco corta.	君にはちょっと短いと思うよ。	意見を言う		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
822	Vale.	分かった。	承諾する		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
823	Me quedo con la otra.	もう一つの方にするわ。	行動を述べる		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
824	Sí, es mejor.	うん、その方がいいよ。	意見を言う		\N	dmod	es18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
825	Hola, Pablo.	こんにちは、パブロ。	挨拶をする		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
826	¿Qué estás leyendo?	何を読んでいるの?	行動をたずねる		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
827	"Cien años de soledad" de García Márquez.	ガルシア・マルケスの『百年の孤独』。	質問にこたえる		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
828	¿Te gustan las novelas?	小説は好き?	嗜好について述べる（もの）		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
829	Sí.	うん。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
830	Me gustan mucho las novelas.	小説大好きなんだ。	嗜好について述べる（もの）		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
831	A mí no me gustan mucho.	私はあんまり好きじゃない。	嗜好について述べる（もの）		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
832	¿Ah, sí?	あ、そうなの？	あいづち		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
833	Es que a mí no me gusta la ficción.	フィクションって好きじゃないのよね。	嗜好について述べる（もの）		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
834	¿Entonces qué clase de libros te gusta?	それなら、どういう種類の本が好きなの?	嗜好について述べる（もの）		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
835	Reportajes, biografías, estudios...	ルポルタージュ、伝記、研究書…	例をあげて述べる		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
836	A mí no me interesa mucho ese tipo de libros.	僕はそういうタイプの本にはあまり興味ないなあ。	嗜好について述べる（もの）		\N	dmod	es19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
837	¿Qué haces los fines de semana?	週末はいつも何してるの?	行動をたずねる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
838	Normalmente salgo con mis amigos.	たいてい友達と出かけるわ。	行動を述べる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
839	¿Y vais al cine?	それで映画に行くの？	行動をたずねる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
840	Sí.	ええ。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
841	Me gusta mucho ir al cine.	映画に行くの大好きなの。	嗜好について述べる（行動）		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
842	¿Y tú, qué haces?	で、あなたは何してるの?	行動をたずねる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
843	Yo habitualmente voy al campo.	僕はいつも郊外に行くよ。	場所を述べる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
844	¿Ah, sí?	ああ、そうなの？	あいづち		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
845	¿Te gusta la naturaleza?	自然が好きなの？	嗜好について述べる（もの）		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
846	Sí.	うん。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
847	Me encanta.	大好き。	嗜好について述べる（もの）		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
848	A mí también me gusta ir al campo.	私も田舎に行くの好きなんだ。	嗜好について述べる（行動）		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
849	¿Por qué no vamos juntos la próxima vez?	今度、一緒に行かない?	提案する		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
850	¡Buena idea!	いいわね。	相手が述べたことを肯定する		\N	dmod	es20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
851	Perdone.	すみません。	注意をひく		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
852	¿Cómo funciona esta fotocopiadora?	このコピー機はどうやって動くんですか?	何でどのようにするかを言う		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
853	Primero tiene que meter la moneda.	まず硬貨を入れなければなりません。	手順と順序について述べる		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
854	Sí.	はい。	あいづち		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
855	Luego ponga aquí el documento original.	次にここにオリジナルの文書を置いてください。	順序について述べる		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
856	Vale.	はい。	あいづち		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
857	Después pulse este botón.	次にこのボタンを押してください。	順序について述べる		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
858	Muy bien.	分かりました。	あいづち		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
859	¿Y para cambiar el tamaño del papel?	では紙の大きさを変えるには？	何でどのようにするかを言う		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
860	Puede elegirlo con este botón.	このボタンで選べます。	技能と能力について述べる		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
861	Muy bien.	分かりました。	了解する		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
862	Muchas gracias.	どうもありがとうございました。	感謝する		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
863	De nada.	どういたしまして。	どういたしましてと言う		\N	dmod	es21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
864	¿Dígame?	もしもし？	注意をひく		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
865	Hola, Luis.	こんにちは、ルイス。	挨拶をする		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
866	Soy Eva.	私エバ。	属性を述べる		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
867	Hombre, Eva.	ああ、エバ。	確認する		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
868	¿Cómo te va?	どうしてる？	どうしているかをたずねる		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
869	Últimamente estoy muy ocupado.	ここ最近すごく忙しいんだよ。	状況(状態)を述べる		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
870	José y yo estamos preocupados por ti porque no vienes a clase. 	あなたが授業に来ないからホセと私で心配してるのよ。	状況(状態)を述べる		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
871	Es que trabajo de profesor en una academia.	ある学校で先生をしててさ。	理由を述べる		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
872	¿Ah, sí? 	あ、そうなの？	あいづち		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
873	Y no tengo tiempo para ir a clase.	で、授業に行く時間がないんだよ。	状況(状態)を述べる(所有)		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
874	Ah, no lo sabía.	ああ、それは知らなかった。	知っている/知らないと言う		\N	dmod	es22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
875	¿Qué vamos a hacer el sábado que viene?	今度の土曜日何しようか？	予定を言う		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
876	Si hace buen tiempo, podemos ir al campo.	天気が良ければ郊外に行ってもいいわね。	ある条件での行動を言う		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
877	¡Buena idea!	いいねえ！	相手が述べたことを肯定する		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
878	Pero...	でも…	言いよどむ		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
879	¿Qué vamos a hacer si hace mal tiempo?	天気が悪かったらどうしよう？	ある条件での行動を言う		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
880	Pues podemos ver unas películas en mi casa.	その時は私の家で映画を何本か見てもいいし。	可能性を述べる		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
881	Muy bien.	そうだね。	承諾する		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
882	Entonces, si hace buen tiempo, quedamos en la estación a las nueve.	じゃあ、天気が良ければ9時に駅で会おう。	ある条件での行動を言う		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
883	Perfecto.	了解。	承諾する		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
884	Y si hace mal tiempo, ven a mi casa a las once.	もし天気が悪かったら11時に私の家に来て。	条件をつける		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
885	De acuerdo.	分かった。	承諾する		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
886	Pues hasta el sábado.	じゃあ土曜日に。	さよならを言う		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
887	Adiós.	じゃあね。	さよならを言う		\N	dmod	es23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
888	Buenos días.	おはようございます。	挨拶をする		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
889	¿Qué desea?	何になさいますか？	希望についてたずねる		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
890	¿Tienen ustedes jamón ibérico de bellota?	ハモン・イベリコ・デ・べジョータはありますか？	状態についてたずねる		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
891	Sí.	はい。	肯定する		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
892	Está a 21 euros el kilo.	キロあたり21ユーロです。	金額について述べる		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
893	¡Qué caro!	高いですね！	感嘆する		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
894	Quería algo menos caro.	それほど高くないものが欲しいのですが。	希望を述べる		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
895	Bueno, este otro también es muy bueno.	はい、こちらのものも大変よろしいですよ。	属性を述べる		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
896	Éste es más barato que el de bellota: está a 15 el kilo.	こちらのほうはデ・べジョータよりもお安くなっています。キロあたり15ユーロです。	比べて述べる（比較と最上級）		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
897	Entonces compraré éste.	じゃあ、こちらを買います。			\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
898	¿Cuántos gramos le pongo？	何グラムお出ししましょうか？	情報を求める(数量)		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
899	Medio kilo.	500グラムお願いします。			\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
900	¿Cuánto cuesta?	おいくらですか？	情報を求める(金額)		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
901	7 euros con cincuenta céntimos.	7ユーロ50センティモです。			\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
902	Aquí tiene.	はい、どうぞ。	何かをあげる		\N	dmod	es24.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
903	Perdone, profesor.	すみません、先生。	注意をひく		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
904	Dime.	何ですか?	呼びかけにこたえる		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
905	Tengo algunas dudas sobre la redacción.	レポートについて分からない点がいくつかあるんですが。	状況(状態)を述べる		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
906	¿Ah, sí?	ああ、そうですか。	あいづち		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
907	¿Podría ir a su despacho para hablar con usted?	先生の研究室にご相談に伺ってもよろしいでしょうか？	許可を求める		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
908	Sí, por supuesto.	ええ、もちろんです。	承諾(了解)する		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
909	¿Cuándo le conviene que vaya?	いつお伺いしたらよろしいでしょう？	時間についてたずねる		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
910	¿Qué te parece si nos vemos el viernes a mediodía?	金曜日のお昼に会うのはどうでしょう？	提案する		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
911	Muy bien.	大丈夫です。	承諾(了解)する		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
912	Entonces nos vemos el viernes.	では、金曜日に会いましょう。	さよならを言う		\N	dmod	es25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
913	Hola, Ana.	やあ、アナ。	挨拶をする		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
914	Hola, Miguel.	こんにちは、ミゲル。	挨拶をする		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
915	¿Qué tal la fiesta del sábado?	土曜日のパーティーはどうだった？	状況(状態)をたずねる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
916	Lo pasamos muy bien.	とても楽しかったよ。	状況(状態)を述べる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
917	Pero... ¿por qué no viniste?	でも…どうして来なかったの?	理由をたずねる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
918	La verdad, no me apeteció salir porque estaba enferma.	実は、調子が悪くて出かける気にならなかったんだ。	理由を述べる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
919	¿Ah, sí?	へえ、そうなの。	あいづち		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
920	¿Estabas resfriada?	風邪だったの?	状況(状態)をたずねる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
921	Sí, por desgracia.	うん、不幸にも。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
922	¿Y ya estás bien?	で、もう大丈夫なの?	状況(状態)をたずねる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
923	Más o menos.	何とか。	状況(状態)を述べる		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
924	Bueno, cuídate.	そう、お大事に。	お大事にと言う		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
925	Gracias.	ありがとう。	感謝する		\N	dmod	es26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
926	Ah, Isabel.	あ、イサベル。	注意をひく		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
927	Te estaba buscando.	探してたんだよ。	状況(状態)を述べる		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
928	Pareces nervioso.	いらいらしてるみたい。	状況(状態)を述べる		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
929	¿Qué te pasa?	どうしたの？	状況(状態)をたずねる		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
930	¿Puedes hacerme un favor?	一つお願いがあるんだ	依頼する		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
931	Sí.	うん。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
932	Dime.	何?	呼びかけにこたえる		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
933	Es que he perdido todos los apuntes de literatura.	実は、文学のノート全部なくしちゃったんだ。	理由を述べる		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
934	No me digas.	本当?	あいづち		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
935	¿Puedes dejarme tus apuntes para fotocopiarlos?	コピーするために君のノート貸してくれる?	依頼する		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
936	Cómo no.	もちろん。	承諾(了解)する		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
937	Muchísimas gracias.	本当にどうもありがとう。	感謝する		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
938	No hay de qué.	どういたしまして。	どういたしましてと言う		\N	dmod	es27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
939	Oye, Miguel.	ねえ、ミゲル。	注意をひく		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
940	¿Te gusta viajar?	旅行は好き?	嗜好について述べる（行動）		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
941	Sí, muchísimo.	うん、大好き。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
942	Quiero viajar por todo el mundo.	世界中を旅行したい。	希望を述べる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
943	¿Ah, sí?	ああ、そう。	あいづち		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
944	¿Y adónde te gustaría ir?	で、どこに行ってみたい?	希望を述べる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
945	Desde luego quiero ir a Asia .	もちろん、アジアに行きたいよ。	希望を述べる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
946	Pero Asia es muy grande.	でも、アジアはとても大きいでしょ。	属性を述べる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
947	¿Qué países quieres visitar en primer lugar? 	まずはどの国に行きたい?	希望を述べる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
948	Pues por ejemplo quiero ir a Japón, a Corea, a China...	そうねえ、例えば日本、韓国、中国に行きたいな。	例をあげて述べる		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
949	¿Te interesa la cultura de esos países?	それらの国の文化に興味があるの?	嗜好について述べる（もの）		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
950	Sí, me interesa mucho.	うん、とても興味がある。	嗜好について述べる（もの）		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
951	Pero están muy lejos, ¿no?	でも、すごく遠いでしょ?	情報を求める（存在と場所）		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
952	Eso no me importa.	それは構わないんだ。	構わないと言う		\N	dmod	es28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
953	Camarera, por favor.	ウェイトレスさん、すみません。	注意をひく		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
954	Sí.	はい。	呼びかけにこたえる		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
955	Dígame.	何でしょうか。	呼びかけにこたえる		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
956	El menú del día, por favor.	定食をお願いします。	依頼する		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
957	Lo siento pero ya se ha acabado.	申し訳ありませんが、もう終わってしまったんです。	あやまる		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
958	¡Con el hambre que tengo!	腹ぺこなんだけどなあ！	感嘆する(強調する)		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
959	Entonces...	それなら…	言いよどむ		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
960	Sólo nos quedan estos bocadillos.	こちらのボカディージョしか残ってないんです。	状況(状態)を述べる		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
961	Bueno...	じゃあ…	言いよどむ		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
962	Me arreglo con uno de ellos.	そのうちの一つで我慢するか。	妥協する		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
963	Le recomiendo éste de jamón y queso.	ハムとチーズ入りのこちらをお薦めします。	助言する		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
964	Está muy bueno.	とてもおいしいですよ。	状態を述べる		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
965	Vale.	よし。	承諾(了解)する		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
966	Deme ése.	それをください。	依頼する		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
967	De acuerdo.	かしこまりました。	承諾(了解)する		\N	dmod	es29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
968	Hola.	こんにちは。			\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
969	Hola.	こんにちは。			\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
970	Quisiera comprar la camisa del Real Madrid.	レアル・マドリッドのユニフォームが欲しいのですが。			\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
971	¿Casa o visitante?	ホーム用ですか？ビジター用ですか？	情報を求める(属性)		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
972	Casa.	ホーム用でお願いします。			\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
973	¿Cuál es su talla?	サイズはどれくらいですか？	情報をもとめる（数字）		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
974	Treinta y cinco.	35です。	属性を述べる		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
975	Pues, en esta talla la tenemos.	ええと、そのサイズでしたらございます。			\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
976	¿Puedo probármela?	試着してみてもよいですか？	許可をもとめる		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
977	Sí, por supuesto.	ええ、もちろん。	了解する		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
978	El probador está al fondo.	試着室は奥です。	場所について述べる		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
979	Gracias.	ありがとう。	感謝する		\N	dmod	es30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
980	Oiga.	すいません。	注意をひく		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
981	Quiero ir al Museo Moderno.	現代美術館に行きたいのです。	希望をのべる		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
982	¿Allí va el autobús?	バスはそこに行きますか？			\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
984	El número 6 va allí, por eso ...	6番のバスはそこに行きますが、そうすると・・・			\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
985	¿Tengo que cambiar la línea?	乗り換えなくてはいけないのですか？	義務を確認する/肯定する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
986	Sí.	そうですね。	 肯定する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
987	Tienes que cambiar en la Plaza Mayor.	プラサ・マヨールで乗り換えなくてはいけません。	義務を確認する/肯定する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
988	Y... después del Museo, voy a ir a la estación Sur.	で・・・美術館のあとに南駅に行くつもりなのですが。	010		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
989	Estación Sur... mejor que vaya a pie.	南駅ですか…、徒歩で行ったほうがいいですね。	助言する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
990	¿Está cerca?	近いですか？	情報をもとめる（存在と場所）		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
991	Sí, sí.	ええ。	肯定する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
992	Está muy cerca.	とても近いですよ。	場所についてのべる 		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
993	Vale.	わかりました。	了解する 		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
994	Gracias.	ありがとうございます。	感謝する		\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
995	Aquí viene el autobús.	バスが来ましたよ。			\N	dmod	es31.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
996	Oiga.	すいません。	注意をひく		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
997	¿Puede usted sacar una foto?	一枚写真をとっていただけますか？	依頼する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
998	No.	いえ。			\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
999	Se prohíbe hacer fotos.	写真撮影は禁止されています。	禁止する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1000	¿Así?	そうなんですか。			\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1001	¿Por qué?	なぜですか？	理由をたずねる		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1002	Aquí hay una base militar.	ここに軍事基地があるのです。	存在についてのべる		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1003	Ah... Vale.	あぁ、わかりました。	了解する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1004	Pero ¡qué bonito es este paisaje! ¿no?	しかしこの景色は美しいですね。	感嘆する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1005	Sí.	ええ。	肯定する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1006	Es verdad.	本当に。			\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1007	Y... ¿sabe usted cómo se va a la parada de autobús?	あと、バス停までどうやって行けばよいかご存知ですか？	何でどうするかたずねる		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1008	Siga todo recto.	ずっとまっすぐ行きます。	指示する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1009	Muchas gracias.	ありがとうございます。	感謝する		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1010	¡Adiós!	さようなら。	さよならを言う		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1011	¡Adiós!	さようなら	さよならを言う		\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1012	¡Buen viaje!	よい旅を。			\N	dmod	es32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1013	Perdone.	すみません。	注意をひく		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1014	¿Por aquí se entra en el museo?	美術館にはここから入るのですか?	場所についてたずねる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1015	Exactamente.	そうです。	相手が述べたことを肯定する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1016	¿Hay control de objetos personales?	持ち物検査はありますか？	情報を求める（存在と場所）		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1017	Sí.	はい。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1018	Ponga los suyos en esta caja.	あなたのものをこの箱に入れてください。	指示する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1019	De acuerdo.	分かりました。	承諾(了解)する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1020	¿Así está bien?	これでいいですか？	確認する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1021	Perfecto.	結構です。	承諾(了解)する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1022	Y usted pase por esta puerta.	あなたはこのゲートを通ってください。	指示する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1023	Vale.	はい。	承諾(了解)する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1024	Espere, por favor.	お待ちください。	指示する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1025	Ah, perdón.	あ、すみません。	あやまる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1026	Es por este llavero.	このキーホルダーのせいです。	理由を述べる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1027	Me lo quito.	はずします。	行動を述べる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
1028	Tome.	はいどうぞ。	人にものをあげる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[4]	\N	\N	\N
1029	Ahora está bien.	今度は大丈夫です。	状況(状態)を述べる		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1030	Gracias por su colaboración.	ご協力ありがとうございました。	感謝する		\N	dmod	es33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1031	Hola.	こんにちは。	挨拶をする		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1032	¿Qué le ha pasado?	どうしましたか？	状況(状態)をたずねる		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1033	Me caí y me torcí la muñeca.	転んで手首をくじいたんです。	行動を述べる		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1034	A ver...	どれどれ…	確認する		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1035	¿Le duele?	痛みますか?	状況(状態)をたずねる		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1036	¡Ay!	あいたっ！	感嘆する(強調する)		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1037	Por favor, no me la toque tan fuerte.	そんなに強く触らないでくださいますか。	しないでくれと言う		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1038	Me duele mucho.	とても痛いんです。	状況(状態)を述べる		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
1039	No está rota, pero... está bastante hinchada.	骨折はしていないが…かなり腫れていますね。	状況(状態)を述べる		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1040	¿Tardará mucho en curarse?	治るのにずいぶんかかるでしょうか？	予定を言う		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1041	Tardará dos semanas al menos.	少なくとも二週間はかかるでしょうね。	予定を言う		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1042	Pero voy a jugar en un partido de tenis el próximo domingo.	でも、今度の日曜日テニスの試合に出るんですが。	予定を言う		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1043	Lo siento pero no puede hacer deporte una semana.	お気の毒ですが、一週間は運動してはいけません。	禁止する		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1044	¡Qué mala suerte!	何て運が悪いの！	感嘆する(強調する)		\N	dmod	es34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1045	¿Podría recomendarme algún diccionario francés-español?	フランス語-スペイン語辞典を何か推薦していただけませんか？	依頼する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1046	Cómo no.	もちろんです。	承諾(了解)する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1047	Por ejemplo, éste.	例えばこれ。	例をあげて述べる		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1048	Es muy ilustrativo.	とても明解ですよ。	属性を述べる		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
1049	Parece que tiene muchos ejemplos.	例文がたくさん載っているようですね。	意見を言う		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1050	Sí.	ええ。	相手が述べたことを肯定する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1051	Si quieres, te lo dejo.	もしよかったら、貸しますけど。	ある条件での行動を言う		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1052	Muchas gracias.	どうもありがとうございます。	感謝する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1053	¿Tengo que devolvérselo hoy?	今日中にお返ししなければなりませんか？	義務を確認する/否定する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1054	No tienes que darte prisa.	急ぐ必要はありません。	義務を確認する/否定する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1055	Tengo otro igual en casa.	同じものがもう一冊家にありますから。	状況(状態)を述べる(所有)		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1056	Entonces se lo devuelvo en la próxima clase.	それでは今度の授業でお返しします。	予定を言う		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1057	Cuando quieras.	いつでもいいですよ。	条件をつける		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1058	Muchas gracias.	どうもありがとうございます。	感謝する		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1059	Hasta la semana que viene.	また来週。	さよならを言う		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1060	Adiós.	さようなら。	さよならを言う		\N	dmod	es35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1061	¿Qué te pasa?	どうしたの？	状況(状態)をたずねる		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1062	Estás muy guapa.	やけにきれいだね。	状況(状態)を述べる		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1063	Es que hoy es mi cumpleaños.	今日は私の誕生日なの。	理由を述べる		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1064	¿Verdad?	本当?	あいづち		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1065	¡Feliz cumpleaños!	誕生日おめでとう！	おめでとうと言う		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1066	Muchas gracias.	どうもありがとう。	感謝する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1067	¿Vas a hacer una fiesta?	パーティーはするの？	予定を言う		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1068	Claro que sí.	もちろんよ。	質問に肯定(はい)/否定(いいえ)でこたえる		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1069	¿Por qué no vienes?	あなたも来ない?	招待する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1070	Estás invitado.	招待するわ。	招待する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1071	Con mucho gusto.	喜んで。	承諾(了解)する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1072	Gracias.	ありがとう。	感謝する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1073	Entonces, ven a mi casa a las siete.	それじゃ、7時に私の家に来てね。	指示する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1074	Vale.	分かった。	承諾(了解)する		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1075	Hasta luego.	じゃあまた。	さよならを言う		\N	dmod	es36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1076	¿Qué te pasa?	どうしたの？	状況(状態)をたずねる		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1077	¿Te encuentras mal?	具合でも悪い?	状況(状態)をたずねる		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1078	Tengo escalofríos.	寒気がするの。	状況(状態)を述べる		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1079	A ver si tienes fiebre...	どれ、熱はあるかな。	確認する		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1080	Sí, tienes fiebre.	うん、熱がある。	状況(状態)を述べる		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1081	Además, me duele mucho la cabeza.	それに、頭がとても痛い。	状況(状態)を述べる		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1082	Seguro que has cogido la gripe.	きっとインフルエンザにかかったんだよ。	意見を言う		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1083	No tengo ganas de ir a clase.	授業に行く気がしないな。	希望を述べる		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1084	Es mejor que vayas al médico.	医者に行った方がいいよ。	助言する		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1085	Tienes razón.	そうね。	相手が述べたことを肯定する		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1086	¿Te importa decir al profesor que no puedo ir a clase?	先生に授業に出られませんって言っておいてくれる？	依頼する		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1088	Se lo diré.	言っておくよ。	予定を言う		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1089	Gracias.	ありがとう。	感謝する		\N	dmod	es37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1090	Me llevo esta corbata.	このネクタイを下さい。	要求する		\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1091	¿Cuánto cuesta?	おいくらですか？	情報を求める（金額）		\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1092	25 euros.	25ユーロでございます。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1093	Vale.	わかりました。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1094	Envuélvala para regalo por favor.	プレゼント用に包んでいただけますか？	依頼する		\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1095	Sí, señor.	承りました。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1096	¿Puedo pagar con tarjeta de crédito?	クレジットカードでの支払いは出来ますか？			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1097	Sí.	はい。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1098	Aquí tiene.	はい、どうぞ。	人にものをあげる		\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1099	Muy bien...	はい。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1100	Firme aquí, por favor.	こちらにサインをお願いします。	依頼する		\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1101	De acuerdo.	わかりました。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1102	Muy bien...	はい。			\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1103	Muchas gracias.	どうもありがとうございました。	感謝する		\N	dmod	es38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1104	Hola.	こんにちは。			\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1105	Hola, María.	こんにちは、マリア。	挨拶をする		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1106	¿Estás sola hoy?	今日は一人かい？	状況をたずねる		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1107	Sí, sí.	ええ。	肯定する		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1108	Carmen está resfriada.	カルメンは風邪を引いているのです。	状況をのべる		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1109	Ah... ¿qué quieres tomar?	あぁ、何を食べますか？	希望をたずねる		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1110	¿Qué me recomiendas?	お奨めは何ですか？			\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1111	Hoy tenemos calamares, tortilla española...	今日はイカと、スペイン風オムレツと･･･			\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1112	Un pincho de tortilla, por favor.	トルティージャのピンチョをください。	依頼する		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1113	Y... ¿algo más?	で、他には？			\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1114	No.	いいわ。	否定する		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1115	Ah... Pero quiero tomar un café solo luego.	あ、でもコーヒーをブラックで一杯飲みたいわ。	希望を述べる		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1116	¿Un café solo?	コーヒーをブラック一杯ね。			\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1117	Muy bien.	わかりました。	了解する		\N	dmod	es39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1118	¿Ésta es tu familia?	これは先生のご家族ですか？			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1119	Sí, sí.	はい。			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1120	Esta foto la tomé hace dos años.	この写真は二年前のものです。			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1121	¿Quién es esta chica, tu hermana?	この女の子は誰ですか？先生の妹さんですか？			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1122	No.	いえ。			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1123	Es mi sobrina Pilar.	姪のピラールです。	人を紹介する		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1124	Y ésta es mi hermana Juana.	そしてこちらが私の妹のフアナです。	人を紹介する		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
1125	¡Qué guapa!	きれいですね！	 感嘆する		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1126	Estudia en la universidad.	大学で勉強しているんだよ。			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1127	Ah... ¿y qué estudia?	へえ、何を勉強しているのですか？	情報をもとめる		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1128	Matemáticas.	数学だよ。			\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1129	Me gustaría conocerla.	知り合いになりたいですね。	希望をのべる		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1130	Claro.	もちろん。	了解する		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1131	Te la presentaré.	君に彼女を紹介するよ。	予定を言う		\N	dmod	es40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1132	Viene un alumno extranjero.	外国人の生徒が1人来る。	\N		\N	vmod	\N	\N	\N	0	1
1133	Me voy al extranjero.	私は外国に行く。	\N		\N	vmod	\N	\N	\N	0	1
1134	Tengo que ir a la Embajada de España para sacar el visado. 	私は査証をとりにスペイン大使館に行かなくてはいけない。	\N		\N	vmod	\N	\N	\N	0	1
1135	¿Vamos a correr al parque?	公園に走りに行く？	\N		\N	vmod	\N	\N	\N	0	1
1136	Yo camino 10 km todos los días.	私は毎日10km歩く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1137	El niño está nadando en la piscina.　	子どもはプールで泳いでいる。	\N		\N	vmod	\N	\N	\N	0	1
1138	Juan corre más rápido que Julia.	フアンはフリアよりも早く走る。	\N		\N	vmod	\N	\N	\N	0	1
1139	Los pingüinos no vuelan.	ペンギンは飛ばない。	\N		\N	vmod	\N	\N	\N	0	1
1140	No me gusta mucho esta música.	私はこの音楽はあまり好きじゃない。	\N		\N	vmod	\N	\N	\N	0	1
1141	Me voy a la piscina mañana por la mañana. 	私は明日の朝、プールに行く。	\N		\N	vmod	\N	\N	\N	0	1
1142	Se me ha estropeado la bicicleta. 	自転車が壊れてしまった。	\N		\N	vmod	\N	\N	\N	0	1
1143	El cruce de esta carretera es peligroso.	この道の交差点は危険だ。	\N		\N	vmod	\N	\N	\N	0	1
1144	Voy a dar una vuelta por la calle.	私はちょっと散歩してくる。	\N		\N	vmod	\N	\N	\N	0	1
1145	En el estanque había muchos peces.	池にはたくさんの魚がいた。	\N		\N	vmod	\N	\N	\N	0	1
1146	Vamos a dar un paseo hasta el Retiro.	レティーロ公園まで散歩に行きましょう。	\N		\N	vmod	\N	\N	\N	0	1
1147	El río Manzanares pasa por Madrid.	マンサナーレス川はマドリードを通る。	\N		\N	vmod	\N	\N	\N	0	1
1148	Giras a la derecha, y encontrarás la señal.	右に曲がると、標識が見えますよ。	\N		\N	vmod	\N	\N	\N	0	1
1149	Quiero colocarme en una empresa buena.	私はいい会社に就職したい。	\N		\N	vmod	\N	\N	\N	0	1
1150	Hay que ponerse traje para la fiesta. 	パーティーには背広をつけなければいけない。	\N		\N	vmod	\N	\N	\N	0	1
1151	No puedo respirar del trabajo que tengo.	私は仕事で息もつけないほどだ。	\N		\N	vmod	\N	\N	\N	0	1
1152	Estos días estoy bastante ocupado.	最近私はかなり忙しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1153	Ayer estuve estudiando en la biblioteca todo el día.	昨日、私は図書館で一日中勉強をしていた。	\N		\N	vmod	\N	\N	\N	0	1
1154	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1155	En esa tienda venden cosas típicas de España.	あの店ではスペインの品物が売られている。	\N		\N	vmod	\N	\N	\N	0	1
1156	En verano tomo mucha fruta.	私は夏には果物をたくさん食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1157	Es importante tomar verduras todos los días. 	野菜を毎日摂取することは大切なことだ。	\N		\N	vmod	\N	\N	\N	0	1
1158	Necesito carne de cerdo para cocinar este plato.	この料理を作るためには豚肉が必要です。	\N		\N	vmod	\N	\N	\N	0	1
1159	Voy a comprar pollo asado.	ローストチキンを買ってくる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1160	Pásame la salsa, por favor.	ソースを取ってください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1161	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1162	Para hacer este plato, necesito laurel.	この料理を作るためにはローレルが必要です。	\N		\N	vmod	\N	\N	\N	0	1
1163	Hoy tengo que hacer la compra.	今日、私は買い物をしないといけない。	\N		\N	vmod	\N	\N	\N	0	1
1164	Mañana si hacec buen tiempo, lavo la ropa.	明日もしいい天気だったら、洗濯をしよう。	\N		\N	vmod	\N	\N	\N	0	1
1165	Es un hogar muy acogedor. 	とても居心地のいい家庭です。	\N		\N	vmod	\N	\N	\N	0	1
1166	Tengo un rosal en el jardín.	私の庭にはバラ園がある。	\N		\N	vmod	\N	\N	\N	0	1
1167	El laｖado de coche cuesta 4 euros.	洗車は４ユーロです。	\N		\N	vmod	\N	\N	\N	0	1
1168	Hoy estoy de limpieza. 	今日は掃除をする日だ。	\N		\N	vmod	\N	\N	\N	0	1
1169	La carta está en mi escritorio. 	手紙は私の机の上にあります。	\N		\N	vmod	\N	\N	\N	0	1
1170	Mi casa tiene 4 habitaciones, una cocina y 2 baños.	私の家には部屋が４つと、台所とトイレが２つあります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1171	He lavado mi jersey.	私はセーターを洗った	\N		\N	vmod	\N	\N	\N	0	1
1172	Escucho la radio por las mañanas.	私は毎朝ラジオを聴く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1173	¿Qué te han regalado por tu cumpleaños? - Una cadena de música.	誕生日に何をプレゼントしてもらったの？－ラジカセだよ。	\N		\N	vmod	\N	\N	\N	0	1
1174	Vamos a mirar en el mapa donde estamos.	今私たちがどこにいるのか、地図で見てみよう。	\N		\N	vmod	\N	\N	\N	0	1
1175	¿Dónde está mi disco? - Ahí está.	私のCDはどこ？－あそこにあるよ。	\N		\N	vmod	\N	\N	\N	0	1
1176	Voy a ir a poner una denuncia a la comisaría.	私は警察に届出をしてくる。	\N		\N	vmod	\N	\N	\N	0	1
1177	¿Puedes cortar la zanahoria?	にんじんを切ってくれる？	\N		\N	vmod	\N	\N	\N	0	1
1178	Vamos por el camino más corto.	一番近い道から行こう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1179	Córtame el pelo por atrás.	後ろの髪を切ってください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1180	Coje la bolsa que está delante de ti.	君の前にある袋をもってください。	\N		\N	vmod	\N	\N	\N	0	1
1181	Levante su mano izquierda, por favor. 	左手を挙げてください。	\N		\N	vmod	\N	\N	\N	0	1
1182	Este pasillo tiene 25 metros de largo.	この廊下は25mの長さがある。	\N		\N	vmod	\N	\N	\N	0	1
1183	Haga el favor de sentarse un minuto.	どうぞ少しおかけになってください。	\N		\N	vmod	\N	\N	\N	0	1
1184	Levántate de la cama, que llegas tarde al colegio.	ベッドから起きなさい。学校に遅れるわよ。	\N		\N	vmod	\N	\N	\N	0	1
1185	Vaya al final del pasillo y gire a la izquierda.	廊下のつきあたりまで行って、左に曲がってください。	\N		\N	vmod	\N	\N	\N	0	1
1186	Voy al colegio a las 7:30.	私は7：30に学校へ行く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1187	A este niño se le da muy mal el estudio.	この子は勉強が苦手だ。	\N		\N	vmod	\N	\N	\N	0	1
1188	En mi clase, hay 3 estudiantes extranjeros.	私のクラスには3人の留学生がいる。	\N		\N	vmod	\N	\N	\N	0	1
1189	¿Qué vas a hacer en las vacaciones de verano?	夏休みには何をするの？	\N		\N	vmod	\N	\N	\N	0	1
1190	¿Me dejas tu cuaderno un momento? 	ちょっとノートを貸してくれる？	\N		\N	vmod	\N	\N	\N	0	1
1191	¿Tienes muchos deberes hoy? - ¡Uy, sí!	今日はたくさん宿題があるの？－そりゃあもう！	\N		\N	vmod	\N	\N	\N	0	1
1192	Aprender japonés será difícil, ¿verdad? - No, no es tan difícil.	日本語を学ぶのは難しいでしょうね。－いいえ、それほどでもありませんよ。	\N		\N	vmod	\N	\N	\N	0	1
1193	¿Me puedes enseñar español?	スペイン語を教えてくれる？	\N		\N	vmod	\N	\N	\N	0	1
1194	No entiendo este ejercicio de matemáticas.	この数学の問題がわからない。	\N		\N	vmod	\N	\N	\N	0	1
1195	¿Hay alguna pregunta?	何かご質問はありますか？	\N	\N	\N	vmod	\N	\N	\N	0	1
1196	Me duelen los dientes. - Tienes que ir al dentista.	歯が痛むんです。－歯医者さんに行かなくては。	\N		\N	vmod	\N	\N	\N	0	1
1197	Visité a mi amigo que está ingresado en el hospital.	私は病院に入院している友達を見舞った。	\N		\N	vmod	\N	\N	\N	0	1
1198	Hay que alimentarse bien para prevenir las enfermedades.	病気を予防するためによく栄養は取らなくてはならない。	\N		\N	vmod	\N	\N	\N	0	1
1199	Mi padre murió a los 60 años.	私の父は60代で亡くなった。	\N		\N	vmod	\N	\N	\N	0	1
1200	Me duele el vientre.	お腹が痛いんです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1201	Vamos a subir por el ascensor.	エレベーターで昇りましょう。	\N		\N	vmod	\N	\N	\N	0	1
1202	Bajamos en la próxima estación. 	次の駅で降りましょう。	\N		\N	vmod	\N	\N	\N	0	1
1203	Mejor que subamos por la escalera.	（私たちは）階段から上ったほうがいいですよ。	\N		\N	vmod	\N	\N	\N	0	1
1204	¿Cómo puedo ir hasta ahí? - Puedes coger el metro y bajar en la estación de Shinjuku.	どうやってそこまで行けますか？－地下鉄に乗って、新宿駅で降りるといいですよ。	\N		\N	vmod	\N	\N	\N	0	1
1205	¿Donde está el servicio? - Está al fondo a la derecha.	トイレはどこですか。－奥の右側です。	\N		\N	vmod	\N	\N	\N	0	1
1206	¿Qué bebida vas a tomar? 	飲み物は何がいい？	\N		\N	vmod	\N	\N	\N	0	1
1207	Entonces, quedamos en la cafetería de siempre. - Muy bien.	じゃあ、いつもの喫茶店で待ち合わせよう。－オッケー。	\N		\N	vmod	\N	\N	\N	0	1
1208	Té con limón, por favor.	レモンティーをください。	\N		\N	vmod	\N	\N	\N	0	1
1209	Quiero un café en taza pequeña, por favor.	コーヒーを小さいカップでお願いします。	\N		\N	vmod	\N	\N	\N	0	1
1210	Por las mañanas tomo un té antes de salir de casa.	毎朝、私は家を出る前に紅茶を飲む。	\N		\N	vmod	\N	\N	\N	0	1
1211	Prefiero el té inglés al té verde.	私は緑茶よりも紅茶が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1212	El camarero sirve muy bien en la mesa.	ウェイターは上手に給仕してくれる。	\N		\N	vmod	\N	\N	\N	0	1
1213	Me encanta el dulce después de las comidas.	私は食後の甘いものが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1214	En las comidas bebo sólo agua.	私は食事の時は水しか飲まない。	\N		\N	vmod	\N	\N	\N	0	1
1215	¿Sabes utilizar los palillos?	お箸の使い方、知ってる？	\N		\N	vmod	\N	\N	\N	0	1
1216	No es bueno abusar de las bebidas alcohólicas.	アルコール飲料の取りすぎは良くない。	\N		\N	vmod	\N	\N	\N	0	1
1217	Este cuchillo tiene buen filo.	このナイフの刃は（切れ味が）いい．	\N		\N	vmod	\N	\N	\N	0	1
1218	Por favor, ¿me acerca una cuchara para la sopa?	すみません、スープ用のスプーンを一つくださいますか。	\N		\N	vmod	\N	\N	\N	0	1
1219	Pínchalo con el tenedor. 	フォークで刺してください。	\N		\N	vmod	\N	\N	\N	0	1
1220	Este pastel no parece que esté muy rico. 	このケーキはあまりおいしそうじゃない。	\N		\N	vmod	\N	\N	\N	0	1
1221	Fui a comprar pan a la panadería de al lado.	私はすぐそこのパン屋さんにパンを買いに行った。	\N		\N	vmod	\N	\N	\N	0	1
1223	Solemos ir al restaurante italiano a cenar los domingos.	私たちは毎週日曜夕食のためにイタリアンレストランに行く。	\N		\N	vmod	\N	\N	\N	0	1
1224	No me gusta nada la comida del comedor del trabajo.	私は職場の食堂の食事が全然好きじゃない。	\N		\N	vmod	\N	\N	\N	0	1
1225	En este restaurante hindú sirven un curry muy rico.	このインド料理レストランのカレーはとてもおいしい。	\N		\N	vmod	\N	\N	\N	0	1
1226	¿Dónde está la entrada del aparcamiento?	駐車場の入り口はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1227	No encuentro la salida por ningún lado.	どこにも出口が見つからない。	\N		\N	vmod	\N	\N	\N	0	1
1228	Dejé la carta en el buzón. 	私は手紙をポストに投函した。	\N		\N	vmod	\N	\N	\N	0	1
1229	Envíame una postal cuando estés en Praga. 	プラハに着いたらポストカードを送ってね。	\N		\N	vmod	\N	\N	\N	0	1
1230	Pega el sello en el sobre.	封筒に切手を貼ってください。	\N		\N	vmod	\N	\N	\N	0	1
1231	Cuando tenga un sobre enviaré el documento. 	封筒が手に入ったら書類を送ろう。	\N		\N	vmod	\N	\N	\N	0	1
1232	Tengo que pasar por correos a recoger el paquete que me envió mi novio.	私は恋人が送ってくれた小包を受け取りに郵便局へ立ち寄らなければいけない。	\N		\N	vmod	\N	\N	\N	0	1
1233	Voy a devolver estos pantalones porque me quedan muy grandes. 	このズボンは返品しよう、私には大きすぎるから。	\N		\N	vmod	\N	\N	\N	0	1
1234	¡Qué bien te queda el sombrero! 	その帽子よく似合ってるね！	\N		\N	vmod	\N	\N	\N	0	1
1235	Este sábado quiero ir a hacer la compra de la semana. 	この土曜日は、私は一週間分の買い物をしに行きたい。	\N		\N	vmod	\N	\N	\N	0	1
1236	En Madrid hay grandes almacenes como El Corté Inglés.	マドリードには、エル・コルテ・イングレスのようなデパートがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1237	Estos pantalones me quedan pequeños.	このズボンは私には小さい。	\N		\N	vmod	\N	\N	\N	0	1
1238	En invierno me pongo dos jerseys cuando voy a la sierra.	冬、私は山に行くのに2重にセーターをつける。	\N		\N	vmod	\N	\N	\N	0	1
1239	¿Me prestas esta chaqueta para la fiesta?	パーティーに行くのにこの上着を貸してくれる？	\N		\N	vmod	\N	\N	\N	0	1
1240	La cocina japonesa es deliciosa.	日本料理はとても美味しい。	\N		\N	vmod	\N	\N	\N	0	1
1241	No tardes mucho en la ducha.	あまりお風呂に時間をかけないでね。	\N		\N	vmod	\N	\N	\N	0	1
1242	Saca el perro al parque.	犬を公園に散歩に連れていきなさい．	\N		\N	vmod	\N	\N	\N	0	1
1243	Le gusta ducharse por las mañanas.	彼(彼女）は朝にシャワーを浴びるのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1244	Los pisos están carísimos.	アパートはものすごく高い。	\N		\N	vmod	\N	\N	\N	0	1
1245	¿Te gustó la ópera de "Carmen"? Sí, gracias por la entrada.	オペラ『カルメン』は良かった？－うん、チケットをありがとう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1246	Nosotros somos buenos amigos.\n	私たちは良い友達です。	\N		\N	vmod	\N	\N	\N	0	1
1247	No sé por qué me dijo tal cosa. 	どうしてそんなことを私に言ったのかわからない。	\N		\N	vmod	\N	\N	\N	0	1
1248	Este filete es más grueso. 	このビフテキはもっと厚い。	\N		\N	vmod	\N	\N	\N	0	1
1249	Esa calle es muy estrecha.	この道はとても狭い。	\N		\N	vmod	\N	\N	\N	0	1
1250	Mejor que utilices un hilo más fino para esta tela.	この生地にはもっと細い糸を使うといいよ。	\N		\N	vmod	\N	\N	\N	0	1
1251	Quiero una habitación amplia.	私は広い部屋が欲しい。	\N		\N	vmod	\N	\N	\N	0	1
1252	Llevo un equipaje ligero para el viaje. 	私は旅行には軽い荷物を持っていく。	\N		\N	vmod	\N	\N	\N	0	1
1253	Este paquete es muy pesado.	この小包はとても重い．	\N		\N	vmod	\N	\N	\N	0	1
1254	No partas el melón tan fino. 	メロンはそんなに薄く切らないでくれ。	\N		\N	vmod	\N	\N	\N	0	1
1255	El niño es muy pequeño para ir solo. 	その子は一人で行くには小さすぎる。	\N		\N	vmod	\N	\N	\N	0	1
1256	Este edificio es bastante viejo.	この建物はかなり古い。	\N		\N	vmod	\N	\N	\N	0	1
1257	Ayer no me encontraba muy animado para salir de casa.	昨日はあまり家から出る気分じゃなかった。	\N		\N	vmod	\N	\N	\N	0	1
1258	Es una persona muy alegre.	彼（彼女）はとてもにぎやかな人だ。	\N		\N	vmod	\N	\N	\N	0	1
1259	Él es el más bajo de su clase. 	彼はクラスで一番背が低い。	\N		\N	vmod	\N	\N	\N	0	1
1260	Hace un día muy claro y buen tiempo.	とても明るくていい天気だ。	\N		\N	vmod	\N	\N	\N	0	1
1261	Se sentía débil después de la operación. 	手術の後、（彼／彼女は）非常に弱ったように感じた。	\N		\N	vmod	\N	\N	\N	0	1
1262	Me resultó bastante interesante el museo.	美術館は私にかなり興味深く感じられた。	\N		\N	vmod	\N	\N	\N	0	1
1263	¡Qué lento eres! Así no vamos a llegar. 	まったくなんてのろまなんだ！こんなんじゃ、着かないよ．	\N		\N	vmod	\N	\N	\N	0	1
1264	Si no te das prisa, vamos a llegar tarde.	急がないと遅刻するよ。	\N		\N	vmod	\N	\N	\N	0	1
1265	No veo nada. Está muy oscura la habitación.	何も見えないよ、部屋が暗すぎる。	\N		\N	vmod	\N	\N	\N	0	1
1266	La habitación está muy sucia.	部屋はとてもきたない。	\N		\N	vmod	\N	\N	\N	0	1
1267	Quedamos dentro de media hora.	30分後に待ち合わせよう。	\N		\N	vmod	\N	\N	\N	0	1
1268	Fuera de casa hace mucho frío. 	家の外はとても寒い。	\N		\N	vmod	\N	\N	\N	0	1
1270	Nos encontramos a 1000 metros de altura. 	私たちの現在地は標高1000メートルです．	\N		\N	vmod	\N	\N	\N	0	1
1271	Este invierno ha sido muy largo y frío.	この冬はとても長く、寒かった。	\N		\N	vmod	\N	\N	\N	0	1
1272	Lloverá al oeste de la Península. 	半島の西側は雨がふるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1273	La vecina de abajo no para de hablar. 	下の階の住民はおしゃべりが止まらない。	\N		\N	vmod	\N	\N	\N	0	1
1274	Sube arriba con la escalera.	階段で上にあがってください．	\N		\N	vmod	\N	\N	\N	0	1
1275	Camina hacia delante.	前にむかって歩いてください。	\N		\N	vmod	\N	\N	\N	0	1
1276	Camina hacia atrás.	後ろに向かって歩いてごらん。	\N		\N	vmod	\N	\N	\N	0	1
1277	Voy a casa de mi primo a comer.	私はいとこの家に食事に行く。	\N		\N	vmod	\N	\N	\N	0	1
1278	Mi abuela se ha ido a dar un paseo.	私の祖母は散歩に行った。	\N		\N	vmod	\N	\N	\N	0	1
1279	Su mujer es muy amable.	彼の奥さんはとても親切だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1280	Mi tío vive al lado nuestro.	私の伯父は私たち家族のすぐ近くに住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1281	La tía de mi amiga es dentista.	私の友達のおばさんは歯科医だ。	\N		\N	vmod	\N	\N	\N	0	1
1282	Mi padre viene a recogerme al aeropuerto.	私の父は私を迎えに空港まで来てくれる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1283	Quiero hacer un buen regalo a mi madre.	私は母に良いプレゼントをあげたい。	\N		\N	vmod	\N	\N	\N	0	1
1284	¿Dónde están mis calcetines? 	私の靴下はどこ？	\N		\N	vmod	\N	\N	\N	0	1
1285	Se me ha mojado la camiseta.	Tシャツが濡れてしまった。	\N		\N	vmod	\N	\N	\N	0	1
1286	Ponme un café con leche. No ponen bien el aperitivo en ese sitio. 	カフェラテを入れてくれ。	\N		\N	vmod	\N	\N	\N	0	1
1287	Ponte los zapatos.	靴をはきなさい。	\N		\N	vmod	\N	\N	\N	0	1
1288	Me pongo la camisa.	Yシャツをつける。	\N	\N	\N	vmod	\N	\N	\N	0	1
1289	En casa es más cómodo andar con zapatillas.	家の中ではスリッパでいるのが心地よい。	\N		\N	vmod	\N	\N	\N	0	1
1290	Voy a coger el paraguas. Está lloviendo mucho.	傘を持っていこう。たくさん雨が降っているから。	\N		\N	vmod	\N	\N	\N	0	1
1291	¿Dónde está el billete? - Te he visto guardarlo en el bolsillo del abrigo.	切符はどこ？－コートのポケットに自分でしまったのを見たよ．	\N		\N	vmod	\N	\N	\N	0	1
1292	Llevo muchos libros en mi cartera.	私はかばんに本をたくさん持っている。	\N		\N	vmod	\N	\N	\N	0	1
1293	Llevo mucho tiempo estudiando. 	私は長い時間勉強をし続けている。	\N		\N	vmod	\N	\N	\N	0	1
1294	Mañana si hace buen tiempo, lavaré la ropa.	明日、もしいい天気だったら私は洗濯をしよう。	\N		\N	vmod	\N	\N	\N	0	1
1296	Límpiate la boca con la servilleta.	ナプキンで口をぬぐいなさい。	\N		\N	vmod	\N	\N	\N	0	1
1297	¡Qué golpe me he dado en el brazo!	腕を強く打ってしまった！	\N		\N	vmod	\N	\N	\N	0	1
1298	Me duele todo el cuerpo porque tengo agujetas.	私は筋肉痛で体中が痛い。	\N		\N	vmod	\N	\N	\N	0	1
1299	¡Menuda cara más dura, se fue sin pagar!	なんて面の皮が厚いやつだ。お金を払わずに行ってしまった！	\N		\N	vmod	\N	\N	\N	0	1
1300	Suénate la nariz.	鼻をかみなさい。	\N		\N	vmod	\N	\N	\N	0	1
1301	¡Ojo, esto sí es importante!	気をつけて、これは重要だから。	\N		\N	vmod	\N	\N	\N	0	1
1302	Lleva tres pendientes en la oreja.	彼女は耳に3つもピアスをしている。	\N		\N	vmod	\N	\N	\N	0	1
1303	Tengo la tripa llena. He comido mucho.	お腹がいっぱいだ。食べ過ぎた。	\N		\N	vmod	\N	\N	\N	0	1
1304	De primer plato quiero sopa, y de segundo, un filete, por favor.	前菜にはスープを、そしてメインディッシュにはビフテキをください。	\N		\N	vmod	\N	\N	\N	0	1
1305	Desayuno tostadas con mantequilla.	私は朝食には，トーストにバターをぬって食べる。	\N		\N	vmod	\N	\N	\N	0	1
1306	Sirve la sopa en cuencos.	スープは茶碗に注いでください。	\N		\N	vmod	\N	\N	\N	0	1
1307	La comida de mi madre es la mejor.	私の母の料理は絶品だ。	\N		\N	vmod	\N	\N	\N	0	1
1308	Me apetece un dulce de esa pastelería.	私はあのケーキ屋の甘菓子が食べたい。	\N		\N	vmod	\N	\N	\N	0	1
1309	Mis gallinas ponen huevos todos los días.	私の鶏は毎日卵を産む。	\N		\N	vmod	\N	\N	\N	0	1
1310	El pescado a la plancha queda bien con salsa de soja.	焼き魚は醤油と合う。	\N		\N	vmod	\N	\N	\N	0	1
1311	No eches demasiada sal a la ensalada.	サラダに塩をかけすぎないでください。	\N		\N	vmod	\N	\N	\N	0	1
1312	Añade una cucharada más de azúcar.	砂糖をもう一さじ加えて下さい。	\N		\N	vmod	\N	\N	\N	0	1
1313	Voy a pegar la foto en el álbum.	写真をアルバムに貼る。	\N		\N	vmod	\N	\N	\N	0	1
1314	Para mi cumpleaños quiero una cámara de fotos.	誕生日には私はカメラがほしい。	\N		\N	vmod	\N	\N	\N	0	1
1315	Tienes cara de frío. Arrímate a la estufa.	寒そうだね。ストーブにもっと近づいて。	\N		\N	vmod	\N	\N	\N	0	1
1316	Los niños escriben con lápiz.	子供たちは鉛筆で字を書く。	\N		\N	vmod	\N	\N	\N	0	1
1317			\N		\N	vmod	\N	\N	\N	0	1
1318	Necesito ponerme gafas.	私は眼鏡をかけなくてはいけない。	\N		\N	vmod	\N	\N	\N	0	1
1319	En el teatro no se permite usar la grabadora.	劇場ではテープレコーダーの使用は許されていない。	\N		\N	vmod	\N	\N	\N	0	1
1320	Este reloj va atrasado.	この時計は遅れている。	\N		\N	vmod	\N	\N	\N	0	1
1321	Tengo que pasar el trabajo a ordenador.	私はレポートをパソコンに入力しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1322	Esta cámara lleva un carrete de 24 fotos.	このカメラには24枚撮りのフイルムが入っている。	\N		\N	vmod	\N	\N	\N	0	1
1324	Llevo utilizando esta pluma estilográfica más de 10 años.	私はこの万年筆を10年以上も使っている。	\N		\N	vmod	\N	\N	\N	0	1
1325	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1326	Este mes de agosto me quiero ir de vacaciones.	この8月は私は休暇で出かけたい。	\N		\N	vmod	\N	\N	\N	0	1
1327	Su cumpleaños es en abril.	彼の誕生日は4月だ。	\N		\N	vmod	\N	\N	\N	0	1
1328	Este mes se me está haciendo muy largo.	今月はとても長く感じられる。	\N		\N	vmod	\N	\N	\N	0	1
1329	En diciembre celebramos la Navidad con la falimia.	12月には私たちは家族でクリスマスを祝う。	\N		\N	vmod	\N	\N	\N	0	1
1330	En febrero quiero ir de excursión un fin de semana.	2月には，どこかの週末に遠足に行きたいな．	\N		\N	vmod	\N	\N	\N	0	1
1331	El dulce típico de enero es el roscón de reyes.	1月の季節のお菓子はロスコン・デ・レジェス（リング状のパウンドケーキ）だ．	\N		\N	vmod	\N	\N	\N	0	1
1332	En julio empieza a hacer calor de verdad.	7月には本格的に暑くなる．	\N		\N	vmod	\N	\N	\N	0	1
1333	El mes que viene estoy fuera de Tokio.	来月は私は東京の外にいる。	\N		\N	vmod	\N	\N	\N	0	1
1334	Marzo ventoso, abril lluvioso, sacan a mayo florido y hermoso.	（諺）風が強い3月と雨の多い4月は、花が咲きみだれる美しい5月をもたらす。	\N		\N	vmod	\N	\N	\N	0	1
1335	El mes pasado no llovió lo suficiente.	先月は雨が十分に降らなかった。	\N		\N	vmod	\N	\N	\N	0	1
1336	En noviembre si hay algún puente, podemos ir de viaje a Asturias.	11月に飛び石連休があれば、私たちはアストゥーリアス地方に旅行に行ける。	\N		\N	vmod	\N	\N	\N	0	1
1337	En octubre nació mi sobrinito.	10月には私の甥っ子が生まれた．	\N		\N	vmod	\N	\N	\N	0	1
1338			\N		\N	vmod	\N	\N	\N	0	1
1339	El jueves voy a estudiar a la biblioteca.	木曜日、私は図書館に勉強に行く。	\N		\N	vmod	\N	\N	\N	0	1
1340	¿Te viene bien que quedemos este martes?	火曜日に会うのは都合いいかい？	\N		\N	vmod	\N	\N	\N	0	1
1341	Los miércoles tengo clase de piano.	水曜日にはピアノのレッスンがある．	\N		\N	vmod	\N	\N	\N	0	1
1342	El otoño es una estación que me gusta mucho.	秋は，私がとても好きな季節だ。	\N		\N	vmod	\N	\N	\N	0	1
1343	Todos los años llueve por estas fechas.	毎年この頃には雨が降る。	\N		\N	vmod	\N	\N	\N	0	1
1344	El invierno en Ávila es bastante frío.	アビラの冬はかなり寒い。	\N		\N	vmod	\N	\N	\N	0	1
1345	No lo veo desde el año pasado.	私は去年から彼に会っていない。	\N		\N	vmod	\N	\N	\N	0	1
1346	Al año que viene empiezo el doctorado.	私は来年博士課程を始める。	\N		\N	vmod	\N	\N	\N	0	1
1347	Ya se terminaron las vacaciones de primavera.	春休みがもう終わってしまった。	\N		\N	vmod	\N	\N	\N	0	1
1348	Nos casamos dentro de dos años.	私たちは再来年，結婚する。	\N		\N	vmod	\N	\N	\N	0	1
1349	Vámonos ya, que atardece.	もう行こう、日が暮れてしまう。	\N		\N	vmod	\N	\N	\N	0	1
1350	A ver si quedamos pasado mañana.	あさって会えたらいいね．	\N		\N	vmod	\N	\N	\N	0	1
1351	Anteayer estuve en casa sin salir.	一昨日、私は出かけず、家にいた。	\N		\N	vmod	\N	\N	\N	0	1
1352	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1353	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1354	Enseguida se cansa.	（彼／彼女は）すぐに疲れてしまう。	\N		\N	vmod	\N	\N	\N	0	1
1355	En este bar no hay ceniceros porque está prohibido fumar.	このバルには灰皿が無いのは，禁煙だからだ．	\N		\N	vmod	\N	\N	\N	0	1
1356	Apague su cigarrillo por favor. Aquí no está permitido fumar. 	タバコを消してください、ここは禁煙です。	\N		\N	vmod	\N	\N	\N	0	1
1357	Este disco está genial.	このCDはとてもいい。	\N		\N	vmod	\N	\N	\N	0	1
1358	Colecciono discos de vinilo.	私はレコードをコレクションしている．	\N		\N	vmod	\N	\N	\N	0	1
1359	¿Tocas el piano?	ピアノを弾けますか？	\N		\N	vmod	\N	\N	\N	0	1
1360	¿Tocas algún instrumento? ¡Niño, no toques eso!	何か楽器を弾けますか？（子供に対し）こら、それに触らないで！	\N	\N	\N	vmod	\N	\N	\N	0	1
1361	La música calma a las fieras. 	音楽は猛獣さえをもなだめる。	\N		\N	vmod	\N	\N	\N	0	1
1362	Tiene en su casa pinturas de gran calidad.	彼女は家に素晴らしい絵画をいくつももっている。	\N		\N	vmod	\N	\N	\N	0	1
1363	Esta noche hace fresco.	今晩は涼しい。	\N		\N	vmod	\N	\N	\N	0	1
1364	El tejado estaba cubierto de nieve.	屋根は雪で覆われていた。	\N		\N	vmod	\N	\N	\N	0	1
1365	¿Qué pasó con tu sombrero? - Se lo llevó el viento. 	帽子，どうしたの？－風が持っていってしまったよ．	\N		\N	vmod	\N	\N	\N	0	1
1367	Siempre la misma historia. ¿Por qué no inventas una excusa mejor?	いつも同じ話だ。もっとましな言い訳をしたらどうだ？	\N		\N	vmod	\N	\N	\N	0	1
1368	NULL	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1369	No se te ocurra decir ni una palabra. 	一言もしゃべっちゃダメだよ。	\N		\N	vmod	\N	\N	\N	0	1
1370	Escribe la frase en la pizarra.	その文を黒板に書いて下さい。	\N		\N	vmod	\N	\N	\N	0	1
1371	Cuéntame lo que pasó.	何があったのか話してくれ。	\N		\N	vmod	\N	\N	\N	0	1
1372	No entiendo el significado de esta palabra. 	この単語の意味がわからない。	\N		\N	vmod	\N	\N	\N	0	1
1373	En japonés hay dos alfabetos silábicos: el hiragana y el katakana.	日本語には2つの音節文字があります。ひらがなとカタカナです。	\N		\N	vmod	\N	\N	\N	0	1
1374	El katakana se utiliza para escribir extranjerismos.	カタカナは外国の物を書くのに使います。	\N		\N	vmod	\N	\N	\N	0	1
1375	Ya es adulto. Debería comportarse mejor.	（彼は）もう大人なんだから、もう少しましに振舞うべきだ。	\N		\N	vmod	\N	\N	\N	0	1
1376	Muchos amigos míos viven fuera de Madrid.	私の友達の多くはマドリッドの外に住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1377	Mis padres llevan 25 años de matrimonio.	私の両親は25年間夫婦生活を送っている。	\N		\N	vmod	\N	\N	\N	0	1
1378	Mi marido y yo somos felices.	私と夫は幸せです。	\N		\N	vmod	\N	\N	\N	0	1
1379	Me gusta el blanco para vestir.	私は白い服が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1380	¿Me prestas tu falda azul?	青いスカートを貸してくれる？	\N	\N	\N	vmod	\N	\N	\N	0	1
1381	Mi madre siempre se viste de color marrón.	私の母はいつも茶色の服を着ている．	\N		\N	vmod	\N	\N	\N	0	1
1382	¡Claro que no! No pienso ir allí más con esa gente.	もちろんだよ！もう二度とあの人たちとそこに行きたいとは思わないね．	\N		\N	vmod	\N	\N	\N	0	1
1383	El pasillo estaba oscuro.	廊下は暗かった。	\N		\N	vmod	\N	\N	\N	0	1
1384	No me gusta ese coche de color amarillo.	私はその黄色い車はあまり好きじゃない．	\N		\N	vmod	\N	\N	\N	0	1
1385	Delante del coche negro tengo el mío.\n	黒い車の前に私の（車）がある。	\N		\N	vmod	\N	\N	\N	0	1
1386	Ahora no podemos pasar porque el semáforo está en rojo.	今は信号が赤だから渡れないよ．	\N		\N	vmod	\N	\N	\N	0	1
1387	¡Qué bonito está el campo verde!	なんてきれいなんだ，緑の野原は！	\N		\N	vmod	\N	\N	\N	0	1
1388	Esto es una cosa muy útil.	これはとても便利なものなんだ．	\N		\N	vmod	\N	\N	\N	0	1
1389	Se hizo el tonto, pero sabía de lo que hablaban.	彼は馬鹿なふりをしたけれども，（彼らが）話していることはわかっていた．	\N		\N	vmod	\N	\N	\N	0	1
1390	¡Abróchate los cordones, que te vas a caer!	\N	\N	\N	\N	vmod	\N	\N	\N	0	1
1391	¡No me empujes!	押さないで！	\N		\N	vmod	\N	\N	\N	0	1
1392	Te lo empiezo a contar de nuevo. Escucha atentamente.	もう一度話すから，気をつけて聞くんだよ．	\N		\N	vmod	\N	\N	\N	0	1
1393	Justo lo que me imaginaba: se ha comido toda la tarta.	思ったとおりだ．彼がケーキを全部食べちゃったんだ．	\N		\N	vmod	\N	\N	\N	0	1
1394	De mayor quiero ser famoso.	私は大きくなったら有名になりたい．	\N		\N	vmod	\N	\N	\N	0	1
1395	La ternera está un poco cara en esta tienda.	この店では牛肉は少し高い．	\N		\N	vmod	\N	\N	\N	0	1
1396	¡Qué niño más malo!	なんて悪い子だ！	\N		\N	vmod	\N	\N	\N	0	1
1397	Se escucha un ruido a lo lejos.	遠くで騒ぎが聞こえる．	\N		\N	vmod	\N	\N	\N	0	1
1398	 ¡Corre, hazlo rápido!	急いで、早くそれをしなさい！	\N		\N	vmod	\N	\N	\N	0	1
1399	El tiempo corre.	時間はあっという間に過ぎていく。	\N		\N	vmod	\N	\N	\N	0	1
1400	A mis hijos les gusta nadar en el río.	私の息子たちは川で泳ぐのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1401	Me voy volando.	大急ぎで帰ります。	\N		\N	vmod	\N	\N	\N	0	1
1402	¿Te gusta el fútbol?	君はサッカーが好き？	\N		\N	vmod	\N	\N	\N	0	1
1403	En la piscina había muchos niños.	プールにはたくさんの子供がいた。	\N		\N	vmod	\N	\N	\N	0	1
1404	El niño está aprendiendo a montar en bicicleta.	子供が自転車の乗り方を練習している。	\N		\N	vmod	\N	\N	\N	0	1
1405	La calle del Codo es la más estrecha de Madrid. 	コド通りは、マドリードで一番狭い道です。	\N		\N	vmod	\N	\N	\N	0	1
1406	Para mi trabajo me visto de traje.	私は仕事には背広で行く。	\N		\N	vmod	\N	\N	\N	0	1
1407	No me gustan nada las verduras.	私は野菜はまったく駄目です。	\N		\N	vmod	\N	\N	\N	0	1
1409	¡Cuidado con el plato! Está muy caliente.	お皿に気をつけて！熱いよ．\n	\N		\N	vmod	\N	\N	\N	0	1
1410	Sírveme en un plato pequeño. 	私には小さなお皿についでくれ。	\N		\N	vmod	\N	\N	\N	0	1
1411	No ha roto un plato en su vida. 	彼は人生でお皿ひとつ割ったことがない→（彼は一度も悪いことをしたことがない）	\N		\N	vmod	\N	\N	\N	0	1
1412	Quiero un hogar confortable.	私は快適な家庭がほしい。	\N		\N	vmod	\N	\N	\N	0	1
1413	Hoy viene la señora de la limpieza a casa.	今日は家政婦さんが家に来る。	\N		\N	vmod	\N	\N	\N	0	1
1414	Lo tengo en mi escritorio. 	それは私の机にある。	\N		\N	vmod	\N	\N	\N	0	1
1415	 ¿Cuándo te cortaste el pelo?	いつ髪を切ったの？	\N		\N	vmod	\N	\N	\N	0	1
1416	No mires para atrás.	後ろを振り返らないで。	\N		\N	vmod	\N	\N	\N	0	1
1417	Delante de mí había un perro que me quería morder.	私の前には犬がいて、私を噛もうとしていた。	\N		\N	vmod	\N	\N	\N	0	1
1418	¿Dónde está el hospital? - Vas por esta calle, y lo encontrarás a tu izquierda.	病院はどこですか？－この道を行くと、左手にありますよ。	\N		\N	vmod	\N	\N	\N	0	1
1419	No me gustan los chicos que tienen pelo largo.	私は長髪の男の子は好きじゃない。	\N		\N	vmod	\N	\N	\N	0	1
1420	¡Siéntate!	座ってください！	\N		\N	vmod	\N	\N	\N	0	1
1421	¡Levántate! 	起きなさい！	\N		\N	vmod	\N	\N	\N	0	1
1422	Se levantó y se fue.	彼は立ち上がって出て行ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
1424	Hago los deberes en el cuaderno.	（私は）ノートに宿題をする。	\N		\N	vmod	\N	\N	\N	0	1
1425	Se estropeó el ascensor y nos quedamos encerrados.	エレベーターが壊れ、私たちは閉じ込められてしまった。	\N		\N	vmod	\N	\N	\N	0	1
1426	Baja la persiana, por favor.	ブラインドを閉めてください。	\N		\N	vmod	\N	\N	\N	0	1
1427	Saca la bebida fuera del frigorífico.	飲み物を冷蔵庫の外に出しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1428	Quiero una bebida fría.	冷たい飲み物がほしい。	\N		\N	vmod	\N	\N	\N	0	1
1429	Nos vemos en la cafetería de la esquina.	角の喫茶店で会いましょう。	\N		\N	vmod	\N	\N	\N	0	1
1430	Acércame la taza de leche.	ミルクのカップを寄せてください。	\N		\N	vmod	\N	\N	\N	0	1
1431	¿Qué prefieres tomar, café o té?	コーヒーとお茶，どっちが飲みたい？	\N		\N	vmod	\N	\N	\N	0	1
1433	Té con leche	ミルクティー	\N		\N	vmod	\N	\N	\N	0	1
1434	Este pastel es demasiado dulce.	このお菓子は甘すぎる。	\N		\N	vmod	\N	\N	\N	0	1
1435	Si comes mucho dulce se te pican los dientes.	もし甘いものを食べ過ぎたら，歯が痛くなるよ。	\N		\N	vmod	\N	\N	\N	0	1
1436	En verano es bueno beber mucha agua.	夏はたくさん水を飲むのが良い。	\N		\N	vmod	\N	\N	\N	0	1
1437	Necesito un palillo para pinchar las aceitunas. 	オリーブの実をつつく爪楊枝がほしい。	\N		\N	vmod	\N	\N	\N	0	1
1438	Coge bien el tenedor.	フォークをしっかり持ちなさい。	\N		\N	vmod	\N	\N	\N	0	1
1439			\N		\N	vmod	\N	\N	\N	0	1
1440	Este pan está muy duro.	このパンはとても固い。	\N		\N	vmod	\N	\N	\N	0	1
1441	La comida mexicana es muy picante.	メキシコ料理はとても辛い。	\N		\N	vmod	\N	\N	\N	0	1
1442	En aquel restaurante preparan buen cocido.	あのレストランでは煮込み料理がおいしい。	\N		\N	vmod	\N	\N	\N	0	1
1443	Tengo dos entradas para la ópera "Carmen". ¿Quieres ir?	オペラ『カルメン』のチケットが2枚あるんだけど、行きたい？	\N		\N	vmod	\N	\N	\N	0	1
1444	Esto no tiene salida.	この問題は解決の見通しがない。	\N		\N	vmod	\N	\N	\N	0	1
1445	Echan mucha propaganda en los buzones.	郵便受けにたくさん広告が入れられる。	\N		\N	vmod	\N	\N	\N	0	1
1446	Tu postal del viaje me ha encantado.	君の旅行のポストカードはとても気に入ったよ。	\N		\N	vmod	\N	\N	\N	0	1
1447	Le sentó mal la cena y devolvió todo.	夕食があたって、彼はすべてもどしてしまった。	\N		\N	vmod	\N	\N	\N	0	1
1448	Ese sombrero es muy elegante.	その帽子はとても上品だ。	\N		\N	vmod	\N	\N	\N	0	1
1449	¡Niño, que te manchas el pantalón!	ほら、ズボンが汚れるよ！	\N		\N	vmod	\N	\N	\N	0	1
1450	Al trabajo voy con chaqueta y corbata.	私は上着とネクタイで仕事に行く。	\N		\N	vmod	\N	\N	\N	0	1
1451	Me voy a duchar. 	お風呂に入るね。	\N		\N	vmod	\N	\N	\N	0	1
1452	Hay mucha gente que pasea por el parque.	公園を散歩する人はたくさんいる。	\N		\N	vmod	\N	\N	\N	0	1
1453	Así le dijo tal cual, sin explicarle más.	（彼は）それ以上の説明なしに，こんなふうに言ったんだよ．	\N		\N	vmod	\N	\N	\N	0	1
1454	No cortes el jamón en lonchas tan gruesas.	ハムをそんなに厚く切らないでください。	\N		\N	vmod	\N	\N	\N	0	1
1455	Vamos a paso ligero. Si no, no llegaremos a tiempo.	足取りを軽めて行こう．そうしないと時間までに着かないよ。	\N		\N	vmod	\N	\N	\N	0	1
1456	Se compró un coche a bajo precio.	彼は非常に低額で車を買った．	\N		\N	vmod	\N	\N	\N	0	1
1457	Está claro que no quiere ir al cine. 	彼が映画に行きたくないのは明らかだ。	\N		\N	vmod	\N	\N	\N	0	1
1458	Como esta camiseta es muy clara, se mancha fácilmente.	このシャツの色は淡いから，汚れやすい．	\N		\N	vmod	\N	\N	\N	0	1
1459	Es un poco lento comiendo.	彼は食べるのが少し遅い。	\N		\N	vmod	\N	\N	\N	0	1
1460	Prefiero un jersey más oscuro.	私はもっと色の濃いセーターの方がいい．	\N		\N	vmod	\N	\N	\N	0	1
1461	Mira dentro del cajón.	引き出しの中をみてごらん。	\N		\N	vmod	\N	\N	\N	0	1
1462	Al este de Madrid está Guadalajara.	マドリッドの東にはグアダラハラがある。	\N		\N	vmod	\N	\N	\N	0	1
1463	Mira abajo de la almohada, ahí está el regalo.	枕の下を見てごらん．そこにプレゼントがあるよ．	\N		\N	vmod	\N	\N	\N	0	1
1464	Este calcetín tiene agujeros.	この靴下は穴が開いている。	\N		\N	vmod	\N	\N	\N	0	1
1465	¿Por qué te quitas la camiseta? -Porque tengo calor.	どうしてシャツを脱ぐの？暑いから．	\N		\N	vmod	\N	\N	\N	0	1
1466	Tarda mucho en ponerse a estudiar. 	（彼は）勉強し始めるのに時間がかかる．	\N		\N	vmod	\N	\N	\N	0	1
1467	Ponerse las botas.	（成句）腹いっぱい食べる	\N		\N	vmod	\N	\N	\N	0	1
1468	Le robaron la cartera sin que se diera cuenta.	彼は気づかないうちに財布をすられた。	\N		\N	vmod	\N	\N	\N	0	1
1469	Llevo con mi novio 3 años y medio.	私は彼氏と3年半付き合っている。	\N		\N	vmod	\N	\N	\N	0	1
1470	Abre la boca.	口を開けてください．	\N		\N	vmod	\N	\N	\N	0	1
1471	He comprado una estufa para el invierno.	私はこの冬のためにストーブを買った。	\N		\N	vmod	\N	\N	\N	0	1
1472	Tiene una cara preciosa.	彼（彼女）はとてもきれいな顔をしている。	\N		\N	vmod	\N	\N	\N	0	1
1473	Me pica la nariz.	鼻がかゆい。	\N		\N	vmod	\N	\N	\N	0	1
1474	¡Qué ojos tan bonitos!	なんてきれいな目だ！	\N		\N	vmod	\N	\N	\N	0	1
1475	Hacer un huevo a la plancha.	目玉焼きを作る。	\N		\N	vmod	\N	\N	\N	0	1
1476	Huevo duro.	ゆで卵	\N		\N	vmod	\N	\N	\N	0	1
1477	¿Has echado sal al guiso?	煮込みに塩を入れた？	\N		\N	vmod	\N	\N	\N	0	1
1478	¿Dónde se pueden comprar carretes?	どこでフィルムを買えますか？	\N		\N	vmod	\N	\N	\N	0	1
1479	Una pluma estilográfica muy elegante.	とても上品な万年筆。	\N		\N	vmod	\N	\N	\N	0	1
1480	En estos grandes almacenes venden aires acondicionados muy baratos.	このデパートではクーラーを安く売っている．	\N		\N	vmod	\N	\N	\N	0	1
1481	Febrero es el mes más frío.	2月は一番寒い月だ．	\N		\N	vmod	\N	\N	\N	0	1
1482	Quiere hacerse el dormido.	眠ったふりをしようとしている．	\N		\N	vmod	\N	\N	\N	0	1
1484	Estuve malo toda la noche.	私は一晩中具合が悪かった．	\N		\N	vmod	\N	\N	\N	0	1
1485	La mujer que está ahí sentada tiene un jersey muy bonito.	あそこに座っている女性はとても素敵なセーターをつけている．	\N		\N	vmod	\N	\N	\N	0	1
1486	De ahora en adelante me he propuesto hacer dieta.	これから先，私はダイエットをすることにした．	\N		\N	vmod	\N	\N	\N	0	1
1487	El padre de Víctor es ingeniero.	ビクトルのお父さんはエンジニアだ．	\N		\N	vmod	\N	\N	\N	0	1
1488	Esta tarde vamos a ver una obra de teatro en la que sale la madre de Ana.	今日の午後は私たちはアナのお母さんが出演する劇を見に行く．	\N		\N	vmod	\N	\N	\N	0	1
1489	Se me ha borrado el trabajo que guardé el otro día en el ordenador.	この前パソコンに保存したレポートが消えてしまった．	\N		\N	vmod	\N	\N	\N	0	1
1490	¿Me puedes prestar la goma de borrar?	消しゴムを貸してくれる？	\N		\N	vmod	\N	\N	\N	0	1
1491	En septiembre tengo que hacer la preinscripción de la autoescuela.	私は9月には自動車教習所の申し込みをしないといけない．	\N		\N	vmod	\N	\N	\N	0	1
1492	Visitamos el pueblo en el atardecer.	私たちは夕方に村を訪れた。	\N		\N	vmod	\N	\N	\N	0	1
1493	Todo el mundo está de vacaciones en Semana Santa.	聖週間には皆が休暇をとる．	\N		\N	vmod	\N	\N	\N	0	1
1494	Tómate todo el tiempo que quieras, no hay prisa.	好きなだけ時間を使いなさい，急ぐことはないよ．	\N		\N	vmod	\N	\N	\N	0	1
1495	Perdona, ¿tienes un cigarrillo?	すみません、タバコを一本もっていますか（もらえますか）？	\N		\N	vmod	\N	\N	\N	0	1
1496	Aprendí a tocar la guitarra cuando era niño.	私は小さい頃ギターを習っていた。	\N		\N	vmod	\N	\N	\N	0	1
1497	En casa hace mucho calor, vamos a salir a tomar el fresco.	家の中はとても暑い。少し涼みに外にでよう。	\N		\N	vmod	\N	\N	\N	0	1
1498	Hace viento. Vamos a volar la cometa.	風があるから凧を飛ばそう。	\N		\N	vmod	\N	\N	\N	0	1
1499	Conozco algunos kanjis.	私は漢字をいくつか知っている．	\N		\N	vmod	\N	\N	\N	0	1
1500	La historia siempre se repite.	歴史は常に繰り返される．	\N		\N	vmod	\N	\N	\N	0	1
1501	La historia la escriben los ganadores, no los perdedores.	歴史を書くのは勝者であり、敗者ではない。	\N		\N	vmod	\N	\N	\N	0	1
1502	El extranjero no habla ni una palabra de español.	その外国人はスペイン語を一言も話さない。	\N		\N	vmod	\N	\N	\N	0	1
1503	La frase no está bien construida.	その文はうまくできていない。	\N		\N	vmod	\N	\N	\N	0	1
1504	Sabe contar hasta diez.	（彼は）10まで数えることができる。	\N		\N	vmod	\N	\N	\N	0	1
1505	Cuenta conmigo para lo que quieras. 	何でも私を頼って下さい。	\N		\N	vmod	\N	\N	\N	0	1
1507	Mejor que no vayamos muchos.	あまり大勢で行かない方がいいよ．	\N		\N	vmod	\N	\N	\N	0	1
1508	Prefiero el coche de color blanco.	私は白い車の方が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1509	¿Ves útil tener tantos trastos desordenados? 	こんなにがらくたをごちゃごちゃと持つことが便利だと思うのかい？	\N		\N	vmod	\N	\N	\N	0	1
1510	Abróchese el cinturón de seguridad.	シートベルトをお締めください．	\N		\N	vmod	\N	\N	\N	0	1
1511	Empuja fuerte la puerta.	ドアを強く押してください．	\N		\N	vmod	\N	\N	\N	0	1
1512	Me queda un poco justo el zapato.	この靴は私にはちょっときつずぎる．	\N		\N	vmod	\N	\N	\N	0	1
1513	Es un grupo muy famoso. 	このとても有名なグループだ．	\N		\N	vmod	\N	\N	\N	0	1
1514	No me gusta escuchar la música alta.	私は大音響で音楽を聴くのは好きじゃない．	\N		\N	vmod	\N	\N	\N	0	1
1515	No sé hablar español.	私はスペイン語を話せません．	\N		\N	vmod	\N	\N	\N	0	1
1516	Se pegó con un niño en el colegio. 	（彼は）学校で殴り合いのけんかをした．	\N		\N	vmod	\N	\N	\N	0	1
1517	La verdad es que este vestido no te pega mucho. 	正直なところ，この洋服はあまり君には馴染まない．	\N		\N	vmod	\N	\N	\N	0	1
1518	¿No sería mejor que mandaramos eso por correo?	それは郵便で送ったほうがいいんじゃないかい？	\N		\N	vmod	\N	\N	\N	0	1
1519	La semana que viene se casa mi hermana pequeña.	来週私の妹が結婚する．	\N		\N	vmod	\N	\N	\N	0	1
1520	Mi hermano menor juega al fútbol.	私の弟はサッカーをする．	\N		\N	vmod	\N	\N	\N	0	1
1521	Mi hermano mayor es profesor de música.	私の兄は音楽の先生だ．	\N		\N	vmod	\N	\N	\N	0	1
1522	Voy a comprar unas manzanas a la frutería de la esquina.	りんごをいくつか買いに角の八百屋に行ってくる．	\N		\N	vmod	\N	\N	\N	0	1
1523	(toc toc) - Sí adelante.	（ノック）－はい，どうぞ．	\N		\N	vmod	\N	\N	\N	0	1
1524	ponerse el sombrero.	帽子をかぶる．	\N		\N	vmod	\N	\N	\N	0	1
1525	Se ha hecho cristiano.	（彼は）クリスチャンになった．	\N		\N	vmod	\N	\N	\N	0	1
1526	El servicio al cliente en este restaurante es de primera calidad.	このレストランのサービスは一流だ．	\N		\N	vmod	\N	\N	\N	0	1
1527	No he entendido la tercera pregunta.	三問目がわからなかった．	\N		\N	vmod	\N	\N	\N	0	1
1528	El cielo estaba despejado pero de repente se nubló y empezó a llover.	空は快晴だったが急に曇って雨が降りだした．	\N		\N	vmod	\N	\N	\N	0	1
1529	Mi primo tiene los pies muy grandes.	私のいとこの足は大きい．	\N		\N	vmod	\N	\N	\N	0	1
1530	Ahora están de oferta las galletas en el supermercado de la esquina.	今，角のスーパーではクッキーが特売セールだ．	\N		\N	vmod	\N	\N	\N	0	1
1531	Me quiero comprar una camisa nueva para el verano.	この夏のために新しいシャツを買いたい．	\N		\N	vmod	\N	\N	\N	0	1
1532	¿De qué curso eres?  - Soy de primero.	君は何年生ですか？―1年生です．	\N		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1533	¿María es abogada?  - No, no es abogada.	マリアは弁護士ですか？―いいえ，弁護士ではありません．	\N		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1534	¿No eres historiador?  - No, yo soy periodista.	君は歴史学者ではないのですか？―いいえ，私は記者です．	\N		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1596	¿Te importa que vaya a verte esta tarde?	今日の午後君に会いに行ってもいい？	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1535	¿Es Pedro policía?  - Sí, y Laura también.	ペドロは警官なのですか？―ええ，ラウラもそうです．	\N		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1537	Luisa es ama de casa, ¿verdad?  - No, es taxista.	ルイサは主婦ですよね？―いいえ，タクシーの運転手です．	\N		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1538	Hola, ¿qué hay? — ¿Qué hay?	こんにちは，元気？　－こんにちは．	\N		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1539	El agua es un líquido.	水は液体だ．	\N		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1540	La tortuga es un reptil.	カメは爬虫類だ．	\N		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1541	¿Tienes hambre? — No, pero tengo sed.	お腹減ってる？　－　お腹は減ってないけど，のどが渇いた。	\N		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1542	¿Cuántos años (qué edad) tienes? — Tengo 20 (veinte) años.	君は何歳？　－　２０歳。	\N		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1543	La casa tiene dos cuartos de baño.	その家にはトイレが２つある。	\N		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1544	Madrid está en el centro de España.	マドリードはスペインの中央にあります．	\N		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1545	El ordenador es barato. / La computadora es barata.	そのコンピュータは安い．	\N		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1546	Tengo un ordenador japonés. / Tengo una computadora japonesa.	私は日本の（日本製の）コンピュータを持っている．	\N		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1547	Soseki es un gran escritor japonés.	漱石は日本の偉大な作家です．	\N		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1548	¿Dónde es el concierto? — Es en el Teatro Nacional.	そのコンサートはどこでやるんですか？　－　国立劇場ですよ．	\N		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1549	¿A qué hora es la clase? — Es a las nueve.	授業は何時からですか？　－　９時です．	\N		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1550	¿Dónde está el teatro? — Está cerca de la estación de Atocha.	その劇場はどこにあるんですか？　－　アトチャ駅の近くです．	\N		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1551	¿A cuántos estamos? — Estamos a 3 de mayo.	今日は何日？　－　５月３日．	\N		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1552	¿A qué hora llega el avión? — Llega a las cinco de la tarde.	飛行機は何時に到着しますか？　－　午後５時に到着します．	\N		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1553	¿Abro la ventana?— Sí, por favor.	窓を開けましょうか．　－　ええ，お願いします．	\N		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1554	¿Envían ustedes este paquete por avión?— No, enviamos todos estos paquetes por barco.	この小包は航空便で送るんですか？　－　いえ，この小包は全部船便で送ります．	\N		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1555	¡Habla usted muy bien español! — Llevo diez años en España.	スペイン語が大変お上手ですね．　－　スペインに来て１０年になりますから．	\N		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1556	Estoy aquí desde las nueve de la mañana.	私は朝９時からここにいる．	\N		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1557	Pedro lo espera.	ペドロはそれ［バス］を待っている．	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1558	Mamá las toma.	母さんはそれ［薬］を飲んでいる．	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1559	¿Te ayudo? - Sí, gracias.	（君を）手伝おうか？―ええ，ありがとう．	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1560	¿Viene Teresa mañana? — No lo sé.	テレサは明日来るの？―知らない．	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1561	¿Aquí esperamos a Juan y a María? — Sí, los (les) esperamos aquí.	ここでフアンとマリアを待ちましょうか．―ええ，ここで（彼らを）待ちましょう．	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1562	Esta noche llamo a mi novia. — La llamas todas las noches, ¿no?	今夜は恋人に電話をするよ．―毎晩（彼女に）電話してるんだろ？	\N		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1564	Pedro regala unas flores a su novia.　→　Pedro las regala a su novia.	ペドロはそれ［花］を恋人に贈る．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1565	Todos los meses Luisa escribe cartas a sus padres.　→　Todos los meses Luisa las escribe a sus padres.	ルイサは毎月それ［手紙］を両親に書く．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1566	Pedro regala unas flores a su novia.　→　Pedro le regala unas flores.	ペドロは彼女［恋人］に花を贈る．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1567	Todos los meses Luisa escribe cartas a sus padres.　→　Todos los meses Luisa les escribe cartas.	ルイサは毎月彼ら［両親］に手紙を書く．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1568	Te preparo la cena.　→　Te la preparo. （2人称間接目的格＋3人称直接目的格）	君に夕食を作ってあげるよ．　→　君にそれ［夕食］を作ってあげるよ．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1569	Me mandan un paquete.　→　Me lo mandan. （1人称間接目的格＋3人称直接目的格）	（彼らが）私に小包を送ってくる．　→　私にそれ［小包］を送ってくる．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1570	Pedro le regala unas flores.　→　Pedro se las regala. （3人称間接目的格＋3人称直接目的格）	ペドロは彼女［恋人］にそれ［花］を贈る．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1571	Julia manda un paquete a su marido.　→　Julia se lo manda. （3人称間接目的格＋3人称直接目的格）	フリアは彼［夫］にそれ［小包］を送る．	\N		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1572	¿Puedes venir a la fiesta mañana? — Lo siento, no puedo.	明日パーティーに来られる？―悪いけど，行けないよ．	\N		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1573	¿Sabes idiomas? — Sí, sé inglés y francés.	外国語を知ってるの？―うん，英語とフランス語ができるよ．	\N		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1574	¿A qué hora sales de casa? — Salgo a las siete.	何時に家を出るの？―７時に出るよ．	\N		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1575	¿Me das un vaso de agua? — Sí, un momento. Ahora te lo doy.	水を一杯もらえるかな．―うん，ちょっと待ってて．今あげるから．	\N		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1576	¿Cómo vienes a la universidad? — Vengo en tren.	大学へは何で来てるの？―電車で．	\N		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1577	Aquí traigo un regalo para ti. — ¡Qué bien!	君へのプレゼントを持ってきたよ．―うれしい！	\N		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1578	Estos zapatos son italianos.	この靴はイタリア製だ．	\N		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1579	Estas chicas son de Sevilla.	この女の子たちはセビーリャ出身だ．	\N		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1580	¿Quién es aquella chica? — Es la hija del director.	あの女の子は誰？　－　監督の娘さんだよ．	\N		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1581	¿De quién son estos zapatos? — Son de mi marido.	この靴はどなたのですか？　－　私の夫のです．	\N		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1582	¿Ha estado Ud. alguna vez en España?	いままでスペインにいらっしゃったことがありますか？	\N		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1583	Hace cinco años que vivo aquí. (= Vivo aquí desde hace cinco años.) 	私はここに住んで5年になる．　（＝私は5年前からここに住んでいる．）	\N		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1584	Hace dos meses que estoy enfermo. (= Estoy enfermo desde hace dos meses.) 	私はここ2ヶ月ほど病気です．　（＝私は2ヶ月前から病気です．）	\N		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1585	A su noviaPedro le regala unas flores.	恋人にペドロは花を贈る．	\N		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1586	A mí me da un vaso de agua, por favor.	私には水を一杯ください．	\N		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1587	Le escribo a él, pero no a ella.	私は彼には手紙を書くが，彼女には書かない．	\N		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1588	¿Y de beber? — Para mí una cerveza, por favor.	飲み物は？―私はビールをお願いします．	\N		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1589	Conviene revisar el coche antes de salir de viaje.	旅行に行く前に車を点検したほうがいい．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1590	Todavía queda un poquito de leche.	牛乳がまだ少し残っている．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1591	Por aquí pasan muchos taxis.	このあたりはタクシーがたくさん通る．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1592	Se me ha perdido la llave.	鍵をなくしてしまった．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1593	A Pedro se le ha roto la pierna esquiando.	ペドロはスキーをしていて足を骨折してしまった．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1594	En los estancos se venden sellos.	たばこ屋では切手が売られている．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1595	Es imposible terminar el trabajo sólo en un par de días.	その仕事を2，3日で終わらせるなんて無理だ．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1597	Me ha llamado un profesor que conocí el otro día en el congreso.	先日会議で知り合った教授が電話をかけてきた．	\N		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1598	Al profesor lo buscamos desde hace una hora. (× Al profesor buscamos...)	私たちは先生を１時間前から探している．	\N		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1599	Pedro (le) envió unas flores a su novia.	ペドロは恋人に花を送った．	\N		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1600	(Les) mandaré un regalo a mis padres por sus bodas de oro.	両親に金婚式のプレゼントを送ろう．	\N		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1601	Manuel (le) dio un beso a Carmen.	マヌエルはカルメンにキスをした．	\N		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1602	No le gustó a Julia la carta. (× No gustó a Julia la carta.)	フリアはその手紙が気に食わなかった．	\N		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1603	¿A qué te dedicas? — Me dedico a la Informática.	（専門は）何をしてるの？―情報学をやっています．	\N		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1604	Julia se mira en el espejo.	フリアは鏡で自分の姿を見る．	\N		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1605	Teresa y Pablo se respetan uno a otro.	テレサとペドロは互いに尊敬しあっている．	\N		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1606	El niño se cayó de la cama. (cfr. La lluvia cayó con fuerza.)	子供がベッドから落ちた．　（cfr. 雨が強く降り注いだ．）	\N		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1607	Al subir al coche los niños se durmieron en seguida. (cfr. Dormimos sólo cinco horas anoche.)	車に乗るとすぐに子供たちは寝入ってしまった．　（cfr. 私たちは昨夜5時間しか眠らなかった．）	\N		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1608	Julia se lo mandó. (le が変化した se)	フリアは彼／彼女／あなたにそれを送った．	\N		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1609	Julia se lo comió. (再帰代名詞の se)	フリアはそれを食べてしまった．	\N		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1610	En los estancos se venden sellos.	たばこ店で切手が売っています．	\N		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1611	Se construyó este edificio hace dos años.	この建物は2年前に建てられた．	\N		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1612	Últimamente se habla mucho del paro.	最近は失業のことがよく話題にされる．	\N		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1613	¿Sabéis dónde está Luis? — ¿Luis?, ¿qué Luis?	君たち，ルイスがどこにいるか知ってる？　－　ルイスって，どのルイス？	\N		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1614	No sé si me conoce.	彼（彼女・あなた）が私のことを知っているかどうかわかりません．	\N		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1615	¡Qué tonterías dices!	なんて馬鹿なことを言うんだ！	\N		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1616	¡Qué inteligente es Alicia!	アリシアは実に頭がいいなあ！	\N		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1617	¡Qué bien habla!	なんて上手に話すんだろう！	\N		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1618	¿Has dicho algo? — No, no he dicho nada.	何か言った？　－　いや，何も言ってないよ．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1619	¿Ha venido alguien? — No, no ha venido nadie.	誰か来た？　－　いや，誰も来てない．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1620	¿Habéis visto a alguien? — No, no hemos visto a nadie.	（君たちは）誰かに会った？　－　いや，誰にも会わなかった．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1621	¿Ha vuelto alguno (de ellos)? — No, no ha vuelto ninguno.	（彼らのうちの）誰かが帰ってきた？　－　いや，誰も帰ってきてない．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1622	¿Tiene algún problema? — No, no tengo ningún problema.	何か問題はありますか？　－　いえ，何も問題はありません．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1623	¿Has ido alguna vez al museo arqueológico? — No, no he ido nunca.	考古学博物館に行ったことはある？　－　いや，一度もない．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1624	No tengo (ni) su dirección ni su teléfono.	私は彼（彼女・あなた）の住所も電話番号も持っていない（知らない）．	\N		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1625	Juan es más guapo que Pedro.	フアンはペドロよりもかっこいい．	\N		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1626	Hay más chicas que chicos en esta clase.	このクラスは男の子よりも女の子のほうが多い．	\N		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1627	Dentro de cuatro años nos licenciaremos.	私たちは４年で大学を卒業する．	\N		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1628	La chica que ha sacado la mejor nota va a ir a España a estudiar.	一番いい成績をとった女の子は，スペインへ留学に行く．	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1629	El café que suelo tomar es de Colombia.	私がいつも飲むコーヒーはコロンビア産だ．	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1630	¿Quién es aquella chica? — Es la chica con la que sale Gerardo.	あの女の子は誰？　－　ヘラルドが付き合ってる女の子だよ．	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1631	¿Cuál será la razón por la que ese novelista ha dejado de escribir?	その小説家が書くのをやめた理由はなんだろうか？	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1632	Este libro es más divertido que el que compré la semana pasada.	この本は先週買ったのより面白い．	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1633	Las que vinieron ayer son mis hermanas.	昨日来たのは私の姉妹たちだ．	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1634	No entiendo lo que dices.	君の言っていることが理解できない．	\N		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1635	En Japón llueve mucho en junio.	日本では6月によく雨が降る．	\N		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1636	Este año ha nevado mucho.	この冬は雪がたくさん降った．	\N		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1637	Ya anochecía cuando entramos en la ciudad.	私たちが町に入ったときにはもう日が暮れかけていた．	\N		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1638	Todavía es temprano.	まだ早い．	\N		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1640	Ya es de noche.	もう夜です．	\N		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1641	Uno se da cuenta de la importancia que tiene la salud cuando cae enfermo.	病気になると健康の大切さに気がつくものです．	\N		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1642	un libro / una casa	本1冊／家1軒	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1643	veintiún libros / veintiuna casas	本21冊／家21軒	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1644	cien yenes	100円	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1645	ciento noventa horas	190時間	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1647	el número cien	数字100	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1648	doscientos cuarenta y un dólares	241ドル	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1649	quinientas cincuenta mil trescientas personas	55万300人	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1650	un millón de vacas	雌牛100万頭	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1651	dos millones cuatrocientos yenes	240万円	\N		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1652	el segundo curso	2学期	\N		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1653	la quinta sinfonía	交響曲第5番	\N		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1654	la 4ª dimensión	第4次元	\N		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1655	los primeros días del curso	学期の初め	\N		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1656	el siglo VI (sexto)	6世紀	\N		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1657	 el siglo XXI (veintiuno)	21世紀	\N		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1658	¿A cuántos estamos hoy? - Estamos a 12 de octubre.	今日は何月何日ですか？ - １０月１２日です．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1659	¿Qué día del mes hoy? / ¿Qué fecha es hoy? - Es (el) 22.	今日は何日ですか？ - ２２日です．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1660	¿Cuánto es tu cumpleaños? / ¿Cuál es tu fecha de nacimiento?	君の誕生日はいつですか？	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1661	El acuerdo fue firmado el martes 29 de febrero.	協定は2月29日に結ばれた．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1662	¿Qué hora es? - Son las tres y cuarto.	何時ですか？―3時15分です．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1663	¿Tienes hora? - Es la una menos diez. / Faltan diez minutos para la una.	何時ですか（時計持ってますか）？―12時50分（1時10分前／1時まであと10分）です．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1664	Ya son más de las cuatro.	すでに4時過ぎだ．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1665	¿A qué hora llegaste? - A eso de las seis y media.	君は何時に着いたの？―6時半ごろです．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1666	Vinieron a las cinco en punto de la tarde.	彼らは午後5時ちょうどにやって来た．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1667	¿Cuánto (qué) pesas? - Peso 60 kilos.	体重はどのくらいですか？―60キロあります．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1668	¿Cuánto (qué) mide usted? - Uno (Un metro) setenta y tres.	身長はどのくらいですか？―1メートル73センチです．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1669	¿Cuánto años (qué edad) tienes? - Tengo 21 años.	何歳ですか？―21歳です．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1670	¿A cuánto están los tomates? - Están a 2 euros el kilo.	トマトはいくらですか？―1キロ2ユーロです．	\N		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1671	Yo soy estudiante.	私は学生です。	\N		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1672	¿De dónde eres tú? - Soy de Tokio.	君の出身は？―私は東京の出身です。	\N		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1673	¿De dónde es Ud.? - Soy de Kyoto.	あなたのご出身は？―私は京都の出身です。	\N		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1674	¿De qué curso sois vosotros? - Nosotros somos de primero.	君たちは何年生？―1年生です．	\N		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1675	Yo soy estudiante.	私は学生です．	\N		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1676	Javier es inteligente.	ハビエルは頭がいいです．	\N		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1677	¿De dónde sois?  - Somos de Barcelona.	君たちはどこの出身ですか？―バルセロナの出身です．	\N		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1678	¿De qué curso eres?  - Soy de primero.	君は何年生ですか？―1年生です．	\N		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1679	¿Es Vd. profesora?  - No, soy intérprete.	あなたは先生ですか？―いいえ，私は通訳です．	\N		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1680	¿María es abogada?  - No, no es abogada.	マリアは弁護士ですか？―いいえ，弁護士ではありません．	\N		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1681	¿No eres historiador?  - No, yo soy periodista.	君は歴史学者ではないのですか？―いいえ，私は記者です．	\N		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1682	¿Es Pedro policía?  - Sí, y Laura también.	ペドロは警官なのですか？―ええ，ラウラもそうです．	\N		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1683	¿Qué es Juan?  - Es juez.	フアンの職業は何ですか？―判事です．	\N		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1684	Luisa es ama de casa, ¿verdad?  - No, es taxista.	ルイサは主婦ですよね？―いいえ，タクシーの運転手です．	\N		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[1]		0	1
1685	¿Qué tienes ahí? — Tengo un lápiz, una agenda y un abrecartas.	そこに何を持ってるの？―鉛筆と，手帳と，ペーパーナイフ．	\N		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1686	Fernando es periodista. Y ¿Raquel? — Ella también es periodista.	フェルナンドは記者です．ラケルは？―彼女も記者です．	\N		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1687	Dos tés con limón y tres cafés con leche, por favor.	レモンティーを２つと，カフェオレを３つください．	\N		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1688	Teresa y Ramón son mexicanos. 	テレサとラモンはメキシコ人です．	\N		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1689	Aquí hay un diccionario.	ここに辞書がある．	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1690	Allí no hay agua ni electricidad.	そこには水も電気もない．	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1691	Hola, ¿qué hay? — ¿Qué hay?	こんにちは，元気？　－こんにちは．	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1692	¿Qué hay sobre la mesa? — Hay un florero.	テーブルの上には何がありますか？　－　花瓶があります．	\N		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1693	¿De quién es el diccionario? — Es de Pepe.	その辞書は誰の？　－　ペペのだよ．	\N		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1694	El agua es un líquido.	水は液体だ．	\N		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1695	La tortuga es un reptil.	カメは爬虫類だ．	\N		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1696	Hay un puente al lado de la casa.	家の横には橋がある．	\N		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1697	Hay unas revistas sobre el estante.	棚の上に雑誌が何冊かある．	\N		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1732	Mamá las toma.	母さんはそれ［薬］を飲んでいる．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1698	Hay unas cien casas alrededor de la central nuclear.	原子力発電所の周囲に約１００軒の家がある．	\N		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1699	¿Qué tienes ahí? — Tengo un lápiz, una agenda y un abrecartas.	そこに何を持っているの？　－　鉛筆と，手帳と，ペーパーナイフ．	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1700	¿Tienes hambre? — No, pero tengo sed.	お腹減ってる？　－　お腹は減ってないけど，のどが渇いた。	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1701	¿Cuántos años tienes? — Tengo 20 (veinte) años.	君は何歳？　－　２０歳。	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1702	La casa tiene dos cuartos de baño.	その家にはトイレが２つある。	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1703	La sopa está caliente.	そのスープは熱い．	\N		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1704	La profesora Márquez está en casa.	マルケス先生は家にいます（在宅です）．	\N		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1705	Madrid está en el centro de España.	マドリードはスペインの中央にあります．	\N		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1706	Tengo un ordenador barato.	私は安いコンピュータを持っている．	\N		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1707	Tengo una computadora barata.	私は安いコンピュータを持っている．	\N		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1708	Tengo un ordenador grande.	私は大きなコンピュータを持っている．	\N		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1709	Tengo una computadora grande.	私は大きなコンピュータを持っている．	\N		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1710	Tengo un ordenador japonés.	私は日本の（日本製の）コンピュータを持っている．	\N		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1711	Tengo una computadora japonesa.	私は日本の（日本製の）コンピュータを持っている．	\N		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1713	Roberto es un buen chico.— Sí, es un chico muy bueno.	ロベルトはいいやつだ．―うん，すごくいいやつだよ．	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1714	Soseki es un gran escritor japonés.	漱石は日本の偉大な作家です．	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1715	¿Es buena la película? — No, es mala. Es muy aburrida.	その映画は良い（おもしろい）？　－　いや，よくないよ．すごく退屈だ．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1716	¿Cómo son Isabel y Fernando? — Son amables, pero un poco egoístas.	イサベルとフェルナンドはどんな人たち？　－　親切だけど，少し自分勝手だ．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1717	¿Está buena la sopa? — Sí, está muy rica.	そのスープはおいしい？　－　うん，すごくおいしいよ．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1718	¿Cómo están Isabel y Fernando? —¡Huy, están furiosos!	イサベルとフェルナンドはどんな様子？　－　いやー，怒ってるよ！	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1719	¿Dónde es el concierto? — Es en el Teatro Nacional.	そのコンサートはどこでやるんですか？　－　国立劇場ですよ．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1720	¿A qué hora es la clase? — Es a las nueve.	授業は何時からですか？　－　９時です．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1721	¿Dónde está el teatro? — Está cerca de la estación de Atocha.	その劇場はどこにあるんですか？　－　アトチャ駅の近くです．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1722	¿A cuántos estamos? — Estamos a 3 de mayo.	今日は何日？　－　５月３日．	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1723	¿Hablas español? — Sí, hablo español y japonés.	君はスペイン語が話せるの？　－　うん，スペイン語と日本語が話せるよ．	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1724	¿Dónde vivís?— Vivimos en la ciudad de Saitama, al norte de Tokio.	君たちはどこに住んでるの？　－　東京の北にある，さいたま市に住んでるよ．	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1725	¿A qué hora llega el avión? — Llega a las cinco de la tarde.	飛行機は何時に到着しますか？　－　午後５時に到着します．	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1726	¿Abro la ventana?— Sí, por favor.	窓を開けましょうか．　－　ええ，お願いします．	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1727	¡Habla usted muy bien español! — Llevo diez años en España.	スペイン語が大変お上手ですね．　－　スペインに来て１０年になりますから．	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1728	Estoy aquí desde las nueve de la mañana.	私は朝９時からここにいる．	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1729	Pedro espera el autobús.	ペドロはバスを待っている．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1730	Mamá toma las pastillas.	母さんは薬を飲んでいる．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1731	Pedro lo espera.	ペドロはそれ［バス］を待っている．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1733	¿Te ayudo? - Sí, gracias.	（君を）手伝おうか？―ええ，ありがとう．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1734	¿Viene Teresa mañana? — No lo sé.	テレサは明日来るの？―知らない．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1735	¿Aquí esperamos a Juan y a María? — Sí, los esperamos aquí.	ここでフアンとマリアを待ちましょうか．―ええ，ここで（彼らを）待ちましょう．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1736	Esta noche llamo a mi novia. — La llamas todas las noches, ¿no?	今夜は恋人に電話をするよ．―毎晩（彼女に）電話してるんだろ？	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1737	Buscamos una secretaria.	私たちは秘書を募集しています．	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[1]		0	1
1738	Escribo a mi novia todas las semanas.	私は恋人に毎週手紙を書く．	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1740	Alfonso siempre nos habla en español.	アルフォンソはいつも私たちにスペイン語で話しかけてくる．	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1741	Cuando le escribo, me contesta en seguida.	私が彼女［恋人］に手紙を書くと，すぐに私に返事してくれる．	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1742	Pedro regala unas flores a su novia.	ペドロは花を恋人に贈る．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1743	Todos los meses Luisa escribe cartas a sus padres.	ルイサは毎月手紙を両親に書く．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1744	Pedro regala unas flores a su novia.　→　Pedro las regala a su novia.	ペドロはそれ［花］を恋人に贈る．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1745	Todos los meses Luisa escribe cartas a sus padres.　→　Todos los meses Luisa las escribe a sus padres.	ルイサは毎月それ［手紙］を両親に書く．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1746	Pedro regala unas flores a su novia.　→　Pedro le regala unas flores.	ペドロは彼女［恋人］に花を贈る．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1747	Todos los meses Luisa escribe cartas a sus padres.　→　Todos los meses Luisa les escribe cartas.	ルイサは毎月彼ら［両親］に手紙を書く．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1748	Te preparo la cena.　→　Te la preparo. （2人称間接目的格＋3人称直接目的格）	君に夕食を作ってあげるよ．　→　君にそれ［夕食］を作ってあげるよ．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1749	Me mandan un paquete.　→　Me lo mandan. （1人称間接目的格＋3人称直接目的格）	（彼らが）私に小包を送ってくる．　→　私にそれ［小包］を送ってくる．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1750	Pedro le regala unas flores.　→　Pedro se las regala. （3人称間接目的格＋3人称直接目的格）	ペドロは彼女［恋人］にそれ［花］を贈る．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[1]		0	1
1751	Julia manda un paquete a su marido.　→　Julia se lo manda. （3人称間接目的格＋3人称直接目的格）	フリアは彼［夫］にそれ［小包］を送る．	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[2]		0	1
1752	¿Qué quieres? — Yo quiero paella. — Entonces, pedimos una paella para los dos.	何が食べたい？―私はパエリヤが食べたい．　―じゃあ，二人分のパエリヤをひとつ頼もう．	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1753	¿Juegan ustedes al tenis? — Sí, aunque jugamos mal, nos divierte mucho jugar al tenis.	あなた方はテニスをされますか．―ええ，上手ではありませんが，大変楽しくテニスをプレーしていますよ．	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1754	¿Cuántas horas duermes generalmente? —Generalmente duermo cinco o seis horas.	君は普段は何時間寝てるの？―普段は5～6時間寝てるよ．	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1755	¿Qué quieres hacer este fin de semana? — Quiero ir al cine a ver una película argentina.	今週末は何をしたい？―映画館にアルゼンチンの映画を見に行きたいな．	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1756	¿Puedes venir a la fiesta mañana? — Lo siento, no puedo.	明日パーティーに来られる？―悪いけど，行けないよ．	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1757	¿Conoces a Juan? — No, no lo conozco mucho.	フアンを知ってる？―いや，あまりよく知らない．	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1758	¿Sabes idiomas? — Sí, sé inglés y francés.	外国語を知ってるの？―うん，英語とフランス語ができるよ．	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1759	¿A qué hora sales de casa? — Salgo a las siete.	何時に家を出るの？―７時に出るよ．	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1760	¿Me das un vaso de agua? — Sí, un momento. Ahora te lo doy.	水を一杯もらえるかな．―うん，ちょっと待ってて．今あげるから．	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1761	¿A dónde vais? — Vamos al despacho del profesor.	君たちどこに行くの？―先生の研究室に行くんだ．	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1762	¿A dónde lleva usted esos libros? — Los llevo a la biblioteca.	その本をどちらへ持っていくんですか？―図書館へ持っていきます．	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1763	¿Cómo vienes a la universidad? — Vengo en tren.	大学へは何で来てるの？―電車で．	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1764	Aquí traigo un regalo para ti. — ¡Qué bien!	君へのプレゼントを持ってきたよ．―うれしい！	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1765	¿Qué vas a hacer esta tarde? — Voy a estudiar porque mañana tengo un examen.	今日の午後は何をするの？―明日試験があるから勉強するよ．	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1766	¿Tienes que ir a clase mañana? — No, mañana no tengo que ir.	明日は授業に行かなきゃいけないの？―いや，明日は行かなくてもだいじょうぶ．	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1767	Debéis aprender estos verbos irregulares, porque son muy frecuentes.	これらの不規則動詞は覚えなければいけないよ，とてもよく出てくるから．	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1768	Este libro es muy divertido.	この本はとても面白い．	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1769	Esta silla es muy cómoda.	この椅子はとても座り心地がいい．	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1770	Estos zapatos son italianos.	この靴はイタリア製だ．	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1771	Estas chicas son de Sevilla.	この女の子たちはセビリャ出身だ．	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1772	¿Quién es aquella chica? — Es la hija del director.	あの女の子は誰？　－　監督の娘さんだよ．	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1773	Este bolso es de tela, y ése es de piel.	このカバンは布製で，それ（そのカバン）は革製だ．	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1774	Esta silla es incómoda, pero ésa es muy cómoda.	この椅子は座り心地がよくないが，その椅子はすごくいい．	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1775	Ésta es mi mujer y éstos son mis padres.	こちらが私の妻で，こちらは私の両親です．	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1776	¿Qué es eso? — ¿Esto? Es un nuevo CD de Paco de Lucía.	何それ？　－　これ？パコ・デ・ルシアの新しいCDだよ．	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1777	Esto es para ti. — Gracias.	これは君にあげるよ．　－　ありがとう．	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1778	¿De quién son estos zapatos? — Son de mi marido.	この靴はどなたのですか？　－　私の夫のです．	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1780	¿Quién es esa chica? ¿Tu novia? — No, es una amiga mía.	その女の子は誰？君の彼女かい？　－　違うよ，友達だよ．	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1781	¿Esta bici es de Pedro? — Sí, es suya.	この自転車はペドロの？　－　そうだよ，彼のだよ．	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1782	Aquí están nuestros pasaportes. ¿Dónde está el suyo?	私たちのパスポートはここにある．彼女のはどこだ？	\N		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1783	¿Ha leído Ud. ya este libro?	あなたはもうこの本を読みましたか？	\N		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1784	¿Ha estado Ud. alguna vez en España?	いままでスペインにいらっしゃったことがありますか？	\N		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1785	Cuando le escribo a ella, me contesta en seguida.	私が彼女に手紙を書くと，すぐに返事が来る．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1786	Les mando regalos de Navidad a ustedes.	私はクリスマスプレゼントをあなたがたに送る．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1787	Pedro le da un beso a su novia.	ペドロは恋人にキスをする．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1788	Julia les envía un paquete a sus padres.	フリアは両親に小包を送る．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1789	A su noviaPedro le regala unas flores.	恋人にペドロは花を贈る．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1790	A mí me da un vaso de agua, por favor.	私には水を一杯ください．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1791	Le escribo a él, pero no a ella.	私は彼には手紙を書くが，彼女には書かない．	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1792	Todos tus colegas hablan bien de ti.	君の同僚はみんな君のことをほめている．	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1793	¿Y de beber? — Para mí una cerveza, por favor.	飲み物は？―私はビールをお願いします．	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1794	Voy a salir de compras con ella esta tarde.	今日の午後彼女と買い物に出かける．	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1795	María ya no quiere salir conmigo.	マリアはもう私と付き合いたくない．	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1796	Me gustan las manzanas.	私はリンゴが好きです．	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1797	Me gustan estos zapatos.	私はこの靴が好きだ（気に入っている）．	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1798	¿Te gusta el vino? — Sí, me gusta mucho.	ワインは好き？―ええ，大好きです．	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1799	A mi hermana no le gusta viajar en avión.	私の姉［妹］は飛行機で旅行するのが嫌いだ．	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1800	¿Por qué no viene Pablo? — Porque a él no le gustan las fiestas.	パブロはどうして来ないの？―パーティーが嫌いだからです．	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1801	A mi hija le asustan los truenos.	うちの娘は雷を怖がる．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1802	Le disgustaba quedarse sola.	彼女は一人になるのを嫌がっていた．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1803	A los españoles les interesa mucho la política.	スペイン人は政治にとても関心がある．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1804	A los padres les preocupa mucho la educación de los niños.	親は子供の教育をとても心配する．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1805	Faltan dos meses para las Olimpiadas.	オリンピックまであと2ヶ月だ．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1806	Aunque me sobra tiempo me falta dinero.	時間はありあまっているが金がない．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1807	No hace falta avisarles de antemano.	彼ら［彼女ら／あなたがた］に事前に連絡する必要はない．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1808	Conviene revisar el coche antes de salir de viaje.	旅行に行く前に車を点検したほうがいい．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]		0	1
1809	Todavía queda un poquito de leche.	牛乳がまだ少し残っている．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[5]		0	1
1810	Por aquí pasan muchos taxis.	このあたりはタクシーがたくさん通る．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[6]		0	1
1811	Señora, se le ha caído el pañuelo.	奥さん，ハンカチが落ちましたよ．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1812	Se me ha perdido la llave.	鍵をなくしてしまった．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1813	A Pedro se le ha roto la pierna esquiando.	ペドロはスキーをしていて足を骨折してしまった．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]		0	1
1814	En los estancos se venden sellos.	たばこ屋では切手が売られている．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1815	Es imposible terminar el trabajo sólo en un par de días.	その仕事を2，3日で終わらせるなんて無理だ．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1816	¿Te importa que vaya a verte esta tarde?	今日の午後君に会いに行ってもいい？	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[3]		0	1
1817	Me ha llamado un profesor que conocí el otro día en el congreso.	先日会議で知り合った教授が電話をかけてきた．	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[4]		0	1
1818	A ti te vieron ayer en el aparcamiento.	君を昨日彼らが駐車場で見た．	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1819	Anteayer me buscaron a mí en la estación.	おととい彼らが私を駅で探していた．	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1820	Al profesor lo buscamos desde hace una hora. 	私たちは先生を１時間前から探している．	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1821	Busqué a Pedro por todas partes.	ペドロをそこらじゅう探し回った．	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1822	Buscamos al profesor desde hace una hora.	私たちは先生を１時間前から探している．	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1823	¿A ti te gusta la comida española? — Sí, me gusta mucho.	スペイン料理は好き？―うん，大好きだよ．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1824	A ella ya le contesté ayer.	彼女にはもう昨日返事をした．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1825	Le escribí a él, no a ella.	彼に手紙を書いたのであって，彼女にではない．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1826	A mis padres les mandaré un regalo por sus bodas de oro.	両親に金婚式のプレゼントを送ろう．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1827	A todos mis colegas ya les mandé tarjetas de Navidad.	同僚全員にもうクリスマスカードを送った．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1828	Pedro le envió unas flores a su novia.	ペドロは恋人に花を送った．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1829	Les mandaré un regalo a mis padres por sus bodas de oro.	両親に金婚式のプレゼントを送ろう．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1830	Manuel le dio un beso a Carmen.	マヌエルはカルメンにキスをした．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]		0	1
1831	No le gustó a Julia la carta.	フリアはその手紙が気に食わなかった．	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1832	Generalmente me levanto a las siete y media, y me acuesto a las once.	普段私は7時半に起きて，11時に寝ます．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1833	El abuelo se sentó en el sofá y se puso a leer el periódico.	祖父はソファーに座って新聞を読み始めた．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1834	La puerta se abre y se cierra sola.	そのドアはひとりでに開閉する．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1835	¿A qué te dedicas? — Me dedico a la Informática.	（専門は）何をしてるの？―情報学をやっています．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1836	Julia se mira en el espejo.	フリアは鏡で自分の姿を見る．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1837	A veces me pregunto por qué esto es así.	ときどき私はどうしてこうなのかと自問することがある．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1838	No me lavé las manos antes de comer.	私は食べる前に手を洗わなかった．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1839	Como hace mucho frío me pongo el abrigo para salir.	とても寒いので，出かけるためにコートを着る．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1840	¿Os escribís con frecuencia?	君たちは（お互いに）よく手紙を書くの？	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1841	Teresa y Pablo se respetan uno a otro.	テレサとペドロは互いに尊敬しあっている．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1842	Pedro se comió una paella entera para cenar. 	ペドロは夕食にパエリヤひと皿を全部食べてしまった．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1843	Ya se han llevado toda la basura. 	ごみはもう全部持っていかれてしまった．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1844	¿Ya te vas? — Sí, ya me voy. 	もう帰るの？―うん，もう帰るよ．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[3]		0	1
1845	El niño se cayó de la cama. 	子供がベッドから落ちた．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[4]		0	1
1846	Al subir al coche los niños se durmieron en seguida.	車に乗るとすぐに子供たちは寝入ってしまった．	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[5]		0	1
1847	Julia se lo mandó.	フリアは彼／彼女／あなたにそれを送った．	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1848	Julia se lo comió.	フリアはそれを食べてしまった．	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1849	Julia siempre habla de sí misma.	フリアはいつも自分のことばかり話している．	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1850	Paco se llevó consigo todo el dinero guardado en la caja.	パコは金庫にしまってあったお金を全部持っていった．	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1851	En España se consume mucho aceite de oliva.	スペインではオリーブオイルがよく消費される．	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1852	Se alquilan apartamentos.	賃貸アパートあり（アパートが貸し出されている）．	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1853	Se prohíbe fumar. (掲示)	禁煙（タバコを吸うことが禁じられている）．	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1854	En los estancos se venden sellos.	たばこ店で切手は売っています．	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1855	Se construyó este edificio hace dos años.	この建物は2年前に建てられた．	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1856	Se come bien en este restaurante.	このレストランはおいしい（おいしく食べられる）．	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1857	¿Cuánto tiempo se tarda de aquí a la universidad? — Se tarda aproximadamente una hora.	ここから大学までどのくらい時間がかかる？―だいたい１時間かかるよ．	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1858	¿Se puede pasar? — Sí, adelante.	入ってよろしいですか？　―　ええ，どうぞ．	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1859	Últimamente se habla mucho del paro.	最近は失業のことがよく話題にされる．	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1860	Ahora no se respeta a los ancianos como antes.	今は以前ほどお年寄りを大切にしない．	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1861	En este hotel se recibe a los clientes a partir de las tres de la tarde.	このホテルは午後3時からチェック･インを受け付けております．	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1862	¿Qué buscas?— Busco las llaves.	何を探してるの？―鍵を探してるんだよ．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1863	¿A quién buscas?— Busco a mis padres.	誰を探してるの？　－　両親を探してるんだ．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1864	¿Cuáles son las ventajas de saber idiomas? — Pues, poder viajar por todo el mundo.	ことば（外国語）を知っていることの利点は何ですか？　－　そうですね，世界中を旅することができることです．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1865	¿Cómo quiere usted la carne, muy hecha o poco hecha? —Normal.	肉はどうなさいますか，ウェルダンですか，レアですか？　－　普通で．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1866	¿Desde cuándo estudias español? — Desde hace un año.	いつからスペイン語を勉強してるの？　－　１年前から．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1867	¿Por qué trabajas tanto? — Porque no tengo dinero.	どうしてそんなに働くの？　－　お金がないからだよ．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]		0	1
1868	¿Qué tal si vamos al cine esta tarde? —De acuerdo.	今日の午後映画に行かない？　－　いいよ．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[5]		0	1
1869	¿Sabéis dónde está Luis? — ¿Luis?, ¿qué Luis?	君たち，ルイスがどこにいるか知ってる？　－　ルイスって，どのルイス？	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1870	No sé si me conoce.	彼（彼女・あなた）が私のことを知っているかどうかわかりません．	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1871	¡Qué hombre más pesado!	なんてしつこい男だ！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1872	¡Qué tonterías dices!	なんて馬鹿なことを言うんだ！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1873	¡Qué inteligente es Alicia!	アリシアは実に頭がいいなあ！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1874	¡Qué bien habla!	なんて上手に話すんだろう！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1875	¡Cómo bailas!	君はなんて踊りがうまいんだ！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1876	¡Cuánto te lo agradezco!	君にはどれほど感謝していることか！	\N		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1878	¿Has dicho algo? — No, no he dicho nada.	何か言った？　－　いや，何も言ってないよ．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1879	¿Ha venido alguien? — No, no ha venido nadie.	誰か来た？　－　いや，誰も来てない．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1880	¿Habéis visto a alguien? — No, no hemos visto a nadie.	（君たちは）誰かに会った？　－　いや，誰にも会わなかった．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1881	¿Ha vuelto alguno de ellos? — No, no ha vuelto ninguno.	彼らのうちの誰かが帰ってきた？　－　いや，誰も帰ってきてない．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1882	¿Tiene algún problema? — No, no tengo ningún problema.	何か問題はありますか？　－　いえ，何も問題はありません．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1883	¿Has ido alguna vez al museo arqueológico? — No, no he ido nunca.	考古学博物館に行ったことはある？　－　いや，一度もない．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1884	No tengo ni su dirección ni su teléfono.	私は彼（彼女・あなた）の住所も電話番号も持っていない（知らない）．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1885	Nunca tomo café por la noche.	私は夜は決してコーヒーを飲まない．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1886	Nadie puede hablar bien un idioma sin estudiar.	勉強しなければ誰もことばをうまく話すことはできない．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1887	A mí no me gusta el flamenco. — A mí tampoco me gusta.	私はフラメンコは好きではない．　－　私も好きではない．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1888	Los japoneses no usan cubiertos sino palillos.	日本人はナイフとフォークではなく箸を使う．	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1889	Juan es más guapo que Pedro.	フアンはペドロよりもかっこいい．	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1890	Hay más chicas que chicos en esta clase.	このクラスは男の子よりも女の子のほうが多い．	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1891	Fernando era tan tonto como Isabel.	フェルナンドはイサベルと同じくらいばかだった．	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1892	Hay tantas chicas como chicos en esta clase.	このクラスには男の子と女の子が同じくらいいる．	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1893	Tiene más de 70 años.	（彼・彼女は）７０歳以上だ．	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1894	Ana es más lista de lo que crees.	アナは君が思うより利口だ．	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1895	¿Diego es mayor o menor que tú? — Ni mayor ni menor. Somos de la misma edad.	ディエゴは君より年上，それとも年下？　－　年上でも年下でもないよ．同い年だ．	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1896	Tu casa es más grande que la mía.	君の家は私のよりも大きい．	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1897	Jaime es el más gordo de los hermanos.	ハイメは兄弟のなかで一番太っている．	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1898	El Teide es la montaña más alta de España.	テイデ山はスペインで一番高い山だ．	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1899	Durante las vacaciones de verano estudiaré español todos los días.	夏休み中は毎日スペイン語を勉強するつもりだ．	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1900	Si no te das prisa, llegarás tarde a clase.	急がないと授業に遅れるよ．	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1901	Dentro de cuatro años nos licenciaremos.	私たちは４年で大学を卒業する．	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1902	¿De dónde es María José? — No sé. Será de algún país hispanoamericano.	マリア・ホセはどこの出身？―知らない．どこかラテンアメリカの国の出身だろう．	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1903	(¡Ring, ring!) — ¡Huy, el teléfono! ¿Quién será a estas horas?	（リーン！）―おや，電話だ！こんな時間に誰だ？	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1904	Carlos me dijo que me llamaría, pero aún no me ha llamado.	カルロスは私に電話するといったが，まだ電話はない．	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1905	Ya sabía que vendrías a pedirme ayuda.	君が私に助けを求めに来ることはわかっていた．	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1906	Probablemente, el ladrón entraría por la ventana de la cocina y saldría por la puerta.	おそらく泥棒はキッチンの窓から入ってドアから出たのだろう．	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1907	La tierra está mojada; ¿llovería anoche?	地面が濡れている．昨夜雨が降ったんだろうか．	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1908	La chica que ha sacado la mejor nota va a ir a España a estudiar.	一番いい成績をとった女の子は，スペインへ留学に行く．	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1909	El café que suelo tomar es de Colombia.	私がいつも飲むコーヒーはコロンビア産だ．	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1910	¿Quién es aquella chica? — Es la chica con la que sale Gerardo.	あの女の子は誰？　－　ヘラルドが付き合ってる女の子だよ．	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1911	¿Cuál será la razón por la que ese novelista ha dejado de escribir?	その小説家が書くのをやめた理由はなんだろうか？	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1912	Este libro es más divertido que el que compré la semana pasada.	この本は先週買ったのより面白い．	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1913	Las que vinieron ayer son mis hermanas.	昨日来たのは私の姉妹たちだ．	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1914	No entiendo lo que dices.	君の言っていることが理解できない．	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]		0	1
1915	En Japón llueve mucho en junio.	日本では6月によく雨が降る．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1916	Este año ha nevado mucho.	この冬は雪がたくさん降った．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1917	Ya anochecía cuando entramos en la ciudad.	私たちが町に入ったときにはもう日が暮れかけていた．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1918	¿Qué tiempo hace hoy?— Hace buen tiempo.	今日はどんな天気ですか？―いい（悪い）天気ですよ．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1919	Ayer hizo mucho frío.	昨日はとても寒かった．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1920	Este verano ha hecho un calor insoportable.	この夏は耐えがたい暑さだった．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1921	Hoy está nublado.	今日は曇っている．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]		0	1
1922	Todavía es temprano.	まだ早い．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[5]		0	1
1923	Ya es tarde.	もう遅い．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[6]		0	1
1924	Ya es de noche.	もう夜です．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[7]		0	1
1925	¿Cuántos años hace que juegas al fútbol? — Hace cinco años que juego al fútbol.	サッカーを何年やってるの（サッカーをして何年になりますか）？―サッカーを5年やっています（サッカーをして5年になります）．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1926	Hay que hacer deporte para mantenerse en forma.	健康を保つにはスポーツをしなくてはならない．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1927	No hay que conducir borracho.	酔っ払って運転をしてはいけない．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1928	No hay que llevar regalos a todos.	全員にプレゼントを持ってくる必要はない．	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[3]		0	1
1929	Llaman a la puerta.	（戸口でベルが鳴ったり，ノックの音がするのを聞いて）誰か来たよ．	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1930	Me han robado la cámara.	カメラを盗まれた．	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1931	En los exámenes me han suspendido en dos asignaturas.	試験で2科目を落とした．	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1932	Comen mucho arroz en Japón.	日本では米をよく食べる．	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1933	Cuando tienes hambre, no puedes pensar.	お腹が減っているときは考えることができない．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1934	Si vives en el extranjero, debes aprender las costumbres del país.	外国に住むのなら，その国の習慣を学ばなければいけない．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1935	El AVE te lleva a Sevilla en dos horas y media.	AVE［スペインの新幹線］ならセビージャまで2時間半で着けます．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1936	En nuestro país cuando entramos en casa, nos quitamos los zapatos.	日本［わが国］では家に入るとき靴を脱ぎます．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1937	Antes respetábamos más a los ancianos.	以前はもっとお年寄りを敬っていました．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1938	En esta empresa a uno le pagan bien si trabaja mucho.	この会社では，たくさん働けば良い給料がもらえる．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1939	Cuando una es madre, lo sacrifica todo por los hijos.	母親になると子どものためにすべてを犠牲にする．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1940	Uno se da cuenta de la importancia que tiene la salud cuando cae enfermo.	病気になると健康の大切さに気がつくものです．	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]		0	1
1941	un libro / una casa	本1冊／家1軒	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1942	veintiún libros / veintiuna casas	本21冊／家21軒	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1943	veintiún mil toneladas	21万トン	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1944	cien yenes	100円	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1945	ciento noventa horas	190時間	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1946	cien mil	10万	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]		0	1
1947	el número cien	数字100	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]		0	1
1948	doscientos cuarenta y un dólares	241ドル	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]		0	1
1949	quinientas cincuenta mil trescientas personas	55万300人	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]		0	1
1950	setecientos millones de personas	7億人	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]		0	1
1951	un millón de vacas	雌牛100万頭	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]		0	1
1952	dos millones cuatrocientos yenes	240万円	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]		0	1
1953	el segundo curso	2学期	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1954	la quinta sinfonía	交響曲第5番	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1955	la 4ª dimensión	第4次元	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1956	los primeros días del curso	学期の初め	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1957	el siglo VI (sexto)	6世紀	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
1958	 el siglo XXI (veintiuno)	21世紀	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]		0	1
1959	¿A cuántos estamos hoy? - Estamos a 12 de octubre.	今日は何月何日ですか？	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1960	¿Qué día del mes es hoy?  - Es 22.	今日は何日ですか？	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1961	¿Cuál es tu fecha de nacimiento?	君の誕生日はいつですか？	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1962	El acuerdo fue firmado el martes 29 de febrero.	協定は2月29日に結ばれた．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1963	¿Qué hora es? - Son las tres y cuarto.	何時ですか？―3時15分です．	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]		0	1
555	Te llamaré a las seis para que me digas si puedes venir.	６時に電話をするから，来られるかどうか教えてくれ．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
530	Será mejor que vayamos en avión.	私たちは飛行機で行ったほうがよさそうだ．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
561	¿Por qué no te alojas en mi casa mientras estés de vacaciones?	休暇中は私の家に泊まったらどうだい？	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]	\N	\N	1
557	En caso de que llueva, aplazaremos el viaje hasta el próximo fin de semana.	雨が降った場合は，旅行は次の週末に延期します．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
575	¡Que tengáis buen viaje!	よい旅を！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[2]	\N	\N	1
565	Aunque sea japonés, no le gusta el pescado crudo.	(断言をやわらげて) 彼はなるほど日本人かもしれないが，刺身がきらいだ．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
582	Corre, corre, que se va el autobús.	走れ，走れ，バスが行ってしまうぞ．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
499	Sonó el teléfono cuando íbamos a salir.	私たちが出かけようとしていたときに電話が鳴った．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	1
521	El jefe me ha dicho que no use el teléfono para hablar con los amigos.	上司は私に，友人と話すのにその電話を使わないようにといった．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
564	Aunque es japonés, no le gusta el pescado crudo.	彼は日本人なのだが，刺身がきらいだ．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
509	¿Qué estáis haciendo? — Estamos limpiando la casa.	君たち何をしてるの？　－　家を掃除してるんだよ．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]	\N	\N	1
501	Hacía tres años que estudiaba español en México cuando tuvo que volver a Japón.	（彼／彼女は）日本へ戻らねばならなくなったときには，メキシコでスペイン語を勉強して３年になっていた．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
591	Venga, levantaos, que ya son las ocho y media.	さあ，起きて，もう８時半だよ．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[4]	\N	\N	1
498	Quería preguntarte una cosa, pero se me ha olvidado.	君に聞きたいことがあったんだけど，忘れちゃったよ．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
542	Cuando me lo preguntaron yo no estaba segura de que pudiéramos ir.	彼ら／彼女ら／あなたがたに聞かれたときには，私たちが行けるかどうか私には自信がなかった．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
511	Paseando por la Gran Vía, me encontré con unos amigos.	グラン・ビアを歩いていたら，友達に会った．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
494	Cuando entré en el aula, no había nadie.	私が教室に入ったときには，誰もいなかった．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
497	Cuando era estudiante, me levantaba muy tarde.	学生だった頃，私は朝とても遅く起きていた．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
490	¿Qué te dijo la profesora? — Que no hice muy bien en el examen.	先生何て言ってたの？　－　私のテストの成績がよくなかったって．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
502	Lo importante es contestarles cuanto antes.	大事なことはできるだけ早く彼ら／彼女らに返事をすることだ．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
553	Estamos buscando una casa que esté cerca de la estación.	私たちは駅の近くにある家を探している．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
512	Corriendo, puedes coger el tren de las tres.	走れば３時の電車に間に合うぞ．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	1
549	Hace cincuenta años no era raro que los trenes llegasen con retraso.	５０年前には電車が遅れて来るのは珍しいことではなかった．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]	\N	\N	1
592	¿Se puede? — Sí, pase, pase.	（入って）よろしいですか？　－　ええ，どうぞお入りください．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]	\N	\N	1
482	¿A qué hora llegaste a casa el otro día? — Llegué a eso de las doce.	この前は何時に家に着いたの？　－　１２時くらい．	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
559	Le enviaremos el paquete por avión a no ser que resulte demasiado costoso.	費用がかかりすぎることがないように，航空便で彼／彼女／あなたに小包を送ります．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]	\N	\N	1
588	Siéntense, por favor.	どうぞおかけください．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
504	Se asomó a la ventana para contemplar el paisaje.	彼／彼女は景色を眺めるために窓から顔を出した．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
556	Pedro cerró las ventanas para que no entrasen bichos.	ペドロは虫が入ってこないように窓を閉めた．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	1
475	Hace cinco años que vivo aquí.	私はここに住んで5年になる．	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[1]	\N	\N	1
584	Cerrad la puerta.	ドアを閉めろ．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
560	En cuanto sepa algo de él, te avisaré.	彼のことで何かわかったらすぐに君に知らせるよ．	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]	\N	\N	1
486	Yo pedí carne y Sofía pidió pescado.	私は肉を頼み（注文し），ソフィアは魚を頼んだ．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
552	¿Hay alguien que haya estado en Quito?	キトに行ったことがある人はいますか？	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
531	Es extraño que nadie hable de ese asunto.	誰もその件について話をしないなんておかしい．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
535	Puede que les haya tocado el premio gordo.	彼ら／彼女らは一等賞が当たったのかもしれない．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
513	Siendo joven, tiene canas.	若いのに白髪がある．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]	\N	\N	1
495	Yo antes fumaba mucho, pero ahora no fumo nada.	私は以前はたくさんタバコを吸っていたが，今はまったく吸わない．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
526	Me temo que hoy haya mucho tráfico en la autopista.	今日は高速道路の交通量が多いのではないかと不安だ．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
550	Al abuelo le gustaba que le acompañáramos a pasear.	祖父は私たちが散歩についていくことを好んでいた．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[4]	\N	\N	1
523	Mi padre no me permite que llegue a casa después de las diez.	父は私が１０時以降に帰宅するのを許さない．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]	\N	\N	1
464	Esta mañana he ido al dentista.	今朝歯医者に行ってきた．	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
507	Yo siempre desayuno viendo la televisión.	私はいつもテレビを見ながら朝食をとる．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	1
510	Mamá, ¿estás preparando la cena? — Sí, la estoy preparando.	ママ，夕食を作ってるの？　－　うん，今作ってるところ．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[5]	\N	\N	1
517	Puede que el petróleo suba mucho esta semana.	今週石油（価格）が大きく上がるかもしれない．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
492	¿Fuiste a algún sitio el domingo? — No, estuve todo el día en casa.	日曜日どこかに行った？　－　いや，一日中家にいたよ．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
503	Me gusta pasear en coche los domingos.	私は日曜日に車で出かける（ドライブに行く）のが好きだ．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
516	Es imposible que terminemos este proyecto en sólo una semana.	私たちがこのプロジェクトを一週間だけで終わらせるのは不可能だ．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
489	La semana pasada hubo dos terremotos.	先週は２回地震があった．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
491	¿Cuántos años estuviste en Buenos Aires? — Cinco años.	ブエノスアイレスには何年いたの？　－　５年．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
515	No estoy segura de que los bancos abran los sábados por la tarde.	土曜の午後に銀行が開いているかどうか確信がない．	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
518	¿A qué hora quieres que te llame mañana?	明日何時に電話してほしい？	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
487	¿Qué tal durmió usted anoche? —Mal, dormí muy mal.	昨夜はよく眠れた？　－　ぜんぜんよく眠れなかった．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
573	Si papá hubiera vuelto pronto anoche, habríamos cenado juntos.	父さんが昨夜早く帰ってきていたら，一緒に夕食を食べたんだけど．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[2]	\N	\N	1
500	¿Te he interrumpido? — No, no. Ya terminaba.	邪魔したかな？　－　いや，大丈夫．もう終わりかけたところだったから．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
463	¿Ha terminado ya el programa de televisión? — No, todavía no ha terminado.	そのテレビ番組はもう終わったの？　－　いや，まだ終わってないよ．	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
472	Lo he hecho ya. 	私はすでにそれをし終えた．	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
578	¡Ojalá todavía estén en casa!	彼ら／彼女らがまだ家にいますように！	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[6]/gmod:instance[5]	\N	\N	1
538	Siento que hayas tenido que esperarnos tanto tiempo.	君がこんなに長時間待たなくてはならなかったのは遺憾だ．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
541	No creí que pudiera conseguir el visado en tan poco tiempo.	こんな短時間でビザが取れるとは思わなかった．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
485	¿Cuándo te llamó Julia? — Me llamó hace dos o tres días.	フリアはいつ君に電話してきたの？　－　２，３日前だよ．	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
483	El poeta leyó en voz alta su poema.	詩人は自分の詩を声に出して読んだ（朗読した）．	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
568	Si hace buen tiempo mañana, te llevaré al zoo.	明日天気がよければ，動物園に連れて行ってあげるよ．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
570	Si hiciera buen tiempo mañana, te llevaría al zoo.	明日がいい天気になるんだったら，動物園に連れて行ってあげるんだけどね．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]	\N	\N	1
572	Si hubiera hecho buen tiempo ayer, te habría llevado al zoo.	昨日がいい天気だったら，動物園に連れて行ってあげたんだけど．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[1]	\N	\N	1
562	Aunque llueve, saldremos.	雨が降る(降っている) のだが出かけるつもりだ．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
567	Tal vez llueva mañana.	たぶん明日は雨が降るだろう．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	1
524	Me alegro de que me digas eso.	君がそれを私に言ってくれてうれしい．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
593	Mira, te voy a decir una cosa. 	ねえ，ちょっと話があるんだけど． (usted に対しては Mire, le . . . )	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]	\N	\N	1
508	Está mal visto hablar con la gente masticando chicle.	ガムをかみながら人と話すのは行儀が悪い．	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
496	De niño, vivía en un pueblo muy tranquilo.	子供の頃，とても静かな村に住んでいた．	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
587	Chicos, no saquéis fotos en el museo, ¿vale?	みんな，博物館で写真を撮ってはいけないよ，わかったね？	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
493	La fiesta fue muy divertida.	パーティーはとても面白かった．	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
525	Siento mucho que no vengas a la fiesta.	君がパーティーに来ないのはとても残念だ．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
586	Sigan todo recto.	（道案内などで）まっすぐに行ってください．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	1
585	No comas tan aprisa y mastica bien.	そんなに急いで食べないで，よく噛みなさい．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
566	Quizá venga más tarde.	おそらく彼／彼女は遅れて来るだろう．	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
546	¿No te dije que volvieras a hablar con ella?	もう一度彼女と話をするように言わなかったっけ？	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]	\N	\N	1
476	Hace dos meses que estoy enfermo. 	私はここ2ヶ月ほど病気です．	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[5]/gmod:instance[2]	\N	\N	1
528	¿Te importa que baje un poco el volumen de la televisión?—No, no, claro.	テレビのボリュームをちょっと下げてもいいかな？　－　かまわないよ，もちろん．	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
545	El oculista nos recomendó que descansáramos un poco cada hora.	眼科医は私たちに１時間ごとに少しずつ休憩をとるようにと勧めた．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_scene (id, explanation, s_type) FROM stdin;
1	海外旅行	1
2	スポーツ	1
3	道	1
4	会社	1
5	図書館	1
6	店	1
7	家庭／家	1
8	部屋	1
9	交番	1
10	美容院	1
11	学校	1
12	授業	1
13	病院	1
14	駅	1
15	喫茶店	1
16	レストラン／食堂	1
17	銀行	1
18	郵便局	1
19	デパート	1
20	不動産屋	1
21	代名詞	2
22	形容詞 1	2
23	形容詞 2	2
24	空間	2
25	家族	2
26	身につける物・動作	2
27	身体	2
28	食生活	2
29	道具・家具	2
30	時・月	2
31	時・週	2
32	時・年	2
33	時・日	2
34	時	2
35	娯楽・趣味	2
36	天気	2
37	ことば	2
38	人間	2
39	色	2
\.


--
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	682	行く	1	1
2	683	英語	1	1
3	684	飛行機	1	1
4	685	外国	1	1
5	685	外国人	1	1
6	687	スペイン語	1	1
7	688	ホテル	1	1
8	689	日本語、日本人	1	1
9	690	出掛ける	1	1
10	691	国（くに）	1	1
11	147	会う	1	1
12	693	休み	1	1
13	694	旅行	1	1
14	695	旅行する	1	1
15	696	遊ぶ、（スポーツ）をする	1	1
16	697	大使館	1	1
17	698	大好き	1	1
18	699	好き	1	1
19	1199	上手（じょうず）に、上手な	1	1
20	701	走る\n＊Correrには、急ぐ、流れるなどの意味もあります。	1	1
21	702	ゆっくり	1	1
22	970	下手（へた）に、下手な	1	1
23	704	歩く	1	1
24	705	泳ぐ	1	1
25	706	速い［スピードが～］	1	1
26	707	飛ぶ	1	1
27	708	スポーツ	1	1
28	709	嫌い、好きじゃない	1	1
29	710	プール	1	1
30	711	バス	1	1
31	712	自転車	1	1
32	713	交差点	1	1
33	714	道（みち）	1	1
34	715	池	1	1
35	716	散歩	1	1
36	717	かわ（川・河）	1	1
37	718	タクシー	1	1
38	719	自動車，車（くるま）	1	1
39	720	曲がる	1	1
40	721	ネクタイ	1	1
41	722	ワイシャツ、ユニフォーム	1	1
42	723	会社	1	1
43	724	背広	1	1
44	725	する，やる	1	1
45	726	吸う	1	1
46	727	電話	1	1
47	728	仕事，課題	1	1
48	729	働く・勤める	1	1
49	730	忙しい	1	1
50	731	図書館	1	1
51	732	辞書，字引	1	1
52	733	借りる	1	\N
53	734	新聞	1	1
54	735	読む	1	1
55	736	本	1	1
56	737	コピー	1	1
57	738	コピーする	1	0
58	739	雑誌	1	1
59	740	冊	1	\N
60	741	牛肉	1	1
61	742	安い	1	1
62	743	店	1	1
63	744	高い	1	1
64	745	いくつ	1	1
65	746	いくら	1	1
66	747	果物	1	1
67	748	野菜	1	1
68	749	魚	1	1
69	750	豚肉	1	1
70	751	鳥肉	1	1
71	752	肉	1	1
72	753	欲しい，～したい	1	1
73	754	渡す	1	1
74	755	八百屋，青果店　＊《verdulería》ともいう．	1	1
75	756	かぎ（鍵）	1	1
76	757	料理	1	1
77	758	買い物する	1	1
78	759	洗濯する	1	1
79	760	掃除する	1	1
80	761	家族	1	1
81	762	家庭	1	1
82	763	庭（にわ）	1	1
83	764	洗濯、洗うこと	1	1
84	765	うち（家）	1	1
85	766	家（いえ）	1	1
86	767	掃除	1	1
87	768	帰る	1	1
88	769	棚、本棚	1	1
89	770	机	1	1
90	771	椅子（いす）	1	1
91	772	部屋	1	1
92	773	冷蔵庫　＊《frigorífico》も同義語	1	1
93	774	洗う	1	1
94	775	ベッド	1	1
95	776	ラジオ	1	1
96	777	ラジカセ	1	1
97	778	～という名前です	1	1
98	779	寝る	1	1
99	780	起きる	1	1
100	781	テーブル	1	1
101	782	テレビ	1	1
102	783	お巡りさん	1	1
103	784	警官	1	\N
104	785	地図	1	1
105	793	そば	1	0
106	787	ここ,こちら, こっち	1	1
107	788	そこ,そちら, そっち	1	1
108	789	あちら, あっち，あそこ	1	1
109	790	どこ,どちら,どっち	1	1
110	791	交番、警察署	1	1
111	792	近い、近く	1	\N
112	793	隣	1	1
113	794	訊く、質問する	1	1
114	795	切る	1	1
115	796	短い	1	1
116	797	後ろ	1	1
117	798	前	1	1
118	799	右	1	1
119	800	左	1	1
120	801	長い	1	1
121	802	座る	1	1
122	803	立つ	1	1
123	804	友達	1	1
124	805	クラス	1	1
125	806	教室	1	1
126	807	廊下	1	1
127	808	学校	1	1
128	809	生徒	1	1
129	810	勉強，研究	1	1
130	811	学生	1	1
131	812	留学生	1	1
132	813	夏休み	1	1
133	814	先生	1	1
134	815	大学	1	1
135	816	ノート	1	1
136	805	授業	1	1
137	818	作文	1	1
138	819	（複数形で）宿題	1	1
139	820	難しい	1	1
140	821	教える	1	1
141	822	テスト	1	1
142	823	練習問題	1	1
143	824	易しい，簡単に	1	1
144	825	練習する	1	1
145	826	質問	1	1
146	827	問題	1	1
147	828	答える	1	1
148	829	痛い	1	1
149	830	歯	1	1
150	831	医者	1	1
151	832	病院	1	1
152	833	病気	1	1
153	834	薬（くすり）	1	1
154	835	死ぬ	1	1
155	836	風邪（かぜ）	1	1
156	837	頭（あたま）	1	1
157	838	腹部　＊口語的には《tripa》が一般的。	1	1
158	839	度（ど）	1	1
159	840	エレベーター	1	1
160	841	切符	1	1
161	842	おりる	1	1
162	843	階段	1	1
163	844	閉める	1	1
164	845	駅	1	1
165	846	地下鉄	1	1
166	847	乗る	1	1
167	848	開ける	1	1
168	849	お手洗い、ふろ	1	1
169	850	トイレ	1	1
170	851	電車	1	1
171	852	飲み物	1	1
172	853	コーヒー	1	1
173	854	喫茶店	1	1
174	855	レモン	1	1
175	856	牛乳	1	1
176	857	砂糖	1	1
177	858	カップ	1	1
178	859	お茶	1	1
179	860	紅茶	1	1
180	861	コップ	1	1
181	862	入れる	1	1
182	863	甘い	1	1
183	864	飲む	1	1
184	865	はし，爪楊枝	1	1
185	866	酒	1	1
186	867	おいしい	1	1
187	868	ナイフ	1	1
188	869	スプーン	1	1
189	870	フォーク	1	1
190	871	チーズ	1	1
191	872	食べる	1	1
192	873	まずい，おいしくない	1	1
193	874	パン	1	1
194	875	辛い	1	1
195	876	レストラン	1	1
196	877	食堂	1	1
197	878	酒・ワイン	1	1
198	879	食べ物	1	1
199	880	カレー	1	1
200	881	お金	1	1
201	882	銀行	1	1
202	883	入り口，玄関\n	1	1
203	884	どうぞ	1	1
204	885	いいえ	1	1
205	886	ええ，はい	1	1
206	887	すみません	1	1
207	862	どうぞ	1	0
208	889	出口	1	1
209	890	着く	1	1
210	891	ポスト，郵便受け	1	1
211	892	葉書，ポストカード	1	1
212	893	張る	1	1
213	894	封筒	1	1
214	895	手紙	1	1
215	896	（複数形で）郵便局	1	1
216	897	返す	1	1
217	898	出す	1	1
218	899	切手	1	1
219	900	荷物，小包	1	1
220	901	枚	1	\N
221	902	貸す	1	1
222	903	買う	1	1
223	904	帽子	1	1
224	905	靴	1	1
225	906	買い物	1	1
226	907	階	1	1
227	908	デパート	1	1
228	909	スカート	1	1
229	910	コート	1	1
230	911	ズボン　＊主に複数形《pantalones》で使用される．\n	1	1
231	912	セーター	1	1
232	913	…てください	1	1
233	914	かばん	1	1
234	915	売る	1	1
235	916	上着	1	1
236	917	お手洗い、ふろ	1	1
237	918	建物	1	1
238	919	台所	1	1
239	920	シャワー，（お風呂）	1	1
240	921	窓	1	1
241	922	住む	1	1
242	923	公園	1	1
243	924	ドア	1	1
244	925	浴びる［一風呂～］	1	1
245	926	アパート	1	1
246	927	玄関	1	1
247	928	彼	1	1
248	929	彼ら，それらのもの	1	1
249	930	私（わたし）	1	1
250	931	私たち	1	1
251	932	だれか	1	1
252	933	だれ	1	1
253	934	どなた	1	1
254	935	きみ	1	1
255	936	あなた	1	1
256	937	この	1	1
257	938	その，あの	1	1
258	939	いかが，どう	1	\N
259	940	どの、どれ，（何）	1	1
260	941	どんな、どう	1	1
261	942	こんな、そのような	1	1
262	943	自分	1	1
263	944	そう、こう	1	1
264	945	厚い	1	1
265	946	狭い	1	1
266	947	細い	1	1
267	948	大きい	1	1
268	949	太い	1	1
269	950	若い	1	1
270	951	広い	1	1
271	952	軽い	1	1
272	953	遠い	1	1
273	954	重い	1	1
274	947	薄い	1	1
275	956	新しい	1	1
276	957	小さい	1	1
277	792	近い、近く	1	1
278	959	古い	1	1
279	960	楽しい、おもしろい	1	1
280	961	にぎやか，明るい，うれしい	1	1
281	962	低い	1	1
282	1199	よい、よく	1	1
283	964	明るい	1	1
284	965	弱い	1	1
285	966	強い，強く	1	1
286	967	興味深い	1	1
287	968	きれい	1	1
288	969	遅い	1	1
289	970	悪い	1	1
290	971	多い、たくさん、とても	1	1
291	972	暗い	1	1
292	973	静かな	1	1
293	974	少ない	1	1
294	975	汚い	1	1
295	976	つまらない	1	1
296	977	横	1	1
297	978	中（なか）	1	1
298	979	外（そと）	1	1
299	980	東（ひがし）	1	1
300	981	高さ	1	1
301	982	縦	1	1
302	983	北（きた）	1	1
303	984	西（にし）	1	1
304	985	下（した）	1	1
305	986	南（みなみ）	1	1
306	987	上（うえ）	1	1
307	988	先（さき）	1	1
308	989	後（あと）	1	1
309	990	従兄弟	1	1
310	991	兄　＊《hermano mayor》ともいう．	3	1
311	991	兄弟（きょうだい）	2	1
312	993	おばあさん	1	1
313	994	おじいさん	1	1
314	995	奥さん	1	1
315	996	母 ＊呼びかけは通常，《mamá》．\n	1	1
316	997	叔父，伯父	1	1
317	998	両親	1	1
318	999	父	1	1
319	1000	姉　＊《hermana mayor》ともいう．	1	1
320	1000	姉妹	1	1
321	1002	叔母，伯母	1	1
322	991	お兄さん	1	0
323	1000	お姉さん	1	0
324	999	お父さん	1	1
325	996	お母さん	1	1
326	1007	靴下	1	1
327	1008	シャツ	1	1
328	1009	脱ぐ	1	1
329	1011	（眼鏡を）かける	1	1
330	1011	（ズボン，靴を）はく	1	1
331	1011	着る	1	1
332	1011	かぶる	1	1
333	1014	ハンカチ	1	1
334	1015	スリッパ	1	1
335	1016	傘	1	1
336	1017	ポケット	1	1
337	1018	財布、かばん	1	1
338	1019	着ている，身に着けている	1	1
339	1020	服	1	1
340	1020	洋服	1	\N
341	1022	口（くち）	1	1
342	1023	腕（うで）	1	1
343	1024	体（からだ）	1	1
344	1025	顔	1	1
345	1026	脚（あし）	1	1
346	1027	手（て）	1	1
347	1028	鼻	1	1
348	1029	目（め）	1	1
349	1030	耳	1	1
350	1031	足（あし）	1	1
351	1032	お腹	1	1
352	757	皿（さら）	1	1
353	1034	バター	1	1
354	1035	茶わん	1	\N
355	1036	あめ	1	1
356	879	昼御飯	1	1
357	1038	夕飯（ゆうはん）、晩御飯	1	1
358	1039	お菓子	1	1
359	1040	卵	1	1
360	1041	朝御飯，朝食をとる	1	1
361	879	御飯（ごはん）	1	1
362	1043	醤油	1	1
363	1044	塩（しお）	1	1
364	1045	夕飯（ゆうはん）、晩御飯	1	1
365	1046	加える	1	1
366	1047	つける、貼る	1	1
367	1048	カメラ	1	1
368	1049	ストーブ	1	1
369	1050	鉛筆	1	1
370	1051	消す	1	1
371	1052	眼鏡（めがね）	1	1
372	1053	テープレコーダー	1	1
373	1054	時計	1	1
374	1055	コンピュータ	1	1
375	1056	フィルム	1	1
376	924	戸（と）	1	1
377	924	門（もん）	1	1
378	1059	ペン	1	1
379	1060	万年筆	1	1
380	1059	ボールペン	1	\N
381	1062	八月	1	1
382	1063	四月	1	1
383	1064	今月	1	1
384	1065	毎月（まいつき）	1	1
385	1066	十二月	1	1
386	1067	二月	1	1
387	1068	一月	1	1
388	1069	七月	1	1
389	1070	六月	1	1
390	1071	来月	1	1
391	1072	五月	1	1
392	1073	三月	1	1
393	1074	先月	1	1
394	1075	十一月	1	1
395	1076	十月	1	1
396	1077	九月	1	1
397	1078	ひとつき	1	1
398	1079	今週	1	1
399	1080	毎週	1	1
400	1081	日曜日	1	1
401	1082	木曜日	1	1
402	1083	来週	1	1
403	1084	月曜日	1	1
404	1085	火曜日	1	1
405	1086	水曜日	1	1
406	1087	土曜日	1	1
407	1088	週間	1	1
408	1089	先週	1	1
409	1090	金曜日	1	1
410	1091	年（ねん）	1	1
411	1092	秋	1	1
412	1093	今年（ことし）	1	1
413	1094	毎年（まいとし）	1	1
414	1095	夏（なつ）	1	1
415	1096	冬	1	1
416	1097	去年	1	1
417	1098	来年	1	1
418	1099	春	1	1
419	1100	再来年，二年後	1	1
420	1101	おととし	1	1
421	1102	午後	1	1
422	1103	今日（きょう）	1	1
423	1104	明日（あした）	1	1
424	1105	時（じ）	1	1
425	1106	昨日（きのう）	1	1
426	1107	夕べ、昨夜	1	1
427	1104	午前	1	1
428	1104	朝	1	1
429	1110	昼，正午	1	1
430	1111	夜（よる）	1	1
431	1112	夕方	1	1
432	1113	あさって	1	1
433	1114	おととい	1	1
434	1115	もう	1	1
435	1116	ながら	1	\N
436	1117	まだ	1	1
437	1118	中(じゅう)	1	1
438	1119	時（とき）	1	1
439	1120	いつ	1	1
440	1121	ときどき	1	1
441	1122	しばしば、頻繁な	1	1
442	1105	時間	1	1
443	1124	すぐ	1	1
444	1125	灰皿	1	1
445	1126	歌（うた）	1	\N
446	1127	歌う	1	\N
447	1128	たばこ	1	1
448	1129	映画	1	1
449	1130	レコード	1	1
450	1131	ギター	1	1
451	1132	弾く	1	1
452	1133	音楽	1	1
453	1134	絵（え）	1	1
454	1135	写真	1	1
455	1136	好き，気に入る	1	1
456	1137	声	1	1
457	1138	晴れ	1	1
458	1139	熱い、暑い	1	1
459	1140	晴れる	1	1
460	1141	涼しい	1	1
461	1142	寒い	1	1
462	1143	雪（ゆき）	1	1
463	1144	雨が降る	1	1
464	1145	雨（あめ）	1	1
465	1119	天気	1	1
466	1147	暑い	1	1
467	1148	風（かぜ）	1	1
468	1149	曇り	1	1
469	1150	冷たい、寒い	1	1
470	1151	曇る	1	1
471	1152	漢字	1	1
472	1153	言う	1	1
473	1154	書く，手紙を書く	1	1
474	1155	話（はなし）	1	1
475	1156	言葉	1	1
476	1157	～語	1	\N
477	1158	語（ご）	1	1
478	1159	話す	1	1
479	1160	文章	1	1
480	1161	語る	2	1
481	1162	意味	1	1
482	1163	平仮名	1	1
483	1164	片仮名	1	1
484	1165	大人（おとな）	1	1
485	1166	大勢	1	1
486	1167	夫婦	1	1
487	1168	子供	1	1
488	995	妻	1	1
489	995	女（おんな）	1	1
490	1171	男の子	1	1
491	1172	人（ひと）	1	1
492	1172	男（おとこ）	1	1
493	1174	女の子	1	1
494	1175	夫	1	1
495	1176	人	1	1
496	1177	みんな、世界中	1	1
497	1178	白（しろ），白い	1	1
498	1179	青，青い	1	1
499	1180	茶色	1	1
500	964	（色が）明るい，淡い	1	1
501	1182	色（いろ）	1	1
502	972	（色が）濃い，暗い	1	1
503	1184	黄色（きいろ），黄色い	1	1
504	1185	黒（くろ），黒い	1	1
505	1186	赤，赤い	1	1
506	1187	緑	1	1
508	1189	パーティー	1	1
509	1190	紙	1	1
510	1191	～になる　＊長期の変化，自分の意志，努力した結果	1	1
511	1192	締める	1	1
512	1193	押す	1	1
513	1194	始まる，始める	1	1
514	1195	ちょうど	1	1
515	1196	ない	1	1
516	1197	まっすぐ	1	1
517	1198	有名	1	1
518	1199	元気	1	1
519	1200	じゃあ	1	1
520	1201	多分	1	1
521	1202	では、また後ほど	1	1
522	1203	多分、おそらく	1	1
523	1204	どうぞ	1	1
524	944	そう、こう	1	0
525	100	おいしい	1	1
526	1205	牛肉	1	1
527	1206	彼女	1	1
528	1207	彼女ら	1	1
529	1208		1	0
530	833		1	0
531	1208	病気の	1	1
532	1209	コピー機	1	1
533	738	コピーする	1	1
534	403	悪い	1	1
535	1210	少し	1	0
536	1210	少し	1	1
537	1211	あなたがた	1	1
538	147	見る	1	1
539	1212	聞く，聴く	1	1
540	488	聞く	1	\N
541	72	知る、知っている	1	1
542	386	できる	1	1
543	1213	スーパーマーケット	1	1
544	32	持つ	1	1
545	686		1	0
546	1136	好き	1	0
547	754		1	0
548	754	渡る、通る	1	1
549	754	（時間、休暇を）過ごす	1	1
550	757	皿	1	0
551	774	洗濯する	1	1
552	797	後（あと）	1	1
553	801	縦、長さ	1	1
554	780	立つ、立ち上がる	1	1
555	823	運動	1	1
556	826		1	0
557	826	問題	1	1
558	846	メートル	1	1
559	850	サービス	1	1
560	859	紅茶	1	1
561	863	お菓子	1	1
562	883	玄関	1	0
563	883	入場券，チケット	1	1
564	1047	貼る	1	1
565	897	もどす，吐く	1	1
566	907	アパート	1	1
567	954	しつこい，くどい	1	1
568	1215	元気のある	1	1
569	964	明白な，明らかな	1	1
570	964	もちろん	1	1
571	1102	遅く	1	1
572	988		1	0
573	1011	～し始める	1	1
574	1019	～し続ける	1	1
575	1029	（注意喚起）気をつけて，注目して．	1	1
576	1191	～のふりをする	1	1
577	1112	日が暮れる	1	1
578	1216	CD	1	1
579	1217	漢字	1	1
580	1155	歴史	1	1
581	1161	数える	1	1
582	1161	あてにする	2	1
583	977	そば	1	1
584	896	郵便，郵便物	1	1
585	1047	殴る　＊《pegarse》で殴り合いをする	1	1
586	1047	合う，似合う	1	1
587	707	大急ぎで行く	1	1
588	1000	妹　＊《hermana menor》，《hermana pequeña》ともいう．	1	1
589	991	弟　＊《hermano menor》，《hermano pequeño》ともいう	3	1
590	988	どうぞ	1	0
591	988	どうぞ	1	1
592	949	重大な	1	1
593	1172	（喜び，驚き）やぁ，まさか，まったく	1	1
594	488	（呼びかけ）ねえ，（電話をかけて）もしもし	1	1
595	32	《tener que + 不定詞》～しなくてはならない．	1	1
507	1188	便利	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
2	30580	1.3101	1.31	体	活動	言語	言語	英語	英語	えいご
3	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
4	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
5	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
6	30588	1.3101	1.31	体	活動	言語	言語	スペイン語	スペイン語	すぺいんご
7	23065	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	ホテル	ホテル	ほてる
8	30562	1.3101	1.31	体	活動	言語	言語	日本語	日本語	にほんご
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
10	21338	1.253	1.25	体	主体	公私	国	国（くに）	国	くに
11	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
12	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
13	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
14	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
15	82317	2.3369999	2.33	用	活動	生活	遊楽	遊ぶ	遊ぶ	あそぶ
16	23402	1.271	1.27	体	主体	機関	政府機関	大使館	大使館	たいしかん
17	95587	3.302	3.30	相	活動	心	好悪・愛憎	大好き	大好き	だいすき
18	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
19	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
21	94288	3.1912999	3.19	相	関係	量	速度	ゆっくり	ゆっくり	ゆっくり
22	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
24	82483	2.3374	2.33	用	活動	生活	スポーツ	泳ぐ	泳ぐ	およぐ
25	94225	3.1912999	3.19	相	関係	量	速度	速い［スピードが～］	速い	はやい
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
27	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
28	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
29	22810	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	プール	プール	ぷうる
30	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
31	56482	1.465	1.46	体	生産物	機械	乗り物（陸上）	自転車	自転車	じてんしゃ
32	57316	1.471	1.47	体	生産物	土地利用	道路・橋	交差点	交差点	こうさてん
33	57152	1.471	1.47	体	生産物	土地利用	道路・橋	道（みち）	道	みち
34	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
35	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
36	60947	1.525	1.52	体	自然	天地	川・湖	かわ（川・河）	かわ	かわ
37	56572	1.465	1.46	体	生産物	機械	乗り物（陸上）	タクシー	タクシー	たくしい
38	56506	1.465	1.46	体	生産物	機械	乗り物（陸上）	自動車	自動車	じどうしゃ
39	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
40	50149	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	ネクタイ	ネクタイ	ねくたい
41	49847	1.4220001	1.42	体	生産物	衣料	上着・コート	ワイシャツ	ワイシャツ	わいしゃつ
42	22666	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	会社	会社	かいしゃ
43	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
44	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
45	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
46	32370	1.3122	1.31	体	活動	言語	通信	電話	電話	でんわ
47	36429	1.332	1.33	体	活動	生活	労働・作業・休暇	仕事	仕事	しごと
48	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
49	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
50	23121	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	図書館	図書館	としょかん
51	34541	1.316	1.31	体	活動	言語	文献・図書	辞書	辞書	じしょ
52	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
53	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
54	80639	2.3150001	2.31	用	活動	言語	読み	読む	読む	よむ
55	34173	1.316	1.31	体	活動	言語	文献・図書	本（ほん）	本	ほん
56	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
57	80748	2.3151	2.31	用	活動	言語	書き	コピーする	コピーする	こぴいする
58	34482	1.316	1.31	体	活動	言語	文献・図書	雑誌	雑誌	ざっし
59	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
60	51299	1.4323	1.43	体	生産物	食料	魚・肉	牛肉	牛肉	ぎゅうにく
61	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
62	22828	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	店（みせ）	店	みせ
63	94023	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	高い	高い	たかい
64	14656	1.196	1.19	体	関係	量	数記号（一二三）	いくつ	いくつ	いくつ
65	14658	1.196	1.19	体	関係	量	数記号（一二三）	いくら	いくら	いくら
66	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
67	51101	1.432	1.43	体	生産物	食料	米・ぬか・小麦粉など	野菜	野菜	やさい
68	63577	1.5504	1.55	体	自然	動物	魚類	魚（さかな）	魚	さかな
69	51303	1.4323	1.43	体	生産物	食料	魚・肉	豚肉	豚肉	ぶたにく
70	51294	1.4323	1.43	体	生産物	食料	魚・肉	鳥肉	鳥肉	とりにく
71	51286	1.4323	1.43	体	生産物	食料	魚・肉	肉	肉	にく
72	96159	3.3041999	3.30	相	活動	心	欲望・期待・失望	欲しい	欲しい	ほしい
73	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
74	22952	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	八百屋	八百屋	やおや
75	54498	1.4541	1.45	体	生産物	道具	日用品	かぎ（鍵）	かぎ	かぎ
76	50577	1.431	1.43	体	生産物	食料	料理	料理	料理	りょうり
77	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
78	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
79	88631	2.3843	2.38	用	活動	事業	掃除など	掃除する	掃除する	そうじする
80	16247	1.21	1.21	体	主体	家族	家族	家族	家族	かぞく
81	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
82	57040	1.47	1.47	体	生産物	土地利用	地類（土地利用）	庭（にわ）	庭	にわ
83	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
84	52392	1.4400001	1.44	体	生産物	住居	住居	うち（家）	うち	うち
85	52391	1.4400001	1.44	体	生産物	住居	住居	家（いえ）	家	いえ
86	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
87	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
88	53263	1.4450001	1.44	体	生産物	住居	棚・台・壇など	本棚	本棚	ほんだな
89	53456	1.447	1.44	体	生産物	住居	家具	机	机	つくえ
90	53482	1.447	1.44	体	生産物	住居	家具	椅子（いす）	椅子	いす
91	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
92	55970	1.462	1.46	体	生産物	機械	電気器具・部品	冷蔵庫	冷蔵庫	れいぞうこ
93	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
94	50330	1.427	1.42	体	生産物	衣料	寝具	ベッド	ベッド	べっど
95	55992	1.462	1.46	体	生産物	機械	電気器具・部品	ラジオ	ラジオ	らじお
96	56144	1.462	1.46	体	生産物	機械	電気器具・部品	ラジカセ	ラジカセ	らじかせ
97	79593	2.3102	2.31	用	活動	言語	名	名のる	名のる	なのる
98	82694	2.3390999	2.33	用	活動	生活	立ち居	寝る	寝る	ねる
99	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
100	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
101	55994	1.462	1.46	体	生産物	機械	電気器具・部品	テレビ	テレビ	てれび
102	20065	1.2417001	1.24	体	主体	成員	保安サービス	お巡りさん	お巡りさん	おまわりさん
103	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
104	32060	1.3115	1.31	体	活動	言語	表・図・譜・式	地図	地図	ちず
105	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
106	10765	1.173	1.17	体	関係	空間	方向・方角	こちら	こちら	こちら
107	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
108	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
109	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
110	23216	1.266	1.26	体	主体	社会	教室・兵営など	交番	交番	こうばん
111	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
112	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
113	80087	2.3132	2.31	用	活動	言語	問答	きく（聞・聴）	きく	きく
114	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
115	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
116	10983	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後ろ	後ろ	うしろ
117	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
118	10956	1.174	1.17	体	関係	空間	左右・前後・たてよこ	右（みぎ）	右	みぎ
119	10954	1.174	1.17	体	関係	空間	左右・前後・たてよこ	左（ひだり）	左	ひだり
120	94000	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	長い	長い	ながい
121	82724	2.3390999	2.33	用	活動	生活	立ち居	座る	座る	すわる
122	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
123	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
124	23913	1.276	1.27	体	主体	機関	同盟・団体	クラス	クラス	くらす
125	22500	1.263	1.26	体	主体	社会	社寺・学校	教室	教室	きょうしつ
126	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
127	22471	1.263	1.26	体	主体	社会	社寺・学校	学校	学校	がっこう
128	20241	1.2419	1.24	体	主体	成員	学徒	生徒	生徒	せいと
129	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
130	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
131	20281	1.2419	1.24	体	主体	成員	学徒	留学生	留学生	りゅうがくせい
132	36595	1.332	1.33	体	活動	生活	労働・作業・休暇	夏休み	夏休み	なつやすみ
133	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
134	22517	1.263	1.26	体	主体	社会	社寺・学校	大学	大学	だいがく
135	55740	1.459	1.45	体	生産物	道具	札・帳など	ノート	ノート	のおと
136	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
137	30813	1.3103	1.31	体	活動	言語	表現	作文	作文	さくぶん
138	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
139	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
140	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
141	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
142	26691	1.3049999	1.30	体	活動	心	学習・習慣・記憶	練習	練習	れんしゅう
143	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
144	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
145	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
146	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
147	80142	2.3132	2.31	用	活動	言語	問答	答える	答える	こたえる
148	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
149	65338	1.5606	1.56	体	自然	身体	骨・歯・爪・角・甲	歯	歯	は
150	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
151	23103	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	病院	病院	びょういん
152	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
153	51929	1.436	1.43	体	生産物	食料	薬剤・薬品	薬（くすり）	薬	くすり
154	90096	2.5702	2.57	用	自然	生命	死	死ぬ	死ぬ	しぬ
155	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
156	64318	1.5601	1.56	体	自然	身体	頭・目鼻・顔	頭（あたま）	頭	あたま
157	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
158	15048	1.1962	1.19	体	関係	量	助数接辞	度（ど）	度	ど
159	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
160	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
161	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
162	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
163	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
164	22785	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	駅	駅	えき
165	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
166	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
167	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
168	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
169	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
170	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
171	51732	1.4349999	1.43	体	生産物	食料	飲料・たばこ	飲み物	飲み物	のみもの
172	51777	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーヒー	コーヒー	こおひい
173	22917	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	喫茶店	喫茶店	きっさてん
174	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
175	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
176	51376	1.433	1.43	体	生産物	食料	調味料・こうじなど	砂糖	砂糖	さとう
177	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
178	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
179	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
180	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
181	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
182	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
183	83154	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	飲む	飲む	のむ
184	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
185	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
186	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
187	54781	1.455	1.45	体	生産物	道具	刃物	ナイフ	ナイフ	ないふ
188	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
189	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
190	51478	1.433	1.43	体	生産物	食料	調味料・こうじなど	チーズ	チーズ	ちいず
191	81700	2.3331001	2.33	用	活動	生活	食生活	食べる	食べる	たべる
192	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
193	50788	1.431	1.43	体	生産物	食料	料理	パン	パン	ぱん
194	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
195	22888	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	レストラン	レストラン	れすとらん
196	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
197	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
198	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
199	51510	1.433	1.43	体	生産物	食料	調味料・こうじなど	カレー	カレー	かれえ
200	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
201	22692	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	銀行	銀行	ぎんこう
202	12249	1.183	1.18	体	関係	形	穴・口	入（い）り口	入り口	いりぐち
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
206	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
207	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
208	12247	1.183	1.18	体	関係	形	穴・口	出口	出口	でぐち
209	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
210	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
211	32265	1.3122	1.31	体	活動	言語	通信	はがき	はがき	はがき
212	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
213	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
214	32261	1.3122	1.31	体	活動	言語	通信	手紙	手紙	てがみ
215	23439	1.272	1.27	体	主体	機関	公共機関	郵便局	郵便局	ゆうびんきょく
216	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
217	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
218	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
219	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
220	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
221	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
222	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
223	50073	1.425	1.42	体	生産物	衣料	帽子・マスクなど	帽子	帽子	ぼうし
224	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
225	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
226	15092	1.1962	1.19	体	関係	量	助数接辞	階	階	かい
227	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
228	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
229	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
230	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
231	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
232	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
233	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
234	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
235	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
236	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
237	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
238	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
239	54653	1.4541	1.45	体	生産物	道具	日用品	シャワー	シャワー	しゃわあ
240	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
241	81948	2.3333001	2.33	用	活動	生活	住生活	住む	住む	すむ
242	23140	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	公園	公園	こうえん
243	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
244	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
245	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
246	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
247	15576	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼（かれ）	彼	かれ
248	15579	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼ら	彼ら	かれら
249	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
250	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
251	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
252	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
253	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
254	15527	1.201	1.20	体	主体	人間	われ・なれ・かれ	君（きみ）	君	きみ
255	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
256	90777	3.1010001	3.10	相	関係	真偽	こそあど・他	この	この	この
257	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
258	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
259	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
260	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
261	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
262	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
263	90799	3.1010001	3.10	相	関係	真偽	こそあど・他	そう	そう	そう
264	94048	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	厚い	厚い	あつい
265	94110	3.1912	3.19	相	関係	量	広狭・大小	狭い	狭い	せまい
266	94125	3.1912	3.19	相	関係	量	広狭・大小	細い	細い	ほそい
267	94142	3.1912	3.19	相	関係	量	広狭・大小	大きい	大きい	おおきい
268	94124	3.1912	3.19	相	関係	量	広狭・大小	太い	太い	ふとい
269	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
270	94080	3.1912	3.19	相	関係	量	広狭・大小	広い	広い	ひろい
271	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
272	94059	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	遠い	遠い	とおい
273	94318	3.1914001	3.19	相	関係	量	軽重	重い	重い	おもい
274	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
275	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
276	94186	3.1912	3.19	相	関係	量	広狭・大小	小さい	小さい	ちいさい
277	94068	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	近い	近い	ちかい
278	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
279	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
280	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
281	94030	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	低い	低い	ひくい
282	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
283	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
284	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
285	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
286	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
287	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
288	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
289	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
290	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
291	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
292	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
293	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
294	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
295	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
296	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
297	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
298	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
299	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
300	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
301	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
302	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
303	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
304	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
305	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
306	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
307	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
308	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
309	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
310	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
311	16780	1.214	1.21	体	主体	家族	兄弟	兄弟（きょうだい）	兄弟	きょうだい
312	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
313	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
314	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
315	16496	1.212	1.21	体	主体	家族	親・先祖	母	母	はは
316	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
317	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
318	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
319	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
320	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
321	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
322	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
323	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
324	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
325	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
326	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
327	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
328	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
330	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
331	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
332	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
333	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
334	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
335	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
336	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
337	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
338	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
339	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
340	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
341	64505	1.5601	1.56	体	自然	身体	頭・目鼻・顔	口	口	くち
342	64741	1.5603	1.56	体	自然	身体	手足・指	腕	腕	うで
343	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
344	64388	1.5601	1.56	体	自然	身体	頭・目鼻・顔	顔	顔	かお
345	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
346	64713	1.5603	1.56	体	自然	身体	手足・指	手（て）	手	て
347	64470	1.5601	1.56	体	自然	身体	頭・目鼻・顔	鼻	鼻	はな
348	64415	1.5601	1.56	体	自然	身体	頭・目鼻・顔	目（め）	目	め
349	64491	1.5601	1.56	体	自然	身体	頭・目鼻・顔	耳	耳	みみ
350	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
351	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
352	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
353	51476	1.433	1.43	体	生産物	食料	調味料・こうじなど	バター	バター	ばたあ
354	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
355	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
356	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
357	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
358	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
359	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
360	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
361	36910	1.3331	1.33	体	活動	生活	食生活	御飯（ごはん）	御飯	ごはん
362	51442	1.433	1.43	体	生産物	食料	調味料・こうじなど	醤油	醤油	しょうゆ
363	51398	1.433	1.43	体	生産物	食料	調味料・こうじなど	塩（しお）	塩	しお
364	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
365	73997	2.158	2.15	用	関係	作用	増減・補充	加える	加える	くわえる
366	72782	2.1559999	2.15	用	関係	作用	接近・接触・隔離	付ける	付ける	つける
367	55928	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	カメラ	カメラ	かめら
368	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
369	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
370	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
371	55889	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	眼鏡（めがね）	眼鏡	めがね
372	56004	1.462	1.46	体	生産物	機械	電気器具・部品	テープレコーダー	テープレコーダー	てえぷれこおだあ
373	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
374	56126	1.462	1.46	体	生産物	機械	電気器具・部品	コンピューター	コンピューター	こんぴゅうたあ
375	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
376	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
377	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
378	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
379	54238	1.4529999	1.45	体	生産物	道具	文具	万年筆	万年筆	まんねんひつ
380	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
381	14681	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	八月	八月	はちがつ
382	14677	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	四月	四月	しがつ
383	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
384	7865	1.1612	1.16	体	関係	時間	毎日・毎度	毎月（まいつき）	毎月	まいつき
385	14685	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十二月	十二月	じゅうにがつ
386	14675	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	二月	二月	にがつ
387	14674	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	一月	一月	いちがつ
388	14680	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	七月	七月	しちがつ
389	14679	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	六月	六月	ろくがつ
390	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
391	8510	1.1631	1.16	体	関係	時間	月	五月（さつき）	五月	さつき
392	14676	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	三月	三月	さんがつ
393	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
394	14684	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十一月	十一月	じゅういちがつ
395	14683	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十月	十月	じゅうがつ
396	14682	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	九月	九月	くがつ
397	14623	1.196	1.19	体	関係	量	数記号（一二三）	ひとつき	ひとつき	ひとつき
398	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
399	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
400	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
401	8558	1.1632	1.16	体	関係	時間	週・週日	木曜日	木曜日	もくようび
402	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
403	8555	1.1632	1.16	体	関係	時間	週・週日	月曜日	月曜日	げつようび
404	8556	1.1632	1.16	体	関係	時間	週・週日	火曜日	火曜日	かようび
405	8557	1.1632	1.16	体	関係	時間	週・週日	水曜日	水曜日	すいようび
406	8560	1.1632	1.16	体	関係	時間	週・週日	土曜日	土曜日	どようび
407	14890	1.1962	1.19	体	関係	量	助数接辞	週間	週間	しゅうかん
408	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
409	8559	1.1632	1.16	体	関係	時間	週・週日	金曜日	金曜日	きんようび
410	14871	1.1962	1.19	体	関係	量	助数接辞	年（ねん）	年	ねん
411	8389	1.1624	1.16	体	関係	時間	季節	秋	秋	あき
412	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
413	7870	1.1612	1.16	体	関係	時間	毎日・毎度	毎年（まいとし）	毎年	まいとし
414	8375	1.1624	1.16	体	関係	時間	季節	夏（なつ）	夏	なつ
415	8403	1.1624	1.16	体	関係	時間	季節	冬	冬	ふゆ
416	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
417	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
418	8361	1.1624	1.16	体	関係	時間	季節	春	春	はる
419	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
420	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
421	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
422	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
423	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
424	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
425	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
426	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
427	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
428	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
429	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
430	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
431	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
432	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
433	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
434	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
435	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
436	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
437	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
438	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
439	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
440	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
441	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
442	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
443	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
444	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
445	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
446	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
447	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
448	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
449	55164	1.456	1.45	体	生産物	道具	楽器・レコードなど	レコード	レコード	れこおど
450	55090	1.456	1.45	体	生産物	道具	楽器・レコードなど	ギター	ギター	ぎたあ
451	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
452	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
453	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
454	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
455	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
456	25605	1.3031	1.30	体	活動	心	声	声	声	こえ
457	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
458	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
459	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
460	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
461	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
462	59878	1.5153	1.51	体	自然	物質	雨・雪	雪（ゆき）	雪	ゆき
463	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
464	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
465	59928	1.5154001	1.51	体	自然	物質	天気	天気	天気	てんき
466	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
467	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
468	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
469	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
470	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
471	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
472	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
473	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
474	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
475	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
476	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
477	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
478	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
479	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
480	80001	2.3131001	2.31	用	活動	言語	話・談話	語る	語る	かたる
481	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
482	31558	1.3113	1.31	体	活動	言語	文字	平仮名	平仮名	ひらがな
483	31559	1.3113	1.31	体	活動	言語	文字	片仮名	片仮名	かたかな
484	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
485	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
486	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
487	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
488	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
489	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
490	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
491	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
492	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
493	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
494	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
495	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
496	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
497	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
498	58059	1.502	1.50	体	自然	自然	色	青	青	あお
499	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
500	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
501	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
502	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
503	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
504	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
505	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
506	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
507	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
508	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
509	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
510	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
511	68584	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	締める	締める	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
513	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
516	4703	1.152	1.15	体	関係	作用	進行・過程・経由	道程	道程	どうてい
517	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
519	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
522	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
523	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
525	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
526	51299	1.4323	1.43	体	生産物	食料	魚・肉	牛肉	牛肉	ぎゅうにく
527	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
528	15579	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼ら	彼ら	かれら
531	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
532	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
533	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
534	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
535	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
536	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
537	15525	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた方	あなた方	あなたがた
538	77624	2.3062	2.30	用	活動	心	注意・認知・了解	見る	見る	みる
539	27329	1.3062	1.30	体	活動	心	注意・認知・了解	認知	認知	にんち
540	75131	2.3001001	2.30	用	活動	心	感覚	知覚する	知覚する	ちかくする
541	75138	2.3001001	2.30	用	活動	心	感覚	知る	知る	しる
542	83398	2.3420999	2.34	用	活動	行為	才能	できる	できる	できる
543	23050	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	スーパーマーケット	スーパーマーケット	すうぱあまあけっと
544	82801	2.3392	2.33	用	活動	生活	手足の動作	持つ	持つ	もつ
546	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
548	70089	2.1521001	2.15	用	関係	作用	移動・発着	渡る	渡る	わたる
549	74593	2.1600001	2.16	用	関係	時間	時間	過ごす	過ごす	すごす
550	54069	1.452	1.45	体	生産物	道具	食器・調理器具	食器	食器	しょっき
551	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
552	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
553	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
554	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
555	38203	1.3374	1.33	体	活動	生活	スポーツ	運動	運動	うんどう
557	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
558	14911	1.1962	1.19	体	関係	量	助数接辞	メートル	メートル	めえとる
560	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
561	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
562	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
563	48235	1.404	1.40	体	生産物	物品	貨幣・切符・証券	入場券	入場券	にゅうじょうけん
564	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
565	90461	2.5710001	2.57	用	自然	生命	生理	戻す［飲み過ぎて～］	戻す	もどす
566	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
567	95999	3.3039999	3.30	相	活動	心	信念・努力・忍耐	しつこい	しつこい	しつこい
568	75027	2.3	2.30	用	活動	心	心	元気が出る	元気が出る	げんきがでる
569	77706	2.3062	2.30	用	活動	心	注意・認知・了解	明らかになる／にする	明らかになる／にする	あきらかになる・あきらかにする
570	100522	4.3099999	4.31	他		判断	判断	もちろん	もちろん	もちろん
571	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
573	69163	2.1501999	2.15	用	関係	作用	開始	始める	始める	はじめる
574	69492	2.1503999	2.15	用	関係	作用	連続・反復	続ける	続ける	つづける
575	77563	2.3062	2.30	用	活動	心	注意・認知・了解	注意を引く	注意を引く	ちゅういをひく
576	76242	2.303	2.30	用	活動	心	表情・態度	振りをする	振りをする	ふりをする
577	74688	2.1635001	2.16	用	関係	時間	朝晩	暮れる［日が～］	暮れる	くれる
578	55188	1.456	1.45	体	生産物	道具	楽器・レコードなど	ＣＤ	ＣＤ	しいでぃい
579	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
580	35862	1.33	1.33	体	活動	生活	文化・歴史・風俗	歴史	歴史	れきし
581	77901	2.3064001	2.30	用	活動	心	測定・計算	数える	数える	かぞえる
582	76981	2.3041999	2.30	用	活動	心	欲望・期待・失望	当てにする	当てにする	あてにする
583	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
584	32320	1.3122	1.31	体	活動	言語	通信	郵便	郵便	ゆうびん
585	83045	2.3392	2.33	用	活動	生活	手足の動作	殴り合う	殴り合う	なぐりあう
586	68429	2.1331999	2.13	用	関係	様相	良不良・適不適	似合う	似合う	にあう
587	70314	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛んで行く	飛んで行く	とんでゆく
588	16811	1.214	1.21	体	主体	家族	兄弟	妹	妹	いもうと
589	16809	1.214	1.21	体	主体	家族	兄弟	弟	弟	おとうと
590	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
591	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
592	55656	1.4579999	1.45	体	生産物	道具	標章・標識・旗など	宝くじ	宝くじ	たからくじ
593	31052	1.311	1.31	体	活動	言語	語	間投詞	間投詞	かんとうし
594	32182	1.3121001	1.31	体	活動	言語	合図・挨拶	呼び掛け	呼び掛け	よびかけ
595	39273	1.34	1.34	体	活動	行為	義務	義務	義務	ぎむ
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	313	1833	0		0	\N	\N
2	313	550	0		0	\N	\N
3	295	467	0		0	\N	\N
5	522	566	1		0	\N	\N
6	229	1839	0		0	\N	\N
7	167	1726	0		0	\N	\N
8	167	1834	0		0	\N	\N
10	98	1832	0		0	\N	\N
11	251	1879	0		0	\N	\N
12	251	1880	0		0	\N	\N
13	251	552	0		0	\N	\N
14	108	1690	0		0	\N	\N
15	108	982	0	\N	0	\N	\N
16	108	984	0	\N	0	\N	\N
17	128	467	0		0	\N	\N
18	123	511	0		0	\N	\N
19	123	838	0	\N	0	\N	\N
20	410	484	0		0	\N	\N
21	410	491	0		0	\N	\N
22	410	1120	0	\N	0	\N	\N
23	426	487	0		0	\N	\N
24	426	573	0		0	\N	\N
25	106	1728	0		0	\N	\N
26	106	1810	0		0	\N	\N
27	106	1100	0	\N	0	\N	\N
28	523	661	0	\N	0	\N	\N
29	523	1098	0	\N	0	\N	\N
30	106	1098	0	\N	0	\N	\N
31	106	614	0	\N	0	\N	\N
35	263	1020	1	\N	0	\N	\N
36	263	1000	2	\N	0	\N	\N
37	263	1837	3		0	\N	\N
39	125	494	0		0	\N	\N
40	125	632	0	\N	0	\N	\N
41	30	1729	0		0	\N	\N
42	30	582	0		0	\N	\N
43	30	1007	0	\N	0	\N	\N
44	30	995	0	\N	0	\N	\N
45	3	1725	0		0	\N	\N
46	3	1554	0		0	\N	\N
47	3	1799	0		0	\N	\N
48	3	530	0		0	\N	\N
49	425	1919	0		0	\N	\N
51	425	572	0		0	\N	\N
52	176	669	0	\N	0	\N	\N
53	201	515	0		0	\N	\N
54	201	798	0	\N	0	\N	\N
56	236	1702	0		0	\N	\N
57	168	1702	1		0	\N	\N
58	61	896	0	\N	0	\N	\N
62	282	585	0		0	\N	\N
65	282	916	0	\N	0	\N	\N
66	160	684	0	\N	0	\N	\N
67	160	689	0	\N	0	\N	\N
68	287	1004	0	\N	0	\N	\N
70	457	572	0		0	\N	\N
71	457	876	0	\N	0	\N	\N
74	156	1081	0	\N	0	\N	\N
75	172	1885	0		0	\N	\N
76	172	1115	0	\N	0	\N	\N
77	172	1116	0	\N	0	\N	\N
78	94	1845	0		0	\N	\N
80	445	1935	0		0	\N	\N
81	446	1933	0		0	\N	\N
82	446	1935	0		0	\N	\N
83	355	658	0	\N	0	\N	\N
84	71	486	0		0	\N	\N
85	71	1865	0		0	\N	\N
86	63	893	0	\N	0	\N	\N
87	63	894	0	\N	0	\N	\N
88	214	1743	0		0	\N	\N
89	214	1747	0		0	\N	\N
91	214	471	0	\N	0	\N	\N
92	233	1773	0		0	\N	\N
96	84	1073	0	\N	0	\N	\N
97	84	754	0	\N	0	\N	\N
98	84	1055	0	\N	0	\N	\N
99	85	1702	0		0	\N	\N
100	85	1896	0		0	\N	\N
101	85	509	0		0	\N	\N
102	85	482	0		0	\N	\N
103	357	1748	0		0	\N	\N
104	357	510	0		0	\N	\N
105	364	1748	0		0	\N	\N
106	364	510	0		0	\N	\N
107	111	29	0	\N	0	\N	\N
108	111	275	0	\N	0	\N	\N
109	111	790	0	\N	0	\N	\N
110	111	990	0	\N	0	\N	\N
111	111	992	0	\N	0	\N	\N
112	277	1721	0		0	\N	\N
113	277	553	0		0	\N	\N
114	277	790	0	\N	0	\N	\N
115	277	990	0	\N	0	\N	\N
116	277	992	0	\N	0	\N	\N
117	163	584	0		0	\N	\N
118	493	1771	0		0	\N	\N
119	493	1780	0		0	\N	\N
120	493	1890	0		0	\N	\N
121	490	1713	0		0	\N	\N
122	490	1890	0		0	\N	\N
123	490	587	0		0	\N	\N
124	448	1755	0		0	\N	\N
125	448	1868	0		0	\N	\N
126	448	839	0	\N	0	\N	\N
127	448	841	0	\N	0	\N	\N
128	124	1890	0		0	\N	\N
129	124	1937	0		0	\N	\N
130	136	1720	0		0	\N	\N
131	136	1766	0		0	\N	\N
132	136	1083	0		0	\N	\N
133	136	466	0		0	\N	\N
135	136	1056	0		0	\N	\N
136	38	1753	0		0	\N	\N
137	38	503	0		0	\N	\N
138	38	746	0	\N	0	\N	\N
139	38	780	0	\N	0	\N	\N
140	38	804	0	\N	0	\N	\N
141	38	806	0	\N	0	\N	\N
142	501	808	0	\N	0	\N	\N
143	501	818	0	\N	0	\N	\N
144	191	1838	0		0	\N	\N
145	191	1848	0		0	\N	\N
147	191	1938	0		0	\N	\N
148	198	1823	0		0	\N	\N
149	198	733	0	\N	0	\N	\N
150	361	1823	0		0	\N	\N
151	361	733	0	\N	0	\N	\N
153	260	1718	0		0	\N	\N
154	260	1865	0		0	\N	\N
155	260	737	0	\N	0	\N	\N
156	260	793	0	\N	0	\N	\N
157	260	852	0	\N	0	\N	\N
158	137	905	0	\N	0	\N	\N
164	222	804	0	\N	0	\N	\N
165	222	897	0	\N	0	\N	\N
166	222	970	0	\N	0	\N	\N
167	147	502	0		0	\N	\N
168	180	655	0	\N	0	\N	\N
169	40	1090	0	\N	0	\N	\N
170	259	1864	0		0	\N	\N
171	259	625	0	\N	0	\N	\N
172	259	755	0	\N	0	\N	\N
173	259	973	0	\N	0	\N	\N
174	439	485	0		0	\N	\N
175	439	1866	0		0	\N	\N
176	439	618	0	\N	0	\N	\N
177	439	909	0	\N	0	\N	\N
180	65	1091	0	\N	0	\N	\N
181	65	689	0	\N	0	\N	\N
183	65	898	0	\N	0	\N	\N
184	64	1701	0		0	\N	\N
185	64	1722	0		0	\N	\N
186	64	491	0		0	\N	\N
188	64	898	0	\N	0	\N	\N
189	203	630	0	\N	0	\N	\N
190	472	1902	0		0	\N	\N
193	472	593	0		0	\N	\N
194	472	524	0		0	\N	\N
195	472	934	0	\N	0	\N	\N
196	221	935	0	\N	0	\N	\N
197	27	1926	0		0	\N	\N
198	27	1043	0	\N	0	\N	\N
199	118	792	0	\N	0	\N	\N
200	360	507	0		0	\N	\N
201	21	758	0	\N	0	\N	\N
202	51	1689	0		0	\N	\N
203	51	1693	0		0	\N	\N
205	51	1045	0	\N	0	\N	\N
207	200	1867	0		0	\N	\N
208	200	1806	0		0	\N	\N
209	279	1768	0		0	\N	\N
211	148	1035	0	\N	0	\N	\N
212	148	1038	0	\N	0	\N	\N
213	400	492	0		0	\N	\N
214	400	503	0		0	\N	\N
215	400	1042	0	\N	0	\N	\N
216	109	1677	0		0	\N	\N
217	109	1719	0		0	\N	\N
219	109	1724	0		0	\N	\N
220	109	1869	0		0	\N	\N
221	109	600	0	\N	0	\N	\N
222	237	624	0	\N	0	\N	\N
223	237	625	0	\N	0	\N	\N
224	247	1785	0		0	\N	\N
225	247	1791	0		0	\N	\N
226	247	1800	0		0	\N	\N
227	247	560	0		0	\N	\N
228	248	1762	0		0	\N	\N
229	248	1881	0		0	\N	\N
230	248	529	0		0	\N	\N
231	248	962	0	\N	0	\N	\N
233	527	1791	0		0	\N	\N
234	527	546	0		0	\N	\N
235	528	1762	0		0	\N	\N
236	17	1823	0		0	\N	\N
237	17	847	0	\N	0	\N	\N
238	531	476	0		0	\N	\N
239	519	1752	0		0	\N	\N
240	519	1073	0	\N	0	\N	\N
241	519	784	0	\N	0	\N	\N
242	519	897	0	\N	0	\N	\N
243	519	912	0	\N	0	\N	\N
244	519	1056	0	\N	0	\N	\N
245	473	1738	0		0	\N	\N
248	257	531	0		0	\N	\N
249	257	836	0	\N	0	\N	\N
250	257	1780	0		0	\N	\N
251	257	548	0	\N	0	\N	\N
252	257	949	0	\N	0	\N	\N
253	398	517	0		0	\N	\N
254	164	1721	0		0	\N	\N
255	164	553	0		0	\N	\N
256	164	882	0	\N	0	\N	\N
257	164	988	0	\N	0	\N	\N
259	88	1697	0		0	\N	\N
260	518	598	0	\N	0	\N	\N
263	518	739	0	\N	0	\N	\N
266	282	720	0	\N	0	\N	\N
267	518	922	0	\N	0	\N	\N
268	256	1554	0		0	\N	\N
269	256	1755	0		0	\N	\N
270	256	1783	0		0	\N	\N
271	256	1916	0		0	\N	\N
272	256	787	0	\N	0	\N	\N
273	256	1765	0		0	\N	\N
274	256	1769	0		0	\N	\N
275	256	1771	0		0	\N	\N
276	256	464	0		0	\N	\N
277	412	1916	0		0	\N	\N
278	130	1671	0		0	\N	\N
280	130	497	0		0	\N	\N
281	141	1765	0		0	\N	\N
282	141	490	0		0	\N	\N
283	141	603	0	\N	0	\N	\N
284	143	1902	0		0	\N	\N
285	143	773	0	\N	0	\N	\N
286	228	814	0	\N	0	\N	\N
287	80	1118	0	\N	0	\N	\N
288	508	1756	0		0	\N	\N
289	508	493	0		0	\N	\N
290	508	525	0		0	\N	\N
291	508	1067	0	\N	0	\N	\N
292	508	915	0	\N	0	\N	\N
293	454	587	0		0	\N	\N
294	454	999	0	\N	0	\N	\N
295	454	997	0	\N	0	\N	\N
296	454	1120	0	\N	0	\N	\N
297	56	771	0	\N	0	\N	\N
298	533	935	0	\N	0	\N	\N
299	532	765	0	\N	0	\N	\N
300	532	769	0	\N	0	\N	\N
301	532	852	0	\N	0	\N	\N
304	441	1767	0		0	\N	\N
305	92	1972	0		0	\N	\N
306	469	1839	0		0	\N	\N
308	285	1037	0	\N	0	\N	\N
309	268	1897	0		0	\N	\N
311	158	730	0	\N	0	\N	\N
312	267	1896	0		0	\N	\N
313	267	946	0	\N	0	\N	\N
318	18	1769	0		0	\N	\N
319	18	1799	0		0	\N	\N
320	18	468	0		0	\N	\N
321	18	1887	0		0	\N	\N
322	18	337	0	\N	0	\N	\N
324	478	508	0		0	\N	\N
325	478	907	0	\N	0	\N	\N
326	478	1723	0		0	\N	\N
327	478	1849	0		0	\N	\N
328	420	1120	0	\N	0	\N	\N
329	44	1755	0		0	\N	\N
330	44	1765	0		0	\N	\N
331	44	879	0	\N	0	\N	\N
333	44	930	0	\N	0	\N	\N
334	44	1043	0	\N	0	\N	\N
335	44	1932	0		0	\N	\N
336	459	568	0		0	\N	\N
337	459	570	0		0	\N	\N
338	459	572	0		0	\N	\N
339	459	882	0	\N	0	\N	\N
340	458	1920	0		0	\N	\N
341	466	1920	0		0	\N	\N
343	461	1839	0		0	\N	\N
344	461	1919	0		0	\N	\N
346	521	1075	0	\N	0	\N	\N
347	521	607	0	\N	0	\N	\N
348	320	1799	0		0	\N	\N
353	323	706	0	\N	0	\N	\N
355	319	706	0	\N	0	\N	\N
358	311	1897	0		0	\N	\N
359	322	94	0	\N	0	\N	\N
360	322	95	0	\N	0	\N	\N
363	491	1871	0		0	\N	\N
364	492	1871	0		0	\N	\N
365	495	1792	0		0	\N	\N
366	424	1720	0		0	\N	\N
367	424	1725	0		0	\N	\N
368	424	1759	0		0	\N	\N
370	442	1754	0		0	\N	\N
371	442	545	0		0	\N	\N
373	442	647	0		0	\N	\N
374	442	651	0		0	\N	\N
375	7	790	0	\N	0	\N	\N
378	422	1918	0		0	\N	\N
379	422	1921	0		0	\N	\N
380	422	713	0	\N	0	\N	\N
381	422	1053	0	\N	0	\N	\N
382	422	1106	0	\N	0	\N	\N
383	475	1758	0		0	\N	\N
384	475	1864	0		0	\N	\N
385	475	1886	0		0	\N	\N
386	2	1685	0		0	\N	\N
387	2	1758	0		0	\N	\N
388	2	1906	0		0	\N	\N
390	1	944	0	\N	0	\N	\N
391	1	981	0	\N	0	\N	\N
393	1	633	0	\N	0	\N	\N
394	1	600	0	\N	0	\N	\N
396	8	564	0		0	\N	\N
397	269	513	0		0	\N	\N
398	15	1753	0		0	\N	\N
399	15	1042	0	\N	0	\N	\N
400	389	1915	0		0	\N	\N
401	296	1696	0		0	\N	\N
403	112	1696	0		0	\N	\N
404	112	799	0	\N	0	\N	\N
405	408	489	0		0	\N	\N
406	402	1059	0	\N	0	\N	\N
407	175	1809	0		0	\N	\N
408	54	1833	0		0	\N	\N
410	272	951	0	\N	0	\N	\N
412	55	1768	0		0	\N	\N
413	55	1783	0		0	\N	\N
414	55	613	0	\N	0	\N	\N
415	55	834	0	\N	0	\N	\N
417	79	509	0		0	\N	\N
418	97	638	0	\N	0	\N	\N
419	97	793	0	\N	0	\N	\N
420	75	1812	0		0	\N	\N
421	209	1934	0		0	\N	\N
422	209	1725	0		0	\N	\N
423	209	482	0		0	\N	\N
424	209	647	0	\N	0	\N	\N
425	209	741	0	\N	0	\N	\N
427	463	1915	0		0	\N	\N
428	463	562	0		0	\N	\N
429	463	567	0		0	\N	\N
431	403	681	0	\N	0	\N	\N
432	403	682	0	\N	0	\N	\N
433	315	510	0		0	\N	\N
434	289	487	0		0	\N	\N
435	289	508	0		0	\N	\N
436	289	1918	0		0	\N	\N
437	289	1077	0	\N	0	\N	\N
438	289	770	0	\N	0	\N	\N
439	289	879	0	\N	0	\N	\N
441	22	1753	0		0	\N	\N
442	423	1766	0		0	\N	\N
443	423	1756	0		0	\N	\N
444	423	518	0		0	\N	\N
445	423	567	0		0	\N	\N
446	427	1728	0		0	\N	\N
448	427	744	0	\N	0	\N	\N
449	428	1728	0		0	\N	\N
450	428	464	0		0	\N	\N
451	428	744	0	\N	0	\N	\N
452	217	559	0		0	\N	\N
453	346	1838	0		0	\N	\N
454	494	1751	0		0	\N	\N
455	494	1778	0		0	\N	\N
456	391	1722	0		0	\N	\N
457	153	731	0	\N	0	\N	\N
459	150	1084	0	\N	0	\N	\N
460	429	910	0	\N	0	\N	\N
461	100	1692	0		0	\N	\N
462	290	1798	0		0	\N	\N
463	290	1839	0		0	\N	\N
464	290	526	0		0	\N	\N
465	290	495	0		0	\N	\N
466	290	1071	0	\N	0	\N	\N
468	290	724	0	\N	0	\N	\N
469	290	1049	0	\N	0	\N	\N
470	488	1775	0		0	\N	\N
471	487	1845	0		0	\N	\N
472	487	1846	0		0	\N	\N
473	487	496	0		0	\N	\N
474	487	1804	0		0	\N	\N
475	487	1938	0		0	\N	\N
476	204	1679	0		0	\N	\N
477	204	1681	0		0	\N	\N
478	204	1554	0		0	\N	\N
479	204	1757	0		0	\N	\N
481	204	472	0		0	\N	\N
482	204	1878	0		0	\N	\N
483	515	1690	0		0	\N	\N
484	515	619	0	\N	0	\N	\N
485	515	938	0	\N	0	\N	\N
486	430	1736	0		0	\N	\N
487	430	1885	0		0	\N	\N
488	430	1924	0		0	\N	\N
489	302	1724	0		0	\N	\N
490	468	1921	0		0	\N	\N
492	275	1776	0		0	\N	\N
493	232	1726	0		0	\N	\N
494	232	1790	0		0	\N	\N
495	232	1094	0	\N	0	\N	\N
497	232	588	0		0	\N	\N
498	232	1024	0	\N	0	\N	\N
499	232	758	0	\N	0	\N	\N
500	318	523	0		0	\N	\N
501	317	1743	0		0	\N	\N
502	317	1775	0		0	\N	\N
503	317	1788	0		0	\N	\N
504	317	1863	0		0	\N	\N
505	317	1804	0		0	\N	\N
506	317	674	0	\N	0	\N	\N
507	10	1904	0		0	\N	\N
508	10	947	0	\N	0	\N	\N
510	333	1811	0		0	\N	\N
511	509	859	0	\N	0	\N	\N
512	219	1554	0		0	\N	\N
515	219	1788	0		0	\N	\N
517	206	1025	0	\N	0	\N	\N
518	53	1833	0		0	\N	\N
520	68	486	0		0	\N	\N
521	68	564	0		0	\N	\N
523	345	1813	0		0	\N	\N
524	226	624	0	\N	0	\N	\N
525	293	1865	0		0	\N	\N
527	293	541	0		0	\N	\N
529	536	1716	0		0	\N	\N
530	536	528	0		0	\N	\N
531	536	545	0		0	\N	\N
532	536	821	0	\N	0	\N	\N
533	102	1682	0		0	\N	\N
534	103	8	0	\N	0	\N	\N
535	331	1839	0		0	\N	\N
536	145	753	0	\N	0	\N	\N
537	113	498	0		0	\N	\N
538	113	542	0		0	\N	\N
540	133	1679	0		0	\N	\N
541	133	1761	0		0	\N	\N
542	133	620	0	\N	0	\N	\N
543	133	627	0	\N	0	\N	\N
544	133	633	0	\N	0	\N	\N
545	133	871	0	\N	0	\N	\N
546	133	903	0	\N	0	\N	\N
547	243	1834	0		0	\N	\N
548	243	584	0		0	\N	\N
549	376	1834	0		0	\N	\N
550	376	584	0		0	\N	\N
551	377	1022	0		0	\N	\N
552	72	1752	0		0	\N	\N
553	72	1755	0		0	\N	\N
554	72	942	0	\N	0	\N	\N
556	72	981	0	\N	0	\N	\N
557	72	1115	0	\N	0	\N	\N
558	190	963	0	\N	0	\N	\N
560	252	1772	0		0	\N	\N
561	252	1778	0		0	\N	\N
562	252	1863	0		0	\N	\N
563	252	583	0		0	\N	\N
566	253	1772	0		0	\N	\N
567	253	1778	0		0	\N	\N
568	253	1780	0		0	\N	\N
569	253	1863	0		0	\N	\N
570	253	583	0	\N	0	\N	\N
571	328	1027	0	\N	0	\N	\N
572	516	586	0		0	\N	\N
573	516	1008	0	\N	0	\N	\N
574	516	792	0	\N	0	\N	\N
575	155	726	0	\N	0	\N	\N
576	58	1697	0		0	\N	\N
578	406	515	0		0	\N	\N
579	406	875	0	\N	0	\N	\N
580	406	886	0	\N	0	\N	\N
581	406	915	0	\N	0	\N	\N
582	9	1839	0		0	\N	\N
584	9	1808	0		0	\N	\N
587	9	651	0	\N	0	\N	\N
588	9	918	0	\N	0	\N	\N
589	218	1814	0		0	\N	\N
590	407	516	0		0	\N	\N
592	407	719	0	\N	0	\N	\N
594	407	1043	0	\N	0	\N	\N
595	205	1682	0		0	\N	\N
596	205	1717	0		0	\N	\N
597	205	1733	0		0	\N	\N
598	205	1760	0		0	\N	\N
599	205	1798	0		0	\N	\N
600	205	1823	0		0	\N	\N
602	205	634	0	\N	0	\N	\N
603	205	660	0	\N	0	\N	\N
604	205	1068	0	\N	0	\N	\N
605	205	1095	0	\N	0	\N	\N
607	205	592	0		0	\N	\N
608	205	595	0		0	\N	\N
609	205	708	0	\N	0	\N	\N
610	205	844	0	\N	0	\N	\N
611	205	977	0	\N	0	\N	\N
612	186	1717	0		0	\N	\N
613	525	666	0	\N	0	\N	\N
614	525	1717	0		0	\N	\N
615	262	1849	0		0	\N	\N
616	90	1769	0		0	\N	\N
617	90	1774	0		0	\N	\N
618	166	1846	0		0	\N	\N
619	305	989	0	\N	0	\N	\N
620	421	1725	0		0	\N	\N
621	421	1765	0		0	\N	\N
623	421	515	0		0	\N	\N
624	421	1816	0		0	\N	\N
626	37	1810	0		0	\N	\N
627	46	1884	0		0	\N	\N
628	46	499	0		0	\N	\N
629	46	521	0		0	\N	\N
630	46	755	0	\N	0	\N	\N
631	101	463	0		0	\N	\N
632	101	507	0		0	\N	\N
633	101	528	0		0	\N	\N
634	438	538	0		0	\N	\N
635	438	541	0		0	\N	\N
636	438	1806	0		0	\N	\N
637	438	527	0	\N	0	\N	\N
638	438	873	0	\N	0	\N	\N
639	465	1918	0		0	\N	\N
640	465	568	0		0	\N	\N
641	465	570	0		0	\N	\N
642	465	572	0		0	\N	\N
643	465	882	0		0	\N	\N
644	465	884	0		0	\N	\N
645	399	1738	0		0	\N	\N
646	399	1739	0		0	\N	\N
647	436	463	0		0	\N	\N
648	436	472	0		0	\N	\N
649	436	1922	0		0	\N	\N
650	436	578	0		0	\N	\N
651	436	1809	0		0	\N	\N
652	496	1864	0		0	\N	\N
653	496	942	0	\N	0	\N	\N
654	384	1743	0		0	\N	\N
656	384	1747	0		0	\N	\N
657	48	1867	0		0	\N	\N
658	48	1936	0		0	\N	\N
661	48	706	0	\N	0	\N	\N
662	48	871	0	\N	0	\N	\N
663	47	1815	0		0	\N	\N
665	47	609	0	\N	0	\N	\N
666	292	496	0		0	\N	\N
667	170	1763	0		0	\N	\N
668	170	512	0		0	\N	\N
669	170	549	0		0	\N	\N
670	170	1934	0		0	\N	\N
671	254	1895	0		0	\N	\N
672	254	635	0	\N	0	\N	\N
673	254	471	0	\N	0	\N	\N
674	254	676	0	\N	0	\N	\N
676	254	739	0	\N	0	\N	\N
677	254	784	0	\N	0	\N	\N
678	254	842	0	\N	0	\N	\N
679	397	699	0	\N	0	\N	\N
681	134	1763	0		0	\N	\N
682	134	484	0	\N	0	\N	\N
683	134	1126	0	\N	0	\N	\N
684	255	1727	0		0	\N	\N
685	255	1762	0		0	\N	\N
686	255	1785	0		0	\N	\N
687	255	487	0		0	\N	\N
688	255	471	0		0	\N	\N
689	255	1865	0		0	\N	\N
691	255	1007	0	\N	0	\N	\N
692	255	1022	0	\N	0	\N	\N
693	255	752	0	\N	0	\N	\N
694	255	907	0	\N	0	\N	\N
696	537	1554	0		0	\N	\N
697	537	1753	0		0	\N	\N
698	537	1786	0		0	\N	\N
699	537	890	0	\N	0	\N	\N
700	440	1837	0		0	\N	\N
701	12	561	0		0	\N	\N
703	234	1814	0		0	\N	\N
704	240	1726	0		0	\N	\N
705	240	504	0		0	\N	\N
706	240	556	0		0	\N	\N
707	11	488	0		0	\N	\N
708	11	674	0		0	\N	\N
709	538	1755	0		0	\N	\N
710	538	583	0		0	\N	\N
711	538	766	0	\N	0	\N	\N
712	11	1816	0		0	\N	\N
714	414	1920	0		0	\N	\N
716	414	715	0	\N	0	\N	\N
717	14	1799	0		0	\N	\N
718	14	1864	0		0	\N	\N
720	14	716	0	\N	0	\N	\N
721	14	777	0	\N	0	\N	\N
722	14	940	0	\N	0	\N	\N
724	13	557	0		0	\N	\N
725	13	575	0		0	\N	\N
726	13	1808	0		0	\N	\N
727	13	787	0	\N	0	\N	\N
728	409	910	0	\N	0	\N	\N
730	197	1798	0		0	\N	\N
731	241	475	0		0	\N	\N
732	241	1724	0		0	\N	\N
733	241	496	0		0	\N	\N
734	87	501	0		0	\N	\N
735	456	483	0		0	\N	\N
736	434	463	0		0	\N	\N
737	434	1843	0		0	\N	\N
738	434	1844	0		0	\N	\N
739	434	1783	0		0	\N	\N
741	434	472	0		0	\N	\N
742	434	500	0		0	\N	\N
743	434	1917	0		0	\N	\N
744	434	1923	0		0	\N	\N
745	434	1924	0		0	\N	\N
746	434	703	0	\N	0	\N	\N
747	434	922	0	\N	0	\N	\N
748	434	957	0	\N	0	\N	\N
749	249	1671	0		0	\N	\N
750	249	1681	0		0	\N	\N
751	249	1752	0		0	\N	\N
752	249	486	0		0	\N	\N
753	249	495	0		0	\N	\N
754	249	507	0		0	\N	\N
755	249	645	0	\N	0	\N	\N
756	249	677	0	\N	0	\N	\N
757	249	777	0	\N	0	\N	\N
759	249	843	0	\N	0	\N	\N
760	224	1770	0		0	\N	\N
761	224	1778	0		0	\N	\N
762	224	1797	0		0	\N	\N
763	541	1864	0		0	\N	\N
764	541	1734	0		0	\N	\N
765	541	1758	0		0	\N	\N
768	541	654	0	sé	0	\N	\N
769	541	797	0	\N	0	\N	\N
771	540	1935	0		0	\N	\N
772	542	907	0	\N	0	\N	\N
773	542	1045	0	 Podría 	0	\N	\N
774	542	1756	0		0	\N	\N
775	542	1886	0		0	\N	\N
776	542	512	0		0	\N	\N
777	542	517	0		0	\N	\N
778	542	527	0		0	\N	\N
780	542	555	0		0	\N	\N
782	542	592	0		0	\N	\N
783	542	976	0	\N	0	\N	\N
784	542	997	0	\N	0	\N	\N
786	544	1700	0		0	\N	\N
787	544	1701	0		0	\N	\N
788	544	1867	0		0	\N	\N
789	544	1882	0		0	\N	\N
790	544	1884	0		0	\N	\N
792	544	575	0		0	\N	\N
794	544	1078	0	 Tengo 	0	\N	\N
798	544	724	0	tengo	0	\N	\N
801	544	753	0	Tengo	0	\N	\N
802	544	768	0	 tengo 	0	\N	\N
803	544	975	0	tenemos	0	\N	\N
806	544	1055	0	 Tengo 	0	\N	\N
807	544	1111	0	tenemos	0	\N	\N
808	4	1133	0	\N	0	\N	\N
810	5	1132	1		0	\N	\N
811	16	1134	0	\N	0	\N	\N
813	20	1135	1	\N	0	\N	\N
814	20	1398	2		0	\N	\N
815	20	1399	3		0	\N	\N
816	23	1136	0	\N	0	\N	\N
818	24	1137	1	\N	0	\N	\N
819	24	1400	2		0	\N	\N
820	25	1398	0	\N	0	\N	\N
821	25	1138	0	\N	0	\N	\N
824	26	1139	1	\N	0	\N	\N
829	28	1140	1	\N	0	\N	\N
830	28	565	2		0	\N	\N
831	28	818	3	\N	0	\N	\N
840	546	1402	0	\N	0	\N	\N
842	455	834	0	\N	0	\N	\N
843	455	841	0	\N	0	\N	\N
846	455	940	0	\N	0	\N	\N
847	28	1384	0	\N	0	\N	\N
848	28	833	0	\N	0	\N	\N
851	29	1141	1	\N	0	\N	\N
852	29	1137	2	\N	0	\N	\N
853	29	1403	3		0	\N	\N
855	123	1197	0	\N	0	\N	\N
856	123	1246	0	\N	0	\N	\N
858	50	1762	0		0	\N	\N
859	50	601	0	\N	0	\N	\N
860	50	613	0	\N	0	\N	\N
861	50	769	0	\N	0	\N	\N
862	50	1153	0	\N	0	\N	\N
863	32	1143	0	\N	0	\N	\N
865	31	1142	1	\N	0	\N	\N
866	31	1404	2		0	\N	\N
869	33	1144	1	\N	0	\N	\N
870	33	1249	2	\N	0	\N	\N
872	34	1145	0	\N	0	\N	\N
873	35	1278	0	\N	0	\N	\N
874	35	1146	0	\N	0	\N	\N
875	36	1400	0	\N	0	\N	\N
876	36	1147	0	\N	0	\N	\N
877	39	1148	0	\N	0	\N	\N
878	42	1149	0	\N	0	\N	\N
880	43	1150	1	\N	0	\N	\N
881	43	1406	2		0	\N	\N
882	45	1151	0	\N	0	\N	\N
883	49	869	0	\N	0	\N	\N
884	62	1155	0	\N	0	\N	\N
885	66	1156	0	\N	0	\N	\N
887	67	1157	1	\N	0	\N	\N
888	67	1407	2		0	\N	\N
889	69	1158	0	\N	0	\N	\N
890	70	1159	0	\N	0	\N	\N
894	73	1321	1	\N	0	\N	\N
895	73	1408	2		0	\N	\N
897	548	1386	0	\N	0	\N	\N
898	549	719	0	\N	0	\N	\N
899	76	1158	0	\N	0	\N	\N
900	76	1162	0	\N	0	\N	\N
901	76	1304	0	\N	0	\N	\N
902	550	1409	1		0	\N	\N
903	550	1410	2		0	\N	\N
904	550	1411	3		0	\N	\N
905	225	1163	0	\N	0	\N	\N
906	225	1235	0	\N	0	\N	\N
908	551	1171	0	\N	0	\N	\N
909	551	1294	0	\N	0	\N	\N
910	93	1838	0		0	\N	\N
911	83	1167	0	\N	0	\N	\N
913	81	1165	1	\N	0	\N	\N
914	81	1412	2		0	\N	\N
915	82	1166	0	\N	0	\N	\N
917	86	1168	1	\N	0	\N	\N
918	86	1413	2		0	\N	\N
920	89	1169	1	\N	0	\N	\N
921	89	1414	2		0	\N	\N
922	91	1251	0	\N	0	\N	\N
923	91	1265	0	\N	0	\N	\N
924	95	1172	0	\N	0	\N	\N
925	96	1173	0	\N	0	\N	\N
926	107	1175	0	\N	0	\N	\N
927	107	1204	0	\N	0	\N	\N
928	110	1176	0	\N	0	\N	\N
932	114	1177	2	\N	0	\N	\N
933	114	1415	3		0	\N	\N
934	115	1178	0	\N	0	\N	\N
935	116	1179	0	\N	0	\N	\N
944	117	1180	3	\N	0	\N	\N
945	117	1417	4		0	\N	\N
948	119	1185	1	\N	0	\N	\N
949	119	1181	2	\N	0	\N	\N
950	119	1418	3		0	\N	\N
954	120	1328	1	\N	0	\N	\N
955	120	1271	2	\N	0	\N	\N
957	120	1419	4		0	\N	\N
958	553	1182	0	\N	0	\N	\N
960	121	1183	1	\N	0	\N	\N
961	121	1420	2		0	\N	\N
967	99	591	1		0	\N	\N
969	99	497	3		0	\N	\N
970	99	472	4		0	\N	\N
971	99	1184	5	\N	0	\N	\N
972	99	1832	6		0	\N	\N
973	99	1421	7		0	\N	\N
975	554	1422	1		0	\N	\N
976	554	1423	2		0	\N	\N
977	126	1182	0	\N	0	\N	\N
978	126	1185	0	\N	0	\N	\N
979	126	1383	0	\N	0	\N	\N
980	127	1184	0	\N	0	\N	\N
981	127	1186	0	\N	0	\N	\N
983	129	1187	0	\N	0	\N	\N
984	129	835	0	\N	0	\N	\N
985	131	1188	0	\N	0	\N	\N
986	132	1189	0	\N	0	\N	\N
988	135	1190	1	\N	0	\N	\N
989	135	1424	2		0	\N	\N
990	138	1191	0	\N	0	\N	\N
991	138	1424	0	\N	0	\N	\N
992	139	1192	0	\N	0	\N	\N
993	140	1193	0	\N	0	\N	\N
994	142	1194	0	\N	0	\N	\N
997	145	1195	0	\N	0	\N	\N
998	149	1196	0	\N	0	\N	\N
999	151	1418	0	\N	0	\N	\N
1000	151	1197	0	\N	0	\N	\N
1001	152	1198	0	\N	0	\N	\N
1002	154	1199	0	\N	0	\N	\N
1003	154	1905	0		0	\N	\N
1004	157	1200	0	\N	0	\N	\N
1006	159	1201	1	\N	0	\N	\N
1007	159	1425	2		0	\N	\N
1010	161	1202	1	\N	0	\N	\N
1012	161	1426	3		0	\N	\N
1013	162	1203	0	\N	0	\N	\N
1015	165	1204	0	\N	0	\N	\N
1016	558	1182	0	\N	0	\N	\N
1017	558	1270	0	\N	0	\N	\N
1018	169	1205	0	\N	0	\N	\N
1024	298	1376	1	\N	0	\N	\N
1025	298	1333	2	\N	0	\N	\N
1026	298	1268	3	\N	0	\N	\N
1027	298	1427	4		0	\N	\N
1031	171	1427	2	\N	0	\N	\N
1032	171	1206	3	\N	0	\N	\N
1033	171	1428	4		0	\N	\N
1035	173	1207	1	\N	0	\N	\N
1036	173	1429	2		0	\N	\N
1037	174	1208	0	\N	0	\N	\N
1039	177	1209	1	\N	0	\N	\N
1040	177	1430	2		0	\N	\N
1046	178	1211	1	\N	0	\N	\N
1047	178	1431	2		0	\N	\N
1048	178	1432	3		0	\N	\N
1049	560	1210	1	\N	0	\N	\N
1050	560	1211	2	\N	0	\N	\N
1051	560	1208	3	\N	0	\N	\N
1052	560	1433	4		0	\N	\N
1053	181	1212	0	\N	0	\N	\N
1054	181	1225	0	\N	0	\N	\N
1055	181	1306	0	\N	0	\N	\N
1058	182	1434	1		0	\N	\N
1059	561	1308	1	\N	0	\N	\N
1060	561	1213	2	\N	0	\N	\N
1061	561	1435	3		0	\N	\N
1063	183	1214	1	\N	0	\N	\N
1064	183	1436	2		0	\N	\N
1067	184	1888	1		0	\N	\N
1068	184	1215	2	\N	0	\N	\N
1069	184	1437	3		0	\N	\N
1071	185	1216	1	\N	0	\N	\N
1072	187	1217	0	\N	0	\N	\N
1073	188	1218	0	\N	0	\N	\N
1075	189	1219	1	\N	0	\N	\N
1076	189	1438	2		0	\N	\N
1078	192	1220	1	\N	0	\N	\N
1081	193	1221	1	\N	0	\N	\N
1082	193	1440	2		0	\N	\N
1084	194	1222	1	\N	0	\N	\N
1085	194	1441	2		0	\N	\N
1088	195	1225	1	\N	0	\N	\N
1089	195	1223	2	\N	0	\N	\N
1090	195	1442	3		0	\N	\N
1091	196	1224	0	\N	0	\N	\N
1092	199	1225	0	\N	0	\N	\N
1093	562	1226	0	\N	0	\N	\N
1094	202	1226	0	\N	0	\N	\N
1095	563	1443	1		0	\N	\N
1098	208	1227	1	\N	0	\N	\N
1099	208	1444	2		0	\N	\N
1101	210	1228	1	\N	0	\N	\N
1102	210	1445	2		0	\N	\N
1104	211	1229	1	\N	0	\N	\N
1105	211	1446	2		0	\N	\N
1106	366	1313	0	\N	0	\N	\N
1107	564	1230	0	\N	0	\N	\N
1108	213	1231	0	\N	0	\N	\N
1109	215	1232	0	\N	0	\N	\N
1111	216	1233	1	\N	0	\N	\N
1113	216	558	0	\N	0	\N	\N
1114	216	618	0	\N	0	\N	\N
1116	565	1447	0	\N	0	\N	\N
1118	223	1234	1	\N	0	\N	\N
1119	223	1448	2		0	\N	\N
1123	230	1233	2	\N	0	\N	\N
1124	230	1449	3		0	\N	\N
1125	231	1171	0	\N	0	\N	\N
1126	231	1238	0	\N	0	\N	\N
1128	235	1239	1	\N	0	\N	\N
1129	235	1450	2		0	\N	\N
1131	238	1240	0	\N	0	\N	\N
1132	239	1241	0	\N	0	\N	\N
1135	244	1243	1	\N	0	\N	\N
1136	244	1451	2		0	\N	\N
1139	242	1135	1	\N	0	\N	\N
1140	242	1242	2	\N	0	\N	\N
1141	242	1452	3		0	\N	\N
1142	566	1244	0	\N	0	\N	\N
1144	294	1266	0	\N	0	\N	\N
1145	250	1246	0	\N	0	\N	\N
1147	261	1247	1	\N	0	\N	\N
1148	261	1453	2		0	\N	\N
1149	5	1188	0		0	\N	\N
1151	264	1248	1	\N	0	\N	\N
1152	264	1454	2		0	\N	\N
1153	265	1249	0	\N	0	\N	\N
1155	274	1254	0		0	\N	\N
1156	266	1250	0	\N	0	\N	\N
1157	270	1251	0	\N	0	\N	\N
1158	270	771	0	\N	0	\N	\N
1160	271	1252	1	\N	0	\N	\N
1161	271	1455	2		0	\N	\N
1163	371	1318	0	\N	0	\N	\N
1164	273	1253	0	\N	0	\N	\N
1166	567	1871	0		0	\N	\N
1170	276	1255	1	\N	0	\N	\N
1171	276	1237	2	\N	0	\N	\N
1172	276	1410	3	\N	0	\N	\N
1173	278	1256	0	\N	0	\N	\N
1175	280	1258	0	\N	0	\N	\N
1176	280	802	0	\N	0	\N	\N
1177	568	1257	0	\N	0	\N	\N
1179	281	1259	1	\N	0	\N	\N
1180	281	1456	2		0	\N	\N
1181	283	1260	0	\N	0	\N	\N
1182	569	1457	1		0	\N	\N
1183	570	1382	0	\N	0	\N	\N
1184	570	1068	0	\N	0	\N	\N
1185	570	748	0	\N	0	\N	\N
1187	500	1458	1		0	\N	\N
1188	284	1261	0	\N	0	\N	\N
1189	286	1262	0	\N	0	\N	\N
1191	288	1263	1	\N	0	\N	\N
1192	288	1459	2		0	\N	\N
1194	571	1264	0	\N	0	\N	\N
1195	571	566	0		0	\N	\N
1196	571	647	0	\N	0	\N	\N
1197	291	1383	0	\N	0	\N	\N
1198	502	1460	1		0	\N	\N
1201	297	1461	2		0	\N	\N
1203	299	1269	1	\N	0	\N	\N
1204	299	1462	2		0	\N	\N
1205	300	1270	0	\N	0	\N	\N
1206	303	1272	0	\N	0	\N	\N
1208	304	1273	1	\N	0	\N	\N
1209	304	1463	2		0	\N	\N
1210	306	1274	0	\N	0	\N	\N
1211	309	1277	0	\N	0	\N	\N
1212	312	1278	0	\N	0	\N	\N
1213	314	1279	0	\N	0	\N	\N
1215	316	1280	0	\N	0	\N	\N
1216	321	1281	0	\N	0	\N	\N
1219	315	1283	0	\N	0	\N	\N
1220	315	1307	0	\N	0	\N	\N
1222	326	1284	1	\N	0	\N	\N
1223	326	1464	2		0	\N	\N
1225	327	1285	1	\N	0	\N	\N
1226	327	1465	2		0	\N	\N
1228	573	1466	1		0	\N	\N
1229	330	1287	1	\N	0	\N	\N
1230	330	1467	2		0	\N	\N
1231	331	1150	0	\N	0	\N	\N
1232	329	1318	0		0	\N	\N
1233	334	1289	0	\N	0	\N	\N
1234	335	1290	0	\N	0	\N	\N
1235	336	1291	0	\N	0	\N	\N
1237	337	1292	1	\N	0	\N	\N
1238	337	1468	2		0	\N	\N
1240	574	1293	1	\N	0	\N	\N
1241	574	1469	2		0	\N	\N
1242	338	1302	0	\N	0	\N	\N
1243	574	1377	0	\N	0	\N	\N
1244	339	1164	0	\N	0	\N	\N
1246	341	1296	1	\N	0	\N	\N
1247	341	1470	2		0	\N	\N
1248	342	1297	0	\N	0	\N	\N
1249	343	1298	0	\N	0	\N	\N
1253	368	1315	1	\N	0	\N	\N
1254	368	1471	2		0	\N	\N
1255	344	1315	1	\N	0	\N	\N
1256	344	1299	2	\N	0	\N	\N
1257	344	1472	3		0	\N	\N
1259	347	1300	1	\N	0	\N	\N
1260	347	1473	2		0	\N	\N
1263	348	1474	2		0	\N	\N
1264	575	1301	0	\N	0	\N	\N
1265	349	1302	0	\N	0	\N	\N
1266	351	1303	0	\N	0	\N	\N
1267	352	1409	0		0	\N	\N
1268	352	1411	0		0	\N	\N
1269	353	1305	0	\N	0	\N	\N
1270	198	1307	0	\N	0	\N	\N
1271	356	1224	0		0	\N	\N
1273	359	1309	1	\N	0	\N	\N
1274	359	1475	2		0	\N	\N
1275	359	1476	3		0	\N	\N
1276	362	1310	0	\N	0	\N	\N
1278	363	1311	1	\N	0	\N	\N
1279	363	1477	2		0	\N	\N
1280	365	1312	0	\N	0	\N	\N
1281	367	1322	0	\N	0	\N	\N
1282	367	1314	0	\N	0	\N	\N
1283	369	1316	0	\N	0	\N	\N
1284	372	1319	0	\N	0	\N	\N
1285	373	1320	0	\N	0	\N	\N
1286	374	1321	0	\N	0	\N	\N
1288	375	1322	1	\N	0	\N	\N
1289	375	1478	2		0	\N	\N
1290	378	1323	0	\N	0	\N	\N
1292	379	1324	1	\N	0	\N	\N
1294	381	1326	0	\N	0	\N	\N
1295	382	1327	0	\N	0	\N	\N
1296	382	1334	0	\N	0	\N	\N
1298	383	1328	0	\N	0	\N	\N
1299	385	1329	0	\N	0	\N	\N
1301	387	1331	0	\N	0	\N	\N
1302	388	1332	0	\N	0	\N	\N
1303	390	1333	0	\N	0	\N	\N
1304	392	1334	0	\N	0	\N	\N
1305	393	1335	0	\N	0	\N	\N
1306	394	1336	0	\N	0	\N	\N
1307	395	1337	0	\N	0	\N	\N
1308	401	1339	0	\N	0	\N	\N
1309	404	1340	0	\N	0	\N	\N
1310	104	1174	0	\N	0	\N	\N
1311	227	1480	1		0	\N	\N
1312	386	1330	1	\N	0	\N	\N
1313	386	1481	2		0	\N	\N
1314	433	1351	0	\N	0	\N	\N
1315	453	1362	0	\N	0	\N	\N
1316	498	1380	0	\N	0	\N	\N
1317	505	1386	0	\N	0	\N	\N
1318	506	1432	0	\N	0	\N	\N
1319	506	1387	0	\N	0	\N	\N
1321	576	1482	1		0	\N	\N
1323	576	1389	0	\N	0	\N	\N
1325	534	1396	1	\N	0	\N	\N
1326	534	1484	2		0	\N	\N
1327	534	1715	0		0	\N	\N
1328	534	1044	0	\N	0	\N	\N
1329	489	1485	1		0	\N	\N
1330	307	1486	1		0	\N	\N
1331	324	1487	1		0	\N	\N
1332	325	1488	1		0	\N	\N
1333	370	1489	1		0	\N	\N
1334	370	1490	2		0	\N	\N
1335	396	1491	1		0	\N	\N
1336	405	1341	0	\N	0	\N	\N
1337	411	1342	0	\N	0	\N	\N
1338	413	1343	0	\N	0	\N	\N
1339	415	1271	0	\N	0	\N	\N
1340	415	1344	0	\N	0	\N	\N
1341	416	1345	0	\N	0	\N	\N
1342	417	1346	0	\N	0	\N	\N
1343	418	1347	0	\N	0	\N	\N
1344	419	1348	0	\N	0	\N	\N
1347	431	1492	2		0	\N	\N
1348	577	1349	0	\N	0	\N	\N
1349	432	1350	0	\N	0	\N	\N
1353	437	942	1	\N	0	\N	\N
1355	437	1494	3		0	\N	\N
1356	443	1354	0	\N	0	\N	\N
1357	444	1355	0	\N	0	\N	\N
1359	447	1356	1	\N	0	\N	\N
1360	447	1495	2		0	\N	\N
1363	449	1358	0	\N	0	\N	\N
1364	578	1175	0	\N	0	\N	\N
1365	578	1357	0	\N	0	\N	\N
1368	450	1496	2		0	\N	\N
1369	452	1361	0	\N	0	\N	\N
1370	452	1140	0	\N	0	\N	\N
1372	460	1363	1	\N	0	\N	\N
1373	460	1497	2		0	\N	\N
1374	462	1364	0	\N	0	\N	\N
1376	467	1365	1	\N	0	\N	\N
1377	467	1498	2		0	\N	\N
1378	471	1366	0	\N	0	\N	\N
1379	579	1499	1		0	\N	\N
1380	483	1373	0	\N	0	\N	\N
1381	483	1374	0	\N	0	\N	\N
1382	474	1367	0	\N	0	\N	\N
1383	580	1500	1		0	\N	\N
1384	580	1501	2		0	\N	\N
1387	477	1372	1	\N	0	\N	\N
1388	477	1369	2	\N	0	\N	\N
1389	477	1502	3		0	\N	\N
1391	479	1370	1	\N	0	\N	\N
1392	479	1503	2		0	\N	\N
1393	480	1371	0	\N	0	\N	\N
1394	480	1392	0	\N	0	\N	\N
1395	581	1504	1		0	\N	\N
1396	582	1505	1		0	\N	\N
1397	481	1372	0	\N	0	\N	\N
1398	482	1373	0	\N	0	\N	\N
1400	484	1375	1	\N	0	\N	\N
1406	485	1507	3		0	\N	\N
1407	486	1377	0	\N	0	\N	\N
1409	497	1379	1	\N	0	\N	\N
1410	497	1508	2		0	\N	\N
1411	499	1381	0	\N	0	\N	\N
1412	503	1384	0	\N	0	\N	\N
1413	504	1385	0	\N	0	\N	\N
1415	507	1388	1	\N	0	\N	\N
1416	507	1509	2		0	\N	\N
1417	511	1510	1		0	\N	\N
1419	512	1391	1	\N	0	\N	\N
1420	512	1511	2		0	\N	\N
1421	513	1332	0	\N	0	\N	\N
1422	513	1346	0	\N	0	\N	\N
1423	513	1392	0	\N	0	\N	\N
1425	514	1393	1	\N	0	\N	\N
1426	514	1512	2		0	\N	\N
1429	517	1513	2		0	\N	\N
1430	526	1395	0	\N	0	\N	\N
1433	539	1397	1	\N	0	\N	\N
1434	539	1514	2		0	\N	\N
1435	77	1163	0	\N	0	\N	\N
1436	451	1359	0	\N	0	\N	\N
1437	451	1496	0	\N	0	\N	\N
1438	583	1221	0	\N	0	\N	\N
1439	583	799	0	\N	0	\N	\N
1442	6	1723	1		0	\N	\N
1444	6	1045	3	\N	0	\N	\N
1445	6	1515	4		0	\N	\N
1446	8	1192	0	\N	0	\N	\N
1447	8	1373	0	\N	0	\N	\N
1448	585	1516	1		0	\N	\N
1449	586	1517	1		0	\N	\N
1450	26	1498	0	\N	0	\N	\N
1451	587	1401	0		0	\N	\N
1452	311	1754	0		0	\N	\N
1455	552	1416	0		0	\N	\N
1456	552	1276	0	\N	0	\N	\N
1457	584	1518	1		0	\N	\N
1459	588	1519	1		0	\N	\N
1460	589	1520	1		0	\N	\N
1461	310	1521	1		0	\N	\N
1462	74	1522	1		0	\N	\N
1463	590	1523	1		0	\N	\N
1464	591	1523	0		0	\N	\N
1465	332	1524	1		0	\N	\N
1466	510	1525	1		0	\N	\N
1467	559	1526	1		0	\N	\N
1468	557	1527	1		0	\N	\N
1469	148	1196	0	\N	0	\N	\N
1471	494	1378	0	\N	0	\N	\N
1475	19	1874	0		0	\N	\N
1476	19	1886	0		0	\N	\N
1477	260	1716	0		0	\N	\N
1478	149	1435	0	\N	0	\N	\N
1479	217	1231	0	\N	0	\N	\N
1480	473	1366	0	\N	0	\N	\N
1481	473	1374	0	\N	0	\N	\N
1482	469	1315	0	\N	0	\N	\N
1483	469	1344	0	\N	0	\N	\N
1484	143	1458	0		0	\N	\N
1485	592	535	0		0	\N	\N
1486	455	1402	0	\N	0	\N	\N
1488	457	1164	0	\N	0	\N	\N
1490	320	1124	0	\N	0	\N	\N
1491	593	867	0	\N	0	\N	\N
1492	594	939	0	 Oye 	0	\N	\N
1493	594	595	0	\N	0	\N	\N
1494	594	980	0	\N	0	\N	\N
1495	219	1232	0	\N	0	\N	\N
1496	219	1253	0	\N	0	\N	\N
1497	541	1215	0	\N	0	\N	\N
1498	595	1163	0	\N	0	\N	\N
1499	595	1321	0	\N	0	\N	\N
1500	595	985	0	\N	0	\N	\N
1501	595	538	0		0	\N	\N
1502	595	1054	0	\N	0	\N	\N
1503	496	1493	0	\N	0	\N	\N
1504	470	1921	1		0	\N	\N
1505	470	1528	2		0	\N	\N
1506	350	989	1	\N	0	\N	\N
1507	350	1529	2		0	\N	\N
1509	543	1530	2		0	\N	\N
1510	41	970	1	\N	0	\N	\N
1511	41	1531	2		0	\N	\N
1512	224	1287	0	\N	0	\N	\N
1513	224	1512	0	\N	0	\N	\N
1514	555	1973	0	\N	0	\N	\N
1515	144	1973	0	\N	0	\N	\N
1516	464	1606	0	\N	0	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_usage_scene_rel (usage_id, scene_id) FROM stdin;
1	1
2	1
3	1
4	1
5	1
6	1
7	1
8	1
9	1
10	1
11	1
12	1
13	1
14	1
15	1
16	1
17	2
18	2
19	2
20	2
21	2
22	2
23	2
24	2
25	2
26	2
27	2
28	2
29	2
30	3
31	3
32	3
33	3
34	3
35	3
36	3
37	3
38	3
39	3
40	4
41	4
42	4
43	4
44	4
45	4
46	4
47	4
48	4
49	4
50	5
51	5
52	5
53	5
54	5
55	5
56	5
57	5
58	5
59	5
60	6
61	6
62	6
63	6
64	6
65	6
66	6
67	6
68	6
69	6
70	6
71	6
72	6
73	6
74	6
75	7
76	7
77	7
78	7
79	7
80	7
81	7
82	7
83	7
84	7
85	7
86	7
87	7
88	8
89	8
90	8
91	8
92	8
93	8
94	8
95	8
96	8
97	8
98	8
99	8
100	8
101	8
102	9
103	9
104	9
105	9
106	9
107	9
108	9
109	9
110	9
111	9
112	9
113	9
114	10
115	10
116	10
117	10
118	10
119	10
120	10
121	10
122	10
123	11
124	11
125	11
126	11
127	11
128	11
129	11
130	11
131	11
132	11
133	11
134	11
135	11
136	11
137	11
138	11
139	11
140	11
141	11
142	11
143	11
144	11
145	11
146	11
147	11
148	13
149	13
150	13
151	13
152	13
153	13
154	13
155	13
156	13
157	13
158	13
159	14
160	14
161	14
162	14
163	14
164	14
165	14
166	14
167	14
168	14
169	14
170	14
171	15
172	15
173	15
174	15
175	15
176	15
177	15
178	15
179	15
180	15
181	15
182	15
183	15
184	16
185	16
186	16
187	16
188	16
189	16
190	16
191	16
192	16
193	16
194	16
195	16
196	16
197	16
198	16
199	16
200	17
201	17
202	17
203	17
204	17
205	17
206	17
207	17
208	17
209	18
210	18
211	18
212	18
213	18
214	18
215	18
216	18
217	18
218	18
219	18
220	18
221	18
222	19
223	19
224	19
225	19
226	19
227	19
228	19
229	19
230	19
231	19
232	19
233	19
234	19
235	19
236	20
237	20
238	20
239	20
240	20
241	20
242	20
243	20
244	20
245	20
246	20
247	21
248	21
249	21
250	21
251	21
252	21
253	21
254	21
255	21
256	21
257	21
258	21
259	21
260	21
261	21
262	21
263	21
264	22
265	22
266	22
267	22
268	22
269	22
270	22
271	22
272	22
273	22
274	22
275	22
276	22
277	22
278	22
279	23
280	23
281	23
282	23
283	23
284	23
285	23
286	23
287	23
288	23
289	23
290	23
291	23
292	23
293	23
294	23
295	23
296	24
297	24
298	24
299	24
300	24
301	24
302	24
303	24
304	24
305	24
306	24
307	24
308	24
309	25
310	25
311	25
312	25
313	25
314	25
315	25
316	25
317	25
318	25
319	25
320	25
321	25
322	25
323	25
324	25
325	25
326	26
327	26
328	26
329	26
330	26
331	26
332	26
333	26
334	26
335	26
336	26
337	26
338	26
339	26
340	26
341	27
342	27
343	27
344	27
345	27
346	27
347	27
348	27
349	27
350	27
351	27
352	28
353	28
354	28
355	28
356	28
357	28
358	28
359	28
360	28
361	28
362	28
363	28
364	28
365	29
366	29
367	29
368	29
369	29
370	29
371	29
372	29
373	29
374	29
375	29
376	29
377	29
378	29
379	29
380	29
381	30
382	30
383	30
384	30
385	30
386	30
387	30
388	30
389	30
390	30
391	30
392	30
393	30
394	30
395	30
396	30
397	31
398	31
399	31
400	31
401	31
402	31
403	31
404	31
405	31
406	31
407	31
408	31
409	31
410	30
411	32
412	32
413	32
414	32
415	32
416	32
417	32
418	32
419	32
420	32
421	33
422	33
423	33
424	33
425	33
426	33
427	33
428	33
429	33
430	33
431	33
432	33
433	33
434	34
435	34
436	34
437	34
438	34
439	34
440	34
441	34
442	34
443	34
444	35
445	35
446	35
447	35
448	35
449	35
450	35
451	35
452	35
453	35
454	35
455	35
456	35
457	36
458	36
459	36
460	36
461	36
462	36
463	36
464	36
465	36
466	36
467	36
468	36
469	36
470	37
471	37
472	37
473	37
474	37
475	37
476	37
477	37
478	37
479	37
480	37
481	37
482	37
483	37
484	38
485	38
486	38
487	38
488	38
489	38
490	38
491	38
492	38
493	38
494	38
495	38
496	38
497	39
498	39
499	39
500	39
501	39
502	39
503	39
504	39
505	39
506	39
525	16
526	6
527	21
528	21
531	13
532	5
533	5
534	23
535	23
536	23
537	21
543	6
546	2
548	3
550	7
551	7
552	24
553	24
554	10
557	11
560	15
561	28
562	20
563	35
564	18
566	20
583	9
584	18
586	26
588	25
589	25
591	17
594	37
455	2
277	9
202	20
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
692	ver	\N	V	\N
836	resfriado	1	R	\N
837	cabeza	1	C	\N
838	vientre	1	V	\N
839	grado	1	G	\N
975	sucio	1	S	\N
976	aburrido	1	A	\N
977	lado	1	L	\N
1110	mediodía	1	M	\N
1111	noche	1	N	\N
1114	anteayer	1	A	\N
733		\N		\N
1	hola	\N	\N	\N
2	María	\N	\N	\N
3	qué tal	\N	\N	\N
4	bien	\N	\N	\N
5	y	\N	\N	\N
6	tú	\N	\N	\N
7	Juan	\N	\N	\N
8	muy	\N	\N	\N
9	gracias	\N	\N	\N
10	a	\N	\N	\N
11	dónde	\N	\N	\N
12	ir	\N	\N	\N
13	el	\N	\N	\N
14	biblioteca	\N	\N	\N
15	para	\N	\N	\N
16	qué	\N	\N	\N
17	tener, que	\N	\N	\N
18	prepararse	\N	\N	\N
19	examen	\N	\N	\N
20	de	\N	\N	\N
21	 mañana 	\N	\N	\N
22	ah	\N	\N	\N
23	sí	\N	\N	\N
24	suerte	\N	\N	\N
25	hasta	\N	\N	\N
689	japonés	1	J	\N
690	salir	1	S	\N
691	país	1	P	\N
825	hacer ejercicio	1	E	\N
826	pregunta	1	P	\N
828	contestar	1	C	\N
829	doler	1	D	\N
830	diente	1	D	\N
961	alegre	1	A	\N
962	bajo	1	B	\N
963	bien	\N	B	\N
26	luego	\N	\N	\N
27	cómo	\N	\N	\N
28	con	\N	\N	\N
29	trabajo	\N	\N	\N
30	escrito	\N	\N	\N
31	más o menos 	\N	\N	\N
32	tener	1	T	\N
33	un	\N	\N	\N
34	problema	\N	\N	\N
35	pasar	\N	\N	\N
36	ser que	\N	\N	\N
37	libro	\N	\N	\N
38	recomendado	\N	\N	\N
39	no	\N	\N	\N
40	estar	\N	\N	\N
41	en	\N	\N	\N
42	aquí	\N	\N	\N
43	lo	\N	\N	\N
44	si	\N	\N	\N
45	querer	\N	\N	\N
46	te	\N	\N	\N
47	dejar	\N	\N	\N
48	mucho	\N	\N	\N
49	de nada 	\N	\N	\N
50	cuándo	\N	\N	\N
51	se	\N	\N	\N
52	devolver	\N	\N	\N
53	haber	\N	\N	\N
54	prisa	\N	\N	\N
55	profesor	\N	\N	\N
56	disculpar	\N	\N	\N
57	despacho	\N	\N	\N
58	del	\N	\N	\N
59	Sánchez	\N	\N	\N
60	segundo	\N	\N	\N
61	piso	\N	\N	\N
62	 del 	\N	\N	\N
63	edificio	\N	\N	\N
64	c	\N	\N	\N
65	cuál	\N	\N	\N
66	ser	\N	\N	\N
67	enfrente	\N	\N	\N
68	su	\N	\N	\N
69	creer	\N	\N	\N
70	que	\N	\N	\N
71	perdonar	\N	\N	\N
72	saber	1	S	\N
73	aula	\N	\N	\N
74	clase	\N	\N	\N
75	también	\N	\N	\N
76	junto	\N	\N	\N
77	me	\N	\N	\N
78	llamar	\N	\N	\N
79	gusto	\N	\N	\N
80	Oviedo	\N	\N	\N
81	yo	\N	\N	\N
82	casualidad	\N	\N	\N
83	Carlos	\N	\N	\N
84	llegar	\N	\N	\N
85	medio	\N	\N	\N
86	hora	\N	\N	\N
87	tarde	\N	\N	\N
88	sentir	\N	\N	\N
89	atasco	\N	\N	\N
90	terrible	\N	\N	\N
91	deber	\N	\N	\N
92	salir	\N	\N	\N
93	más	\N	\N	\N
94	temprano	\N	\N	\N
95	evitar	\N	\N	\N
96	horas punta	\N	\N	\N
97	razón	\N	\N	\N
98	invitar	\N	\N	\N
99	copa	\N	\N	\N
100	bueno	1	B	\N
101	valer	\N	\N	\N
102	venir	\N	\N	\N
103	ir a 	\N	\N	\N
104	 tomar 	\N	\N	\N
105	 caramelo 	\N	\N	\N
106	 uno	\N	\N	\N
107	 sí 	\N	\N	\N
108	 por favor 	\N	\N	\N
109	 aquí 	\N	\N	\N
110	 gracias 	\N	\N	\N
111	 saber 	\N	\N	\N
112	 naranja 	\N	\N	\N
113	 muy 	\N	\N	\N
114	 bueno 	\N	\N	\N
115	 mí 	\N	\N	\N
116	 también 	\N	\N	\N
117	 me 	\N	\N	\N
118	 gustar	\N	\N	\N
119	 este	\N	\N	\N
120	 sabor 	\N	\N	\N
121	 no 	\N	\N	\N
122	 azúcar 	\N	\N	\N
123	 fin 	\N	\N	\N
124	 de 	\N	\N	\N
125	 semana 	\N	\N	\N
126	 por fin 	\N	\N	\N
127	 alguno	\N	\N	\N
128	 plan 	\N	\N	\N
129	 ir a	\N	\N	\N
130	 ir 	\N	\N	\N
131	 a 	\N	\N	\N
132	 Madrid 	\N	\N	\N
133	 ver 	\N	\N	\N
134	mi	\N	\N	\N
135	 padre	\N	\N	\N
136	 bien 	\N	\N	\N
137	 tú 	\N	\N	\N
138	 qué 	\N	\N	\N
139	 hacer 	\N	\N	\N
140	 yo 	\N	\N	\N
141	 ir de excursión 	\N	\N	\N
142	 Cáceres 	\N	\N	\N
143	 bueno	\N	\N	\N
144	 idea 	\N	\N	\N
145	 lo 	\N	\N	\N
146	 igualmente 	\N	\N	\N
147	ver	1	V	\N
148	 el 	\N	\N	\N
149	 lunes 	\N	\N	\N
150	 adiós 	\N	\N	\N
151	 hasta 	\N	\N	\N
152	 hola	\N	\N	\N
153	billete	\N	\N	\N
154	 Barcelona 	\N	\N	\N
155	 para 	\N	\N	\N
156	 día 	\N	\N	\N
157	hoy	\N	\N	\N
158	ida	\N	\N	\N
159	 vuelta 	\N	\N	\N
160	 querer 	\N	\N	\N
161	 fumador 	\N	\N	\N
162	o	\N	\N	\N
163	fumador	\N	\N	\N
164	cuánto	\N	\N	\N
165	costar	\N	\N	\N
166	treinta	\N	\N	\N
167	veraneo	\N	\N	\N
168	moreno	\N	\N	\N
169	mes	\N	\N	\N
170	Niza	\N	\N	\N
171	envidia	\N	\N	\N
172	 estar	\N	\N	\N
173	Francia	\N	\N	\N
174	otro	\N	\N	\N
175	ocasión	\N	\N	\N
176	ya	\N	\N	\N
177	cinco	\N	\N	\N
178	vez	\N	\N	\N
179	visitar	\N	\N	\N
180	hermana	\N	\N	\N
181	trabajar	\N	\N	\N
182	París	\N	\N	\N
183	pues	\N	\N	\N
184	último	\N	\N	\N
185	día	\N	\N	\N
186	semestre	\N	\N	\N
187	ir a	\N	\N	\N
188	hacer	\N	\N	\N
189	este	\N	\N	\N
190	verano	\N	\N	\N
191	viajar	\N	\N	\N
192	por	\N	\N	\N
193	Perú	\N	\N	\N
194	amigo	\N	\N	\N
195	fantástico	\N	\N	\N
196	pensar	\N	\N	\N
197	dos	\N	\N	\N
198	semana	\N	\N	\N
199	Málaga	\N	\N	\N
200	\n\t\t\t\t\t\t\t	\N	\N	\N
201	 le 	\N	\N	\N
202	 toser 	\N	\N	\N
203	 apetito 	\N	\N	\N
204	 resfriado 	\N	\N	\N
205	 fiebre 	\N	\N	\N
206	uf	\N	\N	\N
207	por lo menos	\N	\N	\N
208	38	\N	\N	\N
209	 grado	\N	\N	\N
210	tomar	\N	\N	\N
211	 medicina 	\N	\N	\N
212	 curar 	\N	\N	\N
213	 frecuencia 	\N	\N	\N
214	tener que	\N	\N	\N
215		\N	\N	\N
216	tres	\N	\N	\N
217	al	\N	\N	\N
218	 después 	\N	\N	\N
219	comida	\N	\N	\N
220	 Antonio 	\N	\N	\N
221	 cómo 	\N	\N	\N
222	 llegar 	\N	\N	\N
223	Juana 	\N	\N	\N
224	 domingo 	\N	\N	\N
225	 hora 	\N	\N	\N
226	 nueve 	\N	\N	\N
227	 pero 	\N	\N	\N
228	 por qué 	\N	\N	\N
229	 aeropuerto 	\N	\N	\N
230	coche	\N	\N	\N
231	 poder 	\N	\N	\N
232	 contigo 	\N	\N	\N
233	 claro 	\N	\N	\N
234	buenas tardes	\N	\N	\N
235	 contactar 	\N	\N	\N
236	usted	\N	\N	\N
237	 pregunta 	\N	\N	\N
238	 casa 	\N	\N	\N
239	 cuál 	\N	\N	\N
240	 número 	\N	\N	\N
241	 teléfono 	\N	\N	\N
242	cero	\N	\N	\N
243	cuatro	\N	\N	\N
244	 más 	\N	\N	\N
245	 despacio 	\N	\N	\N
246	 por favor	\N	\N	\N
247	 valer 	\N	\N	\N
248	 De nada 	\N	\N	\N
249	 problema 	\N	\N	\N
250	funcionar	\N	\N	\N
251	 fotocopiadora 	\N	\N	\N
252	 A ver...	\N	\N	\N
253	parecer	\N	\N	\N
254	 que 	\N	\N	\N
255	 funcionar	\N	\N	\N
256	 con 	\N	\N	\N
257	 la 	\N	\N	\N
258	 prisa 	\N	\N	\N
259	 en 	\N	\N	\N
260	 biblioteca 	\N	\N	\N
261	Menos mal	\N	\N	\N
262	 se 	\N	\N	\N
263	 sacar	\N	\N	\N
264	 fotocopia	\N	\N	\N
265	 ampliado, da	\N	\N	\N
266	 fácil 	\N	\N	\N
267	 te 	\N	\N	\N
268	 importar	\N	\N	\N
269	 y 	\N	\N	\N
270	 claro que 	\N	\N	\N
271	este 	\N	\N	\N
272	fin	\N	\N	\N
273	de 	\N	\N	\N
274	Elena 	\N	\N	\N
275	viajar 	\N	\N	\N
276	Galicia	\N	\N	\N
277	con mucho gusto	\N	\N	\N
278	alquilar	\N	\N	\N
279	idea	\N	\N	\N
280	Saber	\N	\N	\N
281	conducir	\N	\N	\N
282	claro	\N	\N	\N
283	entonces	\N	\N	\N
284	cuando	\N	\N	\N
285	cansar	\N	\N	\N
286	poner	\N	\N	\N
287	volante	\N	\N	\N
288	vale	\N	\N	\N
289	de acuerdo	\N	\N	\N
290	viaje	\N	\N	\N
291	hace	\N	\N	\N
292	ilusión	\N	\N	\N
293	mí	\N	\N	\N
294	 perdonar 	\N	\N	\N
295	 alguno 	\N	\N	\N
296	 hotel	\N	\N	\N
297	cerca	\N	\N	\N
298	uno	\N	\N	\N
299	Plaza Mayor 	\N	\N	\N
300	 primero 	\N	\N	\N
301	 derecho 	\N	\N	\N
302	 luego 	\N	\N	\N
303	 seguir 	\N	\N	\N
304	 todo 	\N	\N	\N
305	 recto 	\N	\N	\N
306	 llamar	\N	\N	\N
307	 Carlos V 	\N	\N	\N
308	ｄónde 	\N	\N	\N
309	librería	\N	\N	\N
310	Fuentetaja 	\N	\N	\N
311	Lo siento	\N	\N	\N
312	 eso 	\N	\N	\N
313	 banco 	\N	\N	\N
314	 al lado del 	\N	\N	\N
315	 mucho 	\N	\N	\N
316	 alegre 	\N	\N	\N
317	 es que 	\N	\N	\N
318	 acabar de 	\N	\N	\N
319	 comprar 	\N	\N	\N
320	 coche 	\N	\N	\N
321	 compacto 	\N	\N	\N
322	Mercedes	\N	\N	\N
323	color	\N	\N	\N
324	 gris 	\N	\N	\N
325	 metalizado 	\N	\N	\N
326	como	\N	\N	\N
327	profesor 	\N	\N	\N
328	 González 	\N	\N	\N
329	eso	\N	\N	\N
330	 secreto 	\N	\N	\N
331	 falda 	\N	\N	\N
332	 parecer	\N	\N	\N
333	 quedar 	\N	\N	\N
334	 mejor 	\N	\N	\N
335	 otro	\N	\N	\N
336	 gustar 	\N	\N	\N
337	 color 	\N	\N	\N
338	 talla 	\N	\N	\N
339	 ti 	\N	\N	\N
340	 un poco 	\N	\N	\N
341	 corto 	\N	\N	\N
342	quedarse con	\N	\N	\N
343	 otro, tra 	\N	\N	\N
344	 hola 	\N	\N	\N
345	 Pablo 	\N	\N	\N
346	leer	\N	\N	\N
347	Cien años de soledad	\N	\N	\N
348	 García Márquez 	\N	\N	\N
349	 novela	\N	\N	\N
350	 las 	\N	\N	\N
351	es que	\N	\N	\N
352	 ficción 	\N	\N	\N
353	 entonces 	\N	\N	\N
354	 clase 	\N	\N	\N
355	 libro	\N	\N	\N
356	 reportaje	\N	\N	\N
357	 biografía	\N	\N	\N
358	 estudio	\N	\N	\N
359	 interesar	\N	\N	\N
360	ese	\N	\N	\N
361	 tipo 	\N	\N	\N
362	 hacer	\N	\N	\N
363	 fin	\N	\N	\N
364	 Normalmente 	\N	\N	\N
365	 amigo	\N	\N	\N
366	a + el	\N	\N	\N
367	 cine 	\N	\N	\N
368	 habitualmente 	\N	\N	\N
369	 campo 	\N	\N	\N
370	el 	\N	\N	\N
371	 naturaleza 	\N	\N	\N
372	 encantar	\N	\N	\N
373	 junto	\N	\N	\N
374	 próximo	\N	\N	\N
375	 vez 	\N	\N	\N
376	 meter 	\N	\N	\N
377	 moneda 	\N	\N	\N
378	 documento 	\N	\N	\N
379	 original 	\N	\N	\N
380	 valer	\N	\N	\N
381	pulsar	\N	\N	\N
382	 botón 	\N	\N	\N
383	 cambiar 	\N	\N	\N
384	 tamaño 	\N	\N	\N
385	 papel 	\N	\N	\N
386	poder	1	P	\N
387	 gracias	\N	\N	\N
388	 Luis 	\N	\N	\N
389	 Eva 	\N	\N	\N
390	hombre	\N	\N	\N
391	últimamente	\N	\N	\N
392	 ocupado	\N	\N	\N
393	 José 	\N	\N	\N
394	 preocupado	\N	\N	\N
395	 por 	\N	\N	\N
396	 porque 	\N	\N	\N
397	 trabajar	\N	\N	\N
398	 profesor 	\N	\N	\N
399	 academia 	\N	\N	\N
400	 tiempo 	\N	\N	\N
401	 saber	\N	\N	\N
402	 sábado 	\N	\N	\N
403	malo	1	M	\N
404	 pues 	\N	\N	\N
405	 película	\N	\N	\N
406	 mi 	\N	\N	\N
407	 quedar	\N	\N	\N
408	 estación 	\N	\N	\N
409	 perfecto 	\N	\N	\N
410	 y	\N	\N	\N
411	 venir	\N	\N	\N
412	 once 	\N	\N	\N
413	 De acuerdo 	\N	\N	\N
414	Buenos días	\N	\N	\N
415	qué 	\N	\N	\N
416	 desear 	\N	\N	\N
417	 jamón ibérico de bellota	\N	\N	\N
418	sí 	\N	\N	\N
419	veintiún	\N	\N	\N
420	 euro 	\N	\N	\N
421	 kilo 	\N	\N	\N
422	 caro 	\N	\N	\N
423	 algo 	\N	\N	\N
424	 menos 	\N	\N	\N
425	 otro 	\N	\N	\N
426	también 	\N	\N	\N
427	éste	\N	\N	\N
428	 barato 	\N	\N	\N
429	 de bellota 	\N	\N	\N
430	 quince 	\N	\N	\N
431	éste 	\N	\N	\N
432	cuánto 	\N	\N	\N
433	 gramo 	\N	\N	\N
434	 poner 	\N	\N	\N
435	 medio 	\N	\N	\N
436	 siete 	\N	\N	\N
437	 cincuenta 	\N	\N	\N
438	céntimo	\N	\N	\N
439	aquí 	\N	\N	\N
440	decir, me	\N	\N	\N
441	 duda	\N	\N	\N
442	 sobre 	\N	\N	\N
443	 redacción 	\N	\N	\N
444	 poder	\N	\N	\N
445	 su 	\N	\N	\N
446	 despacho 	\N	\N	\N
447	 hablar 	\N	\N	\N
448	 usted 	\N	\N	\N
449	 por supuesto 	\N	\N	\N
450	 cuándo 	\N	\N	\N
451	 convenir	\N	\N	\N
452	 si 	\N	\N	\N
453	 viernes 	\N	\N	\N
454	 a	\N	\N	\N
455	 mediodía 	\N	\N	\N
456	 Ana 	\N	\N	\N
457	 Miguel 	\N	\N	\N
458	 fiesta 	\N	\N	\N
459	 del	\N	\N	\N
460	 pasar	\N	\N	\N
461	la verdad 	\N	\N	\N
462	 apetecer	\N	\N	\N
463	 salir 	\N	\N	\N
464	 enfermo	\N	\N	\N
465	 resfriado	\N	\N	\N
466	 por desgracia 	\N	\N	\N
467	 ya 	\N	\N	\N
468	 más o menos 	\N	\N	\N
469	cuidarse	\N	\N	\N
470	 Isabel 	\N	\N	\N
471	buscar	\N	\N	\N
472	 parecer 	\N	\N	\N
473	 nervioso	\N	\N	\N
474	 pasar 	\N	\N	\N
475	 hacer, me 	\N	\N	\N
476	 favor 	\N	\N	\N
477	 ser que 	\N	\N	\N
478	perder	\N	\N	\N
479	 todo	\N	\N	\N
480	 apunte	\N	\N	\N
481	 literatura 	\N	\N	\N
482	no, me, decir 	\N	\N	\N
483	 dejar, me 	\N	\N	\N
484	 tu	\N	\N	\N
485	 fotocopiar, los 	\N	\N	\N
486	 cómo no 	\N	\N	\N
487	 no, haber, de, qué 	\N	\N	\N
488	oír	1	O	\N
489	 viajar 	\N	\N	\N
490	 mucho	\N	\N	\N
491	 querer	\N	\N	\N
492	 mundo 	\N	\N	\N
493	 adónde 	\N	\N	\N
494	 desde luego 	\N	\N	\N
495	 Asia 	\N	\N	\N
496	 grande 	\N	\N	\N
497	 país	\N	\N	\N
498	 visitar 	\N	\N	\N
499	 en primer lugar 	\N	\N	\N
500	 por ejemplo 	\N	\N	\N
501	 Japón 	\N	\N	\N
502	 Corea 	\N	\N	\N
503	 China 	\N	\N	\N
504	 cultura 	\N	\N	\N
505	 ese	\N	\N	\N
506	 lejos 	\N	\N	\N
507	 camarera 	\N	\N	\N
508	decir, me 	\N	\N	\N
509	 menú 	\N	\N	\N
510	 lo, sentir	\N	\N	\N
511	acabarse	\N	\N	\N
512	 hambre 	\N	\N	\N
513	 tener	\N	\N	\N
514	 sólo 	\N	\N	\N
515	 nos 	\N	\N	\N
516	 bocadillo	\N	\N	\N
517	arreglarse	\N	\N	\N
518	él	\N	\N	\N
519	 recomendar	\N	\N	\N
520	 éste	\N	\N	\N
521	 jamón 	\N	\N	\N
522	 queso 	\N	\N	\N
523	dar, me 	\N	\N	\N
524	ése	\N	\N	\N
525	 de acuerdo 	\N	\N	\N
526	 camisa 	\N	\N	\N
527	 	\N	\N	\N
528	 visitante 	\N	\N	\N
529	 treinta y cinco 	\N	\N	\N
530	la	\N	\N	\N
531	probar, me, la 	\N	\N	\N
532	 probador 	\N	\N	\N
533	 al 	\N	\N	\N
534	 fondo 	\N	\N	\N
535	 oir 	\N	\N	\N
536	 museo 	\N	\N	\N
537	 moderno 	\N	\N	\N
538	 allí 	\N	\N	\N
539	autobús	\N	\N	\N
540	 seis 	\N	\N	\N
541	 por eso	\N	\N	\N
542	 tener que 	\N	\N	\N
543	 línea 	\N	\N	\N
544	 Plaza Mayor 	\N	\N	\N
545	 sur	\N	\N	\N
546	 mejor que 	\N	\N	\N
547	a pie	\N	\N	\N
548	 autobús 	\N	\N	\N
549	 sacar 	\N	\N	\N
550	 foto 	\N	\N	\N
551	prohibir	\N	\N	\N
552	así	\N	\N	\N
553	 base 	\N	\N	\N
554	 militar 	\N	\N	\N
555	 bonito 	\N	\N	\N
556	paisaje	\N	\N	\N
557	 verdad 	\N	\N	\N
558	 parada 	\N	\N	\N
559	muchas gracias	\N	\N	\N
560	 buen viaje 	\N	\N	\N
561	 entrar 	\N	\N	\N
562	 exactamente 	\N	\N	\N
563	 control 	\N	\N	\N
564	 objeto	\N	\N	\N
565	 personal	\N	\N	\N
566	 el	\N	\N	\N
567	 suyo	\N	\N	\N
568	 este 	\N	\N	\N
569	 caja 	\N	\N	\N
570	 así 	\N	\N	\N
571	 puerta 	\N	\N	\N
572	esperar	\N	\N	\N
573	 por  favor 	\N	\N	\N
574	 perdón 	\N	\N	\N
575	 llavero 	\N	\N	\N
576	 quitar	\N	\N	\N
577	 ahora 	\N	\N	\N
578	 colaboración 	\N	\N	\N
579	caer	\N	\N	\N
580	 se	\N	\N	\N
581	 torcer	\N	\N	\N
582	 muñeca 	\N	\N	\N
583	 a  ver 	\N	\N	\N
584	 doler	\N	\N	\N
585	¡ay!	\N	\N	\N
586	 tocar	\N	\N	\N
587	 tan 	\N	\N	\N
588	 fuerte 	\N	\N	\N
589	 roto	\N	\N	\N
590	 bastante 	\N	\N	\N
591	 hinchado 	\N	\N	\N
592	 tardar	\N	\N	\N
593	 curarse 	\N	\N	\N
594	 dos 	\N	\N	\N
595	 semana	\N	\N	\N
596	 a el menos 	\N	\N	\N
597	 ir a 	\N	\N	\N
598	 jugar 	\N	\N	\N
599	 un	\N	\N	\N
600	 partido 	\N	\N	\N
601	 tenis 	\N	\N	\N
602	 próximo 	\N	\N	\N
603	 lo siento 	\N	\N	\N
604	 deporte 	\N	\N	\N
605	 un 	\N	\N	\N
606	 malo	\N	\N	\N
607	 suerte 	\N	\N	\N
608	 recomendar + me 	\N	\N	\N
609	alguno	\N	\N	\N
610	 diccionario 	\N	\N	\N
611	 francés 	\N	\N	\N
612	 español 	\N	\N	\N
613	 ilustrativo	\N	\N	\N
614	 ejemplo	\N	\N	\N
615	 dejar	\N	\N	\N
616	 gracia	\N	\N	\N
617	tener que 	\N	\N	\N
618	 hoy 	\N	\N	\N
619	 igual 	\N	\N	\N
620	se lo	\N	\N	\N
621	 devolver	\N	\N	\N
622	 cuando 	\N	\N	\N
623	 guapo 	\N	\N	\N
624	 cumpleaños 	\N	\N	\N
625	verdad	\N	\N	\N
626	 feliz 	\N	\N	\N
627	 uno 	\N	\N	\N
628	 claro que sí 	\N	\N	\N
629	 por qué no 	\N	\N	\N
630	 invitado 	\N	\N	\N
631	 gusto 	\N	\N	\N
632	 hasta luego 	\N	\N	\N
633	encontrar	\N	\N	\N
634	 mal 	\N	\N	\N
635	 escalofrío	\N	\N	\N
636	 a ver si 	\N	\N	\N
637	 además 	\N	\N	\N
638	 cabeza 	\N	\N	\N
639	 seguro que 	\N	\N	\N
640	coger	\N	\N	\N
641	 gripe 	\N	\N	\N
642	 tener ganas de 	\N	\N	\N
643	 médico 	\N	\N	\N
644	 razón 	\N	\N	\N
645	 decir 	\N	\N	\N
646	 a + el 	\N	\N	\N
647	se 	\N	\N	\N
648	 preocupar	\N	\N	\N
649	decir	\N	\N	\N
650	 llevar 	\N	\N	\N
651	 corbata 	\N	\N	\N
652	 venticinco 	\N	\N	\N
653	 regalo 	\N	\N	\N
654	 señor 	\N	\N	\N
655	 pagar 	\N	\N	\N
656	 tarjeta 	\N	\N	\N
657	 crédito 	\N	\N	\N
658	 aquí tiene 	\N	\N	\N
659	 muy bien 	\N	\N	\N
660	firmar	\N	\N	\N
661	solo	\N	\N	\N
662	 Carmen 	\N	\N	\N
663	 recomendar 	\N	\N	\N
664	 calamar 	\N	\N	\N
665	 tortilla 	\N	\N	\N
666	 pincho 	\N	\N	\N
667	algo	\N	\N	\N
668	 café 	\N	\N	\N
669	tu	\N	\N	\N
670	 familia 	\N	\N	\N
671	 año 	\N	\N	\N
672	 quién 	\N	\N	\N
673	 chica 	\N	\N	\N
674	 hermana 	\N	\N	\N
675	 sobrina 	\N	\N	\N
676	 Pilar 	\N	\N	\N
677	 Juana 	\N	\N	\N
678	 estudiar 	\N	\N	\N
679	 universidad 	\N	\N	\N
680	 matemáticas 	\N	\N	\N
681	 presentar	\N	\N	\N
682	ir	1	I	\N
683	inglés	1	I	\N
685	extranjero	1	E	\N
687	español	1	E	\N
688	hotel	1	H	\N
693	vacación	1	V	\N
694	viaje	1	V	\N
695	viajar	1	V	\N
696	jugar	1	J	\N
697	embajada	1	E	\N
698	encantar	1	E	\N
699	gustar	0	G	\N
700	bien	\N	B	\N
701	correr	1	C	\N
702	despacio	1	D	\N
703	mal	\N	M	\N
704	caminar	1	C	\N
705	nadar	1	N	\N
706	rápido	1	R	\N
707	volar	1	V	\N
708	deporte	1	D	\N
709	no gustar	1	G	\N
710	piscina	1	P	\N
711	autobús	1	A	\N
712	bicicleta	1	B	\N
713	cruce	1	C	\N
714	calle	1	C	\N
715	estanque	1	E	\N
716	paseo	1	P	\N
717	río	1	R	\N
718	taxi	1	T	\N
719	coche	1	C	\N
720	girar	1	G	\N
721	corbata	1	C	\N
722	camisa	1	C	\N
723	empresa	1	E	\N
724	traje	1	T	\N
725	hacer	1	H	\N
726	respirar	1	R	\N
727	teléfono	1	T	\N
728	trabajo	1	T	\N
729	trabajar	1	T	\N
730	ocupado	1	O	\N
731	biblioteca	1	B	\N
732	diccionario	1	D	\N
734	periódico	1	P	\N
735	leer	1	L	\N
736	libro	1	L	\N
737	fotocopia	1	F	\N
738	fotocopiar	1	F	\N
739	revista	1	R	\N
740		\N		\N
742	barato	1	B	\N
743	tienda	1	T	\N
744	caro	1	C	\N
745	cuántos	1	C	\N
746	cuánto	1	C	\N
747	fruta	1	F	\N
748	verdura	1	V	\N
749	pescado	1	P	\N
750	carne de cerdo	1	C	\N
751	pollo	1	P	\N
752	carne	1	C	\N
753	querer	1	Q	\N
754	pasar	1	P	\N
755	frutería	1	F	\N
756	llave	1	L	\N
757	plato	1	P	\N
758	hacer compra	1	C	\N
760	limpiar	1	L	\N
761	familia	1	F	\N
762	hogar	1	H	\N
763	jardín	1	J	\N
764	lavado	1	L	\N
765	casa	1	C	\N
766	casa	1	C	\N
767	limpieza	1	L	\N
768	volver	1	V	\N
769	estante	1	E	\N
770	escritorio	1	E	\N
771	silla	1	S	\N
772	habitación	1	H	\N
773	nevera	1	N	\N
774	lavar	1	L	\N
775	cama	1	C	\N
776	radio	1	R	\N
777	cadena de música	1	C	\N
778	llamarse	1	L	\N
779	acostarse	1	A	\N
780	levantarse	1	L	\N
781	mesa	1	M	\N
782	televisión	1	T	\N
783	policía	1	P	\N
784	policía	\N	P	\N
785	mapa	1	M	\N
786	al lado de	\N		\N
787	aquí	1	A	\N
788	ahí	1	A	\N
789	allí	1	A	\N
790	dónde	1	D	\N
791	comisaría	1	C	\N
792	cerca	1	C	\N
793	al lado de 	1	L	\N
794	preguntar	1	P	\N
795	cortar	1	C	\N
796	corto	1	C	\N
797	atrás	1	A	\N
798	delante	1	D	\N
799	derecha	1	D	\N
800	izquierda	1	I	\N
801	largo	1	L	\N
802	sentarse	1	S	\N
804	amigo	1	A	\N
805	clase	1	C	\N
806	aula	1	A	\N
807	pasillo	1	P	\N
808	colegio	1	C	\N
809	alumno	1	A	\N
810	estudio	1	E	\N
811	estudiante	1	E	\N
812	estudiante extranjero	1	E	\N
813	vacaciones de verano	1	V	\N
814	profesor	1	P	\N
815	universidad	1	U	\N
816	cuaderno	1	C	\N
817	clase	\N	C	\N
818	redacción	1	R	\N
819	deber	1	D	\N
820	difícil	1	D	\N
821	enseñar	1	E	\N
822	examen	1	E	\N
823	ejercicio	1	E	\N
824	fácil	1	F	\N
831	médico	1	M	\N
832	hospital	1	H	\N
833	enfermedad	1	E	\N
834	medicina	1	M	\N
835	morir	1	M	\N
840	ascensor	1	A	\N
841	billete	1	B	\N
842	bajar	1	B	\N
843	escalera	1	E	\N
844	cerrar	1	C	\N
845	estación	1	E	\N
846	metro	1	M	\N
847	subir	1	S	\N
848	abrir	1	A	\N
849	baño	1	B	\N
850	servicio	1	S	\N
851	tren	1	T	\N
852	bebida	1	B	\N
853	café	1	C	\N
854	cafetería	1	C	\N
855	limón	1	L	\N
856	leche	1	L	\N
857	azúcar	1	A	\N
858	taza	1	T	\N
859	té	1	T	\N
861	copa	1	C	\N
862	servir	1	S	\N
863	dulce	1	D	\N
864	beber	1	B	\N
865	palillo	1	P	\N
866	bebida alcohólica	1	B	\N
867	estar rico	1	R	\N
868	cuchillo	1	C	\N
869	cuchara	1	C	\N
870	tenedor	1	T	\N
871	queso	1	Q	\N
872	comer	1	C	\N
873	no estar rico	1	R	\N
874	pan	1	P	\N
875	picante	1	P	\N
876	restaurante	1	R	\N
877	comedor	1	C	\N
878	vino	1	V	\N
879	comida	1	C	\N
880	curry	1	C	\N
881	dinero	1	D	\N
882	banco	1	B	\N
883	entrada	1	E	\N
884	adelante	0	A	\N
885	no	1	N	\N
886	sí	1	S	\N
887	perdón	1	P	\N
888	servir	\N		\N
889	salida	1	S	\N
890	llegar	1	L	\N
891	buzón	1	B	\N
892	postal	1	P	\N
894	sobre	1	S	\N
895	carta	1	C	\N
896	correo	1	C	\N
897	devolver	1	D	\N
898	enviar	1	E	\N
899	sello	1	S	\N
900	paquete	1	P	\N
901		\N		\N
902	dejar	1	D	\N
903	comprar	1	C	\N
904	sombrero	1	S	\N
905	zapato	1	Z	\N
906	compra	1	C	\N
907	piso	1	P	\N
908	grandes almacenes	1	A	\N
909	falda	1	F	\N
910	abrigo	1	A	\N
911	pantalón	1	P	\N
912	jersey	1	J	\N
913	por favor	1	P	\N
914	bolso	1	B	\N
915	vender	1	V	\N
916	chaqueta	1	C	\N
917	baño	0	B	\N
918	edificio	1	E	\N
919	cocina	1	C	\N
920	ducha	1	D	\N
921	ventana	1	V	\N
922	vivir	1	V	\N
923	parque	1	P	\N
924	puerta	1	P	\N
925	ducharse	1	D	\N
928	él	1	E	\N
929	ellos	1	E	\N
930	yo	1	Y	\N
931	nosotros	1	N	\N
932	alguien	1	A	\N
933	quién	1	Q	\N
934	quién	1	Q	\N
935	tú	1	T	\N
936	usted	1	U	\N
937	este	1	E	\N
938	ese, esa, esos, esas	1	E	\N
939		\N		\N
940	cuál	1	C	\N
941	cómo	1	C	\N
942	tal	1	T	\N
943	sí mismo	1	S	\N
944	así	1	A	\N
945	grueso	1	G	\N
946	estrecho	1	E	\N
947	fino	1	F	\N
948	grande	1	G	\N
949	gordo	1	G	\N
950	joven	1	J	\N
951	amplio	1	A	\N
952	ligero	1	L	\N
953	lejos	1	L	\N
954	pesado	1	P	\N
955	fino	\N	F	\N
956	nuevo	1	N	\N
957	pequeño	1	P	\N
958	cerca	\N	C	\N
959	viejo	1	V	\N
960	divertido	1	D	\N
964	claro	1	C	\N
965	débil	1	D	\N
966	fuerte	1	F	\N
967	interesante	1	I	\N
968	bonito	1	B	\N
969	lento	1	L	\N
970	mal	1	M	\N
971	mucho	1	M	\N
972	oscuro	1	O	\N
973	tranquilo	1	T	\N
974	poco	1	P	\N
978	dentro	1	D	\N
979	fuera	1	F	\N
980	este	1	E	\N
981	altura	1	A	\N
983	norte	1	N	\N
984	oeste	1	O	\N
985	abajo	1	A	\N
986	sur	1	S	\N
987	arriba	1	A	\N
988	adelante	1	A	\N
990	primo	1	P	\N
991	hermano	1	H	\N
992	hermano	\N	H	\N
993	abuela	1	A	\N
994	abuelo	1	A	\N
995	mujer	1	M	\N
996	madre	1	M	\N
997	tío	1	T	\N
998	padres	1	P	\N
999	padre	1	P	\N
1000	hermana	1	H	\N
1001	hermana	0	H	\N
1002	tía	1	T	\N
1003	hermano	\N	H	\N
1004	hermana	0	H	\N
1005	padre	\N	P	\N
1006	madre	\N	M	\N
1007	calcetín	1	C	\N
1008	camiseta	1	C	\N
1009	quitarse	1	Q	\N
1010	ponerse	0	P	\N
1011	ponerse	1	P	\N
1012	ponerse	0	P	\N
1013	ponerse	0	P	\N
1014	pañuelo	1	P	\N
1015	zapatilla	1	Z	\N
1016	paraguas	1	P	\N
1017	bolsillo	1	B	\N
1018	cartera	1	C	\N
1019	llevar	1	L	\N
1020	ropa	\N	R	\N
1021	ropa	\N	R	\N
1022	boca	1	B	\N
1023	brazo	1	B	\N
1024	cuerpo	1	C	\N
1025	cara	1	C	\N
1026	pierna	1	P	\N
1027	mano	1	M	\N
1028	nariz	1	N	\N
1029	ojo	1	O	\N
1030	oreja	1	O	\N
1031	pie	1	P	\N
1032	tripa	1	T	\N
1033	plato	\N	P	\N
1034	mantequilla	1	M	\N
1035	cuenco	\N	C	\N
1036	caramelo	1	C	\N
1037	comida	0	C	\N
1038	cena	1	C	\N
1040	huevo	1	H	\N
1041	desayuno	1	D	\N
1042	comida	0	C	\N
1043	salsa de soja	1	S	\N
1044	sal	1	S	\N
1045	cena	1	C	\N
1046	añadir	1	A	\N
1047	pegar	1	P	\N
1048	cámara	1	C	\N
1049	estufa	1	E	\N
1050	lápiz	1	L	\N
1051	borrar	1	B	\N
1052	gafa	1	G	\N
1053	grabadora	1	G	\N
1054	reloj	1	R	\N
1055	ordenador	1	O	\N
1056	carrete	1	C	\N
1057	puerta	\N	P	\N
1058	puerta	\N	P	\N
1059	bolígrafo	\N	B	\N
1060	pluma estilográfica	1	P	\N
1061	bolígrafo	\N	B	\N
1062	agosto	1	A	\N
1063	abril	1	A	\N
1064	este mes	1	M	\N
1065	todos los meses	1	M	\N
1066	diciembre	1	D	\N
1067	febrero	1	F	\N
1068	enero	1	E	\N
1069	julio	1	J	\N
1070	junio	1	J	\N
1071	el mes que viene	1	M	\N
1072	mayo	1	M	\N
1073	marzo	1	M	\N
1074	el mes pasado	1	M	\N
1075	noviembre	1	N	\N
1076	octubre	1	O	\N
1077	septiembre	1	S	\N
1078	un mes	1	U	\N
1079	esta semana	1	S	\N
1080	todas las semanas	1	S	\N
1081	domingo	1	D	\N
1082	jueves	1	J	\N
1083	la semana que viene	1	S	\N
1084	lunes	1	L	\N
1085	martes	1	M	\N
1086	miércoles	1	M	\N
1087	sábado	1	S	\N
1088	semana	1	S	\N
1089	la semana pasada	1	S	\N
1090	viernes	1	V	\N
1091	año	1	A	\N
1092	otoño	1	O	\N
1093	este año	1	A	\N
1094	todos los años	1	A	\N
1095	verano	1	V	\N
1096	invierno	1	I	\N
1097	el año pasado	1	A	\N
1098	el año que viene	1	A	\N
1099	primavera	1	P	\N
1100	dentro de dos años	1	A	\N
1101	hace dos años	1	A	\N
1102	tarde	1	T	\N
1103	hoy	1	H	\N
1104	mañana	1	M	\N
1105	hora	1	H	\N
1106	ayer	1	A	\N
1107	anoche	1	A	\N
1108	mañana	\N	M	\N
1109	mañana	\N	M	\N
1112	atardecer	1	A	\N
1113	pasado mañana	1	M	\N
1115	ya	1	Y	\N
1116		\N		\N
1117	todavía	1	T	\N
1118	todo el ...	1	T	\N
1119	tiempo	1	T	\N
1120	cuándo	1	C	\N
1121	a veces	1	V	\N
1122	frecuente	1	F	\N
1123	hora	\N	H	\N
1124	enseguida	1	E	\N
1125	cenicero	1	C	\N
1126	canción	\N	C	\N
1127	cantar	\N	C	\N
1128	cigarrillo	1	C	\N
1129	cine	1	C	\N
1130	disco de vinilo	1	D	\N
1131	guitarra	1	G	\N
1132	tocar	1	T	\N
1133	música	1	M	\N
1134	pintura	1	P	\N
1135	foto	1	F	\N
1136	gustar	1	G	\N
1137	voz	1	V	\N
1138	buen tiempo	1	B	\N
1139	calor	1	C	\N
1140	hacer buen tiempo	1	B	\N
1141	fresco	1	F	\N
1142	hacer frío	1	F	\N
1143	nieve	1	N	\N
1144	llover	1	L	\N
1145	lluvia	1	L	\N
1146	tiempo	\N	T	\N
1147	hacer calor	1	C	\N
1148	viento	1	V	\N
1149	nublado	1	N	\N
1150	frío	1	F	\N
1151	nublarse	1	N	\N
1152	letras chinas	1	L	\N
1153	decir	1	D	\N
1154	escribir	1	E	\N
1155	historia	1	H	\N
1156	idioma	1	I	\N
1157		\N		\N
1158	palabra	1	P	\N
1159	hablar	1	H	\N
1160	frase	1	F	\N
1161	contar	1	C	\N
1162	significado	1	S	\N
1163	hiragana	1	H	\N
1164	katakana	1	K	\N
1165	adulto	1	A	\N
1166	muchos	1	M	\N
1167	matrimonio	1	M	\N
1168	niño	1	N	\N
1169	mujer	\N	M	\N
1170	mujer	\N	M	\N
1171	chico	1	C	\N
1172	hombre	1	H	\N
1173	hombre	\N	H	\N
1174	chica	1	C	\N
1175	marido	1	M	\N
1176	hombre	\N	H	\N
1177	todo el mundo	1	M	\N
1178	blanco	1	B	\N
1179	azul	1	A	\N
1180	marrón	1	M	\N
1181	claro	0	C	\N
1182	color	1	C	\N
1183	oscuro	\N	O	\N
1184	amarillo	1	A	\N
1185	negro	1	N	\N
1186	rojo	1	R	\N
1187	verde	1	V	\N
1188	útil	1	U	\N
1189	fiesta	1	F	\N
1190	papel	1	P	\N
1191	hacerse	1	H	\N
1192	abrochar	1	A	\N
1193	empujar	1	E	\N
1194	empezar	1	E	\N
1195	justo	1	J	\N
1196	no hay	1	H	\N
1197	recto	1	R	\N
1198	famoso	1	F	\N
1199	bien	1	B	\N
1200	entonces	1	E	\N
1202	hasta luego	1	L	\N
1203	quizá	1	Q	\N
1204	aquí tiene	1	T	\N
1205	ternera	1	T	\N
1206	ella	1	E	\N
1207	ellas	1	E	\N
1208	enfermo	1	E	\N
1209	fotocopiadora	1	F	\N
1210	un poco	1	P	\N
1211	ustedes	1	U	\N
1212	escuchar	1	E	\N
1213	supermercado	1	S	\N
1214	tenre	0	T	\N
1215	animado	1	A	\N
1216	disco	1	D	\N
1217	kanji	1	K	\N
741	carne de vaca	0	C	\N
759	lavar la ropa	0	L	\N
803	levantarse	0	L	\N
827	pregunta	0	P	\N
860	té inglés	0	T	\N
893	pegar	0	P	\N
926	piso	0	P	\N
927	entrada	0	E	\N
982	largo	0	L	\N
989	atrás	0	A	\N
1039	dulce	0	D	\N
1201	quizá	0	Q	\N
684	avión	1	A	\N
686	extranjero	0	E	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: es
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
1	Hola	やあ	間投詞	\N	\N	\N	596	\N
2	María	マリア	固有名詞	\N	\N	\N	596	\N
3	Qué tal	どう	疑問副詞＋副詞	\N	\N	\N	597	\N
4	Bien	元気で	副詞	\N	\N	\N	598	\N
5	y	そして	接続詞	\N	\N	\N	598	\N
6	tú	君は	代名詞	\N	\N	\N	598	\N
7	Juan	フアン	固有名詞	\N	\N	\N	598	\N
8	Muy	とても	副詞	\N	\N	\N	599	\N
4	bien	元気で	副詞	\N	\N	\N	599	\N
9	gracias	ありがとう	名詞	\N	\N	\N	599	\N
10	A	…へ、…に	前置詞	\N	\N	\N	600	\N
11	dónde	どこ	疑問副詞	\N	\N	\N	600	\N
12	vas	行く	動詞	\N	\N	\N	600	\N
12	Voy	行く	動詞	\N	\N	\N	601	\N
10	 a 	…へ、…に	前置詞	\N	\N	\N	601	\N
13	la		冠詞	\N	\N	\N	601	\N
14	biblioteca	図書館	名詞	\N	\N	\N	601	\N
15	Para	…のために	前置詞	\N	\N	\N	602	\N
16	qué	何	疑問代名詞	\N	\N	\N	602	\N
17	Tengo que	…しなければならない(tener que＋不定詞)	動詞	\N	\N	\N	603	\N
18	prepararme	準備する	動詞	\N	\N	\N	603	\N
15	para	…のために	前置詞	\N	\N	\N	603	\N
13	el		冠詞	\N	\N	\N	603	\N
19	examen	試験	名詞	\N	\N	\N	603	\N
20	de	…の	前置詞	\N	\N	\N	603	\N
21	mañana	明日	副詞	\N	\N	\N	603	\N
22	Ah	ああ	間投詞	\N	\N	\N	604	\N
23	sí	そう	副詞	\N	\N	\N	604	\N
24	Suerte	幸運	名詞	\N	\N	\N	605	\N
9	Gracias	ありがとう	名詞	\N	\N	\N	606	\N
25	Hasta	…まで	前置詞	\N	\N	\N	607	\N
26	luego	後で	副詞	\N	\N	\N	607	\N
25	Hasta	…まで	前置詞	\N	\N	\N	608	\N
26	luego	後で	副詞	\N	\N	\N	608	\N
27	Cómo	どのように	疑問副詞	\N	\N	\N	609	\N
12	vas	進む、行く	動詞	\N	\N	\N	609	\N
28	con	…とともに、…に対して	前置詞	\N	\N	\N	609	\N
13	el	例の、あの	冠詞	\N	\N	\N	609	\N
29	trabajo	課題	名詞	\N	\N	\N	609	\N
30	escrito	文書による、筆記の	形容詞	\N	\N	\N	609	\N
31	Más o menos 	だいたい、およそ	副詞＋接続詞＋副詞	\N	\N	\N	610	\N
32	Tengo	持っている	動詞	\N	\N	\N	611	\N
33	un	一つの、ある	冠詞	\N	\N	\N	611	\N
34	problema	問題、困り事	名詞	\N	\N	\N	611	\N
16	Qué	何	疑問代名詞	\N	\N	\N	612	\N
35	pasa	起こる	動詞	\N	\N	\N	612	\N
36	Es que 	実は…である	動詞＋接続詞	\N	\N	\N	613	\N
13	el	例の、その	冠詞	\N	\N	\N	613	\N
37	libro	本	名詞	\N	\N	\N	613	\N
38	recomendado	推薦された	形容詞	\N	\N	\N	613	\N
39	no	…しない、…でない	副詞	\N	\N	\N	613	\N
40	está	ある	動詞	\N	\N	\N	613	\N
41	en	…において、…の中に	前置詞	\N	\N	\N	613	\N
14	biblioteca	図書館	名詞	\N	\N	\N	613	\N
42	Aquí	ここに	副詞	\N	\N	\N	614	\N
43	lo	それを	代名詞	\N	\N	\N	614	\N
44	Si	もし	接続詞	\N	\N	\N	615	\N
45	quieres	望む	動詞	\N	\N	\N	615	\N
46	te	君に	代名詞	\N	\N	\N	615	\N
43	lo	それを	代名詞	\N	\N	\N	615	\N
47	dejo	貸す	動詞	\N	\N	\N	615	\N
48	Muchas	たくさんの	形容詞	\N	\N	\N	616	\N
9	gracias	ありがとう	名詞	\N	\N	\N	616	\N
49	De nada 	どういたしまして	前置詞＋代名詞	\N	\N	\N	617	\N
50	Cuándo	いつ	疑問副詞	\N	\N	\N	618	\N
51	se	あなたに	代名詞	\N	\N	\N	618	\N
43	lo	それを	代名詞	\N	\N	\N	618	\N
52	devuelvo	返す	動詞	\N	\N	\N	618	\N
39	No	…しない、…でない	副詞	\N	\N	\N	619	\N
53	hay	ある	動詞	\N	\N	\N	619	\N
54	prisa	急ぐこと	名詞	\N	\N	\N	619	\N
48	Muchísimas	非常に多くの	形容詞	\N	\N	\N	620	\N
9	gracias	ありがとう	名詞	\N	\N	\N	620	\N
55	profesor	先生	名詞	\N	\N	\N	620	\N
56	Disculpe	すみません	動詞	\N	\N	\N	621	\N
23	Sí	はい	副詞	\N	\N	\N	622	\N
11	Dónde	どこ	疑問副詞	\N	\N	\N	623	\N
40	está	ある	動詞	\N	\N	\N	623	\N
13	el		冠詞	\N	\N	\N	623	\N
57	despacho	研究室	名詞	\N	\N	\N	623	\N
58	del	…の	前置詞＋冠詞	\N	\N	\N	623	\N
55	profesor	先生	名詞	\N	\N	\N	623	\N
59	Sánchez	サンチェス	固有名詞	\N	\N	\N	623	\N
40	Está	ある	動詞	\N	\N	\N	624	\N
41	en	…に(おいて)	前置詞	\N	\N	\N	624	\N
13	el		冠詞	\N	\N	\N	624	\N
60	segundo	第2番目の	形容詞	\N	\N	\N	624	\N
61	piso	階	名詞	\N	\N	\N	624	\N
62	del	…の	前置詞＋冠詞	\N	\N	\N	624	\N
63	edificio	棟、建物	名詞	\N	\N	\N	624	\N
64	C	(アルファベットの)C	名詞	\N	\N	\N	624	\N
65	Cuál	どれ	疑問代名詞	\N	\N	\N	625	\N
66	es	…です、…である	動詞	\N	\N	\N	625	\N
13	el		冠詞	\N	\N	\N	625	\N
63	edificio	棟、建物	名詞	\N	\N	\N	625	\N
64	C	(アルファベットの)C	名詞	\N	\N	\N	625	\N
66	Es	…です、…である	動詞	\N	\N	\N	626	\N
13	el	それ(男性単数名詞を指して)	冠詞	\N	\N	\N	626	\N
20	de	…の	前置詞	\N	\N	\N	626	\N
67	enfrente	正面に	副詞	\N	\N	\N	626	\N
40	Estará	いる	動詞	\N	\N	\N	627	\N
13	el		冠詞	\N	\N	\N	627	\N
55	profesor	先生	名詞	\N	\N	\N	627	\N
41	en	…に(おいて)	前置詞	\N	\N	\N	627	\N
68	su	彼の	形容詞	\N	\N	\N	627	\N
57	despacho	研究室	名詞	\N	\N	\N	627	\N
69	Creo	…と思う	動詞	\N	\N	\N	628	\N
70	que	…ということ	接続詞	\N	\N	\N	628	\N
23	sí	そう	副詞	\N	\N	\N	628	\N
9	Gracias	ありがとう	名詞	\N	\N	\N	629	\N
49	De nada 	どういたしまして	前置詞＋代名詞	\N	\N	\N	630	\N
71	Perdona	すみません	動詞	\N	\N	\N	631	\N
11	dónde	どこに	疑問副詞	\N	\N	\N	632	\N
40	está	(…に)ある	動詞	\N	\N	\N	632	\N
13	el		冠詞	\N	\N	\N	632	\N
73	aula	教室	名詞	\N	\N	\N	632	\N
12	Vas	行く	動詞	\N	\N	\N	633	\N
10	a	…に、…へ	前置詞	\N	\N	\N	633	\N
13	la		冠詞	\N	\N	\N	633	\N
74	clase	授業	名詞	\N	\N	\N	633	\N
58	del	…の	前置詞＋冠詞	\N	\N	\N	633	\N
55	profesor	先生	名詞	\N	\N	\N	633	\N
59	Sánchez	サンチェス	固有名詞	\N	\N	\N	633	\N
23	Sí	はい	副詞	\N	\N	\N	634	\N
6	Tú	君	代名詞	\N	\N	\N	635	\N
75	también	…もまた	副詞	\N	\N	\N	635	\N
23	Sí	はい	副詞	\N	\N	\N	636	\N
12	Vamos	行く	動詞	\N	\N	\N	637	\N
76	juntos	いっしょの	形容詞	\N	\N	\N	637	\N
77	Me	私を	再帰代名詞	\N	\N	\N	638	\N
78	llamo	(…を…と)呼ぶ	動詞	\N	\N	\N	638	\N
2	María	マリア	固有名詞	\N	\N	\N	638	\N
48	Mucho	たくさんの	形容詞	\N	\N	\N	639	\N
79	gusto	喜び	名詞	\N	\N	\N	639	\N
66	Eres	…である	動詞	\N	\N	\N	642	\N
20	de	…出身の	前置詞	\N	\N	\N	642	\N
42	aquí	ここ	副詞	\N	\N	\N	642	\N
39	No	いいえ	副詞	\N	\N	\N	643	\N
66	Soy	…である	動詞	\N	\N	\N	644	\N
20	de	…出身の	前置詞	\N	\N	\N	644	\N
80	Oviedo	オビエド	固有名詞	\N	\N	\N	644	\N
81	Yo	私	代名詞	\N	\N	\N	645	\N
75	también	…もまた	副詞	\N	\N	\N	645	\N
16	Qué	何という…！	疑問形容詞	\N	\N	\N	646	\N
82	casualidad	偶然	名詞	\N	\N	\N	646	\N
83	Carlos	カルロス	固有名詞	\N	\N	\N	647	\N
84	llegas	着く、到着する	動詞	\N	\N	\N	647	\N
85	media	半分の	形容詞	\N	\N	\N	647	\N
86	hora	1時間	名詞	\N	\N	\N	647	\N
87	tarde	遅く	副詞	\N	\N	\N	647	\N
43	Lo	そのことを	代名詞	\N	\N	\N	648	\N
88	siento	すまなく思う	動詞	\N	\N	\N	648	\N
16	Qué	何が	疑問代名詞	\N	\N	\N	649	\N
46	te	君に	代名詞	\N	\N	\N	649	\N
35	ha pasado	起こる	動詞	\N	\N	\N	649	\N
53	Hay	…がある	動詞	\N	\N	\N	650	\N
33	un		冠詞	\N	\N	\N	650	\N
89	atasco	渋滞	名詞	\N	\N	\N	650	\N
90	terrible	ひどい	形容詞	\N	\N	\N	650	\N
91	Debes	…すべきである(不定詞とともに)	動詞	\N	\N	\N	651	\N
92	salir	出る、出発する	動詞	\N	\N	\N	651	\N
93	más	より…、もっと…	副詞	\N	\N	\N	651	\N
94	temprano	早く	副詞	\N	\N	\N	651	\N
15	para	…するために	前置詞	\N	\N	\N	651	\N
95	evitar	避ける	動詞	\N	\N	\N	651	\N
13	las		冠詞	\N	\N	\N	651	\N
96	horas punta	ラッシュアワー	名詞＋名詞	\N	\N	\N	651	\N
32	Tienes	持っている	動詞	\N	\N	\N	652	\N
97	razón	道理、正当性	名詞	\N	\N	\N	652	\N
77	Me	私を	代名詞	\N	\N	\N	653	\N
71	perdonas	許す	動詞	\N	\N	\N	653	\N
39	No	…ない	副詞	\N	\N	\N	654	\N
72	sé	知っている	動詞	\N	\N	\N	654	\N
46	Te	君に	代名詞	\N	\N	\N	655	\N
98	invito	おごる	動詞	\N	\N	\N	655	\N
10	a		前置詞	\N	\N	\N	655	\N
33	una	一つの	冠詞	\N	\N	\N	655	\N
99	copa	グラス	名詞	\N	\N	\N	655	\N
100	Bueno	(承諾・是認)分かった	間投詞	\N	\N	\N	656	\N
101	vale	(承諾・是認)分かった	動詞	\N	\N	\N	656	\N
102	Venga	さあ	動詞	\N	\N	\N	657	\N
12	vamos	行く	動詞	\N	\N	\N	657	\N
103	Voy a 	(「ir a +不定詞」で)…しよう	動詞＋前置詞	\N	\N	\N	658	\N
104	 tomar 	食べる	動詞	\N	\N	\N	658	\N
33	 un 	一つの 	冠詞	\N	\N	\N	658	\N
105	 caramelo 	飴	名詞	\N	\N	\N	658	\N
45	 Quieres 	望む、欲しいと思う	動詞	\N	\N	\N	659	\N
106	 uno 	一つ 	代名詞	\N	\N	\N	659	\N
107	 Sí 	はい 	副詞	\N	\N	\N	660	\N
108	 por favor 	お願いします	前置詞＋名詞	\N	\N	\N	660	\N
109	 Aquí 	ここに	副詞	\N	\N	\N	661	\N
110	 Gracias 	ありがとう	名詞	\N	\N	\N	662	\N
49	 De nada 	どういたしまして	前置詞＋代名詞	\N	\N	\N	663	\N
10	 A 		前置詞	\N	\N	\N	664	\N
16	qué	何	疑問代名詞	\N	\N	\N	664	\N
111	 sabe 	(saber a ...で)…の味がする	動詞	\N	\N	\N	664	\N
10	 A 		前置詞	\N	\N	\N	665	\N
112	 naranja 	オレンジ	名詞	\N	\N	\N	665	\N
40	 Está 	…である	動詞 	\N	\N	\N	666	\N
113	 muy 	とても	副詞	\N	\N	\N	666	\N
114	 bueno 	おいしい、良い	形容詞	\N	\N	\N	666	\N
107	 Sí 	ええ	副詞	\N	\N	\N	667	\N
10	 A 	…に(とって)	前置詞	\N	\N	\N	668	\N
115	 mí 	私	代名詞 	\N	\N	\N	668	\N
116	 también 	…もまた	副詞	\N	\N	\N	668	\N
117	 me 	私に(とって)	代名詞	\N	\N	\N	668	\N
118	 gusta 	 (何かが誰かの)気に入る	動詞	\N	\N	\N	668	\N
119	 este 	この	形容詞	\N	\N	\N	668	\N
120	 sabor 	味	名詞	\N	\N	\N	668	\N
5	 Y 	そして、しかも	接続詞	\N	\N	\N	669	\N
121	 no 	…しない	副詞	\N	\N	\N	669	\N
122	 azúcar 	砂糖	名詞	\N	\N	\N	669	\N
123	 Fin 	終わり、終末	名詞	\N	\N	\N	670	\N
124	 de 	…の	前置詞	\N	\N	\N	670	\N
125	 semana 	週	名詞	\N	\N	\N	670	\N
126	 Por fin 	ついに	前置詞＋名詞	\N	\N	\N	671	\N
6	tú	君	代名詞	\N	\N	\N	739	\N
32	Tienes	持っている	動詞	\N	\N	\N	672	\N
127	 algún 	何らかの	形容詞	\N	\N	\N	672	\N
128	 plan 	計画	名詞	\N	\N	\N	672	\N
107	 Sí 	はい	副詞	\N	\N	\N	673	\N
129	 Voy a	(「ir + a +不定詞」で)…する予定である	動詞＋前置詞	\N	\N	\N	674	\N
130	 ir 	行く	動詞	\N	\N	\N	674	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	674	\N
132	 Madrid 	マドリード	固有名詞	\N	\N	\N	674	\N
133	 ver 	…に会う	動詞	\N	\N	\N	674	\N
134	mis	私の	所有形容詞	\N	\N	\N	674	\N
135	 padres 	(複数で)両親	名詞	\N	\N	\N	674	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	675	\N
113	 muy 	とても	副詞	\N	\N	\N	675	\N
136	 bien 	良い	副詞	\N	\N	\N	675	\N
5	 Y 	そして	接続詞	\N	\N	\N	676	\N
137	 tú 	君は	代名詞	\N	\N	\N	676	\N
138	 qué 	何	疑問代名詞 	\N	\N	\N	676	\N
129	 vas a	(「ir + a +不定詞」で)…する予定である	動詞＋前置詞	\N	\N	\N	676	\N
139	 hacer 	する	動詞	\N	\N	\N	676	\N
140	 Yo 	私は	代名詞	\N	\N	\N	677	\N
129	 voy a	(「ir + a +不定詞」で)…する予定である	動詞＋前置詞	\N	\N	\N	677	\N
141	 ir de excursión 	遠足に行く	動詞＋前置詞＋名詞	\N	\N	\N	677	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	677	\N
142	 Cáceres 	カセレス	固有名詞	\N	\N	\N	677	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	678	\N
143	 buena 	良い	形容詞	\N	\N	\N	678	\N
144	 idea 	考え	名詞	\N	\N	\N	678	\N
70	 Que 	「que + 接続法現在形」 (願望、祈願)	接続詞	\N	\N	\N	679	\N
145	 lo 	そのことを	代名詞	\N	\N	\N	679	\N
35	 pases 	過ごす	動詞	\N	\N	\N	679	\N
136	 bien 	良く	副詞	\N	\N	\N	679	\N
146	 Igualmente 	同様に	副詞	\N	\N	\N	680	\N
51	Nos	私たちお互いを	代名詞	\N	\N	\N	681	\N
147	vemos 	会う	動詞 	\N	\N	\N	681	\N
148	 el 		冠詞	\N	\N	\N	681	\N
149	 lunes 	月曜日	名詞	\N	\N	\N	681	\N
150	 Adiós 	さようなら	間投詞	\N	\N	\N	682	\N
151	 hasta 	…まで	前置詞	\N	\N	\N	682	\N
148	 el 		冠詞	\N	\N	\N	682	\N
149	 lunes 	月曜日	名詞	\N	\N	\N	682	\N
152	 Hola	こんにちは	間投詞	\N	\N	\N	683	\N
45	Quería	欲しい	動詞	\N	\N	\N	684	\N
33	un	一つの	冠詞	\N	\N	\N	684	\N
153	billete	切符	名詞	\N	\N	\N	684	\N
15	para	…へ	前置詞	\N	\N	\N	684	\N
154	 Barcelona 	バルセロナ	名詞	\N	\N	\N	684	\N
155	 para 	…のため	前置詞	\N	\N	\N	684	\N
13	el		冠詞	\N	\N	\N	684	\N
156	 día 	日	名詞	\N	\N	\N	684	\N
20	de	…の	前置詞	\N	\N	\N	684	\N
157	hoy	今日	名詞	\N	\N	\N	684	\N
20	De	…の	前置詞	\N	\N	\N	685	\N
158	ida	行き	名詞	\N	\N	\N	685	\N
5	y	そして	接続詞	\N	\N	\N	685	\N
159	 vuelta 	帰り	名詞	\N	\N	\N	685	\N
107	 Sí 	はい	副詞	\N	\N	\N	686	\N
145	 Lo 	それ	代名詞	\N	\N	\N	687	\N
160	 quiere 	欲しい	動詞	\N	\N	\N	687	\N
20	de	…の	前置詞	\N	\N	\N	687	\N
161	 fumadores 	喫煙者	名詞	\N	\N	\N	687	\N
162	o	それとも	接続詞	\N	\N	\N	687	\N
39	no	…でない	副詞	\N	\N	\N	687	\N
163	fumadores	喫煙者	名詞	\N	\N	\N	687	\N
20	De	…の	前置詞	\N	\N	\N	688	\N
163	fumadores	喫煙者	名詞	\N	\N	\N	688	\N
164	Cuánto	いくら	疑問代名詞	\N	\N	\N	689	\N
165	cuesta	(費用が)かかる	動詞	\N	\N	\N	689	\N
13	el		冠詞	\N	\N	\N	689	\N
153	billete	切符	名詞	\N	\N	\N	689	\N
166	Treinta	30の	形容詞	\N	\N	\N	690	\N
42	Aquí	ここに	副詞	\N	\N	\N	691	\N
32	tiene	持つ	動詞	\N	\N	\N	691	\N
8	Muy	とても	副詞	\N	\N	\N	692	\N
4	bien	よく	副詞	\N	\N	\N	692	\N
9	Gracias	ありがとう	名詞	\N	\N	\N	693	\N
49	De nada 	どういたしまして	前置詞＋代名詞	\N	\N	\N	694	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	695	\N
7	Juan	フアン	固有名詞	\N	\N	\N	695	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	696	\N
3	Qué tal	どう	疑問副詞＋副詞	\N	\N	\N	697	\N
13	el		冠詞	\N	\N	\N	697	\N
167	veraneo	夏の休暇	名詞	\N	\N	\N	697	\N
40	Estás	…である	動詞	\N	\N	\N	698	\N
8	muy	とても	副詞	\N	\N	\N	698	\N
168	moreno	褐色の	形容詞	\N	\N	\N	698	\N
100	Bueno	ええ	間投詞	\N	\N	\N	699	\N
36	Es que	実は…である	動詞＋接続詞	\N	\N	\N	699	\N
40	estuve	いる	動詞	\N	\N	\N	699	\N
33	un	一つの	冠詞	\N	\N	\N	699	\N
169	mes	月	名詞	\N	\N	\N	699	\N
41	en	…に	前置詞	\N	\N	\N	699	\N
170	Niza	ニース	固有名詞	\N	\N	\N	699	\N
16	Qué	なんという	疑問形容詞	\N	\N	\N	700	\N
171	envidia	ねたみ	名詞	\N	\N	\N	700	\N
5	Y	そして	接続詞	\N	\N	\N	701	\N
172	has estado 	いる	動詞	\N	\N	\N	701	\N
41	en	…に	前置詞	\N	\N	\N	701	\N
173	Francia	フランス	固有名詞	\N	\N	\N	701	\N
174	otras	他の	形容詞	\N	\N	\N	701	\N
175	ocasiones	機会	名詞	\N	\N	\N	701	\N
23	Sí	はい	副詞	\N	\N	\N	702	\N
176	Ya	すでに	副詞	\N	\N	\N	703	\N
12	he ido 	行く	動詞	\N	\N	\N	703	\N
177	cinco	5の	形容詞	\N	\N	\N	703	\N
178	veces	…回	名詞	\N	\N	\N	703	\N
177	 Cinco 	5の	形容詞	\N	\N	\N	704	\N
5	Y	そして	接続詞	\N	\N	\N	705	\N
15	para	…のために	前置詞	\N	\N	\N	705	\N
16	 qué 	どんなこと	疑問代名詞	\N	\N	\N	705	\N
15	 Para 	…のために	前置詞	\N	\N	\N	706	\N
179	visitar	訪問する	動詞	\N	\N	\N	706	\N
10	a	…に	前置詞	\N	\N	\N	706	\N
33	una		冠詞	\N	\N	\N	706	\N
180	hermana	姉	名詞	\N	\N	\N	706	\N
70	que	…である～	関係代名詞	\N	\N	\N	706	\N
181	trabaja	働く	動詞	\N	\N	\N	706	\N
41	en	…で	前置詞	\N	\N	\N	706	\N
182	París	パリ	固有名詞	\N	\N	\N	706	\N
22	Ah	へえ	間投詞	\N	\N	\N	707	\N
16	qué	なんと	疑問副詞	\N	\N	\N	707	\N
4	bien	よい	副詞	\N	\N	\N	707	\N
183	Pues	そうですね	間投詞	\N	\N	\N	708	\N
23	sí	はい	副詞	\N	\N	\N	708	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	709	\N
7	Juan	フアン	名詞	\N	\N	\N	709	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	710	\N
2	María	マリア	名詞	\N	\N	\N	710	\N
3	Qué tal	どう	疑問副詞＋副詞	\N	\N	\N	711	\N
8	Muy	とても	副詞	\N	\N	\N	712	\N
4	bien	よく	副詞	\N	\N	\N	712	\N
157	Hoy	今日	副詞	\N	\N	\N	713	\N
66	es	…である	動詞	\N	\N	\N	713	\N
13	el		冠詞	\N	\N	\N	713	\N
184	último	最後の	形容詞	\N	\N	\N	713	\N
185	día	日	名詞	\N	\N	\N	713	\N
58	del	…の	前置詞＋冠詞	\N	\N	\N	713	\N
186	semestre	学期	名詞	\N	\N	\N	713	\N
39	no	…ではない	副詞	\N	\N	\N	713	\N
23	Sí	ええ	副詞	\N	\N	\N	714	\N
16	Qué	何	疑問代名詞	\N	\N	\N	715	\N
187	vas a	( ir a＋不定詞で)…する予定である	動詞＋前置詞	\N	\N	\N	715	\N
188	hacer	する	動詞	\N	\N	\N	715	\N
189	este	この	形容詞	\N	\N	\N	715	\N
190	verano	夏	名詞	\N	\N	\N	715	\N
187	Voy a	(「ir a＋不定詞」で) …する予定である	動詞＋前置詞	\N	\N	\N	716	\N
191	viajar	旅行する	動詞	\N	\N	\N	716	\N
192	por	…を	前置詞	\N	\N	\N	716	\N
193	Perú	ペルー	固有名詞	\N	\N	\N	716	\N
28	con	…と一緒に	前置詞	\N	\N	\N	716	\N
33	una	一つの	冠詞	\N	\N	\N	716	\N
194	amiga	友人	名詞	\N	\N	\N	716	\N
195	Fantástico	素晴らしい	形容詞	\N	\N	\N	717	\N
5	Y	そして	接続詞	\N	\N	\N	718	\N
6	tú	君	代名詞	\N	\N	\N	718	\N
2	María	マリア	固有名詞	\N	\N	\N	718	\N
196	Pienso	…するつもりである	動詞	\N	\N	\N	719	\N
35	pasar	過ごす	動詞	\N	\N	\N	719	\N
197	dos	２つの	形容詞	\N	\N	\N	719	\N
198	semanas	週	名詞	\N	\N	\N	719	\N
41	en	…で	前置詞	\N	\N	\N	719	\N
199	Málaga	マラガ	名詞	\N	\N	\N	719	\N
16	Qué	なんと	疑問副詞	\N	\N	\N	720	\N
4	bien	良く	副詞	\N	\N	\N	720	\N
200	 Buenos días	おはようございます	形容詞＋名詞 	\N	\N	\N	721	\N
200	 Buenos días	おはようございます	形容詞＋名詞	\N	\N	\N	722	\N
16	Qué	何	疑問代名詞	\N	\N	\N	723	\N
201	 le 	あなたに	代名詞	\N	\N	\N	723	\N
35	pasa	起こる	動詞	\N	\N	\N	723	\N
202	 Toso 	咳をする	動詞	\N	\N	\N	724	\N
48	mucho	たくさんの	副詞	\N	\N	\N	724	\N
5	Y	そして	接続詞	\N	\N	\N	724	\N
39	no	…でない	副詞	\N	\N	\N	724	\N
32	tengo	持つ	動詞	\N	\N	\N	724	\N
203	 apetito 	食欲	名詞	\N	\N	\N	724	\N
22	Ah	ああ	間投詞	\N	\N	\N	725	\N
40	Está	…である	動詞	\N	\N	\N	726	\N
8	muy	とても	副詞	\N	\N	\N	726	\N
204	 resfriado 	風邪をひいた	形容詞	\N	\N	\N	726	\N
5	Y	そして	接続詞	\N	\N	\N	727	\N
32	tiene	持つ	動詞	\N	\N	\N	727	\N
205	 fiebre 	熱	名詞	\N	\N	\N	727	\N
206	Uf	うっ	間投詞	\N	\N	\N	728	\N
23	Sí	はい	副詞	\N	\N	\N	729	\N
207	Por lo menos	少なくとも	前置詞＋代名詞＋形容詞	\N	\N	\N	730	\N
208	38	３８の	形容詞	\N	\N	\N	730	\N
209	 grados 	度	名詞	\N	\N	\N	730	\N
20	de	…において	前置詞	\N	\N	\N	730	\N
205	 fiebre 	熱	名詞	\N	\N	\N	730	\N
210	Tome	飲む	動詞	\N	\N	\N	731	\N
189	esta	この	代名詞	\N	\N	\N	731	\N
211	 medicina 	薬	名詞	\N	\N	\N	731	\N
201	 le 	あなたを	代名詞	\N	\N	\N	731	\N
212	 curará 	治す	動詞	\N	\N	\N	731	\N
28	Con	…の状態で	前置詞	\N	\N	\N	732	\N
16	qué	どのくらいの	疑問形容詞	\N	\N	\N	732	\N
213	 frecuencia 	頻度	名詞	\N	\N	\N	732	\N
214	tengo que	…しなければならない	動詞＋接続詞	\N	\N	\N	732	\N
215	tomarlo	それを飲む	動詞＋代名詞	\N	\N	\N	732	\N
216	Tres	3の	形容詞	\N	\N	\N	733	\N
178	veces	回	名詞	\N	\N	\N	733	\N
217	al	…に	前置詞＋冠詞	\N	\N	\N	733	\N
156	 día 	日	名詞	\N	\N	\N	733	\N
218	 después 	あとで	副詞	\N	\N	\N	733	\N
20	de	…の	前置詞	\N	\N	\N	733	\N
13	las		定冠詞	\N	\N	\N	733	\N
219	comidas	食事	名詞	\N	\N	\N	733	\N
101	Vale	OK	動詞	\N	\N	\N	734	\N
9	Gracias	ありがとう	間投詞	\N	\N	\N	735	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	736	\N
220	 Antonio 	アントニオ	固有名詞	\N	\N	\N	736	\N
221	 Cómo 	どのように	疑問副詞	\N	\N	\N	737	\N
40	estás	…である	動詞	\N	\N	\N	737	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	738	\N
2	María	マリア	固有名詞	\N	\N	\N	738	\N
40	Estoy	…である	動詞	\N	\N	\N	739	\N
4	bien	元気で	副詞	\N	\N	\N	739	\N
9	gracias	ありがとう	間投詞	\N	\N	\N	739	\N
5	y	そして	接続詞	\N	\N	\N	739	\N
4	bien	元気で	副詞	\N	\N	\N	740	\N
9	Gracias	ありがとう	間投詞	\N	\N	\N	740	\N
111	 Sabes 	知っている	動詞	\N	\N	\N	741	\N
16	qué	何の	疑問形容詞	\N	\N	\N	741	\N
156	 día 	日	名詞	\N	\N	\N	741	\N
222	 llega 	到着する	動詞	\N	\N	\N	741	\N
223	 Juana 	フアナ	固有名詞	\N	\N	\N	741	\N
222	 llega 	到着する	動詞	\N	\N	\N	742	\N
13	el		定冠詞	\N	\N	\N	742	\N
224	 domingo 	日曜日	名詞	\N	\N	\N	742	\N
5	Y	そして	接続詞	\N	\N	\N	743	\N
10	a	…に	前置詞	\N	\N	\N	743	\N
16	qué	どの	疑問代名詞	\N	\N	\N	743	\N
225	 hora 	時	名詞	\N	\N	\N	743	\N
222	 llega 	到着する	動詞	\N	\N	\N	743	\N
222	 llega 	到着する	動詞	\N	\N	\N	744	\N
10	a	…に	前置詞	\N	\N	\N	744	\N
13	las		定冠詞	\N	\N	\N	744	\N
226	 nueve 	9の	形容詞	\N	\N	\N	744	\N
20	de	…の	前置詞	\N	\N	\N	744	\N
21	 mañana 	朝	名詞	\N	\N	\N	744	\N
227	 Pero 	しかし	接続詞	\N	\N	\N	745	\N
228	 por qué 	なぜ	前置詞＋疑問代名詞	\N	\N	\N	745	\N
187	voy a	…するつもりである	動詞＋前置詞	\N	\N	\N	746	\N
215	 buscarla 	彼女を迎えにいく	動詞＋代名詞	\N	\N	\N	746	\N
217	al	…に	前置詞＋定冠詞	\N	\N	\N	746	\N
229	 aeropuerto 	空港	名詞	\N	\N	\N	746	\N
41	en	…で	前置詞	\N	\N	\N	746	\N
230	coche	車	名詞	\N	\N	\N	746	\N
22	Ah	あぁ	間投詞	\N	\N	\N	747	\N
231	 Puedo 	…できる	動詞	\N	\N	\N	747	\N
12	ir	行く	動詞	\N	\N	\N	747	\N
232	 contigo 	君と	前置詞＋代名詞	\N	\N	\N	747	\N
233	 Claro 	もちろん	形容詞	\N	\N	\N	748	\N
9	Gracias	ありがとう	間投詞	\N	\N	\N	749	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	750	\N
234	buenas tardes	こんにちは	形容詞＋名詞	\N	\N	\N	750	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	751	\N
2	María	マリア	固有名詞	\N	\N	\N	751	\N
221	 Cómo 	どのように	疑問副詞	\N	\N	\N	752	\N
231	 Puedo 	…できる	動詞	\N	\N	\N	752	\N
235	 contactar 	連絡をとる	動詞	\N	\N	\N	752	\N
28	con	…と	前置詞	\N	\N	\N	752	\N
236	usted	あなた	代名詞	\N	\N	\N	752	\N
21	 mañana 	明日	副詞	\N	\N	\N	752	\N
32	Tengo	持つ	動詞	\N	\N	\N	753	\N
33	un	一つの	冠詞	\N	\N	\N	753	\N
237	 pregunta 	質問	名詞	\N	\N	\N	753	\N
22	Ah	ああ	間投詞	\N	\N	\N	754	\N
215	 llámame 	私に電話をしてください	動詞＋代名詞	\N	\N	\N	754	\N
10	a	…に	前置詞	\N	\N	\N	754	\N
238	 casa 	家	名詞	\N	\N	\N	754	\N
239	 Cuál 	何	疑問代名詞	\N	\N	\N	755	\N
66	es	…である	動詞	\N	\N	\N	755	\N
68	su	あなたの	所有形容詞	\N	\N	\N	755	\N
240	 número 	番号	名詞	\N	\N	\N	755	\N
20	de	…の	前置詞	\N	\N	\N	755	\N
241	 teléfono 	電話	名詞	\N	\N	\N	755	\N
197	dos	2	名詞	\N	\N	\N	756	\N
242	cero	0	名詞	\N	\N	\N	756	\N
243	cuatro	4	名詞	\N	\N	\N	756	\N
200	 sesenta y nueve 	69	 名詞	\N	\N	\N	756	\N
221	 Cómo 	なんとおっしゃいましたか？	疑問副詞	\N	\N	\N	757	\N
244	 Más 	もっと	副詞	\N	\N	\N	758	\N
245	 despacio 	ゆっくりと	副詞	\N	\N	\N	758	\N
246	 por favor 	どうぞ	前置詞＋名詞	\N	\N	\N	758	\N
197	dos	2	名詞	\N	\N	\N	759	\N
242	cero	0	名詞	\N	\N	\N	759	\N
243	cuatro	4	名詞	\N	\N	\N	759	\N
200	 sesenta y nueve 	69	 名詞	\N	\N	\N	759	\N
247	 Vale 	よろしい	動詞	\N	\N	\N	760	\N
9	Gracias	ありがとう	間投詞	\N	\N	\N	761	\N
248	 De nada 	どういたしまして	前置詞＋代名詞 	\N	\N	\N	762	\N
138	 Qué 	何	疑問代名詞	\N	\N	\N	763	\N
35	pasa	起こる	動詞	\N	\N	\N	763	\N
32	 Tienes 	持っている	動詞	\N	\N	\N	764	\N
127	 algún 	何らかの	形容詞	\N	\N	\N	764	\N
249	 problema 	問題	名詞	\N	\N	\N	764	\N
221	 cómo 	どのように	疑問副詞	\N	\N	\N	765	\N
250	 funciona 	動く、機能する	動詞	\N	\N	\N	765	\N
189	 esta	この	形容詞	\N	\N	\N	765	\N
251	 fotocopiadora 	コピー機	名詞	\N	\N	\N	765	\N
252	 A ver...	どれどれ…	前置詞＋動詞	\N	\N	\N	766	\N
77	Me		代名詞	\N	\N	\N	767	\N
253	 Parece 	…のようである、…のように思われる	動詞	\N	\N	\N	767	\N
254	 que 	…ということ	接続詞	\N	\N	\N	767	\N
121	 no 	…しない	副詞	\N	\N	\N	767	\N
255	 funciona 	動く、機能する	動詞	\N	\N	\N	767	\N
256	 Con 	…にもかかわらず	前置詞	\N	\N	\N	768	\N
257	 la 		冠詞	\N	\N	\N	768	\N
258	 prisa 	急ぎ	名詞	\N	\N	\N	768	\N
254	 que 	(目的格関係代名詞)	関係代名詞	\N	\N	\N	768	\N
32	 tengo 	私は持っている	動詞	\N	\N	\N	768	\N
259	 En 	…(の中)に	前置詞	\N	\N	\N	769	\N
257	 la 		冠詞	\N	\N	\N	769	\N
260	 biblioteca 	図書館	名詞	\N	\N	\N	769	\N
53	 hay 	(…が)ある	動詞	\N	\N	\N	769	\N
174	otra	ほかの、別の	不定形容詞	\N	\N	\N	769	\N
251	 fotocopiadora 	コピー機	名詞	\N	\N	\N	769	\N
261	Menos mal	ああよかった	副詞＋副詞	\N	\N	\N	770	\N
221	 cómo 	どのように	疑問詞	\N	\N	\N	771	\N
262	 se 	(再帰受身をつくる)	再帰代名詞	\N	\N	\N	771	\N
263	 sacan 	とる	動詞	\N	\N	\N	771	\N
264	 fotocopias 	コピー	名詞	\N	\N	\N	771	\N
265	 ampliadas 	拡大した	形容詞	\N	\N	\N	771	\N
107	 Sí 	はい	副詞	\N	\N	\N	772	\N
66	 Es 	…である	動詞	\N	\N	\N	773	\N
113	 muy 	とても	副詞	\N	\N	\N	773	\N
266	 fácil 	簡単な	形容詞	\N	\N	\N	773	\N
267	 Te 	君にとって	代名詞	\N	\N	\N	774	\N
268	 importa 	迷惑である	動詞	\N	\N	\N	774	\N
215	acompañarme	私に付き添うこと	動詞＋代名詞	\N	\N	\N	774	\N
269	 y 	そして	接続詞	\N	\N	\N	774	\N
200	 ayudarme 	私を手伝うこと	動詞＋代名詞	\N	\N	\N	774	\N
270	 Claro que 	もちろん…である	形容詞＋接続詞	\N	\N	\N	775	\N
121	 no 	…しない	副詞	\N	\N	\N	775	\N
48	 Muchas 	たくさんの	形容詞	\N	\N	\N	776	\N
110	 gracias 	ありがとう	名詞	\N	\N	\N	776	\N
271	 Este 	この	形容詞	\N	\N	\N	777	\N
272	fin	終わり	名詞	\N	\N	\N	777	\N
273	de 	…の	前置詞	\N	\N	\N	777	\N
198	semana	週	名詞	\N	\N	\N	777	\N
274	Elena 	エレナ	固有名詞	\N	\N	\N	777	\N
5	y	…と	接続詞	\N	\N	\N	777	\N
81	yo	私	代名詞	\N	\N	\N	777	\N
187	vamos a	(「ir a＋不定詞」で)…する予定である	動詞＋前置詞	\N	\N	\N	777	\N
275	viajar 	旅行する	動詞	\N	\N	\N	777	\N
192	por	…を、…のあたりを	前置詞	\N	\N	\N	777	\N
276	Galicia	ガリシア	固有名詞	\N	\N	\N	777	\N
45	Quieres 	…したい	動詞	\N	\N	\N	778	\N
102	venir	来る	動詞	\N	\N	\N	778	\N
23	 Sí 	はい	副詞	\N	\N	\N	779	\N
277	con mucho gusto	喜んで	前置詞＋形容詞＋名詞	\N	\N	\N	779	\N
196	Pensamos	…するつもりである	動詞	\N	\N	\N	780	\N
278	alquilar	借りる	動詞	\N	\N	\N	780	\N
33	un	一つの	冠詞	\N	\N	\N	780	\N
230	coche	自動車	名詞	\N	\N	\N	780	\N
22	Ah	ああ	間投詞	\N	\N	\N	781	\N
100	buena	良い	形容詞	\N	\N	\N	781	\N
279	idea	考え	名詞	\N	\N	\N	781	\N
280	Sabes	…できる	動詞	\N	\N	\N	782	\N
281	conducir	運転する	動詞	\N	\N	\N	782	\N
282	Claro	明白な	形容詞	\N	\N	\N	783	\N
283	Entonces	それなら	副詞	\N	\N	\N	784	\N
284	cuando	…する時	接続詞	\N	\N	\N	784	\N
81	yo	私	代名詞	\N	\N	\N	784	\N
51	me	私を	代名詞	\N	\N	\N	784	\N
285	canse	疲れさせる	動詞	\N	\N	\N	784	\N
286	pones	置く	動詞	\N	\N	\N	784	\N
6	tú	君	代名詞	\N	\N	\N	784	\N
217	al	…に	前置詞＋冠詞	\N	\N	\N	784	\N
287	volante	ハンドル	名詞	\N	\N	\N	784	\N
288	vale	分かった	動詞	\N	\N	\N	784	\N
289	De acuerdo	分かった	前置詞＋名詞	\N	\N	\N	785	\N
8	Muy 	とても	副詞	\N	\N	\N	786	\N
4	bien	良く	副詞	\N	\N	\N	786	\N
189	Este	この	形容詞	\N	\N	\N	787	\N
290	viaje	旅行	名詞	\N	\N	\N	787	\N
77	me	私に	代名詞	\N	\N	\N	787	\N
291	hace	なす、作る	動詞	\N	\N	\N	787	\N
48	mucha	たくさんの	不定形容詞	\N	\N	\N	787	\N
292	ilusión	期待	名詞	\N	\N	\N	787	\N
10	A	…に(とって)	前置詞	\N	\N	\N	788	\N
293	mí	私	代名詞	\N	\N	\N	788	\N
75	también	…もまた	副詞	\N	\N	\N	788	\N
294	 Perdone 	すみません。	動詞	\N	\N	\N	789	\N
108	 por favor 		前置詞＋名詞	\N	\N	\N	789	\N
53	Hay	ある	動詞	\N	\N	\N	790	\N
295	 algún 	ある	形容詞	\N	\N	\N	790	\N
296	 hotel 	ホテル	名詞	\N	\N	\N	790	\N
192	por	…のあたりに	前置詞	\N	\N	\N	790	\N
42	aquí	ここ	副詞	\N	\N	\N	790	\N
297	cerca	近くに	副詞	\N	\N	\N	790	\N
23	Sí	はい	副詞	\N	\N	\N	791	\N
53	hay	ある	動詞	\N	\N	\N	791	\N
298	uno	一つ	代名詞	\N	\N	\N	791	\N
41	en	…に	前置詞	\N	\N	\N	791	\N
13	la		冠詞	\N	\N	\N	791	\N
299	 Plaza Mayor 	マヨール広場	固有名詞	\N	\N	\N	791	\N
104	 Tome 	方向を取る	動詞	\N	\N	\N	792	\N
13	la		冠詞	\N	\N	\N	792	\N
300	 primera 	第一の	形容詞	\N	\N	\N	792	\N
10	a	…に	前置詞	\N	\N	\N	792	\N
301	 derecha 	右	名詞	\N	\N	\N	792	\N
5	y	そして	接続詞	\N	\N	\N	792	\N
302	 luego 	それから	副詞	\N	\N	\N	792	\N
303	 siga 	道をすすむ	動詞	\N	\N	\N	792	\N
304	 todo 	全部の	形容詞	\N	\N	\N	792	\N
305	 recto 	まっすぐに	副詞	\N	\N	\N	792	\N
5	Y	そして	接続詞	\N	\N	\N	793	\N
221	 cómo 	どのように	疑問副詞	\N	\N	\N	793	\N
262	 se 		再帰代名詞	\N	\N	\N	793	\N
306	 llama	…と呼ぶ	動詞	\N	\N	\N	793	\N
13	el		冠詞	\N	\N	\N	793	\N
296	 hotel 	ホテル	名詞	\N	\N	\N	793	\N
307	 Carlos V 	カルロス5世	固有名詞	\N	\N	\N	794	\N
22	Ah	ああ	間投詞	\N	\N	\N	795	\N
5	Y	そして	接続詞	\N	\N	\N	795	\N
308	ｄónde 	どこ	疑問副詞	\N	\N	\N	795	\N
40	 está 	ある	動詞	\N	\N	\N	795	\N
13	la		冠詞	\N	\N	\N	795	\N
309	 librería 	本屋	名詞	\N	\N	\N	795	\N
310	 Fuentetaja 	フエンテタハ	固有名詞	\N	\N	\N	795	\N
311	 Lo siento 	すいません	代名詞＋動詞	\N	\N	\N	796	\N
312	 Eso 	それ	指示代名詞	\N	\N	\N	797	\N
39	no	…でない	副詞	\N	\N	\N	797	\N
145	 lo 	それ	人称代名詞	\N	\N	\N	797	\N
111	 sé 	知っている	動詞	\N	\N	\N	797	\N
5	Y	そして	接続詞	\N	\N	\N	798	\N
53	hay	ある	動詞	\N	\N	\N	798	\N
295	 algún 	ある	形容詞	\N	\N	\N	798	\N
313	 banco 	銀行	名詞	\N	\N	\N	798	\N
192	por	…のあたりに	前置詞	\N	\N	\N	798	\N
42	aquí	ここ	副詞	\N	\N	\N	798	\N
23	Sí	はい	副詞	\N	\N	\N	799	\N
53	hay	ある	動詞	\N	\N	\N	799	\N
298	uno	一つ	代名詞	\N	\N	\N	799	\N
314	 al lado del 	…のそばに	前置詞＋冠詞＋名詞＋前置詞＋冠詞	\N	\N	\N	799	\N
296	 hotel 	ホテル	名詞	\N	\N	\N	799	\N
315	 muchas 	たくさんの	形容詞	\N	\N	\N	800	\N
9	gracias	ありがとう	間投詞	\N	\N	\N	800	\N
200	 De nada.	どういたしまして。	\n\t\t\t\t\t\t\t	\N	\N	\N	801	\N
40	Estás	…である	動詞	\N	\N	\N	802	\N
8	muy	とても	副詞	\N	\N	\N	802	\N
316	 alegre 	うれしい	形容詞	\N	\N	\N	802	\N
39	no	…でない	副詞	\N	\N	\N	802	\N
23	Sí	はい	副詞	\N	\N	\N	803	\N
317	 Es que 	実は…である。	動詞＋接続詞	\N	\N	\N	804	\N
318	 acabo de 	…したばかりです	動詞＋前置詞	\N	\N	\N	804	\N
319	 comprar 	買う	動詞	\N	\N	\N	804	\N
33	un	一つの	冠詞	\N	\N	\N	804	\N
320	 coche 	車	名詞	\N	\N	\N	804	\N
16	Qué	なんと	疑問副詞	\N	\N	\N	805	\N
4	bien	よい	副詞	\N	\N	\N	805	\N
221	 Cómo 	どのように	疑問副詞	\N	\N	\N	806	\N
66	es	…である	動詞	\N	\N	\N	806	\N
13	el		冠詞	\N	\N	\N	806	\N
320	 coche 	車	名詞	\N	\N	\N	806	\N
100	Bueno	ええ	間投詞	\N	\N	\N	807	\N
66	es	…である	動詞	\N	\N	\N	807	\N
321	 compacto 	コンパクトな	形容詞	\N	\N	\N	807	\N
33	un	一つの	冠詞	\N	\N	\N	807	\N
322	 Mercedes 	メルセデス	固有名詞	\N	\N	\N	807	\N
20	De	…の	前置詞	\N	\N	\N	808	\N
16	qué	どの	疑問形容詞	\N	\N	\N	808	\N
323	color	色	名詞	\N	\N	\N	808	\N
66	es	…である	動詞	\N	\N	\N	808	\N
324	 Gris 	灰色の	形容詞	\N	\N	\N	809	\N
325	 metalizado 	メタリックの	形容詞	\N	\N	\N	809	\N
22	Ah	ああ	間投詞	\N	\N	\N	810	\N
326	 Como 	…と同じように	副詞	\N	\N	\N	810	\N
13	el		冠詞	\N	\N	\N	810	\N
58	del	…の	前置詞＋冠詞	\N	\N	\N	810	\N
327	 profesor 	先生	名詞	\N	\N	\N	810	\N
328	 González 	ゴンサレス	固有名詞	\N	\N	\N	810	\N
23	Sí	はい	副詞	\N	\N	\N	811	\N
164	Cuánto	いくら	疑問代名詞	\N	\N	\N	812	\N
267	 te 	君に	代名詞	\N	\N	\N	812	\N
165	ha costado	かかる	動詞	\N	\N	\N	812	\N
329	Eso	それ	指示代名詞	\N	\N	\N	813	\N
66	es	…である	動詞	\N	\N	\N	813	\N
33	un		冠詞	\N	\N	\N	813	\N
330	secreto 	秘密	名詞	\N	\N	\N	813	\N
187	 Voy a 	…しよう	動詞＋前置詞	\N	\N	\N	814	\N
215	 probarme 	試着する	動詞	\N	\N	\N	814	\N
189	esta	この	形容詞	\N	\N	\N	814	\N
331	 falda 	スカート	名詞	\N	\N	\N	814	\N
101	 Vale 	分かった	動詞	\N	\N	\N	815	\N
138	 Qué 	何	疑問代名詞	\N	\N	\N	816	\N
267	 te 	君に	代名詞	\N	\N	\N	816	\N
332	 parece 	…と思われる	動詞	\N	\N	\N	816	\N
69	 Creo 	私は思う	動詞	\N	\N	\N	817	\N
254	 que 	ということ	接続詞	\N	\N	\N	817	\N
267	 te 	君に	代名詞	\N	\N	\N	817	\N
333	 queda 	似合う	動詞	\N	\N	\N	817	\N
334	 mejor 	より良く	副詞	\N	\N	\N	817	\N
148	 la 	その、例の	冠詞	\N	\N	\N	817	\N
335	 otra 	もう一つの	形容詞	\N	\N	\N	817	\N
121	 No 	…しない	副詞	\N	\N	\N	818	\N
267	 te 	君に	代名詞	\N	\N	\N	818	\N
336	 gusta 	(…の)気に入る	動詞	\N	\N	\N	818	\N
148	 el 	その、例の	冠詞	\N	\N	\N	818	\N
337	 color 	色	名詞	\N	\N	\N	818	\N
39	 No 	…でない	副詞	\N	\N	\N	819	\N
315	 mucho 	たいへん、大いに	副詞	\N	\N	\N	819	\N
5	 Y 	そして	接続詞	\N	\N	\N	820	\N
257	 la 		冠詞	\N	\N	\N	820	\N
338	 talla 	丈	名詞	\N	\N	\N	820	\N
69	 Creo 	私は思う	動詞	\N	\N	\N	821	\N
254	 que 	ということ	接続詞	\N	\N	\N	821	\N
155	 para 	…にとって、…のために	前置詞	\N	\N	\N	821	\N
339	 ti 	君	代名詞	\N	\N	\N	821	\N
66	 es 	…である	動詞	\N	\N	\N	821	\N
340	 un poco 	少し	冠詞＋代名詞	\N	\N	\N	821	\N
341	 corta 	短い	形容詞	\N	\N	\N	821	\N
101	 Vale 	分かった	動詞	\N	\N	\N	822	\N
342	 Me quedo con 	私は…に決める、…の方を選ぶ	代名詞＋動詞＋前置詞	\N	\N	\N	823	\N
148	 la 	その、例の	冠詞	\N	\N	\N	823	\N
343	 otra 	もう一つの	形容詞	\N	\N	\N	823	\N
23	 Sí 	はい	副詞	\N	\N	\N	824	\N
66	 es 	…である	動詞	\N	\N	\N	824	\N
334	 mejor 	より良い	形容詞	\N	\N	\N	824	\N
344	 Hola 	こんにちは	間投詞	\N	\N	\N	825	\N
345	 Pablo 	パブロ	固有名詞	\N	\N	\N	825	\N
138	 Qué 	何を	疑問代名詞	\N	\N	\N	826	\N
172	 estás 	…している(「estar + 現在分詞」進行形)	動詞	\N	\N	\N	826	\N
346	 leyendo 	読む	動詞	\N	\N	\N	826	\N
347	Cien años de soledad	百年の孤独		\N	\N	\N	827	\N
124	 de 	…の	前置詞	\N	\N	\N	827	\N
348	 García Márquez 	ガルシア・マルケス	固有名詞	\N	\N	\N	827	\N
46	 Te 	君に	代名詞	\N	\N	\N	828	\N
118	 gustan 	気に入る	動詞	\N	\N	\N	828	\N
148	 las 		冠詞	\N	\N	\N	828	\N
349	 novelas 	小説	名詞	\N	\N	\N	828	\N
107	 Sí 	はい	副詞	\N	\N	\N	829	\N
117	 Me 	私に	代名詞	\N	\N	\N	830	\N
118	 gustan 	気に入る	動詞	\N	\N	\N	830	\N
315	 mucho 	とても、大いに	副詞	\N	\N	\N	830	\N
350	 las 		冠詞	\N	\N	\N	830	\N
349	 novelas 	小説	名詞	\N	\N	\N	830	\N
267	 te 	君に	代名詞	\N	\N	\N	944	\N
10	 A 	…に(間接目的語)	前置詞	\N	\N	\N	831	\N
115	 mí 	私	代名詞	\N	\N	\N	831	\N
121	 no 	…しない	副詞	\N	\N	\N	831	\N
117	 me 	私に	代名詞	\N	\N	\N	831	\N
118	 gustan 	気に入る	動詞	\N	\N	\N	831	\N
315	 mucho 	あまり…ない(否定語とともに)	副詞	\N	\N	\N	831	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	832	\N
107	 sí 	そう	副詞	\N	\N	\N	832	\N
351	 Es que 	…である	動詞	\N	\N	\N	833	\N
131	 a 	…に(間接目的語)	前置詞	\N	\N	\N	833	\N
115	 mí 	私	代名詞(前置詞格)	\N	\N	\N	833	\N
121	 no 	…でない	副詞	\N	\N	\N	833	\N
117	 me 	私に	代名詞	\N	\N	\N	833	\N
118	 gusta 	気に入る	動詞	\N	\N	\N	833	\N
257	 la 	 la 	冠詞	\N	\N	\N	833	\N
352	 ficción 	フィクション	名詞	\N	\N	\N	833	\N
353	 Entonces 	それなら	副詞	\N	\N	\N	834	\N
138	 qué 	何の、どんな	疑問形容詞	\N	\N	\N	834	\N
354	 clase 	種類	名詞	\N	\N	\N	834	\N
124	 de 	…の	前置詞	\N	\N	\N	834	\N
355	 libros 	本	名詞	\N	\N	\N	834	\N
267	 te 	君に	代名詞	\N	\N	\N	834	\N
118	 gusta 	気に入る	動詞	\N	\N	\N	834	\N
356	 Reportajes 	ルポルタージュ	名詞	\N	\N	\N	835	\N
357	 biografías 	伝記	名詞	\N	\N	\N	835	\N
358	 estudios 	研究書	名詞	\N	\N	\N	835	\N
10	 A 	…に(間接目的語)	前置詞	\N	\N	\N	836	\N
115	 mí 	私	代名詞(前置詞格)	\N	\N	\N	836	\N
121	 no 	…しない	副詞	\N	\N	\N	836	\N
117	 me 	私に	代名詞	\N	\N	\N	836	\N
359	 interesa 	(…にとって)興味がある	動詞	\N	\N	\N	836	\N
315	 mucho 	あまり…ない(否定語とともに)	副詞	\N	\N	\N	836	\N
360	ese	その	形容詞	\N	\N	\N	836	\N
361	 tipo 	タイプ	名詞	\N	\N	\N	836	\N
124	 de 	…の	前置詞	\N	\N	\N	836	\N
355	 libros 	本	名詞	\N	\N	\N	836	\N
138	 Qué 	何	疑問代名詞	\N	\N	\N	837	\N
362	 haces 	する	動詞	\N	\N	\N	837	\N
148	 los 		冠詞	\N	\N	\N	837	\N
363	 fines 	終わり	名詞	\N	\N	\N	837	\N
124	 de 	…の	前置詞	\N	\N	\N	837	\N
125	 semana 	週	名詞	\N	\N	\N	837	\N
364	 Normalmente 	普通は	副詞	\N	\N	\N	838	\N
92	 salgo 	出かける	動詞	\N	\N	\N	838	\N
256	 con 	…とともに	前置詞	\N	\N	\N	838	\N
134	 mis 	私の	所有形容詞	\N	\N	\N	838	\N
365	 amigos 	友達	名詞	\N	\N	\N	838	\N
5	 Y 	そして	接続詞	\N	\N	\N	839	\N
12	 vais 	行く	動詞	\N	\N	\N	839	\N
366	 al 	…に、…へ	前置詞＋冠詞	\N	\N	\N	839	\N
367	 cine 	映画館	名詞	\N	\N	\N	839	\N
107	 Sí 	はい	副詞	\N	\N	\N	840	\N
77	 Me 	私に	代名詞	\N	\N	\N	841	\N
118	 gusta 	気に入る	動詞	\N	\N	\N	841	\N
315	 mucho 	とても、大いに	副詞	\N	\N	\N	841	\N
130	 ir 	行く	動詞	\N	\N	\N	841	\N
366	 al 	…に、…へ	前置詞＋冠詞	\N	\N	\N	841	\N
367	 cine 	映画館	名詞	\N	\N	\N	841	\N
5	 Y 	そして	接続詞	\N	\N	\N	842	\N
137	 tú 	君	代名詞	\N	\N	\N	842	\N
138	 qué 	何	疑問代名詞	\N	\N	\N	842	\N
362	 haces 	する	動詞	\N	\N	\N	842	\N
81	 Yo 	私は	代名詞	\N	\N	\N	843	\N
368	 habitualmente 	いつも	副詞	\N	\N	\N	843	\N
12	 voy 	行く	動詞	\N	\N	\N	843	\N
366	 al 	…に、…へ	前置詞＋冠詞	\N	\N	\N	843	\N
369	 campo 	田舎	名詞	\N	\N	\N	843	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	844	\N
107	 sí 	そう	副詞	\N	\N	\N	844	\N
46	 Te 	君に	代名詞	\N	\N	\N	845	\N
118	 gusta 	気に入る	動詞	\N	\N	\N	845	\N
370	 la 		冠詞	\N	\N	\N	845	\N
371	 naturaleza 	自然	名詞	\N	\N	\N	845	\N
107	 Sí 	はい	副詞	\N	\N	\N	846	\N
117	 Me 	私に	代名詞	\N	\N	\N	847	\N
372	 encanta 	…が大好きである	動詞	\N	\N	\N	847	\N
10	 A 	…に(間接目的語)	前置詞	\N	\N	\N	848	\N
115	 mí 	私	代名詞(前置詞格)	\N	\N	\N	848	\N
116	 también 	…もまた	副詞	\N	\N	\N	848	\N
117	 me 	私に	代名詞	\N	\N	\N	848	\N
118	 gusta 	気に入る	動詞	\N	\N	\N	848	\N
12	ir	行く	動詞	\N	\N	\N	848	\N
366	 al 	…に、…へ	前置詞＋冠詞	\N	\N	\N	848	\N
369	 campo 	田舎	名詞	\N	\N	\N	848	\N
228	 Por qué 	なぜ、どうして(por qué no...で「提案(…しない？)」を表す)	前置詞＋疑問代名詞	\N	\N	\N	849	\N
121	 no	…しない	副詞	\N	\N	\N	849	\N
12	 vamos 	行く	動詞	\N	\N	\N	849	\N
373	 juntos 	一緒の	形容詞	\N	\N	\N	849	\N
257	 la 		冠詞	\N	\N	\N	849	\N
374	 próxima 	次の	形容詞	\N	\N	\N	849	\N
375	 vez 	回	名詞	\N	\N	\N	849	\N
143	 Buena 	良い	形容詞	\N	\N	\N	850	\N
144	 idea 	考え	名詞	\N	\N	\N	850	\N
71	 Perdone 	すみません	動詞	\N	\N	\N	851	\N
221	 Cómo 	どうやって	疑問副詞	\N	\N	\N	852	\N
255	 funciona 	動く、機能する	動詞	\N	\N	\N	852	\N
119	 esta	この	形容詞	\N	\N	\N	852	\N
251	 fotocopiadora 	コピー機	名詞	\N	\N	\N	852	\N
300	 Primero 	まず、最初に	副詞	\N	\N	\N	853	\N
214	 tiene que 	…しなければならない	動詞＋接続詞	\N	\N	\N	853	\N
376	 meter 	入れる	動詞	\N	\N	\N	853	\N
13	 la 		冠詞	\N	\N	\N	853	\N
377	 moneda 	硬貨	名詞	\N	\N	\N	853	\N
107	 Sí 	はい	副詞	\N	\N	\N	854	\N
302	 Luego 	次に	副詞	\N	\N	\N	855	\N
286	 ponga 	置く	動詞	\N	\N	\N	855	\N
109	 aquí 	ここに	副詞	\N	\N	\N	855	\N
148	 el 		冠詞	\N	\N	\N	855	\N
378	 documento 	文書	名詞	\N	\N	\N	855	\N
379	 original 	オリジナルの	形容詞	\N	\N	\N	855	\N
380	 Vale 	はい、分かりました	動詞	\N	\N	\N	856	\N
218	 Después 	その後で	副詞	\N	\N	\N	857	\N
381	 pulse 	押す	動詞	\N	\N	\N	857	\N
119	 este 	この	形容詞	\N	\N	\N	857	\N
382	 botón 	ボタン	名詞	\N	\N	\N	857	\N
113	 Muy 	とても、大いに	副詞	\N	\N	\N	858	\N
136	 bien 	良く	副詞	\N	\N	\N	858	\N
5	 Y 	では、そして	接続詞	\N	\N	\N	859	\N
155	 para 	(…する)ために	前置詞	\N	\N	\N	859	\N
383	 cambiar 	変える	動詞	\N	\N	\N	859	\N
148	 el 		冠詞	\N	\N	\N	859	\N
384	 tamaño 	大きさ	名詞	\N	\N	\N	859	\N
62	 del 	…の	前置詞	\N	\N	\N	859	\N
385	 papel 	紙	名詞	\N	\N	\N	859	\N
386	 Puede 	…できる	動詞	\N	\N	\N	860	\N
215	 elegirlo 	それを選ぶ	動詞＋代名詞	\N	\N	\N	860	\N
256	 con 	…で、…によって	前置詞	\N	\N	\N	860	\N
119	 este 	この	形容詞	\N	\N	\N	860	\N
382	 botón 	ボタン	名詞	\N	\N	\N	860	\N
113	 Muy 	とても、大いに	副詞	\N	\N	\N	861	\N
136	 bien 	良く	副詞	\N	\N	\N	861	\N
48	 Muchas 	たくさんの	形容詞	\N	\N	\N	862	\N
387	 gracias 	ありがとう	名詞	\N	\N	\N	862	\N
248	 De nada 	どういたしまして	前置詞＋代名詞	\N	\N	\N	863	\N
215	Dígame 	もしもし	動詞＋代名詞	\N	\N	\N	864	\N
344	 Hola 	こんにちは	間投詞	\N	\N	\N	865	\N
388	 Luis 	ルイス	固有名詞	\N	\N	\N	865	\N
66	 Soy 	…である	動詞	\N	\N	\N	866	\N
389	 Eva 	エバ	固有名詞	\N	\N	\N	866	\N
390	Hombre	ああ	間投詞	\N	\N	\N	867	\N
389	 Eva 	エバ	固有名詞	\N	\N	\N	867	\N
221	Cómo 	どのように 	疑問副詞	\N	\N	\N	868	\N
267	 te 	君に(とって)	代名詞	\N	\N	\N	868	\N
12	 va 	行く	動詞	\N	\N	\N	868	\N
391	Últimamente	最近	副詞	\N	\N	\N	869	\N
172	 estoy 	…の状態にある	動詞	\N	\N	\N	869	\N
113	 muy 	とても	副詞	\N	\N	\N	869	\N
392	 ocupado 	忙しい	形容詞	\N	\N	\N	869	\N
393	 José 	ホセ 	固有名詞	\N	\N	\N	870	\N
269	 y 	…と	接続詞	\N	\N	\N	870	\N
140	 yo 	私	代名詞	\N	\N	\N	870	\N
172	 estamos 	…の状態である	動詞	\N	\N	\N	870	\N
394	 preocupados 	心配している	形容詞	\N	\N	\N	870	\N
395	 por 	…のために	前置詞	\N	\N	\N	870	\N
339	 ti 	君	前置詞	\N	\N	\N	870	\N
396	 porque 	…なので	接続詞	\N	\N	\N	870	\N
121	 no 	…ない	副詞	\N	\N	\N	870	\N
102	 vienes 	来る	動詞	\N	\N	\N	870	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	870	\N
354	 clase 	授業	名詞	\N	\N	\N	870	\N
36	 Es que 	実は…である	動詞＋接続詞	\N	\N	\N	871	\N
397	 trabajo 	働く	動詞	\N	\N	\N	871	\N
124	 de 	…として	前置詞	\N	\N	\N	871	\N
398	 profesor 	先生	名詞	\N	\N	\N	871	\N
259	 en 	…で、…において	前置詞	\N	\N	\N	871	\N
33	 una 	ある	冠詞	\N	\N	\N	871	\N
399	 academia 	学校	名詞	\N	\N	\N	871	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	872	\N
23	sí	そう	副詞	\N	\N	\N	872	\N
5	 Y 	それで 	接続詞	\N	\N	\N	873	\N
121	 no 	…ない	副詞	\N	\N	\N	873	\N
400	 tiempo 	時間	名詞	\N	\N	\N	873	\N
155	 para 	…するための	前置詞	\N	\N	\N	873	\N
130	 ir 	行く	動詞	\N	\N	\N	873	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	873	\N
354	 clase 	授業	名詞	\N	\N	\N	873	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	874	\N
121	 no 	…ない	副詞	\N	\N	\N	874	\N
145	 lo 	そのこと	代名詞	\N	\N	\N	874	\N
401	sabía 	知っている	動詞	\N	\N	\N	874	\N
138	 Qué 	何	疑問代名詞	\N	\N	\N	875	\N
187	 vamos a 	…する予定である、…しよう	動詞＋前置詞	\N	\N	\N	875	\N
139	 hacer 	する	動詞	\N	\N	\N	875	\N
148	 el 		冠詞	\N	\N	\N	875	\N
402	 sábado 	土曜日	名詞	\N	\N	\N	875	\N
254	 que	…するところの	関係代名詞	\N	\N	\N	875	\N
102	 viene 	来る	動詞	\N	\N	\N	875	\N
44	 Si 	もし…なら	接続詞	\N	\N	\N	876	\N
362	 hace 	(三人称単数形で)天候が…である	動詞	\N	\N	\N	876	\N
143	 buen 	良い	形容詞	\N	\N	\N	876	\N
400	 tiempo 	天気	名詞	\N	\N	\N	876	\N
130	 ir 	行く	動詞	\N	\N	\N	876	\N
217	 al 	…に、…へ	前置詞＋冠詞	\N	\N	\N	876	\N
369	 campo 	田舎、郊外	名詞	\N	\N	\N	876	\N
143	 Buena 	良い	形容詞	\N	\N	\N	877	\N
144	 idea 	考え	名詞	\N	\N	\N	877	\N
227	 Pero 	でも、しかし	接続詞	\N	\N	\N	878	\N
138	 Qué 	何	疑問代名詞	\N	\N	\N	879	\N
187	 vamos a 	…する予定である、…しよう	動詞＋前置詞	\N	\N	\N	879	\N
139	 hacer 	する	動詞	\N	\N	\N	879	\N
44	 si 	もし…なら	接続詞	\N	\N	\N	879	\N
362	 hace 	(三人称単数形で)天候が…である	動詞	\N	\N	\N	879	\N
400	 tiempo 	天気	名詞	\N	\N	\N	879	\N
404	 Pues 	それなら	接続詞	\N	\N	\N	880	\N
386	 podemos 	…できる	動詞	\N	\N	\N	880	\N
133	 ver 	見る	動詞	\N	\N	\N	880	\N
106	 unas 	いくつかの	形容詞	\N	\N	\N	880	\N
405	 películas 	映画	名詞	\N	\N	\N	880	\N
259	 en 	…で、…において	前置詞	\N	\N	\N	880	\N
406	 mi 	私の	形容詞	\N	\N	\N	880	\N
238	 casa 	家	名詞	\N	\N	\N	880	\N
8	 Muy 	とても	副詞	\N	\N	\N	881	\N
136	 bien 	良く	副詞	\N	\N	\N	881	\N
353	 Entonces 	それでは	副詞	\N	\N	\N	882	\N
44	 si 	もし…なら	接続詞	\N	\N	\N	882	\N
362	 hace 	(三人称単数形で)天候が…である	動詞	\N	\N	\N	882	\N
143	 buen 	良い	形容詞	\N	\N	\N	882	\N
400	 tiempo 	天気	名詞	\N	\N	\N	882	\N
407	 quedamos 	待ち合わせする	動詞	\N	\N	\N	882	\N
259	 en 	…で、…において	前置詞	\N	\N	\N	882	\N
13	 la 		冠詞	\N	\N	\N	882	\N
408	 estación 	駅	名詞	\N	\N	\N	882	\N
131	 a 	…時に	前置詞	\N	\N	\N	882	\N
226	 nueve 	9	数詞	\N	\N	\N	882	\N
409	 Perfecto 	よろしい	形容詞	\N	\N	\N	883	\N
410	 Y 	そして	接続詞	\N	\N	\N	884	\N
44	 si 	もし…なら	接続詞	\N	\N	\N	884	\N
362	 hace 	(三人称単数形で)天候が…である	動詞	\N	\N	\N	884	\N
400	 tiempo 	天気	名詞	\N	\N	\N	884	\N
411	 ven 	来い	動詞	\N	\N	\N	884	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	884	\N
406	 mi 	私の	形容詞	\N	\N	\N	884	\N
238	 casa 	家	名詞	\N	\N	\N	884	\N
148	 las 		冠詞	\N	\N	\N	884	\N
412	 once 	11	数詞	\N	\N	\N	884	\N
413	 De acuerdo 	分かった	前置詞＋名詞	\N	\N	\N	885	\N
404	 Pues 	それなら	接続詞	\N	\N	\N	886	\N
151	 hasta 	…まで	前置詞	\N	\N	\N	886	\N
148	 el 		冠詞	\N	\N	\N	886	\N
402	 sábado 	土曜日	名詞	\N	\N	\N	886	\N
150	 Adiós 	さようなら	間投詞	\N	\N	\N	887	\N
414	Buenos días	おはようございます		\N	\N	\N	888	\N
415	Qué 	何	疑問代名詞	\N	\N	\N	889	\N
416	 desea 	欲する	動詞	\N	\N	\N	889	\N
236	ustedes	あなたがた	代名詞	\N	\N	\N	890	\N
417	jamón ibérico de bellota	ハモン・イベリコ・デ・べジョータ		\N	\N	\N	890	\N
418	Sí 	はい	副詞	\N	\N	\N	891	\N
40	Está 	…である	動詞	\N	\N	\N	892	\N
10	a	…で	前置詞	\N	\N	\N	892	\N
419	veintiún	21の	形容詞	\N	\N	\N	892	\N
420	 euros 	ユーロ	名詞	\N	\N	\N	892	\N
13	el		冠詞	\N	\N	\N	892	\N
421	 kilo 	キログラム	名詞	\N	\N	\N	892	\N
415	Qué 	何と	疑問副詞	\N	\N	\N	893	\N
422	 caro 	高い	形容詞	\N	\N	\N	893	\N
160	 Quería 	欲しい	動詞	\N	\N	\N	894	\N
423	 algo 	何か	代名詞	\N	\N	\N	894	\N
424	 menos 	より…ない	副詞	\N	\N	\N	894	\N
422	 caro 	高い	形容詞	\N	\N	\N	894	\N
100	Bueno	はい	間投詞	\N	\N	\N	895	\N
189	este	この	形容詞	\N	\N	\N	895	\N
425	 otro 	ほかのもの	代名詞	\N	\N	\N	895	\N
426	también 	･･･もまた	副詞	\N	\N	\N	895	\N
66	es	…である	動詞	\N	\N	\N	895	\N
8	muy	とても	副詞	\N	\N	\N	895	\N
427	Éste	これ	代名詞	\N	\N	\N	896	\N
66	es	…である	動詞	\N	\N	\N	896	\N
244	 más 	もっと	副詞	\N	\N	\N	896	\N
428	 barato 	安い	形容詞	\N	\N	\N	896	\N
70	que	･･･より	接続詞	\N	\N	\N	896	\N
13	el	･･のそれ	冠詞	\N	\N	\N	896	\N
429	 de bellota 	デ・べジョータ		\N	\N	\N	896	\N
40	está 	…である	動詞	\N	\N	\N	896	\N
10	a	…で 	前置詞	\N	\N	\N	896	\N
430	 quince 	15の	形容詞	\N	\N	\N	896	\N
421	 kilo 	キログラム	名詞	\N	\N	\N	896	\N
283	Entonces	それなら	副詞	\N	\N	\N	897	\N
319	 compraré 	買う	動詞	\N	\N	\N	897	\N
431	éste 	これ	代名詞	\N	\N	\N	897	\N
432	Cuántos 	どれだけの	疑問形容詞	\N	\N	\N	898	\N
433	 gramos 	グラム	名詞	\N	\N	\N	898	\N
201	 le 	あなたに	代名詞	\N	\N	\N	898	\N
434	 pongo 	置く	動詞	\N	\N	\N	898	\N
435	 Medio 	半分の	形容詞	\N	\N	\N	899	\N
421	 kilo 	キログラム	名詞	\N	\N	\N	899	\N
432	Cuánto 	いくら	疑問代名詞	\N	\N	\N	900	\N
165	cuesta	(費用が)かかる	動詞	\N	\N	\N	900	\N
436	 siete 	7の	形容詞	\N	\N	\N	901	\N
420	 euros 	ユーロ	名詞	\N	\N	\N	901	\N
28	con	…と一緒に	前置詞	\N	\N	\N	901	\N
437	cincuenta 	50の	形容詞	\N	\N	\N	901	\N
438	céntimos	センティモ	名詞	\N	\N	\N	901	\N
439	Aquí 	ここ	副詞	\N	\N	\N	902	\N
32	tiene	持つ	動詞	\N	\N	\N	902	\N
71	 Perdone 	すみません	動詞	\N	\N	\N	903	\N
398	 profesor 	先生	名詞	\N	\N	\N	903	\N
440	 Dime 	何ですか	動詞+代名詞	\N	\N	\N	904	\N
127	 algunas 	いくつかの	形容詞	\N	\N	\N	905	\N
441	 dudas 	疑問	名詞	\N	\N	\N	905	\N
442	 sobre 	…について	前置詞	\N	\N	\N	905	\N
13	 la 		冠詞	\N	\N	\N	905	\N
443	 redacción 	レポート	名詞	\N	\N	\N	905	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	906	\N
107	 sí 	そう	副詞	\N	\N	\N	906	\N
444	 Podría 	…してもよいでしょうか	動詞	\N	\N	\N	907	\N
130	 ir 	行く	動詞	\N	\N	\N	907	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	907	\N
445	 su 	あなたの	形容詞	\N	\N	\N	907	\N
446	 despacho 	研究室	名詞	\N	\N	\N	907	\N
155	 para 	…するために	前置詞	\N	\N	\N	907	\N
447	 hablar 	話す	動詞	\N	\N	\N	907	\N
256	 con 	…と	前置詞	\N	\N	\N	907	\N
448	 usted 	あなた	代名詞	\N	\N	\N	907	\N
107	 Sí 	はい	副詞	\N	\N	\N	908	\N
449	 por supuesto 	もちろん	前置詞＋形容詞	\N	\N	\N	908	\N
450	 Cuándo 	いつ	疑問副詞	\N	\N	\N	909	\N
201	 le 	あなたに(とって)	代名詞	\N	\N	\N	909	\N
451	 conviene 	都合がよい	動詞	\N	\N	\N	909	\N
254	 que 	…ということ	接続詞	\N	\N	\N	909	\N
12	 vaya 	行く	動詞	\N	\N	\N	909	\N
138	 Qué 	どう		\N	\N	\N	910	\N
267	 te 	君に(とって)	代名詞	\N	\N	\N	910	\N
332	 parece 	思われる	動詞	\N	\N	\N	910	\N
452	 si 	…なら	接続詞	\N	\N	\N	910	\N
51	 nos 	私たちを	代名詞	\N	\N	\N	910	\N
147	 vemos 	会う	動詞	\N	\N	\N	910	\N
148	 el 		冠詞	\N	\N	\N	910	\N
453	 viernes 	金曜日	名詞	\N	\N	\N	910	\N
454	 a	…の頃に	前置詞	\N	\N	\N	910	\N
455	 mediodía 	お昼	名詞	\N	\N	\N	910	\N
113	 Muy 	とても	副詞	\N	\N	\N	911	\N
4	bien	良く	副詞	\N	\N	\N	911	\N
353	 Entonces 	それでは	副詞	\N	\N	\N	912	\N
51	 nos 	私たちを	代名詞	\N	\N	\N	912	\N
147	 vemos 	会う	動詞	\N	\N	\N	912	\N
148	 el 		冠詞	\N	\N	\N	912	\N
453	 viernes 	金曜日	名詞	\N	\N	\N	912	\N
344	 Hola 	やあ	間投詞	\N	\N	\N	913	\N
456	 Ana 	アナ	固有名詞	\N	\N	\N	913	\N
344	 Hola 	こんにちは	間投詞	\N	\N	\N	914	\N
457	 Miguel 	ミゲル	固有名詞	\N	\N	\N	914	\N
3	 Qué tal 	どのように	疑問副詞＋副詞	\N	\N	\N	915	\N
13	 la 	例の	冠詞	\N	\N	\N	915	\N
458	 fiesta 	パーティー	名詞	\N	\N	\N	915	\N
459	 del 	…の	前置詞＋冠詞	\N	\N	\N	915	\N
402	 sábado 	土曜日	名詞	\N	\N	\N	915	\N
145	 Lo 	そのこと	代名詞	\N	\N	\N	916	\N
460	 pasamos 	過ごす		\N	\N	\N	916	\N
113	 muy 	とても	副詞	\N	\N	\N	916	\N
136	 bien 	良く	副詞	\N	\N	\N	916	\N
227	 Pero 	でも	接続詞	\N	\N	\N	917	\N
228	 por qué 	どうして、なぜ	前置詞＋疑問代名詞	\N	\N	\N	917	\N
121	 no 	…ない	副詞	\N	\N	\N	917	\N
102	 viniste 	来る	動詞	\N	\N	\N	917	\N
461	 La verdad 	実は	冠詞＋名詞	\N	\N	\N	918	\N
121	 no 	…ない	副詞	\N	\N	\N	918	\N
117	 me 	私に(とって)	代名詞	\N	\N	\N	918	\N
462	 apeteció 	…する気にさせる	動詞	\N	\N	\N	918	\N
463	 salir 	出かける	動詞	\N	\N	\N	918	\N
396	 porque 	…なので	接続詞	\N	\N	\N	918	\N
172	 estaba 	…の状態である	動詞	\N	\N	\N	918	\N
464	 enferma 	病気の	形容詞	\N	\N	\N	918	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	919	\N
107	 sí 	そう	副詞	\N	\N	\N	919	\N
172	 Estabas 	…の状態である	動詞	\N	\N	\N	920	\N
465	 resfriada 	風邪をひいた	形容詞	\N	\N	\N	920	\N
107	 Sí 	はい	副詞	\N	\N	\N	921	\N
466	 por desgracia 	不幸にも	前置詞＋名詞	\N	\N	\N	921	\N
5	 Y 	そして	接続詞	\N	\N	\N	922	\N
467	 ya 	もう	副詞	\N	\N	\N	922	\N
172	 estás 	…の状態である	動詞	\N	\N	\N	922	\N
136	 bien 	良い	副詞	\N	\N	\N	922	\N
468	 Más o menos 	だいたい、およそ	副詞＋接続詞＋副詞	\N	\N	\N	923	\N
114	 Bueno 	そう	間投詞	\N	\N	\N	924	\N
469	 cuídate 	体に気をつける	動詞＋再帰代名詞	\N	\N	\N	924	\N
110	 Gracias 	ありがとう	名詞	\N	\N	\N	925	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	926	\N
470	 Isabel 	イサベル	固有名詞	\N	\N	\N	926	\N
267	 Te 	君を	代名詞	\N	\N	\N	927	\N
40	 estaba 	(現在分詞とともに)…している	動詞	\N	\N	\N	927	\N
471	 buscando 	探す	動詞	\N	\N	\N	927	\N
472	 Pareces 	…のように見える	動詞	\N	\N	\N	928	\N
473	 nervioso 	いらいらしている	形容詞	\N	\N	\N	928	\N
138	 Qué 	何	疑問代名詞	\N	\N	\N	929	\N
267	 te 	君に	代名詞	\N	\N	\N	929	\N
474	 pasa 	起こる	動詞	\N	\N	\N	929	\N
475	 hacerme 	私に(…を)する	動詞＋代名詞	\N	\N	\N	930	\N
33	 un 	一つの	冠詞	\N	\N	\N	930	\N
476	 favor 	好意	名詞	\N	\N	\N	930	\N
107	 Sí 	はい	副詞	\N	\N	\N	931	\N
440	 Dime 	何ですか? 	動詞＋代名詞	\N	\N	\N	932	\N
477	 Es que 	実は…なのだ	動詞＋接続詞	\N	\N	\N	933	\N
478	 he perdido 	なくす	動詞	\N	\N	\N	933	\N
479	 todos 	全ての	形容詞	\N	\N	\N	933	\N
13	 los 		冠詞	\N	\N	\N	933	\N
480	 apuntes 	ノート	名詞	\N	\N	\N	933	\N
124	 de 	…の	前置詞	\N	\N	\N	933	\N
481	 literatura 	文学	名詞	\N	\N	\N	933	\N
482	 No me digas 	まさか、そんなばかな	副詞＋代名詞＋動詞	\N	\N	\N	934	\N
483	 dejarme 	私に貸す	動詞＋代名詞	\N	\N	\N	935	\N
484	 tus 	君の	形容詞	\N	\N	\N	935	\N
480	 apuntes 	ノート	名詞	\N	\N	\N	935	\N
155	 para 	…するために	前置詞	\N	\N	\N	935	\N
485	 fotocopiarlos 	それらをコピーする	動詞＋代名詞	\N	\N	\N	935	\N
486	 Cómo no 	もちろん	疑問副詞＋副詞	\N	\N	\N	936	\N
48	 Muchísimas 	とてもたくさんの	形容詞	\N	\N	\N	937	\N
387	 gracias 	ありがとう	名詞	\N	\N	\N	937	\N
487	 No hay de qué 	どういたしまして	副詞＋動詞＋前置詞＋疑問代名詞	\N	\N	\N	938	\N
488	 Oye 	聞く	動詞	\N	\N	\N	939	\N
457	 Miguel 	ミゲル	固有名詞	\N	\N	\N	939	\N
267	 Te 	君に	代名詞	\N	\N	\N	940	\N
118	 gusta 	気に入る	動詞	\N	\N	\N	940	\N
489	 viajar 	旅行する	動詞	\N	\N	\N	940	\N
107	 Sí 	はい	副詞	\N	\N	\N	941	\N
490	 muchísimo 	とても	副詞	\N	\N	\N	941	\N
491	 Quiero	…したい	動詞	\N	\N	\N	942	\N
489	 viajar 	旅行する	動詞	\N	\N	\N	942	\N
395	 por 	…(のあたり、じゅう)を	前置詞	\N	\N	\N	942	\N
479	 todo 	全ての	形容詞	\N	\N	\N	942	\N
148	 el 		冠詞	\N	\N	\N	942	\N
492	 mundo 	世界	名詞	\N	\N	\N	942	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	943	\N
107	 sí 	そう	副詞	\N	\N	\N	943	\N
5	 Y 	それで	接続詞	\N	\N	\N	944	\N
493	 adónde 	どこへ	疑問副詞	\N	\N	\N	944	\N
118	 gustaría 	…してみたい	動詞	\N	\N	\N	944	\N
130	 ir 	行く	動詞	\N	\N	\N	944	\N
494	 Desde luego 	もちろん	前置詞＋副詞	\N	\N	\N	945	\N
491	 quiero 	…したい	動詞	\N	\N	\N	945	\N
130	 ir 	行く	動詞	\N	\N	\N	945	\N
131	 a 	…へ	前置詞	\N	\N	\N	945	\N
495	 Asia 	アジア	固有名詞	\N	\N	\N	945	\N
227	 Pero 	でも	接続詞	\N	\N	\N	946	\N
495	 Asia 	アジア	固有名詞	\N	\N	\N	946	\N
66	 es 	…である	動詞	\N	\N	\N	946	\N
113	 muy 	とても	副詞	\N	\N	\N	946	\N
496	 grande 	大きい	形容詞	\N	\N	\N	946	\N
138	 Qué 	どの	疑問形容詞	\N	\N	\N	947	\N
497	 países 	国	名詞	\N	\N	\N	947	\N
491	 quieres 	…したい	動詞	\N	\N	\N	947	\N
498	 visitar 	訪ねる	動詞	\N	\N	\N	947	\N
499	 en primer lugar 	まず	前置詞＋形容詞＋名詞	\N	\N	\N	947	\N
404	 Pues 	そうねえ	接続詞	\N	\N	\N	948	\N
500	 por ejemplo 	例えば	前置詞＋名詞	\N	\N	\N	948	\N
491	 quiero 	…したい	動詞	\N	\N	\N	948	\N
130	 ir 	行く	動詞	\N	\N	\N	948	\N
131	 a 	…へ	前置詞	\N	\N	\N	948	\N
501	 Japón 	日本	固有名詞	\N	\N	\N	948	\N
502	 Corea 	韓国	固有名詞	\N	\N	\N	948	\N
503	 China 	中国	固有名詞	\N	\N	\N	948	\N
46	 Te 	君に	代名詞	\N	\N	\N	949	\N
359	 interesa 	(…にとって)興味がある	動詞	\N	\N	\N	949	\N
13	 la 		冠詞	\N	\N	\N	949	\N
504	 cultura 	文化	名詞	\N	\N	\N	949	\N
124	 de 	…の	前置詞	\N	\N	\N	949	\N
505	 esos 	それらの	形容詞	\N	\N	\N	949	\N
497	 países 	国	名詞	\N	\N	\N	949	\N
107	 Sí 	はい	副詞	\N	\N	\N	950	\N
117	 me 	私に	代名詞	\N	\N	\N	950	\N
359	 interesa 	(…にとって)興味がある	動詞	\N	\N	\N	950	\N
315	 mucho 	とても	副詞	\N	\N	\N	950	\N
227	 Pero 	でも	接続詞	\N	\N	\N	951	\N
172	 están 	…にある	動詞	\N	\N	\N	951	\N
113	 muy 	とても	副詞	\N	\N	\N	951	\N
506	 lejos 	遠くに	副詞	\N	\N	\N	951	\N
121	 ¿no?	でしょ？	副詞	\N	\N	\N	951	\N
312	 Eso 	そのこと	代名詞	\N	\N	\N	952	\N
121	 no 	…ない	副詞	\N	\N	\N	952	\N
117	 me 	私に	代名詞	\N	\N	\N	952	\N
268	 importa 	重要である	動詞	\N	\N	\N	952	\N
507	 Camarera 	ウェイトレス	名詞	\N	\N	\N	953	\N
108	 por favor 	すみません、お願いします	前置詞＋名詞	\N	\N	\N	953	\N
107	 Sí 	はい	副詞	\N	\N	\N	954	\N
508	 Dígame 	何でしょうか	動詞＋代名詞	\N	\N	\N	955	\N
148	 El 		冠詞	\N	\N	\N	956	\N
509	 menú 	メニュー	名詞	\N	\N	\N	956	\N
62	 del 	…の	前置詞＋冠詞	\N	\N	\N	956	\N
156	 día 	日	名詞	\N	\N	\N	956	\N
108	 por favor 	お願いします	前置詞＋名詞	\N	\N	\N	956	\N
510	 Lo siento 	申し訳ありません	代名詞＋動詞	\N	\N	\N	957	\N
227	 pero 	…だが	接続詞	\N	\N	\N	957	\N
467	 ya 	もう、すでに	副詞	\N	\N	\N	957	\N
511	 se ha acabado	終わる	動詞	\N	\N	\N	957	\N
256	 Con 	…なのに	前置詞	\N	\N	\N	958	\N
148	 el 		冠詞	\N	\N	\N	958	\N
512	 hambre 	空腹	名詞	\N	\N	\N	958	\N
254	 que 	…するところの	関係代名詞	\N	\N	\N	958	\N
513	 tengo 	持っている	動詞	\N	\N	\N	958	\N
353	 Entonces 	じゃあ、それなら	副詞	\N	\N	\N	959	\N
514	 Sólo 	ただ…だけ	副詞	\N	\N	\N	960	\N
515	 nos 	私たちに	代名詞	\N	\N	\N	960	\N
407	 quedan 	残っている	動詞	\N	\N	\N	960	\N
119	 estos 	これらの	形容詞	\N	\N	\N	960	\N
516	 bocadillos 	ボカディージョ	名詞	\N	\N	\N	960	\N
114	 Bueno 	では	間投詞	\N	\N	\N	961	\N
517	 Me arreglo 	(arreglarse conで)…で我慢する、間に合わせる	動詞	\N	\N	\N	962	\N
256	 con 	…で	前置詞	\N	\N	\N	962	\N
106	 uno 	一つ	代名詞	\N	\N	\N	962	\N
124	 de 	…の(うちの)	前置詞	\N	\N	\N	962	\N
518	ellos	それら	代名詞	\N	\N	\N	962	\N
201	 Le 	あなたに	代名詞	\N	\N	\N	963	\N
519	 recomiendo 	薦める	動詞	\N	\N	\N	963	\N
520	 éste 	これ	代名詞	\N	\N	\N	963	\N
124	 de 	…の	前置詞	\N	\N	\N	963	\N
521	 jamón 	ハム	名詞	\N	\N	\N	963	\N
269	 y 	…と	接続詞	\N	\N	\N	963	\N
522	 queso 	チーズ	名詞	\N	\N	\N	963	\N
172	 Está 	…である	動詞	\N	\N	\N	964	\N
113	 muy 	とても	副詞	\N	\N	\N	964	\N
143	 bueno 	おいしい	形容詞	\N	\N	\N	964	\N
380	 Vale 	よし、了解	動詞	\N	\N	\N	965	\N
523	 Deme 	私に与える	動詞＋代名詞	\N	\N	\N	966	\N
524	ése	それ	代名詞	\N	\N	\N	966	\N
525	 De acuerdo 	かしこまりました	前置詞＋名詞	\N	\N	\N	967	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	968	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	969	\N
160	 Quisiera 	…したい	動詞	\N	\N	\N	970	\N
319	 comprar 	買う	動詞	\N	\N	\N	970	\N
13	 la 		冠詞	\N	\N	\N	970	\N
526	 camisa 	ユニフォーム	名詞	\N	\N	\N	970	\N
58	del	…の	前置詞＋冠詞	\N	\N	\N	970	\N
527	 Real Madrid 	レアル・マドリッド	固有名詞	\N	\N	\N	970	\N
238	 Casa 	ホーム	名詞	\N	\N	\N	971	\N
162	o	それとも	接続詞	\N	\N	\N	971	\N
528	 visitante 	アウェー	名詞	\N	\N	\N	971	\N
238	 Casa 	ホーム	名詞	\N	\N	\N	972	\N
239	 Cuál 	どれ	疑問代名詞	\N	\N	\N	973	\N
66	es	…である	動詞	\N	\N	\N	973	\N
68	su	あなたの	形容詞	\N	\N	\N	973	\N
338	 talla 	サイズ	名詞	\N	\N	\N	973	\N
529	 Treinta y cinco 	35の	形容詞	\N	\N	\N	974	\N
404	 Pues 	ええと	接続詞	\N	\N	\N	975	\N
41	en	…で	前置詞	\N	\N	\N	975	\N
189	esta	この	形容詞	\N	\N	\N	975	\N
338	 talla 	サイズ	名詞	\N	\N	\N	975	\N
530	la	それを	代名詞	\N	\N	\N	975	\N
32	tenemos	持っている	動詞	\N	\N	\N	975	\N
231	 Puedo 	…できる	動詞	\N	\N	\N	976	\N
531	 probármela 	それを私が試着する	動詞＋代名詞＋代名詞	\N	\N	\N	976	\N
23	Sí	はい	副詞	\N	\N	\N	977	\N
449	 por supuesto 	もちろん	前置詞＋形容詞	\N	\N	\N	977	\N
13	el		冠詞	\N	\N	\N	978	\N
532	 probador 	試着室	名詞	\N	\N	\N	978	\N
40	está	…である	動詞	\N	\N	\N	978	\N
533	 al 	…に	前置詞＋冠詞	\N	\N	\N	978	\N
534	 fondo 	奥	名詞	\N	\N	\N	978	\N
9	Gracias	ありがとう	間投詞	\N	\N	\N	979	\N
535	 Oiga 	すいません	動詞	\N	\N	\N	980	\N
160	 quiero	…したい	動詞	\N	\N	\N	981	\N
12	ir	行く	動詞	\N	\N	\N	981	\N
533	 al 	…に	前置詞＋冠詞	\N	\N	\N	981	\N
536	 museo 	美術館	名詞	\N	\N	\N	981	\N
537	 moderno 	現代の	形容詞	\N	\N	\N	981	\N
538	 Allí 	あそこに	副詞	\N	\N	\N	982	\N
12	va	行く	動詞	\N	\N	\N	982	\N
13	el		冠詞	\N	\N	\N	982	\N
539	autobús	バス	名詞	\N	\N	\N	982	\N
39	No	いいえ	副詞	\N	\N	\N	983	\N
13	El		冠詞	\N	\N	\N	984	\N
240	 número 	番号	名詞	\N	\N	\N	984	\N
540	 seis 	6	名詞	\N	\N	\N	984	\N
12	va	行く	動詞	\N	\N	\N	984	\N
538	 allí 	あそこに	副詞	\N	\N	\N	984	\N
541	por eso	それゆえに	前置詞＋代名詞	\N	\N	\N	984	\N
542	 Tengo que 	…しなければならない	 動詞＋接続詞	\N	\N	\N	985	\N
383	 cambiar 	変える	 動詞	\N	\N	\N	985	\N
13	la		冠詞	\N	\N	\N	985	\N
543	 línea 	線	名詞	\N	\N	\N	985	\N
23	Sí	はい	副詞	\N	\N	\N	986	\N
542	 Tienes que 	…しなければならない	 動詞＋接続詞	\N	\N	\N	987	\N
383	 cambiar 	変える	動詞 	\N	\N	\N	987	\N
41	en	…で	前置詞	\N	\N	\N	987	\N
13	la		冠詞	\N	\N	\N	987	\N
544	 Plaza Mayor	マヨール広場	固有名詞	\N	\N	\N	987	\N
5	Y	そして	接続詞	\N	\N	\N	988	\N
218	 después 	あとで	副詞	\N	\N	\N	988	\N
58	del	…の	前置詞＋冠詞	\N	\N	\N	988	\N
536	 museo 	美術館	名詞	\N	\N	\N	988	\N
187	voy a	…するつもりである	動詞＋前置詞	\N	\N	\N	988	\N
12	ir	行く	動詞	\N	\N	\N	988	\N
10	a	…に	前置詞	\N	\N	\N	988	\N
13	la		冠詞	\N	\N	\N	988	\N
408	 estación 	駅	名詞	\N	\N	\N	988	\N
545	 Sur 	南の	形容詞	\N	\N	\N	988	\N
408	 Estación 	駅	名詞	\N	\N	\N	989	\N
545	 Sur 	南の	形容詞	\N	\N	\N	989	\N
546	 mejor que 	…したほうがよい	形容詞＋接続詞	\N	\N	\N	989	\N
12	vaya	行く	動詞	\N	\N	\N	989	\N
547	a pie	徒歩で	前置詞＋名詞	\N	\N	\N	989	\N
40	Está	ある	動詞	\N	\N	\N	990	\N
297	cerca	近くに	副詞	\N	\N	\N	990	\N
23	Sí	はい	副詞	\N	\N	\N	991	\N
40	Está	ある	動詞	\N	\N	\N	992	\N
8	muy	とても	副詞	\N	\N	\N	992	\N
297	cerca	近くに	副詞	\N	\N	\N	992	\N
247	 Vale 	わかりました	動詞	\N	\N	\N	993	\N
9	Gracias	ありがとう	間投詞	\N	\N	\N	994	\N
42	Aquí	ここ	副詞	\N	\N	\N	995	\N
102	viene	来る	動詞	\N	\N	\N	995	\N
13	el		冠詞	\N	\N	\N	995	\N
548	 autobús 	バス	名詞	\N	\N	\N	995	\N
488	Oiga	すいません	動詞	\N	\N	\N	996	\N
231	 Puede 	…できる	動詞	\N	\N	\N	997	\N
236	usted	あなた	代名詞	\N	\N	\N	997	\N
549	 sacar 	撮る	動詞	\N	\N	\N	997	\N
33	una		冠詞	\N	\N	\N	997	\N
550	 foto 	写真	名詞	\N	\N	\N	997	\N
39	no	いいえ	副詞	\N	\N	\N	998	\N
262	 se 		再帰代名詞	\N	\N	\N	999	\N
551	prohíbe	禁止する	動詞	\N	\N	\N	999	\N
188	hacer	作る	動詞	\N	\N	\N	999	\N
550	 fotos 	写真	名詞	\N	\N	\N	999	\N
552	Así	そのように	副詞	\N	\N	\N	1000	\N
228	 Por qué 	なぜ	前置詞＋疑問代名詞	\N	\N	\N	1001	\N
42	Aquí	ここ	副詞	\N	\N	\N	1002	\N
53	hay	ある	動詞	\N	\N	\N	1002	\N
33	una		冠詞	\N	\N	\N	1002	\N
553	 base 	基地	名詞	\N	\N	\N	1002	\N
554	 militar 	軍の	形容詞	\N	\N	\N	1002	\N
22	Ah	ああ	間投詞	\N	\N	\N	1003	\N
247	 Vale 	わかりました	動詞	\N	\N	\N	1003	\N
227	 Pero 	しかし	接続詞	\N	\N	\N	1004	\N
16	qué	なんという	疑問副詞	\N	\N	\N	1004	\N
555	 bonito 	きれいな	形容詞	\N	\N	\N	1004	\N
66	es	…である	動詞	\N	\N	\N	1004	\N
189	este	この	指示形容詞	\N	\N	\N	1004	\N
556	paisaje	景色	名詞	\N	\N	\N	1004	\N
39	no	…でない	副詞	\N	\N	\N	1004	\N
23	Sí	ええ	副詞	\N	\N	\N	1005	\N
66	es	…である	動詞	\N	\N	\N	1006	\N
557	 verdad 	真実	名詞	\N	\N	\N	1006	\N
5	Y	そして	接続詞	\N	\N	\N	1007	\N
111	 sabe 	知っている	動詞	\N	\N	\N	1007	\N
236	usted	あなた	代名詞	\N	\N	\N	1007	\N
221	 cómo 	どのように	疑問副詞	\N	\N	\N	1007	\N
262	 se 		再帰代名詞	\N	\N	\N	1007	\N
12	va	行く	動詞	\N	\N	\N	1007	\N
10	a	…に	前置詞	\N	\N	\N	1007	\N
13	la		冠詞	\N	\N	\N	1007	\N
558	 parada 	停留所	名詞	\N	\N	\N	1007	\N
20	de	…の	前置詞	\N	\N	\N	1007	\N
548	 autobús 	バス	名詞	\N	\N	\N	1007	\N
303	 siga 	道をすすむ	動詞	\N	\N	\N	1008	\N
304	 todo 	全部の	形容詞	\N	\N	\N	1008	\N
305	 recto 	まっすぐに	副詞	\N	\N	\N	1008	\N
559	Muchas gracias	どうもありがとう	間投詞	\N	\N	\N	1009	\N
150	 Adiós 	さようなら	間投詞	\N	\N	\N	1010	\N
150	 Adiós 	さようなら	間投詞	\N	\N	\N	1011	\N
560	 Buen viaje 	よい旅を	形容詞＋名詞	\N	\N	\N	1012	\N
71	 Perdone 	すみません	動詞	\N	\N	\N	1013	\N
395	 Por 	…を通って	前置詞	\N	\N	\N	1014	\N
109	 aquí 	ここ	副詞	\N	\N	\N	1014	\N
262	 se 	人は…(非人称表現)	代名詞	\N	\N	\N	1014	\N
561	 entra 	入る	動詞	\N	\N	\N	1014	\N
259	 en 	…(の中)に	前置詞	\N	\N	\N	1014	\N
148	 el 		冠詞	\N	\N	\N	1014	\N
536	 museo 	美術館	名詞	\N	\N	\N	1014	\N
562	 Exactamente 	その通りです	副詞	\N	\N	\N	1015	\N
53	 Hay 	ある	動詞	\N	\N	\N	1016	\N
563	 control 	検査	名詞	\N	\N	\N	1016	\N
124	 de 	…の	前置詞	\N	\N	\N	1016	\N
564	 objetos 	物	名詞	\N	\N	\N	1016	\N
565	 personales 	個人の	形容詞	\N	\N	\N	1016	\N
107	 Sí 	はい	副詞	\N	\N	\N	1017	\N
286	 Ponga 	置いてください	動詞	\N	\N	\N	1018	\N
566	 los 		冠詞	\N	\N	\N	1018	\N
567	 suyos 	あなたのもの	所有形容詞	\N	\N	\N	1018	\N
259	 en 	…(の中)に	前置詞	\N	\N	\N	1018	\N
568	 esta 	この	指示形容詞	\N	\N	\N	1018	\N
569	 caja 	箱	名詞	\N	\N	\N	1018	\N
525	 De acuerdo 	分かりました	前置詞＋名詞	\N	\N	\N	1019	\N
570	 Así 	これで	副詞	\N	\N	\N	1020	\N
172	 está 	…である	動詞	\N	\N	\N	1020	\N
136	 bien 	良く	副詞	\N	\N	\N	1020	\N
409	 Perfecto 	結構です	間投詞	\N	\N	\N	1021	\N
269	 Y 	そして	接続詞	\N	\N	\N	1022	\N
448	 usted 	あなた	代名詞	\N	\N	\N	1022	\N
35	 pase 	通ってください	動詞	\N	\N	\N	1022	\N
395	 por 	…を通って	前置詞	\N	\N	\N	1022	\N
189	esta	この	指示形容詞	\N	\N	\N	1022	\N
571	 puerta 	ゲート、門	名詞	\N	\N	\N	1022	\N
101	 Vale 	分かりました	動詞	\N	\N	\N	1023	\N
572	Espere	お待ちください	動詞	\N	\N	\N	1024	\N
573	 por favor 	お願いします、どうか	前置詞＋名詞	\N	\N	\N	1024	\N
22	 Ah 	ああ	間投詞	\N	\N	\N	1025	\N
574	 perdón 	すみません	名詞	\N	\N	\N	1025	\N
66	 Es 	…である	動詞	\N	\N	\N	1026	\N
395	 por 	…のせいで	前置詞	\N	\N	\N	1026	\N
119	 este 	この	指示形容詞	\N	\N	\N	1026	\N
575	 llavero 	キーホルダー	名詞	\N	\N	\N	1026	\N
117	 Me 	私自身から	再帰代名詞	\N	\N	\N	1027	\N
145	 lo 	それを	代名詞	\N	\N	\N	1027	\N
576	 quito 	はずす	動詞	\N	\N	\N	1027	\N
210	 Tome 	はいどうぞ	動詞	\N	\N	\N	1028	\N
577	 Ahora 	今度は	副詞	\N	\N	\N	1029	\N
172	 está 	…である	動詞	\N	\N	\N	1029	\N
136	 bien 	良く	副詞	\N	\N	\N	1029	\N
387	 Gracias 	ありがとう	名詞	\N	\N	\N	1030	\N
395	 por 	…のために	前置詞	\N	\N	\N	1030	\N
68	su	あなたの	所有形容詞	\N	\N	\N	1030	\N
578	 colaboración 	協力	名詞	\N	\N	\N	1030	\N
344	 Hola 	こんにちは	間投詞	\N	\N	\N	1031	\N
138	 Qué 	何が	疑問代名詞	\N	\N	\N	1032	\N
201	 le 	あなたに	代名詞	\N	\N	\N	1032	\N
35	 ha pasado 	起こった	動詞	\N	\N	\N	1032	\N
51	 Me		再帰代名詞	\N	\N	\N	1033	\N
579	 caí 	転ぶ	動詞	\N	\N	\N	1033	\N
269	 y 	そして	接続詞	\N	\N	\N	1033	\N
580	 me 		再帰代名詞	\N	\N	\N	1033	\N
581	 torcí 	くじく	動詞	\N	\N	\N	1033	\N
257	 la 		冠詞	\N	\N	\N	1033	\N
582	 muñeca 	手首	名詞	\N	\N	\N	1033	\N
583	 A ver 	どれどれ	前置詞＋動詞	\N	\N	\N	1034	\N
201	 Le 	あなたに(とって)	代名詞	\N	\N	\N	1035	\N
584	 duele 	痛む	動詞	\N	\N	\N	1035	\N
585	 Ay 	あいたっ！	間投詞	\N	\N	\N	1036	\N
108	 Por favor 	お願いします、どうか	前置詞＋名詞	\N	\N	\N	1037	\N
121	 no 	…ない	副詞	\N	\N	\N	1037	\N
117	 me 	私に(対して)	代名詞	\N	\N	\N	1037	\N
257	 la 	それ(la muñeca)を	代名詞	\N	\N	\N	1037	\N
586	 toque 	触る	動詞	\N	\N	\N	1037	\N
587	 tan 	そんなに	副詞	\N	\N	\N	1037	\N
588	 fuerte 	強く	副詞	\N	\N	\N	1037	\N
117	 Me 	私に(とって)	代名詞	\N	\N	\N	1038	\N
584	 duele 	痛む	動詞	\N	\N	\N	1038	\N
315	 mucho 	とても	副詞	\N	\N	\N	1038	\N
121	 No 	…ない	副詞	\N	\N	\N	1039	\N
172	 está 	…である	動詞	\N	\N	\N	1039	\N
589	 rota 	折れた	形容詞	\N	\N	\N	1039	\N
227	 pero 	しかし	接続詞	\N	\N	\N	1039	\N
590	 bastante 	かなり	副詞	\N	\N	\N	1039	\N
591	 hinchada 	腫れた	形容詞	\N	\N	\N	1039	\N
592	 Tardará 	(時間が)かかる	動詞	\N	\N	\N	1040	\N
315	 mucho 	たくさん	副詞	\N	\N	\N	1040	\N
259	 en 	(tardar enで)…するのに(時間が)かかる	動詞	\N	\N	\N	1040	\N
593	 curarse 	治る	動詞＋再帰代名詞	\N	\N	\N	1040	\N
592	 Tardará 	(時間が)かかるだろう	動詞	\N	\N	\N	1041	\N
594	 dos 	2つの	形容詞	\N	\N	\N	1041	\N
595	 semanas 	週	名詞	\N	\N	\N	1041	\N
596	 al menos 	少なくとも	前置詞＋冠詞＋副詞	\N	\N	\N	1041	\N
227	 Pero 	しかし	接続詞	\N	\N	\N	1042	\N
597	 voy a 	…する予定である	動詞＋前置詞	\N	\N	\N	1042	\N
598	 jugar 	プレイする	動詞	\N	\N	\N	1042	\N
259	 en 	…で	前置詞	\N	\N	\N	1042	\N
599	 un 	ある	冠詞	\N	\N	\N	1042	\N
600	 partido 	試合	名詞	\N	\N	\N	1042	\N
124	 de 	…の	前置詞	\N	\N	\N	1042	\N
601	 tenis 	テニス	名詞	\N	\N	\N	1042	\N
148	 el 		冠詞	\N	\N	\N	1042	\N
602	 próximo	次の	形容詞	\N	\N	\N	1042	\N
224	 domingo 	日曜日	名詞	\N	\N	\N	1042	\N
603	 Lo siento 	お気の毒です	代名詞＋動詞	\N	\N	\N	1043	\N
227	 pero 	…だが	接続詞	\N	\N	\N	1043	\N
121	 no 	…ない	副詞	\N	\N	\N	1043	\N
139	 hacer 	する	動詞	\N	\N	\N	1043	\N
604	 deporte 	スポーツ	名詞	\N	\N	\N	1043	\N
605	 una 	一つの	形容詞	\N	\N	\N	1043	\N
125	 semana 	週	名詞	\N	\N	\N	1043	\N
138	 Qué 	何と	副詞	\N	\N	\N	1044	\N
606	 mala 	悪い	形容詞	\N	\N	\N	1044	\N
607	 suerte 	運	名詞	\N	\N	\N	1044	\N
386	 Podría 	…してくださいますか	動詞	\N	\N	\N	1045	\N
608	 recomendarme 	私に推薦する	動詞＋代名詞	\N	\N	\N	1045	\N
609	algún	何らかの	形容詞	\N	\N	\N	1045	\N
610	 diccionario 	辞典	名詞	\N	\N	\N	1045	\N
611	 francés	フランス語	名詞	\N	\N	\N	1045	\N
612	 español 	スペイン語	名詞	\N	\N	\N	1045	\N
486	 Cómo no 	もちろん	疑問副詞＋副詞	\N	\N	\N	1046	\N
500	 Por ejemplo 	例えば	前置詞＋名詞	\N	\N	\N	1047	\N
520	 éste 	これ	代名詞	\N	\N	\N	1047	\N
66	 Es 	…である	動詞	\N	\N	\N	1048	\N
113	 muy 	とても	副詞	\N	\N	\N	1048	\N
613	 ilustrativo 	明解な	形容詞	\N	\N	\N	1048	\N
332	 Parece 	…と思われる	動詞	\N	\N	\N	1049	\N
254	 que 	…ということ	接続詞	\N	\N	\N	1049	\N
490	 muchos 	たくさんの	形容詞	\N	\N	\N	1049	\N
614	 ejemplos 	例	名詞	\N	\N	\N	1049	\N
107	 Sí 	はい	副詞	\N	\N	\N	1050	\N
452	 Si 	もし…なら	接続詞	\N	\N	\N	1051	\N
45	 quieres 	望む	動詞	\N	\N	\N	1051	\N
267	 te 	君に	代名詞	\N	\N	\N	1051	\N
145	 lo 	それを	代名詞	\N	\N	\N	1051	\N
615	 dejo 	貸す	動詞	\N	\N	\N	1051	\N
48	 Muchas 	たくさんの	形容詞	\N	\N	\N	1052	\N
616	 gracias 	ありがとう	名詞	\N	\N	\N	1052	\N
617	 Tengo que 	…しなければならない	動詞＋接続詞	\N	\N	\N	1053	\N
215	 devolvérselo 	あなたにそれを返す	動詞＋代名詞＋代名詞	\N	\N	\N	1053	\N
618	 hoy 	今日	副詞	\N	\N	\N	1053	\N
121	 no 	…ない	副詞	\N	\N	\N	1054	\N
617	 tienes que 	(否定文で)…する必要はない	動詞＋接続詞	\N	\N	\N	1054	\N
215	 darte prisa 	急ぐ	動詞＋代名詞＋名詞	\N	\N	\N	1054	\N
32	 Tengo 	持っている	動詞	\N	\N	\N	1055	\N
343	 otro 	別のもの	代名詞	\N	\N	\N	1055	\N
619	 igual 	同じ	形容詞	\N	\N	\N	1055	\N
259	 en 	…(の中)に	前置詞	\N	\N	\N	1055	\N
238	 casa 	家	名詞	\N	\N	\N	1055	\N
353	 Entonces 	それでは	副詞	\N	\N	\N	1056	\N
620	se lo	あなたにそれを	代名詞	\N	\N	\N	1056	\N
621	 devuelvo 	返す	動詞	\N	\N	\N	1056	\N
259	 en 	…(の中)で	前置詞	\N	\N	\N	1056	\N
148	 la 		冠詞	\N	\N	\N	1056	\N
374	 próxima 	次の	形容詞	\N	\N	\N	1056	\N
354	 clase 	授業	名詞	\N	\N	\N	1056	\N
622	 Cuando 	…する時	接続詞	\N	\N	\N	1057	\N
45	 quieras 	(君が)望む	動詞	\N	\N	\N	1057	\N
48	 Muchas 	たくさんの	形容詞	\N	\N	\N	1058	\N
387	 gracias 	ありがとう	名詞	\N	\N	\N	1058	\N
151	 Hasta 	…まで	前置詞	\N	\N	\N	1059	\N
148	 la 		冠詞	\N	\N	\N	1059	\N
125	 semana 	週	名詞	\N	\N	\N	1059	\N
254	 que 	…するところの	関係代名詞	\N	\N	\N	1059	\N
411	 viene 	来る	動詞	\N	\N	\N	1059	\N
150	 Adiós 	さようなら	間投詞	\N	\N	\N	1060	\N
138	 Qué 	何が	疑問代名詞	\N	\N	\N	1061	\N
267	 te 	君に	代名詞	\N	\N	\N	1061	\N
474	 pasa 	起こる	動詞	\N	\N	\N	1061	\N
172	 Estás 	…である	動詞	\N	\N	\N	1062	\N
113	 muy 	とても	副詞	\N	\N	\N	1062	\N
623	 guapa 	きれいな	形容詞	\N	\N	\N	1062	\N
36	 Es que 	実は…である	動詞＋接続詞	\N	\N	\N	1063	\N
618	 hoy 	今日	副詞	\N	\N	\N	1063	\N
66	 es 	…である	動詞	\N	\N	\N	1063	\N
406	 mi 	私の	所有形容詞	\N	\N	\N	1063	\N
624	 cumpleaños 	誕生日	名詞	\N	\N	\N	1063	\N
625	Verdad	本当	名詞	\N	\N	\N	1064	\N
626	 Feliz 	幸せな	形容詞	\N	\N	\N	1065	\N
624	 cumpleaños 	誕生日	名詞	\N	\N	\N	1065	\N
48	 Muchas 	たくさんの	形容詞	\N	\N	\N	1066	\N
616	 gracias 	ありがとう	名詞	\N	\N	\N	1066	\N
187	 Vas a 	…する予定である	動詞＋前置詞	\N	\N	\N	1067	\N
139	 hacer 	する	動詞	\N	\N	\N	1067	\N
627	 una 	一つの	形容詞	\N	\N	\N	1067	\N
458	 fiesta 	パーティー	名詞	\N	\N	\N	1067	\N
628	 Claro que sí 	もちろん	形容詞＋接続詞＋副詞	\N	\N	\N	1068	\N
629	 Por qué no 	…しない？	前置詞＋疑問代名詞＋副詞	\N	\N	\N	1069	\N
411	 vienes 	来る	動詞	\N	\N	\N	1069	\N
40	 Estás 	…である	動詞	\N	\N	\N	1070	\N
630	 invitado 	招待されている	形容詞	\N	\N	\N	1070	\N
256	 Con 	…とともに	前置詞	\N	\N	\N	1071	\N
315	 mucho 	たくさんの	形容詞	\N	\N	\N	1071	\N
631	 gusto 	喜び	名詞	\N	\N	\N	1071	\N
387	 Gracias 	ありがとう	名詞	\N	\N	\N	1072	\N
353	 Entonces 	それでは	副詞	\N	\N	\N	1073	\N
102	ven	来なさい	動詞	\N	\N	\N	1073	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	1073	\N
406	 mi 	私の	所有形容詞	\N	\N	\N	1073	\N
238	 casa 	家	名詞	\N	\N	\N	1073	\N
370	 las 		冠詞	\N	\N	\N	1073	\N
436	 siete 	7の	形容詞	\N	\N	\N	1073	\N
247	 Vale 	分かった	動詞	\N	\N	\N	1074	\N
632	 Hasta luego 	じゃあまた	前置詞＋副詞	\N	\N	\N	1075	\N
138	 Qué 	何が	疑問代名詞	\N	\N	\N	1076	\N
267	 te 	君に	代名詞	\N	\N	\N	1076	\N
474	 pasa 	起こる	動詞	\N	\N	\N	1076	\N
51	 Te		再帰代名詞	\N	\N	\N	1077	\N
633	 encuentras 	(再帰代名詞とともに)…の状態である	動詞	\N	\N	\N	1077	\N
634	 mal 	具合が悪く	副詞	\N	\N	\N	1077	\N
32	 Tengo 	持っている	動詞	\N	\N	\N	1078	\N
635	 escalofríos 	寒気	名詞	\N	\N	\N	1078	\N
636	 A ver si 	どれどれ…かな	前置詞＋動詞＋接続詞	\N	\N	\N	1079	\N
513	 tienes 	持っている	動詞	\N	\N	\N	1079	\N
205	 fiebre 	熱	名詞	\N	\N	\N	1079	\N
107	 Sí 	うん	副詞	\N	\N	\N	1080	\N
513	 tienes 	持っている	動詞	\N	\N	\N	1080	\N
205	 fiebre 	熱	名詞	\N	\N	\N	1080	\N
637	 Además 	それに、その上	副詞	\N	\N	\N	1081	\N
117	 me 	私に	代名詞	\N	\N	\N	1081	\N
584	 duele 	痛む	動詞	\N	\N	\N	1081	\N
315	 mucho 	とても	副詞	\N	\N	\N	1081	\N
257	 la 		冠詞	\N	\N	\N	1081	\N
638	 cabeza 	頭	名詞	\N	\N	\N	1081	\N
639	 Seguro que 	きっと	形容詞＋接続詞	\N	\N	\N	1082	\N
640	 has cogido 	(風邪などに)かかる	動詞	\N	\N	\N	1082	\N
148	 la 		冠詞	\N	\N	\N	1082	\N
641	 gripe 	インフルエンザ	名詞	\N	\N	\N	1082	\N
121	 No 	…ない	副詞	\N	\N	\N	1083	\N
642	 tengo ganas de 	(不定詞とともに)(私は)…したい	動詞＋名詞＋前置詞	\N	\N	\N	1083	\N
130	 ir 	行く	動詞	\N	\N	\N	1083	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	1083	\N
354	 clase 	授業	名詞	\N	\N	\N	1083	\N
66	 Es 	…である	動詞	\N	\N	\N	1084	\N
334	 mejor 	より良い	形容詞	\N	\N	\N	1084	\N
254	 que 	ということ	接続詞	\N	\N	\N	1084	\N
12	 vayas 	行く	動詞	\N	\N	\N	1084	\N
533	 al 	…に、…へ	前置詞＋冠詞	\N	\N	\N	1084	\N
643	 médico 	医者	名詞	\N	\N	\N	1084	\N
32	 Tienes 	(君は)持っている	動詞	\N	\N	\N	1085	\N
644	 razón 	正当性、道理	名詞	\N	\N	\N	1085	\N
46	 Te 	君に(とって)	代名詞	\N	\N	\N	1086	\N
268	 importa 	迷惑である	動詞	\N	\N	\N	1086	\N
645	 decir 	言う	動詞	\N	\N	\N	1086	\N
646	 al 	…に	前置詞＋冠詞	\N	\N	\N	1086	\N
398	 profesor 	先生	名詞	\N	\N	\N	1086	\N
254	 que 	…ということ	接続詞	\N	\N	\N	1086	\N
121	 no 	…ない	副詞	\N	\N	\N	1086	\N
130	 ir 	行く	動詞	\N	\N	\N	1086	\N
131	 a 	…に、…へ	前置詞	\N	\N	\N	1086	\N
354	 clase 	授業	名詞	\N	\N	\N	1086	\N
121	 no 	…ない	副詞	\N	\N	\N	1087	\N
647	 te 		再帰代名詞	\N	\N	\N	1087	\N
648	 preocupes 	(再帰代名詞とともに）心配する	動詞＋再帰代名詞	\N	\N	\N	1087	\N
262	 Se 	彼に	代名詞	\N	\N	\N	1088	\N
145	 lo 	そのことを	代名詞	\N	\N	\N	1088	\N
649	 diré 	言う	動詞	\N	\N	\N	1088	\N
387	 Gracias 	ありがとう	名詞	\N	\N	\N	1089	\N
117	 Me 	私自身に	再帰代名詞	\N	\N	\N	1090	\N
650	 llevo 	持って行く	動詞	\N	\N	\N	1090	\N
189	esta	この	指示形容詞	\N	\N	\N	1090	\N
651	 corbata 	ネクタイ	名詞	\N	\N	\N	1090	\N
164	Cuánto	いくら	疑問代名詞	\N	\N	\N	1091	\N
165	cuesta	（費用が）かかる	動詞	\N	\N	\N	1091	\N
652	 venticinco 	25の	形容詞	\N	\N	\N	1092	\N
420	 euros 	ユーロ	名詞	\N	\N	\N	1092	\N
247	 Vale 	わかりました	動詞	\N	\N	\N	1093	\N
200	 Envuélvala 	それを包んでください	動詞＋代名詞	\N	\N	\N	1094	\N
15	para	…のために	前置詞	\N	\N	\N	1094	\N
653	 regalo 	プレゼント	名詞	\N	\N	\N	1094	\N
246	 por favor 	どうぞ	前置詞＋動詞	\N	\N	\N	1094	\N
23	Sí	はい	副詞	\N	\N	\N	1095	\N
654	 señor 		名詞	\N	\N	\N	1095	\N
231	 Puedo 	…できる	動詞	\N	\N	\N	1096	\N
655	 pagar 	支払う	動詞	\N	\N	\N	1096	\N
28	con	…で	前置詞	\N	\N	\N	1096	\N
656	 tarjeta 	カード	名詞	\N	\N	\N	1096	\N
20	de	…の	前置詞	\N	\N	\N	1096	\N
657	 crédito 	信用	名詞	\N	\N	\N	1096	\N
23	Sí	はい	副詞	\N	\N	\N	1097	\N
658	 Aquí tiene 	はい、どうぞ	副詞＋動詞	\N	\N	\N	1098	\N
659	 Muy bien 	はい	副詞＋副詞	\N	\N	\N	1099	\N
660	Firme	署名してください	動詞	\N	\N	\N	1100	\N
42	aquí	ここ	副詞	\N	\N	\N	1100	\N
246	 por favor 	どうぞ	前置詞＋名詞	\N	\N	\N	1100	\N
525	 De acuerdo 	わかりました	前置詞＋名詞	\N	\N	\N	1101	\N
659	 Muy bien 	はい	副詞＋副詞	\N	\N	\N	1102	\N
559	Muchas gracias	どうもありがとうございます	形容詞＋間投詞	\N	\N	\N	1103	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	1104	\N
1	Hola	こんにちは	間投詞	\N	\N	\N	1105	\N
2	María	マリア	固有名詞	\N	\N	\N	1105	\N
40	Estás	…である	動詞	\N	\N	\N	1106	\N
661	 sola 	一人だけ	形容詞	\N	\N	\N	1106	\N
157	hoy	今日	副詞	\N	\N	\N	1106	\N
23	Sí	はい	副詞	\N	\N	\N	1107	\N
662	 Carmen 	カルメン	固有名詞	\N	\N	\N	1108	\N
40	está	…である	動詞	\N	\N	\N	1108	\N
204	 resfriada 	風邪をひいた	形容詞	\N	\N	\N	1108	\N
22	Ah	ああ	間投詞	\N	\N	\N	1109	\N
16	qué	何	疑問代名詞	\N	\N	\N	1109	\N
160	 quieres 	…したい	動詞	\N	\N	\N	1109	\N
210	tomar	食べる	動詞	\N	\N	\N	1109	\N
16	Qué	何	疑問代名詞	\N	\N	\N	1110	\N
77	me	私に	代名詞	\N	\N	\N	1110	\N
663	 recomiendas 	勧める	動詞	\N	\N	\N	1110	\N
157	Hoy	今日	副詞	\N	\N	\N	1111	\N
32	tenemos	持つ	動詞	\N	\N	\N	1111	\N
664	 calamares 	イカ	名詞	\N	\N	\N	1111	\N
665	 tortilla 	オムレツ	名詞	\N	\N	\N	1111	\N
612	 española 	スペインの	形容詞	\N	\N	\N	1111	\N
33	un		不定冠詞	\N	\N	\N	1112	\N
666	 pincho 	ピンチョ	名詞	\N	\N	\N	1112	\N
20	de	…の	前置詞	\N	\N	\N	1112	\N
665	 tortilla 	オムレツ	名詞	\N	\N	\N	1112	\N
246	 por favor 	どうぞ	前置詞＋名詞	\N	\N	\N	1112	\N
5	Y	そして	接続詞	\N	\N	\N	1113	\N
667	algo	何か	代名詞	\N	\N	\N	1113	\N
244	 más 	もっと	副詞	\N	\N	\N	1113	\N
39	No	いいえ	副詞	\N	\N	\N	1114	\N
22	Ah	ああ	間投詞	\N	\N	\N	1115	\N
227	 pero 	しかし	接続詞	\N	\N	\N	1115	\N
160	 quiero 	…したい	動詞	\N	\N	\N	1115	\N
210	tomar	飲む	動詞	\N	\N	\N	1115	\N
33	un	一つの	不定冠詞	\N	\N	\N	1115	\N
668	 café 	コーヒー	名詞	\N	\N	\N	1115	\N
661	 solo 	（コーヒーが)ブラックの	形容詞	\N	\N	\N	1115	\N
302	 luego 	後で	副詞	\N	\N	\N	1115	\N
33	un	一つの	不定冠詞	\N	\N	\N	1116	\N
668	 café 	コーヒー	名詞	\N	\N	\N	1116	\N
661	 solo 	（コーヒーが)ブラックの	形容詞	\N	\N	\N	1116	\N
659	 Muy bien 	わかりました		\N	\N	\N	1117	\N
427	 Ésta 	これ	代名詞	\N	\N	\N	1118	\N
66	es	…である	動詞	\N	\N	\N	1118	\N
669	 tu	君の	形容詞	\N	\N	\N	1118	\N
670	 familia 	家族	名詞	\N	\N	\N	1118	\N
23	Sí	はい	副詞	\N	\N	\N	1119	\N
189	Esta	この	形容詞	\N	\N	\N	1120	\N
550	 foto 	写真	名詞	\N	\N	\N	1120	\N
530	la	それを	代名詞	\N	\N	\N	1120	\N
210	tomé	撮る	動詞	\N	\N	\N	1120	\N
362	 hace 	･･･前に	動詞	\N	\N	\N	1120	\N
197	dos	2の	形容詞	\N	\N	\N	1120	\N
671	 años 	年	名詞	\N	\N	\N	1120	\N
672	 Quién 	誰	疑問代名詞	\N	\N	\N	1121	\N
66	es	…である	動詞	\N	\N	\N	1121	\N
189	esta	この	指示形容詞	\N	\N	\N	1121	\N
673	 chica 	女の子	名詞	\N	\N	\N	1121	\N
669	 tu	あなたの	形容詞	\N	\N	\N	1121	\N
674	 hermana 	妹	名詞	\N	\N	\N	1121	\N
39	No	いいえ	副詞	\N	\N	\N	1122	\N
66	Es	…である	動詞	\N	\N	\N	1123	\N
134	mi	私の	形容詞	\N	\N	\N	1123	\N
675	 sobrina 	姪	名詞	\N	\N	\N	1123	\N
676	 Pilar 	ピラール	固有名詞	\N	\N	\N	1123	\N
5	Y	そして	接続詞	\N	\N	\N	1124	\N
427	 ésta 	こちら	代名詞	\N	\N	\N	1124	\N
66	es	…である	動詞	\N	\N	\N	1124	\N
134	mi	私の	形容詞	\N	\N	\N	1124	\N
674	 hermana 	妹	名詞	\N	\N	\N	1124	\N
677	 Juana 	フアナ	固有名詞	\N	\N	\N	1124	\N
16	Qué	なんという	疑問副詞	\N	\N	\N	1125	\N
623	 guapa 	美女の	形容詞	\N	\N	\N	1125	\N
678	 estudia 	勉強する	動詞	\N	\N	\N	1126	\N
41	en	…で	前置詞	\N	\N	\N	1126	\N
13	la		冠詞	\N	\N	\N	1126	\N
679	 universidad 	大学	名詞	\N	\N	\N	1126	\N
22	Ah	へぇ	間投詞	\N	\N	\N	1127	\N
5	y	そして	接続詞	\N	\N	\N	1127	\N
138	 qué 	何	疑問代名詞	\N	\N	\N	1127	\N
678	 estudia 	勉強する	動詞	\N	\N	\N	1127	\N
680	 matemáticas 	数学	名詞	\N	\N	\N	1128	\N
77	me	私に	代名詞	\N	\N	\N	1129	\N
118	 gustaría 	気に入る	動詞	\N	\N	\N	1129	\N
200	 conocerla 	彼女と知り合いになる	動詞＋代名詞	\N	\N	\N	1129	\N
233	 Claro 	もちろん	形容詞	\N	\N	\N	1130	\N
267	 Te 	君に	代名詞	\N	\N	\N	1131	\N
530	la	彼女を	代名詞	\N	\N	\N	1131	\N
681	 presentaré 	紹介する	動詞	\N	\N	\N	1131	\N
994		\N		\N	\N	\N	127	\N
994		\N		\N	\N	\N	272	\N
976		\N		\N	\N	\N	468	\N
976		\N		\N	\N	\N	469	\N
1203		\N		\N	\N	\N	288	\N
910		\N		\N	\N	\N	133	\N
848		\N		\N	\N	\N	38	\N
848		\N		\N	\N	\N	128	\N
779		\N		\N	\N	\N	126	\N
932		\N		\N	\N	\N	172	\N
932		\N		\N	\N	\N	173	\N
932		\N		\N	\N	\N	274	\N
789		\N		\N	\N	\N	12	\N
789		\N		\N	\N	\N	982	\N
789		\N		\N	\N	\N	984	\N
809		\N		\N	\N	\N	468	\N
804		\N		\N	\N	\N	207	\N
804		\N		\N	\N	\N	838	\N
1091		\N		\N	\N	\N	116	\N
1091		\N		\N	\N	\N	123	\N
1091		\N		\N	\N	\N	1120	\N
1107		\N		\N	\N	\N	119	\N
1107		\N		\N	\N	\N	439	\N
787		\N		\N	\N	\N	41	\N
787		\N		\N	\N	\N	353	\N
787		\N		\N	\N	\N	1100	\N
1204		\N		\N	\N	\N	661	\N
1204		\N		\N	\N	\N	1098	\N
787		\N		\N	\N	\N	1098	\N
787		\N		\N	\N	\N	614	\N
944		\N		\N	\N	\N	131	\N
944		\N		\N	\N	\N	1000	\N
944		\N		\N	\N	\N	1020	\N
806		\N		\N	\N	\N	44	\N
806		\N		\N	\N	\N	182	\N
806		\N		\N	\N	\N	632	\N
711		\N		\N	\N	\N	45	\N
711		\N		\N	\N	\N	308	\N
711		\N		\N	\N	\N	1007	\N
711		\N		\N	\N	\N	995	\N
684		\N		\N	\N	\N	37	\N
684		\N		\N	\N	\N	39	\N
684		\N		\N	\N	\N	111	\N
684		\N		\N	\N	\N	252	\N
1106		\N		\N	\N	\N	226	\N
1106		\N		\N	\N	\N	363	\N
1106		\N		\N	\N	\N	438	\N
857		\N		\N	\N	\N	669	\N
882		\N		\N	\N	\N	237	\N
882		\N		\N	\N	\N	798	\N
849		\N		\N	\N	\N	22	\N
917		\N		\N	\N	\N	22	\N
742		\N		\N	\N	\N	896	\N
731		\N		\N	\N	\N	74	\N
731		\N		\N	\N	\N	601	\N
731		\N		\N	\N	\N	613	\N
731		\N		\N	\N	\N	769	\N
963		\N		\N	\N	\N	40	\N
963		\N		\N	\N	\N	179	\N
963		\N		\N	\N	\N	298	\N
963		\N		\N	\N	\N	311	\N
963		\N		\N	\N	\N	916	\N
841		\N		\N	\N	\N	684	\N
841		\N		\N	\N	\N	689	\N
968		\N		\N	\N	\N	1004	\N
1138		\N		\N	\N	\N	438	\N
1138		\N		\N	\N	\N	876	\N
700		\N		\N	\N	\N	236	\N
700		\N		\N	\N	\N	336	\N
837		\N		\N	\N	\N	1081	\N
853		\N		\N	\N	\N	178	\N
853		\N		\N	\N	\N	1115	\N
853		\N		\N	\N	\N	1116	\N
775		\N		\N	\N	\N	139	\N
722		\N		\N	\N	\N	970	\N
1126		\N		\N	\N	\N	371	\N
1127		\N		\N	\N	\N	369	\N
1127		\N		\N	\N	\N	371	\N
1036		\N		\N	\N	\N	658	\N
752		\N		\N	\N	\N	118	\N
752		\N		\N	\N	\N	158	\N
744		\N		\N	\N	\N	893	\N
744		\N		\N	\N	\N	894	\N
895		\N		\N	\N	\N	57	\N
895		\N		\N	\N	\N	61	\N
895		\N		\N	\N	\N	332	\N
895		\N		\N	\N	\N	471	\N
914		\N		\N	\N	\N	87	\N
765		\N		\N	\N	\N	22	\N
765		\N		\N	\N	\N	195	\N
765		\N		\N	\N	\N	205	\N
765		\N		\N	\N	\N	1073	\N
765		\N		\N	\N	\N	754	\N
765		\N		\N	\N	\N	1055	\N
766		\N		\N	\N	\N	22	\N
766		\N		\N	\N	\N	195	\N
766		\N		\N	\N	\N	205	\N
766		\N		\N	\N	\N	210	\N
1038		\N		\N	\N	\N	62	\N
1038		\N		\N	\N	\N	206	\N
1045		\N		\N	\N	\N	62	\N
1045		\N		\N	\N	\N	206	\N
792		\N		\N	\N	\N	29	\N
792		\N		\N	\N	\N	275	\N
792		\N		\N	\N	\N	790	\N
792		\N		\N	\N	\N	990	\N
792		\N		\N	\N	\N	992	\N
958		\N		\N	\N	\N	29	\N
958		\N		\N	\N	\N	275	\N
958		\N		\N	\N	\N	790	\N
958		\N		\N	\N	\N	990	\N
958		\N		\N	\N	\N	992	\N
844		\N		\N	\N	\N	310	\N
1174		\N		\N	\N	\N	85	\N
1174		\N		\N	\N	\N	96	\N
1174		\N		\N	\N	\N	191	\N
1171		\N		\N	\N	\N	33	\N
1171		\N		\N	\N	\N	191	\N
1171		\N		\N	\N	\N	313	\N
1129		\N		\N	\N	\N	77	\N
1129		\N		\N	\N	\N	161	\N
1129		\N		\N	\N	\N	839	\N
1129		\N		\N	\N	\N	841	\N
805		\N		\N	\N	\N	191	\N
805		\N		\N	\N	\N	374	\N
817		\N		\N	\N	\N	28	\N
817		\N		\N	\N	\N	78	\N
817		\N		\N	\N	\N	1083	\N
817		\N		\N	\N	\N	466	\N
817		\N		\N	\N	\N	467	\N
817		\N		\N	\N	\N	1056	\N
719		\N		\N	\N	\N	93	\N
719		\N		\N	\N	\N	199	\N
719		\N		\N	\N	\N	746	\N
719		\N		\N	\N	\N	780	\N
719		\N		\N	\N	\N	804	\N
719		\N		\N	\N	\N	806	\N
1182		\N		\N	\N	\N	808	\N
1182		\N		\N	\N	\N	818	\N
872		\N		\N	\N	\N	132	\N
872		\N		\N	\N	\N	142	\N
872		\N		\N	\N	\N	361	\N
872		\N		\N	\N	\N	378	\N
879		\N		\N	\N	\N	113	\N
879		\N		\N	\N	\N	733	\N
1042		\N		\N	\N	\N	113	\N
1042		\N		\N	\N	\N	733	\N
941		\N		\N	\N	\N	24	\N
941		\N		\N	\N	\N	26	\N
941		\N		\N	\N	\N	158	\N
941		\N		\N	\N	\N	737	\N
941		\N		\N	\N	\N	793	\N
941		\N		\N	\N	\N	852	\N
818		\N		\N	\N	\N	905	\N
903		\N		\N	\N	\N	368	\N
903		\N		\N	\N	\N	804	\N
903		\N		\N	\N	\N	897	\N
903		\N		\N	\N	\N	970	\N
828		\N		\N	\N	\N	198	\N
861		\N		\N	\N	\N	655	\N
721		\N		\N	\N	\N	1090	\N
940		\N		\N	\N	\N	157	\N
940		\N		\N	\N	\N	625	\N
940		\N		\N	\N	\N	755	\N
940		\N		\N	\N	\N	973	\N
1120		\N		\N	\N	\N	117	\N
1120		\N		\N	\N	\N	159	\N
1120		\N		\N	\N	\N	618	\N
1120		\N		\N	\N	\N	909	\N
746		\N		\N	\N	\N	1091	\N
746		\N		\N	\N	\N	689	\N
746		\N		\N	\N	\N	898	\N
745		\N		\N	\N	\N	21	\N
745		\N		\N	\N	\N	30	\N
745		\N		\N	\N	\N	123	\N
745		\N		\N	\N	\N	898	\N
884		\N		\N	\N	\N	630	\N
1153		\N		\N	\N	\N	328	\N
1153		\N		\N	\N	\N	367	\N
1153		\N		\N	\N	\N	1086	\N
1153		\N		\N	\N	\N	459	\N
1153		\N		\N	\N	\N	246	\N
1153		\N		\N	\N	\N	934	\N
902		\N		\N	\N	\N	935	\N
708		\N		\N	\N	\N	233	\N
708		\N		\N	\N	\N	1043	\N
799		\N		\N	\N	\N	792	\N
1041		\N		\N	\N	\N	203	\N
702		\N		\N	\N	\N	758	\N
732		\N		\N	\N	\N	11	\N
732		\N		\N	\N	\N	15	\N
732		\N		\N	\N	\N	377	\N
732		\N		\N	\N	\N	1045	\N
881		\N		\N	\N	\N	144	\N
881		\N		\N	\N	\N	160	\N
881		\N		\N	\N	\N	349	\N
960		\N		\N	\N	\N	82	\N
829		\N		\N	\N	\N	1081	\N
829		\N		\N	\N	\N	1035	\N
829		\N		\N	\N	\N	1038	\N
1081		\N		\N	\N	\N	124	\N
1081		\N		\N	\N	\N	199	\N
1081		\N		\N	\N	\N	1042	\N
790		\N		\N	\N	\N	3	\N
790		\N		\N	\N	\N	27	\N
790		\N		\N	\N	\N	29	\N
790		\N		\N	\N	\N	35	\N
790		\N		\N	\N	\N	162	\N
790		\N		\N	\N	\N	600	\N
918		\N		\N	\N	\N	624	\N
918		\N		\N	\N	\N	625	\N
928		\N		\N	\N	\N	102	\N
928		\N		\N	\N	\N	108	\N
928		\N		\N	\N	\N	112	\N
928		\N		\N	\N	\N	282	\N
929		\N		\N	\N	\N	103	\N
929		\N		\N	\N	\N	174	\N
929		\N		\N	\N	\N	251	\N
929		\N		\N	\N	\N	962	\N
1206		\N		\N	\N	\N	102	\N
1206		\N		\N	\N	\N	108	\N
1206		\N		\N	\N	\N	268	\N
1207		\N		\N	\N	\N	103	\N
698		\N		\N	\N	\N	113	\N
698		\N		\N	\N	\N	847	\N
1208		\N		\N	\N	\N	155	\N
1200		\N		\N	\N	\N	66	\N
1200		\N		\N	\N	\N	1073	\N
1200		\N		\N	\N	\N	784	\N
1200		\N		\N	\N	\N	897	\N
1200		\N		\N	\N	\N	912	\N
1200		\N		\N	\N	\N	1056	\N
1154		\N		\N	\N	\N	54	\N
1154		\N		\N	\N	\N	102	\N
1154		\N		\N	\N	\N	57	\N
938		\N		\N	\N	\N	397	\N
938		\N		\N	\N	\N	836	\N
938		\N		\N	\N	\N	96	\N
938		\N		\N	\N	\N	548	\N
938		\N		\N	\N	\N	949	\N
1079		\N		\N	\N	\N	239	\N
845		\N		\N	\N	\N	29	\N
845		\N		\N	\N	\N	275	\N
845		\N		\N	\N	\N	882	\N
845		\N		\N	\N	\N	988	\N
845		\N		\N	\N	\N	989	\N
769		\N		\N	\N	\N	18	\N
1199		\N		\N	\N	\N	598	\N
1199		\N		\N	\N	\N	599	\N
1199		\N		\N	\N	\N	712	\N
1199		\N		\N	\N	\N	739	\N
1199		\N		\N	\N	\N	740	\N
963		\N		\N	\N	\N	76	\N
963		\N		\N	\N	\N	720	\N
1199		\N		\N	\N	\N	922	\N
937		\N		\N	\N	\N	39	\N
937		\N		\N	\N	\N	77	\N
937		\N		\N	\N	\N	150	\N
937		\N		\N	\N	\N	223	\N
937		\N		\N	\N	\N	787	\N
937		\N		\N	\N	\N	81	\N
937		\N		\N	\N	\N	83	\N
937		\N		\N	\N	\N	85	\N
937		\N		\N	\N	\N	100	\N
1093		\N		\N	\N	\N	223	\N
811		\N		\N	\N	\N	1	\N
811		\N		\N	\N	\N	44	\N
811		\N		\N	\N	\N	185	\N
822		\N		\N	\N	\N	81	\N
822		\N		\N	\N	\N	122	\N
822		\N		\N	\N	\N	603	\N
824		\N		\N	\N	\N	328	\N
824		\N		\N	\N	\N	773	\N
909		\N		\N	\N	\N	814	\N
761		\N		\N	\N	\N	1118	\N
1189		\N		\N	\N	\N	80	\N
1189		\N		\N	\N	\N	125	\N
1189		\N		\N	\N	\N	247	\N
1189		\N		\N	\N	\N	1067	\N
1189		\N		\N	\N	\N	915	\N
1135		\N		\N	\N	\N	313	\N
1135		\N		\N	\N	\N	999	\N
1135		\N		\N	\N	\N	997	\N
1135		\N		\N	\N	\N	1120	\N
737		\N		\N	\N	\N	771	\N
738		\N		\N	\N	\N	935	\N
1209		\N		\N	\N	\N	765	\N
1209		\N		\N	\N	\N	769	\N
1209		\N		\N	\N	\N	852	\N
687		\N		\N	\N	\N	1045	\N
1122		\N		\N	\N	\N	79	\N
773		\N		\N	\N	\N	43	\N
1150		\N		\N	\N	\N	133	\N
966		\N		\N	\N	\N	1037	\N
949		\N		\N	\N	\N	196	\N
949		\N		\N	\N	\N	257	\N
839		\N		\N	\N	\N	730	\N
948		\N		\N	\N	\N	195	\N
948		\N		\N	\N	\N	946	\N
699		\N		\N	\N	\N	110	\N
699		\N		\N	\N	\N	111	\N
699		\N		\N	\N	\N	113	\N
699		\N		\N	\N	\N	180	\N
699		\N		\N	\N	\N	337	\N
1159		\N		\N	\N	\N	204	\N
1159		\N		\N	\N	\N	907	\N
1159		\N		\N	\N	\N	34	\N
1159		\N		\N	\N	\N	143	\N
1101		\N		\N	\N	\N	1120	\N
725		\N		\N	\N	\N	77	\N
725		\N		\N	\N	\N	81	\N
725		\N		\N	\N	\N	879	\N
725		\N		\N	\N	\N	930	\N
725		\N		\N	\N	\N	1043	\N
725		\N		\N	\N	\N	364	\N
1140		\N		\N	\N	\N	434	\N
1140		\N		\N	\N	\N	436	\N
1140		\N		\N	\N	\N	438	\N
1140		\N		\N	\N	\N	882	\N
1139		\N		\N	\N	\N	227	\N
1147		\N		\N	\N	\N	227	\N
825		\N		\N	\N	\N	357	\N
1142		\N		\N	\N	\N	133	\N
1142		\N		\N	\N	\N	226	\N
1202		\N		\N	\N	\N	1075	\N
1202		\N		\N	\N	\N	607	\N
1001		\N		\N	\N	\N	111	\N
1001		\N		\N	\N	\N	706	\N
1001		\N		\N	\N	\N	1121	\N
1001		\N		\N	\N	\N	1124	\N
1004		\N		\N	\N	\N	111	\N
1004		\N		\N	\N	\N	706	\N
1000		\N		\N	\N	\N	111	\N
1000		\N		\N	\N	\N	706	\N
992		\N		\N	\N	\N	94	\N
992		\N		\N	\N	\N	95	\N
992		\N		\N	\N	\N	196	\N
1003		\N		\N	\N	\N	94	\N
1003		\N		\N	\N	\N	95	\N
991		\N		\N	\N	\N	94	\N
991		\N		\N	\N	\N	95	\N
1172		\N		\N	\N	\N	164	\N
1173		\N		\N	\N	\N	164	\N
1176		\N		\N	\N	\N	164	\N
1105		\N		\N	\N	\N	28	\N
1105		\N		\N	\N	\N	37	\N
1105		\N		\N	\N	\N	71	\N
1123		\N		\N	\N	\N	68	\N
1123		\N		\N	\N	\N	267	\N
1123		\N		\N	\N	\N	376	\N
1123		\N		\N	\N	\N	647	\N
1123		\N		\N	\N	\N	651	\N
688		\N		\N	\N	\N	790	\N
1103		\N		\N	\N	\N	225	\N
1103		\N		\N	\N	\N	228	\N
1103		\N		\N	\N	\N	713	\N
1103		\N		\N	\N	\N	1053	\N
1103		\N		\N	\N	\N	1106	\N
1156		\N		\N	\N	\N	70	\N
1156		\N		\N	\N	\N	157	\N
1156		\N		\N	\N	\N	179	\N
683		\N		\N	\N	\N	42	\N
683		\N		\N	\N	\N	70	\N
683		\N		\N	\N	\N	336	\N
682		\N		\N	\N	\N	366	\N
682		\N		\N	\N	\N	944	\N
682		\N		\N	\N	\N	981	\N
682		\N		\N	\N	\N	633	\N
682		\N		\N	\N	\N	600	\N
689		\N		\N	\N	\N	34	\N
689		\N		\N	\N	\N	286	\N
950		\N		\N	\N	\N	209	\N
696		\N		\N	\N	\N	67	\N
696		\N		\N	\N	\N	1042	\N
1070		\N		\N	\N	\N	222	\N
977		\N		\N	\N	\N	17	\N
977		\N		\N	\N	\N	799	\N
793		\N		\N	\N	\N	17	\N
793		\N		\N	\N	\N	799	\N
1089		\N		\N	\N	\N	121	\N
1083		\N		\N	\N	\N	1059	\N
856		\N		\N	\N	\N	352	\N
735		\N		\N	\N	\N	127	\N
735		\N		\N	\N	\N	368	\N
953		\N		\N	\N	\N	951	\N
780		\N		\N	\N	\N	126	\N
736		\N		\N	\N	\N	82	\N
736		\N		\N	\N	\N	150	\N
736		\N		\N	\N	\N	613	\N
736		\N		\N	\N	\N	834	\N
760		\N		\N	\N	\N	205	\N
778		\N		\N	\N	\N	638	\N
778		\N		\N	\N	\N	793	\N
756		\N		\N	\N	\N	355	\N
890		\N		\N	\N	\N	370	\N
890		\N		\N	\N	\N	37	\N
890		\N		\N	\N	\N	114	\N
890		\N		\N	\N	\N	647	\N
890		\N		\N	\N	\N	741	\N
890		\N		\N	\N	\N	742	\N
1144		\N		\N	\N	\N	222	\N
1144		\N		\N	\N	\N	284	\N
1144		\N		\N	\N	\N	289	\N
1145		\N		\N	\N	\N	139	\N
1084		\N		\N	\N	\N	681	\N
1084		\N		\N	\N	\N	682	\N
996		\N		\N	\N	\N	206	\N
970		\N		\N	\N	\N	119	\N
970		\N		\N	\N	\N	204	\N
970		\N		\N	\N	\N	225	\N
970		\N		\N	\N	\N	1077	\N
970		\N		\N	\N	\N	770	\N
970		\N		\N	\N	\N	879	\N
703		\N		\N	\N	\N	67	\N
403		\N		\N	\N	\N	23	\N
403		\N		\N	\N	\N	1044	\N
1104		\N		\N	\N	\N	78	\N
1104		\N		\N	\N	\N	80	\N
1104		\N		\N	\N	\N	240	\N
1104		\N		\N	\N	\N	289	\N
1108		\N		\N	\N	\N	41	\N
1108		\N		\N	\N	\N	100	\N
1108		\N		\N	\N	\N	744	\N
1109		\N		\N	\N	\N	41	\N
1109		\N		\N	\N	\N	100	\N
1109		\N		\N	\N	\N	744	\N
898		\N		\N	\N	\N	281	\N
1027		\N		\N	\N	\N	132	\N
1175		\N		\N	\N	\N	65	\N
1175		\N		\N	\N	\N	92	\N
1072		\N		\N	\N	\N	30	\N
834		\N		\N	\N	\N	731	\N
831		\N		\N	\N	\N	361	\N
831		\N		\N	\N	\N	1084	\N
1110		\N		\N	\N	\N	910	\N
781		\N		\N	\N	\N	14	\N
971		\N		\N	\N	\N	110	\N
971		\N		\N	\N	\N	133	\N
971		\N		\N	\N	\N	248	\N
971		\N		\N	\N	\N	291	\N
971		\N		\N	\N	\N	1071	\N
971		\N		\N	\N	\N	1081	\N
971		\N		\N	\N	\N	724	\N
971		\N		\N	\N	\N	1049	\N
1169		\N		\N	\N	\N	89	\N
1168		\N		\N	\N	\N	139	\N
1168		\N		\N	\N	\N	140	\N
1168		\N		\N	\N	\N	184	\N
1168		\N		\N	\N	\N	347	\N
1168		\N		\N	\N	\N	378	\N
885		\N		\N	\N	\N	5	\N
885		\N		\N	\N	\N	7	\N
885		\N		\N	\N	\N	39	\N
885		\N		\N	\N	\N	69	\N
885		\N		\N	\N	\N	153	\N
885		\N		\N	\N	\N	171	\N
1196		\N		\N	\N	\N	12	\N
1196		\N		\N	\N	\N	619	\N
1196		\N		\N	\N	\N	938	\N
1111		\N		\N	\N	\N	49	\N
1111		\N		\N	\N	\N	178	\N
1111		\N		\N	\N	\N	231	\N
983		\N		\N	\N	\N	35	\N
1149		\N		\N	\N	\N	228	\N
1151		\N		\N	\N	\N	228	\N
956		\N		\N	\N	\N	90	\N
913		\N		\N	\N	\N	38	\N
913		\N		\N	\N	\N	107	\N
913		\N		\N	\N	\N	1094	\N
913		\N		\N	\N	\N	454	\N
913		\N		\N	\N	\N	1024	\N
913		\N		\N	\N	\N	758	\N
999		\N		\N	\N	\N	245	\N
998		\N		\N	\N	\N	57	\N
998		\N		\N	\N	\N	89	\N
998		\N		\N	\N	\N	105	\N
998		\N		\N	\N	\N	156	\N
998		\N		\N	\N	\N	347	\N
998		\N		\N	\N	\N	674	\N
691		\N		\N	\N	\N	334	\N
691		\N		\N	\N	\N	947	\N
691		\N		\N	\N	\N	949	\N
1014		\N		\N	\N	\N	354	\N
1190		\N		\N	\N	\N	859	\N
900		\N		\N	\N	\N	39	\N
900		\N		\N	\N	\N	105	\N
887		\N		\N	\N	\N	1025	\N
734		\N		\N	\N	\N	127	\N
954		\N		\N	\N	\N	164	\N
749		\N		\N	\N	\N	118	\N
749		\N		\N	\N	\N	286	\N
1031		\N		\N	\N	\N	989	\N
1026		\N		\N	\N	\N	356	\N
907		\N		\N	\N	\N	624	\N
974		\N		\N	\N	\N	158	\N
974		\N		\N	\N	\N	263	\N
1210		\N		\N	\N	\N	24	\N
1210		\N		\N	\N	\N	250	\N
1210		\N		\N	\N	\N	267	\N
1210		\N		\N	\N	\N	821	\N
783		\N		\N	\N	\N	8	\N
784		\N		\N	\N	\N	8	\N
1012		\N		\N	\N	\N	133	\N
826		\N		\N	\N	\N	753	\N
794		\N		\N	\N	\N	186	\N
794		\N		\N	\N	\N	264	\N
794		\N		\N	\N	\N	365	\N
814		\N		\N	\N	\N	5	\N
814		\N		\N	\N	\N	73	\N
814		\N		\N	\N	\N	620	\N
814		\N		\N	\N	\N	627	\N
814		\N		\N	\N	\N	633	\N
814		\N		\N	\N	\N	871	\N
814		\N		\N	\N	\N	903	\N
924		\N		\N	\N	\N	128	\N
924		\N		\N	\N	\N	310	\N
1057		\N		\N	\N	\N	128	\N
1057		\N		\N	\N	\N	310	\N
1058		\N		\N	\N	\N	1022	\N
753		\N		\N	\N	\N	66	\N
753		\N		\N	\N	\N	77	\N
753		\N		\N	\N	\N	942	\N
753		\N		\N	\N	\N	981	\N
753		\N		\N	\N	\N	1115	\N
871		\N		\N	\N	\N	963	\N
933		\N		\N	\N	\N	31	\N
933		\N		\N	\N	\N	86	\N
933		\N		\N	\N	\N	92	\N
933		\N		\N	\N	\N	156	\N
933		\N		\N	\N	\N	309	\N
933		\N		\N	\N	\N	365	\N
934		\N		\N	\N	\N	31	\N
934		\N		\N	\N	\N	86	\N
934		\N		\N	\N	\N	92	\N
934		\N		\N	\N	\N	96	\N
934		\N		\N	\N	\N	156	\N
934		\N		\N	\N	\N	583	\N
1009		\N		\N	\N	\N	1027	\N
1197		\N		\N	\N	\N	312	\N
1197		\N		\N	\N	\N	1008	\N
1197		\N		\N	\N	\N	792	\N
836		\N		\N	\N	\N	726	\N
739		\N		\N	\N	\N	18	\N
1087		\N		\N	\N	\N	237	\N
1087		\N		\N	\N	\N	875	\N
1087		\N		\N	\N	\N	886	\N
1087		\N		\N	\N	\N	915	\N
690		\N		\N	\N	\N	133	\N
690		\N		\N	\N	\N	187	\N
690		\N		\N	\N	\N	351	\N
690		\N		\N	\N	\N	363	\N
690		\N		\N	\N	\N	651	\N
690		\N		\N	\N	\N	918	\N
899		\N		\N	\N	\N	340	\N
1088		\N		\N	\N	\N	238	\N
1088		\N		\N	\N	\N	474	\N
1088		\N		\N	\N	\N	719	\N
1088		\N		\N	\N	\N	1043	\N
886		\N		\N	\N	\N	8	\N
886		\N		\N	\N	\N	25	\N
886		\N		\N	\N	\N	52	\N
886		\N		\N	\N	\N	72	\N
886		\N		\N	\N	\N	110	\N
886		\N		\N	\N	\N	113	\N
886		\N		\N	\N	\N	634	\N
886		\N		\N	\N	\N	660	\N
886		\N		\N	\N	\N	1068	\N
886		\N		\N	\N	\N	1095	\N
886		\N		\N	\N	\N	458	\N
886		\N		\N	\N	\N	461	\N
886		\N		\N	\N	\N	708	\N
886		\N		\N	\N	\N	844	\N
886		\N		\N	\N	\N	977	\N
867		\N		\N	\N	\N	25	\N
100		\N		\N	\N	\N	666	\N
100		\N		\N	\N	\N	25	\N
943		\N		\N	\N	\N	143	\N
771		\N		\N	\N	\N	83	\N
771		\N		\N	\N	\N	88	\N
847		\N		\N	\N	\N	140	\N
986		\N		\N	\N	\N	989	\N
1102		\N		\N	\N	\N	37	\N
1102		\N		\N	\N	\N	81	\N
1102		\N		\N	\N	\N	161	\N
1102		\N		\N	\N	\N	237	\N
1102		\N		\N	\N	\N	342	\N
718		\N		\N	\N	\N	10	\N
718		\N		\N	\N	\N	353	\N
727		\N		\N	\N	\N	177	\N
727		\N		\N	\N	\N	187	\N
727		\N		\N	\N	\N	243	\N
727		\N		\N	\N	\N	755	\N
782		\N		\N	\N	\N	99	\N
782		\N		\N	\N	\N	203	\N
782		\N		\N	\N	\N	250	\N
1119		\N		\N	\N	\N	260	\N
1119		\N		\N	\N	\N	263	\N
1119		\N		\N	\N	\N	349	\N
1119		\N		\N	\N	\N	527	\N
1119		\N		\N	\N	\N	873	\N
1146		\N		\N	\N	\N	225	\N
1146		\N		\N	\N	\N	434	\N
1146		\N		\N	\N	\N	436	\N
1146		\N		\N	\N	\N	438	\N
1146		\N		\N	\N	\N	882	\N
1146		\N		\N	\N	\N	884	\N
1080		\N		\N	\N	\N	54	\N
1080		\N		\N	\N	\N	55	\N
1117		\N		\N	\N	\N	99	\N
1117		\N		\N	\N	\N	153	\N
1117		\N		\N	\N	\N	229	\N
1117		\N		\N	\N	\N	302	\N
1117		\N		\N	\N	\N	352	\N
1177		\N		\N	\N	\N	157	\N
1177		\N		\N	\N	\N	942	\N
1065		\N		\N	\N	\N	57	\N
1065		\N		\N	\N	\N	61	\N
729		\N		\N	\N	\N	160	\N
729		\N		\N	\N	\N	373	\N
729		\N		\N	\N	\N	376	\N
729		\N		\N	\N	\N	474	\N
729		\N		\N	\N	\N	706	\N
729		\N		\N	\N	\N	871	\N
728		\N		\N	\N	\N	341	\N
728		\N		\N	\N	\N	376	\N
728		\N		\N	\N	\N	609	\N
973		\N		\N	\N	\N	184	\N
851		\N		\N	\N	\N	75	\N
851		\N		\N	\N	\N	208	\N
851		\N		\N	\N	\N	271	\N
851		\N		\N	\N	\N	370	\N
935		\N		\N	\N	\N	194	\N
935		\N		\N	\N	\N	635	\N
935		\N		\N	\N	\N	471	\N
935		\N		\N	\N	\N	676	\N
935		\N		\N	\N	\N	739	\N
935		\N		\N	\N	\N	784	\N
935		\N		\N	\N	\N	842	\N
1078		\N		\N	\N	\N	699	\N
815		\N		\N	\N	\N	36	\N
815		\N		\N	\N	\N	75	\N
815		\N		\N	\N	\N	484	\N
815		\N		\N	\N	\N	1126	\N
936		\N		\N	\N	\N	40	\N
936		\N		\N	\N	\N	74	\N
936		\N		\N	\N	\N	102	\N
936		\N		\N	\N	\N	119	\N
936		\N		\N	\N	\N	149	\N
936		\N		\N	\N	\N	158	\N
936		\N		\N	\N	\N	360	\N
936		\N		\N	\N	\N	1007	\N
936		\N		\N	\N	\N	1022	\N
936		\N		\N	\N	\N	752	\N
936		\N		\N	\N	\N	907	\N
936		\N		\N	\N	\N	997	\N
1211		\N		\N	\N	\N	39	\N
1211		\N		\N	\N	\N	67	\N
1211		\N		\N	\N	\N	103	\N
1211		\N		\N	\N	\N	890	\N
1121		\N		\N	\N	\N	131	\N
693		\N		\N	\N	\N	283	\N
915		\N		\N	\N	\N	333	\N
915		\N		\N	\N	\N	340	\N
921		\N		\N	\N	\N	38	\N
921		\N		\N	\N	\N	200	\N
921		\N		\N	\N	\N	278	\N
692		\N		\N	\N	\N	488	\N
692		\N		\N	\N	\N	674	\N
147		\N		\N	\N	\N	77	\N
147		\N		\N	\N	\N	309	\N
147		\N		\N	\N	\N	766	\N
692		\N		\N	\N	\N	342	\N
1095		\N		\N	\N	\N	227	\N
1095		\N		\N	\N	\N	339	\N
1095		\N		\N	\N	\N	715	\N
695		\N		\N	\N	\N	111	\N
695		\N		\N	\N	\N	157	\N
695		\N		\N	\N	\N	362	\N
695		\N		\N	\N	\N	716	\N
695		\N		\N	\N	\N	777	\N
695		\N		\N	\N	\N	940	\N
694		\N		\N	\N	\N	279	\N
694		\N		\N	\N	\N	299	\N
694		\N		\N	\N	\N	351	\N
694		\N		\N	\N	\N	787	\N
1090		\N		\N	\N	\N	910	\N
1090		\N		\N	\N	\N	912	\N
878		\N		\N	\N	\N	110	\N
922		\N		\N	\N	\N	154	\N
922		\N		\N	\N	\N	35	\N
922		\N		\N	\N	\N	184	\N
768		\N		\N	\N	\N	189	\N
1137		\N		\N	\N	\N	115	\N
1115		\N		\N	\N	\N	99	\N
1115		\N		\N	\N	\N	137	\N
1115		\N		\N	\N	\N	138	\N
1115		\N		\N	\N	\N	150	\N
1115		\N		\N	\N	\N	151	\N
1115		\N		\N	\N	\N	153	\N
1115		\N		\N	\N	\N	188	\N
1115		\N		\N	\N	\N	224	\N
1115		\N		\N	\N	\N	230	\N
1115		\N		\N	\N	\N	231	\N
1115		\N		\N	\N	\N	703	\N
1115		\N		\N	\N	\N	922	\N
1115		\N		\N	\N	\N	957	\N
930		\N		\N	\N	\N	1	\N
930		\N		\N	\N	\N	7	\N
930		\N		\N	\N	\N	66	\N
930		\N		\N	\N	\N	118	\N
930		\N		\N	\N	\N	183	\N
930		\N		\N	\N	\N	203	\N
930		\N		\N	\N	\N	645	\N
930		\N		\N	\N	\N	677	\N
930		\N		\N	\N	\N	777	\N
930		\N		\N	\N	\N	784	\N
930		\N		\N	\N	\N	843	\N
905		\N		\N	\N	\N	84	\N
905		\N		\N	\N	\N	92	\N
905		\N		\N	\N	\N	109	\N
72		\N		\N	\N	\N	157	\N
72		\N		\N	\N	\N	53	\N
72		\N		\N	\N	\N	70	\N
72		\N		\N	\N	\N	797	\N
488		\N		\N	\N	\N	371	\N
386		\N		\N	\N	\N	907	\N
386		\N		\N	\N	\N	80	\N
386		\N		\N	\N	\N	179	\N
386		\N		\N	\N	\N	208	\N
386		\N		\N	\N	\N	239	\N
386		\N		\N	\N	\N	249	\N
386		\N		\N	\N	\N	277	\N
386		\N		\N	\N	\N	458	\N
386		\N		\N	\N	\N	976	\N
386		\N		\N	\N	\N	997	\N
1213		\N		\N	\N	\N	138	\N
758		\N		\N	\N	\N	138	\N
32		\N		\N	\N	\N	20	\N
32		\N		\N	\N	\N	21	\N
32		\N		\N	\N	\N	160	\N
32		\N		\N	\N	\N	175	\N
32		\N		\N	\N	\N	177	\N
32		\N		\N	\N	\N	299	\N
685		\N		\N	\N	\N	1133	\N
686		\N		\N	\N	\N	1132	\N
697		\N		\N	\N	\N	1134	\N
701		\N		\N	\N	\N	1135	\N
701		\N		\N	\N	\N	1398	\N
701		\N		\N	\N	\N	1399	\N
704		\N		\N	\N	\N	1136	\N
705		\N		\N	\N	\N	1137	\N
705		\N		\N	\N	\N	1400	\N
706		\N		\N	\N	\N	1398	\N
706		\N		\N	\N	\N	1138	\N
707		\N		\N	\N	\N	1139	\N
707		\N		\N	\N	\N	1401	\N
709		\N		\N	\N	\N	818	\N
709		\N		\N	\N	\N	287	\N
709		\N		\N	\N	\N	1140	\N
1136		\N		\N	\N	\N	1402	\N
1136		\N		\N	\N	\N	834	\N
1136		\N		\N	\N	\N	841	\N
1136		\N		\N	\N	\N	940	\N
709		\N		\N	\N	\N	1384	\N
709		\N		\N	\N	\N	833	\N
710		\N		\N	\N	\N	1137	\N
710		\N		\N	\N	\N	1141	\N
710		\N		\N	\N	\N	1403	\N
804		\N		\N	\N	\N	1197	\N
804		\N		\N	\N	\N	1246	\N
804		\N		\N	\N	\N	1376	\N
731		\N		\N	\N	\N	1153	\N
713		\N		\N	\N	\N	1143	\N
712		\N		\N	\N	\N	1142	\N
712		\N		\N	\N	\N	1404	\N
714		\N		\N	\N	\N	1249	\N
714		\N		\N	\N	\N	1144	\N
715		\N		\N	\N	\N	1145	\N
716		\N		\N	\N	\N	1278	\N
716		\N		\N	\N	\N	1146	\N
717		\N		\N	\N	\N	1400	\N
717		\N		\N	\N	\N	1147	\N
720		\N		\N	\N	\N	1148	\N
723		\N		\N	\N	\N	1149	\N
724		\N		\N	\N	\N	1150	\N
724		\N		\N	\N	\N	1406	\N
726		\N		\N	\N	\N	1151	\N
730		\N		\N	\N	\N	869	\N
743		\N		\N	\N	\N	1155	\N
747		\N		\N	\N	\N	1156	\N
748		\N		\N	\N	\N	1157	\N
748		\N		\N	\N	\N	1407	\N
750		\N		\N	\N	\N	1158	\N
751		\N		\N	\N	\N	1159	\N
754		\N		\N	\N	\N	1321	\N
754		\N		\N	\N	\N	1408	\N
754		\N		\N	\N	\N	1232	\N
754		\N		\N	\N	\N	1386	\N
754		\N		\N	\N	\N	719	\N
757		\N		\N	\N	\N	1158	\N
757		\N		\N	\N	\N	1162	\N
757		\N		\N	\N	\N	1304	\N
757		\N		\N	\N	\N	1409	\N
757		\N		\N	\N	\N	1410	\N
757		\N		\N	\N	\N	1411	\N
906		\N		\N	\N	\N	1163	\N
906		\N		\N	\N	\N	1235	\N
774		\N		\N	\N	\N	1294	\N
774		\N		\N	\N	\N	1171	\N
774		\N		\N	\N	\N	132	\N
764		\N		\N	\N	\N	1167	\N
762		\N		\N	\N	\N	1165	\N
762		\N		\N	\N	\N	1412	\N
763		\N		\N	\N	\N	1166	\N
767		\N		\N	\N	\N	1168	\N
767		\N		\N	\N	\N	1413	\N
770		\N		\N	\N	\N	1169	\N
770		\N		\N	\N	\N	1414	\N
772		\N		\N	\N	\N	1251	\N
772		\N		\N	\N	\N	1265	\N
776		\N		\N	\N	\N	1172	\N
777		\N		\N	\N	\N	1173	\N
788		\N		\N	\N	\N	1175	\N
788		\N		\N	\N	\N	1204	\N
791		\N		\N	\N	\N	1176	\N
795		\N		\N	\N	\N	1177	\N
795		\N		\N	\N	\N	1415	\N
796		\N		\N	\N	\N	1178	\N
797		\N		\N	\N	\N	1179	\N
797		\N		\N	\N	\N	1276	\N
797		\N		\N	\N	\N	1416	\N
798		\N		\N	\N	\N	1180	\N
798		\N		\N	\N	\N	1417	\N
800		\N		\N	\N	\N	1181	\N
800		\N		\N	\N	\N	1185	\N
800		\N		\N	\N	\N	1418	\N
801		\N		\N	\N	\N	1182	\N
801		\N		\N	\N	\N	1271	\N
801		\N		\N	\N	\N	1328	\N
801		\N		\N	\N	\N	1419	\N
802		\N		\N	\N	\N	1183	\N
802		\N		\N	\N	\N	1420	\N
780		\N		\N	\N	\N	1184	\N
780		\N		\N	\N	\N	153	\N
780		\N		\N	\N	\N	185	\N
780		\N		\N	\N	\N	457	\N
780		\N		\N	\N	\N	1421	\N
780		\N		\N	\N	\N	1422	\N
780		\N		\N	\N	\N	1423	\N
807		\N		\N	\N	\N	1182	\N
807		\N		\N	\N	\N	1185	\N
807		\N		\N	\N	\N	1383	\N
808		\N		\N	\N	\N	1184	\N
808		\N		\N	\N	\N	1186	\N
810		\N		\N	\N	\N	1187	\N
810		\N		\N	\N	\N	835	\N
812		\N		\N	\N	\N	1188	\N
813		\N		\N	\N	\N	1189	\N
816		\N		\N	\N	\N	1190	\N
816		\N		\N	\N	\N	1424	\N
819		\N		\N	\N	\N	1191	\N
819		\N		\N	\N	\N	1424	\N
820		\N		\N	\N	\N	1192	\N
821		\N		\N	\N	\N	1193	\N
823		\N		\N	\N	\N	1194	\N
823		\N		\N	\N	\N	357	\N
826		\N		\N	\N	\N	1195	\N
830		\N		\N	\N	\N	1196	\N
832		\N		\N	\N	\N	1418	\N
832		\N		\N	\N	\N	1197	\N
833		\N		\N	\N	\N	1198	\N
835		\N		\N	\N	\N	1199	\N
835		\N		\N	\N	\N	335	\N
838		\N		\N	\N	\N	1200	\N
840		\N		\N	\N	\N	1201	\N
840		\N		\N	\N	\N	1425	\N
842		\N		\N	\N	\N	1204	\N
842		\N		\N	\N	\N	1202	\N
842		\N		\N	\N	\N	1426	\N
843		\N		\N	\N	\N	1203	\N
846		\N		\N	\N	\N	1204	\N
846		\N		\N	\N	\N	1182	\N
846		\N		\N	\N	\N	1270	\N
850		\N		\N	\N	\N	1205	\N
852		\N		\N	\N	\N	1206	\N
979		\N		\N	\N	\N	1268	\N
979		\N		\N	\N	\N	1333	\N
979		\N		\N	\N	\N	1376	\N
979		\N		\N	\N	\N	1427	\N
852		\N		\N	\N	\N	1427	\N
852		\N		\N	\N	\N	1216	\N
852		\N		\N	\N	\N	1428	\N
854		\N		\N	\N	\N	1207	\N
854		\N		\N	\N	\N	1429	\N
855		\N		\N	\N	\N	1208	\N
858		\N		\N	\N	\N	1209	\N
858		\N		\N	\N	\N	1430	\N
859		\N		\N	\N	\N	1208	\N
859		\N		\N	\N	\N	1211	\N
859		\N		\N	\N	\N	1210	\N
859		\N		\N	\N	\N	1431	\N
859		\N		\N	\N	\N	1432	\N
859		\N		\N	\N	\N	1433	\N
862		\N		\N	\N	\N	1212	\N
862		\N		\N	\N	\N	1225	\N
862		\N		\N	\N	\N	1306	\N
863		\N		\N	\N	\N	1213	\N
863		\N		\N	\N	\N	1308	\N
863		\N		\N	\N	\N	1434	\N
863		\N		\N	\N	\N	1435	\N
864		\N		\N	\N	\N	1214	\N
864		\N		\N	\N	\N	1436	\N
865		\N		\N	\N	\N	1215	\N
865		\N		\N	\N	\N	181	\N
865		\N		\N	\N	\N	1437	\N
866		\N		\N	\N	\N	1216	\N
868		\N		\N	\N	\N	1217	\N
869		\N		\N	\N	\N	1218	\N
870		\N		\N	\N	\N	1219	\N
870		\N		\N	\N	\N	1438	\N
873		\N		\N	\N	\N	1220	\N
874		\N		\N	\N	\N	1221	\N
874		\N		\N	\N	\N	1440	\N
875		\N		\N	\N	\N	1222	\N
875		\N		\N	\N	\N	1441	\N
876		\N		\N	\N	\N	1223	\N
876		\N		\N	\N	\N	1225	\N
876		\N		\N	\N	\N	1442	\N
877		\N		\N	\N	\N	1224	\N
880		\N		\N	\N	\N	1225	\N
883		\N		\N	\N	\N	1226	\N
883		\N		\N	\N	\N	1443	\N
889		\N		\N	\N	\N	1227	\N
889		\N		\N	\N	\N	1444	\N
891		\N		\N	\N	\N	1228	\N
891		\N		\N	\N	\N	1445	\N
892		\N		\N	\N	\N	1229	\N
892		\N		\N	\N	\N	1446	\N
1047		\N		\N	\N	\N	1313	\N
1047		\N		\N	\N	\N	1230	\N
894		\N		\N	\N	\N	1231	\N
896		\N		\N	\N	\N	1232	\N
897		\N		\N	\N	\N	1233	\N
897		\N		\N	\N	\N	1447	\N
897		\N		\N	\N	\N	558	\N
897		\N		\N	\N	\N	618	\N
897		\N		\N	\N	\N	1056	\N
904		\N		\N	\N	\N	1234	\N
904		\N		\N	\N	\N	1448	\N
911		\N		\N	\N	\N	1233	\N
911		\N		\N	\N	\N	1237	\N
911		\N		\N	\N	\N	1449	\N
912		\N		\N	\N	\N	1171	\N
912		\N		\N	\N	\N	1238	\N
916		\N		\N	\N	\N	1239	\N
916		\N		\N	\N	\N	1450	\N
919		\N		\N	\N	\N	1158	\N
919		\N		\N	\N	\N	1240	\N
920		\N		\N	\N	\N	1241	\N
920		\N		\N	\N	\N	1243	\N
925		\N		\N	\N	\N	1243	\N
925		\N		\N	\N	\N	1451	\N
923		\N		\N	\N	\N	1242	\N
923		\N		\N	\N	\N	1135	\N
923		\N		\N	\N	\N	1452	\N
907		\N		\N	\N	\N	1244	\N
907		\N		\N	\N	\N	1266	\N
975		\N		\N	\N	\N	1266	\N
931		\N		\N	\N	\N	1246	\N
942		\N		\N	\N	\N	1247	\N
942		\N		\N	\N	\N	1453	\N
686		\N		\N	\N	\N	1188	\N
945		\N		\N	\N	\N	1248	\N
945		\N		\N	\N	\N	1454	\N
946		\N		\N	\N	\N	1249	\N
946		\N		\N	\N	\N	1405	\N
955		\N		\N	\N	\N	1254	\N
947		\N		\N	\N	\N	1250	\N
951		\N		\N	\N	\N	1251	\N
951		\N		\N	\N	\N	771	\N
952		\N		\N	\N	\N	1252	\N
952		\N		\N	\N	\N	1455	\N
1052		\N		\N	\N	\N	1318	\N
954		\N		\N	\N	\N	1253	\N
957		\N		\N	\N	\N	1410	\N
957		\N		\N	\N	\N	1237	\N
957		\N		\N	\N	\N	1255	\N
959		\N		\N	\N	\N	1256	\N
961		\N		\N	\N	\N	1258	\N
961		\N		\N	\N	\N	802	\N
1215		\N		\N	\N	\N	1257	\N
962		\N		\N	\N	\N	1259	\N
962		\N		\N	\N	\N	1456	\N
964		\N		\N	\N	\N	1260	\N
964		\N		\N	\N	\N	1457	\N
964		\N		\N	\N	\N	1382	\N
964		\N		\N	\N	\N	1068	\N
964		\N		\N	\N	\N	748	\N
1181		\N		\N	\N	\N	1458	\N
965		\N		\N	\N	\N	1261	\N
967		\N		\N	\N	\N	1262	\N
969		\N		\N	\N	\N	1263	\N
969		\N		\N	\N	\N	1459	\N
1102		\N		\N	\N	\N	1264	\N
1102		\N		\N	\N	\N	432	\N
1102		\N		\N	\N	\N	647	\N
972		\N		\N	\N	\N	1383	\N
1183		\N		\N	\N	\N	1460	\N
978		\N		\N	\N	\N	1267	\N
978		\N		\N	\N	\N	1461	\N
980		\N		\N	\N	\N	1269	\N
980		\N		\N	\N	\N	1462	\N
981		\N		\N	\N	\N	1270	\N
984		\N		\N	\N	\N	1272	\N
985		\N		\N	\N	\N	1273	\N
985		\N		\N	\N	\N	1463	\N
987		\N		\N	\N	\N	1274	\N
990		\N		\N	\N	\N	1277	\N
993		\N		\N	\N	\N	1278	\N
995		\N		\N	\N	\N	1279	\N
995		\N		\N	\N	\N	89	\N
995		\N		\N	\N	\N	1378	\N
997		\N		\N	\N	\N	1280	\N
1002		\N		\N	\N	\N	1281	\N
996		\N		\N	\N	\N	1283	\N
996		\N		\N	\N	\N	1307	\N
1007		\N		\N	\N	\N	1284	\N
1007		\N		\N	\N	\N	1464	\N
1008		\N		\N	\N	\N	1285	\N
1008		\N		\N	\N	\N	1465	\N
1011		\N		\N	\N	\N	1287	\N
1011		\N		\N	\N	\N	1466	\N
1011		\N		\N	\N	\N	1467	\N
1011		\N		\N	\N	\N	133	\N
1011		\N		\N	\N	\N	1150	\N
1010		\N		\N	\N	\N	1318	\N
1015		\N		\N	\N	\N	1289	\N
1016		\N		\N	\N	\N	1290	\N
1017		\N		\N	\N	\N	1291	\N
1018		\N		\N	\N	\N	1292	\N
1018		\N		\N	\N	\N	1468	\N
1019		\N		\N	\N	\N	1293	\N
1019		\N		\N	\N	\N	1469	\N
1019		\N		\N	\N	\N	1302	\N
1019		\N		\N	\N	\N	1377	\N
1020		\N		\N	\N	\N	1164	\N
1022		\N		\N	\N	\N	1296	\N
1022		\N		\N	\N	\N	1470	\N
1023		\N		\N	\N	\N	1297	\N
1024		\N		\N	\N	\N	1298	\N
1025		\N		\N	\N	\N	1299	\N
1025		\N		\N	\N	\N	1315	\N
1049		\N		\N	\N	\N	1315	\N
1049		\N		\N	\N	\N	1471	\N
1025		\N		\N	\N	\N	1472	\N
1028		\N		\N	\N	\N	1300	\N
1028		\N		\N	\N	\N	1473	\N
1029		\N		\N	\N	\N	1474	\N
1029		\N		\N	\N	\N	1301	\N
1030		\N		\N	\N	\N	1302	\N
1032		\N		\N	\N	\N	1303	\N
1033		\N		\N	\N	\N	1409	\N
1033		\N		\N	\N	\N	1411	\N
1034		\N		\N	\N	\N	1305	\N
879		\N		\N	\N	\N	1307	\N
1037		\N		\N	\N	\N	1224	\N
1040		\N		\N	\N	\N	1309	\N
1040		\N		\N	\N	\N	1475	\N
1040		\N		\N	\N	\N	1476	\N
1043		\N		\N	\N	\N	1310	\N
1044		\N		\N	\N	\N	1311	\N
1044		\N		\N	\N	\N	1477	\N
1046		\N		\N	\N	\N	1312	\N
1048		\N		\N	\N	\N	1322	\N
1048		\N		\N	\N	\N	1314	\N
1050		\N		\N	\N	\N	1316	\N
1053		\N		\N	\N	\N	1319	\N
1054		\N		\N	\N	\N	1320	\N
1055		\N		\N	\N	\N	1321	\N
1056		\N		\N	\N	\N	1322	\N
1056		\N		\N	\N	\N	1478	\N
1059		\N		\N	\N	\N	1323	\N
1060		\N		\N	\N	\N	1324	\N
1062		\N		\N	\N	\N	1326	\N
1063		\N		\N	\N	\N	1327	\N
1063		\N		\N	\N	\N	1334	\N
1064		\N		\N	\N	\N	1326	\N
1064		\N		\N	\N	\N	1328	\N
1066		\N		\N	\N	\N	1329	\N
1067		\N		\N	\N	\N	1330	\N
1068		\N		\N	\N	\N	1331	\N
1069		\N		\N	\N	\N	1332	\N
1071		\N		\N	\N	\N	1333	\N
1073		\N		\N	\N	\N	1334	\N
1074		\N		\N	\N	\N	1335	\N
1075		\N		\N	\N	\N	1336	\N
1076		\N		\N	\N	\N	1337	\N
1082		\N		\N	\N	\N	1339	\N
1085		\N		\N	\N	\N	1340	\N
785		\N		\N	\N	\N	1174	\N
908		\N		\N	\N	\N	1480	\N
1067		\N		\N	\N	\N	1481	\N
1114		\N		\N	\N	\N	1351	\N
1134		\N		\N	\N	\N	1362	\N
1179		\N		\N	\N	\N	1380	\N
1186		\N		\N	\N	\N	1386	\N
1187		\N		\N	\N	\N	1432	\N
1187		\N		\N	\N	\N	1387	\N
1191		\N		\N	\N	\N	1389	\N
1191		\N		\N	\N	\N	1482	\N
403		\N		\N	\N	\N	1396	\N
403		\N		\N	\N	\N	1484	\N
995		\N		\N	\N	\N	1485	\N
988		\N		\N	\N	\N	1486	\N
1005		\N		\N	\N	\N	1487	\N
1006		\N		\N	\N	\N	1488	\N
1051		\N		\N	\N	\N	1489	\N
1051		\N		\N	\N	\N	1490	\N
1077		\N		\N	\N	\N	1491	\N
1086		\N		\N	\N	\N	1341	\N
1092		\N		\N	\N	\N	1342	\N
1094		\N		\N	\N	\N	1343	\N
1096		\N		\N	\N	\N	1271	\N
1096		\N		\N	\N	\N	1344	\N
1097		\N		\N	\N	\N	1345	\N
1098		\N		\N	\N	\N	1346	\N
1099		\N		\N	\N	\N	1347	\N
1100		\N		\N	\N	\N	1348	\N
1112		\N		\N	\N	\N	1349	\N
1112		\N		\N	\N	\N	1492	\N
1113		\N		\N	\N	\N	1350	\N
1118		\N		\N	\N	\N	942	\N
1118		\N		\N	\N	\N	1494	\N
1124		\N		\N	\N	\N	1354	\N
1125		\N		\N	\N	\N	1355	\N
1128		\N		\N	\N	\N	1356	\N
1128		\N		\N	\N	\N	1495	\N
1130		\N		\N	\N	\N	1358	\N
1216		\N		\N	\N	\N	1175	\N
1216		\N		\N	\N	\N	1357	\N
1131		\N		\N	\N	\N	1496	\N
1133		\N		\N	\N	\N	1361	\N
1133		\N		\N	\N	\N	1140	\N
1141		\N		\N	\N	\N	1363	\N
1141		\N		\N	\N	\N	1497	\N
1143		\N		\N	\N	\N	1364	\N
1148		\N		\N	\N	\N	1365	\N
1148		\N		\N	\N	\N	1498	\N
1152		\N		\N	\N	\N	1366	\N
1217		\N		\N	\N	\N	1499	\N
1164		\N		\N	\N	\N	1373	\N
1164		\N		\N	\N	\N	1374	\N
1155		\N		\N	\N	\N	1367	\N
1155		\N		\N	\N	\N	1500	\N
1155		\N		\N	\N	\N	1501	\N
1158		\N		\N	\N	\N	1369	\N
1158		\N		\N	\N	\N	1372	\N
1158		\N		\N	\N	\N	1502	\N
1160		\N		\N	\N	\N	1370	\N
1160		\N		\N	\N	\N	1503	\N
1161		\N		\N	\N	\N	1371	\N
1161		\N		\N	\N	\N	1392	\N
1161		\N		\N	\N	\N	1504	\N
1161		\N		\N	\N	\N	1505	\N
1162		\N		\N	\N	\N	1372	\N
1163		\N		\N	\N	\N	1373	\N
1165		\N		\N	\N	\N	1375	\N
1166		\N		\N	\N	\N	1507	\N
1167		\N		\N	\N	\N	1377	\N
1178		\N		\N	\N	\N	1379	\N
1178		\N		\N	\N	\N	1508	\N
1180		\N		\N	\N	\N	1381	\N
1184		\N		\N	\N	\N	1384	\N
1185		\N		\N	\N	\N	1385	\N
1188		\N		\N	\N	\N	1388	\N
1188		\N		\N	\N	\N	1509	\N
1192		\N		\N	\N	\N	1510	\N
1193		\N		\N	\N	\N	1391	\N
1193		\N		\N	\N	\N	1511	\N
1194		\N		\N	\N	\N	1332	\N
1194		\N		\N	\N	\N	1346	\N
1194		\N		\N	\N	\N	1392	\N
1195		\N		\N	\N	\N	1393	\N
1195		\N		\N	\N	\N	1512	\N
1198		\N		\N	\N	\N	1513	\N
1205		\N		\N	\N	\N	1395	\N
1212		\N		\N	\N	\N	1397	\N
1212		\N		\N	\N	\N	1514	\N
758		\N		\N	\N	\N	1163	\N
1132		\N		\N	\N	\N	1359	\N
1132		\N		\N	\N	\N	1496	\N
977		\N		\N	\N	\N	1221	\N
687		\N		\N	\N	\N	1193	\N
687		\N		\N	\N	\N	34	\N
687		\N		\N	\N	\N	1515	\N
689		\N		\N	\N	\N	1192	\N
689		\N		\N	\N	\N	1373	\N
1047		\N		\N	\N	\N	1516	\N
1047		\N		\N	\N	\N	1517	\N
707		\N		\N	\N	\N	1498	\N
896		\N		\N	\N	\N	1518	\N
1000		\N		\N	\N	\N	1124	\N
1000		\N		\N	\N	\N	1519	\N
991		\N		\N	\N	\N	1520	\N
991		\N		\N	\N	\N	1521	\N
755		\N		\N	\N	\N	1522	\N
988		\N		\N	\N	\N	1523	\N
1011		\N		\N	\N	\N	1524	\N
1191		\N		\N	\N	\N	1525	\N
850		\N		\N	\N	\N	1526	\N
826		\N		\N	\N	\N	1527	\N
829		\N		\N	\N	\N	1196	\N
829		\N		\N	\N	\N	1298	\N
1175		\N		\N	\N	\N	1378	\N
1199		\N		\N	\N	\N	720	\N
1199		\N		\N	\N	\N	916	\N
1199		\N		\N	\N	\N	311	\N
1199		\N		\N	\N	\N	179	\N
1199		\N		\N	\N	\N	40	\N
1199		\N		\N	\N	\N	1198	\N
1199		\N		\N	\N	\N	1234	\N
1199		\N		\N	\N	\N	1438	\N
1199		\N		\N	\N	\N	336	\N
1199		\N		\N	\N	\N	236	\N
1199		\N		\N	\N	\N	167	\N
830		\N		\N	\N	\N	1435	\N
898		\N		\N	\N	\N	1231	\N
898		\N		\N	\N	\N	1232	\N
1154		\N		\N	\N	\N	1366	\N
1154		\N		\N	\N	\N	1374	\N
1150		\N		\N	\N	\N	1315	\N
1150		\N		\N	\N	\N	1344	\N
966		\N		\N	\N	\N	1511	\N
1138		\N		\N	\N	\N	1164	\N
1172		\N		\N	\N	\N	867	\N
1104		\N		\N	\N	\N	744	\N
1104		\N		\N	\N	\N	41	\N
488		\N		\N	\N	\N	595	\N
488		\N		\N	\N	\N	980	\N
900		\N		\N	\N	\N	1232	\N
900		\N		\N	\N	\N	1253	\N
72		\N		\N	\N	\N	1215	\N
32		\N		\N	\N	\N	1163	\N
32		\N		\N	\N	\N	1321	\N
32		\N		\N	\N	\N	985	\N
32		\N		\N	\N	\N	260	\N
32		\N		\N	\N	\N	1054	\N
1177		\N		\N	\N	\N	1493	\N
1151		\N		\N	\N	\N	1528	\N
1031		\N		\N	\N	\N	1529	\N
1213		\N		\N	\N	\N	1530	\N
722		\N		\N	\N	\N	1531	\N
905		\N		\N	\N	\N	1287	\N
905		\N		\N	\N	\N	1512	\N
823		\N		\N	\N	\N	1973	\N
825		\N		\N	\N	\N	1973	\N
1145		\N		\N	\N	\N	1606	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: es
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT word_usage_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


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

