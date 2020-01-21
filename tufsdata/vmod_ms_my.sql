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
1.13	အခြေအနေ
1.23	ပုဂ္ဂိုလ်
1.24	သက်ဆိုင်ရာအုပ်စုဝင်
1.25	အများဆိုင်ရာနှင့်ကိုယ်ရေးကိုယ်တာ
1.33	နေထိုင်စားသောက်မှုဘဝ
1.34	အပြုအမူ
1.35	ဆက်ဆံရေး
1.36	ဆက်ဆံပြုမူခြင်း
1.37	စီးပွားရေး
1.38	လုပ်ဆောင်မှု
1.40	ပစ္စည်း
1.42	အဝတ်အစား
1.47	မြေနေရာအသုံးပြုခြင်း
1.50	သဘာဝ
1.51	ပစ္စည်းဥစ္စာ
1.52	စကြာဝဠာကမ္ဘာမြေ
2.10	အတုနှင့်အစစ်
2.11	အမျိုးအစား
2.12	တည်ရှိခြင်း
2.13	အခြေအနေ
2.14	အား
2.15	သက်ရောက်မှု
2.16	အချိန်ကာလ
2.17	ကြားခံလေဟာနယ်
2.30	စိတ်နေစိတ်ထား
2.31	ဘာသာစကား
2.32	အနုပညာ
2.33	နေထိုင်စားသောက်မှုဘဝ
2.34	အပြုအမူ
2.35	ဆက်ဆံရေး
2.52	စကြာဝဠာကမ္ဘာမြေ
2.56	ကိုယ်ခန္ဓာ
2.57	ဘဝသက်တမ်း
3.30	စိတ်နေစိတ်ထား
2.36	ဆက်ဆံပြုမူခြင်း
2.37	စီးပွားရေး
2.38	လုပ်ဆောင်မှု
2.50	သဘာဝ
2.51	ပစ္စည်းဥစ္စာ
3.10	အတုနှင့်အစစ်
3.37	စီးပွားရေး
1.43	စားသောက်ကုန်
1.44	နေအိမ်
1.45	ကိရိယာ
1.46	စက်
1.53	သတ္တဝါ
1.54	ရုက္ခ
1.55	တိရစ္တာန်
1.56	ကိုယ်ခန္ဓာ
3.11	အမျိုးအစား
3.12	တည်ရှိခြင်း
1.10	အကြောင်း
1.11	အမျိုးအစား
1.12	တည်ရှိခြင်း
1.14	အား
1.15	သက်ရောက်မှု
1.16	အချိန်ကာလ
1.17	ကြားခံလေဟာနယ်
1.18	ပုံသဏ္ဌာန်
1.26	လူ့ဘောင်
1.27	ယန္တယား
1.30	စိတ်နေစိတ်ထား
1.31	ဘာသာစကား
1.32	အနုပညာ
1.41	ကုန်ကြမ်းပစ္စည်း
2.19	ပမာဏ
3.13	အခြေအနေ
3.14	အား
1.57	ဘဝအသက်
1.19	ပမာဏ
1.20	လူပုဂ္ဂိုလ်
1.21	မိသားစု
1.22	အပေါင်းအဖော်
3.15	သက်ရောက်မှု
3.16	အချိန်ကာလ
3.17	ကြားခံလေဟာနယ်
3.18	ပုံသဏ္ဌာန်
3.19	ပမာဏ
3.31	ဘာသာစကား
3.33	နေထိုင်စားသောက်မှုဘဝ
3.34	အပြုအမူ
3.35	ဖလှယ်ခြင်း
3.36	ဆက်ဆံပြုမူခြင်း
3.50	သဘာဝ
3.51	ပစ္စည်းဥစ္စာ
3.52	စကြာဝဠာကမ္ဘာမြေ
3.53	သတ္တဝါ
3.56	ကိုယ်ခန္ဓာ
3.57	ဘဝသက်တမ်း
4.11	ကြားဆက်
4.30	စိတ်ခံစားမှု
4.31	ဆုံးဖြတ်
4.32	ခေါ်ဝေါ်
4.33	နှုတ်ဆက်
4.50	တိရစ္တာန်များ၏အော်မြည်သံ
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
21	はい、大学生です。	はい、大学生です。	null		\N	vmod				\N	0
2548	Helo? 	ဟလို။			\N	vmod				\N	1
299	映画を見た。	映画を見た。	null		\N	vmod				\N	0
329	はい、置いてあります。	はい、置いてあります。	null		\N	vmod				\N	0
563	はい。	はい。	null		\N	vmod				\N	0
390	(1)庭の花	(1)庭の花	null		\N	vmod				\N	0
429	氷が水になりました。	氷が水になりました。	null		\N	vmod				\N	0
893	寒くても、泳ぎます。	寒くても、泳ぎます。	null		\N	vmod				\N	0
1469	映画を見た。	映画を見た。	null		\N	vmod				\N	0
844	鈴木さんから電話ですよ。	鈴木さんから電話ですよ。	null		\N	vmod				\N	0
18	山田さんがリーダーです。	山田さんがリーダーです。	null		\N	vmod				\N	0
19	あっ、田中さんが１位です。	あっ、田中さんが１位です。	null		\N	vmod				\N	0
20	中山さんは大学生ですか。	中山さんは大学生ですか。	null		\N	vmod				\N	0
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
1626	お母さんに見つかりました。	お母さんに見つかりました。	null		\N	vmod				\N	0
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
1360	はい、ありました。	はい、ありました。	null		\N	vmod				\N	0
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
1565	山田さんと田中さん	山田さんと田中さん	null		\N	vmod				\N	0
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
1685	田中さんの本	田中さんの本	null		\N	vmod				\N	0
227	いつテニスをしますか。	いつテニスをしますか。	null		\N	vmod				\N	0
228	あしたテニスをします。	あしたテニスをします。	null		\N	vmod				\N	0
229	土曜日、何をしましたか。	土曜日、何をしましたか。	null		\N	vmod				\N	0
230	映画を見ました。	映画を見ました。	null		\N	vmod				\N	0
1765	はい。	はい。	null		\N	vmod				\N	0
231	わたしは夏休みに旅行しました。	わたしは夏休みに旅行しました。	null		\N	vmod				\N	0
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
1819	何が食べたいですか。	何が食べたいですか。	null		\N	vmod				\N	0
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
2368	失礼します。	失礼します。			\N	vmod				\N	0
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
2689	あ、そうですか。	あ、そうですか。			\N	vmod				\N	0
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
2145	たいしたもんだ。	たいしたもんだ。	null		\N	vmod				\N	0
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
2620	はい。	はい。			\N	vmod				\N	0
323	いいえ。まりは今買い物に行っています。	いいえ。まりは今買い物に行っています。	null		\N	vmod				\N	0
324	窓が閉めてあります。	窓が閉めてあります。	null		\N	vmod				\N	0
325	電気が消してありました。	電気が消してありました。	null		\N	vmod				\N	0
326	駅のホームに新しい映画のポスターがはってありました。	駅のホームに新しい映画のポスターがはってありました。	null		\N	vmod				\N	0
327	問題は15ページに書いてあります。	問題は15ページに書いてあります。	null		\N	vmod				\N	0
328	机の上に辞書が置いてありますか。	机の上に辞書が置いてありますか。	null		\N	vmod				\N	0
330	あ、ケーキが切ってありますよ。	あ、ケーキが切ってありますよ。	null		\N	vmod				\N	0
331	じゃあ、食べましょう。	じゃあ、食べましょう。	null		\N	vmod				\N	0
2289	熱いか？	熱いか？	null		\N	vmod				\N	0
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
2342	はい、何でしょう。	はい、何でしょう。			\N	vmod				\N	0
354	わたしの部屋に［机やベッドやテレビ］などがあります。	わたしの部屋に［机やベッドやテレビ］などがあります。	null		\N	vmod				\N	0
355	大きくて黒いかばんはわたしのです。	大きくて黒いかばんはわたしのです。	null		\N	vmod				\N	0
356	きれいで静かなアパートに住んでいます。	きれいで静かなアパートに住んでいます。	null		\N	vmod				\N	0
357	３年生で留学生の金さん	３年生で留学生の金さん	null		\N	vmod				\N	0
1310	あの黒いかばんです。	あの黒いかばんです。	null		\N	vmod				\N	0
2147	これ、プリント、先週の。	これ、プリント、先週の。	null		\N	vmod				\N	0
2403	すみません。	すみません。			\N	vmod				\N	0
359	→(5)木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	→(5)木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	null		\N	vmod				\N	0
360	→(6)田中さんは３年生で、中村さんは４年生です。	→(6)田中さんは３年生で、中村さんは４年生です。	null		\N	vmod				\N	0
2597	先生。	先生。			\N	vmod				\N	0
361	親切でおもしろい人	親切でおもしろい人	null		\N	vmod				\N	0
362	若くてお金持ちの人	若くてお金持ちの人	null		\N	vmod				\N	0
363	この靴下は、じょうぶで安いです。	この靴下は、じょうぶで安いです。	null		\N	vmod				\N	0
2720	ありがとう。	ありがとう。			\N	vmod				\N	0
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
1686	雨の降る日	雨の降る日	null		\N	vmod				\N	0
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
511	わたしを助けてください。	わたしを助けてください。	null		\N	vmod				\N	0
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
587	映画を見に行きませんか。	映画を見に行きませんか。	null		\N	vmod				\N	0
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
1391	７時に起きます。	７時に起きます。	null		\N	vmod				\N	0
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
1687	鈴木さんの言ったこと	鈴木さんの言ったこと	null		\N	vmod				\N	0
633	東京の大学に行きたかったです。	東京の大学に行きたかったです。	null		\N	vmod				\N	0
634	みんなの前で発表したくありませんでした。	みんなの前で発表したくありませんでした。	null		\N	vmod				\N	0
635	駅まで歩きたくなかったです。	駅まで歩きたくなかったです。	null		\N	vmod				\N	0
636	東京の大学に行きたかったです。	東京の大学に行きたかったです。	null		\N	vmod				\N	0
1777	はい、食べましょう。	はい、食べましょう。	null		\N	vmod				\N	0
637	みんなの前で発表したくありませんでした。	みんなの前で発表したくありませんでした。	null		\N	vmod				\N	0
1365	B2：いいえ、まだです。	B2：いいえ、まだです。	null		\N	vmod				\N	0
638	駅まで歩きたくなかったです。	駅まで歩きたくなかったです。	null		\N	vmod				\N	0
639	きのうコンサートに行ってきました。	きのうコンサートに行ってきました。	null		\N	vmod				\N	0
640	そうですか。それはわたしも行きたかったです。	そうですか。それはわたしも行きたかったです。	null		\N	vmod				\N	0
641	わたしは今コンピューターがほしいです。	わたしは今コンピューターがほしいです。	null		\N	vmod				\N	0
697	いいえ、できません。	いいえ、できません。	null		\N	vmod				\N	0
642	わたしはコンピューターはほしくありません。	わたしはコンピューターはほしくありません。	null		\N	vmod				\N	0
643	わたしはコンピューターはほしくないです。	わたしはコンピューターはほしくないです。	null		\N	vmod				\N	0
644	車がほしいですか。	車がほしいですか。	null		\N	vmod				\N	0
645	いいえ、｛ほしくありません／ほしくないです｝。	いいえ、｛ほしくありません／ほしくないです｝。	null		\N	vmod				\N	0
646	太郎さんは犬がほしいですか。	太郎さんは犬がほしいですか。	null		\N	vmod				\N	0
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
2412	税込みですか。	税込みですか。			\N	vmod				\N	0
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
3101	あそこに　郵便局員が　います。	あそこに　郵便局員が　います。	\N		\N	vmod				782	0
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
1185	はい、　大学生です。	はい、　大学生です。	null		\N	vmod				\N	0
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
882	’このボタンを押せば、ドアが開きます。	’このボタンを押せば、ドアが開きます。	null		\N	vmod				\N	0
836	小林さんはかぜをひいているけれども、学校に来ているかもしれません。	小林さんはかぜをひいているけれども、学校に来ているかもしれません。	null		\N	vmod				\N	0
837	’×小林さんはかぜをひいているのに、学校に来ているかもしれません。	’×小林さんはかぜをひいているのに、学校に来ているかもしれません。	null		\N	vmod				\N	0
839	’×日曜日なのに、学校に行きますか。	’×日曜日なのに、学校に行きますか。	null		\N	vmod				\N	0
840	わたしは東京に住んでいるけれども、弟は京都に住んでいます。	わたしは東京に住んでいるけれども、弟は京都に住んでいます。	null		\N	vmod				\N	0
887	毎日、新聞を読めば、覚えることができますよ。	毎日、新聞を読めば、覚えることができますよ。	null		\N	vmod				\N	0
841	’毎日日本語を勉強している｛けれども／けれど／けど／が｝、なかなか漢字が覚えられません。	’毎日日本語を勉強している｛けれども／けれど／けど／が｝、なかなか漢字が覚えられません。	null		\N	vmod				\N	0
842	’山田さんはいつも元気です｛けれども／けれど／けど／が｝、きょうは静かです。	’山田さんはいつも元気です｛けれども／けれど／けど／が｝、きょうは静かです。	null		\N	vmod				\N	0
843	わたしが話しているのに、じゃまをしないでください。	わたしが話しているのに、じゃまをしないでください。	null		\N	vmod				\N	0
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
883	お酒を｛？飲めば／○飲むと／○飲んだら｝、気分が悪くなります。	お酒を｛？飲めば／○飲むと／○飲んだら｝、気分が悪くなります。	null		\N	vmod				\N	0
884	教科書さえ｛○あれば／×あると／？あったら｝、勉強できる。	教科書さえ｛○あれば／×あると／？あったら｝、勉強できる。	null		\N	vmod				\N	0
885	’×あの大学へ行ったら、自転車が便利です。	’×あの大学へ行ったら、自転車が便利です。	null		\N	vmod				\N	0
886	どうすれば、漢字を覚えることができますか。	どうすれば、漢字を覚えることができますか。	null		\N	vmod				\N	0
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
2140	わたしは学生である。	わたしは学生である。	null		\N	vmod				\N	0
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
973	きょうは友だちと夕飯を食べてきました。	きょうは友だちと夕飯を食べてきました。	null		\N	vmod				\N	0
974	高校の友だちがメールを送ってきました。	高校の友だちがメールを送ってきました。	null		\N	vmod				\N	0
975	これからも日本語を勉強していきます。	これからも日本語を勉強していきます。	null		\N	vmod				\N	0
976	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	0
977	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	0
978	木村さんはわたしに古本を売ってきました。　	木村さんはわたしに古本を売ってきました。　	null		\N	vmod				\N	0
979	’わたしは木村さんから古本を買いました。	’わたしは木村さんから古本を買いました。	null		\N	vmod				\N	0
980	来週までにレポートを書いておきます。	来週までにレポートを書いておきます。	null		\N	vmod				\N	0
981	発表のために資料をコピーしておきました。	発表のために資料をコピーしておきました。	null		\N	vmod				\N	0
1183	あっ、田中さんが１位です。	あっ、田中さんが１位です。	null		\N	vmod				\N	0
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
1001	読んどいたよ、あの本。	読んどいたよ、あの本。	null		\N	vmod				\N	0
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
2656	ええっ。	ええっ。			\N	vmod				\N	0
1018	年が明けました。新しい年の始まりです。今年はどんな年になるんだろう。	年が明けました。新しい年の始まりです。今年はどんな年になるんだろう。	null		\N	vmod				\N	0
1019	山田さんはおそばを召し上がりました。	山田さんはおそばを召し上がりました。	null		\N	vmod				\N	0
1230	教室にいます。	教室にいます。	null		\N	vmod				\N	0
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
1093	つまらない仕事などに時間を使いたくありません。	つまらない仕事などに時間を使いたくありません。	null		\N	vmod				\N	0
1094	お茶でも飲みませんか。	お茶でも飲みませんか。	null		\N	vmod				\N	0
1688	田中さんの来たとき	田中さんの来たとき	null		\N	vmod				\N	0
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
1564	庭の花	庭の花	null		\N	vmod				\N	0
1112	それくらいがちょうどいいです。	それくらいがちょうどいいです。	null		\N	vmod				\N	0
1114	あしたは日曜日ですか。	あしたは日曜日ですか。	null		\N	vmod				\N	0
1115	さあ、起きるか。	さあ、起きるか。	null		\N	vmod				\N	0
1116	もう12時か。	もう12時か。	null		\N	vmod				\N	0
1188	学生ではありませんか。	学生ではありませんか。	null		\N	vmod				\N	0
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
1151	ああ、きれいだなあ。	ああ、きれいだなあ。	null		\N	vmod				\N	0
1152	おや、まちがえたかな。	おや、まちがえたかな。	null		\N	vmod				\N	0
1153	あしたは日曜日だな。	あしたは日曜日だな。	null		\N	vmod				\N	0
1154	暑いな。	暑いな。	null		\N	vmod				\N	0
1155	。	。	null		\N	vmod				\N	0
1156	来たのは山田君さ。	来たのは山田君さ。	null		\N	vmod				\N	0
1157	僕がやるぞ。	僕がやるぞ。	null		\N	vmod				\N	0
1158	俺もやるぜ。	俺もやるぜ。	null		\N	vmod				\N	0
1159	よし、やるとも。　	よし、やるとも。　	null		\N	vmod				\N	0
1160	きょうは会議がありましたよね。	きょうは会議がありましたよね。	null		\N	vmod				\N	0
1161	わたしはね、きのうね、新宿へね、行ったんですよ。	わたしはね、きのうね、新宿へね、行ったんですよ。	null		\N	vmod				\N	0
1162	きのうな、新宿へな、……	きのうな、新宿へな、……	null		\N	vmod				\N	0
1163	きのうさ、新宿へさ、……	きのうさ、新宿へさ、……	null		\N	vmod				\N	0
1164	きのうよ、新宿へよ、……	きのうよ、新宿へよ、……	null		\N	vmod				\N	0
1165	朝です。	朝です。	null		\N	vmod				\N	0
1166	朝ではありません。	朝ではありません。	null		\N	vmod				\N	0
1167	学生です。	学生です。	null		\N	vmod				\N	0
1168	学生ではありません。	学生ではありません。	null		\N	vmod				\N	0
1169	春です。	春です。	null		\N	vmod				\N	0
1170	春ではありません。	春ではありません。	null		\N	vmod				\N	0
1171	田中です。	田中です。	null		\N	vmod				\N	0
1172	キムです。	キムです。	null		\N	vmod				\N	0
1173	朝ではないです。	朝ではないです。	null		\N	vmod				\N	0
1174	学生ではないです。	学生ではないです。	null		\N	vmod				\N	0
1175	田中さんは学生です。	田中さんは学生です。	null		\N	vmod				\N	0
1583	山田さんが本を読みました。	山田さんが本を読みました。	null		\N	vmod				\N	0
1177	わたしが田中です。	わたしが田中です。	null		\N	vmod				\N	0
1179	父は先生ではありません。	父は先生ではありません。	null		\N	vmod				\N	0
1182	山田さんがリーダーです。	山田さんがリーダーです。	null		\N	vmod				\N	0
1184	中山さんは大学生ですか。	中山さんは大学生ですか。	null		\N	vmod				\N	0
1186	田中さんですか。	田中さんですか。	null		\N	vmod				\N	0
1187	はい、田中です。	はい、田中です。	null		\N	vmod				\N	0
1189	はい、学生ではありません。	はい、学生ではありません。	null		\N	vmod				\N	0
1190	田中さんですか。	田中さんですか。	null		\N	vmod				\N	0
1191	いいえ、　山口です。	いいえ、　山口です。	null		\N	vmod				\N	0
1192	学生ではありませんか。	学生ではありませんか。	null		\N	vmod				\N	0
1193	いいえ、　学生です。	いいえ、　学生です。	null		\N	vmod				\N	0
1195	むかし、　ここは　公園でした。	むかし、　ここは　公園でした。	null		\N	vmod				\N	0
1196	父は先生でした。	父は先生でした。	null		\N	vmod				\N	0
1197	お昼はおにぎりではありませんでした。	お昼はおにぎりではありませんでした。	null		\N	vmod				\N	0
1198	きのうは休みでしたか。	きのうは休みでしたか。	null		\N	vmod				\N	0
1199	いいえ、休みではありませんでした。	いいえ、休みではありませんでした。	null		\N	vmod				\N	0
1200	きのうは　休みでは　なかったです。	きのうは　休みでは　なかったです。	null		\N	vmod				\N	0
1201	木があります。	木があります。	null		\N	vmod				\N	0
1202	本があります。	本があります。	null		\N	vmod				\N	0
1203	犬がいます。	犬がいます。	null		\N	vmod				\N	0
1204	田中さんがいます。	田中さんがいます。	null		\N	vmod				\N	0
1205	ペンがありますか。	ペンがありますか。	null		\N	vmod				\N	0
1206	はい、あります。	はい、あります。	null		\N	vmod				\N	0
1207	いいえ、ありません。	いいえ、ありません。	null		\N	vmod				\N	0
1208	山田さん、いますか。	山田さん、いますか。	null		\N	vmod				\N	0
1209	はい、います。	はい、います。	null		\N	vmod				\N	0
1210	いいえ、いません。	いいえ、いません。	null		\N	vmod				\N	0
1211	何がありますか。	何がありますか。	null		\N	vmod				\N	0
1212	ノートが　あります。	ノートが　あります。	null		\N	vmod				\N	0
1213	誰がいましたか。	誰がいましたか。	null		\N	vmod				\N	0
1214	田中さんがいました。	田中さんがいました。	null		\N	vmod				\N	0
1215	誰がいましたか。	誰がいましたか。	null		\N	vmod				\N	0
1216	誰もいませんでした。	誰もいませんでした。	null		\N	vmod				\N	0
1217	ペンがありますか。	ペンがありますか。	null		\N	vmod				\N	0
1218	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	0
1219	先生、　来週　漢字の　試験が　ありますか。	先生、　来週　漢字の　試験が　ありますか。	null		\N	vmod				\N	0
1220	はい、あります。水曜日ですよ。	はい、あります。水曜日ですよ。	null		\N	vmod				\N	0
1221	部屋に　パソコンが　あります。	部屋に　パソコンが　あります。	null		\N	vmod				\N	0
1223	家に　犬が　います。	家に　犬が　います。	null		\N	vmod				\N	0
1225	パソコンは部屋にあります。	パソコンは部屋にあります。	null		\N	vmod				\N	0
1226	田中さんは教室にいます。	田中さんは教室にいます。	null		\N	vmod				\N	0
1227	パソコンはどこにありますか。	パソコンはどこにありますか。	null		\N	vmod				\N	0
1228	部屋にあります。	部屋にあります。	null		\N	vmod				\N	0
1231	みなさん、　質問が　ありますか。	みなさん、　質問が　ありますか。	null		\N	vmod				\N	0
1234	太郎さんには子どもがいます。	太郎さんには子どもがいます。	null		\N	vmod				\N	0
1235	公園でロックコンサートがありました。	公園でロックコンサートがありました。	null		\N	vmod				\N	0
1236	机の上	机の上	null		\N	vmod				\N	0
1237	机の下	机の下	null		\N	vmod				\N	0
1238	家の前	家の前	null		\N	vmod				\N	0
1239	家のうしろ	家のうしろ	null		\N	vmod				\N	0
1240	教室の中	教室の中	null		\N	vmod				\N	0
1241	教室の外	教室の外	null		\N	vmod				\N	0
1242	田中さんの右	田中さんの右	null		\N	vmod				\N	0
1243	田中さんの左	田中さんの左	null		\N	vmod				\N	0
1252	埼玉は　東京の　北に　あります。	埼玉は　東京の　北に　あります。	null		\N	vmod				\N	0
1253	田中さんは　教室の　中に　います。	田中さんは　教室の　中に　います。	null		\N	vmod				\N	0
1256	山田さんのとなりは田中さんです。	山田さんのとなりは田中さんです。	null		\N	vmod				\N	0
1260	体育館の　となりに　プールが　あります。	体育館の　となりに　プールが　あります。	null		\N	vmod				\N	0
1261	はさみは　机の　上に　あります。	はさみは　机の　上に　あります。	null		\N	vmod				\N	0
1262	田中さんのとなりに木村さんがいます。	田中さんのとなりに木村さんがいます。	null		\N	vmod				\N	0
1263	あれは　数学の　教科書です。	あれは　数学の　教科書です。	null		\N	vmod				\N	0
1265	２階です。	２階です。	null		\N	vmod				\N	0
1266	これは誰のかばんですか。	これは誰のかばんですか。	null		\N	vmod				\N	0
1267	わたしのです。	わたしのです。	null		\N	vmod				\N	0
1269	きのうのです。	きのうのです。	null		\N	vmod				\N	0
1180	Sekolah cuti. 	ကျောင်း ပိတ်တယ်။	null		\N	vmod				\N	1
1270	わたしのはどこにありますか。	わたしのはどこにありますか。	null		\N	vmod				\N	0
1271	わたしは東京外国語大学の木村です。	わたしは東京外国語大学の木村です。	null		\N	vmod				\N	0
1364	B1：はい、もう終わりました。	B1：はい、もう終わりました。	null		\N	vmod				\N	0
2273	もう12時か。	もう12時か。	null		\N	vmod				\N	0
1272	日本には、　春と　夏と　秋と　冬の　４つの　季節が　あります。	日本には、　春と　夏と　秋と　冬の　４つの　季節が　あります。	null		\N	vmod				\N	0
1273	この　人は　友だちの　田中さんです。	この　人は　友だちの　田中さんです。	null		\N	vmod				\N	0
1277	すてきな絵ですね。	すてきな絵ですね。	null		\N	vmod				\N	0
1278	ようかんは　どんな　食べ物ですか。	ようかんは　どんな　食べ物ですか。	null		\N	vmod				\N	0
1279	あまいおかしです。	あまいおかしです。	null		\N	vmod				\N	0
1283	じょうぶなかばんです。	じょうぶなかばんです。	null		\N	vmod				\N	0
1284	どんなCDがありますか。	どんなCDがありますか。	null		\N	vmod				\N	0
1285	静かな　音楽の　CDが　あります。	静かな　音楽の　CDが　あります。	null		\N	vmod				\N	0
1287	黒いのを買います。	黒いのを買います。	null		\N	vmod				\N	0
1288	どんな　音楽が　すきですか。	どんな　音楽が　すきですか。	null		\N	vmod				\N	0
1289	静かなのがすきです。	静かなのがすきです。	null		\N	vmod				\N	0
1290	これは　日本語の　教科書です。	これは　日本語の　教科書です。	null		\N	vmod				\N	0
1292	あれは　体育館です。	あれは　体育館です。	null		\N	vmod				\N	0
1293	ここは　１年生の　教室です。	ここは　１年生の　教室です。	null		\N	vmod				\N	0
1294	そこは　図書室です。	そこは　図書室です。	null		\N	vmod				\N	0
1295	あそこは　事務室です。	あそこは　事務室です。	null		\N	vmod				\N	0
1298	この　部屋は　２年生の　教室です。	この　部屋は　２年生の　教室です。	null		\N	vmod				\N	0
1300	先生はあの人です。	先生はあの人です。	null		\N	vmod				\N	0
1301	あの　きれいな　女の人は　山本さんです。	あの　きれいな　女の人は　山本さんです。	null		\N	vmod				\N	0
1711	かしこまりました。	かしこまりました。	null		\N	vmod				\N	0
1303	田中さんの消しゴムはどれですか。	田中さんの消しゴムはどれですか。	null		\N	vmod				\N	0
1304	それです。	それです。	null		\N	vmod				\N	0
1306	あそこです。	あそこです。	null		\N	vmod				\N	0
1307	ありがとうございました。	ありがとうございました。	null		\N	vmod				\N	0
1313	あそこです。	あそこです。	null		\N	vmod				\N	0
1314	わたしのぼうしはどこにありますか。	わたしのぼうしはどこにありますか。	null		\N	vmod				\N	0
1315	そこにあります。	そこにあります。	null		\N	vmod				\N	0
1316	どこですか。	どこですか。	null		\N	vmod				\N	0
1317	あなたのうしろです。	あなたのうしろです。	null		\N	vmod				\N	0
1318	あそこに　かさが　５本　あります。	あそこに　かさが　５本　あります。	null		\N	vmod				\N	0
1321	100円です。	100円です。	null		\N	vmod				\N	0
1324	ボールが　いくつ　ありますか。	ボールが　いくつ　ありますか。	null		\N	vmod				\N	0
1325	15あります。	15あります。	null		\N	vmod				\N	0
1327	３枚　あります。	３枚　あります。	null		\N	vmod				\N	0
1328	そこに　ハンカチが　どのくらい　ありますか。	そこに　ハンカチが　どのくらい　ありますか。	null		\N	vmod				\N	0
1329	30枚くらい　あります。	30枚くらい　あります。	null		\N	vmod				\N	0
1331	今、何時ですか。	今、何時ですか。	null		\N	vmod				\N	0
1336	5月21日です。	5月21日です。	null		\N	vmod				\N	0
1337	あしたは　何曜日ですか。	あしたは　何曜日ですか。	null		\N	vmod				\N	0
1338	日曜日です。	日曜日です。	null		\N	vmod				\N	0
1339	わたしは毎日勉強します。	わたしは毎日勉強します。	null		\N	vmod				\N	0
1340	わたしは　毎日　勉強しません。	わたしは　毎日　勉強しません。	null		\N	vmod				\N	0
1342	田中さんは教室にいます。	田中さんは教室にいます。	null		\N	vmod				\N	0
1343	田中さんは　これから　図書館で　勉強します。	田中さんは　これから　図書館で　勉強します。	null		\N	vmod				\N	0
1344	わたしはあした研究室にいます。	わたしはあした研究室にいます。	null		\N	vmod				\N	0
1345	あしたパーティーがあります。	あしたパーティーがあります。	null		\N	vmod				\N	0
1346	わたしはあした研究室にいません。	わたしはあした研究室にいません。	null		\N	vmod				\N	0
1347	あした、小説家の山口さんが来ます。	あした、小説家の山口さんが来ます。	null		\N	vmod				\N	0
1351	熱が　ありますから、　休みます。	熱が　ありますから、　休みます。	null		\N	vmod				\N	0
1353	テレビはピアノのそばにありますか。	テレビはピアノのそばにありますか。	null		\N	vmod				\N	0
1354	田中さんは教室にいますか。	田中さんは教室にいますか。	null		\N	vmod				\N	0
1355	これから図書館で勉強しますか。	これから図書館で勉強しますか。	null		\N	vmod				\N	0
1357	むかし、　学校の　門の　そばに　大きい　木が　ありました。	むかし、　学校の　門の　そばに　大きい　木が　ありました。	null		\N	vmod				\N	0
1358	きのうは　雨が　降りませんでした。	きのうは　雨が　降りませんでした。	null		\N	vmod				\N	0
1359	きのう地震がありましたか。	きのう地震がありましたか。	null		\N	vmod				\N	0
569	はい。	はい。	null		\N	vmod				\N	0
1361	試験は終わりましたか。	試験は終わりましたか。	null		\N	vmod				\N	0
1362	はい、終わりました。	はい、終わりました。	null		\N	vmod				\N	0
1366	学校へ行きます。	学校へ行きます。	null		\N	vmod				\N	0
1368	公園へ行きますか。	公園へ行きますか。	null		\N	vmod				\N	0
1370	わたしは　ハンバーガーを　食べます。	わたしは　ハンバーガーを　食べます。	null		\N	vmod				\N	0
1372	CDを買います。	CDを買います。	null		\N	vmod				\N	0
1373	切手を　3枚　買います。	切手を　3枚　買います。	null		\N	vmod				\N	0
1374	何を食べますか。	何を食べますか。	null		\N	vmod				\N	0
1375	サンドイッチを食べます。	サンドイッチを食べます。	null		\N	vmod				\N	0
1376	あした映画を見ますか。	あした映画を見ますか。	null		\N	vmod				\N	0
1377	いいえ、見ません。	いいえ、見ません。	null		\N	vmod				\N	0
1381	佐藤さんにプレゼントをあげます。	佐藤さんにプレゼントをあげます。	null		\N	vmod				\N	0
1383	木村さんに　フランス語を　習います。	木村さんに　フランス語を　習います。	null		\N	vmod				\N	0
1384	佐藤さんにプレゼントをもらいます。	佐藤さんにプレゼントをもらいます。	null		\N	vmod				\N	0
1385	壁にシールをはります。	壁にシールをはります。	null		\N	vmod				\N	0
1387	山田さんに本を見せます。	山田さんに本を見せます。	null		\N	vmod				\N	0
1390	何時に起きますか。	何時に起きますか。	null		\N	vmod				\N	0
1394	あしたテニスをします。	あしたテニスをします。	null		\N	vmod				\N	0
1395	土曜日、　何を　しましたか。	土曜日、　何を　しましたか。	null		\N	vmod				\N	0
1399	この　りんごは　甘いです。	この　りんごは　甘いです。	null		\N	vmod				\N	0
1400	あの　りんごは　甘く　ありません。	あの　りんごは　甘く　ありません。	null		\N	vmod				\N	0
1404	甘いです。	甘いです。	null		\N	vmod				\N	0
1405	大きいです。	大きいです。	null		\N	vmod				\N	0
1406	勉強は　おもしろいですか。	勉強は　おもしろいですか。	null		\N	vmod				\N	0
1407	はい、　おもしろいです。	はい、　おもしろいです。	null		\N	vmod				\N	0
1411	はい、寒いです。	はい、寒いです。	null		\N	vmod				\N	0
1412	外は寒いですか。	外は寒いですか。	null		\N	vmod				\N	0
1413	いいえ、寒くありません。	いいえ、寒くありません。	null		\N	vmod				\N	0
1415	おいしいです。	おいしいです。	null		\N	vmod				\N	0
1416	どんなかばんですか。	どんなかばんですか。	null		\N	vmod				\N	0
1417	赤いです。	赤いです。	null		\N	vmod				\N	0
1420	きのうは　寒くなかったです。	きのうは　寒くなかったです。	null		\N	vmod				\N	0
1832	車がほしいですか。	車がほしいですか。	null		\N	vmod				\N	0
1421	北海道はどうでしたか。	北海道はどうでしたか。	null		\N	vmod				\N	0
1422	   B:寒かったです。	   B:寒かったです。	null		\N	vmod				\N	0
1424	   B:おもしろくありませんでした。	   B:おもしろくありませんでした。	null		\N	vmod				\N	0
1462	その　ケーキは　おいしかった。	その　ケーキは　おいしかった。	null		\N	vmod				\N	0
1425	太郎君の　犬は　とても　大きいです。	太郎君の　犬は　とても　大きいです。	null		\N	vmod				\N	0
1430	あまり　勉強しません。	あまり　勉強しません。	null		\N	vmod				\N	0
1432	きょうは　暑い　日です。	きょうは　暑い　日です。	null		\N	vmod				\N	0
1436	きょうはハッピーな日です。	きょうはハッピーな日です。	null		\N	vmod				\N	0
1437	この　かさは　じょうぶです。	この　かさは　じょうぶです。	null		\N	vmod				\N	0
1438	その　かさは　じょうぶですか。	その　かさは　じょうぶですか。	null		\N	vmod				\N	0
1439	いいえ、じょうぶではありません。	いいえ、じょうぶではありません。	null		\N	vmod				\N	0
1440	田中さんは　元気でしたか。	田中さんは　元気でしたか。	null		\N	vmod				\N	0
1441	はい、　元気でした。	はい、　元気でした。	null		\N	vmod				\N	0
1442	いいえ、　元気ではありませんでした。	いいえ、　元気ではありませんでした。	null		\N	vmod				\N	0
1443	このかさはじょうぶではないです。	このかさはじょうぶではないです。	null		\N	vmod				\N	0
1444	田中さんは　元気ではなかったです。	田中さんは　元気ではなかったです。	null		\N	vmod				\N	0
1445	田中さんは　髪が　長いです。	田中さんは　髪が　長いです。	null		\N	vmod				\N	0
1447	中山さんは　力が　強いです。	中山さんは　力が　強いです。	null		\N	vmod				\N	0
1448	うちの　猫は　目が　きれいです。	うちの　猫は　目が　きれいです。	null		\N	vmod				\N	0
1452	田中さん、だいじょうぶですか。	田中さん、だいじょうぶですか。	null		\N	vmod				\N	0
1453	ちょっと　気分が　悪いです。	ちょっと　気分が　悪いです。	null		\N	vmod				\N	0
1456	田中さんはバスケットボールがじょうずです。	田中さんはバスケットボールがじょうずです。	null		\N	vmod				\N	0
1458	わたしはピアノが得意です。	わたしはピアノが得意です。	null		\N	vmod				\N	0
1463	公園は　静かだった。	公園は　静かだった。	null		\N	vmod				\N	0
1464	あの　電子辞書は　便利ではなかった。	あの　電子辞書は　便利ではなかった。	null		\N	vmod				\N	0
1465	わたしは大学生だ。	わたしは大学生だ。	null		\N	vmod				\N	0
1466	木村さんは先生ではない。	木村さんは先生ではない。	null		\N	vmod				\N	0
1467	ここはむかし公園だった。	ここはむかし公園だった。	null		\N	vmod				\N	0
1468	山田さんは　病気ではなかった。	山田さんは　病気ではなかった。	null		\N	vmod				\N	0
1470	この　雑誌は　新しい。	この　雑誌は　新しい。	null		\N	vmod				\N	0
1471	あの　電子辞書は　便利だ。	あの　電子辞書は　便利だ。	null		\N	vmod				\N	0
1472	きょうは雨だ。	きょうは雨だ。	null		\N	vmod				\N	0
1475	あしたは　雨が　降るでしょう。	あしたは　雨が　降るでしょう。	null		\N	vmod				\N	0
1479	雨が降ったので試合が中止になりました。	雨が降ったので試合が中止になりました。	null		\N	vmod				\N	0
1480	雨が　降ったけれども　試合を　しました。	雨が　降ったけれども　試合を　しました。	null		\N	vmod				\N	0
1483	６時に起きて、ジョギングをしました。	６時に起きて、ジョギングをしました。	null		\N	vmod				\N	0
1486	もう一度　言って　くださいませんか。	もう一度　言って　くださいませんか。	null		\N	vmod				\N	0
1487	あした、休んでもいいですか。	あした、休んでもいいですか。	null		\N	vmod				\N	0
1488	本を読んであげます。	本を読んであげます。	null		\N	vmod				\N	0
1489	ビールを買っていきます。	ビールを買っていきます。	null		\N	vmod				\N	0
1490	食べてみます。	食べてみます。	null		\N	vmod				\N	0
1493	ごはんを　食べて　います。	ごはんを　食べて　います。	null		\N	vmod				\N	0
1498	木村さんをお願いします。	木村さんをお願いします。	null		\N	vmod				\N	0
1499	木村さんは　今　食事を　しています。	木村さんは　今　食事を　しています。	null		\N	vmod				\N	0
1500	体育館の　前に　小林さんが　立って　います。	体育館の　前に　小林さんが　立って　います。	null		\N	vmod				\N	0
1502	山田先生を　知って　いますか。	山田先生を　知って　いますか。	null		\N	vmod				\N	0
1504	わたしは　毎朝　ジョギングを　して　います。	わたしは　毎朝　ジョギングを　して　います。	null		\N	vmod				\N	0
1505	わたしは　３年前　アメリカで　勉強して　います。	わたしは　３年前　アメリカで　勉強して　います。	null		\N	vmod				\N	0
1936	この　絵は　まるで　写真のようです。	この　絵は　まるで　写真のようです。	null		\N	vmod				\N	0
1506	山田さんは　10年前に　大学を　卒業して　います。	山田さんは　10年前に　大学を　卒業して　います。	null		\N	vmod				\N	0
1508	ビルがそびえています。	ビルがそびえています。	null		\N	vmod				\N	0
1509	山田さんは　お父さんに　似ています。	山田さんは　お父さんに　似ています。	null		\N	vmod				\N	0
1510	もしもし、　まりさんは　いますか。	もしもし、　まりさんは　いますか。	null		\N	vmod				\N	0
1511	 B：いいえ。まりは今買い物に行っています。	 B：いいえ。まりは今買い物に行っています。	null		\N	vmod				\N	0
1514	駅の　ホームに　新しい　映画の　ポスターが　はって　ありました。	駅の　ホームに　新しい　映画の　ポスターが　はって　ありました。	null		\N	vmod				\N	0
1516	机の　上に　辞書が　置いて　ありますか。	机の　上に　辞書が　置いて　ありますか。	null		\N	vmod				\N	0
1517	はい、　置いて　あります。	はい、　置いて　あります。	null		\N	vmod				\N	0
1518	あ、　ケーキが　切って　ありますよ。	あ、　ケーキが　切って　ありますよ。	null		\N	vmod				\N	0
1519	じゃあ、食べましょう。	じゃあ、食べましょう。	null		\N	vmod				\N	0
1521	小林さんに　来週の　予定を　話して　ありますか。	小林さんに　来週の　予定を　話して　ありますか。	null		\N	vmod				\N	0
1522	いいえ、まだです。	いいえ、まだです。	null		\N	vmod				\N	0
1523	漢字を調べてありますか。	漢字を調べてありますか。	null		\N	vmod				\N	0
1524	はい、調べました。	はい、調べました。	null		\N	vmod				\N	0
1525	田中さんと　山田さんは　大学２年生です。	田中さんと　山田さんは　大学２年生です。	null		\N	vmod				\N	0
1526	わたしは　パンと　サラダを　食べます。	わたしは　パンと　サラダを　食べます。	null		\N	vmod				\N	0
1529	わたしは　日曜日に　漫画や　雑誌を　読みます。	わたしは　日曜日に　漫画や　雑誌を　読みます。	null		\N	vmod				\N	0
1536	３年生で留学生の金さん	３年生で留学生の金さん	null		\N	vmod				\N	0
1613	木村さんに本をあげます。	木村さんに本をあげます。	null		\N	vmod				\N	0
1538	木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。	null		\N	vmod				\N	0
1539	田中さんは３年生で、中村さんは４年生です。	田中さんは３年生で、中村さんは４年生です。	null		\N	vmod				\N	0
1540	親切でおもしろい人	親切でおもしろい人	null		\N	vmod				\N	0
1541	若くてお金持ちの人	若くてお金持ちの人	null		\N	vmod				\N	0
1543	田中さんは　背が　高くて　めがねを　かけて　います。	田中さんは　背が　高くて　めがねを　かけて　います。	null		\N	vmod				\N	0
1550	雨が　降ったり　やんだり　して　います。	雨が　降ったり　やんだり　して　います。	null		\N	vmod				\N	0
1552	あしたの　予定を　教えて　ください。	あしたの　予定を　教えて　ください。	null		\N	vmod				\N	0
1554	わたしは　日本へ　行って、　すもうを　見たいです。	わたしは　日本へ　行って、　すもうを　見たいです。	null		\N	vmod				\N	0
1555	２つに　折って、　はさみで　切って　ください。	２つに　折って、　はさみで　切って　ください。	null		\N	vmod				\N	0
1559	夏休みに　中山さんは　海で　ダイビングを　して、　山本さんは　山に　登りました。	夏休みに　中山さんは　海で　ダイビングを　して、　山本さんは　山に　登りました。	null		\N	vmod				\N	0
1560	田中さんは　東京に　住んで　いて、　山本さんは　大阪に　住んで　います。	田中さんは　東京に　住んで　いて、　山本さんは　大阪に　住んで　います。	null		\N	vmod				\N	0
1561	雨が降って、野球の試合を中止しました。	雨が降って、野球の試合を中止しました。	null		\N	vmod				\N	0
1563	田中さんが来て、木村さんが帰りました。	田中さんが来て、木村さんが帰りました。	null		\N	vmod				\N	0
1566	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	0
1567	本を読みます。	本を読みます。	null		\N	vmod				\N	0
1568	10時から　授業を　始めます。	10時から　授業を　始めます。	null		\N	vmod				\N	0
1569	朝　起きて　顔を　洗います。	朝　起きて　顔を　洗います。	null		\N	vmod				\N	0
1570	春に　なると、　暖かく　なります。	春に　なると、　暖かく　なります。	null		\N	vmod				\N	0
1571	雨が降ったら運動会は休みです。	雨が降ったら運動会は休みです。	null		\N	vmod				\N	0
1572	この本は読みました。	この本は読みました。	null		\N	vmod				\N	0
1573	この本も読みました。	この本も読みました。	null		\N	vmod				\N	0
1574	この本だけ読みました。	この本だけ読みました。	null		\N	vmod				\N	0
1575	この本ばかり読みました。	この本ばかり読みました。	null		\N	vmod				\N	0
1576	この本まで読みました。	この本まで読みました。	null		\N	vmod				\N	0
1577	この本など読みました。	この本など読みました。	null		\N	vmod				\N	0
1578	あしたは日曜日ですか。	あしたは日曜日ですか。	null		\N	vmod				\N	0
1579	あしたは日曜日ですよ。	あしたは日曜日ですよ。	null		\N	vmod				\N	0
1580	あしたは日曜日ですね。	あしたは日曜日ですね。	null		\N	vmod				\N	0
1581	あなた に だけ は 話しましょう。	あなた に だけ は 話しましょう。	null		\N	vmod				\N	0
1582	きょうの　テストは　３時からですよね。	きょうの　テストは　３時からですよね。	null		\N	vmod				\N	0
1584	先生に相談します。	先生に相談します。	null		\N	vmod				\N	0
1585	学校へ行きます。	学校へ行きます。	null		\N	vmod				\N	0
1587	佐藤さんは鈴木さんより年上です。	佐藤さんは鈴木さんより年上です。	null		\N	vmod				\N	0
1589	机の上	机の上	null		\N	vmod				\N	0
1590	田中さんと山田さんが来ました。	田中さんと山田さんが来ました。	null		\N	vmod				\N	0
1591	佐藤さんや田中さんが来ました。	佐藤さんや田中さんが来ました。	null		\N	vmod				\N	0
1593	田中さんが最初です。	田中さんが最初です。	null		\N	vmod				\N	0
1594	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	0
1595	コンピューターがほしいです。	コンピューターがほしいです。	null		\N	vmod				\N	0
1596	ふるさとがなつかしいです。	ふるさとがなつかしいです。	null		\N	vmod				\N	0
1597	水｛が/を｝飲みたいです。	水｛が/を｝飲みたいです。	null		\N	vmod				\N	0
1598	英語｛が/を｝話せます。	英語｛が/を｝話せます。	null		\N	vmod				\N	0
1600	わたし、大学へ行きます。	わたし、大学へ行きます。	null		\N	vmod				\N	0
1602	十字路を　右に　曲がります。	十字路を　右に　曲がります。	null		\N	vmod				\N	0
1603	毎日　この　道を　通ります。	毎日　この　道を　通ります。	null		\N	vmod				\N	0
1604	大学を　卒業します。	大学を　卒業します。	null		\N	vmod				\N	0
1606	楽しい　一日を　過ごしました。	楽しい　一日を　過ごしました。	null		\N	vmod				\N	0
1607	あらしの　中を　走りました。	あらしの　中を　走りました。	null		\N	vmod				\N	0
1608	拍手の中を歩きました。	拍手の中を歩きました。	null		\N	vmod				\N	0
1610	パン、食べました。	パン、食べました。	null		\N	vmod				\N	0
1611	山田さんにプレゼントを贈ります。	山田さんにプレゼントを贈ります。	null		\N	vmod				\N	0
1612	田中さんに　英語を　教えます。	田中さんに　英語を　教えます。	null		\N	vmod				\N	0
1616	犬が山田さんにほえました。	犬が山田さんにほえました。	null		\N	vmod				\N	0
1617	東京に行きます。	東京に行きます。	null		\N	vmod				\N	0
1618	家に帰ります。	家に帰ります。	null		\N	vmod				\N	0
1620	駅の　前に　集まります。	駅の　前に　集まります。	null		\N	vmod				\N	0
1621	氷が水になりました。	氷が水になりました。	null		\N	vmod				\N	0
1622	山田さんは子どもを政治家にしました。	山田さんは子どもを政治家にしました。	null		\N	vmod				\N	0
1623	山田さんに　本を　読ませます。	山田さんに　本を　読ませます。	null		\N	vmod				\N	0
1624	先生にほめられました。	先生にほめられました。	null		\N	vmod				\N	0
1627	木村さんに　英語を　教わりました。	木村さんに　英語を　教わりました。	null		\N	vmod				\N	0
1628	山田さんはお父さんに似ています。	山田さんはお父さんに似ています。	null		\N	vmod				\N	0
1629	この　ズボンは　わたしには　大きすぎます。	この　ズボンは　わたしには　大きすぎます。	null		\N	vmod				\N	0
2049	あした雨が降れば、運動会は中止です。	あした雨が降れば、運動会は中止です。	null		\N	vmod				\N	0
1631	１回に　３袋ずつ　使います。	１回に　３袋ずつ　使います。	null		\N	vmod				\N	0
1632	教室に　佐藤さんが　います。	教室に　佐藤さんが　います。	null		\N	vmod				\N	0
1633	机の上に本があります。	机の上に本があります。	null		\N	vmod				\N	0
1635	大学の　近くに　家を　建てます。	大学の　近くに　家を　建てます。	null		\N	vmod				\N	0
1639	買い物に　行きます。	買い物に　行きます。	null		\N	vmod				\N	0
1641	えんぴつは　字を　書くのに　使います。	えんぴつは　字を　書くのに　使います。	null		\N	vmod				\N	0
1642	山田さんに佐藤さんに田中さんが来ました。	山田さんに佐藤さんに田中さんが来ました。	null		\N	vmod				\N	0
1643	人の多さにびっくりしました。	人の多さにびっくりしました。	null		\N	vmod				\N	0
1644	カラオケで　歌いに　歌って、　声が　出なく　なりました。	カラオケで　歌いに　歌って、　声が　出なく　なりました。	null		\N	vmod				\N	0
1689	佐藤さんは鈴木さんと学校に行きました。	佐藤さんは鈴木さんと学校に行きました。	null		\N	vmod				\N	0
1648	大人から　子どもまで　人気が　あります。	大人から　子どもまで　人気が　あります。	null		\N	vmod				\N	0
1649	この　店は、　おかしから　チケットまで、　なんでも　売って　います。	この　店は、　おかしから　チケットまで、　なんでも　売って　います。	null		\N	vmod				\N	0
1651	あしたから夏休みです。	あしたから夏休みです。	null		\N	vmod				\N	0
1652	ぶどうからワインを作ります。	ぶどうからワインを作ります。	null		\N	vmod				\N	0
1653	田中さんから本を贈りました。	田中さんから本を贈りました。	null		\N	vmod				\N	0
1655	わたしから説明します。	わたしから説明します。	null		\N	vmod				\N	0
1656	鈴木さんから説明させました。	鈴木さんから説明させました。	null		\N	vmod				\N	0
1657	先生からほめられました。	先生からほめられました。	null		\N	vmod				\N	0
1658	白線より　中に　入らないで　ください。	白線より　中に　入らないで　ください。	null		\N	vmod				\N	0
1659	これより会議を始めます。	これより会議を始めます。	null		\N	vmod				\N	0
1661	世界で　一番　長い　川は　ナイル川です。	世界で　一番　長い　川は　ナイル川です。	null		\N	vmod				\N	0
1662	日本では、　３月と　４月と　５月は　春です。	日本では、　３月と　４月と　５月は　春です。	null		\N	vmod				\N	0
1664	これで十分です。	これで十分です。	null		\N	vmod				\N	0
1665	あしたでも　いいです。	あしたでも　いいです。	null		\N	vmod				\N	0
1666	これではだめです。	これではだめです。	null		\N	vmod				\N	0
1669	佐藤さんは　大きい　声で　話します。	佐藤さんは　大きい　声で　話します。	null		\N	vmod				\N	0
1670	木で机を作ります。	木で机を作ります。	null		\N	vmod				\N	0
1673	子どもがはだしで歩いています。	子どもがはだしで歩いています。	null		\N	vmod				\N	0
1674	子どもが　はだかで　走って　います。	子どもが　はだかで　走って　います。	null		\N	vmod				\N	0
1676	家族　全員で　ドライブ　しました。	家族　全員で　ドライブ　しました。	null		\N	vmod				\N	0
72	机の上	机の上	null		\N	vmod				\N	0
1677	日本語が１年間でじょうずになりました。	日本語が１年間でじょうずになりました。	null		\N	vmod				\N	0
1678	この　コンピューターを　20万円で　買いました。	この　コンピューターを　20万円で　買いました。	null		\N	vmod				\N	0
2103	小林さんに手伝ってもらいました。	小林さんに手伝ってもらいました。	null		\N	vmod				\N	0
1680	２と３で５です。	２と３で５です。	null		\N	vmod				\N	0
1681	警察で事件を調べています。	警察で事件を調べています。	null		\N	vmod				\N	0
1684	庭の花	庭の花	null		\N	vmod				\N	0
1690	田中さんは山田さんと結婚しました。	田中さんは山田さんと結婚しました。	null		\N	vmod				\N	0
1691	田中さんはお父さんと似ています。	田中さんはお父さんと似ています。	null		\N	vmod				\N	0
1695	毎日ジョギングをする人はえらいと思います。	毎日ジョギングをする人はえらいと思います。	null		\N	vmod				\N	0
1698	はい。	はい。	null		\N	vmod				\N	0
1699	ハンバーガーとサラダをお願いします。	ハンバーガーとサラダをお願いします。	null		\N	vmod				\N	0
1700	はい。	はい。	null		\N	vmod				\N	0
1701	書類の　コピーを　ください。	書類の　コピーを　ください。	null		\N	vmod				\N	0
1702	すみません、水をくださいませんか。	すみません、水をくださいませんか。	null		\N	vmod				\N	0
1704	あのう、　この　町の　地図を　くださいませんか。	あのう、　この　町の　地図を　くださいませんか。	null		\N	vmod				\N	0
1705	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	0
1706	りんご、ください。	りんご、ください。	null		\N	vmod				\N	0
1707	ハンバーグ、ください。	ハンバーグ、ください。	null		\N	vmod				\N	0
1708	赤い　ばらを　８本　ください。	赤い　ばらを　８本　ください。	null		\N	vmod				\N	0
1709	はい。1200円です。	はい。1200円です。	null		\N	vmod				\N	0
1712	教科書の　15ページを　見て　ください。	教科書の　15ページを　見て　ください。	null		\N	vmod				\N	0
1713	テープの　会話を　聞いて　ください。	テープの　会話を　聞いて　ください。	null		\N	vmod				\N	0
2272	さあ、　起きるか。	さあ、　起きるか。	null		\N	vmod				\N	0
1716	３年生は　手を　あげて　ください。	３年生は　手を　あげて　ください。	null		\N	vmod				\N	0
1717	２年生は、あした８時に学校へ来てください。	２年生は、あした８時に学校へ来てください。	null		\N	vmod				\N	0
1718	どうかゆるしてください。	どうかゆるしてください。	null		\N	vmod				\N	0
1719	わたしを助けてください。	わたしを助けてください。	null		\N	vmod				\N	0
1721	あした　電話を　して　ください。	あした　電話を　して　ください。	null		\N	vmod				\N	0
1722	がんばってください。	がんばってください。	null		\N	vmod				\N	0
1723	安心してください。	安心してください。	null		\N	vmod				\N	0
1724	ぜひ来てください。	ぜひ来てください。	null		\N	vmod				\N	0
1725	もう一度説明してくださいませんか。	もう一度説明してくださいませんか。	null		\N	vmod				\N	0
1726	すみません、　窓を　開けて　くださいませんか。	すみません、　窓を　開けて　くださいませんか。	null		\N	vmod				\N	0
1771	いっしょに昼ごはんを食べませんか。	いっしょに昼ごはんを食べませんか。	null		\N	vmod				\N	0
1729	この　コピー機は　学生が　使っても　いいですよ。	この　コピー機は　学生が　使っても　いいですよ。	null		\N	vmod				\N	0
1730	これを借りてもいいですか。	これを借りてもいいですか。	null		\N	vmod				\N	0
1731	はい、どうぞ。	はい、どうぞ。	null		\N	vmod				\N	0
1732	この　辞書を　借りても　いいですか。	この　辞書を　借りても　いいですか。	null		\N	vmod				\N	0
1735	いいえ。	いいえ。	null		\N	vmod				\N	0
2255	山田さんさえいたら、この試合には勝てるのに。	山田さんさえいたら、この試合には勝てるのに。	null		\N	vmod				\N	0
1736	辞書を　見ても　いいですか。　	辞書を　見ても　いいですか。　	null		\N	vmod				\N	0
1737	いいえ、いけません。	いいえ、いけません。	null		\N	vmod				\N	0
2039	卒業論文を　出せば、　卒業できます。	卒業論文を　出せば、　卒業できます。	null		\N	vmod				\N	0
1739	この　部屋で　たばこを　すっては　いけません。	この　部屋で　たばこを　すっては　いけません。	null		\N	vmod				\N	0
1740	しばらく　お酒を　飲んでは　だめです。	しばらく　お酒を　飲んでは　だめです。	null		\N	vmod				\N	0
1741	この教室は使っちゃいけませんよ。	この教室は使っちゃいけませんよ。	null		\N	vmod				\N	0
1742	泣いちゃだめですよ。	泣いちゃだめですよ。	null		\N	vmod				\N	0
1743	木村さん、その本を借りてはいけませんか。	木村さん、その本を借りてはいけませんか。	null		\N	vmod				\N	0
1744	ここでは　たばこを　すわないで　ください。	ここでは　たばこを　すわないで　ください。	null		\N	vmod				\N	0
1746	宿題を忘れないでください。	宿題を忘れないでください。	null		\N	vmod				\N	0
1747	はい、わかりました。	はい、わかりました。	null		\N	vmod				\N	0
1749	どうかおこらないでください。	どうかおこらないでください。	null		\N	vmod				\N	0
1750	わたしを殺さないでください。	わたしを殺さないでください。	null		\N	vmod				\N	0
1751	不合格にしないでください。	不合格にしないでください。	null		\N	vmod				\N	0
1752	だいじょうぶです。心配しないでください。	だいじょうぶです。心配しないでください。	null		\N	vmod				\N	0
1753	あまり無理をしないでください。	あまり無理をしないでください。	null		\N	vmod				\N	0
1754	気にしないでください。	気にしないでください。	null		\N	vmod				\N	0
1755	どうぞ　遠慮しないで　ください。	どうぞ　遠慮しないで　ください。	null		\N	vmod				\N	0
1756	ペンでもいいですか。	ペンでもいいですか。	null		\N	vmod				\N	0
1757	B1：はい、いいです。	B1：はい、いいです。	null		\N	vmod				\N	0
1758	B2：いいえ、だめです。	B2：いいえ、だめです。	null		\N	vmod				\N	0
1759	レポートはあしたでもいいですか。	レポートはあしたでもいいですか。	null		\N	vmod				\N	0
1760	B1：はい、あしたでもいいです。	B1：はい、あしたでもいいです。	null		\N	vmod				\N	0
1761	B2：いいえ、あしたではだめです。	B2：いいえ、あしたではだめです。	null		\N	vmod				\N	0
1834	誕生日に何がほしいですか。	誕生日に何がほしいですか。	null		\N	vmod				\N	0
1762	パーティーは、ジーンズではいけません。	パーティーは、ジーンズではいけません。	null		\N	vmod				\N	0
1763	この試験は、えんぴつではだめです。	この試験は、えんぴつではだめです。	null		\N	vmod				\N	0
1764	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	0
1766	スケートに行きませんか。	スケートに行きませんか。	null		\N	vmod				\N	0
1767	いいですね。	いいですね。	null		\N	vmod				\N	0
1769	すみません。　土曜日は　仕事が　あります。	すみません。　土曜日は　仕事が　あります。	null		\N	vmod				\N	0
1772	少し　休みませんか。	少し　休みませんか。	null		\N	vmod				\N	0
1773	いっしょに帰りましょう。	いっしょに帰りましょう。	null		\N	vmod				\N	0
1775	信号が　青に　なりました。　さあ、　渡りましょう。	信号が　青に　なりました。　さあ、　渡りましょう。	null		\N	vmod				\N	0
1776	いっしょに昼ごはんを食べませんか。	いっしょに昼ごはんを食べませんか。	null		\N	vmod				\N	0
1779	いいですね。行きましょう。	いいですね。行きましょう。	null		\N	vmod				\N	0
2440	ああ、　行ったけど。	ああ、　行ったけど。			\N	vmod				\N	0
1780	食事の　前には　手を　洗いましょう。	食事の　前には　手を　洗いましょう。	null		\N	vmod				\N	0
1781	手を　あげて　横断歩道を　渡りましょう。	手を　あげて　横断歩道を　渡りましょう。	null		\N	vmod				\N	0
1782	いっしょに帰りませんか。	いっしょに帰りませんか。	null		\N	vmod				\N	0
1783	ええ、帰りましょう。	ええ、帰りましょう。	null		\N	vmod				\N	0
1784	スケートに行きませんか。	スケートに行きませんか。	null		\N	vmod				\N	0
1785	いいですね。行きましょう。	いいですね。行きましょう。	null		\N	vmod				\N	0
1786	土曜日の午後、テニスをしませんか。	土曜日の午後、テニスをしませんか。	null		\N	vmod				\N	0
1787	土曜日ですか。土曜日はちょっと。	土曜日ですか。土曜日はちょっと。	null		\N	vmod				\N	0
1788	あした、　うちへ　遊びに　来ませんか。	あした、　うちへ　遊びに　来ませんか。	null		\N	vmod				\N	0
1789	ありがとう　ございます。　でも、　あしたは　ちょっと。	ありがとう　ございます。　でも、　あしたは　ちょっと。	null		\N	vmod				\N	0
1790	映画を見に行きませんか。	映画を見に行きませんか。	null		\N	vmod				\N	0
1791	すみません。アルバイトがあります。	すみません。アルバイトがあります。	null		\N	vmod				\N	0
1792	きょうから日記を書こう。	きょうから日記を書こう。	null		\N	vmod				\N	0
1793	きょうは　食堂で　昼食を　食べよう。	きょうは　食堂で　昼食を　食べよう。	null		\N	vmod				\N	0
1795	図書館でいっしょに勉強しましょう。	図書館でいっしょに勉強しましょう。	null		\N	vmod				\N	0
1796	あしたもう一度来よう。	あしたもう一度来よう。	null		\N	vmod				\N	0
1797	家に　帰ったら　掃除しよう。	家に　帰ったら　掃除しよう。	null		\N	vmod				\N	0
1798	この　辺で　休みましょう。	この　辺で　休みましょう。	null		\N	vmod				\N	0
1800	わたしは６時に帰ります。	わたしは６時に帰ります。	null		\N	vmod				\N	0
1812	わたしは　今度の　休みに　友だちと　旅行したいです。	わたしは　今度の　休みに　友だちと　旅行したいです。	null		\N	vmod				\N	0
1814	将来、何になりたいですか。	将来、何になりたいですか。	null		\N	vmod				\N	0
1815	日本語の先生になりたいです。	日本語の先生になりたいです。	null		\N	vmod				\N	0
1816	どんな　音楽を　聞きたいですか。	どんな　音楽を　聞きたいですか。	null		\N	vmod				\N	0
1820	そうですね、サンドイッチが食べたいです。	そうですね、サンドイッチが食べたいです。	null		\N	vmod				\N	0
1821	すみません、　山田先生と　話したいんですが。	すみません、　山田先生と　話したいんですが。	null		\N	vmod				\N	0
1822	はい、　ちょっと　待って　ください。	はい、　ちょっと　待って　ください。	null		\N	vmod				\N	0
1823	先生、お手洗いに行きたいんですが。	先生、お手洗いに行きたいんですが。	null		\N	vmod				\N	0
1825	山田さんは　旅行したがって　います。	山田さんは　旅行したがって　います。	null		\N	vmod				\N	0
1827	みんなの　前で　発表したく　ありませんでした。	みんなの　前で　発表したく　ありませんでした。	null		\N	vmod				\N	0
1828	駅まで　歩きたくなかったです。	駅まで　歩きたくなかったです。	null		\N	vmod				\N	0
1829	きのうコンサートに行ってきました。	きのうコンサートに行ってきました。	null		\N	vmod				\N	0
1830	そうですか。　それは　わたしも　行きたかったです。	そうですか。　それは　わたしも　行きたかったです。	null		\N	vmod				\N	0
1833	いいえ、｛ほしくありません／ほしくないです｝。	いいえ、｛ほしくありません／ほしくないです｝。	null		\N	vmod				\N	0
682	K先生がこわいです。	K先生がこわいです。	null		\N	vmod				\N	0
719	たぶん田中さんでしょう。	たぶん田中さんでしょう。	null		\N	vmod				\N	0
1059	雨が降れば運動会を中止します。	雨が降れば運動会を中止します。	null		\N	vmod				\N	0
1497	すみません、今使っています。	すみません、今使っています。	null		\N	vmod				\N	0
1663	片道で100円、往復で200円です。	片道で100円、往復で200円です。	null		\N	vmod				\N	0
1733	すみません。今使っています。	すみません。今使っています。	null		\N	vmod				\N	0
1770	あした、映画を見に行きませんか。	あした、映画を見に行きませんか。	null		\N	vmod				\N	0
2416	はい。	はい。			\N	vmod				\N	0
1835	そうですね、　新しい　自転車が　ほしいです。	そうですね、　新しい　自転車が　ほしいです。	null		\N	vmod				\N	0
1838	わたしはコンピューターはほしくありません。	わたしはコンピューターはほしくありません。	null		\N	vmod				\N	0
1839	わたしはコンピューターはほしくないです。	わたしはコンピューターはほしくないです。	null		\N	vmod				\N	0
1840	太郎さんは犬がほしいですか。	太郎さんは犬がほしいですか。	null		\N	vmod				\N	0
1842	太郎さんはコンピューターがほしいようです。	太郎さんはコンピューターがほしいようです。	null		\N	vmod				\N	0
1843	すみません、　白い　紙が　ほしいんですが。	すみません、　白い　紙が　ほしいんですが。	null		\N	vmod				\N	0
1844	はい。	はい。	null		\N	vmod				\N	0
1845	あのう、　赤い　ボールペンが　ほしいんですが。	あのう、　赤い　ボールペンが　ほしいんですが。	null		\N	vmod				\N	0
1846	はい。	はい。	null		\N	vmod				\N	0
1847	太郎さんは新しいコンピューターをほしがっています。	太郎さんは新しいコンピューターをほしがっています。	null		\N	vmod				\N	0
1850	田中さんはテニスがすきですか。	田中さんはテニスがすきですか。	null		\N	vmod				\N	0
1851	はい、すきです。	はい、すきです。	null		\N	vmod				\N	0
1852	水泳はすきですか。	水泳はすきですか。	null		\N	vmod				\N	0
1854	何がすきですか。	何がすきですか。	null		\N	vmod				\N	0
1855	りんごがすきです。	りんごがすきです。	null		\N	vmod				\N	0
1856	どの科目がすきですか。	どの科目がすきですか。	null		\N	vmod				\N	0
1857	数学がすきです。	数学がすきです。	null		\N	vmod				\N	0
1858	わたしは　犬が　きらいです。	わたしは　犬が　きらいです。	null		\N	vmod				\N	0
1859	わたしは犬がきらいではありません。	わたしは犬がきらいではありません。	null		\N	vmod				\N	0
1861	わたしは犬がこわいです。	わたしは犬がこわいです。	null		\N	vmod				\N	0
1863	わたしは試験の結果が心配です。	わたしは試験の結果が心配です。	null		\N	vmod				\N	0
1864	わたしはつらいです。	わたしはつらいです。	null		\N	vmod				\N	0
1865	わたしは仕事がつらいです。	わたしは仕事がつらいです。	null		\N	vmod				\N	0
1866	あなたは　地震が　こわいですか。	あなたは　地震が　こわいですか。	null		\N	vmod				\N	0
1867	K先生がこわいです。	K先生がこわいです。	null		\N	vmod				\N	0
1868	田中くんは犬がこわいそうです。	田中くんは犬がこわいそうです。	null		\N	vmod				\N	0
1869	田中くんは犬がこわいらしいです。	田中くんは犬がこわいらしいです。	null		\N	vmod				\N	0
1870	田中くんは犬がこわかった。	田中くんは犬がこわかった。	null		\N	vmod				\N	0
1871	田中くんは　いつも　犬を　こわがります。	田中くんは　いつも　犬を　こわがります。	null		\N	vmod				\N	0
1872	田中くんは犬をこわがっています。	田中くんは犬をこわがっています。	null		\N	vmod				\N	0
1874	２年生は５時から体育館を使うことができます。	２年生は５時から体育館を使うことができます。	null		\N	vmod				\N	0
1875	きょうは、バスケットボールの練習をすることができません。	きょうは、バスケットボールの練習をすることができません。	null		\N	vmod				\N	0
1876	中山さんは　200メートル　泳ぐ　ことが　できます。	中山さんは　200メートル　泳ぐ　ことが　できます。	null		\N	vmod				\N	0
1877	わたしは漢字を50書くことができます。	わたしは漢字を50書くことができます。	null		\N	vmod				\N	0
1878	中山さんは　アラビア語を　話す　ことが　できますか。	中山さんは　アラビア語を　話す　ことが　できますか。	null		\N	vmod				\N	0
1880	キムさんは　日本語が　できます。 	キムさんは　日本語が　できます。 	null		\N	vmod				\N	0
1882	わたしは車の運転ができません。	わたしは車の運転ができません。	null		\N	vmod				\N	0
1884	はい、できます。	はい、できます。	null		\N	vmod				\N	0
1886	わたしはさしみが食べられます。	わたしはさしみが食べられます。	null		\N	vmod				\N	0
1887	あした学校に来られます。	あした学校に来られます。	null		\N	vmod				\N	0
1888	水泳ができます。	水泳ができます。	null		\N	vmod				\N	0
1963	あしたの授業で使う本	あしたの授業で使う本	null		\N	vmod				\N	0
1889	パーティーに来られますか。	パーティーに来られますか。	null		\N	vmod				\N	0
1890	B1：はい、行けます。	B1：はい、行けます。	null		\N	vmod				\N	0
1891	B2：いいえ、行けません。	B2：いいえ、行けません。	null		\N	vmod				\N	0
1892	図書館で勉強できます。	図書館で勉強できます。	null		\N	vmod				\N	0
1893	彼を一生愛せますか。	彼を一生愛せますか。	null		\N	vmod				\N	0
1894	あしたは　晴れるでしょう。	あしたは　晴れるでしょう。	null		\N	vmod				\N	0
1895	きょうの試合では、Aチームが勝つでしょう。	きょうの試合では、Aチームが勝つでしょう。	null		\N	vmod				\N	0
1937	小林さんは　鳥のような　声で　歌います。	小林さんは　鳥のような　声で　歌います。	null		\N	vmod				\N	0
2257	５分ほど　まって　ください。	５分ほど　まって　ください。	null		\N	vmod				\N	0
2258	そのくらいの　ことは　自分で　できます。	そのくらいの　ことは　自分で　できます。	null		\N	vmod				\N	0
2259	山田さんくらい　頭の　いい　人は　いません。	山田さんくらい　頭の　いい　人は　いません。	null		\N	vmod				\N	0
2260	富士山は　エベレストほど　高くは　ありません。	富士山は　エベレストほど　高くは　ありません。	null		\N	vmod				\N	0
2261	君にだけ話しましょう。	君にだけ話しましょう。	null		\N	vmod				\N	0
2262	太郎君とさえ話ができなかった。	太郎君とさえ話ができなかった。	null		\N	vmod				\N	0
2263	君だけに話しましょう。	君だけに話しましょう。	null		\N	vmod				\N	0
2264	それくらいが　ちょうどいいです。	それくらいが　ちょうどいいです。	null		\N	vmod				\N	0
2265	言うのです。	言うのです。	null		\N	vmod				\N	0
2266	あしたは日曜日ですか。	あしたは日曜日ですか。	null		\N	vmod				\N	0
2267	あしたは日曜日かしら。	あしたは日曜日かしら。	null		\N	vmod				\N	0
2268	さわるな。	さわるな。	null		\N	vmod				\N	0
2269	あしたは日曜日ですよ。	あしたは日曜日ですよ。	null		\N	vmod				\N	0
2270	わたしも　そう　思いますね。	わたしも　そう　思いますね。	null		\N	vmod				\N	0
2271	ああ、　きれいだなあ。	ああ、　きれいだなあ。	null		\N	vmod				\N	0
2274	あなたも　二十歳に　なりましたか。	あなたも　二十歳に　なりましたか。	null		\N	vmod				\N	0
2275	だいじょうぶか。	だいじょうぶか。	null		\N	vmod				\N	0
2276	本か。	本か。	null		\N	vmod				\N	0
2277	熱いですか。	熱いですか。	null		\N	vmod				\N	0
2278	だいじょうぶですか。	だいじょうぶですか。	null		\N	vmod				\N	0
2279	これは本ですか。	これは本ですか。	null		\N	vmod				\N	0
2280	田中さんはあした来るでしょうか。	田中さんはあした来るでしょうか。	null		\N	vmod				\N	0
2281	熱い？	熱い？	null		\N	vmod				\N	0
2282	どれが　大きい？	どれが　大きい？	null		\N	vmod				\N	0
2283	だいじょうぶ？	だいじょうぶ？	null		\N	vmod				\N	0
2284	どの部屋が静か？	どの部屋が静か？	null		\N	vmod				\N	0
2285	これは、本？　	これは、本？　	null		\N	vmod				\N	0
2286	どなたが　山田さん？	どなたが　山田さん？	null		\N	vmod				\N	0
2287	田中さんはあした来る？	田中さんはあした来る？	null		\N	vmod				\N	0
2288	田中さんは　いつ　来る？	田中さんは　いつ　来る？	null		\N	vmod				\N	0
2290	だいじょうぶか？	だいじょうぶか？	null		\N	vmod				\N	0
2291	これは本か？	これは本か？	null		\N	vmod				\N	0
2292	田中さんはあした来るか？	田中さんはあした来るか？	null		\N	vmod				\N	0
2293	熱い｛だろうか/かな/のかな/かしら｝？　	熱い｛だろうか/かな/のかな/かしら｝？　	null		\N	vmod				\N	0
2294	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？	null		\N	vmod				\N	0
2295	経済の　状態は　よくなるか、　それが　問題です。	経済の　状態は　よくなるか、　それが　問題です。	null		\N	vmod				\N	0
2296	山田さんは、眠くなったのか、目をこすっています。	山田さんは、眠くなったのか、目をこすっています。	null		\N	vmod				\N	0
2297	買い物に　出かけましたが、　何を　買うか、　どこで　買うか、　わからなく　なって　困りました。	買い物に　出かけましたが、　何を　買うか、　どこで　買うか、　わからなく　なって　困りました。	null		\N	vmod				\N	0
2299	早く行きましょうよ。	早く行きましょうよ。	null		\N	vmod				\N	0
2300	早く　やって　くださいよ。	早く　やって　くださいよ。	null		\N	vmod				\N	0
2301	３時ですね。	３時ですね。	null		\N	vmod				\N	0
2302	あしたは日曜日ですね。	あしたは日曜日ですね。	null		\N	vmod				\N	0
2303	暑いですね。	暑いですね。	null		\N	vmod				\N	0
2304	おや、まちがえたかな。	おや、まちがえたかな。	null		\N	vmod				\N	0
2305	あしたは日曜日だな。	あしたは日曜日だな。	null		\N	vmod				\N	0
2306	暑いな。	暑いな。	null		\N	vmod				\N	0
2307	。	。	null		\N	vmod				\N	0
2308	来たのは山田君さ。	来たのは山田君さ。	null		\N	vmod				\N	0
2309	僕がやるぞ。	僕がやるぞ。	null		\N	vmod				\N	0
2310	俺もやるぜ。	俺もやるぜ。	null		\N	vmod				\N	0
2311	よし、　やるとも。　	よし、　やるとも。　	null		\N	vmod				\N	0
2312	きのう、コンサートに行きましたの。	きのう、コンサートに行きましたの。	null		\N	vmod				\N	0
2313	きょうは会議がありましたよね。	きょうは会議がありましたよね。	null		\N	vmod				\N	0
2314	わたしはね、きのうね、新宿へね、行ったんですよ。	わたしはね、きのうね、新宿へね、行ったんですよ。	null		\N	vmod				\N	0
2315	きのうな、新宿へな、……	きのうな、新宿へな、……	null		\N	vmod				\N	0
2316	きのうさ、新宿へさ、……	きのうさ、新宿へさ、……	null		\N	vmod				\N	0
2317	きのうよ、新宿へよ、……	きのうよ、新宿へよ、……	null		\N	vmod				\N	0
2318	あ、斉藤先生。	あ、斉藤先生。			\N	vmod				\N	0
2319	おはようございます。	おはようございます。	 ①おはようございます　②挨拶をする　③おはよう（ございます）(朝)：こんにちは(昼)：こんばんは(夜)　④　山田さんこんにちは。		\N	vmod				\N	0
1932	わたしは　きょう　早く　学校に　行けそうです。	わたしは　きょう　早く　学校に　行けそうです。	null		\N	vmod				\N	0
1992	木村さんが　来るのを　待ちます。	木村さんが　来るのを　待ちます。	null		\N	vmod				\N	0
2320	おはよう。	おはよう。	①おはようございます　②挨拶をする　③おはよう（ございます）(朝)：こんにちは(昼)：こんばんは(夜)　④　山田さんこんにちは。		\N	vmod				\N	0
2321	先生、　今日は　朝から　授業ですか。	先生、　今日は　朝から　授業ですか。			\N	vmod				\N	0
2322	いいえ、午前中に会議があるんです。	いいえ、午前中に会議があるんです。			\N	vmod				\N	0
2323	山田君は。	山田君は。			\N	vmod				\N	0
2387	でも、本当にいただいていいの。	でも、本当にいただいていいの。			\N	vmod				\N	0
1938	このロボットは、生きているように動きます。	このロボットは、生きているように動きます。	null		\N	vmod				\N	0
1941	あの人はまるで歌手のようです。	あの人はまるで歌手のようです。	null		\N	vmod				\N	0
1943	天気予報に　よると、　あしたは　雨が　降るそうです。	天気予報に　よると、　あしたは　雨が　降るそうです。	null		\N	vmod				\N	0
1944	木村さんが　電話に　出ない。　出かけて　いるらしい。	木村さんが　電話に　出ない。　出かけて　いるらしい。	null		\N	vmod				\N	0
2563	明日のボート大会のことですけど。	明日のボート大会のことですけど。			\N	vmod				\N	0
1945	山田さんは　来月　東京に　行くらしいです。	山田さんは　来月　東京に　行くらしいです。	null		\N	vmod				\N	0
1946	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。	null		\N	vmod				\N	0
1948	うわさによると、山田さんは来月東京に行くらしいです。	うわさによると、山田さんは来月東京に行くらしいです。	null		\N	vmod				\N	0
1949	歌舞伎は　おもしろいと　思います。	歌舞伎は　おもしろいと　思います。	null		\N	vmod				\N	0
1950	わたしはあした雨が降ると思います。	わたしはあした雨が降ると思います。	null		\N	vmod				\N	0
1951	田中さんは　もう　帰ったと　思います。	田中さんは　もう　帰ったと　思います。	null		\N	vmod				\N	0
1952	あしたも寒いと思いますか。	あしたも寒いと思いますか。	null		\N	vmod				\N	0
1953	ええ、　たぶん。	ええ、　たぶん。	null		\N	vmod				\N	0
1954	彼は　スポーツが　得意だと　思います。	彼は　スポーツが　得意だと　思います。	null		\N	vmod				\N	0
1955	彼は　スポーツが　得意ではないと　思います。	彼は　スポーツが　得意ではないと　思います。	null		\N	vmod				\N	0
1956	彼は　スポーツが　得意だと　思いません。	彼は　スポーツが　得意だと　思いません。	null		\N	vmod				\N	0
1957	わたしのペン	わたしのペン	null		\N	vmod				\N	0
1958	体育館のとなり	体育館のとなり	null		\N	vmod				\N	0
1959	新しいコンピューター	新しいコンピューター	null		\N	vmod				\N	0
1960	小さい犬	小さい犬	null		\N	vmod				\N	0
1961	元気な人	元気な人	null		\N	vmod				\N	0
1962	すてきな絵	すてきな絵	null		\N	vmod				\N	0
1964	あれは　わたしが　通った　学校です。	あれは　わたしが　通った　学校です。	null		\N	vmod				\N	0
1966	すみません、わたしです。	すみません、わたしです。	null		\N	vmod				\N	0
1968	○×△美術館へ行ったことがない人は、手をあげてください。	○×△美術館へ行ったことがない人は、手をあげてください。	null		\N	vmod				\N	0
1969	（手をあげて）はい。	（手をあげて）はい。	null		\N	vmod				\N	0
1970	わたしは、ビートルズが作った曲がすきです。	わたしは、ビートルズが作った曲がすきです。	null		\N	vmod				\N	0
1972	先月　卒業パーティーを　した　レストランは、　ここです。	先月　卒業パーティーを　した　レストランは、　ここです。	null		\N	vmod				\N	0
1973	きのう　書いた　作文を　きょう　提出しました。	きのう　書いた　作文を　きょう　提出しました。	null		\N	vmod				\N	0
1975	きのうわたしが行った店	きのうわたしが行った店	null		\N	vmod				\N	0
1976	お父さんが病院に勤めている山本さん	お父さんが病院に勤めている山本さん	null		\N	vmod				\N	0
1977	コーヒーは飲んで、紅茶は飲まない人	コーヒーは飲んで、紅茶は飲まない人	null		\N	vmod				\N	0
1978	赤いセーターを着た先生	赤いセーターを着た先生	null		\N	vmod				\N	0
1979	こわれたコンピューター	こわれたコンピューター	null		\N	vmod				\N	0
1980	本を読んでいる人	本を読んでいる人	null		\N	vmod				\N	0
1981	授業で使う本	授業で使う本	null		\N	vmod				\N	0
1982	わたしが通う学校	わたしが通う学校	null		\N	vmod				\N	0
1983	田中さんが合格した話	田中さんが合格した話	null		\N	vmod				\N	0
1984	人が勉強しているとなりでおしゃべりをする。	人が勉強しているとなりでおしゃべりをする。	null		\N	vmod				\N	0
1985	魚を焼くにおい	魚を焼くにおい	null		\N	vmod				\N	0
1986	頭のよくなるくすり	頭のよくなるくすり	null		\N	vmod				\N	0
1987	［外国語を勉強する{こと／の}］は楽しいです。	［外国語を勉強する{こと／の}］は楽しいです。	null		\N	vmod				\N	0
1988	［学生が優秀な{こと／の}］が田中先生の自慢です。	［学生が優秀な{こと／の}］が田中先生の自慢です。	null		\N	vmod				\N	0
1989	［山田さんが合格した{こと／の}］をきょう知りました。	［山田さんが合格した{こと／の}］をきょう知りました。	null		\N	vmod				\N	0
1991	山田さんが　本を　読んで　いるのが　聞こえます。	山田さんが　本を　読んで　いるのが　聞こえます。	null		\N	vmod				\N	0
1994	きのう行ったのは京都です。	きのう行ったのは京都です。	null		\N	vmod				\N	0
1995	大学に進学することを勧めます。	大学に進学することを勧めます。	null		\N	vmod				\N	0
1996	わたしはアメリカに留学することを考えています。	わたしはアメリカに留学することを考えています。	null		\N	vmod				\N	0
1998	お母さんが　買ってきたのを　食べました。	お母さんが　買ってきたのを　食べました。	null		\N	vmod				\N	0
1999	雨が降ったので試合が中止になりました。	雨が降ったので試合が中止になりました。	null		\N	vmod				\N	0
2000	もう　遅いので、　これで　帰ります。	もう　遅いので、　これで　帰ります。	null		\N	vmod				\N	0
2032	鈴木さんから電話ですよ。	鈴木さんから電話ですよ。	null		\N	vmod				\N	0
2001	この　カメラが　便利なので、　これに　しませんか。	この　カメラが　便利なので、　これに　しませんか。	null		\N	vmod				\N	0
2002	あしたが提出日ですので、気をつけてください。	あしたが提出日ですので、気をつけてください。	null		\N	vmod				\N	0
2003	きのうは　祭日でしたから、　学校は　休みでした。	きのうは　祭日でしたから、　学校は　休みでした。	null		\N	vmod				\N	0
2006	もうだいじょうぶですから、心配しないでください。	もうだいじょうぶですから、心配しないでください。	null		\N	vmod				\N	0
2008	小林さんに聞きました。	小林さんに聞きました。	null		\N	vmod				\N	0
2009	田中さんもあした来ますか。	田中さんもあした来ますか。	null		\N	vmod				\N	0
2010	いいえ、来ません。	いいえ、来ません。	null		\N	vmod				\N	0
2012	病気だからです。	病気だからです。	null		\N	vmod				\N	0
2013	どうして　「蛍の光」が　流れて　いるのですか。	どうして　「蛍の光」が　流れて　いるのですか。	null		\N	vmod				\N	0
2014	図書館が　閉まるからです。	図書館が　閉まるからです。	null		\N	vmod				\N	0
2015	雨が降って試合が中止になりました。	雨が降って試合が中止になりました。	null		\N	vmod				\N	0
2016	かぜで　休みました。	かぜで　休みました。	null		\N	vmod				\N	0
2020	一生懸命勉強したのに試験に落ちました。	一生懸命勉強したのに試験に落ちました。	null		\N	vmod				\N	0
2021	この　メロンは　大きいのに　安いです。	この　メロンは　大きいのに　安いです。	null		\N	vmod				\N	0
2022	毎日　日本語を　勉強して　いるけれども、　なかなか　漢字が　覚えられません。	毎日　日本語を　勉強して　いるけれども、　なかなか　漢字が　覚えられません。	null		\N	vmod				\N	0
2025	さっき　食べたのに　もう　おなかが　すきました。	さっき　食べたのに　もう　おなかが　すきました。	null		\N	vmod				\N	0
2026	雨が降ったけれども予定通り運動会をしました。	雨が降ったけれども予定通り運動会をしました。	null		\N	vmod				\N	0
2027	もう　夜の　12時だけれども、　もう　少し　勉強しよう。	もう　夜の　12時だけれども、　もう　少し　勉強しよう。	null		\N	vmod				\N	0
2028	小林さんは　かぜを　ひいて　いるけれども、　学校に　来て　いるかも　しれません。	小林さんは　かぜを　ひいて　いるけれども、　学校に　来て　いるかも　しれません。	null		\N	vmod				\N	0
2029	日曜日　だけれども、　学校に　行きますか。	日曜日　だけれども、　学校に　行きますか。	null		\N	vmod				\N	0
2031	わたしが　話して　いるのに、　じゃまを　しないで　ください。	わたしが　話して　いるのに、　じゃまを　しないで　ください。	null		\N	vmod				\N	0
2033	えっ、もう夜の11時なのに。	えっ、もう夜の11時なのに。	null		\N	vmod				\N	0
2034	レポートの　ことですけれども、　来週の　月曜日に　提出して　ください。	レポートの　ことですけれども、　来週の　月曜日に　提出して　ください。	null		\N	vmod				\N	0
2035	日本中を　旅行しましたけれども、　京都が　一番　すきです。	日本中を　旅行しましたけれども、　京都が　一番　すきです。	null		\N	vmod				\N	0
2036	すみませんが、　郵便局は　この　辺ですか。	すみませんが、　郵便局は　この　辺ですか。	null		\N	vmod				\N	0
2038	雨が　降ると、　雪が　解けます。	雨が　降ると、　雪が　解けます。	null		\N	vmod				\N	0
2448	じゃあ、私もタイにしようかなあ。	じゃあ、私もタイにしようかなあ。			\N	vmod				\N	0
2449	すみません。	すみません。			\N	vmod				\N	0
2451	図書館は　夏休み中も　開いて　いますか。	図書館は　夏休み中も　開いて　いますか。			\N	vmod				\N	0
2452	ええ、　開いて　いますよ。	ええ、　開いて　いますよ。			\N	vmod				\N	0
2453	何時から　開いて　いますか。	何時から　開いて　いますか。	 ①何時から開いていますか。②情報を求める(程度)③何時から～か。　　　　　　　　　　　　　　④映画は何時から始まりますか。		\N	vmod				\N	0
2454	9時からです。	9時からです。			\N	vmod				\N	0
2455	自習室は何時まで使えますか。	自習室は何時まで使えますか。	 ①何時まで使えますか。②情報を求める(程度)③何時まで～か。　　　　　　　　　　　　　　④図書館は何時まで開いていますか。		\N	vmod				\N	0
2456	5時まで使えます。	5時まで使えます。			\N	vmod				\N	0
2457	土日も使えますか。	土日も使えますか。			\N	vmod				\N	0
2458	夏休み中は、土日はお休みなんです。	夏休み中は、土日はお休みなんです。			\N	vmod				\N	0
2459	ありがとうございます。	ありがとうございます。			\N	vmod				\N	0
2460	はい、どうぞ。	はい、どうぞ。			\N	vmod				\N	0
2461	ちょっと伺いたいのですが。	ちょっと伺いたいのですが。			\N	vmod				\N	0
2462	何でしょう。	何でしょう。			\N	vmod				\N	0
2463	この　図書館は　初めてなのですが、　本は　一度に　何冊まで　借りられますか。	この　図書館は　初めてなのですが、　本は　一度に　何冊まで　借りられますか。	①一度に何冊　②情報を求める(数字)　③（期間／回数）に(数量)　　　　　　　　　　　　　　④一週間に何日大学に行きますか。		\N	vmod				\N	0
2464	10冊まで　借りられます。	10冊まで　借りられます。			\N	vmod				\N	0
2465	大学院生も　同じですか。	大学院生も　同じですか。			\N	vmod				\N	0
2466	いえ、　大学院生は、　一ヶ月に　20冊まで　借りられます。	いえ、　大学院生は、　一ヶ月に　20冊まで　借りられます。			\N	vmod				\N	0
2467	どれぐらい　借りられますか。	どれぐらい　借りられますか。	 ①どれくらい②情報を求める(数字)③どのぐらい～ですか。　　　　　　　　　　　　　　④どれぐらい使えますか。		\N	vmod				\N	0
2468	2週間です。	2週間です。			\N	vmod				\N	0
2469	分かりました。	分かりました。			\N	vmod				\N	0
2472	レポートの　締め切りは　今月　20日ですよ。	レポートの　締め切りは　今月　20日ですよ。			\N	vmod				\N	0
2474	先生、期末レポートはメールでお送りしてもいいですか。	先生、期末レポートはメールでお送りしてもいいですか。			\N	vmod				\N	0
2475	メールねえ。	メールねえ。			\N	vmod				\N	0
2476	いや、　やっぱり、　メールは　困るなあ。	いや、　やっぱり、　メールは　困るなあ。			\N	vmod				\N	0
2477	いちいちプリントアウトしなければいけないからね。	いちいちプリントアウトしなければいけないからね。			\N	vmod				\N	0
2478	郵便で20日までに送ってください。	郵便で20日までに送ってください。	①送ってください。②何でどのようにするかを言う。③(何をどのように)　　　　　　　　　　　　　　～てくさい。④明日まで電話でお知らせください。 		\N	vmod				\N	0
2479	わかりました。	わかりました。			\N	vmod				\N	0
2480	では、郵便でご自宅にお送りします。	では、郵便でご自宅にお送りします。	 ①お送りします。②何でどのようにするかを言う。　　　　　　　　　　　　　　③(何をどのように)します。④金曜日までメールで連絡します。 		\N	vmod				\N	0
2481	そうして　ください。	そうして　ください。			\N	vmod				\N	0
2483	渡辺さんは、アメリカに留学していましたね。	渡辺さんは、アメリカに留学していましたね。			\N	vmod				\N	0
2484	ええ、　学部の　時、　半年間　ボストンに　住んで　いました。	ええ、　学部の　時、　半年間　ボストンに　住んで　いました。			\N	vmod				\N	0
2507	じゃあ、どうしようかなあ。	じゃあ、どうしようかなあ。			\N	vmod				\N	0
2485	じゃあ、　英語は　話せますか。	じゃあ、　英語は　話せますか。	①英語は話せますか。②能力について尋ねる。③～はできますか。　　　　　　　　　　④フランス語はしゃべれますか。		\N	vmod				\N	0
2486	ええ、　少しなら。	ええ、　少しなら。			\N	vmod				\N	0
2487	実は、　来週の　水曜日、　アメリカから　お客さんが　来るんですが、　空港まで　迎えに　行って　ほしいんです。	実は、　来週の　水曜日、　アメリカから　お客さんが　来るんですが、　空港まで　迎えに　行って　ほしいんです。			\N	vmod				\N	0
2488	ええ、いいですよ。	ええ、いいですよ。			\N	vmod				\N	0
2489	朝の　十時までに　行けますか。	朝の　十時までに　行けますか。			\N	vmod				\N	0
2490	大丈夫です。	大丈夫です。			\N	vmod				\N	0
2491	車が運転できますから。	車が運転できますから。			\N	vmod				\N	0
2492	すみません、授業料を払いたいのですが。	すみません、授業料を払いたいのですが。			\N	vmod				\N	0
2493	授業料でしたら、会計課でお願いします。	授業料でしたら、会計課でお願いします。			\N	vmod				\N	0
2494	会計課はどこでしょうか。	会計課はどこでしょうか。	①どこにありますか。②情報を求める(存在と場所)③(存在/場所)はどこに(いま　　　　　　　　　　　　　すか／ありますか)④山田さんはどこにいますか。		\N	vmod				\N	0
2500	ありがとうございます。	ありがとうございます。			\N	vmod				\N	0
2713	ゆうべから　急に　熱が　出てね。	ゆうべから　急に　熱が　出てね。			\N	vmod				\N	0
2654	わかりました。	わかりました。			\N	vmod				\N	0
2655	あのう、４限目の英作でもお借りしたいんですが。	あのう、４限目の英作でもお借りしたいんですが。			\N	vmod				\N	0
2660	ええ、これでレポートを書いてもらいますから。	ええ、これでレポートを書いてもらいますから。			\N	vmod				\N	0
2661	あのう、　その日に　会社の　面接が　あるんですが…。	あのう、　その日に　会社の　面接が　あるんですが…。			\N	vmod				\N	0
2662	それなら仕方がありませんね。	それなら仕方がありませんね。			\N	vmod				\N	0
2663	先生、レポートは来週中に提出しなければなりませんか。	先生、レポートは来週中に提出しなければなりませんか。	①提出なければいけませんか　②義務を確認する　③Vなければいけませんか。④雨でも行かなければなりませんか。		\N	vmod				\N	0
2664	ええ、もちろんですよ。	ええ、もちろんですよ。			\N	vmod				\N	0
2665	あ、ちょっと、ちょっと。	あ、ちょっと、ちょっと。			\N	vmod				\N	0
2666	え、何ですか。	え、何ですか。			\N	vmod				\N	0
1914	今ごろの　東京は　寒いかも　しれません。	今ごろの　東京は　寒いかも　しれません。	null		\N	vmod				\N	0
2667	そこに　空き缶を　捨てては　いけませんよ。	そこに　空き缶を　捨てては　いけませんよ。	①捨ててはいけません　②禁止する　③Vてはいけません。④廊下を走ってはいけません。		\N	vmod				\N	0
2668	空き缶は　こっちに　捨てて　ください。	空き缶は　こっちに　捨てて　ください。			\N	vmod				\N	0
2669	わかりました。	わかりました。			\N	vmod				\N	0
2670	ああっ、　それは　そっちに　捨てて　ください。	ああっ、　それは　そっちに　捨てて　ください。			\N	vmod				\N	0
2671	あ、申し訳ありません。	あ、申し訳ありません。			\N	vmod				\N	0
2674	ここは　自転車置き場じゃないんですよ。	ここは　自転車置き場じゃないんですよ。			\N	vmod				\N	0
2675	そうですか。	そうですか。			\N	vmod				\N	0
2676	じゃ、どこにとめればいいでしょうか。	じゃ、どこにとめればいいでしょうか。			\N	vmod				\N	0
2677	図書館の　となりに　自転車置き場が　ありますから、　そこに　とめて　ください。	図書館の　となりに　自転車置き場が　ありますから、　そこに　とめて　ください。	①そこにとめてください。②指示する　③Vてください　④それを読んでおいてください。		\N	vmod				\N	0
2678	わかりました。	わかりました。			\N	vmod				\N	0
2679	これからは必ずそこにとめてくださいね。	これからは必ずそこにとめてくださいね。	①そこにとめてください。②指示する　③Vてください　④それを読んでおいてください。		\N	vmod				\N	0
2680	はい。	はい。			\N	vmod				\N	0
2681	吉田さん、　ちょっと　お願いが　あるんですけど。	吉田さん、　ちょっと　お願いが　あるんですけど。			\N	vmod				\N	0
2682	はい、　何でしょうか。	はい、　何でしょうか。			\N	vmod				\N	0
2683	ゼミのホームページを作りたいんですが、手伝ってもらえますか。	ゼミのホームページを作りたいんですが、手伝ってもらえますか。			\N	vmod				\N	0
2684	はい、わかりました。	はい、わかりました。			\N	vmod				\N	0
2685	吉田さんの研究テーマについても載せたいんですが、いいですか。	吉田さんの研究テーマについても載せたいんですが、いいですか。			\N	vmod				\N	0
2686	はい、かまいません。	はい、かまいません。			\N	vmod				\N	0
2687	あ、あと、顔写真も載せようと思うんですが。	あ、あと、顔写真も載せようと思うんですが。			\N	vmod				\N	0
1933	ここに　おいしそうな　おかしが　あります。	ここに　おいしそうな　おかしが　あります。	null		\N	vmod				\N	0
1934	木村さんは　うれしそうに　走って　きました。	木村さんは　うれしそうに　走って　きました。	null		\N	vmod				\N	0
2040	あした雨が降ったら、試合は中止します。	あした雨が降ったら、試合は中止します。	null		\N	vmod				\N	0
2688	すみません、顔写真はちょっと載せないでいただけないでしょうか。	すみません、顔写真はちょっと載せないでいただけないでしょうか。	①載せないでいただけないでしょうか。②非行為を依頼する　③Vないでください／Vないでいただけませんか。④すみませんがここで煙草を吸わないでください。		\N	vmod				\N	0
2690	わかりました。	わかりました。			\N	vmod				\N	0
2691	山田くん、　今日の　練習、　出るでしょう。	山田くん、　今日の　練習、　出るでしょう。			\N	vmod				\N	0
2692	あのう、今日、練習に出なくてもいいですか。	あのう、今日、練習に出なくてもいいですか。			\N	vmod				\N	0
2694	具合でも悪いの。	具合でも悪いの。			\N	vmod				\N	0
2695	いえ、　明日、　試験が　四つも　あるんです。	いえ、　明日、　試験が　四つも　あるんです。			\N	vmod				\N	0
2696	あ、そう。	あ、そう。			\N	vmod				\N	0
2698	試験、がんばってね。	試験、がんばってね。			\N	vmod				\N	0
2699	はい、ありがとうございます。	はい、ありがとうございます。			\N	vmod				\N	0
2700	鈴木さん、こんにちは。	鈴木さん、こんにちは。			\N	vmod				\N	0
2701	あ、野村先輩。	あ、野村先輩。			\N	vmod				\N	0
2702	何をしているの。	何をしているの。			\N	vmod				\N	0
2703	学園祭の準備です。	学園祭の準備です。			\N	vmod				\N	0
2704	ああ、鈴木さんはダンスサークルだったんだ。	ああ、鈴木さんはダンスサークルだったんだ。			\N	vmod				\N	0
2705	そうなんです。	そうなんです。			\N	vmod				\N	0
2706	土曜日に　ステージが　あるんですが、　よかったら、　先輩も　見に　いらっしゃいませんか。	土曜日に　ステージが　あるんですが、　よかったら、　先輩も　見に　いらっしゃいませんか。	①見にいらっしゃいませんか。②招待する　③いらっしゃいませんか④誕生パーティーをするのですがうちにいらっしゃいませんか。		\N	vmod				\N	0
2707	わかった。	わかった。			\N	vmod				\N	0
2708	じゃあ、　友達と　いっしょに　見に　行くよ。	じゃあ、　友達と　いっしょに　見に　行くよ。			\N	vmod				\N	0
2709	よろしくお願いします。	よろしくお願いします。			\N	vmod				\N	0
2710	先輩、どうしました。	先輩、どうしました。			\N	vmod				\N	0
2711	具合が　悪そうですけど。	具合が　悪そうですけど。			\N	vmod				\N	0
2712	うん、　スキーの　合宿で　風邪を　ひいて　しまったみたい。	うん、　スキーの　合宿で　風邪を　ひいて　しまったみたい。			\N	vmod				\N	0
2142	わたしはきょうまでにレポートを終わらせとく。	わたしはきょうまでにレポートを終わらせとく。	null		\N	vmod				\N	0
1913	山田さんは　図書館に　いるかも　しれません。	山田さんは　図書館に　いるかも　しれません。	null		\N	vmod				\N	0
1915	山田さんは　猫が　きらいかも　しれません。	山田さんは　猫が　きらいかも　しれません。	null		\N	vmod				\N	0
1917	あれは、　田村さんに　ちがい　ありません。	あれは、　田村さんに　ちがい　ありません。	null		\N	vmod				\N	0
1918	あの人はもしかすると木村さんのお兄さんかもしれません。	あの人はもしかすると木村さんのお兄さんかもしれません。	null		\N	vmod				\N	0
1920	妹が帰ってきません。もしかしたら事故にあったのかもしれません。	妹が帰ってきません。もしかしたら事故にあったのかもしれません。	null		\N	vmod				\N	0
1922	木村さんは　英語教師ですから、　英語が　話せる　はずです。	木村さんは　英語教師ですから、　英語が　話せる　はずです。	null		\N	vmod				\N	0
1923	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。	null		\N	vmod				\N	0
1924	木村さんは　英語教師です。	木村さんは　英語教師です。	null		\N	vmod				\N	0
1925	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。	null		\N	vmod				\N	0
1926	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。	null		\N	vmod				\N	0
1927	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。	null		\N	vmod				\N	0
1929	この　おかしは　甘そうです。	この　おかしは　甘そうです。	null		\N	vmod				\N	0
1930	この　電子辞書は　便利そうです。	この　電子辞書は　便利そうです。	null		\N	vmod				\N	0
2044	成績が　悪いと　進学できません。	成績が　悪いと　進学できません。	null		\N	vmod				\N	0
2045	部屋が　静かだと　よく　勉強できます。	部屋が　静かだと　よく　勉強できます。	null		\N	vmod				\N	0
2048	ちりも　つもれば　山と　なる。	ちりも　つもれば　山と　なる。	null		\N	vmod				\N	0
2050	暑かったら、　エアコンを　つけて　ください。	暑かったら、　エアコンを　つけて　ください。	null		\N	vmod				\N	0
2051	あした　晴れだったら、　ドライブに　行きましょう。	あした　晴れだったら、　ドライブに　行きましょう。	null		\N	vmod				\N	0
2052	ひまだったら、遊びに来ませんか。	ひまだったら、遊びに来ませんか。	null		\N	vmod				\N	0
2053	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。	null		\N	vmod				\N	0
2054	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。	null		\N	vmod				\N	0
2057	大学生ならこのくらいはできるはずです。	大学生ならこのくらいはできるはずです。	null		\N	vmod				\N	0
2058	家に　パソコンが　あります。	家に　パソコンが　あります。	null		\N	vmod				\N	0
2059	パソコンがあるなら、インターネットができますね。	パソコンがあるなら、インターネットができますね。	null		\N	vmod				\N	0
2062	車を　買ったら、　ドライブを　しよう。	車を　買ったら、　ドライブを　しよう。	null		\N	vmod				\N	0
2063	学校に｛行くと／行ったら｝、新入生がたくさんいました。	学校に｛行くと／行ったら｝、新入生がたくさんいました。	null		\N	vmod				\N	0
2066	お酒を｛飲むと／飲んだら｝、気分が悪くなります。	お酒を｛飲むと／飲んだら｝、気分が悪くなります。	null		\N	vmod				\N	0
2067	教科書さえあれば、勉強できる。	教科書さえあれば、勉強できる。	null		\N	vmod				\N	0
2070	嫌でも、　しかたが　ありません。	嫌でも、　しかたが　ありません。	null		\N	vmod				\N	0
2071	たとえ　雨でも、　自転車で　行きます。 	たとえ　雨でも、　自転車で　行きます。 	null		\N	vmod				\N	0
2072	この　時計は、　落としても、　水に　ぬれても　こわれません。	この　時計は、　落としても、　水に　ぬれても　こわれません。	null		\N	vmod				\N	0
2073	だれが　選ばれても、　おどろきません。	だれが　選ばれても、　おどろきません。	null		\N	vmod				\N	0
2074	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。	null		\N	vmod				\N	0
2075	わたしは木村さんにプレゼントをあげます。	わたしは木村さんにプレゼントをあげます。	null		\N	vmod				\N	0
2076	木村さんはわたしにプレゼントをくれます。	木村さんはわたしにプレゼントをくれます。	null		\N	vmod				\N	0
2077	わたしは木村さんにプレゼントをもらいます。	わたしは木村さんにプレゼントをもらいます。	null		\N	vmod				\N	0
2078	妹は　山田さんに　おみやげを　あげました。　	妹は　山田さんに　おみやげを　あげました。　	null		\N	vmod				\N	0
2080	木村さんは山田さんにおみやげをあげました。	木村さんは山田さんにおみやげをあげました。	null		\N	vmod				\N	0
2081	妹は山田さんに本をもらいました。	妹は山田さんに本をもらいました。	null		\N	vmod				\N	0
2082	山田さんは木村さんにおみやげをもらいました。	山田さんは木村さんにおみやげをもらいました。	null		\N	vmod				\N	0
2083	わたしは田中先生に花をさしあげました。	わたしは田中先生に花をさしあげました。	null		\N	vmod				\N	0
2084	田中先生は　わたしに　手紙を　くださいました。	田中先生は　わたしに　手紙を　くださいました。	null		\N	vmod				\N	0
2085	わたしは　田中先生に　手紙を　いただきました。	わたしは　田中先生に　手紙を　いただきました。	null		\N	vmod				\N	0
2087	父は　わたしに　本を　くれました。	父は　わたしに　本を　くれました。	null		\N	vmod				\N	0
2091	小林さんはわたしに友だちを紹介してくれました。	小林さんはわたしに友だちを紹介してくれました。	null		\N	vmod				\N	0
2094	田中さんは　わたしに　パソコンの　使い方を　教えて　くれました。	田中さんは　わたしに　パソコンの　使い方を　教えて　くれました。	null		\N	vmod				\N	0
2095	わたしは　生徒を　ほめて　あげました。	わたしは　生徒を　ほめて　あげました。	null		\N	vmod				\N	0
2096	山田さんは息子と遊んでくれました。	山田さんは息子と遊んでくれました。	null		\N	vmod				\N	0
2101	山田さんは　わたしの　ために　詩を　書いて　くれました。	山田さんは　わたしの　ために　詩を　書いて　くれました。	null		\N	vmod				\N	0
2102	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。	null		\N	vmod				\N	0
2105	日本語は　木村さんに　教えて　もらおう。	日本語は　木村さんに　教えて　もらおう。	null		\N	vmod				\N	0
2106	あした来てもらうよ。	あした来てもらうよ。	null		\N	vmod				\N	0
2107	レポートは　みなさんに　出して　もらう　ことに　します。	レポートは　みなさんに　出して　もらう　ことに　します。	null		\N	vmod				\N	0
2108	京都の友だちからおかしを送ってもらいました。　	京都の友だちからおかしを送ってもらいました。　	null		\N	vmod				\N	0
2109	その知らせは田中さんから教えてもらいました。　	その知らせは田中さんから教えてもらいました。　	null		\N	vmod				\N	0
2110	京都からおかしを送ってもらいました。　	京都からおかしを送ってもらいました。　	null		\N	vmod				\N	0
2111	田中先生に　ペンを　貸して　さしあげました。	田中先生に　ペンを　貸して　さしあげました。	null		\N	vmod				\N	0
2112	鈴木先生はわたしに推薦状を書いてくださいました。	鈴木先生はわたしに推薦状を書いてくださいました。	null		\N	vmod				\N	0
2113	わたしは鈴木先生に推薦状を書いていただきました。	わたしは鈴木先生に推薦状を書いていただきました。	null		\N	vmod				\N	0
2114	弟に弁当を作ってやりました。	弟に弁当を作ってやりました。	null		\N	vmod				\N	0
2116	これからも　日本語を　勉強して　いきます。	これからも　日本語を　勉強して　いきます。	null		\N	vmod				\N	0
2117	おみやげを　持って　きました。	おみやげを　持って　きました。	null		\N	vmod				\N	0
2118	高校の友だちがメールを送ってきました。	高校の友だちがメールを送ってきました。	null		\N	vmod				\N	0
2119	日本語を学ぶ人が増えてきました。	日本語を学ぶ人が増えてきました。	null		\N	vmod				\N	0
2121	駅前の通りを歩いてきました。	駅前の通りを歩いてきました。	null		\N	vmod				\N	0
2122	授業まで　時間が　あるので、　朝の　ニュースを　見て　いきます。	授業まで　時間が　あるので、　朝の　ニュースを　見て　いきます。	null		\N	vmod				\N	0
2124	木村さんは　わたしに　古本を　売って　きました。　	木村さんは　わたしに　古本を　売って　きました。　	null		\N	vmod				\N	0
2125	来週までにレポートを書いておきます。	来週までにレポートを書いておきます。	null		\N	vmod				\N	0
2126	発表の　ために　資料を　コピーして　おきました。	発表の　ために　資料を　コピーして　おきました。	null		\N	vmod				\N	0
2127	友だちが　来るので、　部屋を　きれいに　して　おきます。	友だちが　来るので、　部屋を　きれいに　して　おきます。	null		\N	vmod				\N	0
2128	あした木村さんに聞いてみます。	あした木村さんに聞いてみます。	null		\N	vmod				\N	0
2129	この　ジュースを　少し　飲んで　みて　ください。	この　ジュースを　少し　飲んで　みて　ください。	null		\N	vmod				\N	0
2131	いつか南極に行ってみたいです。	いつか南極に行ってみたいです。	null		\N	vmod				\N	0
2132	わたしは　この前　京都へ　行ったよ。	わたしは　この前　京都へ　行ったよ。	null		\N	vmod				\N	0
2133	わたしは先日京都へ行きました。	わたしは先日京都へ行きました。	null		\N	vmod				\N	0
2134	彼は大学の教授だ。言語学を教えている。	彼は大学の教授だ。言語学を教えている。	null		\N	vmod				\N	0
2135	彼は大学の教授である。言語学を教えている。	彼は大学の教授である。言語学を教えている。	null		\N	vmod				\N	0
2136	彼は大学の教授です。言語学を教えています。	彼は大学の教授です。言語学を教えています。	null		\N	vmod				\N	0
2137	わたしは急ぐ。	わたしは急ぐ。	null		\N	vmod				\N	0
2138	日本の冬は寒い。	日本の冬は寒い。	null		\N	vmod				\N	0
2139	わたしは学生だ。	わたしは学生だ。	null		\N	vmod				\N	0
2141	この本はわたしのじゃない。	この本はわたしのじゃない。	null		\N	vmod				\N	0
2143	こうすりゃよかった。	こうすりゃよかった。	null		\N	vmod				\N	0
2144	君、あした来るって言ったよね。	君、あした来るって言ったよね。	null		\N	vmod				\N	0
2155	授業に毎回出席する。これがわたしの今年の目標です。	授業に毎回出席する。これがわたしの今年の目標です。	null		\N	vmod				\N	0
2156	わたしは　英語が　苦手なので　勉強します。	わたしは　英語が　苦手なので　勉強します。	null		\N	vmod				\N	0
2157	星が　たくさん　出て　いますから　あしたは　晴れでしょう。	星が　たくさん　出て　いますから　あしたは　晴れでしょう。	null		\N	vmod				\N	0
2159	以上で　発表は　終わりで　ございますが、　何か　ご質問は　ありますか。	以上で　発表は　終わりで　ございますが、　何か　ご質問は　ありますか。	null		\N	vmod				\N	0
2160	頼む。　金を　貸して　くれ。　お願いします。	頼む。　金を　貸して　くれ。　お願いします。	null		\N	vmod				\N	0
2161	年が　明けました。　新しい　年の　始まりです。　今年は　どんな　年に　なるんだろう。	年が　明けました。　新しい　年の　始まりです。　今年は　どんな　年に　なるんだろう。	null		\N	vmod				\N	0
2162	山田さんはおそばを召し上がりました。	山田さんはおそばを召し上がりました。	null		\N	vmod				\N	0
2163	田中さんは　毎朝、　新聞を　お読みに　なります。	田中さんは　毎朝、　新聞を　お読みに　なります。	null		\N	vmod				\N	0
2164	中田先生がこの本を書かれました。	中田先生がこの本を書かれました。	null		\N	vmod				\N	0
2165	あの　方は　東京駅で　降りられます。	あの　方は　東京駅で　降りられます。	null		\N	vmod				\N	0
2166	わたしはきのう渡辺社長のお宅を拝見しました。	わたしはきのう渡辺社長のお宅を拝見しました。	null		\N	vmod				\N	0
2167	わたしが　かばんを　お持ちします。	わたしが　かばんを　お持ちします。	null		\N	vmod				\N	0
2168	係員がご案内します。	係員がご案内します。	null		\N	vmod				\N	0
2169	あちらは　山田様です。	あちらは　山田様です。	null		\N	vmod				\N	0
2171	ご家族は　どちらに　いらっしゃいますか。	ご家族は　どちらに　いらっしゃいますか。	null		\N	vmod				\N	0
2172	先生は来週もお忙しいようです。	先生は来週もお忙しいようです。	null		\N	vmod				\N	0
2173	先生は来週もご多忙のようです。	先生は来週もご多忙のようです。	null		\N	vmod				\N	0
2175	先日試合で大阪に参りました。	先日試合で大阪に参りました。	null		\N	vmod				\N	0
2176	他社の社員：渡辺社長はいらっしゃいますか。	他社の社員：渡辺社長はいらっしゃいますか。	null		\N	vmod				\N	0
2177	渡辺の部下：渡辺はただいま外出しております。	渡辺の部下：渡辺はただいま外出しております。	null		\N	vmod				\N	0
2146	読んどいたよ、あの本。	読んどいたよ、あの本。	null		\N	vmod				\N	0
2182	お母さんは　若い　とき　看護士でした。	お母さんは　若い　とき　看護士でした。	null		\N	vmod				\N	0
2183	桜の　花が　きれいな　とき、　リーさんは　日本へ　来ました。	桜の　花が　きれいな　とき、　リーさんは　日本へ　来ました。	null		\N	vmod				\N	0
2184	高校生のとき、日本へ留学したことがあります。	高校生のとき、日本へ留学したことがあります。	null		\N	vmod				\N	0
2185	部屋を出るとき、携帯が鳴りました。	部屋を出るとき、携帯が鳴りました。	null		\N	vmod				\N	0
2186	部屋を出たとき、携帯が鳴りました。	部屋を出たとき、携帯が鳴りました。	null		\N	vmod				\N	0
2188	部屋に　いた　とき、　電話しました。	部屋に　いた　とき、　電話しました。	null		\N	vmod				\N	0
2190	若かった　とき、　よく　泳ぎました。	若かった　とき、　よく　泳ぎました。	null		\N	vmod				\N	0
2191	朝起きて顔を洗います。	朝起きて顔を洗います。	null		\N	vmod				\N	0
2193	学校で　勉強を　したり　運動を　したり　します。	学校で　勉強を　したり　運動を　したり　します。	null		\N	vmod				\N	0
2194	春になると暖かくなります。	春になると暖かくなります。	null		\N	vmod				\N	0
2195	雨が降ったので運動会が中止になりました。	雨が降ったので運動会が中止になりました。	null		\N	vmod				\N	0
2196	雨が降ったから運動会が中止になりました。	雨が降ったから運動会が中止になりました。	null		\N	vmod				\N	0
2198	雨が降ったけれども運動会がありました。	雨が降ったけれども運動会がありました。	null		\N	vmod				\N	0
2199	雨が降れば運動会を中止します。	雨が降れば運動会を中止します。	null		\N	vmod				\N	0
2200	雨が降ったら運動会を中止します。	雨が降ったら運動会を中止します。	null		\N	vmod				\N	0
2201	雨が降るなら運動会を中止します。	雨が降るなら運動会を中止します。	null		\N	vmod				\N	0
2202	雨が降っても運動会をします。	雨が降っても運動会をします。	null		\N	vmod				\N	0
2203	象は　大きくて　鼻が　長いです。	象は　大きくて　鼻が　長いです。	null		\N	vmod				\N	0
2324	私は　２限目から　授業です。	私は　２限目から　授業です。			\N	vmod				\N	0
2204	田中さんは、　知って　いながら　知らない　ふりを　しました。	田中さんは、　知って　いながら　知らない　ふりを　しました。	null		\N	vmod				\N	0
2207	田中さんは　学生です。　佐藤さんも　学生です。	田中さんは　学生です。　佐藤さんも　学生です。	null		\N	vmod				\N	0
2208	佐藤さんだけ来ました。	佐藤さんだけ来ました。	null		\N	vmod				\N	0
2209	肉ばかり食べます。	肉ばかり食べます。	null		\N	vmod				\N	0
2210	山田さんこそ会長にふさわしいです。	山田さんこそ会長にふさわしいです。	null		\N	vmod				\N	0
2211	ジュースが　３本しか　ありません。	ジュースが　３本しか　ありません。	null		\N	vmod				\N	0
2212	机の上に本などがあります。	机の上に本などがあります。	null		\N	vmod				\N	0
2214	佐藤さんや田中さんが来ました。山田さんまで来ました。	佐藤さんや田中さんが来ました。山田さんまで来ました。	null		\N	vmod				\N	0
2215	佐藤さんや田中さんが来ました。山田さんさえ来ました。	佐藤さんや田中さんが来ました。山田さんさえ来ました。	null		\N	vmod				\N	0
2216	10人くらい　来ました。	10人くらい　来ました。	null		\N	vmod				\N	0
2217	ここに　えんぴつが　あります。　赤い　鉛筆は　３本　あります。　青い　えんぴつは　３本　あります。	ここに　えんぴつが　あります。　赤い　鉛筆は　３本　あります。　青い　えんぴつは　３本　あります。	null		\N	vmod				\N	0
2218	Ａ：そこにかさとかばんがありますか。	Ａ：そこにかさとかばんがありますか。	null		\N	vmod				\N	0
2219	Ｂ：かさはありますが、かばんはありません。	Ｂ：かさはありますが、かばんはありません。	null		\N	vmod				\N	0
2221	Ａ：宿題をしてきましたか。	Ａ：宿題をしてきましたか。	null		\N	vmod				\N	0
2738	それはいいね。	それはいいね。			\N	vmod				\N	0
2222	Ｂ：レポートは書きましたが、印刷はしていません。	Ｂ：レポートは書きましたが、印刷はしていません。	null		\N	vmod				\N	0
2223	山田さんはドイツ語はじょうずです。	山田さんはドイツ語はじょうずです。	null		\N	vmod				\N	0
2224	きょうの　会議に　20人は　集まりました。	きょうの　会議に　20人は　集まりました。	null		\N	vmod				\N	0
2225	山田先生はやさしいです。	山田先生はやさしいです。	null		\N	vmod				\N	0
2226	田中さんは社長です。	田中さんは社長です。	null		\N	vmod				\N	0
2228	朝ごはんは　もう　食べました。	朝ごはんは　もう　食べました。	null		\N	vmod				\N	0
2230	暖かく　なりましたし、　桜も　咲きました。	暖かく　なりましたし、　桜も　咲きました。	null		\N	vmod				\N	0
2231	きょうの　コンサートには　100人も　来ました。	きょうの　コンサートには　100人も　来ました。	null		\N	vmod				\N	0
2233	時間も　来ました。　そろそろ　終わりに　しましょう。	時間も　来ました。　そろそろ　終わりに　しましょう。	null		\N	vmod				\N	0
2235	あとは　寝るだけです。	あとは　寝るだけです。	null		\N	vmod				\N	0
2236	言うだけで　何も　しません。	言うだけで　何も　しません。	null		\N	vmod				\N	0
2237	何を聞かれても泣くばかりです。	何を聞かれても泣くばかりです。	null		\N	vmod				\N	0
2238	食べたいだけ食べました。	食べたいだけ食べました。	null		\N	vmod				\N	0
2239	日本語は　勉強しただけ　じょうずに　なります。	日本語は　勉強しただけ　じょうずに　なります。	null		\N	vmod				\N	0
2240	すきなだけ持っていってください。	すきなだけ持っていってください。	null		\N	vmod				\N	0
2241	全力を尽くしてこそいい結果がでます。	全力を尽くしてこそいい結果がでます。	null		\N	vmod				\N	0
2243	コアラはユーカリの葉しか食べません。	コアラはユーカリの葉しか食べません。	null		\N	vmod				\N	0
2244	辞書を　引いたり、　インターネットで　調べるなど　しました。	辞書を　引いたり、　インターネットで　調べるなど　しました。	null		\N	vmod				\N	0
2245	小泉氏などの政治家にインタビューしました。	小泉氏などの政治家にインタビューしました。	null		\N	vmod				\N	0
2246	試験中にとなりの人と話すなどのことはしてはいけません。	試験中にとなりの人と話すなどのことはしてはいけません。	null		\N	vmod				\N	0
2248	つまらない　仕事などに　時間を　使いたくありません。	つまらない　仕事などに　時間を　使いたくありません。	null		\N	vmod				\N	0
2250	それでもだいじょうぶです。	それでもだいじょうぶです。	null		\N	vmod				\N	0
2251	この　アルバイトは、　いそがしい　人でも　できます。	この　アルバイトは、　いそがしい　人でも　できます。	null		\N	vmod				\N	0
2252	そのくらいのことはわたしだってできます。	そのくらいのことはわたしだってできます。	null		\N	vmod				\N	0
2253	日本語を　勉強して、　留学生試験に　合格する　までに　なりました。	日本語を　勉強して、　留学生試験に　合格する　までに　なりました。	null		\N	vmod				\N	0
2254	これさえあればだいじょうぶです。	これさえあればだいじょうぶです。	null		\N	vmod				\N	0
2328	お先に失礼します。	お先に失礼します。	①失礼します　②挨拶をする（退席）③失礼します　④すみません、先約があるのでお先に失礼します。		\N	vmod				\N	0
2434	通訳の仕事。	通訳の仕事。			\N	vmod				\N	0
2329	先生、ここに印鑑をいただきたいのですが。	先生、ここに印鑑をいただきたいのですが。			\N	vmod				\N	0
2330	ああ、科目の変更ですね。	ああ、科目の変更ですね。			\N	vmod				\N	0
2331	分かりました。	分かりました。			\N	vmod				\N	0
2333	ありがとうございます。	ありがとうございます。	①ありがとうございます　②感謝する　③（どうも）ありがとう（ございます）　④手伝ってくれてどうもありがとう。 		\N	vmod				\N	0
2334	それから、　この　本を　お返し　します。	それから、　この　本を　お返し　します。			\N	vmod				\N	0
2335	長い　間　ありがとう　ございました。	長い　間　ありがとう　ございました。	 ①ありがとうございます　②感謝する　③（どうも）ありがとう（ございます）　④手伝ってくれてどうもありがとう。		\N	vmod				\N	0
2336	いえいえ。	いえいえ。			\N	vmod				\N	0
2337	で、役に立ちましたか。	で、役に立ちましたか。			\N	vmod				\N	0
2338	ええ、　とても　おもしろくて、　勉強に　なりました。	ええ、　とても　おもしろくて、　勉強に　なりました。			\N	vmod				\N	0
2340	あのう、すみません。	あのう、すみません。	①すみません　②注意を引く　③すみません　④すみません、これいくらですか。		\N	vmod				\N	0
2341	すみません。	すみません。	①すみません　②注意を引く　③すみません　④すみません、これいくらですか。		\N	vmod				\N	0
2343	在学証明書をいただきたいのですが。	在学証明書をいただきたいのですが。			\N	vmod				\N	0
2344	在学証明書は、　横の　機械を　使って　下さい。	在学証明書は、　横の　機械を　使って　下さい。			\N	vmod				\N	0
2345	分かりました。	分かりました。			\N	vmod				\N	0
2346	ありがとうございます。	ありがとうございます。			\N	vmod				\N	0
2347	あのう、たびたびすみません。	あのう、たびたびすみません。	①すみません　②注意を引く　③すみません　④すみません、これいくらですか。		\N	vmod				\N	0
2348	はい、何でしょう。	はい、何でしょう。			\N	vmod				\N	0
2349	機械が動かないんです。	機械が動かないんです。			\N	vmod				\N	0
2350	ああ、もう５時を過ぎていますね。	ああ、もう５時を過ぎていますね。			\N	vmod				\N	0
2351	明日、お願いします。	明日、お願いします。			\N	vmod				\N	0
2353	今日は　初めての　授業ですから、　一人ずつ　自己紹介を　お願いします。	今日は　初めての　授業ですから、　一人ずつ　自己紹介を　お願いします。			\N	vmod				\N	0
2354	じゃあ、田村さんから。	じゃあ、田村さんから。			\N	vmod				\N	0
2355	はい。	はい。			\N	vmod				\N	0
2356	初めまして。	初めまして。	①初めまして　②自己紹介する(初対面の挨拶)　③初めまして　④初めまして山田です。		\N	vmod				\N	0
2357	日本語専攻　４年の　田村と　申します。	日本語専攻　４年の　田村と　申します。	①田村と申します　②自己紹介する(名前を名乗る)　③(名前)と申します　④こんにちは。山田と申します。		\N	vmod				\N	0
2358	斉藤先生のゼミで日本語のアクセントについて卒論を書こうと思っています。	斉藤先生のゼミで日本語のアクセントについて卒論を書こうと思っています。			\N	vmod				\N	0
2359	これから一年間、よろしくお願いします。	これから一年間、よろしくお願いします。	①よろしくお願いします　②自己紹介する（挨拶する）　③よろしくお願いします④はじめまして山田です。よろしくお願いします。		\N	vmod				\N	0
2360	こちらこそ、　よろしく。	こちらこそ、　よろしく。			\N	vmod				\N	0
2589	そう。	そう。			\N	vmod				\N	0
2361	で、　田村さん、　卒論の　準備は　いかがですか。	で、　田村さん、　卒論の　準備は　いかがですか。			\N	vmod				\N	0
2362	はい、いちおう始めています。	はい、いちおう始めています。			\N	vmod				\N	0
2363	就職活動のほうは。	就職活動のほうは。			\N	vmod				\N	0
2364	はい、就職活動もしています。	はい、就職活動もしています。			\N	vmod				\N	0
2365	それは、　大変ですね。	それは、　大変ですね。			\N	vmod				\N	0
2366	がんばってください。	がんばってください。			\N	vmod				\N	0
2370	先生、レポートを提出しに来ました。	先生、レポートを提出しに来ました。			\N	vmod				\N	0
2371	えっ、レポートですか。	えっ、レポートですか。			\N	vmod				\N	0
2372	たしか　締め切りは　先週の　金曜日　でしたよね。	たしか　締め切りは　先週の　金曜日　でしたよね。			\N	vmod				\N	0
2373	遅れてすみません。	遅れてすみません。	①すみません　②あやまる　③（どうも）すみません　④昨日はどうもすみませんでした。 		\N	vmod				\N	0
2374	風邪で　寝込んで　しまいまして･･･。	風邪で　寝込んで　しまいまして･･･。			\N	vmod				\N	0
2375	そうですか、でも、そういう場合も電話かメールであらかじめ連絡してくださいね。	そうですか、でも、そういう場合も電話かメールであらかじめ連絡してくださいね。			\N	vmod				\N	0
2376	わかりました。	わかりました。			\N	vmod				\N	0
2377	これから気をつけます。	これから気をつけます。			\N	vmod				\N	0
2378	で、風邪のほうは。	で、風邪のほうは。			\N	vmod				\N	0
2379	もう、　すっかり　良く　なりました。 	もう、　すっかり　良く　なりました。 			\N	vmod				\N	0
2380	失礼します。	失礼します。			\N	vmod				\N	0
2382	先生、これ、軽井沢のお土産なんです。	先生、これ、軽井沢のお土産なんです。			\N	vmod				\N	0
2384	へえ、つまらないものって、何。	へえ、つまらないものって、何。			\N	vmod				\N	0
2385	りんごワインです。 	りんごワインです。 			\N	vmod				\N	0
2386	へえ、それはめずらしいね。	へえ、それはめずらしいね。			\N	vmod				\N	0
2388	ええ、　どうぞ、　どうぞ。	ええ、　どうぞ、　どうぞ。			\N	vmod				\N	0
2389	じゃあ、遠慮なくいただきますね。	じゃあ、遠慮なくいただきますね。			\N	vmod				\N	0
2390	うーん、これは楽しみだな。	うーん、これは楽しみだな。			\N	vmod				\N	0
2392	いいえ。	いいえ。			\N	vmod				\N	0
2393	田中先生、こんばんは。	田中先生、こんばんは。			\N	vmod				\N	0
2394	ああ、　田村さん、　こんばんは。	ああ、　田村さん、　こんばんは。			\N	vmod				\N	0
2395	先生、今まで、会議ですか。	先生、今まで、会議ですか。			\N	vmod				\N	0
2397	でも、　田村さんも　ずいぶん　遅いですね。	でも、　田村さんも　ずいぶん　遅いですね。			\N	vmod				\N	0
2398	ええ、図書館で卒論の資料を探していました。 	ええ、図書館で卒論の資料を探していました。 			\N	vmod				\N	0
2399	そう、偉いですね。	そう、偉いですね。			\N	vmod				\N	0
2400	じゃあ、気をつけて帰ってくださいね。	じゃあ、気をつけて帰ってくださいね。			\N	vmod				\N	0
2401	はい、　では　失礼します。	はい、　では　失礼します。	①失礼します　②さよならを言う（目下から目上へ）　③さようなら　④部長、お先に失礼します。		\N	vmod				\N	0
2402	さようなら。	さようなら。	①さようなら　②さよならを言う　③さようなら　④　山田君、さようなら。また明日ね。		\N	vmod				\N	0
2404	いらっしゃいませ。	いらっしゃいませ。			\N	vmod				\N	0
2405	本を注文したいんですが。	本を注文したいんですが。			\N	vmod				\N	0
2406	はい、何の本でしょう。	はい、何の本でしょう。			\N	vmod				\N	0
2407	『日本文法辞典』です。	『日本文法辞典』です。			\N	vmod				\N	0
2408	『日本文法辞典』ですね。	『日本文法辞典』ですね。			\N	vmod				\N	0
2410	ちょっとお待ちください。	ちょっとお待ちください。			\N	vmod				\N	0
2411	6,500円です。	6,500円です。			\N	vmod				\N	0
2613	で、　締め切りは　いつまでですか。	で、　締め切りは　いつまでですか。			\N	vmod				\N	0
2413	いえ、　消費税を　入れると、　6,825円に　なります。	いえ、　消費税を　入れると、　6,825円に　なります。			\N	vmod				\N	0
2414	わかりました。	わかりました。			\N	vmod				\N	0
2417	では、　こちらに　お名前と　お電話番号を　お願いします。	では、　こちらに　お名前と　お電話番号を　お願いします。			\N	vmod				\N	0
2418	はい。	はい。			\N	vmod				\N	0
2419	渡辺先輩、　授業登録の　ことで、　ちょっと　質問しても　いいですか。	渡辺先輩、　授業登録の　ことで、　ちょっと　質問しても　いいですか。			\N	vmod				\N	0
2420	いいよ、何。	いいよ、何。			\N	vmod				\N	0
2421	英語専攻の　小林先生の　授業を　取った　ことが　ありますか。	英語専攻の　小林先生の　授業を　取った　ことが　ありますか。	①小林先生の授業を取ったことがありますか。②情報を求める（経験）③（動詞のタ形）＋ことがありますか　④富士山に登ったことがありますか		\N	vmod				\N	0
2422	あるけど。	あるけど。			\N	vmod				\N	0
2423	私、　英語に　あまり　自信が　ないんですけど、　大丈夫でしょうか。	私、　英語に　あまり　自信が　ないんですけど、　大丈夫でしょうか。			\N	vmod				\N	0
2424	そうだねえ、とても厳しい先生だからねえ。	そうだねえ、とても厳しい先生だからねえ。			\N	vmod				\N	0
2425	他の先生の授業を考えたほうがいいかもしれないよ。	他の先生の授業を考えたほうがいいかもしれないよ。			\N	vmod				\N	0
2426	暑いですね。	暑いですね。			\N	vmod				\N	0
2427	早く夏休みが来るといいな。	早く夏休みが来るといいな。			\N	vmod				\N	0
2428	そうね、　山田君、　この　夏の　予定は。	そうね、　山田君、　この　夏の　予定は。			\N	vmod				\N	0
2430	いいわねえ。	いいわねえ。			\N	vmod				\N	0
2433	何のバイトですか。	何のバイトですか。			\N	vmod				\N	0
2435	すごいなあ。	すごいなあ。			\N	vmod				\N	0
2436	鈴木さん、何を見ているの。	鈴木さん、何を見ているの。			\N	vmod				\N	0
2437	旅行の　パンフレットです。	旅行の　パンフレットです。			\N	vmod				\N	0
2438	夏休みにどこかへ旅行したいと思って。	夏休みにどこかへ旅行したいと思って。			\N	vmod				\N	0
2439	そういえば、　先輩は　たしか　去年、　タイへ　行かれましたよね。	そういえば、　先輩は　たしか　去年、　タイへ　行かれましたよね。			\N	vmod				\N	0
2441	お金どのぐらいかかりましたか。	お金どのぐらいかかりましたか。	 ①どのぐらいかかりましたか。②情報を求める(程度)　　　　　　　　　　　　　③(～は)どのぐらい(程度)④時間はどのぐらいかかりましたか。		\N	vmod				\N	0
2442	けっこう　安かったよ。	けっこう　安かったよ。			\N	vmod				\N	0
2443	全部で　10万ぐらいかな。	全部で　10万ぐらいかな。			\N	vmod				\N	0
2444	何日間行っていたんですか。	何日間行っていたんですか。	①何日間行っていたんですか。②情報を求める(程度)　　　　　　　　　　　　　③何(期間)～か。④アメリカは何年間住んでいましたか。 		\N	vmod				\N	0
2148	ちょっと　待って。	ちょっと　待って。	null		\N	vmod				\N	0
2446	3週間ぐらい。	3週間ぐらい。			\N	vmod				\N	0
2447	3週間で　10万ですか…。	3週間で　10万ですか…。			\N	vmod				\N	0
2501	先輩、小沢先生の｢国際法｣はどうですか。	先輩、小沢先生の｢国際法｣はどうですか。	①～はどうですか。②情報を求める(属性)③(対象)はどうですか。　　　　　　　　　　　　　　④このレストランはどうですいか。		\N	vmod				\N	0
2502	小沢先生の　授業は　どれも　いいと　思うよ。	小沢先生の　授業は　どれも　いいと　思うよ。			\N	vmod				\N	0
2503	じゃあ、村上先生の｢経済史｣は。	じゃあ、村上先生の｢経済史｣は。	①～は。②情報を求める(属性)③(対象)は(どうですか)。　　　　　　　　　　　　　④あのデパートは(どうですか)。		\N	vmod				\N	0
2504	あれは　大変よ。	あれは　大変よ。			\N	vmod				\N	0
2505	友達も　よく　言うんですけど、　何が　大変なんですか。	友達も　よく　言うんですけど、　何が　大変なんですか。	①何が～ですか。②情報を求める(属性)③何が(どう)ですか。　　　　　　　　　　　　　　④何が難しいですか。		\N	vmod				\N	0
2506	出席が厳しくて、宿題が多くて。それに成績は辛くて。	出席が厳しくて、宿題が多くて。それに成績は辛くて。			\N	vmod				\N	0
2508	でも、かなり役に立つと思うけど･･･。	でも、かなり役に立つと思うけど･･･。			\N	vmod				\N	0
2509	では、この間のレポートを返却します。	では、この間のレポートを返却します。			\N	vmod				\N	0
2510	山田君。	山田君。			\N	vmod				\N	0
2511	はい。	はい。			\N	vmod				\N	0
2512	なかなか　よく　書けて　いると　思いました。	なかなか　よく　書けて　いると　思いました。	①よく書けていると思います。②意見を言う。③(意見)と思う。                           ④とてもいい作品だと思います。		\N	vmod				\N	0
2513	あの、結論はこれでいいでしょうか。	あの、結論はこれでいいでしょうか。			\N	vmod				\N	0
2514	そうですね、　もう少し　自分の　意見を　書いた　ほうが　いいと　思います。	そうですね、　もう少し　自分の　意見を　書いた　ほうが　いいと　思います。	①書いたほうがいいと思います。②意見を言う。③～ほうが(意見)と思う。　　　　　　　　　　　　　　④こっちのほうがいいと思います。		\N	vmod				\N	0
2515	そうですか。	そうですか。			\N	vmod				\N	0
2614	それが、かなり急いでいるんです。	それが、かなり急いでいるんです。			\N	vmod				\N	0
2516	それから、　漢字の　間違いに　気を　つけて　くださいね。	それから、　漢字の　間違いに　気を　つけて　くださいね。			\N	vmod				\N	0
2517	あ、　本当だ。	あ、　本当だ。			\N	vmod				\N	0
2518	今度から気をつけます。	今度から気をつけます。			\N	vmod				\N	0
2519	鈴木さん、黒澤の映画って好き。	鈴木さん、黒澤の映画って好き。			\N	vmod				\N	0
2521	どれが　一番　好き。	どれが　一番　好き。			\N	vmod				\N	0
2522	そうですねえ、　「赤ひげ」とか　「夢」が　大好きです。	そうですねえ、　「赤ひげ」とか　「夢」が　大好きです。	①文中の形：大好きです。②機能：嗜好について述べる（もの）③文型：(～が)大好きです。　　　　　　　　　　　　　④例文：旅行が大好きです。		\N	vmod				\N	0
2523	へえ、詳しいんだねえ。	へえ、詳しいんだねえ。			\N	vmod				\N	0
2524	「羅生門」はどう。	「羅生門」はどう。			\N	vmod				\N	0
2525	「羅生門」はちょっと…。	「羅生門」はちょっと…。			\N	vmod				\N	0
1997	大きいのを１つください。	大きいのを１つください。	null		\N	vmod				\N	0
2526	あまり　好きじゃないです。	あまり　好きじゃないです。	①文中の形：好きじゃないです。②機能：嗜好について述べる（もの）　　　　　　　　　　　　　③文型：(～が/は)好きじゃないです。④例文：焼肉は好きじゃないです。		\N	vmod				\N	0
2527	来週、　黒澤の　映画祭が　あるんだけど、　一緒に　行く。	来週、　黒澤の　映画祭が　あるんだけど、　一緒に　行く。			\N	vmod				\N	0
2528	えっ、いいんですか。	えっ、いいんですか。			\N	vmod				\N	0
2529	うれしい。	うれしい。			\N	vmod				\N	0
2530	鈴木さんは、　よく　料理するの？	鈴木さんは、　よく　料理するの？			\N	vmod				\N	0
2531	ええ、食べるのが好きなので。	ええ、食べるのが好きなので。	①すきなので。②嗜好について述べる（行動）③(行動)がすきです。　　　　　　　　　　　　　④走るのがすきなので。		\N	vmod				\N	0
2532	得意な料理は何？	得意な料理は何？			\N	vmod				\N	0
2533	スパゲッティとかパエーリアとか。	スパゲッティとかパエーリアとか。			\N	vmod				\N	0
2534	へえ、鈴木さんって、グルメなんだ。	へえ、鈴木さんって、グルメなんだ。			\N	vmod				\N	0
2535	じゃあ、食事は毎日、自分で？	じゃあ、食事は毎日、自分で？			\N	vmod				\N	0
2536	どうも　片付けるのが　苦手なので、　毎日は　作りません。	どうも　片付けるのが　苦手なので、　毎日は　作りません。			\N	vmod				\N	0
2537	たしかに。	たしかに。			\N	vmod				\N	0
2538	食事の後片付けって、面倒だよね。	食事の後片付けって、面倒だよね。			\N	vmod				\N	0
2539	すみません、　拡大コピーを　したいのですが。	すみません、　拡大コピーを　したいのですが。			\N	vmod				\N	0
2540	じゃあ、　まず、　この　ボタンを　押して　ください。	じゃあ、　まず、　この　ボタンを　押して　ください。	①まず　②手順と順序について述べる　③まず、〜。　④困ったことがあったら、まず、留学生課に相談してください。		\N	vmod				\N	0
2541	はい。	はい。			\N	vmod				\N	0
2542	次に、倍率を選んで。	次に、倍率を選んで。	①次に　②手順と順序について述べる　③次に、〜。　④今日は休みだから、まず洗濯をして、次に部屋の掃除をして、それから買い物に行きます。		\N	vmod				\N	0
2543	はい。	はい。			\N	vmod				\N	0
2544	最後に　この　ボタンで　用紙を　選んで、　スタートボタンを　押します。	最後に　この　ボタンで　用紙を　選んで、　スタートボタンを　押します。	①最後に　②手順と順序について述べる　③最後に、〜。　④今回の旅行では、まず京都に行って、次に奈良に行って、最後に大阪に行きました。		\N	vmod				\N	0
2545	わかりました。	わかりました。			\N	vmod				\N	0
2546	ところで、　コピーカードは　持って　いますか。	ところで、　コピーカードは　持って　いますか。			\N	vmod				\N	0
2547	あっ、　先生から　預かるのを　忘れた。	あっ、　先生から　預かるのを　忘れた。			\N	vmod				\N	0
2549	もしもし、　田村ですけど。	もしもし、　田村ですけど。			\N	vmod				\N	0
2550	ああ、田村さん。	ああ、田村さん。			\N	vmod				\N	0
2799	この　ドアは　押すと、　開きます。	この　ドアは　押すと、　開きます。	\N		\N	vmod				106	0
2551	先輩、　最近　学校で　お会いしませんが、　どうか　しましたか。	先輩、　最近　学校で　お会いしませんが、　どうか　しましたか。	①最近学校でお会いしませんが、どうかしましたか。　②どうしているかを尋ねる　③どう　④最近どうですか。		\N	vmod				\N	0
2552	いや、　ちょっと　足を　けがして　しまって。	いや、　ちょっと　足を　けがして　しまって。			\N	vmod				\N	0
2553	えっ、そうだったんですか。	えっ、そうだったんですか。			\N	vmod				\N	0
2554	大丈夫ですか。	大丈夫ですか。			\N	vmod				\N	0
2555	ええ、　もう　大丈夫です。	ええ、　もう　大丈夫です。			\N	vmod				\N	0
2556	それで、論文のほうはどうですか。	それで、論文のほうはどうですか。	①どうですか　②どうしているかを尋ねる　③どうですか。　④最近、調子はどうですか。		\N	vmod				\N	0
2557	何とかがんばっていますよ。	何とかがんばっていますよ。			\N	vmod				\N	0
2558	あまり、無理はなさらないでくださいね。	あまり、無理はなさらないでくださいね。			\N	vmod				\N	0
2559	はい。	はい。			\N	vmod				\N	0
2561	どうかお大事に。	どうかお大事に。			\N	vmod				\N	0
2565	もし、雨が降ったら、大会は中止ですか。	もし、雨が降ったら、大会は中止ですか。			\N	vmod				\N	0
2566	いいえ。	いいえ。			\N	vmod				\N	0
2567	小雨程度なら、中止にはならないと思いますが。	小雨程度なら、中止にはならないと思いますが。	①小雨程度なら、中止にはならない　②ある条件での行動を言う　③条件表現　〜なら、〜。　④風邪をひいたのなら、早く病院に行ったほうがいいですよ。		\N	vmod				\N	0
2568	じゃあ、大雨の場合は、授業がありますか。	じゃあ、大雨の場合は、授業がありますか。			\N	vmod				\N	0
2569	いいえ。	いいえ。			\N	vmod				\N	0
2570	授業はないと思います。	授業はないと思います。			\N	vmod				\N	0
2571	ああ、　明日、　雨だと　いいなあ。	ああ、　明日、　雨だと　いいなあ。			\N	vmod				\N	0
2572	どうして。	どうして。			\N	vmod				\N	0
2573	明日　雨だったら、　友達と　映画を　見に　いく　約束を　して　いるんです。	明日　雨だったら、　友達と　映画を　見に　いく　約束を　して　いるんです。	①明日雨だったら、友達と映画を見にいく　②ある条件での行動を言う　③条件表現　〜たら、〜　④値段が高かったら、買いません。		\N	vmod				\N	0
2575	来週の　飲み会、　新宿と、　吉祥寺と、　池袋の　中で、　どこが　一番　いいでしょうか。	来週の　飲み会、　新宿と、　吉祥寺と、　池袋の　中で、　どこが　一番　いいでしょうか。			\N	vmod				\N	0
2576	池袋は遠いから、やめませんか。	池袋は遠いから、やめませんか。			\N	vmod				\N	0
2577	そうですね。	そうですね。			\N	vmod				\N	0
2578	じゃあ、　新宿と　吉祥寺と、　どちらが　いいでしょうか。	じゃあ、　新宿と　吉祥寺と、　どちらが　いいでしょうか。			\N	vmod				\N	0
2579	吉祥寺より　新宿の　ほうが　安い　店が　多いですから、　新宿に　しませんか。	吉祥寺より　新宿の　ほうが　安い　店が　多いですから、　新宿に　しませんか。	①吉祥寺より新宿のほうが安い店が多い　②比べて述べる　③比較する表現　ＡよりＢのほうが〜。　④野球よりサッカーのほうが好きです。		\N	vmod				\N	0
2580	たしかにそうですね。	たしかにそうですね。			\N	vmod				\N	0
2581	じゃ、新宿にしましょう。	じゃ、新宿にしましょう。			\N	vmod				\N	0
2582	田村さん。	田村さん。			\N	vmod				\N	0
2584	就職活動は進んでいますか。	就職活動は進んでいますか。			\N	vmod				\N	0
2585	それが、なかなか思い通りに進まなくて。	それが、なかなか思い通りに進まなくて。			\N	vmod				\N	0
2586	そう。	そう。			\N	vmod				\N	0
2587	それで、どのような仕事を考えているんですか。	それで、どのような仕事を考えているんですか。			\N	vmod				\N	0
2588	日本語を　教える　仕事です。	日本語を　教える　仕事です。			\N	vmod				\N	0
2590	それじゃ、　外国で　教えると　いうのは　どうですか。	それじゃ、　外国で　教えると　いうのは　どうですか。	①外国で教えるというのはどうですか　②提案する　③〜はどうですか　④飛行機で行くのは高いから、寝台車で行くというのはどうですか。		\N	vmod				\N	0
2591	ちょうど、　韓国の　大学で　日本語教師を　募集して　いるんですよ。	ちょうど、　韓国の　大学で　日本語教師を　募集して　いるんですよ。			\N	vmod				\N	0
2592	え、そうなんですか。	え、そうなんですか。			\N	vmod				\N	0
2593	興味があれば、推薦書を書いてあげますよ。	興味があれば、推薦書を書いてあげますよ。			\N	vmod				\N	0
2594	わあ、うれしい。	わあ、うれしい。			\N	vmod				\N	0
2595	じゃあ、これから真剣に考えてみます。	じゃあ、これから真剣に考えてみます。			\N	vmod				\N	0
2596	はい、　では　今日の　授業は　ここまで。 	はい、　では　今日の　授業は　ここまで。 			\N	vmod				\N	0
2598	来週の授業、休ませていただきたいのですが。	来週の授業、休ませていただきたいのですが。			\N	vmod				\N	0
2600	じつは、就職の最終面接があるんです。	じつは、就職の最終面接があるんです。	①就職の面接があるんです　②理由を述べる　③関連づけ　〜ん（の）です　④昨日は遅刻してしまいました。電車が遅れたんです。		\N	vmod				\N	0
2601	そうですか。	そうですか。			\N	vmod				\N	0
2603	はい、　会社が　遠くに　あるので、　無理だと　思います。	はい、　会社が　遠くに　あるので、　無理だと　思います。	①会社が遠くにあるので　②理由を述べる　③理由を表す表現　〜ので　④ちょっと用事があるので、お先に失礼します。		\N	vmod				\N	0
2605	じゃ、面接、がんばってくださいね。	じゃ、面接、がんばってくださいね。			\N	vmod				\N	0
2606	がんばります。	がんばります。			\N	vmod				\N	0
2607	先生、お忙しいところを申し訳ありません。	先生、お忙しいところを申し訳ありません。			\N	vmod				\N	0
2608	実は　来年、　アメリカの　大学に　留学しようと　思って　いるのですが。	実は　来年、　アメリカの　大学に　留学しようと　思って　いるのですが。			\N	vmod				\N	0
2610	それは、いいですね。	それは、いいですね。			\N	vmod				\N	0
2611	それで、先生に推薦書を書いていただきたいのですが、よろしいでしょうか。	それで、先生に推薦書を書いていただきたいのですが、よろしいでしょうか。	①推薦書を書いていただきたいのですが、よろしいでしょうか　②依頼する　③〜ていただきたいのですが　④わからないところがあるので、教えていただきたいのですが、よろしいでしょうか。		\N	vmod				\N	0
2612	いいですよ。	いいですよ。			\N	vmod				\N	0
2719	うん、そうね。	うん、そうね。			\N	vmod				\N	0
2615	来週の　金曜日までに　お願い　できないでしょうか。	来週の　金曜日までに　お願い　できないでしょうか。	①お願いできないでしょうか　②依頼する　③お願いできないでしょうか　④メールではなく、ファックスでお願いできないでしょうか。		\N	vmod				\N	0
2616	それなら、だいじょうぶですよ。	それなら、だいじょうぶですよ。			\N	vmod				\N	0
2617	ありがとうございます。	ありがとうございます。			\N	vmod				\N	0
2618	これで、ほっとしました。	これで、ほっとしました。			\N	vmod				\N	0
2619	学園祭があるんですか。	学園祭があるんですか。			\N	vmod				\N	0
2621	今月の18日からです。	今月の18日からです。			\N	vmod				\N	0
2622	どんな催し物があるんですか。	どんな催し物があるんですか。			\N	vmod				\N	0
2657	皆さん、　来週の　シンポジウム、　よろしく　お願いします。	皆さん、　来週の　シンポジウム、　よろしく　お願いします。			\N	vmod				\N	0
2659	先生、そのシンポジウムは必ず出なければいけませんか。	先生、そのシンポジウムは必ず出なければいけませんか。	①出なければいけませんか　②義務を確認する　③Vなければいけませんか。④雨でも行かなければなりませんか。		\N	vmod				\N	0
2623	ここは　外語大ですから、　いろんな　国の　音楽を　演奏したり、　お芝居や　ダンスを　やったり、　料理店を　出したり　します。	ここは　外語大ですから、　いろんな　国の　音楽を　演奏したり、　お芝居や　ダンスを　やったり、　料理店を　出したり　します。	①いろいろな国の音楽を演奏したり、お芝居やダンスをやったり、料理店を出したりします　②例をあげて述べる　③〜たり、〜たりします。　④日曜日は、買い物に行ったり、映画を見たりします。		\N	vmod				\N	0
2624	へえ。	へえ。			\N	vmod				\N	0
2625	で、　どんな　料理が　食べられるんですか。	で、　どんな　料理が　食べられるんですか。			\N	vmod				\N	0
2626	そう、　タイや　韓国や　イタリアや　いろいろな　国の　食べ物が　あります。	そう、　タイや　韓国や　イタリアや　いろいろな　国の　食べ物が　あります。	①タイや韓国やイタリアや、いろいろな国の食べ物　②例をあげて述べる　③〜や〜　④日本語の授業は、会話や聴解、読解の授業などがあります。		\N	vmod				\N	0
2628	それは　楽しそうですね。	それは　楽しそうですね。			\N	vmod				\N	0
2629	じゃ、子どもを連れて来ます。	じゃ、子どもを連れて来ます。			\N	vmod				\N	0
2630	ぜひいらしてください。	ぜひいらしてください。			\N	vmod				\N	0
2631	お待ちしています。	お待ちしています。			\N	vmod				\N	0
2632	いらっしゃいませ。	いらっしゃいませ。			\N	vmod				\N	0
2633	ご注文は。	ご注文は。			\N	vmod				\N	0
2634	天ぷらうどん、お願いします。	天ぷらうどん、お願いします。			\N	vmod				\N	0
2635	ごめんなさい。	ごめんなさい。			\N	vmod				\N	0
2636	天ぷらがもう終わってしまったんですよ。	天ぷらがもう終わってしまったんですよ。			\N	vmod				\N	0
2638	うどんは他に何がありますか。	うどんは他に何がありますか。			\N	vmod				\N	0
2639	たぬきかきつねならありますけど。	たぬきかきつねならありますけど。			\N	vmod				\N	0
2640	たぬきかきつねね。	たぬきかきつねね。			\N	vmod				\N	0
2641	じゃあ、きつねうどんでいいです。	じゃあ、きつねうどんでいいです。	①きつねうどんでいいです　②妥協する　③〜でいいです　④本当はこの色の靴がほしいんですけど、サイズがないなら別の色でいいです。		\N	vmod				\N	0
2642	はい、きつねですね。	はい、きつねですね。			\N	vmod				\N	0
2643	少々お待ちください。	少々お待ちください。			\N	vmod				\N	0
2645	この電子辞書、いいですねえ。	この電子辞書、いいですねえ。			\N	vmod				\N	0
2646	そうだろ。	そうだろ。			\N	vmod				\N	0
2647	最近、買ったんだ。	最近、買ったんだ。			\N	vmod				\N	0
2804	友だちに　電話番号を　教えました。	友だちに　電話番号を　教えました。	\N		\N	vmod				536	0
2648	次の　講読の　授業で　お借りしても　いいですか。	次の　講読の　授業で　お借りしても　いいですか。	①お借りしてもいいですか　②許可を求める　③〜てもいいですか。　④写真を撮ってもいいですか。		\N	vmod				\N	0
2649	うーん…。	うーん…。			\N	vmod				\N	0
2650	まあ、いいよ。	まあ、いいよ。			\N	vmod				\N	0
2652	いいけど。	いいけど。			\N	vmod				\N	0
2653	僕、　３限目に　使うから、　それまでには　返して　くれよ。	僕、　３限目に　使うから、　それまでには　返して　くれよ。			\N	vmod				\N	0
2714	それなら、　早く　病院に　行った　ほうが　いいですよ。	それなら、　早く　病院に　行った　ほうが　いいですよ。	①行ったほうがいいですよ　②助言する　③Vたほうがいいです　④風邪のときは病院に行ったほうがいいですよ。		\N	vmod				\N	0
2715	インフルエンザかもしれませんから。	インフルエンザかもしれませんから。			\N	vmod				\N	0
2717	でも、　もうすぐ　卒論の　締め切りなの。	でも、　もうすぐ　卒論の　締め切りなの。			\N	vmod				\N	0
2748	はい、先生、４年間、ありがとうございました。	はい、先生、４年間、ありがとうございました。			\N	vmod				\N	0
2749	薬は朝だけ飲みます。	薬は朝だけ飲みます。	\N		\N	vmod				205	0
2718	でも、　無理は　絶対　しない　ほうが　いいです。	でも、　無理は　絶対　しない　ほうが　いいです。	①しないほうがいいです　②助言する　③Vないほうがいいです　④風邪のときはお風呂に入らない方がいいです。		\N	vmod				\N	0
2721	もしもし、　謝恩会の　会場を　予約したいんですけど。	もしもし、　謝恩会の　会場を　予約したいんですけど。			\N	vmod				\N	0
2722	3月25日の6時からです。	3月25日の6時からです。			\N	vmod				\N	0
2723	30名で、　一人　一万円ぐらいで　お願いできますか。	30名で、　一人　一万円ぐらいで　お願いできますか。			\N	vmod				\N	0
2724	はい、田村と申します。	はい、田村と申します。			\N	vmod				\N	0
2725	それから、　ホテルの　パンフレットを　送って　ほしいんですが。	それから、　ホテルの　パンフレットを　送って　ほしいんですが。	①送ってほしいんですが　②要求する　③Vてほしい　④すみません、資料を見せてほしいのですが。		\N	vmod				\N	0
2726	はい、住所は、東京都府中市朝日町3の11の1です。	はい、住所は、東京都府中市朝日町3の11の1です。			\N	vmod				\N	0
2727	はい、　では、　よろしく　お願いします。	はい、　では、　よろしく　お願いします。			\N	vmod				\N	0
2728	先輩、もうすぐ卒業ですね。 	先輩、もうすぐ卒業ですね。 			\N	vmod				\N	0
2729	就職は、もう決まりましたか。 	就職は、もう決まりましたか。 			\N	vmod				\N	0
2730	ああ、商社に決まったんだ。	ああ、商社に決まったんだ。			\N	vmod				\N	0
2731	おめでとうございます。	おめでとうございます。			\N	vmod				\N	0
2733	鈴木さんは、将来、どんな仕事をしたいと思っているの。	鈴木さんは、将来、どんな仕事をしたいと思っているの。			\N	vmod				\N	0
2735	へえ、それはすごいね。	へえ、それはすごいね。			\N	vmod				\N	0
2736	どこに行きたいの。	どこに行きたいの。			\N	vmod				\N	0
2149	すごくおいしい。	すごくおいしい。	null		\N	vmod				\N	0
1496	日本語の辞書はありますか。	日本語の辞書はありますか。	null		\N	vmod				\N	0
2737	ビジネス英語を勉強しているので、やっぱりアメリカに行きたいですね。	ビジネス英語を勉強しているので、やっぱりアメリカに行きたいですね。	①アメリカに行きたいです　②希望を述べる　③Vたいです　④いつかあなたに会いに行きたいです。		\N	vmod				\N	0
2739	お待たせ。	お待たせ。			\N	vmod				\N	0
2740	ありがとうございました。	ありがとうございました。			\N	vmod				\N	0
2741	あ、斉藤先生。	あ、斉藤先生。			\N	vmod				\N	0
2742	野村君、卒業おめでとう。	野村君、卒業おめでとう。			\N	vmod				\N	0
2743	ありがとうございます。	ありがとうございます。			\N	vmod				\N	0
2745	浩二の母でございます。	浩二の母でございます。			\N	vmod				\N	0
2746	浩二が　大変　お世話に　なりました。	浩二が　大変　お世話に　なりました。			\N	vmod				\N	0
2747	いいえ、　野村君、　これから　立派な　社会人に　なって　くださいね。	いいえ、　野村君、　これから　立派な　社会人に　なって　くださいね。			\N	vmod				\N	0
2750	薬を飲んで寝ます。	薬を飲んで寝ます。	\N		\N	vmod				205	0
2752	歯をみがきます。	歯をみがきます。	\N		\N	vmod				505	0
2760	佐藤さんは　髪が　短いです。	佐藤さんは　髪が　短いです。	\N		\N	vmod				619	0
2765	かぜで、　熱が　３８度　あります。	かぜで、　熱が　３８度　あります。	\N		\N	vmod				432	0
2768	テーブルの　上に　花瓶が　置いて　あります。	テーブルの　上に　花瓶が　置いて　あります。	\N		\N	vmod				414	0
2770	寝る　前に　ストーブを　消さないと、　危ないです。	寝る　前に　ストーブを　消さないと、　危ないです。	\N		\N	vmod				323	0
2773	テープレコーダーに　テープを　入れます。	テープレコーダーに　テープを　入れます。	\N		\N	vmod				415	0
2150	わたし、きのう、あれから映画見て、ごはん食べた。	わたし、きのう、あれから映画見て、ごはん食べた。	null		\N	vmod				\N	0
2816	日本人は　はしを　使って、　ごはんを　食べます。	日本人は　はしを　使って、　ごはんを　食べます。	\N		\N	vmod				513	0
2827	スイッチを　入れて、　電気を　つけます。　	スイッチを　入れて、　電気を　つけます。　	\N		\N	vmod				68	0
2849	きのう　中国から　来た　留学生と　会いました。	きのう　中国から　来た　留学生と　会いました。	\N		\N	vmod				681	0
2850	来月　韓国から　留学生が　来ます。	来月　韓国から　留学生が　来ます。	\N		\N	vmod				681	0
2859	両親が　野球の　練習を　見に　来ました。	両親が　野球の　練習を　見に　来ました。	\N		\N	vmod				690	0
2151	わたしは急ぎます。	わたしは急ぎます。	null		\N	vmod				\N	0
2872	学校で　松井さんと　一緒に　いる　時間が　一番　長いです。	学校で　松井さんと　一緒に　いる　時間が　一番　長いです。	\N		\N	vmod				468	0
2883	毎日　ラジオで　ニュースを　聞きます。	毎日　ラジオで　ニュースを　聞きます。	\N		\N	vmod				183	0
2897	刺身に　しょうゆを　つけて　食べます。	刺身に　しょうゆを　つけて　食べます。	\N		\N	vmod				407	0
2904	この　ドアは　壊れて　いるので、　開きません。	この　ドアは　壊れて　いるので、　開きません。	\N		\N	vmod				433	0
2905	花瓶が　壊れて　しまいました。	花瓶が　壊れて　しまいました。	\N		\N	vmod				163	0
2922	スポーツは　野球が　一番　好きです。	スポーツは　野球が　一番　好きです。	\N		\N	vmod				325	0
2930	もう　遅いので、　家へ　帰ります。	もう　遅いので、　家へ　帰ります。	\N		\N	vmod				107	0
2932	大学の　前に　大きな　本屋が　できました。	大学の　前に　大きな　本屋が　できました。	\N		\N	vmod				418	0
2938	あの　人は　この　大学の　外国人教師です。	あの　人は　この　大学の　外国人教師です。	\N		\N	vmod				136	0
2942	夏休みは　国へ　帰ります。	夏休みは　国へ　帰ります。	\N		\N	vmod				210	0
2945	来年　海外へ　旅行に　行こうと　思って　います。	来年　海外へ　旅行に　行こうと　思って　います。	\N		\N	vmod				715	0
2963	その　スカートを　見せて　ください。	その　スカートを　見せて　ください。	\N		\N	vmod				723	0
2964	一番　安い　魚を　２匹　ください。	一番　安い　魚を　２匹　ください。	\N		\N	vmod				723	0
2972	松井さんに　コピーした　紙を　渡しました。	松井さんに　コピーした　紙を　渡しました。	\N		\N	vmod				253	0
2980	会社へ　行く　とき、　スーツを　着て、　ネクタイを　します。	会社へ　行く　とき、　スーツを　着て、　ネクタイを　します。	\N		\N	vmod				496	0
2985	仕事で　人と　会うので、　ネクタイを　します。	仕事で　人と　会うので、　ネクタイを　します。	\N		\N	vmod				760	0
2990	長い　時間　仕事を　して　いたので、　少し　休みます。	長い　時間　仕事を　して　いたので、　少し　休みます。	\N		\N	vmod				654	0
3003	かぜを　ひいたので、 家で　寝て　いました。	かぜを　ひいたので、 家で　寝て　いました。	\N		\N	vmod				761	0
3004	この　歌が　いちばん　好きです。	この　歌が　いちばん　好きです。	\N		\N	vmod				74	0
3020	寝る　前に、　ストーブを　消します。	寝る　前に、　ストーブを　消します。	\N		\N	vmod				323	0
3031	風の　強い　日は　テニスが　できません。	風の　強い　日は　テニスが　できません。	\N		\N	vmod				711	0
3032	雪の　日に　出かけるのは　危ないです。	雪の　日に　出かけるのは　危ないです。	\N		\N	vmod				663	0
3033	少し　暑いので、　窓を　開けます。	少し　暑いので、　窓を　開けます。	\N		\N	vmod				712	0
3049	夜は　寒く　なるので、　コートを　持って　出かけます。	夜は　寒く　なるので、　コートを　持って　出かけます。	\N		\N	vmod				273	0
2325	もう、　十時半ですよ。	もう、　十時半ですよ。			\N	vmod				\N	0
3054	あの　美容師は　きれいで　細いです。	あの　美容師は　きれいで　細いです。	\N		\N	vmod				762	0
3055	大学を　出たら、　美容師に　なりたいです。	大学を　出たら、　美容師に　なりたいです。	\N		\N	vmod				762	0
3061	この　箱は　横が　長いです。	この　箱は　横が　長いです。	\N		\N	vmod				668	0
3082	なくした　時計が　見つかりました。	なくした　時計が　見つかりました。	\N		\N	vmod				770	0
3083	よく　探せば、　見つかります。	よく　探せば、　見つかります。	\N		\N	vmod				770	0
3085	かぎが　ないので、　かばんの　中を　探しました。	かぎが　ないので、　かばんの　中を　探しました。	\N		\N	vmod				773	0
3090	あの　食堂の　定食は　安くて　おいしいです。	あの　食堂の　定食は　安くて　おいしいです。	\N		\N	vmod				775	0
3113	いちばん　安い　魚を　二匹　ください。	いちばん　安い　魚を　二匹　ください。	\N		\N	vmod				723	0
3125	この　町の　水は　きれいです。	この　町の　水は　きれいです。	\N		\N	vmod				200	0
3152	たくさん　買い物を　したので、　お金が　なくなりました。	たくさん　買い物を　したので、　お金が　なくなりました。	\N		\N	vmod				139	0
3166	イさんは　日本語が　話せます。	イさんは　日本語が　話せます。	\N		\N	vmod				811	0
2450	はい。	はい。			\N	vmod				\N	0
3191	ズボンより　スカートの　ほうが　好きです。	ズボンより　スカートの　ほうが　好きです。	\N		\N	vmod				315	0
3325	今晩　駅で　イさんに　会います。	今晩　駅で　イさんに　会います。	\N		\N	vmod				2	0
1429	とても　勉強します。	とても　勉強します。	null		\N	vmod				\N	0
3200	しょうゆを　つけて、　さしみを　食べます。	しょうゆを　つけて、　さしみを　食べます。	\N		\N	vmod				803	0
3203	砂糖と　塩を　使って、　料理を　作ります。	砂糖と　塩を　使って、　料理を　作ります。	\N		\N	vmod				280	0
3222	目が　悪いので、　眼鏡を　かけます。	目が　悪いので、　眼鏡を　かけます。	\N		\N	vmod				637	0
3228	食べる　前に、　手を　洗います。	食べる　前に、　手を　洗います。	\N		\N	vmod				412	0
2326	あっ、　本当だ。	あっ、　本当だ。			\N	vmod				\N	0
2327	急がないと。	急がないと。			\N	vmod				\N	0
2473	いいですね。	いいですね。			\N	vmod				\N	0
3258	ここから　少し　西へ　行くと、　海が　あります。	ここから　少し　西へ　行くと、　海が　あります。	\N		\N	vmod				539	0
2499	わかりました。	わかりました。			\N	vmod				\N	0
3286	山田さんは　来月　東京に　行くそうです。	山田さんは　来月　東京に　行くそうです。	\N		\N	vmod				675	0
3304	船便で　手紙を　出すと、　ひとつき　かかります。	船便で　手紙を　出すと、　ひとつき　かかります。	\N		\N	vmod				547	0
3308	イさんは　ひとつきで　日本語が　とても　上手に　なりました。	イさんは　ひとつきで　日本語が　とても　上手に　なりました。	\N		\N	vmod				547	0
3345	これは　日本で　売って　いない　服です。	これは　日本で　売って　いない　服です。	\N		\N	vmod				79	0
2152	日本の　冬は　寒いです。	日本の　冬は　寒いです。	null		\N	vmod				\N	0
3359	電話を　切る　前に、　「さようなら」と　言います。	電話を　切る　前に、　「さようなら」と　言います。	\N		\N	vmod				818	0
3360	きのう　友達に　電話を　かけましたが、　すぐ　切りました。	きのう　友達に　電話を　かけましたが、　すぐ　切りました。	\N		\N	vmod				818	0
3400	鳥が　鳴いて　います。	鳥が　鳴いて　います。	\N		\N	vmod				470	0
3401	あの　猫は　かわいい　声で　鳴きます。	あの　猫は　かわいい　声で　鳴きます。	\N		\N	vmod				470	0
3440	あそこの　八百屋は　毎月　１４日が　安いです。	あそこの　八百屋は　毎月　１４日が　安いです。	\N		\N	vmod				488	0
1309	どのかばんですか。	どのかばんですか。	null		\N	vmod				\N	0
3461	きのうは　一日中　テレビを　見て　いました。	きのうは　一日中　テレビを　見て　いました。	\N		\N	vmod				397	0
3471	この　ドアは　開きません。	この　ドアは　開きません。	\N		\N	vmod				433	0
3475	暗い　ところで　本を　読んでは　いけません。	暗い　ところで　本を　読んでは　いけません。	\N		\N	vmod				7	0
3566	この　クラスには　学生が　九人　います。	この　クラスには　学生が　九人　います。	\N		\N	vmod				813	0
3567	来週　四人で　遊びに　行きます。	来週　四人で　遊びに　行きます。	\N		\N	vmod				813	0
3910	ドアが　開きます。	ドアが　開きます。	\N		\N	vmod				433	0
3601	田中さんは　たいへんな　仕事を　して　います。	田中さんは　たいへんな　仕事を　して　います。	\N		\N	vmod				368	0
3602	たくさん　漢字を　覚えなければ　ならないので、　たいへんです。	たくさん　漢字を　覚えなければ　ならないので、　たいへんです。	\N		\N	vmod				368	0
1806	木村さんは留学しようと思っています。	木村さんは留学しようと思っています。	null		\N	vmod				\N	0
1873	うれしい。	うれしい。	null		\N	vmod				\N	0
1939	あの人は歌手のようです。	あの人は歌手のようです。	null		\N	vmod				\N	0
2037	すみません、パソコンが動かないのですけれども。	すみません、パソコンが動かないのですけれども。	null		\N	vmod				\N	0
2098	母はわたしにてぶくろをあんでくれました。	母はわたしにてぶくろをあんでくれました。	null		\N	vmod				\N	0
2197	雨が降ったのに運動会がありました。	雨が降ったのに運動会がありました。	null		\N	vmod				\N	0
2367	はい。	はい。			\N	vmod				\N	0
2381	どうぞ。	どうぞ。			\N	vmod				\N	0
2431	先輩の予定は。	先輩の予定は。			\N	vmod				\N	0
2471	はい。	はい。			\N	vmod				\N	0
2583	はい。	はい。			\N	vmod				\N	0
2609	そうですか。	そうですか。			\N	vmod				\N	0
2697	じゃ、出なくてもいいですよ。	じゃ、出なくてもいいですよ。	①出なくてもいいです　②義務を否定する　③Vなくてもいいです　④雨の日は掃除しなくてもいいです。		\N	vmod				\N	0
3112	カレーと　水を　ください。	カレーと　水を　ください。	\N		\N	vmod				723	0
3393	週末、　山を　登ります。	週末、　山を　登ります。	\N		\N	vmod				501	0
1	朝です。	朝です。	null		\N	vmod				\N	0
160	15あります。	15あります。	null		\N	vmod				\N	0
388	田中さんが来て、木村さんが帰りました。	田中さんが来て、木村さんが帰りました。	null		\N	vmod				\N	0
2482	はい。	はい。			\N	vmod				\N	0
490	はい。	はい。	null		\N	vmod				\N	0
662	はい。	はい。	null		\N	vmod				\N	0
1000	たいしたもんだ。	たいしたもんだ。	null		\N	vmod				\N	0
1113	言うのです。	言うのです。	null		\N	vmod				\N	0
1615	ゴミ箱にごみを捨てます。	ゴミ箱にごみを捨てます。	null		\N	vmod				\N	0
1697	これをください。	これをください。	null		\N	vmod				\N	0
1332	４時です。	４時です。	null		\N	vmod				\N	0
1853	いいえ、すきではありません。	いいえ、すきではありません。	null		\N	vmod				\N	0
1807	木村さんは留学しようと思いますか。	木村さんは留学しようと思いますか。	null		\N	vmod				\N	0
1802	西の　空に　日が　沈もうと　して　います。	西の　空に　日が　沈もうと　して　います。	null		\N	vmod				\N	0
1803	花が散ろうとしています。	花が散ろうとしています。	null		\N	vmod				\N	0
1804	あしたは　早く　起きようと　思います。	あしたは　早く　起きようと　思います。	null		\N	vmod				\N	0
1805	夏休みに　旅行しようと　思って　います。	夏休みに　旅行しようと　思って　います。	null		\N	vmod				\N	0
1808	きょうから　日記を　書こうと　思います。	きょうから　日記を　書こうと　思います。	null		\N	vmod				\N	0
1809	きょうは　食堂で　昼食を　食べようと　思います。	きょうは　食堂で　昼食を　食べようと　思います。	null		\N	vmod				\N	0
858	安ければ、買います。	安ければ、買います。	null		\N	vmod				\N	0
994	日本の冬は寒い。	日本の冬は寒い。	null		\N	vmod				\N	0
3793	教室の　電気を　つけて　ください。	教室の　電気を　つけて　ください。	\N		\N	vmod				802	0
157	100円です。	100円です。	null		\N	vmod				\N	0
1282	どんな　かばんですか。	どんな　かばんですか。	null		\N	vmod				\N	0
117	日本の古い映画です。	日本の古い映画です。	null		\N	vmod				\N	0
267	きょうは暑い日です。	きょうは暑い日です。	null		\N	vmod				\N	0
478	２と３で５です。	２と３で５です。	null		\N	vmod				\N	0
2174	こちらから　お電話　さしあげます。	こちらから　お電話　さしあげます。	null		\N	vmod				\N	0
2242	ジュースしかありません。	ジュースしかありません。	null		\N	vmod				\N	0
2496	印刷センターのとなりです。	印刷センターのとなりです。			\N	vmod				\N	0
3794	辞書を　貸して　ください。	辞書を　貸して　ください。	\N		\N	vmod				802	0
2	朝ではありません。	朝ではありません。	null		\N	vmod				\N	0
3	学生です。	学生です。	null		\N	vmod				\N	0
140	それです。	それです。	null		\N	vmod				\N	0
291	頭が痛いですか。	頭が痛いですか。	null		\N	vmod				\N	0
335	"窓を開けました。	"窓を開けました。	null		\N	vmod				\N	0
838	日曜日だけれども、学校に行きますか。	日曜日だけれども、学校に行きますか。	null		\N	vmod				\N	0
868	近いなら歩きましょう。	近いなら歩きましょう。	null		\N	vmod				\N	0
1181	学校は休みではありません。	学校は休みではありません。	null		\N	vmod				\N	0
1224	教室に田中さんがいます。	教室に田中さんがいます。	null		\N	vmod				\N	0
1363	試験は終わりましたか。	試験は終わりましたか。	null		\N	vmod				\N	0
1503	いいえ、　知りません。	いいえ、　知りません。	null		\N	vmod				\N	0
1703	はい。	はい。	null		\N	vmod				\N	0
1774	はい。	はい。	null		\N	vmod				\N	0
1916	今ごろは、山田さんはひまにちがいありません。 	今ごろは、山田さんはひまにちがいありません。 	null		\N	vmod				\N	0
2089	花に水をやります。	花に水をやります。	null		\N	vmod				\N	0
2339	そう、それはよかった。	そう、それはよかった。			\N	vmod				\N	0
2432	私は　少し　バイトを　しようと　思って　いるの。	私は　少し　バイトを　しようと　思って　いるの。	①バイトをしようと思っているの　②予定を言う　③意向形（う／よう）と思います／思っています　④土曜日は映画を見ようと思っています		\N	vmod				\N	0
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
1232	ありません。	ありません。	null		\N	vmod				\N	0
1352	毎日、勉強しますか。	毎日、勉強しますか。	null		\N	vmod				\N	0
2602	じゃ、　授業の　後の　飲み会にも　来られませんか。	じゃ、　授業の　後の　飲み会にも　来られませんか。			\N	vmod				\N	0
2604	そうですか。	そうですか。			\N	vmod				\N	0
2627	そうですか。	そうですか。			\N	vmod				\N	0
2644	先輩。	先輩。			\N	vmod				\N	0
2658	はい。	はい。			\N	vmod				\N	0
4	学生ではありません。	学生ではありません。	null		\N	vmod				\N	0
2903	寒いので、　ドアを　閉めます。	寒いので、　ドアを　閉めます。	\N		\N	vmod				433	0
1841	はい、ほしいです。	はい、ほしいです。	null		\N	vmod				\N	0
2256	これくらいの大きさです。	これくらいの大きさです。	null		\N	vmod				\N	0
1940	あの人はどうやら歌手のようです。	あの人はどうやら歌手のようです。	null		\N	vmod				\N	0
660	はい。	はい。	null		\N	vmod				\N	0
1097	そのくらいのことはわたしだってできます。	そのくらいのことはわたしだってできます。	null		\N	vmod				\N	0
2673	何ですか。	何ですか。			\N	vmod				\N	0
1902	田中さんは来ますか。	田中さんは来ますか。	null		\N	vmod				\N	0
2046	成績が60点以上だと合格です。	成績が60点以上だと合格です。	null		\N	vmod				\N	0
2298	今行きますよ。	今行きますよ。	null		\N	vmod				\N	0
2352	はい。	はい。			\N	vmod				\N	0
2445	かなり長かったよ。	かなり長かったよ。			\N	vmod				\N	0
2470	じゃ、これ、お願いします。	じゃ、これ、お願いします。			\N	vmod				\N	0
2560	どうもありがとう。	どうもありがとう。			\N	vmod				\N	0
2693	どうして。	どうして。			\N	vmod				\N	0
2732	ありがとう。	ありがとう。			\N	vmod				\N	0
1461	この雑誌は新しい。	この雑誌は新しい。	null		\N	vmod				\N	0
1896	この　問題は、　あしたの　試験に　出るでしょうか。	この　問題は、　あしたの　試験に　出るでしょうか。	null		\N	vmod				\N	0
1897	たぶん　出るでしょう。	たぶん　出るでしょう。	null		\N	vmod				\N	0
1898	きのう、外語大のチームは勝ちましたか。	きのう、外語大のチームは勝ちましたか。	null		\N	vmod				\N	0
1899	わかりません。　でも、　たぶん　勝ったでしょう。	わかりません。　でも、　たぶん　勝ったでしょう。	null		\N	vmod				\N	0
1901	たぶん　田中さんでしょう。	たぶん　田中さんでしょう。	null		\N	vmod				\N	0
1903	たぶん　来ないでしょう。	たぶん　来ないでしょう。	null		\N	vmod				\N	0
1904	客：これはいくらでしょうか。	客：これはいくらでしょうか。	null		\N	vmod				\N	0
1905	店員：それは1000円です。	店員：それは1000円です。	null		\N	vmod				\N	0
1906	あしたは雨が降るだろう。	あしたは雨が降るだろう。	null		\N	vmod				\N	0
1907	田中さんは来ないだろう。	田中さんは来ないだろう。	null		\N	vmod				\N	0
1908	Aチームが勝っただろう。	Aチームが勝っただろう。	null		\N	vmod				\N	0
1909	あしたは日曜日でしょう？	あしたは日曜日でしょう？	null		\N	vmod				\N	0
1910	これは田中さんのでしょう？	これは田中さんのでしょう？	null		\N	vmod				\N	0
1911	わたしがさっき言ったでしょう。	わたしがさっき言ったでしょう。	null		\N	vmod				\N	0
1912	ほら、あそこにコンビニがあるでしょう。	ほら、あそこにコンビニがあるでしょう。	null		\N	vmod				\N	0
2574	なるほど。	なるほど。			\N	vmod				\N	0
2716	ありがとう。	ありがとう。			\N	vmod				\N	0
2564	何か。	何か。			\N	vmod				\N	0
3500	Gunung ini rendah.	ဒီတောင်က နိမ့်တယ်။	\N		\N	vmod				542	1
3109	田中さんは　会社員です。	田中さんは　会社員です。	\N		\N	vmod				787	0
5	春です。	春です。	null		\N	vmod				\N	0
6	春ではありません。	春ではありません。	null		\N	vmod				\N	0
2936	Saya boleh bercakap dalam bahasa Inggeris. 	ကျွန်မ(/ကျွန်တော်) အင်္ဂလိပ်စကား ပြောတတ်တယ်။	\N		\N	vmod				85	1
2937	Saya belajar bahasa Inggeris dengan menggunakan kamus. 	အဘိဓာန်သုံးပြီး အင်္ဂလိပ်စာ လေ့လာတယ်။	\N		\N	vmod				85	1
1350	Encik Tanaka belajar di perpustakaan tetapi saya belajar di rumah. 	မစ္စတာ တာနာခါ က စာကြည့်တိုက်မှာ စာဖတ်မှာဖြစ်ပေမယ့် ကျွန်မ(/ကျွန်တော်)ကတော့ အိမ်မှာပဲ ဖတ်မယ်။	null		\N	vmod				\N	1
1692	Beg itu sama dengan beg saya. 	ဟိုအိတ်က ကျွန်မ(/ကျွန်တော်)အိတ်နဲ့ အတူတူပဲ။	null		\N	vmod				\N	1
3597	Saya memberitahu hari yang saya boleh kepada Encik Lee kerana saya akan keluar bersama beliau pada bulan depan.	နောက်လကျရင် အတူတူ လျှောက်လည်ကြမယ်။ အဲဒီအတွက်  မစ္စတာ လီ ဆီ  ဖြစ်နိုင်မယ့်ရက် ကိုအကြောင်းကြားပါမယ်။	\N		\N	vmod				362	1
3598	Walaupun saya mesti belajar hari ini, tetapi saya boleh esok. 	ဒီနေ့ စာမဖတ်လို့ မရပေမယ့် မနက်ဖန် ဆိုရင်တော့ ဖြစ်ပါတယ်။(ဒီနေ့ စာဖတ်ရမှာမို့  မနက်ဖန် ဆိုရင်တော့ ဖြစ်ပါတယ်။)	\N		\N	vmod				362	1
2154	Filem yang saya tengok semalam itu sangat menarik. 	မနေ့က   ကြည့်ခဲ့တဲ့ ရုပ်ရှင် အရမ်းစိတ်ဝင်စားဖို့ ကောင်းတယ်။	null		\N	vmod				\N	1
3013	Makanan yang saya suka adalah kari. 	ကျွန်မ(/ကျွန်တော်) ကြိုက်တဲ့ စားစရာက ဂျပန်ကာရီ(/မဆလာဟင်းနှင့်ထမင်း) ပါ။	\N		\N	vmod				316	1
3014	Emak saya suka memasak. 	အမေ က ဟင်းချက်ရတာ ကြိုက်တယ်။(အမေ က ဟင်းချက် ဝါသနာပါတယ်။)	\N		\N	vmod				316	1
3785	Minuman yang paling saya suka adalah teh.	ကျွန်မ(/ကျွန်တော်) နံပါတ်တစ် အကြိုက်ဆုံး သောက်စရာ(/ဒွင့်ခ်/အရည်) က လက်ဖက်ရည် ပါ။(သောက်စရာတွေထဲမှာလက်ဖက်ရည်ကိုအကြိုက်ဆုံးပဲ။)	\N		\N	vmod				55	1
3786	Daging ini yang paling murah. 	ဒီအသားက နံပါတ်တစ် ဈေးအပေါဆုံး ပါ။\n(ဒီအသားက ဈေးအပေါဆုံး ပါ။)	\N		\N	vmod				55	1
3336	Saya tidak pergi ke sekolah kerana demam. 	မနေ့က ဖျားလို့ ကျောင်းမသွားဘူး။	\N		\N	vmod				45	1
3337	Selepas habis sekolah, saya akan pergi ke rumah kawan saya. 	အတန်းပြီးရင် သူငယ်ချင်းအိမ် သွားမယ်။	\N		\N	vmod				45	1
2818	Saya makan sarapan setiap hari. 	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း မနက်စာ စားတယ်။	\N		\N	vmod				381	1
1484	Selepas habis makan, saya menggosok gigi. 	ထမင်းစားပြီးမှ သွားတိုက်တယ်။	null		\N	vmod				\N	1
1993	Encik Yamada yang makan kek. 	ကိတ်မုန့် စားတာ မစ္စတာ ရာမဒ ပါ။\n(ကိတ်မု့န် စားတဲ့လူက မစ္စတာ ရာမဒ ပါ။) 	null		\N	vmod				\N	1
2104	Saya belajar memasak daripada ibu.	အမေဆီက ဟင်းချက် သင်ထားတာ။ (ဟင်းချက်နည်းကို အမေ့ဆီက သင်ထားတာ။)	null		\N	vmod				\N	1
1967	Masakan yang ibu masak sangat sedap. 	အမေချက်တဲ့ဟင်းက အရမ်းစားလို့ ကောင်းတယ်။	null		\N	vmod				\N	1
1419	Hidangan di majlis tersebut tidak berapa sedap. 	ပါတီက ဟင်းတွေ စားလို့ မကောင်းဘူး။	null		\N	vmod				\N	1
3433	Setiap hari akan ada ujian mulai pada minggu depan.	နောက်အပတ်ကစပြီး နေ့တိုင်း စာမေးပွဲ ရှိတယ်။	\N		\N	vmod				602	1
3776	Terima kasih.	ကျေးဇူးတင်ပါတယ်။ 	\N		\N	vmod				439	1
3774	Minta maaf, ya.	အားနာစရာကောင်းလိုက်တာ။/အားနာစရာကြီး။	\N		\N	vmod				439	1
3775	Terima kasih banyak-banyak, ya.	ကျေးဇူး အများကြီး တင်ပါတယ်။	\N		\N	vmod				439	1
2391	Terima kasih, ya.	ကျေးဇူးတင်ပါတယ်။			\N	vmod				\N	1
2976	Guru menyerahkan salinan surat khabar kepada pelajar-pelajarnya. 	ဆရာက ကျောင်းသားကို သတင်းစာ မိတ္တူ (/ကော်ပီ) ပေးလိုက်တယ်။	\N		\N	vmod				252	1
2043	Kalau tekan butang ini, pintu akan buka. 	ဒီ ခလုတ်ကို နှိပ်ရင် တံခါး ပွင့်မယ်။	null		\N	vmod				\N	1
3141	Saya telah terima borang permohonan kiriman wang di kaunter. 	ကောင်တာကနေ  ငွေ လွှဲ ပုံစံ စာရွက် ရခဲ့တယ်။	\N		\N	vmod				795	1
3142	Saya menulis nama dan alamat pada borang ini.	ဒီ စာရွက် မှာ နာမည်နဲ့ လိပ်စာ ရေးပါ။	\N		\N	vmod				795	1
3773	Ya, helo. Ini Matsui. 	ဟုတ်ကဲ့ အမိန့်ရှိပါ။ မဆုအိ ပါ(ခင်ဗျား/ရှင်)။	\N		\N	vmod				642	1
3772	Helo, ini Kimura. 	ဟလို၊ ခိမုရ ပါ (ခင်ဗျား/ရှင်)။	\N		\N	vmod				642	1
1605	Saya tidak pergi ke sekolah. 	ကျောင်း မသွားဘူး။	null		\N	vmod				\N	1
1349	Saya pergi ke sekolah setiap hari. 	နေ့တိုင်း ကျောင်းသွားတယ်။	null		\N	vmod				\N	1
3230	Kaki saya letih kerana banyak berjalan kaki. 	လမ်းအများကြီး  လျှောက်လိုက်လို့ ခြေထောက် ညောင်းသွားတယ်။	\N		\N	vmod				15	1
3231	Orang itu kakinya sangat panjang. 	အဲဒီလူ ရဲ့ ခြေထောက်က အရှည်ကြီးပဲ။	\N		\N	vmod				15	1
3028	Saya tidak akan keluar pada hari cuti sekiranya hujan.	နားရက်မှာ မိုးရွာရင်တော့ အပြင်မထွက်ဘူး။	\N		\N	vmod				710	1
3029	Saya akan naik bas ke sekolah esok kerana hujan. 	မနက်ဖန် မိုးရွာမှာမို့ ကျောင်းကို ဘတ်စ်ကား နဲ့ သွားမယ်။	\N		\N	vmod				710	1
2011	Kenapa? 	ဘာကြောင့်ပါလဲ။/ဘာဖြစ်လို့လဲ။	null		\N	vmod				\N	1
2017	Kenapa awak tidak hadir ke kelas? 	ဘာဖြစ်လို့ အတန်းပျက် တာလဲ။	null		\N	vmod				\N	1
2007	Kenapa awak tahu nombor telefon saya?	ဘယ်လိုလုပ် ကျွန်မ(/ကျွန်တော်) ဖုန်းနံပါတ်ကို သိသွားတာလဲ။	null		\N	vmod				\N	1
2047	Saya akan beli jika harganya murah.	ဈေးသက်သာရင် ဝယ်မယ်။	null		\N	vmod				\N	1
2949	Hari ini kedai ini menjual daging dengan harga murah. 	ဒီနေ့ ဒီဆိုင် မှာ အသားဈေးပေါတယ်။	\N		\N	vmod				621	1
2950	Banyak kedai yang tersusun di sana.	ဟို(/အဲဒီ)မှာ  ဆိုင်တွေအများကြီး တန်းစီနေတာပဲ။	\N		\N	vmod				621	1
1433	Ada kedai bagus di depan stesen. 	ဘူတာရှေ့မှာ ဆိုင်ကြီးဆိုင်ကောင်းတွေ အများကြီးရှိတယ်။	null		\N	vmod				\N	1
3524	Encik Hayashi tinggal di bandar yang terdapat ramai orang. 	မစ္စတာ ဟယရှိ က လူနေ ထူထပ်တဲ့ မြို့မှာ နေတယ်။	\N		\N	vmod				93	1
3525	Sekolah ini mempunyai ramai pelajar antarabangsa.	ဒီကျောင်းမှာ နိုင်ငံခြားသားကျောင်းသား များတယ်။	\N		\N	vmod				93	1
2862	Saya mengajar bahasa Jepun kepada orang asing	ကျွန်မ(/ကျွန်တော်) နိုင်ငံခြားသားတွေကို ဂျပန်စာ သင်ပေးနေတယ်။	\N		\N	vmod				105	1
1380	Saya mengajar bahasa Inggeris kepada Cik Kimura. 	မစ္စတာ ခိမုရ ကို အင်္ဂလိပ်စာ သင်တယ်။	null		\N	vmod				\N	1
1883	Bolehkah saya menelefon ke luar negara dengan telefon itu? 	ဟို တယ်လီဖုန်းနဲ့ နိုင်ငံခြားကို ဖုန်းခေါ်လို့ ရသလား။	null		\N	vmod				\N	1
3710	Sekarang ini saya sedang makan malam.	အတော်ပဲ၊ အခု ညစာစားနေတုန်း။	\N		\N	vmod				398	1
3711	Pertandingan akan bermula sekarang ini.	အတော်ပဲ၊ အခု ပွဲစတော့မယ်။	\N		\N	vmod				398	1
2227	Saya pergi ke universiti semalam. 	ကျွန်မ(/ကျွန်တော်) မနေ့က တက္ကသိုလ်ကို သွားတယ်။	null		\N	vmod				\N	1
1826	Sebenarnya saya ingin belajar di universiti di Tokyo. 	တိုကျိုက တက္ကသိုလ် မှာ တက်ချင်တယ်။	null		\N	vmod				\N	1
3750	Mengapa awak belajar bahasa Jepun? 	ဘာအတွက် ဂျပန်စာ ကို လေ့လာနေတာလဲ။	\N		\N	vmod				472	1
2599	Mengapa? 	ဘာကြောင့်ပါလဲ။/ဘာဖြစ်လို့လဲ။			\N	vmod				\N	1
3470	Lima minit lagi kelas akan habis. 	နောက် ငါးမိနစ်ဆို အတန်းပြီးမယ်။	\N		\N	vmod				25	1
2978	Esok saya akan pergi ke syarikat awal. 	မနက်ဖန် ကုမ္ပဏီ စောစော သွားမယ်။	\N		\N	vmod				137	1
2977	Encik Hayashi bekerja di syarikat komputer. 	မစ္စတာ ဟယရှိ က ကွန်ပျူတာ ကုမ္ပဏီမှာ အလုပ်လုပ်တယ်။	\N		\N	vmod				137	1
3318	Saya akan membeli kereta baru pada tahun depan. 	နောက်နှစ်ကျရင်(/လာမယ့်နှစ်ကျရင်) ကျွန်မ(/ကျွန်တော်) ကားအသစ် ၀ယ်မယ်လို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				677	1
3319	Mulai tahun depan, abang saya akan bekerja di bank. 	ကျွန်မ(/ကျွန်တော်)အစ်ကို လာမယ့်နှစ် ကစပြီး ဘဏ်မှာ အလုပ်ဝင်မယ်။	\N		\N	vmod				677	1
1393	Bila awak bermain tenis? 	ဘယ်တော့ တင်းနစ် ရိုက်မလဲ။	null		\N	vmod				\N	1
3417	Saya nak belajar kerana ada ujian pada minggu depan. 	နောက်အပတ် စာမေးပွဲရှိလို့ စာဖတ်မယ်။	\N		\N	vmod				676	1
3037	Oleh kerana esok cuaca panas, saya ingat nak berenang di dalam kolam renang.	မနက်ဖန် ရာသီဥတုပူမှာမို့လို့ ရေကူးကန်မှာ ရေသွားကူးမယ်လို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				712	1
3034	Musim panas di Jepun panas. 	ဂျပန်က နွေရာသီက ပူတယ်။	\N		\N	vmod				712	1
1646	Cuti musim panas dari satu hari bulan Ogos sehingga tiga puluh hari bulan September.	ရှစ်လပိုင်းတစ်ရက်နေ့ ကနေ ကိုးလပိုင်း သုံးဆယ်ရက်နေ့အထိ က နွေရာသီပိတ်ရက်ပါ။	null		\N	vmod				\N	1
1397	Saya pergi melancong semasa cuti musim panas. 	ကျွန်မ(/ကျွန်တော်) နွေရာသီပိတ်ရက်မှာ ခရီးထွက်မယ်။	null		\N	vmod				\N	1
2205	Saya pergi ke laut serta mendaki gunung semasa cuti musim panas tahun ini. 	ဒီနှစ် နွေရာသီပိတ်ရက်တုန်းက ပင်လယ်ကိုလည်း သွားဖြစ်တယ်၊ တောင်လည်းတက်ဖြစ်တယ်။	null		\N	vmod				\N	1
3503	Filem ini tidak berapa bagus.	ဒီရုပ်ရှင်က သိပ် မကောင်းဘူး။	\N		\N	vmod				40	1
3504	Saya tahu kedai yang bagus	ကျွန်မ(/ကျွန်တော်) ကောင်းတဲ့ ဆိုင်ကို သိတယ်။	\N		\N	vmod				40	1
3505	Komputer ini mahal tetapi sangat bagus. 	ဒီကွန်ပျူတာက ဈေးကြီးပေမယ့် အရမ်း ကောင်းတယ်။	\N		\N	vmod				40	1
3683	Musim panas di Jepun sangat panas. 	ဂျပန်က နွေရာသီက အရမ်း ပူတယ်။	\N		\N	vmod				473	1
3682	Semasa musim panas, saya keluar dengan memakai topi setiap hari. 	နွေရာသီ(/နွေအခါ)ဆို နေ့တိုင်း ဦးထုပ်ဆောင်းပြီး အပြင်ထွက်တယ်။	\N		\N	vmod				473	1
3067	Esok saya akan pergi menonton filem dengan kawan saya. 	မနက်ဖန် သူငယ်ချင်းနဲ့ ရုပ်ရှင်သွား ကြည့်မယ်။	\N		\N	vmod				458	1
2429	Saya ingat nak melancong ke Eropah dengan kawan saya. 	သူငယ်ချင်းနဲ့ ဥရောပကို အလည်သွားမလားလို့ စိတ်ကူးနေတယ်။	①旅行しようと思っています　②予定を言う　③意向形（う／よう）と思います／思っています　④土曜日は映画を見ようと思っています		\N	vmod				\N	1
3708	Saya akan tidur selepas membaca buku sedikit.	နည်းနည်းလောက် စာအုပ်ဖတ်ပြီး အိပ်မယ်။(စာအုပ်လေးဘာလေး နည်းနည်းပါးပါး ဖတ်ပြီးအိပ်မယ်။)	\N		\N	vmod				320	1
3709	Semalam, saya minum sedikit arak. 	မနေ့က အရက် နည်းနည်း သောက်ခဲ့တယ်။	\N		\N	vmod				320	1
2024	Hari ini hari Ahad tetapi saya ada kerja. 	ဒီနေ့ တနင်္ဂနွေနေ့ ဆိုပေမယ့် အလုပ်ရှိတယ်။	null		\N	vmod				\N	1
1799	Biar saya buat kerja tersebut. 	အဲဒီ အလုပ် ကို ကျွန်မ(/ကျွန်တော်) လုပ်ပါ့မယ်။/အဲဒီ အလုပ် ကို ကျွန်မ(/ကျွန်တော်) လုပ်မယ်လေ။	null		\N	vmod				\N	1
2947	Saya terfikir nak pergi melancong ke luar negara pada tahun depan.	နောက်နှစ်ကျရင် နိုင်ငံခြားကို ခရီးထွက်(/အလည်သွား)မလားလို့ စိတ်ကူးနေတယ်(/စိတ်ကူးထားတယ်)။	\N		\N	vmod				684	1
2948	Saya membeli buku tentang pelancongan di kedai buku.	စာအုပ်ဆိုင်ကနေ ခရီးသွားလမ်းညွှန် စာအုပ် ဝယ်လာတယ်။	\N		\N	vmod				684	1
3420	Saya telah pergi melancong ke luar negara bersama kawan saya pada tahun lepas. 	မနှစ်က သူငယ်ချင်းနဲ့ နိုင်ငံခြားအလည်ခရီး ထွက်ခဲ့တယ်။	\N		\N	vmod				197	1
3316	Tahun ini lebih panas daripada tahun lepas. 	မနှစ်ကထက်စာရင် ဒီနှစ်က ပိုပူတယ်။	\N		\N	vmod				197	1
1495	Saya belajar sejak tahun lepas. 	မနှစ်ကတည်းက လေ့လာနေတယ်။	null		\N	vmod				\N	1
3706	Terima kasih. Ini sudah cukup. 	ကျေးဇူးတင်ပါတယ်။ ဒီလောက်ဆိုတော်ပါပြီ(/ဒီလောက်ဆိုရပါပြီ)။	\N		\N	vmod				223	1
3806	Semuanya berjumlah seribu enam ratus yen. 	စုစုပေါင်း(/အားလုံးပေါင်း) ထောင့်ခြောက်ရာ ပါ။	\N		\N	vmod				344	1
3807	Kerja rumah semuanya sudah siap dibuat. 	အိမ်စာတွေ  အားလုံး ပြီးပြီ။	\N		\N	vmod				344	1
3850	Saya ingin melancong ke seluruh Jepun. 	ကျွန်မ(/ကျွန်တော်) ဂျပန်အနှံ့ ခရီးသွားချင်တယ်။	\N		\N	vmod				749	1
3851	Saya tidak ada di rumah sepanjang hari semalam. 	မနေ့က တစ်နေ့လုံး(/တစ်နေ့ကုန်) အိမ်မှာမရှိဘူး။	\N		\N	vmod				749	1
3810	Kasut Cik Kobayashi sama dengan kasut saya. 	ကျွန်မ(/ကျွန်တော်) ဖိနပ်နဲ့ မစ္စတာ ခိုဘယရှိ ရဲ့ ဖိနပ် က အတူတူပဲ။	\N		\N	vmod				118	1
3811	Matsui sekelas dengan Encik Lee.	မစ္စတာ မဆုအိ နဲ့ မစ္စတာ လီ က အတန်းအတူတူပဲ။	\N		\N	vmod				118	1
3302	Pasar raya itu tutup pada setiap hari Rabu bulan ini. 	ဒီလ ဟို(/အဲဒီ) စူပါမားကက် က ဗုဒ္ဓဟူးနေ့ ပိတ်တယ်။	\N		\N	vmod				257	1
3303	Saya sangat sibuk bekerja pada bulan ini. 	ဒီလ အလုပ် အရမ်း များတယ်(/ရှုတ်တယ်)။	\N		\N	vmod				257	1
3365	Saya susah kerana kehilangan pasport semasa berada di luar negara. 	နိုင်ငံခြားမှာ ပတ်စပို့ပျောက်သွားလို့ ဒုက္ခရောက်ခဲ့တယ်။	\N		\N	vmod				254	1
3418	Kakak saya akan berkahwin pada minggu depan. 	နောက်အပတ် အစ်မ မင်္ဂလာဆောင်မယ်။	\N		\N	vmod				676	1
3411	Hospital di sana tutup pada setiap hari Rabu dan hari Ahad. 	ဟိုနားက ဆေးရုံက ဗုဒ္ဓဟူးနေ့ နဲ့ တနင်္ဂနွေနေ့ ပိတ်တယ်။	\N		\N	vmod				313	1
3148	Lapangan terbang baru telah dibina dekat sini. 	အိမ်နားက လေဆိပ်အသစ်ကြီး ဆောက်ပြီးသွားပြီ။	\N		\N	vmod				806	1
3149	Pasport ditunjukkan semasa berada di lapangan terbang. 	လေဆိပ်မှာ ပတ်စပို့ ကို ပြတယ်။	\N		\N	vmod				806	1
2908	Kereta Jepun mahal tetapi bagus. 	ဂျပန်ကားက ဈေးကြီးပေမယ့် ကောင်းတယ်။	\N		\N	vmod				217	1
1250	Di belakang rumah ada kereta. 	အိမ်ရဲ့ အနောက်ဖက်မှာ ကားရှိတယ်။	null		\N	vmod				\N	1
2061	Sekiranya kereta sudah dibeli, kita boleh pergi ke mana-mana sahaja. 	ကားဝယ်ထားရင် ဘယ်မဆို သွားနိုင်တယ်။	null		\N	vmod				\N	1
3749	Awak selalu makan tengah hari di mana? 	အမြဲတမ်း ဘယ်မှာ ထမင်းစား သလဲ။	\N		\N	vmod				446	1
1229	Encik Tanaka ada di mana? 	မစ္စတာ တာနာခါ ဘယ်မှာရှိသလဲ။	null		\N	vmod				\N	1
1312	Kereta cikgu ada di mana?	ဆရာ့ကား ဘယ်မှာ ရှိသလဲ။(ဆရာ့ကားက ဘယ်မှာ လဲ။)	null		\N	vmod				\N	1
1264	Di manakah bilik darjah untuk bahasa Jepun ? 	ဂျပန်စာ စာသင်ခန်း က ဘယ်မှာလဲ။	null		\N	vmod				\N	1
1431	Dekat kawasan sini, tidak banyak bangunan yang tinggi. 	ဒီနားမှာ အဆောက်အအုံ ခပ် မြင့်မြင့်တွေ မရှိဘူး။	null		\N	vmod				\N	1
1414	Bagaimana dengan masakan Jepun? 	ဂျပန်ဟင်းလျာတွေ ကို ဘယ်လိုသဘောရသလဲ။	null		\N	vmod				\N	1
1423	Bagaimana filem yang awak tengok semalam?	မနေ့က ရုပ်ရှင် ဘယ်လိုနေလဲ။	null		\N	vmod				\N	1
2064	Bagaimanakah cara supaya saya boleh menghafal kanji? 	ဘယ်လိုလုပ်ရင် ခန်းဂျီး ကို မှတ်မိနိုင် မလဲ။(ခန်းဂျီးကို မှတ်မိအောင်ဘယ်လို လုပ်ရမလဲ။)	null		\N	vmod				\N	1
1297	Ada guru di sana. 	ဟိုမှာ ဆရာ ရှိတယ်။	null		\N	vmod				\N	1
2498	Ada lif di sana. 	ဟိုမှာ ဓာတ်လှေခါး ရှိတယ်။			\N	vmod				\N	1
3752	Yang mana paling sedap? 	ဘယ်ဟာ အရသာအရှိဆုံး(/စားလို့အကောင်းဆုံး)လဲ။ 	\N		\N	vmod				463	1
3753	Yang manakah Puan Hayashi beli ? 	မစ္စတာ ဟယရှိ ဘာ ဝယ်ခဲ့ ပါသလဲ။	\N		\N	vmod				463	1
1836	Awak nak yang mana? 	ဘာလိုချင် ပါသလဲ။	null		\N	vmod				\N	1
1311	Itu Encik Tanaka punya. 	ဟိုဟာ(/အဲဒါ) မစ္စတာ တာနာခါ ပါ။(\nသူက မစ္စတာ တာနာခါ ပါ။)	null		\N	vmod				\N	1
3170	Saya akan cakap tentang perkara tersebut kepada guru. 	အဲဒီအကြောင်းကို ကျွန်မ(/ကျွန်တော်) ဆရာ့ကိုပြောမယ်။	\N		\N	vmod				42	1
1694	Saya ucap "Selamat pagi" selepas bangun pada waktu pagi.	မနက်အိပ်ရာထတဲ့ အခါ “အိုဟိုင်းရိုး ဂိုဇိုင်းမတ်” လို့ ပြောတယ်။	null		\N	vmod				\N	1
3063	Saya akan membuat kerja rumah di perpustakaan malam ini. 	ဒီည စာကြည့်တိုက်မှာ အိမ်စာ လုပ်မယ်။	\N		\N	vmod				303	1
3290	Saya yang memasak makan malam setiap hari. 	ညစာကို နေ့တိုင်း ကိုယ်(/ငါ)ပဲ ချက်တယ်။	\N		\N	vmod				293	1
3165	Walaupun saya belajar bahasa Jepun setiap hari, saya masih tidak boleh hafal kanji. 	နေ့တိုင်း ဂျပန်စာ လေ့လာနေပေမယ့် ခန်းဂျီးကိုတော့ မှတ်လို့မရဘူး။	\N		\N	vmod				178	1
1885	Saya boleh menulis kanji. 	ကျွန်မ(/ကျွန်တော်) ခန်းဂျီး ရေးတတ်တယ်။	null		\N	vmod				\N	1
3009	Ini filem lama Jepun . 	ဒါ ဂျပန် ရှေးဟောင်း ရုပ်ရှင် ဖြစ်ပါတယ်။	\N		\N	vmod				83	1
3874	Erm, tumpang tanya. Perpustakaan di mana?	ဟို…၊တစ်ဆိတ်လောက်မေးပါရစေ။ စာကြည့်တိုက် ဘယ်နားမှာရှိပါသလဲ။	\N		\N	vmod				740	1
1178	Ayah saya guru.	အဖေက ဆရာ(/ကျောင်းဆရာ) ပါ။	null		\N	vmod				\N	1
3425	Hari ini saya tidak pergi ke sekolah kerana selesema.	ဒီနေ့ အအေးမိလို့ ကျောင်း မသွားဘူး။	\N		\N	vmod				194	1
3426	Saya dan Encik Lee pergi menonton wayang pada hari ini.	ဒီနေ့ မစ္စတာလီနဲ့ ရုပ်ရှင်သွားကြည့်မယ်။	\N		\N	vmod				194	1
3446	Hari ini ada kelas dari pagi sampai petang. 	ဒီနေ့ မနက်ကနေ ညနေအထိ အတန်းရှိတယ်။	\N		\N	vmod				12	1
3447	Saya selalu naik kereta api pukul lapan pagi. 	အမြဲတမ်း မနက်ရှစ်နာရီရထားကို စီးတယ်။	\N		\N	vmod				12	1
3069	Kelas cikgu itu menarik.	ဟို(/အဲဒီ)ဆရာရဲ့ အတန်းက စိတ်ဝင်စားဖို့ကောင်းတယ်။\n	\N		\N	vmod				302	1
2005	Saya tidak akan pergi ke sekolah esok kerana tiada kelas.	မနက်ဖန် အတန်းမရှိလို့ ကျောင်းမသွားဘူး။	null		\N	vmod				\N	1
3784	Bukan.	ဟင့်အင်း၊ မဟုတ်ဘူး။	\N		\N	vmod				41	1
1369	Tidak, saya tidak pergi. 	ဟင့်အင်း၊ မသွားဘူး။	null		\N	vmod				\N	1
1879	Tidak, saya tidak boleh buat. 	ဟင့်အင်း၊ မတတ်ဘူး။	null		\N	vmod				\N	1
3252	Buku nota ada dalam beg.	ဗလာစာအုပ်က လွယ်အိတ်ထဲမှာ ရှိတယ်။	\N		\N	vmod				728	1
3253	Bilik darjah itu ada TV.	ဟိုစာသင်ခန်းထဲမှာ တီဗွီ ရှိတယ်။	\N		\N	vmod				728	1
2744	Cikgu, ini ibu saya. 	ဆရာ၊ ဒါ ကျွန်မ(/ကျွန်တော်)ရဲ့ အမေပါ။	①こちらが私の母です。②人を紹介する　③こちらが(人名)です　④こちらが当社の社長の山本です。		\N	vmod				\N	1
3733	Adik perempuan sudah tidur. 	ညီမလေး အိပ်သွားပြီ။	\N		\N	vmod				640	1
3732	Saya sudah makan tengah hari di kantin. 	ကျွန်မ(/ကျွန်တော်) စားသောက်ဆိုင်မှာ နေ့လယ်စာ စားပြီးသွားပြီ။	\N		\N	vmod				640	1
3846	Anjing kami comel betul. 	အိမ်က ခွေးလေးက တကယ်ကို ချစ်ဖို့ကောင်းတယ်။	\N		\N	vmod				596	1
3847	Cerita ini betul.	ဒီစကားက တကယ်(/အမှန်)။	\N		\N	vmod				596	1
1474	Kita boleh belajar di sini. 	ဒီမှာ စာဖတ်လို့ ရတယ်။	null		\N	vmod				\N	1
3766	Ha, Encik Tanaka, selamat malam. 	ဟာ...၊ မစ္စတာ တာနာခါ မင်္ဂလာ(ညချမ်း)ပါ။	\N		\N	vmod				1	1
3767	Oh, baguslah. 	အမလေး၊ တော်ပါသေးရဲ့။	\N		\N	vmod				1	1
3777	Ya, betul. 	ဟုတ်ကဲ့၊ ဟုတ်ပါတယ်။	\N		\N	vmod				741	1
3778	Ya, ada apa?	ဟုတ်ကဲ့၊ ဘာလဲ (ခင်ဗျား/ရှင်)။	\N		\N	vmod				741	1
1824	Ya, boleh. 	ဟုတ်ကဲ့၊ ကောင်းပါတယ်။	null		\N	vmod				\N	1
1715	Ya, baiklah. 	ဟုတ်ကဲ့၊ နားလည်ပါပြီ(/သဘောပေါက်ပါပြီ)။	null		\N	vmod				\N	1
3792	Tolong bantu saya mana yang perlu. 	ကျေးဇူးပြု၍ ဆောင်ရွက် ပေးပါ။(ကျေးဇူးပြုပြီး　ကူညီပေးပါ။)\n	\N		\N	vmod				437	1
2369	Silakan. 	ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ။/လက်ခံပါ။/ယူပါ။/ဝင်ပါ။/သုံးဆောင်ပါ။			\N	vmod				\N	1
2332	Ya, silakan. 	ဟုတ်ကဲ့၊ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ။/ဟုတ်ကဲ့၊လက်ခံပါ။/ဟုတ်ကဲ့၊ယူပါ။/ဟုတ်ကဲ့၊ဝင်ပါ။/ဟုတ်ကဲ့၊သုံးဆောင်ပါ။			\N	vmod				\N	1
2383	Benda ini barang biasa saja, tetapi silakan. 	တန်ဖိုးကြီးတဲ့အရာ မဟုတ်ပေမယ့် လက်ခံပေးပါ(/ယူပါ)။	①どうぞ　②何か（もの）をあげる　③どうぞ　④　これ、どうぞ。		\N	vmod				\N	1
3698	Saya akan membeli gelas ini. Selepas itu, saya akan membeli pinggan ini juga. 	ဒီ ခွက်ကို ဝယ်မယ်။ ပြီးတော့ ဒီ ပန်းကန်ပြားလည်း ဝယ်မယ်။	\N		\N	vmod				357	1
3699	Semalam saya menonton TV. Selepas itu, saya belajar bahasa Jepun. 	မနေ့က တီဗွီ ကြည့်တယ်။ ပြီးတော့ ဂျပန်စာကို လေ့လာတယ်။	\N		\N	vmod				357	1
3787	Saya memesan masakan ini.	ကျွန်မ(/ကျွန်တော်) ဒီ ဟင်းကို မှာမယ်။	\N		\N	vmod				250	1
3788	Bangunan ini lama dan terkenal. 	ဒီ အဆောက်အအုံက ရှေးကျပြီး နာမည်ကြီးတယ်။	\N		\N	vmod				250	1
1244	Ada buku di atas meja. 	စာရေးခုံ(/စာကြည့်စားပွဲ) ပေါ်မှာ စာအုပ် ရှိတယ်။	null		\N	vmod				\N	1
2088	Saya menerima buku daripada ayah saya.	ကျွန်မ(/ကျွန်တော်) အဖေဆီက စာအုပ် ရခဲ့တယ်။	null		\N	vmod				\N	1
2873	Adik perempuan saya pendek dan rambutnya panjang. 	ကျွန်မ(/ကျွန်တော်) ညီမ က အရပ်ပုပြီး ဆံပင် ရှည်တယ်။	\N		\N	vmod				468	1
1727	Ya, OK. 	အင်း(/အေး)၊ကောင်းပါတယ်။	null		\N	vmod				\N	1
2520	Ya, saya suka. 	အင်း(/အေး)၊ကြိုက်ပါတယ်။	①文中の形：すきです。②機能：嗜好について述べる（もの）③文型：(～が)すきです。　　　　　　　　　　　　　　④例文：果物がすきです。		\N	vmod				\N	1
3707	Encik Kobayashi sangat pandai. 	မစ္စတာ ခိုဘယရှိ က ဉာဏ်အရမ်းကောင်းတယ်။	\N		\N	vmod				452	1
1427	Saya sangat letih. 	အရမ်း ပင်ပန်းတယ်။	null		\N	vmod				\N	1
3783	Ya, betul. 	ဟုတ်ကဲ့၊ဟုတ်ပါတယ်။	\N		\N	vmod				345	1
3782	Betul tu. 	ဟုတ်တယ်နော်။	\N		\N	vmod				345	1
2637	Oh begitu ke...	ဪ၊ဟုတ်လား။			\N	vmod				\N	1
2396	Ya, begitu. 	ဟုတ်တယ်။			\N	vmod				\N	1
1837	Saya nak ini dan itu. 	ဒါနဲ့ အဲဒါ နဲ့  လိုချင်ပါတယ်။\n	null		\N	vmod				\N	1
1268	Itu surat khabar bila?	အဲဒါ ဘယ်တုန်းက သတင်းစာလဲ။	null		\N	vmod				\N	1
3062	Salon kecantikan ada di sebelah stesen. 	အလှပြင်ဆိုင်က ဘူတာရဲ့ ဘေးမှာ ရှိတယ်။	\N		\N	vmod				668	1
3072	Kotak ini lebarnya pendek dan panjangnya panjang.	ဒီသေတ္တာက အနံ တိုပြီး အလျား ရှည်တယ်။	\N		\N	vmod				668	1
3427	Saya akan belajar kanji setiap hari mulai esok. 	မနက်ဖန်ကစပြီး နေ့တိုင်း ခန်းဂျီး လေ့လာမယ်။	\N		\N	vmod				16	1
3428	Saya mesti pergi ke kedutaan esok. 	မနက်ဖန် သံရုံး မသွားလို့မဖြစ်ဘူး။	\N		\N	vmod				16	1
3726	Semalam saya belajar bermain piano buat pertama kalinya. 	မနေ့က ပထမဆုံးအကြိမ် စန္ဒရား စသင်တယ်။	\N		\N	vmod				516	1
3727	Saya berjumpa dengan Encik Hayashi buat pertama kalinya. 	ကျွန်မ(/ကျွန်တော်) မစ္စတာ ဟယရှိ နဲ့ ပထမဆုံးအကြိမ် တွေ့ခဲ့တယ်။	\N		\N	vmod				516	1
3781	Kalau begitu, saya nak pergi ke hospital dengan menaiki bas. 	ဒါဆိုရင်၊ ဘတ်စ်ကားနဲ့ပဲ ဆေးရုံသွားမယ်။	\N		\N	vmod				296	1
2415	Kalau begitu, saya minta tolong awak.	ဒါဆိုရင်၊ ဆောင်ရွက်ပေးပါ။			\N	vmod				\N	1
3167	Encik Lee menulis surat dalam bahasa Jepun. 	မစ္စတာလီက ဂျပန်ဘာသာနဲ့ စာတစ်စောင် ရေးခဲ့တယ်။	\N		\N	vmod				811	1
1811	Adik perempuan saya ingin menjadi guru bahasa Jepun. 	ညီမလေးက ဂျပန်စာဆရာမ လုပ်ဖို့ စိတ်ကူးနေတယ်။	null		\N	vmod				\N	1
3758	Bagaimana dengan kopi?	ကောင်ဖီ သောက်ပါဦး။/ကောင်ဖီ သောက်မလား။	\N		\N	vmod				44	1
3759	Bagaimana kalau ambil satu dan cuba makan kuih ini? 	မုန့်တစ်ခုလောက် ယူပါဦး။	\N		\N	vmod				44	1
3603	Encik Tanaka membuat kerja yang susah. 	မစ္စတာ တာနာခါ က ပင်ပန်းတဲ့ အလုပ်တွေ လုပ်နေတယ်။	\N		\N	vmod				366	1
3604	Saya susah kerana mesti hafal banyak kanji. 	ခန်းဂျီးတွေအများကြီး မှတ်ရမှာမို့ ဒုက္ခရောက်နေတယ်။	\N		\N	vmod				366	1
3413	Saya selalu bermain dengan kawan-kawan saya pada hari Jumaat kerana hari kemudiannya cuti. 	နောက်တစ်နေ့က ပိတ်ရက်မို့လို့ သောကြာနေ့ဆို အမြဲတမ်း သူငယ်ချင်းနဲ့ လျှောက်လည်တယ်။	\N		\N	vmod				203	1
2762	Saya kena selesema kerana cuaca sangat sejuk semalam. 	မနေ့က အရမ်းအေးလို့ အအေးမိသွားတယ်။	\N		\N	vmod				153	1
3694	Harga hidangan restoran itu murah, tapi tidak berapa sedap. 	ဟို(/အဲဒီ) စားသောက်ဆိုင်က ဈေးပေါတယ်။ ဒါပေမယ့် သိပ် စားလို့မကောင်းဘူး။	\N		\N	vmod				424	1
3695	Majlis semalam seronok.  Tapi saya agak letih sedikit. 	မနေ့က ပါတီက ပျော်ဖို့ကောင်းပါတယ်။ ဒါပေမယ့် နည်းနည်းတော့ ပင်ပန်းတယ်။	\N		\N	vmod				424	1
3629	Saya akan menelefon Encik Lee esok.	မနက်ဖန် မစ္စတာလီ ဆီ ဖုန်းဆက်မယ်။	\N		\N	vmod				430	1
3628	Saya meminjam telefon daripada Puan Kimura.	မစ္စတာ ခိမုရ က ဖုန်းငှားပေးထားတယ်။\n(ကျွန်မ(/ကျွန်တော်) မစ္စတာ ခိမုရ ဆီက ဖုန်းငှားထားတယ်။)	\N		\N	vmod				430	1
3742	Hari ini saya sering berjumpa dengan Encik Kobayashi.	ဒီနေ့ မစ္စတာ ခိုဘယရှိ နဲ့ ခဏခဏ တွေ့တယ်။	\N		\N	vmod				732	1
3743	Saya selalu pergi ke kedai kopi itu dengan Encik Kobayashi. 	မစ္စတာ ခိမုရနဲ့ ဟို(/အဲဒီ) ကော်ဖီဆိုင်ကို ခဏခဏ သွားတယ်။ (မစ္စတာ ခိမုရနဲ့ အမြဲတမ်း ဟို(/အဲဒီ)ကော်ဖီဆိုင် ကို သွားတယ်။)	\N		\N	vmod				732	1
3512	Saya mendengar cerita yang membosankan daripada kawan saya. 	သူငယ်ချင်းဆီက စိတ်ဝင်စားစရာမကောင်းတဲ့\n(/အရေးမပါတဲ့)စကား ကိုကြားရတယ်။	\N		\N	vmod				409	1
3513	Buku ini membosankan. 	ဒီစာအုပ်က စိတ်ဝင်စားဖို့မကောင်းဘူး။	\N		\N	vmod				409	1
1335	Hari ini berapa hari bulan? 	ဒီနေ့ ဘာလ ဘာရက် လဲ။(ဒီနေ့ ဘာနေ့ လဲ။)	null		\N	vmod				\N	1
1330	Sekarang pukul lima. 	အခု ငါးနာရီပါ။(အခု ငါးနာရီ ထိုးပြီ။)	null		\N	vmod				\N	1
1491	Sekarang Encik Kobayashi tengah membaca buku di perpustakaan. 	အခု မစ္စတာ ခိုဘယရှိ စာကြည့်တိုက်မှာ စာအုပ်ဖတ်နေတယ်။	null		\N	vmod				\N	1
2931	Saya sangat lambat apabila berjalan kaki. 	ကျွန်မ(/ကျွန်တော်) လမ်းလျှောက်တာ အရမ်းနှေးတယ်။	\N		\N	vmod				107	1
2966	Perpustakaan buka dari pukul sembiran pagi sampai pukul lapan malam. 	စာကြည့်တိုက်က မနက် ၉ နာရီ ကနေ ည ၈နာရီအထိ ပါ။\n(စာကြည့်တိုက်က မနက် ၉ နာရီ ကနေ ည ၈နာရီအထိ ဖွင့်ပါတယ်။)	\N		\N	vmod				449	1
1801	Saya ingin belajar di perpustakaan tapi tutup. 	စာကြည့်တိုက်မှာစာဖတ်မလို့လုပ်ထားတာ စာကြည့်တိုက် ပိတ်ထားတယ်(/မဖွင့်ဘူး)။	null		\N	vmod				\N	1
3779	Kalau begitu, saya minta tolong awak.	ဒါဖြင့် ကူညီဆောင်ရွက်ပေးပါ။	\N		\N	vmod				422	1
3780	Baiklah, kita akan mulakan kelas. 	ဒါဖြင့်၊ အတန်း စမယ်။	\N		\N	vmod				422	1
2409	Berapakah harganya? 	ဘယ်လောက် လဲ။	①いくらでしょうか　②情報を求める(金額) 　③いくら（ですか）　④このりんごはいくらですか。		\N	vmod				\N	1
1320	Berapakah harga pen ini? 	ဒီဘောပင် ဘယ်လောက်လဲ။	null		\N	vmod				\N	1
3719	A: Apa kata kita bersama pergi membeli-belah esok?	မနက်ဖန် ဈေးသွားမဝယ်ဘူးလား။(မနက်ဖန် ဈေးသွားဝယ်မလား။)	\N		\N	vmod				399	1
3718	B: Maaf, saya rasa susah sikit kalau esok. 	ဆောရီးပဲ။ မနက်ဖန်တော့ သိပ်အဆင်မပြေဘူး။	\N		\N	vmod				399	1
1720	Sila tunggu sekejap. 	ခဏလောက် စောင့်ပါ။	null		\N	vmod				\N	1
2672	Boleh saya tanya sekejap? 	တစ်ဆိတ်လောက်၊ တောင်းဆိုပါရစေ။			\N	vmod				\N	1
2828	Saya nak masukkan duit ke dalam dompet saya.	ပိုက်ဆံအိတ်ထဲကို ပိုက်ဆံ ထည့်တယ်။	\N		\N	vmod				68	1
2829	Puan Matsui menuangkan kopi untuk saya. 	မစ္စတာ မဆုအိ က ကျွန်မ(/ကျွန်တော်)ကို ကော်ဖီ ထည့်ပေးတယ်။	\N		\N	vmod				68	1
3291	Tandas di sini. 	သန့်စင်ခန်း က ဒီဘက်မှာပါ။	\N		\N	vmod				244	1
3292	Ini Encik Kobayashi. 	ဒီဘက်က မစ္စတာ ခိုဘယရှိ ပါ။(သူက  မစ္စတာ ခိုဘယရှိ ပါ။)	\N		\N	vmod				244	1
1494	Sejak bila awak belajar bahasa Jepun? 	ဘယ်တုန်းကတည်းက ဂျပန်စာကို လေ့လာနေတာလဲ။	null		\N	vmod				\N	1
3755	Awak ingin berkahwin dengan orang yang bagaimana? 	ဘယ်လိုလူမျိုးနဲ့ လက်ထပ်ချင်သလဲ။	\N		\N	vmod				464	1
3754	Itu makanan yang bagaimana? 	အဲဒါ ဘယ်လို အစားအစာမျိုးလဲ။	\N		\N	vmod				464	1
1280	Filem yang bagaimana?	ဘယ်လို ရုပ်ရှင်မျိုးလဲ။	null		\N	vmod				\N	1
1817	Saya ingin mendengar muzik dari Jepun. 	ဂျပန် တေးဂီတ ကို နားထောင်ချင်တယ်။	null		\N	vmod				\N	1
1848	Saya suka muzik. 	ကျွန်မ(/ကျွန်တော်) တေးဂီတ ကို နှစ်သက်တယ်။	null		\N	vmod				\N	1
3467	Masukkan gula, kemudian masukkan kicap sedikit. 	သကြားထည့်ပြီးရင် နောက်တစ်ဆင့်အနေနဲ့ ပဲငံပြာရည် နည်းနည်း ထည့်မယ်။	\N		\N	vmod				403	1
3468	Kemudian, saya akan meminjamkan majalah ini kepada Puan Yamada. 	ပြီးရင် ဒီ မဂ္ဂဇင်းကို မစ္စတာ ရာမဒ ကို ငှားမယ်။	\N		\N	vmod				403	1
2797	Saya nak pulangkan buku kepada perpustakaan. 	စာကြည့်တိုက်ကို စာအုပ် ပြန်ပေးတယ်(/ပြန်အပ်တယ်)။	\N		\N	vmod				141	1
2796	Saya nak pulangkan wang kepada Cik Matsui. 	မစ္စတာ မဆုအိကို ပိုက်ဆံ ပြန်ပေးတယ်(/ပြန်ဆပ်တယ်)။	\N		\N	vmod				141	1
2651	Bolehkah saya pulangkan semasa waktu rehat tengah hari?	နေ့ခင်းနားတဲ့အချိန်မှ ပြန်ပေးလည်းရတယ်။	①お昼休みでもいいですか　②許可を求める　③〜て（で）もいいですか　④この書類の記入は英語でもいいですか。		\N	vmod				\N	1
3160	Pen digunakan untuk mengisi borang permohonan kiriman wang.	ငွေလွှဲချလံ ဖြည့်တဲ့အခါ ဘောပင်ကို သုံးတယ်။	\N		\N	vmod				401	1
3100	Saya guna kad apabila membeli barang. 	ဈေးဝယ်တဲ့ အခါ ခရက်ဒစ်ကတ်(/အကြွေးဝယ်ကတ်) ကို သုံးတယ်။	\N		\N	vmod				401	1
3823	Bilik darjah untuk awak semua berada di tingkat tiga.	မင်းတို့ ရဲ့ စာသင်ခန်းက သုံးထပ်(/တတိယထပ်) မှာ။	\N		\N	vmod				627	1
3824	Kalau awak semua nak pergi, saya pun akan pergi. 	မင်းတို့ သွားရင် ငါလည်း သွားမယ်။	\N		\N	vmod				627	1
3825	Awak semua akan ada ujian kanji pada minggu depan. 	အားလုံးနားထောင်ပါ၊  လာမယ့်အပတ်မှာ ခန်းဂျီး စာမေးပွဲ စစ်မယ်။	\N		\N	vmod				627	1
3789	Jangan masuk ke dalam bilik itu. 	အဲဒီ အခန်းကို မဝင်ရဘူး။	\N		\N	vmod				353	1
1299	Buku itu saya punya. 	အဲဒီ စာအုပ်က  ကျွန်မ(/ကျွန်တော်) ဟာ ပါ။	null		\N	vmod				\N	1
1296	Beg Puan Tanaka ada di situ. 	မစ္စတာ တာနာခါ ရဲ့ အိတ်က အဲဒီမှာ ရှိတယ်။	null		\N	vmod				\N	1
3293	Kerana tidak boleh duduk di sini, saya akan duduk di sana.	ဒီမှာ ထိုင်လို့မရလို့ ဟိုမှာ ထိုင်မယ်။(ဒီမှာ ထိုင်စရာမရှိလို့ ဟိုမှာ ထိုင်မယ်။)	\N		\N	vmod				245	1
3299	Kalau pergi ke situ, ada pejabat pos dan bank. 	အဲဒီကို သွားရင်တော့ စာတိုက်နဲ့ ဘဏ် ရှိတယ်။	\N		\N	vmod				351	1
2864	Saya berlatih bermain tenis setiap hari selepas habis sekolah.	နေ့တိုင်း ကျောင်းဆင်းရင် တင်းနစ် လေ့ကျင့်တယ်။	\N		\N	vmod				690	1
1528	Kami ada latihan bola sepak pada setiap hari Isnin, Rabu dan Jumaat. 	တနင်္လာနေ့ ၊ ဗုဒ္ဓဟူးနေ့ နဲ့ သောကြာနေ့တွေ မှာ ဘောလုံး လေ့ကျင့်ရေး(/ဘောလုံး ခြေကျင့်ပွဲ) ရှိတယ်။	null		\N	vmod				\N	1
3408	Tahun depan saya akan keluar dari universiti. 	နောက်နှစ်မှာ ကျွန်မ(/ကျွန်တော်) တက္ကသိုလ် ပြီးမယ်။	\N		\N	vmod				425	1
3377	Malam ini saya akan keluar dari syarikat awal dan balik ke rumah. 	ဒီည စောစော ကုမ္ပဏီ(/အလုပ်) ဆင်းပြီး၊ အိမ်ပြန်မယ်။	\N		\N	vmod				425	1
1637	Saya keluar dari rumah pada pukul tujuh pagi. 	ခုနစ်နာရီမှာ အိမ်က ထွက်မယ်။	null		\N	vmod				\N	1
3506	Makanan ini tidak baik untuk badan kita. 	ဒါ ခန္ဓာကိုယ် အတွက် မကောင်းတဲ့ စားစရာ။	\N		\N	vmod				702	1
3507	Hari ini cuaca tidak baik. 	ဒီနေ့ ရာသီဥတု ဆိုးတယ်(/မကောင်းဘူး)။	\N		\N	vmod				702	1
3535	Kami memesan empat jenis makanan di restoran. 	စားသောက်ဆိုင်မှာ ဟင်း လေးခု မှာတယ်။(စားသောက်ဆိုင်မှာ ဟင်း လေးမျိုး မှာတယ်။)	\N		\N	vmod				670	1
3058	Pintu kereta api akan tutup.	ရထားတံခါး ပိတ်မယ်။	\N		\N	vmod				433	1
3414	Saya akan makan malam di rumah Encik Hayashi pada hari Sabtu ini. 	စနေနေ့ကျရင် မစ္စတာ ဟယရှိ ရဲ့ အိမ်မှာ ညစာစားမယ်။	\N		\N	vmod				459	1
3074	Saya tidak hadir kerana demam. 	ကိုယ်ပူနေလို့ ဒီနေ့ အနားယူမယ်။	\N		\N	vmod				757	1
1545	Saya tidak boleh pergi ke sekolah kerana demam tinggi. 	ကိုယ်အရမ်းပူလို့ ကျောင်းမသွားနိုင်ဘူး။	null		\N	vmod				\N	1
3073	Semalam saya tidak pergi ke syarikat, tetapi pergi ke hospital.	မနေ့က ကုမ္ပဏီနားပြီး ဆေးရုံ သွားတယ်။(မနေ့က ကုမ္ပဏီခွင့်ယူပြီး ဆေးရုံ သွားတယ်။)	\N		\N	vmod				551	1
1738	Jangan gunakan telefon bimbit di hospital. 	ဆေးရုံ(/ဆေးခန်း)မှာ လက်ကိုင်ဖုန်း မသုံးရဘူး။	null		\N	vmod				\N	1
2944	Bilik hotel ini sangat cantik. 	ဒီ ဟိုတယ်က အခန်းတွေက အရမ်း သန့်တယ်(/လှတယ်)။	\N		\N	vmod				593	1
1634	Saya bermalam di hotel. 	ဟိုတယ်မှာ တည်းမယ်။	null		\N	vmod				\N	1
3144	Saya memberitahu alamat saya yang baru kepada kawan saya. 	သူငယ်ချင်းကို လိပ်စာအသစ် ပေးလိုက်တယ်။	\N		\N	vmod				796	1
2946	Cik Matsui tinggal di luar negara selama tiga tahun. 	မစ္စတာ မဆုအိ က နိုင်ငံခြားမှာ သုံးနှစ် နေခဲ့တယ်။	\N		\N	vmod				715	1
2734	Saya rasa nak bekerja di luar negara.	နိုင်ငံခြားမှာ အလုပ်လုပ်ဖို့ စိတ်ကူးနေတယ်။	①働きたいと思っているんです。②希望を述べる　③Vたいと思います④いつか自分の家を建てたいと思います。		\N	vmod				\N	1
3263	Saya memberi hadiah hari jadi kepada ibu saya. 	အမေ့ကို မွေးနေ့ လက်ဆောင် ပေးတယ်။	\N		\N	vmod				527	1
2153	Saya seorang pelajar. 	ကျွန်မ(/ကျွန်တော်) ကျောင်းသူ(/ကျောင်းသား)ပါ။	null		\N	vmod				\N	1
1176	Encik Tanaka bukan pelajar.	မစ္စတာ တာနာခါ က ကျောင်းသား မဟုတ်ပါဘူး။	null		\N	vmod				\N	1
3685	Di Jepun, angin kencang semasa musim bunga. 	ဂျပန်ရဲ့ နွေဦး လေ က ကြမ်းတယ်။	\N		\N	vmod				724	1
3684	Banyak bunga berkembang semasa musim bunga. 	နွေဦးဆို ပန်းတွေ အများကြီး ပွင့်တယ်။	\N		\N	vmod				724	1
2086	Saya menghadiahkan bunga kepada bapa saya. 	ကျွန်မ(/ကျွန်တော်) အဖေ့ ကို ပန်း ပေးတယ်။	null		\N	vmod				\N	1
2979	Saya keluar dengan kawan pada hari cuti. 	နားရက်(/ပိတ်ရက်)မှာ သူငယ်ချင်းနဲ့  အပြင်ထွက်တယ်။	\N		\N	vmod				653	1
3025	Kalau cerah esok, mari kita bermain tenis. 	မနက်ဖန် နေသာရင် တင်းနစ် ကစားကြမယ်။	\N		\N	vmod				530	1
1194	Cuaca di Tokyo cerah. 	တိုကျိုမှာ နေသာတယ်။	null		\N	vmod				\N	1
3117	Selepas berjalan-jalan di taman, saya nak balik ke rumah. 	ပန်းခြံမှာ လမ်းလျှောက်ပြီး အိမ်ပြန်မယ်။	\N		\N	vmod				231	1
1222	Ada pokok di taman. 	ပန်းခြံ မှာ သစ်ပင်တွေ ရှိတယ်။	null		\N	vmod				\N	1
3660	Saya pergi berjalan-jalan dengan anjing saya ke taman petang ini. 	ညနေစောင်း ခွေးနဲ့ ပန်းခြံ ကို လမ်းလျှောက် သွားတယ်။	\N		\N	vmod				61	1
3661	Anjing kami sangat besar. 	အိမ်က ခွေးက အကြီးကြီးပဲ။	\N		\N	vmod				61	1
1259	Ini pen saya. 	ကျွန်မ(/ကျွန်တော်) ဘောပင် က ဒီဟာ ပါ။	null		\N	vmod				\N	1
1667	Saya menulis huruf dengan pen. 	ဘောပင်နဲ့ စာရေးတယ်။	null		\N	vmod				\N	1
3376	Ini buku nota saya. 	ဒါ ကျွန်မ(/ကျွန်တော်) မှတ်စုစာအုပ်ပါ။	\N		\N	vmod				500	1
1246	Di dalam beg ada buku nota.	အိတ်ထဲမှာ မှတ်စုစာအုပ် ရှိတယ်။	null		\N	vmod				\N	1
1527	Di atas meja ada buku dan buku nota. 	စာရေးခုံ(/စာကြည့်စားပွဲ) ပေါ်မှာ စာအုပ်နဲ့ မှတ်စုစာအုပ် ရှိတယ်။	null		\N	vmod				\N	1
3734	Saya nak buat kerja sedikit lagi dan balik. 	နောက်ထပ် အလုပ်လေး နည်းနည်းလုပ်ပြီး ပြန်မယ်။	\N		\N	vmod				739	1
3735	Saya nak minum segelas lagi air. 	ရေ နောက်ထပ် တစ်ခွက် သောက်တယ်။\n(ရေ နောက်တစ်ခွက် ထပ်သောက်တယ်။)	\N		\N	vmod				739	1
2893	Saya nak bersihkan bilik kerana kawan saya akan datang. 	သူငယ်ချင်းလာမှာမလို့ အခန်းကို သန့်ရှင်းရေးလုပ်တယ်။	\N		\N	vmod				577	1
1434	Bilik sini sangat senyap. 	ဒီအခန်း က အရမ်း တိတ်ဆိတ်တဲ့ အခန်းပါ။ 	null		\N	vmod				\N	1
2994	Banyak deretan rumah di tepi jalan sana. 	ဟိုဘက် လမ်းမှာ အိမ် တွေ အများကြီး တန်းစီနေတယ်။	\N		\N	vmod				43	1
1601	Saya akan keluar rumah pada pukul sembilan pagi. 	ကိုးနာရီမှာ အိမ်က ထွက်မယ်။	null		\N	vmod				\N	1
1402	Anjing di rumah jiran tidak besar. 	ဘေးအိမ်က ခွေးက အကောင်မကြီးဘူး။	null		\N	vmod				\N	1
2843	Ada meja dan kerusi di dalam bilik darjah. 	စာသင်ခန်းမှာ စာရေးခုံ(/စာကြည့်စားပွဲ) နဲ့ ထိုင်ခုံ ရှိတယ်။	\N		\N	vmod				195	1
1650	Saya nak keluar dari bilik darjah. 	စာသင်ခန်းက ထွက်တယ်။	null		\N	vmod				\N	1
2856	Awak mesti membaca soalan dengan baik semasa menulis jawapan.	အဖြေရေးတဲ့အခါမှာ မေးခွန်းကို သေချာ မဖတ်လို့ မဖြစ်ဘူး။(အဖြေမရေးခင် မေးခွန်းကို သေချာ ဖတ်ရတယ်။)	\N		\N	vmod				288	1
1233	Saya tidak ada wang. 	ပိုက်ဆံ မရှိဘူး။	null		\N	vmod				\N	1
2060	Kalau beli kereta, wang akan habis.	ကားဝယ်လိုက်ရင် ပိုက်ဆံကုန်သွားမယ်။	null		\N	vmod				\N	1
3247	Saya letakkan pasu di atas meja. 	စားပွဲပေါ်မှာ ပန်းအိုးကို ထားလိုက်တယ်။(ပန်းအိုးကို စားပွဲပေါ်မှာ ထားလိုက်တယ်။)	\N		\N	vmod				71	1
3248	Ada kucing di bawah kerusi. 	ထိုင်ခုံ အောက်မှာ ကြောင် ရှိတယ်။	\N		\N	vmod				286	1
2868	Cik Matsui duduk di depan saya. 	 ကျွန်တော့်ရှေ့မှာ မစ္စတာ မဆုအိ ထိုင်တယ်။	\N		\N	vmod				604	1
1255	Ada taman di depan rumah saya. 	အိမ်ရဲ့ အရှေ့က ပန်းခြံ ပါ။	null		\N	vmod				\N	1
1249	Ada kucing di depan rumah. 	အိမ် ရဲ့ အရှေ့မှာ ကြောင် ရှိတယ်။	null		\N	vmod				\N	1
3235	Encik Yamada ada di dalam bilik darjah. 	မစ္စတာ ရာမဒ က စာသင်ခန်းထဲမှာ ရှိတယ်။	\N		\N	vmod				467	1
1258	Buku di dalam beg. 	စာအုပ်က လွယ်အိတ် ထဲမှာ ပါ။	null		\N	vmod				\N	1
1275	Ada anjing kecil di dalam kotak. 	သေတ္တာပုံးထဲမှာ ခွေးသေးသေးလေး ရှိတယ်။	null		\N	vmod				\N	1
1254	Encik Yamada ada di luar bilik darjah. 	မစ္စတာ ရာမဒ က စာသင်ခန်းရဲ့ အပြင်မှာ ရှိတယ်။	null		\N	vmod				\N	1
1410	Di luar sejuk? 	အပြင်မှာ အေးလား။	null		\N	vmod				\N	1
1734	Bolehkah saya pergi ke luar? 	အပြင်ထွက်လို့ ရမလား။	null		\N	vmod				\N	1
2867	Belok ke kanan selepas selekoh seterusnya.	နောက် အကွေ့တစ်ခု ရောက်ရင် ညာဘက်ကို ကွေ့မယ်။	\N		\N	vmod				618	1
1247	Encik Yamada ada di sebelah kanan Encik Tanaka. 	မစ္စတာ တာနာခါ ရဲ့ ညာဘက်မှာ မစ္စတာ ရာမဒ ရှိတယ်။	null		\N	vmod				\N	1
2866	Saya pegang penyepit makanan menggunakan tangan kiri.	ကျွန်မ(/ကျွန်တော်) ဘယ်ဘက်လက်နဲ့ တူကို ကိုင်တယ်။	\N		\N	vmod				544	1
1248	Cik Kimura ada di sebelah kiri Encik Tanaka.	မစ္စတာ တာနာခါ ရဲ့ ဘယ်ဘက်မှာ မစ္စတာ ခိမုရ ရှိတယ်။	null		\N	vmod				\N	1
1245	Ada beg di bawah meja.	စာရေးခုံ(/စာကြည့်စားပွဲ) အောက်မှာ လွယ်အိတ် ရှိတယ်။	null		\N	vmod				\N	1
1302	Beg besar itu saya punya.	အဲဒီ အိတ်ကြီးက ကျွန်မ(/ကျွန်တော်)ဟာပါ။	null		\N	vmod				\N	1
3658	Di rumah Encik Hayashi ada anjing dan kucing.	မစ္စတာ ဟယရှိ ရဲ့ အိမ်မှာ ခွေး နဲ့ ကြောင် ရှိတယ်။	\N		\N	vmod				497	1
3659	Ada kucing sedang tidur di sana.	ဟိုမှာ ကြောင်လေး အိပ်နေတယ်။	\N		\N	vmod				497	1
1251	Peti surat ada di depan rumah saya.	စာတိုက်ပုံးက အိမ်နဲ့ မျက်နှာချင်းဆိုင် မှာရှိတယ်။	null		\N	vmod				\N	1
1531	Peti surat ada di depan pejapat pos dan dekat stesen.	စာတိုက်ရဲ့ အရှေ့နဲ့ ဘူတာရဲ့ ဘေးတွေမှာ စာတိုက်ပုံး ရှိတယ်။	null		\N	vmod				\N	1
3256	Bahagian utara Jepun akan sangat sejuk apabila datangnya musim sejuk.	ဆောင်းတွင်းရောက်ရင် ဂျပန်ရဲ့မြောက်ဘက်ပိုင်းမှာ အရမ်းအေးတယ်။	\N		\N	vmod				184	1
2881	Semalam, saya pergi membeli barang di tempat berdekatan dengan stesen.	မနေ့က ဘူတာနားကို ဈေးဝယ် သွားတယ်။	\N		\N	vmod				391	1
1257	Sekolah terletak di kawasan dekat dengan rumah.	ကျောင်းက အိမ်နားမှာ ပါ။	null		\N	vmod				\N	1
2923	Saya berenang di dalam kolam renang kerana panas.	ပူလို့ ရေကူးကန်မှာ ရေကူးတယ်။	\N		\N	vmod				559	1
1548	Saya sering menonton filem dan pergi ke kolam renang bersama kawan saya.	သူငယ်ချင်းနဲ့ အမြဲလိုလို ရုပ်ရှင် ကြည့်လိုက် ရေကူးကန် သွားလိုက် နဲ့။	null		\N	vmod				\N	1
1778	Apa kata kalau kita pergi ke kolam renang? 	ရေကူးကန် မသွားဘူးလား။(ရေကူးကန် သွားရအောင်။)	null		\N	vmod				\N	1
2790	Di sini adalah tingkat dua.	ဒီနေရာက ဒုတိယထပ်ပါ။	\N		\N	vmod				704	1
2495	Ada di tingkat tiga bangunan ini. 	ဒီ အဆောက်အအုံရဲ့ သုံးထပ်(/တတိယထပ်)မှာ ရှိတယ်။			\N	vmod				\N	1
2497	Bagaimana cara untuk saya pergi ke tingkat tiga?	တတိယထပ်ကို ဘယ်လိုသွားရမလဲ။			\N	vmod				\N	1
2971	Itu surat khabar untuk hari ini.	အဲဒါ ဒီနေ့ သတင်းစာ ပါ။	\N		\N	vmod				312	1
2065	Kalau baca surat khabar setiap hari, awak boleh hafal.	နေ့တိုင်း သတင်းစာ ဖတ်ရင် မှတ်မိ လိမ့်မယ်။	null		\N	vmod				\N	1
3681	Saya lebih suka musim luruh daripada musim bunga.	ကျွန်မ(/ကျွန်တော်)က နွေဦးရာသီ ထက် ဆောင်းဦးရာသီကို ပို ကြိုက်(/နှစ်သက်)တယ်။	\N		\N	vmod				8	1
3680	Apabila musim panas berakhir, akan datang musim luruh.	နွေရာသီကုန်ရင် ဆောင်းဦးရာသီ လာမယ်။	\N		\N	vmod				8	1
1276	Encik Tanaka seseorang yang ceria.	မစ္စတာ တာနာခါ ဟာ တက်တက်ကြွကြွရှိတဲ့ လူ ဖြစ်တယ်။	null		\N	vmod				\N	1
1476	Saya rasa orang itu guru bahasa Jepun. 	အဲဒီလူ က ဂျပန်စာဆရာ ဖြစ်မယ် ထင်တယ်။	null		\N	vmod				\N	1
1274	Ada sebuah komputer baru di dalam bilik darjah.	စာသင်ခန်းမှာ ကွန်ပျူတာအသစ် ရှိတယ်။	null		\N	vmod				\N	1
1947	Saya dengar dari guru bahawa ada pelajar baru akan datang pada bulan depan.	ဆရာ့ဆီက ကြားတာ၊ နောက်လကစပြီးကျောင်းသားသစ် လာမယ်ဆိုပဲ။	null		\N	vmod				\N	1
3860	Saya buat kerja dengan menggunakan komputer.	ကွန်ပျူတာသုံးပြီး အလုပ်လုပ်တယ်။	\N		\N	vmod				823	1
1831	Sekarang ini saya nak sebuah komputer.	ကျွန်မ(/ကျွန်တော်) အခု ကွန်ပျူတာ လိုချင်တယ်။	null		\N	vmod				\N	1
3646	Saya memasukkan buku nota dan pen ke dalam kotak.	ပုံးထဲကို မှတ်စုစာအုပ်နဲ့ ဘောပင် ထည့်မယ်။	\N		\N	vmod				512	1
3647	Kotak ini sangat berat.	ဒီ သေတ္တာက အရမ်းပေါ့တယ်။	\N		\N	vmod				512	1
3473	Haiwan yang kecil sangat comel.	တိရစ္ဆာန် သေးသေးလေးတွေက အရမ်း ချစ်ဖို့ကောင်းတယ်။	\N		\N	vmod				387	1
3474	Rumah saya kecil dan sempit.	ကျွန်မ(/ကျွန်တော်) အိမ်က သေးပြီး ကျဉ်းတယ်။	\N		\N	vmod				387	1
3593	Encik Lee tidak sihat kerana selesema.	မစ္စတာ လီ အအေးမိ နေလို့၊ နေမကောင်းဘူး။	\N		\N	vmod				228	1
3594	Encik Yamada seorang yang sangat ceria.	မစ္စတာ ရာမဒ က အလွန် တက်ကြွတဲ့ လူ ဖြစ်တယ်။	\N		\N	vmod				228	1
3010	Adik perempuan pandai melukis.	ညီမလေး က ပန်းချီ တော်တယ်။	\N		\N	vmod				82	1
2806	Makanan Jepun sedap tetapi mahal.	ဂျပန်က အစားအသောက်တွေက စားလို့ကောင်းပေမယ့် ဈေးကြီးတယ်။	\N		\N	vmod				380	1
2780	Kasut ini sudah lama.	ဒီ ဖိနပ် က အဟောင်း ပါ။	\N		\N	vmod				569	1
1281	Filem lama Jepun.	ဂျပန် ရှေးဟောင်း ရုပ်ရှင် ဖြစ်ပါတယ်။	null		\N	vmod				\N	1
3518	Saya ingin pergi ke tempat yang senyap dan cantik.	ကျွန်မ(/ကျွန်တော်) ဆိတ်ငြိမ်ပြီး လှပတဲ့ နေရာကို သွားချင်တယ်။	\N		\N	vmod				285	1
1455	Warna lukisan ini cantik.	ဒီ ပန်းချီက အရောင်လှတယ်။	null		\N	vmod				\N	1
3519	Encik Matsui tinggal di bandar yang kawasannya senyap.	မစ္စတာ မဆုအိ က ဆိတ်ငြိမ်တဲ့မြို့ မှာ နေတယ်။	\N		\N	vmod				285	1
2023	Encik Yamada selalu ceria tetapi hari ini senyap.	မစ္စတာ ရာမဒ က အမြဲတမ်း တက်ကြွနေပြီး၊ ဒီနေ့တော့ ငြိမ်နေတယ်။	null		\N	vmod				\N	1
2785	Kami tanggalkan kasut di pintu masuk rumah. 	အိမ်အဝင်၀မှာ ဖိနပ်ကို ချွတ်တယ်။	\N		\N	vmod				208	1
1286	Awak nak beli kasut yang mana? 	ဘယ်လိုဖိနပ်မျိုးကိုဝယ်မလဲ။	null		\N	vmod				\N	1
2789	Saya sudah beli majalah di kedai buku.	စာအုပ်ဆိုင်မှာ မဂ္ဂဇင်းကို ဝယ်တယ်။	\N		\N	vmod				140	1
1534	Beg yang hitam dan besar itu saya punya.	အမဲရောင်(/အနက်ရောင်) အိတ်အကြီးကြီးက ကျွန်မ(/ကျွန်တော်)ဟာပါ။\n	null		\N	vmod				\N	1
2974	Sambil melihat kamus, saya belajar bahasa Jepun.	အဘိဓာန်ကိုကြည့်ပြီး(/သုံးပြီး) ဂျပန်စာ လေ့လာတယ်။	\N		\N	vmod				284	1
1291	Itulah kamus bahasa Jepun. 	ဂျပန်စာ အဘိဓာန်က အဲဒါ ပါ။	null		\N	vmod				\N	1
3134	Air di sungai ini bersih.	ဒီ ချောင်းက ရေက သန့်တယ်။	\N		\N	vmod				200	1
3272	Perempuan yang cantik itu adalah Cik Kimura.	ဟို အမျိုးသမီးချောလေးက မစ္စ ခိမုရ ပါ။	\N		\N	vmod				132	1
3472	Restoran ini besar dan cantik.	ဒီ စားသောက်ဆိုင်က ကြီးပြီး သန့်(/လှ)တယ်။	\N		\N	vmod				94	1
1401	Anjing di rumah saya besar.	ကျွန်မ(/ကျွန်တော်) အိမ်ကခွေးက ကြီးတယ်။	null		\N	vmod				\N	1
2835	Apabila keluar dari tandas, saya membasuh tangan.	အိမ်သာက ထွက်တဲ့အခါ လက်ကိုဆေးတယ်။	\N		\N	vmod				434	1
1305	Tumpang tanya, tandas ada di mana?	တစ်ဆိတ်လောက်မေးပါရစေ၊ အိမ်သာက ဘယ်နားမှာပါလဲ။	null		\N	vmod				\N	1
3288	Sila buat kerja awak di sana.	နင်(/မင်း/သင်/ခင်ဗျား/ရှင်) ဟိုဘက်မှာ အလုပ်လုပ်နေ ပါ။	\N		\N	vmod				26	1
3289	Cawan itu awak punya.	အဲဒီ ခွက်က နင်(/မင်း/သင်/ခင်ဗျား/ရှင်) ဟာ ပါ။	\N		\N	vmod				26	1
2234	Awak bekerja dengan rajin, ya.	နင်(/မင်း/သင်/ခင်ဗျား/ရှင်) တော်တော် အလုပ်လုပ်တာပဲနော်။	null		\N	vmod				\N	1
2170	Apakah pekerjaan awak?	နင်(/မင်း/သင်/ခင်ဗျား/ရှင်) ဘာအလုပ်လုပ် သလဲ။	null		\N	vmod				\N	1
3856	Pada hari jadi setiap tahun, saya akan makan kek. 	နှစ်တိုင်း မွေးနေ့မှာ ကိတ်မုန့်စားတယ်။	\N		\N	vmod				829	1
3855	Ibu saya sangat suka kek.	မေမေက ကိတ်မု့န် အရမ်းကြိုက်တယ်။	\N		\N	vmod				829	1
1319	Ada tujuh potong kek.	ကိတ်မုန့် ခုနစ်ခု ရှိတယ်။	null		\N	vmod				\N	1
3022	Saya menulis jawapan ujian dengan pen mata bulat.	စာမေးပွဲ အဖြေကို ဘောပင်နဲ့ ရေးတယ်။	\N		\N	vmod				586	1
2802	Saya beli kamera dengan harga tiga puluh ribu yen.	ယန်းသုံးသောင်းနဲ့ ကင်မရာ ဝယ်လိုက်တယ်။	\N		\N	vmod				89	1
2801	Harga jam tangan ini adalah seribu lima ratus yen.	ဒီ နာရီက ယန်းထောင့်ငါးရာ ပါ။	\N		\N	vmod				89	1
2965	Saya pinjam tiga buah buku di perpustakaan.	စာကြည့်တိုက်ကနေ စာအုပ် သုံးအုပ် ငှားခဲ့တယ်။	\N		\N	vmod				270	1
1323	Di atas meja guru ada dua buah kamus dan sebuah majalah. 	ဆရာ့ စာကြည့်စားပွဲပေါ်မှာ အဘိဓာန် နှစ်အုပ် နဲ့ မဂ္ဂဇင်း တစ်အုပ် ရှိတယ်။	null		\N	vmod				\N	1
2969	Majalah tidak boleh dipinjam di perpustakaan.	မဂ္ဂဇင်းကို စာကြည့်တိုက်မှာ ငှားလို့ မရဘူး။	\N		\N	vmod				271	1
2970	Majalah ini menarik.	ဒီ မဂ္ဂဇင်းက စိတ်ဝင်စားဖို့(/ဖတ်လို့)ကောင်းတယ်။	\N		\N	vmod				271	1
3114	Awak beli berapa keping roti?	ပေါင်မုန့် ဘယ်နှခု ဝယ်လိုက်လဲ။	\N		\N	vmod				46	1
3115	Ada berapa cawan di atas meja?	စားပွဲပေါ်မှာ ခွက် ဘယ်နှခွက် ရှိသလဲ။	\N		\N	vmod				46	1
3637	Saya membawa sapu tangan semasa keluar dari rumah.	အပြင်ထွက်တဲ့အခါ လက်ကိုင်ပဝါ ယူသွားတယ်။	\N		\N	vmod				535	1
3638	Saya tertinggal sapu tangan di dalam bilik darjah semalam.	မနေ့က အတန်းထဲမှာ လက်ကိုင်ပဝါ မေ့ကျန်ခဲ့တယ်။	\N		\N	vmod				535	1
2793	Ada sehelai kemeja.	ရှပ်အင်္ကျီ တစ်ထည် ရှိတယ်။	\N		\N	vmod				597	1
2794	Saya ambil dua keping gambar.	ဓာတ်ပုံ နှစ်ပုံ ရိုက်ခဲ့(/ရိုက်လိုက်)တယ်။	\N		\N	vmod				597	1
1640	Saya akan pergi beli kemeja.	 ရှပ်အင်္ကျီ သွားဝယ်မယ်။	null		\N	vmod				\N	1
1326	Berapa helai sapu tangan yang ada di sana? 	အဲဒီမှာ လက်ကိုင်ပဝါ ဘယ်နှထည် ရှိသလဲ။	null		\N	vmod				\N	1
3284	Sila tunggu dua minit.	နှစ်မိနစ် စောင့်ပါ။	\N		\N	vmod				571	1
1679	Lagi sepuluh minit sebelum pukul lima.	နောက် ဆယ်မိနစ်ဆို ငါးနာရီထိုးပြီ။	null		\N	vmod				\N	1
3285	Hari ini hari Ahad tetapi saya pergi ke syarikat.	ဒီနေ့ တနင်္ဂနွေနေ့ ဆိုပေမယ့် ကုမ္ပဏီ(/အလုပ်)သွားရမယ်။	\N		\N	vmod				489	1
1392	Pada hari Ahad saya bermain tenis.	တနင်္ဂနွေနေ့မှာ တင်းနစ် ကစားတယ်။	null		\N	vmod				\N	1
2845	Saya tidak berapa suka belajar.	ကျွန်မ(/ကျွန်တော်) စာကို သိပ်စိတ်မဝင်စားဘူး။	\N		\N	vmod				581	1
2846	Pada minggu lepas saya sibuk, jadi saya tidak boleh belajar.	ရှေ့အပတ်က အလုပ်များလို့ စာမလုပ်နိုင်ဘူး။	\N		\N	vmod				581	1
1341	TV ada di sebelah piano.	တီဗွီက စန္ဒရား ဘေးမှာ ရှိတယ်။	null		\N	vmod				\N	1
2192	Saya makan nasi sambil menonton TV.	တီဗွီ ကြည့်ရင်း ထမင်းစားတယ်။	null		\N	vmod				\N	1
1630	Menonton TV adalah tidak baik untuk mata.	တီဗွီက မျက်စိ အတွက် မကောင်းဘူး။	null		\N	vmod				\N	1
3006	Saya berlatih piano setiap hari.	ကျွန်မ(/ကျွန်တော်) နေ့တိုင်း စန္ဒရား လေ့ကျင့်တယ်။	\N		\N	vmod				759	1
3618	Majlis kahwin kakak saya diadakan pada minggu lepas. 	ရှေ့အပတ်က အစ်မရဲ့ မင်္ဂလာပွဲ ရှိလို့။	\N		\N	vmod				506	1
2991	Saya tidak hadir ke sekolah pada hari ini kerana demam.	အဖျားရှိလို့ ဒီနေ့ကျောင်းကို နားတယ်။(အဖျားရှိလို့ ဒီနေ့ကျောင်းမသွားဘူး။)	\N		\N	vmod				654	1
3133	Ada kucing di depan pintu pagar rumah.	အိမ်က တံခါးရဲ့ ရှေ့မှာ ကြောင်ရှိတယ်။	\N		\N	vmod				646	1
3042	Pada tahun lepas, tidak banyak salji yang turun.	မနှစ်က နှင်း သိပ်မကျဘူး။	\N		\N	vmod				568	1
1931	Kelihatannya hujan akan turun.	မိုး ရွာမလိုပဲ။	null		\N	vmod				\N	1
3351	Saya akan pergi makan malam selepas habis kerja.	အလုပ်ပြီးရင် ညစာ သွားစားမယ်။	\N		\N	vmod				130	1
1348	Kelas akan habis pada waktu pagi esok.	မနက်ဖန် မနက်ပိုင်းမှာတင် အတန်းပြီးမယ်။(မနက်ဖန် နေ့လယ်ဆို အတန်းပြီးပြီ။)	null		\N	vmod				\N	1
3730	Matsui masih belum membuat kerja rumah.	မစ္စတာ မဆုအိ အိမ်စာ မလုပ်သေးဘူး။	\N		\N	vmod				608	1
3731	Sekarang masih pukul sepuluh pagi.	အခု ဆယ်နာရီပဲ ရှိသေးတယ်။	\N		\N	vmod				608	1
1367	Saya balik ke rumah.	အိမ်ပြန်မယ်။	null		\N	vmod				\N	1
1710	Minta dua air coca-cola.	ကိုကာကိုလာ နှစ်ခွက် ပေးပါ။	null		\N	vmod				\N	1
1371	Encik Yamada akan minum air coca-cola.	မစ္စတာ တာနာခါ ကိုကာကိုလာ သောက်တယ်။	null		\N	vmod				\N	1
1818	Saya ingin minum air.	ရေ သောက်ချင်တယ်။	null		\N	vmod				\N	1
2004	Saya sudah baik kerana makan ubat tadi.	ဆေးသောက်လိုက်ရင် ကောင်းသွားမှာပါ။	null		\N	vmod				\N	1
1396	Saya tengok wayang.	ရုပ်ရှင် ကြည့်ခဲ့တယ်။	null		\N	vmod				\N	1
1974	Saya tengok Encik Tanaka sedang belajar di perpustakaan. 	စာကြည့်တိုက်မှာစာဖတ်နေတဲ့ မစ္စတာ တာနာခါ ကိုတွေ့ခဲ့တယ်။(မစ္စတာ တာနာခါ ကို စာကြည့်တိုက်မှာစာဖတ်နေတာ တွေ့လိုက်တယ်။)	null		\N	vmod				\N	1
1482	Ada ditulis di dalam surat.	စာထဲမှာ ရေးထားတယ်။	null		\N	vmod				\N	1
1378	Saya akan hantar surat kepada Encik Tanaka.	မစ္စတာ တာနာခါ ဆီကို စာ ပို့မယ်။	null		\N	vmod				\N	1
1654	Cikgu memberi soalan.	ဆရာကနေ မေးခွန်း မေးခဲ့တယ်။	null		\N	vmod				\N	1
1379	Saya meminjamkan wang kepada Encik Yamada.	မစ္စတာ ရာမဒကို ပိုက်ဆံချေးတယ်။	null		\N	vmod				\N	1
2092	Kimura meminjamkan buku kepada saya.	မစ္စတာ ခိမုရ ဆီက စာအုပ် ငှားခဲ့တယ်။	null		\N	vmod				\N	1
2090	Saya meminjamkan buku nota kepada Encik Kobayashi.	ကျွန်မ(/ကျွန်တော်) မစ္စတာ ခိုဘယရှိ ကို မှတ်စုစာအုပ် ငှားလိုက်တယ်။	null		\N	vmod				\N	1
3852	Saya meminjam buku daripada perpustakaan dan telah membacanya.	စာကြည့်တိုက်မှာ စာအုပ်ငှားပြီး ဖတ်တယ်။	\N		\N	vmod				170	1
1382	Saya meminjam wang daripada Encik Yamada.	မစ္စတာ ရာမဒဆီက ပိုက်ဆံချေးတယ်။	null		\N	vmod				\N	1
3396	Saya belajar bahasa Jepun dengan guru itu.	ကျွန်မ(/ကျွန်တော်) အဲဒီဆရာဆီမှာ ဂျပန်စာ သင်(/တက်)နေတယ်။	\N		\N	vmod				480	1
3397	Semalam Encik Lee belajar kanji daripada Encik Matsui.	 မစ္စတာ လီ မနေ့က မစ္စတာ မဆုအိ ဆီမှာ ခန်းဂျီး သင်တယ်။	\N		\N	vmod				480	1
3854	Dinding bilik darjah ini tebal.	ဒီ စာသင်ခန်းရဲ့ နံရံက ထူတယ်။	\N		\N	vmod				830	1
1614	Saya akan tampal gambar di dinding.	နံရံမှာ ဓာတ်ပုံ ကပ်မယ်။	null		\N	vmod				\N	1
3347	Jangan letak benda di sini.	ဒီမှာ ပစ္စည်းထားလို့ မရဘူး။	\N		\N	vmod				101	1
1386	Saya letak buku di atas meja.	စာရေးခုံ(/စာကြည့်စားပွဲ)ပေါ်မှာ စာအုပ်ကို ထားတယ်။	null		\N	vmod				\N	1
3392	Cik Kimura menunjukkan gambar kepada saya.	မစ္စတာ ခိမုရ က ကျွန်မ(/ကျွန်တော်)ကို ဓာတ်ပုံပြတယ်။	\N		\N	vmod				622	1
1625	Saya menunjukkan buku kepada Encik Tanaka.	မစ္စတာ တာနာခါ ကို စာအုပ် ပြမယ်။	null		\N	vmod				\N	1
3118	Saya berlatih tenis pada setiap hari.	ကျွန်မ(/ကျွန်တော်) နေ့တိုင်း တင်းနစ် လေ့ကျင့်တယ်။	\N		\N	vmod				779	1
1881	Encik Tanaka boleh bermain tenis.	မစ္စတာ တာနာခါ က တင်းနစ် ရိုက်တတ်တယ်။	null		\N	vmod				\N	1
3053	Kerana malam sejuk, saya keluar dengan membawa kot.	ညဆို အေးလို့  ကုတ်အင်္ကျီ ယူပြီး အပြင်ထွက်တယ်။(ညဆို အေးလို့ အပြင်ထွက်ရင် ကုတ်အင်္ကျီ ယူသွားတယ်။)	\N		\N	vmod				273	1
1403	Hari ini tidak sejuk.	ဒီနေ့ မအေးဘူး(/မချမ်းဘူး)။	null		\N	vmod				\N	1
3508	Encik Yamada seorang yang kelakar.	မစ္စတာ ရာမဒ က စိတ်ဝင်စားဖို့ကောင်းတဲ့ လူ ပဲ။	\N		\N	vmod				127	1
3509	Kelas ini sangat menarik.	ဒီ အတန်းက အရမ်း စိတ်ဝင်စားဖို့ ကောင်းတယ်။	\N		\N	vmod				127	1
3212	Bekal Encik Hayashi kelihatan sedap.	မစ္စတာ ဟယရှိ ရဲ့ ထမင်းဘူးက စားချင်စရာကောင်းလိုက်တာ။	\N		\N	vmod				92	1
3213	Kuih ini sedap.	ဒီ မုန့်က စားလို့ကောင်းတယ်။	\N		\N	vmod				92	1
1537	Bunga ini kecil dan berwarna merah.	ဒီပန်းက သေးပြီး နီတယ်။ (ဒီပန်းက သေးသေးနီနီလေး။)	null		\N	vmod				\N	1
3495	Encik Yamada paling tinggi di dalam kelas.	မစ္စတာ ရာမဒ က အတန်းထဲမှာ အရပ် အရှည်ဆုံး ပဲ။	\N		\N	vmod				367	1
3496	Saya ingin tinggal di tempat yang tinggi.	ကျွန်မ(/ကျွန်တော်) မြင့်တဲ့ နေရာမှာ နေချင်တယ်။	\N		\N	vmod				367	1
3700	Kamus ini tidak begitu bagus.	ဒီ အဘိဓာန်က သိပ်မကောင်းဘူး။	\N		\N	vmod				34	1
1428	Saya tidak begitu penat.	သိပ် မပင်ပန်းခဲ့ဘူး။	null		\N	vmod				\N	1
1426	Bilik saya tidak begitu luas.	ကျွန်မ(/ကျွန်တော်) အခန်းက သိပ် မကျယ်ဘူး။	null		\N	vmod				\N	1
2783	Encik Matsui pakai baju putih.	မစ္စတာ မဆုအိ က အဖြူရောင် အင်္ကျီကို ဝတ်ထားတယ်။	\N		\N	vmod				561	1
1435	Cantiknya baju ini, ya.	လှလိုက်တဲ့ အင်္ကျီလေး။/အင်္ကျီလေးက လှတယ်နော်။	null		\N	vmod				\N	1
2130	Tumpang tanya, boleh saya cuba baju ini?	တစ်ဆိတ်လောက်မေးပါရစေ၊ ဒီ အင်္ကျီ ဝတ်ကြည့်လို့ ရမလား။	null		\N	vmod				\N	1
3057	Orang yang berambut hitam itu adalah Encik Matsui. 	ဟို ဆံပင်အနက်ရောင်နဲ့လူ က မစ္စတာ မဆုအိ ပါ။	\N		\N	vmod				764	1
3634	Kami beratur bermula dari ketinggian yang rendah.	အရပ်ပုတဲ့လူ ကနေစပြီး တန်းစီးမယ်။	\N		\N	vmod				331	1
1446	Ketinggian badan Tanaka tinggi.	မစ္စတာ တာနာခါ က အရပ်ရှည်တယ်။	null		\N	vmod				\N	1
3123	Brazil adalah sebuah negara yang sangat kuat dalam bola sepak.	ဘရာဇီးဟာ ဘောလုံး အရမ်း အားသာတဲ့ နိုင်ငံ ဖြစ်တယ်။	\N		\N	vmod				411	1
2766	Oleh sebab gigi saya sakit, saya tidak boleh makan apa-apa.	သွားနာလို့ ဘာမှစားလို့မရဘူး။/သွားနာလို့ ဘာမှ မစားနိုင်ဘူး။	\N		\N	vmod				52	1
1450	Kepala awak sakit?	ခေါင်းကိုက်တယ်။	null		\N	vmod				\N	1
1451	Tidak, tidak sakit.	ဟင့်အင်း၊မနာဘူး(/မကိုက်ဘူး)။	null		\N	vmod				\N	1
3652	Pada bulan lepas, pusat membeli-belah telah dibuka di bandar jiran.	ရှေ့လက ဘေးကပ်လျက်မြို့မှာ ကုန်တိုက် အသစ်ဖွင့်တယ်။	\N		\N	vmod				609	1
3653	Saya akan tinggal di bandar ini mulai tahun depan.	ကျွန်မ(/ကျွန်တော်) နောက်နှစ် ကစပြီး ဒီမြို့မှာ နေမယ်။	\N		\N	vmod				609	1
2906	Oleh sebab jalan ini sangat sempit, ia berbahaya.	ဒီလမ်းက အရမ်း ကျဉ်းပြီး အန္တရာယ်များတယ်။	\N		\N	vmod				623	1
1478	Sila telefon dan tanya, sekiranya awak tidak tahu jalan.	လမ်းမသိခဲ့ရင် ဖုန်းဆက်မေးပါ။	null		\N	vmod				\N	1
1454	Jalan di bandar ini sempit.	ဒီမြို့က လမ်းကျဉ်းတယ်။	null		\N	vmod				\N	1
3245	Warna ini sangat cantik.	ဒီအရောင်က အရမ်း လှတယ်။	\N		\N	vmod				69	1
3050	Saya paling suka lagu ini. 	ကျွန်မ(/ကျွန်တော်) ဒီသီချင်းကို အကြိုက်ဆုံးပဲ။	\N		\N	vmod				74	1
1457	Saya tidak pandai menyanyi lagu.	ကျွန်မ(/ကျွန်တော်) သီချင်းဆို ညံ့တယ်။(ကျွန်မ(/ကျွန်တော်) သီချင်းမဆိုတတ်ဘူး။)	null		\N	vmod				\N	1
3898	Ayah Cik Kimura berusia lima puluh dua tahun.	မစ္စတာ ခိမုရ ရဲ့အဖေက အသက်ငါးဆယ့်နှစ် နှစ်ပါ။	\N		\N	vmod				110	1
2993	Saya akan bekerja selama lapan jam setiap hari.	နေ့တိုင်း ရှစ်နာရီကြာ အလုပ်လုပ်တယ်။(နေ့တိုင်း တစ်နေ့ကို ရှစ်နာရီ အလုပ်လုပ်တယ်။)	\N		\N	vmod				521	1
2992	Saya berkerja juga pada hari Ahad.	ကျွန်မ(/ကျွန်တော်) တနင်္ဂနွေနေ့လည်း အလုပ်လုပ်တယ်။	\N		\N	vmod				521	1
1459	Ayah Encik Yamada seorang yang berkerja dengan rajin.	မစ္စတာ ရာမဒ ကတော့၊ သူ့အဖေ က အရမ်း(/တော်တော်)အလုပ်လုပ်တယ်။(မစ္စတာ ရာမဒ ရဲ့ အဖေက အရမ်း အလုပ်လုပ်တယ်။)	null		\N	vmod				\N	1
1460	Ayah Encik Yamada seorang doktor.	မစ္စတာ ရာမဒ ကတော့၊ သူ့အဖေ က ဆရာဝန်လေ။(မစ္စတာ ရာမဒ ရဲ့ အဖေက ဆရာဝန် ပါ။)	null		\N	vmod				\N	1
3605	Kamus ini sangat ringan dan mudah diguna.	ဒီအဘိဓာန်က အရမ်း ပေါ့ပြီး အဆင်ပြေတဲ့ အဘိဓာန် ပဲ။	\N		\N	vmod				583	1
3606	Kapal terbang laju dan berguna.	လေယာဉ်ပျံက မြန်ပြီး အဆင်ပြေတယ်။	\N		\N	vmod				583	1
1599	Saya baca buku.	ကျွန်မ(/ကျွန်တော်) စာအုပ်ဖတ်ခဲ့တယ်။	null		\N	vmod				\N	1
1696	Kanji ini sebutannya dibaca "yama".	ဒီ ခန်းဂျီးကို “ရာမ” လို့ ဖတ်တယ်။	null		\N	vmod				\N	1
3371	Saya menyanyi lagu sambil berdiri.	မတ်တပ်ရပ်ပြီး သီချင်းဆိုတယ်။	\N		\N	vmod				373	1
3372	Di sana ada Cik Kimura sedang berdiri. 	ဟိုမှာ မစ္စတာ ခိမုရ ရပ်နေတယ်။	\N		\N	vmod				373	1
1485	Sila berdiri.	မတ်တပ်ရပ်(/မတ်တပ်ထ) ပါ။	null		\N	vmod				\N	1
3331	Jangan buka tingkap di sana kerana ia berbahaya.	အန္တရာယ်ရှိလို့ ဟိုက ပြတင်းပေါက်ကို မဖွင့်ပါနဲ့။	\N		\N	vmod				613	1
2894	Bilik ini tiada tingkap.	ဒီအခန်းက ပြတင်းပေါက် မရှိဘူး။	\N		\N	vmod				613	1
3330	この　ボタンを　押すと、　ドアが　開きます。	ဒီ ခလုတ်ကို နှိပ်လိုက်ရင် တံခါး ပွင့်မယ်။	\N		\N	vmod				9	1
1501	\nTingkap buka.	ပြတင်းပေါက် ပွင့်နေတယ်။	null		\N	vmod				\N	1
1921	Sekarang pukul 10, jadi pejabat pos pasti sudah buka.	အခု ဆယ်နာရီ ဆိုတော့၊ စာတိုက် ဖွင့်နေလောက်ပြီ။	null		\N	vmod				\N	1
3434	Setiap pagi saya akan baca surat khabar dan pergi ke syarikat.	မနက်တိုင်း သတင်းစာ ဖတ်ပြီး ကုမ္ပဏီ သွားတယ်။	\N		\N	vmod				598	1
3435	Saya bangun pada pukul enam setiap pagi.	နေ့တိုင်း ခြောက်နာရီမှာ အိပ်ရာ ထတယ်။	\N		\N	vmod				598	1
3323	Saya berkahwin dengan isteri saya pada lima tahun yang lalu.	လွန်ခဲ့တဲ့ ငါးနှစ်တုန်းက အမျိုးသမီးနဲ့ လက်ထပ်ခဲ့တယ်။	\N		\N	vmod				499	1
3324	Encik Lee akan ada di Jepun selama tiga tahun.	မစ္စတာ လီ က ဂျပန်မှာ သုံးနှစ် နေမယ်လို့ စဉ်းစားထားတယ်။	\N		\N	vmod				499	1
3369	Encik Kobayashi tidak tahu restoran itu.	မစ္စတာ ခိုဘယရှိ က အဲဒီစားသောက်ဆိုင်ကို မသိဘူး။	\N		\N	vmod				308	1
3370	Saya tahu nombor telefon Encik Yamada.	ကျွန်မ(/ကျွန်တော်) မစ္စတာ ရာမဒ ရဲ့ ဖုန်းနံပါတ်ကို သိတယ်။	\N		\N	vmod				308	1
3588	Guru di kelas sebelah masih muda.	ဘေးအတန်းက ဆရာက ငယ်ငယ်လေးပဲ ရှိသေးတယ်။	\N		\N	vmod				695	1
2884	Jika belok ke kiri di bangunan itu, di situ ada hospital.	အဲဒီ အဆောက်အအုံရဲ့ ဘယ်ဘက်ကို ကွေ့လိုက်ရင် ဆေးရုံရှိတယ်။	\N		\N	vmod				605	1
1507	Jalan ini berliku-liku.	ဒီလမ်း က ကွေ့ကောက် နေတယ်။	null		\N	vmod				\N	1
3153	Saya pergi membeli-belah dengan kawan-kawan saya pada hari cuti.	ပိတ်ရက်မှာ သူငယ်ချင်း နဲ့ ဈေးသွားဝယ်မယ်။	\N		\N	vmod				139	1
3617	Saya membeli-belah di pasar raya untuk menyediakan masakan malam.	စူပါမားကက်မှာ ညစာအတွက်ဈေးဝယ်ခဲ့တယ်။	\N		\N	vmod				139	1
3368	Saya tutup pintu sebaik sahaja masuk ke dalam bilik.	အခန်းထဲကို ဝင်ရင် တံခါးပိတ်တယ်။	\N		\N	vmod				750	1
1512	Tingkap tutup.	ပြတင်းပေါက် ပိတ်ထားတယ်။	null		\N	vmod				\N	1
2901	Saya belajar dengan memasang lampu di bilik.	အခန်းမီးဖွင့်ပြီး စာဖတ်တယ်။	\N		\N	vmod				428	1
1513	Lampu sudah dipadamkan. 	မီး ပိတ်ထားပြီးပြီ။	null		\N	vmod				\N	1
3128	Apabila keluar, saya terlupa untuk memadamkan lampu.	အပြင်ထွက်တုန်းက မီးပိတ်ဖို့ မေ့သွားတယ်။	\N		\N	vmod				222	1
3129	Saya memadamkan lampu sebelum tidur.	မအိပ်ခင် မီးပိတ်တယ်။	\N		\N	vmod				222	1
2115	Saya berjalan kaki ke stesen.	ဘူတာအထိ လမ်းလျှောက် သွားမယ်။	null		\N	vmod				\N	1
1551	Esok saya akan berjumpa dengan kawan di stesen dan kami akan pergi menonton konsert bersama-sama.	ကျွန်မ(/ကျွန်တော်) မနက်ဖန် ဘူတာမှာ သူငယ်ချင်းနဲ့တွေ့ပြီး သူနဲ့အတူ ဂီတပွဲ သွားမယ်။	null		\N	vmod				\N	1
2857	Soalan ini sangat mudah.	ဒီ ပုစ္ဆာက အရမ်း လွယ်တယ်။	\N		\N	vmod				647	1
3627	Buku ini mempunyai seratus dua puluh muka surat.	ဒီ စာအုပ်က စာမျက်နှာ တစ်ရာ့နှစ်ဆယ် ရှိတယ်။	\N		\N	vmod				573	1
1515	Soalan ada ditulis pada muka surat lima belas. 	မေးခွန်းက စာမျက်နှာဆယ်ငါးမှာ ရေးထားတယ်။	null		\N	vmod				\N	1
3171	Kita menulis jawapan pada kertas ini.	ဒီ စာရွက် မှာ မေးခွန်းရဲ့ အဖြေကို ရေးပါ။	\N		\N	vmod				146	1
3172	Saya menulis surat kepada kawan semalam.	မနေ့က သူငယ်ချင်းဆီ စာရေးခဲ့တယ်။	\N		\N	vmod				146	1
3060	Saya telah memotong rambut saya semalam.	ကျွန်မ(/ကျွန်တော်) မနေ့က ဆံပင် ညှပ်ခဲ့တယ်။	\N		\N	vmod				199	1
2871	Saya memotong kek kepada empat bahagian menggunakan pisau.	ကိတ်မုန့်ကို ဓားနဲ့ လေးပိုင်းပိုင်းတယ်။	\N		\N	vmod				199	1
3329	Saya buka pintu dan masuk ke dalam bilik. 	တံခါး ဖွင့်ပြီး အခန်းထဲ ဝင်မယ်။	\N		\N	vmod				10	1
3328	Oleh sebab panas, saya buka tingkap.	နည်းနည်း အိုက်လို့ ပြတင်းပေါက်ဖွင့်မယ်။	\N		\N	vmod				10	1
1520	Tingkap sedang buka.	ပြတင်းပေါက် ဖွင့်ထားတယ်။	null		\N	vmod				\N	1
3168	Saya susah untuk bercakap dalam bahasa inggeris.	အင်္ဂလိပ်လိုပြောရတာ ခက်တယ်။	\N		\N	vmod				526	1
3169	Encik Matsui sedang bercakap dengan Encik Kobayashi.	မစ္စတာ မဆုအိက မစ္စတာ ခိုဘယရှိ နဲ့ စကားပြောနေတယ်။	\N		\N	vmod				526	1
1609	Saya makan roti sahaja.	ပေါင်မုန့် ပဲ စားလိုက်တယ်။	null		\N	vmod				\N	1
1532	Saya makan roti, telur dan lain-lain lagi.	ပေါင်မုန့် တို့ ကြက်ဥ တို့ စားတယ်။	null		\N	vmod				\N	1
3409	Saya akan ke sekolah mulai pagi pada hari Isnin.	တနင်္လာနေ့ဆို မနက်ကတည်းက ကျောင်းသွားတယ်။	\N		\N	vmod				226	1
3120	Encik Matsui lebih pandai bermain besbol daripada bola sepak.	မစ္စတာ မဆုအိ က ဘောလုံး ထက် ဘေ့စ်ဘော ပိုတော်တယ်။	\N		\N	vmod				777	1
1530	Saya membeli barang di pusat membeli-belah dan pasar raya.	ကုန်တိုက် တို့ စူပါမားကက် တို့မှာဈေးဝယ်တယ်။	null		\N	vmod				\N	1
3111	Saya pergi ke pasar raya untuk membeli barang.	စူပါမားကက်ကို ဈေးဝယ်သွားတယ်။	\N		\N	vmod				788	1
3623	Saya makan telur dengan bubuh garam.	ကြက်ဥကို ဆားဖြူးပြီး စားတယ်။	\N		\N	vmod				382	1
3624	Saya makan roti dan telur setiap pagi.	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း ပေါင်မုန့် နဲ့ ကြက်ဥ စားတယ်။	\N		\N	vmod				382	1
3018	Saya sentiasa tidur di atas katil.	ကျွန်မ(/ကျွန်တော်) အမြဲတမ်း အိပ်ရာ မှာ အိပ်တယ်။	\N		\N	vmod				575	1
1535	Saya tinggal di flat yang cantik dan senyap.	လှပပြီး တိတ်ဆိတ်တဲ့ အိမ်ခန်း မှာ နေတယ်။	null		\N	vmod				\N	1
1928	Rasanya ada orang yang tinggal di rumah ini.	ဒီအိမ်မှာ တစ်ယောက်ယောက် နေ နေသလိုပဲ။	null		\N	vmod				\N	1
3066	Orang itu adalah pelajar antarabangsa sekolah ini.	ဟိုလူက(/သူက) ဒီကျောင်းက နိုင်ငံခြားသား ကျောင်းသားပါ။	\N		\N	vmod				681	1
3065	Pelajar antarabangsa akan datang dari China bulan depan.	နောက်လမှာ တရုတ်ပြည်က ပညာတော်သင်ကျောင်းသား လာမယ်။	\N		\N	vmod				681	1
3587	Orang yang muda dan ceria itu adalah Encik Yamada.	ဟို ငယ်ရွယ်ပြီး သွက်လက်တဲ့လူက မစ္စတာ ရာမဒ ပါ။	\N		\N	vmod				695	1
1542	Stoking ini tahan lama dan murah. 	ဒီခြေအိတ်က ခိုင်ပြီး ဈေးပေါတယ်။	null		\N	vmod				\N	1
1544	Buku ini susah kerana ada banyak tulisan kanji.	ဒီ စာအုပ်က ခန်းဂျီးတွေ များပြီး ခက်တယ်။	null		\N	vmod				\N	1
3135	Encik Lee boleh berbahasa Jepun.	မစ္စတာ လီ က ဂျပန်လို တတ်တယ်။	\N		\N	vmod				418	1
2069	Saya berenang walaupun sejuk.	ချမ်းပေမယ့်လည်း ရေကူးမယ်။	null		\N	vmod				\N	1
1562	Kereta api terhenti kerana datangnya taufan besar.	မုန်တိုင်းကြီးဝင်လို့ ရထားတွေရပ်ကုန်တယ်။	null		\N	vmod				\N	1
1546	Semasa cuti musim panas, saya bermain tenis dan berenang. 	ကျွန်မ(/ကျွန်တော်) နွေရာသီပိတ်ရက်မှာ တင်းနစ် ရိုက်လိုက် ရေကူးလိုက် လုပ်တယ်။	null		\N	vmod				\N	1
2093	Saya meminjamkan wang kepada adik lelaki saya. 	ကျွန်မ(/ကျွန်တော်) မောင်လေး(/ညီလေး)ကို ပိုက်ဆံ ချေးလိုက်တယ်။	null		\N	vmod				\N	1
2030	Saya tinggal di Tokyo manakala adik lelaki saya pula tinggal di Kyoto.	ကျွန်မ(/ကျွန်တော်)က တိုကျိုမှာ နေပေမယ့် မောင်လေး(/ညီလေး) ကတော့ ကျိုတိုမှာ နေတယ်။	null		\N	vmod				\N	1
1547	Pada hari Ahad, adik lelaki saya membaca buku serta menonton televisyen.	တနင်္ဂနွေနေ့ဆို မောင်လေး(/ညီလေး)က စာအုပ်ဖတ်လိုက် တီဗွီကြည့်လိုက် လုပ်တယ်။	null		\N	vmod				\N	1
1549	Saya sering berulang-alik di antara Tokyo dan Osaka dengan kapal terbang. 	လေယာဉ်ပျံနဲ့ တိုကျိုနဲ့ အိုဆာကာကို သွားလိုက်လာလိုက် လုပ်တယ်။	null		\N	vmod				\N	1
3326	Saya akan berjumpa dengan Cik Kimura di stesen malam ini.	ဒီည ဘူတာမှာ မစ္စတာ ခိမုရ နဲ့တွေ့မယ်။	\N		\N	vmod				2	1
3327	Esok saya akan berjumpa dengan Encik Lee dan memberinya cenderamata.	မနက်ဖန် မစ္စတာ လီ နဲ့တွေ့ပြီး လက်ဆောင် ပေးမယ်။	\N		\N	vmod				2	1
3857	Saya pergi menonton konsert bersama kawan semalam.	မနေ့က သူငယ်ချင်းနဲ့ ဂီတပွဲ သွားခဲ့တယ်။	\N		\N	vmod				832	1
1660	Ada konsert di taman	ပန်းခြံမှာ ဂီတပွဲ ရှိတယ်။	null		\N	vmod				\N	1
1388	Saya bangun pada pukul tujuh setengah.	ကျွန်မ(/ကျွန်တော်) ခုနစ်နာရီခွဲမှာ အိပ်ရာထတယ်။	null		\N	vmod				\N	1
2018	Saya tidak dapat bangun kerana demam.	ကိုယ်ပူပြီး အိပ်ရာကမထနိုင်ဘူး။	null		\N	vmod				\N	1
2042	Setiap pagi selepas bangun, ayah saya membaca surat khabar. 	အဖေ မနက်အိပ်ရာထတိုင်း သတင်းစာ ဖတ်တယ်။	null		\N	vmod				\N	1
1588	Saya akan makan nasi di kantin.	စားသောက်ဆိုင်မှာ ထမင်းစားတယ်။	null		\N	vmod				\N	1
1553	Saya bangun pada pukul tujuh pagi, makan sarapan di kantin dan berlatih dari pukul lapan. 	မနက် ခုနစ်နာရီမှာ အိပ်ရာထတယ်၊ စားသောက်ဆိုင်မှာ မနက်စာ စားတယ်၊ ပြီးတော့ရှစ်နာရီ ကစပြီး လေ့ကျင့်တယ်။	null		\N	vmod				\N	1
2874	Saya ingin duduk berehat kerana letih.	ပင်ပန်းလို့ ထိုင်ပြီးအနားယူမယ်။	\N		\N	vmod				330	1
1586	Saya berjalan kaki dari sekolah ke rumah.	ကျောင်းကနေ အိမ်အထိ ခြေလျင်လျှောက်တယ်။	null		\N	vmod				\N	1
1557	Saya berjalan kaki ke sekolah setiap hari. 	ကျွန်မ(/ကျွန်တော်) နေ့တိုင်း ကျောင်းကို လမ်းလျှောက်သွားတယ်။	null		\N	vmod				\N	1
1477	Ini pita pelekat yang saya beli semalam.	ဒါ မနေ့က ဝယ်ခဲ့တဲ့ တိတ်ခွေပါ။	null		\N	vmod				\N	1
1558	Saya belajar bahasa Jepun dengan mendengar pita kaset.	တိတ်ခွေနားထောင်ပြီး ဂျပန်စာ လေ့လာတယ်။	null		\N	vmod				\N	1
3666	Laut di sana kelihatan sangat cantik.	ဟို(/အဲဒီ)က ပင်လယ်က အရမ်း လှတယ်။	\N		\N	vmod				78	1
3667	Ibu bapa saya tinggal dekat laut.	ကျွန်မ(/ကျွန်တော်) မိဘတွေက ပင်လယ်ကမ်းခြေဘေးနားမှာ နေတယ်။	\N		\N	vmod				78	1
3668	Banyak haiwan di gunung itu.	အဲဒီတောင်မှာ တိရစ္ဆာန်တွေ အများကြီးရှိတယ်။	\N		\N	vmod				656	1
3669	Sekolah terletak berdekatan gunung itu.	ကျောင်းက အဲဒီတောင်နားမှာ ရှိတယ်။	\N		\N	vmod				656	1
3395	Saya akan mendaki gunung bersama kawan pada hujung minggu.	စနေတနင်္ဂနွေ မှာ သူငယ်ချင်းနဲ့ တောင်တက်မယ်။	\N		\N	vmod				501	1
3394	Saya pernah mendaki gunung itu.	ကျွန်မ(/ကျွန်တော်) အဲဒီတောင်ကို တက်ဖူးတယ်။	\N		\N	vmod				501	1
3121	Tiada perlawanan besbol kerana hujan turun.	မိုးရွာလို့ ဘေ့စ်ဘော ပြိုင်ပွဲ မရှိဘူး။	\N		\N	vmod				778	1
3122	Esok akan ada perlawanan tenis.	မနက်ဖန် တင်းနစ်ပြိုင်ပွဲ ရှိတယ်။	\N		\N	vmod				790	1
2830	Kereta api ini pergi ke Tokyo.	ဒီရထားက တိုကျိုကို သွားတယ်။	\N		\N	vmod				429	1
1672	Kereta api lewat sampai kerana taufan.	မုန်တိုင်းကြောင့် ရထားနောက်ကျတယ်။	null		\N	vmod				\N	1
1619	Saya naik kapal terbang.	လေယာဉ်ပျံ စီးမယ်။	null		\N	vmod				\N	1
3380	Lif ini berhenti dari tingkat dua sehingga tingkat sembilan.	ဒီ ဓာတ်လှေခါးက နှစ်ထပ်ကနေ ကိုးထပ်အထိ ရပ်တယ်။	\N		\N	vmod				457	1
3381	Sebuat kereta berhenti di depan saya.	ကျွန်မ(/ကျွန်တော်) ရှေ့မှာကားလာရပ်တယ်။	\N		\N	vmod				457	1
1636	Bunga mekar di halaman rumah.	ခြံထဲမှာ ပန်းတွေပွင့် နေတယ်။	null		\N	vmod				\N	1
1935	Tiada kereta di halaman rumah. Rasanya ibu saya sudah keluar.	ခြံထဲမှာကားမရှိဘူး။ အမေ အပြင်ထွက်သွားတယ်ထင်တယ်။	null		\N	vmod				\N	1
3185	Saya bangun pagi dan membasuh muka. 	မနက် အိပ်ရာထ ပြီးတော့ မျက်နှာသစ်တယ်။	\N		\N	vmod				143	1
3232	Saya membasuh badan di bilik mandi.	ရေချိုးခန်းမှာ ကိုယ်လက် သန့်စင်တယ်။	\N		\N	vmod				36	1
3068	Ujian semalam sangat susah.	မနေ့က စာမေးပွဲက အရမ်းခက်တယ်။	\N		\N	vmod				421	1
2858	Ada ujian kanji setiap hari di sekolah.	ကျောင်းမှာ နေ့တိုင်း ခန်းဂျီး စာမေးပွဲ ရှိတယ်။	\N		\N	vmod				421	1
3676	Langit di bahagian timur kelihatan mendung.	အရှေ့ဘက် ကောင်းကင်မှာ တိမ်ထူ နေတယ်။	\N		\N	vmod				355	1
3677	Langit luas.	ကောင်းကင်ကြီးက ကျယ်တယ်။	\N		\N	vmod				355	1
3236	Encik Kobayashi mempunyai payung biru.	မစ္စတာ ခိုဘယရှိ က အပြာရောင်ထီးကို ကိုင်ထားတယ်။/မစ္စတာ ခိုဘယရှိ ဆီမှာ အပြာရောင်ထီး ရှိတယ်။	\N		\N	vmod				4	1
1592	Langit berwarna biru.	မိုးကောင်းကင်က ပြာတယ်။	null		\N	vmod				\N	1
3511	Pembelajaran bahasa Jepun seronok.	ဂျပန်စာလေ့လာရတာ ပျော်တယ်။	\N		\N	vmod				376	1
3510	Majlis semalam sangat seronok.	မနေ့က ပါတီမှာ အရမ်း ပျော်ခဲ့တယ်။/မနေ့က ပါတီက အရမ်း ပျော်ဖို့ကောင်းတယ်။	\N		\N	vmod				376	1
1862	Bagi saya, kelas saya seronok.	ကျွန်မ(/ကျွန်တော်) အတန်းတက်ရတာ ပျော်တယ်။	null		\N	vmod				\N	1
2933	Oleh sebab kaki sakit, saya tidak boleh berlari lagi.	ခြေထောက်နာလို့ မပြေးနိုင်တော့ဘူး။	\N		\N	vmod				517	1
1990	Saya lihat Encik Tanaka berlari.	မစ္စတာ တာနာခါ ပြေးနေတာကို မြင်လိုက်တယ်။	null		\N	vmod				\N	1
3880	Saya tunjukkan gambar melancong kepada Cik Kimura.	မစ္စတာ ခိမုရ ကို ခရီးသွားတုန်းကဓာတ်ပုံ ပြလိုက်တယ်။	\N		\N	vmod				297	1
2181	Apabila saya datang ke Jepun, saya mengambil gambar di lapangan terbang. 	ဂျပန်ကိုလာတုန်းက လေယာဉ်ကွင်းမှာ ဓာတ်ပုံ ရိုက်ခဲ့တယ်။	null		\N	vmod				\N	1
2839	Saya tidak berjalan kaki ke sekolah tetapi naik bas.	ကျောင်းအထိ လမ်းမလျှောက်ဘဲ ဘတ်စ်ကားစီးတယ်။	\N		\N	vmod				504	1
3267	Emak Encik Yamada sangat pandai memasak.	မစ္စတာ ရာမဒ ရဲ့ အမေက ဟင်းချက် အရမ်းတော်တယ်။	\N		\N	vmod				97	1
3190	Saya tidak boleh memakai seluar ini kerana saiznya kecil.	ဒီ ဘောင်းဘီက ကျွန်မ(/ကျွန်တော်)နဲ့ သေးနေလို့၊ ဝတ်လို့မရဘူး။	\N		\N	vmod				326	1
3558	Saya makan nasi tiga kali setiap hari.	နေ့တိုင်း ထမင်း သုံးခါစားတယ်။	\N		\N	vmod				134	1
3559	Saya pergi ke luar negara setiap tahun sekali.	တစ်နှစ် တစ်ခါ နိုင်ငံခြား သွားတယ်။	\N		\N	vmod				134	1
3364	Bunga ini mekar pada musim bunga.	ဒီပန်းက နွေဦး ရောက်ရင် ပွင့်တယ်။	\N		\N	vmod				266	1
3363	Ada banyak bunga yang cantik sedang mekar di taman .	ပန်းခြံမှာ ပန်းလှလှလေးတွေ အများကြီး ပွင့်နေတယ်။	\N		\N	vmod				266	1
3317	Saya akan belajar gitar mulai dari tahun ini.	ကျွန်မ(/ကျွန်တော်) ဒီနှစ်ကစပြီး ဂီတာတီးသင်မယ်။	\N		\N	vmod				247	1
3108	Saya menerima kemeja daripada kawan pada hari jadi saya.	မွေးနေ့မှာ သူငယ်ချင်းဆီက ရှပ်အင်္ကျီ လက်ဆောင်ရတယ်။	\N		\N	vmod				298	1
3173	Saya tidak begitu suka menulis huruf.	စာ ရေးရတာ သိပ် မကြိုက်ဘူး။(စာ ရေးရတာ သိပ် ဝါသနာမပါဘူး။)	\N		\N	vmod				812	1
3174	Cik Matsui pandai menulis huruf.	မစ္စတာ မဆုအိ က လက်ရေးလက်သား ကောင်းတယ်။	\N		\N	vmod				812	1
3862	Semalam saya pergi ke karaoke tetapi saya tidak banyak menyanyi.	မနေ့က ကာရာအိုကေ သွားပေမယ့် သိပ် မဆိုဖြစ်ဘူး။	\N		\N	vmod				831	1
3863	Saya pergi ke karaoke sekali setiap minggu.	ကျွန်မ(/ကျွန်တော်) တစ်ပတ်တစ်ခါ ကာရာအိုကေ သွားတယ်။	\N		\N	vmod				831	1
3015	Saya selalu menyanyi lagu ini di karaoke.	ကာရာအိုကေသွားရင် အမြဲတမ်း ဒီသီချင်းဆိုတယ်။	\N		\N	vmod				75	1
3632	Kita bercakap dengan suara perlahan kerana sudah pukul dua belas malam.	ည ဆယ့်နှစ်နာရီ ရှိပြီ၊ အသံ တိုးတိုးပြော။	\N		\N	vmod				235	1
3633	Suara Encik Matsui kuat.	မစ္စတာ မဆုအိ က အသံ ကျယ်တယ်။	\N		\N	vmod				235	1
3257	Bilik saya terang kerana ada di bahagian selatan.	ကျွန်မ(/ကျွန်တော်) အခန်းက တောင်ဘက်မှာ ရှိလို့ အလင်းရောင်ကောင်းတယ်။	\N		\N	vmod				628	1
2934	Ada burung sedang terbang di langit sana. 	ဟိုဘက်က ကောင်းကင်မှာ ငှက်တွေပျံ နေတယ်။	\N		\N	vmod				456	1
1645	Ada pesawat terbang ke arah Selatan.	လေယာဉ်ပျံက တောင်ဘက်ကို ပျံသွားတယ်။	null		\N	vmod				\N	1
3688	Saya pergi membeli barang dengan kawan dan masuk ke kedai kopi.	သူငယ်ချင်းနဲ့ဈေးဝယ်ပြီး ကော်ဖီဆိုင် ဝင်ဖြစ်တယ်။	\N		\N	vmod				509	1
3689	Setiap hari saya mandi sebelum tidur.	အမြဲတမ်း မအိပ်ခင် ရေချိုးခန်း ဝင်တယ်။	\N		\N	vmod				509	1
3687	Adik perempuan saya akan masuk ke universiti tahun depan.	လာမယ့်နှစ်မှာ ကျွန်မ(/ကျွန်တော်) ညီမ(/နှမ) တက္ကသိုလ် တက်မယ်။	\N		\N	vmod				509	1
1668	Saya pergi ke sekolah dengan bas.	ဘတ်စ်ကားနဲ့ ကျောင်းသွားတယ်။	null		\N	vmod				\N	1
1671	Saya tidak hadir ke sekolah kerana sakit.	နေမကောင်းလို့ ကျောင်းမသွားဘူး။	null		\N	vmod				\N	1
2019	Hari ini tiada kelas kerana cikgu sakit.	မနေ့က ဆရာ နေမကောင်းလို့ အတန်း မရှိဘူး။	null		\N	vmod				\N	1
3552	Encik Lee tinggal di Jepun seorang diri.	မစ္စတာ လီ ဂျပန်မှာ တစ်ယောက်တည်း နေတယ်။	\N		\N	vmod				548	1
3553	Ada seorang pelajar di dalam bilik darjah.	စာသင်ခန်းမှာ ကျောင်းသားတစ်ယောက် ရှိတယ်။	\N		\N	vmod				548	1
3897	Keluarga saya lima orang.	ကျွန်မ(/ကျွန်တော်) မှာ မိသားစု ငါးယောက် ရှိတယ်။	\N		\N	vmod				154	1
2925	Saya belajar dengan adik lelaki saya sebab dia pandai bermain bola sepak.	မောင်လေး(/ညီလေး) က ဘောလုံး ကစားတာတော်လို့ သူ့ဆီကသင်ထားတာ။	\N		\N	vmod				304	1
2926	Encik Matsui pandai memasak.	မစ္စတာ မဆုအိ က ဟင်းချက်တော်တယ်။	\N		\N	vmod				304	1
3896	Kot ini berharga sepuluh ribu yen.	ဒီ ကုတ်အင်္ကျီက တစ်သောင်း ပါ။	\N		\N	vmod				615	1
2842	Saya sekelas dengan Matsui.	ကျွန်မ(/ကျွန်တော်)နဲ့ မစ္စတာ မဆုအိ နဲ့က အတန်းအတူတူပဲ။	\N		\N	vmod				214	1
1682	Kami sekelas pergi jalan-jalan.	အတန်းကလူတွေနဲ့ ခရီးသွားခဲ့တယ်။	null		\N	vmod				\N	1
1683	Saya akan membuat kerja itu sendiri. 	အဲဒီအလုပ်ကိုတော့ ကိုယ့်ဟာကိုယ် လုပ်မယ်။	null		\N	vmod				\N	1
3375	Bahasa di Jepun berbeza dengan luar negara.	ဂျပန်နဲ့ နိုင်ငံခြား က ဘာသာစကား ကွဲပြားတယ်။	\N		\N	vmod				390	1
1693	Buku nota ini berbeza daripada buku nota saya.	ဒီ မှတ်စုစာအုပ် က ကျွန်မ(/ကျွန်တော်) မှတ်စုစာအုပ် နဲ့ မတူဘူး။	null		\N	vmod				\N	1
2189	Semasa masih muda lagi, saya sering berenang. 	ငယ်ငယ်တုန်းကဆို ခဏခဏ ရေကူးတယ်။	null		\N	vmod				\N	1
2187	Saya menelefon semasa saya berada di bilik.	အခန်းမှာရှိတုန်းက ဖုန်းဆက်တယ်။	null		\N	vmod				\N	1
2180	Apabila saya datang ke Jepun, saya mengambil gambar di lapangan terbang. 	ဂျပန်ကိုလာတုန်းက လေယာဉ်ကွင်းမှာ ဓာတ်ပုံ ရိုက်ခဲ့တယ်။	null		\N	vmod				\N	1
2178	Semasa saya sedang makan malam, kawan datang ke rumah.	ကျွန်မ(/ကျွန်တော်) ညစာစားနေတုန်း သူငယ်ချင်းက အိမ်ကို ရောက်လာတယ်။	null		\N	vmod				\N	1
2880	Saya tengok peta kerana saya tidak tahu jalan.	လမ်းမသိလို့ မြေပုံကို ကြည့်တယ်။	\N		\N	vmod				393	1
3243	Saya lebih suka warna biru daripada warna merah.	ကျွန်မ(/ကျွန်တော်) အနီထက် အပြာကိုပို ကြိုက်တယ်။	\N		\N	vmod				5	1
3229	Sebelum makan nasi, saya membasuh tangan.	ထမင်းမစားခင် လက်ဆေးတယ်။	\N		\N	vmod				412	1
2803	Saya terlupa nama orang itu.	အဲဒီလူရဲ့ နာမည် ကို မေ့သွားတယ်။	\N		\N	vmod				479	1
1714	Sila tulis nama.	နာမည်ရေးပါ။	null		\N	vmod				\N	1
1965	Siapakah yang menulis karangan ini?  Karangan ini tiada nama.	ဒီ စာစီစာကုံးကို ရေးတဲ့သူက ဘယ်သူလဲ။ နာမည် တပ်မထားဘူး။	null		\N	vmod				\N	1
3391	Malam ini, saya akan menunggu Encik Kobayashi di stesen.	ဒီည ကျွန်မ(/ကျွန်တော်) ဘူတာမှာ မစ္စတာ ခိုဘယရှိကို စောင့်မယ်။	\N		\N	vmod				610	1
3390	Saya sedang menunggu bas.	ကျွန်မ(/ကျွန်တော်) ဘတ်စ်ကား စောင့်နေတယ်။	\N		\N	vmod				610	1
2982	Jangan merokok di dalam bilik ini.	ဒီအခန်းမှာ ဆေးလိပ် သောက်လို့မရဘူး။	\N		\N	vmod				378	1
2229	Saya sudah berhenti merokok.	ဆေးလိပ် ဖျက်လိုက်ပြီ။	null		\N	vmod				\N	1
3907	Bilik ini tidak boleh masuk.	ဒီအခန်း ထဲကို ဝင်လို့ မဖြစ်ဘူး။	\N		\N	vmod				841	1
3861	Saya menghidupkan suis televisyen.	တီဗွီ ခလုတ်ကို ဖွင့်မယ်။	\N		\N	vmod				834	1
1748	Kami sedang menggunakan komputer. Tolong jangan matikan suis.	ကွန်ပျူတာ သုံးနေတယ်။ ခလုတ် မပိတ်လိုက်ပါနဲ့။	null		\N	vmod				\N	1
3458	Sekarang pukul tujuh malam.	အခု ည ခုနစ်နာရီပါ။	\N		\N	vmod				239	1
3040	Tadi hujan turun pada waktu pagi, tetapi sekarang cerah. 	မနက်က မိုးရွာပေမယ့် အခု နေသာ နေတယ်။	\N		\N	vmod				531	1
1768	Apa kata kita bermain tenis pada petang hari Sabtu? 	စနေနေ့ ညနေပိုင်း(/နေ့လယ်ပိုင်း/နေ့လယ်ဆယ့်နှစ်နာရီနောက်ပိုင်း)မှာ တင်းနစ် ကစားရအောင်။	null		\N	vmod				\N	1
3244	Warna yang saya suka adalah biru.	ကျွန်မ(/ကျွန်တော်) ကြိုက်တဲ့ အရောင်က အပြာ ပါ။	\N		\N	vmod				3	1
3770	Entahlah, saya kurang faham.	ဘယ်လိုပြောရမလဲ၊ သိပ်နားမလည်ဘူး။	\N		\N	vmod				261	1
3771	Baiklah, kita akan mulakan kelas.	ကဲ၊ အတန်းစလိုက်ကြစို့။	\N		\N	vmod				261	1
2920	Mari kita seberang jalan dan jalan di sebelah kiri.	လမ်းကူးပြီး ဘယ်ဘက်ခြမ်းကနေ လျှောက်ရအောင်။	\N		\N	vmod				701	1
2921	Saya akan lintas jambatan untuk ke seberang sungai. 	ချောင်း ဟိုဘက်ကို သွားချင်လို့ တံတားကို ကူးမယ်။	\N		\N	vmod				701	1
1810	Saya nak membersihkan rumah selepas balik.	အိမ်ပြန်ရင် သန့်ရှင်းရေးလုပ်မယ်လို့ စိတ်ကူးထားတယ်။	null		\N	vmod				\N	1
2100	Encik Kimura tolong saya membawa bagasi. 	မစ္စတာ ခိမုရ က ကျွန်မ(/ကျွန်တော်)ရဲ့ အထုပ် ကို ကူသယ်ပေးတယ်။	null		\N	vmod				\N	1
2179	Kita bawa pasport apabila ingin ke luar negara.	နိုင်ငံခြားသွားတဲ့အခါ ပတ်စပို့ကို ယူသွားတယ်။	null		\N	vmod				\N	1
2249	Sesiapa yang tidak bawa pen mata bulat, boleh menggunakan pensel.	ဘောပင်ပါမလာတဲ့လူတွေ ခဲတံနဲ့(ဆို)လည်း ရတယ်။	null		\N	vmod				\N	1
1794	Biar saya tolong bawa bagasi itu.	အဲဒီ အထုပ်ကို ကျွန်မ(/ကျွန်တော်) သယ်ပေးမယ်။	null		\N	vmod				\N	1
3260	Kalau pergi ke arah barat sedikit dari sini, ada laut.	ဒီကနေ အနောက်ဘက်ကို နည်းနည်း သွားရင် ပင်လယ် ရှိတယ်။	\N		\N	vmod				487	1
3529	Saya akan bangun awal esok pagi.	မနက်ဖန် မနက် စောစောထမယ်။	\N		\N	vmod				528	1
3528	Hari ini saya akan keluar waktu lebih awal dari rumah	ဒီနေ့ အိမ်ကနေ စောစော ထွက်မယ်။	\N		\N	vmod				528	1
3444	Malam ini kawan akan bermalam di rumah saya.	ဒီည သူငယ်ချင်း အိမ်မှာ လာတည်းမယ်။	\N		\N	vmod				260	1
3445	Malam ini sangat sejuk.	ဒီည အရမ်း အေးတယ်။	\N		\N	vmod				260	1
1813	Malam ini saya tidak ingin ke mana-mana.	ဒီည ဘယ်မှ မသွားချင်ဘူး။	null		\N	vmod				\N	1
3826	Kita semua menyanyi lagu bersama-sama.	အားလုံးအတူတူ သီချင်းဆိုမယ်။	\N		\N	vmod				631	1
3827	Semua orang sedang menunggu guru di dalam bilik darjah.	အားလုံး စာသင်ခန်းထဲမှာ ဆရာ့ကို စောင့်နေတယ်။	\N		\N	vmod				631	1
3828	Kami semua pelajar universiti ini.	အားလုံး ဒီတက္ကသိုလ်ကကျောင်းသားတွေပါ။	\N		\N	vmod				631	1
2914	Saya akan pergi menaiki basikal walaupun hujan.	မိုးရွာလည်း စက်ဘီးနဲ့ သွားတယ်။	\N		\N	vmod				289	1
2913	Saya membonceng di bahagian belakang basikal kawan saya.	သူငယ်ချင်းရဲ့ စက်ဘီးနောက်ကနေ လိုက်စီးတယ်။	\N		\N	vmod				289	1
2041	Lebih mudah menggunakan basikal kalau pergi ke universiti itu. 	အဲဒီ တက္ကသိုလ်ကို သွားမယ်ဆိုရင် စက်ဘီးက အဆင်ပြေတယ်။	null		\N	vmod				\N	1
3239	Kereta Encik Tanaka putih dan besar.	မစ္စတာ တာနာခါ ရဲ့ ကားက အဖြူရောင် ခပ်ကြီးကြီးကားပါ။	\N		\N	vmod				310	1
3237	Saya beli kasut putih di pusat membeli-belah semalam.	မနေ့က ကုန်တိုက်မှာ အဖြူရောင်ဖိနပ်တစ်ရံ ဝယ်ခဲ့တယ်။	\N		\N	vmod				310	1
3649	Ada  kertas dan pensel di atas meja.	စာရေးခုံ(/စာကြည့်စားပွဲ)ပေါ်မှာ စက္ကူ(/စာရွက်) နဲ့ ခဲတံ ရှိတယ်။	\N		\N	vmod				165	1
3648	Saya menulis jawapan kepada soalan pada kertas ini.	ဒီ စာရွက်ပေါ်မှာ မေးခွန်းရဲ့ အဖြေကို ရေးမယ်။	\N		\N	vmod				165	1
3119	Sukan yang saya paling suka adalah besbol.	အားကစားဆို ဘေ့စ်ဘော ကို အကြိုက်ဆုံး ပဲ။	\N		\N	vmod				325	1
1849	Saya tidak suka bersukan.	ကျွန်မ(/ကျွန်တော်) အားကစား ဝါသနာမပါဘူး။	null		\N	vmod				\N	1
3702	Encik Tanaka selalu kelihatan sibuk.	မစ္စတာ တာနာခါ က အမြဲတမ်း အလုပ်များတဲ့ပုံပဲ။	\N		\N	vmod				60	1
3703	Saya selalu membeli barang di pasar raya ini	ကျွန်မ(/ကျွန်တော်) အမြဲတမ်း ဒီ စူပါမားကက်မှာ ဈေးဝယ်တယ်။	\N		\N	vmod				60	1
3583	Rak buku ini lebarnya 1 meter dan panjangnya 1.5 meter. 	ဒီ စာအုပ်စင်က အနံ တစ်မီတာ အလျား တစ်မီတာခွဲ ရှိတယ်။	\N		\N	vmod				638	1
3584	Encik Yamada boleh berenang sepanjang seratus meter.	မစ္စတာ ရာမဒ က မီတာတစ်ရာ ရေကူးနိုင်တယ်။	\N		\N	vmod				638	1
3182	Belajar bahasa asing susah.	နိုင်ငံခြားဘာသာကိုလေ့လာရတာ ခက်တယ်။	\N		\N	vmod				230	1
3486	Majalah ini tebal dan berat.	ဒီ မဂ္ဂဇင်းက ထူပြီး လေးတယ်။	\N		\N	vmod				23	1
3183	Saya membaca buku yang ditulis dalam bahasa Jepun.	ဂျပန်ဘာသာနဲ့ရေးထားတဲ့ စာအုပ်ကို ဖတ်တယ်။	\N		\N	vmod				230	1
3041	Esok kalau cerah, mari kita bermain tenis. 	မနက်ဖန် နေသာရင် တင်းနစ် ကစားကြမယ်။	\N		\N	vmod				531	1
3722	Orang yang ada di sana mungkin Encik Yamada.	အဲဒီမှာရှိတဲ့လူက မစ္စတာ ရာမဒ ဖြစ်လိမ့်မယ်။	\N		\N	vmod				731	1
3723	Encik Hayashi mungkin tahu tentang berita itu.	မစ္စတာ ဟယရှိ အဲဒီသတင်းကို သိလိမ့်မယ်။	\N		\N	vmod				731	1
3093	Saya pesan makanan kepada pekerja kedai. 	ဆိုင်ဝန်ထမ်း ကို အစားအသောက် မှာလိုက်တယ်။	\N		\N	vmod				774	1
3094	Perkerja restoran ini kelihatan sibuk.	ဒီ စားသောက်ဆိုင်က ဆိုင်ဝန်ထမ်း တွေ အလုပ်များတဲ့ပုံပဲ။	\N		\N	vmod				774	1
2900	Saya lihat jam di dalam bilik darjah kerana tidak tahu pukul berapa sekarang.	အချိန်မသိလို့ စာသင်ခန်းက နာရီကို ကြည့်လိုက်တယ်။	\N		\N	vmod				445	1
1919	Jam ini mesti mahal harganya.	ဒီ နာရီ ကျိန်းသေ ဈေးကြီးမှာ သေချာတယ်။	null		\N	vmod				\N	1
2079	Encik Yamada memberikan buku kepada adik perempuan saya.	မစ္စတာ ရာမဒ က ညီမလေးကို စာအုပ်ပေးတယ်။	null		\N	vmod				\N	1
2099	Saya tolong adik perempuan saya membuat kerja rumah. 	ကျွန်မ(/ကျွန်တော်) ညီမလေးရဲ့ အိမ်စာကို ကြည့်ပေးတယ်။	null		\N	vmod				\N	1
3199	Kuih ini manis.	ဒီမုန့် က ချိုတယ်။	\N		\N	vmod				33	1
3656	Burung sedang minum air.	ငှက်က ရေကို သောက်နေတယ်။	\N		\N	vmod				460	1
3657	Ada burung di atas pokok sana.	ဟိုကသစ်ပင်ပေါ်မှာ ငှက်ရှိတယ်။	\N		\N	vmod				460	1
3287	Saya dengar Encik Yamada akan pergi ke Tokyo bulan depan.	မစ္စတာ ရာမဒ နောက်လမှာ တိုကျိုကို သွားမယ်ထင်တယ်။	\N		\N	vmod				675	1
1942	Saya dengar ada pelajar baru akan datang bulan depan.	လာမယ့်လကစပြီး တပည့် အသစ် လာမယ့်ပုံပဲ။	null		\N	vmod				\N	1
2847	Budak-budak yang ada di sini adalah pelajar dari sekolah yang sama.	ဒီမှာရှိတဲ့ ကလေးတွေအားလုံး တစ်ကျောင်းတည်းက တပည့်တွေ ပဲ။	\N		\N	vmod				332	1
2848	Semasa kelas, guru bertanyakan soalan kepada pelajar.	စာသင်ချိန်အတွင်း ဆရာက တပည့်ကို မေးခွန်းမေးတယ်။	\N		\N	vmod				332	1
3023	Cuaca esok adalah hujan.	မနက်ဖန်ရဲ့ ရာသီဥတုအခြေအနေကတော့ မိုးရွာ ပါမယ်။	\N		\N	vmod				427	1
3024	Cuaca hari ini sangat baik.	ဒီနေ့ ရာသီဥတု အရမ်း သာယာတယ်။	\N		\N	vmod				427	1
3017	Saya ambil banyak gambar semasa melancong.	ခရီးသွားတုန်းက ဓာတ်ပုံတွေ အများကြီး ရိုက်ခဲ့တယ်။	\N		\N	vmod				462	1
2855	Esok saya akan hantar karangan kepada guru.	မနက်ဖန် ဆရာ့ဆီ စာစီစာကုံး ထပ်မယ်။	\N		\N	vmod				267	1
2854	Saya telah membaca karangan yang ditulis Encik Matsui.	ကျွန်မ(/ကျွန်တော်) မစ္စတာ ရာမဒ ရေးတဲ့ စာစီစာကုံး ကို ဖတ်တယ်။	\N		\N	vmod				267	1
2820	Saya minum kopi setiap pagi.	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း ကော်ဖီသောက်တယ်။	\N		\N	vmod				237	1
2821	Saya lebih suka teh daripada kopi.	ကျွန်မ(/ကျွန်တော်) ကော်ဖီထက် လက်ဖက်ရည် ကို ပိုကြိုက်တယ်။	\N		\N	vmod				233	1
3007	Kamera ini mahal tetapi berguna.	ဒီ ကင်မရာ က ဈေးကြီးပေမယ့် အဆင်ပြေတယ်။	\N		\N	vmod				166	1
3008	Saya beli kamera baru.	ကင်မရာ အသစ် ဝယ်လိုက်တယ်။	\N		\N	vmod				166	1
3143	Saya hafal nombor yang tertulis di atas kertas.	စာရွက် မှာရေးထားတဲ့ နံပါတ်ကို မှတ်တယ်။	\N		\N	vmod				536	1
2840	Saya tidak boleh membeli barang kerana pasar raya sudah tutup.	စူပါမားကက် ပိတ်ထားလို့ ဈေးမဝယ်ခဲ့ရဘူး။	\N		\N	vmod				294	1
2841	Beg tidak tutup.	အိတ်က ပိတ် မနေဘူး။ (အိတ်ကို ပိတ်မထားဘူး။/အိတ်ပွင့်နေတယ်။)	\N		\N	vmod				294	1
3349	Saya tidak ingat tentang orang itu.	ကျွန်မ(/ကျွန်တော်) အဲဒီလူရဲ့ အကြောင်းကို မမှတ်မိဘူး။	\N		\N	vmod				124	1
3350	Saya hafal bahasa Jepun dengan menonton TV setiap hari 	နေ့တိုင်း တီဗွီကြည့်ပြီး ဂျပန်စာကို မှတ်တယ်။	\N		\N	vmod				124	1
2764	Oleh sebab perut sakit, saya pergi ke hospital.	ဗိုက်နာလို့ ဆေးရုံ သွားတယ်။	\N		\N	vmod				117	1
3453	Walaupun sudah pukul dua belas tengah malam, saya akan belajar.	ည ဆယ့်နှစ်နာရီပေမယ့် စာဖတ်မယ်။	\N		\N	vmod				673	1
3452	Pasar raya sana buka pada waktu malam juga.	အဲဒီက စူပါမားကက်က ညလည်း ဖွင့်တယ်။	\N		\N	vmod				673	1
3839	Mari kita berehat sebentar dekat sini.	ဒီအနားတဝိုက်မှာ နည်းနည်း(/ခဏ) နားရအောင်။	\N		\N	vmod				578	1
3840	Rumah Hayashi ada dekat sana.	အဲဒီအနားတဝိုက်မှာ မစ္စတာ ဟယရှိရဲ့အိမ် ရှိတယ်။	\N		\N	vmod				578	1
3348	Kalau tekan sini, kopi akan keluar.	ဒီနေရာကို နှိပ်ရင် ကော်ဖီထွက်တယ်။	\N		\N	vmod				106	1
2798	Masukkan wang, kemudian tekan butang.	ပိုက်ဆံထည့်ပြီး ခလုတ်ကို နှိပ်တယ်။	\N		\N	vmod				106	1
3712	Saya akan terus mula bekerja setelah tamat pengajian di universiti.	တက္ကသိုလ် ပြီးရင် ချက်ချင်း အလုပ်လုပ်မယ်။	\N		\N	vmod				318	1
3713	Isteri saya akan pulang sekejap lagi.	အမျိုးသမီးက ချက်ချင်း ပြန်လာတယ်။	\N		\N	vmod				318	1
2782	Rumah baru saya sangat selesa kerana dekat dengan stesen.	အိမ်အသစ်က ဘူတာနဲ့နီးလို့ အရမ်းအဆင်ပြေတယ်။	\N		\N	vmod				389	1
2055	Mari kita berjalan kaki jika dekat.	နီးတယ်ဆိုရင် ခြေလျင်လျှောက်မယ်လေ။	null		\N	vmod				\N	1
3515	Saya tidak suka kerja pembersihan dan mencuci pakaian.	ကျွန်မ(/ကျွန်တော်) သန့်ရှင်းရေးတို့ အဝတ်လျှော်တာတို့ကို လုပ်ရတာ မုန်းတယ်(/မကြိုက်ဘူး)။	\N		\N	vmod				65	1
3514	Saya terdengar cerita yang tidak sedap semalam.	မနေ့က မကြားချင်တဲ့ စကားကို ကြားရတယ်။	\N		\N	vmod				65	1
2056	Tak buat pun boleh kalau tidak suka.	မကြိုက်ရင်(/မလုပ်ချင်ရင်) မလုပ်လည်း ရတယ်။	null		\N	vmod				\N	1
3812	Saya memasukkan banyak susu ke dalam kopi.	ကျွန်မ(/ကျွန်တော်) ကော်ဖီထဲကို နို့အများကြီး ထည့်တယ်။	\N		\N	vmod				368	1
3813	Saya telah banyak berjalan kaki pada hari ini.	မနေ့က လမ်းအများကြီး လျှောက်ခဲ့တယ်။	\N		\N	vmod				368	1
3386	Saya beri peta bandar ini kepada Cik Kimura semalam. 	မနေ့က မစ္စတာ ခိမုရ ကို ဒီမြို့ရဲ့မြေပုံ ပေးလိုက်တယ်။	\N		\N	vmod				700	1
3297	Jangan pergi ke sana kerana berbahaya.	အန္တရာယ်ရှိလို့ အဲဒီကို မသွားပါနဲ့။	\N		\N	vmod				350	1
3298	Itu Encik Lee.	အဲဒီဘက်က(/သူက) မစ္စတာ လီ ပါ။	\N		\N	vmod				350	1
2120	Saya akan beli minuman dan bawa ketika pergi ke sana pada minggu depan.	နောက်အပတ် အဲဒီကိုသွားရင် သောက်စရာတစ်ခုခု ဝယ်သွားမယ်။	null		\N	vmod				\N	1
3459	Saya ada masa lapang pagi ini, jadi saya membaca surat khabar, kemudian keluar dari rumah.	မနက်က အချိန်ရလို့ သတင်းစာဖတ်ပြီးမှ အိမ်က ထွက်တယ်။	\N		\N	vmod				282	1
3460	Saya tidak ada masa bermain kerana sibuk bekerja.	အလုပ်များလို့ ကစားဖို့(/လျှောက်လည်ဖို့) အချိန်မရဘူး။	\N		\N	vmod				282	1
3615	Semalam saya dengar berita yang menarik daripada kawan saya.	မနေ့က သူငယ်ချင်းဆီက စိတ်ဝင်စားဖို့ကောင်းတဲ့ သတင်းတစ်ခု ကြားခဲ့တယ်။	\N		\N	vmod				491	1
3616	Saya lihat berita di TV pagi tadi.	မနက်က တီဗွီသတင်း ကြည့်ခဲ့တယ်။	\N		\N	vmod				491	1
3217	Makan malam hari ini adalah kari.	မနေ့တုန်းက ညစာက ကာရီ(/ထမင်းဖြူနဲ့မဆလာဟင်း) ပါ။	\N		\N	vmod				659	1
2123	Hari ini saya makan malam bersama kawan saya.	ဒီနေ့ သူငယ်ချင်းနဲ့  ညစာစားလာတယ်။	null		\N	vmod				\N	1
3346	Ini makanan yang tidak dijual di Jepun.	ဒါ ဂျပန်မှာ မရောင်းတဲ့ စားစရာ။	\N		\N	vmod				79	1
3344	Kedai itu menjual kuih-muih yang sedap.	ဟိုဆိုင်မှာ စားလို့ကောင်းတဲ့ မုန့်တွေ ရောင်းတယ်။	\N		\N	vmod				79	1
3164	Saya pakai sut semasa pergi ke syarikat.	ကုမ္ပဏီသွားတဲ့အခါ အနောက်တိုင်းဝတ်စုံဝတ်တယ်။	\N		\N	vmod				705	1
1481	Encik Kobayashi pakai kemeja biru.	မစ္စတာ ခိုဘယရှိ က အပြာရောင် ရှပ်အင်္ကျီကို ဝတ်ထားတယ်။	null		\N	vmod				\N	1
3415	Hari jadi ibu pada minggu lepas.	ရှေ့အပတ်(/ပြီးခဲ့တဲ့အပတ်)တုန်းက အမေ့မွေးနေ့။	\N		\N	vmod				340	1
2158	Saya seorang pelajar tetapi abang saya pula pekerja syarikat. 	ကျွန်မ(/ကျွန်တော်)က ကျောင်းသားပေမယ့် အစ်ကိုကတော့ ကုမ္ပဏီ ဝန်ထမ်း ပါ။	null		\N	vmod				\N	1
3373	Encik Hayashi meminta Encik Tanaka membantunya bekerja.	မစ္စတာ ဟယရှိက မစ္စတာ တာနာခါကို အလုပ်လုပ်ပေးဖို့ တောင်းဆိုတယ်။	\N		\N	vmod				377	1
3374	Ibu saya selalu meminta saya membeli barang.	အမေ အမြဲတမ်း ကျွန်မ(/ကျွန်တော်)ကို ဈေးဝယ်ခိုင်းတယ်။	\N		\N	vmod				377	1
3294	Bangunan itu telah dibina pada tahun 794.	ဟိုဘက်က အဆောက်အအုံက ခုနှစ်ရာကိုးဆယ့်လေးနှစ်က ဆောက်ထားတာ။	\N		\N	vmod				22	1
3295	Itu Encik Yamada.	ဟိုဘက်က မစ္စတာ ရာမဒ ပါ။	\N		\N	vmod				22	1
3764	Encik Yamada ingin makan yang mana?	မစ္စတာ ရာမဒ ဘယ်ဟာ စားချင်ပါသလဲ။/မစ္စတာ ရာမဒ က ဘယ်ဟာ စားချင်တာလဲ။	\N		\N	vmod				450	1
3765	Di manakah negara awak?	ဘယ် နိုင်ငံ က ပါလဲ။	\N		\N	vmod				450	1
3454	Ayah bekerja dari pagi sehingga malam setiap hari.	အဖေ နေ့တိုင်း မနက်ကနေ ညအထိ အလုပ်လုပ်တယ်။	\N		\N	vmod				708	1
3455	Malam semalam saya belajar sehingga lewat malam.	မနေ့ညက နောက်ကျတဲ့အထိ(/အတော်မိုးချုပ်တဲ့အထိ) စာဖတ်တယ်။	\N		\N	vmod				708	1
3476	Malam berbahaya kerana gelap.	ညဘက်က မှောင်တော့ အန္တရာယ်များတယ်။	\N		\N	vmod				7	1
2206	Mata akan menjadi rabun kalau membaca buku di tempat gelap.	မှောင်တဲ့နေရာမှာ(/အမှောင်ထဲမှာ) စာဖတ်ရင် မျက်စိပျက်တတ်တယ်။	null		\N	vmod				\N	1
2899	Oleh sebab semalam penat, saya terus tidur.	မနေ့က ပင်ပန်းနေလို့ ချက်ချင်း အိပ်ပျော်သွားတယ်။	\N		\N	vmod				498	1
1389	Saya akan tidur pada pukul sebelas.	ဆယ့်တစ်နာရီမှာ အိပ်တယ်။	null		\N	vmod				\N	1
2213	Apa kata kita minum teh? 	လက်ဖက်ရည်လေးဘာလေး  မသောက်တော့ဘူးလား။	null		\N	vmod				\N	1
2247	Bagaimana dengan teh?	လက်ဘက်ရည်တို့ဘာတို့ သောက်ဦးမလား။	null		\N	vmod				\N	1
3893	Sepuluh hari bulan Oktober adalah hari jadi abang saya.	ဆယ်လ ဆယ်ရက် က အဖေ့ မွေးနေ့ ပါ။	\N		\N	vmod				300	1
3479	Teh ini panas.	ဒီ လက်ဖက်ရည်က ပူတယ်။	\N		\N	vmod				706	1
3480	Saya ingin minum teh yang panas.	ရေနွေးကြမ်း ပူပူလေး သောက်ချင်တယ်။	\N		\N	vmod				706	1
3762	Siapakah Encik Kobayashi?	မစ္စတာ ခိုဘယရှိ ဆိုတာ ဘယ်သူပါလဲ။	\N		\N	vmod				453	1
3763	Siapakah cikgu yang baru?	ဆရာ အသစ်က ဘယ်သူပါလဲ။	\N		\N	vmod				453	1
1322	Saya membeli sepuluh keping setem dan tiga keping poskad.	တံဆိပ်ခေါင်း ဆယ်ခု နဲ့ ပို့စကတ် သုံးခု ဝယ်မယ်။	null		\N	vmod				\N	1
2791	Saya hantar poskad kepada Encik Matsui.	မစ္စတာ မဆုအိ ဆီကို ပို့စကတ် ပို့မယ်။	\N		\N	vmod				510	1
3456	Esok saya akan ada di sekolah pada sebelah pagi.	မနက်ဖန် မနက်ပိုင်း ကျောင်းမှာ ရှိမယ်။	\N		\N	vmod				242	1
3457	Sekarang pukul tujuh pagi.	အခု မနက် ခုနစ်နာရီ ပါ။	\N		\N	vmod				242	1
3215	Kari ini sangat pedas.	ဒီ ကာရီဟင်းက အရမ်းစပ်တယ်။	\N		\N	vmod				168	1
1408	Makanan Jepun pedas?	ဂျပန်က ဟင်းတွေက စပ်သလား။	null		\N	vmod				\N	1
1409	Tidak, tidak pedas.	ဟင့်အင်း၊မစပ်ပါဘူး။	null		\N	vmod				\N	1
3383	Saya tertinggal payung di dalam kereta api semalam.	မနေ့က ရထားပေါ်မှာ ထီးမေ့ကျန်ခဲ့တယ်။	\N		\N	vmod				697	1
3382	Saya tidak akan lupa untuk pulangkan buku esok. 	မနက်ဖန် မမေ့မလျော့ စာအုပ်ပြန်ပေးမယ်။	\N		\N	vmod				697	1
1473	Jangan lupa tentang kerja rumah. 	အိမ်စာလုပ်ဖို့ မမေ့ပါစေနဲ့။(အိမ်စာလုပ်ဖို့ မမေ့နဲ့နော်။)	null		\N	vmod				\N	1
2800	Saya naik bas nombor sepuluh dari stesen.	ဘူတာကနေ နံပါတ်ဆယ်ငါးဘတ်စ်ကား စီးမယ်။	\N		\N	vmod				533	1
1647	Orang nombor satu sampai nombor sepuluh, sila masuk. 	နံပါတ်တစ် ကနေ နံပါတ်တစ်ဆယ်ထိ လူတွေ ဝင်ကြပါ(/ဝင်လို့ရပါပြီ)။	null		\N	vmod				\N	1
3279	Arak boleh diminum setelah menjadi dewasa.	လူကြီး ဖြစ်ရင်(/အရွယ်ရောက်ရင်) အရက် သောက်လို့ ရတယ်။	\N		\N	vmod				116	1
3064	Saya tulis jawapan di sini.	ဒီမှာ အဖြေ ရေးမယ်။	\N		\N	vmod				766	1
1971	Sila hantar kertas yang sudah ditulis dengan jawapan.	အဖြေ ရေးပြီးတဲ့ စာရွက်ကို တင်(/ထပ်)လိုက်ပါ။	null		\N	vmod				\N	1
3311	Baru sahaja saya memotong rambut bulan lepas tetapi rambut sudah panjang.	ရှေ့လကမှ ဆံပင်ညှပ်ထားတာ ပြန်ရှည်လာပြန်ပြီ။	\N		\N	vmod				339	1
3300	Saya melancong ke luar negara pada bulan lepas.	ရှေ့လက နိုင်ငံခြားကို ခရီးထွက်ခဲ့တယ်။	\N		\N	vmod				339	1
3853	Sebuah restoran baru dibuka berhampiran stesen.	ဘူတာနားမှာ စားသောက်ဆိုင်သစ်တစ်ဆိုင် လာဖွင့်ထားတယ်။	\N		\N	vmod				689	1
2805	Hari ini saya akan makan malam di restoran.	ဒီနေ့ စားသောက်ဆိုင်မှာ ညစာ စားမယ်။	\N		\N	vmod				689	1
2987	Saya bekerja di syarikat kereta.	ကျွန်မ(/ကျွန်တော်) ကားကုမ္ပဏီမှာ အလုပ်လုပ်နေတယ်။	\N		\N	vmod				408	1
3189	Saya menanggalkan baju sejuk kerana panas.	ပူလို့ ဆွယ်တာ ချွတ်မယ်။	\N		\N	vmod				333	1
2958	Kawasan yang dekat dengan laut, ikannya sedap.	ပင်လယ်နဲ့ နီးတဲ့ နေရာက ငါးတွေက စားလို့ကောင်းတယ်။	\N		\N	vmod				264	1
3150	Saya kehilangan pasport saya di stesen.	ဘူတာမှာ ပတ်စပို့ ပျောက်သွားတယ်။	\N		\N	vmod				807	1
3151	Pasport diperlukan apabila pergi ke luar negara.	နိုင်ငံခြားသွားတဲ့အခါ ပတ်စပို့ လိုတယ်။	\N		\N	vmod				807	1
3226	Mata adik perempuan saya besar dan hidungnya tinggi.	ညီမလေးက မျက်လုံးပြူးပြီး နှာခေါင်းချွန်တယ်။	\N		\N	vmod				524	1
2774	Encik Matsui meminjamkan pensel kepada saya. 	မစ္စတာ မဆုအိက ခဲတံ ငှားပေးတယ်။	\N		\N	vmod				90	1
3385	Encik Lee faham bahasa Jepun.	မစ္စတာ လီ ဂျပန်စကား နားလည်တယ်။	\N		\N	vmod				696	1
3384	Saya bertanya kepada guru kerana ada soalan yang saya kurang faham.	နားမလည်တာရှိလို့ ဆရာ့ကို မေးမယ်။	\N		\N	vmod				696	1
3078	Saya risau kerana tidak ada apa-apa khabar daripada ibu.	အမေ့ဆီက အဆက်အသွယ်မလာလို့ စိတ်ပူခဲ့ရတယ်။	\N		\N	vmod				768	1
3079	Semalam saya mendengar khabar daripada Encik Matsui.	မနေ့က မစ္စတာ မဆုအိ ဆီက အဆက်အသွယ် ရတယ်။	\N		\N	vmod				768	1
3378	Saya mengambil apa-apa sahaja makanan yang disukai.	ဘာဖြစ်ဖြစ် ကြိုက်တဲ့ စားစရာ ကို ယူတယ်။	\N		\N	vmod				752	1
3379	Saya mengambil kicap dan berikan kepada Encik Lee.	မစ္စတာ လီ ကို ပဲငံပြာရည် ယူပေးလိုက်တယ်။	\N		\N	vmod				752	1
3879	Saya akan melancong ke luar negara selama dua minggu mulai minggu depan. 	နောက်အပတ်ကစပြီး နှစ်ပတ်ကြာ၊ နိုင်ငံခြားခရီး သွားမယ်။	\N		\N	vmod				301	1
3829	Encik Hayashi pernah bekerja selama satu tahun setengah di luar negara.	မစ္စတာ ဟယရှိ နိုင်ငံခြားမှာ တစ်နှစ်ခွဲ အလုပ်လုပ်ခဲ့တယ်။	\N		\N	vmod				532	1
3830	Saya mesti keluar dari rumah kerana sudah pukul tujuh setengah.	ခုနစ်နာရီတောင်ခွဲပြီ၊ အိမ်က မထွက်လို့ မဖြစ်တော့ဘူး။	\N		\N	vmod				532	1
3516	Ini makanan yang Kobayashi sangat suka.	ဒါ မစ္စတာခိုဘယရှိ ရဲ့ အကြိုက်ဆုံး အစားအစာ ပါ။	\N		\N	vmod				363	1
3517	Saya sangat suka binatang.	ကျွန်မ(/ကျွန်တော်) တိရစ္ဆာန် အရမ်းချစ်တယ်။	\N		\N	vmod				363	1
3795	Saya balik bersama dengan semua.	အားလုံး အတူတူ ပြန်ခဲ့တယ်။	\N		\N	vmod				58	1
3796	Saya belajar bersama Encik Yamada di perpustakaan. 	စာကြည့်တိုက်မှာ မစ္စတာရာမဒနဲ့ အတူတူ စာဖတ်မယ်။	\N		\N	vmod				58	1
3797	Marilah pergi melancong bersama saya.	ခရီး အတူတူ သွားကြမလား။	\N		\N	vmod				58	1
3098	Saya membeli beg ini dengan menggunakan kad kredit.	ဒီ လွယ်အိတ် အကြွေးဝယ်ကတ်(/ခရက်ဒစ်ကတ်) နဲ့ ဝယ်ထားတာ။	\N		\N	vmod				781	1
3099	Saya masukkan kad kredit ke dalam dompet.	ပိုက်ဆံအိတ်ထဲ အကြွေးဝယ်ကတ်(/ခရက်ဒစ်ကတ်)ကို ထည့်တယ်။	\N		\N	vmod				781	1
3729	Saya akan bermain bersama Encik Kobayashi lagi pada minggu depan.	ကျွန်မ(/ကျွန်တော်) နောက်အပတ် မစ္စတာ ခိုဘယရှိ နဲ့ ထပ်ပြီးလျှောက်လည်ဦးမယ်။	\N		\N	vmod				607	1
3728	Saya akan datang lagi nanti.	နောက်မှ ထပ်လာမယ်။	\N		\N	vmod				607	1
2562	Kalau begitu, jumpa lagi. 	ဒါပဲနော်၊ နောက်မှ တွေ့မယ်။			\N	vmod				\N	1
3704	Terima kasih atas segalanya.	အစစအရာရာ ကျေးဇူးတင်ပါတယ်။	\N		\N	vmod				70	1
3875	Guru itu adalah orang yang sangat baik.	အဲဒီ ဆရာက အလွန် ထူးချွန်တဲ့ ပုဂ္ဂိုလ် ပါ။	\N		\N	vmod				680	1
3876	Saya ingin menjadi orang dewasa yang baik.	ထူးချွန်တဲ့ လူ ဖြစ်ချင်တယ်။	\N		\N	vmod				680	1
3477	Saya belajar di tempat yang terang.	လင်းလင်းထိန်ထိန်ရှိတဲ့ နေရာမှာ စာဖတ်တယ်။	\N		\N	vmod				7	1
3478	Bilik darjah ini terang dan cantik.	ဒီ စာသင်ခန်းက အလင်းရောင်ကောင်းပြီး သန့်ရှင်းတယ်။	\N		\N	vmod				7	1
3332	Saya mengangkat tangan saya ke atas.	လက်ကို အပေါ်ကို မြှောက်တယ်။	\N		\N	vmod				11	1
3333	Saya mengangkat barang yang tidak diguna ke atas rak buku.	မသုံးတဲ့ ပစ္စည်းကို စာအုပ်စင်ပေါ် တင်မယ်။	\N		\N	vmod				11	1
3216	Saya selalu makan roti pada untuk sarapan.	မနက်စာဆို အမြဲတမ်း ပေါင်မုန့်ပဲစားတယ်။	\N		\N	vmod				13	1
3208	Saya tidak makan sarapan hari ini.	ဒီနေ့ မနက်စာ မစားခဲ့ဘူး။	\N		\N	vmod				13	1
3429	Saya ingin pergi berenang di laut pada lusa.	သန်ဘက်ခါ ပင်လယ်မှာ ရေသွားကူးမယ်လို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				14	1
3430	Lusa akan ada perlawanan besbol.	သန်ဘက်ခါ ဘေ့စ်ဘော ပြိုင်ပွဲ ရှိတယ်။	\N		\N	vmod				14	1
2851	Minggu depan saya akan pergi ke Tokyo bersama kawan dan bermain di sana.	နောက်အပတ် ကျွန်မ(/ကျွန်တော်) သူငယ်ချင်းနဲ့ တိုကျို သွားလည်မယ်။	\N		\N	vmod				18	1
2852	Oleh sebab sudah belajar sepanjang hari semalam, hari ini saya bermain.	မနေ့က တစ်နေ့လုံး စာဖတ်လိုက်လို့ ဒီနေ့တော့ ကစားမယ်။	\N		\N	vmod				18	1
3035	Cuaca akan mula panas apabila memasuki musim bunga.	နွေဦးရောက်ရင် နွေးလာမယ်။	\N		\N	vmod				19	1
3036	Saya pergi jalan-jalan kerana cuaca hari ini cukup panas.	ဒီနေ့ တော်တော် နွေးလို့ လမ်းလျှောက် ထွက်မယ်။	\N		\N	vmod				19	1
2763	Hari ini saya tidur awal kerana kepala saya sakit.	ခေါင်းကိုက်လို့ ဒီနေ့ စောစော အိပ်မယ်။	\N		\N	vmod				20	1
2755	Cik Kimura mempunyai otak yang sangat cerdik.	မစ္စတာ ခိမုရ က ဉာဏ်အရမ်းကောင်းတယ်။	\N		\N	vmod				20	1
3488	Saya makan daging yang tebal.	အသားတုံး ထူထူကို စားတယ်။(အသားတုံး ကြီးကြီးကို စားတယ်။)	\N		\N	vmod				23	1
3296	Kantin terletak di dalam bangunan sana.	စားသောက်ဆိုင်က ဟိုက အဆောက်အအုံထဲမှာ ရှိတယ်။	\N		\N	vmod				24	1
3264	Sekarang kakak saya tinggal sendirian di Tokyo.	အခု အစ်မက တိုကျိုမှာ တစ်ယောက်တည်း နေနေတယ်။	\N		\N	vmod				28	1
3768	Gambar itu saya ambil pada bulan lepas.	အဲဒီ ဓာတ်ပုံက ရှေ့လက တိုကျိုမှာ ရိုက်ထားတာ။	\N		\N	vmod				29	1
3769	Orang itu ialah Encik Kobayashi.	အဲဒီလူက မစ္စတာခိုဘယရှိ ပါ။	\N		\N	vmod				29	1
2997	Setiap malam, saya tidur selepas mandi. 	ညတိုင်း ရေချိုးပြီးမှ အိပ်တယ်။	\N		\N	vmod				31	1
2885	Sini tidak dibenarkan masuk kerana berbahaya.	အန္တရာယ်ရှိလို့ ဒီကို မဝင်ပါနဲ့။(အန္တရာယ်ရှိသည်။မဝင်ရ။)	\N		\N	vmod				32	1
2886	Oleh sebab sudah lewat malam, balik bersendirian adalah berbahaya.	ညအရမ်းမိုးချုပ်ပြီမို့ တစ်ယောက်တည်း ပြန်ရမှာ အန္တရာယ်များတယ်။	\N		\N	vmod				32	1
3335	Sekarang saya tidak ada wang.	ကျွန်မ(/ကျွန်တော်) အခု ပိုက်ဆံ မရှိဘူး။	\N		\N	vmod				37	1
3334	Esok Encik Hayashi ada kerja, jadi beliau tidak dapat datang.	မနက်ဖန် မစ္စတာ ဟယရှိ အလုပ်ရှိလို့ မလာနိုင်ဘူး။	\N		\N	vmod				37	1
3670	Ada ikan di dalam kolam.	ကန်ထဲမှာ ငါး ရှိတယ်။	\N		\N	vmod				48	1
3671	Ada kolam yang besar di dalam taman.	ပန်းခြံ ထဲမှာ ရေကန် အကြီးကြီး ရှိတယ်။	\N		\N	vmod				48	1
2767	Saya bercerita sambil duduk di kerusi.	ထိုင်ခုံမှာ ထိုင်ပြီး စကားပြောမယ်။	\N		\N	vmod				50	1
2983	Saya tidak begitu dapat berehat kerana sibuk setiap hari.	နေ့တိုင်း အလုပ်များလို့ သိပ် အနားမယူနိုင်ဘူး။	\N		\N	vmod				51	1
2984	Walaupun sibuk bekerja, ianya seronok.	အလုပ်က ပင်ပန်းပေမယ့် စိတ်ဝင်စားဖို့ကောင်းတယ်။	\N		\N	vmod				51	1
3884	Saya membeli sekeping poskad di pejabat pos.	စာတိုက်မှာ ပို့စကတ် တစ်ကတ် ဝယ်မယ်။	\N		\N	vmod				53	1
3438	Hotel ini satu hari harganya 7800 yen.	ဒီ ဟိုတယ်က တစ်နေ့ကို ယန်းခုနစ်ထောင့်ရှစ်ရာ ပါ။	\N		\N	vmod				54	1
3439	Semalam hujan, jadi satu hari suntuk saya ada di rumah.	ဒီနေ့ မိုးရွာလို့ တစ်နေ့လုံး အိမ်မှာ ရှိတယ်။	\N		\N	vmod				54	1
3545	Hari jadi bapa adalah pada lima hari bulan Jun.	အဖေ့ရဲ့ မွေးနေ့ က ခြောက်လပိုင်းငါးရက်နေ့ ပါ။	\N		\N	vmod				57	1
3536	Encik Tanaka beli 5 biji kek.	မစ္စတာ တာနာခါ ကိတ်မုန့် ငါးခု ဝယ်ခဲ့တယ်။	\N		\N	vmod				59	1
3177	Saya tidak faham maksud kata-kata cikgu.	ဆရာ့ စကားရဲ့ အဓိပ္ပာယ်ကို နားမလည်ဘူး။/ဆရာ ပြောတဲ့ အဓိပ္ပာယ်ကို နားမလည်ဘူး။	\N		\N	vmod				63	1
3178	Saya mengajar maksud perkataan ini kepada Encik Lee.	မစ္စတာ လီ ကို ဒီစကားရဲ့ အဓိပ္ပာယ် ကို သင်ပေးခဲ့တယ်။	\N		\N	vmod				63	1
2836	Saya menunjukkan tiket di pintu masuk stesen.	ဘူတာရဲ့ ဝင်ပေါက် မှာ လက်မှတ် ကို ပြတယ်။	\N		\N	vmod				66	1
3254	Ada anjing dan kucing di rumah saya.	အိမ်မှာ ခွေးနဲ့ ကြောင် ရှိတယ်။	\N		\N	vmod				754	1
3255	Encik Lee sekarang ada di perpustakaan.	မစ္စတာ လီ က အခု စာကြည့်တိုက်မှာ ရှိတယ်။	\N		\N	vmod				754	1
3338	Saya perlu kamus kerana saya akan tulis karangan dalam kelas esok.	မနက်ဖန် အတန်းမှာ စာစီစာကုံးရေးရမှာမလို့ အဘိဓာန် လိုတယ်။	\N		\N	vmod				67	1
3339	Kita perlu tiket bila naik kereta api.	ရထားစီးတဲ့အခါ လက်မှတ် လိုတယ်။	\N		\N	vmod				67	1
2869	Ramai orang berbaris di belakang saya.	ကျွန်မ(/ကျွန်တော်) နောက်မှာ လူတွေ အများကြီး တန်းစီနေတယ်။	\N		\N	vmod				72	1
2761	Ada pasar raya di belakang stesen.	ဘူတာရဲ့ အနောက်မှာ စူပါမားကက် ရှိတယ်။	\N		\N	vmod				72	1
3489	Saya beli sebuah kamus yang nipis.	အဘိဓာန် ပါးပါးတစ်အုပ် ဝယ်လိုက်တယ်။	\N		\N	vmod				73	1
3490	Oleh sebab dinding bilik ini nipis, kita bercakap dengan suara yang perlahan.	ဒီ အခန်းရဲ့ နံရံက ပါးလို့ အသံတိုးတိုးနဲ့ စကားပြောတယ်။	\N		\N	vmod				73	1
3342	Tempat lahir Tanaka ialah Tokyo.	မစ္စတာ တာနာခါ မွေးတဲ့နေရာ(/ရဲ့မွေးရပ်) က တိုကျိုပါ။	\N		\N	vmod				77	1
3343	Saya lahir pada 26 hari bulan Ogos.	ကျွန်မ(/ကျွန်တော်)ကို ရှစ်လပိုင်း နှစ်ဆယ့်ခြောက်ရက် မှာမွေးခဲ့တယ်။	\N		\N	vmod				77	1
3522	Anjing di rumah jiran bising, jadi saya tidak boleh belajar.	ဘေးအိမ်ကခွေးက ဆူလို့ စာဖတ်လို့ မရဘူး။	\N		\N	vmod				80	1
3523	Orang itu sentiasa bising semasa kelas.	စာသင်ချိန်မှာ အဲဒီလူ အမြဲတမ်း နားငြီးအောင်လုပ်တယ်။	\N		\N	vmod				80	1
3187	Saya keluar dengan bawa kot.	အပေါ်ထပ်အင်္ကျီ (/အနွေးထည်) ယူပြီး အပြင်ထွက်တယ်။	\N		\N	vmod				81	1
3644	Saya pergi ke pawagam menonton filem bersama Encik Lee pada minggu lepas.	ရှေ့အပတ်က မစ္စတာလီနဲ့ ရုပ်ရှင်ရုံကိုသွားပြီး ရုပ်ရှင်ကြည့်ခဲ့တယ်။	\N		\N	vmod				84	1
3645	Pawagam itu baru dan cantik.	အဲဒီ ရုပ်ရှင်ရုံက သစ်လွင်ပြီး သန့်ရှင်း(/လှပ)နေတာပဲ။	\N		\N	vmod				84	1
3798	Beg yang besar senang diguna.	အိတ်အကြီးကြီးက သုံးရတာအဆင်ပြေတယ်။	\N		\N	vmod				95	1
3799	Encik Tanaka tinggal di rumah yang besar.	မစ္စတာ တာနာခါ က အိမ်အကြီးကြီးမှာ နေတယ်။	\N		\N	vmod				95	1
3808	Ramai orang sedang berenang di laut.	ပင်လယ်မှာ လူတွေအများကြီး ရေကူးနေတယ်။	\N		\N	vmod				96	1
3809	Ramai orang yang datang ke parti.	ပါတီပွဲကို လူတွေ အများကြီး လာကြတယ်။	\N		\N	vmod				96	1
3209	Cik Kimura berikan kuih kepada saya.	မစ္စတာ ခိမုရ က ကျွန်မ(/ကျွန်တော်)ကို မုန့်ပေးတယ်။	\N		\N	vmod				98	1
3265	Isteri Encik Tanaka adalah seorang pensyarah di universiti.	မစ္စတာ တာနာခါရဲ့ အမျိုးသမီးက တက္ကသိုလ်က ဆရာမ ပါ။	\N		\N	vmod				102	1
3275	Pak cik gerai sayur itu sentiasa kelihatan ceria.	အဲဒီ ဟင်းသီးဟင်းရွက်ဆိုင်က ဦးလေးကြီးက အမြဲတမ်း တက်ကြွနေတာပဲ။	\N		\N	vmod				103	1
3277	Saya menunjukkan jalan kepada datuk.	ကျွန်မ(/ကျွန်တော်) အဖိုးကို လမ်း ညွှန်ပေးလိုက်တယ်။	\N		\N	vmod				104	1
2834	Tandas ada di tingkat dua.	သန့်စင်ခန်း က နှစ်ထပ်/(ဒုတိယထပ်)မှာ ရှိတယ်။	\N		\N	vmod				109	1
3282	Lekaki itu tinggi dan berkaki panjang.	အဲဒီ အမျိုးသားက အရပ် မြင့်ပြီး ခြေထောက်ရှည်တယ်။	\N		\N	vmod				112	1
3283	Ada budak lelaki sedang memanjat pokok di sana. 	ဟိုမှာ ကောင်လေးတစ်ယောက် သစ်ပင်ပေါ်တက်နေတယ်။	\N		\N	vmod				113	1
3421	Saya beli kasut baru di pusat membeli-belah dua hari lepas.	တနေ့က ကုန်တိုက်မှာ ဖိနပ်အသစ် ဝယ်ခဲ့တယ်။	\N		\N	vmod				114	1
3422	Salji turun kerana cuaca sejuk dua hari lepas.	တနေ့က အေးလို့ နှင်းတွေကျတယ်။	\N		\N	vmod				114	1
3314	Saya mendaki gunung ini dua tahun lepas.	ကျွန်မ(/ကျွန်တော်) တမြန်နှစ်က ဒီ တောင်ကို တက်ခဲ့တယ်။	\N		\N	vmod				115	1
3315	Encik Tanaka sudah keluar dari universiti dua tahun lepas.	တမြန်နှစ်က မစ္စတာ တာနာခါ ကျောင်းထွက်ခဲ့တယ်။	\N		\N	vmod				115	1
3266	Abang Encik Lee akan datang bermain di Jepun pada minggu depan.	နောက်အပတ် မစ္စတာလီရဲ့ အစ်ကို ဂျပန်ကို အလည်လာမယ်။	\N		\N	vmod				119	1
3261	Kakak Cik Kimura seorang yang sangat cantik.	မစ္စတာ ခိမုရရဲ့ အစ်မက အရမ်းချောတဲ့ မိန်းကလေး။	\N		\N	vmod				120	1
3276	Ibu saudara Encik Kobayashi tinggal di Tokyo.	မစ္စတာ ခိုဘယရှိရဲ့ အဒေါ်က တိုကျိုမှာ နေတယ်။	\N		\N	vmod				121	1
3278	Nenek Encik Hayashi memakai cermin mata.	မစ္စတာ ဟယရှိရဲ့ အဖွားက မျက်မှန်တပ်ထားတယ်။	\N		\N	vmod				122	1
2779	Saya makan malam, mandi kemudian tidur.	ညစာစားပြီး၊ ရေချိုးခန်းဝင်ပြီး(/ရေချိုးပြီး) အိပ်တယ်။	\N		\N	vmod				123	1
1745	Jangan mandi hari ini.	ဒီနေ့ ရေချိုးခန်း မဝင်ပါနဲ့။ (ဒီနေ့ ရေမချိုးပါနဲ့။)	null		\N	vmod				\N	1
2879	Pegawai polis memberitahu saya jalan ke stesen.	ရဲသား က ကျွန်မ(/ကျွန်တော်)ကို ဘူတာအထိ လမ်းညွှန်ပေးတယ်။	\N		\N	vmod				125	1
3491	Kotak yang berat dibawa oleh lelaki.	လေးတဲ့ သေတ္တာ ကို ယောကျာ်းလေးက သယ်မယ်။	\N		\N	vmod				126	1
3492	Beg ini besar dan berat.	ဒီ အိတ်က ကြီးပြီး လေးတယ်။	\N		\N	vmod				126	1
2838	Kalau nak ke kedutaan, awak turun di stesen seterusnya.	သံရုံးသွားမှာဆိုရင် နောက်ဘူတာမှာ ဆင်းရမယ်။	\N		\N	vmod				129	1
3274	Ada budak perempuan yang kecil di sana.	ဟိုမှာ ကောင်မလေး ငယ်ငယ်လေး တစ်ယောက် ရှိတယ်။	\N		\N	vmod				133	1
2939	Esok saya akan berjumpa dengan kawan yang merupakan warga asing	မနက်ဖန် နိုင်ငံခြားသား သူငယ်ချင်း(/မိတ်ဆွေ)နဲ့ တွေ့မယ်။	\N		\N	vmod				136	1
3146	Bercakap dengan warga asing sangat seronok	နိုင်ငံခြားသားနဲ့ စကားပြောရတာ ပျော်ဖို့ကောင်းတယ်။	\N		\N	vmod				136	1
2833	Saya tidak naik lif tetapi saya guna tangga.	ဓာတ်လှေခါး မစီးဘဲ လှေခါး ကို သုံးတယ်။	\N		\N	vmod				88	1
3130	Sudah masanya saya balik ke rumah hari ini.	ဒီနေ့တော့ အိမ်ပြန်မယ်။	\N		\N	vmod				142	1
3352	Kalau surat dihantar melalui laut, ianya mengambil masa yang sangat lama.	ရေကြောင်းနဲ့ စာပို့ရင် အချိန်အရမ်းကြာတယ်။	\N		\N	vmod				144	1
3353	Dari stesen untuk sampai ke hospital mengambil masa sepuluh minit dengan menaiki bas.	ဘူတာကနေ ဆေးရုံကို ဘတ်စ်ကားနဲ့ ဆယ်မိနစ် ကြာတယ်။	\N		\N	vmod				144	1
3131	Semalam saya kehilangan kunci.	မနေ့က သော့ ပျောက်သွားတယ်။	\N		\N	vmod				145	1
3132	Ini kunci rumah saya.	ဒါ ကျွန်မ(/ကျွန်တော်) အိမ်သော့ ပါ။	\N		\N	vmod				145	1
3310	Encik Hayashi akan pergi bekerja di luar negara selama satu bulan mulai minggu depan.	မစ္စတာ ဟယရှိ နောက်လကနေစပြီး တစ်လကြာ အလုပ်ကိစ္စနဲ့ နိုင်ငံခြားကို သွားမယ်။	\N		\N	vmod				148	1
3305	Saya belajar bahasa Inggeris selama tiga bulan di Amerika.	အမေရိကမှာ အင်္ဂလိပ်စာကို သုံးလ လေ့လာခဲ့တယ်။	\N		\N	vmod				148	1
3194	Oleh sebab mata tidak bagus saya memakai cermin mata.	မျက်စိ မကောင်းလို့ မျက်မှန်တပ်မယ်။	\N		\N	vmod				150	1
2786	Saya tertinggal payung di dalam kereta api.	ရထားပေါ်မှာ ထီး မေ့ကျန်ခဲ့တယ်။	\N		\N	vmod				151	1
3052	Kita tidak boleh bermain tenis pada hari angin bertiup kuat.	လေကြမ်းတဲ့နေ့ဆို တင်းနစ် ရိုက်လို့မရဘူး။	\N		\N	vmod				711	1
3030	Hari ini tiada angin bertiup.	ဒီနေ့ လေ မတိုက်ဘူး။	\N		\N	vmod				711	1
3145	Orang itu guru sekolah ini. 	အဲဒီ ပုဂ္ဂိုလ်က ဒီကျောင်းက ဆရာ ပါ။	\N		\N	vmod				155	1
3179	Ada banyak perkataan tulisan katakana dalam bahasa Jepun.	ဂျပန်စာမှာ ခတခန စကားတွေ အများကြီး ရှိတယ်။	\N		\N	vmod				156	1
3307	Esok adalah satu hari bulan April.	မနက်ဖန် လေးလပိုင်း(/ဧပြီလ) တစ်ရက်နေ့ ပါ။	\N		\N	vmod				157	1
3306	Hari jadi Encik Matsui adalah pada bulan Ogos.	မစ္စတာ မဆုအိရဲ့ မွေးနေ့က ရှစ်လပိုင်းမှာပါ။	\N		\N	vmod				157	1
2825	Saya dapat cawan yang comel daripada kawan.	သူငယ်ချင်းဆီက ခွက် လှလှလေး ရခဲ့တယ်။	\N		\N	vmod				159	1
3002	Makanan ini boleh dibuat di rumah.	ဒီ ဟင်းက အိမ်မှာ ချက်လို့ရတယ်။	\N		\N	vmod				160	1
3249	Kalau belok ke kanan di penjuru sana, akan ada pasar raya.	ဟို ထောင့် ကနေ ညာဘက်ကို ကွေ့ရင် စူပါမားကက် ရှိတယ်။	\N		\N	vmod				161	1
2902	Ada pasu bunga yang diletakkan di pintu masuk rumah.	အိမ်အဝင်၀ မှာ ပန်းအိုး ထားထားတယ်။	\N		\N	vmod				163	1
3878	Jangan pakai topi semasa kelas.	စာသင်ချိန်မှာ ဦးထုပ် မဆောင်းရဘူး။	\N		\N	vmod				164	1
3410	Awak mesti memulangkan buku sampai hari Selasa.	အင်္ဂါနေ့မကျော်ခင်ထိ စာအုပ် ပြန်မအပ်လို့ မဖြစ်ဘူး။ (အင်္ဂါနေ့မတိုင်မီ စာအုပ် ပြန်အပ်ရမယ်။)	\N		\N	vmod				167	1
3221	Adik lelaki saya mempunyai badan yang kuat.	မောင်လေး(/ညီလေး) က ကိုယ်ခန္ဓာ အရမ်း သန်မာတယ်။	\N		\N	vmod				169	1
3831	Encik Lee nak cuba bermain tenis.	မစ္စတာ လီ က တင်းနစ် ရိုက်ချင်နေတယ်။	\N		\N	vmod				171	1
3832	Kanak-kanak nak kuih.	ကလေးက မုန့် လိုချင်နေတယ်။	\N		\N	vmod				171	1
3494	Bagasi Cik Kimura kecil dan ringan.	မစ္စတာ ခိမုရရဲ့ အထုပ်က သေးပြီး ပေါ့တယ်။	\N		\N	vmod				172	1
3493	Saya nak kasut yang ringan.	ကျွန်မ(/ကျွန်တော်)  ပေါ့တဲ့ ဖိနပ် လိုချင်တယ်။	\N		\N	vmod				172	1
2809	Untuk makan malam hari ini, saya rasa nak masak kari .	ဒီနေ့ ညစာအတွက် ကာရီ ချက်မယ်လို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				173	1
2810	Kari adalah makanan India.	ကာရီ က အန္ဒိယ အစားအစာ ပါ။	\N		\N	vmod				173	1
2895	Ada kalendar yang diletakkan di atas meja.	စာရေးခုံ(/စာကြည့်စားပွဲ)ပေါ်မှာ ပြက္ခဒိန် ထားထားတယ်။	\N		\N	vmod				174	1
2896	Saya beli kalendar untuk tahun depan di pusat membeli-belah.	ကုန်တိုက်မှာ နောက်နှစ်အတွက်ပြက္ခဒိန် ကို ဝယ်တယ်။	\N		\N	vmod				174	1
2915	Semalam saya dan kawan pergi ke sungai dan kami bermain bersama.	မနေ့က သူငယ်ချင်းနဲ့ ချောင်းကို သွားကစားတယ်။	\N		\N	vmod				175	1
2916	Rumah saya terletak di sebalik sungai sana.	အိမ်က အဲဒီ ချောင်းရဲ့ တစ်ဖက်မှာ ရှိတယ်။	\N		\N	vmod				175	1
3250	Beg ini ada poket di sebelah luar.	ဒီ လွယ်အိတ်က အပြင်ဘက်ခြမ်းမှာ အိတ်ကပ် ရှိတယ်။	\N		\N	vmod				176	1
3251	Tandas terletak di sebelah kiri koridor.	အိမ်သာက လျှောက်လမ်းလေးရဲ့ ဘယ်ဘက်ခြမ်းမှာ ရှိတယ်။	\N		\N	vmod				176	1
3585	Saya suka haiwan yang kecil dan comel.	ကျွန်မ(/ကျွန်တော်)က  ချစ်စရာကောင်းတဲ့ အကောင်ငယ်လေးတွေကို ကြိုက်တယ်။	\N		\N	vmod				177	1
3586	Cik Kimura sangat comel.	မစ္စ ခိမုရ က အရမ်း ချစ်ဖို့ကောင်းတယ်။	\N		\N	vmod				177	1
3674	Semalam saya potong pokok.	မနေ့က သစ်ပင် ကို ခုတ်လိုက်တယ်။	\N		\N	vmod				179	1
3675	Di halaman rumah Encik Tanaka ada pokok dan bunga.	မစ္စတာ တာနာခါရဲ့ အိမ်က ခြံဝန်းထဲမှာ သစ်ပင်ပန်းပင် တွေရှိတယ်။	\N		\N	vmod				179	1
3246	Saya menerima sapu tangan berwarna kuning semasa hari jadi.	မွေးနေ့မှာ အဝါရောင် လက်ကိုင်ပဝါလေး လက်ဆောင်ရတယ်။	\N		\N	vmod				180	1
3238	Orang yang memakai kemeja kuning adalah Encik Hayashi.	အဝါရောင် ရှပ်အင်္ကျီ ဝတ်ထားတဲ့ တစ်ယောက်က မစ္စတာ ဟယရှိ ပါ။	\N		\N	vmod				181	1
3356	Pemanas mati, jadi segera saya menghidupkannya.	အပူပေးစက် ငြိမ်းသွားလို့ ချက်ချင်း ပြန်ထွန်းလိုက်တယ်။	\N		\N	vmod				182	1
3357	Lampu di bilik mati.	အခန်း မီး ငြိမ်းသွားပြီ။/အခန်း မီး ပျက်သွားပြီ။	\N		\N	vmod				182	1
2882	Saya bertanya kepada Encik Matsui tentang nombor telefon restoran yang akan saya pergi malam ini.	မစ္စတာ မဆုအိ ဆီက ဒီည သွားမယ့် စားသောက်ဆိုင် ရဲ့ ဖုန်းနံပါတ် ကို မေးထားတယ်။(မစ္စတာ မဆုအိ ဆီက ဒီည သွားမယ့် စားသောက်ဆိုင် ရဲ့ ဖုန်းနံပါတ်ရထားတယ်။)	\N		\N	vmod				183	1
3005	Encik Matsui boleh bermain gitar.	မစ္စတာ မဆုအိ က ဂီတာတီးတတ်တယ်။	\N		\N	vmod				185	1
3126	Saya bersihkan bilik kerana kotor.	အခန်းက ညစ်ပတ်နေလို့ သန့်ရှင်းရေးလုပ်မယ်။	\N		\N	vmod				791	1
3127	Laut dekat sini kotor.	ဒီအနီးတဝိုက်က ပင်လယ် က ညစ်ပတ်တယ်။	\N		\N	vmod				791	1
2819	Selepas habis sekolah, saya dan kawan minum teh di kedai kopi.	ကျောင်းဆင်းပြီးတော့မှ သူငယ်ချင်းနဲ့ ကော်ဖီဆိုင်မှာ လက်ဖက်ရည် သောက်တယ်။	\N		\N	vmod				187	1
2832	Kita membeli tiket semasa menaiki kereta api.	ရထားစီးတဲ့အခါ လက်မှတ် လိုတယ်။	\N		\N	vmod				189	1
3423	Sebuah restoran baru buka di depan stesen semalam.	မနေ့က ဘူတာရှေ့က စားသောက်ဆိုင်သစ်ကြီး ဖွင့်လိုက်ပြီ။	\N		\N	vmod				190	1
3424	Semalam, saya hantar surat kepada ibu saya.	မနေ့က အမေ့ဆီ စာ ပို့လိုက်တယ်။	\N		\N	vmod				190	1
2955	Daging lembu adalah paling mahal di antara semua jenis daging.	အမဲသား က အသားတွေထဲမှာ ဈေးအကြီးဆုံးပဲ။	\N		\N	vmod				192	1
2822	Saya tidak suka susu lembu, jadi saya jarang meminumnya.	ကျွန်မ(/ကျွန်တော်) နွားနို့ မကြိုက်လို့ သိပ် မသောက်ဘူး။	\N		\N	vmod				193	1
3271	Saya ada tiga adik-beradik.	ကျွန်မ(/ကျွန်တော်)မှာ ညီအစ်ကိုမောင်နှမ နှစ်ယောက်ရှိပါတယ်။	\N		\N	vmod				196	1
3011	Oleh sebab Encik Matsui tidak suka rokok, beliau tidak merokok.	မစ္စတာ မဆုအိက ဆေးလိပ် မကြိုက်လို့ မသောက်ဘူး။	\N		\N	vmod				198	1
3012	Saya tidak suka kerja pembersihan dan mencuci pakaian.	ကျွန်မ(/ကျွန်တော်) သန့်ရှင်းရေးတို့ အဝတ်လျှော်တာတို့ကို လုပ်ရတာ မုန်းတယ်(/မကြိုက်ဘူး)။	\N		\N	vmod				198	1
3577	Berat saya empat puluh lima kilogram sekarang.	ကျွန်မ(/ကျွန်တော်) အခု ကိုယ်အလေးချိန် လေးဆယ့်ငါးကီလိုဂရမ် ရှိတယ်။	\N		\N	vmod				201	1
3578	Beg ini beratnya lima kilogram, jadi ianya berat.	ဒီ အထုပ် က ငါးကီလို ရှိလို့ လေးတယ်။	\N		\N	vmod				201	1
3136	Saya meminjam wang dari bank.	ဘဏ်မှာ  ငွေ（/ပိုက်ဆံ） ချေးတယ်။	\N		\N	vmod				202	1
2795	Bank buka dari pukul sembilan pagi hingga tiga petang.	ဘဏ်ဖွင့်ချိန်က မနက် ကိုးနာရီကနေ ညနေ သုံးနာရီ ထိ ပါ။	\N		\N	vmod				202	1
2751	Saya terkena selesema, jadi saya makan ubat.	အအေးမိသွားလို့ ဆေးသောက်မယ်။	\N		\N	vmod				205	1
2961	Setiap pagi saya makan sayur dan buah. 	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း ဟင်းသီးဟင်းရွက်နဲ့ သစ်သီးကို စားတယ်။	\N		\N	vmod				206	1
3227	Saya tidak boleh buka mulut kerana gigi sakit.	သွားနာလို့ ပါးစပ်ဟလို့ မရဘူး။	\N		\N	vmod				207	1
3147	Saya datang ke negara ini tiga tahun yang lalu.	လွန်ခဲ့တဲ့ သုံးနှစ်က ဒီနိုင်ငံကို လာခဲ့တယ်။	\N		\N	vmod				210	1
2943	Jepun adalah negara yang sempit.	ဂျပန်က ကျဉ်းတဲ့ နိုင်ငံ ဖြစ်တယ်။(ဂျပန်နိုင်ငံက ကျဉ်းတယ်။)	\N		\N	vmod				210	1
3027	Semalam sepanjang hari mendung.	မနေ့က တောက်လျှောက် မိုးအုံ့တယ်။	\N		\N	vmod				211	1
3026	Saya dengar esok akan mendung.	မနက်ဖန် မိုးအုံ့မယ်ဆိုပဲ။	\N		\N	vmod				211	1
3047	Langit menjadi sedikit mendung	မိုး နည်းနည်း အုံ့လာပြီ။	\N		\N	vmod				212	1
3048	Semalam sepanjang hari mendung.	မနေ့က တောက်လျှောက် မိုးအုံ့တယ်။	\N		\N	vmod				212	1
3833	Saya sudah siapkan kerja rumah kira-kira separuh.	အိမ်စာ တစ်ဝက်လောက် ပြီးသွားပြီ။	\N		\N	vmod				213	1
3834	Berat telur kira-kira lima puluh gram sebiji.	ကြက်ဥ က တစ်လုံးကို ငါးဆယ်ဂရမ်လောက် ရှိတယ်။	\N		\N	vmod				213	1
3581	Saya masukkkan tiga puluh gram gula dan lima belas gram garam.	သကြား သုံးဆယ်ဂရမ်နဲ့ ဆား ဆယ့်ငါးဂရမ် ထည့်မယ်။	\N		\N	vmod				215	1
3582	Saya membeli dua ratus gram daging babi.	ဝက်သား နှစ်ရာဂရမ် ဝယ်မယ်။	\N		\N	vmod				215	1
3240	Semasa saya pergi ke syarikat, saya memakai sut berwarna hitam.	ကုမ္ပဏီသွားတဲ့အခါ အနက်ရောင် အနောက်တိုင်းဝတ်စုံကို ဝတ်တယ်။	\N		\N	vmod				218	1
2877	Ada ramai anggota polis di persimpangan.	လမ်းဆုံမှာ ရဲတွေ အများကြီးပဲ။	\N		\N	vmod				220	1
2878	Anggota polis bertanyakan nama saya. 	ရဲက ကျွန်မ(/ကျွန်တော်)ကို နာမည်မေးတယ်။	\N		\N	vmod				220	1
3442	Saya keluar dari rumah tanpa makan nasi pagi tadi. 	မနက်က ထမင်းမစားဘဲ အိမ်က ထွက်တယ်။	\N		\N	vmod				221	1
3443	Cuaca pagi ini cerah. 	မနက်က ရာသီဥတု သာယာတယ်။	\N		\N	vmod				221	1
3362	Encik Tanaka sudah berkahwin dan mempunyai anak.	မစ္စတာ တာနာခါ က လက်ထပ်ပြီးသား၊ ကလေး ရှိတယ်။	\N		\N	vmod				225	1
3361	Pada musim bunga tahun depan, kakak akan berkahwin.	​နောက်နှစ် နွေဦးကျရင် အစ်မ မင်္ဂလာဆောင်မယ်။	\N		\N	vmod				225	1
2777	Ada pasu bunga diletakkan di pintu masuk rumah.	အိမ်အဝင်၀ မှာ ပန်းအိုး ထားထားတယ်။	\N		\N	vmod				227	1
2776	Saya membersihkan koridor dan pintu masuk rumah.	အိမ်အဝင်၀နဲ့ လျှောက်လမ်း တွေကို သန့်ရှင်းရေးလုပ်တယ်။	\N		\N	vmod				227	1
3560	Masakan ini menggunakan dua biji telur.	ဒီဟင်းကို ကြက်ဥ နှစ်လုံး သုံးရတယ်။	\N		\N	vmod				229	1
3561	Saya makan satu biji kuih yang saya terima daripada Encik Lee.	မစ္စတာ လီ ဆီကရခဲ့တဲ့ မုန့်ကို တစ်ခုစားလိုက်တယ်။	\N		\N	vmod				229	1
3888	わたしの　家族は　五人です。	ကျွန်မ(/ကျွန်တော်)တို့မှာ မိသားစု ငါးယောက်ရှိတယ်။	\N		\N	vmod				736	1
2907	Lintas persimpangan sana, kemudian belok ke kiri.	အဲဒီ လမ်းဆုံကို ဖြတ်ပြီး ဘယ်ဘက် ကို ကွေ့မယ်။	\N		\N	vmod				232	1
2875	Saya bertanya jalan kepada anggota polis di pondok polis.	ရဲကင်းက ရဲသားကို လမ်း မေးခဲ့တယ်။	\N		\N	vmod				234	1
2876	Ada peta bandar dilekat di pondok polis.	ရဲကင်းမှာ မြို့ရဲ့ မြေပုံ ကို ချိတ်ထားတယ်။	\N		\N	vmod				234	1
3188	Oleh sebab sejuk di luar, saya memakai kot dan pergi ke syarikat.	အပြင်မှာ အေးလို့ ကုမ္ပဏီကို ကုတ်အင်္ကျီ ဝတ်သွားတယ်။	\N		\N	vmod				236	1
3549	Ibu bapa akan datang melawat rumah saya pada sembilan hari bulan bulan depan.	နောက်လ ကိုးရက်နေ့မှာ မိဘတွေ ကျွန်မ(/ကျွန်တော်) အိမ်ကို လာလည်မယ်။	\N		\N	vmod				240	1
3540	Di dalam bilik darjah ini ada sembilan buah beg.	ဒီ စာသင်ခန်းမှာ လွယ်အိတ် ကိုးလုံး ရှိတယ်။	\N		\N	vmod				241	1
2863	Saya tidak dapat menjawab soalan kerana ianya susah.	မေးခွန်း ခက်လို့ မဖြေနိုင်ဘူး။	\N		\N	vmod				243	1
2824	Selepas minum, saya basuh gelas sehingga bersih.	သောက်ပြီးရင် ခွက်ကို ပြောင်အောင် ဆေးမယ်။	\N		\N	vmod				246	1
3184	Apabila ada makna perkataan yang tidak jelas, saya menggunakan kamus. 	စကားရဲ့ အဓိပ္ပာယ် နားမလည်တဲ့အခါ အဘိဓာန် ကို သုံးတယ်။	\N		\N	vmod				248	1
3273	Ada kanak-kanak sedang bermain di taman.	ကလေးလေး ပန်းခြံ မှာ ကစားနေတယ်။	\N		\N	vmod				249	1
2807	Saya suka kedua-dua roti dan nasi.	ကျွန်မ(/ကျွန်တော်) ပေါင်မုန့်ရော ထမင်းရော ကြိုက်တယ်။	\N		\N	vmod				251	1
2808	Malam ini saya akan makan nasi di rumah kawan.	ဒီည သူငယ်ချင်းရဲ့ အိမ်မှာ ထမင်းစားမယ်။	\N		\N	vmod				251	1
2975	Saya membuat salinan buku di perpustakaan.	စာကြည့်တိုက်မှာ စာအုပ်ကို မိတ္တူ(/ကော်ပီ)ကူးခဲ့တယ်။	\N		\N	vmod				253	1
2973	Saya membuat salinan ini sebanyak lima helai.	ဒါကို မိတ္တူ(/ကော်ပီ) ငါးစောင် ကူးမယ်။	\N		\N	vmod				253	1
3835	Encik Tanaka akan tiba di stesen dalam lebih kurang pukul sepuluh.	မစ္စတာ တာနာခါ ဆယ်နာရီဝန်းကျင်လောက် ဘူတာကို ရောက်မယ်။	\N		\N	vmod				256	1
3836	Semasa saya masih kanak-kanak, saya selalu bermain di taman itu.	ကျွန်မ(/ကျွန်တော်) ကလေးဘ၀တုန်းက အဲဒီပန်းခြံမှာ အမြဲ ကစားတယ်။	\N		\N	vmod				256	1
3686	Ada sebanyak empat ujian pada minggu ini.	ဒီအပတ် စာမေးပွဲ လေးခုတောင် ရှိတယ်။	\N		\N	vmod				258	1
3416	Kelas bahasa Jepun tidak ada pada minggu ini.	ဒီအပတ် ဂျပန်စာအတန်း မရှိဘူး။	\N		\N	vmod				258	1
3790	Saya mencari dompet berwarna hitam seperti ini.	ဒီလောက်လောက် မဲတဲ့ ပိုက်ဆံအိတ် ကို ရှာနေတယ်။(ဒီလို အမဲရောင် ပိုက်ဆံအိတ် ကို ရှာနေတယ်။)	\N		\N	vmod				259	1
3791	Saya mahukan topi seperti ini.	ကျွန်မ(/ကျွန်တော်) ဒီလို ဦးထုပ် လိုချင်တယ်။	\N		\N	vmod				259	1
3562	Di Jepun, umur yang dibenarkan memandu adalah lapan belas tahun.	ဂျပန်မှာ ဆယ့်ရှစ်နှစ်ကစပြီး ကားမောင်းလို့ရတယ်။	\N		\N	vmod				262	1
3838	Sekarang pukul dua belas lebih.	အခု ဆယ့်နှစ်နာရီကျော်ပြီ။	\N		\N	vmod				317	1
3563	Adik perempuan saya berumur empat tahun.	ကျွန်မ(/ကျွန်တော်) ညီမလေးက လေးနှစ်ပါ။	\N		\N	vmod				262	1
2787	Semalam saya beli dompet yang baru.	မနေ့က ပိုက်ဆံအိတ် အသစ် ဝယ်လိုက်တယ်။	\N		\N	vmod				263	1
3465	Apabila pulang ke rumah, saya akan mandi dulu.	အိမ်ပြန်ရင် ရေအရင်ချိုးမယ်။	\N		\N	vmod				265	1
3466	Apabila hendak menaiki kereta api, biarlah orang turun dulu.	ရထားစီးတဲ့အခါ ဆင်းတဲ့လူက အရင်။	\N		\N	vmod				265	1
3366	Oleh sebab hujan turun, saya berpayung pergi ke sekolah.	မိုးရွာနေလို့ ထီးဆောင်းပြီး ကျောင်းကို သွားတယ်။/မိုးရွာနေလို့ ကျောင်းကို ထီးဆောင်းသွားတယ်။	\N		\N	vmod				269	1
2826	Saya memasukkan gula dan minum kopi.	ကျွန်မ(/ကျွန်တော်) ကော်ဖီကို သကြားထည့်သောက်တယ်။	\N		\N	vmod				272	1
3320	Dua tahun akan datang saya akan pulang ke negara asal.	နောက်နှစ်ရဲ့နောက်တစ်နှစ်ကျရင် နိုင်ငံကို ခဏပြန်မယ်။(နောက်တစ်နှစ်ကျော်လောက်ကျရင် ကိုယ့်နိုင်ငံကိုယ် ခဏပြန်မယ်။)	\N		\N	vmod				275	1
3321	Saya dengar perpustakaan akan siap di sana dua tahun akan datang.	နောက်နှစ်ရဲ့နောက်တစ်နှစ်ကျရင် အဲဒီမှာ စာကြည့်တိုက် ဖွင့်မယ်ကြားတယ်။(နောက်တစ်နှစ်ကျော်လောက်ကျရင် အဲဒီမှာ စာကြည့်တိုက် ဖွင့်မယ်ကြားတယ်။)	\N		\N	vmod				275	1
3886	Rumah saya ada tiga buah TV.	အိမ်မှာ တီဗွီ သုံးလုံး ရှိတယ်။	\N		\N	vmod				734	1
3280	Encik Matsui dan Encik Lee berkawan.	မစ္စတာ မဆုအိနဲ့ မစ္စတာ လီ က သူငယ်ချင်းတွေ ပါ။	\N		\N	vmod				276	1
2918	Saya pergi berjalan-jalan setiap pagi.	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း လမ်းလျှောက် ထွက်တယ်။	\N		\N	vmod				277	1
3220	Saya memasak dengan masukkan gula dan garam.	သကြားနဲ့ ဆားကို ထည့်ပြီး ဟင်းချက်တယ်။(ဟင်းထဲကို သကြားနဲ့ ဆား ထည့်ချက်တယ်။)	\N		\N	vmod				280	1
3219	Saya ambilkan garam untuk Encik Lee.	မစ္စတာလီ ဆီကို ဆား ယူပေးလိုက်တယ်။(မစ္စတာလီဆီကို ဆား လှမ်းပေးလိုက်တယ်။)	\N		\N	vmod				280	1
3692	Saya ingin berehat sepanjang hari esok.  Tetapi saya harus pergi ke sekolah.	မနက်ဖန် တစ်နေ့လုံး နားချင်တယ်။ ဒါပေမယ့် ကျောင်းမသွားလို့ မဖြစ်ဘူး။	\N		\N	vmod				281	1
3693	Setiap hari sibuk tetapi sangat seronok.	နေ့တိုင်း အလုပ်များတယ်။ ဒါပေမယ့် အရမ်း ပျော်တယ်။	\N		\N	vmod				281	1
2909	Kereta buatan Jepun dijual di luar negara.	ပြည်ပမှာ ဂျပန်ကကားတွေ ရောင်းကောင်းနေတယ်။	\N		\N	vmod				290	1
2910	Ini majalah kereta.	ဒါ မော်တော်ကား မဂ္ဂဇင်း ပါ။	\N		\N	vmod				290	1
2753	Ramai orang yang mati.	လူတွေ အများကြီး သေကုန်တယ်။	\N		\N	vmod				291	1
2996	Oleh sebab panas, saya balik ke rumah dan mandi.	ပူလို့ အိမ်ပြန်ပြီး ရေချိုးတယ်။	\N		\N	vmod				299	1
3462	Semasa kelas kita mesti mendengar cakap guru.	စာသင်ချိန်မှာ ဆရာ့စကားကို သေချာ နားထောင်ရမယ်။	\N		\N	vmod				397	1
3595	Jika makan banyak nasi, badan akan jadi kuat.	ထမင်း အများကြီးစားရင် ခန္ဓာကိုယ် သန်စွမ်းမယ်။	\N		\N	vmod				305	1
3596	Encik Yamada kuat dan sihat.	မစ္စတာ ရာမဒ က သန်စွမ်းပြီး တက်တက်ကြွကြွ ရှိတယ်။	\N		\N	vmod				305	1
3202	Saya makan sashimi dengan cicah kicap. 	ဆာရှိမိကို ပဲငံပြာရည် ဆမ်းပြီး စားတယ်။	\N		\N	vmod				306	1
3881	Saya paling suka warna putih. 	ကျွန်မ(/ကျွန်တော်) အရောင်တွေထဲမှာ အဖြူရောင် ကို အကြိုက်ဆုံးပဲ။	\N		\N	vmod				309	1
2988	Saya menghisap rokok.	ကျွန်မ(/ကျွန်တော်) ဆေးလိပ် သောက်တယ်။	\N		\N	vmod				314	1
2989	Menghisap rokok tidak baik untuk kesihatan.	ဆေးလိပ် သောက်တာ ခန္ဓာကိုယ် အတွက် မကောင်းဘူး။(ဆေးလိပ် သောက်ရင် ကျန်းမာရေး ထိခိုက်နိုင်တယ်။)	\N		\N	vmod				314	1
3192	Cik Kobayashi lebih suka seluar daripada skirt.	မစ္စ ခိုဘယရှိက စကတ် ထက် ဘောင်းဘီ ကို ပိုကြိုက်တယ်။	\N		\N	vmod				315	1
3837	Kelas selalunya akan mula dalam pukul sembilan lebih.	အမြဲတမ်း ကိုးနာရီကျော်မှာ အတန်း စတယ်။	\N		\N	vmod				317	1
3526	Saya ingin pergi ke tempat yang orangnya sedikt.	လူ နည်းတဲ့ နေရာ ကို သွားချင်တယ်။(လူ သိပ်မရှိတဲ့ အရပ်ကို သွားချင်တယ်။)	\N		\N	vmod				319	1
3527	Pasar raya sana ikannya sedikit.	အဲဒီ စူပါမားကက်မှာ ငါး နည်းနည်းပဲ ရှိတယ်။(အဲဒီ စူပါမားကက်မှာ ငါး သိပ်မရှိဘူး။)	\N		\N	vmod				319	1
3038	Apabila tingkap dibuka, jadi sejuk sedikit.	ပြတင်းပေါက် ဖွင့်လိုက်တော့မှ နည်းနည်း အေးသွားတယ်။	\N		\N	vmod				321	1
3039	Musim luruh sejuk.\n	ဆောင်းဦး က အေးမြတယ်။	\N		\N	vmod				321	1
3818	Kalau belajar, awak akan pandai berbahasa Jepun sedikit demi sedikit.	ဂျပန်စာကို လေ့လာရင်တော့ နည်းနည်းစီ တိုးတက်လာမှာပါ။	\N		\N	vmod				322	1
3819	Sila ambil kertas satu demi satu.	စာရွက်ကို တစ်ရွက်စီ ယူပါ။	\N		\N	vmod				322	1
3021	Saya tutup pemanas sebelum tidur.	မအိပ်ခင် အပူပေးစက်ကို ပိတ်တယ်။	\N		\N	vmod				323	1
3019	Apabila pemanas dibuka, akan rasa panas.	အပူပေးစက် ဖွင့်ထားရင် နွေးတယ်။	\N		\N	vmod				323	1
2812	Letakkan gula dalam kopi dengan sudu.	ဇွန်းနဲ့ ကော်ဖီ ထဲကို သကြား ထည့်တယ်။	\N		\N	vmod				324	1
3193	Saya menanggalkan kasut dan memakai selipar.	ရှူးဖိနပ်ကို ချွတ်ပြီး ဖိနပ်ပါး ကို စီးတယ်။	\N		\N	vmod				328	1
3640	Saya basuh tangan dengan sabun.	ဆပ်ပြာနဲ့ လက်ကို ဆေးတယ်။	\N		\N	vmod				334	1
3641	Tiada sabun di bilik mandi.	ရေချိုးခန်းမှာ ဆပ်ပြာ မရှိဘူး။	\N		\N	vmod				334	1
3883	"Kosong" adalah sama dengan "sifar".	ဇီးရိုး က သုံည နဲ့အတူတူပဲ။	\N		\N	vmod				337	1
3895	Saya meminjam seribu yen daripada Encik Yamada semalam.	မနေ့က ကျွန်မ(/ကျွန်တော်) မစ္စတာ ရာမဒ ကို ယန်းတစ်ထောင်ချေးလိုက်တယ်။	\N		\N	vmod				338	1
2995	Esok pagi saya mesti mencuci pakaian saya.	နက်ဖန်မနက်ကျရင် အဝတ် မလျှော်လို့ မဖြစ်ဘူး။	\N		\N	vmod				342	1
2999	Esok pagi saya mesti mencuci pakaian saya.	နက်ဖန်မနက်ကျရင် အဝတ် မလျှော်လို့ မဖြစ်ဘူး။	\N		\N	vmod				343	1
2998	Selepas balik, saya nak membersihkan rumah.	အိမ်ပြန်ရောက်ရင် သန့်ရှင်းရေးလုပ်မယ်လို့ စိတ်ကူးတယ်။	\N		\N	vmod				347	1
3696	Nasi di kantin murah dan sedap.	စားသောက်ဆိုင်က ထမင်းက ဈေးပေါတယ်။ ပြီးတော့ စားလို့လည်းကောင်းတယ်။	\N		\N	vmod				348	1
3697	Saya keluar dari rumah pukul lapan dan menaiki bas pergi ke sekolah.	ရှစ်နာရီမှာ အိမ်ကထွက်တယ်။ ပြီးတော့ ဘတ်စ်ကားနဲ့ကျောင်းကို သွားတယ်။	\N		\N	vmod				348	1
2890	Beg yang terletak dekat dengan saya sudah diberikan kepada Encik Matsui.	ကျွန်မ(/ကျွန်တော်)ဘေးမှာထားထားတဲ့ အိတ်ကို မစ္စတာ မဆုအိ ကို ပေးလိုက်တယ်။	\N		\N	vmod				354	1
2889	Rumah Encik Matsui dekat dengan rumah saya.	မစ္စတာ မဆုအိရဲ့အိမ်က ကျွန်မ(/ကျွန်တော်) အိမ်ရဲ့ဘေးမှာ ရှိတယ်။	\N		\N	vmod				354	1
3872	Kelas hari ini sampai di sini sahaja. Baiklah, jumpa lagi minggu depan.	ဒီနေ့ သင်ခန်းစာ က ဒီလောက်ပါပဲ။ နောက်အပတ်မှ ထပ်တွေ့ ကြတာပေါ့။	\N		\N	vmod				358	1
3873	Sudah siap menjawab ujian? Baiklah sila hantar.	စာမေးပွဲဖြေပြီးပြီလား။ ပြီးရင် ထပ်ကြပါ။	\N		\N	vmod				358	1
3564	Bilik darjah ini ada tujuh buah komputer.	ဒီစာသင်ခန်းမှာ ကွန်ပျူတာ ခုနစ်လုံး ရှိတယ်။	\N		\N	vmod				359	1
3565	Ada empat buah kereta berhenti di depan kedai.	ဆိုင်ရှေ့မှာ ကား လေးစီး ရပ်ထားတယ်။	\N		\N	vmod				359	1
2940	Kalau pusing ke kanan dekat persimpangan itu, akan ada kedutaan.	အဲဒီ လမ်းဆုံကနေ ညာဘက်ကို ကွေ့ရင် သံရုံး ရှိတယ်။(အဲဒီ လမ်းဆုံကနေ ညာဘက် ကွေ့ရင် သံရုံးကိုတွေ့မယ်။)	\N		\N	vmod				361	1
2941	Esok saya akan pergi ke kedutaan.	ကျွန်မ(/ကျွန်တော်) မနက်ဖန် သံရုံးကို သွားမယ်။	\N		\N	vmod				361	1
3600	Ini surat yang penting.	ဒါ အရေးကြီးတဲ့ စာပါ။	\N		\N	vmod				364	1
3599	Buku ini sangat penting, jadi jangan hilangkannya.	ဒီစာအုပ်က အရမ်း အရေးကြီးလို့ မပျောက်ပါစေနဲ့။	\N		\N	vmod				364	1
2778	Dapur di rumah baru luas, jadi sangat senang diguna.	အိမ်သစ်က မီးဖိုချောင်ကျယ်လို့ အရမ်း အဆင်ပြေတယ်။	\N		\N	vmod				365	1
2911	Saya naik teksi dari stesen sampai syarikat.	ဘူတာကနေ ကုမ္ပဏီကို တက္ကဆီ စီးသွားတယ်။	\N		\N	vmod				369	1
2912	Saya pulang ke rumah dengan teksi.	တက္ကဆီနဲ့ အိမ်ပြန်မယ်။	\N		\N	vmod				369	1
3911	Selalu sebelum tidur, saya akan membaca buku selama tiga puluh minit sahaja.	အမြဲတမ်း မအိပ်ခင်မှာ မိနစ် သုံးဆယ်လောက် စာအုပ်ဖတ်တယ်။	\N		\N	vmod				370	1
3912	Saya makan satu biji kuih sahaja.	မုန့်ကို တစ်ခုတည်းပဲ စားတယ်။	\N		\N	vmod				370	1
3820	Budak-budak sedang bermain di taman.	ပန်းခြံမှာ ကလေးတွေ ကစားနေတယ်။	\N		\N	vmod				372	1
3821	Orang-orang itu kawan saya.	ဟိုလူတွေက(/သူတို့တွေက) သူငယ်ချင်းတွေပါ။	\N		\N	vmod				372	1
3621	Buku nota ini lebih panjang panjangnya daripada lebarnya. 	ဒီစာအုပ်က အလျားထက်စာရင် အနံက ပိုရှည်တယ်။	\N		\N	vmod				374	1
3622	Saya memotong kertas ini secara menegak.	ဒီ စက္ကူ ကို ဒေါင်လိုက် ဖြတ်မယ်။	\N		\N	vmod				374	1
3746	Esok awak akan berjumpa dengan siapa?	မနက်ဖန် ဘယ်သူနဲ့ တွေ့မှာလဲ။	\N		\N	vmod				383	1
1308	Milik siapakah beg itu?	အဲဒီ အိတ်က ဘယ်သူ့ဟာလဲ။	null		\N	vmod				\N	1
1900	Di sana ada orang, kan. Siapakah orang itu?	ဟိုမှာ လူတစ်ယောက် ရှိတယ်နော်။ အဲဒီလူက ဘယ်သူလဲ။(ဟိုမှာ လူတစ်ယောက် ရှိတယ်မလား။ အဲဒီလူက ဘယ်သူလဲ။)	null		\N	vmod				\N	1
3747	Ada sesiapa di bilik sebelah?	ဘေးက အခန်းမှာ ဘယ်သူ ရှိသလဲ။	\N		\N	vmod				384	1
3748	Ada sesiapa yang mempunyai pen mata bulat saya?	တစ်ယောက်ယောက်များ ကျွန်မ(/ကျွန်တော်) ဘောပင် ယူသွားသေး လားမသိဘူး။	\N		\N	vmod				384	1
3609	Bulan ini sibuk, jadi tiada hari lapang.	ဒီလ အလုပ်များလို့ အားရက်မရှိဘူး။	\N		\N	vmod				549	1
3619	Encik Yamada memberikan jam pada hari jadi Encik Kobayashi.	မစ္စတာ ရာမဒ က မစ္စတာ ခိုဘယရှိ ရဲ့မွေးနေ့အတွက် နာရီလက်ဆောင် ပေးခဲ့တယ်။	\N		\N	vmod				385	1
3620	Hari Jadi saya ialah 26 hari bulan Ogos.	ကျွန်မ(/ကျွန်တော်)မွေးနေ့က ရှစ်လပိုင်း နှစ်ဆယ့်ခြောက်ရက် နေ့ပါ။	\N		\N	vmod				385	1
3716	Encik Lee semakin pandai berbahasa Jepun.	မစ္စတာ လီ တဖြည်းဖြည်း ဂျပန်စကား တော်လာပြီ။	\N		\N	vmod				386	1
3717	Mulai bulan Julai cuaca akan menjadi semakin panas.	ခုနစ်လပိုင်းကစပြီး တဖြည်းဖြည်း ပူတော့မယ်။	\N		\N	vmod				386	1
3800	Ada kerusi kecil di dalam bilik saya.	ကျွန်မ(/ကျွန်တော်) အခန်းမှာ ထိုင်ခုံသေးသေးလေး ရှိတယ်။	\N		\N	vmod				388	1
3801	Saya lahir di bandar yang kecil.	ကျွန်မ(/ကျွန်တော်)ကို မြို့ငယ်လေးတစ်မြို့ မှာမွေးခဲ့တယ်။	\N		\N	vmod				388	1
2831	Kereta api bawah tanah murah, laju dan sangat berguna.	မြေအောက်လိုင်းကဈေးပေါပြီး အရမ်း အဆင်ပြေ တယ်။	\N		\N	vmod				392	1
3242	Warna rambut Cik Kimura adalah warna coklat.	မစ္စ ခိမုရ ရဲ့ ဆံပင်က အနီရောင် ပါ။	\N		\N	vmod				395	1
3204	Saya menyusun mangkuk dan penyepit di atas meja.	စားပွဲခုံ ပေါ်မှာ ပန်းကန်လုံးနဲ့ တူတွေကို စီထားမယ်။	\N		\N	vmod				396	1
3205	Saya makan nasi menggunakan mangkuk.	ပန်းကန်လုံးနဲ့ ထမင်းစားတယ်။	\N		\N	vmod				396	1
3541	Cuti musim panas mula dari satu hari bulan Ogos. 	ရှစ်လပိုင်းတစ်ရက်နေ့ကစပြီး နွေရာသီ ပိတ်ပြီ။	\N		\N	vmod				400	1
3234	Hari ini sibuk, jadi saya sangat letih.	မနေ့က အလုပ်များလို့ အရမ်းပင်ပန်းသွားတယ်။	\N		\N	vmod				402	1
2757	Bagasi akan tiba esok.	မနက်ဖန် အထုပ် ရောက်မယ်။	\N		\N	vmod				404	1
2758	Kereta api akan tiba di stesen.	ရထားက ဘူတာကို ဆိုက် တယ်။	\N		\N	vmod				404	1
1533	Dalam bilik saya ada meja, katil, TV dan lain-lain.	ကျွန်မ(/ကျွန်တော်)ရဲ့ အခန်းမှာ စာရေးခုံ(/စာကြည့်စားပွဲ) တို့ အိပ်ရာတို့ တီဗွီတို့ ရှိတယ်။	null		\N	vmod				\N	1
3162	Saya membuat meja sendirian.	စားပွဲခုံကို ကိုယ်တိုင်လုပ်တယ်။	\N		\N	vmod				406	1
3161	Syarikat itu membuat kereta.	အဲဒီ ကုမ္ပဏီက ကား ထုတ်လုပ် နေတယ်။	\N		\N	vmod				406	1
2898	Oleh sebab bilik itu gelap, saya akan pasang lampu.	အခန်းကမှောင်လို့ မီး ထွန်းမယ်။	\N		\N	vmod				407	1
3481	Saya minum secawan susu sejuk setiap pagi.	မနက်တိုင်း နွားနို့ အေးအေးလေး တစ်ခွက် သောက်တယ်။	\N		\N	vmod				410	1
3482	Air di dalam kolam renang sejuk.	ရေကူးကန်က ရေက အေးတယ်။	\N		\N	vmod				410	1
3075	Ada pasu bunga di atas meja.	စားပွဲပေါ်မှာ ပန်းအိုး ရှိတယ်။	\N		\N	vmod				414	1
3000	Esok malam saya akan keluar kerana ingin berjumpa dengan kawan.	မနက်ဖန်ည သူငယ်ချင်းနဲ့ တွေ့ရမှာမို့ အပြင်ထွက်မယ်။	\N		\N	vmod				416	1
3001	Semalam saya tidak keluar ke mana-mana.	မနေ့က ဘယ်မှ မထွက်ဘူး။	\N		\N	vmod				416	1
2837	Kalau keluar dari pintu keluar ini, paling dekat dengan perpustakaan. 	ဒီ ထွက်ပေါက်ကနေ ထွက်ရင် စာကြည့်တိုက် နဲ့ အနီးဆုံးကို ရောက်မယ်။	\N		\N	vmod				420	1
3626	Pintu bilik saya tak mahu tutup. 	ကျွန်မ(/ကျွန်တော်) အခန်း တံခါးက ပိတ်လို့မရဘူး။	\N		\N	vmod				431	1
3625	Jangan buka pintu situ. 	အဲဒီက တံခါးကို ဖွင့်လို့ မရဘူး။	\N		\N	vmod				431	1
3046	Saya terkena selesema, jadi suhu badan tiga puluh lapan darjah.	အအေးမိပြီး အဖျား(/ကိုယ်အပူချိန်) သုံးဆယ့်ရှစ် ဒီဂရီ ရှိတယ်။	\N		\N	vmod				432	1
3045	Esok suhu akan naik sampai tiga puluh darjah, jadi akan panas.	မနက်ဖန် အပူချိန်သုံးဆယ်ဒီဂရီအထိ မြင့်မှာဆိုတော့ ပူတယ်။	\N		\N	vmod				432	1
3664	Binatang yang kecil sangat comel.	တိရစ္ဆာန်ငယ်လေးတွေက အရမ်းချစ်ဖို့ကောင်းတယ်။	\N		\N	vmod				438	1
3665	わたしは　動物が　大好きです。	ကျွန်မ(/ကျွန်တော်) တိရစ္ဆာန် အရမ်းချစ်တယ်။	\N		\N	vmod				438	1
3877	Semuanya ada sepuluh.	စုစုပေါင်း တစ်ဆယ် ရှိတယ်။	\N		\N	vmod				440	1
2781	Dari stesen ke sekolah jauh, jadi saya naik bas.	ဘူတာကနေ ကျောင်းကို ဝေးလို့ ဘတ်စ်ကား စီးတယ်။	\N		\N	vmod				441	1
3550	Saya perlu siapkan kerja ini sampai sepuluh hari bulan.	ဆယ်ရက်နေ့မကျော်ခင်ထိ ဒီ အလုပ်ကို မလုပ်လို့ မဖြစ်ဘူး။ (ဆယ်ရက်နေ့မတိုင်မီ ဒီအလုပ်ကို ပြီးအောင်လုပ်ရမယ်။)	\N		\N	vmod				442	1
3720	Saya kadang-kadang membeli barang di gerai sayur ini. 	ကျွန်မ(/ကျွန်တော်) တစ်ခါတလေ ဒီ ကုန်စိမ်းဆိုင်မှာ ဈေးဝယ်တယ်။	\N		\N	vmod				444	1
3721	Cik Kimura kadang-kadang membuat makanan malam.	မစ္စတာ ခိမုရ က တစ်ခါတလေတော့ ညစာချက်တယ်။	\N		\N	vmod				444	1
3613	Saya ingin tinggal di tempat yang senyap dan cantik.	ကျွန်မ(/ကျွန်တော်) တိတ်ဆိတ်ပြီး လှပတဲ့ နေရာမှာ နေချင်တယ်။	\N		\N	vmod				447	1
3614	Sini merupakan tempat yang sangat meriah.	ဒီနေရာက အလွန် စည်ကားတဲ့ နေရာ ဖြစ်တယ်။	\N		\N	vmod				447	1
3313	Tahun lepas adalah tahun yang baik.	မနှစ်က ကောင်းတဲ့နှစ် တစ်နှစ် ဖြစ်တယ်။	\N		\N	vmod				448	1
3756	Encik Lee nak minuman yang mana?	မစ္စတာ လီ ဘယ်သောက်စရာ(/ဘာသောက်စရာ) သောက်မလဲ။(မစ္စတာ လီ ဘာသောက်မလဲ။)	\N		\N	vmod				451	1
3757	Cik Kimura suka yang mana?	မစ္စတာ ခိမုရ ဘယ်တစ်ခုကို ကြိုက်လဲ။	\N		\N	vmod				451	1
2887	Jangan bercakap dengan orang di sebelah semasa kelas. 	စာသင်ချိန်မှာ ဘေးနားက လူနဲ့ စကားမပြောရဘူး။	\N		\N	vmod				454	1
2888	Kedai kopi itu ada di sebelah kedai buku.	အဲဒီ ကော်ဖီဆိုင်က စာအုပ်ဆိုင်ရဲ့ ဘေးနားမှာ ရှိတယ်။	\N		\N	vmod				454	1
3760	Kelas guru yang mana paling menarik?	ဘယ်ဆရာရဲ့ အတန်းက စိတ်ဝင်စားဖို့ အကောင်းဆုံးလဲ။	\N		\N	vmod				455	1
3761	Encik Hayashi orang yang mana?	ဘယ်သူက မစ္စတာ ဟယရှိ လဲ။	\N		\N	vmod				455	1
2957	Daging ayam murah tetapi daging lembu lebih sedap.	ကြက်သားက ဈေးပေါပေမယ့် အမဲသားက ပို စားလို့ကောင်းတယ်။	\N		\N	vmod				461	1
2815	Tidak boleh guna pisau kerana berbahaya.	အန္တရာယ်များလို့ ဓား မသုံးရဘူး။	\N		\N	vmod				466	1
2814	Masakan Perancis dimakan dengan menggunakan pisau dan garpu.	ပြင်သစ်ဟင်းလျာက ဓားနဲ့ခရင်းကို သုံးပြီး စားတယ်။	\N		\N	vmod				466	1
3814	Encik Tanaka boleh menyanyi sambil bermain gitar.	မစ္စတာ တာနာခါ က ဂီတာတီးရင်းနဲ့ သီချင်းဆိုတတ်တယ်။	\N		\N	vmod				469	1
3815	Saya makan nasi sambil menonton TV.	တီဗွီကြည့်ရင်း ထမင်းစားတယ်။	\N		\N	vmod				469	1
3690	Saya menangis apabila menonton filem.	ရုပ်ရှင်ကြည့်နေတုန်းက ငိုလိုက်ရတယ်။	\N		\N	vmod				470	1
3691	Adik prempuan menangis di dalam bilik.	အခန်းထဲမှာ ညီမလေး ငိုနေတယ်။	\N		\N	vmod				470	1
2891	Oleh sebab kehilangan dompet, saya pergi ke pondok polis.	ပိုက်ဆံအိတ် ပျောက်သွားလို့ ရဲစခန်းကို သွားမယ်။	\N		\N	vmod				471	1
2892	Saya kehilangan majalah yang dipinjam daripada Encik Matsui.	မစ္စတာ မာဆုအိ ဆီက ငှားလာတဲ့ မဂ္ဂဇင်း ပျောက်သွားပြီ။	\N		\N	vmod				471	1
3816	Saya membeli baju sejuk, skirt dan lain-lain di pusat membeli-belah semalam.	မနေ့က ကုန်တိုက်မှာ ဆွယ်တာတွေ စကတ်တွေ ဝယ်ခဲ့တယ်။	\N		\N	vmod				475	1
3817	Ada telur, sayur, buah, dan lain-lain di dalam peti sejuk.	ရေခဲသေတ္တာထဲမှာ ကြက်ဥတွေ ဟင်းသီးဟင်း ရွက်တွေနဲ့ သစ်သီးတွေရှိတယ်။	\N		\N	vmod				475	1
3538	Cik Kimura membuat tujuh biji kuih.	မစ္စတာ ခိမုရ က မုန့် ခုနစ်ခု လုပ်ခဲ့တယ်။	\N		\N	vmod				476	1
3548	Saya memindahkan wang seblum tujuh hari bulan.	ခုနစ်ရက်နေ့အရောက် ပိုက်ဆံလွှဲလိုက်မယ်။	\N		\N	vmod				478	1
3405	Saya beratur selama satu jam untuk menonton filem semalam.	မနေ့က ရုပ်ရှင်ကြည့်ဖို့ တစ်နာရီ တန်းစီခဲ့ရတယ်။	\N		\N	vmod				481	1
3404	Ramai orang beratur di depan restoran.	စားသောက်ဆိုင်ရှေ့မှာ လူတွေအများကြီး တန်းစီနေတယ်။	\N		\N	vmod				481	1
3402	Banyak buku tersusun di rak buku.	စာအုပ်စင်မှာ စာအုပ်တွေ အများကြီး စီထားတယ်။	\N		\N	vmod				482	1
3403	Saya menyusun pinggan di atas meja.	စားပွဲမှာ ပန်းကန်တွေကို စီမယ်။	\N		\N	vmod				482	1
3406	Saya ingin menjadi doktor apabila keluar dari universiti.	တက္ကသိုလ် ပြီးရင် သွားဆရာဝန် ဖြစ်ချင်တယ်။	\N		\N	vmod				483	1
3407	Apabila musim panas datang, akan menjadi panas.	နွေရောက်ရင် ပူလာမယ်။	\N		\N	vmod				483	1
3885	Di rumah Encik Tanaka ada dua buah kereta.	မစ္စတာ တာနာခါရဲ့ အိမ်မှာ ကား နှစ်စီး ရှိတယ်။	\N		\N	vmod				484	1
3520	Di sini bandar yang besar dan meriah.	ဒီမြို့က ကြီးပြီး စည်ကားတဲ့ မြို့ဖြစ်တယ်။	\N		\N	vmod				485	1
3521	Kelas sebelah sangat meriah.	ဘေးနားက စာသင်ခန်းက အရမ်း စည်ကားနေတယ်။	\N		\N	vmod				485	1
2953	Makan malam semalam adalah masakan daging.	မနေ့တုန်းက ညစာက အသားဟင်းနဲ့ ပါ။	\N		\N	vmod				486	1
2954	Saya lebih suka ikan daripada daging.	ကျွန်မ(/ကျွန်တော်) အသား ထက် ငါးကို ပိုကြိုက်တယ်။	\N		\N	vmod				486	1
3441	Ibu saya lahir pada dua puluh sembilan hari bulan November.	အမေ့ ကို ဆယ့်တစ်လပိုင်း နှစ်ဆယ့်ကိုးရက်နေ့မှာမွေးခဲ့တယ်။	\N		\N	vmod				488	1
3198	Saya menanggalkan baju kerana ingin mandi.	ရေချိုးခန်းဝင်မလို့ အင်္ကျီချွတ်မယ်။	\N		\N	vmod				494	1
3195	Apabila masuk ke dalam rumah di Jepun, kita menanggalkan kasut.	ဂျပန်မှာ အိမ်ထဲကိုဝင်တဲ့အခါ ဖိနပ်ချွတ်တယ်။	\N		\N	vmod				494	1
2981	Ini tali leher dari Itali.	ဒါ အီတလီက နက်ကတိုင်ပါ။	\N		\N	vmod				496	1
2754	Saya gosok gigi selepas makan nasi.	ထမင်းစားပြီးရင် သွားတိုက်တယ်။	\N		\N	vmod				505	1
3568	Saya masukkan tiga sudu gula dengan menggunakan sudu.	သကြားကို ဇွန်းနဲ့ သုံးခွက် ထည့်တယ်။	\N		\N	vmod				507	1
3569	Semalam saya minum dua gelas arak.	မနေ့က အရက် နှစ်ခွက် သောက်တယ်။	\N		\N	vmod				507	1
3570	Setiap pagi saya minum segelas susu.	မနက်တိုင်း နွားနို့  တစ်ခွက် သောက်တယ်။	\N		\N	vmod				507	1
3088	Saya menggunakan tempat abu rokok apabila merokok.	ဆေးလိပ်သောက်တဲ့အခါ ဆေးလိပ်ပြာခွက်ကို သုံးတယ်။	\N		\N	vmod				508	1
3089	Ada tempat abu rokok di atas meja.	စားပွဲပေါ်မှာ ဆေးလိပ်ပြာခွက် ရှိတယ်။	\N		\N	vmod				508	1
3196	Saya keluar dengan memakai kasut yang baru.	ဖိနပ်အသစ်စီးပြီး  အပြင်ထွက်မယ်။	\N		\N	vmod				511	1
3197	Cik Kimura memakai skirt yang comel.	မစ္စ ခိမုရ က ချစ်စရာကောင်းတဲ့ စကတ်လေးကို ဝတ်ထားတယ်။	\N		\N	vmod				511	1
2917	Selepas menyeberangi jambatan, akan ada taman.	တံတားကို ကူးရင် ချက်ချင်း ပန်းခြံ ရှိတယ်။(တံတားကူးကူးချင်းမှာ ပန်းခြံရှိတယ်။)	\N		\N	vmod				717	1
3398	Universiti akan bermula dari bulan April.	လေးလပိုင်းကနေ တက္ကသိုလ် စတယ်။	\N		\N	vmod				514	1
3399	Kelas akan bermula dari pukul sembilan pagi.	မနက် ကိုးနာရီကနေ အတန်း စတယ်။	\N		\N	vmod				514	1
3744	Saya akan membuat kerja rumah terlebih dahulu selepas balik rumah.	အိမ်ပြန်ရင် အရင်ဆုံး အိမ်စာ လုပ်မယ်။	\N		\N	vmod				515	1
3745	Awal bulan depan saya akan pulang ke negara asal.	နောက်လဆန်း နိုင်ငံကို ပြန်မယ်။	\N		\N	vmod				515	1
3556	Di Jepun arak boleh diminum apabila berumur dua puluh tahun.	ဂျပန်မှာ အသက် နှစ်ဆယ် ကစပြီး အရက် သောက်လို့ရတယ်။	\N		\N	vmod				520	1
3557	Adik lelaki saya akan berumur dua puluh tahun bulan depan.	ကျွန်မညီမ(/ကျွန်တော်ညီ) နောက်လဆို အသက် နှစ်ဆယ် ပြည့်မယ်။	\N		\N	vmod				520	1
3891	Di sini ada lapan keping setem.	ဒီမှာ လက်မှတ် ရှစ် စောင် ရှိတယ်။	\N		\N	vmod				522	1
3551	Dua puluh hari bulan ini akan ada ujian bahasa jepun.	ဒီလ နှစ်ဆယ်ရက်နေ့မှာ ဂျပန်စာ စာမေးပွဲ ရှိတယ်။	\N		\N	vmod				523	1
3672	Bunga ini merah dan cantik.	ဒီပန်း က နီပြီး လှနေတာပဲ။	\N		\N	vmod				725	1
3673	Cik Kimura suka bunga.	မစ္စ ခိမုရ က ပန်းကြိုက်တယ်။	\N		\N	vmod				725	1
3175	Saya mendengar cerita yang menarik daripada Encik Hayashi .	မစ္စတာ ဟယရှိ ဆီက စိတ်ဝင်စားစရာကောင်းတဲ့ စကားကို ကြားခဲ့တယ်။	\N		\N	vmod				525	1
3176	Encik Matsui sedang bercerita dengan Encik Kobayashi.	မစ္စတာ မဆုအိ က မစ္စတာ ဟယရှိ နဲ့ စကား ပြောနေတယ်။	\N		\N	vmod				525	1
2928	Saya rasa kereta api lebih cepat daripada bas untuk sampai ke sekolah.	ကျောင်းအထိဆို ဘတ်စ်ကားထက်စာရင် ရထား က ပိုမြန်တယ်လို့ ထင်တယ်။	\N		\N	vmod				716	1
2929	Encik Matsui berlari dengan cepat	မစ္စတာ မဆုအိ က အပြေးမြန်တယ်။	\N		\N	vmod				716	1
2792	Saya menampal setem pada sampul surat.	စာအိတ် မှာ တံဆိပ်ခေါင်း ကပ်တယ်။	\N		\N	vmod				529	1
3206	Hari ini saya akan makan malam bersama kawan.	ဒီနေ့ သူငယ်ချင်းနဲ့ ညစာစားမယ်။	\N		\N	vmod				537	1
3218	Makan malam hari ini adalah kari.	ဒီနေ့ ညစာကတော့ ကာရီ ဖြစ်ပါတယ်။	\N		\N	vmod				537	1
3913	B: Satu, dua, tiga, empat….	B ：တစ်၊နှစ်၊သုံး၊လေး…။	\N		\N	vmod				278	1
3802	Saya potong buah menjadi separuh.	အသီးကို ထက်ခြမ်း ခြမ်းတယ်။	\N		\N	vmod				538	1
3803	Saya makan roti separuh.	ပေါင်မုန့် တစ်ဝက် စားလိုက်တယ်။	\N		\N	vmod				538	1
3259	Di bahagian timur bandar ini semuanya hutan.	ဒီ မြို့ရဲ့ အရှေ့ဘက်က အားလုံး သစ်တောတွေပါ။	\N		\N	vmod				539	1
3571	Saya membeli tiga ekor ikan di pasar raya semalam	မနေ့က စူပါမားကက်မှာ ငါး သုံးကောင် ဝယ်ခဲ့တယ်။	\N		\N	vmod				540	1
3572	Ada dua ekor anjing di sana.	ဟိုမှာ ခွေးနှစ်ကောင်ရှိတယ်။	\N		\N	vmod				540	1
3573	Di rumah Encik Hayashi ada seekor kucing. 	မစ္စတာ ဟယရှိရဲ့ အိမ်မှာကြောင်တစ်ကောင်ရှိတယ်။	\N		\N	vmod				540	1
3016	Saya akan bermain piano pada konsert bulan depan.	မစ္စတာ ဟယရှိရဲ့ အိမ်မှာကြောင်တစ်ကောင်ရှိတယ်။	\N		\N	vmod				541	1
3499	Orang yang rendah itu Cik Kimura.	ဟို အရပ်ပုပုနဲ့လူက မစ္စတာ ခိမုရ ပါ။	\N		\N	vmod				542	1
3532	Setiap pagi saya makan sebiji telur.	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း ကြက်ဥ တစ်လုံး စားတယ်။	\N		\N	vmod				546	1
3610	Esok saya ada masa lapang, jadi saya akan bermain dengan kawan saya.	ကျွန်မ(/ကျွန်တော်) မနက်ဖန် အားလို့ သူငယ်ချင်းနဲ့ လျှောက်လည်မယ်။	\N		\N	vmod				549	1
3894	Bilik darjah sebelah muat seramai seratus orang.	ဘေးက စာသင်ခန်းမှာ အယောက်တစ်ရာ သွင်းမယ်။	\N		\N	vmod				550	1
3180	Saya boleh tulis hiragana tetapi saya masih belum boleh tulis katakana.	ဟီရဂန ရေးတတ်ပေမယ့် ခတခန တော့ မရေးတတ်သေးဘူး။	\N		\N	vmod				553	1
3448	Saya pergi ke kedai kopi bersama Encik Kimura pada waktu tengah hari semalam.	မနေ့ နေ့လယ်က မစ္စတာ ခိမုရ နဲ့ ကော်ဖီဆိုင် သွားတယ်။	\N		\N	vmod				554	1
3449	Setiap hari saya rehat selama satu jam pada waktu tengah hari .	နေ့တိုင်း နေ့လယ်ပိုင်းဆို တစ်နာရီ နားတယ်။	\N		\N	vmod				554	1
3214	Oleh sebab saya sibuk saya tidak dapat makan tengah hari.	အလုပ်များလို့ နေ့လယ်စာ မစားလိုက်ရဘူး။	\N		\N	vmod				555	1
3207	Saya selalu makan tengah hari di sini.	အမြဲတမ်း ဒီမှာ နေ့လယ်စာ စားတယ်။	\N		\N	vmod				555	1
3630	Tiada filem yang tinggal kerana sudah banyak gambar yang telah ditangkap.	ဓာတ်ပုံတွေ အများကြီးရိုက်လိုက်လို့ ဖလင် မရှိတော့ဘူး။	\N		\N	vmod				557	1
3631	Saya memasukkan filem ke dalam kamera.	ကင်မရာ ထဲကို ဖလင် ထည့်တယ်။	\N		\N	vmod				557	1
2759	Saya menulis nama pada sampul surat.	စာအိတ် မှာ နာမည်ကို ရေးတယ်။	\N		\N	vmod				558	1
2813	Saya menggunakan garpu apabila makan kek.	ကိတ်မုန့်စားတဲ့အခါ ခရင်းကို သုံးတယ်။	\N		\N	vmod				560	1
3043	Rasa sejuk kerana angin sedang bertiup.	လေတိုက် နေလို့ ချမ်းတယ်။	\N		\N	vmod				713	1
3044	Esok angin akan bertiup kuat.	မနက်ဖန် လေပြင်းတိုက် မယ်ဆိုပဲ။	\N		\N	vmod				713	1
3533	Saya meyusun dua buah pasu bunga di atas meja.	စားပွဲပေါ်မှာ ပန်းအိုး နှစ်လုံး စီထားမယ်။	\N		\N	vmod				562	1
2956	Saya tidak boleh makan daging babi.	ကျွန်မ(/ကျွန်တော်) ဝက်သား မစားဘူး။	\N		\N	vmod				563	1
3554	Esok saya dan Encik Kimura berdua akan ke kolam renang.	မနက်ဖန် မစ္စတာ ခိမုရ နဲ့ နှစ်ယောက်တည်း ရေကူးကန် သွားမယ်။	\N		\N	vmod				564	1
3555	Ada dua orang yang tidak dikenali di depan rumah.	အိမ်ရှေ့မှာ မျက်နှာစိမ်း နှစ်ယောက် ရှိတယ်။	\N		\N	vmod				564	1
3542	Encik Tanaka akan pergi ke luar negara pada dua hari bulan bulan depan.	မစ္စတာ တာနာခါ နောက်လ နှစ်ရက်နေ့မှာ နိုင်ငံခြား သွားမယ်။	\N		\N	vmod				565	1
3487	Pen ini besar.	ဒီ ဘောပင် က တုတ်တယ်။	\N		\N	vmod				566	1
3483	Ada pokok yang besar di taman.	ပန်းခြံမှာ သစ်ပင် တုတ်တုတ်ကြီးတွေ ရှိတယ်။	\N		\N	vmod				566	1
3678	Salji turun pada musim sejuk di Jepun.	ဂျပန်မှာ ဆောင်းတွင်း ဆို နှင်းကျတယ်။	\N		\N	vmod				567	1
3679	Oleh sebab musim sejuk sejuk, pemanas dipasang.	ဆောင်းတွင်းဆို ချမ်းလို့ အပူစက်(/အနွေးစက်) ဖွင့်တယ်။	\N		\N	vmod				567	1
2927	Saya tidak pandai melukis.	ကျွန်မ(/ကျွန်တော်) ပန်းချီဆွဲတာ ညံ့တယ်။	\N		\N	vmod				574	1
2924	Oleh sebab saya tidak pandai menyanyi, saya akan berlatih.	သီချင်း ညံ့လို့ အဆိုလေ့ကျင့်မလားလို့ စဉ်းစားနေတယ်။	\N		\N	vmod				574	1
3662	Semalam saya bermain dengan haiwan peliharaan.	မနေ့က အိမ်မွေးတိရစ္ဆာန် နဲ့ ကစားတယ်။	\N		\N	vmod				576	1
3663	Di rumah Encik Kobayashi ada haiwan peliharaan.	မစ္စတာ ခိုဘယရှိရဲ့ အိမ်မှာ အိမ်မွေးတိရစ္ဆာန် ရှိတယ်။	\N		\N	vmod				576	1
2853	Oleh sebab esok ada ujian, malam ini saya akan belajar.	မနက်ဖန် စာမေးပွဲရှိလို့ ဒီည စာဖတ်မယ်။	\N		\N	vmod				580	1
1356	Saya belajar semalam.	မနေ့တုန်းက ကျွန်မ(/ကျွန်တော်) စာဖတ်တယ်။	null		\N	vmod				\N	1
1675	Saya selalu belajar bersendirian.	အမြဲတမ်း တစ်ယောက်တည်း စာဖတ်နေတယ်။	null		\N	vmod				\N	1
3841	Bilik adik lelaki saya lebih kecil daripada bilik saya.	ကျွန်မ(/ကျွန်တော်) အခန်းထက် မောင်လေး(/ညီလေး)ရဲ့ အခန်းက ပိုကျဉ်းတယ်။	\N		\N	vmod				584	1
3842	Saya lebih suka besbol daripada bola sepak.	ဘောလုံးထက်စာရင် ဘေ့စ်ဘော ကို ပိုကြိုက်တယ်။	\N		\N	vmod				584	1
2784	Saya pakai topi apabila keluar pada hari panas.	ပူတဲ့နေ့ဆို ဦးထုပ် ဆောင်းပြီး အပြင်ထွက်တယ်။	\N		\N	vmod				585	1
3635	Jaket ini ada banyak poket, jadi senang diguna.	ဒီ အပေါ်ထပ် အင်္ကျီ မှာက အိတ်ကပ်တွေ အများကြီး ရှိလို့ အဆင်ပြေတယ်။	\N		\N	vmod				588	1
3636	Saya memasukkan duit ke dalam poket.	အိတ်ကပ်ထဲ ပိုက်ဆံထည့်တယ်။	\N		\N	vmod				588	1
3591	Benda yang saya paling nak sekarang adalah komputer baru.	အခုချိန်မှာ အလိုချင်ဆုံး အရာကတော့ ကွန်ပျူတာ အသစ် ပဲ။	\N		\N	vmod				590	1
3592	Saya nak kamus bahasa Jepun.	ကျွန်မ(/ကျွန်တော်) ဂျပန်စာ အဘိဓာန် လိုချင်တယ်။	\N		\N	vmod				590	1
3484	Oleh sebab saya berlari setiap pagi, saya sudah kurus sedikit.	မနက်တိုင်း ပြေးနေလို့ နည်းနည်းတော့ ပိန်သွားတယ်။	\N		\N	vmod				591	1
3485	Orang itu kakinya kurus dan panjang.	ဟိုလူရဲ့ ခြေထောက်က ပိန်ပြီး(/သွယ်ပြီး) ရှည်တယ်။	\N		\N	vmod				591	1
2967	Ada banyak deretan rak buku di perpustakaan.	စာကြည့်တိုက်မှာ စာအုပ်စင်တွေ အများကြီး တန်းစီနေတယ်။	\N		\N	vmod				595	1
2968	Kamus ada di rak buku sana.	အဘိဓာန် ဟိုက စာအုပ်စင်မှာရှိတယ်။	\N		\N	vmod				595	1
3419	Setiap hari Sabtu, saya berlatih bola sepak.	အပတ်စဉ် စနေနေ့တိုင်း ဘောလုံး လေ့ကျင့်တယ်။	\N		\N	vmod				599	1
3309	Setiap bulan saya menulis surat kepada kawan di luar negara.	လတိုင်း နိုင်ငံခြားက သူငယ်ချင်းဆီကို စာရေးတယ်။	\N		\N	vmod				600	1
3301	Setiap bulan saya deposit wang di bank.	လစဉ် ဘဏ်မှာ ငွေအပ်တယ်။	\N		\N	vmod				600	1
3322	Setiap tahun saya memberikan ibu hadiah hari jadi.	နှစ်တိုင်း အမေ့ကို မွေးနေ့လက်ဆောင် ပေးတယ်။	\N		\N	vmod				601	1
3312	Setiap tahun saya pergi melancong bersama keluarga.	နှစ်တိုင်း မိသားစုနဲ့ ခရီးထွက်တယ်။	\N		\N	vmod				601	1
3436	Setiap malam sebelum tidur, saya membaca buku.	ညတိုင်း မအိပ်ခင် စာအုပ်ဖတ်တယ်။	\N		\N	vmod				603	1
3437	Saya belajar bahasa Inggeris setiap malam selama dua jam.	ညတိုင်း နှစ်နာရီကြာလောက် အင်္ဂလိပ်စာကို လေ့လာတယ်။	\N		\N	vmod				603	1
3210	Masakan ini macam tidak sedap.	ဒီဟင်းက စားကောင်းမယ့်ပုံ မပေါ်ဘူး။	\N		\N	vmod				606	1
3211	Kedai itu murah tetapi tidak sedap.	ဟို(/အဲဒီ) ဆိုင်က ဈေးပေါပေမယ့် စားလို့မကောင်းဘူး။	\N		\N	vmod				606	1
3724	Para pelajar beratur secara lurus di koridor.	တပည့်တွေက အဝင်၀မှာ တန်းနေအောင် တန်းစီတယ်။	\N		\N	vmod				611	1
3725	Selepas keluar dari stesen, jalan terus ikut jalan itu.	ဘူတာကထွက်ပြီး ဟိုလမ်းကနေ တည့်တည့် သွားပါ။	\N		\N	vmod				611	1
3642	Saya menghisap rokok dengan menggunakan mancis. 	ယမ်းမီးခြစ် ကိုသုံးပြီး ဆေးလိပ် သောက်တယ်။	\N		\N	vmod				612	1
3643	Ada mancis di atas meja.	စားပွဲပေါ်မှာ မီးခြစ် ရှိတယ်။	\N		\N	vmod				612	1
3589	Di sana ada kotak yang berbentuk bulat.	ဟိုမှာ ဘူးဝိုင်းဝိုင်းလေး ရှိတယ်။	\N		\N	vmod				614	1
3590	Meja ini bulat.	ဒီ စားပွဲက ဝိုင်းတယ်။	\N		\N	vmod				614	1
3233	Selalu sebelum tidur saya menggosok gigi.	အမြဲတမ်း မအိပ်ခင် သွားတိုက်တယ်။	\N		\N	vmod				617	1
2870	Oleh sebab pensel ini selalu digunakan, ia sudah menjadi pendek.	အမြဲတမ်း ဒီခဲတံချည်းပဲသုံးနေလို့ တိုတောင်တိုသွားပြီ။	\N		\N	vmod				619	1
2823	Selepas minum arak, lebih baik minum air.	အရက်သောက်ပြီးတဲ့အခါ ရေသောက်ပေးရင် ကောင်းတယ်။	\N		\N	vmod				620	1
3543	Tiga hari bulan sehingga lima hari bulan Mei merupakan cuti bagi sekolah dan syarikat.	ငါးလပိုင်း သုံးရက် ကနေ ငါးလပိုင်း ငါးရက်နေ့ အထိ ကျောင်းတွေ ရုံးတွေပိတ် တယ်။ 	\N		\N	vmod				624	1
3534	Ada tiga jawapan bagi soalan ini.	ဒီ မေးခွန်းအတွက် အဖြေသုံးခု ရှိတယ်။	\N		\N	vmod				625	1
3241	Encik Yamada memakai tali leher berwarna hijau.	မစ္စတာ တာနာခါ က အစိမ်းရောင် နက်ကတိုင်ကို စည်းထားတယ်။	\N		\N	vmod				626	1
3225	Anjing itu telinganya besar.	ဟိုခွေးက နားရွက် ကြီးတယ်။(ဟိုခွေးရဲ့ နားရွက်က ကြီးတယ်။)	\N		\N	vmod				629	1
3547	Saya hantar bagasi di pejabat pos pada enam hari bulan.	ခြောက်ရက်နေ့က စာတိုက်ကနေ အထုပ် ပို့လိုက်တယ်။	\N		\N	vmod				632	1
3804	Sila buka tingkap di sebelah sana.	ဟိုဘက်က ပြတင်းပေါက်ကို ဖွင့်လိုက်ပါ။	\N		\N	vmod				633	1
3805	Hospital ada di sebalik stesen.	ဆေးရုံက ဘူတာရဲ့ အခြားတစ်ဖက်(/ဟိုဘက်)မှာ။	\N		\N	vmod				633	1
3537	Ada enam buah kotak diletakkan di dalam bilik.	အခန်းထဲမှာ သေတ္တာ ခြောက်လုံးရှိတယ်။	\N		\N	vmod				635	1
3650	Sekarang jalan baru sudah siap, jadi kampung ini telah menjadi selesa.	လမ်းအသစ် ဖောက်ပြီးသွားလို့ ရွာလည်း အဆင်ပြေသွားပြီ။	\N		\N	vmod				636	1
3651	Kampung ini senyap dan cantik.	ဒီရွာက တိတ်ဆိတ်ပြီး လှပ တယ်။	\N		\N	vmod				636	1
3224	Penglihatan Encik Yamada teruk, jadi beliau memakai cermin mata.	မစ္စတာ ရာမဒ က မျက်စိမကောင်းလို့ မျက်မှန်တပ်ထားတယ်။	\N		\N	vmod				637	1
3223	Mata saya letih kerana membaca buku di tempat yang gelap.	အမှောင်ခန်းထဲမှာ စာအုပ်ဖတ်လိုက်တာ မျက်စိ ညောင်းသွားတယ်။	\N		\N	vmod				637	1
2788	Orang yang pakai cermin mata itu Encik Matsui.	ဟို မျက်မှန်တပ်ထားတဲ့ လူက မစ္စတာ မဆုအိ ပါ။	\N		\N	vmod				639	1
3412	Saya akan ke bank untuk memindahkan wang petang hari Khamis ini.	ကြာသပတေးနေ့ နေ့လယ်ပိုင်းကျရင် ဘဏ်မှာ ငွေသွား သွင်းမယ်။	\N		\N	vmod				641	1
3738	Saya nak jadi lebih pandai dalam bahasa Inggeris.	ကျွန်မ(/ကျွန်တော်) အင်္ဂလိပ်စာ ဒီထက်ပို တော်ချင်တယ်။	\N		\N	vmod				644	1
3739	Saya membeli baju yang lebih murah.	ဈေးပိုပေါတဲ့ အဝတ်အစား ကို၀ယ်မယ်။	\N		\N	vmod				644	1
3611	Jangan gunakan benda yang ada di sana.	အဲဒီမှာ ရှိတဲ့ ပစ္စည်းတွေကို မသုံးရဘူး။	\N		\N	vmod				645	1
3612	Cik Kimura suka benda yang comel.	မစ္စ ခိမုရ က ချစ်စရာကောင်းတဲ့ ပစ္စည်းလေးတွေဆို အရမ်းသဘောကျတယ်။	\N		\N	vmod				645	1
3844	Kadang-kadang saya pergi ke kedai buku sana.	ကျွန်မ(/ကျွန်တော်) တစ်ခါတလေ အဲဒီက စာအုပ်ဆိုင်ကို သွားတယ်။	\N		\N	vmod				648	1
3845	Mak cik saya bekerja di kedai bunga.	ကျွန်မ(/ကျွန်တော်) အဒေါ် က ပန်းဆိုင်မှာ အလုပ်လုပ် နေတယ်။	\N		\N	vmod				648	1
2951	Saya membeli buah dan sayur di gerai sayur.	ကျွန်မ(/ကျွန်တော်) သစ်သီးတို့ ဟင်းသီးဟင်းရွက်တို့ ကို ဟင်းသီးဟင်းရွက်ဆိုင်မှာ ဝယ်တယ်။	\N		\N	vmod				649	1
2952	Gerai sayur lebih murah daripada pasar raya.	စူပါမားကက် ထက်စာရင် ကုန်စိမ်းဆိုင်က ဈေးပေါ(/ဈေးချို)တယ်။	\N		\N	vmod				649	1
2959	Ada sayur dan telur di dalam peti sejuk.	ရေခဲသေတ္တာထဲမှာ ဟင်းသီးဟင်းရွက် နဲ့ ကြက်ဥ ရှိတယ်။	\N		\N	vmod				650	1
2960	Potong sayur, kemudian basuh.	ဟင်းရွက်တွေကို လှီးပြီး ဆေးမယ်။	\N		\N	vmod				650	1
2861	Ujian semalam mudah.	မနေ့က စာမေးပွဲက လွယ်တယ်။	\N		\N	vmod				651	1
3539	Saya mesti membeli lapan buah cenderamata.	ကျွန်မ(/ကျွန်တော်) ခရီးအပြန်လက်ဆောင် ရှစ်ခု ဝယ်ရမယ်။	\N		\N	vmod				655	1
3450	Saya mesti siapkan kerja ini sampai petang.	ညနေမစောင်းခင် ဒီ အလုပ်ကို မလုပ်လို့ မဖြစ်ဘူး။	\N		\N	vmod				658	1
3451	Saya pergi berjalan-jalan ke taman pada waktu petang.	ညနေ ပန်းခြံကို လမ်းလျှောက်ဖို့ သွားမယ်။(ညနေ ပန်းခြံမှာ လမ်းသွားလျှောက်မယ်။)	\N		\N	vmod				658	1
2756	Pejabat pos ada di dekat stesen.	စာတိုက်က ဘူတာဘေးမှာ ရှိတယ်။	\N		\N	vmod				660	1
3431	Malam tadi saya penat, jadi saya tidur awal.	မနေ့ညက ပင်ပန်းလို့ အစောကြီးအိပ်တယ်။	\N		\N	vmod				661	1
3432	Malam tadi, saya dan Cik Kimura pergi makan malam.	မနေ့ညက မစ္စတာ ခိမုရနဲ့ ညစာ သွားစားတယ်။	\N		\N	vmod				661	1
3607	Di sini adalah tempat sangat terkenal di Jepun.	ဒီနေရာက ဂျပန်မှာ အရမ်း နာမည်အကြီးတဲ့ နေရာ။	\N		\N	vmod				662	1
3608	Universiti ini lama dan terkenal.	ဒီ တက္ကသိုလ်က ရှေးကျပြီး နာမည်ကြီးတယ်။	\N		\N	vmod				662	1
3051	Saya tidak keluar pada hari ada salji.	နှင်းကျတဲ့နေ့ဆို အပြင်မထွက်ဘူး။	\N		\N	vmod				663	1
2068	Kalau salji turun pun, saya tetap akan  ke sekolah.	နှင်းကျလည်း ကျောင်းသွားတယ်။	null		\N	vmod				\N	1
3737	Oleh sebab kaki sakit, saya jalan perlahan-lahan.	ခြေထောက်နာလို့  ဖြည်းဖြည်းလျှောက်မယ်။	\N		\N	vmod				664	1
3736	Sila cakap secara lebih perlahan-lahan.	ဒီထက် ပိုပြီး  ဖြည်းဖြည်းပြောပေးပါ။	\N		\N	vmod				664	1
3546	Gerai sayur ini menjual dengan harga murah pada lapan hari bulan setiap bulan. 	ဒီကုန်စိမ်းဆိုင်က လတိုင်း ရှစ်ရက်နေ့ဆို ဈေးပေါတယ်။(ဒီကုန်စိမ်းဆိုင်က ရှစ်ရက်နေ့တိုင်း ဈေးချတယ်။)	\N		\N	vmod				665	1
3186	Saya beli pakaian Barat yang baru di pusat membeli-belah.	ကုန်တိုက်မှာ အဝတ်အစား အသစ် ကို ဝယ်တယ်။	\N		\N	vmod				666	1
3544	Saya perlu menulis karangan dalam bahasa Inggeris sampai empat hari bulan.	လေးရက်နေ့အပြီး အင်္ဂလိပ်လို စာစီစာကုံး မရေးလို့ မဖြစ်ဘူး။	\N		\N	vmod				669	1
3388	Cikgu memanggil nama Encik Yamada.	ဆရာက မစ္စတာ ရာမဒရဲ့ နာမည်ကို ခေါ်လိုက်တယ်။	\N		\N	vmod				671	1
3124	Badan saya lemah, jadi saya tidak boleh bersukan.	ကိုယ်ခံအားနည်းလို့(/ကိုယ်ခံအားမကောင်းလို့ )အားကစား လုပ်လို့မရဘူး။	\N		\N	vmod				674	1
2771	Saya dengar berita di radio. 	ရေဒီယိုနဲ့ သတင်း နားထောင်တယ်။	\N		\N	vmod				678	1
2772	Kita boleh dengar lagu dan juga radio menggunakan pemain radio kaset.	ရေဒီယိုကက်ဆက် က ရေဒီယိုရော သီချင်းရော နားထောင်လို့ ရတယ်။	\N		\N	vmod				679	1
3262	Ibu bapa saya ada di luar negara sekarang.	အခု ကျွန်မ(/ကျွန်တော်) မိဘတွေ  နိုင်ငံခြားမှာ နေတယ်။	\N		\N	vmod				682	1
2935	Saya fikir ingin melancong ke luar negara tahun depan.	နောင်နှစ်ကျရင် နိုင်ငံခြားခရီးသွားမလို့ စိတ်ကူးနေတယ်။	\N		\N	vmod				685	1
3882	Di sini suhunya sifar, jadi sangat sejuk.	ဒီမှာ သုံညဒီဂရီမို့လို့ အရမ်း ချမ်းတယ်။	\N		\N	vmod				686	1
2769	Tiada apa-apa di dalam peti sejuk.	ရေခဲသေတ္တာထဲမှာ ဘာမှ မရှိဘူး။	\N		\N	vmod				687	1
2860	Kalau banyak berlatih, awak akan pandai bahasa Jepun.	များများ လေ့ကျင့်ရင် ဂျပန်စကား ကျွမ်းလာမယ်။	\N		\N	vmod				691	1
2844	Saya membersihkan bahagian pintu masuk rumah dan juga koridor.	အဝင်၀ နဲ့ စင်္ကြံ ကိုလည်း သန့်ရှင်းရေး လုပ်မယ်။	\N		\N	vmod				692	1
3889	Saya menyusun enam keping pinggan di atas meja.	စားပွဲပေါ်မှာ ပန်းကန် ခြောက်ချပ် စီမယ်။	\N		\N	vmod				693	1
2097	Adik perempuan saya membuat bekal untuk ayah.	ညီမလေးက အဖေ့ကို ထမင်းဘူး  ထည့်ပေးတယ်။	null		\N	vmod				\N	1
1728	Boleh makan bekal di dalam bilik ini juga.	ဒီ အခန်းထဲမှာ ထမင်းဘူး  ဖွင့်စားလည်းရတယ်။(ဒီ အခန်းထဲမှာ ထမင်းစား လည်းရတယ်။)	null		\N	vmod				\N	1
1556	Mari kita duduk di sana dan makan bekal.	ဟိုမှာ ထိုင်ပြီး ထမင်းဘူး စားရအောင်။(ထမင်းဘူးတွေ ဟိုနားမှာ ထိုင်စားရအောင်။)	null		\N	vmod				\N	1
2919	Saya berjalan-jalan setiap pagi.	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း လမ်းလျှောက်တယ်။	\N		\N	vmod				718	1
3281	Saya ada kawan orang Thailand.	ကျွန်မ(/ကျွန်တော်)မှာ ထိုင်းလူမျိုး သူငယ်ချင်း ရှိတယ်။	\N		\N	vmod				709	1
2775	Minggu depan saya akan pergi ke pejabat hartanah dan mencari bilik yang baru.	နောက်အပတ် အိမ်ခြံမြေဝန်ဆောင်မှုရုံးခန်း သွားပြီး အိမ်ခန်းအသစ် ရှာမယ်။(နောက်အပတ် အိမ်ခြံမြေဝန်ဆောင်မှုရုံးခန်း မှာ အိမ်ခန်းအသစ်သွား ရှာမယ်။)	\N		\N	vmod				719	1
2817	Saya akan guna pinggan baru.	ပန်းကန်ပြားအသစ်ကို သုံးမယ်။	\N		\N	vmod				720	1
2811	Saya tidak minum banyak arak.	ကျွန်မ(/ကျွန်တော်) အရက် သိပ်မသောက်ဘူး။	\N		\N	vmod				721	1
2865	Saya ingin memotong rambut di salon kecantikan pada minggu depan.	နောက်အပတ် အလှပြင်ဆိုင်မှာ ဆံပင်သွား ညှပ်မလို့ စိတ်ကူးနေတယ်။	\N		\N	vmod				722	1
3848	Jangan cakap kepada orang lain.	တခြားလူနဲ့ (/သူများနဲ့)စကားမပြောရဘူး။	\N		\N	vmod				726	1
3849	Ada benda lain yang awak nak?	တခြား လိုချင်တဲ့ ပစ္စည်း ရှိသေးလား။(တခြား ဘာပစ္စည်း လိုချင် သေးလဲ။)	\N		\N	vmod				726	1
2962	Kereta mahal tetapi berguna.	ကား က ဈေးကြီးပေမယ့် အဆင်ပြေတယ်။	\N		\N	vmod				729	1
1418	Beg ini mahal.	ဒီ အိတ်က ဈေးကြီးတယ်။(ဒီ အိတ်ကို ဈေးကြီးကြီး ပေးခဲ့ရတယ်။)	null		\N	vmod				\N	1
3714	Hari ini sangat seronok.	ဒီနေ့ အရမ်းပျော်ခဲ့တယ်။	\N		\N	vmod				730	1
3715	Filem ini sangat seronok.	ဒီ ရုပ်ရှင်က အရမ်း စိတ်ဝင်စားဖို့ ကောင်းတယ်။	\N		\N	vmod				730	1
3740	Awak menulis karangan ini dengan sangat baik.	ဒီ စာစီစာကုံးက အရေးအသား တော်တော် ကောင်းတယ်။	\N		\N	vmod				733	1
3741	Saya berjaya menjawab ujian semalam dengan baik.	မနေ့က စာမေးပွဲ ကောင်းကောင်း ဖြေနိုင်တယ်။	\N		\N	vmod				733	1
3887	"4" dibaca sebagai "empat".. 	ဂျပန်လို “လေး”ကို“ယွန်း”လို့ ဖတ်တယ်။	\N		\N	vmod				735	1
3914	A: Ada berapa?	A ：ဘယ်နှခု ရှိလဲ။	\N		\N	vmod				278	1
3915	Ada tujuh biji telur di dalam peti sejuk.	ရေခဲသေတ္တာထဲမှာ ကြက်ဥ ခုနစ်လုံး ရှိတယ်။	\N		\N	vmod				737	1
3890	Cuaca akan beransur panas apabila masuk bulan tujuh.	ခုနစ်လပိုင်းရောက်ရင် တဖြည်းဖြည်း ပူလာမယ်။	\N		\N	vmod				287	1
3916	Saya pergi ke syarikat setiap hari pada pukul sembilan pagi.	မနက်တိုင်း ကိုးနာရီမှာ ကုမ္ပဏီ သွားတယ်။	\N		\N	vmod				0	1
3892	Adik lelaki saya berumur sembilan tahun.	ကျွန်မ(/ကျွန်တော်) မောင်လေး(/ညီလေး)က ကိုးနှစ်ပါ။/ကျွန်မ(/ကျွန်တော်) မောင်လေး(/ညီလေး)က ကိုးနှစ် ရှိပြီ။	\N		\N	vmod				204	1
3579	Jarak daripada stesen ke perpustakaan adalah dua kilometer.	ဘူတာကနေ စာကြည့်တိုက် အထိ နှစ် ကီလိုမီတာ ရှိတယ်။	\N		\N	vmod				742	1
3580	Saya berlari setiap pagi sebanyak tiga kilometer.	ကျွန်မ(/ကျွန်တော်) မနက်တိုင်း သုံး ကီလိုမီတာ ပြေးတယ်။	\N		\N	vmod				742	1
3574	Saya selalu membawa tiga batang pensel ke sekolah.	ကျောင်းကို အမြဲတမ်း ခဲတံ သုံး ချောင်းယူ သွားတယ်။	\N		\N	vmod				744	1
3575	Ada dua batang pokok di halaman rumah.	အိမ်က ခြံထဲမှာ သစ်ပင် နှစ်ပင် ရှိတယ်။	\N		\N	vmod				744	1
3576	Saya makan nasi dan menghisap sebatang rokok.	ထမင်းစားပြီး ဆေးလိပ် တစ်လိပ် သောက်တယ်။	\N		\N	vmod				744	1
3843	Saya potong rambut tiga hari yang lepas.	ရှေ့သုံးရက် က ဆံပင် ညှပ်ခဲ့တယ်။	\N		\N	vmod				745	1
3822	Saya mandi sebelum tidur.	မအိပ်ခင် ရေချိုးတယ်။	\N		\N	vmod				745	1
3463	Dari rumah ke sekolah mengambil masa satu jam dengan kereta api.	အိမ်ကနေ ကျောင်းအထိ ရထားနဲ့ တစ်နာရီ ကြာတယ်။	\N		\N	vmod				746	1
3464	Saya tidur selama lapan jam semalam.	မနေ့က ရှစ်နာရီကြာ အိပ်တယ်။	\N		\N	vmod				746	1
1334	 Pukul sepuluh lima puluh satu minit.	ဆယ်နာရီ ငါးဆယ့်တစ်မိနစ် ပါ။	null		\N	vmod				\N	1
1333	Pukul berapa sekarang? 	အခု ဘယ်နှနာရီ ဘယ်နှမိနစ် ရှိပြီလဲ။(အခု ဘယ်နှနာရီလဲ။)	null		\N	vmod				\N	1
3354	Saya menelefon rumah tetapi tiada sesiapa di rumah.	အိမ်ကို ဖုန်းဆက်ပေမယ့် ဘယ်သူမှ မရှိဘူး။	\N		\N	vmod				753	1
3355	Saya akan menelefon kawan saya malam ini.	ဒီည သူငယ်ချင်းဆီ ဖုန်းဆက်မယ်။	\N		\N	vmod				753	1
3181	Ayat ini pendek, jadi senang untuk membacanya.	ဒီ စာကြောင်းက တိုလို့ ဖတ်ရလွယ်တယ်။(ဒီ စာကြောင်းက တိုတိုလေးဆိုတော့ ဖတ်ရလွယ်တယ်။)	\N		\N	vmod				756	1
1449	Saya sakit tekak sejak semalam.	ကျွန်မ(/ကျွန်တော်) မနေ့ကတည်းက လည်ချောင်း နာနေတယ်။	null		\N	vmod				\N	1
2986	Saya tidak membuat apa-apa  pada hari cuti minggu lepas.	ရှေ့တစ်ပတ် ပိတ်တုန်းက ဘာမှမလုပ်ဖြစ်ဘူး။	\N		\N	vmod				760	1
1398	Kami akan membuat majlis pada hari jadi Encik Yamada	မစ္စတာ ရာမဒ ရဲ့ မွေးနေ့မှာ ပါတီ လုပ်မယ်။/မစ္စတာ ရာမဒ ရဲ့ မွေးနေ့ကျရင် ပါတီ လုပ်မယ်။	null		\N	vmod				\N	1
3070	Tukang gunting itu kurus dan cantik.	ဟို မိတ်ကပ်ဆရာက သေးသွယ်ပြီး လှတယ်။	\N		\N	vmod				762	1
3071	Saya ingin menjadi tukang gunting selepas keluar dari sekolah.	ကျောင်းပြီးရင် မိတ်ကပ်ဆရာ လုပ်မယ်။	\N		\N	vmod				762	1
3639	Tiada syampu di dalam bilik mandi.	ရေချိုးခန်းထဲမှာ ခေါင်းလျှော်ရည် မရှိဘူး။	\N		\N	vmod				763	1
3056	Saya bersyampu dulu sebelum potong rambut.	ဆံပင် မညှပ်ခင် ခေါင်းအရင် လျှော်တယ်။	\N		\N	vmod				763	1
3059	Saya tunjukkan tiket kepada pekerja stesen.	ကျွန်မ(/ကျွန်တော်) ဘူတာဝန်ထမ်းကို လက်မှတ်ပြလိုက်တယ်။	\N		\N	vmod				765	1
3077	Saya memberitahu nombor telefon Encik Kimura kepada kawan.	သူငယ်ချင်းကို မစ္စတာ ခိမုရရဲ့ ဖုန်းနံပါတ် ပေးလိုက်တယ်။	\N		\N	vmod				767	1
3080	Tolong hubungi syarikat melalui telefon.	ကုမ္ပဏီကို ဖုန်းနဲ့ ဆက်သွယ်လိုက်ပါ။	\N		\N	vmod				769	1
3081	Saya akan hubungi sebaik sahaja saya tiba di rumah.	အိမ်ရောက်ရင် ဆက်သွယ်(/အကြောင်းကြား)လိုက်မယ်။	\N		\N	vmod				769	1
3076	Saya mendengar berita di radio setiap hari.	နေ့တိုင်း ရေဒီယိုနဲ့ သတင်းနားထောင်တယ်။	\N		\N	vmod				771	1
3084	Sewa rumah di flat ini mahal.	ဒီ အိမ်ခန်းက အိမ်လခ ဈေးကြီးတယ်။	\N		\N	vmod				772	1
3087	Saya tidak jumpa kunci saya, jadi saya mencarinya di dalam beg.	သော့ မတွေ့လို့ အိတ်ထဲကို ရှာတယ်။	\N		\N	vmod				773	1
3086	Saya akan mencari bilik yang lebih murah.	ပိုပြီး ဈေးသက်သာတဲ့ အခန်းကို ရှာမလို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				773	1
3091	Saya selalu makan menu set ini untuk makan tengah hari.	နေ့လယ်စာဆို အမြဲတမ်း ဒီ ဆက်မီနျူး ကို စားတယ်။	\N		\N	vmod				775	1
3092	Menu set di kantin itu murah dan sedap.	အဲဒီ စားသောက်ဆိုင်က ဆက်မီနျူးက ဈေးသက်သာပြီး စားလို့ကောင်းတယ်။	\N		\N	vmod				775	1
3095	Saya minum kopi tanpa susu.	ကျွန်မ(/ကျွန်တော်) ကော်ဖီကို နို့ မထည့်ဘဲ သောက်တယ်။	\N		\N	vmod				776	1
3096	Setiap pagi saya makan roti dan minum susu.	မနက်တိုင်း ပေါင်မုန့်စားပြီး နွားနို့ သောက်တယ်။	\N		\N	vmod				776	1
3097	Bahagian stoking ada di tingkat satu.	ခြေအိတ် အရောင်းကောင်တာ က တစ်ထပ် မှာ ရှိတယ်။	\N		\N	vmod				780	1
3103	Hantar melalui udara lebih cepat sampai daripada melalui laut.	သင်္ဘောလိုင်း ထက်စာရင် လေယာဉ်နဲ့ပို့တာက မြန်မြန် ရောက်တယ်။ 	\N		\N	vmod				783	1
3102	Kalau hantar melalui laut mengambil masa tetapi murah.	ရေကြောင်းလိုင်းနဲ့ပို့တာ က အချိန်ကြာပေမယ့် ဈေးသက်သာတယ်။	\N		\N	vmod				784	1
3105	Kerana kirim melalui udara, sedikit mahal.	လေကြောင်းလိုင်းနဲ့ ပို့လိုက်လို့ နည်းနည်း ဈေးများတယ်။	\N		\N	vmod				785	1
3104	Semalam saya mengirim bagasi kepada ibu.	မနေ့က အမေ့ဆီ အထုပ်(/ပစ္စည်း) ပို့လိုက်တယ်။	\N		\N	vmod				785	1
3106	Saya tak nak  pakai sut kerana musim panas panas.	နွေရာသီဆို ပူလို့ အနောက်တိုင်းဝတ်စုံ မဝတ်ချင်ဘူး။	\N		\N	vmod				786	1
3107	会社へ　行く　とき、　スーツを　着ます。	ကုမ္ပဏီသွားတဲ့အခါ အနောက်တိုင်းဝတ်စုံဝတ်တယ်။	\N		\N	vmod				786	1
3110	Cik Kimura adalah pelajar tetapi Encik Tanaka adalah pekerja syarikat.	မစ္စတာ ခိမုရ ကကျောင်းသား ဖြစ်ပြီး မစ္စတာ တာနာခါ ကတော့ ကုမ္ပ⁠ဏီဝန်ထမ်း ဖြစ်ပါတယ်။	\N		\N	vmod				787	1
3116	Orang Jepun makan nasi menggunakan penyepit. 	ဂျပန်လူမျိုးတွေက ထမင်းစားတဲ့အခါ တူကို သုံးတယ်။(ဂျပန်လူမျိုးတွေက တူနဲ့ ထမင်းစားတယ်။)	\N		\N	vmod				789	1
3137	Ayah saya seorang pegawai bank.	ကျွန်မ(/ကျွန်တော်) အဖေက ဘဏ်ဝန်ထမ်းပါ။	\N		\N	vmod				792	1
3138	Pegawai bank di kaunter ramai wanita.	ကောင်တာမှာ ရှိတဲ့ ဘဏ်ဝန်ထမ်းတွေက မိန်းကလေးတွေ များတယ်။	\N		\N	vmod				793	1
3139	Saya membuat pemindahan wang di kaunter.	ဘဏ်ကောင်တာကနေ ငွေလွှဲမယ်။	\N		\N	vmod				793	1
3140	Saya pergi ke bank dan membuat pemindahan wang.	ဘဏ်ကိုသွားပြီး ငွေလွှဲမယ်။(ဘဏ်မှာ ငွေ သွားလွှဲမယ်။)	\N		\N	vmod				794	1
3531	Saya balik ke rumah kerana sudah lewat.	နောက်ကျ နေပြီမို့ အိမ်ပြန်မယ်။ (နောက်ကျနေပြီ။အိမ်ပြန်တော့မယ်။)	\N		\N	vmod				798	1
3530	Saya bangun lewat hari ini kerana semalam penat.	မနေ့က ပင်ပန်းသွားလို့ မနက်က နောက်ကျမှ အိပ်ရာထတယ်။	\N		\N	vmod				798	1
3367	Sebuah kedai buku besar siap dibina di depan universiti.	တက္ကသိုလ်ရှေ့မှာ စာအုပ်ဆိုင်ကြီးတစ်ဆိုင် လာဖွင့်ထားတယ်။	\N		\N	vmod				799	1
3163	Saya memakai tali leher kerana akan berjumpa dengan orang untuk kerja .	အလုပ်ကိစ္စအတွက်နဲ့ ဧည့်သည်နဲ့ တွေ့ရမှာမို့ နက်ကတိုင် စည်းရမယ်။	\N		\N	vmod				800	1
3389	Oleh sebab saya bekerja lama, saya berehat sekejap.	နာရီအတော် ကြာကြာ အလုပ်လုပ်ခဲ့ရလို့ နည်းနည်း အနားယူလိုက်တယ်။	\N		\N	vmod				801	1
3201	Masakan ini kita makan tanpa membubuh apa-apa.	ဒီဟင်းက ဘာမှ မဆမ်းဘဲ စားရတယ်။	\N		\N	vmod				803	1
3501	Saya perlu siapkan kerja ini dalam masa yang singkat.	အချိန်တိုတို အတွင်း ဒီအလုပ်ကို မလုပ်လုပ်လို့ မရဘူး။	\N		\N	vmod				804	1
3502	Satu hari itu sangat singkat.	နေ့တစ်နေ့ဆိုတာ အရမ်း တိုတယ်။	\N		\N	vmod				804	1
3498	Waktu kelas semalam sangat panjang.	မနေ့က အတန်းက အချိန်ရှည်တယ်။	\N		\N	vmod				805	1
3497	Malam ini saya akan cuba belajar dengan masa yang panjang.	ဒီညတော့ အချိန်ရှည်ရှည်လေး(/အချိန်နည်းနည်းကြာကြာလေး) စာဖတ်မယ်လို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				805	1
3154	Pemandu pelancong memberitahu tentang bandar ini.	ဧည့်လမ်းညွှန် က မြို့ရဲ့ အကြောင်းကို ပြောပြပေးတယ်။	\N		\N	vmod				808	1
3155	Kawan saya bekerja sebagai pemandu pelancong.	ကျွန်မ(/ကျွန်တော်)သူငယ်ချင်းက ဧည့်လမ်းညွှန် လုပ်နေတယ်။	\N		\N	vmod				808	1
3156	Oleh kerana tiada kereta api, kami bermalam di rumah kawan.	အပြန်ရထား မရှိလို့ သူငယ်ချင်း အိမ်မှာ တည်းလိုက်တယ်။	\N		\N	vmod				809	1
3157	Malam ini saya akan bermalam di hotel.	ဒီည ဟိုတယ်မှာ တည်းမယ်။	\N		\N	vmod				809	1
3158	Saya menerima cenderamata daripada kawan yang pergi melancong.	သူငယ်ချင်းဆီက ခရီးအပြန်လက်ဆောင် ရခဲ့တယ်။	\N		\N	vmod				810	1
3159	Saya membelikan cenderamata untuk keluarga.	မိသားစုအတွက် အပြန်လက်ဆောင် ဝယ်မယ်။	\N		\N	vmod				810	1
3268	Suami Puan Kobayashi bekerja di hospital.	မစ္စ ဟယရှိရဲ့ အမျိုးသားက ဆေးရုံမှာ အလုပ်လုပ်နေတယ်။	\N		\N	vmod				814	1
3269	Adik perempuan Encik Yamada rendah dan comel.	မစ္စတာ ရာမဒ ရဲ့ ညီမလေးက အရပ်က ပုပုလေးနဲ့ ချစ်စရာကောင်းတယ်။	\N		\N	vmod				815	1
3270	Adik lelaki Encik Kobayashi bermain bola sepak.	မစ္စတာ ဟယရှိ ရဲ့ ညီလေးက ဘောလုံး ကစားနေတယ်။	\N		\N	vmod				816	1
3341	Saya membuka suis komputer.	ကွန်ပျူတာ ခလုတ်ကို ဖွင့်တယ်။	\N		\N	vmod				817	1
3340	Saya membuka suis dan memasang lampu.	ခလုတ်ကို ဖွင့်ပြီး မီးထွန်းတယ်။	\N		\N	vmod				817	1
3358	Saya menutup suis komputer.	ကွန်ပျုတာ ခလုတ်ကို ပိတ်တယ်။	\N		\N	vmod				818	1
2232	Tiada sesiapa datang hari ini.	ဒီနေ့ ဘယ်သူမှ မလာဘူး။	null		\N	vmod				\N	1
1638	Saya datang ke Jepun pada lima belas hari bulan Mac tahun ini .	ဒီနှစ် သုံးလပိုင်းဆယ်ငါးရက်နေ့တုန်းက ဂျပန်ကို လာတယ်။	null		\N	vmod				\N	1
2220	Musim bunga sudah datang tetapi masih belum panas lagi.	နွေဦးရာသီထဲ ဝင်လာပေမယ့် နွေးမလာသေးဘူး။	null		\N	vmod				\N	1
3654	Saya menerima surat daripada ibu yang berada di negara asal. 	အမိနိုင်ငံမှာ ရှိတဲ့ အမေဆီက စာလာတယ်။	\N		\N	vmod				820	1
3655	Saya akan pulang ke negara asal semasa cuti musim panas.	နွေရာသီပိတ်ရက် မှာ အမိနိုင်ငံ ကို ပြန်မယ်။	\N		\N	vmod				820	1
3701	Nanti jom kita makan tengah hari bersama-sama.	နောက်မှ နေ့လယ်စာ အတူတူ စားကြတာပေါ့။	\N		\N	vmod				821	1
3469	Nanti saya akan ke perpustakaan untuk memulangkan buku.	တော်ကြာကျရင် စာကြည့်တိုက်မှာ စာအုပ် သွားအပ်မယ်။	\N		\N	vmod				25	1
3751	Dengan apa awak pergi ke syarikat?	ဘာနဲ့ ကုမ္ပဏီကို သွားမလဲ။	\N		\N	vmod				822	1
1860	Makanan apa yang awak suka?	ဘာ အစားအစာ ကြိုက်သလဲ။	null		\N	vmod				\N	1
1492	Encik Tanaka sekarang ini tengah buat apa?	မစ္စတာ တာနာခါ အခု ဘာလုပ်နေလဲ။	null		\N	vmod				\N	1
3866	Lebih baik berhenti baca buku di tempat yang gelap.	မှောင်တဲ့ နေရာမှာ စာအုပ်ဖတ်တာမျိုးကို မလုပ်တာ ကောင်းမယ်။(အမှောင်ထဲမှာ စာကြည့်တာမျိုး ရှောင်သင့်တယ်။)	\N		\N	vmod				824	1
3867	Saya berhenti kerja bulan lepas.	ရှေ့လကတည်းက ကျွန်မ(/ကျွန်တော်) ကုမ္ပဏီက ထွက်လိုက်တယ်။	\N		\N	vmod				824	1
3868	Saya makan kuih yang saya dapat daripada Encik Tanaka.	မစ္စတာ တာနာခါ ဆီကရခဲ့တဲ့ မုန့်ကို စားလိုက်တယ်။	\N		\N	vmod				825	1
3869	Semalam saya dapat cenderamata daripada Encik Tanaka yang pergi melancong.	မနေ့က မစ္စတာ ရာမဒ ဆီက ခရီးအပြန်လက်ဆောင် ရခဲ့တယ်။	\N		\N	vmod				825	1
3858	Saya tidak sakit, jadi jangan bimbang.	ရောဂါ မဟုတ်တဲ့အတွက် စိုးရိမ်စရာ မလိုပါဘူး။	\N		\N	vmod				826	1
3859	Ibu bimbang kerana adik perempuan masih belum pulang ke rumah.	ညီမလေး ပြန်မလာသေးလို့ အမေ စိတ်ပူနေတယ်။	\N		\N	vmod				826	1
3864	Saya memberitahu nombor telefon bimbit saya kepada kawan.	သူငယ်ချင်းကို လက်ကိုင်ဖုန်းနံပါတ် ပြောပြလိုက်တယ်။(သူငယ်ချင်းကို ဟန်းဖုန်းနံပါတ် ပေးလိုက်တယ်။)	\N		\N	vmod				827	1
3865	Telefon bimbit bersaiz kecil, jadi senang diguna.	လက်ကိုင်ဖုန်း က သေးပြီး အရမ်း အဆင်ပြေတယ်။	\N		\N	vmod				827	1
3871	Encik Matsui memberikan tali leher untuk hari jadi Encik Tanaka.	မစ္စတာ မာဆုအိ က မစ္စတာ တာနာခါ ရဲ့ မွေးနေ့ အတွက် နက်ကတိုင် လက်ဆောင်ပေးတယ်။	\N		\N	vmod				833	1
3870	Encik Kobayashi memberikan separuh roti kepada Cik Kimura.	မစ္စတာ ခိုဘယရှိ က မစ္စတာ ခိမုရ ကို ပေါင်မုန့် တစ်ခြမ်း ပေးလိုက်တယ်။	\N		\N	vmod				833	1
3705	Pelbagai jenis makan tersusun di atas meja.	စားပွဲပေါ်မှာ ဟင်းမျိုးစုံ ကို စီထားတယ်။	\N		\N	vmod				70	1
3387	Saya memanggil sebuah teksi.	တက္ကဆီ တစ်စီး ခေါ်မယ်။	\N		\N	vmod				671	1
3900	Hari hujan berterusan pada minggu lepas.	ရှေ့အပတ်တုန်းက မိုးနေ့တွေ ဆက်တိုက်ပဲ။(ရှေ့အပတ်က မိုးတွေ ဆက်တိုက် ရွာတယ်။)	\N		\N	vmod				837	1
3899	Saya bimbang kerana adik perempuan saya demam tinggi pada hari ini juga secara berterusan.	 ညီမလေးက ဒီနေ့လည်း ကိုယ်တွေဆက်တိုက်ပူနေလို့ စိတ်ပူလိုက်တာ။\n	\N		\N	vmod				837	1
3902	Saya menyemak jawapan ujian.	စာမေးပွဲ အဖြေကို ပြန်စစ်တယ်။	\N		\N	vmod				838	1
3901	Saya menyemak bagasi sebelum keluar rumah.	အိမ်က မထွက်ခင် အထုပ်ကို စစ်တယ်။	\N		\N	vmod				838	1
3904	Saya rasa buku ini sangat menarik	ဒီ စာအုပ် က အရမ်း စိတ်ဝင်စားစရာကောင်းမယ်လို့ ထင်တယ်။	\N		\N	vmod				839	1
3903	Saya rasa akan pulang awal ke rumah kerana hari ini hari jadi isteri saya.	ဒီနေ့ အမျိုးသမီး ရဲ့ မွေးနေ့ မို့လို့ အိမ်စောစောပြန်မယ်လို့ စိတ်ကူးထားတယ်။	\N		\N	vmod				839	1
3906	Lawan kepada "berat" ialah "ringan".	“လေးတယ်” ရဲ့ ဆန့်ကျင်ဘက်က “ပေါ့တယ်”။	\N		\N	vmod				840	1
3905	Bas untuk pergi ke lapangan terbang tiba di jalan yang berlainan.	လေယာဉ်ကွင်း သွားတဲ့ ဘတ်စ်ကားက ပြောင်းပြန်ဘက် လမ်းကို လာမှာ။(လေယာဉ်ကွင်း သွားတဲ့ ဘတ်စ်ကားက ဟိုဘက်ခြမ်းက လာမှာ။)	\N		\N	vmod				840	1
3908	Bunyi akan menjadi kuat sekiranya ditekan di sini.	ဒီနေရာကို နှိပ်ရင် အသံ ကျယ်လာမယ်။\n	\N		\N	vmod				842	1
3909	Saya dan Encik Lee sama kumpulan.	ကျွန်မ(/ကျွန်တော်)နဲ့ မစ္စတာ လီ နဲ့က အဖွဲ့ အတူတူပဲ။	\N		\N	vmod				843	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_scene (id, explanation, s_type) FROM stdin;
1	နိုင်ငံခြားသို့ ခရီးသွားခြင်း	1
2	အားကစား	1
3	လမ်း	1
4	ကုမ္ပဏီ	1
5	စာကြည့်တိုက်	1
6	ဆိုင်	1
7	အိမ်	1
8	အခန်း	1
9	ရဲကင်း	1
10	အလှပြင်ဆိုင်	1
11	စာသင်ကျောင်း	1
12	သင်တန်း	1
13	ဆေးရုံဆေးခန်း	1
14	ဘူတာရုံ	1
15	ကဖေး	1
16	စားသောက်ဆိုင်	1
17	ဘဏ်	1
18	စာတိုက်	1
19	ကုန်တိုက်	1
20	အိမ်ခြံမြေအကျိုးဆောင်	1
21	နာမ်စားများ	2
22	နာမဝိသေသန (၁)	2
23	နာမဝိသေသန (၂)	2
24	ကြားခံလေဟာနယ်	2
25	မိသားစု	2
26	ဝတ်ဆင်ခြင်း	2
27	ကိုယ်ခန္ဓာ	2
28	စားသောက်နေထိုင်ရေး	2
29	ကိရိယာ၊ ပရိဘောဂ	2
30	အချိန်ကာလ၊ လ	2
31	အချိန်ကာလ၊ အပတ်	2
32	အချိန်ကာလ၊ နှစ်	2
33	အချိန်ကာလ၊ ရက်	2
34	အချိန်ကာလ	2
35	ဝါသနာ၊ ပျော်ရွှင်မှု	2
36	မိုးလေဝသ	2
37	ဘာသာစကား	2
38	လူ	2
39	အရောင်	2
\.


--
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: ms
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
435	291	ဘယ်လို	0	1
17	293	ဟို/ဟိုနေရာ\n	0	1
88	294	ဓာတ်လှေခါး	0	1
463	296	ဘယ်ဟာ\nဘာ	0	1
811	71	ဂျပန်ဘာသာ/ဂျပန်စာ/ဂျပန်စကား\n	1	1
44	86	～ပါဦး။/～မလား။	0	1
366	91	ပင်ပန်းတယ်/ခဲယဉ်းတယ်	1	1
203	101	သောကြာ/သောကြာနေ့	0	1
153	103	အအေးမိခြင်း	1	1
424	106	ဒါပေမယ့်	0	1
35	1546	よみ ： あめ	1	1
430	109	ဖုန်း/ဖုန်းဆက်ခြင်း	0	1
732	115	ခဏခဏ/မကြာခဏ/အမြဲတမ်း	1	1
255	117	ဒီဟာ/ဒါ	0	1
627	512	အားလုံး/မင်းတို့ \n\n	0	1
353	515	အဲဒီ 	0	1
349	524	အဲဒီ/အဲဒီနေရာ	0	1
351	531	အဲဒီ/အဲဒီဘက်\n	0	1
739	659	နောက်ထပ် 	1	1
76	778	အိမ်	0	1
828	781	ကိုကာကိုလာ	1	1
503	782	သောက်တယ်	1	1
630	784	ကြည့်တယ်/မြင်တယ်	1	1
52	818	နာတယ်/ကိုက်တယ်\n	0	1
647	858	ပုစ္ဆာ/မေးခွန်း\n/ပြဿနာ	0	1
573	859	စာမျက်နှာ～	1	1
543	898	လေယာဉ်/လေယာဉ်ပျံ\n	0	1
2	903	တွေ့တယ်/ဆုံတယ်\n	1	1
832	905	ဂီတပွဲ 	1	1
100	908	အိပ်ရာထတယ်\n	1	1
307	909	စားသောက်ဆိုင်	0	1
504	952	စီးတယ်\n	1	1
97	959	(သူတစ်ပါးရဲ့)အမေ/(သူတစ်ပါးရဲ့)မေမေ	0	1
326	962	ဘောင်းဘီ/ဘောင်းဘီရှည်	0	1
747	1020	～တုန်း/～အချိန်\n	1	1
393	1024	မြေပုံ	0	1
5	1026	အနီ/အနီရောင်	0	1
412	1030	လက်	0	1
479	1032	နာမည်/အမည်	0	1
578	1208	～အနားတဝိုက်	1	1
106	1211	နှိပ်တယ်/ဖိတယ်\n	1	1
433	1212	တံခါး/တံခါးမ	0	1
318	1218	ချက်ချင်း	1	1
91	1566	よみ ： お～	1	1
389	1220	နီးတယ်	0	1
108	1345	လက်ဖက်ရည်/ရေနွေးကြမ်း	0	1
300	1355	ဆယ်/တစ်ဆယ်	0	1
706	1357	ပူတယ်	1	1
453	1358	ဘယ်သူ/ဘယ်ပုဂ္ဂိုလ်	0	1
188	1374	တံဆိပ်ခေါင်း	0	1
510	1375	ပို့စကတ်	0	1
242	1376	အေအမ်/မနက်ပိုင်း/ည၁၂:၀၀မှနေ့လယ်၁၂:၀၀ထိအချိန်အပိုင်းအခြား	0	1
607	1489	ထပ်ပြီး/နောက်ထပ်/နောက်မှ	0	1
70	1503	အစစအရာရာ/အမျိုးမျိုး\n	1	1
680	1531	ထူးချွန်တယ်/ခမ်းနားတယ်/ထည်ဝါတယ်	1	1
51	1551	အလုပ်များတယ်/အလုပ်ရှုတ်တယ်	0	1
53	1552	တစ်	1	1
54	1553	တစ်နေ့/တစ်ရက်	0	1
57	1554	ငါးရက်/ငါးရက်နေ့ 	0	1
59	1555	ငါးခု \n	0	1
63	1556	အဓိပ္ပာယ်	0	1
66	1557	ဝင်ပေါက်/အဝင်၀ \n	1	1
109	1573	သန့်စင်ခန်း/အိမ်သာ	0	1
112	1574	ယောက်ျားလေး/ကောင်လေး	0	1
113	1575	ယောက်ျားလေး/ကောင်လေး	0	1
114	1576	တနေ့က/တမြန်နေ့က 	0	1
115	1577	တနှစ်က/တမြန်နှစ်က 	0	1
119	1578	(သူတစ်ပါးရဲ့)အစ်ကို/(သူတစ်ပါးရဲ့)ကိုကို 	0	1
120	1579	(သူတစ်ပါးရဲ့)အစ်မ/(သူတစ်ပါးရဲ့)မမ	0	1
121	1580	(သူတစ်ပါးရဲ့)အဒေါ်/(သူတစ်ပါးရဲ့)ဒေါ်ဒေါ်	1	1
122	1581	(သူတစ်ပါးရဲ့)အဖွား/(သူတစ်ပါးရဲ့)ဖွားဖွား	0	1
123	1582	ရေချိုးခန်း/ရေချိုးကန် 	0	1
125	1583	ရဲ/ရဲသား\n	1	1
126	1584	လေးတယ်	0	1
129	1585	ဆင်းတယ်	1	1
133	1586	မိန်းကလေး/ကောင်မလေး\n	0	1
172	1608	ပေါ့တယ်	0	1
173	1609	ကာရီ/မဆလာဟင်း	0	1
174	1610	ပြက္ခဒိန်	0	1
175	1611	ချောင်း/မြစ်	1	1
176	1612	～ဘက်ခြမ်း	1	1
803	1918	ဆမ်းတယ်	1	1
177	1613	ချစ်စရာကောင်းတယ်/ချစ်ဖို့ကောင်းတယ်	0	1
179	1614	သစ်ပင်/အပင် 	0	1
180	1615	အဝါ/အဝါရောင်	0	1
181	1616	အဝါ/အဝါရောင်	0	1
182	1617	ငြိမ်းတယ်/(မီး)ပျက်တယ်	1	1
183	1618	မေးတယ်	1	1
185	1619	ဂီတာ	0	1
220	1640	ရဲ/ရဲဘက်ဆိုင်ရာ	0	1
221	1641	ဒီမနက်/မနက်က	1	1
225	1642	လက်ထပ်တယ်	1	1
149	1593	よみ ： でんわをかける	0	1
227	1643	အိမ်အဝင်၀	0	1
229	1644	～ခု/～လုံး 	1	1
736	1645	ငါး	1	1
232	1646	လမ်းဆုံ	0	1
234	1647	ရဲကင်း/ရဲစခန်းငယ်	0	1
236	1648	ကုတ်အင်္ကျီ 	0	1
240	1649	ကိုးရက်/ကိုးရက်နေ့	0	1
241	1650	ကိုးခု/ကိုးလုံး 	0	1
287	1673	ခုနစ်/ခွန်	0	1
290	1674	ကား/မော်တော်ကား	0	1
291	1675	သေတယ်	1	1
299	1678	ရေချိုးတယ်	0	1
397	1679	～ချိန်/～နေတုန်း	1	1
305	1680	သန်စွမ်းတယ်/ခိုင်မာတယ်\n	0	1
306	1681	ပဲငံပြာရည်	1	1
309	1682	အဖြူ/အဖြူရောင်	0	1
314	1684	(ဆေးလိပ်)သောက်တယ်/(အသက်)ရှူတယ်	1	1
315	1685	စကတ်	0	1
370	1708	～ပဲ/～တည်းပဲ/～လောက် 	1	1
372	1709	～တွေ\n	1	1
374	1710	အနံ/ဒေါင်လိုက်	0	1
383	1712	ဘယ်သူ	0	1
438	1734	တိရစ္ဆာန်	0	1
440	1735	တစ်ဆယ်	1	1
441	1736	ဝေးတယ်	0	1
442	1737	ဆယ်ရက်/ဆယ်ရက်နေ့	0	1
444	1738	တစ်ခါတလေ/ရံဖန်ရံခါ 	1	1
447	1739	နေရာ	0	1
448	1740	နှစ်	1	1
451	1741	ဘယ်/ဘယ်တစ်ခု	0	1
454	1742	ဘေးနား	0	1
455	1743	ဘယ်/ဘယ်လို	0	1
461	1744	ကြက်သား	1	1
466	1746	ဓား	0	1
515	1770	အစဆုံး/အရင်ဆုံး	1	1
520	1772	အသက်နှစ်ဆယ် 	1	1
522	1773	ရှစ်	0	1
523	1774	ရှစ်	0	1
725	1775	ပန်း 	1	1
525	1776	စကား	0	1
716	1777	မြန်တယ်\n	1	1
567	1801	င်းတွင်း/ဆောင်းရာသီ/ဆောင်းဥတု	0	1
574	1803	ညံ့တယ်	0	1
576	1804	အိမ်မွေးတိရစ္ဆာန်	0	1
580	1805	စာဖတ်တယ်/စာလေ့လာတယ်	1	1
584	1806	～ထက်～က ပိုတယ်	1	1
585	1807	ဦးထုပ်	0	1
633	1829	ဟိုဘက်/အခြားတစ်ဖက်	0	1
635	1830	ခြောက်ခု/ခြောက်လုံး\n	0	1
636	1831	ရွာ/ကျေးရွာ\n	0	1
637	1832	မျက်စိ/မျက်လုံး	0	1
639	1833	မျက်မှန်	0	1
224	1395	よみ ： けっこん	0	1
641	1834	ကြာသပတေး/ကြာသပတေးနေ့ \n	0	1
644	1835	ပို/ပိုပြီး	0	1
669	1850	လေးရက်/လေးရက်နေ့	0	1
671	1851	ခေါ်တယ်\n	1	1
674	1852	ကိုယ်ခံအားနည်းတယ်/ကိုယ်ခံအားမကောင်းဘူး	0	1
678	1853	ရေဒီယို	0	1
679	1854	ရေဒီယိုကက်ဆက် 	0	1
682	1855	မိဘ	0	1
685	1856	ခရီးသွားတယ်	1	1
686	1857	သုံည	0	1
687	1858	ရေခဲသေတ္တာ	0	1
691	1860	လေ့ကျင့်တယ်	1	1
692	1861	စင်္ကြံ/လျှောက်လမ်း\n	0	1
693	1862	ခြောက်	0	1
755	1864	ထမင်းဘူး/ထမင်းချိုင့်	1	1
718	1865	လမ်းလျှောက်တယ်	1	1
709	1866	～လူမျိုး 	1	1
719	1867	အိမ်ခြံမြေဝန်ဆောင်မှုရုံးခန်း/အိမ်ခြံမြေဝန်ဆောင်မှုလုပ်ငန်း/အိမ်ခြံမြေအကျိုးဆောင်	1	1
720	1868	ပန်းကန်ပြား	1	1
721	1869	အရက်	1	1
722	1870	အလှပြင်ဆိုင်	1	1
726	1872	တခြား	1	1
772	1898	အိမ်လခ 	1	1
773	1899	ရှာတယ်	1	1
804	1919	တိုတယ်/တိုတို	1	1
805	1920	ရှည်တယ်/ရှည်ရှည်	1	1
808	1921	ဧည့်လမ်းညွှန်/ဂိုက်	1	1
809	1922	တည်းတယ်	1	1
810	1923	အပြန်လက်ဆောင်/အမှတ်တရလက်ဆောင် 	1	1
814	1925	(သူတစ်ပါးရဲ့)အမျိုးသား/(သူတစ်ပါးရဲ့)ခင်ပွန်း/(သူတစ်ပါးရဲ့)ယောက်ျား/(သူတစ်ပါးရဲ့)လင်ယောက်ျား	1	1
815	1926	(သူတစ်ပါးရဲ့)ညီမ/(သူတစ်ပါးရဲ့)နှမ\n	1	1
816	1927	(မိမိရဲ့)ညီလေး/(မိမိရဲ့)မောင်လေး	1	1
268	1047	よみ ： さけ	0	1
274	1665	よみ ： さら	0	1
292	1676	よみ ： じびき	0	1
295	1677	よみ ： しめます	1	1
311	1683	よみ ： じん	0	1
329	760	よみ ： する	0	1
335	1694	よみ ： せびろ	0	1
415	1728	よみ ： てーぷれこーだー	0	1
419	1730	よみ ： てください	0	1
443	750	よみ ： ～じ	1	1
465	1745	よみ ： ない	0	1
495	1761	よみ ： ぬるい	1	1
513	1768	よみ ： はし	0	1
519	1771	よみ ： ばたー	0	1
547	1786	よみ ： ひとつき	0	1
570	1052	よみ ： ふろ	0	1
572	1802	よみ ： ぶんしょう	0	1
582	916	よみ ： べんとう	0	1
616	1820	よみ ： まんねんひつ	0	1
688	1859	よみ ： れこーど	0	1
694	1863	よみ ： わいしゃつ	0	1
723	1871	【よみ】\n ください\n\n【意味】\n Give me ～, please.	1	1
727	1547	よみ ： ある	1	1
743	1880	よみ ： ～にん	1	1
751	1342	よみ ： ひく	1	1
761	1890	【よみ】\n ひきます\n\n【意味】\n catch (a cold)	1	1
770	1896	【よみ】\n みつかります\n\n【意味】\n be found	1	1
782	1903	【よみ】\n ゆうびんきょくいん\n\n【意味】\n post office clerk	1	1
802	1917	【よみ】\n ください\n\n【意味】\n Please ～.	1	1
813	1924	【よみ】\n ～にん\n\n【意味】\n ※ a term for counting person	1	1
216	185	よみ ： くる	0	1
379	1711	よみ ： たぶん	0	1
85	169	အင်္ဂလိပ်ဘာသာ/အင်္ဂလိပ်စာ/အင်္ဂလိပ်စကား	0	1
714	172	ကျွန်ုပ်/ကျွန်တော်/ကျွန်မ	1	1
362	175	ရတယ်/ဖြစ်တယ်/ဖြစ်နိုင်တယ်	0	1
316	324	ကြိုက်တယ်/နှစ်သက်တယ်	0	1
55	325	နံပါတ်တစ်	1	1
45	334	သွားတယ်	1	1
381	337	စားတယ်	1	1
683	339	ဟင်း/ဟင်းချက်တယ်	0	1
602	344	နေ့တိုင်း/နေ့စဉ်	0	1
439	345	ကျေးဇူးတင်ပါတယ်	0	1
252	353	မိတ္တူ /ကော်ပီ	0	1
592	356	ခလုတ်	0	1
795	363	စာရွက်/ပုံစံ စာရွက်/လျှောက်လွှာ/ဖောင်	1	1
642	370	ဟလို/အမိန့်ရှိပါ	0	1
158	372	ကျောင်း	0	1
15	375	ခြေ/ခြေထောက် 	0	1
710	388	 မိုး	1	1
436	398	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	0	1
652	410	ဈေးသက်သာတယ်/ဈေးပေါတယ်/ဈေးချိုတယ်	0	1
621	411	ဆိုင်/ဈေးဆိုင်	0	1
93	412	များတယ်/ထူထပ်တယ်	0	1
105	420	သင်တယ်/သင်ပေးတယ်	1	1
135	422	နိုင်ငံခြား/ပြည်ပ	0	1
398	423	အတော်/အနေတော်	0	1
360	425	တက္ကသိုလ်	0	1
472	440	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	0	1
25	444	နောက်/နောက်ထပ်	1	1
137	446	ကုမ္ပဏီ	0	1
677	454	နောက်နှစ်/လာမယ့်နှစ်	0	1
712	182	ပူတယ်	1	1
474	184	နွေရာသီ ပိတ်ရက်	0	1
40	186	ကောင်းတယ်	0	1
473	188	နွေ/နွေအခါ/နွေရာသီ/နွေဥတု	0	1
458	190	သူငယ်ချင်း	0	1
320	193	နည်းနည်း/အနည်းငယ်\n	0	1
283	197	အလုပ်	0	1
684	200	ခရီး/ခရီးသွား	0	1
197	205	မနှစ်က	0	1
223	212	တော်ပါပြီ/ရပါပြီ	0	1
344	214	စုစုပေါင်း/အားလုံးပေါင်း/အားလုံး	0	1
749	222	～အနှံ့ /～တခွင်/တစ်～လုံး\n\n	1	1
118	239	အတူတူ	0	1
257	245	ဒီလ	0	1
254	252	အခက်တွေ့တယ်/အကျပ်ရိုက်တယ်/ဒုက္ခရောက်တယ်	1	1
676	269	နောက်အပတ် 	0	1
313	270	ဗုဒ္ဓဟူး/ဗုဒ္ဓဟူးနေ့ 	0	1
806	273	လေဆိပ်/လေယာဉ်ကွင်း	1	1
217	278	ကား	0	1
446	284	ဘယ်/ဘယ်နေရာ	0	1
375	285	အဆောက်အအုံ 	0	1
39	299	ဟိုဟာ	0	1
42	300	ပြောတယ်	1	1
303	303	အိမ်စာ	0	1
293	317	ကိုယ်/ကိုယ်တိုင်/ကိုယ်ဟာကိုယ်\n	0	1
178	319	ခန်းဂျီး\n	0	1
83	323	ရုပ်ရှင်	0	1
740	1	ဟို	1	1
341	2	ဆရာ/ဆရာမ/ကျောင်းဆရာ/ဆရာဝန်	0	1
194	5	ဒီနေ့	1	1
12	6	မနက်	0	1
302	7	အတန်း	0	1
41	8	ဟင့်အင်း	0	1
728	11	 ရှိတယ်	1	1
698	13	ကျွန်တော်/ကျွန်မ	0	1
640	15	～သွား	1	1
596	18	တကယ်/အမှန်/အဟုတ်\n	0	1
238	21	ဒီ/ဒီနေရာ	0	1
1	24	ဪ/ဟာ/ဟယ်/အမလေး	0	1
741	28	ဟုတ်ကဲ့/အင်း	1	1
245	528	ဒီ/ဒီဘက်\n	0	1
437	29	ဆောင်ရွက်ပေးပါ/လုပ်ပေးပါ/ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ/လက်ခံပါ/ယူပါ/ဝင်ပါ/သုံးဆောင်ပါ\n	0	1
357	31	ပြီးတော့/နောက်ပြီးတော့	0	1
250	32	ဒီ\n	0	1
594	33	စာအုပ် \n	0	1
468	35	ရှည်တယ်	1	1
86	41	အင်း/အေး\n	0	1
452	42	အရမ်း\n/တော်တော်	0	1
345	45	ဟုတ်တယ်	0	1
356	46	အဲဒါ	0	1
668	53	ဘေး/ဘေးနား/အလျား	0	1
16	61	မနက်ဖန်/နက်ဖန်	1	1
516	63	ပထမဆုံးအကြိမ်	0	1
296	68	ဒါဖြင့်/ဒါဆိုရင်/ဒါပဲနော်	1	1
409	120	ပျင်းစရာကောင်းတယ်/စိတ်ဝင်စားဖို့မကောင်းဘူး/စိတ်ဝင်စားစရာမကောင်းဘူး	0	1
477	123	ဘယ်/ဘာ	1	1
62	134	အခု/ခု	0	1
107	137	နှေးတယ်	1	1
449	138	စာကြည့်တိုက်	0	1
422	144	ဒါဖြင့်  	0	1
47	151	ဘယ်လောက် 	0	1
399	152	ခဏလောက်/တစ်ဆိတ်လောက်/ဆောရီးပါ/အဆင်မပြေဘူး\n	0	1
68	158	ထည့်တယ်	1	1
244	161	ဒီဘက်/ဒီဘက်က	0	1
56	459	ဘယ်တော့ /ဘယ်တုန်းက /ဘယ်အချိန်	0	1
464	466	ဘယ်လို/ဘယ်လိုမျိုး\n	0	1
131	470	တေးဂီတ	0	1
403	498	နောက်တစ်ဆင့်/ပြီးရင် \n	0	1
141	502	ပြန်ပေးတယ်/ပြန်အပ်တယ်	1	1
401	507	သုံးတယ်\n	1	1
690	552	လေ့ကျင့်ခြင်း/လေ့ကျင့်ရေး	0	1
425	553	ထွက်တယ်/ပြီးတယ်/ဆင်းတယ်\n\n	1	1
702	557	ဆိုးတယ်/မကောင်းဘူး	0	1
670	559	လေးခု\n	0	1
459	562	စနေ/စနေနေ့\n	0	1
757	576	ဖျားတယ်/ကိုယ်ပူတယ်\n	1	1
551	579	ဆေးရုံ/ဆေးခန်း	0	1
593	598	ဟိုတယ်	0	1
796	600	လိပ်စာ/နေရပ်	1	1
715	610	နိုင်ငံခြား/ပြည်ပ/ပင်လယ်ရပ်ခြား	1	1
527	617	အမေ/မေမေ	0	1
147	628	ကျောင်းသား/ကျောင်းသူ	0	1
724	629	နွေဦး/နွေဦးရာသီ	1	1
394	634	(မိမိရဲ့)အဖေ/(မိမိရဲ့)ဖေဖေ	0	1
653	635	နားတယ်/နားရက်/ပိတ်ရက်	0	1
530	646	နေသာတယ်	0	1
231	649	ပန်းခြံ	0	1
61	654	ခွေး	0	1
579	656	ဘောပင်	0	1
500	657	မှတ်စုစာအုပ်/ဗလာစာအုပ်	0	1
577	661	 အခန်း	0	1
43	663	အိမ် 	0	1
195	664	စာသင်ခန်း	0	1
288	666	မေးခွန်း/အမေး\n	0	1
99	667	ပိုက်ဆံ/ငွေ\n	0	1
71	670	ပေါ်/အပေါ်	0	1
286	671	အောက်	0	1
604	672	ရှေ့/အရှေ့\n	0	1
467	675	ထဲ/အထဲ	0	1
352	676	အပြင်	1	1
618	677	ဘယ်/ဘယ်ဘက်/(လက်)ဝဲ/(လက်)ဝဲဘက်\n	0	1
544	678	ဘယ်/ဘယ်ဘက်/(လက်)ဝဲ/(လက်)ဝဲဘက်	0	1
162	679	အိတ်/လွယ်အိတ်	0	1
497	681	ကြောင်	0	1
589	682	စာတိုက်ပုံး	0	1
184	685	မြောက်/မြောက်ဘက်	0	1
391	686	အနား/အနီးနား\n	0	1
559	688	ရေကူးကန်	0	1
704	693	～ထပ်/～အထပ်	1	1
312	694	သတင်းစာ 	0	1
8	696	ဆောင်းဦး/ဆောင်းဦးရာသီ\n	0	1
545	699	လူ 	0	1
21	701	အသစ်	0	1
823	702	ကွန်ပျူတာ	1	1
512	703	သေတ္တာ/ပုံး/ဘူး	0	1
387	704	သေးတယ်/အသေး/သေးသေးလေး	0	1
228	705	နေကောင်းတယ်/ကျန်းမာတယ်/တက်ကြွတယ်	0	1
82	707	ပန်းချီ/ရုပ်ပုံကားချပ်/ပုံ	0	1
380	710	အစားအစာ/စားစရာ/အစားအသောက်	0	1
569	713	ဟောင်းတယ်/အဟောင်း/ရှေးကျတယ်/ရှေးဟောင်း	0	1
285	716	ဆိတ်ငြိမ်တယ်/တိတ်ဆိတ်တယ်/ငြိမ်နေတယ်	0	1
208	717	ဖိနပ်	0	1
140	719	ဝယ်တယ်	1	1
219	720	အမဲရောင်/အနက်ရောင် 	0	1
284	722	အဘိဓာန်	0	1
200	726	သန့်တယ်/လှတယ်/လှပတယ်	0	1
132	727	မိန်းမ/အမျိုးသမီး	0	1
94	729	ကြီးတယ်/အကြီးကြီး	0	1
434	731	အိမ်သာ/သန့်စင်ခန်း\n	0	1
26	734	နင်/မင်း/သင်/ခင်ဗျား/ရှင်	0	1
829	738	ကိတ်မုန့်	1	1
586	740	ဘောပင်	0	1
89	741	ယန်း～	1	1
270	742	～အုပ်	1	1
271	743	မဂ္ဂဇင်း	0	1
46	745	ဘယ်နှခု	0	1
535	746	လက်ကိုင်ပဝါ	0	1
597	747	～ထည်/～ချပ်/～ပုံ	1	1
571	753	～မိနစ်	1	1
489	758	တနင်္ဂနွေ/တနင်္ဂနွေနေ့	0	1
581	759	စာ/လေ့လာမှု	0	1
426	761	တီဗွီ/ရုပ်မြင်သံကြား	0	1
759	762	စန္ဒရား	1	1
506	764	ပွဲ/ပါတီ\n	0	1
654	767	နားတယ်/ပျက်ကွက်တယ်	1	1
646	772	တံခါး/မုခ်	0	1
568	774	မိုးရွာတယ်/နှင်းကျတယ်	1	1
130	775	ပြီးတယ်/ပြီးဆုံးတယ်	1	1
608	777	～သေးတယ်	0	1
417	785	စာ/ပေးစာ	0	1
371	786	ထုတ်တယ်/ပို့တယ်	1	1
152	787	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	1	1
170	788	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	1	1
480	790	သင်တယ်/သင်ယူတယ်	1	1
830	791	နံရံ	1	1
101	794	ထားတယ်\n	1	1
622	795	ပြတယ်	1	1
779	796	တင်းနစ်\n	1	1
273	799	အေးတယ်/ချမ်းတယ်	0	1
127	800	စိတ်ဝင်စားစရာကောင်းတယ်/စိတ်ဝင်စားဖို့ကောင်းတယ်	0	1
92	801	စားလို့ကောင်းတယ်/အရသာရှိတယ်	0	1
6	802	အနီ/နီတယ်	0	1
367	803	ရှည်တယ်/မြင့်တယ်	1	1
34	806	သိပ်	0	1
556	807	ကျယ်တယ်/ကြီးတယ်\n	0	1
561	812	အင်္ကျီ/အဝတ်အစား	0	1
764	814	ဆံပင်\n	1	1
331	815	အရပ်/အရပ်အမောင်း	0	1
411	817	သန်မာတယ်/အားသာတယ်	0	1
609	819	မြို့	0	1
623	820	လမ်း	0	1
336	821	ကျဉ်းတယ်	0	1
69	822	အရောင်/အရောင်အဆင်း\n	0	1
74	825	သီချင်း	0	1
110	829	(သူတစ်ပါးရဲ့)အဖေ/(သူတစ်ပါးရဲ့)ဖေဖေ	0	1
521	831	အလုပ်လုပ်တယ်	1	1
49	832	ဆရာဝန်	0	1
583	834	အဆင်ပြေတယ်	0	1
672	836	ဖတ်တယ်	1	1
373	839	ရပ်တယ်/မတ်တပ်ရပ်တယ်/မတ်တပ်ထတယ်	1	1
613	840	ပြတင်းပေါက်	0	1
9	841	ပွင့်တယ်	1	1
598	842	မနက်တိုင်း	0	1
499	844	 ～နှစ်	1	1
308	845	သိတယ်	1	1
605	846	ကွေ့တယ်/ကွေ့ကောက်တယ်/ကွေးတယ်\n	1	1
139	851	ဈေးဝယ်ခြင်း	0	1
750	852	ပိတ်တယ်	1	1
428	853	မီး/လျှပ်စစ်မီး	0	1
222	854	ပိတ်တယ်	1	1
87	855	ဘူတာ/ဘူတာရုံ	0	1
146	860	ရေးတယ်	1	1
199	861	ညှပ်တယ်/ပိုင်းတယ်/လှီးတယ်/ဖြတ်တယ်/ခုတ်တယ်	1	1
10	863	ဖွင့်တယ်	1	1
526	865	စကားပြောတယ်\n	1	1
534	867	ပေါင်မုန့် 	0	1
226	869	တနင်္လာ/တနင်္လာနေ့	0	1
777	870	ဘောလုံး/ဘောလုံးကစားခြင်း	1	1
423	874	ကုန်တိုက်	0	1
788	875	စူပါမားကက်	1	1
382	877	\n	0	1
575	878	အိပ်ရာ/ခုတင်	0	1
30	879	အိမ်ခန်း	0	1
327	880	နေတယ်	1	1
681	881	နိုင်ငံခြားသား ကျောင်းသား/ပညာတော်သင်ကျောင်းသား	0	1
695	886	ငယ်တယ်/ငယ်ရွယ်တယ်\n	0	1
209	889	ခြေအိတ်/ခြေစွပ်	0	1
634	892	ခက်တယ်	0	1
418	893	တတ်တယ်	1	1
128	895	ရေကူးတယ်	1	1
111	897	ညီလေး/မောင်လေး	0	1
330	915	ထိုင်တယ်	1	1
38	917	ခြေလျင်လျှောက်တယ်/လမ်းလျှောက်တယ်\n	1	1
413	918	တိတ်/တိတ်ခွေ\n	0	1
78	920	ပင်လယ်/သမုဒ္ဒရာ	0	1
656	922	တောင်	0	1
501	923	တက်တယ်	1	1
778	924	ဘေ့စ်ဘော	1	1
790	925	ပြိုင်ပွဲ 	1	1
797	926	မုန်တိုင်း	1	1
429	927	ရထား	0	1
457	928	ရပ်တယ်/ရပ်တန့်တယ်\n	1	1
492	929	ခြံ/ခြံဝန်း	0	1
143	931	မျက်နှာ	0	1
36	932	ဆေးတယ်/သန့်စင်တယ်\n	1	1
421	937	စာမေးပွဲ	0	1
355	938	ကောင်းကင်/မိုး/မိုးကောင်းကင်	0	1
4	939	အပြာ/အပြာရောင်	0	1
376	941	ပျော်တယ်/ပျော်စရာကောင်းတယ်/ပျော်ဖို့ကောင်းတယ်	0	1
517	944	ပြေးတယ်	1	1
297	946	ဓာတ်ပုံ	0	1
134	964	～ခါ/～ကြိမ်	1	1
266	969	ပွင့်တယ်	1	1
247	970	ဒီနှစ်	0	1
298	972	ရှပ်အင်္ကျီ \n	0	1
812	974	စာ/စာလုံး/လက်ရေး/လက်ရေးလက်သား	1	1
831	978	ကာရာအိုကေ	1	1
75	979	သီချင်းဆိုတယ်	1	1
235	980	(သက်ရှိသတ္တဝါတွေရဲ့နှုတ်ကထွက်တဲ့)အသံ 	0	1
628	981	တောင်/တောင်ဘက်\n	0	1
456	982	ပျံတယ်	1	1
509	993	ဝင်တယ်	1	1
518	1002	ဘတ်စ်ကား\n	0	1
552	1003	နေမကောင်းဖြစ်တယ်/ရောဂါဖြစ်တယ်	0	1
548	1007	တစ်ယောက်/တစ်ဦး	1	1
154	1008	မိသားစု	0	1
304	1012	တော်တယ်/ကျွမ်းကျင်တယ်	0	1
615	1013	သောင်း/တစ်သောင်း	0	1
214	1016	အတန်း/သင်တန်း	0	1
657	1018	လုပ်တယ်\n\n	1	1
390	1019	ကွာခြားတယ်/ကွဲပြားတယ်/မတူဘူး	1	1
610	1037	စောင့်တယ်	1	1
378	1045	ဆေးလိပ်	0	1
841	1048	မဖြစ်ဘူး/မရဘူး\n	1	1
834	1053	ခလုတ်/မီးခလုတ်	1	1
239	1063	ပီအမ်/ညနေပိုင်း/နေ့လယ်၁၂:၀၀မှည၁၂:၀၀ထိအချိန်အပိုင်းအခြား	0	1
3	1065	အပြာ/အပြာရောင်	0	1
261	1066	ဘယ်လိုပြောရမလဲ/ကဲ\n	0	1
701	1067	ကူးတယ်/ဖြတ်ကူးတယ်	1	1
346	1074	သန့်ရှင်းရေး	0	1
490	1075	အထုပ်/အထုပ်အပိုး/ဝန်ထုပ်	0	1
643	1076	သယ်တယ်/ယူထားတယ်/ကိုင်ထားတယ်	1	1
487	1079	အနောက်/အနောက်ဘက်	0	1
528	1082	စောတယ်	0	1
260	1085	ဒီည\n	0	1
631	1088	အားလုံး	0	1
289	1093	စက်ဘီး	0	1
310	1094	အဖြူ/အဖြူရောင် 	0	1
165	1095	စက္ကူ/စာရွက်\n	0	1
325	1099	အားကစား\n	0	1
60	1107	အမြဲ/အမြဲတမ်း \n	0	1
638	1109	～မီတာ/မီတာ～	1	1
230	1111	～ဘာသာ\n/～စာ/ ～စကား	1	1
531	1118	နေသာတယ်	1	1
731	1121	လိမ့်မယ်/ဖြစ်လိမ့်မယ်	1	1
774	1123	ဆိုင်ဝန်ထမ်း/ဆိုင်သမား/အရောင်းစာရေး\n	1	1
445	1137	နာရီ\n\n	0	1
64	1139	ညီမလေး/နှမလေး	0	1
33	1154	ချိုတယ်\n	0	1
460	1156	ငှက်/ကြက်ငှက်	0	1
675	1162	နောက်လ/လာမယ့်လ	0	1
332	1163	တပည့်	0	1
427	1164	မိုးလေ၀သ/ရာသီဥတုအခြေအနေ/ရာသီဥတု\n	0	1
462	1170	ရိုက်တယ်/ရိုက်ကူးတယ်	1	1
267	1174	စာစီစာကုံး 	0	1
237	1177	ကော်ဖီ	0	1
233	1178	လက်ဖက်ရည်	0	1
166	1185	ကင်မရာ 	0	1
536	1189	နံပါတ်	0	1
294	1193	ပိတ်တယ်	1	1
124	1199	မှတ်တယ်/မှတ်မိတယ်	1	1
117	1200	ဗိုက်/ဝမ်းဗိုက်\n\n	0	1
673	1203	ည	0	1
65	1221	မကြိုက်ဘူး/မုန်းတယ်/မလုပ်ချင်ဘူး\n	0	1
368	1227	များများ/အများကြီး 	0	1
700	1242	လှမ်းပေးတယ်/ပေးလိုက်တယ်	1	1
350	1262	အဲဒီ/အဲဒီနေရာ	0	1
502	1263	သောက်စရာ \n	0	1
282	1264	အချိန်	0	1
491	1265	သတင်း	0	1
659	1266	ညစာ	0	1
79	1268	ရောင်းတယ်	1	1
705	1271	ဝတ်တယ်	1	1
340	1283	ရှေ့အပတ်/ပြီးခဲ့တဲ့အပတ်\n	0	1
27	1287	အစ်ကို/ကိုကို	0	1
377	1290	မှာတယ်/ခိုင်းတယ်/တောင်းဆိုတယ်	1	1
22	1297	ဟို/ဟိုဘက်\n	0	1
450	1299	ဘယ်/ဘယ်ဟာ/ဘာ/ဘယ်ဘက်	0	1
708	1317	ည	1	1
707	1324	မှောင်တယ်	1	1
498	1329	အိပ်တယ်/အိပ်ပျော်တယ်	1	1
168	1378	စပ်တယ်	0	1
697	1381	မေ့တယ်/မေ့လျော့တယ်	1	1
533	1391	နံပါတ်～	1	1
116	1392	လူကြီး/အရွယ်ရောက်	0	1
766	1399	အဖြေ	1	1
339	1400	ရှေ့လ/လာမယ့်လ	0	1
689	1401	စားသောက်ဆိုင်	0	1
408	1402	အလုပ်လုပ်တယ်	1	1
333	1403	ဆွယ်တာ\n	0	1
264	1406	ငါး	0	1
807	1411	ပတ်စပို့/နိုင်ငံကူးလက်မှတ်	1	1
524	1415	နှာ/နှာခေါင်း	0	1
90	1416	ခဲတံ	0	1
696	1422	နားလည်တယ်/သဘောပေါက်တယ်	1	1
768	1439	အဆက်အသွယ်	1	1
752	1450	ယူတယ်	1	1
301	1455	 ～ပတ်ကြာ	1	1
532	1466	ခွဲ/(တစ်)ဝက်	0	1
363	1481	အကြိုက်ဆုံး/အရမ်းကြိုက်တယ်	0	1
58	1483	အတူတူ	1	1
781	1485	အကြွေးဝယ်ကတ်(/ခရက်ဒစ်ကတ်)	1	1
7	1533	အလင်းရောင်ကောင်းတယ်/လင်းလင်းထိန်ထိန်ရှိတယ်/မျက်နှာရွှင်တယ်/ဖော်ရွေတယ်	0	1
11	1534	မြှောက်တယ်/ပင့်တယ်/တင်တယ်\n	1	1
13	1535	မနက်စာ	1	1
14	1536	သန်ဘက်ခါ 	0	1
18	1537	ကစားတယ်/လျှောက်လည်တယ်\n	1	1
19	1538	နွေးတယ်/နွေးထွေးတယ်\n	1	1
20	1539	ခေါင်း/ဦးခေါင်း/ဉာဏ်/ဉာဏ်ရည်	0	1
23	1540	ထူတယ်	0	1
24	1541	ဟိုက/ဟိုဘက်	0	1
28	1542	(မိမိရဲ့)အစ်မ/(မိမိရဲ့)မမ	0	1
29	1543	အဲဒီ/ဟို\n	1	1
31	1544	(ရေ)ချိုးတယ်/လောင်းတယ်	1	1
32	1545	အန္တရာယ်ရှိတယ်/အန္တရာယ်များတယ်\n	0	1
37	1548	(သက်မဲ့အရာ)ရှိတယ်	1	1
343	1698	အဝတ်လျှော်တယ်	1	1
48	1549	ကန်/ရေကန်/အိုင်/ရေအိုင်	0	1
50	1550	ခုံ/ထိုင်ခုံ/ကုလားထိုင်\n	1	1
754	1558	(သက်ရှိသတ္တဝါ)ရှိတယ်\n	1	1
67	1559	လိုတယ်	1	1
72	1560	နောက်/အနောက်\n	1	1
73	1561	ပါးတယ်/ပါးပါး	0	1
77	1562	မွေးတယ်/မွေးဖွားတယ်	1	1
80	1563	ဆူတယ်/ညံတယ်/နားငြီးတယ်	0	1
81	1564	အပေါ်ထပ်အင်္ကျီ/အနွေးထည်	0	1
84	1565	ရုပ်ရှင်ရုံ	0	1
95	1567	အကြီးကြီး	0	1
96	1568	 အများကြီး 	0	1
98	1569	မုန့်\n	0	1
102	1570	အမျိုးသမီး/ဇနီး/မိန်းမ/မယား	0	1
103	1571	(သူတစ်ပါးရဲ့)ဦးလေး/(သူတစ်ပါးရဲ့)ဦးဦး	1	1
104	1572	(သူတစ်ပါးရဲ့)အဖိုး/(သူတစ်ပါးရဲ့)ဖိုးဖိုး	0	1
136	1587	နိုင်ငံခြားသား 	0	1
138	1588	လှေခါး 	0	1
142	1589	ပြန်တယ်	1	1
144	1590	ကြာတယ်	1	1
145	1591	သော့/သော့ချောင်း/သော့အိမ်	0	1
148	1592	～လကြာ \n	1	1
150	1594	တပ်တယ်/ချိတ်တယ်\n	1	1
151	1595	ထီး 	0	1
711	1596	လေ	1	1
155	1597	～ပုဂ္ဂိုလ်	1	1
156	1598	ခတခန/ခတခနအက္ခရာ\n	1	1
157	1599	～လ/～လပိုင်း	1	1
159	1600	ခွက် 	0	1
160	1601	အိမ်/အိမ်ထောင်\n\n	0	1
161	1602	ထောင့်/အစွန်	0	1
163	1603	ပန်းအိုး 	0	1
164	1604	ဆောင်းတယ်\n	1	1
167	1605	အင်္ဂါ/အင်္ဂါနေ့	0	1
169	1606	ကိုယ်ခန္ဓာ/ခန္ဓာကိုယ်	0	1
171	1607	(တစ်စုံတစ်ယောက်က)～ချင်နေတယ်	1	1
791	1620	ညစ်ပတ်တယ်	1	1
187	1621	ကော်ဖီဆိုင်	0	1
189	1622	လက်မှတ်	0	1
190	1623	မနေ့က	1	1
844	1624	ကိုး	1	1
192	1625	အမဲသား	0	1
193	1626	နွားနို့ 	0	1
196	1627	ညီအစ်ကိုမောင်နှမ	0	1
198	1628	မုန်းတယ်/မကြိုက်ဘူး	0	1
201	1629	ကီလိုဂရမ် 	1	1
202	1630	ဘဏ်	0	1
205	1631	ဆေး	0	1
206	1632	သစ်သီး/သစ်သီး၀လံ	0	1
207	1633	ပါးစပ်/အ၀	0	1
210	1634	နိုင်ငံ/အမိနိုင်ငံ	1	1
211	1635	မိုးအုံ့တယ်/တိမ်ထူတယ်\n	0	1
212	1636	မိုးအုံ့တယ်/တိမ်ထူတယ်\n	1	1
213	1637	～လောက် 	1	1
215	1638	～ဂရမ်	1	1
218	1639	အနက်/အနက်ရောင်/အမဲ/အမဲရောင်	0	1
243	1651	ဖြေတယ်	1	1
246	1652	ခွက်	0	1
248	1653	စကား	1	1
249	1654	ကလေး	1	1
251	1655	ထမင်း	1	1
253	1656	မိတ္တူကူးတယ်/ကော်ပီကူးတယ်	1	1
256	1657	～ဝန်းကျင်/～တုန်းက	1	1
258	1658	ဒီအပတ်	0	1
259	1659	ဒီလောက်/ဒီလို	0	1
262	1660	(အသက်)～နှစ်	1	1
263	1661	ပိုက်ဆံအိတ်	0	1
265	1662	အရင်	0	1
269	1663	(ထီး)ဆောင်းတယ်	1	1
272	1664	သကြား	0	1
275	1666	နောက်နှစ်ရဲ့နောက်တစ်နှစ်	1	1
734	1667	သုံး	1	1
276	1668	သုံး	1	1
277	1669	လမ်းလျှောက်ခြင်း	0	1
278	1670	လေး	0	1
280	1671	ဆား\n	0	1
281	1672	ဒါပေမယ့် 	0	1
317	1686	～ကျော်	1	1
319	1687	နည်းတယ်/နည်းနည်း	0	1
321	1688	အေးတယ်/အေးမြတယ်	0	1
322	1689	～စီ	1	1
323	1690	မီးဖို/အနွေးစက်/အပူပေးစက်	0	1
324	1691	ဇွန်း	0	1
328	1692	ဖိနပ်အပါး/ဖိနပ်ပါး 	0	1
334	1693	ဆပ်ပြာ	1	1
337	1695	သုံည	0	1
338	1696	ထောင်/တစ်ထောင်	0	1
342	1697	လျှော်စရာ/လျှော်စရာအဝတ်	0	1
347	1699	သန့်ရှင်းရေးလုပ်တယ်	1	1
348	1700	ပြီးတော့/နောက်ပြီးတော့  	1	1
354	1701	ဘေး/နံဘေး\n	0	1
358	1702	ဒါဆိုရင်/ပြီးရင်	0	1
359	1703	～စီး/～လုံး 	1	1
361	1704	သံရုံး 	0	1
364	1705	အရေးကြီးတယ်	0	1
365	1706	မီးဖိုချောင်/မီးဖိုခန်း	0	1
369	1707	တက္ကဆီ/အငှားယာဉ်	0	1
384	1713	တစ်ယောက်ယောက်/ဘယ်သူ	0	1
385	1714	မွေးနေ့	0	1
386	1715	တဖြည်းဖြည်း	1	1
388	1716	သေးသေး/သေးသေးလေး 	0	1
392	1717	မြေအောက်လိုင်း	0	1
395	1718	အညိုရောင်/အနီရောင်	0	1
396	1719	ပန်းကန်လုံး	1	1
400	1720	တစ်ရက်နေ့\n	1	1
402	1721	ပင်ပန်းတယ်	1	1
404	1722	ရောက်တယ်/ဆိုက်တယ်	1	1
405	1723	စာရေးခုံ/စာကြည့်စားပွဲ	0	1
406	1724	လုပ်တယ်/ထုတ်လုပ်တယ်\n	1	1
407	1725	ထွန်းတယ်/ထွန်းညှိတယ်	1	1
410	1726	အေးတယ်/အေးအေး	0	1
414	1727	စားပွဲ	0	1
416	1729	အပြင်ထွက်တယ်	1	1
420	1731	ထွက်ပေါက်	0	1
431	1732	တံခါး	0	1
432	1733	ဒီဂရီ 	1	1
469	1747	～ရင်း\n	1	1
470	1748	ငိုတယ်	1	1
471	1749	ဖျောက်ပစ်တယ်/ပျောက်သွားတယ်\n	1	1
475	1750	～တွေ～တွေ/～စတာတွေ	1	1
476	1751	ခုနစ်ခု/ခုနစ်လုံး	0	1
478	1752	ခုနစ်ရက်/ခုနစ်ရက်နေ့	0	1
481	1753	စီတယ်/တန်းစီတယ်\n်	1	1
482	1754	စီတယ်/တန်းစီတယ်	1	1
483	1755	ဖြစ်တယ်	1	1
484	1756	နှစ်	1	1
485	1757	စည်ကားတယ်	0	1
486	1758	အသား	0	1
488	1759	～ရက်/～နေ့/～ရက်နေ့	1	1
494	1760	ချွတ်တယ်	1	1
496	1762	နက်ကတိုင်	0	1
505	1763	သွား	0	1
507	1764	～ခွက် 	1	1
508	1765	ဆေးလိပ်ပြာခွက်	0	1
511	1766	(စကတ်)ဝတ်တယ်/(ဖိနပ်)စီးတယ်	1	1
717	1767	တံတား	1	1
514	1769	စတယ်/စတင်တယ်\n	1	1
529	1778	ကပ်တယ်	1	1
537	1779	ညစာ	1	1
538	1780	တစ်ဝက်/ထက်ခြမ်း	0	1
539	1781	အရှေ့/အရှေ့ဘက်	0	1
540	1782	～ကောင်	1	1
541	1783	(ကြိုးတပ်တူရိယာ)တီးတယ်	1	1
542	1784	ပုတယ်/နိမ့်တယ်	0	1
546	1785	တစ်ခု/တစ်လုံး \n	0	1
549	1787	အားတယ် 	0	1
550	1788	ရာ/တစ်ရာ	0	1
553	1789	ဟီရဂန/ဟီရဂနအက္ခရာ	1	1
554	1790	နေ့လယ်/နေ့ခင်း	0	1
555	1791	နေ့လယ်စာ	1	1
557	1792	ဖလင်	0	1
558	1793	စာအိတ်	0	1
560	1794	ခရင်း	0	1
713	1795	တိုက်တယ်/တိုက်ခတ်တယ်	1	1
562	1796	နှစ်ခု/နှစ်လုံး\n	0	1
563	1797	ဝက်သား	1	1
564	1798	နှစ်ယောက်	1	1
565	1799	နှစ်ရက်/နှစ်ရက်နေ့	0	1
566	1800	ဝတယ်/တုတ်တယ်	0	1
588	1808	အိတ်ကပ်	0	1
590	1809	လိုချင်တယ်	0	1
591	1810	ပိန်တယ်	0	1
595	1811	စာအုပ်စင်	0	1
599	1812	အပတ်တိုင်း/အပတ်စဉ် 	0	1
600	1813	လတိုင်း/လစဉ် 	0	1
601	1814	နှစ်တိုင်း/နှစ်စဉ်	0	1
603	1815	ညတိုင်း/ညစဉ် \n	0	1
606	1816	စားမကောင်းဘူး	0	1
611	1817	တန်းတန်း/ဖြောင့်ဖြောင့်/မတ်မတ်	0	1
612	1818	မီးခြစ်/ယမ်းမီးခြစ်	0	1
614	1819	ဝိုင်းတယ်/ဝိုင်းဝိုင်း	1	1
617	1821	တိုက်တယ်/သွေးတယ်	1	1
619	1822	တိုတယ်	1	1
620	1823	ရေ	0	1
624	1824	သုံးရက်/သုံးရက်နေ့ 	0	1
625	1825	သုံးခု/သုံးလုံး	0	1
626	1826	အစိမ်း/အစိမ်းရောင်	0	1
629	1827	နား/နားရွက်\n	0	1
632	1828	ခြောက်ရက်/ခြောက်ရက်နေ့	0	1
645	1836	ပစ္စည်း	0	1
648	1837	～ဆိုင်	1	1
649	1838	ဟင်းသီးဟင်းရွက်ဆိုင်/ကုန်စိမ်းဆိုင်	0	1
650	1839	ဟင်းသီးဟင်းရွက်	0	1
651	1840	လွယ်တယ်	0	1
655	1841	ရှစ်ခု/ရှစ်လုံး	0	1
658	1842	ညနေ/ညနေစောင်း	0	1
660	1843	စာတိုက်	0	1
661	1844	မနေ့ည	1	1
662	1845	နာမည်ကြီးတယ်\n	0	1
663	1846	နှင်း	0	1
664	1847	ဖြည်းဖြည်း	0	1
665	1848	ရှစ်ရက်/ရှစ်ရက်နေ့	0	1
666	1849	အဝတ်အစား 	0	1
729	1873	ဈေးကြီးတယ်	1	1
730	1874	အရမ်း/အလွန်	1	1
733	1875	ကောင်းကောင်း/တော်တော်/သေချာ	1	1
735	1876	လေး	1	1
737	1877	ခုနစ်/ခွန်	1	1
738	1878	ကိုး	1	1
742	1879	ကီလိုမီတာ	1	1
744	1881	～ချောင်း/～ပင်/～လိပ်	1	1
745	1882	မ～ခင်/ရှေ့ ～ က	1	1
746	1883	 ～နာရီကြာ	1	1
748	1884	～နာရီ	1	1
753	1886	(ဖုန်း)ဆက်တယ်	1	1
756	1887	စာကြောင်း	1	1
758	1888	လည်ချောင်း	1	1
760	1889	လုပ်တယ်	1	1
762	1891	အလှဖန်တီးသူ/အလှပြင်ဆရာ/မိတ်ကပ်ဆရာ	1	1
763	1892	ခေါင်းလျှော်ရည်/ခေါင်းလျှော်ခြင်း	1	1
765	1893	ဘူတာဝန်ထမ်း	1	1
767	1894	ဖုန်းနံပါတ်	1	1
769	1895	ဆက်သွယ်တယ်/အကြောင်းကြားတယ်\n	1	1
771	1897	နားထောင်တယ်/ကြားတယ်	1	1
775	1900	တစ်ယောက်စာစားပွဲတစ်ပွဲ/ဆက်မီနျူး	1	1
776	1901	နို့/နွားနို့	1	1
780	1902	အရောင်းကောင်တာ/ရောင်းတဲ့နေရာ	1	1
783	1904	လေယာဉ်စာ/လေကြောင်းလိုင်း/လေကြောင်းစာပို့	1	1
784	1905	သင်္ဘောလိုင်း/ရေကြောင်းလိုင်း/ရေကြောင်းပို့ဆောင်ရေး	1	1
785	1906	ပို့တယ်	1	1
786	1907	အနောက်တိုင်းဝတ်စုံ 	1	1
787	1908	ကုမ္ပ⁠ဏီဝန်ထမ်း	1	1
789	1909	တူ/စားပွဲတင်တူ	1	1
792	1910	ဘဏ်ဝန်ထမ်း	1	1
793	1911	ကောင်တာ/လက်ခံကောင်တာ	1	1
794	1912	ငွေလွှဲခြင်း	1	1
798	1913	နှေးတယ်/နောက်ကျတယ်	1	1
799	1914	ပေါ် ပေါက်တယ်/ပြီးမြောက်တယ်	1	1
800	1915	လုပ်တယ်/(နက်ကတိုင်)စည်းတယ်	1	1
801	1916	အနားယူတယ်	1	1
817	1928	ထည့်တယ်/ဖွင့်တယ်/မီးထွန်းတယ်	1	1
818	1929	ပိတ်တယ်/ဖြတ်တောက်တယ်	1	1
819	1930	လာတယ်	1	1
820	1931	နိုင်ငံ/အမိနိုင်ငံ	1	1
821	1932	နောက်မှ/နောက်ကျရင်/တော်ကြာမှ/တော်ကြာကျရင်	1	1
822	1933	ဘယ်ဟာ/ဘာ	1	1
824	1934	ရပ်တယ်/ရပ်တန့်တယ်/ထွက်တယ်/နုတ်ထွက်တယ်	1	1
825	1935	ရတယ်/ယူတယ်	1	1
826	1936	စိတ်ပူတယ်/စိုးရိမ်တယ်	1	1
827	1937	လက်ကိုင်ဖုန်း/ဟန်းဖုန်း/မိုဘိုင်းဖုန်း	1	1
833	1938	ပေးတယ်	1	1
835	1939	အစစအရာရာ/အမျိုးမျိုး\n	1	1
836	1940	ခေါ်တယ်	1	1
837	1941	ဆက်တိုက်ဖြစ်တယ်/ဆက်လက်တယ်	1	1
838	1942	စစ်တယ်/အတည်ပြုတယ်	1	1
839	1943	ထင်တယ်	1	1
840	1944	ဆန့်ကျင်ဘက်/ပြောင်းပြန်\n	1	1
842	1945	(သက်မဲ့အရာကထွက်တဲ့)အသံ	1	1
843	1946	အဖွဲ့ 	1	1
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
2172	216	2232	1	来る	\N	来	\N
2176	216	1562	5	来る	\N	来	\N
2174	216	2178	3	来る	\N	来	\N
2175	216	2220	4	来る	\N	来	\N
2173	216	1638	2	来る	\N	来	\N
1461	329	1530	2	する	\N	し	\N
1463	329	1810	4	する	\N	しよ	\N
1460	329	1721	1	する	\N	し	\N
1464	329	1799	5	する	\N	し	\N
1462	329	1398	3	する	\N	し	\N
991	582	2097	1	弁当	\N	弁当	\N
993	582	1556	3	弁当	\N	弁当	\N
992	582	1728	2	弁当	\N	弁当	\N
716	268	528	1	酒	\N	酒	\N
484	570	1745	1	ふろ	\N	ふろ	\N
2137	751	2244	1	引く	\N	引い	\N
2277	415	2773	1	テープレコーダー	\N	テープレコーダー	\N
2437	513	2816	1	はし	\N	はし	\N
3531	547	3308	1	ひとつき	\N	ひとつき	\N
3532	547	3304	1	ひとつき	\N	ひとつき	\N
4606	723	3113	2	ください (1)	0	ください	0
4605	723	3112	1	ください (1)	0	ください	0
2073	743	2216	1	～人	\N	～人	\N
2074	743	2231	2	～人	\N	～人	\N
2075	743	2224	3	～人	\N	～人	\N
2901	761	3003	1	ひきます	\N	ひいた	\N
3065	770	3082	2	見つかります	\N	見つかりました	\N
3066	770	3083	1	見つかります	\N	見つかります	\N
3099	782	3101	1	郵便局員	\N	郵便局員	\N
4369	802	3794	1	ください (2)	\N	ください	\N
4368	802	3793	2	ください (2)	\N	ください	\N
3964	813	3567	1	～人	\N	人	\N
3963	813	3566	2	～人	\N	人	\N
3300	85	2936	1	bahasa Inggeris	\N	အင်္ဂလိပ်ဘာသာ/အင်္ဂလိပ်စာ/အင်္ဂလိပ်စကား	\N
3301	85	2937	2	bahasa Inggeris	\N	အင်္ဂလိပ်ဘာသာ/အင်္ဂလိပ်စာ/အင်္ဂလိပ်စကား	\N
3478	714	1350	1	saya	\N	ကျွန်ုပ်/ကျွန်တော်/ကျွန်မ	\N
3479	714	1692	2	saya	\N	ကျွန်ုပ်/ကျွန်တော်/ကျွန်မ	\N
3480	714	1299	3	saya	\N	ကျွန်ုပ်/ကျွန်တော်/ကျွန်မ	\N
3996	362	3597	2	boléh	\N	ရတယ်/ဖြစ်တယ်/ဖြစ်နိုင်တယ်	\N
3997	362	3598	1	boléh	\N	ရတယ်/ဖြစ်တယ်/ဖြစ်နိုင်တယ်	\N
2915	83	2154	2	filem	\N	ရုပ်ရှင်	\N
2920	316	3013	2	suka	\N	ကြိုက်တယ်/နှစ်သက်တယ်	\N
2921	316	3014	1	suka	\N	ကြိုက်တယ်/နှစ်သက်တယ်	\N
4343	55	3785	2	paling	\N	နံပါတ်တစ်	\N
4344	55	3786	1	paling	\N	နံပါတ်တစ်	\N
3589	45	3336	2	pergi	\N	သွားတယ်	\N
3590	45	3337	1	pergi	\N	သွားတယ်	\N
2442	381	2818	1	makan	\N	စားတယ်	\N
2443	381	1484	2	makan	\N	စားတယ်	\N
2444	381	1993	3	makan	\N	စားတယ်	\N
2891	683	2104	1	hidangan/masakan/memasak	\N	ဟင်း/ဟင်းချက်ခြင်း	\N
2892	683	1967	2	hidangan/masakan/memasak	\N	ဟင်း/ဟင်းချက်တယ်	\N
2893	683	1419	3	hidangan/masakan/memasak	\N	ဟင်း/ဟင်းချက်တယ်	\N
3773	602	3433	1	setiap hari	\N	နေ့တိုင်း/နေ့စဉ်\n	\N
3774	602	1557	2	setiap hari	\N	နေ့တိုင်း/နေ့စဉ်	\N
4511	439	3776	1	ya/terima kasih	\N	ကျေးဇူးတင်ပါတယ်	\N
4512	439	3774	2	ya/terima kasih	\N	ကျေးဇူးတင်ပါတယ်	\N
4513	439	3775	3	ya/terima kasih	\N	ကျေးဇူးတင်ပါတယ်	\N
4514	439	2391	4	ya/terima kasih	\N	ကျေးဇူးတင်ပါတယ်	\N
2841	252	2976	1	salinan	\N	မိတ္တူ /ကော်ပီ	\N
4515	592	2043	1	butang	\N	ခလုတ်	\N
3196	795	3141	2	borang	\N	စာရွက်/ပုံစံ စာရွက်/လျှောက်လွှာ/ဖောင်\n​	\N
3197	795	3142	1	borang	\N	စာရွက်/ပုံစံ စာရွက်/လျှောက်လွှာ/ဖောင်	\N
4289	642	3773	1	hélo	\N	ဟလို/အမိန့်ရှိပါ	\N
4290	642	3772	2	hélo	\N	ဟလို/အမိန့်ရှိပါ	\N
4291	642	2548	3	hélo	\N	ဟလို/အမိန့်ရှိပါ	\N
3056	158	1605	1	sekolah	\N	ကျောင်း	\N
3057	158	1349	2	sekolah	\N	ကျောင်း	\N
3350	15	3230	2	kaki	\N	ခြေ/ခြေထောက် 	\N
3351	15	3231	1	kaki	\N	ခြေ/ခြေထောက် 	\N
2948	710	3028	2	hujan	\N	 မိုး	\N
2949	710	3029	1	hujan	\N	 မိုး	\N
4215	436	2011	1	kenapa	\N	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	\N
4216	436	2017	2	kenapa	\N	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	\N
4217	436	2007	3	kenapa	\N	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	\N
2807	652	1542	1	murah	\N	ဈေးသက်သာတယ်/ဈေးပေါတယ်/ဈေးချိုတယ်	\N
2808	652	2047	2	murah	\N	ဈေးသက်သာတယ်/ဈေးပေါတယ်/ဈေးချိုတယ်	\N
4600	621	2949	1	kedai	0	ဆိုင်/ဈေးဆိုင်	0
4601	621	2950	2	kedai	0	ဆိုင်/ဈေးဆိုင်	0
4602	621	1433	3	kedai	0	ဆိုင်/ဈေးဆိုင်	0
3915	93	3524	2	ramai	\N	များတယ်/ထူထပ်တယ်\n	\N
3916	93	3525	1	ramai	\N	များတယ်/ထူထပ်တယ်	\N
2572	105	2862	1	mengajar (ajar)	\N	သင်တယ်/သင်ပေးတယ်	\N
2573	105	1380	2	mengajar (ajar)	\N	သင်တယ်/သင်ပေးတယ်	\N
4500	135	2179	1	luar negara	\N	နိုင်ငံခြား/ပြည်ပ	\N
4501	135	1883	2	luar negara	\N	နိုင်ငံခြား/ပြည်ပ	\N
4144	398	3710	2	ini	\N	အတော်/အနေတော်	\N
4145	398	3711	1	ini	\N	အတော်/အနေတော်	\N
2507	360	2227	1	universiti	\N	 တက္ကသိုလ်	\N
2508	360	1826	2	universiti	\N	တက္ကသိုလ်	\N
4231	472	3750	1	mengapa	\N	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	\N
4232	472	2599	2	mengapa	\N	ဘာကြောင့်/ဘာဖြစ်လို့/ဘယ်လိုလုပ်/ဘာအတွက်	\N
4112	25	3470	1	lagi	\N	နောက်/နောက်ထပ်	\N
2844	137	2978	1	syarikat	\N	ကုမ္ပဏီ	\N
2845	137	2977	2	syarikat	\N	ကုမ္ပဏီ	\N
3757	677	3318	1	tahun depan	\N	နောက်နှစ်/လာမယ့်နှစ်	\N
3758	677	3319	2	tahun depan	\N	နောက်နှစ်/လာမယ့်နှစ်	\N
4197	56	1393	1	bila	\N	ဘယ်တော့ /ဘယ်တုန်းက /ဘယ်အချိန်\n	\N
4198	56	1268	2	bila	\N	ဘယ်တော့ /ဘယ်တုန်းက /ဘယ်အချိန်\n	\N
2960	712	3037	2	panas	\N	ပူတယ်	\N
2961	712	3034	1	panas	\N	ပူတယ်	\N
2510	474	1646	1	cuti musim panas	\N	နွေရာသီ ပိတ်ရက်	\N
2511	474	1397	2	cuti musim panas	\N	နွေရာသီ ပိတ်ရက်	\N
2512	474	2205	3	cuti musim panas	\N	နွေရာသီ ပိတ်ရက်	\N
3880	40	3503	3	bagus	\N	ကောင်းတယ်	\N
3881	40	3504	2	bagus	\N	ကောင်းတယ်	\N
3882	40	3505	1	bagus	\N	ကောင်းတယ်	\N
4588	473	3683	1	musim panas	\N	နွေ/နွေအခါ/နွေရာသီ/နွေဥတု	\N
4589	473	3682	2	musim panas	\N	နွေ/နွေအခါ/နွေရာသီ/နွေဥတု	\N
3026	458	3067	1	kawan	\N	သူငယ်ချင်း	\N
3027	458	2429	2	kawan	\N	သူငယ်ချင်း	\N
4142	320	3708	2	sedikit	\N	နည်းနည်း/အနည်းငယ်\n	\N
4143	320	3709	1	sedikit	\N	နည်းနည်း/အနည်းငယ်\n	\N
3109	283	2024	1	kerja	\N	အလုပ်	\N
4350	283	1799	2	kerja	\N	အလုပ်	\N
2782	684	2947	1	melancong/pelancongan	\N	ခရီး/ခရီးသွား	\N
2783	684	2948	2	melancong/pelancongan	\N	ခရီး/ခရီးသွား	\N
3752	197	3420	1	tahun lepas	\N	မနှစ်က	\N
3753	197	3316	2	tahun lepas	\N	မနှစ်က	\N
3754	197	1495	3	tahun lepas	\N	မနှစ်က	\N
4135	223	3706	1	cukup	\N	တော်ပါပြီ/ရပါပြီ	\N
4390	344	3806	2	semuanya	\N	စုစုပေါင်း/အားလုံးပေါင်း/အားလုံး	\N
4391	344	3807	1	semuanya	\N	စုစုပေါင်း/အားလုံးပေါင်း/အားလုံး	\N
4441	749	3850	2	seluruh/sapanjang	\N	～အနှံ့ /～တခွင်/တစ်～လုံး\n	\N
4442	749	3851	1	seluruh/sapanjang	\N	～အနှံ့ /～တခွင်/တစ်～လုံး\n\n	\N
4394	118	3810	2	sama/se-	\N	အတူတူ	\N
4395	118	3811	1	sama/se-	\N	အတူတူ	\N
3522	257	3302	1	bulan ini	\N	ဒီလ	\N
3523	257	3303	2	bulan ini	\N	ဒီလ	\N
3654	254	3365	1	susah	\N	အခက်တွေ့တယ်/အကျပ်ရိုက်တယ်/ဒုက္ခရောက်တယ်	\N
3746	676	3417	2	minggu depan	\N	နောက်အပတ် 	\N
3747	676	3418	1	minggu depan	\N	နောက်အပတ် 	\N
3740	313	3411	1	hari Rabu	\N	ဗုဒ္ဓဟူး/ဗုဒ္ဓဟူးနေ့ 	\N
3217	806	3148	2	lapangan terbang	\N	လေဆိပ်/လေယာဉ်ကွင်း	\N
3218	806	3149	1	lapangan terbang	\N	လေဆိပ်/လေယာဉ်ကွင်း	\N
2686	217	2908	1	keréta	\N	ကား	\N
2687	217	1250	2	keréta	\N	ကား	\N
2688	217	2061	3	keréta	\N	ကား	\N
4225	446	3749	1	mana	\N	ဘယ်/ဘယ်နေရာ\n	\N
4226	446	1229	2	mana	\N	ဘယ်/ဘယ်နေရာ	\N
4227	446	1312	3	mana	\N	ဘယ်/ဘယ်နေရာ	\N
4228	446	1264	4	mana	\N	ဘယ်/ဘယ်နေရာ	\N
2282	375	1431	1	bangunan	\N	အဆောက်အအုံ	\N
2283	375	2495	2	bangunan	\N	အဆောက်အအုံ 	\N
4212	435	1414	1	bagaimana	\N	ဘယ်လို	\N
4213	435	1423	2	bagaimana	\N	ဘယ်လို	\N
4214	435	2064	3	bagaimana	\N	ဘယ်လို	\N
3501	17	1297	1	sana	\N	ဟို/ဟိုနေရာ\n	\N
2477	88	2498	1	lif	\N	ဓာတ်လှေခါး	\N
4247	463	3752	1	yang mana	\N	ဘယ်ဟာ/ဘာ	\N
4248	463	3753	2	yang mana	\N	ဘယ်ဟာ/ဘာ	\N
4249	463	1836	3	yang mana	\N	ဘယ်ဟာ\nဘာ	\N
3502	39	1311	1	itu	\N	ဟိုဟာ	\N
3263	42	3170	1	cakap	\N	ပြောတယ်	\N
3264	42	1694	2	cakap	\N	ပြောတယ်	\N
3014	303	3063	1	kerja rumah	\N	အိမ်စာ	\N
3015	303	1473	2	kerja rumah	\N	အိမ်စာ	\N
3492	293	3290	1	sendiri/saya	\N	ကိုယ်/ကိုယ်တိုင်/ကိုယ်ဟာကိုယ်\n	\N
4039	430	3629	2	téléfon/menéléfon	\N	ဖုန်း/ဖုန်းဆက်ခြင်း	\N
3493	293	1683	2	sendiri/saya	\N	ကိုယ်/ကိုယ်တိုင်/ကိုယ်ဟာကိုယ်\n	\N
3248	178	3165	1	kanji	\N	ခန်းဂျီး	\N
3249	178	1885	2	kanji	\N	ခန်းဂျီး\n	\N
2914	83	3009	1	filem	\N	ရုပ်ရှင်	\N
4510	740	3874	1	erm	\N	ဟို	\N
2515	341	1178	1	guru/cikgu	\N	ဆရာ/ဆရာမ/ကျောင်းဆရာ/ဆရာဝန်	\N
2516	341	1476	2	guru/cikgu	\N	ဆရာ/ဆရာမ/ကျောင်းဆရာ/ဆရာဝန်	\N
2517	341	2019	3	guru/cikgu	\N	ဆရာ/ဆရာမ/ကျောင်းဆရာ/ဆရာဝန်	\N
3763	194	3425	2	hari ini	\N	ဒီနေ့	\N
3764	194	3426	1	hari ini	\N	ဒီနေ့	\N
3791	12	3446	2	pagi	\N	မနက်	\N
3792	12	3447	1	pagi	\N	မနက်	\N
3619	302	3069	1	kelas	\N	အတန်း	\N
3620	302	2005	2	kelas	\N	အတန်း	\N
4338	41	3784	1	tidak	\N	ဟင့်အင်း	\N
4339	41	1369	2	tidak	\N	ဟင့်အင်း	\N
4340	41	1879	3	tidak	\N	ဟင့်အင်း	\N
3402	728	3252	2	ada	\N	 ရှိတယ်	\N
3403	728	3253	1	ada	\N	 ရှိတယ်	\N
4529	698	2744	1	saya	\N	ကျွန်တော်/ကျွန်မ	\N
4182	640	3733	1	sudah	\N	～သွား	1
4183	640	3732	2	sudah	\N	～သွား	\N
4184	640	2004	3	sudah	\N	～သွား	\N
4435	596	3846	2	betul	\N	တကယ်/အမှန်/အဟုတ်	\N
4436	596	3847	1	betul	\N	တကယ်/အမှန်/အဟုတ်\n	\N
3496	238	1474	1	sini	\N	ဒီ/ဒီနေရာ	\N
4277	1	3766	1	oh/ha	\N	ဪ/ဟာ/ဟယ်/အမလေး\n\n	\N
4278	1	3767	2	oh/ha	\N	ဪ/ဟာ/ဟယ်/အမလေး	\N
4279	1	2637	3	oh/ha	\N	ဪ/ဟာ/ဟယ်/အမလေး	\N
4308	741	3777	1	ya	\N	ဟုတ်ကဲ့/အင်း\n\n \n\n\n	\N
4309	741	3778	2	ya	\N	ဟုတ်ကဲ့/အင်း	\N
4310	741	2332	3	ya	\N	ဟုတ်ကဲ့/အင်း	\N
4311	741	1824	4	ya	\N	ဟုတ်ကဲ့/အင်း	\N
4312	741	1715	5	ya	\N	ဟုတ်ကဲ့/အင်း	\N
4364	437	3792	1	silakan/tolong	\N	ဆောင်ရွက်ပေးပါ/လုပ်ပေးပါ/ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ/လက်ခံပါ/ယူပါ/ဝင်ပါ/သုံးဆောင်ပါ	\N
4365	437	2369	2	silakan/tolong	\N	ဆောင်ရွက်ပေးပါ/လုပ်ပေးပါ/ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ/လက်ခံပါ/ယူပါ/ဝင်ပါ/သုံးဆောင်ပါ	\N
4366	437	2332	3	silakan/tolong	\N	ဆောင်ရွက်ပေးပါ/လုပ်ပေးပါ/ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ/လက်ခံပါ/ယူပါ/ဝင်ပါ/သုံးဆောင်ပါ	\N
4367	437	2383	4	silakan/tolong	\N	ဆောင်ရွက်ပေးပါ/လုပ်ပေးပါ/ဆန္ဒအတိုင်းလုပ်ဆောင်ပါ/လက်ခံပါ/ယူပါ/ဝင်ပါ/သုံးဆောင်ပါ\n	\N
4125	357	3698	2	selepas itu	\N	ပြီးတော့/နောက်ပြီးတော့	\N
4126	357	3699	1	selepas itu	\N	ပြီးတော့/နောက်ပြီးတော့	\N
4345	250	3787	2	ini	\N	ဒီ\n	\N
4346	250	3788	1	ini	\N	ဒီ\n	\N
2825	594	1244	1	buku	\N	စာအုပ် 	\N
2826	594	2088	2	buku	\N	စာအုပ် \n	\N
3005	468	2873	1	panjang	\N	ရှည်တယ်	\N
4341	86	1727	1	ya	\N	အင်း/အေး\n	\N
4342	86	2520	2	ya	\N	အင်း/အေး\n	\N
4140	452	3707	1	sangat	\N	အရမ်း/တော်တော်	\N
4141	452	1427	2	sangat	\N	အရမ်း\n/တော်တော်	\N
4331	345	3783	2	begitu	\N	ဟုတ်တယ်	\N
4332	345	3782	1	begitu	\N	ဟုတ်တယ်	\N
4333	345	2637	3	begitu	\N	ဟုတ်တယ်	\N
4334	345	2396	4	begitu	\N	ဟုတ်တယ်	\N
3506	356	1837	1	itu	\N	အဲဒါ	\N
3507	356	1268	2	itu	\N	အဲဒါ	\N
3042	668	3062	1	sebelah/panjang	\N	ဘေး/ဘေးနား/အလျား	\N
3043	668	3072	2	sebelah/panjang	\N	ဘေး/ဘေးနား/အလျား	\N
3765	16	3427	2	ésok	\N	မနက်ဖန်/နက်ဖန်	\N
3766	16	3428	1	ésok	\N	မနက်ဖန်/နက်ဖန်	\N
4169	516	3726	2	buat pertama kalinya	\N	ပထမဆုံးအကြိမ်	\N
4170	516	3727	1	buat pertama kalinya	\N	ပထမဆုံးအကြိမ်	\N
4320	296	3781	1	kalau begitu	\N	ဒါဖြင့်/ဒါဆိုရင်/ဒါပဲနော်	\N
4321	296	2562	2	kalau begitu	\N	ဒါဖြင့်/ဒါဆိုရင်/ဒါပဲနော်	\N
4322	296	2415	3	kalau begitu	\N	ဒါဖြင့်/ဒါဆိုရင်/ဒါပဲနော်	\N
3255	811	3167	1	bahasa Jepun	\N	ဂျပန်ဘာသာ/ဂျပန်စာ/ဂျပန်စကား\n	\N
3256	811	1811	2	bahasa Jepun	\N	ဂျပန်ဘာသာ/ဂျပန်စာ/ဂျပန်စကား\n	\N
4260	44	3758	1	bagaimana 	\N	 ～ပါဦး။/ ～မလား။\n\n	\N
4261	44	3759	2	bagaimana 	\N	～ပါဦး။/～မလား။	\N
4003	366	3603	2	susah	\N	ပင်ပန်းတယ်/ခဲယဉ်းတယ်	\N
4004	366	3604	1	susah	\N	ပင်ပန်းတယ်/ခဲယဉ်းတယ်	\N
3742	203	3413	1	hari Jumaat	\N	သောကြာ/သောကြာနေ့	\N
4503	153	2762	1	selesema	\N	အအေးမိခြင်း	\N
4121	424	3694	2	tapi	\N	ဒါပေမယ့်	\N
4122	424	3695	1	tapi	\N	ဒါပေမယ့်	\N
4040	430	3628	1	téléfon/menéléfon	\N	ဖုန်း/ဖုန်းဆက်ခြင်း	\N
4193	732	3742	2	sering/selalu	\N	ခဏခဏ/မကြာခဏ/အမြဲတမ်း	\N
4194	732	3743	1	sering/selalu	\N	ခဏခဏ/မကြာခဏ/အမြဲတမ်း	\N
3508	255	1259	1	ini	\N	ဒီဟာ/ဒါ	\N
3895	409	3512	2	membosankan 	\N	ပျင်းစရာကောင်းတယ်/စိတ်ဝင်စားဖို့မကောင်းဘူး/စိတ်ဝင်စားစရာမကောင်းဘူး	\N
3896	409	3513	1	membosankan 	\N	ပျင်းစရာကောင်းတယ်/စိတ်ဝင်စားဖို့မကောင်းဘူး/စိတ်ဝင်စားစရာမကောင်းဘူး	\N
4233	477	1333	1	berapa	\N	ဘယ်/ဘာ	\N
4234	477	1335	2	berapa	\N	ဘယ်/ဘာ	\N
4235	477	1326	3	berapa	\N	ဘယ်/ဘာ	\N
3436	62	1330	1	sekarang	\N	အခု/ခု	\N
3437	62	1491	2	sekarang	\N	အခု/ခု	0
3142	107	2931	1	lambat	\N	နှေးတယ်	\N
2820	449	2966	1	perpustakaan	\N	စာကြည့်တိုက်	\N
2821	449	1974	2	perpustakaan	\N	စာကြည့်တိုက်	\N
2822	449	1801	3	perpustakaan	\N	စာကြည့်တိုက်	\N
4313	422	3779	2	kalau begitu/baiklah	\N	ဒါဖြင့်  	\N
4314	422	3780	1	kalau begitu/baiklah	\N	ဒါဖြင့်  	\N
3124	47	2409	1	berapa	\N	ဘယ်လောက် 	\N
3125	47	1320	2	berapa	\N	ဘယ်လောက် 	\N
4159	399	3719	1	sekejap/sikit	\N	ခဏလောက်/တစ်ဆိတ်လောက်/ဆောရီးပါ/အဆင်မပြေဘူး	\N
4160	399	3718	2	sekejap/sikit	\N	ခဏလောက်/တစ်ဆိတ်လောက်/ဆောရီးပါ/အဆင်မပြေဘူး	\N
4161	399	1720	3	sekejap/sikit	\N	ခဏလောက်/တစ်ဆိတ်လောက်/ဆောရီးပါ/အဆင်မပြေဘူး\n 	\N
4162	399	2672	4	sekejap/sikit	\N	ခဏလောက်/တစ်ဆိတ်လောက်/ဆောရီးပါ/အဆင်မပြေဘူး\n	\N
3596	68	2828	1	masukkan/menuangkan	\N	ထည့်တယ်	\N
3597	68	2829	2	masukkan/menuangkan	\N	ထည့်တယ်	\N
3509	244	3291	2	sini/ini	\N	ဒီဘက်/ဒီဘက်က\n	\N
3510	244	3292	1	sini/ini	\N	ဒီဘက်/ဒီဘက်က	\N
4199	56	1494	3	bila	\N	ဘယ်တော့ /ဘယ်တုန်းက /ဘယ်အချိန်	\N
4253	464	3755	1	yang bagaimana	\N	ဘယ်လို/ဘယ်လိုမျိုး\n	\N
4254	464	3754	2	yang bagaimana	\N	ဘယ်လို/ဘယ်လိုမျိုး	\N
4255	464	1280	3	yang bagaimana	\N	ဘယ်လို/ဘယ်လိုမျိုး\n	\N
2902	131	1817	1	muzik	\N	တေးဂီတ	\N
2903	131	1848	2	muzik	\N	တေးဂီတ	\N
3817	403	3467	2	kemudian	\N	နောက်တစ်ဆင့်/ပြီးရင် \n	\N
3818	403	3468	1	kemudian	\N	နောက်တစ်ဆင့်/ပြီးရင် \n	\N
2383	141	2797	1	pulangkan	\N	ပြန်ပေးတယ်/ပြန်အပ်တယ်	\N
2384	141	2796	2	pulangkan	\N	ပြန်ပေးတယ်/ပြန်အပ်တယ်	\N
2385	141	2651	3	pulangkan	\N	ပြန်ပေးတယ်/ပြန်အပ်တယ်	\N
3233	401	3160	2	guna	\N	သုံးတယ်\n	\N
3234	401	3100	1	guna	\N	သုံးတယ်\n	\N
4409	627	3823	3	awak semua	\N	အားလုံး/မင်းတို့ \n	\N
4410	627	3824	2	awak semua	\N	အားလုံး/မင်းတို့ \n\n	\N
4411	627	3825	1	awak semua	\N	အားလုံး/မင်းတို့ \n\n	\N
4353	353	3789	1	itu	\N	အဲဒီ 	\N
4354	353	1299	2	itu	\N	အဲဒီ 	\N
3497	349	1296	1	situ	\N	အဲဒီ/အဲဒီနေရာ	\N
3511	245	3293	1	sini	\N	ဒီ/ဒီဘက်\n	\N
3517	351	3299	1	situ	\N	အဲဒီ/အဲဒီဘက်\n	\N
2577	690	2864	1	latihan/berlatih	\N	လေ့ကျင့်ခြင်း/လေ့ကျင့်ရေး	\N
2578	690	1528	2	latihan/berlatih	\N	လေ့ကျင့်ခြင်း/လေ့ကျင့်ရေး	\N
3735	425	3408	2	keluar	\N	ထွက်တယ်/ပြီးတယ်/ဆင်းတယ်\n	\N
3736	425	3377	1	keluar	\N	ထွက်တယ်/ပြီးတယ်/ဆင်းတယ်\n\n	\N
3737	425	1637	3	keluar	\N	ထွက်တယ်/ပြီးတယ်/ဆင်းတယ်\n\n	\N
3883	702	3506	2	tidak baik	\N	ဆိုးတယ်/မကောင်းဘူး	\N
3884	702	3507	1	tidak baik	\N	ဆိုးတယ်/မကောင်းဘူး	\N
3931	670	3535	1	empat	\N	လေးခု\n	\N
3743	459	3414	1	hari Sabtu	\N	စနေ/စနေနေ့\n	\N
3052	757	3074	1	demam	\N	ဖျားတယ်/ကိုယ်ပူတယ်\n	\N
3053	757	1545	2	demam	\N	ဖျားတယ်/ကိုယ်ပူတယ်\n	\N
3046	551	3073	1	hospital	\N	ဆေးရုံ /ဆေးခန်း	\N
3047	551	1738	2	hospital	\N	ဆေးရုံ/ဆေးခန်း	\N
2767	593	2944	1	hotél	\N	ဟိုတယ်\n	\N
2768	593	1634	2	hotél	\N	ဟိုတယ်	\N
3206	796	3144	1	alamat	\N	လိပ်စာ/နေရပ်	\N
2775	715	2946	1	luar negara	\N	နိုင်ငံခြား/ပြည်ပ/ပင်လယ်ရပ်ခြား	\N
2776	715	2734	2	luar negara	\N	နိုင်ငံခြား/ပြည်ပ/ပင်လယ်ရပ်ခြား	\N
3413	527	3263	1	ibu	\N	အမေ/မေမေ	\N
2518	147	2153	1	pelajar	\N	ကျောင်းသား/ကျောင်းသူ	\N
2519	147	1176	2	pelajar	\N	ကျောင်းသား/ကျောင်းသူ	\N
2520	147	2158	3	pelajar	\N	ကျောင်းသား/ကျောင်းသူ	\N
4107	724	3685	1	musim bunga	\N	နွေဦး/နွေဦးရာသီ\n	\N
4108	724	3684	1	musim bunga	\N	နွေဦး/နွေဦးရာသီ	\N
3362	394	2086	1	bapa	\N	(မိမိရဲ့)အဖေ/(မိမိရဲ့)ဖေဖေ	\N
2850	653	2979	1	cuti	\N	နားတယ်/နားရက်/ပိတ်ရက်	\N
2851	653	1180	2	cuti	\N	နားတယ်/နားရက်/ပိတ်ရက်	\N
2980	530	3025	1	cerah	\N	နေသာတယ်	\N
2981	530	1194	2	cerah	\N	နေသာတယ်	\N
3130	231	3117	1	taman	\N	ပန်းခြံ	\N
3131	231	1222	2	taman	\N	ပန်းခြံ	\N
3132	231	1255	3	taman	\N	ပန်းခြံ	\N
4079	61	3660	2	anjing	\N	ခွေး	\N
4080	61	3661	1	anjing	\N	ခွေး	\N
2934	579	1259	1	pén	\N	ဘောပင်	\N
2935	579	1667	2	pén	\N	ဘောပင်	\N
3675	500	3376	1	buku nota	\N	မှတ်စုစာအုပ်/ဗလာစာအုပ်	\N
3676	500	1246	2	buku nota	\N	မှတ်စုစာအုပ်/ဗလာစာအုပ်	\N
3677	500	1527	3	buku nota	\N	မှတ်စုစာအုပ်/ဗလာစာအုပ်	\N
4185	739	3734	2	lagi	\N	နောက်ထပ် 	\N
4186	739	3735	1	lagi	\N	နောက်ထပ် 	\N
2637	577	2893	1	bilik	\N	 အခန်း	\N
2638	577	1434	2	bilik	\N	 အခန်း	\N
2884	43	2994	1	rumah	\N	အိမ် 	\N
2885	43	1601	2	rumah	\N	အိမ် 	\N
2886	43	1402	3	rumah	\N	အိမ် 	\N
2504	195	2843	1	bilik darjah	\N	စာသင်ခန်း	\N
2505	195	1254	2	bilik darjah	\N	စာသင်ခန်း	\N
2506	195	1650	3	bilik darjah	\N	စာသင်ခန်း	\N
2544	288	2856	1	soalan	\N	မေးခွန်း/အမေး\n	\N
2545	288	1654	2	soalan	\N	မေးခွန်း/အမေး\n	\N
3198	99	1233	1	wang	\N	ပိုက်ဆံ/ငွေ	\N
3199	99	2060	2	wang	\N	ပိုက်ဆံ/ငွေ	\N
3200	99	2093	3	wang	\N	ပိုက်ဆံ/ငွေ\n	\N
3396	71	3247	1	atas	\N	ပေါ်/အပေါ်	\N
3397	71	1323	2	atas	\N	ပေါ်/အပေါ်	\N
3398	286	3248	1	bawah	\N	အောက်	\N
2591	604	2868	1	depan	\N	ရှေ့/အရှေ့	\N
2592	604	1255	2	depan	\N	ရှေ့/အရှေ့	\N
2593	604	1249	3	depan	\N	ရှေ့/အရှေ့\n	\N
3370	467	3235	1	dalam	\N	ထဲ/အထဲ	\N
3371	467	1258	2	dalam	\N	ထဲ/အထဲ	\N
3372	467	1275	3	dalam	\N	ထဲ/အထဲ	\N
3373	352	1254	1	luar	\N	အပြင်	\N
3374	352	1410	2	luar	\N	အပြင်	\N
3375	352	1734	3	luar	\N	အပြင်	\N
2586	618	2867	1	kanan	\N	ညာ/ညာဘက်/(လက်)ယာ/(လက်)ယာဘက်	\N
2587	618	1247	2	kanan	\N	ဘယ်/ဘယ်ဘက်/(လက်)ဝဲ/(လက်)ဝဲဘက်\n	\N
2582	544	2866	1	kiri	\N	ဘယ်/ဘယ်ဘက်/(လက်)ဝဲ/(လက်)ဝဲဘက်	\N
2583	544	1248	2	kiri	\N	ဘယ်/ဘယ်ဘက်/(လက်)ဝဲ/(လက်)ဝဲဘက်	\N
2327	162	1418	1	bég	\N	အိတ်/လွယ်အိတ်	\N
2328	162	1245	2	bég	\N	အိတ်/လွယ်အိတ်	\N
2329	162	1302	3	bég	\N	အိတ်/လွယ်အိတ်	\N
4077	497	3658	2	kucing	\N	ကြောင်	\N
4078	497	3659	1	kucing	\N	ကြောင်	\N
1514	589	1251	1	peti surat	\N	စာတိုက်ပုံး	\N
1515	589	1531	2	peti surat	\N	စာတိုက်ပုံး	\N
3406	184	3256	1	utara	\N	မြောက်/မြောက်ဘက်	\N
2618	391	2881	1	dekat	\N	အနား/အနီးနား\n	\N
2619	391	1257	2	dekat	\N	အနား/အနီးနား\n	\N
2716	559	2923	1	kolam renang	\N	ရေကူးကန်	\N
2717	559	1548	2	kolam renang	\N	ရေကူးကန်	\N
2718	559	1778	3	kolam renang	\N	ရေကူးကန်	\N
2343	704	2790	1	tingkat	\N	～ထပ်/～အထပ်	\N
2344	704	2495	2	tingkat	\N	～ထပ်/～အထပ်	\N
2345	704	2497	3	tingkat	\N	～ထပ်/～အထပ်	\N
2831	312	2971	1	surat khabar	\N	သတင်းစာ 	\N
2832	312	2065	2	surat khabar	\N	သတင်းစာ 	\N
4590	8	3681	1	musim luruh	\N	ဆောင်းဦး/ဆောင်းဦးရာသီ\n\n	\N
4591	8	3680	2	musim luruh	\N	ဆောင်းဦး/ဆောင်းဦးရာသီ\n	\N
3422	545	1276	1	orang	\N	လူ 	\N
3423	545	1476	2	orang	\N	လူ 	\N
4449	21	1274	1	baru	\N	အသစ်	\N
4450	21	1947	2	baru	\N	အသစ်	\N
4480	823	3860	1	komputer	\N	ကွန်ပျူတာ	\N
4481	823	1831	2	komputer	\N	ကွန်ပျူတာ	\N
4063	512	3646	2	kotak	\N	သေတ္တာ/ပုံး/ဘူး	\N
4064	512	3647	1	kotak	\N	သေတ္တာ/ပုံး/ဘူး	\N
3831	387	3473	2	kecil	\N	သေးတယ်/အသေး/သေးသေးလေး	\N
3832	387	3474	1	kecil	\N	သေးတယ်/အသေး/သေးသေးလေး	\N
3992	228	3593	1	sihat/ceria	\N	နေကောင်းတယ်/ကျန်းမာတယ်/တက်ကြွတယ်	\N
2925	630	1396	1	téngok	\N	ကြည့်တယ်/မြင်တယ်	\N
3993	228	3594	2	sihat/ceria	\N	နေကောင်းတယ်/ကျန်းမာတယ်/တက်ကြွတယ်	\N
4539	82	3010	1	lukisan/melukis	\N	ပန်းချီ/ရုပ်ပုံကားချပ်/ပုံ	\N
4417	532	3829	1	setengah	\N	ခွဲ/(တစ်)ဝက်	\N
4540	82	1455	2	lukisan/melukis	\N	ပန်းချီ/ရုပ်ပုံကားချပ်/ပုံ	\N
2420	380	2806	1	makanan	\N	အစားအစာ/စားစရာ/အစားအသောက်	\N
2421	380	1860	2	makanan	\N	အစားအစာ/စားစရာ/အစားအသောက်	\N
2301	569	2780	1	lama	\N	ဟောင်းတယ်/အဟောင်း/ရှေးကျတယ်/ရှေးဟောင်း	\N
2302	569	1281	2	lama	\N	ဟောင်းတယ်/အဟောင်း/ရှေးကျတယ်/ရှေးဟောင်း	\N
4609	285	3518	1	senyap	0	ဆိတ်ငြိမ်တယ်/တိတ်ဆိတ်တယ်/ငြိမ်နေတယ်\n	0
4610	285	3519	2	senyap	0	ဆိတ်ငြိမ်တယ်/တိတ်ဆိတ်တယ်/ငြိမ်နေတယ်\n	0
4611	285	2023	3	senyap	0	ဆိတ်ငြိမ်တယ်/တိတ်ဆိတ်တယ်/ငြိမ်နေတယ်	0
2320	208	2785	1	kasut	\N	ဖိနပ်	\N
2321	208	1286	2	kasut	\N	ဖိနပ်	\N
2337	140	2789	1	beli	\N	ဝယ်တယ်	\N
2338	140	1477	2	beli	\N	ဝယ်တယ်	\N
2339	140	1640	3	beli	\N	ဝယ်တယ်	\N
1128	219	1534	1	hitam	\N	အမဲရောင်/အနက်ရောင် 	\N
2837	284	2974	1	kamus	\N	အဘိဓာန်	\N
2838	284	1291	2	kamus	\N	အဘိဓာန်	\N
3179	200	3134	1	cantik/bersih	\N	သန့်တယ်/လှတယ်/လှပတယ်	\N
3180	200	1455	2	cantik/bersih	\N	သန့်တယ်/လှတယ်/လှပတယ်	\N
3181	200	1535	3	cantik/bersih	\N	သန့်တယ်/လှတယ်/လှပတယ်	\N
3424	132	3272	1	perempuan	\N	မိန်းမ/အမျိုးသမီး	\N
3829	94	3472	1	besar	\N	ကြီးတယ်/အကြီးကြီး	\N
3830	94	1401	2	besar	\N	ကြီးတယ်/အကြီးကြီး	\N
2481	434	2835	1	tandas	\N	အိမ်သာ/သန့်စင်ခန်း\n	\N
2482	434	1305	2	tandas	\N	အိမ်သာ/သန့်စင်ခန်း\n	\N
3485	26	3288	1	awak	\N	နင်/မင်း/သင်/ခင်ဗျား/ရှင်	\N
3486	26	3289	2	awak	\N	နင်/မင်း/သင်/ခင်ဗျား/ရှင်	\N
3487	26	2234	3	awak	\N	နင်/မင်း/သင်/ခင်ဗျား/ရှင်	\N
3488	26	2170	4	awak	\N	နင်/မင်း/သင်/ခင်ဗျား/ရှင်	\N
4461	829	3856	2	kék	\N	ကိတ်မုန့်	\N
4462	829	3855	1	kék	\N	ကိတ်မုန့်	\N
4463	829	1319	3	kék	\N	ကိတ်မုန့်	\N
2938	586	3022	1	pén mata bulat	\N	ဘောပင်	\N
2939	586	2249	2	pén mata bulat	\N	ဘောပင်	\N
2402	89	2802	2	yén	\N	ယန်း～	\N
2403	89	2801	1	yén	\N	ယန်း～	\N
2815	270	2965	1	buah	\N	～အုပ်	\N
2816	270	1323	2	buah	\N	～အုပ်	\N
2827	271	2969	2	majalah	\N	မဂ္ဂဇင်း	\N
2828	271	2970	1	majalah	\N	မဂ္ဂဇင်း	\N
3122	46	3114	1	berapa	\N	ဘယ်နှခု	\N
3123	46	3115	2	berapa	\N	ဘယ်နှခု	\N
4051	535	3637	2	sapu tangan	\N	လက်ကိုင်ပဝါ	\N
4052	535	3638	1	sapu tangan	\N	လက်ကိုင်ပဝါ	\N
2362	597	2793	1	helai/keping	\N	～ထည်/～ချပ်/～ပုံ	\N
2363	597	2794	2	helai/keping	\N	～ထည်/～ချပ်/～ပုံ	\N
2364	597	1326	3	helai/keping	\N	～ထည်/～ချပ်/～ပုံ	\N
3444	571	3284	1	minit	\N	～မိနစ်	\N
3445	571	1679	2	minit	\N	～မိနစ်	\N
3455	489	3285	1	hari Ahad	\N	တနင်္ဂနွေ/တနင်္ဂနွေနေ့	\N
3456	489	1392	2	hari Ahad	\N	တနင်္ဂနွေ/တနင်္ဂနွေနေ့	\N
2513	581	2845	1	belajar	\N	စာ/လေ့လာမှု	\N
2514	581	2846	2	belajar	\N	စာ/လေ့လာမှု	\N
2267	426	1341	1	TV	\N	တီဗွီ/ရုပ်မြင်သံကြား	\N
2268	426	2192	2	TV	\N	တီဗွီ/ရုပ်မြင်သံကြား	\N
2269	426	1630	3	TV	\N	တီဗွီ/ရုပ်မြင်သံကြား	\N
2909	759	3006	1	piano	\N	စန္ဒရား	\N
4023	506	3618	1	majlis	\N	ပွဲ/ပါတီ\n	\N
4024	506	1398	2	majlis	\N	ပွဲ/ပါတီ\n	\N
3105	654	2991	1	tidak hadir	\N	နားတယ်/ပျက်ကွက်တယ်	\N
3175	646	3133	1	pintu pagar	\N	တံခါး/မုခ်	\N
4543	568	3042	1	turun	\N	မိုးရွာတယ်/နှင်းကျတယ်	\N
4544	568	1931	2	turun	\N	မိုးရွာတယ်/နှင်းကျတယ်	\N
3623	130	3351	1	habis	\N	ပြီးတယ်/ပြီးဆုံးတယ်	\N
3624	130	1348	2	habis	\N	ပြီးတယ်/ပြီးဆုံးတယ်	\N
4177	608	3730	2	masih	\N	～သေးတယ်	\N
4178	608	3731	1	masih	\N	～သေးတယ်	\N
3182	76	1367	1	rumah	\N	အိမ်	\N
3183	76	2178	2	rumah	\N	အိမ်	\N
4466	828	1371	1	air coca-cola	\N	ကိုကာကိုလာ	\N
4467	828	1710	2	air coca-cola	\N	ကိုကာကိုလာ	\N
2453	503	1371	1	minum/makan	\N	သောက်တယ်	\N
2454	503	1818	2	minum/makan	\N	သောက်တယ်	\N
2455	503	2004	3	minum/makan	\N	သောက်တယ်	\N
3209	797	1562	2	taufan	\N	မုန်တိုင်း	\N
2926	630	1974	2	téngok	\N	ကြည့်တယ်/မြင်တယ်	\N
2346	417	1482	1	surat	\N	စာ/ပေးစာ	\N
2347	417	1378	2	surat	\N	စာ/ပေးစာ	\N
2352	371	1378	1	hantar/memberi (beri)	\N	ထုတ်တယ်/ပို့တယ်	\N
2353	371	1654	2	hantar/memberi (beri)	\N	ထုတ်တယ်/ပို့တယ်	\N
2354	371	1971	3	hantar/memberi (beri)	\N	ထုတ်တယ်/ပို့တယ်	\N
2371	152	1379	1	meminjamkan 	\N	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	\N
2372	152	2092	2	meminjamkan 	\N	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	\N
2373	152	2090	3	meminjamkan 	\N	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	\N
4445	170	3852	1	meminjam (pinjam)	\N	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	\N
4446	170	1382	2	meminjam (pinjam)	\N	ချေးတယ်/ချေးပေးတယ်/ငှားတယ်/ငှားပေးတယ်	\N
3720	480	3396	2	belajar	\N	သင်တယ်/သင်ယူတယ်	\N
3721	480	3397	1	belajar	\N	သင်တယ်/သင်ယူတယ်	\N
4537	830	3854	1	dinding	\N	နံရံ	\N
4538	830	1614	2	dinding	\N	နံရံ	\N
3612	101	3347	1	letak	\N	ထားတယ်\n	\N
3613	101	1386	2	letak	\N	ထားတယ်\n	\N
3712	622	3392	1	menunjukkan	\N	ပြတယ်	\N
3713	622	1625	2	menunjukkan	\N	ပြတယ်	\N
3133	779	3118	1	ténis	\N	တင်းနစ်\n	\N
3134	779	1881	2	ténis	\N	တင်းနစ်\n	\N
4541	273	3053	1	sejuk	\N	အေးတယ်/ချမ်းတယ်	\N
4542	273	1403	2	sejuk	\N	အေးတယ်/ချမ်းတယ်	\N
3886	127	3508	2	kelakar/menarik	\N	စိတ်ဝင်စားစရာကောင်းတယ်/စိတ်ဝင်စားဖို့ကောင်းတယ်	\N
3887	127	3509	1	kelakar/menarik	\N	စိတ်ဝင်စားစရာကောင်းတယ်/စိတ်ဝင်စားဖို့ကောင်းတယ်	\N
3319	92	3212	2	sedap	\N	စားလို့ကောင်းတယ်/အရသာရှိတယ်	\N
3320	92	3213	1	sedap	\N	စားလို့ကောင်းတယ်/အရသာရှိတယ်	\N
3377	6	1537	1	mérah	\N	အနီ/နီတယ်	\N
4607	367	3495	1	tinggi	0	ရှည်တယ်/မြင့်တယ်	0
4608	367	3496	2	tinggi	0	ရှည်တယ်/မြင့်တယ်	0
4127	34	3700	1	tidak begitu	\N	သိပ်	\N
4128	34	1428	2	tidak begitu	\N	သိပ်	\N
1480	556	1426	1	luas	\N	ကျယ်တယ်/ကြီးတယ်\n	\N
2314	561	2783	1	baju	\N	အင်္ကျီ/အဝတ်အစား	\N
2315	561	1435	2	baju	\N	အင်္ကျီ/အဝတ်အစား	\N
2316	561	2130	3	baju	\N	အင်္ကျီ/အဝတ်အစား	\N
2995	764	3057	1	rambut	\N	ဆံပင်\n	\N
4047	331	3634	1	ketinggian	\N	အရပ်/အရပ်အမောင်း	\N
4048	331	1446	2	ketinggian	\N	အရပ်/အရပ်အမောင်း	\N
3143	411	3123	1	kuat	\N	သန်မာတယ်/အားသာတယ်	\N
2258	52	2766	1	sakit	\N	နာတယ်/ကိုက်တယ်\n	\N
2259	52	1450	2	sakit	\N	နာတယ်/ကိုက်တယ်\n	\N
2260	52	1451	3	sakit	\N	နာတယ်/ကိုက်တယ်\n	\N
4071	609	3652	2	bandar	\N	မြို့	\N
4072	609	3653	1	bandar	\N	မြို့	\N
2675	623	2906	1	jalan	\N	လမ်း	\N
2676	623	1478	2	jalan	\N	လမ်း	\N
1481	336	1454	1	sempit	\N	ကျဉ်းတယ်	\N
3392	69	3245	1	warna	\N	အရောင်/အရောင်အဆင်း\n	\N
2984	74	3050	1	lagu	\N	သီချင်း	\N
2985	74	1457	2	lagu	\N	သီချင်း	\N
4562	110	3898	1	ayah	\N	(သူတစ်ပါးရဲ့)အဖေ/(သူတစ်ပါးရဲ့)ဖေဖေ	\N
2878	521	2993	1	bekerja	\N	အလုပ်လုပ်တယ်	\N
2879	521	2992	2	bekerja	\N	အလုပ်လုပ်တယ်	\N
2880	521	1459	3	bekerja	\N	အလုပ်လုပ်တယ်	\N
183	49	1460	1	doktor	\N	ဆရာဝန်	\N
4006	583	3605	2	mudah diguna/berguna	\N	အဆင်ပြေတယ်	\N
4007	583	3606	1	mudah diguna/berguna	\N	အဆင်ပြေတယ်	\N
2811	672	1599	1	baca	\N	ဖတ်တယ်	\N
2812	672	1696	2	baca	\N	ဖတ်တယ်	\N
3663	373	3371	2	berdiri	\N	ရပ်တယ်/မတ်တပ်ရပ်တယ်\n	\N
3664	373	3372	1	berdiri	\N	ရပ်တယ်/မတ်တပ်ရပ်တယ်/မတ်တပ်ထတယ်	\N
3665	373	1485	3	berdiri	\N	ရပ်တယ်/မတ်တပ်ရပ်တယ်/မတ်တပ်ထတယ်	\N
3580	613	3331	2	tingkap	\N	ပြတင်းပေါက်	\N
3581	613	2894	1	tingkap	\N	ပြတင်းပေါက်	\N
3577	9	3330	1	buka	\N	ပွင့်တယ်	\N
3578	9	1501	2	buka	\N	ပွင့်တယ်	\N
3579	9	1921	3	buka	\N	ပွင့်တယ်	\N
3775	598	3434	2	setiap pagi	\N	မနက်တိုင်း	\N
3776	598	3435	1	setiap pagi	\N	မနက်တိုင်း	\N
3561	499	3323	2	tahun	\N	 ～နှစ်	\N
3562	499	3324	1	tahun	\N	 ～နှစ်	\N
4629	308	3369	1	tahu	0	သိတယ်	0
4630	308	3370	2	tahu	0	သိတယ်	0
2624	605	2884	1	berliku-liku/bélok	\N	ကွေ့တယ်/ကွေ့ကောက်တယ်/ကွေးတယ်\n	\N
2625	605	1507	2	berliku-liku/bélok	\N	ကွေ့တယ်/ကွေ့ကောက်တယ်/ကွေးတယ်\n	\N
4603	139	3153	1	membeli-belah	0	ဈေးဝယ်ခြင်း	0
4604	139	3617	2	membeli-belah	0	ဈေးဝယ်ခြင်း	0
3659	750	3368	1	tutup	\N	ပိတ်တယ်	\N
3660	750	1512	2	tutup	\N	ပိတ်တယ်	\N
3170	428	2901	1	lampu	\N	မီး/လျှပ်စစ်မီး	\N
3171	428	1513	2	lampu	\N	မီး/လျှပ်စစ်မီး	\N
3160	222	3128	2	memadamkan (padam)	\N	ပိတ်တယ်	\N
3161	222	3129	1	memadamkan (padam)	\N	ပိတ်တယ်	\N
2462	87	2115	1	stésén	\N	ဘူတာ/ဘူတာရုံ	\N
2463	87	1551	2	stésén	\N	ဘူတာ/ဘူတာရုံ	\N
3010	647	2857	1	soalan	\N	ပုစ္ဆာ/မေးခွန်း\n/ပြဿနာ	\N
3011	647	1515	2	soalan	\N	ပုစ္ဆာ/မေးခွန်း\n/ပြဿနာ	\N
4036	573	3627	1	muka surat	\N	စာမျက်နှာ～	\N
4037	573	1515	2	muka surat	\N	စာမျက်နှာ～	\N
4614	146	3171	1	menulis (tulis) 	0	ရေးတယ်	0
4615	146	3172	2	menulis (tulis) 	0	ရေးတယ်	0
3003	199	3060	1	memotong (potong) 	\N	ညှပ်တယ်/ပိုင်းတယ်/လှီးတယ်/ဖြတ်တယ်/ခုတ်တယ်	\N
3004	199	2871	2	memotong (potong) 	\N	ညှပ်တယ်/ပိုင်းတယ်/လှီးတယ်/ဖြတ်တယ်/ခုတ်တယ်	\N
3571	10	3329	2	buka	\N	ဖွင့်တယ်	\N
3572	10	3328	1	buka	\N	ဖွင့်တယ်	\N
3573	10	1520	3	buka	\N	ဖွင့်တယ်	\N
3259	526	3168	2	bercakap (cakap) 	\N	စကားပြောတယ်\n	\N
3260	526	3169	1	bercakap (cakap) 	\N	စကားပြောတယ်\n	\N
3090	534	1609	1	roti	\N	ပေါင်မုန့် 	\N
3091	534	1532	2	roti	\N	ပေါင်မုန့် 	\N
3738	226	3409	1	hari Isnin	\N	တနင်္လာ/တနင်္လာနေ့	\N
3139	777	3120	1	bola sépak	\N	ဘောလုံး/ဘောလုံးကစားခြင်း	\N
432	423	1530	1	pusat membeli-belah	\N	ကုန်တိုက်	\N
3119	788	3111	1	pasar raya	\N	စူပါမားကက်	\N
4029	382	3623	2	telur	\N	ဥ/ကြက်ဥ\n	\N
4030	382	3624	1	telur	\N	\n	\N
2927	575	3018	1	katil	\N	အိပ်ရာ/ခုတင်	\N
473	30	1535	1	flat	\N	အိမ်ခန်း	\N
4505	327	1535	1	tinggal	\N	နေတယ်	\N
4506	327	1928	2	tinggal	\N	နေတယ်	\N
4507	327	2030	3	tinggal	\N	နေတယ်	\N
3028	681	3066	1	pelajar antarabangsa	\N	နိုင်ငံခြားသား ကျောင်းသား/ပညာတော်သင်ကျောင်းသား	\N
3029	681	3065	2	pelajar antarabangsa	\N	နိုင်ငံခြားသား ကျောင်းသား/ပညာတော်သင်ကျောင်းသား	\N
3984	695	3587	2	muda	\N	ငယ်တယ်/ငယ်ရွယ်တယ်	\N
3985	695	3588	1	muda	\N	ငယ်တယ်/ငယ်ရွယ်တယ်\n	\N
972	209	1542	1	stoking	\N	ခြေအိတ်/ခြေစွပ်	\N
242	634	1544	1	susah	\N	ခက်တယ်	\N
3910	418	3135	1	boléh	\N	တတ်တယ်	\N
2730	128	2069	1	berenang	\N	ရေကူးတယ်	\N
2731	128	2189	2	berenang	\N	ရေကူးတယ်	\N
2732	128	1546	3	berenang	\N	ရေကူးတယ်	\N
1105	111	2093	1	adik lelaki	\N	ညီလေး/မောင်လေး	\N
1106	111	2030	2	adik lelaki	\N	ညီလေး/မောင်လေး	\N
1107	111	1547	3	adik lelaki	\N	ညီလေး/မောင်လေး	\N
2751	543	1619	1	kapal terbang	\N	လေယာဉ်/လေယာဉ်ပျံ\n	\N
2752	543	1549	2	kapal terbang	\N	လေယာဉ်/လေယာဉ်ပျံ\n	\N
3567	2	3326	1	berjumpa	\N	တွေ့တယ်/ဆုံတယ်\n	\N
3568	2	3327	2	berjumpa	\N	တွေ့တယ်/ဆုံတယ်\n	\N
4470	832	3857	1	konsert	\N	ဂီတပွဲ 	\N
4471	832	1660	2	konsert	\N	ဂီတပွဲ 	\N
2649	100	1388	1	bangun	\N	အိပ်ရာထတယ်\n	\N
2650	100	2018	2	bangun	\N	အိပ်ရာထတယ်\n	\N
2651	100	2042	3	bangun	\N	အိပ်ရာထတယ်\n	\N
2416	307	1588	1	kantin	\N	စားသောက်ဆိုင်	\N
2417	307	1553	2	kantin	\N	စားသောက်ဆိုင်	\N
2608	330	2874	1	duduk	\N	ထိုင်တယ်	\N
2609	330	1556	2	duduk	\N	ထိုင်တယ်	\N
2704	38	1586	1	berjalan kaki	\N	ခြေလျင်လျှောက်တယ်/လမ်းလျှောက်တယ်\n	\N
2705	38	1557	2	berjalan kaki	\N	ခြေလျင်လျှောက်တယ်/လမ်းလျှောက်တယ်\n	\N
2706	38	2055	3	berjalan kaki	\N	ခြေလျင်လျှောက်တယ်/လမ်းလျှောက်တယ်\n	\N
4451	413	1477	1	pita	\N	တိတ်/တိတ်ခွေ\n	\N
4452	413	1558	2	pita	\N	တိတ်/တိတ်ခွေ\n	\N
4085	78	3666	2	laut	\N	ပင်လယ်/သမုဒ္ဒရာ	\N
4086	78	3667	1	laut	\N	ပင်လယ်/သမုဒ္ဒရာ	\N
4087	656	3668	2	gunung	\N	တောင်	\N
4088	656	3669	1	gunung	\N	တောင်	\N
3718	501	3395	1	mendaki	\N	တက်တယ်	\N
3719	501	3394	2	mendaki	\N	တက်တယ်	\N
3140	778	3121	1	bésbol	\N	ဘေ့စ်ဘော	\N
3141	790	3122	1	perlawanan	\N	ပြိုင်ပွဲ 	\N
3208	797	1672	1	taufan	\N	မုန်တိုင်း	\N
2467	429	2830	1	keréta api	\N	ရထား	\N
2468	429	1672	2	keréta api	\N	ရထား	\N
2469	429	1562	3	keréta api	\N	ရထား	\N
3688	457	3380	1	berhenti	\N	ရပ်တယ်/ရပ်တန့်တယ်\n	\N
3689	457	3381	2	berhenti	\N	ရပ်တယ်/ရပ်တန့်တယ်\n	\N
1467	492	1636	1	halaman rumah	\N	ခြံ/ခြံဝန်း	\N
1468	492	1935	2	halaman rumah	\N	ခြံ/ခြံဝန်း	\N
3279	143	3185	1	muka	\N	မျက်နှာ	\N
3352	36	3232	1	membasuh (basuh) 	\N	ဆေးတယ်/သန့်စင်တယ်\n	\N
3030	421	3068	2	ujian	\N	စာမေးပွဲ	\N
3031	421	2858	1	ujian	\N	စာမေးပွဲ	\N
4095	355	3676	2	langit	\N	ကောင်းကင်/မိုး/မိုးကောင်းကင်	\N
4096	355	3677	1	langit	\N	ကောင်းကင်/မိုး/မိုးကောင်းကင်	\N
3381	4	3236	1	biru	\N	အပြာ/အပြာရောင်\n	\N
3382	4	1592	2	biru	\N	အပြာ/အပြာရောင်	\N
3892	376	3511	1	seronok	\N	ပျော်တယ်/ပျော်စရာကောင်းတယ်/ပျော်ဖို့ကောင်းတယ်	\N
3893	376	3510	2	seronok	\N	ပျော်တယ်/ပျော်စရာကောင်းတယ်/ပျော်ဖို့ကောင်းတယ်	\N
3894	376	1862	3	seronok	\N	ပျော်တယ်/ပျော်စရာကောင်းတယ်/ပျော်ဖို့ကောင်းတယ်	\N
2741	517	2933	1	berlari (lari) 	\N	ပြေးတယ်	\N
2742	517	1990	2	berlari (lari) 	\N	ပြေးတယ်	\N
4535	297	3880	1	gambar	\N	ဓာတ်ပုံ	\N
4536	297	2181	2	gambar	\N	ဓာတ်ပုံ	\N
2488	504	2839	1	naik	\N	စီးတယ်\n	\N
2489	504	1619	2	naik	\N	စီးတယ်\n	\N
3417	97	3267	1	emak	\N	(သူတစ်ပါးရဲ့)အမေ/(သူတစ်ပါးရဲ့)မေမေ	\N
3287	326	3190	1	seluar	\N	ဘောင်းဘီ/ဘောင်းဘီရှည်	\N
3955	134	3558	2	kali	\N	～ခါ/～ကြိမ်	\N
3956	134	3559	1	kali	\N	～ခါ/～ကြိမ်	0
3651	266	3364	1	mekar	\N	ပွင့်တယ်	\N
3652	266	3363	2	mekar	\N	ပွင့်တယ်	\N
3549	247	3317	1	tahun ini	\N	ဒီနှစ်	\N
3550	247	1638	2	tahun ini	\N	ဒီနှစ်	\N
3115	298	3108	1	keméja	\N	ရှပ်အင်္ကျီ \n	\N
3116	298	1640	2	keméja	\N	ရှပ်အင်္ကျီ \n	\N
3267	812	3173	2	huruf	\N	စာ/စာလုံး/လက်ရေး/လက်ရေးလက်သား	\N
3268	812	3174	1	huruf	\N	စာ/စာလုံး/လက်ရေး/လက်ရေးလက်သား	0
4486	831	3862	2	karaoké	\N	ကာရာအိုကေ	\N
4487	831	3863	1	karaoké	\N	ကာရာအိုကေ	\N
2922	75	3015	1	menyanyi (nyanyi) 	\N	သီချင်းဆိုတယ်	\N
4043	235	3632	2	suara	\N	(သက်ရှိသတ္တဝါတွေရဲ့နှုတ်ကထွက်တဲ့)အသံ 	\N
4044	235	3633	1	suara	\N	(သက်ရှိသတ္တဝါတွေရဲ့နှုတ်ကထွက်တဲ့)အသံ 	\N
3407	628	3257	1	selatan	\N	တောင်/တောင်ဘက်\n	\N
2745	456	2934	1	terbang	\N	ပျံတယ်	\N
2746	456	1645	2	terbang	\N	ပျံတယ်	\N
4631	509	3688	1	masuk	0	ဝင်တယ်	0
4632	509	3689	2	masuk	0	ဝင်တယ်	0
4633	509	3687	3	masuk	0	ဝင်တယ်	0
758	518	1668	1	bas	\N	ဘတ်စ်ကား\n	\N
2232	552	1671	1	sakit	\N	နေမကောင်းဖြစ်တယ်/ရောဂါဖြစ်တယ်	\N
2233	552	2019	2	sakit	\N	နေမကောင်းဖြစ်တယ်/ရောဂါဖြစ်တယ်	\N
3949	548	3552	2	seorang	\N	တစ်ယောက်/တစ်ဦး	\N
3950	548	3553	1	seorang	\N	တစ်ယောက်/တစ်ဦး	\N
4561	154	3897	1	keluarga	\N	မိသားစု	\N
2720	304	2925	2	pandai	\N	တော်တယ်/ကျွမ်းကျင်တယ်	\N
2721	304	2926	1	pandai	\N	တော်တယ်/ကျွမ်းကျင်တယ်	\N
4560	615	3896	1	puluh ribu	\N	သောင်း/တစ်သောင်း	\N
2499	214	2842	1	sekelas	\N	အတန်း/သင်တန်း	\N
2500	214	1682	2	sekelas	\N	အတန်း/သင်တန်း	\N
3108	657	1683	1	membuat (buat) 	\N	လုပ်တယ်\n\n	\N
4522	390	3375	1	berbeza	\N	ကွာခြားတယ်/ကွဲပြားတယ်/မတူဘူး	\N
4523	390	1693	2	berbeza	\N	ကွာခြားတယ်/ကွဲပြားတယ်/မတူဘူး	\N
2096	747	2189	1	semasa/apabila	\N	～တုန်း/～အချိန်\n	\N
2097	747	2187	2	semasa/apabila	\N	～တုန်း/～အချိန်	\N
2098	747	2180	3	semasa/apabila	\N	～တုန်း/～အချိန်	\N
2100	747	2178	5	semasa/apabila	\N	～တုန်း/～အချိန်\n	\N
2615	393	2880	1	peta	\N	မြေပုံ	\N
3390	5	3243	1	mérah	\N	အနီ/အနီရောင်	\N
3349	412	3229	1	tangan	\N	လက်	\N
2404	479	2803	1	nama	\N	နာမည်/အမည်	\N
2405	479	1714	2	nama	\N	နာမည်/အမည်	\N
2406	479	1965	3	nama	\N	နာမည်/အမည်	\N
3708	610	3391	1	menunggu (tunggu) 	\N	စောင့်တယ်	\N
3709	610	3390	2	menunggu (tunggu) 	\N	စောင့်တယ်	\N
2856	378	2982	1	merokok	\N	ဆေးလိပ်	\N
2857	378	2229	2	merokok	\N	ဆေးလိပ်	\N
4574	841	3907	1	tidak boléh	\N	မဖြစ်ဘူး/မရဘူး\n	\N
4484	834	3861	1	suis	\N	ခလုတ်/မီးခလုတ်	\N
4485	834	1748	2	suis	\N	ခလုတ်/မီးခလုတ်	\N
3806	239	3458	1	petang/malam	\N	ပီအမ်/ညနေပိုင်း/နေ့လယ်၁၂:၀၀မှည၁၂:၀၀ထိအချိန်အပိုင်းအခြား	\N
3807	239	1768	2	petang/malam	\N	ပီအမ်/ညနေပိုင်း/နေ့လယ်၁၂:၀၀မှည၁၂:၀၀ထိအချိန်အပိုင်းအခြား	\N
3391	3	3244	1	biru	\N	အပြာ/အပြာရောင်	\N
4282	261	3770	2	entahlah/baiklah	\N	ဘယ်လိုပြောရမလဲ/ကဲ\n	\N
4283	261	3771	1	entahlah/baiklah	\N	ဘယ်လိုပြောရမလဲ/ကဲ\n	\N
2707	701	2920	2	lintas	\N	ကူးတယ်/ဖြတ်ကူးတယ်	\N
2708	701	2921	1	lintas	\N	ကူးတယ်/ဖြတ်ကူးတယ်	\N
899	346	1810	1	membersihkan  	\N	သန့်ရှင်းရေး	\N
1508	490	2100	1	bagasi	\N	အထုပ်/အထုပ်အပိုး/ဝန်ထုပ်	\N
1509	490	1794	2	bagasi	\N	အထုပ်/အထုပ်အပိုး/ဝန်ထုပ်	\N
2150	643	2179	1	bawa	\N	သယ်တယ်/ယူထားတယ်/ကိုင်ထားတယ်	\N
2152	643	2249	3	bawa	\N	သယ်တယ်/ယူထားတယ်/ကိုင်ထားတယ်	\N
2154	643	1794	5	bawa	\N	သယ်တယ်/ယူထားတယ်/ကိုင်ထားတယ်	\N
3410	487	3260	1	barat	\N	အနောက်/အနောက်ဘက်	\N
3922	528	3529	2	awal	\N	စောတယ်	\N
3923	528	3528	1	awal	\N	စောတယ်	\N
4616	260	3444	1	malam ini	0	ဒီည\n	0
4617	260	3445	2	malam ini	0	ဒီည\n	0
4618	260	1813	3	malam ini	0	ဒီည\n	0
4412	631	3826	3	semua	\N	အားလုံး	\N
4413	631	3827	2	semua	\N	အားလုံး	\N
4414	631	3828	1	semua	\N	အားလုံး	\N
2696	289	2914	1	basikal	\N	စက်ဘီး	\N
2697	289	2913	2	basikal	\N	စက်ဘီး	\N
2698	289	2041	3	basikal	\N	စက်ဘီး	\N
3385	310	3239	2	putih	\N	အဖြူ/အဖြူရောင် 	\N
3386	310	3237	1	putih	\N	အဖြူ/အဖြူရောင် 	\N
4067	165	3649	1	kertas	\N	စက္ကူ/စာရွက်\n	\N
4068	165	3648	2	kertas	\N	စက္ကူ/စာရွက်\n	\N
3137	325	3119	1	sukan	\N	အားကစား\n	\N
3138	325	1849	2	sukan	\N	အားကစား\n	\N
4131	60	3702	2	selalu	\N	အမြဲ/အမြဲတမ်း \n	\N
4132	60	3703	1	selalu	\N	အမြဲ/အမြဲတမ်း \n	\N
3980	638	3583	2	méter	\N	～မီတာ/မီတာ～	\N
3981	638	3584	1	méter	\N	～မီတာ/မီတာ～	\N
3276	230	3182	2	bahasa	\N	 ～ဘာသာ\n/～စာ/ ～စကား	\N
3277	230	3183	1	bahasa	\N	～ဘာသာ\n/～စာ/ ～စကား	\N
2964	531	3040	1	cerah	\N	နေသာတယ်	\N
2965	531	3041	2	cerah	\N	နေသာတယ်	\N
4165	731	3722	2	mungkin	\N	လိမ့်မယ်/ဖြစ်လိမ့်မယ်	\N
4166	731	3723	1	mungkin	\N	လိမ့်မယ်/ဖြစ်လိမ့်မယ်	\N
3084	774	3093	2	pekerja	\N	ဆိုင်ဝန်ထမ်း/ဆိုင်သမား/အရောင်းစာရေး\n	\N
3085	774	3094	1	pekerja	\N	ဆိုင်ဝန်ထမ်း/ဆိုင်သမား/အရောင်းစာရေး\n	\N
2658	445	2900	1	jam	\N	နာရီ\n\n	\N
2659	445	1919	2	jam	\N	နာရီ\n\n	\N
3358	64	2079	1	adik perempuan	\N	ညီမလေး/နှမလေး	\N
3359	64	2099	2	adik perempuan	\N	ညီမလေး/နှမလေး	\N
3306	33	3199	1	manis	\N	ချိုတယ်\n	\N
4075	460	3656	2	burung	\N	ငှက်/ကြက်ငှက်	\N
4076	460	3657	1	burung	\N	ငှက်/ကြက်ငှက်	\N
3467	675	3287	1	bulan depan	\N	နောက်လ/လာမယ့်လ	\N
3468	675	1942	2	bulan depan	\N	နောက်လ/လာမယ့်လ	\N
2521	332	2847	2	pelajar	\N	တပည့်	\N
2522	332	2848	1	pelajar	\N	တပည့်	\N
2940	427	3023	2	cuaca	\N	မိုးလေ၀သ/ရာသီဥတုအခြေအနေ/ရာသီဥတု\n	\N
2941	427	3024	1	cuaca	\N	မိုးလေ၀သ/ရာသီဥတုအခြေအနေ/ရာသီဥတု\n	\N
2924	462	3017	1	ambil	\N	ရိုက်တယ်/ရိုက်ကူးတယ်	\N
2540	267	2855	1	karangan	\N	စာစီစာကုံး 	\N
2541	267	2854	2	karangan	\N	စာစီစာကုံး 	\N
2446	237	2820	1	kopi	\N	ကော်ဖီ	\N
2447	233	2821	1	téｈ	\N	လက်ဖက်ရည်	\N
2912	166	3007	2	kaméra	\N	ကင်မရာ 	\N
2913	166	3008	1	kaméra	\N	ကင်မရာ 	\N
3204	536	3143	1	nombor	\N	နံပါတ်	\N
2492	294	2840	2	tutup	\N	ပိတ်တယ်	\N
2493	294	2841	1	tutup	\N	ပိတ်တယ်	\N
3616	124	3349	2	ingat/hafal	\N	မှတ်တယ်/မှတ်မိတယ်	\N
3617	124	3350	1	ingat/hafal	\N	မှတ်တယ်/မှတ်မိတယ်	\N
3054	117	2764	1	perut	\N	ဗိုက်/ဝမ်းဗိုက်\n\n	\N
3800	673	3453	1	malam	\N	ည	\N
3801	673	3452	2	malam	\N	ည	\N
4427	578	3839	2	dekat	\N	～အနားတဝိုက်	\N
4428	578	3840	1	dekat	\N	～အနားတဝိုက်	\N
3614	106	3348	2	tekan	\N	နှိပ်တယ်/ဖိတယ်\n	\N
3615	106	2798	1	tekan	\N	နှိပ်တယ်/ဖိတယ်\n	\N
4580	433	3058	2	pintu	\N	တံခါး/တံခါးမ	\N
4621	318	3712	1	terus/sekejap lagi	0	ချက်ချင်း	0
4622	318	3713	2	terus/sekejap lagi	0	ချက်ချင်း	0
2306	389	2782	1	dekat	\N	နီးတယ်	\N
2307	389	2055	2	dekat	\N	နီးတယ်	\N
3899	65	3515	1	tidak suka/tidak sedap	\N	မကြိုက်ဘူး/မုန်းတယ်/မလုပ်ချင်ဘူး\n	\N
3900	65	3514	2	tidak suka/tidak sedap	\N	မကြိုက်ဘူး/မုန်းတယ်/မလုပ်ချင်ဘူး\n	\N
3901	65	2056	3	tidak suka/tidak sedap	\N	မကြိုက်ဘူး/မုန်းတယ်/မလုပ်ချင်ဘူး\n	\N
4396	368	3812	2	banyak	\N	များများ/အများကြီး 	\N
4397	368	3813	1	banyak	\N	များများ/အများကြီး 	\N
3701	700	3386	1	beri	\N	လှမ်းပေးတယ်/ပေးလိုက်တယ်	\N
3515	350	3297	2	sana/itu	\N	အဲဒီ/အဲဒီနေရာ	\N
3516	350	3298	1	sana/itu	\N	အဲဒီ/အဲဒီနေရာ	\N
1571	502	2120	1	minuman	\N	သောက်စရာ \n	\N
3808	282	3459	2	masa	\N	အချိန်	\N
3809	282	3460	1	masa	\N	အချိန်	\N
4016	491	3615	2	berita	\N	သတင်း	\N
4017	491	3616	1	berita	\N	သတင်း	\N
3330	659	3217	1	makan malam	\N	ညစာ	\N
3331	659	2123	2	makan malam	\N	ညစာ	\N
3608	79	3346	2	menjual (jual) 	\N	ရောင်းတယ်	\N
3609	79	3344	1	menjual (jual) 	\N	ရောင်းတယ်	\N
3242	705	3164	1	pakai	\N	ဝတ်တယ်	\N
3243	705	1481	2	pakai	\N	ဝတ်တယ်	\N
3744	340	3415	1	minggu lepas	\N	ရှေ့အပတ်/ပြီးခဲ့တဲ့အပတ်\n	\N
1099	27	2158	1	abang	\N	အစ်ကို/ကိုကို	\N
3666	377	3373	2	meminta (minta) 	\N	မှာတယ်/ခိုင်းတယ်/တောင်းဆိုတယ်\n	\N
3667	377	3374	1	meminta (minta) 	\N	မှာတယ်/ခိုင်းတယ်/တောင်းဆိုတယ်	\N
3512	22	3294	2	itu	\N	ဟို/ဟိုဘက်\n	\N
3513	22	3295	1	itu	\N	ဟို/ဟိုဘက်\n	\N
4268	450	3764	2	yang mana/mana	\N	ဘယ်/ဘယ်ဟာ/ဘာ/ဘယ်ဘက်	\N
4269	450	3765	1	yang mana/mana	\N	ဘယ်/ဘယ်ဟာ/ဘာ/ဘယ်ဘက်	\N
3802	708	3454	2	malam	\N	ည	\N
3803	708	3455	1	malam	\N	ည	\N
3836	707	3476	1	gelap	\N	မှောင်တယ်	\N
3837	707	2206	2	gelap	\N	မှောင်တယ်	\N
2654	498	2899	1	tidur	\N	အိပ်တယ်/အိပ်ပျော်တယ်\n	\N
2655	498	1389	2	tidur	\N	အိပ်တယ်/အိပ်ပျော်တယ်	\N
695	108	2213	1	téh	\N	လက်ဖက်ရည်/ရေနွေးကြမ်း	\N
696	108	2247	2	téh	\N	လက်ဖက်ရည်/ရေနွေးကြမ်း	\N
4557	300	3893	1	sepuluh	0	ဆယ်/တစ်ဆယ်	\N
3842	706	3479	1	panas	\N	ပူတယ်	\N
3843	706	3480	2	panas	\N	ပူတယ်	\N
4266	453	3762	1	siapa	\N	ဘယ်သူ/ဘယ်ပုဂ္ဂိုလ်	\N
4267	453	3763	2	siapa	\N	ဘယ်သူ/ဘယ်ပုဂ္ဂိုလ်	\N
2350	188	1322	1	setém	\N	တံဆိပ်ခေါင်း	\N
2349	510	2791	1	poskad	\N	ပို့စကတ်	\N
3804	242	3456	2	pagi	\N	အေအမ်/မနက်ပိုင်း/ည၁၂:၀၀မှနေ့လယ်၁၂:၀၀ထိအချိန်အပိုင်းအခြား	\N
3805	242	3457	1	pagi	\N	အေအမ်/မနက်ပိုင်း/ည၁၂:၀၀မှနေ့လယ်၁၂:၀၀ထိအချိန်အပိုင်းအခြား	\N
4563	168	3215	1	pedas	\N	စပ်တယ်	\N
4564	168	1408	2	pedas	\N	စပ်တယ်	\N
4565	168	1409	3	pedas	\N	စပ်တယ်	\N
3693	697	3383	1	lupa/tertinggal	\N	မေ့တယ်/မေ့လျော့တယ်	\N
3694	697	3382	2	lupa/tertinggal	\N	မေ့တယ်/မေ့လျော့တယ်	\N
3695	697	1473	3	lupa/tertinggal	\N	မေ့တယ်/မေ့လျော့တယ်	\N
2392	533	2800	1	nombor	\N	နံပါတ်～	\N
2393	533	1647	2	nombor	\N	နံပါတ်～	\N
3431	116	3279	1	déwasa	\N	လူကြီး/အရွယ်ရောက်	\N
3018	766	3064	1	jawapan	\N	အဖြေ	\N
3019	766	1971	2	jawapan	\N	အဖြေ	\N
3537	339	3311	2	bulan lepas	\N	ရှေ့လ/လာမယ့်လ	\N
3538	339	3300	1	bulan lepas	\N	ရှေ့လ/လာမယ့်လ	\N
4447	689	3853	2	réstoran	\N	စားသောက်ဆိုင်	\N
4448	689	2805	1	réstoran	\N	စားသောက်ဆိုင်	\N
2868	408	2987	1	bekerja	\N	အလုပ်လုပ်တယ်	\N
3286	333	3189	1	baju sejuk	\N	ဆွယ်တာ\n	\N
2799	264	2958	1	ikan	\N	ငါး	\N
3219	807	3150	2	pasport	\N	ပတ်စပို့/နိုင်ငံကူးလက်မှတ်	\N
3220	807	3151	1	pasport	\N	ပတ်စပို့/နိုင်ငံကူးလက်မှတ်	\N
3346	524	3226	1	hidung	\N	နှာ/နှာခေါင်း	\N
3299	90	2774	1	pénsél	\N	ခဲတံ	\N
3699	696	3385	1	faham	\N	နားလည်တယ်/သဘောပေါက်တယ်	\N
3700	696	3384	2	faham	\N	နားလည်တယ်/သဘောပေါက်တယ်	\N
3061	768	3078	2	khabar	\N	အဆက်အသွယ်	\N
3062	768	3079	1	khabar	\N	အဆက်အသွယ်	\N
3684	752	3378	1	mengambil (ambil) 	\N	ယူတယ်	\N
3685	752	3379	2	mengambil (ambil) 	\N	ယူတယ်	\N
4531	301	3879	1	minggu	\N	 ～ပတ်ကြာ	\N
4418	532	3830	2	setengah	\N	ခွဲ/(တစ်)ဝက်	\N
3902	363	3516	2	sangat suka	\N	အကြိုက်ဆုံး/အရမ်းကြိုက်တယ်	\N
3903	363	3517	1	sangat suka	\N	အကြိုက်ဆုံး/အရမ်းကြိုက်တယ်	\N
4377	58	3795	1	bersama	\N	အတူတူ	\N
4378	58	3796	2	bersama	\N	အတူတူ	\N
4379	58	3797	3	bersama	\N	အတူတူ	\N
3093	781	3098	2	kad krédit	\N	အကြွေးဝယ်ကတ်(/ခရက်ဒစ်ကတ်)	\N
3094	781	3099	1	kad krédit	\N	အကြွေးဝယ်ကတ်(/ခရက်ဒစ်ကတ်)	\N
4174	607	3729	1	lagi	\N	ထပ်ပြီး/နောက်ထပ်/နောက်မှ	\N
4175	607	3728	2	lagi	\N	ထပ်ပြီး/နောက်ထပ်/နောက်မှ	\N
4176	607	2562	3	lagi	\N	ထပ်ပြီး/နောက်ထပ်/နောက်မှ	\N
4519	70	3704	1	segalanya	\N	အစစအရာရာ/အမျိုးမျိုး\n	\N
4516	680	3875	2	baik	\N	ထူးချွန်တယ်/ခမ်းနားတယ်/ထည်ဝါတယ်	\N
4517	680	3876	1	baik	\N	ထူးချွန်တယ်/ခမ်းနားတယ်/ထည်ဝါတယ်	\N
3838	7	3477	2	terang	\N	အလင်းရောင်ကောင်းတယ်/လင်းလင်းထိန်ထိန်ရှိတယ်/မျက်နှာရွှင်တယ်/ဖော်ရွေတယ်	\N
3839	7	3478	1	terang	\N	အလင်းရောင်ကောင်းတယ်/လင်းလင်းထိန်ထိန်ရှိတယ်/မျက်နှာရွှင်တယ်/ဖော်ရွေတယ်	\N
3584	11	3332	1	mengangkat (angkat)	\N	မြှောက်တယ်/ပင့်တယ်/တင်တယ်\n\n	\N
3585	11	3333	2	mengangkat (angkat)	\N	မြှောက်တယ်/ပင့်တယ်/တင်တယ်\n	\N
3326	13	3216	2	sarapan	\N	မနက်စာ	\N
3327	13	3208	1	sarapan	\N	မနက်စာ	\N
3767	14	3429	2	lusa	\N	သန်ဘက်ခါ 	\N
3768	14	3430	1	lusa	\N	သန်ဘက်ခါ 	\N
2527	18	2851	2	bermain	\N	ကစားတယ်/လျှောက်လည်တယ်\n	\N
2528	18	2852	1	bermain	\N	ကစားတယ်/လျှောက်လည်တယ်\n	\N
2958	19	3035	2	panas	\N	နွေးတယ်/နွေးထွေးတယ်\n	\N
2959	19	3036	1	panas	\N	နွေးတယ်/နွေးထွေးတယ်\n	\N
2242	20	2763	1	otak/kepala	\N	ခေါင်း/ဦးခေါင်း/ဉာဏ်/ဉာဏ်ရည်	\N
2243	20	2755	2	otak/kepala	\N	ခေါင်း/ဦးခေါင်း/ဉာဏ်/ဉာဏ်ရည်	\N
3854	23	3488	2	tebal	\N	ထူတယ်	\N
3855	23	3486	1	tebal	\N	ထူတယ်	\N
3514	24	3296	1	sana	\N	ဟိုက/ဟိုဘက်	\N
3414	28	3264	1	kakak	\N	(မိမိရဲ့)အစ်မ/(မိမိရဲ့)မမ	\N
4280	29	3768	2	itu	\N	အဲဒီ/ဟို\n	\N
4281	29	3769	1	itu	\N	အဲဒီ/ဟို\n	\N
2895	31	2997	1	mandi	\N	(ရေ)ချိုးတယ်/လောင်းတယ်	\N
2626	32	2885	2	berbahaya	\N	အန္တရာယ်ရှိတယ်/အန္တရာယ်များတယ်\n	\N
2627	32	2886	1	berbahaya	\N	အန္တရာယ်ရှိတယ်/အန္တရာယ်များတယ်\n	\N
4627	37	3335	1	ada	0	(သက်မဲ့အရာ)ရှိတယ်\n	0
4628	37	3334	2	ada	0	(သက်မဲ့အရာ)ရှိတယ်	0
4089	48	3670	2	kolam	\N	ကန်/ရေကန်/အိုင်/ရေအိုင်	\N
4090	48	3671	1	kolam	\N	ကန်/ရေကန်/အိုင်/ရေအိုင်	\N
2270	50	2767	1	kerusi	\N	ခုံ/ထိုင်ခုံ/ကုလားထိုင်\n	\N
2858	51	2983	2	sibuk	\N	အလုပ်များတယ်/အလုပ်ရှုတ်တယ်	\N
2859	51	2984	1	sibuk	\N	အလုပ်များတယ်/အလုပ်ရှုတ်တယ်	\N
4548	53	3884	1	se-	\N	တစ်	\N
3779	54	3438	2	satu hari	\N	တစ်နေ့/တစ်ရက်	\N
3780	54	3439	1	satu hari	\N	တစ်နေ့/တစ်ရက်	\N
3941	57	3545	1	lima hari bulan	\N	ငါးရက်/ငါးရက်နေ့ 	\N
3932	59	3536	1	lima biji	\N	ငါးခု \n	\N
3271	63	3177	2	maksud	\N	အဓိပ္ပာယ်	\N
3272	63	3178	1	maksud	\N	အဓိပ္ပာယ်	\N
2483	66	2836	1	pintu masuk	\N	ဝင်ပေါက်/အဝင်၀ \n	\N
3404	754	3254	2	ada	\N	(သက်ရှိသတ္တဝါ)ရှိတယ်\n	\N
3405	754	3255	1	ada	\N	(သက်ရှိသတ္တဝါ)ရှိတယ်\n	\N
3591	67	3338	2	perlu	\N	လိုတယ်	\N
3592	67	3339	1	perlu	\N	လိုတယ်	\N
2596	72	2869	1	belakang	\N	နောက်/အနောက်\n	\N
2597	72	2761	2	belakang	\N	နောက်/အနောက်\n	\N
3856	73	3489	2	nipis	\N	ပါးတယ်/ပါးပါး	\N
3857	73	3490	1	nipis	\N	ပါးတယ်/ပါးပါး	\N
3603	77	3342	2	lahir	\N	မွေးတယ်/မွေးဖွားတယ်	\N
3604	77	3343	1	lahir	\N	မွေးတယ်/မွေးဖွားတယ်	\N
3913	80	3522	2	bising	\N	ဆူတယ်/ညံတယ်/နားငြီးတယ်\n	\N
3914	80	3523	1	bising	\N	ဆူတယ်/ညံတယ်/နားငြီးတယ်	\N
3284	81	3187	1	kot	\N	အပေါ်ထပ်အင်္ကျီ/အနွေးထည်	\N
4061	84	3644	2	pawagam	\N	ရုပ်ရှင်ရုံ	\N
4062	84	3645	1	pawagam	\N	ရုပ်ရှင်ရုံ	\N
4382	95	3798	1	besar	\N	အကြီးကြီး	\N
4383	95	3799	2	besar	\N	အကြီးကြီး	\N
4392	96	3808	2	ramai	\N	 အများကြီး 	\N
4393	96	3809	1	ramai	\N	 အများကြီး 	\N
3316	98	3209	1	kuih	\N	မုန့်\n	\N
3415	102	3265	1	isteri	\N	အမျိုးသမီး/ဇနီး/မိန်းမ/မယား	\N
3427	103	3275	1	pak cik	\N	(သူတစ်ပါးရဲ့)ဦးလေး/(သူတစ်ပါးရဲ့)ဦးဦး	\N
3429	104	3277	1	datuk	\N	(သူတစ်ပါးရဲ့)အဖိုး/(သူတစ်ပါးရဲ့)ဖိုးဖိုး	\N
2478	109	2834	1	tandas	\N	သန့်စင်ခန်း/အိမ်သာ	\N
3434	112	3282	1	lelaki	\N	ယောက်ျားလေး/ကောင်လေး	\N
3435	113	3283	1	budak lelaki	\N	ယောက်ျားလေး/ကောင်လေး	\N
3759	114	3421	2	dua hari lepas	\N	တနေ့က/တမြန်နေ့က 	\N
3760	114	3422	1	dua hari lepas	\N	တနေ့က/တမြန်နေ့က 	\N
3541	115	3314	2	dua tahun lepas	\N	တနှစ်က/တမြန်နှစ်က 	\N
3542	115	3315	1	dua tahun lepas	\N	တနှစ်က/တမြန်နှစ်က 	\N
3416	119	3266	1	abang	\N	(သူတစ်ပါးရဲ့)အစ်ကို/(သူတစ်ပါးရဲ့)ကိုကို 	\N
3411	120	3261	1	kakak	\N	(သူတစ်ပါးရဲ့)အစ်မ/(သူတစ်ပါးရဲ့)မမ	\N
3428	121	3276	1	ibu saudara	\N	(သူတစ်ပါးရဲ့)အဒေါ်/(သူတစ်ပါးရဲ့)ဒေါ်ဒေါ်	\N
3430	122	3278	1	nénék	\N	(သူတစ်ပါးရဲ့)အဖွား/(သူတစ်ပါးရဲ့)ဖွားဖွား	\N
2291	123	2779	1	mandi	\N	ရေချိုးခန်း/ရေချိုးကန် 	\N
2292	123	1745	2	mandi	\N	ရေချိုးခန်း/ရေချိုးကန် 	\N
2614	125	2879	1	pegawai polis	\N	ရဲ/ရဲသား\n	\N
3858	126	3491	2	berat	\N	လေးတယ်	\N
3859	126	3492	1	berat	\N	လေးတယ်	\N
2485	129	2838	1	turun	\N	ဆင်းတယ်	\N
3426	133	3274	1	budak perempuan	\N	မိန်းကလေး/ကောင်မလေး\n	\N
3212	136	2939	2	warga asing	\N	နိုင်ငံခြားသား 	\N
3213	136	3146	1	warga asing	\N	နိုင်ငံခြားသား 	\N
2476	138	2833	1	tangga	\N	လှေခါး 	\N
3172	142	3130	1	balik	\N	ပြန်တယ်	\N
3625	144	3352	2	mengambil (ambil)	\N	ကြာတယ်	\N
3626	144	3353	1	mengambil (ambil)	\N	ကြာတယ်	\N
3173	145	3131	2	kunci	\N	သော့/သော့ချောင်း/သော့အိမ်	\N
3174	145	3132	1	kunci	\N	သော့/သော့ချောင်း/သော့အိမ်	\N
3535	148	3310	2	bulan	\N	～လကြာ \n	\N
3536	148	3305	1	bulan	\N	～လကြာ \n	\N
3291	150	3194	1	mamakai	\N	တပ်တယ်/ချိတ်တယ်\n	\N
2322	151	2786	1	payung	\N	ထီး 	\N
2988	711	3052	1	angin	\N	လေ	\N
2989	711	3030	2	angin	\N	လေ	\N
3207	155	3145	1	orang	\N	～ပုဂ္ဂိုလ်	\N
3273	156	3179	1	katakana	\N	ခတခန/ခတခနအက္ခရာ\n	\N
3529	157	3307	1	bulan	\N	～လ/～လပိုင်း	\N
3530	157	3306	2	bulan	\N	～လ/～လပိုင်း	\N
2451	159	2825	1	cawan	\N	ခွက် 	\N
2900	160	3002	1	rumah	\N	အိမ်/အိမ်ထောင်\n\n	\N
3399	161	3249	1	penjuru	\N	ထောင့်/အစွန်	\N
2672	163	2902	1	pasu bunga	\N	ပန်းအိုး 	\N
4530	164	3878	1	pakai	\N	ဆောင်းတယ်\n	\N
3739	167	3410	1	hari Selasa	\N	အင်္ဂါ/အင်္ဂါနေ့	\N
3340	169	3221	1	badan	\N	ကိုယ်ခန္ဓာ/ခန္ဓာကိုယ်	\N
4419	171	3831	2	nak	\N	(တစ်စုံတစ်ယောက်က)～ချင်နေတယ်	\N
4420	171	3832	1	nak	\N	(တစ်စုံတစ်ယောက်က)～ချင်နေတယ်	\N
3864	172	3494	1	ringan	\N	ပေါ့တယ်	\N
3865	172	3493	2	ringan	\N	ပေါ့တယ်	\N
2426	173	2809	2	kari	\N	ကာရီ/မဆလာဟင်း	\N
2427	173	2810	1	kari	\N	ကာရီ/မဆလာဟင်း	\N
2645	174	2895	1	kaléndar	\N	ပြက္ခဒိန်	\N
2646	174	2896	2	kaléndar	\N	ပြက္ခဒိန်	\N
2699	175	2915	2	sungai	\N	ချောင်း/မြစ်	\N
2700	175	2916	1	sungai	\N	ချောင်း/မြစ်	\N
3400	176	3250	2	sebelah	\N	～ဘက်ခြမ်း	\N
3401	176	3251	1	sebelah	\N	～ဘက်ခြမ်း	\N
3982	177	3585	2	comél	\N	ချစ်စရာကောင်းတယ်/ချစ်ဖို့ကောင်းတယ်	\N
3983	177	3586	1	comél	\N	ချစ်စရာကောင်းတယ်/ချစ်ဖို့ကောင်းတယ်	\N
4093	179	3674	2	pokok	\N	သစ်ပင်/အပင် 	1
4094	179	3675	1	pokok	\N	သစ်ပင်/အပင် 	\N
3393	180	3246	1	kuning	\N	အဝါ/အဝါရောင်	\N
3384	181	3238	1	kuning	\N	အဝါ/အဝါရောင်	\N
3629	182	3356	2	mati	\N	ငြိမ်းတယ်/(မီး)ပျက်တယ်\n	\N
3630	182	3357	1	mati	\N	ငြိမ်းတယ်/(မီး)ပျက်တယ်	\N
3058	183	2882	1	bertanya	\N	မေးတယ်	\N
2908	185	3005	1	gitar	\N	ဂီတာ	\N
3158	791	3126	2	kotor	\N	ညစ်ပတ်တယ်	\N
3159	791	3127	1	kotor	\N	ညစ်ပတ်တယ်	\N
2445	187	2819	1	kedai kopi	\N	ကော်ဖီဆိုင်	\N
2471	189	2832	1	tikét	\N	လက်မှတ်	\N
3761	190	3423	2	semalam	\N	မနေ့က	\N
3762	190	3424	1	semalam	\N	မနေ့က	\N
4642	844	3892	1	sembilan	0	ကိုး	0
4643	844	3916	2	sembilan	0	ကိုး	0
2796	192	2955	1	daging lembu	\N	အမဲသား	\N
2448	193	2822	1	susu lembu	\N	နွားနို့ 	\N
3421	196	3271	1	adik-beradik	\N	ညီအစ်ကိုမောင်နှမ	\N
2918	198	3011	2	tidak suka	\N	မုန်းတယ်/မကြိုက်ဘူး	\N
2919	198	3012	1	tidak suka	\N	မုန်းတယ်/မကြိုက်ဘူး	\N
3974	201	3577	2	kilogram	\N	ကီလိုဂရမ် 	\N
3975	201	3578	1	kilogram	\N	ကီလိုဂရမ် 	\N
3190	202	3136	1	bank	\N	ဘဏ်	\N
3191	202	2795	2	bank	\N	ဘဏ်	\N
13	205	2751	1	ubat	\N	ဆေး	\N
2802	206	2961	1	buah	\N	သစ်သီး/သစ်သီး၀လံ	\N
3347	207	3227	1	mulut	\N	ပါးစပ်/အ၀	\N
3215	210	3147	2	negara	\N	နိုင်ငံ/အမိနိုင်ငံ	\N
3216	210	2943	1	negara	\N	နိုင်ငံ/အမိနိုင်ငံ	\N
2946	211	3027	1	mendung	\N	မိုးအုံ့တယ်/တိမ်ထူတယ်\n	\N
2947	211	3026	2	mendung	\N	မိုးအုံ့တယ်/တိမ်ထူတယ်\n	\N
2978	212	3047	1	mendung	\N	မိုးအုံ့တယ်/တိမ်ထူတယ်\n	\N
2979	212	3048	2	mendung	\N	မိုးအုံ့တယ်/တိမ်ထူတယ်\n	\N
4583	213	3833	1	kira-kira	\N	～လောက် 	\N
4584	213	3834	2	kira-kira	\N	～လောက် 	\N
3978	215	3581	2	gram	\N	～ဂရမ်	\N
3979	215	3582	1	gram	\N	～ဂရမ်	\N
3387	218	3240	1	hitam	\N	အနက်/အနက်ရောင်/အမဲ/အမဲရောင်	\N
2612	220	2877	1	anggota polis	\N	ရဲ/ရဲဘက်ဆိုင်ရာ	\N
2613	220	2878	2	anggota polis	\N	ရဲ/ရဲဘက်ဆိုင်ရာ	\N
3783	221	3442	2	pagi tadi/pagi ini	\N	ဒီမနက်/မနက်က	\N
3784	221	3443	1	pagi tadi/pagi ini	\N	ဒီမနက်/မနက်က	\N
3643	225	3362	2	berkahwin	\N	လက်ထပ်တယ်	\N
3644	225	3361	1	berkahwin	\N	လက်ထပ်တယ်	\N
2286	227	2777	2	pintu masuk rumah	\N	အိမ်အဝင်၀	\N
2287	227	2776	1	pintu masuk rumah	\N	အိမ်အဝင်၀	\N
3957	229	3560	2	biji	\N	～ခု/～လုံး 	1
3958	229	3561	1	biji	\N	～ခု/～လုံး 	\N
4552	736	3888	1	lima	\N	ငါး	\N
2677	232	2907	1	persimpangan	\N	လမ်းဆုံ	\N
2610	234	2875	2	pondok polis	\N	ရဲကင်း/ရဲစခန်းငယ်	\N
2611	234	2876	1	pondok polis	\N	ရဲကင်း/ရဲစခန်းငယ်	\N
3285	236	3188	1	kot	\N	ကုတ်အင်္ကျီ 	\N
3945	240	3549	1	sembilan hari bulan	\N	ကိုးရက်/ကိုးရက်နေ့	\N
3936	241	3540	1	sembilan buah	\N	ကိုးခု/ကိုးလုံး 	\N
2574	243	2863	1	menjawab(jawab)	\N	ဖြေတယ်	\N
2450	246	2824	1	gelas	\N	ခွက်	\N
3278	248	3184	1	perkataan	\N	စကား	\N
3425	249	3273	1	kanak-kanak	\N	ကလေး	\N
2424	251	2807	1	nasi	\N	ထမင်း	\N
2425	251	2808	2	nasi	\N	ထမင်း	\N
2839	253	2975	2	membuat (buat) salinan	\N	မိတ္တူကူးတယ်/ကော်ပီကူးတယ်	\N
2840	253	2973	1	membuat (buat) salinan	\N	မိတ္တူကူးတယ်/ကော်ပီကူးတယ်	\N
4423	256	3835	2	lebih kurang/semasa	\N	～ဝန်းကျင်/～တုန်းက	\N
4424	256	3836	1	lebih kurang/semasa	\N	～ဝန်းကျင်/～တုန်းက	\N
4109	258	3686	2	minggu ini	\N	ဒီအပတ်	\N
4110	258	3416	1	minggu ini	\N	ဒီအပတ်	\N
4355	259	3790	2	seperti ini	\N	ဒီလောက်/ဒီလို	\N
4356	259	3791	1	seperti ini	\N	ဒီလောက်/ဒီလို	\N
3959	262	3562	2	tahun	\N	(အသက်)～နှစ်	\N
3960	262	3563	1	tahun	\N	(အသက်)～နှစ်	\N
2323	263	2787	1	dompét	\N	ပိုက်ဆံအိတ်	\N
3815	265	3465	2	dulu	\N	အရင်	\N
3816	265	3466	1	dulu	\N	အရင်	\N
3655	269	3366	1	berpayung	\N	(ထီး)ဆောင်းတယ်	\N
2452	272	2826	1	gula	\N	သကြား	\N
3557	275	3320	1	dua tahun akan datang	\N	နောက်နှစ်ရဲ့နောက်တစ်နှစ်	\N
3558	275	3321	2	dua tahun akan datang	\N	နောက်နှစ်ရဲ့နောက်တစ်နှစ်	\N
4550	734	3886	1	tiga	\N	သုံး	\N
3432	276	3280	1	Encik/Puan/Cik	\N	သုံး	\N
2702	277	2918	1	berjalan-jalan	\N	လမ်းလျှောက်ခြင်း	\N
4585	278	3913	2	empat	\N	လေး	\N
4586	278	3914	1	empat	\N	လေး	\N
4592	278	3887	3	empat	0	လေး	\N
3338	280	3220	2	garam	\N	ဆား	\N
3339	280	3219	1	garam	\N	ဆား\n	\N
4119	281	3692	2	tetapi	\N	ဒါပေမယ့် 	\N
4120	281	3693	1	tetapi	\N	ဒါပေမယ့် 	\N
4554	287	3890	1	tujuh	\N	ခုနစ်/ခွန်	\N
4596	287	3915	2	tujuh	0	ခုနစ်/ခွန်	\N
2689	290	2909	2	keréta	\N	ကား/မော်တော်ကား	\N
2690	290	2910	1	keréta	\N	ကား/မော်တော်ကား	\N
16	291	2753	1	mati	\N	သေတယ်	\N
2894	299	2996	1	mandi	\N	ရေချိုးတယ်	\N
3812	397	3462	1	semasa	\N	～ချိန်/～နေတုန်း	\N
3994	305	3595	2	kuat	\N	သန်စွမ်းတယ်/ခိုင်မာတယ်	\N
3995	305	3596	1	kuat	\N	သန်စွမ်းတယ်/ခိုင်မာတယ်\n	\N
3309	306	3202	1	kicap	\N	ပဲငံပြာရည်	\N
4545	309	3881	1	putih	\N	အဖြူ/အဖြူရောင်	\N
2871	314	2988	1	menghisap (hisap)	\N	(ဆေးလိပ်)သောက်တယ်/(အသက်)ရှူတယ်	\N
2872	314	2989	2	menghisap (hisap)	\N	(ဆေးလိပ်)သောက်တယ်/(အသက်)ရှူတယ်	\N
3289	315	3192	1	skirt	\N	စကတ်	\N
4425	317	3837	2	lébih	\N	～ကျော်	\N
4426	317	3838	1	lébih	\N	～ကျော်	\N
3917	319	3526	2	sedikit	\N	နည်းတယ်/နည်းနည်း	\N
3918	319	3527	1	sedikit	\N	နည်းတယ်/နည်းနည်း	\N
2962	321	3038	2	sejuk	\N	အေးတယ်/အေးမြတယ်	\N
2963	321	3039	1	sejuk	\N	အေးတယ်/အေးမြတယ်	\N
4404	322	3818	2	démi	\N	～စီ	\N
4405	322	3819	1	démi	\N	～စီ	\N
2932	323	3021	1	pemanas	\N	မီးဖို/အနွေးစက်/အပူပေးစက်	\N
2933	323	3019	2	pemanas	\N	မီးဖို/အနွေးစက်/အပူပေးစက်	\N
2432	324	2812	1	sudu	\N	ဇွန်း	\N
3290	328	3193	1	selipar	\N	ဖိနပ်အပါး/ဖိနပ်ပါး 	\N
4057	334	3640	2	sabun	\N	ဆပ်ပြာ	\N
4058	334	3641	1	sabun	\N	ဆပ်ပြာ	\N
4547	337	3883	1	kosong	\N	သုံည	\N
4559	338	3895	1	ribu	\N	ထောင်/တစ်ထောင်	\N
2890	342	2995	1	mencuci pakaian	\N	လျှော်စရာ/လျှော်စရာအဝတ်	\N
2897	343	2999	1	mencuci pakaian	\N	အဝတ်လျှော်တယ်	\N
2896	347	2998	1	membersihkan	\N	သန့်ရှင်းရေးလုပ်တယ်	\N
4123	348	3696	2	dan	\N	ပြီးတော့/နောက်ပြီးတော့ 	\N
4124	348	3697	1	dan	\N	ပြီးတော့/နောက်ပြီးတော့  	\N
2631	354	2890	2	dekat	\N	ဘေး/နံဘေး\n	\N
2632	354	2889	1	dekat	\N	ဘေး/နံဘေး\n	\N
4508	358	3872	2	baiklah	\N	ဒါဆိုရင်/ပြီးရင်	\N
4509	358	3873	1	baiklah	\N	ဒါဆိုရင်/ပြီးရင်	\N
3961	359	3564	2	buah	\N	～စီး/～လုံး 	\N
3962	359	3565	1	buah	\N	～စီး/～လုံး 	\N
2761	361	2940	2	kedutaan	\N	သံရုံး 	\N
2762	361	2941	1	kedutaan	\N	သံရုံး 	\N
3999	364	3600	2	penting	\N	အရေးကြီးတယ်	\N
4000	364	3599	1	penting	\N	အရေးကြီးတယ်	\N
2288	365	2778	1	dapur	\N	မီးဖိုချောင်/မီးဖိုခန်း	\N
2691	369	2911	2	téksi	\N	တက္ကဆီ/အငှားယာဉ်	\N
2692	369	2912	1	téksi	\N	တက္ကဆီ/အငှားယာဉ်	\N
4581	370	3911	1	sahaja	\N	～ပဲ/～တည်းပဲ/～လောက် 	\N
4582	370	3912	1	sahaja	\N	～ပဲ/～တည်းပဲ/～လောက် 	\N
4406	372	3820	2	X-X	\N	～တွေ\n	\N
4407	372	3821	1	X-X	\N	～တွေ\n	\N
4027	374	3621	2	lébar/menegak	\N	အနံ/ဒေါင်လိုက်	\N
4028	374	3622	1	lébar/menegak	\N	အနံ/ဒေါင်လိုက်	\N
4203	383	3746	1	siapa	\N	ဘယ်သူ	\N
4204	383	1308	2	siapa	\N	ဘယ်သူ	\N
4205	383	1900	3	siapa	\N	ဘယ်သူ	\N
4206	384	3747	2	sesiapa	\N	တစ်ယောက်ယောက်/ဘယ်သူ	\N
4207	384	3748	1	sesiapa	\N	တစ်ယောက်ယောက်/ဘယ်သူ	\N
4025	385	3619	2	hari jadi	\N	မွေးနေ့	\N
4026	385	3620	1	hari jadi	\N	မွေးနေ့	\N
4150	386	3716	2	semakin	\N	တဖြည်းဖြည်း	\N
4151	386	3717	1	semakin	\N	တဖြည်းဖြည်း	\N
4384	388	3800	2	kecil	\N	သေးသေး/သေးသေးလေး 	\N
4385	388	3801	1	kecil	\N	သေးသေး/သေးသေးလေး 	\N
2470	392	2831	1	keréta api bawah tanah	\N	မြေအောက်လိုင်း	\N
3389	395	3242	1	warna coklat	\N	အညိုရောင်/အနီရောင်	\N
3311	396	3204	2	mangkuk	\N	ပန်းကန်လုံး	\N
3312	396	3205	1	mangkuk	\N	ပန်းကန်လုံး	\N
3937	400	3541	1	satu hari bulan	\N	တစ်ရက်နေ့\n	\N
3354	402	3234	1	letih	\N	ပင်ပန်းတယ်	\N
24	404	2757	1	tiba	\N	ရောက်တယ်/ဆိုက်တယ်	\N
25	404	2758	2	tiba	\N	ရောက်တယ်/ဆိုက်တယ်	\N
1245	405	1533	1	méja	\N	စာရေးခုံ/စာကြည့်စားပွဲ	\N
4612	406	3162	1	membuat (buat) 	0	လုပ်တယ်/ထုတ်လုပ်တယ်\n	0
4613	406	3161	2	membuat (buat) 	0	လုပ်တယ်/ထုတ်လုပ်တယ်\n	0
3162	407	2898	1	pasang	\N	ထွန်းတယ်/ထွန်းညှိတယ်	\N
3844	410	3481	2	sejuk	\N	အေးတယ်/အေးအေး	\N
3845	410	3482	1	sejuk	\N	အေးတယ်/အေးအေး	\N
3055	414	3075	1	méja	\N	စားပွဲ	\N
2898	416	3000	2	keluar	\N	အပြင်ထွက်တယ်	\N
2899	416	3001	1	keluar	\N	အပြင်ထွက်တယ်	\N
2484	420	2837	1	pintu keluar	\N	ထွက်ပေါက်	\N
4032	431	3626	2	pintu	\N	တံခါး	\N
4033	431	3625	1	pintu	\N	တံခါး	\N
2976	432	3046	1	darjah	\N	ဒီဂရီ 	\N
2977	432	3045	2	darjah	\N	ဒီဂရီ 	\N
4083	438	3664	2	binatang	\N	တိရစ္ဆာန်	\N
4084	438	3665	1	binatang	\N	တိရစ္ဆာန်	\N
4528	440	3877	1	sepuluh	\N	တစ်ဆယ်	\N
2303	441	2781	1	jauh	\N	ဝေးတယ်	\N
3946	442	3550	1	sepuluh hari bulan	\N	ဆယ်ရက်/ဆယ်ရက်နေ့	\N
4163	444	3720	2	kadang-kadang	\N	တစ်ခါတလေ/ရံဖန်ရံခါ 	\N
4164	444	3721	1	kadang-kadang	\N	တစ်ခါတလေ/ရံဖန်ရံခါ 	\N
4014	447	3613	2	tempat	\N	နေရာ	\N
4015	447	3614	1	tempat	\N	နေရာ	\N
3540	448	3313	1	tahun	1	နှစ်	\N
4256	451	3756	2	yang mana	\N	ဘယ်/ဘယ်တစ်ခု	\N
4257	451	3757	1	yang mana	\N	ဘယ်/ဘယ်တစ်ခု	\N
2628	454	2887	2	sebelah	\N	ဘေးနား	\N
2629	454	2888	1	sebelah	\N	ဘေးနား	\N
4262	455	3760	2	yang mana	\N	ဘယ်/ဘယ်လို	\N
4263	455	3761	1	yang mana	\N	ဘယ်/ဘယ်လို	\N
2798	461	2957	1	daging ayam	\N	ကြက်သား	\N
2435	466	2815	2	pisau	\N	ဓား	\N
2436	466	2814	1	pisau	\N	ဓား	\N
4398	469	3814	2	sambil	\N	～ရင်း\n	\N
4399	469	3815	1	sambil	\N	～ရင်း\n	\N
4116	470	3690	2	menangis	\N	ငိုတယ်	\N
4117	470	3691	1	menangis	\N	ငိုတယ်	\N
2633	471	2891	2	kehilangan	\N	ဖျောက်ပစ်တယ်/ပျောက်သွားတယ်\n 	\N
2634	471	2892	1	kehilangan	\N	ဖျောက်ပစ်တယ်/ပျောက်သွားတယ်\n	\N
4402	475	3816	1	dan lain-lain	\N	～တွေ～တွေ/～စတာတွေ	\N
4403	475	3817	2	dan lain-lain	\N	～တွေ～တွေ/～စတာတွေ	\N
3934	476	3538	1	tujuh biji	\N	ခုနစ်ခု/ခုနစ်လုံး	\N
3944	478	3548	1	tujuh hari bulan	\N	ခုနစ်ရက်/ခုနစ်ရက်နေ့	\N
3731	481	3405	1	beratur	\N	စီတယ်/တန်းစီတယ်\n	\N
3732	481	3404	2	beratur	\N	စီတယ်/တန်းစီတယ်\n်	\N
3726	482	3402	2	tersusun/menyusun (susun)	\N	စီတယ်/တန်းစီတယ်	\N
3727	482	3403	1	tersusun/menyusun (susun)	\N	စီတယ်/တန်းစီတယ်	\N
3733	483	3406	2	menjadi (jadi) 	\N	ဖြစ်တယ်	\N
3734	483	3407	1	menjadi (jadi) 	\N	ဖြစ်တယ်	\N
4549	484	3885	1	dua	\N	နှစ်	1
3911	485	3520	2	meriah	\N	စည်ကားတယ်	\N
3912	485	3521	1	meriah	\N	စည်ကားတယ်	\N
2794	486	2953	2	daging	\N	အသား	\N
2795	486	2954	1	daging	\N	အသား	\N
3782	488	3441	1	hari bulan	\N	～ရက်/～နေ့/～ရက်နေ့	\N
3297	494	3198	1	menanggalkan (tanggal)	\N	ချွတ်တယ်	\N
3298	494	3195	2	menanggalkan (tanggal)	\N	ချွတ်တယ်	\N
3112	496	2981	1	tali léhér	\N	နက်ကတိုင်	\N
17	505	2754	1	gigi	\N	သွား	1
3965	507	3568	3	sudu/gelas	\N	～ခွက် \n	\N
3966	507	3569	2	sudu/gelas	\N	～ခွက် 	\N
3967	507	3570	1	sudu/gelas	\N	～ခွက် 	\N
3076	508	3088	2	tempat abu rokok	\N	ဆေးလိပ်ပြာခွက်	\N
3077	508	3089	1	tempat abu rokok	\N	ဆေးလိပ်ပြာခွက်	\N
3293	511	3196	2	memakai (pakai) 	\N	(စကတ်)ဝတ်တယ်/(ဖိနပ်)စီးတယ်	\N
3294	511	3197	1	memakai (pakai) 	\N	(စကတ်)ဝတ်တယ်/(ဖိနပ်)စီးတယ်	\N
2701	717	2917	1	jambatan	\N	တံတား	\N
3722	514	3398	2	bermula (mula)	\N	စတယ်/စတင်တယ်\n	\N
3723	514	3399	1	bermula (mula)	\N	စတယ်/စတင်တယ်\n	\N
4195	515	3744	2	terlébih dahulu/awal	\N	အစဆုံး/အရင်ဆုံး	\N
4196	515	3745	1	terlébih dahulu/awal	\N	အစဆုံး/အရင်ဆုံး	\N
3953	520	3556	2	dua puluh tahun	\N	အသက်နှစ်ဆယ် 	\N
3954	520	3557	1	dua puluh tahun	\N	အသက်နှစ်ဆယ် 	\N
4555	522	3891	1	lapan	\N	ရှစ်	\N
3947	523	3551	1	dua puluh hari bulan	\N	ရှစ်	\N
4091	725	3672	2	bunga	\N	ပန်း 	\N
4092	725	3673	1	bunga	\N	ပန်း 	\N
3269	525	3175	2	cerita/bercerita	\N	စကား	\N
3270	525	3176	1	cerita/bercerita	\N	စကား	\N
2726	716	2928	2	cepat	\N	မြန်တယ်\n	\N
2727	716	2929	1	cepat	\N	မြန်တယ်\n	\N
2351	529	2792	1	menampal (tampal)	\N	ကပ်တယ်	\N
3332	537	3206	2	makan malam	\N	ညစာ	\N
3333	537	3218	1	makan malam	\N	ညစာ	\N
4386	538	3802	2	separuh	\N	တစ်ဝက်/ထက်ခြမ်း	\N
4387	538	3803	1	separuh	\N	တစ်ဝက်/ထက်ခြမ်း	\N
3409	539	3259	1	timur	\N	အရှေ့/အရှေ့ဘက်	\N
3968	540	3571	3	ékor	\N	～ကောင်	\N
3969	540	3572	2	ékor	\N	～ကောင်	\N
3970	540	3573	1	ékor	\N	～ကောင်	\N
2923	541	3016	1	bermain (main)	\N	(ကြိုးတပ်တူရိယာ)တီးတယ်	\N
3876	542	3499	2	rendah	\N	ပုတယ်/နိမ့်တယ်	\N
3877	542	3500	1	rendah	\N	ပုတယ်/နိမ့်တယ်	\N
3928	546	3532	1	sebiji	\N	တစ်ခု/တစ်လုံး \n	\N
4010	549	3609	2	lapang	\N	အားတယ် 	\N
4011	549	3610	1	lapang	\N	အားတယ် 	\N
4558	550	3894	1	seratus	\N	ရာ/တစ်ရာ	\N
3274	553	3180	1	hiragana	\N	ဟီရဂန/ဟီရဂနအက္ခရာ	\N
3793	554	3448	2	tengah hari 	\N	နေ့လယ်/နေ့ခင်း	\N
3794	554	3449	1	tengah hari 	\N	နေ့လယ်/နေ့ခင်း	\N
3321	555	3214	2	makan tengah hari	\N	နေ့လယ်စာ	\N
3322	555	3207	1	makan tengah hari	\N	နေ့လယ်စာ	\N
4041	557	3630	2	filem	\N	ဖလင်	\N
4042	557	3631	1	filem	\N	ဖလင်	\N
26	558	2759	1	sampul surat	\N	စာအိတ်	\N
2433	560	2813	1	garpu	\N	ခရင်း	\N
2970	713	3043	1	bertiup (tiup)	\N	တိုက်တယ်/တိုက်ခတ်တယ်	\N
2971	713	3044	2	bertiup (tiup)	\N	တိုက်တယ်/တိုက်ခတ်တယ်	\N
3929	562	3533	1	dua buah	\N	နှစ်ခု/နှစ်လုံး\n	\N
2797	563	2956	1	daging babi	\N	ဝက်သား	\N
3951	564	3554	2	berdua/dua orang	\N	နှစ်ယောက်	\N
3952	564	3555	1	berdua/dua orang	\N	နှစ်ယောက်	\N
3938	565	3542	1	dua hari bulan	\N	နှစ်ရက်/နှစ်ရက်နေ့	\N
3852	566	3487	1	besar	\N	ဝတယ်/တုတ်တယ်	\N
3853	566	3483	2	besar	\N	ဝတယ်/တုတ်တယ်	\N
4097	567	3678	2	musim sejuk	\N	ဆောင်း/ဆောင်းတွင်း/ဆောင်းရာသီ/ဆောင်းဥတု	\N
4098	567	3679	1	musim sejuk	\N	င်းတွင်း/ဆောင်းရာသီ/ဆောင်းဥတု	\N
2724	574	2927	1	tidak pandai	\N	ညံ့တယ်	\N
2725	574	2924	2	tidak pandai	\N	ညံ့တယ်	\N
4081	576	3662	2	haiwan peliharaan	\N	အိမ်မွေးတိရစ္ဆာန်	\N
4082	576	3663	1	haiwan peliharaan	\N	အိမ်မွေးတိရစ္ဆာန်	\N
2534	580	2853	1	belajar	\N	စာဖတ်တယ်/စာလေ့လာတယ်	\N
2535	580	1356	2	belajar	\N	စာဖတ်တယ်/စာလေ့လာတယ်	\N
2536	580	1675	3	belajar	\N	စာဖတ်တယ်/စာလေ့လာတယ်	\N
4429	584	3841	2	lebih	\N	～ထက်～က ပိုတယ်	\N
4430	584	3842	1	lebih	\N	～ထက်～က ပိုတယ်	\N
2317	585	2784	1	topi	\N	ဦးထုပ်	\N
4049	588	3635	2	pokét	\N	အိတ်ကပ်	\N
4050	588	3636	1	pokét	\N	အိတ်ကပ်	\N
3988	590	3591	2	nak	\N	လိုချင်တယ်	\N
3989	590	3592	1	nak	\N	လိုချင်တယ်	\N
3847	591	3484	2	kurus	\N	ပိန်တယ်	\N
3848	591	3485	1	kurus	\N	ပိန်တယ်	\N
2823	595	2967	2	rak buku	\N	စာအုပ်စင်	\N
2824	595	2968	1	rak buku	\N	စာအုပ်စင်	\N
3748	599	3419	1	setiap minggu	\N	အပတ်တိုင်း/အပတ်စဉ် 	\N
3533	600	3309	2	setiap bulan	\N	လတိုင်း/လစဉ် 	\N
3534	600	3301	1	setiap bulan	\N	လတိုင်း/လစဉ် 	\N
3559	601	3322	2	setiap tahun	\N	နှစ်တိုင်း/နှစ်စဉ် 	\N
3560	601	3312	1	setiap tahun	\N	နှစ်တိုင်း/နှစ်စဉ်	\N
3777	603	3436	2	setiap malam	\N	ညတိုင်း/ညစဉ် \n	\N
3778	603	3437	1	setiap malam	\N	ညတိုင်း/ညစဉ် \n	\N
3317	606	3210	2	tidak sedap	\N	စားမကောင်းဘူး	\N
3318	606	3211	1	tidak sedap	\N	စားမကောင်းဘူး	\N
4520	611	3724	1	lurus/terus	\N	တန်းတန်း/ဖြောင့်ဖြောင့်/မတ်မတ်\n	\N
4521	611	3725	2	lurus/terus	\N	တန်းတန်း/ဖြောင့်ဖြောင့်/မတ်မတ်	\N
4059	612	3642	2	mancis	\N	မီးခြစ်/ယမ်းမီးခြစ်	\N
4060	612	3643	1	mancis	\N	မီးခြစ်/ယမ်းမီးခြစ်	\N
3986	614	3589	2	bulat	\N	ဝိုင်းတယ်/ဝိုင်းဝိုင်း	\N
3987	614	3590	1	bulat	\N	ဝိုင်းတယ်/ဝိုင်းဝိုင်း	\N
3353	617	3233	1	menggosok (gosok)	\N	တိုက်တယ်/သွေးတယ်	\N
2598	619	2870	2	péndék	\N	တိုတယ်	\N
2449	620	2823	1	air	\N	ရေ	\N
3939	624	3543	1	tiga hari bulan	\N	သုံးရက်/သုံးရက်နေ့ 	\N
3930	625	3534	1	tiga	\N	သုံးခု/သုံးလုံး	\N
3388	626	3241	1	hijau	\N	အစိမ်း/အစိမ်းရောင်	\N
3345	629	3225	1	telinga	\N	နား/နားရွက်\n	\N
3943	632	3547	1	enam hari bulan	\N	ခြောက်ရက်/ခြောက်ရက်နေ့	\N
4388	633	3804	2	sana/sebalik	\N	ဟိုဘက်/အခြားတစ်ဖက်	\N
4389	633	3805	1	sana/sebalik	\N	ဟိုဘက်/အခြားတစ်ဖက်	\N
3933	635	3537	1	enam buah	\N	ခြောက်ခု/ခြောက်လုံး\n	\N
4069	636	3650	2	kampung	\N	ရွာ/ကျေးရွာ\n	\N
4070	636	3651	1	kampung	\N	ရွာ/ကျေးရွာ\n	\N
3343	637	3224	1	mata/penglihatan	\N	မျက်စိ/မျက်လုံး	0
3344	637	3223	1	mata/penglihatan	\N	မျက်စိ/မျက်လုံး	\N
2330	639	2788	1	cermin mata	\N	မျက်မှန်	\N
3741	641	3412	1	hari Khamis	\N	ကြာသပတေး/ကြာသပတေးနေ့ \n	\N
4189	644	3738	2	lebih	\N	ပို/ပိုပြီး 	\N
4190	644	3739	1	lebih	\N	ပို/ပိုပြီး	\N
4012	645	3611	2	benda	\N	ပစ္စည်း	\N
4013	645	3612	1	benda	\N	ပစ္စည်း	\N
4433	648	3844	1	kedai	\N	～ဆိုင်	\N
4434	648	3845	2	kedai	\N	～ဆိုင်	\N
2792	649	2951	2	gerai sayur	\N	ဟင်းသီးဟင်းရွက်ဆိုင်/ကုန်စိမ်းဆိုင်	\N
2793	649	2952	1	gerai sayur	\N	ဟင်းသီးဟင်းရွက်ဆိုင်/ကုန်စိမ်းဆိုင်	\N
2800	650	2959	2	sayur	\N	ဟင်းသီးဟင်းရွက်	\N
2801	650	2960	1	sayur	\N	ဟင်းသီးဟင်းရွက်	\N
2569	651	2861	1	mudah	\N	လွယ်တယ်	\N
3935	655	3539	1	lapan buah	\N	ရှစ်ခု/ရှစ်လုံး	\N
3795	658	3450	2	petang	\N	ညနေ/ညနေစောင်း	\N
3796	658	3451	1	petang	\N	ညနေ/ညနေစောင်း	\N
47	660	2756	1	pejabat pos	\N	စာတိုက်	\N
3769	661	3431	2	malam tadi	\N	မနေ့ည	\N
3770	661	3432	1	malam tadi	\N	မနေ့ည	\N
4008	662	3607	2	terkenal	\N	နာမည်ကြီးတယ်\n	\N
4009	662	3608	1	terkenal	\N	နာမည်ကြီးတယ်\n	\N
2986	663	3051	1	salji	\N	နှင်း	\N
2987	663	2068	2	salji	\N	နှင်း	\N
4623	664	3737	1	perlahan-lahan	0	ဖြည်းဖြည်း	0
4624	664	3736	2	perlahan-lahan	0	ဖြည်းဖြည်း	0
3942	665	3546	1	lapan hari bulan	\N	ရှစ်ရက်/ရှစ်ရက်နေ့	\N
3283	666	3186	1	pakaian Barat	\N	အဝတ်အစား 	\N
3940	669	3544	1	empat hari bulan	\N	လေးရက်/လေးရက်နေ့	\N
4527	671	3388	1	memanggil (panggil)	\N	ခေါ်တယ်\n	\N
3144	674	3124	1	lemah	\N	ကိုယ်ခံအားနည်းတယ်/ကိုယ်ခံအားမကောင်းဘူး	\N
2275	678	2771	1	radio	\N	ရေဒီယို	\N
2276	679	2772	1	pemain radio kasét	\N	ရေဒီယိုကက်ဆက် 	\N
3412	682	3262	1	ibu bapa	\N	မိဘ	\N
3302	685	2935	1	melancong	\N	ခရီးသွားတယ်	\N
4546	686	3882	1	sifar	\N	သုံည	\N
2273	687	2769	1	peti sejuk	\N	ရေခဲသေတ္တာ	\N
2568	691	2860	1	berlatih	\N	လေ့ကျင့်တယ်	\N
2509	692	2844	1	koridor	\N	စင်္ကြံ/လျှောက်လမ်း\n	\N
4553	693	3889	1	enam	\N	ခြောက်	\N
3303	755	2097	1	bekal	\N	ထမင်းဘူး/ထမင်းချိုင့်	\N
3304	755	1728	2	bekal	\N	ထမင်းဘူး/ထမင်းချိုင့်	\N
3305	755	1556	3	bekal	\N	ထမင်းဘူး/ထမင်းချိုင့်	\N
2703	718	2919	1	berjalan-jalan (jalan-jalan)	\N	လမ်းလျှောက်တယ်	\N
3433	709	3281	1	orang	\N	～လူမျိုး 	\N
2284	719	2775	1	pejabat hartanah	\N	အိမ်ခြံမြေဝန်ဆောင်မှုရုံးခန်း/အိမ်ခြံမြေဝန်ဆောင်မှုလုပ်ငန်း/အိမ်ခြံမြေအကျိုးဆောင်	\N
2438	720	2817	1	pinggan	\N	ပန်းကန်ပြား	\N
2430	721	2811	1	arak	\N	အရက်	\N
2579	722	2865	1	salon kecantikan	\N	အလှပြင်ဆိုင်	\N
4439	726	3848	1	lain	\N	တခြား	\N
4440	726	3849	2	lain	\N	တခြား	\N
2805	729	2962	1	mahal	\N	ဈေးကြီးတယ်	\N
2806	729	1418	2	mahal	\N	ဈေးကြီးတယ်	\N
4148	730	3714	2	sangat	\N	အရမ်း/အလွန်	\N
4149	730	3715	1	sangat	\N	အရမ်း/အလွန်	\N
4191	733	3740	2	baik	\N	ကောင်းကောင်း/တော်တော်/သေချာ	\N
4192	733	3741	1	baik	\N	ကောင်းကောင်း/တော်တော်/သေချာ	\N
4551	735	3887	1	empat	\N	လေး	\N
4593	735	3914	2	empat	0	လေး	\N
4594	735	3913	3	empat	0	လေး	\N
4587	737	3915	1	tujuh	\N	ခုနစ်/ခွန်	\N
4595	737	3890	2	tujuh	0	ခုနစ်/ခွန်	\N
4597	738	3916	1	sembilan	0	ကိုး	\N
4599	738	3892	2	sembilan	0	ကိုး	\N
3976	742	3579	2	kilométer	\N	ကီလိုမီတာ	\N
3977	742	3580	1	kilométer	\N	ကီလိုမီတာ	\N
3971	744	3574	3	batang	\N	～ချောင်း/～ပင်/～လိပ်	\N
3972	744	3575	2	batang	\N	～ချောင်း/～ပင်/～လိပ်	\N
3973	744	3576	1	batang	\N	～ချောင်း/～ပင်/～လိပ်	\N
4431	745	3843	2	sebelum/lepas	\N	မ～ခင်/ရှေ့ ～ က	\N
4432	745	3822	1	sebelum/lepas	\N	မ～ခင်/ရှေ့ ～ က	\N
3813	746	3463	2	jam	\N	 ～နာရီကြာ	\N
3814	746	3464	1	jam	\N	 ～နာရီကြာ	\N
3446	748	1334	1	pukul	\N	 ～နာရီ	1
3447	748	1333	2	pukul	\N	～နာရီ	\N
3627	753	3354	2	menéléfon	\N	(ဖုန်း)ဆက်တယ်	\N
3628	753	3355	1	menéléfon	\N	(ဖုန်း)ဆက်တယ်	\N
3275	756	3181	1	ayat	\N	စာကြောင်း	\N
2257	758	1449	1	tekak	\N	လည်ချောင်း	\N
3106	760	2986	1	membuat (buat) 	\N	လုပ်တယ်	\N
3107	760	1398	2	membuat (buat) 	\N	လုပ်တယ်	\N
3038	762	3070	1	tukang gunting	\N	အလှဖန်တီးသူ/အလှပြင်ဆရာ/မိတ်ကပ်ဆရာ	\N
4476	826	3858	2	bimbang	\N	စိတ်ပူတယ်/စိုးရိမ်တယ်	\N
3039	762	3071	2	tukang gunting	\N	အလှဖန်တီးသူ/အလှပြင်ဆရာ/မိတ်ကပ်ဆရာ	\N
4055	763	3639	1	bersyampu/syampu	\N	ခေါင်းလျှော်ရည်/ခေါင်းလျှော်ခြင်း	\N
4056	763	3056	2	bersyampu/syampu	\N	ခေါင်းလျှော်ရည်/ခေါင်းလျှော်ခြင်း	\N
3000	765	3059	1	pekerja stésén	\N	ဘူတာဝန်ထမ်း	\N
3060	767	3077	1	nombor téléfon	\N	ဖုန်းနံပါတ်	\N
3063	769	3080	2	hubungi	\N	ဆက်သွယ်တယ်/အကြောင်းကြားတယ်\n	\N
3064	769	3081	1	hubungi	\N	ဆက်သွယ်တယ်/အကြောင်းကြားတယ်\n	\N
3059	771	3076	1	mendengar (dengar)	\N	နားထောင်တယ်/ကြားတယ်	\N
3067	772	3084	1	séwa rumah	\N	အိမ်လခ 	\N
3074	773	3087	1	mencari (cari)	\N	ရှာတယ်	\N
3075	773	3086	2	mencari (cari)	\N	ရှာတယ်	\N
3082	775	3091	1	menu sét	\N	တစ်ယောက်စာစားပွဲတစ်ပွဲ/ဆက်မီနျူး	\N
3083	775	3092	2	menu sét	\N	တစ်ယောက်စာစားပွဲတစ်ပွဲ/ဆက်မီနျူး	\N
3086	776	3095	2	susu	\N	နို့/နွားနို့	\N
3087	776	3096	1	susu	\N	နို့/နွားနို့	\N
3092	780	3097	1	bahagian	\N	အရောင်းကောင်တာ/ရောင်းတဲ့နေရာ	\N
3101	783	3103	1	melalui udara	\N	လေယာဉ်စာ/လေကြောင်းလိုင်း/လေကြောင်းစာပို့	\N
3100	784	3102	1	melalui laut	\N	သင်္ဘောလိုင်း/ရေကြောင်းလိုင်း/ရေကြောင်းပို့ဆောင်ရေး	\N
3103	785	3105	2	mengirim (kirim)	\N	ပို့တယ်	\N
3104	785	3104	1	mengirim (kirim)	\N	ပို့တယ်	\N
3110	786	3106	2	sut	\N	အနောက်တိုင်းဝတ်စုံ 	\N
3111	786	3107	1	sut	\N	အနောက်တိုင်းဝတ်စုံ 	\N
3118	787	3110	1	pekerja syarikat	\N	ကုမ္ပ⁠ဏီဝန်ထမ်း	\N
3126	789	3116	1	penyepit	\N	တူ/စားပွဲတင်တူ	\N
3192	792	3137	1	pegawai bank	\N	ဘဏ်ဝန်ထမ်း	\N
3193	793	3138	2	kaunter	\N	ကောင်တာ/လက်ခံကောင်တာ	\N
3194	793	3139	1	kaunter	\N	ကောင်တာ/လက်ခံကောင်တာ	\N
3195	794	3140	1	pemindahan	\N	ငွေလွှဲခြင်း	\N
3926	798	3531	1	léwat	\N	နှေးတယ်/နောက်ကျတယ်	\N
3927	798	3530	2	léwat	\N	နှေးတယ်/နောက်ကျတယ်	\N
3656	799	3367	1	siap	\N	ပေါ် ပေါက်တယ်/ပြီးမြောက်တယ်	\N
3237	800	3163	1	memakai (pakai) 	\N	လုပ်တယ်/(နက်ကတိုင်)စည်းတယ်	\N
3705	801	3389	1	beréhat (réhat)	\N	အနားယူတယ်	\N
3308	803	3201	1	membubuh (bubuh)	\N	ဆမ်းတယ်	\N
3878	804	3501	2	singkat	\N	တိုတယ်/တိုတို	\N
3879	804	3502	1	singkat	\N	တိုတယ်/တိုတို	\N
3874	805	3498	1	panjang	\N	ရှည်တယ်/ရှည်ရှည်	\N
3875	805	3497	2	panjang	\N	ရှည်တယ်/ရှည်ရှည်	\N
3227	808	3154	2	pemandu pelancong	\N	ဧည့်လမ်းညွှန်/ဂိုက်	\N
3228	808	3155	1	pemandu pelancong	\N	ဧည့်လမ်းညွှန်/ဂိုက်	\N
3229	809	3156	2	bermalam	\N	တည်းတယ်	\N
3230	809	3157	1	bermalam	\N	တည်းတယ်	\N
3231	810	3158	2	cenderamata	\N	အပြန်လက်ဆောင်/အမှတ်တရလက်ဆောင်	\N
3232	810	3159	1	cenderamata	\N	အပြန်လက်ဆောင်/အမှတ်တရလက်ဆောင် 	\N
3418	814	3268	1	suami	\N	(သူတစ်ပါးရဲ့)အမျိုးသား/(သူတစ်ပါးရဲ့)ခင်ပွန်း/(သူတစ်ပါးရဲ့)ယောက်ျား/(သူတစ်ပါးရဲ့)လင်ယောက်ျား	\N
3419	815	3269	1	adik perempuan	\N	(သူတစ်ပါးရဲ့)ညီမ/(သူတစ်ပါးရဲ့)နှမ\n	\N
3420	816	3270	1	adik lelaki	\N	(မိမိရဲ့)ညီလေး/(မိမိရဲ့)မောင်လေး	\N
3601	817	3341	1	membuka (buka)	\N	ထည့်တယ်/ဖွင့်တယ်/မီးထွန်းတယ်	\N
3602	817	3340	2	membuka (buka)	\N	ထည့်တယ်/ဖွင့်တယ်/မီးထွန်းတယ်	\N
3821	818	3358	1	menutup (tutup)	\N	ပိတ်တယ်/ဖြတ်တောက်တယ်	\N
3637	819	2232	1	datang	\N	လာတယ်	\N
3638	819	1638	2	datang	\N	လာတယ်	\N
3639	819	2220	3	datang	\N	လာတယ်	\N
4073	820	3654	2	negara asal	\N	နိုင်ငံ/အမိနိုင်ငံ	\N
4074	820	3655	1	negara asal	\N	နိုင်ငံ/အမိနိုင်ငံ	\N
4129	821	3701	2	nanti	\N	နောက်မှ/နောက်ကျရင်/တော်ကြာမှ/တော်ကြာကျရင်	\N
4130	821	3469	1	nanti	\N	နောက်မှ/နောက်ကျရင်/တော်ကြာမှ/တော်ကြာကျရင်	\N
4241	822	3751	1	apa	\N	ဘယ်ဟာ/ဘာ	\N
4242	822	1860	2	apa	\N	ဘယ်ဟာ/ဘာ	\N
4243	822	1492	3	apa	\N	ဘယ်ဟာ/ဘာ	\N
4490	824	3866	2	berhenti (henti)	\N	ရပ်တယ်/ရပ်တန့်တယ်/ထွက်တယ်/နုတ်ထွက်တယ်	\N
4491	824	3867	1	berhenti (henti)	\N	ရပ်တယ်/ရပ်တန့်တယ်/ထွက်တယ်/နုတ်ထွက်တယ်	\N
4492	825	3868	2	dapat	\N	ရတယ်/ယူတယ်	\N
4493	825	3869	1	dapat	\N	ရတယ်/ယူတယ်	\N
4477	826	3859	1	bimbang	\N	စိတ်ပူတယ်/စိုးရိမ်တယ်	\N
4488	827	3864	2	téléfon bimbit	\N	လက်ကိုင်ဖုန်း/ဟန်းဖုန်း/မိုဘိုင်းဖုန်း	\N
4489	827	3865	1	téléfon bimbit	\N	လက်ကိုင်ဖုန်း/ဟန်းဖုန်း/မိုဘိုင်းဖုန်း	\N
4498	833	3871	1	memberi (beri)	\N	ပေးတယ်	\N
4499	833	3870	2	memberi (beri)	\N	ပေးတယ်	\N
4518	835	3705	1	pelbagai	\N	အစစအရာရာ/အမျိုးမျိုး\n	\N
4526	836	3387	1	memanggil (panggil)	\N	ခေါ်တယ်	\N
4640	837	3900	1	berterusan	0	ဆက်တိုက်ဖြစ်တယ်/ဆက်လက်တယ်	0
4641	837	3899	2	berterusan	0	ဆက်တိုက်ဖြစ်တယ်/ဆက်လက်တယ်	0
4638	838	3902	1	menyémak (sémak)	0	စစ်တယ်/အတည်ပြုတယ်	0
4639	838	3901	2	menyémak (sémak)	0	စစ်တယ်/အတည်ပြုတယ်	0
4636	839	3904	1	rasa	0	ထင်တယ်	0
4637	839	3903	2	rasa	0	ထင်တယ်	0
4619	840	3906	1	berlainan/lawan	0	ဆန့်ကျင်ဘက်/ပြောင်းပြန်\n	0
4620	840	3905	2	berlainan/lawan	0	ဆန့်ကျင်ဘက်/ပြောင်းပြန်\n	0
4575	842	3908	1	bunyi	\N	(သက်မဲ့အရာကထွက်တဲ့)အသံ	\N
4576	843	3909	1	kumpulan	\N	အဖွဲ့ 	\N
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
1823	air	1	a	\N
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

