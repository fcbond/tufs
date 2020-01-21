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

--
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- Name: plpgsql_call_handler(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION plpgsql_call_handler() RETURNS language_handler
    LANGUAGE c
    AS '$libdir/plpgsql', 'plpgsql_call_handler';


ALTER FUNCTION public.plpgsql_call_handler() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = true;

--
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO ja_zt;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO ja_zt;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO ja_zt;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: ja_zt
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


ALTER TABLE public.t_instance OWNER TO ja_zt;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO ja_zt;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO ja_zt;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: ja_zt
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


ALTER TABLE public.t_usage_classified_rel OWNER TO ja_zt;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: ja_zt
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


ALTER TABLE public.t_usage_inst_rel OWNER TO ja_zt;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO ja_zt;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO ja_zt;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO ja_zt;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: ja_zt
--

CREATE TABLE t_word_inst_rel (
    word_id integer NOT NULL,
    token text NOT NULL,
    sense text,
    pos text,
    cform text,
    reading text,
    pronunciation text,
    ptoken text,
    inst_id integer NOT NULL
);


ALTER TABLE public.t_word_inst_rel OWNER TO ja_zt;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: ja_zt
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN t_usage_classified_rel ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no;


ALTER TABLE public.v_bunruilist OWNER TO ja_zt;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: ja_zt
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO ja_zt;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: ja_zt
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_index_char (id, index_char) FROM stdin;
1	あ
2	い
3	う
4	え
5	お
6	か
7	き
8	く
9	け
10	こ
11	さ
12	し
13	す
14	せ
15	そ
16	た
17	ち
18	つ
19	て
20	と
21	な
22	に
23	ぬ
24	ね
25	の
26	は
27	ひ
28	ふ
29	へ
30	ほ
31	ま
32	み
33	む
34	め
35	も
36	や
37	ゆ
38	よ
39	ら
40	り
41	る
42	れ
43	ろ
44	わ
45	を
46	ん
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
1	朝です。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
2	朝ではありません。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
3	学生です。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
4	学生ではありません。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
5	春です。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
6	春ではありません。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
7	田中です。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
8	キムです。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
9	朝ではないです。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
10	学生ではないです。		null		\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
11	田中さんは学生です。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
12	田中さんは学生ではありません。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
13	私が田中です。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
14	父は先生です。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
15	父は先生ではありません。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
16	学校は休みです。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
17	学校は休みではありません。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
18	山田さんがリーダーです。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
19	あっ、田中さんが１位です。		null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
20	中山さんは大学生ですか。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
21	はい、大学生です。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
22	田中さんですか。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
23	はい、田中です。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
24	学生ではありませんか。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
25	はい、学生ではありません。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
26	田中さんですか。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
27	いいえ、山口です。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
28	学生ではありませんか。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
29	いいえ、学生です。		null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
30	東京は晴れでした。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
31	むかし、ここは公園でした。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
32	父は先生でした。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
33	お昼はおにぎりではありませんでした。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
34	きのうは休みでしたか。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
35	いいえ、休みではありませんでした。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
36	きのうは休みではなかったです。		null		\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
37	木があります。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
38	本があります。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
39	犬がいます。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
40	田中さんがいます。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
41	ペンがありますか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
42	はい、あります。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
43	いいえ、ありません。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
44	山田さん、いますか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
45	はい、います。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
46	いいえ、いません。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
47	何がありますか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
48	ノートがあります。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
49	誰がいましたか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
50	田中さんがいました。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
51	誰がいましたか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
52	誰もいませんでした。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
53	ペンがありますか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
54	はい、どうぞ。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
55	先生、来週漢字の試験がありますか。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
56	はい、あります。水曜日ですよ。		null		\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
57	部屋にパソコンがあります。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
58	公園に木があります。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
59	家に犬がいます。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
60	教室に田中さんがいます。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
61	パソコンは部屋にあります。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
62	田中さんは教室にいます。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
63	パソコンはどこにありますか。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
64	部屋にあります。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
65	田中さんはどこにいますか。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
66	教室にいます。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
67	みなさん、質問がありますか。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
68	ありません。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
69	お金がありません。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
70	太郎さんには子どもがいます。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
71	公園でロックコンサートがありました。		null		\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
72	机の上		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
73	机の下		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
74	家の前		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
75	家のうしろ		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
76	教室の中		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
77	教室の外		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
78	田中さんの右		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
79	田中さんの左		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
80	机の上に本があります。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
81	机の下にかばんがあります。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
82	かばんの中にノートがあります。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
83	田中さんの右に山田さんがいます。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
84	田中さんの左に木村さんがいます。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
85	家の前に猫がいます。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
86	家のうしろに車があります。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
87	ポストは家の向かいにあります。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
88	埼玉は東京の北にあります。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
89	田中さんは教室の中にいます。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
90	山田さんは教室の外にいます。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
91	家の前は公園です。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
92	山田さんのとなりは田中さんです。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
93	学校は家の近くです。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
94	本はかばんの中です。		null		\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
95	わたしのペンはこれです。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
96	体育館のとなりにプールがあります。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
97	はさみは机の上にあります。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
98	田中さんのとなりに木村さんがいます。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
99	あれは数学の教科書です。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
100	日本語の教室はどこですか。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
101	２階です。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
102	これは誰のかばんですか。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
103	わたしのです。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
104	それはいつの新聞ですか。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
105	きのうのです。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
106	わたしのはどこにありますか。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
107	わたしは東京外国語大学の木村です。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
108	日本には、春と夏と秋と冬の４つの季節があります。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
109	この人は友だちの田中さんです。		null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
110	教室に新しいコンピューターがあります。		null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
111	箱の中に小さい犬がいます。		null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
112	田中さんは元気な人です。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
113	すてきな絵ですね。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
114	ようかんはどんな食べ物ですか。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
115	あまいおかしです。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
116	どんな映画ですか。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
117	日本の古い映画です。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
118	どんなかばんですか。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
119	じょうぶなかばんです。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
120	どんなCDがありますか。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
121	静かな音楽のCDがあります。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
122	どの靴を買いますか。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
123	黒いのを買います。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
124	どんな音楽がすきですか。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
125	静かなのがすきです。		null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
126	これは日本語の教科書です。		null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
127	日本語の辞書はそれです。		null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
128	あれは体育館です。		null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
129	ここは１年生の教室です。		null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
130	そこは図書室です。		null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
131	あそこは事務室です。		null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
132	田中さんのかばんはそこにあります。		null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
133	あそこに先生がいます。		null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
134	この部屋は２年生の教室です。		null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
135	その本はわたしのです。		null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
136	先生はあの人です。		null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
137	あのきれいな女の人は山本さんです。		null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
138	その大きいかばんはわたしのです。		null		\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
139	田中さんの消しゴムはどれですか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
140	それです。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
141	すみません、トイレはどこですか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
142	あそこです。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
143	ありがとうございました。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
144	先生の車はどこにありますか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
145	あそこです。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
146	わたしのぼうしはどこにありますか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
147	そこにあります。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
148	どこですか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
149	あなたのうしろです。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	0
150	あのかばんは誰のですか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
151	どのかばんですか。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
152	あの黒いかばんです。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
153	あれは田中さんのです。		null		\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
154	あそこにかさが５本あります。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
155	ケーキが７つあります。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
156	このボールペンはいくらですか。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
157	100円です。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
158	先生の机の上に辞書が２冊と雑誌が１冊あります。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
159	ボールがいくつありますか。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
160	15あります。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
161	そこにハンカチが何枚ありますか。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
162	３枚あります。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
163	そこにハンカチがどのくらいありますか。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
164	30枚くらいあります。		null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
165	今、５時です。		null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
166	今、何時ですか。		null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
167	４時です。		null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
168	今、何時何分ですか。		null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
169	10時51分です。		null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
170	きょうは何月何日ですか。		null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
171	5月21日です。		null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
172	あしたは何曜日ですか。		null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
173	日曜日です。		null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
174	わたしは毎日勉強します。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
175	わたしは毎日勉強しません。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
176	テレビはピアノのそばにあります。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
177	田中さんは教室にいます。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
178	田中さんはこれから図書館で勉強します。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
179	わたしはあした研究室にいます。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
180	あしたパーティーがあります。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
181	わたしはあした研究室にいません。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
182	あした、小説家の山口さんが来ます。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
183	毎日、学校へ行きます。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
184	田中さんは図書館で勉強しますが、わたしは家で勉強します。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
185	熱がありますから、休みます。		null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
186	テレビはピアノのそばにありますか。		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
187	テレビがピアノのそばにあるかどうか		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
188	田中さんは教室にいますか。		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
189	田中さんが教室にいるかどうか		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
190	これから図書館で勉強しますか。		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
191	聞き手がこれから図書館で勉強するかどうか		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
192	’A：田中さんは教室にいますか。		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
193	はい、います。		null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
194	きのうわたしは勉強しました。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
195	むかし、学校の門のそばに大きい木がありました。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
196	きのう地震がありましたか。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
197	はい、ありました。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
198	きのうは雨が降りませんでした。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
199	試験は終わりましたか。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
200	はい、終わりました。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
201	試験は終わりましたか。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
202	B1：はい、もう終わりました。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
203	B2：いいえ、まだです。		null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
204	学校へ行きます。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
205	うちへ帰ります。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
206	公園へ行きますか。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
207	いいえ、行きません。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
208	’学校に行きます。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
209	’うちに帰ります。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
210	’A：公園に行きますか。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
211	いいえ、行きません。		null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
212	わたしはハンバーガーを食べます。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
213	田中さんはコーラを飲みます。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
214	CDを買います。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
215	何を食べますか。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
216	サンドイッチを食べます。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
217	あした映画を見ますか。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
218	いいえ、見ません。		null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
219	田中さんに手紙を出します。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
220	山田さんにお金を貸します。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
221	木村さんに英語を教えます。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
222	山田さんにお金を借ります。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
223	木村さんにフランス語を習います。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
224	壁にシールをはります。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
225	机に本を置きます。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
226	山田さんに本を見せます。		null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
227	いつテニスをしますか。		null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
228	あしたテニスをします。		null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
229	土曜日、何をしましたか。		null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
230	映画を見ました。		null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
231	わたしは夏休みに旅行しました。		null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
232	山田さんの誕生日にパーティーをします。		null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
233	このりんごはあまいです。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
234	あのりんごはあまくありません。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
235	わたしの家の犬は大きいです。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
236	となりの家の犬は大きくありません。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
237	きょうは寒くないです。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
238	あまいです。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
239	大きいです。		null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
240	勉強はおもしろいですか。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
241	はい、おもしろいです。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
242	外は寒いですか。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
243	はい、寒いです。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
244	外は寒いですか。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
245	いいえ、寒くありません。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
246	勉強はおもしろいですか。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
247	はい、おもしろいです。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
248	日本の料理はどうですか。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
249	おいしいです。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
250	どんなかばんですか。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
251	赤いです。		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
252	このかばんは高かったです。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
253	このかばんは高かったです。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
254	パーティーの料理はおいしくありませんでした。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
255	きのうは寒くなかったです。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
256	北海道はどうでしたか。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
257	寒かったです。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
258	きのうの映画はどうでしたか。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
259	おもしろくありませんでした。		null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
260	太郎君の犬はとても大きいです。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
261	わたしの部屋はあまり広くありません。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
262	とてもつかれました。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
263	あまりつかれませんでした。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
264	とても勉強します。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
265	あまり勉強しません。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
266	このあたりには、あまり高い建物がありません。		null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
267	きょうは暑い日です。		null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
268	駅前にいい店があります。		null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
269	ここはとても静かな部屋です。 		null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
270	すてきな服ですね。		null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
271	きょうはハッピーな日です。		null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
272	このかさはじょうぶです。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
273	そのかさはじょうぶですか。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
274	いいえ、じょうぶではありません。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
275	田中さんは元気でしたか。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
276	はい、元気でした。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
277	いいえ、元気ではありませんでした。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
278	このかさはじょうぶではないです。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
279	田中さんは元気ではなかったです。		null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
280	田中さんは髪が長いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
281	田中さんは背が高いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
282	中山さんは力が強いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
283	うちの猫は目がきれいです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
284	わたしはきのうからのどが痛いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
285	この町は道が狭いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
286	この絵は色がきれいです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
287	田中さんはバスケットボールがじょうずです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
288	わたしは歌がへたです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
289	わたしはピアノが得意です。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
290	’ ×わたしはピアノがじょうずです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
291	頭が痛いですか。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
292	いいえ、痛くないです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
293	田中さん、だいじょうぶですか。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
294	ちょっと気分が悪いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
295	田中さんは髪が長いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
296	’田中さんの髪は長いです。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
297	山田さんは、お父さんがよく働きます。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
298	山田さんは、お父さんが医者です。		null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
299	映画を見た。		null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
300	この雑誌は新しい。		null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
301	あの電子辞書は便利だ。		null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
302	きょうは雨だ。		null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
303	今、小林さんは図書館で本を読んでいます。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
304	田中さんは今何をしていますか。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
305	ごはんを食べています。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
306	いつから日本語を勉強していますか。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
307	去年から勉強しています。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
308	日本語の辞書はありますか。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
309	すみません、今使っています。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
310	木村さんをお願いします。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
311	木村さんは今食事をしています。		null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
312	体育館の前に小林さんが立っています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
313	窓が開いています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
314	わたしは毎朝ジョギングをしています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
315	わたしは３年前アメリカで勉強しています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
316	山田さんは10年前に大学を卒業しています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
317	山田先生を知っていますか。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
318	いいえ、知りません。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
319	この道は曲がっています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
320	ビルがそびえています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
321	山田さんはお父さんに似ています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
322	もしもし、まりさんはいますか。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
323	いいえ。まりは今買い物に行っています。		null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
324	窓が閉めてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
325	電気が消してありました。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
326	駅のホームに新しい映画のポスターがはってありました。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
327	問題は15ページに書いてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
328	机の上に辞書が置いてありますか。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
329	はい、置いてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
330	あ、ケーキが切ってありますよ。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
331	じゃあ、食べましょう。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
332	窓が開けてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
333	’ ×窓が開いてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1412	外は寒いですか。		null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
334	窓が開けてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
335	"窓を開けました。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
336	窓が開けてあります。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
337	'''窓が開いています。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
338	小林さんに来週の予定を話してありますか。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
339	いいえ、まだです。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
340	漢字を調べてありますか。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
341	はい、調べました。		null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
342	田中さんと山田さんは大学２年生です。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
343	わたしはパンとサラダを食べます。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
344	机の上に本とノートがあります。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
345	月曜日と水曜日と金曜日にサッカーの練習があります。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
346	［田中さんと山田さん］は大学2年生です。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
347	わたしは［パンとサラダ］を食べます。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
348	机の上に［本とノート］があります。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
349	［月曜日と水曜日と金曜日］にサッカーの練習があります。		null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
350	わたしは日曜日に［漫画や雑誌］を読みます。		null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
351	［デパートやスーパー］で買い物をします。		null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
352	［郵便局の前や駅のそば］にポストがあります。		null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
353	［パンや卵］などを食べます。		null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
354	わたしの部屋に［机やベッドやテレビ］などがあります。		null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
355	大きくて黒いかばんはわたしのです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
356	きれいで静かなアパートに住んでいます。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
357	３年生で留学生の金さん		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
358	→(4)この花は小さくて赤いです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
359	→(5)木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
360	→(6)田中さんは３年生で、中村さんは４年生です。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
361	親切でおもしろい人		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
362	若くてお金持ちの人		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
363	この靴下は、じょうぶで安いです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
364	’×この靴下は、じょうぶで高いです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
365	" この靴下はじょうぶですが、高いです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
366	→(10)田中さんは背が高くてめがねをかけています。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
367	この本は漢字が多くて難しいです。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
368	熱が高くて、学校へ行くことができませんでした。		null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
369	わたしは夏休みにテニスをしたり泳いだりしました。		null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
370	日曜日に弟は本を読んだりテレビを見たりしています。		null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
371	友だちとよく映画を見たりプールに行ったりします。		null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
372	友だちとよく映画を見たりプールに行ったりします。		null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
373	飛行機で東京と大阪を行ったり来たりします。		null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
374	雨が降ったりやんだりしています。		null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
375	→(1) あしたわたしは駅で友だちに会って、いっしょにコンサートに行きます。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
376	あしたわたしは駅で友だちに会って、いっしょにコンサートに行きます。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
377	あしたの予定を教えてください。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
378	朝７時に起きて、食堂で朝ごはんを食べて、８時から練習します。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
379	わたしは日本へ行って、すもうを見たいです。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
380	２つに折って、はさみで切ってください。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
381	あそこに座って、お弁当を食べましょう。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
382	わたしは毎日歩いて学校へ行きます。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
383	テープを聞いて、日本語を勉強します。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
384	夏休みに中山さんは海でダイビングをして、山本さんは山に登りました。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
385	田中さんは東京に住んでいて、山本さんは大阪に住んでいます。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
386	雨が降って、野球の試合を中止しました。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
387	大きい台風が来て、電車が止まりました。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
388	田中さんが来て、木村さんが帰りました。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
389	’田中さんが来てから、木村さんが帰りました。		null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
390	(1)庭の花		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
391	(2)山田さんと田中さん		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
392	(3)机の上に本があります。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
393	(4)本を読みます。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
394	(5)10時から授業を始めます。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
395	(6)朝起きて顔を洗います。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
396	(7)春になると暖かくなります。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
397	(8)雨が降ったら運動会は休みです。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
398	(9)この本は読みました。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
399	(10)この本も読みました。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
400	(11)この本だけ読みました。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
401	(12)この本ばかり読みました。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
402	(13)この本まで読みました。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
403	(14)この本など読みました。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
404	(15)あしたは日曜日ですか。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
405	(16)あしたは日曜日ですよ。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
406	(17)あしたは日曜日ですね。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
407	あなた に だけ は 話しましょう。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
408	きょうのテストは３時からです よ ね。		null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
409	山田さんが本を読みました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
410	空が青いです。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
411	田中さんが最初です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
412	わたしは本を読みました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
413	わたし、大学へ行きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
414	大学を卒業します。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
415	学校を休みます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
416	楽しい１日を過ごしました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
417	あらしの中を走りました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
418	拍手の中を歩きました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
419	パンだけ食べました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
420	パン、食べました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
421	壁に写真をはります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
422	ゴミ箱にごみを捨てます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
423	犬が山田さんにほえました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
424	先生に相談します。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
425	東京に行きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
426	家に帰ります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
427	飛行機に乗ります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
428	駅の前に集まります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
429	氷が水になりました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
430	山田さんは子どもを政治家にしました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
431	山田さんに本を読ませます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
432	先生にほめられました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
433	田中さんに本を見せます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
434	お母さんに見つかりました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
435	木村さんに英語を教わりました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
436	山田さんはお父さんに似ています。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
437	このズボンはわたしには大きすぎます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
438	テレビは目によくないです。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
439	１回に３袋ずつ使います。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
440	ホテルに泊まります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
441	大学の近くに家を建てます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
442	庭に花が咲きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
443	今年の３月15日に日本に来ました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
444	買い物に行きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
445	シャツを買いに行きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
446	えんぴつは字を書くのに使います。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
447	山田さんに佐藤さんに田中さんが来ました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
448	人の多さにびっくりしました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[23]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
449	カラオケで歌いに歌って、声が出なくなりました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[24]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
450	飛行機が南へ飛んでいきます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[25]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
451	学校へ行きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[25]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1540	親切でおもしろい人		null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
452	ぶどうからワインを作ります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[29]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
453	田中さんから本を贈りました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[30]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
454	先生から質問を出しました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[30]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
455	わたしから説明します。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[30]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
456	鈴木さんから説明させました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[31]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
457	先生からほめられました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[31]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
458	佐藤さんは鈴木さんより年上です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[32]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
459	白線より中に入らないでください。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[33]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
460	これより会議を始めます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[33]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
461	世界で一番長い川はナイル川です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[36]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
462	日本では、３月と４月と５月は春です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[36]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
463	片道で100円、往復で200円です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[36]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
464	これで十分です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[36]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
465	ペンで字を書きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[37]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
466	バスで学校に行きます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[37]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
467	佐藤さんは大きい声で話します。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[37]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
468	木で机を作ります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[38]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
469	病気で学校を休みました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[39]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
470	台風で電車が遅れました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[39]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
471	子どもがはだしで歩いています。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[40]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
472	子どもがはだかで走っています。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[40]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
473	いつもひとりで勉強しています。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[41]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
474	家族全員でドライブしました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[41]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
475	日本語が１年間で上手になりました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[42]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
476	このコンピューターを20万円で買いました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[42]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
477	あと10分で５時です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[42]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
478	２と３で５です。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[42]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
479	警察で事件を調べています。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[43]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
480	クラスで旅行に出かけました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[43]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
481	その仕事は自分でやります。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[43]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
482	田中さんと山田さんが来ました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[46]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
483	田中さんはお父さんと似ています。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[48]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
484	あのかばんはわたしのかばんと同じです。　		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[48]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
485	このノートはわたしのノートと違います。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[48]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
486	朝起きたときには「おはようございます」と言います。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[49]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
487	この漢字は「やま」と読みます。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[49]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
488	佐藤さんや田中さんが来ました。		null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[50]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
489	これをください。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
490	はい。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
491	書類のコピーをください。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
492	すみません、水をくださいませんか。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
493	はい。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
494	あのう、この町の地図をくださいませんか。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
495	はい、どうぞ。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
496	ハンバーガーとサラダをお願いします。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
497	はい。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
498	りんご、ください。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
499	ハンバーグ、ください。		null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
500	赤いばらを８本ください。		null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
501	はい。1200円です。		null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
502	コーラを２つお願いします。		null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
503	かしこまりました。		null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
504	教科書の15ページを見てください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
505	テープの会話を聞いてください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
506	３年生は手をあげてください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
507	２年生は、あした８時に学校へ来てください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
508	名前を書いてください。 		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
509	はい、わかりました。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
510	どうかゆるしてください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
511	わたしを助けてください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
512	ちょっと待ってください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
513	あした電話をしてください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
514	がんばってください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
515	安心してください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
516	ぜひ来てください。		null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
517	もう一度説明してくださいませんか。		null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
518	すみません、窓を開けてくださいませんか。		null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
519	ええ、いいですよ。		null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
520	すみません、窓を開けてくださいませんか。		null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
521	ええ、いいですよ。		null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
522	この部屋でお弁当を食べてもいいです。		null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
523	このコピー機は学生が使ってもいいですよ。		null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
524	辞書を見てもいいですか。　		null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
525	いいえ、いけません。		null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
526	病院で携帯電話を使ってはいけません。		null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
527	この部屋でたばこをすってはいけません。		null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
528	しばらくお酒を飲んではだめです。	我暫時不能喝酒。	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
529	この教室は使っちゃいけませんよ。		null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
530	泣いちゃだめですよ。		null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
531	木村さん、その本を借りてはいけませんか。		null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
651	これとそれがほしいです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
532	’木村さん、その本を借りてもいいですか。		null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
533	ここではたばこをすわないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
534	きょうはおふろに入らないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
535	コンピューターを使っています。スイッチを切らないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
536	どうかおこらないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
537	わたしを殺さないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
538	不合格にしないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
539	だいじょうぶです。心配しないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
540	あまり無理をしないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
541	気にしないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
542	どうぞ遠慮しないでください。		null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
543	ペンでもいいですか。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
544	B1：はい、いいです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
545	B2：いいえ、だめです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
546	レポートはあしたでもいいですか。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
547	B1：はい、あしたでもいいです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
548	B2：いいえ、あしたではだめです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
549	レポートはあしたでもいいですか。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
550	B1：はい、あしたでもいいです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
551	B2：いいえ、あしたではだめです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
552	レポートはあしたでもいいですか。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
553	B1：はい、あしたでもいいです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
554	B2：いいえ、あしたではだめです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
555	パーティーは、ジーンズではいけません。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
556	この試験は、えんぴつではだめです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
557	’A：ペンで書いてもいいですか。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
558	’A：レポートはあした出してもいいですか。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
559	’パーティーは、ジーンズで来てはいけません。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
560	’この試験は、えんぴつで解答してはだめです。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
561	"パーティーは、ジーンズじゃいけません。		null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
562	いっしょに帰りませんか。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
563	はい。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
564	スケートに行きませんか。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
565	いいですね。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
566	土曜日の午後、テニスをしませんか。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
567	すみません。土曜日は仕事があります。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
568	いっしょに帰りませんか。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
569	はい。		null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
570	いっしょに帰りましょう。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
571	はい。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
572	信号が青になりました。さあ、渡りましょう。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
573	いっしょに昼ごはんを食べませんか。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
574	はい、食べましょう。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
575	プールへ行きませんか。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
576	いいですね。行きましょう。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
577	食事の前には手を洗いましょう。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
578	手をあげて横断歩道を渡りましょう。		null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
579	いっしょに帰りませんか。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
580	ええ、帰りましょう。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
581	スケートに行きませんか。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
582	いいですね。行きましょう。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
583	土曜日の午後、テニスをしませんか。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
584	土曜日ですか。土曜日はちょっと。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
585	あした、うちへ遊びに来ませんか。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
586	ありがとうございます。でも、あしたはちょっと。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
587	映画を見に行きませんか。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
588	すみません。アルバイトがあります。		null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
589	きょうから日記を書こう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
590	きょうは食堂で昼食を食べよう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
591	あしたもう一度来よう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
592	家に帰ったら掃除しよう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
593	その荷物はわたしが持ちましょう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
594	図書館でいっしょに勉強しましょう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
595	きょうから日記を書こう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
596	きょうは食堂で昼食を食べよう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
597	あしたもう一度来よう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
598	家に帰ったら掃除しよう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
599	この辺で休みましょう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
600	その仕事はわたしがしましょう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
601	わたしは６時に帰ります。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
602	’×わたしは６時に帰りましょう。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
603	図書館で勉強しようとしましたが、休みでした。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
604	西の空に日が沈もうとしています。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
605	花が散ろうとしています。		null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
606	あしたは早く起きようと思います。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
607	夏休みに旅行しようと思っています。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
608	木村さんは留学しようと思っています。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
609	夏休みに旅行しようと思っています。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
610	木村さんは留学しようと思っています。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
611	’×木村さんは留学しようと思います。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
612	木村さんは留学しようと思いますか。		null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
613	わたしは今度の休みに友だちと旅行したいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
614	今晩どこへも行きたくありません。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
615	将来、何になりたいですか。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
616	日本語の先生になりたいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
617	どんな音楽を聞きたいですか。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
618	日本の音楽を聞きたいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
619	今晩どこへも行きたくありません。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
620	将来、何になりたいですか。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
621	日本語の先生になりたいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
622	どんな音楽を聞きたいですか。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
623	日本の音楽を聞きたいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
624	水が飲みたいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
625	何が食べたいですか。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
626	そうですね、サンドイッチが食べたいです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
627	すみません、山田先生と話したいんですが。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
628	はい、ちょっと待ってください。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
629	先生、お手洗いに行きたいんですが。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
630	はい、いいですよ。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
631	’×田中さんは今晩どこへも行きたくないです。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
632	山田さんは旅行したがっています。		null		\N	gmod	explanation067.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
633	東京の大学に行きたかったです。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
634	みんなの前で発表したくありませんでした。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
635	駅まで歩きたくなかったです。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
636	東京の大学に行きたかったです。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
637	みんなの前で発表したくありませんでした。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
638	駅まで歩きたくなかったです。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
639	きのうコンサートに行ってきました。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
640	そうですか。それはわたしも行きたかったです。		null		\N	gmod	explanation068.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
641	わたしは今コンピューターがほしいです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
642	わたしはコンピューターはほしくありません。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
643	わたしはコンピューターはほしくないです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
644	車がほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
645	いいえ、｛ほしくありません／ほしくないです｝。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
646	太郎さんは犬がほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
647	はい、ほしいです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
648	誕生日に何がほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
649	そうですね、新しい自転車がほしいです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
650	どれがほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
652	車がほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
653	いいえ、｛ほしくありません／ほしくないです｝。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
654	誕生日に何がほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
655	そうですね、新しい自転車がほしいです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
656	どれがほしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
657	これとそれがほしいです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
658	太郎さんはコンピューターがほしいようです。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
659	すみません、白い紙がほしいんですが。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
660	はい。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
661	あのう、赤いボールペンがほしいんですが。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
662	はい。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
663	太郎さんは新しいコンピューターをほしがっています。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
664	先生、コンピューターはお入り用ですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
665	先生、どれがよろしいですか。		null		\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
666	わたしは音楽がすきです。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
667	わたしはスポーツがすきではありません。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
668	田中さんはテニスがすきですか。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
669	はい、すきです。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
670	水泳はすきですか。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
671	いいえ、すきではありません。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
672	何がすきですか。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
673	りんごがすきです。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
674	どの科目がすきですか。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	0
675	数学がすきです。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	0
676	わたしは犬がきらいです。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
677	わたしは犬がきらいではありません。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
678	すきな食べ物は何ですか。		null		\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
679	わたしはつらいです。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
680	わたしは仕事がつらいです。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
681	あなたは地震がこわいですか。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
682	K先生がこわいです。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
683	’×田中くんは犬がこわいです。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
684	田中くんは犬がこわいそうです。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
685	田中くんは犬がこわいらしいです。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
686	田中くんは犬がこわかった。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
687	田中くんはいつも犬をこわがります。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
688	田中くんは犬をこわがっています。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
689	うれしい。		null		\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
690	２年生は５時から体育館を使うことができます。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
691	きょうは、バスケットボールの練習をすることができません。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
692	２年生は５時から体育館を使うことができます。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
693	きょうは、バスケットボールの練習をすることができません。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
694	中山さんは200メートル泳ぐことができます。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
695	わたしは漢字を50書くことができます。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
696	中山さんはアラビア語を話すことができますか。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
697	いいえ、できません。		null		\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
698	キムさんは日本語ができます。 		null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
699	田中さんはテニスができます。		null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
700	わたしは車の運転ができません。		null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
701	わたしは漢字が書けます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
702	わたしはさしみが食べられます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
703	あした学校に来られます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
704	水泳ができます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
705	パーティーに来られますか。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
706	B1：はい、行けます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
707	B2：いいえ、行けません。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
708	図書館で勉強できます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
709	彼を一生愛せますか。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
710	’わたしはさしみが食べれます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
711	’あした学校にこれます。		null		\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
712	あしたは晴れるでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
713	きょうの試合では、Aチームが勝つでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
714	この問題は、あしたの試験に出るでしょうか。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
715	たぶん出るでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
716	きのう、外語大のチームは勝ちましたか。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
717	わかりません。でも、たぶん勝ったでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
718	あそこに人がいますね。あの人はだれでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
719	たぶん田中さんでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
720	田中さんは来ますか。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
721	たぶん来ないでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
722	客：これはいくらでしょうか。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
723	店員：それは1000円です。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
724	あしたは雨が降るだろう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
725	田中さんは来ないだろう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
726	Aチームが勝っただろう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
727	あしたは日曜日でしょう？		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
728	これは田中さんのでしょう？		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
729	わたしがさっき言ったでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
730	ほら、あそこにコンビニがあるでしょう。		null		\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
731	山田さんは図書館にいるかもしれません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
732	今ごろの東京は寒いかもしれません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
733	山田さんは猫がきらいかもしれません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
734	あの人はもしかすると木村さんのお兄さんかもしれません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
735	’山田さんは図書館にいるかも。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
736	今ごろは、山田さんはひまにちがいありません。 		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
737	あれは、田村さんにちがいありません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
738	この時計はきっと高いにちがいありません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
739	妹が帰ってきません。もしかしたら事故にあったのかもしれません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
740	今10時ですから、郵便局は開いているはずです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
741	木村さんは英語教師ですから、英語が話せるはずです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
742	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
743	木村さんは英語教師です。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
744	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
745	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
746	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
747	この家はだれか住んでいそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
748	このおかしは甘そうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
749	この電子辞書は便利そうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
750	雨が降りそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
751	わたしはきょう早く学校に行けそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
752	’×わたしはきょう早く学校に行きそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
753	ここにおいしそうなおかしがあります。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
754	木村さんはうれしそうに走ってきました。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
755	庭に車がありません。母は出かけているようです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
756	この絵はまるで写真のようです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
757	小林さんは鳥のような声で歌います。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
758	このロボットは、生きているように動きます。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
759	あの人は歌手のようです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[23]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
760	あの人はどうやら歌手のようです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[24]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
761	あの人はまるで歌手のようです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[24]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
762	来月から新しい生徒が来るそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[26]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
763	天気予報によると、あしたは雨が降るそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[26]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
764	木村さんが電話に出ない。出かけているらしい。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[28]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
765	山田さんは来月東京に行くらしいです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[28]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
766	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[29]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
767	先生から聞きましたが、来月から新しい生徒が来るそうです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[30]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
768	うわさによると、山田さんは来月東京に行くらしいです。		null		\N	gmod	explanation076.xml	/gmod:explanation[1]/gmod:ExplaBlock[30]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
769	歌舞伎はおもしろいと思います。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
770	わたしはあした雨がふると思います。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
771	歌舞伎はおもしろいと思います。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
772	田中さんはもう帰ったと思います。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
773	あしたも寒いと思いますか。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
774	ええ、たぶん。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
775	彼はスポーツが得意だと思います。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
776	彼はスポーツが得意ではないと思います。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
777	彼はスポーツが得意だと思いません。		null		\N	gmod	explanation077.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
778	わたしのペン		null		\N	gmod	explanation078.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
779	体育館のとなり		null		\N	gmod	explanation078.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
780	新しいコンピューター		null		\N	gmod	explanation078.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
781	小さい犬		null		\N	gmod	explanation078.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
782	元気な人		null		\N	gmod	explanation078.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
783	すてきな絵		null		\N	gmod	explanation078.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
784	［きのう書いた作文］をきょう提出しました。		null		\N	gmod	explanation079.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
785	［図書館で勉強している田中さん］を見ました。		null		\N	gmod	explanation079.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
786	あれはわたしが通った学校です。		null		\N	gmod	explanation079.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
787	きのうわたしが行った店		null		\N	gmod	explanation079.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
788	’きのうわたしの行った店		null		\N	gmod	explanation079.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
789	コーヒーは飲んで、紅茶は飲まない人		null		\N	gmod	explanation079.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
790	［外国語を勉強する{こと／の}］は楽しいです。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
791	［学生が優秀な{こと／の}］が田中先生の自慢です。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
792	［山田さんが合格した{こと／の}］をきょう知りました。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
793	外国語を勉強する{こと／の}は楽しいです。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
794	学生が優秀な{こと／の}が田中先生の自慢です。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
795	田中さんが走っているのを見ました。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
796	山田さんが本を読んでいるのが聞こえます。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
797	木村さんが来るのを待ちます。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
798	大学に進学することを勧めます。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
799	わたしはアメリカに留学することを考えています。		null		\N	gmod	explanation080.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
800	雨が降ったので試合が中止になりました。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
801	もう遅いので、これで帰ります。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
802	このカメラが便利なので、これにしませんか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
803	あしたが提出日ですので、気をつけてください。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
804	きのうは祭日でしたから、学校は休みでした。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
805	くすりを飲みましたから、もうだいじょうぶです。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
806	あしたは授業がないから、学校へ行きません。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
807	もうだいじょうぶですから、心配しないでください。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
808	どうしてわたしの電話番号がわかったのですか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
809	小林さんに聞きました。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
810	田中さんもあした来ますか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
811	いいえ、来ません。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
812	どうしてですか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
813	病気だからです。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
814	’A：どうしてわたしの電話番号がわかったのですか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
815	小林さんに聞いたからです。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
816	どうして「蛍の光」が流れているのですか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
817	図書館が閉まるからです。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
818	雨が降って試合が中止になりました。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
819	かぜで休みました。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
820	どうして授業を休んだのですか。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
821	熱があって、起きられませんでした。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
822	きょうは先生が病気で、授業が休みになりました。		null		\N	gmod	explanation081.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
823	一生懸命勉強したのに試験に落ちました。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
824	このメロンは大きいのに安いです。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
825	毎日日本語を勉強しているけれども、なかなか漢字が覚えられません。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
826	山田さんはいつも元気ですけれども、きょうは静かです。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
827	一生懸命勉強したのに試験に落ちました。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
828	このメロンは大きいのに安いです。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
829	きょうは日曜日なのに仕事があります。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
830	さっき食べたのにもうおなかがすきました。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
831	毎日日本語を勉強しているけれども、なかなか漢字が覚えられません。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
832	山田さんはいつも元気ですけれども、きょうは静かです。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
833	雨が降ったけれども予定通り運動会をしました。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
834	もう夜の12時だけれども、もう少し勉強しよう。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
835	’×もう夜の12時なのに、もう少し勉強しよう。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
836	小林さんはかぜをひいているけれども、学校に来ているかもしれません。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
837	’×小林さんはかぜをひいているのに、学校に来ているかもしれません。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
838	日曜日だけれども、学校に行きますか。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
839	’×日曜日なのに、学校に行きますか。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
840	わたしは東京に住んでいるけれども、弟は京都に住んでいます。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
841	’毎日日本語を勉強している｛けれども／けれど／けど／が｝、なかなか漢字が覚えられません。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
842	’山田さんはいつも元気です｛けれども／けれど／けど／が｝、きょうは静かです。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
880	毎日、新聞を読めば、覚えることができますよ。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
843	わたしが話しているのに、じゃまをしないでください。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
844	鈴木さんから電話ですよ。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
845	えっ、もう夜の11時なのに。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
846	レポートのことですけれども、来週の月曜日に提出してください。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
847	日本中を旅行しましたけれども、京都が一番すきです。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
848	すみませんが、郵便局はこの辺ですか。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
849	すみません、パソコンが動かないのですけれども。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
850	’すみません、パソコンが動かないのですけれども、見てもらえますか。		null		\N	gmod	explanation082.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
851	雨が降ると、雪が解けます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
852	父は毎朝起きると、新聞を読みます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
853	このボタンを押すと、ドアが開きます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
854	成績が悪いと進学できません。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
855	部屋が静かだとよく勉強できます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
856	成績が60点以上だと合格です。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
857	卒業論文を出せば、卒業できます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
858	安ければ、買います。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
859	ちりもつもれば山となる。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
860	あした雨が降れば、運動会は中止です。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
861	あした雨が降ったら、試合は中止します。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
862	暑かったら、エアコンをつけてください。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
863	あした晴れだったら、ドライブに行きましょう。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
864	ひまだったら、遊びに来ませんか。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
865	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
866	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
867	あの大学へ行くなら、自転車が便利です。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
868	近いなら歩きましょう。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
869	嫌ならやめてもいいですよ。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
870	大学生ならこのくらいはできるはずです。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
871	家にパソコンがあります。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
872	パソコンがあるなら、インターネットができますね。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
873	車を買うと、お金がなくなります。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
874	車を買えば、どこでも行けます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
875	車を買ったら、ドライブをしよう。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
876	’B：パソコンがあるのなら、インターネットができますね。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
877	’もしあした雨が降れば、運動会は中止です。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
878	学校に｛行くと／行ったら｝、新入生がたくさんいました。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
879	どうすれば、漢字を覚えることができますか。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1541	若くてお金持ちの人		null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
881	このボタンを押すと、ドアが開きます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
882	’このボタンを押せば、ドアが開きます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
883	お酒を｛？飲めば／○飲むと／○飲んだら｝、気分が悪くなります。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
884	教科書さえ｛○あれば／×あると／？あったら｝、勉強できる。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
885	’×あの大学へ行ったら、自転車が便利です。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
886	どうすれば、漢字を覚えることができますか。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[23]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
887	毎日、新聞を読めば、覚えることができますよ。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[23]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
888	教科書さえあれば、勉強できる。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[24]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
889	雨が降ると、雪が解けます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[25]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
890	卒業論文を出せば、卒業できます。		null		\N	gmod	explanation083.xml	/gmod:explanation[1]/gmod:ExplaBlock[25]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
891	たとえ雨でも、自転車で行きます。 		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
892	雪が降っても、学校に行きます。		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
893	寒くても、泳ぎます。		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
894	嫌でも、しかたがありません。		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
895	この時計は、落としても、水にぬれてもこわれません。		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
896	だれが選ばれても、おどろきません。		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
897	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。		null		\N	gmod	explanation084.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
898	わたしは木村さんにプレゼントをあげます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
899	木村さんはわたしにプレゼントをくれます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
900	わたしは木村さんにプレゼントをもらいます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
901	わたしは木村さんにプレゼントをあげます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
902	’×わたしは木村さんにプレゼントをくれます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
903	木村さんはわたしにプレゼントをくれます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
904	’×木村さんはわたしにプレゼントをあげます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
905	妹は山田さんにおみやげをあげました。　		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
906	’×妹は山田さんにおみやげをくれました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
907	山田さんは妹に本をくれました。　		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
908	’×山田さんは妹に本をあげました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
909	木村さんは山田さんにおみやげをあげました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
910	わたしは木村さんにプレゼントをもらいます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
911	’？木村さんはわたしにプレゼントをもらいます。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
912	妹は山田さんに本をもらいました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
913	山田さんは木村さんにおみやげをもらいました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
914	△山田さんに請求書をあげました。→山田さんに請求書を渡しました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
915	△先生はたくさん宿題をくれました。→先生は宿題をたくさん出しました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
916	わたしは田中先生に花をさしあげました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1030	係員がご案内します。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
917	田中先生はわたしに手紙をくださいました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
918	わたしは田中先生に手紙をいただきました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
919	わたしは父に花をあげました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
920	父はわたしに本をくれました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
921	わたしは父に本をもらいました。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
922	花に水をやります。		null		\N	gmod	explanation085.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
923	わたしは小林さんにノートを貸してあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
924	小林さんはわたしに友だちを紹介してくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
925	木村さんに本を貸してもらいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
926	わたしは小林さんにノートを貸してあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
927	小林さんはわたしに友だちを紹介してくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
928	’わたしは小林さんにノートを貸しました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
929	’小林さんはわたしに友だちを紹介しました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
930	わたしは弟にお金を貸してあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
931	田中さんはわたしにパソコンの使い方を教えてくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
932	わたしは生徒をほめてあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
933	山田さんは息子と遊んでくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
934	妹は父にお弁当を作ってあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
935	母はわたしにてぶくろをあんでくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
936	わたしは妹の宿題を見てあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
937	木村さんはわたしの荷物を運んでくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
938	山田さんはわたしのために詩を書いてくれました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
939	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
940	木村さんに本を貸してもらいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
941	小林さんに手伝ってもらいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
942	木村さんに本を貸してもらいました。　→　木村さんに本を借りました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
943	母に料理を教えてもらいました。　→　母に料理を教わりました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
944	日本語は木村さんに教えてもらおう。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
945	あした来てもらうよ。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
946	レポートはみなさんに出してもらうことにします。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
947	’×レポートはみなさんが出してくれることにします。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
948	京都の友だちからおかしを送ってもらいました。　		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
949	’京都の友だちにおかしを送ってもらいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
950	その知らせは田中さんから教えてもらいました。　		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
951	’その知らせは田中さんに教えてもらいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
952	京都からおかしを送ってもらいました。　		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
953	’？京都におかしを送ってもらいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
954	田中先生にペンを貸してさしあげました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
955	鈴木先生はわたしに推薦状を書いてくださいました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
956	わたしは鈴木先生に推薦状を書いていただきました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
957	？先生、ペンを貸してさしあげましょうか。　→　先生、ペンをお貸ししましょうか。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
958	弟に弁当を作ってやりました。		null		\N	gmod	explanation086.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
959	駅まで歩いていきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
960	これからも日本語を勉強していきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
961	おみやげを持ってきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
962	高校の友だちがメールを送ってきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
963	日本語を学ぶ人が増えてきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
964	駅まで歩いていきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
965	おみやげを持ってきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
966	来週そちらへ行くとき、飲み物を買っていきます。　		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
967	’×来週そちらへ行くとき、飲み物を買ってきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
968	駅まで歩いていきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
969	駅前の通りを歩いてきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
970	’駅まで歩きました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
971	おみやげを持ってきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
972	授業まで時間があるので、朝のニュースを見ていきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
973	きょうは友だちと夕飯を食べてきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
974	高校の友だちがメールを送ってきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
975	これからも日本語を勉強していきます。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
976	日本語を学ぶ人が増えてきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
977	日本語を学ぶ人が増えてきました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
978	木村さんはわたしに古本を売ってきました。　		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
979	’わたしは木村さんから古本を買いました。		null		\N	gmod	explanation087.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
980	来週までにレポートを書いておきます。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
981	発表のために資料をコピーしておきました。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
982	友だちが来るので、部屋をきれいにしておきます。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
983	あした木村さんに聞いてみます。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
984	このジュースを少し飲んでみてください。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
985	すみません、この服を着てみてもいいですか。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
986	’×このジュースをたくさん飲んでみてください。→○このジュースをたくさん飲んでください。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
987	いつか南極に行ってみたいです。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
988	’いつか南極に行きたいです。		null		\N	gmod	explanation088.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
989	わたしはこの前京都へ行ったよ。		null		\N	gmod	explanation089.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
990	彼は大学の教授だ。言語学を教えている。		null		\N	gmod	explanation089.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
991	彼は大学の教授である。言語学を教えている。		null		\N	gmod	explanation089.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
992	わたしは先日京都へ行きました。		null		\N	gmod	explanation089.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
993	彼は大学の教授です。言語学を教えています。		null		\N	gmod	explanation089.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
994	日本の冬は寒い。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
995	’×日本の冬は寒いだ。×日本の冬は寒いである。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
996	この本はわたしのじゃない。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
997	わたしはきょうまでにレポートを終わらせとく。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
998	こうすりゃよかった。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
999	君、あした来るって言ったよね。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1000	たいしたもんだ。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1001	読んどいたよ、あの本。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1002	これ、プリント、先週の。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1003	ちょっと待って。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1004	すごくおいしい。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1005	わたし、きのう、あれから映画見て、ごはん食べた。		null		\N	gmod	explanation090.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1006	きのう見た映画はおもしろかったです。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1007	’×きのう見ました映画はおもしろかったです。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1008	授業に毎回出席する。これがわたしの今年の目標です。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1009	’授業に毎回出席します。これがわたしの今年の目標です。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1010	わたしは英語が苦手なので勉強します。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1011	’？わたしは英語が苦手ですので勉強します。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1012	星がたくさん出ていますからあしたは晴れでしょう。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1013	’？星がたくさん出ているからあしたは晴れでしょう。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1014	わたしは学生ですが、兄は会社員です。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1015	’？？わたしは学生だが、兄は会社員です。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1016	以上で発表は終わりでございますが、何かご質問はありますか。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1017	頼む。金を貸してくれ。お願いします。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1018	年が明けました。新しい年の始まりです。今年はどんな年になるんだろう。		null		\N	gmod	explanation091.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1019	山田さんはおそばを召し上がりました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1020	田中さんは毎朝、新聞をお読みになります。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1021	中田先生がこの本を書かれました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1022	あの方は東京駅で降りられます。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1023	あちらは山田様です。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1024	あなたのお仕事は何ですか。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1025	ご家族はどちらにいらっしゃいますか。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1026	先生は来週もお忙しいようです。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1027	先生は来週もご多忙のようです。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1028	わたしはきのう渡辺社長のお宅を拝見しました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1029	わたしがかばんをお持ちします。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1031	こちらからお電話さしあげます。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1032	先日試合で大阪に参りました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1033	’×先日試合で大阪にうかがいました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1034	''先日先生の研究室に参りました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1035	'''先日先生の研究室にうかがいました。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1036	’わたしはきのう渡辺社長の家を見たよ。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1037	他社の社員：渡辺社長はいらっしゃいますか。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1038	渡辺の部下：渡辺はただいま外出しております。		null		\N	gmod	explanation092.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1039	わたしが晩ごはんを食べているとき、友だちがうちへ来ました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1040	お母さんは若いとき看護士でした。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1041	桜の花がきれいなとき、リーさんは日本へ来ました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1042	高校生のとき、日本へ留学したことがあります。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1043	お母さんは若いとき看護士でした。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1044	’若いとき、お母さんは看護士でした。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1045	’ わたしが晩ごはんを食べているときに、友だちがうちへ来ました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1046	部屋にいるとき、電話しました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1047	部屋にいたとき、電話しました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1048	若いとき、よく泳ぎました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1049	若かったとき、よく泳ぎました。		null		\N	gmod	explanation093.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1050	テレビを見ながらごはんを食べました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1051	田中さんは、知っていながら知らないふりをしました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1052	今年の夏休みは、海にも行きましたし、山にも登りました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1053	雨が降ったので運動会が中止になりました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1054	雨が降ったから運動会が中止になりました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1055	雨が降ったのに運動会がありました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1056	雨が降ったけれども運動会がありました。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1057	春になると暖かくなります。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1058	暗いところで本を読むと目が悪くなります。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1059	雨が降れば運動会を中止します。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1060	雨が降ったら運動会を中止します。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1061	雨が降るなら運動会を中止します。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1062	雨が降っても運動会をします。		null		\N	gmod	explanation094.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1063	ここにえんぴつがあります。赤いえんぴつは３本あります。青いえんぴつは２本あります。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1064	Ａ：そこにかさとかばんがありますか。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1065	Ｂ：かさはありますが、かばんはありません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1066	春は来ましたが、まだ暖かくなりません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1067	Ａ：宿題をしてきましたか。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
1985	魚を焼くにおい		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
1068	Ｂ：レポートは書きましたが、印刷はしていません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
1069	山田先生はやさしいです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1070	田中さんは社長です。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1071	わたしはきのう大学へ行きました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1072	朝ごはんはもう食べました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1073	たばこはやめました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
1074	田中さんは学生です。佐藤さんも学生です。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1075	暖かくなりましたし、桜も咲きました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1076	時間も来ました。そろそろ終わりにしましょう。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1077	あなたもよく働きますね。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1078	あとは寝るだけです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1079	言うだけで何もしません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1080	何を聞かれても泣くばかりです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
1081	食べたいだけ食べました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1082	日本語は勉強しただけじょうずになります。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1083	すきなだけ持っていってください。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1084	山田さんこそ会長にふさわしいです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1085	全力を尽くしてこそいい結果がでます。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1086	ジュースしかありません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1087	コアラはユーカリの葉しか食べません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1088	机の上に本などがあります。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1089	辞書を引いたり、インターネットで調べるなどしました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1090	小泉氏などの政治家にインタビューしました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1091	試験中にとなりの人と話すなどのことはしてはいけません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1092	お茶などいかがですか。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1093	つまらない仕事などに時間を使いたくありません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1094	お茶でも飲みませんか。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1095	それでもだいじょうぶです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1096	このアルバイトは、いそがしい人でもできます。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1097	そのくらいのことはわたしだってできます。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1098	佐藤さんや田中さんが来ました。山田さんまで来ました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1099	日本語を勉強して、留学生試験に合格するまでになりました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1100	佐藤さんや田中さんが来ました。山田さんさえ来ました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1101	これさえあればだいじょうぶです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1102	山田さんさえいたら、この試合には勝てるのに。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1103	10人くらい来ました。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1104	これくらいの大きさです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1105	5分ほど待ってください。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1986	頭のよくなるくすり		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
1106	そのくらいのことは自分でできます。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1107	山田さんくらい頭のいい人はいません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1108	富士山はエベレストほど高くはありません。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1109	君にだけ話しましょう。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[23]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1110	太郎君とさえ話ができなかった。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[23]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1111	君だけに話しましょう。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[24]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1112	それくらいがちょうどいいです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[24]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1113	言うのです。		null		\N	gmod	explanation095.xml	/gmod:explanation[1]/gmod:ExplaBlock[25]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1114	あしたは日曜日ですか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1115	さあ、起きるか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1116	もう12時か。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1117	あなたも二十歳になりましたか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1118	だいじょうぶか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1119	本か。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1120	熱いですか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1121	だいじょうぶですか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1122	これは本ですか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1123	田中さんはあした来るでしょうか。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1124	熱い？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1125	どれが大きい？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1126	だいじょうぶ？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1127	どの部屋が静か？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1128	これは、本？　		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	0
1129	どなたが山田さん？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	0
1130	田中さんはあした来る？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	0
1131	田中さんはいつ来る？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	0
1132	熱いか？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1133	だいじょうぶか？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1134	これは本か？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1135	田中さんはあした来るか？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[10]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1136	熱い｛だろうか/かな/のかな/かしら｝？　		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1137	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[11]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1138	経済の状態はよくなるか、それが問題です。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1139	山田さんは、眠くなったのか、目をこすっています。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1140	買い物に出かけましたが、何を買うか、どこで買うか、わからなくなって困りました。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[12]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1141	あしたは日曜日かしら。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[13]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1142	さわるな。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[14]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1143	あしたは日曜日ですよ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1144	今行きますよ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1145	早く行きましょうよ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1146	早くやってくださいよ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[15]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1147	３時ですね。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1148	わたしもそう思いますね。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[16]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1149	あしたは日曜日ですね。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1150	暑いですね。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[17]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1151	ああ、きれいだなあ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[18]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1152	おや、まちがえたかな。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[19]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1153	あしたは日曜日だな。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1154	暑いな。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[20]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1155	。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[21]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1156	来たのは山田君さ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1157	僕がやるぞ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1158	俺もやるぜ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1159	よし、やるとも。　		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[22]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	0
1160	きょうは会議がありましたよね。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[25]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1161	わたしはね、きのうね、新宿へね、行ったんですよ。		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[26]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1162	きのうな、新宿へな、……		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[27]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	0
1163	きのうさ、新宿へさ、……		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[27]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	0
1164	きのうよ、新宿へよ、……		null		\N	gmod	explanation096.xml	/gmod:explanation[1]/gmod:ExplaBlock[27]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	0
1165	朝です。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1166	朝ではありません。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1167	学生です。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1168	学生ではありません。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1169	春です。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1170	春ではありません。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1171	田中です。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1172	キムです。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1173	朝ではないです。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1174	学生ではないです。		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1175	田中さんは学生です。		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1176	田中さんは　学生では　ありません。	田中不是學生。	null	たなかさんは　がくせいでは　ありません。	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1177	わたしが田中です。		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1178	父は　先生です。	我爸爸是老師。	null	ちちは　せんせいです。	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1179	父は先生ではありません。		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1180	学校は　休みです。	學校放假。	null	がっこうは　やすみです。	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1181	学校は休みではありません。		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1182	山田さんがリーダーです。		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1183	あっ、田中さんが１位です。		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1184	中山さんは大学生ですか。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1185	はい、　大学生です。	はい、　だいがくせいです。	null	はい、　だいがくせいです。	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1186	田中さんですか。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1187	はい、田中です。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1188	学生ではありませんか。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1189	はい、学生ではありません。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1190	田中さんですか。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1191	いいえ、　山口です。	いいえ、　やまぐちです。	null	いいえ、　やまぐちです。	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1192	学生ではありませんか。		null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1193	いいえ、　学生です。	いいえ、　がくせいです。	null	いいえ、　がくせいです。	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1194	東京は　晴れでした。	東京放晴了。	null	とうきょうは　はれでした。	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1195	むかし、　ここは　公園でした。	むかし、　ここは　こうえんでした。	null	むかし、　ここは　こうえんでした。	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1196	父は先生でした。		null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1197	お昼はおにぎりではありませんでした。		null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1198	きのうは休みでしたか。		null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1199	いいえ、休みではありませんでした。		null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1200	きのうは　休みでは　なかったです。	きのうは　やすみでは　なかったです。	null	きのうは　やすみでは　なかったです。	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1201	木があります。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1202	本があります。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1203	犬がいます。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1204	田中さんがいます。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1205	ペンがありますか。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1206	はい、あります。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1207	いいえ、ありません。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1208	山田さん、いますか。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1209	はい、います。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1210	いいえ、いません。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1211	何がありますか。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1212	ノートが　あります。	のーとが　あります。	null	のーとが　あります。	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1213	誰がいましたか。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1214	田中さんがいました。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1215	誰がいましたか。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1216	誰もいませんでした。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1217	ペンがありますか。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1218	はい、どうぞ。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1219	先生、　来週　漢字の　試験が　ありますか。	せんせい、　らいしゅう　かんじの　しけんが　ありますか。	null	せんせい、　らいしゅう　かんじの　しけんが　ありますか。	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
1220	はい、あります。水曜日ですよ。		null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
1221	部屋に　パソコンが　あります。	へやに　ぱそこんが　あります。	null	へやに　ぱそこんが　あります。	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1222	公園に　木が　あります。	公園裡面有樹。	null	こうえんに　きが　あります。	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1223	家に　犬が　います。	いえに　いぬが　います。	null	いえに　いぬが　います。	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1224	教室に田中さんがいます。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1225	パソコンは部屋にあります。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1226	田中さんは教室にいます。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1227	パソコンはどこにありますか。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1228	部屋にあります。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1229	田中さんは　どこに　いますか。	請問田中在哪裡？	null	たなかさんは　どこに　いますか。	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1230	教室にいます。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1231	みなさん、　質問が　ありますか。	みなさん、　しつもんが　ありますか。	null	みなさん、　しつもんが　ありますか。	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1232	ありません。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1233	お金が　ありません。	沒錢。	null	おかねが　ありません。	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1234	太郎さんには子どもがいます。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1235	公園でロックコンサートがありました。		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1236	机の上		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1237	机の下		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1238	家の前		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1239	家のうしろ		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1240	教室の中		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1241	教室の外		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1242	田中さんの右		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1243	田中さんの左		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1244	机の　上に　本が　あります。	桌子上面有書。	null	つくえの　うえに　ほんが　あります。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1245	机の　下に　かばんが　あります。	桌子下面有個包包。	null	つくえの　したに　かばんが　あります。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1246	かばんの　中に　ノートが　あります。	包包裡面有筆記本。	null	かばんの　なかに　のーとが　あります。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1247	田中さんの　右に　山田さんが　います。	田中的右邊有山田在。	null	たなかさんの　みぎに　やまださんが　います。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1248	田中さんの　左に　木村さんが　います。	田中的左邊有木村在。	null	たなかさんの　ひだりに　きむらさんが　います。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1249	家の　前に　猫が　います。	房子前面有一隻貓。	null	いえの　まえに　ねこが　います。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1250	家の　うしろに　車が　あります。	房子後面有一輛車。	null	いえの　うしろに　くるまが　あります。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1251	ポストは　家の　向かいに　あります。	郵筒在房子對面。	null	ぽすとは　いえの　むかいに　あります。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1252	埼玉は　東京の　北に　あります。	さいたまは　とうきょうの　きたに　あります。	null	さいたまは　とうきょうの　きたに　あります。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1253	田中さんは　教室の　中に　います。	たなかさんは　きょうしつの　なかに　います。	null	たなかさんは　きょうしつの　なかに　います。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1254	山田さんは　教室の　外に　います。	山田在教室外面。	null	やまださんは　きょうしつの　そとに　います。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
1255	家の　前は　公園です。	房子前面有公園。	null	いえの　まえは　こうえん　です。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
1256	山田さんのとなりは田中さんです。		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
1257	学校は　家の　近くです。	學校在家裡附近。	null	がっこうは　いえの　ちかくです。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
1258	本は　かばんの　中です。	書在包包裡面。	null	ほんは　かばんの　なかです。	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
1259	わたしの　ペンは　これです。	我的筆是這枝。	null	わたしの　ぺんは　これです。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1260	体育館の　となりに　プールが　あります。	たいいくかんの　となりに　ぷーるが　あります。	null	たいいくかんの　となりに　ぷーるが　あります。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1261	はさみは　机の　上に　あります。	はさみは　つくえの　うえに　あります。	null	はさみは　つくえの　うえに　あります。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1262	田中さんのとなりに木村さんがいます。		null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1263	あれは　数学の　教科書です。	あれは　すうがくの　きょうかしょです。	null	あれは　すうがくの　きょうかしょです。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1264	日本語の　教室は　どこですか。	日語教室在哪裡？	null	にほんごの　きょうしつは　どこですか。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1265	２階です。	にかいです。	null	にかいです。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1266	これは誰のかばんですか。	これはだれのかばんですか。	null	これはだれのかばんですか。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1267	わたしのです。		null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1268	それは　いつの　新聞ですか。	那是哪一天的報紙？	null	それは　いつの　しんぶんですか。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1269	きのうのです。		null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
3488	厚い　肉を　食べます。	我要吃厚厚的肉。	\N	あつい　にくを　たべます。	\N	vmod	\N	\N	\N	23	1
1270	わたしのはどこにありますか。		null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1271	わたしは東京外国語大学の木村です。		null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1272	日本には、　春と　夏と　秋と　冬の　４つの　季節が　あります。	にほんには、　はると　なつと　あきと　ふゆの　よっつの　きせつが　あります。	null	にほんには、　はると　なつと　あきと　ふゆの　よっつの　きせつが　あります。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1273	この　人は　友だちの　田中さんです。	この　ひとは　ともだちの　たなかさんです。	null	この　ひとは　ともだちの　たなかさんです。	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1274	教室に　新しい　コンピューターが　あります。	教室裡有新電腦。	null	きょうしつに　あたらしい　こんぴゅーたーが　あります。	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1275	箱の　中に　小さい　犬が　います。	箱子裡面有一隻小狗。	null	はこの　なかに　ちいさい　いぬが　います。	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1276	田中さんは　元気な　人です。	田中是個很有精神的人。	null	たなかさんは　げんきな　ひとです。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1277	すてきな絵ですね。		null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1278	ようかんは　どんな　食べ物ですか。	ようかんは　どんな　たべものですか。	null	ようかんは　どんな　たべものですか。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1279	あまいおかしです。		null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1280	どんな　映画ですか。	什麼樣的電影？	null	どんな　えいがですか。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1281	日本の　古い　映画です。	日本的老電影。	null	にほんの　ふるい　えいがです。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1282	どんな　かばんですか。	どんな　かばんですか。	null	どんな　かばんですか。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1283	じょうぶなかばんです。		null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1284	どんなCDがありますか。		null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1285	静かな　音楽の　CDが　あります。	しずかな　おんがくの　しーでぃーが　あります。	null	しずかな　おんがくの　しーでぃーが　あります。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1286	どの　靴を　買いますか。	你要買哪雙鞋？	null	どの　くつを　かいますか。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1287	黒いのを買います。		null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1288	どんな　音楽が　すきですか。	どんな　おんがくが　すきですか。	null	どんな　おんがくが　すきですか。	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1289	静かなのがすきです。		null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1290	これは　日本語の　教科書です。	これは　にほんごの　きょうかしょです。	null	これは　にほんごの　きょうかしょです。	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1291	日本語の　辞書は　それです。	日文的字典是那本。	null	にほんごの　じしょは　それです。	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1292	あれは　体育館です。	あれは　たいいくかんです。	null	あれは　たいいくかんです。	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1293	ここは　１年生の　教室です。	ここは　いちねんせいの　きょうしつです。	null	ここは　いちねんせいの　きょうしつです。	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1294	そこは　図書室です。	そこは　としょしつです。	null	そこは　としょしつです。	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1295	あそこは　事務室です。	あそこは　じむしつです。	null	あそこは　じむしつです。	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1296	田中さんの　かばんは　そこに　あります。	田中的包包在那裡。	null	たなかさんの　かばんは　そこに　あります。	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1297	あそこに　先生が　います。	老師在那邊。	null	あそこに　せんせいが　います。	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1298	この　部屋は　２年生の　教室です。	この　へやは　にねんせいの　きょうしつです。	null	この　へやは　にねんせいの　きょうしつです。	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1299	その　本は　わたしのです。	那本書是我的。	null	その　ほんは　わたしのです。	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1300	先生はあの人です。		null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1301	あの　きれいな　女の人は　山本さんです。	あの　きれいな　おんなのひとは　やまもとさんです。	null	あの　きれいな　おんなのひとは　やまもとさんです。	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1339	わたしは毎日勉強します。		null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1302	その　大きい　かばんは　わたしのです。	那個大的包包是我的。	null	その　おおきい　かばんは　わたしのです。	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1303	田中さんの消しゴムはどれですか。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1304	それです。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1305	すみません、　トイレは　どこですか。	對不起，請問廁所在哪裡？	null	すみません、　といれは　どこですか。	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1306	あそこです。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1307	ありがとうございました。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1308	あの　かばんは　だれのですか。	那個包包是誰的？	null	あの　かばんは　だれの　ですか。	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1309	どのかばんですか。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1310	あの黒いかばんです。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1311	あれは　田中さんのです。	那是田中的。	null	あれは　たなかさんのです。	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1312	先生の　車は　どこに　ありますか。	老師的車在哪裡呢？	null	せんせいの　くるまは　どこに　ありますか。	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1313	あそこです。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1314	わたしのぼうしはどこにありますか。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1315	そこにあります。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1316	どこですか。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1317	あなたのうしろです。		null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1318	あそこに　かさが　５本　あります。	あそこに　かさが　ごほん　あります。	null	あそこに　かさが　ごほん　あります。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1319	ケーキが　七つ　あります。	蛋糕有七個。	null	けーきが　ななつ　あります。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1320	この　ボールペンは　いくらですか。	這枝原子筆多少錢？	null	この　ぼーるぺんは　いくらですか。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1321	100円です。	ひゃくえんです。	null	ひゃくえんです。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1322	切手を　十枚と　はがきを　三枚　買います。	我要買十張郵票和三張明信片。	null	きってを　じゅうまいと　はがきを　さんまい　かいます。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1323	先生の　机の　上に　辞書が　二冊と　雑誌が　一冊　あります。	老師的桌上有兩本字典和一本雜誌。	null	せんせいの　うくえの　うえに　じしょが　にさつと　ざっしが　いっさつ　あります。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1324	ボールが　いくつ　ありますか。	ぼーるが　いくつ　ありますか。	null	ぼーるが　いくつ　ありますか。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1325	15あります。		null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1326	そこに　ハンカチが　何枚　ありますか。	那邊有幾條手帕？	null	そこに　はんかちが　なんまい　ありますか。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1327	３枚　あります。	さんまい　あります。	null	さんまい　あります。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1328	そこに　ハンカチが　どのくらい　ありますか。	そこに　はんかちが　どのくらい　ありますか。	null	そこに　はんかちが　どのくらい　ありますか。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1329	30枚くらい　あります。	さんじゅうまいくらい　あります。	null	さんじゅうまいくらい　あります。	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1330	今、　五時です。	現在五點。	null	いま、　ごじです。	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1331	今、何時ですか。		null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1332	４時です。		null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1333	今、　何時　何分ですか。	現在幾點幾分？	null	いま、　なんじ　なんぷんですか。	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1334	十時　五十一分です。	十點五十一分。	null	じゅうじ　ごじゅういっぷんです。	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1335	きょうは　何月　何日ですか。	今天幾月幾日？	null	きょうは　なんがつ　なんにちですか。	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1336	5月21日です。		null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1337	あしたは　何曜日ですか。	あしたは　なんようびですか。	null	あしたは　なんようびですか。	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1338	日曜日です。		null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1340	わたしは　毎日　勉強しません。	わたしは　まいにち　べんきょうしません。	null	わたしは　まいにち　べんきょうしません。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1341	テレビは　ピアノの　そばに　あります。	電視在鋼琴旁邊。	null	てれびは　ぴあのの　そばに　あります。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1342	田中さんは教室にいます。		null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1343	田中さんは　これから　図書館で　勉強します。	たなかさんは　これから　としょかんで　べんきょうします。	null	たなかさんは　これから　としょかんで　べんきょうします。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1344	わたしはあした研究室にいます。		null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1345	あしたパーティーがあります。		null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1346	わたしはあした研究室にいません。		null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1347	あした、小説家の山口さんが来ます。		null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1348	あしたは　午前中で　授業が　終わります。	明天的課上午就會結束。	null	あしたは　ごぜんちゅうで　じゅぎょうが　おわります。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1349	毎日、　学校へ　行きます。	我每天去上學。	null	まいにち、　がっこうへ　いきます。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1350	田中さんは　図書館で　勉強しますが、　わたしは　家で　勉強します。	田中在圖書館看書，我在家裡看書。	null	たなかさんは　としょかんで　べんきょうしますが、　わたしは　いえで　べんきょうします。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1351	熱が　ありますから、　休みます。	ねつが　ありますから、　やすみます。	null	ねつが　ありますから、　やすみます。	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1352	毎日、勉強しますか。		null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1353	テレビはピアノのそばにありますか。		null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1354	田中さんは教室にいますか。		null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1355	これから図書館で勉強しますか。		null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1356	きのう　わたしは　勉強しました。	昨天我唸書了。	null	きのう　わたしは　べんきょうしました。	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1357	むかし、　学校の　門の　そばに　大きい　木が　ありました。	むかし、　がっこうの　もんの　そばに　おおきい　きが　ありました。	null	むかし、　がっこうの　もんの　そばに　おおきい　きが　ありました。	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1358	きのうは　雨が　降りませんでした。	きのうは　あめが　ふりませんでした。	null	きのうは　あめが　ふりませんでした。	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1359	きのう地震がありましたか。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1360	はい、ありました。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1361	試験は終わりましたか。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1362	はい、終わりました。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1363	試験は終わりましたか。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1364	B1：はい、もう終わりました。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1365	B2：いいえ、まだです。		null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1366	学校へ行きます。		null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1367	うちへ　帰ります。	我要回家了。	null	うちへ　かえります。	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1368	公園へ行きますか。		null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1369	いいえ、　行きません。	不，我不去。	null	いいえ、　いきません。	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1370	わたしは　ハンバーガーを　食べます。	わたしは　はんばーがーを　たべます。	null	わたしは　はんばーがーを　たべます。	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1371	田中さんは　コーラを　飲みます。	田中要喝可樂。	null	たなかさんは　こーらを　のみます。	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1372	CDを買います。		null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1373	切手を　3枚　買います。	きってを　さんまい　かいます。	null	きってを　さんまい　かいます。	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1374	何を食べますか。		null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1375	サンドイッチを食べます。		null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1376	あした映画を見ますか。		null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1377	いいえ、見ません。		null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1378	田中さんに　手紙を　出します。	我要寄信給田中。	null	たなかさんに　てがみを　だします。	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1379	山田さんに　お金を　貸します。	我要借錢給山田。	null	やまださんに　おかねを　かします	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1380	木村さんに　英語を　教えます。	我要教木村英語。	null	きむらさんに　えいごを　おしえます。	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1381	佐藤さんにプレゼントをあげます。		null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1382	山田さんに　お金を　借ります。	我要向山田借錢。	null	やまださんに　おかねを　かります。	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1383	木村さんに　フランス語を　習います。	きむらさんに　ふらんすごを　ならいます。	null	きむらさんに　ふらんすごを　ならいます。	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1384	佐藤さんにプレゼントをもらいます。		null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1385	壁にシールをはります。		null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1386	机に　本を　置きます。	把書放在桌子上。	null	つくえに　ほんを　おきます。	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1387	山田さんに本を見せます。		null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1388	わたしは　七時半に　起きます。	我七點半起床。	null	わたしは　しちじはんに　おきます。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1389	十一時に　寝ます。	十一點睡覺。	null	じゅういちじに　ねます。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1390	何時に起きますか。		null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1391	７時に起きます。		null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1392	日曜日に　テニスを　します。	星期日我打網球。	null	にちようびに　てにすを　します。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1393	いつ　テニスを　しますか。	什麼時候要打網球？	null	いつ　てにすを　しますか。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1394	あしたテニスをします。		null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1395	土曜日、　何を　しましたか。	どようび、　なにを　しましたか。	null	どようび、　なにを　しましたか。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1396	映画を　見ました。	我看了電影。	null	えいがを　みました。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1397	わたしは　夏休みに　旅行しました。	暑假我去旅行了。	null	わたしは　なつやすみに　りょこうしました。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1398	山田さんの　誕生日に　パーティーを　します。	山田生日那天要辦派對。	null	やまださんの　たんじょうびに　ぱーてぃーを　します。	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1399	この　りんごは　甘いです。	この　りんごは　あまいです。	null	この　りんごは　あまいです。	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1400	あの　りんごは　甘く　ありません。	あの　りんごは　あまく　ありません。	null	あの　りんごは　あまく　ありません。	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1401	わたしの　家の　犬は　大きいです。	我家的狗很大。	null	わたしの　いえの　いぬは　おおきいです。	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1402	となりの　家の　犬は　大きく　ありません。	鄰居的狗不大。	null	となりの　いえの　いぬは　おおきく　ありません。	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1403	きょうは　寒くないです。	今天不冷。	null	きょうは　さむくないです。	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1404	甘いです。		null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1405	大きいです。		null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1406	勉強は　おもしろいですか。	べんきょうは　おもしろいですか。	null	べんきょうは　おもしろいですか。	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1407	はい、　おもしろいです。	はい、　おもしろいです。	null	はい、　おもしろいです。	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1408	日本の　料理は　辛いですか。	日本料理會辣嗎？	null	にほんの　りょうりは　からいですか。	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1409	いいえ、　辛くないです。	不，不辣的。	null	いいえ、　からくないです。	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1410	外は　寒いですか。	外面冷嗎？	null	そとは　さむいですか。	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1411	はい、寒いです。		null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1413	いいえ、寒くありません。		null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1414	日本の　料理は　どうですか。	日本料理怎麼樣？	null	にほんの　りょうりは　どうですか。	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1415	おいしいです。		null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1416	どんなかばんですか。		null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1417	赤いです。		null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1418	この　かばんは　高かったです。	這個包包很貴。	null	この　かばんは　たかかったです。	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1419	パーティーの　料理は　おいしく　ありませんでした。	派對上的菜不好吃。	null	ぱーてぃーの　りょうりは　おいしく　ありませんでした。	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1420	きのうは　寒くなかったです。	きのうは　さむくなかったです。	null	きのうは　さむくなかったです。	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1421	北海道はどうでしたか。		null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1422	   B:寒かったです。		null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1423	きのうの　映画は　どうでしたか。	昨天的電影怎麼樣？	null	きのうの　えいがは　どうでしたか。	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1424	   B:おもしろくありませんでした。		null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1425	太郎君の　犬は　とても　大きいです。	たろうくんの　いぬは　とても　おおきいです。	null	たろうくんの　いぬは　とても　おおきいです。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1426	わたしの　部屋は　あまり　広くありません。	我的房間不是很大。	null	わたしの　へやは　あまり　ひろくありません。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1427	とても　つかれました。	累死我了。	null	とても　つかれました。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1428	あまり　つかれませんでした。	不會很累。	null	あまり　つかれませんでした。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1429	とても　勉強します。	とても　べんきょうします。	null	とても　べんきょうします。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1430	あまり　勉強しません。	あまり　べんきょうしません。	null	あまり　べんきょうしません。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1431	この　あたりには、　あまり　高い　建物が　ありません。	這附近沒有什麼高的建築物。	null	この　あたりには、　あまり　たかい　たてものが　ありません。	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1432	きょうは　暑い　日です。	きょうは　あつい　ひです。	null	きょうは　あつい　ひです。	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1433	駅前に　いい　店が　あります。	車站前面有一家好店。	null	えきまえに　いい　みせが　あります。	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1434	ここは　とても　静かな　部屋です。 	這裡是很安靜的房間。	null	ここは　とても　しずかな　へやです。	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1435	すてきな　服ですね。	好漂亮的衣服呀。	null	すてきな　ふくですね。	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1436	きょうはハッピーな日です。		null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1437	この　かさは　じょうぶです。	この　かさは　じょうぶです。	null	この　かさは　じょうぶです。	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1438	その　かさは　じょうぶですか。	その　かさは　じょうぶですか。	null	その　かさは　じょうぶですか。	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1439	いいえ、じょうぶではありません。		null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1440	田中さんは　元気でしたか。	たなかさんは　げんきでしたか。	null	たなかさんは　げんきでしたか。	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1441	はい、　元気でした。	はい、　げんきでした。	null	はい、　げんきでした。	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1442	いいえ、　元気ではありませんでした。	いいえ、　げんきではありませんでした。	null	いいえ、　げんきではありませんでした。	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1443	このかさはじょうぶではないです。		null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1444	田中さんは　元気ではなかったです。	たなかさんは　げんきではなかったです。	null	たなかさんは　げんきではなかったです。	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1445	田中さんは　髪が　長いです。	たなかさんは　かみが　ながいです。	null	たなかさんは　かみが　ながいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1446	田中さんは　背が　高いです。	田中長得很高。	null	たなかさんは　せが　たかいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1447	中山さんは　力が　強いです。	なかやまさんは　ちからが　つよいです。	null	なかやまさんは　ちからが　つよいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1448	うちの　猫は　目が　きれいです。	うちの　ねこは　めが　きれいです。	null	うちの　ねこは　めが　きれいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1449	わたしは　きのうから　のどが　痛いです。	我從昨天開始頭就在痛了。	null	わたしは　きのうから　のどが　いたいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1450	頭が　痛いですか。	頭痛嗎？	null	あたまが　いたいですか。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1451	いいえ、　痛くないです。	不，不痛。	null	いいえ、　いたくないです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1452	田中さん、だいじょうぶですか。		null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1453	ちょっと　気分が　悪いです。	ちょっと　きぶんが　わるいです。	null	ちょっと　きぶんが　わるいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1454	この　町は　道が　狭いです。	這個小鎮的道路很窄。	null	この　まちは　みちが　せまいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1455	この　絵は　色が　きれいです。	這幅畫顏色很漂亮。	null	この　えは　いろが　きれいです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1456	田中さんはバスケットボールがじょうずです。		null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1457	わたしは　歌が　へたです。	我唱歌唱得不好。	null	わたしは　うたが　へたです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1458	わたしはピアノが得意です。		null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1459	山田さんは、　お父さんが　よく　働きます。	山田的父親工作很勤奮。	null	やまださんは、　おとうさんが　よく　はたらきます。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1460	山田さんは、　お父さんが　医者です。	山田的父親是醫生。	null	やまださんは、　おとうさんが　いしゃです。	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1461	この雑誌は新しい。		null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1462	その　ケーキは　おいしかった。	その　けーきは　おいしかった。	null	その　けーきは　おいしかった。	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1463	公園は　静かだった。	こうえんは　しずかだった。	null	こうえんは　しずかだった。	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1464	あの　電子辞書は　便利ではなかった。	あの　でんしじしょは　べんりではなかった。	null	あの　でんしじしょは　べんりではなかった。	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1465	わたしは大学生だ。		null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1466	木村さんは先生ではない。		null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1467	ここはむかし公園だった。		null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1468	山田さんは　病気ではなかった。	やまださんは　びょうきではなかった。	null	やまださんは　びょうきではなかった。	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1469	映画を見た。		null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1470	この　雑誌は　新しい。	この　ざっしは　あたらしい。	null	この　ざっしは　あたらしい。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1471	あの　電子辞書は　便利だ。	あの　でんしじしょは　べんりだ。	null	あの　でんしじしょは　べんりだ。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1472	きょうは雨だ。		null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1473	宿題を　忘れないで　ください。	不要忘記寫作業。	null	しゅくだいを　わすれないで　ください。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1474	ここで　勉強する　ことが　できます。	在這裡可以唸書。	null	ここで　べんきょうする　ことが　できます。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1475	あしたは　雨が　降るでしょう。	あしたは　あめが　ふるでしょう。	null	あしたは　あめが　ふるでしょう。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1476	あの　人は　日本語の　先生だと　思います。	我覺得那個人是日語教師。	null	あの　ひとは　にほんごの　せんせいだと　おもいます。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1477	これは　きのう　買った　テープです。	這是昨天買的帶子。	null	これは　きのう　かった　てーぷです。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1478	道が　わからない　とき、　電話で　聞いて　ください。	不知道路的時候，請打電話問。	null	みちが　わからない　とき、　でんわで　きいて　ください。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1479	雨が降ったので試合が中止になりました。		null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1480	雨が　降ったけれども　試合を　しました。	あめが　ふったけれども　しあいを　しました。	null	あめが　ふったけれども　しあいを　しました。	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1481	小林さんは　青い　シャツを　着て　います。	小林穿著藍色的襯衫。	null	こばやしさんは　あおい　しゃつを　きて　います。	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1482	手紙に　書いて　ありました。	信裡面有寫。	null	てがみに　かいて　ありました。	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1483	６時に起きて、ジョギングをしました。		null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1484	ごはんを　食べてから、　歯を　みがきます。	吃完飯再刷牙。	null	ごはんを　たべてから、　はを　みがきます。	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1485	立って　ください。	請起立。	null	たって　ください。	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1486	もう一度　言って　くださいませんか。	もういちど　いって　くださいませんか。	null	もういちど　いって　くださいませんか。	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1487	あした、休んでもいいですか。		null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1488	本を読んであげます。		null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1489	ビールを買っていきます。		null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1490	食べてみます。		null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1491	今、　小林さんは　図書館で　本を　読んで　います。	現在小林在圖書館看書。	null	いま、　こばやしさんは　としょかんで　ほんを　よんで　います。	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1492	田中さんは　今　何を　して　いますか。	田中現在在做什麼？	null	たなかさんは　いま　なにを　して　いますか。	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1493	ごはんを　食べて　います。	ごはんを　たべて　います。	null	ごはんを　たべて　います。	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1494	いつから　日本語を　勉強して　いますか。	從什麼時候開始學日文的？	null	いつから　にほんごを　べんきょうして　いますか。	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1495	去年から　勉強して　います。	我從去年開始學。	null	きょねんから　べんきょうして　います。	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1496	日本語の辞書はありますか。		null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1497	すみません、今使っています。		null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1498	木村さんをお願いします。		null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1499	木村さんは　今　食事を　しています。	きむらさんは　いま　しょくじを　しています。	null	きむらさんは　いま　しょくじを　しています。	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1500	体育館の　前に　小林さんが　立って　います。	たいいくかんの　まえに　こばやしさんが　たって　います。	null	たいいくかんの　まえに　こばやしさんが　たって　います。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1501	窓が　開いて　います。	窗戶是開著的。	null	まどが　あいて　います。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1502	山田先生を　知って　いますか。	やまだせんせいを　しって　いますか。	null	やまだせんせいを　しって　いますか。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1503	いいえ、　知りません。	いいえ、　しりません。	null	いいえ、　しりません。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1504	わたしは　毎朝　ジョギングを　して　います。	わたしは　まいあさ　じょぎんぐを　して　います。	null	わたしは　まいあさ　じょぎんぐを　して　います。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1505	わたしは　３年前　アメリカで　勉強して　います。	わたしは　さんねんまえ　あめりかで　べんきょうして　います。	null	わたしは　さんねんまえ　あめりかで　べんきょうして　います。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1506	山田さんは　10年前に　大学を　卒業して　います。	やまださんは　じゅうねんまえに　だいがくを　そつぎょうして　います。	null	やまださんは　じゅうねんまえに　だいがくを　そつぎょうして　います。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1507	この　道は　曲がって　います。	這條路是彎的。	null	この　みちは　まがって　います。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1508	ビルがそびえています。		null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1509	山田さんは　お父さんに　似ています。	やまださんは　おとうさんに　にています。	null	やまださんは　おとうさんに　にています。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1510	もしもし、　まりさんは　いますか。	もしもし、　まりさんは　いますか。	null	もしもし、　まりさんは　いますか。	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1511	 B：いいえ。まりは今買い物に行っています。		null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1512	窓が　閉めて　あります。	有人把窗戶關起來了。	null	まどが　しめて　あります。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1513	電気が　消して　ありました。	電燈當時是關著的。	null	でんきが　けして　ありました。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1514	駅の　ホームに　新しい　映画の　ポスターが　はって　ありました。	えきの　ほーむに　あたらしい　えいがの　ぽすたーが　はって　ありました。	null	えきの　ほーむに　あたらしい　えいがの　ぽすたーが　はって　ありました。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1515	問題は　十五ページに　書いて　あります。	問題寫在第十五頁。	null	もんだいは　じゅうごぺーじに　かいて　あります。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1516	机の　上に　辞書が　置いて　ありますか。	つくえの　うえに　じしょが　おいて　ありますか。	null	つくえの　うえに　じしょが　おいて　ありますか。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1517	はい、　置いて　あります。	はい、　おいて　あります。	null	はい、　おいて　あります。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1518	あ、　ケーキが　切って　ありますよ。	あ、　けーきが　きって　ありますよ。	null	あ、　けーきが　きって　ありますよ。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1519	じゃあ、食べましょう。		null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1520	窓が　開けて　あります。	有人把窗戶打開了。	null	まどが　あけて　あります。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1521	小林さんに　来週の　予定を　話して　ありますか。	こばやしさんに　らいしゅうの　よていを　はなして　ありますか。	null	こばやしさんに　らいしゅうの　よていを　はなして　ありますか。	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1522	いいえ、まだです。		null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1523	漢字を調べてありますか。		null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1524	はい、調べました。		null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1525	田中さんと　山田さんは　大学２年生です。	たなかさんと　やまださんは　だいがくにねんせいです。	null	たなかさんと　やまださんは　だいがくにねんせいです。	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1526	わたしは　パンと　サラダを　食べます。	わたしは　ぱんと　さらだを　たべます。	null	わたしは　ぱんと　さらだを　たべます。	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1527	机の　上に　本と　ノートが　あります。	桌子上有書和筆記本。	null	つくえの　うえに　ほんと　のーとが　あります。	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1528	月曜日と　水曜日と　金曜日に　サッカーの　練習が　あります。	星期一跟星期三跟星期五有足球的練習。	null	げつようびと　すいようびと　きんようびに　さっかーの　れんしゅうが　あります。	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1529	わたしは　日曜日に　漫画や　雑誌を　読みます。	わたしは　にちようびに　まんがや　ざっしを　よみます。	null	わたしは　にちようびに　まんがや　ざっしを　よみます。	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1530	デパートや　スーパーで　買い物を　します。	我要去百貨公司跟超級市場買東西。	null	でぱーとや　すーぱーで　かいものを　します。	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1531	郵便局の　前や　駅の　そばに　ポストが　あります。	在郵局前面和車站旁邊有郵筒。	null	ゆうびんきょくの　まえや　えきの　そばに　ぽすとが　あります。	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1532	パンや　卵などを　食べます。	我吃麵包和雞蛋等等。	null	ぱんや　たまごなどを　たべます。	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1533	わたしの　部屋に　机や　ベッドや　テレビなどが　あります。	我的房間裡面有桌子、床和電視等等。	null	わたしの　へやに　つくえや　べっどや　てれびなどが　あります。	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1534	大きくて　黒い　かばんは　わたしのです。	大大的黑色背包是我的。	null	おおきくて　くろい　かばんは　わたしのです。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1535	きれいで　静かな　アパートに　住んで　います。	我住在漂亮又安靜的公寓。	null	きれいで　しずかな　あぱーとに　すんで　います。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1536	３年生で留学生の金さん		null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1537	この　花は　小さくて　赤いです。	這朵花又小又紅。	null	この　はなは　ちいさくて　あかいです。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1538	木村さんはテニスがじょうずで、小林さんはサッカーがじょうずです。		null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1539	田中さんは３年生で、中村さんは４年生です。		null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1543	田中さんは　背が　高くて　めがねを　かけて　います。	たなかさんは　せが　たかくて　めがねを　かけて　います。	null	たなかさんは　せが　たかくて　めがねを　かけて　います。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1544	この　本は　漢字が　多くて　難しいです。	這本書有很多漢字，很難。	null	この　ほんは　かんじが　おおくて　むずかしいです。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1545	熱が　高くて、　学校へ　行く　ことが　できませんでした。	因為發高燒，沒有辦法去上學。	null	ねつが　たかくて、　がっこうへ　いく　ことが　できませんでした。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1546	わたしは　夏休みに　テニスを　したり　泳いだり　しました。	暑假的時候我打了網球、游了泳。	null	わたしは　なつやすみに　てにすを　したり　およいだり　しました。	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1547	日曜日に　弟は　本を　読んだり　テレビを　見たり　して　います。	星期日弟弟都會看看書看看電視。	null	にちようびに　おとうとは　ほんを　よんだり　てれびを　みたり　して　います。	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1548	友だちと　よく　映画を　見たり　プールに　行ったり　します。	我常和朋友去看看電影、游游泳。	null	ともだちと　よく　えいがを　みたり　ぷーるに　いったり　します。	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1549	飛行機で　東京と　大阪を　行ったり　来たり　します。	搭飛機在東京跟大阪之間來回。	null	ひこうきで　とうきょうと　おおさかを　いったり　きたり　します。	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1550	雨が　降ったり　やんだり　して　います。	あめが　ふったり　やんだり　しています。	null	あめが　ふったり　やんだり　しています。	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1551	あした　わたしは　駅で　友だちに　会って、　いっしょに　コンサートに　行きます。	明天我要跟朋友在車站見面，然後一起去看演唱會。	null	あした　わたしは　えきで　ともだちに　あって、　いっしょに　こんさーとに　いきます。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1552	あしたの　予定を　教えて　ください。	あしたの　よていを　おしえて　ください。	null	あしたの　よていを　おしえて　ください。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1553	朝　七時に　起きて、　食堂で　朝ごはんを　食べて、　８時から　練習します。	我早上七點起床，在餐廳吃完早餐後，八點開始練習。	null	あさ　しちじに　おきて、　しょくどうで　あさごはんを　たべて、　はちじから　れんしゅうします。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1554	わたしは　日本へ　行って、　すもうを　見たいです。	わたしは　にほんへ　いって、　すもうを　みたいです。	null	わたしは　にほんへ　いって、　すもうを　みたいです。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1555	２つに　折って、　はさみで　切って　ください。	ふたつに　おって、　はさみで　きって　ください。	null	ふたつに　おって、　はさみで　きって　ください。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1556	あそこに　座って、　お弁当を　食べましょう。	做在那裡吃便當吧。	null	あそこに　すわって、　おべんとうを　たべましょう。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1557	わたしは　毎日　歩いて　学校へ　行きます。	我每天走路去學校。	null	わたしは　まいにち　あるいて　がっこうへ　いきます。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1558	テープを　聞いて、　日本語を　勉強します。	我聽錄音帶學日文。	null	てーぷを　きいて、　にほんごを　べんきょうします。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1559	夏休みに　中山さんは　海で　ダイビングを　して、　山本さんは　山に　登りました。	なつやすみに　なかやまさんは　うみで　だいびんぐを　して、　やまもとさんは　やまに　のぼりました。	null	なつやすみに　なかやまさんは　うみで　だいびんぐを　して、　やまもとさんは　やまに　のぼりました。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1560	田中さんは　東京に　住んで　いて、　山本さんは　大阪に　住んで　います。	たなかさんは　とうきょうに　すんで　いて、　やまもとさんは　おおさかに　すんで　います。	null	たなかさんは　とうきょうに　すんで　いて、　やまもとさんは　おおさかに　すんで　います。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1561	雨が降って、野球の試合を中止しました。		null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1562	大きい　台風が　来て、　電車が　止まりました。	因為很強的台風來了，電車都停開了。	null	おおきい　たいふうが　きて、　でんしゃが　とまりました。	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1563	田中さんが来て、木村さんが帰りました。		null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1564	庭の花		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1565	山田さんと田中さん		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1566	机の上に本があります。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1567	本を読みます。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1568	10時から　授業を　始めます。	じゅうじから　じゅぎょうを　はじめます。	null	じゅうじから　じゅぎょうを　はじめます。	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1569	朝　起きて　顔を　洗います。	あさ　おきて　かおを　あらいます。	null	あさ　おきて　かおを　あらいます。	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1570	春に　なると、　暖かく　なります。	はるに　なると、　あたたかく　なります。	null	はるに　なると、　あたたかく　なります。	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1571	雨が降ったら運動会は休みです。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1572	この本は読みました。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1573	この本も読みました。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1574	この本だけ読みました。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1575	この本ばかり読みました。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1576	この本まで読みました。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1577	この本など読みました。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1578	あしたは日曜日ですか。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1579	あしたは日曜日ですよ。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1580	あしたは日曜日ですね。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1581	あなた に だけ は 話しましょう。		null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1582	きょうの　テストは　３時からですよね。	きょうの　てすとは　さんじからですよね。	null	きょうの　てすとは　さんじからですよね。	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1583	山田さんが本を読みました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1584	先生に相談します。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1585	学校へ行きます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1586	学校から　家まで　歩きます。	從學校到家裡我用走的。	null	がっこうから　いえまで　あるきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1587	佐藤さんは鈴木さんより年上です。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1588	食堂で　ごはんを　食べます。	我要在餐廳吃飯。	null	しょくどうで　ごはんを　たべます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1589	机の上		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1590	田中さんと山田さんが来ました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1591	佐藤さんや田中さんが来ました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1592	空が　青いです。	天空很藍。	null	そらが　あおいです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1593	田中さんが最初です。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1594	机の上に本があります。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1595	コンピューターがほしいです。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1596	ふるさとがなつかしいです。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1597	水｛が/を｝飲みたいです。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1598	英語｛が/を｝話せます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1599	わたしは　本を　読みました。	我看了書。	null	わたしは　ほんを　よみました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1600	わたし、大学へ行きます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1601	九時に　家を　出ます。	我九點出門。	null	くじに　いえを　でます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1602	十字路を　右に　曲がります。	じゅうじろを　みぎに　まがります。	null	じゅうじろを　みぎに　まがります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
1603	毎日　この　道を　通ります。	まいにち　この　みちを　とおります。	null	まいにち　この　みちを　とおります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
1604	大学を　卒業します。	だいがくを　そつぎょうします。	null	だいがくを　そつぎょうします。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
1605	学校を　休みます。	我有事不能去學校。	null	がっこうを　やすみます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
1606	楽しい　一日を　過ごしました。	たのしい　いちにちを　すごしました。	null	たのしい　いちにちを　すごしました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
1607	あらしの　中を　走りました。	あらしの　なかを　はしりました。	null	あらしの　なかを　はしりました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[25]	\N	\N	1
1608	拍手の中を歩きました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[26]	\N	\N	1
1609	パンだけ　食べました。	我只吃了麵包。	null	ぱんだけ　たべました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[27]	\N	\N	1
1610	パン、食べました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[28]	\N	\N	1
1611	山田さんにプレゼントを贈ります。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[29]	\N	\N	1
1612	田中さんに　英語を　教えます。	たなかさんに　えいごを　おしえます。	null	たなかさんに　えいごを　おしえます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[30]	\N	\N	1
1613	木村さんに本をあげます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[31]	\N	\N	1
1614	壁に　写真を　はります。	把照片貼在牆上。	null	かべに　しゃしんを　はります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[32]	\N	\N	1
1615	ゴミ箱にごみを捨てます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[33]	\N	\N	1
1616	犬が山田さんにほえました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[34]	\N	\N	1
1617	東京に行きます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[35]	\N	\N	1
1618	家に帰ります。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[36]	\N	\N	1
1619	飛行機に　乗ります。	我要搭飛機。	null	ひこうきに　のります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[37]	\N	\N	1
1620	駅の　前に　集まります。	えきの　まえに　あつまります。	null	えきの　まえに　あつまります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[38]	\N	\N	1
1621	氷が水になりました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[39]	\N	\N	1
1622	山田さんは子どもを政治家にしました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[40]	\N	\N	1
1623	山田さんに　本を　読ませます。	やまださんに　ほんを　よませます。	null	やまださんに　ほんを　よませます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[41]	\N	\N	1
1624	先生にほめられました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[42]	\N	\N	1
1625	田中さんに　本を　見せます。	我要把書給田中看。	null	たなかさんに　ほんを　みせます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[43]	\N	\N	1
1626	お母さんに見つかりました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[44]	\N	\N	1
1627	木村さんに　英語を　教わりました。	きむらさんに　えいごを　おそわりました。	null	きむらさんに　えいごを　おそわりました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[45]	\N	\N	1
1628	山田さんはお父さんに似ています。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[46]	\N	\N	1
1629	この　ズボンは　わたしには　大きすぎます。	この　ずぼんは　わたしには　おおきすぎます。	null	この　ずぼんは　わたしには　おおきすぎます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[47]	\N	\N	1
1630	テレビは　目に　よくないです。	看電視對眼睛不好。	null	てれびは　めに　よくないです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[48]	\N	\N	1
1631	１回に　３袋ずつ　使います。	いっかいに　さんふくろずつ　つかいます。	null	いっかいに　さんふくろずつ　つかいます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[49]	\N	\N	1
1632	教室に　佐藤さんが　います。	きょうしつに　さとうさんが　います。	null	きょうしつに　さとうさんが　います。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[50]	\N	\N	1
1633	机の上に本があります。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[51]	\N	\N	1
1634	ホテルに　泊まります。	我要住飯店。	null	ほてるに　とまります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[52]	\N	\N	1
1635	大学の　近くに　家を　建てます。	だいがくの　ちかくに　いえを　たてます。	null	だいがくの　ちかくに　いえを　たてます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[53]	\N	\N	1
1636	庭に　花が　咲きます。	院子裡會開花。	null	にわに　はなが　さきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[54]	\N	\N	1
1637	七時に　家を　出ます。	七點出門。	null	しちじに　いえを　でます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[55]	\N	\N	1
1638	今年の　三月　十五日に　日本に　来ました。	我在今年的三月十五日來到日本。	null	ことしの　さんがつ　じゅうごにちに　にほんに　きました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[56]	\N	\N	1
1639	買い物に　行きます。	かいものに　いきます。	null	かいものに　いきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[57]	\N	\N	1
1640	シャツを　買いに　いきます。	我要去買襯衫。	null	しゃつを　かいに　いきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[58]	\N	\N	1
1641	えんぴつは　字を　書くのに　使います。	えんぴつは　じを　かくのに　つかいます。	null	えんぴつは　じを　かくのに　つかいます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[59]	\N	\N	1
1642	山田さんに佐藤さんに田中さんが来ました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[60]	\N	\N	1
1643	人の多さにびっくりしました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[61]	\N	\N	1
1644	カラオケで　歌いに　歌って、　声が　出なく　なりました。	からおけで　うたいに　うたって、　こえが　でなく　なりました。	null	からおけで　うたいに　うたって、　こえが　でなく　なりました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[62]	\N	\N	1
1645	飛行機が　南へ　飛んで　いきます。	飛機往南邊飛著。	null	ひこうきが　みなみへ　とんで　いきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[63]	\N	\N	1
1646	八月　一日から　九月　三十日まで　夏休みです。	從八月一日到九月三十日是暑假。	null	はちがつ　ついたちから　くがつ　さんじゅうにちまで　なつやすみです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[64]	\N	\N	1
1647	一番の　人から　十番の　人まで　入って　ください。	一號到十號的人請進。	null	いちばんの　ひとから　じゅうばんの　ひとまで　はいって　ください。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[65]	\N	\N	1
1648	大人から　子どもまで　人気が　あります。	おとなから　こどもまで　にんきが　あります。	null	おとなから　こどもまで　にんきが　あります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[66]	\N	\N	1
1649	この　店は、　おかしから　チケットまで、　なんでも　売って　います。	この　みせは、　おかしから　ちけっとまで、　なんでも　うって　います。	null	この　みせは、　おかしから　ちけっとまで、　なんでも　うって　います。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[67]	\N	\N	1
1650	教室から　出ます。	我要離開教室。	null	きょうしつから　でます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[68]	\N	\N	1
1651	あしたから夏休みです。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[69]	\N	\N	1
1652	ぶどうからワインを作ります。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[70]	\N	\N	1
1653	田中さんから本を贈りました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[71]	\N	\N	1
1654	先生から　質問を　出しました。	老師問問題了。	null	せんせいから　しつもんを　だしました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[72]	\N	\N	1
1655	わたしから説明します。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[73]	\N	\N	1
1656	鈴木さんから説明させました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[74]	\N	\N	1
1657	先生からほめられました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[75]	\N	\N	1
1658	白線より　中に　入らないで　ください。	はくせんより　なかに　はいらないで　ください。	null	はくせんより　なかに　はいらないで　ください。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[76]	\N	\N	1
1659	これより会議を始めます。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[77]	\N	\N	1
1660	公園で　コンサートが　あります。	公園裡面有演唱會。	null	こうえんで　こんさーとが　あります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[78]	\N	\N	1
1661	世界で　一番　長い　川は　ナイル川です。	せかいで　いちばん　ながい　かわは　ないるがわです。	null	せかいで　いちばん　ながい　かわは　ないるがわです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[79]	\N	\N	1
1662	日本では、　３月と　４月と　５月は　春です。	にほんでは、　さんがつと　しがつと　ごがつは　はるです。	null	にほんでは、　さんがつと　しがつと　ごがつは　はるです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[80]	\N	\N	1
1663	片道で100円、往復で200円です。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[81]	\N	\N	1
1664	これで十分です。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[82]	\N	\N	1
1665	あしたでも　いいです。	あしたでも　いいです。	null	あしたでも　いいです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[83]	\N	\N	1
1666	これではだめです。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[84]	\N	\N	1
1667	ペンで　字を　書きます。	用筆寫字。	null	ぺんで　じを　かきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[85]	\N	\N	1
1668	バスで　学校に　行きます。	我搭公車去學校。	null	ばすで　がっこうに　いきます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[86]	\N	\N	1
1669	佐藤さんは　大きい　声で　話します。	さとうさんは　おおきい　こえで　はなします。	null	さとうさんは　おおきい　こえで　はなします。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[87]	\N	\N	1
1670	木で机を作ります。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[88]	\N	\N	1
1671	病気で　学校を　休みました。	因為生病所以我沒有去上學。	null	びょうきで　がっこうを　やすみました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[89]	\N	\N	1
1672	台風で　電車が　遅れました。	因為颱風的關係電車誤點了。	null	たいふうで　でんしゃが　おくれました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[90]	\N	\N	1
1673	子どもがはだしで歩いています。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[91]	\N	\N	1
1674	子どもが　はだかで　走って　います。	こどもが　はだかで　はしって　います。	null	こどもが　はだかで　はしって　います。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[92]	\N	\N	1
1675	いつも　ひとりで　勉強して　います。	我都是一個人唸書。	null	いつも　ひとりで　べんきょうして　います。　	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[93]	\N	\N	1
1676	家族　全員で　ドライブ　しました。	かぞく　ぜんいんで　どらいぶ　しました。	null	かぞく　ぜんいんで　どらいぶ　しました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[94]	\N	\N	1
1677	日本語が１年間でじょうずになりました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[95]	\N	\N	1
1678	この　コンピューターを　20万円で　買いました。	この　こんぴゅーたーを　にじゅうまんで　かいました。	null	この　こんぴゅーたーを　にじゅうまんで　かいました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[96]	\N	\N	1
1679	あと　十分で　五時です。	還有十分鐘就五點了。	null	あと　じゅっぷんで　ごじです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[97]	\N	\N	1
1680	２と３で５です。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[98]	\N	\N	1
1681	警察で事件を調べています。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[99]	\N	\N	1
1682	クラスで　旅行に　出かけました。	全班一起去旅行了。	null	くらすで　りょこうに　でかけました。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[100]	\N	\N	1
1683	その　仕事は　自分で　やります。	那個工作我自己來。	null	その　しごとは　じぶんで　やります。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[101]	\N	\N	1
1684	庭の花		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[102]	\N	\N	1
1685	田中さんの本		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[103]	\N	\N	1
1686	雨の降る日		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[104]	\N	\N	1
1687	鈴木さんの言ったこと		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[105]	\N	\N	1
1688	田中さんの来たとき		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[106]	\N	\N	1
1689	佐藤さんは鈴木さんと学校に行きました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[107]	\N	\N	1
1690	田中さんは山田さんと結婚しました。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[108]	\N	\N	1
1691	田中さんはお父さんと似ています。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[109]	\N	\N	1
1692	あの　かばんは　わたしの　かばんと　同じです。　	那個包包跟我的包包一樣。	null	あの　かばんは　わたしの　かばんと　おなじです。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[110]	\N	\N	1
1693	この　ノートは　わたしの　ノートと　違います。	這本筆記跟我的不一樣。	null	この　のーとは　わたしの　のーとと　ちがいます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[111]	\N	\N	1
1694	朝　起きた　ときには　「おはよう　ございます」と　言います。	早上起床時要說「早安」。	null	あさ　おきた　ときには　「おはよう　ございます」と　いいます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[112]	\N	\N	1
1695	毎日ジョギングをする人はえらいと思います。		null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[113]	\N	\N	1
1696	この　漢字は　「やま」と　読みます。	這個漢字唸「やま」。	null	この　かんじは　「やま」と　よみます。	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[114]	\N	\N	1
1697	これをください。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1698	はい。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1699	ハンバーガーとサラダをお願いします。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1700	はい。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1701	書類の　コピーを　ください。	しょるいの　こぴーを　ください。	null	しょるいの　こぴーを　ください。	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1702	すみません、水をくださいませんか。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1703	はい。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1704	あのう、　この　町の　地図を　くださいませんか。	あのう、　この　まちの　ちずを　くださいませんか。	null	あのう、　この　まちの　ちずを　くださいませんか。	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1705	はい、どうぞ。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1706	りんご、ください。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1707	ハンバーグ、ください。		null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1708	赤い　ばらを　８本　ください。	あかい　ばらを　はちほん　ください。	null	あかい　ばらを　はちほん　ください。	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1709	はい。1200円です。		null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1782	いっしょに帰りませんか。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1710	コーラを　二つ　お願いします。	請給我兩杯可樂。	null	こーらを　ふたつ　おねがいします。	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1711	かしこまりました。		null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1712	教科書の　15ページを　見て　ください。	きょうかしょの　１５ぺーじを　みて　ください。	null	きょうかしょの　１５ぺーじを　みて　ください。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1713	テープの　会話を　聞いて　ください。	てーぷの　かいわを　きいて　ください。	null	てーぷの　かいわを　きいて　ください。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1714	名前を　書いて　ください。 	請寫下名字。	null	なまえを　かいて　ください。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1715	はい、　わかりました。	好，我知道了。	null	はい、　わかりました。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1716	３年生は　手を　あげて　ください。	さんねんせいは　てを　あげて　ください。	null	さんねんせいは　てを　あげて　ください。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1717	２年生は、あした８時に学校へ来てください。		null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1718	どうかゆるしてください。		null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1719	わたしを助けてください。		null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1720	ちょっと　待って　ください。	請等一下。	null	ちょっと　まって　ください。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1721	あした　電話を　して　ください。	明天請打電話給我。	null	あした　でんわを　して　ください。	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1722	がんばってください。		null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1723	安心してください。		null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1724	ぜひ来てください。		null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1725	もう一度説明してくださいませんか。		null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1726	すみません、　窓を　開けて　くださいませんか。	すみません、　まどを　あけて　くださいませんか。	null	すみません、　まどを　あけて　くださいませんか。	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1727	ええ、　いいですよ。	好啊，沒問題。	null	ええ、　いいですよ。	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1728	この　部屋で　お弁当を　食べても　いいです。	在這個房間吃便當也可以。	null	この　へやで　おべんとうを　たべても　いいです。	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1729	この　コピー機は　学生が　使っても　いいですよ。	この　こぴーきは　がくせいが　つかっても　いいですよ。	null	この　こぴーきは　がくせいが　つかっても　いいですよ。	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1730	これを借りてもいいですか。		null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1731	はい、どうぞ。		null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1732	この　辞書を　借りても　いいですか。	この　じしょを　かりても　いいですか。	null	この　じしょを　かりても　いいですか。	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1733	すみません。今使っています。		null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1734	外に　出ても　いいですか。	可以去外面嗎？	null	そとに　でても　いいですか。	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1735	いいえ。		null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1736	辞書を　見ても　いいですか。　	じしょを　みても　いいですか。	null	じしょを　みても　いいですか。	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1737	いいえ、いけません。		null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1738	病院で　携帯電話を　使っては　いけません。	在醫院不可以使用行動電話。	null	びょういんで　けいたいでんわを　つかっては　いけません。	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1739	この　部屋で　たばこを　すっては　いけません。	この　へやで　たばこを　すっては　いけません。	null	この　へやで　たばこを　すっては　いけません。	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1740	しばらく　お酒を　飲んでは　だめです。	しばらく　おさけを　のんでは　だめです。	null	しばらく　おさけを　のんでは　だめです。	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1741	この教室は使っちゃいけませんよ。		null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1742	泣いちゃだめですよ。		null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1743	木村さん、その本を借りてはいけませんか。		null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1783	ええ、帰りましょう。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1744	ここでは　たばこを　すわないで　ください。	ここでは　たばこを　すわないで　ください。	null	ここでは　たばこを　すわないで　ください。	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1745	きょうは　おふろに　入らないで　ください。	今天請不要洗澡。	null	きょうは　おふろに　はいらないで　ください。	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1746	宿題を忘れないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1747	はい、わかりました。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1748	コンピューターを　使って　います。　スイッチを　切らないで　ください。	我正在用電腦，請不要把電源關掉。	null	こんぴゅーたーを　つかって　います。　すいっちを　きらないで　ください。	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1749	どうかおこらないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1750	わたしを殺さないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1751	不合格にしないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1752	だいじょうぶです。心配しないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1753	あまり無理をしないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1754	気にしないでください。		null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1755	どうぞ　遠慮しないで　ください。	どうぞ　えんりょしないで　ください。	null	どうぞ　えんりょしないで　ください。	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1756	ペンでもいいですか。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1757	B1：はい、いいです。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1758	B2：いいえ、だめです。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1759	レポートはあしたでもいいですか。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1760	B1：はい、あしたでもいいです。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1761	B2：いいえ、あしたではだめです。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1762	パーティーは、ジーンズではいけません。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1763	この試験は、えんぴつではだめです。		null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1764	いっしょに帰りませんか。		null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1765	はい。		null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1766	スケートに行きませんか。		null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1767	いいですね。		null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1768	土曜日の　午後、　テニスを　しませんか。	星期六下午要不要去打網球？	null	どようびの　ごご、　てにすを　しませんか。	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1769	すみません。　土曜日は　仕事が　あります。	すみません。　どようびは　しごとが　あります。	null	すみません。　どようびは　しごとが　あります。	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1770	あした、映画を見に行きませんか。		null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1771	いっしょに昼ごはんを食べませんか。		null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1772	少し　休みませんか。	すこし　やすみませんか。	null	すこし　やすみませんか。	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1773	いっしょに帰りましょう。		null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1774	はい。		null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1775	信号が　青に　なりました。　さあ、　渡りましょう。	しんごうが　あおに　なりました。　さあ、　わたりましょう。	null	しんごうが　あおに　なりました。　さあ、　わたりましょう。	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1776	いっしょに昼ごはんを食べませんか。		null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1777	はい、食べましょう。		null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1778	プールへ　行きませんか。	要不要去游泳池？	null	ぷーるへ　いきませんか。	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1779	いいですね。行きましょう。		null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1780	食事の　前には　手を　洗いましょう。	しょくじの　まえには　てを　あらいましょう。	null	しょくじの　まえには　てを　あらいましょう。	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1781	手を　あげて　横断歩道を　渡りましょう。	てを　あげて　おうだんほどうを　わたりましょう。	null	てを　あげて　おうだんほどうを　わたりましょう。	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1784	スケートに行きませんか。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1785	いいですね。行きましょう。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1786	土曜日の午後、テニスをしませんか。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1787	土曜日ですか。土曜日はちょっと。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1788	あした、　うちへ　遊びに　来ませんか。	あした、　うちへ　あそびに　きませんか。	null	あした、　うちへ　あそびに　きませんか。	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1789	ありがとう　ございます。　でも、　あしたは　ちょっと。	ありがとう　ございます。　でも、　あしたは　ちょっと。	null	ありがとう　ございます。　でも、　あしたは　ちょっと。	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1790	映画を見に行きませんか。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1791	すみません。アルバイトがあります。		null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1792	きょうから日記を書こう。		null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1793	きょうは　食堂で　昼食を　食べよう。	きょうは　しょくどうで　ちゅうしょくを　たべよう。	null	きょうは　しょくどうで　ちゅうしょくを　たべよう。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1794	その　荷物は　わたしが　持ちましょう。	那個行李我來拿吧。	null	その　にもつは　わたしが　もちましょう。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1795	図書館でいっしょに勉強しましょう。		null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1796	あしたもう一度来よう。		null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1797	家に　帰ったら　掃除しよう。	いえに　かえったら　そうじしよう。	null	いえに　かえったら　そうじしよう。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1798	この　辺で　休みましょう。	この　へんで　やすみましょう。	null	この　へんで　やすみましょう。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1799	その　仕事は　わたしが　しましょう。	那個工作交給我吧。	null	その　しごとは　わたしが　しましょう。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1800	わたしは６時に帰ります。		null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1801	図書館で　勉強しようと　しましたが、　休みでした。	我想要去圖書館唸書，結果沒開。	null	としょかんで　べんきょうしようと　しましたが、　やすみでした。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1802	西の　空に　日が　沈もうと　して　います。	にしの　そらに　ひが　しずもうと　して　います。	null	にしの　そらに　ひが　しずもうと　して　います。	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1803	花が散ろうとしています。		null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1804	あしたは　早く　起きようと　思います。	あしたは　はやく　おきようと　おもいます。	null	あしたは　はやく　おきようと　おもいます。	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1805	夏休みに　旅行しようと　思って　います。	なつやすみに　りょこうしようと　おもって　います。	null	なつやすみに　りょこうしようと　おもって　います。	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1806	木村さんは留学しようと思っています。		null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1807	木村さんは留学しようと思いますか。		null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1808	きょうから　日記を　書こうと　思います。	きょうから　にっきを　かこうと　おもいます。	null	きょうから　にっきを　かこうと　おもいます。	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1809	きょうは　食堂で　昼食を　食べようと　思います。	きょうは　しょくどうで　ちゅうしょくを　たべようと　おもいます。	null	きょうは　しょくどうで　ちゅうしょくを　たべようと　おもいます。	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1810	家へ　帰ったら　掃除を　しようと　思います。	回到家的話我想打掃一下。	null	いえへ　かえったら　そうじを　しようと　おもいます。	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1811	妹は　日本語の　先生に　なろうと　思って　います。	妹妹想要當日語教師。	null	いもうとは　にほんごの　せんせいに　なろうと　おもって　います。	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1812	わたしは　今度の　休みに　友だちと　旅行したいです。	わたしは　こんどの　やすみに　ともだちと　りょこうしたいです。	null	わたしは　こんどの　やすみに　ともだちと　りょこうしたいです。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1813	今晩　どこへも　行きたくありません。	今晚我哪裡也不想去。	null	こんばん　どこへも　いきたくありません。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1814	将来、何になりたいですか。		null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1815	日本語の先生になりたいです。		null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1816	どんな　音楽を　聞きたいですか。	どんな　おんがくを　ききたいですか。	null	どんな　おんがくを　ききたいですか。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1817	日本の　音楽を　聞きたいです。	我想聽日本的音樂。	null	にほんの　おんがくを　ききたいです。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1818	水が　飲みたいです。	我想喝水。	null	みずが　のみたいです。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1819	何が食べたいですか。		null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1820	そうですね、サンドイッチが食べたいです。		null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1821	すみません、　山田先生と　話したいんですが。	すみません、　やまだせんせいと　はなしたいんですが。	null	すみません、　やまだせんせいと　はなしたいんですが。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1822	はい、　ちょっと　待って　ください。	はい、　ちょっと　まって　ください。	null	はい、　ちょっと　まって　ください。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1823	先生、お手洗いに行きたいんですが。		null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1824	はい、　いいですよ。	好，沒問題。	null	はい、　いいですよ。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1825	山田さんは　旅行したがって　います。	やまださんは　りょこうしたがって　います。	null	やまださんは　りょこうしたがって　います。	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1826	東京の　大学へ　行きたかったです。	當時我想去東京大學。	null	とうきょうの　だいがくへ　いきたかったです。	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1827	みんなの　前で　発表したく　ありませんでした。	みんなの　まえで　はっぴょうしたく　ありませんでした。	null	みんなの　まえで　はっぴょうしたく　ありませんでした。	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1828	駅まで　歩きたくなかったです。	えきまで　あるきたくなかったです。	null	えきまで　あるきたくなかったです。	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1829	きのうコンサートに行ってきました。		null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1830	そうですか。　それは　わたしも　行きたかったです。	そうですか。　それは　わたしも　いきたかったです。	null	そうですか。　それは　わたしも　いきたかったです。	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1831	わたしは　今　コンピューターが　ほしいです。	我現在想要一台電腦。	null	わたしは　いま　こんぴゅーたーが　ほしいです。	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1832	車がほしいですか。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1833	いいえ、｛ほしくありません／ほしくないです｝。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1834	誕生日に何がほしいですか。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1835	そうですね、　新しい　自転車が　ほしいです。	そうですね、　あたらしい　じてんしゃが　ほしいです。	null	そうですね、　あたらしい　じてんしゃが　ほしいです。	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1836	どれが　ほしいですか。	你想要哪一個？	null	どれが　ほしいですか。	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1837	これと　それが　ほしいです。	我想要這個和那個。	null	これと　それが　ほしいです。	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1838	わたしはコンピューターはほしくありません。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1839	わたしはコンピューターはほしくないです。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1840	太郎さんは犬がほしいですか。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1841	はい、ほしいです。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1842	太郎さんはコンピューターがほしいようです。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1843	すみません、　白い　紙が　ほしいんですが。	すみません、　しろい　かみが　ほしいんですが。	null	すみません、　しろい　かみが　ほしいんですが。	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1844	はい。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1845	あのう、　赤い　ボールペンが　ほしいんですが。	あのう、　あかい　ぼーるぺんが　ほしいんですが。	null	あのう、　あかい　ぼーるぺんが　ほしいんですが。	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1846	はい。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1847	太郎さんは新しいコンピューターをほしがっています。		null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1983	田中さんが合格した話		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
1848	わたしは　音楽が　すきです。	我喜歡音樂。	null	わたしは　おんがくが　すきです。	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1849	わたしは　スポーツが　すきでは　ありません。	我不喜歡運動。	null	わたしは　すぽーつが　すきでは　ありません。	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1850	田中さんはテニスがすきですか。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1851	はい、すきです。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1852	水泳はすきですか。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1853	いいえ、すきではありません。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1854	何がすきですか。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1855	りんごがすきです。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1856	どの科目がすきですか。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1857	数学がすきです。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1858	わたしは　犬が　きらいです。	わたしは　いぬが　きらいです。	null	わたしは　いぬが　きらいです。	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1859	わたしは犬がきらいではありません。		null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1860	すきな　食べ物は　何ですか。	你喜歡吃的東西是什麼？	null	すきな　たべものは　なんですか。	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1861	わたしは犬がこわいです。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1862	わたしは　授業が　楽しいです。	我很喜歡上課。	null	わたしは　じゅぎょうが　たのしいです。	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1863	わたしは試験の結果が心配です。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1864	わたしはつらいです。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1865	わたしは仕事がつらいです。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1866	あなたは　地震が　こわいですか。	あなたは　じしんが　こわいですか。	null	あなたは　じしんが　こわいですか。	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1867	K先生がこわいです。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1868	田中くんは犬がこわいそうです。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1869	田中くんは犬がこわいらしいです。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1870	田中くんは犬がこわかった。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1871	田中くんは　いつも　犬を　こわがります。	たなかくんは　いつも　いぬを　こわがります。	null	たなかくんは　いつも　いぬを　こわがります。	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1872	田中くんは犬をこわがっています。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1873	うれしい。		null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1874	２年生は５時から体育館を使うことができます。		null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1875	きょうは、バスケットボールの練習をすることができません。		null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1876	中山さんは　200メートル　泳ぐ　ことが　できます。	なかやまさんは　にひゃくめーとる　およぐ　ことが　できます。	null	なかやまさんは　にひゃくめーとる　およぐ　ことが　できます。	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1877	わたしは漢字を50書くことができます。		null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1878	中山さんは　アラビア語を　話す　ことが　できますか。	なかやまさんは　あらびあごを　はなす　ことが　できますか。	null	なかやまさんは　あらびあごを　はなす　ことが　できますか。	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1879	いいえ、　できません。	不，我不行。	null	いいえ、　できません。	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1880	キムさんは　日本語が　できます。 	きむさんは　にほんごが　できます。	null	きむさんは　にほんごが　できます。	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1881	田中さんは　テニスが　できます。	田中會打網球。	null	たなかさんは　てにすが　できます。	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1882	わたしは車の運転ができません。		null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1883	あの　電話で　外国に　電話が　できますか。	那隻電話可以打到國外嗎？	null	あの　でんわで　がいこくに　でんわが　できますか。	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1884	はい、できます。		null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1984	人が勉強しているとなりでおしゃべりをする。		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
1885	わたしは　漢字が　書けます。	我會寫漢字。	null	わたしは　かんじが　かけます。	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1886	わたしはさしみが食べられます。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1887	あした学校に来られます。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1888	水泳ができます。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1889	パーティーに来られますか。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1890	B1：はい、行けます。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1891	B2：いいえ、行けません。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1892	図書館で勉強できます。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1893	彼を一生愛せますか。		null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1894	あしたは　晴れるでしょう。	あしたは　はれるでしょう。	null	あしたは　はれるでしょう。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1895	きょうの試合では、Aチームが勝つでしょう。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1896	この　問題は、　あしたの　試験に　出るでしょうか。	この　もんだいは、　あしたの　しけんに　でるでしょうか。	null	この　もんだいは、　あしたの　しけんに　でるでしょうか。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1897	たぶん　出るでしょう。	たぶん　でるでしょう。	null	たぶん　でるでしょう。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1898	きのう、外語大のチームは勝ちましたか。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1899	わかりません。　でも、　たぶん　勝ったでしょう。	わかりません。　でも、　たぶん　かったでしょう。	null	わかりません。　でも、　たぶん　かったでしょう。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1900	あそこに　人が　いますね。　あの　人は　だれでしょう。	那邊有個人耶。那個人是誰呢？	null	あそこに　ひとが　いますね。　あの　ひとは　だれでしょう。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1901	たぶん　田中さんでしょう。	たぶん　たなかさんでしょう。	null	たぶん　たなかさんでしょう。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1902	田中さんは来ますか。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1903	たぶん　来ないでしょう。	たぶん　こないでしょう。	null	たぶん　こないでしょう。	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1904	客：これはいくらでしょうか。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1905	店員：それは1000円です。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1906	あしたは雨が降るだろう。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1907	田中さんは来ないだろう。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1908	Aチームが勝っただろう。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1909	あしたは日曜日でしょう？		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1910	これは田中さんのでしょう？		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1911	わたしがさっき言ったでしょう。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1912	ほら、あそこにコンビニがあるでしょう。		null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1913	山田さんは　図書館に　いるかも　しれません。	やまださんは　としょかんに　いるかも　しれません。	null	やまださんは　としょかんに　いるかも　しれません。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1914	今ごろの　東京は　寒いかも　しれません。	いまごろの　とうきょうは　さむいかも　しれません。	null	いまごろの　とうきょうは　さむいかも　しれません。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1915	山田さんは　猫が　きらいかも　しれません。	やまださんは　ねこが　きらいかも　しれません。	null	やまださんは　ねこが　きらいかも　しれません。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1916	今ごろは、山田さんはひまにちがいありません。 		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1917	あれは、　田村さんに　ちがい　ありません。	あれは、　たむらさんに　ちがい　ありません。	null	あれは、　たむらさんに　ちがい　ありません。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1918	あの人はもしかすると木村さんのお兄さんかもしれません。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1919	この　時計は　きっと　高いに　ちがいありません。	這個時鐘一定很貴。	null	この　とけいは　きっと　たかいに　ちがいありません。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1920	妹が帰ってきません。もしかしたら事故にあったのかもしれません。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1921	今　十時ですから、　郵便局は　開いて　いる　はずです。	現在十點了，郵局應該開了。	null	いま　じゅうじですから、　ゆうびんきょくは　あいて　いる　はずです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1922	木村さんは　英語教師ですから、　英語が　話せる　はずです。	きむらさんは　えいごきょうしですから、　えいごが　はなせる　はずです。	null	きむらさんは　えいごきょうしですから、　えいごが　はなせる　はずです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1923	木村さんは英語教師ですから英語が話せる｛○はずなのに／×にちがいないのに｝、日常会話さえできません。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1924	木村さんは　英語教師です。	きむらさんは　えいごきょうしです。	null	きむらさんは　えいごきょうしです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1925	そうですか、どうりで英語が話せる｛○はずです／×にちがいないです｝ね。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1926	あの犬の様子を見て、病気｛○にちがいない／×のはずだ｝と思いました。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1927	このデータから考えると、留学生はこれからも増え続ける｛○はずです／？にちがいありません｝。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1928	この　家は　だれか　住んで　いそうです。	這房子看起來好像有人住。	null	この　いえは　だれか　すんで　いそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1929	この　おかしは　甘そうです。	この　おかしは　あまそうです。	null	この　おかしは　あまそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1930	この　電子辞書は　便利そうです。	この　でんしじしょは　べんりそうです。	null	この　でんしじしょは　べんりそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1931	雨が　降りそうです。	好像要下雨了。	null	あめが　ふりそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1932	わたしは　きょう　早く　学校に　行けそうです。	わたしは　きょう　はやく　がっこうに　いけそうです。	null	わたしは　きょう　はやく　がっこうに　いけそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
1933	ここに　おいしそうな　おかしが　あります。	ここに　おいしそうな　おかしが　あります。	null	ここに　おいしそうな　おかしが　あります。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
1934	木村さんは　うれしそうに　走って　きました。	きむらさんは　うれしそうに　はしって　きました。	null	きむらさんは　うれしそうに　はしって　きました。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
1935	庭に　車が　ありません。　母は　出かけて　いるようです。	車子不在院子裡。媽媽好像出門了。	null	にわに　くるまが　ありません。　ははは　でかけて　いるようです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
1936	この　絵は　まるで　写真のようです。	この　えは　まるで　しゃしんのようです。	null	この　えは　まるで　しゃしんのようです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
1937	小林さんは　鳥のような　声で　歌います。	こばやしさんは　とりのような　こえで　うたいます。	null	こばやしさんは　とりのような　こえで　うたいます。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[25]	\N	\N	1
1938	このロボットは、生きているように動きます。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[26]	\N	\N	1
1939	あの人は歌手のようです。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[27]	\N	\N	1
1940	あの人はどうやら歌手のようです。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[28]	\N	\N	1
1941	あの人はまるで歌手のようです。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[29]	\N	\N	1
1942	来月から　新しい　生徒が　来るそうです。	聽說下個月有個新學生要來。	null	らいげつから　あたらしい　せいとが　くるそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[30]	\N	\N	1
1943	天気予報に　よると、　あしたは　雨が　降るそうです。	てんきよほうに　よると、　あしたは　あめが　ふるそうです。	null	てんきよほうに　よると、　あしたは　あめが　ふるそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[31]	\N	\N	1
1944	木村さんが　電話に　出ない。　出かけて　いるらしい。	きむらさんが　でんわに　でない。　でかけて　いるらしい。	null	きむらさんが　でんわに　でない。　でかけて　いるらしい。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[32]	\N	\N	1
1945	山田さんは　来月　東京に　行くらしいです。	やまださんは　らいげつ　とうきょうに　いくらしいです。	null	やまださんは　らいげつ　とうきょうに　いくらしいです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[33]	\N	\N	1
1946	骨を折った｛×らしいです／○ようです｝。レントゲンを撮りましょう。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[34]	\N	\N	1
1947	先生から　聞きましたが、　来月から　新しい　生徒が　来るそうです。	從老師那邊聽說，下個月開始有新同學要來。	null	せんせいから　ききましたが、　らいげつから　あたらしい　せいとが　くるそうです。	\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[35]	\N	\N	1
1948	うわさによると、山田さんは来月東京に行くらしいです。		null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[36]	\N	\N	1
1949	歌舞伎は　おもしろいと　思います。	かぶきは　おもしろいと　おもいます。	null	かぶきは　おもしろいと　おもいます。	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1950	わたしはあした雨が降ると思います。		null		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1951	田中さんは　もう　帰ったと　思います。	たなかさんは　もう　かえったと　おもいます。	null	たなかさんは　もう　かえったと　おもいます。	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1952	あしたも寒いと思いますか。		null		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1953	ええ、　たぶん。	ええ、　たぶん。	null	ええ、　たぶん。	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1954	彼は　スポーツが　得意だと　思います。	かれは　すぽーつが　とくいだと　おもいます。	null	かれは　すぽーつが　とくいだと　おもいます。	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1955	彼は　スポーツが　得意ではないと　思います。	かれは　すぽーつが　とくいではないと　おもいます。	null	かれは　すぽーつが　とくいではないと　おもいます。	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1956	彼は　スポーツが　得意だと　思いません。	かれは　すぽーつが　とくいだと　おもいません。	null	かれは　すぽーつが　とくいだと　おもいません。	\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1957	わたしのペン		null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1958	体育館のとなり		null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1959	新しいコンピューター		null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1960	小さい犬		null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1961	元気な人		null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1962	すてきな絵		null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1963	あしたの授業で使う本		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1964	あれは　わたしが　通った　学校です。	あれは　わたしが　かよった　がっこうです。	null	あれは　わたしが　かよった　がっこうです。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1965	この　作文を　書いた　人は　誰ですか。　名前が　ありません。	寫這篇作文的人是誰？上面沒有名字。	null	この　さくぶんを　かいた　ひとは　だれですか。　なまえが　ありません。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1966	すみません、わたしです。		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1967	母が　作る　料理は　とても　おいしいです。	媽媽做的菜很好吃。	null	ははが　つくる　りょうりは　とても　おいしいです。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1968	○×△美術館へ行ったことがない人は、手をあげてください。		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1969	（手をあげて）はい。		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1970	わたしは、ビートルズが作った曲がすきです。		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1971	答えを　書いた　紙を　出して　ください。	請把寫了答案的紙交出來。	null	こたえを　かいた　かみを　だして　ください。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1972	先月　卒業パーティーを　した　レストランは、　ここです。	せんげつ　そつぎょうぱーてぃーを　した　れすとらんは、　ここです。	null	せんげつ　そつぎょうぱーてぃーを　した　れすとらんは、　ここです。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1973	きのう　書いた　作文を　きょう　提出しました。	きのう　かいた　さくぶんを　きょう　ていしゅつ　しました。	null	きのう　かいた　さくぶんを　きょう　ていしゅつ　しました。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1974	図書館で　勉強して　いる　田中さんを　見ました。	我看到在圖書館唸書的田中。	null	としょかんで　べんきょうして　いる　たなかさんを　みました。	\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1975	きのうわたしが行った店		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1976	お父さんが病院に勤めている山本さん		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1977	コーヒーは飲んで、紅茶は飲まない人		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
1978	赤いセーターを着た先生		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
1979	こわれたコンピューター		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1980	本を読んでいる人		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
1981	授業で使う本		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
1982	わたしが通う学校		null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
1987	［外国語を勉強する{こと／の}］は楽しいです。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1988	［学生が優秀な{こと／の}］が田中先生の自慢です。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1989	［山田さんが合格した{こと／の}］をきょう知りました。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1990	田中さんが　走って　いるのを　見ました。	我看到田中在跑。	null	たなかさんが　はしって　いるのを　みました。	\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1991	山田さんが　本を　読んで　いるのが　聞こえます。	やまださんが　ほんを　よんで　いるのが　きこえます。	null	やまださんが　ほんを　よんで　いるのが　きこえます。	\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1992	木村さんが　来るのを　待ちます。	きむらさんが　くるのを　まちます。	null	きむらさんが　くるのを　まちます。	\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1993	ケーキを　食べたのは　山田さんです。	吃了蛋糕的是山田。	null	けーきを　たべたのは　やまださんです。	\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1994	きのう行ったのは京都です。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1995	大学に進学することを勧めます。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1996	わたしはアメリカに留学することを考えています。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1997	大きいのを１つください。		null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1998	お母さんが　買ってきたのを　食べました。	おかあさんが　かってきたのを　たべました。	null	おかあさんが　かってきたのを　たべました。	\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1999	雨が降ったので試合が中止になりました。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2000	もう　遅いので、　これで　帰ります。	もう　おそいので、　これで　かえります。	null	もう　おそいので、　これで　かえります。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2001	この　カメラが　便利なので、　これに　しませんか。	この　かめらが　べんりなので、　これに　しませんか。	null	この　かめらが　べんりなので、　これに　しませんか。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2002	あしたが提出日ですので、気をつけてください。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2003	きのうは　祭日でしたから、　学校は　休みでした。	きのうは　さいじつでしたから、　がっこうは　やすみでした。	null	きのうは　さいじつでしたから、　がっこうは　やすみでした。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2004	くすりを　飲みましたから、　もう　だいじょうぶです。	藥我吃了，所以已經沒關係了。	null	くすりを　のみましたから、　もう　だいじょうぶです。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2005	あしたは　授業が　ないから、　学校へ　行きません。	明天沒課所以我不去學校。	null	あしたは　じゅぎょうが　ないから、　がっこうへ　いきません。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2006	もうだいじょうぶですから、心配しないでください。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2007	どうして　わたしの　電話番号が　わかったのですか。	你為什麼會知道我的電話號碼？	null	どうして　わたしの　でんわばんごうが　わかったのですか。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2008	小林さんに聞きました。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2009	田中さんもあした来ますか。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2010	いいえ、来ません。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2011	どうしてですか。	為什麼？	null	どうしてですか。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2012	病気だからです。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2013	どうして　「蛍の光」が　流れて　いるのですか。	どうして　「ほたるのひかり」が　ながれて　いるのですか。	null	どうして　「ほたるのひかり」が　ながれて　いるのですか。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2014	図書館が　閉まるからです。	としょかんが　しまるからです。	null	としょかんが　しまるからです。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2015	雨が降って試合が中止になりました。		null		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
2016	かぜで　休みました。	かぜで　やすみました。	null	かぜで　やすみました。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
2017	どうして　授業を　休んだのですか。	為什麼沒有來上課呢？	null	どうして　じゅぎょうを　やすんだのですか。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
2018	熱が　あって、　起きられませんでした。	因為發燒所以起不了床。	null	ねつが　あって、　おきられませんでした。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
2019	きょうは　先生が　病気で、　授業が　休みに　なりました。	今天老師生病，不用上課。	null	きょうは　せんせいが　びょうきで、　じゅぎょうが　やすみに　なりました。	\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
2020	一生懸命勉強したのに試験に落ちました。		null		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2021	この　メロンは　大きいのに　安いです。	この　めろんは　おおきいのに　やすいです。	null	この　めろんは　おおきいのに　やすいです。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2022	毎日　日本語を　勉強して　いるけれども、　なかなか　漢字が　覚えられません。	まいにち　にほんごを　べんきょうして　いるけれども、　なかなか　かんじが　おぼえられません。	null	まいにち　にほんごを　べんきょうして　いるけれども、　なかなか　かんじが　おぼえられません。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2023	山田さんは　いつも　元気ですけれども、　きょうは　静かです。	山田平常總是很有精神，可是今天卻很安靜。	null	やまださんは　いつも　げんきですけれども、　きょうは　しずかです。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2024	きょうは　日曜日なのに　仕事が　あります。	今天是星期天，可是卻有工作要做。	null	きょうは　にちようびなのに　しごとが　あります。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2025	さっき　食べたのに　もう　おなかが　すきました。	さっき　たべたのに　もう　おなかが　すきました。	null	さっき　たべたのに　もう　おなかが　すきました。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2026	雨が降ったけれども予定通り運動会をしました。		null		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2027	もう　夜の　12時だけれども、　もう　少し　勉強しよう。	もう　よるの　じゅうにじだけれども、　もう　すこし　べんきょうしよう。	null	もう　よるの　じゅうにじだけれども、　もう　すこし　べんきょうしよう。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2028	小林さんは　かぜを　ひいて　いるけれども、　学校に　来て　いるかも　しれません。	こばやしさんは　かぜを　ひいて　いるけれども、　がっこうに　きて　いるかも　しれません。	null	こばやしさんは　かぜを　ひいて　いるけれども、　がっこうに　きて　いるかも　しれません。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2029	日曜日　だけれども、　学校に　行きますか。	にちようび　だけれども、　がっこうに　いきますか。	null	にちようび　だけれども、　がっこうに　いきますか。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2030	わたしは　東京に　住んで　いるけれども、　弟は　京都に　住んで　います。	雖然我住在東京，不過弟弟住在京都。	null	わたしは　とうきょうに　すんで　いるけれども、　おとうとは　きょうとに　すんで　います。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2031	わたしが　話して　いるのに、　じゃまを　しないで　ください。	わたしが　はなして　いるのに、　じゃまを　しないで　ください。	null	わたしが　はなして　いるのに、　じゃまを　しないで　ください。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2032	鈴木さんから電話ですよ。		null		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2033	えっ、もう夜の11時なのに。		null		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2034	レポートの　ことですけれども、　来週の　月曜日に　提出して　ください。	れぽーとの　ことですけれども、　らいしゅうの　げつようびに　ていしゅつして　ください。	null	れぽーとの　ことですけれども、　らいしゅうの　げつようびに　ていしゅつして　ください。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2035	日本中を　旅行しましたけれども、　京都が　一番　すきです。	にほんじゅうを　りょこうしましたけれども、　きょうとが　いちばん　すきです。	null	にほんじゅうを　りょこうしましたけれども、　きょうとが　いちばん　すきです。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2036	すみませんが、　郵便局は　この　辺ですか。	すみませんが、　ゆうびんきょくは　この　へんですか。	null	すみませんが、　ゆうびんきょくは　この　へんですか。	\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
2037	すみません、パソコンが動かないのですけれども。		null		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
2038	雨が　降ると、　雪が　解けます。	あめが　ふると、　ゆきが　とけます。	null	あめが　ふると、　ゆきが　とけます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2039	卒業論文を　出せば、　卒業できます。	そつぎょうろんぶんを　だせば、　そつぎょうできます。	null	そつぎょうろんぶんを　だせば、　そつぎょうできます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2040	あした雨が降ったら、試合は中止します。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2041	あの　大学へ　行くなら、　自転車が　便利です。	要去那所大學的話，騎腳踏車去比較方便。	null	あの　だいがくへ　いくなら、　じてんしゃが　べんりです。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2225	山田先生はやさしいです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
2042	父は　毎朝　起きると、　新聞を　読みます。	爸爸每天早上起床後都會看報紙。	null	ちちは　まいあさ　おきると、　しんぶんを　よみます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2043	この　ボタンを　押すと、　ドアが　開きます。	按這個按鈕門就會打開。	null	この　ぼたんを　おすと、　どあが　あきます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2044	成績が　悪いと　進学できません。	せいせきが　わるいと　しんがくできません。	null	せいせきが　わるいと　しんがくできません。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2045	部屋が　静かだと　よく　勉強できます。	へやが　しずかだと　よく　べんきょうできます。	null	へやが　しずかだと　よく　べんきょうできます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2046	成績が60点以上だと合格です。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2047	安ければ、　買います。	便宜的話我就買。	null	やすければ、　かいます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2048	ちりも　つもれば　山と　なる。	ちりも　つもれば　やまと　なる。	null	ちりも　つもれば　やまと　なる。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2049	あした雨が降れば、運動会は中止です。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2050	暑かったら、　エアコンを　つけて　ください。	あつかったら、　えあこんを　つけて　ください。	null	あつかったら、　えあこんを　つけて　ください。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2051	あした　晴れだったら、　ドライブに　行きましょう。	あした　はれだったら、　どらいぶに　いきましょう。	null	あした　はれだったら、　どらいぶに　いきましょう。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2052	ひまだったら、遊びに来ませんか。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2053	部屋で｛勉強していると／勉強していたら｝、太郎が来ました。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2054	木村さんに手紙を｛出すと／出したら｝、すぐに返事がきました。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
2055	近いなら　歩きましょう。	因為很近用走的去吧。	null	ちかいなら　あるきましょう。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
2056	嫌なら　やめても　いいですよ。	不喜歡的話不做也沒關係喔。	null	いやなら　やめても　いいですよ。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
2057	大学生ならこのくらいはできるはずです。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
2058	家に　パソコンが　あります。	いえに　ぱそこんが　あります。	null	いえに　ぱそこんが　あります。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
2059	パソコンがあるなら、インターネットができますね。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
2060	車を　買うと、　お金が　なくなります。	買車的話錢就沒了。	null	くるまを　かうと、　おかねが　なくなります。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
2061	車を　買えば、　どこでも　行けます。	買車的話，不管哪裡都可以去。	null	くるまを　かえば、　どこでも　いけます。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
2062	車を　買ったら、　ドライブを　しよう。	くるまを　かったら、　どらいぶを　しよう。	null	くるまを　かったら、　どらいぶを　しよう。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[25]	\N	\N	1
2063	学校に｛行くと／行ったら｝、新入生がたくさんいました。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[26]	\N	\N	1
2064	どうすれば、　漢字を　覚える　ことが　できますか。	要怎麼樣才能把漢字記住呢？	null	どうすれば、　かんじを　おぼえる　ことが　できますか。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[27]	\N	\N	1
2065	毎日、　新聞を　読めば、　覚える　ことが　できますよ。	每天看報紙的話，就可以記住了喔。	null	まいにち、　しんぶんを　よめば　おぼえる　ことが　できますよ。	\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[28]	\N	\N	1
2066	お酒を｛飲むと／飲んだら｝、気分が悪くなります。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[29]	\N	\N	1
2067	教科書さえあれば、勉強できる。		null		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[30]	\N	\N	1
2068	雪が　降っても、　学校に　行きます。	就算下雪我也要去學校。	null	ゆきが　ふっても、　がっこうに　いきます。	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2069	寒くても、　泳ぎます。	就算冷我也要游泳。	null	さむくても、　およぎます。	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2070	嫌でも、　しかたが　ありません。	いやでも、　しかたが　ありません。	null	いやでも、　しかたが　ありません。	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2071	たとえ　雨でも、　自転車で　行きます。 	たとえ　あめでも、　じてんしゃで　いきます。	null	たとえ　あめでも、　じてんしゃで　いきます。	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2226	田中さんは社長です。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
2072	この　時計は、　落としても、　水に　ぬれても　こわれません。	この　とけいは、　おとしても、　みずに　ぬれても　こわれません。	null	この　とけいは、　おとしても、　みずに　ぬれても　こわれません。	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2073	だれが　選ばれても、　おどろきません。	だれが　えらばれても、　おどろきません。	null	だれが　えらばれても、　おどろきません。	\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2074	このバスに｛乗ると／乗っても｝学校に行けますし、あの電車に乗っても学校に行けます。		null		\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2075	わたしは木村さんにプレゼントをあげます。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2076	木村さんはわたしにプレゼントをくれます。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2077	わたしは木村さんにプレゼントをもらいます。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2078	妹は　山田さんに　おみやげを　あげました。　	いもうとは　やまださんに　おみやげを　あげました。	null	いもうとは　やまださんに　おみやげを　あげました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2079	山田さんは　妹に　本を　くれました。　	山田給了我妹妹一本書。	null	やまださんは　いもうとに　ほんを　くれました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2080	木村さんは山田さんにおみやげをあげました。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2081	妹は山田さんに本をもらいました。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2082	山田さんは木村さんにおみやげをもらいました。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2083	わたしは田中先生に花をさしあげました。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2084	田中先生は　わたしに　手紙を　くださいました。	たなかせんせいは　わたしに　てがみを　くださいました。	null	たなかせんせいは　わたしに　てがみを　くださいました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2085	わたしは　田中先生に　手紙を　いただきました。	わたしは　たなかせんせいに　てがみを　いただきました。	null	わたしは　たなかせんせいに　てがみを　いただきました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2086	わたしは　父に　花を　あげました。	我給了爸爸一朵花。	null	わたしは　ちちに　はなを　あげました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2087	父は　わたしに　本を　くれました。	ちちは　わたしに　ほんを　くれました。	null	ちちは　わたしに　ほんを　くれました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2088	わたしは　父に　本を　もらいました。	我從爸爸那邊收到了一本書。	null	わたしは　ちちに　ほんを　もらいました。	\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2089	花に水をやります。		null		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2090	わたしは　小林さんに　ノートを　貸して　あげました。	我把筆記借給了小林。	null	わたしは　こばやしさんに　のーとを　かして　あげました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2091	小林さんはわたしに友だちを紹介してくれました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2092	木村さんに　本を　貸して　もらいました。	我從木村那邊借到書了。	null	きむらさんに　ほんを　かして　もらいました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2093	わたしは　弟に　お金を　貸して　あげました。	我借錢給弟弟了。	null	わたしは　おとうとに　おかねを　かして　あげました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2094	田中さんは　わたしに　パソコンの　使い方を　教えて　くれました。	たなかさんは　わたしに　ぱそこんの　つかいかたを　おしえて　くれました。	null	たなかさんは　わたしに　ぱそこんの　つかいかたを　おしえて　くれました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2095	わたしは　生徒を　ほめて　あげました。	わたしは　せいとを　ほめて　あげました。	null	わたしは　せいとを　ほめて　あげました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2096	山田さんは息子と遊んでくれました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2097	妹は　父に　お弁当を　作って　あげました。	妹妹做了便當給爸爸。	null	いもうとは　ちちに　おべんとうを　つくって　あげました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2098	母はわたしにてぶくろをあんでくれました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2099	わたしは　妹の　宿題を　見て　あげました。	我幫妹妹看了她的作業。	null	わたしは　いもうとの　しゅくだいを　みて　あげました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2100	木村さんは　わたしの　荷物を　運んで　くれました。	木村幫我搬了行李。	null	きむらさんは　わたしの　にもつを　はこんで　くれました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2366	がんばってください。			がんばってください。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2101	山田さんは　わたしの　ために　詩を　書いて　くれました。	やまださんは　わたしの　ために　しを　かいて　くれました。	null	やまださんは　わたしの　ために　しを　かいて　くれました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2102	わたしはかぜをひいた小林さんに代わってレポートを出してあげました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2103	小林さんに手伝ってもらいました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2104	母に　料理を　教えて　もらいました。	我叫媽媽教我怎麼做菜了。	null	ははに　りょうりを　おしえて　もらいました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2105	日本語は　木村さんに　教えて　もらおう。	にほんごは　きむらさんに　おしえて　もらおう。	null	にほんごは　きむらさんに　おしえて　もらおう。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2106	あした来てもらうよ。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
2107	レポートは　みなさんに　出して　もらう　ことに　します。	れぽーとは　みなさんに　だして　もらう　ことに　します。	null	れぽーとは　みなさんに　だして　もらう　ことに　します。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
2108	京都の友だちからおかしを送ってもらいました。　		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
2109	その知らせは田中さんから教えてもらいました。　		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
2110	京都からおかしを送ってもらいました。　		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
2111	田中先生に　ペンを　貸して　さしあげました。	たなかせんせいに　ぺんを　かして　さしあげました。	null	たなかせんせいに　ぺんを　かして　さしあげました。	\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
2112	鈴木先生はわたしに推薦状を書いてくださいました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
2113	わたしは鈴木先生に推薦状を書いていただきました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
2114	弟に弁当を作ってやりました。		null		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[25]	\N	\N	1
2115	駅まで　歩いて　いきます。	我要走路到車站。	null	えきまで　あるいて　いきます。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2116	これからも　日本語を　勉強して　いきます。	これからも　にほんごを　べんきょうして　いきます。	null	これからも　にほんごを　べんきょうして　いきます。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2117	おみやげを　持って　きました。	おみやげを　もって　きました。	null	おみやげを　もって　きました。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2118	高校の友だちがメールを送ってきました。		null		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2119	日本語を学ぶ人が増えてきました。		null		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2120	来週　そちらへ　行く　とき、　飲み物を　買って　いきます。　	下個星期去你那邊時，我會買飲料過去。	null	らいしゅう　そちらへ　いく　とき、　のみものを　かって　いきます。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2121	駅前の通りを歩いてきました。		null		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2122	授業まで　時間が　あるので、　朝の　ニュースを　見て　いきます。	じゅぎょうまで　じかんが　あるので、　あさの　にゅーすを　みて　いきます。	null	じゅぎょうまで　じかんが　あるので、　あさの　にゅーすを　みて　いきます。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2123	きょうは　友だちと　夕飯を　食べて　きました。	今天我去跟朋友吃晚餐了。	null	きょうは　ともだちと　ゆうはんを　たべて　きました。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2124	木村さんは　わたしに　古本を　売って　きました。　	きむらさんは　わたしに　ふるほんを　うって　きました。	null	きむらさんは　わたしに　ふるほんを　うって　きました。	\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2125	来週までにレポートを書いておきます。		null		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2126	発表の　ために　資料を　コピーして　おきました。	はっぴょうの　ために　しりょうを　こぴーして　おきました。	null	はっぴょうの　ために　しりょうを　こぴーして　おきました。	\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2127	友だちが　来るので、　部屋を　きれいに　して　おきます。	ともだちが　くるので、　へやを　きれいに　して　おきます。	null	ともだちが　くるので、　へやを　きれいに　して　おきます。	\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2128	あした木村さんに聞いてみます。		null		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2129	この　ジュースを　少し　飲んで　みて　ください。	この　じゅーすを　すこし　のんで　みて　ください。	null	この　じゅーすを　すこし　のんで　みて　ください。	\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2367	はい。			はい。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2130	すみません、　この　服を　着て　みても　いいですか。	對不起，我可以穿這件衣服嗎？	null	すみません、　この　ふくを　きて　みても　いいですか。	\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2131	いつか南極に行ってみたいです。		null		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2132	わたしは　この前　京都へ　行ったよ。	わたしは　このまえ　きょうとへ　いったよ。	null	わたしは　このまえ　きょうとへ　いったよ。	\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2133	わたしは先日京都へ行きました。		null		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2134	彼は大学の教授だ。言語学を教えている。		null		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2135	彼は大学の教授である。言語学を教えている。		null		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2136	彼は大学の教授です。言語学を教えています。		null		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2137	わたしは急ぐ。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2138	日本の冬は寒い。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2139	わたしは学生だ。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2140	わたしは学生である。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2141	この本はわたしのじゃない。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2142	わたしはきょうまでにレポートを終わらせとく。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2143	こうすりゃよかった。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2144	君、あした来るって言ったよね。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2145	たいしたもんだ。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2146	読んどいたよ、あの本。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2147	これ、プリント、先週の。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2148	ちょっと　待って。	ちょっと　まって。	null	ちょっと　まって。	\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2149	すごくおいしい。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2150	わたし、きのう、あれから映画見て、ごはん食べた。		null		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2151	わたしは急ぎます。		null		\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2152	日本の　冬は　寒いです。	にほんの　ふゆは　さむいです。	null	にほんの　ふゆは　さむいです。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2153	わたしは　学生です。	我是學生。	null	わたしは　がくせいです。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2154	きのう　見た　映画は　おもしろかったです。	昨天看的電影很有趣。	null	きのう　みた　えいがは　おもしろかったです。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2155	授業に毎回出席する。これがわたしの今年の目標です。		null		\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2156	わたしは　英語が　苦手なので　勉強します。	わたしは　えいごが　にがてなので　べんきょうします。	null	わたしは　えいごが　にがてなので　べんきょうします。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2157	星が　たくさん　出て　いますから　あしたは　晴れでしょう。	ほしが　たくさん　でて　いますから　あしたは　はれでしょう。	null	ほしが　たくさん　でて　いますから　あしたは　はれでしょう。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2158	わたしは　学生ですが、　兄は　会社員です。	我是學生，哥哥是上班族。	null	わたしは　がくせいですが、　あには　かいしゃいんです。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2159	以上で　発表は　終わりで　ございますが、　何か　ご質問は　ありますか。	いじょうで　はっぴょうは　おわりで　ございますが、　なにか　ごしつもんは　ありますか。	null	いじょうで　はっぴょうは　おわりで　ございますが、　なにか　ごしつもんは　ありますか。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2160	頼む。　金を　貸して　くれ。　お願いします。	たのむ。　かねを　かして　くれ。　おねがいします。	null	たのむ。　かねを　かして　くれ。　おねがいします。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2161	年が　明けました。　新しい　年の　始まりです。　今年は　どんな　年に　なるんだろう。	としが　あけました。　あたらしい　としの　はじまりです。　ことしは　どんな　としに　なるんだろう。	null	としが　あけました。　あたらしい　としの　はじまりです。　ことしは　どんな　としに　なるんだろう。	\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2162	山田さんはおそばを召し上がりました。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2296	山田さんは、眠くなったのか、目をこすっています。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[35]	\N	\N	1
2163	田中さんは　毎朝、　新聞を　お読みに　なります。	たなかさんは　まいあさ、　しんぶんを　およみに　なります。	null	たなかさんは　まいあさ、　しんぶんを　およみに　なります。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2164	中田先生がこの本を書かれました。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2165	あの　方は　東京駅で　降りられます。	あの　かたは　とうきょうえきで　おりられます。	null	あの　かたは　とうきょうえきで　おりられます。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2166	わたしはきのう渡辺社長のお宅を拝見しました。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2167	わたしが　かばんを　お持ちします。	わたしが　かばんを　おもちします。	null	わたしが　かばんを　おもちします。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2168	係員がご案内します。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2169	あちらは　山田様です。	あちらは　やまださまです。	null	あちらは　やまださまです。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2170	あなたの　お仕事は　何ですか。	你的工作是什麼？	null	あなたの　おしごとは　なんですか。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2171	ご家族は　どちらに　いらっしゃいますか。	ごかぞくは　どちらに　いらっしゃいますか。	null	ごかぞくは　どちらに　いらっしゃいますか。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2172	先生は来週もお忙しいようです。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2173	先生は来週もご多忙のようです。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2174	こちらから　お電話　さしあげます。	こちらから　おでんわ　さしあげます。	null	こちらから　おでんわ　さしあげます。	\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2175	先日試合で大阪に参りました。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2176	他社の社員：渡辺社長はいらっしゃいますか。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2177	渡辺の部下：渡辺はただいま外出しております。		null		\N	gmod	instances092.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2178	わたしが　晩ごはんを　食べて　いる　とき、　友だちが　うちへ　来ました。	我在吃晚飯的時候，朋友跑來我家。	null	わたしが　ばんごはんを　たべて　いる　とき、　ともだちが　うちへ　きました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2179	外国へ　行く　とき、　パスポートを　持って　行きます。	去國外時要帶護照去。	null	がいこくへ　いく　とき、　ぱすぽーとを　もって　いきます。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2180	日本へ　来る　とき、　空港で　写真を　撮りました。	來日本之前，我在機場拍了照。	null	にほんへ　くる　とき、　くうこうで　しゃしんを　とりました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2181	日本へ　来た　とき、　空港で　写真を　撮りました。	來到日本之後我在機場拍了照。	null	にほんへ　きた　とき、　くうこうで　しゃしんを　とりました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2182	お母さんは　若い　とき　看護士でした。	おかあさんは　わかい　とき　かんごしでした。	null	おかあさんは　わかい　とき　かんごしでした。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2183	桜の　花が　きれいな　とき、　リーさんは　日本へ　来ました。	さくらの　はなが　きれいな　とき、　りーさんは　にほんへ　きました。	null	さくらの　はなが　きれいな　とき、　りーさんは　にほんへ　きました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2184	高校生のとき、日本へ留学したことがあります。		null		\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2185	部屋を出るとき、携帯が鳴りました。		null		\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2186	部屋を出たとき、携帯が鳴りました。		null		\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2187	部屋に　いる　とき、　電話しました。	我在房間時打了電話。	null	へやに　いる　とき、　でんわ　しました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2188	部屋に　いた　とき、　電話しました。	へやに　いた　とき、　でんわしました。	null	へやに　いた　とき、　でんわしました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2189	若い　とき、　よく　泳ぎました。	我年輕的時候經常游泳。	null	わかい　とき、　よく　およぎました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2190	若かった　とき、　よく　泳ぎました。	わかかった　とき、　よく　およぎました。	null	わかかった　とき、　よく　およぎました。	\N	gmod	instances093.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2191	朝起きて顔を洗います。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2192	テレビを　見ながら　ごはんを　食べました。	一邊看電視一邊吃飯。	null	てれびを　みながら　ごはんを　たべました。	\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2368	失礼します。			しつれいします。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2193	学校で　勉強を　したり　運動を　したり　します。	がっこうで　べんきょうを　したり　うんどうを　したり　します。	null	がっこうで　べんきょうを　したり　うんどうを　したり　します。	\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2194	春になると暖かくなります。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2195	雨が降ったので運動会が中止になりました。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2196	雨が降ったから運動会が中止になりました。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2197	雨が降ったのに運動会がありました。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2198	雨が降ったけれども運動会がありました。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2199	雨が降れば運動会を中止します。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2200	雨が降ったら運動会を中止します。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2201	雨が降るなら運動会を中止します。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2202	雨が降っても運動会をします。		null		\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2203	象は　大きくて　鼻が　長いです。	ぞうは　おおきくて　はなが　ながいです。	null	ぞうは　おおきくて　はなが　ながいです。	\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2204	田中さんは、　知って　いながら　知らない　ふりを　しました。	たなかさんは、　しって　いながら　しらない　ふりを　しました。	null	たなかさんは、　しって　いながら　しらない　ふりを　しました。	\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2205	今年の　夏休みは、　海にも　行きましたし、　山にも　登りました。	今年暑假海邊我去了，山我也爬了。	null	ことしの　なつやすみは、　うみにも　いきましたし、　やまにも　のぼりました。	\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2206	暗い　所で　本を　読むと、　目が　悪く　なります。	在暗的地方看書眼睛會變差。	null	くらい　ところで　ほんを　よむと、　めが　わるく　なります。	\N	gmod	instances094.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2207	田中さんは　学生です。　佐藤さんも　学生です。	たなかさんは　がくせいです。　さとうさんも　がくせいです。	null	たなかさんは　がくせいです。　さとうさんも　がくせいです。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2208	佐藤さんだけ来ました。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2209	肉ばかり食べます。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2210	山田さんこそ会長にふさわしいです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2211	ジュースが　３本しか　ありません。	じゅーすが　さんぼんしか　ありません。	null	じゅーすが　さんぼんしか　ありません。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2212	机の上に本などがあります。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2213	お茶でも　飲みませんか。	要不要喝杯茶？	null	おちゃでも　のみませんか。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2214	佐藤さんや田中さんが来ました。山田さんまで来ました。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2215	佐藤さんや田中さんが来ました。山田さんさえ来ました。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2216	10人くらい　来ました。	大約來了10個人。	null	じゅうにんくらい　きました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2217	ここに　えんぴつが　あります。　赤い　鉛筆は　３本　あります。　青い　えんぴつは　３本　あります。	ここに　えんぴつが　あります。　あかい　えんぴつは　さんぼん　あります。　あおい　えんぴつは　さんぼん　あります。	null	ここに　えんぴつが　あります。　あかい　えんぴつは　さんぼん　あります。　あおい　えんぴつは　さんぼん　あります。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2218	Ａ：そこにかさとかばんがありますか。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2219	Ｂ：かさはありますが、かばんはありません。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2220	春は　来ましたが、　まだ　暖かく　なりません。	春天來了，可是還沒有變暖和。	null	はるは　きましたが、　まだ　あたたく　なりません。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2221	Ａ：宿題をしてきましたか。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2222	Ｂ：レポートは書きましたが、印刷はしていません。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
2223	山田さんはドイツ語はじょうずです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
2224	きょうの　会議に　20人は　集まりました。	今天的會議有20個人參加。	null	きょうの　かいぎに　にじゅうにんは　あつまりました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
2227	わたしは　きのう　大学へ　行きました。	我昨天去了大學。	null	わたしは　きのう　だいがくへ　いきました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
2228	朝ごはんは　もう　食べました。	あさごはんは　もう　たべました。	null	あさごはんは　もう　たべました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
2229	たばこは　やめました。	我戒菸了。	null	たばこは　やめました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
2230	暖かく　なりましたし、　桜も　咲きました。	あたたかく　なりましたし、　さくらも　さきました。	null	あたたかく　なりましたし、　さくらも　さきました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
2231	きょうの　コンサートには　100人も　来ました。	今天的演唱會來了100人。	null	きょうの　こんさーとには　ひゃくにんも　きました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[25]	\N	\N	1
2232	きょうは　誰も　来ませんでした。	今天誰也沒有來。	null	きょうは　だれも　きませんでした。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[26]	\N	\N	1
2233	時間も　来ました。　そろそろ　終わりに　しましょう。	じかんも　きました。　そろそろ　おわりに　しましょう。	null	じかんも　きました。　そろそろ　おわりに　しましょう。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[27]	\N	\N	1
2234	あなたも　よく　働きますね。	你也工作得真勤奮呀。	null	あなたも　よく　はたらきますね。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[29]	\N	\N	1
2235	あとは　寝るだけです。	あとは　ねるだけです。	null	あとは　ねるだけです。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[30]	\N	\N	1
2236	言うだけで　何も　しません。	いうだけで　なにも　しません。	null	いうだけで　なにも　しません。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[31]	\N	\N	1
2237	何を聞かれても泣くばかりです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[32]	\N	\N	1
2238	食べたいだけ食べました。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[33]	\N	\N	1
2239	日本語は　勉強しただけ　じょうずに　なります。	にほんごは　べんきょうしただけ　じょうずに　なります。	null	にほんごは　べんきょうしただけ　じょうずに　なります。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[34]	\N	\N	1
2240	すきなだけ持っていってください。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[35]	\N	\N	1
2241	全力を尽くしてこそいい結果がでます。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[36]	\N	\N	1
2242	ジュースしかありません。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[37]	\N	\N	1
2243	コアラはユーカリの葉しか食べません。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[38]	\N	\N	1
2244	辞書を　引いたり、　インターネットで　調べるなど　しました。	我查了字典還有網路等等。	null	じしょを　ひいたり、　いんたーねっとで　しらべるなど　しました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[39]	\N	\N	1
2245	小泉氏などの政治家にインタビューしました。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[40]	\N	\N	1
2246	試験中にとなりの人と話すなどのことはしてはいけません。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[41]	\N	\N	1
2247	お茶など　いかがですか。	來杯茶您覺得怎麼樣？	null	おちゃなど　いかがですか。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[42]	\N	\N	1
2248	つまらない　仕事などに　時間を　使いたくありません。	つまらない　しごとなどに　じかんを　つかいたく　ありません。	null	つまらない　しごとなどに　じかんを　つかいたく　ありません。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[43]	\N	\N	1
2249	ボールペンを　持って　こなかった　人は、　えんぴつでも　いいです。	沒有帶原子筆來的人，用鉛筆也可以。	null	ぼーるぺんを　もって　こなかった　ひとは、　えんぴつでも　いいです。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[44]	\N	\N	1
2250	それでもだいじょうぶです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[45]	\N	\N	1
2251	この　アルバイトは、　いそがしい　人でも　できます。	この　あるばいとは、　いそがしい　ひとでも　できます。	null	この　あるばいとは、　いそがしい　ひとでも　できます。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[46]	\N	\N	1
2252	そのくらいのことはわたしだってできます。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[47]	\N	\N	1
2253	日本語を　勉強して、　留学生試験に　合格する　までに　なりました。	にほんごを　べんきょうして、　りゅうがくせいしけんに　ごうかくする　までに　なりました。	null	にほんごを　べんきょうして、　りゅうがくせいしけんに　ごうかくする　までに　なりました。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[48]	\N	\N	1
2254	これさえあればだいじょうぶです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[49]	\N	\N	1
2255	山田さんさえいたら、この試合には勝てるのに。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[50]	\N	\N	1
2256	これくらいの大きさです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[51]	\N	\N	1
2365	それは、　大変ですね。	それは、　たいへんですね。		それは、　たいへんですね。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2257	５分ほど　まって　ください。	ごふんほど　まって　ください。	null	ごふんほど　まって　ください。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[52]	\N	\N	1
2258	そのくらいの　ことは　自分で　できます。	そのくらいの　ことは　じぶんで　できます。	null	そのくらいの　ことは　じぶんで　できます。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[53]	\N	\N	1
2259	山田さんくらい　頭の　いい　人は　いません。	やまださんくらい　あたまの　いい　ひとは　いません。	null	やまださんくらい　あたまの　いい　ひとは　いません。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[54]	\N	\N	1
2260	富士山は　エベレストほど　高くは　ありません。	ふじさんは　えべれすとほど　たかくは　ありません。	null	ふじさんは　えべれすとほど　たかくは　ありません。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[55]	\N	\N	1
2261	君にだけ話しましょう。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[56]	\N	\N	1
2262	太郎君とさえ話ができなかった。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[57]	\N	\N	1
2263	君だけに話しましょう。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[58]	\N	\N	1
2264	それくらいが　ちょうどいいです。	それくらいが　ちょうどいいです。	null	それくらいが　ちょうどいいです。	\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[59]	\N	\N	1
2265	言うのです。		null		\N	gmod	instances095.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[60]	\N	\N	1
2266	あしたは日曜日ですか。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2267	あしたは日曜日かしら。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2268	さわるな。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
2269	あしたは日曜日ですよ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
2270	わたしも　そう　思いますね。	わたしも　そう　おもいますね。	null	わたしも　そう　おもいますね。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
2271	ああ、　きれいだなあ。	ああ、　きれいだなあ。	null	ああ、　きれいだなあ。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
2272	さあ、　起きるか。	さあ、　おきるか。	null	さあ、　おきるか。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
2273	もう12時か。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
2274	あなたも　二十歳に　なりましたか。	あなたも　はたちに　なりましたか。	null	あなたも　はたちに　なりましたか。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
2275	だいじょうぶか。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
2276	本か。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
2277	熱いですか。	あついですか。	null	あついですか。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
2278	だいじょうぶですか。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
2279	これは本ですか。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
2280	田中さんはあした来るでしょうか。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
2281	熱い？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	1
2282	どれが　大きい？	どれが　おおきい？	null	どれが　おおきい？	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	1
2283	だいじょうぶ？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
2284	どの部屋が静か？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
2285	これは、本？　		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
2286	どなたが　山田さん？	どなたが　やまださん？	null	どなたが　やまださん？	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[25]	\N	\N	1
2287	田中さんはあした来る？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[26]	\N	\N	1
2288	田中さんは　いつ　来る？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[27]	\N	\N	1
2289	熱いか？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[28]	\N	\N	1
2290	だいじょうぶか？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[29]	\N	\N	1
2291	これは本か？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[30]	\N	\N	1
2292	田中さんはあした来るか？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[31]	\N	\N	1
2293	熱い｛だろうか/かな/のかな/かしら｝？　		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[32]	\N	\N	1
2294	どれが大きい｛だろう/だろうか/かな/のかな/かしら｝？		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[33]	\N	\N	1
2295	経済の　状態は　よくなるか、　それが　問題です。	けいざいの　じょうたいは　よくなるか、　それが　もんだいです。	null	けいざいの　じょうたいは　よくなるか、　それが　もんだいです。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[34]	\N	\N	1
2369	どうぞ。	請。		どうぞ。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2297	買い物に　出かけましたが、　何を　買うか、　どこで　買うか、　わからなく　なって　困りました。	かいものに　でかけましたが、　なにを　かうか、　どこで　かうか、　わからなく　なって　こまりました。	null	かいものに　でかけましたが、　なにを　かうか、　どこで　かうか、　わからなく　なって　こまりました。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[36]	\N	\N	1
2298	今行きますよ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[37]	\N	\N	1
2299	早く行きましょうよ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[38]	\N	\N	1
2300	早く　やって　くださいよ。	はやく　やって　くださいよ。	null	はやく　やって　くださいよ。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[39]	\N	\N	1
2301	３時ですね。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[40]	\N	\N	1
2302	あしたは日曜日ですね。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[41]	\N	\N	1
2303	暑いですね。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[42]	\N	\N	1
2304	おや、まちがえたかな。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[43]	\N	\N	1
2305	あしたは日曜日だな。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[44]	\N	\N	1
2306	暑いな。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[45]	\N	\N	1
2307	。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[46]	\N	\N	1
2308	来たのは山田君さ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[47]	\N	\N	1
2309	僕がやるぞ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[48]	\N	\N	1
2310	俺もやるぜ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[49]	\N	\N	1
2311	よし、　やるとも。　	よし、　やるとも。	null	よし、　やるとも。	\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[50]	\N	\N	1
2312	きのう、コンサートに行きましたの。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[53]	\N	\N	1
2313	きょうは会議がありましたよね。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[54]	\N	\N	1
2314	わたしはね、きのうね、新宿へね、行ったんですよ。		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[58]	\N	\N	1
2315	きのうな、新宿へな、……		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[59]	\N	\N	1
2316	きのうさ、新宿へさ、……		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[60]	\N	\N	1
2317	きのうよ、新宿へよ、……		null		\N	gmod	instances096.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[61]	\N	\N	1
2318	あ、斉藤先生。			あ、さいとうせんせい。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2319	おはようございます。		 ①おはようございます　②挨拶をする　③おはよう（ございます）(朝)：こんにちは(昼)：こんばんは(夜)　④　山田さんこんにちは。	おはようございます。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2320	おはよう。		①おはようございます　②挨拶をする　③おはよう（ございます）(朝)：こんにちは(昼)：こんばんは(夜)　④　山田さんこんにちは。	おはよう。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2321	先生、　今日は　朝から　授業ですか。	せんせい、　きょうは　あさから　じゅぎょうですか。		せんせい、　きょうは　あさから　じゅぎょうですか。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2322	いいえ、午前中に会議があるんです。			いいえ、ごぜんちゅうにかいぎがあるんです。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2323	山田君は。			やまだくんは。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2324	私は　２限目から　授業です。	わたくしは　にげんめから　じゅぎょうです。		わたくしは　にげんめから　じゅぎょうです。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2325	もう、　十時半ですよ。	もう、　じゅうじはんですよ。		もう、　じゅうじはんですよ。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2326	あっ、　本当だ。	あっ、　ほんとうだ。		あっ、　ほんとうだ。	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2327	急がないと。			いそがないと	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2328	お先に失礼します。		①失礼します　②挨拶をする（退席）③失礼します　④すみません、先約があるのでお先に失礼します。	おさきにしつれいします	\N	dmod	ja01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
2329	先生、ここに印鑑をいただきたいのですが。			せんせい、ここにいんかんをいただきたいのですが。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2330	ああ、科目の変更ですね。			ああ、かもくのへんこうですね。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2331	分かりました。	わかりました。		わかりました。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2332	はい、　どうぞ。	是的，請。		はい、　どうぞ。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
2333	ありがとうございます。		①ありがとうございます　②感謝する　③（どうも）ありがとう（ございます）　④手伝ってくれてどうもありがとう。 	ありがとうございます。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2435	すごいなあ。			すごいなあ。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2334	それから、　この　本を　お返し　します。	それから、　この　ほんを　おかえし　します。		それから、　この　ほんを　おかえし　します。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2335	長い　間　ありがとう　ございました。	ながい　あいだ　ありがとう　ございました。	 ①ありがとうございます　②感謝する　③（どうも）ありがとう（ございます）　④手伝ってくれてどうもありがとう。	ながい　あいだ　ありがとう　ございました。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
2336	いえいえ。			いえいえ	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2337	で、役に立ちましたか。			で、やくにたちましたか。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2338	ええ、　とても　おもしろくて、　勉強に　なりました。	ええ、　とても　おもしろくて、　べんきょうに　なりました。		ええ、　とても　おもしろくて、　べんきょうに　なりました。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2339	そう、それはよかった。			そう、それはよかった。	\N	dmod	ja02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2340	あのう、すみません。		①すみません　②注意を引く　③すみません　④すみません、これいくらですか。	あのう、すみません。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2341	すみません。		①すみません　②注意を引く　③すみません　④すみません、これいくらですか。	すみません。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2342	はい、何でしょう。			はい、なんでしょう。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2343	在学証明書をいただきたいのですが。			ざいがくしょうめいしょをいただきたいのですが。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2344	在学証明書は、　横の　機械を　使って　下さい。	ざいがくしょうめいしょは、　よこの　きかいを　つかって　ください。		ざいがくしょうめいしょは、　よこの　きかいを　つかって　ください。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2345	分かりました。			わかりました。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2346	ありがとうございます。			ありがとうございます。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2347	あのう、たびたびすみません。		①すみません　②注意を引く　③すみません　④すみません、これいくらですか。	あのう、たびたびすみません。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
2348	はい、何でしょう。			はい、なんでしょう。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2349	機械が動かないんです。			きかいがうごかないんです。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2350	ああ、もう５時を過ぎていますね。			ああ、もうごじをすぎていますね。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2351	明日、お願いします。			あした、おねがいします。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2352	はい。			はい。	\N	dmod	ja03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2353	今日は　初めての　授業ですから、　一人ずつ　自己紹介を　お願いします。	きょうは　はじめての　じゅぎょうですから、　ひとりずつ　じこしょうかいを　おねがいします。		きょうは　はじめての　じゅぎょうですから、　ひとりずつ　じこしょうかいを　おねがいします。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2354	じゃあ、田村さんから。			じゃあ、たむらさんから。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2355	はい。			はい。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2356	初めまして。		①初めまして　②自己紹介する(初対面の挨拶)　③初めまして　④初めまして山田です。	はじめまして。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2357	日本語専攻　４年の　田村と　申します。	にほんごせんこう　よねんの　たむらと　もうします。	①田村と申します　②自己紹介する(名前を名乗る)　③(名前)と申します　④こんにちは。山田と申します。	にほんごせんこう　よねんの　たむらと　もうします。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
2358	斉藤先生のゼミで日本語のアクセントについて卒論を書こうと思っています。			さいとうせんせいのゼミでにほんごのアクセントについてそつろんをかこうとおもっています。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	1
2359	これから一年間、よろしくお願いします。		①よろしくお願いします　②自己紹介する（挨拶する）　③よろしくお願いします④はじめまして山田です。よろしくお願いします。	これからいちねんかん、よろしくおねがいします。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[5]	\N	\N	1
2360	こちらこそ、　よろしく。	こちらこそ、　よろしく。		こちらこそ、　よろしく。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2361	で、　田村さん、　卒論の　準備は　いかがですか。	で、　たむらさん、　そつろんの　じゅんびは　いかがですか。		で、　たむらさん、　そつろんの　じゅんびは　いかがですか。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2362	はい、いちおう始めています。			はい、いちおうはじめています。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2363	就職活動のほうは。			しゅうしょくかつどうのほうは。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2364	はい、就職活動もしています。			はい、しゅうしょくかつどうもしています。	\N	dmod	ja04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2370	先生、レポートを提出しに来ました。			せんせい、レポートをていしゅつしにきました。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2371	えっ、レポートですか。			えっ、レポートですか。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2372	たしか　締め切りは　先週の　金曜日　でしたよね。	たしか　しめきりは　せんしゅうの　きんようび　でしたよね。		たしか　しめきりは　せんしゅうの　きんようび　でしたよね。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2373	遅れてすみません。		①すみません　②あやまる　③（どうも）すみません　④昨日はどうもすみませんでした。 	おくれてすみません	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2374	風邪で　寝込んで　しまいまして･･･。	かぜで　ねこんで　しまいまして・・・。		かぜで　ねこんで　しまいまして・・・。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2375	そうですか、でも、そういう場合も電話かメールであらかじめ連絡してくださいね。			そうですか、でも、そういうばあいもでんわかメールであらかじめれんらくしてくださいね。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2376	わかりました。			わかりました。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2377	これから気をつけます。			これからきをつけます。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2378	で、風邪のほうは。			で、かぜのほうは。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2379	もう、　すっかり　良く　なりました。 	もう、　すっかり　よく　なりました。		もう、　すっかり　よく　なりました。	\N	dmod	ja05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2380	失礼します。			しつれいします。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2381	どうぞ。			どうぞ。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2382	先生、これ、軽井沢のお土産なんです。			せんせい、これ、かるいざわのおみやげなんです。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2383	つまらない　ものですけど、　どうぞ。	不成敬意，請笑納。	①どうぞ　②何か（もの）をあげる　③どうぞ　④　これ、どうぞ。	つまらない　ものですけど、　どうぞ。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2384	へえ、つまらないものって、何。			へえ、つまらないものってなに。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2385	りんごワインです。 			りんごワインです。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2386	へえ、それはめずらしいね。			へえ、それはめずらしいね。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2387	でも、本当にいただいていいの。			でも、ほんとうにいただいていいの。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2388	ええ、　どうぞ、　どうぞ。	ええ、　どうぞ、　どうぞ。		ええ、　どうぞ、　どうぞ。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2389	じゃあ、遠慮なくいただきますね。			じゃあ、えんりょなくいただきますね。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2390	うーん、これは楽しみだな。			うーん、これはたのしみだな。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2391	どうも　ありがとう。	謝謝。		どうも　ありがとう。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
2392	いいえ。			いいえ。	\N	dmod	ja06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2393	田中先生、こんばんは。			たなかせんせい、こんばんは。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2394	ああ、　田村さん、　こんばんは。	ああ、　田村さん、　こんばんは。		ああ、　田村さん、　こんばんは。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2395	先生、今まで、会議ですか。			せんせい、いままで、かいぎですか。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2396	そうなんです。	就是這樣。		そうなんです。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2397	でも、　田村さんも　ずいぶん　遅いですね。	でも、　たむらさんも　ずいぶん　おそいですね。		でも、　たむらさんも　ずいぶん　おそいですね。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2398	ええ、図書館で卒論の資料を探していました。 			ええ、としょかんでそつろんのしりょうをさがしていました。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2399	そう、偉いですね。			そう、えらいですね。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2400	じゃあ、気をつけて帰ってくださいね。			じゃあ、きをつけてかえってくださいね。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2401	はい、　では　失礼します。	はい、　では　しつれいします。	①失礼します　②さよならを言う（目下から目上へ）　③さようなら　④部長、お先に失礼します。	はい、　では　しつれいします。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2402	さようなら。		①さようなら　②さよならを言う　③さようなら　④　山田君、さようなら。また明日ね。	さようなら。	\N	dmod	ja07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2403	すみません。			すみません。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2404	いらっしゃいませ。			いらっしゃいませ。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2524	「羅生門」はどう。			｢らしょうもん｣はどう。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2405	本を注文したいんですが。			ほんをちゅうもんしたいんですが。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2406	はい、何の本でしょう。			はい、なんのほんでしょう。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2407	『日本文法辞典』です。			『にほんぶんぽうじてん』です。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2408	『日本文法辞典』ですね。			『にほんぶんぽうじてん』ですね。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2409	いくら　でしょうか。	多少錢呢？	①いくらでしょうか　②情報を求める(金額) 　③いくら（ですか）　④このりんごはいくらですか。	いくら　でしょうか。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2410	ちょっとお待ちください。			ちょっとおまちください。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2411	6,500円です。	ろくせんごひゃくえんです。		ろくせんごひゃくえんです。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2412	税込みですか。			ぜいこみですか。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2413	いえ、　消費税を　入れると、　6,825円に　なります。	いえ、　しょうひぜいを　いれると、　ろくせんはっぴゃくにじゅうごえんに　なります。		いえ、　しょうひぜいを　いれると、　ろくせんはっぴゃくにじゅうごえんに　なります。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
2414	わかりました。			わかりました。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
2415	じゃあ、　お願いします。	那麼就麻煩你了。		じゃあ、　おねがいします。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[2]	\N	\N	1
2416	はい。			はい。 	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
2417	では、　こちらに　お名前と　お電話番号を　お願いします。	では、　こちらに　おなまえと　おでんわばんごうを　おねがいします。		では、　こちらに　おなまえと　おでんわばんごうを　おねがいします。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[2]	\N	\N	1
2418	はい。			はい。	\N	dmod	ja08.xml	/dmodule[1]/body[1]/dialogue[1]/line[13]/sentence[1]	\N	\N	1
2419	渡辺先輩、　授業登録の　ことで、　ちょっと　質問しても　いいですか。	わたなべせんぱい、　じゅぎょうとうろくの　ことで、　ちょっと　しつもんしても　いいですか。		わたなべせんぱい、　じゅぎょうとうろくの　ことで、　ちょっと　しつもんしても　いいですか。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2420	いいよ、何。			いいよ、なに。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2421	英語専攻の　小林先生の　授業を　取った　ことが　ありますか。	えいごせんこうの　こばやしせんせいの　じゅぎょうを　とった　ことが　ありますか。	①小林先生の授業を取ったことがありますか。②情報を求める（経験）③（動詞のタ形）＋ことがありますか　④富士山に登ったことがありますか	えいごせんこうの　こばやしせんせいの　じゅぎょうを　とった　ことが　ありますか。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2422	あるけど。			あるけど。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2423	私、　英語に　あまり　自信が　ないんですけど、　大丈夫でしょうか。	わたくし、　えいごに　あまり　じしんが　ないんですけど、　だいじょうぶでしょうか。		わたくし、　えいごに　あまり　じしんが　ないんですけど、　だいじょうぶでしょうか。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2424	そうだねえ、とても厳しい先生だからねえ。			そうだねえ、とてもきびしいせんせいだからねえ。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2425	他の先生の授業を考えたほうがいいかもしれないよ。			ほかのせんせいのじゅぎょうをかんがえたほうがいいかもしれないよ。	\N	dmod	ja09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2426	暑いですね。	あついですね。		あついですね。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2427	早く夏休みが来るといいな。			はやくなつやすみがくるといいな。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2428	そうね、　山田君、　この　夏の　予定は。	そうね、　やまだくん、　この　なつの　よていは。		そうね、　やまだくん、　この　なつの　よていは。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2429	友達と　ヨーロッパを　旅行しようと　思って　ます。	我想和朋友去歐洲旅行。	①旅行しようと思っています　②予定を言う　③意向形（う／よう）と思います／思っています　④土曜日は映画を見ようと思っています	ともだちと　よーろっぱを　りょこうしようと　おもって　ます。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2430	いいわねえ。			いいわねえ。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2431	先輩の予定は。			せんぱいのよていは。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2432	私は　少し　バイトを　しようと　思って　いるの。	わたしは　すこし　ばいとを　しようと　おもっているの。	①バイトをしようと思っているの　②予定を言う　③意向形（う／よう）と思います／思っています　④土曜日は映画を見ようと思っています	わたしは　すこし　ばいとを　しようと　おもっているの。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2433	何のバイトですか。			なんのバイトですか。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2434	通訳の仕事。			つうやくのしごと。	\N	dmod	ja10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2436	鈴木さん、何を見ているの。			すずきさん、なにをみているの。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2437	旅行の　パンフレットです。	りょこうの　ぱんふれっとです。		りょこうの　ぱんふれっとです。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2438	夏休みにどこかへ旅行したいと思って。			なつやすみにどこかへりょこうしたいとおもって。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2439	そういえば、　先輩は　たしか　去年、　タイへ　行かれましたよね。	そういえば、　せんぱいは　たしか　去年　たいへ　いかれましたよね。		そういえば、　せんぱいは　たしか　去年　たいへ　いかれましたよね。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
2440	ああ、　行ったけど。	ああ、　行ったけど。		ああ、　行ったけど。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2441	お金どのぐらいかかりましたか。		 ①どのぐらいかかりましたか。②情報を求める(程度)　　　　　　　　　　　　　③(～は)どのぐらい(程度)④時間はどのぐらいかかりましたか。	おかねどのぐらいかかりましたか。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2442	けっこう　安かったよ。	けっこう　やすかったよ。		けっこう　やすかったよ。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2443	全部で　10万ぐらいかな。	ぜんぶで　じゅうまんぐらいかな。		ぜんぶで　じゅうまんぐらいかな。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2444	何日間行っていたんですか。		①何日間行っていたんですか。②情報を求める(程度)　　　　　　　　　　　　　③何(期間)～か。④アメリカは何年間住んでいましたか。 	なんにちかんいっていたんですか。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2445	かなり長かったよ。			かなりながかったよ。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2446	3週間ぐらい。			さんしゅうかんぐらい。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2447	3週間で　10万ですか…。	さんしゅうかんで　じゅうまんですか・・・。		さんしゅうかんで　じゅうまんですか・・・。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2448	じゃあ、私もタイにしようかなあ。			じゃあ、わたしもたいにしようかなあ。	\N	dmod	ja11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2449	すみません。			すみません。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2450	はい。			はい。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2451	図書館は　夏休み中も　開いて　いますか。	としょかんは　なつやすみちゅうも　あいて　いますか。		としょかんは　なつやすみちゅうも　あいて　いますか。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2452	ええ、　開いて　いますよ。	ええ、　あいて　いますよ。		ええ、　あいて　いますよ。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2453	何時から　開いて　いますか。	なんじから　あいて　いますか。	 ①何時から開いていますか。②情報を求める(程度)③何時から～か。　　　　　　　　　　　　　　④映画は何時から始まりますか。	なんじから　あいて　いますか。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2454	9時からです。			くじからです。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2455	自習室は何時まで使えますか。		 ①何時まで使えますか。②情報を求める(程度)③何時まで～か。　　　　　　　　　　　　　　④図書館は何時まで開いていますか。	じしゅうしつはなんじまでつかえますか。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2456	5時まで使えます。			ごじまでつかえます。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2457	土日も使えますか。			どにちもつかえますか。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2458	夏休み中は、土日はお休みなんです。			なつやすみちゅうは、どにちはおやすみなんです。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
2459	ありがとうございます。			ありがとうございます。	\N	dmod	ja12.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
2460	はい、どうぞ。			はい、どうぞ。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2461	ちょっと伺いたいのですが。			ちょっとうかがたいのですが。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2462	何でしょう。			なんでしょう。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2463	この　図書館は　初めてなのですが、　本は　一度に　何冊まで　借りられますか。	この　としょかんは　はじめてなのですが、　ほんは　いちどに　なんさつまで　かりられますか。	①一度に何冊　②情報を求める(数字)　③（期間／回数）に(数量)　　　　　　　　　　　　　　④一週間に何日大学に行きますか。	この　としょかんは　はじめてなのですが、　ほんは　いちどに　なんさつまで　かりられますか。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2464	10冊まで　借りられます。	じゅっさつまで　かりられます。		じゅっさつまで　かりられます。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2465	大学院生も　同じですか。	だいがくいんせいも　おなじですか。		だいがくいんせいも　おなじですか。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2495	この　建物の　三階に　あります。	在這棟建築物的三樓。		この　たてものの　さんがいに　あります。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2646	そうだろ。			そうだろ。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2466	いえ、　大学院生は、　一ヶ月に　20冊まで　借りられます。	いえ、　だいがくいんせいは、　いっかげつに　にじゅっさつまで　かりられます。		いえ、　だいがくいんせいは、　いっかげつに　にじゅっさつまで　かりられます。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2467	どれぐらい　借りられますか。	どれぐらい　かりられますか。	 ①どれくらい②情報を求める(数字)③どのぐらい～ですか。　　　　　　　　　　　　　　④どれぐらい使えますか。	どれぐらい　かりられますか。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2468	2週間です。			にしゅうかんです。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2469	分かりました。			わかりました。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
2470	じゃ、これ、お願いします。			じゃ、これ、おねがいします。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
2471	はい。			はい。	\N	dmod	ja13.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
2472	レポートの　締め切りは　今月　20日ですよ。	れぽーとの　しめきりは　こんげつ　はつかですよ。		れぽーとの　しめきりは　こんげつ　はつかですよ。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2473	いいですね。			いいですね。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2474	先生、期末レポートはメールでお送りしてもいいですか。			せんせい、きまつれぽーとはめーるでおおくりしてもいいですか。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2475	メールねえ。			メールねえ。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2476	いや、　やっぱり、　メールは　困るなあ。	いや、　やっぱり、　めーるは　こまるなあ。		いや、　やっぱり、　めーるは　こまるなあ。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2477	いちいちプリントアウトしなければいけないからね。			いちいちプリントアウトしなければいけないからね。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
2478	郵便で20日までに送ってください。		①送ってください。②何でどのようにするかを言う。③(何をどのように)　　　　　　　　　　　　　　～てくさい。④明日まで電話でお知らせください。 	ゆうびんではつかまでにおくってください。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	1
2479	わかりました。			わかりました。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2480	では、郵便でご自宅にお送りします。		 ①お送りします。②何でどのようにするかを言う。　　　　　　　　　　　　　　③(何をどのように)します。④金曜日までメールで連絡します。 	では、ゆうびんでごじたくにおおくりします。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2481	そうして　ください。	そうして　ください。		そうして　ください。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2482	はい。			はい。	\N	dmod	ja14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2483	渡辺さんは、アメリカに留学していましたね。			わたなべさんは、アメリカにりゅうがくしていましたね。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2484	ええ、　学部の　時、　半年間　ボストンに　住んで　いました。	ええ、　がくぶの　とき、　はんとしかん　ぼすとんに　すんで　いました。		ええ、　がくぶの　とき、　はんとしかん　ぼすとんに　すんで　いました。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2485	じゃあ、　英語は　話せますか。	じゃあ、　英語は　話せますか。	①英語は話せますか。②能力について尋ねる。③～はできますか。　　　　　　　　　　④フランス語はしゃべれますか。	じゃあ、　英語は　話せますか。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2486	ええ、　少しなら。	ええ、　すこしなら。		ええ、　すこしなら。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2487	実は、　来週の　水曜日、　アメリカから　お客さんが　来るんですが、　空港まで　迎えに　行って　ほしいんです。	じつは、　らいしゅうの　すいようび、　あめりかから　おきゃくさんが　くるんですが、　くうこうまで　むかえに　いって　ほしいんです。		じつは、　らいしゅうの　すいようび、　あめりかから　おきゃくさんが　くるんですが、　くうこうまで　むかえに　いって　ほしいんです。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2488	ええ、いいですよ。			ええ、いいですよ。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2489	朝の　十時までに　行けますか。	あさの　じゅうじまでに　いけますか。		あさの　じゅうじまでに　いけますか。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2490	大丈夫です。			だいじょうぶです。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2491	車が運転できますから。			くるまがうんてんできますから。	\N	dmod	ja15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2492	すみません、授業料を払いたいのですが。			すみません、じゅぎょうりょうをはらいたいのですが。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2493	授業料でしたら、会計課でお願いします。			じゅぎょうりょうでしたら、かいけいかでおねがいします。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2494	会計課はどこでしょうか。		①どこにありますか。②情報を求める(存在と場所)③(存在/場所)はどこに(いま　　　　　　　　　　　　　すか／ありますか)④山田さんはどこにいますか。	かいけいかはどこでしょうか。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2496	印刷センターのとなりです。			いんさつセンタ－のとなりです。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2497	三階へは　どう　行けば　いいですか。	三樓要怎麼去？		さんがいへは　どう　いけば　いいですか。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2498	あそこに　エレベーターが　あります。	那邊有電梯。		あそこに　えれべーたーが　あります	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2499	わかりました。			わかりました。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2500	ありがとうございます。			ありがとうございます。	\N	dmod	ja16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2501	先輩、小沢先生の｢国際法｣はどうですか。		①～はどうですか。②情報を求める(属性)③(対象)はどうですか。　　　　　　　　　　　　　　④このレストランはどうですいか。	せんぱい、おざわせんせいの｢こくさいほう｣はどうですか。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2502	小沢先生の　授業は　どれも　いいと　思うよ。	おざわせんせいの　じゅぎょうは　どれも　いいと　おもうよ。		おざわせんせいの　じゅぎょうは　どれも　いいと　おもうよ。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2503	じゃあ、村上先生の｢経済史｣は。		①～は。②情報を求める(属性)③(対象)は(どうですか)。　　　　　　　　　　　　　④あのデパートは(どうですか)。	じゃあ、むらうえせんせいの｢けいざいし｣は。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2504	あれは　大変よ。	あれは　たいへんよ。		あれは　たいへんよ。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2505	友達も　よく　言うんですけど、　何が　大変なんですか。	ともだちも　よく　いうんですけど、　なにが　たいへんなんですか。	①何が～ですか。②情報を求める(属性)③何が(どう)ですか。　　　　　　　　　　　　　　④何が難しいですか。	ともだちも　よく　いうんですけど、　なにが　たいへんなんですか。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2506	出席が厳しくて、宿題が多くて。それに成績は辛くて。			しゅっせきがきびしくて、しゅくだいがおおくて。それにせいせきはからくて。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2507	じゃあ、どうしようかなあ。			じゃあ、どうしようかな。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2508	でも、かなり役に立つと思うけど･･･。			でも、かなりやくにたつとおもうけど･･･。	\N	dmod	ja17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2509	では、この間のレポートを返却します。			では、このあいだのレポートをへんきゃくします。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2510	山田君。			やまだくん。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2511	はい。			はい。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2512	なかなか　よく　書けて　いると　思いました。	なかなか　よく　書けて　いると　おもいました。	①よく書けていると思います。②意見を言う。③(意見)と思う。                           ④とてもいい作品だと思います。	なかなか　よく　書けて　いると　おもいました。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2513	あの、結論はこれでいいでしょうか。			あの、けつろんはこれでいいでしょうか。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2514	そうですね、　もう少し　自分の　意見を　書いた　ほうが　いいと　思います。	そうですね、　もうすこし　じぶんの　いけんを　かいた　ほうが　いいと　おもいます。	①書いたほうがいいと思います。②意見を言う。③～ほうが(意見)と思う。　　　　　　　　　　　　　　④こっちのほうがいいと思います。	そうですね、　もうすこし　じぶんの　いけんを　かいた　ほうが　いいと　おもいます。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2515	そうですか。			そうですか。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2516	それから、　漢字の　間違いに　気を　つけて　くださいね。	それから、　かんじの　まちがいに　きを　つけて　くださいね。		それから、　かんじの　まちがいに　きを　つけて　くださいね。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2517	あ、　本当だ。	あ、　ほんとうだ。		あ、　ほんとうだ。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2518	今度から気をつけます。			こんどからきをつけます。	\N	dmod	ja18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2519	鈴木さん、黒澤の映画って好き。			すずきさん、くろさわのえいがってすき。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2520	ええ、　好きです。	對，我喜歡。	①文中の形：すきです。②機能：嗜好について述べる（もの）③文型：(～が)すきです。　　　　　　　　　　　　　　④例文：果物がすきです。	ええ、　すきです。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2521	どれが　一番　好き。	どれが　いちばん　すき。		どれが　いちばん　すき。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2522	そうですねえ、　「赤ひげ」とか　「夢」が　大好きです。	そうですねえ、　「あかひげ」とか　「ゆめ」が　だいすきです。	①文中の形：大好きです。②機能：嗜好について述べる（もの）③文型：(～が)大好きです。　　　　　　　　　　　　　④例文：旅行が大好きです。	そうですねえ、　「あかひげ」とか　「ゆめ」が　だいすきです。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2523	へえ、詳しいんだねえ。			へえ、くわしいんだねえ。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2525	「羅生門」はちょっと…。			｢らしょうもん｣はちょっと･･･。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2526	あまり　好きじゃないです。	あまり　すきじゃないです。	①文中の形：好きじゃないです。②機能：嗜好について述べる（もの）　　　　　　　　　　　　　③文型：(～が/は)好きじゃないです。④例文：焼肉は好きじゃないです。	あまり　すきじゃないです。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2527	来週、　黒澤の　映画祭が　あるんだけど、　一緒に　行く。	らいしゅう、　くろさわの　えいがさいが　あるんだけど、　いっしょに　いく。		らいしゅう、　くろさわの　えいがさいが　あるんだけど、　いっしょに　いく。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2528	えっ、いいんですか。			えっ、いいんですか。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2529	うれしい。			うれしい。	\N	dmod	ja19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2530	鈴木さんは、　よく　料理するの？	すずきさんは、　よく　りょうりするの？		すずきさんは、　よく　りょうりするの？	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2531	ええ、食べるのが好きなので。		①すきなので。②嗜好について述べる（行動）③(行動)がすきです。　　　　　　　　　　　　　④走るのがすきなので。	ええ、たべるのがすきなので。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2532	得意な料理は何？			とくいなりょうりはなに。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2533	スパゲッティとかパエーリアとか。			スパゲッティとかパエーリアとか。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2534	へえ、鈴木さんって、グルメなんだ。			へえ、すずきさんって、グルメなんだ。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2535	じゃあ、食事は毎日、自分で？			じゃあ、しょくじはまいにち、じぶんで？	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2536	どうも　片付けるのが　苦手なので、　毎日は　作りません。	どうも　かたづけるのが　にがてなので、　まいにちは　つくりません。		どうも　かたづけるのが　にがてなので、　まいにちは　つくりません。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2537	たしかに。			たしかに。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2538	食事の後片付けって、面倒だよね。			食事の後片付けって、面倒だよね。	\N	dmod	ja20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2539	すみません、　拡大コピーを　したいのですが。	すみません、　かくだいこぴーを　したいのですが。		すみません、　かくだいこぴーを　したいのですが。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2540	じゃあ、　まず、　この　ボタンを　押して　ください。	じゃあ、　まず、　この　ぼたんを　おして　ください。	①まず　②手順と順序について述べる　③まず、〜。　④困ったことがあったら、まず、留学生課に相談してください。	じゃあ、　まず、　この　ぼたんを　おして　ください。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2541	はい。			はい。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2542	次に、倍率を選んで。		①次に　②手順と順序について述べる　③次に、〜。　④今日は休みだから、まず洗濯をして、次に部屋の掃除をして、それから買い物に行きます。	つぎに、ばいりつをえらんで。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2543	はい。			はい。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2544	最後に　この　ボタンで　用紙を　選んで、　スタートボタンを　押します。	さいごに　この　ぼたんで　ようしを　えらんで、　すたーとぼたんを　おします。	①最後に　②手順と順序について述べる　③最後に、〜。　④今回の旅行では、まず京都に行って、次に奈良に行って、最後に大阪に行きました。	さいごに　この　ぼたんで　ようしを　えらんで、　すたーとぼたんを　おします。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2545	わかりました。			わかりました。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2546	ところで、　コピーカードは　持って　いますか。	ところで、　こぴーかーどは　もって　いますか。		ところで、　こぴーかーどは　もって　いますか。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2547	あっ、　先生から　預かるのを　忘れた。	あっ、　せんせいから　あずかるのを　わすれた。		あっ、　せんせいから　あずかるのを　わすれた。	\N	dmod	ja21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2548	もしもし。	喂。		もしもし。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2549	もしもし、　田村ですけど。	もしもし、　たむらですけど。		もしもし、　たむらですけど。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2550	ああ、田村さん。			ああ、たむらさん。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2551	先輩、　最近　学校で　お会いしませんが、　どうか　しましたか。	せんぱい、　さいきん　がっこうで　お会いしませんが、　どうか　しましたか。	①最近学校でお会いしませんが、どうかしましたか。　②どうしているかを尋ねる　③どう　④最近どうですか。	せんぱい、　さいきん　がっこうで　お会いしませんが、　どうか　しましたか。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2552	いや、　ちょっと　足を　けがして　しまって。	いや、　ちょっと　あしを　けがして　しまって。		いや、　ちょっと　あしを　けがして　しまって。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2553	えっ、そうだったんですか。			えっ、そうだったんですか。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2554	大丈夫ですか。			だいじょうぶですか。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2555	ええ、　もう　大丈夫です。	ええ、　もう　だいじょうぶです。		ええ、　もう　だいじょうぶです。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2556	それで、論文のほうはどうですか。		①どうですか　②どうしているかを尋ねる　③どうですか。　④最近、調子はどうですか。	それで、ろんぶんのほうはどうですか。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2557	何とかがんばっていますよ。			なんとかがんばっていますよ。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2558	あまり、無理はなさらないでくださいね。			あまり、むりはなさらないでくださいね。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
2559	はい。			はい。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
2560	どうもありがとう。			どうもありがとう。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[2]	\N	\N	1
2561	どうかお大事に。			どうかおだいじに。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
2562	じゃあ、　また。	待會見。/再見囉。		じゃあ、　また。	\N	dmod	ja22.xml	/dmodule[1]/body[1]/dialogue[1]/line[13]/sentence[1]	\N	\N	1
2563	明日のボート大会のことですけど。			あしたのボートたいかいのことですけど。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2564	何か。			なにか。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2565	もし、雨が降ったら、大会は中止ですか。			もし、あめがふったら、たいかいはちゅうしですか。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2566	いいえ。			いいえ。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2567	小雨程度なら、中止にはならないと思いますが。		①小雨程度なら、中止にはならない　②ある条件での行動を言う　③条件表現　〜なら、〜。　④風邪をひいたのなら、早く病院に行ったほうがいいですよ。	こさめていどなら、ちゅうしにはならないとおもいますが。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2568	じゃあ、大雨の場合は、授業がありますか。			じゃあ、おおあめのばあいは、じゅぎょうがありますか。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2569	いいえ。			いいえ。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2570	授業はないと思います。			じゅぎょうはないとおもいます。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2571	ああ、　明日、　雨だと　いいなあ。	ああ、　あした、　あめだと　いいなあ。		ああ、　あした、　あめだと　いいなあ。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2572	どうして。			どうして。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2573	明日　雨だったら、　友達と　映画を　見に　いく　約束を　して　いるんです。	あした　あめだったら、　ともだちと　えいがを　みに　いく　やくそくを　して　いるんです。	①明日雨だったら、友達と映画を見にいく　②ある条件での行動を言う　③条件表現　〜たら、〜　④値段が高かったら、買いません。	あした　あめだったら、　ともだちと　えいがを　みに　いく　やくそくを　して　いるんです。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2574	なるほど。			なるほど。	\N	dmod	ja23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
2575	来週の　飲み会、　新宿と、　吉祥寺と、　池袋の　中で、　どこが　一番　いいでしょうか。	らいしゅうの　のみかい、　しんじゅくと　きちじょうじと、　いけぶくろの　なかで、　どこが　いちばん　いいでしょうか。		らいしゅうの　のみかい、　しんじゅくと　きちじょうじと、　いけぶくろの　なかで、　どこが　いちばん　いいでしょうか。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2576	池袋は遠いから、やめませんか。			いけぶくろはとおいから、やめませんか。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2577	そうですね。			そうですね。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2578	じゃあ、　新宿と　吉祥寺と、　どちらが　いいでしょうか。	じゃあ、　しんじゅくと　きちじょうじと、　どちらが　いいでしょうか。		じゃあ、　しんじゅくと　きちじょうじと、　どちらが　いいでしょうか。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2579	吉祥寺より　新宿の　ほうが　安い　店が　多いですから、　新宿に　しませんか。	きちじょうじより　しんじゅくの　ほうが　やすい　みせが　おおいですから、　しんじゅくに　しませんか。	①吉祥寺より新宿のほうが安い店が多い　②比べて述べる　③比較する表現　ＡよりＢのほうが〜。　④野球よりサッカーのほうが好きです。	きちじょうじより　しんじゅくの　ほうが　やすい　みせが　おおいですから、　しんじゅくに　しませんか。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2580	たしかにそうですね。			たしかにそうですね。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2581	じゃ、新宿にしましょう。			じゃ、しんじゅくにしましょう。	\N	dmod	ja24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2582	田村さん。			たむらさん。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2583	はい。			はい。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2584	就職活動は進んでいますか。			しゅうしょくかつどうはすすんでいますか。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2585	それが、なかなか思い通りに進まなくて。			それが、なかなかおもいどおりにすすまなくて。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2586	そう。			そう。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2587	それで、どのような仕事を考えているんですか。			それで、どのようなしごとをかんがえているんですか。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2588	日本語を　教える　仕事です。	にほんごを　おしえる　しごとです。		にほんごを　おしえる　しごとです。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2589	そう。			そう。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2590	それじゃ、　外国で　教えると　いうのは　どうですか。	それじゃ、　がいこくで　おしえると　いうのは　どうですか。	①外国で教えるというのはどうですか　②提案する　③〜はどうですか　④飛行機で行くのは高いから、寝台車で行くというのはどうですか。	それじゃ、　がいこくで　おしえると　いうのは　どうですか。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2591	ちょうど、　韓国の　大学で　日本語教師を　募集して　いるんですよ。	ちょうど、　かんこくの　だいがくで　にほんごきょうしを　ぼしゅうして　いるんですよ。		ちょうど、　かんこくの　だいがくで　にほんごきょうしを　ぼしゅうして　いるんですよ。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
2592	え、そうなんですか。			え、そうなんですか。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2593	興味があれば、推薦書を書いてあげますよ。			きょうみがあれば、すいせんしょをかいてあげますよ。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2594	わあ、うれしい。			わあ、うれしい。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
2595	じゃあ、これから真剣に考えてみます。			じゃあ、これからしんけんにかんがえてみます。	\N	dmod	ja25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
2596	はい、　では　今日の　授業は　ここまで。 	はい、　では　きょうの　じゅぎょうは　ここまで。		はい、　では　きょうの　じゅぎょうは　ここまで。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2597	先生。			せんせい。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2598	来週の授業、休ませていただきたいのですが。			らいしゅうのじゅぎょう、やすませていただきたいのですが。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2599	なぜですか。	為什麼？		なぜですか。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2600	じつは、就職の最終面接があるんです。		①就職の面接があるんです　②理由を述べる　③関連づけ　〜ん（の）です　④昨日は遅刻してしまいました。電車が遅れたんです。	じつは、しゅうしょくのさいしゅうめんせつがあるんです。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2601	そうですか。			そうですか。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2602	じゃ、　授業の　後の　飲み会にも　来られませんか。	じゃ、　じゅぎょうの　あとの　のみかいにも　こられませんか。		じゃ、　じゅぎょうの　あとの　のみかいにも　こられませんか。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2603	はい、　会社が　遠くに　あるので、　無理だと　思います。	はい、　かいしゃが　とおくに　あるので、　むりだと　おもいます。	①会社が遠くにあるので　②理由を述べる　③理由を表す表現　〜ので　④ちょっと用事があるので、お先に失礼します。	はい、　かいしゃが　とおくに　あるので、　むりだと　おもいます。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2604	そうですか。			そうですか。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2605	じゃ、面接、がんばってくださいね。			じゃ、めんせつ、がんばってくださいね。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2606	がんばります。			がんばります。	\N	dmod	ja26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2607	先生、お忙しいところを申し訳ありません。			せんせい、おいそがしいところをもうしわけありません。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2608	実は　来年、　アメリカの　大学に　留学しようと　思って　いるのですが。	じつは　らいねん、　あめりかの　だいがくに　りゅうがくしようと　おもって　いるのですが。		じつは　らいねん、　あめりかの　だいがくに　りゅうがくしようと　おもって　いるのですが。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2609	そうですか。			そうですか。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2610	それは、いいですね。			それは、いいですね。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2611	それで、先生に推薦書を書いていただきたいのですが、よろしいでしょうか。		①推薦書を書いていただきたいのですが、よろしいでしょうか　②依頼する　③〜ていただきたいのですが　④わからないところがあるので、教えていただきたいのですが、よろしいでしょうか。	それで、せんせいにすいせんしょをかいていただきたいのですが、よろしいでしょうか。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2612	いいですよ。			いいですよ。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2613	で、　締め切りは　いつまでですか。	で、　しめきりは　いつまでですか。		で、　しめきりは　いつまでですか。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2614	それが、かなり急いでいるんです。			それが、かなりいそいでいるんです。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2615	来週の　金曜日までに　お願い　できないでしょうか。	らいしゅうの　きんようびまでに　おねがい　できないでしょうか。	①お願いできないでしょうか　②依頼する　③お願いできないでしょうか　④メールではなく、ファックスでお願いできないでしょうか。	らいしゅうの　きんようびまでに　おねがい　できないでしょうか。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2616	それなら、だいじょうぶですよ。			それなら、だいじょうぶですよ。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2617	ありがとうございます。			ありがとうございます。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2618	これで、ほっとしました。			これで、ほっとしました。	\N	dmod	ja27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2619	学園祭があるんですか。			がくえんさいがあるんですか。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2620	はい。			はい。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2621	今月の18日からです。			こんげつのじゅうはちにちからです。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2622	どんな催し物があるんですか。			どんなもよおしものがあるんですか。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2623	ここは　外語大ですから、　いろんな　国の　音楽を　演奏したり、　お芝居や　ダンスを　やったり、　料理店を　出したり　します。	ここは　がいごだいですから、　いろんな　くにの　おんがくを　えんそうしたり、　おしばいや　だんすを　やったり、　りょうりてんを　だしたり　します。	①いろいろな国の音楽を演奏したり、お芝居やダンスをやったり、料理店を出したりします　②例をあげて述べる　③〜たり、〜たりします。　④日曜日は、買い物に行ったり、映画を見たりします。	ここは　がいごだいですから、　いろんな　くにの　おんがくを　えんそうしたり、　おしばいや　だんすを　やったり、　りょうりてんを　だしたり　します。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2624	へえ。			へえ。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2625	で、　どんな　料理が　食べられるんですか。	で、　どんな　りょうりが　たべられるんですか。		で、　どんな　りょうりが　たべられるんですか。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2626	そう、　タイや　韓国や　イタリアや　いろいろな　国の　食べ物が　あります。	そう、　たいや　かんこくや　いたりあや　いろいろな　くにの　たべものが　あります。	①タイや韓国やイタリアや、いろいろな国の食べ物　②例をあげて述べる　③〜や〜　④日本語の授業は、会話や聴解、読解の授業などがあります。	そう、　たいや　かんこくや　いたりあや　いろいろな　くにの　たべものが　あります。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2627	そうですか。			そうですか。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2628	それは　楽しそうですね。	それは　たのしそうですね。		それは　たのしそうですね。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2629	じゃ、子どもを連れて来ます。			じゃ、こどもをつれてきます。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
2630	ぜひいらしてください。			ぜひいらしてください。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2631	お待ちしています。			おまちしています。	\N	dmod	ja28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
2632	いらっしゃいませ。			いらっしゃいませ。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2633	ご注文は。			ごちゅうもんは。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2634	天ぷらうどん、お願いします。			てんぷらうどん、おねがいします。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2635	ごめんなさい。			ごめんなさい。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2636	天ぷらがもう終わってしまったんですよ。			てんぷらがもうおわってしまったんですよ。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2637	ああ、　そうですか…。	啊，這樣子啊…。		ああ、　そうですか…。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2638	うどんは他に何がありますか。			うどんはほかになにがありますか。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2639	たぬきかきつねならありますけど。			たぬきかきつねならありますけど。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2640	たぬきかきつねね。			たぬきかきつねね。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2641	じゃあ、きつねうどんでいいです。		①きつねうどんでいいです　②妥協する　③〜でいいです　④本当はこの色の靴がほしいんですけど、サイズがないなら別の色でいいです。	じゃあ、きつねうどんでいいです。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2642	はい、きつねですね。			はい、きつねですね。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2643	少々お待ちください。			しょうしょうおまちください。	\N	dmod	ja29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2644	先輩。			せんぱい。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2645	この電子辞書、いいですねえ。			このでんしじしょ、いいですねえ。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2647	最近、買ったんだ。			さいきん、かったんだ。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2648	次の　講読の　授業で　お借りしても　いいですか。	つぎの　こうどくの　じゅぎょうで　おかりしても　いいですか。	①お借りしてもいいですか　②許可を求める　③〜てもいいですか。　④写真を撮ってもいいですか。	つぎの　こうどくの　じゅぎょうで　おかりしても　いいですか。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2649	うーん…。			うーん…。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2650	まあ、いいよ。			まあ、いいよ。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2651	返すのは、　お昼休みでも　いいですか。	我可以中午休息時間還嗎？	①お昼休みでもいいですか　②許可を求める　③〜て（で）もいいですか　④この書類の記入は英語でもいいですか。	かえすのは、　おひるやすみでも　いいですか。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2652	いいけど。			いいけど。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2653	僕、　３限目に　使うから、　それまでには　返して　くれよ。	ぼく、　さんげんめに　つかうから、　それまでには　かえして　くれよ。		ぼく、　さんげんめに　つかうから、　それまでには　かえして　くれよ。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2654	わかりました。			わかりました。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2655	あのう、４限目の英作でもお借りしたいんですが。			あのう、よげんめのえいさくでもおかりしたいんですが。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2656	ええっ。			ええっ。	\N	dmod	ja30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2657	皆さん、　来週の　シンポジウム、　よろしく　お願いします。	みなさん、　らいしゅうの　しんぽじうむ、　よろしく　おねがいします。		みなさん、　らいしゅうの　しんぽじうむ、　よろしく　おねがいします。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2658	はい。			はい。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2659	先生、そのシンポジウムは必ず出なければいけませんか。		①出なければいけませんか　②義務を確認する　③Vなければいけませんか。④雨でも行かなければなりませんか。	せんせい、そのシンポジウムはかならずでなければいけませんか。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2660	ええ、これでレポートを書いてもらいますから。			ええ、これでレポートをかいてもらいますから。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2661	あのう、　その日に　会社の　面接が　あるんですが…。	あのう、　そのひに　かいしゃの　めんせつが　あるんですが・・・。		あのう、　そのひに　かいしゃの　めんせつが　あるんですが・・・。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2662	それなら仕方がありませんね。			それならしかたがありませんね。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2663	先生、レポートは来週中に提出しなければなりませんか。		①提出なければいけませんか　②義務を確認する　③Vなければいけませんか。④雨でも行かなければなりませんか。	せんせい、れぽーとはらいしゅうちゅうにていしゅつしなければなりませんか。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2664	ええ、もちろんですよ。			ええ、もちろんですよ。	\N	dmod	ja31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2665	あ、ちょっと、ちょっと。			あ、ちょっと、ちょっと。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2666	え、何ですか。			え、なんですか。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2667	そこに　空き缶を　捨てては　いけませんよ。	そこに　あきかんを　すてては　いけませんよ。	①捨ててはいけません　②禁止する　③Vてはいけません。④廊下を走ってはいけません。	そこに　あきかんを　すてては　いけませんよ。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2668	空き缶は　こっちに　捨てて　ください。	あきかんは　こっちに　すてて　ください。		あきかんは　こっちに　すてて　ください。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2669	わかりました。			わかりました。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2670	ああっ、　それは　そっちに　捨てて　ください。	ああっ、　それは　そっちに　すてて　ください。		ああっ、　それは　そっちに　すてて　ください。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2671	あ、申し訳ありません。			あ、もうしわけありません。	\N	dmod	ja32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2672	ちょっと　すみません。	不好意思。		ちょっと　すみません。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2673	何ですか。			なんですか。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2674	ここは　自転車置き場じゃないんですよ。	ここは　じてんしゃおきばじゃないんですよ。		ここは　じてんしゃおきばじゃないんですよ。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2675	そうですか。			そうですか。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2676	じゃ、どこにとめればいいでしょうか。			じゃ、どこにとめればいいでしょうか。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2708	じゃあ、　友達と　いっしょに　見に　行くよ。	じゃあ、　ともだちと　いっしょに　みに　いくよ。		じゃあ、　ともだちと　いっしょに　みに　いくよ。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
2677	図書館の　となりに　自転車置き場が　ありますから、　そこに　とめて　ください。	としょかんの　となりに　じてんしゃおきばが　ありますから、　そこに　とめて　ください。	①そこにとめてください。②指示する　③Vてください　④それを読んでおいてください。	としょかんの　となりに　じてんしゃおきばが　ありますから、　そこに　とめて　ください。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2678	わかりました。			わかりました。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2679	これからは必ずそこにとめてくださいね。		①そこにとめてください。②指示する　③Vてください　④それを読んでおいてください。	これからはかならずそこにとめてくださいね。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2680	はい。			はい。	\N	dmod	ja33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2681	吉田さん、　ちょっと　お願いが　あるんですけど。	よしださん、　ちょっと　おねがいが　あるんですけど。		よしださん、　ちょっと　おねがいが　あるんですけど。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2682	はい、　何でしょうか。	はい、　なんでしょうか。		はい、　なんでしょうか。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2683	ゼミのホームページを作りたいんですが、手伝ってもらえますか。			ぜみのほーむぺーじをつくりたいんですが、てつだってもらえますか。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2684	はい、わかりました。			はい、わかりました。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2685	吉田さんの研究テーマについても載せたいんですが、いいですか。			よしださんのけんきゅうてーまについてものせたいんですが、いいですか。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2686	はい、かまいません。			はい、かまいません。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2687	あ、あと、顔写真も載せようと思うんですが。			あ、あと、かおじゃしんものせようとおもうんですが。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2688	すみません、顔写真はちょっと載せないでいただけないでしょうか。		①載せないでいただけないでしょうか。②非行為を依頼する　③Vないでください／Vないでいただけませんか。④すみませんがここで煙草を吸わないでください。	すみません、かおじゃしんはちょっとのせないでいただけないでしょうか。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2689	あ、そうですか。			あ、そうですか。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2690	わかりました。			わかりました。	\N	dmod	ja34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
2691	山田くん、　今日の　練習、　出るでしょう。	やまだくん、　きょうの　れんしゅう、　でるでしょう。		やまだくん、　きょうの　れんしゅう、　でるでしょう。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2692	あのう、今日、練習に出なくてもいいですか。			あのう、きょう、れんしゅうにでなくてもいいですか。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2693	どうして。	どうして。		どうして。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2694	具合でも悪いの。			ぐあいでもわるいの。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2695	いえ、　明日、　試験が　四つも　あるんです。	いえ、　あした、　しけんが　よっつも　あるんです。		いえ、　あした、　しけんが　よっつも　あるんです。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2696	あ、そう。			あ、そう。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2697	じゃ、出なくてもいいですよ。		①出なくてもいいです　②義務を否定する　③Vなくてもいいです　④雨の日は掃除しなくてもいいです。	じゃ、でなくてもいいですよ。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2698	試験、がんばってね。			しけん、がんばってね。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
2699	はい、ありがとうございます。			はい、ありがとうございます。	\N	dmod	ja35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2700	鈴木さん、こんにちは。			すずきさん、こんにちは。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2701	あ、野村先輩。			あ、のむらせんぱい。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2702	何をしているの。			なにをしているの。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2703	学園祭の準備です。			がくえんさいのじゅんびです。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2704	ああ、鈴木さんはダンスサークルだったんだ。			ああ、すずきさんはダンスサークルだったんだ。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2705	そうなんです。			そうなんです。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2706	土曜日に　ステージが　あるんですが、　よかったら、　先輩も　見に　いらっしゃいませんか。	どようびに　すてーじが　あるんですが、　よかったら、　せんぱいも　みに　いらっしゃいませんか。	①見にいらっしゃいませんか。②招待する　③いらっしゃいませんか④誕生パーティーをするのですがうちにいらっしゃいませんか。	どようびに　すてーじが　あるんですが、　よかったら、　せんぱいも　みに　いらっしゃいませんか。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2707	わかった。			わかった。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2709	よろしくお願いします。			よろしくおねがいします。	\N	dmod	ja36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2710	先輩、どうしました。			せんぱい、どうしました。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2711	具合が　悪そうですけど。	ぐあいが　わるそうですけど。		ぐあいが　わるそうですけど。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2712	うん、　スキーの　合宿で　風邪を　ひいて　しまったみたい。	うん、　すきーの　がっしゅくで　かぜを　ひいて　しまったみたい。		うん、　すきーの　がっしゅくで　かぜを　ひいて　しまったみたい。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2713	ゆうべから　急に　熱が　出てね。	ゆうべから　きゅうに　ねつが　でてね。		ゆうべから　きゅうに　ねつが　でてね。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
2714	それなら、　早く　病院に　行った　ほうが　いいですよ。	それなら、　はやく　びょういんに　いった　ほうが　いいですよ。	①行ったほうがいいですよ　②助言する　③Vたほうがいいです　④風邪のときは病院に行ったほうがいいですよ。	それなら、　はやく　びょういんに　いった　ほうが　いいですよ。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2715	インフルエンザかもしれませんから。			いんふるえんざかもしれませんから。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
2716	ありがとう。			ありがとう。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2717	でも、　もうすぐ　卒論の　締め切りなの。	でも、　もうすぐ　そつろんの　しめきりなの。		でも、　もうすぐ　そつろんの　しめきりなの。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2718	でも、　無理は　絶対　しない　ほうが　いいです。	でも、　無理は　絶対　しない　ほうが　いいです。	①しないほうがいいです　②助言する　③Vないほうがいいです　④風邪のときはお風呂に入らない方がいいです。	でも、　無理は　絶対　しない　ほうが　いいです。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2719	うん、そうね。			うん、そうね。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2720	ありがとう。			ありがとう。	\N	dmod	ja37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2721	もしもし、　謝恩会の　会場を　予約したいんですけど。	もしもし、　しゃおんかいの　かいじょうを　よやくしたいんですけど。		もしもし、　しゃおんかいの　かいじょうを　よやくしたいんですけど。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2722	3月25日の6時からです。			さんがつにじゅうごにちのろくじからです。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2723	30名で、　一人　一万円ぐらいで　お願いできますか。	さんじゅうめいで、　ひとり　いちまんえんぐらいで　おねがいできますか。		さんじゅうめいで、　ひとり　いちまんえんぐらいで　おねがいできますか。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2724	はい、田村と申します。			はい、たむらともうします。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2725	それから、　ホテルの　パンフレットを　送って　ほしいんですが。	それから、　ほてるの　ぱんふれっとを　おくって　ほしいんですが。	①送ってほしいんですが　②要求する　③Vてほしい　④すみません、資料を見せてほしいのですが。	それから、　ほてるの　ぱんふれっとを　おくって　ほしいんですが。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2726	はい、住所は、東京都府中市朝日町3の11の1です。			はい、じゅうしょは、とうきょうとふちゅうしあさひちょうさんのじゅういちのいちです。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2727	はい、　では、　よろしく　お願いします。	はい、　では、　よろしく　おねがいします。		はい、　では、　よろしく　おねがいします。	\N	dmod	ja38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2728	先輩、もうすぐ卒業ですね。 			せんぱい、もうすぐそつぎょうですね。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2729	就職は、もう決まりましたか。 			しゅうしょくは、もうきまりましたか。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
2730	ああ、商社に決まったんだ。			ああ、しょうしゃにきまったんだ。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2731	おめでとうございます。			おめでとうございます。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2732	ありがとう。			ありがとう。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2733	鈴木さんは、将来、どんな仕事をしたいと思っているの。			すずきさんは、しょうらい，どんなしごとをしたいとおもっているの。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2734	海外で　働きたいと　思って　いるんです。	我希望能夠在國外工作。	①働きたいと思っているんです。②希望を述べる　③Vたいと思います④いつか自分の家を建てたいと思います。	かいがいで　はたらきたいと　おもって　いるんです。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2735	へえ、それはすごいね。			へえ、それはすごいね。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2736	どこに行きたいの。			どこに行きたいの。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
2774	松井さんに　鉛筆を　貸して　もらいました。	松井借了鉛筆給我。	\N	まついさんに　えんぴつを　かして　もらいました。	\N	vmod	\N	\N	\N	90	1
2913	友達の　自転車の　うしろに　乗りました。	我坐在朋友的腳踏車後面。	\N	ともだちの　じてんしゃの　うしろに　のりました。	\N	vmod	\N	\N	\N	289	1
2737	ビジネス英語を勉強しているので、やっぱりアメリカに行きたいですね。		①アメリカに行きたいです　②希望を述べる　③Vたいです　④いつかあなたに会いに行きたいです。	びじねすえいごをべんきょうしているので，やっぱりあめりかにいきたいですね。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2738	それはいいね。			それはいいね。	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
2739	お待たせ。			おまたせ	\N	dmod	ja39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
2740	ありがとうございました。			ありがとうございました。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2741	あ、斉藤先生。			あ、さいとうせんせい。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
2742	野村君、卒業おめでとう。			のむらくん、そつぎょうおめでとう。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
2743	ありがとうございます。			ありがとうございます。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
2744	先生、　こちらが　私の　母です。	老師，這是我媽媽。	①こちらが私の母です。②人を紹介する　③こちらが(人名)です　④こちらが当社の社長の山本です。	せんせい、　こちらが　わたくしの　ははです。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
2745	浩二の母でございます。			こうじのははでございます。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
2746	浩二が　大変　お世話に　なりました。	こうじが　たいへん　おせわに　なりました。		こうじが　たいへん　おせわに　なりました。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
2747	いいえ、　野村君、　これから　立派な　社会人に　なって　くださいね。	いいえ、　のむらくん、　これから　りっぱな　しゃかいじんに　なって　くださいね。		いいえ、　のむらくん、　これから　りっぱな　しゃかいじんに　なって　くださいね。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
2748	はい、先生、４年間、ありがとうございました。			はい，せんせい、よねんかん、ありがとうございました。	\N	dmod	ja40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
2749	薬は朝だけ飲みます。		\N	\N	\N	vmod	\N	\N	\N	205	1
2750	薬を飲んで寝ます。		\N	\N	\N	vmod	\N	\N	\N	205	1
2751	かぜを　ひいたので、　薬を　飲みます。	因為感冒了，我要吃藥。	\N	かぜを　ひいたので、　くすりを　のみます。	\N	vmod	\N	\N	\N	205	1
2752	歯をみがきます。	はをみがきます。	\N	はをみがきます。	\N	vmod	\N	\N	\N	505	1
2753	人が　大勢　死にました。	死了很多人。	\N	ひとが　おおぜい　しにました。	\N	vmod	\N	\N	\N	291	1
2754	ごはんを　食べたら、　歯を　磨きます。	吃完飯後要刷牙。	\N	ごはんを　たべたら、　はを　みがきます。	\N	vmod	\N	\N	\N	505	1
2755	木村さんは　とても　頭が　いいです。	木村頭腦很好。	\N	きむらさんは　とても　あたまが　いいです。	\N	vmod	\N	\N	\N	20	1
2756	郵便局は　駅の　そばに　あります。	郵局在車站旁邊。	\N	ゆうびんきょくは　えきの　そばに　あります。	\N	vmod	\N	\N	\N	660	1
2757	あした　荷物が　着きます。	明天行李會到。	\N	あした　にもつが　つきます。	\N	vmod	\N	\N	\N	404	1
2758	電車が　駅に　着きます。	電車要抵達車站了。	\N	でんしゃが　えきに　つきます。	\N	vmod	\N	\N	\N	404	1
2759	封筒に　名前を　書きます。	在信封上寫名字。	\N	ふうとうに　なまえを　かきます。	\N	vmod	\N	\N	\N	558	1
2760	佐藤さんは　髪が　短いです。	さとうさんは　かみが　みじかいです。	\N	さとうさんは　かみが　みじかいです。	\N	vmod	\N	\N	\N	619	1
2761	駅の　うしろに　スーパーが　あります。	車站的後面有超級市場。	\N	えきの　うしろに　すーぱーが　あります。	\N	vmod	\N	\N	\N	72	1
2762	きのう　とても　寒かったので、　かぜを　ひきました。	因為昨天很冷，我感冒了。	\N	きのう　とても　さむかったので、　かぜを　ひきました。	\N	vmod	\N	\N	\N	153	1
2763	頭が　痛いので、　今晩は　早く　寝ます。	因為頭痛，今晚要早點睡。	\N	あたまが　いたいので、　こんばんは　はやく　ねます。	\N	vmod	\N	\N	\N	20	1
2764	おなかが　痛いので、　病院へ　行きます。	因為肚子痛，我要去醫院。	\N	おなかが　いたいので、　びょういんへ　いきます。	\N	vmod	\N	\N	\N	117	1
2765	かぜで、　熱が　３８度　あります。	かぜで、　ねつが　さんじゅうはちど　あります。	\N	かぜで、　ねつが　さんじゅうはちど　あります。	\N	vmod	\N	\N	\N	432	1
2766	歯が　痛いので、　何も　食べられません。	因為牙齒痛，什麼東西都沒辦法吃。	\N	はが　いたいので、　なにも　たべられません。	\N	vmod	\N	\N	\N	52	1
2767	いすに　座って、　話を　します。	坐在椅子上說話。	\N	いすに　すわって、　はなしを　します。	\N	vmod	\N	\N	\N	50	1
2768	テーブルの　上に　花瓶が　置いて　あります。	てーぶるの　うえに　かびんが　おいて　あります。	\N	てーぶるの　うえに　かびんが　おいて　あります。	\N	vmod	\N	\N	\N	414	1
2769	冷蔵庫の　中に　何も　ありません。	冰箱裡面什麼都沒有。	\N	れいぞうこの　なかに　なにも　ありません。	\N	vmod	\N	\N	\N	687	1
2770	寝る　前に　ストーブを　消さないと、　危ないです。	ねる　まえに　すとーぶを　けさないと、　あぶないです。	\N	ねる　まえに　すとーぶを　けさないと、　あぶないです。	\N	vmod	\N	\N	\N	323	1
2771	ラジオで　ニュースを　聞きます。	用收音機聽新聞。	\N	らじおで　にゅーすを　ききます。	\N	vmod	\N	\N	\N	678	1
2772	ラジカセは　ラジオも　音楽も　聞く　ことが　できます。	錄放音機可以聽廣播也可以聽音樂。	\N	らじかせは　らじおも　おんがくも　きく　ことが　できます。	\N	vmod	\N	\N	\N	679	1
2773	テープレコーダーに　テープを　入れます。	放錄音帶到錄音機裡面。	\N	てーぷれこーだーに　てーぷを　いれます。	\N	vmod	\N	\N	\N	415	1
2775	来週、　不動産屋へ　行って、　新しい　部屋を　探します。	下個星期我要去房地產業者那邊找新房子。	\N	らいしゅう、　ふどうさんやへ　いって、　あたらしい　へやを　さがします。	\N	vmod	\N	\N	\N	719	1
2776	玄関や　廊下を　掃除します。	打掃門口和走廊。	\N	げんかんや　ろうかを　そうじします。	\N	vmod	\N	\N	\N	227	1
2777	玄関に　花瓶が　置いて　あります。	門口擺著花瓶。	\N	げんかんに　かびんが　おいて　あります。	\N	vmod	\N	\N	\N	227	1
2778	新しい　家は　台所が　広いので、　とても　便利です。	因為新家的廚房很大，非常方便。	\N	あたらしい　いえは　だいどころが　ひろいので、　とても　べんりです。	\N	vmod	\N	\N	\N	365	1
2779	夕飯を　食べて、　おふろに　入って、　寝ます。	吃晚飯、洗澡、睡覺。	\N	ゆうはんを　たべて、　おふろに　はいって、　ねます。	\N	vmod	\N	\N	\N	123	1
2780	この　靴は　古いです。	這雙鞋很舊。	\N	この　くつは　ふるいです。	\N	vmod	\N	\N	\N	569	1
2781	駅から　学校まで　遠いので、　バスに　乗ります。	因為從學校到車站很遠，所以我搭公車。	\N	えきから　がっこうまで　とおいので、　ばすに　のります。	\N	vmod	\N	\N	\N	441	1
2782	新しい　うちは　駅から　近いので、　とても　便利です。	新家離車站很近，所以很方便。	\N	あたらしい　うちは　えきから　ちかいので、　とても　べんりです。	\N	vmod	\N	\N	\N	389	1
2783	松井さんは　白い　服を　着て　います。	松井穿著白衣服。	\N	まついさんは　しろい　ふくを　きて　います。	\N	vmod	\N	\N	\N	561	1
2784	暑い　日は　帽子を　かぶって　出かけます。	天氣熱時我會戴帽子出門。	\N	あつい　ひは　ぼうしを　かぶって　でかけます。	\N	vmod	\N	\N	\N	585	1
2785	玄関で　靴を　脱ぎます。	在門口脫鞋子。	\N	げんかんで　くつを　ぬぎます。	\N	vmod	\N	\N	\N	208	1
2786	電車に　傘を　忘れて　しまいました。	雨傘放在電車上忘了拿。	\N	でんしゃに　かさを　わすれて　しまいました。	\N	vmod	\N	\N	\N	151	1
2787	きのう、　新しい　財布を　買いました。	昨天我買了新錢包。	\N	きのう、あたらしい　さいふを　かいました。	\N	vmod	\N	\N	\N	263	1
2788	あの　眼鏡を　かけて　いる　人は　松井さんです。	那個戴著眼鏡的人是松井。	\N	あの　めがねを　かけて　いる　ひとは　まついさんです。	\N	vmod	\N	\N	\N	639	1
2789	本屋で　雑誌を　買いました。	我在書店買了雜誌。	\N	ほんやで　ざっしを　かいました。	\N	vmod	\N	\N	\N	140	1
2790	ここは　二階です。	這裡是二樓。	\N	ここは　にかいです。	\N	vmod	\N	\N	\N	704	1
2791	松井さんに　はがきを　出します。	我要寄明信片給松井。	\N	まついさんに　はがきを　だします。	\N	vmod	\N	\N	\N	510	1
2792	封筒に　切手を　はります。	在信封上貼郵票。	\N	ふうとうに　きってを　はります。	\N	vmod	\N	\N	\N	529	1
2793	シャツが　一枚　あります。	有一件襯衫。	\N	しゃつが　いちまい　あります。	\N	vmod	\N	\N	\N	597	1
2794	写真を　二枚　撮りました。	我拍了兩張照片。	\N	しゃしんを　にまい　とりました。	\N	vmod	\N	\N	\N	597	1
2795	銀行は　午前　九時から　午後　三時までです。	銀行從上午九點開到下午三點。	\N	ぎんこうは　ごぜん　くじから　ごご　さんじまでです。	\N	vmod	\N	\N	\N	202	1
2796	松井さんに　お金を　返します。	我要還錢給松井。	\N	まついさんに　おかねを　かえします。	\N	vmod	\N	\N	\N	141	1
2797	図書館に　本を　返します。	我要把書還給圖書館。	\N	としょかんに　ほんを　かえします。	\N	vmod	\N	\N	\N	141	1
2798	お金を　入れて、　ボタンを　押します。	把錢投進去，然後按下按鈕。	\N	おかねを　いれて、　ぼたんを　おします。	\N	vmod	\N	\N	\N	106	1
2799	この　ドアは　押すと、　開きます。	この　どあは　おすと、　あきます。	\N	この　どあは　おすと、　あきます。	\N	vmod	\N	\N	\N	106	1
2800	駅から　十五番の　バスに　乗ります。	從車站搭十五號公車。	\N	えきから　じゅうごばんの　ばすに　のります。	\N	vmod	\N	\N	\N	533	1
2801	この　時計は　千五百円です。	這個時鐘一千五百圓。	\N	この　とけいは　せんごひゃくえんです。	\N	vmod	\N	\N	\N	89	1
2802	三万円で　カメラを　買いました。	我花了三萬圓買相機。	\N	さんまんえんで　かめらを　かいました。	\N	vmod	\N	\N	\N	89	1
2803	あの　人の　名前を　忘れて　しまいました。	我忘了那個人的名字。	\N	あの　ひとの　なまえを　わすれて　しまいました。	\N	vmod	\N	\N	\N	479	1
2804	友だちに　電話番号を　教えました。	ともだちに　でんわばんごうを　おしえました。	\N	ともだちに　でんわばんごうを　おしえました。	\N	vmod	\N	\N	\N	536	1
2805	きょうは　レストランで　晩ごはんを　食べます。	今天要在餐廳吃晚飯。	\N	きょうは　れすとらんで　ばんごはんを　たべます。	\N	vmod	\N	\N	\N	689	1
2806	日本の　食べ物は　おいしいですが、　高いです。	日本的食物雖然好吃，但是很貴。	\N	にほんの　たべものは　おいしいですが、　たかいです。	\N	vmod	\N	\N	\N	380	1
2807	わたしは　パンも　ごはんも　好きです。	我喜歡麵包也喜歡米飯。	\N	わたしは　ぱんも　ごはんも　すきです。	\N	vmod	\N	\N	\N	251	1
2808	今晩は　友達の　うちで　ごはんを　食べます。	今晚我要在朋友家吃飯。	\N	こんばんは　ともだちの　うちで　ごはんを　たべます。	\N	vmod	\N	\N	\N	251	1
2809	きょうの　夕飯は　カレーを　作ろうと　思います。	今天晚餐我打算做咖哩。	\N	きょうの　ゆうはんは　かれーを　つくろうと　おもいます。	\N	vmod	\N	\N	\N	173	1
2810	カレーは　インドの　食べ物です。	咖哩是印度的食物。	\N	かれーは　いんどの　たべものです。	\N	vmod	\N	\N	\N	173	1
2811	わたしは　あまり　お酒を　飲みません。	我不太會喝酒。	\N	わたしは　あまり　おさけを　のみません。	\N	vmod	\N	\N	\N	721	1
2812	スプーンで　コーヒーに　砂糖を　入れます。	用湯匙把糖加到咖啡裡面。	\N	すぷーんで　こーひーに　さとうを　いれます。	\N	vmod	\N	\N	\N	324	1
2813	ケーキを　食べる　とき、　フォークを　使います。	吃蛋糕的時候要用叉子。	\N	けーきを　たべる　とき、　ふぉーくを　つかいます。	\N	vmod	\N	\N	\N	560	1
2814	フランス料理は　ナイフと　フォークを　使って　食べます。	法國料理是用刀叉吃的。	\N	ふらんすりょうりは　ないふと　ふぉーくを　つかって　たべます。	\N	vmod	\N	\N	\N	466	1
2815	危ないので、　ナイフを　使っては　いけません。	不可以用刀子，很危險。	\N	あぶないので、　ないふを　つかっては　いけません。	\N	vmod	\N	\N	\N	466	1
2816	日本人は　はしを　使って、　ごはんを　食べます。	日本人用筷子吃飯。	\N	にほんじんは　はしを　つかって、　ごはんを　たべます。	\N	vmod	\N	\N	\N	513	1
2817	新しい　お皿を　使います。	我要用新盤子。	\N	あたらしい　おさらを　つかいます。	\N	vmod	\N	\N	\N	720	1
2818	わたしは　毎日　朝ごはんを　食べます。	我每天吃早餐。	\N	わたしは　まいにち　あさごはんを　たべます。	\N	vmod	\N	\N	\N	381	1
2819	学校が　終わってから、　友達と　喫茶店で　お茶を　飲みました。	放學後我跟朋友去咖啡店喝茶了。	\N	がっこうが　おわってから、　ともだちと　きっさてんで　おちゃを　のみました。	\N	vmod	\N	\N	\N	187	1
2820	わたしは　毎朝　コーヒーを　飲みます。	我每天早上喝咖啡。	\N	わたしは　まいあさ　こーひーを　のみます。	\N	vmod	\N	\N	\N	237	1
2821	わたしは　コーヒーより　紅茶の　ほうが　好きです。	跟咖啡比起來，我比較喜歡紅茶。	\N	わたしは　こーひーより　こうちゃの　ほうが　すきです。　	\N	vmod	\N	\N	\N	233	1
2822	わたしは　牛乳が　嫌いなので、　あまり　飲みません。	我討厭牛奶，所以不常喝。	\N	わたしは　ぎゅうにゅうが　きらいなので、　あまり　のみません。	\N	vmod	\N	\N	\N	193	1
2823	お酒を　飲んだ　あとは、　水を　飲んだ　ほうが　いいです。	喝過酒之後，喝點水比較好。	\N	おさけを　のんだ　あとは、　みずを　のんだ　ほうが　いいです。	\N	vmod	\N	\N	\N	620	1
2824	飲んだら、　コップを　きれいに　洗います。	喝過之後把杯子洗乾淨。	\N	のんだら、　こっぷを　きれいに　あらいます。	\N	vmod	\N	\N	\N	246	1
2825	友達に　かわいい　カップを　もらいました。	我從朋友那邊收到了一個可愛的杯子。	\N	ともだちに　かわいい　かっぷを　もらいました。	\N	vmod	\N	\N	\N	159	1
2826	わたしは　砂糖を　入れて、　コーヒーを　飲みます。	我喝咖啡的時候習慣加糖。	\N	わたしは　さとうを　いれて、　こーひーを　のみます。	\N	vmod	\N	\N	\N	272	1
2827	スイッチを　入れて、　電気を　つけます。　	すいっちを　いれて、　でんきを　つけます。	\N	すいっちを　いれて、　でんきを　つけます。	\N	vmod	\N	\N	\N	68	1
2828	財布に　お金を　入れます。	把錢放到皮包裡面。	\N	さいふに　おかねを　いれます。	\N	vmod	\N	\N	\N	68	1
2829	松井さんは　わたしに　コーヒーを　入れて　くれました。	松井幫我泡了咖啡。	\N	まついさんは　わたしに　こーひーを　いれて　くれました。	\N	vmod	\N	\N	\N	68	1
2830	この　電車は　東京へ　行きます。	這班電車開往東京。	\N	この　でんしゃは　とうきょうへ　いきます。	\N	vmod	\N	\N	\N	429	1
2831	地下鉄は　安くて、　早くて、　とても　便利です。	地下鐵既便宜又快，很方便。	\N	ちかてつは　やすくて、　はやくて、　とても　べんりです。	\N	vmod	\N	\N	\N	392	1
2832	電車に　乗る　とき、　切符を　買います。	搭電車的時候要買車票。	\N	でんしゃに　のる　とき、　きっぷを　かいます。	\N	vmod	\N	\N	\N	189	1
2833	エレベーターに　乗らないで、　階段を　使います。	我不搭電梯，我要走樓梯。	\N	えれべーたーに　のらないで、　かいだんを　つかいます。	\N	vmod	\N	\N	\N	88	1
2834	お手洗いは　二階に　あります。	洗手間在二樓。	\N	おてあらいは　にかいに　あります。	\N	vmod	\N	\N	\N	109	1
2835	トイレから　出る　とき、　手を　洗います。	從廁所出來的時候要洗手。	\N	といれから　でる　とき、　てを　あらいます。	\N	vmod	\N	\N	\N	434	1
2836	駅の　入口で　切符を　見せます。	在車站入口出示車票。	\N	えきの　いりぐちで　きっぷを　みせます。	\N	vmod	\N	\N	\N	66	1
2837	この　出口を　出ると、　図書館に　一番　近いです。	從這個出口出去離圖書館最近。	\N	この　でぐちを　でると、　としょかんに　いちばん　ちかいです。	\N	vmod	\N	\N	\N	420	1
2838	大使館へ　行くなら、　次の　駅で　降ります。	去大使館的話，要在下個車站下車。	\N	たいしかんへ　いくなら、　つぎの　えきで　おります。	\N	vmod	\N	\N	\N	129	1
2839	学校まで　歩かないで、　バスに　乗ります。	我不走路去學校，我搭公車去。	\N	がっこうまで　あるかないで、　ばすに　のります。	\N	vmod	\N	\N	\N	504	1
2840	スーパーが　閉まって　いたので、　買い物が　できませんでした。	因為超級市場已經關門了，沒辦法買東西。	\N	すーぱーが　しまって　いたので、　かいものが　できませんでした。	\N	vmod	\N	\N	\N	294	1
2841	かばんが　閉まって　いませんでした。	包包沒有關好。	\N	かばんが　しまって　いませんでした。	\N	vmod	\N	\N	\N	294	1
2842	わたしは　松井さんと　クラスが　一緒です。	我跟松井同班。	\N	わたしは　まついさんと　くらすが　いっしょです。	\N	vmod	\N	\N	\N	214	1
2843	教室に　机と　いすが　あります。	教室裡有桌子和椅子。	\N	きょうしつに　つくえと　いすが　あります。	\N	vmod	\N	\N	\N	195	1
2844	玄関と　廊下も　掃除します。	門口跟走廊我都會打掃。	\N	げんかんと　ろうかも　そうじします。	\N	vmod	\N	\N	\N	692	1
2845	わたしは　勉強が　あまり　好きでは　ありません。	我不是很喜歡唸書。	\N	わたしは　べんきょうが　あまり　すきでは　ありません。	\N	vmod	\N	\N	\N	581	1
2846	先週は　忙しかったので、　勉強が　できませんでした。	上個星期因為很忙，都沒有唸書。	\N	せんしゅうは　いそがしかったので、　べんきょうが　できませんでした。	\N	vmod	\N	\N	\N	581	1
3021	寝る　前に　ストーブを　消します。	睡前把暖爐關掉。	\N	ねる　まえに　すとーぶを　けします。	\N	vmod	\N	\N	\N	323	1
2847	ここに　いる　子どもたちは　同じ　学校の　生徒です。	在這裡的小孩子都是同一所學校的學生。	\N	ここに　いる　こどもたちは　おなじ　がっこうの　せいとです。	\N	vmod	\N	\N	\N	332	1
2848	授業中、　先生は　生徒に　質問を　しました。	上課中，老師問了學生問題。	\N	じゅぎょうちゅう、　せんせいは　せいとに　しつもんを　しました。	\N	vmod	\N	\N	\N	332	1
2849	きのう　中国から　来た　留学生と　会いました。	きのう　ちゅうごくから　きた　りゅうがくせいと　あいました。	\N	きのう　ちゅうごくから　きた　りゅうがくせいと　あいました。	\N	vmod	\N	\N	\N	681	1
2850	来月　韓国から　留学生が　来ます。	らいげつ　かんこくから　りゅうがくせいが　きます。	\N	らいげつ　かんこくから　りゅうがくせいが　きます。	\N	vmod	\N	\N	\N	681	1
2851	来週、　わたしは　友達と　東京へ　遊びに　行きます。	下個星期，我要和朋友去東京玩。	\N	らいしゅう、　わたしは　ともだちと　とうきょうへ　あそびに　いきます。	\N	vmod	\N	\N	\N	18	1
2852	きのう　一日　勉強したので、　きょうは　遊びます。	我昨天唸了一整天書，今天要玩。	\N	きのう　いちにち　べんきょうしたので、　きょうは　あそびます。	\N	vmod	\N	\N	\N	18	1
2853	あした　テストが　あるので、　今晩は　勉強します。	因為明天有考試，今晚要唸書。	\N	あした　てすとが　あるので、　こんばんは　べんきょうします。	\N	vmod	\N	\N	\N	580	1
2854	わたしは　松井さんが　書いた　作文を　読みました。	我讀了松井寫的作文。	\N	わたしは　まついさんが　かいた　さくぶんを　よみました。	\N	vmod	\N	\N	\N	267	1
2855	あした　先生に　作文を　出します。	明天我要交作文給老師。	\N	あした　せんせいに　さくぶんを　だします。	\N	vmod	\N	\N	\N	267	1
2856	答えを　書く　ときは、　質問を　よく　読まなければ　なりません。	寫答案的時候要把問題好好看清楚。	\N	こたえを　かく　ときは、　しつもんを　よく　よまなければ　なりません。	\N	vmod	\N	\N	\N	288	1
2857	この　問題は　とても　易しいです。	這個問題很簡單。	\N	この　もんだいは　とても　やさしいです。	\N	vmod	\N	\N	\N	647	1
2858	学校で　毎日　漢字の　テストが　あります。	學校每天都有漢字的考試。	\N	がっこうで　まいにち　かんじの　てすとが　あります。	\N	vmod	\N	\N	\N	421	1
2859	両親が　野球の　練習を　見に　来ました。	りょうしんが　やきゅうの　れんしゅうを　みに　きました。	\N	りょうしんが　やきゅうの　れんしゅうを　みに　きました。	\N	vmod	\N	\N	\N	690	1
2860	たくさん　練習すれば、　日本語が　上手に　なります。	多練習的話，日語就會進步。	\N	たくさん　れんしゅうすれば、　にほんごが　じょうずに　なります。	\N	vmod	\N	\N	\N	691	1
2861	きのうの　テストは　易しかったです。	昨天的考試很簡單。	\N	きのうの　てすとは　やさしかったです。	\N	vmod	\N	\N	\N	651	1
2862	わたしは　外国人に　日本語を　教えて　います。	我在教外國人日語。	\N	わたしは　がいこくじんに　にほんごを　おしえて　います。	\N	vmod	\N	\N	\N	105	1
2863	問題が　難しかったので、　答える　ことが　できませんでした。	因為問題很難，我回答不出來。	\N	もんだいが　むずかしかったので、　こたえる　ことが　できませんでした。	\N	vmod	\N	\N	\N	243	1
2864	学校が　終わった　あと、　毎日　テニスの　練習を　します。	我每天下課後都會去練網球。	\N	がっこうが　おわった　あと、　まいにち　てにすの　れんしゅうを　します。	\N	vmod	\N	\N	\N	690	1
2865	来週、　美容院で　髪を　切ろうと　思って　います。	下個星期我想要去美容院剪頭髮。	\N	らいしゅう、　びよういんで　かみを　きろうと　おもって　います。	\N	vmod	\N	\N	\N	722	1
2866	わたしは　左手で　はしを　持ちます。	我用左手拿筷子。	\N	わたしは　ひだりてで　はしを　もちます。	\N	vmod	\N	\N	\N	544	1
2867	次の　角を　右に　曲がります。	在下一個轉角向右轉。	\N	つぎの　かどを　みぎに　まがります。	\N	vmod	\N	\N	\N	618	1
2868	わたしの　前に　松井さんが　座りました。	我的前面有松井坐著。	\N	わたしの　まえに　まついさんが　すわりました。	\N	vmod	\N	\N	\N	604	1
2869	わたしの　うしろに　たくさんの　人たちが　並んで　います。	我的後面排了很多人。	\N	わたしの　うしろに　たくさんの　ひとたちが　ならんで　います。	\N	vmod	\N	\N	\N	72	1
2870	いつも　この　鉛筆を　使って　いたので、　短く　なりました。	因為老是用這枝鉛筆，都變短了。	\N	いつも　この　えんぴつを　つかって　いたので、　みじかく　なりました。	\N	vmod	\N	\N	\N	619	1
2871	ナイフで　ケーキを　四つに　切ります。	用刀子把蛋糕切成四份。	\N	ないふで　けーきを　よっつに　きります。	\N	vmod	\N	\N	\N	199	1
2872	学校で　松井さんと　一緒に　いる　時間が　一番　長いです。	がっこうで　まついさんと　いっしょに　いる　じかんが　いちばん　ながいです。	\N	がっこうで　まついさんと　いっしょに　いる　じかんが　いちばん　ながいです。	\N	vmod	\N	\N	\N	468	1
2873	わたしの　妹は　背が　低くて、　髪が　長いです。	我妹妹個子小，頭髮長長的。	\N	わたしの　いもうとは　せが　ひくくて、　かみが　ながいです。	\N	vmod	\N	\N	\N	468	1
2874	疲れたので、　座って　休みます。	我累了，要坐下來休息。	\N	つかれたので、　すわって　やすみます。	\N	vmod	\N	\N	\N	330	1
2875	交番で　おまわりさんに　道を　聞きました。	我在派出所向警察先生問了路。	\N	こうばんで　おまわりさんに　みちを　ききました。	\N	vmod	\N	\N	\N	234	1
2876	交番に　町の　地図が　はって　あります。	派出所裡面貼著鎮上的地圖。	\N	こうばんに　まちの　ちずが　はって　あります。	\N	vmod	\N	\N	\N	234	1
2877	交差点に　警官が　たくさん　います。	十字路口有很多警官。	\N	こうさてんに　けいかんが　たくさん　います。	\N	vmod	\N	\N	\N	220	1
2878	わたしは　警官に　名前を　聞かれました。	我被警官問了名字。	\N	わたしは　けいかんに　なまえを　きかれました。	\N	vmod	\N	\N	\N	220	1
2879	おまわりさんが　駅までの　道を　教えて　くれました。	警察先生教我到車站要怎麼走。	\N	おまわりさんが　えきまでの　みちを　おしえて　くれました。	\N	vmod	\N	\N	\N	125	1
2880	道が　分からなかったので、　地図を　見ました。	因為不知道路，我看了地圖。	\N	みちが　わからなかったので、　ちずを　みました。	\N	vmod	\N	\N	\N	393	1
2881	きのう　駅の　近くへ　買い物に　行きました。	昨天我去車站附近買東西。	\N	きのう　えきの　ちかくへ　かいものに　いきました。	\N	vmod	\N	\N	\N	391	1
2882	松井さんに　今夜　行く　レストランの　電話番号を　聞きました。	我向松井問了今晚要去的那家餐廳的電話。	\N	まついさんに　こんや　いく　れすとらんの　でんわばんごうを　ききました。	\N	vmod	\N	\N	\N	183	1
2883	毎日　ラジオで　ニュースを　聞きます。	まいにち　らじおで　にゅーすを　ききます。	\N	まいにち　らじおで　にゅーすを　ききます。	\N	vmod	\N	\N	\N	183	1
2884	その　建物を　左に　曲がると、　病院が　あります。	在那棟建築物那邊往左轉之後，有一家醫院。	\N	その　たてものを　ひだりに　まがると、　びょういんが　あります。	\N	vmod	\N	\N	\N	605	1
2885	危ないので、　ここに　入っては　いけません。	因為很危險，不可以進來這裡。	\N	あぶないので、　ここに　はいっては　いけません。	\N	vmod	\N	\N	\N	32	1
2886	もう　夜　遅いですから、　一人で　帰るのは　危ないです。	已經夜深了，一個人回去很危險。	\N	もう　よる　おそいですから、　ひとりで　かえるのは　あぶないです。	\N	vmod	\N	\N	\N	32	1
2887	授業中に　隣の　人と　話しては　いけません。	上課中不可以和旁邊的人說話。	\N	じゅぎょうちゅうに　となりの　ひとと　はなしては　いけません。	\N	vmod	\N	\N	\N	454	1
2888	その　喫茶店は　本屋の　隣に　あります。	那家咖啡店在書店旁邊。	\N	その　きっさてんは　ほんやの　となりに　あります。	\N	vmod	\N	\N	\N	454	1
2889	松井さんの　うちは　わたしの　うちの　そばです。	松井的家在我家旁邊。	\N	まついさんの　うちは　わたしの　うちの　そばです。	\N	vmod	\N	\N	\N	354	1
2890	わたしの　そばに　置いて　あった　かばんを　松井さんに　渡しました。	我把放在我旁邊的包包交給了松井。	\N	わたしの　そばに　おいて　あった　かばんを　まついさんに　わたしました。	\N	vmod	\N	\N	\N	354	1
2891	財布を　なくしたので、　交番へ　行きます。	因為把錢包弄丟了，我要去派出所。	\N	さいふを　なくしたので、　こうばんへ　いきます。	\N	vmod	\N	\N	\N	471	1
2892	松井さんに　借りた　雑誌を　なくして　しまいました。	我把跟松井借來的雜誌弄丟了。	\N	まついさんに　かりた　ざっしを　なくして　しまいました。	\N	vmod	\N	\N	\N	471	1
2893	友達が　来るので、　部屋を　掃除します。	因為朋友要來，我要打掃房間。	\N	ともだちが　くるので、　へやを　そうじします。	\N	vmod	\N	\N	\N	577	1
2894	この　部屋は　窓が　ありません。	這個房間沒有窗戶。	\N	この　へやは　まどが　ありません。	\N	vmod	\N	\N	\N	613	1
2895	机の　上に　カレンダーが　置いて　あります。	桌子上面放著月曆。	\N	つくえの　うえに　かれんだーが　おいて　あります。	\N	vmod	\N	\N	\N	174	1
2896	デパートで　来年の　カレンダーを　買いました。	我在百貨公司買了明年的月曆。	\N	でぱーとで　らいねんの　かれんだーを　かいました。	\N	vmod	\N	\N	\N	174	1
2897	刺身に　しょうゆを　つけて　食べます。	さしみに　しょうゆを　つけて　たべます。	\N	さしみに　しょうゆを　つけて　たべます。	\N	vmod	\N	\N	\N	407	1
2898	部屋が　暗いので、　電気を　つけます。	因為房間很暗，我要開燈。	\N	へやが　くらいので、　でんきを　つけます。	\N	vmod	\N	\N	\N	407	1
2899	きのうは　疲れて　いたので、　すぐ　寝て　しまいました。	因為昨天很累，我馬上就睡了。	\N	きのうは　つかれて　いたので、　すぐ　ねて　しまいました。	\N	vmod	\N	\N	\N	498	1
2900	時間が　分からなかったので、　教室の　時計を　見ました。	因為不知道時間，我看了教室的鍾。	\N	じかんが　わからなかったので、　きょうしつの　とけいを　みました。	\N	vmod	\N	\N	\N	445	1
2901	部屋の　電気を　つけて　勉強します。	把房間電燈打開然後唸書。	\N	へやの　でんきを　つけて　べんきょうします。	\N	vmod	\N	\N	\N	428	1
2902	玄関に　花瓶が　置いて　あります。	玄關放著花瓶。	\N	げんかんに　かびんが　おいて　あります。	\N	vmod	\N	\N	\N	163	1
2903	寒いので、　ドアを　閉めます。	さむいので、　どあを　しめます。	\N	さむいので、　どあを　しめます。	\N	vmod	\N	\N	\N	433	1
2904	この　ドアは　壊れて　いるので、　開きません。	この　どあは　こわれて　いるので、　あきません。	\N	この　どあは　こわれて　いるので、　あきません。	\N	vmod	\N	\N	\N	433	1
2905	花瓶が　壊れて　しまいました。	かびんが　こわれて　しまいました。	\N	かびんが　こわれて　しまいました。	\N	vmod	\N	\N	\N	163	1
2906	この　道は　とても　狭いので、　危ないです。	這條路因為很窄，很危險。	\N	この　みちは　とても　せまいので、　あぶないです。	\N	vmod	\N	\N	\N	623	1
2907	あの　交差点を　渡って、　左に　曲がります。	走過那個十字路口之後左轉。	\N	あの　こうさてんを　わたって、　ひだりに　まがります。	\N	vmod	\N	\N	\N	232	1
2908	日本の　車は　高いですが、　いいです。	日本車雖然貴但是很好。	\N	にほんの　くるまは　たかいですが、　いいです。	\N	vmod	\N	\N	\N	217	1
2909	外国で　日本の　自動車が　売られて　います。	在國外日本車賣得很好。	\N	がいこくで　にほんの　じどうしゃが　うられて　います。	\N	vmod	\N	\N	\N	290	1
2910	これは　自動車の　雑誌です。	這是汽車雜誌。	\N	これは　じどうしゃの　ざっしです。	\N	vmod	\N	\N	\N	290	1
2911	駅から　会社まで　タクシーに　乗ります。	從車站到公司我搭計程車。	\N	えきから　かいしゃまで　たくしーに　のります。	\N	vmod	\N	\N	\N	369	1
2912	タクシーで　うちへ　帰ります。	我搭計程車回家。	\N	たくしーで　うちへ　かえります。	\N	vmod	\N	\N	\N	369	1
2914	雨が　降っても、　自転車で　行きます。	就算下雨我也要騎腳踏車去。	\N	あめが　ふっても、　じてんしゃで　いきます。	\N	vmod	\N	\N	\N	289	1
2915	きのう　友達と　川へ　行って、　遊びました。	昨天我和朋友去河邊玩了。	\N	きのう　ともだちと　かわへ　いって、　あそびました。	\N	vmod	\N	\N	\N	175	1
2916	うちは　あの　川の　向こうに　あります。	我家在條河川的對面。	\N	うちは　あの　かわの　むこうに　あります。	\N	vmod	\N	\N	\N	175	1
2917	橋を　渡ると、　すぐ　公園が　あります。	過了橋就有一座公園。	\N	はしを　わたると、　すぐ　こうえんが　あります。	\N	vmod	\N	\N	\N	717	1
2918	わたしは　毎朝　散歩に　行きます。	我每天早上都會去散步。	\N	わたしは　まいあさ　さんぽに　いきます。	\N	vmod	\N	\N	\N	277	1
2919	わたしは　毎朝　散歩します。	我每天早上散步。	\N	わたしは　まいあさ　さんぽします。	\N	vmod	\N	\N	\N	718	1
2920	道を　渡って、　左側を　歩きましょう。	過馬路後走左邊吧。	\N	みちを　わたって、　ひだりがわを　あるきましょう。	\N	vmod	\N	\N	\N	701	1
2921	川の　向こうへ　行きたいので、　橋を　渡ります。	因為我想到河的對岸，我要過橋。	\N	かわの　むこうへ　いきたいので、　はしを　わたります。	\N	vmod	\N	\N	\N	701	1
2922	スポーツは　野球が　一番　好きです。	すぽーつは　やきゅうが　いちばん　すきです。	\N	すぽーつは　やきゅうが　いちばん　すきです。	\N	vmod	\N	\N	\N	325	1
2923	暑かったので、　プールで　泳ぎました。	因為很熱，我在游泳池游了泳。	\N	あつかったので、　ぷーるで　およぎました。	\N	vmod	\N	\N	\N	559	1
2924	歌が　下手ですから、　練習しようと　思って　います。	因為我唱歌唱得不好，想要練習。	\N	うたが　へたですから、　れんしゅうしようと　おもって　います。	\N	vmod	\N	\N	\N	574	1
2925	弟は　サッカーが　上手なので、　教えて　もらいました。	因為弟弟很會踢足球，我叫他教我了。	\N	おとうとは　さっかーが　じょうずなので、　おしえて　もらいました。	\N	vmod	\N	\N	\N	304	1
2926	松井さんは　料理が　上手です。	松井很會煮菜。	\N	まついさんは　りょうりが　じょうずです。	\N	vmod	\N	\N	\N	304	1
2927	わたしは　絵を　書くのが　下手です。	我很不會畫畫。	\N	わたしは　えを　かくのが　へたです。	\N	vmod	\N	\N	\N	574	1
2928	学校まで　バスより　電車の　ほうが　速いと　思います。	到學校我覺得電車比公車快。	\N	がっこうまで　ばすより　でんしゃの　ほうが　はやいと　おもいます。	\N	vmod	\N	\N	\N	716	1
2929	松井さんは　走るのが　速いです。	松井跑得很快。	\N	まついさんは　はしるのが　はやいです。	\N	vmod	\N	\N	\N	716	1
2930	もう　遅いので、　家へ　帰ります。	もう　おそいので、　いえへ　かえります。	\N	もう　おそいので、　いえへ　かえります。	\N	vmod	\N	\N	\N	107	1
2931	わたしは　歩くのが　とても　遅いです。	我走路走得很慢。	\N	わたしは　あるくのが　とても　おそいです。	\N	vmod	\N	\N	\N	107	1
2932	大学の　前に　大きな　本屋が　できました。	だいがくの　まえに　おおきな　ほんやが　できました。	\N	だいがくの　まえに　おおきな　ほんやが　できました。	\N	vmod	\N	\N	\N	418	1
2933	足が　痛いので、　もう　走れません。	因為腳痛，我跑不動了。	\N	あしが　いたいので、　もう　はしれません。	\N	vmod	\N	\N	\N	517	1
2934	向こうの　空を　鳥が　飛んで　います。	一隻鳥正朝著那邊的天空飛。	\N	むこうの　そらを　とりが　とんで　います。	\N	vmod	\N	\N	\N	456	1
2935	来年　海外を　旅行しようと　思って　います。	明年我想去國外旅行。	\N	らいねん　かいがいを　りょこうしようと　おもって　います。	\N	vmod	\N	\N	\N	685	1
2936	わたしは　英語が　話せます。	我會說英語。	\N	わたしは　えいごが　はなせます。	\N	vmod	\N	\N	\N	85	1
2937	辞書を　使って、　英語を　勉強します。	用字典學英文。	\N	じしょを　つかって、　えいごを　べんきょうします。	\N	vmod	\N	\N	\N	85	1
2938	あの　人は　この　大学の　外国人教師です。	あの　ひとは　この　だいがくの　がいこくじんきょうしです。	\N	あの　ひとは　この　だいがくの　がいこくじんきょうしです。	\N	vmod	\N	\N	\N	136	1
2939	あした　外国人の　友達と　会います。	我明天要去見一個國外的朋友。	\N	あした　がいこくじんの　ともだちと　あいます。	\N	vmod	\N	\N	\N	136	1
2940	あの　交差点を　右に　曲がると、　大使館が　あります。	在那個十字路口右轉之後，有一間大使館。	\N	あの　こうさてんを　みぎに　まがると、　たいしかんが　あります。	\N	vmod	\N	\N	\N	361	1
2941	わたしは　あした　大使館へ　行きます。	我明天要去大使館。	\N	わたしは　あした　たいしかんへ　いきます。	\N	vmod	\N	\N	\N	361	1
2942	夏休みは　国へ　帰ります。	なつやすみは　くにへ　かえります。	\N	なつやすみは　くにへ　かえります。	\N	vmod	\N	\N	\N	210	1
2943	日本は　狭い　国です。	日本是個狹小的國家。	\N	にほんは　せまい　くにです。	\N	vmod	\N	\N	\N	210	1
2944	この　ホテルの　部屋は　とても　きれいです。	這家飯店的房間很乾淨。	\N	この　ほてるの　へやは　とても　きれいです。	\N	vmod	\N	\N	\N	593	1
2945	来年　海外へ　旅行に　行こうと　思って　います。	らいねん　かいがいへ　りょこうに　いこうと　おもって　います。	\N	らいねん　かいがいへ　りょこうに　いこうと　おもって　います。	\N	vmod	\N	\N	\N	715	1
2946	松井さんは　海外に　三年間　住んで　いました。	松井住在國外三年了。	\N	まついさんは　かいがいに　さんねんかん　すんで　いました。	\N	vmod	\N	\N	\N	715	1
2947	来年　海外へ　旅行に　行こうと　思って　います。	明年我想要去國外旅行。	\N	らいねん　かいがいへ　りょこうに　いこうと　おもって　います。	\N	vmod	\N	\N	\N	684	1
2948	本屋で　旅行の　本を　買いました。	我在書店買了旅遊書。	\N	ほんやで　りょこうの　ほんを　かいました。	\N	vmod	\N	\N	\N	684	1
2949	きょう　この　店は　肉が　安いです。	今天這家店肉很便宜。	\N	きょう　この　みせは　にくが　やすいです。	\N	vmod	\N	\N	\N	621	1
2950	あそこに　たくさん　店が　並んで　います。	那邊有很多家店。	\N	あそこに　たくさん　みせが　ならんで　います。	\N	vmod	\N	\N	\N	621	1
2951	わたしは　果物や　野菜は　八百屋で　買います。	水果跟蔬菜我都在蔬菜店買。	\N	わたしは　くだものや　やさいは　やおやで　かいます。	\N	vmod	\N	\N	\N	649	1
2952	スーパーより　八百屋の　ほうが　安いです。	蔬菜店比超級市場便宜。	\N	すーぱーより　やおやの　ほうが　やすいです。	\N	vmod	\N	\N	\N	649	1
2953	きのうの　晩ごはんは　肉料理でした。	昨天的晚飯是用肉做的菜。	\N	きのうの　ばんごはんは　にくりょうりでした。	\N	vmod	\N	\N	\N	486	1
2954	わたしは　肉より　魚の　ほうが　好きです。	跟肉比起來我比較喜歡魚。	\N	わたしは　にくより　さかなの　ほうが　すきです。	\N	vmod	\N	\N	\N	486	1
2955	牛肉は　肉の　中で　一番　高いです。	牛肉是所有的肉裡面最貴的。	\N	ぎゅうにくは　にくの　なかで　いちばん　たかいです。	\N	vmod	\N	\N	\N	192	1
2956	わたしは　ぶた肉が　食べられません。	我不能吃豬肉。	\N	わたしは　ぶたにくが　たべられません。	\N	vmod	\N	\N	\N	563	1
2957	とり肉は　安いですが、　牛肉の　ほうが　おいしいです。	雞肉雖然比較便宜，但是牛肉比較好吃。	\N	とりにくは　やすいですが、　ぎゅうにくの　ほうが　おいしいです。	\N	vmod	\N	\N	\N	461	1
2958	海に　近い　ところでは、　魚が　おいしいです。	靠近海的地方魚都很好吃。	\N	うみに　ちかい　ところでは、　さかなが　おいしいです。	\N	vmod	\N	\N	\N	264	1
2959	冷蔵庫の　中に　野菜や　卵が　あります。	冰箱裡面有蔬菜跟雞蛋。	\N	れいぞうこの　なかに　やさいや　たまごが　あります。	\N	vmod	\N	\N	\N	650	1
2960	野菜を　切って、　洗います。	把蔬菜切一切，然後洗一洗。	\N	やさいを　きって、　あらいます。	\N	vmod	\N	\N	\N	650	1
2961	わたしは　毎朝　野菜と　果物を　食べます。	我每天早上吃蔬菜跟水果。	\N	わたしは　まいあさ　やさいと　くだものを　たべます。	\N	vmod	\N	\N	\N	206	1
2962	車は　高いですが、　便利です。	車子貴，但是很方便。	\N	くるまは　たかいですが、　べんりです。	\N	vmod	\N	\N	\N	729	1
2963	その　スカートを　見せて　ください。	その　すかーとを　みせて　ください。	\N	その　すかーとを　みせて　ください。	\N	vmod	\N	\N	\N	723	1
2964	一番　安い　魚を　２匹　ください。	いちばん　やすい　さかなを　にひき　ください。	\N	いちばん　やすい　さかなを　にひき　ください。	\N	vmod	\N	\N	\N	723	1
2965	図書館で　本を　三冊　借りました。	我在圖書館借了三本書。	\N	としょかんで　ほんを　さんさつ　かりました。	\N	vmod	\N	\N	\N	270	1
2966	図書館は　午前　九時から　午後　八時までです。	圖書館從上午九點開到下午八點。	\N	としょかんは　ごぜん　くじから　ごご　はちじまでです。　	\N	vmod	\N	\N	\N	449	1
2967	図書館に　本棚が　たくさん　並んで　います。	圖書館裡排放著很多書架。	\N	としょかんに　ほんだなが　たくさん　ならんで　います。	\N	vmod	\N	\N	\N	595	1
2968	辞書は　あそこの　本棚に　あります。	字典在那邊的書架上。	\N	じしょは　あそこの　ほんだなに　あります。	\N	vmod	\N	\N	\N	595	1
2969	雑誌は　図書館で　借りる　ことが　できません。	雜誌不能在圖書館借。	\N	ざっしは　としょかんで　かりる　ことが　できません。	\N	vmod	\N	\N	\N	271	1
2970	この　雑誌は　おもしろいです。	這本雜誌很有趣。	\N	この　ざっしは　おもしろいです。	\N	vmod	\N	\N	\N	271	1
2971	それは　きょうの　新聞です。	這是今天的報紙。	\N	それは　きょうの　しんぶんです。	\N	vmod	\N	\N	\N	312	1
2972	松井さんに　コピーした　紙を　渡しました。	まついさんに　こぴーした　かみを　わたしました。	\N	まついさんに　こぴーした　かみを　わたしました。	\N	vmod	\N	\N	\N	253	1
2973	これを　五枚　コピーします。	把這個影印五張。	\N	これを　ごまい　こぴーします。	\N	vmod	\N	\N	\N	253	1
2974	辞書を　見て、　日本語を　勉強します。	我看字典學日文。	\N	じしょを　みて、　にほんごを　べんきょうします。	\N	vmod	\N	\N	\N	284	1
2975	図書館で　本を　コピーしました。	我在圖書館把書影印了。	\N	としょかんで　ほんを　こぴーしました。	\N	vmod	\N	\N	\N	253	1
2976	先生は　学生に　新聞の　コピーを　渡しました。	老師把報紙的影印交了給學生。	\N	せんせいは　がくせいに　しんぶんの　こぴーを　わたしました。	\N	vmod	\N	\N	\N	252	1
2977	林さんは　コンピューターの　会社で　働いて　います。	林先生(小姐)在電腦公司上班。	\N	はやしさんは　こんぴゅーたーの　かいしゃで　はたらいて　います。	\N	vmod	\N	\N	\N	137	1
2978	あしたは　早く　会社へ　行きます。	我明天要早一點去公司。	\N	あしたは　はやく　かいしゃへ　いきます。	\N	vmod	\N	\N	\N	137	1
2979	休みの　日は　友達と　出かけます。	放假我和朋友出去。	\N	やすみの　ひは　ともだちと　でかけます。	\N	vmod	\N	\N	\N	653	1
2980	会社へ　行く　とき、　スーツを　着て、　ネクタイを　します。	かいしゃへ　いく　とき、　すーつを　きて、　ねくたいを　します。	\N	かいしゃへ　いく　とき、　すーつを　きて、　ねくたいを　します。	\N	vmod	\N	\N	\N	496	1
2981	これは　イタリアの　ネクタイです。	這是義大利的領帶。	\N	これは　いたりあの　ねくたいです。	\N	vmod	\N	\N	\N	496	1
2982	この　部屋で　たばこを　吸っては　いけません。	不可以在這個房間吸菸。	\N	この　へやで　たばこを　すっては　いけません。	\N	vmod	\N	\N	\N	378	1
2983	毎日　忙しいので、　あまり　休む　ことが　できません。	因為每天都很忙，不太能休息。	\N	まいにち　いそがしいので、　あまり　やすむ　ことが　できません。	\N	vmod	\N	\N	\N	51	1
2984	仕事は　忙しいですが、　おもしろいです。	雖然工作很忙，不過很有趣。	\N	しごとは　いそがしいですが、　おもしろいです。	\N	vmod	\N	\N	\N	51	1
2985	仕事で　人と　会うので、　ネクタイを　します。	しごとで　ひとと　あうので、　ねくたいを　します。	\N	しごとで　ひとと　あうので、　ねくたいを　します。	\N	vmod	\N	\N	\N	760	1
2986	先週の　休みは　何も　しませんでした。	上星期的假日我什麼也沒做。	\N	せんしゅうの　やすみは　なにも　しませんでした。	\N	vmod	\N	\N	\N	760	1
2987	わたしは　自動車の　会社に　勤めて　います。	我在汽車公司上班。	\N	わたしは　じどうしゃの　かいしゃに　つとめて　います。	\N	vmod	\N	\N	\N	408	1
2988	わたしは　たばこを　吸います。	我抽菸。	\N	わたしは　たばこを　すいます。	\N	vmod	\N	\N	\N	314	1
2989	たばこを　吸うと、　体に　悪いです。	抽菸的話對身體不好。	\N	たばこを　すうと、　からだに　わるいです。	\N	vmod	\N	\N	\N	314	1
2990	長い　時間　仕事を　して　いたので、　少し　休みます。	ながい　じかん　しごとを　して　いたので、　すこし　やすみます。	\N	ながい　じかん　しごとを　して　いたので、　すこし　やすみます。	\N	vmod	\N	\N	\N	654	1
2991	熱が　あるので、　きょうは　学校を　休みます。	因為發燒了，今天我跟學校請假。	\N	ねつが　あるので、　きょうは　がっこうを　やすみます。	\N	vmod	\N	\N	\N	654	1
2992	わたしは　日曜日も　働いて　います。	我星期天也工作。	\N	わたしは　にちようびも　はたらいて　います。	\N	vmod	\N	\N	\N	521	1
2993	毎日　八時間　働きます。	每天工作八個小時。	\N	まいにち　はちじかん　はたらきます。	\N	vmod	\N	\N	\N	521	1
2994	向こうの　道に　家が　たくさん　並んで　います。	那邊的街道有很多房子。	\N	むこうの　みちに　いえが　たくさん　ならんで　います。	\N	vmod	\N	\N	\N	43	1
2995	あしたの　朝　洗濯を　しなければ　なりません。	我早上不能不洗衣服。	\N	あしたの　あさ　せんたくを　しなければ　なりません。	\N	vmod	\N	\N	\N	342	1
2996	暑かったので、　家へ　帰って、　シャワーを　浴びました。	因為很熱，回家沖個澡吧。	\N	あつかったので、　いえへ　かえって、　しゃわーを　あびました。	\N	vmod	\N	\N	\N	299	1
2997	毎晩　シャワーを　浴びてから、　寝ます。	我每天晚上都淋浴過後才睡覺。	\N	まいばん　しゃわーを　あびてから、　ねます。	\N	vmod	\N	\N	\N	31	1
2998	家へ　帰ったら、　掃除しようと　思います。	回到家之後我打算打掃。	\N	いえへ　かえったら、　そうじしようと　おもいます。	\N	vmod	\N	\N	\N	347	1
2999	あしたの　朝　洗濯しなければ　なりません。	明天早上不能不洗衣服。	\N	あしたの　あさ　せんたくしなければ　なりません。	\N	vmod	\N	\N	\N	343	1
3000	あしたの　夜は　友達と　会うので、　出かけます。　	明天晚上我要和朋友見面，所以要出門了。	\N	あしたの　よるは　ともだちと　あうので、　でかけます。	\N	vmod	\N	\N	\N	416	1
3001	きのうは　どこも　出かけませんでした。	昨天我哪裡都沒去。	\N	きのうは　どこも　でかけませんでした。	\N	vmod	\N	\N	\N	416	1
3002	この　料理は　家庭で　作れます。	這道菜在家裡也可以做。	\N	この　りょうりは　かていで　つくれます。	\N	vmod	\N	\N	\N	160	1
3003	かぜを　ひいたので、 家で　寝て　いました。	因為感冒了，我在家裡睡覺。	\N	かぜを　ひいたので、　いえで　ねて　いました。	\N	vmod	\N	\N	\N	761	1
3004	この　歌が　いちばん　好きです。	この　うたが　いちばん　すきです。	\N	この　うたが　いちばん　すきです。	\N	vmod	\N	\N	\N	74	1
3005	松井さんは　ギターを　弾く　ことが　できます。	松井會彈吉他。	\N	まついさんは　ぎたーを　ひく　ことが　できます。	\N	vmod	\N	\N	\N	185	1
3006	わたしは　毎日　ピアノを　練習します。	我每天練習鋼琴。	\N	わたしは　まいにち　ぴあのを　れんしゅうします。	\N	vmod	\N	\N	\N	759	1
3007	この　カメラは　高いですが、　とても　便利です。	這個照相機雖然貴，但是很方便。	\N	この　かめらは　たかいですが、　とても　べんりです。	\N	vmod	\N	\N	\N	166	1
3008	新しい　カメラを　買いました。	我買了新的照相機。	\N	あたらしい　かめらを　かいました。	\N	vmod	\N	\N	\N	166	1
3009	これは　日本の　古い　映画です。	這是日本的老電影。	\N	これは　にほんの　ふるい　えいがです。	\N	vmod	\N	\N	\N	83	1
3010	妹は　絵が　上手です。	妹妹很會畫畫。	\N	いもうとは　えが　じょうずです。	\N	vmod	\N	\N	\N	82	1
3011	松井さんは　たばこが　嫌いなので、　吸いません。	松井不喜歡香菸所以不抽。	\N	まついさんは　たばこが　きらいなので、　すいません。	\N	vmod	\N	\N	\N	198	1
3012	わたしは　掃除や　洗濯が　嫌いです。	我討厭打掃和洗衣服。	\N	わたしは　そうじや　せんたくが　きらいです。	\N	vmod	\N	\N	\N	198	1
3013	わたしの　好きな　食べ物は　カレーです。	我喜歡的食物是咖哩。	\N	わたしの　すきな　たべものは　かれーです。	\N	vmod	\N	\N	\N	316	1
3014	母は　料理が　好きです。	媽媽喜歡做菜。	\N	ははは　りょうりが　すきです。	\N	vmod	\N	\N	\N	316	1
3015	カラオケで　よく　この　歌を　歌います。	我在卡拉OK常常唱這首歌。	\N	からおけで　よく　この　うたを　うたいます。	\N	vmod	\N	\N	\N	75	1
3016	わたしは　来月の　コンサートで　ピアノを　弾きます。	我下個月要在演奏會上彈鋼琴。	\N	わたしは　らいげつの　こんさーとで　ぴあのを　ひきます。	\N	vmod	\N	\N	\N	541	1
3017	旅行で　たくさん　写真を　撮りました。	旅行時照了很多相片。	\N	りょこうで　たくさん　しゃしんを　とりました。	\N	vmod	\N	\N	\N	462	1
3018	わたしは　いつも　ベッドで　寝ます。	我都在床上睡覺。	\N	わたしは　いつも　べっどで　ねます。	\N	vmod	\N	\N	\N	575	1
3019	ストーブを　つけると、　暖かいです。	打開暖爐後，很暖和。	\N	すとーぶを　つけると、　あたたかいです。	\N	vmod	\N	\N	\N	323	1
3020	寝る　前に、　ストーブを　消します。	ねる　まえに、　すとーぶを　けします。	\N	ねる　まえに、　すとーぶを　けします。	\N	vmod	\N	\N	\N	323	1
3022	テストの　答えを　ボールペンで　書きます。	考試的答案用原子筆寫。	\N	てすとの　こたえを　ぼーるぺんで　かきます。	\N	vmod	\N	\N	\N	586	1
3023	あしたの　天気は　雨です。	明天的天氣是下雨。	\N	あしたの　てんきは　あめです。	\N	vmod	\N	\N	\N	427	1
3024	きょうは　とても　天気が　いいです。	今天天氣非常好。	\N	きょうは　とても　てんきが　いいです。	\N	vmod	\N	\N	\N	427	1
3025	あした　晴れだったら、　テニスを　しましょう。	明天放晴的話，去打網球吧。	\N	あした　はれだったら、　てにすを　しましょう。	\N	vmod	\N	\N	\N	530	1
3026	あしたは　曇りだそうです。	聽說明天會是陰天。	\N	あしたは　くもりだそうです。	\N	vmod	\N	\N	\N	211	1
3027	きのうは　ずっと　曇りでした。	昨天一整天都是陰天。	\N	きのうは　ずっと　くもりでした。	\N	vmod	\N	\N	\N	211	1
3028	雨だったら、　休みの　日は　出かけません。	如果下雨，假日我也不會出門。	\N	あめだったら、　やすみの　ひは　でかけません。	\N	vmod	\N	\N	\N	710	1
3029	あしたは　雨なので、　バスで　学校へ　行きます。	因為明天會下雨，我要搭公車去學校。	\N	あしたは　あめなので、　ばすで　がっこうへ　いきます。	\N	vmod	\N	\N	\N	710	1
3030	きょうは　風が　ありません。	今天沒有風。	\N	きょうは　かぜが　ありません。	\N	vmod	\N	\N	\N	711	1
3031	風の　強い　日は　テニスが　できません。	かぜの　つよい　ひは　てにすが　できません。	\N	かぜの　つよい　ひは　てにすが　できません。	\N	vmod	\N	\N	\N	711	1
3032	雪の　日に　出かけるのは　危ないです。	ゆきの　ひに　でかけるのは　あぶないです。	\N	ゆきの　ひに　でかけるのは　あぶないです。	\N	vmod	\N	\N	\N	663	1
3033	少し　暑いので、　窓を　開けます。	すこし　あついので、　まどを　あけます。	\N	すこし　あついので、　まどを　あけます。	\N	vmod	\N	\N	\N	712	1
3034	日本の　夏は　暑いです。	日本的夏天很熱。	\N	にほんの　なつは　あついです。	\N	vmod	\N	\N	\N	712	1
3035	春に　なると、　暖かく　なります。	到了春天就會變暖。	\N	はるに　なると、　あたたかく　なります。	\N	vmod	\N	\N	\N	19	1
3036	きょうは　とても　暖かいので、　散歩に　行きます。	因為今天很暖和，我要去散步。	\N	きょうは　とても　あたたかいので、　さんぽに　いきます。	\N	vmod	\N	\N	\N	19	1
3037	あしたは　暑く　なるので、　プールで　泳ごうと　思います。	因為明天會變熱，我想去游泳池游泳。	\N	あしたは　あつく　なるので、　ぷーるで　およごうと　おもいます。	\N	vmod	\N	\N	\N	712	1
3038	窓を　開けたら、　少し　涼しく　なりました。	打開窗戶之後，有點變涼了。	\N	まどを　あけたら、　すこし　すずしく　なりました。	\N	vmod	\N	\N	\N	321	1
3039	秋は　涼しいです。	秋天很涼爽。	\N	あきは　すずしいです。	\N	vmod	\N	\N	\N	321	1
3040	朝は　雨でしたが、　今は　晴れて　います。	早上雖然下雨，現在放晴了。	\N	あさは　あめでしたが、　いまは　はれて　います。	\N	vmod	\N	\N	\N	531	1
3041	あした　晴れたら、　テニスを　しましょう。	明天天氣好的話去打網球吧。	\N	あした　はれたら、　てにすを　しましょう。	\N	vmod	\N	\N	\N	531	1
3042	去年は　あまり　雪が　降りませんでした。	去年沒下什麼雪。	\N	きょねんは　あまり　ゆきが　ふりませんでした。	\N	vmod	\N	\N	\N	568	1
3043	風が　吹いて　いて、　寒いです。	風一直吹著，很冷。	\N	かぜが　ふいて　いて、　さむいです。	\N	vmod	\N	\N	\N	713	1
3044	あしたは　強い　風が　吹くそうです。	明天好像會颳強風。	\N	あしたは　つよい　かぜが　ふくそうです。	\N	vmod	\N	\N	\N	713	1
3045	あしたは　三十度まで　上がるので、　暑いです。	明天氣溫會升到三十度，很熱。	\N	あしたは　さんじゅうどまで　あがるので、　あついです。	\N	vmod	\N	\N	\N	432	1
3046	かぜで　熱が　三十八度　あります。	因為感冒，發燒到三十八度。	\N	かぜで　ねつが　さんじゅうはちど　あります。	\N	vmod	\N	\N	\N	432	1
3047	空が　少し　曇って　きました。	天空開始有點變陰了。	\N	そらが　すこし　くもって　きました。	\N	vmod	\N	\N	\N	212	1
3048	きのうは　ずっと　曇って　いました。	昨天一整天都是陰陰的。	\N	きのうは　ずっと　くもって　いました。	\N	vmod	\N	\N	\N	212	1
3049	夜は　寒く　なるので、　コートを　持って　出かけます。	よるは　さむく　なるので、　こーとを　もって　でかけます。	\N	よるは　さむく　なるので、　こーとを　もって　でかけます。	\N	vmod	\N	\N	\N	273	1
3050	わたしは　この　歌が　いちばん　好きです。	我最喜歡這首歌。	\N	わたしは　この　うたが　いちばん　すきです。	\N	vmod	\N	\N	\N	74	1
3051	雪の　日は　出かけません。	下雪的日子我不出門。	\N	ゆきの　ひは　でかけません。	\N	vmod	\N	\N	\N	663	1
3052	風が　強い　日は　テニスが　できません。	風很強的日子沒有辦法打網球。	\N	かぜが　つよい　ひは　てにすが　できません。	\N	vmod	\N	\N	\N	711	1
3053	夜は　寒いので、　コートを　持って　出かけます。	晚上很冷，所以我要帶件外套出門。	\N	よるは　さむいので、　こーとを　もって　でかけます。	\N	vmod	\N	\N	\N	273	1
3054	あの　美容師は　きれいで　細いです。	あの　びようしは　きれいで　ほそいです。	\N	あの　びようしは　きれいで　ほそいです。	\N	vmod	\N	\N	\N	762	1
3055	大学を　出たら、　美容師に　なりたいです。	だいがくを　でたら、　びようしに　なりたいです。	\N	だいがくを　でたら、　びようしに　なりたいです。	\N	vmod	\N	\N	\N	762	1
3056	髪を　切る　前に　シャンプーを　します。	剪頭髮以前先洗頭。	\N	かみを　きる　まえに　しゃんぷーを　します。	\N	vmod	\N	\N	\N	763	1
3057	あの　髪が　黒い　人は　松井さんです。	那個黑頭髮的人是松井。	\N	あの　かみが　くろい　ひとは　まついさんです。	\N	vmod	\N	\N	\N	764	1
3058	電車の　ドアが　閉まります。	電車門要關了。	\N	でんしゃの　どあが　しまります。	\N	vmod	\N	\N	\N	433	1
3059	わたしは　駅員に　切符を　見せました。	我把車票拿給站務人員看。	\N	わたしは　えきいんに　きっぷを　みせました。	\N	vmod	\N	\N	\N	765	1
3060	わたしは　きのう　髪を　切りました。	我昨天去剪頭髮了。	\N	わたしは　きのう　かみを　きりました。	\N	vmod	\N	\N	\N	199	1
3061	この　箱は　横が　長いです。	この　はこは　よこが　ながいです。	\N	この　はこは　よこが　ながいです。	\N	vmod	\N	\N	\N	668	1
3062	美容院は　駅の　横に　あります。	美容院在車站旁邊。	\N	びよういんは　えきの　よこに　あります。	\N	vmod	\N	\N	\N	668	1
3063	今晩は　図書館で　宿題を　します。	今晚我要在圖書館寫作業。	\N	こんばんは　としょかんで　しゅくだいを　します。	\N	vmod	\N	\N	\N	303	1
3064	ここに　答えを　書きます。	把答案寫在這裡。	\N	ここに　こたえを　かきます。	\N	vmod	\N	\N	\N	766	1
3065	来月　中国から　留学生が　来ます。	下個月有留學生要從中國過來。	\N	らいげつ　ちゅうごくから　りゅうがくせいが　きます。	\N	vmod	\N	\N	\N	681	1
3066	あの　人は　この　学校の　留学生です。	那個人是這所學校的留學生。	\N	あの　ひとは　この　がっこうの　りゅうがくせいです。	\N	vmod	\N	\N	\N	681	1
3067	あした　友達と　映画を　見に　行きます。	明天要和朋友去看電影。	\N	あした　ともだちと　えいがを　みに　いきます。	\N	vmod	\N	\N	\N	458	1
3068	きのうの　テストは　とても　難しかったです。	昨天的考試很難。	\N	きのうの　てすとは　とても　むずかしかったです。	\N	vmod	\N	\N	\N	421	1
3069	あの　先生の　授業は　おもしろいです。	那個老師的課很有趣。	\N	あの　せんせいの　じゅぎょうは　おもしろいです。	\N	vmod	\N	\N	\N	302	1
3070	あの　美容師は　細くて、　きれいです。	那位美容師既苗條、又漂亮。	\N	あの　びようしは　ほそくて、　きれいです。	\N	vmod	\N	\N	\N	762	1
3071	学校を　出たら、　美容師に　なりたいです。	出了學校之後，我想當美容師。	\N	がっこうを　でたら、　びようしに　なりたいです。	\N	vmod	\N	\N	\N	762	1
3072	この　箱は　縦が　短くて、　横が　長いです。	這個箱子高度較短，寬度較長。	\N	この　はこは　たてが　みじかくて、　よこが　ながいです。	\N	vmod	\N	\N	\N	668	1
3073	きのうは　会社を　休んで、　病院へ　行きました。	昨天我向公司請假，去醫院看病了。	\N	きのうは　かいしゃを　やすんで、　びょういんへ　いきました。	\N	vmod	\N	\N	\N	551	1
3074	熱が　あるので、　きょうは　休みます。	因為發燒了，今天我要休息。	\N	ねつが　あるので、　きょうは　やすみます。	\N	vmod	\N	\N	\N	757	1
3075	テーブルの　上に　花瓶が　あります。	桌子上面有花瓶。	\N	てーぶるの　うえに　かびんが　あります。	\N	vmod	\N	\N	\N	414	1
3076	毎日　ラジオで　ニュースを　聞きます。	我每天用收音機聽新聞。	\N	まいにち　らじおで　にゅーすを　ききます。	\N	vmod	\N	\N	\N	771	1
3077	友達に　木村さんの　電話番号を　教えました。	我把木村的電話號碼告訴朋友了。	\N	ともだちに　きむらさんの　でんわばんごうを　おしえました。	\N	vmod	\N	\N	\N	767	1
3078	母から　連絡が　なかったので、　心配しました。	因為沒有媽媽的消息，我好擔心。	\N	ははから　れんらくが　なかったので、　しんぱいしました。	\N	vmod	\N	\N	\N	768	1
3079	きのう　松井さんから　連絡が　ありました。	昨天有從松井那邊來的連絡。	\N	きのう　まついさんから　れんらくが　ありました。	\N	vmod	\N	\N	\N	768	1
3080	電話で　会社に　連絡して　ください。	請打電話跟公司連絡。	\N	でんわで　かいしゃに　れんらくして　ください。	\N	vmod	\N	\N	\N	769	1
3081	家に　着いたら、　連絡します。	到家的話會跟你聯絡。	\N	いえに　ついたら、　れんらくします。	\N	vmod	\N	\N	\N	769	1
3082	なくした　時計が　見つかりました。	不見的手錶找到了。	\N	なくした　とけいが　みつかりました。	\N	vmod	\N	\N	\N	770	1
3083	よく　探せば、　見つかります。	好好找就能找到。	\N	よく　さがせば、　みつかります。	\N	vmod	\N	\N	\N	770	1
3084	この　アパートは　家賃が　高いです。	這間公寓房租很貴。	\N	この　あぱーとは　やちんが　たかいです。	\N	vmod	\N	\N	\N	772	1
3085	かぎが　ないので、　かばんの　中を　探しました。	かぎが　ないので、　かばんの　なかを　さがしました。	\N	かぎが　ないので、　かばんの　なかを　さがしました。	\N	vmod	\N	\N	\N	773	1
3086	もっと　安い　部屋を　探そうと　思います。	我想找更便宜一點的房間。	\N	もっと　やすい　へやを　さがそうと　おもいます。	\N	vmod	\N	\N	\N	773	1
3087	かぎが　見つからないので、　かばんの　中を　探しました。	因為找不到鑰匙，我翻了一下包包。	\N	かぎが　みつからないので、　かばんの　なかを　さがしました。	\N	vmod	\N	\N	\N	773	1
3088	たばこを　吸う　とき、　灰皿を　使います。	抽菸的時候用菸灰缸。	\N	たばこを　すう　とき、　はいざらを　つかいます。	\N	vmod	\N	\N	\N	508	1
3089	テーブルの　上に　灰皿が　あります。	桌子上面有菸灰缸。	\N	てーぶるの　うえに　はいざらが　あります。	\N	vmod	\N	\N	\N	508	1
3090	あの　食堂の　定食は　安くて　おいしいです。	あの　しょくどうの　ていしょくは　やすくて　おいしいです。	\N	あの　しょくどうの　ていしょくは　やすくて　おいしいです。	\N	vmod	\N	\N	\N	775	1
3091	昼ごはんは　いつも　この　定食を　食べます。	午餐我總是吃這個套餐。	\N	ひるごはんは　いつも　この　ていしょくを　たべます。	\N	vmod	\N	\N	\N	775	1
3092	あの　食堂の　定食は　安くて、　おいしいです。	那家食堂的套餐便宜又好吃。	\N	あの　しょくどうの　ていしょくは　やすくて、　おいしいです。	\N	vmod	\N	\N	\N	775	1
3093	店員に　食べ物を　頼みました。	我向店員點了吃的。	\N	てんいんに　たべものを　たのみました。	\N	vmod	\N	\N	\N	774	1
3094	この　レストランの　店員は　忙しそうです。	這家餐廳的店員看起來好像很忙。	\N	この　れすとらんの　てんいんは　いそがしそうです。	\N	vmod	\N	\N	\N	774	1
3095	わたしは　ミルクを　入れないで、　コーヒーを　飲みます。	我喝不加牛奶的咖啡。	\N	わたしは　みるくを　いれないで、　こーひーを　のみます。	\N	vmod	\N	\N	\N	776	1
3096	毎朝　パンを　食べて、　ミルクを　飲みます。	我每天早上吃麵包、喝牛奶。	\N	まいあさ、　ぱんを　たべて、　みるくを　のみます。	\N	vmod	\N	\N	\N	776	1
3097	靴下の　売り場は　一階に　あります。	襪子的賣場在一樓。	\N	くつしたの　うりばは　いっかいに　あります。	\N	vmod	\N	\N	\N	780	1
3098	この　かばんは　カードで　買いました。	這個包包是刷卡買的。	\N	この　かばんは　かーどで　かいました。	\N	vmod	\N	\N	\N	781	1
3099	財布に　カードを　入れます。	把信用卡放到皮包裡面。	\N	さいふに　かーどを　いれます。	\N	vmod	\N	\N	\N	781	1
3100	買い物を　する　とき、　カードを　使います。	買東西時我用信用卡。	\N	かいものを　する　とき、　かーどを　つかいます。	\N	vmod	\N	\N	\N	401	1
3101	あそこに　郵便局員が　います。	那邊有郵局的人員。	\N	あそこに　ゆうびんきょくいんが　います。	\N	vmod	\N	\N	\N	782	1
3102	船便は　時間が　かかりますが、　安いです。	海運郵件雖然費時，但是很便宜。	\N	ふなびんは　じかんが　かかりますが、　やすいです。	\N	vmod	\N	\N	\N	784	1
3103	船便より　航空便の　ほうが　早く　着きます。	航空郵件比海運郵件快到。	\N	ふなびんより　こうくうびんの　ほうが　はやく　つきます。	\N	vmod	\N	\N	\N	783	1
3104	きのう　母に　荷物を　送りました。	昨天我把行李寄給了媽媽。	\N	きのう　ははに　にもつを　おくりました。	\N	vmod	\N	\N	\N	785	1
3105	航空便で　送ったので、　少し　高かったです。	因為用航空郵件寄，有點貴。	\N	こうくうびんで　おくったので、　すこし　たかかったです。	\N	vmod	\N	\N	\N	785	1
3106	夏は　暑いので、　スーツを　着たくないです。	夏天因為很熱，我不想穿西裝。	\N	なつは　あついので、　すーつを　きたくないです。	\N	vmod	\N	\N	\N	786	1
3107	会社へ　行く　とき、　スーツを　着ます。	去上班的時候我穿西裝。	\N	かいしゃへ　いく　とき、　すーつを　きます。	\N	vmod	\N	\N	\N	786	1
3108	誕生日に　友達から　シャツを　もらいました。	生日那天從朋友那邊收到了一件襯衫。	\N	たんじょうびに　ともだちから　しゃつを　もらいました。	\N	vmod	\N	\N	\N	298	1
3109	田中さんは　会社員です。	たなかさんは　かいしゃいんです。	\N	たなかさんは　かいしゃいんです。	\N	vmod	\N	\N	\N	787	1
3110	木村さんは　学生ですが、　田中さんは　会社員です。	木村是學生，田中是上班族。	\N	きむらさんは　がくせいですが、　たなかさんは　かいしゃいんです。	\N	vmod	\N	\N	\N	787	1
3111	スーパーへ　買い物に　行きます。	我要去超級市場買東西。	\N	すーぱーへ　かいものに　いきます。	\N	vmod	\N	\N	\N	788	1
3112	カレーと　水を　ください。	請給我咖哩和一杯水。	\N	かれーと　みずを　ください。	\N	vmod	\N	\N	\N	723	1
3113	いちばん　安い　魚を　二匹　ください。	請給我兩條最便宜的魚。	\N	いちばん　やすい　さかなを　にひき　ください。	\N	vmod	\N	\N	\N	723	1
3114	いくつ　パンを　買いましたか。	買了幾個麵包？	\N	いくつ　ぱんを　かいましたか。	\N	vmod	\N	\N	\N	46	1
3115	テーブルの　上に　いくつ　コップが　ありますか。	桌子上面有好幾個杯子。	\N	てーぶるの　うえに　いくつ　こっぷが　ありますか。	\N	vmod	\N	\N	\N	46	1
3116	日本人は　おはしを　使って、　ごはんを　食べます。	日本人用筷子吃飯。	\N	にほんじんは　おはしを　つかって、　ごはんを　たべます。	\N	vmod	\N	\N	\N	789	1
3117	公園を　散歩して、　家へ　帰ります。	在公園散步，然後回家。	\N	こうえんを　さんぽして、　いえへ　かえります。	\N	vmod	\N	\N	\N	231	1
3118	わたしは　毎日　テニスの　練習を　します。	我每天練習網球。	\N	わたしは　まいにち　てにすの　れんしゅうを　します。	\N	vmod	\N	\N	\N	779	1
3119	スポーツは　野球が　いちばん　好きです。	運動裡面我最喜歡棒球。	\N	すぽーつは　やきゅうが　いちばん　すきです。	\N	vmod	\N	\N	\N	325	1
3120	松井さんは　サッカーより　野球の　ほうが　上手です。	跟足球比起來，松井棒球打得比較好。	\N	まついさんは　さっかーより　やきゅうの　ほうが　じょうずです。	\N	vmod	\N	\N	\N	777	1
3121	雨が　降ったので、　野球の　試合が　ありませんでした。	因為下雨了，棒球比賽也沒了。	\N	あめが　ふったので、　やきゅうの　しあいが　ありませんでした。	\N	vmod	\N	\N	\N	778	1
3122	あした　テニスの　試合が　あります。	明天有網球比賽。	\N	あした　てにすの　しあいが　あります。	\N	vmod	\N	\N	\N	790	1
3123	ブラジルは　サッカーが　とても　強い　国です。	巴西是一個足球很強的國家。	\N	ぶらじるは　さっかーが　とても　つよい　くにです。	\N	vmod	\N	\N	\N	411	1
3124	体が　弱いので、　スポーツが　できません。	因為身體虛弱，沒有辦法運動。	\N	からだが　よわいので、　すぽーつが　できません。	\N	vmod	\N	\N	\N	674	1
3125	この　町の　水は　きれいです。	この　まちの　みずは　きれいです。	\N	この　まちの　みずは　きれいです。	\N	vmod	\N	\N	\N	200	1
3126	部屋が　汚いので、　掃除します。	因為房間很髒，我要打掃。	\N	へやが　きたないので、　そうじします。	\N	vmod	\N	\N	\N	791	1
3127	この　辺の　海は　汚いです。	這一帶的海很髒。	\N	この　へんの　うみは　きたないです。	\N	vmod	\N	\N	\N	791	1
3128	出かける　とき、　電気を　消すのを　忘れました。	出門的時候忘了關燈。	\N	でかける　とき、　でんきを　けすのを　わすれました。	\N	vmod	\N	\N	\N	222	1
3129	寝る　前に　電気を　消します。	睡覺前關燈。	\N	ねる　まえに　でんきを　けします。	\N	vmod	\N	\N	\N	222	1
3130	きょうは　もう　家へ　帰ります。	今天就到這裡，我要回家了。	\N	きょうは　もう　いえへ　かえります。	\N	vmod	\N	\N	\N	142	1
3131	きのう　かぎを　なくして　しまいました。	昨天我把鑰匙弄丟了。	\N	きのう　かぎを　なくして　しまいました。	\N	vmod	\N	\N	\N	145	1
3132	これは　わたしの　家の　かぎです。	這是我家的鑰匙。	\N	これは　わたしの　いえの　かぎです。	\N	vmod	\N	\N	\N	145	1
3133	家の　門の　前に　猫が　います。	房子大門前面有一隻貓。	\N	いえの　もんの　まえに　ねこが　います。	\N	vmod	\N	\N	\N	646	1
3134	この　川の　水は　きれいです。	這條河的水很乾淨。	\N	この　かわの　みずは　きれいです。	\N	vmod	\N	\N	\N	200	1
3135	イさんは　日本語が　できます。	李先生(小姐)會日文。	\N	いさんは　にほんごが　できます。	\N	vmod	\N	\N	\N	418	1
3136	銀行で　お金を　借ります。	在銀行借錢。	\N	ぎんこうで　おかねを　かります。	\N	vmod	\N	\N	\N	202	1
3137	わたしの　父は　銀行員です。	我爸爸是銀行員。	\N	わたしの　ちちは　ぎんこういんです。	\N	vmod	\N	\N	\N	792	1
3138	窓口に　いる　銀行員は　女の　人が　多いです。	在櫃台的銀行員以女性居多。	\N	まどぐちに　いる　ぎんこういんは　おんなの　ひとが　おおいです。	\N	vmod	\N	\N	\N	793	1
3139	窓口で　お金の　振り込みを　します。	在櫃台匯錢。	\N	まどぐちで　おかねの　ふりこみを　します。	\N	vmod	\N	\N	\N	793	1
3140	銀行へ　行って、　お金の　振り込みを　します。	我要去銀行匯錢。	\N	ぎんこうへ　いって、　おかねの　ふりこみを　します。	\N	vmod	\N	\N	\N	794	1
3141	窓口で　振り込み用紙を　もらいました。	我在櫃台要了一張匯款單。	\N	まどぐちで　ふりこみようしを　もらいました。	\N	vmod	\N	\N	\N	795	1
3142	この　用紙に　名前と　住所を　書きます。	在這張紙上面寫上姓名和地址。	\N	この　ようしに　なまえと　じゅうしょを　かきます。	\N	vmod	\N	\N	\N	795	1
3143	用紙に　書いて　ある　番号を　覚えます。	我會記住寫在紙上的號碼。	\N	ようしに　かいて　ある　ばんごうを　おぼえます。	\N	vmod	\N	\N	\N	536	1
3144	友達に　新しい　住所を　教えました。	我把新地址告訴朋友了。	\N	ともだちに　あたらしい　じゅうしょを　おしえました。	\N	vmod	\N	\N	\N	796	1
3145	あの　方は　この　学校の　先生です。	那個人是這所學校的老師。	\N	あの　かたは　この　がっこうの　せんせいです。	\N	vmod	\N	\N	\N	155	1
3146	外国人と　話すのは　とても　楽しいです。	跟外國人說話很有意思。	\N	がいこくじんと　はなすのは　とても　たのしいです。	\N	vmod	\N	\N	\N	136	1
3147	三年前　この　国へ　来ました。	三年前我來到這個國家。	\N	さんねんまえ　この　くにへ　きました。	\N	vmod	\N	\N	\N	210	1
3148	近くに　新しい　空港が　できました。	附近蓋了一座新機場。	\N	ちかくに　あたらしい　くうこうが　できました。	\N	vmod	\N	\N	\N	806	1
3149	空港で　パスポートを　見せます。	在機場出示護照。	\N	くうこうで　ぱすぽーとを　みせます。	\N	vmod	\N	\N	\N	806	1
3150	駅で　パスポートを　なくしました。	我在車站把護照弄丟了。	\N	えきで　ぱすぽーとを　なくしました。	\N	vmod	\N	\N	\N	807	1
3151	外国へ　行く　とき、　パスポートが　要ります。	去國外的時候需要護照。	\N	がいこくへ　いく　とき、　ぱすぽーとが　いります。	\N	vmod	\N	\N	\N	807	1
3152	たくさん　買い物を　したので、　お金が　なくなりました。	たくさん　かいものを　したので、　おかねが　なくなりました。	\N	たくさん　かいものを　したので、　おかねが　なくなりました。	\N	vmod	\N	\N	\N	139	1
3153	休みの　日は　友達と　買い物に　行きます。	假日我要和朋友去買東西。	\N	やすみの　ひは　ともだちと　かいものに　いきます。	\N	vmod	\N	\N	\N	139	1
3154	ガイドが　この　町の　ことを　教えて　くれました。	導遊告訴了我們一些這個小鎮的事情。	\N	がいどが　この　まちの　ことを　おしえて　くれました。	\N	vmod	\N	\N	\N	808	1
3155	わたしの　友達は　ガイドを　して　います。	我朋友在從事導遊的工作。	\N	わたしの　ともだちは　がいどを　して　います。	\N	vmod	\N	\N	\N	808	1
3156	帰る　電車が　なかったので、　友達の　家に　泊まりました。	因為沒有電車可以回家了，我住在朋友家裡。	\N	かえる　でんしゃが　なかったので、　ともだちの　いえに　とまりました。	\N	vmod	\N	\N	\N	809	1
3157	今晩は　ホテルに　泊まります。	今晚要住飯店。	\N	こんばんは　ほてるに　とまります。	\N	vmod	\N	\N	\N	809	1
3158	友達に　旅行の　お土産を　もらいました。	從朋友那裡拿到旅行的土產了。	\N	ともだちに　りょこうの　おみやげを　もらいました。	\N	vmod	\N	\N	\N	810	1
3159	家族に　お土産を　買います。	我要買土產給家人。	\N	かぞくに　おみやげを　かいます。	\N	vmod	\N	\N	\N	810	1
3160	振り込み用紙を　書く　とき、　ボールペンを　使います。	寫匯款單時用原子筆。	\N	ふりこみようしを　かく　とき、　ぼーるぺんを　つかいます。	\N	vmod	\N	\N	\N	401	1
3161	あの　会社は　車を　作って　います。	那家公司在製造汽車。	\N	あの　かいしゃは　くるまを　つくって　います。	\N	vmod	\N	\N	\N	406	1
3162	自分で　テーブルを　作ります。	我自己做桌子。	\N	じぶんで　てーぶるを　つくります。	\N	vmod	\N	\N	\N	406	1
3163	仕事で　人と　会うので、　ネクタイを　します。	因為工作的關係要跟人見面，我打領帶。	\N	しごとで　ひとと　あうので、　ねくたいを　します。	\N	vmod	\N	\N	\N	800	1
3164	会社へ　行く　とき、　スーツを　着ます。	去上班時我穿西裝。	\N	かいしゃへ　いく　とき、　すーつを　きます。	\N	vmod	\N	\N	\N	705	1
3165	毎日　日本語を　勉強して　いますが、　漢字が　覚えられません。	雖然我每天學日語，可是漢字都記不起來。	\N	まいにち　にほんごを　べんきょうして　いますが、　かんじが　おぼえられません。	\N	vmod	\N	\N	\N	178	1
3166	イさんは　日本語が　話せます。	いさんは　にほんごが　はなせます。	\N	いさんは　にほんごが　はなせます。	\N	vmod	\N	\N	\N	811	1
3167	イさんは　日本語で　手紙を　書きました。。	李先生(小姐)用日文寫了信。	\N	いさんは　にほんごで　てがみを　かきました。	\N	vmod	\N	\N	\N	811	1
3168	英語で　話すのは　難しいです。	用英文講很難。	\N	えいごで　はなすのは　むずかしいです。	\N	vmod	\N	\N	\N	526	1
3169	松井さんは　小林さんと　話して　います。	松井跟小林在講話。	\N	まついさんは　こばやしさんと　はなして　います。	\N	vmod	\N	\N	\N	526	1
3170	その　ことは　わたしが　先生に　言います。　	那件事我來跟老師說。	\N	その　ことは　わたしが　せんせいに　いいます。	\N	vmod	\N	\N	\N	42	1
3171	この　用紙に　問題の　答えを　書きます。	在這張紙上寫答案。	\N	この　ようしに　もんだいの　こたえを　かきます。	\N	vmod	\N	\N	\N	146	1
3172	きのう　友達に　手紙を　書きました。	昨天我寫信給朋友了。	\N	きのう　ともだちに　てがみを　かきました。	\N	vmod	\N	\N	\N	146	1
3173	字を　書くのが　あまり　好きでは　ありません。	我不太喜歡寫字。	\N	じを　かくのが　あまり　すきでは　ありません。	\N	vmod	\N	\N	\N	812	1
3174	松井さんは　字が　上手です。	松井字寫得很漂亮。	\N	まついさんは　じが　じょうずです。	\N	vmod	\N	\N	\N	812	1
3175	林さんに　おもしろい　話を　聞きました。	我從林先生(小姐)那邊聽到了有趣的事情。	\N	はやしさんに　おもしろい　はなしを　ききました。	\N	vmod	\N	\N	\N	525	1
3176	松井さんは　小林さんと　話を　して　います。	松井跟小林在講話。	\N	まついさんは　こばやしさんと　はなしを　して　います。	\N	vmod	\N	\N	\N	525	1
3177	先生の　話は　意味が　分かりませんでした。	老師講的話我不知道是什麼意思。	\N	せんせいの　はなしは　いみが　わかりませんでした。	\N	vmod	\N	\N	\N	63	1
3178	イさんに　この　ことばの　意味を　教えました。	我教了李先生(小姐)這個字。	\N	いさんに　この　ことばの　いみを　おしえました。	\N	vmod	\N	\N	\N	63	1
3179	日本語には　かたかなの　ことばが　たくさん　あります。	日文裡面有很多片假名的單字。	\N	にほんごには　かたかなの　ことばが　たくさん　あります。	\N	vmod	\N	\N	\N	156	1
3180	ひらがなは　書けますが、　かたかなは　まだ　書けません。	我會寫平假名，但不會寫片假名。	\N	ひらがなは　かけますが、　かたかなは　まだ　かけません。	\N	vmod	\N	\N	\N	553	1
3181	この　文は　短いので、　読みやすいです。	因為這篇文章很短，很好唸。	\N	この　ぶんは　みじかいので、　よみやすいです。	\N	vmod	\N	\N	\N	756	1
3182	外国語を　勉強するのは　難しいです。	學習外國語是很難的。	\N	がいこくごを　べんきょうするのは　むずかしいです。	\N	vmod	\N	\N	\N	230	1
3183	日本語で　書かれた　本を　読みます。	我要讀用日文寫的書。	\N	にほんごで　かかれた　ほんを　よみます。	\N	vmod	\N	\N	\N	230	1
3184	ことばの　意味が　分からない　とき、　辞書を　使います。	不知道單字的意思時，我用字典。	\N	ことばの　いみが　わからない　とき、　じしょを　つかいます。	\N	vmod	\N	\N	\N	248	1
3185	朝　起きて、　顔を　洗います。	早上起床，然後洗臉。	\N	あさ　おきて、　かおを　あらいます。	\N	vmod	\N	\N	\N	143	1
3186	デパートで　新しい　洋服を　買いました。	在百貨公司買了新衣服。	\N	でぱーとで　あたらしい　ようふくを　かいました。	\N	vmod	\N	\N	\N	666	1
3187	上着を　持って　出かけます。	帶著上衣出門。	\N	うわぎを　もって　でかけます。	\N	vmod	\N	\N	\N	81	1
3188	外は　寒いので、　コートを　着て、　会社へ　行きます。	因為外面很冷，我要穿外套後再去公司。	\N	そとは　さむいので、　こーとを　きて、　かいしゃへ　いきます。	\N	vmod	\N	\N	\N	236	1
3189	暑いので、　セーターを　脱ぎます。	因為很熱，我要脫毛衣。	\N	あついので、　せーたーを　ぬぎます。	\N	vmod	\N	\N	\N	333	1
3190	この　ズボンは　わたしには　小さいので、　はけません。	這件褲子對我來說太小了，穿不下。	\N	この　ずぼんは　わたしには　ちいさいので、　はけません。	\N	vmod	\N	\N	\N	326	1
3191	ズボンより　スカートの　ほうが　好きです。	ずぼんより　すかーとの　ほうが　すきです。	\N	ずぼんより　すかーとの　ほうが　すきです。	\N	vmod	\N	\N	\N	315	1
3192	小林さんは　スカートより　ズボンの　ほうが　好きです。	跟裙子比起來，小林比較喜歡褲子。	\N	こばやしさんは　すかーとより　ずぼんの　ほうが　すきです。	\N	vmod	\N	\N	\N	315	1
3193	靴を　脱いで、　スリッパを　はきます。	脫鞋子、換上拖鞋。	\N	くつを　ぬいで、　すりっぱを　はきます。	\N	vmod	\N	\N	\N	328	1
3194	目が　悪いので、　眼鏡を　かけます。	眼睛不好所以戴眼鏡。	\N	めが　わるいので、　めがねを　かけます。	\N	vmod	\N	\N	\N	150	1
3195	日本では　家に　入る　とき、　靴を　脱ぎます。	在日本，進入家裡的時候要脫鞋。	\N	にほんでは　いえに　はいる　とき、　くつを　ぬぎます。	\N	vmod	\N	\N	\N	494	1
3196	新しい　靴を　はいて　出かけます。	我要穿新鞋子出門。	\N	あたらしい　くつを　はいて　でかけます。	\N	vmod	\N	\N	\N	511	1
3197	木村さんは　かわいい　スカートを　はいて　います。	木村穿著一件可愛的裙子。	\N	きむらさんは　かわいい　すかーとを　はいて　います。	\N	vmod	\N	\N	\N	511	1
3198	おふろに　入るので、　服を　脱ぎます。	因為要洗澡了，我要脫衣服。	\N	おふろに　はいるので、　ふくを　ぬぎます。	\N	vmod	\N	\N	\N	494	1
3199	この　お菓子は　甘いです。	這個點心很甜。	\N	この　おかしは　あまいです。	\N	vmod	\N	\N	\N	33	1
3200	しょうゆを　つけて、　さしみを　食べます。	しょうゆを　つけて、　さしみを　たべます。	\N	しょうゆを　つけて、　さしみを　たべます。	\N	vmod	\N	\N	\N	803	1
3201	この　料理は　何も　つけないで　食べます。	吃這道菜時什麼都不用沾。	\N	この　りょうりは　なにも　つけないで　たべます。	\N	vmod	\N	\N	\N	803	1
3202	しょうゆを　つけて、　さしみを　食べます。	沾醬油吃生魚片。	\N	しょうゆを　つけて、　さしみを　たべます。	\N	vmod	\N	\N	\N	306	1
3346	これは　日本で　売って　いない　食べ物です。	這是日本沒有賣的食物。	\N	これは　にほんで　うって　いない　たべものです。	\N	vmod	\N	\N	\N	79	1
3203	砂糖と　塩を　使って、　料理を　作ります。	さとうと　しおを　つかって、　りょうりを　つくります。	\N	さとうと　しおを　つかって、　りょうりを　つくります。	\N	vmod	\N	\N	\N	280	1
3204	テーブルの　上に　ちゃわんと　おはしを　並べます。	桌子上擺著碗跟筷子。	\N	てーぶるの　うえに　ちゃわんと　おはしを　ならべます。	\N	vmod	\N	\N	\N	396	1
3205	ちゃわんで　ごはんを　食べます。	用碗吃飯。	\N	ちゃわんで　ごはんを　たべます。	\N	vmod	\N	\N	\N	396	1
3206	きょうは　友達と　晩ごはんを　食べます。	今天我要朋友吃晚餐。	\N	きょうは　ともだちと　ばんごはんを　たべます。	\N	vmod	\N	\N	\N	537	1
3207	いつも　ここで　昼ごはんを　食べます。	我都在這裡吃午餐。	\N	いつも　ここで　ひるごはんを　たべます。	\N	vmod	\N	\N	\N	555	1
3208	きょうは　朝ごはんを　食べませんでした。	今天我沒有吃早餐。	\N	きょうは　あさごはんを　たべませんでした。	\N	vmod	\N	\N	\N	13	1
3209	木村さんは　わたしに　お菓子を　くれました。	木村給了我點心。	\N	きむらさんは　わたしに　おかしを　くれました。	\N	vmod	\N	\N	\N	98	1
3210	この　料理は　まずそうです。	這道菜看起來好像很難吃。	\N	この　りょうりは　まずそうです。	\N	vmod	\N	\N	\N	606	1
3211	あの　店は　安いですが、　まずいです。	那家店雖然便宜但是很難吃。	\N	あの　みせは　やすいですが、　まずいです。	\N	vmod	\N	\N	\N	606	1
3212	林さんの　お弁当は　おいしそうです。	林先生(小姐)的便當看起來好像很好吃。	\N	はやしさんの　おべんとうは　おいしそうです。	\N	vmod	\N	\N	\N	92	1
3213	この　お菓子は　おいしいです。	這個點心很好吃。	\N	この　おかしは　おいしいです。	\N	vmod	\N	\N	\N	92	1
3214	忙しかったので、　昼ごはんを　食べられませんでした。	因為很忙，沒有辦法去吃午餐。	\N	いそがしかったので、　ひるごはんを　たべられませんでした。	\N	vmod	\N	\N	\N	555	1
3215	この　カレーは　とても　辛いです。	這個咖哩很辣。	\N	この　かれーは　とても　からいです。	\N	vmod	\N	\N	\N	168	1
3216	朝ごはんは　いつも　パンを　食べます。	早餐我都吃麵包。	\N	あさごはんは　いつも　ぱんを　たべます。	\N	vmod	\N	\N	\N	13	1
3217	きょうの　夕飯は　カレーです。	今天的晚餐是咖哩。	\N	きょうの　ゆうはんは　かれーです。	\N	vmod	\N	\N	\N	659	1
3218	きょうの　晩ごはんは　カレーです。	今天的晚餐是咖哩。	\N	きょうの　ばんごはんは　かれーです。	\N	vmod	\N	\N	\N	537	1
3219	イさんに　塩を　取って　あげました。	我拿鹽給李先生(小姐)了。	\N	いさんに　しおを　とって　あげました。	\N	vmod	\N	\N	\N	280	1
3220	砂糖と　塩を　入れて、　料理を　作ります。	加糖和鹽，然後開始做菜。	\N	さとうと　しおを　いれて、　りょうりを　つくります。	\N	vmod	\N	\N	\N	280	1
3221	弟は　とても　体が　丈夫です。	弟弟身體很強壯。	\N	おとうとは　とても　からだが　じょうぶです。	\N	vmod	\N	\N	\N	169	1
3222	目が　悪いので、　眼鏡を　かけます。	めが　わるいので、　めがねを　かけます。	\N	めが　わるいので、　めがねを　かけます。	\N	vmod	\N	\N	\N	637	1
3223	暗い　部屋で　本を　読んで　いたので、　目が　疲れました。	因為在暗暗的房間看書，眼睛累了。	\N	くらい　へやで　ほんを　よんで　いたので、　めが　つかれました。	\N	vmod	\N	\N	\N	637	1
3224	山田さんは　目が　悪いので、　眼鏡を　かけて　います。	山田因為眼睛不好，戴著眼鏡。	\N	やまださんは　めが　わるいので、　めがねを　かけて　います。	\N	vmod	\N	\N	\N	637	1
3225	あの　犬は　耳が　大きいです。	那隻狗耳朵很大。	\N	あの　いぬは　みみが　おおきいです。	\N	vmod	\N	\N	\N	629	1
3226	妹は　目が　大きくて、　鼻が　高いです。	妹妹眼睛大大的，鼻子高高的。	\N	いもうとは　めが　おおきくて、　はなが　たかいです。	\N	vmod	\N	\N	\N	524	1
3227	歯が　痛いので、　口を　開ける　ことが　できません。	因為牙齒痛，嘴巴張不開。	\N	はが　いたいので、　くちを　あける　ことが　できません。	\N	vmod	\N	\N	\N	207	1
3228	食べる　前に、　手を　洗います。	たべる　まえに、　てを　あらいます。	\N	たべる　まえに、　てを　あらいます。	\N	vmod	\N	\N	\N	412	1
3229	ごはんを　食べる　前に、　手を　洗います。	吃飯前要洗手。	\N	ごはんを　たべる　まえに、　てを　あらいます。	\N	vmod	\N	\N	\N	412	1
3230	たくさん　歩いたので、　足が　疲れました。	因為走了很遠，腳累了。	\N	たくさん　あるいたので、　あしが　つかれました。	\N	vmod	\N	\N	\N	15	1
3231	あの　人は　とても　足が　長いです。	那個人的腳很長。	\N	あの　ひとは　とても　あしが　ながいです。	\N	vmod	\N	\N	\N	15	1
3232	おふろで　体を　洗います。	在浴室裡洗澡。	\N	おふろで　からだを　あらいます。	\N	vmod	\N	\N	\N	36	1
3233	いつも　寝る　前に、　歯を　磨きます。	我總是在睡前刷牙。	\N	いつも　ねる　まえに、　はを　みがきます。	\N	vmod	\N	\N	\N	617	1
3234	きのうは　忙しかったので、　とても　疲れました。	因為昨天很忙，累死我了。	\N	きのうは　いそがしかったので、　とても　つかれました。	\N	vmod	\N	\N	\N	402	1
3235	山田さんは　教室の　中に　います。	山田在教室裡面。	\N	やまださんは　きょうしつの　なかに　います。	\N	vmod	\N	\N	\N	467	1
3236	小林さんは　青い　傘を　持って　います。	小林拿著藍色的雨傘。	\N	こばやしさんは　あおい　かさを　もって　います。	\N	vmod	\N	\N	\N	4	1
3237	きのう　デパートで　白い　靴を　買いました。	昨天在百貨公司買了白色的鞋子。	\N	きのう　でぱーとで　しろい　くつを　かいました。	\N	vmod	\N	\N	\N	310	1
3238	黄色い　シャツを　着て　いる　人は　林さんです。	穿著黃襯衫的是林先生(小姐)。	\N	きいろい　しゃつを　きて　いる　ひとは　はやしさんです。	\N	vmod	\N	\N	\N	181	1
3239	田中さんの　車は　白くて　大きいです。	田中的車又白又大。	\N	たなかさんの　くるまは　しろくて　おおきいです。	\N	vmod	\N	\N	\N	310	1
3240	会社へ　行く　とき、　黒の　スーツを　着ます。	去公司時我穿黑色西裝。	\N	かいしゃへ　いく　とき、　くろの　すーつを　きます。	\N	vmod	\N	\N	\N	218	1
3241	田中さんは　緑の　ネクタイを　して　います。	田中打著一條綠色的領帶。	\N	たなかさんは　みどりの　ねくたいを　して　います。	\N	vmod	\N	\N	\N	626	1
3242	木村さんの　髪の　色は　茶色です。	木村的頭髮顏色是棕色的。	\N	きむらさんの　かみの　いろは　ちゃいろです。	\N	vmod	\N	\N	\N	395	1
3243	わたしは　赤より　青の　ほうが　好きです。	跟紅色比起來，我比較喜歡藍色。	\N	わたしは　あかより　あおの　ほうが　すきです。	\N	vmod	\N	\N	\N	5	1
3244	わたしの　好きな　色は　青です。	我喜歡的顏色是藍色。	\N	わたしの　すきな　いろは　あおです。	\N	vmod	\N	\N	\N	3	1
3245	この　色は　とても　きれいです。	這顏色很漂亮。	\N	この　いろは　とても　きれいです。	\N	vmod	\N	\N	\N	69	1
3246	誕生日に　黄色の　ハンカチを　もらいました。	生日那天收到了一條黃色手帕。	\N	たんじょうびに　きいろの　はんかちを　もらいました。	\N	vmod	\N	\N	\N	180	1
3247	テーブルの　上に　花瓶を　置きました。	我在桌子上面放了花瓶。	\N	てーぶるの　うえに　かびんを　おきました。	\N	vmod	\N	\N	\N	71	1
3248	いすの　下に　猫が　います。	椅子下面有隻貓。	\N	いすの　したに　ねこが　います。	\N	vmod	\N	\N	\N	286	1
3249	あそこの　角を　右に　曲がると、　スーパーが　あります。	在那邊的轉角往右轉，就有一家超級市場。	\N	あそこの　かどを　みぎに　まがると、　すーぱーが　あります。	\N	vmod	\N	\N	\N	161	1
3250	この　かばんは　外側に　ポケットが　あります。	這個包包的外面附有口袋。	\N	この　かばんは　そとがわに　ぽけっとが　あります。	\N	vmod	\N	\N	\N	176	1
3251	トイレは　廊下の　左側に　あります。	廁所在走廊左邊。	\N	といれは　ろうかの　ひだりがわに　あります。	\N	vmod	\N	\N	\N	176	1
3252	ノートは　かばんの　中に　あります。	筆記本在包包裡面。	\N	のーとは　かばんの　なかに　あります。	\N	vmod	\N	\N	\N	728	1
3253	あそこの　教室には　テレビが　あります。	那邊的教室有電視機。	\N	あそこの　きょうしつには　てれびが　あります。	\N	vmod	\N	\N	\N	728	1
3254	うちに　犬と　猫が　います。	我家有狗和貓。	\N	うちに　いぬと　ねこが　います。	\N	vmod	\N	\N	\N	754	1
3255	イさんは　今　図書館に　います。	李先生(小姐)現在在圖書館。	\N	いさんは　いま　としょかんに　います。	\N	vmod	\N	\N	\N	754	1
3256	冬に　なると、　日本の　北側は　とても　寒いです。	一到了冬天日本北部就會很冷。	\N	ふゆに　なると、　にほんの　きたがわは　とても　さむいです。	\N	vmod	\N	\N	\N	184	1
3257	わたしの　部屋は　南側に　あるので、　明るいです。	因為我的房間在南邊，很明亮。	\N	わたしの　へやは　みなみがわに　あるので、　あかるいです。	\N	vmod	\N	\N	\N	628	1
3258	ここから　少し　西へ　行くと、　海が　あります。	ここから　すこし　にしへ　いくと、　うみが　あります。	\N	ここから　すこし　にしへ　いくと、　うみが　あります。	\N	vmod	\N	\N	\N	539	1
3259	この　町の　東側は　全部　森です。	這個小鎮的東邊全部都是森林。	\N	この　まちの　ひがしがわは　ぜんぶ　もりです。	\N	vmod	\N	\N	\N	539	1
3260	ここから　少し　西へ　行くと、　海が　あります。	從這裡再往西一點就有海了。	\N	ここから　すこし　にしへ　いくと、　うみが　あります。	\N	vmod	\N	\N	\N	487	1
3261	木村さんの　お姉さんは　とても　きれいな　人です。	木村的姊姊是個很漂亮的人。	\N	きむらさんの　おねえさんは　とても　きれいな　ひとです。	\N	vmod	\N	\N	\N	120	1
3262	今　わたしの　両親は　海外に　います。	現在我爸媽在國外。	\N	いま　わたしの　りょうしんは　かいがいに　います。	\N	vmod	\N	\N	\N	682	1
3263	母に　誕生日の　プレゼントを　あげました。	我給了媽媽生日禮物。	\N	ははに　たんじょうびの　ぷれぜんとを　あげました。	\N	vmod	\N	\N	\N	527	1
3264	今　姉は　東京に　一人で　住んで　います。	現在姊姊一個人住在東京。	\N	いま　あねは　とうきょうに　ひとりで　すんで　います。	\N	vmod	\N	\N	\N	28	1
3265	田中さんの　奥さんは　大学の　先生です。	田中的太太是大學教授。	\N	たなかさんの　おくさんは　だいがくの　せんせいです。	\N	vmod	\N	\N	\N	102	1
3266	来週　イさんの　お兄さんが　日本へ　遊びに　来ます。	下星期李先生(小姐)的哥哥要來日本玩。	\N	らいしゅう　いさんの　おにいさんが　にほんへ　あそびに　きます。	\N	vmod	\N	\N	\N	119	1
3267	山田さんの　お母さんは　料理が　とても　上手です。	山田的媽媽很會做菜。	\N	やまださんの　おかあさんは　りょうりが　とても　じょうずです。	\N	vmod	\N	\N	\N	97	1
3268	林さんの　ご主人は　病院で　働いて　います。	林小姐的丈夫在醫院工作。	\N	はやしさんの　ごしゅじんは　びょういんで　はたらいて　います。	\N	vmod	\N	\N	\N	814	1
3269	山田さんの　妹さんは　背が　低くて、　かわいいです。	山田的妹妹雖然個子很矮，但是很可愛。	\N	やまださんの　いもうとさんは　せが　ひくくて、　かわいいです。	\N	vmod	\N	\N	\N	815	1
3270	小林さんの　弟さんは　サッカーを　して　います。	小林的弟弟在踢足球。	\N	こばやしさんの　おとうとさんは　さっかーを　して　います。	\N	vmod	\N	\N	\N	816	1
3271	わたしは　兄弟が　二人　います。	我有兩個兄弟姊妹。	\N	わたしは　きょうだいが　ふたり　います。	\N	vmod	\N	\N	\N	196	1
3272	あの　きれいな　女の　人は　木村さんです。	那個漂亮的女人是木村小姐。	\N	あの　きれいな　おんなの　ひとは　きむらさんです。	\N	vmod	\N	\N	\N	132	1
3273	子どもが　公園で　遊んで　います。	小孩子在公園裡面玩。	\N	こどもが　こうえんで　あそんで　います。	\N	vmod	\N	\N	\N	249	1
3274	あそこに　小さい　女の子が　います。	那邊有個小女孩。	\N	あそこに　ちいさい　おんなのこが　います。	\N	vmod	\N	\N	\N	133	1
3275	あの　八百屋の　おじさんは　いつも　元気です。	那家蔬果店的老闆總是精神飽滿的。	\N	あの　やおやの　おじさんは　いつも　げんきです。	\N	vmod	\N	\N	\N	103	1
3276	小林さんの　おばさんは　東京に　住んで　います。	小林的阿姨住在東京。	\N	こばやしさんの　おばさんは　とうきょうに　すんで　います。	\N	vmod	\N	\N	\N	121	1
3277	わたしは　おじいさんに　道を　教えて　あげました。	我教了爺爺路要怎麼走。	\N	わたしは　おじいさんに　みちを　おしえて　あげました。	\N	vmod	\N	\N	\N	104	1
3278	林さんの　おばあさんは　眼鏡を　かけて　います。	林先生(小姐)的奶奶帶著眼鏡。	\N	はやしさんの　おばあさんは　めがねを　かけて　います。	\N	vmod	\N	\N	\N	122	1
3279	大人に　なったら、　お酒を　飲む　ことが　できます。	變成大人之後就可以喝酒了。	\N	おとなに　なったら、　おさけを　のむ　ことが　できます。	\N	vmod	\N	\N	\N	116	1
3280	松井さんと　イさんは　友達です。	松井跟李是朋友。	\N	まついさんと　いさんは　ともだちです。	\N	vmod	\N	\N	\N	276	1
3281	わたしには　タイ人の　友達が　います。	我有泰國的朋友。	\N	わたしには　たいじんの　ともだちが　います。	\N	vmod	\N	\N	\N	709	1
3282	あの　男の　人は　背が　高くて、　足が　長いです。	那個男人身材又高、腳又長。	\N	あの　おとこの　ひとは　せが　たかくて、　あしが　ながいです。	\N	vmod	\N	\N	\N	112	1
3283	あそこで　男の子が　木に　登って　います。	在那裡有個男孩子在爬樹。	\N	あそこで　おとこのこが　きに　のぼって　います。	\N	vmod	\N	\N	\N	113	1
3284	二分、　待って　ください。	請等兩分鐘。	\N	にふん、　まって　ください。	\N	vmod	\N	\N	\N	571	1
3285	きょうは　日曜日ですが、　会社へ　行きます。	今天雖然是星期天，我還是要去公司。	\N	きょうは　にちようびですが、　かいしゃへ　いきます。	\N	vmod	\N	\N	\N	489	1
3286	山田さんは　来月　東京に　行くそうです。	やまださんは　らいげつ　とうきょうに　いくそうです。	\N	やまださんは　らいげつ　とうきょうに　いくそうです。	\N	vmod	\N	\N	\N	675	1
3287	山田さんは　来月　東京へ　行くそうです。	聽說山田下個月要去東京。	\N	やまださんは　らいげつ　とうきょうへ　いくそうです。	\N	vmod	\N	\N	\N	675	1
3288	あなたは　あっちで　仕事を　して　ください。	請你到那邊去做事。	\N	あなたは　あっちで　しごとを　して　ください。	\N	vmod	\N	\N	\N	26	1
3289	その　コップは　あなたのです。	那個杯子是我的。	\N	その　こっぷは　あなたのです。	\N	vmod	\N	\N	\N	26	1
3290	夕飯は　毎日　自分が　作ります。	晚餐我每天都自己做。	\N	ゆうはんは　まいにち　じぶんが　つくります。	\N	vmod	\N	\N	\N	293	1
3291	お手洗いは　こちらです。	洗手間在這裡。	\N	おてあらいは　こちらです。	\N	vmod	\N	\N	\N	244	1
3292	こちらは　小林さんです。	這位是小林。	\N	こちらは　こばやしさんです。	\N	vmod	\N	\N	\N	244	1
3293	こっちは　座れないので、　あっちに　座ります。	因為這邊不能坐，我坐那邊。	\N	こっちは　すわれないので、　あっちに　すわります。	\N	vmod	\N	\N	\N	245	1
3294	あちらの　建物は　七百九十四年に　建てられました。	那邊的建築物是在794年建造的。	\N	あちらの　たてものは　ななひゃくきゅうじゅうよねんに　たてられました。	\N	vmod	\N	\N	\N	22	1
3295	あちらは　山田さんです。	那位是山田。	\N	あちらは　やまださんです。	\N	vmod	\N	\N	\N	22	1
3296	食堂は　あっちの　建物に　あります。	食堂在那邊的建築物裡面。	\N	しょくどうは　あっちの　たてものに　あります。	\N	vmod	\N	\N	\N	24	1
3297	危ないので、　そちらへ　行かないで　ください。	因為很危險，不要去那邊。	\N	あぶないので、　そちらへ　いかないで　ください。	\N	vmod	\N	\N	\N	350	1
3298	そちらは　イさんです。	那位是李先生(小姐)。	\N	そちらは　いさんです。	\N	vmod	\N	\N	\N	350	1
3299	そっちへ　行くと、　郵便局や　銀行が　あります。	往那邊走就有郵局跟銀行。	\N	そっちへ　いくと、　ゆうびんきょくや　ぎんこうが　あります。	\N	vmod	\N	\N	\N	351	1
3300	先月　海外へ　旅行に　行きました。	上個月我去國外旅行了。	\N	せんげつ　かいがいへ　りょこうに　いきました。	\N	vmod	\N	\N	\N	339	1
3301	毎月　銀行に　お金を　預けて　います。	每個月我都 把錢存在銀行。	\N	まいつき　ぎんこうに　おかねを　あずけて　います。	\N	vmod	\N	\N	\N	600	1
3302	今月　あの　スーパーは　水曜日が　休みです。　　	這個月那家超市星期三休息。	\N	こんげつ　あの　すーぱーは　すいようびが　やすみです。	\N	vmod	\N	\N	\N	257	1
3303	今月は　仕事が　とても　忙しかったです。	這個月工作很忙。	\N	こんげつは　しごとが　とても　いそがしかったです。	\N	vmod	\N	\N	\N	257	1
3304	船便で　手紙を　出すと、　ひとつき　かかります。	用海運寄信要花一個月。	\N	ふなびんで　てがみを　だすと、　ひとつき　かかります。	\N	vmod	\N	\N	\N	547	1
3305	アメリカで　英語を　三か月　勉強しました。	我在美國學了三個月英語。	\N	あめりかで　えいごを　さんかげつ　べんきょうしました。	\N	vmod	\N	\N	\N	148	1
3306	松井さんの　誕生日は　八月です。	松井的生日是八月。	\N	まついさんの　たんじょうびは　はちがつです。	\N	vmod	\N	\N	\N	157	1
3307	あしたは　四月　一日です。	明天是四月一日。	\N	あしたは　しがつ　ついたちです。	\N	vmod	\N	\N	\N	157	1
3308	イさんは　ひとつきで　日本語が　とても　上手に　なりました。	李先生(小姐)只花了一個月日文就進步了很多。	\N	いさんは　ひとつきで　にほんごが　とても　じょうずに　なりました。	\N	vmod	\N	\N	\N	547	1
3309	毎月　海外の　友達に　手紙を　書きます。	我每個月都寫信寄給國外的朋友	\N	まいげつ　かいがいの　ともだちに　てがみを　かきます。	\N	vmod	\N	\N	\N	600	1
3345	これは　日本で　売って　いない　服です。	これは　にほんで　うって　いない　ふくです。	\N	これは　にほんで　うって　いない　ふくです。	\N	vmod	\N	\N	\N	79	1
3310	来週から　一か月、　林さんは　仕事で　海外へ　行きます。	下周開始一個月，林先生(小姐)因為工作的關係要出國。	\N	らいしゅうから　いっかげつ、　はやしさんは　しごとで　かいがいへ　いきます。	\N	vmod	\N	\N	\N	148	1
3311	先月　髪を　切ったのに、　もう　長く　なって　しまいました。	上個月才剛剪過頭髮，又變長了。	\N	せんげつ　かみを　きったのに、　もう　ながく　なって　しまいました。	\N	vmod	\N	\N	\N	339	1
3312	毎年　家族で　旅行に　行きます。	每年都全家人一起去旅行。	\N	まいとし　かぞくで　りょこうに　いきます。	\N	vmod	\N	\N	\N	601	1
3313	去年は　いい　年でした。	去年是個不錯的一年。	\N	きょねんは　いい　としでした。	\N	vmod	\N	\N	\N	448	1
3314	わたしは　おととし　この　山に　登りました。	我前年爬了這座山。	\N	わたしは　おととし　この　やまに　のぼりました。	\N	vmod	\N	\N	\N	115	1
3315	田中さんは　おととし　大学を　出ました。	田中前年從大學畢業了。	\N	たなかさんは　おととし　だいがくを　でました。	\N	vmod	\N	\N	\N	115	1
3316	去年より　今年の　ほうが　暑いです。	跟去年比起來今年比較熱。	\N	きょねんより　ことしの　ほうが　あついです。	\N	vmod	\N	\N	\N	197	1
3317	わたしは　今年から　ギターを　習います。	我從今年開始要學吉他。	\N	わたしは　ことしから　ぎたーを　ならいます。	\N	vmod	\N	\N	\N	247	1
3318	来年　わたしは　新しい　車を　買おうと　思います。	明年我想要買一台新車。	\N	らいねん　わたしは　あたらしい　くるまを　かおうと　おもいます。	\N	vmod	\N	\N	\N	677	1
3319	来年から　兄は　銀行に　勤めます。	明年開始哥哥要在銀行上班。	\N	らいねんから　あには　ぎんこうに　つとめます。	\N	vmod	\N	\N	\N	677	1
3320	さ来年　国へ　帰ります。	後年我要回國。	\N	さらいねん　くにへ　かえります。	\N	vmod	\N	\N	\N	275	1
3321	さ来年　あそこに　図書館が　できるそうです。	後年在那邊會有一座圖書館落成。	\N	さらいねん　あそこに　としょかんが　できるそうです。	\N	vmod	\N	\N	\N	275	1
3322	毎年　母に　誕生日の　プレゼントを　あげます。	我每天都給媽媽生日禮物。	\N	まいねん　ははに　たんじょうびの　ぷれぜんとを　あげます。	\N	vmod	\N	\N	\N	601	1
3323	五年前、　妻と　結婚しました。	我五年前跟太太結婚了。	\N	ごねんまえ、　つまと　けっこんしました。	\N	vmod	\N	\N	\N	499	1
3324	イさんは　日本に　三年　いる　つもりです。	李先生(小姐)打算待在日本三年。	\N	いさんは　にほんに　さんねん　いる　つもりです。	\N	vmod	\N	\N	\N	499	1
3325	今晩　駅で　イさんに　会います。	こんばん　えきで　いさんに　あいます。	\N	こんばん　えきで　いさんに　あいます。	\N	vmod	\N	\N	\N	2	1
3326	今晩　駅で　木村さんと　会います。	今晚我要在車站和木村碰面。	\N	こんばん　えきで　きむらさんと　あいます。	\N	vmod	\N	\N	\N	2	1
3327	あした　イさんに　会って、　お土産を　渡します。	明天我要和李先生(小姐)見面，然後把禮物給他(她)。	\N	あした　いさんに　あって、　おみやげを　わたします。	\N	vmod	\N	\N	\N	2	1
3328	少し　暑いので、　窓を　開けます。	因為有點熱，我要打開窗戶。	\N	すこし　あついので、　まどを　あけます。	\N	vmod	\N	\N	\N	10	1
3329	ドアを　開けて、　部屋に　入ります。	把門打開然後走進房間。	\N	どあを　あけて、　へやに　はいります。	\N	vmod	\N	\N	\N	10	1
3330	この　ボタンを　押すと、　ドアが　開きます。	按這個鈕門就會開。	\N	この　ぼたんを　おすと、　どあが　あきます。	\N	vmod	\N	\N	\N	9	1
3331	危ないので、　あそこの　窓を　開けては　いけません。	因為很危險，不可以把那邊的窗戶打開。	\N	あぶないので、　あそこの　まどを　あけては　いけません。	\N	vmod	\N	\N	\N	613	1
3332	手を　上に　上げます。	把手舉高。	\N	てを　うえに　あげます。	\N	vmod	\N	\N	\N	11	1
3333	使わない　物を　本棚の　上に　上げます。	不用的東西放到書架上面。	\N	つかわない　ものを　ほんだなの　うえに　あげます。	\N	vmod	\N	\N	\N	11	1
3334	あした　林さんは　仕事が　あるので、　来られません。	明天林先生(小姐)有工作所以不能來。	\N	あした　はやしさんは　しごとが　あるので、　こられません。	\N	vmod	\N	\N	\N	37	1
3335	わたしは　今　お金が　ありません。	我現在沒錢。	\N	わたしは　いま　おかねが　ありません。	\N	vmod	\N	\N	\N	37	1
3336	きのう　熱が　あったので、　学校へ　行きませんでした。	因為昨天發燒了，我沒有去學校。	\N	きのう　ねつが　あったので、　がっこうへ　いきませんでした。	\N	vmod	\N	\N	\N	45	1
3337	授業が　終わったら、　友達の　家へ　行きます。	下課後我要去朋友家。	\N	じゅぎょうが　おわったら、　ともだちの　いえへ　いきます。	\N	vmod	\N	\N	\N	45	1
3338	あした　授業で　作文を　書くので、　辞書が　要ります。	因為明天課堂上要寫作文，我需要字典。	\N	あした　じゅぎょうで　さくぶんを　かくので、　じしょが　いります。	\N	vmod	\N	\N	\N	67	1
3339	電車に　乗る　とき、　切符が　要ります。	搭電車時需要車票。	\N	でんしゃに　のる　とき、　きっぷが　いります。	\N	vmod	\N	\N	\N	67	1
3340	スイッチを　入れて、　電気を　つけます。	按下開關、把燈打開。	\N	すいっちを　いれて、　でんきを　つけます。	\N	vmod	\N	\N	\N	817	1
3341	コンピューターの　スイッチを　入れます。	把電腦的電源開關打開。	\N	こんぴゅーたーの　すいっちを　いれます。	\N	vmod	\N	\N	\N	817	1
3342	田中さんの　生まれた　所は　東京です。	田中的出生地在東京。	\N	たなかさんの　うまれた　ところは　とうきょうです。	\N	vmod	\N	\N	\N	77	1
3343	わたしは　八月　二十六日に　生まれました。	我是八月二十六日生的。	\N	わたしは　はちがつ　にじゅうろくにちに　うまれました。	\N	vmod	\N	\N	\N	77	1
3344	あの　店は　おいしい　お菓子を　売って　います。	那家店賣好吃的點心。	\N	あの　みせは　おいしい　おかしを　うって　います。	\N	vmod	\N	\N	\N	79	1
3347	ここに　物を　置いては　いけません。	這裡不可以放東西。	\N	ここに　ものを　おいては　いけません。	\N	vmod	\N	\N	\N	101	1
3348	ここを　押すと、　コーヒーが　出ます。	按這裏咖啡就會出來。	\N	ここを　おすと、　コーヒーが　でます。	\N	vmod	\N	\N	\N	106	1
3349	わたしは　あの　人の　ことを　覚えて　いませんでした。	我不記得那個人了。	\N	わたしは　あの　ひとの　ことを　おぼえて　いませんでした。	\N	vmod	\N	\N	\N	124	1
3350	毎日　テレビを　見て、　日本語を　覚えます。	我每天看電視學日文。	\N	まいにち　てれびを　みて、　にほんごを　おぼえます。	\N	vmod	\N	\N	\N	124	1
3351	仕事が　終わったら、　夕飯を　食べに　行きます。	工作結束後，我要去吃晚飯。	\N	しごとが　おわったら、　ゆうはんを　たべに　いきます。	\N	vmod	\N	\N	\N	130	1
3352	船便で　手紙を　出すと、　とても　時間が　かかります。	用海運寄信的話很花時間。	\N	ふなびんで　てがみを　だすと、　とても　じかんが　かかります。	\N	vmod	\N	\N	\N	144	1
3353	駅から　病院まで　バスで　十分　かかります。	從車站到醫院，坐公車要花十分鐘。	\N	えきから　びょういんまで　ばすで　じゅっぷん　かかります。	\N	vmod	\N	\N	\N	144	1
3354	うちに　電話を　かけましたが、　誰も　いませんでした。	我打電話回家了，可是都沒有人在。	\N	うちに　でんわを　かけましたが、　だれも　いませんでした。	\N	vmod	\N	\N	\N	753	1
3355	今晩　友達に　電話を　かけます。	今晚我會打電話給朋友。	\N	こんばん　ともだちに　でんわを　かけます。	\N	vmod	\N	\N	\N	753	1
3356	ストーブが　消えたので、　すぐ　つけました。	因為暖爐熄了，我馬上又打開。	\N	すとーぶが　きえたので、　すぐ　つけました。	\N	vmod	\N	\N	\N	182	1
3357	部屋の　電気が　消えて　しまいました。	房間的電燈關了。	\N	へやの　でんきが　きえて　しまいました。	\N	vmod	\N	\N	\N	182	1
3358	コンピューターの　スイッチを　切ります。	把電腦開關關掉。	\N	こんぴゅーたーの　すいっちを　きります。	\N	vmod	\N	\N	\N	818	1
3359	電話を　切る　前に、　「さようなら」と　言います。	でんわを　きる　まえに、　「さようなら」と　いいます。	\N	でんわを　きる　まえに、　「さようなら」と　いいます。	\N	vmod	\N	\N	\N	818	1
3360	きのう　友達に　電話を　かけましたが、　すぐ　切りました。	きのう　ともだちに　でんわを　かけましたが、　すぐ　きりました。	\N	きのう　ともだちに　でんわを　かけましたが、　すぐ　きりました。	\N	vmod	\N	\N	\N	818	1
3361	来年の　春、　姉が　結婚します。	明年春天姊姊要結婚。	\N	らいねんの　はる、　あねが　けっこんします。	\N	vmod	\N	\N	\N	225	1
3362	田中さんは　結婚して、　子供が　います。	田中結婚了，有小孩。	\N	たなかさんは　けっこんして、　こどもが　います。	\N	vmod	\N	\N	\N	225	1
3363	公園に　きれいな　花が　たくさん　咲いて　います。	公園裡開著很多漂亮的花。	\N	こうえんに　きれいな　はなが　たくさん　さいて　います。	\N	vmod	\N	\N	\N	266	1
3364	この　花は　春に　なると、　咲きます。	這花到了春天就會開。	\N	この　はなは　はるに　なると、　さきます。	\N	vmod	\N	\N	\N	266	1
3365	外国で　パスポートを　なくしたので、　困りました。	因為在國外把護照弄丟了，很傷腦筋。	\N	がいこくで　ぱすぽーとを　なくしたので、　こまりました。	\N	vmod	\N	\N	\N	254	1
3366	雨が　降って　いるので、　傘を　さして、　学校へ　行きます。	因為下雨了，我要撐傘去學校。	\N	あめが　ふって　いるので、　かさを　さして、　がっこうへ　いきます。	\N	vmod	\N	\N	\N	269	1
3367	大学の　前に　大きな　本屋が　できました。	大學前面開了一家很大的書店。	\N	だいがくの　まえに　おおきな　ほんやが　できました。	\N	vmod	\N	\N	\N	799	1
3368	部屋に　入ったら、　ドアを　閉めます。	近了房間之後把門關上。	\N	へやに　はいったら、　どあを　しめます。	\N	vmod	\N	\N	\N	750	1
3369	小林さんは　その　レストランを　知りませんでした。	小林不知道那家餐廳。	\N	こばやしさんは　その　れすとらんを　しりませんでした。	\N	vmod	\N	\N	\N	308	1
3370	わたしは　山田さんの　電話番号を　知って　います。	我知道山田的電話號碼。	\N	わたしは　やまださんの　でんわばんごうを　しって　います。	\N	vmod	\N	\N	\N	308	1
3371	立って、　歌を　歌います。	站著唱歌。	\N	たって、　うたを　うたいます。	\N	vmod	\N	\N	\N	373	1
3372	あそこに　木村さんが　立って　います。	木村站在那裡。	\N	あそこに　きむらさんが　たって　います。	\N	vmod	\N	\N	\N	373	1
3373	田中さんは　林さんに　仕事を　頼まれました。	田中被林先生(小姐)拜託去做一件工作。	\N	たなかさんは　はやしさんに　しごとを　たのまれました。	\N	vmod	\N	\N	\N	377	1
3374	母は　いつも　わたしに　買い物を　頼みます。	媽媽總是叫我去買東西。	\N	ははは　いつも　わたしに　かいものを　たのみます。	\N	vmod	\N	\N	\N	377	1
3375	日本と　外国は　ことばが　違います。	日本跟國外的語言是不一樣的。	\N	にほんと　がいこくは　ことばが　ちがいます。	\N	vmod	\N	\N	\N	390	1
3376	これは　わたしの　ノートです。	這是我的筆記本。	\N	これは　わたしの　のーとです。	\N	vmod	\N	\N	\N	500	1
3377	今晩は　早く　会社を　出て、　うちへ　帰ります。	今晚我要早一點下班回家。	\N	こんばんは　はやく　かいしゃを　でて、　うちへ　かえります。	\N	vmod	\N	\N	\N	425	1
3378	何でも　好きな　食べ物を　取ります。	喜歡吃的東西就拿。	\N	なんでも　すきな　食べ物を　とります。	\N	vmod	\N	\N	\N	752	1
3379	イさんに　しょうゆを　取って　あげました。	我把醬油拿給了李先生(小姐)。	\N	いさんに　しょうゆを　とって　あげました。	\N	vmod	\N	\N	\N	752	1
3380	この　エレベーターは　二階から　九階まで　止まります。	這個電梯從二樓到九樓都停。	\N	この　えれべーたーは　にかいから　きゅうかいまで　とまります。	\N	vmod	\N	\N	\N	457	1
3381	わたしの　前に　車が　止まりました。	我的前面有一台車停了下來。	\N	わたしの　まえに　くるまが　とまりました。	\N	vmod	\N	\N	\N	457	1
3382	あした　忘れないで、　本を　返します。	明天我不會忘記，會把書還回去。	\N	あした　わすれないで、　ほんを　かえします。	\N	vmod	\N	\N	\N	697	1
3383	きのう　電車に　傘を　忘れました。	昨天我把雨傘忘在電車上面了。	\N	きのう　でんしゃに　かさを　わすれました。	\N	vmod	\N	\N	\N	697	1
3384	分からない　問題が　あるので、　先生に　聞きます。	因為有不懂的問題，我要去問老師。	\N	わからない　もんだいが　あるので、　せんせいに　ききます。	\N	vmod	\N	\N	\N	696	1
3385	イさんは　日本語が　分かります。	李先生(小姐)會日文。	\N	いさんは　にほんごが　わかります。	\N	vmod	\N	\N	\N	696	1
3386	きのう　木村さんに　この　町の　地図を　渡しました。	昨天我把這個小鎮的地圖交給木村了。	\N	きのう　きむらさんに　この　まちの　ちずを　わたしました。	\N	vmod	\N	\N	\N	700	1
3387	タクシーを　一台　呼びます。	我去叫一台計程車。	\N	たくしーを　いちだい　よびます。	\N	vmod	\N	\N	\N	671	1
3388	先生は　山田さんの　名前を　呼びました。	老師叫了山田的名字。	\N	せんせいは　やまださんの　なまえを　よびました。	\N	vmod	\N	\N	\N	671	1
3389	長い　時間　仕事を　して　いたので、　少し　休みました。	因為工作了很長一段時間，我去休息了一下。	\N	ながい　じかん　しごとを　して　いたので、　すこし　やすみました。	\N	vmod	\N	\N	\N	801	1
3390	わたしは　バスを　待って　います。	我正在等公車。	\N	わたしは　ばすを　まって　います。	\N	vmod	\N	\N	\N	610	1
3391	今晩、　わたしは　駅で　小林さんを　待ちます。	今晚我會在車站等小林。	\N	こんばん、　わたしは　えきで　こばやしさんを　まちます。	\N	vmod	\N	\N	\N	610	1
3392	木村さんは　わたしに　写真を　見せて　くれました。	木村把照片給我看了。	\N	きむらさんは　わたしに　しゃしんを　みせて　くれました。	\N	vmod	\N	\N	\N	622	1
3393	週末、　山を　登ります。	しゅうまつ、　やまを　のぼります。	\N	しゅうまつ、　やまを　のぼります。	\N	vmod	\N	\N	\N	501	1
3394	わたしは　あの　山に　登った　ことが　あります。	我有爬過那座山。	\N	わたしは　あの　やまに　のぼった　ことが　あります。	\N	vmod	\N	\N	\N	501	1
3395	週末、　友達と　山に　登ります。	週末要和朋友去爬山。	\N	しゅうまつ、　ともだちと　やまに　のぼります。	\N	vmod	\N	\N	\N	501	1
3396	わたしは　あの　先生に　日本語を　習って　います。	我跟那位老師在學日文。	\N	わたしは　あの　せんせいに　にほんごを　ならって　います。	\N	vmod	\N	\N	\N	480	1
3397	きのう　イさんは　松井さんに　漢字を　習いました。	昨天李先生(小姐)跟松井學了漢字。	\N	きのう　いさんは　まついさんに　かんじを　ならいました。	\N	vmod	\N	\N	\N	480	1
3398	四月から　大学が　始まります。	從四月大學開始上課。	\N	しがつから　だいがくが　はじまります。	\N	vmod	\N	\N	\N	514	1
3399	朝　九時から　授業が　始まります。	早上九點開始上課。	\N	あさ　くじから　じゅぎょうが　はじまります。	\N	vmod	\N	\N	\N	514	1
3400	鳥が　鳴いて　います。	とりが　ないて　います。	\N	とりが　ないて　います。	\N	vmod	\N	\N	\N	470	1
3401	あの　猫は　かわいい　声で　鳴きます。	あの　ねこは　かわいい　こえで　なきます。	\N	あの　ねこは　かわいい　こえで　なきます。	\N	vmod	\N	\N	\N	470	1
3402	本棚に　たくさん　本が　並べて　あります。	書架上排著很多書。	\N	ほんだなに　たくさん　ほんが　ならべて　あります。	\N	vmod	\N	\N	\N	482	1
3403	テーブルに　お皿を　並べます。	把盤子擺在桌子上。	\N	てーぶるに　おさらを　ならべます。	\N	vmod	\N	\N	\N	482	1
3404	レストランの　前に、　人が　大勢　並んで　います。	餐廳前面很很多人在排隊。	\N	れすとらんの　まえに、　ひとが　おおぜい　ならんで　います。	\N	vmod	\N	\N	\N	481	1
3405	きのう　映画を　見るのに、　一時間　並びました。	昨天去看個電影，竟然排了一個小時的隊。	\N	きのう　えいがを　みるのに、　いちじかん　ならびました。	\N	vmod	\N	\N	\N	481	1
3406	大学を　出たら、　医者に　なりたいです。	大學畢業之後我想當醫生。	\N	だいがくを　でたら、　いしゃに　なりたいです。	\N	vmod	\N	\N	\N	483	1
3407	夏に　なると、　暑く　なります。	到了夏天就會變熱。	\N	なつに　なると、　あつく　なります。	\N	vmod	\N	\N	\N	483	1
3408	来年　わたしは　大学を　出ます。	我明年畢業。	\N	らいねん　わたしは　だいがくを　でます。	\N	vmod	\N	\N	\N	425	1
3409	月曜日は　朝から　学校へ　行きます。	星期一從早上我就要去學校。	\N	げつようびは　あさから　がっこうへ　いきます。	\N	vmod	\N	\N	\N	226	1
3410	火曜日までに　本を　返さなければ　なりません。	星期二以前不還書不行。	\N	かようびまでに　ほんを　かえさなければ　なりません。	\N	vmod	\N	\N	\N	167	1
3411	あそこの　病院は　水曜日と　日曜日が　休みです。	那家醫院星期三跟星期天休息。	\N	あそこの　びょういんは　すいようびと　にちようびが　やすみです。	\N	vmod	\N	\N	\N	313	1
3412	木曜日の　午後、　銀行へ　お金を　振り込みに　行きます。	星期四下午我要去銀行匯錢。	\N	もくようびの　ごご、　ぎんこうへ　おかねを　ふりこみに　いきます。	\N	vmod	\N	\N	\N	641	1
3413	次の　日が　休みなので、　金曜日は　いつも　友達と　遊びます。	因為隔天放假，星期五我總是跟朋友去玩。	\N	つぎの　ひが　やすみなので、　きんようびは　いつも　ともだちと　あそびます。	\N	vmod	\N	\N	\N	203	1
3414	土曜日は　林さんの　家で　晩ごはんを　食べます。	星期六我要在林先生(小姐)家裡吃晚飯。	\N	どようびは　はやしさんの　いえで　ばんごはんを　たべます。	\N	vmod	\N	\N	\N	459	1
3415	先週、　母の　誕生日でした。	上個星期是媽媽的生日。	\N	せんしゅう、　ははの　たんじょうびでした。	\N	vmod	\N	\N	\N	340	1
3416	今週、　日本語の　授業は　休みです。	這個星期不用上日文課。	\N	こんしゅう、　にほんごの　じゅぎょうは　やすみです。	\N	vmod	\N	\N	\N	258	1
3417	来週　テストが　あるので、　勉強します。	下個星期有考試，所以我要唸書。	\N	らいしゅう　てすとが　あるので、　べんきょうします。	\N	vmod	\N	\N	\N	676	1
3418	来週、　姉が　結婚します。	下個星期姊姊要結婚了。	\N	らいしゅう、　あねが　けっこんします。	\N	vmod	\N	\N	\N	676	1
3419	毎週　土曜日、　サッカーの　練習を　します。	我每個星期六練習足球。	\N	まいしゅう　どようび、　さっかーの　れんしゅうを　します。	\N	vmod	\N	\N	\N	599	1
3420	去年、　友達と　海外旅行に　行きました。	去年我跟朋友去國外旅行了。	\N	きょねん、　ともだちと　かいがいりょこうに　いきました。	\N	vmod	\N	\N	\N	197	1
3421	おととい　デパートで　新しい　靴を　買いました。	前天我在百貨公司賣了新鞋子。	\N	おととい　でぱーとで　あたらしい　くつを　かいました。	\N	vmod	\N	\N	\N	114	1
3422	おととい　寒かったので、　雪が　降りました。	因為前天很冷，都下雪了。	\N	おととい　さむかったので、　ゆきが　ふりました。	\N	vmod	\N	\N	\N	114	1
3423	きのう　駅前に　新しい　レストランが　できました。	昨天車站前面開了一家新餐廳。	\N	きのう　えきまえに　あたらしい　れすとらんが　できました。	\N	vmod	\N	\N	\N	190	1
3424	きのう　母に　手紙を　出しました。	昨天我寄了一封信給媽媽。	\N	きのう　ははに　てがみを　だしました。	\N	vmod	\N	\N	\N	190	1
3425	きょう　かぜで　学校を　休みました。	今天因為感冒，我跟學校請了假。	\N	きょう　かぜで　がっこうを　やすみました。	\N	vmod	\N	\N	\N	194	1
3426	きょう　イさんと　映画を　見に　行きます。	今天我要跟李先生(小姐)去看電影。	\N	きょう　いさんと　えいがを　みに　いきます。	\N	vmod	\N	\N	\N	194	1
3427	あしたから　毎日　漢字を　勉強します。	從明天開始我要每天學漢字。	\N	あしたから　まいにち　かんじを　べんきょうします。	\N	vmod	\N	\N	\N	16	1
3428	あした　大使館へ　行かなければ　なりません。	明天不能不去大使館。	\N	あした　たいしかんへ　いかなければ　なりません。	\N	vmod	\N	\N	\N	16	1
3429	あさって　海へ　泳ぎに　行こうと　思って　います。	後天我想去海邊游泳。	\N	あさって　うみへ　およぎに　いこうと　おもって　いま。	\N	vmod	\N	\N	\N	14	1
3430	あさって　野球の　試合が　あります。	後天有棒球比賽。	\N	あさって　やきゅうの　しあいが　あります。	\N	vmod	\N	\N	\N	14	1
3431	ゆうべは　疲れて　いたので、　早く　寝ました。	因為昨晚很累，很早就睡了。	\N	ゆうべは　つかれて　いたので、　はやく　ねました。	\N	vmod	\N	\N	\N	661	1
3432	ゆうべ　木村さんと　晩ごはんを　食べに　行きました。	昨晚我和木村去吃晚飯了。	\N	ゆうべ　きむらさんと　ばんごはんを　たべに　いきました。	\N	vmod	\N	\N	\N	661	1
3433	来週から　毎日　テストが　あります。	下星期開始每天都有考試。	\N	らいしゅうから　まいにち　てすとが　あります。	\N	vmod	\N	\N	\N	602	1
3434	毎朝　新聞を　読んで、　会社へ　行きます。	我每天早上看報紙，然後去上班。	\N	まいあさ　しんぶんを　よんで　かいしゃへ　いきます。	\N	vmod	\N	\N	\N	598	1
3435	毎朝　六時に　起きます。	我每天早上六點起床。	\N	まいあさ　ろくじに　おきます。	\N	vmod	\N	\N	\N	598	1
3436	毎晩　寝る　前に　本を　読みます。	每晚睡前我會看書。	\N	まいばん　ねる　まえに　ほんを　よみます。	\N	vmod	\N	\N	\N	603	1
3437	毎晩　二時間　英語の　勉強を　します。	每天晚上我都讀兩小時英文。	\N	まいばん　にじかん　えいごの　べんきょうを　します。	\N	vmod	\N	\N	\N	603	1
3438	この　ホテルは　一日　七千八百円です。	這家飯店住一天要七千八百日圓。	\N	この　ほてるは　いちにち　ななせんはっぴゃくえんです。	\N	vmod	\N	\N	\N	54	1
3439	きのうは　雨だったので、　一日　家に　いました。	昨天下雨，我一整天都待在家裡。	\N	きのうは　あめだったので、　いちにち　いえに　いました。	\N	vmod	\N	\N	\N	54	1
3440	あそこの　八百屋は　毎月　１４日が　安いです。	あそこの　やおやは　まいつき　じゅうよっかが　やすいです。	\N	あそこの　やおやは　まいつき　じゅうよっかが　やすいです。	\N	vmod	\N	\N	\N	488	1
3441	母は　十一月　二十九日に　生まれました。	媽媽是十一月二十九日出生的。	\N	ははは　じゅういちがつ　にじゅうくにちに　うまれました。	\N	vmod	\N	\N	\N	488	1
3442	けさ　ごはんを　食べないで、　家を　出ました。	今天早上我沒有吃飯就出門了。	\N	けさ　ごはんを　たべないで、　いえを　でました。	\N	vmod	\N	\N	\N	221	1
3443	けさは　いい　天気です。	今天早上天氣很好。	\N	けさは　いい　てんきです。	\N	vmod	\N	\N	\N	221	1
3444	今晩　友達が　うちに　泊まります。	今晚朋友要來我家住。	\N	こんばん　ともだちが　うちに　とまります。	\N	vmod	\N	\N	\N	260	1
3445	今晩は　とても　寒いです。	今晚很冷。	\N	こんばんは　とても　さむいです。	\N	vmod	\N	\N	\N	260	1
3446	きょうは　朝から　夕方まで　授業が　ありました。	今天從早上到傍晚都有課。	\N	きょうは　あさから　ゆうがたまで　じゅぎょうが　ありました。	\N	vmod	\N	\N	\N	12	1
3447	いつも　朝　八時の　電車に　乗ります。	我總是搭早上八點的電車。	\N	いつも　あさ　はちじの　でんしゃに　のります。	\N	vmod	\N	\N	\N	12	1
3448	きのうの　昼、　木村さんと　喫茶店へ　行きました。	昨天中午我和木村去咖啡店了。	\N	きのうの　ひる、　きむらさんと　きっさてんへ　いきました。	\N	vmod	\N	\N	\N	554	1
3449	毎日　昼は　一時間　休みます。	每天中午休息一個小時。	\N	まいにち　ひるは　いちじかん　やすみます。	\N	vmod	\N	\N	\N	554	1
3450	夕方までに　この　仕事を　やらなければ　なりません。	傍晚以前不做這個工作不行。	\N	ゆうがたまでに　この　しごとを　やらなけれな　なりません。	\N	vmod	\N	\N	\N	658	1
3451	夕方　公園へ　散歩に　行きました。	傍晚我去公園散步了。	\N	ゆうがた　こうえんへ　さんぽに　いきました。	\N	vmod	\N	\N	\N	658	1
3452	あそこの　スーパーは　夜も　開いて　います。	那家超級市場晚上也有開。	\N	あそこの　すーぱーは　よるも　あいて　います。	\N	vmod	\N	\N	\N	673	1
3453	もう　夜　十二時ですが、　勉強します。	雖然已經十二點了，我還是要唸書。	\N	もう　よる　じゅうにじですが、　べんきょうします。	\N	vmod	\N	\N	\N	673	1
3454	父は　毎日　朝から　晩まで　仕事を　して　います。	爸爸每天從早工作到晚。	\N	ちちは　まいにち　あさから　ばんまで　しごとを　して　います。	\N	vmod	\N	\N	\N	708	1
3455	きのうの　晩、　遅くまで　勉強しました。	昨天晚上我唸書唸到很晚。	\N	きのうの　ばん、　おそくまで　べんきょうしました。	\N	vmod	\N	\N	\N	708	1
3456	あしたは　午前中　学校に　います。	我明天上午在學校。	\N	あしたは　ごぜんちゅう　がっこうに　います。	\N	vmod	\N	\N	\N	242	1
3457	今、　午前　七時です。	現在是上午七點。	\N	いま、　ごぜん　しちじです。	\N	vmod	\N	\N	\N	242	1
3458	今、　午後　七時です。	現在是下午七點。	\N	いま、　ごご　しちじです。	\N	vmod	\N	\N	\N	239	1
3459	けさは　時間が　あるので、　新聞を　読んでから、　家を　出ます。	今天早上有時間，所以我要看個報紙之後再出門。	\N	けさは　じかんが　あるので、　しんぶんを　よんでから、　いえを　でます。	\N	vmod	\N	\N	\N	282	1
3460	仕事が　忙しいので、　遊ぶ　時間が　ありません。	工作太忙了，所以沒有時間玩。	\N	しごとが　いそがしいので、　あそぶ　じかんが　ありません。	\N	vmod	\N	\N	\N	282	1
3461	きのうは　一日中　テレビを　見て　いました。	きのうは　いちにちじゅう　てれびを　みて　いました。	\N	きのうは　いちにちじゅう　てれびを　みて　いました。	\N	vmod	\N	\N	\N	397	1
3462	授業中は　先生の　話を　よく　聞かなければ　なりません。	上課中要好好地聽老師講的話。	\N	じゅぎょうちゅうは　せんせいの　はなしを　よく　きかなければ　なりません。	\N	vmod	\N	\N	\N	397	1
3463	家から　学校まで　電車で　一時間　かかります。	從家裡到學校搭電車要花一個小時。	\N	いえから　がっこうまで　でんしゃで　いちじかん　かかります。	\N	vmod	\N	\N	\N	746	1
3464	きのうは　八時間　寝ました。	昨天睡了八個小時。	\N	きのうは　はちじかん　ねました。	\N	vmod	\N	\N	\N	746	1
3465	家へ　帰ったら、　先に　シャワーを　浴びます。	回家之後我要先沖個澡。	\N	いえへ　かえったら、　さきに　しゃわーを　あびます。	\N	vmod	\N	\N	\N	265	1
3466	電車に　乗る　ときは、　降りる　人が　先です。	搭電車的時候，下車的人優先。	\N	でんしゃに　のる　ときは、　おりる　ひとが　さきです。	\N	vmod	\N	\N	\N	265	1
3467	砂糖を　入れたら、　次に　しょうゆを　少し　入れます。	加糖進去之後，接下來放醬油。	\N	さとうを　いれたら、　つぎに　しょうゆを　すこし　いれます。	\N	vmod	\N	\N	\N	403	1
3468	次　この　雑誌は　山田さんに　貸します。	接下來這本雜誌要借給山田。	\N	つぎ　この　ざっしは　やまださんに　かします。	\N	vmod	\N	\N	\N	403	1
3469	あとで　図書館へ　本を　返しに　行きます。	待會我要去圖書館還書。	\N	あとで　としょかんへ　ほんを　かえしに　いきます。	\N	vmod	\N	\N	\N	25	1
3470	あと　五分で　授業が　終わります。	還有五分鐘下課。	\N	あと　ごふんで　じゅぎょうが　おわります。	\N	vmod	\N	\N	\N	25	1
3471	この　ドアは　開きません。	この　どあは　あきません。	\N	この　どあは　あきません。	\N	vmod	\N	\N	\N	433	1
3472	この　レストランは　大きくて、　きれいです。	這家餐廳又大又漂亮。	\N	この　れすとらんは　おおきくて、　きれいです。	\N	vmod	\N	\N	\N	94	1
3473	小さい　動物は　とても　かわいいです。	小動物很可愛。	\N	ちいさい　どうぶつは　とても　かわいいです。	\N	vmod	\N	\N	\N	387	1
3474	わたしの　うちは　小さくて、　狭いです。	我家又小又窄。	\N	わたしの　うちは　ちいさくて、　せまいです。	\N	vmod	\N	\N	\N	387	1
3475	暗い　ところで　本を　読んでは　いけません。	くらい　ところで　ほんを　よんでは　いけません。	\N	くらい　ところで　ほんを　よんでは　いけません。	\N	vmod	\N	\N	\N	7	1
3476	夜は　暗いので、　危ないです。	晚上暗暗的很危險。	\N	よるは　くらいので、　あぶないです。	\N	vmod	\N	\N	\N	7	1
3477	明るい　所で　勉強します。	我要在亮的地方看書。	\N	あかるい　ところで　べんきょうします。	\N	vmod	\N	\N	\N	7	1
3478	この　教室は　明るくて、　きれいです。	這間教室明亮又乾淨。	\N	この　きょうしつは　あかるくて、　きれいです。	\N	vmod	\N	\N	\N	7	1
3479	この　紅茶は　熱いです。	這杯紅茶是熱的。	\N	この　こうちゃは　あついです。	\N	vmod	\N	\N	\N	706	1
3480	熱い　お茶が　飲みたいです。	我想喝熱紅茶。	\N	あつい　おちゃが　のみたいです。	\N	vmod	\N	\N	\N	706	1
3481	毎朝　冷たい　牛乳を　一杯　飲みます。	我每天早上喝一杯冰牛奶。	\N	まいあさ　つめたい　ぎゅうにゅうを　いっぱい　のみます。	\N	vmod	\N	\N	\N	410	1
3482	プールの　水は　冷たいです。	游泳池的水很冷。	\N	ぷーるの　みずは　つめたいです。	\N	vmod	\N	\N	\N	410	1
3483	公園に　太い　木が　あります。	公園裡有很粗的樹木。	\N	こうえんに　ふとい　きが　あります。	\N	vmod	\N	\N	\N	566	1
3484	毎朝　走って　いるので、　少し　細く　なりました。	因為每天早上跑步，變瘦一點了。	\N	まいあさ　はしって　いるので、　すこし　ほそく　なりました。	\N	vmod	\N	\N	\N	591	1
3485	あの　人は　足が　細くて、　長いです。	那個人的腳細細長長的。	\N	あの　ひとは　あしが　ほそくて、　ながいです。	\N	vmod	\N	\N	\N	591	1
3486	この　雑誌は　厚くて、　重いです。	這本雜誌又厚又重。	\N	この　ざっしは　あつくて、　おもいです。	\N	vmod	\N	\N	\N	23	1
3487	この　ペンは　太いです。	這隻筆很粗。	\N	この　ぺんは　ふといです。	\N	vmod	\N	\N	\N	566	1
3489	薄い　辞書を　買いました。	我買了一本薄的字典。	\N	うすい　じしょを　かいました。	\N	vmod	\N	\N	\N	73	1
3490	この　部屋の　壁は　薄いので、　小さい　声で　話します。	因為這個房間的牆壁很薄，我會小聲一點說話。	\N	この　へやの　かべは　うすいので、　ちいさい　こえで　はなします。	\N	vmod	\N	\N	\N	73	1
3491	重い　箱は　男の　人が　持ちます。	重的箱子男人去拿。	\N	おもい　はこは　おとこの　ひとが　もちます。	\N	vmod	\N	\N	\N	126	1
3492	この　かばんは　大きくて、　重いです。	這個包包又大又重。	\N	この　かばんは　おおきくて、　おもいです。	\N	vmod	\N	\N	\N	126	1
3493	わたしは　軽い　靴が　欲しいです。	我想要一雙輕的鞋子。	\N	わたしは　かるい　くつが　ほしいです。	\N	vmod	\N	\N	\N	172	1
3494	木村さんの　荷物は　小さくて、　軽いです。	木村的行李又小又輕。	\N	きむらさんの　にもつは　ちいさくて、　かるいです。	\N	vmod	\N	\N	\N	172	1
3495	山田さんは　クラスで　いちばん　背が　高いです。	山田在班上是最高的。	\N	やまださんは　くらすで　いちばん　せが　たかいです。	\N	vmod	\N	\N	\N	367	1
3496	わたしは　高い　所に　住みたいです。	我想住在高的地方  /  我想住在貴的地方 (?)	\N	わたしは　たかい　ところに　すみたいです。	\N	vmod	\N	\N	\N	367	1
3497	今晩は　長い　時間　勉強しようと　思って　います。	今晚我打算唸書唸很久。	\N	こんばんは　ながい　じかん　べんきょうしようと　おもって　います。	\N	vmod	\N	\N	\N	805	1
3498	きのうの　授業は　長かったです。	昨天課上得好久。	\N	きのうの　じゅぎょうは　ながかったです。	\N	vmod	\N	\N	\N	805	1
3499	あの　背が　低い　人は　木村さんです。	那位個子矮的人是木村。	\N	あの　せが　ひくい　ひとは　きむらさんです。	\N	vmod	\N	\N	\N	542	1
3500	この　山は　低いです。	這座山很低。	\N	この　やまは　ひくいです。	\N	vmod	\N	\N	\N	542	1
3501	短い　時間で　この　仕事を　やらなければ　なりません。	必須在短時間之內做這項工作不行。	\N	みじかい　じかんで　この　しごとを　やらなければ　なりません。	\N	vmod	\N	\N	\N	804	1
3502	一日は　とても　短いです。	一天是很短暫的。	\N	いちにちは　とても　みじかいです。	\N	vmod	\N	\N	\N	804	1
3503	この　映画は　あまり　よくなかったです。	這部電影不是很好看。	\N	この　えいがは　あまり　よくなかったです。	\N	vmod	\N	\N	\N	40	1
3504	わたしは　いい　店を　知って　います。	我知道一家好店。	\N	わたしは　いい　みせを　しって　います。	\N	vmod	\N	\N	\N	40	1
3505	この　コンピューターは　高いですが、　とても　いいです。	這台電腦很貴，但是很好。	\N	この　こんぴゅーたーは　たかいですが、　とても　いいです。	\N	vmod	\N	\N	\N	40	1
3506	これは　体に　悪い　食べ物です。	這是對身體不好的食物。	\N	これは　からだに　わるい　たべものです。	\N	vmod	\N	\N	\N	702	1
3507	きょうは　天気が　悪いです。	今天天氣不好。	\N	きょうは　てんきが　わるいです。	\N	vmod	\N	\N	\N	702	1
3508	山田さんは　おもしろい　人です。	山田是個有趣的人。	\N	やまださんは　おもしろい　ひとです。	\N	vmod	\N	\N	\N	127	1
3509	この　授業は　とても　おもしろいです。	這門課很有趣。	\N	この　じゅぎょうは　とても　おもしろいです。	\N	vmod	\N	\N	\N	127	1
3510	きのうの　パーティーは　とても　楽しかったです。	昨天的派對很好玩。	\N	きのうの　ぱーてぃーは　とても　たのしかったです。	\N	vmod	\N	\N	\N	376	1
3511	日本語の　勉強は　楽しいです。	學日文很快樂。	\N	にほんごの　べんきょうは　たのしいです。	\N	vmod	\N	\N	\N	376	1
3512	友達に　つまらない　話を　聞きました。	從朋友那邊聽到了很無聊的話。	\N	ともだちに　つまらない　はなしを　ききました。	\N	vmod	\N	\N	\N	409	1
3513	この　本は　つまらないです。	這本書很無趣。	\N	この　ほんは　つまらないです。	\N	vmod	\N	\N	\N	409	1
3514	きのう　嫌な　話を　聞きました。	昨天聽到了討厭的事情。	\N	きのう　いやな　はなしを　ききました。	\N	vmod	\N	\N	\N	65	1
3515	わたしは　掃除や　洗濯を　するのが　嫌です。	我不喜歡打掃和洗衣服。	\N	わたしは　そうじや　せんたくを　するのが　いやです。	\N	vmod	\N	\N	\N	65	1
3516	これは　小林さんの　大好きな　食べ物です。	這是小林很喜歡吃的東西。	\N	これは　こばやしさんの　だいすきな　たべものです。	\N	vmod	\N	\N	\N	363	1
3517	わたしは　動物が　大好きです。	我很喜歡動物。	\N	わたしは　どうぶつが　だいすきです。	\N	vmod	\N	\N	\N	363	1
3518	わたしは　静かで、　きれいな　所へ　行きたいです。	我想去安靜又漂亮的地方。	\N	わたしは　しずかで、　きれいな　ところへ　いきたいです。	\N	vmod	\N	\N	\N	285	1
3519	松井さんは　静かな　町に　住んで　います。	松井住在安靜的小鎮上。	\N	まついさんは　しずかな　まちに　すんで　います。	\N	vmod	\N	\N	\N	285	1
3520	ここは　大きくて　にぎやかな　町です。	這裡是又大又熱鬧的城鎮。	\N	ここは　おおきくて　にぎやかな　まちです。	\N	vmod	\N	\N	\N	485	1
3521	隣の　教室は　とても　にぎやかです。	隔壁教室很熱鬧。	\N	となりの　きょうしつは　とても　にぎやかです。	\N	vmod	\N	\N	\N	485	1
3522	隣の　家の　犬が　うるさいので、　勉強できません。	鄰居的狗太吵了，沒辦法看書。	\N	となりの　いえの　いぬが　うるさいので、　べんきょうできません。	\N	vmod	\N	\N	\N	80	1
3523	授業中、　あの　人は　いつも　うるさいです。	上課中那個人總是很吵。	\N	じゅぎょうちゅう、　あの　ひとは　いつも　うるさいです。	\N	vmod	\N	\N	\N	80	1
3524	林さんは　人が　多い　町に　住んで　います。	林先生(小姐)住在人多的城鎮。	\N	はやしさんは　ひとが　おおい　まちに　すんで　います。	\N	vmod	\N	\N	\N	93	1
3525	この　学校は　留学生が　多いです。	這所學校留學生很多。	\N	この　がっこうは　りゅうがくせいが　おおいです。	\N	vmod	\N	\N	\N	93	1
3526	人が　少ない　所へ　行きたいです。	我想去人少的地方。	\N	ひとが　すくない　ところへ　いきたいです。	\N	vmod	\N	\N	\N	319	1
3527	あそこの　スーパーは　魚が　少ないです。	那家超市魚很少。	\N	あそこの　すーぱーは　さかなが　すくないです。	\N	vmod	\N	\N	\N	319	1
3528	きょうは　早い　時間に　家を　出ます。	今天我要早一點出門。	\N	きょうは　はやい　じかんに　いえを　でます。	\N	vmod	\N	\N	\N	528	1
3529	あした　朝　早く　起きます。	我早上很早起床。	\N	あした　あさ　はやく　おきます。	\N	vmod	\N	\N	\N	528	1
3530	きのうは　疲れて　いたので、　今朝　遅く　起きました。	因為昨天很累，今天早上我很晚才起床。	\N	きのうは　つかれて　いたので、　けさ　おそく　おきました。	\N	vmod	\N	\N	\N	798	1
3531	もう　遅いので、　家へ　帰ります。	已經很晚了，我要回家了。	\N	もう　おそいので、　いえへ　かえります。	\N	vmod	\N	\N	\N	798	1
3532	わたしは　毎朝　卵を　一つ　食べます。	我每天早上吃一個蛋。	\N	わたしは　まいあさ　たまごを　ひとつ　たべます。	\N	vmod	\N	\N	\N	546	1
3533	テーブルの　上に　花瓶を　二つ　並べます。	在桌子上排兩個花瓶。	\N	てーぶるの　うえに　かびんを　ふたつ　ならべます。	\N	vmod	\N	\N	\N	562	1
3534	この　問題の　答えは　三つ　あります。	這個問題有三個答案。	\N	この　もんだいの　こたえは　みっつ　あります。	\N	vmod	\N	\N	\N	625	1
3535	レストランで　料理を　四つ　頼みます。	在餐廳點四樣菜。	\N	れすとらんで　りょうりを　よっつ　たのみます。	\N	vmod	\N	\N	\N	670	1
3536	田中さんは　ケーキを　五つ　買いました。	田中買了五個蛋糕。	\N	たなかさんは　けーきを　いつつ　かいました。	\N	vmod	\N	\N	\N	59	1
3537	部屋に　箱が　六つ　置いて　あります。	房間裡面放著六個箱子。	\N	へやに　はこが　むっつ　おいて　あります。	\N	vmod	\N	\N	\N	635	1
3538	木村さんは　お菓子を　七つ　作りました。	木村做了七份點心。	\N	きむらさんは　おかしを　ななつ　つくりました。	\N	vmod	\N	\N	\N	476	1
3539	わたしは　旅行の　お土産を　八つ　買わなければ　なりません。	旅行的禮物我必須買八個才行。	\N	わたしは　りょこうの　おみやげを　やっつ　かわなければ　なりません。	\N	vmod	\N	\N	\N	655	1
3540	この　教室に　かばんが　九つ　あります。	這間教室裡面有九個包包。	\N	この　きょうしつに　かばんが　ここのつ　あります。	\N	vmod	\N	\N	\N	241	1
3541	八月　一日から　夏休みです。	從八月一日開始放暑假。	\N	はちがつ　ついたちから　なつやすみです。	\N	vmod	\N	\N	\N	400	1
3542	田中さんは　来月　二日に　海外へ　行きます。	田中下個月二號要去國外。	\N	たなかさんは　らいげつ　ふつかに　かいがいへ　いきます。	\N	vmod	\N	\N	\N	565	1
3543	五月　三日から　五月　五日まで　学校や　会社は　休みです。	從五月三日到五月五日學校和公司都放假。	\N	ごがつ　みっかから　ごがつ　いつかまで　がっこうや　かいしゃは　やすみです。	\N	vmod	\N	\N	\N	624	1
3544	四日までに　英語で　作文を　書かなければ　なりません。	四號以前我必須用英文把作文寫完。	\N	よっかまでに　えいごで　さくぶんを　かかなければ　なりません。	\N	vmod	\N	\N	\N	669	1
3545	父の　誕生日は　六月　五日です。	爸爸的生日是六月五日。	\N	ちちの　たんじょうびは　ろくがつ　いつかです。	\N	vmod	\N	\N	\N	57	1
3546	この　八百屋は　毎月　八日が　安いです。	這家蔬果店每個月八號都很便宜。	\N	この　やおやは　まいつき　ようかが　やすいです。	\N	vmod	\N	\N	\N	665	1
3547	六日に　郵便局で　荷物を　送りました。	六號那一天我在郵局把行李寄出去了。	\N	むいかに　ゆうびんきょくで　にもつを　おくりました。	\N	vmod	\N	\N	\N	632	1
3548	七日までに　お金の　振り込みを　します。	七號以前我會把錢匯出去。	\N	なのかまでに　おかねの　ふりこみを　します。	\N	vmod	\N	\N	\N	478	1
3549	来月　九日に　両親が　わたしの　うちへ　遊びに　来ます。	下個月九號我爸媽要來我這裡玩。	\N	らいげつ　ここのかに　りょうしんが　わたしの　うちへ　あそびに　きます。	\N	vmod	\N	\N	\N	240	1
3550	十日までに　この　仕事を　しなければ　なりません。	十號以前我必須把這個工作做完。	\N	とおかまでに　この　しごとを　しなければ　なりません。	\N	vmod	\N	\N	\N	442	1
3551	今月　二十日に　日本語の　テストが　あります。	這個月二十號有日文的考試。	\N	こんげつ　はつかに　にほんごの　てすとが　あります。	\N	vmod	\N	\N	\N	523	1
3552	イさんは　日本に　一人で　住んで　います。	李先生(小姐)在日本一個人住。	\N	いさんは　にほんに　ひとりで　すんで　います。	\N	vmod	\N	\N	\N	548	1
3553	教室に　学生が　一人　います。	教室裡有一個學生。	\N	きょうしつに　がくせいが　ひとり　います。	\N	vmod	\N	\N	\N	548	1
3554	あした　木村さんと　二人で　プールへ　行きます。	明天我和木村兩個人要去游泳池。	\N	あした　きむらさんと　ふたりで　ぷーるへ　いきます。	\N	vmod	\N	\N	\N	564	1
3555	家の　前に　知らない　人が　二人　います。	房子前面有兩個不認識的人。	\N	いえの　まえに　しらない　ひとが　ふたり　います。	\N	vmod	\N	\N	\N	564	1
3556	日本では　二十歳から　お酒が　飲めます。	在日本二十歲以上可以喝酒。	\N	にほんでは　はたちから　おさけが　のめます。	\N	vmod	\N	\N	\N	520	1
3557	来月　わたしの　弟は　二十歳に　なります。	下個月我弟弟就二十歲了。	\N	らいげつ　わたしの　おとうとは　はたちに　なります。	\N	vmod	\N	\N	\N	520	1
3558	毎日　三回　ごはんを　食べます。	每天吃三次飯。	\N	まいにち　さんかい　ごはんを　たべます。	\N	vmod	\N	\N	\N	134	1
3559	一年に　一回　海外へ　行きます。	一年去一次國外。	\N	いちねんに　いっかい　かいがいへ　いきます。	\N	vmod	\N	\N	\N	134	1
3560	この　料理は　卵を　二個　使います。	這道菜要用兩個蛋。	\N	この　りょうりは　たまごを　にこ　つかいます。	\N	vmod	\N	\N	\N	229	1
3561	イさんから　もらった　お菓子を　一個　食べました。	從李先生(小姐)那邊拿到的點心我吃掉一個了。	\N	いさんから　もらった　おかしを　いっこ　たべました。	\N	vmod	\N	\N	\N	229	1
3562	日本では　十八歳から　運転が　できます。	在日本十八歲以上可以開車。	\N	にほんでは　じゅうはっさいから　うんてんが　できます。	\N	vmod	\N	\N	\N	262	1
3563	わたしの　妹は　四歳です。	我妹妹四歲。	\N	わたしの　いもうとは　よんさいです。	\N	vmod	\N	\N	\N	262	1
3564	この　教室には　コンピューターが　七台　あります。	這間教室有七台電腦。	\N	この　きょうしつには　こんぴゅーたーが　ななだい　あります。	\N	vmod	\N	\N	\N	359	1
3565	店の　前に　車が　四台　止まって　います。	店前面停著四輛車。	\N	みせの　まえに　くるまが　よんだい　とまって　います。	\N	vmod	\N	\N	\N	359	1
3566	この　クラスには　学生が　九人　います。	這個班級有九個學生。	\N	この　くらすには　がくせいが　きゅうにん　います。	\N	vmod	\N	\N	\N	813	1
3567	来週　四人で　遊びに　行きます。	下星期四個人要去玩。	\N	らいしゅう　よにんで　あそびに　いきます。	\N	vmod	\N	\N	\N	813	1
3568	スプーンで　三杯　砂糖を　入れます。	用湯匙放三匙砂糖進去。	\N	すぷーんで　さんばい　さとうを　いれます。	\N	vmod	\N	\N	\N	507	1
3569	きのう　二杯　お酒を　飲みました。	昨天喝了兩杯酒。	\N	きのう　にはい　おさけを　のみました。	\N	vmod	\N	\N	\N	507	1
3570	毎朝　一杯　牛乳を　飲みます。	我每天早上喝一杯牛奶。	\N	まいあさ　いっぱい　ぎゅうにゅうを　のみます。	\N	vmod	\N	\N	\N	507	1
3571	きのう　スーパーで　魚を　三匹　買いました。	昨天在超級市場買了三隻魚。	\N	きのう　すーぱーで　さかなを　さんびき　かいました。	\N	vmod	\N	\N	\N	540	1
3572	あそこに　犬が　二匹　います。	那裡有兩條狗。	\N	あそこに　いぬが　にひき　います。	\N	vmod	\N	\N	\N	540	1
3573	林さんの　家に　猫が　一匹　います。	林先生(小姐)家裡有一隻貓。	\N	はやしさんの　いえに　ねこが　いっぴき　います。	\N	vmod	\N	\N	\N	540	1
3574	いつも　学校へ　鉛筆を　三本　持って　行きます。	我都帶著三枝鉛筆去學校。	\N	いつも　がっこうへ　えんぴつを　さんぼん　もって　いきます。	\N	vmod	\N	\N	\N	744	1
3575	家の　庭に　木が　二本　あります。	我家院子裡有兩棵樹。	\N	いえの　にわに　きが　にほん　あります。	\N	vmod	\N	\N	\N	744	1
3576	ごはんを　食べて、　たばこを　一本　吸います。	吃完飯後我會抽一根煙。	\N	ごはんを　たべて、　たばこを　いっぽん　すいます。	\N	vmod	\N	\N	\N	744	1
3577	今　わたしは　四十五キログラム　あります。	現在我四十五公斤。	\N	いま　わたしは　よんじゅうごきろぐらむ　あります。	\N	vmod	\N	\N	\N	201	1
3578	この　荷物は　五キロ　あるので、　重いです。	這件行李有五公斤，很重。	\N	この　にもつは　ごきろ　あるので、　おもいです。	\N	vmod	\N	\N	\N	201	1
3579	駅から　図書館まで　二キロメートル　あります。	從車站到圖書館有兩公里。	\N	えきから　としょかんまで　にきろめーとる　あります。	\N	vmod	\N	\N	\N	742	1
3580	わたしは　毎朝　三キロ　走ります。	我每天早上跑三公里。	\N	わたしは　まいあさ　さんきろ　はしります。	\N	vmod	\N	\N	\N	742	1
3581	砂糖を　三十グラムと　塩を　十五グラム　入れます。	把三十公克的砂糖和十五公克的豬肉放進去。	\N	さとうを　さんじゅうぐらむと　しおを　じゅうごぐらむ　いれます。	\N	vmod	\N	\N	\N	215	1
3582	豚肉を　二百グラム　買います。	我要買兩百公克豬肉。	\N	ぶたにくを　にひゃくぐらむ　かいます。	\N	vmod	\N	\N	\N	215	1
3583	この　本棚は　縦　一メートルと　横　一．五メートル　あります。	這個書架高一公尺寬一點五公尺。	\N	この　ほんだなは　たて　いちめーとると　よこ　いってんごめーとる　あります。	\N	vmod	\N	\N	\N	638	1
3584	山田さんは　百メートル　泳げます。	山田可以游一百公尺。	\N	やまださんは　ひゃくめーとる　およげます。	\N	vmod	\N	\N	\N	638	1
3585	わたしは　小さくて、　かわいい　動物が　好きです。	我喜歡小小的可愛的動物。	\N	わたしは　ちいさくて、　かわいい　どうぶつが　すきです。　	\N	vmod	\N	\N	\N	177	1
3586	木村さんは　とても　かわいいです。	木村很可愛。	\N	きむらさんは　とても　かわいいです。	\N	vmod	\N	\N	\N	177	1
3587	あの　若くて、　元気な　人は　山田さんです。	那個年輕又有精神的人是山田。	\N	あの　わかくて、　げんきな　ひとは　やまださんです。	\N	vmod	\N	\N	\N	695	1
3588	隣の　クラスの　先生は　まだ　若いです。	隔壁班的老師還很年輕。	\N	となりの　くらすの　せんせいは　まだ　わかいです。	\N	vmod	\N	\N	\N	695	1
3589	あそこに　丸い　箱が　あります。	那裡有個圓的箱子。	\N	あそこに　まるい　はこが　あります。	\N	vmod	\N	\N	\N	614	1
3590	この　テーブルは　丸いです。	這個桌子是圓的。	\N	この　てーぶるは　まるいです。	\N	vmod	\N	\N	\N	614	1
3591	今　いちばん　欲しい　物は　新しい　コンピューターです。	現在我最想要的東西是新電腦。	\N	いま　いちばん　ほしい　ものは　あたらしい　こんぴゅーたーです。	\N	vmod	\N	\N	\N	590	1
3592	わたしは　日本語の　辞書が　欲しいです。	我想要的是日文字典。	\N	わたしは　にほんごの　じしょが　ほしいです。	\N	vmod	\N	\N	\N	590	1
3593	イさんは　かぜを　ひいて　いるので、　元気じゃ　ありません。	李先生(小姐)感冒了，所以沒有精神。	\N	いさんは　かぜを　ひいて　いるので、　げんきじゃ　ありません。	\N	vmod	\N	\N	\N	228	1
3594	山田さんは　とても　元気な　人です。	山田是個很有精神的人。	\N	やまださんは　とても　げんきな　ひとです。	\N	vmod	\N	\N	\N	228	1
3595	たくさん　ごはんを　食べれば、　丈夫な　体に　なります。	多吃飯身體就會變強壯。	\N	たくさん　ごはんを　たべれば、　じょうぶな　からだに　なります。	\N	vmod	\N	\N	\N	305	1
3596	山田さんは　丈夫で　元気です。	山田又強壯又有精神。	\N	やまださんは　じょうぶで　げんきです。	\N	vmod	\N	\N	\N	305	1
3597	来月　一緒に　遊ぶので、　イさんに　大丈夫な　日を　教えます。	因為下個月要一起玩，我要告訴小李哪一天沒問題。	\N	らいげつ　いっしょに　あそぶので、　いさんに　だいじょうぶな　ひを　おしえます。	\N	vmod	\N	\N	\N	362	1
3598	きょうは　勉強しなければ　なりませんが、　あしたは　大丈夫です。	今天不能不唸書，不過明天就沒關係了。	\N	きょうは　べんきょうしなければ　なりませんが、　あしたは　だいじょうぶです。	\N	vmod	\N	\N	\N	362	1
3599	この　本は　とても　大切なので、　なくさないで　ください。	這本書很重要，請不要弄丟了。	\N	この　ほんは　とても　たいせつなので、　なくさないで　ください。	\N	vmod	\N	\N	\N	364	1
3600	これは　大切な　手紙です。	這是很重要的一封信。	\N	これは　たいせつな　てがみです。	\N	vmod	\N	\N	\N	364	1
3601	田中さんは　たいへんな　仕事を　して　います。	たなかさんは　たいへんな　しごとを　して　います。	\N	たなかさんは　たいへんな　しごとを　して　います。	\N	vmod	\N	\N	\N	368	1
3602	たくさん　漢字を　覚えなければ　ならないので、　たいへんです。	たくさん　かんじを　おぼえなければ　ならないので、　たいへんです。	\N	たくさん　かんじを　おぼえなければ　ならないので、　たいへんです。	\N	vmod	\N	\N	\N	368	1
3603	田中さんは　大変な　仕事を　して　います。	田中在做一項很辛苦的工作。	\N	たなかさんは　たいへんな　しごとを　して　います。	\N	vmod	\N	\N	\N	366	1
3604	たくさん　漢字を　覚えなければ　ならないので、　大変です。	因為要記很多漢字，很辛苦。	\N	たくさん　かんじを　おぼえなければ　ならないので、　たいへんです。	\N	vmod	\N	\N	\N	366	1
3605	これは　とても　軽くて、　便利な　辞書です。	這是一本很輕而且很方便的字典。	\N	これは　とても　かるくて、　べんりな　じしょです。	\N	vmod	\N	\N	\N	583	1
3606	飛行機は　速くて、　便利です。	飛機又快又方便。	\N	ひこうきは　はやくて、　べんりです。	\N	vmod	\N	\N	\N	583	1
3607	ここは　日本で　とても　有名な　所です。	這裡是日本很有名的地方。	\N	ここは　にほんで　とても　ゆうめいな　ところです。	\N	vmod	\N	\N	\N	662	1
3608	この　大学は　古くて、　有名です。	這所大學很古老而且很有名。	\N	この　だいがくは　ふるくて、　ゆうめいです。	\N	vmod	\N	\N	\N	662	1
3609	今月は　忙しいので、　暇な　日が　ありません。	因為這個月很忙，沒有一天有空。	\N	こんげつは　いそがしいので、　ひまな　ひが　ありません。	\N	vmod	\N	\N	\N	549	1
3610	わたしは　あした　暇なので、　友達と　遊びます。	我明天很閒，所以要跟朋友出去玩。	\N	わたしは　あした　ひまなので、　ともだちと　あそびます。	\N	vmod	\N	\N	\N	549	1
3611	あそこに　ある　物を　使っては　いけません。	在那裡的東西不能用。	\N	あそこに　ある　ものを　つかっては　いけません。	\N	vmod	\N	\N	\N	645	1
3612	木村さんは　かわいい　物が　大好きです。	木村很喜歡可愛的東西。	\N	きむらさんは　かわいい　ものが　だいすきです。	\N	vmod	\N	\N	\N	645	1
3613	わたしは　静かで　きれいな　所に　住みたいです。	我想住在安靜又漂亮的地方。	\N	わたしは　しずかで　きれいな　ところに　すみたいです。	\N	vmod	\N	\N	\N	447	1
3614	ここは　とても　にぎやかな　所です。	這裡是很熱鬧的地方。	\N	ここは　とても　にぎやかな　ところです。	\N	vmod	\N	\N	\N	447	1
3615	きのう　友達に　おもしろい　ニュースを　聞きました。	昨天從朋友那邊聽到了有趣的消息。	\N	きのう　ともだちに　おもしろい　にゅーすを　ききました。	\N	vmod	\N	\N	\N	491	1
3616	けさ　テレビで　ニュースを　見ました。	今天早上我看了電視。	\N	けさ　てれびで　にゅーすを　みました。	\N	vmod	\N	\N	\N	491	1
3617	スーパーで　晩ごはんの　買い物を　しました。	我在超市買了晚飯要用的東西。	\N	すーぱーで　ばんごはんの　かいものを　しました。	\N	vmod	\N	\N	\N	139	1
3618	先週、　姉の　結婚パーティーが　ありました。	上星期舉辦了姊姊的結婚派對。	\N	せんしゅう、　あねの　けっこんぱーてぃーが　ありました。	\N	vmod	\N	\N	\N	506	1
3619	山田さんは　小林さんの　誕生日に　時計を　あげました。	山田在小林生日那天送給了他一隻手錶。	\N	やまださんは　こばやしさんの　たんじょうびに　とけいを　あげました。	\N	vmod	\N	\N	\N	385	1
3620	わたしの　誕生日は　八月　二十六日です。	我的生日是八月二十六日。	\N	わたしの　たんじょうびは　はちがつ　にじゅうろくにちです。	\N	vmod	\N	\N	\N	385	1
3621	この　ノートは　縦より　横の　ほうが　長いです。	這本筆記本的長度比寬度還長	\N	この　のーとは　たてより　よこの　ほうが　ながいです。	\N	vmod	\N	\N	\N	374	1
3622	この　紙を　縦に　切ります。	把這張紙縱切。	\N	この　かみを　たてに　きります。	\N	vmod	\N	\N	\N	374	1
3623	卵に　塩を　つけて　食べます。	沾著鹽吃蛋。	\N	たまごに　しおを　つけて　たべます。	\N	vmod	\N	\N	\N	382	1
3624	わたしは　毎朝　パンと　卵を　食べます。	我每天早上吃麵包和蛋。	\N	わたしは　まいあさ　ぱんと　たまごを　たべます。	\N	vmod	\N	\N	\N	382	1
3625	そこの　戸を　開けては　いけません。	那邊的窗戶不可以關起來。	\N	そこの　とを　あけては　いけません。	\N	vmod	\N	\N	\N	431	1
3626	わたしの　部屋の　戸が　閉まりません。	我房間的窗戶關不起來。	\N	わたしの　へやの　とが　しまりません。	\N	vmod	\N	\N	\N	431	1
3627	この　本は　百二十ページ　あります。	這本書有一百二十頁。	\N	この　ほんは　ひゃくにじゅっぺーじ　あります。	\N	vmod	\N	\N	\N	573	1
3628	木村さんに　電話を　貸して　もらいました。	我從木村那邊借到電話了。	\N	きむらさんに　でんわを　かして　もらいました。	\N	vmod	\N	\N	\N	430	1
3629	あした　イさんに　電話を　します。	明天我會打電話給李先生(小姐)。	\N	あした　いさんに　でんわを　します。	\N	vmod	\N	\N	\N	430	1
3630	たくさん　写真を　撮ったので、　もう　フィルムが　ありません。	因為拍了很多照片，沒有底片了。	\N	たくさん　しゃしんを　とったので、　もう　ふぃるむが　ありません。	\N	vmod	\N	\N	\N	557	1
3631	カメラに　フィルムを　入れます。	把底片裝到照相機裡面。	\N	かめらに　ふぃるむを　いれます。	\N	vmod	\N	\N	\N	557	1
3632	もう　夜　十二時ですから、　小さい　声で　話します。	已經晚上十二點了，小聲講話。	\N	もう　よる　じゅうにじですから、　ちいさい　こえで　はなします。	\N	vmod	\N	\N	\N	235	1
3633	松井さんは　声が　大きいです。	松井的聲音很大。	\N	まついさんは　こえが　おおきいです。	\N	vmod	\N	\N	\N	235	1
3634	背が　低い　人から　並びます。	從身高矮的開始排起。	\N	せが　ひくい　ひとから　ならびます。	\N	vmod	\N	\N	\N	331	1
3635	この　上着には　ポケットが　たくさん　あるので、　便利です。	這件上衣有很多口袋，很方便。	\N	この　うわぎには　ぽけっとが　たくさん　あるので、　べんりです。	\N	vmod	\N	\N	\N	588	1
3636	ポケットの　中に　お金を　入れます。	把錢放到口袋裡面。	\N	ぽけっとの　なかに　おかねを　いれます。	\N	vmod	\N	\N	\N	588	1
3637	出かける　とき、　ハンカチを　持って　行きます。	出門的時候帶著手帕去。	\N	でかける　とき、　はんかちを　もって　いきます。	\N	vmod	\N	\N	\N	535	1
3638	きのう　教室に　ハンカチを　忘れました。	昨天我手帕忘在教室裡面了。	\N	きのう　きょうしつに　はんかちを　わすれました。	\N	vmod	\N	\N	\N	535	1
3639	おふろに　シャンプーが　ありませんでした。	浴室裡面沒有洗髮精了。	\N	おふろに　しゃんぷーが　ありませんでした。	\N	vmod	\N	\N	\N	763	1
3640	せっけんで　手を　洗いました。	用香皂洗手了。	\N	せっけんで　てを　あらいました。	\N	vmod	\N	\N	\N	334	1
3641	おふろに　せっけんが　ありません。	浴室裡面沒有香皂。	\N	おふろに　せっけんが　ありません。	\N	vmod	\N	\N	\N	334	1
3642	マッチを　使って、　たばこを　吸いました。	我用火柴點了煙來抽。	\N	まっちを　つかって、　たばこを　すいました。	\N	vmod	\N	\N	\N	612	1
3643	テーブルの　上に　マッチが　あります。	桌子上面有火柴。	\N	てーぶるの　うえに　まっちが　あります。	\N	vmod	\N	\N	\N	612	1
3644	先週、　イさんと　映画館へ　行って、　映画を　見ました。	上星期我和李先生(小姐)去電影院看電影了。	\N	せんしゅう、　いさんと　えいがかんへ　いって、　えいがを　みました。	\N	vmod	\N	\N	\N	84	1
3645	あの　映画館は　新しくて、　きれいです。	那家電影院又新又漂亮。	\N	あの　えいがかんは　あたらしくて、　きれいです。	\N	vmod	\N	\N	\N	84	1
3646	箱の　中に　ノートや　ペンを　入れます。	把筆記本和筆放到箱子裡面。	\N	はこの　なかに　のーとや　ぺんを　いれます。	\N	vmod	\N	\N	\N	512	1
3647	この　箱は　とても　重いです。	這個箱子很重。	\N	この　はこは　とても　おもいです。	\N	vmod	\N	\N	\N	512	1
3648	この　紙に　問題の　答えを　書きます。	在這張紙上寫問題的解答。	\N	この　かみに　もんだいの　こたえを　かきます。	\N	vmod	\N	\N	\N	165	1
3649	机の　上に　紙と　鉛筆が　あります。	桌子上面有紙和鉛筆。	\N	つくえの　うえに　かみと　えんぴつが　あります。	\N	vmod	\N	\N	\N	165	1
3650	新しい　道が　できたので、　村は　便利に　なりました。	因為開了一條新的道路，村子變得方便多了。	\N	あたらしい　みちが　できたので、　むらは　べんりに　なりました。	\N	vmod	\N	\N	\N	636	1
3651	この　村は　静かで　きれいです。	這個村子又安靜又漂亮。	\N	この　むらは　しずかで　きれいです。	\N	vmod	\N	\N	\N	636	1
3652	先月　隣の　町に　デパートが　できました。	上個月隔壁鎮上有一家百貨公司開幕了。	\N	せんげつ　となりの　まちに　でぱーとが　できました。	\N	vmod	\N	\N	\N	609	1
3653	わたしは　来年から　この　町に　住みます。	我從明年開始要住在這個鎮上。	\N	わたしは　らいねんから　この　まちに　すみます。	\N	vmod	\N	\N	\N	609	1
3654	国に　いる　母から　手紙が　来ました。	收到媽媽從故鄉寄來的信了。	\N	くにに　いる　ははから　てがみが　きました。	\N	vmod	\N	\N	\N	820	1
3655	夏休みは　国へ　帰ります。	暑假我要回國。	\N	なつやすみは　くにへ　かえります。	\N	vmod	\N	\N	\N	820	1
3656	鳥が　水を　飲んで　います。	小鳥在喝水。	\N	とりが　みずを　のんで　います。	\N	vmod	\N	\N	\N	460	1
3657	あそこの　木の　上に　鳥が　います。	那棵樹上有鳥。	\N	あそこの　きの　うえに　とりが　います。	\N	vmod	\N	\N	\N	460	1
3658	林さんの　家には　犬と　猫が　います。	林先生(小姐)家裡有狗和貓。	\N	はやしさんの　いえには　いぬと　ねこが　います。	\N	vmod	\N	\N	\N	497	1
3659	あそこで　猫が　寝て　います。	在那裡有貓在睡覺。	\N	あそこで　ねこが　ねて　います。	\N	vmod	\N	\N	\N	497	1
3660	夕方　犬と　公園へ　散歩に　行きました。	傍晚我和狗去公園散步了。	\N	ゆうがた　いぬと　こうえんへ　さんぽに　いきました。	\N	vmod	\N	\N	\N	61	1
3661	うちの　犬は　とても　大きいです。	我家的狗很大。	\N	うちの　いぬは　とても　おおきいです。	\N	vmod	\N	\N	\N	61	1
3662	きのう　ペットと　遊びました。	昨天我跟寵物一起玩。	\N	きのう　ぺっとと　あそびました。	\N	vmod	\N	\N	\N	576	1
3663	小林さんの　家には　ペットが　います。	小林家裡有寵物。	\N	こばやしさんの　いえには　ぺっとが　います。	\N	vmod	\N	\N	\N	576	1
3664	小さな　動物は　とても　かわいいです。	小動物很可愛。	\N	ちいさな　どうぶつは　とても　かわいいです。	\N	vmod	\N	\N	\N	438	1
3665	わたしは　動物が　大好きです。	我好喜歡好喜歡動物。	\N	わたしは　どうぶつが　だいすきです。	\N	vmod	\N	\N	\N	438	1
3666	あそこの　海は　とても　きれいです。	那邊的海很乾淨。	\N	あそこの　うみは　とても　きれいです。	\N	vmod	\N	\N	\N	78	1
3667	わたしの　両親は　海の　そばに　住んで　います。	我爸媽住在海的旁邊。	\N	わたしの　りょうしんは　うみの　そばに　すんで　います。	\N	vmod	\N	\N	\N	78	1
3668	あの　山には　たくさん　動物が　います。	那座山裡面有很多動物。	\N	あの　やまには　たくさん　どうぶつが　います。	\N	vmod	\N	\N	\N	656	1
3669	学校は　あの　山の　近くに　あります。	學校在那座山附近。	\N	がっこうは　あの　やまの　ちかくに　あります。	\N	vmod	\N	\N	\N	656	1
3670	池の　中に　魚が　います。	池子裡有魚。	\N	いけの　なかに　さかなが　います。	\N	vmod	\N	\N	\N	48	1
3671	公園に　大きな　池が　あります。	公園裡面有個大池塘。	\N	こうえんに　おおきな　いけが　あります。	\N	vmod	\N	\N	\N	48	1
3672	この　花は　赤くて、　きれいです。	這朵花又紅又漂亮。	\N	この　はなは　あかくて、　きれいです。	\N	vmod	\N	\N	\N	725	1
3673	木村さんは　花が　好きです。	木村喜歡花。	\N	きむらさんは　はなが　すきです。	\N	vmod	\N	\N	\N	725	1
3674	きのう　木を　切りました。	我昨天把樹砍了。	\N	きのう　きを　きりました。	\N	vmod	\N	\N	\N	179	1
3675	田中さんの　家の　庭に　木や　花が　あります。　	田中家裡的院子有樹和花。	\N	たなかさんの　いえの　にわに　きや　はなが　あります。	\N	vmod	\N	\N	\N	179	1
3676	東の　空が　曇って　います。	東方的天空密布著烏雲。	\N	ひがしの　そらが　くもって　います。	\N	vmod	\N	\N	\N	355	1
3677	空は　広いです。	天空很廣。	\N	そらは　ひろいです。	\N	vmod	\N	\N	\N	355	1
3678	日本では　冬　雪が　降ります。	在日本冬天會下雪。	\N	にほんでは　ふゆ　ゆきが　ふります。	\N	vmod	\N	\N	\N	567	1
3679	冬は　寒いので、　ストーブを　つけます。	因為冬天很冷，我要開暖爐。	\N	ふゆは　さむいので、　すとーぶを　つけます。	\N	vmod	\N	\N	\N	567	1
3680	夏が　終わると、　秋が　来ます。	夏天結束後秋天就會來臨。	\N	なつが　おわると、　あきが　きます。	\N	vmod	\N	\N	\N	8	1
3681	わたしは　春より　秋の　ほうが　好きです。	跟春天比起來我比較喜歡秋天。	\N	わたしは　はるより　あきの　ほうが　すきです。	\N	vmod	\N	\N	\N	8	1
3682	夏は　毎日　帽子を　かぶって　出かけます。	夏天我每天都戴帽子出門。	\N	なつは　まいにち　ぼうしを　かぶって　でかけます。	\N	vmod	\N	\N	\N	473	1
3683	日本の　夏は　とても　暑いです。	日本的夏天很熱。	\N	にほんの　なつは　とても　あついです。	\N	vmod	\N	\N	\N	473	1
3684	春は　花が　たくさん　咲きます。	春天有很多花會開。	\N	はるは　はなが　たくさん　さきます。	\N	vmod	\N	\N	\N	724	1
3685	日本では　春　風が　強いです。	在日本春天的風很強。	\N	にほんでは　はる　かぜが　つよいです。	\N	vmod	\N	\N	\N	724	1
3686	今週、　テストが　四つも　ありました。	這個星期有四個考試。	\N	こんしゅう、　てすとが　よっつも　ありました。	\N	vmod	\N	\N	\N	258	1
3687	来年、　わたしの　妹は　大学に　入ります。	明年我妹妹要進大學了。	\N	らいねん、　わたしの　いもうとは　だいがくに　はいります。	\N	vmod	\N	\N	\N	509	1
3688	友達と　買い物を　して、　喫茶店に　入りました。	我跟朋友買了東西之後進了一家咖啡店。	\N	ともだちと　かいものを　して、　きっさてんに　はいりました。	\N	vmod	\N	\N	\N	509	1
3689	いつも　寝る　前に、　おふろに　入ります。	我總是在睡前洗澡。	\N	いつも　ねる　まえに、　おふろに　はいります。	\N	vmod	\N	\N	\N	509	1
3690	映画を　見て　いた　とき、　泣いて　しまいました。	看電影的時候哭了。	\N	えいがを　みて　いた　とき、　ないて　しまいました。	\N	vmod	\N	\N	\N	470	1
3691	部屋で　妹が　泣いて　います。	妹妹在房間哭。	\N	へやで　いもうとが　ないて　います。	\N	vmod	\N	\N	\N	470	1
3692	あしたは　一日　休みたいです。　しかし、　学校へ　行かなければ　なりません。	明天我想休息。可是不去學校又不行。	\N	あしたは　いちにち　やすみたいです。　しかし、　学校へ　行かなければ　なりません。	\N	vmod	\N	\N	\N	281	1
3693	毎日　忙しいです。　しかし、　大変　楽しいです。	每天都很忙碌。不過我感到非常快樂。	\N	まいにち　いそがしいです。　しかし、　たいへん　たのしいです。	\N	vmod	\N	\N	\N	281	1
3694	あの　レストランは　安いです。　でも、　あまり　おいしくないです。	那家餐廳很便宜。不過，不是很好吃。	\N	あの　れすとらんは　やすいです。　でも、　あまり　おいしくないです。	\N	vmod	\N	\N	\N	424	1
3695	きのうの　パーティーは　楽しかったです。　でも、　少し　疲れました。	昨天的派對很好玩。可是，有點累。	\N	きのうの　ぱーてぃーは　たのしかったです。　でも、　すこし　つかれました。	\N	vmod	\N	\N	\N	424	1
3696	食堂の　ごはんは　安いです。　そして、　おいしいです。	食堂的飯很便宜。而且，還很好吃。	\N	しょくどうの　ごはんは　やすいです。　そして、　おいしいです。	\N	vmod	\N	\N	\N	348	1
3697	八時に　うちを　出ます。　そして、　バスで　学校へ　行きます。	我要八點出門。然後，坐公車去學校。	\N	はちじに　うちを　でます。　そして、　ばすで　がっこうへ　いきます。	\N	vmod	\N	\N	\N	348	1
3698	この　コップを　買います。　それから、　この　お皿も　買います。	我要買這個杯子。然後，這個盤子我也要買。	\N	この　こっぷを　かいます。　それから、　この　おさらも　かいます。	\N	vmod	\N	\N	\N	357	1
3699	きのうは　テレビを　見ました。　それから、　日本語を　勉強しました。	昨天我看了電視。然後，我又唸了日文。	\N	きのうは　てれびを　みました。　それから、　にほんごを　べんきょうしました。	\N	vmod	\N	\N	\N	357	1
3700	この　辞書は　あまり　よくないです。	這本字典不是很好。	\N	この　じしょは　あまり　よくないです。	\N	vmod	\N	\N	\N	34	1
3701	あとで　いっしょに　昼ごはんを　食べましょう。	等一下一起吃午飯吧。	\N	あとで　いっしょに　ひるごはんを　たべましょう。	\N	vmod	\N	\N	\N	821	1
3702	田中さんは　いつも　忙しそうです。	田中總是很忙的樣子。	\N	たなかさんは　いつも　いそがしそうです。	\N	vmod	\N	\N	\N	60	1
3703	わたしは　いつも　この　スーパーで　買い物を　します。	我總是在這個超市買東西。	\N	わたしは　いつも　この　すーぱーで　かいものを　します。	\N	vmod	\N	\N	\N	60	1
3704	いろいろ　ありがとう　ございました。	非常謝謝您幫了我這麼多。	\N	いろいろ　ありがとう　ございました。	\N	vmod	\N	\N	\N	70	1
3705	テーブルに　いろいろな　料理が　並べて　あります。	桌子上擺著各種菜餚。	\N	てーぶるに　いろいろな　りょうりが　ならべて　あります。	\N	vmod	\N	\N	\N	70	1
3706	ありがとう。　これで　けっこうです。	謝謝。這樣就可以了。	\N	ありがとう。　これで　けっこうです。	\N	vmod	\N	\N	\N	223	1
3707	小林さんは　とても　頭が　いいです。　	小林的腦筋很好。	\N	こばやしさんは　とても　あたまが　いいです。	\N	vmod	\N	\N	\N	452	1
3708	少し　本を　読んで、　寝ます。　	看點書然後睡覺。	\N	すこし　ほんを　よんで、　ねます。	\N	vmod	\N	\N	\N	320	1
3709	きのう　少し　お酒を　飲みました。　	昨天喝了一點酒。	\N	きのう　すこし　おさけを　のみました。	\N	vmod	\N	\N	\N	320	1
3710	今　ちょうど　晩ごはんを　食べて　いる　ところです。	現在剛好在吃晚飯。	\N	いま　ちょうど　ばんごはんを　たべて　いる　ところです。	\N	vmod	\N	\N	\N	398	1
3711	今から　ちょうど　試合が　始まります。	現在比賽正要開始。	\N	いまから　ちょうど　しあいが　はじまります。	\N	vmod	\N	\N	\N	398	1
3712	大学を　出たら、　すぐ　働きます。	大學畢業後我要馬上工作。	\N	だいがくを　でたら、　すぐ　働きます。	\N	vmod	\N	\N	\N	318	1
3713	妻は　すぐに　帰って　来ます。	太太馬上就要回來了。	\N	つまは　すぐに　かえって　きます。	\N	vmod	\N	\N	\N	318	1
3714	きょうは　大変　楽しかったです。	昨天真的很開心。	\N	きょうは　たいへん　たのしかったです。	\N	vmod	\N	\N	\N	730	1
3715	この　映画は　大変　おもしろいです。	這部電影非常好看。	\N	この　えいがは　たいへん　おもしろいです。	\N	vmod	\N	\N	\N	730	1
3716	イさんは　だんだん　日本語が　上手に　なりました。	李先生(小姐)的日文越來越好了。	\N	いさんは　だんだん　にほんごが　じょうずに　なりました。	\N	vmod	\N	\N	\N	386	1
3717	七月から　だんだん　暑く　なります。	從七月開始漸漸變熱。	\N	しつがつから　だんだん　あつく　なります	\N	vmod	\N	\N	\N	386	1
3718	B ： すみません。　あしたは　ちょっと…。	B：不好意思，明天我有點事…。	\N	B ： すみません。　あしたは　ちょっと…。	\N	vmod	\N	\N	\N	399	1
3719	A ： あした　買い物に　行きませんか。　	A：明天要不要去買東西？	\N	A ： あした　かいものに　いきませんか。	\N	vmod	\N	\N	\N	399	1
3720	わたしは　時々　この　八百屋で　買い物を　します。	我有時候會來這家蔬果店買東西。	\N	わたしは　ときどき　この　やおやで　かいものを　します。	\N	vmod	\N	\N	\N	444	1
3721	木村さんは　時々　晩ごはんを　作ります。	木村有時候會做晚飯。	\N	きむらさんは　ときどき　ばんごはんを　つくります。	\N	vmod	\N	\N	\N	444	1
3722	あそこに　いる　人は　たぶん　山田さんです。	那邊那個人大概是山田。	\N	あそこに　いる　ひとは　たぶん　やまださんです。	\N	vmod	\N	\N	\N	731	1
3723	林さんは　たぶん　その　ニュースを　知って　います。　	林先生(小姐)應該知道那個新聞。	\N	はやしさんは　たぶん　その　にゅーすを　しって　います。	\N	vmod	\N	\N	\N	731	1
3724	生徒たちは　廊下に　まっすぐ　並びます。	學生們在走廊上排成一直線。	\N	せいとたちは　ろうかに　まっすぐ　ならびます。	\N	vmod	\N	\N	\N	611	1
3725	駅を　出て、　あの　道を　まっすぐ　行って　ください。	走出車站後，請沿著那條路一直走。	\N	えきを　でて、　あの　みちを　まっすぐ　いって　ください。	\N	vmod	\N	\N	\N	611	1
3726	きのう　初めて　ピアノを　習いました。	昨天第一次去學鋼琴。	\N	きのう　はじめて　ぴあのを　ならいました。	\N	vmod	\N	\N	\N	516	1
3727	わたしは　初めて　林さんに　会いました。	我第一次跟林先生(小姐)見面。	\N	わたしは　はじめて　はやしさんに　あいました。	\N	vmod	\N	\N	\N	516	1
3728	また　あとで　来ます。	我等一下再來。	\N	また　あとで　きます。	\N	vmod	\N	\N	\N	607	1
3729	わたしは　来週　また　小林さんと　遊びます。	我下星期還要跟小林去玩。	\N	わたしは　らいしゅう　また　こばやしさんと　あそびます。	\N	vmod	\N	\N	\N	607	1
3730	松井さんは　まだ　宿題を　して　いません。	松井還沒寫作業。	\N	まついさんは　まだ　しゅくだいを　して　いません。	\N	vmod	\N	\N	\N	608	1
3731	今　まだ　十時です。	現在才十點。	\N	いま　まだ　じゅうじです。	\N	vmod	\N	\N	\N	608	1
3732	わたしは　もう　食堂で　昼ごはんを　食べました。	我已經在食堂吃了中飯。	\N	わたしは　もう　しょくどうで　ひるごはんを　たべました。	\N	vmod	\N	\N	\N	640	1
3733	妹は　もう　寝ました。	妹妹已經睡了。	\N	いもうとは　もう　ねました。	\N	vmod	\N	\N	\N	640	1
3734	もう　少し　仕事を　して、　帰ります。	把工作再做一下我就回家。	\N	もう　すこし　しごとを　して、　かえります。	\N	vmod	\N	\N	\N	739	1
3735	もう　一杯　水を　飲みます。	再喝一杯水。	\N	もう　いっぱい　みずを　のみます。	\N	vmod	\N	\N	\N	739	1
3736	もっと　ゆっくり　話して　ください。	請你再講慢一點。	\N	もっと　ゆっくり　はなして　ください。	\N	vmod	\N	\N	\N	664	1
3737	足が　痛いので、　ゆっくり　歩きます。	因為腳痛，我要慢慢走。	\N	あしが　いたいので、　ゆっくり　あるきます。	\N	vmod	\N	\N	\N	664	1
3738	わたしは　もっと　英語が　上手に　なりたいです。	我想要讓自己的英文更進步。	\N	わたしは　もっと　えいごが　じょうずに　なりたいです。	\N	vmod	\N	\N	\N	644	1
3739	もっと　安い　服を　買います。	我要買更便宜的衣服。	\N	もっと　やすい　ふくを　かいます。	\N	vmod	\N	\N	\N	644	1
3740	この　作文は　とても　よく　書けました。	這篇作文寫得非常好。	\N	この　さくぶんは　とても　よく　かけました。	\N	vmod	\N	\N	\N	733	1
3741	きのうの　テストは　よく　できました。	昨天的考試考得很好。	\N	きのうの　てすとは　よく　できました。	\N	vmod	\N	\N	\N	733	1
3742	きょうは　よく　小林さんに　会います。	今天常常遇到小林。	\N	きょうは　よく　こばやしさんに　あいます。	\N	vmod	\N	\N	\N	732	1
3743	木村さんと　よく　あの　喫茶店へ　行きます。	我常和木村去那家咖啡店。	\N	きむらさんと　よく　あの　きっさてんへ　いきます。	\N	vmod	\N	\N	\N	732	1
3744	家へ　帰ったら、　初めに　宿題を　します。	回到家的話我要先寫作業。	\N	いえへ　かえったら、　はじめに　しゅくだいを　します。	\N	vmod	\N	\N	\N	515	1
3745	来月の　初め、　国へ　帰ります。	下個月初我要回國。	\N	らいげつの　はじめ、　くにへ　かえります。	\N	vmod	\N	\N	\N	515	1
3746	あした　だれと　会いますか。	明天要和誰見面？	\N	あした　だれと　あいますか。	\N	vmod	\N	\N	\N	383	1
3747	隣の　部屋に　だれか　いましたか。	隔壁房間有人在嗎？	\N	となりの　へやに　だれか　いましたか。	\N	vmod	\N	\N	\N	384	1
3748	だれか　わたしの　ボールペンを　持って　いませんか。	請問誰拿了我的原子筆？	\N	だれか　わたしの　ぼーるぺんを　もって　いませんか。	\N	vmod	\N	\N	\N	384	1
3749	いつも　どこで　昼ごはんを　食べますか。	你都在哪裡吃午餐呢？	\N	いつも　どこで　ひるごはんを　たべますか。	\N	vmod	\N	\N	\N	446	1
3750	なぜ　日本語を　勉強して　いるんですか。	你為什麼要學日語呢？	\N	なぜ　にほんごを　べんきょうして　いるんですか。	\N	vmod	\N	\N	\N	472	1
3751	何で　会社へ　行きますか。	你怎麼去上班？	\N	なんで　かいしゃへ　いきますか。	\N	vmod	\N	\N	\N	822	1
3752	どれが　いちばん　おいしいですか。	哪一個最好吃？	\N	どれが　いちばん　おいしいですか。	\N	vmod	\N	\N	\N	463	1
3753	林さんは　どれを　買いましたか。	林先生(小姐)你買了哪一個？	\N	はやしさんは　どれを　かいましたか。	\N	vmod	\N	\N	\N	463	1
3754	それは　どんな　食べ物ですか。	那是什麼樣的食物？	\N	それは　どんな　たべものですか。	\N	vmod	\N	\N	\N	464	1
3755	どんな　人と　結婚したいですか。	你想跟什麼樣的人結婚？	\N	どんな　ひとと　けっこんしたいですか。	\N	vmod	\N	\N	\N	464	1
3756	イさんは　どっちの　飲み物が　いいですか。	李先生(小姐)你要喝哪個飲料？	\N	いさんは　どっちの　のみものが　いいですか。	\N	vmod	\N	\N	\N	451	1
3757	木村さんは　どっちが　好きですか。	木村你喜歡哪一個？	\N	きむらさんは　どっちが　すきですか。	\N	vmod	\N	\N	\N	451	1
3758	コーヒーは　いかがですか。	來杯咖啡如何？	\N	こーひーは　いかがですか。	\N	vmod	\N	\N	\N	44	1
3759	お菓子を　一つ　いかがですか。	來個點心怎麼樣？	\N	おかしを　ひとつ　いかがですか。	\N	vmod	\N	\N	\N	44	1
3760	どの　先生の　授業が　いちばん　おもしろいですか。	哪個老師的課最有趣？	\N	どの　せんせいの　じゅぎょうが　いちばん　おもしろいですか。	\N	vmod	\N	\N	\N	455	1
3761	どの　人が　林さんですか。	哪一個是林先生(小姐)？	\N	どの　ひとが　はやしさんですか。	\N	vmod	\N	\N	\N	455	1
3762	小林さんは　どなたですか。　	小林是哪一位？	\N	こばやしさんは　どなたですか。	\N	vmod	\N	\N	\N	453	1
3763	どなたが　新しい　先生ですか。	哪一位是新來的老師？	\N	どなたが　あたらしい　せんせいですか。	\N	vmod	\N	\N	\N	453	1
3764	山田さんは　どちらを　食べたいですか。　	山田你想吃哪一個？	\N	やまださんは　どちらを　たべたいですか。	\N	vmod	\N	\N	\N	450	1
3765	国は　どちらですか。	你是哪一國人？	\N	くには　どちらですか。	\N	vmod	\N	\N	\N	450	1
3766	ああ、　田中さん、　こんばんは。	啊，田中，晚安。	\N	ああ、　たなかさん、　こんばんは。	\N	vmod	\N	\N	\N	1	1
3767	ああ、　よかったです。	啊，太好了。	\N	ああ、　よかったです。	\N	vmod	\N	\N	\N	1	1
3768	あの　写真は　先月　撮りました。	那張照片是上個月拍的。	\N	あの　しゃしんは　せんげつ　とりました。	\N	vmod	\N	\N	\N	29	1
3769	あの　人は　小林さんです。	那個人是小林。	\N	あの　ひとは　こばやしさんです。	\N	vmod	\N	\N	\N	29	1
3770	さあ、　よく　分かりません。	我也不是很清楚。	\N	さあ、　よく　わかりません。	\N	vmod	\N	\N	\N	261	1
3771	さあ、　授業を　始めましょう。	開始上課吧。	\N	さあ、　じゅぎょうを　はじめましょう。	\N	vmod	\N	\N	\N	261	1
3772	もしもし、　木村ですが。	喂，我是木村。	\N	もしもし、　きむらですが。	\N	vmod	\N	\N	\N	642	1
3773	はい、　もしもし、　松井です。	喂，我是松井。	\N	はい、　もしもし、　まついです。	\N	vmod	\N	\N	\N	642	1
3774	どうも　すみません。	對不起。	\N	どうも　すみません。	\N	vmod	\N	\N	\N	439	1
3775	どうも　ありがとう　ございました。	謝謝。	\N	どうも　ありがとう　ございました。	\N	vmod	\N	\N	\N	439	1
3776	どうも。	謝謝。	\N	どうも。	\N	vmod	\N	\N	\N	439	1
3777	はい、　そうです。	是的，沒錯。	\N	はい、　そうです。	\N	vmod	\N	\N	\N	741	1
3778	はい、　何ですか。	是的，請問有什麼事？	\N	はい、　なんですか。	\N	vmod	\N	\N	\N	741	1
3779	では、　よろしく　お願いします。	那麼就麻煩您了。	\N	では、　よろしく　おねがいします。	\N	vmod	\N	\N	\N	422	1
3780	では、　授業を　始めます。	那麼我們開始上課吧。	\N	では、　じゅぎょうを　はじめます。	\N	vmod	\N	\N	\N	422	1
3781	じゃあ、　バスで　病院へ　行きます。	那麼我要搭公車去醫院了。	\N	じゃあ、　ばすで　びょういんへ　いきます。	\N	vmod	\N	\N	\N	296	1
3782	そうですね。	就是說啊。	\N	そうですね。	\N	vmod	\N	\N	\N	345	1
3783	はい、　そうです。	是，沒錯。	\N	はい、　そうです。	\N	vmod	\N	\N	\N	345	1
3784	いいえ、　違います。	不對，不是這樣。	\N	いいえ、　ちがいます。	\N	vmod	\N	\N	\N	41	1
3785	わたしが　いちばん　好きな　飲み物は　紅茶です。　	我最喜歡的飲料是紅茶。	\N	わたしが　いちばん　すきな　のみものは　こうちゃです。	\N	vmod	\N	\N	\N	55	1
3786	この　肉が　いちばん　安いです。	這個肉是最便宜的。	\N	この　にくが　いちばん　やすいです。	\N	vmod	\N	\N	\N	55	1
3787	わたしは　この　料理を　頼みます。	我要點這道菜。	\N	わたしは　この　りょうりを　たのみます。	\N	vmod	\N	\N	\N	250	1
3788	この　建物は　古くて、　有名です。	這棟建築物既古老又有名。	\N	この　たてものは　ふるくて、　ゆうめいです。	\N	vmod	\N	\N	\N	250	1
3789	その　部屋に　入っては　いけません。	不可以進去那個房間。	\N	その　へやに　はいっては　いけません。	\N	vmod	\N	\N	\N	353	1
3790	こんな　黒い　財布を　探して　います。	我正在找一個像這麼黑的皮包。	\N	こんな　くろい　さいふを　さがして　います。	\N	vmod	\N	\N	\N	259	1
3791	わたしは　こんな　帽子が　欲しいです。	我想要一頂像這樣的帽子。	\N	わたしは　こんな　ぼうしが　ほしいです。	\N	vmod	\N	\N	\N	259	1
3792	どうぞ　よろしく　お願いします。	麻煩您了。/ 請多多關照。	\N	どうぞ　よろしく　おねがいします。	\N	vmod	\N	\N	\N	437	1
3793	教室の　電気を　つけて　ください。	請把教室的燈打開。	\N	きょうしつの　でんきを　つけて　ください。	\N	vmod	\N	\N	\N	802	1
3794	辞書を　貸して　ください。	請借我字典。	\N	じしょを　かして　ください。	\N	vmod	\N	\N	\N	802	1
3795	みんなで　いっしょに　帰りました。	大家一起回去了。	\N	みんなで　いっしょに　かえりました。	\N	vmod	\N	\N	\N	58	1
3796	図書館で　山田さんと　いっしょに　勉強します。	我要在圖書館和山田一起唸書。	\N	としょかんで　やまださんと　いっしょに　べんきょうします。	\N	vmod	\N	\N	\N	58	1
3797	いっしょに　旅行に　行きませんか。	要不要一起去旅行？	\N	いっしょに　りょこうに　いきませんか。	\N	vmod	\N	\N	\N	58	1
3798	大きな　かばんは　便利です。	大的包包很方便。	\N	おおきな　かばんが　べんりです。	\N	vmod	\N	\N	\N	95	1
3799	田中さんは　大きな　家に　住んで　います。	田中住在一個很大的房子。	\N	たなかさんは　おおきな　いえに　すんで　います。	\N	vmod	\N	\N	\N	95	1
3800	わたしの　部屋に　小さな　いすが　あります。　	我的房間裡有一張小椅子。	\N	わたしの　へやに　ちいさな　いすが　あります。	\N	vmod	\N	\N	\N	388	1
3801	わたしは　小さな　町で　生まれました。	我在這個小鎮上出生的。	\N	わたしは　ちいさな　まちで　うまれました。	\N	vmod	\N	\N	\N	388	1
3802	果物を　半分に　切りました。	把水果切成一半。	\N	くだものを　はんぶんに　きりました。	\N	vmod	\N	\N	\N	538	1
3803	パンを　半分　食べました。	我把麵包吃掉了一半。	\N	ぱんを　はんぶん　たべました。	\N	vmod	\N	\N	\N	538	1
3804	向こうの　窓を　開けて　ください。	請把對面的窗戶打開。	\N	むこうの　まどを　あけて　ください。	\N	vmod	\N	\N	\N	633	1
3805	病院は　駅の　向こうです。	醫院在車站對面。	\N	びょういんは　えきの　むこうです。	\N	vmod	\N	\N	\N	633	1
3806	全部で　千六百円です。	總共是一千六百圓。	\N	ぜんぶで　せんろっぴゃくえんです。	\N	vmod	\N	\N	\N	344	1
3807	宿題が　全部　終わりました。	作業全部都寫完了。	\N	しゅくだいが　ぜんぶ　おわりました。	\N	vmod	\N	\N	\N	344	1
3808	海で　大勢の　人が　泳いで　います。	海邊有很多人在游泳。	\N	うみで　おおぜいの　ひとが　およいで　います。	\N	vmod	\N	\N	\N	96	1
3809	パーティーに　人が　大勢　来ました。	派對上來了很多人。	\N	ぱーてぃーに　ひとが　おおぜい　きました。	\N	vmod	\N	\N	\N	96	1
3810	わたしの　靴と　小林さんの　靴は　同じです。	我的鞋跟小林的鞋一樣。	\N	わたしの　くつと　こばやしさんの　くつは　おなじです。	\N	vmod	\N	\N	\N	118	1
3811	松井さんと　イさんは　同じ　クラスです。	松井跟小李同班。	\N	わたしと　いさんは　おなじ　くらすです。	\N	vmod	\N	\N	\N	118	1
3812	わたしは　コーヒーに　たくさん　ミルクを　入れます。	我習慣在咖啡裡面加很多牛奶。	\N	わたしは　こーひーに　たくさん　みるくを　いれます。	\N	vmod	\N	\N	\N	368	1
3813	きょうは　たくさん　歩きました。	今天我走了很多路。	\N	きょうは　たくさん　あるきました。	\N	vmod	\N	\N	\N	368	1
3814	田中さんは　ギターを　弾きながら、　歌を　歌えます。	田中一邊彈吉他一邊唱歌。	\N	田中さんは　ぎたーを　ひきながら、　うたを　うたえます。	\N	vmod	\N	\N	\N	469	1
3815	テレビを　見ながら、　ごはんを　食べます。	一邊看電視一邊吃飯。	\N	てれびを　みながら、　ごはんを　たべます。	\N	vmod	\N	\N	\N	469	1
3816	きのう　デパートで　セーターや　スカートなどを　買いました。	昨天我在百貨公司買了毛衣跟裙子等等。	\N	きのう　でぱーとで　せーたーや　すかーとなどを　かいました。	\N	vmod	\N	\N	\N	475	1
3817	冷蔵庫に　卵や　野菜や　果物などが　あります。　	冰箱裡面有蛋跟蔬菜跟水果等等。	\N	れいぞうこに　たまごや　やさいや　くだものなどが　あります。	\N	vmod	\N	\N	\N	475	1
3818	勉強すれば、　少しずつ　日本語が　上手に　なるでしょう。	用功的話日文就會一點一點地進步吧。	\N	べんきょうすれば、　すこしずつ　にほんごが　じょうずに　なるでしょう。	\N	vmod	\N	\N	\N	322	1
3819	紙を　一枚ずつ　取って　ください。	紙請一張一張地拿。	\N	かみを　いちまいずつ　とって　ください。	\N	vmod	\N	\N	\N	322	1
3820	公園で　子供たちが　遊んで　います。	小孩子們正在公園玩耍。	\N	こうえんで　こどもたちが　あそんで　います。	\N	vmod	\N	\N	\N	372	1
3821	あの　人たちは　友達です。	那些人是朋友。	\N	あの　ひとたちは　ともだちです。	\N	vmod	\N	\N	\N	372	1
3822	寝る　前、　シャワーを　浴びます。	我睡前會沖個澡。	\N	ねる　まえ、　しゃわーを　あびます。	\N	vmod	\N	\N	\N	745	1
3823	皆さんの　教室は　三階です。	各位的教室在三樓。	\N	みなさんの　きょうしつは　さんがいです。	\N	vmod	\N	\N	\N	627	1
3824	皆さんが　行くなら、　わたしも　行きます。	大家都要去的話我也要去。	\N	みなさんが　いくなら、　わたしも　いきます。	\N	vmod	\N	\N	\N	627	1
3825	皆さん、　来週　漢字の　テストを　します。	各位，下星期要考漢字。	\N	みなさん、　らいしゅう　かんじの　てすとを　します。	\N	vmod	\N	\N	\N	627	1
3826	みんなで　いっしょに　歌を　歌います。	大家一起唱歌。	\N	みんなで　いっしょに　うたを　うたいます。	\N	vmod	\N	\N	\N	631	1
3827	みんなが　教室で　先生を　待って　います。	大家都在教室裡等老師。	\N	みんなが　きょうしつで　せんせいを　まって　います。	\N	vmod	\N	\N	\N	631	1
3828	みんな、　この　大学の　学生です。	每個人都是這所大學的學生。	\N	みんな、　この　だいがくの　がくせいです。	\N	vmod	\N	\N	\N	631	1
3829	林さんは　一年半　海外で　働きました。	林先生(小姐)在國外工作了一年半。	\N	はやしさんは　いちねんはん　かいがいで　はたらきました。	\N	vmod	\N	\N	\N	532	1
3830	もう　七時半なので、　家を　出なければ　なりません。　	已經七點半了，我不出門不行了。	\N	もう　しちじはんなので、　いえを　でなければ　なりません。	\N	vmod	\N	\N	\N	532	1
3831	イさんは　テニスを　やりたがって　います。	李先生(小姐)想要打網球。	\N	いさんは　てにすを　やりたがって　います。	\N	vmod	\N	\N	\N	171	1
3832	子供が　お菓子を　欲しがって　います。	小朋友想要點心。	\N	こどもが　おかしを　ほしがって　います。	\N	vmod	\N	\N	\N	171	1
3833	宿題が　半分くらい　終わりました。	作業差不多寫好一半了。	\N	しゅくだいが　はんぶんくらい　おわりました。	\N	vmod	\N	\N	\N	213	1
3834	卵は　一個　五十グラムぐらいです。	一顆蛋差不多重50公克。	\N	たまごは　いっこ　ごじゅうぐらむぐらいです。	\N	vmod	\N	\N	\N	213	1
3835	田中さんは　十時ごろ　駅に　着きます。	田中會在十點左右抵達車站。	\N	たなかさんは　じゅうじごろ　えきに　つきます。	\N	vmod	\N	\N	\N	256	1
3836	わたしは　子どもの　ころ、　よく　あの　公園で　遊びました。	我還小的時候常常在那個公園玩。	\N	わたしは　こどもの　ころ、　よく　あの　こうえんで　あそびました。	\N	vmod	\N	\N	\N	256	1
3837	いつも　九時すぎに　授業が　始まります。	課總是過了九點才開始。	\N	いつも　くじすぎに　じゅぎょうが　はじまります。	\N	vmod	\N	\N	\N	317	1
3838	今　十二時すぎです。	現在過十二點了。	\N	いま　じゅうにじすぎです。	\N	vmod	\N	\N	\N	317	1
3839	この　辺で　少し　休みましょう。	在這裡稍微休息一下吧。	\N	この　へんで　すこし　やすみましょう。	\N	vmod	\N	\N	\N	578	1
3840	あの　辺に　林さんの　家が　あります。	林先生(小姐)的家在這一帶。	\N	あの　へんに　はやしさんの　いえが　あります。	\N	vmod	\N	\N	\N	578	1
3841	わたしの　部屋より　弟の　部屋の　ほうが　狭いです。	跟我的房間比起來，弟弟的房間比較小。	\N	わたしの　へやより　おとうとの　へやの　ほうが　せまいです。	\N	vmod	\N	\N	\N	584	1
3842	サッカーより　野球の　ほうが　好きです。	跟足球比起來，我比較喜歡棒球。	\N	さっかーより　やきゅうの　ほうが　すきです。	\N	vmod	\N	\N	\N	584	1
3843	三日前、　髪を　切りました。	三天前我去剪頭髮了。	\N	みっかまえ、　かみを　きりました。	\N	vmod	\N	\N	\N	745	1
3844	わたしは　時々　あそこの　本屋へ　行きます。	我有時候會去那一家書店。	\N	わたしは　ときどき　あそこの　ほんやへ　いきます。	\N	vmod	\N	\N	\N	648	1
3845	わたしの　おばさんは　花屋で　働いて　います。	我阿姨在花店上班。	\N	わたしの　おばさんは　はなやで　はたらいて　います。	\N	vmod	\N	\N	\N	648	1
3846	うちの　犬は　本当に　かわいいです。　	我家的狗真的很可愛。	\N	うちの　いぬは　ほんとうに　かわいいです。	\N	vmod	\N	\N	\N	596	1
3847	この　話は　本当です。	這些話是真的。	\N	この　はなしは　ほんとうです。	\N	vmod	\N	\N	\N	596	1
3848	ほかの　人に　話しては　いけません。	不可以和其他人說。	\N	ほかの　ひとに　はなしては　いけません。	\N	vmod	\N	\N	\N	726	1
3849	ほかに　欲しい　物は　ありますか。	有沒有其他想要的東西？	\N	ほかに　ほしい　ものは　ありますか。　	\N	vmod	\N	\N	\N	726	1
3850	わたしは　日本中　旅行したいです。	我想要把全日本都旅行個遍。	\N	わたしは　にほんじゅう　りょこうしたいです。	\N	vmod	\N	\N	\N	749	1
3851	きのうは　一日中　うちに　いませんでした。	今天一整天都不在家。	\N	きのうは　いちにちじゅう　うちに　いませんでした。	\N	vmod	\N	\N	\N	749	1
3852	図書館で　本を　借りて、　読みました。	我到圖書館借了書，而且看完了。	\N	としょかんで　ほんを　かりて、　よみました。	\N	vmod	\N	\N	\N	170	1
3853	駅の　近くに　新しい　レストランが　できました。	車站附近開了一家新的餐廳。	\N	えきの　ちかくに　あたらしい　れすとらんが　できました。	\N	vmod	\N	\N	\N	689	1
3854	この　教室の　壁は　厚いです。	這間教室的牆壁很厚。	\N	この　きょうしつの　かべは　あついです。	\N	vmod	\N	\N	\N	830	1
3855	母は　ケーキが　大好きです。	媽媽很喜歡蛋糕。	\N	ははは　けーきが　だいすきです。	\N	vmod	\N	\N	\N	829	1
3856	毎年　誕生日に　ケーキを　食べます。	我每年生日都吃蛋糕。	\N	まいとし　たんじょうびに　けーきを　たべます。	\N	vmod	\N	\N	\N	829	1
3857	きのう　友達と　コンサートに　行きました。	昨天和朋友去看演唱會了。	\N	きのう　ともだちと　こんさーとに　いきました。	\N	vmod	\N	\N	\N	832	1
3858	病気じゃ　ありませんから、　心配しないで　ください。	不是生病，不用擔心。	\N	びょうきじゃ　ありませんから、　しんぱいしないで　ください。	\N	vmod	\N	\N	\N	826	1
3894	隣の　教室は　百人　入れます。	隔壁教室可以容納一百人。	\N	となりの　きょうしつは　ひゃくにん　はいれます。	\N	vmod	\N	\N	\N	550	1
3859	妹が　　まだ　帰らないので、　母は　心配して　います。	妹妹還沒有回家，媽媽很擔心。	\N	いもうとが　まだ　かえらないので、　ははは　しんぱいして　います。	\N	vmod	\N	\N	\N	826	1
3860	コンピューターを　使って、　仕事を　します。	我用電腦工作。	\N	こんぴゅーたーを　つかって、　しごとを　します。	\N	vmod	\N	\N	\N	823	1
3861	テレビの　スイッチを　入れます。	把電視開關打開。	\N	てれびの　すいっちを　いれます。	\N	vmod	\N	\N	\N	834	1
3862	きのう　カラオケに　行きましたが、　あまり　歌いませんでした。	昨天雖然去了卡拉OK，可是我沒什麼唱。	\N	きのう　からおけに　いきましたが、　あまり　うたいませんでした。	\N	vmod	\N	\N	\N	831	1
3863	わたしは　一週間に　一回　カラオケに　行きます。	我一個星期去一次卡拉OK。	\N	わたしは　いっしゅうかんに　いっかい　からおけに　いきます。	\N	vmod	\N	\N	\N	831	1
3864	友達に　携帯電話の　番号を　教えました。	我把電話號碼告訴朋友了。	\N	ともだちに　けいたいでんわの　ばんごうを　おしえました。	\N	vmod	\N	\N	\N	827	1
3865	携帯電話は　小さくて、　とても　便利です。	行動電話小小的，很方便。	\N	けいたいでんわは　ちいさくて、　とても　べんりです。	\N	vmod	\N	\N	\N	827	1
3866	暗い　所で　本を　読むのは　やめた　ほうが　いいです。	最好不要在暗暗的地方看書。	\N	くらい　ところで　ほんを　よむのは　やめた　ほうが　いいです。	\N	vmod	\N	\N	\N	824	1
3867	先月　わたしは　会社を　やめました。	上個月我把工作辭了。	\N	せんげつ　わたしは　かいしゃを　やめました。	\N	vmod	\N	\N	\N	824	1
3868	田中さんに　もらった　お菓子を　食べました。	從田中那邊拿到的點心我吃掉了。	\N	たなかさんに　もらった　おかしを　たべました。	\N	vmod	\N	\N	\N	825	1
3869	きのう　山田さんに　旅行の　お土産を　もらいました。	昨天我從山田那邊拿到了旅行的禮物。	\N	きのう　やまださんに　りょこうの　おみやげを　もらいました。	\N	vmod	\N	\N	\N	825	1
3870	小林さんは　木村さんに　パンを　半分　あげました。	小林把麵包分給木村一半了。	\N	こばやしさんは　きむらさんに　ぱんを　はんぶん　あげました。	\N	vmod	\N	\N	\N	833	1
3871	松井さんは　田中さんの　誕生日に　ネクタイを　あげます。	松井要在木村生日那天送一條領帶。	\N	まついさんは　たなかさんの　たんじょうびに　ねくたいを　あげます。	\N	vmod	\N	\N	\N	833	1
3872	きょうの　授業は　ここまでです。　それでは、　また来週、　会いましょう。	今天課就上到這裡。我們下星期再見。	\N	きょうの　じゅぎょうは　ここまでです。　それでは、　またらいしゅう、　あいましょう。	\N	vmod	\N	\N	\N	358	1
3873	テストは　できましたか。　それでは、　出して　ください。	考試都寫完了嗎？那麼，交出來吧。	\N	てすとは　できましたか。　それでは、　だして　ください。	\N	vmod	\N	\N	\N	358	1
3874	あの、　すみません。　図書館は　どこですか。	不好意思，請問圖書館在哪裡？	\N	あの、　すみません。　としょかんは　どこですか。	\N	vmod	\N	\N	\N	740	1
3875	あの　先生は　大変　りっぱな　方です。	那位老師是個很出色的人。	\N	あの　せんせいは　たいへん　りっぱな　かたです。	\N	vmod	\N	\N	\N	680	1
3876	りっぱな　大人に　なりたいです。	我想當個傑出的人。	\N	りっぱな　おとなに　なりたいです。	\N	vmod	\N	\N	\N	680	1
3877	全部で　十　あります。	總共有十個。	\N	ぜんぶで　とお　あります。	\N	vmod	\N	\N	\N	440	1
3878	授業中、　帽子を　かぶっては　いけません。	上課中不可以戴帽子。	\N	じゅぎょうちゅう、　ぼうしを　かぶっては　いけません。	\N	vmod	\N	\N	\N	164	1
3879	来週から　二週間、　海外へ　旅行に　行きます。	從下週開始兩個星期，我要去國外旅行。	\N	らいしゅうから　にしゅうかん、　かいがいへ　りょこうに　いきます。	\N	vmod	\N	\N	\N	301	1
3880	木村さんに　旅行の　写真を　見せました。	我把旅行的照片給木村看了。	\N	きむらさんに　りょこうの　しゃしんを　みせました。	\N	vmod	\N	\N	\N	297	1
3881	わたしは　色で　いちばん　白が　好きです。	我最喜歡的顏色是白色。	\N	わたしは　いろで　いちばん　しろが　すきです。	\N	vmod	\N	\N	\N	309	1
3882	ここは　零度なので、　とても　寒いです。	這裡只有零度，所以很冷。	\N	ここは　れいどなので、　とても　さむいです。	\N	vmod	\N	\N	\N	686	1
3883	ゼロは　零と　同じです。	Zero跟零是一樣的。	\N	ぜろは　れいと　おなじです。	\N	vmod	\N	\N	\N	337	1
3884	郵便局で　はがきを　一枚　買います。	我要去郵局買一張明信片。	\N	ゆうびんきょくで　はがきを　いちまい　かいます。	\N	vmod	\N	\N	\N	53	1
3885	田中さんの　家には　車が　二台　あります。	田中家裡有兩台車。	\N	たなかさんの　いえには　くるまが　にだい　あります。	\N	vmod	\N	\N	\N	484	1
3886	うちには　テレビが　三台　あります。	我家有三台電視。	\N	うちには　てれびが　さんだい　あります。	\N	vmod	\N	\N	\N	734	1
3887	「四」は　「よん」と　読みます。	「四」唸做「よん」。	\N	「四」は　「よん」と　よみます。	\N	vmod	\N	\N	\N	735	1
3888	わたしの　家族は　五人です。	我們全家有五個人。	\N	わたしの　かぞくは　ごにんです。	\N	vmod	\N	\N	\N	736	1
3889	テーブルの　上に　お皿を　六枚　並べます。	在桌子上面排六個盤子。	\N	てーぶるの　うえに　おさらを　ろくまい　ならべます。	\N	vmod	\N	\N	\N	693	1
3890	七月に　なると、　だんだん　暑く　なります。	到了七月之後就會漸漸熱起來。	\N	しちがつに　なると、　だんだん　あつく　なります。	\N	vmod	\N	\N	\N	287	1
3891	ここに　切手が　八枚　あります。	這裡有八張郵票。	\N	ここに　きってが　はちまい　あります。	\N	vmod	\N	\N	\N	522	1
3892	わたしの　弟は　九歳です。	我弟弟九歲。	\N	わたしの　おとうとは　きゅうさいです。	\N	vmod	\N	\N	\N	204	1
3893	十月　十日は　兄の　誕生日です。	十月十號是哥哥生日。	\N	じゅうがつ　とおかは　あにの　たんじょうびです。	\N	vmod	\N	\N	\N	300	1
3895	きのう　わたしは　山田さんに　千円　借りました。	我昨天跟山田借了一千圓。	\N	きのう　わたしは　やまださんに　せんえん　かりました。	\N	vmod	\N	\N	\N	338	1
3896	この　コートは　一万円です。	這件外套一萬圓。	\N	この　こーとは　いちまんえんです。	\N	vmod	\N	\N	\N	615	1
3897	わたしの　家族は　五人です。	我們全家有五個人。	\N	わたしの　かぞくは　ごにんです。	\N	vmod	\N	\N	\N	154	1
3898	木村さんの　お父さんは　五十二歳です。	木村的父親五十二歲。	\N	きむらさんの　おとうさんは　ごじゅうにさいです。	\N	vmod	\N	\N	\N	110	1
3899	妹は　きょうも　高い　熱が　続いて　いるので、　心配です。	因為妹妹今天也持續發高燒，我很擔心。	\N	いもうとは　きょうも　たかい　ねつが　つづいて　いるので、　しんぱいです。	\N	vmod	\N	\N	\N	837	1
3900	先週は　雨の　日が　続きました。	上個星期都在下雨。	\N	せんしゅうは　あめの　ひが　つづきました。	\N	vmod	\N	\N	\N	837	1
3901	うちを　出る　前に、　荷物を　確認します。	出門之前先確認一下行李。	\N	うちを　でる　まえに、　にもつを　かくにんします。	\N	vmod	\N	\N	\N	838	1
3902	テストの　答えを　確認します。	我要確認一下考試的答案。	\N	てすとの　こたえを　かくにんします。	\N	vmod	\N	\N	\N	838	1
3903	きょうは　妻の　誕生日なので、　早く　うちへ　帰ろうと　思います。	今天是老婆生日，所以我想早點回家。	\N	きょうは　つまの　たんじょうびなので、　はやく　うちへ　かえろうと　おもいます。	\N	vmod	\N	\N	\N	839	1
3904	この　本は　とても　おもしろいと　思います。	我覺得這本書很有趣。	\N	この　ほんは　とても　おもしろいと　おもいます。	\N	vmod	\N	\N	\N	839	1
3905	空港へ　行く　バスは　反対の　道へ　来ます。	到機場的巴士會從反方向的路過來。	\N	くうこうへ　いく　ばすは　はんたいの　みちへ　きます。	\N	vmod	\N	\N	\N	840	1
3906	「重い」の　反対は　「軽い」です。	「重い」的相反是「軽い」。	\N	「おもい」の　はんたいは　「かるい」です。	\N	vmod	\N	\N	\N	840	1
3907	この　部屋に　入っては　だめです。	不可以進去這個房間。	\N	この　へやに　はいっては　だめです。	\N	vmod	\N	\N	\N	841	1
3908	ここを　押すと、　音が　大きく　なります。	按這裡的話聲音就會變大。	\N	ここを　おすと、　おとが　おおきく　なります。	\N	vmod	\N	\N	\N	842	1
3909	わたしと　イさんは　同じ　グループです。	我跟小李是同一組的。	\N	わたしと　いさんは　おなじ　ぐるーぷです。	\N	vmod	\N	\N	\N	843	1
3910	ドアが　開きます。	どあが　あきます。	\N	どあが　あきます。	\N	vmod	\N	\N	\N	433	1
3911	いつも　寝る　前に　三十分だけ　本を　読みます。	我總是在睡前看30分鐘的書。	\N	いつも　ねる　まえに　さんじゅっぷんだけ　ほんを　よみます。	\N	vmod	\N	\N	\N	370	1
3912	お菓子を　一つだけ　食べました。	我只吃了一個點心。	\N	おかしを　ひとつだけ　たべました。	\N	vmod	\N	\N	\N	370	1
3913	B ： 一、　二、　三、　四…。	B：一、二、三、四…。	\N	B ： いち、　に、　さん、　し…。	\N	vmod	\N	\N	\N	278	1
3914	A ： いくつ　ありますか。	A：有幾個？	\N	A ： いくつ　ありますか。	\N	vmod	\N	\N	\N	278	1
3915	冷蔵庫の　中に　卵が　七個　あります。	冰箱裡面有七顆蛋。	\N	れいぞうこの　なかに　たまごが　ななこ　あります。	\N	vmod	\N	\N	\N	737	1
3916	毎朝　九時に　会社へ　行きます。	我每天早上九點去公司。	\N	まいあさ　くじに　かいしゃへ　いきます。	\N	vmod	\N	\N	\N	0	1
1542	この　靴下は、　じょうぶで　安いです。	這雙襪子既耐用又便宜。	null	この　くつしたは、　じょうぶで　やすいです。	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: ja_zt
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	24	是的\n對的\n\n【よみ】\n ああ\n\n【意味】\n right\nnow\n	0	1
2	903	見\n見面\n\n【よみ】\n あいます\n\n【意味】\n meet	1	1
3	1065	藍\n藍色\n\n【よみ】\n あお\n\n【意味】\n blue	0	1
4	939	藍的\n藍色的\n\n【よみ】\n あおい\n\n【意味】\n blue	0	1
5	1026	紅\n紅色\n\n【よみ】\n あか\n\n【意味】\n red	0	1
6	802	紅的\n紅色的\n\n【よみ】\n あかい\n\n【意味】\n red	0	1
7	1533	亮\n亮的\n\n【よみ】\n あかるい\n\n【意味】\n bright\n light	0	1
8	696	秋天\n\n【よみ】\n あき\n\n【意味】\n autumn	0	1
9	841	開著\n\n【よみ】\n あきます\n\n【意味】\n open	1	1
10	863	開\n打開\n\n【よみ】\n あけます\n\n【意味】\n open	1	1
11	1534	抬起來\n\n【よみ】\n あげます\n\n【意味】\n raise\n lift up	1	1
12	6	早上\n\n【よみ】\n あさ\n\n【意味】\n morning	0	1
13	1535	早餐\n早飯\n\n【よみ】\n あさごはん\n\n【意味】\n breakfast	1	1
14	1536	後天\n\n【よみ】\n あさって\n\n【意味】\n the day after tomorrow\n	0	1
15	375	腳\n\n【よみ】\n あし\n\n【意味】\n leg\n foot	0	1
16	61	明天\n\n【よみ】\n あした\n\n【意味】\n tomorrow\n	1	1
17	293	那裡\n\n【よみ】\n あそこ\n\n【意味】\n there\nthat place over there	0	1
18	1537	玩\n\n【よみ】\n あそびます\n\n【意味】\n enjoy oneself\n play	1	1
19	1538	暖和\n溫暖\n\n【よみ】\n あたたかい\n\n【意味】\n warm	1	1
20	1539	頭\n\n【よみ】\n あたま\n\n【意味】\n head	0	1
21	701	新\n新的\n\n【よみ】\n あたらしい\n\n【意味】\n new\n fresh	0	1
22	1297	那邊(較有禮貌的說法)\n\n【よみ】\n あちら\n\n【意味 】\n that way\n that place over there\n ※ the more polite equivalent of "あそこ"\n\n that\n thing over there\n ※ the more polite equivalent of "あれ"	0	1
23	1540	厚\n厚的\n\n【よみ】\n あつい\n\n【意味】\n thick\n heavy	0	1
24	1541	那邊(比較口語的說法)\n\n【よみ】\n あっち\n\n【意味】\n that way\n that place over there\n ※ the informal equivalent of "あちら"	0	1
25	444	再～\n\n【よみ】\n あと\n\n【意味】\n more ～	1	1
26	734	你\n\n【よみ】\nあなた\n\n【意味】\n you\n ※ not used as plural	0	1
27	1287	哥哥\n\n【よみ】\n あに\n\n【意味】\n (my) older brother	0	1
28	1542	姊姊\n\n【よみ】\n あね\n\n【意味】\n (my) older sister	0	1
29	1543	那～(那個、那時候等等)\n\n【よみ】\n あの\n\n【意味】\n that ～\n that ～ over there	1	1
30	879	公寓\n\n【よみ】\n あぱーと\n\n【意味】\n apartment	0	1
31	1544	淋浴\n\n【よみ】\n あびます\n\n【意味】\n take (a shower)	1	1
32	1545	危險\n\n【よみ】\n あぶない\n\n【意味】\n dangerous　	0	1
33	1154	甜\n甜的\n\n【よみ】\n あまい\n\n【意味】\n sweet	0	1
34	806	不是很～\n\n【よみ】\n あまり\n\n【意味】\n not so	0	1
35	1546	よみ ： あめ	1	1
36	932	洗\n\n【よみ】\n あらいます\n\n【意味】\n wash	1	1
37	1548	有\n\n【よみ】\n あります\n\n【意味】\n have	1	1
38	917	走\n走路\n\n【よみ】\n あるきます\n\n【意味】\n walk	1	1
39	299	那個\n\n【よみ】\n あれ\n\n【意味】\n that\n thing over there	0	1
40	186	好\n\n【よみ】\n いい\n\n【意味】\n good	0	1
41	8	不是\n不對\n\n【よみ】\n いいえ\n\n【意味】\n no	0	1
42	300	說話\n\n【よみ】\n いいます\n\n【意味】\n say	1	1
43	663	家\n\n【よみ】\n いえ\n\n【意味】\n house\n home	0	1
44	86	如何\n\n【よみ】\n いかが\n\n【意味】\n Would you like ～ ?	0	1
45	334	去\n\n【よみ】\n いきます\n\n【意味】\n go	1	1
46	745	幾個\n\n【よみ】\n いくつ\n\n【意味】\n how many	0	1
47	151	多少\n\n【よみ】\n いくら\n\n【意味】\n how much	0	1
48	1549	池子\n池塘\n\n【よみ】\n いけ\n\n【意味】\n pond	0	1
49	832	醫生\n\n【よみ】\n いしゃ\n\n【意味】\n doctor	0	1
50	1550	椅子\n\n【よみ】\n いす\n\n【意味】\n chair	1	1
51	1551	忙\n忙碌\n\n【よみ】\n いそがしい\n\n【意味】\n busy	0	1
52	818	痛\n\n【よみ】\n いたい\n\n【意味】\n painful\n have a pain	0	1
53	1552	一\n\n【よみ】\n いち\n\n【意味】\n one	1	1
55	325	最好的\n第一\n\n【よみ】\n いちばん\n\n【意味】\n the most\n the best	1	1
56	459	何時\n什麼時候\n\n【よみ】\n いつ\n\n【意味】\n when	0	1
57	1554	五日\n\n【よみ】\n いつか\n\n【意味】\n fifth\n five days	0	1
58	1483	一起\n\n【よみ】\n いっしょ\n\n【意味】\n together\n with (someone)\n\n same	1	1
59	1555	五個\n\n【よみ】\n いつつ\n\n【意味】\n five	0	1
60	1107	總是\n\n【よみ】\n いつも\n\n【意味】\n always\n usually	0	1
61	654	狗\n\n【よみ】\n いぬ\n\n【意味】\n dog	0	1
62	134	現在\n\n【よみ】\n いま\n\n【意味】\n now	0	1
63	1556	意思\n\n【よみ】\n いみ\n\n【意味】\n meaning	0	1
64	1139	妹妹\n\n【よみ】\n いもうと\n\n【意味】\n (my) younger sister	0	1
65	1221	討厭\n\n【よみ】\n いや\n\n【意味】\n nasty\n unpleasant\n don't like	0	1
66	1557	入口\n\n【よみ】\n いりぐち\n\n【意味】\n entrance	1	1
67	1559	需要\n\n【よみ】\n いります\n\n【意味】\n need\n require	1	1
68	158	放進去\n\n【よみ】\n いれます\n\n【意味】\n put (into)\n pour	1	1
69	822	顏色\n\n【よみ】\n いろ\n\n【意味】\n color	0	1
70	1503	各種\n\n【よみ】\n いろいろ\n\n【意味】\n e.g., いろいろ　ありがとう　ございます。\n → Thank you very much for everything.	1	1
71	670	上面\n\n【よみ】\n うえ\n\n【意味】\n on\n above\n over	0	1
72	1560	後面\n\n【よみ】\n うしろ\n\n【意味】\n back\n behind	1	1
73	1561	薄\n薄的\n\n【よみ】\n うすい\n\n【意味】\n thin	0	1
74	825	歌\n歌曲\n\n【よみ】\n うた\n\n【意味】\n song	0	1
75	979	唱歌\n\n【よみ】\n うたいます\n\n【意味】\n sing	1	1
76	778	家\n\n【よみ】\n うち\n\n【意味】\n house\n home	0	1
77	1562	出生\n\n【よみ】\n うまれます\n\n【意味】\n be born	1	1
78	920	海\n\n【よみ】\n うみ\n\n【意味】\n sea\n ocean	0	1
79	1268	賣\n\n【よみ】\n うります\n\n【意味】\n sell	1	1
80	1563	吵鬧\n囉嗦\n\n【よみ】\n うるさい\n\n【意味】\n noisy	0	1
81	1564	上衣\n\n【よみ】\n うわぎ\n\n【意味】\n jacket	0	1
82	707	繪畫\n\n【よみ】\n え\n\n【意味】\n picture	0	1
83	323	電影\n\n【よみ】\n えいが\n\n【意味】\n movie	0	1
84	1565	電影院\n\n【よみ】\n えいがかん\n\n【意味】\n movie theater	0	1
85	169	英語\n\n【よみ】\n えいご\n\n【意味】\n English	0	1
86	41	是\n對\n\n【よみ】\n ええ\n\n【意味】\n yes	0	1
87	855	車站\n\n【よみ】\n えき\n\n【意味】\n station	0	1
88	294	電梯\n\n【よみ】\n えれべーたー\n\n【意味】\n elevator	0	1
89	741	～圓\n\n【よみ】\n ～えん\n\n【意味】\n ～yen	1	1
90	1416	鉛筆\n\n【よみ】\n えんぴつ\n\n【意味】\n pencil	0	1
91	1566	よみ ： お～	1	1
92	801	好吃\n美味\n\n【よみ】\n おいしい\n\n【意味】\n delicious\n tasty	0	1
93	412	多\n多的\n\n【よみ】\n おおい\n\n【意味】\n many\n much	0	1
94	729	大\n大的\n\n【よみ】\n おおきい\n\n【意味】\n big\n large	0	1
95	1567	大的\n\n【よみ】\n おおきな\n\n【意味】\n big\n large	0	1
96	1568	很多人\n\n【よみ】\n おおぜい\n\n【意味】\n many people	0	1
97	959	媽媽\n母親\n\n【よみ】\n おかあさん\n\n【意味】\n (someone else's) mother	0	1
98	1569	零嘴\n點心\n糖果\n\n【よみ】\n おかし\n\n【意味】\n confectionary	0	1
99	667	錢\n\n【よみ】\n おかね\n\n【意味】\n money	0	1
100	908	起床\n\n【よみ】\n おきます\n\n【意味】\n get up\n wake up	1	1
101	794	放\n\n【よみ】\n おきます\n\n【意味】\n put	1	1
102	1570	太太\n\n【よみ】\n おくさん\n\n【意味】\n (someone else's) wife	0	1
103	1571	叔叔\n伯伯\n\n【よみ】\n おじさん\n\n【意味】\n (someone else's) uncle\n a middle aged man	1	1
104	1572	爺爺\n\n【よみ】\n おじいさん\n\n【意味】\n (someone else's) grandfather\n old man	0	1
105	420	教\n告訴\n\n【よみ】\n おしえます\n\n【意味】\n teach\n tell	1	1
106	1211	按\n押\n\n【よみ】\n おします\n\n【意味】\n push\n press	1	1
107	137	慢\n慢的\n\n【よみ】\n おそい\n\n【意味】\n slow	1	1
108	1345	茶\n綠茶\n\n【よみ】\n おちゃ\n\n【意味】\n tea\n green tea	0	1
109	1573	洗手間\n\n【よみ】\n おてあらい\n\n【意味】\n toilet\n rest room	0	1
110	829	爸爸\n父親\n\n【よみ】\n おとうさん\n\n【意味】\n (someone else's) father	0	1
111	897	弟弟\n\n【よみ】\n おとうと\n\n【意味】\n (my) younger brother	0	1
112	1574	男人\n\n【よみ】\n おとこ\n\n【意味】\n man	0	1
113	1575	男孩\n\n【よみ】\n おとこのこ\n\n【意味】\n boy	0	1
114	1576	前天\n\n【よみ】\n おととい\n\n【意味】\n the day before yesterday	0	1
115	1577	前年\n\n【よみ】\n おととし\n\n【意味】\n the year before last	0	1
116	1392	大人\n\n【よみ】\n おとな\n\n【意味】\n adult	0	1
117	1200	肚子\n腹部\n\n【よみ】\n おなか\n\n【意味】\n stomach	0	1
118	239	相同\n一樣\n\n【よみ】\n おなじ\n\n【意味】\n the same	0	1
119	1578	哥哥\n\n【よみ】\n おにいさん\n\n【意味】\n (someone else's) older brother	0	1
120	1579	姊姊\n\n【よみ】\n おねえさん\n\n【意味】\n (someone else's) older sister	0	1
121	1580	阿姨\n嬸嬸\n\n【よみ】\n おばさん\n\n【意味】\n (someone else's) aunt\n a middle aged woman	1	1
122	1581	奶奶\n\n【よみ】\n おばあさん\n\n【意味】\n (someone else's) grandmother\n old woman	0	1
123	1582	洗澡\n\n【よみ】\n おふろ\n\n【意味】\n bath	0	1
124	1199	記住\n\n【よみ】\n おぼえます\n\n【意味】\n memorize	1	1
125	1583	(巡邏執勤中的)警察\n\n【よみ】\n おまわりさん\n\n【意味】\n policeman	1	1
126	1584	重\n重的\n\n【よみ】\n おもい\n\n【意味】\n heavy	0	1
127	800	好玩\n有趣\n\n【よみ】\n おもしろい\n\n【意味】\n interesting	0	1
128	895	游泳\n\n【よみ】\n およぎます\n\n【意味】\n swim	1	1
129	1585	下～(下車、下樓梯等等)\n\n【よみ】\n おります\n\n【意味】\n get off\n get out of	1	1
130	775	結束\n\n【よみ】\n おわります\n\n【意味】\n end\n finish	1	1
131	470	音樂\n\n【よみ】\n おんがく\n\n【意味】\n music	0	1
132	727	女人\n\n【よみ】\n おんな\n\n【意味】\n woman	0	1
133	1586	女孩\n\n【よみ】\n おんなのこ\n\n【意味】\n girl	0	1
134	964	～次\n\n【よみ】\n ～かい\n\n【意味】\n ～times	1	1
135	422	外國\n\n【よみ】\n がいこく\n\n【意味】\n foreign country	0	1
136	1587	外國人\n\n【よみ】\n がいこくじん\n\n【意味】\n foreigner	0	1
137	446	公司\n\n【よみ】\n かいしゃ\n\n【意味】\n company	0	1
138	1588	樓梯\n\n【よみ】\n かいだん\n\n【意味】\n staircase	0	1
139	851	購物\n\n【よみ】\n かいもの\n\n【意味】\n shopping	0	1
140	719	買\n購買\n\n【よみ】\n かいます\n\n【意味】\n buy\n purchase	1	1
141	502	還\n退還\n\n【よみ】\n かえします\n\n【意味】\n return\n give ～ back\n repay	1	1
142	1589	回家\n回去\n\n【よみ】\n かえります\n\n【意味】\n go home\n return	1	1
143	931	臉\n\n【よみ】\n かお\n\n【意味】\n face	0	1
144	1590	花(時間、錢)\n\n【よみ】\n かかります\n\n【意味】\n take\n ※ used when reffering to time or money	1	1
145	1591	鑰匙\n\n【よみ】\n かぎ\n\n【意味】\n key\n lock	0	1
146	860	寫\n\n【よみ】\n かきます\n\n【意味】\n write\n draw\n paint	1	1
147	628	學生\n\n【よみ】\n がくせい\n\n【意味】\n student	0	1
148	1592	～個月\n\n【よみ】\n ～かげつ\n\n【意味】\n ～months	1	1
149	1593	よみ ： でんわをかける	0	1
150	1594	戴(眼鏡)\n\n【よみ】\n かけます\n\n【意味】\n put on (glasses)	1	1
151	1595	雨傘\n\n【よみ】\n かさ\n\n【意味】\n umbrella	0	1
152	787	借(給別人)\n\n【よみ】\n かします\n\n【意味】\n lend	1	1
153	103	感冒\n\n【よみ】\n かぜ\n\n【意味】\n cold\n flu	1	1
154	1008	家人\n\n【よみ】\n かぞく\n\n【意味】\n family	0	1
155	1597	～位\n※僅用於この(這位)、あの(那位)\n\n【よみ】\n ～かた\n\n【よみ】\n person\n ※ always used with "この", "あの", etc.	1	1
156	1598	片假名\n\n【よみ】\n かたかな\n\n【意味】\n Katakana script	1	1
157	1599	～月\n\n【よみ】\n ～がつ\n\n【意味】\n ～th month of the year	1	1
158	372	學校\n\n【よみ】\n がっこう\n\n【意味】\n school	0	1
159	1600	杯子\n\n【よみ】\n かっぷ\n\n【意味】\n cup	0	1
160	1601	家庭\n\n【よみ】\n かてい\n\n【意味】\n home\n family	0	1
161	1602	轉角\n\n【よみ】\n かど\n\n【意味】\n corner\n edge	0	1
162	679	背包\n手提包\n公事包\n\n【よみ】\n かばん\n\n【意味】\n bag\n briefcase	0	1
163	1603	花瓶\n\n【よみ】\n かびん\n\n【意味】\n (flower) vase	0	1
164	1604	戴(帽子)\n\n【よみ】\n かぶります\n\n【意味】\n put on (a hat, etc.)	1	1
165	1095	紙\n\n【よみ】\n かみ\n\n【意味】\n paper	0	1
166	1185	照相機\n\n【よみ】\n かめら\n\n【意味】\n  camera	0	1
167	1605	星期二\n\n【よみ】\n かようび\n\n【意味】\n Tuesday	0	1
168	1378	辣\n辣的\n\n【よみ】\n からい\n\n【意味】\n hot (of taste)\n spicy	0	1
169	1606	身體\n\n【よみ】\n からだ\n\n【意味】\n body	0	1
170	788	(向別人)借\n\n【よみ】\n かります\n\n【意味】\n borrow\n rent	1	1
171	1607	想～(用於第三人稱)\n\n【よみ】\n ～がる\n\n【意味】\n (someone) want to ～	1	1
172	1608	輕\n輕的\n\n【よみ】\n かるい\n\n【意味】\n light\n 	0	1
173	1609	咖哩\n\n【よみ】\n かれー\n\n【意味】\n curry (and rice)	0	1
174	1610	日曆\n\n【よみ】\n かれんだー\n\n【意味】\n calendar	0	1
175	1611	河流\n河川\n\n【よみ】\n かわ\n\n【意味】\n river	1	1
176	1612	靠～那邊\n\n【よみ】\n ～がわ\n\n【意味】\n at the side of ～	1	1
177	1613	可愛\n\n【よみ】\n かわいい\n\n【意味】\n pretty\n cute	0	1
178	319	漢字\n\n【よみ】\n かんじ\n\n【意味】\n Chinese characters	0	1
179	1614	木頭\n樹木\n\n【よみ】\n き\n\n【意味】\n tree\n wood	0	1
180	1615	黃色\n\n【よみ】\n きいろ\n\n【意味】\n yellow	0	1
181	1616	黃色的\n\n【よみ】\n きいろい\n\n【意味】\n yellow	0	1
182	1617	消失\n不見\n\n【よみ】\n きえます\n\n【意味】\n disappear\n go out	1	1
183	1618	問\n\n【よみ】\n ききます\n\n【意味】\n ask	1	1
184	685	北\n北邊\n\n【よみ】\n きた\n\n【意味】\n north	0	1
185	1619	吉他\n\n【よみ】\n ぎたー\n\n【意味】\n guitar	0	1
187	1621	咖啡店\n\n【よみ】\n きっさてん\n\n【意味】\n tea room\n coffee shop	0	1
188	1374	郵票\n\n【よみ】\n きって\n\n【意味】\n postage stamp	0	1
189	1622	車票\n\n【よみ】\n きっぷ\n\n【意味】\n ticket	0	1
190	1623	昨天\n\n【よみ】\n きのう\n\n【意味】\n yesterday	1	1
192	1625	牛肉\n\n【よみ】\n ぎゅうにく\n\n【意味】\n beef	0	1
193	1626	牛乳\n鮮奶\n\n【よみ】\n ぎゅうにゅう\n\n【意味】\n milk	0	1
194	5	今天\n\n【よみ】\n きょう\n\n【意味】\n today	1	1
195	664	教室\n\n【よみ】\n きょうしつ\n\n【意味】\n classroom\n lecture room	0	1
196	1627	兄弟姊妹\n\n【よみ】\n きょうだい\n\n【意味】\n brother(s) and sister(s)	0	1
197	205	去年\n\n【よみ】\n きょねん\n\n【意味】\n last year	0	1
198	1628	討厭\n不喜歡\n\n【よみ】\n きらい\n\n【意味】\n dislike	0	1
199	861	切\n\n【よみ】\n きります\n\n【意味】\n cut	1	1
200	726	漂亮\n整齊清潔\n\n【よみ】\n きれい\n\n【意味】\n beautiful\n clean	0	1
201	1629	公里\n\n【よみ】\n ～きろ／きろぐらむ\n\n【意味】\n ～kilogram	1	1
202	1630	銀行\n\n【よみ】\n ぎんこう\n\n【意味】\n bank	0	1
203	101	星期五\n\n【よみ】\n きんようび\n\n【意味】\n Friday	0	1
205	1631	藥\n\n【よみ】\n くすり\n\n【意味】\n medicine (include ointment, eye lotion, etc.)	0	1
206	1632	水果\n\n【よみ】\n くだもの\n\n【意味】\n fruit	0	1
207	1633	口\n嘴巴\n\n【よみ】\n くち\n\n【意味】\n mouth	0	1
208	717	鞋子\n\n【よみ】\n くつ\n\n【意味】\n shoes	0	1
209	889	襪子\n\n【よみ】\n くつした\n\n【意味】\n socks	0	1
210	1634	國\n國家\n\n【よみ】\n くに\n\n【意味】\n country	1	1
211	1635	陰天\n\n【よみ】\n くもり\n\n【意味】\n cloudy	0	1
212	1636	變陰天\n\n【よみ】\n くもります\n\n【意味】\n get cloudy	1	1
213	1637	大概\n大約\n\n【よみ】\n ～くらい／ぐらい\n\n【意味】\n about ～	1	1
214	1016	班級\n\n【よみ】\n くらす\n\n【意味】\n class\n homeroom	0	1
215	1638	公克\n\n【よみ】\n ～ぐらむ\n\n【意味】\n ～gram	1	1
216	185	よみ ： くる	0	1
217	278	汽車\n\n【よみ】\n くるま\n\n【意味】\n car\n vehicle	0	1
218	1639	黑\n黑色\n\n【よみ】\n くろ\n\n【意味】\n black	0	1
219	720	黑\n黑的\n\n【よみ】\n くろい\n\n【意味】\n black	0	1
220	1640	警察\n警官\n\n【よみ】\n けいかん\n\n【意味】\n policeman	0	1
221	1641	今天早上\n\n【よみ】\n けさ\n\n【意味】\n this morning	1	1
222	854	消掉\n關掉\n\n【よみ】\n けします\n\n【意味】\n turn off	1	1
223	212	相當\n\n【よみ】\n けっこう\n\n【意味】\n very well	0	1
224	1395	よみ ： けっこん	0	1
225	1642	結婚\n\n【よみ】\n けっこんします\n\n【意味】\n marry\n get married	1	1
226	869	星期一\n\n【よみ】\n げつようび\n\n【意味】\n Monday	0	1
227	1643	玄關\n門口\n\n【よみ】\n げんかん\n\n【意味】\n front door\n entrance hall	0	1
228	705	健康\n有精神\n\n【よみ】\n げんき\n\n【意味】\n healthy\n cheerful	0	1
229	1644	～個\n\n【よみ】\n ～こ\n\n【意味】\n a term for counting eggs, confectionary, soap, etc.	1	1
230	1111	～語\n\n【よみ】\n ～ご\n\n【意味】\n ～ language	1	1
231	649	公園\n\n【よみ】\n こうえん\n\n【意味】\n park	0	1
232	1646	十字路口\n\n【よみ】\n こうさてん\n\n【意味】\n crossing\n intersection	0	1
233	1178	紅茶\n\n【よみ】\n こうちゃ\n\n【意味】\n black tea	0	1
234	1647	派出所\n\n【よみ】\n こうばん\n\n【意味】\n police box	0	1
235	980	聲音\n\n【よみ】\n こえ\n\n【意味】\n voice	0	1
236	1648	外套\n\n【よみ】\n こーと\n\n【意味】\n coat	0	1
237	1177	咖啡\n\n【よみ】\n こーひー\n\n【意味】\n coffee	0	1
238	21	這裡\n\n【よみ】\n ここ\n\n【意味】\n here\n this place	0	1
239	1063	下午\n\n【よみ】\n ごご\n\n【意味】\n p.m\n afternoon	0	1
240	1649	九日\n九天\n\n【よみ】\n ここのか\n\n【意味】\n ninth\n nine days	0	1
241	1650	九個\n\n【よみ】\n ここのつ\n\n【意味】\n nine	0	1
242	1376	上午\n\n【よみ】\n ごぜん\n\n【意味】\n a.m\n morning	0	1
243	1651	回答\n\n【よみ】\n こたえます\n\n【意味】\n answer	1	1
244	161	我這裡\n我這邊(較有禮貌的說法)\n\n【よみ】\n こちら\n\n【意味】\n this way\n this place\n ※ the more polite equivalent of "ここ"\n\n this\n ※ the more polite equivalent of "これ"	0	1
245	528	我這裡\n我這邊(比較口語的說法)\n\n【よみ】\n こっち\n\n【意味】\n this way\n this place\n ※ the informal equivalent of "こちら"	0	1
247	970	今年\n\n【よみ】\n ことし\n\n【意味】\n this year	0	1
248	1653	言詞\n言語\n\n【よみ】\n ことば\n\n【意味】\n word\n language	1	1
249	1654	小孩子\n\n【よみ】\n こども\n\n【意味】\n child	1	1
250	32	這個\n\n【よみ】\n この\n\n【意味】\n this ～\n this ～ here	0	1
251	1655	飯\n\n【よみ】\n ごはん\n\n【意味】\n a meal\n boiled rice	1	1
252	353	影印\n拷貝(名詞)\n\n【よみ】\n こぴー\n\n【意味】\n copy	0	1
253	1656	影印\n拷貝(動詞)\n\n【よみ】\n こぴーします\n\n【意味】\n copy	1	1
254	252	為難\n\n【よみ】\n こまります\n\n【意味】\n be in trouble	1	1
255	117	這個\n\n【よみ】\n これ\n\n【意味】\n this\n thing here	0	1
256	1657	～的時候\n\n【よみ】\n ～ころ／ごろ\n\n【意味】\n about (of time)	1	1
257	245	這個月\n\n【よみ】\n こんげつ\n\n【意味】\n this month	0	1
258	1658	這個星期\n\n【よみ】\n こんしゅう\n\n【意味】\n this week	0	1
259	1659	這麼～\n如此～\n\n【よみ】\n こんな\n\n【意味】\n such	0	1
260	1085	今晚\n\n【よみ】\n こんばん\n\n【意味】\n this evening\n tonight	0	1
261	1066	好\n請\n※用於催促對方行動時\n\n【よみ】\n さあ\n\n【意味】\n right\n now\n ※ used when encouraging some course of action	0	1
262	1660	～歲\n\n【よみ】\n ～さい\n\n【意味】\n ～years old	1	1
263	1661	皮包\n錢包\n\n【よみ】\n さいふ\n\n【意味】\n purse\n wallet	0	1
264	1406	魚\n\n【よみ】\n さかな\n\n【意味】\n fish	0	1
265	1662	前面\n\n【よみ】\n さき\n\n【意味】\n ahead	0	1
266	969	開花\n\n【よみ】\n さきます\n\n【意味】\n flower\n bloom\n blossom	1	1
267	1174	作文\n\n【よみ】\n さくぶん\n\n【意味】\n composition writing	0	1
268	1047	よみ ： さけ	0	1
269	1663	撐(傘)\n\n【よみ】\n さします\n\n【意味】\n put up (an umbrella)	1	1
270	742	～本\n\n【よみ】\n ～さつ\n\n【意味】\n a term for counting books etc.	1	1
271	743	雜誌\n\n【よみ】\n ざっし\n\n【意味】\n magazine	0	1
272	1664	砂糖\n\n【よみ】\n さとう\n\n【意味】\n sugar	0	1
273	799	冷\n寒冷\n\n【よみ】\n さむい\n\n【意味】\n cold\n ※ used when referring to temperature	0	1
274	1665	よみ ： さら	0	1
275	1666	後年\n\n【よみ】\n さらいねん\n\n【意味】\n the year after next	1	1
276	1668	～先生/小姐/女士\n\n【よみ】\n ～さん\n\n【意味】\n Mr.\n Mrs.\n Ms.\n ※ the title of respect added to a name	1	1
277	1669	散步\n\n【よみ】\n さんぽ\n\n【意味】\n walk	0	1
278	1670	四\n\n【よみ】\n し／よん\n\n【意味】\n four	0	1
280	1671	鹽\n\n【よみ】\n しお\n\n【意味】\n salt	0	1
281	1672	但是\n可是\n\n【よみ】\n しかし\n\n【意味】\n but\n however	0	1
282	1264	時間\n\n【よみ】\n じかん\n\n【意味】\n time	0	1
283	197	工作\n\n【よみ】\n しごと\n\n【意味】\n work\n job\n business	0	1
284	722	字典\n辭典\n\n【よみ】\n じしょ\n\n【意味】\n dictionary	0	1
285	716	安靜\n\n【よみ】\n しずか\n\n【意味】\n quiet\n still\n silent	0	1
286	671	下面\n\n【よみ】\n した\n\n【意味】\n under\n below\n beneath	0	1
287	1673	七\n\n【よみ】\n しち／なな\n\n【意味】\n seven	0	1
288	666	問題\n\n【よみ】\n しつもん\n\n【意味】\n question	0	1
289	1093	自行車\n腳踏車\n\n【よみ】\n じてんしゃ\n\n【意味】\n bicycle	0	1
290	1674	汽車\n\n【よみ】\n じどうしゃ\n\n【意味】\n automobile\n car	0	1
291	1675	死\n\n【よみ】\n しにます\n\n【意味】\n die	1	1
292	1676	よみ ： じびき	0	1
293	317	自己\n\n【よみ】\n じぶん\n\n【意味】\n oneself	0	1
294	1193	關\n關閉\n\n【よみ】\n しまります\n\n【意味】\n close\n shut	1	1
295	1677	よみ ： しめます	1	1
296	68	那麼…\n接下來…\n\n【よみ】\n じゃあ\n\n【意味】\n well\n then\n in that case	1	1
297	946	照片\n\n【よみ】\n しゃしん\n\n【意味】\n photograph	0	1
298	972	襯衫\n\n【よみ】\n しゃつ\n\n【意味】\n shirt	0	1
299	1678	淋浴\n\n【よみ】\n しゃわー\n\n【意味】\n shower	0	1
300	1355	十\n\n【よみ】　\n じゅう\n\n【意味】\n ten	0	1
301	1455	～個星期\n\n【よみ】\n ～しゅうかん\n\n【意味】\n ～week(s)	1	1
302	7	(學校的)課\n\n【よみ】\n じゅぎょう\n\n【意味】\n lesson\n class	0	1
303	303	作業\n\n【よみ】\n しゅくだい\n\n【意味】\n homework	0	1
304	1012	很會…\n善於…\n\n【よみ】\n じょうず\n\n【意味】\n good at\n skillful\n clever	0	1
305	1680	強壯\n\n\n【よみ】\n じょうぶ\n\n【意味】\n healthy\n strong	0	1
306	1681	醬油\n\n【よみ】\n しょうゆ\n\n【意味】\n soy sauce	1	1
307	909	餐廳\n\n【よみ】\n しょくどう\n\n【意味】\n lunchroom\n cafeteria	0	1
308	845	知道\n\n【よみ】\n しります\n\n【意味】\n know	1	1
309	1682	白色\n\n【よみ】\n しろ\n\n【意味】\n white	0	1
310	1094	白的\n白色的\n\n【よみ】\n しろい\n\n【意味】\n white	0	1
311	1683	よみ ： じん	0	1
312	694	報紙\n\n【よみ】\n しんぶん\n\n【意味】\n newspaper	0	1
313	270	星期三\n\n【よみ】\n すいようび\n\n【意味】\n Wednesday	0	1
314	1684	吸\n\n【よみ】\n すいます\n\n【意味】\n smoke	1	1
315	1685	裙子\n\n【よみ】\n すかーと\n\n【意味】\n skirt	0	1
316	324	喜歡\n\n【よみ】\n すき\n\n【意味】\n like	0	1
317	1686	超過～(幾分鐘等等)\n\n【よみ】\n ～すぎ\n\n【意味】\n some minute past ～o'clock	1	1
318	1218	立刻\n馬上\n\n【よみ】\n すぐ／すぐに\n\n【意味】\n at once\n immediately	1	1
319	1687	少\n\n【よみ】\n すくない\n\n【意味】\n few\n little	0	1
320	193	一點點\n\n【よみ】\n すこし\n\n【意味】\n a few\n a litttle\n some	0	1
321	1688	涼\n\n【よみ】\n すずしい\n\n【意味】\n cool	0	1
322	1689	每～(幾個等等)\n\n【よみ】\n ～ずつ\n\n【意味】\n each\n ～ at one time	1	1
323	1690	暖爐\n\n【よみ】\n すとーぶ\n\n【意味】\n heater	0	1
324	1691	湯匙\n\n【よみ】\n すぷーん\n\n【意味】\n spoon	0	1
325	1099	運動\n\n【よみ】\n すぽーつ\n\n【意味】\n sport	0	1
326	962	褲子\n長褲\n\n【よみ】\n ずぼん\n\n【意味】\n trousers\n pants	0	1
327	880	住\n\n【よみ】\n すみます\n\n【意味】\n live	1	1
328	1692	拖鞋\n\n【よみ】\n すりっぱ\n\n【意味】\n mules\n scuffs	0	1
329	760	よみ ： する	0	1
330	915	坐\n\n【よみ】\n すわります\n\n【意味】\n sit down	1	1
331	815	背\n身高\n\n【よみ】\n せ\n\n【意味】\n back\n height	0	1
332	1163	學生\n\n【よみ】\n せいと\n\n【意味】\n pupil\n student	0	1
333	1403	毛衣\n\n【よみ】\n せーたー\n\n【意味】\n sweater	0	1
334	1693	肥皂\n香皂\n\n【よみ】\n せっけん\n\n【意味】\n soap	1	1
335	1694	よみ ： せびろ	0	1
336	821	狹窄\n\n【よみ】\n せまい\n\n【意味】\n narrow\n small (room etc.)	0	1
337	1695	零\n\n【よみ】\n ぜろ\n\n【意味】\n zero	0	1
338	1696	千\n\n【よみ】\n せん\n\n【意味】\n thousand	0	1
339	1400	上個月\n\n【よみ】\n せんげつ\n\n【意味】\n last month	0	1
340	1283	上個星期\n\n【よみ】\n せんしゅう\n\n【意味】\n last week	0	1
341	2	老師\n\n【よみ】\n せんせい\n\n【意味】\n teacher\n instructor\n ※ not used when referring to one's own job\n\n doctor\n ※ used when addressing a medical doctor in stead of "Dr.～"	0	1
342	1697	洗衣服(名詞)\n\n【よみ】\n せんたく\n\n【意味】\n washing (clothes)	0	1
343	1698	洗衣服(動詞)\n\n【よみ】\n せんたくします\n\n【意味】\n wash (clothes)	1	1
344	214	全部\n\n【よみ】\n ぜんぶ\n\n【意味】\n all\n whole	0	1
345	45	這樣、這麼\n那樣、那麼\n\n【よみ】\n そう\n\n【意味】\n so	0	1
346	1074	打掃(名詞)\n\n【よみ】\n そうじ\n\n【意味】\n cleaning (room etc.)	0	1
347	1699	打掃(動詞)\n\n【よみ】\n そうじします\n\n【意味】\n clean (room etc.)	1	1
348	1700	然後\n接著\n\n【よみ】\n そして\n\n【意味】\n and\n ※ used when connecting sentences	1	1
349	524	那裡\n那邊\n\n【よみ】\n そこ\n\n【意味】\n there\n that place near the listener	0	1
350	1262	(你)那裡\n(你)那邊\n\n【よみ】\n そちら\n\n【意味】\n that way\n that place near the listener\n ※ the more polite equivalent of "そこ"\n\n that\n thing near the listener\n ※ the more polite equivalent of "それ"	0	1
351	531	(你)那裡\n(你)那邊\n※比較口語的說法\n\n【よみ】\n そっち\n\n【意味】\n that way\n that place\n ※ the informal equivalent of "そちら"	0	1
352	676	外面\n\n【よみ】\n そと\n\n【意味】\n outside\n outdoor	1	1
353	515	那個\n\n【よみ】\n その\n\n【意味】\n that ～\n that ～ near the listener	0	1
354	1701	旁邊\n\n【よみ】\n そば\n\n【意味】\n near\n close	0	1
355	938	天空\n\n【よみ】\n そら\n\n【意味】\n sky\n air	0	1
356	46	那個\n\n【よみ】\n それ\n\n【意味】\n that\n thing near the listener	0	1
357	31	然後\n後來\n\n【よみ】\n それから\n\n【意味】\n after that\n and then	0	1
358	1702	那麼…\n\n【よみ】\n それでは\n\n【意味】\n well then	0	1
359	1703	～輛\n\n【よみ】\n ～だい\n\n【意味】\n ※ a term for counting machines, cars, etc.	1	1
360	425	大學\n\n【よみ】\n だいがく\n\n【意味】\n university\n college	0	1
361	1704	大使館\n\n【よみ】\n たいしかん\n\n【意味】\n embassy	0	1
362	175	沒問題\n\n【よみ】\n だいじょうぶ\n\n【意味】\n all right	0	1
363	1481	好喜歡\n非常喜歡\n\n【よみ】\n だいすき\n\n【意味】\n like ～ very much	0	1
364	1705	重要的\n\n【よみ】\n たいせつ\n\n【意味】\n important\n valuable\n precious	0	1
365	1706	廚房\n\n【よみ】\n だいどころ\n\n【意味】\n kitchen	0	1
366	91	辛苦\n\n【よみ】\n たいへん\n\n【意味】\n hard\n tough\n severe\n awful	1	1
367	803	高\n\n【よみ】\n たかい\n\n【意味】\n tall\n high	1	1
368	1227	很多\n\n【よみ】\n たくさん\n\n【意味】\n many\n much	0	1
369	1707	計程車\n\n【よみ】\n たくしー\n\n【意味】\n taxi	0	1
370	1708	只有～\n\n【よみ】\n ～だけ\n\n【意味】\n only	1	1
371	786	提出\n送出\n\n【よみ】\n だします\n\n【意味】\n take ～ out\n send\n submit	1	1
372	1709	～們(複數人稱)\n\n【よみ】\n ～たち\n\n【意味】\n ※ used when referring to person to show plural	1	1
373	839	站起來\n\n【よみ】\n たちます\n\n【意味】\n stand up	1	1
374	1710	縱\n\n【よみ】\n たて\n\n【意味】\n vertical line	0	1
375	285	建築物\n\n【よみ】\n たてもの\n\n【意味】\n building	0	1
376	941	高興\n開心\n愉快\n\n【よみ】\n たのしい\n\n【意味】\n enjoyable	0	1
377	1290	拜託\n要求\n\n【よみ】\n たのみます\n\n【意味】\n ask	1	1
378	1045	香菸\n\n【よみ】\n たばこ\n\n【意味】\n tobacco\n cigarette	0	1
379	1711	よみ ： たぶん	0	1
380	710	食物\n\n【よみ】\n たべもの\n\n【意味】\n food	0	1
381	337	吃\n\n【よみ】\n たべます\n\n【意味】\n eat\n have	1	1
382	877	蛋\n雞蛋\n\n【よみ】\n たまご\n\n【意味】\n egg	0	1
383	1712	誰\n\n【よみ】\n だれ\n\n【意味】\n who	0	1
384	1713	某人\n\n【よみ】\n だれか\n\n【意味】\n someone	0	1
385	1714	生日\n\n【よみ】\n たんじょうび\n\n【意味】\n birthday	0	1
386	1715	漸漸地\n慢慢地\n\n【よみ】\n だんだん\n\n【意味】\n gradually\n little by little	1	1
387	704	小\n\n【よみ】\n ちいさい\n\n【意味】\n small\n little	0	1
388	1716	小的\n\n【よみ】\n ちいさな\n\n【意味】\n small\n little	0	1
389	1220	近\n近的\n\n【よみ】\n ちかい\n\n【意味】\n near\n close	0	1
390	1019	不對\n不一樣\n\n【よみ】\n ちがいます\n\n【意味】\n differ	1	1
391	686	附近\n\n【よみ】\n ちかく\n\n【意味】\n near\n close	0	1
392	1717	地下鐵\n\n【よみ】\n ちかてつ\n\n【意味】\n subway\n underground	0	1
393	1024	地圖\n\n【よみ】\n ちず\n\n【意味】\n map	0	1
394	634	父親\n爸爸\n\n【よみ】\n ちち\n\n【意味】\n (my) father	0	1
395	1718	褐色\n茶色\n咖啡色\n\n【よみ】\n ちゃいろ\n\n【意味】\n brown	0	1
396	1719	飯碗\n\n【よみ】\n ちゃわん\n\n【意味】\n rice bowl	1	1
398	423	剛好\n\n【よみ】\n ちょうど\n\n【意味】\n just	0	1
399	152	一點\n\n【よみ】\n ちょっと\n\n【意味】\n a little while\n a little bit	0	1
400	1720	一日(每個月的第一天)\n\n【よみ】\n ついたち\n\n【意味】\n first day of the month	1	1
401	507	用\n\n【よみ】\n つかいます\n\n【意味】\n use	1	1
402	1721	累\n疲倦\n\n【よみ】\n つかれます\n\n【意味】\n be tired	1	1
403	498	下一個\n\n【よみ】\n つぎ\n\n【意味】\n next	0	1
404	1722	到達\n抵達\n\n【よみ】\n つきます\n\n【意味】\n arrive\n reach	1	1
405	1723	桌子\n\n【よみ】\n つくえ\n\n【意味】\n desk	0	1
406	1724	做\n製造\n\n【よみ】\n つくります\n\n【意味】\n make\n produce\n manufacture	1	1
407	1725	裝上\n安裝\n\n【よみ】\n つけます\n\n【意味】\n turn on	1	1
408	1402	工作\n\n【よみ】\n つとめます\n\n【意味】\n work	1	1
547	1786	よみ ： ひとつき	0	1
409	120	無聊\n無趣\n\n【よみ】\n つまらない\n\n【意味】\n uninteresting\n worthless	0	1
410	1726	冰\n冰的\n\n【よみ】\n つめたい\n\n【意味】\n cold\n ※ used when referring to touch	0	1
411	817	強\n強的\n\n【よみ】\n つよい\n\n【意味】\n strong	0	1
412	1030	手\n\n【よみ】\n て\n\n【意味】\n hand\n arm	0	1
413	918	錄音帶\n\n【よみ】\n てーぷ\n\n【意味】\n (cassette) tape	0	1
414	1727	桌子\n\n【よみ】\n てーぶる\n\n【意味】\n table	0	1
415	1728	よみ ： てーぷれこーだー	0	1
416	1729	出門\n出去\n\n【よみ】\n でかけます\n\n【意味】\n go out\n 	1	1
417	785	信\n\n【よみ】\n てがみ\n\n【意味】\n letter	0	1
418	893	可以\n能夠\n\n【よみ】\n できます\n\n【意味】\n be able to\n can	1	1
419	1730	よみ ： てください	0	1
420	1731	出口\n\n【よみ】\n でぐち\n\n【意味】\n exit	0	1
421	937	考試\n測驗\n\n【よみ】\n てすと\n\n【意味】\n test\n examination	0	1
422	144	那麼…\n\n【よみ】\n では\n\n【意味】\n well then	0	1
423	874	百貨公司\n\n【よみ】\n でぱーと\n\n【意味】\n department store	0	1
424	106	可是\n\n【よみ】\n でも\n\n【意味】\n though	0	1
425	553	出去\n出來\n\n【よみ】\n でます\n\n【意味】\n go out\n graduated from	1	1
426	761	電視\n\n【よみ】\n てれび\n\n【意味】\n television	0	1
427	1164	天氣\n\n【よみ】\n てんき\n\n【意味】\n weather	0	1
428	853	電力\n\n【よみ】\n でんき\n\n【意味】\n electricity\n light	0	1
429	927	電車\n電聯車\n\n【よみ】\n でんしゃ\n\n【意味】\n electric train	0	1
430	109	電話\n\n【よみ】\n でんわ\n\n【意味】\n telephone\n telephone call	0	1
431	1732	門\n\n【よみ】\n と\n\n【意味】\n door\n sliding door	0	1
432	1733	～度\n\n【よみ】\n ～ど\n\n【意味】\n ～degree(s)	1	1
433	1212	門\n\n【よみ】\n どあ\n\n【意味】\n door	0	1
434	731	廁所\n洗手間\n\n【よみ】\n といれ\n\n【意味】\n toilet\n rest room	0	1
435	291	如何\n\n【よみ】\n どう\n\n【意味】\n how	0	1
436	398	為什麼\n\n【よみ】\n どうして\n\n【意味】\n why	0	1
437	29	請\n\n【よみ】\n どうぞ\n\n【意味】\n Please.\n Here you are.\n ※ used when offering someone something	0	1
438	1734	動物\n\n【よみ】\n どうぶつ\n\n【意味】\n animal	0	1
439	345	謝謝\n你好\n\n【よみ】\n どうも\n\n【意味】\n Well, thanks.	0	1
440	1735	十\n\n【よみ】\n とお\n\n【意味】\n ten	1	1
441	1736	遠\n遠的\n\n【よみ】\n とおい\n\n【意味】\n far\n long way	0	1
442	1737	十日\n\n【よみ】\n とおか\n\n【いみ】\n tenth\n ten days	0	1
443	750	よみ ： ～じ	1	1
444	1738	有時候\n\n【よみ】\n ときどき\n\n【意味】\n sometimes	1	1
445	1137	時鐘\n\n【よみ】\n とけい\n\n【意味】\n clock\n watch	0	1
446	284	哪裡\n\n【よみ】\n どこ\n\n【意味】\n where\n what place	0	1
447	1739	地方\n\n【よみ】\n ところ\n\n【意味】\n place	0	1
448	1740	年\n\n【よみ】\n とし\n\n【意味】\n year	1	1
449	138	圖書館\n\n【よみ】\n としょかん\n\n【意味】\n library	0	1
450	1299	哪裡(較有禮貌的說法)\n\n【よみ】\n どちら\n\n【意味】\n which way\n where\n ※ the more polite equivalent of "どこ"\n\n which one (between two things)	0	1
451	1741	哪裡(比較口語的說法)\n\n【よみ】\n どっち\n\n【意味】\n which way\n where\n ※ the informal equivalent of "どこ"\n\n which one (between two things)	0	1
452	42	很\n非常\n\n【よみ】\n とても\n\n【意味】\n very\n very much	0	1
453	1358	誰\n哪位\n(比較正式的說法)\n\n【よみ】\n どなた\n\n【意味】\n who\n ※ the more polite equivalent of "だれ"	0	1
454	1742	旁邊\n隔壁\n\n【よみ】\n となり\n\n【意味】\n next\n next door	0	1
455	1743	哪個～(對象有三個以上時)\n\n【よみ】\n どの\n\n【意味】\n which ～\n ※ used when referring to three or more	0	1
456	982	飛\n\n【よみ】\n とびます\n\n【意味】\n fly	1	1
457	928	停\n\n【よみ】\n とまります\n\n【意味】\n stop	1	1
458	190	朋友\n\n【よみ】\n ともだち\n\n【意味】\n friend	0	1
459	562	星期六\n\n【よみ】\n どようび\n\n【意味】\n Saturday	0	1
460	1156	鳥\n\n【よみ】\n とり\n\n【意味】\n bird	0	1
461	1744	雞肉\n\n【よみ】\n とりにく\n\n【意味】\n chicken	1	1
462	1170	照相\n拍照\n\n【よみ】\n とります\n\n【意味】\n take (a photograph)	1	1
463	296	哪個(有三個以上的選擇時)\n\n【よみ】\n どれ\n\n【意味】\n which one (of three or more)	0	1
464	466	什麼樣的～\n\n【よみ】\n どんな\n\n【意味】\n what kind of ～	0	1
465	1745	よみ ： ない	0	1
466	1746	刀子\n\n【よみ】\n ないふ\n\n【意味】\n knife	0	1
467	675	裡面\n\n【よみ】\n なか\n\n【意味】\n in\n inside	0	1
468	35	長\n長的\n\n【よみ】\n ながい\n\n【意味】\n long	1	1
469	1747	一邊～\n～的同時\n\n【よみ】\n ～ながら\n\n【意味】\n with ～ing\n ※ not used for main action	1	1
470	1748	哭\n哭泣\n\n【よみ】\n なきます\n\n【意味】\n cry	1	1
471	1749	弄丟\n失去\n\n【よみ】\n なくします\n\n【意味】\n lose	1	1
472	440	為何\n為什麼\n\n【よみ】\n なぜ\n\n【意味】\n why	0	1
473	188	夏天\n\n【よみ】\n なつ\n\n【意味】\n summer	0	1
474	184	暑假\n\n【よみ】\n なつやすみ\n\n【意味】\n summer vacation	0	1
686	1857	零\n\n【よみ】\n れい\n\n【意味】\n zero	0	1
475	1750	～等等\n\n【よみ】\n ～など\n\n【意味】\n and so on\n etc.	1	1
476	1751	七個\n\n【よみ】\n ななつ\n\n【意味】\n seven	0	1
477	123	幾～(幾人、幾天、幾個等等)\n\n【よみ】\n なん～\n\n【意味】\n what ～\n how ～	1	1
478	1752	七日\n\n【よみ】\n なのか\n\n【意味】\n seventh\n seven days	0	1
479	1032	姓名\n\n【よみ】\n なまえ\n\n【意味】\n name	0	1
480	790	學習\n\n【よみ】\n ならいます\n\n【意味】\n learn	1	1
481	1753	排隊\n排列(東西)\n\n【よみ】\n ならびます\n\n【意味】\n line up	1	1
482	1754	排好\n排列好\n\n【よみ】\n ならべます\n\n【意味】\n arrange\n line up\n set	1	1
483	1755	變成\n\n【よみ】\n なります\n\n【意味】\n become	1	1
484	1756	二\n\n【よみ】\n に\n\n【意味】\n two	1	1
485	1757	熱鬧\n\n【よみ】\n にぎやか\n\n【意味】\n lively	0	1
486	1758	肉\n\n【よみ】\n にく\n\n【意味】\n meat	0	1
487	1079	西\n西邊\n\n【よみ】\n にし\n\n【意味】\n west	0	1
488	1759	～日\n\n【よみ】\n ～にち\n\n【意味】\n ～th day of the month\n ～days	1	1
489	758	星期日\n星期天\n\n【よみ】\n にちようび\n\n【意味】\n Sunday	0	1
490	1075	行李\n\n【よみ】\n にもつ\n\n【意味】\n baggage\n parcel	0	1
491	1265	新聞\n\n【よみ】\n にゅーす\n\n【意味】\n news	0	1
492	929	院子\n\n【よみ】\n にわ\n\n【意味】\n garden	0	1
494	1760	脫\n\n【よみ】\n ぬぎます\n\n【意味】\n take off (clothes, shoes, hat, etc.)	1	1
495	1761	よみ ： ぬるい	1	1
496	1762	領帶\n\n【よみ】\n ねくたい\n\n【意味】\n tie	0	1
497	681	貓\n\n【よみ】\n ねこ\n\n【意味】\n cat	0	1
498	1329	睡覺\n\n【よみ】\n ねます\n\n【意味】\n sleep\n go to bed	1	1
499	844	～年\n\n【よみ】\n ～ねん\n\n【意味】\n ～year(s)	1	1
500	657	筆記本\n\n【よみ】\n のーと\n\n【意味】\n notebook	0	1
501	923	爬\n登\n\n【よみ】\n のぼります\n\n【意味】\n climb	1	1
502	1263	飲料\n\n【よみ】\n のみもの\n\n【意味】\n drink	0	1
503	782	喝\n\n【よみ】\n のみます\n\n【意味】\n drink	1	1
504	952	坐\n搭乘\n\n【よみ】\n のります\n\n【意味】\n take\n ride\n get on / in	1	1
505	1763	牙齒\n\n【よみ】\n は\n\n【意味】\n tooth	0	1
506	764	派對\n宴會\n\n【よみ】\n ぱーてぃー\n\n【意味】\n party	0	1
507	1764	～杯\n\n【よみ】\n ～はい\n\n【意味】\n ※ a term for counting drinks	1	1
508	1765	菸灰缸\n\n【よみ】\n はいざら\n\n【意味】\n ashtray	0	1
509	993	進去\n進入\n\n【よみ】\n はいります\n\n【意味】\n enter\n take (a bath)	1	1
510	1375	明信片\n\n【よみ】\n はがき\n\n【意味】\n post card	0	1
511	1766	穿上\n\n【よみ】\n はきます\n\n【意味】\n put on (trousers, shoes, etc.)	1	1
512	703	箱子\n\n【よみ】\n はこ\n\n【意味】\n box	0	1
513	1768	よみ ： はし	0	1
514	1769	開始\n\n【よみ】\n はじまります\n\n【意味】\n begin\n start	1	1
515	1770	剛開始\n\n【よみ】\n はじめ／はじめに\n\n【意味】\n the beginning	1	1
516	63	第一次\n\n【よみ】\n はじめて\n\n【意味】\n for the first time	0	1
517	944	跑\n\n【よみ】\n はしります\n\n【意味】\n run	1	1
518	1002	公車\n巴士\n\n【よみ】\n ばす\n\n【意味】\n bus	0	1
519	1771	よみ ： ばたー	0	1
520	1772	二十歲\n\n【よみ】\n はたち\n\n【意味】\n twenty years old\n twenty years of age	1	1
521	831	工作\n\n【よみ】\n はたらきます\n\n【意味】\n work	1	1
522	1773	八\n\n【よみ】\n はち\n\n【意味】\n eight	0	1
523	1774	二十日\n\n【よみ】\n はつか\n\n【意味】\n twentieth\n twenty days	0	1
524	1415	鼻子\n\n【よみ】\n はな\n\n【意味】\n nose	0	1
525	1776	話\n\n【よみ】\n はなし\n\n【意味】\n talk\n speech\n story	0	1
526	865	說話\n\n【よみ】\n はなします\n\n【意味】\n talk\n speak	1	1
527	617	媽媽\n母親\n\n【よみ】\n はは\n\n【意味】\n (my) mother	0	1
528	1082	快\n快的\n\n【よみ】\n はやい\n\n【意味】\n early\n	0	1
529	1778	貼\n\n【よみ】\n はります\n\n【意味】\n stick	1	1
530	646	晴\n\n【よみ】\n はれ\n\n【意味】\n sunny\n fair	0	1
531	1118	放晴\n\n【よみ】\n はれます\n\n【意味】\n clear (up)	1	1
532	1466	一半\n\n【よみ】\n はん\n\n【意味】\n half	0	1
533	1391	～號\n\n【よみ】\n ～ばん\n\n【意味】\n number～	1	1
534	867	麵包\n\n【よみ】\n ぱん\n\n【意味】\n bread	0	1
535	746	手帕\n\n【よみ】\n はんかち\n\n【意味】\n handkerchief	0	1
536	1189	號碼\n\n【よみ】\n ばんごう\n\n【意味】\n number	0	1
537	1779	晚餐\n晚飯\n\n【よみ】\n ばんごはん\n\n【意味】\n dinner\n supper	1	1
538	1780	一半\n\n【よみ】\n はんぶん\n\n【意味】\n half	0	1
539	1781	東\n東邊\n\n【よみ】\n ひがし\n\n【意味】\n east	0	1
540	1782	～隻\n\n【よみ】\n ～ひき\n\n【意味】\n ※ a term for counting animals, fishes, etc.	1	1
541	1783	彈(樂器)\n\n【よみ】\n ひきます\n\n【意味】\n play\n ※ used for stringed instruments or piano, etc.	1	1
542	1784	低\n低的\n\n【よみ】\n ひくい\n\n【意味】\n low	0	1
544	678	左\n左邊\n\n【よみ】\n ひだり\n\n【意味】\n left	0	1
545	699	人\n\n【よみ】\n ひと\n\n【意味】\n person\n people	0	1
546	1785	一個\n\n【よみ】\n ひとつ\n\n【意味】\n one	0	1
548	1007	一個人\n\n【よみ】\n ひとり\n\n【意味】\n one person	1	1
549	1787	閒\n空閒\n\n【よみ】　\n ひま\n\n【意味】\n free (time)	0	1
550	1788	百貨公司\n\n【よみ】\n ひゃく\n\n【意味】\n hundred	0	1
551	579	醫院\n\n【よみ】\n びょういん\n\n【意味】\n hospital	0	1
552	1003	病\n\n【よみ】\n びょうき\n\n【意味】\n illness\n sickness\n disease	0	1
553	1789	平假名\n\n【よみ】\n ひらがな\n\n【意味】\n Hiragana script	1	1
554	1790	白天\n中午\n\n【よみ】\n ひる\n\n【意味】\n daytime\n noon	0	1
555	1791	午餐\n午飯\n\n【よみ】\n ひるごはん\n\n【意味】\n lunch	1	1
556	807	廣\n廣的\n\n【よみ】\n ひろい\n\n【意味】\n wide\n large\n spacious	0	1
557	1792	底片\n軟片\n\n【よみ】\n ふぃるむ\n\n【意味】\n film	0	1
558	1793	信封\n\n【よみ】\n ふうとう\n\n【意味】\n envelope	0	1
559	688	游泳池\n\n【よみ】\n ぷーる\n\n【意味】\n swimming pool	0	1
560	1794	叉子\n\n【よみ】\n ふぉーく\n\n【意味】\n fork	0	1
561	812	衣服\n\n【よみ】\n ふく\n\n【意味】\n clothes	0	1
562	1796	兩個\n\n【よみ】\n ふたつ\n\n【意味】\n two	0	1
563	1797	豬肉\n\n【よみ】\n ぶたにく\n\n【意味】\n pork	1	1
564	1798	兩個人\n\n【よみ】\n ふたり\n\n【意味】\n two person	1	1
565	1799	二日\n兩天\n\n【よみ】\n ふつか\n\n【意味】\n second\n two days	0	1
566	1800	胖\n胖的\n\n【よみ】\n ふとい\n\n【意味】\n fat\n thick	0	1
567	1801	冬天\n\n【よみ】\n ふゆ\n\n【意味】\n winter	0	1
568	774	下(雨、雪)\n\n【よみ】\n ふります\n\n【意味】\n rain\n snow	1	1
569	713	舊\n舊的\n\n【よみ】　\n ふるい\n\n【意味】\n old\n ※ used when referring to things	0	1
570	1052	よみ ： ふろ	0	1
571	753	～分鐘\n\n【よみ】\n ～ふん\n\n【意味】\n ～minute(s)	1	1
572	1802	よみ ： ぶんしょう	0	1
573	859	～頁\n\n【よみ】\n ～ぺーじ\n\n【意味】\n ～page(s)	1	1
574	1803	不擅長\n笨拙\n\n【よみ】\n へた\n\n【意味】\n poor at\n unskilled\n awkward	0	1
575	878	床\n\n【よみ】\n べっど\n\n【意味】\n bed	0	1
576	1804	寵物\n\n【よみ】\n ぺっと\n\n【意味】\n pet	0	1
577	661	房間\n\n【よみ】\n へや\n\n【意味】\n room	0	1
578	1208	～邊\n※僅用於この(這邊)、あの(那邊)\n\n【よみ】\n ～へん\n\n【意味】\n area\n ※ always used with "この", "あの", etc.	1	1
579	656	筆\n\n【よみ】\n ぺん\n\n【意味】\n pen	0	1
580	1805	唸書\n學習(動詞)\n\n【よみ】\n べんきょうします\n\n【意味】\n study	1	1
581	759	唸書\n學習(名詞)\n\n【よみ】\n べんきょう\n\n【意味】\n study	0	1
582	916	よみ ： べんとう	0	1
583	834	方便\n便利\n\n【よみ】\n べんり\n\n【意味】\n convenient	0	1
584	1806	比較\n※例如サッカーより野球のほうが好きです。\n跟足球比起來我比較喜歡棒球。\n\n【よみ】\n ほう\n\n【意味】\n ～er than\n ※ e.g., サッカーより 野球の ほうが 好きです。\n I like baseball better than soccer.	1	1
585	1807	帽子\n\n【よみ】\n ぼうし\n\n【意味】\n hat\n cap	0	1
586	740	原子筆\n\n【よみ】\n ぼーるぺん\n\n【意味】\n ballpoint pen	0	1
588	1808	口袋\n\n【よみ】\n ぽけっと\n\n【意味】\n pocket	0	1
589	682	郵筒\n信箱\n\n【よみ】\n ぽすと\n\n【意味】\n mailbox\n postbox	0	1
590	1809	想要\n\n【よみ】\n ほしい\n\n【意味】\n want (something)	0	1
591	1810	細\n細的\n\n【よみ】\n ほそい\n\n【意味】\n slender\n fine\n thin	0	1
592	356	鈕扣\n\n【よみ】\n ぼたん\n\n【意味】\n button	0	1
593	598	旅館\n飯店\n\n【よみ】\n ほてる\n\n【意味】\n hotel	0	1
594	33	書\n\n【よみ】\n ほん\n\n【意味】\n book	0	1
595	1811	書架\n\n【よみ】\n ほんだな\n\n【意味】\n bookshelf	0	1
596	18	真的\n\n【よみ】\n ほんとう\n\n【意味】\n real\n really	0	1
598	842	每天早上\n\n【よみ】\n まいあさ\n\n【意味】\n every morning	0	1
599	1812	每個星期\n\n【よみ】\n まいしゅう\n\n【意味】\n every week	0	1
600	1813	每個月\n\n【よみ】\n まいつき／まいげつ\n\n【意味】\n every month	0	1
601	1814	每年\n\n【よみ】\n まいとし／まいねん\n\n【意味】\n every year	0	1
602	344	每天早上\n\n【よみ】\n まいにち\n\n【意味】\n every day	0	1
603	1815	每晚\n\n【よみ】\n まいばん\n\n【意味】\n every night	0	1
604	672	前面\n\n【よみ】\n まえ\n\n【意味】\n front	0	1
605	846	轉彎\n\n【よみ】\n まがります\n\n【意味】\n turn\n curve	1	1
606	1816	難吃\n\n【よみ】\n まずい\n\n【意味】\n bad\n ※ used when referring to taste	0	1
607	1489	再\n再度\n\n【よみ】\n また\n\n【意味】\n again	0	1
608	777	還沒\n尚未\n\n【よみ】\n まだ\n\n【意味】\n not ～ yet	0	1
609	819	小鎮\n\n【よみ】\n まち\n\n【意味】\n town\n city	0	1
610	1037	等\n等待\n\n【よみ】\n まちます\n\n【意味】\n wait	1	1
611	1817	一直\n直直的\n\n【よみ】\n まっすぐ\n\n【意味】\n straight	0	1
612	1818	火柴\n\n【よみ】\n まっち\n\n【意味】\n match	0	1
613	840	窗戶\n\n【よみ】\n まど\n\n【意味】\n window	0	1
614	1819	圓\n圓的\n\n【よみ】\n まるい\n\n【意味】\n round\n circular	1	1
615	1013	萬\n\n【よみ】\n まん\n\n【意味】\n ten thousand	0	1
616	1820	よみ ： まんねんひつ	0	1
617	1821	刷\n磨\n\n【よみ】\n みがきます\n\n【意味】\n brush\n polish	1	1
618	677	右\n\n【よみ】\n みぎ\n\n【意味】\n right	0	1
619	1822	短\n短的\n\n【よみ】\n みじかい\n\n【意味】\n short	1	1
620	1823	水\n\n【よみ】\n みず\n\n【意味】\n water	0	1
621	411	店\n\n【よみ】\n みせ\n\n【意味】\n store\n shop	0	1
622	795	出示\n讓對方看\n\n【よみ】\n みせます\n\n【意味】\n show	1	1
623	820	道路\n\n【よみ】\n みち\n\n【意味】\n road\n way	0	1
624	1824	三日\n三天\n\n【よみ】\n みっか\n\n【意味】\n third\n three days	0	1
625	1825	三個\n\n【よみ】\n みっつ\n\n【意味】\n three	0	1
626	1826	綠色\n\n【よみ】\n みどり\n\n【意味】\n green	0	1
627	512	大家\n各位\n\n【よみ】\n みなさん\n\n【意味】\n everyone\n ※ the more polite equivalent of "みんな"	0	1
628	981	南\n南方\n\n【よみ】\n みなみ\n\n【意味】\n south	0	1
629	1827	耳朵\n\n【よみ】\n みみ\n\n【意味】\n ear	0	1
630	784	看\n\n【よみ】\n みます\n\n【意味】\n see\n look\n watch	1	1
631	1088	大家\n各位(比較口語的說法)\n\n【よみ】\n みんな\n\n【意味】\n everyone	0	1
632	1828	六日\n六天\n\n【よみ】\n むいか\n\n【意味】\n sixth\n six days	0	1
633	1829	對面\n\n【よみ】\n むこう\n\n【意味】\n over there\n beyond	0	1
634	892	難\n困難\n\n【よみ】\n むずかしい\n\n【意味】\n difficult	0	1
635	1830	六個\n\n【よみ】\n むっつ\n\n【意味】\n six	0	1
636	1831	村子\n\n【よみ】\n むら\n\n【意味】\n village	0	1
637	1832	眼睛\n\n【よみ】\n め\n\n【意味】\n eye	0	1
638	1109	～公尺\n\n【よみ】\n ～めーとる\n\n【意味】\n ～meter	1	1
639	1833	眼鏡\n\n【よみ】\n めがね\n\n【意味】\n glasses	0	1
640	15	已經\n\n【よみ】\n もう\n\n【意味】\n already	1	1
641	1834	星期四\n\n【よみ】\n もくようび\n\n【意味】\n Thursday	0	1
642	370	喂(接電話時)\n\n【よみ】\n もしもし\n\n【意味】\n hello.\n ※ used when calling on the phone	0	1
643	1076	拿\n帶\n\n【よみ】\n もちます\n\n【意味】\n have\n hold\n carry	1	1
644	1835	更\n\n【よみ】\n もっと\n\n【意味】\n more	0	1
645	1836	東西\n\n【よみ】\n もの\n\n【意味】\n thing	0	1
646	772	門\n\n【よみ】\n もん\n\n【意味】\n gate	0	1
647	858	問題\n\n【よみ】\n もんだい\n\n【意味】\n question\n problem	0	1
648	1837	～店\n\n【よみ】\n ～や\n\n【意味】\n ～ store	1	1
649	1838	蔬菜店\n\n【よみ】\n やおや\n\n【意味】\n fruit and vegetable store	0	1
650	1839	蔬菜店\n\n【よみ】\n やさい\n\n【意味】\n vegetable	0	1
651	1840	簡單\n簡單的\n\n【よみ】\n やさしい\n\n【意味】\n easy	0	1
652	410	便宜\n便宜的\n\n【よみ】\n やすい\n\n【意味】\n low-priced\n cheap\n inexpensive	0	1
653	635	休息\n休假(名詞)\n\n【よみ】\n やすみ\n\n【意味】\n rest\n holiday\n absence	0	1
654	767	休息\n休假(動詞)\n\n【よみ】\n やすみます\n\n【意味】\n take a holiday\n be absent from\n be closed	1	1
655	1841	八個\n\n【よみ】\n やっつ\n\n【意味】\n eight	0	1
656	922	山\n\n【よみ】\n やま\n\n【意味】\n mountain	0	1
657	1018	做\n\n【よみ】\n やります\n\n【意味】\n do	1	1
658	1842	傍晚\n\n【よみ】\n ゆうがた\n\n【意味】\n evening	0	1
659	1266	晚餐\n晚飯\n\n【よみ】\n ゆうはん\n\n【意味】\n dinner\n supper	0	1
660	1843	郵局\n\n【よみ】\n ゆうびんきょく\n\n【意味】\n post office	0	1
661	1844	昨晚\n\n【よみ】\n ゆうべ\n\n【意味】\n last night\n yesterday evening	1	1
662	1845	有名\n\n【よみ】\n ゆうめい\n\n【意味】\n famous	0	1
663	1846	雪\n\n【よみ】\n ゆき\n\n【意味】\n snow	0	1
664	1847	慢慢地\n\n【よみ】\n ゆっくり\n\n【意味】\n slowly\n leisurely	0	1
665	1848	八日\n八天\n\n【よみ】\n ようか\n\n【意味】\n eighth\n eight days	0	1
666	1849	衣服\n\n【よみ】\n ようふく\n\n【意味】\n clothes	0	1
668	53	橫\n\n【よみ】\n よこ\n\n【意味】\n horizontal line\n \n next \n next door	0	1
669	1850	四日\n四天\n\n【よみ】\n よっか\n\n【意味】\n fourth\n four days	0	1
670	559	四個\n\n【よみ】\n よっつ\n\n【意味】\n four	0	1
671	1851	叫\n\n【よみ】\n よびます\n\n【意味】\n call	1	1
672	836	讀\n\n【よみ】\n よみます\n\n【意味】\n read	1	1
673	1203	晚上\n夜晚\n\n【よみ】\n よる\n\n【意味】\n night\n evening	0	1
674	1852	弱\n弱的\n\n【よみ】\n よわい\n\n【意味】\n weak	0	1
675	1162	下個月\n\n【よみ】\n らいげつ\n\n【意味】\n next month	0	1
676	269	下個星期\n\n【よみ】\n らいしゅう\n\n【意味】\n next week	0	1
677	454	明年\n\n【よみ】\n らいねん\n\n【意味】\n next year	0	1
678	1853	收音機\n\n【よみ】\n らじお\n\n【意味】\n radio	0	1
679	1854	卡式錄放音機\n\n【よみ】\n らじかせ\n\n【意味】\n radio cassette player / recorder	0	1
680	1531	優秀\n\n【よみ】\n りっぱ\n\n【意味】\n fine\n stately	1	1
681	881	留學生\n\n【よみ】\n りゅうがくせい\n\n【意味】\n foreign student	0	1
682	1855	父母\n\n【よみ】\n りょうしん\n\n【意味】\n parents	0	1
683	339	菜餚\n\n【よみ】\n りょうり\n\n【意味】\n dish\n food\n cooking	0	1
684	200	旅行(名詞)\n\n【よみ】\n りょこう\n\n【意味】\n travel	0	1
685	1856	旅行(動詞)\n\n【よみ】\n りょこうします\n\n【意味】\n travel	1	1
687	1858	冰箱\n\n【よみ】\n れいぞうこ\n\n【意味】\n refrigerator	0	1
688	1859	よみ ： れこーど	0	1
689	1401	餐廳\n\n【よみ】\n れすとらん\n\n【意味】\n restaurant	0	1
690	552	練習(名詞)\n\n【よみ】\n れんしゅう\n\n【意味】\n practice	0	1
691	1860	練習(動詞)\n\n【よみ】\n れんしゅうします\n\n【意味】\n practice	1	1
692	1861	走廊\n\n【よみ】\n ろうか\n\n【意味】\n corridor	0	1
693	1862	六日\n六天\n\n【よみ】\n ろく\n\n【意味】\n six	0	1
694	1863	よみ ： わいしゃつ	0	1
695	886	年輕\n\n【よみ】\n わかい\n\n【意味】\n young\n	0	1
696	1422	知道\n明白\n\n【よみ】\n わかります\n\n【意味】\n understand	1	1
697	1381	忘記\n\n【よみ】\n わすれます\n\n【意味】\n forget	1	1
698	13	我\n\n【よみ】\n わたくし\n\n【意味】\n I\n ※ the more polite equivalent of "わたし"	0	1
700	1242	交(給對方)\n\n【よみ】\n わたします\n\n【意味】\n hand	1	1
701	1067	過(馬路、橋等等)\n\n【よみ】\n わたります\n\n【意味】\n across	1	1
702	557	不好\n不好的\n\n【よみ】\n わるい\n\n【意味】\n bad	0	1
704	693	～樓\n\n【よみ】\n ～かい\n\n【意味】\n ～th floor	1	1
705	1271	穿\n\n【よみ】\n きます\n\n【意味】\n put on (a shirt, etc.)	1	1
706	1357	熱\n熱的\n\n【よみ】\n あつい\n\n【意味】\n hot	1	1
707	1324	暗\n暗的\n\n【よみ】\n くらい\n\n【意味】\n dark	1	1
708	1317	夜晚\n\n【よみ】\n ばん\n\n【意味】\n night\n evening	1	1
709	1866	～人\n\n【よみ】\n ～じん\n\n【意味】\n ※ used for suffix putting after one's native country to show own nationality	1	1
710	388	雨\n\n【よみ】\n あめ\n\n【意味】\n rain	1	1
711	1596	風\n\n【よみ】\n かぜ\n\n【意味】\n wind	1	1
712	182	熱\n熱的\n\n【よみ】\n あつい\n\n【意味】\n hot	1	1
713	1795	吹\n\n【よみ】\n ふきます\n\n【意味】\n blow	1	1
714	172	我\n\n【よみ】\n わたし\n\n【意味】\n I	1	1
715	610	海外\n\n【よみ】\n かいがい\n\n【意味】\n foreign countries	1	1
716	1777	快\n快的\n\n【よみ】\n はやい\n\n【意味】\n fast	1	1
717	1767	橋\n\n【よみ】\n はし\n\n【意味】\n bridge	1	1
718	1865	散步(動詞)\n\n【よみ】\n さんぽします\n\n【意味】\n take a walk	1	1
719	1867	房地產業者\n\n【よみ】\n ふどうさんや\n\n【意味】\n real estate bussiness	1	1
720	1868	盤子\n\n【よみ】\n おさら\n\n【意味】\n dish\n plate	1	1
721	1869	酒\n\n【よみ】\n おさけ\n\n【意味】\n alcoholic drinks	1	1
722	1870	美容院\n\n【よみ】\n びよういん\n\n【意味】\n beauty parlor	1	1
723	1871	請給我\n\n【よみ】\n ください\n\n【意味】\n Give me ～, please.	1	1
724	629	春天\n\n【よみ】\n はる\n\n【意味】\n spring	1	1
725	1775	花\n\n【よみ】\n はな\n\n【意味】\n flower\n blossom	1	1
726	1872	其他\n\n【よみ】\n ほか\n\n【意味】\n other	1	1
727	1547	よみ ： ある	1	1
728	11	有\n\n【よみ】\n あります\n\n【意味】\n be\n exist\n ※ used when referring to inanimate things	1	1
729	1873	貴\n貴的\n\n【よみ】\n たかい\n\n【意味】\n expensive\n high	1	1
730	1874	非常\n\n【よみ】\n たいへん\n\n【意味】\n very	1	1
731	1121	大概\n也許\n\n【よみ】\n たぶん\n\n【意味】\n probably\n perhaps\n maybe	1	1
732	115	常常\n\n【よみ】\n よく\n\n【意味】\n often	1	1
733	1875	～得好\n\n【よみ】\n よく\n\n【意味】\n well\n much	1	1
734	1667	三\n\n【よみ】\n さん\n\n【意味】\n three	1	1
735	1876	四\n\n【よみ】\n よん ／ し \n\n【意味】\n four	1	1
736	1645	五\n\n【よみ】\n ご\n\n【意味】\n five	1	1
737	1877	七\n\n【よみ】\n なな／しち\n\n【意味】\n seven	1	1
738	1878	九\n\n【よみ】\n く ／ きゅう\n\n【意味】\n nine	1	1
739	659	再～\n更～\n\n【よみ】\n もう\n\n【意味】\n more ～\n another ～	1	1
740	1	不好意思…\n請問一下…\n\n【よみ】\n あの\n\n【意味】\n well\n ※ used to show one's hesitation	1	1
741	28	是\n\n【よみ】\n はい\n\n【意味】\n yes	1	1
742	1879	公里\n\n【よみ】\n ～きろ／きろめーとる\n\n【意味】\n kilometer	1	1
743	1880	よみ ： ～にん	1	1
744	1881	～隻(鉛筆)\n～顆(樹)\n～根(香菸)\n\n【よみ】\n ～ほん\n\n【意味】\n ※ a term for counting pencils, trees, cigarettes, etc.	1	1
745	1882	～之前\n～以前\n\n【よみ】\n ～まえ\n\n【意味】\n before ～	1	1
746	1883	～小時\n\n【よみ】\n ～じかん\n\n【意味】\n ～hour(s)	1	1
747	1020	～時\n\n【よみ】\n ～とき\n\n【意味】\n at the time of ～	1	1
748	1884	～點\n\n【よみ】\n ～じ\n\n【意味】\n ～o'clock	1	1
750	852	關\n關閉\n\n【よみ】\n しめます\n\n【意味】\n close\n shut	1	1
751	1342	よみ ： ひく	1	1
752	1450	拿\n\n【よみ】\n とります\n\n【意味】\n take\n pass	1	1
753	1886	打(電話)\n\n【よみ】\n かけます\n\n【意味】\n make (a telephone call)	1	1
754	1558	有\n\n【よみ】\n います\n\n【意味】\n exist\n be\n ※used when referring to animate things	1	1
755	1864	飯盒\n便當\n\n【よみ】\n おべんとう\n\n【意味】\n box lunch	1	1
756	1887	句子\n\n【よみ】\n ぶん\n\n【意味】\n sentence	1	1
757	576	發燒\n\n【よみ】\n ねつ\n\n【意味】\n fever	1	1
758	1888	喉嚨\n\n【よみ】\n のど\n\n【意味】\n throat	1	1
759	762	鋼琴\n\n【よみ】\n ぴあの\n\n【意味】\n piano	1	1
760	1889	做\n\n【よみ】\n します\n\n【意味】\n do	1	1
761	1890	染上(感冒)\n\n【よみ】\n ひきます\n\n【意味】\n catch (a cold)	1	1
762	1891	美容師\n\n【よみ】\n びようし\n\n【意味】\n beautician	1	1
763	1892	洗髮精\n\n【よみ】\n しゃんぷー\n\n【意味】\n shampoo	1	1
764	814	頭髮\n\n【よみ】\n かみ\n\n【意味】\n hair	1	1
765	1893	站務人員\n\n【よみ】\n えきいん\n\n【意味】\n station staff	1	1
766	1399	答案\n\n【よみ】\n こたえ\n\n【意味】\n answer	1	1
767	1894	電話號碼\n\n【よみ】\n でんわばんごう\n\n【意味】\n telephone number	1	1
768	1439	聯絡(名詞)\n\n【よみ】\n れんらく\n\n【意味】\n contact	1	1
769	1895	聯絡(動詞)\n\n【よみ】\n れんらくします\n\n【意味】\n contact	1	1
770	1896	找到\n\n【よみ】\n みつかります\n\n【意味】\n be found	1	1
771	1897	聽\n\n【よみ】\n 聞きます\n\n【意味】\n hear\n listen	1	1
772	1898	房租\n\n【よみ】\n やちん\n\n【意味】\n rent	1	1
773	1899	找\n尋找\n\n【よみ】\n さがします\n\n【意味】\n look for	1	1
774	1123	店員\n\n【よみ】\n てんいん\n\n【意味】\n store clerk\n shop assistant	1	1
775	1900	套餐\n\n【よみ】\n ていしょく\n\n【意味】\n set meal	1	1
776	1901	牛奶\n\n【よみ】\n みるく\n\n【意味】\n milk	1	1
777	870	足球\n\n【よみ】\n さっかー\n\n【意味】\n soccer\n football	1	1
778	924	棒球\n\n【よみ】\n やきゅう\n\n【意味】\n baseball	1	1
779	796	網球\n\n【よみ】\n てにす\n\n【意味】\n tennis	1	1
780	1902	賣場\n\n【よみ】\n うりば\n\n【意味】\n counter (in a shop, department store, etc.)	1	1
781	1485	卡片\n\n【よみ】\n かーど\n\n【意味】\n credit card	1	1
782	1903	郵局職員\n\n【よみ】\n ゆうびんきょくいん\n\n【意味】\n post office clerk	1	1
783	1904	航空郵件\n\n【よみ】\n こうくうびん\n\n【意味】\n airmail	1	1
784	1905	海運郵件\n\n【よみ】\n ふなびん\n\n【意味】\n sea mail	1	1
785	1906	寄送\n\n【よみ】\n おくります\n\n【意味】\n send	1	1
786	1907	西裝\n\n【よみ】\n すーつ\n\n【意味】\n suit	1	1
787	1908	上班族\n\n【よみ】\n かいしゃいん\n\n【意味】\n company employee\n office worker	1	1
788	875	超級市場\n\n【よみ】\n すーぱー\n\n【意味】\n supermarket	1	1
789	1909	筷子\n\n【よみ】\n おはし\n\n【意味】\n chopsticks	1	1
790	925	比賽\n\n【よみ】\n しあい\n\n【意味】\n game\n match	1	1
791	1620	髒\n髒的\n\n【よみ】\n きたない\n\n【意味】\n dirty	1	1
792	1910	銀行員\n\n【よみ】\n ぎんこういん\n\n【意味】\n bank employee\n bank clerk	1	1
793	1911	櫃台\n\n【よみ】\n まどぐち\n\n【意味】\n window	1	1
794	1912	匯款\n\n【よみ】\n 振り込み\n\n【意味】\n payment	1	1
795	363	表格\n\n【よみ】\n ようし\n\n【意味】\n form	1	1
796	600	地址\n住址\n\n【よみ】\n じゅうしょ\n\n【意味】\n address	1	1
797	926	颱風\n\n【よみ】\n たいふう\n\n【意味】\n typhoon	1	1
798	1913	慢\n\n\n【よみ】\n おそい\n\n【意味】\n late	1	1
799	1914	完成\n落成\n\n【よみ】\n できます\n\n【意味】\n be built\n be constructed	1	1
800	1915	打(結、領帶等等)\n\n【よみ】\n します\n\n【意味】\n put on (a tie)	1	1
801	1916	休息\n\n【よみ】\n やすみます\n\n【意味】\n take a rest	1	1
802	1917	請～\n\n【よみ】\n ください\n\n【意味】\n Please ～.	1	1
803	1918	醃漬\n浸泡\n\n【よみ】\n つけます\n\n【意味】\n pickle\n soak	1	1
804	1919	短\n短的\n\n【よみ】\n みじかい\n\n【意味】\n short	1	1
805	1920	長\n長的\n\n【よみ】\n ながい\n\n【意味】\n long	1	1
806	273	機場\n\n【よみ】\n くうこう\n\n【意味】\n airport	1	1
807	1411	護照\n\n【よみ】\n ぱすぽーと\n\n【意味】\n passport	1	1
808	1921	導遊\n\n【よみ】\n がいど\n\n【意味】\n guide	1	1
809	1922	住宿\n過夜\n\n【よみ】\n とまります\n\n【意味】\n stay	1	1
810	1923	土產\n禮物\n\n【よみ】\n おみやげ\n\n【意味】\n souvenir	1	1
811	71	日語\n\n【よみ】\n にほんご\n\n【意味】\n Japanese	1	1
812	974	字\n\n【よみ】\n じ\n\n【意味】\n character\n letter	1	1
813	1924	～人\n\n【よみ】\n ～にん\n\n【意味】\n ※ a term for counting person	1	1
814	1925	丈夫\n先生\n\n【よみ】\n ごしゅじん\n\n【意味】\n (someone else's) hasband	1	1
815	1926	妹妹\n\n【よみ】\n いもうとさん\n\n【意味】\n (someone else's) younger sister	1	1
816	1927	弟弟\n\n【よみ】\n おとうと\n\n【意味】\n (someone else's) younger brother	1	1
817	1928	打開\n\n【よみ】\n いれます\n\n【意味】\n turn on	1	1
818	1929	關掉\n\n【よみ】\n きります\n\n【意味】\n turn off\n switch off	1	1
819	1930	來\n\n【よみ】\n きます\n\n【意味】\n come	1	1
820	1931	家鄉\n故鄉\n\n【よみ】\n くに\n\n【意味】\n (one's) home country	1	1
821	1932	等一下\n待會\n\n【よみ】\n あとで\n\n【意味】\n later	1	1
822	1933	什麼\n\n【よみ】\n なに／なん\n\n【意味】\n what	1	1
823	702	電腦\n\n【よみ】\n こんぴゅーたー\n\n【意味】\n computer	1	1
824	1934	停止\n放棄\n\n【よみ】\n やめます\n\n【意味】\n quit\n stop\n give up	1	1
825	1935	接受\n得到\n\n【よみ】\n もらいます\n\n【意味】\n receive\n be given	1	1
826	1936	擔心\n\n【よみ】\n しんぱいします\n\n【意味】\n worry\n be anxious about	1	1
827	1937	行動電話\n\n【よみ】\n けいたいでんわ\n\n【意味】\n cellular phone	1	1
828	781	可樂\n\n【よみ】\n コーラ\n\n【意味】\n cola	1	1
829	738	蛋糕\n\n【よみ】\n ケーキ\n\n【意味】\n cake	1	1
830	791	牆壁\n\n【よみ】\n かべ\n\n【意味】\n wall	1	1
831	978	卡拉OK\n\n【よみ】\n からおけ\n\n【意味】\n karaoke	1	1
832	905	演唱會\n\n【よみ】\n こんさーと\n\n【意味】\n concert	1	1
833	1938	給\n給予\n\n【よみ】\n あげます\n\n【意味】\n give\n　	1	1
834	1053	開關\n\n【よみ】\n すいっち\n\n【意味】\n switch	1	1
835	1939	各種\n各式各樣\n\n【よみ】\n いろいろ\n\n【意味】\n various	1	1
836	1940	叫\n\n【よみ】\n よびます\n\n【意味】\n call	1	1
837	1941	繼續\n\n【よみ】\n つづきます\n\n【意味】\n continue\n last	1	1
838	1942	確認\n\n【よみ】\n かくにんします\n\n【意味】\n confirm\n make sure	1	1
839	1943	想\n認為\n\n【よみ】\n おもいます\n\n【意味】\n think	1	1
840	1944	反對\n\n【よみ】\n はんたい\n\n【意味】\n opposite\n reverse	1	1
841	1048	不行\n不可以\n\n【よみ】\n だめ\n\n【意味】\n no\n not good	1	1
842	1945	聲音\n\n【よみ】\n おと\n\n【意味】\n sound	1	1
843	1946	團體\n\n【よみ】\n ぐるーぷ\n\n【意味】\n group	1	1
844	1624	九\n\n【よみ】\n きゅう / く\n\n【意味】\n nine	1	1
397	1679	整～(天、年等等)\n\n【よみ】\n ～ちゅう\n\n【意味】\n in the midst of ～	1	1
543	898	飛機\n\n【よみ】\n ひこうき\n\n【意味】\n airplane	0	1
54	1553	一日(每個月的第一天)\n\n【よみ】\n いちにち\n\n【意味】\n a [one] day	0	1
246	1652	杯子\n\n【よみ】\n こっぷ\n\n【意味】\n glass	0	1
597	747	～張\n\n【よみ】\n ～まい\n\n【意味】\n ※ a term for counting paper, photographs, clothes, etc. 	1	1
749	222	正在～\n\n【よみ】\n ～じゅう\n\n【意味】\n all (time) long\n\n all over ～	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
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
104	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
105	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
106	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
107	94270	3.1912999	3.19	相	関係	量	速度	遅い	遅い	おそい
108	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
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
161	12060	1.181	1.18	体	関係	形	角など	角（かど）	角	かど
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
533	8901	1.1635	1.16	体	関係	時間	朝晩	晩	晩	ばん
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
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
13	205	2751	1	薬	\N	くすり	\N
16	291	2753	1	死にました	\N	しにました	\N
17	505	2754	1	歯	\N	は	1
24	404	2757	1	着きます	\N	つきます	\N
25	404	2758	2	着きます	\N	つきます	\N
26	558	2759	1	封筒	\N	ふうとう	\N
47	660	2756	1	郵便局	\N	ゆうびんきょく	\N
183	49	1460	1	医者	\N	いしゃ	\N
242	634	1544	1	難しい	\N	むずかしい	\N
432	423	1530	1	デパート	\N	でぱーと	\N
473	30	1535	1	アパート	\N	あぱーと	\N
484	570	1745	1	ふろ	\N	\N	\N
695	108	2213	1	お茶	\N	おちゃ	\N
696	108	2247	2	お茶	\N	おちゃ	\N
716	268	528	1	酒	\N	\N	\N
758	518	1668	1	バス	\N	ばす	\N
899	346	1810	1	掃除	\N	そうじ	\N
972	209	1542	1	靴下	\N	くつした	\N
991	582	2097	1	弁当	\N	\N	\N
992	582	1728	2	弁当	\N	\N	\N
993	582	1556	3	弁当	\N	\N	\N
1099	27	2158	1	兄	\N	あに	\N
1105	111	2093	1	弟	\N	おとうと	\N
1106	111	2030	2	弟	\N	おとうと	\N
1107	111	1547	3	弟	\N	おとうと	\N
1128	219	1534	1	黒い	\N	くろい	\N
1245	405	1533	1	机	\N	つくえ	\N
1460	329	1721	1	し	\N	\N	\N
1461	329	1530	2	し	\N	\N	\N
1462	329	1398	3	し	\N	\N	\N
1463	329	1810	4	しよ	\N	\N	\N
1464	329	1799	5	し	\N	\N	\N
1467	492	1636	1	庭	\N	にわ	\N
1468	492	1935	2	庭	\N	にわ	\N
1480	556	1426	1	広くありません	\N	ひろくありません	\N
1481	336	1454	1	狭い	\N	せまい	\N
1508	490	2100	1	荷物	\N	にもつ	\N
1509	490	1794	2	荷物	\N	にもつ	\N
1514	589	1251	1	ポスト	\N	ぽすと	\N
1515	589	1531	2	ポスト	\N	ぽすと	\N
1571	502	2120	1	飲み物	\N	のみもの	\N
2073	743	2216	1	～人	\N	\N	\N
2074	743	2231	2	～人	\N	\N	\N
2075	743	2224	3	～人	\N	\N	\N
2096	747	2189	1	とき	\N	とき	\N
2097	747	2187	2	とき	\N	とき	\N
2098	747	2180	3	とき	\N	とき	\N
2100	747	2178	5	とき	\N	とき	\N
2137	751	2244	1	引い	\N	ひい	\N
2150	643	2179	1	持って	\N	もって	\N
2152	643	2249	3	持って	\N	もって	\N
2154	643	1794	5	持ちましょう	\N	もちましょう	\N
2172	216	2232	1	来	\N	\N	\N
2173	216	1638	2	来	\N	\N	\N
2174	216	2178	3	来	\N	\N	\N
2175	216	2220	4	来	\N	\N	\N
2176	216	1562	5	来	\N	\N	\N
2232	552	1671	1	病気	\N	びょうき	\N
2233	552	2019	2	病気	\N	びょうき	\N
2242	20	2763	1	頭	\N	あたま	\N
2243	20	2755	2	頭	\N	あたま	\N
2257	758	1449	1	のど	\N	のど	\N
2258	52	2766	1	痛い	\N	いたい	\N
2259	52	1450	2	痛い	\N	いたい	\N
2260	52	1451	3	痛くない	\N	いたくない	\N
2267	426	1341	1	テレビ	\N	てれび	\N
2268	426	2192	2	テレビ	\N	てれび	\N
2269	426	1630	3	テレビ	\N	てれび	\N
2270	50	2767	1	いす	\N	いす	\N
2273	687	2769	1	冷蔵庫	\N	れいぞうこ	\N
2275	678	2771	1	ラジオ	\N	らじお	\N
2276	679	2772	1	ラジカセ	\N	らじかせ	\N
2277	415	2773	1	テープレコーダー	\N	\N	\N
2282	375	1431	1	建物	\N	たてもの	\N
2283	375	2495	2	建物	\N	たてもの	\N
2284	719	2775	1	不動産屋	\N	ふどうさんや	\N
2286	227	2777	2	玄関	\N	げんかん	\N
2287	227	2776	1	玄関	\N	げんかん	\N
2288	365	2778	1	台所	\N	だいどころ	\N
2291	123	2779	1	おふろ	\N	おふろ	\N
2292	123	1745	2	おふろ	\N	おふろ	\N
2301	569	2780	1	古い	\N	ふるい	\N
2302	569	1281	2	古い	\N	ふるい	\N
2303	441	2781	1	遠い	\N	とおい	\N
2306	389	2782	1	近い	\N	ちかい	\N
2307	389	2055	2	近い	\N	ちかい	\N
2314	561	2783	1	服	\N	ふく	\N
2315	561	1435	2	服	\N	ふく	\N
2316	561	2130	3	服	\N	ふく	\N
2317	585	2784	1	帽子	\N	ぼうし	\N
2320	208	2785	1	靴	\N	くつ	\N
2321	208	1286	2	靴	\N	くつ	\N
2322	151	2786	1	傘	\N	かさ	\N
2323	263	2787	1	財布	\N	さいふ	\N
2327	162	1418	1	かばん	\N	かばん	\N
2328	162	1245	2	かばん	\N	かばん	\N
2329	162	1302	3	かばん	\N	かばん	\N
2330	639	2788	1	眼鏡	\N	めがね	\N
2337	140	2789	1	買いました	\N	かいました	\N
2338	140	1477	2	買った	\N	かった	\N
2339	140	1640	3	買いに	\N	かいに	\N
2343	704	2790	1	階	\N	かい	\N
2344	704	2495	2	階	\N	がい	\N
2345	704	2497	3	階	\N	がい	\N
2346	417	1482	1	手紙	\N	てがみ	\N
2347	417	1378	2	手紙	\N	てがみ	\N
2349	510	2791	1	はがき	\N	はがき	\N
2350	188	1322	1	切手	\N	きって	\N
2351	529	2792	1	はります	\N	はります	\N
2352	371	1378	1	出します	\N	だします	\N
2353	371	1654	2	出しました	\N	だしました	\N
2354	371	1971	3	出して	\N	だして	\N
2362	597	2793	1	枚	\N	まい	\N
2363	597	2794	2	枚	\N	まい	\N
2364	597	1326	3	枚	\N	まい	\N
2371	152	1379	1	貸します	\N	かします	\N
2372	152	2092	2	貸して	\N	かして	\N
2373	152	2090	3	貸して	\N	かして	\N
2383	141	2797	1	返します	\N	かえします	\N
2384	141	2796	2	返します	\N	かえします	\N
2385	141	2651	3	返す	\N	かえす	\N
2392	533	2800	1	番	\N	ばん	\N
2393	533	1647	2	番	\N	ばん	\N
2402	89	2802	2	円	\N	えん	\N
2403	89	2801	1	円	\N	えん	\N
2404	479	2803	1	名前	\N	なまえ	\N
2405	479	1714	2	名前	\N	なまえ	\N
2406	479	1965	3	名前	\N	なまえ	\N
2416	307	1588	1	食堂	\N	しょくどう	\N
2417	307	1553	2	食堂	\N	しょくどう	\N
2420	380	2806	1	食べ物	\N	たべもの	\N
2421	380	1860	2	食べ物	\N	たべもの	\N
2424	251	2807	1	ごはん	\N	ごはん	\N
2425	251	2808	2	ごはん	\N	ごはん	\N
2426	173	2809	2	カレー	\N	かれー	\N
2427	173	2810	1	カレー	\N	かれー	\N
2430	721	2811	1	お酒	\N	おさけ	\N
2432	324	2812	1	スプーン	\N	すぷーん	\N
2433	560	2813	1	フォーク	\N	ふぉーく	\N
2435	466	2815	2	ナイフ	\N	ないふ	\N
2436	466	2814	1	ナイフ	\N	ないふ	\N
2437	513	2816	1	はし	\N	\N	\N
2438	720	2817	1	お皿	\N	おさら	\N
2442	381	2818	1	食べます	\N	たべます	\N
2443	381	1484	2	食べて	\N	たべて	\N
2444	381	1993	3	食べた	\N	たべた	\N
2445	187	2819	1	喫茶店	\N	きっさてん	\N
2446	237	2820	1	コーヒー	\N	こーひー	\N
2447	233	2821	1	紅茶	\N	こうちゃ	\N
2448	193	2822	1	牛乳	\N	ぎゅうにゅう	\N
2449	620	2823	1	水	\N	みず	\N
2450	246	2824	1	コップ	\N	こっぷ	\N
2451	159	2825	1	カップ	\N	かっぷ	\N
2452	272	2826	1	砂糖	\N	さとう	\N
2453	503	1371	1	飲みます	\N	のみます	\N
2454	503	1818	2	飲みたいです	\N	のみたいです	\N
2455	503	2004	3	飲みました	\N	のみました	\N
2462	87	2115	1	駅	\N	えき	\N
2463	87	1551	2	駅	\N	えき	\N
2467	429	2830	1	電車	\N	でんしゃ	\N
2468	429	1672	2	電車	\N	でんしゃ	\N
2469	429	1562	3	電車	\N	でんしゃ	\N
2470	392	2831	1	地下鉄	\N	ちかてつ	\N
2471	189	2832	1	切符	\N	きっぷ	\N
2476	138	2833	1	階段	\N	かいだん	\N
2477	88	2498	1	エレベーター	\N	えれべーたー	\N
2478	109	2834	1	お手洗い	\N	おてあらい	\N
2481	434	2835	1	トイレ	\N	といれ	\N
2482	434	1305	2	トイレ	\N	といれ	\N
2483	66	2836	1	入口	\N	いりぐち	\N
2484	420	2837	1	出口	\N	でぐち	\N
2485	129	2838	1	降ります	\N	おります	\N
2488	504	2839	1	乗ります	\N	のります	\N
2489	504	1619	2	乗ります	\N	のります	\N
2492	294	2840	2	閉まって	\N	しまって	\N
2493	294	2841	1	閉まって	\N	しまって	\N
2499	214	2842	1	クラス	\N	くらす	\N
2500	214	1682	2	クラス	\N	くらす	\N
2504	195	2843	1	教室	\N	きょうしつ	\N
2505	195	1254	2	教室	\N	きょうしつ	\N
2506	195	1650	3	教室	\N	きょうしつ	\N
2507	360	2227	1	大学	\N	だいがく	\N
2508	360	1826	2	大学	\N	だいがく	\N
2509	692	2844	1	廊下	\N	ろうか	\N
2510	474	1646	1	夏休み	\N	なつやすみ	\N
2511	474	1397	2	夏休み	\N	なつやすみ	\N
2512	474	2205	3	夏休み	\N	なつやすみ	\N
2513	581	2845	1	勉強	\N	べんきょう	\N
2514	581	2846	2	勉強	\N	べんきょう	\N
2515	341	1178	1	先生	\N	せんせい	\N
2516	341	1476	2	先生	\N	せんせい	\N
2517	341	2019	3	先生	\N	せんせい	\N
2518	147	2153	1	学生	\N	がくせい	\N
2519	147	1176	2	学生	\N	がくせい	\N
2520	147	2158	3	学生	\N	がくせい	\N
2521	332	2847	2	生徒	\N	せいと	\N
2522	332	2848	1	生徒	\N	せいと	\N
2527	18	2851	2	遊びに	\N	あそびに	\N
2528	18	2852	1	遊びます	\N	あそびます	\N
2534	580	2853	1	勉強します	\N	べんきょうします	\N
2535	580	1356	2	勉強しました	\N	べんきょうしました	\N
2536	580	1675	3	勉強して	\N	べんきょうして	\N
2540	267	2855	1	作文	\N	さくぶん	\N
2541	267	2854	2	作文	\N	さくぶん	\N
2544	288	2856	1	質問	\N	しつもん	\N
2545	288	1654	2	質問	\N	しつもん	\N
2568	691	2860	1	練習すれば	\N	れんしゅうすれば	\N
2569	651	2861	1	易しかった	\N	やさしかった	\N
2572	105	2862	1	教えて	\N	おしえて	\N
2573	105	1380	2	教えます	\N	おしえます	\N
2574	243	2863	1	答える	\N	こたえる	\N
2577	690	2864	1	練習	\N	れんしゅう	\N
2578	690	1528	2	練習	\N	れんしゅう	\N
2579	722	2865	1	美容院	\N	びよういん	\N
2582	544	2866	1	左	\N	ひだり	\N
2583	544	1248	2	左	\N	ひだり	\N
2586	618	2867	1	右	\N	みぎ	\N
2587	618	1247	2	右	\N	みぎ	\N
2591	604	2868	1	前	\N	まえ	\N
2592	604	1255	2	前	\N	まえ	\N
2593	604	1249	3	前	\N	まえ	\N
2596	72	2869	1	うしろ	\N	うしろ	\N
2597	72	2761	2	うしろ	\N	うしろ	\N
2598	619	2870	2	短く	\N	みじかく	\N
2608	330	2874	1	座って	\N	すわって	\N
2609	330	1556	2	座って	\N	すわって	\N
2610	234	2875	2	交番	\N	こうばん	\N
2611	234	2876	1	交番	\N	こうばん	\N
2612	220	2877	1	警官	\N	けいかん	\N
2613	220	2878	2	警官	\N	けいかん	\N
2614	125	2879	1	おまわりさん	\N	おまわりさん	\N
2615	393	2880	1	地図	\N	ちず	\N
2618	391	2881	1	近く	\N	ちかく	\N
2619	391	1257	2	近く	\N	ちかく	\N
2624	605	2884	1	曲がる	\N	まがる	\N
2625	605	1507	2	曲がって	\N	まがって	\N
2626	32	2885	2	危ない	\N	あぶない	\N
2627	32	2886	1	危ない	\N	あぶない	\N
2628	454	2887	2	隣	\N	となり	\N
2629	454	2888	1	隣	\N	となり	\N
2631	354	2890	2	そば	\N	そば	\N
2632	354	2889	1	そば	\N	そば	\N
2633	471	2891	2	なくした	\N	なくした	\N
2634	471	2892	1	なくして	\N	なくして	\N
2637	577	2893	1	部屋	\N	へや	\N
2638	577	1434	2	部屋	\N	へや	\N
2645	174	2895	1	カレンダー	\N	かれんだー	\N
2646	174	2896	2	カレンダー	\N	かれんだー	\N
2649	100	1388	1	起きます	\N	おきます	\N
2650	100	2018	2	起きられませんでした	\N	おきられませんでした	\N
2651	100	2042	3	起きる	\N	おきる	\N
2654	498	2899	1	寝て	\N	ねて	\N
2655	498	1389	2	寝ます	\N	ねます	\N
2658	445	2900	1	時計	\N	とけい	\N
2659	445	1919	2	時計	\N	とけい	\N
2672	163	2902	1	花瓶	\N	かびん	\N
2675	623	2906	1	道	\N	みち	\N
2676	623	1478	2	道	\N	みち	\N
2677	232	2907	1	交差点	\N	こうさてん	\N
2686	217	2908	1	車	\N	くるま	\N
2687	217	1250	2	車	\N	くるま	\N
2688	217	2061	3	車	\N	くるま	\N
2689	290	2909	2	自動車	\N	じどうしゃ	\N
2690	290	2910	1	自動車	\N	じどうしゃ	\N
2691	369	2911	2	タクシー	\N	たくしー	\N
2692	369	2912	1	タクシー	\N	たくしー	\N
2696	289	2914	1	自転車	\N	じてんしゃ	\N
2697	289	2913	2	自転車	\N	じてんしゃ	\N
2698	289	2041	3	自転車	\N	じてんしゃ	\N
2699	175	2915	2	川	\N	かわ	\N
2700	175	2916	1	川	\N	かわ	\N
2701	717	2917	1	橋	\N	はし	\N
2702	277	2918	1	散歩	\N	さんぽ	\N
2703	718	2919	1	散歩します	\N	さんぽします	\N
2704	38	1586	1	歩きます	\N	あるきます	\N
2705	38	1557	2	歩いて	\N	あるいて	\N
2706	38	2055	3	歩きましょう	\N	あるきましょう	\N
2707	701	2920	2	渡って	\N	わたって	\N
2708	701	2921	1	渡ります	\N	わたります	\N
2716	559	2923	1	プール	\N	ぷーる	\N
2717	559	1548	2	プール	\N	ぷーる	\N
2718	559	1778	3	プール	\N	ぷーる	\N
2720	304	2925	2	上手なので	\N	じょうずなので	\N
2721	304	2926	1	上手	\N	じょうず	\N
2724	574	2927	1	下手	\N	へた	\N
2725	574	2924	2	下手	\N	へた	\N
2726	716	2928	2	速い	\N	はやい	\N
2727	716	2929	1	速い	\N	はやい	\N
2730	128	2069	1	泳ぎます	\N	およぎます	\N
2731	128	2189	2	泳ぎました	\N	およぎました	\N
2732	128	1546	3	泳いだり	\N	およいだり	\N
2741	517	2933	1	走れません	\N	はしれません	\N
2742	517	1990	2	走って	\N	はしって	\N
2745	456	2934	1	飛んで	\N	とんで	\N
2746	456	1645	2	飛んで	\N	とんで	\N
2751	543	1619	1	飛行機	\N	ひこうき	\N
2752	543	1549	2	飛行機	\N	ひこうき	\N
2761	361	2940	2	大使館	\N	たいしかん	\N
2762	361	2941	1	大使館	\N	たいしかん	\N
2767	593	2944	1	ホテル	\N	ほてる	\N
2768	593	1634	2	ホテル	\N	ほてる	\N
2775	715	2946	1	海外	\N	かいがい	\N
2776	715	2734	2	海外	\N	かいがい	\N
2782	684	2947	1	旅行	\N	りょこう	\N
2783	684	2948	2	旅行	\N	りょこう	\N
2792	649	2951	2	八百屋	\N	やおや	\N
2793	649	2952	1	八百屋	\N	やおや	\N
2794	486	2953	2	肉	\N	にく	\N
2795	486	2954	1	肉	\N	にく	\N
2796	192	2955	1	牛肉	\N	ぎゅうにく	\N
2797	563	2956	1	ぶた肉	\N	ぶたにく	\N
2798	461	2957	1	とり肉	\N	とりにく	\N
2799	264	2958	1	魚	\N	さかな	\N
2800	650	2959	2	野菜	\N	やさい	\N
2801	650	2960	1	野菜	\N	やさい	\N
2802	206	2961	1	果物	\N	くだもの	\N
2805	729	2962	1	高い	\N	たかい	\N
2806	729	1418	2	高かった	\N	たかかった	\N
2807	652	1542	1	安い	\N	やすい	\N
2808	652	2047	2	安ければ	\N	やすければ	\N
2811	672	1599	1	読みました	\N	よみました	\N
2812	672	1696	2	読みます	\N	よみます	\N
2815	270	2965	1	冊	\N	さつ	\N
2816	270	1323	2	冊	\N	さつ	\N
2820	449	2966	1	図書館	\N	としょかん	\N
2821	449	1974	2	図書館	\N	としょかん	\N
2822	449	1801	3	図書館	\N	としょかん	\N
2823	595	2967	2	本棚	\N	ほんだな	\N
2824	595	2968	1	本棚	\N	ほんだな	\N
2825	594	1244	1	本	\N	ほん	\N
2826	594	2088	2	本	\N	ほん	\N
2827	271	2969	2	雑誌	\N	ざっし	\N
2828	271	2970	1	雑誌	\N	ざっし	\N
2831	312	2971	1	新聞	\N	しんぶん	\N
2832	312	2065	2	新聞	\N	しんぶん	\N
2837	284	2974	1	辞書	\N	じしょ	\N
2838	284	1291	2	辞書	\N	じしょ	\N
2839	253	2975	2	コピーしました	\N	こぴーしました	\N
2840	253	2973	1	コピーします	\N	こぴーします	\N
2841	252	2976	1	コピー	\N	こぴー	\N
2844	137	2978	1	会社	\N	かいしゃ	\N
2845	137	2977	2	会社	\N	かいしゃ	\N
2850	653	2979	1	休み	\N	やすみ	\N
2851	653	1180	2	休み	\N	やすみ	\N
2856	378	2982	1	たばこ	\N	たばこ	\N
2857	378	2229	2	たばこ	\N	たばこ	\N
2858	51	2983	2	忙しい	\N	いそがしい	\N
2859	51	2984	1	忙しい	\N	いそがしい	\N
2868	408	2987	1	勤めて	\N	つとめて	\N
2871	314	2988	1	吸います	\N	すいます	\N
2872	314	2989	2	吸う	\N	すう	\N
2878	521	2993	1	働きます	\N	はたらきます	\N
2879	521	2992	2	働いて	\N	はたらいて	\N
2880	521	1459	3	働きます	\N	はたらきます	\N
2884	43	2994	1	家	\N	いえ	\N
2885	43	1601	2	家	\N	いえ	\N
2886	43	1402	3	家	\N	いえ	\N
2890	342	2995	1	洗濯	\N	せんたく	\N
2891	683	2104	1	料理	\N	りょうり	\N
2892	683	1967	2	料理	\N	りょうり	\N
2893	683	1419	3	料理	\N	りょうり	\N
2894	299	2996	1	シャワー	\N	しゃわー	\N
2895	31	2997	1	浴びて	\N	あびて	\N
2896	347	2998	1	掃除しよう	\N	そうじしよう	\N
2897	343	2999	1	洗濯しなければ	\N	せんたくしなければ	\N
2898	416	3000	2	出かけます	\N	でかけます	\N
2899	416	3001	1	出かけませんでした	\N	でかけませんでした	\N
2900	160	3002	1	家庭	\N	かてい	\N
2901	761	3003	1	ひいた	\N	ひいた	\N
2902	131	1817	1	音楽	\N	おんがく	\N
2903	131	1848	2	音楽	\N	おんがく	\N
2908	185	3005	1	ギター	\N	ぎたー	\N
2909	759	3006	1	ピアノ	\N	ぴあの	\N
2912	166	3007	2	カメラ	\N	かめら	\N
2913	166	3008	1	カメラ	\N	かめら	\N
2914	83	3009	1	映画	\N	えいが	\N
2915	83	2154	2	映画	\N	えいが	\N
2918	198	3011	2	嫌いなので	\N	きらいなので	\N
2919	198	3012	1	嫌い	\N	きらい	\N
2920	316	3013	2	好きな	\N	すきな	\N
2921	316	3014	1	好き	\N	すき	\N
2922	75	3015	1	歌います	\N	うたいます	\N
2923	541	3016	1	弾きます	\N	ひきます	\N
2924	462	3017	1	撮りました	\N	とりました	\N
2925	630	1396	1	見ました	\N	みました	\N
2926	630	1974	2	見ました	\N	みました	\N
2927	575	3018	1	ベッド	\N	べっど	\N
2932	323	3021	1	ストーブ	\N	すとーぶ	\N
2933	323	3019	2	ストーブ	\N	すとーぶ	\N
2934	579	1259	1	ペン	\N	ぺん	\N
2935	579	1667	2	ペン	\N	ぺん	\N
2938	586	3022	1	ボールペン	\N	ぼーるぺん	\N
2939	586	2249	2	ボールペン	\N	ぼーるぺん	\N
2940	427	3023	2	天気	\N	てんき	\N
2941	427	3024	1	天気	\N	てんき	\N
2946	211	3027	1	曇り	\N	くもり	\N
2947	211	3026	2	曇り	\N	くもり	\N
2948	710	3028	2	雨	\N	あめ	\N
2949	710	3029	1	雨	\N	あめ	\N
2958	19	3035	2	暖かく	\N	あたたかく	\N
2959	19	3036	1	暖かい	\N	あたたかい	\N
2960	712	3037	2	暑く	\N	あつく	\N
2961	712	3034	1	暑い	\N	あつい	\N
2962	321	3038	2	涼しく	\N	すずしく	\N
2963	321	3039	1	涼しい	\N	すずしい	\N
2964	531	3040	1	晴れて	\N	はれて	\N
2965	531	3041	2	晴れたら	\N	はれたら	\N
2970	713	3043	1	吹いて	\N	ふいて	\N
2971	713	3044	2	吹くそうです	\N	ふくそうです	\N
2976	432	3046	1	度	\N	ど	\N
2977	432	3045	2	度	\N	ど	\N
2978	212	3047	1	曇って	\N	くもって	\N
2979	212	3048	2	曇って	\N	くもって	\N
2980	530	3025	1	晴れ	\N	はれ	\N
2981	530	1194	2	晴れ	\N	はれ	\N
2984	74	3050	1	歌	\N	うた	\N
2985	74	1457	2	歌	\N	うた	\N
2986	663	3051	1	雪	\N	ゆき	\N
2987	663	2068	2	雪	\N	ゆき	\N
2988	711	3052	1	風	\N	かぜ	\N
2989	711	3030	2	風	\N	かぜ	\N
2995	764	3057	1	髪	\N	かみ	\N
3000	765	3059	1	駅員	\N	えきいん	\N
3003	199	3060	1	切りました	\N	きりました	\N
3004	199	2871	2	切ります	\N	きります	\N
3005	468	2873	1	長い	\N	ながい	\N
3010	647	2857	1	問題	\N	もんだい	\N
3011	647	1515	2	問題	\N	もんだい	\N
3014	303	3063	1	宿題	\N	しゅくだい	\N
3015	303	1473	2	宿題	\N	しゅくだい	\N
3018	766	3064	1	答え	\N	こたえ	\N
3019	766	1971	2	答え	\N	こたえ	\N
3026	458	3067	1	友達	\N	ともだち	\N
3027	458	2429	2	友達	\N	ともだち	\N
3028	681	3066	1	留学生	\N	りゅうがくせい	\N
3029	681	3065	2	留学生	\N	りゅうがくせい	\N
3030	421	3068	2	テスト	\N	てすと	\N
3031	421	2858	1	テスト	\N	てすと	\N
3038	762	3070	1	美容師	\N	びようし	\N
3039	762	3071	2	美容師	\N	びようし	\N
3042	668	3062	1	横	\N	よこ	\N
3043	668	3072	2	横	\N	よこ	\N
3046	551	3073	1	病院	\N	びょういん	\N
3047	551	1738	2	病院	\N	びょういん	\N
3052	757	3074	1	熱	\N	ねつ	\N
3053	757	1545	2	熱	\N	ねつ	\N
3054	117	2764	1	おなか	\N	おなか	\N
3055	414	3075	1	テーブル	\N	てーぶる	\N
3056	158	1605	1	学校	\N	がっこう	\N
3057	158	1349	2	学校	\N	がっこう	\N
3058	183	2882	1	聞きました	\N	ききました	\N
3059	771	3076	1	聞きます	\N	ききます	\N
3060	767	3077	1	電話番号	\N	でんわばんごう	\N
3061	768	3078	2	連絡	\N	れんらく	\N
3062	768	3079	1	連絡	\N	れんらく	\N
3063	769	3080	2	連絡して	\N	れんらくして	\N
3064	769	3081	1	連絡します	\N	れんらくします	\N
3065	770	3082	2	見つかりました	\N	みつかりました	\N
3066	770	3083	1	見つかります	\N	みつかります	\N
3067	772	3084	1	家賃	\N	やちん	\N
3074	773	3087	1	探しました	\N	さがしました	\N
3075	773	3086	2	探そう	\N	さがそう	\N
3076	508	3088	2	灰皿	\N	はいざら	\N
3077	508	3089	1	灰皿	\N	はいざら	\N
3082	775	3091	1	定食	\N	ていしょく	\N
3083	775	3092	2	定食	\N	ていしょく	\N
3084	774	3093	2	店員	\N	てんいん	\N
3085	774	3094	1	店員	\N	てんいん	\N
3086	776	3095	2	ミルク	\N	みるく	\N
3087	776	3096	1	ミルク	\N	みるく	\N
3090	534	1609	1	パン	\N	ぱん	\N
3091	534	1532	2	パン	\N	ぱん	\N
3092	780	3097	1	売り場	\N	うりば	\N
3093	781	3098	2	カード	\N	かーど	\N
3094	781	3099	1	カード	\N	かーど	\N
3099	782	3101	1	郵便局員	\N	ゆうびんきょくいん	\N
3100	784	3102	1	船便	\N	ふなびん	\N
3101	783	3103	1	航空便	\N	こうくうびん	\N
3103	785	3105	2	送った	\N	おくった	\N
3104	785	3104	1	送りました	\N	おくりました	\N
3105	654	2991	1	休みます	\N	やすみます	\N
3106	760	2986	1	しませんでした	\N	しませんでした	\N
3107	760	1398	2	します	\N	します	\N
3108	657	1683	1	やります	\N	やります	\N
3109	283	2024	1	仕事	\N	しごと	\N
3110	786	3106	2	スーツ	\N	すーつ	\N
3111	786	3107	1	スーツ	\N	すーつ	\N
3112	496	2981	1	ネクタイ	\N	ねくたい	\N
3115	298	3108	1	シャツ	\N	しゃつ	\N
3116	298	1640	2	シャツ	\N	しゃつ	\N
3118	787	3110	1	会社員	\N	かいしゃいん	\N
3119	788	3111	1	スーパー	\N	すーぱー	\N
3122	46	3114	1	いくつ	\N	いくつ	\N
3123	46	3115	2	いくつ	\N	いくつ	\N
3124	47	2409	1	いくら	\N	いくら	\N
3125	47	1320	2	いくら	\N	いくら	\N
3126	789	3116	1	おはし	\N	おはし	\N
3130	231	3117	1	公園	\N	こうえん	\N
3131	231	1222	2	公園	\N	こうえん	\N
3132	231	1255	3	公園	\N	こうえん	\N
3133	779	3118	1	テニス	\N	てにす	\N
3134	779	1881	2	テニス	\N	てにす	\N
3137	325	3119	1	スポーツ	\N	すぽーつ	\N
3138	325	1849	2	スポーツ	\N	すぽーつ	\N
3139	777	3120	1	サッカー	\N	さっかー	\N
3140	778	3121	1	野球	\N	やきゅう	\N
3141	790	3122	1	試合	\N	しあい	\N
3142	107	2931	1	遅い	\N	おそい	\N
3143	411	3123	1	強い	\N	つよい	\N
3144	674	3124	1	弱い	\N	よわい	\N
3158	791	3126	2	汚い	\N	きたない	\N
3159	791	3127	1	汚い	\N	きたない	\N
3160	222	3128	2	消す	\N	けす	\N
3161	222	3129	1	消します	\N	けします	\N
3162	407	2898	1	つけます	\N	つけます	\N
3170	428	2901	1	電気	\N	でんき	\N
3171	428	1513	2	電気	\N	でんき	\N
3172	142	3130	1	帰ります	\N	かえります	\N
3173	145	3131	2	かぎ	\N	かぎ	\N
3174	145	3132	1	かぎ	\N	かぎ	\N
3175	646	3133	1	門	\N	もん	\N
3179	200	3134	1	きれい	\N	きれい	\N
3180	200	1455	2	きれい	\N	きれい	\N
3181	200	1535	3	きれいで	\N	きれいで	\N
3182	76	1367	1	うち	\N	うち	\N
3183	76	2178	2	うち	\N	うち	\N
3190	202	3136	1	銀行	\N	ぎんこう	\N
3191	202	2795	2	銀行	\N	ぎんこう	\N
3192	792	3137	1	銀行員	\N	ぎんこういん	\N
3193	793	3138	2	窓口	\N	まどぐち	\N
3194	793	3139	1	窓口	\N	まどぐち	\N
3195	794	3140	1	振り込み	\N	ふりこみ	\N
3196	795	3141	2	用紙	\N	ようし	\N
3197	795	3142	1	用紙	\N	ようし	\N
3198	99	1233	1	お金	\N	おかね	\N
3199	99	2060	2	お金	\N	おかね	\N
3200	99	2093	3	お金	\N	おかね	\N
3204	536	3143	1	番号	\N	ばんごう	\N
3206	796	3144	1	住所	\N	じゅうしょ	\N
3207	155	3145	1	方	\N	かた	\N
3208	797	1672	1	台風	\N	たいふう	\N
3209	797	1562	2	台風	\N	たいふう	\N
3212	136	2939	2	外国人	\N	がいこくじん	\N
3213	136	3146	1	外国人	\N	がいこくじん	\N
3215	210	3147	2	国	\N	くに	\N
3216	210	2943	1	国	\N	くに	\N
3217	806	3148	2	空港	\N	くうこう	\N
3218	806	3149	1	空港	\N	くうこう	\N
3219	807	3150	2	パスポート	\N	ぱすぽーと	\N
3220	807	3151	1	パスポート	\N	ぱすぽーと	\N
3227	808	3154	2	ガイド	\N	がいど	\N
3228	808	3155	1	ガイド	\N	がいど	\N
3229	809	3156	2	泊まりました	\N	とまりました	\N
3230	809	3157	1	泊まります	\N	とまります	\N
3231	810	3158	2	お土産	\N	おみやげ	\N
3232	810	3159	1	お土産	\N	おみやげ	\N
3233	401	3160	2	使います	\N	つかいます	\N
3234	401	3100	1	使います	\N	つかいます	\N
3237	800	3163	1	します	\N	します	\N
3242	705	3164	1	着ます	\N	きます	\N
3243	705	1481	2	着て	\N	きて	\N
3248	178	3165	1	漢字	\N	かんじ	\N
3249	178	1885	2	漢字	\N	かんじ	\N
3255	811	3167	1	日本語	\N	にほんご	\N
3256	811	1811	2	日本語	\N	にほんご	\N
3259	526	3168	2	話す	\N	はなす	\N
3260	526	3169	1	話して	\N	はなして	\N
3263	42	3170	1	言います	\N	いいます	\N
3264	42	1694	2	言います	\N	いいます	\N
3267	812	3173	2	字	\N	じ	\N
3268	812	3174	1	字	\N	じ	0
3269	525	3175	2	話	\N	はなし	\N
3270	525	3176	1	話	\N	はなし	\N
3271	63	3177	2	意味	\N	いみ	\N
3272	63	3178	1	意味	\N	いみ	\N
3273	156	3179	1	かたかな	\N	かたかな	\N
3274	553	3180	1	ひらがな	\N	ひらがな	\N
3275	756	3181	1	文	\N	ぶん	\N
3276	230	3182	2	語	\N	ご	\N
3277	230	3183	1	語	\N	ご	\N
3278	248	3184	1	ことば	\N	ことば	\N
3279	143	3185	1	顔	\N	かお	\N
3283	666	3186	1	洋服	\N	ようふく	\N
3284	81	3187	1	上着	\N	うわぎ	\N
3285	236	3188	1	コート	\N	こーと	\N
3286	333	3189	1	セーター	\N	せーたー	\N
3287	326	3190	1	ズボン	\N	ずぼん	\N
3289	315	3192	1	スカート	\N	すかーと	\N
3290	328	3193	1	スリッパ	\N	すりっぱ	\N
3291	150	3194	1	かけます	\N	かけます	\N
3293	511	3196	2	はいて	\N	はいて	\N
3294	511	3197	1	はいて	\N	はいて	\N
3297	494	3198	1	脱ぎます	\N	ぬぎます	\N
3298	494	3195	2	脱ぎます	\N	ぬぎます	\N
3299	90	2774	1	鉛筆	\N	えんぴつ	\N
3300	85	2936	1	英語	\N	えいご	\N
3301	85	2937	2	英語	\N	えいご	\N
3302	685	2935	1	旅行しよう	\N	りょこうしよう	\N
3303	755	2097	1	お弁当	\N	おべんとう	\N
3304	755	1728	2	お弁当	\N	おべんとう	\N
3305	755	1556	3	お弁当	\N	おべんとう	\N
3306	33	3199	1	甘い	\N	あまい	\N
3308	803	3201	1	つけないで	\N	つけないで	\N
3309	306	3202	1	しょうゆ	\N	しょうゆ	\N
3311	396	3204	2	ちゃわん	\N	ちゃわん	\N
3312	396	3205	1	ちゃわん	\N	ちゃわん	\N
3316	98	3209	1	お菓子	\N	おかし	\N
3317	606	3210	2	まずそう	\N	まずそう	\N
3318	606	3211	1	まずい	\N	まずい	\N
3319	92	3212	2	おいしそう	\N	おいしそう	\N
3320	92	3213	1	おいしい	\N	おいしい	\N
3321	555	3214	2	昼ごはん	\N	ひるごはん	\N
3322	555	3207	1	昼ごはん	\N	ひるごはん	\N
3326	13	3216	2	朝ごはん	\N	あさごはん	\N
3327	13	3208	1	朝ごはん	\N	あさごはん	\N
3330	659	3217	1	夕飯	\N	ゆうはん	\N
3331	659	2123	2	夕飯	\N	ゆうはん	\N
3332	537	3206	2	晩ごはん	\N	ばんごはん	\N
3333	537	3218	1	晩ごはん	\N	ばんごはん	\N
3338	280	3220	2	塩	\N	しお	\N
3339	280	3219	1	塩	\N	しお	\N
3340	169	3221	1	体	\N	からだ	\N
3343	637	3224	1	目	\N	め	0
3344	637	3223	1	目	\N	め	\N
3345	629	3225	1	耳	\N	みみ	\N
3346	524	3226	1	鼻	\N	はな	\N
3347	207	3227	1	口	\N	くち	\N
3349	412	3229	1	手	\N	て	\N
3350	15	3230	2	足	\N	あし	\N
3351	15	3231	1	足	\N	あし	\N
3352	36	3232	1	洗います	\N	あらいます	\N
3353	617	3233	1	磨きます	\N	みがきます	\N
3354	402	3234	1	疲れました	\N	つかれました	\N
3358	64	2079	1	妹	\N	いもうと	\N
3359	64	2099	2	妹	\N	いもうと	\N
3362	394	2086	1	父	\N	ちち	\N
3370	467	3235	1	中	\N	なか	\N
3371	467	1258	2	中	\N	なか	\N
3372	467	1275	3	中	\N	なか	\N
3373	352	1254	1	外	\N	そと	\N
3374	352	1410	2	外	\N	そと	\N
3375	352	1734	3	外	\N	そと	\N
3377	6	1537	1	赤い	\N	あかい	\N
3381	4	3236	1	青い	\N	あおい	\N
3382	4	1592	2	青い	\N	あおい	\N
3384	181	3238	1	黄色い	\N	きいろい	\N
3385	310	3239	2	白くて	\N	しろくて	\N
3386	310	3237	1	白い	\N	しろい	\N
3387	218	3240	1	黒	\N	くろ	\N
3388	626	3241	1	緑	\N	みどり	\N
3389	395	3242	1	茶色	\N	ちゃいろ	\N
3390	5	3243	1	赤	\N	あか	\N
3391	3	3244	1	青	\N	あお	\N
3392	69	3245	1	色	\N	いろ	\N
3393	180	3246	1	黄色	\N	きいろ	\N
3396	71	3247	1	上	\N	うえ	\N
3397	71	1323	2	上	\N	うえ	\N
3398	286	3248	1	下	\N	した	\N
3399	161	3249	1	角	\N	かど	\N
3400	176	3250	2	側	\N	がわ	\N
3401	176	3251	1	側	\N	がわ	\N
3402	728	3252	2	あります	\N	あります	\N
3403	728	3253	1	あります	\N	あります	\N
3404	754	3254	2	います	\N	います	\N
3405	754	3255	1	います	\N	います	\N
3406	184	3256	1	北	\N	きた	\N
3407	628	3257	1	南	\N	みなみ	\N
3409	539	3259	1	東	\N	ひがし	\N
3410	487	3260	1	西	\N	にし	\N
3411	120	3261	1	お姉さん	\N	おねえさん	\N
3412	682	3262	1	両親	\N	りょうしん	\N
3413	527	3263	1	母	\N	はは	\N
3414	28	3264	1	姉	\N	あね	\N
3415	102	3265	1	奥さん	\N	おくさん	\N
3416	119	3266	1	お兄さん	\N	おにいさん	\N
3417	97	3267	1	お母さん	\N	おかあさん	\N
3418	814	3268	1	ご主人	\N	ごしゅじん	\N
3419	815	3269	1	妹さん	\N	いもうとさん	\N
3420	816	3270	1	弟さん	\N	おとうとさん	\N
3421	196	3271	1	兄弟	\N	きょうだい	\N
3422	545	1276	1	人	\N	ひと	\N
3423	545	1476	2	人	\N	ひと	\N
3424	132	3272	1	女	\N	おんな	\N
3425	249	3273	1	子ども	\N	こども	\N
3426	133	3274	1	女の子	\N	おんなのこ	\N
3427	103	3275	1	おじさん	\N	おじさん	\N
3428	121	3276	1	おばさん	\N	おばさん	\N
3429	104	3277	1	おじいさん	\N	おじいさん	\N
3430	122	3278	1	おばあさん	\N	おばあさん	\N
3431	116	3279	1	大人	\N	おとな	\N
3432	276	3280	1	さん	\N	さん	\N
3433	709	3281	1	人	\N	じん	\N
3434	112	3282	1	男	\N	おとこ	\N
3435	113	3283	1	男の子	\N	おとこのこ	\N
3436	62	1330	1	今	\N	いま	\N
3437	62	1491	2	今	\N	いま	0
3444	571	3284	1	分	\N	ふん	\N
3445	571	1679	2	分	\N	ぷん	\N
3446	748	1334	1	時	\N	じ	1
3447	748	1333	2	時	\N	じ	\N
3455	489	3285	1	日曜日	\N	にちようび	\N
3456	489	1392	2	日曜日	\N	にちようび	\N
3467	675	3287	1	来月	\N	らいげつ	\N
3468	675	1942	2	来月	\N	らいげつ	\N
3478	714	1350	1	わたし	\N	わたし	\N
3479	714	1692	2	わたし	\N	わたし	\N
3480	714	1299	3	わたし	\N	わたし	\N
3485	26	3288	1	あなた	\N	あなた	\N
3486	26	3289	2	あなた	\N	あなた	\N
3487	26	2234	3	あなた	\N	あなた	\N
3488	26	2170	4	あなた	\N	あなた	\N
3492	293	3290	1	自分	\N	じぶん	\N
3493	293	1683	2	自分	\N	じぶん	\N
3496	238	1474	1	ここ	\N	ここ	\N
3497	349	1296	1	そこ	\N	そこ	\N
3501	17	1297	1	あそこ	\N	あそこ	\N
3502	39	1311	1	あれ	\N	あれ	\N
3506	356	1837	1	それ	\N	それ	\N
3507	356	1268	2	それ	\N	それ	\N
3508	255	1259	1	これ	\N	これ	\N
3509	244	3291	2	こちら	\N	こちら	\N
3510	244	3292	1	こちら	\N	こちら	\N
3511	245	3293	1	こっち	\N	こっち	\N
3512	22	3294	2	あちら	\N	あちら	\N
3513	22	3295	1	あちら	\N	あちら	\N
3514	24	3296	1	あっち	\N	あっち	\N
3515	350	3297	2	そちら	\N	そちら	\N
3516	350	3298	1	そちら	\N	そちら	\N
3517	351	3299	1	そっち	\N	そっち	\N
3522	257	3302	1	今月	\N	こんげつ	\N
3523	257	3303	2	今月	\N	こんげつ	\N
3529	157	3307	1	月	\N	がつ	\N
3530	157	3306	2	月	\N	がつ	\N
3531	547	3308	1	ひとつき	\N	\N	\N
3532	547	3304	1	ひとつき	\N	\N	\N
3533	600	3309	2	毎月	\N	まいげつ	\N
3534	600	3301	1	毎月	\N	まいつき	\N
3535	148	3310	2	か月	\N	かげつ	\N
3536	148	3305	1	か月	\N	かげつ	\N
3537	339	3311	2	先月	\N	せんげつ	\N
3538	339	3300	1	先月	\N	せんげつ	\N
3540	448	3313	1	年	1	とし	\N
3541	115	3314	2	おととし	\N	おととし	\N
3542	115	3315	1	おととし	\N	おととし	\N
3549	247	3317	1	今年	\N	ことし	\N
3550	247	1638	2	今年	\N	ことし	\N
3557	275	3320	1	さ来年	\N	さらいねん	\N
3558	275	3321	2	さ来年	\N	さらいねん	\N
3559	601	3322	2	毎年	\N	まいねん	\N
3560	601	3312	1	毎年	\N	まいとし	\N
3561	499	3323	2	年	\N	ねん	\N
3562	499	3324	1	年	\N	ねん	\N
3567	2	3326	1	会います	\N	あいます	\N
3568	2	3327	2	会って	\N	あって	\N
3571	10	3329	2	開けて	\N	あけて	\N
3572	10	3328	1	開けます	\N	あけます	\N
3573	10	1520	3	開けて	\N	あけて	\N
3577	9	3330	1	開きます	\N	あきます	\N
3578	9	1501	2	開いて	\N	あいて	\N
3579	9	1921	3	開いて	\N	あいて	\N
3580	613	3331	2	窓	\N	まど	\N
3581	613	2894	1	窓	\N	まど	\N
3584	11	3332	1	上げます	\N	あげます	\N
3585	11	3333	2	上げます	\N	あげます	\N
3589	45	3336	2	行きませんでした	\N	いきませんでした	\N
3590	45	3337	1	行きます	\N	いきます	\N
3591	67	3338	2	要ります	\N	いります	\N
3592	67	3339	1	要ります	\N	いります	\N
3596	68	2828	1	入れます	\N	いれます	\N
3597	68	2829	2	入れて	\N	いれて	\N
3601	817	3341	1	入れます	\N	いれます	\N
3602	817	3340	2	入れて	\N	いれて	\N
3603	77	3342	2	生まれた	\N	うまれた	\N
3604	77	3343	1	生まれました	\N	うまれました	\N
3608	79	3346	2	売って	\N	うって	\N
3609	79	3344	1	売って	\N	うって	\N
3612	101	3347	1	置いて	\N	おいて	\N
3613	101	1386	2	置きます	\N	おきます	\N
3614	106	3348	2	押す	\N	おす	\N
3615	106	2798	1	押します	\N	おします	\N
3616	124	3349	2	覚えて	\N	おぼえて	\N
3617	124	3350	1	覚えます	\N	おぼえます	\N
3619	302	3069	1	授業	\N	じゅぎょう	\N
3620	302	2005	2	授業	\N	じゅぎょう	\N
3623	130	3351	1	終わったら	\N	おわったら	\N
3624	130	1348	2	終わります	\N	おわります	\N
3625	144	3352	2	かかります	\N	かかります	\N
3626	144	3353	1	かかります	\N	かかります	\N
3627	753	3354	2	かけました	\N	かけました	\N
3628	753	3355	1	かけます	\N	かけます	\N
3629	182	3356	2	消えた	\N	きえた	\N
3630	182	3357	1	消えて	\N	きえて	\N
3637	819	2232	1	来ませんでした	\N	きませんでした	\N
3638	819	1638	2	来ました	\N	きました	\N
3639	819	2220	3	来ました	\N	きました	\N
3643	225	3362	2	結婚して	\N	けっこんして	\N
3644	225	3361	1	結婚します	\N	けっこんします	\N
3651	266	3364	1	咲きます	\N	さきます	\N
3652	266	3363	2	咲いて	\N	さいて	\N
3654	254	3365	1	困りました	\N	こまりました	\N
3655	269	3366	1	さして	\N	さして	\N
3656	799	3367	1	できました	\N	できました	\N
3659	750	3368	1	閉めます	\N	しめます	\N
3660	750	1512	2	閉めて	\N	しめて	\N
3663	373	3371	2	立って	\N	たって	\N
3664	373	3372	1	立って	\N	たって	\N
3665	373	1485	3	立って	\N	たって	\N
3666	377	3373	2	頼まれました	\N	たのまれました	\N
3667	377	3374	1	頼みます	\N	たのみます	\N
3675	500	3376	1	ノート	\N	のーと	\N
3676	500	1246	2	ノート	\N	のーと	\N
3677	500	1527	3	ノート	\N	のーと	\N
3684	752	3378	1	取ります	\N	とります	\N
3685	752	3379	2	取って	\N	とって	\N
3688	457	3380	1	止まります	\N	とまります	\N
3689	457	3381	2	止まりました	\N	とまりました	\N
3693	697	3383	1	忘れました	\N	わすれました	\N
3694	697	3382	2	忘れないで	\N	わすれないで	\N
3695	697	1473	3	忘れないで	\N	わすれないで	\N
3699	696	3385	1	分かります	\N	わかります	\N
3700	696	3384	2	分からない	\N	わからない	\N
3701	700	3386	1	渡しました	\N	わたしました	\N
3705	801	3389	1	休みました	\N	やすみました	\N
3708	610	3391	1	待ちます	\N	まちます	\N
3709	610	3390	2	待って	\N	まって	\N
3712	622	3392	1	見せて	\N	みせて	\N
3713	622	1625	2	見せます	\N	みせます	\N
3718	501	3395	1	登ります	\N	のぼります	\N
3719	501	3394	2	登った	\N	のぼった	\N
3720	480	3396	2	習って	\N	ならって	\N
3721	480	3397	1	習いました	\N	ならいました	\N
3722	514	3398	2	始まります	\N	はじまります	\N
3723	514	3399	1	始まります	\N	はじまります	\N
3726	482	3402	2	並べて	\N	ならべて	\N
3727	482	3403	1	並べます	\N	ならべます	\N
3731	481	3405	1	並びました	\N	ならびました	\N
3732	481	3404	2	並んで	\N	ならんで	\N
3733	483	3406	2	なりたいです	\N	なりたいです	\N
3734	483	3407	1	なります	\N	なります	\N
3735	425	3408	2	出ます	\N	でます	\N
3736	425	3377	1	出て	\N	でて	\N
3737	425	1637	3	出ます	\N	でます	\N
3738	226	3409	1	月曜日	\N	げつようび	\N
3739	167	3410	1	火曜日	\N	かようび	\N
3740	313	3411	1	水曜日	\N	すいようび	\N
4193	732	3742	2	よく	\N	よく	\N
3741	641	3412	1	木曜日	\N	もくようび	\N
3742	203	3413	1	金曜日	\N	きんようび	\N
3743	459	3414	1	土曜日	\N	どようび	\N
3744	340	3415	1	先週	\N	せんしゅう	\N
3746	676	3417	2	来週	\N	らいしゅう	\N
3747	676	3418	1	来週	\N	らいしゅう	\N
3748	599	3419	1	毎週	\N	まいしゅう	\N
3752	197	3420	1	去年	\N	きょねん	\N
3753	197	3316	2	去年	\N	きょねん	\N
3754	197	1495	3	去年	\N	きょねん	\N
3757	677	3318	1	来年	\N	らいねん	\N
3758	677	3319	2	来年	\N	らいねん	\N
3759	114	3421	2	おととい	\N	おととい	\N
3760	114	3422	1	おととい	\N	おととい	\N
3761	190	3423	2	きのう	\N	きのう	\N
3762	190	3424	1	きのう	\N	きのう	\N
3763	194	3425	2	きょう	\N	きょう	\N
3764	194	3426	1	きょう	\N	きょう	\N
3765	16	3427	2	あした	\N	あした	\N
3766	16	3428	1	あした	\N	あした	\N
3767	14	3429	2	あさって	\N	あさって	\N
3768	14	3430	1	あさって	\N	あさって	\N
3769	661	3431	2	ゆうべ	\N	ゆうべ	\N
3770	661	3432	1	ゆうべ	\N	ゆうべ	\N
3773	602	3433	1	毎日	\N	まいにち	\N
3774	602	1557	2	毎日	\N	まいにち	\N
3775	598	3434	2	毎朝	\N	まいあさ	\N
3776	598	3435	1	毎朝	\N	まいあさ	\N
3777	603	3436	2	毎晩	\N	まいばん	\N
3778	603	3437	1	毎晩	\N	まいばん	\N
3779	54	3438	2	一日	\N	いちにち	\N
3780	54	3439	1	一日	\N	いちにち	\N
3782	488	3441	1	日	\N	にち	\N
3783	221	3442	2	けさ	\N	けさ	\N
3784	221	3443	1	けさ	\N	けさ	\N
3791	12	3446	2	朝	\N	あさ	\N
3792	12	3447	1	朝	\N	あさ	\N
3793	554	3448	2	昼	\N	ひる	\N
3794	554	3449	1	昼	\N	ひる	\N
3795	658	3450	2	夕方	\N	ゆうがた	\N
3796	658	3451	1	夕方	\N	ゆうがた	\N
3800	673	3453	1	夜	\N	よる	\N
3801	673	3452	2	夜	\N	よる	\N
3802	708	3454	2	晩	\N	ばん	\N
3803	708	3455	1	晩	\N	ばん	\N
3804	242	3456	2	午前	\N	ごぜん	\N
3805	242	3457	1	午前	\N	ごぜん	\N
3806	239	3458	1	午後	\N	ごご	\N
3807	239	1768	2	午後	\N	ごご	\N
3808	282	3459	2	時間	\N	じかん	\N
3809	282	3460	1	時間	\N	じかん	\N
3812	397	3462	1	中	\N	ちゅう	\N
3813	746	3463	2	時間	\N	じかん	\N
3814	746	3464	1	時間	\N	じかん	\N
3815	265	3465	2	先	\N	さき	\N
3816	265	3466	1	先	\N	さき	\N
3817	403	3467	2	次	\N	つぎ	\N
3818	403	3468	1	次	\N	つぎ	\N
3821	818	3358	1	切ります	\N	きります	\N
3829	94	3472	1	大きくて	\N	おおきくて	\N
3830	94	1401	2	大きい	\N	おおきい	\N
3831	387	3473	2	小さい	\N	ちいさい	\N
3832	387	3474	1	小さくて	\N	ちいさくて	\N
3836	707	3476	1	暗い	\N	くらい	\N
3837	707	2206	2	暗い	\N	くらい	\N
3838	7	3477	2	明るい	\N	あかるい	\N
3839	7	3478	1	明るくて	\N	あかるくて	\N
3842	706	3479	1	熱い	\N	あつい	\N
3843	706	3480	2	熱い	\N	あつい	\N
3844	410	3481	2	冷たい	\N	つめたい	\N
3845	410	3482	1	冷たい	\N	つめたい	\N
3847	591	3484	2	細く	\N	ほそく	\N
3848	591	3485	1	細くて	\N	ほそくて	\N
3852	566	3487	1	太い	\N	ふとい	\N
3853	566	3483	2	太い	\N	ふとい	\N
3854	23	3488	2	厚い	\N	あつい	\N
3855	23	3486	1	厚くて	\N	あつくて	\N
3856	73	3489	2	薄い	\N	うすい	\N
3857	73	3490	1	薄い	\N	うすい	\N
3858	126	3491	2	重い	\N	おもい	\N
3859	126	3492	1	重い	\N	おもい	\N
3864	172	3494	1	軽い	\N	かるい	\N
3865	172	3493	2	軽い	\N	かるい	\N
3874	805	3498	1	長かった	\N	ながかった	\N
3875	805	3497	2	長い	\N	ながい	\N
3876	542	3499	2	低い	\N	ひくい	\N
3877	542	3500	1	低い	\N	ひくい	\N
3878	804	3501	2	短い	\N	みじかい	\N
3879	804	3502	1	短い	\N	みじかい	\N
3880	40	3503	3	よくなかった	\N	よくなかった	\N
3881	40	3504	2	いい	\N	いい	\N
3882	40	3505	1	いい	\N	いい	\N
3883	702	3506	2	悪い	\N	わるい	\N
3884	702	3507	1	悪い	\N	わるい	\N
3886	127	3508	2	おもしろい	\N	おもしろい	\N
3887	127	3509	1	おもしろい	\N	おもしろい	\N
3892	376	3511	1	楽しい	\N	たのしい	\N
3893	376	3510	2	楽しかった	\N	たのしかった	\N
3894	376	1862	3	楽しい	\N	たのしい	\N
3895	409	3512	2	つまらない	\N	つまらない	\N
3896	409	3513	1	つまらない	\N	つまらない	\N
3899	65	3515	1	嫌	\N	いや	\N
3900	65	3514	2	嫌な	\N	いやな	\N
3901	65	2056	3	嫌なら	\N	いやなら	\N
3902	363	3516	2	大好きな	\N	だいすきな	\N
3903	363	3517	1	大好き	\N	だいすき	\N
3910	418	3135	1	できます	\N	できます	\N
3911	485	3520	2	にぎやかな	\N	にぎやかな	\N
3912	485	3521	1	にぎやか	\N	にぎやか	\N
3913	80	3522	2	うるさい	\N	うるさい	\N
3914	80	3523	1	うるさい	\N	うるさい	\N
3915	93	3524	2	多い	\N	おおい	\N
3916	93	3525	1	多い	\N	おおい	\N
3917	319	3526	2	少ない	\N	すくない	\N
3918	319	3527	1	少ない	\N	すくない	\N
3922	528	3529	2	早く	\N	はやく	\N
3923	528	3528	1	早い	\N	はやい	\N
3926	798	3531	1	遅い	\N	おそい	\N
3927	798	3530	2	遅く	\N	おそく	\N
3928	546	3532	1	一つ	\N	ひとつ	\N
3929	562	3533	1	二つ	\N	ふたつ	\N
3930	625	3534	1	三つ	\N	みっつ	\N
3931	670	3535	1	四つ	\N	よっつ	\N
3932	59	3536	1	五つ	\N	いつつ	\N
3933	635	3537	1	六つ	\N	むっつ	\N
3934	476	3538	1	七つ	\N	ななつ	\N
3935	655	3539	1	八つ	\N	やっつ	\N
3936	241	3540	1	九つ	\N	ここのつ	\N
3937	400	3541	1	一日	\N	ついたち	\N
3938	565	3542	1	二日	\N	ふつか	\N
3939	624	3543	1	三日	\N	みっか	\N
3940	669	3544	1	四日	\N	よっか	\N
3941	57	3545	1	五日	\N	いつか	\N
3942	665	3546	1	八日	\N	ようか	\N
3943	632	3547	1	六日	\N	むいか	\N
3944	478	3548	1	七日	\N	なのか	\N
3945	240	3549	1	九日	\N	ここのか	\N
3946	442	3550	1	十日	\N	とおか	\N
3947	523	3551	1	二十日	\N	はつか	\N
3949	548	3552	2	一人	\N	ひとり	\N
3950	548	3553	1	一人	\N	ひとり	\N
3951	564	3554	2	二人	\N	ふたり	\N
3952	564	3555	1	二人	\N	ふたり	\N
3953	520	3556	2	二十歳	\N	はたち	\N
3954	520	3557	1	二十歳	\N	はたち	\N
3955	134	3558	2	回	\N	かい	\N
3956	134	3559	1	回	\N	かい	0
3957	229	3560	2	個	\N	こ	1
3958	229	3561	1	個	\N	こ	\N
3959	262	3562	2	歳	\N	さい	\N
3960	262	3563	1	歳	\N	さい	\N
3961	359	3564	2	台	\N	だい	\N
3962	359	3565	1	台	\N	だい	\N
3963	813	3566	2	人	\N	にん	\N
3964	813	3567	1	人	\N	にん	\N
3965	507	3568	3	杯	\N	ばい	\N
3966	507	3569	2	杯	\N	はい	\N
3967	507	3570	1	杯	\N	ぱい	\N
3968	540	3571	3	匹	\N	びき	\N
3969	540	3572	2	匹	\N	ひき	\N
3970	540	3573	1	匹	\N	ぴき	\N
3971	744	3574	3	本	\N	ぼん	\N
3972	744	3575	2	本	\N	ほん	\N
3973	744	3576	1	本	\N	ぽん	\N
3974	201	3577	2	キログラム	\N	きろぐらむ	\N
3975	201	3578	1	キロ	\N	きろ	\N
3976	742	3579	2	キロメートル	\N	きろめーとる	\N
3977	742	3580	1	キロ	\N	きろ	\N
3978	215	3581	2	グラム	\N	ぐらむ	\N
3979	215	3582	1	グラム	\N	ぐらむ	\N
3980	638	3583	2	メートル	\N	めーとる	\N
3981	638	3584	1	メートル	\N	めーとる	\N
3982	177	3585	2	かわいい	\N	かわいい	\N
3983	177	3586	1	かわいい	\N	かわいい	\N
3984	695	3587	2	若くて	\N	わかくて	\N
3985	695	3588	1	若い	\N	わかい	\N
3986	614	3589	2	丸い	\N	まるい	\N
3987	614	3590	1	丸い	\N	まるい	\N
3988	590	3591	2	欲しい	\N	ほしい	\N
3989	590	3592	1	欲しい	\N	ほしい	\N
3992	228	3593	1	元気じゃ　ありません	\N	げんきじゃ　ありません	\N
3993	228	3594	2	元気な	\N	げんきな	\N
3994	305	3595	2	丈夫な	\N	じょうぶな	\N
3995	305	3596	1	丈夫で	\N	じょうぶで	\N
3996	362	3597	2	大丈夫な	\N	だいじょうぶな	\N
3997	362	3598	1	大丈夫	\N	だいじょうぶ	\N
3999	364	3600	2	大切な	\N	たいせつな	\N
4000	364	3599	1	大切なので	\N	たいせつなので	\N
4003	366	3603	2	大変な	\N	たいへんな	\N
4004	366	3604	1	大変	\N	たいへん	\N
4006	583	3605	2	便利な	\N	べんりな	\N
4007	583	3606	1	便利	\N	べんり	\N
4008	662	3607	2	有名な	\N	ゆうめいな	\N
4009	662	3608	1	有名	\N	ゆうめい	\N
4010	549	3609	2	暇な	\N	ひまな	\N
4011	549	3610	1	暇なので	\N	ひまなので	\N
4012	645	3611	2	物	\N	もの	\N
4013	645	3612	1	物	\N	もの	\N
4014	447	3613	2	所	\N	ところ	\N
4015	447	3614	1	所	\N	ところ	\N
4016	491	3615	2	ニュース	\N	にゅーす	\N
4017	491	3616	1	ニュース	\N	にゅーす	\N
4023	506	3618	1	パーティー	\N	ぱーてぃー	\N
4024	506	1398	2	パーティー	\N	ぱーてぃー	\N
4025	385	3619	2	誕生日	\N	たんじょうび	\N
4026	385	3620	1	誕生日	\N	たんじょうび	\N
4027	374	3621	2	縦	\N	たて	\N
4028	374	3622	1	縦	\N	たて	\N
4029	382	3623	2	卵	\N	たまご	\N
4030	382	3624	1	卵	\N	たまご	\N
4032	431	3626	2	戸	\N	と	\N
4033	431	3625	1	戸	\N	と	\N
4036	573	3627	1	ページ	\N	ぺーじ	\N
4037	573	1515	2	ページ	\N	ぺーじ	\N
4039	430	3629	2	電話	\N	でんわ	\N
4040	430	3628	1	電話	\N	でんわ	\N
4041	557	3630	2	フィルム	\N	ふぃるむ	\N
4042	557	3631	1	フィルム	\N	ふぃるむ	\N
4043	235	3632	2	声	\N	こえ	\N
4044	235	3633	1	声	\N	こえ	\N
4047	331	3634	1	背	\N	せ	\N
4048	331	1446	2	背	\N	せ	\N
4049	588	3635	2	ポケット	\N	ぽけっと	\N
4050	588	3636	1	ポケット	\N	ぽけっと	\N
4051	535	3637	2	ハンカチ	\N	はんかち	\N
4052	535	3638	1	ハンカチ	\N	はんかち	\N
4055	763	3639	1	シャンプー	\N	しゃんぷー	\N
4056	763	3056	2	シャンプー	\N	しゃんぷー	\N
4057	334	3640	2	せっけん	\N	せっけん	\N
4058	334	3641	1	せっけん	\N	せっけん	\N
4059	612	3642	2	マッチ	\N	まっち	\N
4060	612	3643	1	マッチ	\N	まっち	\N
4061	84	3644	2	映画館	\N	えいがかん	\N
4062	84	3645	1	映画館	\N	えいがかん	\N
4063	512	3646	2	箱	\N	はこ	\N
4064	512	3647	1	箱	\N	はこ	\N
4067	165	3649	1	紙	\N	かみ	\N
4068	165	3648	2	紙	\N	かみ	\N
4069	636	3650	2	村	\N	むら	\N
4070	636	3651	1	村	\N	むら	\N
4071	609	3652	2	町	\N	まち	\N
4072	609	3653	1	町	\N	まち	\N
4073	820	3654	2	国	\N	くに	\N
4074	820	3655	1	国	\N	くに	\N
4075	460	3656	2	鳥	\N	とり	\N
4076	460	3657	1	鳥	\N	とり	\N
4077	497	3658	2	猫	\N	ねこ	\N
4078	497	3659	1	猫	\N	ねこ	\N
4079	61	3660	2	犬	\N	いぬ	\N
4080	61	3661	1	犬	\N	いぬ	\N
4081	576	3662	2	ペット	\N	ぺっと	\N
4082	576	3663	1	ペット	\N	ぺっと	\N
4083	438	3664	2	動物	\N	どうぶつ	\N
4084	438	3665	1	動物	\N	どうぶつ	\N
4085	78	3666	2	海	\N	うみ	\N
4086	78	3667	1	海	\N	うみ	\N
4087	656	3668	2	山	\N	やま	\N
4088	656	3669	1	山	\N	やま	\N
4089	48	3670	2	池	\N	いけ	\N
4090	48	3671	1	池	\N	いけ	\N
4091	725	3672	2	花	\N	はな	\N
4092	725	3673	1	花	\N	はな	\N
4093	179	3674	2	木	\N	き	1
4094	179	3675	1	木	\N	き	\N
4095	355	3676	2	空	\N	そら	\N
4096	355	3677	1	空	\N	そら	\N
4097	567	3678	2	冬	\N	ふゆ	\N
4098	567	3679	1	冬	\N	ふゆ	\N
4107	724	3685	1	春	\N	はる	\N
4108	724	3684	1	春	\N	はる	\N
4109	258	3686	2	今週	\N	こんしゅう	\N
4110	258	3416	1	今週	\N	こんしゅう	\N
4112	25	3470	1	あと	\N	あと	\N
4116	470	3690	2	泣いて	\N	ないて	\N
4117	470	3691	1	泣いて	\N	ないて	\N
4119	281	3692	2	しかし	\N	しかし	\N
4120	281	3693	1	しかし	\N	しかし	\N
4121	424	3694	2	でも	\N	でも	\N
4122	424	3695	1	でも	\N	でも	\N
4123	348	3696	2	そして	\N	そして	\N
4124	348	3697	1	そして	\N	そして	\N
4125	357	3698	2	それから	\N	それから	\N
4126	357	3699	1	それから	\N	それから	\N
4127	34	3700	1	あまり	\N	あまり	\N
4128	34	1428	2	あまり	\N	あまり	\N
4129	821	3701	2	あとで	\N	あとで	\N
4130	821	3469	1	あとで	\N	あとで	\N
4131	60	3702	2	いつも	\N	いつも	\N
4132	60	3703	1	いつも	\N	いつも	\N
4135	223	3706	1	けっこう	\N	けっこう	\N
4140	452	3707	1	とても	\N	とても	\N
4141	452	1427	2	とても	\N	とても	\N
4142	320	3708	2	少し	\N	すこし	\N
4143	320	3709	1	少し	\N	すこし	\N
4144	398	3710	2	ちょうど	\N	ちょうど	\N
4145	398	3711	1	ちょうど	\N	ちょうど	\N
4148	730	3714	2	大変	\N	たいへん	\N
4149	730	3715	1	大変	\N	たいへん	\N
4150	386	3716	2	だんだん	\N	だんだん	\N
4151	386	3717	1	だんだん	\N	だんだん	\N
4159	399	3719	1	ちょっと	\N	ちょっと	\N
4160	399	3718	2	ちょっと	\N	ちょっと	\N
4161	399	1720	3	ちょっと	\N	ちょっと	\N
4162	399	2672	4	ちょっと	\N	ちょっと	\N
4163	444	3720	2	時々	\N	ときどき	\N
4164	444	3721	1	時々	\N	ときどき	\N
4165	731	3722	2	たぶん	\N	たぶん	\N
4166	731	3723	1	たぶん	\N	たぶん	\N
4169	516	3726	2	初めて	\N	はじめて	\N
4170	516	3727	1	初めて	\N	はじめて	\N
4174	607	3729	1	また	\N	また	\N
4175	607	3728	2	また	\N	また	\N
4176	607	2562	3	また	\N	また	\N
4177	608	3730	2	まだ	\N	まだ	\N
4178	608	3731	1	まだ	\N	まだ	\N
4182	640	3733	1	もう	\N	もう	1
4183	640	3732	2	もう	\N	もう	\N
4184	640	2004	3	もう	\N	もう	\N
4185	739	3734	2	もう	\N	もう	\N
4186	739	3735	1	もう	\N	もう	\N
4189	644	3738	2	もっと	\N	もっと	\N
4190	644	3739	1	もっと	\N	もっと	\N
4191	733	3740	2	よく	\N	よく	\N
4192	733	3741	1	よく	\N	よく	\N
4194	732	3743	1	よく	\N	よく	\N
4195	515	3744	2	初めに	\N	はじめに	\N
4196	515	3745	1	初め	\N	はじめ	\N
4197	56	1393	1	いつ	\N	いつ	\N
4198	56	1268	2	いつ	\N	いつ	\N
4199	56	1494	3	いつ	\N	いつ	\N
4203	383	3746	1	だれ	\N	だれ	\N
4204	383	1308	2	だれ	\N	だれ	\N
4205	383	1900	3	だれ	\N	だれ	\N
4206	384	3747	2	だれか	\N	だれか	\N
4207	384	3748	1	だれか	\N	だれか	\N
4212	435	1414	1	どう	\N	どう	\N
4213	435	1423	2	どう	\N	どう	\N
4214	435	2064	3	どう	\N	どう	\N
4215	436	2011	1	どうして	\N	どうして	\N
4216	436	2017	2	どうして	\N	どうして	\N
4217	436	2007	3	どうして	\N	どうして	\N
4225	446	3749	1	どこ	\N	どこ	\N
4226	446	1229	2	どこ	\N	どこ	\N
4227	446	1312	3	どこ	\N	どこ	\N
4228	446	1264	4	どこ	\N	どこ	\N
4231	472	3750	1	なぜ	\N	なぜ	\N
4232	472	2599	2	なぜ	\N	なぜ	\N
4233	477	1333	1	何	\N	なん	\N
4234	477	1335	2	何	\N	なん	\N
4235	477	1326	3	何	\N	なん	\N
4241	822	3751	1	何	\N	なん	\N
4242	822	1860	2	何	\N	なん	\N
4243	822	1492	3	何	\N	なに	\N
4247	463	3752	1	どれ	\N	どれ	\N
4248	463	3753	2	どれ	\N	どれ	\N
4249	463	1836	3	どれ	\N	どれ	\N
4253	464	3755	1	どんな	\N	どんな	\N
4254	464	3754	2	どんな	\N	どんな	\N
4255	464	1280	3	どんな	\N	どんな	\N
4256	451	3756	2	どっち	\N	どっち	\N
4257	451	3757	1	どっち	\N	どっち	\N
4260	44	3758	1	いかが	\N	いかが	\N
4261	44	3759	2	いかが	\N	いかが	\N
4262	455	3760	2	どの	\N	どの	\N
4263	455	3761	1	どの	\N	どの	\N
4266	453	3762	1	どなた	\N	どなた	\N
4267	453	3763	2	どなた	\N	どなた	\N
4268	450	3764	2	どちら	\N	どちら	\N
4269	450	3765	1	どちら	\N	どちら	\N
4277	1	3766	1	ああ	\N	ああ	\N
4278	1	3767	2	ああ	\N	ああ	\N
4279	1	2637	3	ああ	\N	ああ	\N
4280	29	3768	2	あの	\N	あの	\N
4281	29	3769	1	あの	\N	あの	\N
4282	261	3770	2	さあ	\N	さあ	\N
4283	261	3771	1	さあ	\N	さあ	\N
4289	642	3773	1	もしもし	\N	もしもし	\N
4290	642	3772	2	もしもし	\N	もしもし	\N
4291	642	2548	3	もしもし	\N	もしもし	\N
4308	741	3777	1	はい	\N	はい	\N
4309	741	3778	2	はい	\N	はい	\N
4310	741	2332	3	はい	\N	はい	\N
4311	741	1824	4	はい	\N	はい	\N
4312	741	1715	5	はい	\N	はい	\N
4313	422	3779	2	では	\N	では	\N
4314	422	3780	1	では	\N	では	\N
4320	296	3781	1	じゃあ	\N	じゃあ	\N
4321	296	2562	2	じゃあ	\N	じゃあ	\N
4322	296	2415	3	じゃあ	\N	じゃあ	\N
4331	345	3783	2	そう	\N	そう	\N
4332	345	3782	1	そう	\N	そう	\N
4333	345	2637	3	そう	\N	そう	\N
4334	345	2396	4	そう	\N	そう	\N
4338	41	3784	1	いいえ	\N	いいえ	\N
4339	41	1369	2	いいえ	\N	いいえ	\N
4340	41	1879	3	いいえ	\N	いいえ	\N
4341	86	1727	1	ええ	\N	ええ	\N
4342	86	2520	2	ええ	\N	ええ	\N
4343	55	3785	2	いちばん	\N	いちばん	\N
4344	55	3786	1	いちばん	\N	いちばん	\N
4345	250	3787	2	この	\N	この	\N
4346	250	3788	1	この	\N	この	\N
4350	283	1799	2	仕事	\N	しごと	\N
4353	353	3789	1	その	\N	その	\N
4354	353	1299	2	その	\N	その	\N
4355	259	3790	2	こんな	\N	こんな	\N
4356	259	3791	1	こんな	\N	こんな	\N
4364	437	3792	1	どうぞ	\N	どうぞ	\N
4365	437	2369	2	どうぞ	\N	どうぞ	\N
4366	437	2332	3	どうぞ	\N	どうぞ	\N
4367	437	2383	4	どうぞ	\N	どうぞ	\N
4368	802	3793	2	ください	\N	ください	\N
4369	802	3794	1	ください	\N	ください	\N
4377	58	3795	1	いっしょ	\N	いっしょ	\N
4378	58	3796	2	いっしょ	\N	いっしょ	\N
4379	58	3797	3	いっしょ	\N	いっしょ	\N
4382	95	3798	1	大きな	\N	おおきな	\N
4383	95	3799	2	大きな	\N	おおきな	\N
4384	388	3800	2	小さな	\N	ちいさな	\N
4385	388	3801	1	小さな	\N	ちいさな	\N
4386	538	3802	2	半分	\N	はんぶん	\N
4387	538	3803	1	半分	\N	はんぶん	\N
4388	633	3804	2	向こう	\N	むこう	\N
4389	633	3805	1	向こう	\N	むこう	\N
4390	344	3806	2	全部	\N	ぜんぶ	\N
4391	344	3807	1	全部	\N	ぜんぶ	\N
4392	96	3808	2	大勢	\N	おおぜい	\N
4393	96	3809	1	大勢	\N	おおぜい	\N
4394	118	3810	2	同じ	\N	おなじ	\N
4395	118	3811	1	同じ	\N	おなじ	\N
4396	368	3812	2	たくさん	\N	たくさん	\N
4397	368	3813	1	たくさん	\N	たくさん	\N
4398	469	3814	2	ながら	\N	ながら	\N
4399	469	3815	1	ながら	\N	ながら	\N
4402	475	3816	1	など	\N	など	\N
4403	475	3817	2	など	\N	など	\N
4404	322	3818	2	ずつ	\N	ずつ	\N
4405	322	3819	1	ずつ	\N	ずつ	\N
4406	372	3820	2	たち	\N	たち	\N
4407	372	3821	1	たち	\N	たち	\N
4409	627	3823	3	皆さん	\N	みなさん	\N
4410	627	3824	2	皆さん	\N	みなさん	\N
4411	627	3825	1	皆さん	\N	みなさん	\N
4412	631	3826	3	みんな	\N	みんな	\N
4413	631	3827	2	みんな	\N	みんな	\N
4414	631	3828	1	みんな	\N	みんな	\N
4417	532	3829	1	半	\N	はん	\N
4418	532	3830	2	半	\N	はん	\N
4419	171	3831	2	がって	\N	がって	\N
4420	171	3832	1	がって	\N	がって	\N
4423	256	3835	2	ごろ	\N	ごろ	\N
4424	256	3836	1	ころ	\N	ころ	\N
4425	317	3837	2	すぎ	\N	すぎ	\N
4426	317	3838	1	すぎ	\N	すぎ	\N
4427	578	3839	2	辺	\N	へん	\N
4428	578	3840	1	辺	\N	へん	\N
4429	584	3841	2	ほう	\N	ほう	\N
4430	584	3842	1	ほう	\N	ほう	\N
4431	745	3843	2	前	\N	まえ	\N
4432	745	3822	1	前	\N	まえ	\N
4433	648	3844	1	屋	\N	や	\N
4434	648	3845	2	屋	\N	や	\N
4435	596	3846	2	本当	\N	ほんとう	\N
4436	596	3847	1	本当	\N	ほんとう	\N
4439	726	3848	1	ほか	\N	ほか	\N
4440	726	3849	2	ほか	\N	ほか	\N
4441	749	3850	2	中	\N	じゅう	\N
4442	749	3851	1	中	\N	じゅう	\N
4445	170	3852	1	借りて	\N	かりて	\N
4446	170	1382	2	借ります	\N	かります	\N
4447	689	3853	2	レストラン	\N	れすとらん	\N
4448	689	2805	1	レストラン	\N	れすとらん	\N
4449	21	1274	1	新しい	\N	あたらしい	\N
4450	21	1947	2	新しい	\N	あたらしい	\N
4451	413	1477	1	テープ	\N	てーぷ	\N
4452	413	1558	2	テープ	\N	てーぷ	\N
4461	829	3856	2	ケーキ	\N	けーき	\N
4462	829	3855	1	ケーキ	\N	けーき	\N
4463	829	1319	3	ケーキ	\N	けーき	\N
4466	828	1371	1	コーラ	\N	こーら	\N
4467	828	1710	2	コーラ	\N	こーら	\N
4470	832	3857	1	コンサート	\N	こんさーと	\N
4471	832	1660	2	コンサート	\N	こんさーと	\N
4476	826	3858	2	心配しないで	\N	しんぱいしないで	\N
4477	826	3859	1	心配して	\N	しんぱいして	\N
4480	823	3860	1	コンピューター	\N	こんぴゅーたー	\N
4481	823	1831	2	コンピューター	\N	こんぴゅーたー	\N
4484	834	3861	1	スイッチ	\N	すいっち	\N
4485	834	1748	2	スイッチ	\N	すいっち	\N
4486	831	3862	2	カラオケ	\N	からおけ	\N
4487	831	3863	1	カラオケ	\N	からおけ	\N
4488	827	3864	2	携帯電話	\N	けいたいでんわ	\N
4489	827	3865	1	携帯電話	\N	けいたいでんわ	\N
4490	824	3866	2	やめた	\N	やめた	\N
4491	824	3867	1	やめました	\N	やめました	\N
4492	825	3868	2	もらった	\N	もらった	\N
4493	825	3869	1	もらいました	\N	もらいました	\N
4498	833	3871	1	あげます	\N	あげます	\N
4499	833	3870	2	あげました	\N	あげました	\N
4500	135	2179	1	外国	\N	がいこく	\N
4501	135	1883	2	外国	\N	がいこく	\N
4503	153	2762	1	かぜ	\N	かぜ	\N
4505	327	1535	1	住んで	\N	すんで	\N
4506	327	1928	2	住んで	\N	すんで	\N
4507	327	2030	3	住んで	\N	すんで	\N
4508	358	3872	2	それでは	\N	それでは	\N
4509	358	3873	1	それでは	\N	それでは	\N
4510	740	3874	1	あの	\N	あの	\N
4511	439	3776	1	どうも	\N	どうも	\N
4512	439	3774	2	どうも	\N	どうも	\N
4513	439	3775	3	どうも	\N	どうも	\N
4514	439	2391	4	どうも	\N	どうも	\N
4515	592	2043	1	ボタン	\N	ぼたん	\N
4516	680	3875	2	りっぱな	\N	りっぱな	\N
4517	680	3876	1	りっぱな	\N	りっぱな	\N
4518	835	3705	1	いろいろ	\N	いろいろ	\N
4519	70	3704	1	いろいろ	\N	いろいろ	\N
4520	611	3724	1	まっすぐ	\N	まっすぐ	\N
4521	611	3725	2	まっすぐ	\N	まっすぐ	\N
4522	390	3375	1	違います	\N	ちがいます	\N
4523	390	1693	2	違います	\N	ちがいます	\N
4526	836	3387	1	呼びます	\N	よびます	\N
4527	671	3388	1	呼びました	\N	よびました	\N
4528	440	3877	1	十	\N	とお	\N
4529	698	2744	1	私	\N	わたくし	\N
4530	164	3878	1	かぶって	\N	かぶって	\N
4531	301	3879	1	週間	\N	しゅうかん	\N
4535	297	3880	1	写真	\N	しゃしん	\N
4536	297	2181	2	写真	\N	しゃしん	\N
4537	830	3854	1	壁	\N	かべ	\N
4538	830	1614	2	壁	\N	かべ	\N
4539	82	3010	1	絵	\N	え	\N
4540	82	1455	2	絵	\N	え	\N
4541	273	3053	1	寒い	\N	さむい	\N
4542	273	1403	2	寒くない	\N	さむくない	\N
4543	568	3042	1	降りませんでした	\N	ふりませんでした	\N
4544	568	1931	2	降りそうです	\N	ふりそうです	\N
4545	309	3881	1	白	\N	しろ	\N
4546	686	3882	1	零	\N	れい	\N
4547	337	3883	1	ゼロ	\N	ぜろ	\N
4548	53	3884	1	一	\N	いち	\N
4549	484	3885	1	二	\N	に	1
4550	734	3886	1	三	\N	さん	\N
4551	735	3887	1	四	\N	よん	\N
4552	736	3888	1	五	\N	ご	\N
4553	693	3889	1	六	\N	ろく	\N
4554	287	3890	1	七	\N	しち	\N
4555	522	3891	1	八	\N	はち	\N
4557	300	3893	1	十	0	じゅう	\N
4558	550	3894	1	百	\N	ひゃく	\N
4559	338	3895	1	千	\N	せん	\N
4560	615	3896	1	万	\N	まん	\N
4561	154	3897	1	家族	\N	かぞく	\N
4562	110	3898	1	お父さん	\N	おとうさん	\N
4563	168	3215	1	辛い	\N	からい	\N
4564	168	1408	2	辛い	\N	からい	\N
4565	168	1409	3	辛くない	\N	からくない	\N
4574	841	3907	1	だめ	\N	だめ	\N
4575	842	3908	1	音	\N	おと	\N
4576	843	3909	1	グループ	\N	ぐるーぷ	\N
4580	433	3058	2	ドア	\N	どあ	\N
4581	370	3911	1	だけ	\N	だけ	\N
4582	370	3912	1	だけ	\N	だけ	\N
4583	213	3833	1	くらい	\N	くらい	\N
4584	213	3834	2	ぐらい	\N	ぐらい	\N
4585	278	3913	2	四	\N	し	\N
4586	278	3914	1	\N	\N	\N	\N
4587	737	3915	1	七	\N	なな	\N
4588	473	3683	1	夏	\N	なつ	\N
4589	473	3682	2	夏	\N	なつ	\N
4590	8	3681	1	秋	\N	あき	\N
4591	8	3680	2	秋	\N	あき	\N
4592	278	3887	3	四	0	よん	\N
4593	735	3914	2	\N	0	null	\N
4594	735	3913	3	四	0	し	\N
4595	737	3890	2	七	0	しち	\N
4596	287	3915	2	七	0	なな	\N
4597	738	3916	1	九	0	く	\N
4599	738	3892	2	九	0	きゅう	\N
4600	621	2949	1	店	0	\N	0
4601	621	2950	2	店	0	\N	0
4602	621	1433	3	店	0	\N	0
4603	139	3153	1	買い物	0	かいもの	0
4604	139	3617	2	買い物	0	かいもの	0
4605	723	3112	1	ください	0	ください	0
4606	723	3113	2	ください	0	ください	0
4607	367	3495	1	高い	0	\N	0
4608	367	3496	2	高い	0	\N	0
4609	285	3518	1	静かで	0	しずかで	0
4610	285	3519	2	静かな	0	しずかな	0
4611	285	2023	3	静か	0	しずか	0
4612	406	3162	1	作ります	0	つくります	0
4613	406	3161	2	作って	0	つくって	0
4614	146	3171	1	書きます	0	\N	0
4615	146	3172	2	書きました	0	\N	0
4616	260	3444	1	今晩	0	こんばん	0
4617	260	3445	2	今晩	0	こんばん	0
4618	260	1813	3	今晩	0	こんばん	0
4619	840	3906	1	反対	0	\N	0
4620	840	3905	2	反対	0	\N	0
4621	318	3712	1	すぐ	0	すぐ	0
4622	318	3713	2	すぐに	0	すぐに	0
4623	664	3737	1	ゆっくり	0	\N	0
4624	664	3736	2	ゆっくり	0	\N	0
4627	37	3335	1	ありません	0	ありません	0
4628	37	3334	2	ある	0	ある	0
4629	308	3369	1	知りませんでした	0	しりませんでした	0
4630	308	3370	2	知って	0	しって	0
4631	509	3688	1	入りました	0	\N	0
4632	509	3689	2	入ります	0	\N	0
4633	509	3687	3	入ります	0	\N	0
4636	839	3904	1	思います	0	おもいます	0
4637	839	3903	2	思います	0	おもいます	0
4638	838	3902	1	確認します	0	かくにんします	0
4639	838	3901	2	確認します	0	かくにんします	0
4640	837	3900	1	続きました	0	つづきました	0
4641	837	3899	2	続いて	0	つづいて	0
4642	844	3892	1	九	0	きゅう	0
4643	844	3916	2	九	0	く	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
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
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: ja_zt
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
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
1	あの(2)	1	あ	\N
2	先生	1	せ	\N
3	おはようございます	\N	\N	\N
4	おはよう	\N	\N	\N
5	きょう	1	き	\N
6	朝	1	あ	\N
7	授業	1	し	\N
8	いいえ	1	い	\N
9	午前中	\N	\N	\N
10	会議	\N	\N	\N
11	あります(1)	1	あ	\N
12	～君	\N	\N	\N
13	私	1	わ	\N
14	２限目	\N	\N	\N
15	もう(1)	1	も	\N
16	十時半	\N	\N	\N
17	あっ	\N	\N	\N
18	本当	1	ほ	\N
19	急がないと	\N	\N	\N
20	お先に失礼します	\N	\N	\N
21	ここ	1	こ	\N
22	印鑑	\N	\N	\N
23	いただきたい	\N	\N	\N
24	ああ	1	あ	\N
25	科目	\N	\N	\N
26	変更	\N	\N	\N
27	わかりました	\N	\N	\N
28	はい	1	は	\N
29	どうぞ	1	と	\N
30	ありがとうございます	\N	\N	\N
31	それから	1	そ	\N
32	この	1	こ	\N
33	本	1	ほ	\N
34	お返しします	\N	\N	\N
35	長い (1)	1	な	\N
36	間	\N	\N	\N
37	ありがとうございました	\N	\N	\N
38	いえいえ	\N	\N	\N
39	で	\N	\N	\N
40	役に立ちました	\N	\N	\N
41	ええ	1	え	\N
42	とても	1	と	\N
43	おもしろくて	\N	\N	\N
44	勉強になる	\N	\N	\N
45	そう	1	そ	\N
46	それ	1	そ	\N
47	よかった	\N	\N	\N
48	あのう	\N	\N	\N
49	すみません	\N	\N	\N
50	何でしょう	\N	\N	\N
51	在学証明書	\N	\N	\N
52	 いただきたい	\N	\N	\N
53	横 	1	よ	\N
54	機械	\N	\N	\N
55	使って	\N	\N	\N
56	～てください	\N	\N	\N
57	たびたび	\N	\N	\N
58	動かない	\N	\N	\N
59	５時	\N	\N	\N
60	過ぎています	\N	\N	\N
61	あした	1	あ	\N
62	お願いします	\N	\N	\N
63	初めて	1	は	\N
64	一人	\N	\N	\N
65	～ずつ	\N	\N	\N
66	自己紹介	\N	\N	\N
67	～をお願いします	\N	\N	\N
68	じゃあ	1	し	\N
69	～さん	\N	\N	\N
70	初めまして	\N	\N	\N
71	日本語	1	に	\N
72	専攻	\N	\N	\N
73	4年	\N	\N	\N
74	～と申します	\N	\N	\N
75	ゼミ	\N	\N	\N
76	アクセント	\N	\N	\N
77	卒論	\N	\N	\N
78	書こう	\N	\N	\N
79	～と思っています	\N	\N	\N
80	これから	\N	\N	\N
81	一年間	\N	\N	\N
82	よろしくお願いします	\N	\N	\N
83	こちらこそ	\N	\N	\N
84	よろしく	\N	\N	\N
85	準備	\N	\N	\N
86	いかが	1	い	\N
87	いちおう	\N	\N	\N
88	始めています	\N	\N	\N
89	就職活動	\N	\N	\N
90	しています	\N	\N	\N
91	大変(1)	1	た	\N
92	がんばってください	\N	\N	\N
93	失礼します	\N	\N	\N
94	レポート	\N	\N	\N
95	提出し	\N	\N	\N
96	来ました	\N	\N	\N
97	えっ	\N	\N	\N
98	たしか	\N	\N	\N
99	締め切り	\N	\N	\N
100	先週の	\N	\N	\N
101	金曜日	1	き	\N
102	遅れて	\N	\N	\N
103	かぜ	1	か	\N
104	寝込んでしまいまして	\N	\N	\N
105	そうですか	\N	\N	\N
106	でも	1	て	\N
107	そういう	\N	\N	\N
108	場合	\N	\N	\N
109	電話	1	て	\N
110	メール	\N	\N	\N
111	あらかじめ	\N	\N	\N
112	連絡して	\N	\N	\N
113	気をつけます	\N	\N	\N
114	すっかり	\N	\N	\N
115	よく(1)	1	よ	\N
116	なりました	\N	\N	\N
117	これ	1	こ	\N
118	軽井沢	\N	\N	\N
119	（お）土産	\N	\N	\N
120	つまらない	1	つ	\N
121	もの	\N	\N	\N
122	へえ	\N	\N	\N
123	何～	1	な	\N
124	りんごワイン	\N	\N	\N
125	めずらしい	\N	\N	\N
126	本当に	\N	\N	\N
127	いただいて	\N	\N	\N
128	～ていいの	\N	\N	\N
129	遠慮なく	\N	\N	\N
130	うーん	\N	\N	\N
131	楽しみ	\N	\N	\N
132	どうもありがとう	\N	\N	\N
133	こんばんは	\N	\N	\N
134	今	1	い	\N
135	そうなんです	\N	\N	\N
136	ずいぶん	\N	\N	\N
137	遅い (1)	1	お	\N
138	図書館	1	と	\N
139	資料	\N	\N	\N
140	探して	\N	\N	\N
141	偉い	\N	\N	\N
142	気をつけて	\N	\N	\N
143	帰って	\N	\N	\N
144	では	1	て	\N
145	さようなら	\N	\N	\N
146	いらっしゃいませ	\N	\N	\N
147	注文したい	\N	\N	\N
148	日本	\N	\N	\N
149	文法	\N	\N	\N
150	辞典	\N	\N	\N
151	いくら	1	い	\N
152	ちょっと	1	ち	\N
153	お待ちください	\N	\N	\N
154	6,500円	\N	\N	\N
155	税込み	\N	\N	\N
156	いえ	\N	\N	\N
157	消費税	\N	\N	\N
158	入れます(1)	1	い	\N
159	6,825円	\N	\N	\N
160	なります	\N	\N	\N
161	こちら	1	こ	\N
162	(お)名前	\N	\N	\N
163	(お)電話番号	\N	\N	\N
164	先輩	\N	\N	\N
165	登録	\N	\N	\N
166	質問して	\N	\N	\N
167	～てもいいですか	\N	\N	\N
168	いいよ	\N	\N	\N
169	英語	1	え	\N
170	とった	\N	\N	\N
171	～たことがあります	\N	\N	\N
172	わたし	1	わ	\N
173	あまり（～ない）	\N	\N	\N
174	自信	\N	\N	\N
175	大丈夫	1	た	\N
176	そうだねえ	\N	\N	\N
177	厳しい	\N	\N	\N
178	他	\N	\N	\N
179	考えた	\N	\N	\N
180	～たほうがいい	\N	\N	\N
181	～かもしれない	\N	\N	\N
182	暑い	1	あ	\N
183	早く	\N	\N	\N
184	夏休み	1	な	\N
185	来る	0	く	\N
186	いい	1	い	\N
187	そうね	\N	\N	\N
188	夏	1	な	\N
189	予定	\N	\N	\N
190	友達	1	と	\N
191	ヨーロッパ	\N	\N	\N
192	旅行しよう	\N	\N	\N
193	少し	1	す	\N
194	バイト	\N	\N	\N
195	しよう	\N	\N	\N
196	通訳	\N	\N	\N
197	仕事	1	し	\N
198	すごい	\N	\N	\N
199	見ている	\N	\N	\N
200	旅行	1	り	\N
201	パンフレット	\N	\N	\N
202	どこか	\N	\N	\N
203	旅行したい	\N	\N	\N
204	～と思って	\N	\N	\N
205	去年	1	き	\N
206	タイ	\N	\N	\N
207	行かれました	\N	\N	\N
208	行った	\N	\N	\N
209	（お）かね	\N	\N	\N
210	どのぐらい	\N	\N	\N
211	かかりましたか	\N	\N	\N
212	けっこう	1	け	\N
213	安かった	\N	\N	\N
214	全部	1	せ	\N
215	10万	\N	\N	\N
216	～日間	\N	\N	\N
217	行っていた	\N	\N	\N
218	かなり	\N	\N	\N
219	長かった	\N	\N	\N
220	3週間	\N	\N	\N
221	～週間	\N	\N	\N
222	～中	1	し	\N
223	開いていますか	\N	\N	\N
224	～時	\N	\N	\N
225	9時	\N	\N	\N
226	自習室	\N	\N	\N
227	使えますか	\N	\N	\N
228	5時	\N	\N	\N
229	土日	\N	\N	\N
230	(お)休み	\N	\N	\N
231	はい、どうぞ	\N	\N	\N
232	伺いたい	\N	\N	\N
233	一度	\N	\N	\N
234	～冊	\N	\N	\N
235	借りられますか	\N	\N	\N
236	10冊	\N	\N	\N
237	借りられます	\N	\N	\N
238	大学院生	\N	\N	\N
239	同じ	1	お	\N
240	一ヶ月	\N	\N	\N
241	20冊	\N	\N	\N
242	どれぐらい	\N	\N	\N
243	2週間	\N	\N	\N
244	じゃ	\N	\N	\N
245	今月	1	こ	\N
246	20日	\N	\N	\N
247	いいですね	\N	\N	\N
248	期末レポート	\N	\N	\N
249	お送りして	\N	\N	\N
250	いや	\N	\N	\N
251	やっぱり	\N	\N	\N
252	困ります	1	こ	\N
253	いちいち	\N	\N	\N
254	プリントアウトしなければ	\N	\N	\N
255	～なければいけない	\N	\N	\N
256	郵便	\N	\N	\N
257	送って	\N	\N	\N
258	(ご)自宅	\N	\N	\N
259	そうしてください	\N	\N	\N
260	アメリカ	\N	\N	\N
261	留学して	\N	\N	\N
262	学部	\N	\N	\N
263	半年間	\N	\N	\N
264	ボストン	\N	\N	\N
265	住んでいました	\N	\N	\N
266	話せますか	\N	\N	\N
267	少しなら	\N	\N	\N
268	実は	\N	\N	\N
269	来週	1	ら	\N
270	水曜日	1	す	\N
271	お客さん	\N	\N	\N
272	来るんですが	\N	\N	\N
273	空港	1	く	\N
274	迎えに行って	\N	\N	\N
275	いいです	\N	\N	\N
276	十時	\N	\N	\N
277	行けますか	\N	\N	\N
278	車	1	く	\N
279	運転	\N	\N	\N
280	できます	\N	\N	\N
281	授業料	\N	\N	\N
282	払いたい	\N	\N	\N
283	会計課	\N	\N	\N
284	どこ	1	と	\N
285	建物	1	た	\N
286	3階	\N	\N	\N
287	～階	\N	\N	\N
288	あります	\N	\N	\N
289	印刷センタ－	\N	\N	\N
290	となり	\N	\N	\N
291	どう	1	と	\N
292	行けば	\N	\N	\N
293	あそこ	1	あ	\N
294	エレベーター	1	え	\N
295	国際法	\N	\N	\N
296	どれ	1	と	\N
297	～と思う	\N	\N	\N
298	経済史	\N	\N	\N
299	あれ	1	あ	\N
300	言います	1	い	\N
301	出席	\N	\N	\N
302	厳しくて	\N	\N	\N
303	宿題	1	し	\N
304	多くて	\N	\N	\N
305	それに	\N	\N	\N
306	成績	\N	\N	\N
307	辛くて	\N	\N	\N
308	どうしようかなあ	\N	\N	\N
309	役に立つ	\N	\N	\N
310	この間	\N	\N	\N
311	返却します	\N	\N	\N
312	なかなか	\N	\N	\N
313	書けている	\N	\N	\N
314	～と思いました	\N	\N	\N
315	結論	\N	\N	\N
316	もう少し	\N	\N	\N
317	自分	1	し	\N
318	意見	\N	\N	\N
319	漢字	1	か	\N
320	間違い	\N	\N	\N
321	今度	\N	\N	\N
322	黒澤	\N	\N	\N
323	映画	1	え	\N
324	好き	1	す	\N
325	いちばん	1	い	\N
326	そうですねえ	\N	\N	\N
327	あかひげ	\N	\N	\N
328	ゆめ	\N	\N	\N
329	大好きです	\N	\N	\N
330	詳しい	\N	\N	\N
331	羅生門	\N	\N	\N
332	映画祭	\N	\N	\N
333	一緒に	\N	\N	\N
334	行きます	1	い	\N
335	うれしい	\N	\N	\N
336	料理する	\N	\N	\N
337	食べます	1	た	\N
338	得意	\N	\N	\N
339	料理	1	り	\N
340	スパゲッティ	\N	\N	\N
341	パエーリア	\N	\N	\N
342	グルメ	\N	\N	\N
343	食事	\N	\N	\N
344	毎日	1	ま	\N
345	どうも	1	と	\N
346	片付ける	\N	\N	\N
347	苦手	\N	\N	\N
348	作りません	\N	\N	\N
349	たしかに	\N	\N	\N
350	後片付け	\N	\N	\N
351	面倒	\N	\N	\N
352	拡大	\N	\N	\N
353	コピー	1	こ	\N
354	したい	\N	\N	\N
355	まず	\N	\N	\N
356	ボタン	1	ほ	\N
357	押して	\N	\N	\N
358	次に	\N	\N	\N
359	倍率	\N	\N	\N
360	選んで	\N	\N	\N
361		\N	\N	\N
362	最後	\N	\N	\N
363	用紙	1	よ	\N
364	スタートボタン	\N	\N	\N
365	ところで	\N	\N	\N
366	コピーカード	\N	\N	\N
367	持っています	\N	\N	\N
368	預かる	\N	\N	\N
369	忘れた	\N	\N	\N
370	もしもし	1	も	\N
371	最近	\N	\N	\N
372	学校	1	か	\N
373	お会いしません	\N	\N	\N
374	どうかしましたか	\N	\N	\N
375	足	1	あ	\N
376	けがしてしまって	\N	\N	\N
377	そうだったんですか	\N	\N	\N
378	論文	\N	\N	\N
379	何とか	\N	\N	\N
380	がんばっています	\N	\N	\N
381	無理なさらないで	\N	\N	\N
382	～ないでください	\N	\N	\N
383	お大事に	\N	\N	\N
384	じゃあ、また	\N	\N	\N
385	ボート大会	\N	\N	\N
386	何か	\N	\N	\N
387	もし（～たら）	\N	\N	\N
388	雨	1	あ	\N
389	降ったら	\N	\N	\N
390	大会	\N	\N	\N
391	中止	\N	\N	\N
392	小雨	\N	\N	\N
393	程度	\N	\N	\N
394	ならない	\N	\N	\N
395	～と思います	\N	\N	\N
396	大雨	\N	\N	\N
397	ありますか	\N	\N	\N
398	どうして	1	と	\N
399	見にいく	\N	\N	\N
400	約束をしている	\N	\N	\N
401	なるほど	\N	\N	\N
402	飲み会	\N	\N	\N
403	新宿	\N	\N	\N
404	吉祥寺	\N	\N	\N
405	池袋	\N	\N	\N
406	～の中で	\N	\N	\N
407	やめませんか	\N	\N	\N
408	そうですね	\N	\N	\N
409	どちらが	\N	\N	\N
410	安い	1	や	\N
411	店	1	み	\N
412	多い	1	お	\N
413	～にしませんか	\N	\N	\N
414	～にしましょう	\N	\N	\N
415	進んでいます	\N	\N	\N
416	思い通り	\N	\N	\N
417	進まなくて	\N	\N	\N
418	どのような	\N	\N	\N
419	考えている	\N	\N	\N
420	教えます	1	お	\N
421	それじゃ	\N	\N	\N
422	外国	1	か	\N
423	ちょうど	1	ち	\N
424	韓国	\N	\N	\N
425	大学	1	た	\N
426	日本語教師	\N	\N	\N
427	募集している	\N	\N	\N
428	え	\N	\N	\N
429	そうなんですか	\N	\N	\N
430	興味	\N	\N	\N
431	あれば	\N	\N	\N
432	推薦書	\N	\N	\N
433	書いて	\N	\N	\N
434	～てあげます	\N	\N	\N
435	あー	\N	\N	\N
436	真剣に	\N	\N	\N
437	せんせい	\N	\N	\N
438	休ませて	\N	\N	\N
439	～ていただきたいのですが	\N	\N	\N
440	なぜ	1	な	\N
441	じつは	\N	\N	\N
442	就職	\N	\N	\N
443	最終面接	\N	\N	\N
444	あと	1	あ	\N
445	来られません	\N	\N	\N
446	会社	1	か	\N
447	遠く	\N	\N	\N
448	無理	\N	\N	\N
449	面接	\N	\N	\N
450	がんばって	\N	\N	\N
451	がんばります	\N	\N	\N
452	(お)忙しい	\N	\N	\N
453	申し訳ありません	\N	\N	\N
454	来年	1	ら	\N
455	留学しよう	\N	\N	\N
456	～と思っている	\N	\N	\N
457	～ていただきたい	\N	\N	\N
458	よろしいでしょうか	\N	\N	\N
459	いつ	1	い	\N
460	急いでいる	\N	\N	\N
461	お願いできない	\N	\N	\N
462	だいじょうぶ	\N	\N	\N
463	ほっとしました	\N	\N	\N
464	学園祭	\N	\N	\N
465	18日	\N	\N	\N
466	どんな	1	と	\N
467	催し物	\N	\N	\N
468	外語大	\N	\N	\N
469	いろんな	\N	\N	\N
470	音楽	1	お	\N
471	演奏したり	\N	\N	\N
472	(お)芝居	\N	\N	\N
473	ダンス	\N	\N	\N
474	やったり	\N	\N	\N
475	料理店	\N	\N	\N
476	出したり	\N	\N	\N
477	食べられる	\N	\N	\N
478	イタリア	\N	\N	\N
479	いろいろな	\N	\N	\N
480	楽しそう	\N	\N	\N
481	子ども	\N	\N	\N
482	連れて来ます	\N	\N	\N
483	ぜひいらしてください	\N	\N	\N
484	お待ちして	\N	\N	\N
485	(ご)注文	\N	\N	\N
486	天ぷらうどん	\N	\N	\N
487	ごめんなさい	\N	\N	\N
488	天ぷら	\N	\N	\N
489	終わってしまった	\N	\N	\N
490	うどん	\N	\N	\N
491	たぬき	\N	\N	\N
492	きつね	\N	\N	\N
493	きつねうどん	\N	\N	\N
494	少々	\N	\N	\N
495	電子辞書	\N	\N	\N
496	そうだろ	\N	\N	\N
497	買った	\N	\N	\N
498	次	1	つ	\N
499	講読	\N	\N	\N
500	お借りして	\N	\N	\N
501	まあ	\N	\N	\N
502	返します	1	か	\N
503	(お)昼休み	\N	\N	\N
504	～でもいいですか	\N	\N	\N
505	僕	\N	\N	\N
506	３限目	\N	\N	\N
507	使います	1	つ	\N
508	返して	\N	\N	\N
509	４限目	\N	\N	\N
510	英作	\N	\N	\N
511	ええっ	\N	\N	\N
512	皆さん	1	み	\N
513	シンポジウム	\N	\N	\N
514	よろしくお願いいたします	\N	\N	\N
515	その	1	そ	\N
516	必ず	\N	\N	\N
517	出なければ	\N	\N	\N
518	～なければいけません	\N	\N	\N
519	～てもらいます	\N	\N	\N
520	日	\N	\N	\N
521	仕方がありません	\N	\N	\N
522	～なければなりません	\N	\N	\N
523	もちろん	\N	\N	\N
524	そこ	1	そ	\N
525	空き缶	\N	\N	\N
526	捨てて	\N	\N	\N
527	～てはいけません	\N	\N	\N
528	こっち	1	こ	\N
529	分かりました	\N	\N	\N
530	ああっ	\N	\N	\N
531	そっち	1	そ	\N
532	ちょっとすみません	\N	\N	\N
533	何ですか	\N	\N	\N
534	自転車置き場	\N	\N	\N
535	とめれば	\N	\N	\N
536	とめて	\N	\N	\N
537	(お)願い	\N	\N	\N
538	何でしょうか	\N	\N	\N
539	ホームページ	\N	\N	\N
540	作りたい	\N	\N	\N
541	手伝って	\N	\N	\N
542	～てもらえますか	\N	\N	\N
543	研究テーマ	\N	\N	\N
544	載せたい	\N	\N	\N
545	いいですか	\N	\N	\N
546	かまいません	\N	\N	\N
547	顔写真	\N	\N	\N
548	載せよう	\N	\N	\N
549	載せないで	\N	\N	\N
550	～ないでいただけないでしょうか	\N	\N	\N
551	～くん	\N	\N	\N
552	練習	1	れ	\N
553	出ます	1	て	\N
554	出なくて	\N	\N	\N
555	～なくてもいいですか	\N	\N	\N
556	具合	\N	\N	\N
557	悪い	1	わ	\N
558	試験	\N	\N	\N
559	四つ	1	よ	\N
560	こんにちは	\N	\N	\N
561	ダンスサークル	\N	\N	\N
562	土曜日	1	と	\N
563	ステージ	\N	\N	\N
564	よかったら	\N	\N	\N
565	見にいらっしゃいませんか	\N	\N	\N
566	分かった	\N	\N	\N
567	いっしょに	\N	\N	\N
568	見に行く	\N	\N	\N
569	悪そう	\N	\N	\N
570	うん	\N	\N	\N
571	スキー	\N	\N	\N
572	合宿	\N	\N	\N
573	風邪をひいてしまった	\N	\N	\N
574	ゆうべ	\N	\N	\N
575	急に	\N	\N	\N
576	熱	1	ね	\N
577	出て	\N	\N	\N
578	それなら	\N	\N	\N
579	病院	1	ひ	\N
580	インフルエンザ	\N	\N	\N
581	～かもしれません	\N	\N	\N
582	ありがとう	\N	\N	\N
583	もうすぐ	\N	\N	\N
584	絶対	\N	\N	\N
585	しない	\N	\N	\N
586	～ないほうがいい	\N	\N	\N
587	謝恩会	\N	\N	\N
588	会場	\N	\N	\N
589	予約したい	\N	\N	\N
590	3月	\N	\N	\N
591	25日	\N	\N	\N
592	6時	\N	\N	\N
593	30名	\N	\N	\N
594	～名	\N	\N	\N
595	一万	\N	\N	\N
596	～円	\N	\N	\N
597	お願いできます	\N	\N	\N
598	ホテル	1	ほ	\N
599	送ってほしい	\N	\N	\N
600	住所	1	し	\N
601	東京都	\N	\N	\N
602	府中市	\N	\N	\N
603	朝日町	\N	\N	\N
604	卒業	\N	\N	\N
605	決まりました	\N	\N	\N
606	商社	\N	\N	\N
607	決まった	\N	\N	\N
608	おめでとうございます	\N	\N	\N
609	将来	\N	\N	\N
610	海外	1	か	\N
611	働きたい	\N	\N	\N
612	行きたい	\N	\N	\N
613	ビジネス英語	\N	\N	\N
614	勉強している	\N	\N	\N
615	お待たせ	\N	\N	\N
616	おめでとう	\N	\N	\N
617	母	1	は	\N
618	お世話になりました	\N	\N	\N
619	立派な	\N	\N	\N
620	社会人	\N	\N	\N
621	なって	\N	\N	\N
622	4年間	\N	\N	\N
623	～年間	\N	\N	\N
624	です	\N	\N	\N
625	。	\N	\N	\N
626	ます	\N	\N	\N
627	ん	\N	\N	\N
628	学生	1	か	\N
629	春	1	は	\N
630	田中	\N	\N	\N
631	キム	\N	\N	\N
632	さん	\N	\N	\N
633	が	\N	\N	\N
634	父	1	ち	\N
635	休み	1	や	\N
636	山田	\N	\N	\N
637	リーダー	\N	\N	\N
638	、	\N	\N	\N
639	１	\N	\N	\N
640	位	\N	\N	\N
641	中山	\N	\N	\N
642	大学生	\N	\N	\N
643	か	\N	\N	\N
644	山口	\N	\N	\N
645	東京	\N	\N	\N
646	晴れ	1	は	\N
647	た	\N	\N	\N
648	むかし	\N	\N	\N
649	公園	1	こ	\N
650	お昼	\N	\N	\N
651	おにぎり	\N	\N	\N
652	きのう	\N	\N	\N
653	かう	\N	\N	\N
654	犬	1	い	\N
655	いる	\N	\N	\N
656	ペン	1	へ	\N
657	ノート	1	の	\N
658	誰	\N	\N	\N
659	もう(2)	1	も	\N
660	よ	\N	\N	\N
661	部屋	1	へ	\N
662	パソコン	\N	\N	\N
663	家	1	い	\N
664	教室	1	き	\N
665	みなさん	\N	\N	\N
666	質問	1	し	\N
667	お金	1	お	\N
668	太郎	\N	\N	\N
669	ロックコンサート	\N	\N	\N
670	上	1	う	\N
671	下	1	し	\N
672	前	1	ま	\N
673	うし	\N	\N	\N
674	ろ	\N	\N	\N
675	中	1	な	\N
676	外	1	そ	\N
677	右	1	み	\N
678	左	1	ひ	\N
679	かばん	1	か	\N
680	木村	\N	\N	\N
681	猫	1	ね	\N
682	ポスト	1	ほ	\N
683	向かい	\N	\N	\N
684	埼玉	\N	\N	\N
685	北	1	き	\N
686	近く	1	ち	\N
687	体育館	\N	\N	\N
688	プール	1	ふ	\N
689	はさみ	\N	\N	\N
690	数学	\N	\N	\N
691	教科書	\N	\N	\N
692	２	\N	\N	\N
693	～階	1	か	\N
694	新聞	1	し	\N
695	東京外国語大学	\N	\N	\N
696	秋	1	あ	\N
697	４つ	\N	\N	\N
698	季節	\N	\N	\N
699	人	1	ひ	\N
700	友だち	\N	\N	\N
701	新しい	1	あ	\N
702	コンピューター	1	こ	\N
703	箱	1	は	\N
704	小さい	1	ち	\N
705	元気	1	け	\N
706	すてき	\N	\N	\N
707	絵	1	え	\N
708	よう	\N	\N	\N
709	かん	\N	\N	\N
710	食べ物	1	た	\N
711	あまい	\N	\N	\N
712	おかし	\N	\N	\N
713	古い	1	ふ	\N
714	じょうぶ	\N	\N	\N
715	CD	\N	\N	\N
716	静か	1	し	\N
717	靴	1	く	\N
718	を	\N	\N	\N
719	買います	1	か	\N
720	黒い	1	く	\N
721	すき	\N	\N	\N
722	辞書	1	し	\N
723	年生	\N	\N	\N
724	図書	\N	\N	\N
725	事務	\N	\N	\N
726	きれい	1	き	\N
727	女	1	お	\N
728	山本	\N	\N	\N
729	大きい	1	お	\N
730	消しゴム	\N	\N	\N
731	トイレ	1	と	\N
732	ござる	\N	\N	\N
733	ぼうし	\N	\N	\N
734	あなた	1	あ	\N
735	さる	\N	\N	\N
736	かさ	\N	\N	\N
737	５	\N	\N	\N
738	ケーキ	1	け	\N
739	７つ	\N	\N	\N
740	ボールペン	1	ほ	\N
741	～円	1	え	\N
742	～冊	1	さ	\N
743	雑誌	1	さ	\N
744	ボール	\N	\N	\N
745	いくつ	1	い	\N
746	ハンカチ	1	は	\N
747	～枚	1	ま	\N
748	３	\N	\N	\N
749	くらい	\N	\N	\N
751	何時	\N	\N	\N
752	４	\N	\N	\N
753	～分	1	ふ	\N
754	きょう	\N	\N	\N
755	月	\N	\N	\N
756	あした	\N	\N	\N
757	曜日	\N	\N	\N
758	日曜日	1	に	\N
759	勉強	1	へ	\N
760	する	0	す	\N
761	テレビ	1	て	\N
762	ピアノ	1	ひ	\N
763	研究	\N	\N	\N
764	パーティー	1	は	\N
765	小説	\N	\N	\N
766	から	\N	\N	\N
767	休みます (1)	1	や	\N
768	聞き手	\N	\N	\N
769	’	\N	\N	\N
770	A	\N	\N	\N
771	：	\N	\N	\N
772	門	1	も	\N
773	地震	\N	\N	\N
774	降ります	1	ふ	\N
775	終わります	1	お	\N
776	B	\N	\N	\N
777	まだ	1	ま	\N
778	うち	1	う	\N
779	帰る	\N	\N	\N
780	ハンバーガー	\N	\N	\N
781	コーラ	1	こ	\N
782	飲みます	1	の	\N
783	サンドイッチ	\N	\N	\N
784	見ます	1	み	\N
785	手紙	1	て	\N
786	出します	1	た	\N
787	貸します	1	か	\N
788	借ります	1	か	\N
789	フランス語	\N	\N	\N
790	習います	1	な	\N
791	壁	1	か	\N
792	シール	\N	\N	\N
793	はる	\N	\N	\N
794	置きます	1	お	\N
795	見せます	1	み	\N
796	テニス	1	て	\N
797	誕生	\N	\N	\N
798	りんご	\N	\N	\N
799	寒い	1	さ	\N
800	おもしろい	1	お	\N
801	おいしい	1	お	\N
802	赤い	1	あ	\N
803	高い (2)	1	た	\N
804	北海道	\N	\N	\N
805	君	\N	\N	\N
806	あまり	1	あ	\N
807	広い	1	ひ	\N
808	つく	\N	\N	\N
809	れる	\N	\N	\N
810	あたり	\N	\N	\N
811	駅前	\N	\N	\N
812	服	1	ふ	\N
813	ハッピー	\N	\N	\N
814	髪	1	か	\N
815	背	1	せ	\N
816	力	\N	\N	\N
817	強い	1	つ	\N
818	痛い	1	い	\N
819	町	1	ま	\N
820	道	1	み	\N
821	狭い	1	せ	\N
822	色	1	い	\N
823	バスケットボール	\N	\N	\N
824	じょうず	\N	\N	\N
825	歌	1	う	\N
826	へた	\N	\N	\N
827	×	\N	\N	\N
828	気分	\N	\N	\N
829	お父さん	1	お	\N
830	よい	\N	\N	\N
831	働きます	1	は	\N
832	医者	1	い	\N
833	電子	\N	\N	\N
834	便利	1	へ	\N
835	小林	\N	\N	\N
836	読みます	1	よ	\N
837	ごはん	\N	\N	\N
838	お願い	\N	\N	\N
839	立ちます	1	た	\N
840	窓	1	ま	\N
841	開きます	1	あ	\N
842	毎朝	1	ま	\N
843	ジョギング	\N	\N	\N
844	～年	1	ね	\N
845	知ります	1	し	\N
846	曲がります	1	ま	\N
847	ビル	\N	\N	\N
848	そびえる	\N	\N	\N
849	似る	\N	\N	\N
850	まり	\N	\N	\N
851	買い物	1	か	\N
852	閉めます	1	し	\N
853	電気	1	て	\N
854	消します	1	け	\N
855	駅	1	え	\N
856	ホーム	\N	\N	\N
857	ポスター	\N	\N	\N
858	問題	1	も	\N
859	～ページ	1	へ	\N
860	書きます	1	か	\N
861	切ります(1)	1	き	\N
862	う	\N	\N	\N
863	開けます	1	あ	\N
864	"	\N	\N	\N
865	話します	1	は	\N
866	調べる	\N	\N	\N
867	パン	1	は	\N
868	サラダ	\N	\N	\N
869	月曜日	1	け	\N
870	サッカー	1	さ	\N
871	［	\N	\N	\N
872	漫画	\N	\N	\N
873	や	\N	\N	\N
874	デパート	1	て	\N
875	スーパー	1	す	\N
876	局	\N	\N	\N
877	卵	1	た	\N
878	ベッド	1	へ	\N
879	アパート	1	あ	\N
880	住みます	1	す	\N
881	留学生	1	り	\N
882	金	\N	\N	\N
883	→	\N	\N	\N
884	中村	\N	\N	\N
885	親切	\N	\N	\N
886	若い	1	わ	\N
887	お	\N	\N	\N
888	金持ち	\N	\N	\N
889	靴下	1	く	\N
890	めがね	\N	\N	\N
891	かける	\N	\N	\N
892	難しい	1	む	\N
893	できます (1)	1	て	\N
894	たり	\N	\N	\N
895	泳ぎます	1	お	\N
896	だり	\N	\N	\N
897	弟	1	お	\N
898	飛行機	1	ひ	\N
899	大阪	\N	\N	\N
900	行う	\N	\N	\N
901	たる	\N	\N	\N
902	やむ	\N	\N	\N
903	会います	1	あ	\N
904	いっしょ	\N	\N	\N
905	コンサート	1	こ	\N
906	くださる	\N	\N	\N
907	７	\N	\N	\N
908	起きます	1	お	\N
909	食堂	1	し	\N
910	８	\N	\N	\N
911	すもう	\N	\N	\N
912	たい	\N	\N	\N
913	２つ	\N	\N	\N
914	折る	\N	\N	\N
915	座ります	1	す	\N
916	弁当	0	へ	\N
917	歩きます	1	あ	\N
918	テープ	1	て	\N
919	聞く	\N	\N	\N
920	海	1	う	\N
921	ダイビング	\N	\N	\N
922	山	1	や	\N
923	登ります	1	の	\N
924	野球	1	や	\N
925	試合	1	し	\N
926	台風	1	た	\N
927	電車	1	て	\N
928	止まります	1	と	\N
929	庭	1	に	\N
930	始める	\N	\N	\N
931	顔	1	か	\N
932	洗います	1	あ	\N
933	暖かい	\N	\N	\N
934	運動会	\N	\N	\N
935	だけ	\N	\N	\N
936	ばかり	\N	\N	\N
937	テスト	1	て	\N
938	空	1	そ	\N
939	青い	1	あ	\N
940	最初	\N	\N	\N
941	楽しい	1	た	\N
942	過ごす	\N	\N	\N
943	あらし	\N	\N	\N
944	走ります	1	は	\N
945	拍手	\N	\N	\N
946	写真	1	し	\N
947	ゴミ箱	\N	\N	\N
948	ごみ	\N	\N	\N
949	捨てる	\N	\N	\N
950	ほえる	\N	\N	\N
951	相談	\N	\N	\N
952	乗ります	1	の	\N
953	集まる	\N	\N	\N
954	氷	\N	\N	\N
955	政治	\N	\N	\N
956	せる	\N	\N	\N
957	ほめる	\N	\N	\N
958	られる	\N	\N	\N
959	お母さん	1	お	\N
960	見つかる	\N	\N	\N
961	教わる	\N	\N	\N
962	ズボン	1	す	\N
963	すぎる	\N	\N	\N
964	～回	1	か	\N
965	袋	\N	\N	\N
966	ずつ	\N	\N	\N
967	泊まる	\N	\N	\N
968	建てる	\N	\N	\N
969	咲きます	1	さ	\N
970	今年	1	こ	\N
971	３月	\N	\N	\N
972	シャツ	1	し	\N
973	えんぴつ	\N	\N	\N
974	字	1	し	\N
975	佐藤	\N	\N	\N
976	さ	\N	\N	\N
977	びっくり	\N	\N	\N
978	カラオケ	1	か	\N
979	歌います	1	う	\N
980	声	1	こ	\N
981	南	1	み	\N
982	飛びます	1	と	\N
983	ぶどう	\N	\N	\N
984	ワイン	\N	\N	\N
985	作る	\N	\N	\N
986	贈る	\N	\N	\N
987	説明	\N	\N	\N
988	鈴木	\N	\N	\N
989	よる	\N	\N	\N
990	年上	\N	\N	\N
991	白線	\N	\N	\N
992	より	\N	\N	\N
993	入ります	1	は	\N
994	世界	\N	\N	\N
995	川	\N	\N	\N
996	ナイル	\N	\N	\N
997	４月	\N	\N	\N
998	５月	\N	\N	\N
999	片道	\N	\N	\N
1000	往復	\N	\N	\N
1001	十分	\N	\N	\N
1002	バス	1	は	\N
1003	病気	1	ひ	\N
1004	遅れる	\N	\N	\N
1005	はだし	\N	\N	\N
1006	はだかる	\N	\N	\N
1007	一人	1	ひ	\N
1008	家族	1	か	\N
1009	全員	\N	\N	\N
1010	ドライブ	\N	\N	\N
1011	年間	\N	\N	\N
1012	上手	1	し	\N
1013	万	1	ま	\N
1014	警察	\N	\N	\N
1015	事件	\N	\N	\N
1016	クラス	1	く	\N
1017	出かける	\N	\N	\N
1018	やります	1	や	\N
1019	違います	1	ち	\N
1020	～とき	1	と	\N
1021	「	\N	\N	\N
1022	」	\N	\N	\N
1023	書類	\N	\N	\N
1024	地図	1	ち	\N
1025	ハンバーグ	\N	\N	\N
1026	赤	1	あ	\N
1027	いばら	\N	\N	\N
1028	かしこまる	\N	\N	\N
1029	会話	\N	\N	\N
1030	手	1	て	\N
1031	あげる	\N	\N	\N
1032	名前	1	な	\N
1033	わかる	\N	\N	\N
1034	どうか	\N	\N	\N
1035	ゆるす	\N	\N	\N
1036	助ける	\N	\N	\N
1037	待ちます	1	ま	\N
1038	がんばる	\N	\N	\N
1039	安心	\N	\N	\N
1040	ぜひ	\N	\N	\N
1041	もう一度	\N	\N	\N
1042	機	\N	\N	\N
1043	いける	\N	\N	\N
1044	携帯	\N	\N	\N
1045	たばこ	1	た	\N
1046	しばらく	\N	\N	\N
1047	酒	0	さ	\N
1048	だめ	1	た	\N
1049	ちゃ	\N	\N	\N
1050	泣く	\N	\N	\N
1051	すう	\N	\N	\N
1052	ふろ	0	ふ	\N
1053	スイッチ	1	す	\N
1054	おこる	\N	\N	\N
1055	殺す	\N	\N	\N
1056	不合格	\N	\N	\N
1057	心配	\N	\N	\N
1058	気	\N	\N	\N
1059	遠慮	\N	\N	\N
1060	ジーンズ	\N	\N	\N
1061	解答	\N	\N	\N
1062	スケート	\N	\N	\N
1063	午後	1	こ	\N
1064	信号	\N	\N	\N
1065	青	1	あ	\N
1066	さあ	1	さ	\N
1067	渡ります	1	わ	\N
1068	横断	\N	\N	\N
1069	歩道	\N	\N	\N
1070	遊び	\N	\N	\N
1071	アルバイト	\N	\N	\N
1072	日記	\N	\N	\N
1073	昼食	\N	\N	\N
1074	掃除	1	そ	\N
1075	荷物	1	に	\N
1076	持ちます	1	も	\N
1077	この辺	\N	\N	\N
1078	６	\N	\N	\N
1079	西	1	に	\N
1080	沈む	\N	\N	\N
1081	散る	\N	\N	\N
1082	早い	1	は	\N
1083	思う	\N	\N	\N
1084	留学	\N	\N	\N
1085	今晩	1	こ	\N
1086	手洗い	\N	\N	\N
1087	したがう	\N	\N	\N
1088	みんな	1	み	\N
1089	発表	\N	\N	\N
1090	ほしい	\N	\N	\N
1091	｛	\N	\N	\N
1092	｝	\N	\N	\N
1093	自転車	1	し	\N
1094	白い	1	し	\N
1095	紙	1	か	\N
1096	がる	\N	\N	\N
1097	入り用	\N	\N	\N
1098	よろしい	\N	\N	\N
1099	スポーツ	1	す	\N
1100	水泳	\N	\N	\N
1101	きらい	\N	\N	\N
1102	つらい	\N	\N	\N
1103	こわい	\N	\N	\N
1104	K	\N	\N	\N
1105	くん	\N	\N	\N
1106	らしい	\N	\N	\N
1107	いつも	1	い	\N
1108	こわがる	\N	\N	\N
1109	～メートル	1	め	\N
1110	アラビア	\N	\N	\N
1111	～語	1	こ	\N
1112	書ける	\N	\N	\N
1113	さす	\N	\N	\N
1114	行ける	\N	\N	\N
1115	彼	\N	\N	\N
1116	一生	\N	\N	\N
1117	愛せる	\N	\N	\N
1118	晴れます	1	は	\N
1119	チーム	\N	\N	\N
1120	勝つ	\N	\N	\N
1121	たぶん	1	た	\N
1122	外語	\N	\N	\N
1123	店員	1	て	\N
1124	？	\N	\N	\N
1125	さっき	\N	\N	\N
1126	ほら	\N	\N	\N
1127	コンビニ	\N	\N	\N
1128	かも	\N	\N	\N
1129	しれる	\N	\N	\N
1130	ごろ	\N	\N	\N
1131	もしか	\N	\N	\N
1132	兄さん	\N	\N	\N
1133	今ごろ	\N	\N	\N
1134	ひま	\N	\N	\N
1135	ちがう	\N	\N	\N
1136	田村	\N	\N	\N
1137	時計	1	と	\N
1138	きっと	\N	\N	\N
1139	妹	1	い	\N
1140	事故	\N	\N	\N
1141	はず	\N	\N	\N
1142	教師	\N	\N	\N
1143	話せる	\N	\N	\N
1144	○	\N	\N	\N
1145	ちがい	\N	\N	\N
1146	日常	\N	\N	\N
1147	さえ	\N	\N	\N
1148	うり	\N	\N	\N
1149	様子	\N	\N	\N
1150	データ	\N	\N	\N
1151	考える	\N	\N	\N
1152	増える	\N	\N	\N
1153	続ける	\N	\N	\N
1154	甘い	1	あ	\N
1155	まるで	\N	\N	\N
1156	鳥	1	と	\N
1157	ロボット	\N	\N	\N
1158	生きる	\N	\N	\N
1159	動く	\N	\N	\N
1160	歌手	\N	\N	\N
1161	どうやら	\N	\N	\N
1162	来月	1	ら	\N
1163	生徒	1	せ	\N
1164	天気	1	て	\N
1165	予報	\N	\N	\N
1166	骨	\N	\N	\N
1167	ら	\N	\N	\N
1168	しいる	\N	\N	\N
1169	レントゲン	\N	\N	\N
1170	撮ります	1	と	\N
1171	うわさ	\N	\N	\N
1172	歌舞伎	\N	\N	\N
1173	ふる	\N	\N	\N
1174	作文	1	さ	\N
1175	提出	\N	\N	\N
1176	通る	\N	\N	\N
1177	コーヒー	1	こ	\N
1178	紅茶	1	こ	\N
1179	優秀	\N	\N	\N
1180	自慢	\N	\N	\N
1181	合格	\N	\N	\N
1182	聞こえる	\N	\N	\N
1183	進学	\N	\N	\N
1184	勧める	\N	\N	\N
1185	カメラ	1	か	\N
1186	つける	\N	\N	\N
1187	祭日	\N	\N	\N
1188	くすり	\N	\N	\N
1189	番号	1	は	\N
1190	蛍	\N	\N	\N
1191	光	\N	\N	\N
1192	流れる	\N	\N	\N
1193	閉まります	1	し	\N
1194	かぜ	\N	\N	\N
1195	一生懸命	\N	\N	\N
1196	落ちる	\N	\N	\N
1197	メロン	\N	\N	\N
1198	けれども	\N	\N	\N
1199	覚えます	1	お	\N
1200	おなか	1	お	\N
1201	すく	\N	\N	\N
1202	通り	\N	\N	\N
1203	夜	1	よ	\N
1204	京都	\N	\N	\N
1205	けれど	\N	\N	\N
1206	けど	\N	\N	\N
1207	じゃま	\N	\N	\N
1208	～辺	1	へ	\N
1209	もらえる	\N	\N	\N
1210	解ける	\N	\N	\N
1211	押します	1	お	\N
1212	ドア	1	と	\N
1213	点	\N	\N	\N
1214	以上	\N	\N	\N
1215	ちり	\N	\N	\N
1216	つもる	\N	\N	\N
1217	エアコン	\N	\N	\N
1218	すぐ／すぐに	1	す	\N
1219	返事	\N	\N	\N
1220	近い	1	ち	\N
1221	嫌	1	い	\N
1222	やめる	\N	\N	\N
1223	インターネット	\N	\N	\N
1224	なくなる	\N	\N	\N
1225	もし	\N	\N	\N
1226	新入生	\N	\N	\N
1227	たくさん	1	た	\N
1228	さえる	\N	\N	\N
1229	たとえ	\N	\N	\N
1230	しかた	\N	\N	\N
1231	落とす	\N	\N	\N
1232	ぬれる	\N	\N	\N
1233	こわれる	\N	\N	\N
1234	選ぶ	\N	\N	\N
1235	おどろく	\N	\N	\N
1236	し	\N	\N	\N
1237	プレゼント	\N	\N	\N
1238	もらう	\N	\N	\N
1239	おみやげ	\N	\N	\N
1240	△	\N	\N	\N
1241	請求	\N	\N	\N
1242	渡します	1	わ	\N
1243	さしあげる	\N	\N	\N
1244	いただく	\N	\N	\N
1245	紹介	\N	\N	\N
1246	使い方	\N	\N	\N
1247	息子	\N	\N	\N
1248	てぶくろ	\N	\N	\N
1249	あむ	\N	\N	\N
1250	運ぶ	\N	\N	\N
1251	ため	\N	\N	\N
1252	詩	\N	\N	\N
1253	代わる	\N	\N	\N
1254	手伝う	\N	\N	\N
1255	送る	\N	\N	\N
1256	おかす	\N	\N	\N
1257	知らせ	\N	\N	\N
1258	推薦	\N	\N	\N
1259	貸し	\N	\N	\N
1260	高校	\N	\N	\N
1261	学ぶ	\N	\N	\N
1262	そちら	1	そ	\N
1263	飲み物	1	の	\N
1264	時間	1	し	\N
1265	ニュース	1	に	\N
1266	夕飯	1	ゆ	\N
1267	古本	\N	\N	\N
1268	売ります	1	う	\N
1269	みる	\N	\N	\N
1270	ジュース	\N	\N	\N
1271	着ます	1	き	\N
1272	いつか	\N	\N	\N
1273	南極	\N	\N	\N
1274	教授	\N	\N	\N
1275	言語	\N	\N	\N
1276	学	\N	\N	\N
1277	先日	\N	\N	\N
1278	こう	\N	\N	\N
1279	って	\N	\N	\N
1280	たいした	\N	\N	\N
1281	もん	\N	\N	\N
1282	プリント	\N	\N	\N
1283	先週	1	せ	\N
1284	毎回	\N	\N	\N
1285	目標	\N	\N	\N
1286	星	\N	\N	\N
1287	兄	1	あ	\N
1288	員	\N	\N	\N
1289	ご	\N	\N	\N
1290	頼みます	1	た	\N
1291	明ける	\N	\N	\N
1292	始まり	\N	\N	\N
1293	召し上がる	\N	\N	\N
1294	読み	\N	\N	\N
1295	中田	\N	\N	\N
1296	降りる	\N	\N	\N
1297	あちら	1	あ	\N
1298	様	\N	\N	\N
1299	どちら	1	と	\N
1300	いらっしゃる	\N	\N	\N
1301	お忙しい	\N	\N	\N
1302	ご多忙	\N	\N	\N
1303	渡辺	\N	\N	\N
1304	社長	\N	\N	\N
1305	お宅	\N	\N	\N
1306	拝見	\N	\N	\N
1307	係員	\N	\N	\N
1308	案内	\N	\N	\N
1309	参る	\N	\N	\N
1310	うかがう	\N	\N	\N
1311	他社	\N	\N	\N
1312	社員	\N	\N	\N
1313	部下	\N	\N	\N
1314	ただいま	\N	\N	\N
1315	外出	\N	\N	\N
1316	おる	\N	\N	\N
1317	晩	1	は	\N
1318	看護	\N	\N	\N
1319	桜	\N	\N	\N
1320	リー	\N	\N	\N
1321	高校生	\N	\N	\N
1322	ながら	\N	\N	\N
1323	ふり	\N	\N	\N
1324	暗い	1	く	\N
1325	ところ	\N	\N	\N
1326	印刷	\N	\N	\N
1327	やさしい	\N	\N	\N
1328	そろそろ	\N	\N	\N
1329	寝ます	1	ね	\N
1330	い	\N	\N	\N
1331	こそ	\N	\N	\N
1332	会長	\N	\N	\N
1333	ふさわしい	\N	\N	\N
1334	全力	\N	\N	\N
1335	尽くす	\N	\N	\N
1336	結果	\N	\N	\N
1337	でる	\N	\N	\N
1338	しか	\N	\N	\N
1339	コアラ	\N	\N	\N
1340	ユーカリ	\N	\N	\N
1341	葉	\N	\N	\N
1342	引く	0	ひ	\N
1343	小泉	\N	\N	\N
1344	インタビュー	\N	\N	\N
1345	お茶	1	お	\N
1346	それでも	\N	\N	\N
1347	いそがしい	\N	\N	\N
1348	さんま	\N	\N	\N
1349	勝てる	\N	\N	\N
1350	くらう	\N	\N	\N
1351	ほど	\N	\N	\N
1352	富士山	\N	\N	\N
1353	エベレスト	\N	\N	\N
1354	二	\N	\N	\N
1355	十	1	し	\N
1356	歳	\N	\N	\N
1357	熱い	1	あ	\N
1358	どなた	1	と	\N
1359	/	\N	\N	\N
1360	かしら	\N	\N	\N
1361	経済	\N	\N	\N
1362	状態	\N	\N	\N
1363	眠い	\N	\N	\N
1364	こする	\N	\N	\N
1365	さわる	\N	\N	\N
1366	なあ	\N	\N	\N
1367	おや	\N	\N	\N
1368	まちがえる	\N	\N	\N
1369	ぞ	\N	\N	\N
1370	俺	\N	\N	\N
1371	ぜ	\N	\N	\N
1372	はねる	\N	\N	\N
1373	…	\N	\N	\N
1374	切手	1	き	\N
1375	はがき	1	は	\N
1376	午前	1	こ	\N
1377	時半	\N	\N	\N
1378	辛い	1	か	\N
1379	削除	\N	\N	\N
1380	削除	\N	\N	\N
1381	忘れます	1	わ	\N
1382	みがく	\N	\N	\N
1383	ビール	\N	\N	\N
1384	ふるさと	\N	\N	\N
1385	なつかしい	\N	\N	\N
1386	９	\N	\N	\N
1387	十字路	\N	\N	\N
1388	一	\N	\N	\N
1389	８月	\N	\N	\N
1390	９月	\N	\N	\N
1391	～番	1	は	\N
1392	大人	1	お	\N
1393	人気	\N	\N	\N
1394	チケット	\N	\N	\N
1396	えらい	\N	\N	\N
1397	美術館	\N	\N	\N
1398	ビートルズ	\N	\N	\N
1399	答え	1	こ	\N
1400	先月	1	せ	\N
1401	レストラン	1	れ	\N
1402	勤めます	1	つ	\N
1403	セーター	1	せ	\N
1404	通う	\N	\N	\N
1405	おしゃべり	\N	\N	\N
1406	魚	1	さ	\N
1407	焼く	\N	\N	\N
1408	におい	\N	\N	\N
1409	１つ	\N	\N	\N
1410	急ぐ	\N	\N	\N
1411	パスポート	1	は	\N
1412	鳴る	\N	\N	\N
1413	運動	\N	\N	\N
1414	象	\N	\N	\N
1415	鼻	1	は	\N
1416	鉛筆	1	え	\N
1417	ドイツ語	\N	\N	\N
1418	斉藤	\N	\N	\N
1419	限	\N	\N	\N
1420	お先に	\N	\N	\N
1421	失礼	\N	\N	\N
1422	分かります	1	わ	\N
1423	お返し	\N	\N	\N
1424	在学	\N	\N	\N
1425	証明	\N	\N	\N
1426	横	\N	\N	\N
1427	下さる	\N	\N	\N
1428	すむ	\N	\N	\N
1429	自己	\N	\N	\N
1430	初め	\N	\N	\N
1431	まして	\N	\N	\N
1432	申す	\N	\N	\N
1433	について	\N	\N	\N
1434	活動	\N	\N	\N
1435	ほう	\N	\N	\N
1436	寝込む	\N	\N	\N
1437	しまう	\N	\N	\N
1438	･･･	\N	\N	\N
1439	連絡	1	れ	\N
1440	良い	\N	\N	\N
1441	土産	\N	\N	\N
1442	遠慮ない	\N	\N	\N
1443	探す	\N	\N	\N
1444	注文	\N	\N	\N
1445	お待ち	\N	\N	\N
1446	,	\N	\N	\N
1447	いう	\N	\N	\N
1448	消費	\N	\N	\N
1449	税	\N	\N	\N
1450	取ります	1	と	\N
1451	ねえ	\N	\N	\N
1452	ぐらい	\N	\N	\N
1453	かかる	\N	\N	\N
1454	日間	\N	\N	\N
1455	～週間	1	し	\N
1456	自習	\N	\N	\N
1457	使える	\N	\N	\N
1458	伺う	\N	\N	\N
1459	一度に	\N	\N	\N
1460	ヶ月	\N	\N	\N
1461	期末	\N	\N	\N
1462	お送り	\N	\N	\N
1463	アウト	\N	\N	\N
1464	ける	\N	\N	\N
1465	自宅	\N	\N	\N
1466	半	1	は	\N
1467	お客	\N	\N	\N
1468	迎える	\N	\N	\N
1469	料	\N	\N	\N
1470	払う	\N	\N	\N
1471	会計	\N	\N	\N
1472	センター	\N	\N	\N
1473	小沢	\N	\N	\N
1474	｢	\N	\N	\N
1475	国際	\N	\N	\N
1476	法	\N	\N	\N
1477	村上	\N	\N	\N
1478	返却	\N	\N	\N
1479	赤ひげ	\N	\N	\N
1480	とか	\N	\N	\N
1481	大好き	1	た	\N
1482	祭	\N	\N	\N
1483	いっしょ	1	い	\N
1484	スタート	\N	\N	\N
1485	カード	1	か	\N
1486	けがす	\N	\N	\N
1487	なさる	\N	\N	\N
1488	大事	\N	\N	\N
1489	また	1	ま	\N
1490	ボート	\N	\N	\N
1491	約束	\N	\N	\N
1492	会	\N	\N	\N
1493	進む	\N	\N	\N
1494	募集	\N	\N	\N
1495	わあ	\N	\N	\N
1496	真剣	\N	\N	\N
1497	最終	\N	\N	\N
1498	申し訳	\N	\N	\N
1499	ほっと	\N	\N	\N
1500	学園	\N	\N	\N
1501	演奏	\N	\N	\N
1502	芝居	\N	\N	\N
1503	いろいろ(2)	1	い	\N
1504	連れる	\N	\N	\N
1505	す	\N	\N	\N
1506	昼休み	\N	\N	\N
1507	英	\N	\N	\N
1508	作	\N	\N	\N
1509	仕方	\N	\N	\N
1510	置き場	\N	\N	\N
1511	とめる	\N	\N	\N
1512	吉田	\N	\N	\N
1513	テーマ	\N	\N	\N
1514	載せる	\N	\N	\N
1515	かまう	\N	\N	\N
1516	いただける	\N	\N	\N
1517	野村	\N	\N	\N
1518	サークル	\N	\N	\N
1519	みたい	\N	\N	\N
1520	謝恩	\N	\N	\N
1521	予約	\N	\N	\N
1522	名	\N	\N	\N
1523	都	\N	\N	\N
1524	府中	\N	\N	\N
1525	市	\N	\N	\N
1526	決まる	\N	\N	\N
1527	ビジネス	\N	\N	\N
1528	待たす	\N	\N	\N
1529	浩二	\N	\N	\N
1530	お世話	\N	\N	\N
1531	りっぱ	1	り	\N
1532	社会	\N	\N	\N
1533	明るい	1	あ	\N
1534	上げます	1	あ	\N
1535	朝ごはん	1	あ	\N
1536	あさって	1	あ	\N
1537	遊びます	1	あ	\N
1538	暖かい	1	あ	\N
1539	頭	1	あ	\N
1540	厚い	1	あ	\N
1541	あっち	1	あ	\N
1542	姉	1	あ	\N
1543	あの(1)	1	あ	\N
1544	浴びます	1	あ	\N
1545	危ない	1	あ	\N
1548	あります(2)	1	あ	\N
1549	池	1	い	\N
1550	いす	1	い	\N
1551	忙しい	1	い	\N
1552	一	1	い	\N
1553	一日	1	い	\N
1554	五日	1	い	\N
1555	五つ	1	い	\N
1556	意味	1	い	\N
1557	入口	1	い	\N
1558	います	1	い	\N
1559	要ります	1	い	\N
1560	うしろ	1	う	\N
1561	薄い	1	う	\N
1562	生まれます	1	う	\N
1563	うるさい	1	う	\N
1564	上着	1	う	\N
1565	映画館	1	え	\N
1567	大きな	1	お	\N
1568	大勢	1	お	\N
1569	お菓子	1	お	\N
1570	奥さん	1	お	\N
1571	おじさん	1	お	\N
1572	おじいさん	1	お	\N
1573	お手洗い	1	お	\N
1574	男	1	お	\N
1575	男の子	1	お	\N
1576	おととい	1	お	\N
1577	おととし	1	お	\N
1578	お兄さん	1	お	\N
1579	お姉さん	1	お	\N
1580	おばさん	1	お	\N
1581	おばあさん	1	お	\N
1582	おふろ	1	お	\N
1583	おまわりさん	1	お	\N
1584	重い	1	お	\N
1585	降ります	1	お	\N
1586	女の子	1	お	\N
1587	外国人	1	か	\N
1588	階段	1	か	\N
1589	帰ります	1	か	\N
1590	かかります	1	か	\N
1591	かぎ	1	か	\N
1592	～か月	1	か	\N
1594	かけます (1)	1	か	\N
1595	傘	1	か	\N
1596	風	1	か	\N
1597	～方	1	か	\N
1598	かたかな	1	か	\N
1599	～月	1	か	\N
1600	カップ	1	か	\N
1601	家庭	1	か	\N
1602	角	1	か	\N
1603	花瓶	1	か	\N
1604	かぶります	1	か	\N
1605	火曜日	1	か	\N
1606	体	1	か	\N
1607	～がる	1	か	\N
1608	軽い	1	か	\N
1609	カレー	1	か	\N
1610	カレンダー	1	か	\N
1611	川	1	か	\N
1612	～側	1	か	\N
1613	かわいい	1	か	\N
1614	木	1	き	\N
1615	黄色	1	き	\N
1616	黄色い	1	き	\N
1617	消えます	1	き	\N
1618	聞きます (1)	1	き	\N
1619	ギター	1	き	\N
1620	汚い	1	き	\N
1621	喫茶店	1	き	\N
1622	切符	1	き	\N
1623	きのう	1	き	\N
1624	九	1	き	\N
1625	牛肉	1	き	\N
1626	牛乳	1	き	\N
1627	兄弟	1	き	\N
1628	嫌い	1	き	\N
1629	～キロ／キログラム	1	き	\N
1630	銀行	1	き	\N
1631	薬	1	く	\N
1632	果物	1	く	\N
1633	口	1	く	\N
1634	国 (1)	1	く	\N
1635	曇り	1	く	\N
1636	曇ります	1	く	\N
1637	～くらい／ぐらい	1	く	\N
1638	～グラム	1	く	\N
1639	黒	1	く	\N
1640	警官	1	け	\N
1641	けさ	1	け	\N
1642	結婚します	1	け	\N
1643	玄関	1	け	\N
1644	～個	1	こ	\N
1645	五	1	こ	\N
1646	交差点	1	こ	\N
1647	交番	1	こ	\N
1648	コート	1	こ	\N
1649	九日	1	こ	\N
1650	九つ	1	こ	\N
1651	答えます	1	こ	\N
1652	コップ	1	こ	\N
1653	ことば	1	こ	\N
1654	子ども	1	こ	\N
1655	ごはん	1	こ	\N
1656	コピーします	1	こ	\N
1657	～ころ／ごろ	1	こ	\N
1658	今週	1	こ	\N
1659	こんな	1	こ	\N
1660	～歳	1	さ	\N
1661	財布	1	さ	\N
1662	先	1	さ	\N
1663	さします	1	さ	\N
1664	砂糖	1	さ	\N
1666	さ来年	1	さ	\N
1667	三	1	さ	\N
1668	～さん	1	さ	\N
1669	散歩	1	さ	\N
1670	四	1	し	\N
1671	塩	1	し	\N
1672	しかし	1	し	\N
1673	七	1	し	\N
1674	自動車	1	し	\N
1675	死にます	1	し	\N
1678	シャワー	1	し	\N
1679	～中	1	ち	\N
1680	丈夫	1	し	\N
1681	しょうゆ	1	し	\N
1682	白	1	し	\N
1684	吸います	1	す	\N
1685	スカート	1	す	\N
1686	～すぎ	1	す	\N
1687	少ない	1	す	\N
1688	涼しい	1	す	\N
1689	～ずつ	1	す	\N
1690	ストーブ	1	す	\N
1691	スプーン	1	す	\N
1692	スリッパ	1	す	\N
1693	せっけん	1	せ	\N
1695	ゼロ	1	せ	\N
1696	千	1	せ	\N
1697	洗濯	1	せ	\N
1698	洗濯します	1	せ	\N
1699	掃除します	1	そ	\N
1700	そして	1	そ	\N
1701	そば	1	そ	\N
1702	それでは	1	そ	\N
1703	～台	1	た	\N
1704	大使館	1	た	\N
1705	大切	1	た	\N
1706	台所	1	た	\N
1707	タクシー	1	た	\N
1708	～だけ	1	た	\N
1709	～たち	1	た	\N
1710	縦	1	た	\N
1712	だれ	1	た	\N
1713	だれか	1	た	\N
1714	誕生日	1	た	\N
1715	だんだん	1	た	\N
1716	小さな	1	ち	\N
1717	地下鉄	1	ち	\N
1718	茶色	1	ち	\N
1719	ちゃわん	1	ち	\N
1720	一日	1	つ	\N
1721	疲れます	1	つ	\N
1722	着きます	1	つ	\N
1723	机	1	つ	\N
1724	作ります	1	つ	\N
1725	つけます (1)	1	つ	\N
1726	冷たい	1	つ	\N
1727	テーブル	1	て	\N
1728	テープレコーダー	0	て	\N
1729	出かけます	1	て	\N
1731	出口	1	て	\N
1732	戸	1	と	\N
1733	～度	1	と	\N
1734	動物	1	と	\N
1735	十	1	と	\N
1736	遠い	1	と	\N
1737	十日	1	と	\N
1738	時々	1	と	\N
1739	所	1	と	\N
1740	年	1	と	\N
1741	どっち	1	と	\N
1742	隣	1	と	\N
1743	どの	1	と	\N
1744	とり肉	1	と	\N
1746	ナイフ	1	な	\N
1747	～ながら	1	な	\N
1748	泣きます	1	な	\N
1749	なくします	1	な	\N
1750	～など	1	な	\N
1751	七つ	1	な	\N
1752	七日	1	な	\N
1753	並びます	1	な	\N
1754	並べます	1	な	\N
1755	なります	1	な	\N
1756	二	1	に	\N
1757	にぎやか	1	に	\N
1758	肉	1	に	\N
1759	～日	1	に	\N
1760	脱ぎます	1	ぬ	\N
1762	ネクタイ	1	ね	\N
1763	歯	1	は	\N
1764	～杯	1	は	\N
1765	灰皿	1	は	\N
1766	はきます	1	は	\N
1767	橋	1	は	\N
1768	はし	0	は	\N
1769	始まります	1	は	\N
1770	初め／初めに	1	は	\N
1772	二十歳	1	は	\N
1773	八	1	は	\N
1774	二十日	1	は	\N
1775	花	1	は	\N
1776	話	1	は	\N
1777	速い	1	は	\N
1778	はります	1	は	\N
1779	晩ごはん	1	は	\N
1780	半分	1	は	\N
1781	東	1	ひ	\N
1782	～匹	1	ひ	\N
1783	弾きます	1	ひ	\N
1784	低い	1	ひ	\N
1785	一つ	1	ひ	\N
1786	ひとつき	0	ひ	\N
1787	暇	1	ひ	\N
1788	百	1	ひ	\N
1789	ひらがな	1	ひ	\N
1790	昼	1	ひ	\N
1791	昼ごはん	1	ひ	\N
1792	フィルム	1	ふ	\N
1793	封筒	1	ふ	\N
1794	フォーク	1	ふ	\N
1795	吹きます	1	ふ	\N
1796	二つ	1	ふ	\N
1797	ぶた肉	1	ふ	\N
1798	二人	1	ふ	\N
1799	二日	1	ふ	\N
1800	太い	1	ふ	\N
1801	冬	1	ふ	\N
1803	下手	1	へ	\N
1804	ペット	1	へ	\N
1805	勉強します	1	へ	\N
1806	ほう	1	ほ	\N
1807	帽子	1	ほ	\N
1808	ポケット	1	ほ	\N
1809	欲しい	1	ほ	\N
1810	細い	1	ほ	\N
1811	本棚	1	ほ	\N
1812	毎週	1	ま	\N
1813	毎月	1	ま	\N
1814	毎年	1	ま	\N
1815	毎晩	1	ま	\N
1816	まずい	1	ま	\N
1817	まっすぐ	1	ま	\N
1818	マッチ	1	ま	\N
1819	丸い	1	ま	\N
1821	磨きます	1	み	\N
1822	短い (1)	1	み	\N
1823	水	1	み	\N
1824	三日	1	み	\N
1825	三つ	1	み	\N
1826	緑	1	み	\N
1827	耳	1	み	\N
1828	六日	1	む	\N
1829	向こう	1	む	\N
1830	六つ	1	む	\N
1831	村	1	む	\N
1832	目	1	め	\N
1833	眼鏡	1	め	\N
1834	木曜日	1	も	\N
1835	もっと	1	も	\N
1836	物	1	も	\N
1837	～屋	1	や	\N
1838	八百屋	1	や	\N
1839	野菜	1	や	\N
1840	易しい	1	や	\N
1841	八つ	1	や	\N
1842	夕方	1	ゆ	\N
1843	郵便局	1	ゆ	\N
1844	ゆうべ	1	ゆ	\N
1845	有名	1	ゆ	\N
1846	雪	1	ゆ	\N
1847	ゆっくり	1	ゆ	\N
1848	八日	1	よ	\N
1849	洋服	1	よ	\N
1850	四日	1	よ	\N
1851	呼びます(1)	1	よ	\N
1852	弱い	1	よ	\N
1853	ラジオ	1	ら	\N
1854	ラジカセ	1	ら	\N
1855	両親	1	り	\N
1856	旅行します	1	り	\N
1857	零	1	れ	\N
1858	冷蔵庫	1	れ	\N
1860	練習します	1	れ	\N
1861	廊下	1	ろ	\N
1862	六	1	ろ	\N
1864	お弁当	1	お	\N
1865	散歩します	1	さ	\N
1866	～人	1	し	\N
1867	不動産屋	1	ふ	\N
1868	お皿	1	お	\N
1869	お酒	1	お	\N
1870	美容院	1	ひ	\N
1871	ください (1)	1	く	\N
1872	ほか	1	ほ	\N
1873	高い (1)	1	た	\N
1874	大変(2)	1	た	\N
1875	よく(2)	1	よ	\N
1876	四	1	よ	\N
1877	七	1	な	\N
1878	九	1	く	\N
1879	～キロ／キロメートル	1	き	\N
1880	～人	0	ひ	\N
1881	～本	1	ほ	\N
1882	～前	1	ま	\N
1883	～時間	1	し	\N
1884	～時	1	し	\N
1885	時	0	と	\N
1886	かけます (2)	1	か	\N
1887	文	1	ふ	\N
1888	のど	1	の	\N
1889	します (1)	1	し	\N
1890	ひきます	1	ひ	\N
1891	美容師	1	ひ	\N
1892	シャンプー	1	し	\N
1893	駅員	1	え	\N
1894	電話番号	1	て	\N
1895	連絡します	1	れ	\N
1896	見つかります	1	み	\N
1897	聞きます (2)	1	き	\N
1898	家賃	1	や	\N
1899	探します	1	さ	\N
1900	定食	1	て	\N
1901	ミルク	1	み	\N
1902	売り場	1	う	\N
1903	郵便局員	1	ゆ	\N
1904	航空便	1	こ	\N
1905	船便	1	ふ	\N
1906	送ります	1	お	\N
1907	スーツ	1	す	\N
1908	会社員	1	か	\N
1909	おはし	1	お	\N
1910	銀行員	1	き	\N
1911	窓口	1	ま	\N
1912	振り込み	1	ふ	\N
1913	遅い (2)	1	お	\N
1914	できます (2)	1	て	\N
1915	します (2)	1	し	\N
1916	休みます (2)	1	や	\N
1917	ください (2)	1	く	\N
1918	つけます (2)	1	つ	\N
1919	短い (2)	1	み	\N
1920	長い (2)	1	な	\N
1921	ガイド	1	か	\N
1922	泊まります	1	と	\N
1923	お土産	1	お	\N
1924	～人	1	に	\N
1925	ご主人	1	こ	\N
1926	妹さん	1	い	\N
1927	弟さん	1	お	\N
1928	入れます(2)	1	い	\N
1929	切ります(2)	1	き	\N
1930	来ます	1	き	\N
1931	国 (2)	1	く	\N
1932	あとで	1	あ	\N
1933	何	1	な	\N
1934	やめます	1	や	\N
1935	もらいます	1	も	\N
1936	心配します	1	し	\N
1937	携帯電話	1	け	\N
1938	あげます	1	あ	\N
1939	いろいろ(1)	1	い	\N
1940	呼びます(2)	1	よ	\N
1941	続きます	1	つ	\N
1942	確認します	1	か	\N
1943	思います	1	お	\N
1944	反対	1	は	\N
1945	音	1	お	\N
1946	グループ	1	く	\N
1947	きゅう	0	き	\N
1676	字引	0	し	\N
1677	しめます	0	し	\N
1683	－人	0	し	\N
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
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: ja_zt
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, ptoken, inst_id) FROM stdin;
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ja_zt
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

