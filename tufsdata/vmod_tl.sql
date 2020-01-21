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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO tl;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO tl;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO tl;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: tl
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


ALTER TABLE public.t_instance OWNER TO tl;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO tl;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO tl;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: tl
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


ALTER TABLE public.t_usage_classified_rel OWNER TO tl;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: tl
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


ALTER TABLE public.t_usage_inst_rel OWNER TO tl;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO tl;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO tl;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: tl
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO tl;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: tl
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


ALTER TABLE public.t_word_inst_rel OWNER TO tl;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: tl
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO tl;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: tl
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO tl;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: tl
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: tl
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
15	NG
16	O
17	P
18	R
19	S
20	T
21	U
22	W
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
18	Ano ang lumilipad?  Mga paruparo ang lumilipad.	何が飛んでいるの。チョウが飛んでいます。	null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
19	Ano ang masarap? Mangga ang masarap.	何がおいしいですか。マンゴーがおいしいです。	null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
20	Ano ang pangalan mo? Tony ang pangalan ko.	あなたの名前は何ですか。トニーが私の名前です。（→私の名前はトニーです。）	null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
21	Ito ba ang sariwa?	これは新鮮ですか。	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
22	Si Heneral Aguinaldo ba ang unang presidente ng Pilipinas?	アギナルド将軍がフィリピンの最初の大統領ですか。	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
23	Sampagita ba ang paborito niyang bulaklak?	サンパギータが彼女のお気に入りの花ですか。 	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
24	Adobo ba ang pinakapopular na ulam?	アドボが一番人気のあるおかずですか。	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
25	Si Quezon ang hindi unang presidente.	ケソンが１代目の大統領ではありません。（しかしケソンは何代目かの大統領である。）	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
26	Hindi si Quezon ang unang presidente.	ケソンが１代目の大統領ではありません。（ケソン以外の誰かが１代目の大統領である。）	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
27	Malinis ang kuwarto ng mga bata.	子供たちの部屋はきれいです。	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
28	Kuwarto ng mga bata ito. 	これは子供たちの部屋です。 	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
29	Masarap ang talbos ng kamote.	サツマイモの新芽はおいしいです。	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
30	Bulaklak ng saging iyon.	あれはバナナの花です。	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
31	Mahigpit ang ate ko.	私の姉は厳しいです。	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
32	Ate ko si Sister Fe.	フェ修道女は私の姉です｡	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
33	Dalaga ang titser ko ng Ingles.	私の英語の先生は独身です。	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
34	Nag-aaral  ako  sa  University  of  the  Philippines.	私はフィリピン大学で勉強しています。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
35	Mahal ang mga isda  sa  Maynila.	マニラでは魚は高いです。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
36	Dumapo ang ibon sa itaas ng puno.	木の上のほうに鳥がとまりました。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
37	Maganda ang dagat sa amin.   	私たちの所では海はきれいです。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
38	Dumating sila dito kahapon.	彼らは昨日ここに到着しました。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]	\N	\N	1
39	Sa mga bata ang mga laruang ito.	これらのおもちゃは子供たちのものです｡	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
40	Kay Lilia ang singsing na ito.	この指輪はリリアのものです。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
41	Ang mga laruang ito ang sa mga bata.	これらのおもちゃが子供たちのものです｡	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
42	Ang singsing na ito ang kay Lilia.	この指輪がリリアのものです。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
43	Kanino ito?	これは誰のものですか｡	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
44	Sa akin iyan.	それは私のものです｡	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
45	Mahal ang aking hikaw.	私のイヤリングは高いです。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
46	Para sa pista ang bandang ito.	この楽隊は祭りのためのものです。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
47	Ang bandang ito ang para sa pista.	この楽隊が祭りのためのものです。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
48	Gamot para sa hika ang mga ito.	これはぜんぞくのための薬です。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
49	Namatay si Rizal para sa bansa natin.	リサールは私たちの国のために死にました。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
50	May pista bukas.	明日祭りがあります。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
51	Mayroong dalawang kalabaw sa ilog.　	川に２頭の水牛がいます。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
52	Walang alitaptap dito.	ここにはホタルがいません。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
53	Maraming magandang isla sa Pilipinas.	フィリピンにはきれいな島がたくさんあります。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
54	Ganito kaputi ang buhangin sa Boracay.	ボラカイの砂はこれくらい白いです。	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
550	Sa Hunyo ang pasukan sa eskwelahan.\n	学校は６月に始まる。\n	\N		\N	vmod	\N	\N	\N	0	1
55	Ganyan ka kasipag.	彼はそれくらい勤勉です。	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
56	Gaano sila kahusay sa sayaw?	彼女たちはどれぐらい踊りが上手ですか。	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
57	Kasingyaman si Don Jose ng asawa mo.	ホセ氏はあなたのだんなさんと同じくらいお金持ちです。	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
58	Magandang umaga, Aling Irma.	おはようございます、イルマおばさん。	挨拶をする		\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
59	Oy Tony, ikaw pala!	トニー、あんたかい。			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
60	Saan ho kayo galing?	どこへ行ってらしたのですか？	挨拶をする		\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
61	Galing ako sa palengke.	市場へ行ってきたんだよ。			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
62	Ikaw, saan ka naman pupunta?	あんたはどこに行くんだい？			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
63	Bihis na bihis ka,ah!	ずいぶんとおめかししてるね。			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
64	May lakad ho ako sa Makati.	マカティに用事があります。			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
65	O sige, mag-ingat ka, ha.	そうかい、気をつけるんだよ。			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
66	O sige ho, ikumusta ninyo ako kay Mang Rudy.	わかりました。ルディーおじさんによろしくお伝えください。			\N	dmod	tl01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
67	Oy Jun, salamat pala sa buko pie.	ジュン、ブコパイありがとう。	感謝する		\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
68	Ang sarap! 	おいしかったわ。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
69	Walang anuman.	どういたしまして。	感謝する		\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
70	Mabuti naman at nagustuhan mo.	気に入ってくれてよかった。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
71	Oo, naubos nga agad, eh.	ええ、すぐに食べてしまったわ。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
72	Kumusta naman ang lakad mo sa Calamba?　　　　　　　　　　　　　　　　	カランバでの用事はどうだったの？			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
73	Mabuti naman.	よかったよ。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
74	Siyanga pala, maraming salamat din sa tulong mo sa paper ko.	ところで、レポートを手伝ってくれてとても助かったよ。	感謝する		\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
75	Bale-wala iyon.	どうってことないわ。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
76	Mas mabuting magpasalamat ka kay Carmen.　　　　　　　　　　　　　　　　	カルメンにも感謝したほうがいいわよ。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
78	Siya ang nag-type ng paper ko!	彼女が僕のレポートを打ってくれたんだった。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
79	Tito, tingnan mo iyon, o!	ティト、あれを見てごらん。	注意をひく		\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
80	Ano po iyon?	あれは何ですか？	注意をひく		\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
81	Ang laking isda!	大きな魚だなあ！			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
82	Ay, hindi iyon isda.	あれは魚じゃないわ。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
83	Dugong iyon!	ジュゴンよ。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
84	Ano po ang dugong?	ジュゴンって何ですか？			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
85	Isang mammal na nakatira sa dagat sa Western Visayas at Palawan.	西ビサヤ諸島やパラワン島の海に住んでいる哺乳類の1種よ。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
86	Parang bakang lumalangoy, ano?	牛が泳いでるみたいだね。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
87	Oo nga.	その通りよ。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
88	Suwerte tayo dahil bihira itong makita.	これはめったに見ることができないから私たちはラッキーなのよ。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
89	Kung gusto mo, tingnan natin ito sa encyclopedia.	もしよかったら、百科事典で見てみましょう。			\N	dmod	tl03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
90	Tao po!	ごめんください。			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
91	Nariyan po ba si Minda?	ミンダさんはいますか？			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
92	Sino po sila?	どちらさまですか？			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
93	Ako po si Rolly, ang kaklase ni Minda. 	ローリーです、ミンダさんの同級生です。 	自己紹介する		\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
94	Kayo ho ba ang ate ni Minda?	ミンダさんのお姉さんでいらっしゃいますか？	自己紹介する		\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
95	Hindi.	いいえ。			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
96	Ako ang nanay niya.	私は母親です。			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
97	Napakabata naman ninyo!	ずいぶんとお若いんですね！			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
98	Parang ate lang kayo ni Minda.	ミンダさんのお姉さんみたいですね。			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
100	Tuloy ka at tatawagin ko si Minda.	中に入って。ミンダを呼んできます。	機能		\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
101	Helo, puwede ho bang makausap si Cherry?	もしもし、チェリーさんと話したいのですが？			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
102	Mike, si Cherry ito!	マイク、チェリーよ。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
103	Cherry, pasensiya ka na at hindi ako nakarating                              sa bertdey party mo kahapon.	チェリー、昨日きみの誕生日パーティーに行けなくてごめん。	あやまる		\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
104	Okey lang iyon.	かまわないわよ。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
105	Kasi nilagnat ako, eh.	熱があったんだ。	あやまる		\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
106	Sayang napakasaya pa naman namin!	残念だったわ。とても楽しかったのよ。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
107	Kumusta ka na ngayon?	今日は気分はどう？			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
108	Medyo magaling na ako, pero inuubo pa rin.	少し良くなったけど、まだ咳をしてるんだ。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
109	Magpagaling ka, ha.	お大事にね。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
110	Salamat.	ありがとう。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
111	Sorry talaga, ha.	本当にごめんね。			\N	dmod	tl05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
112	Greg, eto pala ang tsokolate para sa iyo.	グレッグ、これ、あなたへのチョコレートよ。	何かをあげる		\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
113	Salamat, Yuko.	ありがとう、ユーコ。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
115	Valentine’s day　kasi, eh.	バレンタインデーですもの。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
116	Ano?	え？			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
117	Bakit ikaw ang nagreregalo?	どうして君がプレゼントをくれるの？			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
118	Ganyan sa amin sa Japan, eh.	日本ではそうなのよ。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
119	Naku, hindi ganyan dito sa Pilipinas!	えー、フィリピンでは違うよ。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
120	Mga babae rito ang nireregaluhan.	ここでは女の子がもらうんだよ。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
121	Ganoon ba?	そうなの？			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
122	Nakakahiya!	恥ずかしいことしたわ！			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
123	Inunahan mo naman ako, eh.	君に先にやられた。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
124	May regalo din ako sa iyo.	僕も君にプレゼントがあるんだ。	何かをあげる		\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
125	Eto pala ang rosas.	はい、バラの花だよ。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
126	Sana magustuhan mo.	君が気に入ってくれるといいけど。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[4]	\N	\N	\N
127	Gabi na.	もう夜ね。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
128	Wala pa si Josie.	ジョシーはまだ帰って来ないねえ。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
129	Baka ho natrapik siya.	交通渋滞に巻き込まれたのかもしれません。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
130	Kailangan ko hong umuwi nang maaga ngayon.	今日は早く家に戻らなくちゃいけないんです。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
131	Sandali na lang at darating na siya.	もうちょっと待っていれば、帰ってきますよ。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
132	Maaga pa ho ang trabaho ko bukas.	明日は仕事が早いんです。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
133	Babalik na lang ho uli ako bukas.	明日また伺います。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
134	Bahala ka.	お好きなように。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
135	Aalis na ho ako.	失礼します。	さよならを言う		\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
136	Pakisabi na lang ho ninyo kay Josie na dumating ako.	僕が来たことをジョシーに伝えておいてください。			\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
137	O sige, mag-ingat ka, ha.	では、気をつけてね。 	さよならを言う		\N	dmod	tl07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
138	Magkano ho ang isang kilong mangga?	マンゴは１キロおいくら？	金額についてたずねる		\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
139	Kuwarenta pesos ho ang isang kilo.	１キロは４０ペソです。			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
140	Ang mahal naman!	高いわね！			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
141	Wala ho bang tawad?	おまけしてくれませんか？			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
142	Mura na ho iyan.	すでにお安いですよ。			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
143	Galing pa ho iyan sa Cebu, kaya masarap.	セブ産ですからおいしいですよ。			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
144	Ilan ho ang mayroon sa isang kilo?	１キロでいくつありますか？			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
145	Mga apat ho kung malalaki at lima kung maliliit.	大きければ４個ほど、小さければ５個です。			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
146	Kukunin ko na lang ang kalahating kilo.	半キロもらいます。	金額についてたずねる		\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
147	Piliin ho ninyo ang magaganda.	きれいなのを選んでください。			\N	dmod	tl08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
148	Nakapunta ka na ba sa Davao?	ダバオに行ったことがある？	経験についてたずねる		\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
149	Oo, noong isang taon.	ええ、去年。			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
150	Nakaakyat nga ako sa Mt. Apo, eh.	アポ山に登ったわ。			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
151	Nakaakyat ka ba hanggang sa tuktok?	頂上まで登れたの？			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
152	Hindi, dahil sumakit ang paa ko, eh.	いいえ。足が痛かったんですもの。			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
153	Nakarating ka ba sa Samal Island?	サマール島まで行けた？	経験についてたずねる		\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
154	Hindi rin.	いいえ。			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
155	Ano lang ang ginawa mo sa Davao?	ダバオで何したの？			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
156	Nakatikim naman ako ng durian at marang.	ドリアンとマランを味見したわ。			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
157	Iyon lang?	それだけ？			\N	dmod	tl09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
158	Ano ang balak mo sa summer vacation?	夏休みは何を計画しているの？	予定を述べる		\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
159	Balak kong pumunta sa Baguio.	バギオに行くつもりなんだ。	予定を述べる		\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
160	Masyadong mainit dito, eh.	ここは暑すぎるよ。			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
161	May tutuluyan ka ba sa Baguio?	バギオで泊まるところはあるの？			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
162	Mayroon, doon sa bahay ng kaklase ko noong haiskul.	あるよ、高校時代の同級生の家がね。			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
163	Ano naman ang gagawin mo sa Baguio?	バギオでは何をするの？			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
164	Gusto ko lang magpalamig.	涼みたいだけだ。			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
165	Matagal na rin akong hindi nakapunta doon.	長いことあそこには行っていないからな。			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
166	Iba na ang Baguio ngayon.	今のバギオは変わったわよ。			\N	dmod	tl10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
167	Nasaan ho tayo ngayon?	今どこですか？			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
168	Nasa Bontoc na ho tayo.	ボントックにいます。			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
169	Gaano kalayo pa ho ba ang Sagada mula rito?	ここからサガダまではどのくらい遠いですか？	情報を求める（程度）		\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
170	Mga dalawang oras pa ho.	およそ２時間です。			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
171	Ang Kalinga ho?	カリンガは？			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
172	Mas malayo pa ho iyon kaysa sa Sagada.	サガダよりもっと遠いです。			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
173	Ganito pala magbiyahe dito sa Mountain Province.	山岳州ではこんなふうに旅するのね。			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
174	Nakakapagod!	とても疲れるわ！			\N	dmod	tl11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
175	Hi Carol, kumusta ang bakasyon mo?	やあキャロル、休みはどうだった？			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
176	Masaya siyempre.	もちろん楽しかったわ。			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
177	Teka, anong oras na ngayon?	ちょっと、今何時？	時間についてたずねる		\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
178	Alas nuwebe kinse.	９時１５分だよ。	時間についてたずねる		\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
179	Bakit, may klase ka ba?	どうして、授業があるの？			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
180	Oo, may klase akong histori nang alas diyes.	ええ、歴史の授業が１０時にあるの。			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
181	May klase rin ako kaninang alas siyete, pero P.E. lang.	僕はさっき７時に授業があったけど、体育だった。			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
182	Ano ang iskedyul mo ngayong semester?	今学期のスケジュールはどうなってるの？			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
183	Pag Lunes at Huwebes, Pilipino at Math, mula alas otso y medya ng umaga hanggang ala una ng hapon.	月曜日と木曜日はフィリピノ語と数学で、午前８時半から午後１時まで。			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
184	Pareho pala tayo!	僕たち同じだね。			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
185	O magkita tayo sa laybrari mamayang alas tres!	図書館で３時に会おうよ。			\N	dmod	tl12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
186	Mayroon ka bang kapatid, Margie?	マージ、きょうだいがいるかい？			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
187	Mayroon akong isang kapatid na lalaki.	男のきょうだいが１人いるわ。			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
188	Naku, dalawa lang kayo?	え、君たち２人だけ？			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
190	Bakit, ilan kayo?	あなたたち何人？	情報を求める（数字）		\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
191	Sampu kami.	僕たち１０人。			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
192	Ano, sampu?	何ですって、１０人？			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
193	Ilan ang lalaki at ilan ang babae?	男は何人で女は何人？			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
194	Anim ang lalaki at apat ang babae.	男は６人で女は４人。			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
195	Siyanga pala, Margie, ilang taon ka na?	ところでマージ、君何歳？	情報を求める（数字）		\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
196	Sikreto iyan.	それは秘密。			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
197	Paano ho magluto ng sinigang na baboy?	豚肉のシニガンスープはどうやって料理するのですか？	手段についてたずねる		\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
198	Medyo mahirap.	ちょっと難しいわよ。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
199	Pakuluan mo muna ang karneng baboy hanggang sa lumambot.	まず豚肉をやわらかくなるまで煮て。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
200	Lagyan mo rin ng asin.	塩も入れて。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
201	Mga ilang oras ho iyan?	それは何時間ぐらいですか？			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
202	Mga isa at kalahating oras.	およそ１時間半です。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
203	Tapos ilagay mo ang mga gulay na nahiwa na.	それから切った野菜を入れて。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
204	Ano ho ang uunahin ko?	何を先にしましょうか？			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
205	Unahin mo ang labanos, dahil matagal itong maluto.	大根を先にしなさい。これは煮えるのに時間がかかるから。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
206	Isabay mo na rin ang dinurog na sampalok.	潰したサンパロックをも同時に入れなさい。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
207	Tapos ho?	それから？			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
208	Ihuli mo ang kangkong.	空芯菜を最後にしなさい。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
209	Timplahan mo ng patis kung matabang pa.	味が薄かったら、パティスで味を調えなさい。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
210	Madali lang pala!	簡単なんですね。			\N	dmod	tl14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
211	Taga-saan ka?	あなたどこ出身？			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
212	Taga-Maynila ako.	マニラ出身だよ。			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
213	Ikaw?	君は？			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
214	Taga-Zamboanga ako.	サンボアンガ出身よ。			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
215	Marunong ka bang mag-Chabacano?	チャバカノ語ができるの？	015		\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
216	Siyempre.	もちろん。			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
217	Magaling din akong mag-Cebuano.	セブアノ語も上手よ。			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
218	Talaga?	本当？			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
219	Ilang wika ang alam mo?	君、いくつの言葉を知っているの？			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
220	Apat, bukod sa Tagalog at Ingles.	タガログと英語のほかに４つよ。	機能		\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
221	Ikaw, Tagalog lang ba ang alam mo?	あなたは、知ってるのはタガログだけ？			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
222	Hindi.	いいや。			\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
223	Mahusay akong mag-Amoy dahil taga-China ang lolo ko.	祖父が中国出身だから僕は福建語が上手だよ。	能力についてたずねる		\N	dmod	tl15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
224	Nasaan si Nony?	ノニーはどこにいるんだい？	場所についてたずねる		\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
225	Ewan ko.	知りませんよ。			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
226	Naroon yata siya sa bahay nina Fe.	たぶんフェの家にいますよ。			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
227	Bakit siya naroon?	どうしてあそこにいるんだい？			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
228	Magnobyo na ba sila?	彼らは恋人同士かい？			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
229	Ano pa!	他になんだって言うの？			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
230	Teka, may tao yata sa labas.	ちょっと外に人がいるみたいだ。			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
231	Ah, baka iyong naniningil ng kuryente.	電気の料金を集める人でしょ？			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
232	Nasaan ang pitaka ko?	私の財布どこかしら？			\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
233	Nasa ibabaw ng tokador.	化粧台の上だよ。	場所についてたずねる		\N	dmod	tl16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
234	Narito na pala si Ate!	姉さんここにいたんだね。			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
235	Ang dami ng pasalubong!	お土産がたくさん！			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
236	Hindi para sa iyo itong kahon, ha?	このダンボール箱はあんたへのものじゃないわよ。			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
237	Para kanino iyan?	それは誰へのもの？	特徴についてたずねる		\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
238	Para kina Tatay at Nanay ito.	これは父さんと母さんへのものよ。			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
239	Kanino naman ang bagong maletang ito?	この新しいスーツケースは誰の？	特徴についてたずねる		\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
240	Sa akin iyan.	それは私のものよ。			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
241	Aling pasalubong ang para sa akin?	どのお土産が僕へのもの？			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
242	Ay, sorry, nakalimutan ko.	あらごめん、忘れたわ。			\N	dmod	tl17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
243	Nagpagupit ka pala!	髪の毛切ったんだね。			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
244	Oo.	ええ。			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
245	Nagsawa na ako sa mahabang buhok.	長い髪には飽きてしまったわ。			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
246	Sa palagay ko, mas bagay sa iyo ang mahabang buhok.	君には長い髪の方が似合うと思うよ。	意見を述べる		\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
247	Ganoon ba?	そうなの？			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
248	Akala ko, mukhang bumata ako sa maikling buhok.	短い髪だと若く見えると思ったんだけど。	意見を述べる		\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
249	Mukhang elegante ka sa mahabang buhok, kasi mataba ang mukha mo.	長い髪だとエレガントに見えるよ、君の顔はふっくらしてるからね。			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
250	Mahirap mag-ayos ng mahabang buhok.	長い髪の毛は手入れが面倒なの。			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
251	Para sa akin, puwede na ito.	私にはこれでいいわ。			\N	dmod	tl18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
252	Romy, kumain ka ng pinakbet.	ロミー、ピナクベットを食べて。			\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
253	May kasama ba itong ampalaya?	これには苦瓜も入っているの？			\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
254	Siyempre.	もちろん。			\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
255	Bakit, ayaw mo ba ng ampalaya?	どうして、苦瓜嫌いなの？			\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
256	Ayaw na ayaw ko ng ampalaya dahil masyadong mapait.	苦瓜は苦すぎるから大嫌いだ。	好きなものについて述べる		\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
257	Pero gusto ko ng kalabasa at talong.	でもカボチャとナスは好きだ。	好きなものについて述べる		\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
258	Ihiwalay mo na lang ang ampalaya.	苦瓜だけを別にして。			\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
259	Paborito kong gulay iyan, eh.	それは私のお気に入りの野菜よ。			\N	dmod	tl19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
260	Nanonood ka ba ng telenobela?	テレビドラマを見る？			\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
261	Hindi ako mahilig diyan.	好きじゃないわ。	好きな行動について述べる		\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
262	Mas gusto kong manood ng sine.	映画を見るほうがずっと好きよ。			\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
263	O sige, kung libre ka mamaya, manood tayo ng sine.	わかった、あとで時間があれば映画を見よう。			\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
264	Mahilig akong manood ng sine, pero ayaw kong manood ngayon.	映画を見るのが好きだわ、でも今日は見たくないわ。	好きな行動について述べる		\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
265	Ikaw, ano ang hilig mo?	あなたは何が好きなの？			\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
266	Gusto ko lang matulog.	僕は寝ることだけ。			\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
267	Kaya ka pala mataba!	だから太っているのね。			\N	dmod	tl20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
268	Madali bang magtanim ng kamoteng-kahoy?	カッサバは植えるのは簡単？	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
269	Oo, madali lang.	ええ、やさしいわよ。	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
270	Ano ang una kong gagawin?	最初に何をするの？	順序について述べる		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
271	Eto ang puno ng kamoteng-kahoy.	これがカッサバの幹よ。	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
272	Putulin mo ang dulo nitong puno.	この幹の端を切って。	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
273	Ganito?	こんな風に？	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
274	Gawin mong matulis ang bahaging pinutol mo.	切り口を鋭角にして。	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
275	Tapos?	それから？	順序について述べる		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
276	Tanggalin mo ang lahat ng dahon at itanim mo na sa lupa.	葉っぱを全部とって土に埋めて。	機能		\N	dmod	tl21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
277	Aba, si Francis iyon! Francis!	あらー、フランシスだわ！フランシス！	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
278	Lorna, kumusta ka?	ロルナ、元気かい？	状況についてたずねる		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
279	Matagal na tayong hindi nagkita, ah!	長いこと会わなかったな。	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
280	Bakit ka narito sa kasal ng pinsan ko?	わたしのいとこの結婚式になぜあなたがいるの？	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
281	Inimbita ako ng pinsan mo.	君のいとこに招待されたんだ。	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
282	Isa pa, alam kong darating ka.	それに加えて君が来るのがわかっていたから。	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
283	Huwag mo nga akong bolahin.	私にお世辞を言わないで。	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
284	Talaga, nami-miss na kita.	本当だよ。君がいなくて寂しかった。	機能		\N	dmod	tl22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
285	May bagyo yata. 	台風みたいだな。	機能		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
287	Siguradong babaha na naman sa labas.	外はまた洪水になるわ。	機能		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
288	Oo nga. Pag may baha, huwag tayong lumabas. 	そうだね。洪水のときは外に出るのはやめよう。	ある条件での行動を言う		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
289	Oo, delikado, kasi baka tayo mahulog sa manhole.	そうね、危険だわ。わたしたちマンホールに落ちるかもしれないから。	機能		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
290	Marumi rin ang tubig kaya baka tayo magkasakit. 	水も汚いので病気になるかもしれない。	機能		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
291	Sana umaraw naman bukas.	明日晴れるといいのに。	機能		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
292	Sana nga. Kung aaraw bukas, puwede tayong dumalaw sa lola.	だといいね。明日晴れたら、おばあちゃんを訪ねることができる。	ある条件での行動を言う		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
293	Napakalaki pala ng putok ng Pinatubo!	ピナツボの噴火はとても大きかったわね。	機能		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
294	Oo. Ito ang pinakamalaking putok ng bulkan noong twentieth century.	うん。20世紀で最も大きな噴火だったんだよ。	比べる		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
295	Maraming nawalan ng bahay at lupa.	多くの人が家と土地を失ったんだ。	機能		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
296	Mas malaki ba ito kaysa sa putok ng Mayon Volcano noon?	これは以前のマヨン火山の噴火よりも大きいの？	比べる		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
297	Siyempre.  Umabot sa Maynila ang abo.	もちろん。灰はマニラまで到達したんだ。	機能		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
298	Nakakatakot pala sa Pilipinas!	フィリピンは怖いわね。	機能		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
299	Mas nakakatakot sa Hapon kaysa sa Pilipinas dahil maraming lindol.	日本のほうがフィリピンよりもずっと怖いよ、たくさん地震があるからね。	機能		\N	dmod	tl24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
300	Kukuha ako ng Filipino ngayong semester.	今学期はフィリピノ語をとるわ。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
301	Mas mabuting kunin mo ang klase ni Mister Santos.	サントス先生の授業をとったほうがいいよ。	25		\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
302	Bakit? Napili ko na ang klase ni Miss Ramos.	どうして？ラモス先生の授業を選択しちゃったわ。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
303	Naku, huwag, dahil terror siya.	わぁ、やめとけよ。彼女は恐ろしいよ。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
304	Halos walang pumapasa sa klase niya taun-taon.	毎年彼女の授業で合格点をもらう人はほとんどいないよ。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
305	Akala ko, mabait siya.	彼女は親切な人だと思ったのに。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
306	Hindi. At marami ring assignments sa klase niya.	いいや。彼女のクラスでは宿題もたくさんあるよ。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
307	Mabuti na lang at nakita kita. Salamat.	あなたに会えて良かったわ。ありがとう。			\N	dmod	tl25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
308	Wala ka yata kahapon sa klase.	昨日は授業にいなかったみたいね。			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
309	Kasi nasira ho ang tiyan ko.	お腹を壊したんです。			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
310	Bakit, ano ang kinain mo?	どうして、何を食べたの？			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
311	Kumain ho ako ng isda at tahong.	魚とムール貝を食べました。			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
312	Siguradong nasira ang tiyan mo dahil sa tahong.	ムール貝が原因でお腹を壊したに違いないわね。	26		\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
313	Kumusta ang pakiramdam mo ngayon?	今日は気分はどう？			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
314	Mabuti-buti na ho, salamat.	かなり良いです。ありがとうございます。			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
315	Sa susunod, mag-iingat ka sa pagkain.	次からは食べ物に気をつけなさい。			\N	dmod	tl26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
316	May sasabihin sana ako sa iyo.	君に話したいことがあるんだけど。	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
317	Ano iyon?	何なの？	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
318	Kinapos ako ngayong linggong ito, kaya puwede bang mangutang sa iyo?	今週お金が足りないので君から借りられる？	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
319	Magkano ang kailangan mo?	いくら必要なの？	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
320	Mga tatlong daang piso lang sana.	およそ300ペソほど。	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
321	O sige, pero puwede bang ibalik mo ito sa katapusan ng buwan?	分かったわ。でも今月末に返してもらえる？	依頼する		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
322	Magbabayad ako ng upa sa boarding house ko, eh.	下宿先に家賃を払います。	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
323	Walang problema.	問題ないよ。	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
324	Siguro mababayaran na kita sa isang linggo.	たぶん来週払えるよ。	機能		\N	dmod	tl27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
325	Ate, bakit wala ka pang boyfriend? 	姉さん、どうしてまだボーイフレンドがいないの？			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
326	Malapit ka nang mag-treynta, ah.	もうすぐ30だよね。			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
327	Hindi ko pa nakikilala ang type kong lalaki.	理想のタイプの男性にまだ知り合ってないだけだよ。			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
328	Ano ang type mo?	理想のタイプってどんなの？			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
329	Katulad ni Richard Gomez, iyong guwapo, matangkad at mukhang mabait.	リチャード・ゴメスみたいな、ハンサムで背が高くて、人が良さそうな人。	28		\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
330	Masyadong mataas ang pangarap mo.	姉さんの望みは高すぎるよ。			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
331	Baka tumanda kang dalaga tulad nina Tita Maria at Tita Rosa.	マリアおばさんや、ロサおばさんみたいに独身のまま年をとっちゃうかもよ。			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
332	Ay, ayaw ko!	あら、やだわ。			\N	dmod	tl28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
333	Mamasyal muna tayo rito sa Chinatown bago tayo kumain.	食べる前にチャイナタウンを散策しましょう。			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
334	O sige. Lalakad ba tayo?	いいよ。僕たち歩くの？			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
335	Puwede tayong lumakad o sumakay.	歩いてもいいし、乗ってもいいわ。			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
336	Kung sasakay tayo, sa kalesa o sa traysikel?	乗るとしたら、馬車、それともトライシクル？			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
337	Mahal ang kalesa pero matatanaw natin ang tanawin.	馬車は高いけれど景色がよく見えるわ。			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
338	Mas mabilis at mas mura kung sasakay tayo ng traysikel.	トライシクルに乗ったほうが方が早いし、安いよ。			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
339	Baka hindi tayo mag-enjoy kung sa traysikel.	トライシクルだと楽しめないかも。			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
340	At masikip nga pala ang traysikel.	トライシクルは狭いしね。			\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
341	Sige, magkalesa na lang tayo.	じゃあ、馬車で行きましょう。	29		\N	dmod	tl29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
342	Magandang hapon po.	こんにちは。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
343	O Rene, napasyal ka.	おお、レネ、よく来たね。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
344	Wala pa rito si Luz.	ルースはまだ帰ってきてないのよ。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
345	Okey lang ho.	かまいません。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
346	Kayo ho naman ang sadya ko.	おばさんに会いに来たんです。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
347	Ano iyon?	何の用事？			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
348	Maaari ho bang imbitahin si Luz?	ルースを招待してもいいですか？	30		\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
349	Gusto ko ho sana siyang maging partner ko.	彼女に僕のパートナーになってもらいたいんです。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
350	Partner sa anong okasyon?	何のパートナー？			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
351	Sa high school homecoming ball ho namin sa isang buwan.	来月高校で行われる、卒業生たちのためのダンスパーティーです。			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
352	Aba, oo, iyon lang pala!	あら、いいわよ。それだけ？			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
353	Salamat ho, pero puwede rin ho bang mahiram ang amerikana ni Mang Celso?	ありがとうございます。セルソおじさんのスーツを借りてもよろしいですか？			\N	dmod	tl30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
354	Paano kang nag-apply para sa pasaporte mo?	どうやってパスポートを申請したの？			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
355	Kailangan ko bang mag-apply nang personal?	自分で申請する必要があるの？	31		\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
356	Oo, para mas mabilis.	その方が早いよ。			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
357	Ano pa ang dapat kong gawin?	何をすればいいの？			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
358	Dapat kang magdala ng birth certificate mo at walong retrato sa DFA.	出生届と写真8枚を外務省にもっていく必要がある。	31		\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
359	Ano pa?	他には？			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
360	Siyempre, kailangan mong mag-fill-up ng application form.	もちろん、申請書に記入する必要がある。			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
361	Gaano katagal ko makukuha ang pasaporte ko?	パスポートをもらえるまでどの位かかる？			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
362	Mga dalawang linggo lang.	2週間くらいだよ。			\N	dmod	tl31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
363	Bawal manigarilyo rito, hindi mo ba alam?	ここは禁煙よ、知らないの？	32		\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
364	Ha?  Bawal rin ba rito?	え？ここでも禁じられているの？			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
365	Akala ko, sa Singapore lang.	シンガポールだけだと思ってた。			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
366	Oo, talagang bawal sa public area.	ええ、公共の場所では本当に禁じられているの。			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
367	Mahigpit na rin dito.	ここも厳しいのよ。			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
368	Naku, mahihirapan ako.	わぁ、僕は苦労するなぁ。			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
369	Oo, kaya dapat ka nang tumigil sa paninigarilyo.	そうよ、だからあなたタバコを吸うのをやめるべきだわ。			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
370	Sige na nga. Susubukan ko.	わかったよ。やってみる。			\N	dmod	tl32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
371	Mamang drayber, sa U.P. ho.	運転手さん、フィリピン大学へ。			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
372	Saan ho tayo dadaan?	どこを通りましょうか？			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
373	Iwasan ho natin ang EDSA.	エドサ大通りは避けましょう。	33		\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
374	Masyadong matrapik ho roon.	あそこは交通渋滞がひどすぎます。			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
375	Kakanan na ho ako roon sa kanto, ha?	角で右に曲がりましょうか？ 			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
376	Oho.	はい。			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
377	Kumanan kayo riyan.	そこで右に曲がってください。	33		\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
378	Sa susunod na kanto ho, kumaliwa kayo at diretso lang.	3番目の角で左に曲がってください。そして真っ直ぐ行ってください。			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
379	Saan ho ba kayo sa U.P.?	フィリピン大学のどこですか？			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
381	Pumara na lang kayo sa harap ng bilding.	建物の前に止めてください。			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
382	Ryan, pupunta tayo sa libing ng lolo mo ngayon. 	ライアン、今日はおじいさんのお葬式に行きますよ。	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
383	Sa sementeryo po ba? 	墓地に行くの？	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
384	Sa simbahan muna.	まず教会ですよ。	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
385	Huwag kang mag-ingay habang may misa. 	ミサの間はうるさくしないでね。	非行為を依頼する 		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
386	Puwede po ba akong maglaro pagkatapos ng misa? 	ミサの後は遊んでもいい？ 	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
387	Hindi puwede at huwag ka ring lumayo sa akin.	だめよ、それに私から離れないで。	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
388	Pagkatapos ng misa, didiretso po ba tayo sa sementeryo? 	ミサの後は墓地に真っ直ぐ行くの？	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
389	Oo, at huwag kang masyadong matanong.	あんまり質問しないで。	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
390	Tayo na. 	さあ、行きましょう。	機能		\N	dmod	tl34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
391	Hiro, mabuti at nakarating ka sa amin. 	ヒロ、よく我が家に来てくださいましたね。 	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
392	Maligayang Pasko ho, Mrs. Rosales. 	クリスマスおめでとうございます、ロサレス夫人。	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
393	Pasok ka. 	中に入って。	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
394	Hindi mo kailangang hubarin ang sapatos mo. 	靴を脱ぐ必要はありませんよ。	義務を確認する／否定する 		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
395	Pagpasensiyahan po ninyo itong regalo ko. 	こんなプレゼントで申し訳ありません。	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
396	Naku, nag-abala ka pa. 	まあ気をつかって。 	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
397	Hindi ka na dapat nagdala ng regalo. 	プレゼントなんて必要なかったのに。 	義務を確認する／否定する 		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
398	Galing ho sa Kyoto ito, ipinadala na nanay ko. 	これは京都のもので、母が送ってきました。	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
399	Ang ganda! 	まあきれい！	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
400	Maraming salamat. 	どうもありがとう。	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
401	Pakisabi na ring salamat sa nanay mo. 	お母さんにありがとうって伝えてください。	機能		\N	dmod	tl35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
402	Balita ko, piyesta raw sa bayan ninyo sa Linggo. 	日曜日、あなた方の町ではお祭りがあるそうね。 	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
403	Oo, pumasyal ka sa bahay namin.	はい、僕の家に遊びに来て下さい。	招待する		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
404	Isama mo rin ang ate mo kung libre siya.	時間があったらきみのお姉さんも連れて。	機能 		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
405	Sige, tatanungin ko siya.	わかったわ。彼女に聞いてみるわ。 	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
406	Ano ang handa ninyo?	何のごちそうを用意するの？	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
407	Maraming seafood at may lechon din.	シーフードがたくさんあるし、子豚の丸焼きもあるよ。	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
408	Ano pala ang paboritong pagkain ng ate mo?	きみの姉さんの好きな食べ物はなんだい？	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
409	Mahilig siya sa halaya.	彼女はハラヤが好きよ。	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
410	Ganoon ba?	そうなの？	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
411	Sige, ipapagawa ko iyan sa nanay ko. 	母さんにそれを作ってもらうことにする。 	機能		\N	dmod	tl36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
412	Rolly, mukhang may problema ka, ah. 	ロリー、何か問題があるみたいだね。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
413	Mayroon nga ho.	あるんです。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
414	Tungkol ho sa isang babae. 	一人の女性についてです。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
415	Bakit, ano ang nangyayari sa iyo? 	一体どうしたっていうんだい？	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
416	May nagustuhan ho akong isang Haponesa, pero may boyfriend na siya.	僕、日本の女の人を好きになっちゃったんです。でも彼女にはボーイフレンドがいるんです。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
417	Mahirap na problema iyan. 	 それはずいぶんと難しい問題だね。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
418	Ano ho ang mabuti kong gawin?	僕は何をしたらいいのかなぁ。 	助言する 		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
419	Mamili ka sa mga ito. 	この中から選びなさい。 	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
420	Una, matulog ka muna.	１番目は、まず寝なさい。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
421	Pangalawa, mag-isip ka nang mabuti.	２番目は、良く考えなさい。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
422	Pangatlo, kalimutan mo siya.	３番目は、彼女を忘れなさい。	機能		\N	dmod	tl37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	\N
423	May mga ready-made na barong Tagalog ba kayo?	既製のバロンタガログがありますか？ 	機能		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
424	Wala ho ngayon. 	今日はございません。 	機能		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
425	Gusto ko hong magpatahi ng barong Tagalog na jusi.	 バナナ繊維の布地でバロンタガログを作ってもらいたいのです。	要求する		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
426	Para ho ba sa inyo?	お客さま用のですか？ 	機能		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
427	Para ho sa asawa ko.	夫用のです。 	機能 		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
428	Gusto ko ho ng hindi masyadong malaki ang burda. 	その刺繍はあまり大きくないのが好きです。	機能 		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
429	Pahingi ho ng size ng asawa ninyo.	 ご主人様のサイズを教えてください。	機能 		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
430	Habaan ninyo ang manggas, kasi mahaba ang braso niya. 	夫の腕は長いので袖を長くしてください。 	機能 		\N	dmod	tl38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
431	Pupunta kami sa San Pablo sa Mahal na Araw. 	聖週間に私たちはサンパブロに行きます。 	機能		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
432	Gusto mo bang sumama sa amin? 	一緒に来たいですか？ 	機能		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
433	Kung hindi abala sa inyo, gusto kong sumama. 	あなた方に迷惑でないなら、一緒に行きたいです。 	希望を述べる		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
434	Maganda raw ang prusisyon. 	パレードはきれいだそうです。	機能		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
435	Malaki rin daw ang mga santo sa karosa. 	山車の聖像も大きいそうです。	機能		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
436	Gusto kong sumali sa prusisyon. 	僕はパレードに参加したい。	希望を述べる		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
437	Puwede. 	できるわよ。	機能 		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
438	Kung gusto mo, puwede ka ring humila ng karosa.  	もし望むなら、山車を引くこともできます。	希望を述べる		\N	dmod	tl39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
439	Siyanga pala, dumating mula sa Iloilo ang kababata ko. 	ところで、幼友達がイロイロからやってきたわ。	紹介		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
440	Maganda ba siya? 	彼女美人？	紹介		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
441	Oo, naging reyna siya sa piyesta noon. 	ええ、以前お祭りのとき女王になったわ。	紹介		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
443	Dalaga pa ba siya?  	彼女まだ独身？	紹介		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
444	Oo.	ええ 	機能 		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
445	Ipakilala mo naman ako sa kanya.	僕を彼女に紹介して。 	紹介する 		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
446	Aba, eto na pala siya!	あら、もう彼女がきたわ！ 	機能		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
447	Tina, ito si Joey, ang kaopisina ko.	メリー、こちらがジョーイ、会社の同僚です。	紹介する 		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
448	Joey, siya si Tina, ang kababata ko. 	ジョーイ、彼女がティナ、幼友達です。	機能		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
449	Hi Tina, kumusta ka? 	やあティナ、はじめまして。	紹介する		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
450	magasinsin	雑誌を見る	\N		\N	vmod	\N	\N	\N	0	1
451	Pupunta ako sa Pilipinas sa Abril.\n	私は4月にフィリピンに行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
452	Mainit sa Hapon sa Agosto.\n	日本は8月は暑い。\n	\N		\N	vmod	\N	\N	\N	0	1
453	Hindi maaaring mag-ingay sa aklatan.\n	図書館ではうるさくしてはいけません。\n	\N		\N	vmod	\N	\N	\N	0	1
454	Bawal uminom ng alak ang mga bata.\n	子供はお酒を飲んではいけません。\n	\N		\N	vmod	\N	\N	\N	0	1
455	Kumain ng almusal si Pedro bago pumasok sa trabaho.\n	ペドロは仕事に行く前に朝食を食べた。\n	\N		\N	vmod	\N	\N	\N	0	1
456	Mahal ang mga apartment sa Makati.\n	マカティでは、アパートは高い。\n	\N		\N	vmod	\N	\N	\N	0	1
457			\N		\N	vmod	\N	\N	\N	0	1
458	Linisin mo ang kalan mamaya.\n	ストーブを後で掃除して。\n	\N		\N	vmod	\N	\N	\N	0	1
459	Wala siyang asawa.\n	彼は奥さんがいない。\n	\N		\N	vmod	\N	\N	\N	0	1
460	Ipapakilala ko sa iyo ang aking asawa.\n	私の妻を紹介します。\n	\N		\N	vmod	\N	\N	\N	0	1
461	Nilalagyan ko ng asukal ang kape ko.\n	私はコーヒーに砂糖を入れる。\n	\N		\N	vmod	\N	\N	\N	0	1
462			\N		\N	vmod	\N	\N	\N	0	1
463	Kulay asul ang Manila Bay dati.\n	以前マニラ湾は青かった。\n	\N		\N	vmod	\N	\N	\N	0	1
464	Gusto ko ng maanghang na sawsawan para sa isda.\n	私は、魚には辛いつけだれが好きです。\n	\N		\N	vmod	\N	\N	\N	0	1
465	Iabot mo nga ang asin.	塩を取って。	\N		\N	vmod	\N	\N	\N	0	1
466	Isampay mo sa labas ang mga damit kung maaraw bukas.\n	明日もし晴れたら、外に服を干してね。\n	\N		\N	vmod	\N	\N	\N	0	1
467	Maraming mag-asawa ang nakatira sa bayan namin.\n	私たちの町にはたくさんの夫婦が住んでいる。\n	\N		\N	vmod	\N	\N	\N	0	1
468	Pagbutihin mo ang iyong pag-aaral.\n	勉強を頑張りなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
469	Malaki ang bag na ginagamit ni Nene sa eskuwelahan.\n	ネネが学校で使っているバックは大きい。\n	\N		\N	vmod	\N	\N	\N	0	1
470	Nasa ibaba ang pustiso ni Nanay.\n	お母さんの入れ歯は下にある。\n	\N		\N	vmod	\N	\N	\N	0	1
471	Nakalimutan ko ang bagahe ko sa loob ng tren.\n	荷物を電車の中に忘れてしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
472	Ano ang plano mo sa bakasyon sa tag-init?\n	夏休みの予定は？\n	\N		\N	vmod	\N	\N	\N	0	1
473	Nagtatrabaho sa bangko ang nanay ni Tony.\n	トニーの母親は銀行で働いている。\n	\N		\N	vmod	\N	\N	\N	0	1
474	Marumi ang banyo sa dormitoryo.\n	寮の風呂場は汚い。\n	\N		\N	vmod	\N	\N	\N	0	1
475	Nabasag ang baso sa kusina.\n	台所でコップが割れてしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
476	May hawak na manika ang batang babae.\n	女の子は人形を持っている。\n	\N		\N	vmod	\N	\N	\N	0	1
477	Naglalaro ang mga batang lalaki sa kalye.\n	男の子たちが道で遊んでいる。\n	\N		\N	vmod	\N	\N	\N	0	1
478	Hindi ako naglalagay ng bater sa tinapay.\n	私はパンにバターをつけない。\n	\N		\N	vmod	\N	\N	\N	0	1
479	Berde ang mga dahon sa tag-init.\n	夏には、葉っぱが緑色だ。\n	\N		\N	vmod	\N	\N	\N	0	1
480	Nakadungaw sa bintana ang mga dalaga.\n	女の人たちが、窓から覗いている。\n	\N		\N	vmod	\N	\N	\N	0	1
481	Makinis ang binti ni Ruffa.\n	ルファの脚はつるつるです。\n	\N		\N	vmod	\N	\N	\N	0	1
482	Palaging bisi sa trabaho ang tatay ni Richard.\n	リチャードのお父さんは、いつも仕事で忙しい。\n	\N		\N	vmod	\N	\N	\N	0	1
483	Malalaki ang mga bisig ng panday.\n	鍛冶屋の腕は太い。\n	\N		\N	vmod	\N	\N	\N	0	1
484	Nawala ang bisikleta sa Luneta.\n	ルネタ公園で自転車がなくなった。\n	\N		\N	vmod	\N	\N	\N	0	1
485	Wala akong pasok sa Biyernes.\n	私は金曜日に授業がありません。\n	\N		\N	vmod	\N	\N	\N	0	1
486	Ilang bolpen ang kailangan mo sa opisina?\n	事務所でボールペンがいくつ必要ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
487	Maalikabok ang bookshelf sa bahay.\n	家の本棚は埃っぽい。\n	\N		\N	vmod	\N	\N	\N	0	1
488	Malaki ang boses ng pulis-trapiko.\n	交通警察官の声は大きい。	\N		\N	vmod	\N	\N	\N	0	1
489	Huwag mong buksan ang bintana sa kuwarto.\n	部屋の窓を開けないで。\n	\N		\N	vmod	\N	\N	\N	0	1
490	Nabutas ang bulsa ko dahil sa mga barya.\n	小銭のせいで、ポケットに穴が開いてしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
491	Pagdating sa Quiapo, bumaba ka sa may simbahan.\n	キアポに着いたら、教会のところで降りてね。\n	\N		\N	vmod	\N	\N	\N	0	1
492	Bumibili ako ng isda sa palengke araw-araw.\n	私は毎日市場で魚を買う。\n	\N		\N	vmod	\N	\N	\N	0	1
493	Isara mo ang bunganga mo at baka pasukan ng langaw.\n	ハエが入るから、口を閉じて。\n	\N		\N	vmod	\N	\N	\N	0	1
494	Binura ko ang mga nakasulat sa pisara.\n	私は黒板に書いてあったものを消してしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
495	Magbubus ako papuntang Baguio mamayang gabi.\n	私は今晩バスでバギオに行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
496	Nasa kanto ang buson.\n	ポストは角にあります。\n	\N		\N	vmod	\N	\N	\N	0	1
497	Mahal ang renta ng bahay dito buwan-buwan.\n	ここでは、毎月の家の賃貸料が高い。	\N		\N	vmod	\N	\N	\N	0	1
498	Marunong ka bang gumamit ng chopsticks?\n	箸を使うのは上手ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
499	Madalas pumunta sa coffee shop ang mga estudyante.\n	学生たちは、よく喫茶店に行く。	\N		\N	vmod	\N	\N	\N	0	1
500	May bayad ang paggamit ng CR sa Glorietta.\n	グロリエッタのトイレの利用は有料です。\n	\N		\N	vmod	\N	\N	\N	0	1
501	Maanghang ang curry sa Chap-chap.\n	「チャプチャプ（お店の名前）」のカレーは辛い。\n	\N		\N	vmod	\N	\N	\N	0	1
502	Masisikip ang mga daan sa loob ng UP.\n	UP内の道は狭い。\n	\N		\N	vmod	\N	\N	\N	0	1
503	Ibaba mo nang dahan-dahan ang baril mo.\n	銃をゆっくり降ろしなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
504	Gusto ko ng bagong damit sa Pasko.\n	クリスマスに、新しい服が欲しい。\n	\N		\N	vmod	\N	\N	\N	0	1
505	Malamig ang simoy ng hangin sa dapithapon.\n	夕方のそよ風は冷たい。\n	\N		\N	vmod	\N	\N	\N	0	1
506	Maraming dayuhan ang paroroon.\n	たくさんの外国人がそこに行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
507	Maraming mga dayuhang-mag-aaral sa Tokyo University.\n	東京大学には留学生がたくさんいる。\n	\N		\N	vmod	\N	\N	\N	0	1
508	Malaki ang bagong department istor sa Baguio.\n	バギオの新しいデパートは大きい。\n	\N		\N	vmod	\N	\N	\N	0	1
509	Ilan ang ginagamit mong diksyunaryo sa pag-aaral ng Tagalog?\n	タガログ語を勉強するのに、いくつの辞書を使っているの？\n	\N		\N	vmod	\N	\N	\N	0	1
510	Dilaw ang paborito kong kulay.\n	私の好きな色は黄色です。\n	\N		\N	vmod	\N	\N	\N	0	1
511	Maraming Pilipino ang umuuwi kapag Disyembre.\n	12月には、たくさんのフィリピン人が（故郷に）帰る。	\N		\N	vmod	\N	\N	\N	0	1
512	Bawal umupo diyan.\n	そこの座るのは禁止です。	\N		\N	vmod	\N	\N	\N	0	1
513	Doktor ang pinsan ni Emma.\n	エマの従兄弟は医者です。\n	\N		\N	vmod	\N	\N	\N	0	1
514	Nagbabasa ako ng dyaryo araw-araw.\n	私は新聞を毎日読みます。\n	\N		\N	vmod	\N	\N	\N	0	1
515	Ganiyang-ganiyan ang mukha ng tatay mo noong bata pa siya.\n	あなたのお父さんは、子供のときに丁度あなたのような顔をしていた。\n	\N		\N	vmod	\N	\N	\N	0	1
516	Gaano karami ang mga eksam mo ngayong semestre?\n	今学期は、あなたはどのくらいたくさん試験があるの？\n	\N		\N	vmod	\N	\N	\N	0	1
517	Nahihilo ako kapag sumasakay ng elebeytor.\n	エレベーターに乗るとめまいがする。\n	\N		\N	vmod	\N	\N	\N	0	1
518	Kailangan kong pumunta nang maaga sa embahada bukas.\n	明日、私は朝早くに大使館に行く必要がある。\n	\N		\N	vmod	\N	\N	\N	0	1
519	Mura ang tiket ng eroplano sa Enero.\n	一月は、飛行機のチケット代が安い。	\N		\N	vmod	\N	\N	\N	0	1
520	Malayo ang eskuwelahan sa aming bahay.\n	学校は私たちの家から遠い。\n	\N		\N	vmod	\N	\N	\N	0	1
521	Kaunti ang mga estudyante sa aklatan.\n	図書館にいる学生は少ないです。\n	\N		\N	vmod	\N	\N	\N	0	1
522	Mawalang-galang na nga po, puwede ho bang magtanong?\n	すみませんが、質問してもいいですか？\n	\N		\N	vmod	\N	\N	\N	0	1
523	Mamaya na ako bibili ng film.\n	フィルムは後で買うよ。\n	\N		\N	vmod	\N	\N	\N	0	1
524	May magandang pontimpen sa mesa ng lolo ko.\n\n	私のおじいさんの机にはいい万年筆がある。\n	\N		\N	vmod	\N	\N	\N	0	1
525	Pluma ang regalo ko sa kanya.	彼女へのプレゼントはペンです。	\N		\N	vmod	\N	\N	\N	0	1
526	Marumi ang kuwelyo ng polo ni Boboy.\n	ボーボイのシャツの襟は汚い。\n	\N		\N	vmod	\N	\N	\N	0	1
527	Nag-aral ako ng wikang Pranses noong hayskul.\n	高校のとき、私はフランス語を勉強した。\n	\N		\N	vmod	\N	\N	\N	0	1
528	Huwag mo akong tanungin tungkol sa mga ganiyang bagay.\n	そういうことについて、私に質問しないで。\n	\N		\N	vmod	\N	\N	\N	0	1
529	Umiinom siya ng gatas bago matulog.\n	彼は寝る前に牛乳を飲む。\n	\N		\N	vmod	\N	\N	\N	0	1
530	Mahilig sa gitara si Freddie.\n	フレディーはギターが好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
531	Tanghali na ako gumising kanina.\n	さっき、お昼に起きたんだ。\n	\N		\N	vmod	\N	\N	\N	0	1
532	Matataas ang mga gusali sa Shinjuku.\n	新宿のビルは高い。\n	\N		\N	vmod	\N	\N	\N	0	1
534	Gustung-gusto ko talaga ang mga kanta ni Jaya.\n	僕はジャヤの歌が大好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
535	Ilang metro ang lapad ng bahay?\n	家の横幅は何メートルありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
536	Nanood siya ng TV habang kumakain.\n	彼女はテレビを見ながら食べた。\n	\N		\N	vmod	\N	\N	\N	0	1
537	Matarik ang hagdan sa bundok.\n	山の階段は急だ。\n	\N		\N	vmod	\N	\N	\N	0	1
538	Maliit lang ang halamanan namin sa probinsya.\n	故郷にある私たちの庭は小さい。\n	\N		\N	vmod	\N	\N	\N	0	1
539	Presko ang hangin sa tabing-dagat.\n	海岸の風は気持ちがいい。\n	\N		\N	vmod	\N	\N	\N	0	1
540	Sinubukan kong mag-aral ng wikang Hapon sa kolehiyo.\n	大学で私は日本語を勉強してみた。\n	\N		\N	vmod	\N	\N	\N	0	1
541	Ano ang ulam natin mamayang hapunan?\n	今晩の夕飯のおかずは何？\n	\N		\N	vmod	\N	\N	\N	0	1
542	May paradahan sa unahan ng gusaling iyan.\n	あの建物の先に、駐車場がある。\n	\N		\N	vmod	\N	\N	\N	0	1
543	Higpitan mo ang hawak sa kamay ng anak mo.\n	子供と繋いでいる手をきつくしなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
544	Nasa hilaga ng Luzon ang Ilocos.\n	イロコスはルソン島の北にある。\n	\N		\N	vmod	\N	\N	\N	0	1
545	Hindi mahusay sa Math si Ella.\n	エラは数学に弱い。\n	\N		\N	vmod	\N	\N	\N	0	1
546	Hindi raw masarap ang balot.\n	バロットはおいしくないそうです。\n	\N		\N	vmod	\N	\N	\N	0	1
547	Marami kaming homework sa Physics.\n	私たちは物理でたくさん宿題がある。\n	\N		\N	vmod	\N	\N	\N	0	1
548	Maulan pa rin sa Hulyo.\n	７月はまだ雨が多い。\n	\N		\N	vmod	\N	\N	\N	0	1
549	Humiram ako ng DVD kay Joseph.\n	私はジョセフにDVDを借りた。\n	\N		\N	vmod	\N	\N	\N	0	1
551	Maraming mga Pilipinong nars sa ibang bansa.\n	外国に、フィリピン人の看護婦がたくさんいる。\n	\N		\N	vmod	\N	\N	\N	0	1
552	Ibenta mo na lang ang mga lumang libro mo.\n	あなたの古い本を売ってしまいなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
553	Idinagdag mo ba rito ang bayad sa kuryente?\n	あなたはここに電気代を加えましたか？\n	\N		\N	vmod	\N	\N	\N	0	1
554	Huwag mong idikit sa pader iyang kalendaryo.\n	そのカレンダーを壁に貼らないで。\n	\N		\N	vmod	\N	\N	\N	0	1
555	Ihuhulog ko mamaya ang mga sulat para kay Nanay.\n	お母さんへの手紙を後で出します。\n	\N		\N	vmod	\N	\N	\N	0	1
556	Ikabit mo ang ilaw sa kisame.\n	天井に電灯を取り付けて。\n	\N		\N	vmod	\N	\N	\N	0	1
557	Malapad ang mesang ito.	この机は広い。	\N		\N	vmod	\N	\N	\N	0	1
558	Malapad ang ilong ko.	私の鼻は広がっている。	\N		\N	vmod	\N	\N	\N	0	1
559	Ano ang paborito mong inumin sa piesta?\n	お祭りで、あなたの好きな飲み物は何？\n	\N		\N	vmod	\N	\N	\N	0	1
560	Ayaw kong ipahiram ang libro ko sa kanya.\n	私は彼女に本を貸したくない。\n	\N		\N	vmod	\N	\N	\N	0	1
561	Isabit mo na lang sa balikat mo iyang bag.\n	そのかばんを肩にかけなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
562	Isang buwan ako na walang suweldo noong isang taon.\n	去年、私は一ヶ月間給料をもらえなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
563	Isara mo ang pinto dahil malamig.\n	寒いからドアを閉めて。\n	\N		\N	vmod	\N	\N	\N	0	1
564	Hindi ako mahilig sa isports.\n	私はスポーツが好きではない。\n	\N		\N	vmod	\N	\N	\N	0	1
565	Magkano ang kailangang selyo para dito?\n	これにはいくらの切手が必要ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
566	Nagkakagulo ang mga tao doon sa maliit na istasyon ng pulis.\n	あの交番で人々が混乱している。	\N		\N	vmod	\N	\N	\N	0	1
567	May bomba daw sa istasyon ng tren.\n	駅に爆弾があるそうです。\n	\N		\N	vmod	\N	\N	\N	0	1
568	Isusuot ko ang pantalon na regalo ni Gary.\n	私はガーリーからのプレゼントのズボンをはく。\n	\N		\N	vmod	\N	\N	\N	0	1
569	Magsumbrero ka dahil mainit sa labas.\n	外は暑いから帽子をかぶりなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
570	Itim ang kulay ng buhok ng mga Filipino.\n	フィリピン人の髪の色は黒い。\n	\N		\N	vmod	\N	\N	\N	0	1
571	Kumakain ako ng itlog sa almusal araw-araw.	毎日、私は朝食に卵を食べる。	\N		\N	vmod	\N	\N	\N	0	1
572	Lilipat ng bahay sina Fe itong buwang ito.\n	今月、フェ達は家を引っ越す。\n	\N		\N	vmod	\N	\N	\N	0	1
573	Nakita mo ba ang jacket ni Rudy?\n	ルーディーの上着を見た？\n	\N		\N	vmod	\N	\N	\N	0	1
574	Hindi ako nakatulog kagabi.	僕は昨夜眠れなかった。	\N		\N	vmod	\N	\N	\N	0	1
575	Ano ang kahulugan nito?\n	この意味は何ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
576	Si Totoy ay matalik kong kaibigan.	トニーは私の親友です。	\N		\N	vmod	\N	\N	\N	0	1
577	Kailan ka ba babalik dito?	いつここに帰ってくるの？	\N		\N	vmod	\N	\N	\N	0	1
578	Kakaunti lang ang kinain ko sa party.\n	パーティーでは、私は少ししか食べなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
579	Nakatira siya sa isang kalapit na bayan.\n	彼は、近くの町に住んでいる。\n	\N		\N	vmod	\N	\N	\N	0	1
580	Ang tao ay may kanan at kaliwang kamay.	人間には右手と左手がある。	\N		\N	vmod	\N	\N	\N	0	1
581	Matulog ka sa kama mo, huwag sa sahig.	床ではなくベッドで寝なさい。	\N		\N	vmod	\N	\N	\N	0	1
582	Nag-swimming kami noong kamakalawa.\n	私たちは、おととい泳ぎに行った。\n	\N		\N	vmod	\N	\N	\N	0	1
583	Mura lang ang binili kong kamera kahapon.	私が昨日買ったカメラは安かった。	\N		\N	vmod	\N	\N	\N	0	1
584	Puti ang suot na kamisadentro ni Tony.\n	トニーの着ているワイシャツは白い。	\N		\N	vmod	\N	\N	\N	0	1
585	Gusto ko ng malagkit na kanin.	モチモチしたご飯が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
586	Lumulubog ang araw sa kanluran.\n	太陽は西に沈む。\n	\N		\N	vmod	\N	\N	\N	0	1
587	Masarap ang pagkain sa kantin ng aming eskwelahan.\n	私たちの学校の食堂の食べ物はおいしい。\n	\N		\N	vmod	\N	\N	\N	0	1
588	Tatlo ang kapatid na babae ni Mario.\n	マリオは、姉妹が３人います。\n	\N		\N	vmod	\N	\N	\N	0	1
589	Mahilig sa karneng baka ang mga taga-Batangas.\n	バタンガス出身の人は、牛肉が好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
590	Katabi ng Bangko ang Mcdo.\n	マクドナルドは、銀行の隣です。\n	\N		\N	vmod	\N	\N	\N	0	1
591	Sagutin mo sa lahat ng katanugan.	すべての問題に答えなさい。	\N		\N	vmod	\N	\N	\N	0	1
592	Mahirap ang mga tanong sa exam kanina.	さっきの試験の問題は難しかった。	\N		\N	vmod	\N	\N	\N	0	1
594	Binigyan niya ang mga bata ng maraming kendi.	彼女は子供たちにたくさんのあめを与えた。	\N		\N	vmod	\N	\N	\N	0	1
595	Hindi ko nilagyan ng keso ang spaghetti.	私はスパゲッティにチーズをかけなかった。	\N		\N	vmod	\N	\N	\N	0	1
596	Maliit lang ang klasrum sa eskuwelahan ni Totoy.\n	トートイの学校の教室は小さい。\n	\N		\N	vmod	\N	\N	\N	0	1
597	Kombiniyente ang kompyuter lalo na sa opisina.\n	特にオフィスでは、コンピュータは便利だ。\n	\N		\N	vmod	\N	\N	\N	0	1
598	Marami akong homework na komposisyon.\n	作文の宿題がたくさんある。\n	\N		\N	vmod	\N	\N	\N	0	1
599	Malabo ang kopyang binigay mo sa akin.\n	君がくれたコピーは不鮮明だよ。\n	\N		\N	vmod	\N	\N	\N	0	1
600	Huwag mong kalimutang kopyahin ang textbook.	教科書をコピーするのを忘れないでね。	\N		\N	vmod	\N	\N	\N	0	1
601	Maingay sa koridor tuwing lunch break.\n	昼休みになると、階段はにぎやかだ。\n	\N		\N	vmod	\N	\N	\N	0	1
602	May aksidente sa krosing kaninang umaga.\n	今朝、交差点で事故があった。\n	\N		\N	vmod	\N	\N	\N	0	1
603	Kulay kape ang balat ng mga mangingisda.\n	猟師たちの肌は茶色だ。\n	\N		\N	vmod	\N	\N	\N	0	1
604	Sa malaking kumpanya nagtatrabaho si Juan.\n	フアンは大きい会社で働いている。\n	\N		\N	vmod	\N	\N	\N	0	1
605	Kung ganoon, tawagan mo na lang ako.\n	じゃあ、私に電話してね。\n	\N		\N	vmod	\N	\N	\N	0	1
606	Mura ang kurbatang nabili ko.\n	私が買ったネクタイは安かった。\n	\N		\N	vmod	\N	\N	\N	0	1
607	Mahal ang kutsarang pilak.	銀のスプーンは高い。	\N		\N	vmod	\N	\N	\N	0	1
608	Ihasa mo itong kutsilyo para tumalas.	鋭くなるように、このナイフを研いで。	\N		\N	vmod	\N	\N	\N	0	1
609	Kailangan ko ng anim na kuwaderno para sa eskwelahan.\n	私は学校で6冊のノートが必要です。\n	\N		\N	vmod	\N	\N	\N	0	1
610	Matangkad ang kuya ni Ben.\n	ベンのお兄さんは背が高い。\n	\N		\N	vmod	\N	\N	\N	0	1
611	Wala akong kuya.	私には兄がいません。	\N		\N	vmod	\N	\N	\N	0	1
612	Hindi ko makita ang labasan sa istasyon ng tren.\n	電車の駅の出口が見当たらない。\n	\N		\N	vmod	\N	\N	\N	0	1
613	Mabuti kaming lahat.	私たちはみんな元気です。	\N		\N	vmod	\N	\N	\N	0	1
614	Ilang metro ang lapad ng bahay?	家の横幅は何メートルですか？	\N		\N	vmod	\N	\N	\N	0	1
615	Sinukat mo ba ang haba ng kahon?\n	箱のたての長さを計った？\n	\N		\N	vmod	\N	\N	\N	0	1
616	Ilang lapis ang binili mo sa tindahang iyan?	そのお店で鉛筆をいくつ買ったの？	\N		\N	vmod	\N	\N	\N	0	1
617	Pinagmasdan niya ang larawan ng kanyang ina.\n	彼のお母さんの絵を、彼はじっと見つめた。\n	\N		\N	vmod	\N	\N	\N	0	1
618	Malalim ang lawa sa Taal.\n	タール湖は深い。\n	\N		\N	vmod	\N	\N	\N	0	1
619	Nilagyan ko ng limon ang tsaa.\n	私は紅茶にレモンを入れた。\n	\N		\N	vmod	\N	\N	\N	0	1
620	Kunan mo ng letrato ang pamilya mo.\n	家族の写真を撮りなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
621	May ilog sa likod ng bahay namin.\n	私たちの家の後ろには、川がある。\n	\N		\N	vmod	\N	\N	\N	0	1
622	Huwag kang maglakad sa likod ko.	私の後を歩かないで。	\N		\N	vmod	\N	\N	\N	0	1
623	Linggu-linggo silang nagbabasketbol sa gym.\n	毎週彼らは体育館でバスケットボールをする。\n	\N		\N	vmod	\N	\N	\N	0	1
624	Maaliwalas sa loob ng bahay ni Nene.\n	根根の部屋の中は明るくて心地が良い。	\N		\N	vmod	\N	\N	\N	0	1
625	Luma ang kotseng minamaneho ni Jun.\n	ジュンの運転している車は古い。\n	\N		\N	vmod	\N	\N	\N	0	1
626	Bawal lumiko diyan sa kanto.\n	その角では、曲がるのは禁止です。\n	\N		\N	vmod	\N	\N	\N	0	1
627	Ang ibon ay lumipad na patimog.	鳥は南へ飛んでいった。	\N		\N	vmod	\N	\N	\N	0	1
628	Anong luto ang gusto mo sa baboy?\n	豚を使った何の料理が好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
629	Mababa lang ang nakuha ko sa test kahapon.\n	昨日のテストで私の取った点数は低かった。\n	\N		\N	vmod	\N	\N	\N	0	1
630	Mabagal maglakad ang pagong ko.\n	私の亀はゆっくり歩く。\n	\N		\N	vmod	\N	\N	\N	0	1
631	Mabigat ang elepante.\n	像は重い。\n	\N		\N	vmod	\N	\N	\N	0	1
632	Madalas kaming mag-aral sa aklatan.\n	私たちは、よく図書館で勉強する。\n	\N		\N	vmod	\N	\N	\N	0	1
633	Natatakot akong maglakad sa madilim na kalye.\n	暗い道を歩くのは怖い。\n	\N		\N	vmod	\N	\N	\N	0	1
634	Palaging madilim ang kulay ng damit ni Tuting.\n	トゥティンの服の色はいつも暗い。\n	\N		\N	vmod	\N	\N	\N	0	1
635	Magaan ang balahibo ng manok.\n	鳥の羽根は軽い。\n	\N		\N	vmod	\N	\N	\N	0	1
636	Mahilig magbasa ng magasin ang ate ko.\n	私の姉は、雑誌を読むのが好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
637	Ayaw kong magbasa ng makakapal na libro.\n	私は厚い本を読むのが嫌いだ。\n	\N		\N	vmod	\N	\N	\N	0	1
638	Madalas mag-ensayo sa umaga ang mga manlalaro.\n	選手たちは、よく午前中に練習する。	\N		\N	vmod	\N	\N	\N	0	1
639	Huwag kang maghubad ng sapatos dito.\n	ここで靴を脱がないで。\n	\N		\N	vmod	\N	\N	\N	0	1
640	Naghuhugas ang kuya ko ng pinggan.\n	私の兄は皿を洗っている。\n	\N		\N	vmod	\N	\N	\N	0	1
641	Magiging maulap ang kalangitan bukas ng hapon.\n	明日の午後、空は曇るでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
642	Nagkuwento ng katatakutan si Larry kagabi.\n	昨晩、ラリーは怖い話をした。\n	\N		\N	vmod	\N	\N	\N	0	1
643	Ayaw kong maglaba ng maong.\n	ジーンズを洗うのは嫌だ。\n	\N		\N	vmod	\N	\N	\N	0	1
644	Naglakbay kami nang matagal sa disyerto.\n	私たちは長い間砂漠を旅した。\n	\N		\N	vmod	\N	\N	\N	0	1
645	Naglilinis ako ng kuwarto araw-araw.\n	私は毎日部屋を掃除します。\n	\N		\N	vmod	\N	\N	\N	0	1
646	Sabihin mo ang iyong gusto.	あなたのしたいことを言ってね。	\N		\N	vmod	\N	\N	\N	0	1
647	Marunong ka bang magsalita ng wikang Hapon?\n	あなたは日本語を話せる？\n	\N		\N	vmod	\N	\N	\N	0	1
648	Anong oras nagsimula ang klase ninyo?\n	あなたたちの授業は何時に始まったの？\n	\N		\N	vmod	\N	\N	\N	0	1
649	Huwag kang magsuot ng maruming damit.\n	汚い服を着るな。\n	\N		\N	vmod	\N	\N	\N	0	1
650	Nagtatrabaho sa ibang bansa ang ate kong nars.\n	看護婦の姉は、外国で働いている。\n	\N		\N	vmod	\N	\N	\N	0	1
652	Nagtuturo siya sa UP.\n	彼女は、フィリピン大学で教えている。\n	\N		\N	vmod	\N	\N	\N	0	1
653	Mauunawaan mo rin ito kapag naging magulang ka na.\n	あなたも親になったときに、これが理解できるだろう。\n	\N		\N	vmod	\N	\N	\N	0	1
654	Mukhang mahina ang katawan ng manlalarong iyon.\n	あの選手は体が弱いようだ。	\N		\N	vmod	\N	\N	\N	0	1
655	Masarap ang mainit na kape sa almusal.\n	朝食に、熱いコーヒーはおいしい。\n	\N		\N	vmod	\N	\N	\N	0	1
656	Makapal ang salamin ni Lorna.\n	ローナの眼鏡は厚い。\n	\N		\N	vmod	\N	\N	\N	0	1
657	Hindi ako nakinig sa klase kanina.\n	さっっき僕は授業を聞いていなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
658	Malakas ang ulan kahapon.\n	昨日、雨が強かった。\n	\N		\N	vmod	\N	\N	\N	0	1
659	Malamig sa Baguio lalo na sa Disyembre.\n	１２月は特に、バギオは寒い。\n	\N		\N	vmod	\N	\N	\N	0	1
660	Masarap uminom ng malamig na juice sa tag-init.\n	夏に冷たいジュースを飲むのは、おいしい。\n	\N		\N	vmod	\N	\N	\N	0	1
661	Malapit lang sa eskuwelahan ang bahay nina Lito.\n	リトたちの家は学校の近くだ。\n	\N		\N	vmod	\N	\N	\N	0	1
662	Naliligo ako bago pumasok sa opisina.\n	私は事務所に出かける前に、お風呂に入る。\n	\N		\N	vmod	\N	\N	\N	0	1
663	Maliit lang ang apartment namin sa Maynila.\n	マニラの私たちのアパートは、小さい。\n	\N		\N	vmod	\N	\N	\N	0	1
664	Maliwanag ang kuwarto ni Karen.	カレンの部屋は明るい。	\N		\N	vmod	\N	\N	\N	0	1
665	Araw-araw ka bang namimili sa palengke?\n	あなたは毎日市場に買い物に行くのですか？\n	\N		\N	vmod	\N	\N	\N	0	1
666	Araw-araw ka bang namimili sa palengke?\n	あなたは毎日市場で買い物するのですか？\n	\N		\N	vmod	\N	\N	\N	0	1
667	Nabasag ko ang mangkok sa restawran.\n	私はレストランで、茶碗を割ってしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
668	Bawal manigarilyo sa loob ng gusali.\n	建物の中でタバコを吸うのは、禁止です。\n	\N		\N	vmod	\N	\N	\N	0	1
669	Manipis lang na libro ang kasya sa bag ko.\n	私のバックに入るのは、薄い本だけです。\n	\N		\N	vmod	\N	\N	\N	0	1
670	Hindi ko maintindihan ang mapa ni Lucy.\n	ルーシーの地図は私には分からない。\n	\N		\N	vmod	\N	\N	\N	0	1
671	Marami ang mga Pilipinong nagtatrabaho sa Amerika.\n	アメリカで働くフィリピン人はたくさんいます。\n	\N		\N	vmod	\N	\N	\N	0	1
672	Malamig pa ang Marso sa Hapon.	３月は、日本ではまだ寒い。	\N		\N	vmod	\N	\N	\N	0	1
673	Wala akong pasok tuwing Marso.	私は毎週火曜日は仕事がない。	\N		\N	vmod	\N	\N	\N	0	1
674	Wala akong pasok tuwing Martes.	私は毎週火曜日には仕事がない。	\N		\N	vmod	\N	\N	\N	0	1
675	Masakit ang tiyan ko.	お腹が痛いです。	\N		\N	vmod	\N	\N	\N	0	1
676	Hindi siya gumawa ng masama.	彼は悪いことなどしていない。	\N		\N	vmod	\N	\N	\N	0	1
677	Lumaki sanang masigla ang anak natin.\n	私たちの息子が元気に育って欲しい。\n	\N		\N	vmod	\N	\N	\N	0	1
678	Bigyan natin ng sigla ang ating pag-awit.	もっとにぎやかに歌おう。	\N		\N	vmod	\N	\N	\N	0	1
679	Malabo ang mata ng lola ko.	私の祖母の目は老眼だ。	\N		\N	vmod	\N	\N	\N	0	1
680	Matanda na ang lolo ko pero malakas pa siya.	私のおじいさんはもう年老いているが、まだ丈夫だ。	\N		\N	vmod	\N	\N	\N	0	1
681	Maulap ngayon, kaya hindi mainit.	今日は曇っているので、暑くない。	\N		\N	vmod	\N	\N	\N	0	1
682	Presko ang hangin kung Mayo sa Hapon.	日本は、５月には風が心地よい。	\N		\N	vmod	\N	\N	\N	0	1
683	Nawalan ako ng medyas.	靴下をなくしてしまった。	\N		\N	vmod	\N	\N	\N	0	1
684	Malaki ang mesa ko sa bahay.\n	家の私の机は大きい。\n	\N		\N	vmod	\N	\N	\N	0	1
685	Hindi ko gusto ang paglalaba ng ating katulong.\n	私は、私たちのお手伝いさんがする洗濯は好きじゃない。\n	\N		\N	vmod	\N	\N	\N	0	1
686	Kailangan natin ng malaking halaga para sa paglalakbay na ito.\n	私たちは、この旅行のためにたくさんの蓄えが必要だ。\n	\N		\N	vmod	\N	\N	\N	0	1
687	Magaling sa paglilinis ng bahay si Nena.\n	ネナは、家の掃除が上手だ。\n	\N		\N	vmod	\N	\N	\N	0	1
688	Huwag kang makinig sa pag-uusap nila.\n	彼らの話を聞くな。\n	\N		\N	vmod	\N	\N	\N	0	1
689	Ilang palapag ang gusali ninyo?\n	この建物は何階建てですか？\n	\N		\N	vmod	\N	\N	\N	0	1
690	Kasama nila ang aso sa pamamasyal.\n	彼らは散歩に犬を連れて行った。\n	\N		\N	vmod	\N	\N	\N	0	1
691	Malungkot ang aking pamilya sa aking pag-alis.\n	私が出て行くことで、家族は寂しがっている。\n	\N		\N	vmod	\N	\N	\N	0	1
692	Kasama niya ang katulong sa pamimili sa palengke.\n	彼女は市場にお手伝いさんと買い物に出かける。\n	\N		\N	vmod	\N	\N	\N	0	1
693	Dalawin mo naman kami dito paminsan-minsan.\n	時々ここに私たちを訪ねて来てね。\n	\N		\N	vmod	\N	\N	\N	0	1
694	Masama raw ang panahon bukas.\n	明日の天気は悪いらしい。\n	\N		\N	vmod	\N	\N	\N	0	1
695	Hindi ko maintindihan ang pangungusap na ito.\n	この文章の意味は分からない。\n	\N		\N	vmod	\N	\N	\N	0	1
696	Nakalimutan ko sa bahay ang aking panlamig.\n	家に私のコートを忘れてしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
697	Makapal ang pantalon na suot ko.\n	私のはいているズボンは厚い。\n	\N		\N	vmod	\N	\N	\N	0	1
698	Bawal magbigay ng panyo bilang regalo.\n	プレゼントにハンカチをあげてはいけない。\n	\N		\N	vmod	\N	\N	\N	0	1
699	Napunit ang papel ko.\n	私の紙が破れてしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
700	Mahaba ang palda ni Mila.\n	ミラのスカートは長い。\n	\N		\N	vmod	\N	\N	\N	0	1
701	Pumupunta kami sa park tuwing Linggo.\n	毎週日曜日に、私たちは公園に行く。\n	\N		\N	vmod	\N	\N	\N	0	1
702	Hindi ako mahilig pumunta sa mga parti.\n	私はパーティーに行くのが好きではない。\n	\N		\N	vmod	\N	\N	\N	0	1
703	Malayo mula rito ang pasukan ng supermarket.\n	ここからスーパーの入り口までは遠い。\n	\N		\N	vmod	\N	\N	\N	0	1
704	Magdala ka ng payong, kasi uulan daw mamaya.	後で雨が降るそうだから、傘を持っていきなさい。	\N		\N	vmod	\N	\N	\N	0	1
705	Dumating siya noong nakaraang Pebrero.	彼はこの間の２月に到着した。	\N		\N	vmod	\N	\N	\N	0	1
706	Wala na akong pera.	私はもうお金がない。	\N		\N	vmod	\N	\N	\N	0	1
707	Hindi siya kumantok sa pinto bago pumasok.\n	彼女は入る前に戸をノックしなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
708	Wala bang pinto sa kuwarto mo?	あなたの部屋にはドアがないの？	\N		\N	vmod	\N	\N	\N	0	1
709	Hindi siya kumatok sa pinto bago pumasok.\n	彼女は入る前に戸をノックしなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
710	May mga halaman sa pintuan ng kapitbahay ko.\n	私のお隣さんの玄関には植物がある。\n	\N		\N	vmod	\N	\N	\N	0	1
711	Ilang pirasong papel ang kailangan mo?\n	あなたは何枚の紙が必要なの？\n	\N		\N	vmod	\N	\N	\N	0	1
712	Ayaw kong maghugas ng plato.	私は皿を洗うのが嫌いだ。	\N		\N	vmod	\N	\N	\N	0	1
713	Maraming tao kanina sa pos opis.\n	さっき、郵便局にたくさん人がいた。\n	\N		\N	vmod	\N	\N	\N	0	1
714	Bumili ako ng poskard para sa pamilya ko.\n	私は家族にポストカードを買った。\n	\N		\N	vmod	\N	\N	\N	0	1
715	Presko ang pakiramdam pagkatapos maligo.\n	水浴びをした後は涼しい。	\N		\N	vmod	\N	\N	\N	0	1
716	Ano ang pinakapaborito mong prutas?	あなたの一番好きなフルーツは何ですか？	\N		\N	vmod	\N	\N	\N	0	1
717	 Pula ang labi niya at makinis ang balat niya.	彼女は唇が赤く、肌がつやつやしている。	\N		\N	vmod	\N	\N	\N	0	1
718	May kakilala akong pulis.\n	私は警察官の知り合いがいる。\n	\N		\N	vmod	\N	\N	\N	0	1
719	Hinuli siya ng isang pulis.	彼はお巡りさんに捕まった。	\N		\N	vmod	\N	\N	\N	0	1
720	Nakikinig ako ng balita sa radyo.\n	私はラジオでニュースを聞いている。\n	\N		\N	vmod	\N	\N	\N	0	1
721	Nasira ang radyo ko sa bahay.\n	家の私のラジオが壊れてしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
722	May mga binebentang lumang plaka sa Quiapo.\n	キアポでは古いレコードを売っている。	\N		\N	vmod	\N	\N	\N	0	1
723	Nawalan ako ng relo ko.	私は時計をなくしてしまった。	\N		\N	vmod	\N	\N	\N	0	1
724	Malaki ang repridyereytor ng tiyo ko.\n	私のおじの冷蔵庫は大きい。	\N		\N	vmod	\N	\N	\N	0	1
725	Madalang kaming kumain sa restawran.\n	私たちは、ほとんどレストランで食事をしない。	\N		\N	vmod	\N	\N	\N	0	1
726	Siya ang pinakamagandang babae sa bayang ito.	彼女がこの町中で一番美しい。	\N		\N	vmod	\N	\N	\N	0	1
727	Sa isa pang taon ang kasal ng pinsan ko.\n	私の従兄弟の結婚式は再来年です。\n	\N		\N	vmod	\N	\N	\N	0	1
728	Aalis papuntang Canada sa isang taon ang kapatid ko.\n	私の弟は来年カナダに出発する。\n	\N		\N	vmod	\N	\N	\N	0	1
729	Sa Sabado ang susunod na miting natin.	次回の集まりは土曜日です。\n	\N		\N	vmod	\N	\N	\N	0	1
730	Maraming sakit ang makukuha sa maruming ilog.\n	汚い川では、様々な病気にかかる恐れがある。\n	\N		\N	vmod	\N	\N	\N	0	1
731	Natapakan ko ang salamin sa mata ni Jean.\n	ジーンの眼鏡を踏んでしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
732	Samakalawa na ang uwi ni Kuya galing sa Saudi.\n	サウジアラビアから、兄が帰国するのはもう明後日だ。\n	\N		\N	vmod	\N	\N	\N	0	1
733	Tignan mong mabuti ang iyong sarili sa salamin.\n	鏡で自分自身をよく見つめなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
734	Wala pang pasok sa aming eskuwelahan sa Setyembre.	私たちの学校では、９月にはまだ授業がありません。	\N		\N	vmod	\N	\N	\N	0	1
735	Nag-shower ako kagabi bago matulog.\n	昨日の夜、寝る前にシャワーを浴びた。\n	\N		\N	vmod	\N	\N	\N	0	1
736	Mura lang ang sigarilyo sa tindahan sa kanto.\n	角のお店は、タバコが安い。\n	\N		\N	vmod	\N	\N	\N	0	1
737	Sige, kumain ka na.\n	どうぞ、食べてください。\n	\N		\N	vmod	\N	\N	\N	0	1
738	Naging sikat si Mariah Carey sa Pilipinas.\n	マライア・キャリーは、フィリピンで有名になった。\n	\N		\N	vmod	\N	\N	\N	0	1
739	Sumisikat ang araw sa silangan.\n	太陽は東から昇る。\n	\N		\N	vmod	\N	\N	\N	0	1
740	Sino sa inyo ang may kotse?	あなたたちの中で、誰か車を持っている人？	\N		\N	vmod	\N	\N	\N	0	1
741	May sipon ka ba?\n	風を引いてしまったの？	\N		\N	vmod	\N	\N	\N	0	1
742	May sipon ka ba?\n	風邪を引いてしまったの？	\N		\N	vmod	\N	\N	\N	0	1
743	Ilang sobre ang ipapadala mo sa kanila?\n	彼らにいくつの封筒を送るの？\n	\N		\N	vmod	\N	\N	\N	0	1
744	Wala pang subway sa Pilipinas.\n	フィリピンにはまだ地下鉄がない。\n	\N		\N	vmod	\N	\N	\N	0	1
745	Naghulog ako ng sulat noong isang araw.\n	先日私は手紙を出した。\n	\N		\N	vmod	\N	\N	\N	0	1
746	Sino ang sumagot sa tanong mo?\n	あなたの質問に誰が答えたの？	\N		\N	vmod	\N	\N	\N	0	1
747	Malaki ang sumbrero ng magsasaka.\n	農夫の帽子は大きい。	\N		\N	vmod	\N	\N	\N	0	1
748	Sumulat ka sa nanay mo para hindi siya mag-alala.\n	お母さんが心配しないように、手紙を書きなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
749	Nakalimutan ko ang susi sa loob ng kotse.\n	車の中に鍵を忘れた。\n	\N		\N	vmod	\N	\N	\N	0	1
750	Paborito ko ang kulay asul na sweater.\n	私は青のセーターがお気に入りだ。\n	\N		\N	vmod	\N	\N	\N	0	1
751	Nilinisan niya kahapon ang swimming pool.\n	彼は昨日プールを掃除した。\n	\N		\N	vmod	\N	\N	\N	0	1
752	Ilang metro rin ang taas ng bahay ni Jess?\n\n	ジェスの家は高さが何メートルありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
753	May mga bahay sa tabi ng ilog.\n	川のそばに家が数軒ある。\n	\N		\N	vmod	\N	\N	\N	0	1
754	Pumupunta kami sa dagat tuwing tag-init.\n	私たちは夏になる度に海に行く。\n	\N		\N	vmod	\N	\N	\N	0	1
755	Mainit ba sa taglagas sa Hapon?	日本では、秋は暑いですか？	\N		\N	vmod	\N	\N	\N	0	1
756	Sinisipon ako tuwing taglamig.\n	冬になる度に私は風邪を引く。\n	\N		\N	vmod	\N	\N	\N	0	1
757	Maraming bulaklak ang namumukadkad tuwing tagsibol.\n	春になると、たくさんの花が満開になる。	\N		\N	vmod	\N	\N	\N	0	1
758	Lumaki ako sa isang masayang tahanan.\n	私は楽しい家庭で育った。\n	\N		\N	vmod	\N	\N	\N	0	1
759	Tahimik na lugar ang sementeryo.\n	お墓は静かな場所です。\n	\N		\N	vmod	\N	\N	\N	0	1
760	Siguraduhin mong gumagana ang metro ng taksi.\n	タクシーのメーターが動いているのを確認しなさい。	\N		\N	vmod	\N	\N	\N	0	1
761	Hindi ako kumakain ng tanghalian.\n	私はお昼ご飯を食べない。\n	\N		\N	vmod	\N	\N	\N	0	1
762	Ano ba ang tanong mo sa kanya kanina?\n	さっき、彼に対するあなたの質問は何だったの？\n	\N		\N	vmod	\N	\N	\N	0	1
763	Ang lahat ng tao ay mamamatay.	すべての人は死ぬ。	\N		\N	vmod	\N	\N	\N	0	1
764	Luma na ang tape recorder na ito.	このテープレコーダーはもう古い。	\N		\N	vmod	\N	\N	\N	0	1
765	Bigyan mo ako ng isang tasang kape.	私にコーヒーを一杯ちょうだい。	\N		\N	vmod	\N	\N	\N	0	1
766	Magaling magmaneho ang tatay ko.	私の父は運転するのが上手です。	\N		\N	vmod	\N	\N	\N	0	1
767	Nasira ang telebisyon namin kahapon.	きのう私たちのテレビが壊れてしまった。	\N		\N	vmod	\N	\N	\N	0	1
768	Mayroong tatlong telepono sa opis namin.	私たちの事務所には、３つの電話がある。	\N		\N	vmod	\N	\N	\N	0	1
769	Nasugatan siya sa tenga niya.	彼は耳に怪我をした。	\N		\N	vmod	\N	\N	\N	0	1
770	Mahal ang tiket ng tren sa Hapon.	日本では電車の切符は高い。	\N		\N	vmod	\N	\N	\N	0	1
771	Maraming tindahan ng gulay sa palengke ng Baguio.\n	バギオの市場には、八百屋がたくさんある。\n	\N		\N	vmod	\N	\N	\N	0	1
772	Ipakikuha mo nga ako ng isang tinidor.	私にフォークをひとつ取ってください。	\N		\N	vmod	\N	\N	\N	0	1
773	Pakilinisan ang ashtray pagkatapos mong manigarilyo.\n	タバコを吸った後、灰皿をきれいにしてね。\n	\N		\N	vmod	\N	\N	\N	0	1
774	Isang abogado ang tito ko.\n	私のおじは弁護士です。\n	\N		\N	vmod	\N	\N	\N	0	1
775	Malaki ang tiyan ng pulis sa kanto.\n	街角にいる警官のお腹は大きい。\n	\N		\N	vmod	\N	\N	\N	0	1
776	Maalat ang toyong nabili ko.\n	私の買った醤油は塩辛い。\n	\N		\N	vmod	\N	\N	\N	0	1
777	Kinakalawang na ang trangkahan namin.\n	私たちの門は、もう錆付いている。	\N		\N	vmod	\N	\N	\N	0	1
778	Umiinom siya ng green tea pagkatapos kumain.\n	彼は食事が終わった後にお茶を飲む。\n	\N		\N	vmod	\N	\N	\N	0	1
779	Umiinom ako ng tsaa kapag may lagnat ako.\n	私は熱があるときには紅茶を飲む。\n	\N		\N	vmod	\N	\N	\N	0	1
780	Magtsinelas ka dito.	ここではスリッパを履いてね。	\N		\N	vmod	\N	\N	\N	0	1
781	Tumakbo nang mabilis ang mga magnanakaw.\n	泥棒たちは、早く走った。\n	\N		\N	vmod	\N	\N	\N	0	1
782	Tumayo ka nang diretso.\n	まっすぐ立ちなさい。	\N		\N	vmod	\N	\N	\N	0	1
783	Tumutugtog ng gitara sa istasyon ng tren ang mga pulubi.\n	こじきたちが電車の駅でギターを演奏している。\n	\N		\N	vmod	\N	\N	\N	0	1
784	Tuwid na tuwid umupo ang mga binata dito.	ここの独身男性は、とてもまっすぐに座る。	\N		\N	vmod	\N	\N	\N	0	1
785	Bilog ang ulo ng sanggol.\n	赤ちゃんの頭は丸い。\n	\N		\N	vmod	\N	\N	\N	0	1
786	Napakatrapik talaga sa umaga.\n	朝は交通渋滞がひどい。\n	\N		\N	vmod	\N	\N	\N	0	1
787	Uminom ka ng gamot para sa lagnat.\n	解熱薬を飲みなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
788	Umulan nang malakas kagabi.\n	昨夜、雨が強く降った。\n	\N		\N	vmod	\N	\N	\N	0	1
789	Huwag kang umupo sa sahig.\n	床に座らないで。\n	\N		\N	vmod	\N	\N	\N	0	1
790	Nakapag-aral si Letty sa isang sikat na unibersidad.\n	レティーはある有名大学で勉強した。	\N		\N	vmod	\N	\N	\N	0	1
791	Wala nang upuan sa simbahan nang dumating kami.\n	私たちが教会に着いたとき、椅子はもうなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
792	Walang kuwentang kausap ang binatang iyon.\n	その独身男性は、話をしてもつまらない相手だ。	\N		\N	vmod	\N	\N	\N	0	1
793	Ilan ang pupunta sa ating pag-eensayo mamayang hapon?\n	今日の午後、私たちの練習には何人来るの？	\N		\N	vmod	\N	\N	\N	0	1
794	May lagnat ka ba? Ilang digri?	熱があるの？何度？	\N		\N	vmod	\N	\N	\N	0	1
795	Baka may sakit siya, kasi masyado siyang payat.	彼は病気かもしれない、細すぎるから。	\N		\N	vmod	\N	\N	\N	0	1
796	Matagal na akong nag-aaral ng Filipino.	私は長い間フィリピン語を勉強している。	\N		\N	vmod	\N	\N	\N	0	1
797	Ito ang pinakasikat na otel sa Pilipinas.	これがフィリピンで一番有名なホテルです。	\N		\N	vmod	\N	\N	\N	0	1
798	Hindi ako kumakain ng manok.	私は鶏肉を食べない。	\N		\N	vmod	\N	\N	\N	0	1
799	Masyadong maliit ang mesa namin sa bahay.	私たちの家のテーブルは小さすぎる。	\N		\N	vmod	\N	\N	\N	0	1
800	Masakit ang ngipin ko kagabi.	昨夜、私は歯が痛かった。	\N		\N	vmod	\N	\N	\N	0	1
801	Ayaw kong pumunta sa ospital.	私は病院に行きたくない。	\N		\N	vmod	\N	\N	\N	0	1
802	Nakakatawa ang kuwento niya.	彼の話はおもしろい。	\N		\N	vmod	\N	\N	\N	0	1
803	Nakasuot siya ng Kimono kanina.	彼女はさっき着物を着ていた。	\N		\N	vmod	\N	\N	\N	0	1
804	Hindi ako mahilig sa mga matamis.	私はお菓子があまり好きではない。	\N		\N	vmod	\N	\N	\N	0	1
805	Nanganak siya noong isang buwan.	彼女は先月出産した。	\N		\N	vmod	\N	\N	\N	0	1
806	Aalis ako sa Nobyembre sa Amerika.	私は11月にアメリカに発つ。	\N		\N	vmod	\N	\N	\N	0	1
77	Oo nga pala.	そうだね。			\N	dmod	tl02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
114	Hindi ko naman bertdey, ah.	でも僕の誕生日じゃないよ。			\N	dmod	tl06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
380	Sa Quezon Hall ho. 	ケソンホールです。			\N	dmod	tl33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1	Naglalaro  ang mga bata.	子供たちは遊んでいます。	null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2	Estudyante si Lita.	リタは学生です。	null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
3	Natutulog sila.	彼らは寝ています。	null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
442	Totoo? 	本当？	紹介		\N	dmod	tl40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
286	Ang lakas ng ulan!	雨が強いなぁ！	機能		\N	dmod	tl23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
533	Gusto ko ng bagong kotse.\n	新しい車が欲しい。\n	\N		\N	vmod	\N	\N	\N	0	1
593	Malakas ang katawan niya.	彼女の体は丈夫だ。	\N		\N	vmod	\N	\N	\N	0	1
4	Estudyante kami.	私たちは学生です。	null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
5	Maasim ito.	これはすっぱいです。	null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
6	Mangga ang mga ito.	これらはマンゴーです。	null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
7	Matamis ba ang mangga?	マンゴーは甘いですか。	null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
8	Makulit ba si John?	ジョンは頑固ですか。	null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
9	Masaya ka ba?	あなたは幸せですか。	null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
10	Sampagita ba ang mga ito?	これらはサンパギータですか。	null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
11	Hindi mura ang pinya.	パイナップルは安くありません。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
12	Hindi Pilipina si Carmen.	カルメンはフィリピン人ではありません。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
13	Hindi ako gutom.	私はお腹が空いていません。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
14	Hindi ito gumamela.	これはハイビスカスではありません。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
15	Alin ang sampagita? Ito ang sampagita. 	どれがサンパギータですか。これがサンパギータです。	null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
16	Sino ang mabait? Ikaw ang mabait.	誰が親切ですか。あなたが親切です。	null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
17	Sino ang kumakanta? Ang mga bata ang kumakanta.	誰が歌っていますか。子供たちが歌っています。	null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
99	Salamat.	ありがとう。			\N	dmod	tl04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
189	Oo.	ええ。			\N	dmod	tl13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
651	Itinulak daw ni Nene ang kalaro niya.\n	ネネは、相手を押したそうだ。\n	\N		\N	vmod	\N	\N	\N	0	1
807	Wala akong ginagawa ngayong Oktubreng ito.	私はこの10月、することが何もない。	\N		\N	vmod	\N	\N	\N	0	1
808	Wala tayong klase sa Miyerkoles, di ba?	私たちは、水曜日に授業がないよね？	\N		\N	vmod	\N	\N	\N	0	1
809	Nagkasakit siya noong isang linggo.	彼は先週病気になった。	\N		\N	vmod	\N	\N	\N	0	1
810	Hindi masyadong mainit ang tag-init ngayong taon.	今年は夏があまり暑くない。	\N		\N	vmod	\N	\N	\N	0	1
811	Estudyante pa ako noong isa pang taon.	私は一昨年、まだ学生だった。	\N		\N	vmod	\N	\N	\N	0	1
812	May talento siya sa musika.	彼は音楽の才能がある。	\N		\N	vmod	\N	\N	\N	0	1
813	Umulan ng niyebe kanina.	さっき雪が降った。	\N		\N	vmod	\N	\N	\N	0	1
814	Puwede ba akong humiram ng lapis na iyan?	私はその鉛筆を借りてもいいですか？	\N		\N	vmod	\N	\N	\N	0	1
815	Masayang masaya sa bayan namin pag may piesta.	私たちの村は、お祭りがあるときはとても楽しい。	\N		\N	vmod	\N	\N	\N	0	1
816	Hindi ako mahilig sa mga kulay na matingkad.	私は明るい色があまり好きではない。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: tl
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	702	行く	1	1
2	703	英語	1	1
3	704	飛行機	1	1
4	705	外国	1	1
5	706	外国人	1	1
6	707	フランス語	1	1
7	708	ホテル	1	1
8	709	日本語	1	1
9	710	出掛ける	1	1
10	711	国（くに）	1	1
11	712	会う	1	1
12	713	休み	1	1
13	714	旅行	1	1
14	715	旅行する	1	1
15	716	遊ぶ	1	1
16	717	大使館	1	1
17	718	大好き	1	1
18	719	好き	1	0
19	720	上手（じょうず）	1	1
20	721	走る	1	1
21	722	ゆっくり	1	1
22	723	下手（へた）	1	1
23	724	歩く	1	1
24	725	泳ぐ	1	1
25	726	速い［スピードが～］	1	1
26	727	飛ぶ	1	1
27	728	スポーツ	1	1
28	729	嫌い	1	1
29	730	プール	1	1
30	731	バス	1	1
31	732	自転車	1	1
32	733	交差点	1	1
33	734	道（みち）	1	1
34	735	池、湖	1	1
35	736	散歩	1	1
36	737	かわ（川・河）	1	1
37	738	タクシー	1	1
38	739	自動車，車（くるま）	1	1
39	740	曲がる	1	1
40	741	ネクタイ	1	1
41	742	ワイシャツ	1	1
42	743	会社	1	1
43	744	背広	1	1
44	745	やる	1	1
45	746	吸う	1	1
46	747	電話	1	1
47	748	仕事	1	1
48	749	働く・勤める	1	1
49	750	忙しい	1	1
50	751	図書館	1	1
51	752	辞書，字引	1	1
52	753	借りる	1	1
53	754	新聞	1	1
54	755	読む	1	1
55	756	本	1	1
56	757	コピー	1	1
57	758	コピーする	1	1
58	759	雑誌	1	1
59	760	冊	1	\N
60	761	牛肉	1	1
61	762	安い	1	1
62	763	店	1	1
63	764	高い	1	1
64	765	いくつ	1	1
65	766	いくら	1	1
66	767	果物	1	1
67	768	野菜	1	1
68	769	魚	1	1
69	770	豚肉	1	1
70	771	鳥肉	1	1
71	772	肉	1	1
72	719	欲しい	1	1
73	774	渡す	1	1
74	775	八百屋	1	1
75	776	かぎ（鍵）	1	1
76	777	料理	1	1
77	778	買い物する	1	1
78	779	洗濯する	1	1
79	780	掃除する	1	1
80	781	家族	1	1
81	782	家庭	1	1
82	783	庭（にわ）	1	1
83	784	洗濯	1	1
84	785	うち（家）	1	1
85	785	家（いえ）	1	1
86	787	掃除	1	1
87	788	かえる（帰・返）	1	1
88	789	本棚	1	1
89	790	机	1	1
90	791	椅子（いす）	1	1
91	792	部屋	1	1
92	793	冷蔵庫	1	1
93	794	洗う	1	1
94	795	ベッド	1	1
95	796	ラジオ	1	1
96	796	ラジカセ	1	1
97	798	～という名前です	1	1
98	799	寝る	1	1
99	800	起きる	1	1
100	790	テーブル	1	1
101	802	テレビ	1	1
102	803	お巡りさん	1	1
103	803	警官	1	1
104	805	地図	1	1
105	806	そば	1	1
106	807	ここ,こちら, こっち	1	1
107	808	そこ,そちら, そっち	1	1
108	809	あちら, あっち，あそこ	1	1
109	810	どこ,どちら,どっち	1	1
110	811	交番	1	1
111	812	近く	1	1
112	813	隣	1	1
113	814	きく	1	1
114	815	切る	1	1
115	816	短い	1	1
116	817	後ろ	1	1
117	818	前	1	1
118	819	右	1	1
119	820	左	1	1
120	821	長い	1	1
121	822	座る	1	1
122	823	立つ	1	1
123	824	友達	1	1
124	825	クラス	1	1
125	826	教室	1	1
126	827	廊下	1	1
127	828	学校	1	1
128	829	生徒	1	1
129	830	勉強	1	1
130	829	学生	1	1
131	832	留学生	1	1
132	833	夏休み	1	1
133	834	先生	1	1
134	835	大学	1	1
135	836	ノート	1	1
136	837	授業	1	1
137	838	作文	1	1
138	839	宿題	1	1
139	840	難しい	1	1
140	841	教える	1	1
141	842	テスト	1	1
142	843	練習	1	1
143	844	易しい	1	1
144	845	練習する	1	1
145	846	質問	1	1
146	847	問題	1	1
147	848	答える	1	1
148	849	痛い	1	1
149	850	歯	1	1
150	851	医者	1	1
151	852	病院	1	1
152	853	病気	1	1
153	854	薬（くすり）	1	1
154	855	死ぬ	1	1
155	856	風邪（かぜ）	1	1
156	857	頭（あたま）	1	1
157	858	お腹	1	1
158	859	度（ど）	1	1
159	860	エレベーター	1	1
160	861	切符	1	1
161	862	おりる	1	1
162	863	階段	1	1
163	864	閉める	1	1
164	865	駅	1	1
165	866	地下鉄	1	1
166	867	乗る	1	1
167	868	開ける	1	1
168	869	お手洗い	1	1
169	870	トイレ	1	1
170	871	電車	1	1
171	872	飲み物	1	1
172	873	コーヒー	1	1
173	874	喫茶店	1	1
174	875	レモン	1	1
175	876	牛乳	1	1
176	877	砂糖	1	1
177	878	カップ	1	1
178	879	お茶	1	1
179	880	紅茶	1	1
180	881	コップ	1	1
181	882	入れる	1	1
182	883	甘い	1	1
183	884	飲む	1	1
184	885	はし	1	1
185	886	酒	1	0
186	887	おいしい	1	1
187	888	ナイフ	1	1
188	889	スプーン	1	1
189	890	フォーク	1	1
190	891	チーズ	1	1
191	892	食べる	1	1
192	893	まずい	1	1
193	894	パン	1	1
194	895	辛い	1	1
195	896	レストラン	1	1
196	897	食堂	1	1
197	886	酒・ワイン	1	1
198	899	食べ物	1	1
199	900	カレー	1	1
200	901	お金	1	1
201	902	銀行	1	1
202	903	入り口	1	1
203	904	どうぞ,どういたしまして	1	1
204	905	いいえ	1	1
205	906	ええ	1	1
206	907	すみません	1	1
207	908	どうぞ	1	1
208	909	出口	1	1
209	910	着く	1	1
210	911	ポスト	1	1
211	912	はがき	1	1
212	913	貼る	1	1
213	914	封筒	1	1
214	915	手紙	1	1
215	916	郵便局	1	1
216	917	返す	1	1
217	918	出す	1	1
218	919	切手	1	1
219	920	荷物	1	1
220	921	枚	1	1
221	922	貸す	1	1
222	923	買う	1	1
223	924	帽子	1	1
224	925	靴	1	1
225	926	買い物	1	1
226	927	階	1	1
227	928	デパート	1	1
228	929	スカート	1	1
229	930	コート	1	1
230	931	ズボン	1	1
231	932	セーター	1	1
232	933	…てください	1	1
233	934	かばん	1	1
234	935	売る	1	1
235	936	上着	1	1
236	937	ふろ	1	1
237	938	建物	1	1
238	939	台所	1	1
239	940	シャワー	1	1
240	941	窓	1	1
241	942	住む	1	1
242	943	公園	1	1
243	944	ドア	1	1
244	945	浴びる［一風呂～］	1	1
245	946	アパート	1	1
246	947	玄関	1	1
247	948	彼，彼女	1	1
248	949	彼ら，彼女たち	1	1
249	950	私（わたし）	1	1
250	951	私たち	1	1
251	952	だれか	1	1
252	952	だれ	1	1
253	952	どなた	1	1
254	955	きみ	1	1
255	955	あなた	1	1
256	957	この	1	1
257	958	その，あの	1	1
258	959	いかが，どう	1	1
259	960	どの	1	1
260	961	どんな	1	1
261	962	こんな	1	1
262	963	自分	1	1
263	964	そう	1	1
264	965	厚い	1	1
265	966	狭い	1	1
266	967	細い	1	1
267	968	大きい	1	1
268	969	太い	1	1
269	970	若い	1	1
270	971	広い	1	1
271	972	軽い	1	1
272	973	遠い	1	1
273	974	重い	1	1
274	975	薄い	1	1
275	976	新しい	1	1
276	977	小さい	1	1
277	978	近い	1	1
278	979	古い	1	1
279	980	楽しい	1	1
280	981	にぎやか	1	1
281	982	低い	1	1
282	983	よい	1	1
283	984	明るい	1	1
284	985	弱い	1	1
285	986	強い	1	1
286	987	おもしろい	1	1
287	988	きれい	1	1
288	989	遅い	1	1
289	990	悪い	1	1
290	991	多い	1	1
291	992	暗い	1	1
292	993	静か	1	1
293	994	少ない	1	1
294	995	汚い	1	1
295	996	つまらない	1	1
296	997	横	1	1
297	998	中（なか）	1	1
298	999	外（そと）	1	1
299	1000	東（ひがし）	1	1
300	1001	高さ	1	1
301	1002	縦	1	1
302	1003	北（きた）	1	1
303	1004	西（にし）	1	1
304	1005	下（した）	1	1
305	1006	南（みなみ）	1	1
306	1007	上（うえ）	1	1
307	1008	先（さき）	1	1
308	1009	後（あと）	1	1
309	1010	いとこ	1	1
310	1011	兄	1	1
311	1012	兄弟（きょうだい）	1	1
312	1013	おばあさん	1	1
313	1014	おじいさん	1	1
314	1015	奥さん	1	1
315	1016	母	1	1
316	1017	叔父，伯父	1	1
317	1018	両親	1	1
318	1019	父	1	1
319	1020	姉	1	1
320	1021	姉妹	1	1
321	1022	叔母，伯母	1	1
322	1011	お兄さん	1	1
323	1020	お姉さん	1	1
324	1019	お父さん	1	1
325	1016	お母さん	1	1
326	1027	靴下	1	1
327	1028	シャツ	1	1
328	1029	脱ぐ	1	1
329	1030	架ける	1	1
330	1031	は（穿）く［ズボンを～］	1	1
331	1032	着る	1	1
332	1033	かぶる	1	1
333	1034	ハンカチ	1	1
334	1035	スリッパ	1	1
335	1036	傘	1	1
336	1037	ポケット	1	1
337	1038	財布	1	1
338	1039	着ている	1	1
339	1040	服	1	1
340	1040	洋服	1	1
341	1042	口	1	1
342	1043	腕（うで）	1	1
343	1044	体（からだ）	1	1
344	1045	顔	1	1
345	1046	脚（あし）	1	1
346	1047	手（て）	1	1
347	1048	鼻	1	1
348	1049	目（め）	1	1
349	1050	耳	1	1
350	1051	足（あし）	1	1
351	858	おなか	1	1
352	1053	皿（さら）	1	1
353	1054	バター	1	1
354	1055	茶わん	1	1
355	1056	あめ	1	1
356	1057	昼御飯	1	1
357	1058	夕飯（ゆうはん）	1	1
358	1059	お菓子	1	1
359	1060	卵	1	1
360	1061	朝御飯	1	1
361	1062	御飯（ごはん）	1	1
362	1063	醤油	1	1
363	1064	塩（しお）	1	1
364	1058	晩御飯	1	1
365	1066	くわえる	1	1
366	1067	つける	1	1
367	1068	カメラ	1	1
368	1069	ストーブ	1	1
369	1070	鉛筆	1	1
370	1071	消す	1	1
371	1072	眼鏡（めがね）	1	1
372	1073	テープレコーダー	1	1
373	1074	時計	1	1
374	1075	コンピュータ	1	1
375	1076	フィルム	1	1
376	944	戸（と）	1	1
377	1078	門（もん）	1	1
378	1079	ペン	1	1
379	1080	万年筆	1	1
380	1081	ボールペン	1	1
381	1082	八月	1	1
382	1083	四月	1	1
383	1084	今月	1	1
384	1085	毎月（まいつき）	1	1
385	1086	十二月	1	1
386	1087	二月	1	1
387	1088	一月	1	1
388	1089	七月	1	1
389	1090	六月	1	1
390	1091	来月	1	1
391	1092	五月	1	1
392	1093	三月	1	1
393	1094	先月	1	1
394	1095	十一月	1	1
395	1096	十月	1	1
396	1097	九月	1	1
397	1098	ひとつき	1	1
398	1099	今週	1	1
399	1100	毎週	1	1
400	1101	日曜日	1	1
401	1102	木曜日	1	1
402	1103	来週	1	1
403	1104	月曜日	1	1
404	1105	火曜日	1	1
405	1106	水曜日	1	1
406	1107	土曜日	1	1
407	1108	週間	1	1
408	1109	先週	1	1
409	1110	金曜日	1	1
410	1111	年（ねん）	1	1
411	1112	秋	1	1
412	1113	今年（ことし）	1	1
413	1114	毎年（まいとし）	1	1
414	1115	夏（なつ）	1	1
415	1116	冬	1	1
416	1117	去年	1	1
417	1118	来年	1	1
418	1119	春	1	1
419	1120	再来年	1	1
420	1121	おととし	1	1
421	1122	午後	1	1
422	1123	今日（きょう）	1	1
423	1124	明日（あした）	1	1
424	1125	時（じ）	1	1
425	1126	昨日（きのう）	1	1
426	1127	夕べ	1	1
427	1128	午前	1	1
428	1129	朝	1	1
429	1130	昼	1	1
430	1131	夜（よる）	1	1
431	1132	夕方	1	1
432	1133	あさって	1	1
433	1134	おととい	1	1
434	1135	もう	1	1
435	1136	ながら	1	1
436	1137	まだ	1	1
437	1138	中(ちゅう)	1	1
438	1139	時（とき）	1	1
439	1140	いつ	1	1
440	1141	ときどき	1	1
441	1142	しばしば	1	1
442	1143	時間	1	1
443	1144	すぐ	1	1
444	1145	灰皿	1	1
445	1146	歌（うた）	1	1
446	1147	歌う	1	1
447	1148	たばこ	1	1
448	1149	映画	1	1
449	1150	レコード	1	1
450	1151	ギター	1	1
451	1152	弾く	1	1
452	1153	音楽	1	1
453	1154	絵（え）	1	1
454	1155	写真	1	1
455	719	好き，気に入る	1	1
456	1157	声	1	1
457	1158	晴れ	1	1
458	1159	暑い	1	1
459	1160	晴れる	1	1
460	1161	涼しい	1	1
461	1162	寒い	1	1
462	1163	雪（ゆき）	1	1
463	1164	雨が降る	1	1
464	1165	雨（あめ）	1	1
465	1166	天気	1	1
466	1167	あたたかい（暖・温）	1	1
467	1168	風（かぜ）	1	1
468	1169	曇り	1	1
469	1170	冷たい	1	1
470	1171	曇る	1	1
471	1172	漢字	1	\N
472	1173	言う	1	1
473	1174	書く	1	1
474	1175	話（はなし）	1	1
475	1176	言葉	1	1
476	1176	～語	1	1
477	1176	語（ご）	1	1
478	1179	話す	1	1
479	1180	文章	1	1
480	1181	語る	1	1
481	1182	意味	1	1
482	1183	平仮名	1	\N
483	1184	片仮名	1	\N
484	1185	大人（おとな）	1	1
485	991	大勢	1	1
486	1187	夫婦	1	1
487	1188	子供	1	1
488	1015	妻	1	1
489	1190	女（おんな）	1	1
490	1191	男の子	1	1
491	1192	人（ひと）	1	1
492	1193	男（おとこ）	1	1
493	1194	女の子	1	1
494	1195	夫	1	1
495	1192	人	1	1
496	1197	みんな	1	1
497	1198	白（しろ），白い	1	1
498	1199	青，青い	1	1
499	1200	茶色	1	1
500	1201	明るい，淡い	1	1
501	1202	色（いろ）	1	1
502	992	濃い，暗い	1	1
503	1204	黄色（きいろ），黄色い	1	1
504	1205	黒（くろ），黒い	1	1
505	1206	赤，赤い	1	1
506	1207	緑	1	1
507	1208	便利	1	1
508	1209	パーティー	1	1
509	1210	紙	1	1
510	1211	～になる	1	1
511	1212	締める	1	1
512	1213	押す	1	1
513	1214	始まる	1	1
514	1215	ちょうど	1	1
515	1216	ない	1	1
516	1217	まっすぐ	1	1
517	1218	有名	1	1
518	981	元気	1	1
519	1220	じゃあ	1	1
520	1221	多分	1	1
521	908	では	1	1
522	410	フィリピノ語	1	1
523	1128	朝	1	1
524	817	後(あと)	1	1
525	1159	あたたかい（暖・温）	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
507	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
438	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
439	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
399	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
384	7865	1.1612	1.16	体	関係	時間	毎日・毎度	毎月（まいつき）	毎月	まいつき
413	7870	1.1612	1.16	体	関係	時間	毎日・毎度	毎年（まいとし）	毎年	まいとし
418	8361	1.1624	1.16	体	関係	時間	季節	春	春	はる
414	8375	1.1624	1.16	体	関係	時間	季節	夏（なつ）	夏	なつ
411	8389	1.1624	1.16	体	関係	時間	季節	秋	秋	あき
415	8403	1.1624	1.16	体	関係	時間	季節	冬	冬	ふゆ
391	8510	1.1631	1.16	体	関係	時間	月	五月（さつき）	五月	さつき
403	8555	1.1632	1.16	体	関係	時間	週・週日	月曜日	月曜日	げつようび
404	8556	1.1632	1.16	体	関係	時間	週・週日	火曜日	火曜日	かようび
405	8557	1.1632	1.16	体	関係	時間	週・週日	水曜日	水曜日	すいようび
401	8558	1.1632	1.16	体	関係	時間	週・週日	木曜日	木曜日	もくようび
409	8559	1.1632	1.16	体	関係	時間	週・週日	金曜日	金曜日	きんようび
406	8560	1.1632	1.16	体	関係	時間	週・週日	土曜日	土曜日	どようび
400	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
427	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
421	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
523	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
428	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
429	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
431	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
430	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
412	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
383	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
398	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
422	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
416	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
420	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
393	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
408	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
425	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
433	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
426	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
417	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
419	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
390	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
402	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
423	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
432	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
107	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
108	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
109	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
307	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
106	10765	1.173	1.17	体	関係	空間	方向・方角	こちら	こちら	こちら
299	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
303	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
305	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
302	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
119	10954	1.174	1.17	体	関係	空間	左右・前後・たてよこ	左（ひだり）	左	ひだり
118	10956	1.174	1.17	体	関係	空間	左右・前後・たてよこ	右（みぎ）	右	みぎ
117	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
116	10983	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後ろ	後ろ	うしろ
308	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
524	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
301	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
296	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
306	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
304	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
298	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
297	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
105	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
112	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
111	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
208	12247	1.183	1.18	体	関係	形	穴・口	出口	出口	でぐち
202	12249	1.183	1.18	体	関係	形	穴・口	入（い）り口	入り口	いりぐち
485	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
300	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
496	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
397	14623	1.196	1.19	体	関係	量	数記号（一二三）	ひとつき	ひとつき	ひとつき
64	14656	1.196	1.19	体	関係	量	数記号（一二三）	いくつ	いくつ	いくつ
65	14658	1.196	1.19	体	関係	量	数記号（一二三）	いくら	いくら	いくら
387	14674	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	一月	一月	いちがつ
386	14675	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	二月	二月	にがつ
392	14676	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	三月	三月	さんがつ
382	14677	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	四月	四月	しがつ
389	14679	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	六月	六月	ろくがつ
388	14680	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	七月	七月	しちがつ
381	14681	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	八月	八月	はちがつ
396	14682	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	九月	九月	くがつ
395	14683	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十月	十月	じゅうがつ
394	14684	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十一月	十一月	じゅういちがつ
385	14685	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十二月	十二月	じゅうにがつ
410	14871	1.1962	1.19	体	関係	量	助数接辞	年（ねん）	年	ねん
407	14890	1.1962	1.19	体	関係	量	助数接辞	週間	週間	しゅうかん
424	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
442	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
158	15048	1.1962	1.19	体	関係	量	助数接辞	度（ど）	度	ど
226	15092	1.1962	1.19	体	関係	量	助数接辞	階	階	かい
59	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
220	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
491	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
495	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
249	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
250	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
255	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
254	15527	1.201	1.20	体	主体	人間	われ・なれ・かれ	君（きみ）	君	きみ
247	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
248	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
252	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
253	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
251	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
262	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
492	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
490	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
489	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
493	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
487	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
484	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
313	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
312	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
80	16247	1.21	1.21	体	主体	家族	家族	家族	家族	かぞく
486	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
494	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
488	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
314	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
317	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
318	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
315	16496	1.212	1.21	体	主体	家族	親・先祖	母	母	はは
324	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
325	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
311	16780	1.214	1.21	体	主体	家族	兄弟	兄弟（きょうだい）	兄弟	きょうだい
310	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
322	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
319	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
320	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
323	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
316	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
321	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
309	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
123	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
5	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
133	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
150	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
103	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
102	20065	1.2417001	1.24	体	主体	成員	保安サービス	お巡りさん	お巡りさん	おまわりさん
130	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
128	20241	1.2419	1.24	体	主体	成員	学徒	生徒	生徒	せいと
131	20281	1.2419	1.24	体	主体	成員	学徒	留学生	留学生	りゅうがくせい
81	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
10	21338	1.253	1.25	体	主体	公私	国	国（くに）	国	くに
4	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
127	22471	1.263	1.26	体	主体	社会	社寺・学校	学校	学校	がっこう
125	22500	1.263	1.26	体	主体	社会	社寺・学校	教室	教室	きょうしつ
134	22517	1.263	1.26	体	主体	社会	社寺・学校	大学	大学	だいがく
42	22666	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	会社	会社	かいしゃ
201	22692	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	銀行	銀行	ぎんこう
164	22785	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	駅	駅	えき
29	22810	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	プール	プール	ぷうる
62	22828	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	店（みせ）	店	みせ
195	22888	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	レストラン	レストラン	れすとらん
196	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
173	22917	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	喫茶店	喫茶店	きっさてん
74	22952	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	八百屋	八百屋	やおや
227	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
7	23065	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	ホテル	ホテル	ほてる
151	23103	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	病院	病院	びょういん
50	23121	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	図書館	図書館	としょかん
242	23140	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	公園	公園	こうえん
110	23216	1.266	1.26	体	主体	社会	教室・兵営など	交番	交番	こうばん
16	23402	1.271	1.27	体	主体	機関	政府機関	大使館	大使館	たいしかん
215	23439	1.272	1.27	体	主体	機関	公共機関	郵便局	郵便局	ゆうびんきょく
124	23913	1.276	1.27	体	主体	機関	同盟・団体	クラス	クラス	くらす
456	25605	1.3031	1.30	体	活動	心	声	声	声	こえ
142	26691	1.3049999	1.30	体	活動	心	学習・習慣・記憶	練習	練習	れんしゅう
129	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
141	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
481	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
138	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
475	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
522	30514	1.3101	1.31	体	活動	言語	言語	言語	言語	げんご
476	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
477	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
8	30562	1.3101	1.31	体	活動	言語	言語	日本語	日本語	にほんご
2	30580	1.3101	1.31	体	活動	言語	言語	英語	英語	えいご
6	30586	1.3101	1.31	体	活動	言語	言語	フランス語	フランス語	ふらんすご
137	30813	1.3103	1.31	体	活動	言語	表現	作文	作文	さくぶん
471	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
482	31558	1.3113	1.31	体	活動	言語	文字	平仮名	平仮名	ひらがな
483	31559	1.3113	1.31	体	活動	言語	文字	片仮名	片仮名	かたかな
104	32060	1.3115	1.31	体	活動	言語	表・図・譜・式	地図	地図	ちず
214	32261	1.3122	1.31	体	活動	言語	通信	手紙	手紙	てがみ
211	32265	1.3122	1.31	体	活動	言語	通信	はがき	はがき	はがき
46	32370	1.3122	1.31	体	活動	言語	通信	電話	電話	でんわ
474	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
145	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
146	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
56	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
479	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
55	34173	1.316	1.31	体	活動	言語	文献・図書	本（ほん）	本	ほん
58	34482	1.316	1.31	体	活動	言語	文献・図書	雑誌	雑誌	ざっし
53	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
51	34541	1.316	1.31	体	活動	言語	文献・図書	辞書	辞書	じしょ
445	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
453	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
454	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
452	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
448	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
47	36429	1.332	1.33	体	活動	生活	労働・作業・休暇	仕事	仕事	しごと
132	36595	1.332	1.33	体	活動	生活	労働・作業・休暇	夏休み	夏休み	なつやすみ
12	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
361	36910	1.3331	1.33	体	活動	生活	食生活	御飯（ごはん）	御飯	ごはん
360	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
356	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
357	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
364	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
13	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
35	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
27	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
19	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
22	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
508	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
136	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
225	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
83	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
86	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
219	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
200	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
160	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
218	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
509	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
339	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
340	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
235	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
43	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
231	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
41	49847	1.4220001	1.42	体	生産物	衣料	上着・コート	ワイシャツ	ワイシャツ	わいしゃつ
229	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
230	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
228	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
327	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
336	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
223	50073	1.425	1.42	体	生産物	衣料	帽子・マスクなど	帽子	帽子	ぼうし
40	50149	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	ネクタイ	ネクタイ	ねくたい
326	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
224	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
334	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
335	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
94	50330	1.427	1.42	体	生産物	衣料	寝具	ベッド	ベッド	べっど
198	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
76	50577	1.431	1.43	体	生産物	食料	料理	料理	料理	りょうり
193	50788	1.431	1.43	体	生産物	食料	料理	パン	パン	ぱん
67	51101	1.432	1.43	体	生産物	食料	米・ぬか・小麦粉など	野菜	野菜	やさい
71	51286	1.4323	1.43	体	生産物	食料	魚・肉	肉	肉	にく
70	51294	1.4323	1.43	体	生産物	食料	魚・肉	鳥肉	鳥肉	とりにく
60	51299	1.4323	1.43	体	生産物	食料	魚・肉	牛肉	牛肉	ぎゅうにく
69	51303	1.4323	1.43	体	生産物	食料	魚・肉	豚肉	豚肉	ぶたにく
176	51376	1.433	1.43	体	生産物	食料	調味料・こうじなど	砂糖	砂糖	さとう
363	51398	1.433	1.43	体	生産物	食料	調味料・こうじなど	塩（しお）	塩	しお
362	51442	1.433	1.43	体	生産物	食料	調味料・こうじなど	醤油	醤油	しょうゆ
353	51476	1.433	1.43	体	生産物	食料	調味料・こうじなど	バター	バター	ばたあ
190	51478	1.433	1.43	体	生産物	食料	調味料・こうじなど	チーズ	チーズ	ちいず
199	51510	1.433	1.43	体	生産物	食料	調味料・こうじなど	カレー	カレー	かれえ
358	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
355	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
171	51732	1.4349999	1.43	体	生産物	食料	飲料・たばこ	飲み物	飲み物	のみもの
178	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
179	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
172	51777	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーヒー	コーヒー	こおひい
185	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
197	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
447	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
153	51929	1.436	1.43	体	生産物	食料	薬剤・薬品	薬（くすり）	薬	くすり
85	52391	1.4400001	1.44	体	生産物	住居	住居	家（いえ）	家	いえ
84	52392	1.4400001	1.44	体	生産物	住居	住居	うち（家）	うち	うち
237	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
377	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
91	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
245	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
246	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
238	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
169	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
168	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
126	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
162	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
240	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
88	53263	1.4450001	1.44	体	生産物	住居	棚・台・壇など	本棚	本棚	ほんだな
376	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
243	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
89	53456	1.447	1.44	体	生産物	住居	家具	机	机	つくえ
100	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
90	53482	1.447	1.44	体	生産物	住居	家具	椅子（いす）	椅子	いす
368	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
236	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
444	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
210	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
213	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
337	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
233	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
352	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
354	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
180	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
177	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
184	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
189	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
188	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
369	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
379	54238	1.4529999	1.45	体	生産物	道具	文具	万年筆	万年筆	まんねんひつ
380	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
378	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
75	54498	1.4541	1.45	体	生産物	道具	日用品	かぎ（鍵）	かぎ	かぎ
333	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
239	54653	1.4541	1.45	体	生産物	道具	日用品	シャワー	シャワー	しゃわあ
187	54781	1.455	1.45	体	生産物	道具	刃物	ナイフ	ナイフ	ないふ
450	55090	1.456	1.45	体	生産物	道具	楽器・レコードなど	ギター	ギター	ぎたあ
449	55164	1.456	1.45	体	生産物	道具	楽器・レコードなど	レコード	レコード	れこおど
135	55740	1.459	1.45	体	生産物	道具	札・帳など	ノート	ノート	のおと
371	55889	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	眼鏡（めがね）	眼鏡	めがね
367	55928	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	カメラ	カメラ	かめら
375	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
92	55970	1.462	1.46	体	生産物	機械	電気器具・部品	冷蔵庫	冷蔵庫	れいぞうこ
95	55992	1.462	1.46	体	生産物	機械	電気器具・部品	ラジオ	ラジオ	らじお
101	55994	1.462	1.46	体	生産物	機械	電気器具・部品	テレビ	テレビ	てれび
372	56004	1.462	1.46	体	生産物	機械	電気器具・部品	テープレコーダー	テープレコーダー	てえぷれこおだあ
374	56126	1.462	1.46	体	生産物	機械	電気器具・部品	コンピューター	コンピューター	こんぴゅうたあ
96	56144	1.462	1.46	体	生産物	機械	電気器具・部品	ラジカセ	ラジカセ	らじかせ
373	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
31	56482	1.465	1.46	体	生産物	機械	乗り物（陸上）	自転車	自転車	じてんしゃ
38	56506	1.465	1.46	体	生産物	機械	乗り物（陸上）	自動車	自動車	じどうしゃ
37	56572	1.465	1.46	体	生産物	機械	乗り物（陸上）	タクシー	タクシー	たくしい
30	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
170	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
165	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
159	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
3	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
82	57040	1.47	1.47	体	生産物	土地利用	地類（土地利用）	庭（にわ）	庭	にわ
33	57152	1.471	1.47	体	生産物	土地利用	道路・橋	道（みち）	道	みち
32	57316	1.471	1.47	体	生産物	土地利用	道路・橋	交差点	交差点	こうさてん
501	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
504	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
505	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
499	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
503	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
506	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
498	58059	1.502	1.50	体	自然	自然	色	青	青	あお
467	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
464	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
462	59878	1.5153	1.51	体	自然	物質	雨・雪	雪（ゆき）	雪	ゆき
465	59928	1.5154001	1.51	体	自然	物質	天気	天気	天気	てんき
457	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
468	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
36	60947	1.525	1.52	体	自然	天地	川・湖	かわ（川・河）	かわ	かわ
34	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
174	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
66	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
68	63577	1.5504	1.55	体	自然	動物	魚類	魚（さかな）	魚	さかな
343	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
156	64318	1.5601	1.56	体	自然	身体	頭・目鼻・顔	頭（あたま）	頭	あたま
344	64388	1.5601	1.56	体	自然	身体	頭・目鼻・顔	顔	顔	かお
348	64415	1.5601	1.56	体	自然	身体	頭・目鼻・顔	目（め）	目	め
347	64470	1.5601	1.56	体	自然	身体	頭・目鼻・顔	鼻	鼻	はな
349	64491	1.5601	1.56	体	自然	身体	頭・目鼻・顔	耳	耳	みみ
341	64505	1.5601	1.56	体	自然	身体	頭・目鼻・顔	口	口	くち
157	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
351	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
346	64713	1.5603	1.56	体	自然	身体	手足・指	手（て）	手	て
342	64741	1.5603	1.56	体	自然	身体	手足・指	腕	腕	うで
345	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
350	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
149	65338	1.5606	1.56	体	自然	身体	骨・歯・爪・角・甲	歯	歯	は
175	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
359	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
152	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
155	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
510	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
217	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
99	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
370	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
511	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
209	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
87	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
181	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
332	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
161	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
463	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
166	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
167	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
163	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
366	72782	2.1559999	2.15	用	関係	作用	接近・接触・隔離	付ける	付ける	つける
212	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
39	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
114	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
365	73997	2.158	2.15	用	関係	作用	増減・補充	加える	加える	くわえる
513	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
446	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
144	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
472	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
97	79593	2.3102	2.31	用	活動	言語	名	名のる	名のる	なのる
478	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
480	80001	2.3131001	2.31	用	活動	言語	話・談話	語る	語る	かたる
113	80087	2.3132	2.31	用	活動	言語	問答	きく（聞・聴）	きく	きく
147	80142	2.3132	2.31	用	活動	言語	問答	答える	答える	こたえる
54	80639	2.3150001	2.31	用	活動	言語	読み	読む	読む	よむ
473	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
57	80748	2.3151	2.31	用	活動	言語	書き	コピーする	コピーする	こぴいする
451	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
191	81700	2.3331001	2.33	用	活動	生活	食生活	食べる	食べる	たべる
331	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
338	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
330	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
328	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
241	81948	2.3333001	2.33	用	活動	生活	住生活	住む	住む	すむ
244	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
15	82317	2.3369999	2.33	用	活動	生活	遊楽	遊ぶ	遊ぶ	あそぶ
14	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
24	82483	2.3374	2.33	用	活動	生活	スポーツ	泳ぐ	泳ぐ	およぐ
122	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
98	82694	2.3390999	2.33	用	活動	生活	立ち居	寝る	寝る	ねる
121	82724	2.3390999	2.33	用	活動	生活	立ち居	座る	座る	すわる
183	83154	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	飲む	飲む	のむ
45	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
44	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
48	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
11	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
140	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
232	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
234	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
77	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
222	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
73	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
221	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
52	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
216	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
93	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
78	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
79	88631	2.3843	2.38	用	活動	事業	掃除など	掃除する	掃除する	そうじする
470	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
459	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
154	90096	2.5702	2.57	用	自然	生命	死	死ぬ	死ぬ	しぬ
256	90777	3.1010001	3.10	相	関係	真偽	こそあど・他	この	この	この
261	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
263	90799	3.1010001	3.10	相	関係	真偽	こそあど・他	そう	そう	そう
257	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
259	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
260	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
258	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
282	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
289	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
274	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
287	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
294	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
139	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
143	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
285	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
284	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
441	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
440	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
275	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
278	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
269	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
288	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
436	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
434	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
443	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
435	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
516	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
290	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
293	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
120	94000	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	長い	長い	ながい
115	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
63	94023	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	高い	高い	たかい
281	94030	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	低い	低い	ひくい
264	94048	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	厚い	厚い	あつい
272	94059	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	遠い	遠い	とおい
277	94068	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	近い	近い	ちかい
270	94080	3.1912	3.19	相	関係	量	広狭・大小	広い	広い	ひろい
265	94110	3.1912	3.19	相	関係	量	広狭・大小	狭い	狭い	せまい
268	94124	3.1912	3.19	相	関係	量	広狭・大小	太い	太い	ふとい
266	94125	3.1912	3.19	相	関係	量	広狭・大小	細い	細い	ほそい
267	94142	3.1912	3.19	相	関係	量	広狭・大小	大きい	大きい	おおきい
276	94186	3.1912	3.19	相	関係	量	広狭・大小	小さい	小さい	ちいさい
25	94225	3.1912999	3.19	相	関係	量	速度	速い［スピードが～］	速い	はやい
21	94288	3.1912999	3.19	相	関係	量	速度	ゆっくり	ゆっくり	ゆっくり
273	94318	3.1914001	3.19	相	関係	量	軽重	重い	重い	おもい
271	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
458	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
460	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
461	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
437	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
148	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
279	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
286	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
295	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
18	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
455	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
17	95587	3.302	3.30	相	活動	心	好悪・愛憎	大好き	大好き	だいすき
28	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
72	96159	3.3041999	3.30	相	活動	心	欲望・期待・失望	欲しい	欲しい	ほしい
517	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
49	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
61	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
283	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
500	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
291	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
497	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
292	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
280	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
186	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
192	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
182	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
194	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
502	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
469	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
525	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
466	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
519	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
206	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
207	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	443	71	0	\N	\N	\N	\N
2	249	13	0	\N	\N	\N	\N
4	424	185	0	\N	\N	\N	\N
5	259	241	0	\N	\N	\N	\N
6	43	353	0	\N	\N	\N	\N
7	260	19	0	\N	\N	\N	\N
8	260	80	0	\N	\N	\N	\N
9	494	427	0	\N	\N	\N	\N
10	363	200	0	\N	\N	\N	\N
11	319	32	0	\N	\N	\N	\N
13	323	325	0	\N	\N	\N	\N
14	28	255	0	\N	\N	\N	\N
16	459	291	0	\N	\N	\N	\N
17	203	69	0	\N	\N	\N	\N
18	489	193	0	\N	\N	\N	\N
19	275	239	0	\N	\N	\N	\N
20	84	226	0	\N	\N	\N	\N
21	520	129	0	\N	\N	\N	\N
22	12	175	0	\N	\N	\N	\N
23	10	49	0	\N	\N	\N	\N
26	269	97	0	\N	\N	\N	\N
27	487	1	0	\N	\N	\N	\N
28	487	28	0	\N	\N	\N	\N
29	423	50	0	\N	\N	\N	\N
30	216	321	0	\N	\N	\N	\N
31	69	199	0	\N	\N	\N	\N
32	25	338	0	\N	\N	\N	\N
33	282	73	0	\N	\N	\N	\N
34	282	76	0	\N	\N	\N	\N
35	390	351	0	\N	\N	\N	\N
36	106	52	0	\N	\N	\N	\N
37	106	160	0	\N	\N	\N	\N
38	108	165	0	\N	\N	\N	\N
39	209	38	0	\N	\N	\N	\N
40	143	210	0	\N	\N	\N	\N
41	290	53	0	\N	\N	\N	\N
42	290	407	0	\N	\N	\N	\N
43	294	290	0	\N	\N	\N	\N
44	130	2	0	\N	\N	\N	\N
45	430	127	0	\N	\N	\N	\N
46	153	48	0	\N	\N	\N	\N
47	261	173	0	\N	\N	\N	\N
48	44	163	0	\N	\N	\N	\N
49	67	259	0	\N	\N	\N	\N
50	18	257	0	\N	\N	\N	\N
51	287	37	0	\N	\N	\N	\N
52	287	440	0	\N	\N	\N	\N
53	114	243	0	\N	\N	\N	\N
54	421	183	0	\N	\N	\N	\N
55	117	381	0	\N	\N	\N	\N
56	204	306	0	\N	\N	\N	\N
57	401	183	0	\N	\N	\N	\N
58	120	249	0	\N	\N	\N	\N
59	139	417	0	\N	\N	\N	\N
60	19	223	0	\N	\N	\N	\N
61	306	233	0	\N	\N	\N	\N
62	254	213	0	\N	\N	\N	\N
63	255	117	0	\N	\N	\N	\N
64	64	144	0	\N	\N	\N	\N
65	36	51	0	\N	\N	\N	\N
66	2	220	0	\N	\N	\N	\N
67	68	311	0	\N	\N	\N	\N
68	115	248	0	\N	\N	\N	\N
69	458	160	0	\N	\N	\N	\N
70	425	308	0	\N	\N	\N	\N
71	250	191	0	\N	\N	\N	\N
72	250	431	0	\N	\N	\N	\N
73	311	186	0	\N	\N	\N	\N
74	71	199	0	\N	\N	\N	\N
75	124	306	0	\N	\N	\N	\N
76	136	180	0	\N	\N	\N	\N
77	136	302	0	\N	\N	\N	\N
78	191	252	0	\N	\N	\N	\N
79	191	333	0	\N	\N	\N	\N
80	446	17	0	\N	\N	\N	\N
81	91	28	0	\N	\N	\N	\N
82	11	185	0	\N	\N	\N	\N
83	181	203	0	\N	\N	\N	\N
84	298	230	0	\N	\N	\N	\N
86	492	193	0	\N	\N	\N	\N
87	492	327	0	\N	\N	\N	\N
88	400	402	0	\N	\N	\N	\N
89	407	362	0	\N	\N	\N	\N
90	312	292	0	\N	\N	\N	\N
91	313	382	0	\N	\N	\N	\N
92	9	288	0	\N	\N	\N	\N
93	24	86	0	\N	\N	\N	\N
94	403	183	0	\N	\N	\N	\N
95	23	334	0	\N	\N	\N	\N
96	15	386	0	\N	\N	\N	\N
97	267	296	0	\N	\N	\N	\N
98	272	172	0	\N	\N	\N	\N
99	398	318	0	\N	\N	\N	\N
100	402	324	0	\N	\N	\N	\N
101	510	349	0	\N	\N	\N	\N
102	65	319	0	\N	\N	\N	\N
103	63	35	0	\N	\N	\N	\N
104	63	140	0	\N	\N	\N	\N
105	61	142	0	\N	\N	\N	\N
106	434	127	0	\N	\N	\N	\N
107	434	446	0	\N	\N	\N	\N
108	315	398	0	\N	\N	\N	\N
109	325	238	0	\N	\N	\N	\N
110	256	272	0	\N	\N	\N	\N
111	205	77	0	\N	\N	\N	\N
112	205	87	0	\N	\N	\N	\N
113	442	170	0	\N	\N	\N	\N
114	154	49	0	\N	\N	\N	\N
115	436	128	0	\N	\N	\N	\N
116	350	152	0	\N	\N	\N	\N
117	258	197	0	\N	\N	\N	\N
118	198	315	0	\N	\N	\N	\N
119	232	136	0	\N	\N	\N	\N
120	309	280	0	\N	\N	\N	\N
121	337	232	0	\N	\N	\N	\N
122	1	159	0	\N	\N	\N	\N
123	497	54	0	\N	\N	\N	\N
124	186	19	0	\N	\N	\N	\N
125	186	29	0	\N	\N	\N	\N
126	279	176	0	\N	\N	\N	\N
127	265	340	0	\N	\N	\N	\N
128	109	60	0	\N	\N	\N	\N
129	109	372	0	\N	\N	\N	\N
130	224	394	0	\N	\N	\N	\N
131	97	448	0	\N	\N	\N	\N
132	521	137	0	\N	\N	\N	\N
133	248	3	0	\N	\N	\N	\N
134	248	228	0	\N	\N	\N	\N
135	448	264	0	\N	\N	\N	\N
136	253	92	0	\N	\N	\N	\N
137	247	305	0	\N	\N	\N	\N
138	166	335	0	\N	\N	\N	\N
139	268	267	0	\N	\N	\N	\N
140	182	7	0	\N	\N	\N	\N
141	98	420	0	\N	\N	\N	\N
142	416	149	0	\N	\N	\N	\N
143	491	230	0	\N	\N	\N	\N
144	324	238	0	\N	\N	\N	\N
145	413	304	0	\N	\N	\N	\N
146	321	331	0	\N	\N	\N	\N
147	133	33	0	\N	\N	\N	\N
148	157	309	0	\N	\N	\N	\N
149	47	132	0	\N	\N	\N	\N
150	241	85	0	\N	\N	\N	\N
151	464	286	0	\N	\N	\N	\N
152	427	183	0	\N	\N	\N	\N
153	87	130	0	\N	\N	\N	\N
154	515	323	0	\N	\N	\N	\N
155	515	424	0	\N	\N	\N	\N
156	475	219	0	\N	\N	\N	\N
157	252	17	0	\N	\N	\N	\N
159	382	451	1	\N	\N	\N	\N
160	381	452	1	\N	\N	\N	\N
161	50	453	1	\N	\N	\N	\N
162	185	454	1	\N	\N	\N	\N
163	360	455	1	\N	\N	\N	\N
164	245	456	1	\N	\N	\N	\N
166	368	458	1	\N	\N	\N	\N
167	314	459	1	\N	\N	\N	\N
168	488	460	1	\N	\N	\N	\N
169	176	461	1	\N	\N	\N	\N
171	498	463	1	\N	\N	\N	\N
172	194	464	1	\N	\N	\N	\N
173	73	465	1	\N	\N	\N	\N
174	457	466	1	\N	\N	\N	\N
175	486	467	1	\N	\N	\N	\N
176	129	468	1	\N	\N	\N	\N
177	233	469	1	\N	\N	\N	\N
178	304	470	1	\N	\N	\N	\N
179	219	471	1	\N	\N	\N	\N
180	132	472	1	\N	\N	\N	\N
181	201	473	1	\N	\N	\N	\N
182	236	474	1	\N	\N	\N	\N
183	180	475	1	\N	\N	\N	\N
184	493	476	1	\N	\N	\N	\N
185	490	477	1	\N	\N	\N	\N
186	353	478	1	\N	\N	\N	\N
187	506	479	1	\N	\N	\N	\N
188	240	480	1	\N	\N	\N	\N
189	345	481	1	\N	\N	\N	\N
190	49	482	1	\N	\N	\N	\N
191	342	483	1	\N	\N	\N	\N
192	31	484	1	\N	\N	\N	\N
193	409	485	1	\N	\N	\N	\N
194	380	486	1	\N	\N	\N	\N
195	88	487	1	\N	\N	\N	\N
196	456	488	1	\N	\N	\N	\N
197	167	489	1	\N	\N	\N	\N
198	336	490	1	\N	\N	\N	\N
199	161	491	1	\N	\N	\N	\N
200	222	492	1	\N	\N	\N	\N
201	341	493	1	\N	\N	\N	\N
202	370	494	1	\N	\N	\N	\N
203	30	495	1	\N	\N	\N	\N
204	210	496	1	\N	\N	\N	\N
205	384	497	1	\N	\N	\N	\N
206	184	498	1	\N	\N	\N	\N
207	173	499	1	\N	\N	\N	\N
208	169	500	1	\N	\N	\N	\N
209	199	501	1	\N	\N	\N	\N
210	33	502	1	\N	\N	\N	\N
211	21	503	1	\N	\N	\N	\N
212	339	504	1	\N	\N	\N	\N
213	340	504	0	\N	\N	\N	\N
214	197	454	0	\N	\N	\N	\N
215	431	505	1	\N	\N	\N	\N
216	5	506	1	\N	\N	\N	\N
217	131	507	1	\N	\N	\N	\N
218	227	508	1	\N	\N	\N	\N
219	51	509	1	\N	\N	\N	\N
220	503	510	1	\N	\N	\N	\N
221	385	511	1	\N	\N	\N	\N
222	107	512	1	\N	\N	\N	\N
223	150	513	1	\N	\N	\N	\N
224	53	514	1	\N	\N	\N	\N
225	514	515	1	\N	\N	\N	\N
226	141	516	1	\N	\N	\N	\N
227	159	517	1	\N	\N	\N	\N
228	16	518	1	\N	\N	\N	\N
229	3	519	1	\N	\N	\N	\N
230	387	519	0	\N	\N	\N	\N
231	127	520	1	\N	\N	\N	\N
232	128	521	1	\N	\N	\N	\N
233	206	522	1	\N	\N	\N	\N
234	375	523	1	\N	\N	\N	\N
235	379	524	1	\N	\N	\N	\N
236	378	525	1	\N	\N	\N	\N
237	327	526	1	\N	\N	\N	\N
238	6	527	1	\N	\N	\N	\N
239	263	528	1	\N	\N	\N	\N
240	175	529	1	\N	\N	\N	\N
241	450	530	1	\N	\N	\N	\N
242	99	531	1	\N	\N	\N	\N
243	237	532	1	\N	\N	\N	\N
244	72	533	1	\N	\N	\N	\N
245	455	257	0	\N	\N	\N	\N
246	17	534	1	\N	\N	\N	\N
248	435	536	1	\N	\N	\N	\N
249	162	537	1	\N	\N	\N	\N
250	82	538	1	\N	\N	\N	\N
251	467	539	1	\N	\N	\N	\N
252	8	540	1	\N	\N	\N	\N
253	357	541	1	\N	\N	\N	\N
254	364	541	0	\N	\N	\N	\N
255	307	542	1	\N	\N	\N	\N
256	511	543	1	\N	\N	\N	\N
257	302	544	1	\N	\N	\N	\N
258	22	545	1	\N	\N	\N	\N
259	192	546	1	\N	\N	\N	\N
260	138	547	1	\N	\N	\N	\N
261	388	548	1	\N	\N	\N	\N
262	52	549	1	\N	\N	\N	\N
263	389	550	1	\N	\N	\N	\N
264	4	551	1	\N	\N	\N	\N
265	234	552	1	\N	\N	\N	\N
266	365	553	1	\N	\N	\N	\N
267	212	554	1	\N	\N	\N	\N
268	217	555	1	\N	\N	\N	\N
269	366	556	1	\N	\N	\N	\N
270	270	557	1	\N	\N	\N	\N
271	347	558	1	\N	\N	\N	\N
272	171	559	1	\N	\N	\N	\N
273	221	560	1	\N	\N	\N	\N
274	329	561	1	\N	\N	\N	\N
275	397	562	1	\N	\N	\N	\N
276	163	563	1	\N	\N	\N	\N
277	27	564	1	\N	\N	\N	\N
278	218	565	1	\N	\N	\N	\N
279	110	566	1	\N	\N	\N	\N
280	164	567	1	\N	\N	\N	\N
281	330	568	1	\N	\N	\N	\N
282	332	569	1	\N	\N	\N	\N
283	504	570	1	\N	\N	\N	\N
284	359	571	1	\N	\N	\N	\N
285	383	572	1	\N	\N	\N	\N
286	235	573	1	\N	\N	\N	\N
287	426	574	1	\N	\N	\N	\N
288	481	575	1	\N	\N	\N	\N
289	123	576	1	\N	\N	\N	\N
290	439	577	1	\N	\N	\N	\N
291	293	578	1	\N	\N	\N	\N
292	111	579	1	\N	\N	\N	\N
293	119	580	1	\N	\N	\N	\N
294	94	581	1	\N	\N	\N	\N
295	433	582	1	\N	\N	\N	\N
296	346	543	0	\N	\N	\N	\N
297	367	583	1	\N	\N	\N	\N
298	41	584	1	\N	\N	\N	\N
299	118	580	0	\N	\N	\N	\N
300	361	585	1	\N	\N	\N	\N
301	303	586	1	\N	\N	\N	\N
302	445	534	0	\N	\N	\N	\N
303	196	587	1	\N	\N	\N	\N
304	320	588	1	\N	\N	\N	\N
305	172	461	0	\N	\N	\N	\N
306	60	589	1	\N	\N	\N	\N
307	112	590	1	\N	\N	\N	\N
308	146	592	1	\N	\N	\N	\N
309	343	593	1	\N	\N	\N	\N
310	355	594	1	\N	\N	\N	\N
311	190	595	1	\N	\N	\N	\N
312	125	596	1	\N	\N	\N	\N
313	507	597	1	\N	\N	\N	\N
314	137	598	1	\N	\N	\N	\N
315	374	597	0	\N	\N	\N	\N
316	56	599	1	\N	\N	\N	\N
317	57	600	1	\N	\N	\N	\N
318	126	601	1	\N	\N	\N	\N
319	38	533	0	\N	\N	\N	\N
320	32	602	1	\N	\N	\N	\N
321	501	510	0	\N	\N	\N	\N
322	499	603	1	\N	\N	\N	\N
323	42	604	1	\N	\N	\N	\N
324	519	605	1	\N	\N	\N	\N
325	40	606	1	\N	\N	\N	\N
326	238	475	0	\N	\N	\N	\N
327	188	607	1	\N	\N	\N	\N
328	187	608	1	\N	\N	\N	\N
329	135	609	1	\N	\N	\N	\N
331	322	610	0	\N	\N	\N	\N
332	310	611	1	\N	\N	\N	\N
333	208	612	1	\N	\N	\N	\N
335	496	613	1	\N	\N	\N	\N
336	296	614	1	\N	\N	\N	\N
337	301	615	1	\N	\N	\N	\N
338	369	616	1	\N	\N	\N	\N
339	453	617	1	\N	\N	\N	\N
340	34	618	1	\N	\N	\N	\N
341	174	619	1	\N	\N	\N	\N
342	454	620	1	\N	\N	\N	\N
343	55	560	0	\N	\N	\N	\N
344	116	621	1	\N	\N	\N	\N
345	308	622	1	\N	\N	\N	\N
346	399	623	1	\N	\N	\N	\N
347	297	624	1	\N	\N	\N	\N
348	278	625	1	\N	\N	\N	\N
349	39	626	1	\N	\N	\N	\N
350	26	627	1	\N	\N	\N	\N
352	76	628	1	\N	\N	\N	\N
353	281	629	1	\N	\N	\N	\N
354	288	630	1	\N	\N	\N	\N
355	273	631	1	\N	\N	\N	\N
356	441	632	1	\N	\N	\N	\N
357	291	633	1	\N	\N	\N	\N
358	502	634	1	\N	\N	\N	\N
359	271	635	1	\N	\N	\N	\N
360	58	636	1	\N	\N	\N	\N
361	54	637	1	\N	\N	\N	\N
362	144	638	1	\N	\N	\N	\N
363	328	639	1	\N	\N	\N	\N
364	93	640	1	\N	\N	\N	\N
365	470	641	1	\N	\N	\N	\N
366	480	642	1	\N	\N	\N	\N
367	78	643	1	\N	\N	\N	\N
368	14	644	1	\N	\N	\N	\N
370	79	645	1	\N	\N	\N	\N
371	472	646	1	\N	\N	\N	\N
372	478	647	1	\N	\N	\N	\N
373	513	648	1	\N	\N	\N	\N
374	331	649	1	\N	\N	\N	\N
375	48	650	1	\N	\N	\N	\N
376	512	651	1	\N	\N	\N	\N
377	140	652	1	\N	\N	\N	\N
378	317	653	1	\N	\N	\N	\N
379	284	654	1	\N	\N	\N	\N
380	466	655	1	\N	\N	\N	\N
381	264	656	1	\N	\N	\N	\N
382	113	657	1	\N	\N	\N	\N
383	285	658	1	\N	\N	\N	\N
384	461	659	1	\N	\N	\N	\N
385	469	660	1	\N	\N	\N	\N
386	277	661	1	\N	\N	\N	\N
387	244	662	1	\N	\N	\N	\N
388	276	663	1	\N	\N	\N	\N
389	283	664	1	\N	\N	\N	\N
391	77	666	1	\N	\N	\N	\N
392	354	667	1	\N	\N	\N	\N
393	45	668	1	\N	\N	\N	\N
394	274	669	1	\N	\N	\N	\N
395	104	670	1	\N	\N	\N	\N
396	485	671	1	\N	\N	\N	\N
397	392	672	1	\N	\N	\N	\N
399	404	674	1	\N	\N	\N	\N
400	148	675	1	\N	\N	\N	\N
401	289	676	1	\N	\N	\N	\N
402	518	677	1	\N	\N	\N	\N
403	280	678	1	\N	\N	\N	\N
404	348	679	1	\N	\N	\N	\N
405	484	680	1	\N	\N	\N	\N
406	468	681	1	\N	\N	\N	\N
407	391	682	1	\N	\N	\N	\N
408	326	683	1	\N	\N	\N	\N
409	89	684	1	\N	\N	\N	\N
410	83	685	1	\N	\N	\N	\N
411	13	686	1	\N	\N	\N	\N
412	86	687	1	\N	\N	\N	\N
413	474	688	1	\N	\N	\N	\N
414	226	689	1	\N	\N	\N	\N
415	35	690	1	\N	\N	\N	\N
416	80	691	1	\N	\N	\N	\N
417	225	692	1	\N	\N	\N	\N
418	440	693	1	\N	\N	\N	\N
419	465	694	1	\N	\N	\N	\N
420	479	695	1	\N	\N	\N	\N
421	229	696	1	\N	\N	\N	\N
422	230	697	1	\N	\N	\N	\N
423	333	698	1	\N	\N	\N	\N
424	509	699	1	\N	\N	\N	\N
425	228	700	1	\N	\N	\N	\N
426	242	701	1	\N	\N	\N	\N
427	508	702	1	\N	\N	\N	\N
428	202	703	1	\N	\N	\N	\N
429	335	704	1	\N	\N	\N	\N
430	386	705	1	\N	\N	\N	\N
431	200	706	1	\N	\N	\N	\N
433	243	708	1	\N	\N	\N	\N
434	376	709	1	\N	\N	\N	\N
435	246	710	1	\N	\N	\N	\N
436	220	711	1	\N	\N	\N	\N
437	352	712	1	\N	\N	\N	\N
438	215	713	1	\N	\N	\N	\N
439	211	714	1	\N	\N	\N	\N
440	460	715	1	\N	\N	\N	\N
441	66	716	1	\N	\N	\N	\N
442	505	717	1	\N	\N	\N	\N
443	103	718	1	\N	\N	\N	\N
444	102	719	1	\N	\N	\N	\N
445	95	720	1	\N	\N	\N	\N
446	96	721	1	\N	\N	\N	\N
447	449	722	1	\N	\N	\N	\N
448	373	723	1	\N	\N	\N	\N
449	92	724	1	\N	\N	\N	\N
450	195	725	1	\N	\N	\N	\N
451	437	726	1	\N	\N	\N	\N
452	419	727	1	\N	\N	\N	\N
453	417	728	1	\N	\N	\N	\N
454	406	729	1	\N	\N	\N	\N
455	152	730	1	\N	\N	\N	\N
456	371	731	1	\N	\N	\N	\N
457	432	732	1	\N	\N	\N	\N
458	262	733	1	\N	\N	\N	\N
459	396	734	1	\N	\N	\N	\N
460	239	735	1	\N	\N	\N	\N
461	447	736	1	\N	\N	\N	\N
462	207	737	1	\N	\N	\N	\N
463	517	738	1	\N	\N	\N	\N
464	299	739	1	\N	\N	\N	\N
465	251	740	1	\N	\N	\N	\N
466	155	742	1	\N	\N	\N	\N
467	213	743	1	\N	\N	\N	\N
468	165	744	1	\N	\N	\N	\N
469	214	745	1	\N	\N	\N	\N
470	147	746	1	\N	\N	\N	\N
471	223	747	1	\N	\N	\N	\N
472	473	748	1	\N	\N	\N	\N
473	75	749	1	\N	\N	\N	\N
474	231	750	1	\N	\N	\N	\N
475	29	751	1	\N	\N	\N	\N
476	300	752	1	\N	\N	\N	\N
477	105	753	1	\N	\N	\N	\N
478	414	754	1	\N	\N	\N	\N
479	411	755	1	\N	\N	\N	\N
480	415	756	1	\N	\N	\N	\N
481	418	757	1	\N	\N	\N	\N
482	81	758	1	\N	\N	\N	\N
483	85	162	0	\N	\N	\N	\N
484	292	759	1	\N	\N	\N	\N
485	37	760	1	\N	\N	\N	\N
486	429	531	0	\N	\N	\N	\N
487	356	761	1	\N	\N	\N	\N
488	145	762	1	\N	\N	\N	\N
489	495	763	1	\N	\N	\N	\N
490	410	562	0	\N	\N	\N	\N
491	372	764	1	\N	\N	\N	\N
492	177	765	1	\N	\N	\N	\N
493	318	766	1	\N	\N	\N	\N
494	101	767	1	\N	\N	\N	\N
495	46	768	1	\N	\N	\N	\N
496	349	769	1	\N	\N	\N	\N
497	160	770	1	\N	\N	\N	\N
498	305	627	0	\N	\N	\N	\N
499	193	478	0	\N	\N	\N	\N
500	62	736	0	\N	\N	\N	\N
501	74	771	1	\N	\N	\N	\N
502	189	772	1	\N	\N	\N	\N
503	444	773	1	\N	\N	\N	\N
504	316	774	1	\N	\N	\N	\N
505	351	775	1	\N	\N	\N	\N
506	362	776	1	\N	\N	\N	\N
507	377	777	1	\N	\N	\N	\N
508	170	612	0	\N	\N	\N	\N
509	178	778	1	\N	\N	\N	\N
510	179	779	1	\N	\N	\N	\N
511	334	780	1	\N	\N	\N	\N
512	20	781	1	\N	\N	\N	\N
513	122	782	1	\N	\N	\N	\N
514	451	783	1	\N	\N	\N	\N
515	516	784	1	\N	\N	\N	\N
516	156	785	1	\N	\N	\N	\N
517	428	786	1	\N	\N	\N	\N
518	183	787	1	\N	\N	\N	\N
519	463	788	1	\N	\N	\N	\N
520	121	789	1	\N	\N	\N	\N
521	134	790	1	\N	\N	\N	\N
522	90	791	1	\N	\N	\N	\N
523	295	792	1	\N	\N	\N	\N
524	477	527	0	\N	\N	\N	\N
525	476	647	0	\N	\N	\N	\N
526	142	793	1	\N	\N	\N	\N
527	158	794	1	\N	\N	\N	\N
528	266	795	1	\N	\N	\N	\N
529	522	796	1	\N	\N	\N	\N
530	7	797	1	\N	\N	\N	\N
531	70	798	1	\N	\N	\N	\N
532	100	799	1	\N	\N	\N	\N
533	149	800	1	\N	\N	\N	\N
534	151	801	1	\N	\N	\N	\N
535	286	802	1	\N	\N	\N	\N
536	338	803	1	\N	\N	\N	\N
537	344	515	0	\N	\N	\N	\N
538	358	804	1	\N	\N	\N	\N
539	393	805	1	\N	\N	\N	\N
540	394	806	1	\N	\N	\N	\N
541	395	807	1	\N	\N	\N	\N
542	405	808	1	\N	\N	\N	\N
543	408	809	1	\N	\N	\N	\N
544	412	810	1	\N	\N	\N	\N
545	420	811	1	\N	\N	\N	\N
546	422	130	0	\N	\N	\N	\N
547	422	681	0	\N	\N	\N	\N
548	452	812	1	\N	\N	\N	\N
549	462	813	1	\N	\N	\N	\N
550	257	814	1	\N	\N	\N	\N
551	438	815	1	\N	\N	\N	\N
552	500	816	1	\N	\N	\N	\N
553	523	786	0	\N	\N	\N	\N
554	524	622	0	\N	\N	\N	\N
555	525	655	0	\N	\N	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: tl
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
522	1
523	33
524	24
525	36
455	2
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
15	palengke	\N	\N	\N
16	ka	\N	\N	\N
17	naman	\N	\N	\N
18	pumunta	\N	\N	\N
19	bihis	\N	\N	\N
20	na	\N	\N	\N
21	ah	\N	\N	\N
22	may	\N	\N	\N
23	lakad	\N	\N	\N
24	mag-ingat	\N	\N	\N
25	ha	\N	\N	\N
26	ikumusta	\N	\N	\N
27	ninyo	\N	\N	\N
28	kay	\N	\N	\N
29	salamat	\N	\N	\N
30	ang	\N	\N	\N
31	sarap	\N	\N	\N
32	magustuhan	\N	\N	\N
33	mo	\N	\N	\N
34	oo	\N	\N	\N
35	maubos	\N	\N	\N
36	nga	\N	\N	\N
37	agad	\N	\N	\N
38	eh	\N	\N	\N
39	kumusta	\N	\N	\N
40	mabuti	\N	\N	\N
41	marami	\N	\N	\N
42	din	\N	\N	\N
43	tulong	\N	\N	\N
44	paper	\N	\N	\N
45	ko	\N	\N	\N
46	iyon	\N	\N	\N
47	magpasalamat	\N	\N	\N
48	siya	\N	\N	\N
49	mag-type	\N	\N	\N
50	ng	\N	\N	\N
51	tingnan	\N	\N	\N
52	o	\N	\N	\N
53	ano	\N	\N	\N
54	laki	\N	\N	\N
55	isda	\N	\N	\N
56	ay	\N	\N	\N
57	hindi	\N	\N	\N
58	dugong	\N	\N	\N
59	isa	\N	\N	\N
60	mammal	\N	\N	\N
61	nakatira	\N	\N	\N
62	dagat	\N	\N	\N
63	at	\N	\N	\N
64	parang	\N	\N	\N
65	baka	\N	\N	\N
66	lumangoy	\N	\N	\N
67	suwerte	\N	\N	\N
68	tayo	\N	\N	\N
69	dahil	\N	\N	\N
70	bihira	\N	\N	\N
71	ito	\N	\N	\N
72	makita	\N	\N	\N
73	kung	\N	\N	\N
74	gusto	\N	\N	\N
75	natin	\N	\N	\N
76	encyclopedia	\N	\N	\N
77	 nariyan	\N	\N	\N
78	 po	\N	\N	\N
79	 ba	\N	\N	\N
80	 si 	\N	\N	\N
81	 ako 	\N	\N	\N
82	 ang 	\N	\N	\N
83	 kaklase 	\N	\N	\N
84	 ni 	\N	\N	\N
85	 ho 	\N	\N	\N
86	 ate 	\N	\N	\N
87	 ako	\N	\N	\N
88	 nanay	\N	\N	\N
89	 niya	\N	\N	\N
90	 napakabata 	\N	\N	\N
91	 naman 	\N	\N	\N
92	 ninyo 	\N	\N	\N
93	 parang 	\N	\N	\N
94	 lang 	\N	\N	\N
95	 kayo 	\N	\N	\N
96	 salamat 	\N	\N	\N
97	 tuloy 	\N	\N	\N
98	 ka 	\N	\N	\N
99	 at 	\N	\N	\N
100	 tawagin 	\N	\N	\N
101	 ko 	\N	\N	\N
102	 helo 	\N	\N	\N
103	 puwede 	\N	\N	\N
104	 ba 	\N	\N	\N
105	 -ng 	\N	\N	\N
106	 makausap 	\N	\N	\N
107	\n\t\t\t\t\t\t\t	\N	\N	\N
108	 ito 	\N	\N	\N
109	 hindi 	\N	\N	\N
110	 makarating 	\N	\N	\N
111	 mo 	\N	\N	\N
112	 kahapon 	\N	\N	\N
113	 iyon 	\N	\N	\N
114	 kasi 	\N	\N	\N
115	 lagnatin 	\N	\N	\N
116	 sayang 	\N	\N	\N
117	 napakasaya 	\N	\N	\N
118	 namin 	\N	\N	\N
119	 kumusta 	\N	\N	\N
120	 na 	\N	\N	\N
121	 ngayon 	\N	\N	\N
122	 medyo 	\N	\N	\N
123	 magaling 	\N	\N	\N
124	pero	\N	\N	\N
125	ubuhin	\N	\N	\N
126	pa	\N	\N	\N
127	rin	\N	\N	\N
128	talaga	\N	\N	\N
129	eto	\N	\N	\N
130	 pala 	\N	\N	\N
131	 tsokolate 	\N	\N	\N
132	 naman	\N	\N	\N
133	 bertdey 	\N	\N	\N
134	kasi	\N	\N	\N
135	 bakit 	\N	\N	\N
136	 magregalo 	\N	\N	\N
137	 ganyan 	\N	\N	\N
138	Japan	\N	\N	\N
139	naku	\N	\N	\N
140	ganyan	\N	\N	\N
141	dito	\N	\N	\N
142	 Pilipinas 	\N	\N	\N
143	mga	\N	\N	\N
144	babae	\N	\N	\N
145	rito	\N	\N	\N
146	 regaluhan 	\N	\N	\N
147	ganoon	\N	\N	\N
148	ba	\N	\N	\N
149	nakakahiya	\N	\N	\N
150	 unahan 	\N	\N	\N
151	regalo	\N	\N	\N
152	rosas	\N	\N	\N
153	sana	\N	\N	\N
154	 magustuhan 	\N	\N	\N
155	gabi	\N	\N	\N
156	wala	\N	\N	\N
157	si	\N	\N	\N
158	 matrapik	\N	\N	\N
159	 kailangan 	\N	\N	\N
160	umuwi	\N	\N	\N
161	nang	\N	\N	\N
162	maaga	\N	\N	\N
163	ngayon	\N	\N	\N
164	dumating	\N	\N	\N
165	 trabaho 	\N	\N	\N
166	bukas	\N	\N	\N
167	bumalik	\N	\N	\N
168	uli	\N	\N	\N
169	umalis	\N	\N	\N
170	pakisabi	\N	\N	\N
171	magkano	\N	\N	\N
172	kilo	\N	\N	\N
173	mangga	\N	\N	\N
174	 kuwarenta 	\N	\N	\N
175	peso	\N	\N	\N
176	mahal	\N	\N	\N
177	tawad	\N	\N	\N
178	mura	\N	\N	\N
179	iyan	\N	\N	\N
180	 galing 	\N	\N	\N
181	kaya	\N	\N	\N
182	masarap	\N	\N	\N
183	ilan	\N	\N	\N
184	mayroon	\N	\N	\N
185	apat	\N	\N	\N
186	malaki	\N	\N	\N
187	lima	\N	\N	\N
188	maliit	\N	\N	\N
189	 kunin 	\N	\N	\N
190	 kalahati 	\N	\N	\N
191	piliin	\N	\N	\N
192	 maganda 	\N	\N	\N
193	makapunta	\N	\N	\N
194	 makaakyat 	\N	\N	\N
195	tuktok	\N	\N	\N
196	sumakit	\N	\N	\N
197	paa	\N	\N	\N
198	lang	\N	\N	\N
199	 gawin 	\N	\N	\N
200	 makatikim 	\N	\N	\N
201	 ng	\N	\N	\N
202	 durian	\N	\N	\N
203	 at	\N	\N	\N
204	 marang	\N	\N	\N
205	 iyon	\N	\N	\N
206	 lang	\N	\N	\N
207	balak	\N	\N	\N
208	masyado	\N	\N	\N
209	mainit	\N	\N	\N
210	tuluyan	\N	\N	\N
211	doon	\N	\N	\N
212	bahay	\N	\N	\N
213	kaklase	\N	\N	\N
214	gawin	\N	\N	\N
215	 magpalamig 	\N	\N	\N
216	matagal	\N	\N	\N
217	iba	\N	\N	\N
218	nasaan	\N	\N	\N
219	nasa	\N	\N	\N
220	mula	\N	\N	\N
221	dalawa	\N	\N	\N
222	oras	\N	\N	\N
223	mas	\N	\N	\N
224	malayo	\N	\N	\N
225	ganito	\N	\N	\N
226	magbiyahe	\N	\N	\N
227	nakakapagod	\N	\N	\N
228	hi	\N	\N	\N
229	bakasyon	\N	\N	\N
230	masaya	\N	\N	\N
231	 siyempre 	\N	\N	\N
232	teka	\N	\N	\N
233	bakit	\N	\N	\N
234	klase	\N	\N	\N
235	kanina	\N	\N	\N
236	 iskedyul 	\N	\N	\N
237	pag	\N	\N	\N
238	 Lunes 	\N	\N	\N
239	 Huwebes 	\N	\N	\N
240	 Pilipino 	\N	\N	\N
241	hanggang	\N	\N	\N
242	hapon	\N	\N	\N
243	pareho	\N	\N	\N
244	magkita	\N	\N	\N
245	 laybrari 	\N	\N	\N
246	mamaya	\N	\N	\N
247	kapatid	\N	\N	\N
248	lalaki	\N	\N	\N
249	sampu	\N	\N	\N
250	kami	\N	\N	\N
251	anim 	\N	\N	\N
252	 sikreto 	\N	\N	\N
253	paano	\N	\N	\N
254	magluto	\N	\N	\N
255	 sinigang 	\N	\N	\N
256	baboy	\N	\N	\N
257	medyo	\N	\N	\N
258	mahirap	\N	\N	\N
259	 pakuluan 	\N	\N	\N
260	muna	\N	\N	\N
261	 lumambot 	\N	\N	\N
262	 lagyan 	\N	\N	\N
263	asin	\N	\N	\N
264	iyan 	\N	\N	\N
265	tapos	\N	\N	\N
266	 ilagay 	\N	\N	\N
267	gulay	\N	\N	\N
268	mahiwa	\N	\N	\N
269	unahin	\N	\N	\N
270	labanos	\N	\N	\N
271	maluto	\N	\N	\N
272	 isabay 	\N	\N	\N
273	 durugin 	\N	\N	\N
274	 sampalok 	\N	\N	\N
275	ihuli	\N	\N	\N
276	kangkong	\N	\N	\N
277	 timplahan 	\N	\N	\N
278	patis	\N	\N	\N
279	 matabang 	\N	\N	\N
280	madali	\N	\N	\N
281	 marunong 	\N	\N	\N
282	 mag-Chabacano 	\N	\N	\N
283	 siyempre	\N	\N	\N
284	 mag-Cebuano 	\N	\N	\N
285	 talaga	\N	\N	\N
286	alam	\N	\N	\N
287	 Tagalog 	\N	\N	\N
288	Ingles	\N	\N	\N
289	Tagalog 	\N	\N	\N
290	mahusay	\N	\N	\N
291	 mag-Amoy 	\N	\N	\N
292	lolo	\N	\N	\N
293	naroon	\N	\N	\N
294	yata	\N	\N	\N
295	nina	\N	\N	\N
296	magnobyo	\N	\N	\N
297	sila	\N	\N	\N
298	tao	\N	\N	\N
299	-g	\N	\N	\N
300	 maningil 	\N	\N	\N
301	 kuryente 	\N	\N	\N
302	pitaka	\N	\N	\N
303	 tokador 	\N	\N	\N
304	narito	\N	\N	\N
305	ate	\N	\N	\N
306	dami	\N	\N	\N
307	 pasalubong 	\N	\N	\N
308	kahon	\N	\N	\N
309	tatay	\N	\N	\N
310	nanay	\N	\N	\N
311	kanino	\N	\N	\N
312	bago	\N	\N	\N
313	maleta	\N	\N	\N
314	alin	\N	\N	\N
315	 makalimutan 	\N	\N	\N
316	 magpagupit 	\N	\N	\N
317	magsawa	\N	\N	\N
318	mahaba	\N	\N	\N
319	buhok	\N	\N	\N
320	bagay	\N	\N	\N
321	mukhang	\N	\N	\N
322	bumata	\N	\N	\N
323	maikli	\N	\N	\N
324	elegante	\N	\N	\N
325	mataba	\N	\N	\N
326	mukha	\N	\N	\N
327	mag-ayos	\N	\N	\N
328	puwede	\N	\N	\N
329	kumain	\N	\N	\N
330	pinakbet	\N	\N	\N
331	kasama	\N	\N	\N
332	ampalaya	\N	\N	\N
333	siyempre	\N	\N	\N
334	ayaw	\N	\N	\N
335	mapait	\N	\N	\N
336	kalabasa	\N	\N	\N
337	talong	\N	\N	\N
338	 ihiwalay 	\N	\N	\N
339	paborito	\N	\N	\N
340	manood	\N	\N	\N
341	 telenobela 	\N	\N	\N
342	mahilig	\N	\N	\N
343	diyan	\N	\N	\N
344	sine	\N	\N	\N
345	libre	\N	\N	\N
346	hilig	\N	\N	\N
347	matulog	\N	\N	\N
348	magtanim	\N	\N	\N
349	 kamoteng-kahoy	\N	\N	\N
350	una	\N	\N	\N
351	puno	\N	\N	\N
352	 putulin	\N	\N	\N
353	dulo	\N	\N	\N
354	nito	\N	\N	\N
355	matulis	\N	\N	\N
356	bahagi	\N	\N	\N
357	putulin	\N	\N	\N
358	 tanggalin	\N	\N	\N
359	lahat	\N	\N	\N
360	dahon	\N	\N	\N
361	itanim	\N	\N	\N
362	lupa	\N	\N	\N
363	aba	\N	\N	\N
364	 kumusta	\N	\N	\N
365	kasal	\N	\N	\N
366	pisan	\N	\N	\N
367	imbitahin	\N	\N	\N
368	 pinsan	\N	\N	\N
369	isa pa	\N	\N	\N
370	huwag	\N	\N	\N
371	 bolahin	\N	\N	\N
372	mamiss	\N	\N	\N
373	kita	\N	\N	\N
374	 bagyo	\N	\N	\N
375	lakas	\N	\N	\N
376	ulan	\N	\N	\N
377	sigurado	\N	\N	\N
378	bumaha	\N	\N	\N
379	labas	\N	\N	\N
380	 oo nga	\N	\N	\N
381	baha	\N	\N	\N
382	lumabas	\N	\N	\N
383	 delikado	\N	\N	\N
384	mahulog	\N	\N	\N
385	manhole	\N	\N	\N
386	marumi	\N	\N	\N
387	tubig	\N	\N	\N
388	 magkasakit	\N	\N	\N
389	umaraw	\N	\N	\N
390	dumalaw	\N	\N	\N
391	lola	\N	\N	\N
392	 napakalaki	\N	\N	\N
393	putok	\N	\N	\N
394	 pinakamalaki	\N	\N	\N
395	 putok	\N	\N	\N
396	 bulkan	\N	\N	\N
397	noon	\N	\N	\N
398	mawalan	\N	\N	\N
399	 ito	\N	\N	\N
400	 kaysa	\N	\N	\N
401	 Mayon 	\N	\N	\N
402	 umabot	\N	\N	\N
403	 Maynila	\N	\N	\N
404	abo	\N	\N	\N
405	 Pilipinas	\N	\N	\N
406	 Hapon	\N	\N	\N
407	 dahil	\N	\N	\N
408	 lindol	\N	\N	\N
409	kumuha	\N	\N	\N
410	Filipino	1	F	\N
411	semester	\N	\N	\N
412	kunin	\N	\N	\N
413	ni	\N	\N	\N
414	mapili	\N	\N	\N
415	halos	\N	\N	\N
416	pumasa	\N	\N	\N
417	taun-taon	\N	\N	\N
418	akala ko	\N	\N	\N
419	mabait	\N	\N	\N
420	niya	\N	\N	\N
421	kahapon	\N	\N	\N
422	masira	\N	\N	\N
423	tiyan	\N	\N	\N
424	kainin	\N	\N	\N
425	tahong	\N	\N	\N
426	dahil 	\N	\N	\N
427	pakiramdam	\N	\N	\N
428	susunod	\N	\N	\N
429	pagkain	\N	\N	\N
430	sa iyo	\N	\N	\N
431	kapusin	\N	\N	\N
432	linggo	\N	\N	\N
433	 kaya	\N	\N	\N
434	 puwede	\N	\N	\N
435	 -ng	\N	\N	\N
436	 mangutang	\N	\N	\N
437	 magkano	\N	\N	\N
438	 kailangan	\N	\N	\N
439	piso	\N	\N	\N
440	 o sige	\N	\N	\N
441	 pero	\N	\N	\N
442	 ibalik	\N	\N	\N
443	 mo	\N	\N	\N
444	 sa	\N	\N	\N
445	 katapusan	\N	\N	\N
446	 buwan	\N	\N	\N
447	 magbayad	\N	\N	\N
448	 upa	\N	\N	\N
449	 ko	\N	\N	\N
450	 eh	\N	\N	\N
451	 problema	\N	\N	\N
452	 siguro	\N	\N	\N
453	 mabayaran	\N	\N	\N
454	 linggo	\N	\N	\N
455	malapit	\N	\N	\N
456	treynta	\N	\N	\N
457	makilala	\N	\N	\N
458	type	\N	\N	\N
459	katulad	\N	\N	\N
460	guwapo	\N	\N	\N
461	matangkad	\N	\N	\N
462	mataas	\N	\N	\N
463	pangarap	\N	\N	\N
464	tumanda	\N	\N	\N
465	dalaga	\N	\N	\N
466	tulad	\N	\N	\N
467	tita	\N	\N	\N
468	mamasyal	\N	\N	\N
469	o sige	\N	\N	\N
470	lumakad	\N	\N	\N
471	sumakay	\N	\N	\N
472	kalesa	\N	\N	\N
473	traysikel	\N	\N	\N
474	matanaw	\N	\N	\N
475	tanawin	\N	\N	\N
476	mabilis	\N	\N	\N
477	masikip	\N	\N	\N
478	sige	\N	\N	\N
479	magkalesa	\N	\N	\N
480	mapasyal	\N	\N	\N
481	sadya	\N	\N	\N
482	maaari	\N	\N	\N
483	maging	\N	\N	\N
484	okasyon	\N	\N	\N
485	namin	\N	\N	\N
486	buwan	\N	\N	\N
487	mahiram	\N	\N	\N
488	amg	\N	\N	\N
489	amerikana	\N	\N	\N
490	para sa	\N	\N	\N
491	pasaporte	\N	\N	\N
492	kailangan	\N	\N	\N
493	para	\N	\N	\N
494	mas mabilis	\N	\N	\N
495	 pa	\N	\N	\N
496	dapat	\N	\N	\N
497	magdala	\N	\N	\N
498	walo	\N	\N	\N
499	retrato	\N	\N	\N
500	tagal	\N	\N	\N
501	makuha	\N	\N	\N
502	bawal	\N	\N	\N
503	manigarilyo	\N	\N	\N
504	akala 	\N	\N	\N
505	Singapore	\N	\N	\N
506	mahigpit	\N	\N	\N
507	mahirapan	\N	\N	\N
508	tumigil	\N	\N	\N
509	paninigarilyo	\N	\N	\N
510	sige 	\N	\N	\N
511	subukan	\N	\N	\N
512	mama	\N	\N	\N
513	drayber	\N	\N	\N
514	dumaan	\N	\N	\N
515	iwasan	\N	\N	\N
516	matrapik	\N	\N	\N
517	kumanan	\N	\N	\N
518	kanto	\N	\N	\N
519	oho	\N	\N	\N
520	sa susunod na	\N	\N	\N
521	kumaliwa	\N	\N	\N
522	diretso	\N	\N	\N
523	pumara	\N	\N	\N
524	 harap 	\N	\N	\N
525	bilding	\N	\N	\N
526	 pumunta 	\N	\N	\N
527	 tayo 	\N	\N	\N
528	sa 	\N	\N	\N
529	 libing	\N	\N	\N
530	ng 	\N	\N	\N
531	 lolo 	\N	\N	\N
532	 sementeryo	\N	\N	\N
533	 po 	\N	\N	\N
534	ba 	\N	\N	\N
535	 simbahan	\N	\N	\N
536	 muna 	\N	\N	\N
537	 huwag	\N	\N	\N
538	 ka	\N	\N	\N
539	 mag-ingay 	\N	\N	\N
540	 habang	\N	\N	\N
541	 may	\N	\N	\N
542	 misa	\N	\N	\N
543	 maglaro 	\N	\N	\N
544	 pagkatapos 	\N	\N	\N
545	 din	\N	\N	\N
546	 lumayo 	\N	\N	\N
547	 sa akin	\N	\N	\N
548	 akin	\N	\N	\N
549	 dumiretso 	\N	\N	\N
550	 tayo	\N	\N	\N
551	 sementeryo 	\N	\N	\N
552	 oo	\N	\N	\N
553	 masyado	\N	\N	\N
554	 matanong	\N	\N	\N
555	 tayo na 	\N	\N	\N
556	 mabuti  	\N	\N	\N
557	ka 	\N	\N	\N
558	sa amin	\N	\N	\N
559	 maligaya	\N	\N	\N
560	 Pasko 	\N	\N	\N
561	 pasok	\N	\N	\N
562	-ng 	\N	\N	\N
563	 hubarin 	\N	\N	\N
564	 sapatos 	\N	\N	\N
565	 pagpasensiyahan	\N	\N	\N
566	 regalo	\N	\N	\N
567	 naku	\N	\N	\N
568	 mag-abala 	\N	\N	\N
569	 na	\N	\N	\N
570	 dapat 	\N	\N	\N
571	 magdala	\N	\N	\N
572	 regalo 	\N	\N	\N
573	 ho	\N	\N	\N
574	 sa 	\N	\N	\N
575	 ipadala 	\N	\N	\N
576	 nanay 	\N	\N	\N
577	 ang	\N	\N	\N
578	 ganda 	\N	\N	\N
579	 pakisabi 	\N	\N	\N
580	 din 	\N	\N	\N
581	 balita 	\N	\N	\N
582	 piyesta 	\N	\N	\N
583	daw 	\N	\N	\N
584	 bayan 	\N	\N	\N
585	 Linggo 	\N	\N	\N
586	oo 	\N	\N	\N
587	 pumasyal 	\N	\N	\N
588	 bahay	\N	\N	\N
589	 isama 	\N	\N	\N
590	 kung	\N	\N	\N
591	 libre 	\N	\N	\N
592	 siya	\N	\N	\N
593	 sige 	\N	\N	\N
594	 tanugin 	\N	\N	\N
595	ko 	\N	\N	\N
596	siya 	\N	\N	\N
597	 ano  	\N	\N	\N
598	 ang  	\N	\N	\N
599	 handa 	\N	\N	\N
600	 marami\t	\N	\N	\N
601	at 	\N	\N	\N
602	 ano	\N	\N	\N
603	pala 	\N	\N	\N
604	 paborito 	\N	\N	\N
605	 pagkain 	\N	\N	\N
606	 ate	\N	\N	\N
607	 mahilig  	\N	\N	\N
608	 siya 	\N	\N	\N
609	 halaya 	\N	\N	\N
610	 ipagawa 	\N	\N	\N
611	 iyan 	\N	\N	\N
612	 mukhang 	\N	\N	\N
613	 may 	\N	\N	\N
614	 problema 	\N	\N	\N
615	ah 	\N	\N	\N
616	 mayroon 	\N	\N	\N
617	 nga 	\N	\N	\N
618	ho 	\N	\N	\N
619	 tungkol 	\N	\N	\N
620	 isa 	\N	\N	\N
621	 babae 	\N	\N	\N
622	 bakit  	\N	\N	\N
623	ang 	\N	\N	\N
624	 mangyari 	\N	\N	\N
625	 magustuhan	\N	\N	\N
626	 isa	\N	\N	\N
627	 Haponesa 	\N	\N	\N
628	pero 	\N	\N	\N
629	may 	\N	\N	\N
630	na 	\N	\N	\N
631	 mahirap	\N	\N	\N
632	 mabuti	\N	\N	\N
633	 gawin	\N	\N	\N
634	 mamili	\N	\N	\N
635	 una 	\N	\N	\N
636	 matulog  	\N	\N	\N
637	 muna	\N	\N	\N
638	 pangalawa 	\N	\N	\N
639	 mag-isip  	\N	\N	\N
640	 pangatlo 	\N	\N	\N
641	 kalimutan 	\N	\N	\N
642	 mga	\N	\N	\N
643	 barong Tagalog 	\N	\N	\N
644	 kayo	\N	\N	\N
645	 wala 	\N	\N	\N
646	 gusto  	\N	\N	\N
647	 magpatahi 	\N	\N	\N
648	 barong Tagalog	\N	\N	\N
649	 para	\N	\N	\N
650	 inyo 	\N	\N	\N
651	 para 	\N	\N	\N
652	 asawa 	\N	\N	\N
653	 gusto	\N	\N	\N
654	 hindi	\N	\N	\N
655	 malaki	\N	\N	\N
656	 burda	\N	\N	\N
657	 pahingi 	\N	\N	\N
658	 habaan 	\N	\N	\N
659	 manggas 	\N	\N	\N
660	 mahaba 	\N	\N	\N
661	 braso 	\N	\N	\N
662	 kami	\N	\N	\N
663	 Mahal na Araw	\N	\N	\N
664	gusto 	\N	\N	\N
665	mo 	\N	\N	\N
666	 sumama 	\N	\N	\N
667	 sa amin	\N	\N	\N
668	 abala 	\N	\N	\N
669	 sa inyo	\N	\N	\N
670	 gusto 	\N	\N	\N
671	 sumama\t	\N	\N	\N
672	 daw	\N	\N	\N
673	 prusisyon	\N	\N	\N
674	 mga 	\N	\N	\N
675	 santo 	\N	\N	\N
676	 karosa 	\N	\N	\N
677	 sumali 	\N	\N	\N
678	 prusisyon 	\N	\N	\N
679	 rin	\N	\N	\N
680	 humila 	\N	\N	\N
681	 karosa	\N	\N	\N
682	 siyanga 	\N	\N	\N
683	 dumating	\N	\N	\N
684	 mula	\N	\N	\N
685	 Iloilo 	\N	\N	\N
686	 kababata	\N	\N	\N
687	 maganda	\N	\N	\N
688	 maging	\N	\N	\N
689	 reyna	\N	\N	\N
690	 noon 	\N	\N	\N
691	 totoo 	\N	\N	\N
692	 dalaga 	\N	\N	\N
694	 ipakilala 	\N	\N	\N
695	kanya	\N	\N	\N
697	 eto	\N	\N	\N
698	 pala	\N	\N	\N
699	 si	\N	\N	\N
700	 Joey 	\N	\N	\N
701	 kaopisina 	\N	\N	\N
702	pumunta	1	P	\N
703	Ingles	1	I	\N
704	eroplano	1	E	\N
705	ibang bansa	1	B	\N
706	dayuhan	1	D	\N
707	wikang Pranses	1	P	\N
708	otel	1	O	\N
709	Hapon	1	H	\N
710	lumabas	1	L	\N
711	bansa	1	B	\N
712	magkita	1	K	\N
713	bakasyon	1	B	\N
714	paglalakbay	1	L	\N
715	maglakbay	1	L	\N
716	maglaro	1	L	\N
717	embahada	1	E	\N
718	gustung-gusto	1	G	\N
719	gusto	1	G	\N
720	mahusay	1	H	\N
721	tumakbo	1	T	\N
722	dahan-dahan	1	D	\N
723	hindi mahusay	1	H	\N
724	maglakad	1	L	\N
725	lumangoy	1	L	\N
726	mabilis	1	B	\N
727	lumipad	1	L	\N
728	isports	1	I	\N
729	ayaw	1	A	\N
730	swimming pool	1	S	\N
731	bus	1	B	\N
732	bisikleta	1	B	\N
733	krosing	1	K	\N
734	daan	1	D	\N
735	lawa	1	L	\N
736	pamamasyal	1	P	\N
737	ilog	1	I	\N
738	taksi	1	T	\N
739	kotse	1	K	\N
740	lumiko	1	L	\N
741	kurbata	1	K	\N
742	kamisadentro	1	K	\N
743	kumpanya	1	K	\N
744	amerikana	1	A	\N
745	gawin	1	G	\N
746	manigarilyo	1	S	\N
747	telepono	1	T	\N
748	trabaho	1	T	\N
749	magtrabaho	1	T	\N
750	bisi	1	B	\N
751	aklatan	1	A	\N
752	diksyunaryo	1	D	\N
753	humiram	1	H	\N
754	dyaryo	1	D	\N
755	magbasa	1	B	\N
756	libro	1	L	\N
757	kopya	1	K	\N
758	kopyahin	1	K	\N
759	magasin	1	M	\N
760		\N		\N
761	karneng baka	1	B	\N
762	mura	1	M	\N
763	tindahan	1	T	\N
764	mahal	1	M	\N
765	ilan	1	I	\N
766	magkano	1	M	\N
767	prutas	1	P	\N
768	gulay	1	G	\N
769	isda	1	I	\N
770	karneng baboy	1	B	\N
771	manok	1	M	\N
772	karne	1	K	\N
773	gusto	0	G	\N
774	iabot	1	A	\N
775	tindahan ng gulay	1	T	\N
776	susi	1	S	\N
777	luto	1	L	\N
778	mamili	1	B	\N
779	maglaba	1	L	\N
780	maglinis	1	L	\N
781	pamilya	1	P	\N
782	tahanan	1	T	\N
783	halamanan	1	H	\N
784	paglalaba	1	L	\N
785	bahay	1	B	\N
786	bahay	0	B	\N
787	paglilinis	1	L	\N
788	umuwi	1	U	\N
789	bookshelf	1	B	\N
790	mesa	1	M	\N
791	upuan	1	U	\N
792	kuwarto	1	K	\N
793	repridyereytor	1	R	\N
794	maghugas	1	H	\N
795	kama	1	K	\N
796	radyo	1	R	\N
797	radyo	0	R	\N
798	si	1	S	\N
799	matulog	1	T	\N
800	gumising	1	G	\N
801	mesa	0	M	\N
802	telebisyon	1	T	\N
803	pulis	1	P	\N
804	pulis	0	P	\N
805	mapa	1	M	\N
806	tabi	1	T	\N
807	dito	1	D	\N
808	diyan	1	D	\N
809	doon	1	D	\N
810	saan	1	S	\N
811	maliit na istasyon ng pulis	1	P	\N
812	kalapit	1	L	\N
813	katabi	1	T	\N
814	makinig	1	D	\N
815	maggupit	1	G	\N
816	maikli	1	I	\N
817	likod	1	L	\N
818	harap	1	H	\N
819	kanan	1	K	\N
820	kaliwa	1	K	\N
821	mahaba	1	H	\N
822	umupo	1	U	\N
823	tumayo	1	T	\N
824	kaibigan	1	K	\N
825	klase	1	K	\N
826	klasrum	1	K	\N
827	koridor	1	K	\N
828	eskuwelahan	1	E	\N
829	estudyante	1	E	\N
830	pag-aaral	1	A	\N
831	estudyante	0	E	\N
832	dayuhang-mag-aaral	1	D	\N
833	bakasyon sa tag-init	1	B	\N
834	titser	1	T	\N
835	unibersidad	1	U	\N
836	kuwaderno	1	K	\N
837	klase	1	K	\N
838	komposisyon	1	K	\N
839	homework	1	H	\N
840	mahirap	1	H	\N
841	magturo	1	T	\N
842	eksam	1	E	\N
843	pag-eensayo	1	E	\N
844	madali	1	D	\N
845	mag-ensayo	1	E	\N
846	tanong	1	T	\N
847	tanong	1	T	\N
848	sumagot	1	S	\N
849	masakit	1	S	\N
850	ngipin	1	NG	\N
851	doktor	1	D	\N
852	ospital	1	O	\N
853	sakit	1	S	\N
854	gamot	1	G	\N
855	mamatay	1	P	\N
856	sipon	1	S	\N
858	tiyan	1	T	\N
859	digri	0	D	\N
860	elebeytor	1	E	\N
861	tiket	1	T	\N
862	bumaba	1	B	\N
863	hagdan	1	H	\N
864	isara	1	S	\N
865	istasyon ng tren	1	I	\N
866	subway	1	S	\N
867	sumakay	1	S	\N
868	buksan	1	B	\N
869	CR	0	C	\N
870	CR	1	C	\N
871	tren	1	T	\N
872	inumin	1	I	\N
873	kape	1	K	\N
874	coffee shop	1	C	\N
875	limon	1	L	\N
876	gatas	1	G	\N
877	asukal	1	A	\N
878	tasa	1	T	\N
879	green tea	1	G	\N
880	tsaa	1	T	\N
881	baso	1	B	\N
882	ilagay	1	L	\N
883	matamis	1	T	\N
884	uminom	1	I	\N
885	chopsticks	1	C	\N
886	alak	1	A	\N
887	masarap	1	S	\N
888	kutsilyo	1	K	\N
889	kutsara	1	K	\N
890	tinidor	1	T	\N
891	keso	1	K	\N
892	kumain	1	K	\N
893	hindi masarap	1	M	\N
894	tinapay	1	T	\N
895	maanghang	1	A	\N
896	restawran	1	R	\N
897	kantin	1	K	\N
898	alak	0	A	\N
899	pagkain	1	P	\N
900	curry	1	C	\N
901	pera	1	P	\N
902	bangko	1	B	\N
903	pasukan	1	P	\N
904	walang anuman	1	A	\N
905	hindi	1	H	\N
906	oo	1	O	\N
907	Mawalang-galang na nga po.	1	G	\N
908	sige	1	S	\N
909	labasan	1	L	\N
910	dumating	1	D	\N
911	buson	1	B	\N
912	poskard	1	P	\N
913	idikit	1	D	\N
914	sobre	1	S	\N
915	sulat	1	S	\N
916	pos opis	1	P	\N
917	ibalik	1	B	\N
918	ihulog	1	H	\N
919	selyo	1	S	\N
920	bagahe	1	B	\N
921	piraso	1	P	\N
922	ipahiram	1	H	\N
923	bumili	1	B	\N
924	sumbrero	1	S	\N
925	sapatos	1	S	\N
926	pamimili	1	B	\N
927	palapag	1	P	\N
928	department istor	1	D	\N
929	palda	1	P	\N
930	panlamig	1	P	\N
931	pantalon	1	P	\N
932	sweater	1	S	\N
933	paki～	1	P	\N
934	bag	1	B	\N
935	ibenta	1	B	\N
936	jacket	1	J	\N
937	banyo	1	B	\N
938	gusali	1	G	\N
939	kusina	1	K	\N
940	shower	1	S	\N
941	bintana	1	B	\N
942	tumira	1	T	\N
943	park	1	P	\N
944	pinto	1	P	\N
945	maligo	1	L	\N
946	apartment	1	A	\N
947	pintuan	1	P	\N
948	siya	1	S	\N
949	sila	1	S	\N
950	ako	1	A	\N
951	kami	1	K	\N
952	sino	1	S	\N
953	sino	0	S	\N
954	sino	0	S	\N
955	ikaw	1	I	\N
956	ikaw	0	I	\N
957	nito	1	N	\N
958	niyan	1	N	\N
959	paano	1	P	\N
960	alin	1	A	\N
961	ano	1	A	\N
962	ganito	1	G	\N
963	sarili	1	S	\N
964	ganiyan	1	G	\N
965	makapal	1	K	\N
966	masikip	1	S	\N
967	payat	1	P	\N
968	malaki	1	L	\N
969	mataba	1	T	\N
970	bata	1	B	\N
971	malapad	1	L	\N
972	magaan	1	G	\N
973	malayo	1	L	\N
974	mabigat	1	B	\N
975	manipis	1	N	\N
976	bago	1	B	\N
977	maliit	1	L	\N
978	malapit	1	L	\N
979	luma	1	L	\N
980	masaya	1	S	\N
981	masigla	1	S	\N
982	mababa	1	B	\N
983	mabuti	1	B	\N
984	maliwanag	1	L	\N
985	mahina	1	H	\N
986	malakas	1	L	\N
987	nakakatawa	1	T	\N
988	maganda	1	G	\N
989	mabagal	1	B	\N
990	masama	1	S	\N
991	marami	1	D	\N
992	madilim	1	D	\N
993	tahimik	1	T	\N
994	kakaunti	1	K	\N
995	marumi	1	D	\N
996	walang kuwenta	1	K	\N
997	lapad	1	L	\N
998	loob	1	L	\N
999	labas	1	L	\N
1000	silangan	1	S	\N
1001	taas	1	T	\N
1002	haba	1	H	\N
1003	hilaga	1	H	\N
1004	kanluran	1	K	\N
1005	ibaba	1	I	\N
1006	timog	1	T	\N
1007	ibabaw	1	I	\N
1008	unahan	1	U	\N
1009	likod	0	L	\N
1010	pinsan	1	P	\N
1011	kuya	1	K	\N
1012	kapatid	1	K	\N
1013	lola	1	L	\N
1014	lolo	1	L	\N
1015	asawa	1	A	\N
1016	nanay	1	N	\N
1017	tito	1	T	\N
1018	magulang	1	M	\N
1019	tatay	1	T	\N
1020	ate	1	A	\N
1021	kapatid na babae	1	K	\N
1022	tita	1	T	\N
1023	kuya	0	K	\N
1024	ate	0	A	\N
1025	tatay	0	T	\N
1026	nanay	0	N	\N
1027	medyas	1	M	\N
1028	polo	1	P	\N
1029	maghubad	1	H	\N
1030	isabit	1	S	\N
1031	isuot	1	S	\N
1032	magsuot	1	S	\N
1033	magsumbrero	1	S	\N
1034	panyo	1	P	\N
1035	tsinelas	1	T	\N
1036	payong	1	P	\N
1037	bulsa	1	B	\N
1038	pitaka	1	P	\N
1039	nakasuot	1	S	\N
1040	damit	1	D	\N
1041	damit	0	D	\N
1042	bunganga	1	B	\N
1043	bisig	1	B	\N
1044	katawan	1	K	\N
1045	mukha	1	M	\N
1046	binti	1	B	\N
1047	kamay	1	K	\N
1048	ilong	1	I	\N
1049	mata	1	M	\N
1050	tenga	1	T	\N
1051	paa	1	P	\N
1052	tiyan	0	T	\N
1053	plato	1	P	\N
1054	bater	1	B	\N
1055	mangkok	1	M	\N
1056	kendi	1	K	\N
1057	tanghalian	1	T	\N
1058	hapunan	1	H	\N
1059	mga matamis	1	M	\N
1060	itlog	1	I	\N
1061	almusal	1	A	\N
1062	kanin	1	K	\N
1063	toyo	1	T	\N
1064	asin	1	A	\N
1065	hapunan	0	H	\N
1066	idagdag	1	D	\N
1067	ikabit	1	K	\N
1068	kamera	1	K	\N
1069	kalan	1	K	\N
1070	lapis	1	L	\N
1071	burahin	1	B	\N
1072	salamin sa mata	1	S	\N
1073	tape recorder	1	T	\N
1074	relo	1	R	\N
1075	kompyuter	1	K	\N
1076	film	1	F	\N
1077	pinto	0	P	\N
1078	trangkahan	1	T	\N
1079	pluma	1	P	\N
1080	pontimpen	1	P	\N
1081	bolpen	1	B	\N
1082	Agosto	1	A	\N
1083	Abril	1	A	\N
1084	itong buwang ito	1	B	\N
1085	buwan-buwan	1	B	\N
1086	Disyembre	1	D	\N
1087	Pebrero	1	P	\N
1088	Enero	1	E	\N
1089	Hulyo	1	H	\N
1090	Hunyo	1	H	\N
1091	sa isang buwan	1	B	\N
1092	Mayo	1	M	\N
1093	Marso	1	M	\N
1094	noong isang buwan	1	B	\N
1095	Nobyembre	1	N	\N
1096	Oktubre	1	O	\N
1097	Setyembre	1	S	\N
1098	isang buwan	1	B	\N
1099	ngayong linggo	1	L	\N
1100	linggu-linggo	1	L	\N
1114	taun-taon	1	T	\N
1115	tag-init	1	T	\N
1116	taglamig	1	T	\N
1117	noong isang taon	1	T	\N
1118	sa isang taon	1	T	\N
1119	tagsibol	1	T	\N
1120	sa isa pang taon	1	T	\N
1121	noong isa pang taon	1	T	\N
1122	hapon	1	H	\N
1123	ngayon	1	NG	\N
1124	bukas	1	B	\N
1125	alas	1	A	\N
1126	kahapon	1	K	\N
1127	kagabi	1	K	\N
1128	umaga	1	U	\N
1129	umaga	0	U	\N
1130	tanghali	1	T	\N
1131	gabi	1	G	\N
1132	dapithapon	1	D	\N
1133	samakalawa	1	S	\N
1134	kamakalawa	1	K	\N
1135	na	1	N	\N
1136	habang	1	H	\N
1137	pa	1	P	\N
1138	sa	1	S	\N
1139	pag	1	P	\N
1140	kailan	1	K	\N
1141	paminsan-minsan	1	P	\N
1142	madalas	1	D	\N
1143	oras	1	O	\N
1144	agad	1	A	\N
1145	ashtray	1	A	\N
1146	kanta	1	K	\N
1147	kumanta	1	K	\N
1148	sigarilyo	1	S	\N
1149	sine	1	S	\N
1150	plaka	1	P	\N
1151	gitara	1	G	\N
1152	tumugtog	1	T	\N
1153	musika	1	M	\N
1154	larawan	1	L	\N
1155	letrato	1	L	\N
1156	gusto	0	G	\N
1157	boses	1	B	\N
1158	maaraw	1	A	\N
1159	mainit	1	I	\N
1160	umaraw	1	A	\N
1161	presko	1	P	\N
1162	malamig	1	L	\N
1163	niyebe	1	N	\N
1164	umulan	1	U	\N
1165	ulan	1	U	\N
1166	panahon	1	P	\N
1167	mainit	0	I	\N
1168	hangin	1	H	\N
1169	maulap	1	U	\N
1170	malamig	1	L	\N
1171	maging maulap	1	U	\N
1172		\N		\N
1173	magsabi	1	S	\N
1174	sumulat	1	S	\N
1175	pag-uusap	1	U	\N
1176	wika	1	W	\N
1177	wika	0	W	\N
1178	wika	0	W	\N
1179	magsalita	1	S	\N
1180	pangungusap	1	U	\N
1181	magkuwento	1	K	\N
1182	kahulugan	1	K	\N
1183		\N		\N
1184		\N		\N
1185	matanda	1	T	\N
1186	marami	0	D	\N
1187	mag-asawa	1	A	\N
1188	bata	1	B	\N
1189	asawa	0	A	\N
1190	babae	1	B	\N
1191	batang lalaki	1	B	\N
1192	tao	1	T	\N
1193	lalaki	1	L	\N
1194	batang babae	1	B	\N
1195	asawa	1	A	\N
1196	tao	0	T	\N
1197	lahat	1	L	\N
1198	puti	1	P	\N
1199	asul	1	A	\N
1200	kulay kape	1	K	\N
1201	matingkad	1	M	\N
1202	kulay	1	K	\N
1203	madilim	0	D	\N
1204	dilaw	1	D	\N
1205	itim	1	I	\N
1206	pula	1	P	\N
1207	berde	1	B	\N
1208	kombinyente	1	K	\N
1209	parti	1	P	\N
1210	papel	1	P	\N
1211	maging	1	M	\N
1212	higpitan	1	H	\N
1213	itulak	1	T	\N
1214	magsimula	1	S	\N
1215	ganiyang-ganiyan	1	G	\N
1216	wala	1	W	\N
1217	tuwid	1	T	\N
1218	sikat	1	S	\N
1219	masigla	0	S	\N
1220	kung ganoon	1	K	\N
1221	baka	1	B	\N
1222	sige	0	S	\N
693	 oo 	\N	\N	\N
1	maganda	\N	\N	\N
2	-ng	\N	\N	\N
3	umaga	\N	\N	\N
4	po	\N	\N	\N
5		\N	\N	\N
6	oy	\N	\N	\N
7	ikaw	\N	\N	\N
8	pala	\N	\N	\N
9	saan	\N	\N	\N
10	ho	\N	\N	\N
11	kayo	\N	\N	\N
12	galing	\N	\N	\N
13	ako	\N	\N	\N
14	sa	\N	\N	\N
696	 aba	\N	\N	\N
857	ulo	1	U	\N
1101	Linggo	1	L	\N
1102	Huwebes	1	H	\N
1103	sa isang linggo	1	L	\N
1104	Lunes	1	L	\N
1105	Martes	1	M	\N
1106	Miyerkoles	1	M	\N
1107	Sabado	1	S	\N
1108	linggo	1	L	\N
1109	noong isang linggo	1	L	\N
1110	Biyernes	1	B	\N
1111	taon	1	T	\N
1112	taglagas	1	T	\N
1113	ngayong taon	1	T	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: tl
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
1	maganda	美しい	形容詞	\N	\N	\N	58	\N
2	-ng		繋辞	\N	\N	\N	58	\N
3	umaga	朝	名詞	\N	\N	\N	58	\N
4	po	敬意を表わす	副詞	\N	\N	\N	58	\N
5	Aling Irma	イルマおばさん	固有名詞	\N	\N	\N	58	\N
6	oy		感嘆詞	\N	\N	\N	59	\N
5	Tony	トニー	固有名詞	\N	\N	\N	59	\N
7	ikaw	あなた	代名詞	\N	\N	\N	59	\N
8	pala	驚きを表わす	副詞	\N	\N	\N	59	\N
9	saan	どこ	疑問代名詞	\N	\N	\N	60	\N
10	ho	敬意を表わす	副詞	\N	\N	\N	60	\N
11	kayo	あなた	代名詞	\N	\N	\N	60	\N
12	galing	来る	動詞	\N	\N	\N	60	\N
13	ako	わたし	代名詞	\N	\N	\N	61	\N
14	sa	～から	前置詞	\N	\N	\N	61	\N
15	palengke	市場	名詞	\N	\N	\N	61	\N
16	ka	あなた	代名詞	\N	\N	\N	62	\N
17	naman	話題を変える	副詞	\N	\N	\N	62	\N
18	pupunta	行く	動詞	\N	\N	\N	62	\N
19	bihis	着る	動詞	\N	\N	\N	63	\N
20	na		繋辞	\N	\N	\N	63	\N
21	ah		感嘆詞	\N	\N	\N	63	\N
22	may	ある	存在を表わす小詞	\N	\N	\N	64	\N
23	lakad	用事	名詞	\N	\N	\N	64	\N
13	ako	私	代名詞	\N	\N	\N	64	\N
14	sa	～に	前置詞	\N	\N	\N	64	\N
5	Makati	マカティ	固有名詞	\N	\N	\N	64	\N
5	o sige	わかった	感嘆詞	\N	\N	\N	65	\N
24	mag-ingat	気をつける	動詞	\N	\N	\N	65	\N
25	ha		感嘆詞	\N	\N	\N	65	\N
26	ikumusta	よろしく言う	動詞	\N	\N	\N	66	\N
27	ninyo	あなた	代名詞	\N	\N	\N	66	\N
28	kay	～に	標識辞	\N	\N	\N	66	\N
5	Mang Rudy	ルディーおじさん	固有名詞	\N	\N	\N	66	\N
6	oy		感嘆詞	\N	\N	\N	67	\N
5	Jun	ジュン	固有名詞	\N	\N	\N	67	\N
29	salamat	ありがとう	名詞	\N	\N	\N	67	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	67	\N
14	sa	～を	前置詞	\N	\N	\N	67	\N
30	ang		標識辞	\N	\N	\N	68	\N
31	sarap	おいしい	形容詞	\N	\N	\N	68	\N
5	walang anuman	どういたしまして		\N	\N	\N	69	\N
5	mabuti at	～でよかった		\N	\N	\N	70	\N
17	naman	語調を柔らげる	副詞	\N	\N	\N	70	\N
32	nagustuhan	気に入る	動詞	\N	\N	\N	70	\N
33	mo	あなた	代名詞	\N	\N	\N	70	\N
34	oo	ええ	副詞	\N	\N	\N	71	\N
35	naubos	なくなる	動詞	\N	\N	\N	71	\N
36	nga	語調を柔らげる	副詞	\N	\N	\N	71	\N
37	agad	すぐに	副詞	\N	\N	\N	71	\N
38	eh		感嘆詞	\N	\N	\N	71	\N
39	kumusta	どうですか	疑問代名詞	\N	\N	\N	72	\N
17	naman	話題を変える	副詞	\N	\N	\N	72	\N
23	lakad	用事	名詞	\N	\N	\N	72	\N
33	mo	あなたの	代名詞	\N	\N	\N	72	\N
14	sa	～で	前置詞	\N	\N	\N	72	\N
5	Calamba	カランバ	固有名詞	\N	\N	\N	72	\N
40	mabuti	よい	形容詞	\N	\N	\N	73	\N
5	siyanga pala	ところで		\N	\N	\N	74	\N
41	marami	たくさん	形容詞	\N	\N	\N	74	\N
2	-ng		繋辞	\N	\N	\N	74	\N
42	din	～も	副詞	\N	\N	\N	74	\N
43	tulong	手伝い	名詞	\N	\N	\N	74	\N
33	mo	あなたの	代名詞	\N	\N	\N	74	\N
44	paper	レポート	名詞	\N	\N	\N	74	\N
45	ko	私の	代名詞	\N	\N	\N	74	\N
5	bale-wala	どうってことない		\N	\N	\N	75	\N
46	iyon	それ	代名詞	\N	\N	\N	75	\N
5	mas mabuting	～したほうがいい		\N	\N	\N	76	\N
47	magpasalamat	感謝する	動詞	\N	\N	\N	76	\N
16	ka	あなた	代名詞	\N	\N	\N	76	\N
28	kay	～に	標識辞	\N	\N	\N	76	\N
5	oo nga pala	そうだね		\N	\N	\N	77	\N
48	siya	彼女	代名詞	\N	\N	\N	78	\N
49	nag-type	打つ	動詞	\N	\N	\N	78	\N
50	ng		標識辞	\N	\N	\N	78	\N
45	ko	私の	代名詞	\N	\N	\N	78	\N
5	Tito	ティト	固有名詞	\N	\N	\N	79	\N
51	tingnan	見る	動詞	\N	\N	\N	79	\N
33	mo	あなた	代名詞	\N	\N	\N	79	\N
46	iyon	あれ	代名詞	\N	\N	\N	79	\N
52	o		感嘆詞	\N	\N	\N	79	\N
53	ano	何	疑問代名詞	\N	\N	\N	80	\N
4	po	敬意を表す	副詞	\N	\N	\N	80	\N
30	ang		標識辞	\N	\N	\N	81	\N
54	laki	大きい	形容詞	\N	\N	\N	81	\N
2	-ng		繋辞	\N	\N	\N	81	\N
55	isda	魚	名詞	\N	\N	\N	81	\N
56	ay		感嘆詞	\N	\N	\N	82	\N
57	hindi	～でない	副詞	\N	\N	\N	82	\N
58	dugong	ジュゴン	名詞	\N	\N	\N	83	\N
53	ano	何	疑問代名詞	\N	\N	\N	84	\N
59	isa	1つ	数詞	\N	\N	\N	85	\N
2	-ng		繋辞	\N	\N	\N	85	\N
60	mammal	哺乳類	名詞	\N	\N	\N	85	\N
20	na		繋辞	\N	\N	\N	85	\N
61	nakatira	住んでいる	形容詞	\N	\N	\N	85	\N
14	sa	～に	前置詞	\N	\N	\N	85	\N
62	dagat	海	名詞	\N	\N	\N	85	\N
5	Western Visayas	西ビサヤ諸島	固有名詞	\N	\N	\N	85	\N
63	at	～と	接続詞	\N	\N	\N	85	\N
64	parang	～のようだ	副詞	\N	\N	\N	86	\N
65	baka	牛	名詞	\N	\N	\N	86	\N
2	-ng		繋辞	\N	\N	\N	86	\N
66	lumalamgoy	泳いでいる	動詞	\N	\N	\N	86	\N
53	ano	～だね	副詞	\N	\N	\N	86	\N
34	oo	そうよ	副詞	\N	\N	\N	87	\N
36	nga	語調を柔らげる	副詞	\N	\N	\N	87	\N
67	suwerte	運がいい	形容詞	\N	\N	\N	88	\N
68	tayo	私たち	代名詞	\N	\N	\N	88	\N
69	dahil	なぜなら	接続詞	\N	\N	\N	88	\N
70	bihira	めったに～ない	副詞	\N	\N	\N	88	\N
71	ito	これ	代名詞	\N	\N	\N	88	\N
2	-ng		繋辞	\N	\N	\N	88	\N
72	makita	見る	動詞	\N	\N	\N	88	\N
73	kung	もし	接続詞	\N	\N	\N	89	\N
74	gusto	～したい	動詞	\N	\N	\N	89	\N
33	mo	あなた	代名詞	\N	\N	\N	89	\N
75	natin	私たち	代名詞	\N	\N	\N	89	\N
14	sa	～で	前置詞	\N	\N	\N	89	\N
76	encyclopedia	百科事典	名詞	\N	\N	\N	89	\N
5	tao po	ごめんください		\N	\N	\N	90	\N
77	 nariyan	そこにいる	存在を表わす小詞	\N	\N	\N	91	\N
78	 po	敬意を表わす	副詞	\N	\N	\N	91	\N
79	 ba	疑問文を作る	副詞	\N	\N	\N	91	\N
80	 si 		標識辞	\N	\N	\N	91	\N
5	 Minda 	ミンダ	固有名詞	\N	\N	\N	91	\N
5	sino po sila?	どちらさまですか？		\N	\N	\N	92	\N
81	 ako 	私	代名詞	\N	\N	\N	93	\N
5	 Rolly 	ローリー	固有名詞	\N	\N	\N	93	\N
82	 ang 		標識辞	\N	\N	\N	93	\N
83	 kaklase 	同級生	名詞	\N	\N	\N	93	\N
84	 ni 		標識辞	\N	\N	\N	93	\N
11	kayo	あなた	代名詞	\N	\N	\N	94	\N
85	 ho 	敬意を表す	副詞	\N	\N	\N	94	\N
86	 ate 	姉	名詞	\N	\N	\N	94	\N
57	hindi 	いいえ	副詞	\N	\N	\N	95	\N
87	 ako	私	代名詞	\N	\N	\N	96	\N
88	 nanay	母親	名詞	\N	\N	\N	96	\N
89	 niya	彼女の	代名詞	\N	\N	\N	96	\N
90	 napakabata 	とても若い	形容詞	\N	\N	\N	97	\N
91	 naman 	語調を柔らげる	副詞	\N	\N	\N	97	\N
92	 ninyo 	あなた	代名詞	\N	\N	\N	97	\N
93	 parang 	～のようだ	副詞	\N	\N	\N	98	\N
94	 lang 	～だけ	副詞	\N	\N	\N	98	\N
95	 kayo 	あなた	代名詞	\N	\N	\N	98	\N
96	 salamat 	ありがとう	名詞	\N	\N	\N	99	\N
97	 tuloy 	中に入る	動詞	\N	\N	\N	100	\N
98	 ka 	あなた	代名詞	\N	\N	\N	100	\N
99	 at 	そして	接続詞	\N	\N	\N	100	\N
100	 tatawagin 	呼ぶ	動詞	\N	\N	\N	100	\N
101	 ko 	私	代名詞	\N	\N	\N	100	\N
102	 helo 	もしもし	感嘆詞	\N	\N	\N	101	\N
103	 puwede 	～してもよい	動詞	\N	\N	\N	101	\N
85	 ho 	敬意を表す	副詞	\N	\N	\N	101	\N
104	 ba 	疑問文を作る	副詞	\N	\N	\N	101	\N
105	 -ng 		繋辞	\N	\N	\N	101	\N
106	 makausap 	話ができる	動詞	\N	\N	\N	101	\N
80	 si 		標識辞	\N	\N	\N	101	\N
5	 Cherry 	チェリー	固有名詞	\N	\N	\N	101	\N
107	 Mike 	マイク	固有名詞	\N	\N	\N	102	\N
108	 ito 	こちら	代名詞	\N	\N	\N	102	\N
5	 pasensiya ka na 	ごめん		\N	\N	\N	103	\N
63	at	なぜなら	接続詞	\N	\N	\N	103	\N
109	 hindi 	～ない	副詞	\N	\N	\N	103	\N
81	 ako 	私	代名詞	\N	\N	\N	103	\N
110	 nakarating 	行くことができる	動詞	\N	\N	\N	103	\N
14	sa	～に	前置詞	\N	\N	\N	103	\N
111	 mo 	君の/あなたの	代名詞	\N	\N	\N	103	\N
112	 kahapon 	昨日	副詞	\N	\N	\N	103	\N
5	 okey lang 	かまわない		\N	\N	\N	104	\N
113	 iyon 	それ	代名詞	\N	\N	\N	104	\N
114	 kasi 	なぜなら	接続詞	\N	\N	\N	105	\N
115	 nilagnat 	熱が出る	動詞	\N	\N	\N	105	\N
81	 ako 	私	代名詞	\N	\N	\N	105	\N
38	eh		感嘆詞	\N	\N	\N	105	\N
116	 sayang 	残念	感嘆詞	\N	\N	\N	106	\N
117	 napakasaya 	とても楽しい	形容詞	\N	\N	\N	106	\N
118	 namin 	私たち	代名詞	\N	\N	\N	106	\N
119	 kumusta 	気分はどう？	疑問代名詞	\N	\N	\N	107	\N
98	 ka 	あなた	代名詞	\N	\N	\N	107	\N
120	 na 	もう	副詞	\N	\N	\N	107	\N
121	 ngayon 	今日	副詞	\N	\N	\N	107	\N
122	 medyo 	少し	副詞	\N	\N	\N	108	\N
123	 magaling 	良い	形容詞	\N	\N	\N	108	\N
20	na	もう	副詞	\N	\N	\N	108	\N
13	ako	私	代名詞	\N	\N	\N	108	\N
124	pero	でも	接続詞	\N	\N	\N	108	\N
125	inuubo	咳をする	動詞	\N	\N	\N	108	\N
126	pa	まだ	副詞	\N	\N	\N	108	\N
127	rin	～もまた	副詞	\N	\N	\N	108	\N
5	 magpagaling ka 	お大事に		\N	\N	\N	109	\N
25	ha		感嘆詞	\N	\N	\N	109	\N
29	salamat	ありがとう	名詞	\N	\N	\N	110	\N
128	talaga	本当に	副詞	\N	\N	\N	111	\N
5	 Greg 	グレッグ	固有名詞	\N	\N	\N	112	\N
129	eto	これ	代名詞	\N	\N	\N	112	\N
130	 pala 	軽い驚きを表す	副詞	\N	\N	\N	112	\N
30	ang		標識辞	\N	\N	\N	112	\N
131	 tsokolate 	チョコレート	名詞	\N	\N	\N	112	\N
96	 salamat 	ありがとう	名詞	\N	\N	\N	113	\N
5	Yuko	ユーコ	固有名詞	\N	\N	\N	113	\N
109	 hindi 	～でない	副詞	\N	\N	\N	114	\N
45	ko	私の	代名詞	\N	\N	\N	114	\N
132	 naman	語調を柔らげる	副詞	\N	\N	\N	114	\N
133	 bertdey 	誕生日	名詞	\N	\N	\N	114	\N
21	ah		感嘆詞	\N	\N	\N	114	\N
5	 Valentine’s day 	バレンタインデー	名詞	\N	\N	\N	115	\N
134	kasi	～だから	接続詞	\N	\N	\N	115	\N
38	eh		感嘆詞	\N	\N	\N	115	\N
53	ano	え？	語彙項目の品詞	\N	\N	\N	116	\N
135	 bakit 	どうして	疑問代名詞	\N	\N	\N	117	\N
7	ikaw	君/あなた	代名詞	\N	\N	\N	117	\N
136	 nagreregalo 	プレゼントをする	動詞	\N	\N	\N	117	\N
137	 ganyan 	そのような	代名詞	\N	\N	\N	118	\N
5	sa amin 	わたしたちのところで	代名詞句	\N	\N	\N	118	\N
14	sa	～で	前置詞	\N	\N	\N	118	\N
138	Japan	日本	固有名詞	\N	\N	\N	118	\N
139	naku	えー	感嘆詞	\N	\N	\N	119	\N
57	hindi	～でない	副詞	\N	\N	\N	119	\N
140	ganyan	そのような	代名詞	\N	\N	\N	119	\N
141	dito	ここ	代名詞	\N	\N	\N	119	\N
14	sa	～で	前置詞	\N	\N	\N	119	\N
142	 Pilipinas 	フィリピン	固有名詞	\N	\N	\N	119	\N
143	mga	複数を表す	標識辞	\N	\N	\N	120	\N
144	babae	女性	名詞	\N	\N	\N	120	\N
145	rito	ここで	代名詞	\N	\N	\N	120	\N
30	ang		標識辞	\N	\N	\N	120	\N
146	 nireregaluhan 	プレゼントをもらう	動詞 	\N	\N	\N	120	\N
147	ganoon	あのような	代名詞	\N	\N	\N	121	\N
148	ba	疑問文を作る	代名詞	\N	\N	\N	121	\N
149	nakakahiya	恥ずかしい	形容詞	\N	\N	\N	122	\N
150	 inunahan 	先を超される	動詞	\N	\N	\N	123	\N
33	mo	君/あなた	代名詞	\N	\N	\N	123	\N
17	naman	語調を柔らげる	副詞	\N	\N	\N	123	\N
13	ako	私	代名詞	\N	\N	\N	123	\N
38	eh		感嘆詞	\N	\N	\N	123	\N
22	may	ある	存在を表す小詞	\N	\N	\N	124	\N
151	regalo	プレゼント	名詞	\N	\N	\N	124	\N
42	din	～も	副詞	\N	\N	\N	124	\N
13	ako	私	代名詞	\N	\N	\N	124	\N
5	sa iyo	君に/あなたに	代名詞句	\N	\N	\N	124	\N
129	eto	はい	代名詞	\N	\N	\N	125	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	125	\N
30	ang		標識辞	\N	\N	\N	125	\N
152	rosas	バラ	名詞	\N	\N	\N	125	\N
153	sana	～だといいな	副詞	\N	\N	\N	126	\N
154	 magustuhan 	気に入る	動詞	\N	\N	\N	126	\N
33	mo	君/あなた	代名詞	\N	\N	\N	126	\N
155	gabi	夜	名詞	\N	\N	\N	127	\N
20	na	もう	副詞	\N	\N	\N	127	\N
156	wala	いない	存在を表す小詞	\N	\N	\N	128	\N
126	pa	まだ	副詞	\N	\N	\N	128	\N
157	si	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	128	\N
107	Josie 	ジョシー	固有名詞	\N	\N	\N	128	\N
65	baka	～かもしれない	副詞	\N	\N	\N	129	\N
10	ho	敬意を表す	副詞	\N	\N	\N	129	\N
158	 natrapik	交通渋滞に巻き込まれる	動詞	\N	\N	\N	129	\N
48	siya	彼	代名詞	\N	\N	\N	129	\N
159	 kailangan 	～しなければならない	動詞	\N	\N	\N	130	\N
45	ko	私	代名詞	\N	\N	\N	130	\N
10	ho	敬意を表す	副詞	\N	\N	\N	130	\N
2	-ng		繋辞	\N	\N	\N	130	\N
160	umuwi	家に帰る	動詞	\N	\N	\N	130	\N
161	nang	\n\t\t\t\t\t\t\t	形容詞を副詞にするもの 	\N	\N	\N	130	\N
162	maaga	早く	副詞	\N	\N	\N	130	\N
163	ngayon	今日	副詞	\N	\N	\N	130	\N
107	 sandali na lang 	ちょっと待って 	\n\t\t\t\t\t\t\t	\N	\N	\N	131	\N
63	at	そうすれば	接続詞	\N	\N	\N	131	\N
164	darating	帰ってくる	動詞	\N	\N	\N	131	\N
20	na	もう	副詞	\N	\N	\N	131	\N
48	siya	彼	代名詞	\N	\N	\N	131	\N
162	maaga	早い	形容詞	\N	\N	\N	132	\N
126	pa	まだ	副詞	\N	\N	\N	132	\N
10	ho	敬意を表す	副詞	\N	\N	\N	132	\N
30	ang		標識辞	\N	\N	\N	132	\N
165	 trabaho 	仕事	名詞	\N	\N	\N	132	\N
45	ko	私の	代名詞	\N	\N	\N	132	\N
166	bukas	明日	副詞	\N	\N	\N	132	\N
167	babalik	（戻って）来る	動詞	\N	\N	\N	133	\N
10	ho	敬意を表す	副詞	\N	\N	\N	133	\N
168	uli	また	副詞	\N	\N	\N	133	\N
13	ako	私	代名詞	\N	\N	\N	133	\N
166	bukas	明日	副詞	\N	\N	\N	133	\N
5	bahala ka	お好きなように		\N	\N	\N	134	\N
169	aalis	立ち去る	動詞	\N	\N	\N	135	\N
20	na	もう	副詞	\N	\N	\N	135	\N
10	ho	敬意を表す	副詞	\N	\N	\N	135	\N
13	ako	私	代名詞	\N	\N	\N	135	\N
170	pakisabi	伝えてください	動詞	\N	\N	\N	136	\N
10	ho	敬意を表す	副詞	\N	\N	\N	136	\N
27	ninyo	あなた	代名詞	\N	\N	\N	136	\N
28	kay	～に	標識辞	\N	\N	\N	136	\N
107	Josie 	ジョシー	固有名詞	\N	\N	\N	136	\N
20	na		繋辞	\N	\N	\N	136	\N
164	dumating	来る	動詞	\N	\N	\N	136	\N
13	ako	私	代名詞	\N	\N	\N	136	\N
5	o sige	さようなら	感嘆詞	\N	\N	\N	137	\N
24	mag-ingat	気をつける	動詞	\N	\N	\N	137	\N
16	ka	あなた	代名詞	\N	\N	\N	137	\N
25	ha		感嘆詞	\N	\N	\N	137	\N
171	magkano 	いくら	疑問代名詞	\N	\N	\N	138	\N
10	ho	敬意を表す	副詞	\N	\N	\N	138	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	138	\N
59	isa	１	数詞	\N	\N	\N	138	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	138	\N
172	kilo	キロ	名詞	\N	\N	\N	138	\N
173	mangga	マンゴ	名詞	\N	\N	\N	138	\N
174	 kuwarenta 	４０	数詞	\N	\N	\N	139	\N
175	pesos	ペソ	名詞	\N	\N	\N	139	\N
10	ho	敬意を表す	副詞	\N	\N	\N	139	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	139	\N
59	isa	１	数詞	\N	\N	\N	139	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	139	\N
172	kilo	キロ	名詞	\N	\N	\N	139	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	140	\N
176	mahal	高い	形容詞	\N	\N	\N	140	\N
17	naman	語調を柔らげる	副詞	\N	\N	\N	140	\N
156	wala	ない	非存在を表す小詞	\N	\N	\N	141	\N
10	ho	敬意を表す	副詞	\N	\N	\N	141	\N
148	ba	疑問文を作る	副詞 	\N	\N	\N	141	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	141	\N
177	tawad	値引き	名詞	\N	\N	\N	141	\N
178	mura	安い	形容詞	\N	\N	\N	142	\N
20	na	すでに	副詞	\N	\N	\N	142	\N
10	ho	敬意を表す	副詞	\N	\N	\N	142	\N
179	iyan	それ	代名詞	\N	\N	\N	142	\N
180	 galing 	来る	動詞	\N	\N	\N	143	\N
126	pa	他に	副詞	\N	\N	\N	143	\N
10	ho	敬意を表す	副詞	\N	\N	\N	143	\N
179	iyan	それ	代名詞	\N	\N	\N	143	\N
14	sa	～から	前置詞	\N	\N	\N	143	\N
107	Cebu	セブ	固有名詞	\N	\N	\N	143	\N
181	kaya	だから	接続詞	\N	\N	\N	143	\N
182	masarap	 おいしい	形容詞	\N	\N	\N	143	\N
183	ilan	いくつ	疑問代名詞	\N	\N	\N	144	\N
10	ho	敬意を表す	副詞	\N	\N	\N	144	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	144	\N
184	mayroon	ある	存在を表す小詞	\N	\N	\N	144	\N
14	sa	～で	前置詞	\N	\N	\N	144	\N
59	isa	１	数詞	\N	\N	\N	144	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	144	\N
172	kilo	キロ	名詞	\N	\N	\N	144	\N
143	mga	～ほど/およそ	副詞 	\N	\N	\N	145	\N
185	apat	４つ	数詞	\N	\N	\N	145	\N
10	ho	敬意を表す	副詞	\N	\N	\N	145	\N
73	kung	～ならば	接続詞	\N	\N	\N	145	\N
186	malalaki	大きい	形容詞	\N	\N	\N	145	\N
63	at	そして	接続詞	\N	\N	\N	145	\N
187	lima	５つ	数詞	\N	\N	\N	145	\N
188	maliliit	小さい	形容詞	\N	\N	\N	145	\N
189	 kukunin 	もらう	動詞	\N	\N	\N	146	\N
45	ko	私	代名詞	\N	\N	\N	146	\N
107	na lang	ちょうど	\n\t\t\t\t\t\t\t	\N	\N	\N	146	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	146	\N
190	 kalahati 	半分	名詞	\N	\N	\N	146	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	146	\N
172	kilo	キロ	名詞	\N	\N	\N	146	\N
191	piliin	選ぶ	動詞	\N	\N	\N	147	\N
10	ho	敬意を表す	副詞	\N	\N	\N	147	\N
27	ninyo	あなた	代名詞	\N	\N	\N	147	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	147	\N
192	 magaganda 	美しい 	形容詞	\N	\N	\N	147	\N
193	nakapunta	行ったことがある	動詞	\N	\N	\N	148	\N
16	ka	君/あなた	代名詞	\N	\N	\N	148	\N
20	na	もう	副詞	\N	\N	\N	148	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	148	\N
14	sa	～に	前置詞	\N	\N	\N	148	\N
107	Davao	ダバオ	固有名詞	\N	\N	\N	148	\N
34	oo	ええ/はい	副詞	\N	\N	\N	149	\N
107	 noong isang taon	去年	副詞句 	\N	\N	\N	149	\N
194	 nakaakyat 	登ることができる	動詞	\N	\N	\N	150	\N
36	nga	語調を柔らかくする	副詞	\N	\N	\N	150	\N
13	ako	私	代名詞	\N	\N	\N	150	\N
14	sa	～に	前置詞	\N	\N	\N	150	\N
107	Mt. Apo	アポ山	固有名詞	\N	\N	\N	150	\N
38	eh	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	150	\N
194	 nakaakyat 	登ることができた	動詞	\N	\N	\N	151	\N
16	ka	君/あなた	代名詞	\N	\N	\N	151	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	151	\N
107	hanggang sa	～まで	前置詞句	\N	\N	\N	151	\N
195	tuktok	頂上	名詞	\N	\N	\N	151	\N
57	hindi	いいえ	副詞	\N	\N	\N	152	\N
69	dahil	なぜなら	接続詞	\N	\N	\N	152	\N
196	sumakit	痛む	動詞	\N	\N	\N	152	\N
30	ang		標識辞	\N	\N	\N	152	\N
197	paa	足	名詞	\N	\N	\N	152	\N
45	ko	私の	代名詞	\N	\N	\N	152	\N
38	eh	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	152	\N
110	 nakarating 	行くことができる	動詞	\N	\N	\N	153	\N
16	ka	君/あなた	代名詞	\N	\N	\N	153	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	153	\N
14	sa	～まで	前置詞	\N	\N	\N	153	\N
107	 Samal Island 	サマール島	固有名詞	\N	\N	\N	153	\N
57	hindi	いいえ	副詞	\N	\N	\N	154	\N
127	rin	～も	副詞	\N	\N	\N	154	\N
53	ano	何	疑問代名詞	\N	\N	\N	155	\N
198	lang	～だけ	副詞	\N	\N	\N	155	\N
30	ang		標識辞	\N	\N	\N	155	\N
199	 ginawa 	する	動詞	\N	\N	\N	155	\N
33	mo	君/あなた	代名詞	\N	\N	\N	155	\N
14	sa	～で	前置詞	\N	\N	\N	155	\N
107	Davao	ダバオ	固有名詞	\N	\N	\N	155	\N
200	 nakatikim 	味見する	動詞	\N	\N	\N	156	\N
132	 naman	 語調を柔らげる	 副詞	\N	\N	\N	156	\N
87	 ako	私 	 代名詞	\N	\N	\N	156	\N
201	 ng	\n\t\t\t\t\t\t\t	 標識辞	\N	\N	\N	156	\N
202	 durian	 ドリアン	 名詞	\N	\N	\N	156	\N
203	 at	～と 	 接続詞	\N	\N	\N	156	\N
204	 marang	 マラン	名詞 	\N	\N	\N	156	\N
205	 iyon	 それ	代名詞 	\N	\N	\N	157	\N
206	lang 	～だけ 	 副詞	\N	\N	\N	157	\N
53	ano	何	疑問代名詞	\N	\N	\N	158	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	158	\N
207	balak	計画	名詞	\N	\N	\N	158	\N
33	mo	あなたの	代名詞	\N	\N	\N	158	\N
14	sa	～の 	前置詞	\N	\N	\N	158	\N
107	summer vacation	夏休み	名詞	\N	\N	\N	158	\N
207	balak	計画	名詞	\N	\N	\N	159	\N
45	ko	私の	代名詞	\N	\N	\N	159	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	159	\N
18	pumunta	行く	動詞	\N	\N	\N	159	\N
14	sa	～に	前置詞	\N	\N	\N	159	\N
107	Baguio	バギオ	固有名詞	\N	\N	\N	159	\N
208	masyado	～すぎる	副詞	\N	\N	\N	160	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	160	\N
209	mainit	暑い	形容詞	\N	\N	\N	160	\N
141	dito	ここ	代名詞	\N	\N	\N	160	\N
38	eh	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	160	\N
22	may	ある	存在を表す小詞	\N	\N	\N	161	\N
210	tutuluyan	泊まる	動詞	\N	\N	\N	161	\N
16	ka	あなた	代名詞	\N	\N	\N	161	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	161	\N
14	sa	～で	前置詞	\N	\N	\N	161	\N
107	Baguio	バギオ	固有名詞	\N	\N	\N	161	\N
184	mayroon	ある	存在を表す小詞	\N	\N	\N	162	\N
211	doon	あそこ	代名詞	\N	\N	\N	162	\N
14	sa	～で	前置詞	\N	\N	\N	162	\N
212	bahay	家	名詞	\N	\N	\N	162	\N
50	ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	162	\N
213	kaklase	同級生	名詞	\N	\N	\N	162	\N
45	ko	私の	代名詞	\N	\N	\N	162	\N
3	umaga	朝	名詞	\N	\N	\N	183	\N
107	noong haiskul	高校時代	副詞句	\N	\N	\N	162	\N
53	ano	何	疑問代名詞	\N	\N	\N	163	\N
17	naman	話題を変える	副詞	\N	\N	\N	163	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	163	\N
214	gagawin	する	動詞	\N	\N	\N	163	\N
33	mo	あなた	代名詞	\N	\N	\N	163	\N
14	sa	～で	前置詞	\N	\N	\N	163	\N
107	Baguio	バギオ	固有名詞	\N	\N	\N	163	\N
74	gusto	～したい	動詞	\N	\N	\N	164	\N
45	ko	私	代名詞	\N	\N	\N	164	\N
198	lang	～だけ	副詞	\N	\N	\N	164	\N
215	 magpalamig 	涼む	動詞	\N	\N	\N	164	\N
216	matagal	長い	形容詞	\N	\N	\N	165	\N
20	na	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	165	\N
127	rin	～も	副詞	\N	\N	\N	165	\N
13	ako	私	代名詞	\N	\N	\N	165	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	165	\N
57	hindi	～ない	副詞	\N	\N	\N	165	\N
193	nakapunta	行く	動詞	\N	\N	\N	165	\N
211	doon	あそこ	代名詞	\N	\N	\N	165	\N
217	iba	違う	形容詞	\N	\N	\N	166	\N
20	na	もう	副詞	\N	\N	\N	166	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	166	\N
107	Baguio	バギオ	固有名詞	\N	\N	\N	166	\N
163	ngayon	今	副詞	\N	\N	\N	166	\N
218	nasaan	どこにいる	疑問代名詞	\N	\N	\N	167	\N
10	ho	敬意を表す	副詞	\N	\N	\N	167	\N
68	tayo	私たち	代名詞	\N	\N	\N	167	\N
163	ngayon	今	副詞	\N	\N	\N	167	\N
219	nasa	～にいる	存在を表す小詞	\N	\N	\N	168	\N
5	Bontoc	ボントック	固有名詞	\N	\N	\N	168	\N
20	na	もう	副詞	\N	\N	\N	168	\N
10	ho	敬意を表す	副詞	\N	\N	\N	168	\N
68	tayo	私たち	代名詞	\N	\N	\N	168	\N
5	gaano kalayo	どのくらい遠い	疑問代名詞句	\N	\N	\N	169	\N
126	pa	まだ	副詞	\N	\N	\N	169	\N
10	ho	敬意を表す	副詞	\N	\N	\N	169	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	169	\N
30	ang		標識辞	\N	\N	\N	169	\N
220	mula	～から	前置詞	\N	\N	\N	169	\N
145	rito	ここ	代名詞	\N	\N	\N	169	\N
143	mga	およそ	副詞	\N	\N	\N	170	\N
221	dalawa	２	数詞	\N	\N	\N	170	\N
2	-ng		繋辞	\N	\N	\N	170	\N
222	oras	時間	名詞	\N	\N	\N	170	\N
126	pa	まだ	副詞	\N	\N	\N	170	\N
10	ho	敬意を表す	副詞	\N	\N	\N	170	\N
30	ang		標識辞	\N	\N	\N	171	\N
5	Kalinga	カリンガ	固有名詞	\N	\N	\N	171	\N
10	ho	敬意を表す	副詞	\N	\N	\N	171	\N
223	mas	もっと	副詞	\N	\N	\N	172	\N
224	malayo	遠い	形容詞	\N	\N	\N	172	\N
126	pa	まだ	副詞	\N	\N	\N	172	\N
10	ho	敬意を表す	副詞	\N	\N	\N	172	\N
46	iyon	あれ	代名詞	\N	\N	\N	172	\N
5	kaysa sa	～より	前置詞句	\N	\N	\N	172	\N
225	ganito	このように	代名詞	\N	\N	\N	173	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	173	\N
226	magbiyahe	旅する	動詞	\N	\N	\N	173	\N
141	dito	ここ	代名詞	\N	\N	\N	173	\N
14	sa	～で	前置詞	\N	\N	\N	173	\N
5	Mountain Province	山岳州	固有名詞	\N	\N	\N	173	\N
227	nakakapagod	とても疲れる	形容詞	\N	\N	\N	174	\N
228	hi	やあ	感嘆詞	\N	\N	\N	175	\N
107	 Carol	キャロル	固有名詞	\N	\N	\N	175	\N
39	kumusta	どう？	疑問代名詞	\N	\N	\N	175	\N
30	ang		標識辞	\N	\N	\N	175	\N
229	bakasyon	休み	名詞	\N	\N	\N	175	\N
33	mo	君の/あなたの	代名詞	\N	\N	\N	175	\N
230	masaya	楽しい	形容詞	\N	\N	\N	176	\N
231	 siyempre 	もちろん	副詞	\N	\N	\N	176	\N
232	teka	ちょっと	感嘆詞	\N	\N	\N	177	\N
107	anong oras	何時？	疑問代名詞句	\N	\N	\N	177	\N
20	na	もう	副詞	\N	\N	\N	177	\N
163	ngayon	今	副詞	\N	\N	\N	177	\N
107	 alas nuwebe kinse 	９時１５分	\n\t\t\t\t\t\t\t	\N	\N	\N	178	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	179	\N
22	may	ある	存在を表す小詞	\N	\N	\N	179	\N
234	klase	授業	名詞	\N	\N	\N	179	\N
16	ka	君/あなた	代名詞	\N	\N	\N	179	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	179	\N
34	oo	はい/ええ	副詞	\N	\N	\N	180	\N
22	may	ある	存在を表す小詞	\N	\N	\N	180	\N
234	klase	授業	名詞	\N	\N	\N	180	\N
13	ako	私	代名詞	\N	\N	\N	180	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	180	\N
107	histori	歴史	名詞	\N	\N	\N	180	\N
161	nang	\n\t\t\t\t\t\t\t	形容詞を副詞にするもの	\N	\N	\N	180	\N
22	may	ある	存在を表す小詞	\N	\N	\N	181	\N
234	klase	授業	名詞	\N	\N	\N	181	\N
127	rin	～も	副詞	\N	\N	\N	181	\N
13	ako	私	代名詞	\N	\N	\N	181	\N
235	kanina	さっき	副詞	\N	\N	\N	181	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	181	\N
107	alas siyete	７時	\n\t\t\t\t\t\t\t	\N	\N	\N	181	\N
124	pero	けれど	接続詞	\N	\N	\N	181	\N
198	lang	～だけ	副詞	\N	\N	\N	181	\N
53	amo	何	疑問代名詞	\N	\N	\N	182	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	182	\N
236	 iskedyul 	スケジュール	名詞	\N	\N	\N	182	\N
33	mo	君の/あなたの	代名詞	\N	\N	\N	182	\N
5	ngayong semester	今学期 	副詞句	\N	\N	\N	182	\N
237	pag	～には	接続詞	\N	\N	\N	183	\N
238	 Lunes 	月曜日	名詞	\N	\N	\N	183	\N
63	at	～と	接続詞	\N	\N	\N	183	\N
239	 Huwebes 	木曜日	名詞	\N	\N	\N	183	\N
240	 Pilipino 	フィリピノ語	名詞	\N	\N	\N	183	\N
107	Math	数学	名詞	\N	\N	\N	183	\N
220	mula	～から	前置詞	\N	\N	\N	183	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	183	\N
241	hanggang	～まで	前置詞	\N	\N	\N	183	\N
242	hapon	午後	名詞	\N	\N	\N	183	\N
243	pareho	同じ	形容詞	\N	\N	\N	184	\N
8	pala	軽い驚きを表す	語彙項	\N	\N	\N	184	\N
68	tayo	私たち	代名詞	\N	\N	\N	184	\N
52	o	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	185	\N
244	magkita	会う	動詞	\N	\N	\N	185	\N
68	tayo	私たち	代名詞	\N	\N	\N	185	\N
14	sa	～で	前置詞	\N	\N	\N	185	\N
245	 laybrari 	図書館	名詞	\N	\N	\N	185	\N
246	mamaya	あとで	副詞	\N	\N	\N	185	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	185	\N
107	alas tres	３時	\n\t\t\t\t\t\t\t	\N	\N	\N	185	\N
184	mayroon	いる/ある	存在を表す小詞	\N	\N	\N	186	\N
16	ka	君/あなた	代名詞	\N	\N	\N	186	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	186	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	186	\N
247	kapatid	きょうだい	名詞	\N	\N	\N	186	\N
107	 Margie	マージ	固有名詞	\N	\N	\N	186	\N
184	mayroon	いる/ある	存在を表す小詞	\N	\N	\N	187	\N
13	ako	私	代名詞	\N	\N	\N	187	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	187	\N
59	isa	１	数詞	\N	\N	\N	187	\N
247	kapatid	きょうだい	名詞	\N	\N	\N	187	\N
20	na	 ～の	繋辞	\N	\N	\N	187	\N
248	lalaki	男	名詞	\N	\N	\N	187	\N
139	naku	え	感嘆詞	\N	\N	\N	188	\N
221	dalawa	２	数詞	\N	\N	\N	188	\N
198	lang	～だけ	副詞	\N	\N	\N	188	\N
11	kayo	君たち/あなたたち	代名詞	\N	\N	\N	188	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	190	\N
183	ilan	いくつ	疑問代名詞	\N	\N	\N	190	\N
11	kayo	あなたたち	代名詞	\N	\N	\N	190	\N
249	sampu	１０	数詞	\N	\N	\N	191	\N
250	kami	私たち（相手を含まない）	代名詞 	\N	\N	\N	191	\N
53	ano	何	疑問代名詞	\N	\N	\N	192	\N
249	sampu	１０	数詞	\N	\N	\N	192	\N
183	ilan	いくつ	疑問代名詞	\N	\N	\N	193	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞 	\N	\N	\N	193	\N
248	lalaki	男	名詞	\N	\N	\N	193	\N
63	at	そして	接続詞	\N	\N	\N	193	\N
144	babae	女 	名詞	\N	\N	\N	193	\N
251	anim 	６ 	数詞 	\N	\N	\N	194	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞 	\N	\N	\N	194	\N
248	lalaki	男	名詞	\N	\N	\N	194	\N
63	at	そして	接続詞	\N	\N	\N	194	\N
185	apat	４	数詞	\N	\N	\N	194	\N
144	babae	女 	名詞	\N	\N	\N	194	\N
107	siyanga pala	ところで 	\n\t\t\t\t\t\t\t	\N	\N	\N	195	\N
16	ka	君/あなた 	代名詞 	\N	\N	\N	195	\N
20	na	もう 	代名詞 	\N	\N	\N	195	\N
252	 sikreto 	秘密 	名詞	\N	\N	\N	196	\N
179	iyan	それ	代名詞	\N	\N	\N	196	\N
253	paano	どうやって	疑問代名詞	\N	\N	\N	197	\N
10	ho	敬意を表す	副詞	\N	\N	\N	197	\N
254	magluto	料理する	動詞	\N	\N	\N	197	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	197	\N
255	 sinigang 	シニガンスープ	名詞	\N	\N	\N	197	\N
20	na		繋辞	\N	\N	\N	197	\N
256	baboy	豚（肉）	名詞	\N	\N	\N	197	\N
257	medyo	ちょっと	副詞	\N	\N	\N	198	\N
258	mahirap	難しい	形容詞	\N	\N	\N	198	\N
259	 pakuluan 	煮る	動詞	\N	\N	\N	199	\N
33	mo	あなた	代名詞	\N	\N	\N	199	\N
260	muna	まず	副詞	\N	\N	\N	199	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	199	\N
5	karneng baboy	豚肉	名詞	\N	\N	\N	199	\N
107	hanggang sa	～まで	前置詞句	\N	\N	\N	199	\N
261	 lumambot 	やわらかくなる	動詞	\N	\N	\N	199	\N
262	 lagyan 	入れる	動詞	\N	\N	\N	200	\N
33	mo	あなた	代名詞	\N	\N	\N	200	\N
127	rin	～も	副詞	\N	\N	\N	200	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	200	\N
263	asin	塩	名詞	\N	\N	\N	200	\N
143	mga	およそ 	副詞	\N	\N	\N	201	\N
107	ilang oras	何時間	疑問代名詞句	\N	\N	\N	201	\N
10	ho	敬意を表す	副詞	\N	\N	\N	201	\N
264	iyan	それ	代名詞	\N	\N	\N	201	\N
143	mga	 およそ	副詞	\N	\N	\N	202	\N
59	isa	１	数詞	\N	\N	\N	202	\N
63	at	～と	接続詞	\N	\N	\N	202	\N
190	 kalahati 	半分	名詞	\N	\N	\N	202	\N
2	-ng		繋辞	\N	\N	\N	202	\N
222	oras	時間	名詞	\N	\N	\N	202	\N
265	tapos	それから	接続詞	\N	\N	\N	203	\N
266	 ilagay 	入れる	動詞	\N	\N	\N	203	\N
33	mo	あなた	代名詞	\N	\N	\N	203	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	203	\N
143	mga	複数を表す	標識辞	\N	\N	\N	203	\N
267	gulay	野菜	名詞	\N	\N	\N	203	\N
20	na		繋辞	\N	\N	\N	203	\N
268	nahiwa	切る	動詞	\N	\N	\N	203	\N
53	ano	何	疑問代名詞	\N	\N	\N	204	\N
10	ho	敬意を表す	副詞	\N	\N	\N	204	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	204	\N
269	uunahin	先にする	動詞	\N	\N	\N	204	\N
45	ko	私	代名詞	\N	\N	\N	204	\N
269	unahin	先にしなさい	動詞	\N	\N	\N	205	\N
33	mo	あなた	代名詞	\N	\N	\N	205	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	205	\N
270	labanos	大根	名詞	\N	\N	\N	205	\N
69	dahil	～だから/なぜなら	接続詞	\N	\N	\N	205	\N
216	matagal	時間がかかる	形容詞	\N	\N	\N	205	\N
71	ito	これ	代名詞	\N	\N	\N	205	\N
2	-ng		繋辞	\N	\N	\N	205	\N
271	maluto	煮える	動詞	\N	\N	\N	205	\N
272	 isabay 	同時に入れなさい	動詞	\N	\N	\N	206	\N
33	mo	あなた	代名詞	\N	\N	\N	206	\N
20	na	もう	副詞	\N	\N	\N	206	\N
127	rin	～も	副詞	\N	\N	\N	206	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	206	\N
273	 dinurog 	潰す	動詞	\N	\N	\N	206	\N
274	 sampalok 	サンパロック（木の実）	名詞	\N	\N	\N	206	\N
265	tapos	それから	接続詞	\N	\N	\N	207	\N
10	ho	敬意を表す	副詞	\N	\N	\N	207	\N
275	ihuli	最後にする	動詞	\N	\N	\N	208	\N
33	mo	あなた	代名詞	\N	\N	\N	208	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	208	\N
276	kangkong	空芯菜	名詞	\N	\N	\N	208	\N
277	 timplahan 	味を調える	動詞	\N	\N	\N	209	\N
33	mo	あなた	代名詞	\N	\N	\N	209	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	209	\N
278	patis	パティス	名詞	\N	\N	\N	209	\N
73	kung	～なら	接続詞	\N	\N	\N	209	\N
279	 matabang 	味が薄い	形容詞	\N	\N	\N	209	\N
126	pa	まだ	副詞	\N	\N	\N	209	\N
280	madali	簡単	形容詞	\N	\N	\N	210	\N
198	lang	～だけ 	副詞	\N	\N	\N	210	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	210	\N
107	taga-saan	どこ出身？	\n\t\t\t\t\t\t\t	\N	\N	\N	211	\N
16	ka	あなた	代名詞	\N	\N	\N	211	\N
107	taga-Maynila	マニラ出身	前置詞句	\N	\N	\N	212	\N
13	ako	私	代名詞	\N	\N	\N	212	\N
7	ikaw	君/あなた	代名詞	\N	\N	\N	213	\N
107	taga-Zamboanga	サンボアンガ出身	前置詞句	\N	\N	\N	214	\N
13	ako	私	代名詞	\N	\N	\N	214	\N
281	 marunong 	できる	形容詞	\N	\N	\N	215	\N
16	ka	君/あなた	代名詞	\N	\N	\N	215	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	215	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	215	\N
282	 mag-Chabacano 	チャバカノ語を話す	動詞	\N	\N	\N	215	\N
283	 siyempre	もちろん	副詞	\N	\N	\N	216	\N
123	magaling 	上手だ	形容詞	\N	\N	\N	217	\N
42	din	～も	副詞	\N	\N	\N	217	\N
13	ako	私	代名詞	\N	\N	\N	217	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	217	\N
284	 mag-Cebuano 	セブアノ語を話す	動詞	\N	\N	\N	217	\N
285	talaga	本当	副詞	\N	\N	\N	218	\N
5	ilang wika	いくつの言葉	疑問代名詞句	\N	\N	\N	219	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	219	\N
286	alam	知っている	動詞	\N	\N	\N	219	\N
33	mo	君/あなた	代名詞	\N	\N	\N	219	\N
185	apat	４つ	数詞	\N	\N	\N	220	\N
107	bukod sa	～のほかに	前置詞句	\N	\N	\N	220	\N
287	 Tagalog 	タガログ語	名詞	\N	\N	\N	220	\N
63	at	～と	接続詞	\N	\N	\N	220	\N
288	Ingles	英語	名詞	\N	\N	\N	220	\N
7	ikaw	あなた	代名詞	\N	\N	\N	221	\N
289	Tagalog 	タガログ語	名詞	\N	\N	\N	221	\N
198	lang	～だけ	副詞	\N	\N	\N	221	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	221	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	221	\N
286	alam	知っている	動詞	\N	\N	\N	221	\N
33	mo	あなた	代名詞	\N	\N	\N	221	\N
57	hindi	いいや	副詞	\N	\N	\N	222	\N
290	mahusay	上手だ	形容詞	\N	\N	\N	223	\N
13	ako	私	代名詞	\N	\N	\N	223	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	223	\N
291	 mag-Amoy 	福建語を話す	動詞	\N	\N	\N	223	\N
69	dahil	～だから	接続詞	\N	\N	\N	223	\N
107	 taga-China 	中国出身	前置詞句	\N	\N	\N	223	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	223	\N
292	lolo	祖父	名詞	\N	\N	\N	223	\N
45	ko	私の	代名詞	\N	\N	\N	223	\N
218	nasaan	どこにいる	疑問代名詞	\N	\N	\N	224	\N
157	si	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	224	\N
107	 Nony 	ノニー	固有名詞	\N	\N	\N	224	\N
5	ewan ko	私は知らない		\N	\N	\N	225	\N
293	naroon	あそこにいる	存在を表す小詞	\N	\N	\N	226	\N
294	yata	たぶん	副詞	\N	\N	\N	226	\N
48	siya	彼	代名詞	\N	\N	\N	226	\N
14	sa	～に	前置詞	\N	\N	\N	226	\N
212	bahay	家	名詞	\N	\N	\N	226	\N
295	nina	～たちの	標識辞	\N	\N	\N	226	\N
107	Fe	フェ	固有名詞	\N	\N	\N	226	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	227	\N
48	siya	彼	代名詞	\N	\N	\N	227	\N
293	naroon	あそこにいる	存在を表す小詞	\N	\N	\N	227	\N
296	magnobyo	恋人同士だ	動詞	\N	\N	\N	228	\N
20	na	もう	副詞	\N	\N	\N	228	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	228	\N
297	sila	彼ら	代名詞	\N	\N	\N	228	\N
53	ano	何	疑問代名詞	\N	\N	\N	229	\N
126	pa	他に	副詞	\N	\N	\N	229	\N
232	teka	ちょっと	副詞	\N	\N	\N	230	\N
22	may	いる	存在を表す小詞	\N	\N	\N	230	\N
298	tao	人	名詞	\N	\N	\N	230	\N
294	yata	たぶん	副詞	\N	\N	\N	230	\N
5	sa labas	外に	代名詞	\N	\N	\N	230	\N
21	ah	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	231	\N
65	baka	～かもしれない/たぶん	副詞	\N	\N	\N	231	\N
46	iyon	あれ	代名詞	\N	\N	\N	231	\N
299	-g	\n\t\t\t\t\t\t\t	繋辞の一部	\N	\N	\N	231	\N
300	 naniningil 	料金を集める	動詞	\N	\N	\N	231	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	231	\N
301	 kuryente 	電気	名詞	\N	\N	\N	231	\N
218	nasaan	どこにある	疑問代名詞	\N	\N	\N	232	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	232	\N
302	pitaka	財布	名詞	\N	\N	\N	232	\N
45	ko	私の	代名詞	\N	\N	\N	232	\N
107	 nasa ibabaw ng 	～の上にある	\n\t\t\t\t\t\t\t	\N	\N	\N	233	\N
303	 tokador 	化粧台	名詞	\N	\N	\N	233	\N
304	narito	ここにいる	存在を表す小詞	\N	\N	\N	234	\N
20	na	もう	副詞	\N	\N	\N	234	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	234	\N
157	si	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	234	\N
305	Ate	姉	名詞	\N	\N	\N	234	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	235	\N
306	dami	たくさん	名詞	\N	\N	\N	235	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	235	\N
74	gusto	好き	動詞	\N	\N	\N	257	\N
307	 pasalubong 	お土産	名詞	\N	\N	\N	235	\N
57	hindi	～でない	副詞	\N	\N	\N	236	\N
107	para sa iyo	あなたへのもの/あなたのための	代名詞句	\N	\N	\N	236	\N
71	ito	これ	代名詞	\N	\N	\N	236	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	236	\N
308	kahon	ダンボール箱	名詞	\N	\N	\N	236	\N
25	ha	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	236	\N
107	para kanino	誰へのもの /誰のための	疑問代名詞句 	\N	\N	\N	237	\N
179	iyan	それ	代名詞	\N	\N	\N	237	\N
107	para kina	～たちへのもの/～たちのための	前置詞句	\N	\N	\N	238	\N
309	Tatay	父	名詞	\N	\N	\N	238	\N
63	at	～と	接続詞	\N	\N	\N	238	\N
310	Nanay	母	名詞	\N	\N	\N	238	\N
71	ito	これ	代名詞	\N	\N	\N	238	\N
311	kanino	誰の	疑問代名詞	\N	\N	\N	239	\N
17	naman	話題を変える	副詞	\N	\N	\N	239	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	239	\N
312	bago	新しい	形容詞	\N	\N	\N	239	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	239	\N
313	maleta	スーツケース	名詞	\N	\N	\N	239	\N
71	ito	これ	代名詞	\N	\N	\N	239	\N
107	sa akin	私のもの	代名詞句	\N	\N	\N	240	\N
179	iyan	それ	代名詞	\N	\N	\N	240	\N
314	alin	どれ	疑問代名詞	\N	\N	\N	241	\N
299	-g	\n\t\t\t\t\t\t\t	繋辞の一部	\N	\N	\N	241	\N
307	 pasalubong 	お土産 	名詞	\N	\N	\N	241	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	241	\N
107	para sa akin	私へのもの /私のための	代名詞句	\N	\N	\N	241	\N
56	ay	あら	感嘆詞	\N	\N	\N	242	\N
315	 nakalimutan 	忘れた	動詞	\N	\N	\N	242	\N
45	ko	私	代名詞	\N	\N	\N	242	\N
316	 nagpagupit 	髪の毛を切ってもらう	動詞	\N	\N	\N	243	\N
16	ka	君/あなた	代名詞	\N	\N	\N	243	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	243	\N
34	oo	ええ	副詞	\N	\N	\N	244	\N
317	nagsawa	飽きる	動詞	\N	\N	\N	245	\N
20	na	もう	副詞	\N	\N	\N	245	\N
13	ako	私	代名詞	\N	\N	\N	245	\N
14	sa	～に	前置詞	\N	\N	\N	245	\N
318	mahaba	長い	形容詞	\N	\N	\N	245	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	245	\N
319	buhok	髪の毛	名詞	\N	\N	\N	245	\N
5	sa palagay ko	私は思う		\N	\N	\N	246	\N
223	mas	もっと	副詞	\N	\N	\N	246	\N
320	bagay	似合う	形容詞	\N	\N	\N	246	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	246	\N
318	mahaba	長い	形容詞	\N	\N	\N	246	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	246	\N
319	buhok	髪	名詞	\N	\N	\N	246	\N
147	ganoon	そのような	代名詞	\N	\N	\N	247	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	247	\N
5	akala ko	私は思った		\N	\N	\N	248	\N
321	mukhang	～に見える	副詞	\N	\N	\N	248	\N
322	bumata	若くなる	動詞	\N	\N	\N	248	\N
13	ako	私	代名詞	\N	\N	\N	248	\N
14	sa	～だと	前置詞	\N	\N	\N	248	\N
323	maikli	短い	形容詞	\N	\N	\N	248	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	248	\N
319	buhok	髪	名詞	\N	\N	\N	248	\N
321	mukhang	～に見える	副詞	\N	\N	\N	249	\N
324	elegante	エレガントな	形容詞	\N	\N	\N	249	\N
16	ka	君/あなた	代名詞	\N	\N	\N	249	\N
14	sa	～だと	前置詞	\N	\N	\N	249	\N
318	mahaba	長い	形容詞	\N	\N	\N	249	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	249	\N
319	buhok	髪	名詞	\N	\N	\N	249	\N
134	kasi	～だから/なぜなら	接続詞	\N	\N	\N	249	\N
325	mataba	ふっくらしている/太っている	形容詞	\N	\N	\N	249	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	249	\N
326	mukha	顔	名詞	\N	\N	\N	249	\N
33	mo	君の/あなたの	代名詞	\N	\N	\N	249	\N
258	mahirap	面倒な	形容詞	\N	\N	\N	250	\N
327	mag-ayos	手入れをする/整える	動詞	\N	\N	\N	250	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	250	\N
318	mahaba	長い	形容詞	\N	\N	\N	250	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	250	\N
319	buhok	髪の毛	名詞	\N	\N	\N	250	\N
107	para sa akin	私にとっては	代名詞句	\N	\N	\N	251	\N
328	puwede	まあまあだ	形容詞	\N	\N	\N	251	\N
20	na	もう	副詞	\N	\N	\N	251	\N
71	ito	これ	代名詞	\N	\N	\N	251	\N
107	 Romy	ロミー	固有名詞	\N	\N	\N	252	\N
329	kumain	食べる	動詞	\N	\N	\N	252	\N
16	ka	あなた	代名詞	\N	\N	\N	252	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	252	\N
330	pinakbet	 ピナクベット	名詞	\N	\N	\N	252	\N
22	may	ある	存在を表す小詞	\N	\N	\N	253	\N
331	kasama	伴っている	形容詞	\N	\N	\N	253	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	253	\N
71	ito	これ	代名詞	\N	\N	\N	253	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	253	\N
332	ampalaya	苦瓜	名詞	\N	\N	\N	253	\N
333	siyempre	もちろん	副詞	\N	\N	\N	254	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	255	\N
334	ayaw	嫌いだ	動詞	\N	\N	\N	255	\N
33	mo	あなた	代名詞	\N	\N	\N	255	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	255	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	255	\N
332	ampalaya	苦瓜	名詞	\N	\N	\N	255	\N
107	ayaw na ayaw	大嫌いだ	動詞句	\N	\N	\N	256	\N
45	ko	私	代名詞	\N	\N	\N	256	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	256	\N
332	ampalaya	苦瓜	名詞	\N	\N	\N	256	\N
69	dahil	～だから/なぜなら	接続詞	\N	\N	\N	256	\N
208	masyado	～すぎる	副詞	\N	\N	\N	256	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	256	\N
335	mapait	苦い	形容詞	\N	\N	\N	256	\N
124	pero	でも/しかし	接続詞	\N	\N	\N	257	\N
45	ko	私	代名詞	\N	\N	\N	257	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	257	\N
336	kalabasa	カボチャ	名詞	\N	\N	\N	257	\N
63	at	～と	接続詞	\N	\N	\N	257	\N
337	talong	ナス	名詞	\N	\N	\N	257	\N
338	 ihiwalay 	別にする	動詞	\N	\N	\N	258	\N
33	mo	あなた	代名詞	\N	\N	\N	258	\N
20	na	\n\t\t\t\t\t\t\t	副詞	\N	\N	\N	258	\N
198	lang	～だけ	副詞	\N	\N	\N	258	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	258	\N
332	ampalaya	苦瓜	名詞	\N	\N	\N	258	\N
339	paborito	お気に入りの	形容詞	\N	\N	\N	259	\N
45	ko	私	代名詞	\N	\N	\N	259	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	259	\N
267	gulay	野菜	名詞	\N	\N	\N	259	\N
179	iyan	それ	代名詞	\N	\N	\N	259	\N
38	eh	\n\t\t\t\t\t\t\t	感嘆詞	\N	\N	\N	259	\N
340	nanonood	（映画などを）見る	動詞	\N	\N	\N	260	\N
16	ka	君/あなた	代名詞	\N	\N	\N	260	\N
148	ba	疑問文を作る	副詞	\N	\N	\N	260	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	260	\N
341	 telenobela 	テレビドラマ	名詞	\N	\N	\N	260	\N
57	hindi	～でない	副詞	\N	\N	\N	261	\N
13	ako	私	代名詞	\N	\N	\N	261	\N
342	mahilig	～が好きだ	形容詞	\N	\N	\N	261	\N
343	diyan	それ	前置詞	\N	\N	\N	261	\N
223	mas	ずっと	副詞	\N	\N	\N	262	\N
74	gusto	好む/～したい	動詞	\N	\N	\N	262	\N
45	ko	私	代名詞	\N	\N	\N	262	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	262	\N
340	 manood 	（映画などを）見る	動詞	\N	\N	\N	262	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	262	\N
344	sine	映画	名詞	\N	\N	\N	262	\N
107	o sige	わかった	\n\t\t\t\t\t\t\t	\N	\N	\N	263	\N
73	kung	～ならば 	接続詞 	\N	\N	\N	263	\N
345	libre	時間がある	形容詞	\N	\N	\N	263	\N
16	ka	君/あなた	代名詞	\N	\N	\N	263	\N
246	mamaya	あとで	副詞	\N	\N	\N	263	\N
340	 manood 	（映画などを）見る	動詞	\N	\N	\N	263	\N
68	tayo	私たち	代名詞	\N	\N	\N	263	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	263	\N
344	sine	映画	名詞	\N	\N	\N	263	\N
342	mahilig	～が好きだ	形容詞	\N	\N	\N	264	\N
13	ako	私	代名詞	\N	\N	\N	264	\N
2	-ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	264	\N
340	 manood 	（映画などを）見る	動詞	\N	\N	\N	264	\N
50	ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	264	\N
344	sine	映画	名詞	\N	\N	\N	264	\N
124	pero	でも/しかし	接続詞	\N	\N	\N	264	\N
334	ayaw	～したくない	動詞	\N	\N	\N	264	\N
45	ko	私	代名詞	\N	\N	\N	264	\N
163	ngayon	今日	副詞	\N	\N	\N	264	\N
7	ikaw	あなた	代名詞	\N	\N	\N	265	\N
53	ano	何	疑問代名詞	\N	\N	\N	265	\N
30	ang	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	265	\N
346	hilig	好きなこと	名詞	\N	\N	\N	265	\N
33	mo	あなたの	名詞	\N	\N	\N	265	\N
74	gusto	好む/～したい	動詞	\N	\N	\N	266	\N
45	ko	私	代名詞	\N	\N	\N	266	\N
198	lang	～だけ	副詞	\N	\N	\N	266	\N
347	matulog	寝る	動詞	\N	\N	\N	266	\N
181	kaya	だから	接続詞	\N	\N	\N	267	\N
16	ka	あなた	代名詞	\N	\N	\N	267	\N
8	pala	軽い驚きを表す	副詞	\N	\N	\N	267	\N
325	mataba	太っている	形容詞	\N	\N	\N	267	\N
280	madali	簡単な	形容詞	\N	\N	\N	268	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	268	\N
2	-ng		繋辞	\N	\N	\N	268	\N
348	magtanim	植える	動詞	\N	\N	\N	268	\N
349	 kamoteng-kahoy	カッサバ	名詞	\N	\N	\N	268	\N
34	oo	ええ	副詞	\N	\N	\N	269	\N
280	madali	簡単な	形容詞	\N	\N	\N	269	\N
198	lang	～だけ	副詞	\N	\N	\N	269	\N
53	ano	何	疑問代名詞	\N	\N	\N	270	\N
30	ang		標識辞	\N	\N	\N	270	\N
350	una	最初に	副詞	\N	\N	\N	270	\N
45	ko	（わたし）	代名詞	\N	\N	\N	270	\N
2	-ng		繋辞	\N	\N	\N	270	\N
214	gagawin	する	動詞	\N	\N	\N	270	\N
129	eto	これ	代名詞	\N	\N	\N	271	\N
30	ang		標識辞	\N	\N	\N	271	\N
351	puno	木の幹	名詞	\N	\N	\N	271	\N
50	ng		標識辞	\N	\N	\N	271	\N
349	 kamoteng-kahoy	カッサバ	名詞	\N	\N	\N	271	\N
352	 putulin	切る	動詞	\N	\N	\N	272	\N
33	mo	（あなた）	代名詞	\N	\N	\N	272	\N
30	ang		標識辞	\N	\N	\N	272	\N
353	dulo	端	名詞	\N	\N	\N	272	\N
354	nito	この	代名詞	\N	\N	\N	272	\N
2	-ng		繋辞	\N	\N	\N	272	\N
351	puno	木の幹	名詞	\N	\N	\N	272	\N
225	ganito	こんな風に	代名詞	\N	\N	\N	273	\N
214	gawin	する	動詞	\N	\N	\N	274	\N
33	mo	（あなた）	代名詞	\N	\N	\N	274	\N
2	-ng		繋辞	\N	\N	\N	274	\N
355	matulis	鋭角な	形容詞	\N	\N	\N	274	\N
30	ang		標識辞	\N	\N	\N	274	\N
356	bahagi	部分	名詞	\N	\N	\N	274	\N
357	pinutol	切る、折る	語彙項目の品詞	\N	\N	\N	274	\N
265	tapos	それから	接続詞	\N	\N	\N	275	\N
358	 tanggalin	取り去る	動詞	\N	\N	\N	276	\N
33	mo	あなた	代名詞	\N	\N	\N	276	\N
30	ang		標識辞	\N	\N	\N	276	\N
359	lahat	全部	名詞	\N	\N	\N	276	\N
50	ng		標識辞	\N	\N	\N	276	\N
360	dahon	葉	名詞	\N	\N	\N	276	\N
63	at	そして、～と	接続詞	\N	\N	\N	276	\N
361	itanim	植える	動詞	\N	\N	\N	276	\N
20	na	すでに	副詞	\N	\N	\N	276	\N
14	sa	～に	前置詞	\N	\N	\N	276	\N
362	lupa	土	名詞	\N	\N	\N	276	\N
363	aba	あら	感嘆詞	\N	\N	\N	277	\N
157	si		標識辞	\N	\N	\N	277	\N
5	 Francis	フランシス	固有名詞	\N	\N	\N	277	\N
46	iyon	あれ	代名詞	\N	\N	\N	277	\N
107	 Lorna	ロルナ	固有名詞	\N	\N	\N	278	\N
364	 kumusta ka	元気かい		\N	\N	\N	278	\N
216	matagal	長い間	形容詞	\N	\N	\N	279	\N
20	na	すでに	副詞	\N	\N	\N	279	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	279	\N
2	-ng		繋辞	\N	\N	\N	279	\N
57	hindi	～でない	副詞	\N	\N	\N	279	\N
244	nagkita	会う	動詞	\N	\N	\N	279	\N
21	ah		感嘆詞	\N	\N	\N	279	\N
233	bakit 	なぜ	疑問代名詞	\N	\N	\N	280	\N
16	ka	あなた	代名詞	\N	\N	\N	280	\N
304	narito	ここにいる	小詞	\N	\N	\N	280	\N
14	sa	～に	前置詞	\N	\N	\N	280	\N
365	kasal	結婚式	名詞	\N	\N	\N	280	\N
50	ng		標識辞	\N	\N	\N	280	\N
366	pinsan	いとこ	名詞	\N	\N	\N	280	\N
45	ko	わたしの	代名詞	\N	\N	\N	280	\N
367	inimbita	招待する	動詞	\N	\N	\N	281	\N
13	ako	わたし	代名詞	\N	\N	\N	281	\N
50	ng		標識辞	\N	\N	\N	281	\N
368	 pinsan	いとこ	名詞	\N	\N	\N	281	\N
33	mo	あなたの	代名詞	\N	\N	\N	281	\N
369	isa pa	それに加えて（もうひとつ）	語彙項目の品詞	\N	\N	\N	282	\N
286	alam	わかる	名詞	\N	\N	\N	282	\N
45	ko	（わたし）	代名詞	\N	\N	\N	282	\N
2	-ng		繋辞	\N	\N	\N	282	\N
164	darating	来る	動詞	\N	\N	\N	282	\N
16	ka	君、あなた	代名詞	\N	\N	\N	282	\N
370	huwag	～しないで	副詞	\N	\N	\N	283	\N
33	mo	あなた	代名詞	\N	\N	\N	283	\N
36	nga		副詞	\N	\N	\N	283	\N
13	ako	わたし	代名詞	\N	\N	\N	283	\N
2	-ng		繋辞	\N	\N	\N	283	\N
371	 bolahin	お世辞を言う	動詞	\N	\N	\N	283	\N
128	talaga	本当	副詞	\N	\N	\N	284	\N
372	nami-miss	～がいなくて寂しい	語彙項目の品詞	\N	\N	\N	284	\N
20	na	すでに	副詞	\N	\N	\N	284	\N
373	kita	私はあなた	代名詞	\N	\N	\N	284	\N
22	may	～がある	小詞	\N	\N	\N	285	\N
374	 bagyo	台風	名詞	\N	\N	\N	285	\N
294	yata	たぶん	副詞	\N	\N	\N	285	\N
30	ang		標識辞	\N	\N	\N	286	\N
375	lakas	強い	形容詞	\N	\N	\N	286	\N
50	ng		標識辞	\N	\N	\N	286	\N
376	ulan	雨	名詞	\N	\N	\N	286	\N
377	siguradong	確かに～である	副詞	\N	\N	\N	287	\N
378	babaha	洪水になる	動詞	\N	\N	\N	287	\N
20	na		副詞	\N	\N	\N	287	\N
17	naman		副詞	\N	\N	\N	287	\N
379	sa labas	外で	前置詞句	\N	\N	\N	287	\N
380	 oo nga	そうだね	副詞句	\N	\N	\N	288	\N
237	pag		接続詞	\N	\N	\N	288	\N
22	may	～がある	小詞	\N	\N	\N	288	\N
381	baha	洪水	名詞	\N	\N	\N	288	\N
370	huwag	～するな	副詞	\N	\N	\N	288	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	288	\N
2	-ng		繋辞	\N	\N	\N	288	\N
382	lumabas	外にでる	動詞	\N	\N	\N	288	\N
34	oo	そうね	副詞	\N	\N	\N	289	\N
383	 delikado	危険	形容詞	\N	\N	\N	289	\N
134	kasi	なぜなら	接続詞	\N	\N	\N	289	\N
65	baka	たぶん	副詞	\N	\N	\N	289	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	289	\N
384	mahulog	落ちる	動詞	\N	\N	\N	289	\N
14	sa	～に	前置詞	\N	\N	\N	289	\N
385	manhole	マンホール	名詞	\N	\N	\N	289	\N
386	marumi	汚い	形容詞	\N	\N	\N	290	\N
42	rin	～も	副詞	\N	\N	\N	290	\N
30	ang	語彙項目の文中での意味	標識辞	\N	\N	\N	290	\N
387	tubig	水	名詞	\N	\N	\N	290	\N
181	kaya	だから	接続詞	\N	\N	\N	290	\N
65	baka	（～かもしれない）	副詞	\N	\N	\N	290	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	290	\N
388	 magkasakit	病気になる	動詞	\N	\N	\N	290	\N
153	sana	～だといいのに	副詞	\N	\N	\N	291	\N
389	umaraw	晴れる	動詞	\N	\N	\N	291	\N
17	naman		副詞	\N	\N	\N	291	\N
166	bukas	明日	副詞	\N	\N	\N	291	\N
153	sana	～だといいのに	副詞	\N	\N	\N	292	\N
36	nga		副詞	\N	\N	\N	292	\N
73	kung	もし～なら	接続詞	\N	\N	\N	292	\N
389	aaraw	晴れる	動詞	\N	\N	\N	292	\N
166	bukas	明日	副詞	\N	\N	\N	292	\N
328	puwede	～することができる	動詞	\N	\N	\N	292	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	292	\N
2	-ng		繋辞	\N	\N	\N	292	\N
390	dumalaw	訪ねる	動詞	\N	\N	\N	292	\N
14	sa	～を	前置詞	\N	\N	\N	292	\N
391	lola	祖母	名詞	\N	\N	\N	292	\N
392	 napakalaki	とても大きい	形容詞	\N	\N	\N	293	\N
8	pala		(驚きを表す)副詞	\N	\N	\N	293	\N
50	ng		標識辞	\N	\N	\N	293	\N
393	putok	噴火	名詞	\N	\N	\N	293	\N
5	Pinatubo	ピナツボ山	名詞	\N	\N	\N	293	\N
34	oo	はい	副詞	\N	\N	\N	294	\N
71	ito	これ	代名詞	\N	\N	\N	294	\N
30	ang		標識辞	\N	\N	\N	294	\N
394	 pinakamalaki	最も大きな	形容詞	\N	\N	\N	294	\N
2	-ng		繋辞	\N	\N	\N	294	\N
395	 putok	噴火	名詞	\N	\N	\N	294	\N
50	ng		標識辞	\N	\N	\N	294	\N
396	 bulkan	火山	名詞	\N	\N	\N	294	\N
397	noon	以前	副詞	\N	\N	\N	294	\N
5	 twentieth century	20世紀	名詞	\N	\N	\N	294	\N
41	marami	多くの	形容詞	\N	\N	\N	295	\N
2	-ng		繋辞	\N	\N	\N	295	\N
398	nawalan	失う	動詞	\N	\N	\N	295	\N
50	ng		標識辞	\N	\N	\N	295	\N
212	bahay	家	名詞	\N	\N	\N	295	\N
63	at	～と	接続詞	\N	\N	\N	295	\N
362	lupa	土地	名詞	\N	\N	\N	295	\N
223	mas 	さらに、もっと	副詞	\N	\N	\N	296	\N
186	malaki	大きい	形容詞	\N	\N	\N	296	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	296	\N
399	 ito	これ	代名詞	\N	\N	\N	296	\N
400	 kaysa sa	～より	副詞	\N	\N	\N	296	\N
395	 putok	噴火	名詞	\N	\N	\N	296	\N
50	ng		標識辞	\N	\N	\N	296	\N
401	 Mayon Volcano	マヨン火山	固有名詞	\N	\N	\N	296	\N
397	noon	以前	副詞	\N	\N	\N	296	\N
283	 siyempre	もちろん	副詞	\N	\N	\N	297	\N
402	 umabot	到達する	動詞	\N	\N	\N	297	\N
14	sa	～に	前置詞	\N	\N	\N	297	\N
403	 Maynila	マニラ	固有名詞	\N	\N	\N	297	\N
30	ang		標識辞	\N	\N	\N	297	\N
404	abo	灰	名詞	\N	\N	\N	297	\N
107	nakakatakot	怖ろしい	形容詞	\N	\N	\N	298	\N
8	pala		(驚きを表す)副詞	\N	\N	\N	298	\N
14	sa	～で	前置詞	\N	\N	\N	298	\N
405	 Pilipinas	フィリピン	固有名詞 	\N	\N	\N	298	\N
223	mas 	さらに、もっと	副詞	\N	\N	\N	299	\N
107	nakakatakot	怖ろしい	形容詞	\N	\N	\N	299	\N
14	sa		(場所を表す)前置詞	\N	\N	\N	299	\N
406	 Hapon	日本	固有名詞 	\N	\N	\N	299	\N
400	 kaysa sa	～よりも	副詞	\N	\N	\N	299	\N
405	 Pilipinas	フィリピン	固有名詞 	\N	\N	\N	299	\N
407	 dahil	なぜなら	接続詞	\N	\N	\N	299	\N
41	marami	多くの	形容詞	\N	\N	\N	299	\N
2	-ng		繋辞	\N	\N	\N	299	\N
408	 lindol	地震	名詞	\N	\N	\N	299	\N
409	kukuha	取る	動詞	\N	\N	\N	300	\N
13	ako	（わたし）	代名詞	\N	\N	\N	300	\N
50	ng		標識辞	\N	\N	\N	300	\N
410	Filipino	フィリピノ語	名詞	\N	\N	\N	300	\N
163	ngayon	今	副詞	\N	\N	\N	300	\N
2	-ng		繋辞	\N	\N	\N	300	\N
411	semester	学期	名詞	\N	\N	\N	300	\N
40	mas mabuting	～したほうがよい	形容詞句	\N	\N	\N	301	\N
412	kunin	取る	動詞	\N	\N	\N	301	\N
33	mo	あなた	代名詞	\N	\N	\N	301	\N
30	ang		標識辞	\N	\N	\N	301	\N
234	klase	授業	名詞	\N	\N	\N	301	\N
413	ni		標識辞	\N	\N	\N	301	\N
5	Mister Santos	サントス先生	名詞	\N	\N	\N	301	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	302	\N
414	napili	選択する	動詞	\N	\N	\N	302	\N
45	ko	わたし	代名詞	\N	\N	\N	302	\N
20	na	もう	副詞	\N	\N	\N	302	\N
30	ang		標識辞	\N	\N	\N	302	\N
234	klase	授業	名詞	\N	\N	\N	302	\N
413	ni		標識辞	\N	\N	\N	302	\N
5	Miss Ramos	ラモス先生	名詞	\N	\N	\N	302	\N
139	naku	わぁ	感嘆詞	\N	\N	\N	303	\N
370	huwag	やめとけ	副詞	\N	\N	\N	303	\N
69	dahil	なぜなら	接続詞	\N	\N	\N	303	\N
5	terror	恐ろしい	形容詞	\N	\N	\N	303	\N
48	siya	彼女	代名詞	\N	\N	\N	303	\N
415	halos	ほとんど	副詞	\N	\N	\N	304	\N
156	walang	～がいない	小詞	\N	\N	\N	304	\N
416	pumapasa	合格点をもらう	動詞	\N	\N	\N	304	\N
14	sa	～で	前置詞	\N	\N	\N	304	\N
234	klase	授業	名詞	\N	\N	\N	304	\N
417	taun-taon	毎年	副詞	\N	\N	\N	304	\N
418	akala ko	わたしは思う		\N	\N	\N	305	\N
419	mabait	親切な	形容詞	\N	\N	\N	305	\N
48	siya	彼女	代名詞	\N	\N	\N	305	\N
57	hindi	いいえ	副詞	\N	\N	\N	306	\N
63	at	それに	接続詞	\N	\N	\N	306	\N
41	maraming	たくさん～がある	形容詞	\N	\N	\N	306	\N
42	rin	～も	副詞	\N	\N	\N	306	\N
5	assignments	宿題	名詞	\N	\N	\N	306	\N
14	sa	～で	前置詞	\N	\N	\N	306	\N
234	klase	授業	名詞	\N	\N	\N	306	\N
420	niya	彼女の	代名詞	\N	\N	\N	306	\N
40	mabuti na lang at	～で良かった		\N	\N	\N	307	\N
72	nakita	会う	動詞	\N	\N	\N	307	\N
373	kita	わたしがあなたに	代名詞	\N	\N	\N	307	\N
29	salamat	ありがとう	名詞	\N	\N	\N	307	\N
156	wala	いない	(不在を表す)小詞	\N	\N	\N	308	\N
16	ka	あなた	代名詞	\N	\N	\N	308	\N
294	yata	たぶん	副詞	\N	\N	\N	308	\N
421	kahapon	昨日	副詞	\N	\N	\N	308	\N
14	sa	～に	前置詞	\N	\N	\N	308	\N
234	klase	授業	名詞	\N	\N	\N	308	\N
134	kasi	なぜなら	接続詞	\N	\N	\N	309	\N
422	nasira	壊す	動詞	\N	\N	\N	309	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	309	\N
30	ang		標識辞	\N	\N	\N	309	\N
423	tiyan	お腹	名詞	\N	\N	\N	309	\N
45	ko	わたしの	代名詞	\N	\N	\N	309	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	310	\N
53	ano	何	疑問代名詞	\N	\N	\N	310	\N
30	ang		標識辞	\N	\N	\N	310	\N
424	kinain	食べる	動詞	\N	\N	\N	310	\N
33	mo	あなた	代名詞	\N	\N	\N	310	\N
329	kumain	食べる	動詞	\N	\N	\N	311	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	311	\N
13	ako	わたし	代名詞	\N	\N	\N	311	\N
50	ng		標識辞	\N	\N	\N	311	\N
55	isda	魚	名詞	\N	\N	\N	311	\N
63	at	～と	接続詞	\N	\N	\N	311	\N
425	tahong	ムール貝	名詞	\N	\N	\N	311	\N
377	siguradong	～にちがいない	形容詞	\N	\N	\N	312	\N
422	nasira	壊す	動詞	\N	\N	\N	312	\N
30	ang		標識辞	\N	\N	\N	312	\N
423	tiyan	お腹	名詞	\N	\N	\N	312	\N
33	mo	あなたの	代名詞	\N	\N	\N	312	\N
426	dahil sa~	～が原因である	前置詞句	\N	\N	\N	312	\N
425	tahong	ムール貝	名詞	\N	\N	\N	312	\N
39	kumusta	いかが	疑問代名詞	\N	\N	\N	313	\N
30	ang		標識辞	\N	\N	\N	313	\N
427	pakiramdam	気分	名詞	\N	\N	\N	313	\N
33	mo	あなたの	代名詞	\N	\N	\N	313	\N
163	ngayon	今日	副詞	\N	\N	\N	313	\N
40	mabuti-buti	かなり良い	形容詞	\N	\N	\N	314	\N
20	na	もう	副詞	\N	\N	\N	314	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	314	\N
29	salamat	ありがとう	名詞	\N	\N	\N	314	\N
428	sa susunod	\t次	副詞句	\N	\N	\N	315	\N
24	mag-iingat	気をつける	動詞	\N	\N	\N	315	\N
16	ka	あなた	代名詞	\N	\N	\N	315	\N
14	sa	～に	前置詞	\N	\N	\N	315	\N
429	pagkain	食べ物	名詞	\N	\N	\N	315	\N
5	may sasabihin	話すことがある		\N	\N	\N	316	\N
153	sana	願望を表す	副詞	\N	\N	\N	316	\N
13	ako	わたし	代名詞	\N	\N	\N	316	\N
430	sa iyo	あなたに		\N	\N	\N	316	\N
53	ano	何	疑問代名詞	\N	\N	\N	317	\N
46	iyon	あれ	代名詞	\N	\N	\N	317	\N
431	kinapos	お金が足りない	動詞	\N	\N	\N	318	\N
13	ako	わたし	代名詞	\N	\N	\N	318	\N
432	 ngayong linggong ito	今週	名詞	\N	\N	\N	318	\N
433	 kaya	だから	接続詞	\N	\N	\N	318	\N
434	 puwede	～してもよろしい	動詞	\N	\N	\N	318	\N
79	 ba	疑問文を作る	副詞	\N	\N	\N	318	\N
435	 -ng		繋辞	\N	\N	\N	318	\N
436	 mangutang	(お金を)借りる	動詞	\N	\N	\N	318	\N
430	sa iyo	～に		\N	\N	\N	318	\N
437	 magkano	いくら	疑問代名詞	\N	\N	\N	319	\N
438	 kailangan	必要である	動詞	\N	\N	\N	319	\N
33	mo	あなた	代名詞	\N	\N	\N	319	\N
143	mga	およそ	標識辞	\N	\N	\N	320	\N
5	 tatlong daan	300	数詞	\N	\N	\N	320	\N
439	piso	ペソ	名詞	\N	\N	\N	320	\N
198	lang	～だけ	副詞	\N	\N	\N	320	\N
153	sana		(希望を表す)副詞	\N	\N	\N	320	\N
440	 o sige	いいですよ	感嘆詞句	\N	\N	\N	321	\N
441	 pero	でも、しかし	接続詞	\N	\N	\N	321	\N
434	 puwede	～してもよろしい	動詞	\N	\N	\N	321	\N
79	 ba		疑問代名詞	\N	\N	\N	321	\N
435	 -ng		繋辞	\N	\N	\N	321	\N
442	 ibalik	返す	動詞	\N	\N	\N	321	\N
443	 mo	あなた	代名詞	\N	\N	\N	321	\N
399	 ito	これ	代名詞	\N	\N	\N	321	\N
444	 sa	～に	前置詞	\N	\N	\N	321	\N
445	 katapusan	終わり	名詞	\N	\N	\N	321	\N
201	 ng		標識辞	\N	\N	\N	321	\N
446	 buwan	月	名詞	\N	\N	\N	321	\N
447	 magbabayad	払う	動詞	\N	\N	\N	322	\N
87	 ako	わたし	代名詞	\N	\N	\N	322	\N
201	 ng		標識辞	\N	\N	\N	322	\N
448	 upa	家賃	名詞	\N	\N	\N	322	\N
444	 sa	～に	前置詞	\N	\N	\N	322	\N
5	boarding house	下宿先	名詞	\N	\N	\N	322	\N
449	 ko	わたしの	代名詞	\N	\N	\N	322	\N
450	 eh		感嘆詞	\N	\N	\N	322	\N
156	walang	～がない	小詞	\N	\N	\N	323	\N
451	 problema	問題	名詞	\N	\N	\N	323	\N
452	 siguro	たぶん	副詞	\N	\N	\N	324	\N
453	 mababayaran	払うことができる	動詞	\N	\N	\N	324	\N
20	na	すでに	副詞	\N	\N	\N	324	\N
373	kita	わたしはあなたに	代名詞	\N	\N	\N	324	\N
454	sa isang linggo	来週	副詞	\N	\N	\N	324	\N
305	ate	姉さん	名詞	\N	\N	\N	325	\N
233	bakit	どうして	疑問代名詞	\N	\N	\N	325	\N
156	wala	～がいない	小詞	\N	\N	\N	325	\N
16	ka	あなた	代名詞	\N	\N	\N	325	\N
126	pa	まだ	副詞	\N	\N	\N	325	\N
2	-ng		繋辞	\N	\N	\N	325	\N
5	boyfriend	ボーイフレンド	名詞	\N	\N	\N	325	\N
455	malapit	もうすぐ	形容詞	\N	\N	\N	326	\N
16	ka	あなた	代名詞	\N	\N	\N	326	\N
20	na	すでに	副詞	\N	\N	\N	326	\N
2	-ng		繋辞	\N	\N	\N	326	\N
456	mag-treynta	30歳になる	動詞	\N	\N	\N	326	\N
21	ah		感嘆詞	\N	\N	\N	326	\N
57	hindi	～でない	副詞	\N	\N	\N	327	\N
45	ko	わたし	代名詞	\N	\N	\N	327	\N
126	pa	まだ	副詞	\N	\N	\N	327	\N
457	nakikilala	知り合う	動詞	\N	\N	\N	327	\N
30	ang		標識辞	\N	\N	\N	327	\N
458	type	理想のタイプ	名詞	\N	\N	\N	327	\N
2	-ng		繋辞	\N	\N	\N	327	\N
248	lalaki	男性	名詞	\N	\N	\N	327	\N
53	ano	何	疑問代名詞	\N	\N	\N	328	\N
30	ang		標識辞	\N	\N	\N	328	\N
458	type	（理想の）タイプ	名詞	\N	\N	\N	328	\N
33	mo	あなたの	代名詞	\N	\N	\N	328	\N
459	katulad	似ている	形容詞	\N	\N	\N	329	\N
413	ni		標識辞	\N	\N	\N	329	\N
5	Richard Gomez	リチャード・ゴメス	固有名詞	\N	\N	\N	329	\N
46	iyon		代名詞	\N	\N	\N	329	\N
2	-ng		繋辞	\N	\N	\N	329	\N
460	guwapo	ハンサム	形容詞	\N	\N	\N	329	\N
461	matangkad	背が高い	形容詞	\N	\N	\N	329	\N
63	at	そして	接続詞	\N	\N	\N	329	\N
321	mukhang	～のように見える	副詞	\N	\N	\N	329	\N
419	mabait	人が良い	形容詞	\N	\N	\N	329	\N
208	masyadong	～すぎる	副詞	\N	\N	\N	330	\N
462	mataas	高い	形容詞	\N	\N	\N	330	\N
30	ang		標識辞	\N	\N	\N	330	\N
463	pangarap	理想	名詞	\N	\N	\N	330	\N
33	mo	あなたの	代名詞	\N	\N	\N	330	\N
65	baka	～かもしれない（たぶん）	副詞	\N	\N	\N	331	\N
464	tumanda	年をとる	動詞	\N	\N	\N	331	\N
16	ka	あなた	代名詞	\N	\N	\N	331	\N
2	-ng		標識辞	\N	\N	\N	331	\N
465	dalaga	独身	名詞	\N	\N	\N	331	\N
466	tulad	似ている	形容詞	\N	\N	\N	331	\N
295	nina		標識辞	\N	\N	\N	331	\N
467	tita	おばさん	名詞	\N	\N	\N	331	\N
5	Maria	マリア	固有名詞	\N	\N	\N	331	\N
63	at	～と	接続詞	\N	\N	\N	331	\N
56	ay	あら	感嘆詞	\N	\N	\N	332	\N
334	ayaw	いやである	動詞	\N	\N	\N	332	\N
45	ko	わたし	代名詞	\N	\N	\N	332	\N
468	mamasyal	散策する	動詞	\N	\N	\N	333	\N
260	muna	まず	副詞	\N	\N	\N	333	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	333	\N
141	rito	ここ	副詞	\N	\N	\N	333	\N
14	sa		前置詞	\N	\N	\N	333	\N
5	Chinatown	チャイナタウン	名詞	\N	\N	\N	333	\N
312	bago	～の前	接続詞	\N	\N	\N	333	\N
329	kumain	食べる	動詞	\N	\N	\N	333	\N
469	o sige	いいですよ	感嘆詞	\N	\N	\N	334	\N
470	lalakad	歩く	動詞	\N	\N	\N	334	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	334	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	334	\N
328	puwede	～できる	動詞	\N	\N	\N	335	\N
68	tayo	（わたしたち）	代名詞	\N	\N	\N	335	\N
2	-ng		繋辞	\N	\N	\N	335	\N
470	lumakad	歩く	動詞	\N	\N	\N	335	\N
52	o	（または）	副詞	\N	\N	\N	335	\N
471	sumakay	乗る	動詞	\N	\N	\N	335	\N
73	kung	もし～なら	接続詞	\N	\N	\N	336	\N
471	sasakay	乗る	動詞	\N	\N	\N	336	\N
68	tayo	（わたしたち）	代名詞	\N	\N	\N	336	\N
14	sa	～に	前置詞	\N	\N	\N	336	\N
472	kalesa	馬車	名詞	\N	\N	\N	336	\N
52	o	または	副詞	\N	\N	\N	336	\N
473	traysikel	トライシクル	名詞	\N	\N	\N	336	\N
176	mahal	(値段が)高い	形容詞	\N	\N	\N	337	\N
30	ang		標識辞	\N	\N	\N	337	\N
472	kalesa	馬車	名詞	\N	\N	\N	337	\N
124	pero	でも、しかし	接続詞	\N	\N	\N	337	\N
474	matatanaw	見ることができる	動詞	\N	\N	\N	337	\N
75	natin	わたしたち	代名詞	\N	\N	\N	337	\N
475	tanawin	景色	名詞	\N	\N	\N	337	\N
223	mas	（より～である）	(比較を表す)副詞	\N	\N	\N	338	\N
476	mabilis	早い	形容詞	\N	\N	\N	338	\N
63	at	加えて、それに	接続詞	\N	\N	\N	338	\N
178	mura	安い	形容詞	\N	\N	\N	338	\N
73	kung	（もし）～なら	接続詞	\N	\N	\N	338	\N
471	sasakay	乗る	動詞	\N	\N	\N	338	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	338	\N
50	ng		標識辞	\N	\N	\N	338	\N
473	traysikel	トライシクル	名詞	\N	\N	\N	338	\N
65	baka	たぶん	副詞	\N	\N	\N	339	\N
57	hindi	～でない	副詞	\N	\N	\N	339	\N
68	tayo	（わたしたち）	代名詞	\N	\N	\N	339	\N
5	mag-enjoy	楽しむ	動詞	\N	\N	\N	339	\N
73	kung	（もし）～なら	接続詞	\N	\N	\N	339	\N
14	sa	～で	前置詞	\N	\N	\N	339	\N
473	traysikel	トライシクル	名詞	\N	\N	\N	339	\N
63	at	（そして）	(順接の)接続詞	\N	\N	\N	340	\N
477	masikip	狭い	形容詞	\N	\N	\N	340	\N
36	nga	語調をやわらげる	副詞	\N	\N	\N	340	\N
8	pala	驚きを表す	副詞	\N	\N	\N	340	\N
30	ang		標識辞	\N	\N	\N	340	\N
473	traysikel	トライシクル	名詞	\N	\N	\N	340	\N
478	sige	じゃあ	感嘆詞	\N	\N	\N	341	\N
479	magkalesa	馬車で行く	動詞	\N	\N	\N	341	\N
20	na		副詞	\N	\N	\N	341	\N
198	lang		副詞	\N	\N	\N	341	\N
68	tayo	（わたしたち）	代名詞	\N	\N	\N	341	\N
5	magandang hapon	\tこんにちは		\N	\N	\N	342	\N
4	po		(敬意を表す)副詞	\N	\N	\N	342	\N
52	o	おお	感嘆詞	\N	\N	\N	343	\N
5	Rene	レネ	固有名詞	\N	\N	\N	343	\N
480	napasyal	来る、訪問する	動詞	\N	\N	\N	343	\N
16	ka	（あなた）	代名詞	\N	\N	\N	343	\N
156	wala	いない	(存在を表す)小詞	\N	\N	\N	344	\N
126	pa	まだ	副詞	\N	\N	\N	344	\N
141	rito	（ここ）	副詞	\N	\N	\N	344	\N
157	si		標識辞	\N	\N	\N	344	\N
5	Luz	ルース	固有名詞	\N	\N	\N	344	\N
5	okey lang	かまいません	形容詞句	\N	\N	\N	345	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	345	\N
11	kayo	あなた	代名詞	\N	\N	\N	346	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	346	\N
17	naman		副詞	\N	\N	\N	346	\N
30	ang		標識辞	\N	\N	\N	346	\N
481	sadya	（目的）	名詞	\N	\N	\N	346	\N
45	ko	わたしの	代名詞	\N	\N	\N	346	\N
53	ano	なに	疑問代名詞	\N	\N	\N	347	\N
46	iyon	（あれ）	代名詞	\N	\N	\N	347	\N
482	maaari	～してもよろしい	動詞	\N	\N	\N	348	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	348	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	348	\N
2	-ng		繋辞	\N	\N	\N	348	\N
367	imbitahin	招待する	動詞	\N	\N	\N	348	\N
157	si		標識辞	\N	\N	\N	348	\N
5	Luz	ルース	固有名詞	\N	\N	\N	348	\N
74	gusto	～したい	動詞	\N	\N	\N	349	\N
45	ko	わたし	代名詞	\N	\N	\N	349	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	349	\N
153	sana	（～だといい）	(希望を表す)副詞	\N	\N	\N	349	\N
48	siya	彼女	代名詞	\N	\N	\N	349	\N
2	-ng		繋辞	\N	\N	\N	349	\N
483	maging	～になる	動詞	\N	\N	\N	349	\N
5	partner	パートナー	名詞	\N	\N	\N	349	\N
5	partner	パートナー	名詞	\N	\N	\N	350	\N
14	sa		(場所を表す)前置詞	\N	\N	\N	350	\N
53	ano	なに	疑問代名詞	\N	\N	\N	350	\N
2	-ng		繋辞	\N	\N	\N	350	\N
484	okasyon	（機会）	名詞	\N	\N	\N	350	\N
14	sa		(場所を表す)前置詞	\N	\N	\N	351	\N
5	high school homecoming ball	高校の卒業生たちのために行われるダンスパーティー	名詞	\N	\N	\N	351	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	351	\N
485	namin	（わたしたちの）	代名詞	\N	\N	\N	351	\N
59	isa	1	数詞	\N	\N	\N	351	\N
2	-ng		繋辞	\N	\N	\N	351	\N
486	buwan	月	名詞	\N	\N	\N	351	\N
363	aba	あら	感嘆詞	\N	\N	\N	352	\N
34	oo	いいわよ	副詞	\N	\N	\N	352	\N
46	iyon	それ	代名詞	\N	\N	\N	352	\N
198	lang	～だけ	副詞	\N	\N	\N	352	\N
8	pala		副詞	\N	\N	\N	352	\N
29	salamat	ありがとう	名詞	\N	\N	\N	353	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	353	\N
124	pero	（でも）	接続詞	\N	\N	\N	353	\N
328	puwede	～できる	動詞	\N	\N	\N	353	\N
42	rin	～も	副詞	\N	\N	\N	353	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	353	\N
2	-ng		繋辞	\N	\N	\N	353	\N
487	mahiram	借りる	動詞	\N	\N	\N	353	\N
488	ang		標識辞	\N	\N	\N	353	\N
489	amerikana	スーツ	名詞	\N	\N	\N	353	\N
413	ni		標識辞	\N	\N	\N	353	\N
5	Mang Celso	セルソおじさん	名詞	\N	\N	\N	353	\N
253	paano	どうやって	疑問代名詞	\N	\N	\N	354	\N
16	ka	あなた	代名詞	\N	\N	\N	354	\N
2	-ng		繋辞	\N	\N	\N	354	\N
5	nag-apply	申請する	動詞	\N	\N	\N	354	\N
490	para sa	～するために	前置詞句	\N	\N	\N	354	\N
491	pasaporte	パスポート	名詞	\N	\N	\N	354	\N
33	mo	あなた	代名詞	\N	\N	\N	354	\N
492	kailangan	必要である	動詞	\N	\N	\N	355	\N
45	ko	わたし	代名詞	\N	\N	\N	355	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	355	\N
2	-ng		繋辞	\N	\N	\N	355	\N
5	mag-apply	申請する	動詞	\N	\N	\N	355	\N
34	oo		(肯定を表す)副詞	\N	\N	\N	356	\N
493	para	～のためには	前置詞	\N	\N	\N	356	\N
494	mas mabilis	より早い	形容詞句	\N	\N	\N	356	\N
53	ano	何	疑問代名詞	\N	\N	\N	357	\N
495	pa	（ほかに）	副詞	\N	\N	\N	357	\N
30	ang		標識辞	\N	\N	\N	357	\N
496	dapat	～するべきである	動詞	\N	\N	\N	357	\N
45	ko	わたし	代名詞	\N	\N	\N	357	\N
2	-ng		繋辞	\N	\N	\N	357	\N
214	gawin	する	動詞	\N	\N	\N	357	\N
496	dapat	～するべきである	動詞	\N	\N	\N	358	\N
16	ka	あなた	代名詞	\N	\N	\N	358	\N
2	-ng		繋辞	\N	\N	\N	358	\N
497	magdala	持って行く	動詞	\N	\N	\N	358	\N
50	ng		標識辞	\N	\N	\N	358	\N
5	birth certificate	出生証明書	名詞	\N	\N	\N	358	\N
33	mo	あなた	代名詞	\N	\N	\N	358	\N
63	at	～と	接続詞	\N	\N	\N	358	\N
498	walo	8	数詞	\N	\N	\N	358	\N
499	retrato	写真	名詞	\N	\N	\N	358	\N
14	sa	～に	前置詞	\N	\N	\N	358	\N
53	ano	何	疑問代名詞	\N	\N	\N	359	\N
495	pa	（ほかに）	副詞	\N	\N	\N	359	\N
333	siyempre	もちろん	副詞	\N	\N	\N	360	\N
492	kailangan	必要である	動詞	\N	\N	\N	360	\N
33	mo	あなた	代名詞	\N	\N	\N	360	\N
2	-ng		繋辞	\N	\N	\N	360	\N
5	mag-fill-up	記入する	動詞	\N	\N	\N	360	\N
50	ng		標識辞	\N	\N	\N	360	\N
500	gaano katagal	どの位(時間が)かかる	疑問代名詞句	\N	\N	\N	361	\N
501	makukuha	取ることができる	動詞	\N	\N	\N	361	\N
30	ang		標識辞	\N	\N	\N	361	\N
491	pasaporte	パスポート	名詞	\N	\N	\N	361	\N
45	ko	わたしの	代名詞	\N	\N	\N	361	\N
143	mga	複数を表す	標識辞	\N	\N	\N	362	\N
221	dalawa	2	数詞	\N	\N	\N	362	\N
2	-ng		繋辞	\N	\N	\N	362	\N
432	linggo	週	名詞	\N	\N	\N	362	\N
198	lang		副詞	\N	\N	\N	362	\N
502	bawal	禁止する	動詞	\N	\N	\N	363	\N
503	manigarilyo	タバコを吸う	動詞	\N	\N	\N	363	\N
141	rito	ここ	副詞	\N	\N	\N	363	\N
57	hindi	～でない	(否定を表す)副詞	\N	\N	\N	363	\N
33	mo	あなた	代名詞	\N	\N	\N	363	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	363	\N
286	alam	知っている	動詞	\N	\N	\N	363	\N
25	ha		感嘆詞	\N	\N	\N	364	\N
502	bawal	禁止する	動詞	\N	\N	\N	364	\N
42	rin	～も	副詞	\N	\N	\N	364	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	364	\N
141	rito	ここ	副詞	\N	\N	\N	364	\N
504	akala ko	わたしは思った		\N	\N	\N	365	\N
14	sa		(場所を示す)前置詞	\N	\N	\N	365	\N
505	Singapore	シンガポール	固有名詞	\N	\N	\N	365	\N
198	lang	～だけ	副詞	\N	\N	\N	365	\N
34	oo	ええ	副詞	\N	\N	\N	366	\N
128	talaga	本当に	副詞	\N	\N	\N	366	\N
2	-ng		繋辞	\N	\N	\N	366	\N
502	bawal	禁止する	動詞	\N	\N	\N	366	\N
14	sa		(場所を示す)前置詞	\N	\N	\N	366	\N
5	public	公共の	形容詞	\N	\N	\N	366	\N
506	mahigpit	厳しい	形容詞	\N	\N	\N	367	\N
20	na	すでに	副詞	\N	\N	\N	367	\N
42	rin	～も	副詞	\N	\N	\N	367	\N
141	dito	ここ	副詞	\N	\N	\N	367	\N
139	naku	わぁ	感嘆詞	\N	\N	\N	368	\N
507	mahihirapan	苦労する	動詞	\N	\N	\N	368	\N
13	ako	わたし	代名詞	\N	\N	\N	368	\N
34	oo	ええ	副詞	\N	\N	\N	369	\N
181	kaya	だから	接続詞	\N	\N	\N	369	\N
496	dapat	～するべきである	動詞	\N	\N	\N	369	\N
16	ka	あなた	代名詞	\N	\N	\N	369	\N
20	na		副詞	\N	\N	\N	369	\N
2	-ng		繋辞	\N	\N	\N	369	\N
508	tumigil	やめる	動詞	\N	\N	\N	369	\N
14	sa	～を	前置詞	\N	\N	\N	369	\N
509	paninigarilyo	タバコを吸う	名詞	\N	\N	\N	369	\N
510	sige na nga	わかった		\N	\N	\N	370	\N
511	susubukan	やってみる	動詞	\N	\N	\N	370	\N
45	ko 	（わたし）	代名詞	\N	\N	\N	370	\N
512	mama	男性	名詞	\N	\N	\N	371	\N
2	-ng		繋辞	\N	\N	\N	371	\N
513	drayber	運転手	名詞	\N	\N	\N	371	\N
14	sa	～へ	(場所を示す)前置詞	\N	\N	\N	371	\N
5	U.P.	フィリピン大学	固有名詞	\N	\N	\N	371	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	371	\N
9	saan	どこ	疑問代名詞 	\N	\N	\N	372	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	372	\N
68	tayo	わたしたち	代名詞	\N	\N	\N	372	\N
514	dadaan	通る	動詞	\N	\N	\N	372	\N
515	iwasan	避ける	動詞	\N	\N	\N	373	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	373	\N
75	natin	わたしたち	代名詞	\N	\N	\N	373	\N
30	ang		標識辞	\N	\N	\N	373	\N
5	EDSA	エドサ大通り	固有名詞	\N	\N	\N	373	\N
208	masyado	ひどい、過度の	(程度を表す)副詞	\N	\N	\N	374	\N
2	-ng		繋辞	\N	\N	\N	374	\N
516	matrapik	交通渋滞	形容詞	\N	\N	\N	374	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	374	\N
211	roon	あそこ	副詞	\N	\N	\N	374	\N
517	kakanan	右に曲がる	動詞	\N	\N	\N	375	\N
20	na		副詞	\N	\N	\N	375	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	375	\N
13	ako	わたし	代名詞	\N	\N	\N	375	\N
211	roon	あそこ	副詞	\N	\N	\N	375	\N
14	sa	～で	前置詞	\N	\N	\N	375	\N
518	kanto	角\t	名詞	\N	\N	\N	375	\N
25	ha		感嘆詞	\N	\N	\N	375	\N
519	oho	はい	副詞	\N	\N	\N	376	\N
517	kumanan	曲がる	動詞	\N	\N	\N	377	\N
11	kayo	あなた	代名詞	\N	\N	\N	377	\N
343	riyan	そこ	副詞	\N	\N	\N	377	\N
520	sa susunod na	次の	形容詞句	\N	\N	\N	378	\N
518	kanto	角\t	名詞	\N	\N	\N	378	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	378	\N
521	kumaliwa	左に曲がる	動詞	\N	\N	\N	378	\N
11	kayo	あなた	代名詞	\N	\N	\N	378	\N
63	at	そして	接続詞	\N	\N	\N	378	\N
522	diretso	真っ直ぐ	副詞	\N	\N	\N	378	\N
198	lang	～だけ	副詞	\N	\N	\N	378	\N
9	saan	どこ	疑問代名詞 	\N	\N	\N	379	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	379	\N
148	ba		(疑問を表す)副詞	\N	\N	\N	379	\N
11	kayo	あなた	代名詞	\N	\N	\N	379	\N
14	sa	～へ	(場所を示す)前置詞	\N	\N	\N	379	\N
5	U.P.	フィリピン大学	固有名詞	\N	\N	\N	379	\N
14	sa		(場所を示す)前置詞	\N	\N	\N	380	\N
5	Quezon Hall	ケソンホール	固有名詞	\N	\N	\N	380	\N
10	ho		(敬意を表す)副詞	\N	\N	\N	380	\N
523	pumara	止める	動詞	\N	\N	\N	381	\N
20	na		副詞	\N	\N	\N	381	\N
198	lang		副詞	\N	\N	\N	381	\N
11	kayo	あなた	代名詞	\N	\N	\N	381	\N
524	sa harap ng ~	～の前で	前置詞句	\N	\N	\N	381	\N
525	bilding	建物	名詞	\N	\N	\N	381	\N
107	 Ryan 	ライアン 	固有名詞 	\N	\N	\N	382	\N
526	 pupunta 	行く 	動詞	\N	\N	\N	382	\N
527	 tayo	わたしたち 	代名詞	\N	\N	\N	382	\N
528	sa 	～に 	前置詞 	\N	\N	\N	382	\N
529	 libing 	お葬式 	名詞 	\N	\N	\N	382	\N
530	ng 		標識辞	\N	\N	\N	382	\N
531	 lolo 	祖父	名詞	\N	\N	\N	382	\N
443	 mo	あなたの 	代名詞 	\N	\N	\N	382	\N
121	 ngayon	今日	副詞	\N	\N	\N	382	\N
444	 sa	～へ 	前置詞 	\N	\N	\N	383	\N
532	 sementeryo	墓地 	名詞	\N	\N	\N	383	\N
533	 po		（敬意を表す）副詞 	\N	\N	\N	383	\N
534	ba 		(疑問を表す)副詞 	\N	\N	\N	383	\N
444	 sa	～に 	前置詞 	\N	\N	\N	384	\N
535	 simbahan 	教会	名詞 	\N	\N	\N	384	\N
536	 muna	 まず	副詞	\N	\N	\N	384	\N
537	 huwag	～するな	副詞 	\N	\N	\N	385	\N
538	 ka	あなた 	代名詞 	\N	\N	\N	385	\N
435	-ng 		繋辞 	\N	\N	\N	385	\N
539	 mag-ingay 	うるさくする 	動詞 	\N	\N	\N	385	\N
540	 habang 	～の間 	接続詞	\N	\N	\N	385	\N
541	 may 	～がある	小詞 	\N	\N	\N	385	\N
542	 misa	ミサ 	名詞	\N	\N	\N	385	\N
103	 puwede 	～してもよろしい	動詞	\N	\N	\N	386	\N
78	 po		 (敬意を表す)副詞	\N	\N	\N	386	\N
79	 ba		(疑問を表す)副詞 	\N	\N	\N	386	\N
87	 ako	わたし	代名詞 	\N	\N	\N	386	\N
435	-ng 		繋辞 	\N	\N	\N	386	\N
543	 maglaro 	遊ぶ	動詞	\N	\N	\N	386	\N
544	 pagkatapos ng 	～のあとで	接続詞 	\N	\N	\N	386	\N
542	 misa	ミサ	名詞 	\N	\N	\N	386	\N
109	 hindi 	～でない	(否定を表す)副詞 	\N	\N	\N	387	\N
103	 puwede 	～できる	動詞	\N	\N	\N	387	\N
203	 at	それに 	接続詞 	\N	\N	\N	387	\N
537	 huwag	～するな	副詞 	\N	\N	\N	387	\N
538	 ka	あなた	代名詞 	\N	\N	\N	387	\N
545	 rin	～も 	副詞 	\N	\N	\N	387	\N
435	 -g		繋辞の一部	\N	\N	\N	387	\N
546	 lumayo 	離れる	動詞 	\N	\N	\N	387	\N
547	 sa akin	わたしから	代名詞	\N	\N	\N	387	\N
548	 akin	わたし	代名詞	\N	\N	\N	387	\N
544	 pagkatapos ng 	～のあとで	接続詞 	\N	\N	\N	388	\N
542	 misa	ミサ	名詞 	\N	\N	\N	388	\N
549	 didiretso 	真っ直ぐ行く	動詞	\N	\N	\N	388	\N
78	 po		 (敬意を表す)副詞	\N	\N	\N	388	\N
79	 ba		(疑問を表す)副詞 	\N	\N	\N	388	\N
550	 tayo	わたしたち 	代名詞 	\N	\N	\N	388	\N
444	 sa		前置詞	\N	\N	\N	388	\N
551	 sementeryo 	教会 	名詞 	\N	\N	\N	388	\N
552	 oo		感嘆詞 	\N	\N	\N	389	\N
99	 at		接続詞 	\N	\N	\N	389	\N
537	 huwag	～するな	副詞 	\N	\N	\N	389	\N
538	 ka	あなた 	代名詞 	\N	\N	\N	389	\N
435	-ng 	\n\t\t\t\t\t\t\t	繋辞 	\N	\N	\N	389	\N
553	 masyado	過度の	(程度を表す)副詞 	\N	\N	\N	389	\N
554	 matanong 	質問が多い	形容詞	\N	\N	\N	389	\N
555	 tayo na 	さあ行きましょう 		\N	\N	\N	390	\N
5	 Hiro 	ヒロ 	固有名詞 	\N	\N	\N	391	\N
556	 mabuti at ~ 	～でよかった 		\N	\N	\N	391	\N
110	 nakarating 	来ることができる 	動詞 	\N	\N	\N	391	\N
557	ka 	あなた 	代名詞 	\N	\N	\N	391	\N
558	sa amin	わたしたちのところ 	前置詞句 	\N	\N	\N	391	\N
559	 maligaya	楽しい	形容詞	\N	\N	\N	392	\N
435	 -ng		繋辞 	\N	\N	\N	392	\N
560	 Pasko	クリスマス 	名詞 	\N	\N	\N	392	\N
10	ho	敬意を表す 	副詞 	\N	\N	\N	392	\N
107	 Mrs. Rosales 	ロサレス夫人	固有名詞	\N	\N	\N	392	\N
561	 pasok	中に入る	動詞 	\N	\N	\N	393	\N
538	 ka	あなた	代名詞 	\N	\N	\N	393	\N
109	 hindi 	～でない	(否定を表す)副詞 	\N	\N	\N	394	\N
443	 mo	あなた	代名詞 	\N	\N	\N	394	\N
159	 kailangan 	必要である 	動詞 	\N	\N	\N	394	\N
562	-g 		繋辞の一部 	\N	\N	\N	394	\N
563	 hubarin 	脱ぐ 	動詞	\N	\N	\N	394	\N
82	 ang 		標識辞	\N	\N	\N	394	\N
564	 sapatos 	靴 	名詞 	\N	\N	\N	394	\N
565	 pagpasensiyahan 	申し訳ないと思う 	動詞	\N	\N	\N	395	\N
78	 po		（敬意を表す）副詞 	\N	\N	\N	395	\N
92	 ninyo 	あなた 	代名詞 	\N	\N	\N	395	\N
71	ito	これ 	代名詞 	\N	\N	\N	395	\N
562	 -ng	語彙項目の文中での意味 	繋辞 	\N	\N	\N	395	\N
566	 regalo 	プレゼント 	名詞 	\N	\N	\N	395	\N
45	ko	わたしの	代名詞 	\N	\N	\N	395	\N
567	 naku 	まあ	感嘆詞 	\N	\N	\N	396	\N
568	 nag-abala 	気を使う 	動詞 	\N	\N	\N	396	\N
538	 ka	あなた 	代名詞 	\N	\N	\N	396	\N
495	 pa	\n\t\t\t\t\t\t\t	副詞 	\N	\N	\N	396	\N
109	 hindi 	～でない	（否定を表す）副詞 	\N	\N	\N	397	\N
538	 ka	あなた 	代名詞 	\N	\N	\N	397	\N
569	 na	語彙項目の文中での意味	副詞 	\N	\N	\N	397	\N
570	 dapat 	～しなければならない 	動詞 	\N	\N	\N	397	\N
571	 nagdala 	 もってくる	動詞	\N	\N	\N	397	\N
201	 ng	語彙項目の文中での意味 	標識辞	\N	\N	\N	397	\N
572	 regalo 	プレゼント	名詞 	\N	\N	\N	397	\N
180	 galing 	（～から）来る 	動詞	\N	\N	\N	398	\N
573	 ho		副詞	\N	\N	\N	398	\N
574	 sa	～から	前置詞	\N	\N	\N	398	\N
5	 Kyoto 	京都	名詞	\N	\N	\N	398	\N
108	 ito	これ	代名詞	\N	\N	\N	398	\N
575	 ipinadala 	送ってくる 	動詞	\N	\N	\N	398	\N
201	 ng		標識辞	\N	\N	\N	398	\N
576	 nanay	母	名詞	\N	\N	\N	398	\N
449	 ko	わたしの 	代名詞	\N	\N	\N	398	\N
577	 ang		標識辞	\N	\N	\N	399	\N
578	 ganda 	美しさ	名詞 	\N	\N	\N	399	\N
96	 maraming salamat 	どうもありがとう 		\N	\N	\N	400	\N
579	 pakisabi 	伝えてください	動詞	\N	\N	\N	401	\N
569	 na		副詞	\N	\N	\N	401	\N
580	 rin	（～も） 	副詞	\N	\N	\N	401	\N
435	-g 	\n\t\t\t\t\t\t\t	繋辞の一部	\N	\N	\N	401	\N
96	 salamat 	 ありがとう	名詞	\N	\N	\N	401	\N
444	 sa 		前置詞	\N	\N	\N	401	\N
576	 nanay 	母 	名詞	\N	\N	\N	401	\N
443	 mo	あなたの 	代名詞	\N	\N	\N	401	\N
581	 balita ko 	わたしは聞いた 		\N	\N	\N	402	\N
582	 piyesta 	お祭り 	名詞 	\N	\N	\N	402	\N
583	 raw 	 ～だそうだ	(伝聞を表す)副詞 	\N	\N	\N	402	\N
528	sa 	～で 	(場所を表す)前置詞 	\N	\N	\N	402	\N
584	 bayan 	町 	名詞 	\N	\N	\N	402	\N
92	 ninyo 	あなたたちの 	代名詞 	\N	\N	\N	402	\N
585	 Linggo 	日曜日 	名詞 	\N	\N	\N	402	\N
586	oo 	はい 	副詞 	\N	\N	\N	403	\N
587	 pumasyal	遊びに行く 	動詞	\N	\N	\N	403	\N
16	ka	あなた	代名詞	\N	\N	\N	403	\N
528	sa	～に 	（場所を表す）前置詞	\N	\N	\N	403	\N
588	 bahay 	家 	名詞 	\N	\N	\N	403	\N
118	 namin 	わたしたちの 	代名詞	\N	\N	\N	403	\N
589	 isama 	連れる 	動詞	\N	\N	\N	404	\N
111	 mo	あなた 	代名詞	\N	\N	\N	404	\N
580	 rin	～も 	副詞	\N	\N	\N	404	\N
82	 ang		標識辞	\N	\N	\N	404	\N
86	 ate 	お姉さん 	名詞	\N	\N	\N	404	\N
443	 mo	あなた 	代名詞 	\N	\N	\N	404	\N
590	 kung	もし～なら 	接続詞	\N	\N	\N	404	\N
591	 libre	時間がある 	形容詞 	\N	\N	\N	404	\N
592	 siya	彼女	代名詞 	\N	\N	\N	404	\N
593	 sige 	わかった	感嘆詞 	\N	\N	\N	405	\N
594	 tatanugin 	質問する 	動詞	\N	\N	\N	405	\N
595	 ko 	 わたし	代名詞	\N	\N	\N	405	\N
596	siya	彼女 	代名詞	\N	\N	\N	405	\N
597	 ano 	何	疑問代名詞 	\N	\N	\N	406	\N
598	 ang 		標識辞 	\N	\N	\N	406	\N
599	 handa\t	ごちそう	名詞 	\N	\N	\N	406	\N
92	 ninyo 	 あなたたち	代名詞 	\N	\N	\N	406	\N
600	 marami 	たくさん	形容詞 	\N	\N	\N	407	\N
562	 -ng	\n\t\t\t\t\t\t\t	繋辞	\N	\N	\N	407	\N
5	 seafood  	 シーフード	名詞	\N	\N	\N	407	\N
601	at 	～と	接続詞 	\N	\N	\N	407	\N
541	 may 	～がある	小詞	\N	\N	\N	407	\N
580	 din	～も 	副詞	\N	\N	\N	407	\N
602	 ano	何	疑問代名詞 	\N	\N	\N	408	\N
603	pala 	驚きを表す	副詞 	\N	\N	\N	408	\N
577	 ang		標識辞 	\N	\N	\N	408	\N
604	 paborito 	好きな	形容詞	\N	\N	\N	408	\N
435	 -ng		繋辞 	\N	\N	\N	408	\N
605	 pagkain 	食べ物	名詞 	\N	\N	\N	408	\N
201	 ng		標識辞 	\N	\N	\N	408	\N
606	 ate	姉	名詞 	\N	\N	\N	408	\N
111	 mo	あなたの 	代名詞	\N	\N	\N	408	\N
607	 mahilig	～が好きである	形容詞 	\N	\N	\N	409	\N
608	 siya 	彼女 	代名詞	\N	\N	\N	409	\N
528	 sa 		前置詞 	\N	\N	\N	409	\N
609	 halaya	ハラヤ 	名詞	\N	\N	\N	409	\N
147	 ganoon	そんなふうな	副詞	\N	\N	\N	410	\N
534	 ba		(疑問を表す)副詞	\N	\N	\N	410	\N
510	 sige	（それでは）	感嘆詞	\N	\N	\N	411	\N
610	 ipapagawa 	作ってもらう 	動詞	\N	\N	\N	411	\N
101	 ko	わたし 	代名詞	\N	\N	\N	411	\N
611	 iyan	それ 	代名詞	\N	\N	\N	411	\N
574	 sa 	～に	前置詞	\N	\N	\N	411	\N
576	 nanay 	母 	名詞	\N	\N	\N	411	\N
449	 ko	わたしの 	代名詞	\N	\N	\N	411	\N
5	 Rolly 	ロリー 	固有名詞 	\N	\N	\N	412	\N
612	 mukhang 	 ～みたいだ	副詞	\N	\N	\N	412	\N
613	 may 	～がある 	(存在を表す)小詞 	\N	\N	\N	412	\N
614	 problema 	問題 	名詞	\N	\N	\N	412	\N
557	ka 	あなた 	代名詞 	\N	\N	\N	412	\N
615	ah 		感嘆詞 	\N	\N	\N	412	\N
616	 mayroon 	ある 	（存在を表す）小詞 	\N	\N	\N	413	\N
617	 nga		副詞 	\N	\N	\N	413	\N
618	ho 	敬意を表す	副詞 	\N	\N	\N	413	\N
619	 tungkol sa 	～について 	前置詞句 	\N	\N	\N	414	\N
573	 ho	敬意を表す	副詞 	\N	\N	\N	414	\N
620	 isa 	1	数詞 	\N	\N	\N	414	\N
562	-ng 	語彙項目の文中での意味 	繋辞 	\N	\N	\N	414	\N
621	 babae	女性	名詞 	\N	\N	\N	414	\N
622	 bakit  		疑問代名詞	\N	\N	\N	415	\N
602	 ano		疑問代名詞	\N	\N	\N	415	\N
623	ang 	語彙項目の文中での意味	標識辞 	\N	\N	\N	415	\N
624	 nangyayari 	起こる 	動詞 	\N	\N	\N	415	\N
430	sa iyo	あなたに 	代名詞	\N	\N	\N	415	\N
613	 may 	～がある、～がいる	(存在を表す)小詞 	\N	\N	\N	416	\N
625	 nagustuhan 	気に入る 	動詞 	\N	\N	\N	416	\N
573	 ho	敬意を表す	副詞 	\N	\N	\N	416	\N
87	 ako	わたし 	代名詞 	\N	\N	\N	416	\N
435	 -ng		繋辞	\N	\N	\N	416	\N
626	 isa 	1	形容詞 	\N	\N	\N	416	\N
627	 Haponesa 	日本の女性 	名詞 	\N	\N	\N	416	\N
628	pero    	しかし	接続詞	\N	\N	\N	416	\N
629	may 	～がいる 	（存在を表す）小詞	\N	\N	\N	416	\N
5	boyfriend 	ボーイフレンド	名詞	\N	\N	\N	416	\N
630	na	もう、すでに 	副詞 	\N	\N	\N	416	\N
596	siya  	彼女	代名詞	\N	\N	\N	416	\N
631	 mahirap  	難しい	形容詞	\N	\N	\N	417	\N
569	 na		繋辞 	\N	\N	\N	417	\N
451	 problema	問題 	名詞 	\N	\N	\N	417	\N
179	iyan	それ	代名詞 	\N	\N	\N	417	\N
602	 ano	何 	疑問代名詞 	\N	\N	\N	418	\N
10	ho 		副詞	\N	\N	\N	418	\N
30	ang 		標識辞 	\N	\N	\N	418	\N
632	 mabuti 	よい 	形容詞	\N	\N	\N	418	\N
45	ko 	わたし 	副詞 	\N	\N	\N	418	\N
2	-ng 	語彙項目の文中での意味	繋辞 	\N	\N	\N	418	\N
633	 gawin 	する 	動詞	\N	\N	\N	418	\N
634	 mamili 	選ぶ 	動詞 	\N	\N	\N	419	\N
98	 ka	あなた	代名詞	\N	\N	\N	419	\N
399	 sa mga ito	これらの中から	 前置詞句	\N	\N	\N	419	\N
635	 una 	1番目	序数	\N	\N	\N	420	\N
636	 matulog 	寝る	動詞 	\N	\N	\N	420	\N
538	 ka	あなた 	代名詞 	\N	\N	\N	420	\N
637	 muna	まず 	副詞	\N	\N	\N	420	\N
638	 pangalawa	2番目 	序数	\N	\N	\N	421	\N
639	 mag-isip 	よく考える 	動詞 	\N	\N	\N	421	\N
538	 ka	あなた 	代名詞 	\N	\N	\N	421	\N
40	 ng mabuti	しっかりと	副詞	\N	\N	\N	421	\N
640	 pangatlo 	3番目 	序数	\N	\N	\N	422	\N
641	 kalimutan 	忘れる	動詞 	\N	\N	\N	422	\N
443	 mo	あなた 	代名詞 	\N	\N	\N	422	\N
608	 siya 	彼女	代名詞	\N	\N	\N	422	\N
613	 may	～がある 	（存在を表す）小詞 	\N	\N	\N	423	\N
642	 mga		（複数を表す）標識辞	\N	\N	\N	423	\N
5	 ready-made 	既製の	形容詞	\N	\N	\N	423	\N
569	 na		繋辞	\N	\N	\N	423	\N
643	 barong Tagalog 	 バロンタガログ	名詞	\N	\N	\N	423	\N
79	 ba	疑問文を作る	副詞 	\N	\N	\N	423	\N
644	 kayo	 あなた	代名詞 	\N	\N	\N	423	\N
645	 wala	ない 	（存在を表す）小詞 	\N	\N	\N	424	\N
573	 ho	敬意を表す	副詞	\N	\N	\N	424	\N
121	 ngayon 	今日	副詞	\N	\N	\N	424	\N
646	 gusto 	～したい 	動詞	\N	\N	\N	425	\N
449	 ko 	わたし 	代名詞	\N	\N	\N	425	\N
573	 ho 		副詞	\N	\N	\N	425	\N
435	-ng 		繋辞	\N	\N	\N	425	\N
647	 magpatahi	縫ってもらう	動詞	\N	\N	\N	425	\N
201	 ng	\n\t\t\t\t\t\t\t	標識辞	\N	\N	\N	425	\N
648	 barong Tagalog	バロンタガログ 	動詞	\N	\N	\N	425	\N
569	 na		繋辞	\N	\N	\N	425	\N
5	 jusi  	バナナ繊維	名詞	\N	\N	\N	425	\N
649	 para sa~ 	～のための	前置詞句 	\N	\N	\N	426	\N
573	 ho	敬意を表す	副詞	\N	\N	\N	426	\N
79	 ba	疑問を表す	副詞	\N	\N	\N	426	\N
650	 inyo	あなた 	代名詞	\N	\N	\N	426	\N
651	 para sa~ 	～のための	前置詞句 	\N	\N	\N	427	\N
573	 ho 	敬意を表す	副詞	\N	\N	\N	427	\N
652	 asawa 	夫	名詞	\N	\N	\N	427	\N
449	 ko	わたしの	代名詞	\N	\N	\N	427	\N
653	 gusto 	好きだ	動詞	\N	\N	\N	428	\N
449	 ko	わたし	代名詞	\N	\N	\N	428	\N
573	 ho 	敬意を表す	副詞	\N	\N	\N	428	\N
201	 ng		標識辞 	\N	\N	\N	428	\N
654	 hindi		（否定を表す）副詞 	\N	\N	\N	428	\N
553	 masyado 	あまりにも	副詞	\N	\N	\N	428	\N
435	-ng 		繋辞	\N	\N	\N	428	\N
655	 malaki 	大きい 	形容詞	\N	\N	\N	428	\N
82	 ang 		標識辞	\N	\N	\N	428	\N
656	 burda	刺繍 	名詞	\N	\N	\N	428	\N
657	 pahingi 	～を下さい	動詞	\N	\N	\N	429	\N
573	 ho 	敬意を表す	副詞	\N	\N	\N	429	\N
201	ng		標識辞	\N	\N	\N	429	\N
107	size	サイズ 	名詞	\N	\N	\N	429	\N
652	 asawa 	夫	名詞	\N	\N	\N	429	\N
92	 ninyo	あなたの 	代名詞	\N	\N	\N	429	\N
658	 habaan 	長くする	動詞	\N	\N	\N	430	\N
92	 ninyo\t	あなた 	代名詞 	\N	\N	\N	430	\N
577	ang		標識辞	\N	\N	\N	430	\N
659	 manggas 	袖	名詞	\N	\N	\N	430	\N
114	 kasi 	なぜなら 	接続詞 	\N	\N	\N	430	\N
660	 mahaba 	長い 	形容詞	\N	\N	\N	430	\N
82	 ang 		標識辞 	\N	\N	\N	430	\N
661	 braso	腕	名詞 	\N	\N	\N	430	\N
89	 niya 	彼の 	代名詞	\N	\N	\N	430	\N
526	 pupunta 	行く 	動詞	\N	\N	\N	431	\N
662	 kami	私たち	代名詞	\N	\N	\N	431	\N
444	 sa	～へ	代名詞	\N	\N	\N	431	\N
5	 San Pablo 	サンパブロ	名詞	\N	\N	\N	431	\N
663	 Mahal na Araw	聖週間	名詞	\N	\N	\N	431	\N
664	gusto 	～したい	動詞	\N	\N	\N	432	\N
665	mo 	あなた	代名詞	\N	\N	\N	432	\N
148	ba 		（疑問を表す）副詞	\N	\N	\N	432	\N
2	-ng		繋辞	\N	\N	\N	432	\N
666	 sumama 	一緒に行く	動詞	\N	\N	\N	432	\N
667	 sa amin	わたしたち	前置詞	\N	\N	\N	432	\N
590	 kung	もし～なら 	接続詞	\N	\N	\N	433	\N
109	 hindi 	～でない	（否定を表す）副詞	\N	\N	\N	433	\N
668	 abala 	迷惑な	形容詞	\N	\N	\N	433	\N
669	 sa inyo	～あなた方に	前置詞	\N	\N	\N	433	\N
670	 gusto 	～したい	動詞	\N	\N	\N	433	\N
101	 ko 	わたし	代名詞	\N	\N	\N	433	\N
105	-ng 		繋辞 	\N	\N	\N	433	\N
671	 sumama 	一緒に行く	動詞	\N	\N	\N	433	\N
192	 maganda 	きれいな 	形容詞	\N	\N	\N	434	\N
672	 raw	～だそうだ	（伝聞を表す）副詞 	\N	\N	\N	434	\N
577	 ang 		標識辞	\N	\N	\N	434	\N
673	 prusisyon	宗教的なパレード 	名詞 	\N	\N	\N	434	\N
655	 malaki	大きい 	形容詞	\N	\N	\N	435	\N
545	 rin	～も	副詞	\N	\N	\N	435	\N
672	 daw	～だそうだ 	（伝聞を表す）副詞	\N	\N	\N	435	\N
577	 ang		標識辞	\N	\N	\N	435	\N
674	 mga 		（複数を表す）標識辞	\N	\N	\N	435	\N
675	 santo 	聖像	名詞	\N	\N	\N	435	\N
574	 sa 	\n\t\t\t\t\t\t\t	前置詞	\N	\N	\N	435	\N
676	 karosa 	山車	名詞	\N	\N	\N	435	\N
670	 gusto 	～したい 	動詞	\N	\N	\N	436	\N
101	 ko	わたし	代名詞	\N	\N	\N	436	\N
435	 -ng		繋辞	\N	\N	\N	436	\N
677	 sumali 	参加する 	動詞	\N	\N	\N	436	\N
444	 sa	～に 	前置詞	\N	\N	\N	436	\N
678	 prusisyon 	宗教的なパレード 	名詞	\N	\N	\N	436	\N
103	 puwede 	できる 	動詞	\N	\N	\N	437	\N
590	 kung 	もし～なら 	接続詞	\N	\N	\N	438	\N
653	 gusto	望む	動詞	\N	\N	\N	438	\N
443	 mo	あなた	代名詞	\N	\N	\N	438	\N
434	 puwede 	できる	動詞	\N	\N	\N	438	\N
538	 ka	あなた	代名詞	\N	\N	\N	438	\N
679	 rin	～も	副詞	\N	\N	\N	438	\N
562	-g 		繋辞の一部	\N	\N	\N	438	\N
680	 humila 	引く	動詞	\N	\N	\N	438	\N
201	 ng		標識辞	\N	\N	\N	438	\N
681	 karosa 	山車	名詞	\N	\N	\N	438	\N
682	 siyanga pala	ところで	感嘆詞	\N	\N	\N	439	\N
683	 dumating 	来る	動詞	\N	\N	\N	439	\N
684	 mula sa	から来る	前置詞句	\N	\N	\N	439	\N
685	 Iloilo	イロイロ市	固有名詞	\N	\N	\N	439	\N
577	 ang		標識辞	\N	\N	\N	439	\N
686	 kababata 	幼友達 	名詞	\N	\N	\N	439	\N
449	 ko 	私の	代名詞	\N	\N	\N	439	\N
687	 maganda 	美しい	形容詞	\N	\N	\N	440	\N
79	 ba 	疑問文を作る	副詞	\N	\N	\N	440	\N
592	 siya 	彼女	代名詞	\N	\N	\N	440	\N
552	 oo	ええ	副詞	\N	\N	\N	441	\N
688	 naging	～になる	動詞	\N	\N	\N	441	\N
689	 reyna	女王	名詞	\N	\N	\N	441	\N
592	 siya	彼女	代名詞	\N	\N	\N	441	\N
444	 sa	～で	前置詞	\N	\N	\N	441	\N
582	 piyesta	お祭り	名詞	\N	\N	\N	441	\N
690	 noon	以前	副詞	\N	\N	\N	441	\N
691	 totoo	本当に	形容詞	\N	\N	\N	442	\N
692	 dalaga	独身の女性	名詞	\N	\N	\N	443	\N
495	 pa	まだ	副詞	\N	\N	\N	443	\N
79	 ba		（疑問を表す）副詞	\N	\N	\N	443	\N
592	 siya	彼女	（疑問を表す）副詞	\N	\N	\N	443	\N
693	 oo	ええ	副詞	\N	\N	\N	444	\N
694	 ipakilala 	紹介する	動詞	\N	\N	\N	445	\N
443	 mo	あなた	代名詞	\N	\N	\N	445	\N
132	 naman	語調をやわらげる	副詞	\N	\N	\N	445	\N
87	 ako	私	代名詞	\N	\N	\N	445	\N
695	 sa kanya	彼女に	代名詞	\N	\N	\N	445	\N
696	 aba	あら	感嘆詞	\N	\N	\N	446	\N
697	 eto	ここに	代名詞	\N	\N	\N	446	\N
569	 na	もう	副詞	\N	\N	\N	446	\N
698	 pala	驚きを表す	副詞	\N	\N	\N	446	\N
592	 siya	彼女	代名詞	\N	\N	\N	446	\N
5	 Tina 	ティナ 	固有名詞	\N	\N	\N	447	\N
399	 ito	こちら	代名詞	\N	\N	\N	447	\N
699	 si		標識辞	\N	\N	\N	447	\N
700	 Joey	ジョーイ 	固有名詞	\N	\N	\N	447	\N
82	 ang		標識辞	\N	\N	\N	447	\N
701	 kaopisina 	 (会社の)同僚	名詞	\N	\N	\N	447	\N
449	 ko	 私の	代名詞	\N	\N	\N	447	\N
592	 siya	 彼女	代名詞	\N	\N	\N	448	\N
699	si		標識辞	\N	\N	\N	448	\N
577	ang		標識辞	\N	\N	\N	448	\N
5	hi 	 やあ	感嘆詞	\N	\N	\N	449	\N
39	 kumusta ka 	はじめまして 		\N	\N	\N	449	\N
1144		\N		\N	\N	\N	71	\N
950		\N		\N	\N	\N	13	\N
1125		\N		\N	\N	\N	185	\N
960		\N		\N	\N	\N	241	\N
744		\N		\N	\N	\N	353	\N
961		\N		\N	\N	\N	19	\N
961		\N		\N	\N	\N	80	\N
1195		\N		\N	\N	\N	427	\N
1064		\N		\N	\N	\N	200	\N
1020		\N		\N	\N	\N	32	\N
1024		\N		\N	\N	\N	325	\N
729		\N		\N	\N	\N	255	\N
1160		\N		\N	\N	\N	291	\N
904		\N		\N	\N	\N	69	\N
1190		\N		\N	\N	\N	193	\N
976		\N		\N	\N	\N	239	\N
785		\N		\N	\N	\N	226	\N
1221		\N		\N	\N	\N	129	\N
713		\N		\N	\N	\N	175	\N
711		\N		\N	\N	\N	49	\N
970		\N		\N	\N	\N	97	\N
1188		\N		\N	\N	\N	1	\N
1188		\N		\N	\N	\N	28	\N
1124		\N		\N	\N	\N	50	\N
917		\N		\N	\N	\N	321	\N
770		\N		\N	\N	\N	199	\N
726		\N		\N	\N	\N	338	\N
983		\N		\N	\N	\N	73	\N
983		\N		\N	\N	\N	76	\N
1091		\N		\N	\N	\N	351	\N
807		\N		\N	\N	\N	52	\N
807		\N		\N	\N	\N	160	\N
809		\N		\N	\N	\N	165	\N
910		\N		\N	\N	\N	38	\N
844		\N		\N	\N	\N	210	\N
991		\N		\N	\N	\N	53	\N
991		\N		\N	\N	\N	407	\N
1186		\N		\N	\N	\N	295	\N
995		\N		\N	\N	\N	290	\N
831		\N		\N	\N	\N	2	\N
1131		\N		\N	\N	\N	127	\N
854		\N		\N	\N	\N	48	\N
962		\N		\N	\N	\N	173	\N
745		\N		\N	\N	\N	163	\N
768		\N		\N	\N	\N	259	\N
719		\N		\N	\N	\N	257	\N
988		\N		\N	\N	\N	37	\N
988		\N		\N	\N	\N	440	\N
815		\N		\N	\N	\N	243	\N
1122		\N		\N	\N	\N	183	\N
818		\N		\N	\N	\N	381	\N
905		\N		\N	\N	\N	306	\N
1102		\N		\N	\N	\N	183	\N
821		\N		\N	\N	\N	249	\N
840		\N		\N	\N	\N	417	\N
720		\N		\N	\N	\N	223	\N
1007		\N		\N	\N	\N	233	\N
955		\N		\N	\N	\N	213	\N
956		\N		\N	\N	\N	117	\N
765		\N		\N	\N	\N	144	\N
737		\N		\N	\N	\N	51	\N
703		\N		\N	\N	\N	220	\N
769		\N		\N	\N	\N	311	\N
816		\N		\N	\N	\N	248	\N
1159		\N		\N	\N	\N	160	\N
1126		\N		\N	\N	\N	308	\N
951		\N		\N	\N	\N	191	\N
951		\N		\N	\N	\N	431	\N
1012		\N		\N	\N	\N	186	\N
772		\N		\N	\N	\N	199	\N
825		\N		\N	\N	\N	306	\N
837		\N		\N	\N	\N	180	\N
837		\N		\N	\N	\N	302	\N
892		\N		\N	\N	\N	252	\N
892		\N		\N	\N	\N	333	\N
1147		\N		\N	\N	\N	17	\N
792		\N		\N	\N	\N	28	\N
712		\N		\N	\N	\N	185	\N
882		\N		\N	\N	\N	203	\N
999		\N		\N	\N	\N	230	\N
1193		\N		\N	\N	\N	193	\N
1193		\N		\N	\N	\N	327	\N
1101		\N		\N	\N	\N	402	\N
1108		\N		\N	\N	\N	362	\N
1013		\N		\N	\N	\N	292	\N
1014		\N		\N	\N	\N	382	\N
710		\N		\N	\N	\N	288	\N
725		\N		\N	\N	\N	86	\N
1104		\N		\N	\N	\N	183	\N
724		\N		\N	\N	\N	334	\N
716		\N		\N	\N	\N	386	\N
968		\N		\N	\N	\N	296	\N
973		\N		\N	\N	\N	172	\N
1099		\N		\N	\N	\N	318	\N
1103		\N		\N	\N	\N	324	\N
1211		\N		\N	\N	\N	349	\N
766		\N		\N	\N	\N	319	\N
764		\N		\N	\N	\N	35	\N
764		\N		\N	\N	\N	140	\N
762		\N		\N	\N	\N	142	\N
1135		\N		\N	\N	\N	127	\N
1135		\N		\N	\N	\N	446	\N
1016		\N		\N	\N	\N	398	\N
1026		\N		\N	\N	\N	238	\N
957		\N		\N	\N	\N	272	\N
906		\N		\N	\N	\N	77	\N
906		\N		\N	\N	\N	87	\N
1143		\N		\N	\N	\N	170	\N
855		\N		\N	\N	\N	49	\N
1137		\N		\N	\N	\N	128	\N
1051		\N		\N	\N	\N	152	\N
959		\N		\N	\N	\N	197	\N
899		\N		\N	\N	\N	315	\N
933		\N		\N	\N	\N	136	\N
1010		\N		\N	\N	\N	280	\N
1038		\N		\N	\N	\N	232	\N
702		\N		\N	\N	\N	159	\N
1198		\N		\N	\N	\N	54	\N
887		\N		\N	\N	\N	19	\N
887		\N		\N	\N	\N	29	\N
980		\N		\N	\N	\N	176	\N
966		\N		\N	\N	\N	340	\N
810		\N		\N	\N	\N	60	\N
810		\N		\N	\N	\N	372	\N
925		\N		\N	\N	\N	394	\N
798		\N		\N	\N	\N	448	\N
1222		\N		\N	\N	\N	137	\N
949		\N		\N	\N	\N	3	\N
949		\N		\N	\N	\N	228	\N
1149		\N		\N	\N	\N	264	\N
954		\N		\N	\N	\N	92	\N
948		\N		\N	\N	\N	305	\N
867		\N		\N	\N	\N	335	\N
969		\N		\N	\N	\N	267	\N
883		\N		\N	\N	\N	7	\N
799		\N		\N	\N	\N	420	\N
1117		\N		\N	\N	\N	149	\N
1192		\N		\N	\N	\N	230	\N
1025		\N		\N	\N	\N	238	\N
1114		\N		\N	\N	\N	304	\N
1022		\N		\N	\N	\N	331	\N
834		\N		\N	\N	\N	33	\N
858		\N		\N	\N	\N	309	\N
748		\N		\N	\N	\N	132	\N
942		\N		\N	\N	\N	85	\N
1165		\N		\N	\N	\N	286	\N
1128		\N		\N	\N	\N	183	\N
788		\N		\N	\N	\N	130	\N
1216		\N		\N	\N	\N	323	\N
1216		\N		\N	\N	\N	424	\N
1176		\N		\N	\N	\N	219	\N
953		\N		\N	\N	\N	17	\N
1083		\N		\N	\N	\N	451	\N
1082		\N		\N	\N	\N	452	\N
751		\N		\N	\N	\N	453	\N
886		\N		\N	\N	\N	454	\N
1061		\N		\N	\N	\N	455	\N
946		\N		\N	\N	\N	456	\N
1069		\N		\N	\N	\N	458	\N
1015		\N		\N	\N	\N	459	\N
1189		\N		\N	\N	\N	460	\N
877		\N		\N	\N	\N	461	\N
1199		\N		\N	\N	\N	463	\N
895		\N		\N	\N	\N	464	\N
774		\N		\N	\N	\N	465	\N
1158		\N		\N	\N	\N	466	\N
1187		\N		\N	\N	\N	467	\N
830		\N		\N	\N	\N	468	\N
934		\N		\N	\N	\N	469	\N
1005		\N		\N	\N	\N	470	\N
920		\N		\N	\N	\N	471	\N
833		\N		\N	\N	\N	472	\N
902		\N		\N	\N	\N	473	\N
937		\N		\N	\N	\N	474	\N
881		\N		\N	\N	\N	475	\N
1194		\N		\N	\N	\N	476	\N
1191		\N		\N	\N	\N	477	\N
1054		\N		\N	\N	\N	478	\N
1207		\N		\N	\N	\N	479	\N
941		\N		\N	\N	\N	480	\N
1046		\N		\N	\N	\N	481	\N
750		\N		\N	\N	\N	482	\N
1043		\N		\N	\N	\N	483	\N
732		\N		\N	\N	\N	484	\N
1110		\N		\N	\N	\N	485	\N
1081		\N		\N	\N	\N	486	\N
789		\N		\N	\N	\N	487	\N
1157		\N		\N	\N	\N	488	\N
868		\N		\N	\N	\N	489	\N
1037		\N		\N	\N	\N	490	\N
862		\N		\N	\N	\N	491	\N
923		\N		\N	\N	\N	492	\N
1042		\N		\N	\N	\N	493	\N
1071		\N		\N	\N	\N	494	\N
731		\N		\N	\N	\N	495	\N
911		\N		\N	\N	\N	496	\N
1085		\N		\N	\N	\N	497	\N
885		\N		\N	\N	\N	498	\N
874		\N		\N	\N	\N	499	\N
870		\N		\N	\N	\N	500	\N
900		\N		\N	\N	\N	501	\N
734		\N		\N	\N	\N	502	\N
722		\N		\N	\N	\N	503	\N
1040		\N		\N	\N	\N	504	\N
1041		\N		\N	\N	\N	504	\N
898		\N		\N	\N	\N	454	\N
1132		\N		\N	\N	\N	505	\N
706		\N		\N	\N	\N	506	\N
832		\N		\N	\N	\N	507	\N
928		\N		\N	\N	\N	508	\N
752		\N		\N	\N	\N	509	\N
1204		\N		\N	\N	\N	510	\N
1086		\N		\N	\N	\N	511	\N
808		\N		\N	\N	\N	512	\N
851		\N		\N	\N	\N	513	\N
754		\N		\N	\N	\N	514	\N
1215		\N		\N	\N	\N	515	\N
842		\N		\N	\N	\N	516	\N
860		\N		\N	\N	\N	517	\N
717		\N		\N	\N	\N	518	\N
704		\N		\N	\N	\N	519	\N
1088		\N		\N	\N	\N	519	\N
828		\N		\N	\N	\N	520	\N
829		\N		\N	\N	\N	521	\N
907		\N		\N	\N	\N	522	\N
1076		\N		\N	\N	\N	523	\N
1080		\N		\N	\N	\N	524	\N
1079		\N		\N	\N	\N	525	\N
1028		\N		\N	\N	\N	526	\N
707		\N		\N	\N	\N	527	\N
964		\N		\N	\N	\N	528	\N
876		\N		\N	\N	\N	529	\N
1151		\N		\N	\N	\N	530	\N
800		\N		\N	\N	\N	531	\N
938		\N		\N	\N	\N	532	\N
773		\N		\N	\N	\N	533	\N
1156		\N		\N	\N	\N	257	\N
718		\N		\N	\N	\N	534	\N
1136		\N		\N	\N	\N	536	\N
863		\N		\N	\N	\N	537	\N
783		\N		\N	\N	\N	538	\N
1168		\N		\N	\N	\N	539	\N
709		\N		\N	\N	\N	540	\N
1058		\N		\N	\N	\N	541	\N
1065		\N		\N	\N	\N	541	\N
1008		\N		\N	\N	\N	542	\N
1212		\N		\N	\N	\N	543	\N
1003		\N		\N	\N	\N	544	\N
723		\N		\N	\N	\N	545	\N
893		\N		\N	\N	\N	546	\N
839		\N		\N	\N	\N	547	\N
1089		\N		\N	\N	\N	548	\N
753		\N		\N	\N	\N	549	\N
1090		\N		\N	\N	\N	550	\N
705		\N		\N	\N	\N	551	\N
935		\N		\N	\N	\N	552	\N
1066		\N		\N	\N	\N	553	\N
913		\N		\N	\N	\N	554	\N
918		\N		\N	\N	\N	555	\N
1067		\N		\N	\N	\N	556	\N
971		\N		\N	\N	\N	557	\N
1048		\N		\N	\N	\N	558	\N
872		\N		\N	\N	\N	559	\N
922		\N		\N	\N	\N	560	\N
1030		\N		\N	\N	\N	561	\N
1098		\N		\N	\N	\N	562	\N
864		\N		\N	\N	\N	563	\N
728		\N		\N	\N	\N	564	\N
919		\N		\N	\N	\N	565	\N
811		\N		\N	\N	\N	566	\N
865		\N		\N	\N	\N	567	\N
1031		\N		\N	\N	\N	568	\N
1033		\N		\N	\N	\N	569	\N
1205		\N		\N	\N	\N	570	\N
1060		\N		\N	\N	\N	571	\N
1084		\N		\N	\N	\N	572	\N
936		\N		\N	\N	\N	573	\N
1127		\N		\N	\N	\N	574	\N
1182		\N		\N	\N	\N	575	\N
824		\N		\N	\N	\N	576	\N
1140		\N		\N	\N	\N	577	\N
994		\N		\N	\N	\N	578	\N
812		\N		\N	\N	\N	579	\N
820		\N		\N	\N	\N	580	\N
795		\N		\N	\N	\N	581	\N
1134		\N		\N	\N	\N	582	\N
1047		\N		\N	\N	\N	543	\N
1068		\N		\N	\N	\N	583	\N
742		\N		\N	\N	\N	584	\N
819		\N		\N	\N	\N	580	\N
1062		\N		\N	\N	\N	585	\N
1004		\N		\N	\N	\N	586	\N
1146		\N		\N	\N	\N	534	\N
897		\N		\N	\N	\N	587	\N
1021		\N		\N	\N	\N	588	\N
873		\N		\N	\N	\N	461	\N
761		\N		\N	\N	\N	589	\N
813		\N		\N	\N	\N	590	\N
847		\N		\N	\N	\N	592	\N
1044		\N		\N	\N	\N	593	\N
1056		\N		\N	\N	\N	594	\N
891		\N		\N	\N	\N	595	\N
826		\N		\N	\N	\N	596	\N
1208		\N		\N	\N	\N	597	\N
838		\N		\N	\N	\N	598	\N
1075		\N		\N	\N	\N	597	\N
757		\N		\N	\N	\N	599	\N
758		\N		\N	\N	\N	600	\N
827		\N		\N	\N	\N	601	\N
739		\N		\N	\N	\N	533	\N
733		\N		\N	\N	\N	602	\N
1202		\N		\N	\N	\N	510	\N
1200		\N		\N	\N	\N	603	\N
743		\N		\N	\N	\N	604	\N
1220		\N		\N	\N	\N	605	\N
741		\N		\N	\N	\N	606	\N
939		\N		\N	\N	\N	475	\N
889		\N		\N	\N	\N	607	\N
888		\N		\N	\N	\N	608	\N
836		\N		\N	\N	\N	609	\N
1023		\N		\N	\N	\N	610	\N
1011		\N		\N	\N	\N	611	\N
909		\N		\N	\N	\N	612	\N
1197		\N		\N	\N	\N	613	\N
997		\N		\N	\N	\N	614	\N
1002		\N		\N	\N	\N	615	\N
1070		\N		\N	\N	\N	616	\N
1154		\N		\N	\N	\N	617	\N
735		\N		\N	\N	\N	618	\N
875		\N		\N	\N	\N	619	\N
1155		\N		\N	\N	\N	620	\N
756		\N		\N	\N	\N	560	\N
817		\N		\N	\N	\N	621	\N
1009		\N		\N	\N	\N	622	\N
1100		\N		\N	\N	\N	623	\N
998		\N		\N	\N	\N	624	\N
979		\N		\N	\N	\N	625	\N
740		\N		\N	\N	\N	626	\N
727		\N		\N	\N	\N	627	\N
777		\N		\N	\N	\N	628	\N
982		\N		\N	\N	\N	629	\N
989		\N		\N	\N	\N	630	\N
974		\N		\N	\N	\N	631	\N
1142		\N		\N	\N	\N	632	\N
992		\N		\N	\N	\N	633	\N
1203		\N		\N	\N	\N	634	\N
972		\N		\N	\N	\N	635	\N
759		\N		\N	\N	\N	636	\N
755		\N		\N	\N	\N	637	\N
845		\N		\N	\N	\N	638	\N
1029		\N		\N	\N	\N	639	\N
794		\N		\N	\N	\N	640	\N
1171		\N		\N	\N	\N	641	\N
1181		\N		\N	\N	\N	642	\N
779		\N		\N	\N	\N	643	\N
715		\N		\N	\N	\N	644	\N
780		\N		\N	\N	\N	645	\N
1173		\N		\N	\N	\N	646	\N
1179		\N		\N	\N	\N	647	\N
1214		\N		\N	\N	\N	648	\N
1032		\N		\N	\N	\N	649	\N
749		\N		\N	\N	\N	650	\N
1213		\N		\N	\N	\N	651	\N
841		\N		\N	\N	\N	652	\N
1018		\N		\N	\N	\N	653	\N
985		\N		\N	\N	\N	654	\N
1167		\N		\N	\N	\N	655	\N
965		\N		\N	\N	\N	656	\N
814		\N		\N	\N	\N	657	\N
986		\N		\N	\N	\N	658	\N
1162		\N		\N	\N	\N	659	\N
1170		\N		\N	\N	\N	660	\N
978		\N		\N	\N	\N	661	\N
945		\N		\N	\N	\N	662	\N
977		\N		\N	\N	\N	663	\N
984		\N		\N	\N	\N	664	\N
778		\N		\N	\N	\N	666	\N
1055		\N		\N	\N	\N	667	\N
746		\N		\N	\N	\N	668	\N
975		\N		\N	\N	\N	669	\N
805		\N		\N	\N	\N	670	\N
1186		\N		\N	\N	\N	671	\N
1093		\N		\N	\N	\N	672	\N
1105		\N		\N	\N	\N	674	\N
849		\N		\N	\N	\N	675	\N
990		\N		\N	\N	\N	676	\N
1219		\N		\N	\N	\N	677	\N
981		\N		\N	\N	\N	678	\N
1049		\N		\N	\N	\N	679	\N
1185		\N		\N	\N	\N	680	\N
1169		\N		\N	\N	\N	681	\N
1092		\N		\N	\N	\N	682	\N
1027		\N		\N	\N	\N	683	\N
790		\N		\N	\N	\N	684	\N
784		\N		\N	\N	\N	685	\N
714		\N		\N	\N	\N	686	\N
787		\N		\N	\N	\N	687	\N
1175		\N		\N	\N	\N	688	\N
927		\N		\N	\N	\N	689	\N
736		\N		\N	\N	\N	690	\N
781		\N		\N	\N	\N	691	\N
926		\N		\N	\N	\N	692	\N
1141		\N		\N	\N	\N	693	\N
1166		\N		\N	\N	\N	694	\N
1180		\N		\N	\N	\N	695	\N
930		\N		\N	\N	\N	696	\N
931		\N		\N	\N	\N	697	\N
1034		\N		\N	\N	\N	698	\N
1210		\N		\N	\N	\N	699	\N
929		\N		\N	\N	\N	700	\N
943		\N		\N	\N	\N	701	\N
1209		\N		\N	\N	\N	702	\N
903		\N		\N	\N	\N	703	\N
1036		\N		\N	\N	\N	704	\N
1087		\N		\N	\N	\N	705	\N
901		\N		\N	\N	\N	706	\N
944		\N		\N	\N	\N	708	\N
1077		\N		\N	\N	\N	709	\N
947		\N		\N	\N	\N	710	\N
921		\N		\N	\N	\N	711	\N
1053		\N		\N	\N	\N	712	\N
916		\N		\N	\N	\N	713	\N
912		\N		\N	\N	\N	714	\N
1161		\N		\N	\N	\N	715	\N
767		\N		\N	\N	\N	716	\N
1206		\N		\N	\N	\N	717	\N
804		\N		\N	\N	\N	718	\N
803		\N		\N	\N	\N	719	\N
796		\N		\N	\N	\N	720	\N
797		\N		\N	\N	\N	721	\N
1150		\N		\N	\N	\N	722	\N
1074		\N		\N	\N	\N	723	\N
793		\N		\N	\N	\N	724	\N
896		\N		\N	\N	\N	725	\N
1138		\N		\N	\N	\N	726	\N
1120		\N		\N	\N	\N	727	\N
1118		\N		\N	\N	\N	728	\N
1107		\N		\N	\N	\N	729	\N
853		\N		\N	\N	\N	730	\N
1072		\N		\N	\N	\N	731	\N
1133		\N		\N	\N	\N	732	\N
963		\N		\N	\N	\N	733	\N
1097		\N		\N	\N	\N	734	\N
940		\N		\N	\N	\N	735	\N
1148		\N		\N	\N	\N	736	\N
908		\N		\N	\N	\N	737	\N
1218		\N		\N	\N	\N	738	\N
1000		\N		\N	\N	\N	739	\N
952		\N		\N	\N	\N	740	\N
856		\N		\N	\N	\N	741	\N
856		\N		\N	\N	\N	742	\N
914		\N		\N	\N	\N	743	\N
866		\N		\N	\N	\N	744	\N
915		\N		\N	\N	\N	745	\N
848		\N		\N	\N	\N	746	\N
924		\N		\N	\N	\N	747	\N
1174		\N		\N	\N	\N	748	\N
776		\N		\N	\N	\N	749	\N
932		\N		\N	\N	\N	750	\N
730		\N		\N	\N	\N	751	\N
1001		\N		\N	\N	\N	752	\N
806		\N		\N	\N	\N	753	\N
1115		\N		\N	\N	\N	754	\N
1112		\N		\N	\N	\N	755	\N
1116		\N		\N	\N	\N	756	\N
1119		\N		\N	\N	\N	757	\N
782		\N		\N	\N	\N	758	\N
786		\N		\N	\N	\N	162	\N
993		\N		\N	\N	\N	759	\N
738		\N		\N	\N	\N	760	\N
1130		\N		\N	\N	\N	531	\N
1057		\N		\N	\N	\N	761	\N
846		\N		\N	\N	\N	762	\N
1196		\N		\N	\N	\N	763	\N
1111		\N		\N	\N	\N	562	\N
1073		\N		\N	\N	\N	764	\N
878		\N		\N	\N	\N	765	\N
1019		\N		\N	\N	\N	766	\N
802		\N		\N	\N	\N	767	\N
747		\N		\N	\N	\N	768	\N
1050		\N		\N	\N	\N	769	\N
861		\N		\N	\N	\N	770	\N
1006		\N		\N	\N	\N	627	\N
894		\N		\N	\N	\N	478	\N
763		\N		\N	\N	\N	736	\N
775		\N		\N	\N	\N	771	\N
890		\N		\N	\N	\N	772	\N
1145		\N		\N	\N	\N	773	\N
1017		\N		\N	\N	\N	774	\N
1052		\N		\N	\N	\N	775	\N
1063		\N		\N	\N	\N	776	\N
1078		\N		\N	\N	\N	777	\N
871		\N		\N	\N	\N	612	\N
879		\N		\N	\N	\N	778	\N
880		\N		\N	\N	\N	779	\N
1035		\N		\N	\N	\N	780	\N
721		\N		\N	\N	\N	781	\N
823		\N		\N	\N	\N	782	\N
1152		\N		\N	\N	\N	783	\N
1217		\N		\N	\N	\N	784	\N
857		\N		\N	\N	\N	785	\N
1129		\N		\N	\N	\N	786	\N
884		\N		\N	\N	\N	787	\N
1164		\N		\N	\N	\N	788	\N
822		\N		\N	\N	\N	789	\N
835		\N		\N	\N	\N	790	\N
791		\N		\N	\N	\N	791	\N
996		\N		\N	\N	\N	792	\N
1178		\N		\N	\N	\N	527	\N
1177		\N		\N	\N	\N	647	\N
843		\N		\N	\N	\N	793	\N
859		\N		\N	\N	\N	794	\N
967		\N		\N	\N	\N	795	\N
410		\N		\N	\N	\N	796	\N
708		\N		\N	\N	\N	797	\N
771		\N		\N	\N	\N	798	\N
801		\N		\N	\N	\N	799	\N
850		\N		\N	\N	\N	800	\N
852		\N		\N	\N	\N	801	\N
987		\N		\N	\N	\N	802	\N
1039		\N		\N	\N	\N	803	\N
1045		\N		\N	\N	\N	515	\N
1059		\N		\N	\N	\N	804	\N
1094		\N		\N	\N	\N	805	\N
1095		\N		\N	\N	\N	806	\N
1096		\N		\N	\N	\N	807	\N
1106		\N		\N	\N	\N	808	\N
1109		\N		\N	\N	\N	809	\N
1113		\N		\N	\N	\N	810	\N
1121		\N		\N	\N	\N	811	\N
1123		\N		\N	\N	\N	130	\N
1123		\N		\N	\N	\N	681	\N
1153		\N		\N	\N	\N	812	\N
1163		\N		\N	\N	\N	813	\N
958		\N		\N	\N	\N	814	\N
1139		\N		\N	\N	\N	815	\N
1201		\N		\N	\N	\N	816	\N
1128		\N		\N	\N	\N	786	\N
817		\N		\N	\N	\N	622	\N
1159		\N		\N	\N	\N	655	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: tl
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

