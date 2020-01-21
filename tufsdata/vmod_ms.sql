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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO ms;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO ms;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO ms;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: ms
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


ALTER TABLE public.t_instance OWNER TO ms;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO ms;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO ms;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: ms
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


ALTER TABLE public.t_usage_classified_rel OWNER TO ms;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: ms
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


ALTER TABLE public.t_usage_inst_rel OWNER TO ms;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO ms;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO ms;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: ms
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO ms;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: ms
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


ALTER TABLE public.t_word_inst_rel OWNER TO ms;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: ms
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO ms;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: ms
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO ms;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: ms
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_index_char (id, index_char) FROM stdin;
1	a
2	b
3	c
4	d
5	e
6	é
7	f
8	g
9	h
10	i
11	j
12	k
13	l
14	m
15	n
16	o
17	p
18	r
19	s
20	t
21	u
22	w
23	x
24	y
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
3874	Erm, tumpang tanya. Perpustakaan di mana?	あの、　すみません。　図書館は　どこですか。	\N		\N	vmod				740	1
1476	Saya rasa orang itu guru bahasa Jepun. 	あの　人は　日本語の　先生だと　思います。	null		\N	vmod				\N	1
2019	Hari ini tiada kelas kerana cikgu sakit.	きょうは　先生が　病気で、　授業が　休みに　なりました。	null		\N	vmod				\N	1
3425	Hari ini saya tidak pergi ke sekolah kerana selesema.	きょう　かぜで　学校を　休みました。	\N		\N	vmod				194	1
3426	Saya dan Encik Lee pergi menonton wayang pada hari ini.	きょう　イさんと　映画を　見に　行きます。	\N		\N	vmod				194	1
3446	Hari ini ada kelas dari pagi sampai petang. 	きょうは　朝から　夕方まで　授業が　ありました。	\N		\N	vmod				12	1
2005	Saya tidak akan pergi ke sekolah esok kerana tiada kelas.	あしたは　授業が　ないから、　学校へ　行きません。	null		\N	vmod				\N	1
1369	Tidak, saya tidak pergi. 	いいえ、　行きません。	null		\N	vmod				\N	1
1879	Tidak, saya tidak boleh buat. 	いいえ、　できません。	null		\N	vmod				\N	1
3784	Bukan.	いいえ、　違います。	\N		\N	vmod				41	1
2004	Saya sudah baik kerana makan ubat tadi.	くすりを　飲みましたから、　もう　だいじょうぶです。	null		\N	vmod				\N	1
3732	Saya sudah makan tengah hari di kantin. 	わたしは　もう　食堂で　昼ごはんを　食べました。	\N		\N	vmod				640	1
3733	Adik perempuan sudah tidur. 	妹は　もう　寝ました。	\N		\N	vmod				640	1
3847	Cerita ini betul.	この　話は　本当です。	\N		\N	vmod				596	1
3766	Ha, Encik Tanaka, selamat malam. 	ああ、　田中さん、　こんばんは。	\N		\N	vmod				1	1
3767	Oh, baguslah. 	ああ、　よかったです。	\N		\N	vmod				1	1
1824	Ya, boleh. 	はい、　いいですよ。	null		\N	vmod				\N	1
3777	Ya, betul. 	はい、　そうです。	\N		\N	vmod				741	1
3778	Ya, ada apa?	はい、　何ですか。	\N		\N	vmod				741	1
2383	Benda ini barang biasa saja, tetapi silakan. 	つまらない　ものですけど、　どうぞ。	①どうぞ　②何か（もの）をあげる　③どうぞ　④　これ、どうぞ。		\N	vmod				\N	1
3792	Tolong bantu saya mana yang perlu. 	どうぞ　よろしく　お願いします。	\N		\N	vmod				437	1
3698	Saya akan membeli gelas ini. Selepas itu, saya akan membeli pinggan ini juga. 	この　コップを　買います。　それから、　この　お皿も　買います。	\N		\N	vmod				357	1
3699	Semalam saya menonton TV. Selepas itu, saya belajar bahasa Jepun. 	きのうは　テレビを　見ました。　それから、　日本語を　勉強しました。	\N		\N	vmod				357	1
3787	Saya memesan masakan ini.	わたしは　この　料理を　頼みます。	\N		\N	vmod				250	1
3788	Bangunan ini lama dan terkenal. 	この　建物は　古くて、　有名です。	\N		\N	vmod				250	1
3888	わたしの　家族は　五人です。	わたしの　家族は　五人です。	\N		\N	vmod				736	1
18	山田さんがリーダーです。	山田さんがリーダーです。	null		\N	vmod				\N	0
19	あっ、田中さんが１位です。	あっ、田中さんが１位です。	null		\N	vmod				\N	0
20	中山さんは大学生ですか。	中山さんは大学生ですか。	null		\N	vmod				\N	0
21	はい、大学生です。	はい、大学生です。	null		\N	vmod				\N	0
22	田中さんですか。	田中さんですか。	null		\N	vmod				\N	0
23	はい、田中です。	はい、田中です。	null		\N	vmod				\N	0
24	学生ではありませんか。	学生ではありませんか。	null		\N	vmod				\N	0
25	はい、学生ではありません。	はい、学生ではありません。	null		\N	vmod				\N	0
26	田中さんですか。	田中さんですか。	null		\N	vmod				\N	0
27	いいえ、山口です。	いいえ、山口です。	null		\N	vmod				\N	0
28	学生ではありませんか。	学生ではありませんか。	null		\N	vmod				\N	0
29	いいえ、学生です。	いいえ、学生です。	null		\N	vmod				\N	0
30	東京は晴れでした。	東京は晴れでした。	null		\N	vmod				\N	0
31	むかし、ここは公園でした。	むかし、ここは公園でした。	null		\N	vmod				\N	0
32	父は先生でした。	父は先生でした。	null		\N	vmod				\N	0
33	お昼はおにぎりではありませんでした。	お昼はおにぎりではありませんでした。	null		\N	vmod				\N	0
34	きのうは休みでしたか。	きのうは休みでしたか。	null		\N	vmod				\N	0
35	いいえ、休みではありませんでした。	いいえ、休みではありませんでした。	null		\N	vmod				\N	0
36	きのうは休みではなかったです。	きのうは休みではなかったです。	null		\N	vmod				\N	0
37	木があります。	木があります。	null		\N	vmod				\N	0
38	本があります。	本があります。	null		\N	vmod				\N	0
39	犬がいます。	犬がいます。	null		\N	vmod				\N	0
40	田中さんがいます。	田中さんがいます。	null		\N	vmod				\N	0
41	ペンがありますか。	ペンがありますか。	null		\N	vmod				\N	0
42	はい、あります。	はい、あります。	null		\N	vmod				\N	0
43	いいえ、ありません。	いいえ、ありません。	null		\N	vmod				\N	0
44	山田さん、いますか。	山田さん、いますか。	null		\N	vmod				\N	0
45	はい、います。	はい、います。	null		\N	vmod				\N	0
46	いいえ、いません。	いいえ、いません。	null		\N	vmod				\N	0
47	何がありますか。	何がありますか。	null		\N	vmod				\N	0
48	ノートがあります。	ノートがあります。	null		\N	vmod				\N	0
49	誰がいましたか。	誰がいましたか。	null		\N	vmod				\N	0
50	田中さんがいました。	田中さんがいました。	null		\N	vmod				\N	0
51	誰がいましたか。	誰がいましたか。	null		\N	vmod				\N	0
52	誰もいませんでした。	誰もいませんでした。	null		\N	vmod				\N	0
53	ペンがありますか。	ペンがありますか。	null		\N	vmod				\N	0
54	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	0
55	先生、来週漢字の試験がありますか。	先生、来週漢字の試験がありますか。	null		\N	vmod				\N	0
56	はい、あります。水曜日ですよ。	はい、あります。水曜日ですよ。	null		\N	vmod				\N	0
57	部屋にパソコンがあります。	部屋にパソコンがあります。	null		\N	vmod				\N	0
58	公園に木があります。	公園に木があります。	null		\N	vmod				\N	0
59	家に犬がいます。	家に犬がいます。	null		\N	vmod				\N	0
60	教室に田中さんがいます。	教室に田中さんがいます。	null		\N	vmod				\N	0
61	パソコンは部屋にあります。	パソコンは部屋にあります。	null		\N	vmod				\N	0
62	田中さんは教室にいます。	田中さんは教室にいます。	null		\N	vmod				\N	0
63	パソコンはどこにありますか。	パソコンはどこにありますか。	null		\N	vmod				\N	0
64	部屋にあります。	部屋にあります。	null		\N	vmod				\N	0
65	田中さんはどこにいますか。	田中さんはどこにいますか。	null		\N	vmod				\N	0
66	教室にいます。	教室にいます。	null		\N	vmod				\N	0
67	みなさん、質問がありますか。	みなさん、質問がありますか。	null		\N	vmod				\N	0
68	ありません。	ありません。	null		\N	vmod				\N	0
69	お金がありません。	お金がありません。	null		\N	vmod				\N	0
70	太郎さんには子どもがいます。	太郎さんには子どもがいます。	null		\N	vmod				\N	0
1626	お母さんに見つかりました。	お母さんに見つかりました。	null		\N	vmod				\N	1
71	公園でロックコンサートがありました。	公園でロックコンサートがありました。	null		\N	vmod				\N	0
73	机の下	机の下	null		\N	vmod				\N	0
74	家の前	家の前	null		\N	vmod				\N	0
75	家のうしろ	家のうしろ	null		\N	vmod				\N	0
76	教室の中	教室の中	null		\N	vmod				\N	0
77	教室の外	教室の外	null		\N	vmod				\N	0
78	田中さんの右	田中さんの右	null		\N	vmod				\N	0
79	田中さんの左	田中さんの左	null		\N	vmod				\N	0
80	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	0
81	机の下にかばんがあります。	机の下にかばんがあります。	null		\N	vmod				\N	0
82	かばんの中にノートがあります。	かばんの中にノートがあります。	null		\N	vmod				\N	0
83	田中さんの右に山田さんがいます。	田中さんの右に山田さんがいます。	null		\N	vmod				\N	0
84	田中さんの左に木村さんがいます。	田中さんの左に木村さんがいます。	null		\N	vmod				\N	0
85	家の前に猫がいます。	家の前に猫がいます。	null		\N	vmod				\N	0
86	家のうしろに車があります。	家のうしろに車があります。	null		\N	vmod				\N	0
87	ポストは家の向かいにあります。	ポストは家の向かいにあります。	null		\N	vmod				\N	0
88	埼玉は東京の北にあります。	埼玉は東京の北にあります。	null		\N	vmod				\N	0
89	田中さんは教室の中にいます。	田中さんは教室の中にいます。	null		\N	vmod				\N	0
90	山田さんは教室の外にいます。	山田さんは教室の外にいます。	null		\N	vmod				\N	0
91	家の前は公園です。	家の前は公園です。	null		\N	vmod				\N	0
92	山田さんのとなりは田中さんです。	山田さんのとなりは田中さんです。	null		\N	vmod				\N	0
93	学校は家の近くです。	学校は家の近くです。	null		\N	vmod				\N	0
94	本はかばんの中です。	本はかばんの中です。	null		\N	vmod				\N	0
95	わたしのペンはこれです。	わたしのペンはこれです。	null		\N	vmod				\N	0
96	体育館のとなりにプールがあります。	体育館のとなりにプールがあります。	null		\N	vmod				\N	0
97	はさみは机の上にあります。	はさみは机の上にあります。	null		\N	vmod				\N	0
98	田中さんのとなりに木村さんがいます。	田中さんのとなりに木村さんがいます。	null		\N	vmod				\N	0
99	あれは数学の教科書です。	あれは数学の教科書です。	null		\N	vmod				\N	0
100	日本語の教室はどこですか。	日本語の教室はどこですか。	null		\N	vmod				\N	0
101	２階です。	２階です。	null		\N	vmod				\N	0
102	これは誰のかばんですか。	これは誰のかばんですか。	null		\N	vmod				\N	0
103	わたしのです。	わたしのです。	null		\N	vmod				\N	0
104	それはいつの新聞ですか。	それはいつの新聞ですか。	null		\N	vmod				\N	0
105	きのうのです。	きのうのです。	null		\N	vmod				\N	0
106	わたしのはどこにありますか。	わたしのはどこにありますか。	null		\N	vmod				\N	0
107	わたしは東京外国語大学の木村です。	わたしは東京外国語大学の木村です。	null		\N	vmod				\N	0
108	日本には、春と夏と秋と冬の４つの季節があります。	日本には、春と夏と秋と冬の４つの季節があります。	null		\N	vmod				\N	0
109	この人は友だちの田中さんです。	この人は友だちの田中さんです。	null		\N	vmod				\N	0
110	教室に新しいコンピューターがあります。	教室に新しいコンピューターがあります。	null		\N	vmod				\N	0
111	箱の中に小さい犬がいます。	箱の中に小さい犬がいます。	null		\N	vmod				\N	0
112	田中さんは元気な人です。	田中さんは元気な人です。	null		\N	vmod				\N	0
113	すてきな絵ですね。	すてきな絵ですね。	null		\N	vmod				\N	0
114	ようかんはどんな食べ物ですか。	ようかんはどんな食べ物ですか。	null		\N	vmod				\N	0
115	あまいおかしです。	あまいおかしです。	null		\N	vmod				\N	0
116	どんな映画ですか。	どんな映画ですか。	null		\N	vmod				\N	0
118	どんなかばんですか。	どんなかばんですか。	null		\N	vmod				\N	0
119	じょうぶなかばんです。	じょうぶなかばんです。	null		\N	vmod				\N	0
120	どんなCDがありますか。	どんなCDがありますか。	null		\N	vmod				\N	0
121	静かな音楽のCDがあります。	静かな音楽のCDがあります。	null		\N	vmod				\N	0
122	どの靴を買いますか。	どの靴を買いますか。	null		\N	vmod				\N	0
123	黒いのを買います。	黒いのを買います。	null		\N	vmod				\N	0
124	どんな音楽がすきですか。	どんな音楽がすきですか。	null		\N	vmod				\N	0
125	静かなのがすきです。	静かなのがすきです。	null		\N	vmod				\N	0
126	これは日本語の教科書です。	これは日本語の教科書です。	null		\N	vmod				\N	0
127	日本語の辞書はそれです。	日本語の辞書はそれです。	null		\N	vmod				\N	0
128	あれは体育館です。	あれは体育館です。	null		\N	vmod				\N	0
129	ここは１年生の教室です。	ここは１年生の教室です。	null		\N	vmod				\N	0
130	そこは図書室です。	そこは図書室です。	null		\N	vmod				\N	0
131	あそこは事務室です。	あそこは事務室です。	null		\N	vmod				\N	0
132	田中さんのかばんはそこにあります。	田中さんのかばんはそこにあります。	null		\N	vmod				\N	0
133	あそこに先生がいます。	あそこに先生がいます。	null		\N	vmod				\N	0
134	この部屋は２年生の教室です。	この部屋は２年生の教室です。	null		\N	vmod				\N	0
135	その本はわたしのです。	その本はわたしのです。	null		\N	vmod				\N	0
136	先生はあの人です。	先生はあの人です。	null		\N	vmod				\N	0
137	あのきれいな女の人は山本さんです。	あのきれいな女の人は山本さんです。	null		\N	vmod				\N	0
138	その大きいかばんはわたしのです。	その大きいかばんはわたしのです。	null		\N	vmod				\N	0
139	田中さんの消しゴムはどれですか。	田中さんの消しゴムはどれですか。	null		\N	vmod				\N	0
141	すみません、トイレはどこですか。	すみません、トイレはどこですか。	null		\N	vmod				\N	0
142	あそこです。	あそこです。	null		\N	vmod				\N	0
143	ありがとうございました。	ありがとうございました。	null		\N	vmod				\N	0
1565	山田さんと田中さん	山田さんと田中さん	null		\N	vmod				\N	1
144	先生の車はどこにありますか。	先生の車はどこにありますか。	null		\N	vmod				\N	0
145	あそこです。	あそこです。	null		\N	vmod				\N	0
146	わたしのぼうしはどこにありますか。	わたしのぼうしはどこにありますか。	null		\N	vmod				\N	0
147	そこにあります。	そこにあります。	null		\N	vmod				\N	0
148	どこですか。	どこですか。	null		\N	vmod				\N	0
149	あなたのうしろです。	あなたのうしろです。	null		\N	vmod				\N	0
150	あのかばんは誰のですか。	あのかばんは誰のですか。	null		\N	vmod				\N	0
151	どのかばんですか。	どのかばんですか。	null		\N	vmod				\N	0
152	あの黒いかばんです。	あの黒いかばんです。	null		\N	vmod				\N	0
153	あれは田中さんのです。	あれは田中さんのです。	null		\N	vmod				\N	0
154	あそこにかさが５本あります。	あそこにかさが５本あります。	null		\N	vmod				\N	0
155	ケーキが７つあります。	ケーキが７つあります。	null		\N	vmod				\N	0
156	このボールペンはいくらですか。	このボールペンはいくらですか。	null		\N	vmod				\N	0
158	先生の机の上に辞書が２冊と雑誌が１冊あります。	先生の机の上に辞書が２冊と雑誌が１冊あります。	null		\N	vmod				\N	0
159	ボールがいくつありますか。	ボールがいくつありますか。	null		\N	vmod				\N	0
161	そこにハンカチが何枚ありますか。	そこにハンカチが何枚ありますか。	null		\N	vmod				\N	0
162	３枚あります。	３枚あります。	null		\N	vmod				\N	0
163	そこにハンカチがどのくらいありますか。	そこにハンカチがどのくらいありますか。	null		\N	vmod				\N	0
164	30枚くらいあります。	30枚くらいあります。	null		\N	vmod				\N	0
165	今、５時です。	今、５時です。	null		\N	vmod				\N	0
166	今、何時ですか。	今、何時ですか。	null		\N	vmod				\N	0
167	４時です。	４時です。	null		\N	vmod				\N	0
168	今、何時何分ですか。	今、何時何分ですか。	null		\N	vmod				\N	0
169	10時51分です。	10時51分です。	null		\N	vmod				\N	0
170	きょうは何月何日ですか。	きょうは何月何日ですか。	null		\N	vmod				\N	0
171	5月21日です。	5月21日です。	null		\N	vmod				\N	0
172	あしたは何曜日ですか。	あしたは何曜日ですか。	null		\N	vmod				\N	0
173	日曜日です。	日曜日です。	null		\N	vmod				\N	0
174	わたしは毎日勉強します。	わたしは毎日勉強します。	null		\N	vmod				\N	0
175	わたしは毎日勉強しません。	わたしは毎日勉強しません。	null		\N	vmod				\N	0
176	テレビはピアノのそばにあります。	テレビはピアノのそばにあります。	null		\N	vmod				\N	0
177	田中さんは教室にいます。	田中さんは教室にいます。	null		\N	vmod				\N	0
178	田中さんはこれから図書館で勉強します。	田中さんはこれから図書館で勉強します。	null		\N	vmod				\N	0
179	わたしはあした研究室にいます。	わたしはあした研究室にいます。	null		\N	vmod				\N	0
180	あしたパーティーがあります。	あしたパーティーがあります。	null		\N	vmod				\N	0
181	わたしはあした研究室にいません。	わたしはあした研究室にいません。	null		\N	vmod				\N	0
182	あした、小説家の山口さんが来ます。	あした、小説家の山口さんが来ます。	null		\N	vmod				\N	0
183	毎日、学校へ行きます。	毎日、学校へ行きます。	null		\N	vmod				\N	0
184	田中さんは図書館で勉強しますが、わたしは家で勉強します。	田中さんは図書館で勉強しますが、わたしは家で勉強します。	null		\N	vmod				\N	0
185	熱がありますから、休みます。	熱がありますから、休みます。	null		\N	vmod				\N	0
186	テレビはピアノのそばにありますか。	テレビはピアノのそばにありますか。	null		\N	vmod				\N	0
187	テレビがピアノのそばにあるかどうか	テレビがピアノのそばにあるかどうか	null		\N	vmod				\N	0
188	田中さんは教室にいますか。	田中さんは教室にいますか。	null		\N	vmod				\N	0
189	田中さんが教室にいるかどうか	田中さんが教室にいるかどうか	null		\N	vmod				\N	0
190	これから図書館で勉強しますか。	これから図書館で勉強しますか。	null		\N	vmod				\N	0
191	聞き手がこれから図書館で勉強するかどうか	聞き手がこれから図書館で勉強するかどうか	null		\N	vmod				\N	0
192	’A：田中さんは教室にいますか。	’A：田中さんは教室にいますか。	null		\N	vmod				\N	0
193	はい、います。	はい、います。	null		\N	vmod				\N	0
194	きのうわたしは勉強しました。	きのうわたしは勉強しました。	null		\N	vmod				\N	0
195	むかし、学校の門のそばに大きい木がありました。	むかし、学校の門のそばに大きい木がありました。	null		\N	vmod				\N	0
196	きのう地震がありましたか。	きのう地震がありましたか。	null		\N	vmod				\N	0
197	はい、ありました。	はい、ありました。	null		\N	vmod				\N	0
198	きのうは雨が降りませんでした。	きのうは雨が降りませんでした。	null		\N	vmod				\N	0
199	試験は終わりましたか。	試験は終わりましたか。	null		\N	vmod				\N	0
200	はい、終わりました。	はい、終わりました。	null		\N	vmod				\N	0
201	試験は終わりましたか。	試験は終わりましたか。	null		\N	vmod				\N	0
202	B1：はい、もう終わりました。	B1：はい、もう終わりました。	null		\N	vmod				\N	0
203	B2：いいえ、まだです。	B2：いいえ、まだです。	null		\N	vmod				\N	0
204	学校へ行きます。	学校へ行きます。	null		\N	vmod				\N	0
205	うちへ帰ります。	うちへ帰ります。	null		\N	vmod				\N	0
206	公園へ行きますか。	公園へ行きますか。	null		\N	vmod				\N	0
207	いいえ、行きません。	いいえ、行きません。	null		\N	vmod				\N	0
208	’学校に行きます。	’学校に行きます。	null		\N	vmod				\N	0
209	’うちに帰ります。	’うちに帰ります。	null		\N	vmod				\N	0
210	’A：公園に行きますか。	’A：公園に行きますか。	null		\N	vmod				\N	0
211	いいえ、行きません。	いいえ、行きません。	null		\N	vmod				\N	0
1244	Ada buku di atas meja. 	机の　上に　本が　あります。	null		\N	vmod				\N	1
299	映画を見た。	映画を見た。	null		\N	vmod				\N	0
212	わたしはハンバーガーを食べます。	わたしはハンバーガーを食べます。	null		\N	vmod				\N	0
213	田中さんはコーラを飲みます。	田中さんはコーラを飲みます。	null		\N	vmod				\N	0
214	CDを買います。	CDを買います。	null		\N	vmod				\N	0
215	何を食べますか。	何を食べますか。	null		\N	vmod				\N	0
216	サンドイッチを食べます。	サンドイッチを食べます。	null		\N	vmod				\N	0
217	あした映画を見ますか。	あした映画を見ますか。	null		\N	vmod				\N	0
218	いいえ、見ません。	いいえ、見ません。	null		\N	vmod				\N	0
219	田中さんに手紙を出します。	田中さんに手紙を出します。	null		\N	vmod				\N	0
220	山田さんにお金を貸します。	山田さんにお金を貸します。	null		\N	vmod				\N	0
221	木村さんに英語を教えます。	木村さんに英語を教えます。	null		\N	vmod				\N	0
222	山田さんにお金を借ります。	山田さんにお金を借ります。	null		\N	vmod				\N	0
223	木村さんにフランス語を習います。	木村さんにフランス語を習います。	null		\N	vmod				\N	0
224	壁にシールをはります。	壁にシールをはります。	null		\N	vmod				\N	0
225	机に本を置きます。	机に本を置きます。	null		\N	vmod				\N	0
226	山田さんに本を見せます。	山田さんに本を見せます。	null		\N	vmod				\N	0
1685	田中さんの本	田中さんの本	null		\N	vmod				\N	1
227	いつテニスをしますか。	いつテニスをしますか。	null		\N	vmod				\N	0
228	あしたテニスをします。	あしたテニスをします。	null		\N	vmod				\N	0
229	土曜日、何をしましたか。	土曜日、何をしましたか。	null		\N	vmod				\N	0
230	映画を見ました。	映画を見ました。	null		\N	vmod				\N	0
231	わたしは夏休みに旅行しました。	わたしは夏休みに旅行しました。	null		\N	vmod				\N	0
511	わたしを助けてください。	わたしを助けてください。	null		\N	vmod				\N	0
232	山田さんの誕生日にパーティーをします。	山田さんの誕生日にパーティーをします。	null		\N	vmod				\N	0
233	このりんごはあまいです。	このりんごはあまいです。	null		\N	vmod				\N	0
234	あのりんごはあまくありません。	あのりんごはあまくありません。	null		\N	vmod				\N	0
235	わたしの家の犬は大きいです。	わたしの家の犬は大きいです。	null		\N	vmod				\N	0
236	となりの家の犬は大きくありません。	となりの家の犬は大きくありません。	null		\N	vmod				\N	0
237	きょうは寒くないです。	きょうは寒くないです。	null		\N	vmod				\N	0
238	あまいです。	あまいです。	null		\N	vmod				\N	0
239	大きいです。	大きいです。	null		\N	vmod				\N	0
240	勉強はおもしろいですか。	勉強はおもしろいですか。	null		\N	vmod				\N	0
241	はい、おもしろいです。	はい、おもしろいです。	null		\N	vmod				\N	0
242	外は寒いですか。	外は寒いですか。	null		\N	vmod				\N	0
243	はい、寒いです。	はい、寒いです。	null		\N	vmod				\N	0
244	外は寒いですか。	外は寒いですか。	null		\N	vmod				\N	0
245	いいえ、寒くありません。	いいえ、寒くありません。	null		\N	vmod				\N	0
246	勉強はおもしろいですか。	勉強はおもしろいですか。	null		\N	vmod				\N	0
247	はい、おもしろいです。	はい、おもしろいです。	null		\N	vmod				\N	0
248	日本の料理はどうですか。	日本の料理はどうですか。	null		\N	vmod				\N	0
249	おいしいです。	おいしいです。	null		\N	vmod				\N	0
250	どんなかばんですか。	どんなかばんですか。	null		\N	vmod				\N	0
251	赤いです。	赤いです。	null		\N	vmod				\N	0
252	このかばんは高かったです。	このかばんは高かったです。	null		\N	vmod				\N	0
253	このかばんは高かったです。	このかばんは高かったです。	null		\N	vmod				\N	0
254	パーティーの料理はおいしくありませんでした。	パーティーの料理はおいしくありませんでした。	null		\N	vmod				\N	0
255	きのうは寒くなかったです。	きのうは寒くなかったです。	null		\N	vmod				\N	0
256	北海道はどうでしたか。	北海道はどうでしたか。	null		\N	vmod				\N	0
257	寒かったです。	寒かったです。	null		\N	vmod				\N	0
258	きのうの映画はどうでしたか。	きのうの映画はどうでしたか。	null		\N	vmod				\N	0
259	おもしろくありませんでした。	おもしろくありませんでした。	null		\N	vmod				\N	0
260	太郎君の犬はとても大きいです。	太郎君の犬はとても大きいです。	null		\N	vmod				\N	0
261	わたしの部屋はあまり広くありません。	わたしの部屋はあまり広くありません。	null		\N	vmod				\N	0
262	とてもつかれました。	とてもつかれました。	null		\N	vmod				\N	0
263	あまりつかれませんでした。	あまりつかれませんでした。	null		\N	vmod				\N	0
264	とても勉強します。	とても勉強します。	null		\N	vmod				\N	0
265	あまり勉強しません。	あまり勉強しません。	null		\N	vmod				\N	0
266	このあたりには、あまり高い建物がありません。	このあたりには、あまり高い建物がありません。	null		\N	vmod				\N	0
268	駅前にいい店があります。	駅前にいい店があります。	null		\N	vmod				\N	0
269	ここはとても静かな部屋です。 	ここはとても静かな部屋です。 	null		\N	vmod				\N	0
270	すてきな服ですね。	すてきな服ですね。	null		\N	vmod				\N	0
271	きょうはハッピーな日です。	きょうはハッピーな日です。	null		\N	vmod				\N	0
272	このかさはじょうぶです。	このかさはじょうぶです。	null		\N	vmod				\N	0
273	そのかさはじょうぶですか。	そのかさはじょうぶですか。	null		\N	vmod				\N	0
274	いいえ、じょうぶではありません。	いいえ、じょうぶではありません。	null		\N	vmod				\N	0
275	田中さんは元気でしたか。	田中さんは元気でしたか。	null		\N	vmod				\N	0
276	はい、元気でした。	はい、元気でした。	null		\N	vmod				\N	0
318	いいえ、知りません。	いいえ、知りません。	null		\N	vmod				\N	0
278	このかさはじょうぶではないです。	このかさはじょうぶではないです。	null		\N	vmod				\N	0
279	田中さんは元気ではなかったです。	田中さんは元気ではなかったです。	null		\N	vmod				\N	0
280	田中さんは髪が長いです。	田中さんは髪が長いです。	null		\N	vmod				\N	0
281	田中さんは背が高いです。	田中さんは背が高いです。	null		\N	vmod				\N	0
282	中山さんは力が強いです。	中山さんは力が強いです。	null		\N	vmod				\N	0
283	うちの猫は目がきれいです。	うちの猫は目がきれいです。	null		\N	vmod				\N	0
284	わたしはきのうからのどが痛いです。	わたしはきのうからのどが痛いです。	null		\N	vmod				\N	0
285	この町は道が狭いです。	この町は道が狭いです。	null		\N	vmod				\N	0
286	この絵は色がきれいです。	この絵は色がきれいです。	null		\N	vmod				\N	0
287	田中さんはバスケットボールがじょうずです。	田中さんはバスケットボールがじょうずです。	null		\N	vmod				\N	0
288	わたしは歌がへたです。	わたしは歌がへたです。	null		\N	vmod				\N	0
289	わたしはピアノが得意です。	わたしはピアノが得意です。	null		\N	vmod				\N	0
290	’ ×わたしはピアノがじょうずです。	’ ×わたしはピアノがじょうずです。	null		\N	vmod				\N	0
292	いいえ、痛くないです。	いいえ、痛くないです。	null		\N	vmod				\N	0
293	田中さん、だいじょうぶですか。	田中さん、だいじょうぶですか。	null		\N	vmod				\N	0
294	ちょっと気分が悪いです。	ちょっと気分が悪いです。	null		\N	vmod				\N	0
295	田中さんは髪が長いです。	田中さんは髪が長いです。	null		\N	vmod				\N	0
296	’田中さんの髪は長いです。	’田中さんの髪は長いです。	null		\N	vmod				\N	0
297	山田さんは、お父さんがよく働きます。	山田さんは、お父さんがよく働きます。	null		\N	vmod				\N	0
298	山田さんは、お父さんが医者です。	山田さんは、お父さんが医者です。	null		\N	vmod				\N	0
300	この雑誌は新しい。	この雑誌は新しい。	null		\N	vmod				\N	0
301	あの電子辞書は便利だ。	あの電子辞書は便利だ。	null		\N	vmod				\N	0
302	きょうは雨だ。	きょうは雨だ。	null		\N	vmod				\N	0
303	今、小林さんは図書館で本を読んでいます。	今、小林さんは図書館で本を読んでいます。	null		\N	vmod				\N	0
304	田中さんは今何をしていますか。	田中さんは今何をしていますか。	null		\N	vmod				\N	0
305	ごはんを食べています。	ごはんを食べています。	null		\N	vmod				\N	0
306	いつから日本語を勉強していますか。	いつから日本語を勉強していますか。	null		\N	vmod				\N	0
307	去年から勉強しています。	去年から勉強しています。	null		\N	vmod				\N	0
308	日本語の辞書はありますか。	日本語の辞書はありますか。	null		\N	vmod				\N	0
309	すみません、今使っています。	すみません、今使っています。	null		\N	vmod				\N	0
310	木村さんをお願いします。	木村さんをお願いします。	null		\N	vmod				\N	0
311	木村さんは今食事をしています。	木村さんは今食事をしています。	null		\N	vmod				\N	0
312	体育館の前に小林さんが立っています。	体育館の前に小林さんが立っています。	null		\N	vmod				\N	0
313	窓が開いています。	窓が開いています。	null		\N	vmod				\N	0
314	わたしは毎朝ジョギングをしています。	わたしは毎朝ジョギングをしています。	null		\N	vmod				\N	0
315	わたしは３年前アメリカで勉強しています。	わたしは３年前アメリカで勉強しています。	null		\N	vmod				\N	0
316	山田さんは10年前に大学を卒業しています。	山田さんは10年前に大学を卒業しています。	null		\N	vmod				\N	0
317	山田先生を知っていますか。	山田先生を知っていますか。	null		\N	vmod				\N	0
319	この道は曲がっています。	この道は曲がっています。	null		\N	vmod				\N	0
320	ビルがそびえています。	ビルがそびえています。	null		\N	vmod				\N	0
321	山田さんはお父さんに似ています。	山田さんはお父さんに似ています。	null		\N	vmod				\N	0
322	もしもし、まりさんはいますか。	もしもし、まりさんはいますか。	null		\N	vmod				\N	0
323	いいえ。まりは今買い物に行っています。	いいえ。まりは今買い物に行っています。	null		\N	vmod				\N	0
324	窓が閉めてあります。	窓が閉めてあります。	null		\N	vmod				\N	0
325	電気が消してありました。	電気が消してありました。	null		\N	vmod				\N	0
326	駅のホームに新しい映画のポスターがはってありました。	駅のホームに新しい映画のポスターがはってありました。	null		\N	vmod				\N	0
327	問題は15ページに書いてあります。	問題は15ページに書いてあります。	null		\N	vmod				\N	0
328	机の上に辞書が置いてありますか。	机の上に辞書が置いてありますか。	null		\N	vmod				\N	0
329	はい、置いてあります。	はい、置いてあります。	null		\N	vmod				\N	0
330	あ、ケーキが切ってありますよ。	あ、ケーキが切ってありますよ。	null		\N	vmod				\N	0
331	じゃあ、食べましょう。	じゃあ、食べましょう。	null		\N	vmod				\N	0
332	窓が開けてあります。	窓が開けてあります。	null		\N	vmod				\N	0
333	’ ×窓が開いてあります。	’ ×窓が開いてあります。	null		\N	vmod				\N	0
334	窓が開けてあります。	窓が開けてあります。	null		\N	vmod				\N	0
336	窓が開けてあります。	窓が開けてあります。	null		\N	vmod				\N	0
337	'''窓が開いています。	'''窓が開いています。	null		\N	vmod				\N	0
338	小林さんに来週の予定を話してありますか。	小林さんに来週の予定を話してありますか。	null		\N	vmod				\N	0
339	いいえ、まだです。	いいえ、まだです。	null		\N	vmod				\N	0
340	漢字を調べてありますか。	漢字を調べてありますか。	null		\N	vmod				\N	0
341	はい、調べました。	はい、調べました。	null		\N	vmod				\N	0
342	田中さんと山田さんは大学２年生です。	田中さんと山田さんは大学２年生です。	null		\N	vmod				\N	0
343	わたしはパンとサラダを食べます。	わたしはパンとサラダを食べます。	null		\N	vmod				\N	0
344	机の上に本とノートがあります。	机の上に本とノートがあります。	null		\N	vmod				\N	0
345	月曜日と水曜日と金曜日にサッカーの練習があります。	月曜日と水曜日と金曜日にサッカーの練習があります。	null		\N	vmod				\N	0
346	［田中さんと山田さん］は大学2年生です。	［田中さんと山田さん］は大学2年生です。	null		\N	vmod				\N	0
347	わたしは［パンとサラダ］を食べます。	わたしは［パンとサラダ］を食べます。	null		\N	vmod				\N	0
348	机の上に［本とノート］があります。	机の上に［本とノート］があります。	null		\N	vmod				\N	0
349	［月曜日と水曜日と金曜日］にサッカーの練習があります。	［月曜日と水曜日と金曜日］にサッカーの練習があります。	null		\N	vmod				\N	0
350	わたしは日曜日に［漫画や雑誌］を読みます。	わたしは日曜日に［漫画や雑誌］を読みます。	null		\N	vmod				\N	0
351	［デパートやスーパー］で買い物をします。	［デパートやスーパー］で買い物をします。	null		\N	vmod				\N	0
470	台風で電車が遅れました。	台風で電車が遅れました。	null		\N	vmod				\N	0
352	［郵便局の前や駅のそば］にポストがあります。	［郵便局の前や駅のそば］にポストがあります。	null		\N	vmod				\N	0
353	［パンや卵］などを食べます。	［パンや卵］などを食べます。	null		\N	vmod				\N	0
354	わたしの部屋に［机やベッドやテレビ］などがあります。	わたしの部屋に［机やベッドやテレビ］などがあります。	null		\N	vmod				\N	0
355	大きくて黒いかばんはわたしのです。	大きくて黒いかばんはわたしのです。	null		\N	vmod				\N	0
356	きれいで静かなアパートに住んでいます。	きれいで静かなアパートに住んでいます。	null		\N	vmod				\N	0
357	３年生で留学生の金さん	３年生で留学生の金さん	null		\N	vmod				\N	0
1310	あの黒いかばんです。	あの黒いかばんです。	null		\N	vmod				\N	1
359	→(5)木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	→(5)木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	null		\N	vmod				\N	0
360	→(6)田中さんは３年生で、中村さんは４年生です。	→(6)田中さんは３年生で、中村さんは４年生です。	null		\N	vmod				\N	0
361	親切でおもしろい人	親切でおもしろい人	null		\N	vmod				\N	0
362	若くてお金持ちの人	若くてお金持ちの人	null		\N	vmod				\N	0
363	この靴下は、じょうぶで安いです。	この靴下は、じょうぶで安いです。	null		\N	vmod				\N	0
364	’×この靴下は、じょうぶで高いです。	’×この靴下は、じょうぶで高いです。	null		\N	vmod				\N	0
365	" この靴下はじょうぶですが、高いです。	" この靴下はじょうぶですが、高いです。	null		\N	vmod				\N	0
366	→(10)田中さんは背が高くてめがねをかけています。	→(10)田中さんは背が高くてめがねをかけています。	null		\N	vmod				\N	0
367	この本は漢字が多くて難しいです。	この本は漢字が多くて難しいです。	null		\N	vmod				\N	0
368	熱が高くて、学校へ行くことができませんでした。	熱が高くて、学校へ行くことができませんでした。	null		\N	vmod				\N	0
369	わたしは夏休みにテニスをしたり泳いだりしました。	わたしは夏休みにテニスをしたり泳いだりしました。	null		\N	vmod				\N	0
370	日曜日に弟は本を読んだりテレビを見たりしています。	日曜日に弟は本を読んだりテレビを見たりしています。	null		\N	vmod				\N	0
371	友だちとよく映画を見たりプールに行ったりします。	友だちとよく映画を見たりプールに行ったりします。	null		\N	vmod				\N	0
372	友だちとよく映画を見たりプールに行ったりします。	友だちとよく映画を見たりプールに行ったりします。	null		\N	vmod				\N	0
373	飛行機で東京と大阪を行ったり来たりします。	飛行機で東京と大阪を行ったり来たりします。	null		\N	vmod				\N	0
374	雨が降ったりやんだりしています。	雨が降ったりやんだりしています。	null		\N	vmod				\N	0
375	→(1) あしたわたしは駅で友だちに会って、いっしょにコンサートに行きます。	→(1) あしたわたしは駅で友だちに会って、いっしょにコンサートに行きます。	null		\N	vmod				\N	0
563	はい。	はい。	null		\N	vmod				\N	0
376	あしたわたしは駅で友だちに会って、いっしょにコンサートに行きます。	あしたわたしは駅で友だちに会って、いっしょにコンサートに行きます。	null		\N	vmod				\N	0
377	あしたの予定を教えてください。	あしたの予定を教えてください。	null		\N	vmod				\N	0
378	朝７時に起きて、食堂で朝ごはんを食べて、８時から練習します。	朝７時に起きて、食堂で朝ごはんを食べて、８時から練習します。	null		\N	vmod				\N	0
379	わたしは日本へ行って、すもうを見たいです。	わたしは日本へ行って、すもうを見たいです。	null		\N	vmod				\N	0
380	２つに折って、はさみで切ってください。	２つに折って、はさみで切ってください。	null		\N	vmod				\N	0
381	あそこに座って、お弁当を食べましょう。	あそこに座って、お弁当を食べましょう。	null		\N	vmod				\N	0
382	わたしは毎日歩いて学校へ行きます。	わたしは毎日歩いて学校へ行きます。	null		\N	vmod				\N	0
383	テープを聞いて、日本語を勉強します。	テープを聞いて、日本語を勉強します。	null		\N	vmod				\N	0
384	夏休みに中山さんは海でダイビングをして、山本さんは山に登りました。	夏休みに中山さんは海でダイビングをして、山本さんは山に登りました。	null		\N	vmod				\N	0
385	田中さんは東京に住んでいて、山本さんは大阪に住んでいます。	田中さんは東京に住んでいて、山本さんは大阪に住んでいます。	null		\N	vmod				\N	0
386	雨が降って、野球の試合を中止しました。	雨が降って、野球の試合を中止しました。	null		\N	vmod				\N	0
387	大きい台風が来て、電車が止まりました。	大きい台風が来て、電車が止まりました。	null		\N	vmod				\N	0
513	あした電話をしてください。	あした電話をしてください。	null		\N	vmod				\N	0
389	’田中さんが来てから、木村さんが帰りました。	’田中さんが来てから、木村さんが帰りました。	null		\N	vmod				\N	0
390	(1)庭の花	(1)庭の花	null		\N	vmod				\N	0
391	(2)山田さんと田中さん	(2)山田さんと田中さん	null		\N	vmod				\N	0
392	(3)机の上に本があります。	(3)机の上に本があります。	null		\N	vmod				\N	0
393	(4)本を読みます。	(4)本を読みます。	null		\N	vmod				\N	0
394	(5)10時から授業を始めます。	(5)10時から授業を始めます。	null		\N	vmod				\N	0
395	(6)朝起きて顔を洗います。	(6)朝起きて顔を洗います。	null		\N	vmod				\N	0
396	(7)春になると暖かくなります。	(7)春になると暖かくなります。	null		\N	vmod				\N	0
397	(8)雨が降ったら運動会は休みです。	(8)雨が降ったら運動会は休みです。	null		\N	vmod				\N	0
398	(9)この本は読みました。	(9)この本は読みました。	null		\N	vmod				\N	0
399	(10)この本も読みました。	(10)この本も読みました。	null		\N	vmod				\N	0
400	(11)この本だけ読みました。	(11)この本だけ読みました。	null		\N	vmod				\N	0
401	(12)この本ばかり読みました。	(12)この本ばかり読みました。	null		\N	vmod				\N	0
402	(13)この本まで読みました。	(13)この本まで読みました。	null		\N	vmod				\N	0
403	(14)この本など読みました。	(14)この本など読みました。	null		\N	vmod				\N	0
404	(15)あしたは日曜日ですか。	(15)あしたは日曜日ですか。	null		\N	vmod				\N	0
405	(16)あしたは日曜日ですよ。	(16)あしたは日曜日ですよ。	null		\N	vmod				\N	0
406	(17)あしたは日曜日ですね。	(17)あしたは日曜日ですね。	null		\N	vmod				\N	0
407	あなた に だけ は 話しましょう。	あなた に だけ は 話しましょう。	null		\N	vmod				\N	0
408	きょうのテストは３時からです よ ね。	きょうのテストは３時からです よ ね。	null		\N	vmod				\N	0
409	山田さんが本を読みました。	山田さんが本を読みました。	null		\N	vmod				\N	0
410	空が青いです。	空が青いです。	null		\N	vmod				\N	0
411	田中さんが最初です。	田中さんが最初です。	null		\N	vmod				\N	0
412	わたしは本を読みました。	わたしは本を読みました。	null		\N	vmod				\N	0
413	わたし、大学へ行きます。	わたし、大学へ行きます。	null		\N	vmod				\N	0
414	大学を卒業します。	大学を卒業します。	null		\N	vmod				\N	0
415	学校を休みます。	学校を休みます。	null		\N	vmod				\N	0
416	楽しい１日を過ごしました。	楽しい１日を過ごしました。	null		\N	vmod				\N	0
417	あらしの中を走りました。	あらしの中を走りました。	null		\N	vmod				\N	0
418	拍手の中を歩きました。	拍手の中を歩きました。	null		\N	vmod				\N	0
419	パンだけ食べました。	パンだけ食べました。	null		\N	vmod				\N	0
420	パン、食べました。	パン、食べました。	null		\N	vmod				\N	0
421	壁に写真をはります。	壁に写真をはります。	null		\N	vmod				\N	0
422	ゴミ箱にごみを捨てます。	ゴミ箱にごみを捨てます。	null		\N	vmod				\N	0
423	犬が山田さんにほえました。	犬が山田さんにほえました。	null		\N	vmod				\N	0
424	先生に相談します。	先生に相談します。	null		\N	vmod				\N	0
425	東京に行きます。	東京に行きます。	null		\N	vmod				\N	0
426	家に帰ります。	家に帰ります。	null		\N	vmod				\N	0
427	飛行機に乗ります。	飛行機に乗ります。	null		\N	vmod				\N	0
428	駅の前に集まります。	駅の前に集まります。	null		\N	vmod				\N	0
429	氷が水になりました。	氷が水になりました。	null		\N	vmod				\N	0
430	山田さんは子どもを政治家にしました。	山田さんは子どもを政治家にしました。	null		\N	vmod				\N	0
431	山田さんに本を読ませます。	山田さんに本を読ませます。	null		\N	vmod				\N	0
432	先生にほめられました。	先生にほめられました。	null		\N	vmod				\N	0
433	田中さんに本を見せます。	田中さんに本を見せます。	null		\N	vmod				\N	0
434	お母さんに見つかりました。	お母さんに見つかりました。	null		\N	vmod				\N	0
435	木村さんに英語を教わりました。	木村さんに英語を教わりました。	null		\N	vmod				\N	0
436	山田さんはお父さんに似ています。	山田さんはお父さんに似ています。	null		\N	vmod				\N	0
437	このズボンはわたしには大きすぎます。	このズボンはわたしには大きすぎます。	null		\N	vmod				\N	0
438	テレビは目によくないです。	テレビは目によくないです。	null		\N	vmod				\N	0
439	１回に３袋ずつ使います。	１回に３袋ずつ使います。	null		\N	vmod				\N	0
440	ホテルに泊まります。	ホテルに泊まります。	null		\N	vmod				\N	0
441	大学の近くに家を建てます。	大学の近くに家を建てます。	null		\N	vmod				\N	0
442	庭に花が咲きます。	庭に花が咲きます。	null		\N	vmod				\N	0
443	今年の３月15日に日本に来ました。	今年の３月15日に日本に来ました。	null		\N	vmod				\N	0
444	買い物に行きます。	買い物に行きます。	null		\N	vmod				\N	0
445	シャツを買いに行きます。	シャツを買いに行きます。	null		\N	vmod				\N	0
446	えんぴつは字を書くのに使います。	えんぴつは字を書くのに使います。	null		\N	vmod				\N	0
447	山田さんに佐藤さんに田中さんが来ました。	山田さんに佐藤さんに田中さんが来ました。	null		\N	vmod				\N	0
448	人の多さにびっくりしました。	人の多さにびっくりしました。	null		\N	vmod				\N	0
449	カラオケで歌いに歌って、声が出なくなりました。	カラオケで歌いに歌って、声が出なくなりました。	null		\N	vmod				\N	0
450	飛行機が南へ飛んでいきます。	飛行機が南へ飛んでいきます。	null		\N	vmod				\N	0
451	学校へ行きます。	学校へ行きます。	null		\N	vmod				\N	0
452	ぶどうからワインを作ります。	ぶどうからワインを作ります。	null		\N	vmod				\N	0
453	田中さんから本を贈りました。	田中さんから本を贈りました。	null		\N	vmod				\N	0
454	先生から質問を出しました。	先生から質問を出しました。	null		\N	vmod				\N	0
455	わたしから説明します。	わたしから説明します。	null		\N	vmod				\N	0
456	鈴木さんから説明させました。	鈴木さんから説明させました。	null		\N	vmod				\N	0
457	先生からほめられました。	先生からほめられました。	null		\N	vmod				\N	0
458	佐藤さんは鈴木さんより年上です。	佐藤さんは鈴木さんより年上です。	null		\N	vmod				\N	0
459	白線より中に入らないでください。	白線より中に入らないでください。	null		\N	vmod				\N	0
460	これより会議を始めます。	これより会議を始めます。	null		\N	vmod				\N	0
461	世界で一番長い川はナイル川です。	世界で一番長い川はナイル川です。	null		\N	vmod				\N	0
462	日本では、３月と４月と５月は春です。	日本では、３月と４月と５月は春です。	null		\N	vmod				\N	0
463	片道で100円、往復で200円です。	片道で100円、往復で200円です。	null		\N	vmod				\N	0
464	これで十分です。	これで十分です。	null		\N	vmod				\N	0
465	ペンで字を書きます。	ペンで字を書きます。	null		\N	vmod				\N	0
466	バスで学校に行きます。	バスで学校に行きます。	null		\N	vmod				\N	0
467	佐藤さんは大きい声で話します。	佐藤さんは大きい声で話します。	null		\N	vmod				\N	0
468	木で机を作ります。	木で机を作ります。	null		\N	vmod				\N	0
469	病気で学校を休みました。	病気で学校を休みました。	null		\N	vmod				\N	0
1686	雨の降る日	雨の降る日	null		\N	vmod				\N	1
471	子どもがはだしで歩いています。	子どもがはだしで歩いています。	null		\N	vmod				\N	0
472	子どもがはだかで走っています。	子どもがはだかで走っています。	null		\N	vmod				\N	0
473	いつもひとりで勉強しています。	いつもひとりで勉強しています。	null		\N	vmod				\N	0
474	家族全員でドライブしました。	家族全員でドライブしました。	null		\N	vmod				\N	0
475	日本語が１年間で上手になりました。	日本語が１年間で上手になりました。	null		\N	vmod				\N	0
519	ええ、いいですよ。	ええ、いいですよ。	null		\N	vmod				\N	0
476	このコンピューターを20万円で買いました。	このコンピューターを20万円で買いました。	null		\N	vmod				\N	0
477	あと10分で５時です。	あと10分で５時です。	null		\N	vmod				\N	0
479	警察で事件を調べています。	警察で事件を調べています。	null		\N	vmod				\N	0
480	クラスで旅行に出かけました。	クラスで旅行に出かけました。	null		\N	vmod				\N	0
481	その仕事は自分でやります。	その仕事は自分でやります。	null		\N	vmod				\N	0
482	田中さんと山田さんが来ました。	田中さんと山田さんが来ました。	null		\N	vmod				\N	0
483	田中さんはお父さんと似ています。	田中さんはお父さんと似ています。	null		\N	vmod				\N	0
484	あのかばんはわたしのかばんと同じです。　	あのかばんはわたしのかばんと同じです。　	null		\N	vmod				\N	0
485	このノートはわたしのノートと違います。	このノートはわたしのノートと違います。	null		\N	vmod				\N	0
486	朝起きたときには「おはようございます」と言います。	朝起きたときには「おはようございます」と言います。	null		\N	vmod				\N	0
487	この漢字は「やま」と読みます。	この漢字は「やま」と読みます。	null		\N	vmod				\N	0
488	佐藤さんや田中さんが来ました。	佐藤さんや田中さんが来ました。	null		\N	vmod				\N	0
489	これをください。	これをください。	null		\N	vmod				\N	0
491	書類のコピーをください。	書類のコピーをください。	null		\N	vmod				\N	0
492	すみません、水をくださいませんか。	すみません、水をくださいませんか。	null		\N	vmod				\N	0
493	はい。	はい。	null		\N	vmod				\N	0
494	あのう、この町の地図をくださいませんか。	あのう、この町の地図をくださいませんか。	null		\N	vmod				\N	0
495	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	0
496	ハンバーガーとサラダをお願いします。	ハンバーガーとサラダをお願いします。	null		\N	vmod				\N	0
497	はい。	はい。	null		\N	vmod				\N	0
498	りんご、ください。	りんご、ください。	null		\N	vmod				\N	0
499	ハンバーグ、ください。	ハンバーグ、ください。	null		\N	vmod				\N	0
500	赤いばらを８本ください。	赤いばらを８本ください。	null		\N	vmod				\N	0
501	はい。1200円です。	はい。1200円です。	null		\N	vmod				\N	0
502	コーラを２つお願いします。	コーラを２つお願いします。	null		\N	vmod				\N	0
503	かしこまりました。	かしこまりました。	null		\N	vmod				\N	0
504	教科書の15ページを見てください。	教科書の15ページを見てください。	null		\N	vmod				\N	0
505	テープの会話を聞いてください。	テープの会話を聞いてください。	null		\N	vmod				\N	0
506	３年生は手をあげてください。	３年生は手をあげてください。	null		\N	vmod				\N	0
507	２年生は、あした８時に学校へ来てください。	２年生は、あした８時に学校へ来てください。	null		\N	vmod				\N	0
508	名前を書いてください。 	名前を書いてください。 	null		\N	vmod				\N	0
509	はい、わかりました。	はい、わかりました。	null		\N	vmod				\N	0
510	どうかゆるしてください。	どうかゆるしてください。	null		\N	vmod				\N	0
512	ちょっと待ってください。	ちょっと待ってください。	null		\N	vmod				\N	0
514	がんばってください。	がんばってください。	null		\N	vmod				\N	0
515	安心してください。	安心してください。	null		\N	vmod				\N	0
516	ぜひ来てください。	ぜひ来てください。	null		\N	vmod				\N	0
517	もう一度説明してくださいませんか。	もう一度説明してくださいませんか。	null		\N	vmod				\N	0
518	すみません、窓を開けてくださいませんか。	すみません、窓を開けてくださいませんか。	null		\N	vmod				\N	0
521	ええ、いいですよ。	ええ、いいですよ。	null		\N	vmod				\N	0
522	この部屋でお弁当を食べてもいいです。	この部屋でお弁当を食べてもいいです。	null		\N	vmod				\N	0
523	このコピー機は学生が使ってもいいですよ。	このコピー機は学生が使ってもいいですよ。	null		\N	vmod				\N	0
524	辞書を見てもいいですか。　	辞書を見てもいいですか。　	null		\N	vmod				\N	0
525	いいえ、いけません。	いいえ、いけません。	null		\N	vmod				\N	0
526	病院で携帯電話を使ってはいけません。	病院で携帯電話を使ってはいけません。	null		\N	vmod				\N	0
527	この部屋でたばこをすってはいけません。	この部屋でたばこをすってはいけません。	null		\N	vmod				\N	0
528	しばらくお酒を飲んではだめです。	しばらくお酒を飲んではだめです。	null		\N	vmod				\N	0
529	この教室は使っちゃいけませんよ。	この教室は使っちゃいけませんよ。	null		\N	vmod				\N	0
530	泣いちゃだめですよ。	泣いちゃだめですよ。	null		\N	vmod				\N	0
531	木村さん、その本を借りてはいけませんか。	木村さん、その本を借りてはいけませんか。	null		\N	vmod				\N	0
532	’木村さん、その本を借りてもいいですか。	’木村さん、その本を借りてもいいですか。	null		\N	vmod				\N	0
533	ここではたばこをすわないでください。	ここではたばこをすわないでください。	null		\N	vmod				\N	0
534	きょうはおふろに入らないでください。	きょうはおふろに入らないでください。	null		\N	vmod				\N	0
535	コンピューターを使っています。スイッチを切らないでください。	コンピューターを使っています。スイッチを切らないでください。	null		\N	vmod				\N	0
536	どうかおこらないでください。	どうかおこらないでください。	null		\N	vmod				\N	0
537	わたしを殺さないでください。	わたしを殺さないでください。	null		\N	vmod				\N	0
538	不合格にしないでください。	不合格にしないでください。	null		\N	vmod				\N	0
539	だいじょうぶです。心配しないでください。	だいじょうぶです。心配しないでください。	null		\N	vmod				\N	0
540	あまり無理をしないでください。	あまり無理をしないでください。	null		\N	vmod				\N	0
541	気にしないでください。	気にしないでください。	null		\N	vmod				\N	0
542	どうぞ遠慮しないでください。	どうぞ遠慮しないでください。	null		\N	vmod				\N	0
543	ペンでもいいですか。	ペンでもいいですか。	null		\N	vmod				\N	0
544	B1：はい、いいです。	B1：はい、いいです。	null		\N	vmod				\N	0
545	B2：いいえ、だめです。	B2：いいえ、だめです。	null		\N	vmod				\N	0
546	レポートはあしたでもいいですか。	レポートはあしたでもいいですか。	null		\N	vmod				\N	0
547	B1：はい、あしたでもいいです。	B1：はい、あしたでもいいです。	null		\N	vmod				\N	0
548	B2：いいえ、あしたではだめです。	B2：いいえ、あしたではだめです。	null		\N	vmod				\N	0
549	レポートはあしたでもいいですか。	レポートはあしたでもいいですか。	null		\N	vmod				\N	0
550	B1：はい、あしたでもいいです。	B1：はい、あしたでもいいです。	null		\N	vmod				\N	0
551	B2：いいえ、あしたではだめです。	B2：いいえ、あしたではだめです。	null		\N	vmod				\N	0
552	レポートはあしたでもいいですか。	レポートはあしたでもいいですか。	null		\N	vmod				\N	0
553	B1：はい、あしたでもいいです。	B1：はい、あしたでもいいです。	null		\N	vmod				\N	0
554	B2：いいえ、あしたではだめです。	B2：いいえ、あしたではだめです。	null		\N	vmod				\N	0
555	パーティーは、ジーンズではいけません。	パーティーは、ジーンズではいけません。	null		\N	vmod				\N	0
556	この試験は、えんぴつではだめです。	この試験は、えんぴつではだめです。	null		\N	vmod				\N	0
557	’A：ペンで書いてもいいですか。	’A：ペンで書いてもいいですか。	null		\N	vmod				\N	0
558	’A：レポートはあした出してもいいですか。	’A：レポートはあした出してもいいですか。	null		\N	vmod				\N	0
559	’パーティーは、ジーンズで来てはいけません。	’パーティーは、ジーンズで来てはいけません。	null		\N	vmod				\N	0
560	’この試験は、えんぴつで解答してはだめです。	’この試験は、えんぴつで解答してはだめです。	null		\N	vmod				\N	0
561	"パーティーは、ジーンズじゃいけません。	"パーティーは、ジーンズじゃいけません。	null		\N	vmod				\N	0
562	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	0
564	スケートに行きませんか。	スケートに行きませんか。	null		\N	vmod				\N	0
565	いいですね。	いいですね。	null		\N	vmod				\N	0
566	土曜日の午後、テニスをしませんか。	土曜日の午後、テニスをしませんか。	null		\N	vmod				\N	0
567	すみません。土曜日は仕事があります。	すみません。土曜日は仕事があります。	null		\N	vmod				\N	0
568	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	0
570	いっしょに帰りましょう。	いっしょに帰りましょう。	null		\N	vmod				\N	0
571	はい。	はい。	null		\N	vmod				\N	0
572	信号が青になりました。さあ、渡りましょう。	信号が青になりました。さあ、渡りましょう。	null		\N	vmod				\N	0
573	いっしょに昼ごはんを食べませんか。	いっしょに昼ごはんを食べませんか。	null		\N	vmod				\N	0
574	はい、食べましょう。	はい、食べましょう。	null		\N	vmod				\N	0
575	プールへ行きませんか。	プールへ行きませんか。	null		\N	vmod				\N	0
576	いいですね。行きましょう。	いいですね。行きましょう。	null		\N	vmod				\N	0
577	食事の前には手を洗いましょう。	食事の前には手を洗いましょう。	null		\N	vmod				\N	0
578	手をあげて横断歩道を渡りましょう。	手をあげて横断歩道を渡りましょう。	null		\N	vmod				\N	0
579	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	0
580	ええ、帰りましょう。	ええ、帰りましょう。	null		\N	vmod				\N	0
581	スケートに行きませんか。	スケートに行きませんか。	null		\N	vmod				\N	0
582	いいですね。行きましょう。	いいですね。行きましょう。	null		\N	vmod				\N	0
583	土曜日の午後、テニスをしませんか。	土曜日の午後、テニスをしませんか。	null		\N	vmod				\N	0
584	土曜日ですか。土曜日はちょっと。	土曜日ですか。土曜日はちょっと。	null		\N	vmod				\N	0
585	あした、うちへ遊びに来ませんか。	あした、うちへ遊びに来ませんか。	null		\N	vmod				\N	0
586	ありがとうございます。でも、あしたはちょっと。	ありがとうございます。でも、あしたはちょっと。	null		\N	vmod				\N	0
587	映画を見に行きませんか。	映画を見に行きませんか。	null		\N	vmod				\N	0
588	すみません。アルバイトがあります。	すみません。アルバイトがあります。	null		\N	vmod				\N	0
589	きょうから日記を書こう。	きょうから日記を書こう。	null		\N	vmod				\N	0
590	きょうは食堂で昼食を食べよう。	きょうは食堂で昼食を食べよう。	null		\N	vmod				\N	0
591	あしたもう一度来よう。	あしたもう一度来よう。	null		\N	vmod				\N	0
592	家に帰ったら掃除しよう。	家に帰ったら掃除しよう。	null		\N	vmod				\N	0
593	その荷物はわたしが持ちましょう。	その荷物はわたしが持ちましょう。	null		\N	vmod				\N	0
594	図書館でいっしょに勉強しましょう。	図書館でいっしょに勉強しましょう。	null		\N	vmod				\N	0
595	きょうから日記を書こう。	きょうから日記を書こう。	null		\N	vmod				\N	0
596	きょうは食堂で昼食を食べよう。	きょうは食堂で昼食を食べよう。	null		\N	vmod				\N	0
597	あしたもう一度来よう。	あしたもう一度来よう。	null		\N	vmod				\N	0
598	家に帰ったら掃除しよう。	家に帰ったら掃除しよう。	null		\N	vmod				\N	0
1391	７時に起きます。	７時に起きます。	null		\N	vmod				\N	1
599	この辺で休みましょう。	この辺で休みましょう。	null		\N	vmod				\N	0
600	その仕事はわたしがしましょう。	その仕事はわたしがしましょう。	null		\N	vmod				\N	0
601	わたしは６時に帰ります。	わたしは６時に帰ります。	null		\N	vmod				\N	0
602	’×わたしは６時に帰りましょう。	’×わたしは６時に帰りましょう。	null		\N	vmod				\N	0
603	図書館で勉強しようとしましたが、休みでした。	図書館で勉強しようとしましたが、休みでした。	null		\N	vmod				\N	0
604	西の空に日が沈もうとしています。	西の空に日が沈もうとしています。	null		\N	vmod				\N	0
605	花が散ろうとしています。	花が散ろうとしています。	null		\N	vmod				\N	0
606	あしたは早く起きようと思います。	あしたは早く起きようと思います。	null		\N	vmod				\N	0
607	夏休みに旅行しようと思っています。	夏休みに旅行しようと思っています。	null		\N	vmod				\N	0
608	木村さんは留学しようと思っています。	木村さんは留学しようと思っています。	null		\N	vmod				\N	0
609	夏休みに旅行しようと思っています。	夏休みに旅行しようと思っています。	null		\N	vmod				\N	0
610	木村さんは留学しようと思っています。	木村さんは留学しようと思っています。	null		\N	vmod				\N	0
611	’×木村さんは留学しようと思います。	’×木村さんは留学しようと思います。	null		\N	vmod				\N	0
612	木村さんは留学しようと思いますか。	木村さんは留学しようと思いますか。	null		\N	vmod				\N	0
613	わたしは今度の休みに友だちと旅行したいです。	わたしは今度の休みに友だちと旅行したいです。	null		\N	vmod				\N	0
614	今晩どこへも行きたくありません。	今晩どこへも行きたくありません。	null		\N	vmod				\N	0
615	将来、何になりたいですか。	将来、何になりたいですか。	null		\N	vmod				\N	0
616	日本語の先生になりたいです。	日本語の先生になりたいです。	null		\N	vmod				\N	0
617	どんな音楽を聞きたいですか。	どんな音楽を聞きたいですか。	null		\N	vmod				\N	0
618	日本の音楽を聞きたいです。	日本の音楽を聞きたいです。	null		\N	vmod				\N	0
619	今晩どこへも行きたくありません。	今晩どこへも行きたくありません。	null		\N	vmod				\N	0
620	将来、何になりたいですか。	将来、何になりたいですか。	null		\N	vmod				\N	0
621	日本語の先生になりたいです。	日本語の先生になりたいです。	null		\N	vmod				\N	0
622	どんな音楽を聞きたいですか。	どんな音楽を聞きたいですか。	null		\N	vmod				\N	0
623	日本の音楽を聞きたいです。	日本の音楽を聞きたいです。	null		\N	vmod				\N	0
624	水が飲みたいです。	水が飲みたいです。	null		\N	vmod				\N	0
625	何が食べたいですか。	何が食べたいですか。	null		\N	vmod				\N	0
626	そうですね、サンドイッチが食べたいです。	そうですね、サンドイッチが食べたいです。	null		\N	vmod				\N	0
627	すみません、山田先生と話したいんですが。	すみません、山田先生と話したいんですが。	null		\N	vmod				\N	0
628	はい、ちょっと待ってください。	はい、ちょっと待ってください。	null		\N	vmod				\N	0
629	先生、お手洗いに行きたいんですが。	先生、お手洗いに行きたいんですが。	null		\N	vmod				\N	0
630	はい、いいですよ。	はい、いいですよ。	null		\N	vmod				\N	0
631	’×田中さんは今晩どこへも行きたくないです。	’×田中さんは今晩どこへも行きたくないです。	null		\N	vmod				\N	0
632	山田さんは旅行したがっています。	山田さんは旅行したがっています。	null		\N	vmod				\N	0
1687	鈴木さんの言ったこと	鈴木さんの言ったこと	null		\N	vmod				\N	1
633	東京の大学に行きたかったです。	東京の大学に行きたかったです。	null		\N	vmod				\N	0
634	みんなの前で発表したくありませんでした。	みんなの前で発表したくありませんでした。	null		\N	vmod				\N	0
635	駅まで歩きたくなかったです。	駅まで歩きたくなかったです。	null		\N	vmod				\N	0
636	東京の大学に行きたかったです。	東京の大学に行きたかったです。	null		\N	vmod				\N	0
1777	はい、食べましょう。	はい、食べましょう。	null		\N	vmod				\N	1
637	みんなの前で発表したくありませんでした。	みんなの前で発表したくありませんでした。	null		\N	vmod				\N	0
638	駅まで歩きたくなかったです。	駅まで歩きたくなかったです。	null		\N	vmod				\N	0
639	きのうコンサートに行ってきました。	きのうコンサートに行ってきました。	null		\N	vmod				\N	0
640	そうですか。それはわたしも行きたかったです。	そうですか。それはわたしも行きたかったです。	null		\N	vmod				\N	0
641	わたしは今コンピューターがほしいです。	わたしは今コンピューターがほしいです。	null		\N	vmod				\N	0
642	わたしはコンピューターはほしくありません。	わたしはコンピューターはほしくありません。	null		\N	vmod				\N	0
643	わたしはコンピューターはほしくないです。	わたしはコンピューターはほしくないです。	null		\N	vmod				\N	0
644	車がほしいですか。	車がほしいですか。	null		\N	vmod				\N	0
645	いいえ、｛ほしくありません／ほしくないです｝。	いいえ、｛ほしくありません／ほしくないです｝。	null		\N	vmod				\N	0
646	太郎さんは犬がほしいですか。	太郎さんは犬がほしいですか。	null		\N	vmod				\N	0
893	寒くても、泳ぎます。	寒くても、泳ぎます。	null		\N	vmod				\N	0
647	はい、ほしいです。	はい、ほしいです。	null		\N	vmod				\N	0
648	誕生日に何がほしいですか。	誕生日に何がほしいですか。	null		\N	vmod				\N	0
649	そうですね、新しい自転車がほしいです。	そうですね、新しい自転車がほしいです。	null		\N	vmod				\N	0
650	どれがほしいですか。	どれがほしいですか。	null		\N	vmod				\N	0
651	これとそれがほしいです。	これとそれがほしいです。	null		\N	vmod				\N	0
652	車がほしいですか。	車がほしいですか。	null		\N	vmod				\N	0
653	いいえ、｛ほしくありません／ほしくないです｝。	いいえ、｛ほしくありません／ほしくないです｝。	null		\N	vmod				\N	0
654	誕生日に何がほしいですか。	誕生日に何がほしいですか。	null		\N	vmod				\N	0
655	そうですね、新しい自転車がほしいです。	そうですね、新しい自転車がほしいです。	null		\N	vmod				\N	0
656	どれがほしいですか。	どれがほしいですか。	null		\N	vmod				\N	0
657	これとそれがほしいです。	これとそれがほしいです。	null		\N	vmod				\N	0
658	太郎さんはコンピューターがほしいようです。	太郎さんはコンピューターがほしいようです。	null		\N	vmod				\N	0
659	すみません、白い紙がほしいんですが。	すみません、白い紙がほしいんですが。	null		\N	vmod				\N	0
661	あのう、赤いボールペンがほしいんですが。	あのう、赤いボールペンがほしいんですが。	null		\N	vmod				\N	0
663	太郎さんは新しいコンピューターをほしがっています。	太郎さんは新しいコンピューターをほしがっています。	null		\N	vmod				\N	0
664	先生、コンピューターはお入り用ですか。	先生、コンピューターはお入り用ですか。	null		\N	vmod				\N	0
665	先生、どれがよろしいですか。	先生、どれがよろしいですか。	null		\N	vmod				\N	0
666	わたしは音楽がすきです。	わたしは音楽がすきです。	null		\N	vmod				\N	0
667	わたしはスポーツがすきではありません。	わたしはスポーツがすきではありません。	null		\N	vmod				\N	0
668	田中さんはテニスがすきですか。	田中さんはテニスがすきですか。	null		\N	vmod				\N	0
669	はい、すきです。	はい、すきです。	null		\N	vmod				\N	0
670	水泳はすきですか。	水泳はすきですか。	null		\N	vmod				\N	0
671	いいえ、すきではありません。	いいえ、すきではありません。	null		\N	vmod				\N	0
672	何がすきですか。	何がすきですか。	null		\N	vmod				\N	0
673	りんごがすきです。	りんごがすきです。	null		\N	vmod				\N	0
674	どの科目がすきですか。	どの科目がすきですか。	null		\N	vmod				\N	0
675	数学がすきです。	数学がすきです。	null		\N	vmod				\N	0
676	わたしは犬がきらいです。	わたしは犬がきらいです。	null		\N	vmod				\N	0
677	わたしは犬がきらいではありません。	わたしは犬がきらいではありません。	null		\N	vmod				\N	0
678	すきな食べ物は何ですか。	すきな食べ物は何ですか。	null		\N	vmod				\N	0
679	わたしはつらいです。	わたしはつらいです。	null		\N	vmod				\N	0
680	わたしは仕事がつらいです。	わたしは仕事がつらいです。	null		\N	vmod				\N	0
681	あなたは地震がこわいですか。	あなたは地震がこわいですか。	null		\N	vmod				\N	0
683	’×田中くんは犬がこわいです。	’×田中くんは犬がこわいです。	null		\N	vmod				\N	0
684	田中くんは犬がこわいそうです。	田中くんは犬がこわいそうです。	null		\N	vmod				\N	0
685	田中くんは犬がこわいらしいです。	田中くんは犬がこわいらしいです。	null		\N	vmod				\N	0
686	田中くんは犬がこわかった。	田中くんは犬がこわかった。	null		\N	vmod				\N	0
687	田中くんはいつも犬をこわがります。	田中くんはいつも犬をこわがります。	null		\N	vmod				\N	0
688	田中くんは犬をこわがっています。	田中くんは犬をこわがっています。	null		\N	vmod				\N	0
689	うれしい。	うれしい。	null		\N	vmod				\N	0
690	２年生は５時から体育館を使うことができます。	２年生は５時から体育館を使うことができます。	null		\N	vmod				\N	0
691	きょうは、バスケットボールの練習をすることができません。	きょうは、バスケットボールの練習をすることができません。	null		\N	vmod				\N	0
692	２年生は５時から体育館を使うことができます。	２年生は５時から体育館を使うことができます。	null		\N	vmod				\N	0
693	きょうは、バスケットボールの練習をすることができません。	きょうは、バスケットボールの練習をすることができません。	null		\N	vmod				\N	0
694	中山さんは200メートル泳ぐことができます。	中山さんは200メートル泳ぐことができます。	null		\N	vmod				\N	0
695	わたしは漢字を50書くことができます。	わたしは漢字を50書くことができます。	null		\N	vmod				\N	0
696	中山さんはアラビア語を話すことができますか。	中山さんはアラビア語を話すことができますか。	null		\N	vmod				\N	0
697	いいえ、できません。	いいえ、できません。	null		\N	vmod				\N	0
698	キムさんは日本語ができます。 	キムさんは日本語ができます。 	null		\N	vmod				\N	0
699	田中さんはテニスができます。	田中さんはテニスができます。	null		\N	vmod				\N	0
700	わたしは車の運転ができません。	わたしは車の運転ができません。	null		\N	vmod				\N	0
701	わたしは漢字が書けます。	わたしは漢字が書けます。	null		\N	vmod				\N	0
702	わたしはさしみが食べられます。	わたしはさしみが食べられます。	null		\N	vmod				\N	0
703	あした学校に来られます。	あした学校に来られます。	null		\N	vmod				\N	0
704	水泳ができます。	水泳ができます。	null		\N	vmod				\N	0
705	パーティーに来られますか。	パーティーに来られますか。	null		\N	vmod				\N	0
706	B1：はい、行けます。	B1：はい、行けます。	null		\N	vmod				\N	0
707	B2：いいえ、行けません。	B2：いいえ、行けません。	null		\N	vmod				\N	0
708	図書館で勉強できます。	図書館で勉強できます。	null		\N	vmod				\N	0
709	彼を一生愛せますか。	彼を一生愛せますか。	null		\N	vmod				\N	0
710	’わたしはさしみが食べれます。	’わたしはさしみが食べれます。	null		\N	vmod				\N	0
711	’あした学校にこれます。	’あした学校にこれます。	null		\N	vmod				\N	0
712	あしたは晴れるでしょう。	あしたは晴れるでしょう。	null		\N	vmod				\N	0
713	きょうの試合では、Aチームが勝つでしょう。	きょうの試合では、Aチームが勝つでしょう。	null		\N	vmod				\N	0
714	この問題は、あしたの試験に出るでしょうか。	この問題は、あしたの試験に出るでしょうか。	null		\N	vmod				\N	0
715	たぶん出るでしょう。	たぶん出るでしょう。	null		\N	vmod				\N	0
716	きのう、外語大のチームは勝ちましたか。	きのう、外語大のチームは勝ちましたか。	null		\N	vmod				\N	0
871	家にパソコンがあります。	家にパソコンがあります。	null		\N	vmod				\N	0
717	わかりません。でも、たぶん勝ったでしょう。	わかりません。でも、たぶん勝ったでしょう。	null		\N	vmod				\N	0
718	あそこに人がいますね。あの人はだれでしょう。	あそこに人がいますね。あの人はだれでしょう。	null		\N	vmod				\N	0
721	たぶん来ないでしょう。	たぶん来ないでしょう。	null		\N	vmod				\N	0
722	客：これはいくらでしょうか。	客：これはいくらでしょうか。	null		\N	vmod				\N	0
723	店員：それは1000円です。	店員：それは1000円です。	null		\N	vmod				\N	0
724	あしたは雨が降るだろう。	あしたは雨が降るだろう。	null		\N	vmod				\N	0
725	田中さんは来ないだろう。	田中さんは来ないだろう。	null		\N	vmod				\N	0
726	Aチームが勝っただろう。	Aチームが勝っただろう。	null		\N	vmod				\N	0
727	あしたは日曜日でしょう？	あしたは日曜日でしょう？	null		\N	vmod				\N	0
728	これは田中さんのでしょう？	これは田中さんのでしょう？	null		\N	vmod				\N	0
729	わたしがさっき言ったでしょう。	わたしがさっき言ったでしょう。	null		\N	vmod				\N	0
730	ほら、あそこにコンビニがあるでしょう。	ほら、あそこにコンビニがあるでしょう。	null		\N	vmod				\N	0
731	山田さんは図書館にいるかもしれません。	山田さんは図書館にいるかもしれません。	null		\N	vmod				\N	0
732	今ごろの東京は寒いかもしれません。	今ごろの東京は寒いかもしれません。	null		\N	vmod				\N	0
733	山田さんは猫がきらいかもしれません。	山田さんは猫がきらいかもしれません。	null		\N	vmod				\N	0
734	あの人はもしかすると木村さんのお兄さんかもしれません。	あの人はもしかすると木村さんのお兄さんかもしれません。	null		\N	vmod				\N	0
735	’山田さんは図書館にいるかも。	’山田さんは図書館にいるかも。	null		\N	vmod				\N	0
736	今ごろは、山田さんはひまにちがいありません。 	今ごろは、山田さんはひまにちがいありません。 	null		\N	vmod				\N	0
737	あれは、田村さんにちがいありません。	あれは、田村さんにちがいありません。	null		\N	vmod				\N	0
738	この時計はきっと高いにちがいありません。	この時計はきっと高いにちがいありません。	null		\N	vmod				\N	0
739	妹が帰ってきません。もしかしたら事故にあったのかもしれません。	妹が帰ってきません。もしかしたら事故にあったのかもしれません。	null		\N	vmod				\N	0
740	今10時ですから、郵便局は開いているはずです。	今10時ですから、郵便局は開いているはずです。	null		\N	vmod				\N	0
741	木村さんは英語教師ですから、英語が話せるはずです。	木村さんは英語教師ですから、英語が話せるはずです。	null		\N	vmod				\N	0
742	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。	null		\N	vmod				\N	0
743	木村さんは英語教師です。	木村さんは英語教師です。	null		\N	vmod				\N	0
744	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。	null		\N	vmod				\N	0
745	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。	null		\N	vmod				\N	0
746	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。	null		\N	vmod				\N	0
747	この家はだれか住んでいそうです。	この家はだれか住んでいそうです。	null		\N	vmod				\N	0
748	このおかしは甘そうです。	このおかしは甘そうです。	null		\N	vmod				\N	0
749	この電子辞書は便利そうです。	この電子辞書は便利そうです。	null		\N	vmod				\N	0
750	雨が降りそうです。	雨が降りそうです。	null		\N	vmod				\N	0
751	わたしはきょう早く学校に行けそうです。	わたしはきょう早く学校に行けそうです。	null		\N	vmod				\N	0
752	’×わたしはきょう早く学校に行きそうです。	’×わたしはきょう早く学校に行きそうです。	null		\N	vmod				\N	0
753	ここにおいしそうなおかしがあります。	ここにおいしそうなおかしがあります。	null		\N	vmod				\N	0
754	木村さんはうれしそうに走ってきました。	木村さんはうれしそうに走ってきました。	null		\N	vmod				\N	0
755	庭に車がありません。母は出かけているようです。	庭に車がありません。母は出かけているようです。	null		\N	vmod				\N	0
756	この絵はまるで写真のようです。	この絵はまるで写真のようです。	null		\N	vmod				\N	0
757	小林さんは鳥のような声で歌います。	小林さんは鳥のような声で歌います。	null		\N	vmod				\N	0
758	このロボットは、生きているように動きます。	このロボットは、生きているように動きます。	null		\N	vmod				\N	0
759	あの人は歌手のようです。	あの人は歌手のようです。	null		\N	vmod				\N	0
760	あの人はどうやら歌手のようです。	あの人はどうやら歌手のようです。	null		\N	vmod				\N	0
761	あの人はまるで歌手のようです。	あの人はまるで歌手のようです。	null		\N	vmod				\N	0
762	来月から新しい生徒が来るそうです。	来月から新しい生徒が来るそうです。	null		\N	vmod				\N	0
763	天気予報によると、あしたは雨が降るそうです。	天気予報によると、あしたは雨が降るそうです。	null		\N	vmod				\N	0
764	木村さんが電話に出ない。出かけているらしい。	木村さんが電話に出ない。出かけているらしい。	null		\N	vmod				\N	0
765	山田さんは来月東京に行くらしいです。	山田さんは来月東京に行くらしいです。	null		\N	vmod				\N	0
766	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。	null		\N	vmod				\N	0
767	先生から聞きましたが、来月から新しい生徒が来るそうです。	先生から聞きましたが、来月から新しい生徒が来るそうです。	null		\N	vmod				\N	0
768	うわさによると、山田さんは来月東京に行くらしいです。	うわさによると、山田さんは来月東京に行くらしいです。	null		\N	vmod				\N	0
769	歌舞伎はおもしろいと思います。	歌舞伎はおもしろいと思います。	null		\N	vmod				\N	0
770	わたしはあした雨がふると思います。	わたしはあした雨がふると思います。	null		\N	vmod				\N	0
771	歌舞伎はおもしろいと思います。	歌舞伎はおもしろいと思います。	null		\N	vmod				\N	0
772	田中さんはもう帰ったと思います。	田中さんはもう帰ったと思います。	null		\N	vmod				\N	0
773	あしたも寒いと思いますか。	あしたも寒いと思いますか。	null		\N	vmod				\N	0
774	ええ、たぶん。	ええ、たぶん。	null		\N	vmod				\N	0
775	彼はスポーツが得意だと思います。	彼はスポーツが得意だと思います。	null		\N	vmod				\N	0
776	彼はスポーツが得意ではないと思います。	彼はスポーツが得意ではないと思います。	null		\N	vmod				\N	0
777	彼はスポーツが得意だと思いません。	彼はスポーツが得意だと思いません。	null		\N	vmod				\N	0
778	わたしのペン	わたしのペン	null		\N	vmod				\N	0
779	体育館のとなり	体育館のとなり	null		\N	vmod				\N	0
780	新しいコンピューター	新しいコンピューター	null		\N	vmod				\N	0
781	小さい犬	小さい犬	null		\N	vmod				\N	0
782	元気な人	元気な人	null		\N	vmod				\N	0
783	すてきな絵	すてきな絵	null		\N	vmod				\N	0
784	［きのう書いた作文］をきょう提出しました。	［きのう書いた作文］をきょう提出しました。	null		\N	vmod				\N	0
785	［図書館で勉強している田中さん］を見ました。	［図書館で勉強している田中さん］を見ました。	null		\N	vmod				\N	0
786	あれはわたしが通った学校です。	あれはわたしが通った学校です。	null		\N	vmod				\N	0
787	きのうわたしが行った店	きのうわたしが行った店	null		\N	vmod				\N	0
788	’きのうわたしの行った店	’きのうわたしの行った店	null		\N	vmod				\N	0
789	コーヒーは飲んで、紅茶は飲まない人	コーヒーは飲んで、紅茶は飲まない人	null		\N	vmod				\N	0
790	［外国語を勉強する{こと／の}］は楽しいです。	［外国語を勉強する{こと／の}］は楽しいです。	null		\N	vmod				\N	0
791	［学生が優秀な{こと／の}］が田中先生の自慢です。	［学生が優秀な{こと／の}］が田中先生の自慢です。	null		\N	vmod				\N	0
792	［山田さんが合格した{こと／の}］をきょう知りました。	［山田さんが合格した{こと／の}］をきょう知りました。	null		\N	vmod				\N	0
793	外国語を勉強する{こと／の}は楽しいです。	外国語を勉強する{こと／の}は楽しいです。	null		\N	vmod				\N	0
794	学生が優秀な{こと／の}が田中先生の自慢です。	学生が優秀な{こと／の}が田中先生の自慢です。	null		\N	vmod				\N	0
795	田中さんが走っているのを見ました。	田中さんが走っているのを見ました。	null		\N	vmod				\N	0
796	山田さんが本を読んでいるのが聞こえます。	山田さんが本を読んでいるのが聞こえます。	null		\N	vmod				\N	0
797	木村さんが来るのを待ちます。	木村さんが来るのを待ちます。	null		\N	vmod				\N	0
798	大学に進学することを勧めます。	大学に進学することを勧めます。	null		\N	vmod				\N	0
799	わたしはアメリカに留学することを考えています。	わたしはアメリカに留学することを考えています。	null		\N	vmod				\N	0
800	雨が降ったので試合が中止になりました。	雨が降ったので試合が中止になりました。	null		\N	vmod				\N	0
801	もう遅いので、これで帰ります。	もう遅いので、これで帰ります。	null		\N	vmod				\N	0
802	このカメラが便利なので、これにしませんか。	このカメラが便利なので、これにしませんか。	null		\N	vmod				\N	0
803	あしたが提出日ですので、気をつけてください。	あしたが提出日ですので、気をつけてください。	null		\N	vmod				\N	0
804	きのうは祭日でしたから、学校は休みでした。	きのうは祭日でしたから、学校は休みでした。	null		\N	vmod				\N	0
805	くすりを飲みましたから、もうだいじょうぶです。	くすりを飲みましたから、もうだいじょうぶです。	null		\N	vmod				\N	0
806	あしたは授業がないから、学校へ行きません。	あしたは授業がないから、学校へ行きません。	null		\N	vmod				\N	0
807	もうだいじょうぶですから、心配しないでください。	もうだいじょうぶですから、心配しないでください。	null		\N	vmod				\N	0
808	どうしてわたしの電話番号がわかったのですか。	どうしてわたしの電話番号がわかったのですか。	null		\N	vmod				\N	0
809	小林さんに聞きました。	小林さんに聞きました。	null		\N	vmod				\N	0
810	田中さんもあした来ますか。	田中さんもあした来ますか。	null		\N	vmod				\N	0
811	いいえ、来ません。	いいえ、来ません。	null		\N	vmod				\N	0
812	どうしてですか。	どうしてですか。	null		\N	vmod				\N	0
813	病気だからです。	病気だからです。	null		\N	vmod				\N	0
814	’A：どうしてわたしの電話番号がわかったのですか。	’A：どうしてわたしの電話番号がわかったのですか。	null		\N	vmod				\N	0
815	小林さんに聞いたからです。	小林さんに聞いたからです。	null		\N	vmod				\N	0
816	どうして「蛍の光」が流れているのですか。	どうして「蛍の光」が流れているのですか。	null		\N	vmod				\N	0
817	図書館が閉まるからです。	図書館が閉まるからです。	null		\N	vmod				\N	0
818	雨が降って試合が中止になりました。	雨が降って試合が中止になりました。	null		\N	vmod				\N	0
819	かぜで休みました。	かぜで休みました。	null		\N	vmod				\N	0
820	どうして授業を休んだのですか。	どうして授業を休んだのですか。	null		\N	vmod				\N	0
821	熱があって、起きられませんでした。	熱があって、起きられませんでした。	null		\N	vmod				\N	0
822	きょうは先生が病気で、授業が休みになりました。	きょうは先生が病気で、授業が休みになりました。	null		\N	vmod				\N	0
823	一生懸命勉強したのに試験に落ちました。	一生懸命勉強したのに試験に落ちました。	null		\N	vmod				\N	0
824	このメロンは大きいのに安いです。	このメロンは大きいのに安いです。	null		\N	vmod				\N	0
825	毎日日本語を勉強しているけれども、なかなか漢字が覚えられません。	毎日日本語を勉強しているけれども、なかなか漢字が覚えられません。	null		\N	vmod				\N	0
826	山田さんはいつも元気ですけれども、きょうは静かです。	山田さんはいつも元気ですけれども、きょうは静かです。	null		\N	vmod				\N	0
827	一生懸命勉強したのに試験に落ちました。	一生懸命勉強したのに試験に落ちました。	null		\N	vmod				\N	0
828	このメロンは大きいのに安いです。	このメロンは大きいのに安いです。	null		\N	vmod				\N	0
829	きょうは日曜日なのに仕事があります。	きょうは日曜日なのに仕事があります。	null		\N	vmod				\N	0
830	さっき食べたのにもうおなかがすきました。	さっき食べたのにもうおなかがすきました。	null		\N	vmod				\N	0
831	毎日日本語を勉強しているけれども、なかなか漢字が覚えられません。	毎日日本語を勉強しているけれども、なかなか漢字が覚えられません。	null		\N	vmod				\N	0
832	山田さんはいつも元気ですけれども、きょうは静かです。	山田さんはいつも元気ですけれども、きょうは静かです。	null		\N	vmod				\N	0
833	雨が降ったけれども予定通り運動会をしました。	雨が降ったけれども予定通り運動会をしました。	null		\N	vmod				\N	0
834	もう夜の12時だけれども、もう少し勉強しよう。	もう夜の12時だけれども、もう少し勉強しよう。	null		\N	vmod				\N	0
835	’×もう夜の12時なのに、もう少し勉強しよう。	’×もう夜の12時なのに、もう少し勉強しよう。	null		\N	vmod				\N	0
836	小林さんはかぜをひいているけれども、学校に来ているかもしれません。	小林さんはかぜをひいているけれども、学校に来ているかもしれません。	null		\N	vmod				\N	0
837	’×小林さんはかぜをひいているのに、学校に来ているかもしれません。	’×小林さんはかぜをひいているのに、学校に来ているかもしれません。	null		\N	vmod				\N	0
839	’×日曜日なのに、学校に行きますか。	’×日曜日なのに、学校に行きますか。	null		\N	vmod				\N	0
840	わたしは東京に住んでいるけれども、弟は京都に住んでいます。	わたしは東京に住んでいるけれども、弟は京都に住んでいます。	null		\N	vmod				\N	0
841	’毎日日本語を勉強している｛けれども／けれど／けど／が｝、なかなか漢字が覚えられません。	’毎日日本語を勉強している｛けれども／けれど／けど／が｝、なかなか漢字が覚えられません。	null		\N	vmod				\N	0
842	’山田さんはいつも元気です｛けれども／けれど／けど／が｝、きょうは静かです。	’山田さんはいつも元気です｛けれども／けれど／けど／が｝、きょうは静かです。	null		\N	vmod				\N	0
843	わたしが話しているのに、じゃまをしないでください。	わたしが話しているのに、じゃまをしないでください。	null		\N	vmod				\N	0
844	鈴木さんから電話ですよ。	鈴木さんから電話ですよ。	null		\N	vmod				\N	0
845	えっ、もう夜の11時なのに。	えっ、もう夜の11時なのに。	null		\N	vmod				\N	0
846	レポートのことですけれども、来週の月曜日に提出してください。	レポートのことですけれども、来週の月曜日に提出してください。	null		\N	vmod				\N	0
847	日本中を旅行しましたけれども、京都が一番すきです。	日本中を旅行しましたけれども、京都が一番すきです。	null		\N	vmod				\N	0
848	すみませんが、郵便局はこの辺ですか。	すみませんが、郵便局はこの辺ですか。	null		\N	vmod				\N	0
849	すみません、パソコンが動かないのですけれども。	すみません、パソコンが動かないのですけれども。	null		\N	vmod				\N	0
850	’すみません、パソコンが動かないのですけれども、見てもらえますか。	’すみません、パソコンが動かないのですけれども、見てもらえますか。	null		\N	vmod				\N	0
851	雨が降ると、雪が解けます。	雨が降ると、雪が解けます。	null		\N	vmod				\N	0
852	父は毎朝起きると、新聞を読みます。	父は毎朝起きると、新聞を読みます。	null		\N	vmod				\N	0
853	このボタンを押すと、ドアが開きます。	このボタンを押すと、ドアが開きます。	null		\N	vmod				\N	0
854	成績が悪いと進学できません。	成績が悪いと進学できません。	null		\N	vmod				\N	0
855	部屋が静かだとよく勉強できます。	部屋が静かだとよく勉強できます。	null		\N	vmod				\N	0
856	成績が60点以上だと合格です。	成績が60点以上だと合格です。	null		\N	vmod				\N	0
857	卒業論文を出せば、卒業できます。	卒業論文を出せば、卒業できます。	null		\N	vmod				\N	0
859	ちりもつもれば山となる。	ちりもつもれば山となる。	null		\N	vmod				\N	0
860	あした雨が降れば、運動会は中止です。	あした雨が降れば、運動会は中止です。	null		\N	vmod				\N	0
861	あした雨が降ったら、試合は中止します。	あした雨が降ったら、試合は中止します。	null		\N	vmod				\N	0
862	暑かったら、エアコンをつけてください。	暑かったら、エアコンをつけてください。	null		\N	vmod				\N	0
863	あした晴れだったら、ドライブに行きましょう。	あした晴れだったら、ドライブに行きましょう。	null		\N	vmod				\N	0
864	ひまだったら、遊びに来ませんか。	ひまだったら、遊びに来ませんか。	null		\N	vmod				\N	0
865	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。	null		\N	vmod				\N	0
866	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。	null		\N	vmod				\N	0
867	あの大学へ行くなら、自転車が便利です。	あの大学へ行くなら、自転車が便利です。	null		\N	vmod				\N	0
869	嫌ならやめてもいいですよ。	嫌ならやめてもいいですよ。	null		\N	vmod				\N	0
870	大学生ならこのくらいはできるはずです。	大学生ならこのくらいはできるはずです。	null		\N	vmod				\N	0
872	パソコンがあるなら、インターネットができますね。	パソコンがあるなら、インターネットができますね。	null		\N	vmod				\N	0
873	車を買うと、お金がなくなります。	車を買うと、お金がなくなります。	null		\N	vmod				\N	0
874	車を買えば、どこでも行けます。	車を買えば、どこでも行けます。	null		\N	vmod				\N	0
875	車を買ったら、ドライブをしよう。	車を買ったら、ドライブをしよう。	null		\N	vmod				\N	0
876	’B：パソコンがあるのなら、インターネットができますね。	’B：パソコンがあるのなら、インターネットができますね。	null		\N	vmod				\N	0
877	’もしあした雨が降れば、運動会は中止です。	’もしあした雨が降れば、運動会は中止です。	null		\N	vmod				\N	0
878	学校に｛行くと／行ったら｝、新入生がたくさんいました。	学校に｛行くと／行ったら｝、新入生がたくさんいました。	null		\N	vmod				\N	0
879	どうすれば、漢字を覚えることができますか。	どうすれば、漢字を覚えることができますか。	null		\N	vmod				\N	0
880	毎日、新聞を読めば、覚えることができますよ。	毎日、新聞を読めば、覚えることができますよ。	null		\N	vmod				\N	0
881	このボタンを押すと、ドアが開きます。	このボタンを押すと、ドアが開きます。	null		\N	vmod				\N	0
882	’このボタンを押せば、ドアが開きます。	’このボタンを押せば、ドアが開きます。	null		\N	vmod				\N	0
883	お酒を｛？飲めば／○飲むと／○飲んだら｝、気分が悪くなります。	お酒を｛？飲めば／○飲むと／○飲んだら｝、気分が悪くなります。	null		\N	vmod				\N	0
884	教科書さえ｛○あれば／×あると／？あったら｝、勉強できる。	教科書さえ｛○あれば／×あると／？あったら｝、勉強できる。	null		\N	vmod				\N	0
885	’×あの大学へ行ったら、自転車が便利です。	’×あの大学へ行ったら、自転車が便利です。	null		\N	vmod				\N	0
886	どうすれば、漢字を覚えることができますか。	どうすれば、漢字を覚えることができますか。	null		\N	vmod				\N	0
887	毎日、新聞を読めば、覚えることができますよ。	毎日、新聞を読めば、覚えることができますよ。	null		\N	vmod				\N	0
888	教科書さえあれば、勉強できる。	教科書さえあれば、勉強できる。	null		\N	vmod				\N	0
889	雨が降ると、雪が解けます。	雨が降ると、雪が解けます。	null		\N	vmod				\N	0
890	卒業論文を出せば、卒業できます。	卒業論文を出せば、卒業できます。	null		\N	vmod				\N	0
891	たとえ雨でも、自転車で行きます。 	たとえ雨でも、自転車で行きます。 	null		\N	vmod				\N	0
892	雪が降っても、学校に行きます。	雪が降っても、学校に行きます。	null		\N	vmod				\N	0
894	嫌でも、しかたがありません。	嫌でも、しかたがありません。	null		\N	vmod				\N	0
895	この時計は、落としても、水にぬれてもこわれません。	この時計は、落としても、水にぬれてもこわれません。	null		\N	vmod				\N	0
896	だれが選ばれても、おどろきません。	だれが選ばれても、おどろきません。	null		\N	vmod				\N	0
897	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。	null		\N	vmod				\N	0
898	わたしは木村さんにプレゼントをあげます。	わたしは木村さんにプレゼントをあげます。	null		\N	vmod				\N	0
899	木村さんはわたしにプレゼントをくれます。	木村さんはわたしにプレゼントをくれます。	null		\N	vmod				\N	0
900	わたしは木村さんにプレゼントをもらいます。	わたしは木村さんにプレゼントをもらいます。	null		\N	vmod				\N	0
901	わたしは木村さんにプレゼントをあげます。	わたしは木村さんにプレゼントをあげます。	null		\N	vmod				\N	0
902	’×わたしは木村さんにプレゼントをくれます。	’×わたしは木村さんにプレゼントをくれます。	null		\N	vmod				\N	0
903	木村さんはわたしにプレゼントをくれます。	木村さんはわたしにプレゼントをくれます。	null		\N	vmod				\N	0
904	’×木村さんはわたしにプレゼントをあげます。	’×木村さんはわたしにプレゼントをあげます。	null		\N	vmod				\N	0
905	妹は山田さんにおみやげをあげました。　	妹は山田さんにおみやげをあげました。　	null		\N	vmod				\N	0
906	’×妹は山田さんにおみやげをくれました。	’×妹は山田さんにおみやげをくれました。	null		\N	vmod				\N	0
907	山田さんは妹に本をくれました。　	山田さんは妹に本をくれました。　	null		\N	vmod				\N	0
908	’×山田さんは妹に本をあげました。	’×山田さんは妹に本をあげました。	null		\N	vmod				\N	0
909	木村さんは山田さんにおみやげをあげました。	木村さんは山田さんにおみやげをあげました。	null		\N	vmod				\N	0
910	わたしは木村さんにプレゼントをもらいます。	わたしは木村さんにプレゼントをもらいます。	null		\N	vmod				\N	0
911	’？木村さんはわたしにプレゼントをもらいます。	’？木村さんはわたしにプレゼントをもらいます。	null		\N	vmod				\N	0
912	妹は山田さんに本をもらいました。	妹は山田さんに本をもらいました。	null		\N	vmod				\N	0
913	山田さんは木村さんにおみやげをもらいました。	山田さんは木村さんにおみやげをもらいました。	null		\N	vmod				\N	0
914	△山田さんに請求書をあげました。→山田さんに請求書を渡しました。	△山田さんに請求書をあげました。→山田さんに請求書を渡しました。	null		\N	vmod				\N	0
915	△先生はたくさん宿題をくれました。→先生は宿題をたくさん出しました。	△先生はたくさん宿題をくれました。→先生は宿題をたくさん出しました。	null		\N	vmod				\N	0
916	わたしは田中先生に花をさしあげました。	わたしは田中先生に花をさしあげました。	null		\N	vmod				\N	0
917	田中先生はわたしに手紙をくださいました。	田中先生はわたしに手紙をくださいました。	null		\N	vmod				\N	0
918	わたしは田中先生に手紙をいただきました。	わたしは田中先生に手紙をいただきました。	null		\N	vmod				\N	0
919	わたしは父に花をあげました。	わたしは父に花をあげました。	null		\N	vmod				\N	0
920	父はわたしに本をくれました。	父はわたしに本をくれました。	null		\N	vmod				\N	0
921	わたしは父に本をもらいました。	わたしは父に本をもらいました。	null		\N	vmod				\N	0
922	花に水をやります。	花に水をやります。	null		\N	vmod				\N	0
923	わたしは小林さんにノートを貸してあげました。	わたしは小林さんにノートを貸してあげました。	null		\N	vmod				\N	0
924	小林さんはわたしに友だちを紹介してくれました。	小林さんはわたしに友だちを紹介してくれました。	null		\N	vmod				\N	0
925	木村さんに本を貸してもらいました。	木村さんに本を貸してもらいました。	null		\N	vmod				\N	0
926	わたしは小林さんにノートを貸してあげました。	わたしは小林さんにノートを貸してあげました。	null		\N	vmod				\N	0
927	小林さんはわたしに友だちを紹介してくれました。	小林さんはわたしに友だちを紹介してくれました。	null		\N	vmod				\N	0
928	’わたしは小林さんにノートを貸しました。	’わたしは小林さんにノートを貸しました。	null		\N	vmod				\N	0
929	’小林さんはわたしに友だちを紹介しました。	’小林さんはわたしに友だちを紹介しました。	null		\N	vmod				\N	0
2873	Adik perempuan saya pendek dan rambutnya panjang. 	わたしの　妹は　背が　低くて、　髪が　長いです。	\N		\N	vmod				468	1
930	わたしは弟にお金を貸してあげました。	わたしは弟にお金を貸してあげました。	null		\N	vmod				\N	0
931	田中さんはわたしにパソコンの使い方を教えてくれました。	田中さんはわたしにパソコンの使い方を教えてくれました。	null		\N	vmod				\N	0
932	わたしは生徒をほめてあげました。	わたしは生徒をほめてあげました。	null		\N	vmod				\N	0
933	山田さんは息子と遊んでくれました。	山田さんは息子と遊んでくれました。	null		\N	vmod				\N	0
934	妹は父にお弁当を作ってあげました。	妹は父にお弁当を作ってあげました。	null		\N	vmod				\N	0
935	母はわたしにてぶくろをあんでくれました。	母はわたしにてぶくろをあんでくれました。	null		\N	vmod				\N	0
936	わたしは妹の宿題を見てあげました。	わたしは妹の宿題を見てあげました。	null		\N	vmod				\N	0
937	木村さんはわたしの荷物を運んでくれました。	木村さんはわたしの荷物を運んでくれました。	null		\N	vmod				\N	0
938	山田さんはわたしのために詩を書いてくれました。	山田さんはわたしのために詩を書いてくれました。	null		\N	vmod				\N	0
939	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。	null		\N	vmod				\N	0
940	木村さんに本を貸してもらいました。	木村さんに本を貸してもらいました。	null		\N	vmod				\N	0
941	小林さんに手伝ってもらいました。	小林さんに手伝ってもらいました。	null		\N	vmod				\N	0
942	木村さんに本を貸してもらいました。　→　木村さんに本を借りました。	木村さんに本を貸してもらいました。　→　木村さんに本を借りました。	null		\N	vmod				\N	0
943	母に料理を教えてもらいました。　→　母に料理を教わりました。	母に料理を教えてもらいました。　→　母に料理を教わりました。	null		\N	vmod				\N	0
944	日本語は木村さんに教えてもらおう。	日本語は木村さんに教えてもらおう。	null		\N	vmod				\N	0
2140	わたしは学生である。	わたしは学生である。	null		\N	vmod				\N	1
945	あした来てもらうよ。	あした来てもらうよ。	null		\N	vmod				\N	0
946	レポートはみなさんに出してもらうことにします。	レポートはみなさんに出してもらうことにします。	null		\N	vmod				\N	0
947	’×レポートはみなさんが出してくれることにします。	’×レポートはみなさんが出してくれることにします。	null		\N	vmod				\N	0
948	京都の友だちからおかしを送ってもらいました。　	京都の友だちからおかしを送ってもらいました。　	null		\N	vmod				\N	0
949	’京都の友だちにおかしを送ってもらいました。	’京都の友だちにおかしを送ってもらいました。	null		\N	vmod				\N	0
950	その知らせは田中さんから教えてもらいました。　	その知らせは田中さんから教えてもらいました。　	null		\N	vmod				\N	0
951	’その知らせは田中さんに教えてもらいました。	’その知らせは田中さんに教えてもらいました。	null		\N	vmod				\N	0
952	京都からおかしを送ってもらいました。　	京都からおかしを送ってもらいました。　	null		\N	vmod				\N	0
953	’？京都におかしを送ってもらいました。	’？京都におかしを送ってもらいました。	null		\N	vmod				\N	0
954	田中先生にペンを貸してさしあげました。	田中先生にペンを貸してさしあげました。	null		\N	vmod				\N	0
1001	読んどいたよ、あの本。	読んどいたよ、あの本。	null		\N	vmod				\N	0
955	鈴木先生はわたしに推薦状を書いてくださいました。	鈴木先生はわたしに推薦状を書いてくださいました。	null		\N	vmod				\N	0
956	わたしは鈴木先生に推薦状を書いていただきました。	わたしは鈴木先生に推薦状を書いていただきました。	null		\N	vmod				\N	0
957	？先生、ペンを貸してさしあげましょうか。　→　先生、ペンをお貸ししましょうか。	？先生、ペンを貸してさしあげましょうか。　→　先生、ペンをお貸ししましょうか。	null		\N	vmod				\N	0
958	弟に弁当を作ってやりました。	弟に弁当を作ってやりました。	null		\N	vmod				\N	0
959	駅まで歩いていきます。	駅まで歩いていきます。	null		\N	vmod				\N	0
960	これからも日本語を勉強していきます。	これからも日本語を勉強していきます。	null		\N	vmod				\N	0
961	おみやげを持ってきました。	おみやげを持ってきました。	null		\N	vmod				\N	0
962	高校の友だちがメールを送ってきました。	高校の友だちがメールを送ってきました。	null		\N	vmod				\N	0
963	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	0
964	駅まで歩いていきます。	駅まで歩いていきます。	null		\N	vmod				\N	0
965	おみやげを持ってきました。	おみやげを持ってきました。	null		\N	vmod				\N	0
966	来週そちらへ行くとき、飲み物を買っていきます。　	来週そちらへ行くとき、飲み物を買っていきます。　	null		\N	vmod				\N	0
967	’×来週そちらへ行くとき、飲み物を買ってきます。	’×来週そちらへ行くとき、飲み物を買ってきます。	null		\N	vmod				\N	0
968	駅まで歩いていきます。	駅まで歩いていきます。	null		\N	vmod				\N	0
969	駅前の通りを歩いてきました。	駅前の通りを歩いてきました。	null		\N	vmod				\N	0
970	’駅まで歩きました。	’駅まで歩きました。	null		\N	vmod				\N	0
971	おみやげを持ってきました。	おみやげを持ってきました。	null		\N	vmod				\N	0
972	授業まで時間があるので、朝のニュースを見ていきます。	授業まで時間があるので、朝のニュースを見ていきます。	null		\N	vmod				\N	0
1727	Ya, OK. 	ええ、　いいですよ。	null		\N	vmod				\N	1
1365	B2：いいえ、まだです。	B2：いいえ、まだです。	null		\N	vmod				\N	1
973	きょうは友だちと夕飯を食べてきました。	きょうは友だちと夕飯を食べてきました。	null		\N	vmod				\N	0
974	高校の友だちがメールを送ってきました。	高校の友だちがメールを送ってきました。	null		\N	vmod				\N	0
975	これからも日本語を勉強していきます。	これからも日本語を勉強していきます。	null		\N	vmod				\N	0
976	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	0
977	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	0
978	木村さんはわたしに古本を売ってきました。　	木村さんはわたしに古本を売ってきました。　	null		\N	vmod				\N	0
979	’わたしは木村さんから古本を買いました。	’わたしは木村さんから古本を買いました。	null		\N	vmod				\N	0
980	来週までにレポートを書いておきます。	来週までにレポートを書いておきます。	null		\N	vmod				\N	0
981	発表のために資料をコピーしておきました。	発表のために資料をコピーしておきました。	null		\N	vmod				\N	0
1183	あっ、田中さんが１位です。	あっ、田中さんが１位です。	null		\N	vmod				\N	1
982	友だちが来るので、部屋をきれいにしておきます。	友だちが来るので、部屋をきれいにしておきます。	null		\N	vmod				\N	0
983	あした木村さんに聞いてみます。	あした木村さんに聞いてみます。	null		\N	vmod				\N	0
984	このジュースを少し飲んでみてください。	このジュースを少し飲んでみてください。	null		\N	vmod				\N	0
985	すみません、この服を着てみてもいいですか。	すみません、この服を着てみてもいいですか。	null		\N	vmod				\N	0
986	’×このジュースをたくさん飲んでみてください。→○このジュースをたくさん飲んでください。	’×このジュースをたくさん飲んでみてください。→○このジュースをたくさん飲んでください。	null		\N	vmod				\N	0
987	いつか南極に行ってみたいです。	いつか南極に行ってみたいです。	null		\N	vmod				\N	0
988	’いつか南極に行きたいです。	’いつか南極に行きたいです。	null		\N	vmod				\N	0
989	わたしはこの前京都へ行ったよ。	わたしはこの前京都へ行ったよ。	null		\N	vmod				\N	0
990	彼は大学の教授だ。言語学を教えている。	彼は大学の教授だ。言語学を教えている。	null		\N	vmod				\N	0
991	彼は大学の教授である。言語学を教えている。	彼は大学の教授である。言語学を教えている。	null		\N	vmod				\N	0
992	わたしは先日京都へ行きました。	わたしは先日京都へ行きました。	null		\N	vmod				\N	0
993	彼は大学の教授です。言語学を教えています。	彼は大学の教授です。言語学を教えています。	null		\N	vmod				\N	0
995	’×日本の冬は寒いだ。×日本の冬は寒いである。	’×日本の冬は寒いだ。×日本の冬は寒いである。	null		\N	vmod				\N	0
996	この本はわたしのじゃない。	この本はわたしのじゃない。	null		\N	vmod				\N	0
997	わたしはきょうまでにレポートを終わらせとく。	わたしはきょうまでにレポートを終わらせとく。	null		\N	vmod				\N	0
998	こうすりゃよかった。	こうすりゃよかった。	null		\N	vmod				\N	0
999	君、あした来るって言ったよね。	君、あした来るって言ったよね。	null		\N	vmod				\N	0
1002	これ、プリント、先週の。	これ、プリント、先週の。	null		\N	vmod				\N	0
1003	ちょっと待って。	ちょっと待って。	null		\N	vmod				\N	0
1004	すごくおいしい。	すごくおいしい。	null		\N	vmod				\N	0
1005	わたし、きのう、あれから映画見て、ごはん食べた。	わたし、きのう、あれから映画見て、ごはん食べた。	null		\N	vmod				\N	0
1006	きのう見た映画はおもしろかったです。	きのう見た映画はおもしろかったです。	null		\N	vmod				\N	0
1007	’×きのう見ました映画はおもしろかったです。	’×きのう見ました映画はおもしろかったです。	null		\N	vmod				\N	0
1008	授業に毎回出席する。これがわたしの今年の目標です。	授業に毎回出席する。これがわたしの今年の目標です。	null		\N	vmod				\N	0
1009	’授業に毎回出席します。これがわたしの今年の目標です。	’授業に毎回出席します。これがわたしの今年の目標です。	null		\N	vmod				\N	0
1010	わたしは英語が苦手なので勉強します。	わたしは英語が苦手なので勉強します。	null		\N	vmod				\N	0
1011	’？わたしは英語が苦手ですので勉強します。	’？わたしは英語が苦手ですので勉強します。	null		\N	vmod				\N	0
1012	星がたくさん出ていますからあしたは晴れでしょう。	星がたくさん出ていますからあしたは晴れでしょう。	null		\N	vmod				\N	0
1013	’？星がたくさん出ているからあしたは晴れでしょう。	’？星がたくさん出ているからあしたは晴れでしょう。	null		\N	vmod				\N	0
1014	わたしは学生ですが、兄は会社員です。	わたしは学生ですが、兄は会社員です。	null		\N	vmod				\N	0
1015	’？？わたしは学生だが、兄は会社員です。	’？？わたしは学生だが、兄は会社員です。	null		\N	vmod				\N	0
1016	以上で発表は終わりでございますが、何かご質問はありますか。	以上で発表は終わりでございますが、何かご質問はありますか。	null		\N	vmod				\N	0
1017	頼む。金を貸してくれ。お願いします。	頼む。金を貸してくれ。お願いします。	null		\N	vmod				\N	0
1427	Saya sangat letih. 	とても　つかれました。	null		\N	vmod				\N	1
2656	ええっ。	ええっ。			\N	vmod				\N	1
1018	年が明けました。新しい年の始まりです。今年はどんな年になるんだろう。	年が明けました。新しい年の始まりです。今年はどんな年になるんだろう。	null		\N	vmod				\N	0
1019	山田さんはおそばを召し上がりました。	山田さんはおそばを召し上がりました。	null		\N	vmod				\N	0
1230	教室にいます。	教室にいます。	null		\N	vmod				\N	1
1020	田中さんは毎朝、新聞をお読みになります。	田中さんは毎朝、新聞をお読みになります。	null		\N	vmod				\N	0
1021	中田先生がこの本を書かれました。	中田先生がこの本を書かれました。	null		\N	vmod				\N	0
1022	あの方は東京駅で降りられます。	あの方は東京駅で降りられます。	null		\N	vmod				\N	0
1023	あちらは山田様です。	あちらは山田様です。	null		\N	vmod				\N	0
1024	あなたのお仕事は何ですか。	あなたのお仕事は何ですか。	null		\N	vmod				\N	0
1025	ご家族はどちらにいらっしゃいますか。	ご家族はどちらにいらっしゃいますか。	null		\N	vmod				\N	0
1026	先生は来週もお忙しいようです。	先生は来週もお忙しいようです。	null		\N	vmod				\N	0
1027	先生は来週もご多忙のようです。	先生は来週もご多忙のようです。	null		\N	vmod				\N	0
1028	わたしはきのう渡辺社長のお宅を拝見しました。	わたしはきのう渡辺社長のお宅を拝見しました。	null		\N	vmod				\N	0
1029	わたしがかばんをお持ちします。	わたしがかばんをお持ちします。	null		\N	vmod				\N	0
1030	係員がご案内します。	係員がご案内します。	null		\N	vmod				\N	0
1031	こちらからお電話さしあげます。	こちらからお電話さしあげます。	null		\N	vmod				\N	0
1032	先日試合で大阪に参りました。	先日試合で大阪に参りました。	null		\N	vmod				\N	0
1033	’×先日試合で大阪にうかがいました。	’×先日試合で大阪にうかがいました。	null		\N	vmod				\N	0
1034	''先日先生の研究室に参りました。	''先日先生の研究室に参りました。	null		\N	vmod				\N	0
1035	'''先日先生の研究室にうかがいました。	'''先日先生の研究室にうかがいました。	null		\N	vmod				\N	0
1036	’わたしはきのう渡辺社長の家を見たよ。	’わたしはきのう渡辺社長の家を見たよ。	null		\N	vmod				\N	0
1037	他社の社員：渡辺社長はいらっしゃいますか。	他社の社員：渡辺社長はいらっしゃいますか。	null		\N	vmod				\N	0
1038	渡辺の部下：渡辺はただいま外出しております。	渡辺の部下：渡辺はただいま外出しております。	null		\N	vmod				\N	0
1039	わたしが晩ごはんを食べているとき、友だちがうちへ来ました。	わたしが晩ごはんを食べているとき、友だちがうちへ来ました。	null		\N	vmod				\N	0
1040	お母さんは若いとき看護士でした。	お母さんは若いとき看護士でした。	null		\N	vmod				\N	0
1041	桜の花がきれいなとき、リーさんは日本へ来ました。	桜の花がきれいなとき、リーさんは日本へ来ました。	null		\N	vmod				\N	0
1042	高校生のとき、日本へ留学したことがあります。	高校生のとき、日本へ留学したことがあります。	null		\N	vmod				\N	0
1043	お母さんは若いとき看護士でした。	お母さんは若いとき看護士でした。	null		\N	vmod				\N	0
1044	’若いとき、お母さんは看護士でした。	’若いとき、お母さんは看護士でした。	null		\N	vmod				\N	0
1045	’ わたしが晩ごはんを食べているときに、友だちがうちへ来ました。	’ わたしが晩ごはんを食べているときに、友だちがうちへ来ました。	null		\N	vmod				\N	0
1046	部屋にいるとき、電話しました。	部屋にいるとき、電話しました。	null		\N	vmod				\N	0
1047	部屋にいたとき、電話しました。	部屋にいたとき、電話しました。	null		\N	vmod				\N	0
1048	若いとき、よく泳ぎました。	若いとき、よく泳ぎました。	null		\N	vmod				\N	0
1049	若かったとき、よく泳ぎました。	若かったとき、よく泳ぎました。	null		\N	vmod				\N	0
1050	テレビを見ながらごはんを食べました。	テレビを見ながらごはんを食べました。	null		\N	vmod				\N	0
1051	田中さんは、知っていながら知らないふりをしました。	田中さんは、知っていながら知らないふりをしました。	null		\N	vmod				\N	0
1052	今年の夏休みは、海にも行きましたし、山にも登りました。	今年の夏休みは、海にも行きましたし、山にも登りました。	null		\N	vmod				\N	0
1053	雨が降ったので運動会が中止になりました。	雨が降ったので運動会が中止になりました。	null		\N	vmod				\N	0
1054	雨が降ったから運動会が中止になりました。	雨が降ったから運動会が中止になりました。	null		\N	vmod				\N	0
1055	雨が降ったのに運動会がありました。	雨が降ったのに運動会がありました。	null		\N	vmod				\N	0
1056	雨が降ったけれども運動会がありました。	雨が降ったけれども運動会がありました。	null		\N	vmod				\N	0
1057	春になると暖かくなります。	春になると暖かくなります。	null		\N	vmod				\N	0
1058	暗いところで本を読むと目が悪くなります。	暗いところで本を読むと目が悪くなります。	null		\N	vmod				\N	0
1060	雨が降ったら運動会を中止します。	雨が降ったら運動会を中止します。	null		\N	vmod				\N	0
1061	雨が降るなら運動会を中止します。	雨が降るなら運動会を中止します。	null		\N	vmod				\N	0
1062	雨が降っても運動会をします。	雨が降っても運動会をします。	null		\N	vmod				\N	0
3782	Betul tu. 	そうですね。	\N		\N	vmod				345	1
3783	Ya, betul. 	はい、　そうです。	\N		\N	vmod				345	1
1268	Itu surat khabar bila?	それは　いつの　新聞ですか。	null		\N	vmod				\N	1
1063	ここにえんぴつがあります。赤いえんぴつは３本あります。青いえんぴつは２本あります。	ここにえんぴつがあります。赤いえんぴつは３本あります。青いえんぴつは２本あります。	null		\N	vmod				\N	0
1064	Ａ：そこにかさとかばんがありますか。	Ａ：そこにかさとかばんがありますか。	null		\N	vmod				\N	0
1065	Ｂ：かさはありますが、かばんはありません。	Ｂ：かさはありますが、かばんはありません。	null		\N	vmod				\N	0
1066	春は来ましたが、まだ暖かくなりません。	春は来ましたが、まだ暖かくなりません。	null		\N	vmod				\N	0
1067	Ａ：宿題をしてきましたか。	Ａ：宿題をしてきましたか。	null		\N	vmod				\N	0
1068	Ｂ：レポートは書きましたが、印刷はしていません。	Ｂ：レポートは書きましたが、印刷はしていません。	null		\N	vmod				\N	0
1069	山田先生はやさしいです。	山田先生はやさしいです。	null		\N	vmod				\N	0
1070	田中さんは社長です。	田中さんは社長です。	null		\N	vmod				\N	0
1071	わたしはきのう大学へ行きました。	わたしはきのう大学へ行きました。	null		\N	vmod				\N	0
1072	朝ごはんはもう食べました。	朝ごはんはもう食べました。	null		\N	vmod				\N	0
1073	たばこはやめました。	たばこはやめました。	null		\N	vmod				\N	0
1074	田中さんは学生です。佐藤さんも学生です。	田中さんは学生です。佐藤さんも学生です。	null		\N	vmod				\N	0
1075	暖かくなりましたし、桜も咲きました。	暖かくなりましたし、桜も咲きました。	null		\N	vmod				\N	0
1076	時間も来ました。そろそろ終わりにしましょう。	時間も来ました。そろそろ終わりにしましょう。	null		\N	vmod				\N	0
1077	あなたもよく働きますね。	あなたもよく働きますね。	null		\N	vmod				\N	0
1078	あとは寝るだけです。	あとは寝るだけです。	null		\N	vmod				\N	0
1079	言うだけで何もしません。	言うだけで何もしません。	null		\N	vmod				\N	0
1080	何を聞かれても泣くばかりです。	何を聞かれても泣くばかりです。	null		\N	vmod				\N	0
1081	食べたいだけ食べました。	食べたいだけ食べました。	null		\N	vmod				\N	0
1082	日本語は勉強しただけじょうずになります。	日本語は勉強しただけじょうずになります。	null		\N	vmod				\N	0
1083	すきなだけ持っていってください。	すきなだけ持っていってください。	null		\N	vmod				\N	0
1084	山田さんこそ会長にふさわしいです。	山田さんこそ会長にふさわしいです。	null		\N	vmod				\N	0
1085	全力を尽くしてこそいい結果がでます。	全力を尽くしてこそいい結果がでます。	null		\N	vmod				\N	0
1086	ジュースしかありません。	ジュースしかありません。	null		\N	vmod				\N	0
1087	コアラはユーカリの葉しか食べません。	コアラはユーカリの葉しか食べません。	null		\N	vmod				\N	0
1088	机の上に本などがあります。	机の上に本などがあります。	null		\N	vmod				\N	0
1089	辞書を引いたり、インターネットで調べるなどしました。	辞書を引いたり、インターネットで調べるなどしました。	null		\N	vmod				\N	0
1090	小泉氏などの政治家にインタビューしました。	小泉氏などの政治家にインタビューしました。	null		\N	vmod				\N	0
1091	試験中にとなりの人と話すなどのことはしてはいけません。	試験中にとなりの人と話すなどのことはしてはいけません。	null		\N	vmod				\N	0
1092	お茶などいかがですか。	お茶などいかがですか。	null		\N	vmod				\N	0
1151	ああ、きれいだなあ。	ああ、きれいだなあ。	null		\N	vmod				\N	0
1093	つまらない仕事などに時間を使いたくありません。	つまらない仕事などに時間を使いたくありません。	null		\N	vmod				\N	0
1094	お茶でも飲みませんか。	お茶でも飲みませんか。	null		\N	vmod				\N	0
1688	田中さんの来たとき	田中さんの来たとき	null		\N	vmod				\N	1
1095	それでもだいじょうぶです。	それでもだいじょうぶです。	null		\N	vmod				\N	0
1096	このアルバイトは、いそがしい人でもできます。	このアルバイトは、いそがしい人でもできます。	null		\N	vmod				\N	0
1098	佐藤さんや田中さんが来ました。山田さんまで来ました。	佐藤さんや田中さんが来ました。山田さんまで来ました。	null		\N	vmod				\N	0
1099	日本語を勉強して、留学生試験に合格するまでになりました。	日本語を勉強して、留学生試験に合格するまでになりました。	null		\N	vmod				\N	0
1100	佐藤さんや田中さんが来ました。山田さんさえ来ました。	佐藤さんや田中さんが来ました。山田さんさえ来ました。	null		\N	vmod				\N	0
1101	これさえあればだいじょうぶです。	これさえあればだいじょうぶです。	null		\N	vmod				\N	0
1102	山田さんさえいたら、この試合には勝てるのに。	山田さんさえいたら、この試合には勝てるのに。	null		\N	vmod				\N	0
1103	10人くらい来ました。	10人くらい来ました。	null		\N	vmod				\N	0
1104	これくらいの大きさです。	これくらいの大きさです。	null		\N	vmod				\N	0
1105	5分ほど待ってください。	5分ほど待ってください。	null		\N	vmod				\N	0
1106	そのくらいのことは自分でできます。	そのくらいのことは自分でできます。	null		\N	vmod				\N	0
1107	山田さんくらい頭のいい人はいません。	山田さんくらい頭のいい人はいません。	null		\N	vmod				\N	0
1108	富士山はエベレストほど高くはありません。	富士山はエベレストほど高くはありません。	null		\N	vmod				\N	0
1109	君にだけ話しましょう。	君にだけ話しましょう。	null		\N	vmod				\N	0
1110	太郎君とさえ話ができなかった。	太郎君とさえ話ができなかった。	null		\N	vmod				\N	0
1111	君だけに話しましょう。	君だけに話しましょう。	null		\N	vmod				\N	0
1564	庭の花	庭の花	null		\N	vmod				\N	1
1112	それくらいがちょうどいいです。	それくらいがちょうどいいです。	null		\N	vmod				\N	0
1114	あしたは日曜日ですか。	あしたは日曜日ですか。	null		\N	vmod				\N	0
1115	さあ、起きるか。	さあ、起きるか。	null		\N	vmod				\N	0
1116	もう12時か。	もう12時か。	null		\N	vmod				\N	0
1117	あなたも二十歳になりましたか。	あなたも二十歳になりましたか。	null		\N	vmod				\N	0
1118	だいじょうぶか。	だいじょうぶか。	null		\N	vmod				\N	0
1119	本か。	本か。	null		\N	vmod				\N	0
1120	熱いですか。	熱いですか。	null		\N	vmod				\N	0
1121	だいじょうぶですか。	だいじょうぶですか。	null		\N	vmod				\N	0
1122	これは本ですか。	これは本ですか。	null		\N	vmod				\N	0
1123	田中さんはあした来るでしょうか。	田中さんはあした来るでしょうか。	null		\N	vmod				\N	0
1124	熱い？	熱い？	null		\N	vmod				\N	0
1125	どれが大きい？	どれが大きい？	null		\N	vmod				\N	0
1126	だいじょうぶ？	だいじょうぶ？	null		\N	vmod				\N	0
1127	どの部屋が静か？	どの部屋が静か？	null		\N	vmod				\N	0
1128	これは、本？　	これは、本？　	null		\N	vmod				\N	0
1129	どなたが山田さん？	どなたが山田さん？	null		\N	vmod				\N	0
1130	田中さんはあした来る？	田中さんはあした来る？	null		\N	vmod				\N	0
1131	田中さんはいつ来る？	田中さんはいつ来る？	null		\N	vmod				\N	0
1132	熱いか？	熱いか？	null		\N	vmod				\N	0
1133	だいじょうぶか？	だいじょうぶか？	null		\N	vmod				\N	0
1134	これは本か？	これは本か？	null		\N	vmod				\N	0
1135	田中さんはあした来るか？	田中さんはあした来るか？	null		\N	vmod				\N	0
1136	熱い｛だろうか/かな/のかな/かしら｝？　	熱い｛だろうか/かな/のかな/かしら｝？　	null		\N	vmod				\N	0
1137	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？	null		\N	vmod				\N	0
1138	経済の状態はよくなるか、それが問題です。	経済の状態はよくなるか、それが問題です。	null		\N	vmod				\N	0
1139	山田さんは、眠くなったのか、目をこすっています。	山田さんは、眠くなったのか、目をこすっています。	null		\N	vmod				\N	0
1140	買い物に出かけましたが、何を買うか、どこで買うか、わからなくなって困りました。	買い物に出かけましたが、何を買うか、どこで買うか、わからなくなって困りました。	null		\N	vmod				\N	0
1141	あしたは日曜日かしら。	あしたは日曜日かしら。	null		\N	vmod				\N	0
1142	さわるな。	さわるな。	null		\N	vmod				\N	0
1143	あしたは日曜日ですよ。	あしたは日曜日ですよ。	null		\N	vmod				\N	0
1144	今行きますよ。	今行きますよ。	null		\N	vmod				\N	0
1145	早く行きましょうよ。	早く行きましょうよ。	null		\N	vmod				\N	0
1146	早くやってくださいよ。	早くやってくださいよ。	null		\N	vmod				\N	0
1147	３時ですね。	３時ですね。	null		\N	vmod				\N	0
1148	わたしもそう思いますね。	わたしもそう思いますね。	null		\N	vmod				\N	0
1149	あしたは日曜日ですね。	あしたは日曜日ですね。	null		\N	vmod				\N	0
1150	暑いですね。	暑いですね。	null		\N	vmod				\N	0
1152	おや、まちがえたかな。	おや、まちがえたかな。	null		\N	vmod				\N	0
1153	あしたは日曜日だな。	あしたは日曜日だな。	null		\N	vmod				\N	0
1154	暑いな。	暑いな。	null		\N	vmod				\N	0
1155	。	。	null		\N	vmod				\N	0
1156	来たのは山田君さ。	来たのは山田君さ。	null		\N	vmod				\N	0
1157	僕がやるぞ。	僕がやるぞ。	null		\N	vmod				\N	0
1158	俺もやるぜ。	俺もやるぜ。	null		\N	vmod				\N	0
1837	Saya nak ini dan itu. 	これと　それが　ほしいです。	null		\N	vmod				\N	1
1159	よし、やるとも。　	よし、やるとも。　	null		\N	vmod				\N	0
1160	きょうは会議がありましたよね。	きょうは会議がありましたよね。	null		\N	vmod				\N	0
1161	わたしはね、きのうね、新宿へね、行ったんですよ。	わたしはね、きのうね、新宿へね、行ったんですよ。	null		\N	vmod				\N	0
1162	きのうな、新宿へな、……	きのうな、新宿へな、……	null		\N	vmod				\N	0
1163	きのうさ、新宿へさ、……	きのうさ、新宿へさ、……	null		\N	vmod				\N	0
1164	きのうよ、新宿へよ、……	きのうよ、新宿へよ、……	null		\N	vmod				\N	0
1165	朝です。	朝です。	null		\N	vmod				\N	1
1166	朝ではありません。	朝ではありません。	null		\N	vmod				\N	1
1167	学生です。	学生です。	null		\N	vmod				\N	1
1168	学生ではありません。	学生ではありません。	null		\N	vmod				\N	1
1169	春です。	春です。	null		\N	vmod				\N	1
1170	春ではありません。	春ではありません。	null		\N	vmod				\N	1
1171	田中です。	田中です。	null		\N	vmod				\N	1
1172	キムです。	キムです。	null		\N	vmod				\N	1
1173	朝ではないです。	朝ではないです。	null		\N	vmod				\N	1
1174	学生ではないです。	学生ではないです。	null		\N	vmod				\N	1
1175	田中さんは学生です。	田中さんは学生です。	null		\N	vmod				\N	1
1583	山田さんが本を読みました。	山田さんが本を読みました。	null		\N	vmod				\N	1
1177	わたしが田中です。	わたしが田中です。	null		\N	vmod				\N	1
1179	父は先生ではありません。	父は先生ではありません。	null		\N	vmod				\N	1
1182	山田さんがリーダーです。	山田さんがリーダーです。	null		\N	vmod				\N	1
1184	中山さんは大学生ですか。	中山さんは大学生ですか。	null		\N	vmod				\N	1
1185	はい、　大学生です。	はい、　大学生です。	null		\N	vmod				\N	1
1186	田中さんですか。	田中さんですか。	null		\N	vmod				\N	1
1187	はい、田中です。	はい、田中です。	null		\N	vmod				\N	1
1188	学生ではありませんか。	学生ではありませんか。	null		\N	vmod				\N	1
1189	はい、学生ではありません。	はい、学生ではありません。	null		\N	vmod				\N	1
1190	田中さんですか。	田中さんですか。	null		\N	vmod				\N	1
1191	いいえ、　山口です。	いいえ、　山口です。	null		\N	vmod				\N	1
1192	学生ではありませんか。	学生ではありませんか。	null		\N	vmod				\N	1
1193	いいえ、　学生です。	いいえ、　学生です。	null		\N	vmod				\N	1
1195	むかし、　ここは　公園でした。	むかし、　ここは　公園でした。	null		\N	vmod				\N	1
1196	父は先生でした。	父は先生でした。	null		\N	vmod				\N	1
1197	お昼はおにぎりではありませんでした。	お昼はおにぎりではありませんでした。	null		\N	vmod				\N	1
1198	きのうは休みでしたか。	きのうは休みでしたか。	null		\N	vmod				\N	1
1199	いいえ、休みではありませんでした。	いいえ、休みではありませんでした。	null		\N	vmod				\N	1
1200	きのうは　休みでは　なかったです。	きのうは　休みでは　なかったです。	null		\N	vmod				\N	1
1201	木があります。	木があります。	null		\N	vmod				\N	1
1202	本があります。	本があります。	null		\N	vmod				\N	1
1203	犬がいます。	犬がいます。	null		\N	vmod				\N	1
1204	田中さんがいます。	田中さんがいます。	null		\N	vmod				\N	1
1205	ペンがありますか。	ペンがありますか。	null		\N	vmod				\N	1
1206	はい、あります。	はい、あります。	null		\N	vmod				\N	1
1207	いいえ、ありません。	いいえ、ありません。	null		\N	vmod				\N	1
1208	山田さん、いますか。	山田さん、いますか。	null		\N	vmod				\N	1
1209	はい、います。	はい、います。	null		\N	vmod				\N	1
1210	いいえ、いません。	いいえ、いません。	null		\N	vmod				\N	1
1211	何がありますか。	何がありますか。	null		\N	vmod				\N	1
1212	ノートが　あります。	ノートが　あります。	null		\N	vmod				\N	1
1213	誰がいましたか。	誰がいましたか。	null		\N	vmod				\N	1
1214	田中さんがいました。	田中さんがいました。	null		\N	vmod				\N	1
1215	誰がいましたか。	誰がいましたか。	null		\N	vmod				\N	1
1216	誰もいませんでした。	誰もいませんでした。	null		\N	vmod				\N	1
1217	ペンがありますか。	ペンがありますか。	null		\N	vmod				\N	1
1218	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	1
1219	先生、　来週　漢字の　試験が　ありますか。	先生、　来週　漢字の　試験が　ありますか。	null		\N	vmod				\N	1
1220	はい、あります。水曜日ですよ。	はい、あります。水曜日ですよ。	null		\N	vmod				\N	1
1221	部屋に　パソコンが　あります。	部屋に　パソコンが　あります。	null		\N	vmod				\N	1
1223	家に　犬が　います。	家に　犬が　います。	null		\N	vmod				\N	1
1225	パソコンは部屋にあります。	パソコンは部屋にあります。	null		\N	vmod				\N	1
1226	田中さんは教室にいます。	田中さんは教室にいます。	null		\N	vmod				\N	1
1227	パソコンはどこにありますか。	パソコンはどこにありますか。	null		\N	vmod				\N	1
1228	部屋にあります。	部屋にあります。	null		\N	vmod				\N	1
1231	みなさん、　質問が　ありますか。	みなさん、　質問が　ありますか。	null		\N	vmod				\N	1
1234	太郎さんには子どもがいます。	太郎さんには子どもがいます。	null		\N	vmod				\N	1
1235	公園でロックコンサートがありました。	公園でロックコンサートがありました。	null		\N	vmod				\N	1
1236	机の上	机の上	null		\N	vmod				\N	1
1237	机の下	机の下	null		\N	vmod				\N	1
1238	家の前	家の前	null		\N	vmod				\N	1
1239	家のうしろ	家のうしろ	null		\N	vmod				\N	1
1240	教室の中	教室の中	null		\N	vmod				\N	1
1178	Ayah saya guru.	父は　先生です。	null		\N	vmod				\N	1
1241	教室の外	教室の外	null		\N	vmod				\N	1
1242	田中さんの右	田中さんの右	null		\N	vmod				\N	1
1243	田中さんの左	田中さんの左	null		\N	vmod				\N	1
1180	Sekolah cuti. 	学校は　休みです。	null		\N	vmod				\N	1
1252	埼玉は　東京の　北に　あります。	埼玉は　東京の　北に　あります。	null		\N	vmod				\N	1
1253	田中さんは　教室の　中に　います。	田中さんは　教室の　中に　います。	null		\N	vmod				\N	1
1256	山田さんのとなりは田中さんです。	山田さんのとなりは田中さんです。	null		\N	vmod				\N	1
1260	体育館の　となりに　プールが　あります。	体育館の　となりに　プールが　あります。	null		\N	vmod				\N	1
1261	はさみは　机の　上に　あります。	はさみは　机の　上に　あります。	null		\N	vmod				\N	1
1262	田中さんのとなりに木村さんがいます。	田中さんのとなりに木村さんがいます。	null		\N	vmod				\N	1
1263	あれは　数学の　教科書です。	あれは　数学の　教科書です。	null		\N	vmod				\N	1
1265	２階です。	２階です。	null		\N	vmod				\N	1
1266	これは誰のかばんですか。	これは誰のかばんですか。	null		\N	vmod				\N	1
1267	わたしのです。	わたしのです。	null		\N	vmod				\N	1
1269	きのうのです。	きのうのです。	null		\N	vmod				\N	1
1270	わたしのはどこにありますか。	わたしのはどこにありますか。	null		\N	vmod				\N	1
1271	わたしは東京外国語大学の木村です。	わたしは東京外国語大学の木村です。	null		\N	vmod				\N	1
1272	日本には、　春と　夏と　秋と　冬の　４つの　季節が　あります。	日本には、　春と　夏と　秋と　冬の　４つの　季節が　あります。	null		\N	vmod				\N	1
1273	この　人は　友だちの　田中さんです。	この　人は　友だちの　田中さんです。	null		\N	vmod				\N	1
1277	すてきな絵ですね。	すてきな絵ですね。	null		\N	vmod				\N	1
1278	ようかんは　どんな　食べ物ですか。	ようかんは　どんな　食べ物ですか。	null		\N	vmod				\N	1
1279	あまいおかしです。	あまいおかしです。	null		\N	vmod				\N	1
1283	じょうぶなかばんです。	じょうぶなかばんです。	null		\N	vmod				\N	1
1284	どんなCDがありますか。	どんなCDがありますか。	null		\N	vmod				\N	1
1285	静かな　音楽の　CDが　あります。	静かな　音楽の　CDが　あります。	null		\N	vmod				\N	1
1287	黒いのを買います。	黒いのを買います。	null		\N	vmod				\N	1
1288	どんな　音楽が　すきですか。	どんな　音楽が　すきですか。	null		\N	vmod				\N	1
1289	静かなのがすきです。	静かなのがすきです。	null		\N	vmod				\N	1
1290	これは　日本語の　教科書です。	これは　日本語の　教科書です。	null		\N	vmod				\N	1
1292	あれは　体育館です。	あれは　体育館です。	null		\N	vmod				\N	1
1293	ここは　１年生の　教室です。	ここは　１年生の　教室です。	null		\N	vmod				\N	1
1294	そこは　図書室です。	そこは　図書室です。	null		\N	vmod				\N	1
1295	あそこは　事務室です。	あそこは　事務室です。	null		\N	vmod				\N	1
1298	この　部屋は　２年生の　教室です。	この　部屋は　２年生の　教室です。	null		\N	vmod				\N	1
1300	先生はあの人です。	先生はあの人です。	null		\N	vmod				\N	1
1301	あの　きれいな　女の人は　山本さんです。	あの　きれいな　女の人は　山本さんです。	null		\N	vmod				\N	1
1711	かしこまりました。	かしこまりました。	null		\N	vmod				\N	1
1303	田中さんの消しゴムはどれですか。	田中さんの消しゴムはどれですか。	null		\N	vmod				\N	1
1304	それです。	それです。	null		\N	vmod				\N	1
1306	あそこです。	あそこです。	null		\N	vmod				\N	1
1307	ありがとうございました。	ありがとうございました。	null		\N	vmod				\N	1
1313	あそこです。	あそこです。	null		\N	vmod				\N	1
1314	わたしのぼうしはどこにありますか。	わたしのぼうしはどこにありますか。	null		\N	vmod				\N	1
1315	そこにあります。	そこにあります。	null		\N	vmod				\N	1
1316	どこですか。	どこですか。	null		\N	vmod				\N	1
1317	あなたのうしろです。	あなたのうしろです。	null		\N	vmod				\N	1
1318	あそこに　かさが　５本　あります。	あそこに　かさが　５本　あります。	null		\N	vmod				\N	1
1321	100円です。	100円です。	null		\N	vmod				\N	1
1324	ボールが　いくつ　ありますか。	ボールが　いくつ　ありますか。	null		\N	vmod				\N	1
1325	15あります。	15あります。	null		\N	vmod				\N	1
1327	３枚　あります。	３枚　あります。	null		\N	vmod				\N	1
1328	そこに　ハンカチが　どのくらい　ありますか。	そこに　ハンカチが　どのくらい　ありますか。	null		\N	vmod				\N	1
1329	30枚くらい　あります。	30枚くらい　あります。	null		\N	vmod				\N	1
1331	今、何時ですか。	今、何時ですか。	null		\N	vmod				\N	1
1336	5月21日です。	5月21日です。	null		\N	vmod				\N	1
1337	あしたは　何曜日ですか。	あしたは　何曜日ですか。	null		\N	vmod				\N	1
1338	日曜日です。	日曜日です。	null		\N	vmod				\N	1
1339	わたしは毎日勉強します。	わたしは毎日勉強します。	null		\N	vmod				\N	1
1340	わたしは　毎日　勉強しません。	わたしは　毎日　勉強しません。	null		\N	vmod				\N	1
1342	田中さんは教室にいます。	田中さんは教室にいます。	null		\N	vmod				\N	1
1343	田中さんは　これから　図書館で　勉強します。	田中さんは　これから　図書館で　勉強します。	null		\N	vmod				\N	1
1344	わたしはあした研究室にいます。	わたしはあした研究室にいます。	null		\N	vmod				\N	1
1345	あしたパーティーがあります。	あしたパーティーがあります。	null		\N	vmod				\N	1
1346	わたしはあした研究室にいません。	わたしはあした研究室にいません。	null		\N	vmod				\N	1
1347	あした、小説家の山口さんが来ます。	あした、小説家の山口さんが来ます。	null		\N	vmod				\N	1
1351	熱が　ありますから、　休みます。	熱が　ありますから、　休みます。	null		\N	vmod				\N	1
1353	テレビはピアノのそばにありますか。	テレビはピアノのそばにありますか。	null		\N	vmod				\N	1
1354	田中さんは教室にいますか。	田中さんは教室にいますか。	null		\N	vmod				\N	1
1355	これから図書館で勉強しますか。	これから図書館で勉強しますか。	null		\N	vmod				\N	1
1357	むかし、　学校の　門の　そばに　大きい　木が　ありました。	むかし、　学校の　門の　そばに　大きい　木が　ありました。	null		\N	vmod				\N	1
1358	きのうは　雨が　降りませんでした。	きのうは　雨が　降りませんでした。	null		\N	vmod				\N	1
1333	Pukul berapa sekarang? 	今、　何時　何分ですか。	null		\N	vmod				\N	1
1359	きのう地震がありましたか。	きのう地震がありましたか。	null		\N	vmod				\N	1
1360	はい、ありました。	はい、ありました。	null		\N	vmod				\N	1
1361	試験は終わりましたか。	試験は終わりましたか。	null		\N	vmod				\N	1
1362	はい、終わりました。	はい、終わりました。	null		\N	vmod				\N	1
1364	B1：はい、もう終わりました。	B1：はい、もう終わりました。	null		\N	vmod				\N	1
1366	学校へ行きます。	学校へ行きます。	null		\N	vmod				\N	1
1368	公園へ行きますか。	公園へ行きますか。	null		\N	vmod				\N	1
1370	わたしは　ハンバーガーを　食べます。	わたしは　ハンバーガーを　食べます。	null		\N	vmod				\N	1
1372	CDを買います。	CDを買います。	null		\N	vmod				\N	1
1373	切手を　3枚　買います。	切手を　3枚　買います。	null		\N	vmod				\N	1
1374	何を食べますか。	何を食べますか。	null		\N	vmod				\N	1
1375	サンドイッチを食べます。	サンドイッチを食べます。	null		\N	vmod				\N	1
1376	あした映画を見ますか。	あした映画を見ますか。	null		\N	vmod				\N	1
1377	いいえ、見ません。	いいえ、見ません。	null		\N	vmod				\N	1
1381	佐藤さんにプレゼントをあげます。	佐藤さんにプレゼントをあげます。	null		\N	vmod				\N	1
1383	木村さんに　フランス語を　習います。	木村さんに　フランス語を　習います。	null		\N	vmod				\N	1
1384	佐藤さんにプレゼントをもらいます。	佐藤さんにプレゼントをもらいます。	null		\N	vmod				\N	1
1385	壁にシールをはります。	壁にシールをはります。	null		\N	vmod				\N	1
1387	山田さんに本を見せます。	山田さんに本を見せます。	null		\N	vmod				\N	1
1390	何時に起きますか。	何時に起きますか。	null		\N	vmod				\N	1
1394	あしたテニスをします。	あしたテニスをします。	null		\N	vmod				\N	1
1395	土曜日、　何を　しましたか。	土曜日、　何を　しましたか。	null		\N	vmod				\N	1
1399	この　りんごは　甘いです。	この　りんごは　甘いです。	null		\N	vmod				\N	1
1400	あの　りんごは　甘く　ありません。	あの　りんごは　甘く　ありません。	null		\N	vmod				\N	1
1404	甘いです。	甘いです。	null		\N	vmod				\N	1
1405	大きいです。	大きいです。	null		\N	vmod				\N	1
1406	勉強は　おもしろいですか。	勉強は　おもしろいですか。	null		\N	vmod				\N	1
1407	はい、　おもしろいです。	はい、　おもしろいです。	null		\N	vmod				\N	1
1411	はい、寒いです。	はい、寒いです。	null		\N	vmod				\N	1
1412	外は寒いですか。	外は寒いですか。	null		\N	vmod				\N	1
1413	いいえ、寒くありません。	いいえ、寒くありません。	null		\N	vmod				\N	1
1415	おいしいです。	おいしいです。	null		\N	vmod				\N	1
1416	どんなかばんですか。	どんなかばんですか。	null		\N	vmod				\N	1
1417	赤いです。	赤いです。	null		\N	vmod				\N	1
1420	きのうは　寒くなかったです。	きのうは　寒くなかったです。	null		\N	vmod				\N	1
1832	車がほしいですか。	車がほしいですか。	null		\N	vmod				\N	1
1421	北海道はどうでしたか。	北海道はどうでしたか。	null		\N	vmod				\N	1
1422	   B:寒かったです。	   B:寒かったです。	null		\N	vmod				\N	1
1424	   B:おもしろくありませんでした。	   B:おもしろくありませんでした。	null		\N	vmod				\N	1
1462	その　ケーキは　おいしかった。	その　ケーキは　おいしかった。	null		\N	vmod				\N	1
1425	太郎君の　犬は　とても　大きいです。	太郎君の　犬は　とても　大きいです。	null		\N	vmod				\N	1
1430	あまり　勉強しません。	あまり　勉強しません。	null		\N	vmod				\N	1
1432	きょうは　暑い　日です。	きょうは　暑い　日です。	null		\N	vmod				\N	1
1436	きょうはハッピーな日です。	きょうはハッピーな日です。	null		\N	vmod				\N	1
1437	この　かさは　じょうぶです。	この　かさは　じょうぶです。	null		\N	vmod				\N	1
1438	その　かさは　じょうぶですか。	その　かさは　じょうぶですか。	null		\N	vmod				\N	1
1439	いいえ、じょうぶではありません。	いいえ、じょうぶではありません。	null		\N	vmod				\N	1
1440	田中さんは　元気でしたか。	田中さんは　元気でしたか。	null		\N	vmod				\N	1
1441	はい、　元気でした。	はい、　元気でした。	null		\N	vmod				\N	1
1442	いいえ、　元気ではありませんでした。	いいえ、　元気ではありませんでした。	null		\N	vmod				\N	1
1443	このかさはじょうぶではないです。	このかさはじょうぶではないです。	null		\N	vmod				\N	1
1444	田中さんは　元気ではなかったです。	田中さんは　元気ではなかったです。	null		\N	vmod				\N	1
1445	田中さんは　髪が　長いです。	田中さんは　髪が　長いです。	null		\N	vmod				\N	1
1447	中山さんは　力が　強いです。	中山さんは　力が　強いです。	null		\N	vmod				\N	1
1448	うちの　猫は　目が　きれいです。	うちの　猫は　目が　きれいです。	null		\N	vmod				\N	1
1452	田中さん、だいじょうぶですか。	田中さん、だいじょうぶですか。	null		\N	vmod				\N	1
1453	ちょっと　気分が　悪いです。	ちょっと　気分が　悪いです。	null		\N	vmod				\N	1
1456	田中さんはバスケットボールがじょうずです。	田中さんはバスケットボールがじょうずです。	null		\N	vmod				\N	1
1458	わたしはピアノが得意です。	わたしはピアノが得意です。	null		\N	vmod				\N	1
1463	公園は　静かだった。	公園は　静かだった。	null		\N	vmod				\N	1
1464	あの　電子辞書は　便利ではなかった。	あの　電子辞書は　便利ではなかった。	null		\N	vmod				\N	1
1465	わたしは大学生だ。	わたしは大学生だ。	null		\N	vmod				\N	1
1466	木村さんは先生ではない。	木村さんは先生ではない。	null		\N	vmod				\N	1
1467	ここはむかし公園だった。	ここはむかし公園だった。	null		\N	vmod				\N	1
1468	山田さんは　病気ではなかった。	山田さんは　病気ではなかった。	null		\N	vmod				\N	1
1470	この　雑誌は　新しい。	この　雑誌は　新しい。	null		\N	vmod				\N	1
1471	あの　電子辞書は　便利だ。	あの　電子辞書は　便利だ。	null		\N	vmod				\N	1
1472	きょうは雨だ。	きょうは雨だ。	null		\N	vmod				\N	1
1475	あしたは　雨が　降るでしょう。	あしたは　雨が　降るでしょう。	null		\N	vmod				\N	1
1474	Kita boleh belajar di sini. 	ここで　勉強する　ことが　できます。	null		\N	vmod				\N	1
1479	雨が降ったので試合が中止になりました。	雨が降ったので試合が中止になりました。	null		\N	vmod				\N	1
1480	雨が　降ったけれども　試合を　しました。	雨が　降ったけれども　試合を　しました。	null		\N	vmod				\N	1
1483	６時に起きて、ジョギングをしました。	６時に起きて、ジョギングをしました。	null		\N	vmod				\N	1
1486	もう一度　言って　くださいませんか。	もう一度　言って　くださいませんか。	null		\N	vmod				\N	1
1487	あした、休んでもいいですか。	あした、休んでもいいですか。	null		\N	vmod				\N	1
1488	本を読んであげます。	本を読んであげます。	null		\N	vmod				\N	1
1489	ビールを買っていきます。	ビールを買っていきます。	null		\N	vmod				\N	1
1490	食べてみます。	食べてみます。	null		\N	vmod				\N	1
1493	ごはんを　食べて　います。	ごはんを　食べて　います。	null		\N	vmod				\N	1
1498	木村さんをお願いします。	木村さんをお願いします。	null		\N	vmod				\N	1
1499	木村さんは　今　食事を　しています。	木村さんは　今　食事を　しています。	null		\N	vmod				\N	1
1500	体育館の　前に　小林さんが　立って　います。	体育館の　前に　小林さんが　立って　います。	null		\N	vmod				\N	1
1502	山田先生を　知って　いますか。	山田先生を　知って　いますか。	null		\N	vmod				\N	1
1504	わたしは　毎朝　ジョギングを　して　います。	わたしは　毎朝　ジョギングを　して　います。	null		\N	vmod				\N	1
1505	わたしは　３年前　アメリカで　勉強して　います。	わたしは　３年前　アメリカで　勉強して　います。	null		\N	vmod				\N	1
1936	この　絵は　まるで　写真のようです。	この　絵は　まるで　写真のようです。	null		\N	vmod				\N	1
1506	山田さんは　10年前に　大学を　卒業して　います。	山田さんは　10年前に　大学を　卒業して　います。	null		\N	vmod				\N	1
1508	ビルがそびえています。	ビルがそびえています。	null		\N	vmod				\N	1
1509	山田さんは　お父さんに　似ています。	山田さんは　お父さんに　似ています。	null		\N	vmod				\N	1
1510	もしもし、　まりさんは　いますか。	もしもし、　まりさんは　いますか。	null		\N	vmod				\N	1
1511	 B：いいえ。まりは今買い物に行っています。	 B：いいえ。まりは今買い物に行っています。	null		\N	vmod				\N	1
1514	駅の　ホームに　新しい　映画の　ポスターが　はって　ありました。	駅の　ホームに　新しい　映画の　ポスターが　はって　ありました。	null		\N	vmod				\N	1
1516	机の　上に　辞書が　置いて　ありますか。	机の　上に　辞書が　置いて　ありますか。	null		\N	vmod				\N	1
1517	はい、　置いて　あります。	はい、　置いて　あります。	null		\N	vmod				\N	1
1518	あ、　ケーキが　切って　ありますよ。	あ、　ケーキが　切って　ありますよ。	null		\N	vmod				\N	1
1519	じゃあ、食べましょう。	じゃあ、食べましょう。	null		\N	vmod				\N	1
1521	小林さんに　来週の　予定を　話して　ありますか。	小林さんに　来週の　予定を　話して　ありますか。	null		\N	vmod				\N	1
1522	いいえ、まだです。	いいえ、まだです。	null		\N	vmod				\N	1
1523	漢字を調べてありますか。	漢字を調べてありますか。	null		\N	vmod				\N	1
1524	はい、調べました。	はい、調べました。	null		\N	vmod				\N	1
1525	田中さんと　山田さんは　大学２年生です。	田中さんと　山田さんは　大学２年生です。	null		\N	vmod				\N	1
1526	わたしは　パンと　サラダを　食べます。	わたしは　パンと　サラダを　食べます。	null		\N	vmod				\N	1
1485	Sila berdiri.	立って　ください。	null		\N	vmod				\N	1
1529	わたしは　日曜日に　漫画や　雑誌を　読みます。	わたしは　日曜日に　漫画や　雑誌を　読みます。	null		\N	vmod				\N	1
1536	３年生で留学生の金さん	３年生で留学生の金さん	null		\N	vmod				\N	1
1613	木村さんに本をあげます。	木村さんに本をあげます。	null		\N	vmod				\N	1
1538	木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	null		\N	vmod				\N	1
1539	田中さんは３年生で、中村さんは４年生です。	田中さんは３年生で、中村さんは４年生です。	null		\N	vmod				\N	1
1540	親切でおもしろい人	親切でおもしろい人	null		\N	vmod				\N	1
1541	若くてお金持ちの人	若くてお金持ちの人	null		\N	vmod				\N	1
1543	田中さんは　背が　高くて　めがねを　かけて　います。	田中さんは　背が　高くて　めがねを　かけて　います。	null		\N	vmod				\N	1
1550	雨が　降ったり　やんだり　して　います。	雨が　降ったり　やんだり　して　います。	null		\N	vmod				\N	1
1552	あしたの　予定を　教えて　ください。	あしたの　予定を　教えて　ください。	null		\N	vmod				\N	1
1554	わたしは　日本へ　行って、　すもうを　見たいです。	わたしは　日本へ　行って、　すもうを　見たいです。	null		\N	vmod				\N	1
1555	２つに　折って、　はさみで　切って　ください。	２つに　折って、　はさみで　切って　ください。	null		\N	vmod				\N	1
1559	夏休みに　中山さんは　海で　ダイビングを　して、　山本さんは　山に　登りました。	夏休みに　中山さんは　海で　ダイビングを　して、　山本さんは　山に　登りました。	null		\N	vmod				\N	1
1560	田中さんは　東京に　住んで　いて、　山本さんは　大阪に　住んで　います。	田中さんは　東京に　住んで　いて、　山本さんは　大阪に　住んで　います。	null		\N	vmod				\N	1
1561	雨が降って、野球の試合を中止しました。	雨が降って、野球の試合を中止しました。	null		\N	vmod				\N	1
1563	田中さんが来て、木村さんが帰りました。	田中さんが来て、木村さんが帰りました。	null		\N	vmod				\N	1
1566	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	1
1931	Kelihatannya hujan akan turun.	雨が　降りそうです。	null		\N	vmod				\N	1
1567	本を読みます。	本を読みます。	null		\N	vmod				\N	1
1568	10時から　授業を　始めます。	10時から　授業を　始めます。	null		\N	vmod				\N	1
1569	朝　起きて　顔を　洗います。	朝　起きて　顔を　洗います。	null		\N	vmod				\N	1
1570	春に　なると、　暖かく　なります。	春に　なると、　暖かく　なります。	null		\N	vmod				\N	1
1571	雨が降ったら運動会は休みです。	雨が降ったら運動会は休みです。	null		\N	vmod				\N	1
1572	この本は読みました。	この本は読みました。	null		\N	vmod				\N	1
1573	この本も読みました。	この本も読みました。	null		\N	vmod				\N	1
1574	この本だけ読みました。	この本だけ読みました。	null		\N	vmod				\N	1
1575	この本ばかり読みました。	この本ばかり読みました。	null		\N	vmod				\N	1
1576	この本まで読みました。	この本まで読みました。	null		\N	vmod				\N	1
1577	この本など読みました。	この本など読みました。	null		\N	vmod				\N	1
1578	あしたは日曜日ですか。	あしたは日曜日ですか。	null		\N	vmod				\N	1
1579	あしたは日曜日ですよ。	あしたは日曜日ですよ。	null		\N	vmod				\N	1
1580	あしたは日曜日ですね。	あしたは日曜日ですね。	null		\N	vmod				\N	1
1581	あなた に だけ は 話しましょう。	あなた に だけ は 話しましょう。	null		\N	vmod				\N	1
1582	きょうの　テストは　３時からですよね。	きょうの　テストは　３時からですよね。	null		\N	vmod				\N	1
1584	先生に相談します。	先生に相談します。	null		\N	vmod				\N	1
1585	学校へ行きます。	学校へ行きます。	null		\N	vmod				\N	1
1664	これで十分です。	これで十分です。	null		\N	vmod				\N	1
1587	佐藤さんは鈴木さんより年上です。	佐藤さんは鈴木さんより年上です。	null		\N	vmod				\N	1
1589	机の上	机の上	null		\N	vmod				\N	1
1590	田中さんと山田さんが来ました。	田中さんと山田さんが来ました。	null		\N	vmod				\N	1
1591	佐藤さんや田中さんが来ました。	佐藤さんや田中さんが来ました。	null		\N	vmod				\N	1
1593	田中さんが最初です。	田中さんが最初です。	null		\N	vmod				\N	1
1594	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	1
1595	コンピューターがほしいです。	コンピューターがほしいです。	null		\N	vmod				\N	1
1596	ふるさとがなつかしいです。	ふるさとがなつかしいです。	null		\N	vmod				\N	1
1597	水｛が/を｝飲みたいです。	水｛が/を｝飲みたいです。	null		\N	vmod				\N	1
1598	英語｛が/を｝話せます。	英語｛が/を｝話せます。	null		\N	vmod				\N	1
1600	わたし、大学へ行きます。	わたし、大学へ行きます。	null		\N	vmod				\N	1
1602	十字路を　右に　曲がります。	十字路を　右に　曲がります。	null		\N	vmod				\N	1
1603	毎日　この　道を　通ります。	毎日　この　道を　通ります。	null		\N	vmod				\N	1
1604	大学を　卒業します。	大学を　卒業します。	null		\N	vmod				\N	1
1606	楽しい　一日を　過ごしました。	楽しい　一日を　過ごしました。	null		\N	vmod				\N	1
1607	あらしの　中を　走りました。	あらしの　中を　走りました。	null		\N	vmod				\N	1
1608	拍手の中を歩きました。	拍手の中を歩きました。	null		\N	vmod				\N	1
1610	パン、食べました。	パン、食べました。	null		\N	vmod				\N	1
1611	山田さんにプレゼントを贈ります。	山田さんにプレゼントを贈ります。	null		\N	vmod				\N	1
1612	田中さんに　英語を　教えます。	田中さんに　英語を　教えます。	null		\N	vmod				\N	1
1616	犬が山田さんにほえました。	犬が山田さんにほえました。	null		\N	vmod				\N	1
1617	東京に行きます。	東京に行きます。	null		\N	vmod				\N	1
1618	家に帰ります。	家に帰ります。	null		\N	vmod				\N	1
1620	駅の　前に　集まります。	駅の　前に　集まります。	null		\N	vmod				\N	1
1621	氷が水になりました。	氷が水になりました。	null		\N	vmod				\N	1
1622	山田さんは子どもを政治家にしました。	山田さんは子どもを政治家にしました。	null		\N	vmod				\N	1
1623	山田さんに　本を　読ませます。	山田さんに　本を　読ませます。	null		\N	vmod				\N	1
1624	先生にほめられました。	先生にほめられました。	null		\N	vmod				\N	1
1627	木村さんに　英語を　教わりました。	木村さんに　英語を　教わりました。	null		\N	vmod				\N	1
1628	山田さんはお父さんに似ています。	山田さんはお父さんに似ています。	null		\N	vmod				\N	1
1629	この　ズボンは　わたしには　大きすぎます。	この　ズボンは　わたしには　大きすぎます。	null		\N	vmod				\N	1
2049	あした雨が降れば、運動会は中止です。	あした雨が降れば、運動会は中止です。	null		\N	vmod				\N	1
1631	１回に　３袋ずつ　使います。	１回に　３袋ずつ　使います。	null		\N	vmod				\N	1
1632	教室に　佐藤さんが　います。	教室に　佐藤さんが　います。	null		\N	vmod				\N	1
1633	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	1
1635	大学の　近くに　家を　建てます。	大学の　近くに　家を　建てます。	null		\N	vmod				\N	1
1639	買い物に　行きます。	買い物に　行きます。	null		\N	vmod				\N	1
1641	えんぴつは　字を　書くのに　使います。	えんぴつは　字を　書くのに　使います。	null		\N	vmod				\N	1
1642	山田さんに佐藤さんに田中さんが来ました。	山田さんに佐藤さんに田中さんが来ました。	null		\N	vmod				\N	1
1643	人の多さにびっくりしました。	人の多さにびっくりしました。	null		\N	vmod				\N	1
1644	カラオケで　歌いに　歌って、　声が　出なく　なりました。	カラオケで　歌いに　歌って、　声が　出なく　なりました。	null		\N	vmod				\N	1
1689	佐藤さんは鈴木さんと学校に行きました。	佐藤さんは鈴木さんと学校に行きました。	null		\N	vmod				\N	1
1648	大人から　子どもまで　人気が　あります。	大人から　子どもまで　人気が　あります。	null		\N	vmod				\N	1
1649	この　店は、　おかしから　チケットまで、　なんでも　売って　います。	この　店は、　おかしから　チケットまで、　なんでも　売って　います。	null		\N	vmod				\N	1
1651	あしたから夏休みです。	あしたから夏休みです。	null		\N	vmod				\N	1
1652	ぶどうからワインを作ります。	ぶどうからワインを作ります。	null		\N	vmod				\N	1
1653	田中さんから本を贈りました。	田中さんから本を贈りました。	null		\N	vmod				\N	1
1655	わたしから説明します。	わたしから説明します。	null		\N	vmod				\N	1
1656	鈴木さんから説明させました。	鈴木さんから説明させました。	null		\N	vmod				\N	1
1657	先生からほめられました。	先生からほめられました。	null		\N	vmod				\N	1
1658	白線より　中に　入らないで　ください。	白線より　中に　入らないで　ください。	null		\N	vmod				\N	1
1659	これより会議を始めます。	これより会議を始めます。	null		\N	vmod				\N	1
1661	世界で　一番　長い　川は　ナイル川です。	世界で　一番　長い　川は　ナイル川です。	null		\N	vmod				\N	1
1662	日本では、　３月と　４月と　５月は　春です。	日本では、　３月と　４月と　５月は　春です。	null		\N	vmod				\N	1
1665	あしたでも　いいです。	あしたでも　いいです。	null		\N	vmod				\N	1
1666	これではだめです。	これではだめです。	null		\N	vmod				\N	1
1669	佐藤さんは　大きい　声で　話します。	佐藤さんは　大きい　声で　話します。	null		\N	vmod				\N	1
1670	木で机を作ります。	木で机を作ります。	null		\N	vmod				\N	1
1673	子どもがはだしで歩いています。	子どもがはだしで歩いています。	null		\N	vmod				\N	1
1674	子どもが　はだかで　走って　います。	子どもが　はだかで　走って　います。	null		\N	vmod				\N	1
3062	Salon kecantikan ada di sebelah stesen. 	美容院は　駅の　横に　あります。	\N		\N	vmod				668	1
1676	家族　全員で　ドライブ　しました。	家族　全員で　ドライブ　しました。	null		\N	vmod				\N	1
1677	日本語が１年間でじょうずになりました。	日本語が１年間でじょうずになりました。	null		\N	vmod				\N	1
1678	この　コンピューターを　20万円で　買いました。	この　コンピューターを　20万円で　買いました。	null		\N	vmod				\N	1
2103	小林さんに手伝ってもらいました。	小林さんに手伝ってもらいました。	null		\N	vmod				\N	1
1680	２と３で５です。	２と３で５です。	null		\N	vmod				\N	1
1681	警察で事件を調べています。	警察で事件を調べています。	null		\N	vmod				\N	1
1684	庭の花	庭の花	null		\N	vmod				\N	1
1690	田中さんは山田さんと結婚しました。	田中さんは山田さんと結婚しました。	null		\N	vmod				\N	1
1691	田中さんはお父さんと似ています。	田中さんはお父さんと似ています。	null		\N	vmod				\N	1
1695	毎日ジョギングをする人はえらいと思います。	毎日ジョギングをする人はえらいと思います。	null		\N	vmod				\N	1
1698	はい。	はい。	null		\N	vmod				\N	1
1699	ハンバーガーとサラダをお願いします。	ハンバーガーとサラダをお願いします。	null		\N	vmod				\N	1
1700	はい。	はい。	null		\N	vmod				\N	1
1701	書類の　コピーを　ください。	書類の　コピーを　ください。	null		\N	vmod				\N	1
1702	すみません、水をくださいませんか。	すみません、水をくださいませんか。	null		\N	vmod				\N	1
1704	あのう、　この　町の　地図を　くださいませんか。	あのう、　この　町の　地図を　くださいませんか。	null		\N	vmod				\N	1
1705	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	1
1706	りんご、ください。	りんご、ください。	null		\N	vmod				\N	1
1707	ハンバーグ、ください。	ハンバーグ、ください。	null		\N	vmod				\N	1
1708	赤い　ばらを　８本　ください。	赤い　ばらを　８本　ください。	null		\N	vmod				\N	1
1709	はい。1200円です。	はい。1200円です。	null		\N	vmod				\N	1
1712	教科書の　15ページを　見て　ください。	教科書の　15ページを　見て　ください。	null		\N	vmod				\N	1
1713	テープの　会話を　聞いて　ください。	テープの　会話を　聞いて　ください。	null		\N	vmod				\N	1
1716	３年生は　手を　あげて　ください。	３年生は　手を　あげて　ください。	null		\N	vmod				\N	1
1717	２年生は、あした８時に学校へ来てください。	２年生は、あした８時に学校へ来てください。	null		\N	vmod				\N	1
1718	どうかゆるしてください。	どうかゆるしてください。	null		\N	vmod				\N	1
1719	わたしを助けてください。	わたしを助けてください。	null		\N	vmod				\N	1
1721	あした　電話を　して　ください。	あした　電話を　して　ください。	null		\N	vmod				\N	1
1722	がんばってください。	がんばってください。	null		\N	vmod				\N	1
1723	安心してください。	安心してください。	null		\N	vmod				\N	1
1724	ぜひ来てください。	ぜひ来てください。	null		\N	vmod				\N	1
1725	もう一度説明してくださいませんか。	もう一度説明してくださいませんか。	null		\N	vmod				\N	1
1726	すみません、　窓を　開けて　くださいませんか。	すみません、　窓を　開けて　くださいませんか。	null		\N	vmod				\N	1
1771	いっしょに昼ごはんを食べませんか。	いっしょに昼ごはんを食べませんか。	null		\N	vmod				\N	1
1729	この　コピー機は　学生が　使っても　いいですよ。	この　コピー機は　学生が　使っても　いいですよ。	null		\N	vmod				\N	1
1730	これを借りてもいいですか。	これを借りてもいいですか。	null		\N	vmod				\N	1
1731	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	1
1732	この　辞書を　借りても　いいですか。	この　辞書を　借りても　いいですか。	null		\N	vmod				\N	1
1735	いいえ。	いいえ。	null		\N	vmod				\N	1
2255	山田さんさえいたら、この試合には勝てるのに。	山田さんさえいたら、この試合には勝てるのに。	null		\N	vmod				\N	1
1736	辞書を　見ても　いいですか。　	辞書を　見ても　いいですか。　	null		\N	vmod				\N	1
1737	いいえ、いけません。	いいえ、いけません。	null		\N	vmod				\N	1
1715	Ya, baiklah. 	はい、　わかりました。	null		\N	vmod				\N	1
2039	卒業論文を　出せば、　卒業できます。	卒業論文を　出せば、　卒業できます。	null		\N	vmod				\N	1
1739	この　部屋で　たばこを　すっては　いけません。	この　部屋で　たばこを　すっては　いけません。	null		\N	vmod				\N	1
1740	しばらく　お酒を　飲んでは　だめです。	しばらく　お酒を　飲んでは　だめです。	null		\N	vmod				\N	1
1741	この教室は使っちゃいけませんよ。	この教室は使っちゃいけませんよ。	null		\N	vmod				\N	1
1742	泣いちゃだめですよ。	泣いちゃだめですよ。	null		\N	vmod				\N	1
1743	木村さん、その本を借りてはいけませんか。	木村さん、その本を借りてはいけませんか。	null		\N	vmod				\N	1
1744	ここでは　たばこを　すわないで　ください。	ここでは　たばこを　すわないで　ください。	null		\N	vmod				\N	1
1746	宿題を忘れないでください。	宿題を忘れないでください。	null		\N	vmod				\N	1
1747	はい、わかりました。	はい、わかりました。	null		\N	vmod				\N	1
1749	どうかおこらないでください。	どうかおこらないでください。	null		\N	vmod				\N	1
1750	わたしを殺さないでください。	わたしを殺さないでください。	null		\N	vmod				\N	1
1751	不合格にしないでください。	不合格にしないでください。	null		\N	vmod				\N	1
1752	だいじょうぶです。心配しないでください。	だいじょうぶです。心配しないでください。	null		\N	vmod				\N	1
1753	あまり無理をしないでください。	あまり無理をしないでください。	null		\N	vmod				\N	1
1754	気にしないでください。	気にしないでください。	null		\N	vmod				\N	1
1755	どうぞ　遠慮しないで　ください。	どうぞ　遠慮しないで　ください。	null		\N	vmod				\N	1
1756	ペンでもいいですか。	ペンでもいいですか。	null		\N	vmod				\N	1
1757	B1：はい、いいです。	B1：はい、いいです。	null		\N	vmod				\N	1
1758	B2：いいえ、だめです。	B2：いいえ、だめです。	null		\N	vmod				\N	1
1759	レポートはあしたでもいいですか。	レポートはあしたでもいいですか。	null		\N	vmod				\N	1
1760	B1：はい、あしたでもいいです。	B1：はい、あしたでもいいです。	null		\N	vmod				\N	1
1761	B2：いいえ、あしたではだめです。	B2：いいえ、あしたではだめです。	null		\N	vmod				\N	1
1762	パーティーは、ジーンズではいけません。	パーティーは、ジーンズではいけません。	null		\N	vmod				\N	1
1763	この試験は、えんぴつではだめです。	この試験は、えんぴつではだめです。	null		\N	vmod				\N	1
1764	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	1
1765	はい。	はい。	null		\N	vmod				\N	1
1766	スケートに行きませんか。	スケートに行きませんか。	null		\N	vmod				\N	1
1767	いいですね。	いいですね。	null		\N	vmod				\N	1
1769	すみません。　土曜日は　仕事が　あります。	すみません。　土曜日は　仕事が　あります。	null		\N	vmod				\N	1
1772	少し　休みませんか。	少し　休みませんか。	null		\N	vmod				\N	1
1773	いっしょに帰りましょう。	いっしょに帰りましょう。	null		\N	vmod				\N	1
1775	信号が　青に　なりました。　さあ、　渡りましょう。	信号が　青に　なりました。　さあ、　渡りましょう。	null		\N	vmod				\N	1
1776	いっしょに昼ごはんを食べませんか。	いっしょに昼ごはんを食べませんか。	null		\N	vmod				\N	1
1779	いいですね。行きましょう。	いいですね。行きましょう。	null		\N	vmod				\N	1
1780	食事の　前には　手を　洗いましょう。	食事の　前には　手を　洗いましょう。	null		\N	vmod				\N	1
1781	手を　あげて　横断歩道を　渡りましょう。	手を　あげて　横断歩道を　渡りましょう。	null		\N	vmod				\N	1
1782	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	1
1783	ええ、帰りましょう。	ええ、帰りましょう。	null		\N	vmod				\N	1
1784	スケートに行きませんか。	スケートに行きませんか。	null		\N	vmod				\N	1
1785	いいですね。行きましょう。	いいですね。行きましょう。	null		\N	vmod				\N	1
1786	土曜日の午後、テニスをしませんか。	土曜日の午後、テニスをしませんか。	null		\N	vmod				\N	1
1787	土曜日ですか。土曜日はちょっと。	土曜日ですか。土曜日はちょっと。	null		\N	vmod				\N	1
1788	あした、　うちへ　遊びに　来ませんか。	あした、　うちへ　遊びに　来ませんか。	null		\N	vmod				\N	1
1789	ありがとう　ございます。　でも、　あしたは　ちょっと。	ありがとう　ございます。　でも、　あしたは　ちょっと。	null		\N	vmod				\N	1
1790	映画を見に行きませんか。	映画を見に行きませんか。	null		\N	vmod				\N	1
3072	Kotak ini lebarnya pendek dan panjangnya panjang.	この　箱は　縦が　短くて、　横が　長いです。	\N		\N	vmod				668	1
3427	Saya akan belajar kanji setiap hari mulai esok. 	あしたから　毎日　漢字を　勉強します。	\N		\N	vmod				16	1
1791	すみません。アルバイトがあります。	すみません。アルバイトがあります。	null		\N	vmod				\N	1
1792	きょうから日記を書こう。	きょうから日記を書こう。	null		\N	vmod				\N	1
1793	きょうは　食堂で　昼食を　食べよう。	きょうは　食堂で　昼食を　食べよう。	null		\N	vmod				\N	1
1795	図書館でいっしょに勉強しましょう。	図書館でいっしょに勉強しましょう。	null		\N	vmod				\N	1
1796	あしたもう一度来よう。	あしたもう一度来よう。	null		\N	vmod				\N	1
1797	家に　帰ったら　掃除しよう。	家に　帰ったら　掃除しよう。	null		\N	vmod				\N	1
1798	この　辺で　休みましょう。	この　辺で　休みましょう。	null		\N	vmod				\N	1
1800	わたしは６時に帰ります。	わたしは６時に帰ります。	null		\N	vmod				\N	1
1812	わたしは　今度の　休みに　友だちと　旅行したいです。	わたしは　今度の　休みに　友だちと　旅行したいです。	null		\N	vmod				\N	1
1814	将来、何になりたいですか。	将来、何になりたいですか。	null		\N	vmod				\N	1
1815	日本語の先生になりたいです。	日本語の先生になりたいです。	null		\N	vmod				\N	1
1816	どんな　音楽を　聞きたいですか。	どんな　音楽を　聞きたいですか。	null		\N	vmod				\N	1
1819	何が食べたいですか。	何が食べたいですか。	null		\N	vmod				\N	1
1820	そうですね、サンドイッチが食べたいです。	そうですね、サンドイッチが食べたいです。	null		\N	vmod				\N	1
1821	すみません、　山田先生と　話したいんですが。	すみません、　山田先生と　話したいんですが。	null		\N	vmod				\N	1
1822	はい、　ちょっと　待って　ください。	はい、　ちょっと　待って　ください。	null		\N	vmod				\N	1
1823	先生、お手洗いに行きたいんですが。	先生、お手洗いに行きたいんですが。	null		\N	vmod				\N	1
1825	山田さんは　旅行したがって　います。	山田さんは　旅行したがって　います。	null		\N	vmod				\N	1
1827	みんなの　前で　発表したく　ありませんでした。	みんなの　前で　発表したく　ありませんでした。	null		\N	vmod				\N	1
1828	駅まで　歩きたくなかったです。	駅まで　歩きたくなかったです。	null		\N	vmod				\N	1
1829	きのうコンサートに行ってきました。	きのうコンサートに行ってきました。	null		\N	vmod				\N	1
1830	そうですか。　それは　わたしも　行きたかったです。	そうですか。　それは　わたしも　行きたかったです。	null		\N	vmod				\N	1
1833	いいえ、｛ほしくありません／ほしくないです｝。	いいえ、｛ほしくありません／ほしくないです｝。	null		\N	vmod				\N	1
682	K先生がこわいです。	K先生がこわいです。	null		\N	vmod				\N	0
719	たぶん田中さんでしょう。	たぶん田中さんでしょう。	null		\N	vmod				\N	0
1059	雨が降れば運動会を中止します。	雨が降れば運動会を中止します。	null		\N	vmod				\N	0
1497	すみません、今使っています。	すみません、今使っています。	null		\N	vmod				\N	1
1663	片道で100円、往復で200円です。	片道で100円、往復で200円です。	null		\N	vmod				\N	1
1733	すみません。今使っています。	すみません。今使っています。	null		\N	vmod				\N	1
1770	あした、映画を見に行きませんか。	あした、映画を見に行きませんか。	null		\N	vmod				\N	1
2416	はい。	はい。			\N	vmod				\N	1
1834	誕生日に何がほしいですか。	誕生日に何がほしいですか。	null		\N	vmod				\N	1
1835	そうですね、　新しい　自転車が　ほしいです。	そうですね、　新しい　自転車が　ほしいです。	null		\N	vmod				\N	1
1838	わたしはコンピューターはほしくありません。	わたしはコンピューターはほしくありません。	null		\N	vmod				\N	1
1839	わたしはコンピューターはほしくないです。	わたしはコンピューターはほしくないです。	null		\N	vmod				\N	1
1840	太郎さんは犬がほしいですか。	太郎さんは犬がほしいですか。	null		\N	vmod				\N	1
1842	太郎さんはコンピューターがほしいようです。	太郎さんはコンピューターがほしいようです。	null		\N	vmod				\N	1
1843	すみません、　白い　紙が　ほしいんですが。	すみません、　白い　紙が　ほしいんですが。	null		\N	vmod				\N	1
1844	はい。	はい。	null		\N	vmod				\N	1
1845	あのう、　赤い　ボールペンが　ほしいんですが。	あのう、　赤い　ボールペンが　ほしいんですが。	null		\N	vmod				\N	1
1846	はい。	はい。	null		\N	vmod				\N	1
1847	太郎さんは新しいコンピューターをほしがっています。	太郎さんは新しいコンピューターをほしがっています。	null		\N	vmod				\N	1
1850	田中さんはテニスがすきですか。	田中さんはテニスがすきですか。	null		\N	vmod				\N	1
1851	はい、すきです。	はい、すきです。	null		\N	vmod				\N	1
1852	水泳はすきですか。	水泳はすきですか。	null		\N	vmod				\N	1
1854	何がすきですか。	何がすきですか。	null		\N	vmod				\N	1
1855	りんごがすきです。	りんごがすきです。	null		\N	vmod				\N	1
1856	どの科目がすきですか。	どの科目がすきですか。	null		\N	vmod				\N	1
1857	数学がすきです。	数学がすきです。	null		\N	vmod				\N	1
1858	わたしは　犬が　きらいです。	わたしは　犬が　きらいです。	null		\N	vmod				\N	1
1859	わたしは犬がきらいではありません。	わたしは犬がきらいではありません。	null		\N	vmod				\N	1
1861	わたしは犬がこわいです。	わたしは犬がこわいです。	null		\N	vmod				\N	1
1863	わたしは試験の結果が心配です。	わたしは試験の結果が心配です。	null		\N	vmod				\N	1
1864	わたしはつらいです。	わたしはつらいです。	null		\N	vmod				\N	1
1865	わたしは仕事がつらいです。	わたしは仕事がつらいです。	null		\N	vmod				\N	1
1866	あなたは　地震が　こわいですか。	あなたは　地震が　こわいですか。	null		\N	vmod				\N	1
1867	K先生がこわいです。	K先生がこわいです。	null		\N	vmod				\N	1
1868	田中くんは犬がこわいそうです。	田中くんは犬がこわいそうです。	null		\N	vmod				\N	1
1869	田中くんは犬がこわいらしいです。	田中くんは犬がこわいらしいです。	null		\N	vmod				\N	1
1870	田中くんは犬がこわかった。	田中くんは犬がこわかった。	null		\N	vmod				\N	1
1871	田中くんは　いつも　犬を　こわがります。	田中くんは　いつも　犬を　こわがります。	null		\N	vmod				\N	1
1872	田中くんは犬をこわがっています。	田中くんは犬をこわがっています。	null		\N	vmod				\N	1
1874	２年生は５時から体育館を使うことができます。	２年生は５時から体育館を使うことができます。	null		\N	vmod				\N	1
2045	部屋が　静かだと　よく　勉強できます。	部屋が　静かだと　よく　勉強できます。	null		\N	vmod				\N	1
1875	きょうは、バスケットボールの練習をすることができません。	きょうは、バスケットボールの練習をすることができません。	null		\N	vmod				\N	1
1876	中山さんは　200メートル　泳ぐ　ことが　できます。	中山さんは　200メートル　泳ぐ　ことが　できます。	null		\N	vmod				\N	1
1877	わたしは漢字を50書くことができます。	わたしは漢字を50書くことができます。	null		\N	vmod				\N	1
1878	中山さんは　アラビア語を　話す　ことが　できますか。	中山さんは　アラビア語を　話す　ことが　できますか。	null		\N	vmod				\N	1
1880	キムさんは　日本語が　できます。 	キムさんは　日本語が　できます。 	null		\N	vmod				\N	1
1882	わたしは車の運転ができません。	わたしは車の運転ができません。	null		\N	vmod				\N	1
1884	はい、できます。	はい、できます。	null		\N	vmod				\N	1
1886	わたしはさしみが食べられます。	わたしはさしみが食べられます。	null		\N	vmod				\N	1
1887	あした学校に来られます。	あした学校に来られます。	null		\N	vmod				\N	1
1888	水泳ができます。	水泳ができます。	null		\N	vmod				\N	1
1963	あしたの授業で使う本	あしたの授業で使う本	null		\N	vmod				\N	1
1889	パーティーに来られますか。	パーティーに来られますか。	null		\N	vmod				\N	1
1890	B1：はい、行けます。	B1：はい、行けます。	null		\N	vmod				\N	1
1891	B2：いいえ、行けません。	B2：いいえ、行けません。	null		\N	vmod				\N	1
1892	図書館で勉強できます。	図書館で勉強できます。	null		\N	vmod				\N	1
1893	彼を一生愛せますか。	彼を一生愛せますか。	null		\N	vmod				\N	1
1894	あしたは　晴れるでしょう。	あしたは　晴れるでしょう。	null		\N	vmod				\N	1
1895	きょうの試合では、Aチームが勝つでしょう。	きょうの試合では、Aチームが勝つでしょう。	null		\N	vmod				\N	1
1937	小林さんは　鳥のような　声で　歌います。	小林さんは　鳥のような　声で　歌います。	null		\N	vmod				\N	1
2257	５分ほど　まって　ください。	５分ほど　まって　ください。	null		\N	vmod				\N	1
2258	そのくらいの　ことは　自分で　できます。	そのくらいの　ことは　自分で　できます。	null		\N	vmod				\N	1
2259	山田さんくらい　頭の　いい　人は　いません。	山田さんくらい　頭の　いい　人は　いません。	null		\N	vmod				\N	1
2260	富士山は　エベレストほど　高くは　ありません。	富士山は　エベレストほど　高くは　ありません。	null		\N	vmod				\N	1
2261	君にだけ話しましょう。	君にだけ話しましょう。	null		\N	vmod				\N	1
2262	太郎君とさえ話ができなかった。	太郎君とさえ話ができなかった。	null		\N	vmod				\N	1
2263	君だけに話しましょう。	君だけに話しましょう。	null		\N	vmod				\N	1
2264	それくらいが　ちょうどいいです。	それくらいが　ちょうどいいです。	null		\N	vmod				\N	1
2265	言うのです。	言うのです。	null		\N	vmod				\N	1
2266	あしたは日曜日ですか。	あしたは日曜日ですか。	null		\N	vmod				\N	1
2267	あしたは日曜日かしら。	あしたは日曜日かしら。	null		\N	vmod				\N	1
2268	さわるな。	さわるな。	null		\N	vmod				\N	1
2269	あしたは日曜日ですよ。	あしたは日曜日ですよ。	null		\N	vmod				\N	1
2270	わたしも　そう　思いますね。	わたしも　そう　思いますね。	null		\N	vmod				\N	1
2271	ああ、　きれいだなあ。	ああ、　きれいだなあ。	null		\N	vmod				\N	1
2272	さあ、　起きるか。	さあ、　起きるか。	null		\N	vmod				\N	1
2274	あなたも　二十歳に　なりましたか。	あなたも　二十歳に　なりましたか。	null		\N	vmod				\N	1
2275	だいじょうぶか。	だいじょうぶか。	null		\N	vmod				\N	1
2276	本か。	本か。	null		\N	vmod				\N	1
2277	熱いですか。	熱いですか。	null		\N	vmod				\N	1
2278	だいじょうぶですか。	だいじょうぶですか。	null		\N	vmod				\N	1
2279	これは本ですか。	これは本ですか。	null		\N	vmod				\N	1
2280	田中さんはあした来るでしょうか。	田中さんはあした来るでしょうか。	null		\N	vmod				\N	1
2281	熱い？	熱い？	null		\N	vmod				\N	1
2282	どれが　大きい？	どれが　大きい？	null		\N	vmod				\N	1
2283	だいじょうぶ？	だいじょうぶ？	null		\N	vmod				\N	1
2284	どの部屋が静か？	どの部屋が静か？	null		\N	vmod				\N	1
2285	これは、本？　	これは、本？　	null		\N	vmod				\N	1
2286	どなたが　山田さん？	どなたが　山田さん？	null		\N	vmod				\N	1
2287	田中さんはあした来る？	田中さんはあした来る？	null		\N	vmod				\N	1
2288	田中さんは　いつ　来る？	田中さんは　いつ　来る？	null		\N	vmod				\N	1
2290	だいじょうぶか？	だいじょうぶか？	null		\N	vmod				\N	1
2291	これは本か？	これは本か？	null		\N	vmod				\N	1
2292	田中さんはあした来るか？	田中さんはあした来るか？	null		\N	vmod				\N	1
2293	熱い｛だろうか/かな/のかな/かしら｝？　	熱い｛だろうか/かな/のかな/かしら｝？　	null		\N	vmod				\N	1
2294	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？	null		\N	vmod				\N	1
2295	経済の　状態は　よくなるか、　それが　問題です。	経済の　状態は　よくなるか、　それが　問題です。	null		\N	vmod				\N	1
2296	山田さんは、眠くなったのか、目をこすっています。	山田さんは、眠くなったのか、目をこすっています。	null		\N	vmod				\N	1
2297	買い物に　出かけましたが、　何を　買うか、　どこで　買うか、　わからなく　なって　困りました。	買い物に　出かけましたが、　何を　買うか、　どこで　買うか、　わからなく　なって　困りました。	null		\N	vmod				\N	1
2299	早く行きましょうよ。	早く行きましょうよ。	null		\N	vmod				\N	1
2300	早く　やって　くださいよ。	早く　やって　くださいよ。	null		\N	vmod				\N	1
2301	３時ですね。	３時ですね。	null		\N	vmod				\N	1
2302	あしたは日曜日ですね。	あしたは日曜日ですね。	null		\N	vmod				\N	1
2303	暑いですね。	暑いですね。	null		\N	vmod				\N	1
2304	おや、まちがえたかな。	おや、まちがえたかな。	null		\N	vmod				\N	1
2305	あしたは日曜日だな。	あしたは日曜日だな。	null		\N	vmod				\N	1
2306	暑いな。	暑いな。	null		\N	vmod				\N	1
2307	。	。	null		\N	vmod				\N	1
2308	来たのは山田君さ。	来たのは山田君さ。	null		\N	vmod				\N	1
2309	僕がやるぞ。	僕がやるぞ。	null		\N	vmod				\N	1
2310	俺もやるぜ。	俺もやるぜ。	null		\N	vmod				\N	1
2311	よし、　やるとも。　	よし、　やるとも。　	null		\N	vmod				\N	1
2312	きのう、コンサートに行きましたの。	きのう、コンサートに行きましたの。	null		\N	vmod				\N	1
2313	きょうは会議がありましたよね。	きょうは会議がありましたよね。	null		\N	vmod				\N	1
2314	わたしはね、きのうね、新宿へね、行ったんですよ。	わたしはね、きのうね、新宿へね、行ったんですよ。	null		\N	vmod				\N	1
2315	きのうな、新宿へな、……	きのうな、新宿へな、……	null		\N	vmod				\N	1
2316	きのうさ、新宿へさ、……	きのうさ、新宿へさ、……	null		\N	vmod				\N	1
2317	きのうよ、新宿へよ、……	きのうよ、新宿へよ、……	null		\N	vmod				\N	1
2318	あ、斉藤先生。	あ、斉藤先生。			\N	vmod				\N	1
2319	おはようございます。	おはようございます。	 ①おはようございます　②挨拶をする　③おはよう（ございます）(朝)：こんにちは(昼)：こんばんは(夜)　④　山田さんこんにちは。		\N	vmod				\N	1
3428	Saya mesti pergi ke kedutaan esok. 	あした　大使館へ　行かなければ　なりません。	\N		\N	vmod				16	1
1932	わたしは　きょう　早く　学校に　行けそうです。	わたしは　きょう　早く　学校に　行けそうです。	null		\N	vmod				\N	1
2368	失礼します。	失礼します。			\N	vmod				\N	1
2320	おはよう。	おはよう。	①おはようございます　②挨拶をする　③おはよう（ございます）(朝)：こんにちは(昼)：こんばんは(夜)　④　山田さんこんにちは。		\N	vmod				\N	1
2321	先生、　今日は　朝から　授業ですか。	先生、　今日は　朝から　授業ですか。			\N	vmod				\N	1
2322	いいえ、午前中に会議があるんです。	いいえ、午前中に会議があるんです。			\N	vmod				\N	1
2323	山田君は。	山田君は。			\N	vmod				\N	1
2387	でも、本当にいただいていいの。	でも、本当にいただいていいの。			\N	vmod				\N	1
1938	このロボットは、生きているように動きます。	このロボットは、生きているように動きます。	null		\N	vmod				\N	1
1941	あの人はまるで歌手のようです。	あの人はまるで歌手のようです。	null		\N	vmod				\N	1
1943	天気予報に　よると、　あしたは　雨が　降るそうです。	天気予報に　よると、　あしたは　雨が　降るそうです。	null		\N	vmod				\N	1
1944	木村さんが　電話に　出ない。　出かけて　いるらしい。	木村さんが　電話に　出ない。　出かけて　いるらしい。	null		\N	vmod				\N	1
1945	山田さんは　来月　東京に　行くらしいです。	山田さんは　来月　東京に　行くらしいです。	null		\N	vmod				\N	1
1946	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。	null		\N	vmod				\N	1
1948	うわさによると、山田さんは来月東京に行くらしいです。	うわさによると、山田さんは来月東京に行くらしいです。	null		\N	vmod				\N	1
1949	歌舞伎は　おもしろいと　思います。	歌舞伎は　おもしろいと　思います。	null		\N	vmod				\N	1
1950	わたしはあした雨が降ると思います。	わたしはあした雨が降ると思います。	null		\N	vmod				\N	1
1951	田中さんは　もう　帰ったと　思います。	田中さんは　もう　帰ったと　思います。	null		\N	vmod				\N	1
1952	あしたも寒いと思いますか。	あしたも寒いと思いますか。	null		\N	vmod				\N	1
1953	ええ、　たぶん。	ええ、　たぶん。	null		\N	vmod				\N	1
1954	彼は　スポーツが　得意だと　思います。	彼は　スポーツが　得意だと　思います。	null		\N	vmod				\N	1
1955	彼は　スポーツが　得意ではないと　思います。	彼は　スポーツが　得意ではないと　思います。	null		\N	vmod				\N	1
1956	彼は　スポーツが　得意だと　思いません。	彼は　スポーツが　得意だと　思いません。	null		\N	vmod				\N	1
1957	わたしのペン	わたしのペン	null		\N	vmod				\N	1
1958	体育館のとなり	体育館のとなり	null		\N	vmod				\N	1
1959	新しいコンピューター	新しいコンピューター	null		\N	vmod				\N	1
1960	小さい犬	小さい犬	null		\N	vmod				\N	1
1961	元気な人	元気な人	null		\N	vmod				\N	1
1962	すてきな絵	すてきな絵	null		\N	vmod				\N	1
1964	あれは　わたしが　通った　学校です。	あれは　わたしが　通った　学校です。	null		\N	vmod				\N	1
1966	すみません、わたしです。	すみません、わたしです。	null		\N	vmod				\N	1
1968	○×△美術館へ行ったことがない人は、手をあげてください。	○×△美術館へ行ったことがない人は、手をあげてください。	null		\N	vmod				\N	1
1969	（手をあげて）はい。	（手をあげて）はい。	null		\N	vmod				\N	1
1970	わたしは、ビートルズが作った曲がすきです。	わたしは、ビートルズが作った曲がすきです。	null		\N	vmod				\N	1
1972	先月　卒業パーティーを　した　レストランは、　ここです。	先月　卒業パーティーを　した　レストランは、　ここです。	null		\N	vmod				\N	1
1973	きのう　書いた　作文を　きょう　提出しました。	きのう　書いた　作文を　きょう　提出しました。	null		\N	vmod				\N	1
1975	きのうわたしが行った店	きのうわたしが行った店	null		\N	vmod				\N	1
1976	お父さんが病院に勤めている山本さん	お父さんが病院に勤めている山本さん	null		\N	vmod				\N	1
1977	コーヒーは飲んで、紅茶は飲まない人	コーヒーは飲んで、紅茶は飲まない人	null		\N	vmod				\N	1
1978	赤いセーターを着た先生	赤いセーターを着た先生	null		\N	vmod				\N	1
1979	こわれたコンピューター	こわれたコンピューター	null		\N	vmod				\N	1
3726	Semalam saya belajar bermain piano buat pertama kalinya. 	きのう　初めて　ピアノを　習いました。	\N		\N	vmod				516	1
1980	本を読んでいる人	本を読んでいる人	null		\N	vmod				\N	1
1981	授業で使う本	授業で使う本	null		\N	vmod				\N	1
1982	わたしが通う学校	わたしが通う学校	null		\N	vmod				\N	1
1983	田中さんが合格した話	田中さんが合格した話	null		\N	vmod				\N	1
1984	人が勉強しているとなりでおしゃべりをする。	人が勉強しているとなりでおしゃべりをする。	null		\N	vmod				\N	1
1985	魚を焼くにおい	魚を焼くにおい	null		\N	vmod				\N	1
1986	頭のよくなるくすり	頭のよくなるくすり	null		\N	vmod				\N	1
1987	［外国語を勉強する{こと／の}］は楽しいです。	［外国語を勉強する{こと／の}］は楽しいです。	null		\N	vmod				\N	1
1988	［学生が優秀な{こと／の}］が田中先生の自慢です。	［学生が優秀な{こと／の}］が田中先生の自慢です。	null		\N	vmod				\N	1
1989	［山田さんが合格した{こと／の}］をきょう知りました。	［山田さんが合格した{こと／の}］をきょう知りました。	null		\N	vmod				\N	1
1991	山田さんが　本を　読んで　いるのが　聞こえます。	山田さんが　本を　読んで　いるのが　聞こえます。	null		\N	vmod				\N	1
1992	木村さんが　来るのを　待ちます。	木村さんが　来るのを　待ちます。	null		\N	vmod				\N	1
1994	きのう行ったのは京都です。	きのう行ったのは京都です。	null		\N	vmod				\N	1
1995	大学に進学することを勧めます。	大学に進学することを勧めます。	null		\N	vmod				\N	1
1996	わたしはアメリカに留学することを考えています。	わたしはアメリカに留学することを考えています。	null		\N	vmod				\N	1
1998	お母さんが　買ってきたのを　食べました。	お母さんが　買ってきたのを　食べました。	null		\N	vmod				\N	1
1999	雨が降ったので試合が中止になりました。	雨が降ったので試合が中止になりました。	null		\N	vmod				\N	1
2000	もう　遅いので、　これで　帰ります。	もう　遅いので、　これで　帰ります。	null		\N	vmod				\N	1
2032	鈴木さんから電話ですよ。	鈴木さんから電話ですよ。	null		\N	vmod				\N	1
2001	この　カメラが　便利なので、　これに　しませんか。	この　カメラが　便利なので、　これに　しませんか。	null		\N	vmod				\N	1
2002	あしたが提出日ですので、気をつけてください。	あしたが提出日ですので、気をつけてください。	null		\N	vmod				\N	1
2003	きのうは　祭日でしたから、　学校は　休みでした。	きのうは　祭日でしたから、　学校は　休みでした。	null		\N	vmod				\N	1
2006	もうだいじょうぶですから、心配しないでください。	もうだいじょうぶですから、心配しないでください。	null		\N	vmod				\N	1
2008	小林さんに聞きました。	小林さんに聞きました。	null		\N	vmod				\N	1
2009	田中さんもあした来ますか。	田中さんもあした来ますか。	null		\N	vmod				\N	1
2010	いいえ、来ません。	いいえ、来ません。	null		\N	vmod				\N	1
2012	病気だからです。	病気だからです。	null		\N	vmod				\N	1
2013	どうして　「蛍の光」が　流れて　いるのですか。	どうして　「蛍の光」が　流れて　いるのですか。	null		\N	vmod				\N	1
2014	図書館が　閉まるからです。	図書館が　閉まるからです。	null		\N	vmod				\N	1
2015	雨が降って試合が中止になりました。	雨が降って試合が中止になりました。	null		\N	vmod				\N	1
2016	かぜで　休みました。	かぜで　休みました。	null		\N	vmod				\N	1
2020	一生懸命勉強したのに試験に落ちました。	一生懸命勉強したのに試験に落ちました。	null		\N	vmod				\N	1
2021	この　メロンは　大きいのに　安いです。	この　メロンは　大きいのに　安いです。	null		\N	vmod				\N	1
2022	毎日　日本語を　勉強して　いるけれども、　なかなか　漢字が　覚えられません。	毎日　日本語を　勉強して　いるけれども、　なかなか　漢字が　覚えられません。	null		\N	vmod				\N	1
2025	さっき　食べたのに　もう　おなかが　すきました。	さっき　食べたのに　もう　おなかが　すきました。	null		\N	vmod				\N	1
2026	雨が降ったけれども予定通り運動会をしました。	雨が降ったけれども予定通り運動会をしました。	null		\N	vmod				\N	1
2024	Hari ini hari Ahad tetapi saya ada kerja. 	きょうは　日曜日なのに　仕事が　あります。	null		\N	vmod				\N	1
2027	もう　夜の　12時だけれども、　もう　少し　勉強しよう。	もう　夜の　12時だけれども、　もう　少し　勉強しよう。	null		\N	vmod				\N	1
2028	小林さんは　かぜを　ひいて　いるけれども、　学校に　来て　いるかも　しれません。	小林さんは　かぜを　ひいて　いるけれども、　学校に　来て　いるかも　しれません。	null		\N	vmod				\N	1
2029	日曜日　だけれども、　学校に　行きますか。	日曜日　だけれども、　学校に　行きますか。	null		\N	vmod				\N	1
2031	わたしが　話して　いるのに、　じゃまを　しないで　ください。	わたしが　話して　いるのに、　じゃまを　しないで　ください。	null		\N	vmod				\N	1
2033	えっ、もう夜の11時なのに。	えっ、もう夜の11時なのに。	null		\N	vmod				\N	1
2034	レポートの　ことですけれども、　来週の　月曜日に　提出して　ください。	レポートの　ことですけれども、　来週の　月曜日に　提出して　ください。	null		\N	vmod				\N	1
2035	日本中を　旅行しましたけれども、　京都が　一番　すきです。	日本中を　旅行しましたけれども、　京都が　一番　すきです。	null		\N	vmod				\N	1
2036	すみませんが、　郵便局は　この　辺ですか。	すみませんが、　郵便局は　この　辺ですか。	null		\N	vmod				\N	1
2038	雨が　降ると、　雪が　解けます。	雨が　降ると、　雪が　解けます。	null		\N	vmod				\N	1
2448	じゃあ、私もタイにしようかなあ。	じゃあ、私もタイにしようかなあ。			\N	vmod				\N	1
2449	すみません。	すみません。			\N	vmod				\N	1
2451	図書館は　夏休み中も　開いて　いますか。	図書館は　夏休み中も　開いて　いますか。			\N	vmod				\N	1
2452	ええ、　開いて　いますよ。	ええ、　開いて　いますよ。			\N	vmod				\N	1
2453	何時から　開いて　いますか。	何時から　開いて　いますか。	 ①何時から開いていますか。②情報を求める(程度)③何時から～か。　　　　　　　　　　　　　　④映画は何時から始まりますか。		\N	vmod				\N	1
2454	9時からです。	9時からです。			\N	vmod				\N	1
2455	自習室は何時まで使えますか。	自習室は何時まで使えますか。	 ①何時まで使えますか。②情報を求める(程度)③何時まで～か。　　　　　　　　　　　　　　④図書館は何時まで開いていますか。		\N	vmod				\N	1
2456	5時まで使えます。	5時まで使えます。			\N	vmod				\N	1
2457	土日も使えますか。	土日も使えますか。			\N	vmod				\N	1
2458	夏休み中は、土日はお休みなんです。	夏休み中は、土日はお休みなんです。			\N	vmod				\N	1
2459	ありがとうございます。	ありがとうございます。			\N	vmod				\N	1
2460	はい、どうぞ。	はい、どうぞ。			\N	vmod				\N	1
2461	ちょっと伺いたいのですが。	ちょっと伺いたいのですが。			\N	vmod				\N	1
2462	何でしょう。	何でしょう。			\N	vmod				\N	1
2463	この　図書館は　初めてなのですが、　本は　一度に　何冊まで　借りられますか。	この　図書館は　初めてなのですが、　本は　一度に　何冊まで　借りられますか。	①一度に何冊　②情報を求める(数字)　③（期間／回数）に(数量)　　　　　　　　　　　　　　④一週間に何日大学に行きますか。		\N	vmod				\N	1
2464	10冊まで　借りられます。	10冊まで　借りられます。			\N	vmod				\N	1
2465	大学院生も　同じですか。	大学院生も　同じですか。			\N	vmod				\N	1
2466	いえ、　大学院生は、　一ヶ月に　20冊まで　借りられます。	いえ、　大学院生は、　一ヶ月に　20冊まで　借りられます。			\N	vmod				\N	1
2467	どれぐらい　借りられますか。	どれぐらい　借りられますか。	 ①どれくらい②情報を求める(数字)③どのぐらい～ですか。　　　　　　　　　　　　　　④どれぐらい使えますか。		\N	vmod				\N	1
2468	2週間です。	2週間です。			\N	vmod				\N	1
2469	分かりました。	分かりました。			\N	vmod				\N	1
2472	レポートの　締め切りは　今月　20日ですよ。	レポートの　締め切りは　今月　20日ですよ。			\N	vmod				\N	1
2474	先生、期末レポートはメールでお送りしてもいいですか。	先生、期末レポートはメールでお送りしてもいいですか。			\N	vmod				\N	1
2475	メールねえ。	メールねえ。			\N	vmod				\N	1
2476	いや、　やっぱり、　メールは　困るなあ。	いや、　やっぱり、　メールは　困るなあ。			\N	vmod				\N	1
2477	いちいちプリントアウトしなければいけないからね。	いちいちプリントアウトしなければいけないからね。			\N	vmod				\N	1
2478	郵便で20日までに送ってください。	郵便で20日までに送ってください。	①送ってください。②何でどのようにするかを言う。③(何をどのように)　　　　　　　　　　　　　　～てくさい。④明日まで電話でお知らせください。 		\N	vmod				\N	1
2479	わかりました。	わかりました。			\N	vmod				\N	1
2480	では、郵便でご自宅にお送りします。	では、郵便でご自宅にお送りします。	 ①お送りします。②何でどのようにするかを言う。　　　　　　　　　　　　　　③(何をどのように)します。④金曜日までメールで連絡します。 		\N	vmod				\N	1
2481	そうして　ください。	そうして　ください。			\N	vmod				\N	1
2483	渡辺さんは、アメリカに留学していましたね。	渡辺さんは、アメリカに留学していましたね。			\N	vmod				\N	1
2484	ええ、　学部の　時、　半年間　ボストンに　住んで　いました。	ええ、　学部の　時、　半年間　ボストンに　住んで　いました。			\N	vmod				\N	1
2507	じゃあ、どうしようかなあ。	じゃあ、どうしようかなあ。			\N	vmod				\N	1
2048	ちりも　つもれば　山と　なる。	ちりも　つもれば　山と　なる。	null		\N	vmod				\N	1
2485	じゃあ、　英語は　話せますか。	じゃあ、　英語は　話せますか。	①英語は話せますか。②能力について尋ねる。③～はできますか。　　　　　　　　　　④フランス語はしゃべれますか。		\N	vmod				\N	1
2486	ええ、　少しなら。	ええ、　少しなら。			\N	vmod				\N	1
2487	実は、　来週の　水曜日、　アメリカから　お客さんが　来るんですが、　空港まで　迎えに　行って　ほしいんです。	実は、　来週の　水曜日、　アメリカから　お客さんが　来るんですが、　空港まで　迎えに　行って　ほしいんです。			\N	vmod				\N	1
2488	ええ、いいですよ。	ええ、いいですよ。			\N	vmod				\N	1
2489	朝の　十時までに　行けますか。	朝の　十時までに　行けますか。			\N	vmod				\N	1
2490	大丈夫です。	大丈夫です。			\N	vmod				\N	1
2491	車が運転できますから。	車が運転できますから。			\N	vmod				\N	1
2492	すみません、授業料を払いたいのですが。	すみません、授業料を払いたいのですが。			\N	vmod				\N	1
2493	授業料でしたら、会計課でお願いします。	授業料でしたら、会計課でお願いします。			\N	vmod				\N	1
2494	会計課はどこでしょうか。	会計課はどこでしょうか。	①どこにありますか。②情報を求める(存在と場所)③(存在/場所)はどこに(いま　　　　　　　　　　　　　すか／ありますか)④山田さんはどこにいますか。		\N	vmod				\N	1
2500	ありがとうございます。	ありがとうございます。			\N	vmod				\N	1
2713	ゆうべから　急に　熱が　出てね。	ゆうべから　急に　熱が　出てね。			\N	vmod				\N	1
2654	わかりました。	わかりました。			\N	vmod				\N	1
2655	あのう、４限目の英作でもお借りしたいんですが。	あのう、４限目の英作でもお借りしたいんですが。			\N	vmod				\N	1
2660	ええ、これでレポートを書いてもらいますから。	ええ、これでレポートを書いてもらいますから。			\N	vmod				\N	1
2661	あのう、　その日に　会社の　面接が　あるんですが…。	あのう、　その日に　会社の　面接が　あるんですが…。			\N	vmod				\N	1
2662	それなら仕方がありませんね。	それなら仕方がありませんね。			\N	vmod				\N	1
2663	先生、レポートは来週中に提出しなければなりませんか。	先生、レポートは来週中に提出しなければなりませんか。	①提出なければいけませんか　②義務を確認する　③Vなければいけませんか。④雨でも行かなければなりませんか。		\N	vmod				\N	1
2664	ええ、もちろんですよ。	ええ、もちろんですよ。			\N	vmod				\N	1
2665	あ、ちょっと、ちょっと。	あ、ちょっと、ちょっと。			\N	vmod				\N	1
2666	え、何ですか。	え、何ですか。			\N	vmod				\N	1
2667	そこに　空き缶を　捨てては　いけませんよ。	そこに　空き缶を　捨てては　いけませんよ。	①捨ててはいけません　②禁止する　③Vてはいけません。④廊下を走ってはいけません。		\N	vmod				\N	1
2668	空き缶は　こっちに　捨てて　ください。	空き缶は　こっちに　捨てて　ください。			\N	vmod				\N	1
2669	わかりました。	わかりました。			\N	vmod				\N	1
2670	ああっ、　それは　そっちに　捨てて　ください。	ああっ、　それは　そっちに　捨てて　ください。			\N	vmod				\N	1
2671	あ、申し訳ありません。	あ、申し訳ありません。			\N	vmod				\N	1
2674	ここは　自転車置き場じゃないんですよ。	ここは　自転車置き場じゃないんですよ。			\N	vmod				\N	1
2675	そうですか。	そうですか。			\N	vmod				\N	1
2676	じゃ、どこにとめればいいでしょうか。	じゃ、どこにとめればいいでしょうか。			\N	vmod				\N	1
2672	Boleh saya tanya sekejap? 	ちょっと　すみません。			\N	vmod				\N	1
2677	図書館の　となりに　自転車置き場が　ありますから、　そこに　とめて　ください。	図書館の　となりに　自転車置き場が　ありますから、　そこに　とめて　ください。	①そこにとめてください。②指示する　③Vてください　④それを読んでおいてください。		\N	vmod				\N	1
2678	わかりました。	わかりました。			\N	vmod				\N	1
2679	これからは必ずそこにとめてくださいね。	これからは必ずそこにとめてくださいね。	①そこにとめてください。②指示する　③Vてください　④それを読んでおいてください。		\N	vmod				\N	1
2680	はい。	はい。			\N	vmod				\N	1
2681	吉田さん、　ちょっと　お願いが　あるんですけど。	吉田さん、　ちょっと　お願いが　あるんですけど。			\N	vmod				\N	1
2682	はい、　何でしょうか。	はい、　何でしょうか。			\N	vmod				\N	1
2683	ゼミのホームページを作りたいんですが、手伝ってもらえますか。	ゼミのホームページを作りたいんですが、手伝ってもらえますか。			\N	vmod				\N	1
2684	はい、わかりました。	はい、わかりました。			\N	vmod				\N	1
2685	吉田さんの研究テーマについても載せたいんですが、いいですか。	吉田さんの研究テーマについても載せたいんですが、いいですか。			\N	vmod				\N	1
2686	はい、かまいません。	はい、かまいません。			\N	vmod				\N	1
2687	あ、あと、顔写真も載せようと思うんですが。	あ、あと、顔写真も載せようと思うんですが。			\N	vmod				\N	1
1933	ここに　おいしそうな　おかしが　あります。	ここに　おいしそうな　おかしが　あります。	null		\N	vmod				\N	1
1934	木村さんは　うれしそうに　走って　きました。	木村さんは　うれしそうに　走って　きました。	null		\N	vmod				\N	1
2040	あした雨が降ったら、試合は中止します。	あした雨が降ったら、試合は中止します。	null		\N	vmod				\N	1
2050	暑かったら、　エアコンを　つけて　ください。	暑かったら、　エアコンを　つけて　ください。	null		\N	vmod				\N	1
2688	すみません、顔写真はちょっと載せないでいただけないでしょうか。	すみません、顔写真はちょっと載せないでいただけないでしょうか。	①載せないでいただけないでしょうか。②非行為を依頼する　③Vないでください／Vないでいただけませんか。④すみませんがここで煙草を吸わないでください。		\N	vmod				\N	1
2689	あ、そうですか。	あ、そうですか。			\N	vmod				\N	1
2690	わかりました。	わかりました。			\N	vmod				\N	1
2691	山田くん、　今日の　練習、　出るでしょう。	山田くん、　今日の　練習、　出るでしょう。			\N	vmod				\N	1
2692	あのう、今日、練習に出なくてもいいですか。	あのう、今日、練習に出なくてもいいですか。			\N	vmod				\N	1
2694	具合でも悪いの。	具合でも悪いの。			\N	vmod				\N	1
2695	いえ、　明日、　試験が　四つも　あるんです。	いえ、　明日、　試験が　四つも　あるんです。			\N	vmod				\N	1
2696	あ、そう。	あ、そう。			\N	vmod				\N	1
2698	試験、がんばってね。	試験、がんばってね。			\N	vmod				\N	1
2699	はい、ありがとうございます。	はい、ありがとうございます。			\N	vmod				\N	1
2700	鈴木さん、こんにちは。	鈴木さん、こんにちは。			\N	vmod				\N	1
2701	あ、野村先輩。	あ、野村先輩。			\N	vmod				\N	1
2702	何をしているの。	何をしているの。			\N	vmod				\N	1
2703	学園祭の準備です。	学園祭の準備です。			\N	vmod				\N	1
2704	ああ、鈴木さんはダンスサークルだったんだ。	ああ、鈴木さんはダンスサークルだったんだ。			\N	vmod				\N	1
2705	そうなんです。	そうなんです。			\N	vmod				\N	1
2706	土曜日に　ステージが　あるんですが、　よかったら、　先輩も　見に　いらっしゃいませんか。	土曜日に　ステージが　あるんですが、　よかったら、　先輩も　見に　いらっしゃいませんか。	①見にいらっしゃいませんか。②招待する　③いらっしゃいませんか④誕生パーティーをするのですがうちにいらっしゃいませんか。		\N	vmod				\N	1
2707	わかった。	わかった。			\N	vmod				\N	1
2708	じゃあ、　友達と　いっしょに　見に　行くよ。	じゃあ、　友達と　いっしょに　見に　行くよ。			\N	vmod				\N	1
2709	よろしくお願いします。	よろしくお願いします。			\N	vmod				\N	1
2710	先輩、どうしました。	先輩、どうしました。			\N	vmod				\N	1
2711	具合が　悪そうですけど。	具合が　悪そうですけど。			\N	vmod				\N	1
2712	うん、　スキーの　合宿で　風邪を　ひいて　しまったみたい。	うん、　スキーの　合宿で　風邪を　ひいて　しまったみたい。			\N	vmod				\N	1
2142	わたしはきょうまでにレポートを終わらせとく。	わたしはきょうまでにレポートを終わらせとく。	null		\N	vmod				\N	1
1913	山田さんは　図書館に　いるかも　しれません。	山田さんは　図書館に　いるかも　しれません。	null		\N	vmod				\N	1
1914	今ごろの　東京は　寒いかも　しれません。	今ごろの　東京は　寒いかも　しれません。	null		\N	vmod				\N	1
1915	山田さんは　猫が　きらいかも　しれません。	山田さんは　猫が　きらいかも　しれません。	null		\N	vmod				\N	1
1917	あれは、　田村さんに　ちがい　ありません。	あれは、　田村さんに　ちがい　ありません。	null		\N	vmod				\N	1
1918	あの人はもしかすると木村さんのお兄さんかもしれません。	あの人はもしかすると木村さんのお兄さんかもしれません。	null		\N	vmod				\N	1
1920	妹が帰ってきません。もしかしたら事故にあったのかもしれません。	妹が帰ってきません。もしかしたら事故にあったのかもしれません。	null		\N	vmod				\N	1
1922	木村さんは　英語教師ですから、　英語が　話せる　はずです。	木村さんは　英語教師ですから、　英語が　話せる　はずです。	null		\N	vmod				\N	1
1923	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。	null		\N	vmod				\N	1
1924	木村さんは　英語教師です。	木村さんは　英語教師です。	null		\N	vmod				\N	1
1925	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。	null		\N	vmod				\N	1
1926	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。	null		\N	vmod				\N	1
3727	Saya berjumpa dengan Encik Hayashi buat pertama kalinya. 	わたしは　初めて　林さんに　会いました。	\N		\N	vmod				516	1
2415	Kalau begitu, saya minta tolong awak.	じゃあ、　お願いします。			\N	vmod				\N	1
2562	Kalau begitu, jumpa lagi. 	じゃあ、　また。			\N	vmod				\N	1
3781	Kalau begitu, saya nak pergi ke hospital dengan menaiki bas. 	じゃあ、　バスで　病院へ　行きます。	\N		\N	vmod				296	1
2145	たいしたもんだ。	たいしたもんだ。	null		\N	vmod				\N	1
1927	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。	null		\N	vmod				\N	1
1929	この　おかしは　甘そうです。	この　おかしは　甘そうです。	null		\N	vmod				\N	1
1930	この　電子辞書は　便利そうです。	この　電子辞書は　便利そうです。	null		\N	vmod				\N	1
2044	成績が　悪いと　進学できません。	成績が　悪いと　進学できません。	null		\N	vmod				\N	1
2418	はい。	はい。			\N	vmod				\N	1
2051	あした　晴れだったら、　ドライブに　行きましょう。	あした　晴れだったら、　ドライブに　行きましょう。	null		\N	vmod				\N	1
2052	ひまだったら、遊びに来ませんか。	ひまだったら、遊びに来ませんか。	null		\N	vmod				\N	1
2053	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。	null		\N	vmod				\N	1
2054	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。	null		\N	vmod				\N	1
2057	大学生ならこのくらいはできるはずです。	大学生ならこのくらいはできるはずです。	null		\N	vmod				\N	1
2058	家に　パソコンが　あります。	家に　パソコンが　あります。	null		\N	vmod				\N	1
2059	パソコンがあるなら、インターネットができますね。	パソコンがあるなら、インターネットができますね。	null		\N	vmod				\N	1
2062	車を　買ったら、　ドライブを　しよう。	車を　買ったら、　ドライブを　しよう。	null		\N	vmod				\N	1
2063	学校に｛行くと／行ったら｝、新入生がたくさんいました。	学校に｛行くと／行ったら｝、新入生がたくさんいました。	null		\N	vmod				\N	1
2066	お酒を｛飲むと／飲んだら｝、気分が悪くなります。	お酒を｛飲むと／飲んだら｝、気分が悪くなります。	null		\N	vmod				\N	1
2067	教科書さえあれば、勉強できる。	教科書さえあれば、勉強できる。	null		\N	vmod				\N	1
2070	嫌でも、　しかたが　ありません。	嫌でも、　しかたが　ありません。	null		\N	vmod				\N	1
2071	たとえ　雨でも、　自転車で　行きます。 	たとえ　雨でも、　自転車で　行きます。 	null		\N	vmod				\N	1
2072	この　時計は、　落としても、　水に　ぬれても　こわれません。	この　時計は、　落としても、　水に　ぬれても　こわれません。	null		\N	vmod				\N	1
2073	だれが　選ばれても、　おどろきません。	だれが　選ばれても、　おどろきません。	null		\N	vmod				\N	1
2074	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。	null		\N	vmod				\N	1
2075	わたしは木村さんにプレゼントをあげます。	わたしは木村さんにプレゼントをあげます。	null		\N	vmod				\N	1
2076	木村さんはわたしにプレゼントをくれます。	木村さんはわたしにプレゼントをくれます。	null		\N	vmod				\N	1
2077	わたしは木村さんにプレゼントをもらいます。	わたしは木村さんにプレゼントをもらいます。	null		\N	vmod				\N	1
2078	妹は　山田さんに　おみやげを　あげました。　	妹は　山田さんに　おみやげを　あげました。　	null		\N	vmod				\N	1
2080	木村さんは山田さんにおみやげをあげました。	木村さんは山田さんにおみやげをあげました。	null		\N	vmod				\N	1
2081	妹は山田さんに本をもらいました。	妹は山田さんに本をもらいました。	null		\N	vmod				\N	1
2620	はい。	はい。			\N	vmod				\N	1
2082	山田さんは木村さんにおみやげをもらいました。	山田さんは木村さんにおみやげをもらいました。	null		\N	vmod				\N	1
2083	わたしは田中先生に花をさしあげました。	わたしは田中先生に花をさしあげました。	null		\N	vmod				\N	1
2084	田中先生は　わたしに　手紙を　くださいました。	田中先生は　わたしに　手紙を　くださいました。	null		\N	vmod				\N	1
2085	わたしは　田中先生に　手紙を　いただきました。	わたしは　田中先生に　手紙を　いただきました。	null		\N	vmod				\N	1
2087	父は　わたしに　本を　くれました。	父は　わたしに　本を　くれました。	null		\N	vmod				\N	1
2091	小林さんはわたしに友だちを紹介してくれました。	小林さんはわたしに友だちを紹介してくれました。	null		\N	vmod				\N	1
2094	田中さんは　わたしに　パソコンの　使い方を　教えて　くれました。	田中さんは　わたしに　パソコンの　使い方を　教えて　くれました。	null		\N	vmod				\N	1
2095	わたしは　生徒を　ほめて　あげました。	わたしは　生徒を　ほめて　あげました。	null		\N	vmod				\N	1
2096	山田さんは息子と遊んでくれました。	山田さんは息子と遊んでくれました。	null		\N	vmod				\N	1
2101	山田さんは　わたしの　ために　詩を　書いて　くれました。	山田さんは　わたしの　ために　詩を　書いて　くれました。	null		\N	vmod				\N	1
2102	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。	null		\N	vmod				\N	1
2105	日本語は　木村さんに　教えて　もらおう。	日本語は　木村さんに　教えて　もらおう。	null		\N	vmod				\N	1
2106	あした来てもらうよ。	あした来てもらうよ。	null		\N	vmod				\N	1
2107	レポートは　みなさんに　出して　もらう　ことに　します。	レポートは　みなさんに　出して　もらう　ことに　します。	null		\N	vmod				\N	1
2108	京都の友だちからおかしを送ってもらいました。　	京都の友だちからおかしを送ってもらいました。　	null		\N	vmod				\N	1
2109	その知らせは田中さんから教えてもらいました。　	その知らせは田中さんから教えてもらいました。　	null		\N	vmod				\N	1
2110	京都からおかしを送ってもらいました。　	京都からおかしを送ってもらいました。　	null		\N	vmod				\N	1
2111	田中先生に　ペンを　貸して　さしあげました。	田中先生に　ペンを　貸して　さしあげました。	null		\N	vmod				\N	1
2112	鈴木先生はわたしに推薦状を書いてくださいました。	鈴木先生はわたしに推薦状を書いてくださいました。	null		\N	vmod				\N	1
2113	わたしは鈴木先生に推薦状を書いていただきました。	わたしは鈴木先生に推薦状を書いていただきました。	null		\N	vmod				\N	1
2114	弟に弁当を作ってやりました。	弟に弁当を作ってやりました。	null		\N	vmod				\N	1
2116	これからも　日本語を　勉強して　いきます。	これからも　日本語を　勉強して　いきます。	null		\N	vmod				\N	1
2117	おみやげを　持って　きました。	おみやげを　持って　きました。	null		\N	vmod				\N	1
2118	高校の友だちがメールを送ってきました。	高校の友だちがメールを送ってきました。	null		\N	vmod				\N	1
2088	Saya menerima buku daripada ayah saya.	わたしは　父に　本を　もらいました。	null		\N	vmod				\N	1
2119	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	1
2121	駅前の通りを歩いてきました。	駅前の通りを歩いてきました。	null		\N	vmod				\N	1
2122	授業まで　時間が　あるので、　朝の　ニュースを　見て　いきます。	授業まで　時間が　あるので、　朝の　ニュースを　見て　いきます。	null		\N	vmod				\N	1
1811	Adik perempuan saya ingin menjadi guru bahasa Jepun. 	妹は　日本語の　先生に　なろうと　思って　います。	null		\N	vmod				\N	1
2124	木村さんは　わたしに　古本を　売って　きました。　	木村さんは　わたしに　古本を　売って　きました。　	null		\N	vmod				\N	1
2125	来週までにレポートを書いておきます。	来週までにレポートを書いておきます。	null		\N	vmod				\N	1
2126	発表の　ために　資料を　コピーして　おきました。	発表の　ために　資料を　コピーして　おきました。	null		\N	vmod				\N	1
2127	友だちが　来るので、　部屋を　きれいに　して　おきます。	友だちが　来るので、　部屋を　きれいに　して　おきます。	null		\N	vmod				\N	1
2128	あした木村さんに聞いてみます。	あした木村さんに聞いてみます。	null		\N	vmod				\N	1
2129	この　ジュースを　少し　飲んで　みて　ください。	この　ジュースを　少し　飲んで　みて　ください。	null		\N	vmod				\N	1
2131	いつか南極に行ってみたいです。	いつか南極に行ってみたいです。	null		\N	vmod				\N	1
2132	わたしは　この前　京都へ　行ったよ。	わたしは　この前　京都へ　行ったよ。	null		\N	vmod				\N	1
2133	わたしは先日京都へ行きました。	わたしは先日京都へ行きました。	null		\N	vmod				\N	1
2134	彼は大学の教授だ。言語学を教えている。	彼は大学の教授だ。言語学を教えている。	null		\N	vmod				\N	1
2135	彼は大学の教授である。言語学を教えている。	彼は大学の教授である。言語学を教えている。	null		\N	vmod				\N	1
2289	熱いか？	熱いか？	null		\N	vmod				\N	1
2136	彼は大学の教授です。言語学を教えています。	彼は大学の教授です。言語学を教えています。	null		\N	vmod				\N	1
2137	わたしは急ぐ。	わたしは急ぐ。	null		\N	vmod				\N	1
2138	日本の冬は寒い。	日本の冬は寒い。	null		\N	vmod				\N	1
2139	わたしは学生だ。	わたしは学生だ。	null		\N	vmod				\N	1
2141	この本はわたしのじゃない。	この本はわたしのじゃない。	null		\N	vmod				\N	1
2143	こうすりゃよかった。	こうすりゃよかった。	null		\N	vmod				\N	1
2144	君、あした来るって言ったよね。	君、あした来るって言ったよね。	null		\N	vmod				\N	1
2155	授業に毎回出席する。これがわたしの今年の目標です。	授業に毎回出席する。これがわたしの今年の目標です。	null		\N	vmod				\N	1
2156	わたしは　英語が　苦手なので　勉強します。	わたしは　英語が　苦手なので　勉強します。	null		\N	vmod				\N	1
2157	星が　たくさん　出て　いますから　あしたは　晴れでしょう。	星が　たくさん　出て　いますから　あしたは　晴れでしょう。	null		\N	vmod				\N	1
2159	以上で　発表は　終わりで　ございますが、　何か　ご質問は　ありますか。	以上で　発表は　終わりで　ございますが、　何か　ご質問は　ありますか。	null		\N	vmod				\N	1
2160	頼む。　金を　貸して　くれ。　お願いします。	頼む。　金を　貸して　くれ。　お願いします。	null		\N	vmod				\N	1
2161	年が　明けました。　新しい　年の　始まりです。　今年は　どんな　年に　なるんだろう。	年が　明けました。　新しい　年の　始まりです。　今年は　どんな　年に　なるんだろう。	null		\N	vmod				\N	1
2162	山田さんはおそばを召し上がりました。	山田さんはおそばを召し上がりました。	null		\N	vmod				\N	1
2163	田中さんは　毎朝、　新聞を　お読みに　なります。	田中さんは　毎朝、　新聞を　お読みに　なります。	null		\N	vmod				\N	1
2164	中田先生がこの本を書かれました。	中田先生がこの本を書かれました。	null		\N	vmod				\N	1
2165	あの　方は　東京駅で　降りられます。	あの　方は　東京駅で　降りられます。	null		\N	vmod				\N	1
2166	わたしはきのう渡辺社長のお宅を拝見しました。	わたしはきのう渡辺社長のお宅を拝見しました。	null		\N	vmod				\N	1
2167	わたしが　かばんを　お持ちします。	わたしが　かばんを　お持ちします。	null		\N	vmod				\N	1
2168	係員がご案内します。	係員がご案内します。	null		\N	vmod				\N	1
2169	あちらは　山田様です。	あちらは　山田様です。	null		\N	vmod				\N	1
2171	ご家族は　どちらに　いらっしゃいますか。	ご家族は　どちらに　いらっしゃいますか。	null		\N	vmod				\N	1
2172	先生は来週もお忙しいようです。	先生は来週もお忙しいようです。	null		\N	vmod				\N	1
2173	先生は来週もご多忙のようです。	先生は来週もご多忙のようです。	null		\N	vmod				\N	1
2719	うん、そうね。	うん、そうね。			\N	vmod				\N	1
2175	先日試合で大阪に参りました。	先日試合で大阪に参りました。	null		\N	vmod				\N	1
2176	他社の社員：渡辺社長はいらっしゃいますか。	他社の社員：渡辺社長はいらっしゃいますか。	null		\N	vmod				\N	1
2177	渡辺の部下：渡辺はただいま外出しております。	渡辺の部下：渡辺はただいま外出しております。	null		\N	vmod				\N	1
2146	読んどいたよ、あの本。	読んどいたよ、あの本。	null		\N	vmod				\N	1
2182	お母さんは　若い　とき　看護士でした。	お母さんは　若い　とき　看護士でした。	null		\N	vmod				\N	1
2183	桜の　花が　きれいな　とき、　リーさんは　日本へ　来ました。	桜の　花が　きれいな　とき、　リーさんは　日本へ　来ました。	null		\N	vmod				\N	1
2184	高校生のとき、日本へ留学したことがあります。	高校生のとき、日本へ留学したことがあります。	null		\N	vmod				\N	1
2185	部屋を出るとき、携帯が鳴りました。	部屋を出るとき、携帯が鳴りました。	null		\N	vmod				\N	1
2186	部屋を出たとき、携帯が鳴りました。	部屋を出たとき、携帯が鳴りました。	null		\N	vmod				\N	1
2188	部屋に　いた　とき、　電話しました。	部屋に　いた　とき、　電話しました。	null		\N	vmod				\N	1
2190	若かった　とき、　よく　泳ぎました。	若かった　とき、　よく　泳ぎました。	null		\N	vmod				\N	1
2191	朝起きて顔を洗います。	朝起きて顔を洗います。	null		\N	vmod				\N	1
2193	学校で　勉強を　したり　運動を　したり　します。	学校で　勉強を　したり　運動を　したり　します。	null		\N	vmod				\N	1
2194	春になると暖かくなります。	春になると暖かくなります。	null		\N	vmod				\N	1
2195	雨が降ったので運動会が中止になりました。	雨が降ったので運動会が中止になりました。	null		\N	vmod				\N	1
2196	雨が降ったから運動会が中止になりました。	雨が降ったから運動会が中止になりました。	null		\N	vmod				\N	1
2198	雨が降ったけれども運動会がありました。	雨が降ったけれども運動会がありました。	null		\N	vmod				\N	1
2199	雨が降れば運動会を中止します。	雨が降れば運動会を中止します。	null		\N	vmod				\N	1
2200	雨が降ったら運動会を中止します。	雨が降ったら運動会を中止します。	null		\N	vmod				\N	1
2201	雨が降るなら運動会を中止します。	雨が降るなら運動会を中止します。	null		\N	vmod				\N	1
2202	雨が降っても運動会をします。	雨が降っても運動会をします。	null		\N	vmod				\N	1
2203	象は　大きくて　鼻が　長いです。	象は　大きくて　鼻が　長いです。	null		\N	vmod				\N	1
2324	私は　２限目から　授業です。	私は　２限目から　授業です。			\N	vmod				\N	1
2204	田中さんは、　知って　いながら　知らない　ふりを　しました。	田中さんは、　知って　いながら　知らない　ふりを　しました。	null		\N	vmod				\N	1
2207	田中さんは　学生です。　佐藤さんも　学生です。	田中さんは　学生です。　佐藤さんも　学生です。	null		\N	vmod				\N	1
2208	佐藤さんだけ来ました。	佐藤さんだけ来ました。	null		\N	vmod				\N	1
2209	肉ばかり食べます。	肉ばかり食べます。	null		\N	vmod				\N	1
2210	山田さんこそ会長にふさわしいです。	山田さんこそ会長にふさわしいです。	null		\N	vmod				\N	1
2211	ジュースが　３本しか　ありません。	ジュースが　３本しか　ありません。	null		\N	vmod				\N	1
2212	机の上に本などがあります。	机の上に本などがあります。	null		\N	vmod				\N	1
2214	佐藤さんや田中さんが来ました。山田さんまで来ました。	佐藤さんや田中さんが来ました。山田さんまで来ました。	null		\N	vmod				\N	1
2215	佐藤さんや田中さんが来ました。山田さんさえ来ました。	佐藤さんや田中さんが来ました。山田さんさえ来ました。	null		\N	vmod				\N	1
2216	10人くらい　来ました。	10人くらい　来ました。	null		\N	vmod				\N	1
2217	ここに　えんぴつが　あります。　赤い　鉛筆は　３本　あります。　青い　えんぴつは　３本　あります。	ここに　えんぴつが　あります。　赤い　鉛筆は　３本　あります。　青い　えんぴつは　３本　あります。	null		\N	vmod				\N	1
2218	Ａ：そこにかさとかばんがありますか。	Ａ：そこにかさとかばんがありますか。	null		\N	vmod				\N	1
2219	Ｂ：かさはありますが、かばんはありません。	Ｂ：かさはありますが、かばんはありません。	null		\N	vmod				\N	1
2221	Ａ：宿題をしてきましたか。	Ａ：宿題をしてきましたか。	null		\N	vmod				\N	1
3759	Bagaimana kalau ambil satu dan cuba makan kuih ini? 	お菓子を　一つ　いかがですか。	\N		\N	vmod				44	1
2738	それはいいね。	それはいいね。			\N	vmod				\N	1
2222	Ｂ：レポートは書きましたが、印刷はしていません。	Ｂ：レポートは書きましたが、印刷はしていません。	null		\N	vmod				\N	1
2223	山田さんはドイツ語はじょうずです。	山田さんはドイツ語はじょうずです。	null		\N	vmod				\N	1
2224	きょうの　会議に　20人は　集まりました。	きょうの　会議に　20人は　集まりました。	null		\N	vmod				\N	1
2225	山田先生はやさしいです。	山田先生はやさしいです。	null		\N	vmod				\N	1
2226	田中さんは社長です。	田中さんは社長です。	null		\N	vmod				\N	1
2228	朝ごはんは　もう　食べました。	朝ごはんは　もう　食べました。	null		\N	vmod				\N	1
2230	暖かく　なりましたし、　桜も　咲きました。	暖かく　なりましたし、　桜も　咲きました。	null		\N	vmod				\N	1
2231	きょうの　コンサートには　100人も　来ました。	きょうの　コンサートには　100人も　来ました。	null		\N	vmod				\N	1
2233	時間も　来ました。　そろそろ　終わりに　しましょう。	時間も　来ました。　そろそろ　終わりに　しましょう。	null		\N	vmod				\N	1
2235	あとは　寝るだけです。	あとは　寝るだけです。	null		\N	vmod				\N	1
2236	言うだけで　何も　しません。	言うだけで　何も　しません。	null		\N	vmod				\N	1
2237	何を聞かれても泣くばかりです。	何を聞かれても泣くばかりです。	null		\N	vmod				\N	1
2238	食べたいだけ食べました。	食べたいだけ食べました。	null		\N	vmod				\N	1
2239	日本語は　勉強しただけ　じょうずに　なります。	日本語は　勉強しただけ　じょうずに　なります。	null		\N	vmod				\N	1
2240	すきなだけ持っていってください。	すきなだけ持っていってください。	null		\N	vmod				\N	1
2241	全力を尽くしてこそいい結果がでます。	全力を尽くしてこそいい結果がでます。	null		\N	vmod				\N	1
2243	コアラはユーカリの葉しか食べません。	コアラはユーカリの葉しか食べません。	null		\N	vmod				\N	1
2244	辞書を　引いたり、　インターネットで　調べるなど　しました。	辞書を　引いたり、　インターネットで　調べるなど　しました。	null		\N	vmod				\N	1
2245	小泉氏などの政治家にインタビューしました。	小泉氏などの政治家にインタビューしました。	null		\N	vmod				\N	1
2246	試験中にとなりの人と話すなどのことはしてはいけません。	試験中にとなりの人と話すなどのことはしてはいけません。	null		\N	vmod				\N	1
2248	つまらない　仕事などに　時間を　使いたくありません。	つまらない　仕事などに　時間を　使いたくありません。	null		\N	vmod				\N	1
2250	それでもだいじょうぶです。	それでもだいじょうぶです。	null		\N	vmod				\N	1
2251	この　アルバイトは、　いそがしい　人でも　できます。	この　アルバイトは、　いそがしい　人でも　できます。	null		\N	vmod				\N	1
2252	そのくらいのことはわたしだってできます。	そのくらいのことはわたしだってできます。	null		\N	vmod				\N	1
2253	日本語を　勉強して、　留学生試験に　合格する　までに　なりました。	日本語を　勉強して、　留学生試験に　合格する　までに　なりました。	null		\N	vmod				\N	1
2254	これさえあればだいじょうぶです。	これさえあればだいじょうぶです。	null		\N	vmod				\N	1
2328	お先に失礼します。	お先に失礼します。	①失礼します　②挨拶をする（退席）③失礼します　④すみません、先約があるのでお先に失礼します。		\N	vmod				\N	1
2434	通訳の仕事。	通訳の仕事。			\N	vmod				\N	1
2329	先生、ここに印鑑をいただきたいのですが。	先生、ここに印鑑をいただきたいのですが。			\N	vmod				\N	1
2330	ああ、科目の変更ですね。	ああ、科目の変更ですね。			\N	vmod				\N	1
2331	分かりました。	分かりました。			\N	vmod				\N	1
2333	ありがとうございます。	ありがとうございます。	①ありがとうございます　②感謝する　③（どうも）ありがとう（ございます）　④手伝ってくれてどうもありがとう。 		\N	vmod				\N	1
2334	それから、　この　本を　お返し　します。	それから、　この　本を　お返し　します。			\N	vmod				\N	1
2335	長い　間　ありがとう　ございました。	長い　間　ありがとう　ございました。	 ①ありがとうございます　②感謝する　③（どうも）ありがとう（ございます）　④手伝ってくれてどうもありがとう。		\N	vmod				\N	1
2332	Ya, silakan. 	はい、　どうぞ。			\N	vmod				\N	1
2336	いえいえ。	いえいえ。			\N	vmod				\N	1
2337	で、役に立ちましたか。	で、役に立ちましたか。			\N	vmod				\N	1
2338	ええ、　とても　おもしろくて、　勉強に　なりました。	ええ、　とても　おもしろくて、　勉強に　なりました。			\N	vmod				\N	1
2227	Saya pergi ke universiti semalam. 	わたしは　きのう　大学へ　行きました。	null		\N	vmod				\N	1
2340	あのう、すみません。	あのう、すみません。	①すみません　②注意を引く　③すみません　④すみません、これいくらですか。		\N	vmod				\N	1
2341	すみません。	すみません。	①すみません　②注意を引く　③すみません　④すみません、これいくらですか。		\N	vmod				\N	1
2342	はい、何でしょう。	はい、何でしょう。			\N	vmod				\N	1
2343	在学証明書をいただきたいのですが。	在学証明書をいただきたいのですが。			\N	vmod				\N	1
2344	在学証明書は、　横の　機械を　使って　下さい。	在学証明書は、　横の　機械を　使って　下さい。			\N	vmod				\N	1
2345	分かりました。	分かりました。			\N	vmod				\N	1
2346	ありがとうございます。	ありがとうございます。			\N	vmod				\N	1
2347	あのう、たびたびすみません。	あのう、たびたびすみません。	①すみません　②注意を引く　③すみません　④すみません、これいくらですか。		\N	vmod				\N	1
2348	はい、何でしょう。	はい、何でしょう。			\N	vmod				\N	1
2349	機械が動かないんです。	機械が動かないんです。			\N	vmod				\N	1
2350	ああ、もう５時を過ぎていますね。	ああ、もう５時を過ぎていますね。			\N	vmod				\N	1
2351	明日、お願いします。	明日、お願いします。			\N	vmod				\N	1
2353	今日は　初めての　授業ですから、　一人ずつ　自己紹介を　お願いします。	今日は　初めての　授業ですから、　一人ずつ　自己紹介を　お願いします。			\N	vmod				\N	1
2354	じゃあ、田村さんから。	じゃあ、田村さんから。			\N	vmod				\N	1
2355	はい。	はい。			\N	vmod				\N	1
2356	初めまして。	初めまして。	①初めまして　②自己紹介する(初対面の挨拶)　③初めまして　④初めまして山田です。		\N	vmod				\N	1
2357	日本語専攻　４年の　田村と　申します。	日本語専攻　４年の　田村と　申します。	①田村と申します　②自己紹介する(名前を名乗る)　③(名前)と申します　④こんにちは。山田と申します。		\N	vmod				\N	1
2358	斉藤先生のゼミで日本語のアクセントについて卒論を書こうと思っています。	斉藤先生のゼミで日本語のアクセントについて卒論を書こうと思っています。			\N	vmod				\N	1
2359	これから一年間、よろしくお願いします。	これから一年間、よろしくお願いします。	①よろしくお願いします　②自己紹介する（挨拶する）　③よろしくお願いします④はじめまして山田です。よろしくお願いします。		\N	vmod				\N	1
2360	こちらこそ、　よろしく。	こちらこそ、　よろしく。			\N	vmod				\N	1
2589	そう。	そう。			\N	vmod				\N	1
2361	で、　田村さん、　卒論の　準備は　いかがですか。	で、　田村さん、　卒論の　準備は　いかがですか。			\N	vmod				\N	1
2362	はい、いちおう始めています。	はい、いちおう始めています。			\N	vmod				\N	1
2363	就職活動のほうは。	就職活動のほうは。			\N	vmod				\N	1
2364	はい、就職活動もしています。	はい、就職活動もしています。			\N	vmod				\N	1
2365	それは、　大変ですね。	それは、　大変ですね。			\N	vmod				\N	1
2366	がんばってください。	がんばってください。			\N	vmod				\N	1
2370	先生、レポートを提出しに来ました。	先生、レポートを提出しに来ました。			\N	vmod				\N	1
2371	えっ、レポートですか。	えっ、レポートですか。			\N	vmod				\N	1
2372	たしか　締め切りは　先週の　金曜日　でしたよね。	たしか　締め切りは　先週の　金曜日　でしたよね。			\N	vmod				\N	1
2373	遅れてすみません。	遅れてすみません。	①すみません　②あやまる　③（どうも）すみません　④昨日はどうもすみませんでした。 		\N	vmod				\N	1
2374	風邪で　寝込んで　しまいまして･･･。	風邪で　寝込んで　しまいまして･･･。			\N	vmod				\N	1
2375	そうですか、でも、そういう場合も電話かメールであらかじめ連絡してくださいね。	そうですか、でも、そういう場合も電話かメールであらかじめ連絡してくださいね。			\N	vmod				\N	1
2376	わかりました。	わかりました。			\N	vmod				\N	1
2377	これから気をつけます。	これから気をつけます。			\N	vmod				\N	1
2378	で、風邪のほうは。	で、風邪のほうは。			\N	vmod				\N	1
2379	もう、　すっかり　良く　なりました。 	もう、　すっかり　良く　なりました。 			\N	vmod				\N	1
2380	失礼します。	失礼します。			\N	vmod				\N	1
2382	先生、これ、軽井沢のお土産なんです。	先生、これ、軽井沢のお土産なんです。			\N	vmod				\N	1
2384	へえ、つまらないものって、何。	へえ、つまらないものって、何。			\N	vmod				\N	1
2385	りんごワインです。 	りんごワインです。 			\N	vmod				\N	1
2386	へえ、それはめずらしいね。	へえ、それはめずらしいね。			\N	vmod				\N	1
2388	ええ、　どうぞ、　どうぞ。	ええ、　どうぞ、　どうぞ。			\N	vmod				\N	1
2389	じゃあ、遠慮なくいただきますね。	じゃあ、遠慮なくいただきますね。			\N	vmod				\N	1
2390	うーん、これは楽しみだな。	うーん、これは楽しみだな。			\N	vmod				\N	1
2392	いいえ。	いいえ。			\N	vmod				\N	1
2393	田中先生、こんばんは。	田中先生、こんばんは。			\N	vmod				\N	1
2369	Silakan. 	どうぞ。			\N	vmod				\N	1
2147	これ、プリント、先週の。	これ、プリント、先週の。	null		\N	vmod				\N	1
2394	ああ、　田村さん、　こんばんは。	ああ、　田村さん、　こんばんは。			\N	vmod				\N	1
2395	先生、今まで、会議ですか。	先生、今まで、会議ですか。			\N	vmod				\N	1
2397	でも、　田村さんも　ずいぶん　遅いですね。	でも、　田村さんも　ずいぶん　遅いですね。			\N	vmod				\N	1
2398	ええ、図書館で卒論の資料を探していました。 	ええ、図書館で卒論の資料を探していました。 			\N	vmod				\N	1
2399	そう、偉いですね。	そう、偉いですね。			\N	vmod				\N	1
2400	じゃあ、気をつけて帰ってくださいね。	じゃあ、気をつけて帰ってくださいね。			\N	vmod				\N	1
2401	はい、　では　失礼します。	はい、　では　失礼します。	①失礼します　②さよならを言う（目下から目上へ）　③さようなら　④部長、お先に失礼します。		\N	vmod				\N	1
2402	さようなら。	さようなら。	①さようなら　②さよならを言う　③さようなら　④　山田君、さようなら。また明日ね。		\N	vmod				\N	1
2403	すみません。	すみません。			\N	vmod				\N	1
2404	いらっしゃいませ。	いらっしゃいませ。			\N	vmod				\N	1
2405	本を注文したいんですが。	本を注文したいんですが。			\N	vmod				\N	1
2406	はい、何の本でしょう。	はい、何の本でしょう。			\N	vmod				\N	1
2407	『日本文法辞典』です。	『日本文法辞典』です。			\N	vmod				\N	1
2408	『日本文法辞典』ですね。	『日本文法辞典』ですね。			\N	vmod				\N	1
2410	ちょっとお待ちください。	ちょっとお待ちください。			\N	vmod				\N	1
2411	6,500円です。	6,500円です。			\N	vmod				\N	1
2413	いえ、　消費税を　入れると、　6,825円に　なります。	いえ、　消費税を　入れると、　6,825円に　なります。			\N	vmod				\N	1
2414	わかりました。	わかりました。			\N	vmod				\N	1
2417	では、　こちらに　お名前と　お電話番号を　お願いします。	では、　こちらに　お名前と　お電話番号を　お願いします。			\N	vmod				\N	1
2419	渡辺先輩、　授業登録の　ことで、　ちょっと　質問しても　いいですか。	渡辺先輩、　授業登録の　ことで、　ちょっと　質問しても　いいですか。			\N	vmod				\N	1
2420	いいよ、何。	いいよ、何。			\N	vmod				\N	1
2421	英語専攻の　小林先生の　授業を　取った　ことが　ありますか。	英語専攻の　小林先生の　授業を　取った　ことが　ありますか。	①小林先生の授業を取ったことがありますか。②情報を求める（経験）③（動詞のタ形）＋ことがありますか　④富士山に登ったことがありますか		\N	vmod				\N	1
2422	あるけど。	あるけど。			\N	vmod				\N	1
2423	私、　英語に　あまり　自信が　ないんですけど、　大丈夫でしょうか。	私、　英語に　あまり　自信が　ないんですけど、　大丈夫でしょうか。			\N	vmod				\N	1
2424	そうだねえ、とても厳しい先生だからねえ。	そうだねえ、とても厳しい先生だからねえ。			\N	vmod				\N	1
2425	他の先生の授業を考えたほうがいいかもしれないよ。	他の先生の授業を考えたほうがいいかもしれないよ。			\N	vmod				\N	1
2426	暑いですね。	暑いですね。			\N	vmod				\N	1
2427	早く夏休みが来るといいな。	早く夏休みが来るといいな。			\N	vmod				\N	1
2428	そうね、　山田君、　この　夏の　予定は。	そうね、　山田君、　この　夏の　予定は。			\N	vmod				\N	1
2430	いいわねえ。	いいわねえ。			\N	vmod				\N	1
2433	何のバイトですか。	何のバイトですか。			\N	vmod				\N	1
2435	すごいなあ。	すごいなあ。			\N	vmod				\N	1
2436	鈴木さん、何を見ているの。	鈴木さん、何を見ているの。			\N	vmod				\N	1
2437	旅行の　パンフレットです。	旅行の　パンフレットです。			\N	vmod				\N	1
2438	夏休みにどこかへ旅行したいと思って。	夏休みにどこかへ旅行したいと思って。			\N	vmod				\N	1
2439	そういえば、　先輩は　たしか　去年、　タイへ　行かれましたよね。	そういえば、　先輩は　たしか　去年、　タイへ　行かれましたよね。			\N	vmod				\N	1
2441	お金どのぐらいかかりましたか。	お金どのぐらいかかりましたか。	 ①どのぐらいかかりましたか。②情報を求める(程度)　　　　　　　　　　　　　③(～は)どのぐらい(程度)④時間はどのぐらいかかりましたか。		\N	vmod				\N	1
2442	けっこう　安かったよ。	けっこう　安かったよ。			\N	vmod				\N	1
2443	全部で　10万ぐらいかな。	全部で　10万ぐらいかな。			\N	vmod				\N	1
2444	何日間行っていたんですか。	何日間行っていたんですか。	①何日間行っていたんですか。②情報を求める(程度)　　　　　　　　　　　　　③何(期間)～か。④アメリカは何年間住んでいましたか。 		\N	vmod				\N	1
2396	Ya, begitu. 	そうなんです。			\N	vmod				\N	1
2148	ちょっと　待って。	ちょっと　待って。	null		\N	vmod				\N	1
2446	3週間ぐらい。	3週間ぐらい。			\N	vmod				\N	1
2447	3週間で　10万ですか…。	3週間で　10万ですか…。			\N	vmod				\N	1
2501	先輩、小沢先生の｢国際法｣はどうですか。	先輩、小沢先生の｢国際法｣はどうですか。	①～はどうですか。②情報を求める(属性)③(対象)はどうですか。　　　　　　　　　　　　　　④このレストランはどうですいか。		\N	vmod				\N	1
2502	小沢先生の　授業は　どれも　いいと　思うよ。	小沢先生の　授業は　どれも　いいと　思うよ。			\N	vmod				\N	1
2503	じゃあ、村上先生の｢経済史｣は。	じゃあ、村上先生の｢経済史｣は。	①～は。②情報を求める(属性)③(対象)は(どうですか)。　　　　　　　　　　　　　④あのデパートは(どうですか)。		\N	vmod				\N	1
2504	あれは　大変よ。	あれは　大変よ。			\N	vmod				\N	1
2505	友達も　よく　言うんですけど、　何が　大変なんですか。	友達も　よく　言うんですけど、　何が　大変なんですか。	①何が～ですか。②情報を求める(属性)③何が(どう)ですか。　　　　　　　　　　　　　　④何が難しいですか。		\N	vmod				\N	1
2506	出席が厳しくて、宿題が多くて。それに成績は辛くて。	出席が厳しくて、宿題が多くて。それに成績は辛くて。			\N	vmod				\N	1
2508	でも、かなり役に立つと思うけど･･･。	でも、かなり役に立つと思うけど･･･。			\N	vmod				\N	1
2509	では、この間のレポートを返却します。	では、この間のレポートを返却します。			\N	vmod				\N	1
2510	山田君。	山田君。			\N	vmod				\N	1
2511	はい。	はい。			\N	vmod				\N	1
2512	なかなか　よく　書けて　いると　思いました。	なかなか　よく　書けて　いると　思いました。	①よく書けていると思います。②意見を言う。③(意見)と思う。                           ④とてもいい作品だと思います。		\N	vmod				\N	1
2513	あの、結論はこれでいいでしょうか。	あの、結論はこれでいいでしょうか。			\N	vmod				\N	1
2514	そうですね、　もう少し　自分の　意見を　書いた　ほうが　いいと　思います。	そうですね、　もう少し　自分の　意見を　書いた　ほうが　いいと　思います。	①書いたほうがいいと思います。②意見を言う。③～ほうが(意見)と思う。　　　　　　　　　　　　　　④こっちのほうがいいと思います。		\N	vmod				\N	1
2515	そうですか。	そうですか。			\N	vmod				\N	1
2516	それから、　漢字の　間違いに　気を　つけて　くださいね。	それから、　漢字の　間違いに　気を　つけて　くださいね。			\N	vmod				\N	1
2517	あ、　本当だ。	あ、　本当だ。			\N	vmod				\N	1
2518	今度から気をつけます。	今度から気をつけます。			\N	vmod				\N	1
2519	鈴木さん、黒澤の映画って好き。	鈴木さん、黒澤の映画って好き。			\N	vmod				\N	1
2720	ありがとう。	ありがとう。			\N	vmod				\N	1
2521	どれが　一番　好き。	どれが　一番　好き。			\N	vmod				\N	1
2522	そうですねえ、　「赤ひげ」とか　「夢」が　大好きです。	そうですねえ、　「赤ひげ」とか　「夢」が　大好きです。	①文中の形：大好きです。②機能：嗜好について述べる（もの）③文型：(～が)大好きです。　　　　　　　　　　　　　④例文：旅行が大好きです。		\N	vmod				\N	1
2523	へえ、詳しいんだねえ。	へえ、詳しいんだねえ。			\N	vmod				\N	1
2524	「羅生門」はどう。	「羅生門」はどう。			\N	vmod				\N	1
2525	「羅生門」はちょっと…。	「羅生門」はちょっと…。			\N	vmod				\N	1
2526	あまり　好きじゃないです。	あまり　好きじゃないです。	①文中の形：好きじゃないです。②機能：嗜好について述べる（もの）　　　　　　　　　　　　　③文型：(～が/は)好きじゃないです。④例文：焼肉は好きじゃないです。		\N	vmod				\N	1
2527	来週、　黒澤の　映画祭が　あるんだけど、　一緒に　行く。	来週、　黒澤の　映画祭が　あるんだけど、　一緒に　行く。			\N	vmod				\N	1
2528	えっ、いいんですか。	えっ、いいんですか。			\N	vmod				\N	1
2529	うれしい。	うれしい。			\N	vmod				\N	1
2530	鈴木さんは、　よく　料理するの？	鈴木さんは、　よく　料理するの？			\N	vmod				\N	1
2531	ええ、食べるのが好きなので。	ええ、食べるのが好きなので。	①すきなので。②嗜好について述べる（行動）③(行動)がすきです。　　　　　　　　　　　　　④走るのがすきなので。		\N	vmod				\N	1
2532	得意な料理は何？	得意な料理は何？			\N	vmod				\N	1
2533	スパゲッティとかパエーリアとか。	スパゲッティとかパエーリアとか。			\N	vmod				\N	1
2534	へえ、鈴木さんって、グルメなんだ。	へえ、鈴木さんって、グルメなんだ。			\N	vmod				\N	1
2535	じゃあ、食事は毎日、自分で？	じゃあ、食事は毎日、自分で？			\N	vmod				\N	1
2536	どうも　片付けるのが　苦手なので、　毎日は　作りません。	どうも　片付けるのが　苦手なので、　毎日は　作りません。			\N	vmod				\N	1
2537	たしかに。	たしかに。			\N	vmod				\N	1
2538	食事の後片付けって、面倒だよね。	食事の後片付けって、面倒だよね。			\N	vmod				\N	1
2539	すみません、　拡大コピーを　したいのですが。	すみません、　拡大コピーを　したいのですが。			\N	vmod				\N	1
2520	Ya, saya suka. 	ええ、　好きです。	①文中の形：すきです。②機能：嗜好について述べる（もの）③文型：(～が)すきです。　　　　　　　　　　　　　　④例文：果物がすきです。		\N	vmod				\N	1
2540	じゃあ、　まず、　この　ボタンを　押して　ください。	じゃあ、　まず、　この　ボタンを　押して　ください。	①まず　②手順と順序について述べる　③まず、〜。　④困ったことがあったら、まず、留学生課に相談してください。		\N	vmod				\N	1
2541	はい。	はい。			\N	vmod				\N	1
2542	次に、倍率を選んで。	次に、倍率を選んで。	①次に　②手順と順序について述べる　③次に、〜。　④今日は休みだから、まず洗濯をして、次に部屋の掃除をして、それから買い物に行きます。		\N	vmod				\N	1
2543	はい。	はい。			\N	vmod				\N	1
2544	最後に　この　ボタンで　用紙を　選んで、　スタートボタンを　押します。	最後に　この　ボタンで　用紙を　選んで、　スタートボタンを　押します。	①最後に　②手順と順序について述べる　③最後に、〜。　④今回の旅行では、まず京都に行って、次に奈良に行って、最後に大阪に行きました。		\N	vmod				\N	1
2545	わかりました。	わかりました。			\N	vmod				\N	1
2546	ところで、　コピーカードは　持って　いますか。	ところで、　コピーカードは　持って　いますか。			\N	vmod				\N	1
2547	あっ、　先生から　預かるのを　忘れた。	あっ、　先生から　預かるのを　忘れた。			\N	vmod				\N	1
2549	もしもし、　田村ですけど。	もしもし、　田村ですけど。			\N	vmod				\N	1
2550	ああ、田村さん。	ああ、田村さん。			\N	vmod				\N	1
2551	先輩、　最近　学校で　お会いしませんが、　どうか　しましたか。	先輩、　最近　学校で　お会いしませんが、　どうか　しましたか。	①最近学校でお会いしませんが、どうかしましたか。　②どうしているかを尋ねる　③どう　④最近どうですか。		\N	vmod				\N	1
2552	いや、　ちょっと　足を　けがして　しまって。	いや、　ちょっと　足を　けがして　しまって。			\N	vmod				\N	1
2553	えっ、そうだったんですか。	えっ、そうだったんですか。			\N	vmod				\N	1
2554	大丈夫ですか。	大丈夫ですか。			\N	vmod				\N	1
2555	ええ、　もう　大丈夫です。	ええ、　もう　大丈夫です。			\N	vmod				\N	1
2556	それで、論文のほうはどうですか。	それで、論文のほうはどうですか。	①どうですか　②どうしているかを尋ねる　③どうですか。　④最近、調子はどうですか。		\N	vmod				\N	1
2557	何とかがんばっていますよ。	何とかがんばっていますよ。			\N	vmod				\N	1
2558	あまり、無理はなさらないでくださいね。	あまり、無理はなさらないでくださいね。			\N	vmod				\N	1
2559	はい。	はい。			\N	vmod				\N	1
2561	どうかお大事に。	どうかお大事に。			\N	vmod				\N	1
2563	明日のボート大会のことですけど。	明日のボート大会のことですけど。			\N	vmod				\N	1
2565	もし、雨が降ったら、大会は中止ですか。	もし、雨が降ったら、大会は中止ですか。			\N	vmod				\N	1
2566	いいえ。	いいえ。			\N	vmod				\N	1
2721	もしもし、　謝恩会の　会場を　予約したいんですけど。	もしもし、　謝恩会の　会場を　予約したいんですけど。			\N	vmod				\N	1
2567	小雨程度なら、中止にはならないと思いますが。	小雨程度なら、中止にはならないと思いますが。	①小雨程度なら、中止にはならない　②ある条件での行動を言う　③条件表現　〜なら、〜。　④風邪をひいたのなら、早く病院に行ったほうがいいですよ。		\N	vmod				\N	1
2568	じゃあ、大雨の場合は、授業がありますか。	じゃあ、大雨の場合は、授業がありますか。			\N	vmod				\N	1
2569	いいえ。	いいえ。			\N	vmod				\N	1
2570	授業はないと思います。	授業はないと思います。			\N	vmod				\N	1
2571	ああ、　明日、　雨だと　いいなあ。	ああ、　明日、　雨だと　いいなあ。			\N	vmod				\N	1
2572	どうして。	どうして。			\N	vmod				\N	1
2573	明日　雨だったら、　友達と　映画を　見に　いく　約束を　して　いるんです。	明日　雨だったら、　友達と　映画を　見に　いく　約束を　して　いるんです。	①明日雨だったら、友達と映画を見にいく　②ある条件での行動を言う　③条件表現　〜たら、〜　④値段が高かったら、買いません。		\N	vmod				\N	1
2575	来週の　飲み会、　新宿と、　吉祥寺と、　池袋の　中で、　どこが　一番　いいでしょうか。	来週の　飲み会、　新宿と、　吉祥寺と、　池袋の　中で、　どこが　一番　いいでしょうか。			\N	vmod				\N	1
2576	池袋は遠いから、やめませんか。	池袋は遠いから、やめませんか。			\N	vmod				\N	1
2577	そうですね。	そうですね。			\N	vmod				\N	1
2578	じゃあ、　新宿と　吉祥寺と、　どちらが　いいでしょうか。	じゃあ、　新宿と　吉祥寺と、　どちらが　いいでしょうか。			\N	vmod				\N	1
2579	吉祥寺より　新宿の　ほうが　安い　店が　多いですから、　新宿に　しませんか。	吉祥寺より　新宿の　ほうが　安い　店が　多いですから、　新宿に　しませんか。	①吉祥寺より新宿のほうが安い店が多い　②比べて述べる　③比較する表現　ＡよりＢのほうが〜。　④野球よりサッカーのほうが好きです。		\N	vmod				\N	1
2580	たしかにそうですね。	たしかにそうですね。			\N	vmod				\N	1
2581	じゃ、新宿にしましょう。	じゃ、新宿にしましょう。			\N	vmod				\N	1
2582	田村さん。	田村さん。			\N	vmod				\N	1
2584	就職活動は進んでいますか。	就職活動は進んでいますか。			\N	vmod				\N	1
2585	それが、なかなか思い通りに進まなくて。	それが、なかなか思い通りに進まなくて。			\N	vmod				\N	1
2586	そう。	そう。			\N	vmod				\N	1
2587	それで、どのような仕事を考えているんですか。	それで、どのような仕事を考えているんですか。			\N	vmod				\N	1
2588	日本語を　教える　仕事です。	日本語を　教える　仕事です。			\N	vmod				\N	1
2590	それじゃ、　外国で　教えると　いうのは　どうですか。	それじゃ、　外国で　教えると　いうのは　どうですか。	①外国で教えるというのはどうですか　②提案する　③〜はどうですか　④飛行機で行くのは高いから、寝台車で行くというのはどうですか。		\N	vmod				\N	1
2591	ちょうど、　韓国の　大学で　日本語教師を　募集して　いるんですよ。	ちょうど、　韓国の　大学で　日本語教師を　募集して　いるんですよ。			\N	vmod				\N	1
2592	え、そうなんですか。	え、そうなんですか。			\N	vmod				\N	1
2593	興味があれば、推薦書を書いてあげますよ。	興味があれば、推薦書を書いてあげますよ。			\N	vmod				\N	1
2594	わあ、うれしい。	わあ、うれしい。			\N	vmod				\N	1
2595	じゃあ、これから真剣に考えてみます。	じゃあ、これから真剣に考えてみます。			\N	vmod				\N	1
2596	はい、　では　今日の　授業は　ここまで。 	はい、　では　今日の　授業は　ここまで。 			\N	vmod				\N	1
2597	先生。	先生。			\N	vmod				\N	1
2598	来週の授業、休ませていただきたいのですが。	来週の授業、休ませていただきたいのですが。			\N	vmod				\N	1
2600	じつは、就職の最終面接があるんです。	じつは、就職の最終面接があるんです。	①就職の面接があるんです　②理由を述べる　③関連づけ　〜ん（の）です　④昨日は遅刻してしまいました。電車が遅れたんです。		\N	vmod				\N	1
2601	そうですか。	そうですか。			\N	vmod				\N	1
2603	はい、　会社が　遠くに　あるので、　無理だと　思います。	はい、　会社が　遠くに　あるので、　無理だと　思います。	①会社が遠くにあるので　②理由を述べる　③理由を表す表現　〜ので　④ちょっと用事があるので、お先に失礼します。		\N	vmod				\N	1
2605	じゃ、面接、がんばってくださいね。	じゃ、面接、がんばってくださいね。			\N	vmod				\N	1
2606	がんばります。	がんばります。			\N	vmod				\N	1
2607	先生、お忙しいところを申し訳ありません。	先生、お忙しいところを申し訳ありません。			\N	vmod				\N	1
2608	実は　来年、　アメリカの　大学に　留学しようと　思って　いるのですが。	実は　来年、　アメリカの　大学に　留学しようと　思って　いるのですが。			\N	vmod				\N	1
2610	それは、いいですね。	それは、いいですね。			\N	vmod				\N	1
2611	それで、先生に推薦書を書いていただきたいのですが、よろしいでしょうか。	それで、先生に推薦書を書いていただきたいのですが、よろしいでしょうか。	①推薦書を書いていただきたいのですが、よろしいでしょうか　②依頼する　③〜ていただきたいのですが　④わからないところがあるので、教えていただきたいのですが、よろしいでしょうか。		\N	vmod				\N	1
2612	いいですよ。	いいですよ。			\N	vmod				\N	1
2613	で、　締め切りは　いつまでですか。	で、　締め切りは　いつまでですか。			\N	vmod				\N	1
2614	それが、かなり急いでいるんです。	それが、かなり急いでいるんです。			\N	vmod				\N	1
2615	来週の　金曜日までに　お願い　できないでしょうか。	来週の　金曜日までに　お願い　できないでしょうか。	①お願いできないでしょうか　②依頼する　③お願いできないでしょうか　④メールではなく、ファックスでお願いできないでしょうか。		\N	vmod				\N	1
2616	それなら、だいじょうぶですよ。	それなら、だいじょうぶですよ。			\N	vmod				\N	1
2617	ありがとうございます。	ありがとうございます。			\N	vmod				\N	1
2618	これで、ほっとしました。	これで、ほっとしました。			\N	vmod				\N	1
2619	学園祭があるんですか。	学園祭があるんですか。			\N	vmod				\N	1
2621	今月の18日からです。	今月の18日からです。			\N	vmod				\N	1
2622	どんな催し物があるんですか。	どんな催し物があるんですか。			\N	vmod				\N	1
2657	皆さん、　来週の　シンポジウム、　よろしく　お願いします。	皆さん、　来週の　シンポジウム、　よろしく　お願いします。			\N	vmod				\N	1
2659	先生、そのシンポジウムは必ず出なければいけませんか。	先生、そのシンポジウムは必ず出なければいけませんか。	①出なければいけませんか　②義務を確認する　③Vなければいけませんか。④雨でも行かなければなりませんか。		\N	vmod				\N	1
2623	ここは　外語大ですから、　いろんな　国の　音楽を　演奏したり、　お芝居や　ダンスを　やったり、　料理店を　出したり　します。	ここは　外語大ですから、　いろんな　国の　音楽を　演奏したり、　お芝居や　ダンスを　やったり、　料理店を　出したり　します。	①いろいろな国の音楽を演奏したり、お芝居やダンスをやったり、料理店を出したりします　②例をあげて述べる　③〜たり、〜たりします。　④日曜日は、買い物に行ったり、映画を見たりします。		\N	vmod				\N	1
2624	へえ。	へえ。			\N	vmod				\N	1
2625	で、　どんな　料理が　食べられるんですか。	で、　どんな　料理が　食べられるんですか。			\N	vmod				\N	1
2626	そう、　タイや　韓国や　イタリアや　いろいろな　国の　食べ物が　あります。	そう、　タイや　韓国や　イタリアや　いろいろな　国の　食べ物が　あります。	①タイや韓国やイタリアや、いろいろな国の食べ物　②例をあげて述べる　③〜や〜　④日本語の授業は、会話や聴解、読解の授業などがあります。		\N	vmod				\N	1
2628	それは　楽しそうですね。	それは　楽しそうですね。			\N	vmod				\N	1
2629	じゃ、子どもを連れて来ます。	じゃ、子どもを連れて来ます。			\N	vmod				\N	1
2599	Mengapa? 	なぜですか。			\N	vmod				\N	1
2630	ぜひいらしてください。	ぜひいらしてください。			\N	vmod				\N	1
2631	お待ちしています。	お待ちしています。			\N	vmod				\N	1
2632	いらっしゃいませ。	いらっしゃいませ。			\N	vmod				\N	1
2633	ご注文は。	ご注文は。			\N	vmod				\N	1
2634	天ぷらうどん、お願いします。	天ぷらうどん、お願いします。			\N	vmod				\N	1
2635	ごめんなさい。	ごめんなさい。			\N	vmod				\N	1
2636	天ぷらがもう終わってしまったんですよ。	天ぷらがもう終わってしまったんですよ。			\N	vmod				\N	1
2638	うどんは他に何がありますか。	うどんは他に何がありますか。			\N	vmod				\N	1
2639	たぬきかきつねならありますけど。	たぬきかきつねならありますけど。			\N	vmod				\N	1
2640	たぬきかきつねね。	たぬきかきつねね。			\N	vmod				\N	1
2641	じゃあ、きつねうどんでいいです。	じゃあ、きつねうどんでいいです。	①きつねうどんでいいです　②妥協する　③〜でいいです　④本当はこの色の靴がほしいんですけど、サイズがないなら別の色でいいです。		\N	vmod				\N	1
2642	はい、きつねですね。	はい、きつねですね。			\N	vmod				\N	1
2643	少々お待ちください。	少々お待ちください。			\N	vmod				\N	1
2645	この電子辞書、いいですねえ。	この電子辞書、いいですねえ。			\N	vmod				\N	1
2646	そうだろ。	そうだろ。			\N	vmod				\N	1
2647	最近、買ったんだ。	最近、買ったんだ。			\N	vmod				\N	1
2648	次の　講読の　授業で　お借りしても　いいですか。	次の　講読の　授業で　お借りしても　いいですか。	①お借りしてもいいですか　②許可を求める　③〜てもいいですか。　④写真を撮ってもいいですか。		\N	vmod				\N	1
2649	うーん…。	うーん…。			\N	vmod				\N	1
2650	まあ、いいよ。	まあ、いいよ。			\N	vmod				\N	1
2652	いいけど。	いいけど。			\N	vmod				\N	1
2653	僕、　３限目に　使うから、　それまでには　返して　くれよ。	僕、　３限目に　使うから、　それまでには　返して　くれよ。			\N	vmod				\N	1
2714	それなら、　早く　病院に　行った　ほうが　いいですよ。	それなら、　早く　病院に　行った　ほうが　いいですよ。	①行ったほうがいいですよ　②助言する　③Vたほうがいいです　④風邪のときは病院に行ったほうがいいですよ。		\N	vmod				\N	1
2715	インフルエンザかもしれませんから。	インフルエンザかもしれませんから。			\N	vmod				\N	1
2717	でも、　もうすぐ　卒論の　締め切りなの。	でも、　もうすぐ　卒論の　締め切りなの。			\N	vmod				\N	1
2748	はい、先生、４年間、ありがとうございました。	はい、先生、４年間、ありがとうございました。			\N	vmod				\N	1
2749	薬は朝だけ飲みます。	薬は朝だけ飲みます。	\N		\N	vmod				205	1
2718	でも、　無理は　絶対　しない　ほうが　いいです。	でも、　無理は　絶対　しない　ほうが　いいです。	①しないほうがいいです　②助言する　③Vないほうがいいです　④風邪のときはお風呂に入らない方がいいです。		\N	vmod				\N	1
2722	3月25日の6時からです。	3月25日の6時からです。			\N	vmod				\N	1
2723	30名で、　一人　一万円ぐらいで　お願いできますか。	30名で、　一人　一万円ぐらいで　お願いできますか。			\N	vmod				\N	1
2724	はい、田村と申します。	はい、田村と申します。			\N	vmod				\N	1
2725	それから、　ホテルの　パンフレットを　送って　ほしいんですが。	それから、　ホテルの　パンフレットを　送って　ほしいんですが。	①送ってほしいんですが　②要求する　③Vてほしい　④すみません、資料を見せてほしいのですが。		\N	vmod				\N	1
2726	はい、住所は、東京都府中市朝日町3の11の1です。	はい、住所は、東京都府中市朝日町3の11の1です。			\N	vmod				\N	1
2727	はい、　では、　よろしく　お願いします。	はい、　では、　よろしく　お願いします。			\N	vmod				\N	1
2728	先輩、もうすぐ卒業ですね。 	先輩、もうすぐ卒業ですね。 			\N	vmod				\N	1
2729	就職は、もう決まりましたか。 	就職は、もう決まりましたか。 			\N	vmod				\N	1
2730	ああ、商社に決まったんだ。	ああ、商社に決まったんだ。			\N	vmod				\N	1
2731	おめでとうございます。	おめでとうございます。			\N	vmod				\N	1
2733	鈴木さんは、将来、どんな仕事をしたいと思っているの。	鈴木さんは、将来、どんな仕事をしたいと思っているの。			\N	vmod				\N	1
2735	へえ、それはすごいね。	へえ、それはすごいね。			\N	vmod				\N	1
2736	どこに行きたいの。	どこに行きたいの。			\N	vmod				\N	1
2637	Oh begitu ke...	ああ、　そうですか…。			\N	vmod				\N	1
2149	すごくおいしい。	すごくおいしい。	null		\N	vmod				\N	1
1496	日本語の辞書はありますか。	日本語の辞書はありますか。	null		\N	vmod				\N	1
2737	ビジネス英語を勉強しているので、やっぱりアメリカに行きたいですね。	ビジネス英語を勉強しているので、やっぱりアメリカに行きたいですね。	①アメリカに行きたいです　②希望を述べる　③Vたいです　④いつかあなたに会いに行きたいです。		\N	vmod				\N	1
2739	お待たせ。	お待たせ。			\N	vmod				\N	1
2740	ありがとうございました。	ありがとうございました。			\N	vmod				\N	1
2741	あ、斉藤先生。	あ、斉藤先生。			\N	vmod				\N	1
2742	野村君、卒業おめでとう。	野村君、卒業おめでとう。			\N	vmod				\N	1
2743	ありがとうございます。	ありがとうございます。			\N	vmod				\N	1
2745	浩二の母でございます。	浩二の母でございます。			\N	vmod				\N	1
2746	浩二が　大変　お世話に　なりました。	浩二が　大変　お世話に　なりました。			\N	vmod				\N	1
2747	いいえ、　野村君、　これから　立派な　社会人に　なって　くださいね。	いいえ、　野村君、　これから　立派な　社会人に　なって　くださいね。			\N	vmod				\N	1
2750	薬を飲んで寝ます。	薬を飲んで寝ます。	\N		\N	vmod				205	1
2752	歯をみがきます。	歯をみがきます。	\N		\N	vmod				505	1
2760	佐藤さんは　髪が　短いです。	佐藤さんは　髪が　短いです。	\N		\N	vmod				619	1
2765	かぜで、　熱が　３８度　あります。	かぜで、　熱が　３８度　あります。	\N		\N	vmod				432	1
2768	テーブルの　上に　花瓶が　置いて　あります。	テーブルの　上に　花瓶が　置いて　あります。	\N		\N	vmod				414	1
2770	寝る　前に　ストーブを　消さないと、　危ないです。	寝る　前に　ストーブを　消さないと、　危ないです。	\N		\N	vmod				323	1
2773	テープレコーダーに　テープを　入れます。	テープレコーダーに　テープを　入れます。	\N		\N	vmod				415	1
2744	Cikgu, ini ibu saya. 	先生、　こちらが　私の　母です。	①こちらが私の母です。②人を紹介する　③こちらが(人名)です　④こちらが当社の社長の山本です。		\N	vmod				\N	1
2150	わたし、きのう、あれから映画見て、ごはん食べた。	わたし、きのう、あれから映画見て、ごはん食べた。	null		\N	vmod				\N	1
2799	この　ドアは　押すと、　開きます。	この　ドアは　押すと、　開きます。	\N		\N	vmod				106	1
2804	友だちに　電話番号を　教えました。	友だちに　電話番号を　教えました。	\N		\N	vmod				536	1
2816	日本人は　はしを　使って、　ごはんを　食べます。	日本人は　はしを　使って、　ごはんを　食べます。	\N		\N	vmod				513	1
2827	スイッチを　入れて、　電気を　つけます。　	スイッチを　入れて、　電気を　つけます。　	\N		\N	vmod				68	1
3604	Saya susah kerana mesti hafal banyak kanji. 	たくさん　漢字を　覚えなければ　ならないので、　大変です。	\N		\N	vmod				366	1
2849	きのう　中国から　来た　留学生と　会いました。	きのう　中国から　来た　留学生と　会いました。	\N		\N	vmod				681	1
2850	来月　韓国から　留学生が　来ます。	来月　韓国から　留学生が　来ます。	\N		\N	vmod				681	1
2859	両親が　野球の　練習を　見に　来ました。	両親が　野球の　練習を　見に　来ました。	\N		\N	vmod				690	1
2151	わたしは急ぎます。	わたしは急ぎます。	null		\N	vmod				\N	1
2872	学校で　松井さんと　一緒に　いる　時間が　一番　長いです。	学校で　松井さんと　一緒に　いる　時間が　一番　長いです。	\N		\N	vmod				468	1
2883	毎日　ラジオで　ニュースを　聞きます。	毎日　ラジオで　ニュースを　聞きます。	\N		\N	vmod				183	1
2897	刺身に　しょうゆを　つけて　食べます。	刺身に　しょうゆを　つけて　食べます。	\N		\N	vmod				407	1
2904	この　ドアは　壊れて　いるので、　開きません。	この　ドアは　壊れて　いるので、　開きません。	\N		\N	vmod				433	1
2905	花瓶が　壊れて　しまいました。	花瓶が　壊れて　しまいました。	\N		\N	vmod				163	1
2910	Ini majalah kereta.	これは　自動車の　雑誌です。	\N		\N	vmod				290	1
2922	スポーツは　野球が　一番　好きです。	スポーツは　野球が　一番　好きです。	\N		\N	vmod				325	1
2930	もう　遅いので、　家へ　帰ります。	もう　遅いので、　家へ　帰ります。	\N		\N	vmod				107	1
2932	大学の　前に　大きな　本屋が　できました。	大学の　前に　大きな　本屋が　できました。	\N		\N	vmod				418	1
2938	あの　人は　この　大学の　外国人教師です。	あの　人は　この　大学の　外国人教師です。	\N		\N	vmod				136	1
2942	夏休みは　国へ　帰ります。	夏休みは　国へ　帰ります。	\N		\N	vmod				210	1
2945	来年　海外へ　旅行に　行こうと　思って　います。	来年　海外へ　旅行に　行こうと　思って　います。	\N		\N	vmod				715	1
2963	その　スカートを　見せて　ください。	その　スカートを　見せて　ください。	\N		\N	vmod				723	1
2964	一番　安い　魚を　２匹　ください。	一番　安い　魚を　２匹　ください。	\N		\N	vmod				723	1
2972	松井さんに　コピーした　紙を　渡しました。	松井さんに　コピーした　紙を　渡しました。	\N		\N	vmod				253	1
2980	会社へ　行く　とき、　スーツを　着て、　ネクタイを　します。	会社へ　行く　とき、　スーツを　着て、　ネクタイを　します。	\N		\N	vmod				496	1
2985	仕事で　人と　会うので、　ネクタイを　します。	仕事で　人と　会うので、　ネクタイを　します。	\N		\N	vmod				760	1
2990	長い　時間　仕事を　して　いたので、　少し　休みます。	長い　時間　仕事を　して　いたので、　少し　休みます。	\N		\N	vmod				654	1
3003	かぜを　ひいたので、 家で　寝て　いました。	かぜを　ひいたので、 家で　寝て　いました。	\N		\N	vmod				761	1
3004	この　歌が　いちばん　好きです。	この　歌が　いちばん　好きです。	\N		\N	vmod				74	1
3020	寝る　前に、　ストーブを　消します。	寝る　前に、　ストーブを　消します。	\N		\N	vmod				323	1
3031	風の　強い　日は　テニスが　できません。	風の　強い　日は　テニスが　できません。	\N		\N	vmod				711	1
3032	雪の　日に　出かけるのは　危ないです。	雪の　日に　出かけるのは　危ないです。	\N		\N	vmod				663	1
3033	少し　暑いので、　窓を　開けます。	少し　暑いので、　窓を　開けます。	\N		\N	vmod				712	1
3049	夜は　寒く　なるので、　コートを　持って　出かけます。	夜は　寒く　なるので、　コートを　持って　出かけます。	\N		\N	vmod				273	1
2325	もう、　十時半ですよ。	もう、　十時半ですよ。			\N	vmod				\N	1
3054	あの　美容師は　きれいで　細いです。	あの　美容師は　きれいで　細いです。	\N		\N	vmod				762	1
3055	大学を　出たら、　美容師に　なりたいです。	大学を　出たら、　美容師に　なりたいです。	\N		\N	vmod				762	1
3061	この　箱は　横が　長いです。	この　箱は　横が　長いです。	\N		\N	vmod				668	1
3082	なくした　時計が　見つかりました。	なくした　時計が　見つかりました。	\N		\N	vmod				770	1
3083	よく　探せば、　見つかります。	よく　探せば、　見つかります。	\N		\N	vmod				770	1
3085	かぎが　ないので、　かばんの　中を　探しました。	かぎが　ないので、　かばんの　中を　探しました。	\N		\N	vmod				773	1
3090	あの　食堂の　定食は　安くて　おいしいです。	あの　食堂の　定食は　安くて　おいしいです。	\N		\N	vmod				775	1
3069	Kelas cikgu itu menarik.	あの　先生の　授業は　おもしろいです。	\N		\N	vmod				302	1
3101	あそこに　郵便局員が　います。	あそこに　郵便局員が　います。	\N		\N	vmod				782	1
3107	会社へ　行く　とき、　スーツを　着ます。	会社へ　行く　とき、　スーツを　着ます。	\N		\N	vmod				786	1
3113	いちばん　安い　魚を　二匹　ください。	いちばん　安い　魚を　二匹　ください。	\N		\N	vmod				723	1
3125	この　町の　水は　きれいです。	この　町の　水は　きれいです。	\N		\N	vmod				200	1
3152	たくさん　買い物を　したので、　お金が　なくなりました。	たくさん　買い物を　したので、　お金が　なくなりました。	\N		\N	vmod				139	1
3166	イさんは　日本語が　話せます。	イさんは　日本語が　話せます。	\N		\N	vmod				811	1
3167	Encik Lee menulis surat dalam bahasa Jepun. 	イさんは　日本語で　手紙を　書きました。。	\N		\N	vmod				811	1
2450	はい。	はい。			\N	vmod				\N	1
3191	ズボンより　スカートの　ほうが　好きです。	ズボンより　スカートの　ほうが　好きです。	\N		\N	vmod				315	1
3325	今晩　駅で　イさんに　会います。	今晩　駅で　イさんに　会います。	\N		\N	vmod				2	1
3200	しょうゆを　つけて、　さしみを　食べます。	しょうゆを　つけて、　さしみを　食べます。	\N		\N	vmod				803	1
3203	砂糖と　塩を　使って、　料理を　作ります。	砂糖と　塩を　使って、　料理を　作ります。	\N		\N	vmod				280	1
3212	Bekal Encik Hayashi kelihatan sedap.	林さんの　お弁当は　おいしそうです。	\N		\N	vmod				92	1
3222	目が　悪いので、　眼鏡を　かけます。	目が　悪いので、　眼鏡を　かけます。	\N		\N	vmod				637	1
3228	食べる　前に、　手を　洗います。	食べる　前に、　手を　洗います。	\N		\N	vmod				412	1
2326	あっ、　本当だ。	あっ、　本当だ。			\N	vmod				\N	1
2327	急がないと。	急がないと。			\N	vmod				\N	1
2473	いいですね。	いいですね。			\N	vmod				\N	1
3258	ここから　少し　西へ　行くと、　海が　あります。	ここから　少し　西へ　行くと、　海が　あります。	\N		\N	vmod				539	1
3252	Buku nota ada dalam beg.	ノートは　かばんの　中に　あります。	\N		\N	vmod				728	1
3253	Bilik darjah itu ada TV.	あそこの　教室には　テレビが　あります。	\N		\N	vmod				728	1
2499	わかりました。	わかりました。			\N	vmod				\N	1
3286	山田さんは　来月　東京に　行くそうです。	山田さんは　来月　東京に　行くそうです。	\N		\N	vmod				675	1
3291	Tandas di sini. 	お手洗いは　こちらです。	\N		\N	vmod				244	1
3304	船便で　手紙を　出すと、　ひとつき　かかります。	船便で　手紙を　出すと、　ひとつき　かかります。	\N		\N	vmod				547	1
3308	イさんは　ひとつきで　日本語が　とても　上手に　なりました。	イさんは　ひとつきで　日本語が　とても　上手に　なりました。	\N		\N	vmod				547	1
3330	この　ボタンを　押すと、　ドアが　開きます。	この　ボタンを　押すと、　ドアが　開きます。	\N		\N	vmod				9	1
3345	これは　日本で　売って　いない　服です。	これは　日本で　売って　いない　服です。	\N		\N	vmod				79	1
3316	Tahun ini lebih panas daripada tahun lepas. 	去年より　今年の　ほうが　暑いです。	\N		\N	vmod				197	1
2152	日本の　冬は　寒いです。	日本の　冬は　寒いです。	null		\N	vmod				\N	1
3359	電話を　切る　前に、　「さようなら」と　言います。	電話を　切る　前に、　「さようなら」と　言います。	\N		\N	vmod				818	1
3360	きのう　友達に　電話を　かけましたが、　すぐ　切りました。	きのう　友達に　電話を　かけましたが、　すぐ　切りました。	\N		\N	vmod				818	1
3400	鳥が　鳴いて　います。	鳥が　鳴いて　います。	\N		\N	vmod				470	1
3376	Ini buku nota saya. 	これは　わたしの　ノートです。	\N		\N	vmod				500	1
3401	あの　猫は　かわいい　声で　鳴きます。	あの　猫は　かわいい　声で　鳴きます。	\N		\N	vmod				470	1
3440	あそこの　八百屋は　毎月　１４日が　安いです。	あそこの　八百屋は　毎月　１４日が　安いです。	\N		\N	vmod				488	1
1309	どのかばんですか。	どのかばんですか。	null		\N	vmod				\N	1
3461	きのうは　一日中　テレビを　見て　いました。	きのうは　一日中　テレビを　見て　いました。	\N		\N	vmod				397	1
3471	この　ドアは　開きません。	この　ドアは　開きません。	\N		\N	vmod				433	1
3475	暗い　ところで　本を　読んでは　いけません。	暗い　ところで　本を　読んでは　いけません。	\N		\N	vmod				7	1
3447	Saya selalu naik kereta api pukul lapan pagi. 	いつも　朝　八時の　電車に　乗ります。	\N		\N	vmod				12	1
3513	Buku ini membosankan. 	この　本は　つまらないです。	\N		\N	vmod				409	1
3566	この　クラスには　学生が　九人　います。	この　クラスには　学生が　九人　います。	\N		\N	vmod				813	1
3567	来週　四人で　遊びに　行きます。	来週　四人で　遊びに　行きます。	\N		\N	vmod				813	1
3910	ドアが　開きます。	ドアが　開きます。	\N		\N	vmod				433	1
3601	田中さんは　たいへんな　仕事を　して　います。	田中さんは　たいへんな　仕事を　して　います。	\N		\N	vmod				368	1
3602	たくさん　漢字を　覚えなければ　ならないので、　たいへんです。	たくさん　漢字を　覚えなければ　ならないので、　たいへんです。	\N		\N	vmod				368	1
3603	Encik Tanaka membuat kerja yang susah. 	田中さんは　大変な　仕事を　して　います。	\N		\N	vmod				366	1
1806	木村さんは留学しようと思っています。	木村さんは留学しようと思っています。	null		\N	vmod				\N	1
1873	うれしい。	うれしい。	null		\N	vmod				\N	1
1939	あの人は歌手のようです。	あの人は歌手のようです。	null		\N	vmod				\N	1
2037	すみません、パソコンが動かないのですけれども。	すみません、パソコンが動かないのですけれども。	null		\N	vmod				\N	1
2098	母はわたしにてぶくろをあんでくれました。	母はわたしにてぶくろをあんでくれました。	null		\N	vmod				\N	1
2197	雨が降ったのに運動会がありました。	雨が降ったのに運動会がありました。	null		\N	vmod				\N	1
2367	はい。	はい。			\N	vmod				\N	1
2381	どうぞ。	どうぞ。			\N	vmod				\N	1
2431	先輩の予定は。	先輩の予定は。			\N	vmod				\N	1
2471	はい。	はい。			\N	vmod				\N	1
2583	はい。	はい。			\N	vmod				\N	1
2609	そうですか。	そうですか。			\N	vmod				\N	1
2697	じゃ、出なくてもいいですよ。	じゃ、出なくてもいいですよ。	①出なくてもいいです　②義務を否定する　③Vなくてもいいです　④雨の日は掃除しなくてもいいです。		\N	vmod				\N	1
3112	カレーと　水を　ください。	カレーと　水を　ください。	\N		\N	vmod				723	1
3393	週末、　山を　登ります。	週末、　山を　登ります。	\N		\N	vmod				501	1
1	朝です。	朝です。	null		\N	vmod				\N	0
3413	Saya selalu bermain dengan kawan-kawan saya pada hari Jumaat kerana hari kemudiannya cuti. 	次の　日が　休みなので、　金曜日は　いつも　友達と　遊びます。	\N		\N	vmod				203	1
2762	Saya kena selesema kerana cuaca sangat sejuk semalam. 	きのう　とても　寒かったので、　かぜを　ひきました。	\N		\N	vmod				153	1
3694	Harga hidangan restoran itu murah, tapi tidak berapa sedap. 	あの　レストランは　安いです。　でも、　あまり　おいしくないです。	\N		\N	vmod				424	1
3695	Majlis semalam seronok.  Tapi saya agak letih sedikit. 	きのうの　パーティーは　楽しかったです。　でも、　少し　疲れました。	\N		\N	vmod				424	1
3628	Saya meminjam telefon daripada Puan Kimura.	木村さんに　電話を　貸して　もらいました。	\N		\N	vmod				430	1
3629	Saya akan menelefon Encik Lee esok.	あした　イさんに　電話を　します。	\N		\N	vmod				430	1
3742	Hari ini saya sering berjumpa dengan Encik Kobayashi.	きょうは　よく　小林さんに　会います。	\N		\N	vmod				732	1
3743	Saya selalu pergi ke kedai kopi itu dengan Encik Kobayashi. 	木村さんと　よく　あの　喫茶店へ　行きます。	\N		\N	vmod				732	1
1259	Ini pen saya. 	わたしの　ペンは　これです。	null		\N	vmod				\N	1
3512	Saya mendengar cerita yang membosankan daripada kawan saya. 	友達に　つまらない　話を　聞きました。	\N		\N	vmod				409	1
1326	Berapa helai sapu tangan yang ada di sana? 	そこに　ハンカチが　何枚　ありますか。	null		\N	vmod				\N	1
1335	Hari ini berapa hari bulan? 	きょうは　何月　何日ですか。	null		\N	vmod				\N	1
1330	Sekarang pukul lima. 	今、　五時です。	null		\N	vmod				\N	1
1491	Sekarang Encik Kobayashi tengah membaca buku di perpustakaan. 	今、　小林さんは　図書館で　本を　読んで　います。	null		\N	vmod				\N	1
2931	Saya sangat lambat apabila berjalan kaki. 	わたしは　歩くのが　とても　遅いです。	\N		\N	vmod				107	1
1974	Saya tengok Encik Tanaka sedang belajar di perpustakaan. 	図書館で　勉強して　いる　田中さんを　見ました。	null		\N	vmod				\N	1
2966	Perpustakaan buka dari pukul sembiran pagi sampai pukul lapan malam. 	図書館は　午前　九時から　午後　八時までです。	\N		\N	vmod				449	1
3779	Kalau begitu, saya minta tolong awak.	では、　よろしく　お願いします。	\N		\N	vmod				422	1
3780	Baiklah, kita akan mulakan kelas. 	では、　授業を　始めます。	\N		\N	vmod				422	1
1320	Berapakah harga pen ini? 	この　ボールペンは　いくらですか。	null		\N	vmod				\N	1
2409	Berapakah harganya? 	いくら　でしょうか。	①いくらでしょうか　②情報を求める(金額) 　③いくら（ですか）　④このりんごはいくらですか。		\N	vmod				\N	1
1720	Sila tunggu sekejap. 	ちょっと　待って　ください。	null		\N	vmod				\N	1
3718	B: Maaf, saya rasa susah sikit kalau esok. 	B ： すみません。　あしたは　ちょっと…。	\N		\N	vmod				399	1
3719	A: Apa kata kita bersama pergi membeli-belah esok?	A ： あした　買い物に　行きませんか。　	\N		\N	vmod				399	1
2828	Saya nak masukkan duit ke dalam dompet saya.	財布に　お金を　入れます。	\N		\N	vmod				68	1
2829	Puan Matsui menuangkan kopi untuk saya. 	松井さんは　わたしに　コーヒーを　入れて　くれました。	\N		\N	vmod				68	1
3292	Ini Encik Kobayashi. 	こちらは　小林さんです。	\N		\N	vmod				244	1
2936	Saya boleh bercakap dalam bahasa Inggeris. 	わたしは　英語が　話せます。	\N		\N	vmod				85	1
2937	Saya belajar bahasa Inggeris dengan menggunakan kamus. 	辞書を　使って、　英語を　勉強します。	\N		\N	vmod				85	1
1299	Buku itu saya punya. 	その　本は　わたしのです。	null		\N	vmod				\N	1
1350	Encik Tanaka belajar di perpustakaan tetapi saya belajar di rumah. 	田中さんは　図書館で　勉強しますが、　わたしは　家で　勉強します。	null		\N	vmod				\N	1
1692	Beg itu sama dengan beg saya. 	あの　かばんは　わたしの　かばんと　同じです。　	null		\N	vmod				\N	1
3597	Saya memberitahu hari yang saya boleh kepada Encik Lee kerana saya akan keluar bersama beliau pada bulan depan.	来月　一緒に　遊ぶので、　イさんに　大丈夫な　日を　教えます。	\N		\N	vmod				362	1
3598	Walaupun saya mesti belajar hari ini, tetapi saya boleh esok. 	きょうは　勉強しなければ　なりませんが、　あしたは　大丈夫です。	\N		\N	vmod				362	1
3034	Musim panas di Jepun panas. 	日本の　夏は　暑いです。	\N		\N	vmod				712	1
3037	Oleh kerana esok cuaca panas, saya ingat nak berenang di dalam kolam renang.	あしたは　暑く　なるので、　プールで　泳ごうと　思います。	\N		\N	vmod				712	1
1397	Saya pergi melancong semasa cuti musim panas. 	わたしは　夏休みに　旅行しました。	null		\N	vmod				\N	1
1646	Cuti musim panas dari satu hari bulan Ogos sehingga tiga puluh hari bulan September.	八月　一日から　九月　三十日まで　夏休みです。	null		\N	vmod				\N	1
2205	Saya pergi ke laut serta mendaki gunung semasa cuti musim panas tahun ini. 	今年の　夏休みは、　海にも　行きましたし、　山にも　登りました。	null		\N	vmod				\N	1
3503	Filem ini tidak berapa bagus.	この　映画は　あまり　よくなかったです。	\N		\N	vmod				40	1
3504	Saya tahu kedai yang bagus	わたしは　いい　店を　知って　います。	\N		\N	vmod				40	1
3505	Komputer ini mahal tetapi sangat bagus. 	この　コンピューターは　高いですが、　とても　いいです。	\N		\N	vmod				40	1
3682	Semasa musim panas, saya keluar dengan memakai topi setiap hari. 	夏は　毎日　帽子を　かぶって　出かけます。	\N		\N	vmod				473	1
3683	Musim panas di Jepun sangat panas. 	日本の　夏は　とても　暑いです。	\N		\N	vmod				473	1
2429	Saya ingat nak melancong ke Eropah dengan kawan saya. 	友達と　ヨーロッパを　旅行しようと　思って　ます。	①旅行しようと思っています　②予定を言う　③意向形（う／よう）と思います／思っています　④土曜日は映画を見ようと思っています		\N	vmod				\N	1
3067	Esok saya akan pergi menonton filem dengan kawan saya. 	あした　友達と　映画を　見に　行きます。	\N		\N	vmod				458	1
3708	Saya akan tidur selepas membaca buku sedikit.	少し　本を　読んで、　寝ます。　	\N		\N	vmod				320	1
3709	Semalam, saya minum sedikit arak. 	きのう　少し　お酒を　飲みました。　	\N		\N	vmod				320	1
1799	Biar saya buat kerja tersebut. 	その　仕事は　わたしが　しましょう。	null		\N	vmod				\N	1
2947	Saya terfikir nak pergi melancong ke luar negara pada tahun depan.	来年　海外へ　旅行に　行こうと　思って　います。	\N		\N	vmod				684	1
2948	Saya membeli buku tentang pelancongan di kedai buku.	本屋で　旅行の　本を　買いました。	\N		\N	vmod				684	1
1495	Saya belajar sejak tahun lepas. 	去年から　勉強して　います。	null		\N	vmod				\N	1
3420	Saya telah pergi melancong ke luar negara bersama kawan saya pada tahun lepas. 	去年、　友達と　海外旅行に　行きました。	\N		\N	vmod				197	1
3706	Terima kasih. Ini sudah cukup. 	ありがとう。　これで　けっこうです。	\N		\N	vmod				223	1
3806	Semuanya berjumlah seribu enam ratus yen. 	全部で　千六百円です。	\N		\N	vmod				344	1
3807	Kerja rumah semuanya sudah siap dibuat. 	宿題が　全部　終わりました。	\N		\N	vmod				344	1
3850	Saya ingin melancong ke seluruh Jepun. 	わたしは　日本中　旅行したいです。	\N		\N	vmod				749	1
3851	Saya tidak ada di rumah sepanjang hari semalam. 	きのうは　一日中　うちに　いませんでした。	\N		\N	vmod				749	1
3810	Kasut Cik Kobayashi sama dengan kasut saya. 	わたしの　靴と　小林さんの　靴は　同じです。	\N		\N	vmod				118	1
3811	Matsui sekelas dengan Encik Lee.	松井さんと　イさんは　同じ　クラスです。	\N		\N	vmod				118	1
3302	Pasar raya itu tutup pada setiap hari Rabu bulan ini. 	今月　あの　スーパーは　水曜日が　休みです。　　	\N		\N	vmod				257	1
3303	Saya sangat sibuk bekerja pada bulan ini. 	今月は　仕事が　とても　忙しかったです。	\N		\N	vmod				257	1
3365	Saya susah kerana kehilangan pasport semasa berada di luar negara. 	外国で　パスポートを　なくしたので、　困りました。	\N		\N	vmod				254	1
3417	Saya nak belajar kerana ada ujian pada minggu depan. 	来週　テストが　あるので、　勉強します。	\N		\N	vmod				676	1
3418	Kakak saya akan berkahwin pada minggu depan. 	来週、　姉が　結婚します。	\N		\N	vmod				676	1
3411	Hospital di sana tutup pada setiap hari Rabu dan hari Ahad. 	あそこの　病院は　水曜日と　日曜日が　休みです。	\N		\N	vmod				313	1
3148	Lapangan terbang baru telah dibina dekat sini. 	近くに　新しい　空港が　できました。	\N		\N	vmod				806	1
3149	Pasport ditunjukkan semasa berada di lapangan terbang. 	空港で　パスポートを　見せます。	\N		\N	vmod				806	1
1250	Di belakang rumah ada kereta. 	家の　うしろに　車が　あります。	null		\N	vmod				\N	1
2061	Sekiranya kereta sudah dibeli, kita boleh pergi ke mana-mana sahaja. 	車を　買えば、　どこでも　行けます。	null		\N	vmod				\N	1
2908	Kereta Jepun mahal tetapi bagus. 	日本の　車は　高いですが、　いいです。	\N		\N	vmod				217	1
1229	Encik Tanaka ada di mana? 	田中さんは　どこに　いますか。	null		\N	vmod				\N	1
1264	Di manakah bilik darjah untuk bahasa Jepun ? 	日本語の　教室は　どこですか。	null		\N	vmod				\N	1
1312	Kereta cikgu ada di mana?	先生の　車は　どこに　ありますか。	null		\N	vmod				\N	1
3749	Awak selalu makan tengah hari di mana? 	いつも　どこで　昼ごはんを　食べますか。	\N		\N	vmod				446	1
1431	Dekat kawasan sini, tidak banyak bangunan yang tinggi. 	この　あたりには、　あまり　高い　建物が　ありません。	null		\N	vmod				\N	1
2495	Ada di tingkat tiga bangunan ini. 	この　建物の　三階に　あります。			\N	vmod				\N	1
1414	Bagaimana dengan masakan Jepun? 	日本の　料理は　どうですか。	null		\N	vmod				\N	1
1423	Bagaimana filem yang awak tengok semalam?	きのうの　映画は　どうでしたか。	null		\N	vmod				\N	1
2064	Bagaimanakah cara supaya saya boleh menghafal kanji? 	どうすれば、　漢字を　覚える　ことが　できますか。	null		\N	vmod				\N	1
1297	Ada guru di sana. 	あそこに　先生が　います。	null		\N	vmod				\N	1
2498	Ada lif di sana. 	あそこに　エレベーターが　あります。			\N	vmod				\N	1
1836	Awak nak yang mana? 	どれが　ほしいですか。	null		\N	vmod				\N	1
3752	Yang mana paling sedap? 	どれが　いちばん　おいしいですか。	\N		\N	vmod				463	1
3753	Yang manakah Puan Hayashi beli ? 	林さんは　どれを　買いましたか。	\N		\N	vmod				463	1
1311	Itu Encik Tanaka punya. 	あれは　田中さんのです。	null		\N	vmod				\N	1
1694	Saya ucap "Selamat pagi" selepas bangun pada waktu pagi.	朝　起きた　ときには　「おはよう　ございます」と　言います。	null		\N	vmod				\N	1
3170	Saya akan cakap tentang perkara tersebut kepada guru. 	その　ことは　わたしが　先生に　言います。　	\N		\N	vmod				42	1
1473	Jangan lupa tentang kerja rumah. 	宿題を　忘れないで　ください。	null		\N	vmod				\N	1
3063	Saya akan membuat kerja rumah di perpustakaan malam ini. 	今晩は　図書館で　宿題を　します。	\N		\N	vmod				303	1
1683	Saya akan membuat kerja itu sendiri. 	その　仕事は　自分で　やります。	null		\N	vmod				\N	1
3290	Saya yang memasak makan malam setiap hari. 	夕飯は　毎日　自分が　作ります。	\N		\N	vmod				293	1
1885	Saya boleh menulis kanji. 	わたしは　漢字が　書けます。	null		\N	vmod				\N	1
3165	Walaupun saya belajar bahasa Jepun setiap hari, saya masih tidak boleh hafal kanji. 	毎日　日本語を　勉強して　いますが、　漢字が　覚えられません。	\N		\N	vmod				178	1
2154	Filem yang saya tengok semalam itu sangat menarik. 	きのう　見た　映画は　おもしろかったです。	null		\N	vmod				\N	1
3009	Ini filem lama Jepun . 	これは　日本の　古い　映画です。	\N		\N	vmod				83	1
3013	Makanan yang saya suka adalah kari. 	わたしの　好きな　食べ物は　カレーです。	\N		\N	vmod				316	1
3014	Emak saya suka memasak. 	母は　料理が　好きです。	\N		\N	vmod				316	1
3785	Minuman yang paling saya suka adalah teh.	わたしが　いちばん　好きな　飲み物は　紅茶です。　	\N		\N	vmod				55	1
3786	Daging ini yang paling murah. 	この　肉が　いちばん　安いです。	\N		\N	vmod				55	1
3336	Saya tidak pergi ke sekolah kerana demam. 	きのう　熱が　あったので、　学校へ　行きませんでした。	\N		\N	vmod				45	1
3337	Selepas habis sekolah, saya akan pergi ke rumah kawan saya. 	授業が　終わったら、　友達の　家へ　行きます。	\N		\N	vmod				45	1
1484	Selepas habis makan, saya menggosok gigi. 	ごはんを　食べてから、　歯を　みがきます。	null		\N	vmod				\N	1
1993	Encik Yamada yang makan kek. 	ケーキを　食べたのは　山田さんです。	null		\N	vmod				\N	1
2818	Saya makan sarapan setiap hari. 	わたしは　毎日　朝ごはんを　食べます。	\N		\N	vmod				381	1
1419	Hidangan di majlis tersebut tidak berapa sedap. 	パーティーの　料理は　おいしく　ありませんでした。	null		\N	vmod				\N	1
1967	Masakan yang ibu masak sangat sedap. 	母が　作る　料理は　とても　おいしいです。	null		\N	vmod				\N	1
2104	Saya belajar memasak daripada ibu.	母に　料理を　教えて　もらいました。	null		\N	vmod				\N	1
1557	Saya berjalan kaki ke sekolah setiap hari. 	わたしは　毎日　歩いて　学校へ　行きます。	null		\N	vmod				\N	1
3433	Setiap hari akan ada ujian mulai pada minggu depan.	来週から　毎日　テストが　あります。	\N		\N	vmod				602	1
2391	Terima kasih, ya.	どうも　ありがとう。			\N	vmod				\N	1
3774	Minta maaf, ya.	どうも　すみません。	\N		\N	vmod				439	1
3775	Terima kasih banyak-banyak, ya.	どうも　ありがとう　ございました。	\N		\N	vmod				439	1
3776	Terima kasih.	どうも。	\N		\N	vmod				439	1
2976	Guru menyerahkan salinan surat khabar kepada pelajar-pelajarnya. 	先生は　学生に　新聞の　コピーを　渡しました。	\N		\N	vmod				252	1
2043	Kalau tekan butang ini, pintu akan buka. 	この　ボタンを　押すと、　ドアが　開きます。	null		\N	vmod				\N	1
3141	Saya telah terima borang permohonan kiriman wang di kaunter. 	窓口で　振り込み用紙を　もらいました。	\N		\N	vmod				795	1
3142	Saya menulis nama dan alamat pada borang ini.	この　用紙に　名前と　住所を　書きます。	\N		\N	vmod				795	1
2548	Helo? 	もしもし。			\N	vmod				\N	1
3772	Helo, ini Kimura. 	もしもし、　木村ですが。	\N		\N	vmod				642	1
3773	Ya, helo. Ini Matsui. 	はい、　もしもし、　松井です。	\N		\N	vmod				642	1
1349	Saya pergi ke sekolah setiap hari. 	毎日、　学校へ　行きます。	null		\N	vmod				\N	1
1605	Saya tidak pergi ke sekolah. 	学校を　休みます。	null		\N	vmod				\N	1
3230	Kaki saya letih kerana banyak berjalan kaki. 	たくさん　歩いたので、　足が　疲れました。	\N		\N	vmod				15	1
3231	Orang itu kakinya sangat panjang. 	あの　人は　とても　足が　長いです。	\N		\N	vmod				15	1
3028	Saya tidak akan keluar pada hari cuti sekiranya hujan.	雨だったら、　休みの　日は　出かけません。	\N		\N	vmod				710	1
3029	Saya akan naik bas ke sekolah esok kerana hujan. 	あしたは　雨なので、　バスで　学校へ　行きます。	\N		\N	vmod				710	1
2007	Kenapa awak tahu nombor telefon saya?	どうして　わたしの　電話番号が　わかったのですか。	null		\N	vmod				\N	1
2011	Kenapa? 	どうしてですか。	null		\N	vmod				\N	1
2017	Kenapa awak tidak hadir ke kelas? 	どうして　授業を　休んだのですか。	null		\N	vmod				\N	1
1542	Stoking ini tahan lama dan murah. 	この　靴下は、　じょうぶで　安いです。	null		\N	vmod				\N	1
1433	Ada kedai bagus di depan stesen. 	駅前に　いい　店が　あります。	null		\N	vmod				\N	1
2949	Hari ini kedai ini menjual daging dengan harga murah. 	きょう　この　店は　肉が　安いです。	\N		\N	vmod				621	1
2950	Banyak kedai yang tersusun di sana.	あそこに　たくさん　店が　並んで　います。	\N		\N	vmod				621	1
3524	Encik Hayashi tinggal di bandar yang terdapat ramai orang. 	林さんは　人が　多い　町に　住んで　います。	\N		\N	vmod				93	1
3525	Sekolah ini mempunyai ramai pelajar antarabangsa.	この　学校は　留学生が　多いです。	\N		\N	vmod				93	1
1380	Saya mengajar bahasa Inggeris kepada Cik Kimura. 	木村さんに　英語を　教えます。	null		\N	vmod				\N	1
2862	Saya mengajar bahasa Jepun kepada orang asing	わたしは　外国人に　日本語を　教えて　います。	\N		\N	vmod				105	1
1883	Bolehkah saya menelefon ke luar negara dengan telefon itu? 	あの　電話で　外国に　電話が　できますか。	null		\N	vmod				\N	1
2179	Kita bawa pasport apabila ingin ke luar negara.	外国へ　行く　とき、　パスポートを　持って　行きます。	null		\N	vmod				\N	1
3710	Sekarang ini saya sedang makan malam.	今　ちょうど　晩ごはんを　食べて　いる　ところです。	\N		\N	vmod				398	1
3711	Pertandingan akan bermula sekarang ini.	今から　ちょうど　試合が　始まります。	\N		\N	vmod				398	1
1826	Sebenarnya saya ingin belajar di universiti di Tokyo. 	東京の　大学へ　行きたかったです。	null		\N	vmod				\N	1
3750	Mengapa awak belajar bahasa Jepun? 	なぜ　日本語を　勉強して　いるんですか。	\N		\N	vmod				472	1
3470	Lima minit lagi kelas akan habis. 	あと　五分で　授業が　終わります。	\N		\N	vmod				25	1
2977	Encik Hayashi bekerja di syarikat komputer. 	林さんは　コンピューターの　会社で　働いて　います。	\N		\N	vmod				137	1
2978	Esok saya akan pergi ke syarikat awal. 	あしたは　早く　会社へ　行きます。	\N		\N	vmod				137	1
3318	Saya akan membeli kereta baru pada tahun depan. 	来年　わたしは　新しい　車を　買おうと　思います。	\N		\N	vmod				677	1
3319	Mulai tahun depan, abang saya akan bekerja di bank. 	来年から　兄は　銀行に　勤めます。	\N		\N	vmod				677	1
1393	Bila awak bermain tenis? 	いつ　テニスを　しますか。	null		\N	vmod				\N	1
1494	Sejak bila awak belajar bahasa Jepun? 	いつから　日本語を　勉強して　いますか。	null		\N	vmod				\N	1
1280	Filem yang bagaimana?	どんな　映画ですか。	null		\N	vmod				\N	1
3754	Itu makanan yang bagaimana? 	それは　どんな　食べ物ですか。	\N		\N	vmod				464	1
3755	Awak ingin berkahwin dengan orang yang bagaimana? 	どんな　人と　結婚したいですか。	\N		\N	vmod				464	1
1817	Saya ingin mendengar muzik dari Jepun. 	日本の　音楽を　聞きたいです。	null		\N	vmod				\N	1
1848	Saya suka muzik. 	わたしは　音楽が　すきです。	null		\N	vmod				\N	1
3467	Masukkan gula, kemudian masukkan kicap sedikit. 	砂糖を　入れたら、　次に　しょうゆを　少し　入れます。	\N		\N	vmod				403	1
3468	Kemudian, saya akan meminjamkan majalah ini kepada Puan Yamada. 	次　この　雑誌は　山田さんに　貸します。	\N		\N	vmod				403	1
2651	Bolehkah saya pulangkan semasa waktu rehat tengah hari?	返すのは、　お昼休みでも　いいですか。	①お昼休みでもいいですか　②許可を求める　③〜て（で）もいいですか　④この書類の記入は英語でもいいですか。		\N	vmod				\N	1
2796	Saya nak pulangkan wang kepada Cik Matsui. 	松井さんに　お金を　返します。	\N		\N	vmod				141	1
2797	Saya nak pulangkan buku kepada perpustakaan. 	図書館に　本を　返します。	\N		\N	vmod				141	1
3100	Saya guna kad apabila membeli barang. 	買い物を　する　とき、　カードを　使います。	\N		\N	vmod				401	1
3160	Pen digunakan untuk mengisi borang permohonan kiriman wang.	振り込み用紙を　書く　とき、　ボールペンを　使います。	\N		\N	vmod				401	1
160	15あります。	15あります。	null		\N	vmod				\N	0
3823	Bilik darjah untuk awak semua berada di tingkat tiga.	皆さんの　教室は　三階です。	\N		\N	vmod				627	1
3824	Kalau awak semua nak pergi, saya pun akan pergi. 	皆さんが　行くなら、　わたしも　行きます。	\N		\N	vmod				627	1
3825	Awak semua akan ada ujian kanji pada minggu depan. 	皆さん、　来週　漢字の　テストを　します。	\N		\N	vmod				627	1
3789	Jangan masuk ke dalam bilik itu. 	その　部屋に　入っては　いけません。	\N		\N	vmod				353	1
1296	Beg Puan Tanaka ada di situ. 	田中さんの　かばんは　そこに　あります。	null		\N	vmod				\N	1
3293	Kerana tidak boleh duduk di sini, saya akan duduk di sana.	こっちは　座れないので、　あっちに　座ります。	\N		\N	vmod				245	1
3299	Kalau pergi ke situ, ada pejabat pos dan bank. 	そっちへ　行くと、　郵便局や　銀行が　あります。	\N		\N	vmod				351	1
1528	Kami ada latihan bola sepak pada setiap hari Isnin, Rabu dan Jumaat. 	月曜日と　水曜日と　金曜日に　サッカーの　練習が　あります。	null		\N	vmod				\N	1
2864	Saya berlatih bermain tenis setiap hari selepas habis sekolah.	学校が　終わった　あと、　毎日　テニスの　練習を　します。	\N		\N	vmod				690	1
1637	Saya keluar dari rumah pada pukul tujuh pagi. 	七時に　家を　出ます。	null		\N	vmod				\N	1
3377	Malam ini saya akan keluar dari syarikat awal dan balik ke rumah. 	今晩は　早く　会社を　出て、　うちへ　帰ります。	\N		\N	vmod				425	1
3408	Tahun depan saya akan keluar dari universiti. 	来年　わたしは　大学を　出ます。	\N		\N	vmod				425	1
3506	Makanan ini tidak baik untuk badan kita. 	これは　体に　悪い　食べ物です。	\N		\N	vmod				702	1
3507	Hari ini cuaca tidak baik. 	きょうは　天気が　悪いです。	\N		\N	vmod				702	1
3535	Kami memesan empat jenis makanan di restoran. 	レストランで　料理を　四つ　頼みます。	\N		\N	vmod				670	1
3414	Saya akan makan malam di rumah Encik Hayashi pada hari Sabtu ini. 	土曜日は　林さんの　家で　晩ごはんを　食べます。	\N		\N	vmod				459	1
1545	Saya tidak boleh pergi ke sekolah kerana demam tinggi. 	熱が　高くて、　学校へ　行く　ことが　できませんでした。	null		\N	vmod				\N	1
3074	Saya tidak hadir kerana demam. 	熱が　あるので、　きょうは　休みます。	\N		\N	vmod				757	1
1738	Jangan gunakan telefon bimbit di hospital. 	病院で　携帯電話を　使っては　いけません。	null		\N	vmod				\N	1
3073	Semalam saya tidak pergi ke syarikat, tetapi pergi ke hospital.	きのうは　会社を　休んで、　病院へ　行きました。	\N		\N	vmod				551	1
1634	Saya bermalam di hotel. 	ホテルに　泊まります。	null		\N	vmod				\N	1
2944	Bilik hotel ini sangat cantik. 	この　ホテルの　部屋は　とても　きれいです。	\N		\N	vmod				593	1
3144	Saya memberitahu alamat saya yang baru kepada kawan saya. 	友達に　新しい　住所を　教えました。	\N		\N	vmod				796	1
2734	Saya rasa nak bekerja di luar negara.	海外で　働きたいと　思って　いるんです。	①働きたいと思っているんです。②希望を述べる　③Vたいと思います④いつか自分の家を建てたいと思います。		\N	vmod				\N	1
2946	Cik Matsui tinggal di luar negara selama tiga tahun. 	松井さんは　海外に　三年間　住んで　いました。	\N		\N	vmod				715	1
3263	Saya memberi hadiah hari jadi kepada ibu saya. 	母に　誕生日の　プレゼントを　あげました。	\N		\N	vmod				527	1
1176	Encik Tanaka bukan pelajar.	田中さんは　学生では　ありません。	null		\N	vmod				\N	1
2153	Saya seorang pelajar. 	わたしは　学生です。	null		\N	vmod				\N	1
2158	Saya seorang pelajar tetapi abang saya pula pekerja syarikat. 	わたしは　学生ですが、　兄は　会社員です。	null		\N	vmod				\N	1
3684	Banyak bunga berkembang semasa musim bunga. 	春は　花が　たくさん　咲きます。	\N		\N	vmod				724	1
3685	Di Jepun, angin kencang semasa musim bunga. 	日本では　春　風が　強いです。	\N		\N	vmod				724	1
2086	Saya menghadiahkan bunga kepada bapa saya. 	わたしは　父に　花を　あげました。	null		\N	vmod				\N	1
2979	Saya keluar dengan kawan pada hari cuti. 	休みの　日は　友達と　出かけます。	\N		\N	vmod				653	1
1194	Cuaca di Tokyo cerah. 	東京は　晴れでした。	null		\N	vmod				\N	1
3025	Kalau cerah esok, mari kita bermain tenis. 	あした　晴れだったら、　テニスを　しましょう。	\N		\N	vmod				530	1
1222	Ada pokok di taman. 	公園に　木が　あります。	null		\N	vmod				\N	1
1255	Ada taman di depan rumah saya. 	家の　前は　公園です。	null		\N	vmod				\N	1
3117	Selepas berjalan-jalan di taman, saya nak balik ke rumah. 	公園を　散歩して、　家へ　帰ります。	\N		\N	vmod				231	1
3660	Saya pergi berjalan-jalan dengan anjing saya ke taman petang ini. 	夕方　犬と　公園へ　散歩に　行きました。	\N		\N	vmod				61	1
3661	Anjing kami sangat besar. 	うちの　犬は　とても　大きいです。	\N		\N	vmod				61	1
1667	Saya menulis huruf dengan pen. 	ペンで　字を　書きます。	null		\N	vmod				\N	1
1246	Di dalam beg ada buku nota.	かばんの　中に　ノートが　あります。	null		\N	vmod				\N	1
1527	Di atas meja ada buku dan buku nota. 	机の　上に　本と　ノートが　あります。	null		\N	vmod				\N	1
3734	Saya nak buat kerja sedikit lagi dan balik. 	もう　少し　仕事を　して、　帰ります。	\N		\N	vmod				739	1
3735	Saya nak minum segelas lagi air. 	もう　一杯　水を　飲みます。	\N		\N	vmod				739	1
1434	Bilik sini sangat senyap. 	ここは　とても　静かな　部屋です。 	null		\N	vmod				\N	1
2893	Saya nak bersihkan bilik kerana kawan saya akan datang. 	友達が　来るので、　部屋を　掃除します。	\N		\N	vmod				577	1
1402	Anjing di rumah jiran tidak besar. 	となりの　家の　犬は　大きく　ありません。	null		\N	vmod				\N	1
1601	Saya akan keluar rumah pada pukul sembilan pagi. 	九時に　家を　出ます。	null		\N	vmod				\N	1
2994	Banyak deretan rumah di tepi jalan sana. 	向こうの　道に　家が　たくさん　並んで　います。	\N		\N	vmod				43	1
1254	Encik Yamada ada di luar bilik darjah. 	山田さんは　教室の　外に　います。	null		\N	vmod				\N	1
1650	Saya nak keluar dari bilik darjah. 	教室から　出ます。	null		\N	vmod				\N	1
2843	Ada meja dan kerusi di dalam bilik darjah. 	教室に　机と　いすが　あります。	\N		\N	vmod				195	1
1654	Cikgu memberi soalan.	先生から　質問を　出しました。	null		\N	vmod				\N	1
2856	Awak mesti membaca soalan dengan baik semasa menulis jawapan.	答えを　書く　ときは、　質問を　よく　読まなければ　なりません。	\N		\N	vmod				288	1
1233	Saya tidak ada wang. 	お金が　ありません。	null		\N	vmod				\N	1
2060	Kalau beli kereta, wang akan habis.	車を　買うと、　お金が　なくなります。	null		\N	vmod				\N	1
2093	Saya meminjamkan wang kepada adik lelaki saya. 	わたしは　弟に　お金を　貸して　あげました。	null		\N	vmod				\N	1
1323	Di atas meja guru ada dua buah kamus dan sebuah majalah. 	先生の　机の　上に　辞書が　二冊と　雑誌が　一冊　あります。	null		\N	vmod				\N	1
3247	Saya letakkan pasu di atas meja. 	テーブルの　上に　花瓶を　置きました。	\N		\N	vmod				71	1
3248	Ada kucing di bawah kerusi. 	いすの　下に　猫が　います。	\N		\N	vmod				286	1
1249	Ada kucing di depan rumah. 	家の　前に　猫が　います。	null		\N	vmod				\N	1
2868	Cik Matsui duduk di depan saya. 	わたしの　前に　松井さんが　座りました。	\N		\N	vmod				604	1
1258	Buku di dalam beg. 	本は　かばんの　中です。	null		\N	vmod				\N	1
1275	Ada anjing kecil di dalam kotak. 	箱の　中に　小さい　犬が　います。	null		\N	vmod				\N	1
3235	Encik Yamada ada di dalam bilik darjah. 	山田さんは　教室の　中に　います。	\N		\N	vmod				467	1
1410	Di luar sejuk? 	外は　寒いですか。	null		\N	vmod				\N	1
1734	Bolehkah saya pergi ke luar? 	外に　出ても　いいですか。	null		\N	vmod				\N	1
1247	Encik Yamada ada di sebelah kanan Encik Tanaka. 	田中さんの　右に　山田さんが　います。	null		\N	vmod				\N	1
2867	Belok ke kanan selepas selekoh seterusnya.	次の　角を　右に　曲がります。	\N		\N	vmod				618	1
1248	Cik Kimura ada di sebelah kiri Encik Tanaka.	田中さんの　左に　木村さんが　います。	null		\N	vmod				\N	1
2866	Saya pegang penyepit makanan menggunakan tangan kiri.	わたしは　左手で　はしを　持ちます。	\N		\N	vmod				544	1
1245	Ada beg di bawah meja.	机の　下に　かばんが　あります。	null		\N	vmod				\N	1
1302	Beg besar itu saya punya.	その　大きい　かばんは　わたしのです。	null		\N	vmod				\N	1
1418	Beg ini mahal.	この　かばんは　高かったです。	null		\N	vmod				\N	1
3658	Di rumah Encik Hayashi ada anjing dan kucing.	林さんの　家には　犬と　猫が　います。	\N		\N	vmod				497	1
3659	Ada kucing sedang tidur di sana.	あそこで　猫が　寝て　います。	\N		\N	vmod				497	1
1251	Peti surat ada di depan rumah saya.	ポストは　家の　向かいに　あります。	null		\N	vmod				\N	1
1531	Peti surat ada di depan pejapat pos dan dekat stesen.	郵便局の　前や　駅の　そばに　ポストが　あります。	null		\N	vmod				\N	1
3256	Bahagian utara Jepun akan sangat sejuk apabila datangnya musim sejuk.	冬に　なると、　日本の　北側は　とても　寒いです。	\N		\N	vmod				184	1
1257	Sekolah terletak di kawasan dekat dengan rumah.	学校は　家の　近くです。	null		\N	vmod				\N	1
2881	Semalam, saya pergi membeli barang di tempat berdekatan dengan stesen.	きのう　駅の　近くへ　買い物に　行きました。	\N		\N	vmod				391	1
1548	Saya sering menonton filem dan pergi ke kolam renang bersama kawan saya.	友だちと　よく　映画を　見たり　プールに　行ったり　します。	null		\N	vmod				\N	1
1778	Apa kata kalau kita pergi ke kolam renang? 	プールへ　行きませんか。	null		\N	vmod				\N	1
2923	Saya berenang di dalam kolam renang kerana panas.	暑かったので、　プールで　泳ぎました。	\N		\N	vmod				559	1
2497	Bagaimana cara untuk saya pergi ke tingkat tiga?	三階へは　どう　行けば　いいですか。			\N	vmod				\N	1
2790	Di sini adalah tingkat dua.	ここは　二階です。	\N		\N	vmod				704	1
2065	Kalau baca surat khabar setiap hari, awak boleh hafal.	毎日、　新聞を　読めば、　覚える　ことが　できますよ。	null		\N	vmod				\N	1
2971	Itu surat khabar untuk hari ini.	それは　きょうの　新聞です。	\N		\N	vmod				312	1
3680	Apabila musim panas berakhir, akan datang musim luruh.	夏が　終わると、　秋が　来ます。	\N		\N	vmod				8	1
3681	Saya lebih suka musim luruh daripada musim bunga.	わたしは　春より　秋の　ほうが　好きです。	\N		\N	vmod				8	1
1276	Encik Tanaka seseorang yang ceria.	田中さんは　元気な　人です。	null		\N	vmod				\N	1
1274	Ada sebuah komputer baru di dalam bilik darjah.	教室に　新しい　コンピューターが　あります。	null		\N	vmod				\N	1
1947	Saya dengar dari guru bahawa ada pelajar baru akan datang pada bulan depan.	先生から　聞きましたが、　来月から　新しい　生徒が　来るそうです。	null		\N	vmod				\N	1
1831	Sekarang ini saya nak sebuah komputer.	わたしは　今　コンピューターが　ほしいです。	null		\N	vmod				\N	1
3860	Saya buat kerja dengan menggunakan komputer.	コンピューターを　使って、　仕事を　します。	\N		\N	vmod				823	1
3646	Saya memasukkan buku nota dan pen ke dalam kotak.	箱の　中に　ノートや　ペンを　入れます。	\N		\N	vmod				512	1
3647	Kotak ini sangat berat.	この　箱は　とても　重いです。	\N		\N	vmod				512	1
388	田中さんが来て、木村さんが帰りました。	田中さんが来て、木村さんが帰りました。	null		\N	vmod				\N	0
3473	Haiwan yang kecil sangat comel.	小さい　動物は　とても　かわいいです。	\N		\N	vmod				387	1
3474	Rumah saya kecil dan sempit.	わたしの　うちは　小さくて、　狭いです。	\N		\N	vmod				387	1
3593	Encik Lee tidak sihat kerana selesema.	イさんは　かぜを　ひいて　いるので、　元気じゃ　ありません。	\N		\N	vmod				228	1
3594	Encik Yamada seorang yang sangat ceria.	山田さんは　とても　元気な　人です。	\N		\N	vmod				228	1
1455	Warna lukisan ini cantik.	この　絵は　色が　きれいです。	null		\N	vmod				\N	1
1860	Makanan apa yang awak suka?	すきな　食べ物は　何ですか。	null		\N	vmod				\N	1
2806	Makanan Jepun sedap tetapi mahal.	日本の　食べ物は　おいしいですが、　高いです。	\N		\N	vmod				380	1
1281	Filem lama Jepun.	日本の　古い　映画です。	null		\N	vmod				\N	1
2780	Kasut ini sudah lama.	この　靴は　古いです。	\N		\N	vmod				569	1
2023	Encik Yamada selalu ceria tetapi hari ini senyap.	山田さんは　いつも　元気ですけれども、　きょうは　静かです。	null		\N	vmod				\N	1
3518	Saya ingin pergi ke tempat yang senyap dan cantik.	わたしは　静かで、　きれいな　所へ　行きたいです。	\N		\N	vmod				285	1
3519	Encik Matsui tinggal di bandar yang kawasannya senyap.	松井さんは　静かな　町に　住んで　います。	\N		\N	vmod				285	1
1286	Awak nak beli kasut yang mana? 	どの　靴を　買いますか。	null		\N	vmod				\N	1
1477	Ini pita pelekat yang saya beli semalam.	これは　きのう　買った　テープです。	null		\N	vmod				\N	1
1640	Saya akan pergi beli kemeja.	シャツを　買いに　いきます。	null		\N	vmod				\N	1
2789	Saya sudah beli majalah di kedai buku.	本屋で　雑誌を　買いました。	\N		\N	vmod				140	1
1534	Beg yang hitam dan besar itu saya punya.	大きくて　黒い　かばんは　わたしのです。	null		\N	vmod				\N	1
1291	Itulah kamus bahasa Jepun. 	日本語の　辞書は　それです。	null		\N	vmod				\N	1
2974	Sambil melihat kamus, saya belajar bahasa Jepun.	辞書を　見て、　日本語を　勉強します。	\N		\N	vmod				284	1
1535	Saya tinggal di flat yang cantik dan senyap.	きれいで　静かな　アパートに　住んで　います。	null		\N	vmod				\N	1
3134	Air di sungai ini bersih.	この　川の　水は　きれいです。	\N		\N	vmod				200	1
3272	Perempuan yang cantik itu adalah Cik Kimura.	あの　きれいな　女の　人は　木村さんです。	\N		\N	vmod				132	1
1401	Anjing di rumah saya besar.	わたしの　家の　犬は　大きいです。	null		\N	vmod				\N	1
3472	Restoran ini besar dan cantik.	この　レストランは　大きくて、　きれいです。	\N		\N	vmod				94	1
1305	Tumpang tanya, tandas ada di mana?	すみません、　トイレは　どこですか。	null		\N	vmod				\N	1
2835	Apabila keluar dari tandas, saya membasuh tangan.	トイレから　出る　とき、　手を　洗います。	\N		\N	vmod				434	1
2170	Apakah pekerjaan awak?	あなたの　お仕事は　何ですか。	null		\N	vmod				\N	1
2234	Awak bekerja dengan rajin, ya.	あなたも　よく　働きますね。	null		\N	vmod				\N	1
3288	Sila buat kerja awak di sana.	あなたは　あっちで　仕事を　して　ください。	\N		\N	vmod				26	1
1319	Ada tujuh potong kek.	ケーキが　七つ　あります。	null		\N	vmod				\N	1
3855	Ibu saya sangat suka kek.	母は　ケーキが　大好きです。	\N		\N	vmod				829	1
3856	Pada hari jadi setiap tahun, saya akan makan kek. 	毎年　誕生日に　ケーキを　食べます。	\N		\N	vmod				829	1
2249	Sesiapa yang tidak bawa pen mata bulat, boleh menggunakan pensel.	ボールペンを　持って　こなかった　人は、　えんぴつでも　いいです。	null		\N	vmod				\N	1
3022	Saya menulis jawapan ujian dengan pen mata bulat.	テストの　答えを　ボールペンで　書きます。	\N		\N	vmod				586	1
2801	Harga jam tangan ini adalah seribu lima ratus yen.	この　時計は　千五百円です。	\N		\N	vmod				89	1
2802	Saya beli kamera dengan harga tiga puluh ribu yen.	三万円で　カメラを　買いました。	\N		\N	vmod				89	1
2965	Saya pinjam tiga buah buku di perpustakaan.	図書館で　本を　三冊　借りました。	\N		\N	vmod				270	1
2969	Majalah tidak boleh dipinjam di perpustakaan.	雑誌は　図書館で　借りる　ことが　できません。	\N		\N	vmod				271	1
2970	Majalah ini menarik.	この　雑誌は　おもしろいです。	\N		\N	vmod				271	1
3114	Awak beli berapa keping roti?	いくつ　パンを　買いましたか。	\N		\N	vmod				46	1
3115	Ada berapa cawan di atas meja?	テーブルの　上に　いくつ　コップが　ありますか。	\N		\N	vmod				46	1
3458	Sekarang pukul tujuh malam.	今、　午後　七時です。	\N		\N	vmod				239	1
3637	Saya membawa sapu tangan semasa keluar dari rumah.	出かける　とき、　ハンカチを　持って　行きます。	\N		\N	vmod				535	1
3638	Saya tertinggal sapu tangan di dalam bilik darjah semalam.	きのう　教室に　ハンカチを　忘れました。	\N		\N	vmod				535	1
2793	Ada sehelai kemeja.	シャツが　一枚　あります。	\N		\N	vmod				597	1
2794	Saya ambil dua keping gambar.	写真を　二枚　撮りました。	\N		\N	vmod				597	1
1679	Lagi sepuluh minit sebelum pukul lima.	あと　十分で　五時です。	null		\N	vmod				\N	1
3284	Sila tunggu dua minit.	二分、　待って　ください。	\N		\N	vmod				571	1
1392	Pada hari Ahad saya bermain tenis.	日曜日に　テニスを　します。	null		\N	vmod				\N	1
3285	Hari ini hari Ahad tetapi saya pergi ke syarikat.	きょうは　日曜日ですが、　会社へ　行きます。	\N		\N	vmod				489	1
2845	Saya tidak berapa suka belajar.	わたしは　勉強が　あまり　好きでは　ありません。	\N		\N	vmod				581	1
2846	Pada minggu lepas saya sibuk, jadi saya tidak boleh belajar.	先週は　忙しかったので、　勉強が　できませんでした。	\N		\N	vmod				581	1
1341	TV ada di sebelah piano.	テレビは　ピアノの　そばに　あります。	null		\N	vmod				\N	1
1630	Menonton TV adalah tidak baik untuk mata.	テレビは　目に　よくないです。	null		\N	vmod				\N	1
2192	Saya makan nasi sambil menonton TV.	テレビを　見ながら　ごはんを　食べました。	null		\N	vmod				\N	1
3006	Saya berlatih piano setiap hari.	わたしは　毎日　ピアノを　練習します。	\N		\N	vmod				759	1
1398	Kami akan membuat majlis pada hari jadi Encik Yamada	山田さんの　誕生日に　パーティーを　します。	null		\N	vmod				\N	1
3618	Majlis kahwin kakak saya diadakan pada minggu lepas. 	先週、　姉の　結婚パーティーが　ありました。	\N		\N	vmod				506	1
2991	Saya tidak hadir ke sekolah pada hari ini kerana demam.	熱が　あるので、　きょうは　学校を　休みます。	\N		\N	vmod				654	1
3133	Ada kucing di depan pintu pagar rumah.	家の　門の　前に　猫が　います。	\N		\N	vmod				646	1
3042	Pada tahun lepas, tidak banyak salji yang turun.	去年は　あまり　雪が　降りませんでした。	\N		\N	vmod				568	1
1348	Kelas akan habis pada waktu pagi esok.	あしたは　午前中で　授業が　終わります。	null		\N	vmod				\N	1
3351	Saya akan pergi makan malam selepas habis kerja.	仕事が　終わったら、　夕飯を　食べに　行きます。	\N		\N	vmod				130	1
3730	Matsui masih belum membuat kerja rumah.	松井さんは　まだ　宿題を　して　いません。	\N		\N	vmod				608	1
3731	Sekarang masih pukul sepuluh pagi.	今　まだ　十時です。	\N		\N	vmod				608	1
1367	Saya balik ke rumah.	うちへ　帰ります。	null		\N	vmod				\N	1
2178	Semasa saya sedang makan malam, kawan datang ke rumah.	わたしが　晩ごはんを　食べて　いる　とき、　友だちが　うちへ　来ました。	null		\N	vmod				\N	1
1371	Encik Yamada akan minum air coca-cola.	田中さんは　コーラを　飲みます。	null		\N	vmod				\N	1
1710	Minta dua air coca-cola.	コーラを　二つ　お願いします。	null		\N	vmod				\N	1
1818	Saya ingin minum air.	水が　飲みたいです。	null		\N	vmod				\N	1
1396	Saya tengok wayang.	映画を　見ました。	null		\N	vmod				\N	1
1378	Saya akan hantar surat kepada Encik Tanaka.	田中さんに　手紙を　出します。	null		\N	vmod				\N	1
1482	Ada ditulis di dalam surat.	手紙に　書いて　ありました。	null		\N	vmod				\N	1
1971	Sila hantar kertas yang sudah ditulis dengan jawapan.	答えを　書いた　紙を　出して　ください。	null		\N	vmod				\N	1
1379	Saya meminjamkan wang kepada Encik Yamada.	山田さんに　お金を　貸します。	null		\N	vmod				\N	1
2090	Saya meminjamkan buku nota kepada Encik Kobayashi.	わたしは　小林さんに　ノートを　貸して　あげました。	null		\N	vmod				\N	1
2092	Kimura meminjamkan buku kepada saya.	木村さんに　本を　貸して　もらいました。	null		\N	vmod				\N	1
1382	Saya meminjam wang daripada Encik Yamada.	山田さんに　お金を　借ります。	null		\N	vmod				\N	1
3852	Saya meminjam buku daripada perpustakaan dan telah membacanya.	図書館で　本を　借りて、　読みました。	\N		\N	vmod				170	1
3396	Saya belajar bahasa Jepun dengan guru itu.	わたしは　あの　先生に　日本語を　習って　います。	\N		\N	vmod				480	1
3397	Semalam Encik Lee belajar kanji daripada Encik Matsui.	きのう　イさんは　松井さんに　漢字を　習いました。	\N		\N	vmod				480	1
1614	Saya akan tampal gambar di dinding.	壁に　写真を　はります。	null		\N	vmod				\N	1
3854	Dinding bilik darjah ini tebal.	この　教室の　壁は　厚いです。	\N		\N	vmod				830	1
1386	Saya letak buku di atas meja.	机に　本を　置きます。	null		\N	vmod				\N	1
3347	Jangan letak benda di sini.	ここに　物を　置いては　いけません。	\N		\N	vmod				101	1
1625	Saya menunjukkan buku kepada Encik Tanaka.	田中さんに　本を　見せます。	null		\N	vmod				\N	1
3392	Cik Kimura menunjukkan gambar kepada saya.	木村さんは　わたしに　写真を　見せて　くれました。	\N		\N	vmod				622	1
1881	Encik Tanaka boleh bermain tenis.	田中さんは　テニスが　できます。	null		\N	vmod				\N	1
3118	Saya berlatih tenis pada setiap hari.	わたしは　毎日　テニスの　練習を　します。	\N		\N	vmod				779	1
1403	Hari ini tidak sejuk.	きょうは　寒くないです。	null		\N	vmod				\N	1
3053	Kerana malam sejuk, saya keluar dengan membawa kot.	夜は　寒いので、　コートを　持って　出かけます。	\N		\N	vmod				273	1
3508	Encik Yamada seorang yang kelakar.	山田さんは　おもしろい　人です。	\N		\N	vmod				127	1
3509	Kelas ini sangat menarik.	この　授業は　とても　おもしろいです。	\N		\N	vmod				127	1
3213	Kuih ini sedap.	この　お菓子は　おいしいです。	\N		\N	vmod				92	1
1537	Bunga ini kecil dan berwarna merah.	この　花は　小さくて　赤いです。	null		\N	vmod				\N	1
3495	Encik Yamada paling tinggi di dalam kelas.	山田さんは　クラスで　いちばん　背が　高いです。	\N		\N	vmod				367	1
3496	Saya ingin tinggal di tempat yang tinggi.	わたしは　高い　所に　住みたいです。	\N		\N	vmod				367	1
1428	Saya tidak begitu penat.	あまり　つかれませんでした。	null		\N	vmod				\N	1
3700	Kamus ini tidak begitu bagus.	この　辞書は　あまり　よくないです。	\N		\N	vmod				34	1
1426	Bilik saya tidak begitu luas.	わたしの　部屋は　あまり　広くありません。	null		\N	vmod				\N	1
1435	Cantiknya baju ini, ya.	すてきな　服ですね。	null		\N	vmod				\N	1
2130	Tumpang tanya, boleh saya cuba baju ini?	すみません、　この　服を　着て　みても　いいですか。	null		\N	vmod				\N	1
490	はい。	はい。	null		\N	vmod				\N	0
2783	Encik Matsui pakai baju putih.	松井さんは　白い　服を　着て　います。	\N		\N	vmod				561	1
3057	Orang yang berambut hitam itu adalah Encik Matsui. 	あの　髪が　黒い　人は　松井さんです。	\N		\N	vmod				764	1
1446	Ketinggian badan Tanaka tinggi.	田中さんは　背が　高いです。	null		\N	vmod				\N	1
3634	Kami beratur bermula dari ketinggian yang rendah.	背が　低い　人から　並びます。	\N		\N	vmod				331	1
3123	Brazil adalah sebuah negara yang sangat kuat dalam bola sepak.	ブラジルは　サッカーが　とても　強い　国です。	\N		\N	vmod				411	1
1450	Kepala awak sakit?	頭が　痛いですか。	null		\N	vmod				\N	1
1451	Tidak, tidak sakit.	いいえ、　痛くないです。	null		\N	vmod				\N	1
2766	Oleh sebab gigi saya sakit, saya tidak boleh makan apa-apa.	歯が　痛いので、　何も　食べられません。	\N		\N	vmod				52	1
3652	Pada bulan lepas, pusat membeli-belah telah dibuka di bandar jiran.	先月　隣の　町に　デパートが　できました。	\N		\N	vmod				609	1
3653	Saya akan tinggal di bandar ini mulai tahun depan.	わたしは　来年から　この　町に　住みます。	\N		\N	vmod				609	1
1478	Sila telefon dan tanya, sekiranya awak tidak tahu jalan.	道が　わからない　とき、　電話で　聞いて　ください。	null		\N	vmod				\N	1
2906	Oleh sebab jalan ini sangat sempit, ia berbahaya.	この　道は　とても　狭いので、　危ないです。	\N		\N	vmod				623	1
1454	Jalan di bandar ini sempit.	この　町は　道が　狭いです。	null		\N	vmod				\N	1
3245	Warna ini sangat cantik.	この　色は　とても　きれいです。	\N		\N	vmod				69	1
1457	Saya tidak pandai menyanyi lagu.	わたしは　歌が　へたです。	null		\N	vmod				\N	1
3050	Saya paling suka lagu ini. 	わたしは　この　歌が　いちばん　好きです。	\N		\N	vmod				74	1
3898	Ayah Cik Kimura berusia lima puluh dua tahun.	木村さんの　お父さんは　五十二歳です。	\N		\N	vmod				110	1
1459	Ayah Encik Yamada seorang yang berkerja dengan rajin.	山田さんは、　お父さんが　よく　働きます。	null		\N	vmod				\N	1
2992	Saya berkerja juga pada hari Ahad.	わたしは　日曜日も　働いて　います。	\N		\N	vmod				521	1
2993	Saya akan bekerja selama lapan jam setiap hari.	毎日　八時間　働きます。	\N		\N	vmod				521	1
1460	Ayah Encik Yamada seorang doktor.	山田さんは、　お父さんが　医者です。	null		\N	vmod				\N	1
3605	Kamus ini sangat ringan dan mudah diguna.	これは　とても　軽くて、　便利な　辞書です。	\N		\N	vmod				583	1
3606	Kapal terbang laju dan berguna.	飛行機は　速くて、　便利です。	\N		\N	vmod				583	1
1599	Saya baca buku.	わたしは　本を　読みました。	null		\N	vmod				\N	1
1696	Kanji ini sebutannya dibaca "yama".	この　漢字は　「やま」と　読みます。	null		\N	vmod				\N	1
3371	Saya menyanyi lagu sambil berdiri.	立って、　歌を　歌います。	\N		\N	vmod				373	1
3372	Di sana ada Cik Kimura sedang berdiri. 	あそこに　木村さんが　立って　います。	\N		\N	vmod				373	1
2894	Bilik ini tiada tingkap.	この　部屋は　窓が　ありません。	\N		\N	vmod				613	1
3331	Jangan buka tingkap di sana kerana ia berbahaya.	危ないので、　あそこの　窓を　開けては　いけません。	\N		\N	vmod				613	1
1501	\nTingkap buka.	窓が　開いて　います。	null		\N	vmod				\N	1
1921	Sekarang pukul 10, jadi pejabat pos pasti sudah buka.	今　十時ですから、　郵便局は　開いて　いる　はずです。	null		\N	vmod				\N	1
3434	Setiap pagi saya akan baca surat khabar dan pergi ke syarikat.	毎朝　新聞を　読んで、　会社へ　行きます。	\N		\N	vmod				598	1
3323	Saya berkahwin dengan isteri saya pada lima tahun yang lalu.	五年前、　妻と　結婚しました。	\N		\N	vmod				499	1
3324	Encik Lee akan ada di Jepun selama tiga tahun.	イさんは　日本に　三年　いる　つもりです。	\N		\N	vmod				499	1
3369	Encik Kobayashi tidak tahu restoran itu.	小林さんは　その　レストランを　知りませんでした。	\N		\N	vmod				308	1
3370	Saya tahu nombor telefon Encik Yamada.	わたしは　山田さんの　電話番号を　知って　います。	\N		\N	vmod				308	1
1507	Jalan ini berliku-liku.	この　道は　曲がって　います。	null		\N	vmod				\N	1
2884	Jika belok ke kiri di bangunan itu, di situ ada hospital.	その　建物を　左に　曲がると、　病院が　あります。	\N		\N	vmod				605	1
3153	Saya pergi membeli-belah dengan kawan-kawan saya pada hari cuti.	休みの　日は　友達と　買い物に　行きます。	\N		\N	vmod				139	1
3617	Saya membeli-belah di pasar raya untuk menyediakan masakan malam.	スーパーで　晩ごはんの　買い物を　しました。	\N		\N	vmod				139	1
1512	Tingkap tutup.	窓が　閉めて　あります。	null		\N	vmod				\N	1
3368	Saya tutup pintu sebaik sahaja masuk ke dalam bilik.	部屋に　入ったら、　ドアを　閉めます。	\N		\N	vmod				750	1
1513	Lampu sudah dipadamkan. 	電気が　消して　ありました。	null		\N	vmod				\N	1
2901	Saya belajar dengan memasang lampu di bilik.	部屋の　電気を　つけて　勉強します。	\N		\N	vmod				428	1
3128	Apabila keluar, saya terlupa untuk memadamkan lampu.	出かける　とき、　電気を　消すのを　忘れました。	\N		\N	vmod				222	1
3129	Saya memadamkan lampu sebelum tidur.	寝る　前に　電気を　消します。	\N		\N	vmod				222	1
1551	Esok saya akan berjumpa dengan kawan di stesen dan kami akan pergi menonton konsert bersama-sama.	あした　わたしは　駅で　友だちに　会って、　いっしょに　コンサートに　行きます。	null		\N	vmod				\N	1
2115	Saya berjalan kaki ke stesen.	駅まで　歩いて　いきます。	null		\N	vmod				\N	1
1515	Soalan ada ditulis pada muka surat lima belas. 	問題は　十五ページに　書いて　あります。	null		\N	vmod				\N	1
569	はい。	はい。	null		\N	vmod				\N	0
2857	Soalan ini sangat mudah.	この　問題は　とても　易しいです。	\N		\N	vmod				647	1
3627	Buku ini mempunyai seratus dua puluh muka surat.	この　本は　百二十ページ　あります。	\N		\N	vmod				573	1
3171	Kita menulis jawapan pada kertas ini.	この　用紙に　問題の　答えを　書きます。	\N		\N	vmod				146	1
3172	Saya menulis surat kepada kawan semalam.	きのう　友達に　手紙を　書きました。	\N		\N	vmod				146	1
2871	Saya memotong kek kepada empat bahagian menggunakan pisau.	ナイフで　ケーキを　四つに　切ります。	\N		\N	vmod				199	1
3060	Saya telah memotong rambut saya semalam.	わたしは　きのう　髪を　切りました。	\N		\N	vmod				199	1
1520	Tingkap sedang buka.	窓が　開けて　あります。	null		\N	vmod				\N	1
3328	Oleh sebab panas, saya buka tingkap.	少し　暑いので、　窓を　開けます。	\N		\N	vmod				10	1
3329	Saya buka pintu dan masuk ke dalam bilik. 	ドアを　開けて、　部屋に　入ります。	\N		\N	vmod				10	1
3168	Saya susah untuk bercakap dalam bahasa inggeris.	英語で　話すのは　難しいです。	\N		\N	vmod				526	1
3169	Encik Matsui sedang bercakap dengan Encik Kobayashi.	松井さんは　小林さんと　話して　います。	\N		\N	vmod				526	1
1532	Saya makan roti, telur dan lain-lain lagi.	パンや　卵などを　食べます。	null		\N	vmod				\N	1
1609	Saya makan roti sahaja.	パンだけ　食べました。	null		\N	vmod				\N	1
3409	Saya akan ke sekolah mulai pagi pada hari Isnin.	月曜日は　朝から　学校へ　行きます。	\N		\N	vmod				226	1
3120	Encik Matsui lebih pandai bermain besbol daripada bola sepak.	松井さんは　サッカーより　野球の　ほうが　上手です。	\N		\N	vmod				777	1
1530	Saya membeli barang di pusat membeli-belah dan pasar raya.	デパートや　スーパーで　買い物を　します。	null		\N	vmod				\N	1
3111	Saya pergi ke pasar raya untuk membeli barang.	スーパーへ　買い物に　行きます。	\N		\N	vmod				788	1
3623	Saya makan telur dengan bubuh garam.	卵に　塩を　つけて　食べます。	\N		\N	vmod				382	1
3624	Saya makan roti dan telur setiap pagi.	わたしは　毎朝　パンと　卵を　食べます。	\N		\N	vmod				382	1
3018	Saya sentiasa tidur di atas katil.	わたしは　いつも　ベッドで　寝ます。	\N		\N	vmod				575	1
1928	Rasanya ada orang yang tinggal di rumah ini.	この　家は　だれか　住んで　いそうです。	null		\N	vmod				\N	1
2030	Saya tinggal di Tokyo manakala adik lelaki saya pula tinggal di Kyoto.	わたしは　東京に　住んで　いるけれども、　弟は　京都に　住んで　います。	null		\N	vmod				\N	1
3065	Pelajar antarabangsa akan datang dari China bulan depan.	来月　中国から　留学生が　来ます。	\N		\N	vmod				681	1
3066	Orang itu adalah pelajar antarabangsa sekolah ini.	あの　人は　この　学校の　留学生です。	\N		\N	vmod				681	1
3587	Orang yang muda dan ceria itu adalah Encik Yamada.	あの　若くて、　元気な　人は　山田さんです。	\N		\N	vmod				695	1
3588	Guru di kelas sebelah masih muda.	隣の　クラスの　先生は　まだ　若いです。	\N		\N	vmod				695	1
1544	Buku ini susah kerana ada banyak tulisan kanji.	この　本は　漢字が　多くて　難しいです。	null		\N	vmod				\N	1
3135	Encik Lee boleh berbahasa Jepun.	イさんは　日本語が　できます。	\N		\N	vmod				418	1
1546	Semasa cuti musim panas, saya bermain tenis dan berenang. 	わたしは　夏休みに　テニスを　したり　泳いだり　しました。	null		\N	vmod				\N	1
2069	Saya berenang walaupun sejuk.	寒くても、　泳ぎます。	null		\N	vmod				\N	1
2189	Semasa masih muda lagi, saya sering berenang. 	若い　とき、　よく　泳ぎました。	null		\N	vmod				\N	1
1547	Pada hari Ahad, adik lelaki saya membaca buku serta menonton televisyen.	日曜日に　弟は　本を　読んだり　テレビを　見たり　して　います。	null		\N	vmod				\N	1
1549	Saya sering berulang-alik di antara Tokyo dan Osaka dengan kapal terbang. 	飛行機で　東京と　大阪を　行ったり　来たり　します。	null		\N	vmod				\N	1
1619	Saya naik kapal terbang.	飛行機に　乗ります。	null		\N	vmod				\N	1
3326	Saya akan berjumpa dengan Cik Kimura di stesen malam ini.	今晩　駅で　木村さんと　会います。	\N		\N	vmod				2	1
3327	Esok saya akan berjumpa dengan Encik Lee dan memberinya cenderamata.	あした　イさんに　会って、　お土産を　渡します。	\N		\N	vmod				2	1
1660	Ada konsert di taman	公園で　コンサートが　あります。	null		\N	vmod				\N	1
3857	Saya pergi menonton konsert bersama kawan semalam.	きのう　友達と　コンサートに　行きました。	\N		\N	vmod				832	1
1388	Saya bangun pada pukul tujuh setengah.	わたしは　七時半に　起きます。	null		\N	vmod				\N	1
2018	Saya tidak dapat bangun kerana demam.	熱が　あって、　起きられませんでした。	null		\N	vmod				\N	1
2042	Setiap pagi selepas bangun, ayah saya membaca surat khabar. 	父は　毎朝　起きると、　新聞を　読みます。	null		\N	vmod				\N	1
3863	Saya pergi ke karaoke sekali setiap minggu.	わたしは　一週間に　一回　カラオケに　行きます。	\N		\N	vmod				831	1
1553	Saya bangun pada pukul tujuh pagi, makan sarapan di kantin dan berlatih dari pukul lapan. 	朝　七時に　起きて、　食堂で　朝ごはんを　食べて、　８時から　練習します。	null		\N	vmod				\N	1
1588	Saya akan makan nasi di kantin.	食堂で　ごはんを　食べます。	null		\N	vmod				\N	1
1556	Mari kita duduk di sana dan makan bekal.	あそこに　座って、　お弁当を　食べましょう。	null		\N	vmod				\N	1
2874	Saya ingin duduk berehat kerana letih.	疲れたので、　座って　休みます。	\N		\N	vmod				330	1
1586	Saya berjalan kaki dari sekolah ke rumah.	学校から　家まで　歩きます。	null		\N	vmod				\N	1
2055	Mari kita berjalan kaki jika dekat.	近いなら　歩きましょう。	null		\N	vmod				\N	1
1558	Saya belajar bahasa Jepun dengan mendengar pita kaset.	テープを　聞いて、　日本語を　勉強します。	null		\N	vmod				\N	1
662	はい。	はい。	null		\N	vmod				\N	0
3666	Laut di sana kelihatan sangat cantik.	あそこの　海は　とても　きれいです。	\N		\N	vmod				78	1
3667	Ibu bapa saya tinggal dekat laut.	わたしの　両親は　海の　そばに　住んで　います。	\N		\N	vmod				78	1
3668	Banyak haiwan di gunung itu.	あの　山には　たくさん　動物が　います。	\N		\N	vmod				656	1
3669	Sekolah terletak berdekatan gunung itu.	学校は　あの　山の　近くに　あります。	\N		\N	vmod				656	1
3394	Saya pernah mendaki gunung itu.	わたしは　あの　山に　登った　ことが　あります。	\N		\N	vmod				501	1
3395	Saya akan mendaki gunung bersama kawan pada hujung minggu.	週末、　友達と　山に　登ります。	\N		\N	vmod				501	1
3121	Tiada perlawanan besbol kerana hujan turun.	雨が　降ったので、　野球の　試合が　ありませんでした。	\N		\N	vmod				778	1
3122	Esok akan ada perlawanan tenis.	あした　テニスの　試合が　あります。	\N		\N	vmod				790	1
1562	Kereta api terhenti kerana datangnya taufan besar.	大きい　台風が　来て、　電車が　止まりました。	null		\N	vmod				\N	1
1672	Kereta api lewat sampai kerana taufan.	台風で　電車が　遅れました。	null		\N	vmod				\N	1
2830	Kereta api ini pergi ke Tokyo.	この　電車は　東京へ　行きます。	\N		\N	vmod				429	1
3380	Lif ini berhenti dari tingkat dua sehingga tingkat sembilan.	この　エレベーターは　二階から　九階まで　止まります。	\N		\N	vmod				457	1
3381	Sebuat kereta berhenti di depan saya.	わたしの　前に　車が　止まりました。	\N		\N	vmod				457	1
1636	Bunga mekar di halaman rumah.	庭に　花が　咲きます。	null		\N	vmod				\N	1
1935	Tiada kereta di halaman rumah. Rasanya ibu saya sudah keluar.	庭に　車が　ありません。　母は　出かけて　いるようです。	null		\N	vmod				\N	1
3185	Saya bangun pagi dan membasuh muka. 	朝　起きて、　顔を　洗います。	\N		\N	vmod				143	1
3232	Saya membasuh badan di bilik mandi.	おふろで　体を　洗います。	\N		\N	vmod				36	1
2858	Ada ujian kanji setiap hari di sekolah.	学校で　毎日　漢字の　テストが　あります。	\N		\N	vmod				421	1
3068	Ujian semalam sangat susah.	きのうの　テストは　とても　難しかったです。	\N		\N	vmod				421	1
3676	Langit di bahagian timur kelihatan mendung.	東の　空が　曇って　います。	\N		\N	vmod				355	1
3677	Langit luas.	空は　広いです。	\N		\N	vmod				355	1
1592	Langit berwarna biru.	空が　青いです。	null		\N	vmod				\N	1
3236	Encik Kobayashi mempunyai payung biru.	小林さんは　青い　傘を　持って　います。	\N		\N	vmod				4	1
1862	Bagi saya, kelas saya seronok.	わたしは　授業が　楽しいです。	null		\N	vmod				\N	1
3510	Majlis semalam sangat seronok.	きのうの　パーティーは　とても　楽しかったです。	\N		\N	vmod				376	1
1990	Saya lihat Encik Tanaka berlari.	田中さんが　走って　いるのを　見ました。	null		\N	vmod				\N	1
2933	Oleh sebab kaki sakit, saya tidak boleh berlari lagi.	足が　痛いので、　もう　走れません。	\N		\N	vmod				517	1
2181	Apabila saya datang ke Jepun, saya mengambil gambar di lapangan terbang. 	日本へ　来た　とき、　空港で　写真を　撮りました。	null		\N	vmod				\N	1
3880	Saya tunjukkan gambar melancong kepada Cik Kimura.	木村さんに　旅行の　写真を　見せました。	\N		\N	vmod				297	1
2839	Saya tidak berjalan kaki ke sekolah tetapi naik bas.	学校まで　歩かないで、　バスに　乗ります。	\N		\N	vmod				504	1
3267	Emak Encik Yamada sangat pandai memasak.	山田さんの　お母さんは　料理が　とても　上手です。	\N		\N	vmod				97	1
3190	Saya tidak boleh memakai seluar ini kerana saiznya kecil.	この　ズボンは　わたしには　小さいので、　はけません。	\N		\N	vmod				326	1
3558	Saya makan nasi tiga kali setiap hari.	毎日　三回　ごはんを　食べます。	\N		\N	vmod				134	1
3559	Saya pergi ke luar negara setiap tahun sekali.	一年に　一回　海外へ　行きます。	\N		\N	vmod				134	1
3363	Ada banyak bunga yang cantik sedang mekar di taman .	公園に　きれいな　花が　たくさん　咲いて　います。	\N		\N	vmod				266	1
3364	Bunga ini mekar pada musim bunga.	この　花は　春に　なると、　咲きます。	\N		\N	vmod				266	1
1638	Saya datang ke Jepun pada lima belas hari bulan Mac tahun ini .	今年の　三月　十五日に　日本に　来ました。	null		\N	vmod				\N	1
3317	Saya akan belajar gitar mulai dari tahun ini.	わたしは　今年から　ギターを　習います。	\N		\N	vmod				247	1
3108	Saya menerima kemeja daripada kawan pada hari jadi saya.	誕生日に　友達から　シャツを　もらいました。	\N		\N	vmod				298	1
3173	Saya tidak begitu suka menulis huruf.	字を　書くのが　あまり　好きでは　ありません。	\N		\N	vmod				812	1
3174	Cik Matsui pandai menulis huruf.	松井さんは　字が　上手です。	\N		\N	vmod				812	1
3862	Semalam saya pergi ke karaoke tetapi saya tidak banyak menyanyi.	きのう　カラオケに　行きましたが、　あまり　歌いませんでした。	\N		\N	vmod				831	1
3015	Saya selalu menyanyi lagu ini di karaoke.	カラオケで　よく　この　歌を　歌います。	\N		\N	vmod				75	1
3632	Kita bercakap dengan suara perlahan kerana sudah pukul dua belas malam.	もう　夜　十二時ですから、　小さい　声で　話します。	\N		\N	vmod				235	1
3633	Suara Encik Matsui kuat.	松井さんは　声が　大きいです。	\N		\N	vmod				235	1
3257	Bilik saya terang kerana ada di bahagian selatan.	わたしの　部屋は　南側に　あるので、　明るいです。	\N		\N	vmod				628	1
1645	Ada pesawat terbang ke arah Selatan.	飛行機が　南へ　飛んで　いきます。	null		\N	vmod				\N	1
2934	Ada burung sedang terbang di langit sana. 	向こうの　空を　鳥が　飛んで　います。	\N		\N	vmod				456	1
3687	Adik perempuan saya akan masuk ke universiti tahun depan.	来年、　わたしの　妹は　大学に　入ります。	\N		\N	vmod				509	1
3688	Saya pergi membeli barang dengan kawan dan masuk ke kedai kopi.	友達と　買い物を　して、　喫茶店に　入りました。	\N		\N	vmod				509	1
3689	Setiap hari saya mandi sebelum tidur.	いつも　寝る　前に、　おふろに　入ります。	\N		\N	vmod				509	1
1668	Saya pergi ke sekolah dengan bas.	バスで　学校に　行きます。	null		\N	vmod				\N	1
1671	Saya tidak hadir ke sekolah kerana sakit.	病気で　学校を　休みました。	null		\N	vmod				\N	1
3552	Encik Lee tinggal di Jepun seorang diri.	イさんは　日本に　一人で　住んで　います。	\N		\N	vmod				548	1
3553	Ada seorang pelajar di dalam bilik darjah.	教室に　学生が　一人　います。	\N		\N	vmod				548	1
3897	Keluarga saya lima orang.	わたしの　家族は　五人です。	\N		\N	vmod				154	1
2925	Saya belajar dengan adik lelaki saya sebab dia pandai bermain bola sepak.	弟は　サッカーが　上手なので、　教えて　もらいました。	\N		\N	vmod				304	1
2926	Encik Matsui pandai memasak.	松井さんは　料理が　上手です。	\N		\N	vmod				304	1
3896	Kot ini berharga sepuluh ribu yen.	この　コートは　一万円です。	\N		\N	vmod				615	1
1682	Kami sekelas pergi jalan-jalan.	クラスで　旅行に　出かけました。	null		\N	vmod				\N	1
2842	Saya sekelas dengan Matsui.	わたしは　松井さんと　クラスが　一緒です。	\N		\N	vmod				214	1
1693	Buku nota ini berbeza daripada buku nota saya.	この　ノートは　わたしの　ノートと　違います。	null		\N	vmod				\N	1
3375	Bahasa di Jepun berbeza dengan luar negara.	日本と　外国は　ことばが　違います。	\N		\N	vmod				390	1
2180	Apabila saya datang ke Jepun, saya mengambil gambar di lapangan terbang. 	日本へ　来る　とき、　空港で　写真を　撮りました。	null		\N	vmod				\N	1
2187	Saya menelefon semasa saya berada di bilik.	部屋に　いる　とき、　電話しました。	null		\N	vmod				\N	1
2880	Saya tengok peta kerana saya tidak tahu jalan.	道が　分からなかったので、　地図を　見ました。	\N		\N	vmod				393	1
3243	Saya lebih suka warna biru daripada warna merah.	わたしは　赤より　青の　ほうが　好きです。	\N		\N	vmod				5	1
3229	Sebelum makan nasi, saya membasuh tangan.	ごはんを　食べる　前に、　手を　洗います。	\N		\N	vmod				412	1
1714	Sila tulis nama.	名前を　書いて　ください。 	null		\N	vmod				\N	1
1965	Siapakah yang menulis karangan ini?  Karangan ini tiada nama.	この　作文を　書いた　人は　誰ですか。　名前が　ありません。	null		\N	vmod				\N	1
2803	Saya terlupa nama orang itu.	あの　人の　名前を　忘れて　しまいました。	\N		\N	vmod				479	1
3390	Saya sedang menunggu bas.	わたしは　バスを　待って　います。	\N		\N	vmod				610	1
3391	Malam ini, saya akan menunggu Encik Kobayashi di stesen.	今晩、　わたしは　駅で　小林さんを　待ちます。	\N		\N	vmod				610	1
2229	Saya sudah berhenti merokok.	たばこは　やめました。	null		\N	vmod				\N	1
2982	Jangan merokok di dalam bilik ini.	この　部屋で　たばこを　吸っては　いけません。	\N		\N	vmod				378	1
3907	Bilik ini tidak boleh masuk.	この　部屋に　入っては　だめです。	\N		\N	vmod				841	1
1748	Kami sedang menggunakan komputer. Tolong jangan matikan suis.	コンピューターを　使って　います。　スイッチを　切らないで　ください。	null		\N	vmod				\N	1
3861	Saya menghidupkan suis televisyen.	テレビの　スイッチを　入れます。	\N		\N	vmod				834	1
1768	Apa kata kita bermain tenis pada petang hari Sabtu? 	土曜日の　午後、　テニスを　しませんか。	null		\N	vmod				\N	1
3244	Warna yang saya suka adalah biru.	わたしの　好きな　色は　青です。	\N		\N	vmod				3	1
3770	Entahlah, saya kurang faham.	さあ、　よく　分かりません。	\N		\N	vmod				261	1
3771	Baiklah, kita akan mulakan kelas.	さあ、　授業を　始めましょう。	\N		\N	vmod				261	1
2920	Mari kita seberang jalan dan jalan di sebelah kiri.	道を　渡って、　左側を　歩きましょう。	\N		\N	vmod				701	1
2921	Saya akan lintas jambatan untuk ke seberang sungai. 	川の　向こうへ　行きたいので、　橋を　渡ります。	\N		\N	vmod				701	1
1794	Biar saya tolong bawa bagasi itu.	その　荷物は　わたしが　持ちましょう。	null		\N	vmod				\N	1
2100	Encik Kimura tolong saya membawa bagasi. 	木村さんは　わたしの　荷物を　運んで　くれました。	null		\N	vmod				\N	1
3260	Kalau pergi ke arah barat sedikit dari sini, ada laut.	ここから　少し　西へ　行くと、　海が　あります。	\N		\N	vmod				487	1
3528	Hari ini saya akan keluar waktu lebih awal dari rumah	きょうは　早い　時間に　家を　出ます。	\N		\N	vmod				528	1
3529	Saya akan bangun awal esok pagi.	あした　朝　早く　起きます。	\N		\N	vmod				528	1
3444	Malam ini kawan akan bermalam di rumah saya.	今晩　友達が　うちに　泊まります。	\N		\N	vmod				260	1
3445	Malam ini sangat sejuk.	今晩は　とても　寒いです。	\N		\N	vmod				260	1
3826	Kita semua menyanyi lagu bersama-sama.	みんなで　いっしょに　歌を　歌います。	\N		\N	vmod				631	1
3827	Semua orang sedang menunggu guru di dalam bilik darjah.	みんなが　教室で　先生を　待って　います。	\N		\N	vmod				631	1
3828	Kami semua pelajar universiti ini.	みんな、　この　大学の　学生です。	\N		\N	vmod				631	1
2041	Lebih mudah menggunakan basikal kalau pergi ke universiti itu. 	あの　大学へ　行くなら、　自転車が　便利です。	null		\N	vmod				\N	1
2913	Saya membonceng di bahagian belakang basikal kawan saya.	友達の　自転車の　うしろに　乗りました。	\N		\N	vmod				289	1
2914	Saya akan pergi menaiki basikal walaupun hujan.	雨が　降っても、　自転車で　行きます。	\N		\N	vmod				289	1
3237	Saya beli kasut putih di pusat membeli-belah semalam.	きのう　デパートで　白い　靴を　買いました。	\N		\N	vmod				310	1
3239	Kereta Encik Tanaka putih dan besar.	田中さんの　車は　白くて　大きいです。	\N		\N	vmod				310	1
3648	Saya menulis jawapan kepada soalan pada kertas ini.	この　紙に　問題の　答えを　書きます。	\N		\N	vmod				165	1
3649	Ada  kertas dan pensel di atas meja.	机の　上に　紙と　鉛筆が　あります。	\N		\N	vmod				165	1
1849	Saya tidak suka bersukan.	わたしは　スポーツが　すきでは　ありません。	null		\N	vmod				\N	1
3119	Sukan yang saya paling suka adalah besbol.	スポーツは　野球が　いちばん　好きです。	\N		\N	vmod				325	1
3702	Encik Tanaka selalu kelihatan sibuk.	田中さんは　いつも　忙しそうです。	\N		\N	vmod				60	1
3703	Saya selalu membeli barang di pasar raya ini	わたしは　いつも　この　スーパーで　買い物を　します。	\N		\N	vmod				60	1
3583	Rak buku ini lebarnya 1 meter dan panjangnya 1.5 meter. 	この　本棚は　縦　一メートルと　横　一．五メートル　あります。	\N		\N	vmod				638	1
3584	Encik Yamada boleh berenang sepanjang seratus meter.	山田さんは　百メートル　泳げます。	\N		\N	vmod				638	1
3182	Belajar bahasa asing susah.	外国語を　勉強するのは　難しいです。	\N		\N	vmod				230	1
3183	Saya membaca buku yang ditulis dalam bahasa Jepun.	日本語で　書かれた　本を　読みます。	\N		\N	vmod				230	1
3040	Tadi hujan turun pada waktu pagi, tetapi sekarang cerah. 	朝は　雨でしたが、　今は　晴れて　います。	\N		\N	vmod				531	1
3041	Esok kalau cerah, mari kita bermain tenis. 	あした　晴れたら、　テニスを　しましょう。	\N		\N	vmod				531	1
3722	Orang yang ada di sana mungkin Encik Yamada.	あそこに　いる　人は　たぶん　山田さんです。	\N		\N	vmod				731	1
3723	Encik Hayashi mungkin tahu tentang berita itu.	林さんは　たぶん　その　ニュースを　知って　います。　	\N		\N	vmod				731	1
3093	Saya pesan makanan kepada pekerja kedai. 	店員に　食べ物を　頼みました。	\N		\N	vmod				774	1
3094	Perkerja restoran ini kelihatan sibuk.	この　レストランの　店員は　忙しそうです。	\N		\N	vmod				774	1
1919	Jam ini mesti mahal harganya.	この　時計は　きっと　高いに　ちがいありません。	null		\N	vmod				\N	1
2900	Saya lihat jam di dalam bilik darjah kerana tidak tahu pukul berapa sekarang.	時間が　分からなかったので、　教室の　時計を　見ました。	\N		\N	vmod				445	1
2079	Encik Yamada memberikan buku kepada adik perempuan saya.	山田さんは　妹に　本を　くれました。　	null		\N	vmod				\N	1
2099	Saya tolong adik perempuan saya membuat kerja rumah. 	わたしは　妹の　宿題を　見て　あげました。	null		\N	vmod				\N	1
3199	Kuih ini manis.	この　お菓子は　甘いです。	\N		\N	vmod				33	1
3656	Burung sedang minum air.	鳥が　水を　飲んで　います。	\N		\N	vmod				460	1
3657	Ada burung di atas pokok sana.	あそこの　木の　上に　鳥が　います。	\N		\N	vmod				460	1
1942	Saya dengar ada pelajar baru akan datang bulan depan.	来月から　新しい　生徒が　来るそうです。	null		\N	vmod				\N	1
3287	Saya dengar Encik Yamada akan pergi ke Tokyo bulan depan.	山田さんは　来月　東京へ　行くそうです。	\N		\N	vmod				675	1
2847	Budak-budak yang ada di sini adalah pelajar dari sekolah yang sama.	ここに　いる　子どもたちは　同じ　学校の　生徒です。	\N		\N	vmod				332	1
2848	Semasa kelas, guru bertanyakan soalan kepada pelajar.	授業中、　先生は　生徒に　質問を　しました。	\N		\N	vmod				332	1
3023	Cuaca esok adalah hujan.	あしたの　天気は　雨です。	\N		\N	vmod				427	1
3024	Cuaca hari ini sangat baik.	きょうは　とても　天気が　いいです。	\N		\N	vmod				427	1
3017	Saya ambil banyak gambar semasa melancong.	旅行で　たくさん　写真を　撮りました。	\N		\N	vmod				462	1
2854	Saya telah membaca karangan yang ditulis Encik Matsui.	わたしは　松井さんが　書いた　作文を　読みました。	\N		\N	vmod				267	1
2855	Esok saya akan hantar karangan kepada guru.	あした　先生に　作文を　出します。	\N		\N	vmod				267	1
2820	Saya minum kopi setiap pagi.	わたしは　毎朝　コーヒーを　飲みます。	\N		\N	vmod				237	1
2821	Saya lebih suka teh daripada kopi.	わたしは　コーヒーより　紅茶の　ほうが　好きです。	\N		\N	vmod				233	1
3007	Kamera ini mahal tetapi berguna.	この　カメラは　高いですが、　とても　便利です。	\N		\N	vmod				166	1
3008	Saya beli kamera baru.	新しい　カメラを　買いました。	\N		\N	vmod				166	1
3143	Saya hafal nombor yang tertulis di atas kertas.	用紙に　書いて　ある　番号を　覚えます。	\N		\N	vmod				536	1
2840	Saya tidak boleh membeli barang kerana pasar raya sudah tutup.	スーパーが　閉まって　いたので、　買い物が　できませんでした。	\N		\N	vmod				294	1
2841	Beg tidak tutup.	かばんが　閉まって　いませんでした。	\N		\N	vmod				294	1
3349	Saya tidak ingat tentang orang itu.	わたしは　あの　人の　ことを　覚えて　いませんでした。	\N		\N	vmod				124	1
3350	Saya hafal bahasa Jepun dengan menonton TV setiap hari 	毎日　テレビを　見て、　日本語を　覚えます。	\N		\N	vmod				124	1
2564	何か。	何か。			\N	vmod				\N	1
2764	Oleh sebab perut sakit, saya pergi ke hospital.	おなかが　痛いので、　病院へ　行きます。	\N		\N	vmod				117	1
3452	Pasar raya sana buka pada waktu malam juga.	あそこの　スーパーは　夜も　開いて　います。	\N		\N	vmod				673	1
3453	Walaupun sudah pukul dua belas tengah malam, saya akan belajar.	もう　夜　十二時ですが、　勉強します。	\N		\N	vmod				673	1
3839	Mari kita berehat sebentar dekat sini.	この　辺で　少し　休みましょう。	\N		\N	vmod				578	1
3840	Rumah Hayashi ada dekat sana.	あの　辺に　林さんの　家が　あります。	\N		\N	vmod				578	1
2798	Masukkan wang, kemudian tekan butang.	お金を　入れて、　ボタンを　押します。	\N		\N	vmod				106	1
3348	Kalau tekan sini, kopi akan keluar.	ここを　押すと、　コーヒーが　出ます。	\N		\N	vmod				106	1
3058	Pintu kereta api akan tutup.	電車の　ドアが　閉まります。	\N		\N	vmod				433	1
3712	Saya akan terus mula bekerja setelah tamat pengajian di universiti.	大学を　出たら、　すぐ　働きます。	\N		\N	vmod				318	1
3713	Isteri saya akan pulang sekejap lagi.	妻は　すぐに　帰って　来ます。	\N		\N	vmod				318	1
2782	Rumah baru saya sangat selesa kerana dekat dengan stesen.	新しい　うちは　駅から　近いので、　とても　便利です。	\N		\N	vmod				389	1
2056	Tak buat pun boleh kalau tidak suka.	嫌なら　やめても　いいですよ。	null		\N	vmod				\N	1
3514	Saya terdengar cerita yang tidak sedap semalam.	きのう　嫌な　話を　聞きました。	\N		\N	vmod				65	1
3515	Saya tidak suka kerja pembersihan dan mencuci pakaian.	わたしは　掃除や　洗濯を　するのが　嫌です。	\N		\N	vmod				65	1
3812	Saya memasukkan banyak susu ke dalam kopi.	わたしは　コーヒーに　たくさん　ミルクを　入れます。	\N		\N	vmod				368	1
3813	Saya telah banyak berjalan kaki pada hari ini.	きょうは　たくさん　歩きました。	\N		\N	vmod				368	1
3386	Saya beri peta bandar ini kepada Cik Kimura semalam. 	きのう　木村さんに　この　町の　地図を　渡しました。	\N		\N	vmod				700	1
3297	Jangan pergi ke sana kerana berbahaya.	危ないので、　そちらへ　行かないで　ください。	\N		\N	vmod				350	1
3298	Itu Encik Lee.	そちらは　イさんです。	\N		\N	vmod				350	1
2120	Saya akan beli minuman dan bawa ketika pergi ke sana pada minggu depan.	来週　そちらへ　行く　とき、　飲み物を　買って　いきます。　	null		\N	vmod				\N	1
3459	Saya ada masa lapang pagi ini, jadi saya membaca surat khabar, kemudian keluar dari rumah.	けさは　時間が　あるので、　新聞を　読んでから、　家を　出ます。	\N		\N	vmod				282	1
3460	Saya tidak ada masa bermain kerana sibuk bekerja.	仕事が　忙しいので、　遊ぶ　時間が　ありません。	\N		\N	vmod				282	1
3615	Semalam saya dengar berita yang menarik daripada kawan saya.	きのう　友達に　おもしろい　ニュースを　聞きました。	\N		\N	vmod				491	1
3616	Saya lihat berita di TV pagi tadi.	けさ　テレビで　ニュースを　見ました。	\N		\N	vmod				491	1
2123	Hari ini saya makan malam bersama kawan saya.	きょうは　友だちと　夕飯を　食べて　きました。	null		\N	vmod				\N	1
3217	Makan malam hari ini adalah kari.	きょうの　夕飯は　カレーです。	\N		\N	vmod				659	1
3344	Kedai itu menjual kuih-muih yang sedap.	あの　店は　おいしい　お菓子を　売って　います。	\N		\N	vmod				79	1
3346	Ini makanan yang tidak dijual di Jepun.	これは　日本で　売って　いない　食べ物です。	\N		\N	vmod				79	1
1481	Encik Kobayashi pakai kemeja biru.	小林さんは　青い　シャツを　着て　います。	null		\N	vmod				\N	1
3164	Saya pakai sut semasa pergi ke syarikat.	会社へ　行く　とき、　スーツを　着ます。	\N		\N	vmod				705	1
3415	Hari jadi ibu pada minggu lepas.	先週、　母の　誕生日でした。	\N		\N	vmod				340	1
3373	Encik Hayashi meminta Encik Tanaka membantunya bekerja.	田中さんは　林さんに　仕事を　頼まれました。	\N		\N	vmod				377	1
3374	Ibu saya selalu meminta saya membeli barang.	母は　いつも　わたしに　買い物を　頼みます。	\N		\N	vmod				377	1
3294	Bangunan itu telah dibina pada tahun 794.	あちらの　建物は　七百九十四年に　建てられました。	\N		\N	vmod				22	1
3295	Itu Encik Yamada.	あちらは　山田さんです。	\N		\N	vmod				22	1
3764	Encik Yamada ingin makan yang mana?	山田さんは　どちらを　食べたいですか。　	\N		\N	vmod				450	1
3454	Ayah bekerja dari pagi sehingga malam setiap hari.	父は　毎日　朝から　晩まで　仕事を　して　います。	\N		\N	vmod				708	1
3455	Malam semalam saya belajar sehingga lewat malam.	きのうの　晩、　遅くまで　勉強しました。	\N		\N	vmod				708	1
2206	Mata akan menjadi rabun kalau membaca buku di tempat gelap.	暗い　所で　本を　読むと、　目が　悪く　なります。	null		\N	vmod				\N	1
3476	Malam berbahaya kerana gelap.	夜は　暗いので、　危ないです。	\N		\N	vmod				7	1
1389	Saya akan tidur pada pukul sebelas.	十一時に　寝ます。	null		\N	vmod				\N	1
2899	Oleh sebab semalam penat, saya terus tidur.	きのうは　疲れて　いたので、　すぐ　寝て　しまいました。	\N		\N	vmod				498	1
2213	Apa kata kita minum teh? 	お茶でも　飲みませんか。	null		\N	vmod				\N	1
2247	Bagaimana dengan teh?	お茶など　いかがですか。	null		\N	vmod				\N	1
3893	Sepuluh hari bulan Oktober adalah hari jadi abang saya.	十月　十日は　兄の　誕生日です。	\N		\N	vmod				300	1
3479	Teh ini panas.	この　紅茶は　熱いです。	\N		\N	vmod				706	1
3480	Saya ingin minum teh yang panas.	熱い　お茶が　飲みたいです。	\N		\N	vmod				706	1
3762	Siapakah Encik Kobayashi?	小林さんは　どなたですか。　	\N		\N	vmod				453	1
3763	Siapakah cikgu yang baru?	どなたが　新しい　先生ですか。	\N		\N	vmod				453	1
1322	Saya membeli sepuluh keping setem dan tiga keping poskad.	切手を　十枚と　はがきを　三枚　買います。	null		\N	vmod				\N	1
2791	Saya hantar poskad kepada Encik Matsui.	松井さんに　はがきを　出します。	\N		\N	vmod				510	1
3456	Esok saya akan ada di sekolah pada sebelah pagi.	あしたは　午前中　学校に　います。	\N		\N	vmod				242	1
3457	Sekarang pukul tujuh pagi.	今、　午前　七時です。	\N		\N	vmod				242	1
1408	Makanan Jepun pedas?	日本の　料理は　辛いですか。	null		\N	vmod				\N	1
1409	Tidak, tidak pedas.	いいえ、　辛くないです。	null		\N	vmod				\N	1
3215	Kari ini sangat pedas.	この　カレーは　とても　辛いです。	\N		\N	vmod				168	1
3382	Saya tidak akan lupa untuk pulangkan buku esok. 	あした　忘れないで、　本を　返します。	\N		\N	vmod				697	1
3383	Saya tertinggal payung di dalam kereta api semalam.	きのう　電車に　傘を　忘れました。	\N		\N	vmod				697	1
1647	Orang nombor satu sampai nombor sepuluh, sila masuk. 	一番の　人から　十番の　人まで　入って　ください。	null		\N	vmod				\N	1
2800	Saya naik bas nombor sepuluh dari stesen.	駅から　十五番の　バスに　乗ります。	\N		\N	vmod				533	1
3279	Arak boleh diminum setelah menjadi dewasa.	大人に　なったら、　お酒を　飲む　ことが　できます。	\N		\N	vmod				116	1
3064	Saya tulis jawapan di sini.	ここに　答えを　書きます。	\N		\N	vmod				766	1
3300	Saya melancong ke luar negara pada bulan lepas.	先月　海外へ　旅行に　行きました。	\N		\N	vmod				339	1
3311	Baru sahaja saya memotong rambut bulan lepas tetapi rambut sudah panjang.	先月　髪を　切ったのに、　もう　長く　なって　しまいました。	\N		\N	vmod				339	1
2805	Hari ini saya akan makan malam di restoran.	きょうは　レストランで　晩ごはんを　食べます。	\N		\N	vmod				689	1
3853	Sebuah restoran baru dibuka berhampiran stesen.	駅の　近くに　新しい　レストランが　できました。	\N		\N	vmod				689	1
2987	Saya bekerja di syarikat kereta.	わたしは　自動車の　会社に　勤めて　います。	\N		\N	vmod				408	1
3189	Saya menanggalkan baju sejuk kerana panas.	暑いので、　セーターを　脱ぎます。	\N		\N	vmod				333	1
2958	Kawasan yang dekat dengan laut, ikannya sedap.	海に　近い　ところでは、　魚が　おいしいです。	\N		\N	vmod				264	1
3150	Saya kehilangan pasport saya di stesen.	駅で　パスポートを　なくしました。	\N		\N	vmod				807	1
3151	Pasport diperlukan apabila pergi ke luar negara.	外国へ　行く　とき、　パスポートが　要ります。	\N		\N	vmod				807	1
3226	Mata adik perempuan saya besar dan hidungnya tinggi.	妹は　目が　大きくて、　鼻が　高いです。	\N		\N	vmod				524	1
2774	Encik Matsui meminjamkan pensel kepada saya. 	松井さんに　鉛筆を　貸して　もらいました。	\N		\N	vmod				90	1
3384	Saya bertanya kepada guru kerana ada soalan yang saya kurang faham.	分からない　問題が　あるので、　先生に　聞きます。	\N		\N	vmod				696	1
3385	Encik Lee faham bahasa Jepun.	イさんは　日本語が　分かります。	\N		\N	vmod				696	1
3078	Saya risau kerana tidak ada apa-apa khabar daripada ibu.	母から　連絡が　なかったので、　心配しました。	\N		\N	vmod				768	1
3079	Semalam saya mendengar khabar daripada Encik Matsui.	きのう　松井さんから　連絡が　ありました。	\N		\N	vmod				768	1
3378	Saya mengambil apa-apa sahaja makanan yang disukai.	何でも　好きな　食べ物を　取ります。	\N		\N	vmod				752	1
3379	Saya mengambil kicap dan berikan kepada Encik Lee.	イさんに　しょうゆを　取って　あげました。	\N		\N	vmod				752	1
3879	Saya akan melancong ke luar negara selama dua minggu mulai minggu depan. 	来週から　二週間、　海外へ　旅行に　行きます。	\N		\N	vmod				301	1
3829	Encik Hayashi pernah bekerja selama satu tahun setengah di luar negara.	林さんは　一年半　海外で　働きました。	\N		\N	vmod				532	1
3830	Saya mesti keluar dari rumah kerana sudah pukul tujuh setengah.	もう　七時半なので、　家を　出なければ　なりません。　	\N		\N	vmod				532	1
3516	Ini makanan yang Kobayashi sangat suka.	これは　小林さんの　大好きな　食べ物です。	\N		\N	vmod				363	1
3517	Saya sangat suka binatang.	わたしは　動物が　大好きです。	\N		\N	vmod				363	1
3795	Saya balik bersama dengan semua.	みんなで　いっしょに　帰りました。	\N		\N	vmod				58	1
3796	Saya belajar bersama Encik Yamada di perpustakaan. 	図書館で　山田さんと　いっしょに　勉強します。	\N		\N	vmod				58	1
3797	Marilah pergi melancong bersama saya.	いっしょに　旅行に　行きませんか。	\N		\N	vmod				58	1
3098	Saya membeli beg ini dengan menggunakan kad kredit.	この　かばんは　カードで　買いました。	\N		\N	vmod				781	1
3099	Saya masukkan kad kredit ke dalam dompet.	財布に　カードを　入れます。	\N		\N	vmod				781	1
3728	Saya akan datang lagi nanti.	また　あとで　来ます。	\N		\N	vmod				607	1
3729	Saya akan bermain bersama Encik Kobayashi lagi pada minggu depan.	わたしは　来週　また　小林さんと　遊びます。	\N		\N	vmod				607	1
3704	Terima kasih atas segalanya.	いろいろ　ありがとう　ございました。	\N		\N	vmod				70	1
3875	Guru itu adalah orang yang sangat baik.	あの　先生は　大変　りっぱな　方です。	\N		\N	vmod				680	1
3876	Saya ingin menjadi orang dewasa yang baik.	りっぱな　大人に　なりたいです。	\N		\N	vmod				680	1
3477	Saya belajar di tempat yang terang.	明るい　所で　勉強します。	\N		\N	vmod				7	1
3478	Bilik darjah ini terang dan cantik.	この　教室は　明るくて、　きれいです。	\N		\N	vmod				7	1
3333	Saya mengangkat barang yang tidak diguna ke atas rak buku.	使わない　物を　本棚の　上に　上げます。	\N		\N	vmod				11	1
3208	Saya tidak makan sarapan hari ini.	きょうは　朝ごはんを　食べませんでした。	\N		\N	vmod				13	1
3216	Saya selalu makan roti pada untuk sarapan.	朝ごはんは　いつも　パンを　食べます。	\N		\N	vmod				13	1
3109	田中さんは　会社員です。	田中さんは　会社員です。	\N		\N	vmod				787	1
3429	Saya ingin pergi berenang di laut pada lusa.	あさって　海へ　泳ぎに　行こうと　思って　います。	\N		\N	vmod				14	1
3430	Lusa akan ada perlawanan besbol.	あさって　野球の　試合が　あります。	\N		\N	vmod				14	1
2851	Minggu depan saya akan pergi ke Tokyo bersama kawan dan bermain di sana.	来週、　わたしは　友達と　東京へ　遊びに　行きます。	\N		\N	vmod				18	1
1000	たいしたもんだ。	たいしたもんだ。	null		\N	vmod				\N	0
2852	Oleh sebab sudah belajar sepanjang hari semalam, hari ini saya bermain.	きのう　一日　勉強したので、　きょうは　遊びます。	\N		\N	vmod				18	1
3035	Cuaca akan mula panas apabila memasuki musim bunga.	春に　なると、　暖かく　なります。	\N		\N	vmod				19	1
3036	Saya pergi jalan-jalan kerana cuaca hari ini cukup panas.	きょうは　とても　暖かいので、　散歩に　行きます。	\N		\N	vmod				19	1
2755	Cik Kimura mempunyai otak yang sangat cerdik.	木村さんは　とても　頭が　いいです。	\N		\N	vmod				20	1
2763	Hari ini saya tidur awal kerana kepala saya sakit.	頭が　痛いので、　今晩は　早く　寝ます。	\N		\N	vmod				20	1
3486	Majalah ini tebal dan berat.	この　雑誌は　厚くて、　重いです。	\N		\N	vmod				23	1
3488	Saya makan daging yang tebal.	厚い　肉を　食べます。	\N		\N	vmod				23	1
3296	Kantin terletak di dalam bangunan sana.	食堂は　あっちの　建物に　あります。	\N		\N	vmod				24	1
3264	Sekarang kakak saya tinggal sendirian di Tokyo.	今　姉は　東京に　一人で　住んで　います。	\N		\N	vmod				28	1
3768	Gambar itu saya ambil pada bulan lepas.	あの　写真は　先月　撮りました。	\N		\N	vmod				29	1
3769	Orang itu ialah Encik Kobayashi.	あの　人は　小林さんです。	\N		\N	vmod				29	1
2997	Setiap malam, saya tidur selepas mandi. 	毎晩　シャワーを　浴びてから、　寝ます。	\N		\N	vmod				31	1
2885	Sini tidak dibenarkan masuk kerana berbahaya.	危ないので、　ここに　入っては　いけません。	\N		\N	vmod				32	1
3334	Esok Encik Hayashi ada kerja, jadi beliau tidak dapat datang.	あした　林さんは　仕事が　あるので、　来られません。	\N		\N	vmod				37	1
3335	Sekarang saya tidak ada wang.	わたしは　今　お金が　ありません。	\N		\N	vmod				37	1
3670	Ada ikan di dalam kolam.	池の　中に　魚が　います。	\N		\N	vmod				48	1
3671	Ada kolam yang besar di dalam taman.	公園に　大きな　池が　あります。	\N		\N	vmod				48	1
2767	Saya bercerita sambil duduk di kerusi.	いすに　座って、　話を　します。	\N		\N	vmod				50	1
2983	Saya tidak begitu dapat berehat kerana sibuk setiap hari.	毎日　忙しいので、　あまり　休む　ことが　できません。	\N		\N	vmod				51	1
2984	Walaupun sibuk bekerja, ianya seronok.	仕事は　忙しいですが、　おもしろいです。	\N		\N	vmod				51	1
3884	Saya membeli sekeping poskad di pejabat pos.	郵便局で　はがきを　一枚　買います。	\N		\N	vmod				53	1
3438	Hotel ini satu hari harganya 7800 yen.	この　ホテルは　一日　七千八百円です。	\N		\N	vmod				54	1
3439	Semalam hujan, jadi satu hari suntuk saya ada di rumah.	きのうは　雨だったので、　一日　家に　いました。	\N		\N	vmod				54	1
3545	Hari jadi bapa adalah pada lima hari bulan Jun.	父の　誕生日は　六月　五日です。	\N		\N	vmod				57	1
3536	Encik Tanaka beli 5 biji kek.	田中さんは　ケーキを　五つ　買いました。	\N		\N	vmod				59	1
3177	Saya tidak faham maksud kata-kata cikgu.	先生の　話は　意味が　分かりませんでした。	\N		\N	vmod				63	1
3178	Saya mengajar maksud perkataan ini kepada Encik Lee.	イさんに　この　ことばの　意味を　教えました。	\N		\N	vmod				63	1
2836	Saya menunjukkan tiket di pintu masuk stesen.	駅の　入口で　切符を　見せます。	\N		\N	vmod				66	1
3254	Ada anjing dan kucing di rumah saya.	うちに　犬と　猫が　います。	\N		\N	vmod				754	1
3255	Encik Lee sekarang ada di perpustakaan.	イさんは　今　図書館に　います。	\N		\N	vmod				754	1
3338	Saya perlu kamus kerana saya akan tulis karangan dalam kelas esok.	あした　授業で　作文を　書くので、　辞書が　要ります。	\N		\N	vmod				67	1
3339	Kita perlu tiket bila naik kereta api.	電車に　乗る　とき、　切符が　要ります。	\N		\N	vmod				67	1
2761	Ada pasar raya di belakang stesen.	駅の　うしろに　スーパーが　あります。	\N		\N	vmod				72	1
2869	Ramai orang berbaris di belakang saya.	わたしの　うしろに　たくさんの　人たちが　並んで　います。	\N		\N	vmod				72	1
3489	Saya beli sebuah kamus yang nipis.	薄い　辞書を　買いました。	\N		\N	vmod				73	1
3490	Oleh sebab dinding bilik ini nipis, kita bercakap dengan suara yang perlahan.	この　部屋の　壁は　薄いので、　小さい　声で　話します。	\N		\N	vmod				73	1
3342	Tempat lahir Tanaka ialah Tokyo.	田中さんの　生まれた　所は　東京です。	\N		\N	vmod				77	1
3343	Saya lahir pada 26 hari bulan Ogos.	わたしは　八月　二十六日に　生まれました。	\N		\N	vmod				77	1
3522	Anjing di rumah jiran bising, jadi saya tidak boleh belajar.	隣の　家の　犬が　うるさいので、　勉強できません。	\N		\N	vmod				80	1
3523	Orang itu sentiasa bising semasa kelas.	授業中、　あの　人は　いつも　うるさいです。	\N		\N	vmod				80	1
3187	Saya keluar dengan bawa kot.	上着を　持って　出かけます。	\N		\N	vmod				81	1
3644	Saya pergi ke pawagam menonton filem bersama Encik Lee pada minggu lepas.	先週、　イさんと　映画館へ　行って、　映画を　見ました。	\N		\N	vmod				84	1
3645	Pawagam itu baru dan cantik.	あの　映画館は　新しくて、　きれいです。	\N		\N	vmod				84	1
3798	Beg yang besar senang diguna.	大きな　かばんは　便利です。	\N		\N	vmod				95	1
3799	Encik Tanaka tinggal di rumah yang besar.	田中さんは　大きな　家に　住んで　います。	\N		\N	vmod				95	1
5	春です。	春です。	null		\N	vmod				\N	0
3808	Ramai orang sedang berenang di laut.	海で　大勢の　人が　泳いで　います。	\N		\N	vmod				96	1
3809	Ramai orang yang datang ke parti.	パーティーに　人が　大勢　来ました。	\N		\N	vmod				96	1
3209	Cik Kimura berikan kuih kepada saya.	木村さんは　わたしに　お菓子を　くれました。	\N		\N	vmod				98	1
3265	Isteri Encik Tanaka adalah seorang pensyarah di universiti.	田中さんの　奥さんは　大学の　先生です。	\N		\N	vmod				102	1
3275	Pak cik gerai sayur itu sentiasa kelihatan ceria.	あの　八百屋の　おじさんは　いつも　元気です。	\N		\N	vmod				103	1
3277	Saya menunjukkan jalan kepada datuk.	わたしは　おじいさんに　道を　教えて　あげました。	\N		\N	vmod				104	1
2834	Tandas ada di tingkat dua.	お手洗いは　二階に　あります。	\N		\N	vmod				109	1
3282	Lekaki itu tinggi dan berkaki panjang.	あの　男の　人は　背が　高くて、　足が　長いです。	\N		\N	vmod				112	1
3283	Ada budak lelaki sedang memanjat pokok di sana. 	あそこで　男の子が　木に　登って　います。	\N		\N	vmod				113	1
3421	Saya beli kasut baru di pusat membeli-belah dua hari lepas.	おととい　デパートで　新しい　靴を　買いました。	\N		\N	vmod				114	1
3422	Salji turun kerana cuaca sejuk dua hari lepas.	おととい　寒かったので、　雪が　降りました。	\N		\N	vmod				114	1
3314	Saya mendaki gunung ini dua tahun lepas.	わたしは　おととし　この　山に　登りました。	\N		\N	vmod				115	1
3315	Encik Tanaka sudah keluar dari universiti dua tahun lepas.	田中さんは　おととし　大学を　出ました。	\N		\N	vmod				115	1
3266	Abang Encik Lee akan datang bermain di Jepun pada minggu depan.	来週　イさんの　お兄さんが　日本へ　遊びに　来ます。	\N		\N	vmod				119	1
3261	Kakak Cik Kimura seorang yang sangat cantik.	木村さんの　お姉さんは　とても　きれいな　人です。	\N		\N	vmod				120	1
3276	Ibu saudara Encik Kobayashi tinggal di Tokyo.	小林さんの　おばさんは　東京に　住んで　います。	\N		\N	vmod				121	1
3278	Nenek Encik Hayashi memakai cermin mata.	林さんの　おばあさんは　眼鏡を　かけて　います。	\N		\N	vmod				122	1
1745	Jangan mandi hari ini.	きょうは　おふろに　入らないで　ください。	null		\N	vmod				\N	1
2779	Saya makan malam, mandi kemudian tidur.	夕飯を　食べて、　おふろに　入って、　寝ます。	\N		\N	vmod				123	1
2879	Pegawai polis memberitahu saya jalan ke stesen.	おまわりさんが　駅までの　道を　教えて　くれました。	\N		\N	vmod				125	1
3491	Kotak yang berat dibawa oleh lelaki.	重い　箱は　男の　人が　持ちます。	\N		\N	vmod				126	1
3492	Beg ini besar dan berat.	この　かばんは　大きくて、　重いです。	\N		\N	vmod				126	1
2838	Kalau nak ke kedutaan, awak turun di stesen seterusnya.	大使館へ　行くなら、　次の　駅で　降ります。	\N		\N	vmod				129	1
3274	Ada budak perempuan yang kecil di sana.	あそこに　小さい　女の子が　います。	\N		\N	vmod				133	1
2939	Esok saya akan berjumpa dengan kawan yang merupakan warga asing	あした　外国人の　友達と　会います。	\N		\N	vmod				136	1
3146	Bercakap dengan warga asing sangat seronok	外国人と　話すのは　とても　楽しいです。	\N		\N	vmod				136	1
2833	Saya tidak naik lif tetapi saya guna tangga.	エレベーターに　乗らないで、　階段を　使います。	\N		\N	vmod				88	1
3130	Sudah masanya saya balik ke rumah hari ini.	きょうは　もう　家へ　帰ります。	\N		\N	vmod				142	1
3352	Kalau surat dihantar melalui laut, ianya mengambil masa yang sangat lama.	船便で　手紙を　出すと、　とても　時間が　かかります。	\N		\N	vmod				144	1
3353	Dari stesen untuk sampai ke hospital mengambil masa sepuluh minit dengan menaiki bas.	駅から　病院まで　バスで　十分　かかります。	\N		\N	vmod				144	1
3131	Semalam saya kehilangan kunci.	きのう　かぎを　なくして　しまいました。	\N		\N	vmod				145	1
3132	Ini kunci rumah saya.	これは　わたしの　家の　かぎです。	\N		\N	vmod				145	1
3305	Saya belajar bahasa Inggeris selama tiga bulan di Amerika.	アメリカで　英語を　三か月　勉強しました。	\N		\N	vmod				148	1
3310	Encik Hayashi akan pergi bekerja di luar negara selama satu bulan mulai minggu depan.	来週から　一か月、　林さんは　仕事で　海外へ　行きます。	\N		\N	vmod				148	1
3194	Oleh sebab mata tidak bagus saya memakai cermin mata.	目が　悪いので、　眼鏡を　かけます。	\N		\N	vmod				150	1
2786	Saya tertinggal payung di dalam kereta api.	電車に　傘を　忘れて　しまいました。	\N		\N	vmod				151	1
3030	Hari ini tiada angin bertiup.	きょうは　風が　ありません。	\N		\N	vmod				711	1
3052	Kita tidak boleh bermain tenis pada hari angin bertiup kuat.	風が　強い　日は　テニスが　できません。	\N		\N	vmod				711	1
3145	Orang itu guru sekolah ini. 	あの　方は　この　学校の　先生です。	\N		\N	vmod				155	1
3179	Ada banyak perkataan tulisan katakana dalam bahasa Jepun.	日本語には　かたかなの　ことばが　たくさん　あります。	\N		\N	vmod				156	1
3306	Hari jadi Encik Matsui adalah pada bulan Ogos.	松井さんの　誕生日は　八月です。	\N		\N	vmod				157	1
3307	Esok adalah satu hari bulan April.	あしたは　四月　一日です。	\N		\N	vmod				157	1
2825	Saya dapat cawan yang comel daripada kawan.	友達に　かわいい　カップを　もらいました。	\N		\N	vmod				159	1
3002	Makanan ini boleh dibuat di rumah.	この　料理は　家庭で　作れます。	\N		\N	vmod				160	1
3249	Kalau belok ke kanan di penjuru sana, akan ada pasar raya.	あそこの　角を　右に　曲がると、　スーパーが　あります。	\N		\N	vmod				161	1
2902	Ada pasu bunga yang diletakkan di pintu masuk rumah.	玄関に　花瓶が　置いて　あります。	\N		\N	vmod				163	1
3878	Jangan pakai topi semasa kelas.	授業中、　帽子を　かぶっては　いけません。	\N		\N	vmod				164	1
3048	Semalam sepanjang hari mendung.	きのうは　ずっと　曇って　いました。	\N		\N	vmod				212	1
3410	Awak mesti memulangkan buku sampai hari Selasa.	火曜日までに　本を　返さなければ　なりません。	\N		\N	vmod				167	1
3221	Adik lelaki saya mempunyai badan yang kuat.	弟は　とても　体が　丈夫です。	\N		\N	vmod				169	1
3831	Encik Lee nak cuba bermain tenis.	イさんは　テニスを　やりたがって　います。	\N		\N	vmod				171	1
1113	言うのです。	言うのです。	null		\N	vmod				\N	0
3832	Kanak-kanak nak kuih.	子供が　お菓子を　欲しがって　います。	\N		\N	vmod				171	1
3493	Saya nak kasut yang ringan.	わたしは　軽い　靴が　欲しいです。	\N		\N	vmod				172	1
3494	Bagasi Cik Kimura kecil dan ringan.	木村さんの　荷物は　小さくて、　軽いです。	\N		\N	vmod				172	1
2809	Untuk makan malam hari ini, saya rasa nak masak kari .	きょうの　夕飯は　カレーを　作ろうと　思います。	\N		\N	vmod				173	1
2810	Kari adalah makanan India.	カレーは　インドの　食べ物です。	\N		\N	vmod				173	1
2895	Ada kalendar yang diletakkan di atas meja.	机の　上に　カレンダーが　置いて　あります。	\N		\N	vmod				174	1
2896	Saya beli kalendar untuk tahun depan di pusat membeli-belah.	デパートで　来年の　カレンダーを　買いました。	\N		\N	vmod				174	1
2915	Semalam saya dan kawan pergi ke sungai dan kami bermain bersama.	きのう　友達と　川へ　行って、　遊びました。	\N		\N	vmod				175	1
2916	Rumah saya terletak di sebalik sungai sana.	うちは　あの　川の　向こうに　あります。	\N		\N	vmod				175	1
3250	Beg ini ada poket di sebelah luar.	この　かばんは　外側に　ポケットが　あります。	\N		\N	vmod				176	1
3251	Tandas terletak di sebelah kiri koridor.	トイレは　廊下の　左側に　あります。	\N		\N	vmod				176	1
3585	Saya suka haiwan yang kecil dan comel.	わたしは　小さくて、　かわいい　動物が　好きです。	\N		\N	vmod				177	1
3586	Cik Kimura sangat comel.	木村さんは　とても　かわいいです。	\N		\N	vmod				177	1
3674	Semalam saya potong pokok.	きのう　木を　切りました。	\N		\N	vmod				179	1
3675	Di halaman rumah Encik Tanaka ada pokok dan bunga.	田中さんの　家の　庭に　木や　花が　あります。　	\N		\N	vmod				179	1
3246	Saya menerima sapu tangan berwarna kuning semasa hari jadi.	誕生日に　黄色の　ハンカチを　もらいました。	\N		\N	vmod				180	1
3238	Orang yang memakai kemeja kuning adalah Encik Hayashi.	黄色い　シャツを　着て　いる　人は　林さんです。	\N		\N	vmod				181	1
3356	Pemanas mati, jadi segera saya menghidupkannya.	ストーブが　消えたので、　すぐ　つけました。	\N		\N	vmod				182	1
3357	Lampu di bilik mati.	部屋の　電気が　消えて　しまいました。	\N		\N	vmod				182	1
2882	Saya bertanya kepada Encik Matsui tentang nombor telefon restoran yang akan saya pergi malam ini.	松井さんに　今夜　行く　レストランの　電話番号を　聞きました。	\N		\N	vmod				183	1
3005	Encik Matsui boleh bermain gitar.	松井さんは　ギターを　弾く　ことが　できます。	\N		\N	vmod				185	1
3126	Saya bersihkan bilik kerana kotor.	部屋が　汚いので、　掃除します。	\N		\N	vmod				791	1
3127	Laut dekat sini kotor.	この　辺の　海は　汚いです。	\N		\N	vmod				791	1
2819	Selepas habis sekolah, saya dan kawan minum teh di kedai kopi.	学校が　終わってから、　友達と　喫茶店で　お茶を　飲みました。	\N		\N	vmod				187	1
2832	Kita membeli tiket semasa menaiki kereta api.	電車に　乗る　とき、　切符を　買います。	\N		\N	vmod				189	1
3423	Sebuah restoran baru buka di depan stesen semalam.	きのう　駅前に　新しい　レストランが　できました。	\N		\N	vmod				190	1
3424	Semalam, saya hantar surat kepada ibu saya.	きのう　母に　手紙を　出しました。	\N		\N	vmod				190	1
3892	Adik lelaki saya berumur sembilan tahun.	わたしの　弟は　九歳です。	\N		\N	vmod				204	1
3916	Saya pergi ke syarikat setiap hari pada pukul sembilan pagi.	毎朝　九時に　会社へ　行きます。	\N		\N	vmod				0	1
2955	Daging lembu adalah paling mahal di antara semua jenis daging.	牛肉は　肉の　中で　一番　高いです。	\N		\N	vmod				192	1
2822	Saya tidak suka susu lembu, jadi saya jarang meminumnya.	わたしは　牛乳が　嫌いなので、　あまり　飲みません。	\N		\N	vmod				193	1
3271	Saya ada tiga adik-beradik.	わたしは　兄弟が　二人　います。	\N		\N	vmod				196	1
3011	Oleh sebab Encik Matsui tidak suka rokok, beliau tidak merokok.	松井さんは　たばこが　嫌いなので、　吸いません。	\N		\N	vmod				198	1
3012	Saya tidak suka kerja pembersihan dan mencuci pakaian.	わたしは　掃除や　洗濯が　嫌いです。	\N		\N	vmod				198	1
3577	Berat saya empat puluh lima kilogram sekarang.	今　わたしは　四十五キログラム　あります。	\N		\N	vmod				201	1
3578	Beg ini beratnya lima kilogram, jadi ianya berat.	この　荷物は　五キロ　あるので、　重いです。	\N		\N	vmod				201	1
2795	Bank buka dari pukul sembilan pagi hingga tiga petang.	銀行は　午前　九時から　午後　三時までです。	\N		\N	vmod				202	1
3136	Saya meminjam wang dari bank.	銀行で　お金を　借ります。	\N		\N	vmod				202	1
2751	Saya terkena selesema, jadi saya makan ubat.	かぜを　ひいたので、　薬を　飲みます。	\N		\N	vmod				205	1
2961	Setiap pagi saya makan sayur dan buah. 	わたしは　毎朝　野菜と　果物を　食べます。	\N		\N	vmod				206	1
3227	Saya tidak boleh buka mulut kerana gigi sakit.	歯が　痛いので、　口を　開ける　ことが　できません。	\N		\N	vmod				207	1
3147	Saya datang ke negara ini tiga tahun yang lalu.	三年前　この　国へ　来ました。	\N		\N	vmod				210	1
3026	Saya dengar esok akan mendung.	あしたは　曇りだそうです。	\N		\N	vmod				211	1
3027	Semalam sepanjang hari mendung.	きのうは　ずっと　曇りでした。	\N		\N	vmod				211	1
3047	Langit menjadi sedikit mendung	空が　少し　曇って　きました。	\N		\N	vmod				212	1
3833	Saya sudah siapkan kerja rumah kira-kira separuh.	宿題が　半分くらい　終わりました。	\N		\N	vmod				213	1
3834	Berat telur kira-kira lima puluh gram sebiji.	卵は　一個　五十グラムぐらいです。	\N		\N	vmod				213	1
3581	Saya masukkkan tiga puluh gram gula dan lima belas gram garam.	砂糖を　三十グラムと　塩を　十五グラム　入れます。	\N		\N	vmod				215	1
3582	Saya membeli dua ratus gram daging babi.	豚肉を　二百グラム　買います。	\N		\N	vmod				215	1
3240	Semasa saya pergi ke syarikat, saya memakai sut berwarna hitam.	会社へ　行く　とき、　黒の　スーツを　着ます。	\N		\N	vmod				218	1
2877	Ada ramai anggota polis di persimpangan.	交差点に　警官が　たくさん　います。	\N		\N	vmod				220	1
2878	Anggota polis bertanyakan nama saya. 	わたしは　警官に　名前を　聞かれました。	\N		\N	vmod				220	1
3442	Saya keluar dari rumah tanpa makan nasi pagi tadi. 	けさ　ごはんを　食べないで、　家を　出ました。	\N		\N	vmod				221	1
3443	Cuaca pagi ini cerah. 	けさは　いい　天気です。	\N		\N	vmod				221	1
3361	Pada musim bunga tahun depan, kakak akan berkahwin.	来年の　春、　姉が　結婚します。	\N		\N	vmod				225	1
3362	Encik Tanaka sudah berkahwin dan mempunyai anak.	田中さんは　結婚して、　子供が　います。	\N		\N	vmod				225	1
2776	Saya membersihkan koridor dan pintu masuk rumah.	玄関や　廊下を　掃除します。	\N		\N	vmod				227	1
2777	Ada pasu bunga diletakkan di pintu masuk rumah.	玄関に　花瓶が　置いて　あります。	\N		\N	vmod				227	1
3560	Masakan ini menggunakan dua biji telur.	この　料理は　卵を　二個　使います。	\N		\N	vmod				229	1
3561	Saya makan satu biji kuih yang saya terima daripada Encik Lee.	イさんから　もらった　お菓子を　一個　食べました。	\N		\N	vmod				229	1
2907	Lintas persimpangan sana, kemudian belok ke kiri.	あの　交差点を　渡って、　左に　曲がります。	\N		\N	vmod				232	1
2875	Saya bertanya jalan kepada anggota polis di pondok polis.	交番で　おまわりさんに　道を　聞きました。	\N		\N	vmod				234	1
2876	Ada peta bandar dilekat di pondok polis.	交番に　町の　地図が　はって　あります。	\N		\N	vmod				234	1
3188	Oleh sebab sejuk di luar, saya memakai kot dan pergi ke syarikat.	外は　寒いので、　コートを　着て、　会社へ　行きます。	\N		\N	vmod				236	1
3549	Ibu bapa akan datang melawat rumah saya pada sembilan hari bulan bulan depan.	来月　九日に　両親が　わたしの　うちへ　遊びに　来ます。	\N		\N	vmod				240	1
3540	Di dalam bilik darjah ini ada sembilan buah beg.	この　教室に　かばんが　九つ　あります。	\N		\N	vmod				241	1
2863	Saya tidak dapat menjawab soalan kerana ianya susah.	問題が　難しかったので、　答える　ことが　できませんでした。	\N		\N	vmod				243	1
2824	Selepas minum, saya basuh gelas sehingga bersih.	飲んだら、　コップを　きれいに　洗います。	\N		\N	vmod				246	1
3184	Apabila ada makna perkataan yang tidak jelas, saya menggunakan kamus. 	ことばの　意味が　分からない　とき、　辞書を　使います。	\N		\N	vmod				248	1
3273	Ada kanak-kanak sedang bermain di taman.	子どもが　公園で　遊んで　います。	\N		\N	vmod				249	1
2807	Saya suka kedua-dua roti dan nasi.	わたしは　パンも　ごはんも　好きです。	\N		\N	vmod				251	1
2808	Malam ini saya akan makan nasi di rumah kawan.	今晩は　友達の　うちで　ごはんを　食べます。	\N		\N	vmod				251	1
2973	Saya membuat salinan ini sebanyak lima helai.	これを　五枚　コピーします。	\N		\N	vmod				253	1
2975	Saya membuat salinan buku di perpustakaan.	図書館で　本を　コピーしました。	\N		\N	vmod				253	1
3835	Encik Tanaka akan tiba di stesen dalam lebih kurang pukul sepuluh.	田中さんは　十時ごろ　駅に　着きます。	\N		\N	vmod				256	1
3836	Semasa saya masih kanak-kanak, saya selalu bermain di taman itu.	わたしは　子どもの　ころ、　よく　あの　公園で　遊びました。	\N		\N	vmod				256	1
3416	Kelas bahasa Jepun tidak ada pada minggu ini.	今週、　日本語の　授業は　休みです。	\N		\N	vmod				258	1
3686	Ada sebanyak empat ujian pada minggu ini.	今週、　テストが　四つも　ありました。	\N		\N	vmod				258	1
3790	Saya mencari dompet berwarna hitam seperti ini.	こんな　黒い　財布を　探して　います。	\N		\N	vmod				259	1
3791	Saya mahukan topi seperti ini.	わたしは　こんな　帽子が　欲しいです。	\N		\N	vmod				259	1
3562	Di Jepun, umur yang dibenarkan memandu adalah lapan belas tahun.	日本では　十八歳から　運転が　できます。	\N		\N	vmod				262	1
3563	Adik perempuan saya berumur empat tahun.	わたしの　妹は　四歳です。	\N		\N	vmod				262	1
2787	Semalam saya beli dompet yang baru.	きのう、　新しい　財布を　買いました。	\N		\N	vmod				263	1
3465	Apabila pulang ke rumah, saya akan mandi dulu.	家へ　帰ったら、　先に　シャワーを　浴びます。	\N		\N	vmod				265	1
3466	Apabila hendak menaiki kereta api, biarlah orang turun dulu.	電車に　乗る　ときは、　降りる　人が　先です。	\N		\N	vmod				265	1
3366	Oleh sebab hujan turun, saya berpayung pergi ke sekolah.	雨が　降って　いるので、　傘を　さして、　学校へ　行きます。	\N		\N	vmod				269	1
2826	Saya memasukkan gula dan minum kopi.	わたしは　砂糖を　入れて、　コーヒーを　飲みます。	\N		\N	vmod				272	1
3320	Dua tahun akan datang saya akan pulang ke negara asal.	さ来年　国へ　帰ります。	\N		\N	vmod				275	1
3321	Saya dengar perpustakaan akan siap di sana dua tahun akan datang.	さ来年　あそこに　図書館が　できるそうです。	\N		\N	vmod				275	1
3886	Rumah saya ada tiga buah TV.	うちには　テレビが　三台　あります。	\N		\N	vmod				734	1
3280	Encik Matsui dan Encik Lee berkawan.	松井さんと　イさんは　友達です。	\N		\N	vmod				276	1
2918	Saya pergi berjalan-jalan setiap pagi.	わたしは　毎朝　散歩に　行きます。	\N		\N	vmod				277	1
3887	"4" dibaca sebagai "empat".. 	「四」は　「よん」と　読みます。	\N		\N	vmod				735	1
3913	B: Satu, dua, tiga, empat….	B ： 一、　二、　三、　四…。	\N		\N	vmod				278	1
3914	A: Ada berapa?	A ： いくつ　ありますか。	\N		\N	vmod				278	1
3219	Saya ambilkan garam untuk Encik Lee.	イさんに　塩を　取って　あげました。	\N		\N	vmod				280	1
3220	Saya memasak dengan masukkan gula dan garam.	砂糖と　塩を　入れて、　料理を　作ります。	\N		\N	vmod				280	1
3692	Saya ingin berehat sepanjang hari esok.  Tetapi saya harus pergi ke sekolah.	あしたは　一日　休みたいです。　しかし、　学校へ　行かなければ　なりません。	\N		\N	vmod				281	1
3693	Setiap hari sibuk tetapi sangat seronok.	毎日　忙しいです。　しかし、　大変　楽しいです。	\N		\N	vmod				281	1
3890	Cuaca akan beransur panas apabila masuk bulan tujuh.	七月に　なると、　だんだん　暑く　なります。	\N		\N	vmod				287	1
3915	Ada tujuh biji telur di dalam peti sejuk.	冷蔵庫の　中に　卵が　七個　あります。	\N		\N	vmod				737	1
2909	Kereta buatan Jepun dijual di luar negara.	外国で　日本の　自動車が　売られて　います。	\N		\N	vmod				290	1
2753	Ramai orang yang mati.	人が　大勢　死にました。	\N		\N	vmod				291	1
2996	Oleh sebab panas, saya balik ke rumah dan mandi.	暑かったので、　家へ　帰って、　シャワーを　浴びました。	\N		\N	vmod				299	1
3462	Semasa kelas kita mesti mendengar cakap guru.	授業中は　先生の　話を　よく　聞かなければ　なりません。	\N		\N	vmod				397	1
3595	Jika makan banyak nasi, badan akan jadi kuat.	たくさん　ごはんを　食べれば、　丈夫な　体に　なります。	\N		\N	vmod				305	1
3596	Encik Yamada kuat dan sihat.	山田さんは　丈夫で　元気です。	\N		\N	vmod				305	1
3202	Saya makan sashimi dengan cicah kicap. 	しょうゆを　つけて、　さしみを　食べます。	\N		\N	vmod				306	1
3881	Saya paling suka warna putih. 	わたしは　色で　いちばん　白が　好きです。	\N		\N	vmod				309	1
2988	Saya menghisap rokok.	わたしは　たばこを　吸います。	\N		\N	vmod				314	1
2989	Menghisap rokok tidak baik untuk kesihatan.	たばこを　吸うと、　体に　悪いです。	\N		\N	vmod				314	1
3192	Cik Kobayashi lebih suka seluar daripada skirt.	小林さんは　スカートより　ズボンの　ほうが　好きです。	\N		\N	vmod				315	1
3837	Kelas selalunya akan mula dalam pukul sembilan lebih.	いつも　九時すぎに　授業が　始まります。	\N		\N	vmod				317	1
3838	Sekarang pukul dua belas lebih.	今　十二時すぎです。	\N		\N	vmod				317	1
3526	Saya ingin pergi ke tempat yang orangnya sedikt.	人が　少ない　所へ　行きたいです。	\N		\N	vmod				319	1
3527	Pasar raya sana ikannya sedikit.	あそこの　スーパーは　魚が　少ないです。	\N		\N	vmod				319	1
3038	Apabila tingkap dibuka, jadi sejuk sedikit.	窓を　開けたら、　少し　涼しく　なりました。	\N		\N	vmod				321	1
3039	Musim luruh sejuk.\n	秋は　涼しいです。	\N		\N	vmod				321	1
3818	Kalau belajar, awak akan pandai berbahasa Jepun sedikit demi sedikit.	勉強すれば、　少しずつ　日本語が　上手に　なるでしょう。	\N		\N	vmod				322	1
3819	Sila ambil kertas satu demi satu.	紙を　一枚ずつ　取って　ください。	\N		\N	vmod				322	1
3019	Apabila pemanas dibuka, akan rasa panas.	ストーブを　つけると、　暖かいです。	\N		\N	vmod				323	1
3021	Saya tutup pemanas sebelum tidur.	寝る　前に　ストーブを　消します。	\N		\N	vmod				323	1
2812	Letakkan gula dalam kopi dengan sudu.	スプーンで　コーヒーに　砂糖を　入れます。	\N		\N	vmod				324	1
3193	Saya menanggalkan kasut dan memakai selipar.	靴を　脱いで、　スリッパを　はきます。	\N		\N	vmod				328	1
3640	Saya basuh tangan dengan sabun.	せっけんで　手を　洗いました。	\N		\N	vmod				334	1
3641	Tiada sabun di bilik mandi.	おふろに　せっけんが　ありません。	\N		\N	vmod				334	1
3883	"Kosong" adalah sama dengan "sifar".	ゼロは　零と　同じです。	\N		\N	vmod				337	1
3895	Saya meminjam seribu yen daripada Encik Yamada semalam.	きのう　わたしは　山田さんに　千円　借りました。	\N		\N	vmod				338	1
2995	Esok pagi saya mesti mencuci pakaian saya.	あしたの　朝　洗濯を　しなければ　なりません。	\N		\N	vmod				342	1
2999	Esok pagi saya mesti mencuci pakaian saya.	あしたの　朝　洗濯しなければ　なりません。	\N		\N	vmod				343	1
2998	Selepas balik, saya nak membersihkan rumah.	家へ　帰ったら、　掃除しようと　思います。	\N		\N	vmod				347	1
3696	Nasi di kantin murah dan sedap.	食堂の　ごはんは　安いです。　そして、　おいしいです。	\N		\N	vmod				348	1
3697	Saya keluar dari rumah pukul lapan dan menaiki bas pergi ke sekolah.	八時に　うちを　出ます。　そして、　バスで　学校へ　行きます。	\N		\N	vmod				348	1
2889	Rumah Encik Matsui dekat dengan rumah saya.	松井さんの　うちは　わたしの　うちの　そばです。	\N		\N	vmod				354	1
2890	Beg yang terletak dekat dengan saya sudah diberikan kepada Encik Matsui.	わたしの　そばに　置いて　あった　かばんを　松井さんに　渡しました。	\N		\N	vmod				354	1
3872	Kelas hari ini sampai di sini sahaja. Baiklah, jumpa lagi minggu depan.	きょうの　授業は　ここまでです。　それでは、　また来週、　会いましょう。	\N		\N	vmod				358	1
3873	Sudah siap menjawab ujian? Baiklah sila hantar.	テストは　できましたか。　それでは、　出して　ください。	\N		\N	vmod				358	1
3564	Bilik darjah ini ada tujuh buah komputer.	この　教室には　コンピューターが　七台　あります。	\N		\N	vmod				359	1
3565	Ada empat buah kereta berhenti di depan kedai.	店の　前に　車が　四台　止まって　います。	\N		\N	vmod				359	1
2940	Kalau pusing ke kanan dekat persimpangan itu, akan ada kedutaan.	あの　交差点を　右に　曲がると、　大使館が　あります。	\N		\N	vmod				361	1
2941	Esok saya akan pergi ke kedutaan.	わたしは　あした　大使館へ　行きます。	\N		\N	vmod				361	1
1332	４時です。	４時です。	null		\N	vmod				\N	1
3599	Buku ini sangat penting, jadi jangan hilangkannya.	この　本は　とても　大切なので、　なくさないで　ください。	\N		\N	vmod				364	1
3600	Ini surat yang penting.	これは　大切な　手紙です。	\N		\N	vmod				364	1
2778	Dapur di rumah baru luas, jadi sangat senang diguna.	新しい　家は　台所が　広いので、　とても　便利です。	\N		\N	vmod				365	1
2911	Saya naik teksi dari stesen sampai syarikat.	駅から　会社まで　タクシーに　乗ります。	\N		\N	vmod				369	1
2912	Saya pulang ke rumah dengan teksi.	タクシーで　うちへ　帰ります。	\N		\N	vmod				369	1
3911	Selalu sebelum tidur, saya akan membaca buku selama tiga puluh minit sahaja.	いつも　寝る　前に　三十分だけ　本を　読みます。	\N		\N	vmod				370	1
3912	Saya makan satu biji kuih sahaja.	お菓子を　一つだけ　食べました。	\N		\N	vmod				370	1
3820	Budak-budak sedang bermain di taman.	公園で　子供たちが　遊んで　います。	\N		\N	vmod				372	1
3821	Orang-orang itu kawan saya.	あの　人たちは　友達です。	\N		\N	vmod				372	1
3621	Buku nota ini lebih panjang panjangnya daripada lebarnya. 	この　ノートは　縦より　横の　ほうが　長いです。	\N		\N	vmod				374	1
3622	Saya memotong kertas ini secara menegak.	この　紙を　縦に　切ります。	\N		\N	vmod				374	1
1308	Milik siapakah beg itu?	あの　かばんは　だれのですか。	null		\N	vmod				\N	1
3746	Esok awak akan berjumpa dengan siapa?	あした　だれと　会いますか。	\N		\N	vmod				383	1
3747	Ada sesiapa di bilik sebelah?	隣の　部屋に　だれか　いましたか。	\N		\N	vmod				384	1
3748	Ada sesiapa yang mempunyai pen mata bulat saya?	だれか　わたしの　ボールペンを　持って　いませんか。	\N		\N	vmod				384	1
3619	Encik Yamada memberikan jam pada hari jadi Encik Kobayashi.	山田さんは　小林さんの　誕生日に　時計を　あげました。	\N		\N	vmod				385	1
3620	Hari Jadi saya ialah 26 hari bulan Ogos.	わたしの　誕生日は　八月　二十六日です。	\N		\N	vmod				385	1
3716	Encik Lee semakin pandai berbahasa Jepun.	イさんは　だんだん　日本語が　上手に　なりました。	\N		\N	vmod				386	1
3717	Mulai bulan Julai cuaca akan menjadi semakin panas.	七月から　だんだん　暑く　なります。	\N		\N	vmod				386	1
3800	Ada kerusi kecil di dalam bilik saya.	わたしの　部屋に　小さな　いすが　あります。　	\N		\N	vmod				388	1
3801	Saya lahir di bandar yang kecil.	わたしは　小さな　町で　生まれました。	\N		\N	vmod				388	1
2831	Kereta api bawah tanah murah, laju dan sangat berguna.	地下鉄は　安くて、　早くて、　とても　便利です。	\N		\N	vmod				392	1
3242	Warna rambut Cik Kimura adalah warna coklat.	木村さんの　髪の　色は　茶色です。	\N		\N	vmod				395	1
3204	Saya menyusun mangkuk dan penyepit di atas meja.	テーブルの　上に　ちゃわんと　おはしを　並べます。	\N		\N	vmod				396	1
3205	Saya makan nasi menggunakan mangkuk.	ちゃわんで　ごはんを　食べます。	\N		\N	vmod				396	1
3541	Cuti musim panas mula dari satu hari bulan Ogos. 	八月　一日から　夏休みです。	\N		\N	vmod				400	1
3234	Hari ini sibuk, jadi saya sangat letih.	きのうは　忙しかったので、　とても　疲れました。	\N		\N	vmod				402	1
2757	Bagasi akan tiba esok.	あした　荷物が　着きます。	\N		\N	vmod				404	1
2758	Kereta api akan tiba di stesen.	電車が　駅に　着きます。	\N		\N	vmod				404	1
1533	Dalam bilik saya ada meja, katil, TV dan lain-lain.	わたしの　部屋に　机や　ベッドや　テレビなどが　あります。	null		\N	vmod				\N	1
3161	Syarikat itu membuat kereta.	あの　会社は　車を　作って　います。	\N		\N	vmod				406	1
3162	Saya membuat meja sendirian.	自分で　テーブルを　作ります。	\N		\N	vmod				406	1
2898	Oleh sebab bilik itu gelap, saya akan pasang lampu.	部屋が　暗いので、　電気を　つけます。	\N		\N	vmod				407	1
3481	Saya minum secawan susu sejuk setiap pagi.	毎朝　冷たい　牛乳を　一杯　飲みます。	\N		\N	vmod				410	1
3482	Air di dalam kolam renang sejuk.	プールの　水は　冷たいです。	\N		\N	vmod				410	1
3075	Ada pasu bunga di atas meja.	テーブルの　上に　花瓶が　あります。	\N		\N	vmod				414	1
3000	Esok malam saya akan keluar kerana ingin berjumpa dengan kawan.	あしたの　夜は　友達と　会うので、　出かけます。　	\N		\N	vmod				416	1
3001	Semalam saya tidak keluar ke mana-mana.	きのうは　どこも　出かけませんでした。	\N		\N	vmod				416	1
2837	Kalau keluar dari pintu keluar ini, paling dekat dengan perpustakaan. 	この　出口を　出ると、　図書館に　一番　近いです。	\N		\N	vmod				420	1
3625	Jangan buka pintu situ. 	そこの　戸を　開けては　いけません。	\N		\N	vmod				431	1
3626	Pintu bilik saya tak mahu tutup. 	わたしの　部屋の　戸が　閉まりません。	\N		\N	vmod				431	1
3045	Esok suhu akan naik sampai tiga puluh darjah, jadi akan panas.	あしたは　三十度まで　上がるので、　暑いです。	\N		\N	vmod				432	1
3046	Saya terkena selesema, jadi suhu badan tiga puluh lapan darjah.	かぜで　熱が　三十八度　あります。	\N		\N	vmod				432	1
3664	Binatang yang kecil sangat comel.	小さな　動物は　とても　かわいいです。	\N		\N	vmod				438	1
2781	Dari stesen ke sekolah jauh, jadi saya naik bas.	駅から　学校まで　遠いので、　バスに　乗ります。	\N		\N	vmod				441	1
3550	Saya perlu siapkan kerja ini sampai sepuluh hari bulan.	十日までに　この　仕事を　しなければ　なりません。	\N		\N	vmod				442	1
3720	Saya kadang-kadang membeli barang di gerai sayur ini. 	わたしは　時々　この　八百屋で　買い物を　します。	\N		\N	vmod				444	1
2047	Saya akan beli jika harganya murah.	安ければ、　買います。	null		\N	vmod				\N	1
3721	Cik Kimura kadang-kadang membuat makanan malam.	木村さんは　時々　晩ごはんを　作ります。	\N		\N	vmod				444	1
3613	Saya ingin tinggal di tempat yang senyap dan cantik.	わたしは　静かで　きれいな　所に　住みたいです。	\N		\N	vmod				447	1
3614	Sini merupakan tempat yang sangat meriah.	ここは　とても　にぎやかな　所です。	\N		\N	vmod				447	1
3756	Encik Lee nak minuman yang mana?	イさんは　どっちの　飲み物が　いいですか。	\N		\N	vmod				451	1
3757	Cik Kimura suka yang mana?	木村さんは　どっちが　好きですか。	\N		\N	vmod				451	1
2887	Jangan bercakap dengan orang di sebelah semasa kelas. 	授業中に　隣の　人と　話しては　いけません。	\N		\N	vmod				454	1
2888	Kedai kopi itu ada di sebelah kedai buku.	その　喫茶店は　本屋の　隣に　あります。	\N		\N	vmod				454	1
3760	Kelas guru yang mana paling menarik?	どの　先生の　授業が　いちばん　おもしろいですか。	\N		\N	vmod				455	1
3761	Encik Hayashi orang yang mana?	どの　人が　林さんですか。	\N		\N	vmod				455	1
2957	Daging ayam murah tetapi daging lembu lebih sedap.	とり肉は　安いですが、　牛肉の　ほうが　おいしいです。	\N		\N	vmod				461	1
2814	Masakan Perancis dimakan dengan menggunakan pisau dan garpu.	フランス料理は　ナイフと　フォークを　使って　食べます。	\N		\N	vmod				466	1
2815	Tidak boleh guna pisau kerana berbahaya.	危ないので、　ナイフを　使っては　いけません。	\N		\N	vmod				466	1
3814	Encik Tanaka boleh menyanyi sambil bermain gitar.	田中さんは　ギターを　弾きながら、　歌を　歌えます。	\N		\N	vmod				469	1
3815	Saya makan nasi sambil menonton TV.	テレビを　見ながら、　ごはんを　食べます。	\N		\N	vmod				469	1
3690	Saya menangis apabila menonton filem.	映画を　見て　いた　とき、　泣いて　しまいました。	\N		\N	vmod				470	1
3691	Adik prempuan menangis di dalam bilik.	部屋で　妹が　泣いて　います。	\N		\N	vmod				470	1
2891	Oleh sebab kehilangan dompet, saya pergi ke pondok polis.	財布を　なくしたので、　交番へ　行きます。	\N		\N	vmod				471	1
2892	Saya kehilangan majalah yang dipinjam daripada Encik Matsui.	松井さんに　借りた　雑誌を　なくして　しまいました。	\N		\N	vmod				471	1
3816	Saya membeli baju sejuk, skirt dan lain-lain di pusat membeli-belah semalam.	きのう　デパートで　セーターや　スカートなどを　買いました。	\N		\N	vmod				475	1
3817	Ada telur, sayur, buah, dan lain-lain di dalam peti sejuk.	冷蔵庫に　卵や　野菜や　果物などが　あります。　	\N		\N	vmod				475	1
3538	Cik Kimura membuat tujuh biji kuih.	木村さんは　お菓子を　七つ　作りました。	\N		\N	vmod				476	1
3548	Saya memindahkan wang seblum tujuh hari bulan.	七日までに　お金の　振り込みを　します。	\N		\N	vmod				478	1
3404	Ramai orang beratur di depan restoran.	レストランの　前に、　人が　大勢　並んで　います。	\N		\N	vmod				481	1
3405	Saya beratur selama satu jam untuk menonton filem semalam.	きのう　映画を　見るのに、　一時間　並びました。	\N		\N	vmod				481	1
3402	Banyak buku tersusun di rak buku.	本棚に　たくさん　本が　並べて　あります。	\N		\N	vmod				482	1
3403	Saya menyusun pinggan di atas meja.	テーブルに　お皿を　並べます。	\N		\N	vmod				482	1
3406	Saya ingin menjadi doktor apabila keluar dari universiti.	大学を　出たら、　医者に　なりたいです。	\N		\N	vmod				483	1
3407	Apabila musim panas datang, akan menjadi panas.	夏に　なると、　暑く　なります。	\N		\N	vmod				483	1
3885	Di rumah Encik Tanaka ada dua buah kereta.	田中さんの　家には　車が　二台　あります。	\N		\N	vmod				484	1
3520	Di sini bandar yang besar dan meriah.	ここは　大きくて　にぎやかな　町です。	\N		\N	vmod				485	1
3521	Kelas sebelah sangat meriah.	隣の　教室は　とても　にぎやかです。	\N		\N	vmod				485	1
2953	Makan malam semalam adalah masakan daging.	きのうの　晩ごはんは　肉料理でした。	\N		\N	vmod				486	1
2954	Saya lebih suka ikan daripada daging.	わたしは　肉より　魚の　ほうが　好きです。	\N		\N	vmod				486	1
3441	Ibu saya lahir pada dua puluh sembilan hari bulan November.	母は　十一月　二十九日に　生まれました。	\N		\N	vmod				488	1
3195	Apabila masuk ke dalam rumah di Jepun, kita menanggalkan kasut.	日本では　家に　入る　とき、　靴を　脱ぎます。	\N		\N	vmod				494	1
3198	Saya menanggalkan baju kerana ingin mandi.	おふろに　入るので、　服を　脱ぎます。	\N		\N	vmod				494	1
2981	Ini tali leher dari Itali.	これは　イタリアの　ネクタイです。	\N		\N	vmod				496	1
2754	Saya gosok gigi selepas makan nasi.	ごはんを　食べたら、　歯を　磨きます。	\N		\N	vmod				505	1
3568	Saya masukkan tiga sudu gula dengan menggunakan sudu.	スプーンで　三杯　砂糖を　入れます。	\N		\N	vmod				507	1
3569	Semalam saya minum dua gelas arak.	きのう　二杯　お酒を　飲みました。	\N		\N	vmod				507	1
3570	Setiap pagi saya minum segelas susu.	毎朝　一杯　牛乳を　飲みます。	\N		\N	vmod				507	1
3088	Saya menggunakan tempat abu rokok apabila merokok.	たばこを　吸う　とき、　灰皿を　使います。	\N		\N	vmod				508	1
3089	Ada tempat abu rokok di atas meja.	テーブルの　上に　灰皿が　あります。	\N		\N	vmod				508	1
3196	Saya keluar dengan memakai kasut yang baru.	新しい　靴を　はいて　出かけます。	\N		\N	vmod				511	1
3197	Cik Kimura memakai skirt yang comel.	木村さんは　かわいい　スカートを　はいて　います。	\N		\N	vmod				511	1
2917	Selepas menyeberangi jambatan, akan ada taman.	橋を　渡ると、　すぐ　公園が　あります。	\N		\N	vmod				717	1
3398	Universiti akan bermula dari bulan April.	四月から　大学が　始まります。	\N		\N	vmod				514	1
3399	Kelas akan bermula dari pukul sembilan pagi.	朝　九時から　授業が　始まります。	\N		\N	vmod				514	1
2716	ありがとう。	ありがとう。			\N	vmod				\N	1
3744	Saya akan membuat kerja rumah terlebih dahulu selepas balik rumah.	家へ　帰ったら、　初めに　宿題を　します。	\N		\N	vmod				515	1
3745	Awal bulan depan saya akan pulang ke negara asal.	来月の　初め、　国へ　帰ります。	\N		\N	vmod				515	1
3556	Di Jepun arak boleh diminum apabila berumur dua puluh tahun.	日本では　二十歳から　お酒が　飲めます。	\N		\N	vmod				520	1
3557	Adik lelaki saya akan berumur dua puluh tahun bulan depan.	来月　わたしの　弟は　二十歳に　なります。	\N		\N	vmod				520	1
3891	Di sini ada lapan keping setem.	ここに　切手が　八枚　あります。	\N		\N	vmod				522	1
3551	Dua puluh hari bulan ini akan ada ujian bahasa jepun.	今月　二十日に　日本語の　テストが　あります。	\N		\N	vmod				523	1
3672	Bunga ini merah dan cantik.	この　花は　赤くて、　きれいです。	\N		\N	vmod				725	1
3673	Cik Kimura suka bunga.	木村さんは　花が　好きです。	\N		\N	vmod				725	1
3175	Saya mendengar cerita yang menarik daripada Encik Hayashi .	林さんに　おもしろい　話を　聞きました。	\N		\N	vmod				525	1
3176	Encik Matsui sedang bercerita dengan Encik Kobayashi.	松井さんは　小林さんと　話を　して　います。	\N		\N	vmod				525	1
2928	Saya rasa kereta api lebih cepat daripada bas untuk sampai ke sekolah.	学校まで　バスより　電車の　ほうが　速いと　思います。	\N		\N	vmod				716	1
2929	Encik Matsui berlari dengan cepat	松井さんは　走るのが　速いです。	\N		\N	vmod				716	1
2792	Saya menampal setem pada sampul surat.	封筒に　切手を　はります。	\N		\N	vmod				529	1
3206	Hari ini saya akan makan malam bersama kawan.	きょうは　友達と　晩ごはんを　食べます。	\N		\N	vmod				537	1
3218	Makan malam hari ini adalah kari.	きょうの　晩ごはんは　カレーです。	\N		\N	vmod				537	1
3802	Saya potong buah menjadi separuh.	果物を　半分に　切りました。	\N		\N	vmod				538	1
3259	Di bahagian timur bandar ini semuanya hutan.	この　町の　東側は　全部　森です。	\N		\N	vmod				539	1
3571	Saya membeli tiga ekor ikan di pasar raya semalam	きのう　スーパーで　魚を　三匹　買いました。	\N		\N	vmod				540	1
3572	Ada dua ekor anjing di sana.	あそこに　犬が　二匹　います。	\N		\N	vmod				540	1
3573	Di rumah Encik Hayashi ada seekor kucing. 	林さんの　家に　猫が　一匹　います。	\N		\N	vmod				540	1
3016	Saya akan bermain piano pada konsert bulan depan.	わたしは　来月の　コンサートで　ピアノを　弾きます。	\N		\N	vmod				541	1
3499	Orang yang rendah itu Cik Kimura.	あの　背が　低い　人は　木村さんです。	\N		\N	vmod				542	1
3532	Setiap pagi saya makan sebiji telur.	わたしは　毎朝　卵を　一つ　食べます。	\N		\N	vmod				546	1
3609	Bulan ini sibuk, jadi tiada hari lapang.	今月は　忙しいので、　暇な　日が　ありません。	\N		\N	vmod				549	1
3610	Esok saya ada masa lapang, jadi saya akan bermain dengan kawan saya.	わたしは　あした　暇なので、　友達と　遊びます。	\N		\N	vmod				549	1
3894	Bilik darjah sebelah muat seramai seratus orang.	隣の　教室は　百人　入れます。	\N		\N	vmod				550	1
3180	Saya boleh tulis hiragana tetapi saya masih belum boleh tulis katakana.	ひらがなは　書けますが、　かたかなは　まだ　書けません。	\N		\N	vmod				553	1
3448	Saya pergi ke kedai kopi bersama Encik Kimura pada waktu tengah hari semalam.	きのうの　昼、　木村さんと　喫茶店へ　行きました。	\N		\N	vmod				554	1
3449	Setiap hari saya rehat selama satu jam pada waktu tengah hari .	毎日　昼は　一時間　休みます。	\N		\N	vmod				554	1
3207	Saya selalu makan tengah hari di sini.	いつも　ここで　昼ごはんを　食べます。	\N		\N	vmod				555	1
3214	Oleh sebab saya sibuk saya tidak dapat makan tengah hari.	忙しかったので、　昼ごはんを　食べられませんでした。	\N		\N	vmod				555	1
3630	Tiada filem yang tinggal kerana sudah banyak gambar yang telah ditangkap.	たくさん　写真を　撮ったので、　もう　フィルムが　ありません。	\N		\N	vmod				557	1
3631	Saya memasukkan filem ke dalam kamera.	カメラに　フィルムを　入れます。	\N		\N	vmod				557	1
2759	Saya menulis nama pada sampul surat.	封筒に　名前を　書きます。	\N		\N	vmod				558	1
2813	Saya menggunakan garpu apabila makan kek.	ケーキを　食べる　とき、　フォークを　使います。	\N		\N	vmod				560	1
3043	Rasa sejuk kerana angin sedang bertiup.	風が　吹いて　いて、　寒いです。	\N		\N	vmod				713	1
3044	Esok angin akan bertiup kuat.	あしたは　強い　風が　吹くそうです。	\N		\N	vmod				713	1
3533	Saya meyusun dua buah pasu bunga di atas meja.	テーブルの　上に　花瓶を　二つ　並べます。	\N		\N	vmod				562	1
2956	Saya tidak boleh makan daging babi.	わたしは　ぶた肉が　食べられません。	\N		\N	vmod				563	1
3554	Esok saya dan Encik Kimura berdua akan ke kolam renang.	あした　木村さんと　二人で　プールへ　行きます。	\N		\N	vmod				564	1
3555	Ada dua orang yang tidak dikenali di depan rumah.	家の　前に　知らない　人が　二人　います。	\N		\N	vmod				564	1
3542	Encik Tanaka akan pergi ke luar negara pada dua hari bulan bulan depan.	田中さんは　来月　二日に　海外へ　行きます。	\N		\N	vmod				565	1
3483	Ada pokok yang besar di taman.	公園に　太い　木が　あります。	\N		\N	vmod				566	1
3487	Pen ini besar.	この　ペンは　太いです。	\N		\N	vmod				566	1
3678	Salji turun pada musim sejuk di Jepun.	日本では　冬　雪が　降ります。	\N		\N	vmod				567	1
3679	Oleh sebab musim sejuk sejuk, pemanas dipasang.	冬は　寒いので、　ストーブを　つけます。	\N		\N	vmod				567	1
2924	Oleh sebab saya tidak pandai menyanyi, saya akan berlatih.	歌が　下手ですから、　練習しようと　思って　います。	\N		\N	vmod				574	1
2927	Saya tidak pandai melukis.	わたしは　絵を　書くのが　下手です。	\N		\N	vmod				574	1
3662	Semalam saya bermain dengan haiwan peliharaan.	きのう　ペットと　遊びました。	\N		\N	vmod				576	1
3663	Di rumah Encik Kobayashi ada haiwan peliharaan.	小林さんの　家には　ペットが　います。	\N		\N	vmod				576	1
1356	Saya belajar semalam.	きのう　わたしは　勉強しました。	null		\N	vmod				\N	1
1675	Saya selalu belajar bersendirian.	いつも　ひとりで　勉強して　います。	null		\N	vmod				\N	1
2853	Oleh sebab esok ada ujian, malam ini saya akan belajar.	あした　テストが　あるので、　今晩は　勉強します。	\N		\N	vmod				580	1
3841	Bilik adik lelaki saya lebih kecil daripada bilik saya.	わたしの　部屋より　弟の　部屋の　ほうが　狭いです。	\N		\N	vmod				584	1
3842	Saya lebih suka besbol daripada bola sepak.	サッカーより　野球の　ほうが　好きです。	\N		\N	vmod				584	1
2784	Saya pakai topi apabila keluar pada hari panas.	暑い　日は　帽子を　かぶって　出かけます。	\N		\N	vmod				585	1
3635	Jaket ini ada banyak poket, jadi senang diguna.	この　上着には　ポケットが　たくさん　あるので、　便利です。	\N		\N	vmod				588	1
3636	Saya memasukkan duit ke dalam poket.	ポケットの　中に　お金を　入れます。	\N		\N	vmod				588	1
3591	Benda yang saya paling nak sekarang adalah komputer baru.	今　いちばん　欲しい　物は　新しい　コンピューターです。	\N		\N	vmod				590	1
3592	Saya nak kamus bahasa Jepun.	わたしは　日本語の　辞書が　欲しいです。	\N		\N	vmod				590	1
3484	Oleh sebab saya berlari setiap pagi, saya sudah kurus sedikit.	毎朝　走って　いるので、　少し　細く　なりました。	\N		\N	vmod				591	1
3485	Orang itu kakinya kurus dan panjang.	あの　人は　足が　細くて、　長いです。	\N		\N	vmod				591	1
2967	Ada banyak deretan rak buku di perpustakaan.	図書館に　本棚が　たくさん　並んで　います。	\N		\N	vmod				595	1
2968	Kamus ada di rak buku sana.	辞書は　あそこの　本棚に　あります。	\N		\N	vmod				595	1
3419	Setiap hari Sabtu, saya berlatih bola sepak.	毎週　土曜日、　サッカーの　練習を　します。	\N		\N	vmod				599	1
3301	Setiap bulan saya deposit wang di bank.	毎月　銀行に　お金を　預けて　います。	\N		\N	vmod				600	1
3309	Setiap bulan saya menulis surat kepada kawan di luar negara.	毎月　海外の　友達に　手紙を　書きます。	\N		\N	vmod				600	1
3312	Setiap tahun saya pergi melancong bersama keluarga.	毎年　家族で　旅行に　行きます。	\N		\N	vmod				601	1
3322	Setiap tahun saya memberikan ibu hadiah hari jadi.	毎年　母に　誕生日の　プレゼントを　あげます。	\N		\N	vmod				601	1
3436	Setiap malam sebelum tidur, saya membaca buku.	毎晩　寝る　前に　本を　読みます。	\N		\N	vmod				603	1
3437	Saya belajar bahasa Inggeris setiap malam selama dua jam.	毎晩　二時間　英語の　勉強を　します。	\N		\N	vmod				603	1
3210	Masakan ini macam tidak sedap.	この　料理は　まずそうです。	\N		\N	vmod				606	1
3211	Kedai itu murah tetapi tidak sedap.	あの　店は　安いですが、　まずいです。	\N		\N	vmod				606	1
3724	Para pelajar beratur secara lurus di koridor.	生徒たちは　廊下に　まっすぐ　並びます。	\N		\N	vmod				611	1
3725	Selepas keluar dari stesen, jalan terus ikut jalan itu.	駅を　出て、　あの　道を　まっすぐ　行って　ください。	\N		\N	vmod				611	1
3642	Saya menghisap rokok dengan menggunakan mancis. 	マッチを　使って、　たばこを　吸いました。	\N		\N	vmod				612	1
3643	Ada mancis di atas meja.	テーブルの　上に　マッチが　あります。	\N		\N	vmod				612	1
3589	Di sana ada kotak yang berbentuk bulat.	あそこに　丸い　箱が　あります。	\N		\N	vmod				614	1
3590	Meja ini bulat.	この　テーブルは　丸いです。	\N		\N	vmod				614	1
3233	Selalu sebelum tidur saya menggosok gigi.	いつも　寝る　前に、　歯を　磨きます。	\N		\N	vmod				617	1
2870	Oleh sebab pensel ini selalu digunakan, ia sudah menjadi pendek.	いつも　この　鉛筆を　使って　いたので、　短く　なりました。	\N		\N	vmod				619	1
2823	Selepas minum arak, lebih baik minum air.	お酒を　飲んだ　あとは、　水を　飲んだ　ほうが　いいです。	\N		\N	vmod				620	1
3543	Tiga hari bulan sehingga lima hari bulan Mei merupakan cuti bagi sekolah dan syarikat.	五月　三日から　五月　五日まで　学校や　会社は　休みです。	\N		\N	vmod				624	1
3534	Ada tiga jawapan bagi soalan ini.	この　問題の　答えは　三つ　あります。	\N		\N	vmod				625	1
3241	Encik Yamada memakai tali leher berwarna hijau.	田中さんは　緑の　ネクタイを　して　います。	\N		\N	vmod				626	1
3225	Anjing itu telinganya besar.	あの　犬は　耳が　大きいです。	\N		\N	vmod				629	1
3547	Saya hantar bagasi di pejabat pos pada enam hari bulan.	六日に　郵便局で　荷物を　送りました。	\N		\N	vmod				632	1
3804	Sila buka tingkap di sebelah sana.	向こうの　窓を　開けて　ください。	\N		\N	vmod				633	1
3805	Hospital ada di sebalik stesen.	病院は　駅の　向こうです。	\N		\N	vmod				633	1
3537	Ada enam buah kotak diletakkan di dalam bilik.	部屋に　箱が　六つ　置いて　あります。	\N		\N	vmod				635	1
3650	Sekarang jalan baru sudah siap, jadi kampung ini telah menjadi selesa.	新しい　道が　できたので、　村は　便利に　なりました。	\N		\N	vmod				636	1
3651	Kampung ini senyap dan cantik.	この　村は　静かで　きれいです。	\N		\N	vmod				636	1
3223	Mata saya letih kerana membaca buku di tempat yang gelap.	暗い　部屋で　本を　読んで　いたので、　目が　疲れました。	\N		\N	vmod				637	1
3224	Penglihatan Encik Yamada teruk, jadi beliau memakai cermin mata.	山田さんは　目が　悪いので、　眼鏡を　かけて　います。	\N		\N	vmod				637	1
2788	Orang yang pakai cermin mata itu Encik Matsui.	あの　眼鏡を　かけて　いる　人は　松井さんです。	\N		\N	vmod				639	1
3412	Saya akan ke bank untuk memindahkan wang petang hari Khamis ini.	木曜日の　午後、　銀行へ　お金を　振り込みに　行きます。	\N		\N	vmod				641	1
3738	Saya nak jadi lebih pandai dalam bahasa Inggeris.	わたしは　もっと　英語が　上手に　なりたいです。	\N		\N	vmod				644	1
3739	Saya membeli baju yang lebih murah.	もっと　安い　服を　買います。	\N		\N	vmod				644	1
3611	Jangan gunakan benda yang ada di sana.	あそこに　ある　物を　使っては　いけません。	\N		\N	vmod				645	1
3612	Cik Kimura suka benda yang comel.	木村さんは　かわいい　物が　大好きです。	\N		\N	vmod				645	1
3844	Kadang-kadang saya pergi ke kedai buku sana.	わたしは　時々　あそこの　本屋へ　行きます。	\N		\N	vmod				648	1
3845	Mak cik saya bekerja di kedai bunga.	わたしの　おばさんは　花屋で　働いて　います。	\N		\N	vmod				648	1
2951	Saya membeli buah dan sayur di gerai sayur.	わたしは　果物や　野菜は　八百屋で　買います。	\N		\N	vmod				649	1
2952	Gerai sayur lebih murah daripada pasar raya.	スーパーより　八百屋の　ほうが　安いです。	\N		\N	vmod				649	1
2959	Ada sayur dan telur di dalam peti sejuk.	冷蔵庫の　中に　野菜や　卵が　あります。	\N		\N	vmod				650	1
2960	Potong sayur, kemudian basuh.	野菜を　切って、　洗います。	\N		\N	vmod				650	1
3539	Saya mesti membeli lapan buah cenderamata.	わたしは　旅行の　お土産を　八つ　買わなければ　なりません。	\N		\N	vmod				655	1
3450	Saya mesti siapkan kerja ini sampai petang.	夕方までに　この　仕事を　やらなければ　なりません。	\N		\N	vmod				658	1
3451	Saya pergi berjalan-jalan ke taman pada waktu petang.	夕方　公園へ　散歩に　行きました。	\N		\N	vmod				658	1
2756	Pejabat pos ada di dekat stesen.	郵便局は　駅の　そばに　あります。	\N		\N	vmod				660	1
3431	Malam tadi saya penat, jadi saya tidur awal.	ゆうべは　疲れて　いたので、　早く　寝ました。	\N		\N	vmod				661	1
3432	Malam tadi, saya dan Cik Kimura pergi makan malam.	ゆうべ　木村さんと　晩ごはんを　食べに　行きました。	\N		\N	vmod				661	1
3607	Di sini adalah tempat sangat terkenal di Jepun.	ここは　日本で　とても　有名な　所です。	\N		\N	vmod				662	1
3608	Universiti ini lama dan terkenal.	この　大学は　古くて、　有名です。	\N		\N	vmod				662	1
2068	Kalau salji turun pun, saya tetap akan  ke sekolah.	雪が　降っても、　学校に　行きます。	null		\N	vmod				\N	1
3051	Saya tidak keluar pada hari ada salji.	雪の　日は　出かけません。	\N		\N	vmod				663	1
3736	Sila cakap secara lebih perlahan-lahan.	もっと　ゆっくり　話して　ください。	\N		\N	vmod				664	1
3737	Oleh sebab kaki sakit, saya jalan perlahan-lahan.	足が　痛いので、　ゆっくり　歩きます。	\N		\N	vmod				664	1
3546	Gerai sayur ini menjual dengan harga murah pada lapan hari bulan setiap bulan. 	この　八百屋は　毎月　八日が　安いです。	\N		\N	vmod				665	1
3186	Saya beli pakaian Barat yang baru di pusat membeli-belah.	デパートで　新しい　洋服を　買いました。	\N		\N	vmod				666	1
3544	Saya perlu menulis karangan dalam bahasa Inggeris sampai empat hari bulan.	四日までに　英語で　作文を　書かなければ　なりません。	\N		\N	vmod				669	1
3388	Cikgu memanggil nama Encik Yamada.	先生は　山田さんの　名前を　呼びました。	\N		\N	vmod				671	1
3124	Badan saya lemah, jadi saya tidak boleh bersukan.	体が　弱いので、　スポーツが　できません。	\N		\N	vmod				674	1
2771	Saya dengar berita di radio. 	ラジオで　ニュースを　聞きます。	\N		\N	vmod				678	1
2772	Kita boleh dengar lagu dan juga radio menggunakan pemain radio kaset.	ラジカセは　ラジオも　音楽も　聞く　ことが　できます。	\N		\N	vmod				679	1
3262	Ibu bapa saya ada di luar negara sekarang.	今　わたしの　両親は　海外に　います。	\N		\N	vmod				682	1
2935	Saya fikir ingin melancong ke luar negara tahun depan.	来年　海外を　旅行しようと　思って　います。	\N		\N	vmod				685	1
3882	Di sini suhunya sifar, jadi sangat sejuk.	ここは　零度なので、　とても　寒いです。	\N		\N	vmod				686	1
2769	Tiada apa-apa di dalam peti sejuk.	冷蔵庫の　中に　何も　ありません。	\N		\N	vmod				687	1
2860	Kalau banyak berlatih, awak akan pandai bahasa Jepun.	たくさん　練習すれば、　日本語が　上手に　なります。	\N		\N	vmod				691	1
2844	Saya membersihkan bahagian pintu masuk rumah dan juga koridor.	玄関と　廊下も　掃除します。	\N		\N	vmod				692	1
3889	Saya menyusun enam keping pinggan di atas meja.	テーブルの　上に　お皿を　六枚　並べます。	\N		\N	vmod				693	1
1728	Boleh makan bekal di dalam bilik ini juga.	この　部屋で　お弁当を　食べても　いいです。	null		\N	vmod				\N	1
2097	Adik perempuan saya membuat bekal untuk ayah.	妹は　父に　お弁当を　作って　あげました。	null		\N	vmod				\N	1
2919	Saya berjalan-jalan setiap pagi.	わたしは　毎朝　散歩します。	\N		\N	vmod				718	1
3281	Saya ada kawan orang Thailand.	わたしには　タイ人の　友達が　います。	\N		\N	vmod				709	1
2775	Minggu depan saya akan pergi ke pejabat hartanah dan mencari bilik yang baru.	来週、　不動産屋へ　行って、　新しい　部屋を　探します。	\N		\N	vmod				719	1
2817	Saya akan guna pinggan baru.	新しい　お皿を　使います。	\N		\N	vmod				720	1
2811	Saya tidak minum banyak arak.	わたしは　あまり　お酒を　飲みません。	\N		\N	vmod				721	1
2865	Saya ingin memotong rambut di salon kecantikan pada minggu depan.	来週、　美容院で　髪を　切ろうと　思って　います。	\N		\N	vmod				722	1
3848	Jangan cakap kepada orang lain.	ほかの　人に　話しては　いけません。	\N		\N	vmod				726	1
3849	Ada benda lain yang awak nak?	ほかに　欲しい　物は　ありますか。	\N		\N	vmod				726	1
2962	Kereta mahal tetapi berguna.	車は　高いですが、　便利です。	\N		\N	vmod				729	1
3714	Hari ini sangat seronok.	きょうは　大変　楽しかったです。	\N		\N	vmod				730	1
3715	Filem ini sangat seronok.	この　映画は　大変　おもしろいです。	\N		\N	vmod				730	1
3740	Awak menulis karangan ini dengan sangat baik.	この　作文は　とても　よく　書けました。	\N		\N	vmod				733	1
3741	Saya berjaya menjawab ujian semalam dengan baik.	きのうの　テストは　よく　できました。	\N		\N	vmod				733	1
3579	Jarak daripada stesen ke perpustakaan adalah dua kilometer.	駅から　図書館まで　二キロメートル　あります。	\N		\N	vmod				742	1
3580	Saya berlari setiap pagi sebanyak tiga kilometer.	わたしは　毎朝　三キロ　走ります。	\N		\N	vmod				742	1
3574	Saya selalu membawa tiga batang pensel ke sekolah.	いつも　学校へ　鉛筆を　三本　持って　行きます。	\N		\N	vmod				744	1
3575	Ada dua batang pokok di halaman rumah.	家の　庭に　木が　二本　あります。	\N		\N	vmod				744	1
3576	Saya makan nasi dan menghisap sebatang rokok.	ごはんを　食べて、　たばこを　一本　吸います。	\N		\N	vmod				744	1
3822	Saya mandi sebelum tidur.	寝る　前、　シャワーを　浴びます。	\N		\N	vmod				745	1
3843	Saya potong rambut tiga hari yang lepas.	三日前、　髪を　切りました。	\N		\N	vmod				745	1
3463	Dari rumah ke sekolah mengambil masa satu jam dengan kereta api.	家から　学校まで　電車で　一時間　かかります。	\N		\N	vmod				746	1
3464	Saya tidur selama lapan jam semalam.	きのうは　八時間　寝ました。	\N		\N	vmod				746	1
1334	 Pukul sepuluh lima puluh satu minit.	十時　五十一分です。	null		\N	vmod				\N	1
3354	Saya menelefon rumah tetapi tiada sesiapa di rumah.	うちに　電話を　かけましたが、　誰も　いませんでした。	\N		\N	vmod				753	1
3355	Saya akan menelefon kawan saya malam ini.	今晩　友達に　電話を　かけます。	\N		\N	vmod				753	1
3181	Ayat ini pendek, jadi senang untuk membacanya.	この　文は　短いので、　読みやすいです。	\N		\N	vmod				756	1
1449	Saya sakit tekak sejak semalam.	わたしは　きのうから　のどが　痛いです。	null		\N	vmod				\N	1
2986	Saya tidak membuat apa-apa  pada hari cuti minggu lepas.	先週の　休みは　何も　しませんでした。	\N		\N	vmod				760	1
3070	Tukang gunting itu kurus dan cantik.	あの　美容師は　細くて、　きれいです。	\N		\N	vmod				762	1
3071	Saya ingin menjadi tukang gunting selepas keluar dari sekolah.	学校を　出たら、　美容師に　なりたいです。	\N		\N	vmod				762	1
3056	Saya bersyampu dulu sebelum potong rambut.	髪を　切る　前に　シャンプーを　します。	\N		\N	vmod				763	1
3639	Tiada syampu di dalam bilik mandi.	おふろに　シャンプーが　ありませんでした。	\N		\N	vmod				763	1
3059	Saya tunjukkan tiket kepada pekerja stesen.	わたしは　駅員に　切符を　見せました。	\N		\N	vmod				765	1
3077	Saya memberitahu nombor telefon Encik Kimura kepada kawan.	友達に　木村さんの　電話番号を　教えました。	\N		\N	vmod				767	1
3080	Tolong hubungi syarikat melalui telefon.	電話で　会社に　連絡して　ください。	\N		\N	vmod				769	1
3081	Saya akan hubungi sebaik sahaja saya tiba di rumah.	家に　着いたら、　連絡します。	\N		\N	vmod				769	1
3076	Saya mendengar berita di radio setiap hari.	毎日　ラジオで　ニュースを　聞きます。	\N		\N	vmod				771	1
3084	Sewa rumah di flat ini mahal.	この　アパートは　家賃が　高いです。	\N		\N	vmod				772	1
3086	Saya akan mencari bilik yang lebih murah.	もっと　安い　部屋を　探そうと　思います。	\N		\N	vmod				773	1
3087	Saya tidak jumpa kunci saya, jadi saya mencarinya di dalam beg.	かぎが　見つからないので、　かばんの　中を　探しました。	\N		\N	vmod				773	1
3091	Saya selalu makan menu set ini untuk makan tengah hari.	昼ごはんは　いつも　この　定食を　食べます。	\N		\N	vmod				775	1
3092	Menu set di kantin itu murah dan sedap.	あの　食堂の　定食は　安くて、　おいしいです。	\N		\N	vmod				775	1
3095	Saya minum kopi tanpa susu.	わたしは　ミルクを　入れないで、　コーヒーを　飲みます。	\N		\N	vmod				776	1
3096	Setiap pagi saya makan roti dan minum susu.	毎朝　パンを　食べて、　ミルクを　飲みます。	\N		\N	vmod				776	1
3097	Bahagian stoking ada di tingkat satu.	靴下の　売り場は　一階に　あります。	\N		\N	vmod				780	1
3103	Hantar melalui udara lebih cepat sampai daripada melalui laut.	船便より　航空便の　ほうが　早く　着きます。	\N		\N	vmod				783	1
3102	Kalau hantar melalui laut mengambil masa tetapi murah.	船便は　時間が　かかりますが、　安いです。	\N		\N	vmod				784	1
3104	Semalam saya mengirim bagasi kepada ibu.	きのう　母に　荷物を　送りました。	\N		\N	vmod				785	1
3105	Kerana kirim melalui udara, sedikit mahal.	航空便で　送ったので、　少し　高かったです。	\N		\N	vmod				785	1
3106	Saya tak nak  pakai sut kerana musim panas panas.	夏は　暑いので、　スーツを　着たくないです。	\N		\N	vmod				786	1
3110	Cik Kimura adalah pelajar tetapi Encik Tanaka adalah pekerja syarikat.	木村さんは　学生ですが、　田中さんは　会社員です。	\N		\N	vmod				787	1
3116	Orang Jepun makan nasi menggunakan penyepit. 	日本人は　おはしを　使って、　ごはんを　食べます。	\N		\N	vmod				789	1
3137	Ayah saya seorang pegawai bank.	わたしの　父は　銀行員です。	\N		\N	vmod				792	1
3138	Pegawai bank di kaunter ramai wanita.	窓口に　いる　銀行員は　女の　人が　多いです。	\N		\N	vmod				793	1
3139	Saya membuat pemindahan wang di kaunter.	窓口で　お金の　振り込みを　します。	\N		\N	vmod				793	1
3140	Saya pergi ke bank dan membuat pemindahan wang.	銀行へ　行って、　お金の　振り込みを　します。	\N		\N	vmod				794	1
3530	Saya bangun lewat hari ini kerana semalam penat.	きのうは　疲れて　いたので、　今朝　遅く　起きました。	\N		\N	vmod				798	1
3531	Saya balik ke rumah kerana sudah lewat.	もう　遅いので、　家へ　帰ります。	\N		\N	vmod				798	1
3367	Sebuah kedai buku besar siap dibina di depan universiti.	大学の　前に　大きな　本屋が　できました。	\N		\N	vmod				799	1
3163	Saya memakai tali leher kerana akan berjumpa dengan orang untuk kerja .	仕事で　人と　会うので、　ネクタイを　します。	\N		\N	vmod				800	1
3389	Oleh sebab saya bekerja lama, saya berehat sekejap.	長い　時間　仕事を　して　いたので、　少し　休みました。	\N		\N	vmod				801	1
3201	Masakan ini kita makan tanpa membubuh apa-apa.	この　料理は　何も　つけないで　食べます。	\N		\N	vmod				803	1
3501	Saya perlu siapkan kerja ini dalam masa yang singkat.	短い　時間で　この　仕事を　やらなければ　なりません。	\N		\N	vmod				804	1
3502	Satu hari itu sangat singkat.	一日は　とても　短いです。	\N		\N	vmod				804	1
3497	Malam ini saya akan cuba belajar dengan masa yang panjang.	今晩は　長い　時間　勉強しようと　思って　います。	\N		\N	vmod				805	1
3498	Waktu kelas semalam sangat panjang.	きのうの　授業は　長かったです。	\N		\N	vmod				805	1
3154	Pemandu pelancong memberitahu tentang bandar ini.	ガイドが　この　町の　ことを　教えて　くれました。	\N		\N	vmod				808	1
3155	Kawan saya bekerja sebagai pemandu pelancong.	わたしの　友達は　ガイドを　して　います。	\N		\N	vmod				808	1
3156	Oleh kerana tiada kereta api, kami bermalam di rumah kawan.	帰る　電車が　なかったので、　友達の　家に　泊まりました。	\N		\N	vmod				809	1
3157	Malam ini saya akan bermalam di hotel.	今晩は　ホテルに　泊まります。	\N		\N	vmod				809	1
3158	Saya menerima cenderamata daripada kawan yang pergi melancong.	友達に　旅行の　お土産を　もらいました。	\N		\N	vmod				810	1
3159	Saya membelikan cenderamata untuk keluarga.	家族に　お土産を　買います。	\N		\N	vmod				810	1
3268	Suami Puan Kobayashi bekerja di hospital.	林さんの　ご主人は　病院で　働いて　います。	\N		\N	vmod				814	1
3269	Adik perempuan Encik Yamada rendah dan comel.	山田さんの　妹さんは　背が　低くて、　かわいいです。	\N		\N	vmod				815	1
3270	Adik lelaki Encik Kobayashi bermain bola sepak.	小林さんの　弟さんは　サッカーを　して　います。	\N		\N	vmod				816	1
3340	Saya membuka suis dan memasang lampu.	スイッチを　入れて、　電気を　つけます。	\N		\N	vmod				817	1
3341	Saya membuka suis komputer.	コンピューターの　スイッチを　入れます。	\N		\N	vmod				817	1
3358	Saya menutup suis komputer.	コンピューターの　スイッチを　切ります。	\N		\N	vmod				818	1
2220	Musim bunga sudah datang tetapi masih belum panas lagi.	春は　来ましたが、　まだ　暖かく　なりません。	null		\N	vmod				\N	1
2232	Tiada sesiapa datang hari ini.	きょうは　誰も　来ませんでした。	null		\N	vmod				\N	1
3654	Saya menerima surat daripada ibu yang berada di negara asal. 	国に　いる　母から　手紙が　来ました。	\N		\N	vmod				820	1
3655	Saya akan pulang ke negara asal semasa cuti musim panas.	夏休みは　国へ　帰ります。	\N		\N	vmod				820	1
3469	Nanti saya akan ke perpustakaan untuk memulangkan buku.	あとで　図書館へ　本を　返しに　行きます。	\N		\N	vmod				25	1
3701	Nanti jom kita makan tengah hari bersama-sama.	あとで　いっしょに　昼ごはんを　食べましょう。	\N		\N	vmod				821	1
1492	Encik Tanaka sekarang ini tengah buat apa?	田中さんは　今　何を　して　いますか。	null		\N	vmod				\N	1
3751	Dengan apa awak pergi ke syarikat?	何で　会社へ　行きますか。	\N		\N	vmod				822	1
3866	Lebih baik berhenti baca buku di tempat yang gelap.	暗い　所で　本を　読むのは　やめた　ほうが　いいです。	\N		\N	vmod				824	1
3867	Saya berhenti kerja bulan lepas.	先月　わたしは　会社を　やめました。	\N		\N	vmod				824	1
3868	Saya makan kuih yang saya dapat daripada Encik Tanaka.	田中さんに　もらった　お菓子を　食べました。	\N		\N	vmod				825	1
3869	Semalam saya dapat cenderamata daripada Encik Tanaka yang pergi melancong.	きのう　山田さんに　旅行の　お土産を　もらいました。	\N		\N	vmod				825	1
3858	Saya tidak sakit, jadi jangan bimbang.	病気じゃ　ありませんから、　心配しないで　ください。	\N		\N	vmod				826	1
3859	Ibu bimbang kerana adik perempuan masih belum pulang ke rumah.	妹が　　まだ　帰らないので、　母は　心配して　います。	\N		\N	vmod				826	1
3864	Saya memberitahu nombor telefon bimbit saya kepada kawan.	友達に　携帯電話の　番号を　教えました。	\N		\N	vmod				827	1
3865	Telefon bimbit bersaiz kecil, jadi senang diguna.	携帯電話は　小さくて、　とても　便利です。	\N		\N	vmod				827	1
3870	Encik Kobayashi memberikan separuh roti kepada Cik Kimura.	小林さんは　木村さんに　パンを　半分　あげました。	\N		\N	vmod				833	1
3871	Encik Matsui memberikan tali leher untuk hari jadi Encik Tanaka.	松井さんは　田中さんの　誕生日に　ネクタイを　あげます。	\N		\N	vmod				833	1
3705	Pelbagai jenis makan tersusun di atas meja.	テーブルに　いろいろな　料理が　並べて　あります。	\N		\N	vmod				70	1
3387	Saya memanggil sebuah teksi.	タクシーを　一台　呼びます。	\N		\N	vmod				671	1
3899	Saya bimbang kerana adik perempuan saya demam tinggi pada hari ini juga secara berterusan.	妹は　きょうも　高い　熱が　続いて　いるので、　心配です。	\N		\N	vmod				837	1
3900	Hari hujan berterusan pada minggu lepas.	先週は　雨の　日が　続きました。	\N		\N	vmod				837	1
3901	Saya menyemak bagasi sebelum keluar rumah.	うちを　出る　前に、　荷物を　確認します。	\N		\N	vmod				838	1
3902	Saya menyemak jawapan ujian.	テストの　答えを　確認します。	\N		\N	vmod				838	1
3903	Saya rasa akan pulang awal ke rumah kerana hari ini hari jadi isteri saya.	きょうは　妻の　誕生日なので、　早く　うちへ　帰ろうと　思います。	\N		\N	vmod				839	1
3904	Saya rasa buku ini sangat menarik	この　本は　とても　おもしろいと　思います。	\N		\N	vmod				839	1
3905	Bas untuk pergi ke lapangan terbang tiba di jalan yang berlainan.	空港へ　行く　バスは　反対の　道へ　来ます。	\N		\N	vmod				840	1
3906	Lawan kepada "berat" ialah "ringan".	「重い」の　反対は　「軽い」です。	\N		\N	vmod				840	1
3289	Cawan itu awak punya.	その　コップは　あなたのです。	\N		\N	vmod				26	1
1807	木村さんは留学しようと思いますか。	木村さんは留学しようと思いますか。	null		\N	vmod				\N	1
1801	Saya ingin belajar di perpustakaan tapi tutup. 	図書館で　勉強しようと　しましたが、　休みでした。	null		\N	vmod				\N	1
1802	西の　空に　日が　沈もうと　して　います。	西の　空に　日が　沈もうと　して　います。	null		\N	vmod				\N	1
1803	花が散ろうとしています。	花が散ろうとしています。	null		\N	vmod				\N	1
1804	あしたは　早く　起きようと　思います。	あしたは　早く　起きようと　思います。	null		\N	vmod				\N	1
1805	夏休みに　旅行しようと　思って　います。	夏休みに　旅行しようと　思って　います。	null		\N	vmod				\N	1
1808	きょうから　日記を　書こうと　思います。	きょうから　日記を　書こうと　思います。	null		\N	vmod				\N	1
1809	きょうは　食堂で　昼食を　食べようと　思います。	きょうは　食堂で　昼食を　食べようと　思います。	null		\N	vmod				\N	1
1810	Saya nak membersihkan rumah selepas balik.	家へ　帰ったら　掃除を　しようと　思います。	null		\N	vmod				\N	1
1813	Malam ini saya tidak ingin ke mana-mana.	今晩　どこへも　行きたくありません。	null		\N	vmod				\N	1
3908	Bunyi akan menjadi kuat sekiranya ditekan di sini.	ここを　押すと、　音が　大きく　なります。	\N		\N	vmod				842	1
3909	Saya dan Encik Lee sama kumpulan.	わたしと　イさんは　同じ　グループです。	\N		\N	vmod				843	1
3665	わたしは　動物が　大好きです。	わたしは　動物が　大好きです。	\N		\N	vmod				438	1
858	安ければ、買います。	安ければ、買います。	null		\N	vmod				\N	0
994	日本の冬は寒い。	日本の冬は寒い。	null		\N	vmod				\N	0
3707	Encik Kobayashi sangat pandai. 	小林さんは　とても　頭が　いいです。　	\N		\N	vmod				452	1
72	机の上	机の上	null		\N	vmod				\N	0
3793	教室の　電気を　つけて　ください。	教室の　電気を　つけて　ください。	\N		\N	vmod				802	1
157	100円です。	100円です。	null		\N	vmod				\N	0
1282	どんな　かばんですか。	どんな　かばんですか。	null		\N	vmod				\N	1
3846	Anjing kami comel betul. 	うちの　犬は　本当に　かわいいです。　	\N		\N	vmod				596	1
117	日本の古い映画です。	日本の古い映画です。	null		\N	vmod				\N	0
267	きょうは暑い日です。	きょうは暑い日です。	null		\N	vmod				\N	0
478	２と３で５です。	２と３で５です。	null		\N	vmod				\N	0
2174	こちらから　お電話　さしあげます。	こちらから　お電話　さしあげます。	null		\N	vmod				\N	1
2242	ジュースしかありません。	ジュースしかありません。	null		\N	vmod				\N	1
2412	税込みですか。	税込みですか。			\N	vmod				\N	1
2273	もう12時か。	もう12時か。	null		\N	vmod				\N	1
2440	ああ、　行ったけど。	ああ、　行ったけど。			\N	vmod				\N	1
2496	印刷センターのとなりです。	印刷センターのとなりです。			\N	vmod				\N	1
3794	辞書を　貸して　ください。	辞書を　貸して　ください。	\N		\N	vmod				802	1
2	朝ではありません。	朝ではありません。	null		\N	vmod				\N	0
3	学生です。	学生です。	null		\N	vmod				\N	0
140	それです。	それです。	null		\N	vmod				\N	0
291	頭が痛いですか。	頭が痛いですか。	null		\N	vmod				\N	0
335	"窓を開けました。	"窓を開けました。	null		\N	vmod				\N	0
838	日曜日だけれども、学校に行きますか。	日曜日だけれども、学校に行きますか。	null		\N	vmod				\N	0
868	近いなら歩きましょう。	近いなら歩きましょう。	null		\N	vmod				\N	0
1181	学校は休みではありません。	学校は休みではありません。	null		\N	vmod				\N	1
1224	教室に田中さんがいます。	教室に田中さんがいます。	null		\N	vmod				\N	1
1363	試験は終わりましたか。	試験は終わりましたか。	null		\N	vmod				\N	1
1503	いいえ、　知りません。	いいえ、　知りません。	null		\N	vmod				\N	1
1703	はい。	はい。	null		\N	vmod				\N	1
1774	はい。	はい。	null		\N	vmod				\N	1
1916	今ごろは、山田さんはひまにちがいありません。 	今ごろは、山田さんはひまにちがいありません。 	null		\N	vmod				\N	1
2089	花に水をやります。	花に水をやります。	null		\N	vmod				\N	1
2339	そう、それはよかった。	そう、それはよかった。			\N	vmod				\N	1
2432	私は　少し　バイトを　しようと　思って　いるの。	私は　少し　バイトを　しようと　思って　いるの。	①バイトをしようと思っているの　②予定を言う　③意向形（う／よう）と思います／思っています　④土曜日は映画を見ようと思っています		\N	vmod				\N	1
7	田中です。	田中です。	null		\N	vmod				\N	0
8	キムです。	キムです。	null		\N	vmod				\N	0
9	朝ではないです。	朝ではないです。	null		\N	vmod				\N	0
10	学生ではないです。	学生ではないです。	null		\N	vmod				\N	0
11	田中さんは学生です。	田中さんは学生です。	null		\N	vmod				\N	0
12	田中さんは学生ではありません。	田中さんは学生ではありません。	null		\N	vmod				\N	0
13	私が田中です。	私が田中です。	null		\N	vmod				\N	0
14	父は先生です。	父は先生です。	null		\N	vmod				\N	0
15	父は先生ではありません。	父は先生ではありません。	null		\N	vmod				\N	0
16	学校は休みです。	学校は休みです。	null		\N	vmod				\N	0
17	学校は休みではありません。	学校は休みではありません。	null		\N	vmod				\N	0
277	いいえ、元気ではありませんでした。	いいえ、元気ではありませんでした。	null		\N	vmod				\N	0
358	→(4)この花は小さくて赤いです。	→(4)この花は小さくて赤いです。	null		\N	vmod				\N	0
520	すみません、窓を開けてくださいませんか。	すみません、窓を開けてくださいませんか。	null		\N	vmod				\N	0
720	田中さんは来ますか。	田中さんは来ますか。	null		\N	vmod				\N	0
1232	ありません。	ありません。	null		\N	vmod				\N	1
1352	毎日、勉強しますか。	毎日、勉強しますか。	null		\N	vmod				\N	1
2602	じゃ、　授業の　後の　飲み会にも　来られませんか。	じゃ、　授業の　後の　飲み会にも　来られませんか。			\N	vmod				\N	1
2604	そうですか。	そうですか。			\N	vmod				\N	1
2627	そうですか。	そうですか。			\N	vmod				\N	1
2644	先輩。	先輩。			\N	vmod				\N	1
2658	はい。	はい。			\N	vmod				\N	1
4	学生ではありません。	学生ではありません。	null		\N	vmod				\N	0
2903	寒いので、　ドアを　閉めます。	寒いので、　ドアを　閉めます。	\N		\N	vmod				433	1
2785	Kami tanggalkan kasut di pintu masuk rumah. 	玄関で　靴を　脱ぎます。	\N		\N	vmod				208	1
2886	Oleh sebab sudah lewat malam, balik bersendirian adalah berbahaya.	もう　夜　遅いですから、　一人で　帰るのは　危ないです。	\N		\N	vmod				32	1
2943	Jepun adalah negara yang sempit.	日本は　狭い　国です。	\N		\N	vmod				210	1
2861	Ujian semalam mudah.	きのうの　テストは　易しかったです。	\N		\N	vmod				651	1
1841	はい、ほしいです。	はい、ほしいです。	null		\N	vmod				\N	1
2256	これくらいの大きさです。	これくらいの大きさです。	null		\N	vmod				\N	1
1940	あの人はどうやら歌手のようです。	あの人はどうやら歌手のようです。	null		\N	vmod				\N	1
660	はい。	はい。	null		\N	vmod				\N	0
1997	大きいのを１つください。	大きいのを１つください。	null		\N	vmod				\N	1
1097	そのくらいのことはわたしだってできます。	そのくらいのことはわたしだってできます。	null		\N	vmod				\N	0
2482	はい。	はい。			\N	vmod				\N	1
2673	何ですか。	何ですか。			\N	vmod				\N	1
1429	とても　勉強します。	とても　勉強します。	null		\N	vmod				\N	1
1469	映画を見た。	映画を見た。	null		\N	vmod				\N	1
1615	ゴミ箱にごみを捨てます。	ゴミ箱にごみを捨てます。	null		\N	vmod				\N	1
1697	これをください。	これをください。	null		\N	vmod				\N	1
1853	いいえ、すきではありません。	いいえ、すきではありません。	null		\N	vmod				\N	1
1902	田中さんは来ますか。	田中さんは来ますか。	null		\N	vmod				\N	1
2046	成績が60点以上だと合格です。	成績が60点以上だと合格です。	null		\N	vmod				\N	1
2298	今行きますよ。	今行きますよ。	null		\N	vmod				\N	1
2352	はい。	はい。			\N	vmod				\N	1
2445	かなり長かったよ。	かなり長かったよ。			\N	vmod				\N	1
2470	じゃ、これ、お願いします。	じゃ、これ、お願いします。			\N	vmod				\N	1
2560	どうもありがとう。	どうもありがとう。			\N	vmod				\N	1
2693	どうして。	どうして。			\N	vmod				\N	1
2732	ありがとう。	ありがとう。			\N	vmod				\N	1
3010	Adik perempuan pandai melukis.	妹は　絵が　上手です。	\N		\N	vmod				82	1
3332	Saya mengangkat tangan saya ke atas.	手を　上に　上げます。	\N		\N	vmod				11	1
3500	Gunung ini rendah.	この　山は　低いです。	\N		\N	vmod				542	1
3758	Bagaimana dengan kopi?	コーヒーは　いかがですか。	\N		\N	vmod				44	1
1461	この雑誌は新しい。	この雑誌は新しい。	null		\N	vmod				\N	1
1896	この　問題は、　あしたの　試験に　出るでしょうか。	この　問題は、　あしたの　試験に　出るでしょうか。	null		\N	vmod				\N	1
1897	たぶん　出るでしょう。	たぶん　出るでしょう。	null		\N	vmod				\N	1
1898	きのう、外語大のチームは勝ちましたか。	きのう、外語大のチームは勝ちましたか。	null		\N	vmod				\N	1
1899	わかりません。　でも、　たぶん　勝ったでしょう。	わかりません。　でも、　たぶん　勝ったでしょう。	null		\N	vmod				\N	1
1901	たぶん　田中さんでしょう。	たぶん　田中さんでしょう。	null		\N	vmod				\N	1
1903	たぶん　来ないでしょう。	たぶん　来ないでしょう。	null		\N	vmod				\N	1
1904	客：これはいくらでしょうか。	客：これはいくらでしょうか。	null		\N	vmod				\N	1
1905	店員：それは1000円です。	店員：それは1000円です。	null		\N	vmod				\N	1
1906	あしたは雨が降るだろう。	あしたは雨が降るだろう。	null		\N	vmod				\N	1
1907	田中さんは来ないだろう。	田中さんは来ないだろう。	null		\N	vmod				\N	1
1908	Aチームが勝っただろう。	Aチームが勝っただろう。	null		\N	vmod				\N	1
1909	あしたは日曜日でしょう？	あしたは日曜日でしょう？	null		\N	vmod				\N	1
1910	これは田中さんのでしょう？	これは田中さんのでしょう？	null		\N	vmod				\N	1
1911	わたしがさっき言ったでしょう。	わたしがさっき言ったでしょう。	null		\N	vmod				\N	1
1912	ほら、あそこにコンビニがあるでしょう。	ほら、あそこにコンビニがあるでしょう。	null		\N	vmod				\N	1
2574	なるほど。	なるほど。			\N	vmod				\N	1
1900	Di sana ada orang, kan. Siapakah orang itu?	あそこに　人が　いますね。　あの　人は　だれでしょう。	null		\N	vmod				\N	1
6	春ではありません。	春ではありません。	null		\N	vmod				\N	0
3435	Saya bangun pada pukul enam setiap pagi.	毎朝　六時に　起きます。	\N		\N	vmod				598	1
3511	Pembelajaran bahasa Jepun seronok.	日本語の　勉強は　楽しいです。	\N		\N	vmod				376	1
3765	Di manakah negara awak?	国は　どちらですか。	\N		\N	vmod				450	1
3877	Semuanya ada sepuluh.	全部で　十　あります。	\N		\N	vmod				440	1
3313	Tahun lepas adalah tahun yang baik.	去年は　いい　年でした。	\N		\N	vmod				448	1
3803	Saya makan roti separuh.	パンを　半分　食べました。	\N		\N	vmod				538	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: ms
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
20	1539	【よみ】\n あたま\n\n【意味】\n head	0	1
21	701	【よみ】\n あたらしい\n\n【意味】\n new\n fresh	0	1
22	1297	【よみ】\n あちら\n\n【意味 】\n that way\n that place over there\n ※ the more polite equivalent of "あそこ"\n\n that\n thing over there\n ※ the more polite equivalent of "あれ"	0	1
23	1540	【よみ】\n あつい\n\n【意味】\n thick\n heavy	0	1
24	1541	【よみ】\n あっち\n\n【意味】\n that way\n that place over there\n ※ the informal equivalent of "あちら"	0	1
25	444	【よみ】\n あと\n\n【意味】\n more ～	1	1
26	734	【よみ】\nあなた\n\n【意味】\n you\n ※ not used as plural	0	1
27	1287	【よみ】\n あに\n\n【意味】\n (my) older brother	0	1
28	1542	【よみ】\n あね\n\n【意味】\n (my) older sister	0	1
29	1543	【よみ】\n あの\n\n【意味】\n that ～\n that ～ over there	1	1
30	879	【よみ】\n あぱーと\n\n【意味】\n apartment	0	1
31	1544	【よみ】\n あびます\n\n【意味】\n take (a shower)	1	1
32	1545	【よみ】\n あぶない\n\n【意味】\n dangerous　	0	1
33	1154	【よみ】\n あまい\n\n【意味】\n sweet	0	1
34	806	【よみ】\n あまり\n\n【意味】\n not so	0	1
35	1546	よみ ： あめ	1	1
36	932	【よみ】\n あらいます\n\n【意味】\n wash	1	1
37	1548	【よみ】\n あります\n\n【意味】\n have	1	1
38	917	【よみ】\n あるきます\n\n【意味】\n walk	1	1
39	299	【よみ】\n あれ\n\n【意味】\n that\n thing over there	0	1
40	186	【よみ】\n いい\n\n【意味】\n good	0	1
41	8	【よみ】\n いいえ\n\n【意味】\n no	0	1
42	300	【よみ】\n いいます\n\n【意味】\n say	1	1
43	663	【よみ】\n いえ\n\n【意味】\n house\n home	0	1
44	86	【よみ】\n いかが\n\n【意味】\n Would you like ～ ?	0	1
45	334	【よみ】\n いきます\n\n【意味】\n go	1	1
46	745	【よみ】\n いくつ\n\n【意味】\n how many	0	1
47	151	【よみ】\n いくら\n\n【意味】\n how much	0	1
48	1549	【よみ】\n いけ\n\n【意味】\n pond	0	1
49	832	【よみ】\n いしゃ\n\n【意味】\n doctor	0	1
50	1550	【よみ】\n いす\n\n【意味】\n chair	1	1
51	1551	【よみ】\n いそがしい\n\n【意味】\n busy	0	1
52	818	【よみ】\n いたい\n\n【意味】\n painful\n have a pain	0	1
53	1552	【よみ】\n いち\n\n【意味】\n one	1	1
55	325	【よみ】\n いちばん\n\n【意味】\n the most\n the best	1	1
56	459	【よみ】\n いつ\n\n【意味】\n when	0	1
57	1554	【よみ】\n いつか\n\n【意味】\n fifth\n five days	0	1
58	1483	【よみ】\n いっしょ\n\n【意味】\n together\n with (someone)\n\n same	1	1
59	1555	【よみ】\n いつつ\n\n【意味】\n five	0	1
60	1107	【よみ】\n いつも\n\n【意味】\n always\n usually	0	1
61	654	【よみ】\n いぬ\n\n【意味】\n dog	0	1
62	134	【よみ】\n いま\n\n【意味】\n now	0	1
63	1556	【よみ】\n いみ\n\n【意味】\n meaning	0	1
64	1139	【よみ】\n いもうと\n\n【意味】\n (my) younger sister	0	1
65	1221	【よみ】\n いや\n\n【意味】\n nasty\n unpleasant\n don't like	0	1
66	1557	【よみ】\n いりぐち\n\n【意味】\n entrance	1	1
67	1559	【よみ】\n いります\n\n【意味】\n need\n require	1	1
68	158	【よみ】\n いれます\n\n【意味】\n put (into)\n pour	1	1
69	822	【よみ】\n いろ\n\n【意味】\n color	0	1
70	1503	【よみ】\n いろいろ\n\n【意味】\n e.g., いろいろ　ありがとう　ございます。\n → Thank you very much for everything.	1	1
71	670	【よみ】\n うえ\n\n【意味】\n on\n above\n over	0	1
72	1560	【よみ】\n うしろ\n\n【意味】\n back\n behind	1	1
73	1561	【よみ】\n うすい\n\n【意味】\n thin	0	1
74	825	【よみ】\n うた\n\n【意味】\n song	0	1
75	979	【よみ】\n うたいます\n\n【意味】\n sing	1	1
76	778	【よみ】\n うち\n\n【意味】\n house\n home	0	1
77	1562	【よみ】\n うまれます\n\n【意味】\n be born	1	1
78	920	【よみ】\n うみ\n\n【意味】\n sea\n ocean	0	1
79	1268	【よみ】\n うります\n\n【意味】\n sell	1	1
80	1563	【よみ】\n うるさい\n\n【意味】\n noisy	0	1
81	1564	【よみ】\n うわぎ\n\n【意味】\n jacket	0	1
82	707	【よみ】\n え\n\n【意味】\n picture	0	1
83	323	【よみ】\n えいが\n\n【意味】\n movie	0	1
84	1565	【よみ】\n えいがかん\n\n【意味】\n movie theater	0	1
85	169	【よみ】\n えいご\n\n【意味】\n English	0	1
86	41	【よみ】\n ええ\n\n【意味】\n yes	0	1
87	855	【よみ】\n えき\n\n【意味】\n station	0	1
88	294	【よみ】\n えれべーたー\n\n【意味】\n elevator	0	1
89	741	【よみ】\n ～えん\n\n【意味】\n ～yen	1	1
90	1416	【よみ】\n えんぴつ\n\n【意味】\n pencil	0	1
91	1566	よみ ： お～	1	1
92	801	【よみ】\n おいしい\n\n【意味】\n delicious\n tasty	0	1
93	412	【よみ】\n おおい\n\n【意味】\n many\n much	0	1
94	729	【よみ】\n おおきい\n\n【意味】\n big\n large	0	1
95	1567	【よみ】\n おおきな\n\n【意味】\n big\n large	0	1
96	1568	【よみ】\n おおぜい\n\n【意味】\n many people	0	1
97	959	【よみ】\n おかあさん\n\n【意味】\n (someone else's) mother	0	1
98	1569	【よみ】\n おかし\n\n【意味】\n confectionary	0	1
99	667	【よみ】\n おかね\n\n【意味】\n money	0	1
100	908	【よみ】\n おきます\n\n【意味】\n get up\n wake up	1	1
101	794	【よみ】\n おきます\n\n【意味】\n put	1	1
102	1570	【よみ】\n おくさん\n\n【意味】\n (someone else's) wife	0	1
103	1571	【よみ】\n おじさん\n\n【意味】\n (someone else's) uncle\n a middle aged man	1	1
104	1572	【よみ】\n おじいさん\n\n【意味】\n (someone else's) grandfather\n old man	0	1
105	420	【よみ】\n おしえます\n\n【意味】\n teach\n tell	1	1
106	1211	【よみ】\n おします\n\n【意味】\n push\n press	1	1
107	137	【よみ】\n おそい\n\n【意味】\n slow	1	1
108	1345	【よみ】\n おちゃ\n\n【意味】\n tea\n green tea	0	1
109	1573	【よみ】\n おてあらい\n\n【意味】\n toilet\n rest room	0	1
110	829	【よみ】\n おとうさん\n\n【意味】\n (someone else's) father	0	1
111	897	【よみ】\n おとうと\n\n【意味】\n (my) younger brother	0	1
112	1574	【よみ】\n おとこ\n\n【意味】\n man	0	1
113	1575	【よみ】\n おとこのこ\n\n【意味】\n boy	0	1
114	1576	【よみ】\n おととい\n\n【意味】\n the day before yesterday	0	1
115	1577	【よみ】\n おととし\n\n【意味】\n the year before last	0	1
116	1392	【よみ】\n おとな\n\n【意味】\n adult	0	1
117	1200	【よみ】\n おなか\n\n【意味】\n stomach	0	1
118	239	【よみ】\n おなじ\n\n【意味】\n the same	0	1
119	1578	【よみ】\n おにいさん\n\n【意味】\n (someone else's) older brother	0	1
120	1579	【よみ】\n おねえさん\n\n【意味】\n (someone else's) older sister	0	1
121	1580	【よみ】\n おばさん\n\n【意味】\n (someone else's) aunt\n a middle aged woman	1	1
122	1581	【よみ】\n おばあさん\n\n【意味】\n (someone else's) grandmother\n old woman	0	1
123	1582	【よみ】\n おふろ\n\n【意味】\n bath	0	1
124	1199	【よみ】\n おぼえます\n\n【意味】\n memorize	1	1
125	1583	【よみ】\n おまわりさん\n\n【意味】\n policeman	1	1
126	1584	【よみ】\n おもい\n\n【意味】\n heavy	0	1
127	800	【よみ】\n おもしろい\n\n【意味】\n interesting	0	1
128	895	【よみ】\n およぎます\n\n【意味】\n swim	1	1
129	1585	【よみ】\n おります\n\n【意味】\n get off\n get out of	1	1
130	775	【よみ】\n おわります\n\n【意味】\n end\n finish	1	1
131	470	【よみ】\n おんがく\n\n【意味】\n music	0	1
132	727	【よみ】\n おんな\n\n【意味】\n woman	0	1
133	1586	【よみ】\n おんなのこ\n\n【意味】\n girl	0	1
134	964	【よみ】\n ～かい\n\n【意味】\n ～times	1	1
135	422	【よみ】\n がいこく\n\n【意味】\n foreign country	0	1
136	1587	【よみ】\n がいこくじん\n\n【意味】\n foreigner	0	1
137	446	【よみ】\n かいしゃ\n\n【意味】\n company	0	1
138	1588	【よみ】\n かいだん\n\n【意味】\n staircase	0	1
139	851	【よみ】\n かいもの\n\n【意味】\n shopping	0	1
140	719	【よみ】\n かいます\n\n【意味】\n buy\n purchase	1	1
141	502	【よみ】\n かえします\n\n【意味】\n return\n give ～ back\n repay	1	1
142	1589	【よみ】\n かえります\n\n【意味】\n go home\n return	1	1
143	931	【よみ】\n かお\n\n【意味】\n face	0	1
144	1590	【よみ】\n かかります\n\n【意味】\n take\n ※ used when reffering to time or money	1	1
145	1591	【よみ】\n かぎ\n\n【意味】\n key\n lock	0	1
146	860	【よみ】\n かきます\n\n【意味】\n write\n draw\n paint	1	1
147	628	【よみ】\n がくせい\n\n【意味】\n student	0	1
758	1888	【よみ】\n のど\n\n【意味】\n throat	1	1
148	1592	【よみ】\n ～かげつ\n\n【意味】\n ～months	1	1
149	1593	よみ ： でんわをかける	0	1
150	1594	【よみ】\n かけます\n\n【意味】\n put on (glasses)	1	1
151	1595	【よみ】\n かさ\n\n【意味】\n umbrella	0	1
152	787	【よみ】\n かします\n\n【意味】\n lend	1	1
153	103	【よみ】\n かぜ\n\n【意味】\n cold\n flu	1	1
154	1008	【よみ】\n かぞく\n\n【意味】\n family	0	1
155	1597	【よみ】\n ～かた\n\n【よみ】\n person\n ※ always used with "この", "あの", etc.	1	1
156	1598	【よみ】\n かたかな\n\n【意味】\n Katakana script	1	1
157	1599	【よみ】\n ～がつ\n\n【意味】\n ～th month of the year	1	1
158	372	【よみ】\n がっこう\n\n【意味】\n school	0	1
159	1600	【よみ】\n かっぷ\n\n【意味】\n cup	0	1
160	1601	【よみ】\n かてい\n\n【意味】\n home\n family	0	1
161	1602	【よみ】\n かど\n\n【意味】\n corner\n edge	0	1
162	679	【よみ】\n かばん\n\n【意味】\n bag\n briefcase	0	1
163	1603	【よみ】\n かびん\n\n【意味】\n (flower) vase	0	1
164	1604	【よみ】\n かぶります\n\n【意味】\n put on (a hat, etc.)	1	1
165	1095	【よみ】\n かみ\n\n【意味】\n paper	0	1
166	1185	【よみ】\n かめら\n\n【意味】\n  camera	0	1
321	1688	【よみ】\n すずしい\n\n【意味】\n cool	0	1
167	1605	【よみ】\n かようび\n\n【意味】\n Tuesday	0	1
168	1378	【よみ】\n からい\n\n【意味】\n hot (of taste)\n spicy	0	1
169	1606	【よみ】\n からだ\n\n【意味】\n body	0	1
170	788	【よみ】\n かります\n\n【意味】\n borrow\n rent	1	1
171	1607	【よみ】\n ～がる\n\n【意味】\n (someone) want to ～	1	1
172	1608	【よみ】\n かるい\n\n【意味】\n light\n 	0	1
173	1609	【よみ】\n かれー\n\n【意味】\n curry (and rice)	0	1
174	1610	【よみ】\n かれんだー\n\n【意味】\n calendar	0	1
175	1611	【よみ】\n かわ\n\n【意味】\n river	1	1
176	1612	【よみ】\n ～がわ\n\n【意味】\n at the side of ～	1	1
177	1613	【よみ】\n かわいい\n\n【意味】\n pretty\n cute	0	1
178	319	【よみ】\n かんじ\n\n【意味】\n Chinese characters	0	1
179	1614	【よみ】\n き\n\n【意味】\n tree\n wood	0	1
180	1615	【よみ】\n きいろ\n\n【意味】\n yellow	0	1
181	1616	【よみ】\n きいろい\n\n【意味】\n yellow	0	1
182	1617	【よみ】\n きえます\n\n【意味】\n disappear\n go out	1	1
183	1618	【よみ】\n ききます\n\n【意味】\n ask	1	1
184	685	【よみ】\n きた\n\n【意味】\n north	0	1
185	1619	【よみ】\n ぎたー\n\n【意味】\n guitar	0	1
187	1621	【よみ】\n きっさてん\n\n【意味】\n tea room\n coffee shop	0	1
188	1374	【よみ】\n きって\n\n【意味】\n postage stamp	0	1
189	1622	【よみ】\n きっぷ\n\n【意味】\n ticket	0	1
190	1623	【よみ】\n きのう\n\n【意味】\n yesterday	1	1
192	1625	【よみ】\n ぎゅうにく\n\n【意味】\n beef	0	1
193	1626	【よみ】\n ぎゅうにゅう\n\n【意味】\n milk	0	1
194	5	【よみ】\n きょう\n\n【意味】\n today	1	1
195	664	【よみ】\n きょうしつ\n\n【意味】\n classroom\n lecture room	0	1
196	1627	【よみ】\n きょうだい\n\n【意味】\n brother(s) and sister(s)	0	1
197	205	【よみ】\n きょねん\n\n【意味】\n last year	0	1
198	1628	【よみ】\n きらい\n\n【意味】\n dislike	0	1
199	861	【よみ】\n きります\n\n【意味】\n cut	1	1
200	726	【よみ】\n きれい\n\n【意味】\n beautiful\n clean	0	1
201	1629	【よみ】\n ～きろ／きろぐらむ\n\n【意味】\n ～kilogram	1	1
202	1630	【よみ】\n ぎんこう\n\n【意味】\n bank	0	1
203	101	【よみ】\n きんようび\n\n【意味】\n Friday	0	1
205	1631	【よみ】\n くすり\n\n【意味】\n medicine (include ointment, eye lotion, etc.)	0	1
206	1632	【よみ】\n くだもの\n\n【意味】\n fruit	0	1
207	1633	【よみ】\n くち\n\n【意味】\n mouth	0	1
208	717	【よみ】\n くつ\n\n【意味】\n shoes	0	1
209	889	【よみ】\n くつした\n\n【意味】\n socks	0	1
210	1634	【よみ】\n くに\n\n【意味】\n country	1	1
211	1635	【よみ】\n くもり\n\n【意味】\n cloudy	0	1
212	1636	【よみ】\n くもります\n\n【意味】\n get cloudy	1	1
213	1637	【よみ】\n ～くらい／ぐらい\n\n【意味】\n about ～	1	1
214	1016	【よみ】\n くらす\n\n【意味】\n class\n homeroom	0	1
215	1638	【よみ】\n ～ぐらむ\n\n【意味】\n ～gram	1	1
217	278	【よみ】\n くるま\n\n【意味】\n car\n vehicle	0	1
218	1639	【よみ】\n くろ\n\n【意味】\n black	0	1
219	720	【よみ】\n くろい\n\n【意味】\n black	0	1
220	1640	【よみ】\n けいかん\n\n【意味】\n policeman	0	1
221	1641	【よみ】\n けさ\n\n【意味】\n this morning	1	1
222	854	【よみ】\n けします\n\n【意味】\n turn off	1	1
223	212	【よみ】\n けっこう\n\n【意味】\n very well	0	1
224	1395	よみ ： けっこん	0	1
225	1642	【よみ】\n けっこんします\n\n【意味】\n marry\n get married	1	1
226	869	【よみ】\n げつようび\n\n【意味】\n Monday	0	1
227	1643	【よみ】\n げんかん\n\n【意味】\n front door\n entrance hall	0	1
228	705	【よみ】\n げんき\n\n【意味】\n healthy\n cheerful	0	1
229	1644	【よみ】\n ～こ\n\n【意味】\n a term for counting eggs, confectionary, soap, etc.	1	1
230	1111	【よみ】\n ～ご\n\n【意味】\n ～ language	1	1
231	649	【よみ】\n こうえん\n\n【意味】\n park	0	1
232	1646	【よみ】\n こうさてん\n\n【意味】\n crossing\n intersection	0	1
233	1178	【よみ】\n こうちゃ\n\n【意味】\n black tea	0	1
234	1647	【よみ】\n こうばん\n\n【意味】\n police box	0	1
235	980	【よみ】\n こえ\n\n【意味】\n voice	0	1
236	1648	【よみ】\n こーと\n\n【意味】\n coat	0	1
237	1177	【よみ】\n こーひー\n\n【意味】\n coffee	0	1
238	21	【よみ】\n ここ\n\n【意味】\n here\n this place	0	1
239	1063	【よみ】\n ごご\n\n【意味】\n p.m\n afternoon	0	1
240	1649	【よみ】\n ここのか\n\n【意味】\n ninth\n nine days	0	1
241	1650	【よみ】\n ここのつ\n\n【意味】\n nine	0	1
242	1376	【よみ】\n ごぜん\n\n【意味】\n a.m\n morning	0	1
243	1651	【よみ】\n こたえます\n\n【意味】\n answer	1	1
244	161	【よみ】\n こちら\n\n【意味】\n this way\n this place\n ※ the more polite equivalent of "ここ"\n\n this\n ※ the more polite equivalent of "これ"	0	1
245	528	【よみ】\n こっち\n\n【意味】\n this way\n this place\n ※ the informal equivalent of "こちら"	0	1
247	970	【よみ】\n ことし\n\n【意味】\n this year	0	1
248	1653	【よみ】\n ことば\n\n【意味】\n word\n language	1	1
249	1654	【よみ】\n こども\n\n【意味】\n child	1	1
250	32	【よみ】\n この\n\n【意味】\n this ～\n this ～ here	0	1
251	1655	【よみ】\n ごはん\n\n【意味】\n a meal\n boiled rice	1	1
252	353	【よみ】\n こぴー\n\n【意味】\n copy	0	1
253	1656	【よみ】\n こぴーします\n\n【意味】\n copy	1	1
254	252	【よみ】\n こまります\n\n【意味】\n be in trouble	1	1
255	117	【よみ】\n これ\n\n【意味】\n this\n thing here	0	1
256	1657	【よみ】\n ～ころ／ごろ\n\n【意味】\n about (of time)	1	1
257	245	【よみ】\n こんげつ\n\n【意味】\n this month	0	1
258	1658	【よみ】\n こんしゅう\n\n【意味】\n this week	0	1
259	1659	【よみ】\n こんな\n\n【意味】\n such	0	1
260	1085	【よみ】\n こんばん\n\n【意味】\n this evening\n tonight	0	1
261	1066	【よみ】\n さあ\n\n【意味】\n right\n now\n ※ used when encouraging some course of action	0	1
262	1660	【よみ】\n ～さい\n\n【意味】\n ～years old	1	1
263	1661	【よみ】\n さいふ\n\n【意味】\n purse\n wallet	0	1
264	1406	【よみ】\n さかな\n\n【意味】\n fish	0	1
265	1662	【よみ】\n さき\n\n【意味】\n ahead	0	1
266	969	【よみ】\n さきます\n\n【意味】\n flower\n bloom\n blossom	1	1
267	1174	【よみ】\n さくぶん\n\n【意味】\n composition writing	0	1
268	1047	よみ ： さけ	0	1
269	1663	【よみ】\n さします\n\n【意味】\n put up (an umbrella)	1	1
270	742	【よみ】\n ～さつ\n\n【意味】\n a term for counting books etc.	1	1
271	743	【よみ】\n ざっし\n\n【意味】\n magazine	0	1
272	1664	【よみ】\n さとう\n\n【意味】\n sugar	0	1
273	799	【よみ】\n さむい\n\n【意味】\n cold\n ※ used when referring to temperature	0	1
274	1665	よみ ： さら	0	1
275	1666	【よみ】\n さらいねん\n\n【意味】\n the year after next	1	1
276	1668	【よみ】\n ～さん\n\n【意味】\n Mr.\n Mrs.\n Ms.\n ※ the title of respect added to a name	1	1
277	1669	【よみ】\n さんぽ\n\n【意味】\n walk	0	1
278	1670	【よみ】\n し／よん\n\n【意味】\n four	0	1
280	1671	【よみ】\n しお\n\n【意味】\n salt	0	1
281	1672	【よみ】\n しかし\n\n【意味】\n but\n however	0	1
282	1264	【よみ】\n じかん\n\n【意味】\n time	0	1
283	197	【よみ】\n しごと\n\n【意味】\n work\n job\n business	0	1
284	722	【よみ】\n じしょ\n\n【意味】\n dictionary	0	1
285	716	【よみ】\n しずか\n\n【意味】\n quiet\n still\n silent	0	1
286	671	【よみ】\n した\n\n【意味】\n under\n below\n beneath	0	1
287	1673	【よみ】\n しち／なな\n\n【意味】\n seven	0	1
288	666	【よみ】\n しつもん\n\n【意味】\n question	0	1
289	1093	【よみ】\n じてんしゃ\n\n【意味】\n bicycle	0	1
290	1674	【よみ】\n じどうしゃ\n\n【意味】\n automobile\n car	0	1
291	1675	【よみ】\n しにます\n\n【意味】\n die	1	1
292	1676	よみ ： じびき	0	1
293	317	【よみ】\n じぶん\n\n【意味】\n oneself	0	1
294	1193	【よみ】\n しまります\n\n【意味】\n close\n shut	1	1
295	1677	よみ ： しめます	1	1
296	68	【よみ】\n じゃあ\n\n【意味】\n well\n then\n in that case	1	1
297	946	【よみ】\n しゃしん\n\n【意味】\n photograph	0	1
298	972	【よみ】\n しゃつ\n\n【意味】\n shirt	0	1
299	1678	【よみ】\n しゃわー\n\n【意味】\n shower	0	1
300	1355	【よみ】　\n じゅう\n\n【意味】\n ten	0	1
301	1455	【よみ】\n ～しゅうかん\n\n【意味】\n ～week(s)	1	1
302	7	【よみ】\n じゅぎょう\n\n【意味】\n lesson\n class	0	1
303	303	【よみ】\n しゅくだい\n\n【意味】\n homework	0	1
304	1012	【よみ】\n じょうず\n\n【意味】\n good at\n skillful\n clever	0	1
305	1680	【よみ】\n じょうぶ\n\n【意味】\n healthy\n strong	0	1
306	1681	【よみ】\n しょうゆ\n\n【意味】\n soy sauce	1	1
307	909	【よみ】\n しょくどう\n\n【意味】\n lunchroom\n cafeteria	0	1
308	845	【よみ】\n しります\n\n【意味】\n know	1	1
309	1682	【よみ】\n しろ\n\n【意味】\n white	0	1
310	1094	【よみ】\n しろい\n\n【意味】\n white	0	1
311	1683	よみ ： じん	0	1
312	694	【よみ】\n しんぶん\n\n【意味】\n newspaper	0	1
313	270	【よみ】\n すいようび\n\n【意味】\n Wednesday	0	1
314	1684	【よみ】\n すいます\n\n【意味】\n smoke	1	1
315	1685	【よみ】\n すかーと\n\n【意味】\n skirt	0	1
316	324	【よみ】\n すき\n\n【意味】\n like	0	1
317	1686	【よみ】\n ～すぎ\n\n【意味】\n some minute past ～o'clock	1	1
318	1218	【よみ】\n すぐ／すぐに\n\n【意味】\n at once\n immediately	1	1
319	1687	【よみ】\n すくない\n\n【意味】\n few\n little	0	1
320	193	【よみ】\n すこし\n\n【意味】\n a few\n a litttle\n some	0	1
322	1689	【よみ】\n ～ずつ\n\n【意味】\n each\n ～ at one time	1	1
323	1690	【よみ】\n すとーぶ\n\n【意味】\n heater	0	1
324	1691	【よみ】\n すぷーん\n\n【意味】\n spoon	0	1
325	1099	【よみ】\n すぽーつ\n\n【意味】\n sport	0	1
326	962	【よみ】\n ずぼん\n\n【意味】\n trousers\n pants	0	1
327	880	【よみ】\n すみます\n\n【意味】\n live	1	1
328	1692	【よみ】\n すりっぱ\n\n【意味】\n mules\n scuffs	0	1
329	760	よみ ： する	0	1
330	915	【よみ】\n すわります\n\n【意味】\n sit down	1	1
331	815	【よみ】\n せ\n\n【意味】\n back\n height	0	1
332	1163	【よみ】\n せいと\n\n【意味】\n pupil\n student	0	1
333	1403	【よみ】\n せーたー\n\n【意味】\n sweater	0	1
334	1693	【よみ】\n せっけん\n\n【意味】\n soap	1	1
335	1694	よみ ： せびろ	0	1
336	821	【よみ】\n せまい\n\n【意味】\n narrow\n small (room etc.)	0	1
337	1695	【よみ】\n ぜろ\n\n【意味】\n zero	0	1
338	1696	【よみ】\n せん\n\n【意味】\n thousand	0	1
339	1400	【よみ】\n せんげつ\n\n【意味】\n last month	0	1
340	1283	【よみ】\n せんしゅう\n\n【意味】\n last week	0	1
341	2	【よみ】\n せんせい\n\n【意味】\n teacher\n instructor\n ※ not used when referring to one's own job\n\n doctor\n ※ used when addressing a medical doctor in stead of "Dr.～"	0	1
342	1697	【よみ】\n せんたく\n\n【意味】\n washing (clothes)	0	1
343	1698	【よみ】\n せんたくします\n\n【意味】\n wash (clothes)	1	1
344	214	【よみ】\n ぜんぶ\n\n【意味】\n all\n whole	0	1
345	45	【よみ】\n そう\n\n【意味】\n so	0	1
346	1074	【よみ】\n そうじ\n\n【意味】\n cleaning (room etc.)	0	1
347	1699	【よみ】\n そうじします\n\n【意味】\n clean (room etc.)	1	1
348	1700	【よみ】\n そして\n\n【意味】\n and\n ※ used when connecting sentences	1	1
349	524	【よみ】\n そこ\n\n【意味】\n there\n that place near the listener	0	1
350	1262	【よみ】\n そちら\n\n【意味】\n that way\n that place near the listener\n ※ the more polite equivalent of "そこ"\n\n that\n thing near the listener\n ※ the more polite equivalent of "それ"	0	1
351	531	【よみ】\n そっち\n\n【意味】\n that way\n that place\n ※ the informal equivalent of "そちら"	0	1
352	676	【よみ】\n そと\n\n【意味】\n outside\n outdoor	1	1
353	515	【よみ】\n その\n\n【意味】\n that ～\n that ～ near the listener	0	1
354	1701	【よみ】\n そば\n\n【意味】\n near\n close	0	1
355	938	【よみ】\n そら\n\n【意味】\n sky\n air	0	1
356	46	【よみ】\n それ\n\n【意味】\n that\n thing near the listener	0	1
357	31	【よみ】\n それから\n\n【意味】\n after that\n and then	0	1
358	1702	【よみ】\n それでは\n\n【意味】\n well then	0	1
359	1703	【よみ】\n ～だい\n\n【意味】\n ※ a term for counting machines, cars, etc.	1	1
360	425	【よみ】\n だいがく\n\n【意味】\n university\n college	0	1
361	1704	【よみ】\n たいしかん\n\n【意味】\n embassy	0	1
362	175	【よみ】\n だいじょうぶ\n\n【意味】\n all right	0	1
363	1481	【よみ】\n だいすき\n\n【意味】\n like ～ very much	0	1
364	1705	【よみ】\n たいせつ\n\n【意味】\n important\n valuable\n precious	0	1
365	1706	【よみ】\n だいどころ\n\n【意味】\n kitchen	0	1
366	91	【よみ】\n たいへん\n\n【意味】\n hard\n tough\n severe\n awful	1	1
367	803	【よみ】\n たかい\n\n【意味】\n tall\n high	1	1
368	1227	【よみ】\n たくさん\n\n【意味】\n many\n much	0	1
369	1707	【よみ】\n たくしー\n\n【意味】\n taxi	0	1
370	1708	【よみ】\n ～だけ\n\n【意味】\n only	1	1
371	786	【よみ】\n だします\n\n【意味】\n take ～ out\n send\n submit	1	1
372	1709	【よみ】\n ～たち\n\n【意味】\n ※ used when referring to person to show plural	1	1
373	839	【よみ】\n たちます\n\n【意味】\n stand up	1	1
374	1710	【よみ】\n たて\n\n【意味】\n vertical line	0	1
375	285	【よみ】\n たてもの\n\n【意味】\n building	0	1
376	941	【よみ】\n たのしい\n\n【意味】\n enjoyable	0	1
377	1290	【よみ】\n たのみます\n\n【意味】\n ask	1	1
378	1045	【よみ】\n たばこ\n\n【意味】\n tobacco\n cigarette	0	1
380	710	【よみ】\n たべもの\n\n【意味】\n food	0	1
381	337	【よみ】\n たべます\n\n【意味】\n eat\n have	1	1
382	877	【よみ】\n たまご\n\n【意味】\n egg	0	1
383	1712	【よみ】\n だれ\n\n【意味】\n who	0	1
384	1713	【よみ】\n だれか\n\n【意味】\n someone	0	1
385	1714	【よみ】\n たんじょうび\n\n【意味】\n birthday	0	1
386	1715	【よみ】\n だんだん\n\n【意味】\n gradually\n little by little	1	1
387	704	【よみ】\n ちいさい\n\n【意味】\n small\n little	0	1
388	1716	【よみ】\n ちいさな\n\n【意味】\n small\n little	0	1
389	1220	【よみ】\n ちかい\n\n【意味】\n near\n close	0	1
390	1019	【よみ】\n ちがいます\n\n【意味】\n differ	1	1
391	686	【よみ】\n ちかく\n\n【意味】\n near\n close	0	1
392	1717	【よみ】\n ちかてつ\n\n【意味】\n subway\n underground	0	1
393	1024	【よみ】\n ちず\n\n【意味】\n map	0	1
394	634	【よみ】\n ちち\n\n【意味】\n (my) father	0	1
395	1718	【よみ】\n ちゃいろ\n\n【意味】\n brown	0	1
396	1719	【よみ】\n ちゃわん\n\n【意味】\n rice bowl	1	1
398	423	【よみ】\n ちょうど\n\n【意味】\n just	0	1
399	152	【よみ】\n ちょっと\n\n【意味】\n a little while\n a little bit	0	1
400	1720	【よみ】\n ついたち\n\n【意味】\n first day of the month	1	1
401	507	【よみ】\n つかいます\n\n【意味】\n use	1	1
402	1721	【よみ】\n つかれます\n\n【意味】\n be tired	1	1
403	498	【よみ】\n つぎ\n\n【意味】\n next	0	1
404	1722	【よみ】\n つきます\n\n【意味】\n arrive\n reach	1	1
405	1723	【よみ】\n つくえ\n\n【意味】\n desk	0	1
406	1724	【よみ】\n つくります\n\n【意味】\n make\n produce\n manufacture	1	1
407	1725	【よみ】\n つけます\n\n【意味】\n turn on	1	1
408	1402	【よみ】\n つとめます\n\n【意味】\n work	1	1
409	120	【よみ】\n つまらない\n\n【意味】\n uninteresting\n worthless	0	1
410	1726	【よみ】\n つめたい\n\n【意味】\n cold\n ※ used when referring to touch	0	1
411	817	【よみ】\n つよい\n\n【意味】\n strong	0	1
412	1030	【よみ】\n て\n\n【意味】\n hand\n arm	0	1
413	918	【よみ】\n てーぷ\n\n【意味】\n (cassette) tape	0	1
414	1727	【よみ】\n てーぶる\n\n【意味】\n table	0	1
415	1728	よみ ： てーぷれこーだー	0	1
416	1729	【よみ】\n でかけます\n\n【意味】\n go out\n 	1	1
417	785	【よみ】\n てがみ\n\n【意味】\n letter	0	1
418	893	【よみ】\n できます\n\n【意味】\n be able to\n can	1	1
419	1730	よみ ： てください	0	1
420	1731	【よみ】\n でぐち\n\n【意味】\n exit	0	1
421	937	【よみ】\n てすと\n\n【意味】\n test\n examination	0	1
422	144	【よみ】\n では\n\n【意味】\n well then	0	1
423	874	【よみ】\n でぱーと\n\n【意味】\n department store	0	1
424	106	【よみ】\n でも\n\n【意味】\n though	0	1
425	553	【よみ】\n でます\n\n【意味】\n go out\n graduated from	1	1
426	761	【よみ】\n てれび\n\n【意味】\n television	0	1
427	1164	【よみ】\n てんき\n\n【意味】\n weather	0	1
428	853	【よみ】\n でんき\n\n【意味】\n electricity\n light	0	1
429	927	【よみ】\n でんしゃ\n\n【意味】\n electric train	0	1
430	109	【よみ】\n でんわ\n\n【意味】\n telephone\n telephone call	0	1
431	1732	【よみ】\n と\n\n【意味】\n door\n sliding door	0	1
432	1733	【よみ】\n ～ど\n\n【意味】\n ～degree(s)	1	1
433	1212	【よみ】\n どあ\n\n【意味】\n door	0	1
434	731	【よみ】\n といれ\n\n【意味】\n toilet\n rest room	0	1
435	291	【よみ】\n どう\n\n【意味】\n how	0	1
436	398	【よみ】\n どうして\n\n【意味】\n why	0	1
437	29	【よみ】\n どうぞ\n\n【意味】\n Please.\n Here you are.\n ※ used when offering someone something	0	1
438	1734	【よみ】\n どうぶつ\n\n【意味】\n animal	0	1
439	345	【よみ】\n どうも\n\n【意味】\n Well, thanks.	0	1
440	1735	【よみ】\n とお\n\n【意味】\n ten	1	1
441	1736	【よみ】\n とおい\n\n【意味】\n far\n long way	0	1
442	1737	【よみ】\n とおか\n\n【いみ】\n tenth\n ten days	0	1
443	750	よみ ： ～じ	1	1
444	1738	【よみ】\n ときどき\n\n【意味】\n sometimes	1	1
445	1137	【よみ】\n とけい\n\n【意味】\n clock\n watch	0	1
446	284	【よみ】\n どこ\n\n【意味】\n where\n what place	0	1
447	1739	【よみ】\n ところ\n\n【意味】\n place	0	1
448	1740	【よみ】\n とし\n\n【意味】\n year	1	1
449	138	【よみ】\n としょかん\n\n【意味】\n library	0	1
450	1299	【よみ】\n どちら\n\n【意味】\n which way\n where\n ※ the more polite equivalent of "どこ"\n\n which one (between two things)	0	1
451	1741	【よみ】\n どっち\n\n【意味】\n which way\n where\n ※ the informal equivalent of "どこ"\n\n which one (between two things)	0	1
452	42	【よみ】\n とても\n\n【意味】\n very\n very much	0	1
453	1358	【よみ】\n どなた\n\n【意味】\n who\n ※ the more polite equivalent of "だれ"	0	1
454	1742	【よみ】\n となり\n\n【意味】\n next\n next door	0	1
455	1743	【よみ】\n どの\n\n【意味】\n which ～\n ※ used when referring to three or more	0	1
456	982	【よみ】\n とびます\n\n【意味】\n fly	1	1
457	928	【よみ】\n とまります\n\n【意味】\n stop	1	1
458	190	【よみ】\n ともだち\n\n【意味】\n friend	0	1
459	562	【よみ】\n どようび\n\n【意味】\n Saturday	0	1
460	1156	【よみ】\n とり\n\n【意味】\n bird	0	1
461	1744	【よみ】\n とりにく\n\n【意味】\n chicken	1	1
462	1170	【よみ】\n とります\n\n【意味】\n take (a photograph)	1	1
463	296	【よみ】\n どれ\n\n【意味】\n which one (of three or more)	0	1
464	466	【よみ】\n どんな\n\n【意味】\n what kind of ～	0	1
465	1745	よみ ： ない	0	1
466	1746	【よみ】\n ないふ\n\n【意味】\n knife	0	1
467	675	【よみ】\n なか\n\n【意味】\n in\n inside	0	1
468	35	【よみ】\n ながい\n\n【意味】\n long	1	1
469	1747	【よみ】\n ～ながら\n\n【意味】\n with ～ing\n ※ not used for main action	1	1
470	1748	【よみ】\n なきます\n\n【意味】\n cry	1	1
471	1749	【よみ】\n なくします\n\n【意味】\n lose	1	1
472	440	【よみ】\n なぜ\n\n【意味】\n why	0	1
473	188	【よみ】\n なつ\n\n【意味】\n summer	0	1
474	184	【よみ】\n なつやすみ\n\n【意味】\n summer vacation	0	1
475	1750	【よみ】\n ～など\n\n【意味】\n and so on\n etc.	1	1
476	1751	【よみ】\n ななつ\n\n【意味】\n seven	0	1
477	123	【よみ】\n なん～\n\n【意味】\n what ～\n how ～	1	1
478	1752	【よみ】\n なのか\n\n【意味】\n seventh\n seven days	0	1
479	1032	【よみ】\n なまえ\n\n【意味】\n name	0	1
480	790	【よみ】\n ならいます\n\n【意味】\n learn	1	1
481	1753	【よみ】\n ならびます\n\n【意味】\n line up	1	1
482	1754	【よみ】\n ならべます\n\n【意味】\n arrange\n line up\n set	1	1
483	1755	【よみ】\n なります\n\n【意味】\n become	1	1
484	1756	【よみ】\n に\n\n【意味】\n two	1	1
485	1757	【よみ】\n にぎやか\n\n【意味】\n lively	0	1
486	1758	【よみ】\n にく\n\n【意味】\n meat	0	1
487	1079	【よみ】\n にし\n\n【意味】\n west	0	1
488	1759	【よみ】\n ～にち\n\n【意味】\n ～th day of the month\n ～days	1	1
489	758	【よみ】\n にちようび\n\n【意味】\n Sunday	0	1
490	1075	【よみ】\n にもつ\n\n【意味】\n baggage\n parcel	0	1
491	1265	【よみ】\n にゅーす\n\n【意味】\n news	0	1
492	929	【よみ】\n にわ\n\n【意味】\n garden	0	1
494	1760	【よみ】\n ぬぎます\n\n【意味】\n take off (clothes, shoes, hat, etc.)	1	1
495	1761	よみ ： ぬるい	1	1
496	1762	【よみ】\n ねくたい\n\n【意味】\n tie	0	1
497	681	【よみ】\n ねこ\n\n【意味】\n cat	0	1
498	1329	【よみ】\n ねます\n\n【意味】\n sleep\n go to bed	1	1
499	844	【よみ】\n ～ねん\n\n【意味】\n ～year(s)	1	1
500	657	【よみ】\n のーと\n\n【意味】\n notebook	0	1
501	923	【よみ】\n のぼります\n\n【意味】\n climb	1	1
502	1263	【よみ】\n のみもの\n\n【意味】\n drink	0	1
503	782	【よみ】\n のみます\n\n【意味】\n drink	1	1
504	952	【よみ】\n のります\n\n【意味】\n take\n ride\n get on / in	1	1
505	1763	【よみ】\n は\n\n【意味】\n tooth	0	1
506	764	【よみ】\n ぱーてぃー\n\n【意味】\n party	0	1
507	1764	【よみ】\n ～はい\n\n【意味】\n ※ a term for counting drinks	1	1
508	1765	【よみ】\n はいざら\n\n【意味】\n ashtray	0	1
509	993	【よみ】\n はいります\n\n【意味】\n enter\n take (a bath)	1	1
510	1375	【よみ】\n はがき\n\n【意味】\n post card	0	1
511	1766	【よみ】\n はきます\n\n【意味】\n put on (trousers, shoes, etc.)	1	1
512	703	【よみ】\n はこ\n\n【意味】\n box	0	1
513	1768	よみ ： はし	0	1
514	1769	【よみ】\n はじまります\n\n【意味】\n begin\n start	1	1
515	1770	【よみ】\n はじめ／はじめに\n\n【意味】\n the beginning	1	1
516	63	【よみ】\n はじめて\n\n【意味】\n for the first time	0	1
517	944	【よみ】\n はしります\n\n【意味】\n run	1	1
518	1002	【よみ】\n ばす\n\n【意味】\n bus	0	1
519	1771	よみ ： ばたー	0	1
520	1772	【よみ】\n はたち\n\n【意味】\n twenty years old\n twenty years of age	1	1
521	831	【よみ】\n はたらきます\n\n【意味】\n work	1	1
522	1773	【よみ】\n はち\n\n【意味】\n eight	0	1
523	1774	【よみ】\n はつか\n\n【意味】\n twentieth\n twenty days	0	1
524	1415	【よみ】\n はな\n\n【意味】\n nose	0	1
525	1776	【よみ】\n はなし\n\n【意味】\n talk\n speech\n story	0	1
526	865	【よみ】\n はなします\n\n【意味】\n talk\n speak	1	1
527	617	【よみ】\n はは\n\n【意味】\n (my) mother	0	1
528	1082	【よみ】\n はやい\n\n【意味】\n early\n	0	1
529	1778	【よみ】\n はります\n\n【意味】\n stick	1	1
530	646	【よみ】\n はれ\n\n【意味】\n sunny\n fair	0	1
531	1118	【よみ】\n はれます\n\n【意味】\n clear (up)	1	1
532	1466	【よみ】\n はん\n\n【意味】\n half	0	1
533	1391	【よみ】\n ～ばん\n\n【意味】\n number～	1	1
534	867	【よみ】\n ぱん\n\n【意味】\n bread	0	1
535	746	【よみ】\n はんかち\n\n【意味】\n handkerchief	0	1
536	1189	【よみ】\n ばんごう\n\n【意味】\n number	0	1
537	1779	【よみ】\n ばんごはん\n\n【意味】\n dinner\n supper	1	1
538	1780	【よみ】\n はんぶん\n\n【意味】\n half	0	1
539	1781	【よみ】\n ひがし\n\n【意味】\n east	0	1
540	1782	【よみ】\n ～ひき\n\n【意味】\n ※ a term for counting animals, fishes, etc.	1	1
541	1783	【よみ】\n ひきます\n\n【意味】\n play\n ※ used for stringed instruments or piano, etc.	1	1
542	1784	【よみ】\n ひくい\n\n【意味】\n low	0	1
544	678	【よみ】\n ひだり\n\n【意味】\n left	0	1
545	699	【よみ】\n ひと\n\n【意味】\n person\n people	0	1
546	1785	【よみ】\n ひとつ\n\n【意味】\n one	0	1
547	1786	よみ ： ひとつき	0	1
548	1007	【よみ】\n ひとり\n\n【意味】\n one person	1	1
549	1787	【よみ】　\n ひま\n\n【意味】\n free (time)	0	1
550	1788	【よみ】\n ひゃく\n\n【意味】\n hundred	0	1
551	579	【よみ】\n びょういん\n\n【意味】\n hospital	0	1
552	1003	【よみ】\n びょうき\n\n【意味】\n illness\n sickness\n disease	0	1
553	1789	【よみ】\n ひらがな\n\n【意味】\n Hiragana script	1	1
554	1790	【よみ】\n ひる\n\n【意味】\n daytime\n noon	0	1
555	1791	【よみ】\n ひるごはん\n\n【意味】\n lunch	1	1
556	807	【よみ】\n ひろい\n\n【意味】\n wide\n large\n spacious	0	1
557	1792	【よみ】\n ふぃるむ\n\n【意味】\n film	0	1
558	1793	【よみ】\n ふうとう\n\n【意味】\n envelope	0	1
559	688	【よみ】\n ぷーる\n\n【意味】\n swimming pool	0	1
560	1794	【よみ】\n ふぉーく\n\n【意味】\n fork	0	1
561	812	【よみ】\n ふく\n\n【意味】\n clothes	0	1
562	1796	【よみ】\n ふたつ\n\n【意味】\n two	0	1
563	1797	【よみ】\n ぶたにく\n\n【意味】\n pork	1	1
564	1798	【よみ】\n ふたり\n\n【意味】\n two person	1	1
565	1799	【よみ】\n ふつか\n\n【意味】\n second\n two days	0	1
566	1800	【よみ】\n ふとい\n\n【意味】\n fat\n thick	0	1
567	1801	【よみ】\n ふゆ\n\n【意味】\n winter	0	1
568	774	【よみ】\n ふります\n\n【意味】\n rain\n snow	1	1
569	713	【よみ】　\n ふるい\n\n【意味】\n old\n ※ used when referring to things	0	1
570	1052	よみ ： ふろ	0	1
571	753	【よみ】\n ～ふん\n\n【意味】\n ～minute(s)	1	1
572	1802	よみ ： ぶんしょう	0	1
573	859	【よみ】\n ～ぺーじ\n\n【意味】\n ～page(s)	1	1
574	1803	【よみ】\n へた\n\n【意味】\n poor at\n unskilled\n awkward	0	1
575	878	【よみ】\n べっど\n\n【意味】\n bed	0	1
576	1804	【よみ】\n ぺっと\n\n【意味】\n pet	0	1
577	661	【よみ】\n へや\n\n【意味】\n room	0	1
578	1208	【よみ】\n ～へん\n\n【意味】\n area\n ※ always used with "この", "あの", etc.	1	1
579	656	【よみ】\n ぺん\n\n【意味】\n pen	0	1
580	1805	【よみ】\n べんきょうします\n\n【意味】\n study	1	1
581	759	【よみ】\n べんきょう\n\n【意味】\n study	0	1
582	916	よみ ： べんとう	0	1
583	834	【よみ】\n べんり\n\n【意味】\n convenient	0	1
584	1806	【よみ】\n ほう\n\n【意味】\n ～er than\n ※ e.g., サッカーより 野球の ほうが 好きです。\n I like baseball better than soccer.	1	1
585	1807	【よみ】\n ぼうし\n\n【意味】\n hat\n cap	0	1
586	740	【よみ】\n ぼーるぺん\n\n【意味】\n ballpoint pen	0	1
588	1808	【よみ】\n ぽけっと\n\n【意味】\n pocket	0	1
589	682	【よみ】\n ぽすと\n\n【意味】\n mailbox\n postbox	0	1
590	1809	【よみ】\n ほしい\n\n【意味】\n want (something)	0	1
591	1810	【よみ】\n ほそい\n\n【意味】\n slender\n fine\n thin	0	1
592	356	【よみ】\n ぼたん\n\n【意味】\n button	0	1
593	598	【よみ】\n ほてる\n\n【意味】\n hotel	0	1
594	33	【よみ】\n ほん\n\n【意味】\n book	0	1
595	1811	【よみ】\n ほんだな\n\n【意味】\n bookshelf	0	1
596	18	【よみ】\n ほんとう\n\n【意味】\n real\n really	0	1
598	842	【よみ】\n まいあさ\n\n【意味】\n every morning	0	1
599	1812	【よみ】\n まいしゅう\n\n【意味】\n every week	0	1
600	1813	【よみ】\n まいつき／まいげつ\n\n【意味】\n every month	0	1
601	1814	【よみ】\n まいとし／まいねん\n\n【意味】\n every year	0	1
602	344	【よみ】\n まいにち\n\n【意味】\n every day	0	1
603	1815	【よみ】\n まいばん\n\n【意味】\n every night	0	1
604	672	【よみ】\n まえ\n\n【意味】\n front	0	1
605	846	【よみ】\n まがります\n\n【意味】\n turn\n curve	1	1
606	1816	【よみ】\n まずい\n\n【意味】\n bad\n ※ used when referring to taste	0	1
607	1489	【よみ】\n また\n\n【意味】\n again	0	1
608	777	【よみ】\n まだ\n\n【意味】\n not ～ yet	0	1
609	819	【よみ】\n まち\n\n【意味】\n town\n city	0	1
610	1037	【よみ】\n まちます\n\n【意味】\n wait	1	1
611	1817	【よみ】\n まっすぐ\n\n【意味】\n straight	0	1
612	1818	【よみ】\n まっち\n\n【意味】\n match	0	1
613	840	【よみ】\n まど\n\n【意味】\n window	0	1
614	1819	【よみ】\n まるい\n\n【意味】\n round\n circular	1	1
615	1013	【よみ】\n まん\n\n【意味】\n ten thousand	0	1
616	1820	よみ ： まんねんひつ	0	1
617	1821	【よみ】\n みがきます\n\n【意味】\n brush\n polish	1	1
618	677	【よみ】\n みぎ\n\n【意味】\n right	0	1
619	1822	【よみ】\n みじかい\n\n【意味】\n short	1	1
620	1823	【よみ】\n みず\n\n【意味】\n water	0	1
621	411	【よみ】\n みせ\n\n【意味】\n store\n shop	0	1
622	795	【よみ】\n みせます\n\n【意味】\n show	1	1
623	820	【よみ】\n みち\n\n【意味】\n road\n way	0	1
624	1824	【よみ】\n みっか\n\n【意味】\n third\n three days	0	1
625	1825	【よみ】\n みっつ\n\n【意味】\n three	0	1
626	1826	【よみ】\n みどり\n\n【意味】\n green	0	1
627	512	【よみ】\n みなさん\n\n【意味】\n everyone\n ※ the more polite equivalent of "みんな"	0	1
628	981	【よみ】\n みなみ\n\n【意味】\n south	0	1
629	1827	【よみ】\n みみ\n\n【意味】\n ear	0	1
630	784	【よみ】\n みます\n\n【意味】\n see\n look\n watch	1	1
631	1088	【よみ】\n みんな\n\n【意味】\n everyone	0	1
632	1828	【よみ】\n むいか\n\n【意味】\n sixth\n six days	0	1
633	1829	【よみ】\n むこう\n\n【意味】\n over there\n beyond	0	1
634	892	【よみ】\n むずかしい\n\n【意味】\n difficult	0	1
635	1830	【よみ】\n むっつ\n\n【意味】\n six	0	1
636	1831	【よみ】\n むら\n\n【意味】\n village	0	1
637	1832	【よみ】\n め\n\n【意味】\n eye	0	1
638	1109	【よみ】\n ～めーとる\n\n【意味】\n ～meter	1	1
639	1833	【よみ】\n めがね\n\n【意味】\n glasses	0	1
640	15	【よみ】\n もう\n\n【意味】\n already	1	1
641	1834	【よみ】\n もくようび\n\n【意味】\n Thursday	0	1
642	370	【よみ】\n もしもし\n\n【意味】\n hello.\n ※ used when calling on the phone	0	1
643	1076	【よみ】\n もちます\n\n【意味】\n have\n hold\n carry	1	1
644	1835	【よみ】\n もっと\n\n【意味】\n more	0	1
645	1836	【よみ】\n もの\n\n【意味】\n thing	0	1
646	772	【よみ】\n もん\n\n【意味】\n gate	0	1
647	858	【よみ】\n もんだい\n\n【意味】\n question\n problem	0	1
648	1837	【よみ】\n ～や\n\n【意味】\n ～ store	1	1
649	1838	【よみ】\n やおや\n\n【意味】\n fruit and vegetable store	0	1
650	1839	【よみ】\n やさい\n\n【意味】\n vegetable	0	1
651	1840	【よみ】\n やさしい\n\n【意味】\n easy	0	1
652	410	【よみ】\n やすい\n\n【意味】\n low-priced\n cheap\n inexpensive	0	1
653	635	【よみ】\n やすみ\n\n【意味】\n rest\n holiday\n absence	0	1
654	767	【よみ】\n やすみます\n\n【意味】\n take a holiday\n be absent from\n be closed	1	1
655	1841	【よみ】\n やっつ\n\n【意味】\n eight	0	1
656	922	【よみ】\n やま\n\n【意味】\n mountain	0	1
657	1018	【よみ】\n やります\n\n【意味】\n do	1	1
658	1842	【よみ】\n ゆうがた\n\n【意味】\n evening	0	1
659	1266	【よみ】\n ゆうはん\n\n【意味】\n dinner\n supper	0	1
660	1843	【よみ】\n ゆうびんきょく\n\n【意味】\n post office	0	1
661	1844	【よみ】\n ゆうべ\n\n【意味】\n last night\n yesterday evening	1	1
662	1845	【よみ】\n ゆうめい\n\n【意味】\n famous	0	1
663	1846	【よみ】\n ゆき\n\n【意味】\n snow	0	1
664	1847	【よみ】\n ゆっくり\n\n【意味】\n slowly\n leisurely	0	1
665	1848	【よみ】\n ようか\n\n【意味】\n eighth\n eight days	0	1
666	1849	【よみ】\n ようふく\n\n【意味】\n clothes	0	1
668	53	【よみ】\n よこ\n\n【意味】\n horizontal line\n \n next \n next door	0	1
669	1850	【よみ】\n よっか\n\n【意味】\n fourth\n four days	0	1
670	559	【よみ】\n よっつ\n\n【意味】\n four	0	1
671	1851	【よみ】\n よびます\n\n【意味】\n call	1	1
672	836	【よみ】\n よみます\n\n【意味】\n read	1	1
673	1203	【よみ】\n よる\n\n【意味】\n night\n evening	0	1
675	1162	【よみ】\n らいげつ\n\n【意味】\n next month	0	1
676	269	【よみ】\n らいしゅう\n\n【意味】\n next week	0	1
677	454	【よみ】\n らいねん\n\n【意味】\n next year	0	1
678	1853	【よみ】\n らじお\n\n【意味】\n radio	0	1
679	1854	【よみ】\n らじかせ\n\n【意味】\n radio cassette player / recorder	0	1
680	1531	【よみ】\n りっぱ\n\n【意味】\n fine\n stately	1	1
681	881	【よみ】\n りゅうがくせい\n\n【意味】\n foreign student	0	1
682	1855	【よみ】\n りょうしん\n\n【意味】\n parents	0	1
683	339	【よみ】\n りょうり\n\n【意味】\n dish\n food\n cooking	0	1
684	200	【よみ】\n りょこう\n\n【意味】\n travel	0	1
685	1856	【よみ】\n りょこうします\n\n【意味】\n travel	1	1
686	1857	【よみ】\n れい\n\n【意味】\n zero	0	1
687	1858	【よみ】\n れいぞうこ\n\n【意味】\n refrigerator	0	1
688	1859	よみ ： れこーど	0	1
689	1401	【よみ】\n れすとらん\n\n【意味】\n restaurant	0	1
690	552	【よみ】\n れんしゅう\n\n【意味】\n practice	0	1
691	1860	【よみ】\n れんしゅうします\n\n【意味】\n practice	1	1
692	1861	【よみ】\n ろうか\n\n【意味】\n corridor	0	1
693	1862	【よみ】\n ろく\n\n【意味】\n six	0	1
694	1863	よみ ： わいしゃつ	0	1
695	886	【よみ】\n わかい\n\n【意味】\n young\n	0	1
696	1422	【よみ】\n わかります\n\n【意味】\n understand	1	1
697	1381	【よみ】\n わすれます\n\n【意味】\n forget	1	1
698	13	【よみ】\n わたくし\n\n【意味】\n I\n ※ the more polite equivalent of "わたし"	0	1
700	1242	【よみ】\n わたします\n\n【意味】\n hand	1	1
701	1067	【よみ】\n わたります\n\n【意味】\n across	1	1
702	557	【よみ】\n わるい\n\n【意味】\n bad	0	1
704	693	【よみ】\n ～かい\n\n【意味】\n ～th floor	1	1
705	1271	【よみ】\n きます\n\n【意味】\n put on (a shirt, etc.)	1	1
706	1357	【よみ】\n あつい\n\n【意味】\n hot	1	1
707	1324	【よみ】\n くらい\n\n【意味】\n dark	1	1
708	1317	【よみ】\n ばん\n\n【意味】\n night\n evening	1	1
709	1866	【よみ】\n ～じん\n\n【意味】\n ※ used for suffix putting after one's native country to show own nationality	1	1
710	388	【よみ】\n あめ\n\n【意味】\n rain	1	1
711	1596	【よみ】\n かぜ\n\n【意味】\n wind	1	1
712	182	【よみ】\n あつい\n\n【意味】\n hot	1	1
713	1795	【よみ】\n ふきます\n\n【意味】\n blow	1	1
714	172	【よみ】\n わたし\n\n【意味】\n I	1	1
715	610	【よみ】\n かいがい\n\n【意味】\n foreign countries	1	1
716	1777	【よみ】\n はやい\n\n【意味】\n fast	1	1
717	1767	【よみ】\n はし\n\n【意味】\n bridge	1	1
718	1865	【よみ】\n さんぽします\n\n【意味】\n take a walk	1	1
719	1867	【よみ】\n ふどうさんや\n\n【意味】\n real estate bussiness	1	1
720	1868	【よみ】\n おさら\n\n【意味】\n dish\n plate	1	1
721	1869	【よみ】\n おさけ\n\n【意味】\n alcoholic drinks	1	1
722	1870	【よみ】\n びよういん\n\n【意味】\n beauty parlor	1	1
723	1871	【よみ】\n ください\n\n【意味】\n Give me ～, please.	1	1
724	629	【よみ】\n はる\n\n【意味】\n spring	1	1
725	1775	【よみ】\n はな\n\n【意味】\n flower\n blossom	1	1
726	1872	【よみ】\n ほか\n\n【意味】\n other	1	1
727	1547	よみ ： ある	1	1
728	11	【よみ】\n あります\n\n【意味】\n be\n exist\n ※ used when referring to inanimate things	1	1
729	1873	【よみ】\n たかい\n\n【意味】\n expensive\n high	1	1
730	1874	【よみ】\n たいへん\n\n【意味】\n very	1	1
731	1121	【よみ】\n たぶん\n\n【意味】\n probably\n perhaps\n maybe	1	1
732	115	【よみ】\n よく\n\n【意味】\n often	1	1
733	1875	【よみ】\n よく\n\n【意味】\n well\n much	1	1
734	1667	【よみ】\n さん\n\n【意味】\n three	1	1
735	1876	【よみ】\n よん ／ し \n\n【意味】\n four	1	1
736	1645	【よみ】\n ご\n\n【意味】\n five	1	1
737	1877	【よみ】\n なな／しち\n\n【意味】\n seven	1	1
738	1878	【よみ】\n く ／ きゅう\n\n【意味】\n nine	1	1
739	659	【よみ】\n もう\n\n【意味】\n more ～\n another ～	1	1
740	1	【よみ】\n あの\n\n【意味】\n well\n ※ used to show one's hesitation	1	1
741	28	【よみ】\n はい\n\n【意味】\n yes	1	1
742	1879	【よみ】\n ～きろ／きろめーとる\n\n【意味】\n kilometer	1	1
743	1880	よみ ： ～にん	1	1
744	1881	【よみ】\n ～ほん\n\n【意味】\n ※ a term for counting pencils, trees, cigarettes, etc.	1	1
745	1882	【よみ】\n ～まえ\n\n【意味】\n before ～	1	1
746	1883	【よみ】\n ～じかん\n\n【意味】\n ～hour(s)	1	1
747	1020	【よみ】\n ～とき\n\n【意味】\n at the time of ～	1	1
748	1884	【よみ】\n ～じ\n\n【意味】\n ～o'clock	1	1
750	852	【よみ】\n しめます\n\n【意味】\n close\n shut	1	1
751	1342	よみ ： ひく	1	1
752	1450	【よみ】\n とります\n\n【意味】\n take\n pass	1	1
753	1886	【よみ】\n かけます\n\n【意味】\n make (a telephone call)	1	1
754	1558	【よみ】\n います\n\n【意味】\n exist\n be\n ※used when referring to animate things	1	1
755	1864	【よみ】\n おべんとう\n\n【意味】\n box lunch	1	1
756	1887	【よみ】\n ぶん\n\n【意味】\n sentence	1	1
757	576	【よみ】\n ねつ\n\n【意味】\n fever	1	1
759	762	【よみ】\n ぴあの\n\n【意味】\n piano	1	1
760	1889	【よみ】\n します\n\n【意味】\n do	1	1
761	1890	【よみ】\n ひきます\n\n【意味】\n catch (a cold)	1	1
762	1891	【よみ】\n びようし\n\n【意味】\n beautician	1	1
763	1892	【よみ】\n しゃんぷー\n\n【意味】\n shampoo	1	1
764	814	【よみ】\n かみ\n\n【意味】\n hair	1	1
765	1893	【よみ】\n えきいん\n\n【意味】\n station staff	1	1
766	1399	【よみ】\n こたえ\n\n【意味】\n answer	1	1
767	1894	【よみ】\n でんわばんごう\n\n【意味】\n telephone number	1	1
768	1439	【よみ】\n れんらく\n\n【意味】\n contact	1	1
769	1895	【よみ】\n れんらくします\n\n【意味】\n contact	1	1
770	1896	【よみ】\n みつかります\n\n【意味】\n be found	1	1
771	1897	【よみ】\n 聞きます\n\n【意味】\n hear\n listen	1	1
772	1898	【よみ】\n やちん\n\n【意味】\n rent	1	1
773	1899	【よみ】\n さがします\n\n【意味】\n look for	1	1
774	1123	【よみ】\n てんいん\n\n【意味】\n store clerk\n shop assistant	1	1
775	1900	【よみ】\n ていしょく\n\n【意味】\n set meal	1	1
776	1901	【よみ】\n みるく\n\n【意味】\n milk	1	1
777	870	【よみ】\n さっかー\n\n【意味】\n soccer\n football	1	1
778	924	【よみ】\n やきゅう\n\n【意味】\n baseball	1	1
779	796	【よみ】\n てにす\n\n【意味】\n tennis	1	1
830	791	【よみ】\n かべ\n\n【意味】\n wall	1	1
780	1902	【よみ】\n うりば\n\n【意味】\n counter (in a shop, department store, etc.)	1	1
781	1485	【よみ】\n かーど\n\n【意味】\n credit card	1	1
782	1903	【よみ】\n ゆうびんきょくいん\n\n【意味】\n post office clerk	1	1
783	1904	【よみ】\n こうくうびん\n\n【意味】\n airmail	1	1
784	1905	【よみ】\n ふなびん\n\n【意味】\n sea mail	1	1
785	1906	【よみ】\n おくります\n\n【意味】\n send	1	1
786	1907	【よみ】\n すーつ\n\n【意味】\n suit	1	1
787	1908	【よみ】\n かいしゃいん\n\n【意味】\n company employee\n office worker	1	1
788	875	【よみ】\n すーぱー\n\n【意味】\n supermarket	1	1
789	1909	【よみ】\n おはし\n\n【意味】\n chopsticks	1	1
790	925	【よみ】\n しあい\n\n【意味】\n game\n match	1	1
791	1620	【よみ】\n きたない\n\n【意味】\n dirty	1	1
792	1910	【よみ】\n ぎんこういん\n\n【意味】\n bank employee\n bank clerk	1	1
793	1911	【よみ】\n まどぐち\n\n【意味】\n window	1	1
794	1912	【よみ】\n 振り込み\n\n【意味】\n payment	1	1
795	363	【よみ】\n ようし\n\n【意味】\n form	1	1
796	600	【よみ】\n じゅうしょ\n\n【意味】\n address	1	1
797	926	【よみ】\n たいふう\n\n【意味】\n typhoon	1	1
798	1913	【よみ】\n おそい\n\n【意味】\n late	1	1
799	1914	【よみ】\n できます\n\n【意味】\n be built\n be constructed	1	1
800	1915	【よみ】\n します\n\n【意味】\n put on (a tie)	1	1
801	1916	【よみ】\n やすみます\n\n【意味】\n take a rest	1	1
802	1917	【よみ】\n ください\n\n【意味】\n Please ～.	1	1
803	1918	【よみ】\n つけます\n\n【意味】\n pickle\n soak	1	1
804	1919	【よみ】\n みじかい\n\n【意味】\n short	1	1
805	1920	【よみ】\n ながい\n\n【意味】\n long	1	1
806	273	【よみ】\n くうこう\n\n【意味】\n airport	1	1
807	1411	【よみ】\n ぱすぽーと\n\n【意味】\n passport	1	1
808	1921	【よみ】\n がいど\n\n【意味】\n guide	1	1
809	1922	【よみ】\n とまります\n\n【意味】\n stay	1	1
810	1923	【よみ】\n おみやげ\n\n【意味】\n souvenir	1	1
811	71	【よみ】\n にほんご\n\n【意味】\n Japanese	1	1
812	974	【よみ】\n じ\n\n【意味】\n character\n letter	1	1
813	1924	【よみ】\n ～にん\n\n【意味】\n ※ a term for counting person	1	1
597	747	【よみ】\n ～まい\n\n【意味】\n ※ a term for counting paper, photographs, clothes, etc. 	1	1
749	222	【よみ】\n ～じゅう\n\n【意味】\n all (time) long\n\n all over ～	1	1
674	1852	【よみ】\n よわい\n\n【意味】\n weak	0	1
1	24	【よみ】\n ああ\n\n【意味】\n right\nnow\n	0	1
2	903	【よみ】\n あいます\n\n【意味】\n meet	1	1
3	1065	【よみ】\n あお\n\n【意味】\n blue	0	1
4	939	【よみ】\n あおい\n\n【意味】\n blue	0	1
5	1026	【よみ】\n あか\n\n【意味】\n red	0	1
6	802	【よみ】\n あかい\n\n【意味】\n red	0	1
7	1533	【よみ】\n あかるい\n\n【意味】\n bright\n light	0	1
8	696	【よみ】\n あき\n\n【意味】\n autumn	0	1
9	841	【よみ】\n あきます\n\n【意味】\n open	1	1
10	863	【よみ】\n あけます\n\n【意味】\n open	1	1
11	1534	【よみ】\n あげます\n\n【意味】\n raise\n lift up	1	1
12	6	【よみ】\n あさ\n\n【意味】\n morning	0	1
13	1535	【よみ】\n あさごはん\n\n【意味】\n breakfast	1	1
14	1536	【よみ】\n あさって\n\n【意味】\n the day after tomorrow\n	0	1
15	375	【よみ】\n あし\n\n【意味】\n leg\n foot	0	1
16	61	【よみ】\n あした\n\n【意味】\n tomorrow\n	1	1
17	293	【よみ】\n あそこ\n\n【意味】\n there\nthat place over there	0	1
18	1537	【よみ】\n あそびます\n\n【意味】\n enjoy oneself\n play	1	1
19	1538	【よみ】\n あたたかい\n\n【意味】\n warm	1	1
216	185	よみ ： くる	0	1
379	1711	よみ ： たぶん	0	1
814	1925	【よみ】\n ごしゅじん\n\n【意味】\n (someone else's) hasband	1	1
815	1926	【よみ】\n いもうとさん\n\n【意味】\n (someone else's) younger sister	1	1
816	1927	【よみ】\n おとうと\n\n【意味】\n (someone else's) younger brother	1	1
817	1928	【よみ】\n いれます\n\n【意味】\n turn on	1	1
818	1929	【よみ】\n きります\n\n【意味】\n turn off\n switch off	1	1
819	1930	【よみ】\n きます\n\n【意味】\n come	1	1
820	1931	【よみ】\n くに\n\n【意味】\n (one's) home country	1	1
821	1932	【よみ】\n あとで\n\n【意味】\n later	1	1
822	1933	【よみ】\n なに／なん\n\n【意味】\n what	1	1
823	702	【よみ】\n こんぴゅーたー\n\n【意味】\n computer	1	1
824	1934	【よみ】\n やめます\n\n【意味】\n quit\n stop\n give up	1	1
825	1935	【よみ】\n もらいます\n\n【意味】\n receive\n be given	1	1
826	1936	【よみ】\n しんぱいします\n\n【意味】\n worry\n be anxious about	1	1
827	1937	【よみ】\n けいたいでんわ\n\n【意味】\n cellular phone	1	1
828	781	【よみ】\n コーラ\n\n【意味】\n cola	1	1
829	738	【よみ】\n ケーキ\n\n【意味】\n cake	1	1
831	978	【よみ】\n からおけ\n\n【意味】\n karaoke	1	1
832	905	【よみ】\n こんさーと\n\n【意味】\n concert	1	1
833	1938	【よみ】\n あげます\n\n【意味】\n give\n　	1	1
834	1053	【よみ】\n すいっち\n\n【意味】\n switch	1	1
835	1939	【よみ】\n いろいろ\n\n【意味】\n various	1	1
836	1940	【よみ】\n よびます\n\n【意味】\n call	1	1
837	1941	【よみ】\n つづきます\n\n【意味】\n continue\n last	1	1
838	1942	【よみ】\n かくにんします\n\n【意味】\n confirm\n make sure	1	1
839	1943	【よみ】\n おもいます\n\n【意味】\n think	1	1
840	1944	【よみ】\n はんたい\n\n【意味】\n opposite\n reverse	1	1
841	1048	【よみ】\n だめ\n\n【意味】\n no\n not good	1	1
842	1945	【よみ】\n おと\n\n【意味】\n sound	1	1
843	1946	【よみ】\n ぐるーぷ\n\n【意味】\n group	1	1
844	1624	【よみ】\n きゅう / く\n\n【意味】\n nine	1	1
54	1553	【よみ】\n いちにち\n\n【意味】\n a [one] day	0	1
246	1652	【よみ】\n こっぷ\n\n【意味】\n glass	0	1
397	1679	【よみ】\n ～ちゅう\n\n【意味】\n in the midst of ～	1	1
543	898	【よみ】\n ひこうき\n\n【意味】\n airplane	0	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
104	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
105	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
106	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
107	94270	3.1912999	3.19	相	関係	量	速度	遅い	遅い	おそい
108	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
161	12060	1.181	1.18	体	関係	形	角など	角（かど）	角	かど
1	100403	4.3010001	4.30	他		感動	間投	ああ	ああ	ああ
2	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
3	58059	1.502	1.50	体	自然	自然	色	青	青	あお
4	99141	3.5020001	3.50	相	自然	自然	色	青い	青い	あおい
5	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
6	99131	3.5020001	3.50	相	自然	自然	色	赤い	赤い	あかい
7	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
8	8389	1.1624	1.16	体	関係	時間	季節	秋	秋	あき
9	72632	2.1552999	2.15	用	関係	作用	開閉・封	開く	開く	あく
10	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
11	71867	2.154	2.15	用	関係	作用	上がり・下がり	上げる	上げる	あげる
12	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
13	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
14	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
15	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
16	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
17	9991	1.17	1.17	体	関係	空間	空間・場所	あそこ	あそこ	あそこ
18	82317	2.3369999	2.33	用	活動	生活	遊楽	遊ぶ	遊ぶ	あそぶ
19	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
20	64318	1.5601	1.56	体	自然	身体	頭・目鼻・顔	頭（あたま）	頭	あたま
21	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
22	9996	1.17	1.17	体	関係	空間	空間・場所	あちら	あちら	あちら
23	94048	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	厚い	厚い	あつい
24	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
25	9700	1.1670001	1.16	体	関係	時間	時間的前後	後（あと）	後	あと
26	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
27	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
28	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
29	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
30	52432	1.4400001	1.44	体	生産物	住居	住居	アパート	アパート	あぱあと
31	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
32	92298	3.1345999	3.13	相	関係	様相	難易・安危	危ない	危ない	あぶない
33	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
34	94420	3.1919999	3.19	相	関係	量	程度	あまり	あまり	あまり
35	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
36	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
37	67418	2.1199999	2.12	用	関係	存在	存在	有る	有る	ある
38	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
39	159	1.101	1.10	体	関係	事柄	こそあど・他	あれ	あれ	あれ
40	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
41	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
42	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
43	52391	1.4400001	1.44	体	生産物	住居	住居	家（いえ）	家	いえ
44	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
45	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
46	14656	1.196	1.19	体	関係	量	数記号（一二三）	いくつ	いくつ	いくつ
47	14658	1.196	1.19	体	関係	量	数記号（一二三）	いくら	いくら	いくら
48	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
49	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
50	53482	1.447	1.44	体	生産物	住居	家具	椅子（いす）	椅子	いす
51	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
52	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
53	14329	1.196	1.19	体	関係	量	数記号（一二三）	一（いち）	一	いち
533	8901	1.1635	1.16	体	関係	時間	朝晩	晩	晩	ばん
54	8585	1.1633	1.16	体	関係	時間	日	一日（いちにち）	一日	いちにち
55	622	1.1101	1.11	体	関係	類	等級・系列	一番	一番	いちばん
56	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
57	14591	1.196	1.19	体	関係	量	数記号（一二三）	五日（いつか）	五日	いつか
58	6224	1.1551	1.15	体	関係	作用	統一・組み合わせ	一緒	一緒	いっしょ
59	14369	1.196	1.19	体	関係	量	数記号（一二三）	五つ	五つ	いつつ
60	92959	3.1600001	3.16	相	関係	時間	時間	いつも	いつも	いつも
61	62994	1.5501	1.55	体	自然	動物	哺乳類	犬	犬	いぬ
62	8987	1.1641001	1.16	体	関係	時間	現在	今（いま）	今	いま
63	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
64	16811	1.214	1.21	体	主体	家族	兄弟	妹	妹	いもうと
65	95614	3.302	3.30	相	活動	心	好悪・愛憎	嫌（いや）	嫌	いや
66	12249	1.183	1.18	体	関係	形	穴・口	入（い）り口	入り口	いりぐち
67	87018	2.3710999	2.37	用	活動	経済	需給	要る	要る	いる
68	88558	2.3842001	2.38	用	活動	事業	炊事・調理	入れる［茶を～］	入れる	いれる
69	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
70	92011	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	いろいろ	いろいろ	いろいろ
71	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
72	10983	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後ろ	後ろ	うしろ
73	94052	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	薄い	薄い	うすい
74	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
75	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
76	52392	1.4400001	1.44	体	生産物	住居	住居	うち（家）	うち	うち
77	67730	2.1210999	2.12	用	関係	存在	発生・復活	うまれる（生・産）	うまれる	うまれる
78	61075	1.526	1.52	体	自然	天地	海・島	海（うみ）	海	うみ
79	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
80	99215	3.503	3.50	相	自然	自然	音	うるさい	うるさい	うるさい
81	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
82	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
83	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
84	23133	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	映画館	映画館	えいがかん
85	30580	1.3101	1.31	体	活動	言語	言語	英語	英語	えいご
86	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
87	22785	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	駅	駅	えき
88	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
89	15325	1.1962	1.19	体	関係	量	助数接辞	円	円	えん
90	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
91	101029	4.3319998	4.33	他		挨拶	手紙用語など	お－	お－	お
92	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
93	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
94	94142	3.1912	3.19	相	関係	量	広狭・大小	大きい	大きい	おおきい
95	94143	3.1912	3.19	相	関係	量	広狭・大小	大きな	大きな	おおきな
96	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
97	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
98	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
99	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
100	81627	2.3329999	2.33	用	活動	生活	生活・起臥	起きる	起きる	おきる
101	69825	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	置く	置く	おく
102	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
103	16190	1.205	1.20	体	主体	人間	老少	おじさん	おじさん	おじさん
109	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
110	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
111	16809	1.214	1.21	体	主体	家族	兄弟	弟	弟	おとうと
112	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
113	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
114	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
115	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
116	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
117	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
118	91125	3.1129999	3.11	相	関係	類	異同・類似	同じ	同じ	おなじ
119	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
120	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
121	16192	1.205	1.20	体	主体	人間	老少	おばさん	おばさん	おばさん
122	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
123	53048	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	おふろ	おふろ	おふろ
124	77301	2.3050001	2.30	用	活動	心	学習・習慣・記憶	覚える	覚える	おぼえる
125	20065	1.2417001	1.24	体	主体	成員	保安サービス	お巡りさん	お巡りさん	おまわりさん
126	94318	3.1914001	3.19	相	関係	量	軽重	重い	重い	おもい
127	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
128	82483	2.3374	2.33	用	活動	生活	スポーツ	泳ぐ	泳ぐ	およぐ
129	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
130	69249	2.1503	2.15	用	関係	作用	終了・中止・停止	終わる	終わる	おわる
131	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
132	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
133	15972	1.204	1.20	体	主体	人間	男女	女の子	女の子	めのこ
134	15069	1.1962	1.19	体	関係	量	助数接辞	回	回	かい
135	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
136	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
137	22666	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	会社	会社	かいしゃ
138	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
139	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
140	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
141	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
142	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
143	64388	1.5601	1.56	体	自然	身体	頭・目鼻・顔	顔	顔	かお
144	74595	2.1600001	2.16	用	関係	時間	時間	掛かる［五時間～・数年～］	掛かる	かかる
145	54498	1.4541	1.45	体	生産物	道具	日用品	かぎ（鍵）	かぎ	かぎ
146	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
147	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
148	14885	1.1962	1.19	体	関係	量	助数接辞	－か月・箇月（かげつ）	－か月・箇月	かげつ
149	79855	2.3122001	2.31	用	活動	言語	通信	電話を掛ける	電話を掛ける	でんわをかける
150	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
151	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
152	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
153	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
154	16247	1.21	1.21	体	主体	家族	家族	家族	家族	かぞく
155	15423	1.2	1.20	体	主体	人間	人間	－方（かた）	－方	かた
156	31559	1.3113	1.31	体	活動	言語	文字	片仮名	片仮名	かたかな
157	14882	1.1962	1.19	体	関係	量	助数接辞	－月（がつ）	－月	がつ
158	22471	1.263	1.26	体	主体	社会	社寺・学校	学校	学校	がっこう
159	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
160	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
162	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
163	53802	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	花瓶	花瓶	かびん
164	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
165	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
166	55928	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	カメラ	カメラ	かめら
167	8556	1.1632	1.16	体	関係	時間	週・週日	火曜日	火曜日	かようび
168	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
169	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
170	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
171	76240	2.303	2.30	用	活動	心	表情・態度	－がる［うれし～・おもしろ～・苦し～・痛～・かゆ～］	－がる	がる
172	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
173	51510	1.433	1.43	体	生産物	食料	調味料・こうじなど	カレー	カレー	かれえ
174	34629	1.3161	1.31	体	活動	言語	目録・暦	カレンダー	カレンダー	かれんだあ
175	60947	1.525	1.52	体	自然	天地	川・湖	かわ（川・河）	かわ	かわ
176	11392	1.175	1.17	体	関係	空間	面・側・表裏	側（がわ）	側	がわ
177	95676	3.302	3.30	相	活動	心	好悪・愛憎	かわいい	かわいい	かわいい
178	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
179	61626	1.54	1.54	体	自然	植物	植物	木（き）	木	き
180	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
181	99136	3.5020001	3.50	相	自然	自然	色	黄色い	黄色い	きいろい
182	89739	2.5160999	2.51	用	自然	物質	火	消える	消える	きえる
183	80088	2.3132	2.31	用	活動	言語	問答	聞く	聞く	きく
184	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
185	55090	1.456	1.45	体	生産物	道具	楽器・レコードなど	ギター	ギター	ぎたあ
187	22917	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	喫茶店	喫茶店	きっさてん
188	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
189	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
190	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
192	51299	1.4323	1.43	体	生産物	食料	魚・肉	牛肉	牛肉	ぎゅうにく
193	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
194	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
195	22500	1.263	1.26	体	主体	社会	社寺・学校	教室	教室	きょうしつ
196	16780	1.214	1.21	体	主体	家族	兄弟	兄弟（きょうだい）	兄弟	きょうだい
197	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
198	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
199	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
200	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
201	15002	1.1962	1.19	体	関係	量	助数接辞	キログラム	キログラム	きろぐらむ
202	22692	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	銀行	銀行	ぎんこう
203	8559	1.1632	1.16	体	関係	時間	週・週日	金曜日	金曜日	きんようび
205	51929	1.436	1.43	体	生産物	食料	薬剤・薬品	薬（くすり）	薬	くすり
206	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
207	64505	1.5601	1.56	体	自然	身体	頭・目鼻・顔	口	口	くち
208	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
209	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
210	21338	1.253	1.25	体	主体	公私	国	国（くに）	国	くに
211	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
212	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
213	94383	3.1919999	3.19	相	関係	量	程度	－くらい	－くらい	くらい
214	23913	1.276	1.27	体	主体	機関	同盟・団体	クラス	クラス	くらす
215	15001	1.1962	1.19	体	関係	量	助数接辞	グラム	グラム	ぐらむ
216	71061	2.1526999	2.15	用	関係	作用	往復	来（く）る	来る	くる
217	48812	1.415	1.41	体	生産物	資材	輪・車・棒・管など	車（くるま）	車	くるま
218	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
219	99120	3.5020001	3.50	相	自然	自然	色	黒い	黒い	くろい
220	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
221	9029	1.1641001	1.16	体	関係	時間	現在	今朝（けさ）	今朝	けさ
222	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
223	94562	3.1919999	3.19	相	関係	量	程度	けっこう［～おいしい］	けっこう	けっこう
224	37406	1.335	1.33	体	活動	生活	冠婚	結婚	結婚	けっこん
225	82161	2.335	2.33	用	活動	生活	冠婚	結婚する	結婚する	けっこんする
226	8555	1.1632	1.16	体	関係	時間	週・週日	月曜日	月曜日	げつようび
227	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
228	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
229	15151	1.1962	1.19	体	関係	量	助数接辞	－個（こ）	－個	こ
230	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
231	23140	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	公園	公園	こうえん
232	57316	1.471	1.47	体	生産物	土地利用	道路・橋	交差点	交差点	こうさてん
233	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
234	23216	1.266	1.26	体	主体	社会	教室・兵営など	交番	交番	こうばん
235	25605	1.3031	1.30	体	活動	心	声	声	声	こえ
236	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
237	51777	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーヒー	コーヒー	こおひい
238	9974	1.17	1.17	体	関係	空間	空間・場所	ここ	ここ	ここ
239	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
240	14598	1.196	1.19	体	関係	量	数記号（一二三）	九日（ここのか）	九日	ここのか
241	14373	1.196	1.19	体	関係	量	数記号（一二三）	九つ	九つ	ここのつ
242	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
243	80142	2.3132	2.31	用	活動	言語	問答	答える	答える	こたえる
244	10765	1.173	1.17	体	関係	空間	方向・方角	こちら	こちら	こちら
245	10766	1.173	1.17	体	関係	空間	方向・方角	こっち	こっち	こっち
246	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
247	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
248	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
249	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
250	90777	3.1010001	3.10	相	関係	真偽	こそあど・他	この	この	この
251	36910	1.3331	1.33	体	活動	生活	食生活	御飯（ごはん）	御飯	ごはん
252	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
253	80748	2.3151	2.31	用	活動	言語	書き	コピーする	コピーする	こぴいする
254	75855	2.3013999	2.30	用	活動	心	苦悩・悲哀	困る	困る	こまる
255	147	1.101	1.10	体	関係	事柄	こそあど・他	これ	これ	これ
256	7729	1.1611	1.16	体	関係	時間	時機・時刻	ころ	ころ	ころ
257	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
258	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
259	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
260	9031	1.1641001	1.16	体	関係	時間	現在	今晩	今晩	こんばん
261	100460	4.3010001	4.30	他		感動	間投	さあ	さあ	さあ
262	14870	1.1962	1.19	体	関係	量	助数接辞	－歳（さい）	－歳	さい
263	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
264	63577	1.5504	1.55	体	自然	動物	魚類	魚（さかな）	魚	さかな
265	9270	1.165	1.16	体	関係	時間	順序	先（さき）	先	さき
266	90067	2.5701001	2.57	用	自然	生命	生	咲く	咲く	さく
267	34739	1.3200001	1.32	体	活動	芸術	創作・著述	作文	作文	さくぶん
268	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
269	71714	2.1531999	2.15	用	関係	作用	入り・入れ	差す	差す	さす
270	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
271	34482	1.316	1.31	体	活動	言語	文献・図書	雑誌	雑誌	ざっし
272	51376	1.433	1.43	体	生産物	食料	調味料・こうじなど	砂糖	砂糖	さとう
273	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
274	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
275	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
276	14335	1.196	1.19	体	関係	量	数記号（一二三）	三（さん）	三	さん
277	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
278	14337	1.196	1.19	体	関係	量	数記号（一二三）	四（し）	四	し
280	51398	1.433	1.43	体	生産物	食料	調味料・こうじなど	塩（しお）	塩	しお
281	100256	4.1129999	4.11	他		接続	反対	しかし	しかし	しかし
282	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
283	36429	1.332	1.33	体	活動	生活	労働・作業・休暇	仕事	仕事	しごと
284	34541	1.316	1.31	体	活動	言語	文献・図書	辞書	辞書	じしょ
285	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
286	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
287	14340	1.196	1.19	体	関係	量	数記号（一二三）	七（しち）	七	しち
288	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
289	56482	1.465	1.46	体	生産物	機械	乗り物（陸上）	自転車	自転車	じてんしゃ
290	56506	1.465	1.46	体	生産物	機械	乗り物（陸上）	自動車	自動車	じどうしゃ
291	90096	2.5702	2.57	用	自然	生命	死	死ぬ	死ぬ	しぬ
292	34545	1.316	1.31	体	活動	言語	文献・図書	字引	字引	じびき
293	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
294	72671	2.1552999	2.15	用	関係	作用	開閉・封	閉まる	閉まる	しまる
295	68584	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	締める	締める	しめる
296	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
297	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
298	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
299	54653	1.4541	1.45	体	生産物	道具	日用品	シャワー	シャワー	しゃわあ
300	14375	1.196	1.19	体	関係	量	数記号（一二三）	十（じゅう）	十	じゅう
301	8543	1.1632	1.16	体	関係	時間	週・週日	週間	週間	しゅうかん
302	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
303	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
304	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
305	100087	3.5710001	3.57	相	自然	生命	生理・病気など	丈夫（じょうぶ）	丈夫	じょうぶ
306	51442	1.433	1.43	体	生産物	食料	調味料・こうじなど	醤油	醤油	しょうゆ
307	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
308	75138	2.3001001	2.30	用	活動	心	感覚	知る	知る	しる
309	57950	1.502	1.50	体	自然	自然	色	白（しろ）	白	しろ
310	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
311	15407	1.2	1.20	体	主体	人間	人間	－人（じん）	－人	じん
312	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
313	8557	1.1632	1.16	体	関係	時間	週・週日	水曜日	水曜日	すいようび
314	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
315	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
316	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
317	9704	1.1670001	1.16	体	関係	時間	時間的前後	－過ぎ［五分～・五十～］	－過ぎ	すぎ
318	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
319	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
320	93932	3.191	3.19	相	関係	量	多少	少し	少し	すこし
321	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
322	94949	3.194	3.19	相	関係	量	一般・全体・部分	－ずつ	－ずつ	ずつ
323	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
324	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
325	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
326	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
327	81948	2.3333001	2.33	用	活動	生活	住生活	住む	住む	すむ
328	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
329	83481	2.3429999	2.34	用	活動	行為	行為・活動	する	する	する
330	82724	2.3390999	2.33	用	活動	生活	立ち居	座る	座る	すわる
331	64593	1.5602	1.56	体	自然	身体	胸・背・腹	背（せ）	背	せ
332	20241	1.2419	1.24	体	主体	成員	学徒	生徒	生徒	せいと
333	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
334	54609	1.4541	1.45	体	生産物	道具	日用品	石鹸	石鹸	せっけん
335	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
336	94110	3.1912	3.19	相	関係	量	広狭・大小	狭い	狭い	せまい
337	14327	1.196	1.19	体	関係	量	数記号（一二三）	ゼロ	ゼロ	ぜろ
338	14441	1.196	1.19	体	関係	量	数記号（一二三）	千	千	せん
339	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
340	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
341	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
342	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
343	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
344	13993	1.194	1.19	体	関係	量	一般・全体・部分	全部	全部	ぜんぶ
345	90799	3.1010001	3.10	相	関係	真偽	こそあど・他	そう	そう	そう
346	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
347	88631	2.3843	2.38	用	活動	事業	掃除など	掃除する	掃除する	そうじする
348	100171	4.1110001	4.11	他		接続	累加	そして	そして	そして
349	9980	1.17	1.17	体	関係	空間	空間・場所	そこ	そこ	そこ
350	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
351	9987	1.17	1.17	体	関係	空間	空間・場所	そっち	そっち	そっち
352	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
353	90793	3.1010001	3.10	相	関係	真偽	こそあど・他	その	その	その
354	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
355	60368	1.52	1.52	体	自然	天地	宇宙・空	空（そら）	空	そら
356	153	1.101	1.10	体	関係	事柄	こそあど・他	それ	それ	それ
357	100175	4.1110001	4.11	他		接続	累加	それから	それから	それから
358	100233	4.112	4.11	他		接続	展開	それでは	それでは	それでは
359	14208	1.1950001	1.19	体	関係	量	単位	台（だい）	台	だい
360	22517	1.263	1.26	体	主体	社会	社寺・学校	大学	大学	だいがく
361	23402	1.271	1.27	体	主体	機関	政府機関	大使館	大使館	たいしかん
362	92283	3.1345999	3.13	相	関係	様相	難易・安危	大丈夫	大丈夫	だいじょうぶ
363	95587	3.302	3.30	相	活動	心	好悪・愛憎	大好き	大好き	だいすき
364	96508	3.3067999	3.30	相	活動	心	詳細・正確・不思議	大切	大切	たいせつ
365	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
366	94586	3.1919999	3.19	相	関係	量	程度	大変	大変	たいへん
367	94023	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	高い	高い	たかい
368	93838	3.191	3.19	相	関係	量	多少	たくさん	たくさん	たくさん
369	56572	1.465	1.46	体	生産物	機械	乗り物（陸上）	タクシー	タクシー	たくしい
370	94953	3.194	3.19	相	関係	量	一般・全体・部分	－だけ	－だけ	だけ
371	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
372	14317	1.1950999	1.19	体	関係	量	群・組・対	－たち	－たち	たち
373	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
374	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
375	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
376	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
377	85908	2.3659999	2.36	用	活動	待遇	請求・依頼	頼む	頼む	たのむ
378	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
379	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
380	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
381	81700	2.3331001	2.33	用	活動	生活	食生活	食べる	食べる	たべる
382	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
383	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
384	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
385	8682	1.1633	1.16	体	関係	時間	日	誕生日	誕生日	たんじょうび
386	93352	3.165	3.16	相	関係	時間	順序	段段	段段	だんだん
387	94186	3.1912	3.19	相	関係	量	広狭・大小	小さい	小さい	ちいさい
388	94187	3.1912	3.19	相	関係	量	広狭・大小	小さな	小さな	ちいさな
389	94068	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	近い	近い	ちかい
390	67286	2.1129999	2.11	用	関係	類	異同・類似	違う	違う	ちがう
391	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
392	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
393	32060	1.3115	1.31	体	活動	言語	表・図・譜・式	地図	地図	ちず
394	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
395	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
396	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
397	9570	1.1652	1.16	体	関係	時間	途中・盛り	－中（ちゅう）	－中	ちゅう
398	94429	3.1919999	3.19	相	関係	量	程度	ちょうど	ちょうど	ちょうど
399	93979	3.191	3.19	相	関係	量	多少	ちょっと	ちょっと	ちょっと
400	8590	1.1633	1.16	体	関係	時間	日	ついたち	ついたち	ついたち
401	88962	2.3852	2.38	用	活動	事業	扱い・操作・使用	使う	使う	つかう
402	75380	2.3002999	2.30	用	活動	心	飢渇・酔い・疲労・睡眠など	疲れる	疲れる	つかれる
403	9301	1.165	1.16	体	関係	時間	順序	次（つぎ）	次	つぎ
404	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
405	53456	1.447	1.44	体	生産物	住居	家具	机	机	つくえ
406	67903	2.122	2.12	用	関係	存在	成立	つくる（作・造）	つくる	つくる
407	67749	2.1210999	2.12	用	関係	存在	発生・復活	付ける［果実を～］	付ける	つける
408	81423	2.332	2.33	用	活動	生活	労働・作業・休暇	勤める	勤める	つとめる
409	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
410	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
411	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
412	64713	1.5603	1.56	体	自然	身体	手足・指	手（て）	手	て
413	49158	1.416	1.41	体	生産物	資材	コード・縄・綱など	テープ	テープ	てえぷ
414	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
415	56004	1.462	1.46	体	生産物	機械	電気器具・部品	テープレコーダー	テープレコーダー	てえぷれこおだあ
416	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
417	32261	1.3122	1.31	体	活動	言語	通信	手紙	手紙	てがみ
418	83398	2.3420999	2.34	用	活動	行為	才能	できる	できる	できる
419	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
420	12247	1.183	1.18	体	関係	形	穴・口	出口	出口	でぐち
421	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
422	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
423	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
424	100272	4.1129999	4.11	他		接続	反対	でも	でも	でも
425	70122	2.1521001	2.15	用	関係	作用	移動・発着	出る	出る	でる
426	55994	1.462	1.46	体	生産物	機械	電気器具・部品	テレビ	テレビ	てれび
427	59928	1.5154001	1.51	体	自然	物質	天気	天気	天気	てんき
428	57616	1.5001	1.50	体	自然	自然	エネルギー	電気	電気	でんき
429	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
430	32370	1.3122	1.31	体	活動	言語	通信	電話	電話	でんわ
431	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
432	15048	1.1962	1.19	体	関係	量	助数接辞	度（ど）	度	ど
433	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
434	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
435	90822	3.1010001	3.10	相	関係	真偽	こそあど・他	どう	どう	どう
436	100367	4.118	4.11	他		接続	理由	どうして	どうして	どうして
437	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
438	62896	1.55	1.55	体	自然	動物	動物	動物	動物	どうぶつ
439	100865	4.3210001	4.32	他		呼び掛け	応答	どうも	どうも	どうも
440	14395	1.196	1.19	体	関係	量	数記号（一二三）	とお	とお	とお
441	94059	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	遠い	遠い	とおい
442	14600	1.196	1.19	体	関係	量	数記号（一二三）	十日（とおか）	十日	とおか
443	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
444	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
445	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
446	9998	1.17	1.17	体	関係	空間	空間・場所	どこ	どこ	どこ
447	10053	1.17	1.17	体	関係	空間	空間・場所	所（ところ）	所	ところ
448	8441	1.163	1.16	体	関係	時間	年	とし（年・歳）	とし	とし
449	23121	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	図書館	図書館	としょかん
450	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
451	164	1.101	1.10	体	関係	事柄	こそあど・他	どっち	どっち	どっち
452	94634	3.1919999	3.19	相	関係	量	程度	とても	とても	とても
453	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
454	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
455	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
456	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
457	69438	2.1503	2.15	用	関係	作用	終了・中止・停止	止まる	止まる	とまる
458	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
459	8560	1.1632	1.16	体	関係	時間	週・週日	土曜日	土曜日	どようび
460	63268	1.5502	1.55	体	自然	動物	鳥類	鳥（とり）	鳥	とり
461	51294	1.4323	1.43	体	生産物	食料	魚・肉	鳥肉	鳥肉	とりにく
462	88910	2.3850999	2.38	用	活動	事業	練り・塗り・撃ち・録音・撮影	撮る	撮る	とる
463	163	1.101	1.10	体	関係	事柄	こそあど・他	どれ	どれ	どれ
464	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
465	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
466	54781	1.455	1.45	体	生産物	道具	刃物	ナイフ	ナイフ	ないふ
467	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
468	94000	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	長い	長い	ながい
469	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
470	76383	2.303	2.30	用	活動	心	表情・態度	泣く	泣く	なく
471	68054	2.125	2.12	用	関係	存在	消滅	なくす	なくす	なくす
472	100362	4.118	4.11	他		接続	理由	なぜ	なぜ	なぜ
473	8375	1.1624	1.16	体	関係	時間	季節	夏（なつ）	夏	なつ
474	36595	1.332	1.33	体	活動	生活	労働・作業・休暇	夏休み	夏休み	なつやすみ
475	14320	1.1950999	1.19	体	関係	量	群・組・対	－など	－など	など
476	14371	1.196	1.19	体	関係	量	数記号（一二三）	七つ	七つ	ななつ
477	14849	1.1962	1.19	体	関係	量	助数接辞	何（なん）－	何－	なん
478	14595	1.196	1.19	体	関係	量	数記号（一二三）	七日（なのか）	七日	なのか
479	30628	1.3102	1.31	体	活動	言語	名	名前	名前	なまえ
480	77113	2.3050001	2.30	用	活動	心	学習・習慣・記憶	習う［～より慣れよ］	習う	ならう
481	73880	2.1573	2.15	用	関係	作用	配列・排列	並ぶ	並ぶ	ならぶ
482	73881	2.1573	2.15	用	関係	作用	配列・排列	並べる	並べる	ならべる
483	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
484	14332	1.196	1.19	体	関係	量	数記号（一二三）	二（に）	二	に
485	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
486	51286	1.4323	1.43	体	生産物	食料	魚・肉	肉	肉	にく
487	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
488	14892	1.1962	1.19	体	関係	量	助数接辞	－日（にち）	－日	にち
489	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
490	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
491	32538	1.3123	1.31	体	活動	言語	伝達・報知	ニュース	ニュース	にゅうす
492	57040	1.47	1.47	体	生産物	土地利用	地類（土地利用）	庭（にわ）	庭	にわ
494	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
495	99859	3.517	3.51	相	自然	物質	熱	ぬるい	ぬるい	ぬるい
496	50149	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	ネクタイ	ネクタイ	ねくたい
497	63080	1.5501	1.55	体	自然	動物	哺乳類	猫	猫	ねこ
498	82694	2.3390999	2.33	用	活動	生活	立ち居	寝る	寝る	ねる
499	14871	1.1962	1.19	体	関係	量	助数接辞	年（ねん）	年	ねん
500	55740	1.459	1.45	体	生産物	道具	札・帳など	ノート	ノート	のおと
501	71928	2.154	2.15	用	関係	作用	上がり・下がり	登る	登る	のぼる
502	51732	1.4349999	1.43	体	生産物	食料	飲料・たばこ	飲み物	飲み物	のみもの
503	83154	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	飲む	飲む	のむ
504	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
505	65338	1.5606	1.56	体	自然	身体	骨・歯・爪・角・甲	歯	歯	は
506	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
507	15189	1.1962	1.19	体	関係	量	助数接辞	杯（はい）	杯	はい
508	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
509	71454	2.1531999	2.15	用	関係	作用	入り・入れ	入（はい）る	入る	はいる
510	32265	1.3122	1.31	体	活動	言語	通信	はがき	はがき	はがき
511	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
512	53883	1.4513	1.45	体	生産物	道具	箱など	箱	箱	はこ
513	57368	1.471	1.47	体	生産物	土地利用	道路・橋	橋	橋	はし
514	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
515	9372	1.1651	1.16	体	関係	時間	終始	はじめ（初・始）	はじめ	はじめ
516	93558	3.1670001	3.16	相	関係	時間	時間的前後	初めて	初めて	はじめて
517	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
518	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
519	51476	1.433	1.43	体	生産物	食料	調味料・こうじなど	バター	バター	ばたあ
520	8123	1.1622	1.16	体	関係	時間	年配	二十・二十歳（はたち）	二十・二十歳	はたち
521	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
522	14341	1.196	1.19	体	関係	量	数記号（一二三）	八（はち）	八	はち
523	8591	1.1633	1.16	体	関係	時間	日	二十日（はつか）	二十日	はつか
524	62749	1.541	1.54	体	自然	植物	枝・葉・花・実	花（はな）	花	はな
525	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
526	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
527	16496	1.212	1.21	体	主体	家族	親・先祖	母	母	はは
528	93485	3.1659999	3.16	相	関係	時間	新旧・遅速	早い	早い	はやい
529	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
530	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
531	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
532	14146	1.194	1.19	体	関係	量	一般・全体・部分	半	半	はん
534	50788	1.431	1.43	体	生産物	食料	料理	パン	パン	ぱん
535	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
536	12864	1.1902	1.19	体	関係	量	数	番号	番号	ばんごう
537	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
538	14143	1.194	1.19	体	関係	量	一般・全体・部分	半分	半分	はんぶん
539	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
540	15180	1.1962	1.19	体	関係	量	助数接辞	匹（ひき）	匹	ひき
541	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
542	94030	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	低い	低い	ひくい
543	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
544	10954	1.174	1.17	体	関係	空間	左右・前後・たてよこ	左（ひだり）	左	ひだり
545	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
546	14365	1.196	1.19	体	関係	量	数記号（一二三）	一つ	一つ	ひとつ
547	14623	1.196	1.19	体	関係	量	数記号（一二三）	ひとつき	ひとつき	ひとつき
548	14563	1.196	1.19	体	関係	量	数記号（一二三）	ひとり	ひとり	ひとり
549	7508	1.16	1.16	体	関係	時間	時間	暇（ひま）	暇	ひま
550	14414	1.196	1.19	体	関係	量	数記号（一二三）	百	百	ひゃく
551	23103	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	病院	病院	びょういん
552	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
553	31558	1.3113	1.31	体	活動	言語	文字	平仮名	平仮名	ひらがな
554	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
555	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
556	94080	3.1912	3.19	相	関係	量	広狭・大小	広い	広い	ひろい
557	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
558	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
559	22810	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	プール	プール	ぷうる
560	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
561	83245	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吹く	吹く	ふく
562	14366	1.196	1.19	体	関係	量	数記号（一二三）	二つ	二つ	ふたつ
563	51303	1.4323	1.43	体	生産物	食料	魚・肉	豚肉	豚肉	ぶたにく
564	14564	1.196	1.19	体	関係	量	数記号（一二三）	ふたり	ふたり	ふたり
565	14588	1.196	1.19	体	関係	量	数記号（一二三）	二日（ふつか）	二日	ふつか
566	94124	3.1912	3.19	相	関係	量	広狭・大小	太い	太い	ふとい
567	8403	1.1624	1.16	体	関係	時間	季節	冬	冬	ふゆ
568	89521	2.5153	2.51	用	自然	物質	雨・雪	降る	降る	ふる
569	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
570	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
571	14903	1.1962	1.19	体	関係	量	助数接辞	分（ふん）	分	ふん
572	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
573	15221	1.1962	1.19	体	関係	量	助数接辞	ページ	ページ	ぺえじ
574	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
575	50330	1.427	1.42	体	生産物	衣料	寝具	ベッド	ベッド	べっど
576	62902	1.55	1.55	体	自然	動物	動物	ペット	ペット	ぺっと
577	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
578	11742	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	辺（へん）	辺	へん
579	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
580	77172	2.3050001	2.30	用	活動	心	学習・習慣・記憶	勉強する	勉強する	べんきょうする
581	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
582	50475	1.4299999	1.43	体	生産物	食料	食料	弁当	弁当	べんとう
583	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
584	187	1.101	1.10	体	関係	事柄	こそあど・他	方（ほう）	方	ほう
585	50073	1.425	1.42	体	生産物	衣料	帽子・マスクなど	帽子	帽子	ぼうし
586	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
588	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
589	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
590	96159	3.3041999	3.30	相	活動	心	欲望・期待・失望	欲しい	欲しい	ほしい
591	94125	3.1912	3.19	相	関係	量	広狭・大小	細い	細い	ほそい
592	48953	1.4151	1.41	体	生産物	資材	ピン・ボタン・くいなど	ボタン	ボタン	ぼたん
593	23065	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	ホテル	ホテル	ほてる
594	34173	1.316	1.31	体	活動	言語	文献・図書	本（ほん）	本	ほん
595	53263	1.4450001	1.44	体	生産物	住居	棚・台・壇など	本棚	本棚	ほんだな
596	221	1.103	1.10	体	関係	事柄	真偽・是非	本当	本当	ほんとう
597	15206	1.1962	1.19	体	関係	量	助数接辞	枚（まい）	枚	まい
598	7860	1.1612	1.16	体	関係	時間	毎日・毎度	毎朝	毎朝	まいあさ
599	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
600	7865	1.1612	1.16	体	関係	時間	毎日・毎度	毎月（まいつき）	毎月	まいつき
601	7870	1.1612	1.16	体	関係	時間	毎日・毎度	毎年（まいとし）	毎年	まいとし
602	7851	1.1612	1.16	体	関係	時間	毎日・毎度	毎日	毎日	まいにち
603	7861	1.1612	1.16	体	関係	時間	毎日・毎度	毎晩	毎晩	まいばん
604	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
605	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
606	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
607	93142	3.1612	3.16	相	関係	時間	毎日・毎度	また	また	また
608	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
609	21710	1.255	1.25	体	主体	公私	政治的区画	町（まち）	町	まち
610	76984	2.3041999	2.30	用	活動	心	欲望・期待・失望	待つ	待つ	まつ
611	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
612	48676	1.413	1.41	体	生産物	資材	燃料・肥料	マッチ	マッチ	まっち
613	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
614	93774	3.1800001	3.18	相	関係	形	形	まるい（丸・円）	まるい	まるい
615	14463	1.196	1.19	体	関係	量	数記号（一二三）	万	万	まん
616	54238	1.4529999	1.45	体	生産物	道具	文具	万年筆	万年筆	まんねんひつ
617	88794	2.3850999	2.38	用	活動	事業	練り・塗り・撃ち・録音・撮影	磨く	磨く	みがく
618	10956	1.174	1.17	体	関係	空間	左右・前後・たてよこ	右（みぎ）	右	みぎ
619	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
620	59203	1.513	1.51	体	自然	物質	水・乾湿	水（みず）	水	みず
621	22828	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	店（みせ）	店	みせ
622	80450	2.3139999	2.31	用	活動	言語	宣告・宣言・発表	見せる	見せる	みせる
623	57152	1.471	1.47	体	生産物	土地利用	道路・橋	道（みち）	道	みち
624	14589	1.196	1.19	体	関係	量	数記号（一二三）	三日（みっか）	三日	みっか
625	14367	1.196	1.19	体	関係	量	数記号（一二三）	三つ	三つ	みっつ
626	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
627	14012	1.194	1.19	体	関係	量	一般・全体・部分	皆さん	皆さん	みなさん
628	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
629	64491	1.5601	1.56	体	自然	身体	頭・目鼻・顔	耳	耳	みみ
630	78839	2.3090999	2.30	用	活動	心	見る	見る	見る	みる
631	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
632	14592	1.196	1.19	体	関係	量	数記号（一二三）	六日（むいか）	六日	むいか
633	10779	1.173	1.17	体	関係	空間	方向・方角	向こう	向こう	むこう
634	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
635	14370	1.196	1.19	体	関係	量	数記号（一二三）	六つ	六つ	むっつ
636	21712	1.255	1.25	体	主体	公私	政治的区画	村（むら）	村	むら
637	64415	1.5601	1.56	体	自然	身体	頭・目鼻・顔	目（め）	目	め
638	14911	1.1962	1.19	体	関係	量	助数接辞	メートル	メートル	めえとる
639	55889	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	眼鏡（めがね）	眼鏡	めがね
640	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
641	8558	1.1632	1.16	体	関係	時間	週・週日	木曜日	木曜日	もくようび
642	100754	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	もしもし	もしもし	もしもし
643	82801	2.3392	2.33	用	活動	生活	手足の動作	持つ	持つ	もつ
644	94499	3.1919999	3.19	相	関係	量	程度	もっと	もっと	もっと
645	47878	1.4	1.40	体	生産物	物品	物品	物（もの）	物	もの
646	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
647	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
648	22831	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	－屋・家（や）	－屋・家	や
649	22952	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	八百屋	八百屋	やおや
650	51101	1.432	1.43	体	生産物	食料	米・ぬか・小麦粉など	野菜	野菜	やさい
651	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
652	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
653	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
654	81495	2.332	2.33	用	活動	生活	労働・作業・休暇	休む	休む	やすむ
655	14372	1.196	1.19	体	関係	量	数記号（一二三）	八つ	八つ	やっつ
656	60710	1.524	1.52	体	自然	天地	山野	山（やま）	山	やま
657	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
658	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
659	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
660	23439	1.272	1.27	体	主体	機関	公共機関	郵便局	郵便局	ゆうびんきょく
661	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
662	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
663	59878	1.5153	1.51	体	自然	物質	雨・雪	雪（ゆき）	雪	ゆき
664	94288	3.1912999	3.19	相	関係	量	速度	ゆっくり	ゆっくり	ゆっくり
665	14596	1.196	1.19	体	関係	量	数記号（一二三）	八日（ようか）	八日	ようか
666	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
668	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
669	14590	1.196	1.19	体	関係	量	数記号（一二三）	四日（よっか）	四日	よっか
670	14368	1.196	1.19	体	関係	量	数記号（一二三）	四つ	四つ	よっつ
671	79600	2.3102	2.31	用	活動	言語	名	呼ぶ	呼ぶ	よぶ
672	80639	2.3150001	2.31	用	活動	言語	読み	読む	読む	よむ
673	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
674	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
675	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
676	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
677	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
678	55992	1.462	1.46	体	生産物	機械	電気器具・部品	ラジオ	ラジオ	らじお
679	56144	1.462	1.46	体	生産物	機械	電気器具・部品	ラジカセ	ラジカセ	らじかせ
680	91443	3.1301999	3.13	相	関係	様相	趣・調子	立派	立派	りっぱ
681	20281	1.2419	1.24	体	主体	成員	学徒	留学生	留学生	りゅうがくせい
682	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
683	47261	1.3842	1.38	体	活動	事業	炊事・調理	料理	料理	りょうり
684	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
685	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
686	14326	1.196	1.19	体	関係	量	数記号（一二三）	零（れい）	零	れい
687	55970	1.462	1.46	体	生産物	機械	電気器具・部品	冷蔵庫	冷蔵庫	れいぞうこ
688	55164	1.456	1.45	体	生産物	道具	楽器・レコードなど	レコード	レコード	れこおど
689	22888	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	レストラン	レストラン	れすとらん
690	26691	1.3049999	1.30	体	活動	心	学習・習慣・記憶	練習	練習	れんしゅう
691	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
692	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
693	14339	1.196	1.19	体	関係	量	数記号（一二三）	六（ろく）	六	ろく
694	49847	1.4220001	1.42	体	生産物	衣料	上着・コート	ワイシャツ	ワイシャツ	わいしゃつ
695	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
696	77658	2.3062	2.30	用	活動	心	注意・認知・了解	分かる	分かる	わかる
697	77319	2.3050001	2.30	用	活動	心	学習・習慣・記憶	忘れる	忘れる	わすれる
698	15475	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたくし）	私	わたくし
700	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
701	70089	2.1521001	2.15	用	関係	作用	移動・発着	渡る	渡る	わたる
702	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
704	15092	1.1962	1.19	体	関係	量	助数接辞	階	階	かい
705	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
706	99845	3.517	3.51	相	自然	物質	熱	熱い	熱い	あつい
707	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
708	8901	1.1635	1.16	体	関係	時間	朝晩	晩	晩	ばん
709	15407	1.2	1.20	体	主体	人間	人間	－人（じん）	－人	じん
710	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
711	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
712	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
713	89492	2.5151	2.51	用	自然	物質	風	吹く	吹く	ふく
714	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
715	11537	1.177	1.17	体	関係	空間	内外	海外	海外	かいがい
716	94225	3.1912999	3.19	相	関係	量	速度	速い［スピードが～］	速い	はやい
717	57368	1.471	1.47	体	生産物	土地利用	道路・橋	橋	橋	はし
718	82382	2.3371	2.33	用	活動	生活	旅・行楽	散歩する	散歩する	さんぽする
719	22720	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	不動産屋	不動産屋	ふどうさんや
720	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
721	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
722	23091	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	美容院	美容院	びよういん
724	8361	1.1624	1.16	体	関係	時間	季節	春	春	はる
725	62749	1.541	1.54	体	自然	植物	枝・葉・花・実	花（はな）	花	はな
726	329	1.104	1.10	体	関係	事柄	本体・代理	外（ほか）	外	ほか
727	67417	2.1199999	2.12	用	関係	存在	存在	在る	在る	ある
728	67417	2.1199999	2.12	用	関係	存在	存在	在る	在る	ある
729	98899	3.3710001	3.37	相	活動	経済	経済・収支	高い	高い	たかい
730	94586	3.1919999	3.19	相	関係	量	程度	大変	大変	たいへん
731	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
732	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
733	91642	3.1331999	3.13	相	関係	様相	良不良・適不適	よく	よく	よく
734	14335	1.196	1.19	体	関係	量	数記号（一二三）	三（さん）	三	さん
735	14350	1.196	1.19	体	関係	量	数記号（一二三）	よん	よん	よん
736	14338	1.196	1.19	体	関係	量	数記号（一二三）	五（ご）	五	ご
737	14362	1.196	1.19	体	関係	量	数記号（一二三）	なな	なな	なな
738	14343	1.196	1.19	体	関係	量	数記号（一二三）	九（く）	九	く
739	94500	3.1919999	3.19	相	関係	量	程度	もう	もう	もう
740	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
741	100789	4.3210001	4.32	他		呼び掛け	応答	はい	はい	はい
742	14912	1.1962	1.19	体	関係	量	助数接辞	キロメートル	キロメートル	きろめえとる
743	15165	1.1962	1.19	体	関係	量	助数接辞	人（にん）	人	にん
744	15140	1.1962	1.19	体	関係	量	助数接辞	本（ほん）	本	ほん
745	9698	1.1670001	1.16	体	関係	時間	時間的前後	前（まえ）	前	まえ
746	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
747	7709	1.1611	1.16	体	関係	時間	時機・時刻	時（とき）	時	とき
748	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
749	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
750	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
751	73145	2.1561999	2.15	用	関係	作用	突き・押し・引き・すれなど	引く	引く	ひく
752	86697	2.3699999	2.37	用	活動	経済	取得	取る	取る	とる
753	69181	2.1501999	2.15	用	関係	作用	開始	－かける	－かける	かける
754	67457	2.1199999	2.12	用	関係	存在	存在	居る	居る	いる
755	50475	1.4299999	1.43	体	生産物	食料	食料	弁当	弁当	べんとう
756	33735	1.3154	1.31	体	活動	言語	文章	文（ぶん）	文	ぶん
757	66187	1.571	1.57	体	自然	生命	生理	熱	熱	ねつ
758	64362	1.5601	1.56	体	自然	身体	頭・目鼻・顔	のど	のど	のど
759	55109	1.456	1.45	体	生産物	道具	楽器・レコードなど	ピアノ	ピアノ	ぴあの
760	83481	2.3429999	2.34	用	活動	行為	行為・活動	する	する	する
762	20181	1.2418	1.24	体	主体	成員	サービス	美容師	美容師	びようし
763	37367	1.3334	1.33	体	活動	生活	保健・衛生	シャンプー	シャンプー	しゃんぷう
764	65101	1.5605	1.56	体	自然	身体	皮・毛髪・羽毛	髪	髪	かみ
765	19103	1.24	1.24	体	主体	成員	成員・職	駅員	駅員	えきいん
766	32816	1.3132	1.31	体	活動	言語	問答	答え	答え	こたえ
767	12871	1.1902	1.19	体	関係	量	数	電話番号	電話番号	でんわばんごう
768	32453	1.3123	1.31	体	活動	言語	伝達・報知	連絡	連絡	れんらく
769	79931	2.3123	2.31	用	活動	言語	伝達・報知	連絡する	連絡する	れんらくする
771	82335	2.3369999	2.33	用	活動	生活	遊楽	聞く［香を～］	聞く	きく
772	44948	1.374	1.37	体	活動	経済	給与・料金・利子	家賃	家賃	やちん
773	78069	2.3065	2.30	用	活動	心	研究・試験・調査・検査など	探す	探す	さがす
774	19104	1.24	1.24	体	主体	成員	成員・職	店員	店員	てんいん
775	50596	1.431	1.43	体	生産物	食料	料理	定食	定食	ていしょく
776	51806	1.4349999	1.43	体	生産物	食料	飲料・たばこ	ミルク	ミルク	みるく
777	38497	1.3374	1.33	体	活動	生活	スポーツ	サッカー	サッカー	さっかあ
778	38526	1.3374	1.33	体	活動	生活	スポーツ	野球	野球	やきゅう
779	38468	1.3374	1.33	体	活動	生活	スポーツ	テニス	テニス	てにす
780	10194	1.17	1.17	体	関係	空間	空間・場所	売り場	売り場	うりば
781	55662	1.459	1.45	体	生産物	道具	札・帳など	カード	カード	かあど
783	46659	1.383	1.38	体	活動	事業	運輸	航空便	航空便	こうくうびん
784	46658	1.383	1.38	体	活動	事業	運輸	船便（ふなびん）	船便	ふなびん
785	88102	2.3829999	2.38	用	活動	事業	運輸	送る	送る	おくる
786	49813	1.4220001	1.42	体	生産物	衣料	上着・コート	スーツ	スーツ	すうつ
787	19108	1.24	1.24	体	主体	成員	成員・職	会社員	会社員	かいしゃいん
788	23051	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	スーパー	スーパー	すうぱあ
789	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
790	41520	1.3542	1.35	体	活動	交わり	競争	試合	試合	しあい
791	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
792	19109	1.24	1.24	体	主体	成員	成員・職	銀行員	銀行員	ぎんこういん
793	22322	1.262	1.26	体	主体	社会	現場	窓口	窓口	まどぐち
794	44178	1.3710001	1.37	体	活動	経済	経済・収支	振り込み	振り込み	ふりこみ
795	48411	1.411	1.41	体	生産物	資材	紙	用紙	用紙	ようし
796	10124	1.17	1.17	体	関係	空間	空間・場所	住所	住所	じゅうしょ
797	59628	1.5151	1.51	体	自然	物質	風	台風	台風	たいふう
798	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
799	67729	2.1210999	2.12	用	関係	存在	発生・復活	出来る	出来る	できる
800	81834	2.3332	2.33	用	活動	生活	衣生活	する［ベルトを～・おむつを～］	する	する
801	69409	2.1503	2.15	用	関係	作用	終了・中止・停止	休む	休む	やすむ
803	71573	2.1531999	2.15	用	関係	作用	入り・入れ	つける（漬・浸）	つける	つける
804	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
805	92944	3.1600001	3.16	相	関係	時間	時間	永い	永い	ながい
806	22807	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	空港	空港	くうこう
807	55690	1.459	1.45	体	生産物	道具	札・帳など	パスポート	パスポート	ぱすぽおと
808	20186	1.2418	1.24	体	主体	成員	サービス	ガイド	ガイド	がいど
809	82026	2.3333001	2.33	用	活動	生活	住生活	泊まる	泊まる	とまる
810	48073	1.401	1.40	体	生産物	物品	持ち物・売り物・土産など	土産（みやげ）	土産	みやげ
811	30562	1.3101	1.31	体	活動	言語	言語	日本語	日本語	にほんご
812	31496	1.3113	1.31	体	活動	言語	文字	字	字	じ
814	16351	1.211	1.21	体	主体	家族	夫婦	主人	主人	しゅじん
815	16812	1.214	1.21	体	主体	家族	兄弟	妹さん	妹さん	いもうとさん
816	16810	1.214	1.21	体	主体	家族	兄弟	弟さん	弟さん	おとうとさん
817	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
818	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
819	71061	2.1526999	2.15	用	関係	作用	往復	来（く）る	来る	くる
820	21316	1.252	1.25	体	主体	公私	郷里	国（くに）	国	くに
821	9700	1.1670001	1.16	体	関係	時間	時間的前後	後（あと）	後	あと
822	171	1.101	1.10	体	関係	事柄	こそあど・他	何（なに・なん）	何	なに・なん
823	56126	1.462	1.46	体	生産物	機械	電気器具・部品	コンピューター	コンピューター	こんぴゅうたあ
824	69380	2.1503	2.15	用	関係	作用	終了・中止・停止	やめる	やめる	やめる
825	87475	2.3770001	2.37	用	活動	経済	授受	もらう	もらう	もらう
826	75733	2.3013	2.30	用	活動	心	安心・焦燥・満足	心配する	心配する	しんぱいする
827	56040	1.462	1.46	体	生産物	機械	電気器具・部品	携帯電話	携帯電話	けいたいでんわ
828	51796	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーラ	コーラ	こおら
829	51567	1.434	1.43	体	生産物	食料	菓子	ケーキ	ケーキ	けえき
830	53191	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	壁（かべ）	壁	かべ
831	35325	1.323	1.32	体	活動	芸術	音楽	カラオケ	カラオケ	からおけ
832	40839	1.351	1.35	体	活動	交わり	集会	コンサート	コンサート	こんさあと
833	87385	2.3770001	2.37	用	活動	経済	授受	上げる	上げる	あげる
834	56108	1.462	1.46	体	生産物	機械	電気器具・部品	スイッチ	スイッチ	すいっち
835	92011	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	いろいろ	いろいろ	いろいろ
836	84166	2.352	2.35	用	活動	交わり	応接・送迎	呼ぶ	呼ぶ	よぶ
837	69490	2.1503999	2.15	用	関係	作用	連続・反復	続く	続く	つづく
838	77630	2.3062	2.30	用	活動	心	注意・認知・了解	確認する	確認する	かくにんする
839	77348	2.3060999	2.30	用	活動	心	思考・意見・疑い	思う	思う	おもう
840	1177	1.112	1.11	体	関係	類	相対	反対	反対	はんたい
841	91708	3.1331999	3.13	相	関係	様相	良不良・適不適	駄目	駄目	だめ
842	58166	1.503	1.50	体	自然	自然	音	音（おと）	音	おと
843	14227	1.1950999	1.19	体	関係	量	群・組・対	グループ	グループ	ぐるうぷ
844	14344	1.196	1.19	体	関係	量	数記号（一二三）	九（きゅう）	九	きゅう
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
4510	740	3874	1	erm	\N	あの	\N
2517	341	2019	3	guru/cikgu	\N	先生	\N
2516	341	1476	2	guru/cikgu	\N	先生	\N
2515	341	1178	1	guru/cikgu	\N	先生	\N
3763	194	3425	2	hari ini	\N	きょう	\N
3764	194	3426	1	hari ini	\N	きょう	\N
3792	12	3447	1	pagi	\N	朝	\N
3791	12	3446	2	pagi	\N	朝	\N
3620	302	2005	2	kelas	\N	授業	\N
3619	302	3069	1	kelas	\N	授業	\N
4338	41	3784	1	tidak	\N	いいえ	\N
4340	41	1879	3	tidak	\N	いいえ	\N
4339	41	1369	2	tidak	\N	いいえ	\N
3403	728	3253	1	ada	\N	あります	\N
3402	728	3252	2	ada	\N	あります	\N
4529	698	2744	1	saya	\N	私	\N
4184	640	2004	3	sudah	\N	もう	\N
4182	640	3733	1	sudah	\N	もう	1
4436	596	3847	1	betul	\N	本当	\N
4435	596	3846	2	betul	\N	本当	\N
3496	238	1474	1	sini	\N	ここ	\N
4277	1	3766	1	oh/ha	\N	ああ	\N
4279	1	2637	3	oh/ha	\N	ああ	\N
4278	1	3767	2	oh/ha	\N	ああ	\N
4309	741	3778	2	ya	\N	はい	\N
4312	741	1715	5	ya	\N	はい	\N
4311	741	1824	4	ya	\N	はい	\N
4310	741	2332	3	ya	\N	はい	\N
4308	741	3777	1	ya	\N	はい	\N
4366	437	2332	3	silakan/tolong	\N	どうぞ	\N
4364	437	3792	1	silakan/tolong	\N	どうぞ	\N
4365	437	2369	2	silakan/tolong	\N	どうぞ	\N
4367	437	2383	4	silakan/tolong	\N	どうぞ	\N
4125	357	3698	2	selepas itu	\N	それから	\N
4126	357	3699	1	selepas itu	\N	それから	\N
4345	250	3787	2	ini	\N	この	\N
4346	250	3788	1	ini	\N	この	\N
2825	594	1244	1	buku	\N	本	\N
2826	594	2088	2	buku	\N	本	\N
3005	468	2873	1	panjang	\N	長い	\N
4341	86	1727	1	ya	\N	ええ	\N
4342	86	2520	2	ya	\N	ええ	\N
4141	452	1427	2	sangat	\N	とても	\N
4140	452	3707	1	sangat	\N	とても	\N
4333	345	2637	3	begitu	\N	そう	\N
4332	345	3782	1	begitu	\N	そう	\N
4331	345	3783	2	begitu	\N	そう	\N
4334	345	2396	4	begitu	\N	そう	\N
3506	356	1837	1	itu	\N	それ	\N
3507	356	1268	2	itu	\N	それ	\N
3043	668	3072	2	sebelah/panjang	\N	横	\N
3042	668	3062	1	sebelah/panjang	\N	横	\N
3766	16	3428	1	ésok	\N	あした	\N
3765	16	3427	2	ésok	\N	あした	\N
4170	516	3727	1	buat pertama kalinya	\N	初めて	\N
4169	516	3726	2	buat pertama kalinya	\N	初めて	\N
4322	296	2415	3	kalau begitu	\N	じゃあ	\N
4321	296	2562	2	kalau begitu	\N	じゃあ	\N
4320	296	3781	1	kalau begitu	\N	じゃあ	\N
3256	811	1811	2	bahasa Jepun	\N	日本語	\N
3255	811	3167	1	bahasa Jepun	\N	日本語	\N
4261	44	3759	2	bagaimana 	\N	いかが	\N
4260	44	3758	1	bagaimana 	\N	いかが	\N
4004	366	3604	1	susah	\N	大変	\N
4003	366	3603	2	susah	\N	大変な	\N
3742	203	3413	1	hari Jumaat	\N	金曜日	\N
4503	153	2762	1	selesema	\N	かぜ	\N
4122	424	3695	1	tapi	\N	でも	\N
4121	424	3694	2	tapi	\N	でも	\N
4040	430	3628	1	téléfon/menéléfon	\N	電話	\N
4039	430	3629	2	téléfon/menéléfon	\N	電話	\N
4193	732	3742	2	sering/selalu	\N	よく	\N
4194	732	3743	1	sering/selalu	\N	よく	\N
3508	255	1259	1	ini	\N	これ	\N
3895	409	3512	2	membosankan 	\N	つまらない	\N
3896	409	3513	1	membosankan 	\N	つまらない	\N
4233	477	1333	1	berapa	\N	何	\N
4235	477	1326	3	berapa	\N	何	\N
4234	477	1335	2	berapa	\N	何	\N
3436	62	1330	1	sekarang	\N	今	\N
3437	62	1491	2	sekarang	\N	今	0
3142	107	2931	1	lambat	\N	遅い	\N
2821	449	1974	2	perpustakaan	\N	図書館	\N
2820	449	2966	1	perpustakaan	\N	図書館	\N
2822	449	1801	3	perpustakaan	\N	図書館	\N
4314	422	3780	1	kalau begitu/baiklah	\N	では	\N
4313	422	3779	2	kalau begitu/baiklah	\N	では	\N
3125	47	1320	2	berapa	\N	いくら	\N
3124	47	2409	1	berapa	\N	いくら	\N
4162	399	2672	4	sekejap/sikit	\N	ちょっと	\N
4161	399	1720	3	sekejap/sikit	\N	ちょっと	\N
4160	399	3718	2	sekejap/sikit	\N	ちょっと	\N
4159	399	3719	1	sekejap/sikit	\N	ちょっと	\N
3596	68	2828	1	masukkan/menuangkan	\N	入れます	\N
3597	68	2829	2	masukkan/menuangkan	\N	入れて	\N
3509	244	3291	2	sini/ini	\N	こちら	\N
3510	244	3292	1	sini/ini	\N	こちら	\N
3300	85	2936	1	bahasa Inggeris	\N	英語	\N
3301	85	2937	2	bahasa Inggeris	\N	英語	\N
3479	714	1692	2	saya	\N	わたし	\N
3478	714	1350	1	saya	\N	わたし	\N
3480	714	1299	3	saya	\N	わたし	\N
3997	362	3598	1	boléh	\N	大丈夫	\N
3996	362	3597	2	boléh	\N	大丈夫な	\N
2960	712	3037	2	panas	\N	暑く	\N
2961	712	3034	1	panas	\N	暑い	\N
2511	474	1397	2	cuti musim panas	\N	夏休み	\N
2512	474	2205	3	cuti musim panas	\N	夏休み	\N
2510	474	1646	1	cuti musim panas	\N	夏休み	\N
2172	216	2232	1	来る	\N	来	\N
2176	216	1562	5	来る	\N	来	\N
2174	216	2178	3	来る	\N	来	\N
2175	216	2220	4	来る	\N	来	\N
2173	216	1638	2	来る	\N	来	\N
3881	40	3504	2	bagus	\N	いい	\N
3882	40	3505	1	bagus	\N	いい	\N
3880	40	3503	3	bagus	\N	よくなかった	\N
4588	473	3683	1	musim panas	\N	夏	\N
4589	473	3682	2	musim panas	\N	夏	\N
3027	458	2429	2	kawan	\N	友達	\N
3026	458	3067	1	kawan	\N	友達	\N
4143	320	3709	1	sedikit	\N	少し	\N
4142	320	3708	2	sedikit	\N	少し	\N
4350	283	1799	2	kerja	\N	仕事	\N
3109	283	2024	1	kerja	\N	仕事	\N
2783	684	2948	2	melancong/pelancongan	\N	旅行	\N
2782	684	2947	1	melancong/pelancongan	\N	旅行	\N
3752	197	3420	1	tahun lepas	\N	去年	\N
3754	197	1495	3	tahun lepas	\N	去年	\N
3753	197	3316	2	tahun lepas	\N	去年	\N
4135	223	3706	1	cukup	\N	けっこう	\N
4391	344	3807	1	semuanya	\N	全部	\N
4390	344	3806	2	semuanya	\N	全部	\N
4442	749	3851	1	seluruh/sapanjang	\N	中	\N
4441	749	3850	2	seluruh/sapanjang	\N	中	\N
4394	118	3810	2	sama/se-	\N	同じ	\N
4395	118	3811	1	sama/se-	\N	同じ	\N
3523	257	3303	2	bulan ini	\N	今月	\N
3522	257	3302	1	bulan ini	\N	今月	\N
3654	254	3365	1	susah	\N	困りました	\N
3746	676	3417	2	minggu depan	\N	来週	\N
3747	676	3418	1	minggu depan	\N	来週	\N
3740	313	3411	1	hari Rabu	\N	水曜日	\N
3217	806	3148	2	lapangan terbang	\N	空港	\N
3218	806	3149	1	lapangan terbang	\N	空港	\N
2688	217	2061	3	keréta	\N	車	\N
2687	217	1250	2	keréta	\N	車	\N
2686	217	2908	1	keréta	\N	車	\N
4226	446	1229	2	mana	\N	どこ	\N
4225	446	3749	1	mana	\N	どこ	\N
4228	446	1264	4	mana	\N	どこ	\N
4227	446	1312	3	mana	\N	どこ	\N
2283	375	2495	2	bangunan	\N	建物	\N
2282	375	1431	1	bangunan	\N	建物	\N
4214	435	2064	3	bagaimana	\N	どう	\N
4213	435	1423	2	bagaimana	\N	どう	\N
4212	435	1414	1	bagaimana	\N	どう	\N
3501	17	1297	1	sana	\N	あそこ	\N
2477	88	2498	1	lif	\N	エレベーター	\N
4249	463	1836	3	yang mana	\N	どれ	\N
4248	463	3753	2	yang mana	\N	どれ	\N
4247	463	3752	1	yang mana	\N	どれ	\N
3502	39	1311	1	itu	\N	あれ	\N
3264	42	1694	2	cakap	\N	言います	\N
3263	42	3170	1	cakap	\N	言います	\N
3014	303	3063	1	kerja rumah	\N	宿題	\N
3015	303	1473	2	kerja rumah	\N	宿題	\N
3492	293	3290	1	sendiri/saya	\N	自分	\N
3493	293	1683	2	sendiri/saya	\N	自分	\N
3249	178	1885	2	kanji	\N	漢字	\N
3248	178	3165	1	kanji	\N	漢字	\N
2914	83	3009	1	filem	\N	映画	\N
2915	83	2154	2	filem	\N	映画	\N
2921	316	3014	1	suka	\N	好き	\N
2920	316	3013	2	suka	\N	好きな	\N
4343	55	3785	2	paling	\N	いちばん	\N
4344	55	3786	1	paling	\N	いちばん	\N
3589	45	3336	2	pergi	\N	行きませんでした	\N
3590	45	3337	1	pergi	\N	行きます	\N
2444	381	1993	3	makan	\N	食べた	\N
2442	381	2818	1	makan	\N	食べます	\N
2443	381	1484	2	makan	\N	食べて	\N
2892	683	1967	2	hidangan/masakan/memasak	\N	料理	\N
2891	683	2104	1	hidangan/masakan/memasak	\N	料理	\N
2893	683	1419	3	hidangan/masakan/memasak	\N	料理	\N
3773	602	3433	1	setiap hari	\N	毎日	\N
3774	602	1557	2	setiap hari	\N	毎日	\N
4512	439	3774	2	ya/terima kasih	\N	どうも	\N
4514	439	2391	4	ya/terima kasih	\N	どうも	\N
4513	439	3775	3	ya/terima kasih	\N	どうも	\N
4511	439	3776	1	ya/terima kasih	\N	どうも	\N
2841	252	2976	1	salinan	\N	コピー	\N
4515	592	2043	1	butang	\N	ボタン	\N
3196	795	3141	2	borang	\N	用紙	\N
3197	795	3142	1	borang	\N	用紙	\N
4290	642	3772	2	hélo	\N	もしもし	\N
4291	642	2548	3	hélo	\N	もしもし	\N
4289	642	3773	1	hélo	\N	もしもし	\N
3057	158	1349	2	sekolah	\N	学校	\N
3056	158	1605	1	sekolah	\N	学校	\N
3351	15	3231	1	kaki	\N	足	\N
3350	15	3230	2	kaki	\N	足	\N
2949	710	3029	1	hujan	\N	雨	\N
2948	710	3028	2	hujan	\N	雨	\N
4217	436	2007	3	kenapa	\N	どうして	\N
4216	436	2017	2	kenapa	\N	どうして	\N
4215	436	2011	1	kenapa	\N	どうして	\N
2807	652	1542	1	murah	\N	安い	\N
2808	652	2047	2	murah	\N	安ければ	\N
4600	621	2949	1	kedai	0	店	0
4601	621	2950	2	kedai	0	店	0
4602	621	1433	3	kedai	0	店	0
3915	93	3524	2	ramai	\N	多い	\N
3916	93	3525	1	ramai	\N	多い	\N
2573	105	1380	2	mengajar (ajar)	\N	教えます	\N
2572	105	2862	1	mengajar (ajar)	\N	教えて	\N
4501	135	1883	2	luar negara	\N	外国	\N
4500	135	2179	1	luar negara	\N	外国	\N
4145	398	3711	1	ini	\N	ちょうど	\N
4144	398	3710	2	ini	\N	ちょうど	\N
2507	360	2227	1	universiti	\N	大学	\N
2508	360	1826	2	universiti	\N	大学	\N
4232	472	2599	2	mengapa	\N	なぜ	\N
4231	472	3750	1	mengapa	\N	なぜ	\N
4112	25	3470	1	lagi	\N	あと	\N
2844	137	2978	1	syarikat	\N	会社	\N
2845	137	2977	2	syarikat	\N	会社	\N
3757	677	3318	1	tahun depan	\N	来年	\N
3758	677	3319	2	tahun depan	\N	来年	\N
4199	56	1494	3	bila	\N	いつ	\N
4197	56	1393	1	bila	\N	いつ	\N
4198	56	1268	2	bila	\N	いつ	\N
4255	464	1280	3	yang bagaimana	\N	どんな	\N
4254	464	3754	2	yang bagaimana	\N	どんな	\N
4253	464	3755	1	yang bagaimana	\N	どんな	\N
2902	131	1817	1	muzik	\N	音楽	\N
2903	131	1848	2	muzik	\N	音楽	\N
3818	403	3468	1	kemudian	\N	次	\N
3817	403	3467	2	kemudian	\N	次	\N
2384	141	2796	2	pulangkan	\N	返します	\N
2383	141	2797	1	pulangkan	\N	返します	\N
2385	141	2651	3	pulangkan	\N	返す	\N
3233	401	3160	2	guna	\N	使います	\N
3234	401	3100	1	guna	\N	使います	\N
4411	627	3825	1	awak semua	\N	皆さん	\N
4409	627	3823	3	awak semua	\N	皆さん	\N
4410	627	3824	2	awak semua	\N	皆さん	\N
4354	353	1299	2	itu	\N	その	\N
4353	353	3789	1	itu	\N	その	\N
3497	349	1296	1	situ	\N	そこ	\N
3511	245	3293	1	sini	\N	こっち	\N
3517	351	3299	1	situ	\N	そっち	\N
2578	690	1528	2	latihan/berlatih	\N	練習	\N
2577	690	2864	1	latihan/berlatih	\N	練習	\N
3735	425	3408	2	keluar	\N	出ます	\N
3737	425	1637	3	keluar	\N	出ます	\N
3736	425	3377	1	keluar	\N	出て	\N
3884	702	3507	1	tidak baik	\N	悪い	\N
3883	702	3506	2	tidak baik	\N	悪い	\N
3931	670	3535	1	empat	\N	四つ	\N
3743	459	3414	1	hari Sabtu	\N	土曜日	\N
3053	757	1545	2	demam	\N	熱	\N
3052	757	3074	1	demam	\N	熱	\N
3046	551	3073	1	hospital	\N	病院	\N
3047	551	1738	2	hospital	\N	病院	\N
2768	593	1634	2	hotél	\N	ホテル	\N
2767	593	2944	1	hotél	\N	ホテル	\N
3206	796	3144	1	alamat	\N	住所	\N
2776	715	2734	2	luar negara	\N	海外	\N
2775	715	2946	1	luar negara	\N	海外	\N
3413	527	3263	1	ibu	\N	母	\N
2519	147	1176	2	pelajar	\N	学生	\N
2518	147	2153	1	pelajar	\N	学生	\N
2520	147	2158	3	pelajar	\N	学生	\N
4108	724	3684	1	musim bunga	\N	春	\N
4107	724	3685	1	musim bunga	\N	春	\N
3362	394	2086	1	bapa	\N	父	\N
2851	653	1180	2	cuti	\N	休み	\N
2850	653	2979	1	cuti	\N	休み	\N
2981	530	1194	2	cerah	\N	晴れ	\N
2980	530	3025	1	cerah	\N	晴れ	\N
3130	231	3117	1	taman	\N	公園	\N
3132	231	1255	3	taman	\N	公園	\N
3131	231	1222	2	taman	\N	公園	\N
4079	61	3660	2	anjing	\N	犬	\N
4080	61	3661	1	anjing	\N	犬	\N
2935	579	1667	2	pén	\N	ペン	\N
2934	579	1259	1	pén	\N	ペン	\N
3676	500	1246	2	buku nota	\N	ノート	\N
3675	500	3376	1	buku nota	\N	ノート	\N
3677	500	1527	3	buku nota	\N	ノート	\N
4185	739	3734	2	lagi	\N	もう	\N
4186	739	3735	1	lagi	\N	もう	\N
2637	577	2893	1	bilik	\N	部屋	\N
2638	577	1434	2	bilik	\N	部屋	\N
2886	43	1402	3	rumah	\N	家	\N
2884	43	2994	1	rumah	\N	家	\N
2885	43	1601	2	rumah	\N	家	\N
2504	195	2843	1	bilik darjah	\N	教室	\N
2505	195	1254	2	bilik darjah	\N	教室	\N
2506	195	1650	3	bilik darjah	\N	教室	\N
2545	288	1654	2	soalan	\N	質問	\N
2544	288	2856	1	soalan	\N	質問	\N
3199	99	2060	2	wang	\N	お金	\N
3200	99	2093	3	wang	\N	お金	\N
3198	99	1233	1	wang	\N	お金	\N
3396	71	3247	1	atas	\N	上	\N
3397	71	1323	2	atas	\N	上	\N
3398	286	3248	1	bawah	\N	下	\N
2593	604	1249	3	depan	\N	前	\N
2592	604	1255	2	depan	\N	前	\N
2591	604	2868	1	depan	\N	前	\N
3370	467	3235	1	dalam	\N	中	\N
3371	467	1258	2	dalam	\N	中	\N
3372	467	1275	3	dalam	\N	中	\N
3375	352	1734	3	luar	\N	外	\N
3373	352	1254	1	luar	\N	外	\N
3374	352	1410	2	luar	\N	外	\N
2586	618	2867	1	kanan	\N	右	\N
2587	618	1247	2	kanan	\N	右	\N
2582	544	2866	1	kiri	\N	左	\N
2583	544	1248	2	kiri	\N	左	\N
2328	162	1245	2	bég	\N	かばん	\N
2329	162	1302	3	bég	\N	かばん	\N
2327	162	1418	1	bég	\N	かばん	\N
4078	497	3659	1	kucing	\N	猫	\N
4077	497	3658	2	kucing	\N	猫	\N
1514	589	1251	1	peti surat	\N	ポスト	\N
1515	589	1531	2	peti surat	\N	ポスト	\N
3406	184	3256	1	utara	\N	北	\N
2618	391	2881	1	dekat	\N	近く	\N
2619	391	1257	2	dekat	\N	近く	\N
2716	559	2923	1	kolam renang	\N	プール	\N
2718	559	1778	3	kolam renang	\N	プール	\N
2717	559	1548	2	kolam renang	\N	プール	\N
2345	704	2497	3	tingkat	\N	階	\N
2343	704	2790	1	tingkat	\N	階	\N
2344	704	2495	2	tingkat	\N	階	\N
2832	312	2065	2	surat khabar	\N	新聞	\N
2831	312	2971	1	surat khabar	\N	新聞	\N
4591	8	3680	2	musim luruh	\N	秋	\N
4590	8	3681	1	musim luruh	\N	秋	\N
3423	545	1476	2	orang	\N	人	\N
3422	545	1276	1	orang	\N	人	\N
4449	21	1274	1	baru	\N	新しい	\N
4450	21	1947	2	baru	\N	新しい	\N
4480	823	3860	1	komputer	\N	コンピューター	\N
4481	823	1831	2	komputer	\N	コンピューター	\N
4064	512	3647	1	kotak	\N	箱	\N
4063	512	3646	2	kotak	\N	箱	\N
3832	387	3474	1	kecil	\N	小さくて	\N
3831	387	3473	2	kecil	\N	小さい	\N
3992	228	3593	1	sihat/ceria	\N	元気じゃ　ありません	\N
3993	228	3594	2	sihat/ceria	\N	元気な	\N
4539	82	3010	1	lukisan/melukis	\N	絵	\N
4540	82	1455	2	lukisan/melukis	\N	絵	\N
2421	380	1860	2	makanan	\N	食べ物	\N
2420	380	2806	1	makanan	\N	食べ物	\N
2302	569	1281	2	lama	\N	古い	\N
2301	569	2780	1	lama	\N	古い	\N
4611	285	2023	3	senyap	0	静か	0
4609	285	3518	1	senyap	0	静かで	0
4610	285	3519	2	senyap	0	静かな	0
2321	208	1286	2	kasut	\N	靴	\N
2320	208	2785	1	kasut	\N	靴	\N
2339	140	1640	3	beli	\N	買いに	\N
2338	140	1477	2	beli	\N	買った	\N
2337	140	2789	1	beli	\N	買いました	\N
1128	219	1534	1	hitam	\N	黒い	\N
2838	284	1291	2	kamus	\N	辞書	\N
2837	284	2974	1	kamus	\N	辞書	\N
3181	200	1535	3	cantik/bersih	\N	きれいで	\N
3179	200	3134	1	cantik/bersih	\N	きれい	\N
3180	200	1455	2	cantik/bersih	\N	きれい	\N
3424	132	3272	1	perempuan	\N	女	\N
3829	94	3472	1	besar	\N	大きくて	\N
3830	94	1401	2	besar	\N	大きい	\N
2482	434	1305	2	tandas	\N	トイレ	\N
2481	434	2835	1	tandas	\N	トイレ	\N
3485	26	3288	1	awak	\N	あなた	\N
3487	26	2234	3	awak	\N	あなた	\N
3486	26	3289	2	awak	\N	あなた	\N
3488	26	2170	4	awak	\N	あなた	\N
4461	829	3856	2	kék	\N	ケーキ	\N
4463	829	1319	3	kék	\N	ケーキ	\N
4462	829	3855	1	kék	\N	ケーキ	\N
2938	586	3022	1	pén mata bulat	\N	ボールペン	\N
2939	586	2249	2	pén mata bulat	\N	ボールペン	\N
2402	89	2802	2	yén	\N	円	\N
2403	89	2801	1	yén	\N	円	\N
2815	270	2965	1	buah	\N	冊	\N
2816	270	1323	2	buah	\N	冊	\N
2827	271	2969	2	majalah	\N	雑誌	\N
2828	271	2970	1	majalah	\N	雑誌	\N
3123	46	3115	2	berapa	\N	いくつ	\N
3122	46	3114	1	berapa	\N	いくつ	\N
4052	535	3638	1	sapu tangan	\N	ハンカチ	\N
4051	535	3637	2	sapu tangan	\N	ハンカチ	\N
2363	597	2794	2	helai/keping	\N	枚	\N
2362	597	2793	1	helai/keping	\N	枚	\N
2364	597	1326	3	helai/keping	\N	枚	\N
3445	571	1679	2	minit	\N	分	\N
3444	571	3284	1	minit	\N	分	\N
3455	489	3285	1	hari Ahad	\N	日曜日	\N
3456	489	1392	2	hari Ahad	\N	日曜日	\N
2514	581	2846	2	belajar	\N	勉強	\N
2513	581	2845	1	belajar	\N	勉強	\N
1461	329	1530	2	する	\N	し	\N
1463	329	1810	4	する	\N	しよ	\N
1460	329	1721	1	する	\N	し	\N
1464	329	1799	5	する	\N	し	\N
1462	329	1398	3	する	\N	し	\N
2267	426	1341	1	TV	\N	テレビ	\N
2268	426	2192	2	TV	\N	テレビ	\N
2269	426	1630	3	TV	\N	テレビ	\N
2909	759	3006	1	piano	\N	ピアノ	\N
4023	506	3618	1	majlis	\N	パーティー	\N
4024	506	1398	2	majlis	\N	パーティー	\N
3105	654	2991	1	tidak hadir	\N	休みます	\N
3175	646	3133	1	pintu pagar	\N	門	\N
4544	568	1931	2	turun	\N	降りそうです	\N
4543	568	3042	1	turun	\N	降りませんでした	\N
3623	130	3351	1	habis	\N	終わったら	\N
3624	130	1348	2	habis	\N	終わります	\N
4178	608	3731	1	masih	\N	まだ	\N
4177	608	3730	2	masih	\N	まだ	\N
3182	76	1367	1	rumah	\N	うち	\N
3183	76	2178	2	rumah	\N	うち	\N
4466	828	1371	1	air coca-cola	\N	コーラ	\N
4467	828	1710	2	air coca-cola	\N	コーラ	\N
2454	503	1818	2	minum/makan	\N	飲みたいです	\N
2455	503	2004	3	minum/makan	\N	飲みました	\N
2453	503	1371	1	minum/makan	\N	飲みます	\N
2925	630	1396	1	téngok	\N	見ました	\N
2926	630	1974	2	téngok	\N	見ました	\N
2346	417	1482	1	surat	\N	手紙	\N
2347	417	1378	2	surat	\N	手紙	\N
2354	371	1971	3	hantar/memberi (beri)	\N	出して	\N
2352	371	1378	1	hantar/memberi (beri)	\N	出します	\N
2353	371	1654	2	hantar/memberi (beri)	\N	出しました	\N
2373	152	2090	3	meminjamkan 	\N	貸して	\N
2371	152	1379	1	meminjamkan 	\N	貸します	\N
2372	152	2092	2	meminjamkan 	\N	貸して	\N
4446	170	1382	2	meminjam (pinjam)	\N	借ります	\N
4445	170	3852	1	meminjam (pinjam)	\N	借りて	\N
3720	480	3396	2	belajar	\N	習って	\N
3721	480	3397	1	belajar	\N	習いました	\N
4538	830	1614	2	dinding	\N	壁	\N
4537	830	3854	1	dinding	\N	壁	\N
3613	101	1386	2	letak	\N	置きます	\N
3612	101	3347	1	letak	\N	置いて	\N
3713	622	1625	2	menunjukkan	\N	見せます	\N
3712	622	3392	1	menunjukkan	\N	見せて	\N
3133	779	3118	1	ténis	\N	テニス	\N
3134	779	1881	2	ténis	\N	テニス	\N
4542	273	1403	2	sejuk	\N	寒くない	\N
4541	273	3053	1	sejuk	\N	寒い	\N
3886	127	3508	2	kelakar/menarik	\N	おもしろい	\N
3887	127	3509	1	kelakar/menarik	\N	おもしろい	\N
3319	92	3212	2	sedap	\N	おいしそう	\N
3320	92	3213	1	sedap	\N	おいしい	\N
3377	6	1537	1	mérah	\N	赤い	\N
4608	367	3496	2	tinggi	0	高い	0
4607	367	3495	1	tinggi	0	高い	0
4127	34	3700	1	tidak begitu	\N	あまり	\N
4128	34	1428	2	tidak begitu	\N	あまり	\N
1480	556	1426	1	luas	\N	広くありません	\N
2315	561	1435	2	baju	\N	服	\N
2314	561	2783	1	baju	\N	服	\N
2316	561	2130	3	baju	\N	服	\N
2995	764	3057	1	rambut	\N	髪	\N
4048	331	1446	2	ketinggian	\N	背	\N
4047	331	3634	1	ketinggian	\N	背	\N
3143	411	3123	1	kuat	\N	強い	\N
2259	52	1450	2	sakit	\N	痛い	\N
2260	52	1451	3	sakit	\N	痛くない	\N
2258	52	2766	1	sakit	\N	痛い	\N
4072	609	3653	1	bandar	\N	町	\N
4071	609	3652	2	bandar	\N	町	\N
2676	623	1478	2	jalan	\N	道	\N
2675	623	2906	1	jalan	\N	道	\N
1481	336	1454	1	sempit	\N	狭い	\N
3392	69	3245	1	warna	\N	色	\N
2985	74	1457	2	lagu	\N	歌	\N
2984	74	3050	1	lagu	\N	歌	\N
4562	110	3898	1	ayah	\N	お父さん	\N
2880	521	1459	3	bekerja	\N	働きます	\N
2879	521	2992	2	bekerja	\N	働いて	\N
2878	521	2993	1	bekerja	\N	働きます	\N
183	49	1460	1	doktor	\N	医者	\N
4006	583	3605	2	mudah diguna/berguna	\N	便利な	\N
4007	583	3606	1	mudah diguna/berguna	\N	便利	\N
2812	672	1696	2	baca	\N	読みます	\N
2811	672	1599	1	baca	\N	読みました	\N
3663	373	3371	2	berdiri	\N	立って	\N
3664	373	3372	1	berdiri	\N	立って	\N
3665	373	1485	3	berdiri	\N	立って	\N
3580	613	3331	2	tingkap	\N	窓	\N
3581	613	2894	1	tingkap	\N	窓	\N
3579	9	1921	3	buka	\N	開いて	\N
3577	9	3330	1	buka	\N	開きます	\N
3578	9	1501	2	buka	\N	開いて	\N
3775	598	3434	2	setiap pagi	\N	毎朝	\N
3776	598	3435	1	setiap pagi	\N	毎朝	\N
3562	499	3324	1	tahun	\N	年	\N
3561	499	3323	2	tahun	\N	年	\N
4629	308	3369	1	tahu	0	知りませんでした	0
4630	308	3370	2	tahu	0	知って	0
2625	605	1507	2	berliku-liku/bélok	\N	曲がって	\N
2624	605	2884	1	berliku-liku/bélok	\N	曲がる	\N
4604	139	3617	2	membeli-belah	0	買い物	0
4603	139	3153	1	membeli-belah	0	買い物	0
3659	750	3368	1	tutup	\N	閉めます	\N
3660	750	1512	2	tutup	\N	閉めて	\N
3171	428	1513	2	lampu	\N	電気	\N
3170	428	2901	1	lampu	\N	電気	\N
3161	222	3129	1	memadamkan (padam)	\N	消します	\N
3160	222	3128	2	memadamkan (padam)	\N	消す	\N
2462	87	2115	1	stésén	\N	駅	\N
2463	87	1551	2	stésén	\N	駅	\N
3010	647	2857	1	soalan	\N	問題	\N
3011	647	1515	2	soalan	\N	問題	\N
4037	573	1515	2	muka surat	\N	ページ	\N
4036	573	3627	1	muka surat	\N	ページ	\N
4614	146	3171	1	menulis (tulis) 	0	書きます	0
4615	146	3172	2	menulis (tulis) 	0	書きました	0
3004	199	2871	2	memotong (potong) 	\N	切ります	\N
3003	199	3060	1	memotong (potong) 	\N	切りました	\N
3571	10	3329	2	buka	\N	開けて	\N
3573	10	1520	3	buka	\N	開けて	\N
3572	10	3328	1	buka	\N	開けます	\N
3260	526	3169	1	bercakap (cakap) 	\N	話して	\N
3259	526	3168	2	bercakap (cakap) 	\N	話す	\N
3091	534	1532	2	roti	\N	パン	\N
3090	534	1609	1	roti	\N	パン	\N
3738	226	3409	1	hari Isnin	\N	月曜日	\N
3139	777	3120	1	bola sépak	\N	サッカー	\N
432	423	1530	1	pusat membeli-belah	\N	デパート	\N
3119	788	3111	1	pasar raya	\N	スーパー	\N
4029	382	3623	2	telur	\N	卵	\N
4030	382	3624	1	telur	\N	卵	\N
2927	575	3018	1	katil	\N	ベッド	\N
473	30	1535	1	flat	\N	アパート	\N
4507	327	2030	3	tinggal	\N	住んで	\N
4506	327	1928	2	tinggal	\N	住んで	\N
4505	327	1535	1	tinggal	\N	住んで	\N
3029	681	3065	2	pelajar antarabangsa	\N	留学生	\N
3028	681	3066	1	pelajar antarabangsa	\N	留学生	\N
3985	695	3588	1	muda	\N	若い	\N
3984	695	3587	2	muda	\N	若くて	\N
972	209	1542	1	stoking	\N	靴下	\N
242	634	1544	1	susah	\N	難しい	\N
3910	418	3135	1	boléh	\N	できます	\N
2731	128	2189	2	berenang	\N	泳ぎました	\N
2732	128	1546	3	berenang	\N	泳いだり	\N
2730	128	2069	1	berenang	\N	泳ぎます	\N
1107	111	1547	3	adik lelaki	\N	弟	\N
1106	111	2030	2	adik lelaki	\N	弟	\N
1105	111	2093	1	adik lelaki	\N	弟	\N
2751	543	1619	1	kapal terbang	\N	飛行機	\N
2752	543	1549	2	kapal terbang	\N	飛行機	\N
3568	2	3327	2	berjumpa	\N	会って	\N
3567	2	3326	1	berjumpa	\N	会います	\N
4470	832	3857	1	konsert	\N	コンサート	\N
4471	832	1660	2	konsert	\N	コンサート	\N
2651	100	2042	3	bangun	\N	起きる	\N
2649	100	1388	1	bangun	\N	起きます	\N
2650	100	2018	2	bangun	\N	起きられませんでした	\N
2416	307	1588	1	kantin	\N	食堂	\N
2417	307	1553	2	kantin	\N	食堂	\N
2608	330	2874	1	duduk	\N	座って	\N
2609	330	1556	2	duduk	\N	座って	\N
991	582	2097	1	弁当	\N	弁当	\N
993	582	1556	3	弁当	\N	弁当	\N
992	582	1728	2	弁当	\N	弁当	\N
2705	38	1557	2	berjalan kaki	\N	歩いて	\N
2704	38	1586	1	berjalan kaki	\N	歩きます	\N
2706	38	2055	3	berjalan kaki	\N	歩きましょう	\N
4451	413	1477	1	pita	\N	テープ	\N
4452	413	1558	2	pita	\N	テープ	\N
4086	78	3667	1	laut	\N	海	\N
4085	78	3666	2	laut	\N	海	\N
4087	656	3668	2	gunung	\N	山	\N
4088	656	3669	1	gunung	\N	山	\N
3718	501	3395	1	mendaki	\N	登ります	\N
3719	501	3394	2	mendaki	\N	登った	\N
3140	778	3121	1	bésbol	\N	野球	\N
3141	790	3122	1	perlawanan	\N	試合	\N
3209	797	1562	2	taufan	\N	台風	\N
3208	797	1672	1	taufan	\N	台風	\N
2467	429	2830	1	keréta api	\N	電車	\N
2468	429	1672	2	keréta api	\N	電車	\N
2469	429	1562	3	keréta api	\N	電車	\N
3689	457	3381	2	berhenti	\N	止まりました	\N
3688	457	3380	1	berhenti	\N	止まります	\N
1467	492	1636	1	halaman rumah	\N	庭	\N
1468	492	1935	2	halaman rumah	\N	庭	\N
3279	143	3185	1	muka	\N	顔	\N
3352	36	3232	1	membasuh (basuh) 	\N	洗います	\N
3030	421	3068	2	ujian	\N	テスト	\N
3031	421	2858	1	ujian	\N	テスト	\N
4095	355	3676	2	langit	\N	空	\N
4096	355	3677	1	langit	\N	空	\N
3381	4	3236	1	biru	\N	青い	\N
3382	4	1592	2	biru	\N	青い	\N
3893	376	3510	2	seronok	\N	楽しかった	\N
3894	376	1862	3	seronok	\N	楽しい	\N
3892	376	3511	1	seronok	\N	楽しい	\N
2741	517	2933	1	berlari (lari) 	\N	走れません	\N
2742	517	1990	2	berlari (lari) 	\N	走って	\N
4535	297	3880	1	gambar	\N	写真	\N
4536	297	2181	2	gambar	\N	写真	\N
2489	504	1619	2	naik	\N	乗ります	\N
2488	504	2839	1	naik	\N	乗ります	\N
3417	97	3267	1	emak	\N	お母さん	\N
3287	326	3190	1	seluar	\N	ズボン	\N
3955	134	3558	2	kali	\N	回	\N
3956	134	3559	1	kali	\N	回	0
3652	266	3363	2	mekar	\N	咲いて	\N
3651	266	3364	1	mekar	\N	咲きます	\N
3549	247	3317	1	tahun ini	\N	今年	\N
3550	247	1638	2	tahun ini	\N	今年	\N
3115	298	3108	1	keméja	\N	シャツ	\N
3116	298	1640	2	keméja	\N	シャツ	\N
3267	812	3173	2	huruf	\N	字	\N
3268	812	3174	1	huruf	\N	字	0
4486	831	3862	2	karaoké	\N	カラオケ	\N
4487	831	3863	1	karaoké	\N	カラオケ	\N
2922	75	3015	1	menyanyi (nyanyi) 	\N	歌います	\N
4044	235	3633	1	suara	\N	声	\N
4043	235	3632	2	suara	\N	声	\N
3407	628	3257	1	selatan	\N	南	\N
2746	456	1645	2	terbang	\N	飛んで	\N
2745	456	2934	1	terbang	\N	飛んで	\N
4631	509	3688	1	masuk	0	入りました	0
4633	509	3687	3	masuk	0	入ります	0
4632	509	3689	2	masuk	0	入ります	0
758	518	1668	1	bas	\N	バス	\N
2232	552	1671	1	sakit	\N	病気	\N
2233	552	2019	2	sakit	\N	病気	\N
3949	548	3552	2	seorang	\N	一人	\N
3950	548	3553	1	seorang	\N	一人	\N
4561	154	3897	1	keluarga	\N	家族	\N
2721	304	2926	1	pandai	\N	上手	\N
2720	304	2925	2	pandai	\N	上手なので	\N
4560	615	3896	1	puluh ribu	\N	万	\N
2499	214	2842	1	sekelas	\N	クラス	\N
2500	214	1682	2	sekelas	\N	クラス	\N
3108	657	1683	1	membuat (buat) 	\N	やります	\N
4523	390	1693	2	berbeza	\N	違います	\N
4522	390	3375	1	berbeza	\N	違います	\N
2098	747	2180	3	semasa/apabila	\N	とき	\N
2100	747	2178	5	semasa/apabila	\N	とき	\N
2096	747	2189	1	semasa/apabila	\N	とき	\N
2097	747	2187	2	semasa/apabila	\N	とき	\N
2615	393	2880	1	peta	\N	地図	\N
3390	5	3243	1	mérah	\N	赤	\N
3349	412	3229	1	tangan	\N	手	\N
2404	479	2803	1	nama	\N	名前	\N
2406	479	1965	3	nama	\N	名前	\N
2405	479	1714	2	nama	\N	名前	\N
3709	610	3390	2	menunggu (tunggu) 	\N	待って	\N
3708	610	3391	1	menunggu (tunggu) 	\N	待ちます	\N
2857	378	2229	2	merokok	\N	たばこ	\N
3303	755	2097	1	bekal	\N	お弁当	\N
2856	378	2982	1	merokok	\N	たばこ	\N
716	268	528	1	酒	\N	酒	\N
4574	841	3907	1	tidak boléh	\N	だめ	\N
484	570	1745	1	ふろ	\N	ふろ	\N
4484	834	3861	1	suis	\N	スイッチ	\N
4485	834	1748	2	suis	\N	スイッチ	\N
3806	239	3458	1	petang/malam	\N	午後	\N
3807	239	1768	2	petang/malam	\N	午後	\N
3391	3	3244	1	biru	\N	青	\N
4283	261	3771	1	entahlah/baiklah	\N	さあ	\N
4282	261	3770	2	entahlah/baiklah	\N	さあ	\N
2707	701	2920	2	lintas	\N	渡って	\N
2708	701	2921	1	lintas	\N	渡ります	\N
899	346	1810	1	membersihkan  	\N	掃除	\N
1508	490	2100	1	bagasi	\N	荷物	\N
1509	490	1794	2	bagasi	\N	荷物	\N
2152	643	2249	3	bawa	\N	持って	\N
2150	643	2179	1	bawa	\N	持って	\N
2154	643	1794	5	bawa	\N	持ちましょう	\N
3410	487	3260	1	barat	\N	西	\N
3923	528	3528	1	awal	\N	早い	\N
3922	528	3529	2	awal	\N	早く	\N
4618	260	1813	3	malam ini	0	今晩	0
4616	260	3444	1	malam ini	0	今晩	0
4617	260	3445	2	malam ini	0	今晩	0
4414	631	3828	1	semua	\N	みんな	\N
4413	631	3827	2	semua	\N	みんな	\N
4412	631	3826	3	semua	\N	みんな	\N
2698	289	2041	3	basikal	\N	自転車	\N
2697	289	2913	2	basikal	\N	自転車	\N
2696	289	2914	1	basikal	\N	自転車	\N
3386	310	3237	1	putih	\N	白い	\N
3385	310	3239	2	putih	\N	白くて	\N
4067	165	3649	1	kertas	\N	紙	\N
4068	165	3648	2	kertas	\N	紙	\N
3137	325	3119	1	sukan	\N	スポーツ	\N
3138	325	1849	2	sukan	\N	スポーツ	\N
4132	60	3703	1	selalu	\N	いつも	\N
4131	60	3702	2	selalu	\N	いつも	\N
3980	638	3583	2	méter	\N	メートル	\N
3981	638	3584	1	méter	\N	メートル	\N
3276	230	3182	2	bahasa	\N	語	\N
3277	230	3183	1	bahasa	\N	語	\N
2964	531	3040	1	cerah	\N	晴れて	\N
2965	531	3041	2	cerah	\N	晴れたら	\N
4166	731	3723	1	mungkin	\N	たぶん	\N
4165	731	3722	2	mungkin	\N	たぶん	\N
3085	774	3094	1	pekerja	\N	店員	\N
3084	774	3093	2	pekerja	\N	店員	\N
2658	445	2900	1	jam	\N	時計	\N
2659	445	1919	2	jam	\N	時計	\N
3358	64	2079	1	adik perempuan	\N	妹	\N
3359	64	2099	2	adik perempuan	\N	妹	\N
3306	33	3199	1	manis	\N	甘い	\N
4075	460	3656	2	burung	\N	鳥	\N
4076	460	3657	1	burung	\N	鳥	\N
3468	675	1942	2	bulan depan	\N	来月	\N
3467	675	3287	1	bulan depan	\N	来月	\N
2521	332	2847	2	pelajar	\N	生徒	\N
2522	332	2848	1	pelajar	\N	生徒	\N
2940	427	3023	2	cuaca	\N	天気	\N
2941	427	3024	1	cuaca	\N	天気	\N
2924	462	3017	1	ambil	\N	撮りました	\N
2541	267	2854	2	karangan	\N	作文	\N
2540	267	2855	1	karangan	\N	作文	\N
2446	237	2820	1	kopi	\N	コーヒー	\N
2447	233	2821	1	téｈ	\N	紅茶	\N
2913	166	3008	1	kaméra	\N	カメラ	\N
2912	166	3007	2	kaméra	\N	カメラ	\N
3204	536	3143	1	nombor	\N	番号	\N
2492	294	2840	2	tutup	\N	閉まって	\N
2493	294	2841	1	tutup	\N	閉まって	\N
3616	124	3349	2	ingat/hafal	\N	覚えて	\N
3617	124	3350	1	ingat/hafal	\N	覚えます	\N
3054	117	2764	1	perut	\N	おなか	\N
3800	673	3453	1	malam	\N	夜	\N
3801	673	3452	2	malam	\N	夜	\N
4427	578	3839	2	dekat	\N	辺	\N
4428	578	3840	1	dekat	\N	辺	\N
3615	106	2798	1	tekan	\N	押します	\N
3614	106	3348	2	tekan	\N	押す	\N
4580	433	3058	2	pintu	\N	ドア	\N
4622	318	3713	2	terus/sekejap lagi	0	すぐに	0
4621	318	3712	1	terus/sekejap lagi	0	すぐ	0
2307	389	2055	2	dekat	\N	近い	\N
2306	389	2782	1	dekat	\N	近い	\N
3900	65	3514	2	tidak suka/tidak sedap	\N	嫌な	\N
3899	65	3515	1	tidak suka/tidak sedap	\N	嫌	\N
3901	65	2056	3	tidak suka/tidak sedap	\N	嫌なら	\N
4396	368	3812	2	banyak	\N	たくさん	\N
4397	368	3813	1	banyak	\N	たくさん	\N
3701	700	3386	1	beri	\N	渡しました	\N
3516	350	3298	1	sana/itu	\N	そちら	\N
3515	350	3297	2	sana/itu	\N	そちら	\N
1571	502	2120	1	minuman	\N	飲み物	\N
3808	282	3459	2	masa	\N	時間	\N
3809	282	3460	1	masa	\N	時間	\N
4017	491	3616	1	berita	\N	ニュース	\N
4016	491	3615	2	berita	\N	ニュース	\N
3330	659	3217	1	makan malam	\N	夕飯	\N
3331	659	2123	2	makan malam	\N	夕飯	\N
3608	79	3346	2	menjual (jual) 	\N	売って	\N
3609	79	3344	1	menjual (jual) 	\N	売って	\N
3242	705	3164	1	pakai	\N	着ます	\N
3243	705	1481	2	pakai	\N	着て	\N
3744	340	3415	1	minggu lepas	\N	先週	\N
1099	27	2158	1	abang	\N	兄	\N
3666	377	3373	2	meminta (minta) 	\N	頼まれました	\N
3667	377	3374	1	meminta (minta) 	\N	頼みます	\N
3513	22	3295	1	itu	\N	あちら	\N
3512	22	3294	2	itu	\N	あちら	\N
4269	450	3765	1	yang mana/mana	\N	どちら	\N
4268	450	3764	2	yang mana/mana	\N	どちら	\N
3803	708	3455	1	malam	\N	晩	\N
3802	708	3454	2	malam	\N	晩	\N
3836	707	3476	1	gelap	\N	暗い	\N
3837	707	2206	2	gelap	\N	暗い	\N
2655	498	1389	2	tidur	\N	寝ます	\N
2654	498	2899	1	tidur	\N	寝て	\N
2137	751	2244	1	引く	\N	引い	\N
695	108	2213	1	téh	\N	お茶	\N
696	108	2247	2	téh	\N	お茶	\N
4557	300	3893	1	sepuluh	0	十	\N
3843	706	3480	2	panas	\N	熱い	\N
3842	706	3479	1	panas	\N	熱い	\N
4267	453	3763	2	siapa	\N	どなた	\N
4266	453	3762	1	siapa	\N	どなた	\N
2350	188	1322	1	setém	\N	切手	\N
2349	510	2791	1	poskad	\N	はがき	\N
3805	242	3457	1	pagi	\N	午前	\N
3804	242	3456	2	pagi	\N	午前	\N
4564	168	1408	2	pedas	\N	辛い	\N
4565	168	1409	3	pedas	\N	辛くない	\N
4563	168	3215	1	pedas	\N	辛い	\N
3694	697	3382	2	lupa/tertinggal	\N	忘れないで	\N
3695	697	1473	3	lupa/tertinggal	\N	忘れないで	\N
3693	697	3383	1	lupa/tertinggal	\N	忘れました	\N
2393	533	1647	2	nombor	\N	番	\N
2392	533	2800	1	nombor	\N	番	\N
3431	116	3279	1	déwasa	\N	大人	\N
3018	766	3064	1	jawapan	\N	答え	\N
3019	766	1971	2	jawapan	\N	答え	\N
3538	339	3300	1	bulan lepas	\N	先月	\N
3537	339	3311	2	bulan lepas	\N	先月	\N
4448	689	2805	1	réstoran	\N	レストラン	\N
4447	689	3853	2	réstoran	\N	レストラン	\N
2868	408	2987	1	bekerja	\N	勤めて	\N
3286	333	3189	1	baju sejuk	\N	セーター	\N
2799	264	2958	1	ikan	\N	魚	\N
3219	807	3150	2	pasport	\N	パスポート	\N
3220	807	3151	1	pasport	\N	パスポート	\N
3346	524	3226	1	hidung	\N	鼻	\N
3299	90	2774	1	pénsél	\N	鉛筆	\N
3699	696	3385	1	faham	\N	分かります	\N
3700	696	3384	2	faham	\N	分からない	\N
3062	768	3079	1	khabar	\N	連絡	\N
3061	768	3078	2	khabar	\N	連絡	\N
3685	752	3379	2	mengambil (ambil) 	\N	取って	\N
3684	752	3378	1	mengambil (ambil) 	\N	取ります	\N
4531	301	3879	1	minggu	\N	週間	\N
4418	532	3830	2	setengah	\N	半	\N
4417	532	3829	1	setengah	\N	半	\N
3902	363	3516	2	sangat suka	\N	大好きな	\N
3903	363	3517	1	sangat suka	\N	大好き	\N
4377	58	3795	1	bersama	\N	いっしょ	\N
4379	58	3797	3	bersama	\N	いっしょ	\N
4378	58	3796	2	bersama	\N	いっしょ	\N
3093	781	3098	2	kad krédit	\N	カード	\N
3094	781	3099	1	kad krédit	\N	カード	\N
4176	607	2562	3	lagi	\N	また	\N
4175	607	3728	2	lagi	\N	また	\N
4174	607	3729	1	lagi	\N	また	\N
4519	70	3704	1	segalanya	\N	いろいろ	\N
4517	680	3876	1	baik	\N	りっぱな	\N
4516	680	3875	2	baik	\N	りっぱな	\N
3838	7	3477	2	terang	\N	明るい	\N
3839	7	3478	1	terang	\N	明るくて	\N
3585	11	3333	2	mengangkat (angkat)	\N	上げます	\N
3584	11	3332	1	mengangkat (angkat)	\N	上げます	\N
3326	13	3216	2	sarapan	\N	朝ごはん	\N
3327	13	3208	1	sarapan	\N	朝ごはん	\N
3768	14	3430	1	lusa	\N	あさって	\N
3767	14	3429	2	lusa	\N	あさって	\N
2528	18	2852	1	bermain	\N	遊びます	\N
2527	18	2851	2	bermain	\N	遊びに	\N
2959	19	3036	1	panas	\N	暖かい	\N
2958	19	3035	2	panas	\N	暖かく	\N
2243	20	2755	2	otak/kepala	\N	頭	\N
2242	20	2763	1	otak/kepala	\N	頭	\N
3855	23	3486	1	tebal	\N	厚くて	\N
3854	23	3488	2	tebal	\N	厚い	\N
3514	24	3296	1	sana	\N	あっち	\N
3414	28	3264	1	kakak	\N	姉	\N
4280	29	3768	2	itu	\N	あの	\N
4281	29	3769	1	itu	\N	あの	\N
2895	31	2997	1	mandi	\N	浴びて	\N
2626	32	2885	2	berbahaya	\N	危ない	\N
2627	32	2886	1	berbahaya	\N	危ない	\N
4628	37	3334	2	ada	0	ある	0
4627	37	3335	1	ada	0	ありません	0
4089	48	3670	2	kolam	\N	池	\N
4090	48	3671	1	kolam	\N	池	\N
2270	50	2767	1	kerusi	\N	いす	\N
2859	51	2984	1	sibuk	\N	忙しい	\N
2858	51	2983	2	sibuk	\N	忙しい	\N
3779	54	3438	2	satu hari	\N	一日	\N
3780	54	3439	1	satu hari	\N	一日	\N
3941	57	3545	1	lima hari bulan	\N	五日	\N
3932	59	3536	1	lima biji	\N	五つ	\N
3271	63	3177	2	maksud	\N	意味	\N
3272	63	3178	1	maksud	\N	意味	\N
2483	66	2836	1	pintu masuk	\N	入口	\N
3404	754	3254	2	ada	\N	います	\N
3405	754	3255	1	ada	\N	います	\N
3592	67	3339	1	perlu	\N	要ります	\N
3591	67	3338	2	perlu	\N	要ります	\N
2597	72	2761	2	belakang	\N	うしろ	\N
2596	72	2869	1	belakang	\N	うしろ	\N
3857	73	3490	1	nipis	\N	薄い	\N
3856	73	3489	2	nipis	\N	薄い	\N
3604	77	3343	1	lahir	\N	生まれました	\N
3603	77	3342	2	lahir	\N	生まれた	\N
3914	80	3523	1	bising	\N	うるさい	\N
3913	80	3522	2	bising	\N	うるさい	\N
3284	81	3187	1	kot	\N	上着	\N
4062	84	3645	1	pawagam	\N	映画館	\N
4061	84	3644	2	pawagam	\N	映画館	\N
4383	95	3799	2	besar	\N	大きな	\N
4382	95	3798	1	besar	\N	大きな	\N
4393	96	3809	1	ramai	\N	大勢	\N
4392	96	3808	2	ramai	\N	大勢	\N
3316	98	3209	1	kuih	\N	お菓子	\N
3415	102	3265	1	isteri	\N	奥さん	\N
3427	103	3275	1	pak cik	\N	おじさん	\N
3429	104	3277	1	datuk	\N	おじいさん	\N
2478	109	2834	1	tandas	\N	お手洗い	\N
3434	112	3282	1	lelaki	\N	男	\N
3435	113	3283	1	budak lelaki	\N	男の子	\N
3759	114	3421	2	dua hari lepas	\N	おととい	\N
3760	114	3422	1	dua hari lepas	\N	おととい	\N
3542	115	3315	1	dua tahun lepas	\N	おととし	\N
3541	115	3314	2	dua tahun lepas	\N	おととし	\N
3416	119	3266	1	abang	\N	お兄さん	\N
3411	120	3261	1	kakak	\N	お姉さん	\N
3428	121	3276	1	ibu saudara	\N	おばさん	\N
3430	122	3278	1	nénék	\N	おばあさん	\N
2292	123	1745	2	mandi	\N	おふろ	\N
2291	123	2779	1	mandi	\N	おふろ	\N
2614	125	2879	1	pegawai polis	\N	おまわりさん	\N
3859	126	3492	1	berat	\N	重い	\N
3858	126	3491	2	berat	\N	重い	\N
2485	129	2838	1	turun	\N	降ります	\N
3426	133	3274	1	budak perempuan	\N	女の子	\N
3212	136	2939	2	warga asing	\N	外国人	\N
3213	136	3146	1	warga asing	\N	外国人	\N
2476	138	2833	1	tangga	\N	階段	\N
3172	142	3130	1	balik	\N	帰ります	\N
3625	144	3352	2	mengambil (ambil)	\N	かかります	\N
3626	144	3353	1	mengambil (ambil)	\N	かかります	\N
3173	145	3131	2	kunci	\N	かぎ	\N
3174	145	3132	1	kunci	\N	かぎ	\N
3536	148	3305	1	bulan	\N	か月	\N
3535	148	3310	2	bulan	\N	か月	\N
3291	150	3194	1	mamakai	\N	かけます	\N
2322	151	2786	1	payung	\N	傘	\N
2989	711	3030	2	angin	\N	風	\N
2988	711	3052	1	angin	\N	風	\N
3207	155	3145	1	orang	\N	方	\N
3273	156	3179	1	katakana	\N	かたかな	\N
3529	157	3307	1	bulan	\N	月	\N
3530	157	3306	2	bulan	\N	月	\N
2451	159	2825	1	cawan	\N	カップ	\N
2900	160	3002	1	rumah	\N	家庭	\N
3399	161	3249	1	penjuru	\N	角	\N
2672	163	2902	1	pasu bunga	\N	花瓶	\N
4530	164	3878	1	pakai	\N	かぶって	\N
3739	167	3410	1	hari Selasa	\N	火曜日	\N
3340	169	3221	1	badan	\N	体	\N
4420	171	3832	1	nak	\N	がって	\N
4419	171	3831	2	nak	\N	がって	\N
3864	172	3494	1	ringan	\N	軽い	\N
3865	172	3493	2	ringan	\N	軽い	\N
2427	173	2810	1	kari	\N	カレー	\N
2426	173	2809	2	kari	\N	カレー	\N
2645	174	2895	1	kaléndar	\N	カレンダー	\N
2646	174	2896	2	kaléndar	\N	カレンダー	\N
2699	175	2915	2	sungai	\N	川	\N
2700	175	2916	1	sungai	\N	川	\N
3400	176	3250	2	sebelah	\N	側	\N
3401	176	3251	1	sebelah	\N	側	\N
3983	177	3586	1	comél	\N	かわいい	\N
3982	177	3585	2	comél	\N	かわいい	\N
4094	179	3675	1	pokok	\N	木	\N
4093	179	3674	2	pokok	\N	木	1
3393	180	3246	1	kuning	\N	黄色	\N
3384	181	3238	1	kuning	\N	黄色い	\N
3629	182	3356	2	mati	\N	消えた	\N
3630	182	3357	1	mati	\N	消えて	\N
3058	183	2882	1	bertanya	\N	聞きました	\N
2908	185	3005	1	gitar	\N	ギター	\N
3159	791	3127	1	kotor	\N	汚い	\N
3158	791	3126	2	kotor	\N	汚い	\N
2445	187	2819	1	kedai kopi	\N	喫茶店	\N
2471	189	2832	1	tikét	\N	切符	\N
3761	190	3423	2	semalam	\N	きのう	\N
3762	190	3424	1	semalam	\N	きのう	\N
2796	192	2955	1	daging lembu	\N	牛肉	\N
2448	193	2822	1	susu lembu	\N	牛乳	\N
3421	196	3271	1	adik-beradik	\N	兄弟	\N
2918	198	3011	2	tidak suka	\N	嫌いなので	\N
2919	198	3012	1	tidak suka	\N	嫌い	\N
3975	201	3578	1	kilogram	\N	キロ	\N
3974	201	3577	2	kilogram	\N	キログラム	\N
3190	202	3136	1	bank	\N	銀行	\N
3191	202	2795	2	bank	\N	銀行	\N
2802	206	2961	1	buah	\N	果物	\N
3347	207	3227	1	mulut	\N	口	\N
3215	210	3147	2	negara	\N	国	\N
3216	210	2943	1	negara	\N	国	\N
2947	211	3026	2	mendung	\N	曇り	\N
2946	211	3027	1	mendung	\N	曇り	\N
2979	212	3048	2	mendung	\N	曇って	\N
2978	212	3047	1	mendung	\N	曇って	\N
4583	213	3833	1	kira-kira	\N	くらい	\N
4584	213	3834	2	kira-kira	\N	ぐらい	\N
3978	215	3581	2	gram	\N	グラム	\N
3979	215	3582	1	gram	\N	グラム	\N
3387	218	3240	1	hitam	\N	黒	\N
2613	220	2878	2	anggota polis	\N	警官	\N
2612	220	2877	1	anggota polis	\N	警官	\N
3784	221	3443	1	pagi tadi/pagi ini	\N	けさ	\N
3783	221	3442	2	pagi tadi/pagi ini	\N	けさ	\N
3643	225	3362	2	berkahwin	\N	結婚して	\N
3644	225	3361	1	berkahwin	\N	結婚します	\N
2287	227	2776	1	pintu masuk rumah	\N	玄関	\N
2286	227	2777	2	pintu masuk rumah	\N	玄関	\N
3958	229	3561	1	biji	\N	個	\N
3957	229	3560	2	biji	\N	個	1
4552	736	3888	1	lima	\N	五	\N
2677	232	2907	1	persimpangan	\N	交差点	\N
2610	234	2875	2	pondok polis	\N	交番	\N
2611	234	2876	1	pondok polis	\N	交番	\N
3285	236	3188	1	kot	\N	コート	\N
3945	240	3549	1	sembilan hari bulan	\N	九日	\N
3936	241	3540	1	sembilan buah	\N	九つ	\N
2574	243	2863	1	menjawab(jawab)	\N	答える	\N
2450	246	2824	1	gelas	\N	コップ	\N
3278	248	3184	1	perkataan	\N	ことば	\N
3425	249	3273	1	kanak-kanak	\N	子ども	\N
2424	251	2807	1	nasi	\N	ごはん	\N
2425	251	2808	2	nasi	\N	ごはん	\N
2840	253	2973	1	membuat (buat) salinan	\N	コピーします	\N
2839	253	2975	2	membuat (buat) salinan	\N	コピーしました	\N
4423	256	3835	2	lebih kurang/semasa	\N	ごろ	\N
4424	256	3836	1	lebih kurang/semasa	\N	ころ	\N
4109	258	3686	2	minggu ini	\N	今週	\N
4110	258	3416	1	minggu ini	\N	今週	\N
4355	259	3790	2	seperti ini	\N	こんな	\N
4356	259	3791	1	seperti ini	\N	こんな	\N
3959	262	3562	2	tahun	\N	歳	\N
3960	262	3563	1	tahun	\N	歳	\N
2323	263	2787	1	dompét	\N	財布	\N
3815	265	3465	2	dulu	\N	先	\N
3816	265	3466	1	dulu	\N	先	\N
3655	269	3366	1	berpayung	\N	さして	\N
2452	272	2826	1	gula	\N	砂糖	\N
3557	275	3320	1	dua tahun akan datang	\N	さ来年	\N
3558	275	3321	2	dua tahun akan datang	\N	さ来年	\N
4550	734	3886	1	tiga	\N	三	\N
3432	276	3280	1	Encik/Puan/Cik	\N	さん	\N
2702	277	2918	1	berjalan-jalan	\N	散歩	\N
4586	278	3914	1	empat	\N	\N	\N
4592	278	3887	3	empat	0	四	\N
4585	278	3913	2	empat	\N	四	\N
3338	280	3220	2	garam	\N	塩	\N
3339	280	3219	1	garam	\N	塩	\N
4120	281	3693	1	tetapi	\N	しかし	\N
4119	281	3692	2	tetapi	\N	しかし	\N
4596	287	3915	2	tujuh	0	七	\N
4554	287	3890	1	tujuh	\N	七	\N
2690	290	2910	1	keréta	\N	自動車	\N
2689	290	2909	2	keréta	\N	自動車	\N
2894	299	2996	1	mandi	\N	シャワー	\N
3812	397	3462	1	semasa	\N	中	\N
3995	305	3596	1	kuat	\N	丈夫で	\N
3994	305	3595	2	kuat	\N	丈夫な	\N
3309	306	3202	1	kicap	\N	しょうゆ	\N
4545	309	3881	1	putih	\N	白	\N
2872	314	2989	2	menghisap (hisap)	\N	吸う	\N
2871	314	2988	1	menghisap (hisap)	\N	吸います	\N
3289	315	3192	1	skirt	\N	スカート	\N
4426	317	3838	1	lébih	\N	すぎ	\N
4425	317	3837	2	lébih	\N	すぎ	\N
3917	319	3526	2	sedikit	\N	少ない	\N
3918	319	3527	1	sedikit	\N	少ない	\N
2962	321	3038	2	sejuk	\N	涼しく	\N
2963	321	3039	1	sejuk	\N	涼しい	\N
4404	322	3818	2	démi	\N	ずつ	\N
4405	322	3819	1	démi	\N	ずつ	\N
2933	323	3019	2	pemanas	\N	ストーブ	\N
2932	323	3021	1	pemanas	\N	ストーブ	\N
2432	324	2812	1	sudu	\N	スプーン	\N
3290	328	3193	1	selipar	\N	スリッパ	\N
4057	334	3640	2	sabun	\N	せっけん	\N
4058	334	3641	1	sabun	\N	せっけん	\N
4547	337	3883	1	kosong	\N	ゼロ	\N
4559	338	3895	1	ribu	\N	千	\N
2890	342	2995	1	mencuci pakaian	\N	洗濯	\N
2897	343	2999	1	mencuci pakaian	\N	洗濯しなければ	\N
2896	347	2998	1	membersihkan	\N	掃除しよう	\N
4123	348	3696	2	dan	\N	そして	\N
4124	348	3697	1	dan	\N	そして	\N
2632	354	2889	1	dekat	\N	そば	\N
2631	354	2890	2	dekat	\N	そば	\N
4509	358	3873	1	baiklah	\N	それでは	\N
4508	358	3872	2	baiklah	\N	それでは	\N
3961	359	3564	2	buah	\N	台	\N
3962	359	3565	1	buah	\N	台	\N
2762	361	2941	1	kedutaan	\N	大使館	\N
2761	361	2940	2	kedutaan	\N	大使館	\N
3999	364	3600	2	penting	\N	大切な	\N
4000	364	3599	1	penting	\N	大切なので	\N
2288	365	2778	1	dapur	\N	台所	\N
2691	369	2911	2	téksi	\N	タクシー	\N
2692	369	2912	1	téksi	\N	タクシー	\N
4581	370	3911	1	sahaja	\N	だけ	\N
4582	370	3912	1	sahaja	\N	だけ	\N
4407	372	3821	1	X-X	\N	たち	\N
4406	372	3820	2	X-X	\N	たち	\N
4027	374	3621	2	lébar/menegak	\N	縦	\N
4028	374	3622	1	lébar/menegak	\N	縦	\N
4204	383	1308	2	siapa	\N	だれ	\N
4205	383	1900	3	siapa	\N	だれ	\N
4203	383	3746	1	siapa	\N	だれ	\N
4206	384	3747	2	sesiapa	\N	だれか	\N
4207	384	3748	1	sesiapa	\N	だれか	\N
4025	385	3619	2	hari jadi	\N	誕生日	\N
4026	385	3620	1	hari jadi	\N	誕生日	\N
4150	386	3716	2	semakin	\N	だんだん	\N
4151	386	3717	1	semakin	\N	だんだん	\N
4384	388	3800	2	kecil	\N	小さな	\N
4385	388	3801	1	kecil	\N	小さな	\N
2470	392	2831	1	keréta api bawah tanah	\N	地下鉄	\N
3389	395	3242	1	warna coklat	\N	茶色	\N
3311	396	3204	2	mangkuk	\N	ちゃわん	\N
3312	396	3205	1	mangkuk	\N	ちゃわん	\N
3937	400	3541	1	satu hari bulan	\N	一日	\N
3354	402	3234	1	letih	\N	疲れました	\N
25	404	2758	2	tiba	\N	着きます	\N
24	404	2757	1	tiba	\N	着きます	\N
1245	405	1533	1	méja	\N	机	\N
4612	406	3162	1	membuat (buat) 	0	作ります	0
4613	406	3161	2	membuat (buat) 	0	作って	0
3162	407	2898	1	pasang	\N	つけます	\N
3845	410	3482	1	sejuk	\N	冷たい	\N
3844	410	3481	2	sejuk	\N	冷たい	\N
3055	414	3075	1	méja	\N	テーブル	\N
2277	415	2773	1	テープレコーダー	\N	テープレコーダー	\N
2899	416	3001	1	keluar	\N	出かけませんでした	\N
2898	416	3000	2	keluar	\N	出かけます	\N
2484	420	2837	1	pintu keluar	\N	出口	\N
4032	431	3626	2	pintu	\N	戸	\N
4033	431	3625	1	pintu	\N	戸	\N
2977	432	3045	2	darjah	\N	度	\N
2976	432	3046	1	darjah	\N	度	\N
4084	438	3665	1	binatang	\N	動物	\N
4083	438	3664	2	binatang	\N	動物	\N
4528	440	3877	1	sepuluh	\N	十	\N
2303	441	2781	1	jauh	\N	遠い	\N
3946	442	3550	1	sepuluh hari bulan	\N	十日	\N
4164	444	3721	1	kadang-kadang	\N	時々	\N
4163	444	3720	2	kadang-kadang	\N	時々	\N
4014	447	3613	2	tempat	\N	所	\N
4015	447	3614	1	tempat	\N	所	\N
3540	448	3313	1	tahun	1	年	\N
4256	451	3756	2	yang mana	\N	どっち	\N
4257	451	3757	1	yang mana	\N	どっち	\N
2628	454	2887	2	sebelah	\N	隣	\N
2629	454	2888	1	sebelah	\N	隣	\N
4262	455	3760	2	yang mana	\N	どの	\N
4263	455	3761	1	yang mana	\N	どの	\N
2798	461	2957	1	daging ayam	\N	とり肉	\N
2436	466	2814	1	pisau	\N	ナイフ	\N
2435	466	2815	2	pisau	\N	ナイフ	\N
4399	469	3815	1	sambil	\N	ながら	\N
4398	469	3814	2	sambil	\N	ながら	\N
4117	470	3691	1	menangis	\N	泣いて	\N
4116	470	3690	2	menangis	\N	泣いて	\N
2633	471	2891	2	kehilangan	\N	なくした	\N
2634	471	2892	1	kehilangan	\N	なくして	\N
4402	475	3816	1	dan lain-lain	\N	など	\N
4403	475	3817	2	dan lain-lain	\N	など	\N
3934	476	3538	1	tujuh biji	\N	七つ	\N
3944	478	3548	1	tujuh hari bulan	\N	七日	\N
3732	481	3404	2	beratur	\N	並んで	\N
3731	481	3405	1	beratur	\N	並びました	\N
3726	482	3402	2	tersusun/menyusun (susun)	\N	並べて	\N
3727	482	3403	1	tersusun/menyusun (susun)	\N	並べます	\N
3733	483	3406	2	menjadi (jadi) 	\N	なりたいです	\N
3734	483	3407	1	menjadi (jadi) 	\N	なります	\N
4549	484	3885	1	dua	\N	二	1
3912	485	3521	1	meriah	\N	にぎやか	\N
3911	485	3520	2	meriah	\N	にぎやかな	\N
2794	486	2953	2	daging	\N	肉	\N
2795	486	2954	1	daging	\N	肉	\N
3782	488	3441	1	hari bulan	\N	日	\N
3298	494	3195	2	menanggalkan (tanggal)	\N	脱ぎます	\N
3297	494	3198	1	menanggalkan (tanggal)	\N	脱ぎます	\N
3112	496	2981	1	tali léhér	\N	ネクタイ	\N
17	505	2754	1	gigi	\N	歯	1
3965	507	3568	3	sudu/gelas	\N	杯	\N
3967	507	3570	1	sudu/gelas	\N	杯	\N
3966	507	3569	2	sudu/gelas	\N	杯	\N
3076	508	3088	2	tempat abu rokok	\N	灰皿	\N
3077	508	3089	1	tempat abu rokok	\N	灰皿	\N
3293	511	3196	2	memakai (pakai) 	\N	はいて	\N
3294	511	3197	1	memakai (pakai) 	\N	はいて	\N
2701	717	2917	1	jambatan	\N	橋	\N
2437	513	2816	1	はし	\N	はし	\N
3723	514	3399	1	bermula (mula)	\N	始まります	\N
3722	514	3398	2	bermula (mula)	\N	始まります	\N
4195	515	3744	2	terlébih dahulu/awal	\N	初めに	\N
4196	515	3745	1	terlébih dahulu/awal	\N	初め	\N
3953	520	3556	2	dua puluh tahun	\N	二十歳	\N
3954	520	3557	1	dua puluh tahun	\N	二十歳	\N
4555	522	3891	1	lapan	\N	八	\N
3947	523	3551	1	dua puluh hari bulan	\N	二十日	\N
4092	725	3673	1	bunga	\N	花	\N
4091	725	3672	2	bunga	\N	花	\N
3269	525	3175	2	cerita/bercerita	\N	話	\N
3270	525	3176	1	cerita/bercerita	\N	話	\N
2727	716	2929	1	cepat	\N	速い	\N
2726	716	2928	2	cepat	\N	速い	\N
2351	529	2792	1	menampal (tampal)	\N	はります	\N
3333	537	3218	1	makan malam	\N	晩ごはん	\N
3332	537	3206	2	makan malam	\N	晩ごはん	\N
4387	538	3803	1	separuh	\N	半分	\N
4386	538	3802	2	separuh	\N	半分	\N
3409	539	3259	1	timur	\N	東	\N
3968	540	3571	3	ékor	\N	匹	\N
3969	540	3572	2	ékor	\N	匹	\N
3970	540	3573	1	ékor	\N	匹	\N
2923	541	3016	1	bermain (main)	\N	弾きます	\N
3876	542	3499	2	rendah	\N	低い	\N
3877	542	3500	1	rendah	\N	低い	\N
3928	546	3532	1	sebiji	\N	一つ	\N
3531	547	3308	1	ひとつき	\N	ひとつき	\N
3532	547	3304	1	ひとつき	\N	ひとつき	\N
4011	549	3610	1	lapang	\N	暇なので	\N
4010	549	3609	2	lapang	\N	暇な	\N
4558	550	3894	1	seratus	\N	百	\N
3274	553	3180	1	hiragana	\N	ひらがな	\N
3794	554	3449	1	tengah hari 	\N	昼	\N
3793	554	3448	2	tengah hari 	\N	昼	\N
3321	555	3214	2	makan tengah hari	\N	昼ごはん	\N
3322	555	3207	1	makan tengah hari	\N	昼ごはん	\N
4041	557	3630	2	filem	\N	フィルム	\N
4042	557	3631	1	filem	\N	フィルム	\N
26	558	2759	1	sampul surat	\N	封筒	\N
2433	560	2813	1	garpu	\N	フォーク	\N
2971	713	3044	2	bertiup (tiup)	\N	吹くそうです	\N
2970	713	3043	1	bertiup (tiup)	\N	吹いて	\N
3929	562	3533	1	dua buah	\N	二つ	\N
2797	563	2956	1	daging babi	\N	ぶた肉	\N
3952	564	3555	1	berdua/dua orang	\N	二人	\N
3951	564	3554	2	berdua/dua orang	\N	二人	\N
3938	565	3542	1	dua hari bulan	\N	二日	\N
3852	566	3487	1	besar	\N	太い	\N
3853	566	3483	2	besar	\N	太い	\N
4097	567	3678	2	musim sejuk	\N	冬	\N
4098	567	3679	1	musim sejuk	\N	冬	\N
2724	574	2927	1	tidak pandai	\N	下手	\N
2725	574	2924	2	tidak pandai	\N	下手	\N
4081	576	3662	2	haiwan peliharaan	\N	ペット	\N
4082	576	3663	1	haiwan peliharaan	\N	ペット	\N
2535	580	1356	2	belajar	\N	勉強しました	\N
2536	580	1675	3	belajar	\N	勉強して	\N
2534	580	2853	1	belajar	\N	勉強します	\N
4429	584	3841	2	lebih	\N	ほう	\N
4430	584	3842	1	lebih	\N	ほう	\N
2317	585	2784	1	topi	\N	帽子	\N
4049	588	3635	2	pokét	\N	ポケット	\N
4050	588	3636	1	pokét	\N	ポケット	\N
3988	590	3591	2	nak	\N	欲しい	\N
3989	590	3592	1	nak	\N	欲しい	\N
3848	591	3485	1	kurus	\N	細くて	\N
3847	591	3484	2	kurus	\N	細く	\N
2824	595	2968	1	rak buku	\N	本棚	\N
2823	595	2967	2	rak buku	\N	本棚	\N
3748	599	3419	1	setiap minggu	\N	毎週	\N
3533	600	3309	2	setiap bulan	\N	毎月	\N
3534	600	3301	1	setiap bulan	\N	毎月	\N
3560	601	3312	1	setiap tahun	\N	毎年	\N
3559	601	3322	2	setiap tahun	\N	毎年	\N
3777	603	3436	2	setiap malam	\N	毎晩	\N
3778	603	3437	1	setiap malam	\N	毎晩	\N
3317	606	3210	2	tidak sedap	\N	まずそう	\N
3318	606	3211	1	tidak sedap	\N	まずい	\N
4521	611	3725	2	lurus/terus	\N	まっすぐ	\N
4520	611	3724	1	lurus/terus	\N	まっすぐ	\N
4060	612	3643	1	mancis	\N	マッチ	\N
4059	612	3642	2	mancis	\N	マッチ	\N
3987	614	3590	1	bulat	\N	丸い	\N
3986	614	3589	2	bulat	\N	丸い	\N
3353	617	3233	1	menggosok (gosok)	\N	磨きます	\N
2598	619	2870	2	péndék	\N	短く	\N
2449	620	2823	1	air	\N	水	\N
3939	624	3543	1	tiga hari bulan	\N	三日	\N
3930	625	3534	1	tiga	\N	三つ	\N
3388	626	3241	1	hijau	\N	緑	\N
3345	629	3225	1	telinga	\N	耳	\N
3943	632	3547	1	enam hari bulan	\N	六日	\N
4388	633	3804	2	sana/sebalik	\N	向こう	\N
4389	633	3805	1	sana/sebalik	\N	向こう	\N
3933	635	3537	1	enam buah	\N	六つ	\N
4069	636	3650	2	kampung	\N	村	\N
4070	636	3651	1	kampung	\N	村	\N
3344	637	3223	1	mata/penglihatan	\N	目	\N
3343	637	3224	1	mata/penglihatan	\N	目	0
2330	639	2788	1	cermin mata	\N	眼鏡	\N
3741	641	3412	1	hari Khamis	\N	木曜日	\N
4189	644	3738	2	lebih	\N	もっと	\N
4190	644	3739	1	lebih	\N	もっと	\N
4013	645	3612	1	benda	\N	物	\N
4012	645	3611	2	benda	\N	物	\N
4433	648	3844	1	kedai	\N	屋	\N
4434	648	3845	2	kedai	\N	屋	\N
2793	649	2952	1	gerai sayur	\N	八百屋	\N
2792	649	2951	2	gerai sayur	\N	八百屋	\N
2800	650	2959	2	sayur	\N	野菜	\N
2801	650	2960	1	sayur	\N	野菜	\N
2569	651	2861	1	mudah	\N	易しかった	\N
3935	655	3539	1	lapan buah	\N	八つ	\N
3795	658	3450	2	petang	\N	夕方	\N
3796	658	3451	1	petang	\N	夕方	\N
47	660	2756	1	pejabat pos	\N	郵便局	\N
3769	661	3431	2	malam tadi	\N	ゆうべ	\N
3770	661	3432	1	malam tadi	\N	ゆうべ	\N
4009	662	3608	1	terkenal	\N	有名	\N
4008	662	3607	2	terkenal	\N	有名な	\N
2987	663	2068	2	salji	\N	雪	\N
2986	663	3051	1	salji	\N	雪	\N
4624	664	3736	2	perlahan-lahan	0	ゆっくり	0
4623	664	3737	1	perlahan-lahan	0	ゆっくり	0
3942	665	3546	1	lapan hari bulan	\N	八日	\N
3283	666	3186	1	pakaian Barat	\N	洋服	\N
3940	669	3544	1	empat hari bulan	\N	四日	\N
4527	671	3388	1	memanggil (panggil)	\N	呼びました	\N
3144	674	3124	1	lemah	\N	弱い	\N
2275	678	2771	1	radio	\N	ラジオ	\N
2276	679	2772	1	pemain radio kasét	\N	ラジカセ	\N
3412	682	3262	1	ibu bapa	\N	両親	\N
3302	685	2935	1	melancong	\N	旅行しよう	\N
4546	686	3882	1	sifar	\N	零	\N
2273	687	2769	1	peti sejuk	\N	冷蔵庫	\N
2568	691	2860	1	berlatih	\N	練習すれば	\N
2509	692	2844	1	koridor	\N	廊下	\N
4553	693	3889	1	enam	\N	六	\N
3304	755	1728	2	bekal	\N	お弁当	\N
3305	755	1556	3	bekal	\N	お弁当	\N
2703	718	2919	1	berjalan-jalan (jalan-jalan)	\N	散歩します	\N
3433	709	3281	1	orang	\N	人	\N
2284	719	2775	1	pejabat hartanah	\N	不動産屋	\N
2438	720	2817	1	pinggan	\N	お皿	\N
2430	721	2811	1	arak	\N	お酒	\N
2579	722	2865	1	salon kecantikan	\N	美容院	\N
4606	723	3113	2	ください (1)	0	ください	0
4605	723	3112	1	ください (1)	0	ください	0
4440	726	3849	2	lain	\N	ほか	\N
4439	726	3848	1	lain	\N	ほか	\N
2806	729	1418	2	mahal	\N	高かった	\N
2805	729	2962	1	mahal	\N	高い	\N
4148	730	3714	2	sangat	\N	大変	\N
4149	730	3715	1	sangat	\N	大変	\N
4191	733	3740	2	baik	\N	よく	\N
4192	733	3741	1	baik	\N	よく	\N
4594	735	3913	3	empat	0	四	\N
4593	735	3914	2	empat	0	\N	\N
4551	735	3887	1	empat	\N	四	\N
4595	737	3890	2	tujuh	0	七	\N
4587	737	3915	1	tujuh	\N	七	\N
4599	738	3892	2	sembilan	0	九	\N
4597	738	3916	1	sembilan	0	九	\N
3977	742	3580	1	kilométer	\N	キロ	\N
3976	742	3579	2	kilométer	\N	キロメートル	\N
2073	743	2216	1	～人	\N	～人	\N
2074	743	2231	2	～人	\N	～人	\N
2075	743	2224	3	～人	\N	～人	\N
3971	744	3574	3	batang	\N	本	\N
3972	744	3575	2	batang	\N	本	\N
3973	744	3576	1	batang	\N	本	\N
4432	745	3822	1	sebelum/lepas	\N	前	\N
4431	745	3843	2	sebelum/lepas	\N	前	\N
3813	746	3463	2	jam	\N	時間	\N
3814	746	3464	1	jam	\N	時間	\N
3446	748	1334	1	pukul	\N	時	1
3447	748	1333	2	pukul	\N	時	\N
3628	753	3355	1	menéléfon	\N	かけます	\N
3627	753	3354	2	menéléfon	\N	かけました	\N
3275	756	3181	1	ayat	\N	文	\N
2257	758	1449	1	tekak	\N	のど	\N
3107	760	1398	2	membuat (buat) 	\N	します	\N
3106	760	2986	1	membuat (buat) 	\N	しませんでした	\N
2901	761	3003	1	ひきます	\N	ひいた	\N
3039	762	3071	2	tukang gunting	\N	美容師	\N
3038	762	3070	1	tukang gunting	\N	美容師	\N
4055	763	3639	1	bersyampu/syampu	\N	シャンプー	\N
4056	763	3056	2	bersyampu/syampu	\N	シャンプー	\N
3000	765	3059	1	pekerja stésén	\N	駅員	\N
3060	767	3077	1	nombor téléfon	\N	電話番号	\N
3063	769	3080	2	hubungi	\N	連絡して	\N
3064	769	3081	1	hubungi	\N	連絡します	\N
3065	770	3082	2	見つかります	\N	見つかりました	\N
3066	770	3083	1	見つかります	\N	見つかります	\N
3059	771	3076	1	mendengar (dengar)	\N	聞きます	\N
3067	772	3084	1	séwa rumah	\N	家賃	\N
3075	773	3086	2	mencari (cari)	\N	探そう	\N
3074	773	3087	1	mencari (cari)	\N	探しました	\N
3082	775	3091	1	menu sét	\N	定食	\N
3083	775	3092	2	menu sét	\N	定食	\N
3087	776	3096	1	susu	\N	ミルク	\N
3086	776	3095	2	susu	\N	ミルク	\N
3092	780	3097	1	bahagian	\N	売り場	\N
3099	782	3101	1	郵便局員	\N	郵便局員	\N
3101	783	3103	1	melalui udara	\N	航空便	\N
3100	784	3102	1	melalui laut	\N	船便	\N
3103	785	3105	2	mengirim (kirim)	\N	送った	\N
3104	785	3104	1	mengirim (kirim)	\N	送りました	\N
3110	786	3106	2	sut	\N	スーツ	\N
3111	786	3107	1	sut	\N	スーツ	\N
3118	787	3110	1	pekerja syarikat	\N	会社員	\N
3126	789	3116	1	penyepit	\N	おはし	\N
3192	792	3137	1	pegawai bank	\N	銀行員	\N
3193	793	3138	2	kaunter	\N	窓口	\N
3194	793	3139	1	kaunter	\N	窓口	\N
3195	794	3140	1	pemindahan	\N	振り込み	\N
3927	798	3530	2	léwat	\N	遅く	\N
3926	798	3531	1	léwat	\N	遅い	\N
3656	799	3367	1	siap	\N	できました	\N
3237	800	3163	1	memakai (pakai) 	\N	します	\N
3705	801	3389	1	beréhat (réhat)	\N	休みました	\N
4369	802	3794	1	ください (2)	\N	ください	\N
4368	802	3793	2	ください (2)	\N	ください	\N
3308	803	3201	1	membubuh (bubuh)	\N	つけないで	\N
3878	804	3501	2	singkat	\N	短い	\N
3879	804	3502	1	singkat	\N	短い	\N
3874	805	3498	1	panjang	\N	長かった	\N
3875	805	3497	2	panjang	\N	長い	\N
3227	808	3154	2	pemandu pelancong	\N	ガイド	\N
3228	808	3155	1	pemandu pelancong	\N	ガイド	\N
3229	809	3156	2	bermalam	\N	泊まりました	\N
3230	809	3157	1	bermalam	\N	泊まります	\N
3231	810	3158	2	cenderamata	\N	お土産	\N
3232	810	3159	1	cenderamata	\N	お土産	\N
3964	813	3567	1	～人	\N	人	\N
3963	813	3566	2	～人	\N	人	\N
3418	814	3268	1	suami	\N	ご主人	\N
3419	815	3269	1	adik perempuan	\N	妹さん	\N
3420	816	3270	1	adik lelaki	\N	弟さん	\N
3601	817	3341	1	membuka (buka)	\N	入れます	\N
3602	817	3340	2	membuka (buka)	\N	入れて	\N
3821	818	3358	1	menutup (tutup)	\N	切ります	\N
3638	819	1638	2	datang	\N	来ました	\N
3637	819	2232	1	datang	\N	来ませんでした	\N
13	205	2751	1	ubat	\N	薬	\N
16	291	2753	1	mati	\N	死にました	\N
3639	819	2220	3	datang	\N	来ました	\N
4073	820	3654	2	negara asal	\N	国	\N
4074	820	3655	1	negara asal	\N	国	\N
4130	821	3469	1	nanti	\N	あとで	\N
4129	821	3701	2	nanti	\N	あとで	\N
4243	822	1492	3	apa	\N	何	\N
4242	822	1860	2	apa	\N	何	\N
4241	822	3751	1	apa	\N	何	\N
4490	824	3866	2	berhenti (henti)	\N	やめた	\N
4491	824	3867	1	berhenti (henti)	\N	やめました	\N
4493	825	3869	1	dapat	\N	もらいました	\N
4492	825	3868	2	dapat	\N	もらった	\N
4477	826	3859	1	bimbang	\N	心配して	\N
4476	826	3858	2	bimbang	\N	心配しないで	\N
4489	827	3865	1	téléfon bimbit	\N	携帯電話	\N
4488	827	3864	2	téléfon bimbit	\N	携帯電話	\N
4498	833	3871	1	memberi (beri)	\N	あげます	\N
4499	833	3870	2	memberi (beri)	\N	あげました	\N
4518	835	3705	1	pelbagai	\N	いろいろ	\N
4526	836	3387	1	memanggil (panggil)	\N	呼びます	\N
4619	840	3906	1	berlainan/lawan	0	反対	0
4620	840	3905	2	berlainan/lawan	0	反対	0
4575	842	3908	1	bunyi	\N	音	\N
4576	843	3909	1	kumpulan	\N	グループ	\N
4183	640	3732	2	sudah	\N	もう	\N
4548	53	3884	1	se-	\N	一	\N
4642	844	3892	1	sembilan	0	九	0
4643	844	3916	2	sembilan	0	九	0
4640	837	3900	1	berterusan	0	続きました	0
4641	837	3899	2	berterusan	0	続いて	0
4638	838	3902	1	menyémak (sémak)	0	確認します	0
4639	838	3901	2	menyémak (sémak)	0	確認します	0
4636	839	3904	1	rasa	0	思います	0
4637	839	3903	2	rasa	0	思います	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
569	208	usage_208_0.jpg		\N
570	208	usage_208_1.jpg		\N
571	209	usage_209_0.jpg		\N
572	209	usage_209_1.jpg		\N
573	207	usage_207_0.jpg		\N
574	207	usage_207_1.jpg		\N
575	218	usage_218_0.jpg		\N
576	219	usage_219_0.jpg		\N
580	236	usage_236_0.jpg		\N
581	236	usage_236_1.jpg		\N
582	237	usage_237_0.jpg		\N
583	237	usage_237_1.jpg		\N
584	828	usage_828_0.jpg		\N
585	246	usage_246_0.jpg		\N
586	251	usage_251_0.jpg		\N
587	823	usage_823_0.jpg		\N
588	240	usage_240_0.jpg		\N
589	736	usage_736_0.jpg		\N
590	233	usage_233_0.jpg		\N
594	777	usage_777_0.jpg		\N
595	777	usage_777_1.jpg		\N
596	777	usage_777_2.jpg		\N
597	264	usage_264_0.jpg		\N
598	263	usage_263_0.jpg		\N
599	267	usage_267_0.jpg		\N
600	734	usage_734_0.jpg		\N
601	271	usage_271_0.jpg		\N
602	333	usage_333_0.jpg		\N
603	333	usage_333_1.jpg		\N
604	334	usage_334_0.jpg		\N
605	337	usage_337_0.jpg		\N
606	338	usage_338_0.jpg		\N
607	343	usage_343_0.jpg		\N
608	355	usage_355_0.jpg		\N
609	355	usage_355_1.jpg		\N
610	834	usage_834_0.jpg		\N
611	786	usage_786_0.jpg		\N
612	315	usage_315_0.jpg		\N
613	315	usage_315_1.jpg		\N
614	323	usage_323_0.jpg		\N
615	324	usage_324_0.jpg		\N
616	324	usage_324_1.jpg		\N
617	326	usage_326_0.jpg		\N
618	328	usage_328_0.jpg		\N
622	313	usage_313_0.jpg		\N
623	298	usage_298_0.jpg		\N
624	299	usage_299_0.jpg		\N
625	306	usage_306_0.jpg		\N
626	278	usage_278_0.jpg		\N
627	289	usage_289_0.jpg		\N
628	287	usage_287_0.jpg		\N
629	300	usage_300_0.jpg		\N
630	312	usage_312_0.jpg		\N
631	309	usage_309_0.jpg		\N
632	310	usage_310_0.jpg		\N
633	781	usage_781_0.jpg		\N
634	781	usage_781_1.jpg		\N
635	145	usage_145_0.jpg		\N
636	145	usage_145_1.jpg		\N
637	156	usage_156_0.jpg		\N
638	156	usage_156_1.jpg		\N
639	159	usage_159_0.jpg		\N
640	159	usage_159_1.jpg		\N
641	162	usage_162_0.jpg		\N
642	162	usage_162_1.jpg		\N
643	166	usage_166_0.jpg		\N
644	166	usage_166_1.jpg		\N
645	173	usage_173_0.jpg		\N
509	3	usage_3_0.jpg		\N
510	4	usage_4_0.jpg		\N
511	5	usage_5_0.jpg		\N
512	6	usage_6_0.jpg		\N
513	36	usage_36_0.jpg		\N
514	36	usage_36_1.jpg		\N
515	15	usage_15_0.jpg		\N
516	20	usage_20_0.jpg		\N
517	38	usage_38_0.jpg		\N
518	38	usage_38_1.jpg		\N
526	53	usage_53_0.jpg		\N
527	43	usage_43_0.jpg		\N
528	61	usage_61_0.jpg		\N
529	61	usage_61_1.jpg		\N
530	57	usage_57_0.jpg		\N
531	48	usage_48_0.jpg		\N
532	68	usage_68_0.jpg		\N
533	76	usage_76_0.jpg		\N
534	78	usage_78_0.jpg		\N
535	78	usage_78_1.jpg		\N
536	81	usage_81_0.jpg		\N
537	81	usage_81_1.jpg		\N
538	88	usage_88_0.jpg		\N
539	90	usage_90_0.jpg		\N
540	90	usage_90_1.jpg		\N
541	104	usage_104_0.jpg		\N
542	104	usage_104_1.jpg		\N
543	117	usage_117_0.jpg		\N
544	122	usage_122_0.jpg		\N
545	122	usage_122_1.jpg		\N
546	123	usage_123_0.jpg		\N
547	789	usage_789_0.jpg		\N
548	98	usage_98_0.jpg		\N
549	99	usage_99_0.jpg		\N
550	720	usage_720_0.jpg		\N
551	720	usage_720_1.jpg		\N
552	109	usage_109_0.jpg		\N
553	721	usage_721_0.jpg		\N
554	721	usage_721_1.jpg		\N
555	721	usage_721_2.jpg		\N
556	108	usage_108_0.jpg		\N
557	755	usage_755_0.jpg		\N
558	128	usage_128_0.jpg		\N
559	128	usage_128_1.jpg		\N
560	829	usage_829_0.jpg		\N
561	829	usage_829_1.jpg		\N
562	827	usage_827_0.jpg		\N
563	827	usage_827_1.jpg		\N
564	225	usage_225_0.jpg		\N
565	226	usage_226_0.jpg		\N
566	227	usage_227_0.jpg		\N
567	206	usage_206_0.jpg		\N
568	738	usage_738_0.jpg		\N
646	174	usage_174_0.jpg		\N
647	167	usage_167_0.jpg		\N
648	163	usage_163_0.jpg		\N
649	163	usage_163_1.jpg		\N
653	138	usage_138_0.jpg		\N
654	178	usage_178_0.jpg		\N
655	178	usage_178_1.jpg		\N
656	143	usage_143_0.jpg		\N
657	151	usage_151_0.jpg		\N
661	146	usage_146_0.jpg		\N
662	175	usage_175_0.jpg		\N
663	175	usage_175_1.jpg		\N
664	169	usage_169_0.jpg		\N
665	830	usage_830_0.jpg		\N
666	830	usage_830_1.jpg		\N
667	185	usage_185_0.jpg		\N
668	185	usage_185_1.jpg		\N
669	180	usage_180_0.jpg		\N
670	181	usage_181_0.jpg		\N
671	192	usage_192_0.jpg		\N
672	203	usage_203_0.jpg		\N
673	844	usage_844_0.jpg		\N
674	188	usage_188_0.jpg		\N
675	179	usage_179_0.jpg		\N
676	179	usage_179_1.jpg		\N
677	184	usage_184_0.jpg		\N
678	771	usage_771_0.jpg		\N
679	400	usage_400_0.jpg		\N
680	405	usage_405_0.jpg		\N
681	396	usage_396_0.jpg		\N
682	396	usage_396_1.jpg		\N
683	393	usage_393_0.jpg		\N
684	395	usage_395_0.jpg		\N
685	413	usage_413_0.jpg		\N
686	414	usage_414_0.jpg		\N
687	414	usage_414_1.jpg		\N
688	779	usage_779_0.jpg		\N
689	779	usage_779_1.jpg		\N
693	429	usage_429_0.jpg		\N
694	430	usage_430_0.jpg		\N
695	369	usage_369_0.jpg		\N
696	378	usage_378_0.jpg		\N
697	381	usage_381_0.jpg		\N
698	381	usage_381_1.jpg		\N
699	365	usage_365_0.jpg		\N
700	365	usage_365_1.jpg		\N
701	382	usage_382_0.jpg		\N
702	382	usage_382_1.jpg		\N
703	461	usage_461_0.jpg		\N
704	434	usage_434_0.jpg		\N
705	433	usage_433_0.jpg		\N
706	433	usage_433_1.jpg		\N
712	442	usage_442_0.jpg		\N
713	460	usage_460_0.jpg		\N
714	460	usage_460_1.jpg		\N
715	456	usage_456_0.jpg		\N
716	456	usage_456_1.jpg		\N
717	445	usage_445_0.jpg		\N
718	445	usage_445_1.jpg		\N
719	431	usage_431_0.jpg		\N
720	459	usage_459_0.jpg		\N
721	693	usage_693_0.jpg		\N
722	686	usage_686_0.jpg		\N
723	687	usage_687_0.jpg		\N
724	687	usage_687_1.jpg		\N
728	683	usage_683_0.jpg		\N
729	683	usage_683_1.jpg		\N
730	683	usage_683_2.jpg		\N
731	735	usage_735_0.jpg		\N
732	669	usage_669_0.jpg		\N
733	672	usage_672_0.jpg		\N
734	665	usage_665_0.jpg		\N
738	650	usage_650_0.jpg		\N
739	650	usage_650_1.jpg		\N
740	778	usage_778_0.jpg		\N
741	778	usage_778_1.jpg		\N
742	656	usage_656_0.jpg		\N
743	646	usage_646_0.jpg		\N
744	641	usage_641_0.jpg		\N
748	639	usage_639_0.jpg		\N
749	639	usage_639_1.jpg		\N
750	637	usage_637_0.jpg		\N
751	637	usage_637_1.jpg		\N
752	632	usage_632_0.jpg		\N
753	776	usage_776_0.jpg		\N
754	624	usage_624_0.jpg		\N
755	629	usage_629_0.jpg		\N
756	620	usage_620_0.jpg		\N
757	620	usage_620_1.jpg		\N
758	623	usage_623_0.jpg		\N
759	623	usage_623_1.jpg		\N
760	628	usage_628_0.jpg		\N
763	626	usage_626_0.jpg		\N
764	615	usage_615_0.jpg		\N
768	612	usage_612_0.jpg		\N
769	497	usage_497_0.jpg		\N
770	496	usage_496_0.jpg		\N
771	496	usage_496_1.jpg		\N
774	500	usage_500_0.jpg		\N
775	500	usage_500_1.jpg		\N
776	489	usage_489_0.jpg		\N
777	484	usage_484_0.jpg		\N
778	492	usage_492_0.jpg		\N
779	492	usage_492_1.jpg		\N
780	487	usage_487_0.jpg		\N
781	466	usage_466_0.jpg		\N
782	470	usage_470_0.jpg		\N
783	737	usage_737_0.jpg		\N
784	478	usage_478_0.jpg		\N
785	595	usage_595_0.jpg		\N
786	594	usage_594_0.jpg		\N
787	585	usage_585_0.jpg		\N
788	585	usage_585_1.jpg		\N
789	585	usage_585_2.jpg		\N
790	589	usage_589_0.jpg		\N
791	586	usage_586_0.jpg		\N
792	586	usage_586_1.jpg		\N
793	577	usage_577_0.jpg		\N
794	577	usage_577_1.jpg		\N
795	579	usage_579_0.jpg		\N
796	579	usage_579_1.jpg		\N
797	575	usage_575_0.jpg		\N
798	759	usage_759_0.jpg		\N
799	553	usage_553_0.jpg		\N
800	553	usage_553_1.jpg		\N
801	541	usage_541_0.jpg		\N
802	541	usage_541_1.jpg		\N
803	539	usage_539_0.jpg		\N
804	543	usage_543_0.jpg		\N
805	543	usage_543_1.jpg		\N
806	550	usage_550_0.jpg		\N
807	551	usage_551_0.jpg		\N
808	551	usage_551_1.jpg		\N
809	557	usage_557_0.jpg		\N
810	559	usage_559_0.jpg		\N
811	559	usage_559_1.jpg		\N
812	560	usage_560_0.jpg		\N
813	560	usage_560_1.jpg		\N
814	563	usage_563_0.jpg		\N
815	565	usage_565_0.jpg		\N
816	558	usage_558_0.jpg		\N
817	558	usage_558_1.jpg		\N
818	558	usage_558_2.jpg		\N
819	510	usage_510_0.jpg		\N
820	518	usage_518_0.jpg		\N
821	807	usage_807_0.jpg		\N
822	534	usage_534_0.jpg		\N
823	534	usage_534_1.jpg		\N
824	535	usage_535_0.jpg		\N
825	725	usage_725_0.jpg		\N
826	725	usage_725_1.jpg		\N
827	508	usage_508_0.jpg		\N
828	717	usage_717_0.jpg		\N
829	717	usage_717_1.jpg		\N
830	505	usage_505_0.jpg		\N
834	521	usage_521_0.jpg		\N
835	521	usage_521_1.jpg		\N
836	523	usage_523_0.jpg		\N
839	512	usage_512_0.jpg		\N
840	512	usage_512_1.jpg		\N
841	522	usage_522_0.jpg		\N
842	524	usage_524_0.jpg		\N
843	205	usage_205_0.jpg		\N
844	205	usage_205_1.jpg		\N
845	663	usage_663_0.jpg		\N
846	663	usage_663_1.jpg		\N
847	613	usage_613_0.jpg		\N
848	613	usage_613_1.jpg		\N
849	412	usage_412_0.jpg		\N
850	412	usage_412_1.jpg		\N
851	165	usage_165_0.jpg		\N
852	165	usage_165_1.jpg		\N
853	50	usage_50_0.jpg		\N
854	50	usage_50_1.jpg		\N
855	438	usage_438_0.jpg		\N
856	438	usage_438_1.jpg		\N
857	438	usage_438_2.jpg		\N
858	438	usage_438_3.jpg		\N
859	787	usage_787_0.jpg		\N
860	787	usage_787_1.jpg		\N
861	617	usage_617_0.jpg		\N
862	517	usage_517_0.jpg		\N
863	517	usage_517_1.jpg		\N
864	330	usage_330_0.jpg		\N
865	330	usage_330_1.jpg		\N
866	342	usage_342_0.jpg		\N
867	193	usage_193_0.jpg		\N
868	290	usage_290_0.jpg		\N
869	31	usage_31_0.jpg		\N
870	503	usage_503_0.jpg		\N
871	643	usage_643_0.jpg		\N
872	643	usage_643_1.jpg		\N
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_usage_scene_rel (usage_id, scene_id) FROM stdin;
3	39
4	39
5	39
6	39
7	22
9	14
12	34
13	28
14	33
15	27
16	33
17	21
18	11
19	36
20	13
20	27
21	20
22	21
23	22
24	21
26	21
27	25
28	25
30	20
31	7
32	9
33	28
36	27
38	3
39	21
40	23
42	37
43	7
46	6
47	6
49	13
50	29
51	4
52	13
54	33
62	34
63	37
64	25
65	23
66	14
68	15
69	39
71	24
72	10
72	24
73	22
74	35
75	35
76	7
80	23
81	26
82	35
83	35
85	37
87	14
88	14
89	17
90	29
92	28
93	23
94	22
97	25
98	28
99	17
100	8
102	25
103	38
104	38
105	12
107	2
108	15
109	14
110	25
111	25
112	38
113	38
114	33
115	32
116	38
117	13
117	27
119	25
120	25
121	38
122	38
123	20
125	9
126	22
127	23
128	2
129	14
131	35
132	38
133	38
135	1
136	1
137	4
138	14
139	1
140	19
141	5
141	17
142	7
143	27
145	7
146	37
147	11
148	30
150	26
151	19
152	5
152	17
153	13
154	25
155	17
155	38
156	37
157	30
158	11
159	15
160	7
161	24
162	19
163	8
164	26
166	35
167	31
168	28
169	27
170	5
170	17
172	22
173	16
174	8
175	3
176	24
178	37
180	39
181	39
183	9
184	24
185	35
187	15
188	18
189	14
190	33
192	6
193	15
194	33
195	11
196	25
197	32
198	35
199	10
200	8
202	17
203	31
205	13
206	6
207	27
208	19
209	19
210	1
211	36
212	36
214	11
217	3
218	39
219	39
220	9
221	33
222	8
226	31
227	20
230	37
231	3
232	3
233	15
234	9
236	26
237	15
238	21
239	34
242	34
243	12
244	21
245	21
246	15
247	32
248	37
249	38
251	16
252	5
253	5
255	21
257	30
258	31
260	33
263	19
264	6
265	34
267	12
268	16
270	5
271	5
272	15
273	36
274	16
275	32
276	38
277	3
280	28
282	34
283	4
284	5
285	23
286	24
288	12
289	3
290	3
291	13
293	21
294	14
297	35
298	4
299	7
301	31
302	12
303	12
304	2
306	28
307	16
309	39
310	39
312	5
313	31
314	4
315	26
316	23
316	35
319	23
321	36
323	29
324	16
325	2
326	26
327	20
328	26
329	4
330	10
332	11
333	26
335	4
336	20
339	30
340	31
341	11
341	12
342	7
343	7
346	8
347	8
349	21
350	21
351	21
352	24
354	24
356	21
360	11
361	1
363	23
365	20
367	22
369	3
371	18
375	20
376	23
378	4
380	16
381	16
387	22
389	20
392	14
393	9
394	25
395	39
396	28
397	34
401	19
401	29
402	27
403	34
404	18
405	29
406	29
407	8
408	4
409	23
410	22
411	2
412	27
413	29
414	29
415	29
416	7
417	18
418	2
419	19
420	14
421	12
423	19
426	29
427	36
428	8
429	14
432	13
432	36
433	8
433	14
434	14
441	20
445	8
448	32
449	5
454	24
458	11
459	31
461	6
462	35
466	16
467	24
468	10
471	9
474	11
479	9
479	17
485	23
486	6
487	24
488	33
489	31
490	18
492	7
494	26
496	4
496	26
498	8
499	32
500	12
502	15
503	15
504	14
505	13
505	27
508	16
510	18
511	26
513	16
517	2
518	3
519	28
521	4
524	27
525	37
526	37
527	25
528	23
529	18
530	36
531	36
533	17
534	16
536	17
537	28
539	24
541	35
542	22
543	1
544	10
545	38
547	30
551	13
552	13
553	37
554	34
555	28
556	20
558	18
559	2
560	16
561	19
563	6
566	22
568	36
569	20
570	20
571	34
572	37
574	2
575	29
577	8
579	29
580	11
581	11
582	28
585	19
585	26
586	29
589	18
591	22
593	1
594	5
595	5
597	18
598	33
599	31
600	30
601	32
602	33
603	33
604	10
604	24
605	9
606	28
613	8
616	29
617	27
618	10
619	10
620	15
621	6
623	3
626	39
628	24
629	27
630	35
634	12
637	27
639	19
639	26
641	31
646	7
647	12
649	6
650	6
651	12
652	6
653	4
654	4
657	4
658	34
659	28
660	18
661	33
663	36
666	26
668	10
672	5
673	34
674	2
675	30
676	31
677	32
678	29
679	29
681	11
682	25
683	7
684	1
685	1
687	29
688	35
689	16
690	12
691	12
692	11
694	4
698	21
701	3
702	23
704	19
705	26
706	22
707	22
708	34
709	38
710	36
711	36
712	36
713	36
714	21
715	1
716	2
717	3
718	3
719	20
720	16
721	16
722	10
723	6
728	24
729	6
746	34
748	34
754	24
755	28
756	37
757	13
758	13
758	27
759	35
760	4
761	13
762	10
763	10
764	10
765	14
766	12
767	9
768	9
769	9
770	9
771	35
772	20
773	20
774	15
774	16
774	19
775	16
776	15
777	2
778	2
779	2
780	19
781	19
782	18
783	18
784	18
785	18
786	4
787	4
788	6
789	16
790	2
791	8
792	17
793	17
794	17
795	17
796	17
797	36
798	23
800	26
803	28
804	22
805	22
806	1
807	1
808	1
809	1
810	1
811	37
812	37
814	25
815	25
816	25
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
657	buku nota	1	b	\N
659	lagi	1	l	\N
661	bilik	1	b	\N
663	rumah	1	r	\N
664	bilik darjah	1	b	\N
666	soalan	1	s	\N
667	wang	1	w	\N
670	atas	1	a	\N
671	bawah	1	b	\N
672	depan	1	d	\N
675	dalam	1	d	\N
676	luar	1	l	\N
677	kanan	1	k	\N
678	kiri	1	k	\N
679	bég	1	b	\N
681	kucing	1	k	\N
682	peti surat	1	p	\N
685	utara	1	u	\N
686	dekat	1	d	\N
688	kolam renang	1	k	\N
693	tingkat	1	t	\N
694	surat khabar	1	s	\N
696	musim luruh	1	m	\N
699	orang	1	o	\N
701	baru	1	b	\N
702	komputer	1	k	\N
703	kotak	1	k	\N
704	kecil	1	k	\N
705	sihat/ceria	1	s	\N
707	lukisan/melukis	1	l	\N
710	makanan	1	m	\N
713	lama	1	l	\N
716	senyap	1	s	\N
717	kasut	1	k	\N
719	beli	1	b	\N
720	hitam	1	h	\N
722	kamus	1	k	\N
726	cantik/bersih	1	c	\N
727	perempuan	1	p	\N
729	besar	1	b	\N
731	tandas	1	t	\N
734	awak	1	a	\N
738	kék	1	k	\N
740	pén mata bulat	1	p	\N
741	yén	1	y	\N
742	buah	1	b	\N
743	majalah	1	m	\N
745	berapa	1	b	\N
746	sapu tangan	1	s	\N
747	helai/keping	1	h	\N
753	minit	1	m	\N
758	hari Ahad	1	h	\N
759	belajar	1	b	\N
762	piano	1	p	\N
767	tidak hadir	1	t	\N
772	pintu pagar	1	p	\N
774	turun	1	t	\N
775	habis	1	h	\N
777	masih	1	m	\N
778	rumah	1	r	\N
781	air coca-cola	1	a	\N
782	minum/makan	1	m	\N
784	téngok	1	t	\N
785	surat	1	s	\N
786	hantar/memberi (beri)	1	h	\N
787	meminjamkan 	1	m	\N
788	meminjam (pinjam)	1	m	\N
790	belajar	1	b	\N
791	dinding	1	d	\N
794	letak	1	l	\N
795	menunjukkan	1	m	\N
796	ténis	1	t	\N
799	sejuk	1	s	\N
800	kelakar/menarik	1	k	\N
801	sedap	1	s	\N
802	mérah	1	m	\N
803	tinggi	1	t	\N
806	tidak begitu	1	t	\N
807	luas	1	l	\N
812	baju	1	b	\N
814	rambut	1	r	\N
815	ketinggian	1	k	\N
817	kuat	1	k	\N
818	sakit	1	s	\N
819	bandar	1	b	\N
820	jalan	1	j	\N
821	sempit	1	s	\N
822	warna	1	w	\N
825	lagu	1	l	\N
829	ayah	1	a	\N
831	bekerja	1	b	\N
832	doktor	1	d	\N
834	mudah diguna/berguna	1	m	\N
836	baca	1	b	\N
839	berdiri	1	b	\N
840	tingkap	1	t	\N
841	buka	1	b	\N
842	setiap pagi	1	s	\N
844	tahun	1	t	\N
845	tahu	1	t	\N
846	berliku-liku/bélok	1	b	\N
851	membeli-belah	1	m	\N
852	tutup	1	t	\N
853	lampu	1	l	\N
854	memadamkan (padam)	1	m	\N
855	stésén	1	s	\N
858	soalan	1	s	\N
859	muka surat	1	m	\N
860	menulis (tulis) 	1	m	\N
861	memotong (potong) 	1	m	\N
863	buka	1	b	\N
865	bercakap (cakap) 	1	b	\N
867	roti	1	r	\N
869	hari Isnin	1	h	\N
870	bola sépak	1	b	\N
874	pusat membeli-belah	1	p	\N
875	pasar raya	1	p	\N
877	telur	1	t	\N
878	katil	1	k	\N
879	flat	1	f	\N
880	tinggal	1	t	\N
881	pelajar antarabangsa	1	p	\N
886	muda	1	m	\N
889	stoking	1	s	\N
892	susah	1	s	\N
893	boléh	1	b	\N
895	berenang	1	b	\N
897	adik lelaki	1	a	\N
898	kapal terbang	1	k	\N
903	berjumpa	1	b	\N
905	konsert	1	k	\N
908	bangun	1	b	\N
909	kantin	1	k	\N
915	duduk	1	d	\N
917	berjalan kaki	1	b	\N
918	pita	1	p	\N
920	laut	1	l	\N
922	gunung	1	g	\N
923	mendaki	1	m	\N
924	bésbol	1	b	\N
925	perlawanan	1	p	\N
926	taufan	1	t	\N
927	keréta api	1	k	\N
928	berhenti	1	b	\N
929	halaman rumah	1	h	\N
931	muka	1	m	\N
932	membasuh (basuh) 	1	m	\N
937	ujian	1	u	\N
938	langit	1	l	\N
939	biru	1	b	\N
941	seronok	1	s	\N
944	berlari (lari) 	1	b	\N
946	gambar	1	g	\N
952	naik	1	n	\N
959	emak	1	e	\N
962	seluar	1	s	\N
964	kali	1	k	\N
969	mekar	1	m	\N
970	tahun ini	1	t	\N
972	keméja	1	k	\N
974	huruf	1	h	\N
978	karaoké	1	k	\N
979	menyanyi (nyanyi) 	1	m	\N
980	suara	1	s	\N
981	selatan	1	s	\N
982	terbang	1	t	\N
993	masuk	1	m	\N
1002	bas	1	b	\N
1003	sakit	1	s	\N
1007	seorang	1	s	\N
1008	keluarga	1	k	\N
1012	pandai	1	p	\N
1013	puluh ribu	1	p	\N
1016	sekelas	1	s	\N
1018	membuat (buat) 	1	m	\N
1019	berbeza	1	b	\N
1020	semasa/apabila	1	s	\N
1024	peta	1	p	\N
1026	mérah	1	m	\N
1030	tangan	1	t	\N
1032	nama	1	n	\N
1037	menunggu (tunggu) 	1	m	\N
1045	merokok	1	m	\N
1048	tidak boléh	1	t	\N
1053	suis	1	s	\N
1063	petang/malam	1	p	\N
1065	biru	1	b	\N
1066	entahlah/baiklah	1	e	\N
1067	lintas	1	l	\N
1074	membersihkan  	1	m	\N
1075	bagasi	1	b	\N
1076	bawa	1	b	\N
1079	barat	1	b	\N
1082	awal	1	a	\N
1085	malam ini	1	m	\N
1088	semua	1	s	\N
1093	basikal	1	b	\N
1094	putih	1	p	\N
1095	kertas	1	k	\N
1099	sukan	1	s	\N
1107	selalu	1	s	\N
1109	méter	1	m	\N
1111	bahasa	1	b	\N
1118	cerah	1	c	\N
1121	mungkin	1	m	\N
1123	pekerja	1	p	\N
1137	jam	1	j	\N
1139	adik perempuan	1	a	\N
1154	manis	1	m	\N
1156	burung	1	b	\N
1162	bulan depan	1	b	\N
1163	pelajar	1	p	\N
1164	cuaca	1	c	\N
1170	ambil	1	a	\N
1174	karangan	1	k	\N
1177	kopi	1	k	\N
1178	téｈ	1	t	\N
1185	kaméra	1	k	\N
1189	nombor	1	n	\N
1193	tutup	1	t	\N
1199	ingat/hafal	1	i	\N
1200	perut	1	p	\N
1203	malam	1	m	\N
1208	dekat	1	d	\N
1211	tekan	1	t	\N
1212	pintu	1	p	\N
1218	terus/sekejap lagi	1	t	\N
1220	dekat	1	d	\N
1221	tidak suka/tidak sedap	1	t	\N
1227	banyak	1	b	\N
1242	beri	1	b	\N
1262	sana/itu	1	s	\N
1263	minuman	1	m	\N
1264	masa	1	m	\N
1265	berita	1	b	\N
1266	makan malam	1	m	\N
1268	menjual (jual) 	1	m	\N
1271	pakai	1	p	\N
1283	minggu lepas	1	m	\N
1287	abang	1	a	\N
1290	meminta (minta) 	1	m	\N
1297	itu	1	i	\N
1299	yang mana/mana	1	y	\N
1317	malam	1	m	\N
1324	gelap	1	g	\N
1329	tidur	1	t	\N
1345	téh	1	t	\N
1355	sepuluh	1	s	\N
1357	panas	1	p	\N
1358	siapa	1	s	\N
1374	setém	1	s	\N
1375	poskad	1	p	\N
1376	pagi	1	p	\N
1378	pedas	1	p	\N
1381	lupa/tertinggal	1	l	\N
1391	nombor	1	n	\N
1392	déwasa	1	d	\N
1399	jawapan	1	j	\N
1400	bulan lepas	1	b	\N
1401	réstoran	1	r	\N
1402	bekerja	1	b	\N
1403	baju sejuk	1	b	\N
1406	ikan	1	i	\N
1411	pasport	1	p	\N
1415	hidung	1	h	\N
1416	pénsél	1	p	\N
1422	faham	1	f	\N
1439	khabar	1	k	\N
1450	mengambil (ambil) 	1	m	\N
1455	minggu	1	m	\N
1466	setengah	1	s	\N
1481	sangat suka	1	s	\N
1483	bersama	1	b	\N
1485	kad krédit	1	k	\N
1489	lagi	1	l	\N
1503	segalanya	1	s	\N
1531	baik	1	b	\N
1533	terang	1	t	\N
1534	mengangkat (angkat)	1	m	\N
1535	sarapan	1	s	\N
1536	lusa	1	l	\N
1537	bermain	1	b	\N
1538	panas	1	p	\N
1539	otak/kepala	1	o	\N
1540	tebal	1	t	\N
1541	sana	1	s	\N
1542	kakak	1	k	\N
1543	itu	1	i	\N
1544	mandi	1	m	\N
1545	berbahaya	1	b	\N
1548	ada	1	a	\N
1549	kolam	1	k	\N
1550	kerusi	1	k	\N
1551	sibuk	1	s	\N
1552	se-	1	s	\N
1553	satu hari	1	s	\N
1554	lima hari bulan	1	l	\N
1555	lima biji	1	l	\N
1556	maksud	1	m	\N
1557	pintu masuk	1	p	\N
1558	ada	1	a	\N
1559	perlu	1	p	\N
1560	belakang	1	b	\N
1561	nipis	1	n	\N
1562	lahir	1	l	\N
1563	bising	1	b	\N
1564	kot	1	k	\N
1565	pawagam	1	p	\N
1567	besar	1	b	\N
1568	ramai	1	r	\N
1569	kuih	1	k	\N
1570	isteri	1	i	\N
1571	pak cik	1	p	\N
1572	datuk	1	d	\N
1573	tandas	1	t	\N
1574	lelaki	1	l	\N
1575	budak lelaki	1	b	\N
1576	dua hari lepas	1	d	\N
1577	dua tahun lepas	1	d	\N
1578	abang	1	a	\N
1579	kakak	1	k	\N
1580	ibu saudara	1	i	\N
1581	nénék	1	n	\N
1582	mandi	1	m	\N
1583	pegawai polis	1	p	\N
1584	berat	1	b	\N
1585	turun	1	t	\N
1586	budak perempuan	1	b	\N
1587	warga asing	1	w	\N
1588	tangga	1	t	\N
1589	balik	1	b	\N
1590	mengambil (ambil)	1	m	\N
1591	kunci	1	k	\N
1592	bulan	1	b	\N
1594	mamakai	1	m	\N
1595	payung	1	p	\N
1596	angin	1	a	\N
1597	orang	1	o	\N
1598	katakana	1	k	\N
1599	bulan	1	b	\N
1600	cawan	1	c	\N
1601	rumah	1	r	\N
1602	penjuru	1	p	\N
1603	pasu bunga	1	p	\N
1604	pakai	1	p	\N
1605	hari Selasa	1	h	\N
1606	badan	1	b	\N
1607	nak	1	n	\N
1608	ringan	1	r	\N
1609	kari	1	k	\N
1610	kaléndar	1	k	\N
1611	sungai	1	s	\N
1612	sebelah	1	s	\N
1613	comél	1	c	\N
1614	pokok	1	p	\N
1615	kuning	1	k	\N
1616	kuning	1	k	\N
1617	mati	1	m	\N
1618	bertanya	1	b	\N
1619	gitar	1	g	\N
1620	kotor	1	k	\N
1621	kedai kopi	1	k	\N
1622	tikét	1	t	\N
1623	semalam	1	s	\N
1624	sembilan	1	s	\N
1625	daging lembu	1	d	\N
1626	susu lembu	1	s	\N
1627	adik-beradik	1	a	\N
1628	tidak suka	1	t	\N
1629	kilogram	1	k	\N
1630	bank	1	b	\N
1631	ubat	1	u	\N
1632	buah	1	b	\N
1633	mulut	1	m	\N
1634	negara	1	n	\N
1635	mendung	1	m	\N
1636	mendung	1	m	\N
1637	kira-kira	1	k	\N
1638	gram	1	g	\N
1639	hitam	1	h	\N
1640	anggota polis	1	a	\N
1641	pagi tadi/pagi ini	1	p	\N
1642	berkahwin	1	b	\N
1645	lima	1	l	\N
1646	persimpangan	1	p	\N
1647	pondok polis	1	p	\N
1648	kot	1	k	\N
1649	sembilan hari bulan	1	s	\N
1650	sembilan buah	1	s	\N
1651	menjawab(jawab)	1	m	\N
1652	gelas	1	g	\N
1653	perkataan	1	p	\N
1654	kanak-kanak	1	k	\N
1655	nasi	1	n	\N
1656	membuat (buat) salinan	1	m	\N
1657	lebih kurang/semasa	1	l	\N
1658	minggu ini	1	m	\N
1659	seperti ini	1	s	\N
1660	tahun	1	t	\N
1661	dompét	1	d	\N
1662	dulu	1	d	\N
1663	berpayung	1	b	\N
1664	gula	1	g	\N
1666	dua tahun akan datang	1	d	\N
1667	tiga	1	t	\N
1668	Encik/Puan/Cik	1	E	\N
1669	berjalan-jalan	1	b	\N
1670	empat	1	e	\N
1671	garam	1	g	\N
1672	tetapi	1	t	\N
1673	tujuh	1	t	\N
1674	keréta	1	k	\N
1675	mati	1	m	\N
1678	mandi	1	m	\N
1679	semasa	1	s	\N
1680	kuat	1	k	\N
1681	kicap	1	k	\N
1682	putih	1	p	\N
1684	menghisap (hisap)	1	m	\N
1685	skirt	1	s	\N
1686	lébih	1	l	\N
1687	sedikit	1	s	\N
1688	sejuk	1	s	\N
1690	pemanas	1	p	\N
1691	sudu	1	s	\N
1692	selipar	1	s	\N
1693	sabun	1	s	\N
1695	kosong	1	k	\N
1696	ribu	1	r	\N
1697	mencuci pakaian	1	m	\N
1698	mencuci pakaian	1	m	\N
1699	membersihkan	1	m	\N
1700	dan	1	d	\N
1701	dekat	1	d	\N
1702	baiklah	1	b	\N
1703	buah	1	b	\N
1704	kedutaan	1	k	\N
1705	penting	1	p	\N
1706	dapur	1	d	\N
1707	téksi	1	t	\N
1708	sahaja	1	s	\N
1709	X-X	1	X	\N
1710	lébar/menegak	1	l	\N
1712	siapa	1	s	\N
1713	sesiapa	1	s	\N
1714	hari jadi	1	h	\N
1715	semakin	1	s	\N
1716	kecil	1	k	\N
1717	keréta api bawah tanah	1	k	\N
1718	warna coklat	1	w	\N
1719	mangkuk	1	m	\N
1720	satu hari bulan	1	s	\N
1721	letih	1	l	\N
1722	tiba	1	t	\N
1723	méja	1	m	\N
1724	membuat (buat) 	1	m	\N
1725	pasang	1	p	\N
1726	sejuk	1	s	\N
1727	méja	1	m	\N
1729	keluar	1	k	\N
1731	pintu keluar	1	p	\N
1732	pintu	1	p	\N
1733	darjah	1	d	\N
1	erm	1	e	\N
2	guru/cikgu	1	g	\N
5	hari ini	1	h	\N
6	pagi	1	p	\N
7	kelas	1	k	\N
8	tidak	1	t	\N
11	ada	1	a	\N
13	saya	1	s	\N
15	sudah	1	s	\N
18	betul	1	b	\N
21	sini	1	s	\N
24	oh/ha	1	o	\N
28	ya	1	y	\N
29	silakan/tolong	1	s	\N
31	selepas itu	1	s	\N
32	ini	1	i	\N
33	buku	1	b	\N
35	panjang	1	p	\N
41	ya	1	y	\N
42	sangat	1	s	\N
45	begitu	1	b	\N
46	itu	1	i	\N
53	sebelah/panjang	1	s	\N
61	ésok	1	é	\N
63	buat pertama kalinya	1	b	\N
68	kalau begitu	1	k	\N
71	bahasa Jepun	1	b	\N
86	bagaimana 	1	b	\N
91	susah	1	s	\N
101	hari Jumaat	1	h	\N
103	selesema	1	s	\N
106	tapi	1	t	\N
109	téléfon/menéléfon	1	t	\N
115	sering/selalu	1	s	\N
117	ini	1	i	\N
120	membosankan 	1	m	\N
123	berapa	1	b	\N
134	sekarang	1	s	\N
137	lambat	1	l	\N
138	perpustakaan	1	p	\N
144	kalau begitu/baiklah	1	k	\N
151	berapa	1	b	\N
152	sekejap/sikit	1	s	\N
158	masukkan/menuangkan	1	m	\N
161	sini/ini	1	s	\N
169	bahasa Inggeris	1	b	\N
172	saya	1	s	\N
175	boléh	1	b	\N
182	panas	1	p	\N
184	cuti musim panas	1	c	\N
186	bagus	1	b	\N
188	musim panas	1	m	\N
190	kawan	1	k	\N
193	sedikit	1	s	\N
197	kerja	1	k	\N
200	melancong/pelancongan	1	m	\N
205	tahun lepas	1	t	\N
212	cukup	1	c	\N
214	semuanya	1	s	\N
222	seluruh/sapanjang	1	s	\N
239	sama/se-	1	s	\N
245	bulan ini	1	b	\N
252	susah	1	s	\N
269	minggu depan	1	m	\N
270	hari Rabu	1	h	\N
273	lapangan terbang	1	l	\N
278	keréta	1	k	\N
284	mana	1	m	\N
285	bangunan	1	b	\N
291	bagaimana	1	b	\N
293	sana	1	s	\N
294	lif	1	l	\N
296	yang mana	1	y	\N
299	itu	1	i	\N
300	cakap	1	c	\N
303	kerja rumah	1	k	\N
317	sendiri/saya	1	s	\N
319	kanji	1	k	\N
323	filem	1	f	\N
324	suka	1	s	\N
325	paling	1	p	\N
334	pergi	1	p	\N
337	makan	1	m	\N
339	hidangan/masakan/memasak	1	h	\N
344	setiap hari	1	s	\N
345	ya/terima kasih	1	y	\N
353	salinan	1	s	\N
356	butang	1	b	\N
363	borang	1	b	\N
370	hélo	1	h	\N
372	sekolah	1	s	\N
375	kaki	1	k	\N
388	hujan	1	h	\N
398	kenapa	1	k	\N
410	murah	1	m	\N
411	kedai	1	k	\N
412	ramai	1	r	\N
420	mengajar (ajar)	1	m	\N
422	luar negara	1	l	\N
423	ini	1	i	\N
425	universiti	1	u	\N
440	mengapa	1	m	\N
444	lagi	1	l	\N
446	syarikat	1	s	\N
454	tahun depan	1	t	\N
459	bila	1	b	\N
466	yang bagaimana	1	y	\N
470	muzik	1	m	\N
498	kemudian	1	k	\N
502	pulangkan	1	p	\N
507	guna	1	g	\N
512	awak semua	1	a	\N
515	itu	1	i	\N
524	situ	1	s	\N
528	sini	1	s	\N
531	situ	1	s	\N
552	latihan/berlatih	1	l	\N
553	keluar	1	k	\N
557	tidak baik	1	t	\N
559	empat	1	e	\N
562	hari Sabtu	1	h	\N
576	demam	1	d	\N
579	hospital	1	h	\N
598	hotél	1	h	\N
600	alamat	1	a	\N
610	luar negara	1	l	\N
617	ibu	1	i	\N
628	pelajar	1	p	\N
629	musim bunga	1	m	\N
634	bapa	1	b	\N
635	cuti	1	c	\N
646	cerah	1	c	\N
649	taman	1	t	\N
654	anjing	1	a	\N
656	pén	1	p	\N
1734	binatang	1	b	\N
1735	sepuluh	1	s	\N
1736	jauh	1	j	\N
1737	sepuluh hari bulan	1	s	\N
1738	kadang-kadang	1	k	\N
1739	tempat	1	t	\N
1740	tahun	1	t	\N
1741	yang mana	1	y	\N
1742	sebelah	1	s	\N
1743	yang mana	1	y	\N
1744	daging ayam	1	d	\N
1746	pisau	1	p	\N
1747	sambil	1	s	\N
1748	menangis	1	m	\N
1749	kehilangan	1	k	\N
1750	dan lain-lain	1	d	\N
1751	tujuh biji	1	t	\N
1752	tujuh hari bulan	1	t	\N
1753	beratur	1	b	\N
1754	tersusun/menyusun (susun)	1	t	\N
1755	menjadi (jadi) 	1	m	\N
1756	dua	1	d	\N
1757	meriah	1	m	\N
1758	daging	1	d	\N
1759	hari bulan	1	h	\N
1776	cerita/bercerita	1	c	\N
1777	cepat	1	c	\N
1778	menampal (tampal)	1	m	\N
1779	makan malam	1	m	\N
1780	separuh	1	s	\N
1781	timur	1	t	\N
1782	ékor	1	é	\N
1783	bermain (main)	1	b	\N
1784	rendah	1	r	\N
1785	sebiji	1	s	\N
1787	lapang	1	l	\N
1788	seratus	1	s	\N
1789	hiragana	1	h	\N
1790	tengah hari 	1	t	\N
1791	makan tengah hari	1	m	\N
1792	filem	1	f	\N
1793	sampul surat	1	s	\N
1794	garpu	1	g	\N
1795	bertiup (tiup)	1	b	\N
1796	dua buah	1	d	\N
1797	daging babi	1	d	\N
1798	berdua/dua orang	1	b	\N
1799	dua hari bulan	1	d	\N
1800	besar	1	b	\N
1803	tidak pandai	1	t	\N
1804	haiwan peliharaan	1	h	\N
1805	belajar	1	b	\N
1806	lebih	1	l	\N
1807	topi	1	t	\N
1808	pokét	1	p	\N
1809	nak	1	n	\N
1810	kurus	1	k	\N
1811	rak buku	1	r	\N
1812	setiap minggu	1	s	\N
1813	setiap bulan	1	s	\N
1814	setiap tahun	1	s	\N
1815	setiap malam	1	s	\N
1816	tidak sedap	1	t	\N
1817	lurus/terus	1	l	\N
1818	mancis	1	m	\N
1819	bulat	1	b	\N
1821	menggosok (gosok)	1	m	\N
1822	péndék	1	p	\N
1823	air	1	a	\N
1824	tiga hari bulan	1	t	\N
1825	tiga	1	t	\N
1826	hijau	1	h	\N
1827	telinga	1	t	\N
1828	enam hari bulan	1	e	\N
1829	sana/sebalik	1	s	\N
1830	enam buah	1	e	\N
1831	kampung	1	k	\N
1832	mata/penglihatan	1	m	\N
1833	cermin mata	1	c	\N
1834	hari Khamis	1	h	\N
1835	lebih	1	l	\N
1836	benda	1	b	\N
1837	kedai	1	k	\N
1838	gerai sayur	1	g	\N
1839	sayur	1	s	\N
1840	mudah	1	m	\N
1841	lapan buah	1	l	\N
1842	petang	1	p	\N
1843	pejabat pos	1	p	\N
1844	malam tadi	1	m	\N
1845	terkenal	1	t	\N
1846	salji	1	s	\N
1847	perlahan-lahan	1	p	\N
1848	lapan hari bulan	1	l	\N
1849	pakaian Barat	1	p	\N
1850	empat hari bulan	1	e	\N
1851	memanggil (panggil)	1	m	\N
1852	lemah	1	l	\N
1853	radio	1	r	\N
1854	pemain radio kasét	1	p	\N
1855	ibu bapa	1	i	\N
1856	melancong	1	m	\N
1857	sifar	1	s	\N
1858	peti sejuk	1	p	\N
1860	berlatih	1	b	\N
1861	koridor	1	k	\N
1862	enam	1	e	\N
1864	bekal	1	b	\N
1865	berjalan-jalan (jalan-jalan)	1	b	\N
1866	orang	1	o	\N
1867	pejabat hartanah	1	p	\N
1868	pinggan	1	p	\N
1869	arak	1	a	\N
1870	salon kecantikan	1	s	\N
1872	lain	1	l	\N
1873	mahal	1	m	\N
1874	sangat	1	s	\N
1875	baik	1	b	\N
1876	empat	1	e	\N
1877	tujuh	1	t	\N
1878	sembilan	1	s	\N
1879	kilométer	1	k	\N
1881	batang	1	b	\N
1882	sebelum/lepas	1	s	\N
1883	jam	1	j	\N
1884	pukul	1	p	\N
1886	menéléfon	1	m	\N
1887	ayat	1	a	\N
1888	tekak	1	t	\N
1889	membuat (buat) 	1	m	\N
1891	tukang gunting	1	t	\N
1892	bersyampu/syampu	1	b	\N
1893	pekerja stésén	1	p	\N
1894	nombor téléfon	1	n	\N
1895	hubungi	1	h	\N
1897	mendengar (dengar)	1	m	\N
1898	séwa rumah	1	s	\N
1899	mencari (cari)	1	m	\N
1900	menu sét	1	m	\N
1901	susu	1	s	\N
1915	memakai (pakai) 	1	m	\N
1922	bermalam	1	b	\N
1923	cenderamata	1	c	\N
1925	suami	1	s	\N
1926	adik perempuan	1	a	\N
1927	adik lelaki	1	a	\N
1928	membuka (buka)	1	m	\N
1929	menutup (tutup)	1	m	\N
1930	datang	1	d	\N
1933	apa	1	a	\N
1801	musim sejuk	1	m	\N
1902	bahagian	1	b	\N
1904	melalui udara	1	m	\N
1905	melalui laut	1	m	\N
1906	mengirim (kirim)	1	m	\N
1907	sut	1	s	\N
1908	pekerja syarikat	1	p	\N
1909	penyepit	1	p	\N
1910	pegawai bank	1	p	\N
1911	kaunter	1	k	\N
1912	pemindahan	1	p	\N
1913	léwat	1	l	\N
1914	siap	1	s	\N
1916	beréhat (réhat)	1	b	\N
1918	membubuh (bubuh)	1	m	\N
1919	singkat	1	s	\N
1920	panjang	1	p	\N
1921	pemandu pelancong	1	p	\N
1931	negara asal	1	n	\N
1932	nanti	1	n	\N
1934	berhenti (henti)	1	b	\N
1935	dapat	1	d	\N
1936	bimbang	1	b	\N
1937	téléfon bimbit	1	t	\N
1938	memberi (beri)	1	m	\N
1939	pelbagai	1	p	\N
1940	memanggil (panggil)	1	m	\N
1941	berterusan	1	b	\N
1942	menyémak (sémak)	1	m	\N
1943	rasa	1	r	\N
1944	berlainan/lawan	1	b	\N
1945	bunyi	1	b	\N
1946	kumpulan	1	k	\N
1903	郵便局員	0	ゆ	\N
1676	字引	0	し	\N
1677	しめます	0	し	\N
1917	ください (2)	0	く	\N
1924	～人	0	に	\N
315	結論	0	\N	\N
461	お願いできない	0	\N	\N
625	。	0	\N	\N
3	おはようございます	0	\N	\N
4	おはよう	0	\N	\N
9	午前中	0	\N	\N
10	会議	0	\N	\N
12	～君	0	\N	\N
14	２限目	0	\N	\N
16	十時半	0	\N	\N
17	あっ	0	\N	\N
19	急がないと	0	\N	\N
20	お先に失礼します	0	\N	\N
22	印鑑	0	\N	\N
23	いただきたい	0	\N	\N
25	科目	0	\N	\N
26	変更	0	\N	\N
27	わかりました	0	\N	\N
30	ありがとうございます	0	\N	\N
34	お返しします	0	\N	\N
36	間	0	\N	\N
37	ありがとうございました	0	\N	\N
38	いえいえ	0	\N	\N
39	で	0	\N	\N
40	役に立ちました	0	\N	\N
43	おもしろくて	0	\N	\N
44	勉強になる	0	\N	\N
47	よかった	0	\N	\N
48	あのう	0	\N	\N
49	すみません	0	\N	\N
50	何でしょう	0	\N	\N
51	在学証明書	0	\N	\N
52	 いただきたい	0	\N	\N
54	機械	0	\N	\N
55	使って	0	\N	\N
56	～てください	0	\N	\N
57	たびたび	0	\N	\N
58	動かない	0	\N	\N
59	５時	0	\N	\N
60	過ぎています	0	\N	\N
62	お願いします	0	\N	\N
64	一人	0	\N	\N
65	～ずつ	0	\N	\N
66	自己紹介	0	\N	\N
67	～をお願いします	0	\N	\N
69	～さん	0	\N	\N
70	初めまして	0	\N	\N
72	専攻	0	\N	\N
73	4年	0	\N	\N
74	～と申します	0	\N	\N
75	ゼミ	0	\N	\N
76	アクセント	0	\N	\N
77	卒論	0	\N	\N
78	書こう	0	\N	\N
79	～と思っています	0	\N	\N
80	これから	0	\N	\N
81	一年間	0	\N	\N
82	よろしくお願いします	0	\N	\N
83	こちらこそ	0	\N	\N
84	よろしく	0	\N	\N
85	準備	0	\N	\N
87	いちおう	0	\N	\N
88	始めています	0	\N	\N
89	就職活動	0	\N	\N
90	しています	0	\N	\N
92	がんばってください	0	\N	\N
93	失礼します	0	\N	\N
94	レポート	0	\N	\N
95	提出し	0	\N	\N
96	来ました	0	\N	\N
97	えっ	0	\N	\N
98	たしか	0	\N	\N
99	締め切り	0	\N	\N
100	先週の	0	\N	\N
102	遅れて	0	\N	\N
104	寝込んでしまいまして	0	\N	\N
105	そうですか	0	\N	\N
107	そういう	0	\N	\N
108	場合	0	\N	\N
110	メール	0	\N	\N
111	あらかじめ	0	\N	\N
112	連絡して	0	\N	\N
113	気をつけます	0	\N	\N
114	すっかり	0	\N	\N
116	なりました	0	\N	\N
118	軽井沢	0	\N	\N
119	（お）土産	0	\N	\N
121	もの	0	\N	\N
122	へえ	0	\N	\N
124	りんごワイン	0	\N	\N
125	めずらしい	0	\N	\N
126	本当に	0	\N	\N
127	いただいて	0	\N	\N
128	～ていいの	0	\N	\N
129	遠慮なく	0	\N	\N
130	うーん	0	\N	\N
131	楽しみ	0	\N	\N
132	どうもありがとう	0	\N	\N
133	こんばんは	0	\N	\N
135	そうなんです	0	\N	\N
136	ずいぶん	0	\N	\N
139	資料	0	\N	\N
140	探して	0	\N	\N
141	偉い	0	\N	\N
142	気をつけて	0	\N	\N
143	帰って	0	\N	\N
145	さようなら	0	\N	\N
146	いらっしゃいませ	0	\N	\N
147	注文したい	0	\N	\N
148	日本	0	\N	\N
149	文法	0	\N	\N
150	辞典	0	\N	\N
153	お待ちください	0	\N	\N
154	6,500円	0	\N	\N
155	税込み	0	\N	\N
156	いえ	0	\N	\N
157	消費税	0	\N	\N
159	6,825円	0	\N	\N
160	なります	0	\N	\N
162	(お)名前	0	\N	\N
163	(お)電話番号	0	\N	\N
164	先輩	0	\N	\N
165	登録	0	\N	\N
166	質問して	0	\N	\N
167	～てもいいですか	0	\N	\N
168	いいよ	0	\N	\N
170	とった	0	\N	\N
171	～たことがあります	0	\N	\N
173	あまり（～ない）	0	\N	\N
174	自信	0	\N	\N
176	そうだねえ	0	\N	\N
177	厳しい	0	\N	\N
178	他	0	\N	\N
179	考えた	0	\N	\N
180	～たほうがいい	0	\N	\N
181	～かもしれない	0	\N	\N
183	早く	0	\N	\N
185	来る	0	く	\N
187	そうね	0	\N	\N
189	予定	0	\N	\N
191	ヨーロッパ	0	\N	\N
192	旅行しよう	0	\N	\N
194	バイト	0	\N	\N
195	しよう	0	\N	\N
196	通訳	0	\N	\N
198	すごい	0	\N	\N
199	見ている	0	\N	\N
201	パンフレット	0	\N	\N
202	どこか	0	\N	\N
203	旅行したい	0	\N	\N
204	～と思って	0	\N	\N
206	タイ	0	\N	\N
207	行かれました	0	\N	\N
208	行った	0	\N	\N
209	（お）かね	0	\N	\N
210	どのぐらい	0	\N	\N
211	かかりましたか	0	\N	\N
213	安かった	0	\N	\N
215	10万	0	\N	\N
216	～日間	0	\N	\N
217	行っていた	0	\N	\N
218	かなり	0	\N	\N
219	長かった	0	\N	\N
220	3週間	0	\N	\N
221	～週間	0	\N	\N
223	開いていますか	0	\N	\N
224	～時	0	\N	\N
225	9時	0	\N	\N
226	自習室	0	\N	\N
227	使えますか	0	\N	\N
228	5時	0	\N	\N
229	土日	0	\N	\N
230	(お)休み	0	\N	\N
231	はい、どうぞ	0	\N	\N
232	伺いたい	0	\N	\N
233	一度	0	\N	\N
234	～冊	0	\N	\N
235	借りられますか	0	\N	\N
236	10冊	0	\N	\N
237	借りられます	0	\N	\N
238	大学院生	0	\N	\N
240	一ヶ月	0	\N	\N
241	20冊	0	\N	\N
242	どれぐらい	0	\N	\N
243	2週間	0	\N	\N
244	じゃ	0	\N	\N
246	20日	0	\N	\N
247	いいですね	0	\N	\N
248	期末レポート	0	\N	\N
249	お送りして	0	\N	\N
250	いや	0	\N	\N
251	やっぱり	0	\N	\N
253	いちいち	0	\N	\N
254	プリントアウトしなければ	0	\N	\N
255	～なければいけない	0	\N	\N
256	郵便	0	\N	\N
257	送って	0	\N	\N
258	(ご)自宅	0	\N	\N
259	そうしてください	0	\N	\N
260	アメリカ	0	\N	\N
261	留学して	0	\N	\N
262	学部	0	\N	\N
263	半年間	0	\N	\N
264	ボストン	0	\N	\N
265	住んでいました	0	\N	\N
266	話せますか	0	\N	\N
267	少しなら	0	\N	\N
268	実は	0	\N	\N
271	お客さん	0	\N	\N
272	来るんですが	0	\N	\N
274	迎えに行って	0	\N	\N
275	いいです	0	\N	\N
276	十時	0	\N	\N
277	行けますか	0	\N	\N
279	運転	0	\N	\N
280	できます	0	\N	\N
281	授業料	0	\N	\N
282	払いたい	0	\N	\N
283	会計課	0	\N	\N
286	3階	0	\N	\N
287	～階	0	\N	\N
288	あります	0	\N	\N
289	印刷センタ－	0	\N	\N
290	となり	0	\N	\N
292	行けば	0	\N	\N
295	国際法	0	\N	\N
297	～と思う	0	\N	\N
298	経済史	0	\N	\N
301	出席	0	\N	\N
302	厳しくて	0	\N	\N
304	多くて	0	\N	\N
305	それに	0	\N	\N
306	成績	0	\N	\N
307	辛くて	0	\N	\N
308	どうしようかなあ	0	\N	\N
309	役に立つ	0	\N	\N
310	この間	0	\N	\N
311	返却します	0	\N	\N
312	なかなか	0	\N	\N
313	書けている	0	\N	\N
314	～と思いました	0	\N	\N
316	もう少し	0	\N	\N
318	意見	0	\N	\N
320	間違い	0	\N	\N
321	今度	0	\N	\N
322	黒澤	0	\N	\N
326	そうですねえ	0	\N	\N
327	あかひげ	0	\N	\N
328	ゆめ	0	\N	\N
329	大好きです	0	\N	\N
330	詳しい	0	\N	\N
331	羅生門	0	\N	\N
332	映画祭	0	\N	\N
333	一緒に	0	\N	\N
335	うれしい	0	\N	\N
336	料理する	0	\N	\N
338	得意	0	\N	\N
340	スパゲッティ	0	\N	\N
341	パエーリア	0	\N	\N
342	グルメ	0	\N	\N
343	食事	0	\N	\N
346	片付ける	0	\N	\N
347	苦手	0	\N	\N
348	作りません	0	\N	\N
349	たしかに	0	\N	\N
350	後片付け	0	\N	\N
351	面倒	0	\N	\N
352	拡大	0	\N	\N
354	したい	0	\N	\N
355	まず	0	\N	\N
357	押して	0	\N	\N
358	次に	0	\N	\N
359	倍率	0	\N	\N
360	選んで	0	\N	\N
361		0	\N	\N
362	最後	0	\N	\N
364	スタートボタン	0	\N	\N
365	ところで	0	\N	\N
366	コピーカード	0	\N	\N
367	持っています	0	\N	\N
368	預かる	0	\N	\N
369	忘れた	0	\N	\N
371	最近	0	\N	\N
373	お会いしません	0	\N	\N
374	どうかしましたか	0	\N	\N
376	けがしてしまって	0	\N	\N
377	そうだったんですか	0	\N	\N
378	論文	0	\N	\N
379	何とか	0	\N	\N
380	がんばっています	0	\N	\N
381	無理なさらないで	0	\N	\N
382	～ないでください	0	\N	\N
383	お大事に	0	\N	\N
384	じゃあ、また	0	\N	\N
385	ボート大会	0	\N	\N
386	何か	0	\N	\N
387	もし（～たら）	0	\N	\N
389	降ったら	0	\N	\N
390	大会	0	\N	\N
391	中止	0	\N	\N
392	小雨	0	\N	\N
393	程度	0	\N	\N
394	ならない	0	\N	\N
395	～と思います	0	\N	\N
396	大雨	0	\N	\N
397	ありますか	0	\N	\N
399	見にいく	0	\N	\N
400	約束をしている	0	\N	\N
401	なるほど	0	\N	\N
402	飲み会	0	\N	\N
403	新宿	0	\N	\N
404	吉祥寺	0	\N	\N
405	池袋	0	\N	\N
406	～の中で	0	\N	\N
407	やめませんか	0	\N	\N
408	そうですね	0	\N	\N
409	どちらが	0	\N	\N
413	～にしませんか	0	\N	\N
414	～にしましょう	0	\N	\N
415	進んでいます	0	\N	\N
416	思い通り	0	\N	\N
417	進まなくて	0	\N	\N
418	どのような	0	\N	\N
419	考えている	0	\N	\N
421	それじゃ	0	\N	\N
424	韓国	0	\N	\N
426	日本語教師	0	\N	\N
427	募集している	0	\N	\N
428	え	0	\N	\N
429	そうなんですか	0	\N	\N
430	興味	0	\N	\N
431	あれば	0	\N	\N
432	推薦書	0	\N	\N
433	書いて	0	\N	\N
434	～てあげます	0	\N	\N
435	あー	0	\N	\N
436	真剣に	0	\N	\N
437	せんせい	0	\N	\N
438	休ませて	0	\N	\N
439	～ていただきたいのですが	0	\N	\N
441	じつは	0	\N	\N
442	就職	0	\N	\N
443	最終面接	0	\N	\N
445	来られません	0	\N	\N
447	遠く	0	\N	\N
448	無理	0	\N	\N
449	面接	0	\N	\N
450	がんばって	0	\N	\N
451	がんばります	0	\N	\N
452	(お)忙しい	0	\N	\N
453	申し訳ありません	0	\N	\N
455	留学しよう	0	\N	\N
456	～と思っている	0	\N	\N
457	～ていただきたい	0	\N	\N
458	よろしいでしょうか	0	\N	\N
460	急いでいる	0	\N	\N
462	だいじょうぶ	0	\N	\N
463	ほっとしました	0	\N	\N
464	学園祭	0	\N	\N
465	18日	0	\N	\N
467	催し物	0	\N	\N
468	外語大	0	\N	\N
469	いろんな	0	\N	\N
471	演奏したり	0	\N	\N
472	(お)芝居	0	\N	\N
473	ダンス	0	\N	\N
474	やったり	0	\N	\N
475	料理店	0	\N	\N
476	出したり	0	\N	\N
477	食べられる	0	\N	\N
478	イタリア	0	\N	\N
479	いろいろな	0	\N	\N
480	楽しそう	0	\N	\N
481	子ども	0	\N	\N
482	連れて来ます	0	\N	\N
483	ぜひいらしてください	0	\N	\N
484	お待ちして	0	\N	\N
485	(ご)注文	0	\N	\N
486	天ぷらうどん	0	\N	\N
487	ごめんなさい	0	\N	\N
488	天ぷら	0	\N	\N
489	終わってしまった	0	\N	\N
490	うどん	0	\N	\N
491	たぬき	0	\N	\N
492	きつね	0	\N	\N
493	きつねうどん	0	\N	\N
494	少々	0	\N	\N
495	電子辞書	0	\N	\N
496	そうだろ	0	\N	\N
497	買った	0	\N	\N
499	講読	0	\N	\N
500	お借りして	0	\N	\N
501	まあ	0	\N	\N
503	(お)昼休み	0	\N	\N
504	～でもいいですか	0	\N	\N
506	３限目	0	\N	\N
508	返して	0	\N	\N
509	４限目	0	\N	\N
510	英作	0	\N	\N
511	ええっ	0	\N	\N
513	シンポジウム	0	\N	\N
514	よろしくお願いいたします	0	\N	\N
516	必ず	0	\N	\N
517	出なければ	0	\N	\N
518	～なければいけません	0	\N	\N
519	～てもらいます	0	\N	\N
520	日	0	\N	\N
521	仕方がありません	0	\N	\N
522	～なければなりません	0	\N	\N
523	もちろん	0	\N	\N
525	空き缶	0	\N	\N
526	捨てて	0	\N	\N
527	～てはいけません	0	\N	\N
529	分かりました	0	\N	\N
530	ああっ	0	\N	\N
532	ちょっとすみません	0	\N	\N
533	何ですか	0	\N	\N
534	自転車置き場	0	\N	\N
535	とめれば	0	\N	\N
536	とめて	0	\N	\N
537	(お)願い	0	\N	\N
538	何でしょうか	0	\N	\N
539	ホームページ	0	\N	\N
540	作りたい	0	\N	\N
541	手伝って	0	\N	\N
542	～てもらえますか	0	\N	\N
543	研究テーマ	0	\N	\N
544	載せたい	0	\N	\N
545	いいですか	0	\N	\N
546	かまいません	0	\N	\N
547	顔写真	0	\N	\N
548	載せよう	0	\N	\N
549	載せないで	0	\N	\N
550	～ないでいただけないでしょうか	0	\N	\N
551	～くん	0	\N	\N
554	出なくて	0	\N	\N
555	～なくてもいいですか	0	\N	\N
556	具合	0	\N	\N
558	試験	0	\N	\N
560	こんにちは	0	\N	\N
561	ダンスサークル	0	\N	\N
563	ステージ	0	\N	\N
564	よかったら	0	\N	\N
565	見にいらっしゃいませんか	0	\N	\N
566	分かった	0	\N	\N
567	いっしょに	0	\N	\N
568	見に行く	0	\N	\N
569	悪そう	0	\N	\N
570	うん	0	\N	\N
571	スキー	0	\N	\N
572	合宿	0	\N	\N
573	風邪をひいてしまった	0	\N	\N
574	ゆうべ	0	\N	\N
575	急に	0	\N	\N
577	出て	0	\N	\N
578	それなら	0	\N	\N
580	インフルエンザ	0	\N	\N
581	～かもしれません	0	\N	\N
582	ありがとう	0	\N	\N
583	もうすぐ	0	\N	\N
584	絶対	0	\N	\N
585	しない	0	\N	\N
586	～ないほうがいい	0	\N	\N
587	謝恩会	0	\N	\N
588	会場	0	\N	\N
589	予約したい	0	\N	\N
591	25日	0	\N	\N
592	6時	0	\N	\N
593	30名	0	\N	\N
594	～名	0	\N	\N
595	一万	0	\N	\N
596	～円	0	\N	\N
597	お願いできます	0	\N	\N
599	送ってほしい	0	\N	\N
601	東京都	0	\N	\N
602	府中市	0	\N	\N
603	朝日町	0	\N	\N
604	卒業	0	\N	\N
605	決まりました	0	\N	\N
606	商社	0	\N	\N
607	決まった	0	\N	\N
608	おめでとうございます	0	\N	\N
609	将来	0	\N	\N
611	働きたい	0	\N	\N
612	行きたい	0	\N	\N
613	ビジネス英語	0	\N	\N
614	勉強している	0	\N	\N
615	お待たせ	0	\N	\N
616	おめでとう	0	\N	\N
618	お世話になりました	0	\N	\N
619	立派な	0	\N	\N
620	社会人	0	\N	\N
621	なって	0	\N	\N
622	4年間	0	\N	\N
623	～年間	0	\N	\N
624	です	0	\N	\N
626	ます	0	\N	\N
627	ん	0	\N	\N
630	田中	0	\N	\N
631	キム	0	\N	\N
632	さん	0	\N	\N
633	が	0	\N	\N
636	山田	0	\N	\N
637	リーダー	0	\N	\N
638	、	0	\N	\N
639	１	0	\N	\N
640	位	0	\N	\N
641	中山	0	\N	\N
642	大学生	0	\N	\N
643	か	0	\N	\N
644	山口	0	\N	\N
645	東京	0	\N	\N
647	た	0	\N	\N
648	むかし	0	\N	\N
650	お昼	0	\N	\N
651	おにぎり	0	\N	\N
652	きのう	0	\N	\N
653	かう	0	\N	\N
655	いる	0	\N	\N
658	誰	0	\N	\N
660	よ	0	\N	\N
662	パソコン	0	\N	\N
665	みなさん	0	\N	\N
668	太郎	0	\N	\N
669	ロックコンサート	0	\N	\N
673	うし	0	\N	\N
674	ろ	0	\N	\N
680	木村	0	\N	\N
683	向かい	0	\N	\N
684	埼玉	0	\N	\N
687	体育館	0	\N	\N
689	はさみ	0	\N	\N
690	数学	0	\N	\N
691	教科書	0	\N	\N
692	２	0	\N	\N
695	東京外国語大学	0	\N	\N
697	４つ	0	\N	\N
698	季節	0	\N	\N
700	友だち	0	\N	\N
706	すてき	0	\N	\N
708	よう	0	\N	\N
709	かん	0	\N	\N
711	あまい	0	\N	\N
712	おかし	0	\N	\N
714	じょうぶ	0	\N	\N
715	CD	0	\N	\N
718	を	0	\N	\N
721	すき	0	\N	\N
723	年生	0	\N	\N
724	図書	0	\N	\N
725	事務	0	\N	\N
728	山本	0	\N	\N
730	消しゴム	0	\N	\N
732	ござる	0	\N	\N
733	ぼうし	0	\N	\N
735	さる	0	\N	\N
736	かさ	0	\N	\N
739	７つ	0	\N	\N
744	ボール	0	\N	\N
748	３	0	\N	\N
749	くらい	0	\N	\N
751	何時	0	\N	\N
752	４	0	\N	\N
754	きょう	0	\N	\N
755	月	0	\N	\N
756	あした	0	\N	\N
757	曜日	0	\N	\N
760	する	0	す	\N
763	研究	0	\N	\N
761	TV	1	T	\N
765	小説	0	\N	\N
766	から	0	\N	\N
768	聞き手	0	\N	\N
769	’	0	\N	\N
770	A	0	\N	\N
771	：	0	\N	\N
773	地震	0	\N	\N
776	B	0	\N	\N
779	帰る	0	\N	\N
780	ハンバーガー	0	\N	\N
783	サンドイッチ	0	\N	\N
789	フランス語	0	\N	\N
792	シール	0	\N	\N
793	はる	0	\N	\N
797	誕生	0	\N	\N
798	りんご	0	\N	\N
804	北海道	0	\N	\N
805	君	0	\N	\N
808	つく	0	\N	\N
809	れる	0	\N	\N
810	あたり	0	\N	\N
811	駅前	0	\N	\N
813	ハッピー	0	\N	\N
816	力	0	\N	\N
823	バスケットボール	0	\N	\N
824	じょうず	0	\N	\N
826	へた	0	\N	\N
827	×	0	\N	\N
828	気分	0	\N	\N
830	よい	0	\N	\N
833	電子	0	\N	\N
835	小林	0	\N	\N
837	ごはん	0	\N	\N
838	お願い	0	\N	\N
843	ジョギング	0	\N	\N
847	ビル	0	\N	\N
848	そびえる	0	\N	\N
849	似る	0	\N	\N
850	まり	0	\N	\N
856	ホーム	0	\N	\N
857	ポスター	0	\N	\N
862	う	0	\N	\N
864	"	0	\N	\N
866	調べる	0	\N	\N
868	サラダ	0	\N	\N
871	［	0	\N	\N
872	漫画	0	\N	\N
873	や	0	\N	\N
876	局	0	\N	\N
884	中村	0	\N	\N
885	親切	0	\N	\N
887	お	0	\N	\N
888	金持ち	0	\N	\N
890	めがね	0	\N	\N
891	かける	0	\N	\N
894	たり	0	\N	\N
896	だり	0	\N	\N
899	大阪	0	\N	\N
900	行う	0	\N	\N
901	たる	0	\N	\N
902	やむ	0	\N	\N
764	majlis	1	m	\N
904	いっしょ	0	\N	\N
906	くださる	0	\N	\N
907	７	0	\N	\N
910	８	0	\N	\N
911	すもう	0	\N	\N
912	たい	0	\N	\N
913	２つ	0	\N	\N
914	折る	0	\N	\N
916	弁当	0	へ	\N
919	聞く	0	\N	\N
921	ダイビング	0	\N	\N
930	始める	0	\N	\N
933	暖かい	0	\N	\N
934	運動会	0	\N	\N
935	だけ	0	\N	\N
936	ばかり	0	\N	\N
940	最初	0	\N	\N
942	過ごす	0	\N	\N
943	あらし	0	\N	\N
945	拍手	0	\N	\N
947	ゴミ箱	0	\N	\N
948	ごみ	0	\N	\N
949	捨てる	0	\N	\N
950	ほえる	0	\N	\N
951	相談	0	\N	\N
953	集まる	0	\N	\N
954	氷	0	\N	\N
955	政治	0	\N	\N
956	せる	0	\N	\N
957	ほめる	0	\N	\N
958	られる	0	\N	\N
960	見つかる	0	\N	\N
961	教わる	0	\N	\N
963	すぎる	0	\N	\N
965	袋	0	\N	\N
966	ずつ	0	\N	\N
967	泊まる	0	\N	\N
968	建てる	0	\N	\N
971	３月	0	\N	\N
973	えんぴつ	0	\N	\N
975	佐藤	0	\N	\N
976	さ	0	\N	\N
977	びっくり	0	\N	\N
983	ぶどう	0	\N	\N
984	ワイン	0	\N	\N
985	作る	0	\N	\N
986	贈る	0	\N	\N
987	説明	0	\N	\N
988	鈴木	0	\N	\N
989	よる	0	\N	\N
990	年上	0	\N	\N
991	白線	0	\N	\N
992	より	0	\N	\N
994	世界	0	\N	\N
995	川	0	\N	\N
996	ナイル	0	\N	\N
997	４月	0	\N	\N
998	５月	0	\N	\N
999	片道	0	\N	\N
1000	往復	0	\N	\N
1001	十分	0	\N	\N
1004	遅れる	0	\N	\N
1005	はだし	0	\N	\N
1006	はだかる	0	\N	\N
1009	全員	0	\N	\N
1010	ドライブ	0	\N	\N
1011	年間	0	\N	\N
1014	警察	0	\N	\N
1015	事件	0	\N	\N
1017	出かける	0	\N	\N
1021	「	0	\N	\N
1022	」	0	\N	\N
1023	書類	0	\N	\N
1025	ハンバーグ	0	\N	\N
1027	いばら	0	\N	\N
1028	かしこまる	0	\N	\N
1029	会話	0	\N	\N
1031	あげる	0	\N	\N
1033	わかる	0	\N	\N
1034	どうか	0	\N	\N
1035	ゆるす	0	\N	\N
1036	助ける	0	\N	\N
1038	がんばる	0	\N	\N
1039	安心	0	\N	\N
1040	ぜひ	0	\N	\N
1041	もう一度	0	\N	\N
1042	機	0	\N	\N
1043	いける	0	\N	\N
1044	携帯	0	\N	\N
1046	しばらく	0	\N	\N
1047	酒	0	さ	\N
1049	ちゃ	0	\N	\N
1050	泣く	0	\N	\N
1051	すう	0	\N	\N
1052	ふろ	0	ふ	\N
1054	おこる	0	\N	\N
1055	殺す	0	\N	\N
1056	不合格	0	\N	\N
1057	心配	0	\N	\N
1058	気	0	\N	\N
1059	遠慮	0	\N	\N
1060	ジーンズ	0	\N	\N
1061	解答	0	\N	\N
1062	スケート	0	\N	\N
1064	信号	0	\N	\N
1068	横断	0	\N	\N
1069	歩道	0	\N	\N
1070	遊び	0	\N	\N
1071	アルバイト	0	\N	\N
1072	日記	0	\N	\N
1073	昼食	0	\N	\N
1077	この辺	0	\N	\N
1078	６	0	\N	\N
1080	沈む	0	\N	\N
1081	散る	0	\N	\N
1083	思う	0	\N	\N
1084	留学	0	\N	\N
1086	手洗い	0	\N	\N
1087	したがう	0	\N	\N
1089	発表	0	\N	\N
1090	ほしい	0	\N	\N
1091	｛	0	\N	\N
1092	｝	0	\N	\N
1096	がる	0	\N	\N
1097	入り用	0	\N	\N
1098	よろしい	0	\N	\N
1100	水泳	0	\N	\N
1101	きらい	0	\N	\N
1102	つらい	0	\N	\N
1103	こわい	0	\N	\N
1104	K	0	\N	\N
1105	くん	0	\N	\N
1106	らしい	0	\N	\N
1108	こわがる	0	\N	\N
1110	アラビア	0	\N	\N
1112	書ける	0	\N	\N
1113	さす	0	\N	\N
1114	行ける	0	\N	\N
1115	彼	0	\N	\N
1116	一生	0	\N	\N
1117	愛せる	0	\N	\N
1119	チーム	0	\N	\N
1120	勝つ	0	\N	\N
1122	外語	0	\N	\N
1124	？	0	\N	\N
1125	さっき	0	\N	\N
1126	ほら	0	\N	\N
1127	コンビニ	0	\N	\N
1128	かも	0	\N	\N
1129	しれる	0	\N	\N
1130	ごろ	0	\N	\N
1131	もしか	0	\N	\N
1132	兄さん	0	\N	\N
1133	今ごろ	0	\N	\N
1134	ひま	0	\N	\N
1135	ちがう	0	\N	\N
1136	田村	0	\N	\N
1138	きっと	0	\N	\N
1140	事故	0	\N	\N
1141	はず	0	\N	\N
1142	教師	0	\N	\N
1143	話せる	0	\N	\N
1144	○	0	\N	\N
1145	ちがい	0	\N	\N
1146	日常	0	\N	\N
1147	さえ	0	\N	\N
1148	うり	0	\N	\N
1149	様子	0	\N	\N
1150	データ	0	\N	\N
1151	考える	0	\N	\N
1152	増える	0	\N	\N
1153	続ける	0	\N	\N
1155	まるで	0	\N	\N
1157	ロボット	0	\N	\N
1158	生きる	0	\N	\N
1159	動く	0	\N	\N
1160	歌手	0	\N	\N
1161	どうやら	0	\N	\N
1165	予報	0	\N	\N
1166	骨	0	\N	\N
1167	ら	0	\N	\N
1168	しいる	0	\N	\N
1169	レントゲン	0	\N	\N
1171	うわさ	0	\N	\N
1172	歌舞伎	0	\N	\N
1173	ふる	0	\N	\N
1175	提出	0	\N	\N
1176	通る	0	\N	\N
1179	優秀	0	\N	\N
1180	自慢	0	\N	\N
1181	合格	0	\N	\N
1182	聞こえる	0	\N	\N
1183	進学	0	\N	\N
1184	勧める	0	\N	\N
1186	つける	0	\N	\N
1187	祭日	0	\N	\N
1188	くすり	0	\N	\N
1190	蛍	0	\N	\N
1191	光	0	\N	\N
1192	流れる	0	\N	\N
1194	かぜ	0	\N	\N
1195	一生懸命	0	\N	\N
1196	落ちる	0	\N	\N
1197	メロン	0	\N	\N
1198	けれども	0	\N	\N
1201	すく	0	\N	\N
1202	通り	0	\N	\N
1204	京都	0	\N	\N
1205	けれど	0	\N	\N
1206	けど	0	\N	\N
1207	じゃま	0	\N	\N
1209	もらえる	0	\N	\N
1210	解ける	0	\N	\N
1213	点	0	\N	\N
1214	以上	0	\N	\N
1215	ちり	0	\N	\N
1216	つもる	0	\N	\N
1217	エアコン	0	\N	\N
1219	返事	0	\N	\N
1222	やめる	0	\N	\N
1223	インターネット	0	\N	\N
1224	なくなる	0	\N	\N
1225	もし	0	\N	\N
1226	新入生	0	\N	\N
1228	さえる	0	\N	\N
1229	たとえ	0	\N	\N
1230	しかた	0	\N	\N
1231	落とす	0	\N	\N
1232	ぬれる	0	\N	\N
1233	こわれる	0	\N	\N
1234	選ぶ	0	\N	\N
1235	おどろく	0	\N	\N
1236	し	0	\N	\N
1237	プレゼント	0	\N	\N
1238	もらう	0	\N	\N
1239	おみやげ	0	\N	\N
1240	△	0	\N	\N
1241	請求	0	\N	\N
1243	さしあげる	0	\N	\N
1244	いただく	0	\N	\N
1245	紹介	0	\N	\N
1246	使い方	0	\N	\N
1247	息子	0	\N	\N
1248	てぶくろ	0	\N	\N
1249	あむ	0	\N	\N
1250	運ぶ	0	\N	\N
1251	ため	0	\N	\N
1252	詩	0	\N	\N
1253	代わる	0	\N	\N
1254	手伝う	0	\N	\N
1255	送る	0	\N	\N
1256	おかす	0	\N	\N
1257	知らせ	0	\N	\N
1258	推薦	0	\N	\N
1259	貸し	0	\N	\N
1260	高校	0	\N	\N
1261	学ぶ	0	\N	\N
1267	古本	0	\N	\N
1269	みる	0	\N	\N
1270	ジュース	0	\N	\N
1272	いつか	0	\N	\N
1273	南極	0	\N	\N
1274	教授	0	\N	\N
1275	言語	0	\N	\N
1276	学	0	\N	\N
1277	先日	0	\N	\N
1278	こう	0	\N	\N
1279	って	0	\N	\N
1280	たいした	0	\N	\N
1281	もん	0	\N	\N
1282	プリント	0	\N	\N
1284	毎回	0	\N	\N
1285	目標	0	\N	\N
1286	星	0	\N	\N
1288	員	0	\N	\N
1289	ご	0	\N	\N
1291	明ける	0	\N	\N
1292	始まり	0	\N	\N
1293	召し上がる	0	\N	\N
1294	読み	0	\N	\N
1295	中田	0	\N	\N
1296	降りる	0	\N	\N
1298	様	0	\N	\N
1300	いらっしゃる	0	\N	\N
1301	お忙しい	0	\N	\N
1302	ご多忙	0	\N	\N
1303	渡辺	0	\N	\N
1304	社長	0	\N	\N
1305	お宅	0	\N	\N
1306	拝見	0	\N	\N
1307	係員	0	\N	\N
1308	案内	0	\N	\N
1309	参る	0	\N	\N
1310	うかがう	0	\N	\N
1311	他社	0	\N	\N
1312	社員	0	\N	\N
1313	部下	0	\N	\N
1314	ただいま	0	\N	\N
1315	外出	0	\N	\N
1316	おる	0	\N	\N
1318	看護	0	\N	\N
1319	桜	0	\N	\N
1320	リー	0	\N	\N
1321	高校生	0	\N	\N
1322	ながら	0	\N	\N
1323	ふり	0	\N	\N
1325	ところ	0	\N	\N
1326	印刷	0	\N	\N
1327	やさしい	0	\N	\N
1328	そろそろ	0	\N	\N
1330	い	0	\N	\N
1331	こそ	0	\N	\N
1332	会長	0	\N	\N
1333	ふさわしい	0	\N	\N
1334	全力	0	\N	\N
1335	尽くす	0	\N	\N
1336	結果	0	\N	\N
1337	でる	0	\N	\N
1338	しか	0	\N	\N
1339	コアラ	0	\N	\N
1340	ユーカリ	0	\N	\N
1341	葉	0	\N	\N
1342	引く	0	ひ	\N
1343	小泉	0	\N	\N
1344	インタビュー	0	\N	\N
1346	それでも	0	\N	\N
1347	いそがしい	0	\N	\N
1348	さんま	0	\N	\N
1349	勝てる	0	\N	\N
1350	くらう	0	\N	\N
1351	ほど	0	\N	\N
1352	富士山	0	\N	\N
1353	エベレスト	0	\N	\N
1354	二	0	\N	\N
1356	歳	0	\N	\N
1359	/	0	\N	\N
1360	かしら	0	\N	\N
1361	経済	0	\N	\N
1362	状態	0	\N	\N
1363	眠い	0	\N	\N
1364	こする	0	\N	\N
1365	さわる	0	\N	\N
1366	なあ	0	\N	\N
1367	おや	0	\N	\N
1368	まちがえる	0	\N	\N
1369	ぞ	0	\N	\N
1370	俺	0	\N	\N
1371	ぜ	0	\N	\N
1372	はねる	0	\N	\N
1373	…	0	\N	\N
1377	時半	0	\N	\N
1379	削除	0	\N	\N
1380	削除	0	\N	\N
1382	みがく	0	\N	\N
1383	ビール	0	\N	\N
1384	ふるさと	0	\N	\N
1385	なつかしい	0	\N	\N
1386	９	0	\N	\N
1387	十字路	0	\N	\N
1388	一	0	\N	\N
1389	８月	0	\N	\N
1390	９月	0	\N	\N
1393	人気	0	\N	\N
1394	チケット	0	\N	\N
1396	えらい	0	\N	\N
1397	美術館	0	\N	\N
1398	ビートルズ	0	\N	\N
1404	通う	0	\N	\N
1405	おしゃべり	0	\N	\N
1407	焼く	0	\N	\N
1408	におい	0	\N	\N
1409	１つ	0	\N	\N
1410	急ぐ	0	\N	\N
1412	鳴る	0	\N	\N
1413	運動	0	\N	\N
1414	象	0	\N	\N
1417	ドイツ語	0	\N	\N
1418	斉藤	0	\N	\N
1419	限	0	\N	\N
1420	お先に	0	\N	\N
1421	失礼	0	\N	\N
1423	お返し	0	\N	\N
1424	在学	0	\N	\N
1425	証明	0	\N	\N
1426	横	0	\N	\N
1427	下さる	0	\N	\N
1428	すむ	0	\N	\N
1429	自己	0	\N	\N
1430	初め	0	\N	\N
1431	まして	0	\N	\N
1432	申す	0	\N	\N
1433	について	0	\N	\N
1434	活動	0	\N	\N
1435	ほう	0	\N	\N
1436	寝込む	0	\N	\N
1437	しまう	0	\N	\N
1438	･･･	0	\N	\N
1440	良い	0	\N	\N
1441	土産	0	\N	\N
1442	遠慮ない	0	\N	\N
1443	探す	0	\N	\N
1444	注文	0	\N	\N
1445	お待ち	0	\N	\N
1446	,	0	\N	\N
1447	いう	0	\N	\N
1448	消費	0	\N	\N
1449	税	0	\N	\N
1451	ねえ	0	\N	\N
1452	ぐらい	0	\N	\N
1453	かかる	0	\N	\N
1454	日間	0	\N	\N
1456	自習	0	\N	\N
1457	使える	0	\N	\N
1458	伺う	0	\N	\N
1459	一度に	0	\N	\N
1460	ヶ月	0	\N	\N
1461	期末	0	\N	\N
1462	お送り	0	\N	\N
1463	アウト	0	\N	\N
1464	ける	0	\N	\N
1465	自宅	0	\N	\N
1467	お客	0	\N	\N
1468	迎える	0	\N	\N
1469	料	0	\N	\N
1470	払う	0	\N	\N
1471	会計	0	\N	\N
1472	センター	0	\N	\N
1473	小沢	0	\N	\N
1474	｢	0	\N	\N
1475	国際	0	\N	\N
1476	法	0	\N	\N
1477	村上	0	\N	\N
1478	返却	0	\N	\N
1479	赤ひげ	0	\N	\N
1480	とか	0	\N	\N
1482	祭	0	\N	\N
1484	スタート	0	\N	\N
1486	けがす	0	\N	\N
1487	なさる	0	\N	\N
1488	大事	0	\N	\N
1490	ボート	0	\N	\N
1491	約束	0	\N	\N
1492	会	0	\N	\N
1493	進む	0	\N	\N
1494	募集	0	\N	\N
1495	わあ	0	\N	\N
1496	真剣	0	\N	\N
1497	最終	0	\N	\N
1498	申し訳	0	\N	\N
1499	ほっと	0	\N	\N
1500	学園	0	\N	\N
1501	演奏	0	\N	\N
1502	芝居	0	\N	\N
1504	連れる	0	\N	\N
1505	す	0	\N	\N
1506	昼休み	0	\N	\N
1507	英	0	\N	\N
1508	作	0	\N	\N
1509	仕方	0	\N	\N
1510	置き場	0	\N	\N
1511	とめる	0	\N	\N
1512	吉田	0	\N	\N
1513	テーマ	0	\N	\N
1514	載せる	0	\N	\N
1515	かまう	0	\N	\N
1516	いただける	0	\N	\N
1517	野村	0	\N	\N
1518	サークル	0	\N	\N
1519	みたい	0	\N	\N
1520	謝恩	0	\N	\N
1521	予約	0	\N	\N
1522	名	0	\N	\N
1523	都	0	\N	\N
1524	府中	0	\N	\N
1525	市	0	\N	\N
1526	決まる	0	\N	\N
1527	ビジネス	0	\N	\N
1528	待たす	0	\N	\N
1529	浩二	0	\N	\N
1530	お世話	0	\N	\N
1532	社会	0	\N	\N
1728	テープレコーダー	0	て	\N
1768	はし	0	は	\N
1871	ください (1)	0	く	\N
1880	～人	0	ひ	\N
1885	時	0	と	\N
1890	ひきます	0	ひ	\N
1896	見つかります	0	み	\N
1947	きゅう	0	き	\N
590	3月	0	\N	\N
737	５	0	\N	\N
882	金	0	\N	\N
1683	－人	0	し	\N
505	僕	0	\N	\N
883	→	0	\N	\N
1786	ひとつき	0	ひ	\N
1694	背広	0	せ	\N
1711	多分	0	た	\N
1730	…てください	0	て	\N
750	～時	0	と	\N
1745	ない	0	な	\N
1761	温い	0	ぬ	\N
1771	バター	0	は	\N
1546	飴	0	あ	\N
1566	お～	0	お	\N
1593	電話を掛ける	0	て	\N
1395	結婚	0	け	\N
1665	皿	0	さ	\N
1802	文章	0	ふ	\N
1820	万年筆	0	ま	\N
1859	レコード	0	れ	\N
1863	ワイシャツ	0	わ	\N
1547	ある	0	あ	\N
1643	pintu masuk rumah	1	p	\N
1644	biji	1	b	\N
1760	menanggalkan (tanggal)	1	m	\N
1762	tali léhér	1	t	\N
1763	gigi	1	g	\N
1764	sudu/gelas	1	s	\N
1765	tempat abu rokok	1	t	\N
1766	memakai (pakai) 	1	m	\N
1767	jambatan	1	j	\N
1769	bermula (mula)	1	b	\N
1770	terlébih dahulu/awal	1	t	\N
1772	dua puluh tahun	1	d	\N
1773	lapan	1	l	\N
1774	dua puluh hari bulan	1	d	\N
1775	bunga	1	b	\N
1689	demi	1	d	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ms
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

