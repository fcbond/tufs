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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO de;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO de;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO de;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: de
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


ALTER TABLE public.t_instance OWNER TO de;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO de;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO de;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: de
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


ALTER TABLE public.t_usage_classified_rel OWNER TO de;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: de
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


ALTER TABLE public.t_usage_inst_rel OWNER TO de;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO de;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO de;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: de
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO de;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: de
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


ALTER TABLE public.t_word_inst_rel OWNER TO de;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: de
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO de;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: de
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO de;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: de
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: de
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
23	W
24	X
25	Y
26	Z
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
1698			\N		\N	vmod	\N	\N	\N	0	1
129	Auf was wartest du noch?	君はまだ何を待っているの？	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
377	Wenn ich genug Geld hätte, arbeitete ich nicht mehr.		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
688	Er beantwortet die Frage.	彼はその質問に答える。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1078	Stimmt...	そうだねぇ…。	同意する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1251	Ja, bitte.	はい，お願いします。	希望を述べる		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1317	Ja, mach doch.	うん，そうしなよ。	提案する		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1351	Bist du erkältet?	風邪引いたの？	どうしているかを尋ねる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1419	Ach komm!	大丈夫だよ。	意見を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1454	Ich hab' echt 'nen Riesenhunger.	お腹ぺこぺこだよ。	理由を述べる		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1660	Das ist nett von dir!	恩に着るよ。	感謝する		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1752	Die Schuhe sind mir zu eng.	この靴は私にはきつい。	\N		\N	vmod	\N	\N	\N	0	1
1844	Da löschte er die Zigarette.	そのとき彼はたばこを消した。	\N		\N	vmod	\N	\N	\N	0	1
1	Ich lerne Deutsch.	私はドイツ語を勉強する。	null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2	Sie lernen Englisch.	あなたは英語を勉強する。	null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
3	Wir lernen Chinesisch.	私たちは中国語を勉強する。	null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
4	Sie lernen Französisch.	あなたたちはフランス語を勉強する。	null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
5	Hans trinkt Rotwein, aber Hanna trinkt Weißwein.	ハンスは赤ワインを飲む。でもハンナは白ワインを飲む。	null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
6	[Hans trinkt Rotwein], aber [Hanna trinkt Weißwein].		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
7	Kommt er heute?	彼は今日来るの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
8	Ja, er kommt heute.	うん，来るよ。	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
9	Nein, er kommt heute nicht.	いいや，来ないよ。	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
10	Kommt er heute nicht?	彼は今日来ないの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
11	Doch, er kommt heute.	いいや，来るよ。	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
12	Nein, er kommt heute nicht.	うん，来ないよ。	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
13	Wann kommst du?	いつ来るの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
14	Wo wohnst du?	どこに住んでいるの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
15	Wer lernt Deutsch?	だれがドイツ語を勉強するの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
16	Was machst du heute?	今日は何をするの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
17	Warum lachst du?	どうして笑っているの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
18	Wie lernst du Deutsch?	どのようにドイツ語を勉強しているの？	null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
19	Sind Sie Japaner?	あなたは日本人ですか？（男性に対して）	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
20	– Ja, ich bin Japaner.	はい，私は日本人です。	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
21	Bist du Studentin?	君，大学生？（女性に対して）	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
22	– Ja, ich bin Studentin.	うん，大学生だよ。	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
23	Sind sie Deutsche?	あの人たちはドイツ人なの？	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
24	– Nein, er ist Italiener und sie ist Französin.	いや，彼はイタリア人，彼女はフランス人だ。	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
2078	Mein Gepäck ist leicht.	私の荷物は軽い。	\N		\N	vmod	\N	\N	\N	0	1
25	Draußen ist es sehr kalt.	外はとても寒い。	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
26	Sind Sie glücklich?	あなたたちは幸せですか？	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
27	Ja, wir sind sehr glücklich.	はい，私たちはとても幸せです。	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1703	Sie trinken keinen Tropfen Alkohol.	彼らは一滴も酒を飲まない。	\N		\N	vmod	\N	\N	\N	0	1
28	Seid ihr traurig?	君たち，悲しいの？	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
29	Nein. wir sind nur müde.	いいや，疲れているだけだよ。	null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
30	Haben Sie heute Zeit?	あなたは今日時間がありますか？	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
31	– Ja, ich habe heute Zeit.	はい，あります。	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
32	Hast du heute Deutsch?	君，今日ドイツ語の授業ある？	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
33	– Nein, aber ich habe heute Englisch.	ないよ，でも今日は英語がある。	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
34	Er hat Geld und sie hat auch Geld.	彼はお金を持っているし，彼女もお金を持っている。	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
35	– Haben sie auch Zeit?	彼らは時間もあるのかな？	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
36	Haben Sie Reiswein?	（お店で）日本酒ありますか？	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
37	– Ja, wir haben Reiswein.	はい，ありますよ。	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
38	Habt ihr Kinder?	君たち，子供はいるの？	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
39	– Ja, wir haben zwei Kinder.	はい，二人います。	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
40	Werden Sie Lehrer?	あなたは先生になるのですか？（男性に対して）	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
41	– Ja, ich werde Lehrer.	はい，先生になります。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
42	Wirst du Lehrerin?	君は，先生になるの？（女性に対して）	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
43	– Nein, ich werde Dolmetscherin.	ううん，通訳になるの。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
44	Er wird Arzt und sie wird auch Ärztin.	彼は医者になり，彼女も医者になる。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
45	Es ist noch kalt, aber bald wird es warm.	まだ寒いけれど，もうすぐ暖かくなる。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
46	Wann werdet ihr Großeltern?	あなたたち，いつ孫ができる（祖父母になる）の？	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
47	– Wir werden bald Großeltern.	もうすぐです。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
48	Ich hoffe, Sie werden bald wieder gesund.	あなた［たち］はもうすぐ治る（再び健康になる）と思います。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
49	Ich hoffe, sie werden bald wieder gesund.	彼らはもうすぐ治る（再び健康になる）と思います。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
50	Die Tochter hilft dem Vater.	娘は父を手伝う。	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
51	Die Mutter fragt den Vater.	母は父に尋ねる。	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
52	„Wo ist das Buch?“ „Das Buch ist hier.“	「本はどこ？」「本はここにあるよ。」	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
53	Peter kauft bald ein Auto.	ペーターはもうすぐ車を買うよ。	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
54	Peter kauft bald das Auto.	ペーターはもうすぐ（あの）車を買うよ。	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
55	Peter kauft heute ein Buch.	ペーターは今日（ある１冊の）本を買う。	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
56	Peter kauft heute △ Bücher.	ペーターは今日（何冊かの）本を買う。	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
57	Peter kauft heute die Bücher.	ペーターは今日（あの数冊の）本を買う。	null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
58	×Schickt heute er der Studentin eine Mail?		null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
59	○Schickt er heute der Studentin eine Mail?		null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
60	×Was machen dort Sie?		null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
61	○Was machen Sie dort?		null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
62	Er kommt heute nicht.	彼は今日来ない。（別の日については何も言っていない）	null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
63	Er kommt nicht heute.	彼は今日は来ない（が，別の日に来る）。	null		\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
64	Statt meines Vaters kommt mein Onkel.	父の代わりにおじが来ます。	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
65	Trotz des Regens machen sie einen Spaziergang.	雨なのに彼らは散歩をする。	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
66	Er schläft während des Unterrichts.	彼は授業中に眠る。	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
67	Wegen der Erkältung kommt sie nicht.	風邪のために彼女は来ない。	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
68	Die Kinder gehen zur Schule.	子供たちは学校に行く。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
69	Trotz des Regens machen sie einen Spaziergang.	雨なのに彼らは散歩をする。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
70	Die Kinder gehen zu der Schule.	子供たちはその学校に行く。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
71	Er fährt zum Bahnhof.	彼は駅に行く。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
72	Ich wohne bei meinem Onkel.	私はそのおじさんの家に住んでいる。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
73	Sie arbeitet bei einer Bank.	彼女はある銀行で働いている。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
74	Dem Bahnhof gegenüber ist ein Kaufhaus.	駅の向かいにデパートがある。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
75	Die Kinder fahren mit dem Bus zur Schule.	子供たちはバスで学校に行く。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
76	Sie fährt mit dem Auto nach Berlin.	彼女は車でベルリンへ行く。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
77	Ich gehe zur Post und dann zum Kaufhaus.	私は郵便局に行き，それからデパートに行く。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
78	Die Lehrerin ist seit drei Tagen krank.	先生は３日前から病気だ。	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
79	Die Straßenbahn fährt bis zum Stadttor.	路面電車は市門まで行く。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
80	Der Zug fährt nur bis nach Bonn.	その列車はボンまでしか行かない。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
81	Wir bummeln durch die Stadt.	私たちは町をあちこち散歩する。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
82	Er erweitert seinen Gesichtskreis durch Reisen.	彼は旅を通じて視野を広げる。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
83	Ich miete das Zimmer für ein Jahr.	私はその部屋を１年の予定で借りる。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
84	Sind Sie für den Vorschlag?	あなたはその提案に賛成ですか？	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
85	Der Unterricht beginnt um 9 Uhr.	授業は９時に始まる。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
86	Wir bitten den Lehrer um Hilfe.	私たちは先生に手助けを頼む。	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
87	Sie arbeitet bei dieser Bank.	彼女はこの銀行で働いている。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
88	Welche Straßenbahn fährt zum Marktplatz?	どの路面電車が中央広場へ行きますか。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
89	Um jeden Tisch stehen sechs Stühle.	どのテーブルの周りにも椅子が６つ置いてある。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
90	Solche Fahrräder rosten schnell.	そういう自転車はすぐ錆びる。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
91	Alle Studenten bestehen diese Prüfung.	全ての学生がこの試験に受かる。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
92	Manche Kinder gehen zu einer Nachhilfeschule.	かなり多くの子供が塾に通っている。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
93	Seit jenem Unfall fährt er nicht mehr Auto.	あの事故以来彼は車を運転していない。	null		\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
94	Meine Schwester arbeitet bei dieser Bank.	私の姉はこの銀行で働いている。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
95	Ich kenne deinen Bruder.	君のお兄さんのこと知っているよ。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
96	Ihr Hotel ist gleich beim Bahnhof.	あなた［たち］のホテルは駅のすぐ近くです。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
97	Sind Sie für seinen Vorschlag?	あなた［たち］は彼の提案に賛成ですか？	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
98	Sie bittet ihren Lehrer um Hilfe.	彼女は［自分の］先生に手助けを頼む。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
99	Kein Student besteht diese Prüfung.	この試験に受かる学生はいない。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
100	Unsere Schule liegt gegenüber dem Friedhof.	学校は墓地の向かいにある。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
101	Eure Lehrerin ist seit Sonntag krank.	先生は日曜日から病気だ。	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
102	Am Sonntag fahren sie ans Meer.	日曜日に彼らは海［辺］に行く。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
103	Wir verbringen den Urlaub am Meer.	私たちは休暇を海辺で過ごす。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
104	Die Touristen steigen auf den Turm der Kirche.	観光客たちは教会の塔［の上］に登る。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
105	Auf dem Kirchturm machen sie eine Pause.	教会の塔の上で彼らは休憩する。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
106	Wie heißt das auf Deutsch?	これはドイツ語で何て言うの？	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
107	Das Buch fällt hinter das Regal.	本が本棚の後ろに落ちる。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
108	Das Buch liegt hinter dem Regal.	その本は本棚の後ろにある。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
109	Im Sommer reist sie nach Deutschland.	夏に彼女はドイツに旅行する。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
110	Er stellt den Drucker neben den Computer.	彼はプリンターをコンピューターの隣に置く。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
111	Der Drucker steht neben dem Computer.	プリンターはコンピューターの隣に置いてある。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
112	Sie hängt das Foto über den Schreibtisch.	彼女は写真を机の上［の壁］に掛ける。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
113	Das Foto hängt über dem Schreibtisch.	写真は机の上［の壁］に掛けてある。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
114	Die Schüler gehen hier über die Straße.	生徒たちはここで通りの向こう側へ渡る。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
115	Der Junge legt den Fußball unter den Tisch.	少年はサッカーボールを机の下に置く。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
116	Der Fußball liegt unter dem Tisch.	サッカーボールは机の下にある。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
117	Das Mädchen tritt vor den Spiegel.	少女は鏡の前へ歩み寄る。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
118	Das Mädchen steht vor dem Spiegel.	少女は鏡の前に立っている。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
119	Vor dem Abendessen macht er die Hausaufgaben.	夕食の前に彼は宿題をする。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
120	Er stellt den Fernseher zwischen das Regal und den Schrank.	彼はテレビを本棚とタンスの間に置く。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
121	Der Fernseher steht zwischen dem Regal und dem Schrank.	テレビは本棚とタンスの間に置いてある。	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
122	Da drüben ist mein Auto und daneben ist das meines Vaters.	あそこに私の車があって，その隣に父のがある。	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
123	Sie nimmt eine Apfelsine und macht Saft daraus.	彼女はオレンジを取り，それでジュースを作る。	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
124	„Hier ist ein Päckchen für dich?“ „Was ist darin?“	「ここに君宛の小包が来ているよ。」「［その］中は何だろう？」	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
125	Da ist ein Kino und nicht weit davon ist eine Disko.	あそこに映画館がり，そこから遠くないところにディスコがある。	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
126	Der Film beginnt um acht Uhr. Davor kommt nur Werbung.	映画は8時に始まる。その前は広告だけだ。	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
127	Mit was fährt er nach Italien?	彼は何(なに)でイタリアへ行くの？	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
128	Gegen was sind Sie allergisch?	あなたは何に対してアレルギーなんですか？	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
130	Sprich lauter!	もっと大きい声で話しなさい。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
131	Lies den Brief!	手紙を読みなさい。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
132	Werde doch bitte schnell wieder gesund!	どうか早く元気になってね。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
133	Sei brav!	行儀よくしなさい。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
134	Seid still!	静かにして。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
135	Seien Sie pünktlich!	時間を守りなさい。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
136	Nehmen Sie bitte Platz!	どうぞお掛けください。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
137	Warte mal hier!	ちょっとここで待っててね。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
138	Kommt doch zu uns!	ぜひうちに来なさいよ。	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
140	In Japan ist es im Sommer sehr schwül.	日本では夏はとても蒸し暑い。	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
141	„Wie spät ist es jetzt?“ „Es ist 8.20 Uhr.“	「今何時？」「8時20分だよ。」	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
142	Mir ist kalt.	私は寒い。	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
143	Mir ist schlecht.	私は気持ちが悪い。	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
144	Mir ist schwindlig.	私はめまいがする。	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
145	Mein Sohn kann Geige spielen.	うちの息子はバイオリンが弾ける。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
146	Ich kann nicht gut schlafen.	私はよく眠れない。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
147	Kannst du noch ein Stück Kuchen essen?	君，ケーキもう一つ食べられる？	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
148	Ich muss langsam nach Hause fahren.	私はそろそろ家に帰らないといけない。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
149	Sie müssen viele Mails schreiben.	あなたはメールをたくさん書かないといけない。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
150	Das ist aber komisch. Ich muss lachen.	それはおかしい。笑わずにはいられないよ。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
151	Ich muss heute in die Stadt.	私は今日，町に出ないといけない。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
152	Hanna kann gut Französisch.	ハンナはフランス語がよくできる。	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
153	Was wollt ihr in den Ferien machen?	君たちは休みに何をするつもりなの。	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
154	Ich will unbedingt einen Hund haben.	私はどうしても犬を飼いたい。	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
155	Heute möchte ich zu Hause bleiben.	今日は家にいたい。	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
156	Wollen Sie bitte Platz nehmen?	(椅子に)座りませんか？	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
157	Wollen wir am Wochenende in die Berge fahren?	週末に山に行かない？	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
158	Möchtest du mit uns Fußball spielen?	一緒にサッカーしない？	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
159	Wir wollen ans Meer.	私たちは海に行くつもりだ。	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
160	Ich möchte zum Geburtstag ein Sportrad.	僕は誕生日にスポーツバイクが欲しい。	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
161	Die Schüler mögen ihren Lehrer sehr.	生徒たちは先生が大好きだ。	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
162	„Magst du Möhren?“ „Nein, Möhren mag ich nicht.“	「ニンジン好き？」「ニンジンは嫌い。」	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
163	Er will Jura studieren.	彼は法学を専攻するつもりだ。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
164	Er soll Jura studieren.	彼は法学を専攻するべきだ。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
165	Ich soll um 5 Uhr vor dem Bahnhof sein.	私は5時に駅前にいるように言われている。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
166	Der Chef sagt: „Herr Berg soll sofort kommen.“	上司が言う:「ベルクさんをすぐに来させなさい。」	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
167	Wann sollen wir zu Ihnen kommen?	私たちはいつお邪魔したらいいですか？	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1704	Das alte Haus wurde abgerissen.	その古い家は取り壊された。	\N		\N	vmod	\N	\N	\N	0	1
168	Die Autofahrer sollen die Verkehrsregeln beachten.	運転者は交通規則を守るべきだ。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
169	Er soll sehr sehr reich sein.	彼はとてもお金持ちだそうだ。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
170	Jetzt dürft ihr das Computerspiel machen.	今度はコンピューターゲームをしていいよ。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
171	Nach dem Examen darf man faul sein.	試験の後はのんびりしていてもいい。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
172	Du darfst nicht ins Kino gehen.	君は映画に行ってはいけないよ。	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
173	Hier darf man nicht rauchen.	ここで喫煙をしてはいけない。（＝ここは禁煙だ）	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
174	Wir werden nächste Woche in Urlaub fahren.	私たちは来週休暇旅行に行く予定だ。	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
175	Ich werde es nie vergessen.	私はそれを決して忘れないでしょう。	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
176	Du wirst nie wieder so viel Glück haben!	君はこんな幸運に見舞われることは二度とないよ。	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
177	Ende März fliege ich nach Deutschland.	３月末に私はドイツに行きます。	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
178	In drei Stunden bin ich mit der Arbeit fertig.	私は３時間後に仕事は終わっているよ。	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
179	Sie zieht bald nach Osaka um.	彼女はまもなく大阪へ転居する。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
180	Wann zieht sie nach Osaka um?	彼女はいつ大阪へ転居する。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
181	Zieht sie bald nach Osaka um?	彼女はまもなく大阪へ転居するの。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
182	Sie muss bald nach Osaka umziehen.	彼女はまもなく大阪へ転居しないといけない。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
183	Wir fahren morgen sehr früh ab.	私たちは明日とても早く出発する。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
184	Wann kommt dieser Zug in Köln an?	この列車は何時にケルンに着きますか？	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
185	Ich höre mit dem Rauchen auf.	私は喫煙をやめる。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
186	Geht ihr heute Abend aus?	君たち今晩外出するの？	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
187	Das Kind schläft immer schnell ein.	その子はいつも寝入るのが早い。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
188	Meine Eltern gehen jeden Tag spazieren.	私の両親は毎日散歩している。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
189	Wer nimmt am Ausflug teil?	誰が遠足に参加するの？	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
190	Wir müssen in Köln umsteigen.	私たちはケルンで乗り換えないといけない。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
191	Die Sonne geht bald unter.	太陽がまもなく沈む。	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
192	Hast du schon etwas vor?	もう何か予定している？	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
193	Am Sonntag besuchen sie ihre Großeltern.	日曜に彼らは祖父母のところに遊びに行く。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
194	Er beantwortet die Frage.	彼はその質問に答える。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
195	Dieses Fahrrad gefällt mir sehr.	この自転車はとても気に入った。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
196	Dieses Auto gehört meinem Vater.	この車は父のものだ。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
197	Dieses Wörterbuch kann ich Ihnen empfehlen.	この辞書ならあなたに薦められます。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
198	Kannst du diesen Fleck aus der Jacke entfernen?	この上着の汚れ落とせる？	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
199	Ich erkenne ihn an seiner Stimme.	私は声で彼だとわかる。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
200	Du sollst ein Handwerk erlernen.	お前は手に職をつけるべきだ。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
201	Ich kann diesen Satz nicht verstehen.	私はこの文が理解できません。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
202	Ich muss meinen Aufsatz noch verbessern.	作文をもっと良く書き直さないと。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
203	Das Glas fällt auf den Boden und zerbricht.	グラスが床に落ちて砕ける。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
204	Er umfährt das Stadtzentrum.	彼は町の中心部を迂回する。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
205	Er fährt ein Verkehrsschild um.	彼は交通標識を轢き倒す。	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
206	Bevor ich abreise, muss ich noch vieles erledigen.	私は出発する前にまだ多くのことを片付けなければならない。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
207	Ich hoffe, dass wir morgen schönes Wetter haben.	私は明日良い天気になることを期待している。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
208	Ich fahre mit dem Bus zur Uni, wenn es stark regnet.	雨が強いときはバスで大学へ行く。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
209	Yuta kommt nicht zur Party, weil er morgen eine Prüfung hat.	ユウタは明日試験があるからパーティーには来ない。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
210	Yuko kommt zur Party, obwohl sie morgen eine Prüfung hat.	ユウコは明日試験があるのにパーティーに来る。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
211	Da er morgen eine Prüfung hat, muss er heute viel lernen.	彼は明日試験があるので今日はたくさん勉強しないといけない。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
212	Da ist meine Brille!	あっ，そこに僕の眼鏡があった。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
213	Wir müssen schon gehen, damit wir den Zug nicht verpassen.	列車に遅れないために，もう行かないと行けない。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
214	Er nimmt ein Messer. Und damit schneidet er ein Stück Käse ab.	彼はナイフを取り出す。そしてそれでチーズを一かけら切り取る。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
215	Während sie die Wäsche wäschst, bereitet er das Mittagessen.	彼女が洗濯する間に彼が昼食を準備する。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
216	Während des Essens sprechen die Kinder sehr laut.	食事の間，子供たちは大声でしゃべる。	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
217	Ich weiß noch nicht, wann du kommst?	僕はまだ君がいつ来るのか知らない。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
218	Ich weiß noch nicht, wo du wohnst.	僕はまだ君がどこに住んでいるのか知らない。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
219	Ich weiß noch nicht, wer Deutsch lernt.	僕はまだ誰がドイツ語を勉強するのかしらない。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
220	Ich weiß noch nicht, was du heute machen willst.	僕はまだ君が今日は何をしたいのか知らない。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
221	Ich verstehe nicht, warum du so lachst.	僕は君がなんでそなふうに笑うのか分からない。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
222	Ich möchte wissen, wie du Deutsch lernst.	僕は君がどうやってドイツ語を勉強しているのか知りたい。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
223	Ich weiß noch nicht, ob ich nach Wien fahre.	僕はまだウィーンに行くかどうかわからない。	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
224	[Ich bleibe zu Hause], denn [das Wetter ist schlecht].　(=(4))		null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
225	Er liest die Zeitung. Seine Frau sieht die Nachrichten.	彼は新聞を読んでいる。彼の妻はニュースを見ている。(←(1))	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
226	Ich bleibe zu Hause. Das Wetter ist schlecht.	私は家に居る。天気がわるい。 (←(4))	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
227	Er wartet schon lange.	彼はもう長い間待っている。（現在形）	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
228	Er wartete schon lange.	彼はもう長い間待っていた。（過去形）	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
229	Wir haben heute Deutsch gelernt.	私たちは今日ドイツ語を学んだ。	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
230	Deutsch wird auch in Japan gelernt.	ドイツ語は日本でも学ばれている。	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
231	Ich habe den Koffer schon gepackt.	私はもうスーツケースの荷造りをした。	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
232	Gestern abend kam ich um 11 Uhr nach Hause. Da las meine Frau die Zeitung.	昨夜私は11時に帰宅した。妻は新聞を読んでいた。	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1705	Die Hose passt gut.	このズボンはぴったり合う。	\N		\N	vmod	\N	\N	\N	0	1
233	Ich bin müde, weil ich ganz intensiv gearbeitet habe.	僕はすごく集中して働いたので疲れた。	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
234	Ich habe es ganz vergessen.	「私はそれを忘れる」の現在完了形	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
235	Ich hatte es ganz vergessen.	「私はそれを忘れる」の過去完了形	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
236	Nachdem sie das Buch gelesen hatte, fuhr sie nach Hause.	その本を読んだ後で彼女は家に帰った。	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
237	Sie wird wohl krank gewesen sein.	彼女はたぶん病気だったのだろう。（過去の推量）	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
238	Sie wird wohl krank sein.	彼女はたぶん病気なのだろう。（現在の推量）	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
239	Sie hat diesen Brief lesen müssen.		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
240	Ich habe in die Stadt gemusst.	私は町へ行かねばならなかった。（現在完了形）	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
241	Ich muss in die Stadt.	私は町へ行かねばならない。（現在形）	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
242	Ich habe in die Stadt fahren müssen.	私は町へ行かねばならなかった。（現在完了形）	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
243	Ich muss in die Stadt fahren.	私は町へ行かねばならない。（現在形）	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
244	das gute Fußballer	その上手なサッカー選手（付加語的用法）	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
245	Der Fußballer ist sehr gut.	そのサッカー選手はとても上手い。（述語的用法）	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
246	Der Fußballer spielt sehr gut.	そのサッカー選手はとても上手くプレーする。（副詞的用法）	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
247	Guten Morgen/Tag/Abend!	おはよう／今日は／今晩は！	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
248	Gute Nacht!	おやすみ！	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
249	Schönes Wochenende!	楽しい週末を！	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
250	Gute Reise!	楽しい旅行を！	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
251	Schöne Ferien!	楽しい休暇を！	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
252	Es freut mich sehr, Sie kennen zu lernen.	お近づきになれてとてもうれしいです。	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
253	Es ist sehr leicht, mit dem Rauchen aufzuhören. Ich habe schon zehnmal aufgehört.	喫煙を止めるのはとても簡単だ。僕はもう10回も止めたことがあるよ。	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
254	Darf ich Sie bitten, etwas langsamer zu sprechen?	少しゆっくり話すようお願いしていいですか？	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
255	Er hat mir versprochen, das Geld heute zurückzugeben.	彼は私にお金を今日返すと約束した。	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
256	Ich habe nicht den Mut, meinem Freund die Wahrheit zu sagen.	私は恋人に本当のことを話す勇気はない。	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
257	Papa, wann hast du denn Zeit, mit mir Fußball zu spielen?	パパ，僕とサッカーする時間いったいいつあるの？	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
258	Ich bin schon richtig aufgeregt, sie endlich wiederzusehen.	彼女にやっと再会できることが僕は今からすごく楽しみだ。※d-モジュール	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
259	Der Prüfling war nicht fähig, auf die Fragen schlagfertig zu antworten.	受験者は質問に的確に答えることができなかった。	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
260	Sie besteht darauf, ein deutsches Auto zu kaufen.	彼女はドイツ車を買うことにこだわる。	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
261	Wie bist du darauf gekommen, nach Japan zu kommen?	どうして日本に来ることを思いついたの？	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
262	Ich habe viel zu tun.	私はたくさんすることがある。	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
263	Ich habe wenig zu tun.	私はあまりすることがない。	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
264	Ich habe heute zwei Briefe zu schreiben.	私は今日２通の手紙を書かなければならない。	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
265	Du hast zu gehorchen.	お前は言うことを聞かないといけないよ。	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
266	Sie brauchen dieses Buch nicht zu lesen.	あなたはこの本を読む必要はない。	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
267	Hast du schon angefangen, den Aufsatz zu schreiben?	もう作文書き始めた？	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
268	Das Fahrrad fängt an zu rosten.	自転車がさび始める。	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
269	Ich denke nur an mich.	私は自分のことばかり考えている。（再帰代名詞）	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
270	Du denkst nur an mich.	あなたは私のことばかり考えている。（人称代名詞）	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
271	Er denkt nur an sich.	彼は自分のことばかり考えている。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
272	Er denkt nur an ihn.	彼(X)は彼(Y)のことばかり考えている。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
273	Ich wasche mir die Hände.	私は[自分の]手を洗う。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
274	Ich wasche dem Kind die Hände.	私は子供の手を洗ってやる。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
275	Er kauft sich einen Computer.	彼は[自分に]パソコンを買う。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
276	Er kauft ihr einen Computer.	彼は彼女にパソコンを買ってやる。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
277	Die Schwestern verstehen sich gut.	その姉妹は互いによく理解し合っている。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
278	Wir haben uns doch letzte Woche erst gesehen, bei Claudia.	私たちは先週会ったばかりでしょ，クラウディアの家で。	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
279	Die Studenten freuen sich auf die Ferien.	学生達は休暇を楽しみにしている。	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
280	Ich interessiere mich nicht sehr für Politik.	私は政治にそれほど関心がありません。	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
281	Erinnerst du dich noch an deinen Kindergarten?	君はまだ幼稚園のことを覚えている？	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
282	Mein Mann ist beim Finanzamt beschäftigt.	夫は税務署に勤務している。	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
283	Kannst du dir vorstellen, wie schrecklich der Unfall war.	その事故がどんなにひどかったか想像できる？	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
284	Ich konnte mir nicht erlauben, meine Meinung zu sagen.	私は思い切って自分の意見を言うことができなかった。	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
285	In diesem Land gibt es viele Arbeitslose.	この国にはたくさん失業者がいる。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
286	Sie hat einen Deutschen geheiratet.	彼女はドイツ人と結婚した。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
287	Meine Mutter war früher Angestellte.	母は以前会社員だった。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
288	Der Bahnhof war mit Reisenden überfüllt.	駅は旅行者であふれていた。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
289	„Ja, ich suche einen kleinen Terminkalender fürs nächste Jahr.“	「はい，来年用の小さな手帳を探しているんです。」 	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
290	  „Moment ... nein, tut mir Leid, es ist wirklich der letzte.“	「ちょっとお待ちください．．．申し訳ありません，これが本当に最後の［手帳］です。」	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
291	Alles Gute!	お元気で！	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
292	Und, was gibt's Neues?	それで，何か変わったことあったの？ ［会話22］	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
293	Denken Sie an was Spezielles?	何かお決まりのものをお探しです（＜何か特定のものをお考えですか）？［会話29］	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
294	Wir übersetzen den Satz aus dem Deutschen ins Japanische.	私たちはその文をドイツ語から日本語に訳す。	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
295	Da wohnt nämlich mein Onkel, den besuche ich jedes Jahr.	というのも，そこにおじさんが住んでるから，その人のところに毎年行くんだ。［会話20］	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
296	Und den Roman hast du auch! Den wollte ich schon lange mal lesen.	この小説もあるのね。これずっと前から読みたかったんだ。	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
329	Die Zeitschrift wird von vielen Studenten gelesen.	その雑誌は多くの学生に読まれている。	null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
297	Sie können bis zu zehn Bücher ausleihen.Wollen Sie die hier ausleihen?	10冊まで借りられますよ。この本，貸し出しですか（＜借り出したいですか）？［会話13］	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
298	„Ich glaube, Sie haben Ihr Portemonnaie vergessen.“	お財布を忘れませんでしたか？	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
299	„Ich, mein Portemonnaie?!“ 	僕が，財布を？	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
300	„Ja, ist das nicht Ihres?“	これ，あなたのではないでしょうか？	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
301	„Oh, ja! Das ist meins.“	あっ，本当だ。僕のです。	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
302	„Ja, wir kriegen dieses Jahr auch keine neuen Kalender mehr rein.“	はい，今年は新しいダイアリーの入荷も終わりましたので。	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
303	„Hm, tja, na gut, dann nehme ich eben diesen.“	そうですか，まあ，いいか，じゃあこれください。	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
304	Ich brauche einen größeren Teller.	私はもっと大きい皿が必要だ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
305	Das ist der größte Teller.	これが一番大きいお皿なんだ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
306	Hast du eine tiefere Schüssel für den Salat?	サラダ用のもっと深いボウルある？	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
307	Das ist die tiefste Schüssel.	これが一番深いボウルなんだ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
308	Ich brauche ein schärferes Messer.	私はもっと切れる包丁が必要だ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
309	Das ist das schärfste Messer.	これが一番切れる包丁なんだ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
310	Habt ihr keine kleineren Gläser?	もっと小さいグラスはないの？	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
311	Das sind die kleinsten Gläser.	これが一番小さいグラスなんだ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
312	Du hast mehr Bücher als ich.	君は僕よりたくさん本を持っている。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
313	Er hat weniger Haar als du.	彼の髪の毛は君より少ないよ。	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
314	Er ist klüger, als du denkst.	彼は君が思っているよりも賢いよ。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
315	Der Unfall war viel schlimmer, als ich es mir vorgetellt hatte.	その事故は私が想像していたよりもはるかにひどかった。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
316	Es ist besser, mit Freunden Bier zu trinken, als allein zu Hause zu sitzen.	友達とビールでも飲む方が一人で家にいるよりも良い。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
317	Er ist als Verleger erfolgreicher denn als Dichter.　	彼は詩人としてよりも出版人として成功している。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
318	○Die Kirschen sind jetzt am billigsten. / ×Die Kirschen sind jetzt die billigsten.　サクランボは今が一番安い。	サクランボは今が一番安い。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
319	Franz ist der größte Schüler in der Klasse.	フランツはクラスで一番背が高い生徒だ。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
320	Hanna ist die größte [Schülerin] in der Klasse.	ハンナはクラスで一番背が高い[女生徒だ]。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
321	Die Prüfung zu bestehen, ist jetzt das wichtigste.	試験に受かることが今は最も重要だ。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
322	Die Prüfung zu bestehen, ist jetzt am wichtigsten.	試験に受かることが今は最も重要だ。	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
323	Geh lieber gleich zum Arzt!	すぐ医者に行った方がいいよ！	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
324	Eher will ich sterben als ihn heiraten.	彼と結婚するくらいならむしろ死んでしまいたい。	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
325	Sie sollten sich mehr schonen.	あなたはもっと自分をいたわるべきでしょう。	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
326	Hier wird bald eine Grundschule gebaut.	ここにもうすぐ小学校が建てられる。	null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
327	Die Grundschule wurde vor einem Jahr gebaut.	小学校は１年前に建てられた。	null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
328	Der Tisch wurde gedeckt und das Essen wurde aufgetragen.	テーブルに食器が並べられ，食事が運ばれてきた。	null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
330	Wissen Sie, wann hier eine Grundschule gebaut wird?	いつここに小学校が建てられるかご存知ですか。	null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
331	Er behauptet, dass die Zeitschrift von vielen Studenten gelesen wird. 	その雑誌は多くの学生に読まれていると彼は主張する。	null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
332	Die Bankräuber sind gestern festgenommen worden.	銀行強盗は昨日逮捕された。	null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
333	Der Brand ist schnell gelöscht worden.	火事はすぐに消化された。	null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
334	Ist mein Fahrrad noch nicht repariert worden?	僕の自転車はまだ修理されていないの？	null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
335	In der Zeitung steht, dass die Bankräuber festgenommen worden sind.	銀行強盗が逮捕されたと新聞に出ている。	null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
336	Ich habe gehört, dass der Brand schnell gelöscht worden ist.	火事はすぐに消化されたって聞いたよ。	null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
337	Der Patient kann noch gerettet werden.	その患者はまだ救うことができる。	null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
338	Der Bankräuber wird in drei Tagen festgenommen worden sein.	銀行強盗は3日後には逮捕されているだろう。	null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
339	Der Bankräuber wird schon festgenommen worden sein.	銀行強盗はすでに逮捕されているだろう。	null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
340	Die Eltern verwöhnen Gisela sehr.	両親はギーゼラをとても甘やかしている。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
341	Gisela wird von den Eltern sehr verwöhnt.	ギーゼラは両親にとても甘やかされている。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
342	Die Abgeordneten kritisierten den Minister heftig.	議員達は大臣を激しく批判した。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
343	Der Minister wurde von den Abgeordneten heftig kritisiert.	大臣は議員達から激しく批判された。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
344	Ein Freund hat ihn über den Unfall unterrichtet.	友達が彼にその事故について知らせた	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
345	Er ist durch einen Freund über den Unfall unterrichtet worden.	彼は友達からその事故について知らされた。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
346	Ich hab’ gestern chinesischen Tee geschenkt bekommen.	昨日中国茶をもらったの。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
347	Ein Freund hat mir gestern chinesischen Tee geschenkt.	友達が私に昨日中国茶をくれたの。	null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
348	Auf der Party wurde gelacht und gesungen.	パーティーでは笑って歌った。	null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
349	In dieser Zeit wird hart gearbeitet und ordentlich verdient.	この時期にはしっかり仕事してたっぷり稼ぐ。（観光地のホテルの話）	null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
350	Es wird gefeiert, es wird gesungen, es wird geweint. Junge Menschen steigen auf die Mauer und tanzen.	祝って，歌って，泣いている。若者たちは壁に登って踊っている。（ベルリンの壁開放の時の様子）	null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
351	Ob in Vietnam, in Palestina, in Tschetschenien oder im Irak überall wurde und wird gestorben.	ヴェトナム，パレスチナ，チェチェンそれにイラクと，いたるところで人が死んでいったし死んでいる。	null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
352	Das Fahrrad ist schon repariert.	自転車はもう修理してある。（状態受動）	null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
353	Seine Schuhe sind blank geputzt.	彼の靴はぴかぴかに磨いてある。（状態受動）	null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
354	Sie ist sofort eingeschlafen.	彼女はすぐに寝入った。（現在完了形）	null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
355	Wir sind nach Heidelberg gefahren.	私たちはハイデルベルクへ行った。（現在完了形）	null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
356	Ja, ich denke an so einen kleinen Taschenkalender, der aber trotzdem für jeden Tag eine Seite hat.	ええと，これくらいの小さなダイアリーで，毎日で１ページになっているものがほしい（＜を考えている）んですけど。［会話29］	null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
357	Ein Ziegelhaus ist weitaus trockener als ein Haus, das aus anderen Materialien errichtet wird.	レンガの家は他の素材で建てる家よりもはるかに乾燥している。	null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
358	Mein Vater arbeitet bei einer Firma, die eng mit Toyota zusammenarbeitet.	父はトヨタと提携している会社で働いている。	null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
359	Viele Frauen, die ihren Beruf nicht aufgeben wollen, machen sich Gedanken, wie sie alles schaffen werden.	仕事を辞めたくない多くの女性はどうしたらそうできるか考えている。	null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
360	Mein Vater, der jetzt in Berlin arbeitet, ruft uns selten an.	今ベルリンで仕事をしている父は家にめったに電話をしてくれない。	null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
361	Die Touristen, die diese alte Stadt kennen, besuchen sie immer wieder.	この古都に来たことがある旅行者はここをくりかえし訪れる。	null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
362	Die Aufgaben, die unser Lehrer uns gibt, sind sehr schwierig.	先生が私たちに出す課題はとても難しい。	null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
363	Es gibt Menschen, denen nie jemand glaubt, obwohl sie die Wahrheit sprechen.	真実を言っても決して信じてもらえない人がいる。	null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
364	Mein Lehrer, bei dem ich Deutsch gelernt habe, ist in Rente gegangen.	ドイツ語を習った（＜その人のもとで私がドイツ語を勉強した）先生は定年退職した。	null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
365	Das Auto, mit dem wir nach Italien fahren wollten, hat eine Panne bekommen.	［それで］イタリアに行こうと思っていた車が故障した。	null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
366	Wir möchten euch hier Hotels vorstellen, in denen wir übernachtet haben.	ここでは皆さんに私たちが泊まったことのあるホテルを紹介したいと思います。	null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
367	Wer nicht arbeitet, soll auch nicht essen.	働かざる者，食うべからず。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
368	Wen man nicht sieht, vergisst man leicht.	会わなくなった人はすぐに忘れる。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
369	Wem nicht zu raten ist, dem ist auch nicht zu helfen.	助言を受けない人は助けることもできない。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
370	Wessen er immer gedenkt, ist seine Mutter.	彼がいつも思い出す人はお母さんだった。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
371	Das ist alles, was ich erzählen kann.	これが私に話せることのすべてです。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
372	Das ist das Beste, was ich tun kann.	これが私にできる最善のことです。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
373	Oh, das ist aber ganz schön viel, was wir da machen müssen.	えー，それじゃ，やらなきゃいけない事が多すぎますよ。［会話31］	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
374	Leipzig ist eine Stadt, wo man die Veränderung vom Kommunismus in den Kapitalismus sehen kann.	ライプツィッヒは共産主義から資本主義への変化を目で見ることができる都市だ。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
375	Leipzig ist eine Stadt, in der man die Veränderung vom Kommunismus in den Kapitalismus sehen kann.	ライプツィッヒは共産主義から資本主義への変化を目で見ることができる都市だ。	null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
376	Wenn ich genug Geld hätte, würde ich nicht mehr arbeiten.	もし十分なお金があったら，もう働かないだろうに。	null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
378	Martin sagte, seine Frau komme morgen nach Japan.	マルティーンは，奥さんが明日日本に来ると言った。（kommeは接続法１式）	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
379	Martin sagte, seine Kinder kämen morgen nach Japan.	マルティーンは，子供たちが明日日本に来ると言った。（接続法１式kommenは直説法現在形と同じ形なので接続法２式kämenを使っている）	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
380	Damals glaubte man, die Sonne laufe um die Erde.	当時人々は太陽が地球の周りを回ると信じていた。 	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
381	Sie sagte, er habe sich ein Auto gekauft.	彼女は［彼が車を買った］と言った。	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
382	Sie sagte, er kaufe sich ein Auto.	彼女は彼が車を買うと言った。	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
383	Er sagt, sie sei krank gewesen.	彼は［彼女は病気だった］と言っている。	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
384	Er sagt, sie sei krank.	彼は［彼女は病気だ］と言っている。	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
385	Der Arzt sagte, dass meine Frau um 7:45 verstarb.	医者は，私の妻が7時45分に死亡したと言った。	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
386	Der Hals-Nasen-Ohren Arzt sagte, meine Ohren an sich sind in Ordnung.	耳鼻咽喉科医は，私の耳そのものは正常だと言った。	null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
422	Wo wohnst du?	どこに住んでいるの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
1918	Ich finde sie zu dünn.	彼女は痩せすぎだと思う。	\N		\N	vmod	\N	\N	\N	0	1
387	Könnte ich mein Leben nochmals leben, dann würde ich das nächste Mal riskieren, mehr Fehler zu machen.	人生をもう一度生きられるとしたら，今度は思い切ってもっとたくさん失敗をしてやろう。	null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
388	Wenn ich das doch nur nicht gesagt hätte!	あんなこと言わないでおけばよかったなあ。	null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
389	Hätte ich das doch nur nicht gesagt!	あんなこと言わないでおけばよかったなあ。	null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
390	Ich hätte heute schon beinahe einen Unfall verursacht!	今日はあやうく事故を起こすところだったよ。	null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
391	Um ein Haar hätte ich den wichtigen Termin vergessen!	もう少しで大事なアポイントメントを忘れるところだったよ。	null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
392	Aber ... na ja, du hättest ja auch später kommen können!	でも，遅れて来てもよかったのに。	null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
393	Aber ... du hättest uns doch mindestens anrufen können.	でもせめて電話ぐらいしてくれたらよかったのに。［会話26］	null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
394	Und welche Preislage sollte es sein?	ご予算はおいくらぐらいでしょうか？	null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
395	Hättest du nicht Lust, da auch mal mitzumachen?	あなたも一緒にする気ない？［会話20］	null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
396	Allerdings bräuchte ich dafür ein Empfehlungsschreiben.	ただ，そのためには推薦状が必要なんですが。［会話27］	null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
397	Wie wär' s dann mit japanischer Literatur?	それなら日本文学とかはどう？［会話28］	null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
398	Sie promoviert jetzt in Heidelberg und würde gern im nächsten Semester an unserem Seminar teilnehmen.	今ハイデルベルクで博士論文を書いていて，来学期，先生のゼミに参加したいそうです。［会話40］	null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
399	Du sprichst so, als hättest du nichts davon gehört.	君はそのことをまるで聞いていないみたいな言い方をするね。	null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
400	Ich lerne Deutsch.	私はドイツ語を勉強する。	null	ttt	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
401	Sie lernen Englisch.	あなたは英語を勉強する。	null	ttt	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
402	Wir lernen Chinesisch.	私たちは中国語を勉強する。	null	ttt	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
403	Sie lernen Französisch.	あなたたちはフランス語を勉強する。	null	ttt	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
404	Ich lerne Deutsch.	私はドイツ語を勉強する。	null	ttt	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
405	Du lernst Englisch.	君は英語を勉強する。	null	ttt	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
406	Wir lernen Chinesisch.	私たちは中国語を勉強する。	null	ttt	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
407	Ihr lernt Französisch.	君たちはフランス語を勉強する。	null	ttt	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
408	Er lernt Deutsch.	彼はドイツ語を勉強する。	null	ttt	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
409	Sie lernt Japanisch.	彼女は日本語を勉強する。	null	ttt	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
410	Sie lernen Englisch.	彼ら/彼女たちは英語を勉強する。	null	ttt	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
411	Hans trinkt heute Rotwein.	ハンスは今日赤ワインを飲む．	null	ttt	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
412	Heute trinkt Hans Rotwein.	今日ハンスは赤ワインを飲む．	null	ttt	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
413	Rotwein trinkt Hans heute.	赤ワインをハンスは今日飲む．	null	ttt	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
414	Hans trinkt Rotwein, aber Hanna trinkt Weißwein.	ハンスは赤ワインを飲む。でもハンナは白ワインを飲む。	null	ttt	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
415	Kommt er heute?	彼は今日来るの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
416	Ja, er kommt heute.	うん，来るよ。	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
417	Nein, er kommt heute nicht.	いいや，来ないよ。	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
418	Kommt er heute nicht?	彼は今日来ないの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
419	Doch, er kommt heute.	いいや，来るよ。	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
420	Nein, er kommt heute nicht.	うん，来ないよ。	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
421	Wann kommst du?	いつ来るの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
423	Wer lernt Deutsch?	だれがドイツ語を勉強するの？ 	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
424	Was machst du heute?	今日は何をするの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
425	Warum lachst du?	どうして笑っているの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
426	Wie lernst du Deutsch?	どのようにドイツ語を勉強しているの？	null	ttt	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
427	Sind Sie Japaner?	あなたは日本人ですか？（男性に対して）	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
428	Ja, ich bin Japaner.	はい，私は日本人です。	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
429	Bist du Studentin?	君，大学生？（女性に対して）	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
430	Ja, ich bin Studentin.	うん，大学生だよ。	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
431	Sind sie Deutsche?	あの人たちはドイツ人なの？	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
432	Nein, er ist Italiener und sie ist Französin.	いや，彼はイタリア人，彼女はフランス人だ。	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
433	Draußen ist es sehr kalt.	外はとても寒い。	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
434	Sind Sie glücklich?	あなたたちは幸せですか？	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
435	Ja, wir sind sehr glücklich.	はい，私たちはとても幸せです。	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
436	Seid ihr traurig?	君たち，悲しいの？	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
437	Nein. wir sind nur müde.	いいや，疲れているだけだよ。	null	ttt	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
438	Haben Sie heute Zeit?	あなたは今日時間がありますか？	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
439	Ja, ich habe heute Zeit.	はい，あります。	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
440	Hast du heute Deutsch?	君，今日ドイツ語の授業ある？	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
441	Nein, aber ich habe heute Englisch.	ないよ，でも今日は英語がある。	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
442	Er hat Geld und sie hat auch Geld.	彼はお金を持っているし，彼女もお金を持っている。	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
443	Haben sie auch Zeit?	彼らは時間もあるのかな？	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
444	Haben Sie Reiswein?	（お店で）日本酒ありますか？ 	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
445	Ja, wir haben Reiswein.	はい，ありますよ。	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
446	Habt ihr Kinder?	君たち，子供はいるの？	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
447	Ja, wir haben zwei Kinder.	はい，二人います。	null	ttt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
448	Werden Sie Lehrer?	あなたは先生になるのですか？（男性に対して）	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
449	Ja, ich werde Lehrer.	はい，先生になります。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
450	Wirst du Lehrerin?	君は，先生になるの？（女性に対して）	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
451	Nein, ich werde Dolmetscherin.	ううん，通訳になるの。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
452	Er wird Arzt und sie wird auch Ärztin.	彼は医者になり，彼女も医者になる。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
453	Es ist noch kalt, aber bald wird es warm.	まだ寒いけれど，もうすぐ暖かくなる。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
454	Wann werdet ihr Großeltern?	あなたたち，いつ孫ができる（祖父母になる）の？	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
455	Wir werden bald Großeltern.	私たちはもうすぐ祖父母になる。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
456	Ich hoffe, Sie werden bald wieder gesund.	あなた［たち］はもうすぐ治る（再び健康になる）と思います。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
457	Ich hoffe, sie werden bald wieder gesund.	彼らはもうすぐ治る（再び健康になる）と思います。	null	ttt	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
458	Der Vater kocht. Und die Mutter und das Kind essen.	父が料理をする。そして母と子供が食べる。	null	ttt	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
459	Die Väter kochen. Die Mütter und die Kinder essen.	父親たちが料理をする。母親たちと子供たちが食べる。	null	ttt	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
460	Der Vater kocht gern.	父は料理が好きだ。	null	ttt	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
461	der Beruf des Vaters	父の職業	null	ttt	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1706	Er hat sich beim Spielen den Arm gebrochen.	彼は試合中に腕を折ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
462	Die Tochter dankt dem Vater.	娘は父に感謝する。	null	ttt	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
463	Die Mutter liebt den Vater.	母は父を愛している。	null	ttt	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
464	Die Tochter hilft dem Vater.	娘は父を手伝う。	null	ttt	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
465	Die Mutter fragt den Vater.	母は父に尋ねる。	null	ttt	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
466	„Wo ist das Buch?“ „Das Buch ist hier.“	「本はどこ？」「本はここにあるよ。」	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
467	Peter kauft bald ein Auto.	ペーターはもうすぐ車を買うよ。	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
468	Peter kauft bald das Auto.	ペーターはもうすぐ（あの）車を買うよ。	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
469	Peter kauft heute ein Buch.	ペーターは今日（ある１冊の）本を買う。	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
470	Peter kauft heute △ Bücher.	ペーターは今日（何冊かの）本を買う。	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
471	Peter kauft heute die Bücher.	ペーターは今日（あの数冊の）本を買う。	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
472	Ein Schüler fragt den Lehrer.	ある生徒が先生に質問する． 	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
473	Ich helfe einem Schüler	私はある生徒を手伝う． 	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
474	Wir haben einen Sohn	私たちには息子がひとりいる． 	null	ttt	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
475	Er kommt heute nicht.	彼は今日来ない。（別の日については何も言っていない）	null	ttt	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
476	Er kommt nicht heute.	彼は今日は来ない（が，別の日に来る）。	null	ttt	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
477	Wir fahren morgen nach Berlin.	私たちは明日ベルリンへ行く。	null	ttt	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
478	Er fährt übermorgen nach München.	彼は明後日ミュンヒェンへ行く。	null	ttt	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
479	Wir sprechen Deutsch.	私たちはドイツ語を話す。	null	ttt	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
480	Sprichst du auch Deutsch?	君もドイツ語を話すの？	null	ttt	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
481	Kazuya fährt mit dem Fahrrad um den See.	カズヤは自転車で湖の周りを走る。	null	ttt	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
482	Trotz des Regens spielen die Kinder im Garten.	雨なのに子供たちは庭で遊ぶ。	null	ttt	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
483	Statt meines Vaters kommt mein Onkel.	父の代わりにおじが来ます。	null	ttt	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
484	Trotz des Regens machen sie einen Spaziergang.	雨なのに彼らは散歩をする。	null	ttt	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
485	Er schläft während des Unterrichts.	彼は授業中に眠る。	null	ttt	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
486	Wegen der Erkältung kommt sie nicht.	風邪のために彼女は来ない。	null	ttt	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
487	Sie nimmt ein Buch aus der Tasche.	彼女はバッグから本を取り出す。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
488	Das Hotel ist gleich beim Bahnhof.	ホテルは駅のすぐ近くにある。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
489	Die Schule liegt gegenüber dem Friedhof.	学校は墓地の向かいにある。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
490	Der Lehrer diskutiert mit den Schülern.	先生は生徒たちと議論する。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
491	Nach dem Abendessen sehe ich einen Film.	夕食の後，私は映画を見る。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
492	Die Lehrerin ist seit dem Sonntag krank.	先生は日曜日から病気だ。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
493	Er bekommt von dem Japaner einen Brief.	彼はその日本人から手紙をもらう。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
494	Er geht zu dem Professor.	彼はその教授のところに行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
495	Die Kinder gehen zur Schule.	子供たちは学校に行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
496	Die Kinder gehen zu der Schule.	子供たちはその学校に行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
497	Er fährt zum Bahnhof.	彼は駅に行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
498	Er fährt zu dem Bahnhof.	彼はその駅に行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
499	Ich wohne bei meinem Onkel.	私はそのおじさんの家に住んでいる。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
500	Sie arbeitet bei einer Bank.	彼女はある銀行で働いている。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
501	Dem Bahnhof gegenüber ist ein Kaufhaus.	駅の向かいにデパートがある。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
502	Die Kinder fahren mit dem Bus zur Schule.	子供たちはバスで学校に行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
503	Sie fährt mit dem Auto nach Berlin.	彼女は車でベルリンへ行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
504	Ich gehe zur Post und dann zum Kaufhaus.	私は郵便局に行き，それからデパートに行く。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
505	Die Lehrerin ist seit drei Tagen krank.	先生は３日前から病気だ。	null	ttt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
506	Das Fest dauert bis Sonntag.	祭りは日曜日まで続く。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
507	Der Zug fährt jetzt durch einen Tunnel.	列車は今トンネルを通っている。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
508	Den Fluss entlang stehen Kirschbäume.	川に沿って桜の木がある。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
509	Lernt ihr nur für die Prüfung?	君たちは試験のためにだけ勉強するの？	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
510	Das Auto fährt gegen den Wind.	車は向かい風で走っている。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
511	Sie trinkt Kaffee ohne Zucker.	彼女はコーヒーを砂糖なしで飲む。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
512	Um den Tisch stehen sechs Stühle.	テーブルの周りには椅子が６つ置いてある。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
513	Die Straßenbahn fährt bis zum Stadttor.	路面電車は市門まで行く。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
514	Der Zug fährt nur bis nach Bonn.	その列車はボンまでしか行かない。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
515	Wir bummeln durch die Stadt.	私たちは町をあちこち散歩する。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
516	Er erweitert seinen Gesichtskreis durch Reisen.	彼は旅を通じて視野を広げる。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
517	Ich miete das Zimmer für ein Jahr.	私はその部屋を１年の予定で借りる。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
518	Sind Sie für den Vorschlag?	あなたはその提案に賛成ですか？	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
519	Der Unterricht beginnt um 9 Uhr.	授業は９時に始まる。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
520	Wir bitten den Lehrer um Hilfe.	私たちは先生に手助けを頼む。	null	ttt	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
521	Welche Bluse passt zu diesem Rock?	どのブラウスがこのスカートに合う？	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
522	„Diese Bluse passt zu jedem Rock.“	「このブラウスならどのスカートにも合うよ。」	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
523	Sie arbeitet bei dieser Bank.	彼女はこの銀行で働いている。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
524	Welche Straßenbahn fährt zum Marktplatz?	どの路面電車が中央広場へ行きますか。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
525	Um jeden Tisch stehen sechs Stühle.	どのテーブルの周りにも椅子が６つ置いてある。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
526	Solche Fahrräder rosten schnell.	そういう自転車はすぐ錆びる。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
527	Alle Studenten bestehen diese Prüfung.	全ての学生がこの試験に受かる。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
528	Manche Kinder gehen zu einer Nachhilfeschule.	かなり多くの子供が塾に通っている。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
529	Seit jenem Unfall fährt er nicht mehr Auto.	あの事故以来彼は車を運転していない。	null	ttt	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
530	„Wo ist dein Computer?“ „Mein Computer? Ich habe keinen Computer.“	「君のパソコンはどこ？」「僕のパソコン？僕はパソコンを持ってないよ。」	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
531	Meine Schwester arbeitet bei dieser Bank.	私の姉はこの銀行で働いている。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
532	Ich kenne deinen Bruder.	君のお兄さんのこと知っているよ。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
533	Ihr Hotel ist gleich beim Bahnhof.	あなた［たち］のホテルは駅のすぐ近くです。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
534	Sind Sie für seinen Vorschlag?	あなた［たち］は彼の提案に賛成ですか？	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
535	Sie bittet ihren Lehrer um Hilfe.	彼女は［自分の］先生に手助けを頼む。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
536	Kein Student besteht diese Prüfung.	この試験に受かる学生はいない。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1707	Die Kinder setzen einen Hut auf.	子供たちは帽子をかぶる。	\N		\N	vmod	\N	\N	\N	0	1
537	Unsere Schule liegt gegenüber dem Friedhof.	学校は墓地の向かいにある。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
538	Eure Lehrerin ist seit Sonntag krank.	先生は日曜日から病気だ。	null	ttt	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
539	Die Studenten essen in der Mensa.	学生達は学食で食べる。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
540	Die Studenten gehen in die Mensa.	学生達は学食に行く。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
541	Ich hänge eine Pendeluhr an die Wand.	私は振り子時計を壁に掛ける。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
542	An der Wand hängt eine Pendeluhr.	壁には振り子時計が掛かっている。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
543	Am Sonntag fahren sie ans Meer.	日曜日に彼らは海［辺］に行く。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
544	Wir verbringen den Urlaub am Meer.	私たちは休暇を海辺で過ごす。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
545	Die Touristen steigen auf den Turm der Kirche.	観光客たちは教会の塔［の上］に登る。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
546	Auf dem Kirchturm machen sie eine Pause.	教会の塔の上で彼らは休憩する。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
547	Wie heißt das auf Deutsch?	これはドイツ語で何て言うの？	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
548	Das Buch fällt hinter das Regal.	本が本棚の後ろに落ちる。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
549	Das Buch liegt hinter dem Regal.	その本は本棚の後ろにある。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
550	Im Sommer reist sie nach Deutschland.	夏に彼女はドイツに旅行する。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
551	Er stellt den Drucker neben den Computer.	彼はプリンターをコンピューターの隣に置く。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
552	Der Drucker steht neben dem Computer.	プリンターはコンピューターの隣に置いてある。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
553	Sie hängt das Foto über den Schreibtisch.	彼女は写真を机の上［の壁］に掛ける。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
554	Das Foto hängt über dem Schreibtisch.	写真は机の上［の壁］に掛けてある。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
555	Die Schüler gehen hier über die Straße.	生徒たちはここで通りの向こう側へ渡る。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
556	Der Junge legt den Fußball unter den Tisch.	少年はサッカーボールを机の下に置く。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
557	Der Fußball liegt unter dem Tisch.	サッカーボールは机の下にある。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
558	Das Mädchen tritt vor den Spiegel.	少女は鏡の前へ歩み寄る。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	\N
559	Das Mädchen steht vor dem Spiegel.	少女は鏡の前に立っている。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	\N
560	Vor dem Abendessen macht er die Hausaufgaben.	夕食の前に彼は宿題をする。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	\N
561	Er stellt den Fernseher zwischen das Regal und den Schrank.	彼はテレビを本棚とタンスの間に置く。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	\N
562	Der Fernseher steht zwischen dem Regal und dem Schrank.	テレビは本棚とタンスの間に置いてある。	null	ttt	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	\N
563	 „Was schenkst du mir zum Geburtstag?“	「誕生日に何をくれるの？」	null	ttt	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
564	 „Ich schenke dir ein Auto.“	「自動車をあげるよ。」	null	ttt	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
565	 „Liebst du mich nicht? “	「僕のこと愛していないの？」	null	ttt	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
566	 „Nein, ich liebe dich nicht mehr. “	「うん，もうあなたのことは愛してないわ。」	null	ttt	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
567	 „Was schenkst du deiner Mutter?“	「お母さんに何を贈るの？」	null	ttt	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
568	 „Ich schenke ihr einen Schal.“	「スカーフを贈るよ。」	null	ttt	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
569	 „Liebst du ihn nicht?“	「彼のこと愛していないの？」	null	ttt	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
570	 „Nein, ich liebe ihn nicht mehr.“	「うん，もう彼のことは愛してないの。」	null	ttt	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
571	Er fragt Sie.	彼はあなたに尋ねる．	null	ttt	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
572	Ich danke Ihnen.	私はあなたに感謝します．	null	ttt	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
573	„Sind Sie mit dem Lehrer zufrieden?“	「先生に満足していますか？」	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1708	Ich habe gute Augen.	私は目が良い。	\N		\N	vmod	\N	\N	\N	0	1
574	„Ja, ich bin mit ihm zufrieden.“	「はい，［彼に］満足しています。」	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
575	„Sind Sie mit dem Unterricht zufrieden?“	「授業に満足していますか？」	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
576	„Ja, ich bin damit zufrieden.“	「はい，［それに］満足しています。」	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
577	Da drüben ist mein Auto und daneben ist das meines Vaters.	あそこに私の車があって，その隣に父のがある。	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
578	Sie nimmt eine Apfelsine und macht Saft daraus.	彼女はオレンジを取り，それでジュースを作る。	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
579	„Hier ist ein Päckchen für dich?“ „Was ist darin?“	「ここに君宛の小包が来ているよ。」「［その］中は何だろう？」	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
580	Da ist ein Kino und nicht weit davon ist eine Disko.	あそこに映画館がり，そこから遠くないところにディスコがある。	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
581	Der Film beginnt um acht Uhr. Davor kommt nur Werbung.	映画は8時に始まる。その前は広告だけだ。	null	ttt	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
582	Womit fahren Sie in die Stadt? Mit dem Bus oder mit der Straßenbahn?	あなたは何(なに)で町へ行きますか。バスですか市電ですか？	null	ttt	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
583	Worüber diskutiert ihr denn? Über die Umweltprobleme?	君たちは何について議論しているの？環境問題について？	null	ttt	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
584	Mit was fährt er nach Italien?	彼は何(なに)でイタリアへ行くの？	null	ttt	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
585	Gegen was sind Sie allergisch?	あなたは何に対してアレルギーなんですか？	null	ttt	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
586	Auf was wartest du noch?	君はまだ何を待っているの？	null	ttt	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
587	Antworte bitte sofort!	すぐに答えてよ。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
588	Geht schnell zur Schule!	はやく学校に行きなさい。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
589	Kommen Sie mal zu uns.	一度私たちの家に来て下さい。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
590	Sprich lauter!	もっと大きい声で話しなさい。※lauterはlautの比較級	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
591	Lies den Brief!	手紙を読みなさい。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
592	Werde doch bitte schnell wieder gesund!	どうか早く元気になってね。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
593	Sei brav!	行儀よくしなさい。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
594	Seid still!	静かにして。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
595	Seien Sie pünktlich!	時間を守りなさい。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
596	Nehmen Sie bitte Platz!	どうぞお掛けください。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
597	Warte mal hier!	ちょっとここで待っててね。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
598	Kommt doch zu uns!	ぜひうちに来なさいよ。	null	ttt	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
599	Es regnet jeden Tag.	毎日雨が降る。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
600	In dieser Gegend schneit es viel.	この地方では雪がたくさん降る。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
601	Es donnert und blitzt.	雷が鳴って稲妻が落ちる。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
602	Wie geht es Ihnen?	お元気ですか？（あなたは調子どうですか）	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
603	Vor dem Bahnhof gibt es zwei Kaufhäuser.	駅前にデパートが二つある。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
604	Heut ist es sehr kalt.	今日はとても寒い。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
605	In Japan ist es im Sommer sehr schwül.	日本では夏はとても蒸し暑い。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
606	„Wie spät ist es jetzt?“ -- „Es ist 8.20 Uhr.“	「今何時？」 -- 「8時20分だよ。」	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
607	Mir ist kalt.	私は寒い。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
608	Mir ist schlecht.	私は気持ちが悪い。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
609	Mir ist schwindlig.	私はめまいがする。	null	ttt	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
610	Mein Vater kann sehr gut kochen.	私の父はとても上手に料理ができる。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
611	Ich muss auch am Sonntag arbeiten.	私は日曜日にも仕事をしないといけない。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
612	Mein Sohn kann Geige spielen.	うちの息子はバイオリンが弾ける。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
613	Ich kann nicht gut schlafen.	私はよく眠れない。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
614	Kannst du noch ein Stück Kuchen essen?	君，ケーキもう一つ食べられる？	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
615	Ich muss langsam nach Hause fahren.	私はそろそろ家に帰らないといけない。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
616	Sie müssen viele Mails schreiben.	あなたはメールをたくさん書かないといけない。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
617	Das ist aber komisch. Ich muss lachen.	それはおかしい。笑わずにはいられないよ。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
618	Ich muss heute in die Stadt.	私は今日，町に出ないといけない。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
619	Hanna kann gut Französisch.	ハンナはフランス語がよくできる。	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
620	Ich kann Deutsch sprechen.	私はドイツ語が話せる．	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
621	Ich muss Geld für ein Auto sparen.	私は車を買うために貯金しなければ．	null	ttt	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
622	Sie will in Berlin Geschichte studieren.	彼女はベルリンで歴史を勉強するつもりだ。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
623	Ich möchte ein Glas Wein trinken.	私はワインを一杯飲みたい。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
624	Was wollt ihr in den Ferien machen?	君たちは休みに何をするつもりなの。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
625	Ich will unbedingt einen Hund haben.	私はどうしても犬を飼いたい。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
626	Heute möchte ich zu Hause bleiben.	今日は家にいたい。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
627	Wollen Sie bitte Platz nehmen?	(椅子に)座りませんか？	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
628	Wollen wir am Wochenende in die Berge fahren?	週末に山に行かない？	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
629	Möchtest du mit uns Fußball spielen?	一緒にサッカーしない？	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
630	Wir wollen ans Meer.	私たちは海に行くつもりだ。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
631	Ich möchte zum Geburtstag ein Sportrad.	僕は誕生日にスポーツバイクが欲しい。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
632	Die Schüler mögen ihren Lehrer sehr.	生徒たちは先生が大好きだ。	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
633	„Magst du Möhren?“ „Nein, Möhren mag ich nicht.“	「ニンジン好き？」「ニンジンは嫌い。」	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
634	Ich will Geschichte studieren.	僕は歴史を勉強するつもりだ．	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
635	Was möchtest du morgen machen?–– Ich möchte Fußball spielen.	明日，何したい？ -- サッカーがしたいな．	null	ttt	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
636	Soll ich das Fenster schließen?	窓を閉めましょうか？	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
637	Darf ich das Fenster schließen?	窓を閉めてもいいですか？	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
638	Er will Jura studieren.	彼は法学を専攻するつもりだ。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
639	Er soll Jura studieren.	彼は法学を専攻するべきだ。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
640	Ich soll um 5 Uhr vor dem Bahnhof sein.	私は5時に駅前にいるように言われている。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
641	Der Chef sagt: „Herr Berg soll sofort kommen.“	上司が言う:「ベルクさんをすぐに来させなさい。」	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
642	Wann sollen wir zu Ihnen kommen?	私たちはいつお邪魔したらいいですか？	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
643	Die Autofahrer sollen die Verkehrsregeln beachten.	運転者は交通規則を守るべきだ。 	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
644	Er soll sehr sehr reich sein.	彼はとてもお金持ちだそうだ。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
645	Jetzt dürft ihr das Computerspiel machen.	今度はコンピューターゲームをしていいよ。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
646	Nach dem Examen darf man faul sein.	試験の後はのんびりしていてもいい。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
647	Du darfst nicht ins Kino gehen.	君は映画に行ってはいけないよ。	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
648	Hier darf man nicht rauchen.	ここで喫煙をしてはいけない。（＝ここは禁煙だ）	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
649	Soll ich das Fenster öffnen.	窓をあけましょうか？ 	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
650	Darf ich das Fenster öffnen?	窓をあけてもいい？ 	null	ttt	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
651	Morgen wird es schneien.	明日は雪が降るでしょう。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
652	Taro ist nicht da. Er wird wohl krank sein.	太郎は来ていない。おそらく病気なのだろう。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
653	Er muss krank sein.	彼は病気に違いない。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
654	Der Bus kann jeden Augenblick kommen.	バスは今にでも来るかもしれない。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
655	Das kann nicht sein.	そんなことはあり得ない。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
656	Wir werden nächste Woche in Urlaub fahren.	私たちは来週休暇旅行に行く予定だ。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
657	Ich werde es nie vergessen.	私はそれを決して忘れないでしょう。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
658	Du wirst nie wieder so viel Glück haben!	君はこんな幸運に見舞われることは二度とないよ。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
659	Ende März fliege ich nach Deutschland.	３月末に私はドイツに行きます。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
660	In drei Stunden bin ich mit der Arbeit fertig.	私は３時間後に仕事は終わっているよ。	null	ttt	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
661	Muss ich heute zum Zahnarzt gehen?	私は今日歯医者に行かなければならないの？	null	ttt	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
662	Heute Nachmittag gehe ich im Supermarkt einkaufen.	今日の午後  私は  スーパーで  買物をしに  行く。	null	ttt	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
663	Wann kommt ihr uns in Toyama besuchen?	いつ  君たちは  私たちを  富山に  訪ねに  来るの？	null	ttt	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
664	Heute Nachmittag lasse ich meine Kinder schwimmen gehen.	今日の午後  私は  子供たちを  泳ぎに  行か  せる。	null	ttt	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
665	Heute Nachmittag kann ich im Supermarkt einkaufen gehen.	今日の午後  私は  スーパーで  買物をしに  行く ことができる。	null	ttt	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
666	Heute Nachmittag kann ich meine Kinder schwimmen gehen lassen.	今日の午後  私は  子供たちを  泳ぎに  行か  せる ことができる。	null	ttt	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
667	Ich stehe jeden Tag um 7 Uhr auf.	私は毎日７時に起きる。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
668	Er ruft seine Freundin an.	彼は恋人に電話を掛ける。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
669	Mach bitte die Tür zu!	ドアを閉めてね。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
670	Sie zieht bald nach Osaka um.	彼女はまもなく大阪へ転居する。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
671	Wann zieht sie nach Osaka um? 	彼女はいつ大阪へ転居する。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
672	Zieht sie bald nach Osaka um?	彼女はまもなく大阪へ転居するの。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
673	Sie muss bald nach Osaka umziehen.	彼女はまもなく大阪へ転居しないといけない。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
674	Sie zieht bald nach Osaka um.	彼女は  まもなく  大阪へ  転居する	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
675	Sie muss bald nach Osaka umziehen.	彼女は  まもなく  大阪へ  転居し  ないといけない	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
676	Wir fahren morgen sehr früh ab.	私たちは明日とても早く出発する。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
677	Wann kommt dieser Zug in Köln an?	この列車は何時にケルンに着きますか？	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
678	Ich höre mit dem Rauchen auf.	私は喫煙をやめる。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
679	Geht ihr heute Abend aus?	君たち今晩外出するの？	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
680	Das Kind schläft immer schnell ein.	その子はいつも眠入るのが早い。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
681	Meine Eltern gehen jeden Tag spazieren.	私の両親は毎日散歩している。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
682	Wer nimmt am Ausflug teil?	誰が遠足に参加するの？	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
683	Wir müssen in Köln umsteigen.	私たちはケルンで乗り換えないといけない。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
684	Die Sonne geht bald unter.	太陽がまもなく沈む。	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
685	Hast du schon etwas vor?	もう何か予定している？	null	ttt	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
686	Ich bekomme von meinem Vater eine Uhr.	私は父から時計をもらう。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
687	Am Sonntag besuchen sie ihre Großeltern.	日曜に彼らは祖父母のところに遊びに行く。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
689	Dieses Fahrrad gefällt mir sehr.	この自転車はとても気に入った。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
690	Dieses Auto gehört meinem Vater.	この車は父のものだ。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
691	Dieses Wörterbuch kann ich Ihnen empfehlen.	この辞書ならあなたに薦められます。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
692	Kannst du diesen Fleck aus der Jacke entfernen?	この上着の汚れ落とせる？	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
693	Ich erkenne ihn an seiner Stimme.	私は声で彼だとわかる。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
694	Du sollst ein Handwerk erlernen.	お前は手に職をつけるべきだ。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
695	Ich kann diesen Satz nicht verstehen.	私はこの文が理解できません。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
696	Ich muss meinen Aufsatz noch verbessern.	作文をもっと良く書き直さないと。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
697	Das Glas fällt auf den Boden und zerbricht.	グラスが床に落ちて砕ける。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
698	Er umfährt das Stadtzentrum.	彼は町の中心部を迂回する。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
699	Er fährt ein Verkehrsschild um.	彼は交通標識を轢き倒す。	null	ttt	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
700	He is studying in Berlin.	彼はベルリンで勉強している。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
701	I know that he is studying in Berlin.	私は彼がベルリンで勉強していることを知っている。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
702	Er studiert in Berlin.	 彼はベルリンで勉強している。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
703	Ich weiß, dass er in Berlin studiert.	 私は彼がベルリンで勉強していることを知っている。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
704	Bevor ich abreise, muss ich noch vieles erledigen.	私は出発する前にまだ多くのことを片付けなければならない。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
705	Ich hoffe, dass wir morgen schönes Wetter haben.	私は明日良い天気になることを期待している。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
706	Ich fahre mit dem Bus zur Uni, wenn es stark regnet.	雨が強いときはバスで大学へ行く。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
707	Yuta kommt nicht zur Party, weil er morgen eine Prüfung hat.	ユウタは明日試験があるからパーティーには来ない。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
708	Yuko kommt zur Party, obwohl sie morgen eine Prüfung hat.	ユウコは明日試験があるのにパーティーに来る。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
709	Da er morgen eine Prüfung hat, muss er heute viel lernen.	彼は明日試験があるので今日はたくさん勉強しないといけない。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
710	Da ist meine Brille!	あっ，そこに僕の眼鏡があった。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
711	Wir müssen schon gehen, damit wir den Zug nicht verpassen.	列車に遅れないために，もう行かないと行けない。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
712	Er nimmt ein Messer. Und damit schneidet er ein Stück Käse ab.	彼はナイフを取り出す。そしてそれでチーズを一かけら切り取る。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
713	Während sie die Wäsche wäschst, bereitet er das Mittagessen.	彼女が洗濯する間に彼が昼食を準備する。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
714	Während des Essens sprechen die Kinder sehr laut.	食事の間，子供たちは大声でしゃべる。	null	ttt	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
715	Ich stehe jeden Tag um 7 Uhr auf.	私は毎日７時に起きる。	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
716	Er weiß nicht, dass ich jeden Tag um 7 Uhr aufstehe.	私は毎日７時に起きる。	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
717	Er will in Paris Musik studieren.	彼はパリで音楽の勉強をするつもりだ。	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
718	Ich weiß, dass er in Paris Musik studieren will.	私は，彼がパリで音楽の勉強をするつもりだということを知っている。	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
719	Da er eine Prüfung hat, kommt er nicht mit ins Kino.	彼は試験があるので一緒に映画に行かない。	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
720	Er will in Paris Musik studieren.	彼は	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
721	dass er in Paris Musik studieren will	彼が	null	ttt	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
722	Warum kommt sie nicht zur Party?	どうして彼女はパーティーに来ないの。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
723	Er fragt Hiroko, warum sie nicht zur Party kommt.	彼はヒロコに，どうしてパーティーに来ないのか尋ねる。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
724	Kommt sie zur Party?	彼女はパーティーに来るの。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
725	Ich weiß nicht, ob sie zur Party kommt.	私は彼女がパーティーに来るのかどうか知らない。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
726	Ich weiß noch nicht, wann du kommst?	 僕はまだ君がいつ来るのか知らない。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
727	Ich weiß noch nicht, wo du wohnst.	僕はまだ君がどこに住んでいるのか知らない。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
728	Ich weiß noch nicht, wer Deutsch lernt.	僕はまだ誰がドイツ語を勉強するのかしらない。 	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
729	Ich weiß noch nicht, was du heute machen willst.	僕はまだ君が今日は何をしたいのか知らない。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
730	Ich verstehe nicht, warum du so lachst.	 僕は君がなんでそなふうに笑うのか分からない。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
731	Ich weiß noch nicht, ob ich nach Wien fahre.	僕はまだウィーンに行くかどうかわからない。	null	ttt	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
732	Er liest die Zeitung und seine Frau sieht die Nachrichten.	彼は新聞を読んでいる，そして彼の妻はニュースを見ている。	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
733	Er ist müde, aber er muss noch arbeiten.	彼は疲れている，でもまだ仕事をしないといけない。	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
734	Sie ruft ihn an oder er ruft sie an.	彼女が彼に電話をするか，彼が彼女に電話をする。 	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
735	Ich bleibe zu Hause, denn das Wetter ist schlecht.	私は家に居る。なぜなら天気が悪いから。	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
736	[Er liest die Zeitung] und [seine Frau sieht die Nachrichten].	(=(1)) 	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
737	[Ich bleibe zu Hause], denn [das Wetter ist schlecht].	(=(4))	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
738	Ich bleibe zu Hause. Das Wetter ist schlecht.	私は家に居る。天気がわるい。 (←(4))	null	ttt	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
739	Er wartet schon lange.	彼はもう長い間待っている。（現在形）	null	ttt	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
740	Er wartete schon lange.	彼はもう長い間待っていた。（過去形）	null	ttt	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
741	Wir haben heute Deutsch gelernt.	私たちは今日ドイツ語を学んだ。	null	ttt	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
742	Deutsch wird auch in Japan gelernt.	ドイツ語は日本でも学ばれている。	null	ttt	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
743	„Hast du das Buch schon gelesen?“	「その本もう読んだ？」	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
744	„Nein, ich habe es noch nicht gelesen.“	「いや，まだ読んでいない。」	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
745	Sie haben Ihr Portemonnaie vergessen.	お財布を忘れましたよ。	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
746	Ich habe gestern meine Brille verloren.	私は昨日眼鏡をなくしてしまった。	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
747	Ich habe den Koffer schon gepackt.	私はもうスーツケースの荷造りをした。	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
748	Gestern abend kam ich um 1Uhr nach Hause. Da las meine Frau die Zeitung.	昨夜私は11時に帰宅した。妻は新聞を読んでいた。	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
749	Ich bin müde, weil ich ganz intensiv gearbeitet habe.	僕はすごく集中して働いたので疲れた。	null	ttt	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
750	Barbara ist erst um 1 Uhr ins Bett gegangen.	バルバラはやっと１時に床についた。	null	ttt	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
751	Sie ist sofort eingeschlafen.	彼女はすぐに寝入った。	null	ttt	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
752	Ich bin noch einige Zeit wach geblieben.	私はまだしばらく目が覚めたままだった。	null	ttt	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
753	Der Film hatte schon begonnen, als wir ins Kino kamen.	私たちが映画館に入ったら，映画はすでに始まっていた。	null	ttt	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
754	Ich musste ein Taxi nehmen, weil der letzte Bus schon abgefahren war.	最終バスが出てしまっていたのでタクシーに乗る羽目になった。	null	ttt	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
755	Ich habe es ganz vergessen.	「私はそれを忘れる」の現在完了形	null	ttt	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
756	Ich hatte es ganz vergessen.	「私はそれを忘れる」の過去完了形	null	ttt	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
757	Nachdem sie das Buch gelesen hatte, fuhr sie nach Hause.	その本を読んだ後で彼女は家に帰った。	null	ttt	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
758	Im März werde ich das Studium beendet haben.	３月に私は大学を終了しているだろう。	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
759	Er muss schon in Berlin angekommen sein.	彼はもうベルリンに着いているはずだ。	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
760	Sie kann die Verabredung vergessen haben.	彼女は約束を忘れたのかもしれない。	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
761	Sie wird wohl krank gewesen sein.	彼女はたぶん病気だったのだろう。（過去の推量）	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
762	Sie wird wohl krank sein.	 彼女はたぶん病気なのだろう。（現在の推量）	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
763	Ich habe in die Stadt gemusst.	私は町へ行かねばならなかった。（現在完了形）	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
764	Ich muss in die Stadt. 	私は町へ行かねばならない。（現在形）	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
765	Ich habe in die Stadt fahren müssen.	私は町へ行かねばならなかった。（現在完了形）	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
766	Ich muss in die Stadt fahren. 	私は町へ行かねばならない。（現在形）	null	ttt	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
767	Der kleine Wecker und die große Vase sind Geschenke von meinem Vater.	その小さな目覚し時計と大きな花瓶は父からのプレゼントだ。	null	ttt	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
768	das gute Fußballer	その上手なサッカー選手（付加語的用法）	null	ttt	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
769	Der Fußballer ist sehr gut.	そのサッカー選手はとても上手い。（述語的用法）	null	ttt	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
770	Der Fußballer spielt sehr gut.	そのサッカー選手はとても上手くプレーする。（副詞的用法）	null	ttt	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
771	Guten Morgen!	おはよう！	null	ttt	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
772	Gute Nacht!	おやすみ！	null	ttt	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
773	Schönes Wochenende!	楽しい週末を！	null	ttt	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
774	Gute Reise!	楽しい旅行を！	null	ttt	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
775	Schöne Ferien!	楽しい休暇を！	null	ttt	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
776	Die Mutter sitzt neben dem schlafenden Kind und liest ein Buch.	母親は眠っている子供の隣に座って本を読んでいる。	null	ttt	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
777	Zum Frühstück gab es belegte Brote und gekochte Eier.	朝食にはオープンサンドイッチとゆで卵があった。	null	ttt	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
778	Jeden Tag für die Familie zu kochen ist nicht leicht.	毎日家族のために料理をするのは簡単ではない。	null	ttt	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
779	Es ist nicht leicht, jeden Tag für die Familie zu kochen.	毎日家族のために料理をするのは簡単ではない。	null	ttt	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
780	Deutsch in zwei Jahren perfekt zu lernen	ドイツ語を２年間で完璧に習得すること	null	ttt	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
781	nächste Woche im Nationaltheater die Räuber von Friedrich Schiller zu sehen	来週・国立劇場で・シラーの「群盗」を・見ること	null	ttt	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
782	Es ist nicht möglich, dieses dicke Buch in drei Tagen zu lesen.	この厚い本を３日で読むことは不可能だ。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
783	Er hat beschlossen, jeden Tag 30 Minuten zu joggen.	彼は毎日30分ジョッギングすることを決心した。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
784	Hast du Lust, jeden Tag für die Familie zu kochen?	毎日家族のために料理する気ある？	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
785	Bist du bereit, jeden Tag für die Familie zu kochen?	毎日家族のために料理する覚悟ある？	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
786	Es freut mich sehr, Sie kennen zu lernen.	お近づきになれてとてもうれしいです。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
787	Es ist sehr leicht, mit dem Rauchen aufzuhören. Ich habe schon zehnmal aufgehört.	喫煙を辞めるのはとても簡単だ。僕はもう10回も止めたことがあるよ。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
788	Darf ich Sie bitten, etwas langsamer zu sprechen?	少しゆっくり話すようお願いしていいですか？	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
789	Er hat mir versprochen, das Geld heute zurückzugeben.	彼は私にお金を今日返すと約束した。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
790	Ich habe nicht den Mut, meinem Freund die Wahrheit zu sagen.	私は恋人に本当のことを話す勇気はない。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1067	Ich habe gar nichts gemerkt.	全然気づきませんでした。	事実を述べる		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
791	Papa, wann hast du denn Zeit, mit mir Fußball zu spielen?	パパ，僕とサッカーする時間いったいいつあるの？	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
792	Ich bin schon richtig aufgeregt, sie endlich wiederzusehen.	彼女にやっと再会できることが僕は今からすごく楽しみだ。※d-モジュール	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
793	Der Prüfling war nicht fähig, auf die Fragen schlagfertig zu antworten.	受験者は質問に的確に答えることができなかった。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
794	Sie besteht darauf, ein deutsches Auto zu kaufen.	彼女はドイツ車を買うことにこだわる。	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
795	Wie bist du darauf gekommen, nach Japan zu kommen?	どうして日本に来ることを思いついたの？	null	ttt	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
796	Um fit zu bleiben, läuft er jeden Tag eine Stunde.	体調を良く保つために彼は毎日１時間歩いている。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
797	Er ging ins Kino, statt die Hausaufgaben zu machen.	彼は宿題をするかわりに映画に行った。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
798	Sie ist weggegangen, ohne die Tür zuzumachen.	彼女はドアを閉めずに出て行った。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
799	Ich bringe dann etwas zu trinken mit.	じゃあ，何か飲むものを持っていくよ。←会話	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
800	Wir haben nichts zu essen.	私たちは食べるものが何もない。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
801	Nichts zu danken!	どういたしまして。（＜感謝することは何もない）←会話	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
802	Ich habe viel zu tun.	私はたくさんすることがある。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
803	Ich habe wenig zu tun.	私はあまりすることがない。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
804	Du hast zu gehorchen.	お前は言うことを聞かないといけないよ。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
805	Sie brauchen dieses Buch nicht zu lesen.	あなたはこの本を読む必要はない。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
806	Hast du schon angefangen, den Aufsatz zu schreiben?.	もう作文書き始めた？	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
807	Das Fahrrad fängt an zu rosten.	自転車がさび始める。	null	ttt	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
808	Ich denke nur an dich.	僕は君のことだけを考えている。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
809	Du denkst nur an dich.	君は自分のことだけを考えている。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
810	Ich denke nur an mich.	私は自分のことばかり考えている。（再帰代名詞）	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
811	Du denkst nur an mich.	あなたは私のことばかり考えている。（人称代名詞）	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
812	Er denkt nur an sich.	彼は自分のことばかり考えている。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
813	Er denkt nur an ihn.	彼(X)は彼(Y)のことばかり考えている。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
814	Ich wasche mir die Hände.	私は[自分の]手を洗う。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
815	Ich wasche dem Kind die Hände.	私は子供の手を洗ってやる。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
816	Er kauft sich einen Computer.	彼は[自分に]パソコンを買う。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
817	Er kauft ihr einen Computer.	彼は彼女にパソコンを買ってやる。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
818	Die Schwestern verstehen sich gut.	その姉妹は互いによく理解し合っている。	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
819	Wir haben uns doch letzte Woche erst gesehen, bei Claudia.	私たちは先週会ったばかりでしょ，クラウディアの家で。←会話	null	ttt	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
820	Der Chef ärgert sich sehr.	チーフはとても怒っている。	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
821	Die Studenten freuen sich auf die Ferien.	学生達は休暇を楽しみにしている。	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
822	Ich interessiere mich nicht sehr für Politik.	私は政治にそれほど関心がありません。	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
823	Erinnerst du dich noch an deinen Kindergarten?	君はまだ幼稚園のことを覚えている？	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
824	Er beschäftigt sich viel mit seinen Kindern.	彼はよく子供たちの面倒をみる。	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
825	Kannst du dir vorstellen, wie schrecklich der Unfall war.	その事故がどんなにひどかったか想像できる？	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
860	Habt ihr keine kleineren Gläser?	もっと小さいグラスはないの？	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
826	Ich konnte mir nicht erlauben, meine Meinung zu sagen.	私は思い切って自分の意見を言うことができなかった。	null	ttt	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
827	Der kranke Mann konnte nichts essen.	その病気の男性は何も食べられなかった。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
828	Der Kranke konnte nichts essen.	その病人は何も食べられなかった。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
829	Die Kranke bekommt jeden Tag Blumen.	その病人（女性）は毎日花をもらう。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
830	Die Kranken bekommen jeden Tag Blumen.	その病人たちは毎日花をもらう。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
831	In diesem Land gibt es viele Arbeitslose.	この国にはたくさん失業者がいる。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
832	Sie hat einen Deutschen geheiratet.	彼女はドイツ人と結婚した。 	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
833	Meine Mutter war früher Angestellte.	母は以前会社員だった。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
834	Der Bahnhof war mit Reisenden überfüllt.	駅は旅行者であふれていた。	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
835	„Ja, ich suche einen kleinen Terminkalender fürs nächste Jahr.“	「はい，来年用の小さな手帳を探しているんです。」 	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
836	„Moment ... nein, tut mir Leid, es ist wirklich der letzte.“	「ちょっとお待ちください．．．申し訳ありません，これが本当に最後の［手帳］です。」	null	ttt	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
837	Ich möchte etwas Kaltes trinken.	僕は何か冷たいものが飲みたい。	null	ttt	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
838	Wir haben nichts Neues erfahren.	私たちは何も新しいことは聞いていない。	null	ttt	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
839	Alles Gute!	お元気で！	null	ttt	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
840	Und, was gibt's Neues?	それで，何か変わったことあったの？ ［会話22］	null	ttt	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
841	Denken Sie an was Spezielles?	何かお決まりのものをお探しです（＜何か特定のものをお考えですか）？［会話29］	null	ttt	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
842	Wir übersetzen den Satz aus dem Deutschen ins Japanische.	私たちはその文をドイツ語から日本語に訳す。	null	ttt	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
843	Ich glaube, die sind schon fast alle verkauft. 	そういうのはもうほとんどみんな売れてしまったと思いますが…。	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
844	Da wohnt nämlich mein Onkel, den besuche ich jedes Jahr.	というのも，そこにおじさんが住んでるから，その人のところに毎年行くんだ。［会話20］	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
845	Und den Roman hast du auch! Den wollte ich schon lange mal lesen.	この小説もあるのね。これずっと前から読みたかったんだ。［会話6］	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
846	Sie können bis zu zehn Bücher ausleihen.Wollen Sie die hier ausleihen?	10冊まで借りられますよ。この本，貸し出しですか（＜借り出したいですか）？［会話13］	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
847	„Ich glaube, Sie haben Ihr Portemonnaie vergessen.“	お財布を忘れませんでしたか？	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
848	„Ja, ist das nicht Ihres?“	これ，あなたのではないでしょうか？	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
849	„Oh, ja! Das ist meins.“	あっ，本当だ。僕のです。［会話2］	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
850	„Ja, wir kriegen dieses Jahr auch keine neuen Kalender mehr rein.“	はい，今年は新しいダイアリーの入荷も終わりましたので。	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
851	„Hm, tja, na gut, dann nehme ich eben diesen.“	そうですか，まあ，いいか，じゃあこれください。［会話29］	null	ttt	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
852	Mein Zimmer ist kleiner als sein Zimmer.	私の部屋は彼の部屋より小さいよ。	null	ttt	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
853	„Stimmt. Aber mein Zimmer ist das kleinste.“	たしかに。でも僕の部屋が一番小さいよ。	null	ttt	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
854	Ich brauche einen größeren Teller.	私はもっと大きい皿が必要だ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
855	Das ist der größte Teller.	これが一番大きいお皿なんだ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
856	Hast du eine tiefere Schüssel für den Salat?	サラダ用のもっと深いボウルある？	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
857	Das ist die tiefste Schüssel.	これが一番深いボウルなんだ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
858	Ich brauche ein schärferes Messer.	私はもっと切れる包丁が必要だ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
859	Das ist das schärfste Messer.	これが一番切れる包丁なんだ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
861	Das sind die kleinsten Gläser.	これが一番小さいグラスなんだ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
862	Du hast mehr Bücher als ich.	君は僕よりたくさん本を持っている。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
863	Er hat weniger Haar als du.	彼の髪の毛は君より少ないよ。	null	ttt	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
864	Mein Vater ist jünger als meine Mutter.	父は母より若い。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
865	○Michael ist reich.	ミヒャエルは金持ちだ。(原級)	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
866	○Michael ist reicher.	ミヒャエルの方が金持ちだ。(比較級)	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
867	Michael ist der reichste.	ミヒャエルが一番金持ちだ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
868	Michael ist am reichsten.	ミヒャエルが一番金持ちだ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
869	Michaela ist die reichste.	ミヒャエラが一番金持ちだ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
870	Michaela ist am reichsten.	ミヒャエラが一番金持ちだ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
871	Er ist klüger, als du denkst.	彼は君が思っているよりも賢いよ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
872	Der Unfall war viel schlimmer, als ich es mir vorgetellt hatte.	その事故は私が想像していたよりもはるかにひどかった。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
873	Es ist besser, mit Freunden Bier zu trinken, als allein zu Hause zu sitzen.	友達とビールでも飲む方が一人で家にいるよりも良い。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
874	Er ist als Verleger erfolgreicher denn als Dichter.	彼は詩人としてよりも出版人として成功している。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
875	Die Kirschen sind jetzt am billigsten.	サクランボは今が一番安い。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
876	Franz ist der größte [Schüler] in der Klasse.	フランツはクラスで一番背が高い[生徒だ]。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
877	Hanna ist die größte [Schülerin] in der Klasse.	ハンナはクラスで一番背が高い[女生徒だ]。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
878	Die Prüfung zu bestehen, ist jetzt das wichtigste.	試験に受かることが今は最も重要だ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
879	Die Prüfung zu bestehen, ist jetzt am wichtigsten. 	試験に受かることが今は最も重要だ。	null	ttt	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
880	Er spricht gut Englisch.	彼は英語がうまい。（うまく英語を話す）	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
881	Er spricht besser Englisch als Deutsch.	彼はドイツ語よりも英語の方がうまい。	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
882	Er spricht am besten Englisch von uns.	彼は私たちの中で英語が一番うまい。	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
883	Ich trinke gern Wein.	私はワインが好きだ。(原級)	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
884	Ich trinke lieber Wein als Bier.	私はワインの方が好きだ。(比較級)	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
885	Ich trinke am liebsten Wein.	私はワインが一番好きだ。(最上級)	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
886	Geh lieber gleich zum Arzt!	すぐ医者に行った方がいいよ！	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
887	Eher will ich sterben als ihn heiraten.	彼と結婚するくらいならむしろ死んでしまいたい。	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
888	Sie sollten sich mehr schonen.	あなたはもっと自分をいたわるべきでしょう。	null	ttt	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
889	Mein Lehrer ist so alt wie mein Vater.	先生は父を同じ年だ。 	null	ttt	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
890	Mein Lehrer ist nicht so alt wie mein Vater.	先生は父ほど高齢ではない。	null	ttt	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
891	Komm so früh wie möglich nach Hause!	できるだけ早く帰ってきて。	null	ttt	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
892	Die Preise steigen immer höher.	物価はますます高騰する。	null	ttt	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
893	Je älter er wird, desto bescheidener wird er.	彼は歳を取るのに応じて謙虚になっていく。	null	ttt	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
894	Der Schüler wird ständig gelobt.	その生徒はいつもほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
895	Ich werde ständig gelobt.	私はいつもほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
896	Du wirst ständig gelobt.	君はいつもほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
897	Wir werden ständig gelobt.	私たちはいつもほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
898	Ihr werdet ständig gelobt.	君たちはいつもほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
899	Die Schüler werden ständig gelobt.	生徒たちはいつもほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
900	Der Schüler wird ständig von seinem Lehrer gelobt.	その生徒はいつも先生にほめられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
901	Der Schüler wurde von seinem Lehrer gelobt.	その生徒は先生にほめられた。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
902	Hier wird bald eine Grundschule gebaut.	ここにもうすぐ小学校が建てられる。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
903	Die Grundschule wurde vor einem Jahr gebaut.	小学校は１年前に建てられた。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
904	Der Tisch wurde gedeckt und das Essen wurde aufgetragen.	テーブルに食器が並べられ，食事が運ばれてきた。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
905	Wissen Sie, wann hier eine Grundschule gebaut wird?	いつここに小学校が建てられるかご存知ですか。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
906	Er behauptet, dass die Zeitschrift von vielen Studenten gelesen wird.	その雑誌は多くの学生に読まれていると彼は主張する。	null	ttt	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
907	Vor dem Bahnhof wird ein Supermarkt eröffnet.	駅前にスーパーが開店する。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
908	Vor dem Bahnhof ist ein Supermarkt eröffnet worden.	駅前にスーパーが開店した。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
909	Vor dem Bahnhof war ein Supermarkt eröffnet worden.	駅前にスーパーが開店した。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
910	Die Bankräuber sind gestern festgenommen worden.	銀行強盗は昨日逮捕された。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
911	Der Brand ist schnell gelöscht worden.	火事はすぐに消化された。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
912	Ist mein Fahrrad noch nicht repariert worden?	僕の自転車はまだ修理されていないの？	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
913	In der Zeitung steht, dass die Bankräuber festgenommen worden sind.	 銀行強盗が逮捕されたと新聞に出ている。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
914	Ich habe gehört, dass der Brand schnell gelöscht worden ist.	火事はすぐに消化されたって聞いたよ。	null	ttt	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
915	Der Bankräuber wird bald festgenommen werden.	銀行強盗はすぐに逮捕されるだろう。	null	ttt	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
916	Das Auto musste zur Werkstatt abgeschleppt werden.	車は工場まで引っ張って行かれねばならなかった。	null	ttt	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
917	Der Patient kann noch gerettet werden.	その患者はまだ救うことができる。	null	ttt	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
918	Der Patient kann noch gerettet werden.	その患者はまだ救うことができる。	null	ttt	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
919	Der Bankräuber wird in drei Tagen festgenommen worden sein.	銀行強盗は3日後には逮捕されているだろう。	null	ttt	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
920	Der Bankräuber wird schon festgenommen worden sein.	銀行強盗はすでに逮捕されているだろう。	null	ttt	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
921	Der Lehrer lobt den Schüler ständig.	先生はその生徒をいつもほめる。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
922	Der Schüler wird ständig [vom Lehrer] gelobt.	その生徒はいつも［先生に］ほめられる。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
923	Der Lehrer hilft dem Schüler ständig.	先生はその生徒をいつも助ける。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
924	Dem Schüler wird ständig [vom Lehrer] geholfen.	その生徒はいつも［先生に］助けられる。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
925	Die Berghütte wurde durch eine große Lawine zerstört.	山小屋は大きななだれにつぶされた。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
926	Die Eltern verwöhnen Gisela sehr.	両親はギーゼラをとても甘やかしている。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
927	Gisela wird von den Eltern sehr verwöhnt.	ギーゼラは両親にとても甘やかされている。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
928	Die Abgeordneten kritisierten den Minister heftig.	議員達は大臣を激しく批判した。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
929	Der Minister wurde von den Abgeordneten heftig kritisiert.	大臣は議員達から激しく批判された。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
930	Ein Freund hat ihn über den Unfall unterrichtet.	友達が彼にその事故について知らせた	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
931	Er ist durch einen Freund über den Unfall unterrichtet worden.	彼は友達からその事故について知らされた。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
1709	Ihre Augen sind vom Weinen rot.	泣いて彼女の目は赤くなっている。	\N		\N	vmod	\N	\N	\N	0	1
932	Ich hab’ gestern chinesischen Tee geschenkt bekommen.	昨日中国茶をもらったの。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
933	Ein Freund hat mir gestern chinesischen Tee geschenkt.	友達が私に昨日中国茶をくれたの。	null	ttt	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
934	Es wurde bis in die Nacht hinein gefeiert.	夜中までパーティーをしていた。	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
935	Bis in die Nacht hinein wurde gefeiert.	夜中までパーティーをしていた。	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
936	Wie vielen Menschen wird mit Ihrer Spende geholfen?	あなたの寄付で何人の人が助かるでしょうか？（赤十字のホームページ）	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
937	Hier wird über die Nebenwirkungen von Medikamenten diskutiert.	ここでは薬の副作用について議論します。	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
938	In dieser Zeit wird hart gearbeitet und ordentlich verdient.	この時期にはしっかり仕事してたっぷり稼ぐ。（観光地のホテルの話）	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
939	Es wird gefeiert, es wird gesungen, es wird geweint. Junge Menschen steigen auf die Mauer und tanzen.	祝って，歌って，泣いている。若者たちは壁に登って踊っている。（ベルリンの壁開放の時の様子）	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
940	Ob in Vietnam, in Palestina, in Tschetschenien oder im Irak überall wurde und wird gestorben.	ヴェトナム，パレスチナ，チェチェンそれにイラクと，いたるところで人が死んでいったし死んでいる。	null	ttt	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
941	Das Fahrrad ist schon repariert.	自転車はもう修理してある。（修理した結果の状態）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
942	Das Fahrrad wird heute repariert.	自転車は今日修理される。（修理する動作）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
943	Seine Schuhe sind blank geputzt.	彼の靴はぴかぴかに磨いてある。（磨いた結果の状態）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
944	Seine Schuhe werden blank geputzt.	彼の靴はぴかぴかに磨かれる。（磨く動作）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
945	Das Fahrrad ist schon repariert.	自転車はもう修理してある。（状態受動）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
946	Er repariert das Fahrrad.	彼は自転車を修理する。（他動詞）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
947	Seine Schuhe sind blank geputzt.	彼の靴はぴかぴかに磨いてある。（状態受動）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
948	Er putzt seine Schuhe.	彼は靴を磨く。（他動詞）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
949	Sie ist sofort eingeschlafen.	彼女はすぐに寝入った。（現在完了形）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
950	Sie schläft sofort ein.	彼女はすぐに寝入る。（自動詞）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
951	Wir sind nach Heidelberg gefahren.	私たちはハイデルベルクへ行った。（現在完了形）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
952	Wir fahren nach Heidelberg.	私たちはハイデルベルクへ行く。（自動詞）	null	ttt	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
953	Musik-Charts sollen manipuliert worden sein.	音楽ヒットチャートは操作されたらしい。	null	ttt	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
954	Das ist der Pulli, der mir am besten gefällt.	これが私の一番気に入っているセーターだ。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
955	Das ist das Hemd, das mir am besten gefällt.	これが私の一番気に入っているシャツだ。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
956	Das ist die Jacke, die mir am besten gefällt.	これが私の一番気に入っている上着だ。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
957	Das sind die Schuhe, die mir am besten gefallen.	これが私の一番気に入っている靴だ。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
958	Ja, ich denke an so einen kleinen Taschenkalender, der aber trotzdem für jeden Tag eine Seite hat.	ええと，これくらいの小さなダイアリーで，毎日で１ページになっているものがほしい（＜を考えている）んですけど。［会話29］	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
959	Ein Ziegelhaus ist weitaus trockener als ein Haus, das aus anderen Materialien errichtet wird.	レンガの家は他の素材で建てる家よりもはるかに乾燥している。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
960	Mein Vater arbeitet bei einer Firma, die eng mit Toyota zusammenarbeitet.	父はトヨタと提携している会社で働いている。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
961	Viele Frauen, die ihren Beruf nicht aufgeben wollen, machen sich Gedanken, wie sie alles schaffen werden.	仕事を辞めたくない多くの女性はどうしたらそうできるか考えている。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
962	Mein Vater, der jetzt in Berlin arbeitet, ruft uns selten an.	今ベルリンで仕事をしている父は家にめったに電話をしてくれない。	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1710	Ich warte am Ausgang auf dich.	出口の所で（君を）待っているね。	\N		\N	vmod	\N	\N	\N	0	1
963	Das ist das Kleid, das mir am besten gefällt.	これは私が一番気に入っているドレスです．	null	ttt	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
964	Wer ist der Mann, der da Zeitung liest?	あそこで新聞を読んでいる男の人は誰なの？	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
965	Wer ist der Mann, den du anrufen wolltest?	君が電話をしようとした男の人は誰なの？	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
966	Wer ist der Mann, dem die Frauen vertrauen?	女性たちが信頼する男性は誰だろう？	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
967	Wer ist der Mann, dessen Werk Millionen Fans in aller Welt begeistert?	その作品が全世界の何百万のファンを感激させる男は誰だろう？	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
968	Die Touristen, die diese alte Stadt kennen, besuchen sie immer wieder.	この古都に来たことがある旅行者はここをくりかえし訪れる。	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
969	Die Aufgaben, die unser Lehrer uns gibt, sind sehr schwierig.	先生が私たちに出す課題はとても難しい。	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
970	Es gibt Menschen, denen nie jemand glaubt, obwohl sie die Wahrheit sprechen.	真実を言っても決して信じてもらえない人がいる。	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
971	Wir möchten euch hier Hotels vorstellen, in denen wir übernachtet haben.	ここでは皆さんに私たちが泊まったことのあるホテルを紹介したいと思います。	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
972	Sie sucht den Hut, den sie gestern gekauft hat.	彼女は昨日買った帽子を探している．	null	ttt	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
973	Wer A sagt, muss auch B sagen.	Aを言う人はBも言わないといけない。（＝言い出したことは責任を持って続けないといけない）	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
974	Wer nicht arbeitet, soll auch nicht essen.	働かざる者，食うべからず。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
975	Wen man nicht sieht, vergisst man leicht.	会わなくなった人はすぐに忘れる。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
976	Wessen er immer gedenkt, ist seine Mutter.	彼がいつも思い出す人はお母さんだった。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
977	Das ist alles, was ich erzählen kann.	これが私に話せることのすべてです。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
978	Das ist das Beste, was ich tun kann.	これが私にできる最善のことです。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
979	Oh, das ist aber ganz schön viel, was wir da machen müssen.	えー，それじゃ，やらなきゃいけない事が多すぎますよ。［会話31］	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
980	Leipzig ist eine Stadt, wo man die Veränderung vom Kommunismus in den Kapitalismus sehen kann.	ライプツィッヒは共産主義から資本主義への変化を目で見ることができる都市だ。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
981	Leipzig ist eine Stadt, in der man die Veränderung vom Kommunismus in den Kapitalismus sehen kann.	ライプツィッヒは共産主義から資本主義への変化を目で見ることができる都市だ。	null	ttt	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
982	Er sagte, er habe keine Zeit.	彼は時間が無いと言っていた。	null	ttt	\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
983	Wenn er Zeit hätte, würde er eine Reise durch Deutschland machen.	もしも時間があれば彼はドイツ中を旅行するだろう。	null	ttt	\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
984	Er sagt, er könne nicht kommen, weil er keine Zeit habe.	彼は，時間がないから来られないと言っている。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
985	Martin sagte, seine Frau komme morgen nach Japan.	マルティーンは，奥さんが明日日本に来ると言った。（kommeは接続法１式）	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
986	Martin sagte, seine Kinder kämen morgen nach Japan.	マルティーンは，子供たちが明日日本に来ると言った。（接続法１式kommenは直説法現在形と同じ形なので接続法２式kämenを使っている）	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
987	Damals glaubte man, die Sonne laufe um die Erde.	当時人々は太陽が地球の周りを回ると信じていた。 	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
988	Sie sagte, er habe sich ein Auto gekauft.	彼女は［彼が車を買った］と言った。 	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
989	Sie sagte, er kaufe sich ein Auto.	彼女は［彼が車を買う］と言った。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
990	Er sagt, sie sei krank gewesen.	彼は［彼女は病気だった］と言っている。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
991	Er sagt, sie sei krank.	彼は［彼女は病気だ］と言っている。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
992	Tina sagte, sie sei krank.	ティナは自分が病気だと言った。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
993	Tina sagte: „Ich bin krank.“	ティナは言った。「私，病気なの。」	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
1065	Nichts zu danken!	大したことないですよ。	感謝する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
994	Tobi fragte mich, ob Tina auch komme.	トビは僕にティナも来るのか尋ねた。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
995	Tobi fragte mich, ob Tina auch komme.	トビは僕にティナも来るのか尋ねた。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
996	Tobi fragte mich: „Kommt Tina auch?“	トビは僕に尋ねた。「ティナも来るの？」	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
997	Tobi fragte mich, wann Tina komme.	トビは僕にティナがいつ来るのか尋ねた。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
998	Tobi fragte mich: „Wann kommt Tina?“	トビは僕に尋ねた。「ティナはいつ来るの？」	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
999	Tobi sagte Tina, sie solle nicht rauchen.	トビはティナにタバコを吸うなと言った。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
1000	Tobi sagte zu Tina: „Rauche nicht!“	トビはティナに言った。「タバコを吸うな！」	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
1001	Tobi bat Tina, er möge nicht rauchen.	トビはティナにタバコを吸わないでと頼んだ。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	\N
1002	Tobi bat Tina: „Rauche bitte nicht!“	トビはティナに頼んだ。「タバコを吸わないで！」	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	\N
1003	Der Arzt sagte, dass meine Frau um 7:45 verstarb.	医者は，私の妻が7時45分に死亡したと言った。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	\N
1004	Der Hals-Nasen-Ohren Arzt sagte, meine Ohren an sich sind in Ordnung.	耳鼻咽喉科医は，私の耳そのものは正常だと言った。	null	ttt	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	\N
1005	Wenn ich Bürgermeister wäre, gäbe es keine Schule mehr.	もしも僕が市長だったら学校はもうなくなるだろう。	null	ttt	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1006	Wenn ich Bürgermeister wäre, würde es keine Schule mehr geben.	もしも僕が市長だったら，学校はもうなくなるだろう。	null	ttt	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1007	Wenn er nicht krank wäre, würde er am Ausflug teilnehmen.	もしも病気でなければ，彼は遠足に参加するだろう。（現在のこと）	null	ttt	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1008	Wenn er nicht krank gewesen wäre, hätte er am Ausflug teilgenommen	もしも病気でなかったならば，彼は遠足に参加していただろう。（過去のこと）	null	ttt	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1009	Könnte ich mein Leben nochmals leben, dann würde ich das nächste Mal riskieren, mehr Fehler zu machen.	人生をもう一度生きられるとしたら，今度は思い切ってもっとたくさん失敗をしてやろう。	null	ttt	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1010	Wenn das Paket doch endlich käme!	小包がもういい加減に届いてくれたらなあ。	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1011	Na ja, wenn er doch bloß keine Freundin hätte...	あーあ，彼に恋人さえいなかったらなあ。［会話37］	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1012	Ich glaube, die könnte sich gut in unsere WG einleben und mit der hätten wir auch viel Spaß.	彼女なら，うちのWGによく馴染めそうだし，一緒に楽しめると思うよ。［会話18］※ WGはWohngemeinschaftの略。アパートを数人で借りて部屋を分けて使う。	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1013	Wenn ich das doch nur nicht gesagt hätte!	あんなこと言わないでおけばよかったなあ。	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1014	Hätte ich das doch nur nicht gesagt!	あんなこと言わないでおけばよかったなあ。	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1015	Ich hätte heute schon beinahe einen Unfall verursacht!	今日はあやうく事故を起こすところだったよ。	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1016	Um ein Haar hätte ich den wichtigen Termin vergessen!	もう少しで大事なアポイントメントを忘れるところだったよ。	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1017	Aber ... na ja, du hättest ja auch später kommen können!	でも，遅れて来てもよかったのに。［会話26］	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1018	Aber ... du hättest uns doch mindestens anrufen können.	でもせめて電話ぐらいしてくれたらよかったのに。［会話26］	null	ttt	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1019	Also, ich hätte da eine Bitte.	あの，お願いしたいことがあるんですが。［会話27］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1020	Würden Sie bitte das Material für die Sitzung am Nachmittag vorbereiten?	午後の会議の資料を準備してくれますか。［会話33］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1021	Du sprichst so, als ob du nichts davon gehört hättest.	君はそのことをまるで聞いていないみたいな言い方をするね。	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1022	Unsere Deutschlehrerin ist Japanerin. Sie kann Deutsch aber so gut, als ob sie eine Deutsche wäre.	私たちのドイツ語の先生は日本人だ。でもまるでドイツ人のようにドイツ語がうまい。	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1023	Und welche Preislage sollte es sein?	ご予算はおいくらぐらいでしょうか？［会話8］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1066	Wo haben Sie es denn gefunden?	一体どこにあったんですか？	情報を求める（存在と場所）		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1024	Hättest du nicht Lust, da auch mal mitzumachen?	あなたも一緒にする気ない？［会話20］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1025	Allerdings bräuchte ich dafür ein Empfehlungsschreiben.	ただ，そのためには推薦状が必要なんですが。［会話27］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1026	Wie wär' s dann mit japanischer Literatur?	それなら日本文学とかはどう？［会話28］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1027	Sie promoviert jetzt in Heidelberg und würde gern im nächsten Semester an unserem Seminar teilnehmen.	今ハイデルベルクで博士論文を書いていて，来学期，先生のゼミに参加したいそうです。［会話40］	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1028	Du sprichst so, als hättest du nichts davon gehört.	君はそのことをまるで聞いていないみたいな言い方をするね。	null	ttt	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
1029	Der Herr erhöre unser Gebet!	主が私たちの祈りをお聞きくださいますように。	null	ttt	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1030	Der Herr erhört unser Gebet!	主が私たちの祈りをお聞きくださいますように。	null	ttt	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1031	Jeder tue sein Bestes.	各々ベストを尽くすように。	null	ttt	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1032	Jeder tut sein Bestes.	各々がベストを尽くしている。	null	ttt	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1033	Singen wir zusammen!	一緒に歌おう。	null	ttt	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1034	Wir singen zusammen.	私たちは一緒に歌う。	null	ttt	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1035	Hallo, Angela!	やぁ，アンゲラ！	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1036	Hallo, Michael!	こんにちは，ミヒャエル！	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1037	Lange nicht gesehen!	久しぶりだね！	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1038	Na, wie geht's?	どう，元気？	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1039	Danke, gut!	ありがとう，元気だよ。	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1040	Und dir?	あなたは？	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1041	Mir geht's auch gut.	ぼくも元気だよ。	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1042	Und ... was machst du jetzt?	それで，今何をしているの？	どうしているか尋ねる		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1043	Ich fahre zu meinen Eltern.	両親のところへ行くの。	予定を言う		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1044	Mein Vater hat heute Geburtstag.	今日が父の誕生日なんだ。	事実を述べる		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1045	Ach so, dann feiert ihr jetzt zusammen?	ふーん，そうなんだ，じゃあ，これから一緒にお祝いするんだね？	予定を言う		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1046	Schön!	いいね！	意見を言う		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1047	Grüß deine Eltern von mir!	ご両親によろしく！	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
1048	Okay, das mache ich.	うん，そうするよ。	ある条件での行動を言う		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1049	Oh, der Bus kommt schon!	あ，もうバスが来た！	描写する		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1050	Dann wünsche ich dir noch einen schönen Abend!	じゃあ，素敵な晩を過ごしてね！	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1051	Tschüs!               	じゃあね！               	さよならを言う               		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1052	Danke, gleichfalls!	ありがとう，君もね！	挨拶をする		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1053	Tschüs!	バイバイ！	さよならを言う		\N	dmod	de01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1054	Hallo, Entschuldigung!	あの，すみません！	注意をひく		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1055	Meinen Sie mich?	僕ですか？	確認する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1056	Ja.	はい。	肯定する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1057	Ich glaube, Sie haben Ihr Portemonnaie vergessen.	お財布を忘れませんでしたか。	意見を言う		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1058	Ich, mein Portemonnaie?!	僕が？財布ですか？	情報を求める（所有）		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1059	Ja, ist das nicht Ihres?	これ，あなたのではないでしょうか？	情報を求める（所有）		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1060	Oh, ja!	あっ本当だ！	肯定する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1061	Das ist meins.	ぼくのです。	事実を述べる		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1062	Das ist aber sehr nett von Ihnen!	これはどうもご親切に！	感謝する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1063	Vielen Dank!	どうもありがとうございます！	感謝する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	\N
1064	"Danke schön!" ―  "Bitte schön!"	「ありがとう！」 ― 「いいえ。（どういたしまして。）」	感謝する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1068	In der Telefonzelle haben Sie es vergessen.	電話ボックスに置き忘れていましたよ。	事実を述べる		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1069	Sie waren direkt vor mir dran.	私はすぐ後ろにいたんです。	事実を述べる		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1070	Ach, Gott sei Dank!	ああ，よかった！	感情を表わす		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1071	Da bin ich aber froh!	それにしても本当に助かりましたよ。	感情を表わす		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1072	Vielen Dank nochmals!	本当にどうもありがとうございました。	感謝する		\N	dmod	de02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
1073	Heute war das Wetter wirklich schön!	今日は本当にいいお天気だったね！	描写する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1074	Ja, und es ist noch richtig warm.	そうだね，まだ本当に暖かいし。	意見を言う		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1075	Wow, schau mal, das Abendrot!	うわ，見てみて，夕日だよ！	注意を引く		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1076	Ja, echt phantastisch!	うん，本当にきれいだね！	描写する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1077	Wie im Film!	まるで映画みたいだ！	比喩する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1079	Oh, hör mal!	あ，聴いてみて！	注意を引く		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1080	Da macht jemand Musik!	あそこで誰かが音楽を演奏してるよ。	描写する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
1081	Musik?	音楽？	確認する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1082	... Ich hör' nichts.	ぼくには何も聞こえないけど。	意見を言う		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1083	Doch, hör doch mal!	聞こえるよ，ちゃんと聴いてみて！	注意を引く		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1084	... Ah ja, stimmt.	…あ，本当だ！	同意する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1085	Jetzt hör' ich's auch.	今度はぼくにも聞こえる。	事実を述べる		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1086	Da spielt jemand Gitarre!	誰かがギターを弾いてる。	描写する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
1087	Gehen wir da mal hin?	あっちに行ってみようか？	提案する		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1088	Okay, gute Idee!	うん，そうしよう！	意見を言う		\N	dmod	de03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1089	Ist hier noch frei?	ここまだ空いてる？	許可を求める		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1090	Ja, bitte!	うん，どうぞ！	許可を求める		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1091	Hier findet doch die Vorlesung von Professor Dupont statt, oder?	ここ，デュポン先生の講義だよね？	情報を求める（属性）		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1092	Ja, richtig.	うん，そうだよ。	意見を言う		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1093	Ich kenne dich noch gar nicht.	まだ君とは知り合いじゃないと思うけど，	事実を言う		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1094	Studierst du auch Jura?	やっぱり法学専攻なの？	情報を求める（属性）		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1095	Nein, ich studiere Politik.	ううん，政治学を勉強しているの。	事実を述べる		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1096	Aber ich interessiere mich auch für französisches Recht.	でもフランスの法律にも興味があるんだ。	嗜好について述べる（もの）		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1097	Übrigens, ich heiße Silke.	ところで，私はズィルケ。	自己紹介する		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1098	Und du?               	あなたは？               			\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	\N
1099	Ich bin Klaus.	僕，クラウス。	自己紹介する		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1100	Ich habe gehört, dass die Vorlesung auf Französisch ist.	この授業はフランス語でするって聞いたんだけど，	情報を求める（属性）		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1101	Stimmt das?	本当なの？	確認する		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1102	Ich glaube, ja.	うん，そうだと思うよ。	意見を言う		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1103	Der Professor kommt ja aus Frankreich.	先生はフランス出身だしね。	人を紹介する		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1104	Kannst du gut Französisch?	フランス語がわかるの？	技能と能力についてたずねる		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1105	Ja, ich habe als Kind in Frankreich gelebt.	うん，子供の頃，フランスで暮らしていたから。	経験についてたずねる		\N	dmod	de04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1106	Hallo, Hans!	やぁ，ハンス！	挨拶をする		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1107	Wartest du schon lange?	ずいぶん待たせちゃった？	情報を求める（程度）		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1108	Na ja, es geht.	まあ，大したことないよ。	意見を言う		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1109	Ungefähr eine Viertelstunde.	15分ぐらいだし。	情報を求める（程度）		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1110	Oh, das tut mir wirklich Leid!	本当にごめん！	あやまる		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1111	Der Zug hatte 20 Minuten Verspätung.	電車が２０分も遅れちゃって。	理由を述べる		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1112	Na ja, da kann man nichts machen.	まあ，仕方ないね。	妥協する		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1113	Übrigens, hast du mein Buch mitgebracht?	それはそうと，ぼくの本持って来た？	情報を求める（存在と場所）		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1114	Dein Buch?	本？			\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1115	Oh, nein!	やだ！			\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1116	Mein Gott!	どうしよう！	感情を表わす		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1117	Das habe ich ganz vergessen.	そのこと，すっかり忘れていた。	理由を述べる		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[4]	\N	\N	\N
1118	Oh, nein!	うそ！	感情を表わす		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1119	Entschuldigung!	ごめん！	あやまる		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1120	Das ist mir jetzt wirklich peinlich!	本当に申し訳ない	あやまる		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1121	Ich bringe es dir morgen mit, okay?	明日持ってくる。それでいい？	許可を求める		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1122	Ja, ist in Ordnung.	うん，いいよ。	妥協する		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1123	Dann trinken wir erst mal einen Kaffee.	じゃあ，とりあえずコーヒーでも飲もう。	提案する		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1124	Ja, das ist gut.	うん，それがいいね。	意見を言う		\N	dmod	de05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1125	Wow, du hast ja viele Bücher!	うわあ，本たくさん持ってるんだね！	描写する		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1126	Na ja, ich lese sehr gern.	まあね，本を読むの好きだから。	嗜好について述べる（行動）		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1127	Und den Roman hast du auch!	この小説もあるのね！	情報を求める（所有）		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1128	Den wollte ich schon lange mal lesen.	これずっと前から読みたかったんだ。	希望を述べる		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1129	Wie hat er dir gefallen?	どうだった，この小説？	情報を求める（属性）		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1130	Ja, sehr gut!	うん，すごくいいよ。	意見を言う		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1131	Der war wirklich sehr spannend.	本当にワクワクするよ。	意見を言う		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1132	Hast du den noch nicht?	まだ持ってないの？	情報を求める（所有）		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
1133	Nein.	うん，ない。	否定する		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1134	Ach so, wenn du willst, dann nimm ihn doch einfach mit!	そうか，読むんなら，持っていっていいよ！	何かをあげる		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1135	Ich schenke ihn dir.	それ君にあげるよ。	何かをあげる		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1136	Echt?	本当に？	確認する		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1137	Ja, ich habe ihn schon zweimal gelesen und brauche ihn nicht mehr.	うん，ぼくはもう二回も読んだから，もういらないよ。	理由を述べる		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1138	Das ist aber lieb von dir.	うれしい。	感情を表わす		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1139	Danke schön!	どうもありがとう！	感謝する		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1140	Bitte!	どういたしまして。	感謝する		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1141	Ich hoffe, er gefällt dir.	気に入るといいね。	希望を述べる		\N	dmod	de06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
1142	Fährst du eigentlich immer mit diesem Zug?	いつもこの電車を使ってるの？	情報を求める（属性）		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1143	Nein.	ううん。	否定する		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1144	Normalerweise fahre ich mit der Straßenbahn.	普段は路面電車を使うよ。	事実を述べる		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1145	Wohin fährst du denn jetzt?	今はどこに行くところ？	予定を言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1146	Ins Zentrum.	中心街へ行くの。	予定を言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1147	Ich treffe Freunde.	友達に会いに。	予定を言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1148	Und du?	ミヒャエルは？			\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
1149	Ich muss zur Arbeit.	ぼくは仕事があるんだ。	予定を言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1150	Oh, du Armer!	あら，かわいそうに！	感情を表わす		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1151	Ja, aber ich muss heute nur vier Stunden arbeiten.	でも今日は４時間働くだけなんだ。	事実を述べる		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1152	Na ja, das geht ja noch.	そうか，ならまだいいね。	意見を言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1153	Oh!	あ！	感情を表わす		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1154	Ich muss aussteigen!	私もう降りないと！	ある条件での行動を言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
1155	Dann viel Spaß!	では，楽しんでね！	さよならを言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1156	Tschüs!	じゃあね！	さよならを言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1157	Danke, schönes Wochenende!	ありがとう，よい週末を！	さよならを言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1158	Tschüs!	バイバイ！	さよならを言う		\N	dmod	de07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1159	Guten Tag!	こんにちは！	挨拶をする		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1160	Guten Tag!	いらっしゃいませ！	挨拶をする		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1161	Entschuldigung, können Sie mir bitte weiter helfen?	すみません，ちょっとお願いできますか？	依頼する		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1162	Ich suche etwas für ein sechsjähriges Kind.	６歳の子供のものを探しているんですが。	事実を述べる		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1163	Ein Kleid oder so was.	ワンピースとか何か。	例をあげて述べる		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1164	Am besten aus Baumwolle.	木綿のがあればベストなんですけど。	希望を述べる		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	\N
1165	Ja, gerne.	はい。			\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1166	Und welche Preislage sollte es sein?	ご予算はおいくらぐらいでしょうか？	金額についてたずねる		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1167	Ja...	そうですね。			\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1168	Hmm...				\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1169	Ungefähr 50 Euro?	50ユーロぐらいですかね。	意見を言う		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1170	Aha...	でしたら…			\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1171	Wie finden Sie dieses Kleid?	このワンピースなどはいかがでしょうか？	提案する		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1172	Das ist doch ganz niedlich.	とてもかわいいですよ。	意見を言う		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1173	Sehr schön!	素敵ですね！	意見を言う		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1174	Das gefällt mir wirklich gut.	とてもいいですね。	意見を言う		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1175	Was kostet das denn?	おいくらですか？	情報を求める（金額）		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
1176	45 Euro.	45ユーロです。	情報を求める		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1177	Gut, das nehm' ich.	そう，じゃあ，それください！			\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1178	Vielen Dank!	ありがとうございます！	感謝する		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1179	Dann kommen Sie mit zur Kasse.	では，レジの方へお願いします！	指示する		\N	dmod	de08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1180	Na, was liest du denn da so interessiert?	ねえ，何をそんなに面白そうに読んでるの？	どうしているかをたずねる		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1181	Oh, seit wann bist du denn hier?	あれ，いつからここにいたの？	情報を求める（存在と場所）		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1182	Ich hab' dich gar nicht bemerkt.	全然気づかなかったよ。	意見を言う		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1183	Der Reiseführer hier ist so interessant.	この旅行ガイド，本当に面白いんだ。	意見を言う		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1184	Ach, willst du verreisen?	へえ，旅行に行くの？	予定を言う		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1185	Ja, im Sommer fahre ich nach China.	うん，夏に中国に行くの。	予定を言う		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1186	Nach China?	中国？			\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1187	Ja, ich interessiere mich für chinesische Geschichte und Kultur.	そうよ，中国の歴史や文化に興味があるんだ。	嗜好について述べる（もの）		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1188	Hast du schon mal in Asien Urlaub gemacht?	アジアのどこかで休暇を過ごしたことある？	情報を求める（経験）		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1189	In China war ich noch nicht.	中国には行ったことないけど，	情報を求める（経験）		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1190	Aber letztes Jahr war ich in Thailand.	去年タイに行ってきたよ。	情報を求める（経験）		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1191	Schön!	へえ，いいなあ！	感情を表わす		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1192	Und wie war's da?	で，どうだった？	情報を求める（属性）		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1193	Das war ganz toll.	すごくよかったよ。	意見を言う		\N	dmod	de09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1194	Gott sei Dank!	やれやれ。	感情を表わす		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1195	Die Prüfung ist endlich vorbei!	やっと試験が終わったね！	事実を述べる		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1196	Ja, ich freu' mich auch total.	本当にうれしいよ！	感情を表わす		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1197	Jetzt haben wir endlich Sommerferien!	これからは夏休みだ！	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1198	Was machst du denn diesen Sommer?	この夏は何をする？	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1199	Hmm.	うん。			\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1200	Nächste Woche Freitag fahr' ich für zwei Wochen in Urlaub.	来週金曜日に２週間の旅行に出かけるの。	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1201	Schön!	いいね！			\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1202	Wohin denn?	どこに？	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1203	Und mit wem eigentlich?	誰と？	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1204	Mit meinem Freund.	私の彼と，	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1205	In die Türkei.	トルコに。	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1206	Wir haben da Freunde.	トルコには友達がいるし。	事実を述べる		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1207	Und du?	で，クリストフは？			\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	\N
1208	Hast du schon was vor?	何かもう予定あるの？	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[5]	\N	\N	\N
1209	In einer Woche kommt meine Freundin aus den Staaten zu Besuch.	１週間後にアメリカから彼女が遊びに来るんだ。	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1210	Ich bin schon richtig aufgeregt, sie endlich wiederzusehen.	またやっと会えるから，今からうれしくてしょうがないよ。	感情を表わす		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1211	Das glaub' ich!	そうだよね！	意見を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1212	Wir haben auch schon 'ne ganze Menge Ausflüge und so geplant.	たくさん遠出とかも計画しているんだ。	予定を言う		\N	dmod	de10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1213	Na, was hast du am Wochenende gemacht?	ねえ，週末は何したの？	情報を求める（経験）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1214	Ich war am Samstag zum ersten Mal im Café Kowalski.	土曜日，初めてカフェ・コバルスキーに行ったんだ。 	情報を求める（経験） 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1215	Warst du auch schon mal da?	君も行ったことある？ 	情報を求める（経験） 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1216	Ja, ich geh' ganz gern dahin.	うん，そこに行くのは結構好きよ。	嗜好について述べる（行動）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1217	Und ... wie hat's dir gefallen?	それで，どれくらい気に入った？ 	情報を求める（程度） 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1218	Echt gut, ist sehr gemütlich.	本当にいいね，とても居心地がいいよ。	情報を求める（程度） 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1219	Wie oft bist du denn da?	君は一体何回ぐらい行くの？	情報を求める（程度）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1220	Hmm, vielleicht so einmal pro Woche.	うーん，週に一回くらいかな。	情報を求める（程度）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1221	So oft?	そんなに？	情報を求める（程度）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1222	Die haben Happy-hour-Menüs.	ハッピーアワーセットがあるの。	描写する 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1223	Unter der Woche bekommt man zwischen fünf und acht eine Riesenportion Wiener Schnitzel für 6 Euro.	平日は５時から８時まで，特大のウィーナーシュニッツェルが６ユーロなんだよ。	描写する 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1224	Was heißt das, "eine Riesenportion"?	特大ってどのくらい？ 	情報を求める（程度）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1225	Die Schnitzel sind so groß wie Teller, und man bekommt sogar zwei davon.	お皿ぐらい大きくて，しかも２枚なの。	情報を求める（程度）		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1226	Oh!	へえ！ 	感嘆する 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1227	Das muss ich auch mal probieren.	それはぼくも一度試してみなくっちゃ。 	希望を述べる 		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1228	Hast du heute Abend Zeit?	今晩，時間ある？	予定を言う		\N	dmod	de11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	1
1229	Hey, Anna, wann fängt dein nächstes Seminar an?	ねえ，アンナ，次のゼミは何時に始まるの？	情報を求める（時間）		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1230	Um Viertel nach zwei.	2時15分。	情報を求める（時間）		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1231	Und du?	ディートマーは？	予定を言う		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1232	Hast du's eilig?	急いでる？	予定を言う		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
1233	Nee, gar nicht.	ううん，全然。	予定を言う		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1234	Ich habe heute keine Veranstaltungen mehr.	今日はもう授業ないんだ。	予定を言う		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1235	Wie spät ist es jetzt?	今，何時？	情報を求める（時間）		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1236	Erst zehn nach eins.	まだ1時10分すぎ。	情報を求める（時間）		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1237	Ich hab' etwa noch 'ne Stunde.	あと１時間はあるわ。	情報を求める（時間）		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1238	Gut.	じゃあ，	相づちを打つ		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1239	Geh'n wir 'nen Kaffee trinken?	コーヒー飲みに行かない？	提案する		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1240	Ja, gerne!	うん，いいねぇ。	提案する		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1241	Hmm, gehen wir ins Stadt-Café oder bleiben wir in der Uni?	えーっと，シュタットカフェに行く？それとも学内にしようか。	提案する		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1242	Bis zum Stadt-Café brauchen wir bestimmt 'ne Viertelstunde.	シュタットカフェまではきっと15分位かかるよ。	情報を求める（時間）		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1243	Setzen wir uns doch hier draußen auf den Rasen?	外の芝生に座ろうよ！	提案する		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1244	Gute Idee!	それはいい！	提案する		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1245	Das Wetter ist ja auch echt schön heute.	今日は本当に天気がいいからね。	事実を述べる		\N	dmod	de12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1246	Guten Tag.	こんにちは。	挨拶をする		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1247	Ich hab' mal eine Frage.	ちょっとお聞きしたいのですが。	注意をひく		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1248	Wie viele Bücher darf man auf einmal ausleihen?	一度に何冊借りられますか？	情報を求める（数字）		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
1249	Sie können bis zu zehn Bücher ausleihen.	10冊まで借りられますよ。	情報を求める（数字）		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1250	Wollen Sie die hier ausleihen?	この本，貸出ですか？	希望を述べる		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1252	Dann brauche ich mal Ihren Bibliotheksausweis.	では，図書館カードをお願いします。	ある条件での行動を言う		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1253	Ja, hier, bitte schön.	はい，ここにあります，どうぞ。	何かをあげる		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1254	Danke ...	どうも。	感謝する		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1255	So, bitte.	…では，どうぞ。	何かをあげる		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1256	Wie lange kann ich die behalten?	どれくらい借りていられますか？	情報を求める（数字）		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1257	Zwei Monate.	２ヶ月です。	情報を求める（数字）		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1258	Also, bis zum 18. Januar.	では，1月18日に（別れ際のあいさつ）。	情報を求める（数字）		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1259	Das ist gut.	そうですか。	相づちを打つ		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1260	Vielen Dank.	ありがとうございました。	感謝する		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1261	Auf Wiedersehen.	さようなら。	さよならを言う		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
1262	Auf Wiedersehen.	さようなら。	さよならを言う		\N	dmod	de13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1263	Was sind das denn für Stäbchen?	それは一体，何の棒？	情報を求める（属性）		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1264	Das sind Essstäbchen.	これは食べるための棒（＝箸）よ。	情報を求める（属性）		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1265	Das sehe ich auch, aber warum sind die denn so kurz?	それはぼくも分かるけど，一体どうしてそんなに短いの？	理由を述べる		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1266	Das sind japanische, die sind kürzer als die chinesischen.	これは日本のよ，中国のより短いの。	理由を述べる		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1267	Kannst du eigentlich mit Stäbchen essen?	ところで，箸で食べられる？	技能と能力について尋ねる		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1268	Nee, nicht so richtig.	いいや，うまくはないよ。	技能と能力について尋ねる		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1269	Wie hält man die denn?	一体どうやって持つの？	何でどのようにするかを言う		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1270	Wie einen Kuli, und der Ringfinger stützt das untere Stäbchen.	ボールペンみたいに。それで，薬指が下の箸を支えるの。	何でどのようにするかを言う		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1271	So ... ist das so richtig?	ええと，…これでいいの？	情報を求める（属性）		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1272	Und womit isst du denn Tofu?	で，豆腐は一体何で食べるの？	何でどのようにするかを言う		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1273	Etwa auch damit?	ひょっとしてこれで？	何でどのようにするかを言う		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1274	Na, klar.	当たり前よ。	肯定する		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1275	Versuch's doch auch mal.	ちょっとやってみたら。	提案する		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1276	Hmm, nee, ich nehm' lieber 'ne Gabel...	うーん，いいや。フォークの方がいいよ。	嗜好について述べる		\N	dmod	de14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1711	Er hat eine Ausländerin geheiratet.	彼はある外国人女性と結婚した。	\N		\N	vmod	\N	\N	\N	0	1
1277	Du kannst doch Japanisch, oder?	ねえ，日本語できるよね？	技能と能力について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1278	Ja, ein bisschen.	うん，少しね。	技能と能力について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1279	Kannst du denn auch Chinesisch lesen?	中国語も読める？	技能と能力について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1280	Kaum.	無理。	技能と能力について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1281	Ich hab' nie Chinesisch gelernt, aber im Japanischen benutzt man ja auch chinesiche Schriftzeichen.	中国語は習ったことないんだ。でも，日本語でも中国の文字を使うんだよ。	能力についてたずねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1282	Ach ja?	えーそうなの？	相づちを打つ		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1283	Interessant!	おもしろいね！	意見を言う		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1284	Dann kannst du mir ja vielleicht doch helfen?	じゃあ，よかったら手伝ってくれる？	可能性について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1285	Wobei denn?	一体何を？	情報を求める（属性）		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1286	Ich hab' gestern chinesischen Tee geschenkt bekommen.	昨日中国茶をもらったの。	事実を述べる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1287	Der schmeckt wirklich super!	本当にすごく美味しいのよ。	事実を述べる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1288	Ich möchte gern wissen, was da drin ist, aber ich kann die Zutaten nicht lesen.	何が入っているか知りたいんだけど，原材料名が読めなくて。	技能と能力について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1289	Gut.	いいよ，	相づちを打つ		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1290	Ich kann's ja mal versuchen, aber nur wenn ich den Tee probieren darf!	ちょっと試してみよう。でも，そのお茶を飲ませてもらえるならね。	可能性について尋ねる		\N	dmod	de15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1291	Entschuldigung, gibt es hier in der Nähe einen Kopierer?	すみません，この近くにコピー機はありますか？	場所についてたずねる		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1292	Ja, der Kopierraum ist im ersten Stock.	ええ，コピー室が２階にありますよ。	情報を求める（存在と場所）		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1293	Gehen Sie hier die Treppe hoch und dann geradeaus.	ここの階段を上って，まっすぐです。	情報を求める（存在と場所）		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1294	Auf der rechten Seite ist dann der Kopierraum.	そうすると，右側にコピー室があります。	情報を求める（存在と場所）		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1295	Vielen Dank.	ありがとうございます。	感謝する		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1296	Ach so, braucht man da auch eine Kopierkarte?	あ，そうだ，そこでもコピーカードが要りますか？	必要性を尋ねる		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1297	Ja, die braucht man schon.	はい，必要ですね。	必要性を尋ねる		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1298	Ah ja.	そうですか。	確認する		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1299	Und wo kann ich die kaufen?	で，それはどこで買えますか？	情報を求める（存在と場所）		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1300	Im Gebäude II.	２号館です。	情報を求める（存在と場所）		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1301	Neben dem Haupteingang ist eine Kopierecke, dort ist ein Kartenautomat.	正面入り口の隣にコピーコーナーがあって，そこに自動販売機があります。	情報を求める（存在と場所）		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1302	Danke schön.	ありがとうございます。	感謝する		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1303	Gern geschehen.	どういたしまして。	感謝する		\N	dmod	de16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1304	Du Andrea, warst du vielleicht schon mal in der Vorlesung "Einführung in die Kunstgeschichte"?	ねぇアンドレア，もしかしたら「美術史概説」の講義に出てた？	情報を求める（経験）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1305	Ja, ich glaube.	うん，出てたと思うよ。	情報を求める（経験）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1306	Die ist doch von Frau Schmidt, oder?	それ，シュミット先生のでしょ？	情報を求める（属性）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1307	Ja, genau.	そう。	肯定する		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1308	Ich überlege jetzt, ob ich da hingehe.	出ようかどうか考えてるところなんだ。	事実を述べる		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1309	Wie war die denn?	どうだった？	情報を求める（属性）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1310	Ach, sehr interessant!	あ，すごくおもしろかったよ！	情報を求める（属性）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1311	Und wie ist Frau Schmidt...?	それでシュミット先生は…？	情報を求める（属性）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1312	Auch nett.	いい先生よ。	情報を求める（属性）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1313	Sie spricht zwar immer ziemlich schnell, nee, aber sie ist wirklich okay.	確かにいつもかなり早口だけど，うん，でも本当にいいよ。	特徴についてたずねる		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1314	Wir hatten auch eine Exkursion zu einem Museum gemacht, das war auch gut.	課外授業で美術館にも行ったの，これも良かったよ。	情報を求める（経験）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1315	Hm, das hört sich ja nicht schlecht an.	へぇ，それは悪くなさそうね。	情報を求める（属性）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1316	Dann werde ich die wohl auch besuchen.	それじゃあ，私も出てみようかな。	予定を言う		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1318	Und findet die jedes Semester statt, die Vorlesung?	で，毎学期やってるの，その講義？	情報を求める（時間）		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1319	Ich meine, ja.	そうだと思うよ。	肯定する		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1320	Aber ganz genau weiß ich's auch nicht.	でも正確には私も分からない。	事実を述べる		\N	dmod	de17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1321	Oh Nicole, wer soll jetzt bloß unsere neue Mitbewohnerin werden?	ねえニコル，こんどだれが新しい同居人になったらいいかなあ。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1322	Tja, das ist eine schwere Frage.	うーん，難しい質問だね。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1323	Ich fand irgendwie alle ziemlich nett.	なんか，みんなとってもよかったね。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1324	Ja, ich auch.	うん，そう思う。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1325	... Aber Julia war eigentlich am lockersten; findest du nicht auch?	…でも，ユリアが実際，一番気楽な感じだったね，そう思わない？	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1326	Ich glaube, die könnte sich gut in unsere WG einleben und mit der hätten wir auch viel Spaß.	彼女なら，うちのWGによく馴染めそうだし，一緒に楽しめると思うよ。	要求する		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1327	Ja, stimmt.	そうだね。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1328	Allerdings kann ich mir das auch mit Katrin gut vorstellen.	もちろん，カトリンでもそうだと思う。	可能性を述べる		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1329	Die war doch auch ganz witzig.	彼女もかなりおもしろかったよね。	情報を求める（属性）		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
1330	Und was ich gut finde, ist, dass sie noch studiert.	あと，いいと思うのは，まだ大学に通っていることかな。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
1331	Ja, ist vielleicht auch besser mit einer Studentin zusammen zu wohnen.	うん，一緒に住むのは学生のほうがいいかもね。	意見を述べる		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1332	Wenn jemand arbeitet, muss der immer so früh aufstehen.	働いていたら，いつも早起きしなくちゃいけないし。	義務を確認する/肯定する		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1333	Mhm.	うーん。	相づちを打つ		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1334	Und wie hat dir die Italienerin gefallen?	あと，イタリア人の子はどうだった？	嗜好について述べる（もの）		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1335	Ach, Chiara!	ああ，キアラね！	相づちを打つ		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1336	Ja, die war auch sehr sehr nett.	うん，彼女もすごくいい感じだったよ。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1337	Und was ich echt erstaunlich fand, war, dass die so gut Deutsch gesprochen hat.	彼女があんなにドイツ語が上手だったのには驚いたね。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
1338	Ja, wirklich.	うん，本当に。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1339	Aber sie wollte natürlich auch nur für sechs Monate einziehen.	でも，もちろん入っても6ヶ月だけと言っていたけどね。	希望を述べる		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1340	Das ist nicht lange und dann müssen wir bald wieder jemanden suchen.	あんまり長くないし，そうしたらまたすぐに誰か探さなくちゃいけないよ。	情報を求める（時間）		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
1341	Ach, ich weiß auch nicht.	ああ，私も分からないなあ。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1342	Es ist wirklich schwer, sich zu entscheiden.	決めるのは本当に難しいね。.	情報を求める（属性）		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1343	Ja, das ist es.	そうだね。	相づちを打つ		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1344	Wir sollten einfach noch mal 'ne Nacht drüber schlafen.	とにかくもう一晩考えたほうがいいかな。	意見を言う		\N	dmod	de18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
1345	Magst du eigentlich lieber Kaffee oder Tee?	ところでコーヒーとお茶，どっちが好き？	嗜好について述べる（もの）		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1346	Auf jeden Fall Kaffee.	絶対コーヒー。	嗜好について述べる（もの）		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1347	Und am liebsten Milchkaffee.	で，ミルクコーヒーが一番好きなの。	嗜好について述べる（もの）		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1348	Und du?	それでザビーネは？	嗜好について述べる（もの）		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
1349	Ah nee, ich trinke am liebsten schwarzen Tee.	ううん（コーヒーはだめ），私は紅茶が一番好き。	嗜好について述べる（もの）		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1712	In Tokio leben viele Ausländer.		\N		\N	vmod	\N	\N	\N	0	1
1350	Aber heute werde ich wohl mal Kamillentee nehmen.	でも，ちょっと今日はカモミールティーにしようかな。	予定を言う		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1352	Ja, sieht so aus.	うん，そうみたい。	肯定する		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1353	Seit gestern tut mir der Hals ziemlich weh.	というのも昨日からのどがすごく痛くって。	理由を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1354	Ach, du Arme!	ああ，かわいそうに。	感想を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1355	Hoffentlich geht es schnell wieder weg!	すぐにまた直るといいね。	希望を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1356	Ja, das hoffe ich auch.	うん，そうだといいんだけど。	希望を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1357	... Willst du auch noch ein Apfelkuchen?	 …あとリンゴケーキも食べる？	希望を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1358	Nein, ich nicht.	ううん，私はいいや。	希望を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1359	Hast du etwa noch Hunger?	ひょっとしてまだお腹空いてるの？	どうしているかを尋ねる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1360	Ja, ein Stück könnte ich noch essen.	うん，あと一切れならまだ食べられるよ。	事実を述べる		\N	dmod	de19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1361	Tina, wie ist das eigentlich mit dir, machst du auch Sport?	ティーナ，ところであなたはどう？スポーツするの？	好きな行動について述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1362	Klar, ich mach' gern Aerobic und ich schwimme auch oft.	もちろん，エアロビクスも好きだし，よく泳ぎにも行くよ。	嗜好について述べる（行動）		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1363	Warum fragst du?	どうして？	理由を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1364	Ach, wir spielen doch mittwochs immer Volleyball im Sportzentrum.	うん，水曜にいつもスポーツセンターで，ちょっとバレーボールをしてるの。	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1365	Hättest du nicht Lust, da auch mal mitzumachen?	あなたも一緒にする気ない？	提案する		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1366	Ach, weißt du, Volleyball ist nicht so mein Ding.	うーん，実は，バレーボールはそれほどする気がないなあ。	嗜好について述べる（行動）		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1367	Na komm, wir sind doch alle keine Profis.	ねえやろうよ，みんな上手いわけじゃないんだし。	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1368	Nee, tut mir Leid.	ううん，ごめんね。	あやまる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1369	Andere Sportarten gerne, aber Ballsport ist nichts für mich.	ほかのスポーツならいいんだけど，球技は私向きじゃないの。	嗜好について述べる（行動）		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1370	Na ja, macht ja nichts.	まあ，気にしないで。	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1371	... Fährst du denn Ski?	…ところでスキーはするの？	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1372	Ja, sogar sehr gern.	うん，すごく好き。	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1373	Und Snowboard fahre ich auch.	あとスノーボードもするよ。	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1374	Ach, das ist ja toll!	ああ，それはいいね！	意見を言う		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1375	Dann komm mich doch mal im Winter in St. Anton besuchen!	じゃあ，冬になったらザンクトアントンに来てよ！	指示する		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1376	Da wohnt nämlich mein Onkel, den besuche ich jedes Jahr.	というのも，おじさんが住んでるから，毎年行くんだ。	事実を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
1377	Super!	すごいね！	意見を言う		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1378	Ich besuch' dich da gerne mal.	一度遊びに行きたいな。	希望を述べる		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1379	Hmm... Schön.	うふふ，いいと思うわよ。	意見を言う		\N	dmod	de20.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	\N
1380	Ach ... kannst du mir mal helfen?	あの…，ちょっと手伝ってもらえるかしら？	依頼する		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1381	Ja, klar.	うん，いいよ。	許可を求める		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1382	Ich möchte diese Seite vergrößern.	あの，このページ拡大したいんだけど，	希望を述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1383	Aber ich weiß nicht, wie es geht ...	どうすればいいかわからなくて。	事実を述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1384	Ach, das ist eigentlich ganz einfach.	あ，それならすごく簡単だよ。	意見を述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1385	Also, du legst das Blatt hier auf...	じゃあ，まずここに紙を置いて，	手順と順序について述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1386	Em, wie groß soll es denn werden?	えーと，大きさは？	情報を求める（程度）		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
1387	DIN A3?	A３？	情報を求める（程度）		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
1388	Ja.	うん, 	同意する		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1389	Ich glaub', das reicht.	それで十分だと思う。	意見を言う		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1390	Okay, und dann stellst du hier die Größe ein.	オッケー，次にここで大きさを設定する。	順序について述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1391	Moment mal, "A4 auf A3", ja?	ちょっと待って，A４をA３にすればいいんだよね？	情報を求める（程度）		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1392	Ja.	うん。	同意する		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1393	Dann drückst du auf "Start", so wie beim normalen Kopieren.	それから，普通のコピーと同じように「スタート」を押せばいいの。	手順と順序について述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1394	So.	ほら。	注意をひく		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1395	Tja, das ist ja ziemlich einfach.	そうか。本当に簡単だね。	意見を述べる		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1396	Peinlich, peinlich.	おはずかしい。	感情を表わす		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1397	Vielen Dank.	どうもありがとう！	感謝する		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
1398	Nichts zu danken!	いえいえ。	感謝する		\N	dmod	de21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1399	Schröder.	シュレーダーです。	注意をひく		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1400	Hallo, Uli.	もしもし，ウリ？	挨拶をする		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1401	Martina.	マルティーナだけど。	挨拶をする		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1402	Oh, Martina!	あ，マルティーナ。	挨拶をする		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1403	Du bist's.	君か。	挨拶をする		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1404	Lange nichts von dir gehört.	久しぶりだね。	挨拶をする		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1405	Wie geht's denn?	元気？	挨拶をする		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	\N
1406	Was soll das heißen, "lange nichts von dir gehört"!?	どういうこと，「久しぶり」って？	情報を求める（属性）		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1407	Wir haben uns doch letzte Woche erst gesehen, bei Claudia.	先週も会ったでしょう，クラウディアのところで。	事実を述べる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1408	Äh, tja... Ja, aber mir kommt's schon vor, wie 'ne Ewigkeit.	えーと，そうだったね，結構，前だと思ってたんだけど。	意見を述べる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1409	OK.	まあいいや。	妥協する		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1410	Also, wie geht's dir?	それで，元気？	どうしているかをたずねる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1411	Na ja, es geht so.	まあまあかな。	どうしているかをたずねる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1412	Meine Magisterarbeit, du weißt schon.	修論のこと，知ってるでしょう。	理由を述べる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1413	Und dir?	君は？	どうしているかをたずねる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1414	Auch nicht so besonders.	特に良いわけでもないよ。	どうしているかをたずねる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1415	Und, was gibt's Neues?	それで，最近何か変わったことあったの？	どうしているかをたずねる		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1416	Tja...	うーん…。	感情を表わす		\N	dmod	de22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1417	Heute Abend gehen wir doch in den Wald, Wildschweine gucken, oder?	今晩は森に行くんだよね，イノシシ見に。	予定を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1418	Ja schon, aber es sieht doch so nach Regen aus ...	うん，でもなんだか雨が降りそうだよね。	意見を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1420	Lass uns trotzdem gehen, und wenn's auch regnet.	雨が降っても行こうよ。	提案する		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1421	Ich will aber nicht nass werden.	でも雨に濡れるのはいや。	意見を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1422	Mensch, Katja!	おい，カーチャ！	感情を表わす		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1423	Wir haben doch gesagt...	行くって言ったじゃないか。	理由を述べる		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1424	Nee.	いや。	意見を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1425	Ich bin doch nicht blöd.	そんなばかみたいなことはしないわよ。	意見を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1426	Wenn du unbedingt willst, geh' doch allein in den Wald.	どうしても行きたいなら，ひとりで行けば？	ある条件での行動を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1427	Ich bleib' schön zu Hause und gucke "Ally McBeal".	私はうちで「アリーmyラブ」でも見てるよ。	予定を言う		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	\N
1428	Und wenn du nach Hause kommst, mach' ich dir eine Kanne Kamillentee.	でもね，帰ってきたら，カモミールティーを入れてあげる。	提案する		\N	dmod	de23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[5]	\N	\N	\N
1429	Elke, isst du eigentlich gerne japanisch?	エルケ，日本食は好き？	嗜好について述べる（もの）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1430	Ja. 	うん。			\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1431	Tofu, zum Beispiel esse ich gern.	たとえばお豆腐なんかよく食べるよ。	例をあげる		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1432	Tofu...	豆腐か…。	例をあげて述べる		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1433	Isst du auch Sashimi, ich meine rohen Fisch?	刺身も食べる？生の魚のことだけど。	嗜好について述べる（もの）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1434	Ja.	うん。	嗜好について述べる（もの）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1435	Aber ich esse Tofu lieber als Sashimi.	でもお刺身よりは豆腐の方が好き。	比べて述べる（比較級と最上級）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1436	Und magst du auch Misosuppe?	お味噌汁も好き？	嗜好について述べる（もの）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1437	Ja.	うん。	嗜好について述べる（もの）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1438	Die esse ich sogar am liebsten, was japanisches Essen angeht.	それどころか一番好きだよ，日本食の中では。	比べて述べる（比較級と最上級）		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1439	Aber du, ... warum redest du eigentlich die ganze Zeit über japanisches Essen?	ところで，どうしてずっと日本食の話ばかりするの？	理由を述べる		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1440	Tja, die Sache ist die:	えーと，それはね。	理由を述べる		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1441			人を紹介する		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1442	Und am Wochenende machen wir 'ne kleine Fete, da kocht er japanisch.	週末に小さなパーティーをするんだけど，彼が日本食を作るの。	予定を言う		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1443	Also ... wenn du Zeit und Lust hast, kannst du ja auch kommen...	もしよかったら，来ない？	招待する		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	\N
1444	Ja gerne.	うん，行きたいな。	意見を言う		\N	dmod	de24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1445	Also, wann treffen wir uns?	で，何時に会おうか？	情報を求める（時間）		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1446	Um sechs?	６時でどう？	提案する		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1447	Vor dem Rathaus?	市役所の前で？	提案する		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1448	Um sechs...	６時か。	情報を求める（時間）		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1449	Hm...	うーん…。	感情を表わす		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1450	Das ist vielleicht 'n bisschen früh.	それはちょっと早いかな。	意見を述べる		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1451	Der Film beginnt doch erst um acht, oder?	映画は８時からだろう？	時間についてたずねる		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	1
1452	Ja, aber ich möchte vor dem Film noch etwas mit dir spazieren gehen.	うん，でも映画の前に一緒にちょっと散歩でもしたいなと思って。	希望を述べる		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1453	Hmm... Ich muss vorher aber unbedingt noch was essen.	うーん，でもその前に何かを食べておかないと。	希望を述べる		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1455	Also, wenn du willst, kannst du bei uns essen.	じゃあ，もしよかったら，うちで食べてもいいよ。	提案する		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1456	Ach, ja?	え？	感情を表わす		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1457	Ist das in Ordnung?	いいの？	許可を求める		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1458	Ja, klar.	もちろん。	許可を求める		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1459	Echt?	本当に？	許可を求める		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1460	Das ist aber nett.	それは助かるなあ。	感謝する		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1461	Tja, und wann soll ich dann vorbeikommen?	えーと，何時ごろ行けばいい？	情報を求める（時間）		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
1462	Also, ich würde sagen ... so gegen fünf.	そうだね…５時ごろでどう？	提案する		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1463	Ist das OK?	いい？	許可を求める		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1464	Gut, um fünf.	うん，じゃあ５時に。	予定を言う		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	\N
1465	Bis dann.	それじゃあね。	さよならを言う		\N	dmod	de25.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[2]	\N	\N	1
1466	Hallo, Anette!	やぁ，アネッテ！	挨拶をする		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1467	Warum bist du denn gestern nicht zur Fete gekommen?	昨日はどうしてパーティーに来なかったの？	理由を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1468	Oh, tut mir wirklich Leid!	本当にごめん！	あやまる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1469	Ich wollte kommen, aber ich konnte nicht.	本当は行きたかったんだけど，ダメだったの。	事実を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1470	Warum?	どうして？	理由を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1471	Weil ... meine Mutter ist plötzlich krank geworden.	母が急に体調を崩しちゃって。	理由を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1508	Ach, ich glaub'  schon.	うん，そうだと思うよ。	嗜好について述べる（もの）		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1472	Da musste ich für meinen kleinen Bruder kochen.	それで私が弟の食事を作らなければならなかったの。	意見を言う		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1473	Ach, so!	そうだったのか！	同意する		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1474	Aber ... na ja, du hättest ja auch später kommen können!	でも，遅れて来てもよかったのに。	意見を言う		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1475	Nein, das ging auch nicht, meiner Mutter ging es wirklich schlecht!	ううん，それどころじゃなかったの。母の調子が本当に悪くって。	理由を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1476	Oh, das wusste ich nicht.	そうか，それは知らなかった。	事実を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1477	Aber ... du hättest uns doch mindestens anrufen können.	でもせめて電話ぐらいしてくれたらよかったのに。	意見を言う		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1478	Ja, tut mir Leid, aber unser Telefon war plötzlich kaputt, ausgerechnet gestern Abend!	ごめん。でもそれがね，電話も急に壊れちゃったの，よりによって昨日の夜に！	理由を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1479	Na, so ein Zufall!	まあ，なんという偶然だろう！	感情を表わす		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1480	Ja, du weißt, dass ich kein Handy habe.	それに私，携帯も持ってないじゃない…。	理由を述べる		\N	dmod	de26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1481	Guten Tag, Herr Büker.	こんにちは。ビューカー先生。	挨拶をする		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1482	Ach, guten Tag, Frau Raindl.	あ，こんにちは，ラインドルさん。	挨拶をする 		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1483	... Hier, bitte, setzen Sie sich.	どうぞ座ってください。	許可を求める		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1484	Ja, gern ...	ありがとうございます。	感謝する		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1485	Ja, um was geht's denn?	で，何の話ですか？	どうしているかをたずねる		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1486	Also, ich hätte da eine Bitte.	あの，お願いしたいことがあるんですが。	依頼する		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1487	Ich habe doch vor, nach Japan zu gehen, um Materialien für meine Magisterarbeit zu sammeln.	修論の資料収集のために，日本に行く予定なんですけど。	予定を言う		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1488	Ach ja.	ああ，そうでしたね。	同意する		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1489	Ja, und jetzt wollte ich mich für ein Stipendium beim DAAD bewerben.	はい，それで DAADの奨学金に応募しようと思っているんです。	希望を述べる		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1490	Allerdings bräuchte ich dafür ein Empfehlungsschreiben.	ただ，そのためには推薦状が必要なんですが。	理由を述べる		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1491	Jetzt wollte ich Sie bitten, ob Sie mir das vielleicht schreiben könnten.	推薦状を書いていただけないでしょうか？	依頼する 		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
1492	Ja, kein Problem.	はい，いいですよ。	許可を求める		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1493	Das mach' ich gern.	よろこんで書きましょう。	ある条件での行動を言う		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1494	Bis wann brauchen Sie das Schreiben denn?	いつまでに必要ですか？	情報を求める（時間）		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
1495	Hm, eigentlich spätestens bis nächsten Montag.	遅くても来週の月曜日までには。	情報を求める（時間）		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1496	Wäre das möglich?	よろしいでしょうか？	許可を求める		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1497	Ja.	はい。	同意する		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1498	Kommen Sie doch einfach am nächsten Montag vorbei.	では，来週の月曜日に寄ってください。	要求する		\N	dmod	de27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
1499	Oh Mann, ich hab' immer noch kein Geschenk für meine Schwester, und die hat schon übermorgen Geburtstag.	ああ，こまった，妹のプレゼントまだ用意してないよ。あさって妹の誕生日なんだ。	事実を述べる		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1500	Tja ... da musst du dir was einfallen lassen.	じゃあ，考えなくちゃいけないね。	意見を言う		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1501	... Hm, wie alt wird deine Schwester denn?	…それで，妹さんいくつになるの？	情報を求める（数字）		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1502	Achtzehn.	１８歳。	情報を求める（数字）		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1503	Weißt du vielleicht irgendwas?	何かあるかな？	助言する		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1504	Puh, kommt drauf an.	さあー，場合によるね。	意見を言う		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1505	Für was interessiert sie sich denn?	妹さんは何に興味があるの？	情報を求める（属性）		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1506	Ja, eigentlich liest sie ziemlich viel: Romane, Krimis und so...	そうだね，本はかなり読むんだ。小説とか，推理小説とか…。	例をあげて述べる		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1507	Hm ... auch was von ausländischen Autoren?	ふーん…，外国の作家も？	嗜好について述べる（もの）		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1509	Wie wär' s dann mit japanischer Literatur?	それなら日本文学とかはどう？	提案する		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1510	... Ich weiß nicht, vielleicht was von Haruki Murakami oder Banana Yoshimoto...	よくわからないけど、村上春樹や吉本バナナのなんか。	例をあげて述べる		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1511	Hm ja, warum eigentlich nicht?	うん，いいかも。	同意する		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1512	Welche Bücher sind denn da gut?	どの本が良いかなあ？	助言する		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1513	Ach, zum Beispiel "Kitchen" von Yoshimoto oder "Naokos Lächeln".	そうね，たとえば，吉本バナナの「キッチン」とか「ノルウェイの森」とか。	例をあげて述べる		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1514	Das ist von Murakami...	これは村上春樹のだけど。	例をあげて述べる		\N	dmod	de28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1515	Guten Tag, kann ich Ihnen helfen?	いらっしゃいませ，何かお探しですか？	挨拶をする		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1516	Ja, ich suche einen kleinen Terminkalender fürs nächste Jahr.	ええ，来年のダイアリーを探してるんですが。	依頼する		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1517	Die haben wir hier vorne.	はい，こちらにございます。	情報を求める（存在と場所）		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1518	Denken Sie an was Spezielles?	何かお決まりのものをお探しです？	情報を求める（属性）		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1519	Ja, an so 'nen kleinen Taschenkalender, der aber trotzdem für jeden Tag 'ne Seite hat.	ええと，これくらいの小さなダイアリーで，毎日で１ページになっているものがほしいんですけど。	例をあげて述べる		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1520	Oh, dann muss ich mal sehen.	では，ちょっと見てみませんと。	条件をつける		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1521	Ich glaube, die sind schon fast alle verkauft.	そういうのはもうほとんどみんな売れてしまったと思いますが…。	意見を言う		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1522	Aaahh, Moment, hier hab' ich doch noch einen.	いや，まだひとつ残ってました。	情報を求める（存在と場所）		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1523	Bitte...	どうぞ。	提案する		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[4]	\N	\N	\N
1524	Genau so einen suche ich.	はい，ちょうどこういうのを探していたんです。	事実を述べる		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1525	Aber ... die Farbe gefällt mir nicht so.	でも…，色があまり気に入らないなあ。	嗜好について述べる（もの）		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1526	Hätten Sie den vielleicht auch noch in Schwarz?	これの黒はまだありますか？	情報を求める（存在と場所）		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1527	Oh, ich glaube nicht.	ええ，たぶんないと思います。	意見を言う		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1528	Moment ... nein, tut mir Leid, es ist wirklich der letzte.	少々お待ちください,…やっぱりありませんね。申し訳ございませんが，これが本当に最後です。	場所についてたずねる		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1529	Oh, schade.	あ，それは残念。	感情を表わす		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1530	Was mach ich denn jetzt?	どうしようかなあ？			\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1531	Ja, wir kriegen dieses Jahr auch keine neuen Kalender mehr rein.	今年は新しいダイアリーの入荷も終わりましたので。	予定を言う		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1532	Hm, tja, na gut, dann nehme ich eben diesen.	そうですか，まあ，いいか，じゃあこれください。	妥協する		\N	dmod	de29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1533	Hast du vielleicht ein japanisch-deutsches Wörterbuch?	ねえ，ひょっとして和独辞書持ってる？	情報を求める（所有）		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1534	Nee, aber ein japanisch-englisches.	ううん，ないよ。和英ならあるけど。	情報を求める（所有）		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1535	Na ja, das geht auch.	まあ，それでもいいや。	妥協する		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1536	Kann ich's mal haben?	ちょっと借りてもいい？	許可を求める		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1537	Klar, steht da vorne im Regal!	もちろん，そこの前の本棚にあるよ。	情報を求める（存在と場所）		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1538	Oh, danke! (Anette nimmt das Wörterbuch aus dem Regal.)	ありがとう！（アネッテは本棚から辞書を取る。）	感謝する		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1539	... Du hast doch noch 'nen Textmarker, oder?	…ねえ，蛍光ペン持ってたっけ？	情報を求める		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1540	Jaa...	うん。	情報を求める（存在と場所）		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1541	Kann ich den mal gerade haben?	ちょっと借りてもいいかしら？	許可を求める		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1542	Ja, natürlich.	もちろん，どうぞ。	許可を求める		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1543	Danke!	ありがとう！	感謝する		\N	dmod	de30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1544	Ja, heute haben wir wirklich viele neue Vokabeln besprochen.	さあ，今日は本当にたくさん新しい単語について話しましたね。	事実を述べる		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1545	Haben Sie denn jetzt noch Fragen?	他に何か質問ありますか？	注意をひく		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1546	Schreiben wir eigentlich nächste Woche wieder einen Vokabeltest?	来週もまた単語テストがあるんですか？	予定を言う		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1547	Ja, und dafür sollten Sie lernen!	はい，テストのために勉強してください。	義務を確認する/肯定する		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1548	Müssen wir alle neuen Vokabeln lernen?	新しい単語を全部覚えなくちゃいけないのですか？	義務を確認する/肯定する		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1549	Ja, natürlich und ich gebe Ihnen jetzt auch noch einige Übungen, die Sie zu Hause machen sollten.	はい，もちろん。で，覚えられるように，家でやる練習問題を今いくつか出しますね。	義務を確認する/肯定する		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1550	Und bis wann sollen wir die machen?	で，それはいつまでにやるんですか？	義務を確認する/肯定する		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1551	Na ja, auch bis zur nächsten Stunde.	まあ，次の時間までにかな。	義務を確認する/肯定する		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1552	Oh, das ist aber ganz schön viel, was wir da machen müssen.	えー，それじゃ，やらなきゃいけない事が多すぎますよ。	事実を述べる		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1553	Tja, ohne Fleiß kein Preis.	まあ，勤勉なくして成功ならず，かな。	例を挙げて述べる		\N	dmod	de31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1554	Wow, das Bild ist aber schön!	うわぁ，この絵，すごく素敵！	嗜好について述べる		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1555	Findest du?	そう思う？	嗜好について述べる		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1556	Ja, das ist toll.	うん，すばらしい。	嗜好について述べる		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1557	Davon mach' ich jetzt mal ein Foto.	ちょっと写真取るね。	予定を言う		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1558	Was, du willst hier fotografieren?	えっ，ここで写真取るつもり？	予定を言う		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1559	Ja, wieso, ist das etwa verboten?	そうよ，どうして？ひょっとして禁止でもされているの？	禁止する		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1560	Na, ich glaub' schon.	まあ，そう思うよ。	意見を言う		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1561	In Museen darf man doch nie fotografieren.	美術館では決して撮影してはいけないんだ。	禁止する		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1562	Bist du sicher?	それは確かなの？	確認する		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1563	Warte!	待って！	指示する		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1564	Ich frage mal den Mann da hinten.	そこの人にちょっと聞いてみるよ。	予定を言う		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1565	Siehst du, ich hatte Recht.	（少し後で）ほら，ぼくが正しかった。	事実を述べる		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
1566	Das ist streng verboten.	絶対禁止だよ。	禁止する		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[4]	\N	\N	\N
1567	Ach so, schade!	そう，残念！	意見を言う		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1568	Na ja, aber an der Kasse gibt's doch bestimmt 'nen Prospekt oder Ansichtskarten mit den Bildern hier.	まあ，でもきっと窓口に，ここの絵の載ったパンフレットか絵はがきがあるよ。	予想を述べる		\N	dmod	de32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1569	Frau Köpf!	ケプフさん。	注意をひく		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1570	Ja.	はい。	注意をひく		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1571	Würden Sie bitte das Material für die Sitzung am Nachmittag vorbereiten?	午後の会議の資料を準備してくれますか。	依頼する		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1572	Ja, natürlich, Herr Schröder!	ええ，もちろんです，シュレーダーさん。	依頼する		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1573	Und wenn Sie damit fertig sind, bringen Sie mir's doch bitte sofort!	準備ができたら，すぐに私のところへ持ってきてください。	依頼する		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1574	Ja, ist in Ordnung.	はい，かしこまりました。	依頼する		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1575	Äh, Frau Köpf!	えーっと，ケプフさん，	注意をひく		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1576	Noch was...	あと…。	注意をひく		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1577	Ja?	なんでしょう？	注意をひく		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1578	Verständigen Sie doch wieder auch die anderen Abteilungen, dass die Sitzung 'ne Stunde später, also erst um 16 Uhr anfängt.	他の部署にも，会議が，１時間遅れて，つまり16時に始まることを通知してください。	依頼する		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1579	Ja, selbstverständlich, das mach' ich auch.	はい，もちろんです，伝えておきます。	依頼する		\N	dmod	de33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1580	Hey du!	（ヘッドフォンで音楽を聴きながら，クラウスは図書館で本を読んでいる）（小声で）ちょっと！	注意をひく		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1581	Meinst du mich?	オレのこと？	注意をひく		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1702	Der Himmel bewölkte sich rasch.	空はすぐに曇った。	\N		\N	vmod	\N	\N	\N	0	1
1582	Du kannst doch hier nicht einfach Musik hören!	ここで音楽なんて聞かないでよ！	非行為を依頼する		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1583	Und wieso nicht?	なんでダメなの？	理由を述べる		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1584	Mensch, weil das die anderen stört!	だって，他の人の邪魔になるでしょ！	理由を述べる		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1585	Ich habe doch 'nen Kopfhörer auf, wie du siehst.	見てのとおり，ヘッドフォンしてるじゃない。	ある条件での行動を言う		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1586	Das stört trotzdem.	それでも迷惑だよ。	ある条件での行動を言う		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1587	Kannst du deinen Walkman bitte ausschalten?	ウォークマン，切ってくれない？	要求する		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1588	Na wenn's denn sein muss.	そうしろって言うんなら。	要求する		\N	dmod	de34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1589	Gehen wir eigentlich dieses Wochenende ins Konzert?	この週末，コンサートだよね？ 	確認する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1590	Ja, genau.	うん，そうだよ。	確認する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1591	Wo ist denn noch mal die Kunsthalle?	芸術ホールってどこですか？ 	情報を求める（存在と場所） 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1592	Warst du da noch nie?	まだ行ったことないの？ 	情報を求める（経験）		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1593	Nee.	ないよ。 	情報を求める（経験）		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1594	Hmm...	うーん。	注意をひく		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1595	Soll ich dir den Lageplan mal faxen?	地図をファックスしようか？ 	義務を確認する /否定する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1596	Oder soll ich dich lieber am Bahnhof abholen?	それとも駅まで迎えに行った方が良い？ 	義務を確認する /否定する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
1597	Nee, das brauchst du nicht.	いや，それは必要ないよ。 	義務を確認する /否定する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1598	Ich glaube, ich kann das auch im Internet nachgucken.	たぶん，インターネットで調べられると思うんだ。 	理由を述べる 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1599	Na, gut!	それならいいね！ 	意見を言う		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1600	Dann treffen wir uns am Samstag um 7!	じゃあ，土曜日，７時に会おう！	提案する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1601	Gut.	うん。 	提案する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1602	Falls du dich verläufst, ruf mich an!	もし，迷ったら電話してね！ 	確認する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1603	Meine Handynummer hast du ja.	ぼくの携帯番号は持ってるよね？ 	確認する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
1604	Alles klar.	万事 OKだよ。 	確認する 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1605	Also dann bis Samstag!	じゃあ，土曜日にね！ 	予定を言う 		\N	dmod	de35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
1606	Ach, übrigens, hast du am Sonntag Zeit?	あっそうだ，日曜日，時間ある？ 	招待する 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1607	Weiß ich noch nicht...	まだ分からない。 	予定を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1608	Ich muss noch bis Montag ein Referat fertig kriegen.	月曜までにレポートを仕上げないといけないんだ。	予定を述べる		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1609	Heute ist doch erst Mittwoch!	今日はまだ水曜じゃない！ 	情報を求める（時間） 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1610	Das schaffst du schon noch bis Samstag.	土曜日までにできるよ。 	意見を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1611	Ja, mal seh'n.	うん，どうかな。 	意見を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1612	Wieso denn, was hast du denn am Sonntag vor?	ところでどうして？日曜日に何を計画してるの？ 	予定を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1613	Da kommt eine japanische Freundin zu mir.	日本人の友達が来るの。 	予定を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1614	Wir wollen zusammen Sushi machen.	一緒に寿司を作ろうと思って。 	予定を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1615	Sushi!? 	寿司！？ 	相づちを打つ 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1616	Echt?	本当？ 	相づちを打つ 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1617	Könnt ihr das wirklich selber machen?	自分達で作れるの？ 	技能と能力について尋ねる 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1618	Ja sicher.	もちろん。 	技能と能力について尋ねる 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1619	Und ... wir laden dich ein.	だから…招待するよ。 	招待する 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1620	Komm doch vorbei!	うちに来てよ。 	招待する 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1621	Au ja!	うん！ 	相づちを打つ 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1622	Das ist aber nett von euch!	それは親切だなあ！ 	感謝する 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1623	Hoffentlich schaffe ich das mit meinem Referat...	レポートが終わるといいんだけど。 	希望を述べる 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
1624	Ja, das kriegst du schon irgendwie hin.	そうだね，きっとどうにか片付けられるよ。 	意見を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1625	Also dann um acht.	それじゃ，８時に。 	予定を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1626	OK!	オッケー！ 	相づちを打つ 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
1627	Ich bringe dann etwas zu trinken mit.	じゃあ，何か飲み物でも持っていくよ。 	予定を言う 		\N	dmod	de36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
1628	Du bist heute aber blass.	今日，なんだか顔色が悪いよ。	事実を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1629	Was ist denn los?	どうしたの？	どうしているかを尋ねる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1630	Ach, ich schlafe zur Zeit nicht gut.	うん，最近よく眠れないの。	事実を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1631	Deshalb bin ich auch immer so müde.	だからいつも疲れていて。	理由を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1632	Du solltest vielleicht mehr Sport machen.	もしかすると，もっと運動したらいいんじゃない？	助言する		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1633	Ich spiele doch schon jeden Tag 'ne Stunde Fußball.	毎日一時間はサッカーしてるんだけど。	事実を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1634	Tja, das sollte eigentlich genug sein.	そうなの，じゃあ十分なはずだね。	意見を言う		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1635	Hm... trink doch mal 'ne Tasse Tee mit Honig vorm Schlafen.	寝る前に紅茶に蜂蜜を入れて飲んでみたら。	助言する		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1636	Das hab' ich auch schon probiert.	それもやってみたの。	情報を求める（経験）		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1637	Das wirkt bei mir aber leider nicht.	でも，私には効かないよ。	事実を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1638	Willst du dann nicht mal zum Arzt gehen?	じゃあ，一度医者に行ってみない？	助言する		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1639	Nein, das ist auch wieder übertrieben...	ううん，それはまた大げさね…。	情報を求める（程度）		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1640	Na ja, wenn er doch bloß keine Freundin hätte...	あーあ，彼に恋人さえいなかったらなあ。	希望を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1641	Wie?	ええっ？	指示するものについて尋ねる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1642	Was?	なにを？	指示するものについて尋ねる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
1643	Ach so, du hast Liebeskummer!	ああそうなの，恋の悩みね！	事実を述べる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
1644	Und wer ist ER überhaupt?	それで，「彼」って一体誰？	指示するものについて尋ねる		\N	dmod	de37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[4]	\N	\N	\N
1645	Du Andrea, du warst doch auch letzte Woche hier in der Vorlesung?	ねえアンドレア，先週もこの講義に出てた？	経験についてたずねる		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1646	Na klar.	うん，もちろん。	情報を求める（経験）		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1647	Aber du warst nicht da.	でもイーナはいなかったよね？	情報を求める（経験）		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1648	Warum eigentlich?	どうしたの？	理由を述べる		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
1649	Hast du verschlafen?	寝坊した？	情報を求める（経験）		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	\N
1650	Äh ... ja.	えっと…そうなの。	肯定する		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1651	Also ich hab' am Tag vorher bis zwei Uhr nachts gearbeitet und ich konnt' dann einfach nicht mehr...	というのも，前の日，２時まで勉強してて，そしたらもう…。	情報を求める（経験）		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1652	Ah ja.	そうか。	相づちを打つ		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1653	Du musstest ja, bis Freitag, glaub' ich, dieses Referat fertig kriegen.	確か金曜までにあのレポートを仕上げなくちゃいけなかったんだよね。	情報を求める（経験）		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1654	Genau...	そのとおり。	相づちを打つ		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1655	Ach, hör mal, kannst du mir vielleicht deine Notizen von der letzten Woche leihen?	それでね，先週のノート貸してくれるかな？	要求する		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1656	Ich würd' sie dir dann beim nächsten Mal wiedergeben.	この次に返すから。	予定を言う		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1657	Ja klar.	いいよ。	相づちを打つ		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1658	Moment ... hier, bitte!	待ってね…，はいどうぞ。	人にものをあげる		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1659	Hey, danke!	うわあ，ありがとう！	感謝する		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1661	Kein Problem.	いえいえ。	感謝する		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1662	Aber sag mal, kannst du meine Schrift überhaupt lesen?	でもね，そもそも私の字，読める？	可能性を述べる		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1663	Hmm, es geht.	うーん，なんとか。	可能性を述べる		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1664	Ist schon ein bisschen schwierig...	確かにちょっと難しいね。	情報を求める（属性）		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1665	Das sagen alle.	みんなそう言うよ。	事実を述べる		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1666	Na ja, du kannst mich ja fragen, wenn du was nicht verstehst.	読めないところあったら聞いてね。	ある条件での行動を言う		\N	dmod	de38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
1667	Äh, was willst du denn eigentlich nach dem Studium machen?	ところで，大学出たら，どうするの？	希望を述べる		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1668	Ich will Staatsanwältin werden.	検察官になるつもりよ。 	希望を述べる 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1669	Dieser Koffer ist ziemlich schwer.	このスーツケースはかなり思い。	情報を求める（属性） 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1670	Ja, ist es auch.	実際大変だよ。 	情報を求める（属性） 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1671	Ich muss zwei Staatsexamen bestehen.	国家試験に２つ合格しなくちゃいけないの。 	義務を確認する /肯定する 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1672	Und du?	それで，オラフは？ 	希望を述べる 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
1673	Was willst du später mal machen?	将来何をするつもり？ 	希望を述べる 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	1
1674	Ich möchte als Programmierer arbeiten.	プログラマーとして働きたいんだ。 	希望を述べる		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1675	Stimmt, du studierst ja auch Informatik!	そうだ，情報学専攻だったね。 	確認する 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1676	Ja, genau.	そのとおり。 	相づちを打つ 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1677	Also ... wenn du mal mit deinem Computer Probleme hast, helfe ich dir gerne!	だから，コンピュータで困ったら，助けてあげるからね。 	ある条件での行動を言う 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1678	Das ist aber nett, Olaf!	それはご親切に，オラフ。 	感謝する 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1679	Hast du heute vielleicht Zeit?	（笑いながら）今日，時間ある？ 	予定を言う 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1680	Wieso?	どうして？ 	理由を述べる 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1681	Ist dein Computer etwa kaputt?	コンピュータが壊れたの？ 	理由を述べる 		\N	dmod	de39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1682	Guten Tag, Herr Professor Fischer.	こんにちは，フィッシャー先生。	挨拶をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1683	Grüß Gott, Frau Hoffmann.	こんにちは，ホフマンさん。	挨拶をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1684	Darf ich Ihnen Frau Schneider vorstellen?	シュナイダーさんをご紹介してもよろしいですか？	人を紹介する		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1685	Sie promoviert jetzt in Heidelberg und würde gern im nächsten Semester an unserem Seminar teilnehmen.	今ハイデルベルクで博士論文を書いていて，来学期，先生のゼミに参加したいそうです。	人を紹介する		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1686	Frau Schneider, das ist Herr Professor Fischer.	シュナイダーさん，こちらがフィッシャー先生です。	人を紹介する		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
1687	Guten Tag, Herr Professor Fischer.	こんにちは，フィッシャー先生。	挨拶をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1688	Freut mich, Sie kennen zu lernen.	お目にかかれて光栄です。	挨拶をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1689	Grüß Gott, Frau Schneider.	こんにちは，シュナイダーさん。	挨拶をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1690	Angenehm.	初めまして。	挨拶をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1691	Bitte nehmen Sie doch Platz.	どうぞお座りください。	指示をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1692	Danke...	ありがとうございます。	感謝する		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1693	Ja, Frau Schneider, ich freue mich, dass Sie Interesse an unserem Seminar haben.	シュナイダーさん，私達のゼミに興味を持ってくれて嬉しいです。	意見を言う		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1694	Sagen Sie, woran arbeiten Sie denn eigentlich genau?	それで詳しく言うと，何について研究しているのですか？	自己紹介する		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1695	Ich mache eine kontrastive Studie zum Artikelgebrauch im Deutschen und Französischen.	ドイツ語とフランス語における冠詞使用の対照研究をしています。	自己紹介をする		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1696	Ach, das ist ja interessant.	そうですか，それはおもしろそうですね。	意見を言う		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1697	Da können Sie doch wunderbar auch in unserem Seminar über Ihre Arbeit berichten.	それならちょうどこのゼミでも，あなたの研究について発表してもらえますね。	依頼する		\N	dmod	de40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1699	Das Auto biegt um die Ecke.	車が角を曲る。	\N		\N	vmod	\N	\N	\N	0	1
1700	Sie bogen sich alle vor Lachen.	彼らはみんな腹をかかえて笑った。	\N		\N	vmod	\N	\N	\N	0	1
1701	Ich bin jetzt beschäftigt.	私は今手が離せない（とても忙しい）。	\N		\N	vmod	\N	\N	\N	0	1
1713	In Tokio leben viele Ausländer.	東京には外国人がたくさん住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1714	Er ist ein ausländischer Student aus der Türkei.		\N		\N	vmod	\N	\N	\N	0	1
1715	Er ist ein ausländischer Student aus der Türkei.	彼はトルコ出身の留学生だ。	\N		\N	vmod	\N	\N	\N	0	1
1716	Zieh dir die Schuhe aus!	靴を脱いで！	\N		\N	vmod	\N	\N	\N	0	1
1717	Der Himmel klärt sich auf.	空が晴れる。	\N		\N	vmod	\N	\N	\N	0	1
1718	Ich möchte ins Ausland reisen.	私は外国へ旅行に行きたい。	\N		\N	vmod	\N	\N	\N	0	1
1719	Er ist gerade im Bad.	彼は今お風呂に入っている。	\N		\N	vmod	\N	\N	\N	0	1
1720	Sie hat den Aschenbecher ausgeleert.	彼女は灰皿を空けた。	\N		\N	vmod	\N	\N	\N	0	1
1721	Sie ist eine berühmte Künstlerin.	彼女は有名な芸術家だ。	\N		\N	vmod	\N	\N	\N	0	1
1722	Der Hund hat ihm ins Bein gebissen. 	犬が彼の足にかみついた。	\N		\N	vmod	\N	\N	\N	0	1
1723	Wir leihen uns aus der Bibliothek Bücher aus.	私たちは図書館から本を借りる。	\N		\N	vmod	\N	\N	\N	0	1
1724	Sie klebte die Briefmarke auf den Brief.	彼女は手紙に切手を貼った。	\N		\N	vmod	\N	\N	\N	0	1
1725	Anfang April fängt das neue Semester an.	４月初めに新学期が始まる。	\N		\N	vmod	\N	\N	\N	0	1
1726	Die Mutter zieht dem Kind einen Mantel an.	お母さんが子供にコートを着せる。	\N		\N	vmod	\N	\N	\N	0	1
1727	Der neue Anzug steht ihm gut.	その新しいスーツは彼によく似合う。	\N		\N	vmod	\N	\N	\N	0	1
1728	Das Apartment liegt direkt am Meer.	そのアパートは海辺に位置している。	\N		\N	vmod	\N	\N	\N	0	1
1729	Er erfasste die Bedeutung ihres Wortes nicht.	彼は彼女の言葉の意味が掴めなかった。	\N		\N	vmod	\N	\N	\N	0	1
1730	Der Arzt tastete seinen Bauch ab.	医者は彼のお腹を触診した。	\N		\N	vmod	\N	\N	\N	0	1
1731	Das Mädchen trägt ein blaues Kleid.	女の子はブルーのワンピースを着ている。	\N		\N	vmod	\N	\N	\N	0	1
1732	Wir suchen ein billiges Hotel oder eine Jugendherberge.	私たちは安いホテルかユースホステルを探している。	\N		\N	vmod	\N	\N	\N	0	1
1733	Das Kind zeichnet mit dem Bleistift die Bilder.	子供が鉛筆で絵を書く。	\N		\N	vmod	\N	\N	\N	0	1
1734	"Mama, krieg ich noch ein leckeres Bonbon?"	”ママ，ぼく飴をもう一つ食べてもいい？”	\N		\N	vmod	\N	\N	\N	0	1
1735	Wo liegt die deutsche Botschaft in Japan?	在日ドイツ大使館はどこにありますか？	\N		\N	vmod	\N	\N	\N	0	1
1736	Sie hat braune Augen und eine braune Haarfarbe.	彼女は茶色の目に茶髪である。	\N		\N	vmod	\N	\N	\N	0	1
1737	Der Briefkasten steht direkt am Haupteingang vom Hotel.	郵便ポストはホテルの中央入口のすぐ近くにある。	\N		\N	vmod	\N	\N	\N	0	1
1738	Sie hat dick Butter aufs Brot gestrichen.	彼女はパンにバターを厚く塗った。	\N		\N	vmod	\N	\N	\N	0	1
1739	Dieses Brot wird zum Frühstück frisch gebacken und noch warm serviert.	このパンは朝食のときに焼かれ，温かいうちに食卓に並べられる。	\N		\N	vmod	\N	\N	\N	0	1
1740	In diesem Kurs lernen die Teilnehmer chinesische Zeichen lesen und schreiben.	このコースで参加者たちは漢字の読み方と書き方を習う。	\N		\N	vmod	\N	\N	\N	0	1
1741	Mein Sohn mag sehr gerne Curry.	私の息子はカレーは大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1742	Mein Cousin wohnt in Köln.	私のいとこはケルンに住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1743	Auf jeden Dezember folgt wieder ein Mai.	１２月のあとには必ず５月が来る。（（諺）苦あれば楽あり）	\N		\N	vmod	\N	\N	\N	0	1
1744	Das Zimmer ist mir zu dunkel.	この部屋は暗すぎる。	\N		\N	vmod	\N	\N	\N	0	1
1745	Das Brot ist in dünne Scheiben geschnitten.	パンは薄切りにしてある。	\N		\N	vmod	\N	\N	\N	0	1
1746	Ich wollte ihn eben anrufen, als er eintrat.	ちょうど私が彼に電話しようとしたとき彼が入ってきた。	\N		\N	vmod	\N	\N	\N	0	1
1747	Das Ehepaar Meyer hat drei Kinder.	マイヤー氏夫婦は３人の子供がいる。	\N		\N	vmod	\N	\N	\N	0	1
1748	Viele essen gerne ein gekochtes Ei zum Frühstück.	多くの人が朝食にゆで卵を食べる。	\N		\N	vmod	\N	\N	\N	0	1
1749	Das Gebäude hat zwei Eingänge.	この建物は入口が二つある。	\N		\N	vmod	\N	\N	\N	0	1
1750	Gesundes Essen fängt beim Einkauf an.	ヘルシーな食事は買い物のときから始まる。	\N		\N	vmod	\N	\N	\N	0	1
1751	Wir sind in Tokio in einen falschen Zug eingestiegen.	私たちは東京で違う電車に乗り込んでしまった。	\N		\N	vmod	\N	\N	\N	0	1
1753	Kinder reden, Erwachsene hören zu.	子供たちが話して，大人たちはそれに耳を傾ける。	\N		\N	vmod	\N	\N	\N	0	1
1754	Er hat für morgen eine Fahrkarte nach München gelöst.	彼は明日のためにミュンヘン行きの切符を買った。	\N		\N	vmod	\N	\N	\N	0	1
1755	Wir haben gestern das Fußballspiel im Fernsehen gesehen.	私たちは昨日テレビでサッカーの試合を観た。	\N		\N	vmod	\N	\N	\N	0	1
1756	Er wohnt fern von dieser Stadt.	彼はこの町から遠く離れて住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1757	Auf dem Film sind noch drei Bilder.	フィルムはまだ３枚分残っている。	\N		\N	vmod	\N	\N	\N	0	1
1758	Mein Sohn isst sehr gerne Fleisch.	私の息子は肉食が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1759	Das Flugzeug ist pünktlich gelandet.	飛行機は定刻に着陸した。	\N		\N	vmod	\N	\N	\N	0	1
1760	Der Schrank steht im Flur.	ロッカーは廊下にある。	\N		\N	vmod	\N	\N	\N	0	1
1761	Sie wohnen auf dem gleichen Flur.	彼らは同じフロアに住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1762	Er ist immer so lustig und macht viele Witze.	彼はいつも面白くて，よく冗談を言う。	\N		\N	vmod	\N	\N	\N	0	1
1763	Dass frische Früchte und Gemüse gesund sind, weiß eigentlich jeder.	新鮮な果物と野菜が健康に良いことは誰もが知っている。	\N		\N	vmod	\N	\N	\N	0	1
1764	Wenn die Kirschen blühen, kommt der Frühling.	桜が咲くと春がやってくる。	\N		\N	vmod	\N	\N	\N	0	1
1765	Um wie viel Uhr gibt es Frühstück?	朝食は何時ですか？	\N		\N	vmod	\N	\N	\N	0	1
1766	Ich habe von meinem Vater einen Füllfederhalter geschenkt bekommen.	私はお父さんから万年筆のプレゼントをもらった。	\N		\N	vmod	\N	\N	\N	0	1
1767	Zu Fuß dauert es etwa fünf Minuten.	徒歩で５分くらいかかる。	\N		\N	vmod	\N	\N	\N	0	1
1768	Wenn man große Füße hat, ist es schwer gescheite Schuhe zu finden. 	足が大きい人はちゃんとした靴を見つけるのが難しい。	\N		\N	vmod	\N	\N	\N	0	1
1769	Was machst du eigentlich den ganzen Tag?	君は一日中一体何をしているの？	\N		\N	vmod	\N	\N	\N	0	1
1770			\N		\N	vmod	\N	\N	\N	0	1
1771	Das neue Gebäude wird nächstes Jahr fertig.	その新しい建物は来年完成する。	\N		\N	vmod	\N	\N	\N	0	1
1772	Das Gebäude steht an einer der Hauptstraßen.	その建物はメインストリートの一角に建っている。	\N		\N	vmod	\N	\N	\N	0	1
1773	Meistens kaufen wir beim Gemüsehändler um die Ecke.	私たちはたいてい角を曲がった所の八百屋さんで（野菜を）買う。	\N		\N	vmod	\N	\N	\N	0	1
1774	Was muss man beim Gespräch mit den Kunden beachten?	顧客と話すとき注意を払うべき点は何ですか？	\N		\N	vmod	\N	\N	\N	0	1
1775	Welche Getränke gibt es zu den Mahlzeiten?	食事にはどんな飲み物がありますか？	\N		\N	vmod	\N	\N	\N	0	1
1776	Es sind 20 Grad draußen.	外は２０度だ。	\N		\N	vmod	\N	\N	\N	0	1
1777	Ich bin in Wien bei meiner Großmutter aufgewachsen.	私はウィーンにあるおばあさんのところで育った。	\N		\N	vmod	\N	\N	\N	0	1
1778	Mein Gepäck ist während der Reise verloren gegangen.	私の荷物は旅行の間になくなってしまった。	\N		\N	vmod	\N	\N	\N	0	1
1779	Er ist sehr gesellig und immer dazu bereit, neue Freunde zu finden.	彼はとても社交的で，常に新しい友達を見つける準備ができている。	\N		\N	vmod	\N	\N	\N	0	1
1780	Ihr Gesicht strahlte vor Freude.	彼女の顔はうれしさで光り輝いていた。	\N		\N	vmod	\N	\N	\N	0	1
1781	Ich war fünf Jahre alt, als mein Großvater starb. Ich vermisse ihn sehr.	私のおじいさんは私が５歳のときに亡くなった。私は彼をとても懐かしく思う。	\N		\N	vmod	\N	\N	\N	0	1
1782	Viele Bäume sind bereits grün und auf den Wiesen blühen Blumen.	木々はもう緑色で，草原の上には花が咲き乱れている。	\N		\N	vmod	\N	\N	\N	0	1
1783	Ich hasse Leute, die im Auto mit dem Handy telefonieren.	私は車の中で携帯で電話する人たちが嫌いだ。	\N		\N	vmod	\N	\N	\N	0	1
1784	Ich muss die Hausaufgaben fertig machen, bevor Franz kommt.	私はフランツが来る前に宿題を終えなくてはならない。	\N		\N	vmod	\N	\N	\N	0	1
1785	An heißen Tagen gehe ich gern schwimmen.	暑い日には私はよく泳ぎに行く。	\N		\N	vmod	\N	\N	\N	0	1
1786			\N		\N	vmod	\N	\N	\N	0	1
1787	Im Herbst färbt sich das Laub herrlich bunt.	秋には木の葉が鮮やかに色づく。	\N		\N	vmod	\N	\N	\N	0	1
1788	Wenn Ihr keine CDs mehr im Laden kauft, dann können wir keine Musik mehr machen.	あなたがたがCDを店で買わないと，私たちはこれ以上音楽を作ることができない。	\N		\N	vmod	\N	\N	\N	0	1
1789	Sie hat lange Haare.	彼女は髪の毛が長い。	\N		\N	vmod	\N	\N	\N	0	1
1790	Die Länge des Rheins beträgt 1320 km.	ライン川の長さは1320kmである。	\N		\N	vmod	\N	\N	\N	0	1
1791	Der Film ist langweilig.	あの映画はつまらない。	\N		\N	vmod	\N	\N	\N	0	1
1792	Mein Mann arbeitet demnächst für zwei Jahre im Ausland.	夫は海外で働いてもうすぐ２年になる。	\N		\N	vmod	\N	\N	\N	0	1
1793	Bei mir wirkt dieses Medikament auf jeden Fall sehr gut.	私にはこの薬がいつもよく効く。	\N		\N	vmod	\N	\N	\N	0	1
1794	Meine Großmutter geht jeden Monat einmal zum Arzt.	私のおばあさんは月に一度医者に行く。	\N		\N	vmod	\N	\N	\N	0	1
1795	Manchmal telefoniere ich mit ihm.	時々私は彼と電話で話す。	\N		\N	vmod	\N	\N	\N	0	1
1796	Darf ich den roten Mantel mal probieren?	あの赤いコートを試着してみてもいいですか？	\N		\N	vmod	\N	\N	\N	0	1
1797	Meine Nichte wird diesen Monat fünf Jahre alt.	私の姪は今月で５歳になる。	\N		\N	vmod	\N	\N	\N	0	1
1798	Wie viele Bücher hast du letzten Monat gelesen?	先月君は何冊の本を読んだの？	\N		\N	vmod	\N	\N	\N	0	1
1799	Anfang Mai planen wir eine kleine Reise nach Hawaii. 	私たちは５月初めにハワイへの小旅行を計画している。	\N		\N	vmod	\N	\N	\N	0	1
1800	Der Mensch lebt nicht vom Brot allein.	人はパンだけで生きるものではない。（聖書）	\N		\N	vmod	\N	\N	\N	0	1
1801	Gegrillte Hähnchen werden mit Messer und Gabel gegessen.	グリルしたチキンはナイフとフォークで食べる。	\N		\N	vmod	\N	\N	\N	0	1
1802	Das Kind trinkt täglich ca. ein Liter Milch.	子供は毎日１リットルの牛乳を飲む。	\N		\N	vmod	\N	\N	\N	0	1
1803	Heute Mittag habe ich einen Termin in der Klinik.	今日の昼に私は病院に（診察の）予約をしている。	\N		\N	vmod	\N	\N	\N	0	1
1804	Der Marktplatz liegt in der Mitte der Stadt.	広場は都市の真ん中にある。	\N		\N	vmod	\N	\N	\N	0	1
1805	In diesem Sommer werde ich für zwei Monate im New Yorker Büro arbeiten.	この夏，私は２ヶ月間ニューヨークの事務所で働く。	\N		\N	vmod	\N	\N	\N	0	1
1806	Nächsten Monat ziehe ich aus beruflichen Gründen nach Berlin.	来月私は仕事の都合でベルリンへ引っ越す。	\N		\N	vmod	\N	\N	\N	0	1
1807	"Was ist dein Lieblingssport?" ― "Mein Lieblingssport ist Fußball."	「好きなスポーツは何？」 ― 「私はサッカーが大好きだよ。」	\N		\N	vmod	\N	\N	\N	0	1
1808	Er stand mit offenem Mund da und dachte an nichts.	彼は口を開けたままそこに立って，何も考えていなかった。	\N		\N	vmod	\N	\N	\N	0	1
1809	Das Kind hat Fieber und sieht trotzdem munter aus.	あの子は熱があっても元気そうに見える。	\N		\N	vmod	\N	\N	\N	0	1
1810	Der nächste Bahnhof ist 10 km entfernt.	最寄り駅は１０キロ離れている。	\N		\N	vmod	\N	\N	\N	0	1
1811	Das Hotel liegt ganz nahe am Meer.	そのホテルは海のすぐ近くにある。	\N		\N	vmod	\N	\N	\N	0	1
1812	Der Schreibtisch ist zu niedrig für mich.	この机は私には低すぎる。	\N		\N	vmod	\N	\N	\N	0	1
1813	Im November findet jährlich das Unifest statt. 	毎年１１月には大学祭が開催される。	\N		\N	vmod	\N	\N	\N	0	1
1814	Zum Frühstück esse ich meistens nur Obst.	私は朝食はふつう果物だけ食べる。	\N		\N	vmod	\N	\N	\N	0	1
1815	Alle Kinder wärmen sich am Ofen.	子供たちはみんなストーブの所で身体を温めている。	\N		\N	vmod	\N	\N	\N	0	1
1816	Er hat gute Ohren.	彼は耳がいい。	\N		\N	vmod	\N	\N	\N	0	1
1817	Das Wintersemester beginnt am 1. Oktober.	冬学期は１０月１日に始まる。	\N		\N	vmod	\N	\N	\N	0	1
1818	Nehmen Sie ein Blatt Papier zur Hand und schreiben Sie Ihren Namen in die Mitte des Papiers. 	紙を一枚手に取り，紙の真ん中にお名前を書いてください。	\N		\N	vmod	\N	\N	\N	0	1
1819	Im Park tummeln sich viele Kinder.	公園ではたくさんの子供たちが走り回っている。	\N		\N	vmod	\N	\N	\N	0	1
1820	Direkt neben dem Bahnhof liegt eine Polizeiwache.	駅のすぐ隣に交番がある。	\N		\N	vmod	\N	\N	\N	0	1
1821	Er will wie sein Vater Polizist werden.	彼は自分の父のように警察官になろうとしている。	\N		\N	vmod	\N	\N	\N	0	1
1822	Am Wochenende gehe ich gerne ins Schwimmbad.	週末にはプールによく行く。	\N		\N	vmod	\N	\N	\N	0	1
1823	Das Handy ist wirklich praktisch.	携帯電話は本当に便利だ。	\N		\N	vmod	\N	\N	\N	0	1
1824	Er hat Probleme mit seiner Freundin.	彼は彼女のことで悩んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1825	Deutschland hat ein ernstes Arbeitslosenproblem.	ドイツは深刻な失業者問題を抱えている。	\N		\N	vmod	\N	\N	\N	0	1
1826	Sie trägt gern eine Jeans und einen Pullover.	彼女はジーンズとセーターをよく着る。	\N		\N	vmod	\N	\N	\N	0	1
1827	Das Bad und die Toilette sollte man häufig putzen.	お風呂とトイレは頻繁に掃除すべきだ。	\N		\N	vmod	\N	\N	\N	0	1
1828	Nimm einen Regenschirm mit! Vielleicht regnet es heute Abend wieder.	傘を持っていきなさい。今晩また雨が降るかもしれないわよ。	\N		\N	vmod	\N	\N	\N	0	1
1829	Das chinesische Restaurant ist wegen seiner besonderen Atmosphäre beliebt.	あの中国レストランはその独特な雰囲気で評判が良い。	\N		\N	vmod	\N	\N	\N	0	1
1830	Hindus essen kein Rindfleisch, Moslems kein Schweinefleisch.	ヒンズー教徒は牛肉を食べず，イスラム教徒は豚肉を食べない。	\N		\N	vmod	\N	\N	\N	0	1
1831	Stockholm ist eine sehr saubere und ruhige Stadt.	ストックホルムはとてもきれいで静かな都市である。	\N		\N	vmod	\N	\N	\N	0	1
1832	Ich war letztes Jahr in Italien und vorletztes Jahr in Frankreich, beide im August.	私は，昨年はイタリアへ，おととしはフランスへ行った。いずれも８月だった。	\N		\N	vmod	\N	\N	\N	0	1
1833	Hier hast du den Schlüssel zu meinem Zimmer. Ich komme gleich nach.	これが私の部屋の鍵です。私もすぐ来ます。	\N		\N	vmod	\N	\N	\N	0	1
1834	Da ich sowieso gerne scharf esse, waren die Nudeln für mich nicht sehr scharf.	私は辛いものが好きだから，そのラーメンは私にはそれほど辛くなかった。	\N		\N	vmod	\N	\N	\N	0	1
1835	Jedes alte Bier schmeckt schlecht.	古いビールはどれもまずい。	\N		\N	vmod	\N	\N	\N	0	1
1836	Doch mein Kopf schmerzt und ich fühle mich nicht gut.	頭が痛くて気分がすぐれない。	\N		\N	vmod	\N	\N	\N	0	1
1837	Der Berggipfel ist selbst im Sommer mit Schnee bedeckt.	その山の頂上は夏でさえ雪で覆われている。	\N		\N	vmod	\N	\N	\N	0	1
1838	Sein Englisch ist schlecht, aber besser als mein Italienisch.	彼は英語が下手だ。でも私のイタリア語よりはましだ。	\N		\N	vmod	\N	\N	\N	0	1
1839	Die Suppe war wirklich lecker.	そのスープは本当においしかった。	\N		\N	vmod	\N	\N	\N	0	1
1840	Zu viel Salz kann den Blutdruck erhöhen.	塩分の取りすぎは血圧を上げる恐れがある。	\N		\N	vmod	\N	\N	\N	0	1
1841	Er sammelt alte Schallplatten, die er teilweise wieder verkauft.	彼は古いレコードを集めているが，中には再び売るものもある。	\N		\N	vmod	\N	\N	\N	0	1
1842	Früher hat mir immer meine Mutter die Haare geschnitten.	以前はいつも母が髪の毛を切ってくれた。	\N		\N	vmod	\N	\N	\N	0	1
1843	Schweinefleisch enthält vor allem Vitamin B1 und B6.	豚肉はとりわけビタミンB1とB6を含んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1845	Die Sojasoße stammt ursprünglich aus China.	醤油は本来中国に由来する。	\N		\N	vmod	\N	\N	\N	0	1
1846	Es war schon sehr spät und eigentlich waren wir müde.	すでに（時間が）遅かったし，私たちは疲れていた。	\N		\N	vmod	\N	\N	\N	0	1
1847	Übung macht den Meister.	（諺）修練なくして名人なし	\N		\N	vmod	\N	\N	\N	0	1
1848	Ich habe zu Weihnachten eine Uhr geschenkt bekommen.	私はクリスマスに時計のプレゼントをもらった。	\N		\N	vmod	\N	\N	\N	0	1
1849	Das Kind putzt sich die Zähne.	子供は歯を磨く。	\N		\N	vmod	\N	\N	\N	0	1
1850	Ich trinke sehr gerne Tee mit Zitrone.	私はレモンティが好きだ（よく飲む）。	\N		\N	vmod	\N	\N	\N	0	1
1851	Berlin meldet heiter bis wölkig bei 27 Grad.	ベルリンは27度で晴れのち曇りだそうだ。	\N		\N	vmod	\N	\N	\N	0	1
1852	Wir planen zur Zeit schon eine Reise für das übernächste Jahr.	私たちはもう再来年の旅行の計画を立てている。	\N		\N	vmod	\N	\N	\N	0	1
1853	Katakana wird hauptsächlich benutzt, um Fremdwörter und ausländische Namen zu schreiben.	片仮名は主に，外来語や外国人の名前を書くのに用いられる。	\N		\N	vmod	\N	\N	\N	0	1
1854	Wo ist die nächste U-Bahn-Station?	最寄の地下鉄の駅はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1855	Sie übt jeden Tag drei Stunden Piano.	彼女は毎日３時間ピアノの練習をしている。	\N		\N	vmod	\N	\N	\N	0	1
1856	Ich studiere seit zwei Jahren an der Universität in Tokio.	私は２年前から東京の大学で勉強している。	\N		\N	vmod	\N	\N	\N	0	1
1857	Ich habe fast jeden Vormittag Unterricht.	私は午前中はたいてい授業が入っている。	\N		\N	vmod	\N	\N	\N	0	1
1858	Diese Bibliothek hat 2 Mio. Exemplare in ihrem Bestand.	この図書館は200万冊の本を所蔵している。	\N		\N	vmod	\N	\N	\N	0	1
1859	Wir schreiben jede Woche einen Vokabeltest.	私たちは毎週単語テストを受ける。	\N		\N	vmod	\N	\N	\N	0	1
1860	Diese Woche habe ich viel zu tun.	今週はとても忙しい（することが多い）。	\N		\N	vmod	\N	\N	\N	0	1
1861	Wahrscheinlich regnet es morgen.	明日は多分雨が降るだろう。	\N		\N	vmod	\N	\N	\N	0	1
1862	Das weiße Hemd trägt er ohne Krawatte, dazu Jeans.	彼はノーネクタイで白いシャツを着て，それにジーンズを穿いている。	\N		\N	vmod	\N	\N	\N	0	1
1863	Ihr Gesicht war weiß wie Schnee.	彼女の顔は雪のように白かった。	\N		\N	vmod	\N	\N	\N	0	1
1864	Wir haben eine möblierte Wohnung gemietet.	私たちは家具つき家を借りた。	\N		\N	vmod	\N	\N	\N	0	1
1865	Während der Reis kocht, bereite ich ein Dessert vor.	ご飯を炊く間に，私はデザートを用意する。	\N		\N	vmod	\N	\N	\N	0	1
1866	In Japan isst man sehr viel Reis.	日本ではご飯をたくさん食べる。	\N		\N	vmod	\N	\N	\N	0	1
1867	Das Kind räumt sein Zimmer auf und bekommt dafür was Süßes.	子供は自分の部屋を片付けて，その代償として甘い物をもらう。	\N		\N	vmod	\N	\N	\N	0	1
1868	Jeden Morgen steht er um 5 auf und rennt ein paar Stunden im Park herum.	彼は毎朝５時に起きて，公園の周りを２～３時間走る。	\N		\N	vmod	\N	\N	\N	0	1
1869	Sie sind gerade von der Reise zurückgekehrt.	彼らはたった今旅行から帰ってきたところだ。	\N		\N	vmod	\N	\N	\N	0	1
1870	Bist du beim Lesen auf fremde Wörter gestoßen, schlage ihre Bedeutung im Wörterbuch nach.	読書中にわからない単語にぶつかったら，辞書でその意味を調べてください。	\N		\N	vmod	\N	\N	\N	0	1
1871	Das Kind isst die warme Suppe mit dem Löffel.	子供はスプーンで温かいスープを食べる。	\N		\N	vmod	\N	\N	\N	0	1
1872	Sie stellt den Wecker und löscht die Kerze.	彼女は目覚まし時計をセットして，ロウソクを消す。	\N		\N	vmod	\N	\N	\N	0	1
1873	Biegen Sie hier nach links ab.	ここで左折してください。	\N		\N	vmod	\N	\N	\N	0	1
1874	Nehmen Sie den Aufzug oder die Treppe.	エレベーターか階段を利用してください。	\N		\N	vmod	\N	\N	\N	0	1
1875	Ich bin gestern Abend hier angekommen.	私は昨日の夕方ここに着いた。	\N		\N	vmod	\N	\N	\N	0	1
1876	Mitte August haben wir eine Woche Urlaub.	８月半ばに私たちは１週間の休暇をとる。	\N		\N	vmod	\N	\N	\N	0	1
1877	Möchten Sie ein Zimmer mit Bad oder Dusche?	バス付きの部屋かシャワー付きの部屋，どちらになさいますか？	\N		\N	vmod	\N	\N	\N	0	1
1878	Sein Besuch hat eine große Bedeutung für uns.	彼の訪問は我々にとって大きな意味がある。	\N		\N	vmod	\N	\N	\N	0	1
1879	die deutsche Sprache	ドイツ語	\N		\N	vmod	\N	\N	\N	0	1
1880	Muttersprache	母国語	\N		\N	vmod	\N	\N	\N	0	1
1881	Fremdsprache	外国語	\N		\N	vmod	\N	\N	\N	0	1
1882	Wer keine Fremdsprache kennt, kennt seine Muttersprache nicht. (Johann Wolfgang Geothe)	外国語を知らない人は母国語も知らない。（ゲーテ）	\N		\N	vmod	\N	\N	\N	0	1
1883	Ich habe zwei Geschwister, einen Bruder und eine Schwester. Ich bin die älteste.	私は兄弟が２人いる。弟と妹。私が一番年上である。	\N		\N	vmod	\N	\N	\N	0	1
1884	Das Kind kann die Strümpfe schon selber anziehen.	あの子はもう自分で靴下が履ける。	\N		\N	vmod	\N	\N	\N	0	1
1885	Kniestrumpf	ハイソックス	\N		\N	vmod	\N	\N	\N	0	1
1886	Diese Schokolade gefällt mir nicht. Sie ist zu süß.	このチョコレートはあまり好きじゃない。甘すぎるから。	\N		\N	vmod	\N	\N	\N	0	1
1887	Das Krankenhaus liegt fünf Minuten zu Fuß vom Hauptbahnhof.	その病院は中央駅から歩いて５分の所にある。	\N		\N	vmod	\N	\N	\N	0	1
1888	Sie trägt oft Krawatten und es sieht auch gut aus.	彼女は時々ネクタイをしているが，それもよく似合う。	\N		\N	vmod	\N	\N	\N	0	1
1889	qas		\N		\N	vmod	\N	\N	\N	0	1
1890	Die alte Frau stand an der Ampel und wartete auf Grün. 	老婦人は信号のところに立って，（信号が）青になるのを待っていた。	\N		\N	vmod	\N	\N	\N	0	1
1891	Er ist vor Aufregung vom Stuhl aufgestanden.	彼は興奮のあまり椅子から立ち上がった。	\N		\N	vmod	\N	\N	\N	0	1
1892	Das Kind wurde gleich ausgezogen und ins Bad gebracht.	子供はすぐに洋服を脱がされ，浴室に連れて行かれた。	\N		\N	vmod	\N	\N	\N	0	1
1893	Die Sache hat sich schon aufgeklärt.	事態の真相はすでに明らかになった。	\N		\N	vmod	\N	\N	\N	0	1
1894	Heute gehe ich zur Bank, um ein Konto zu eröffnen.	私は今日口座を作るため銀行に行く。	\N		\N	vmod	\N	\N	\N	0	1
1895	Die Lampe kann sowohl an der Wand als auch an der Decke befestigt werden.	このランプは，壁にも天井にも取り付けられる。	\N		\N	vmod	\N	\N	\N	0	1
1896	Das Ereignis hat unsere Freundschaft sehr befestigt.	その出来事が私たちの友情（きずな）を強めた。	\N		\N	vmod	\N	\N	\N	0	1
1897	Alles beginnt mit dem ersten Schritt.	すべてのことは最初の一歩から始まる。	\N		\N	vmod	\N	\N	\N	0	1
1898	Warum färben sich die Blätter im Herbst?	木の葉はどうして秋には色づくのだろうか。	\N		\N	vmod	\N	\N	\N	0	1
1899	Diese Liste besteht aus drei Seiten..	このリストは３ページからなっている。	\N		\N	vmod	\N	\N	\N	0	1
1900	Dieser Film hat eine wichtige Botschaft.	この映画は重要なメッセージを含んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1901	Sie schreibt oft Briefe an ihre Freunde in Deutschland.	彼女は時々ドイツの友達に手紙を書く。	\N		\N	vmod	\N	\N	\N	0	1
1902	Sie holte einen großen Briefumschlag aus ihrem Schreibtisch und schrieb seine Adresse darauf.	彼女は自分の机から大きな封筒を持ってきて，その上に彼の住所を書いた。	\N		\N	vmod	\N	\N	\N	0	1
1903	Der Lehrer trägt eine goldene Brille.	その先生は金縁眼鏡をしている。	\N		\N	vmod	\N	\N	\N	0	1
1904			\N		\N	vmod	\N	\N	\N	0	1
1905			\N		\N	vmod	\N	\N	\N	0	1
1906	Die Brüder Grimm waren berühmte deutsche Märchensammler.	グリム兄弟は有名なドイツ童話収集家であった。	\N		\N	vmod	\N	\N	\N	0	1
1907	Dort steigen Sie um in den Bus der Linie 100.	そこで100番線のバスに乗り換えて下さい。	\N		\N	vmod	\N	\N	\N	0	1
1908	Zwiebeln klein schneiden und in Butter braun rösten.	タマネギはみじん切りにして，バターで茶色になるまで炒める。[料理レシピ]	\N		\N	vmod	\N	\N	\N	0	1
1909	Heute ist es teilweise bewölkt.	今日は時々曇り。	\N		\N	vmod	\N	\N	\N	0	1
1910	Dieses Curry enthält zehn verschiedene Gewürze.	このカレーには１０種類のスパイスが入っている。	\N		\N	vmod	\N	\N	\N	0	1
1911	Unser Hund wird immer dicker.	うちの犬はますます太る。	\N		\N	vmod	\N	\N	\N	0	1
1912	Ich habe immer noch dicke Mandeln.	私はまだ扁桃腺が腫れている。	\N		\N	vmod	\N	\N	\N	0	1
1913	Sie waren schon als Kind dicke Freunde.	彼らは子供のときから親友だった。	\N		\N	vmod	\N	\N	\N	0	1
1914	Ich habe am Dienstag Nachmittag einen wichtigen Termin.	火曜日の午後は重要な予定がある。	\N		\N	vmod	\N	\N	\N	0	1
1915	Am Donnerstag letzter Woche hab ich ein Gespräch mit ihm gehabt. 	先週の木曜日に私は彼と話し合いをした。	\N		\N	vmod	\N	\N	\N	0	1
1916	Sie hat dunkle Haare und braune Augen.	彼女は黒い髪の毛に茶色の目をしている。	\N		\N	vmod	\N	\N	\N	0	1
1917	Ich trinke gerne dunkles Bier.	私は黒ビールが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1919	Die Suppe ist dünner geraten, als gewünscht.	スープは期待したより水っぽくなってしまった。	\N		\N	vmod	\N	\N	\N	0	1
1920	Zuerst möchte ich eine heiße Dusche nehmen.	私はまず熱いシャワーを浴びたい。	\N		\N	vmod	\N	\N	\N	0	1
1921	Als der Wecker klingelte, hatte ich mich schon geduscht und umgezogen.	目覚まし時計が鳴ったとき，私はすでにシャワーを浴びて着替えていた。	\N		\N	vmod	\N	\N	\N	0	1
1922	Eben das wollte ich auch sagen.	まさにそれこそ私の言おうとしたことだ。	\N		\N	vmod	\N	\N	\N	0	1
1923	Eingang verboten!	立ち入り禁止！	\N		\N	vmod	\N	\N	\N	0	1
1924	Wir machen immer in diesem Supermarkt Einkäufe.	私たちはいつもこのスーパーで買い物をする。	\N		\N	vmod	\N	\N	\N	0	1
1925	Entschuldigung für die Verspätung!	遅くなってごめんなさい。	\N		\N	vmod	\N	\N	\N	0	1
1926	Ich habe vor zwei Wochen eine schlimme Erkältung bekommen.	私は２週間前にひどい風邪をひいた。	\N		\N	vmod	\N	\N	\N	0	1
1927	Die Eintrittskarte für Erwachsene kostet 10 Euro, für Kinder 5 Euro.	入場券は，大人１０ユーロ，子供５ユーロである。	\N		\N	vmod	\N	\N	\N	0	1
1928	Meine Mutter hat mir das Märchen oft erzählt, als ich klein war.	私が幼いとき，母は私に童話をよく聞かせてくれた。	\N		\N	vmod	\N	\N	\N	0	1
1929	Eines Abends erzählte er mir von seiner Reise nach Italien.	ある夜彼は，私にイタリア旅行の話をしてくれた。	\N		\N	vmod	\N	\N	\N	0	1
1930	Eine einfache Fahrkarte nach München bitte!	ミュンヘン行きの片道切符を一枚ください。	\N		\N	vmod	\N	\N	\N	0	1
1931	Eine Hin- und Rückfahrkarte kostet 35 Euro.	往復切符は35ユーロです。	\N		\N	vmod	\N	\N	\N	0	1
1932	Jede Familie hat ihre eigenen Regeln.	それぞれの家庭には特有のルールがある。	\N		\N	vmod	\N	\N	\N	0	1
1933	Ihr Gesicht hat alle Farben verloren.	彼女の顔から血の気がすっかりうせた。	\N		\N	vmod	\N	\N	\N	0	1
1934	Was gibt es heute Abend im Fernsehen?	今夜はテレビで何があるのかね。	\N		\N	vmod	\N	\N	\N	0	1
1935	Im letzten Februar hat meine Schwester einen Amerikaner geheiratet.	今年の２月に姉はアメリカ人と結婚した。	\N		\N	vmod	\N	\N	\N	0	1
1936	Sie steht am Fenster und blickt hinaus.	彼女は窓辺に立ち，外を眺めている。	\N		\N	vmod	\N	\N	\N	0	1
1937	Die Erinnerung an ferne Tage steigt in mir auf.	遠い日々の思い出が心に蘇る。	\N		\N	vmod	\N	\N	\N	0	1
1938	Vielleicht ist das in ferner Zukunft möglich.	それはもしかしたら遠い未来においては可能かもしれない。	\N		\N	vmod	\N	\N	\N	0	1
1939	Ich möchte diesen Film entwickeln lassen.	このフィルムを現像してもらいたいのですが。	\N		\N	vmod	\N	\N	\N	0	1
1940	Ich esse lieber Fisch als Fleisch.	私は肉より魚が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1941	Tatsächlich ist das eine sehr interessante Frage.	実はそれはとても興味深い問題である。	\N		\N	vmod	\N	\N	\N	0	1
1942	Sein Ferienhaus hat einen großen Garten.	彼の別荘には大きな庭がある。	\N		\N	vmod	\N	\N	\N	0	1
1943	Meine Freunde haben für mich eine Geburtstagsparty gegeben.	友達が私のために誕生日パーティーを開いてくれた。	\N		\N	vmod	\N	\N	\N	0	1
1944	Heute Nachmittag gehen wir einkaufen.	今日の午後私たちは買い物に行く。	\N		\N	vmod	\N	\N	\N	0	1
1945	Beim Training trägt sie ein gelbes T-Shirt. 	トレーニングのとき彼女は黄色いTシャツを着ている。	\N		\N	vmod	\N	\N	\N	0	1
1946	bares Geld	現金	\N		\N	vmod	\N	\N	\N	0	1
1947	Nachdem wir unser Gepäck aufgegeben hatten, haben wir eine kurze Pause gemacht. 	荷物を預けた後，私たちは少しばかりの休憩をした。	\N		\N	vmod	\N	\N	\N	0	1
1948	Er macht ein trauriges Gesicht.	彼は悲しそうな顔をした。	\N		\N	vmod	\N	\N	\N	0	1
1949	Alle Bilder müssen gleich groß sein.	すべての絵は同じ大きさでなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1950	Auch das ist bis zu einem gewissen Grad verständlich.	それもある程度までは納得できる。	\N		\N	vmod	\N	\N	\N	0	1
1951	Inzwischen hatte er 40 Grad Fieber.	その間彼は熱が４０度あった。	\N		\N	vmod	\N	\N	\N	0	1
1952	Ich hatte große Angst vor der Prüfung.	私は試験に対して大いに不安を感じていた。	\N		\N	vmod	\N	\N	\N	0	1
1953	Ich habe gute Augen.	私は目（視力）が良い。	\N		\N	vmod	\N	\N	\N	0	1
1954	Sie hat die Hände wie zum Gebet gefaltet.	彼女は祈る時のように両手を組み合わせた。	\N		\N	vmod	\N	\N	\N	0	1
1955	Wann erscheint das nächste Heft?	次号はいつ刊行されますか？	\N		\N	vmod	\N	\N	\N	0	1
1956	Sie haben die Antwort in ihr Heft geschrieben.	彼らは答えをノートに書いた。	\N		\N	vmod	\N	\N	\N	0	1
1957	Mir ist heiß und ich bin so müde.	私は暑い。そしてとても疲れている。	\N		\N	vmod	\N	\N	\N	0	1
1958	Darüber hatten wir bereits eine heiße Diskussion.	それについては私たちはすでに激しい議論をした。	\N		\N	vmod	\N	\N	\N	0	1
1959	So verging der Abend in heiterer Stimmung.	そういうふうに夜はにぎやかなムードで過ぎ去っていった。	\N		\N	vmod	\N	\N	\N	0	1
1960	Durch die großen Fenster ist das Zimmer sehr hell.	大きい窓のおかげでこの部屋はとても明るい。	\N		\N	vmod	\N	\N	\N	0	1
1961	Sie trägt heute ein helles Kleid.	彼女は今日淡色のワンピースを着ている。	\N		\N	vmod	\N	\N	\N	0	1
1962	Ich nehme ein helles Bier.	私は（黒ビールではなく）淡色のビールにします。	\N		\N	vmod	\N	\N	\N	0	1
1963	Wir haben uns schon im Herbst vorigen Jahres kennen gelernt.	私たちは昨年の秋に知り合った。	\N		\N	vmod	\N	\N	\N	0	1
1964	Er steht ganz hinten im Saal.	彼はホールの一番後ろに立っている。	\N		\N	vmod	\N	\N	\N	0	1
1965	Japanisch besteht aus drei Schriften: Hiragana, Katakana und Kanji.	日本語は３の文字―平仮名，カタカナ，漢字―から成っている。	\N		\N	vmod	\N	\N	\N	0	1
1966	Sie trägt gerne Schuhe mit hohen Absätzen.	彼女はかかとの高い靴をよく履く。	\N		\N	vmod	\N	\N	\N	0	1
1967	Diese Diät ist auch gut gegen hohen Blutdruck.	この食餌療法は高血圧にも良い。	\N		\N	vmod	\N	\N	\N	0	1
1968	In welchem Hotel wohnen Sie?	どのホテルに滞在していますか？	\N		\N	vmod	\N	\N	\N	0	1
1969	Für ihren Sohn hat sie ein gebratenes Huhn gekauft.	息子のために彼女はローストチキンを買った。	\N		\N	vmod	\N	\N	\N	0	1
1970	Während er sprach, hat er das Zimmer verlassen.	彼は話しながら，部屋を出て行った。	\N		\N	vmod	\N	\N	\N	0	1
1971	Meine Tochter ist dieses Jahr 20 Jahre alt geworden.	娘は今年２０才になった。	\N		\N	vmod	\N	\N	\N	0	1
1972	Anfang Juli fahre ich für 5 Tage nach Frankfurt zu meinen Eltern.	７月初め頃に５日間私はフランクフルトの両親のところへ行く。	\N		\N	vmod	\N	\N	\N	0	1
1973	Meine Großeltern haben sehr jung geheiratet.	祖父母はとても若くして結婚した。	\N		\N	vmod	\N	\N	\N	0	1
1974	Bis Ende Juni möchte ich gerne noch zwei Kilo abnehmen.	私は６月終わりまでにあと２キロ痩せたい。	\N		\N	vmod	\N	\N	\N	0	1
1975	Ich habe zum Geburtstag von meinem Vater eine Digitalkamera geschenkt bekommen.	私は誕生日に父からデジタルカメラをプレゼントしてもらった。	\N		\N	vmod	\N	\N	\N	0	1
1976	Der Kassenttenrekorder funktioniert schon lange nicht mehr.	このカセットレコーダはずっと動かないままだ。	\N		\N	vmod	\N	\N	\N	0	1
1977	Wir werden zweiter Klasse fahren.	私たちは２等で行く。	\N		\N	vmod	\N	\N	\N	0	1
1978	Gestern haben wir uns den Film "Das fliegende Klassenzimmer" angesehen.	昨日私たちは映画「飛ぶ教室」を観た。	\N		\N	vmod	\N	\N	\N	0	1
1979	Bitte kleben Sie eine Briefmarke darauf und werfen Sie den Brief in den Postkasten.	その上に切手を貼って，郵便ポストに投函してください。	\N		\N	vmod	\N	\N	\N	0	1
1980	Sein T-Shirt klebt ihm am Rücken.	汗でTシャツが彼の背中にはりついている。	\N		\N	vmod	\N	\N	\N	0	1
1981	Seine Frau liegt seit vorgestern im Krankenhaus.	彼の奥さんは一昨日から入院している。	\N		\N	vmod	\N	\N	\N	0	1
1982	Aus der Küche riecht es gut. 	キッチンからいいにおいがする。	\N		\N	vmod	\N	\N	\N	0	1
1983	Er leidet an einer Krankheit.	彼は病気にかかっている。	\N		\N	vmod	\N	\N	\N	0	1
1984	An der Kreuzung steht die Polizei.	交差点に警察が立っている。	\N		\N	vmod	\N	\N	\N	0	1
1985	Wie viel Geld gibst du durchschnittlich im Monat für Kleidung aus?	君は洋服代に月平均どれぐらい使っているの？	\N		\N	vmod	\N	\N	\N	0	1
1986	Er hat eine kleine Tochter.	彼は幼い娘が一人いる。	\N		\N	vmod	\N	\N	\N	0	1
1987	Hier machen wir eine kleine Pause.	ここで一休みしましょう。	\N		\N	vmod	\N	\N	\N	0	1
1988	Die neue Version hat noch einige kleine Fehler.	新しいヴァージョンにもいくつかのケアレスミスがある。	\N		\N	vmod	\N	\N	\N	0	1
1989	Bitte senden Sie eine Kopie Ihres Ausweises an uns.	私たちに身分証明書のコピーを送ってください。	\N		\N	vmod	\N	\N	\N	0	1
1990	Ein gesunder Geist erfordert einen gesunden Körper.	健康な精神には健康な肉体が必要である。	\N		\N	vmod	\N	\N	\N	0	1
1991	Dieser Kugelschreiber schreibt echt gut.	このボールペンはとてもよく書ける。	\N		\N	vmod	\N	\N	\N	0	1
1992	Auf dem Kühlschrank steht die Mikrowelle.	冷蔵庫の上に電子レンジがある。	\N		\N	vmod	\N	\N	\N	0	1
1993	Im Mai haben wir einen kurzen Urlaub auf Hawaii gemacht.	５月に私たちはハワイで短い休暇を過ごした。	\N		\N	vmod	\N	\N	\N	0	1
1994	Sie will heute ihre langen Haare kurz schneiden lassen.	彼女は今日その長い髪を短く切るつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
1995	Heute ist der Laden geschlossen.	その店は今日閉まっている。	\N		\N	vmod	\N	\N	\N	0	1
1996	In meiner Jugend habe ich die Sommerferien immer auf dem Land verbracht.	若い頃僕は，夏休みをいつも田舎で過ごした。	\N		\N	vmod	\N	\N	\N	0	1
1997	Wir haben zehn lange Jahre in dieser Stadt gewohnt.	私たちは１０年もの長い間この都市に住んだ。	\N		\N	vmod	\N	\N	\N	0	1
1998	Ich habe die Datei gelöscht.	私はそのデータを消してしまった。	\N		\N	vmod	\N	\N	\N	0	1
1999	Das Lied ist auch im Ausland ziemlich bekannt.	その歌は海外でもかなり知られている。	\N		\N	vmod	\N	\N	\N	0	1
2000	Manchmal hat er sogar keine Zeit zum Schlafen.	時々彼は寝る時間さえない。	\N		\N	vmod	\N	\N	\N	0	1
2001	Er muss die Medikamente täglich einnehmen.	彼は薬を毎日飲まなければならない。	\N		\N	vmod	\N	\N	\N	0	1
2002	Sie war schon früh munter.	彼女はまだ早い時間に目が覚めていた。	\N		\N	vmod	\N	\N	\N	0	1
2003	Sie mag den Brief noch nicht erhalten haben.	彼女はまだ手紙を受け取っていないのかもしれない。	\N		\N	vmod	\N	\N	\N	0	1
2004	Diesen Morgen sind wir in die Kirche gegangen.	今朝私たちは教会へ（礼拝に）行った。	\N		\N	vmod	\N	\N	\N	0	1
2005	In naher Zukunft will ich gerne in meine Heimat zurückkehren.	近い将来私は故郷に戻るつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
2006	Ich kenne ihn schon lange. Er ist ein naher Freund.	私は彼を知り合ってもう長い。彼は親友である。	\N		\N	vmod	\N	\N	\N	0	1
2007	Ich wohne ganz in der Nähe von hier.	私はここからすぐ近くの所に住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
2008	Er fiel zu Boden und das Blut floss ihm aus der Nase.	彼は地面に倒れて，鼻から血を流していた。	\N		\N	vmod	\N	\N	\N	0	1
2009	Sie spricht neben Deutsch auch Englisch und Französisch.	彼女はドイツ語に加えて英語とフランス語も話せる。	\N		\N	vmod	\N	\N	\N	0	1
2010	Auf dem Land sind die Mieten niedrig.	地方は家賃が安い。	\N		\N	vmod	\N	\N	\N	0	1
2011	Schweden liegt im Norden Europas.	スウェーデンはヨーロッパの北部に位置している。	\N		\N	vmod	\N	\N	\N	0	1
2012	Das Geschäft ist von 10 bis 20 Uhr geöffnet.	その店は１０時から２０時まで開いている。	\N		\N	vmod	\N	\N	\N	0	1
2013	Das Zimmer geht nach Süden und ist sehr hell.	この部屋は南向きで，とても明るい。	\N		\N	vmod	\N	\N	\N	0	1
2014	Brasilien ist das größte Land in Südamerika.	ブラジルは南アメリカで一番大きな国である。	\N		\N	vmod	\N	\N	\N	0	1
2015	Die Sonne geht im Osten auf.	太陽は東から昇る。	\N		\N	vmod	\N	\N	\N	0	1
2016	Am Eingang stehen für die Gäste Pantoffeln bereit.	玄関にはお客さん用にスリッパが用意されている。	\N		\N	vmod	\N	\N	\N	0	1
2017	An meinem Geburtstag habe ich per Post ein Päckchen bekommen.	誕生日の日に私は郵便で一つの小包をもらった。	\N		\N	vmod	\N	\N	\N	0	1
2018	Auf der Urlaubsreise schreibt sie gerne Postkarten an ihre Freunde.	休暇旅行で彼女は友人たちに葉書を書くのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
2019	Heute muss ich das Paket zur Post bringen.	今日私はこの小包を郵便局へ持って行かなければならない。	\N		\N	vmod	\N	\N	\N	0	1
2020	Er hat mehrjährige praktische Erfahrungen in den Bereichen.	彼はその分野で数年間の実務経験がある。	\N		\N	vmod	\N	\N	\N	0	1
2021	Der Mantel muss zum Reinigen gegeben werden.	コートはドライクリーニングに出すべきだ。	\N		\N	vmod	\N	\N	\N	0	1
2022	Er schaltet das Radio ein, um die Nachrichten zu hören.	彼はニュースを聞くためラジオのスイッチを入れた。	\N		\N	vmod	\N	\N	\N	0	1
2023	Ich suche einen Radiorekorder mit CD-Spieler.	私はCDプレーヤーつきのラジカセを探している。	\N		\N	vmod	\N	\N	\N	0	1
2024	Den Anzug habe ich schon in die Reinigung gebracht. 	その背広は私がもうクリーニングに出した。	\N		\N	vmod	\N	\N	\N	0	1
2025	Also beginnen wir mit der Reinigung der Zimmer.	では，部屋の掃除から始めましょう。	\N		\N	vmod	\N	\N	\N	0	1
2026	Jetzt führen sie endlich ein ruhiges Leben in ihrer Heimat.	彼らは今ようやく故郷で落ち着いた生活を送っている。	\N		\N	vmod	\N	\N	\N	0	1
2027	Sie lehrt Deutsch.	彼女はドイツ語を教えている。	\N		\N	vmod	\N	\N	\N	0	1
2028	Er hat mich sehr viel gelehrt.	彼は私にとてもたくさんのことを教えてくれた。	\N		\N	vmod	\N	\N	\N	0	1
2029	Das Messer ist scharf.	このナイフは切れ味がよい。	\N		\N	vmod	\N	\N	\N	0	1
2030	Das Geschäft ist am Sonntag geschlossen.	その店は日曜日には閉まっている。	\N		\N	vmod	\N	\N	\N	0	1
2031	Die Sitzung wurde gegen 20 Uhr geschlossen.	会議は夜の８時頃終わった。	\N		\N	vmod	\N	\N	\N	0	1
2032	Weiße Hemden werden schnell schmutzig.	白いシャツは汚れやすい。	\N		\N	vmod	\N	\N	\N	0	1
2033	Sie hat in diesen Tagen schwere Sorgen.	彼女は最近深刻な心配事がある。	\N		\N	vmod	\N	\N	\N	0	1
2034	Mit solchen Leuten wollen wir nicht mehr zusammenarbeiten.	そのような人々とはこれ以上一緒に働きたくない。	\N		\N	vmod	\N	\N	\N	0	1
2035	Die Kinder freuen sich schon auf die Sommerferien.	子供たちはもう夏休みを楽しみにしている。	\N		\N	vmod	\N	\N	\N	0	1
2036	Deutschland ist eine sehr starke Mannschaft.	ドイツはとても強いチームだ。	\N		\N	vmod	\N	\N	\N	0	1
2037	Meine Großmutter ist mit 80 Jahren gestorben.	祖母は80才で亡くなった。	\N		\N	vmod	\N	\N	\N	0	1
2038	Sapporo liegt in Nordjapan.	札幌は北日本に位置している。	\N		\N	vmod	\N	\N	\N	0	1
2039	Das Mädchen ist so süß und nett.	あの女の子はとてもかわいくてやさしい。	\N		\N	vmod	\N	\N	\N	0	1
2040	Sie ist schwach und oft krank.	彼女は（身体が）弱くて病気がちだ。	\N		\N	vmod	\N	\N	\N	0	1
2041	Ich finde das Argument schwach.	私はその論証は弱いと思う。	\N		\N	vmod	\N	\N	\N	0	1
2042	Er kommt aus Ostdeutschland.	彼は東ドイツ出身だ。	\N		\N	vmod	\N	\N	\N	0	1
2043	Er hat das Handy in die Tasche gesteckt.	彼は携帯をポケットに突っ込んだ。	\N		\N	vmod	\N	\N	\N	0	1
2044	Meine Tante wohnt in München.	叔母はミュンヘンに住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
2045	Er wischt sich mit dem Taschentuch den Schweiß von der Stirn ab.	彼はハンカチで額の汗をぬぐい取る。	\N		\N	vmod	\N	\N	\N	0	1
2046	Sie haben ein großes Haus mit Garten. Im Garten gibt es auch einen Teich.	彼らは庭付きの大きな家を持っている。庭には池もある。	\N		\N	vmod	\N	\N	\N	0	1
2047	Wo ist die Toilette?	トイレはどこですか？	\N		\N	vmod	\N	\N	\N	0	1
2048	Ich muss kurz auf die Toilette.	ちょっとトイレに行ってきます。	\N		\N	vmod	\N	\N	\N	0	1
2049	Er hat in zwei Spielen drei Tore geschossen.	彼は２試合で３得点した。	\N		\N	vmod	\N	\N	\N	0	1
2050	Gestern habe ich deine Schwester auf der Straße getroffen.	昨日街頭で君の妹に（偶然）会ったよ。	\N		\N	vmod	\N	\N	\N	0	1
2051	Das Gebäude wurde im Zweiten Weltkrieg von einer Bombe getroffen.	その建物は第二次世界大戦で爆弾が命中して壊された。	\N		\N	vmod	\N	\N	\N	0	1
2052	Das tut nichts zur Sache.	それはこのこととは関係ない。	\N		\N	vmod	\N	\N	\N	0	1
2053	Gleich da vorn ist ein schönes Café.	このすぐ先にきれいなカフェがある。	\N		\N	vmod	\N	\N	\N	0	1
2054	Ich habe auf der Party viele Leute kennen gelernt.	私はパーティーでたくさんの人と知り合った。	\N		\N	vmod	\N	\N	\N	0	1
2055	Heute ist es sehr warm.	今日はとても暖かい。	\N		\N	vmod	\N	\N	\N	0	1
2056	Ich möchte etwas Warmes trinken.	何か温かいものを飲みたい。	\N		\N	vmod	\N	\N	\N	0	1
2057	Die Mutter faltet die Wäsche.	母は洗濯物を畳んでいる。	\N		\N	vmod	\N	\N	\N	0	1
2058	Wie oft wäscht du dein Auto?	君はどれくらい頻繁に洗車をするの？	\N		\N	vmod	\N	\N	\N	0	1
2059	Manchmal tut es noch weh.	時々まだ痛む。	\N		\N	vmod	\N	\N	\N	0	1
2060	Der Sommer ist nicht mehr weit.	夏はもう間近だ。	\N		\N	vmod	\N	\N	\N	0	1
2061	Kann hier jemand Deutsch?	ここにどなたかドイツ語のできる人はいますか？	\N		\N	vmod	\N	\N	\N	0	1
2062	Im Westen der Stadt entsteht ein neues Altenheim.	都市の西部に新しい老人ホームができる。	\N		\N	vmod	\N	\N	\N	0	1
2063	Belgien liegt in Westeuropa.	ベルギーは西ヨーロッパに位置している。	\N		\N	vmod	\N	\N	\N	0	1
2064	Wir wollen diesen Winter in Skiurlaub fahren.	私たちはこの冬スキー旅行に出かける予定だ。	\N		\N	vmod	\N	\N	\N	0	1
2065	Ich gehe mindesten einmal pro Woche schwimmen.	私は少なくとも一週間に一回は泳ぎに行く。	\N		\N	vmod	\N	\N	\N	0	1
2066	Die Zeit vergeht so schnell.	時が経つのは本当に速い。	\N		\N	vmod	\N	\N	\N	0	1
2067	Ich habe zwei Kilo abgenommen, indem ich jeden Tag Sport gemacht habe.	毎日運動をすることによって，私は２キロ痩せた。	\N		\N	vmod	\N	\N	\N	0	1
2068	In Japan feiert man am 3. März das Mädchenfest.	日本では３月３日に女の子の祭りを祝う。	\N		\N	vmod	\N	\N	\N	0	1
2069	Dieser Turm hat eine Höhe von über 50 Metern.	この塔の高さは50メートル以上ある。	\N		\N	vmod	\N	\N	\N	0	1
2070	Der Mann hat eine Geldstrafe in Höhe von 500 Euro bezahlt. 	その男は500ユーロの罰金を払った。	\N		\N	vmod	\N	\N	\N	0	1
2071	Sie hat für uns so leckere Speisen zubereitet.	彼女は私たちのためにこんなにおいしい料理を用意してくれた。	\N		\N	vmod	\N	\N	\N	0	1
2072	Der Artikel stand vorgestern im Blatt.	その記事は一昨日新聞に出ていた。	\N		\N	vmod	\N	\N	\N	0	1
2073	Ich habe mir schon Farbe gekauft, damit ich mein Zimmer streichen kann.	私はもう自分の部屋に塗るペンキを購入した。	\N		\N	vmod	\N	\N	\N	0	1
2074	Er ist mein großer Bruder.	彼は私の兄です。	\N		\N	vmod	\N	\N	\N	0	1
2075	Heute ist es windig und ziemlich kühl.	今日は風通しがよくてずいぶん涼しい。	\N		\N	vmod	\N	\N	\N	0	1
2076	Die Erdoberfläche besteht zu einem Drittel aus Land und zwei Drittel aus Wasser.	地表は，３分の１は陸で，３分の２は水で出来ている。	\N		\N	vmod	\N	\N	\N	0	1
2077	Sie zeigt mir den Weg auf der Landkarte.	彼女は地図で道を教えてくれる。	\N		\N	vmod	\N	\N	\N	0	1
2079	Sie trinkt Kaffee immer mit zwei Löffel Zucker.	彼女はコーヒーにいつもスプーン２杯の砂糖を入れる。	\N		\N	vmod	\N	\N	\N	0	1
2080	Er öffnet ihr die Tür.	彼は彼女にドアを開けてあげる。	\N		\N	vmod	\N	\N	\N	0	1
2081	Dafür ist die Papiertüte zu schwach.	それには紙袋は弱すぎる。	\N		\N	vmod	\N	\N	\N	0	1
2082	Hier ist es im September immer noch schwül.	ここは９月にもまだ蒸し暑い。	\N		\N	vmod	\N	\N	\N	0	1
2083	Er hat einen starken Willen und setzt seine Meinug durch.	彼は意志が強くて，自分の意見を押し通す。	\N		\N	vmod	\N	\N	\N	0	1
2084	Er hat das Gepäck zum Bahnhof getragen.	彼が荷物を駅まで運んでくれた。	\N		\N	vmod	\N	\N	\N	0	1
2085	Von hier kann man das Meer weit überschauen.	ここから海を広々と見渡せる。	\N		\N	vmod	\N	\N	\N	0	1
2086	Das große Tor öffnete sich knarrend.	その大きな門はぎいぎい音を立てながら開いた。	\N		\N	vmod	\N	\N	\N	0	1
2087	Das Buch habe ich mir von Hans geliehen.	その本はハンスから借りたものだ。	\N		\N	vmod	\N	\N	\N	0	1
2088	Mein Sohn räumt sein Zimmer selber auf.	うちの息子は自分の部屋は自分で掃除する。	\N		\N	vmod	\N	\N	\N	0	1
2089	Ich bin 20 Jahre alt.	私は２０歳だ。	\N		\N	vmod	\N	\N	\N	0	1
2090	Die Tische biegen sich unter der schweren Last.	重みでテーブルがたわむ。	\N		\N	vmod	\N	\N	\N	0	1
2091	Gehen Sie hier nach rechts und dann immer geradeaus.	ここで右に曲がって，まっすぐ行ってください。	\N		\N	vmod	\N	\N	\N	0	1
139	Heute ist es sehr kalt.	今日はとても寒い。	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: de
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	705	行く，歩いて行く	1	1
2	706	英語	1	1
3	707	飛行機，航空機	1	1
4	708	外国，国外	1	1
5	709	外国人　<女>Ausländerin	1	1
6	710	フランス語	1	1
7	711	ホテル，旅館	1	1
8	712	日本語	1	1
9	713	出掛ける，外出する	1	1
10	714	国，国家	1	1
11	715	（約束して）会う，（偶然）出会う，出くわす	1	1
12	716	休み，休暇	1	1
13	717	旅行，旅	1	1
14	718	旅行する	1	1
15	719	遊ぶ	1	1
16	720	大使館	2	1
17	721	大好き，お気に入り	1	1
18	722	好きだ，好む	1	1
19	723	上手（じょうず）な，有能な，優れた，うまい	2	1
20	724	走る，駆ける	1	1
21	725	ゆっくり，遅い	1	1
22	726	（質が）悪い，粗末な，下手な	1	1
23	727	歩く，走る	1	1
24	728	泳ぐ，泳いでいく	1	1
25	729	（スピードが）速い，速やかな，（動作が）素早い	1	1
26	730	飛ぶ，飛行する，飛行機で行く	1	1
27	731	スポーツ	1	1
28	732	嫌い，憎む	1	1
29	733	プール	1	1
30	734	バス	1	1
31	735	自転車	1	1
32	736	交差点，十字路	1	1
33	737	道，道路，通り	1	1
34	738	池，沼	1	1
35	739	散歩	1	1
36	740	かわ（川・河）	1	1
37	741	タクシー	1	1
38	742	自動車，車	1	1
39	743	曲がる，たわむ	1	1
40	744	ネクタイ	1	1
41	745	ワイシャツ，シャツ	1	1
42	746	会社，商社	1	1
43	747	背広，（男性用の）スーツ	1	1
44	748	やる，する，行なう	1	1
45	749	（タバコなどを）吸う，喫煙する	1	1
46	750	電話，電話機	1	1
47	751	仕事，労働，活動	1	1
48	752	働く，勤める，（～に）従事する	1	1
49	753	忙しい	1	1
50	754	図書館	1	1
51	755	辞書，字引	1	1
52	756	借りる	1	1
53	757	新聞	1	1
54	758	読む，読書する	1	1
55	759	本，書籍	1	1
56	760	コピー，写し，プリント	1	1
57	761	コピーする，写す，プリントする	1	1
58	762	雑誌	1	1
59	763	サンプル，例，見本，（本などの）部，冊	1	1
60	764	牛肉，ビーフ	1	1
61	765	安い	1	1
62	766	店，商店	1	1
63	767	高い，丈の高い	1	1
64	768	いくつ	1	1
65	769	どれくらい，どれほど，いくら	2	1
66	770	果物，果実	1	1
67	771	野菜	1	1
68	772	魚，魚類，魚料理	1	1
69	773	豚肉	1	1
70	774	鳥肉	1	1
71	775	肉，肉類	1	1
72	776	（möchteの形で）欲しい，～したい，～したがっている，～してもらいたい	1	1
73	777	渡す，与える，預ける	1	1
74	778	八百屋	1	1
75	779	かぎ（鍵），キー	1	1
76	780	料理	1	1
77	781	買い物する	1	1
78	782	洗う，洗濯する	1	1
79	783	掃除する，きれいにする	1	1
80	784	家族，家庭，一家	1	1
81	785	家族，家庭，一家	1	1
82	786	庭（にわ），庭園	1	1
83	787	洗うこと，洗濯	1	1
84	788	うち（家），住まい，住居	1	1
85	789	家（いえ），家屋，住宅	1	1
86	790	掃除，整理	1	1
87	791	帰える，戻ってくる	1	1
88	792	本棚，書棚	1	1
89	793	机，食卓，テーブル	1	1
90	794	椅子（いす）	1	1
91	795	部屋，ルーム	1	1
92	796	冷蔵庫	1	1
93	797	洗う，洗濯する	1	1
94	798	ベッド	1	1
95	799	ラジオ，ラジオ放送	1	1
96	800	ラジカセ	1	1
97	801	～という名前である，～と呼ばれている	1	1
98	802	寝る，眠っている	1	1
99	803	起きる，起床する	1	1
100	804	机，食卓，テーブル	1	1
101	805	テレビ（受像機） ＊Fernseherともいう。	2	1
102	806	警官，お巡りさん　<女>Polizistin	1	1
103	807	警官，お巡りさん　<女>Polizistin	1	1
104	808	地図	1	1
105	809	（３格と）～のそばに，～の隣に，（４格と）～の隣へ，～の横へ	1	1
106	810	ここ，こちら，こっち	1	1
107	811	（空間的に）そこ,そちら, そっち	1	1
108	812	あちら, あっち，あそこ	1	1
109	813	どこ，どちら，どっち	1	1
110	814	交番	1	1
111	815	近さ，近く，付近	1	1
112	816	（３格と）～のそばに，～の隣に，（４格と）～の隣へ，～の横へ	1	1
113	817	きく，（意図的に）聴く，聴取する	1	1
114	818	（刃物で）切る，切断する	1	1
115	819	（空間的に）短い，近い，短距離の	1	1
116	820	（３格と）～後ろに（で），（４格と）～の後ろへ	1	1
117	821	（空間的に）（３格と）～前に（で），（４格と）～の前へ	1	1
118	822	右の，右側の	1	1
119	823	左の，左側の	1	1
120	824	（空間的に）長い	1	1
121	825	座る，腰を下ろす	1	1
122	826	立つ，（座った状態から）立ち上がる，起立する	1	1
123	827	友達，友人　<女>Freundin	1	1
124	828	クラス，学級，学年	1	1
125	829	教室	1	1
126	830	廊下，床	1	1
127	831	学校	1	1
128	832	生徒　<女>Schülerin	1	1
129	833	（大学での）勉強，研究	1	1
130	834	学生　<女>Studentin	1	1
131	835	留学生	1	1
132	836	夏休み，夏季休暇	1	1
133	837	先生，教師　<女>Lehrerin	1	1
134	838	大学	1	1
135	839	ノート，帳面	1	1
136	840	授業	1	1
137	841	作文，（比較的短い）論文	1	1
138	842	宿題	1	1
139	843	難しい，困難な，厄介な，面倒な	1	1
140	844	教える，教育する	1	1
141	845	試験，テスト，検査	1	1
142	846	練習	1	1
143	847	易しい，簡単な，楽な	1	1
144	848	練習する	1	1
145	849	質問，問い	1	1
146	850	問題，課題，悩み	1	1
147	851	答える，返事する，回答する	1	1
148	852	（体の一部が）痛い，痛む	1	1
149	853	歯	1	1
150	854	医者　<女>Ärztin	1	1
151	855	病院	1	1
152	856	病気	1	1
153	857	薬（くすり）	1	1
154	858	死ぬ	1	1
155	859	風邪（かぜ）	1	1
156	860	頭（あたま），頭部	1	1
157	861	お腹	1	1
158	862	（温度・角度などの）度（ど）	1	1
159	863	エレベーター	1	1
160	864	切符，乗車券	1	1
161	865	おりる	1	1
162	866	階段	1	1
163	867	閉める，（服の）ボタンをはめる	1	1
164	868	駅	1	1
165	869	地下鉄	1	1
166	870	乗る	1	1
167	871	開ける，開く	1	1
168	872	トイレ，お手洗い	1	1
169	873	トイレ，お手洗い	1	1
170	874	電車	1	1
171	875	飲み物，飲料	1	1
172	876	コーヒー	1	1
173	877	喫茶店	1	1
174	878	レモン	1	1
175	879	牛乳	1	1
176	880	砂糖	1	1
177	881	カップ，茶わん	1	1
178	882	お茶，紅茶	1	1
179	883	お茶，紅茶	1	1
180	884	ガラス容器，コップ，グラス	2	1
181	885	入れる	1	1
182	886	甘い，甘みのある	1	1
183	887	飲む	1	1
184	888	はし	1	1
185	889	酒	1	1
186	890	おいしい	1	1
187	891	ナイフ，メス，刀	1	1
188	892	スプーン	1	1
189	893	フォーク	1	1
190	894	チーズ	1	1
191	895	食べる，食事をする	1	1
192	896	まずい	1	1
193	897	パン	1	1
194	898	（味・香りなどが）辛い，刺激性の	1	1
195	899	レストラン，料理店	1	1
196	900	食堂，学生食堂	1	1
197	901	酒，ワイン	1	1
198	902	食べ物，料理	1	1
199	903	カレー	1	1
200	904	お金，通貨	1	1
201	905	銀行	1	1
202	906	入口，玄関	1	1
203	907	どうぞ，どういたしまして	1	1
204	908	いいえ	1	1
205	909	ええ，はい	1	1
206	910	すみません	1	1
207	911	どうぞ，どうか	1	1
208	912	出口	1	1
209	913	着く，到着する	1	1
210	914	ポスト	1	1
211	915	はがき，絵葉書	1	1
212	916	貼る，貼り付ける，くっつける	1	1
213	917	封筒	1	1
214	918	手紙，書簡	1	1
215	919	郵便局	1	1
216	920	返す，返却する	1	1
217	921	出す	1	1
218	922	切手	1	1
219	923	荷物，郵便小包	1	1
220	924	枚，（１枚の）紙，ページ	2	0
221	925	貸す，貸与する	1	1
222	926	買う，購入する	1	1
223	927	帽子	1	1
224	928	靴	1	1
225	929	買い物，ショッピング	1	1
226	930	（建物の）階	1	1
227	931	デパート，百貨店	1	1
228	932	スカート	1	1
229	933	コート	1	1
230	934	ズボン	1	1
231	935	セーター，プルオーバー	1	1
232	936	…てください	1	1
233	937	かばん，バック	1	1
234	938	売る，売却する，販売する	1	1
235	939	上着，ジャケット	1	1
236	940	ふろ，入浴	1	1
237	941	建物，建造物，家屋	1	1
238	942	台所，キッチン	1	1
239	943	シャワー	1	1
240	944	窓	1	1
241	945	住む，住んでいる	1	1
242	946	公園，遊園地	1	1
243	947	ドア，戸（と），扉	1	1
244	948	浴びる［一風呂～］	1	1
245	949	アパート	1	1
246	950	入口，玄関	1	1
247	951	彼，その男	1	1
248	952	彼女，彼ら，彼女たち	1	1
249	953	私（わたし）	1	1
250	954	私たち	1	1
251	955	ある人，誰か	1	1
252	956	誰，どなた	1	1
253	957	誰，どなた	1	1
254	958	きみ，おまえ	1	1
255	959	あなた，あなたがた	1	1
256	960	この，その，これらの	1	1
257	961	その，あの	1	1
258	962	いかが，どう，どのように	1	1
259	963	どの，どちらの，どのような，どんな	1	1
260	964	どの，どちらの，どのような，どんな	1	1
261	965	こんな，このような，そのような	1	1
262	966	自分	1	1
263	967	そう，そのように，そんなふうに	1	1
264	968	太い，厚い	1	1
265	969	狭い，（衣服などが）窮屈な	1	1
266	970	薄い，細い，痩せた	1	1
267	971	大きい，広大な，背丈が高い	1	1
268	972	太い，厚い	1	1
269	973	若い，幼い	1	1
270	974	（幅が）広い，広がった，広々とした	1	1
271	975	軽い，軽量の	2	1
272	976	（空間的に）遠い，遠方の，遠く離れた	1	1
273	977	重い，重量のある	1	1
274	978	薄い，細い，痩せた	1	1
275	979	新しい，新規の，最近の，汚れていない	1	1
276	980	（大きさが）小さい，小型の，小柄な	1	1
277	981	（空間的に）近い，近くの，すぐそばの	1	1
278	982	古い，使い古した	1	1
279	983	愉快な，陽気な，楽しい，おもしろい	1	1
280	984	にぎやか	1	1
281	985	（高さが）低い	1	1
282	986	よい，正しい，好ましい，適切な	1	1
283	987	（光で）明るい	1	1
284	988	（体力などが）弱い，貧弱な	1	1
285	989	強い，強力な	1	1
286	990	おもしろい，興味を引く	1	1
287	991	きれいな，美しい	1	1
288	992	（時刻・時期が）遅い，	1	1
289	993	（質が）悪い，粗末な，下手な	1	1
290	994	多い，多くの，たくさんの	1	1
291	995	暗い，暗闇の	1	1
292	996	静かな，閑静な	1	1
293	997	少ない，ほんの少しの，ほとんど～ない	1	1
294	998	汚い，汚れた，不潔な	1	1
295	999	つまらない，退屈な，単調な	1	1
296	1000	横	1	1
297	1001	（空間的に）中（なか），中央，真ん中	1	1
298	1002	外（そと）	1	1
299	1003	東（ひがし），東部	1	1
300	1004	（空間的な）高さ，高度	1	1
301	1005	縦，長さ	1	1
302	1006	北（きた），北方	1	1
303	1007	西（にし），西部	1	1
304	1008	（空間的に）（３格と）～の下（した）に，（４格と）～の下方へ	1	1
305	1009	南（みなみ），南部	1	1
306	1010	（３格と）上（うえ）に，（４格と）上方へ	1	1
307	1011	先（さき）に，先頭に，前方に	1	1
308	1012	後（あと），後ろに，奥に，裏側に	1	1
309	1013	いとこ　<女>Cousine	1	1
310	1014	兄，お兄さん \n＊特に年上の場合は，älterer Bruderという。	1	1
311	1015	兄弟（きょうだい），兄弟姉妹	1	1
312	1016	おばあさん，祖母	1	1
313	1017	おじいさん，祖父	1	1
314	1018	妻，奥さん	2	1
315	1019	母，母親，お母さん	1	1
316	1020	叔父，伯父	1	1
317	1021	両親	1	1
318	1022	父，父親，お父さん	1	1
319	1023	姉，お姉さん	1	1
320	1024	姉妹	3	1
321	1025	叔母，伯母	1	1
322	1026	兄，お兄さん ＊特に年上の場合は，älterer Bruderという。	1	1
323	1027	姉，お姉さん	1	1
324	1028	父，父親，お父さん	1	1
325	1029	母，母親，お母さん	1	1
326	1030	靴下	1	1
327	1031	ワイシャツ，シャツ	1	1
328	1032	脱ぐ	1	1
329	1033	架ける，ぶら下げる	1	1
330	1034	は（穿）く［ズボンを～］	1	1
331	1035	着る，身につける	1	1
332	1036	かぶる	1	1
333	1037	ハンカチ	1	1
334	1038	スリッパ	1	1
335	1039	傘	1	1
336	1040	ポケット	1	1
337	1041	財布，小銭入れ	1	1
338	1042	身につけている，着ている	1	1
339	1043	服，洋服，衣類	1	1
340	1044	服，洋服，衣類	1	1
341	1045	口	1	1
342	1046	腕（うで）	1	1
343	1047	体（からだ），身体，肉体	1	1
344	1048	顔，顔立ち	1	1
345	1049	脚（あし）	1	1
346	1050	手（て）	1	1
347	1051	鼻，嗅覚	1	1
348	1052	目（め），眼，視力	1	1
349	1053	耳，聴覚，聴力	1	1
350	1054	足（あし）	1	1
351	1055	おなか	1	1
352	1056	皿（さら）	1	1
353	1057	バター	1	1
354	1058	カップ，茶わん	1	1
355	1059	あめ，キャンディー	1	1
356	1060	昼御飯，昼食	1	1
357	1061	夕飯，夕食，晩御飯	1	1
358	1062	お菓子	1	1
359	1063	卵	1	1
360	1064	朝御飯，朝食	1	1
361	1065	イネ，米，御飯（ごはん）	1	1
362	1066	醤油	1	1
363	1067	塩（しお），食塩	1	1
364	1068	夕飯，夕食，晩御飯	1	1
365	1069	くわえる	1	1
366	1070	つける，取り付ける，固定する	1	1
367	1071	カメラ	1	1
368	1072	ストーブ，暖炉	1	1
369	1073	鉛筆	1	1
370	1074	（火・スイッチなどを）消す，消化する	1	1
371	1075	眼鏡（めがね）	1	1
372	1076	テープレコーダー	1	1
373	1077	時計	1	1
374	1078	コンピュータ	1	1
375	1079	フィルム	1	1
376	1080	ドア，戸（と），扉	1	1
377	1081	門（もん），入口	1	1
378	1082	ペン	1	1
379	1083	万年筆	1	1
380	1084	ボールペン	1	1
381	1085	八月	1	1
382	1086	四月	1	1
383	1087	今月	1	1
384	1088	毎月	1	1
385	1089	十二月	1	1
386	1090	二月	1	1
387	1091	一月	1	1
388	1092	七月	1	1
389	1093	六月	1	1
390	1094	来月	1	1
391	1095	五月	1	1
392	1096	三月	1	1
393	1097	先月	1	1
394	1098	十一月	1	1
395	1099	十月	1	1
396	1100	九月	1	1
397	1101	ひとつき，月	1	1
398	1102	今週	1	1
399	1103	毎週	1	1
400	1104	日曜日	1	1
401	1105	木曜日	1	1
402	1106	来週	1	1
403	1107	月曜日	1	1
404	1108	火曜日	1	1
405	1109	水曜日	1	1
406	1110	土曜日	1	1
407	1111	週，週間	1	1
408	1112	先週	1	1
409	1113	金曜日	1	1
410	1114	年（ねん），１年	1	1
411	1115	秋	1	1
412	1116	今年（ことし）	1	1
413	1117	毎年（まいとし）	1	1
414	1118	夏（なつ）	1	1
415	1119	冬	1	1
416	1120	去年	1	1
417	1121	来年	1	1
418	1122	春	1	1
419	1123	再来年	1	1
420	1124	おととし	1	1
421	1125	午後	1	1
422	1126	今日（きょう），本日	1	1
423	1127	明日（あした）	1	1
424	1128	時（じ）	1	1
425	1129	昨日（きのう）	1	1
426	1130	夕べ	1	1
427	1131	午前	1	1
428	1132	朝，午前	1	1
429	1133	昼，正午	1	1
430	1134	夜（よる）	1	1
431	1135	夕方，日暮れ（時），晩	1	1
432	1136	あさって	1	1
433	1137	おととい	1	1
434	1138	もう，早く，すでに	1	1
435	1139	～しながら，～している間に	1	1
436	1140	まだ，いまだに，なお	1	1
437	1141	全体の，全部の，～中(ちゅう)	1	1
438	1142	時（とき）	1	1
439	1143	いつ，何時に	1	1
440	1144	ときどき	1	1
441	1145	しばしば，頻繁に，多くの場合	1	1
442	1146	時間，期間，時期	1	1
443	1147	間もなく，すぐに	2	1
444	1148	灰皿	1	1
445	1149	歌（うた）	1	1
446	1150	歌う	1	1
447	1151	たばこ	1	1
448	1152	映画	1	1
449	1153	レコード	1	1
450	1154	ギター	1	1
451	1155	（楽器を）演奏する，弾く	3	1
452	1156	音楽	1	1
453	1157	絵（え），図，写真，画像	1	1
454	1158	写真	1	1
455	1159	好き，気に入る	1	1
456	1160	声	1	1
457	1161	晴れた，澄んだ	1	1
458	1162	暑い，熱い	1	1
459	1163	晴れる	1	1
460	1164	涼しい，冷たい	1	1
461	1165	寒い	1	1
462	1166	雪（ゆき）	1	1
463	1167	雨が降る	1	1
464	1168	雨	1	1
465	1169	天気，天候，気象	1	1
466	1170	暖かい，温かい，温暖な	1	1
467	1171	風（かぜ）	1	1
468	1172	曇り，曇った	1	1
469	1173	冷たい	1	1
470	1174	曇る	1	1
471	1175	漢字	1	1
472	1176	言う，述べる	1	1
473	1177	（文字・手紙・文章などを）書く，つづる，執筆する	1	1
474	1178	話（はなし），会話，会談	1	1
475	1179	言葉，言語	1	1
476	1180	ドイツ語	1	1
477	1181	語（ご），単語	1	1
478	1182	話す，しゃべる	1	1
479	1183	文，文章	1	1
480	1184	語る，語って聞かせる，叙述する	1	1
481	1185	意味	1	1
482	1186	平仮名	1	1
483	1187	片仮名	1	1
484	1188	大人（おとな），成人	1	1
485	1189	大勢，たくさんの人々	1	1
486	1190	夫婦	1	1
487	1191	子供，子	1	1
488	1192	妻，奥さん	2	1
492	1196	男，男性	1	1
490	1194	男の子	1	1
493	1197	女の子，少女	1	1
494	1198	夫	2	1
495	1199	人，人間，（特定の）人物	1	1
496	1200	みんな，すべての人々	1	1
497	1201	白（しろ），白い	1	1
498	1202	青，青い，ブルーの	1	1
499	1203	茶色	1	1
500	1204	（色が）明るい，淡い，薄い	1	1
501	1205	色（いろ），色彩，色調	1	1
502	1206	（色が）濃い，暗い	1	1
503	1207	黄色（きいろ），黄色い	1	1
504	1208	黒（くろ），黒い	1	1
505	1209	赤，赤い	1	1
506	1210	緑，緑色の	1	1
507	1211	便利な，有用な，実用的な，役に立つ	1	1
508	1212	パーティー	1	1
509	1213	紙，書類，文書	1	1
510	1214	～になる	1	1
511	1215	締める，閉じる	1	1
512	1216	押す，押し付ける	1	1
513	1217	始まる，開始する	1	1
514	1218	ちょうど，ちょうどそのとき	1	1
515	1219	（１つも）ない，～ではない	1	1
516	1220	まっすぐ	1	1
517	1221	有名な，高名な	1	1
518	1222	元気な，健やかな，活発な	1	1
519	1223	じゃあ	1	1
520	1224	多分，おそらく	1	1
521	1225	では	1	1
522	982	年齢が～の	1	1
523	720	お知らせ，メッセージ	1	1
524	777	（es gibt + 4格で） ～がある，存在する	2	1
525	801	～という（意味）ことである	2	1
526	1195	（間投詞的に）おいこら，おやまあ	2	1
527	977	困難な，難しい	2	1
528	1142	時間，期間，時期	2	1
529	1146	時（とき）	1	1
530	1165	冷たい	2	1
531	1173	寒い	1	1
532	1128	時計	1	1
533	1077	時（じ）	2	1
534	974	（空間的に）遠い	2	1
535	902	食事（すること）	1	1
536	782	洗う	1	0
537	1181	言葉，話	2	1
538	940	浴室	2	1
539	1185	重要性，価値，意義	2	1
540	753	勤めている，働いている	2	1
541	967	同じぐらい，それほど	2	1
542	967	とても，たいへん	3	1
543	924	葉	1	1
544	982	年老いた，高齢の	1	1
545	1223	したがって，それゆえに	1	1
546	1035	（人に）服を着せる	1	1
547	751	（結果としての）作品，業績，論文	2	1
548	803	立つ，（座った状態から）立ち上がる，起立する	1	1
549	826	起きる，起床する	2	1
550	1032	（人の）服を脱がす	1	1
551	1163	明確になる，解明される	2	1
552	1070	固める，堅固にする，強化する	2	1
553	911	（感謝や謝罪に対し）どういたしまして	2	1
554	924	新聞，雑誌	3	1
555	1014	弟 \n＊特に年下の場合は，jüngerer Bruderという。	2	1
556	1026	弟 ＊特に年下の場合は，jüngerer Bruderという。	2	1
557	1014	（複数で）兄弟	3	1
558	1026	（複数で）兄弟	3	1
559	811	（時間的に）そのときに，その頃	2	1
560	811	（原因・結果）～だから，～なので	3	1
561	968	太った，でぶの	2	1
562	968	腫れた	3	1
563	972	太った，でぶの	2	1
564	972	腫れた	3	1
565	968	濃密な，密接な	4	1
566	972	濃密な，密接な	4	1
567	1206	暗い，暗闇の	1	1
568	995	（色が）濃い，暗い	2	1
569	970	希薄な，水っぽい，中身の乏しい	2	1
570	978	希薄な，水っぽい，中身の乏しい	2	1
571	1218	かろうじて，ぎりぎりのところで，やっとのことで	2	1
572	1218	まさに，まさしく	3	1
573	906	入ること，入場	2	1
574	950	入ること，入場	2	1
575	906	（郵便物の）到着，（商品の）入荷	3	0
576	950	（郵便物の）到着，（商品の）入荷	3	0
577	969	（関係が）密接な，親密な	2	1
578	1184	述べる，伝える，報告する	2	1
579	1205	絵の具，塗料，染料	2	1
580	1205	顔色（Gesichtsfarbe），血色	2	1
581	1082	羽，羽毛，羽布団	1	1
582	805	テレビ（放送），テレビの画像	1	1
583	976	（時間的に）遠い昔の，ずっと先の	2	1
584	1079	映画	2	1
585	1152	フィルム	1	1
586	730	飛行機で行く，空の旅をする	2	0
587	730	飛ぶような速さで動く・進む	3	0
588	849	問題，テーマ	2	1
589	1193	妻，奥さん	2	1
590	1192	女（おんな），女性，婦人	1	1
591	1018	女（おんな），女性，婦人	1	1
592	1018	（既婚の女性に対する呼びかけ・敬称）～さん，～夫人	3	1
593	1192	（既婚の女性に対する呼びかけ・敬称）～さん，～夫人	3	1
594	1193	（既婚の女性に対する呼びかけ・敬称）～さん，～夫人	3	1
595	827	ボーイフレンド，恋人 <女>Freundin	2	1
596	1141	とても，かなりに，相当	3	1
597	1141	かなりの，多くの	2	1
598	777	催す，開催する，上演する	2	1
599	705	（機械などが）動く，機能する	3	0
600	705	（非人称）事が進行する，～の具合（調子）が…である，うまくいく	4	1
601	705	～へ行く，～しに行く	2	1
602	1048	顔つき，表情	2	1
603	884	ガラス	1	0
604	884	（単位名詞）杯	3	1
605	1147	すぐそばに	3	1
606	1147	同じく，等しく，同様に	1	1
607	862	程度，度合い，段階	2	1
608	971	年上の，成長した	2	1
609	971	重要な，主要な	3	1
610	971	高度な，非常な	4	1
611	986	上手（じょうず）な，有能な，優れた，うまい	2	1
612	986	丈夫な，健康な	3	1
613	723	よい，正しい，好ましい，適切な	1	1
614	723	丈夫な，健康な	3	1
615	1033	掛かっている，掛けてある	2	1
616	789	自宅	2	1
617	839	（雑誌の）冊，号	2	1
618	1162	激しい，激烈な	2	1
619	1161	朗らかな，陽気な，明るい	2	1
620	987	（色が）明るい，淡い，薄い	2	1
621	1204	（光で）明るい	1	1
622	810	（人に物を与えたり示したりときなど）さあ，ここに	2	1
623	767	（位置が）高い，高く上へ	2	1
624	767	（数値が）高い，高額の	3	1
625	817	（事柄を）聞き知る，（口頭で）知らされる	2	1
626	1139	～することによって	2	0
627	828	（分類上の）グループ，部類	2	0
628	828	（列車などの）等級	3	1
629	916	くっついている，貼ってある	2	1
630	980	（年齢が）小さい，若い，幼い	2	1
631	980	（時間的に）短い	3	1
632	980	（程度的に）小さい，些細な	4	1
633	819	（時間的に）短い，短時間の	2	1
634	714	田舎，地方，地域	2	1
635	714	陸，陸地	3	1
636	824	（時間的に）長い，長期の	2	1
637	847	軽い，軽量の	2	1
638	847	すぐに（よく）～する	3	1
639	975	易しい，簡単な，楽な	1	1
640	975	すぐに（よく）～する	3	1
641	756	貸す，貸与する	1	1
642	925	借りる	2	1
643	1074	消去する，抹消する	2	1
644	1196	夫	2	1
645	1198	男（おとこ），男性	1	1
646	1196	（間投詞的に）（警告・怒り・驚きを表して）おやおや，まいったな	3	1
647	1198	（間投詞的に）（警告・怒り・驚きを表して）おやおや，あきれた	3	1
648	1199	（間投詞的に）おいこら，おやまあ，	2	1
649	1001	（時間的に）半ば，中旬	2	1
650	1222	目の覚めた	2	1
651	722	～かもしれない，～でありうる	2	1
652	722	（möchteの形で）欲しい，～したい，～したがっている，～してもらいたい	3	1
653	776	～かもしれない，～でありうる	1	1
654	776	好きだ，好む	1	1
655	985	（数値・程度などが）低い，少ない，安い	2	1
656	981	（時間的に）近い，間近い	2	1
657	981	（関係が）近い，親密な	3	1
658	815	（時間的な）近さ，近い将来	2	0
659	815	（関係・事柄の）近さ	3	0
660	809	（３格と）～と並んで，～以外に，～に加えて	2	1
661	816	（３格と）～と並んで，～以外に，～に加えて	2	1
662	1140	その上なお，さらに，もっと	2	1
663	806	警察，警察署	1	0
664	807	警察，警察署	1	0
665	1211	実際的な，実践的な	1	1
666	923	＊特に，小型小包はPäckchenという。	2	1
667	783	洗濯する，（ドライ）クリーニングする	2	0
668	919	郵便（制度）	2	1
669	790	クリーニング，クリーニング店	2	1
670	996	落ち着いた，平穏な	2	1
671	898	（刃物が）鋭い，切れ味がよい	1	1
672	993	（状況・天候などが）思わしくない，不調の	2	1
673	726	（状況・天候などが）思わしくない，不調の	2	1
674	993	（身体の器官が）よく機能しない，体の具合が悪い	3	1
675	726	（身体の器官が）よく機能しない，体の具合が悪い	3	1
676	867	（商店・施設などを）閉める，閉鎖する	2	1
677	867	（会議・演説などを）終わりにする，締めくくる	3	1
678	779	（解明の）鍵，手がかり	2	0
679	1138	きっと，必ず，確かに	2	1
680	991	（天気が）よく晴れた，快適な	2	1
681	991	かなりの，相当の	3	1
682	991	心からの，どうも	4	1
683	977	重大な，はなはだしい	3	1
684	988	（知的・能力的に）弱い，劣った	3	1
685	988	（物が）弱い，（性能が）低い	2	1
686	1023	妹	2	1
687	1023	姉妹	3	1
688	1024	姉，お姉さん	1	1
689	1024	妹	2	1
690	1027	姉妹	3	1
691	1027	妹	2	1
692	992	（予定より）遅れた，遅刻の	2	1
693	1155	遊ぶ	1	1
694	1155	（スポーツ競技を）する	2	1
695	719	（スポーツ競技を）する	2	1
696	719	（楽器を）演奏する，弾く	3	1
697	1182	（ある言語を）話す	2	1
698	888	小さい棒	1	1
699	989	（能力・性能が）優れた，強力な	2	1
700	989	（程度が）強い，激しい	3	1
701	1160	意見（表明），意思（表示）	2	0
702	886	かわいい	2	1
703	937	ポケット	2	1
704	1040	かばん，バック	1	1
705	1081	（サッカーなどの）ゴール，得点	2	1
706	1042	（持ち）運ぶ，持っていく（くる）	2	1
707	715	当てる，命中させる	2	1
708	748	（影響などを）及ぼす，重要である	2	1
709	748	leid, wehなどと共に	3	1
710	1010	（４格と）～について，～に関して	2	1
711	1008	（時間的に）～の間に	2	1
712	994	よく，しばしば	2	1
713	994	はるかに，ずっと	3	1
714	994	（wie, soなどど）～数（量）の	4	1
715	821	（時間的に）（３格と）～の前に	2	1
716	821	（原因）（３格と）～のあまり（思わず）	3	1
717	821	（感情の対象）～に対して\n	3	1
718	769	何	1	1
719	769	何かあるもの（こと）	3	1
720	769	～すること	4	1
721	797	洗濯する	2	0
722	787	洗濯物	2	1
723	974	（時間的に）遠い	3	1
724	1214	（未来）～するだろう	2	1
725	1214	（受動）～られる，～される	4	1
726	1214	（推量）～らしい，～かもしれない	3	1
727	962	～のような，～ごとく	2	1
728	962	どれくらい，どれほど	2	1
729	813	～であるところの	2	1
730	945	泊まる，滞在する	2	1
731	1000	面，側，ページ	1	1
732	1004	（抽象的な）高さ，程度	2	1
733	743	（方向を示す語句と共に）～へ曲がる，カーブする	2	1
734	1226	毎日	1	1
491	1195	人，人間，（特定の）人物	1	1
489	1193	女（おんな），女性，婦人	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
2	30580	1.3101	1.31	体	活動	言語	言語	英語	英語	えいご
3	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
4	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
5	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
6	30586	1.3101	1.31	体	活動	言語	言語	フランス語	フランス語	ふらんすご
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
248	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
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
511	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
513	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
516	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
517	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
519	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
591	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
613	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
637	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
319	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
696	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
5	357	491	0	\N	0	\N	\N
6	496	91	0	\N	0	\N	\N
10	47	1149	0	\N	0	\N	\N
12	150	44	0	\N	0	\N	\N
17	9	186	1	Lange	0	\N	\N
19	161	1154	0	\N	0	\N	\N
21	137	267	0	\N	0	\N	\N
25	94	750	0	\N	0	\N	\N
37	108	1301	0	\N	0	\N	\N
38	298	1243	0	\N	0	\N	\N
40	512	1393	1	wie geht 's  wie geht es	0	\N	\N
42	77	662	0	\N	0	\N	\N
43	454	112	0	\N	0	\N	\N
44	454	1557	0	\N	0	\N	\N
45	329	112	1	so	0	\N	\N
56	247	163	0	\N	0	\N	\N
64	451	145	0	\N	0	\N	\N
65	15	482	0	\N	0	\N	\N
66	189	1276	0	\N	0	\N	\N
72	203	1303	0	\N	0	\N	\N
73	425	1467	0	\N	0	\N	\N
75	450	1086	0	\N	0	\N	\N
76	180	203	0	\N	0	\N	\N
78	443	323	0	\N	0	\N	\N
79	267	1225	0	\N	0	\N	\N
85	286	1183	0	\N	0	\N	\N
87	223	972	0	\N	0	\N	\N
89	113	1582	0	\N	0	\N	\N
91	116	107	0	\N	0	\N	\N
92	116	108	0	\N	0	\N	\N
95	327	955	0	\N	0	\N	\N
96	205	428	0	\N	0	\N	\N
97	235	956	0	\N	0	\N	\N
99	387	1258	0	\N	0	\N	\N
102	490	115	0	\N	0	\N	\N
103	416	1190	0	\N	0	\N	\N
106	190	214	0	\N	0	\N	\N
108	227	77	0	\N	0	\N	\N
112	124	319	0	\N	0	\N	\N
114	358	147	0	\N	0	\N	\N
116	10	285	0	\N	0	\N	\N
117	21	148	0	\N	0	\N	\N
118	21	254	1	in	0	\N	\N
122	54	296	0	\N	0	\N	\N
123	54	782	0	\N	0	\N	\N
126	493	118	0	\N	0	\N	\N
129	196	539	0	\N	0	\N	\N
130	356	215	0	\N	0	\N	\N
131	405	1609	0	\N	0	\N	\N
132	403	1608	0	\N	0	\N	\N
135	452	717	0	\N	0	\N	\N
143	18	161	0	\N	0	\N	\N
147	88	108	0	\N	0	\N	\N
148	464	1418	0	\N	0	\N	\N
149	13	250	0	\N	0	\N	\N
150	13	983	0	\N	0	\N	\N
152	228	522	0	\N	0	\N	\N
160	163	637	0	\N	0	\N	\N
165	224	353	0	\N	0	\N	\N
168	504	1526	0	\N	0	\N	\N
171	139	362	0	\N	0	\N	\N
181	35	65	0	\N	0	\N	\N
183	184	1267	0	\N	0	\N	\N
185	463	208	1	meins	0	\N	\N
187	456	199	0	\N	0	\N	\N
192	233	487	0	\N	0	\N	\N
193	177	1635	0	\N	0	\N	\N
194	37	754	0	\N	0	\N	\N
195	178	347	0	\N	0	\N	\N
196	46	1478	0	\N	0	\N	\N
199	89	89	0	\N	0	\N	\N
203	243	669	0	\N	0	\N	\N
206	424	126	0	\N	0	\N	\N
210	408	1645	0	\N	0	\N	\N
214	65	1175	0	\N	0	\N	\N
215	83	215	0	\N	0	\N	\N
216	197	623	0	\N	0	\N	\N
217	293	263	0	\N	0	\N	\N
220	465	207	0	\N	0	\N	\N
221	258	18	0	\N	0	\N	\N
222	467	510	0	\N	0	\N	\N
230	58	329	0	\N	0	\N	\N
233	176	511	0	\N	0	\N	\N
237	409	1653	0	\N	0	\N	\N
240	145	194	0	\N	0	\N	\N
241	36	508	0	\N	0	\N	\N
243	42	358	0	\N	0	\N	\N
247	501	1525	0	\N	0	\N	\N
253	232	136	0	\N	0	\N	\N
259	185	1703	1		0	\N	\N
264	519	1455	0	\N	0	\N	\N
266	330	1705	1		0	\N	\N
267	342	1706	1		0	\N	\N
268	150	323	0	\N	0	\N	\N
269	332	1707	1		0	\N	\N
273	208	1710	1		0	\N	\N
280	5	1713	1		0	\N	\N
281	5	1711	2		0	\N	\N
284	131	1715	2		0	\N	\N
285	328	1716	1		0	\N	\N
286	459	1717	1		0	\N	\N
288	236	1719	1		0	\N	\N
289	444	1720	1		0	\N	\N
290	517	1721	1		0	\N	\N
291	49	1701	1	beschäftigtはbeschäftigenの過去分詞形	0	\N	\N
295	218	1724	1		0	\N	\N
296	107	212	0	\N	0	\N	\N
298	382	1725	1		0	\N	\N
300	43	1727	1		0	\N	\N
301	245	1728	1		0	\N	\N
302	481	1729	1		0	\N	\N
303	157	1730	1		0	\N	\N
305	498	1731	1		0	\N	\N
306	61	1732	1		0	\N	\N
307	369	1733	1		0	\N	\N
308	355	1734	1		0	\N	\N
309	16	1735	1		0	\N	\N
310	499	1736	1		0	\N	\N
311	210	1737	1		0	\N	\N
313	193	1739	1		0	\N	\N
314	471	1740	1		0	\N	\N
316	309	1742	1	Cousine　（女の）いとこ	0	\N	\N
317	385	1743	1		0	\N	\N
318	291	1744	1		0	\N	\N
319	274	1745	1		0	\N	\N
320	514	1746	0		0	\N	\N
321	486	1747	1		0	\N	\N
322	359	1748	1		0	\N	\N
323	202	1749	1		0	\N	\N
325	166	1751	1		0	\N	\N
326	265	1752	1		0	\N	\N
331	272	1756	1		0	\N	\N
333	71	1758	1		0	\N	\N
334	3	1759	1		0	\N	\N
335	126	1760	1		0	\N	\N
336	126	1761	2		0	\N	\N
337	279	1762	1		0	\N	\N
339	418	1764	1		0	\N	\N
341	379	1766	1		0	\N	\N
344	345	1722	2	ja	0	\N	\N
345	350	1767	1	morgen	0	\N	\N
346	350	1768	2		0	\N	\N
349	417	1771	1	gut	0	\N	\N
354	73	362	2	lese	0	\N	\N
357	67	1763	0	\N	0	\N	\N
358	74	1773	1		0	\N	\N
359	474	1774	1		0	\N	\N
360	171	1775	1		0	\N	\N
362	312	1777	1		0	\N	\N
364	280	1779	1		0	\N	\N
365	344	1780	1		0	\N	\N
366	313	1781	1		0	\N	\N
367	506	1782	1		0	\N	\N
368	28	1783	1		0	\N	\N
369	138	1784	1		0	\N	\N
372	97	1097	2	wirklich	0	\N	\N
380	120	1789	1		0	\N	\N
381	301	1790	1		0	\N	\N
382	295	1791	1		0	\N	\N
384	23	796	1	schenke	0	\N	\N
388	384	1794	1		0	\N	\N
391	383	1797	1		0	\N	\N
393	393	1798	1	lieb	0	\N	\N
394	391	1799	1		0	\N	\N
396	526	1584	0	\N	0	\N	\N
397	495	1800	1	hoffe	0	\N	\N
399	175	1802	1		0	\N	\N
400	429	1803	1		0	\N	\N
401	297	1804	1		0	\N	\N
402	397	1805	1		0	\N	\N
404	315	287	1	\N	0	\N	\N
405	315	567	2	\N	0	\N	\N
406	325	287	1	fahre	0	\N	\N
407	325	567	2	mit	0	\N	\N
409	18	162	1	jetzt	0	\N	\N
412	390	1806	1		0	\N	\N
413	17	1807	1		0	\N	\N
414	341	1808	1		0	\N	\N
415	518	1809	1		0	\N	\N
426	112	111	1	arbeiten	0	\N	\N
427	112	110	2	Na ja	0	\N	\N
429	277	1811	1		0	\N	\N
430	277	1810	2		0	\N	\N
438	281	1812	1		0	\N	\N
439	394	1813	1		0	\N	\N
441	441	1362	0	\N	0	\N	\N
443	376	669	1	vergessen	0	\N	\N
444	66	1814	1		0	\N	\N
445	368	1815	1		0	\N	\N
446	349	1816	1		0	\N	\N
447	395	1817	1		0	\N	\N
448	509	1818	1		0	\N	\N
452	337	1057	1	\N	0	\N	\N
455	242	1819	1		0	\N	\N
456	110	1820	1		0	\N	\N
457	103	1821	1		0	\N	\N
458	102	1821	1	Preislage	0	\N	\N
460	29	1822	1		0	\N	\N
461	507	1823	1		0	\N	\N
464	231	1826	1		0	\N	\N
466	335	1828	1		0	\N	\N
468	14	109	1	mich	0	\N	\N
469	14	82	2	\N	0	\N	\N
470	195	1829	1		0	\N	\N
471	60	1830	1		0	\N	\N
472	292	1831	1		0	\N	\N
473	420	1832	1		0	\N	\N
475	505	1796	1	mehr	0	\N	\N
476	75	1833	1		0	\N	\N
477	194	1834	1		0	\N	\N
478	192	1835	1		0	\N	\N
484	121	1483	1	zur	0	\N	\N
485	462	1837	1		0	\N	\N
486	22	1838	1		0	\N	\N
487	186	1839	1		0	\N	\N
488	363	1840	1		0	\N	\N
489	449	1841	1		0	\N	\N
492	69	1843	1		0	\N	\N
494	273	1669	0	\N	0	\N	\N
496	527	1342	1	\N	0	\N	\N
499	19	246	1	\N	0	\N	\N
500	19	1337	2	\N	0	\N	\N
501	441	1219	0	\N	0	\N	\N
502	24	1362	1	können	0	\N	\N
511	447	1844	1		0	\N	\N
513	362	1845	1		0	\N	\N
516	178	1349	0	\N	0	\N	\N
519	179	1349	1	Urlaub	0	\N	\N
520	179	347	2	denn	0	\N	\N
521	142	1847	1		0	\N	\N
522	373	1848	1		0	\N	\N
523	324	196	1	ach	0	\N	\N
526	149	1849	1		0	\N	\N
527	174	1850	1		0	\N	\N
528	457	1851	1		0	\N	\N
529	468	1851	1	da	0	\N	\N
532	419	1852	1		0	\N	\N
534	469	837	1	endlich	0	\N	\N
535	530	837	1	vorbei	0	\N	\N
536	531	139	1	Elke	0	\N	\N
537	483	1853	1		0	\N	\N
539	276	852	1	jetzt	0	\N	\N
540	156	1836	0	\N	0	\N	\N
541	57	1393	0	\N	0	\N	\N
544	532	1848	1	letztes	0	\N	\N
550	234	1521	2	zwei	0	\N	\N
551	165	1854	1		0	\N	\N
552	144	1855	1		0	\N	\N
553	134	1856	1		0	\N	\N
554	117	117	0	\N	0	\N	\N
555	117	118	0	\N	0	\N	\N
556	427	1857	1		0	\N	\N
557	59	1858	1		0	\N	\N
561	399	1859	1		0	\N	\N
562	398	1860	1		0	\N	\N
563	520	1861	1		0	\N	\N
567	497	1862	2		0	\N	\N
568	534	125	0	\N	0	\N	\N
570	84	1864	1		0	\N	\N
571	535	216	1	doch	0	\N	\N
582	536	274	2	wiederzusehen	0	\N	\N
583	20	1868	1		0	\N	\N
585	216	255	1	geplant	0	\N	\N
588	511	798	1	am	0	\N	\N
589	537	1729	1	Frankreich	0	\N	\N
590	477	1870	1		0	\N	\N
591	351	1730	1	gelebt	0	\N	\N
593	370	1872	1		0	\N	\N
594	119	1873	1		0	\N	\N
595	159	1874	1		0	\N	\N
596	364	491	1	einfach	0	\N	\N
598	431	1228	1	\N	0	\N	\N
599	431	1050	2	\N	0	\N	\N
600	209	184	1	schon	0	\N	\N
601	209	1875	2		0	\N	\N
602	137	202	1	Was	0	\N	\N
603	381	1876	1		0	\N	\N
604	538	1877	1		0	\N	\N
607	539	1878	1		0	\N	\N
608	540	282	1	\N	0	\N	\N
609	516	1293	0	\N	0	\N	\N
614	263	1352	1	\N	0	\N	\N
615	263	1366	2	\N	0	\N	\N
616	263	730	3	\N	0	\N	\N
620	541	889	1	\N	0	\N	\N
624	288	1846	1		0	\N	\N
625	288	141	2	\N	0	\N	\N
640	475	1882	4		0	\N	\N
641	311	1883	1		0	\N	\N
644	326	1884	1		0	\N	\N
646	182	1886	1		0	\N	\N
648	40	1888	1		0	\N	\N
650	542	1022	1	\N	0	\N	\N
653	99	1332	1	\N	0	\N	\N
654	99	1868	2	\N	0	\N	\N
656	278	1704	1		0	\N	\N
657	278	361	2	\N	0	\N	\N
658	544	1890	1		0	\N	\N
661	545	1578	1	\N	0	\N	\N
662	545	1651	2	\N	0	\N	\N
664	147	259	1	\N	0	\N	\N
665	147	587	2	\N	0	\N	\N
666	546	1726	1		0	\N	\N
667	331	1705	2	richtig	0	\N	\N
668	47	178	0	\N	0	\N	\N
669	547	1697	0	\N	0	\N	\N
672	48	1674	1	\N	0	\N	\N
673	48	376	2	\N	0	\N	\N
674	48	1694	3	\N	0	\N	\N
677	479	201	1	\N	0	\N	\N
678	479	294	2	\N	0	\N	\N
679	549	1332	1	Erst	0	\N	\N
680	549	1868	2	hab'	0	\N	\N
681	548	1891	1		0	\N	\N
682	122	1891	1	ja	0	\N	\N
683	550	1892	1		0	\N	\N
686	38	76	1	\N	0	\N	\N
687	38	196	2	\N	0	\N	\N
688	38	529	3	\N	0	\N	\N
689	551	1893	1		0	\N	\N
690	164	71	1	\N	0	\N	\N
691	164	288	2	\N	0	\N	\N
692	164	1596	3	\N	0	\N	\N
693	201	73	1	\N	0	\N	\N
694	201	1894	2		0	\N	\N
696	366	1895	1		0	\N	\N
697	552	1896	1		0	\N	\N
698	513	126	1	hier	0	\N	\N
699	513	1897	2		0	\N	\N
701	453	1554	1	\N	0	\N	\N
702	453	1757	2	\N	0	\N	\N
704	207	136	1	\N	0	\N	\N
705	207	132	2	\N	0	\N	\N
706	553	1064	0	\N	0	\N	\N
708	543	1898	1		0	\N	\N
709	220	1899	1		0	\N	\N
710	220	1385	2	\N	0	\N	\N
711	523	1900	1		0	\N	\N
712	214	1901	1		0	\N	\N
713	214	493	2	\N	0	\N	\N
714	213	1902	1		0	\N	\N
715	371	1903	1		0	\N	\N
716	371	746	2	\N	0	\N	\N
717	322	95	1	Claudia	0	\N	\N
719	556	1472	1	Das	0	\N	\N
722	555	1472	1	\N	0	\N	\N
724	310	95	1	\N	0	\N	\N
728	557	1906	1		0	\N	\N
729	558	1906	1	mit	0	\N	\N
732	55	55	1	\N	0	\N	\N
733	55	487	2	\N	0	\N	\N
734	55	776	3	\N	0	\N	\N
738	30	75	1	\N	0	\N	\N
739	30	654	2	\N	0	\N	\N
740	30	1907	3		0	\N	\N
741	353	1738	1		0	\N	\N
742	353	1908	2		0	\N	\N
743	470	1702	1		0	\N	\N
744	470	1909	2		0	\N	\N
746	173	1214	1	\N	0	\N	\N
747	173	1241	2	\N	0	\N	\N
749	374	1681	1	\N	0	\N	\N
750	374	1677	2	\N	0	\N	\N
751	199	1741	1		0	\N	\N
752	199	1910	2		0	\N	\N
755	560	719	1	\N	0	\N	\N
756	560	295	2	\N	0	\N	\N
757	559	232	0	\N	0	\N	\N
760	521	1155	1	\N	0	\N	\N
761	521	1605	2	\N	0	\N	\N
762	521	1050	3	\N	0	\N	\N
764	50	1723	1		0	\N	\N
765	50	1252	2	\N	0	\N	\N
766	521	1465	0	\N	0	\N	\N
773	257	80	1	\N	0	\N	\N
774	257	337	2	\N	0	\N	\N
775	257	315	3	\N	0	\N	\N
780	476	480	1	\N	0	\N	\N
781	476	547	2	\N	0	\N	\N
782	476	222	3	\N	0	\N	\N
783	476	742	4	\N	0	\N	\N
785	264	782	1	Die	0	\N	\N
787	268	782	1	wirklich	0	\N	\N
788	268	1738	2	super	0	\N	\N
789	561	1911	1		0	\N	\N
790	563	1911	1	wissen	0	\N	\N
791	562	1912	1		0	\N	\N
792	564	1912	1	drin	0	\N	\N
793	264	1738	2	\N	0	\N	\N
794	565	1913	1		0	\N	\N
795	566	1913	1	mal	0	\N	\N
799	298	25	0	\N	0	\N	\N
800	404	1914	1		0	\N	\N
802	256	184	1	\N	0	\N	\N
803	256	1382	2	\N	0	\N	\N
804	256	349	3	\N	0	\N	\N
808	254	192	1	\N	0	\N	\N
809	254	804	2	\N	0	\N	\N
810	254	823	3	\N	0	\N	\N
811	254	965	4	\N	0	\N	\N
812	401	1915	1		0	\N	\N
813	567	1744	1	da	0	\N	\N
815	502	1916	1	schon	0	\N	\N
816	568	1916	1		0	\N	\N
817	568	1917	2		0	\N	\N
818	502	1917	2	da	0	\N	\N
820	266	1745	1	kann	0	\N	\N
821	266	1918	2		0	\N	\N
822	274	1918	2		0	\N	\N
823	569	1919	1		0	\N	\N
824	570	1919	1	kann	0	\N	\N
825	239	1920	1		0	\N	\N
826	244	1921	1		0	\N	\N
827	239	1877	0	\N	0	\N	\N
828	571	1532	1	\N	0	\N	\N
829	572	1922	1		0	\N	\N
830	573	1923	1		0	\N	\N
831	574	1923	1	Kartenautomat	0	\N	\N
832	225	1924	1		0	\N	\N
833	225	1750	2		0	\N	\N
837	317	1043	1	\N	0	\N	\N
838	317	1047	2	\N	0	\N	\N
839	317	340	3	\N	0	\N	\N
840	317	188	4	\N	0	\N	\N
841	577	358	1	\N	0	\N	\N
843	2	880	1	\N	0	\N	\N
844	2	882	2	\N	0	\N	\N
845	206	1161	1	\N	0	\N	\N
846	206	1925	2		0	\N	\N
847	247	66	0	\N	0	\N	\N
848	155	67	1	\N	0	\N	\N
849	155	1926	2		0	\N	\N
850	484	1753	1		0	\N	\N
851	484	1927	2		0	\N	\N
852	480	371	1	\N	0	\N	\N
853	480	1928	2		0	\N	\N
854	578	1929	1		0	\N	\N
858	191	539	1	\N	0	\N	\N
859	191	367	2	\N	0	\N	\N
860	191	1267	3	\N	0	\N	\N
861	191	1453	4	\N	0	\N	\N
863	198	904	1	\N	0	\N	\N
864	198	1438	2	\N	0	\N	\N
865	160	1754	1		0	\N	\N
866	160	1930	2		0	\N	\N
867	160	1931	3		0	\N	\N
870	31	195	1	\N	0	\N	\N
871	31	481	2	\N	0	\N	\N
872	31	352	3	\N	0	\N	\N
873	80	778	1	\N	0	\N	\N
874	80	1932	2		0	\N	\N
875	81	778	1	wohl	0	\N	\N
876	81	1932	2	besuchen	0	\N	\N
877	580	1933	1		0	\N	\N
882	101	121	1	\N	0	\N	\N
883	101	120	2	\N	0	\N	\N
886	386	1935	1		0	\N	\N
887	582	1934	1		0	\N	\N
888	582	1755	2		0	\N	\N
889	240	637	1	\N	0	\N	\N
890	240	1936	2		0	\N	\N
891	12	279	1	\N	0	\N	\N
892	12	153	2	\N	0	\N	\N
893	12	251	3	\N	0	\N	\N
895	583	1937	1		0	\N	\N
896	583	1938	2		0	\N	\N
900	585	1757	1	vergessen	0	\N	\N
904	584	491	2		0	\N	\N
906	448	491	2	\N	0	\N	\N
907	448	126	3	\N	0	\N	\N
908	584	126	3	hätten ... Spaß	0	\N	\N
909	375	1757	1		0	\N	\N
910	375	1939	2		0	\N	\N
911	585	1939	2	mir ... vorstellen	0	\N	\N
912	68	1433	1	\N	0	\N	\N
913	68	1940	2		0	\N	\N
915	454	113	0	\N	0	\N	\N
916	145	1247	0	\N	0	\N	\N
917	588	1941	1		0	\N	\N
919	6	152	1	\N	0	\N	\N
920	6	1100	2	\N	0	\N	\N
921	488	732	1	jemand	0	\N	\N
922	409	1200	0	\N	0	\N	\N
925	314	732	1	\N	0	\N	\N
926	314	378	2	\N	0	\N	\N
929	592	1684	1	\N	0	\N	\N
930	592	1686	2	\N	0	\N	\N
931	591	1890	0	\N	0	\N	\N
932	590	1890	1	erstaunlich	0	\N	\N
933	489	1890	1	gesprochen	0	\N	\N
934	488	378	2	Italienerin	0	\N	\N
937	589	732	1	der	0	\N	\N
938	589	378	2	wollte	0	\N	\N
939	593	1684	1		0	\N	\N
940	594	1684	1	müssen	0	\N	\N
941	593	1686	2	echt	0	\N	\N
942	594	1686	2	jemanden	0	\N	\N
944	595	256	1	\N	0	\N	\N
945	595	1209	2	\N	0	\N	\N
947	123	344	1	\N	0	\N	\N
948	123	1613	2	\N	0	\N	\N
952	596	233	0	\N	0	\N	\N
953	596	1172	0	\N	0	\N	\N
955	437	1769	1		0	\N	\N
956	437	1439	2	\N	0	\N	\N
957	597	1212	0	\N	0	\N	\N
959	237	1772	1		0	\N	\N
960	237	1771	2	\N	0	\N	\N
961	82	1942	1		0	\N	\N
962	82	482	2	\N	0	\N	\N
965	524	603	1	gern	0	\N	\N
966	524	363	2	\N	0	\N	\N
968	360	1765	1		0	\N	\N
969	360	777	2	\N	0	\N	\N
970	598	1943	1		0	\N	\N
973	455	195	1	\N	0	\N	\N
974	455	957	2	\N	0	\N	\N
975	455	1141	3	\N	0	\N	\N
983	600	602	1	\N	0	\N	\N
984	600	1041	2	\N	0	\N	\N
992	1	1420	1	\N	0	\N	\N
993	1	711	2	\N	0	\N	\N
1001	601	68	1	\N	0	\N	\N
1002	601	1589	2	\N	0	\N	\N
1003	601	1944	3		0	\N	\N
1004	601	188	4	\N	0	\N	\N
1005	503	1945	1		0	\N	\N
1016	602	1948	1		0	\N	\N
1017	425	1353	0	\N	0	\N	\N
1019	426	232	1	\N	0	\N	\N
1020	426	1478	2	\N	0	\N	\N
1021	604	623	0	\N	0	\N	\N
1022	605	96	1	\N	0	\N	\N
1023	267	767	0	\N	0	\N	\N
1024	606	1949	1		0	\N	\N
1025	607	1950	1		0	\N	\N
1026	158	1776	1		0	\N	\N
1027	158	1951	2		0	\N	\N
1028	609	1878	0	\N	0	\N	\N
1029	610	1952	1		0	\N	\N
1030	320	277	0	\N	0	\N	\N
1032	613	1174	1	doch	0	\N	\N
1038	614	1041	1	nämlich	0	\N	\N
1042	611	246	1	\N	0	\N	\N
1043	611	1337	2	\N	0	\N	\N
1044	613	1630	2	nass	0	\N	\N
1046	613	1512	3	mir	0	\N	\N
1047	282	1174	1	\N	0	\N	\N
1048	282	1630	2	\N	0	\N	\N
1049	282	1512	3	\N	0	\N	\N
1050	612	1041	1	\N	0	\N	\N
1051	612	1953	2		0	\N	\N
1052	614	1953	2	vergrößern	0	\N	\N
1053	346	274	1	Tofu	0	\N	\N
1054	346	1954	2		0	\N	\N
1056	615	113	1	\N	0	\N	\N
1062	85	357	3	\N	0	\N	\N
1063	616	155	0	\N	0	\N	\N
1064	616	316	0	\N	0	\N	\N
1065	616	891	0	\N	0	\N	\N
1066	85	1704	0	\N	0	\N	\N
1067	617	1955	1		0	\N	\N
1068	135	1956	1		0	\N	\N
1069	458	1957	1		0	\N	\N
1070	458	1785	2		0	\N	\N
1071	618	1958	1		0	\N	\N
1073	525	106	1	hast	0	\N	\N
1074	525	1224	2	\N	0	\N	\N
1075	619	1959	1		0	\N	\N
1076	283	1960	1		0	\N	\N
1078	620	1961	1		0	\N	\N
1079	620	1962	2		0	\N	\N
1080	621	1960	1	genau	0	\N	\N
1081	500	1961	1	beim	0	\N	\N
1082	500	1962	2	Sache	0	\N	\N
1084	41	955	1	\N	0	\N	\N
1085	41	1862	2	\N	0	\N	\N
1086	327	1862	1	wohnt	0	\N	\N
1087	411	1787	1		0	\N	\N
1088	411	1963	2		0	\N	\N
1091	422	16	1	\N	0	\N	\N
1092	422	1228	2	\N	0	\N	\N
1093	422	1073	3	\N	0	\N	\N
1097	106	137	1	\N	0	\N	\N
1098	106	173	2	\N	0	\N	\N
1099	106	326	3	\N	0	\N	\N
1101	622	1183	1	\N	0	\N	\N
1102	622	1833	2	\N	0	\N	\N
1104	308	1564	1	\N	0	\N	\N
1105	308	1964	2		0	\N	\N
1106	482	1965	1		0	\N	\N
1107	623	1293	0	\N	0	\N	\N
1108	63	1966	1		0	\N	\N
1109	624	1967	1		0	\N	\N
1114	625	399	1	\N	0	\N	\N
1115	625	336	2	\N	0	\N	\N
1116	230	1705	0	\N	0	\N	\N
1117	7	1968	1		0	\N	\N
1118	7	488	2	\N	0	\N	\N
1119	70	1969	1		0	\N	\N
1125	249	1	1	\N	0	\N	\N
1126	249	1149	2	\N	0	\N	\N
1127	249	499	3	\N	0	\N	\N
1128	435	1970	1		0	\N	\N
1129	286	1696	0	\N	0	\N	\N
1130	205	1356	0	\N	0	\N	\N
1131	205	1122	0	\N	0	\N	\N
1132	235	198	0	\N	0	\N	\N
1133	412	1971	1		0	\N	\N
1134	412	302	2	\N	0	\N	\N
1139	410	83	1	\N	0	\N	\N
1140	410	327	2	\N	0	\N	\N
1141	410	780	3	\N	0	\N	\N
1143	8	409	1	\N	0	\N	\N
1144	8	1277	2	\N	0	\N	\N
1145	413	1376	0	\N	0	\N	\N
1146	388	1972	1		0	\N	\N
1147	269	350	1	toll	0	\N	\N
1148	269	1973	2		0	\N	\N
1149	389	1974	1		0	\N	\N
1151	172	1123	1	\N	0	\N	\N
1152	172	1345	2	\N	0	\N	\N
1154	461	139	1	\N	0	\N	\N
1155	461	45	2	\N	0	\N	\N
1156	531	45	2	Warum	0	\N	\N
1157	367	1975	1		0	\N	\N
1158	372	1976	1		0	\N	\N
1160	222	1299	1	\N	0	\N	\N
1161	222	382	2	\N	0	\N	\N
1162	227	74	0	\N	0	\N	\N
1167	515	99	1	\N	0	\N	\N
1168	515	982	2	\N	0	\N	\N
1169	515	1480	3	\N	0	\N	\N
1176	487	187	1	\N	0	\N	\N
1177	487	1105	2	\N	0	\N	\N
1178	487	1162	3	\N	0	\N	\N
1179	487	528	4	\N	0	\N	\N
1180	628	1977	1		0	\N	\N
1181	125	1978	1		0	\N	\N
1182	212	1979	1		0	\N	\N
1183	629	1980	1		0	\N	\N
1186	151	1981	1		0	\N	\N
1187	151	1887	2		0	\N	\N
1188	238	1982	1		0	\N	\N
1189	152	1983	1		0	\N	\N
1191	204	9	1	\N	0	\N	\N
1192	204	744	2	\N	0	\N	\N
1193	32	1984	1		0	\N	\N
1194	339	1985	1		0	\N	\N
1195	340	1985	1	das	0	\N	\N
1199	630	1986	1		0	\N	\N
1200	630	1928	2	\N	0	\N	\N
1201	631	1987	1		0	\N	\N
1202	632	1988	1		0	\N	\N
1203	56	1989	1		0	\N	\N
1204	343	1990	1		0	\N	\N
1205	380	1991	1		0	\N	\N
1206	92	1992	1		0	\N	\N
1210	633	1993	2		0	\N	\N
1212	115	1994	2		0	\N	\N
1213	62	1995	1		0	\N	\N
1214	634	1996	1		0	\N	\N
1215	636	1997	1		0	\N	\N
1219	143	253	1	\N	0	\N	\N
1221	638	368	1	\N	0	\N	\N
1222	640	368	1	setzen ... sich	0	\N	\N
1223	639	253	1	hier	0	\N	\N
1224	641	1655	0	\N	0	\N	\N
1225	221	1655	1	magst	0	\N	\N
1228	643	1998	1		0	\N	\N
1229	445	1999	1		0	\N	\N
1230	440	1795	1		0	\N	\N
1231	440	2000	2		0	\N	\N
1234	646	1499	0	\N	0	\N	\N
1235	647	1499	1	um	0	\N	\N
1236	648	1584	1	gefällt	0	\N	\N
1238	492	1564	1	\N	0	\N	\N
1239	492	827	2	\N	0	\N	\N
1241	644	282	0	\N	0	\N	\N
1243	4	1718	1		0	\N	\N
1244	4	1792	2	\N	0	\N	\N
1245	494	282	2	wollte	0	\N	\N
1246	645	1564	1	Magisterarbeit	0	\N	\N
1247	645	827	2	japanisches	0	\N	\N
1248	153	1793	1		0	\N	\N
1249	153	2001	2		0	\N	\N
1250	649	1876	0	\N	0	\N	\N
1251	403	1498	0	\N	0	\N	\N
1253	423	183	1	\N	0	\N	\N
1254	423	207	2	\N	0	\N	\N
1255	650	2002	1		0	\N	\N
1257	421	665	1	\N	0	\N	\N
1258	421	1571	2	\N	0	\N	\N
1259	654	161	1	jetzt	0	\N	\N
1260	654	162	2	denn	0	\N	\N
1263	72	155	1	\N	0	\N	\N
1264	72	160	2	Ins	0	\N	\N
1266	652	155	1	brauchen\n	0	\N	\N
1267	652	160	2	Zentrum	0	\N	\N
1268	653	2003	1		0	\N	\N
1269	651	2003	1	bis	0	\N	\N
1270	428	771	1	\N	0	\N	\N
1271	428	2004	2		0	\N	\N
1274	430	248	1	\N	0	\N	\N
1275	430	1344	2	\N	0	\N	\N
1276	430	934	3	\N	0	\N	\N
1277	656	2005	1		0	\N	\N
1278	657	2006	1		0	\N	\N
1279	111	2007	1		0	\N	\N
1280	111	1291	2	mir geht's	0	\N	\N
1281	348	1709	1		0	\N	\N
1282	348	1708	2		0	\N	\N
1283	347	2008	1		0	\N	\N
1285	105	111	1	\N	0	\N	\N
1286	105	110	2	\N	0	\N	\N
1287	105	1301	3	\N	0	\N	\N
1288	112	1301	3	Geburtstag	0	\N	\N
1289	660	2009	1		0	\N	\N
1290	661	2009	1	da	0	\N	\N
1292	275	292	1	Tschüs	0	\N	\N
1293	275	1544	2	Dann	0	\N	\N
1294	275	1321	3	\N	0	\N	\N
1295	655	2010	1		0	\N	\N
1298	662	614	1	\N	0	\N	\N
1299	662	1344	2	\N	0	\N	\N
1302	436	1089	1	\N	0	\N	\N
1303	436	45	2	\N	0	\N	\N
1304	436	823	3	\N	0	\N	\N
1311	316	72	1	\N	0	\N	\N
1312	316	64	2	\N	0	\N	\N
1314	305	2013	1		0	\N	\N
1315	305	2014	2		0	\N	\N
1317	334	2016	1		0	\N	\N
1319	508	722	1	\N	0	\N	\N
1320	508	348	2	\N	0	\N	\N
1322	215	77	1	\N	0	\N	\N
1324	211	2018	1		0	\N	\N
1329	219	2019	1		0	\N	\N
1330	219	1010	2	\N	0	\N	\N
1332	666	124	1	\N	0	\N	\N
1333	665	2020	1		0	\N	\N
1334	146	1825	1		0	\N	\N
1335	146	1824	2		0	\N	\N
1338	141	719	1	\N	0	\N	\N
1339	141	321	2	\N	0	\N	\N
1340	667	2021	1		0	\N	\N
1342	182	1867	2	kleinen	0	\N	\N
1344	45	173	1	\N	0	\N	\N
1345	45	185	2	\N	0	\N	\N
1346	95	2022	1		0	\N	\N
1347	96	2023	1		0	\N	\N
1348	668	2017	0		0	\N	\N
1349	669	2024	1		0	\N	\N
1350	86	2025	1		0	\N	\N
1351	361	1866	1		0	\N	\N
1352	361	1865	2		0	\N	\N
1353	670	2026	1		0	\N	\N
1355	140	2027	1		0	\N	\N
1356	140	2028	2		0	\N	\N
1359	472	1665	1	\N	0	\N	\N
1360	472	256	2	\N	0	\N	\N
1361	472	284	3	\N	0	\N	\N
1363	406	1600	1	\N	0	\N	\N
1364	406	1610	2	\N	0	\N	\N
1365	671	2029	1		0	\N	\N
1368	98	1344	2	\N	0	\N	\N
1369	98	1630	0	\N	0	\N	\N
1370	98	680	0	\N	0	\N	\N
1371	672	735	1	\N	0	\N	\N
1372	289	1838	1	was	0	\N	\N
1373	674	143	0	\N	0	\N	\N
1374	674	1475	0	\N	0	\N	\N
1375	675	143	0	\N	0	\N	\N
1376	675	1475	0	\N	0	\N	\N
1377	673	735	1	verkauft	0	\N	\N
1378	676	2030	1		0	\N	\N
1379	677	2031	1		0	\N	\N
1380	294	2032	1		0	\N	\N
1381	114	1745	1	\N	0	\N	\N
1382	114	1842	2		0	\N	\N
1385	25	588	1	\N	0	\N	\N
1386	25	187	2	\N	0	\N	\N
1387	25	1313	3	\N	0	\N	\N
1395	679	1664	1	\N	0	\N	\N
1396	679	1624	2	\N	0	\N	\N
1397	679	1418	3	\N	0	\N	\N
1399	434	1107	1	\N	0	\N	\N
1400	434	1521	2	\N	0	\N	\N
1401	434	1188	3	\N	0	\N	\N
1402	680	1073	0	\N	0	\N	\N
1403	287	1554	0	\N	0	\N	\N
1404	681	373	0	\N	0	\N	\N
1407	682	1139	1	\N	0	\N	\N
1408	682	1253	2	\N	0	\N	\N
1411	473	264	1	\N	0	\N	\N
1412	473	267	2	\N	0	\N	\N
1413	473	1491	3	\N	0	\N	\N
1415	127	75	1	\N	0	\N	\N
1416	127	100	2	\N	0	\N	\N
1418	128	472	1	\N	0	\N	\N
1419	128	894	2	\N	0	\N	\N
1420	527	1322	0	\N	0	\N	\N
1421	683	2033	1		0	\N	\N
1425	319	94	0	\N	0	\N	\N
1426	688	94	1	kann	0	\N	\N
1427	323	94	1	mal	0	\N	\N
1433	686	1499	1	\N	0	\N	\N
1434	686	1501	2	\N	0	\N	\N
1435	689	1499	1	das	0	\N	\N
1436	689	1501	2	\N	0	\N	\N
1437	691	1499	1	geht	0	\N	\N
1438	691	1501	2	\N	0	\N	\N
1439	687	277	1	toll	0	\N	\N
1440	690	277	1	toll	0	\N	\N
1446	255	30	1	\N	0	\N	\N
1447	255	97	2	\N	0	\N	\N
1448	217	1989	0	\N	0	\N	\N
1450	446	1033	1	\N	0	\N	\N
1451	446	348	2	\N	0	\N	\N
1452	261	526	1	Riesenportion	0	\N	\N
1453	261	2034	2		0	\N	\N
1456	414	1198	1	\N	0	\N	\N
1457	414	109	2	\N	0	\N	\N
1458	414	140	3	\N	0	\N	\N
1459	132	1197	1	\N	0	\N	\N
1460	132	2035	2		0	\N	\N
1462	400	193	1	\N	0	\N	\N
1463	400	1606	2	\N	0	\N	\N
1465	692	392	1	groß	0	\N	\N
1468	694	158	1	\N	0	\N	\N
1469	694	1364	2	\N	0	\N	\N
1470	693	482	0	\N	0	\N	\N
1471	451	1086	0	\N	0	\N	\N
1472	695	158	1	was	0	\N	\N
1473	695	1364	2	da	0	\N	\N
1474	696	1086	1	Fleiß	0	\N	\N
1475	696	145	2	Wald	0	\N	\N
1478	697	620	0	\N	0	\N	\N
1479	478	254	1	\N	0	\N	\N
1480	478	363	2	\N	0	\N	\N
1481	698	1263	0	\N	0	\N	\N
1482	700	208	1	\N	0	\N	\N
1483	699	2036	1		0	\N	\N
1488	154	2037	1		0	\N	\N
1489	154	324	2	\N	0	\N	\N
1490	154	351	3	\N	0	\N	\N
1492	226	1292	1	\N	0	\N	\N
1493	226	1874	2	\N	0	\N	\N
1495	129	758	1	\N	0	\N	\N
1496	129	1667	2	\N	0	\N	\N
1498	90	89	1	China	0	\N	\N
1499	90	1891	2	\N	0	\N	\N
1500	302	2011	1		0	\N	\N
1501	302	2038	2		0	\N	\N
1502	702	2039	1		0	\N	\N
1505	130	329	2	\N	0	\N	\N
1506	130	91	0	\N	0	\N	\N
1507	284	2040	1		0	\N	\N
1508	684	2041	1		0	\N	\N
1509	299	2015	1		0	\N	\N
1510	299	2042	2		0	\N	\N
1511	704	487	0	\N	0	\N	\N
1512	703	2043	1		0	\N	\N
1513	336	2043	0	\N	0	\N	\N
1514	321	2044	1		0	\N	\N
1515	333	2045	1		0	\N	\N
1516	354	1635	0	\N	0	\N	\N
1517	34	2046	1		0	\N	\N
1518	352	304	1	\N	0	\N	\N
1519	352	1225	2	\N	0	\N	\N
1520	306	112	1	\N	0	\N	\N
1521	306	113	2	\N	0	\N	\N
1522	100	89	1	gemerkt	0	\N	\N
1524	168	2047	1		0	\N	\N
1525	168	2048	2		0	\N	\N
1526	169	2047	1	Verständigen	0	\N	\N
1527	169	2048	2	Abteilungen	0	\N	\N
1528	705	2049	1		0	\N	\N
1531	338	1731	1	\N	0	\N	\N
1532	338	1903	2	\N	0	\N	\N
1533	11	1445	1	\N	0	\N	\N
1534	11	2050	2		0	\N	\N
1535	707	2051	1		0	\N	\N
1537	162	1293	1	\N	0	\N	\N
1538	162	1874	2	\N	0	\N	\N
1541	183	1627	1	\N	0	\N	\N
1542	183	1123	2	\N	0	\N	\N
1543	183	316	3	\N	0	\N	\N
1546	44	262	1	\N	0	\N	\N
1547	44	372	2	\N	0	\N	\N
1550	709	1110	1	\N	0	\N	\N
1551	709	1353	2	\N	0	\N	\N
1553	708	2052	1		0	\N	\N
1554	243	798	0	\N	0	\N	\N
1555	376	798	2	wie	0	\N	\N
1559	710	345	1	\N	0	\N	\N
1560	710	583	2	\N	0	\N	\N
1561	710	937	3	\N	0	\N	\N
1563	432	478	1	\N	0	\N	\N
1564	432	1499	2	\N	0	\N	\N
1568	533	126	1	mir	0	\N	\N
1569	533	606	2	\N	0	\N	\N
1570	533	165	3	\N	0	\N	\N
1571	533	1651	4	\N	0	\N	\N
1572	424	606	1	Kunsthalle	0	\N	\N
1573	424	165	2	warst	0	\N	\N
1574	424	1651	3	da	0	\N	\N
1576	136	85	1	\N	0	\N	\N
1577	136	575	2	\N	0	\N	\N
1578	711	1223	0	\N	0	\N	\N
1580	318	196	1	\N	0	\N	\N
1581	318	610	2	\N	0	\N	\N
1582	324	610	2	lieber	0	\N	\N
1583	290	1155	0	\N	0	\N	\N
1584	290	373	0	\N	0	\N	\N
1585	713	315	0	\N	0	\N	\N
1587	290	1125	0	\N	0	\N	\N
1588	714	1248	0	\N	0	\N	\N
1590	712	600	1	\N	0	\N	\N
1591	712	824	2	\N	0	\N	\N
1592	715	119	0	\N	0	\N	\N
1593	715	327	0	\N	0	\N	\N
1596	716	1780	1	\N	0	\N	\N
1597	716	1891	2	\N	0	\N	\N
1598	717	1952	0	\N	0	\N	\N
1599	433	1981	0	\N	0	\N	\N
1601	307	2053	2		0	\N	\N
1602	485	2054	1		0	\N	\N
1603	408	278	0	\N	0	\N	\N
1605	402	174	1	\N	0	\N	\N
1606	402	1546	2	\N	0	\N	\N
1609	439	184	1	\N	0	\N	\N
1610	439	1181	2	\N	0	\N	\N
1611	439	1229	3	\N	0	\N	\N
1613	718	128	0	\N	0	\N	\N
1614	718	153	0	\N	0	\N	\N
1615	719	293	0	\N	0	\N	\N
1621	720	372	1	\N	0	\N	\N
1622	720	1337	2	\N	0	\N	\N
1633	466	2055	1		0	\N	\N
1634	466	1074	2	\N	0	\N	\N
1635	466	45	3	\N	0	\N	\N
1636	466	2056	4		0	\N	\N
1637	722	2057	1		0	\N	\N
1638	93	274	1	Ausflüge	0	\N	\N
1639	721	215	1	sie	0	\N	\N
1641	93	215	2	sie	0	\N	\N
1644	78	274	1	wiederzusehen	0	\N	\N
1645	78	215	2	aufgeregt	0	\N	\N
1646	78	2058	3		0	\N	\N
1647	93	2058	3		0	\N	\N
1648	148	1353	1	\N	0	\N	\N
1649	148	2059	2		0	\N	\N
1650	197	884	0	\N	0	\N	\N
1651	723	2060	1		0	\N	\N
1662	259	1512	1	\N	0	\N	\N
1663	259	521	2	jetzt	0	\N	\N
1664	259	88	3	\N	0	\N	\N
1665	259	394	4	\N	0	\N	\N
1666	260	1512	1	mit	0	\N	\N
1667	260	521	2	feiert	0	\N	\N
1668	260	88	3	schaffe	0	\N	\N
1669	260	394	4	das	0	\N	\N
1670	293	313	0	\N	0	\N	\N
1675	253	189	1	was	0	\N	\N
1676	253	966	2	müde	0	\N	\N
1681	251	2061	1		0	\N	\N
1682	251	1080	2	\N	0	\N	\N
1683	251	363	3	\N	0	\N	\N
1685	252	189	1	wirklich	0	\N	\N
1686	252	966	2	so	0	\N	\N
1687	252	367	3	\N	0	\N	\N
1688	253	367	3	sollte	0	\N	\N
1697	726	652	0	\N	0	\N	\N
1699	510	1668	1	\N	0	\N	\N
1700	510	893	2	\N	0	\N	\N
1702	724	174	1	\N	0	\N	\N
1703	724	651	2	\N	0	\N	\N
1706	725	329	1	\N	0	\N	\N
1707	725	915	2	\N	0	\N	\N
1708	725	341	3	\N	0	\N	\N
1710	303	2062	1		0	\N	\N
1711	303	2063	2		0	\N	\N
1712	465	1073	0	\N	0	\N	\N
1713	258	602	0	\N	0	\N	\N
1720	727	1821	1	\N	0	\N	\N
1721	727	1270	2	\N	0	\N	\N
1723	728	1219	1	\N	0	\N	\N
1724	728	1256	2	\N	0	\N	\N
1725	728	825	3	\N	0	\N	\N
1726	64	1248	0	\N	0	\N	\N
1728	415	2064	1		0	\N	\N
1729	415	1375	2	\N	0	\N	\N
1731	250	81	1	\N	0	\N	\N
1732	250	157	2	\N	0	\N	\N
1734	109	14	1	\N	0	\N	\N
1735	109	1591	2	\N	0	\N	\N
1736	729	374	0	\N	0	\N	\N
1737	407	1209	1	\N	0	\N	\N
1738	407	2065	2		0	\N	\N
1742	241	1376	1	\N	0	\N	\N
1744	730	1968	0	\N	0	\N	\N
1745	241	2044	0	\N	0	\N	\N
1747	51	197	1	\N	0	\N	\N
1748	51	1533	2	\N	0	\N	\N
1754	438	2066	1		0	\N	\N
1755	528	1630	1	\N	0	\N	\N
1756	528	257	2	Film	0	\N	\N
1757	528	349	3	\N	0	\N	\N
1760	442	1630	1	Kultur	0	\N	\N
1761	442	257	2	\N	0	\N	\N
1762	442	349	3	nett	0	\N	\N
1763	529	2066	0	\N	0	\N	\N
1766	53	232	1	\N	0	\N	\N
1767	53	335	2	\N	0	\N	\N
1769	91	83	1	\N	0	\N	\N
1770	91	852	2	\N	0	\N	\N
1773	170	80	1	\N	0	\N	\N
1774	170	1142	2	\N	0	\N	\N
1775	170	1111	3	\N	0	\N	\N
1777	87	1869	1		0	\N	\N
1778	87	2005	2	\N	0	\N	\N
1780	491	1800	1		0	\N	\N
1781	491	936	2	\N	0	\N	\N
1782	495	936	2	nach	0	\N	\N
1783	731	1294	0	\N	0	\N	\N
1784	731	1382	0	\N	0	\N	\N
1785	187	214	0	\N	0	\N	\N
1786	187	308	0	\N	0	\N	\N
1787	626	2067	1		0	\N	\N
1788	586	659	0	\N	0	\N	\N
1789	26	659	1	\N	0	\N	\N
1794	304	115	1	\N	0	\N	\N
1795	304	116	2	\N	0	\N	\N
1796	304	191	3	\N	0	\N	\N
1798	392	758	1	\N	0	\N	\N
1799	392	2068	2		0	\N	\N
1800	464	65	0	\N	0	\N	\N
1801	133	472	1	\N	0	\N	\N
1802	133	923	2	\N	0	\N	\N
1803	133	78	3	\N	0	\N	\N
1805	33	114	1	\N	0	\N	\N
1806	33	2050	2	\N	0	\N	\N
1808	200	621	1	\N	0	\N	\N
1809	200	255	2	\N	0	\N	\N
1810	200	376	3	\N	0	\N	\N
1811	300	2069	1		0	\N	\N
1812	732	2070	1		0	\N	\N
1813	76	2071	1		0	\N	\N
1814	246	1749	1	übrigens	0	\N	\N
1815	554	2072	1		0	\N	\N
1816	579	2073	1		0	\N	\N
1817	608	2074	1		0	\N	\N
1818	460	2075	1		0	\N	\N
1819	635	2076	1		0	\N	\N
1820	104	2077	1		0	\N	\N
1821	637	2078	1		0	\N	\N
1822	271	2078	1	etwa	0	\N	\N
1823	188	1871	1		0	\N	\N
1824	188	2079	2		0	\N	\N
1825	167	2080	1		0	\N	\N
1826	167	650	2	\N	0	\N	\N
1827	167	2012	3		0	\N	\N
1828	685	2081	1		0	\N	\N
1829	396	2082	1		0	\N	\N
1830	285	2083	1		0	\N	\N
1831	706	2084	1		0	\N	\N
1832	270	2085	1		0	\N	\N
1833	377	2086	1		0	\N	\N
1834	52	2087	1		0	\N	\N
1835	642	2087	1	unserem	0	\N	\N
1836	435	215	0	\N	0	\N	\N
1840	79	1849	1	\N	0	\N	\N
1841	79	353	2	\N	0	\N	\N
1842	79	1827	3		0	\N	\N
1843	262	2088	1		0	\N	\N
1844	262	1617	2	fahr'  fahre	0	\N	\N
1845	522	2089	1		0	\N	\N
1846	522	1501	2	\N	0	\N	\N
1847	522	889	3	\N	0	\N	\N
1848	733	1699	1		0	\N	\N
1849	39	2090	1		0	\N	\N
1850	39	1700	2	bogenはbiegenの過去複数形	0	\N	\N
1852	248	182	1	bitte	0	\N	\N
1853	248	69	2	\N	0	\N	\N
1854	248	457	3	\N	0	\N	\N
1858	118	2091	1		0	\N	\N
1859	118	1294	2	im	0	\N	\N
1861	229	1796	1		0	\N	\N
1862	229	2021	2	\N	0	\N	\N
1864	27	1632	1	\N	0	\N	\N
1865	27	1361	2	\N	0	\N	\N
1866	27	2067	3	\N	0	\N	\N
1867	734	2067	1	\N	0	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: de
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
554	18
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
613	23
637	22
696	35
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
254		\N	\N	\N
487	sagen	\N	\N	\N
798	Bett	1	B	\N
1	hallo	\N	\N	\N
2	lange	\N	\N	\N
3	sehen	\N	\N	\N
4	na	\N	\N	\N
5	wie geht es	\N	\N	\N
6	mir geht es	\N	\N	\N
7	auch	\N	\N	\N
8	was	\N	\N	\N
9	machen	\N	\N	\N
10	jetzt	\N	\N	\N
11	fahren	\N	\N	\N
12	zu	\N	\N	\N
13	mein	\N	\N	\N
14	Eltern	\N	\N	\N
15	Vater	\N	\N	\N
16	heute	\N	\N	\N
17	Geburtstag	\N	\N	\N
18	dann	\N	\N	\N
19	feiern	\N	\N	\N
20	zusammen	\N	\N	\N
21	schön	\N	\N	\N
22	grüßen	\N	\N	\N
23	dein	\N	\N	\N
24	von	\N	\N	\N
25	mir	\N	\N	\N
26	das	\N	\N	\N
27	Bus	\N	\N	\N
28	kommen	\N	\N	\N
29	schon	\N	\N	\N
30	wünschen	\N	\N	\N
31	dir	\N	\N	\N
32	noch	\N	\N	\N
33	Abend	\N	\N	\N
34	tschüs	\N	\N	\N
35	gleichfalls	\N	\N	\N
36	Entschuldigung	\N	\N	\N
37	meinen	\N	\N	\N
38	mich	\N	\N	\N
39	glauben	\N	\N	\N
40	Ihr	\N	\N	\N
41	Portemonnaie	\N	\N	\N
42	vergessen	\N	\N	\N
43	Ihrer	\N	\N	\N
44	meiner	\N	\N	\N
45	aber	\N	\N	\N
46	sehr	\N	\N	\N
47	nett	\N	\N	\N
48	Ihnen	\N	\N	\N
49	vielen Dank	\N	\N	\N
50	bitte schön	\N	\N	\N
51	nichts zu danken	\N	\N	\N
52	wo	\N	\N	\N
53	es	\N	\N	\N
54	denn	\N	\N	\N
55	finden	\N	\N	\N
56	gar	\N	\N	\N
57	nichts	\N	\N	\N
58	merken	\N	\N	\N
59	in	\N	\N	\N
60	Telefonzelle	\N	\N	\N
61	direkt	\N	\N	\N
62	vor	\N	\N	\N
63	dran sein	\N	\N	\N
64	ach	\N	\N	\N
65	Gott sei Dank	\N	\N	\N
66	da	\N	\N	\N
67	froh	\N	\N	\N
68	nochmals	\N	\N	\N
69	sein	\N	\N	\N
70	Wetter	\N	\N	\N
71	wirklch	\N	\N	\N
72	richtig	\N	\N	\N
73	warm	\N	\N	\N
74	schauen	\N	\N	\N
75	mal	\N	\N	\N
76	Abendrot	\N	\N	\N
77	echt	\N	\N	\N
78	phantastisch	\N	\N	\N
79	wie	\N	\N	\N
80	in + dem	\N	\N	\N
81	Film	\N	\N	\N
82	stimmen	\N	\N	\N
83	hören	\N	\N	\N
84	jemand	\N	\N	\N
85	Musik	\N	\N	\N
86	doch	\N	\N	\N
87	spielen	\N	\N	\N
88	Gitarre	\N	\N	\N
89	hingehen	\N	\N	\N
90	gut	\N	\N	\N
91	Idee	\N	\N	\N
92	hier	\N	\N	\N
93	frei	\N	\N	\N
94	bitte	\N	\N	\N
95	stattfinden	\N	\N	\N
96	Vorlesung	\N	\N	\N
97	Professor	\N	\N	\N
98	oder	\N	\N	\N
99	kennen	\N	\N	\N
100	dich	\N	\N	\N
101	studieren	\N	\N	\N
102	Jura	\N	\N	\N
103	Politik	\N	\N	\N
104	sich für ~ interessieren	\N	\N	\N
105	französisch	\N	\N	\N
106	Recht	\N	\N	\N
107	übrigens	\N	\N	\N
108	heißen	\N	\N	\N
109	Silke	\N	\N	\N
110	Klaus	\N	\N	\N
111	dass	\N	\N	\N
112	auf	\N	\N	\N
113	Französisch	\N	\N	\N
114	ja	\N	\N	\N
115	aus	\N	\N	\N
116	Frankreich	\N	\N	\N
117	können	\N	\N	\N
118	als	\N	\N	\N
119	Kind	\N	\N	\N
120	leben	\N	\N	\N
121	warten	\N	\N	\N
122	na ja	\N	\N	\N
123	es geht	\N	\N	\N
124	ungefähr	\N	\N	\N
125	Viertelstunde	\N	\N	\N
126	das tut mir Leid	\N	\N	\N
127	wirklich	\N	\N	\N
128	Zug	\N	\N	\N
129	haben	\N	\N	\N
130	Minute	\N	\N	\N
131	Verspätung	\N	\N	\N
132	man	\N	\N	\N
133	Buch	\N	\N	\N
134	mitbringen	\N	\N	\N
135	mein Gott	\N	\N	\N
136	ganz	\N	\N	\N
137	peinlich	\N	\N	\N
138	morgen	\N	\N	\N
139	in Ordnung sein	\N	\N	\N
140	trinken	\N	\N	\N
141	erst mal	\N	\N	\N
142	Kaffee	\N	\N	\N
143	viel	\N	\N	\N
144	lesen	\N	\N	\N
145	gern	\N	\N	\N
146	der	\N	\N	\N
147	Roman	\N	\N	\N
148	wollen	\N	\N	\N
149	gefallen	\N	\N	\N
150	spannend	\N	\N	\N
151	wenn	\N	\N	\N
152	mitnehmen	\N	\N	\N
153	ihn	\N	\N	\N
154	einfach	\N	\N	\N
155	schenken	\N	\N	\N
156	zweimal	\N	\N	\N
157	brauchen	\N	\N	\N
158	mehr	\N	\N	\N
159	lieb	\N	\N	\N
160	danke	\N	\N	\N
161	hoffen	\N	\N	\N
162	eigentlich	\N	\N	\N
163	immer	\N	\N	\N
164	mit	\N	\N	\N
165	normalerweise	\N	\N	\N
166	Straßenbahn	\N	\N	\N
167	wohin	\N	\N	\N
168	ins = in das	\N	\N	\N
169	Zentrum	\N	\N	\N
170	treffen	\N	\N	\N
171	ein paar	\N	\N	\N
172	Freund	\N	\N	\N
173	müssen	\N	\N	\N
174	zur = zu der	\N	\N	\N
175	Arbeit	\N	\N	\N
176	arm	\N	\N	\N
177	nur	\N	\N	\N
178	vier	\N	\N	\N
179	Stunde	\N	\N	\N
180	arbeiten	\N	\N	\N
181	gehen	\N	\N	\N
182	müsen	\N	\N	\N
183	aussteigen	\N	\N	\N
184	viel Spaß	\N	\N	\N
185	Wochenende	\N	\N	\N
186	guten Tag	\N	\N	\N
187	helfen	\N	\N	\N
188	suchen	\N	\N	\N
189	etwas	\N	\N	\N
190	für	\N	\N	\N
191	sechsjährig	\N	\N	\N
192	Kleid	\N	\N	\N
193	so was	\N	\N	\N
194	Baumwolle	\N	\N	\N
195	am besten	\N	\N	\N
196	welcher	\N	\N	\N
197	Preislage	\N	\N	\N
198	sollen	\N	\N	\N
199	Euro	\N	\N	\N
200	dieser	\N	\N	\N
201	niedlich	\N	\N	\N
202	kosten	\N	\N	\N
203	nehmen	\N	\N	\N
204	mitkommen	\N	\N	\N
205	Kasse	\N	\N	\N
206	so	\N	\N	\N
207	interssiert	\N	\N	\N
208	seit	\N	\N	\N
209	wann	\N	\N	\N
210	bemerken	\N	\N	\N
211	Reiseführer	\N	\N	\N
212	interessant	\N	\N	\N
213	verreisen	\N	\N	\N
214	im = in dem	\N	\N	\N
215	Sommer	\N	\N	\N
216	nach	\N	\N	\N
217	China	\N	\N	\N
218	sich für ～ interessieren	\N	\N	\N
219	chinesisch	\N	\N	\N
220	Geschichte	\N	\N	\N
221	Kultur	\N	\N	\N
222	Asien	\N	\N	\N
223	Urlaub	\N	\N	\N
224	letzt	\N	\N	\N
225	Jahr	\N	\N	\N
226	Thailand	\N	\N	\N
227	toll	\N	\N	\N
228	Prüfung	\N	\N	\N
229	endlich	\N	\N	\N
230	vorbei	\N	\N	\N
231	sich freuen	\N	\N	\N
232	total	\N	\N	\N
233	Sommerferien	\N	\N	\N
234	nächst	\N	\N	\N
235	Woche	\N	\N	\N
236	Freitag	\N	\N	\N
237	in Urlaub fahren	\N	\N	\N
238	zwei	\N	\N	\N
239	wem	\N	\N	\N
240	Türkei	\N	\N	\N
241	vorhaben	\N	\N	\N
242	Freundin	\N	\N	\N
243	die Staaten	\N	\N	\N
244	Besuch	\N	\N	\N
245	aufgeregt	\N	\N	\N
246	sie	\N	\N	\N
247	wiedersehen	\N	\N	\N
248	Menge	\N	\N	\N
249	Ausflug	\N	\N	\N
250	und so	\N	\N	\N
251	planen	\N	\N	\N
252	am = an dem	\N	\N	\N
253	Samstag	\N	\N	\N
255	Café	\N	\N	\N
256	Kowalski	\N	\N	\N
257	dahin	\N	\N	\N
258	hat es	\N	\N	\N
259	gemütlich	\N	\N	\N
260	wie oft	\N	\N	\N
261	vielleicht	\N	\N	\N
262	einmal	\N	\N	\N
263	pro	\N	\N	\N
264	oft	\N	\N	\N
265	die	\N	\N	\N
266	Happy-hour-Menü	\N	\N	\N
267	unter der Woche	\N	\N	\N
268	bekommen	\N	\N	\N
269	zwischen	\N	\N	\N
270	Riesenportion	\N	\N	\N
271	Portion	\N	\N	\N
272	Wiener Schnitzel	\N	\N	\N
273	was heißt ...	\N	\N	\N
274	groß	\N	\N	\N
275	Teller	\N	\N	\N
276	sogar	\N	\N	\N
277	davon	\N	\N	\N
278	probieren	\N	\N	\N
279	Zeit	\N	\N	\N
280	heute Abend	\N	\N	\N
281	anfangen	\N	\N	\N
282	Seminar	\N	\N	\N
283	um	\N	\N	\N
284	Viertel	\N	\N	\N
285	es eilig haben	\N	\N	\N
286	nee	\N	\N	\N
287	gar nicht	\N	\N	\N
288	kein	\N	\N	\N
289	Veranstaltung	\N	\N	\N
290	erst	\N	\N	\N
291	etwa	\N	\N	\N
292	ein	\N	\N	\N
293	gerne	\N	\N	\N
294	ins =   in das	\N	\N	\N
295	bleiben	\N	\N	\N
296	Uni	\N	\N	\N
297	bis zu dem	\N	\N	\N
298	Stadt-Café	\N	\N	\N
299	bestimmt	\N	\N	\N
300	Vietelstunde	\N	\N	\N
301	sich setzen	\N	\N	\N
302	draußen	\N	\N	\N
303	Rasen	\N	\N	\N
304	Frage	\N	\N	\N
305	wie viele	\N	\N	\N
306	dürfen	\N	\N	\N
307	ausleihen	\N	\N	\N
308	Bibliotheksausweis	\N	\N	\N
309	Wie lange	\N	\N	\N
310	behalten	\N	\N	\N
311	Monat	\N	\N	\N
312	also	\N	\N	\N
313	Januar	\N	\N	\N
314	was für (ein) ...	\N	\N	\N
315	Stäbchen	\N	\N	\N
316	Essstäbchen	\N	\N	\N
317	warum	\N	\N	\N
318	japanisch	\N	\N	\N
319	kurz	\N	\N	\N
320	essen	\N	\N	\N
321	halten	\N	\N	\N
322	Kuli	\N	\N	\N
323	Ringfinger	\N	\N	\N
324	stützen	\N	\N	\N
325	unter	\N	\N	\N
326	womit	\N	\N	\N
327	Tofu	\N	\N	\N
328	damit	\N	\N	\N
329	klar	\N	\N	\N
330	versuchen	\N	\N	\N
331	ein(e)	\N	\N	\N
332	Gabel	\N	\N	\N
333	ein bisschen	\N	\N	\N
334	Chinesisch	\N	\N	\N
335	kaum	\N	\N	\N
336	nie	\N	\N	\N
337	lernen	\N	\N	\N
338	benutzen	\N	\N	\N
339	Schriftzeichen	\N	\N	\N
340	wobei	\N	\N	\N
341	Tee	\N	\N	\N
342	schmecken	\N	\N	\N
343	super	\N	\N	\N
344	möchte	\N	\N	\N
345	wissen	\N	\N	\N
346	drin (=darin)	\N	\N	\N
347	Zutat	\N	\N	\N
348	kann es	\N	\N	\N
349	nur wenn	\N	\N	\N
350	es gibt ... （４格）	\N	\N	\N
351	Kopierer	\N	\N	\N
352	Kopierraum	\N	\N	\N
353	Stock	\N	\N	\N
354	hochgehen	\N	\N	\N
355	Treppe	\N	\N	\N
356	geradeaus	\N	\N	\N
357	recht	\N	\N	\N
358	Seite	\N	\N	\N
359	Kopierkarte	\N	\N	\N
360	kaufen	\N	\N	\N
361	Gebäude	\N	\N	\N
362	neben	\N	\N	\N
363	Haupteingang	\N	\N	\N
364	Kopierecke	\N	\N	\N
365	dort	\N	\N	\N
366	Kartenautomat	\N	\N	\N
367	gern geschehen	\N	\N	\N
368	schon mal	\N	\N	\N
369	Einführung	\N	\N	\N
370	Kunstgeschichte	\N	\N	\N
371	genau	\N	\N	\N
372	überlegen	\N	\N	\N
373	ob	\N	\N	\N
374	sprechen	\N	\N	\N
375	zwar	\N	\N	\N
376	ziemlich	\N	\N	\N
377	schnell	\N	\N	\N
378	nein	\N	\N	\N
379	Exkursion	\N	\N	\N
380	Museum	\N	\N	\N
381	sich anhören	\N	\N	\N
382	schlecht	\N	\N	\N
383	werden	\N	\N	\N
384	wohl	\N	\N	\N
385	besuchen	\N	\N	\N
386	jeder	\N	\N	\N
387	Semester	\N	\N	\N
388	ich es	\N	\N	\N
389	wer	\N	\N	\N
390	bloß	\N	\N	\N
391	Mitbewohnerin	\N	\N	\N
392	tja	\N	\N	\N
393	schwer	\N	\N	\N
394	irgendwie	\N	\N	\N
395	alle	\N	\N	\N
396	locker	\N	\N	\N
397	sich einleben	\N	\N	\N
398	WG	\N	\N	\N
399	Spaß haben	\N	\N	\N
400	allerdings	\N	\N	\N
401	sich3 vorstellen	\N	\N	\N
402	witzig	\N	\N	\N
403	früh	\N	\N	\N
404	aufstehen	\N	\N	\N
405	Italienerin	\N	\N	\N
406	erstaunlich	\N	\N	\N
407	natürlich	\N	\N	\N
408	einziehen	\N	\N	\N
409	bald	\N	\N	\N
410	sich entscheiden	\N	\N	\N
411	drüber = darüber	\N	\N	\N
412	mögen	\N	\N	\N
413	Milchkaffee	\N	\N	\N
414	schwarzer Tee	\N	\N	\N
415	Kamillentee	\N	\N	\N
416	erkältet	\N	\N	\N
417	aussehen	\N	\N	\N
418	gestern	\N	\N	\N
419	～3 weh tun	\N	\N	\N
420	nämlich	\N	\N	\N
421	Hals	\N	\N	\N
422	Arme[r]	\N	\N	\N
423	hoffentlich	\N	\N	\N
424	weggehen	\N	\N	\N
425	wieder	\N	\N	\N
426	Apfelkuchen	\N	\N	\N
427	Hunger	\N	\N	\N
428	Stück	\N	\N	\N
429	Sport	\N	\N	\N
430	Aerobic	\N	\N	\N
431	schwimmen	\N	\N	\N
432	fragen	\N	\N	\N
433	mittwochs	\N	\N	\N
434	Volleyball	\N	\N	\N
435	Sportzentrum	\N	\N	\N
436	Lust	\N	\N	\N
437	mitmachen	\N	\N	\N
438	Profi	\N	\N	\N
439	ander	\N	\N	\N
440	Sportart	\N	\N	\N
441	Ballsport	\N	\N	\N
442	nichts machen	\N	\N	\N
443	Ski fahren	\N	\N	\N
444	スノーボード	\N	\N	\N
445	Winter	\N	\N	\N
446	St. Anton	\N	\N	\N
447	Onkel	\N	\N	\N
448	den	\N	\N	\N
449	vergrößern	\N	\N	\N
450	auflegen	\N	\N	\N
451	Blatt	\N	\N	\N
452	DIN	\N	\N	\N
453	reichen	\N	\N	\N
454	einstellen	\N	\N	\N
455	Größe	\N	\N	\N
456	Moment	\N	\N	\N
457	drücken	\N	\N	\N
458	beim = bei dem	\N	\N	\N
459	normal	\N	\N	\N
460	kopieren	\N	\N	\N
461	Schröder	\N	\N	\N
462	Uli	\N	\N	\N
463	Martina	\N	\N	\N
464	oh	\N	\N	\N
465	uns	\N	\N	\N
466	bei	\N	\N	\N
467	Claudia	\N	\N	\N
468	vorkommen	\N	\N	\N
469	eine	\N	\N	\N
470	Ewigkeit	\N	\N	\N
471	Magisterarbeit	\N	\N	\N
472	und	\N	\N	\N
473	nicht	\N	\N	\N
474	besonders	\N	\N	\N
475	es gibt	\N	\N	\N
476	Neue	\N	\N	\N
477	Wald	\N	\N	\N
478	Wildschwein	\N	\N	\N
479	gucken	\N	\N	\N
480	nach... aussehen	\N	\N	\N
481	Regen	\N	\N	\N
482	trotzdem	\N	\N	\N
483	regnen	\N	\N	\N
484	nass	\N	\N	\N
485	Mensch	\N	\N	\N
486	Katja	\N	\N	\N
488	blöd	\N	\N	\N
489	unbedingt	\N	\N	\N
490	aallein	\N	\N	\N
491	zurückkkommen	\N	\N	\N
492	kochen	\N	\N	\N
493	Elke	\N	\N	\N
494	zum Beispiel	\N	\N	\N
495	roh	\N	\N	\N
496	Fisch	\N	\N	\N
497	lieber	\N	\N	\N
498	Misosuppe	\N	\N	\N
499	am liebsten	\N	\N	\N
500	Essen	\N	\N	\N
501	reden	\N	\N	\N
502	über	\N	\N	\N
503	Sache	\N	\N	\N
504	WG(=Wohngemeinschaft)	\N	\N	\N
505	wohnen	\N	\N	\N
506	Japaner	\N	\N	\N
507	an dem	\N	\N	\N
508	klein	\N	\N	\N
509	Fete	\N	\N	\N
510	Rathaus	\N	\N	\N
511	beginnen	\N	\N	\N
512	spazieren gehen	\N	\N	\N
513	vorher	\N	\N	\N
514	was(=etwas)	\N	\N	\N
515	Riesenhunger	\N	\N	\N
516	in Ordung sein	\N	\N	\N
517	vorbeikommen	\N	\N	\N
518	gegen	\N	\N	\N
519	Mutter	\N	\N	\N
520	plötzlich	\N	\N	\N
521	krank	\N	\N	\N
522	Bruder	\N	\N	\N
523	später	\N	\N	\N
524	es geht ... (３格)　～	\N	\N	\N
525	mindestens	\N	\N	\N
526	anrufen	\N	\N	\N
527	\n\t\t\t\t\t\t\t	\N	\N	\N
528	unser	\N	\N	\N
529	Telefon	\N	\N	\N
530	kaputt	\N	\N	\N
531	ausgerechnet	\N	\N	\N
532	Zufall	\N	\N	\N
533	Handy	\N	\N	\N
534	Herr	\N	\N	\N
535	Frau	\N	\N	\N
536	es geht um ...	\N	\N	\N
537	Bitte	\N	\N	\N
538	Japan	\N	\N	\N
539	Material	\N	\N	\N
540	sammeln	\N	\N	\N
541	sich für …（４格）  bewerben	\N	\N	\N
542	Stipendium	\N	\N	\N
543	DAAD (=Deutscher Akademischer Austauschdienst)	\N	\N	\N
544	dafür	\N	\N	\N
545	Empfehlungsschreiben	\N	\N	\N
546	schreiben	\N	\N	\N
547	Problem	\N	\N	\N
548	bis	\N	\N	\N
549	Schreiben	\N	\N	\N
550	spätestens	\N	\N	\N
551	Montag	\N	\N	\N
552	oh Mann	\N	\N	\N
553	immer noch 	\N	\N	\N
554	Geschenk	\N	\N	\N
555	Schwester	\N	\N	\N
556	übermorgen	\N	\N	\N
557	einfallen	\N	\N	\N
558	lassen	\N	\N	\N
559	wie alt	\N	\N	\N
560	achtzehn	\N	\N	\N
561	irgendwas	\N	\N	\N
562	das kommt darauf an	\N	\N	\N
563	sich für … interessieren	\N	\N	\N
564	Krimi	\N	\N	\N
565	ausländisch	\N	\N	\N
566	Autor	\N	\N	\N
567	wie wäre es ... mit ~	\N	\N	\N
568	Literatur	\N	\N	\N
569	warum nicht	\N	\N	\N
570	welche	\N	\N	\N
571	Terminkalender	\N	\N	\N
572	vorne	\N	\N	\N
573	an …4 denken	\N	\N	\N
574	speziell	\N	\N	\N
575	Taschenkalender	\N	\N	\N
576	Tag	\N	\N	\N
577	fast	\N	\N	\N
578	verkaufen	\N	\N	\N
579	einer	\N	\N	\N
580	Farbe	\N	\N	\N
581	Schwarz	\N	\N	\N
582	schade	\N	\N	\N
583	kriegen	\N	\N	\N
584	neu	\N	\N	\N
585	Kalender	\N	\N	\N
586	rein	\N	\N	\N
587	naa gut	\N	\N	\N
588	eben	\N	\N	\N
589	japanisch-deutsch	\N	\N	\N
590	Wörterbuch	\N	\N	\N
591	japanisch-englisch	\N	\N	\N
592	stehen	\N	\N	\N
593	in dem	\N	\N	\N
594	Regal	\N	\N	\N
595	danken	\N	\N	\N
596	Textmarker	\N	\N	\N
597	gerade	\N	\N	\N
598	Vokabel	\N	\N	\N
599	besprechen	\N	\N	\N
600	Vokabeltest	\N	\N	\N
601	dazu	\N	\N	\N
602	einige	\N	\N	\N
603	Übung	\N	\N	\N
604	bis zu der	\N	\N	\N
605	ohne	\N	\N	\N
606	Fleiß	\N	\N	\N
607	Preis	\N	\N	\N
608	Foto	\N	\N	\N
609	fotografieren	\N	\N	\N
610	wieso	\N	\N	\N
611	verboten	\N	\N	\N
612	sicher	\N	\N	\N
613	hinten	\N	\N	\N
614	Recht haben	\N	\N	\N
615	streng	\N	\N	\N
616	es gibt ...	\N	\N	\N
617	Prospekt	\N	\N	\N
618	Ansichtskarte	\N	\N	\N
619	Bild	\N	\N	\N
620	Sitzung	\N	\N	\N
621	vorbereiten	\N	\N	\N
622	fertig	\N	\N	\N
623	Sie es	\N	\N	\N
624	sofort	\N	\N	\N
625	was (=etwas)	\N	\N	\N
626	verständigen	\N	\N	\N
627	Abteilung	\N	\N	\N
628	selbstverständlich	\N	\N	\N
629	bei dem	\N	\N	\N
630	Musikhören	\N	\N	\N
631	Kopfhörer	\N	\N	\N
632	Bibliothek	\N	\N	\N
633	leise	\N	\N	\N
634	stören	\N	\N	\N
635	aufhaben	\N	\N	\N
636	Walkman	\N	\N	\N
637	ausschalten	\N	\N	\N
638	ins Konzert gehen	\N	\N	\N
639	Kunsthalle	\N	\N	\N
640	Lageplan	\N	\N	\N
641	faxen	\N	\N	\N
642	Bahnhof	\N	\N	\N
643	abholen	\N	\N	\N
644	Internet	\N	\N	\N
645	nachgucken	\N	\N	\N
646	falls	\N	\N	\N
647	sich verlaufen	\N	\N	\N
648	Handynummer	\N	\N	\N
649	Sonntag	\N	\N	\N
650	Referat	\N	\N	\N
651	Mittwoch	\N	\N	\N
652	schaffen	\N	\N	\N
653	selber	\N	\N	\N
654	einladen	\N	\N	\N
655	euch	\N	\N	\N
656	hinkriegen	\N	\N	\N
657	副詞	\N	\N	\N
658	blass	\N	\N	\N
659	schlafen	\N	\N	\N
660	deshalb	\N	\N	\N
661	müde	\N	\N	\N
662	Fußball	\N	\N	\N
663	genug	\N	\N	\N
664	Tasse	\N	\N	\N
665	Honig	\N	\N	\N
666	Schlafen	\N	\N	\N
667	wirken	\N	\N	\N
668	leider	\N	\N	\N
669	Arzt	\N	\N	\N
670	übertrieben	\N	\N	\N
671	Liebeskummer	\N	\N	\N
672	überhaupt	\N	\N	\N
673	verschlafen	\N	\N	\N
674	nachts	\N	\N	\N
675	Notiz	\N	\N	\N
676	leihen	\N	\N	\N
677	Mal	\N	\N	\N
678	wiedergeben	\N	\N	\N
679	Schrift	\N	\N	\N
680	schwierig	\N	\N	\N
681	verstehen	\N	\N	\N
682	Studium	\N	\N	\N
683	Staatsanwältin	\N	\N	\N
684	Staatsexamen	\N	\N	\N
685	bestehen	\N	\N	\N
686	Programmierer	\N	\N	\N
687	Informatik	\N	\N	\N
688	Computer	\N	\N	\N
689	lachen	\N	\N	\N
690	vorstellen	\N	\N	\N
691	promovieren	\N	\N	\N
692	teilnehmen	\N	\N	\N
693	freuen	\N	\N	\N
694	kennen lernen	\N	\N	\N
695	Platz nehmen	\N	\N	\N
696	Interesse	\N	\N	\N
697	woran	\N	\N	\N
698	kontrastiv	\N	\N	\N
699	Studie	\N	\N	\N
700	zu dem	\N	\N	\N
701	Artikelgebrauch	\N	\N	\N
702	Deutsch	\N	\N	\N
703	wunderbar	\N	\N	\N
704	berichten	\N	\N	\N
705	gehen	1	G	\N
706	Englisch	1	E	\N
707	Flugzeug	1	F	\N
708	Ausland	1	A	\N
709	Ausländer	1	A	\N
710	Französisch	1	F	\N
711	Hotel	1	H	\N
712	Japanisch	1	J	\N
713	ausgehen	1	A	\N
714	Land	1	L	\N
715	treffen	1	T	\N
716	Ferien	1	F	\N
717	Reise	1	R	\N
718	reisen	1	R	\N
719	spielen	1	S	\N
720	Botschaft	1	B	\N
721	Lieblings...	1	L	\N
722	mögen	1	M	\N
723	gut	1	G	\N
724	rennen	1	R	\N
725	langsam	1	L	\N
726	schlecht	1	S	\N
727	laufen	1	L	\N
728	schwimmen	1	S	\N
729	schnell	1	S	\N
730	fliegen	1	F	\N
731	Sport	1	S	\N
732	hassen	1	H	\N
733	Schwimmbad	1	S	\N
734	Bus	1	B	\N
735	Fahrrad	1	F	\N
736	Kreuzung	1	K	\N
737	Straße	1	S	\N
738	Teich	1	T	\N
739	Spaziergang	1	S	\N
740	Fluss	1	F	\N
741	Taxi	1	T	\N
742	Auto	1	A	\N
743	biegen	1	B	\N
744	Krawatte	1	K	\N
745	Hemd	1	H	\N
746	Firma	1	F	\N
747	Anzug	1	A	\N
748	tun	1	T	\N
749	rauchen	1	R	\N
750	Telefon	1	T	\N
751	Arbeit	1	A	\N
752	arbeiten	1	A	\N
753	beschäftigt	1	B	\N
754	Bibliothek	1	B	\N
755	Wörterbuch	1	W	\N
756	leihen	1	L	\N
757	Zeitung	1	Z	\N
758	lesen	1	L	\N
759	Buch	1	B	\N
760	Kopie	1	K	\N
761	kopieren	1	K	\N
762	Zeitschrift	1	Z	\N
763	Exemplar	1	E	\N
764	Rindfleisch	1	R	\N
765	billig	1	B	\N
766	Laden	1	L	\N
767	hoch	1	H	\N
768	wie viel	1	W	\N
769	was	1	W	\N
770	Obst	1	O	\N
771	Gemüse	1	G	\N
772	Fisch	1	F	\N
773	Schweinefleisch	1	S	\N
774	Huhn	1	H	\N
775	Fleisch	1	F	\N
777	geben	1	G	\N
778	Gemüsehändler	1	G	\N
779	Schlüssel	1	S	\N
780	Speise	1	S	\N
781	einkaufen	1	E	\N
782	waschen	1	W	\N
783	putzen	1	P	\N
784	Familie	1	F	\N
816	neben	0	N	\N
786	Garten	1	G	\N
787	Wäsche	1	W	\N
788	Wohnung	1	W	\N
789	Haus	1	H	\N
790	Reinigung	1	R	\N
791	zurückkehren	1	Z	\N
792	Regal	1	R	\N
793	Tisch	1	T	\N
794	Stuhl	1	S	\N
795	Zimmer	1	Z	\N
796	Kühlschrank	1	K	\N
803	aufstehen	\N	A	\N
799	Radio	1	R	\N
800	Radiorekorder	1	R	\N
801	heißen	1	H	\N
802	schlafen	1	S	\N
776	mögen	\N	M	\N
805	Fernsehen	1	F	\N
806	Polizist	1	P	\N
882	Tee	\N	T	\N
808	Landkarte	1	L	\N
809	neben	1	N	\N
810	hier	1	H	\N
811	da	1	D	\N
812	dort	1	D	\N
813	wo	1	W	\N
814	Polizeiwache	1	P	\N
815	Nähe	1	N	\N
817	hören	1	H	\N
818	schneiden	1	S	\N
819	kurz	1	K	\N
820	hinter	1	H	\N
821	vor	1	V	\N
822	rechts	1	R	\N
823	links	1	L	\N
824	lang	1	L	\N
825	sich setzen	1	S	\N
807	Polizist	0	P	\N
827	Freund	1	F	\N
828	Klasse	1	K	\N
829	Klassenzimmer	1	K	\N
830	Flur	1	F	\N
831	Schule	1	S	\N
832	Schüler	1	S	\N
833	Studium	1	S	\N
834	Student	1	S	\N
835	ausländischer Student	1	A	\N
836	Sommerferien	1	S	\N
837	Lehrer	1	L	\N
838	Universität	1	U	\N
839	Heft	1	H	\N
840	Unterricht	1	U	\N
841	Aufsatz	1	A	\N
842	Hausaufgabe	1	H	\N
843	schwierig	1	S	\N
844	lehren	1	L	\N
845	Prüfung	1	P	\N
846	Übung	1	U	\N
847	leicht	1	L	\N
848	üben	1	U	\N
849	Frage	1	F	\N
850	Problem	1	P	\N
851	antworten	1	A	\N
852	weh tun	1	W	\N
853	Zahn	1	Z	\N
854	Arzt	1	A	\N
855	Krankenhaus	1	K	\N
856	Krankheit	1	K	\N
857	Medikament	1	M	\N
858	sterben	1	S	\N
859	Erkältung	1	E	\N
860	Kopf	1	K	\N
861	Bauch	1	B	\N
862	Grad	1	G	\N
863	Aufzug	1	A	\N
864	Fahrkarte	1	F	\N
865	aussteigen	1	A	\N
866	Treppe	1	T	\N
867	schließen	1	S	\N
868	Bahnhof	1	B	\N
869	U-Bahn	1	U	\N
870	einsteigen	1	E	\N
871	öffnen	1	O	\N
873	Toilette	1	T	\N
874	Zug	1	Z	\N
875	Getränk	1	G	\N
876	Kaffee	1	K	\N
877	Café	1	C	\N
878	Zitrone	1	Z	\N
879	Milch	1	M	\N
880	Zucker	1	Z	\N
881	Tasse	1	T	\N
883	Tee	1	T	\N
884	Glas	1	G	\N
886	süß	1	S	\N
887	trinken	1	T	\N
888	Stäbchen	1	S	\N
889	Alkohol	1	A	\N
890	lecker	1	L	\N
891	Messer	1	M	\N
892	Löffel	1	L	\N
893	Gabel	1	G	\N
894	Käse	1	K	\N
895	essen	1	E	\N
896	schlecht schmecken	0	S	\N
897	Brot	1	B	\N
898	scharf	1	S	\N
899	Restaurant	1	R	\N
900	Mensa	1	M	\N
901	Wein	1	W	\N
902	Essen	1	E	\N
903	Curry	1	C	\N
904	Geld	1	G	\N
905	Bank	1	B	\N
906	Eingang	1	E	\N
907	gern geschehen	1	G	\N
908	nein	1	N	\N
909	ja	1	J	\N
910	Entschuldigung	1	E	\N
911	bitte	1	B	\N
912	Ausgang	1	A	\N
913	ankommen	1	A	\N
914	Briefkasten	1	B	\N
915	Postkarte	1	P	\N
916	kleben	1	K	\N
917	Briefumschlag	1	B	\N
918	Brief	1	B	\N
919	Post	1	P	\N
920	zurückgeben	1	Z	\N
921	senden	0	S	\N
922	Briefmarke	1	B	\N
923	Paket	1	P	\N
924	Blatt	1	B	\N
926	kaufen	1	K	\N
927	Hut	1	H	\N
928	Schuh	1	S	\N
929	Einkauf	1	E	\N
930	Stock	1	S	\N
931	Kaufhaus	1	K	\N
932	Rock	1	R	\N
933	Mantel	1	M	\N
934	Hose	1	H	\N
935	Pullover	1	P	\N
936	bitte	0	B	\N
937	Tasche	1	T	\N
938	verkaufen	1	V	\N
939	Jacke	1	J	\N
940	Bad	1	B	\N
941	Gebäude	1	G	\N
942	Küche	1	K	\N
943	Dusche	1	D	\N
944	Fenster	1	F	\N
945	wohnen	1	W	\N
946	Park	1	P	\N
947	Tür	1	T	\N
948	duschen	1	D	\N
949	Apartment	1	A	\N
978	dünn	\N	D	\N
951	er	1	E	\N
952	sie	1	S	\N
953	ich	1	I	\N
954	wir	1	W	\N
955	jemand	1	J	\N
956	wer	1	W	\N
993	schlecht	0	S	\N
958	du	1	D	\N
959	Sie	1	S	\N
960	dieser	1	D	\N
961	der	1	D	\N
962	wie	1	W	\N
963	welch	1	W	\N
1058	Tasse	0	T	\N
965	solch	1	S	\N
966	selber	1	S	\N
967	so	1	S	\N
968	dick	1	D	\N
969	eng	1	E	\N
970	dünn	1	D	\N
971	groß	1	G	\N
804	Tisch	0	T	\N
973	jung	1	J	\N
974	weit	1	W	\N
872	Toilette	0	T	\N
976	fern	1	F	\N
977	schwer	1	S	\N
925	leihen	\N	L	\N
979	neu	1	N	\N
980	klein	1	K	\N
981	nah	1	N	\N
982	alt	1	A	\N
983	lustig	1	L	\N
984	gesellig	0	G	\N
985	niedrig	1	N	\N
1080	Tür	0	T	\N
987	hell	1	H	\N
988	schwach	1	S	\N
989	stark	1	S	\N
990	interessant	1	I	\N
991	schön	1	S	\N
992	spät	1	S	\N
994	viel	1	V	\N
995	dunkel	1	D	\N
996	ruhig	1	R	\N
997	wenig	1	W	\N
998	schmutzig	1	S	\N
999	langweilig	1	L	\N
1001	Mitte	1	M	\N
1002	draußen	1	D	\N
1003	Osten	1	O	\N
1004	Höhe	1	H	\N
1005	Länge	1	L	\N
1006	Norden	1	N	\N
1007	Westen	1	W	\N
1008	unter	1	U	\N
1009	Süden	1	S	\N
1010	über	1	U	\N
1011	vorn	1	V	\N
1012	hinten	1	H	\N
1013	Cousin	1	C	\N
1014	Bruder	1	B	\N
1015	Geschwister	1	G	\N
1016	Großmutter	1	G	\N
1017	Großvater	1	G	\N
1018	Frau	1	F	\N
1040	Tasche	\N	T	\N
1020	Onkel	1	O	\N
1021	Eltern	1	E	\N
1022	Vater	1	V	\N
1023	Schwester	1	S	\N
1128	Uhr	\N	U	\N
1025	Tante	1	T	\N
1030	Strumpf	1	S	\N
1019	Mutter	1	M	\N
1032	ausziehen	1	A	\N
1033	hängen	1	H	\N
1034	anziehen	0	A	\N
1035	anziehen	1	A	\N
1036	aufsetzen	1	A	\N
1037	Taschentuch	1	T	\N
1038	Pantoffel	1	P	\N
1039	Regenschirm	1	R	\N
1041	Portemonnaie	1	P	\N
1042	tragen	1	T	\N
1043	Kleidung	1	K	\N
1029	Mutter	0	M	\N
1045	Mund	1	M	\N
1046	Arm	1	A	\N
1047	Körper	1	K	\N
1048	Gesicht	1	G	\N
1049	Bein	1	B	\N
1050	Hand	1	H	\N
1051	Nase	1	N	\N
1052	Auge	1	A	\N
1053	Ohr	1	O	\N
1054	Fuß	1	F	\N
1024	Schwester	0	S	\N
1056	Teller	1	T	\N
1057	Butter	1	B	\N
1059	Bonbon	1	B	\N
1060	Mittagessen	1	M	\N
1061	Abendessen	1	A	\N
1062	Kuchen	1	K	\N
1063	Ei	1	E	\N
1064	Frühstück	1	F	\N
1065	Reis	1	R	\N
1066	Sojasoße	1	S	\N
1067	Salz	1	S	\N
1027	Schwester	0	S	\N
1070	befestigen	1	B	\N
1071	Kamera	1	K	\N
1072	Ofen	1	O	\N
1073	Bleistift	1	B	\N
1074	löschen	1	L	\N
1075	Brille	1	B	\N
1076	Kassettenrekorder	1	K	\N
1077	Uhr	1	U	\N
1078	Computer	1	C	\N
1079	Film	1	F	\N
1081	Tor	1	T	\N
1083	Füllfederhalter	1	F	\N
1084	Kugelschreiber	1	K	\N
1085	August	1	A	\N
1086	April	1	A	\N
1087	diesen Monat	1	M	\N
1088	jeden Monat	1	M	\N
1089	Dezember	1	D	\N
1090	Februar	1	F	\N
1091	Januar	1	J	\N
1092	Juli	1	J	\N
1093	Juni	1	J	\N
1094	nächsten Monat	1	M	\N
1095	Mai	1	M	\N
1096	März	1	M	\N
1097	letzten Monat	1	M	\N
1098	November	1	N	\N
1099	Oktober	1	O	\N
1100	September	1	S	\N
1101	Monat	1	M	\N
1102	diese Woche	1	W	\N
1103	jede Woche	1	W	\N
1104	Sonntag	1	S	\N
1105	Donnerstag	1	D	\N
1106	nächste Woche	1	W	\N
1107	Montag	1	M	\N
1108	Dienstag	1	D	\N
1109	Mittwoch	1	M	\N
1110	Samstag	1	S	\N
1111	Woche	1	W	\N
1112	letzte Woche	1	W	\N
1113	Freitag	1	F	\N
1114	Jahr	1	J	\N
1115	Herbst	1	H	\N
1116	dieses Jahr	1	J	\N
1117	jedes Jahr	1	J	\N
1118	Sommer	1	S	\N
1119	Winter	1	W	\N
1120	letztes Jahr	1	J	\N
1121	nächstes Jahr	1	J	\N
1122	Frühling	1	F	\N
1123	übernächstes Jahr	1	J	\N
1124	vorletztes Jahr	1	J	\N
1125	Nachmittag	1	N	\N
1126	heute	1	H	\N
1127	morgen	1	M	\N
1129	gestern	1	G	\N
1130	gestern Abend	1	G	\N
1131	Vormittag	1	V	\N
1132	Morgen	1	M	\N
1133	Mittag	1	M	\N
1134	Nacht	1	N	\N
1135	Abend	1	A	\N
1136	übermorgen	1	U	\N
1137	vorgestern	1	V	\N
1138	schon	1	S	\N
1139	während	1	W	\N
1140	noch	1	N	\N
1141	ganz	1	G	\N
1142	Zeit	1	Z	\N
1143	wann	1	W	\N
1144	manchmal	1	M	\N
1145	oft	1	O	\N
1147	gleich	1	G	\N
1148	Aschenbecher	1	A	\N
1149	Lied	1	L	\N
1150	singen	1	S	\N
1151	Zigarette	1	Z	\N
972	dick	\N	D	\N
1153	Schallplatte	1	S	\N
1154	Gitarre	1	G	\N
1055	Bauch	\N	B	\N
1156	Musik	1	M	\N
1157	Bild	1	B	\N
1158	Foto	1	F	\N
1159	gefallen	1	G	\N
1160	Stimme	1	S	\N
1161	heiter	1	H	\N
1162	heiß	1	H	\N
1163	sich aufklären	1	A	\N
1164	kühl	1	K	\N
1165	kalt	1	K	\N
1166	Schnee	1	S	\N
1167	regnen	1	R	\N
1168	Regen	1	R	\N
1169	Wetter	1	W	\N
1170	warm	1	W	\N
1171	Wind	1	W	\N
1172	wolkig	1	W	\N
950	Eingang	\N	E	\N
1174	sich bewölken	1	B	\N
1175	chinesisches Zeichen	1	C	\N
1176	sagen	1	S	\N
1177	schreiben	1	S	\N
1178	Gespräch	1	G	\N
1179	Sprache	1	S	\N
1180	Deutsch	1	D	\N
1181	Wort	1	W	\N
1182	sprechen	1	S	\N
1183	Satz	1	S	\N
1184	erzählen	1	E	\N
1185	Bedeutung	1	B	\N
1186	Hiragana	1	H	\N
1187	Katakana	1	K	\N
1188	Erwachsene	1	E	\N
1189	viele Leute	1	V	\N
1190	Ehepaar	1	E	\N
1191	Kind	1	K	\N
785	Familie	\N	F	\N
1192	Frau	\N	F	\N
1194	Junge	1	J	\N
1195	Mensch	1	M	\N
1196	Mann	1	M	\N
1197	Mädchen	1	M	\N
1200	alle	1	A	\N
1201	weiß	1	W	\N
1202	blau	1	B	\N
1203	braun	1	B	\N
1193	Frau	\N	F	\N
1205	Farbe	1	F	\N
986	gut	0	G	\N
1207	gelb	1	G	\N
1208	schwarz	1	S	\N
1209	rot	1	R	\N
1210	grün	1	G	\N
1211	praktisch	1	P	\N
1212	Party	1	P	\N
1213	Papier	1	P	\N
1214	werden	1	W	\N
1215	zumachen	1	Z	\N
1216	drücken	1	D	\N
1217	beginnen	1	B	\N
1218	eben	1	E	\N
1219	kein	1	K	\N
1220	geradeaus	1	G	\N
1221	berühmt	1	B	\N
1222	munter	1	M	\N
1223	also	1	A	\N
1224	wahrscheinlich	1	W	\N
1225	dann	1	D	\N
1226	jeden Tag	0	T	\N
885	einlegen	0	E	\N
1000	Seite	0	S	\N
1069	hinzufügen	0	E	\N
1082	Feder	0	F	\N
1068	Abendessen	0	A	\N
1031	Hemd	0	H	\N
1044	Kleidung	0	K	\N
975	leicht	0	L	\N
1155	spielen	0	S	\N
1028	Vater	0	V	\N
797	waschen	0	W	\N
1026	Bruder	\N	B	\N
1206	dunkel	\N	D	\N
1152	Film	\N	F	\N
1204	hell	\N	H	\N
1173	kalt	\N	K	\N
1198	Mann	\N	M	\N
1199	Mensch	\N	M	\N
1146	Zeit	\N	Z	\N
826	aufstehen	1	A	\N
957	wer	0	W	\N
964	welch	0	W	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: de
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
459	normalen	普通の	形容詞	\N	\N	\N	1393	\N
460	Kopieren	コピーする	動詞（名詞化）	\N	\N	\N	1393	\N
392	tja	そうだね	間投詞	\N	\N	\N	1395	\N
376	ziemlich	かなり	副詞	\N	\N	\N	1395	\N
154	einfach	簡単だ	形容詞	\N	\N	\N	1395	\N
137	peinlich	気まずい	形容詞	\N	\N	\N	1396	\N
49	Vielen Dank	ありがとう	成句	\N	\N	\N	1397	\N
51	Nichts zu danken	どういたしまして	成句	\N	\N	\N	1398	\N
461	Schröder	シュレーダー	人名（姓）	\N	\N	\N	1399	\N
1	Hallo	もしもし	間投詞	\N	\N	\N	1400	\N
462	Uli	ウリ	男性人名	\N	\N	\N	1400	\N
463	Martina	マルティーナ	女性人名	\N	\N	\N	1401	\N
464	Oh	ああ，おお	間投詞	\N	\N	\N	1402	\N
69	bist	…である	動詞	\N	\N	\N	1403	\N
2	Lange	長い間	副詞	\N	\N	\N	1404	\N
57	nichts	何も…ない	不定代名詞	\N	\N	\N	1404	\N
24	von	…から	前置詞（３格と）	\N	\N	\N	1404	\N
31	dir	君	人称代名詞（３格）	\N	\N	\N	1404	\N
83	gehört	聞く	動詞（過去分詞）	\N	\N	\N	1404	\N
5	Wie geht 's	調子はどう	成句	\N	\N	\N	1405	\N
54	denn	いったい	副詞	\N	\N	\N	1405	\N
8	Was	何	疑問代名詞	\N	\N	\N	1406	\N
198	soll	…べきである	話法の助動詞	\N	\N	\N	1406	\N
108	heißen	…という意味である	動詞	\N	\N	\N	1406	\N
465	uns	私たち	人称代名詞（４格）	\N	\N	\N	1407	\N
86	doch	…ではないか	副詞	\N	\N	\N	1407	\N
254	letzte Woche	先週	成句	\N	\N	\N	1407	\N
3	gesehen	…（４格）に会う	動詞（過去分詞）	\N	\N	\N	1407	\N
466	bei	…のところで	前置詞（３格と）	\N	\N	\N	1407	\N
467	Claudia	クラウディア	女性人名	\N	\N	\N	1407	\N
45	aber	しかし，ところが	並列接続詞	\N	\N	\N	1408	\N
25	mir	私	人称代名詞（３格）	\N	\N	\N	1408	\N
468	kommt ... vor	…（３格）には～と思える	動詞	\N	\N	\N	1408	\N
29	schon	すでに	副詞	\N	\N	\N	1408	\N
79	wie	…のように	従属接続詞	\N	\N	\N	1408	\N
469	'ne	ひとつの	不定冠詞	\N	\N	\N	1408	\N
470	Ewigkeit	非常に長い時間（永遠）	女性名詞	\N	\N	\N	1408	\N
312	Also	それでは	副詞	\N	\N	\N	1410	\N
254	wie geht 's  wie geht es	…（３格）の調子はどう	成句	\N	\N	\N	1410	\N
31	dir	君	人称代名詞（３格）	\N	\N	\N	1410	\N
122	Na ja	まあね	間投詞	\N	\N	\N	1411	\N
254	es geht	なんとかなっている	成句	\N	\N	\N	1411	\N
206	so	それで，これで	副詞	\N	\N	\N	1411	\N
13	Meine	私の	所有冠詞（女性１格）	\N	\N	\N	1412	\N
471	Magisterarbeit	修士論文	女性名詞	\N	\N	\N	1412	\N
345	weißt	知っている	動詞	\N	\N	\N	1412	\N
29	schon	もう，すでに	副詞	\N	\N	\N	1412	\N
472	Und	そして，それから	並列接続詞	\N	\N	\N	1413	\N
31	dir	君に，君にとって	人称代名詞（３格）	\N	\N	\N	1413	\N
7	Auch	…もまた	副詞	\N	\N	\N	1414	\N
473	nicht	…ない	副詞	\N	\N	\N	1414	\N
206	so	それほど	副詞	\N	\N	\N	1414	\N
474	besonders	特別に（良い）	副詞	\N	\N	\N	1414	\N
472	Und	そして	並列接続詞	\N	\N	\N	1415	\N
8	was	何が	疑問代名詞	\N	\N	\N	1415	\N
475	gibt 's  gibt es	…（４格）がある	成句	\N	\N	\N	1415	\N
476	Neues	新しいこと，ニュース	中性名詞（形容詞の名詞化）	\N	\N	\N	1415	\N
392	Tja	そうだなあ	間投詞	\N	\N	\N	1416	\N
16	heute	今日	副詞	\N	\N	\N	1417	\N
33	Abend	晩，夕方	男性名詞	\N	\N	\N	1417	\N
181	gehen	行く	動詞	\N	\N	\N	1417	\N
86	doch	…だよね（確認を表わす）	副詞	\N	\N	\N	1417	\N
59	in	…（４格）へ	前置詞（4格と）	\N	\N	\N	1417	\N
477	Wald	森	男性名詞	\N	\N	\N	1417	\N
478	Wildschweine	イノシシ	中性名詞（複数４格）	\N	\N	\N	1417	\N
479	gucken	見る	動詞	\N	\N	\N	1417	\N
98	oder	…でしょう？	並列接続詞	\N	\N	\N	1417	\N
29	schon	確かに	副詞	\N	\N	\N	1418	\N
45	aber	しかし	並列接続詞	\N	\N	\N	1418	\N
480	sieht ... nach aus	…になりそうに見える	分離動詞	\N	\N	\N	1418	\N
481	Regen	雨	男性名詞	\N	\N	\N	1418	\N
28	komm	ねえ，さあ	成句	\N	\N	\N	1419	\N
254	lass uns	…しよう	成句	\N	\N	\N	1420	\N
482	trotzdem	それにもかかわらず	副詞	\N	\N	\N	1420	\N
181	gehen	行く	動詞	\N	\N	\N	1420	\N
483	regnet	雨が降る	動詞	\N	\N	\N	1420	\N
148	will	…したい	話法の助動詞	\N	\N	\N	1421	\N
45	aber	でも	副詞	\N	\N	\N	1421	\N
473	nicht	…ない	副詞	\N	\N	\N	1421	\N
484	nass	ぬれた	形容詞	\N	\N	\N	1421	\N
383	werden	…になる	動詞	\N	\N	\N	1421	\N
485	Mensch	おい！（呼びかけ）	男性名詞	\N	\N	\N	1422	\N
486	Katja	カーチャ	女性人名	\N	\N	\N	1422	\N
129	haben		完了助動詞	\N	\N	\N	1423	\N
86	doch	だって…でしょう（確認を表わす）	副詞	\N	\N	\N	1423	\N
487	gesagt	言う	動詞（過去分詞）	\N	\N	\N	1423	\N
286	nee	いいえ	副詞	\N	\N	\N	1424	\N
488	blöd	ばかばかしい，まぬけな	形容詞	\N	\N	\N	1425	\N
151	wenn	もし…ならば	従属接続詞	\N	\N	\N	1426	\N
489	unbedingt	絶対に	副詞	\N	\N	\N	1426	\N
148	willst	…するつもしだ	話法の助動詞	\N	\N	\N	1426	\N
181	geh'  gehe	行く	動詞（命令形）	\N	\N	\N	1426	\N
490	allein	一人きりで	副詞	\N	\N	\N	1426	\N
59	in	…へ	前置詞（４格と）	\N	\N	\N	1426	\N
477	Wald	森	男性名詞	\N	\N	\N	1426	\N
295	bleib'  bleibe	いる，とどまる	動詞	\N	\N	\N	1427	\N
21	schön	ちゃんと	副詞	\N	\N	\N	1427	\N
206	zu Hause	家に	前置詞句	\N	\N	\N	1427	\N
479	gucke	見る	動詞	\N	\N	\N	1427	\N
151	wenn	…する時に	従属接続詞	\N	\N	\N	1428	\N
491	zurückkkommst	帰ってくる	分離動詞	\N	\N	\N	1428	\N
492	koch'  koche	（コーヒー）などを入れる	動詞	\N	\N	\N	1428	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1428	\N
415	Kamillentee	カモミールティー	女性名詞	\N	\N	\N	1428	\N
493	Elke	エルケ	女性人名	\N	\N	\N	1429	\N
320	isst	食べる	動詞	\N	\N	\N	1429	\N
162	eigentlich	ところで	副詞	\N	\N	\N	1429	\N
293	gerne	好んで	副詞	\N	\N	\N	1429	\N
318	japanisch	日本風の	形容詞	\N	\N	\N	1429	\N
327	Tofu	豆腐	男性名詞	\N	\N	\N	1431	\N
494	zum Beispiel	たとえば	成句	\N	\N	\N	1431	\N
320	esse	食べる	動詞	\N	\N	\N	1431	\N
145	gern	好んで	副詞	\N	\N	\N	1431	\N
7	auch	…もまた	副詞	\N	\N	\N	1433	\N
37	meine	…（４格）のことを言っている	動詞	\N	\N	\N	1433	\N
495	rohen	生の	形容詞（男性４格）	\N	\N	\N	1433	\N
496	Fisch	魚	男性名詞	\N	\N	\N	1433	\N
497	lieber	より好んで	副詞（gernの比較級）	\N	\N	\N	1435	\N
118	als	（比較級と）…より	副詞	\N	\N	\N	1435	\N
472	und	そして	並列接続詞	\N	\N	\N	1436	\N
412	magst	…（４格）が好きだ	並列接続詞	\N	\N	\N	1436	\N
498	Misosuppe	味噌汁	女性名詞	\N	\N	\N	1436	\N
265	Die	それを	指示代名詞（女性４格）	\N	\N	\N	1438	\N
276	sogar	それどころか	副詞	\N	\N	\N	1438	\N
499	am liebsten	最も好んで	副詞（gernの最上級）	\N	\N	\N	1438	\N
254	was ... angeht	…（４格）に関して	成句	\N	\N	\N	1438	\N
318	japanisches	日本の，日本風の	形容詞（中性４格）	\N	\N	\N	1438	\N
500	Essen	食べ物，料理	中性名詞	\N	\N	\N	1438	\N
317	warum	どうして，なぜ	疑問副詞	\N	\N	\N	1439	\N
501	redest	話す，語る	動詞	\N	\N	\N	1439	\N
254	die ganze Zeit	ずっと	成句	\N	\N	\N	1439	\N
502	über	…について	前置詞（４格と）	\N	\N	\N	1439	\N
392	Tja	そうだなあ，ええと	間投詞	\N	\N	\N	1440	\N
1	Hallo	やあ	間投詞	\N	\N	\N	1035	\N
2	lange	長い間	副詞	\N	\N	\N	1037	\N
3	gesehen	会った	動詞	\N	\N	\N	1037	\N
4	na	ねえ	間投詞	\N	\N	\N	1038	\N
5	wie geht's	調子はどう	成句	\N	\N	\N	1038	\N
6	mir geht's	私は調子が～だ	成句	\N	\N	\N	1041	\N
7	auch	…も	副詞	\N	\N	\N	1041	\N
8	was	何を	疑問代名詞	\N	\N	\N	1042	\N
9	machst	する	動詞	\N	\N	\N	1042	\N
10	jetzt	今	副詞	\N	\N	\N	1042	\N
11	fahre	（乗り物で）行く	動詞	\N	\N	\N	1043	\N
12	zu	…（のところ）に	前置詞（３格と）	\N	\N	\N	1043	\N
13	meinen	私の	所有冠詞（複数３格）	\N	\N	\N	1043	\N
14	Eltern	両親	複数名詞	\N	\N	\N	1043	\N
13	mein	私の	所有冠詞（男性１格）	\N	\N	\N	1044	\N
15	Vater	父	男性名詞	\N	\N	\N	1044	\N
16	heute	今日	副詞	\N	\N	\N	1044	\N
17	Geburtstag	誕生日	男性名詞	\N	\N	\N	1044	\N
18	dann	それなら	副詞	\N	\N	\N	1045	\N
19	feiert	お祝いする	動詞	\N	\N	\N	1045	\N
10	jetzt	今	副詞	\N	\N	\N	1045	\N
20	zusammen	一緒に	副詞	\N	\N	\N	1045	\N
21	schön	すてきだ	形容詞	\N	\N	\N	1046	\N
22	Grüß	挨拶する	動詞	\N	\N	\N	1047	\N
23	deine	君の	所有冠詞（複数４格）	\N	\N	\N	1047	\N
24	von	…から	前置詞（３格と）	\N	\N	\N	1047	\N
25	mir	私	人称代名詞（３格）	\N	\N	\N	1047	\N
26	das	それを	指示代名詞	\N	\N	\N	1048	\N
9	mache	する	動詞	\N	\N	\N	1048	\N
27	Bus	バス	男性名詞	\N	\N	\N	1049	\N
28	kommt	来る	動詞	\N	\N	\N	1049	\N
29	schon	もう	副詞	\N	\N	\N	1049	\N
18	Dann	それでは	副詞	\N	\N	\N	1050	\N
30	wünsche	願う	動詞	\N	\N	\N	1050	\N
31	dir	君に	人称代名詞(3格）	\N	\N	\N	1050	\N
32	noch	まだ	副詞	\N	\N	\N	1050	\N
21	schönen	すてきな	形容詞	\N	\N	\N	1050	\N
33	Abend	晩	男性名詞	\N	\N	\N	1050	\N
34	Tschüs	じゃあね，バイバイ	間投詞	\N	\N	\N	1051	\N
35	gleichfalls	同様に	副詞	\N	\N	\N	1052	\N
36	Entschuldigung	すみません	名詞	\N	\N	\N	1054	\N
37	Meinen	…のことを言う	動詞（４格と）	\N	\N	\N	1055	\N
38	mich	私	人称代名詞（４格）	\N	\N	\N	1055	\N
39	glaube	思う	動詞	\N	\N	\N	1057	\N
40	Ihr	あなたの	所有冠詞（中性４格）	\N	\N	\N	1057	\N
41	Portemonnaie	財布	中性名詞	\N	\N	\N	1057	\N
42	vergessen	忘れる	動詞（過去分詞）	\N	\N	\N	1057	\N
13	mein	私の	所有冠詞（中性４格）	\N	\N	\N	1058	\N
41	Portemonnaie	財布	中性名詞	\N	\N	\N	1058	\N
43	Ihres	あなたのもの	所有代名詞（中性１格）	\N	\N	\N	1059	\N
44	meins	私のもの	所有代名詞（中性１格）	\N	\N	\N	1061	\N
45	aber	（驚きを表す）	副詞	\N	\N	\N	1062	\N
46	sehr	とても	副詞	\N	\N	\N	1062	\N
47	nett	親切だ	形容詞	\N	\N	\N	1062	\N
24	von	…による	前置詞（３格と）	\N	\N	\N	1062	\N
48	Ihnen	あなた	人称代名詞（３格）	\N	\N	\N	1062	\N
49	vielen Dank	どうもありがとう	成句	\N	\N	\N	1063	\N
50	Bitte schön	どういたしまして	成句	\N	\N	\N	1064	\N
51	Nichts zu danken	礼には及びません	成句	\N	\N	\N	1065	\N
52	Wo	どこ	疑問副詞	\N	\N	\N	1066	\N
53	es	それを	人称代名詞（中性４格）	\N	\N	\N	1066	\N
54	denn	いったい	副詞	\N	\N	\N	1066	\N
55	gefunden	見つける	動詞（過去分詞）	\N	\N	\N	1066	\N
56	gar	まったく	副詞	\N	\N	\N	1067	\N
57	nichts	何も…ない	不定代名詞	\N	\N	\N	1067	\N
58	gemerkt	気づく	動詞（過去分詞）	\N	\N	\N	1067	\N
59	In	…の中で	前置詞（３格と）	\N	\N	\N	1068	\N
60	Telefonzelle	電話ボックス	女性名詞	\N	\N	\N	1068	\N
53	es	それを	人称代名詞（中性４格）	\N	\N	\N	1068	\N
42	vergessen	忘れる	動詞（過去分詞）	\N	\N	\N	1068	\N
61	direkt	すぐ	副詞	\N	\N	\N	1069	\N
62	vor	…の前に	前置詞（３格と）	\N	\N	\N	1069	\N
25	mir	私	人称代名詞（３格）	\N	\N	\N	1069	\N
63	waren ... dran	順番だ	成句	\N	\N	\N	1069	\N
64	ach	ああ	間投詞	\N	\N	\N	1070	\N
65	Gott sei Dank	ありがたい	成句	\N	\N	\N	1070	\N
66	Da	それは	副詞	\N	\N	\N	1071	\N
45	aber	（感情を強める）	副詞	\N	\N	\N	1071	\N
67	froh	うれしい	形容詞	\N	\N	\N	1071	\N
49	Vielen Dank	どうもありがとう	成句	\N	\N	\N	1072	\N
68	nochmals	もう一度	成句	\N	\N	\N	1072	\N
16	Heute	今日	副詞	\N	\N	\N	1073	\N
69	war	…だ	動詞（過去形）	\N	\N	\N	1073	\N
70	Wetter	天気	中性名詞	\N	\N	\N	1073	\N
71	wirklich	本当に	副詞	\N	\N	\N	1073	\N
32	noch	まだ	副詞	\N	\N	\N	1074	\N
72	richtig	実に	副詞	\N	\N	\N	1074	\N
73	warm	暖かい	形容詞	\N	\N	\N	1074	\N
74	schau	見る	動詞（命令形）	\N	\N	\N	1075	\N
75	mal	ちょっと	副詞	\N	\N	\N	1075	\N
76	Abendrot	夕日	中性名詞	\N	\N	\N	1075	\N
77	echt	本当に	副詞	\N	\N	\N	1076	\N
78	phantastisch	すばらしい	形容詞	\N	\N	\N	1076	\N
79	Wie	…のように	接続詞	\N	\N	\N	1077	\N
80	im	…の中で	前置詞＋定冠詞（男性・中性３格）	\N	\N	\N	1077	\N
81	Film	映画	男性名詞	\N	\N	\N	1077	\N
82	Stimmt	その通りだ	動詞	\N	\N	\N	1078	\N
83	hör	聞く	動詞（命令形）	\N	\N	\N	1079	\N
75	mal	ちょっと	副詞	\N	\N	\N	1079	\N
66	da	あそこで	副詞	\N	\N	\N	1080	\N
9	macht	する	動詞	\N	\N	\N	1080	\N
84	jemand	誰かが	不定代名詞	\N	\N	\N	1080	\N
85	Musik	音楽	女性名詞	\N	\N	\N	1080	\N
85	Musik	音楽	女性名詞	\N	\N	\N	1081	\N
83	hör'	聞こえる	動詞	\N	\N	\N	1082	\N
57	nichts	何も…ない	不定代名詞	\N	\N	\N	1082	\N
86	doch	（相手の否定的発言を打ち消して）いや	副詞	\N	\N	\N	1083	\N
83	hör	聞く	動詞（命令形）	\N	\N	\N	1083	\N
75	mal	ちょっと	副詞	\N	\N	\N	1083	\N
82	stimmt	その通りだ	動詞	\N	\N	\N	1084	\N
10	jetzt	今	副詞	\N	\N	\N	1085	\N
83	hör'	聞こえる	動詞	\N	\N	\N	1085	\N
7	auch	…も	副詞	\N	\N	\N	1085	\N
66	Da	あそこで	副詞	\N	\N	\N	1086	\N
87	spielt	演奏する	動詞	\N	\N	\N	1086	\N
84	jemand	誰かが	不定代名詞	\N	\N	\N	1086	\N
88	Gitarre	ギター	女性名詞	\N	\N	\N	1086	\N
89	Gehen ... hin	そこに行く	分離動詞	\N	\N	\N	1087	\N
66	da	あそこ	副詞	\N	\N	\N	1087	\N
75	mal	ちょっと	副詞	\N	\N	\N	1087	\N
90	gute	良い	形容詞（女性１格）	\N	\N	\N	1088	\N
91	Idee	考え	女性名詞	\N	\N	\N	1088	\N
92	hier	ここ	副詞	\N	\N	\N	1089	\N
32	noch	まだ	副詞	\N	\N	\N	1089	\N
93	frei	空いている	形容詞	\N	\N	\N	1089	\N
94	bitte	どうぞ	副詞	\N	\N	\N	1090	\N
95	findet ... statt	行われる	分離動詞	\N	\N	\N	1091	\N
86	doch	（確認を求めて）…でしょう	副詞	\N	\N	\N	1091	\N
96	Vorlesung	講義	女性名詞	\N	\N	\N	1091	\N
24	von	…の	前置詞（３格と）	\N	\N	\N	1091	\N
97	Professor	教授	男性名詞	\N	\N	\N	1091	\N
98	oder	（確認を求めて）…そうだよね	接続詞	\N	\N	\N	1091	\N
72	richtig	正しい	形容詞	\N	\N	\N	1092	\N
99	kenne	知っている	動詞	\N	\N	\N	1093	\N
100	dich	君を	人称代名詞（４格）	\N	\N	\N	1093	\N
32	noch	まだ	副詞	\N	\N	\N	1093	\N
56	gar	まったく	副詞	\N	\N	\N	1093	\N
101	Studierst	（大学で）専攻する	動詞	\N	\N	\N	1094	\N
7	auch	…も	副詞	\N	\N	\N	1094	\N
102	Jura	法学	複数名詞	\N	\N	\N	1094	\N
103	Politik	政治学	女性名詞	\N	\N	\N	1095	\N
104	interessiere mich ... für ~	…（４格）に興味がある	再帰動詞	\N	\N	\N	1096	\N
7	auch	…も	副詞	\N	\N	\N	1096	\N
105	französisches	フランスの	形容詞（中性４格）	\N	\N	\N	1096	\N
106	Recht	法律	中性名詞	\N	\N	\N	1096	\N
107	Übrigens	ところで	副詞	\N	\N	\N	1097	\N
108	heiße	（…という）名前である	動詞(１格と）	\N	\N	\N	1097	\N
109	Silke	ズィルケ	女性人名	\N	\N	\N	1097	\N
110	Klaus	クラウス	男性人名	\N	\N	\N	1099	\N
83	gehört	聞く	動詞（過去分詞）	\N	\N	\N	1100	\N
111	dass	…ということ	従属接続詞	\N	\N	\N	1100	\N
96	Vorlesung	講義	女性名詞	\N	\N	\N	1100	\N
112	auf	…で	前置詞	\N	\N	\N	1100	\N
113	Französisch	フランス語	中性名詞	\N	\N	\N	1100	\N
82	Stimmt	合っている	動詞	\N	\N	\N	1101	\N
26	das	それは	指示代名詞	\N	\N	\N	1101	\N
39	glaube	思う	動詞	\N	\N	\N	1102	\N
97	Professor	教授	男性名詞	\N	\N	\N	1103	\N
28	kommt	来る	動詞	\N	\N	\N	1103	\N
114	ja	（理由付け）…だから	副詞	\N	\N	\N	1103	\N
115	aus	…から	前置詞	\N	\N	\N	1103	\N
116	Frankreich	フランス	地名	\N	\N	\N	1103	\N
117	Kannst	できる	動詞（４格と）	\N	\N	\N	1104	\N
90	gut	上手い	形容詞	\N	\N	\N	1104	\N
113	Französisch	フランス語	中性名詞	\N	\N	\N	1104	\N
118	als	…として	接続詞	\N	\N	\N	1105	\N
119	Kind	子供	中性名詞	\N	\N	\N	1105	\N
59	in	…で	前置詞	\N	\N	\N	1105	\N
116	Frankreich	フランス	地名	\N	\N	\N	1105	\N
120	gelebt	暮らす	動詞（過去分詞）	\N	\N	\N	1105	\N
121	Wartest	待っている	動詞	\N	\N	\N	1107	\N
29	schon	すでに	副詞	\N	\N	\N	1107	\N
2	lange	長い間	副詞	\N	\N	\N	1107	\N
122	Na ja	まあね	成句	\N	\N	\N	1108	\N
123	es geht	なんとか成っている	成句	\N	\N	\N	1108	\N
124	Ungefähr	約	副詞	\N	\N	\N	1109	\N
125	Viertelstunde	15分	女性名詞	\N	\N	\N	1109	\N
126	das tut mir ... Leid	ごめんなさい	成句	\N	\N	\N	1110	\N
127	wirklich	本当に	副詞	\N	\N	\N	1110	\N
128	Zug	電車	名詞	\N	\N	\N	1111	\N
129	hatte	持つ	動詞（過去形）	\N	\N	\N	1111	\N
130	Minuten	分	女性名詞（複数４格）	\N	\N	\N	1111	\N
131	Verspätung	遅刻	女性名詞	\N	\N	\N	1111	\N
122	na ja	まあね	成句	\N	\N	\N	1112	\N
66	da	それでは	副詞	\N	\N	\N	1112	\N
117	kann	…できる	話法の助動詞	\N	\N	\N	1112	\N
132	man	人は	不定代名詞	\N	\N	\N	1112	\N
57	nichts	何も…ない	不定代名詞	\N	\N	\N	1112	\N
9	machen	する	動詞	\N	\N	\N	1112	\N
107	übrigens	ところで	副詞	\N	\N	\N	1113	\N
13	mein	私の	所有冠詞（中性４格）	\N	\N	\N	1113	\N
133	Buch	本	中性名詞	\N	\N	\N	1113	\N
134	mitgebracht	持ってくる	動詞（過去分詞）	\N	\N	\N	1113	\N
23	Dein	君の	所有冠詞（中性４格）	\N	\N	\N	1114	\N
133	Buch	本	中性名詞	\N	\N	\N	1114	\N
135	Mein Gott	おやおや，なんということだ	成句	\N	\N	\N	1116	\N
26	das	それを	指示代名詞（中性４格）	\N	\N	\N	1117	\N
136	ganz	完全に	副詞	\N	\N	\N	1117	\N
42	vergessen	忘れる	動詞（過去分詞）	\N	\N	\N	1117	\N
36	Entschuldigung	ごめんなさい（＜許し）	女性名詞	\N	\N	\N	1119	\N
26	Das	それは	指示代名詞	\N	\N	\N	1120	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1120	\N
10	jetzt	今	副詞	\N	\N	\N	1120	\N
127	wirklich	本当に	副詞	\N	\N	\N	1120	\N
137	peinlich	心苦しい	形容詞	\N	\N	\N	1120	\N
134	bringe ... mit	持ってくる	分離動詞	\N	\N	\N	1121	\N
53	es	それを	人称代名詞（中性４格）	\N	\N	\N	1121	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1121	\N
138	morgen	明日	副詞	\N	\N	\N	1121	\N
139	ist in Ordnung	問題ない	成句	\N	\N	\N	1122	\N
18	Dann	それなら	副詞	\N	\N	\N	1123	\N
140	trinken	飲む	動詞	\N	\N	\N	1123	\N
141	erst mal	まず	成句	\N	\N	\N	1123	\N
142	Kaffee	コーヒー	男性名詞	\N	\N	\N	1123	\N
90	gut	良い	形容詞	\N	\N	\N	1124	\N
129	hast	持っている	動詞	\N	\N	\N	1125	\N
143	viele	多くの	不定数詞	\N	\N	\N	1125	\N
133	Bücher	本	中性名詞（複数４格）	\N	\N	\N	1125	\N
122	Na ja	まあね	成句	\N	\N	\N	1126	\N
144	lese	読書する	動詞	\N	\N	\N	1126	\N
46	sehr	とても	副詞	\N	\N	\N	1126	\N
145	gern	好んで	副詞	\N	\N	\N	1126	\N
146	den	この	指示冠詞（男性４格）	\N	\N	\N	1127	\N
147	Roman	（長編）小説	男性名詞	\N	\N	\N	1127	\N
7	auch	…も	副詞	\N	\N	\N	1127	\N
146	Den	これを	指示代名詞（男性４格）	\N	\N	\N	1128	\N
148	wollte	…するつもりだ	話法の助動詞（過去形）	\N	\N	\N	1128	\N
29	schon	すでに	副詞	\N	\N	\N	1128	\N
2	lange	長い間	副詞	\N	\N	\N	1128	\N
144	lesen	読む	動詞	\N	\N	\N	1128	\N
79	Wie	どのように	疑問副詞	\N	\N	\N	1129	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1129	\N
149	gefallen	…（3格）に気に入る	動詞（過去分詞）	\N	\N	\N	1129	\N
46	sehr	すごく	副詞	\N	\N	\N	1130	\N
90	gut	良い	形容詞	\N	\N	\N	1130	\N
146	Der	これ，それ	指示代名詞（男性1格）	\N	\N	\N	1131	\N
69	war	…である	動詞（過去形）	\N	\N	\N	1131	\N
127	wirklich	本当に	副詞	\N	\N	\N	1131	\N
150	spannend	ハラハラ(ワクワク)させる	形容詞	\N	\N	\N	1131	\N
129	hast	持っている	動詞	\N	\N	\N	1132	\N
146	den	これ，それ	指示代名詞（男性4格）	\N	\N	\N	1132	\N
32	noch	まだ	副詞	\N	\N	\N	1132	\N
151	wenn	もし…ならば	従属接続詞	\N	\N	\N	1134	\N
148	willst	…したい	話法の助動詞	\N	\N	\N	1134	\N
152	nimm ... mit	持っていく	分離動詞（命令形）	\N	\N	\N	1134	\N
18	dann	それならば	副詞	\N	\N	\N	1134	\N
153	ihn	それを	人称代名詞（男性４格）	\N	\N	\N	1134	\N
86	doch	（促す気持ち）さあ，ぜひ	副詞	\N	\N	\N	1134	\N
154	einfach	ただ，とにかく	副詞	\N	\N	\N	1134	\N
155	schenke	プレゼントする	動詞	\N	\N	\N	1135	\N
153	ihn	それを	人称代名詞（男性４格）	\N	\N	\N	1135	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1135	\N
77	Echt	本当に	副詞	\N	\N	\N	1136	\N
156	zweimal	2度，2回	副詞	\N	\N	\N	1137	\N
144	gelesen	読む	動詞（過去分詞）	\N	\N	\N	1137	\N
157	brauche	必要とする	動詞	\N	\N	\N	1137	\N
158	mehr	（否定と共に）もう（…ない）	副詞	\N	\N	\N	1137	\N
45	aber	本当に，まったく	副詞	\N	\N	\N	1138	\N
159	lieb	親切な	形容詞	\N	\N	\N	1138	\N
160	danke	ありがとう	間投詞	\N	\N	\N	1139	\N
94	Bitte	どういたしまして	副詞	\N	\N	\N	1140	\N
161	hoffe	期待する，望む	動詞	\N	\N	\N	1141	\N
149	gefällt	…（3格）に気に入る	動詞	\N	\N	\N	1141	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1141	\N
11	Fährst	（乗り物で）行く，乗って行く	動詞	\N	\N	\N	1142	\N
92	hier	ここに	副詞	\N	\N	\N	1181	\N
162	eigentlich	（疑問文で）ところで，そもそも	副詞	\N	\N	\N	1142	\N
163	immer	いつも	副詞	\N	\N	\N	1142	\N
164	mit	…で（手段）	前置詞（３格と）	\N	\N	\N	1142	\N
128	Zug	電車	男性名詞	\N	\N	\N	1142	\N
165	Normalerweise	ふつうは	副詞	\N	\N	\N	1144	\N
11	fahre	（乗り物で）行く，乗って行く	動詞	\N	\N	\N	1144	\N
164	mit	…で（手段）	前置詞（３格と）	\N	\N	\N	1144	\N
166	Straßenbahn	路面電車	女性名詞	\N	\N	\N	1144	\N
167	Wohin	どこに	疑問副詞	\N	\N	\N	1145	\N
10	jetzt	今	副詞	\N	\N	\N	1145	\N
54	denn	いったい	副詞	\N	\N	\N	1145	\N
168	Ins	…（の中）へ	前置詞＋定冠詞（中性４格）	\N	\N	\N	1146	\N
169	Zentrum	中心街	中性名詞	\N	\N	\N	1146	\N
170	treffe	会う	動詞（４格と）	\N	\N	\N	1147	\N
171	ein paar	二三の，若干の	不定数詞	\N	\N	\N	1147	\N
172	Freunde	友達	名詞（複数４格）	\N	\N	\N	1147	\N
173	muss	…しなければならない	話法の助動詞	\N	\N	\N	1149	\N
174	zur	…に（方向・目的）	前置詞（３格と）＋定冠詞（女性３格）	\N	\N	\N	1149	\N
175	Arbeit	仕事	女性名詞	\N	\N	\N	1149	\N
176	Armer	かわいそうな人	形容詞（名詞化）	\N	\N	\N	1150	\N
173	muss	（nurと共に）…するだけでいい	話法の助動詞	\N	\N	\N	1151	\N
16	heute	今日	副詞	\N	\N	\N	1151	\N
177	nur	ただ…だけ	副詞	\N	\N	\N	1151	\N
178	vier	4	数詞	\N	\N	\N	1151	\N
179	Stunden	時間	女性名詞（複数４格）	\N	\N	\N	1151	\N
180	arbeiten	働く	動詞	\N	\N	\N	1151	\N
122	Na ja	まあいいか	成句	\N	\N	\N	1152	\N
26	das	それは	指示代名詞	\N	\N	\N	1152	\N
181	geht	なんとかなる	動詞	\N	\N	\N	1152	\N
114	ja	…だね	副詞	\N	\N	\N	1152	\N
32	noch	まだ，なお	副詞	\N	\N	\N	1152	\N
182	muss	…しなければならない	話法助動詞	\N	\N	\N	1154	\N
183	aussteigen	（乗り物）から降りる	分離動詞	\N	\N	\N	1154	\N
18	Dann	それでは	副詞	\N	\N	\N	1155	\N
184	viel Spaß	楽しんでね！	成句	\N	\N	\N	1155	\N
34	Tschüs	またね，バイバイ	間投詞	\N	\N	\N	1156	\N
21	schönes	良い	形容詞（中性４格）	\N	\N	\N	1157	\N
185	Wochenende	週末	中性名詞	\N	\N	\N	1157	\N
34	Tschüs	またね，バイバイ	間投詞	\N	\N	\N	1158	\N
186	Guten Tag	こんにちは	成句	\N	\N	\N	1159	\N
186	Guten Tag	こんにちは	成句	\N	\N	\N	1160	\N
36	Entschuldigung	すみません（＜許し）	女性名詞	\N	\N	\N	1161	\N
117	können	…することができる	話法の助動詞	\N	\N	\N	1161	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1161	\N
187	helfen	…を助ける，手伝う	動詞（３格と）	\N	\N	\N	1161	\N
188	suche	探す	動詞	\N	\N	\N	1162	\N
189	etwas	何か，あるもの	不定代名詞	\N	\N	\N	1162	\N
190	für	…のために	前置詞（４格と）	\N	\N	\N	1162	\N
191	sechsjähriges	6歳の	形容詞（中性４格）	\N	\N	\N	1162	\N
119	Kind	子供	中性名詞	\N	\N	\N	1162	\N
192	Kleid	ワンピース	中性名詞	\N	\N	\N	1163	\N
98	oder	あるいは	接続詞	\N	\N	\N	1163	\N
193	so was	そのようなもの	成句	\N	\N	\N	1163	\N
115	aus	…でできた	前置詞（３格と）	\N	\N	\N	1164	\N
194	Baumwolle	木綿	女性名詞	\N	\N	\N	1164	\N
195	am besten	最も良い	形容詞（gutの最上級）	\N	\N	\N	1164	\N
145	gerne	好んで，喜んで	副詞	\N	\N	\N	1165	\N
196	welche	どの	疑問冠詞（女性１格）	\N	\N	\N	1166	\N
197	Preislage	価格帯	女性名詞	\N	\N	\N	1166	\N
198	soll	…べきである	話法の助動詞	\N	\N	\N	1166	\N
69	sein	…である	動詞	\N	\N	\N	1166	\N
124	Ungefähr	約，おおよそ	副詞	\N	\N	\N	1169	\N
199	Euro	ユーロ	男性名詞	\N	\N	\N	1169	\N
79	Wie	どのように	疑問副詞	\N	\N	\N	1171	\N
55	finden	…を～と思う	動詞	\N	\N	\N	1171	\N
200	dieses	この	指示冠詞（中性４格）	\N	\N	\N	1171	\N
192	Kleid	ワンピース	中性名詞	\N	\N	\N	1171	\N
86	doch	（同意を求めて）…でしょう	副詞	\N	\N	\N	1172	\N
136	ganz	とても	副詞	\N	\N	\N	1172	\N
201	niedlich	かわいらしい	形容詞	\N	\N	\N	1172	\N
46	sehr	とても	副詞	\N	\N	\N	1173	\N
21	schön	きれいな，素敵な	形容詞	\N	\N	\N	1173	\N
149	gefällt	…（３格）に気に入る	動詞	\N	\N	\N	1174	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1174	\N
90	gut	良い	形容詞	\N	\N	\N	1174	\N
8	was	いくら	疑問代名詞	\N	\N	\N	1175	\N
202	kostet	（値段が）…である	動詞	\N	\N	\N	1175	\N
26	das	それは	指示代名詞	\N	\N	\N	1175	\N
54	denn	いったい	副詞	\N	\N	\N	1175	\N
203	nehm'  nehme	（品物を）買う	動詞	\N	\N	\N	1177	\N
49	Vielen Dank	どうもありがとう	成句	\N	\N	\N	1178	\N
18	Dann	それでは	副詞	\N	\N	\N	1179	\N
204	kommen ... mit	一緒に来る	分離動詞	\N	\N	\N	1179	\N
94	bitte	どうぞ	副詞	\N	\N	\N	1179	\N
174	zur	…の方へ，…のところへ	前置詞＋定冠詞（女性３格）	\N	\N	\N	1179	\N
205	Kasse	レジ	女性名詞	\N	\N	\N	1179	\N
4	Na	ねえ	間投詞	\N	\N	\N	1180	\N
8	was	何を	疑問代名詞	\N	\N	\N	1180	\N
144	liest	読む	動詞	\N	\N	\N	1180	\N
66	da	そこで	副詞	\N	\N	\N	1180	\N
206	so	そんなに	副詞	\N	\N	\N	1180	\N
207	interessiert	興味を持った	形容詞	\N	\N	\N	1180	\N
208	seit	…以来	前置詞（３格と）	\N	\N	\N	1181	\N
209	wann	いつ	疑問副詞	\N	\N	\N	1181	\N
69	bist	いる	動詞	\N	\N	\N	1181	\N
54	denn	いったい	副詞	\N	\N	\N	1181	\N
100	dich	君	人称代名詞（４格）	\N	\N	\N	1182	\N
56	gar	まったく	副詞	\N	\N	\N	1182	\N
210	bemerkt	気づく	動詞（４格と，過去分詞）	\N	\N	\N	1182	\N
211	Reiseführer	旅行ガイド	男性名詞	\N	\N	\N	1183	\N
206	so	そのように，そんな具合に	副詞	\N	\N	\N	1183	\N
212	interessant	おもしろい，興味をひく	形容詞	\N	\N	\N	1183	\N
148	willst	…するつもりである	話法の助動詞	\N	\N	\N	1184	\N
213	verreisen	旅行に出る	動詞	\N	\N	\N	1184	\N
214	im	…に（時）	前置詞＋冠詞（男性・中性３格）	\N	\N	\N	1185	\N
215	Sommer	夏	男性名詞	\N	\N	\N	1185	\N
11	fahr'  fahre	（乗り物で）行く	動詞	\N	\N	\N	1185	\N
216	nach	…（地名）へ	前置詞	\N	\N	\N	1185	\N
217	China	中国	地名	\N	\N	\N	1185	\N
218	interessiere mich für ～	～（４格）に興味がある	再帰動詞	\N	\N	\N	1187	\N
219	chinesische	中国の	形容詞（女性４格）	\N	\N	\N	1187	\N
220	Geschichte	歴史	女性名詞	\N	\N	\N	1187	\N
221	Kultur	文化	女性名詞	\N	\N	\N	1187	\N
29	schon	もう，すでに	副詞	\N	\N	\N	1188	\N
75	mal	以前に，かつて	副詞	\N	\N	\N	1188	\N
222	Asien	アジア	地名	\N	\N	\N	1188	\N
223	Urlaub	休暇旅行，バカンス	男性名詞	\N	\N	\N	1188	\N
9	gemacht	する	動詞（過去分詞）	\N	\N	\N	1188	\N
59	in	…に	前置詞	\N	\N	\N	1189	\N
217	China	中国	名詞	\N	\N	\N	1189	\N
69	war	いた	動詞	\N	\N	\N	1189	\N
32	noch	まだ	副詞	\N	\N	\N	1189	\N
224	letztes	最近の，最後の	形容詞（中性４格）	\N	\N	\N	1190	\N
225	Jahr	年	中性名詞	\N	\N	\N	1190	\N
69	war	いる	動詞（過去形）	\N	\N	\N	1190	\N
226	Thailand	タイ	地名	\N	\N	\N	1190	\N
21	schön	すばらしい，素敵だ	形容詞	\N	\N	\N	1191	\N
79	wie	どのようだ	疑問副詞	\N	\N	\N	1192	\N
66	da	そこは	副詞	\N	\N	\N	1192	\N
136	ganz	とても	副詞	\N	\N	\N	1193	\N
227	toll	すてきな，すごく良い	形容詞	\N	\N	\N	1193	\N
65	Gott sei dank	ありがたい，やれやれ	成句	\N	\N	\N	1194	\N
228	Prüfung	試験	女性名詞	\N	\N	\N	1195	\N
229	endlich	やっと	副詞	\N	\N	\N	1195	\N
230	vorbei	過ぎ去って	副詞	\N	\N	\N	1195	\N
231	freu' mich	喜ぶ，うれしく思う	再帰動詞	\N	\N	\N	1196	\N
7	auch	…も	副詞	\N	\N	\N	1196	\N
232	total	本当に	副詞	\N	\N	\N	1196	\N
10	jetzt	今から	副詞	\N	\N	\N	1197	\N
233	Sommerferien	夏休み	複数名詞	\N	\N	\N	1197	\N
8	Was	何を	疑問代名詞	\N	\N	\N	1198	\N
9	machst	する	動詞	\N	\N	\N	1198	\N
200	diesen	この	指示冠詞（男性４格）	\N	\N	\N	1198	\N
215	Sommer	夏	男性名詞	\N	\N	\N	1198	\N
234	Nächste	次の	形容詞（女性４格）	\N	\N	\N	1200	\N
235	Woche	週	女性名詞	\N	\N	\N	1200	\N
236	Freitag	金曜日	男性名詞	\N	\N	\N	1200	\N
237	fahr' ...  in Urlaub  fahre ... in Urlaub	休暇旅行に出かける	成句	\N	\N	\N	1200	\N
190	für	…の予定で	前置詞（４格と）	\N	\N	\N	1200	\N
238	zwei	２	数詞	\N	\N	\N	1200	\N
167	Wohin	どこへ	疑問副詞	\N	\N	\N	1202	\N
54	denn	いったい	副詞	\N	\N	\N	1202	\N
164	mit	…と一緒に	前置詞（３格と）	\N	\N	\N	1203	\N
239	wem	誰	疑問代名詞（３格）	\N	\N	\N	1203	\N
162	eigentlich	いったい	副詞	\N	\N	\N	1203	\N
164	Mit	…と一緒に	前置詞	\N	\N	\N	1204	\N
13	meinem	私の	所有冠詞（男性３格）	\N	\N	\N	1204	\N
172	Freund	恋人，親友	男性名詞	\N	\N	\N	1204	\N
59	In	…へ	前置詞（3・4格支配;ここでは4格名詞と結びついている）	\N	\N	\N	1205	\N
240	Türkei	トルコ	地名（女性名詞）	\N	\N	\N	1205	\N
66	da	そこに	副詞	\N	\N	\N	1206	\N
172	Freunde	友達	名詞（複数４格）	\N	\N	\N	1206	\N
241	hast ... vor	計画する，予定する	分離動詞	\N	\N	\N	1208	\N
29	schon	もう，すでに	副詞	\N	\N	\N	1208	\N
8	was	何か	不定代名詞	\N	\N	\N	1208	\N
59	In	…後に	前置詞（3・4格支配；ここでは3格名詞と）	\N	\N	\N	1209	\N
235	Woche	週	女性名詞	\N	\N	\N	1209	\N
28	kommt	来る	動詞	\N	\N	\N	1209	\N
13	meine	私の	所有代名詞（女性１格）	\N	\N	\N	1209	\N
242	Freundin	恋人，親友	女性名詞	\N	\N	\N	1209	\N
115	aus	…（場所）から	前置詞（３格と）	\N	\N	\N	1209	\N
243	den Staaten	アメリカ合衆国	複数名詞（３格）	\N	\N	\N	1209	\N
12	zu	…のために	前置詞（３格と）	\N	\N	\N	1209	\N
244	Besuch	訪問	男性名詞	\N	\N	\N	1209	\N
72	richtig	本当に，実に	副詞	\N	\N	\N	1210	\N
245	aufgeregt	興奮している	形容詞	\N	\N	\N	1210	\N
246	sie	彼女	人称代名詞（４格）	\N	\N	\N	1210	\N
229	endlich	やっと	副詞	\N	\N	\N	1210	\N
247	wiederzusehen	…（４格）に再会する	分離動詞（zu不定詞）	\N	\N	\N	1210	\N
39	glaub'	（本当だと）思う	動詞	\N	\N	\N	1211	\N
136	ganze	かなりの，多くの	形容詞（女性４格）	\N	\N	\N	1212	\N
248	Menge	数量	女性名詞	\N	\N	\N	1212	\N
249	Ausflüge	遠足，遠出	男性名詞（複数４格）	\N	\N	\N	1212	\N
250	und so	など	成句	\N	\N	\N	1212	\N
251	geplant	計画する，予定する	動詞（過去分詞）	\N	\N	\N	1212	\N
4	Na	ねえ	間投詞	\N	\N	\N	1213	\N
8	was	何を 	疑問代名詞 	\N	\N	\N	1213	\N
252	am	…（時）に	前置詞＋定冠詞	\N	\N	\N	1213	\N
185	Wochenende	週末	中性名詞	\N	\N	\N	1213	\N
9	gemacht	する 	他動詞（過去分詞） 	\N	\N	\N	1213	\N
69	war	いる 	自動詞（過去形） 	\N	\N	\N	1214	\N
253	Samstag	土曜日 	男性名詞 	\N	\N	\N	1214	\N
254	zum ersten Mal	初めて 	成句 	\N	\N	\N	1214	\N
255	Café	カフェ 	中性名詞 	\N	\N	\N	1214	\N
256	Kowalski	コバルスキー 	人名 	\N	\N	\N	1214	\N
69	warst	いる 	自動詞（過去形）	\N	\N	\N	1215	\N
254	schon mal	これまでに一度 	成句 	\N	\N	\N	1215	\N
66	da	そこに 	副詞	\N	\N	\N	1215	\N
181	geh'	行く	自動詞	\N	\N	\N	1216	\N
136	ganz	非常に	副詞	\N	\N	\N	1216	\N
145	gern	好んで	副詞	\N	\N	\N	1216	\N
257	dahin	そこへ	副詞	\N	\N	\N	1216	\N
79	wie	どのように 	疑問副詞 	\N	\N	\N	1217	\N
258	hat's		動詞＋人称代名詞（１格）	\N	\N	\N	1217	\N
31	dir	君 	人称代名詞（３格）	\N	\N	\N	1217	\N
149	gefallen	…（３格）の気に入る	自動詞（過去分詞）	\N	\N	\N	1217	\N
77	Echt	本当に	副詞	\N	\N	\N	1218	\N
259	gemütlich	居心地のいい	形容詞	\N	\N	\N	1218	\N
260	Wie oft	どれほど頻繁に	成句	\N	\N	\N	1219	\N
69	bist	いる	自動詞	\N	\N	\N	1219	\N
54	denn	一体	副詞	\N	\N	\N	1219	\N
261	vielleicht	だいたい	副詞 	\N	\N	\N	1220	\N
262	einmal	一度 	副詞 	\N	\N	\N	1220	\N
263	pro	…につき 	前置詞（４格と）	\N	\N	\N	1220	\N
235	Woche	週 	女性名詞	\N	\N	\N	1220	\N
206	so	そんなに 	副詞 	\N	\N	\N	1221	\N
264	oft	頻繁に	副詞	\N	\N	\N	1221	\N
265	Die	彼らは	指示代名詞（複数１格）	\N	\N	\N	1222	\N
266	Happy-hour-Menüs	ハッピーアワーセット	中性名詞（複数４格） 	\N	\N	\N	1222	\N
267	Unter der Woche	平日に	成句	\N	\N	\N	1223	\N
268	bekommt	得る 	他動詞 	\N	\N	\N	1223	\N
269	zwischen	…と…の間に 	前置詞 	\N	\N	\N	1223	\N
270	Riesenportion	大盛り	女性名詞	\N	\N	\N	1223	\N
271	Portion	（飲食物の）一人前	女性名詞 	\N	\N	\N	1223	\N
272	Wiener Schnitzel	ウィーン風カツレツ	中性名詞 	\N	\N	\N	1223	\N
190	für	…（料金）で	前置詞（４格と）	\N	\N	\N	1223	\N
273	Was heißt ...	…とはどういうことか	成句	\N	\N	\N	1224	\N
274	groß	大きい	形容詞 	\N	\N	\N	1225	\N
254	so ～  wie ...	…のように～ 	成句 	\N	\N	\N	1225	\N
275	Teller	皿 	男性名詞 	\N	\N	\N	1225	\N
276	sogar	しかも 	副詞	\N	\N	\N	1225	\N
277	davon	それの	副詞 	\N	\N	\N	1225	\N
26	Das	それは	指示代名詞（４格）	\N	\N	\N	1227	\N
173	muss	しなくてはならない	話法の助動詞 	\N	\N	\N	1227	\N
75	mal	一度	副詞	\N	\N	\N	1227	\N
278	probieren	試す	他動詞	\N	\N	\N	1227	\N
279	Zeit	時間	女性名詞	\N	\N	\N	1228	\N
280	heute Abend	今晩	成句	\N	\N	\N	1228	\N
281	fängt ... an	始まる	分離動詞	\N	\N	\N	1229	\N
23	dein	君の	所有冠詞（中性１格）	\N	\N	\N	1229	\N
234	nächstes	次の	形容詞（中性１格）	\N	\N	\N	1229	\N
282	Seminar	ゼミナール	中性名詞（１格）	\N	\N	\N	1229	\N
283	Um	…（時刻）に	前置詞（４格と）	\N	\N	\N	1230	\N
284	Viertel	15分	中性名詞（４格）	\N	\N	\N	1230	\N
216	nach	…後	前置詞（３格と）	\N	\N	\N	1230	\N
254				\N	\N	\N	1231	\N
285	Hast ...'s eilig	急いでいる	成句	\N	\N	\N	1232	\N
286	Nee	ううん	間投詞	\N	\N	\N	1233	\N
287	gar nicht	全く…ない	成句	\N	\N	\N	1233	\N
288	keine	…がない	否定冠詞（複数４格）	\N	\N	\N	1234	\N
289	Veranstaltungen	授業	女性名詞（複数４格）	\N	\N	\N	1234	\N
158	mehr	もう（…ない）	副詞	\N	\N	\N	1234	\N
254	Wie spät ist es jetzt?	今何時ですか？	成句	\N	\N	\N	1235	\N
290	Erst	まだ，ようやく	副詞	\N	\N	\N	1236	\N
129	hab'	持っている	他動詞	\N	\N	\N	1237	\N
32	noch	まだ	副詞	\N	\N	\N	1237	\N
291	etwa	ほぼ	副詞	\N	\N	\N	1237	\N
292	'ne  eine	１	数詞	\N	\N	\N	1237	\N
179	Stunde	（１）時間	女性名詞（４格）	\N	\N	\N	1237	\N
254				\N	\N	\N	1238	\N
181	geh'n	行く	自動詞	\N	\N	\N	1239	\N
292	'nen  einen	ひとつの	数詞（男性４格）	\N	\N	\N	1239	\N
140	trinken	飲む	他動詞（不定形）	\N	\N	\N	1239	\N
293	gerne	好んで	副詞	\N	\N	\N	1240	\N
294	ins	…（の中）へ	前置詞＋定冠詞（中性４格）	\N	\N	\N	1241	\N
295	bleiben	とどまる	自動詞	\N	\N	\N	1241	\N
296	Uni	大学	女性名詞（３格）	\N	\N	\N	1241	\N
297	bis zum	…まで	前置詞＋前置詞＋定冠詞	\N	\N	\N	1242	\N
298	Stadt-Café	シュタットカフェ	中性名詞（３格）	\N	\N	\N	1242	\N
157	brauchen	必要とする	他動詞	\N	\N	\N	1242	\N
299	bestimmt	きっと	副詞	\N	\N	\N	1242	\N
292	'ne  eine	一つの	数詞（女性４格）	\N	\N	\N	1242	\N
300	Vietelstunde	15分	女性名詞（４格）	\N	\N	\N	1242	\N
301	Setzen ... uns	座る	再帰動詞	\N	\N	\N	1243	\N
86	doch	ねえ	副詞	\N	\N	\N	1243	\N
302	draußen	外で	副詞	\N	\N	\N	1243	\N
112	auf	…上で	前置詞（３格と）	\N	\N	\N	1243	\N
303	Rasen	芝生	男性名詞（３格）	\N	\N	\N	1243	\N
90	Gute	良い	形容詞（女性１格）	\N	\N	\N	1244	\N
91	Idee	考え	女性名詞	\N	\N	\N	1244	\N
70	Wetter	天気	中性名詞	\N	\N	\N	1245	\N
114	ja	確かに	副詞	\N	\N	\N	1245	\N
77	echt	本当に	副詞	\N	\N	\N	1245	\N
254				\N	\N	\N	1246	\N
129	hab'	持っている	他動詞	\N	\N	\N	1247	\N
75	mal	ちょっと	副詞	\N	\N	\N	1247	\N
304	Frage	質問	女性名詞（４格）	\N	\N	\N	1247	\N
305	Wie viele	いくつの	成句	\N	\N	\N	1248	\N
133	Bücher	本	中性名詞（複数４格）	\N	\N	\N	1248	\N
306	darf	…してもよい（許可）	話法の助動詞	\N	\N	\N	1248	\N
254	auf einmal	一度に	成句	\N	\N	\N	1248	\N
307	ausleihen	借りる	分離動詞	\N	\N	\N	1248	\N
117	können	…できる	話法の助動詞	\N	\N	\N	1249	\N
254	bis zu	…まで	前置詞＋前置詞	\N	\N	\N	1249	\N
148	Wollen	…したい	話法の助動詞	\N	\N	\N	1250	\N
265	die	それらを	指示代名詞（複数４格）	\N	\N	\N	1250	\N
254				\N	\N	\N	1251	\N
18	Dann	それでは	副詞	\N	\N	\N	1252	\N
157	brauche	必要とする	他動詞	\N	\N	\N	1252	\N
75	mal	ちょっと	副詞	\N	\N	\N	1252	\N
40	Ihren	あなたの	所有冠詞（男性４格）	\N	\N	\N	1252	\N
308	Bibliotheksausweis	図書館IDカード	男性名詞（４格）	\N	\N	\N	1252	\N
50	bitte schön	どうぞ	成句	\N	\N	\N	1253	\N
309	Wie lange	どのくらい長く	成句	\N	\N	\N	1256	\N
117	kann	…できる	話法の助動詞	\N	\N	\N	1256	\N
310	behalten	持っておく	他動詞	\N	\N	\N	1256	\N
311	Monate	月	男性名詞（複数４格）	\N	\N	\N	1257	\N
312	Also	つまり	副詞	\N	\N	\N	1258	\N
254	bis zum  bis zu dem	…まで	前置詞＋前置詞＋定冠詞	\N	\N	\N	1258	\N
313	Januar	１月	男性名詞	\N	\N	\N	1258	\N
254				\N	\N	\N	1259	\N
254				\N	\N	\N	1260	\N
254				\N	\N	\N	1261	\N
254				\N	\N	\N	1262	\N
314	Was ... für	どんな…	成句	\N	\N	\N	1263	\N
54	denn	一体	副詞	\N	\N	\N	1263	\N
315	Stäbchen	小さな棒，箸	中性名詞（複数１格）	\N	\N	\N	1263	\N
316	Essstäbchen	箸	中性名詞（複数１格）	\N	\N	\N	1264	\N
146	Das	それ	指示代名詞（中性４格）	\N	\N	\N	1265	\N
3	sehe	…（４格）がわかる	他動詞	\N	\N	\N	1265	\N
317	warum	なぜ	疑問副詞	\N	\N	\N	1265	\N
206	so	そんなに	副詞	\N	\N	\N	1265	\N
318	japanische	日本の	形容詞（複数１格）	\N	\N	\N	1266	\N
319	kürzer	より短い	形容詞（比較級）	\N	\N	\N	1266	\N
118	als	…より	接続詞	\N	\N	\N	1266	\N
219	chinesischen	中国の	形容詞（複数１格）	\N	\N	\N	1266	\N
117	Kannst	…できる	話法の助動詞	\N	\N	\N	1267	\N
162	eigentlich	ところで	副詞	\N	\N	\N	1267	\N
164	mit	…（道具）で	前置詞（３格と）	\N	\N	\N	1267	\N
320	essen	食べる	自動詞	\N	\N	\N	1267	\N
286	Nee	いいえ（口語）	間投詞	\N	\N	\N	1268	\N
254	nicht so	それほど…でない	成句	\N	\N	\N	1268	\N
72	richtig	正しい，きちんとした	形容詞	\N	\N	\N	1268	\N
79	Wie	どのように	疑問副詞	\N	\N	\N	1269	\N
321	hält	持つ	持つ	\N	\N	\N	1269	\N
79	Wie	…のように	接続詞	\N	\N	\N	1270	\N
322	Kuli	ボールペン	男性名詞	\N	\N	\N	1270	\N
323	Ringfinger	薬指	男性名詞	\N	\N	\N	1270	\N
324	stützt	支える	他動詞	\N	\N	\N	1270	\N
325	untere	下の	形容詞	\N	\N	\N	1270	\N
206	So	このように	副詞	\N	\N	\N	1271	\N
72	richtig	正しい	形容詞	\N	\N	\N	1271	\N
326	womit	何でもって(mit + was)	副詞	\N	\N	\N	1272	\N
320	isst	食べる	他動詞	\N	\N	\N	1272	\N
327	Tofu	Tofu	男性（中性）名詞	\N	\N	\N	1272	\N
291	Etwa	ひょっとして	副詞	\N	\N	\N	1273	\N
328	damit	それで	副詞	\N	\N	\N	1273	\N
329	klar	当たり前だ	形容詞	\N	\N	\N	1274	\N
330	Versuch	試みる	他動詞（命令形）	\N	\N	\N	1275	\N
203	nehm'	使う	他動詞	\N	\N	\N	1276	\N
145	lieber	より好んで	副詞（比較級）	\N	\N	\N	1276	\N
331	'ne	ある（一つの）	不定冠詞（女性４格）	\N	\N	\N	1276	\N
332	Gabel	フォーク	女性名詞	\N	\N	\N	1276	\N
117	kannst	…（４格）ができる	他動詞	\N	\N	\N	1277	\N
86	doch	…よね（確認）	副詞	\N	\N	\N	1277	\N
98	oder	そうでしょう	並列接続詞	\N	\N	\N	1277	\N
333	ein bisschen	少し	成句	\N	\N	\N	1278	\N
117	Kannst	…できる	話法の助動詞	\N	\N	\N	1279	\N
54	denn	それじゃあ	副詞	\N	\N	\N	1279	\N
334	Chinesisch	中国語	中性名詞	\N	\N	\N	1279	\N
144	lesen	読む	他動詞	\N	\N	\N	1279	\N
335	Kaum	ほとんど…ない	副詞	\N	\N	\N	1280	\N
129	hab'		完了の助動詞	\N	\N	\N	1281	\N
336	nie	一度も…ない	副詞	\N	\N	\N	1281	\N
337	gelernt	学ぶ，習う	他動詞	\N	\N	\N	1281	\N
254	im Japanischen	日本語で	成句	\N	\N	\N	1281	\N
338	benutzt	使う	他動詞	\N	\N	\N	1281	\N
114	ja	確かに	副詞	\N	\N	\N	1281	\N
219	chinesischen	中国の	形容詞（複数４格）	\N	\N	\N	1281	\N
339	Schriftzeichen	文字	中性名詞（複数４格）	\N	\N	\N	1281	\N
254				\N	\N	\N	1282	\N
254				\N	\N	\N	1283	\N
18	Dann	それなら	副詞	\N	\N	\N	1284	\N
25	mir	私	人称代名詞（３格）	\N	\N	\N	1284	\N
261	vielleicht	ひょっとしたら	副詞	\N	\N	\N	1284	\N
86	doch	やはり（期待）	副詞	\N	\N	\N	1284	\N
187	helfen	…（３格）を手伝う，助ける	自動詞	\N	\N	\N	1284	\N
340	Wobei	何の際に (bei + was)	疑問副詞	\N	\N	\N	1285	\N
129	hab'		完了の助動詞	\N	\N	\N	1286	\N
219	chinesischen	中国の	形容詞（男性４格）	\N	\N	\N	1286	\N
341	Tee	お茶	男性名詞	\N	\N	\N	1286	\N
155	geschenkt	プレゼントする	他動詞（過去分詞）	\N	\N	\N	1286	\N
268	bekommen	もらう	他動詞（過去分詞）	\N	\N	\N	1286	\N
146	Der	それは	指示代名詞（男性１格）	\N	\N	\N	1287	\N
342	schmeckt	味がする	自動詞	\N	\N	\N	1287	\N
127	wirklich	本当に	副詞	\N	\N	\N	1287	\N
343	super	すごい	形容詞	\N	\N	\N	1287	\N
344	möchte	…したい	話法の助動詞	\N	\N	\N	1288	\N
145	gern	好んで	副詞	\N	\N	\N	1288	\N
345	wissen	知る	他動詞	\N	\N	\N	1288	\N
8	was	何が	疑問代名詞	\N	\N	\N	1288	\N
346	drin	その中に（口語）	副詞	\N	\N	\N	1288	\N
347	Zutaten	材料	女性名詞(複数４格）	\N	\N	\N	1288	\N
348	kann's			\N	\N	\N	1290	\N
75	mal	ちょっと	副詞	\N	\N	\N	1290	\N
330	versuchen	試す	他動詞	\N	\N	\N	1290	\N
349	nur wenn	…するときのみ	成句	\N	\N	\N	1290	\N
278	probieren	試飲する	他動詞	\N	\N	\N	1290	\N
306	darf	…してもよい（許可）	話法の助動詞	\N	\N	\N	1290	\N
36	Entschuldigung	すみません（＜許し）	女性名詞	\N	\N	\N	1291	\N
350	gibt es	…（４格）がある	成句	\N	\N	\N	1291	\N
254	in der Nähe	近くに	成句	\N	\N	\N	1291	\N
351	Kopierer	コピー機	男性名詞	\N	\N	\N	1291	\N
352	Kopierraum	コピー室	男性名詞	\N	\N	\N	1292	\N
254	im  in dem	…（の中）に	前置詞＋定冠詞（男性・中性３格）	\N	\N	\N	1292	\N
290	ersten	第１の	数詞	\N	\N	\N	1292	\N
353	Stock	階	男性名詞	\N	\N	\N	1292	\N
354	gehen ... hoch	上へ行く	分離動詞	\N	\N	\N	1293	\N
355	Treppe	階段	女性名詞	\N	\N	\N	1293	\N
18	dann	それから	副詞	\N	\N	\N	1293	\N
356	geradeaus	まっすぐ	副詞	\N	\N	\N	1293	\N
112	auf	…（の上）に	前置詞（３格と）	\N	\N	\N	1294	\N
357	rechten	右の	形容詞	\N	\N	\N	1294	\N
358	Seite	側	女性名詞	\N	\N	\N	1294	\N
29	schon	もう	副詞	\N	\N	\N	1294	\N
254				\N	\N	\N	1295	\N
157	braucht	必要とする	他動詞	\N	\N	\N	1296	\N
66	da	そこで	副詞	\N	\N	\N	1296	\N
359	Kopierkarte	コピーカード	女性名詞	\N	\N	\N	1296	\N
265	die	それを	指示代名詞（女性４格）	\N	\N	\N	1297	\N
29	schon	まさに，確かに	副詞	\N	\N	\N	1297	\N
254				\N	\N	\N	1298	\N
52	wo	どこで	疑問副詞	\N	\N	\N	1299	\N
117	kann	…できる	話法の助動詞	\N	\N	\N	1299	\N
360	kaufen	買う	他動詞	\N	\N	\N	1299	\N
361	Gebäude	建物	中性名詞	\N	\N	\N	1300	\N
362	neben	…の隣に	前置詞（３格と）	\N	\N	\N	1301	\N
363	Haupteingang	正面入り口	男性名詞	\N	\N	\N	1301	\N
364	Kopierecke	コピーコーナー	女性名詞	\N	\N	\N	1301	\N
365	dort	そこに	副詞	\N	\N	\N	1301	\N
366	Kartenautomat	カードの自動販売機	男性名詞	\N	\N	\N	1301	\N
254				\N	\N	\N	1302	\N
367	gern geschehen	どういたしまして	成句	\N	\N	\N	1303	\N
69	warst	いる	自動詞（過去形）	\N	\N	\N	1304	\N
261	vielleicht	もしかしたら	副詞	\N	\N	\N	1304	\N
368	schon mal	これまでに一度	成句	\N	\N	\N	1304	\N
96	Vorlesung	講義	女性名詞	\N	\N	\N	1304	\N
369	Einführung	導入	女性名詞	\N	\N	\N	1304	\N
370	Kunstgeschichte	美術史	女性名詞	\N	\N	\N	1304	\N
39	glaube	思う	動詞	\N	\N	\N	1305	\N
265	Die	それは	指示代名詞（女性１格）	\N	\N	\N	1306	\N
86	doch	でしょう	副詞	\N	\N	\N	1306	\N
24	von	…の	前置詞（３格と）	\N	\N	\N	1306	\N
98	oder	そうでしょう	並列接続詞	\N	\N	\N	1306	\N
371	genau	その通り	副詞	\N	\N	\N	1307	\N
372	überlege	よく考える	他動詞	\N	\N	\N	1308	\N
10	jetzt	今	副詞	\N	\N	\N	1308	\N
373	ob	…かどうか	従属接続詞	\N	\N	\N	1308	\N
89	hingehe	（そこに）行く	自動詞	\N	\N	\N	1308	\N
79	Wie	どのような	疑問副詞	\N	\N	\N	1309	\N
69	war	…である	自動詞	\N	\N	\N	1309	\N
54	denn	いったい	副詞	\N	\N	\N	1309	\N
46	sehr	とても	副詞	\N	\N	\N	1310	\N
212	interessant	興味深い	形容詞	\N	\N	\N	1310	\N
254				\N	\N	\N	1311	\N
47	nett	親切な	形容詞	\N	\N	\N	1312	\N
374	spricht	話す	動詞	\N	\N	\N	1313	\N
375	zwar	確かに	副詞	\N	\N	\N	1313	\N
163	immer	いつも	副詞	\N	\N	\N	1313	\N
376	ziemlich	かなり	副詞	\N	\N	\N	1313	\N
377	schnell	速い	形容詞	\N	\N	\N	1313	\N
378	nee	ううん	間投詞	\N	\N	\N	1313	\N
127	wirklich	本当に	副詞	\N	\N	\N	1313	\N
379	Exkursion	課外授業	女性名詞	\N	\N	\N	1314	\N
12	zu	…（場所）へ	前置詞（３格と）	\N	\N	\N	1314	\N
380	Museum	美術館	中性名詞	\N	\N	\N	1314	\N
9	gemacht	する	他動詞（過去分詞）	\N	\N	\N	1314	\N
69	war	…である	自動詞（過去形）	\N	\N	\N	1314	\N
381	hört sich ... an	…に聞こえる	分離動詞・再帰動詞	\N	\N	\N	1315	\N
114	ja	だね	副詞	\N	\N	\N	1315	\N
382	schlecht	悪い	形容詞	\N	\N	\N	1315	\N
18	Dann	それでは	副詞	\N	\N	\N	1316	\N
383	werde	…つもりだ	未来の助動詞	\N	\N	\N	1316	\N
384	wohl	おそらく	副詞	\N	\N	\N	1316	\N
385	besuchen	訪れる	他動詞	\N	\N	\N	1316	\N
9	mach	する	他動詞（命令形）	\N	\N	\N	1317	\N
86	doch	（…しな）よ（促し）	副詞	\N	\N	\N	1317	\N
95	findet ... statt	行われる	分離動詞	\N	\N	\N	1318	\N
386	jedes	毎	指示冠詞（中性４格）	\N	\N	\N	1318	\N
387	Semester	学期	中性名詞	\N	\N	\N	1318	\N
37	meine	…と思う	他動詞	\N	\N	\N	1319	\N
136	ganz	全く	副詞	\N	\N	\N	1320	\N
371	genau	正確に	副詞	\N	\N	\N	1320	\N
345	weiß	知っている	他動詞	\N	\N	\N	1320	\N
388	ich's			\N	\N	\N	1320	\N
389	wer	誰が	疑問代名詞	\N	\N	\N	1321	\N
198	soll	…すべきだ	話法の助動詞	\N	\N	\N	1321	\N
390	bloß	一体	副詞	\N	\N	\N	1321	\N
391	Mitbewohnerin	同居人	女性名詞	\N	\N	\N	1321	\N
383	werden	…（１格）になる	自動詞	\N	\N	\N	1321	\N
392	Tja	そうだなあ	間投詞	\N	\N	\N	1322	\N
393	schwere	難しい	形容詞	\N	\N	\N	1322	\N
304	Frage	質問	女性名詞	\N	\N	\N	1322	\N
55	fand	思う	他動詞（過去形）	\N	\N	\N	1323	\N
394	irgendwie	なんとなく	副詞	\N	\N	\N	1323	\N
395	alle	みんな	不定代名詞（複数1格）	\N	\N	\N	1323	\N
376	ziemlich	かなり	副詞	\N	\N	\N	1323	\N
47	nett	感じの良い	形容詞	\N	\N	\N	1323	\N
254				\N	\N	\N	1324	\N
162	eigentlich	実際	副詞	\N	\N	\N	1325	\N
396	am lockersten	気楽な	形容詞	\N	\N	\N	1325	\N
55	findest	思う	他動詞	\N	\N	\N	1325	\N
265	die	彼女は	指示代名詞（女性1格）	\N	\N	\N	1326	\N
117	könnte	…できる	話法の助動詞（接続法第2式）	\N	\N	\N	1326	\N
397	sich ... einleben	住み慣れる	再帰動詞	\N	\N	\N	1326	\N
398	WG	共同居住グループ	女性名詞	\N	\N	\N	1326	\N
146	der	彼女に	指示代名詞（女性3画）	\N	\N	\N	1326	\N
399	hätten ... Spaß	楽しむ	成句	\N	\N	\N	1326	\N
82	stimmt	正しい	自動詞	\N	\N	\N	1327	\N
400	Allerdings	もちろん	副詞	\N	\N	\N	1328	\N
401	mir ... vorstellen	想像する	他動詞	\N	\N	\N	1328	\N
69	war	…である	自動詞（過去形）	\N	\N	\N	1329	\N
86	doch	だよ	副詞	\N	\N	\N	1329	\N
402	witzig	おもしろい	形容詞	\N	\N	\N	1329	\N
8	was	…するところのもの	関係代名詞	\N	\N	\N	1330	\N
90	besser	良い	形容詞	\N	\N	\N	1331	\N
164	mit	…と	前置詞（３格と）	\N	\N	\N	1331	\N
20	zusammen	一緒に	副詞	\N	\N	\N	1331	\N
151	Wenn	…のとき	従属接続詞	\N	\N	\N	1332	\N
84	jemand	誰かが	不定代名詞	\N	\N	\N	1332	\N
173	muss	…しなくてはならない	話法の助動詞	\N	\N	\N	1332	\N
146	der	その人が	指示代名詞	\N	\N	\N	1332	\N
403	früh	朝早く	副詞	\N	\N	\N	1332	\N
404	aufstehen	起きる	分離動詞	\N	\N	\N	1332	\N
254				\N	\N	\N	1333	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1334	\N
405	Italienerin	イタリア人	女性名詞	\N	\N	\N	1334	\N
149	gefallen	…（３格）の気に入る	j3 gefallen自動詞	\N	\N	\N	1334	\N
254				\N	\N	\N	1335	\N
254				\N	\N	\N	1336	\N
77	echt	本当に	副詞	\N	\N	\N	1337	\N
406	erstaunlich	驚くべき	形容詞	\N	\N	\N	1337	\N
374	gesprochen	話す	他動詞	\N	\N	\N	1337	\N
127	wirklich	本当に	副詞	\N	\N	\N	1338	\N
148	wollte	…するつもりだ	話法の助動詞（過去形）	\N	\N	\N	1339	\N
407	natürlich	もちろん	副詞	\N	\N	\N	1339	\N
311	Monate	（ヵ）月	男性名詞	\N	\N	\N	1339	\N
408	einziehen	入居する	分離動詞	\N	\N	\N	1339	\N
2	lange	長く	形容詞	\N	\N	\N	1340	\N
173	müssen	…しなくてはならない	話法の助動詞	\N	\N	\N	1340	\N
409	bald	まもなく	副詞	\N	\N	\N	1340	\N
84	jemanden	誰かを	不定代名詞（4格）	\N	\N	\N	1340	\N
345	weiß	知っている	他動詞	\N	\N	\N	1341	\N
410	sich ... entscheiden	決定する	再帰動詞	\N	\N	\N	1342	\N
254				\N	\N	\N	1343	\N
198	sollten	…すべきだ	話法の助動詞	\N	\N	\N	1344	\N
154	einfach	とにかく	副詞	\N	\N	\N	1344	\N
411	drüber	それについて	副詞	\N	\N	\N	1344	\N
412	magst	好き	他動詞	\N	\N	\N	1345	\N
162	eigentlich	ところで	副詞	\N	\N	\N	1345	\N
145	lieber	より好んで	副詞（比較級）	\N	\N	\N	1345	\N
98	oder	それとも	並列接続詞	\N	\N	\N	1345	\N
254	auf jeden Fall	とにかく	成句	\N	\N	\N	1346	\N
145	am liebsten	最も好んで	副詞（最上級）	\N	\N	\N	1347	\N
413	Milchkaffee	ミルクコーヒー	男性名詞	\N	\N	\N	1347	\N
254				\N	\N	\N	1348	\N
140	trinke	飲む	他動詞	\N	\N	\N	1349	\N
414	schwarzen Tee	紅茶	形容詞＋男性名詞（４格）	\N	\N	\N	1349	\N
383	werde	…つもりだ	未来の助動詞	\N	\N	\N	1350	\N
384	wohl	（たぶん）…かな	副詞	\N	\N	\N	1350	\N
75	mal	ちょっと	副詞	\N	\N	\N	1350	\N
415	Kamillentee	カモミールティー	男性名詞	\N	\N	\N	1350	\N
203	nehmen	（選んで）…にする他動詞		\N	\N	\N	1350	\N
416	erkältet	風邪をひいている	形容詞	\N	\N	\N	1351	\N
417	sieht ... aus	…らしい	分離動詞	\N	\N	\N	1352	\N
206	so	そう	副詞	\N	\N	\N	1352	\N
208	seit	…以来	前置詞（３格と）	\N	\N	\N	1353	\N
418	gestern	昨日	副詞	\N	\N	\N	1353	\N
419	tut mir ... weh	痛い	成句	\N	\N	\N	1353	\N
420	nämlich	というのも，つまり	副詞	\N	\N	\N	1353	\N
421	Hals	のど	男性名詞	\N	\N	\N	1353	\N
376	ziemlich	かなり	副詞	\N	\N	\N	1353	\N
422	Arme	かわいそうな人	名詞（形容詞変化）	\N	\N	\N	1354	\N
423	hoffentlich	…であるといいが	副詞	\N	\N	\N	1355	\N
424	geht ... weg	（痛みなどが）消える	分離動詞	\N	\N	\N	1355	\N
377	schnell	すぐの	形容詞	\N	\N	\N	1355	\N
425	wieder	再び	副詞	\N	\N	\N	1355	\N
161	hoffe	望む	他動詞	\N	\N	\N	1356	\N
148	willst	欲しい	他動詞	\N	\N	\N	1357	\N
32	noch	まだ，他に	副詞	\N	\N	\N	1357	\N
426	Apfelkuchen	リンゴケーキ	男性名詞	\N	\N	\N	1357	\N
254				\N	\N	\N	1358	\N
291	etwa	ひょっとして	副詞	\N	\N	\N	1359	\N
427	Hunger	空腹	男性名詞	\N	\N	\N	1359	\N
428	Stück	一切れ	中性名詞	\N	\N	\N	1360	\N
117	könnte	…かもしれない	助動詞接続法第２式	\N	\N	\N	1360	\N
79	wie	どのように	疑問副詞	\N	\N	\N	1361	\N
162	eigentlich	ところで	副詞	\N	\N	\N	1361	\N
164	mit	…に関して	前置詞（３格と）	\N	\N	\N	1361	\N
31	dir	君	人称代名詞（３格）	\N	\N	\N	1361	\N
9	machst	する	他動詞	\N	\N	\N	1361	\N
429	Sport	スポーツ	男性名詞	\N	\N	\N	1361	\N
329	klar	もちろん	副詞	\N	\N	\N	1362	\N
9	mach'	する	他動詞	\N	\N	\N	1362	\N
145	gern	好んで	副詞	\N	\N	\N	1362	\N
430	Aerobic	エアロビクス	中性名詞	\N	\N	\N	1362	\N
431	schwimme	泳ぐ	自動詞	\N	\N	\N	1362	\N
264	oft	しばしば	副詞	\N	\N	\N	1362	\N
317	Warum	なぜ	疑問副詞	\N	\N	\N	1363	\N
432	fragst	尋ねる	他動詞	\N	\N	\N	1363	\N
86	doch	…だよ	副詞	\N	\N	\N	1364	\N
433	mittwochs	毎水曜日に	副詞	\N	\N	\N	1364	\N
163	immer	いつも	副詞副詞	\N	\N	\N	1364	\N
333	ein bisschen	ちょっと	成句	\N	\N	\N	1364	\N
434	Volleyball	バレーボール	男性名詞	\N	\N	\N	1364	\N
435	Sportzentrum	スポーツセンター	中性名詞	\N	\N	\N	1364	\N
129	Hättest	持つ	他動詞（接続法第２式）	\N	\N	\N	1365	\N
66	da	（前文を受けて）それで	副詞	\N	\N	\N	1365	\N
436	Lust	する気	女性名詞	\N	\N	\N	1365	\N
75	mal	ちょっと	副詞	\N	\N	\N	1365	\N
437	mitzumachen	参加する	動詞（zu不定詞）	\N	\N	\N	1365	\N
254	weißt du	あのね	成句	\N	\N	\N	1366	\N
4	na	ねえ	間投詞	\N	\N	\N	1367	\N
28	komm	さあ（誘いかけ）	成句	\N	\N	\N	1367	\N
288	keine	…でない	否定冠詞（複数形）	\N	\N	\N	1367	\N
438	Profis	プロ選手	男性名詞（複数形）	\N	\N	\N	1367	\N
286	nee	ううん	間投詞	\N	\N	\N	1368	\N
254	tut mir Leid	残念ですが	成句	\N	\N	\N	1368	\N
439	andere	ほかの	形容詞	\N	\N	\N	1369	\N
440	Sportarten	スポーツ種目	女性名詞	\N	\N	\N	1369	\N
293	gerne	好んで	副詞	\N	\N	\N	1369	\N
441	Ballsport	球技	中性名詞	\N	\N	\N	1369	\N
57	nichts	なにものでもない	不定代名詞	\N	\N	\N	1369	\N
254	na ja	まあいいよ	成句	\N	\N	\N	1370	\N
442	macht ... nichts	気にしないで	成句	\N	\N	\N	1370	\N
114	ja	まあ	人称代名詞（３格）	\N	\N	\N	1370	\N
443	Fährst ... Ski	スキーを滑る	成句	\N	\N	\N	1371	\N
54	denn	一体	副詞	\N	\N	\N	1371	\N
276	sogar	そのうえ	副詞	\N	\N	\N	1372	\N
444	Snowboard	スノーボード	中性（男性）名詞	\N	\N	\N	1373	\N
227	toll	すばらしい	形容詞	\N	\N	\N	1374	\N
86	doch	ぜひ	副詞	\N	\N	\N	1375	\N
75	mal	一度	副詞	\N	\N	\N	1375	\N
445	Winter	冬	男性名詞	\N	\N	\N	1375	\N
446	St. Anton	ザンクトアントン	固有名詞（地名）	\N	\N	\N	1375	\N
385	besuchen	訪問する	他動詞	\N	\N	\N	1375	\N
66	da	そこで	副詞	\N	\N	\N	1376	\N
420	nämlich	というのも	副詞	\N	\N	\N	1376	\N
447	Onkel	おじ	男性名詞	\N	\N	\N	1376	\N
448	den	その人を	指示代名詞	\N	\N	\N	1376	\N
254	jedes Jahr	毎年	成句	\N	\N	\N	1376	\N
254				\N	\N	\N	1377	\N
66	da	そこで	副詞	\N	\N	\N	1378	\N
254				\N	\N	\N	1379	\N
117	kannst	…することができる	話法の助動詞	\N	\N	\N	1380	\N
25	mir	私	人称代名詞（３格）	\N	\N	\N	1380	\N
75	mal	ちょっと	副詞	\N	\N	\N	1380	\N
187	helfen	…（３格）を手伝う	動詞	\N	\N	\N	1380	\N
329	klar	明らかだ，あたりまえだ	形容詞	\N	\N	\N	1381	\N
412	möchte	…したい	話法の助動詞	\N	\N	\N	1382	\N
358	Seite	ページ	女性名詞	\N	\N	\N	1382	\N
449	vergrößern	拡大する	非分離動詞	\N	\N	\N	1382	\N
345	weiß	知っている	動詞	\N	\N	\N	1383	\N
79	wie	どのように	疑問副詞	\N	\N	\N	1383	\N
181	geht	（機械・装置などが）動く，作動する	動詞	\N	\N	\N	1383	\N
162	eigentlich	本当は	副詞	\N	\N	\N	1384	\N
136	ganz	非常に	副詞	\N	\N	\N	1384	\N
154	einfach	簡単だ	形容詞	\N	\N	\N	1384	\N
450	legst ... auf	上に載せる，置く	分離動詞	\N	\N	\N	1385	\N
451	Blatt	紙，シート	中性名詞	\N	\N	\N	1385	\N
79	wie	どのように	疑問副詞	\N	\N	\N	1386	\N
274	groß	大きい	形容詞	\N	\N	\N	1386	\N
198	soll	…べきである	話法の助動詞	\N	\N	\N	1386	\N
54	denn	いったい	副詞	\N	\N	\N	1386	\N
383	werden\n\n	…になる	動詞	\N	\N	\N	1386	\N
452	DIN	ドイツ工業規格（Deutsche Industrie-Normen）	名詞・略語	\N	\N	\N	1387	\N
39	glaub'	思う，考える	動詞	\N	\N	\N	1389	\N
453	reicht	達する，十分である	動詞	\N	\N	\N	1389	\N
18	dann	それから，その次に	副詞	\N	\N	\N	1390	\N
454	stellst ... ein	調節する，セットする	分離動詞	\N	\N	\N	1390	\N
455	Größe	大きさ	女性名詞	\N	\N	\N	1390	\N
456	Moment	瞬間，ほんのちょっとの間	男性名詞	\N	\N	\N	1391	\N
75	mal	（命令文での要請の表現を和らげて）ちょっと	副詞	\N	\N	\N	1391	\N
112	auf	（変化の結果）…に	前置詞（４格と）	\N	\N	\N	1391	\N
457	drücken	押す	動詞	\N	\N	\N	1393	\N
112	auf	…（の上）を	前置詞（４格と）	\N	\N	\N	1393	\N
371	genau	ちょうど	形容詞	\N	\N	\N	1393	\N
79	wie	…のように	接続詞	\N	\N	\N	1393	\N
458	beim	…のときに，…の際に	前置詞（３格と）	\N	\N	\N	1393	\N
503	Sache	事情，問題	女性名詞	\N	\N	\N	1440	\N
265	die	それ	指示代名詞（女性１格）	\N	\N	\N	1440	\N
466	Bei	…のところに	前置詞（３格と）	\N	\N	\N	1441	\N
465	uns	私たち	人称代名詞（３格）	\N	\N	\N	1441	\N
59	in	…（場所）に	前置詞（３格と）	\N	\N	\N	1441	\N
504	WG	共同居住グループ	名詞・略語	\N	\N	\N	1441	\N
505	wohnt	住んでいる	動詞	\N	\N	\N	1441	\N
506	Japaner	日本人	男性名詞	\N	\N	\N	1441	\N
108	heißt	…という名前である	動詞	\N	\N	\N	1441	\N
146	der	その人は	指示代名詞（男性１格）	\N	\N	\N	1441	\N
318	japanisch	日本風の	形容詞	\N	\N	\N	1442	\N
378	Nein	いいえ	副詞	\N	\N	\N	1475	\N
507	am	…（時）に	前置詞＋定冠詞	\N	\N	\N	1442	\N
185	Wochenende	週末	中性名詞	\N	\N	\N	1442	\N
9	machen	する	動詞	\N	\N	\N	1442	\N
508	kleine	小さな	形容詞	\N	\N	\N	1442	\N
509	Fete	パーティー	女性名詞	\N	\N	\N	1442	\N
66	da	そこで	副詞	\N	\N	\N	1442	\N
492	kocht	料理をする	動詞	\N	\N	\N	1442	\N
312	Also	だから	副詞	\N	\N	\N	1443	\N
151	wenn	もし…ならば	従属接続詞	\N	\N	\N	1443	\N
279	Zeit	時間	女性名詞	\N	\N	\N	1443	\N
436	Lust	その気	女性名詞	\N	\N	\N	1443	\N
117	kannst	…してもよい	話法の助動詞	\N	\N	\N	1443	\N
28	kommen	来る	動詞	\N	\N	\N	1443	\N
293	gerne	喜んで	副詞	\N	\N	\N	1444	\N
312	Also	それでは	副詞	\N	\N	\N	1445	\N
151	wenn	何時に	疑問副詞	\N	\N	\N	1445	\N
170	treffen	…（４格）に会う	動詞	\N	\N	\N	1445	\N
465	uns	私たち	人称代名詞（４格）	\N	\N	\N	1445	\N
283	Um	…（時刻）に	前置詞	\N	\N	\N	1446	\N
62	Vor	…の前で	前置詞（３格と）	\N	\N	\N	1447	\N
510	Rathaus	市役所	中性名詞	\N	\N	\N	1447	\N
26	Das	それは	指示代名詞	\N	\N	\N	1450	\N
261	vielleicht	ひょっとしたら	成句	\N	\N	\N	1450	\N
333	'n bisschen ein bisschen	少し，ちょっと	成句	\N	\N	\N	1450	\N
403	früh	早い	形容詞	\N	\N	\N	1450	\N
81	Film	映画	男性名詞	\N	\N	\N	1451	\N
511	beginnt	始まる	動詞	\N	\N	\N	1451	\N
86	doch	…だよね（確認）	副詞	\N	\N	\N	1451	\N
290	erst	ようやく	副詞	\N	\N	\N	1451	\N
98	oder	…でしょう？（文末で）	並列接続詞	\N	\N	\N	1451	\N
344	möchte	…したい	話法の助動詞	\N	\N	\N	1452	\N
62	vor	…の前に	前置詞（３格）	\N	\N	\N	1452	\N
32	noch	まだ	副詞	\N	\N	\N	1452	\N
189	etwas	少し，いくらか	不定代名詞	\N	\N	\N	1452	\N
164	mit	…と一緒に	前置詞（３格と）	\N	\N	\N	1452	\N
31	dir	君	人称代名詞（３格）	\N	\N	\N	1452	\N
512	spazieren gehen	散歩する	動詞	\N	\N	\N	1452	\N
173	muss	…しなければならない	話法の助動詞	\N	\N	\N	1453	\N
513	vorher	その前に，前もって	副詞	\N	\N	\N	1453	\N
489	unbedingt	ぜひとも	副詞	\N	\N	\N	1453	\N
32	noch	まだ	副詞	\N	\N	\N	1453	\N
514	was	何か	不定代名詞	\N	\N	\N	1453	\N
320	essen	食べる	動詞	\N	\N	\N	1453	\N
77	echt	本当に	副詞	\N	\N	\N	1454	\N
515	Riesenhunger	ものすごい空服	男性名詞	\N	\N	\N	1454	\N
312	Also	それでは，じゃあ	副詞	\N	\N	\N	1455	\N
151	wenn	もし…ならば	従属接続詞	\N	\N	\N	1455	\N
148	willst	…したい	話法の助動詞	\N	\N	\N	1455	\N
117	kannst	…してもよい	話法の助動詞	\N	\N	\N	1455	\N
7	auch	…も	副詞	\N	\N	\N	1455	\N
466	bei	…のところで	前置詞（３格と）	\N	\N	\N	1455	\N
465	uns	私たち	人称代名詞（３格）	\N	\N	\N	1455	\N
516	ist ... in Ordung	問題ない	成句	\N	\N	\N	1457	\N
329	klar	明らかだ	形容詞	\N	\N	\N	1458	\N
26	das	それは	指示代名詞	\N	\N	\N	1460	\N
45	aber	とても	副詞	\N	\N	\N	1460	\N
47	nett	親切だ	形容詞	\N	\N	\N	1460	\N
392	Tja	ええと	間投詞	\N	\N	\N	1461	\N
198	soll	…するべきた	話法の助動詞	\N	\N	\N	1461	\N
18	dann	それでは	副詞	\N	\N	\N	1461	\N
517	vorbeikommen	立ち寄る	分離動詞	\N	\N	\N	1461	\N
254	ich würde sagen	私の考えでは（私なら…というだろう）	成句	\N	\N	\N	1462	\N
518	gegen	…頃に	前置詞	\N	\N	\N	1462	\N
90	Gut	いい，けっこうである	形容詞	\N	\N	\N	1464	\N
254	Bis dann	じゃあまた（その時まで）	成句	\N	\N	\N	1465	\N
317	Warum	なぜ，どうして	疑問副詞	\N	\N	\N	1467	\N
54	denn	いったい	副詞	\N	\N	\N	1467	\N
418	gestern	明日	副詞	\N	\N	\N	1467	\N
473	nicht	…ない	副詞	\N	\N	\N	1467	\N
254	zur  zu der	…に（行き先）	前置詞（３格と）	\N	\N	\N	1467	\N
509	Fete	パーティー	女性名詞	\N	\N	\N	1467	\N
28	gekommen	来る	動詞（過去分詞）	\N	\N	\N	1467	\N
254	das tut mir ... Leid	それは申し訳ない	成句	\N	\N	\N	1468	\N
127	wirklich	本当に	形容詞	\N	\N	\N	1468	\N
148	wollte	…するつもりだ	話法の助動詞（過去形）	\N	\N	\N	1469	\N
162	eigentlich	ほんとうは，もともとは	副詞	\N	\N	\N	1469	\N
28	kommen	来る	動詞	\N	\N	\N	1469	\N
45	aber	しかし	並列接続詞	\N	\N	\N	1469	\N
117	konnte	…することができる	話法の助動詞	\N	\N	\N	1469	\N
13	meine	私の	所有冠詞（女性１格）	\N	\N	\N	1471	\N
519	Mutter	母	女性名詞	\N	\N	\N	1471	\N
520	plötzlich	急に，いきなり	副詞	\N	\N	\N	1471	\N
521	krank	病気の	形容詞	\N	\N	\N	1471	\N
383	geworden	…になる	動詞（過去分詞）	\N	\N	\N	1471	\N
66	Da	それで	副詞	\N	\N	\N	1472	\N
173	musste	…しなければならない	話法の助動詞（過去形）	\N	\N	\N	1472	\N
190	für	…のために	前置詞（４格と）	\N	\N	\N	1472	\N
13	meinen	私の	所有冠詞（男性４格）	\N	\N	\N	1472	\N
508	kleinen	小さな，幼い	形容詞（男性４格）	\N	\N	\N	1472	\N
522	Bruder	弟，兄	男性名詞	\N	\N	\N	1472	\N
492	kochen	料理をする	動詞	\N	\N	\N	1472	\N
45	aber	しかし，でも	並列接続詞	\N	\N	\N	1474	\N
122	na ja 	まあいいか	間投詞	\N	\N	\N	1474	\N
129	hättest		完了の助動詞（接続法Ⅱ）	\N	\N	\N	1474	\N
7	auch	…も	副詞	\N	\N	\N	1474	\N
523	später	あとで	副詞	\N	\N	\N	1474	\N
28	kommen	来る	動詞	\N	\N	\N	1474	\N
117	können	…することができる	話法の助動詞	\N	\N	\N	1474	\N
181	ging	なんとかなる	動詞（過去形）	\N	\N	\N	1475	\N
13	meiner	私の	所有冠詞（女性３格）	\N	\N	\N	1475	\N
524	ging es 	…（３格）は調子が～だ	成句	\N	\N	\N	1475	\N
127	wirklich	本当に	副詞	\N	\N	\N	1475	\N
382	schlecht	悪い，健康でない	形容詞	\N	\N	\N	1475	\N
26	das	それを	指示代名詞（中性４格）	\N	\N	\N	1476	\N
345	wusste	知っている	動詞（過去形）	\N	\N	\N	1476	\N
465	uns	私たち	人称代名詞（４格）	\N	\N	\N	1477	\N
86	doch	それでも，やっぱり	副詞	\N	\N	\N	1477	\N
525	mindestens	せめて，少なくとも	副詞	\N	\N	\N	1477	\N
526	anrufen	…（４格）に電話をかける	分離動詞	\N	\N	\N	1477	\N
527	tut mir Leid	申し訳ない	成句	\N	\N	\N	1478	\N
528	unser	私たちの	所有冠詞（中性１格）	\N	\N	\N	1478	\N
529	Telefon	電話	中性名詞	\N	\N	\N	1478	\N
69	war	…である	動詞（過去形）	\N	\N	\N	1478	\N
530	kaputt	壊れた，故障した	副詞	\N	\N	\N	1478	\N
531	ausgerechnet	よりによって	副詞	\N	\N	\N	1478	\N
33	Abend	晩	男性名詞	\N	\N	\N	1478	\N
4	na	まあ	間投詞	\N	\N	\N	1479	\N
206	so	そのような	副詞	\N	\N	\N	1479	\N
532	Zufall	偶然	男性名詞	\N	\N	\N	1479	\N
345	weißt	知っている	動詞	\N	\N	\N	1480	\N
114	ja	…じゃないか	副詞	\N	\N	\N	1480	\N
111	dass	…ということ	従属接続詞	\N	\N	\N	1480	\N
288	kein	（ひとつも）…ない	否定冠詞	\N	\N	\N	1480	\N
533	Handy	携帯電話	中性名詞	\N	\N	\N	1480	\N
129	habe	持っている	動詞	\N	\N	\N	1480	\N
186	guten Tag	こんにちは	成句	\N	\N	\N	1481	\N
534	Herr	…さん（男性に対して）	男性名詞	\N	\N	\N	1481	\N
535	Frau	…さん（女性に対して），…夫人	女性名詞 	\N	\N	\N	1482	\N
92	hier	ここに	副詞 	\N	\N	\N	1483	\N
94	bitte	どうぞ	間投詞 	\N	\N	\N	1483	\N
301	setzen ... sich	座る	再帰動詞	\N	\N	\N	1483	\N
160	danke	ありがとう	間投詞	\N	\N	\N	1484	\N
536	um ... geht’ s  um ... geht es	…（４格）が問題だ	成句 	\N	\N	\N	1485	\N
8	was	何	疑問代名詞	\N	\N	\N	1485	\N
54	denn	いったい	副詞	\N	\N	\N	1485	\N
312	also	つまり	副詞	\N	\N	\N	1486	\N
129	hätte	持っている	動詞（接続法Ⅱ）	\N	\N	\N	1486	\N
66	da	それで	副詞	\N	\N	\N	1486	\N
537	Bitte	頼み，願い	女性名詞	\N	\N	\N	1486	\N
241	habe ... vor	予定している，計画している	分離動詞 	\N	\N	\N	1487	\N
216	nach	…へ 	前置詞（３格と）	\N	\N	\N	1487	\N
538	Japan	日本	中性名詞	\N	\N	\N	1487	\N
181	gehen	行く	動詞	\N	\N	\N	1487	\N
283	um	（ zu不定詞と）…するために	接続詞	\N	\N	\N	1487	\N
539	Materialien	資料，データ	中性名詞（複数形）	\N	\N	\N	1487	\N
190	für	…のための	前置詞（４格と）	\N	\N	\N	1487	\N
13	meine	私の	所有冠詞（女性１格）	\N	\N	\N	1487	\N
471	Magisterarbeit	修士論文	女性名詞	\N	\N	\N	1487	\N
540	sammeln	集める	動詞	\N	\N	\N	1487	\N
10	jetzt	今	副詞	\N	\N	\N	1489	\N
148	wollte	…したい，…しようとする	話法の助動詞（接続法Ⅱ）	\N	\N	\N	1489	\N
541	mich für ... bewerben	…に応募する，…を申し込む	動詞	\N	\N	\N	1489	\N
542	Stipendium	奨学金	中性名詞	\N	\N	\N	1489	\N
254	beim  bei dem	…（機関・組織）で	前置詞＋定冠詞	\N	\N	\N	1489	\N
543	DAAD	ドイツ学術交流会	名詞・略語	\N	\N	\N	1489	\N
400	allerdings	ただし	副詞	\N	\N	\N	1490	\N
157	bräuchte	必要とする	動詞（接続法Ⅱ）	\N	\N	\N	1490	\N
544	dafür	そのために	副詞	\N	\N	\N	1490	\N
545	Empfehlungsschreiben	推薦状	中性名詞	\N	\N	\N	1490	\N
432	fragen	…（４格）に尋ねる，質問する	動詞	\N	\N	\N	1491	\N
373	ob	…かどうか	従属接続詞	\N	\N	\N	1491	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1491	\N
261	vielleicht	よろしければ	副詞	\N	\N	\N	1491	\N
546	schreiben	書く	動詞	\N	\N	\N	1491	\N
117	könnten	…することができる	話法の助動詞（接続法Ⅱ）	\N	\N	\N	1491	\N
114	ja	はい	副詞	\N	\N	\N	1492	\N
288	kein	…ない	否定冠詞	\N	\N	\N	1492	\N
547	Problem	問題	中性名詞	\N	\N	\N	1492	\N
9	mach'  mache	する	動詞 	\N	\N	\N	1493	\N
145	gern	喜んで	副詞 	\N	\N	\N	1493	\N
548	bis	…まで	前置詞	\N	\N	\N	1494	\N
209	wann	いつ	疑問副詞	\N	\N	\N	1494	\N
157	brauchen\n	必要とする	動詞	\N	\N	\N	1494	\N
549	Schreiben	書状，書簡	中性名詞	\N	\N	\N	1494	\N
54	denn	いったい	副詞	\N	\N	\N	1494	\N
162	eigentlich	ほんとうは	副詞 	\N	\N	\N	1495	\N
550	spätestens	遅くても	副詞	\N	\N	\N	1495	\N
548	bis	…までに	前置詞（４格と）	\N	\N	\N	1495	\N
234	nächsten	次の	形容詞	\N	\N	\N	1495	\N
551	Montag	月曜日	男性名詞	\N	\N	\N	1495	\N
69	wäre	…だろう	助動詞（接続法Ⅱ）	\N	\N	\N	1496	\N
54	denn	それで	副詞	\N	\N	\N	1496	\N
181	gehen	（事が）できる，うまくいく	動詞	\N	\N	\N	1496	\N
517	kommen ... vorbei	立ち寄る	分離動詞	\N	\N	\N	1498	\N
154	einfach	ただ，とにかく	副詞 	\N	\N	\N	1498	\N
254	am  an dem	…（日時）に	前置詞＋定冠詞 	\N	\N	\N	1498	\N
552	Oh Mann	ああ！	成句	\N	\N	\N	1499	\N
553	immer noch 	いまだに	成句	\N	\N	\N	1499	\N
288	kein	（一つも）…ない	否定冠詞（中性４格）	\N	\N	\N	1499	\N
554	Geschenk	プレゼント	中性名詞	\N	\N	\N	1499	\N
190	für	…のための	前置詞（４格と）	\N	\N	\N	1499	\N
13	meine	私の	所有冠詞（女性４格）	\N	\N	\N	1499	\N
87	spiele	する	他動詞	\N	\N	\N	1633	\N
555	Schwester	妹，姉	女性名詞	\N	\N	\N	1499	\N
265	die	その人は	指示代名詞（女性１格）	\N	\N	\N	1499	\N
29	schon	もう	副詞	\N	\N	\N	1499	\N
556	übermorgen	あさって	副詞	\N	\N	\N	1499	\N
17	Geburtstag	誕生日	男性名詞	\N	\N	\N	1499	\N
392	tja	そうだね	間投詞	\N	\N	\N	1500	\N
66	da	それなら	副詞	\N	\N	\N	1500	\N
173	musst	…しなければならない	話法の助動詞	\N	\N	\N	1500	\N
31	dir	君に	人称代名詞（３格）	\N	\N	\N	1500	\N
8	was	何か	不定代名詞	\N	\N	\N	1500	\N
557	einfallen	…（３格）に思いつく	分離動詞	\N	\N	\N	1500	\N
558	lassen	…させる	使役の助動詞	\N	\N	\N	1500	\N
559	Wie alt	何歳	成句	\N	\N	\N	1501	\N
383	wird	…になる	動詞	\N	\N	\N	1501	\N
23	deine	君の	所有冠詞（女性１格）	\N	\N	\N	1501	\N
54	denn	いったい	副詞	\N	\N	\N	1501	\N
560	achtzehn	１８	数詞	\N	\N	\N	1502	\N
345	Weißt	知っている	動詞	\N	\N	\N	1503	\N
261	vielleicht	ひょっとしたら	副詞	\N	\N	\N	1503	\N
561	irgendwas	何かあるもの	不定代名詞	\N	\N	\N	1503	\N
562	kommt drauf an	それは場合による	成句	\N	\N	\N	1504	\N
563	für ... interessiert ... sich	…（４格）に興味を持つ	再帰動詞	\N	\N	\N	1505	\N
8	was	何	疑問代名詞	\N	\N	\N	1505	\N
54	denn	いったい	副詞	\N	\N	\N	1505	\N
162	eigentlich	ほんとうは，もともとは	副詞	\N	\N	\N	1506	\N
144	liest	本を読む，読書する	動詞	\N	\N	\N	1506	\N
376	ziemlich	かなり	副詞	\N	\N	\N	1506	\N
143	viel	たくさん	形容詞	\N	\N	\N	1506	\N
147	Romane	小説	男性名詞（複数形）	\N	\N	\N	1506	\N
564	Krimis	推理小説	男性名詞（複数形）	\N	\N	\N	1506	\N
250	und so	…とか何か		\N	\N	\N	1506	\N
7	auch	…も	副詞	\N	\N	\N	1507	\N
565	ausländische	外国の	形容詞	\N	\N	\N	1507	\N
566	Autoren	作家	男性名詞（複数形）	\N	\N	\N	1507	\N
39	glaub'	思う，信じる	動詞	\N	\N	\N	1508	\N
29	schon	きっと，確かに	副詞	\N	\N	\N	1508	\N
567	Wie wär's ... mit ~	…（3格）はどうだろう	成句	\N	\N	\N	1509	\N
18	dann	それなら	副詞	\N	\N	\N	1509	\N
318	japanischer	日本の	形容詞	\N	\N	\N	1509	\N
568	Literatur	文学	女性名詞	\N	\N	\N	1509	\N
345	weiß	知っている	動詞	\N	\N	\N	1510	\N
473	nicht	…ない	副詞	\N	\N	\N	1510	\N
261	vielleicht	もしかしたら	副詞	\N	\N	\N	1510	\N
514	was	何か	不定代名詞	\N	\N	\N	1510	\N
24	von	…の	前置詞（３格と）	\N	\N	\N	1510	\N
569	warum ... nicht	もちろん（いいよ）	成句	\N	\N	\N	1511	\N
162	eigentlich	そもそも	副詞	\N	\N	\N	1511	\N
570	Welche	どの	疑問冠詞	\N	\N	\N	1512	\N
133	Bücher	本	中性名詞（複数形）	\N	\N	\N	1512	\N
54	denn	いったい	副詞	\N	\N	\N	1512	\N
66	da	それでは	副詞	\N	\N	\N	1512	\N
90	gut	良い	形容詞	\N	\N	\N	1512	\N
494	zum Beispiel	たとえば	前置詞句	\N	\N	\N	1513	\N
24	von	…の	前置詞（３格と）	\N	\N	\N	1513	\N
117	kann	…することができる	話法の助動詞	\N	\N	\N	1515	\N
48	Ihnen	あなた	人称代名詞（３格）	\N	\N	\N	1515	\N
187	helfen	手伝う，助ける	動詞	\N	\N	\N	1515	\N
188	suche	探す	動詞	\N	\N	\N	1516	\N
508	kleinen	小さな	形容詞（男性４格）	\N	\N	\N	1516	\N
571	Terminkalender	ダイアリー，手帳	男性名詞	\N	\N	\N	1516	\N
254	fürs  fü das	…用の	前置詞＋定冠詞	\N	\N	\N	1516	\N
234	nächste	次の	形容詞	\N	\N	\N	1516	\N
225	Jahr	年	中性名詞	\N	\N	\N	1516	\N
265	die	それらを	指示代名詞（複数４格）	\N	\N	\N	1517	\N
92	hier	ここに	副詞	\N	\N	\N	1517	\N
572	vorne	前に	副詞	\N	\N	\N	1517	\N
573	denken	…(４格）を考える	動詞	\N	\N	\N	1518	\N
514	was	何か	不定代名詞	\N	\N	\N	1518	\N
574	Spezielles	特別なもの	形容詞の名詞化（中性４格）	\N	\N	\N	1518	\N
206	so	そのような	副詞	\N	\N	\N	1519	\N
508	kleinen	小さな	形容詞	\N	\N	\N	1519	\N
575	Taschenkalender	ポケットダイアリー	男性名詞	\N	\N	\N	1519	\N
146	der		関係代名詞	\N	\N	\N	1519	\N
482	trotzdem	それにもかかわらず	副詞	\N	\N	\N	1519	\N
190	für	…用に	前置詞（４格と）	\N	\N	\N	1519	\N
386	jeden	毎	指示冠詞（男性４格）	\N	\N	\N	1519	\N
576	Tag	日	名詞	\N	\N	\N	1519	\N
358	Seite	ページ	女性名詞	\N	\N	\N	1519	\N
129	hat	…を持つ	動詞	\N	\N	\N	1519	\N
18	dann	そういうわけならば	副詞	\N	\N	\N	1520	\N
173	muss	…しなければならない	話法の助動詞	\N	\N	\N	1520	\N
75	mal	ちょっと	副詞	\N	\N	\N	1520	\N
3	sehen	見る	動詞	\N	\N	\N	1520	\N
39	glaube	思う	動詞	\N	\N	\N	1521	\N
265	die	それらは	指示代名詞（複数１格）	\N	\N	\N	1521	\N
29	schon	もう，すでに	副詞	\N	\N	\N	1521	\N
577	fast	ほとんど	副詞	\N	\N	\N	1521	\N
395	alle	すべて	不定代名詞	\N	\N	\N	1521	\N
578	verkauft	売る	動詞（過去分詞）	\N	\N	\N	1521	\N
456	Moment	ちょっと（待って）	男性名詞	\N	\N	\N	1522	\N
92	hier	ここに	副詞	\N	\N	\N	1522	\N
129	hab'  habe	持っている	動詞	\N	\N	\N	1522	\N
86	doch	やはり	副詞	\N	\N	\N	1522	\N
32	noch	まだ	副詞	\N	\N	\N	1522	\N
579	einen	一つ	不定代名詞（男性４格）	\N	\N	\N	1522	\N
94	bitte	どうぞ	間投詞	\N	\N	\N	1523	\N
371	genau	ちょうど	副詞	\N	\N	\N	1524	\N
206	so	そのような，このような	副詞	\N	\N	\N	1524	\N
188	suche	探す	動詞	\N	\N	\N	1524	\N
45	aber	でも	並列接続詞	\N	\N	\N	1525	\N
580	Farbe	色	女性名詞	\N	\N	\N	1525	\N
149	gefällt	…（３格）に気に入る	動詞	\N	\N	\N	1525	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1525	\N
206	so	それほど，そんなに	副詞	\N	\N	\N	1525	\N
129	hätten	持っている	動詞(接続法Ⅱ）	\N	\N	\N	1526	\N
448	den	それを	指示代名詞（男性４格）	\N	\N	\N	1526	\N
261	vielleicht	ひょっとして，もしかしたら	副詞	\N	\N	\N	1526	\N
7	auch	…もまた	副詞	\N	\N	\N	1526	\N
32	noch	まだ	副詞	\N	\N	\N	1526	\N
59	in	…の色で	前置詞	\N	\N	\N	1526	\N
581	Schwarz	黒，黒色	中性名詞	\N	\N	\N	1526	\N
254	tut mir Leid	申し訳ない	成句	\N	\N	\N	1528	\N
127	wirklich	本当に	副詞	\N	\N	\N	1528	\N
224	letzte	最後の	形容詞	\N	\N	\N	1528	\N
582	schade	残念な	形容詞	\N	\N	\N	1529	\N
8	was	何を	疑問代名詞	\N	\N	\N	1530	\N
9	mach'  mache	する	動詞	\N	\N	\N	1530	\N
54	denn	いったい	副詞	\N	\N	\N	1530	\N
10	jetzt	さて	副詞	\N	\N	\N	1530	\N
583	kriegen	手に入れる	動詞	\N	\N	\N	1531	\N
200	dieses	この	指示代名詞（中性４格）	\N	\N	\N	1531	\N
225	Jahr	年	中性名詞	\N	\N	\N	1531	\N
288	keine	（一つも）…ない	否定冠詞	\N	\N	\N	1531	\N
584	neunen	新しい	形容詞	\N	\N	\N	1531	\N
585	Kalender	ダイアリー	男性名詞（複数形）	\N	\N	\N	1531	\N
158	mehr	もう（…ない），もはや（…ない）	副詞	\N	\N	\N	1531	\N
586	rein	（店の）中へ	副詞	\N	\N	\N	1531	\N
587	na gut	まあいいか	間投詞	\N	\N	\N	1532	\N
18	dann	それでは	副詞	\N	\N	\N	1532	\N
203	nehme	買う，（店などで）…にする	動詞	\N	\N	\N	1532	\N
588	eben	とにかく	副詞	\N	\N	\N	1532	\N
200	diesen	これを	指示代名詞（男性４格）	\N	\N	\N	1532	\N
129	hast	持っている	動詞	\N	\N	\N	1533	\N
261	vielleicht	ひょっとして	副詞	\N	\N	\N	1533	\N
589	japanisch-deutsches	和独の	形容詞	\N	\N	\N	1533	\N
590	Wörterbuch	辞書	中性名詞	\N	\N	\N	1533	\N
286	nee	いいえ	副詞	\N	\N	\N	1534	\N
591	japanisch-englisches	和英の	形容詞（中性４格）	\N	\N	\N	1534	\N
122	na ja	まあ	間投詞	\N	\N	\N	1535	\N
26	das	それは	指示代名詞	\N	\N	\N	1535	\N
181	geht	うまくいく，なんとかなる	動詞	\N	\N	\N	1535	\N
7	auch	…も	副詞	\N	\N	\N	1535	\N
117	kann	…してもいい	話法の助動詞	\N	\N	\N	1536	\N
75	mal	ちょっと	副詞	\N	\N	\N	1536	\N
129	haben	持っている	動詞	\N	\N	\N	1536	\N
329	klar	明確な，明らかな	形容詞	\N	\N	\N	1537	\N
26	das	それは	指示代名詞	\N	\N	\N	1537	\N
592	steht	立ててある，置いてある	動詞	\N	\N	\N	1537	\N
66	da	そこに	副詞	\N	\N	\N	1537	\N
572	vorne	前に	副詞	\N	\N	\N	1537	\N
593	im	…の中に	前置詞（３格と）	\N	\N	\N	1537	\N
594	Regal	本棚	中性名詞	\N	\N	\N	1537	\N
595	danke	ありがとう	間投詞	\N	\N	\N	1538	\N
129	hast	持っている	動詞	\N	\N	\N	1539	\N
86	doch	…だったよね	副詞	\N	\N	\N	1539	\N
596	Textmarker	蛍光ペン	男性名詞	\N	\N	\N	1539	\N
98	oder	…でしょう	並列接続詞	\N	\N	\N	1539	\N
448	den	それを	指示代名詞	\N	\N	\N	1541	\N
75	mal	ちょっと	副詞	\N	\N	\N	1541	\N
597	gerade	今	副詞	\N	\N	\N	1541	\N
129	haben	持っている，手に入れる	動詞	\N	\N	\N	1541	\N
407	natürlich	もちろん	副詞	\N	\N	\N	1542	\N
92	hier	ここに	副詞	\N	\N	\N	1542	\N
598	Vokabeln	単語	女性名詞（複数形）	\N	\N	\N	1544	\N
599	besprochen	…（４格）について話し合う	他動詞（過去分詞）	\N	\N	\N	1544	\N
304	Fragen	質問	女性名詞（複数形）	\N	\N	\N	1545	\N
254	nächste Woche	来週	成句	\N	\N	\N	1546	\N
600	Vokabeltest	単語テスト	男性名詞	\N	\N	\N	1546	\N
546	schreiben	書く	他動詞	\N	\N	\N	1546	\N
544	dafür	そのために	副詞	\N	\N	\N	1547	\N
198	sollten	…すべきだ	話法の助動詞（接続法第２式）	\N	\N	\N	1547	\N
407	natürlich	もちろん	副詞	\N	\N	\N	1549	\N
48	Ihnen	あなたたちに	人称代名詞（２人称敬称３格）	\N	\N	\N	1549	\N
601	dazu	そのために	副詞	\N	\N	\N	1549	\N
602	einige	いくつかの	不定代名詞	\N	\N	\N	1549	\N
603	Übungen	練習問題	女性名詞（複数形）	\N	\N	\N	1549	\N
265	die	（それを）	関係代名詞（複数４格）	\N	\N	\N	1549	\N
254	zu Hause	うちで	成句	\N	\N	\N	1549	\N
548	bis	…までに	前置詞	\N	\N	\N	1550	\N
265	die	それを	指示代名詞（複数４格）	\N	\N	\N	1550	\N
254	na ja	まあ	成句	\N	\N	\N	1551	\N
604	bis zur	…まで	前置詞＋前置詞＋定冠詞（女性３格）	\N	\N	\N	1551	\N
234	nächsten	次の	形容詞	\N	\N	\N	1551	\N
21	schön	とても	副詞	\N	\N	\N	1552	\N
136	ganz	かなり	副詞	\N	\N	\N	1552	\N
8	was	…すること	不定関係代名詞（４格）	\N	\N	\N	1552	\N
66	da	その場合に	副詞	\N	\N	\N	1552	\N
605	ohne	…なしに	前置詞（４格と）	\N	\N	\N	1553	\N
606	Fleiß	勤勉，努力	男性名詞	\N	\N	\N	1553	\N
607	Preis	賞	男性名詞	\N	\N	\N	1553	\N
45	aber	本当に	副詞	\N	\N	\N	1554	\N
55	findest	思う	他動詞	\N	\N	\N	1555	\N
227	toll	すばらしい，すごい	形容詞	\N	\N	\N	1556	\N
277	davon	それの	副詞	\N	\N	\N	1557	\N
9	mach'  mache	（写真を）撮る	他動詞	\N	\N	\N	1557	\N
292	ein	ひとつの	不定冠詞（中性４格）	\N	\N	\N	1557	\N
608	Foto	写真	中性名詞	\N	\N	\N	1557	\N
8	was	えっ	疑問副詞	\N	\N	\N	1558	\N
148	willst	…するつもりだ	話法の助動詞	\N	\N	\N	1558	\N
609	fotografieren	写真を撮る	自動詞	\N	\N	\N	1558	\N
610	wieso	なぜ	疑問副詞	\N	\N	\N	1559	\N
291	etwa	ひょっとして	副詞	\N	\N	\N	1559	\N
611	verboten	禁じられた	形容詞	\N	\N	\N	1559	\N
4	Na	まあ	間投詞	\N	\N	\N	1560	\N
39	glaub'  glaube	思う	他動詞	\N	\N	\N	1560	\N
29	schon	実際に	副詞	\N	\N	\N	1560	\N
380	Museen	美術館，博物館	中性名詞（複数形）	\N	\N	\N	1561	\N
306	darf	（否定と）…してはいけない	話法の助動詞	\N	\N	\N	1561	\N
86	doch	…じゃないか	副詞	\N	\N	\N	1561	\N
336	nie	決して…ない	副詞	\N	\N	\N	1561	\N
612	sicher	確か	副詞	\N	\N	\N	1562	\N
121	Warte	待つ	自動詞（命令形）	\N	\N	\N	1563	\N
75	mal	ちょっと	副詞	\N	\N	\N	1564	\N
66	da	そこの	副詞	\N	\N	\N	1564	\N
613	hinten	後ろの	副詞	\N	\N	\N	1564	\N
254	siehst du	ほらね	成句	\N	\N	\N	1565	\N
614	hatte Recht	正しい	成句	\N	\N	\N	1565	\N
615	streng	厳格に	形容詞	\N	\N	\N	1566	\N
254	Ach so	そうなの	成句	\N	\N	\N	1567	\N
582	schade	残念だ	形容詞	\N	\N	\N	1567	\N
205	Kasse	窓口，レジ	女性名詞	\N	\N	\N	1568	\N
616	gibt's  gibt es	…（４格）がある	成句	\N	\N	\N	1568	\N
86	doch	…だよ	副詞	\N	\N	\N	1568	\N
299	bestimmt	きっと	副詞	\N	\N	\N	1568	\N
292	'nen	ひとつの	不定冠詞（男性４格）	\N	\N	\N	1568	\N
617	Prospekt	パンフレット	男性名詞	\N	\N	\N	1568	\N
618	Ansichtskarten	絵はがき	女性名詞（複数形）	\N	\N	\N	1568	\N
619	Bildern	絵	中性名詞（複数３格）	\N	\N	\N	1568	\N
254	Würden Sie bitte ...	…していただけますか	成句	\N	\N	\N	1571	\N
539	Material	資料	中性名詞	\N	\N	\N	1571	\N
620	Sitzung	会議	女性名詞	\N	\N	\N	1571	\N
621	vorbereiten	準備する	分離動詞	\N	\N	\N	1571	\N
407	natürlich	もちろん	副詞	\N	\N	\N	1572	\N
328	damit	それについて		\N	\N	\N	1573	\N
622	fertig	（mit …が）済んだ	形容詞	\N	\N	\N	1573	\N
623	Sie's		人称代名詞＋人称代名詞	\N	\N	\N	1573	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1573	\N
86	doch	ぜひ	副詞	\N	\N	\N	1573	\N
624	sofort	すぐに	副詞	\N	\N	\N	1573	\N
139	ist in Ordnung.	承知した，問題ない	成句	\N	\N	\N	1574	\N
625	was	何か	不定代名詞	\N	\N	\N	1576	\N
626	Verständigen	…（４格）に知らせる	他動詞	\N	\N	\N	1578	\N
627	Abteilungen	部署，課	女性名詞（複数形）	\N	\N	\N	1578	\N
111	dass	…ということ	従属接続詞	\N	\N	\N	1578	\N
620	Sitzung	会議	女性名詞	\N	\N	\N	1578	\N
292	'ne  eine	一	数詞（女性４格）	\N	\N	\N	1578	\N
179	Stunde	時間	女性名詞	\N	\N	\N	1578	\N
523	später	後に	副詞	\N	\N	\N	1578	\N
312	also	すなわち	副詞	\N	\N	\N	1578	\N
290	erst	ようやく	副詞	\N	\N	\N	1578	\N
281	anfängt	始まる	分離動詞	\N	\N	\N	1578	\N
628	selbstverständlich	当然の	副詞	\N	\N	\N	1579	\N
9	mach' > mache	する	他動詞	\N	\N	\N	1579	\N
629	Beim	…の際に	前置詞＋定冠詞	\N	\N	\N	1580	\N
630	Musikhören	音楽を聴くこと	中性名詞	\N	\N	\N	1580	\N
631	Kopfhörer	ヘッドフォン	男性名詞	\N	\N	\N	1580	\N
632	Bibliothek	図書館	女性名詞	\N	\N	\N	1580	\N
136	ganz	非常に	副詞	\N	\N	\N	1580	\N
633	leise	（音が）小さい	形容詞	\N	\N	\N	1580	\N
66	da	そこの	副詞	\N	\N	\N	1580	\N
37	Meinst	…（４格）のことを言う	他動詞	\N	\N	\N	1581	\N
38	mich	私を	人称代名詞（４格）	\N	\N	\N	1581	\N
117	kannst	…できる	話法の助動詞	\N	\N	\N	1582	\N
86	doch	だよ	副詞	\N	\N	\N	1582	\N
154	einfach	平気で	副詞	\N	\N	\N	1582	\N
610	wieso	どうして	疑問副詞	\N	\N	\N	1583	\N
485	Mensch	おい（間投詞的）	男性名詞	\N	\N	\N	1584	\N
439	anderen	他の（人）	不定代名詞	\N	\N	\N	1584	\N
634	stört	…を邪魔する	他動詞	\N	\N	\N	1584	\N
635	habe ... auf	かぶっている	分離動詞	\N	\N	\N	1585	\N
292	'nen	ひとつの	不定冠詞（男性４格）	\N	\N	\N	1585	\N
79	wie	…ように	従属接続詞	\N	\N	\N	1585	\N
3	siehst	見る	動詞	\N	\N	\N	1585	\N
482	trotzdem	それにもかかわらず	副詞	\N	\N	\N	1586	\N
636	Walkman	ウォークマン	男性名詞	\N	\N	\N	1587	\N
637	ausschalten	…（のスイッチを）切る	分離動詞	\N	\N	\N	1587	\N
4	na	まあ	間投詞	\N	\N	\N	1588	\N
54	denn	（それでは）	副詞	\N	\N	\N	1588	\N
173	muss	…でなければならない	話法の助動詞	\N	\N	\N	1588	\N
162	eigentlich	ところで 	副詞 	\N	\N	\N	1589	\N
200	dieses	この 	指示冠詞（中性４格） 	\N	\N	\N	1589	\N
185	Wochenende	週末 	中性名詞	\N	\N	\N	1589	\N
638	gehen ... ins Konzert	コンサートに行く	成句 	\N	\N	\N	1589	\N
371	genau	その通り	副詞 	\N	\N	\N	1590	\N
52	wo	どこに 	疑問副詞 	\N	\N	\N	1591	\N
254	noch mal	もう一度	成句 	\N	\N	\N	1591	\N
639	Kunsthalle	芸術ホール	女性名詞	\N	\N	\N	1591	\N
69	warst	いる 	動詞（過去形） 	\N	\N	\N	1592	\N
66	da	そこに 	副詞 	\N	\N	\N	1592	\N
254	noch nie	まだ一度も…ない	成句 	\N	\N	\N	1592	\N
286	nee	ううん 	間投詞 	\N	\N	\N	1593	\N
254				\N	\N	\N	1594	\N
198	soll	…すべきだ 	話法の助動詞 	\N	\N	\N	1595	\N
640	Lageplan	所在地図	男性名詞 	\N	\N	\N	1595	\N
75	mal	一度 	副詞 	\N	\N	\N	1595	\N
641	faxen	ファックスする	他動詞 	\N	\N	\N	1595	\N
98	oder	それとも 	並列接続詞 	\N	\N	\N	1596	\N
100	dich	君を	人称代名詞（４格） 	\N	\N	\N	1596	\N
497	lieber	むしろ 	副詞 	\N	\N	\N	1596	\N
254	am  an dem	…（場所）に 	前置詞＋定冠詞 	\N	\N	\N	1596	\N
642	Bahnhof	駅	男性名詞 	\N	\N	\N	1596	\N
643	abholen	迎えに行く	分離動詞 	\N	\N	\N	1596	\N
157	brauchst	必要である 	他動詞 	\N	\N	\N	1597	\N
39	glaube	思う	他動詞 	\N	\N	\N	1598	\N
117	kann	…できる	話法の助動詞 	\N	\N	\N	1598	\N
254	im  in dem	…（場所）で	前置詞＋定冠詞 	\N	\N	\N	1598	\N
644	Internet	インターネット	中性名詞 	\N	\N	\N	1598	\N
645	nachgucken	調べる	分離動詞 	\N	\N	\N	1598	\N
4	na	まあ	間投詞	\N	\N	\N	1599	\N
18	dann	それでは 	副詞 	\N	\N	\N	1600	\N
170	treffen	…（４格）に会う 	動詞 	\N	\N	\N	1600	\N
465	uns	私たち 	人称代名詞（４格） 	\N	\N	\N	1600	\N
254	am  an dem	…（時）に 	前置詞＋冠詞 	\N	\N	\N	1600	\N
253	Samstag	土曜日 	男性名詞 	\N	\N	\N	1600	\N
283	um	…時に 	前置詞 	\N	\N	\N	1600	\N
254				\N	\N	\N	1601	\N
646	falls	…の場合には 	従属接続詞 	\N	\N	\N	1602	\N
647	dich verläufst	道に迷う 	再帰動詞 	\N	\N	\N	1602	\N
526	ruf ... an	…（４格）に電話する 	分離動詞 	\N	\N	\N	1602	\N
38	mich	私 	人称代名詞（４格） 	\N	\N	\N	1602	\N
648	Handynummer	携帯番号 	女性名詞 	\N	\N	\N	1603	\N
114	ja	…だろうね 	副詞 	\N	\N	\N	1603	\N
254	alles klar	すべて了解 	成句 	\N	\N	\N	1604	\N
254	also dann	それでは 		\N	\N	\N	1605	\N
107	übrigens	ところで 	副詞 	\N	\N	\N	1606	\N
254	am  an dem	…（時）に 	前置詞＋冠詞 	\N	\N	\N	1606	\N
649	Sonntag	日曜日 	男性名詞 	\N	\N	\N	1606	\N
279	Zeit	時間 	女性名詞 	\N	\N	\N	1606	\N
345	weiß	知っている 	他動詞 	\N	\N	\N	1607	\N
32	noch	まだ 	副詞 	\N	\N	\N	1607	\N
173	muss	…しなくてはならない 	話法の助動詞 	\N	\N	\N	1608	\N
548	bis	…までに 	前置詞 	\N	\N	\N	1608	\N
551	Montag	月曜日 	男性名詞 	\N	\N	\N	1608	\N
650	Referat	レポート 	中性名詞 	\N	\N	\N	1608	\N
254	fertig kriegen	仕上げる 	成句 	\N	\N	\N	1608	\N
16	heute	今日 	副詞 	\N	\N	\N	1609	\N
86	doch	だよ 	副詞 	\N	\N	\N	1609	\N
290	erst	まだ 	副詞 	\N	\N	\N	1609	\N
651	Mittwoch	水曜日 	男性名詞 	\N	\N	\N	1609	\N
652	schaffst	やり遂げる 	他動詞 	\N	\N	\N	1610	\N
29	schon	きっと 	副詞 	\N	\N	\N	1610	\N
253	Samstag	土曜日 	男性名詞 	\N	\N	\N	1610	\N
254	mal seh'n	まあ見てみよう 	成句 	\N	\N	\N	1611	\N
610	wieso	どうして 	疑問副詞 	\N	\N	\N	1612	\N
54	denn	一体 	副詞 	\N	\N	\N	1612	\N
8	was	何を 	疑問代名詞（４格） 	\N	\N	\N	1612	\N
241	hast ... vor	予定している 	分離動詞 	\N	\N	\N	1612	\N
66	da	その日 	副詞 	\N	\N	\N	1613	\N
318	japanische	日本の 	副詞 	\N	\N	\N	1613	\N
12	zu	…のところへ 	前置詞（３格と） 	\N	\N	\N	1613	\N
25	mir	私 	人称代名詞（３格） 	\N	\N	\N	1613	\N
148	wollen	…するつもりだ 	話法の助動詞 	\N	\N	\N	1614	\N
20	zusammen	一緒に 	副詞 	\N	\N	\N	1614	\N
9	machen	作る 	他動詞 	\N	\N	\N	1614	\N
254				\N	\N	\N	1615	\N
77	echt	本当に 	副詞 	\N	\N	\N	1616	\N
117	könnt	…できる 	話法の助動詞 	\N	\N	\N	1617	\N
127	wirklich	本当に 	副詞 	\N	\N	\N	1617	\N
653	selber	自分で 	副詞 	\N	\N	\N	1617	\N
612	sicher	きっと，もちろん 	副詞 	\N	\N	\N	1618	\N
654	laden ... ein	招待する 	分離動詞 	\N	\N	\N	1619	\N
100	dich	君を 	人称代名詞（４格） 	\N	\N	\N	1619	\N
517	komm ... vorbei	立ち寄る 	自動詞 	\N	\N	\N	1620	\N
254				\N	\N	\N	1621	\N
45	aber	全く 	副詞 	\N	\N	\N	1622	\N
47	nett	親切だ 	形容詞 	\N	\N	\N	1622	\N
24	von	…による 	前置詞（３格と） 	\N	\N	\N	1622	\N
655	euch	君たち 	人称代名詞（３格） 	\N	\N	\N	1622	\N
423	hoffentlich	…であるとよいが 	副詞 	\N	\N	\N	1623	\N
652	schaffe	やり遂げる 	他動詞 	\N	\N	\N	1623	\N
26	das	それを 	指示代名詞 	\N	\N	\N	1623	\N
164	mit	…に関する 	前置詞（３格と） 	\N	\N	\N	1623	\N
656	kriegst ... hin	やってのける 	分離動詞 	\N	\N	\N	1624	\N
29	schon	きっと 	副詞 	\N	\N	\N	1624	\N
394	irgendwie	どうにか 	副詞 	\N	\N	\N	1624	\N
254	also dann	それでは 	成句 	\N	\N	\N	1625	\N
283	um	…（時間）に 	前置詞（４格と） 	\N	\N	\N	1625	\N
254				\N	\N	\N	1626	\N
134	bringe ... mit	持っていく 	分離他動詞 	\N	\N	\N	1627	\N
189	etwas	何か 	不定代名詞 	\N	\N	\N	1627	\N
140	zu trinken		動詞（ zu不定詞） 	\N	\N	\N	1627	\N
657	heute	今日	疑問代名詞	\N	\N	\N	1628	\N
45	aber	本当に	副詞	\N	\N	\N	1628	\N
658	blass	青ざめた	形容詞	\N	\N	\N	1628	\N
254	Was ist ... los	どうしたの	成句	\N	\N	\N	1629	\N
54	denn	一体	副詞	\N	\N	\N	1629	\N
659	schlafe	眠る	自動詞	\N	\N	\N	1630	\N
254	zur Zeit	現在のところ	成句	\N	\N	\N	1630	\N
660	Deshalb	だから	副詞	\N	\N	\N	1631	\N
163	immer	いつも	副詞	\N	\N	\N	1631	\N
206	so	とても	副詞	\N	\N	\N	1631	\N
661	müde	疲れている	形容詞	\N	\N	\N	1631	\N
198	solltest	…すべきだ	話法の助動詞（接続法Ⅱ）	\N	\N	\N	1632	\N
261	vielleicht	もしかすると	副詞	\N	\N	\N	1632	\N
158	mehr	もっとたくさん	副詞	\N	\N	\N	1632	\N
429	Sport	スポーツ	男性名詞	\N	\N	\N	1632	\N
9	machen	する	他動詞	\N	\N	\N	1632	\N
86	doch	でも…だよ	副詞	\N	\N	\N	1633	\N
29	schon	すでに	副詞	\N	\N	\N	1633	\N
254	jeden Tag	毎日	成句	\N	\N	\N	1633	\N
469	'ne	１	数詞（女性４格）	\N	\N	\N	1633	\N
179	Stunde	時間	女性名詞	\N	\N	\N	1633	\N
662	Fußball	サッカー	男性名詞	\N	\N	\N	1633	\N
198	sollte	…なはずだ	話法の助動詞（接続法Ⅱ）	\N	\N	\N	1634	\N
45	aber	しかし	副詞	\N	\N	\N	1634	\N
663	genug	十分に	副詞	\N	\N	\N	1634	\N
140	trink	飲む	他動詞（命令形単数親称）	\N	\N	\N	1635	\N
86	doch	ぜひ	副詞	\N	\N	\N	1635	\N
469	'ne	１	数詞（女性４格）	\N	\N	\N	1635	\N
664	Tasse	カップ	女性名詞	\N	\N	\N	1635	\N
164	mit	…入りの	前置詞（３格と）	\N	\N	\N	1635	\N
665	Honig	蜂蜜	男性名詞	\N	\N	\N	1635	\N
254	vorm  vor dem	…の前に	前置詞＋冠詞	\N	\N	\N	1635	\N
666	Schlafen	眠ること	中性名詞	\N	\N	\N	1635	\N
129	hab'		完了の助動詞	\N	\N	\N	1636	\N
278	probiert	試す	他動詞（過去分詞形）	\N	\N	\N	1636	\N
667	wirkt	作用する	自動詞	\N	\N	\N	1637	\N
466	bei	…の場合	前置詞（３格と）	\N	\N	\N	1637	\N
25	mir	私	人称代名詞（３格）	\N	\N	\N	1637	\N
668	leider	残念ながら	副詞	\N	\N	\N	1637	\N
148	Willst	…するつもりだ	話法の助動詞	\N	\N	\N	1638	\N
18	dann	それでは	副詞	\N	\N	\N	1638	\N
75	mal	一度	副詞	\N	\N	\N	1638	\N
254	zum  zu dem	…（のところ）に	前置詞＋冠詞	\N	\N	\N	1638	\N
669	Arzt	医者	男性名詞	\N	\N	\N	1638	\N
670	übertrieben	大げさな	形容詞	\N	\N	\N	1639	\N
151	wenn	もし…	従属接続詞	\N	\N	\N	1640	\N
86	doch	やっぱり	副詞	\N	\N	\N	1640	\N
390	bloß	ただ…さえ	副詞	\N	\N	\N	1640	\N
129	hätte	持っている	他動詞（接続法Ⅱ）	\N	\N	\N	1640	\N
79	Wie	どのように（言ったのですか）	疑問副詞（１格）	\N	\N	\N	1641	\N
8	was	何を	疑問代名詞（４格）	\N	\N	\N	1642	\N
671	Liebeskummer	恋の悩み	男性名詞	\N	\N	\N	1643	\N
672	überhaupt	一体	副詞	\N	\N	\N	1644	\N
254	letzte Woche	先週	成句	\N	\N	\N	1645	\N
96	Vorlesung	講義	女性名詞	\N	\N	\N	1645	\N
69	warst	いる	自動詞（過去形）	\N	\N	\N	1645	\N
254	na klar	もちろん	成句	\N	\N	\N	1646	\N
66	da	そこに	副詞	\N	\N	\N	1647	\N
254	oder	そうじゃない	接続詞	\N	\N	\N	1647	\N
162	eigentlich	一体	副詞	\N	\N	\N	1648	\N
129	Hast		完了の助動詞	\N	\N	\N	1649	\N
673	verschlafen	寝過ごす	自動詞（過去分詞形）	\N	\N	\N	1649	\N
129	hab'		完了の助動詞	\N	\N	\N	1651	\N
254	am Tag vorher	その前の日に	成句	\N	\N	\N	1651	\N
548	bis	…まで	前置詞（４格と）	\N	\N	\N	1651	\N
674	nachts	夜中	副詞	\N	\N	\N	1651	\N
180	gearbeitet	勉強する	自動詞（過去分詞形）	\N	\N	\N	1651	\N
66	da	それで	副詞	\N	\N	\N	1651	\N
117	konnt'  konnte	…できる	話法の助動詞（過去形）	\N	\N	\N	1651	\N
18	dann	そうしたら	そうしたら副詞	\N	\N	\N	1651	\N
154	einfach	とにかく	副詞	\N	\N	\N	1651	\N
173	musstest	…しなくてはならない	話法の助動詞（過去形）	\N	\N	\N	1653	\N
114	ja	確か…だよね	副詞	\N	\N	\N	1653	\N
39	glaub'	思う	他動詞	\N	\N	\N	1653	\N
236	Freitag	金曜日	男性名詞	\N	\N	\N	1653	\N
200	dieses	この	指示代名詞（中性４格）	\N	\N	\N	1653	\N
650	Referat	レポート	中性名詞	\N	\N	\N	1653	\N
254	fertig kriegen	完成する	成句	\N	\N	\N	1653	\N
254	hör mal	ねえ	成句	\N	\N	\N	1655	\N
117	kannst	…できる	話法の助動詞	\N	\N	\N	1655	\N
25	mir	私に	人称代名詞（３格）	\N	\N	\N	1655	\N
23	deine	君の	所有冠詞（複数４格）	\N	\N	\N	1655	\N
675	Notizen	メモ	女性名詞（複数形）	\N	\N	\N	1655	\N
24	von	…の	前置詞（３格と）	\N	\N	\N	1655	\N
676	leihen	貸す	他動詞	\N	\N	\N	1655	\N
383	würd'	…するだろう	助動詞（接続法Ⅱ）	\N	\N	\N	1656	\N
31	dir	君に人称代名詞（３格）		\N	\N	\N	1656	\N
254	beim  bei dem		前置詞＋冠詞	\N	\N	\N	1656	\N
234	nächsten	次の	形容詞	\N	\N	\N	1656	\N
677	Mal	回	中性名詞	\N	\N	\N	1656	\N
678	wiedergeben	返す	分離動詞	\N	\N	\N	1656	\N
456	Moment	ちょっと待って（瞬間）	男性名詞	\N	\N	\N	1658	\N
47	nett	親切だ	形容詞	\N	\N	\N	1660	\N
24	von	…からの	前置詞（３格と）	\N	\N	\N	1660	\N
288	kein	（１つも）…ない	否定冠詞	\N	\N	\N	1661	\N
547	Problem	問題	中性名詞	\N	\N	\N	1661	\N
254	sag mal	ねえ	成句	\N	\N	\N	1662	\N
672	überhaupt	そもそも	副詞	\N	\N	\N	1662	\N
13	meine	私の	所有冠詞（女性４格）	\N	\N	\N	1662	\N
679	Schrift	文字，筆跡	女性名詞	\N	\N	\N	1662	\N
254	es geht	なんとかなる	成句	\N	\N	\N	1663	\N
206	so	そのままで	副詞	\N	\N	\N	1663	\N
29	schon	確かに	副詞	\N	\N	\N	1664	\N
333	ein bisschen	ちょっと	成句	\N	\N	\N	1664	\N
680	schwierig	形容詞	難しい	\N	\N	\N	1664	\N
487	sagen	言う	他動詞	\N	\N	\N	1665	\N
395	alle	すべての人	不定代名詞	\N	\N	\N	1665	\N
254	na ja	まあ	成句	\N	\N	\N	1666	\N
114	ja	ぜひ	副詞	\N	\N	\N	1666	\N
432	fragen	…（４格）に尋ねる	他動詞	\N	\N	\N	1666	\N
151	wenn	もし…	従属接続詞	\N	\N	\N	1666	\N
625	was	何か	不定代名詞（４格）	\N	\N	\N	1666	\N
681	verstehst	理解する	他動詞	\N	\N	\N	1666	\N
8	was	何 	疑問代名詞（４格） 	\N	\N	\N	1667	\N
148	willst	…するつもりだ 	話法の助動詞 	\N	\N	\N	1667	\N
162	eigentlich	一体 	副詞 	\N	\N	\N	1667	\N
216	nach	…の後で 	前置詞（３格と） 	\N	\N	\N	1667	\N
682	Studium	大学での勉強 	中性名詞 	\N	\N	\N	1667	\N
148	will	…するつもりだ 	話法の助動詞 	\N	\N	\N	1668	\N
683	Staatsanwältin	検察官（女性形） 	女性名詞 	\N	\N	\N	1668	\N
383	werden	…になる 	自動詞 	\N	\N	\N	1668	\N
198	soll	…だそうだ，らしい 	話法の助動詞 	\N	\N	\N	1669	\N
114	ja	…ね 	副詞 	\N	\N	\N	1669	\N
376	ziemlich	かなり 	副詞 	\N	\N	\N	1669	\N
393	schwer	難しい 	形容詞 	\N	\N	\N	1669	\N
7	auch	実際 	副詞 	\N	\N	\N	1670	\N
173	muss	…しなくてはならない 	話法の助動詞 	\N	\N	\N	1671	\N
684	Staatsexamen	国家試験 	中性名詞（複数形） 	\N	\N	\N	1671	\N
685	bestehen	…（４格に）合格する 	他動詞 	\N	\N	\N	1671	\N
523	später	後に，将来 	副詞 	\N	\N	\N	1673	\N
344	möchte	…したい 	話法の助動詞 	\N	\N	\N	1674	\N
118	als	…として 	従属接続詞 	\N	\N	\N	1674	\N
686	Programmierer	プログラマー 	男性名詞 	\N	\N	\N	1674	\N
180	arbeiten	働く 	自動詞 	\N	\N	\N	1674	\N
82	Stimmt	合っている	自動詞	\N	\N	\N	1675	\N
101	studierst	大学で専攻する 	他動詞 	\N	\N	\N	1675	\N
114	ja	確かに 	副詞 	\N	\N	\N	1675	\N
687	Informatik	情報科学 	女性名詞 	\N	\N	\N	1675	\N
371	genau	その通り 	副詞 	\N	\N	\N	1676	\N
312	Also	つまり，だから	副詞	\N	\N	\N	1677	\N
151	wenn	…する時 	従属接続詞 	\N	\N	\N	1677	\N
75	mal	いつか 	副詞 	\N	\N	\N	1677	\N
164	mit	…のことで 	前置詞（３格と） 	\N	\N	\N	1677	\N
23	deinem	君の 	所有冠詞（男性３格） 	\N	\N	\N	1677	\N
688	Computer	コンピュータ 	男性名詞 	\N	\N	\N	1677	\N
547	Probleme	問題 	中性名詞（複数形） 	\N	\N	\N	1677	\N
187	helfe	…（３格）を助ける 	自動詞 	\N	\N	\N	1677	\N
31	dir	君 	人称代名詞（３格） 	\N	\N	\N	1677	\N
293	gerne	よろこんで 	副詞 	\N	\N	\N	1677	\N
47	nett	親切だ 	形容詞 	\N	\N	\N	1678	\N
689	lachend	笑う	自動詞（現在分詞）	\N	\N	\N	1679	\N
261	vielleicht	ひょっとしたら 	副詞副詞 	\N	\N	\N	1679	\N
16	heute	今日 	副詞 	\N	\N	\N	1679	\N
279	Zeit	時間 	女性名詞 	\N	\N	\N	1679	\N
610	Wieso	どうして	疑問副詞	\N	\N	\N	1680	\N
23	dein	君の 	所有冠詞 	\N	\N	\N	1681	\N
291	etwa	ひょっとして 	副詞 	\N	\N	\N	1681	\N
530	kaputt	壊れている 	形容詞 	\N	\N	\N	1681	\N
97	Professor	教授	男性名詞	\N	\N	\N	1682	\N
254	Grüß Gott	こんにちは	成句	\N	\N	\N	1683	\N
306	Darf	…してもよい（許可）	話法の助動詞	\N	\N	\N	1684	\N
48	Ihnen	あなたに	人称代名詞（３格）	\N	\N	\N	1684	\N
690	vorstellen	紹介する	他動詞	\N	\N	\N	1684	\N
691	promoviert	博士論文を書く	自動詞	\N	\N	\N	1685	\N
383	würde	…するだろう	未来の助動詞（接続用第２式）	\N	\N	\N	1685	\N
145	gern	好んで	副詞	\N	\N	\N	1685	\N
593	im	…（時）に	前置詞＋冠詞	\N	\N	\N	1685	\N
234	nächsten	次の	形容詞	\N	\N	\N	1685	\N
387	Semester	学期	中性名詞	\N	\N	\N	1685	\N
528	unserem	私達の	所有冠詞（中性３格）	\N	\N	\N	1685	\N
282	Seminar	ゼミナール	中性名詞	\N	\N	\N	1685	\N
692	teilnehmen	（an＋３格に）参加する	分離動詞	\N	\N	\N	1685	\N
254				\N	\N	\N	1686	\N
254				\N	\N	\N	1687	\N
693	Freut	喜ばす	他動詞	\N	\N	\N	1688	\N
38	mich	私を	人称代名詞（４格）	\N	\N	\N	1688	\N
694	kennen zu lernen	…（４格と）と知り合いになる	句動詞（zu不定詞）	\N	\N	\N	1688	\N
254				\N	\N	\N	1689	\N
254	Angenehm	はじめまして	成句	\N	\N	\N	1690	\N
695	nehmen ... Platz	座る	成句	\N	\N	\N	1691	\N
86	doch	ぜひ	副詞	\N	\N	\N	1691	\N
254				\N	\N	\N	1692	\N
231	freue mich	嬉しい	再帰動詞	\N	\N	\N	1693	\N
111	dass	…ということ	従属接続詞	\N	\N	\N	1693	\N
696	Interesse	（an＋３格への）興味	中性名詞	\N	\N	\N	1693	\N
254	Sagen Sie	ところで	成句	\N	\N	\N	1694	\N
697	woran	何について	疑問副詞	\N	\N	\N	1694	\N
180	arbeiten	研究する	自動詞	\N	\N	\N	1694	\N
162	eigentlich	一体	副詞	\N	\N	\N	1694	\N
371	genau	詳細に（言うと）	副詞	\N	\N	\N	1694	\N
698	kontrastive	対照の	形容詞	\N	\N	\N	1695	\N
699	Studie	研究	女性名詞	\N	\N	\N	1695	\N
700	zum	…について	前置詞＋冠詞	\N	\N	\N	1695	\N
701	Artikelgebrauch	冠詞使用	男性名詞	\N	\N	\N	1695	\N
254	im   in dem	…における	前置詞＋定冠詞	\N	\N	\N	1695	\N
702	Deutschen	ドイツ語	中性名詞（形容詞変化）	\N	\N	\N	1695	\N
113	Französischen	フランス語	中性名詞（形容詞変化）	\N	\N	\N	1695	\N
114	ja	…ですね	副詞	\N	\N	\N	1696	\N
212	interessant	興味深い	形容詞	\N	\N	\N	1696	\N
66	Da	それならば	副詞	\N	\N	\N	1697	\N
117	können	…できる	話法の助動詞	\N	\N	\N	1697	\N
86	doch	ぜひ	副詞	\N	\N	\N	1697	\N
703	wunderbar	すばらしい	形容詞	\N	\N	\N	1697	\N
502	über	…について	前置詞（４格と）	\N	\N	\N	1697	\N
40	Ihre	あなたの	所有冠詞	\N	\N	\N	1697	\N
175	Arbeit	研究	女性名詞	\N	\N	\N	1697	\N
704	berichten	報告する，発表する	自動詞	\N	\N	\N	1697	\N
1135		\N		\N	\N	\N	1228	\N
1061		\N		\N	\N	\N	491	\N
1200		\N		\N	\N	\N	91	\N
851		\N		\N	\N	\N	259	\N
751		\N		\N	\N	\N	1149	\N
752		\N		\N	\N	\N	1674	\N
854		\N		\N	\N	\N	44	\N
713	Lange	\N		\N	\N	\N	186	\N
865		\N		\N	\N	\N	1154	\N
742		\N		\N	\N	\N	76	\N
841		\N		\N	\N	\N	267	\N
868		\N		\N	\N	\N	71	\N
905		\N		\N	\N	\N	73	\N
798		\N		\N	\N	\N	750	\N
1157		\N		\N	\N	\N	1554	\N
911		\N		\N	\N	\N	136	\N
918		\N		\N	\N	\N	493	\N
1075		\N		\N	\N	\N	746	\N
1014		\N		\N	\N	\N	95	\N
1014		\N		\N	\N	\N	1472	\N
759		\N		\N	\N	\N	55	\N
734		\N		\N	\N	\N	75	\N
877		\N		\N	\N	\N	1214	\N
1078		\N		\N	\N	\N	1681	\N
960		\N		\N	\N	\N	184	\N
812		\N		\N	\N	\N	1301	\N
1002		\N		\N	\N	\N	1243	\N
1216	wie geht 's  wie geht es	\N		\N	\N	\N	1393	\N
1218		\N		\N	\N	\N	1532	\N
781		\N		\N	\N	\N	662	\N
1158		\N		\N	\N	\N	112	\N
1158		\N		\N	\N	\N	1557	\N
1033	so	\N		\N	\N	\N	112	\N
958		\N		\N	\N	\N	192	\N
913	schon	\N		\N	\N	\N	184	\N
874		\N		\N	\N	\N	1142	\N
1021		\N		\N	\N	\N	188	\N
1021		\N		\N	\N	\N	1043	\N
969		\N		\N	\N	\N	358	\N
706		\N		\N	\N	\N	880	\N
910		\N		\N	\N	\N	1161	\N
951		\N		\N	\N	\N	163	\N
859		\N		\N	\N	\N	67	\N
1184		\N		\N	\N	\N	371	\N
895		\N		\N	\N	\N	539	\N
902		\N		\N	\N	\N	904	\N
1182		\N		\N	\N	\N	254	\N
1155		\N		\N	\N	\N	145	\N
719		\N		\N	\N	\N	482	\N
893		\N		\N	\N	\N	1276	\N
786		\N		\N	\N	\N	482	\N
1159		\N		\N	\N	\N	957	\N
705		\N		\N	\N	\N	68	\N
904		\N		\N	\N	\N	621	\N
907		\N		\N	\N	\N	1303	\N
1129		\N		\N	\N	\N	1467	\N
1130		\N		\N	\N	\N	232	\N
1154		\N		\N	\N	\N	1086	\N
884		\N		\N	\N	\N	203	\N
1147		\N		\N	\N	\N	96	\N
1147		\N		\N	\N	\N	323	\N
971		\N		\N	\N	\N	1225	\N
986		\N		\N	\N	\N	1630	\N
723		\N		\N	\N	\N	246	\N
789		\N		\N	\N	\N	357	\N
990		\N		\N	\N	\N	1183	\N
953		\N		\N	\N	\N	1	\N
927		\N		\N	\N	\N	972	\N
711		\N		\N	\N	\N	488	\N
817		\N		\N	\N	\N	1582	\N
767		\N		\N	\N	\N	1293	\N
820		\N		\N	\N	\N	107	\N
820		\N		\N	\N	\N	108	\N
810		\N		\N	\N	\N	137	\N
1126		\N		\N	\N	\N	16	\N
1031		\N		\N	\N	\N	955	\N
909		\N		\N	\N	\N	428	\N
939		\N		\N	\N	\N	956	\N
1114		\N		\N	\N	\N	83	\N
1091		\N		\N	\N	\N	1258	\N
712		\N		\N	\N	\N	409	\N
1194		\N		\N	\N	\N	115	\N
1120		\N		\N	\N	\N	1190	\N
876		\N		\N	\N	\N	1345	\N
1165		\N		\N	\N	\N	139	\N
894		\N		\N	\N	\N	214	\N
926		\N		\N	\N	\N	1299	\N
931		\N		\N	\N	\N	77	\N
1191		\N		\N	\N	\N	187	\N
1050	Tofu	\N		\N	\N	\N	274	\N
828		\N		\N	\N	\N	319	\N
1062		\N		\N	\N	\N	147	\N
714		\N		\N	\N	\N	285	\N
725		\N		\N	\N	\N	148	\N
725	in	\N		\N	\N	\N	254	\N
837		\N		\N	\N	\N	923	\N
847		\N		\N	\N	\N	253	\N
756		\N		\N	\N	\N	1655	\N
758		\N		\N	\N	\N	296	\N
758		\N		\N	\N	\N	782	\N
968	Die	\N		\N	\N	\N	782	\N
1197		\N		\N	\N	\N	118	\N
1196		\N		\N	\N	\N	827	\N
900		\N		\N	\N	\N	539	\N
1060		\N		\N	\N	\N	215	\N
1109		\N		\N	\N	\N	1609	\N
1107		\N		\N	\N	\N	1608	\N
1127		\N		\N	\N	\N	183	\N
1132		\N		\N	\N	\N	771	\N
1156		\N		\N	\N	\N	717	\N
1019		\N		\N	\N	\N	567	\N
1125		\N		\N	\N	\N	665	\N
1134		\N		\N	\N	\N	248	\N
908		\N		\N	\N	\N	9	\N
722		\N		\N	\N	\N	161	\N
1140		\N		\N	\N	\N	45	\N
749		\N		\N	\N	\N	173	\N
792		\N		\N	\N	\N	108	\N
1168		\N		\N	\N	\N	1418	\N
717		\N		\N	\N	\N	250	\N
717		\N		\N	\N	\N	983	\N
718		\N		\N	\N	\N	82	\N
932		\N		\N	\N	\N	522	\N
932		\N		\N	\N	\N	521	\N
964	feiert	\N		\N	\N	\N	521	\N
803		\N		\N	\N	\N	1332	\N
1176		\N		\N	\N	\N	256	\N
1110		\N		\N	\N	\N	1600	\N
993		\N		\N	\N	\N	735	\N
867		\N		\N	\N	\N	637	\N
729		\N		\N	\N	\N	588	\N
1138		\N		\N	\N	\N	227	\N
991		\N		\N	\N	\N	1073	\N
1177		\N		\N	\N	\N	264	\N
928		\N		\N	\N	\N	353	\N
831		\N		\N	\N	\N	75	\N
832		\N		\N	\N	\N	472	\N
1208		\N		\N	\N	\N	1526	\N
977		\N		\N	\N	\N	1342	\N
1023		\N		\N	\N	\N	1499	\N
843		\N		\N	\N	\N	362	\N
959		\N		\N	\N	\N	30	\N
1150		\N		\N	\N	\N	1033	\N
967		\N		\N	\N	\N	1352	\N
1118		\N		\N	\N	\N	109	\N
836		\N		\N	\N	\N	1197	\N
1104		\N		\N	\N	\N	193	\N
992		\N		\N	\N	\N	141	\N
739		\N		\N	\N	\N	65	\N
731		\N		\N	\N	\N	1361	\N
888		\N		\N	\N	\N	1267	\N
989		\N		\N	\N	\N	208	\N
1167	meins	\N		\N	\N	\N	208	\N
858		\N		\N	\N	\N	324	\N
1160		\N		\N	\N	\N	199	\N
930		\N		\N	\N	\N	1292	\N
737		\N		\N	\N	\N	114	\N
833		\N		\N	\N	\N	758	\N
937		\N		\N	\N	\N	487	\N
881		\N		\N	\N	\N	1635	\N
741		\N		\N	\N	\N	754	\N
882		\N		\N	\N	\N	347	\N
750		\N		\N	\N	\N	1478	\N
1056		\N		\N	\N	\N	304	\N
1056		\N		\N	\N	\N	1225	\N
793		\N		\N	\N	\N	89	\N
715		\N		\N	\N	\N	1445	\N
866		\N		\N	\N	\N	1293	\N
887		\N		\N	\N	\N	316	\N
947		\N		\N	\N	\N	669	\N
840		\N		\N	\N	\N	85	\N
1008		\N		\N	\N	\N	116	\N
1128		\N		\N	\N	\N	126	\N
1136		\N		\N	\N	\N	478	\N
1022		\N		\N	\N	\N	196	\N
994		\N		\N	\N	\N	600	\N
1112		\N		\N	\N	\N	1645	\N
1106		\N		\N	\N	\N	174	\N
1143		\N		\N	\N	\N	184	\N
1170		\N		\N	\N	\N	1074	\N
769		\N		\N	\N	\N	1175	\N
787		\N		\N	\N	\N	215	\N
901		\N		\N	\N	\N	623	\N
997		\N		\N	\N	\N	263	\N
1169		\N		\N	\N	\N	207	\N
962		\N		\N	\N	\N	18	\N
1171		\N		\N	\N	\N	510	\N
1119		\N		\N	\N	\N	1375	\N
954		\N		\N	\N	\N	81	\N
813		\N		\N	\N	\N	14	\N
1111		\N		\N	\N	\N	1209	\N
755		\N		\N	\N	\N	1533	\N
1146		\N		\N	\N	\N	257	\N
762		\N		\N	\N	\N	329	\N
795		\N		\N	\N	\N	83	\N
880		\N		\N	\N	\N	511	\N
710		\N		\N	\N	\N	152	\N
1018		\N		\N	\N	\N	732	\N
1113		\N		\N	\N	\N	1200	\N
1113		\N		\N	\N	\N	1653	\N
827		\N		\N	\N	\N	344	\N
849		\N		\N	\N	\N	194	\N
740		\N		\N	\N	\N	508	\N
772		\N		\N	\N	\N	1433	\N
746		\N		\N	\N	\N	358	\N
1152		\N		\N	\N	\N	491	\N
716		\N		\N	\N	\N	279	\N
944		\N		\N	\N	\N	637	\N
1205		\N		\N	\N	\N	1525	\N
784		\N		\N	\N	\N	778	\N
735		\N		\N	\N	\N	195	\N
743		\N		\N	\N	\N	1699	\N
743	bogenはbiegenの過去複数形	\N		\N	\N	\N	1700	\N
936		\N		\N	\N	\N	136	\N
753	beschäftigtはbeschäftigenの過去分詞形	\N		\N	\N	\N	1701	\N
753		\N		\N	\N	\N	282	\N
1152		\N		\N	\N	\N	126	\N
1217	hier	\N		\N	\N	\N	126	\N
1174		\N		\N	\N	\N	1702	\N
889		\N		\N	\N	\N	1703	\N
982		\N		\N	\N	\N	1501	\N
982		\N		\N	\N	\N	889	\N
982		\N		\N	\N	\N	1704	\N
1223		\N		\N	\N	\N	1455	\N
1225		\N		\N	\N	\N	1605	\N
1034		\N		\N	\N	\N	1705	\N
1046		\N		\N	\N	\N	1706	\N
854		\N		\N	\N	\N	323	\N
1036		\N		\N	\N	\N	1707	\N
1052		\N		\N	\N	\N	1708	\N
1052		\N		\N	\N	\N	1709	\N
912		\N		\N	\N	\N	1710	\N
709		\N		\N	\N	\N	1711	\N
709		\N		\N	\N	\N	1713	\N
835		\N		\N	\N	\N	1714	\N
835		\N		\N	\N	\N	1715	\N
1032		\N		\N	\N	\N	1716	\N
1163		\N		\N	\N	\N	1717	\N
708		\N		\N	\N	\N	1718	\N
940		\N		\N	\N	\N	1719	\N
1148		\N		\N	\N	\N	1720	\N
1221		\N		\N	\N	\N	1721	\N
754		\N		\N	\N	\N	1723	\N
922		\N		\N	\N	\N	1724	\N
811		\N		\N	\N	\N	212	\N
961		\N		\N	\N	\N	80	\N
1086		\N		\N	\N	\N	1725	\N
1035		\N		\N	\N	\N	1726	\N
747		\N		\N	\N	\N	1727	\N
949		\N		\N	\N	\N	1728	\N
1185		\N		\N	\N	\N	1729	\N
861		\N		\N	\N	\N	1730	\N
1202		\N		\N	\N	\N	1731	\N
765		\N		\N	\N	\N	1732	\N
1073		\N		\N	\N	\N	1733	\N
1059		\N		\N	\N	\N	1734	\N
720		\N		\N	\N	\N	1735	\N
1203		\N		\N	\N	\N	1736	\N
914		\N		\N	\N	\N	1737	\N
1057		\N		\N	\N	\N	1738	\N
897		\N		\N	\N	\N	1739	\N
1175		\N		\N	\N	\N	1740	\N
903		\N		\N	\N	\N	1741	\N
1013	Cousine　（女の）いとこ	\N		\N	\N	\N	1742	\N
1089		\N		\N	\N	\N	1743	\N
995		\N		\N	\N	\N	1744	\N
978		\N		\N	\N	\N	1745	\N
1218		\N		\N	\N	\N	1746	\N
1190		\N		\N	\N	\N	1747	\N
1063		\N		\N	\N	\N	1748	\N
906		\N		\N	\N	\N	1749	\N
929		\N		\N	\N	\N	1750	\N
870		\N		\N	\N	\N	1751	\N
969		\N		\N	\N	\N	1752	\N
1188		\N		\N	\N	\N	1753	\N
864		\N		\N	\N	\N	1754	\N
805		\N		\N	\N	\N	1755	\N
976		\N		\N	\N	\N	1756	\N
1079		\N		\N	\N	\N	1757	\N
775		\N		\N	\N	\N	1758	\N
707		\N		\N	\N	\N	1759	\N
830		\N		\N	\N	\N	1760	\N
830		\N		\N	\N	\N	1761	\N
983		\N		\N	\N	\N	1762	\N
1122		\N		\N	\N	\N	1764	\N
1064		\N		\N	\N	\N	1765	\N
1083		\N		\N	\N	\N	1766	\N
1054	morgen	\N		\N	\N	\N	1767	\N
1049	ja	\N		\N	\N	\N	1722	\N
1054		\N		\N	\N	\N	1768	\N
1141		\N		\N	\N	\N	1769	\N
1121	gut	\N		\N	\N	\N	1771	\N
941		\N		\N	\N	\N	1772	\N
777	lese	\N		\N	\N	\N	362	\N
777	gern	\N		\N	\N	\N	603	\N
771		\N		\N	\N	\N	1763	\N
778		\N		\N	\N	\N	1773	\N
1178		\N		\N	\N	\N	1774	\N
875		\N		\N	\N	\N	1775	\N
862		\N		\N	\N	\N	1776	\N
1016		\N		\N	\N	\N	1777	\N
984		\N		\N	\N	\N	1779	\N
1048		\N		\N	\N	\N	1780	\N
1017		\N		\N	\N	\N	1781	\N
1210		\N		\N	\N	\N	1782	\N
732		\N		\N	\N	\N	1783	\N
842		\N		\N	\N	\N	1784	\N
1162		\N		\N	\N	\N	1785	\N
801	wirklich	\N		\N	\N	\N	1097	\N
801	hast	\N		\N	\N	\N	106	\N
745		\N		\N	\N	\N	955	\N
1115		\N		\N	\N	\N	1787	\N
824		\N		\N	\N	\N	1789	\N
1005		\N		\N	\N	\N	1790	\N
999		\N		\N	\N	\N	1791	\N
727	schenke	\N		\N	\N	\N	796	\N
857		\N		\N	\N	\N	1793	\N
1088		\N		\N	\N	\N	1794	\N
1144		\N		\N	\N	\N	1795	\N
933		\N		\N	\N	\N	1796	\N
1087		\N		\N	\N	\N	1797	\N
1097	lieb	\N		\N	\N	\N	1798	\N
1095		\N		\N	\N	\N	1799	\N
1195		\N		\N	\N	\N	1800	\N
1195		\N		\N	\N	\N	1584	\N
1199	hoffe	\N		\N	\N	\N	1800	\N
879		\N		\N	\N	\N	1802	\N
1133		\N		\N	\N	\N	1803	\N
1001		\N		\N	\N	\N	1804	\N
1101		\N		\N	\N	\N	1805	\N
1019		\N		\N	\N	\N	287	\N
1029	fahre	\N		\N	\N	\N	287	\N
1029	mit	\N		\N	\N	\N	567	\N
722	jetzt	\N		\N	\N	\N	162	\N
776	Ins	\N		\N	\N	\N	160	\N
1094		\N		\N	\N	\N	1806	\N
721		\N		\N	\N	\N	1807	\N
1045		\N		\N	\N	\N	1808	\N
1222		\N		\N	\N	\N	1809	\N
1219		\N		\N	\N	\N	1480	\N
1219		\N		\N	\N	\N	99	\N
815	mir geht's	\N		\N	\N	\N	1291	\N
809		\N		\N	\N	\N	110	\N
809		\N		\N	\N	\N	111	\N
816	arbeiten	\N		\N	\N	\N	111	\N
816	Na ja	\N		\N	\N	\N	110	\N
981		\N		\N	\N	\N	1810	\N
981		\N		\N	\N	\N	1811	\N
1116		\N		\N	\N	\N	302	\N
979	Dann	\N		\N	\N	\N	1544	\N
979	Tschüs	\N		\N	\N	\N	292	\N
985		\N		\N	\N	\N	1812	\N
1098		\N		\N	\N	\N	1813	\N
871		\N		\N	\N	\N	650	\N
1145		\N		\N	\N	\N	1362	\N
1020		\N		\N	\N	\N	72	\N
1080	vergessen	\N		\N	\N	\N	669	\N
770		\N		\N	\N	\N	1814	\N
1072		\N		\N	\N	\N	1815	\N
1053		\N		\N	\N	\N	1816	\N
1099		\N		\N	\N	\N	1817	\N
1213		\N		\N	\N	\N	1818	\N
1212		\N		\N	\N	\N	722	\N
1041		\N		\N	\N	\N	1057	\N
919		\N		\N	\N	\N	77	\N
946		\N		\N	\N	\N	1819	\N
814		\N		\N	\N	\N	1820	\N
807		\N		\N	\N	\N	1821	\N
806	Preislage	\N		\N	\N	\N	1821	\N
733		\N		\N	\N	\N	1822	\N
1211		\N		\N	\N	\N	1823	\N
850		\N		\N	\N	\N	1824	\N
850		\N		\N	\N	\N	1825	\N
935		\N		\N	\N	\N	1826	\N
783		\N		\N	\N	\N	1827	\N
1039		\N		\N	\N	\N	1828	\N
718	mich	\N		\N	\N	\N	109	\N
899		\N		\N	\N	\N	1829	\N
764		\N		\N	\N	\N	1830	\N
996		\N		\N	\N	\N	1831	\N
1124		\N		\N	\N	\N	1832	\N
956	wirklich	\N		\N	\N	\N	189	\N
1209	mehr	\N		\N	\N	\N	1796	\N
779		\N		\N	\N	\N	1833	\N
898		\N		\N	\N	\N	1834	\N
896		\N		\N	\N	\N	1835	\N
818		\N		\N	\N	\N	1745	\N
952		\N		\N	\N	\N	457	\N
825	zur	\N		\N	\N	\N	1483	\N
1166		\N		\N	\N	\N	1837	\N
726		\N		\N	\N	\N	1838	\N
890		\N		\N	\N	\N	1839	\N
1067		\N		\N	\N	\N	1840	\N
1153		\N		\N	\N	\N	1841	\N
818		\N		\N	\N	\N	1842	\N
773		\N		\N	\N	\N	1843	\N
977		\N		\N	\N	\N	1669	\N
723		\N		\N	\N	\N	1337	\N
1145		\N		\N	\N	\N	1219	\N
728	können	\N		\N	\N	\N	1362	\N
1027		\N		\N	\N	\N	1501	\N
1000		\N		\N	\N	\N	1294	\N
822	im	\N		\N	\N	\N	1294	\N
966	fahr'  fahre	\N		\N	\N	\N	1617	\N
794	China	\N		\N	\N	\N	89	\N
1151		\N		\N	\N	\N	1844	\N
1142		\N		\N	\N	\N	1630	\N
1066		\N		\N	\N	\N	1845	\N
992		\N		\N	\N	\N	1846	\N
882		\N		\N	\N	\N	1349	\N
883	denn	\N		\N	\N	\N	347	\N
883	Urlaub	\N		\N	\N	\N	1349	\N
846		\N		\N	\N	\N	1847	\N
1077		\N		\N	\N	\N	1848	\N
1028	ach	\N		\N	\N	\N	196	\N
1142	Film	\N		\N	\N	\N	257	\N
1146	Kultur	\N		\N	\N	\N	1630	\N
853		\N		\N	\N	\N	1849	\N
878		\N		\N	\N	\N	1850	\N
1161		\N		\N	\N	\N	1851	\N
1172	da	\N		\N	\N	\N	1851	\N
973	toll	\N		\N	\N	\N	350	\N
1123		\N		\N	\N	\N	1852	\N
1173	endlich	\N		\N	\N	\N	837	\N
1165	vorbei	\N		\N	\N	\N	837	\N
1173	Elke	\N		\N	\N	\N	139	\N
1187		\N		\N	\N	\N	1853	\N
980	jetzt	\N		\N	\N	\N	852	\N
860		\N		\N	\N	\N	1836	\N
761		\N		\N	\N	\N	1393	\N
1010		\N		\N	\N	\N	112	\N
1010		\N		\N	\N	\N	113	\N
1128	letztes	\N		\N	\N	\N	1848	\N
1077	mir	\N		\N	\N	\N	126	\N
1008		\N		\N	\N	\N	115	\N
1138		\N		\N	\N	\N	1521	\N
938	zwei	\N		\N	\N	\N	1521	\N
869		\N		\N	\N	\N	1854	\N
848		\N		\N	\N	\N	1855	\N
838		\N		\N	\N	\N	1856	\N
821		\N		\N	\N	\N	117	\N
821		\N		\N	\N	\N	118	\N
1131		\N		\N	\N	\N	1857	\N
763		\N		\N	\N	\N	1858	\N
1103		\N		\N	\N	\N	1859	\N
1102		\N		\N	\N	\N	1860	\N
1224		\N		\N	\N	\N	1861	\N
1201		\N		\N	\N	\N	1862	\N
974		\N		\N	\N	\N	125	\N
963	jetzt	\N		\N	\N	\N	521	\N
788		\N		\N	\N	\N	1864	\N
902	doch	\N		\N	\N	\N	216	\N
1065		\N		\N	\N	\N	1865	\N
1065		\N		\N	\N	\N	1866	\N
782	aufgeregt	\N		\N	\N	\N	215	\N
782	wiederzusehen	\N		\N	\N	\N	274	\N
724		\N		\N	\N	\N	1868	\N
920	geplant	\N		\N	\N	\N	255	\N
791		\N		\N	\N	\N	1869	\N
947		\N		\N	\N	\N	798	\N
1215	am	\N		\N	\N	\N	798	\N
1181	Frankreich	\N		\N	\N	\N	1729	\N
1181		\N		\N	\N	\N	1870	\N
1055	gelebt	\N		\N	\N	\N	1730	\N
892		\N		\N	\N	\N	1871	\N
1074		\N		\N	\N	\N	1872	\N
823		\N		\N	\N	\N	1873	\N
863		\N		\N	\N	\N	1874	\N
1068	einfach	\N		\N	\N	\N	491	\N
1135		\N		\N	\N	\N	1050	\N
913		\N		\N	\N	\N	1875	\N
841	Was	\N		\N	\N	\N	202	\N
1085		\N		\N	\N	\N	1876	\N
940		\N		\N	\N	\N	1877	\N
868		\N		\N	\N	\N	288	\N
868		\N		\N	\N	\N	1596	\N
1185		\N		\N	\N	\N	1878	\N
1220		\N		\N	\N	\N	1293	\N
967		\N		\N	\N	\N	1366	\N
967		\N		\N	\N	\N	730	\N
967		\N		\N	\N	\N	889	\N
967		\N		\N	\N	\N	1022	\N
965	Riesenportion	\N		\N	\N	\N	526	\N
992	groß	\N		\N	\N	\N	392	\N
1179		\N		\N	\N	\N	1882	\N
1015		\N		\N	\N	\N	1883	\N
1030		\N		\N	\N	\N	1884	\N
886		\N		\N	\N	\N	1886	\N
855		\N		\N	\N	\N	1887	\N
744		\N		\N	\N	\N	1888	\N
803		\N		\N	\N	\N	1868	\N
982		\N		\N	\N	\N	361	\N
982		\N		\N	\N	\N	1890	\N
1223		\N		\N	\N	\N	1578	\N
1223		\N		\N	\N	\N	1651	\N
851		\N		\N	\N	\N	587	\N
1035	richtig	\N		\N	\N	\N	1705	\N
751		\N		\N	\N	\N	178	\N
751		\N		\N	\N	\N	1697	\N
752		\N		\N	\N	\N	376	\N
752		\N		\N	\N	\N	1694	\N
1183		\N		\N	\N	\N	201	\N
1183		\N		\N	\N	\N	294	\N
826	Erst	\N		\N	\N	\N	1332	\N
826	hab'	\N		\N	\N	\N	1868	\N
803		\N		\N	\N	\N	1891	\N
826	ja	\N		\N	\N	\N	1891	\N
1032		\N		\N	\N	\N	1892	\N
742		\N		\N	\N	\N	196	\N
742		\N		\N	\N	\N	529	\N
1163		\N		\N	\N	\N	1893	\N
905		\N		\N	\N	\N	1894	\N
1070		\N		\N	\N	\N	1895	\N
1070		\N		\N	\N	\N	1896	\N
1217		\N		\N	\N	\N	1897	\N
1157		\N		\N	\N	\N	1757	\N
911		\N		\N	\N	\N	132	\N
911		\N		\N	\N	\N	1064	\N
924		\N		\N	\N	\N	1385	\N
924		\N		\N	\N	\N	1898	\N
924		\N		\N	\N	\N	1899	\N
720		\N		\N	\N	\N	1900	\N
918		\N		\N	\N	\N	1901	\N
917		\N		\N	\N	\N	1902	\N
1075		\N		\N	\N	\N	1903	\N
1026	Claudia	\N		\N	\N	\N	95	\N
1026	Das	\N		\N	\N	\N	1472	\N
1014		\N		\N	\N	\N	1904	\N
1014		\N		\N	\N	\N	1905	\N
1014		\N		\N	\N	\N	1906	\N
1026	mit	\N		\N	\N	\N	1906	\N
759		\N		\N	\N	\N	487	\N
759		\N		\N	\N	\N	776	\N
734		\N		\N	\N	\N	654	\N
734		\N		\N	\N	\N	1907	\N
1057		\N		\N	\N	\N	1908	\N
1174		\N		\N	\N	\N	1909	\N
877		\N		\N	\N	\N	1241	\N
1078		\N		\N	\N	\N	1677	\N
903		\N		\N	\N	\N	1910	\N
811		\N		\N	\N	\N	719	\N
811		\N		\N	\N	\N	295	\N
811		\N		\N	\N	\N	232	\N
1225		\N		\N	\N	\N	1050	\N
1225		\N		\N	\N	\N	1155	\N
754		\N		\N	\N	\N	1252	\N
1225		\N		\N	\N	\N	1465	\N
961		\N		\N	\N	\N	315	\N
961		\N		\N	\N	\N	337	\N
1180		\N		\N	\N	\N	222	\N
1180		\N		\N	\N	\N	480	\N
1180		\N		\N	\N	\N	547	\N
1180		\N		\N	\N	\N	742	\N
968		\N		\N	\N	\N	1738	\N
972	wirklich	\N		\N	\N	\N	782	\N
972	super	\N		\N	\N	\N	1738	\N
968		\N		\N	\N	\N	1911	\N
972	wissen	\N		\N	\N	\N	1911	\N
968		\N		\N	\N	\N	1912	\N
972	drin	\N		\N	\N	\N	1912	\N
968		\N		\N	\N	\N	1913	\N
972	mal	\N		\N	\N	\N	1913	\N
960		\N		\N	\N	\N	349	\N
1002		\N		\N	\N	\N	25	\N
1108		\N		\N	\N	\N	1914	\N
960		\N		\N	\N	\N	1382	\N
958		\N		\N	\N	\N	804	\N
958		\N		\N	\N	\N	823	\N
958		\N		\N	\N	\N	965	\N
1105		\N		\N	\N	\N	1915	\N
1206	da	\N		\N	\N	\N	1744	\N
995		\N		\N	\N	\N	1916	\N
1206	schon	\N		\N	\N	\N	1916	\N
995		\N		\N	\N	\N	1917	\N
1206	da	\N		\N	\N	\N	1917	\N
970	kann	\N		\N	\N	\N	1745	\N
970		\N		\N	\N	\N	1918	\N
978		\N		\N	\N	\N	1918	\N
970		\N		\N	\N	\N	1919	\N
978	kann	\N		\N	\N	\N	1919	\N
943		\N		\N	\N	\N	1920	\N
948		\N		\N	\N	\N	1921	\N
943		\N		\N	\N	\N	1877	\N
1218		\N		\N	\N	\N	1922	\N
906		\N		\N	\N	\N	1923	\N
950	Kartenautomat	\N		\N	\N	\N	1923	\N
929		\N		\N	\N	\N	1924	\N
1021		\N		\N	\N	\N	340	\N
1021		\N		\N	\N	\N	1047	\N
706		\N		\N	\N	\N	882	\N
910		\N		\N	\N	\N	1925	\N
951		\N		\N	\N	\N	66	\N
859		\N		\N	\N	\N	1926	\N
1188		\N		\N	\N	\N	1927	\N
1184		\N		\N	\N	\N	1928	\N
1184		\N		\N	\N	\N	1929	\N
895		\N		\N	\N	\N	367	\N
895		\N		\N	\N	\N	1267	\N
895		\N		\N	\N	\N	1453	\N
902		\N		\N	\N	\N	1438	\N
864		\N		\N	\N	\N	1930	\N
864		\N		\N	\N	\N	1931	\N
735		\N		\N	\N	\N	352	\N
735		\N		\N	\N	\N	481	\N
784		\N		\N	\N	\N	1932	\N
785	wohl	\N		\N	\N	\N	778	\N
785	besuchen	\N		\N	\N	\N	1932	\N
1205		\N		\N	\N	\N	1933	\N
716		\N		\N	\N	\N	153	\N
716		\N		\N	\N	\N	251	\N
805		\N		\N	\N	\N	120	\N
805		\N		\N	\N	\N	121	\N
805		\N		\N	\N	\N	1934	\N
1090		\N		\N	\N	\N	1935	\N
944		\N		\N	\N	\N	1936	\N
976		\N		\N	\N	\N	1937	\N
976		\N		\N	\N	\N	1938	\N
1152	vergessen	\N		\N	\N	\N	1757	\N
1079		\N		\N	\N	\N	491	\N
1079	hätten ... Spaß	\N		\N	\N	\N	126	\N
1079		\N		\N	\N	\N	1939	\N
1152	mir ... vorstellen	\N		\N	\N	\N	1939	\N
772		\N		\N	\N	\N	1940	\N
1158		\N		\N	\N	\N	113	\N
849		\N		\N	\N	\N	1247	\N
849		\N		\N	\N	\N	1941	\N
710		\N		\N	\N	\N	1100	\N
1192	jemand	\N		\N	\N	\N	732	\N
827		\N		\N	\N	\N	256	\N
1018		\N		\N	\N	\N	378	\N
1018		\N		\N	\N	\N	1684	\N
1018		\N		\N	\N	\N	1686	\N
1018		\N		\N	\N	\N	1890	\N
1192	erstaunlich	\N		\N	\N	\N	1890	\N
1193	gesprochen	\N		\N	\N	\N	1890	\N
1192	Italienerin	\N		\N	\N	\N	378	\N
1193	wollte	\N		\N	\N	\N	378	\N
1193	der	\N		\N	\N	\N	732	\N
1192		\N		\N	\N	\N	1684	\N
1193	müssen	\N		\N	\N	\N	1684	\N
1192	echt	\N		\N	\N	\N	1686	\N
1193	jemanden	\N		\N	\N	\N	1686	\N
827		\N		\N	\N	\N	1209	\N
827		\N		\N	\N	\N	1613	\N
1141		\N		\N	\N	\N	233	\N
1141		\N		\N	\N	\N	1172	\N
1141		\N		\N	\N	\N	1439	\N
1141		\N		\N	\N	\N	1212	\N
941		\N		\N	\N	\N	1771	\N
786		\N		\N	\N	\N	1942	\N
777		\N		\N	\N	\N	363	\N
1064		\N		\N	\N	\N	777	\N
777		\N		\N	\N	\N	1943	\N
1159		\N		\N	\N	\N	195	\N
1159		\N		\N	\N	\N	1141	\N
705		\N		\N	\N	\N	1589	\N
705		\N		\N	\N	\N	602	\N
705		\N		\N	\N	\N	1041	\N
705		\N		\N	\N	\N	1420	\N
705		\N		\N	\N	\N	711	\N
705		\N		\N	\N	\N	188	\N
705		\N		\N	\N	\N	1944	\N
1207		\N		\N	\N	\N	1945	\N
904		\N		\N	\N	\N	255	\N
904		\N		\N	\N	\N	1946	\N
1048		\N		\N	\N	\N	1948	\N
1129		\N		\N	\N	\N	1353	\N
1130		\N		\N	\N	\N	1478	\N
884		\N		\N	\N	\N	623	\N
971		\N		\N	\N	\N	767	\N
1147		\N		\N	\N	\N	1949	\N
862		\N		\N	\N	\N	1950	\N
862		\N		\N	\N	\N	1951	\N
971		\N		\N	\N	\N	1878	\N
971		\N		\N	\N	\N	1952	\N
1024		\N		\N	\N	\N	277	\N
986		\N		\N	\N	\N	1174	\N
723	doch	\N		\N	\N	\N	1174	\N
986		\N		\N	\N	\N	246	\N
986		\N		\N	\N	\N	1041	\N
723	nämlich	\N		\N	\N	\N	1041	\N
986		\N		\N	\N	\N	1337	\N
723	nass	\N		\N	\N	\N	1630	\N
986		\N		\N	\N	\N	1512	\N
723	mir	\N		\N	\N	\N	1512	\N
986		\N		\N	\N	\N	1953	\N
723	vergrößern	\N		\N	\N	\N	1953	\N
1050		\N		\N	\N	\N	1954	\N
1033		\N		\N	\N	\N	113	\N
789		\N		\N	\N	\N	155	\N
789		\N		\N	\N	\N	891	\N
789		\N		\N	\N	\N	316	\N
789		\N		\N	\N	\N	1704	\N
839		\N		\N	\N	\N	1955	\N
839		\N		\N	\N	\N	1956	\N
1162		\N		\N	\N	\N	1957	\N
1162		\N		\N	\N	\N	1958	\N
801		\N		\N	\N	\N	1224	\N
1161		\N		\N	\N	\N	1959	\N
987		\N		\N	\N	\N	1960	\N
987		\N		\N	\N	\N	1961	\N
987		\N		\N	\N	\N	1962	\N
1204	genau	\N		\N	\N	\N	1960	\N
1204	beim	\N		\N	\N	\N	1961	\N
1204	Sache	\N		\N	\N	\N	1962	\N
745		\N		\N	\N	\N	1862	\N
1031	wohnt	\N		\N	\N	\N	1862	\N
1115		\N		\N	\N	\N	1963	\N
1126		\N		\N	\N	\N	1073	\N
1126		\N		\N	\N	\N	1228	\N
810		\N		\N	\N	\N	1833	\N
810		\N		\N	\N	\N	173	\N
810		\N		\N	\N	\N	326	\N
810		\N		\N	\N	\N	1183	\N
1012		\N		\N	\N	\N	1564	\N
1012		\N		\N	\N	\N	1964	\N
1186		\N		\N	\N	\N	1965	\N
767		\N		\N	\N	\N	1966	\N
767		\N		\N	\N	\N	1967	\N
817		\N		\N	\N	\N	336	\N
817		\N		\N	\N	\N	399	\N
934		\N		\N	\N	\N	1705	\N
711		\N		\N	\N	\N	1968	\N
774		\N		\N	\N	\N	1969	\N
953		\N		\N	\N	\N	1149	\N
953		\N		\N	\N	\N	499	\N
1139		\N		\N	\N	\N	1970	\N
990		\N		\N	\N	\N	1696	\N
909		\N		\N	\N	\N	1356	\N
909		\N		\N	\N	\N	1122	\N
939		\N		\N	\N	\N	198	\N
1116		\N		\N	\N	\N	1971	\N
1114		\N		\N	\N	\N	327	\N
1114		\N		\N	\N	\N	780	\N
712		\N		\N	\N	\N	1277	\N
1117		\N		\N	\N	\N	1376	\N
1092		\N		\N	\N	\N	1972	\N
973		\N		\N	\N	\N	1973	\N
1093		\N		\N	\N	\N	1974	\N
876		\N		\N	\N	\N	1123	\N
1165		\N		\N	\N	\N	45	\N
1173	Warum	\N		\N	\N	\N	45	\N
1071		\N		\N	\N	\N	1975	\N
1076		\N		\N	\N	\N	1976	\N
926		\N		\N	\N	\N	382	\N
931		\N		\N	\N	\N	74	\N
1219		\N		\N	\N	\N	982	\N
1191		\N		\N	\N	\N	1105	\N
1191		\N		\N	\N	\N	1162	\N
1191		\N		\N	\N	\N	528	\N
828		\N		\N	\N	\N	1977	\N
829		\N		\N	\N	\N	1978	\N
916		\N		\N	\N	\N	1979	\N
916		\N		\N	\N	\N	1980	\N
855		\N		\N	\N	\N	1981	\N
942		\N		\N	\N	\N	1982	\N
856		\N		\N	\N	\N	1983	\N
908		\N		\N	\N	\N	744	\N
736		\N		\N	\N	\N	1984	\N
1043		\N		\N	\N	\N	1985	\N
1044	das	\N		\N	\N	\N	1985	\N
980		\N		\N	\N	\N	1928	\N
980		\N		\N	\N	\N	1986	\N
980		\N		\N	\N	\N	1987	\N
980		\N		\N	\N	\N	1988	\N
760		\N		\N	\N	\N	1989	\N
1047		\N		\N	\N	\N	1990	\N
1084		\N		\N	\N	\N	1991	\N
796		\N		\N	\N	\N	1992	\N
819		\N		\N	\N	\N	1993	\N
819		\N		\N	\N	\N	1994	\N
766		\N		\N	\N	\N	1995	\N
714		\N		\N	\N	\N	1996	\N
824		\N		\N	\N	\N	1997	\N
837		\N		\N	\N	\N	472	\N
837		\N		\N	\N	\N	78	\N
847		\N		\N	\N	\N	368	\N
975	setzen ... sich	\N		\N	\N	\N	368	\N
975	hier	\N		\N	\N	\N	253	\N
925	magst	\N		\N	\N	\N	1655	\N
1074		\N		\N	\N	\N	1998	\N
1149		\N		\N	\N	\N	1999	\N
1144		\N		\N	\N	\N	2000	\N
1198	japanisches	\N		\N	\N	\N	827	\N
1196		\N		\N	\N	\N	1499	\N
1198	um	\N		\N	\N	\N	1499	\N
1199	gefällt	\N		\N	\N	\N	1584	\N
1196		\N		\N	\N	\N	1564	\N
1198	Magisterarbeit	\N		\N	\N	\N	1564	\N
1196		\N		\N	\N	\N	282	\N
708		\N		\N	\N	\N	1792	\N
1198	wollte	\N		\N	\N	\N	282	\N
857		\N		\N	\N	\N	2001	\N
1001		\N		\N	\N	\N	1876	\N
1107		\N		\N	\N	\N	1498	\N
1127		\N		\N	\N	\N	207	\N
1222		\N		\N	\N	\N	2002	\N
1125		\N		\N	\N	\N	1571	\N
776	jetzt	\N		\N	\N	\N	161	\N
776	denn	\N		\N	\N	\N	162	\N
722	Zentrum	\N		\N	\N	\N	160	\N
776		\N		\N	\N	\N	155	\N
722	brauchen\n	\N		\N	\N	\N	155	\N
776		\N		\N	\N	\N	2003	\N
722	bis	\N		\N	\N	\N	2003	\N
1132		\N		\N	\N	\N	2004	\N
1134		\N		\N	\N	\N	934	\N
1134		\N		\N	\N	\N	1344	\N
981		\N		\N	\N	\N	2005	\N
981		\N		\N	\N	\N	2006	\N
815		\N		\N	\N	\N	2007	\N
1051		\N		\N	\N	\N	2008	\N
809		\N		\N	\N	\N	1301	\N
816	Geburtstag	\N		\N	\N	\N	1301	\N
809		\N		\N	\N	\N	2009	\N
816	da	\N		\N	\N	\N	2009	\N
979		\N		\N	\N	\N	1321	\N
985		\N		\N	\N	\N	2010	\N
1140		\N		\N	\N	\N	614	\N
1140		\N		\N	\N	\N	1344	\N
1140		\N		\N	\N	\N	823	\N
1140		\N		\N	\N	\N	1089	\N
1006		\N		\N	\N	\N	2011	\N
871		\N		\N	\N	\N	2012	\N
1020		\N		\N	\N	\N	64	\N
1009		\N		\N	\N	\N	2013	\N
1009		\N		\N	\N	\N	2014	\N
1003		\N		\N	\N	\N	2015	\N
1038		\N		\N	\N	\N	2016	\N
1212		\N		\N	\N	\N	348	\N
923		\N		\N	\N	\N	1010	\N
919		\N		\N	\N	\N	2017	\N
915		\N		\N	\N	\N	2018	\N
923		\N		\N	\N	\N	2019	\N
923		\N		\N	\N	\N	124	\N
1211		\N		\N	\N	\N	2020	\N
845		\N		\N	\N	\N	719	\N
845		\N		\N	\N	\N	321	\N
783		\N		\N	\N	\N	2021	\N
886	kleinen	\N		\N	\N	\N	1867	\N
749		\N		\N	\N	\N	185	\N
799		\N		\N	\N	\N	2022	\N
800		\N		\N	\N	\N	2023	\N
790		\N		\N	\N	\N	2024	\N
790		\N		\N	\N	\N	2025	\N
996		\N		\N	\N	\N	2026	\N
844		\N		\N	\N	\N	2027	\N
844		\N		\N	\N	\N	2028	\N
1176		\N		\N	\N	\N	284	\N
1176		\N		\N	\N	\N	1665	\N
1110		\N		\N	\N	\N	1610	\N
898		\N		\N	\N	\N	2029	\N
802		\N		\N	\N	\N	1344	\N
802		\N		\N	\N	\N	1630	\N
802		\N		\N	\N	\N	680	\N
993	was	\N		\N	\N	\N	1838	\N
993		\N		\N	\N	\N	143	\N
993		\N		\N	\N	\N	1475	\N
726		\N		\N	\N	\N	143	\N
726		\N		\N	\N	\N	1475	\N
726	verkauft	\N		\N	\N	\N	735	\N
867		\N		\N	\N	\N	2030	\N
867		\N		\N	\N	\N	2031	\N
998		\N		\N	\N	\N	2032	\N
729		\N		\N	\N	\N	187	\N
729		\N		\N	\N	\N	1313	\N
1138		\N		\N	\N	\N	1188	\N
1138		\N		\N	\N	\N	1418	\N
1138		\N		\N	\N	\N	1624	\N
1138		\N		\N	\N	\N	1664	\N
1138		\N		\N	\N	\N	1107	\N
991		\N		\N	\N	\N	1554	\N
991		\N		\N	\N	\N	373	\N
991		\N		\N	\N	\N	1139	\N
991		\N		\N	\N	\N	1253	\N
1177		\N		\N	\N	\N	267	\N
1177		\N		\N	\N	\N	1491	\N
831		\N		\N	\N	\N	100	\N
832		\N		\N	\N	\N	894	\N
977		\N		\N	\N	\N	1322	\N
977		\N		\N	\N	\N	2033	\N
1024	das	\N		\N	\N	\N	1499	\N
1027	geht	\N		\N	\N	\N	1499	\N
1023		\N		\N	\N	\N	94	\N
1024	kann	\N		\N	\N	\N	94	\N
1027	mal	\N		\N	\N	\N	94	\N
1023		\N		\N	\N	\N	1501	\N
1024		\N		\N	\N	\N	1501	\N
1023	toll	\N		\N	\N	\N	277	\N
1027	toll	\N		\N	\N	\N	277	\N
952		\N		\N	\N	\N	69	\N
959		\N		\N	\N	\N	97	\N
921		\N		\N	\N	\N	1989	\N
1150		\N		\N	\N	\N	348	\N
965		\N		\N	\N	\N	2034	\N
1118		\N		\N	\N	\N	140	\N
1118		\N		\N	\N	\N	1198	\N
836		\N		\N	\N	\N	2035	\N
1104		\N		\N	\N	\N	1606	\N
1155		\N		\N	\N	\N	158	\N
1155		\N		\N	\N	\N	1364	\N
1155		\N		\N	\N	\N	482	\N
1155		\N		\N	\N	\N	1086	\N
719	was	\N		\N	\N	\N	158	\N
719	da	\N		\N	\N	\N	1364	\N
719	Fleiß	\N		\N	\N	\N	1086	\N
719	Wald	\N		\N	\N	\N	145	\N
731		\N		\N	\N	\N	1632	\N
1182		\N		\N	\N	\N	363	\N
1182		\N		\N	\N	\N	620	\N
888		\N		\N	\N	\N	1263	\N
989		\N		\N	\N	\N	2036	\N
858		\N		\N	\N	\N	351	\N
858		\N		\N	\N	\N	2037	\N
930		\N		\N	\N	\N	1874	\N
833		\N		\N	\N	\N	1667	\N
794		\N		\N	\N	\N	1891	\N
1006		\N		\N	\N	\N	2038	\N
886		\N		\N	\N	\N	2039	\N
834		\N		\N	\N	\N	329	\N
834		\N		\N	\N	\N	91	\N
988		\N		\N	\N	\N	2040	\N
988		\N		\N	\N	\N	2041	\N
1003		\N		\N	\N	\N	2042	\N
1040		\N		\N	\N	\N	487	\N
937		\N		\N	\N	\N	2043	\N
1040		\N		\N	\N	\N	2043	\N
1025		\N		\N	\N	\N	2044	\N
1037		\N		\N	\N	\N	2045	\N
1058		\N		\N	\N	\N	1635	\N
738		\N		\N	\N	\N	2046	\N
804	gemerkt	\N		\N	\N	\N	89	\N
872		\N		\N	\N	\N	2047	\N
872		\N		\N	\N	\N	2048	\N
873	Verständigen	\N		\N	\N	\N	2047	\N
873	Abteilungen	\N		\N	\N	\N	2048	\N
1081		\N		\N	\N	\N	2049	\N
1042		\N		\N	\N	\N	1731	\N
1042		\N		\N	\N	\N	1903	\N
715		\N		\N	\N	\N	2050	\N
715		\N		\N	\N	\N	2051	\N
866		\N		\N	\N	\N	1874	\N
887		\N		\N	\N	\N	1123	\N
887		\N		\N	\N	\N	1627	\N
748		\N		\N	\N	\N	262	\N
748		\N		\N	\N	\N	372	\N
748		\N		\N	\N	\N	1110	\N
748		\N		\N	\N	\N	1353	\N
852		\N		\N	\N	\N	1353	\N
748		\N		\N	\N	\N	2052	\N
1080	wie	\N		\N	\N	\N	798	\N
1010		\N		\N	\N	\N	345	\N
1010		\N		\N	\N	\N	583	\N
1010		\N		\N	\N	\N	937	\N
1136		\N		\N	\N	\N	1499	\N
1077		\N		\N	\N	\N	165	\N
1077		\N		\N	\N	\N	606	\N
1077		\N		\N	\N	\N	1651	\N
1128	Kunsthalle	\N		\N	\N	\N	606	\N
1128	warst	\N		\N	\N	\N	165	\N
1128	da	\N		\N	\N	\N	1651	\N
840		\N		\N	\N	\N	575	\N
1008		\N		\N	\N	\N	1223	\N
1022		\N		\N	\N	\N	610	\N
1028	lieber	\N		\N	\N	\N	610	\N
994		\N		\N	\N	\N	1155	\N
994		\N		\N	\N	\N	373	\N
994		\N		\N	\N	\N	315	\N
994		\N		\N	\N	\N	824	\N
994		\N		\N	\N	\N	1125	\N
994		\N		\N	\N	\N	1248	\N
821		\N		\N	\N	\N	119	\N
821		\N		\N	\N	\N	327	\N
821		\N		\N	\N	\N	1780	\N
821		\N		\N	\N	\N	1891	\N
821		\N		\N	\N	\N	1952	\N
1137		\N		\N	\N	\N	1981	\N
1011		\N		\N	\N	\N	2053	\N
1189		\N		\N	\N	\N	2054	\N
1112		\N		\N	\N	\N	278	\N
1106		\N		\N	\N	\N	1546	\N
1143		\N		\N	\N	\N	1181	\N
1143		\N		\N	\N	\N	1229	\N
1170		\N		\N	\N	\N	45	\N
769		\N		\N	\N	\N	128	\N
769		\N		\N	\N	\N	153	\N
769		\N		\N	\N	\N	293	\N
769		\N		\N	\N	\N	372	\N
769		\N		\N	\N	\N	1337	\N
1170		\N		\N	\N	\N	2055	\N
1170		\N		\N	\N	\N	2056	\N
787		\N		\N	\N	\N	2057	\N
797	Ausflüge	\N		\N	\N	\N	274	\N
797	sie	\N		\N	\N	\N	215	\N
782		\N		\N	\N	\N	2058	\N
797		\N		\N	\N	\N	2058	\N
852		\N		\N	\N	\N	2059	\N
901		\N		\N	\N	\N	884	\N
974		\N		\N	\N	\N	2060	\N
963		\N		\N	\N	\N	88	\N
963		\N		\N	\N	\N	394	\N
963		\N		\N	\N	\N	1512	\N
964	mit	\N		\N	\N	\N	1512	\N
964	das	\N		\N	\N	\N	394	\N
964	schaffe	\N		\N	\N	\N	88	\N
997		\N		\N	\N	\N	313	\N
956	so	\N		\N	\N	\N	966	\N
957	was	\N		\N	\N	\N	189	\N
957	müde	\N		\N	\N	\N	966	\N
955		\N		\N	\N	\N	1080	\N
955		\N		\N	\N	\N	2061	\N
955		\N		\N	\N	\N	363	\N
956		\N		\N	\N	\N	367	\N
957	sollte	\N		\N	\N	\N	367	\N
1214		\N		\N	\N	\N	174	\N
1214		\N		\N	\N	\N	915	\N
1214		\N		\N	\N	\N	1668	\N
1214		\N		\N	\N	\N	652	\N
1214		\N		\N	\N	\N	893	\N
1214		\N		\N	\N	\N	651	\N
1214		\N		\N	\N	\N	329	\N
1214		\N		\N	\N	\N	341	\N
1007		\N		\N	\N	\N	2062	\N
1007		\N		\N	\N	\N	2063	\N
1169		\N		\N	\N	\N	1073	\N
962		\N		\N	\N	\N	602	\N
962		\N		\N	\N	\N	1219	\N
962		\N		\N	\N	\N	1256	\N
962		\N		\N	\N	\N	1821	\N
962		\N		\N	\N	\N	1270	\N
962		\N		\N	\N	\N	825	\N
768		\N		\N	\N	\N	1248	\N
1119		\N		\N	\N	\N	2064	\N
954		\N		\N	\N	\N	157	\N
813		\N		\N	\N	\N	1591	\N
813		\N		\N	\N	\N	374	\N
1111		\N		\N	\N	\N	2065	\N
945		\N		\N	\N	\N	1376	\N
945		\N		\N	\N	\N	1968	\N
945		\N		\N	\N	\N	2044	\N
755		\N		\N	\N	\N	197	\N
1142		\N		\N	\N	\N	349	\N
1142		\N		\N	\N	\N	2066	\N
1146	nett	\N		\N	\N	\N	349	\N
1146		\N		\N	\N	\N	2066	\N
757		\N		\N	\N	\N	232	\N
757		\N		\N	\N	\N	335	\N
795		\N		\N	\N	\N	852	\N
874		\N		\N	\N	\N	80	\N
874		\N		\N	\N	\N	1111	\N
791		\N		\N	\N	\N	2005	\N
1195		\N		\N	\N	\N	936	\N
1199	nach	\N		\N	\N	\N	936	\N
1000		\N		\N	\N	\N	1382	\N
891		\N		\N	\N	\N	214	\N
891		\N		\N	\N	\N	308	\N
1139		\N		\N	\N	\N	2067	\N
730		\N		\N	\N	\N	659	\N
1096		\N		\N	\N	\N	758	\N
1008		\N		\N	\N	\N	191	\N
1096		\N		\N	\N	\N	2068	\N
1168		\N		\N	\N	\N	65	\N
737		\N		\N	\N	\N	2050	\N
904		\N		\N	\N	\N	376	\N
1004		\N		\N	\N	\N	2069	\N
1004		\N		\N	\N	\N	2070	\N
780		\N		\N	\N	\N	2071	\N
950	übrigens	\N		\N	\N	\N	1749	\N
924		\N		\N	\N	\N	2072	\N
1205		\N		\N	\N	\N	2073	\N
971		\N		\N	\N	\N	2074	\N
1164		\N		\N	\N	\N	2075	\N
714		\N		\N	\N	\N	2076	\N
808		\N		\N	\N	\N	2077	\N
847		\N		\N	\N	\N	2078	\N
975	etwa	\N		\N	\N	\N	2078	\N
892		\N		\N	\N	\N	2079	\N
871		\N		\N	\N	\N	2080	\N
988		\N		\N	\N	\N	2081	\N
1100		\N		\N	\N	\N	2082	\N
989		\N		\N	\N	\N	2083	\N
1042		\N		\N	\N	\N	2084	\N
974		\N		\N	\N	\N	2085	\N
1081		\N		\N	\N	\N	2086	\N
756		\N		\N	\N	\N	2087	\N
925	unserem	\N		\N	\N	\N	2087	\N
1139		\N		\N	\N	\N	215	\N
783		\N		\N	\N	\N	353	\N
783		\N		\N	\N	\N	1849	\N
966		\N		\N	\N	\N	2088	\N
982		\N		\N	\N	\N	2089	\N
743		\N		\N	\N	\N	2090	\N
952	bitte	\N		\N	\N	\N	182	\N
822		\N		\N	\N	\N	2091	\N
933		\N		\N	\N	\N	2021	\N
731		\N		\N	\N	\N	2067	\N
1226		\N		\N	\N	\N	2067	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: de
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

