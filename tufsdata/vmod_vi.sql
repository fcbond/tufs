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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO vi;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO vi;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO vi;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: vi
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


ALTER TABLE public.t_instance OWNER TO vi;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO vi;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO vi;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: vi
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


ALTER TABLE public.t_usage_classified_rel OWNER TO vi;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: vi
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


ALTER TABLE public.t_usage_inst_rel OWNER TO vi;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO vi;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO vi;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: vi
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO vi;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: vi
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


ALTER TABLE public.t_word_inst_rel OWNER TO vi;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: vi
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO vi;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: vi
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO vi;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: vi
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_index_char (id, index_char) FROM stdin;
1	A
3	Â
2	Ă
4	B
5	C
6	D
7	Đ
8	E
9	Ê
10	G
11	H
12	I
13	K
14	L
15	M
16	N
17	O
18	Ô
19	Ơ
20	P
21	Q
22	R
23	S
24	T
25	U
26	Ư
27	V
28	X
29	Y
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
93	Tôi đây.	私です	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
145	Trước đi học tôi mua báo.	×	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
202	= Thùng rác ở cạnh cái bàn.		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
686	không, linh	0	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
724	Tôi dậy lúc 7 giờ.	7時に起きました	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
975	mùa	季節	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1	Tôi là người Nhật.	私は日本人です	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
2	Đây là sầu riêng.	これはドリアンです	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
3	Tôi không phải là nhân viên công ty.	私は会社員ではありません	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
4	Ông ấy không phải là giáo sư.	彼は教師ではありません	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
5	Cái này không phải là từ điển.	これは辞書ではありません	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
6	Anh có phải là sinh viên không?	あなたは学生ですか	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
7	Vâng, tôi là sinh viên.	はい、私は学生です	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
8	Không, tôi không phải là sinh viên.	いいえ、私は学生ではありません	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
9	Chị ấy có phải là người Việt không?	彼女はベトナム人ですか	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
10	Vâng, chị ấy là người Việt.	はい、彼女はベトナム人です	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
11	Không, chị ấy không phải là người Việt.	いいえ、彼女はベトナム人ではありません	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
12	Chị ấy là đẹp.	×	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
13	Chị ấy đẹp.	○：彼女は美しい	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
14	Quyển sách này là mới.	×	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
15	Quyển sách này mới.	○：この本は新しい	null		\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
16	Từ điển này tốt.	この辞書はいいです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
17	Cái nhà này cao.	この家は（背丈が）高いです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
18	Từ điển này không tốt.	この辞書はよくないです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
19	Con voi kia có to không?	あの象は大きいですか	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
20	Cái nhà này đắt không?	この家は（値段が）高いですか。	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
21	Có, cái nhà này đắt.	はい、この家は（値段が）高いです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
22	Không, cái nhà này không đắt.	いいえ、 この家は（値段が）高くありません	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
23	Con mèo trắng này.	この白い猫 （名詞を修飾する場合）	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
24	Con mèo này trắng.	この猫は白いです （文の述語になる場合）	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
25	Con mèo trắng này xinh.	この白い猫はかわいいです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
26	Con mèo này trắng xinh.	×：指示詞 "này" の位置が違う	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
27	Chị Hoa rất đẹp.	ホアさんはとても綺麗です	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
28	Tiếng Việt rất dễ.	ベトナム語はとても簡単です	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
29	Sách này hay lắm.	この本はとても面白いです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
30	Cái này không đắt lắm.	これは（値段が）あまり高くないです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
31	Anh nói tiếng Việt giỏi quá!	あなたはベトナム語がとても上手です	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
32	Từ điển này tốt.	この辞書はかなりいいです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
33	Hôm nay trời hơi lạnh.	今日は少し寒いです	null		\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
34	Hoa này đẹp hơn hoa kia.	この花はあの花よりきれいです	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
35	Bà Tâm già hơn bà Cúc.	タムさんはクックさんより年をとっています	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
36	Xe đạp này tốt nhất.	この自転車が一番いいです	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
37	Trong lớp tôi, chị Hoa xinh nhất.	私のクラスでは、ホアさんが一番かわいいです	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
38	Cái cầu này dài bằng cái cầu kia.	この橋はあの橋と同じくらい長いです	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
39	Cái nhà này to bằng cái nhà kia.	この家はあの家と同じくらい大きいです	null		\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
40	Em hiểu.	僕は分かります	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
41	Tôi đi học.	私は学校に行く	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
42	Ông ấy nói tiếng Việt.	彼はベトナム語を話す	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
43	Em không hiểu.	僕は分かりません	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
44	Anh ấy không uống rượu.	彼は酒を飲まない	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
45	Chị ấy không nghe nhạc.	彼女は音楽を聴かない	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
46	Em có hiểu không?	君は分かりましたか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
47	Có, em hiểu.	はい、分かります	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
48	Không, em không hiểu.	いいえ、分かりません	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
49	Anh có uống rượu không?	あなたはお酒を飲みますか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
50	Chị có nghe nhạc không?	あなたは音楽を聴きますか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
51	Anh ăn cơm chưa?	ご飯を食べましたか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
52	Chị viết thư chưa?	手紙を書きましたか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
53	Em làm bài tập xong chưa?	宿題は終わりましたか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
54	Anh có ăn cơm chưa? 	ご飯を食べましたか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
55	Có, tôi ăn cơm rồi.	はい、もう食べました	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
56	Chưa, tôi chưa ăn cơm.	いいえ、まだ食べていません	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
57	Hiểu chưa?	分かった？	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
58	Hiểu rồi.	分かった	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
59	Anh ăn trưa chưa?	昼ごはん食べた？	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
60	Ăn rồi.	食べたよ	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
61	Anh không biết à?	知らないんですか	null		\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
62	Chị ấy nói gì?	彼女は何と言っていますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
63	Em làm gì?	君は何をしますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
64	Anh làm nghề gì?	あなたはどんな仕事をしていますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
65	Cái này tiếng Việt gọi là gì?	これはベトナム語で何と言いますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
66	Đây là cái gì?	これはなんですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
67	Chị thích cái gì?	あなたは何が好きですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
68	Cái gì cũng được.	なんでもいいです	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
69	Anh đi đâu ?	あなたはどこに行きますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
70	Bưu điện ở đâu?	郵便局はどこにありますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
71	Chị mua áo ở đâu?	どこで服を買いましたか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
72	Ông Tuấn ở đâu?	トゥアンさんはどこにいますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
73	Chị ấy là ai?	彼女は誰ですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
74	Ai vẽ bức tranh này?	誰がこの絵を描いたのですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
75	Ai đảm đương việc này?	誰がこの仕事を担当しますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
76	Em đi du lịch với ai?	誰と旅行に行くのですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
77	Anh gửi bưu phẩm này cho ai?	この小包を誰に送りますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
78	Khi nào anh đi Việt Nam?	いつベトナムに行きますか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
79	Anh đi Việt Nam khi nào?	いつベトナムに行きましたか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
80	Vì sao chị ăn ít thế?	どうして少ししか食べないのですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
81	Vì tôi bị đau dạ dày.	なぜなら胃が痛いからです	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
82	Tại sao em không đi học?	なぜ君は学校に来なかった	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
83	Vì em ngủ quên.	寝坊してしまったからです	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
84	Sao anh nói vậy?	なぜそう言うのですか	null		\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
85	Cái nhà này đẹp.	この家はきれいです	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
86	Quyển sách này hay.	この本は面白いです	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
87	Con chó kia chạy nhanh.	あの犬は早く走る	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
88	Ba chiếc xe đạp này tốt.	この3台の自転車はいいです	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
89	Tôi có 3 bức ảnh của anh.	私はあなたの写真を3枚持っています	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
90	5 chiếc bút bi này rất rẻ.	この5本のボールペンはとても安いです	null		\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
91	3 con mèo trắng này	この3匹の白い猫	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
92	Ai bấm chuông đấy?	呼び鈴を押したのは誰？	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
94	Anh đi đâu đấy?	どこへ行くんですか	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
95	Alô, Nam gọi đây ạ.	もしもし、ナムです	null		\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
96	2 quả táo	2個のりんご	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
97	1 chiếc máy bay	1機の飛行機	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
98	3 quyển sách	3冊の本	null		\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
99	Năm nay anh bao nhiêu tuổi?	○：今年、あなたは何歳ですか	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
100	Năm nay anh là bao nhiêu tuổi?	×	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
101	Năm nay tôi 25 tuổi.	○：今年、私は２５歳です	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
102	Năm nay tôi là 25 tuổi.	×	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
103	Quyển sách này giá bao nhiêu tiền?	○：この本はいくらですか	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
104	Quyển sách này là giá bao nhiêu tiền?	×	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
105	Quyển sách này giá 50.000 (năm mươi nghìn) đồng.	○：この本は5万ドンです	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
106	Quyển sách này là giá 50.000 (năm mươi nghìn) đồng.	×	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
107	Giá bao nhiêu?	いくら？	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
108	= Bao nhiêu tiền?	いくら？	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
109	20 nghìn.	2万（ドン）だよ	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
687	trăm	100	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
110	Cái này bao nhiêu?	これいくら？	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
111	= Cái này giá bao nhiêu?	これいくら？	null		\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
112	Bây giờ là mấy giờ?	何時ですか	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
113	Bây giờ là 9 giờ.	9時です	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
114	Bây giờ mấy giờ rồi?	何時ですか	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
115	Bây giờ 12 giờ rồi.	12時です	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
116	Chị ngủ dậy lúc mấy giờ?	あなたは何時に起きましたか	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
117	Tôi dậy lúc 7 giờ.	7時に起きました	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
118	Mấy giờ anh đi học?	何時に学校に行きますか	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
119	Tôi đi học lúc 8 giờ.	8時に行きます	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
120	9 giờ 20 phút	○：9時20分	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
121	9 giờ 20	○：9時20分	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
122	9 giờ 12 phút	○：9時12分	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
123	9 giờ 12	△：実際には使われる場合が多くなっています	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
124	10 giờ rưỡi	10時半	null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
125	= 10 giờ 30 phút		null		\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
126	Hôm nay tôi đi làm lúc 10 giờ sáng.	今日は午前10時に仕事に行きます	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
127	Tôi đi ngủ lúc 10 giờ tối.	私は午後10時に寝ます	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
128	Hàng ngày mẹ tôi nấu cơm từ 5 giờ sáng.	母は毎日朝5時からご飯を作ります	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
129	5 giờ chiều tôi về nhà.	午後5時に家に帰ります	null		\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
130	Tôi học tiếng Anh 3 giờ một ngày.	私は1日に英語を3時間勉強します	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
131	Từ nhà em đến sân bay đi ô tô hết 2 giờ.	私の家から空港まで車で2時間かかります	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
132	Bây giờ là 8 giờ.	今は8時です	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
133	Tôi đi học lúc 7 giờ.	7時に学校へ行きます	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
134	Anh ấy làm việc từ 8 giờ sáng đến 5 giờ chiều.	彼は朝の8時から夕方の5時まで働いている	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
135	Tôi học tiếng Anh 3 tiếng một ngày.	私は1日に英語を3時間勉強します	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
136	Từ nhà em đến sân bay đi ô tô hết 2 tiếng.	私の家から空港まで車で2時間かかります	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
137	Từ đây đến ga Hà Nội đi bộ hết 10 phút.	ここからハノイ駅まで歩いて10分かかります	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
138	Từ nhà tôi đến trường đại học mất 5 phút.	家から大学まで歩いて5分かかります	null		\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
139	Trước giờ học tôi mua báo.	○：授業の前に新聞を買う	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
140	Trước khi giờ học tôi mua báo.	×	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
141	Trước thứ bảy tôi phải làm xong việc này.	土曜日までにこの仕事を終わらせなければならない	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
142	Trong tuần này cô Liên đến thăm nhà tôi.	今週中にリエン叔母さんが家に来る	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
143	Sau bữa ăn tôi uống chè.	食事の後、私はお茶を飲む	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
144	Trước khi đi học tôi mua báo.	○：学校に行く前に新聞を買う	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
146	Trước khi ăn sáng tôi đi tập thể dục.	朝ごはんを食べる前に運動しに行く	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
688	một trăm linh hai	102	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
147	Trong khi dùng thuốc anh không nên uống rượu.	薬を使っているときはお酒を飲まないほうがいい	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
148	Sau khi ăn cơm tôi uống chè.	ご飯を食べた後、私はお茶を飲む	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
149	Trước khi khách đến tôi phải dọn phòng.	お客さんが来る前に部屋を掃除しなければならない	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
150	Sau khi anh Anh đưa ra ý kiến công việc dần dần trở nên tốt đẹp.	アインさんが提案を出してから、事業はうまくいくようになった	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
151	Trong khi cô Lan ở bệnh viện chúng em thăm viếng cô nhiều lần.	ラン先生が入院している間、私たちはよくお見舞いに行った	null		\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
152	Tôi sẽ ở Phnôm Pênh 2 ngày.	私はプノンペンに2日います	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
153	3 ngày trước anh Nam chuyển nhà.	3 日前ナムさんは引っ越しました	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
154	Mấy hôm nay tôi không khỏe lắm.	ここ何日かあまり元気ではない	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
155	giữa tháng tư	4月の中ほど / 4月中旬	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
156	giữa năm 2000	2000年の中ごろ	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
157	ngày 30 tháng 4 năm 2000	2000年4月30日	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
158	ngày mồng 2 tháng 9 năm 2003	2003年9月2日	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
159	Trên trời có mặt trăng.	空に月が出ている	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
160	Năm nay tôi 23 tuổi.	今年私は23歳です	null		\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
161	thứ ba tuần trước	先週の火曜日	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
162	thứ tư tuần này	今週の水曜日	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
163	chủ nhật tuần sau	来週の日曜日	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
164	Hôm nay là ngày mồng 2.	今日は2日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
165	Hôm nay là ngày mồng 10. 	今日は10日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
166	Hôm nay là ngày 11.	今日は11日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
167	Hôm nay là ngày 31.	今日は31日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
168	Hôm nay là ngày mồng mấy?	今日は何日ですか	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
169	Hôm nay là ngày mồng 3.	今日は３日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
170	Hôm nay là ngày bao nhiêu?	今日は何日ですか	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
171	Hôm nay là ngày 25.	今日は２５日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
172	Hôm nay là ngày thứ mấy?	今日は何曜日ですか	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
173	Hôm nay là ngày thứ tư.	今日は水曜日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
174	Hôm nay là thứ mấy?	今日は何曜日ですか	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
175	Hôm nay là thứ bảy.	今日は土曜日です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
176	Tháng này là tháng mấy?	今月は何月ですか	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
177	Tháng này là tháng 11.	今月は11月です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
178	Năm nay là năm bao nhiêu?	今年は何年ですか	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
179	Năm nay là năm 2005.	今年は2005年です	null		\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
180	chiếc xe của tôi	私の車	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
181	sách của thư viện	図書館の本	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
182	nắp của hộp	箱の蓋	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
183	chân của con lợn	豚の足	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
184	đề nghị của nhân viên	職員の提案	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
185	tác phẩm của họa sĩ	画家の作品	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
186	nguyên nhân của vụ tai nạn ấy	その事故の原因	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
187	Cái này của anh ấy.	これは彼のです	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
188	Quyển sách này của chị Lan.	この本はランさんのものです	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
189	Cái này không phải của tôi.	これは私のではありません	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
190	Cái này của anh ấy, phải không?	これはあなたのでしょう？	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
191	Cái này của ai?	これは誰のですか	null		\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
192	Anh Tuấn viết được chữ Hán.	トゥアンさんは漢字を書けます	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
193	Anh ấy không ăn được cua.	彼はカニが食べられない	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
194	Tôi không thể sửa máy tính.	私はパソコンを直すことができない	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
195	Tôi chưa thể có kết luận.	まだ結論を出すことができない	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
196	Anh có thể đảm đương công việc này không?	この仕事を担当できますか	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
197	Chị có hát được bài hát này không?	この歌を歌うことができますか	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
198	Bố tôi biết lái xe.	私の父は車を運転できる	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
199	Tôi không biết đá bóng.	私はサッカーができない	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
200	Anh có biết bơi không?	あなたは泳げますか	null		\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
201	Bên cạnh cái bàn có thùng rác	机の横にゴミ箱がある	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
203	Bên cạnh con đường có tòa nhà.	道の横に家がある	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
204	= Tòa nhà ở cạnh con đường.		null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
205	Ngoài sân có xe máy.	庭にはバイクがある	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
206	Trong sân có xe máy.	庭にはバイクがある	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
207	Trên trời có đám mây.	空に雲がある	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
208	Dưới sông có nhiều lá cây.	川に木の葉がたくさん浮いている	null		\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
209	Anh là nhân viên công ty, phải không?	あなたは会社員ですね	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
210	Em sống ở Sài Gòn, phải không?	サイゴンに住んでいますね	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
211	Nhà này rất đẹp, phải không?	この家はきれいでしょう	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
212	Anh ấy không phải là người Việt, phải không?	彼はベトナム人ではないでしょう	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
213	Chị chưa làm bài tập, phải không?	まだ宿題をやっていませんね	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
214	Chị đi làm việc hay (là) đi chơi?	あなたは仕事に行きますか、遊びに行きますか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
215	Ông muốn mua cái nào, cái này hay (là) cái kia?	あなたはこれとあれのどちらを買いたいですか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
216	Chị ấy là người Trung Quốc hay là người Hàn Quốc?	彼女は中国人ですか、韓国人ですか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
217	Chị muốn ăn gì, phở hay là nem rán?	あなたはフォーと揚げ春巻きのどちらを食べたいですか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
218	Tôi muốn uống nước cam hay là nước xoài.	私はオレンジジュースかマンゴージュースを飲みたい	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
219	Bây giờ anh có muốn về nhà hay không?	今あなたは家に帰りたいですか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
220	Anh có đi uống bia hay không?	あなたはビールを飲みに行きますか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
221	Anh đã sửa xe đạp hay chưa? 	あなたはもう自転車を修理しましたか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
222	Anh đã làm bài tập hay chưa?	あなたはもう宿題をしましたか	null		\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
223	Anh phải hỏi ý kiến bố mẹ.	あなたは両親の意見を聞かなければなりません	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
224	Chị nên học tiếng Việt để nghiên cứu về Việt Nam.	あなたはベトナムについて研究するためにベトナム語を勉強するべきです	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
225	Anh không nên hút thuốc lá.	あなたはタバコを吸うべきではありません	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
226	Tôi cần mua một quyển từ điển Việt-Anh.	私は越英辞書を 1 冊買う必要があります	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
227	Hôm nay anh cần làm xong việc này.	今日、あなたはこの仕事をし終える必要があります	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
228	Tôi dám gọi điện cho chị ấy.	私は思い切って彼女に電話します	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
229	Tôi định mua hai cân cam và một cân nho.	私はオレンジ 2 キロとブドウ 1 キロを買うつもりです	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
230	Tôi có thể làm bài tập này.	私はこの練習問題をすることができます	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
231	Tôi muốn ăn phở.	私はフォーを食べたいです	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
232	Anh có muốn gặp chị ấy không ?	あなたは彼女に会いたいですか	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
233	Tôi thích nấu ăn.	私は料理するのが好きです	null		\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
234	Tôi đã làm bài tập.	私は宿題をやりました	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
235	Hôm qua tôi làm bài tập.	昨日私は宿題をやりました	null	この例では "Hôm qua" があるので "đã" を使わなくても過去形になります。	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
236	Hôm qua tôi đã làm bài tập.	昨日私はもう宿題をやっていました	null	この例では "Hôm qua" と "đã" を併用しているので、過去が強調されています。	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
237	Khi đến bệnh viện, bà ấy đã khỏe rồi.	病院に着いたとき、彼女はもう元気になっていた	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
238	Khi em vào trường đại học thì tôi đã về nước rồi.	あなたが大学に入るころには私は帰国してしまっているだろう	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
239	Tôi sẽ đi mua vé máy bay.	航空券を買いに行きます	null	時制詞を使った例	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
240	Chiều mai tôi đi mua vé máy bay.	明日の午後航空券を買いに行きます	null	時制詞を使わない例	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
241	Mẹ tôi đang nấu cơm.	母はご飯を作っています	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
242	Hôm qua khi tôi đang chuẩn bị đi, bạn tôi đến thăm nhà tôi.	昨日私が出かける準備をしているときに友人が家を訪ねてきた	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
243	Tôi vừa đọc hết cuốn sách này.	ちょうどこの本を読み終わったところです	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
244	Anh ấy mới sửa nhà xong.	家の修理が終わったばかりです	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
245	Cô ấy sắp lấy chồng.	彼女はもうすぐ結婚する	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
246	Quán ăn sắp mở cửa.	食堂はもうすぐ開店する	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
247	Liên hoan sắp bắt đầu chưa?	パーティーはもうすぐ始まりますか	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
248	Sắp, liên hoan sắp bắt đầu.	はい、もうすぐ始まります	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
249	Chưa, liên hoan chưa bắt đầu.	いいえ、まだ始まりません	null		\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
250	Giải thích mãi ông ấy cũng chẳng hiểu gì.	いくら説明しても彼はまったく理解しない	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
251	Chị ấy chẳng tỏ ra ý muốn của mình.	彼女は自分の意向を表に出さない	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
252	Tôi không khỏi nhớ quê tôi.	故郷を思い出さずにはいられない	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
253	Không ai không vui vì tin ấy.	このニュースを聞いて誰もが喜んだ	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
254	Tôi không quên gửi thư cho chị ấy.	彼女へ忘れずに手紙を出した	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
255	Nếu như vậy, nó không thể không thất bại.	このままだと彼は必ず失敗する	null		\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
256	Anh ấy nhất định không đến.	彼はきっと来ない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
257	Hôm qua tôi không đi đâu.	昨日私はどこにも行かなかった	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
258	Hôm qua tôi không đi đâu cả.	昨日私はどこにも行かなかった	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
259	Chị ấy không nói gì cả.	彼女は何も言わない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
260	Chị ấy không nói gì hết.	彼女は何も言わない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
261	Chờ đến 3 tiếng nhưng tôi chưa gặp ai hết.	3時間も待っているのに、まだ誰とも会っていない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
262	Chẳng ai biết.	誰も知らない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
263	Không có gì quý hơn độc lập, tự do.	独立と自由ほど尊いものは無い	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
264	Không phải đâu!	違う	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
265	Ý kiến của anh không đúng đâu.	あなたの意見は正しくない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
266	Anh ấy không chăm học chút nào.	彼はちっともまじめに勉強しない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
267	Không phải tôi không muốn đi học.	学校に行きたくないわけじゃない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
268	Không phải là chị ấy đi chơi.	彼女は遊んでいるのではない	null		\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
269	Tôi được cô giáo khen.	○：私は先生に褒められた	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
270	Tôi bị bố mẹ mắng.	○：私は両親に叱られた	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
271	Tôi bị cô giáo khen.	×	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
272	Tôi được bố mẹ mắng.	×	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
273	Vấn đề này được giải quyết.	この問題は解決された	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
274	Ông ấy bị bắt.	彼は捕まった	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
275	Tôi được điểm tốt.	私はいい点を取った	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
276	Chị ấy được mọi người hoan nghênh.	彼女は皆から歓迎された	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
277	Tôi bị tai nạn giao thông.	私は交通事故にあった	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
278	Tôi bị cảm.	風邪を引いた	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
279	Anh ấy bị bố đánh.	彼は父親に殴られた	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
280	Xe máy bị hỏng.	バイクが壊れた	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
281	Bức tranh này do tôi vẽ.	この絵は私が描いたものです	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
282	Dự án này do cô Lan đề nghị.	この案はランさんによって提案された	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
283	Anh ấy bị ốm do thức khuya liên tục.	彼は夜更かしのし過ぎで病気になった	null		\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
284	Mẹ cho con đi chợ.	母は子供を市場に行かせた	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
285	Giám đốc cho các nhân viên đi tìm khách hàng mới.	社長は社員に新しい客を探しに行かせた	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
286	Công nhân cho máy chạy.	工員が機械を動かす	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
287	Xin cho tôi biết.	私に教えてください	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
288	Cho tôi xem.	見せてください	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
599	Anh đi đâu ?	あなたはどこに行きますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
289	Tai nạn giao thông làm tôi không kịp.	交通事故のせいで間に合わなかった	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
290	Bài học chán ấy làm các sinh viên buồn ngủ.	その文章がつまらないので学生たちは眠くなった	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
291	Để cô ấy phát biểu ý kiến.	彼女に意見を述べさせておきなさい	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
292	Anh ấy thì không cần giúp đỡ, để anh ấy tự làm.	彼には助けは要らない、ひとりでやらせなさい	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
293	Chúng ta phải để phòng sạch sẽ.	私たちは部屋をきれいにしておかなければならない	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
294	Mẹ em bắt em phải chăm học.	母が私に勉強させた	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
295	Cái gì khiến anh ấy nói như thế?	なぜ彼はそのように言ったのか	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
296	Tiếng cãi nhau khiến hàng xóm khó chịu.	けんかの声で近所の人は不愉快になった	null		\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
297	Đừng hút thuốc trong quán này.	店内でタバコを吸ってはいけません	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
298	Đừng ăn uống trong lớp.	教室の中で飲食してはいけません	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
299	Chớ vì thất bại mà nản lòng.	失敗しても落ち込んではいけません	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
300	Anh không nên sử dụng công ty du lịch ấy.	あの旅行会社は使わないほうがいい	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
301	Không được để xe trên vỉa hè.	歩道の上に車を止めてはならない	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
302	Cấm rẽ phải.	右折禁止です	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
303	Chị ấy không được khỏe.	彼女はあまり元気ではない	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
304	Ông ấy không được mạnh.	彼はあまり丈夫ではない	null		\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
305	Đi đi!	行け	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
306	Vứt đi!	捨てろ	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
307	Cháu ngồi đi.	座りなさい	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
308	Em ăn đi.	食べなさい	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
309	Em hãy đọc đi.	さあ読みなさい	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
310	Chị hãy uống thuốc đi.	さあ薬を飲みなさい	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
311	Chúng ta hãy đi đi.	さあ行きましょう	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
312	Anh hãy cẩn thận.	気をつけなさい	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
313	Hãy im lặng.	静かにしろ	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
314	Xin ông dạy cho cháu.	（どうか）私に教えてください	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
315	Mời anh ngồi.	どうぞ座ってください	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
316	Xin mời vào.	入ってください	null		\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
317	Chị ấy duyên dáng biết bao! 	彼女はなんて魅力的なのでしょう	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
318	Anh ấy đẹp trai biết mấy!	彼はなんてハンサムなのでしょう	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
319	Phòng này sáng làm sao!	この部屋はなんて明るいのでしょう	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
320	Hôm nay nóng quá!	今日は暑いね	null		\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
321	Chị không biết nói tiếng anh à?	あなたは英語を話せないのですか	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
322	Tôi hiểu rồi ạ.	私は分かりました	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
323	Xin lỗi, tôi ngồi đây được không ạ?	すみません、ここに座ってもいいですか	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
324	Anh vẫn còn học tiếng Việt chứ?	あなたはまだベトナム語を勉強していますよね	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
325	Anh vẫn ở khách sạn Thăng Long chứ?	あなたはまだタンロンホテルに滞在していますよね	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
326	Anh ấy dịch khá tốt đấy.	彼はかなり上手に訳しましたよ	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
327	Còn tức giận hả?	まだ怒っているの	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
328	Tôi trả tiền rồi mà.	私はもうお金を払ったじゃないですか	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
329	Hôm nay đến nhà mình chơi nhé.	今日は私の家に遊びに来てね	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
330	Hôm nay trời đẹp quá nhỉ !	今日は天気がいいですね	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
331	Hà Nội đông người quá nhỉ !	ハノイはとても人が多いですね	null		\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[9]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
332	Trong bốn mùa, anh thích mùa nào nhất?	四季の中で、あなたはどの季節が一番好きですか	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
333	Bây giờ là mùa xuân nên trời đẹp.	今は春なので天気がいいです	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
334	Mùa đông, trời rét.	冬は寒いです	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
335	Ngày mai thời tiết thế nào?	明日の天気はどうですか	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
336	Ngày mai trời mưa to.	明日は大雨が降ります	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
337	Tôi bị mưa.	私は雨に降られました	null		\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
338	Từ nhà tôi đến văn phòng đi xe máy hết 15 phút.	私の家からオフィスまで15分かかります	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
339	Tôi từ Kyoto đến.	私は京都から来ました	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
340	Chúng ta đi bộ đến ga Ueno, sau đó lên tàu từ đấy.	上野まで歩いていき、そこから電車に乗りました	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
341	Hàng ngày tôi học đến 11 giờ. 	毎日11時まで勉強します	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
342	Hôm nay tôi lên lớp từ 1 giờ chiều.	今日の始業時間は午後1時からです	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
343	Chúng em nói chuyện đến khuya. 	私たちは夜遅くまで話をしました	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
344	Hôm nay chúng ta bắt đầu học từ trang 120.	今日は120ページから始めます	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
345	Sáng mai hãy đến nhà tôi trước 9 giờ.	明日の朝9時までに私の家に来なさい	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
346	Anh phải quay về đến 4 giờ chiều.	4時までに戻ってきなさい	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
347	Chị ấy ở Trung Quốc đến. 	彼女は中国から来た	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
348	Anh ấy ở Vinh ra Hà Nội. 	彼はヴィンからハノイに来た	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
349	Mẹ tôi vừa đi chợ về.	母は市場に行ってきたところです	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
350	Chị đi đâu về?	どこに行ってきましたか	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
351	Tôi đi học về.	学校に行ってきました	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
352	Anh ấy đi mua báo về.	彼は新聞を買って帰ってきた	null		\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
353	Ngày mai tôi đi Đà Nẵng.	明日、私はダナンに行きます	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
354	Mời anh đến nhà tôi.	どうぞ私の家に来てください	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
355	Chiều mai tôi đến nhà bạn tôi.	明日の午後、私は友達の家に行きます	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
356	Bây giờ tôi vào được không?	今入ってもいいですか	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
357	Chúng ta hãy ra sân.	さあ、庭へ出ましょう	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
358	Anh ấy hay lên miền núi.	彼はよく山岳地帯に行きます	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
359	Ông Hoàng xuống gác một.	ホアンさんは 1 階へ降りました	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
360	Bộ đội đang qua sông.	部隊は今、川を渡っているところです	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
361	Chị Hà về nhà rồi.	ハーさんはもう家へ帰りました	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
362	Tôi vừa lên Đà Lạt.	私はダラットに来たばかりです（低所→高所）	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
363	Mai tôi xuống Nha Trang.	明日、私はニャチャンに行きます（高所→低所）	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
364	Tuần trước anh ấy lên Hà Nội.	先週、彼はハノイへ来ました（農村→都市）	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
365	Tháng sau chị ấy xuống Châu Đốc.	来月、彼女はチャウドックへ行きます（都市→農村）	null		\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
366	Tôi gặp anh ấy ở khách sạn.	私はホテルで彼に会いました	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
367	Tôi phải trả quyển sách này cho thầy giáo.	私は先生にこの本を返さなければなりません	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
368	Tôi sẽ gửi thư cho anh.	私はあなたに手紙を送ります	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
369	Cái bàn này làm bằng gỗ.	この机は木でできています	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
370	Tôi đi học bằng xe máy.	私はバイクで通学します	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
371	Tôi đang tìm sách về kinh tế Việt Nam.	私はベトナム経済に関する本を探しています	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
372	Anh đi du lịch với ai?	あなたは誰と旅行に行くのですか	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
373	Thầy Nam nghiêm khắc đối với sinh viên.	ナム先生は学生に対して厳しいです	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
374	Tôi muốn đi du lịch khắp thế giới.	私は世界中あらゆる所へ旅行に行きたいです	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
375	Hầu hết mọi người đều biết chuyện này.	ほとんど全ての人がこの話を知っています	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
376	Từ nhà tôi đến trường khoảng 3 km.	私の家から学校まで 3 キロです	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
377	Giữa anh và tôi không có bí mật.	あなたと私の間には秘密はありません	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
378	Cả chị ấy lẫn tôi đều là sinh viên.	彼女も私も学生です	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
379	Bất cứ việc gì tôi cũng làm.	どんな仕事でもします	null		\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
380	Tôi phải gọi điện lại cho anh Sang.	私はまたサンさんに電話をかけなければなりません	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
381	Tuần trước tôi đã xem phim ấy rồi nhưng tuần này tôi muốn xem lại.	私は先週その映画を見ましたが、今週また見たいです	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
382	Em gái tôi khóc mãi.	私の妹はずっと泣いています	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
383	Tôi giải thích mãi mà anh ấy không hiểu.	私がずっと説明しても彼は分かりません	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
384	Hãy nghỉ một cái đã.	まず一休みしましょう	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
385	Tôi không muốn uống nữa	私はもうこれ以上飲みたくありません	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
386	Anh đã ăn hết chưa?	もう全部食べましたか	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
387	Tôi chưa viết xong.	私はまだ書き終えていません	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
388	Anh nên đọc thêm những tài liệu này.	あなたはこれらの資料をもっと読んだほうがいいです	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
389	Anh phải làm lấy việc này.	あなたは自分でこの仕事をしなくてはなりません	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
390	Em hãy hỏi mẹ thử.	（子供に）おかあさんに聞いてみなさい	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
391	Mời anh ăn thử.	どうぞ食べてみてください	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
392	Chị hãy nhớ lại xem.	思い出してみなさい	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
642	con, bố, mẹ	親子間	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
393	Tên người đó tôi quên mất rồi.	その人の名前は忘れてしまいました	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
394	Hôm qua tôi mua phải hàng giả.	昨日偽物を買ってしまった	null		\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
395	Anh ấy yêu cô ấy đến mức có thể chết vì cô ấy.	彼は彼女のためなら死んでも構わないほど彼女を愛している	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
396	Bài tập này khó đến mức ngay cả anh ấy không làm được.	この練習問題は彼でもできないほど難しい	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
397	Tối qua trời lạnh đến nỗi có tuyết.	昨晩は雪が降るほど寒かったです	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
398	Anh ấy có nhiều tiền đến nỗi không biết nên tiêu vào việc gì.	彼は何に使っていいか分からないほどお金を持っている	null		\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
399	Con mèo đã ngủ đến 4 tiếng.	ネコは 4 時間も眠った	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
400	Anh ấy đi nước ngoài những 3 năm.	彼は 3 年間も外国に行っていた	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
401	Bể bơi này sâu tới 4m.	このプールは深さが 4 メートルもある	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
402	Hôm qua tôi thức đến tận 2 giờ sáng.	昨日私は2時まで起きていた	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
403	Anh ấy học đến tận 11 giờ tối.	彼は夜11時まで勉強した	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
404	Các anh ấy họp có mười lăm phút.	彼らは15分だけ会合をした	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
405	Chị ấy mua có một cái bút.	彼女は一本だけペンを買った	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
406	Các anh ấy họp mỗi mười lăm phút.	彼らは15分だけ会合をした	null		\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
407	Tôi thường vừa nghe nhạc vừa học.	私はよく音楽を聴きながら勉強します	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
408	Chị ấy vừa ngồi tàu vừa ngắm cảnh.	彼女は電車で座りながら景色を見ている	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
409	Cái nhà này vừa cũ vừa đắt.	この家は古いし値段が高いです	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
410	Chị ấy vừa đẹp vừa hiền.	彼女は綺麗だし優しいです	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
411	Phòng này vừa là nhà bếp vừa là phòng ăn.	この部屋は台所でもあるし食堂でもある	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
412	Mùa hè Nhật Bản không những nóng mà còn oi bức.	日本の夏は暑いばかりでなく蒸し暑いです	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
413	Chị ấy không chỉ biết nói tiếng Anh mà còn biết nói tiếng Nga nữa.	彼女は英語が話せるだけでなくロシア語も話せます	null		\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
414	Cô ấy trở thành một nhà văn nổi tiếng.	彼女は有名な作家になった	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
415	Chị ấy trở thành một cô gái đẹp.	彼女はきれいになった	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
416	Một nông thôn trở thành đô thị mới.	農村がニュータウンになる	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
417	Vấn đề trở nên phức tạp.	問題が複雑になる	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
418	Ý tưởng này trở nên cũ.	このアイデアは古くなってしまった	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
419	Các sinh viên trong lớp trở nên thân mật.	クラスの学生たちは親しくなった	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
420	Cô giáo mới chia lớp thành 3 nhóm nhỏ.	新しい先生はクラスを 3 つの小グループに分けた	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
421	Mẹ tôi cắt bánh sinh nhật thành 5 miếng.	母は誕生ケーキを 5 つに切った	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
422	Bà phù thủy biến hoàng tử thành một con ếch.	魔法使いは王子をカエルにした	null		\N	gmod	explanation052.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
423	Bao giờ anh ấy cũng đi học đúng giờ.	彼はいつも時間通りに登校する	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
424	Ông ấy lúc nào cũng uống rượu.	彼はいつも酒を飲んでいる	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
643	mình, tớ, cậu	親しい仲で	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
425	Chị ấy lúc nào cũng vui.	彼女はいつも楽しそうにしている	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
426	Thầy Anh không bao giờ cười.	アイン先生は決して笑わない	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
427	Cô ấy không bao giờ đọc sách.	彼女は決して本を読まない	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
428	Tôi chưa bao giờ đi Huế.	私はまだフエに行ったことがありません	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
429	Anh đã bao giờ đi Huế chưa?	フエに行ったことがありますか	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
430	Rồi, tôi đã đi Huế rồi.	はい、フエに行きました	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
431	Chưa, tôi chưa bao giờ đi Huế.	いいえ、まだフエに行ったことはありません	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
432	Tôi chưa ăn món ăn Trung Quốc lần nào.	私はまだ中華料理を食べたことがありません	null		\N	gmod	explanation053.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
433	Ước gì anh ấy bảo tôi trước.	彼は前もって私に言ってくれたらよかったのに	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
434	Ước gì anh ấy đến thăm tôi.	彼が訪ねてきてくれればいいのに	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
435	Tôi mong gặp lại chị.	またお会いしたいです	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
436	Cô ấy muốn tôi đi với cô ấy.	彼女は、私が彼女と一緒に行くことを望んでいる	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
437	Tôi hy vọng anh ấy sẽ sớm bình phục.	私は彼が早く回復することを願っています → 彼に早く回復して欲しい	null		\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
438	Tuy đứa con không nói gì nhưng người mẹ vẫn hiểu.	子供は何も言わなくても母親は分かるのです	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
439	Tuy tôi chưa gặp chị ấy nhưng tôi đã nghe nói nhiều về chị ấy.	私は彼女に会ったことはありませんが、彼女のことはよく聞いています	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
440	Dù đã uống thuốc ngủ, tôi vẫn không ngủ được	私は睡眠薬を飲んだのに眠れません	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
441	Mặc dù anh ấy bị mệt nhưng anh ấy vẫn đi học.	彼は疲れていますが、学校に行きます	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
442	Mặc dù vô tuyến này rất đắt nhưng anh ấy vẫn mua.	このテレビはとても高いのですが、彼は買いました	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
443	Tuy vậy chúng tôi vẫn thua cuộc.	それでも私たちは負けました	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
444	Thế nhưng tôi đã chẳng nghe nói gì cả.	でも何も聞いていないですよ	null		\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
445	Không có kinh nghiệm, làm sao mà vượt qua khó khăn như thế này được.	経験がないと、どうしてこのような困難を乗り越えることができようか	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
446	Tôi làm sao mà làm việc đó một mình được. 	どうして私ひとりでその仕事ができようか	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
447	Đủ điều kiện, lẽ nào lại không thành công.	条件が十分揃っているので、成功しないわけがない	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
448	Lẽ nào anh ấy lại không biết.	彼が知らないわけがない	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
449	Anh chẳng nói thế là gì?	そう言ったでしょうが	null		\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
450	Nếu tôi có tiền thì tôi sẽ mua nhà.	もしお金があれば、私は家を買います	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
451	= Nếu tôi có tiền, tôi sẽ mua nhà	もしお金があれば、私は家を買います	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
452	= Tôi có tiền thì tôi sẽ mua nhà.	もしお金があれば、私は家を買います	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
453	Nếu tôi đi Hà Nội thì tôi sẽ đi bằng máy bay.	もしハノイに行くなら、私は飛行機で行きます	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
454	Anh mà không chịu học thì anh không thi đỗ được.	頑張って勉強しないと試験に受かることができませんよ	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
455	Anh có đi thì tôi mới ở lại.	あなたが行くなら私は残ります	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
644	anh ấy, ông ấy	彼	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
456	Chị ấy có nhờ thì tôi mới giúp.	彼女が頼めば私は手伝います	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
457	Phải chăm học mấy năm, anh mới thi đỗ lấy tư cách đó được.	まじめに数年勉強してはじめて、その試験に合格し資格を得ることができるのです	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
458	Giả tôi trẻ lại được thì tôi muốn lập gia đình với cô ấy.	仮に若返ることが出来るとしたら、私は彼女と結婚したいです	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
459	Giả sử có người hỏi, anh sẽ trả lời sao?	仮に誰か質問する人がいたら、あなたはどのように答えるのですか	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
460	Anh phải đọc bài này cẩn thận, chứ không thì không thể hiểu được.	あなたはこの文章を注意して読まなければなりません。でないと理解できません	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
461	Chị phải đi ngay bây giờ, nếu không chị sẽ không kịp.	あなたは今すぐいかなくてはなりません。そうしないと間に合いません	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
462	Anh nên xin lỗi vợ, nếu không chị ấy sẽ giận lắm.	あなたは奥さんに謝るべきです。そうしないと彼女は非常に怒りますよ	null		\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
463	Tôi nghĩ rằng anh ấy đến muộn.	彼は遅れてくると思う	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
464	Anh ấy nói là anh ấy không thích uống cà phê.	彼はコーヒーはあまり好きではないと言いました	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
465	Tôi nghĩ rằng tình hình kinh tế Nhật sắp được khôi phục.	私は日本の景気はそろそろ回復すると思います	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
466	Tôi cho rằng chị ấy là một người tốt bụng.	彼女はいい人だと思います	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
467	Tôi tin là anh ấy không bao giờ nói dối.	彼は決して嘘をつかないと信じています	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
468	Tôi nghi là anh ấy nói dối.	彼は嘘をついているのではないかと疑っています	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
469	Tôi sợ là cơn bão đổ bộ vào miền này.	台風がこの地方に上陸するのではと恐れています	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[7]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
470	Mẹ anh ấy lo là anh ấy bị tai nạn trong du lịch.	彼の母親は旅行中彼が事故に遭わないか心配しています	null		\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[8]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
471	Thầy giáo bảo các sinh viên ôn tập nhiều.	先生は学生たちによく復習するように言いました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
472	Anh ấy khuyên tôi không uống rượu nhiều.	彼は私にあまり酒を飲まないよう忠告しました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
473	Công an yêu cầu tôi xuống xe.	警察は私に車から降りるように要求しました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
474	Tôi mời ông ấy vào nhà.	彼を家に迎えました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
475	Tôi nhờ anh ấy làm giúp bài tập này.	彼に宿題を手伝ってもらうよう頼みました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
476	Chị ấy rủ tôi đi xem phim.	彼女は私を映画に誘いました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
477	Tôi đề nghị ngày mai chúng ta nghỉ học.	私は明日は休講にしようと提案しました	null		\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
478	Nhân dân Ucraina bầu ông Yuschenco làm tổng thống.	ウクライナの国民はユーシェンコ氏を大統領に選出しました	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
479	Giám đốc chọn chị ấy làm thư ký mới.	社長は彼女を新しい秘書に選びました	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
480	Bộ ngoại giao cử ông ấy làm đại sứ Việt Nam.	外務省は彼をベトナム大使に任命しました	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
481	Cô giáo cho các sinh viên từ điển tiếng Việt.	先生は学生たちにベトナム語辞典をあげました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
482	Mẹ cho tôi một chút tiền để mua sách.	母は私に本を買うためのお金をくれました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
483	Hiệu trưởng phát phần thưởng cho học sinh.	校長先生が生徒を表彰しました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
484	Ông Cường phát lương cho nhân viên.	クオンさんが社員に給料を配りました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
519	Tình hình hiện nay rất khó.	現在の状況はとても厳しい	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
485	Nhân ngày sinh nhật, tôi biếu quà cho bà nội.	誕生日を祝して、おばあちゃんに贈り物を贈りました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
486	Anh tôi tặng một bộ từ điển bách khoa cho tôi.	兄は私に百科事典を贈ってくれました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
487	Anh tặng bó hoa cho em.	君に花をプレゼントしたい	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
488	Anh ấy đưa tài liệu cho tôi.	彼は私に資料を渡しました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
489	Tôi gửi thư cho chị Thuận.	トゥアンさんに手紙を送ります	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
490	Tôi phải gửi những hàng này tới địa chỉ này.	この荷物をこの住所まで送らなくてはなりません	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
491	Tôi nhờ anh ấy chuyển bức thư cho gia đình tôi.	彼に私の家族に手紙を届けてくれるよう頼みました	null		\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
492	Tôi mượn của anh ấy cuốn sách này.	この本を彼から借りた	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
493	Tôi mượn cuốn sách này của anh ấy.	彼からこの本を借りた	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
494	Em mượn cuốn sách này của ai ?	誰からこの本を借りたの？	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
495	Tôi vay tiền của giám đốc.	社長からお金を借りた	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
496	Tôi thuê xe của công ty ấy.	その会社から車を借りました	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
497	Tôi đã nhận báo cáo của chị ấy.	彼女からレポートを受け取りました	null		\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
498	Cả chủ Nhật cũng phải đi làm thêm.	（他の日は当然として）日曜日も仕事に行かなければなりません	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
499	Cả chị ấy cũng biết chuyện ấy.	彼女でさえもその話を知っています	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
500	Anh phải làm ngay bây giờ.	あなたは今すぐしなければなりません	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
501	Chính các bạn là những người chủ tương lai.	皆さんこそが未来の担い手です	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
502	Em đừng có nghĩ như thế.	そのように考えてはなりません	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
503	Mẹ tôi đã lo đến gầy người.	私の母はやせるほど心配していました	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
504	Tôi muốn mua cả hai cái này.	私はこれらを 2 つとも買いたいです	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
505	Mai chúng ta gặp nhau ở đây đúng 3 giờ chiều nhé.	明日午後 3 時ちょうどにここで会いましょう	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
506	Anh ấy ăn những năm bát cơm.	彼は 5 杯もご飯を食べました	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
507	Anh ấy uống những 5 chai bia.	彼はビールを 5 本も飲みました	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
508	Anh ấy chờ ở đây những 30 phút.	彼は30分も待っています	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
509	Đồng hồ tôi nhanh đến mười ba phút.	私の時計は 13 分も進んでいます	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
510	Chị ấy chỉ ăn có một bát cơm.	彼女は 1 杯しかご飯を食べていません	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
511	Ai cũng biết cả.	誰でも知っています	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
512	Tôi không biết đâu.	私はまったくく知りません	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
513	Tiếng Việt không khó đâu.	ベトナム語は難しくありません	null		\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
514	Hãy đứng xa xa mà nhìn lại.	少し離れて立ってもう一度見てください	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
515	Xin cho tôi xem một cái nho nhỏ.	少し小さいのを見せてください	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
516	Tình hình khó khăn	困難な状況	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
517	Căn phòng sạch sẽ	清潔な部屋	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
518	Nhà cửa ở nông thôn rộng rãi.	農村の家は広いです	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
520	Phòng này rất sạch.	この部屋はとても清潔です	null		\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
521	Sáng mai làm ơn đánh thức tôi vào lúc sáu giờ rưỡi.	明日の朝 6 時半に起こしてください	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
522	Tôi đã đánh rơi tài liệu.	私は資料を落としました	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
523	Gần đây có một ngôi nhà cho thuê.	この近くに貸家が 1 軒あります	null		\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
524	Anh ấy nói：Tôi không đi.	彼は言いました。「私は行きません」	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
525	Anh ấy nói : Khi nào có kết quả thì xin anh cho tôi biết.	彼は言いました。「結果が分かったら私に教えてください」	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
526	Anh ấy nói là anh ấy không đi.	彼は自分は行かないと言った	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
527	Anh ấy đã yêu cầu tôi là khi nào có kết quả thì cho anh ấy biết.	彼は結果が分かり次第知らせるように私に要求しました。	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
528	Chị ấy là ai?	彼女は誰ですか	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
529	Chị ấy là người nước nào?	彼女はどこの国の人ですか	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
530	Anh có biết chị ấy là ai không?	あなたは彼女が誰だか知っていますか	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
531	Anh có biết chị ấy là người nước nào không?	あなたは彼女がどこの国の人か知っていますか	null		\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
532	Tôi là sinh viên.	私は学生です	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
533	Ông ấy không phải là giáo sư. 	彼は教師ではありません	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
534	Chị có phải là người Việt không? 	あなたはベトナム人ですか	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
535	Vâng, tôi là người Việt. 	はい、私はベトナム人です	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
536	Không, tôi không phải là người Việt. 	いいえ、私はベトナム人ではありません	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
537	Tôi là người Nhật.	私は日本人です。	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
538	Đây là sầu riêng.	これはドリアンです。	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
539	Tôi không phải là nhân viên công ty.	私は会社員ではありません	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
540	Cái này không phải là từ điển.	これは辞書ではありません	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
541	Chị ấy có phải là người Việt không?	彼女はベトナム人ですか 	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
542	Vâng, chị ấy là người Việt.	はい、彼女はベトナム人です 	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
543	Không, chị ấy không phải là người Việt.	いいえ、彼女はベトナム人ではありません	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
544	Không, chị ấy là người Nhật. 	いいえ、彼女は日本人です	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
545	Từ điển này tốt. 	この辞書はいいです	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
546	Con voi kia có to không?	あの象は大きいですか	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
547	Chị Hoa rất đẹp.	ホアさんはとても綺麗です	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
548	Sách này hay lắm. 	この本はとても面白いです。	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
549	Anh nói tiếng Việt giỏi quá!　 	あなたはベトナム語がとても上手です	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
550	Con mèo này trắng.	この猫は白いです	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
551	Con mèo trắng này xinh.	この白い猫はかわいいです	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
552	Từ điển này không tốt.	この辞書はよくないです	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
553	Cái nhà này đắt không?	この家は（値段が）高いですか。	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
554	Cái này không đắt lắm.	これは（値段が）あまり高くないです	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
555	Hôm nay trời hơi lạnh.	今日は少し寒いです	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
556	Hoa này đẹp hơn hoa kia.	この花はあの花よりきれいです	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
557	Cái cầu này dài bằng cái cầu kia.	この橋はあの橋と同じくらい長いです	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
558	Xe đạp này tốt nhất.	この自転車が一番いいです	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
559	Bà Tâm già hơn bà Cúc.	タムさんはクックさんより年をとっています	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
560	Trong lớp tôi, chị Hoa xinh nhất.	私のクラスでは、ホアさんが一番かわいいです	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
561	Cái nhà này to bằng cái nhà kia.	この家はあの家と同じくらい大きいです	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
562	Tôi biết. 	私は知っています	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
563	Tôi không biết. 	私は知りません	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
564	Anh có biết không? 	あなたは知っていますか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
565	Có, tôi biết. 	はい、知っています	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
566	Không, tôi không biết. 	いいえ、知りません	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
567	Em không hiểu.	僕は分かりません	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
568	Anh ấy không uống rượu.	彼は酒を飲まない	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
569	Tôi gặp anh ấy.	私は彼に会う	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
570	Tôi không gặp anh ấy.	私は彼に会いません	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
571	Tôi chưa gặp anh ấy.	私はまだ彼とは会っていません	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
572	Em có hiểu không?	君は分かりましたか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
573	Anh có uống rượu không?	あなたはお酒を飲みますか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
574	Chị có nghe nhạc không?	あなたは音楽を聴きますか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
575	Anh ăn cơm chưa?	ご飯を食べましたか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
576	Chị viết thư chưa?	手紙を書きましたか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
577	Em làm bài tập xong chưa?	宿題は終わりましたか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
578	Có, tôi ăn cơm rồi.	はい、もう食べました	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
579	Chưa, tôi chưa ăn cơm.	いいえ、まだ食べていません	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
580	Hiểu chưa?	分かった？	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
581	Hiểu rồi.	分かった	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	\N
582	Anh không biết à?	知らないんですか	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	\N
583	Chị sống ở đâu?	どこに住んでいますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
584	Ông ấy là ai?	彼は誰ですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
585	Đây là cái gì?	これはなんですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
586	Vấn đề này được giải quyết thế nào?	この問題はどのように解決されたのですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
587	Vì sao em cười?	なぜ笑っているのですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
588	Khi nào anh ấy đi du lịch?	いつ旅行に行きますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
589	Chị ấy nói gì?	彼女は何と言っていますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
590	Em làm gì?	君は何をしますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
591	Chị thích cái gì?	あなたは何が好きですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
592	Anh làm nghề gì?	あなたはどんな仕事をしていますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
593	Cái này tiếng Việt gọi là gì?	これはベトナム語で何と言いますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
594	Khi nào anh đi Việt Nam?	いつベトナムに行きますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
595	Anh đi Việt Nam khi nào?	いつベトナムに行きましたか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
596	Bưu điện ở đâu?	郵便局はどこにありますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
597	Chị mua áo ở đâu?	どこで服を買いましたか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
598	Ông Tuấn ở đâu?	トゥアンさんはどこにいますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
600	Vì sao chị ăn ít thế?	どうして少ししか食べないのですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
601	Vì tôi bị đau dạ dày.	なぜなら胃が痛いからです	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	1
602	Tại sao em không đi học?	なぜ君は学校に来なかった	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	\N
603	Vì em ngủ quên.	寝坊してしまったからです	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	\N
604	Sao anh nói vậy?	なぜそう言うのですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
605	Ai đảm đương việc này?	誰がこの仕事を担当しますか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	\N
606	Em đi du lịch với ai?	誰と旅行に行くのですか	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
607	Tôi bị đau chân.	私は足が痛い	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
608	Tôi bị đau đầu.	私は頭が痛いです	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
609	Mắt chị ấy to lắm.	彼女の目は非常に大きいです	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
610	Tôi mỏi chân rồi.	私はもう足が疲れました	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
611	đầu; nghĩ, hiểu	「頭」; ｢考える｣「理解する」「知っている」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
612	mặt; cười, mỉm cười, khóc	「顔」;「笑う」「微笑む」「泣く」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
613	tai; nghe, lắng nghe	「耳」;「聞く」「耳を傾ける」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
614	mắt; xem, thấy, nhìn, ngủ, dậy	「目」;「見る」「見える、見る、わかる」「見つめる」「寝る」「起きる」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
615	mũi; ngửi	「鼻」;「匂いをかぐ」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
616	miệng; nói, đọc, ăn, uống, hát	「口」;「話す」「読む」「食べる」「飲む」「歌う」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
617	tay; viết, làm, lấy	「手」;「書く」「する、働く」「取る」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
618	chân; đi, chạy, đứng, ngồi	「足」;「行く」「走る」「立つ」「座る」 	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
619	Bố tôi là công nhân.	私の父は工員です	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
620	Bố mẹ tôi sống ở Huế.	両親はフエに住んでいます	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
621	Em gái tôi đi Nga du học.	妹はロシアに留学に行きました	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
622	Tôi có 2 anh chị.	私には2人の兄弟がいます	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
623	ông ngoại, ông nội	祖父：（母方の祖父）（父方の祖父）	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
624	bà ngoại, bà nội	祖母：（母方の祖母）（父方の祖母）	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
625	vợ, chồng	「妻」「夫」	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
626	mẹ, bố, cha	「母」「父」「父」	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
627	vợ chồng	夫婦	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
628	cha mẹ, bố mẹ	父母	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
629	tôi	わたし	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
630	anh, chị	「兄」「姉」	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
631	em trai, em gái 	「弟」「妹」	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
632	anh họ, chị họ, em họ	「従兄」「従姉」「従弟・従妹」	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
633	con trai, con gái	「息子」「娘」	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
634	cưới vợ, cưới chồng, lấy chồng, lấy vợ, lập gia đình	結婚する	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
635	Tôi là sinh viên.	私は学生です	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
636	Hôm nay anh đi đâu?	今日あなたはどこに行きますか	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
637	Chị ấy làm việc ở siêu thị.	彼女はスーパーで働いている	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
638	Em chào thầy ạ.	（先生）こんにちは	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
639	tôi	私	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
640	cháu, em, anh, chị, cô, chú, bác, ông, bà 	あなた	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
641	em, thầy, cô	先生・生徒間	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
645	chị ấy, cô ấy, bà ấy	彼女	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
646	Chúng ta học tiếng Việt.	私たちはベトナム語を勉強している	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
647	Chúng em học tiếng Việt.	私たちはベトナム語を勉強している	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
648	chúng ta	私たち（包括形）	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
649	chúng tôi	私たち（除外系）	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
650	các anh, các chị, các cô, các bạn ...	あなたがた	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
651	các anh ấy, các chị ấy, các ông ấy ...	あなたがた	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
652	họ	彼ら	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
653	Cái nhà này đẹp 	この家はきれいです	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
654	Con chó kia chạy nhanh.	あの犬は速く走る	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
655	chiếc: chiếc bút bi, chiếc ghế, chiếc xe đạp, chiếc máy bay	無生物名詞につける類別詞：ボールペン、いす、自転車、飛行機	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
656	quả: quả bóng, quả cam, quả đất, quả trứng	果物や果物に似た球形のものにつける類別詞：ボール、オレンジ、地球、卵	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
657	quyển: quyển sách, quyển tạp chí, quyển từ điển	本に付ける類別詞：本、雑誌、辞書	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
658	bức: bức ảnh, bức màn cửa, bức tranh	薄くて長方形のものにつける類別詞：写真、カーテン、絵	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
659	bàn: cái bàn, chiếc bàn	机	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
660	thư: lá thư, bức thư	手紙	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
661	sách: quyển sách, cuốn sách	本	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
662	bóng: quả bóng, trái bóng	ボール	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
663	Cô ấy viết một bức thư cho bố mẹ.	彼女は父母に 1 通手紙を書いています	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
664	Ba chiếc xe đạp này tốt.	この3台の自転車はいいです	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
665	Tôi có 3 bức ảnh của anh.	私はあなたの写真を 3 枚持っています	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
666	Từ điển này tốt, từ điển này không tốt.	この辞書はよく、この辞書はよくない	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
667	Đó là Văn Miếu.	あれは文廟です	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
668	Đây là cái gì? 	これはなんですか	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
669	này, ấy, đó, kia, nào	この、その、その、あの、どの	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
670	đây, cái này	これ	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
671	đấy, đó, cái ấy, cái đấy, cái đó	それ	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
672	kia, cái kia	あれ	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
673	gì, cái gì	どれ	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
674	đây, đấy, đó, kia, đâu	ここ、そこ、そこ、あそこ、どこ	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
675	3 con mèo trắng này	この3匹の白い猫	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
676	Ai bấm chuông đấy?	呼び鈴を押したのは誰？	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
677	Tôi đây.	私です	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
678	Anh đi đâu đấy?	どこへ行くんですか	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
679	Alô, Nam gọi đây ạ.	もしもし、ナムです	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
680	Lớp này có mấy người?	このクラスには何人いますか	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
681	Lớp này có năm người.	このクラスには5人います	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
682	Công ty này có bao nhiêu người?	この会社には何人いますか	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
683	Công ty này có hai mưoi lăm người.	この会社には25人います	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
684	Phòng này có 3 bức tranh.	この部屋には絵が3枚あります	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
685	một, hai, ba, bốn, năm, sáu, bảy, tám, chín, mười  	1,2,3,4,5,6,7,8,9,10	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
689	một trăm linh năm	105	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
690	một nghìn không trăm mười	1010	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
691	một nghìn không trăm năm mươi	1050	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
692	nghìn, triệu, tỷ	1000, 100万, 10億	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
693	2 quả táo	2個のりんご	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
694	1 chiếc máy bay	1機の飛行機	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
695	3 quyển sách	3冊の本	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
696	hai nghìn rưởi	2500	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
697	Núi này cao thứ ba trên thế giới.	この山は世界で3番目に高い山です	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
698	Tôi là sinh viên năm thứ nhất.	私は（大学）1年生です	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
699	Hôm nay là ngày thứ tư.	今日は水曜日です	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
700	nhất định	一定	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
701	sông Cửu Long	九龍江（メコン川のこと）	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
702	tam giác	三角	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
703	tứ giác	四角	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
704	ngũ quan	五感	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
705	chữ thập	十字	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
706	bách khoa	百科	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
707	thiên niên kỷ	千年紀	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
708	Năm nay anh bao nhiêu tuổi?	今年、あなたは何歳ですか	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
709	Năm nay em mấy tuổi?	今年、君は何歳ですか	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
710	Năm nay tôi 25 tuổi.	今年、私は２５歳です	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
711	Quyển sách này giá bao nhiêu tiền?	この本はいくらですか	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
712	Quyển sách này giá 50.000 (năm mươi nghìn) đồng.	この本は5万ドンです	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
713	Cái này bao nhiêu?	これいくら？	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
714	Cái này giá bao nhiêu?	これいくら？	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
715	Bây giờ là mấy giờ?	何時ですか	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
716	Bây giờ mấy giờ rồi?	何時ですか	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
717	Bây giờ là 9 giờ.	9時です	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
718	Bây giờ 12 giờ rồi.	12時です	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
719	Anh đi làm lúc mấy giờ? 	何時に仕事に行きますか	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
720	Tôi đi làm lúc 7giờ. 	7時に仕事に行きます	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
721	Bây giờ là 6 giờ kém 10.	6時10分前です	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
722	Thầy Tuấn dạy từ 8 giờ đến 11 giờ. 	トゥアン先生は8時から11時まで教えます	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
723	Chị ngủ dậy lúc mấy giờ?	あなたは何時に起きましたか	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
725	Bây giờ là 9 giờ 20.	9時20分です	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
726	10 giờ rưỡi	10時半	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
727	Buổi sáng tôi đi học.	朝は学校に行く	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
728	Sáng mai tôi gặp bạn.	明日の朝私は友達と会う	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
729	Tối qua anh ấy đến thăm nhà tôi.	昨晩彼が私の家を訪ねてきた	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
730	Tôi đi xem phim lúc 7 giờ tối.	午後7時に映画を見に行きます	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
731	buổi sáng, buổi trưa, buổi chiều, buổi tối	「朝」「昼」「午後（夕方）」「夜」	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
732	sáng qua, sáng nay, sáng mai	「昨日の朝」「今日の朝」「明日の朝」	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
733	trưa qua, trưa nay, trưa mai	「昨日の昼」「今日の昼」「明日の昼」	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
734	chiều qua, chiều nay, chiều mai	「昨日の午後（夕方）」「今日の午後（夕方）」「明日の午後（夕方）」	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
735	tối qua, tối nay, tối mai	「昨日の夜」「今日の夜」「明日の夜」	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
736	Hôm nay tôi đi làm lúc 10 giờ sáng.	今日は午前10時に仕事に行きます	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
737	Hàng ngày mẹ tôi nấu cơm từ 5 giờ sáng.	母は毎日朝5時からご飯を作ります	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
738	5 giờ chiều tôi về nhà.	午後5時に家に帰ります	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
739	Hàng ngày tôi học tiếng Việt 2 tiếng.	毎日ベトナム語を2時間勉強します	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
740	Từ đây đến thư viện đi bộ hết 15 phút.	図書館まで歩いて15分かかります	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
741	Từ Hà Nội đến Sài Gòn đi tàu mất khoảng 30 tiếng.	ハノイからサイゴンまで列車で約30時間かかります	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
742	Tôi học tiếng Anh 3 giờ một ngày.	私は一日に英語を3時間勉強します	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
743	Từ nhà em đến sân bay đi ô tô hết 2 tiếng.	私の家から空港まで車で2時間かかります	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
744	Anh ấy làm việc từ 8 giờ sáng đến 5 giờ chiều.	彼は朝の8時から夕方の5時まで働いている	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
745	Từ nhà tôi đến trường đại học mất 5 phút.	家から大学まで歩いて5分かかります	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
746	Trước giờ học tôi mua báo.	授業の前に新聞を買う	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
747	Trước thứ bảy tôi phải làm xong việc này.	土曜日までにこの仕事を終わらせなければならない	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
748	Trong tuần này cô Liên đến thăm nhà tôi.	今週中にリエン叔母さんが家に来る	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
749	Sau bữa ăn tôi uống chè.	食事の後、私はお茶を飲む	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
750	Trước khi đi học tôi mua báo. 	学校に行く前に新聞を買う	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
751	Trước khi ăn sáng tôi đi tập thể dục.	朝ごはんを食べる前に運動しに行く	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
752	Trong khi dùng thuốc anh không nên uống rượu.	薬を使っているときはお酒を飲まないほうがいい	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
753	Sau khi ăn cơm tôi uống chè.	ご飯を食べた後、私はお茶を飲む	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
754	Trước khi khách đến tôi phải dọn phòng.	お客さんが来る前に部屋を掃除しなければならない	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
755	Sau khi anh Anh đưa ra ý kiến công việc dần dần trở nên tốt đẹp.	アインさんが提案を出してから、事業はうまくいくようになった	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
756	Trong khi cô Lan ở bệnh viện chúng em thăm cô nhiều lần.	ラン先生が入院している間、私たちはよくお見舞いに行った	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
757	hôm kia, hôm qua, hôm nay, ngày mai, ngày kia	おととい（2日前）、昨日、今日、明日、明後日	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
758	hôm trước	先日	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
759	mấy hôm nay	ここ何日か	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
760	Tôi sẽ ở Phnôm Pênh 2 ngày.	私はプノンペンに2日居ます	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
761	3 ngày trước anh Nam chuyển nhà.	3 日前ナムさんは引っ越しました	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
762	Mấy hôm nay tôi không khỏe lắm.	ここ何日かあまり元気ではない	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
763	tuần trước, tuần này, tuần sau	先週、今週、来週	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
764	tháng trước, tháng này, tháng sau	先月、今月、来月	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
765	đầu tháng, giữa tháng, cuối tháng	上旬、中旬、下旬	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
766	giữa tháng tư	4月の中ほど / 4月中旬	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
767	năm ngoái, năm qua	去年	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
768	năm nay  	今年	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
769	sang năm, năm tới	来年	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
770	ngày 30 tháng 4 năm 2000	2000年4月30日	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
771	ngày mồng 2 tháng 9 năm 2003	2003年9月2日	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
772	mặt trời	太陽	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
773	mặt trăng	月	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
774	Trên trời có mặt trăng.	空に月が出ている	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
775	tháng giêng	正月、1月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
776	tháng một	1月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
777	tháng hai	2月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
778	tháng ba	3月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
779	tháng tư	4月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
780	tháng năm	5月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
781	tháng sáu	6月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
782	tháng bảy	7月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
783	tháng tám	8月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
784	tháng chín	9月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
785	tháng mười	10月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
786	tháng mười một	11月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
787	tháng mười hai	12月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
788	tháng chạp	旧暦の12月	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
789	chủ nhật	日曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
790	ngày thứ hai	月曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
791	ngày thứ ba	火曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
792	ngày thứ tư	水曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
793	ngày thứ năm	木曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
794	ngày thứ sáu	金曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	\N
795	ngày thứ bảy	土曜日	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	\N
796	Hôm nay là ngày mồng 2. 	今日は2日です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
797	Hôm nay là ngày mồng 10. 	今日は10日です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
798	Hôm nay là ngày 11.	今日は11日です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
799	Hôm nay là ngày bao nhiêu? 	今日は何日ですか	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
800	Hôm nay là ngày mồng mấy?	今日は何日ですか	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
801	Hôm nay là ngày thứ mấy? 	今日は何曜日ですか	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
802	Hôm nay là thứ mấy?	今日は何曜日ですか	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
803	Hôm nay là thứ tư.	今日は水曜日です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
804	Hôm nay là thứ bảy.	今日は土曜日です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
805	Tháng này là tháng mấy?	今月は何月ですか	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
806	Tháng này là tháng 11.	今月は11月です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
807	Năm nay là năm bao nhiêu?	今年は何年ですか	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
808	Năm nay là năm 2005.	今年は2005年です	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
809	Cái bút của tôi	私のペン	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
810	Tay của ông ngoại	祖父の手	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
811	Mùi hương của hoa mai	梅の香り	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
812	chiếc xe của tôi	私の車	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
813	đề nghị của nhân viên	職員の提案	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
814	tác phẩm của họa sĩ	画家の作品	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
815	nguyên nhân của vụ tai nạn ấy	その事故の原因	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
816	nhà em	私の家	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
817	sách tiếng Việt	ベトナム語の本	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
818	mẹ tôi	私の母	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
819	Cái này của anh ấy.	これは彼のです	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
820	Quyển sách này của chị Lan.	この本はランさんのものです	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
821	Cái này không phải của tôi.	これは私のではありません	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
822	Cái này của anh ấy, phải không?	これは彼のでしょう？	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
823	Cái này của ai?	これは誰のですか	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
824	Cuốn từ điển này của ai? 	この辞書は誰のですか 	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
825	Tôi có thể nói được tiếng Việt. 	私はベトナム語が話せます	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
826	Anh ấy không thể nói được tiếng Việt. 	彼はベトナム語が話せません	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
827	Anh có nói được tiếng Pháp không? 	あなたはフランス語が話せますか	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
828	Anh Tuấn viết được chữ Hán.	トゥアンさんは漢字を書けます	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
829	Anh ấy không ăn được cua.	彼はカニが食べられない	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
830	Tôi không thể sửa máy tính.	私はパソコンを直すことができない	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
831	Tôi chưa thể có kết luận.	まだ結論を出すことができない	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
832	Chị có hát được bài hát này không?	この歌を歌うことができますか	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
833	Bố tôi biết lái xe.	私のお父さんは車を運転できる	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
834	Anh có biết bơi không?	あなたは泳げますか	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
835	Trên bàn có nhiều sách. 	机の上には本がたくさんある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
836	Bên cạnh tủ lạnh có bếp ga. 	冷蔵庫の横にガス台がある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
837	Trong nhà có khách. 	家の中にお客さんがいる	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
838	Ngoài sân có xe máy. 	庭にはバイクがある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
839	Trên trời có mặt trăng. 	空に月が出ている	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
840	Dưới sông có một chiếc tàu. 	川に１隻の船がある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
841	Bên cạnh cái bàn có thùng rác.	机の横にゴミ箱がある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
842	Thùng rác ở cạnh cái bàn.	机の横にゴミ箱がある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
843	Tòa nhà ở cạnh con đường.	道の横に家がある	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
844	Dưới sông có nhiều lá cây.	川に木の葉がたくさん浮いている	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
845	Chị ấy là sinh viên, phải không? 	彼女は学生ですね	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
846	Cô ấy biết nói tiếng Nhật, phải không? 	彼女は日本語が話せますね	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
847	Anh ấy thích chơi bóng đá, phải không? 	彼はサッカーが好きでしょう 	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
848	Anh là nhân viên công ty, phải không?	あなたは会社員ですね	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
849	Em sống ở Sài Gòn, phải không?	サイゴンに住んでいますね	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
850	Nhà này rất đẹp, phải không?	この家はきれいでしょう	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
851	Anh ấy không phải là người Việt, phải không?	彼はベトナム人ではないでしょう	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
852	Chị chưa làm bài tập, phải không?	まだ宿題をやっていませんね	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
853	Chị đi làm việc hay đi chơi? 	あなたは仕事に行きますか、遊びに行きますか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
854	Bây giờ anh có muốn về nhà hay không? 	今あなたは家に帰りたいですか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
855	Ông muốn mua cái nào, cái này hay cái kia?	あなたはこれとあれのどちらを買いたいですか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
856	Chị ấy là người Trung Quốc hay là người Hàn Quốc?	彼女は中国人ですか、韓国人ですか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
857	Chị muốn ăn gì, phở hay là nem rán?	あなたはフォーと揚げ春巻きのどちらを食べたいですか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1195	cho thuê	賃貸しさせる	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
858	Tôi muốn uống nước cam hay là nước xoài.	私はオレンジジュースかマンゴージュースを飲みたい	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
859	Anh có đi uống bia hay không?	あなたはビールを飲みに行きますか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
860	Anh đã sửa xe đạp hay chưa? 	あなたはもう自転車を修理しましたか	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
861	Anh phải hỏi ý kiến bố mẹ. 	あなたは両親の意見を聞かなければなりません	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
862	Chị nên học tiếng Việt để nghiên cứu về Việt Nam.	あなたはベトナムについて研究するためにベトナム語を勉強するべきです	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
863	Tôi cần mua một quyển từ điển Việt-Anh.	私は越英辞書を 1 冊買う必要があります	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
864	Hôm nay anh cần làm xong việc này.	今日、あなたはこの仕事をし終える必要があります	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
865	Tôi dám gọi điện cho chị ấy.	私は思い切って彼女に電話します	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
866	Tôi định mua hai cân cam và một cân nho.	私はオレンジ 2 キロとブドウ 1 キロを買うつもりです	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
867	Tôi có thể làm bài tập này.	私はこの練習問題をすることが出来ます	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
868	Anh có muốn gặp chị ấy không ?	あなたは彼女に会いたいですか	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
869	Tôi thích nấu ăn.	私は料理するのが好きです	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
870	Hôm qua tôi gặp anh Nam. 	昨日ナムさんに会いました	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
871	Ngày mai tôi gặp anh Nam. 	明日ナムさんに会います	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
872	Tôi đã làm bài tập.	私は宿題をやりました	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
873	Hôm qua tôi làm bài tập.	昨日私は宿題をやりました	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
874	Hôm qua tôi đã làm bài tập.	昨日私はもう宿題をやっていました	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
875	Khi đến bệnh viện, bà ấy đã khỏe rồi.	病院に着いたとき、彼女はもう元気になっていた	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
876	Khi em vào trường đại học thì tôi đã về nước rồi.	あなたが大学に入るころには私は帰国してしまっているだろう	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
877	Tôi sẽ đi mua vé máy bay.	航空券を買いに行きます	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
878	Chiều mai tôi đi mua vé máy bay.	明日の午後航空券を買いに行きます	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
879	Mẹ tôi đang nấu cơm.	母はご飯を作っています	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
880	Hôm qua khi tôi đang chuẩn bị đi, bạn tôi đến thăm nhà tôi.	昨日私が出かける準備をしているときに友人が家を訪ねてきた	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
881	Tôi vừa đọc hết cuốn sách này.	ちょうどこの本を読み終わったところです	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
882	Anh ấy mới sửa nhà xong.	家の修理が終わったばかりです	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
883	Cô ấy sắp lấy chồng.	彼女はもうすぐ結婚する	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
884	Liên hoan sắp bắt đầu chưa?	パーティーはもうすぐ始まりますか	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
885	Sắp, liên hoan sắp bắt đầu.	はい、もうすぐ始まります	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
886	Chưa, liên hoan chưa bắt đầu.	いいえ、まだ始まりません	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
887	Chị ấy chẳng tỏ ra ý muốn của mình. 	彼女は自分の意向を表に出さない	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
888	Không ai không mong muốn hòa bình. 	誰もが平和を望んでいる	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
889	Chúng ta không thể không thành công. 	我々は必ず成功する	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
890	Giải thích mãi ông ấy cũng chẳng hiểu gì.	いくら説明しても彼は全く理解しない	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
891	Tôi không khỏi nhớ quê tôi.	故郷を思い出さずにはいられない	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
892	Tôi không quên gửi thư cho chị ấy.	彼女に忘れずに手紙を出した	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
893	Nếu như vậy, nó không thể không thất bại.	このままだと彼は必ず失敗する	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
894	Anh ấy không biết gì cả. 	彼は何も知らない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
895	Hôm nay tôi không đi đâu. 	今日は私はどこにも行かない 	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
896	Không phải nhà anh ấy giàu. 	彼の家は豊かだというわけではない 	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
897	Chưa ai đến cả. 	まだ誰も来ていない 	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
898	Tôi hoàn toàn không thỏa mãn. 	私はまったく満足していない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
899	Tôi không hoàn toàn thỏa mãn. 	私は完全に満足したわけではない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
900	Anh ấy nhất định không đến.	彼はきっと来ない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
901	Chị ấy không nói gì cả.	彼女は何も言わない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
902	Chờ đến 3 tiếng nhưng tôi chưa gặp ai hết.	3時間も待っているのに、まだ誰とも会っていない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
903	Chẳng ai biết.	誰も知らない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
904	Không có gì quý hơn độc lập, tự do.	独立と自由ほど尊いものはない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
905	Không phải đâu!	違う	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
906	Ý kiến của anh không đúng đâu.	あなたの意見は正しくない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
907	Anh ấy không chăm học chút nào.	彼はちっともまじめに勉強しない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
908	Không phải tôi không muốn đi học.	学校に行きたくないわけじゃない	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
909	Tôi được cô giáo khen.	私は先生に褒められた 	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
910	Tôi bị bố mẹ mắng. 	私は両親に叱られた 	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
911	Bức thư này do bác Cường viết. 	この手紙はクオン叔父さんによって書かれました 	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
912	Vấn đề này được giải quyết.	この問題は解決された	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
913	Ông ấy bị bắt.	彼は捕まった	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
914	Tôi được điểm tốt.	私はいい点を取った	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
915	Chị ấy được mọi người hoan nghênh.	彼女は皆から歓迎された	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
916	Tôi bị tai nạn giao thông.	私は交通事故にあった	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
917	Tôi bị cảm.	風邪を引いた	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
918	Xe máy bị hỏng.	バイクが壊れた	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
919	Anh ấy bị ốm do thức khuya liên tục.	彼は夜更かしのし過ぎで病気になった	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
920	Mẹ cho con đi chợ. 	母は子供を市場に行かせた	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
921	Để cô ấy phát biểu ý kiến.	彼女に意見を述べさせておく	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
922	Mẹ em bắt em phải chăm học. 	母親は子供に勉強するように言った	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
923	Giám đốc cho các nhân viên đi tìm khách hàng mới.	社長は社員に新しい客を探しに行かせた	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
924	Công nhân cho máy chạy.	工員が機械を動かす	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
925	Xin cho tôi biết.	私に教えてください	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
926	Cho tôi xem.	見せてください	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
927	Tai nạn giao thông làm tôi không kịp.	交通事故のせいで間に合わなかった	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
928	Bài học chán ấy làm các sinh viên buồn ngủ.	その文章がつまらないので学生たちは眠くなった	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
929	Anh ấy thì không cần giúp đỡ, để anh ấy tự làm.	彼には助けは要らない、ひとりでやらせなさい	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
930	Chúng ta phải để phòng sạch sẽ.	私たちは部屋をきれいにしておかなければならない	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
931	Mẹ bắt em phải chăm học.	母が私に勉強させた	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
932	Cái gì khiến anh ấy nói như thế?	なぜ彼はそのように言ったのか	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
933	Tiếng cãi nhau khiến hàng xóm khó chịu.	けんかの声で近所の人は不愉快になった	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
934	Đừng đi một mình. 	ひとりで行ってはいけません	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
935	Chớ vì không thích thầy giáo mà lười. 	先生が気に入らないからといって怠けてはいけない	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
936	Không nên đi theo người lạ. 	変な人についていかないほうがいい	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
937	Không được chạy ở hành lang.	廊下を走ってはいけません	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
938	Đừng hút thuốc trong quán này.	店内でタバコを吸ってはいけません	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
939	Đừng ăn uống trong lớp.	教室の中で飲食してはいけません	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
940	Chớ vì thất bại mà nản lòng.	失敗しても落ち込んではいけません	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
941	Không được để xe trên vỉa hè.	歩道の上に車を止めてはならない	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
942	Cấm rẽ phải.	右折禁止です	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
943	Chị ấy không được khỏe.	彼女はあまり元気ではない	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
944	Nói đi. 	言え	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
945	Em ăn đi. 	食べなさい	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
946	Em hãy đọc đi. 	さあ読みなさい	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
947	Hãy đọc 	読め	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
948	Mời anh vào. 	どうぞ入ってください	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
949	Xin thầy nói chậm hơn. 	（どうか）もっとゆっくり話してください	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
950	Đi đi!	行け	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
951	Vứt đi!	捨てろ	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
952	Cháu ngồi đi.	座りなさい	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
953	Chúng ta hãy đi đi.	さあ行きましょう	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
954	Anh hãy cẩn thận.	気をつけなさい	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
955	Hãy im lặng.	静かにしろ	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
956	Xin ông dạy cho cháu.	（どうか）私に教えてください	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
957	Mời anh ngồi.	どうぞ座ってください	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
958	Xin mời vào.	入ってください	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	1
959	Phong cảnh ở đây đẹp biết mấy! 	ここの景色はなんて美しいのでしょう	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
960	Hoa này đẹp quá!	この花はきれいだね	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
961	Chị ấy duyên dáng biết bao! 	彼女はなんて魅力的なのでしょう	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
962	Anh ấy đẹp trai biết mấy!	彼はなんてハンサムなのでしょう	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
963	Phòng này sáng làm sao!	この部屋はなんて明るいのでしょう	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
964	Hôm nay nóng quá!	今日は暑いね	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
965	Chị không biết nói tiếng Anh à? 	あなたは英語を話せないのですか	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
966	Xin lỗi, tôi ngồi đây được không ạ?	すみません、ここに座ってもいいですか	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
967	Anh vẫn còn học tiếng Việt chứ?	あなたはまだベトナム語を勉強していますよね	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
968	Anh vẫn ở khách sạn Thăng Long chứ?	あなたはまだタンロンホテルに滞在していますよね	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
969	Anh ấy dịch khá tốt đấy.	彼はかなり上手に訳しましたよ	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
970	Còn tức giận hả?	まだ怒っているの	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
971	Tôi trả tiền rồi mà.	私はもうお金を払ったじゃないですか	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
972	Hôm nay đến nhà mình chơi nhé.	今日は私の家に遊びに来てね	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
973	Hà Nội đông người quá nhỉ !	ハノイはとても人が多いですね	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
974	Hôm nay trời đẹp. 	今日は天気がいいです	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
976	bốn mùa	四季	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
977	mùa xuân, mùa hè, mùa thu, mùa đông	春、夏、秋、冬	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
978	mùa mưa, mùa khô	雨季、乾季	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
979	Trong bốn mùa, anh thích mùa nào nhất?	四季の中で、あなたはどの季節が一番好きですか	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
980	Bây giờ là mùa xuân nên trời đẹp.	今は春なので天気がいいです	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
981	Mùa đông, trời rét.	冬は寒いです	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
982	nhiệt độ	温度	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
983	nóng, lạnh, rét	暑い、寒い、寒い	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
984	nắng, nóng bức, nóng nực	日差しが強い、暑苦しい、暑苦しい	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
985	Trời đầy mây. 	曇っています	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
986	Trời mưa to. 	大雨が降っています	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
987	Trời đã tạnh rồi.	雨が止みました	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
988	mưa, mưa phùn	雨、霧雨	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
989	Gió thổi mạnh. 	強風が吹いています	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	1
990	gió mùa	季節風 	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	\N
991	Tuyết rơi. 	雪が降っています 	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	1
992	tuyết, bão tuyết	雪、吹雪	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]	\N	\N	\N
993	lụt, lụt lội	洪水	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]	\N	\N	\N
994	hạn hán	旱魃	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[21]	\N	\N	\N
995	Ngày mai thời tiết thế nào?	明日の天気はどうですか	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[22]	\N	\N	1
996	Ngày mai trời mưa to.	明日は大雨が降ります	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[23]	\N	\N	1
997	Tôi bị mưa.	私は雨に降られました	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[24]	\N	\N	1
998	Từ nhà tôi đến ga 2 km. 	私の家から駅まで2キロです	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
999	Tôi đi từ Hà Nội đến Hải Dương. 	ハノイからハイズオンまで行きます	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1000	Tôi đi chợ về.	市場に行ってきました	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1001	Anh ấy ở Mỹ đến.  	彼はアメリカから来た	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1002	Từ nhà tôi đến văn phòng đi xe máy hết 15 phút.	私の家からオフィスまでバイクで15分かかります。	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1003	Chúng ta đi bộ đến ga Ueno, sau đó lên tàu từ đấy.	上野まで歩いていき、そこから電車に乗りました。	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1004	Hàng ngày tôi học đến 11 giờ. 	毎日11時まで勉強します。	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1005	Hôm nay tôi lên lớp từ 1 giờ chiều.	今日の始業時間は午後1時からです。	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1006	Chúng em nói chuyện đến khuya. 	私たちは夜遅くまで話をしました	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1007	Hôm nay chúng ta bắt đầu học từ trang 120.	今日は120ページから始めます	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1008	Anh ấy ở Vinh ra Hà Nội. 	彼はヴィンからハノイに来た	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
1009	Anh ấy đi mua báo về.	彼は新聞を買って帰ってきた	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1010	Chị đi đâu về?	どこに行ってきましたか	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1011	Sáng mai hãy đến nhà tôi trước 9 giờ.	明日の朝9時までに私の家に来なさい	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
1012	Anh phải quay về đến 4 giờ chiều.	4時までに戻ってきなさい	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
1013	Từ 5 giở trở đi thì tôi có rỗi.	5時以降なら空いてます／ 5時以降なら暇です	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
1014	Mấy giờ cũng được.	何時でも構いません	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1015	Anh ấy hay lên miền núi.	彼はよく山岳地帯に行く	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1240	Ừ, chúng ta đi.	うん、行こう。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1016	Hai con mèo đen chạy vào vườn của nhà tôi. 	黒い猫が 2 匹私の家の庭に走りこんできました	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1017	Mời anh đến nhà tôi.	どうぞ私の家に来てください	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1018	Bây giờ tôi vào được không?	今入ってもいいですか	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1019	Chúng ta hãy ra sân.	さあ、庭へ出ましょう	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1020	Ông Hoàng xuống gác một.	ホアンさんは 1 階へ降りました	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1021	Bộ đội đang qua sông.	部隊は今、川を渡っているところです	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1022	Mai bố tôi ra Hà Nội.	明日、私の父はハノイへ来ます／明日、私の父はハノイへ行きます	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1023	Hôm qua mẹ tôi vào thành phố Hồ Chí Minh.	昨日、私の母はホーチミン市へ行きました／昨日、私の母はホーチミン市へ来ました	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1024	Tôi vừa lên Đà Lạt.	私はダラットに来たばかりです（低所→高所）	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1025	Mai tôi xuống Nha Trang.	明日、私はニャチャンに行きます（高所→低所）	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
1026	Tuần trước anh ấy lên Hà Nội.	先週、彼はハノイへ来ました（農村→都市）	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1027	Tháng sau chị ấy xuống Châu Đốc.	来月、彼女はチャウドックへ行きます（都市→農村）	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1028	Tôi gặp anh ấy ở khách sạn.	私はホテルで彼に会いました	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1029	Giữa anh và tôi không có bí mật.	あなたと私の間には秘密はありません	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1030	Tôi phải trả quyển sách này cho thầy giáo.	私は先生にこの本を返さなければなりません	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1031	Cái bàn này làm bằng gỗ.	この机は木でできています	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1032	Tôi đi học bằng xe máy.	私はバイクで通学します	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1033	Tôi đang tìm sách về kinh tế Việt Nam.	私はベトナム経済に関する本を探しています	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1034	Thầy Nam nghiêm khắc đối với sinh viên.	ナム先生は学生に対して厳しいです	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1035	Tôi muốn đi du lịch khắp thế giới.	私は世界中あらゆる所へ旅行に行きたいです	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1036	Hầu hết mọi người đều biết chuyện này.	ほとんど全ての人がこの話を知っています	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1037	Cả chị ấy lẫn tôi đều là sinh viên.	彼女も私も学生です	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
1038	Bất cứ việc gì tôi cũng làm.	どんな仕事でもします	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
1039	Tôi phải gọi điện lại cho anh Sang.	私はまたサンさんに電話をかけなければなりません。	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1040	Tôi chưa viết xong. 	私はまだ書き終えていません	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1041	Tuần trước tôi đã xem phim ấy rồi nhưng tuần này tôi muốn xem lại.	私は先週その映画を見ましたが、今週また見たいです	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1042	Em gái tôi khóc mãi.	私の妹はずっと泣いています	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1043	Tôi giải thích mãi mà anh ấy không hiểu.	私がずっと説明しても彼は分かりません	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1044	Hãy nghỉ một cái đã.	まず一休みしましょう	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1045	Tôi không muốn uống nữa	私はもうこれ以上飲みたくありません	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1046	Anh đã ăn hết chưa?	もう全部食べましたか	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1047	Anh nên đọc thêm những tài liệu này.	あなたはこれらの資料をもっと読んだほうがいいです	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1048	Anh phải làm lấy việc này.	あなたは自分でこの仕事をしなくてはなりません	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
1049	Em hãy hỏi mẹ thử.	（子供に）おかあさんに聞いてみなさい	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1050	Mời anh ăn thử.	どうぞ食べてみてください	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
1051	Chị hãy nhớ lại xem.	思い出してみなさい	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
1052	Tên người đó tôi quên mất rồi.	その人の名前は忘れてしまいました	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	1
1053	Hôm qua tôi mua phải hàng giả.	昨日偽物を買ってしまった	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
1054	Anh ấy yêu cô ấy đến mức có thể chết vì cô ấy. 	彼は彼女のためなら死んでも構わないほど彼女を愛している	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1055	Bài tập này khó đến mức ngay cả anh ấy không làm được.	この練習問題は彼でもできないほど難しい	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1056	Tối qua trời lạnh đến nỗi có tuyết.	昨晩は雪が降るほど寒かったです	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1057	Anh ấy có nhiều tiền đến nỗi không biết nên tiêu vào việc gì.	彼は何に使っていいか分からないほどお金を持っている	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1058	Con mèo đã ngủ 4 tiếng. 	ネコは 4 時間眠った	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1059	Con mèo đã ngủ tới 4 tiếng.	ネコは 4 時間も眠った	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1060	Anh ấy đi nước ngoài những 3 năm.	彼は 3 年間も外国に行っていた	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1061	Bể bơi này sâu tới 4m.	このプールは深さが 4 メートルもある	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1062	Anh ấy học đến tận 11 giờ tối.	彼は夜 11 時まで勉強した	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1063	Các anh ấy họp có mười lăm phút.	彼らは 15 分だけ会合をした	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1064	Chị ấy mua có một cái bút.	彼女は 1 本だけペンを買った	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1065	Các anh ấy họp mỗi mười lăm phút.	彼らは 15 分だけ会合をした	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1066	Tôi thường vừa nghe nhạc vừa học.	私はよく音楽を聴きながら勉強します	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1067	Chị ấy vừa ngồi tàu vừa ngắm cảnh.	彼女は電車で座りながら景色を見ている	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1068	Cái nhà này vừa cũ vừa đắt.	この家は古いし値段が高いです	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1069	Chị ấy vừa đẹp vừa hiền.	彼女は綺麗だし優しいです	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1070	Phòng này vừa là nhà bếp vừa là phòng ăn.	この部屋は台所でもあるし食堂でもある	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1071	Mùa hè Nhật Bản không những nóng mà còn oi bức.	日本の夏は暑いばかりでなく蒸し暑いです	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1072	Chị ấy không chỉ biết nói tiếng Anh mà còn biết nói tiếng Nga nữa.	彼女は英語が話せるだけでなくロシア語も話せます	null		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1073	Chị ấy trở thành ca sĩ. 	彼女は歌手になった	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1074	Ông ấy trở nên giàu có. 	彼は裕福になった	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1075	Thời tiết trở nên ấm áp hơn. 	天気が暖かくなった	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1076	Cô ấy trở thành một nhà văn nổi tiếng.	彼女は有名な作家になった	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1077	Một nông thôn trở thành đô thị mới.	農村がニュータウンになる	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1078	Vấn đề trở nên phức tạp.	問題が複雑になる	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1079	Các sinh viên trong lớp trở nên thân mật.	クラスの学生たちは親しくなった	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1080	Cô giáo mới chia lớp thành 3 nhóm nhỏ.	新しい先生はクラスを 3 つの小グループに分けた	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1081	Mẹ tôi cắt bánh sinh nhật thành 5 miếng.	母は誕生ケーキを 5 つに切った	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1082	Bà phù thủy biến hoàng tử thành một con ếch.	魔法使いは王子をカエルにした	null		\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
1083	Bao giờ anh ấy cũng ngủ quên. 	彼はいつも寝坊する	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1084	Anh ấy không bao giờ xem phim. 	彼は絶対に映画を見ない	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1085	Tôi chưa bao giờ đi miền trung. 	私はまだ中部に行ったことがありません	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1086	Tôi chưa đi nước ngoài lần nào. 	私はまだ外国へ行ったことがありません	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1087	Anh đã đi Thái Lan lần nào chưa? 	あなたはタイに行ったことがありますか	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1088	Rồi, tôi đã đi Thái Lan rồi. 	はい、タイに行ったことがあります	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1089	Bao giờ anh ấy cũng đi học đúng giờ.	彼はいつも遅刻しない	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1090	Ông ấy lúc nào cũng uống rượu.	彼はいつも酒を飲んでいる	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1091	Tôi chưa bao giờ đi Huế.	私はまだフエに行ったことがありません	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1092	Anh đã bao giờ đi Huế chưa?	フエに行ったことがありますか	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
1093	Rồi, tôi đã đi Huế rồi.	はい、フエに行きました	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
1094	Chưa, tôi chưa bao giờ đi Huế.	いいえ、まだフエに行ったことはありません	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
1095	Tôi chưa ăn món ăn Trung Quốc lần nào.	私はまだ中華料理を食べたことがありません	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1096	Ước gì anh ấy bảo tôi trước.	彼は前もって私に言ってくれたらよかったのに	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1097	Ước gì anh ấy đến thăm tôi.	彼が訪ねてきてくれればいいのに	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1098	Tôi mong gặp lại chị.	またお会いしたいです	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1099	Cô ấy muốn tôi đi với cô ấy.	彼女は、私が彼女と一緒に行くことを望んでいる	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1100	Tôi hy vọng anh ấy sẽ sớm bình phục.	彼に早く回復して欲しい	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1101	Tuy đứa con không nói gì nhưng người mẹ vẫn hiểu.	子供は何も言わなくても母親は分かるのです	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1102	Tuy tôi chưa gặp chị ấy nhưng tôi đã nghe nói nhiều về chị ấy.	私は彼女に会ったことはありませんが、彼女のことはよく聞いています	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1103	Dù đã uống thuốc ngủ, tôi vẫn không ngủ được	私は睡眠薬を飲んだのに眠れません	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1104	Mặc dù anh ấy bị mệt nhưng anh ấy vẫn đi học.	彼は疲れていますが、学校に行きます	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1105	Mặc dù vô tuyến này rất đắt nhưng anh ấy vẫn mua.	このテレビはとても高いのですが、彼は買いました	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1106	Tuy vậy chúng tôi vẫn thua cuộc.	それでも私たちは負けました	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1107	Thế nhưng tôi đã chẳng nghe nói gì cả.	でも何も聞いていないですよ	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1108	Không có kinh nghiệm, làm sao mà vượt qua khó khăn như thế này được.	経験がないと、どうしてこのような困難を乗り越えることができようか	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1109	Tôi làm sao mà làm việc đó một mình được. 	どうして私ひとりでその仕事ができようか	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1110	Đủ điều kiện, lẽ nào lại không thành công.	条件が十分揃っているので、成功しないわけがない	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1111	Lẽ nào anh ấy lại không biết.	彼が知らないわけがない	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1112	Anh chẳng nói thế là gì?	そう言ったでしょうが	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1113	Nếu tôi có tiền thì tôi sẽ mua nhà.	もしお金があれば、私は家を買います	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1114	Nếu tôi đi Hà Nội thì tôi sẽ đi bằng máy bay.	もしハノイに行くなら、私は飛行機で行きます	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1115	Anh mà không chịu học thì không thi đỗ được.	頑張って勉強しないと試験に受かることができませんよ	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1116	Chị ấy có nhờ thì tôi mới giúp.	彼女が頼めば私は手伝います	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1117	Phải chăm học mấy năm, anh mới thi đỗ lấy tư cách đó được.	まじめに数年勉強してはじめて、その試験に合格し資格を得ることができるのです	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1118	Giả tôi trẻ lại được thì tôi muốn lập gia đình với cô ấy.	仮に若返ることが出来るとしたら、私は彼女と結婚したいです	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1119	Giả sử có người hỏi, anh sẽ trả lời sao?	仮に誰か質問する人がいたら、あなたはどのように答えるのですか	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1120	Anh phải đọc bài này cẩn thận, chứ không thì không thể hiểu được.	あなたはこの文章を注意して読まなければなりません。でないと理解できません	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
1121	Chị phải đi ngay bây giờ, nếu không chị sẽ không kịp.	あなたは今すぐいかなくてはなりません。そうしないと間に合いません	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1122	Anh nên xin lỗi vợ, nếu không chị ấy sẽ giận lắm.	あなたは奥さんに謝るべきです。そうしないと彼女は非常に怒りますよ	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1123	Tôi nghĩ rằng anh ấy không đến. 	私は彼は来ないと思います	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1124	Chị ấy nói rằng chị ấy sẽ thôi việc tại công ty. 	彼女は仕事を辞めると言いました	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1125	Ai cũng biết là anh Tân chăm học. 	タンさんが熱心に勉強していることは誰もが知っています	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1126	Mỗi lần đi máy bay, tôi sợ là máy bay rơi. 	飛行機に乗る度に飛行機が落ちないか心配になります	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1127	Tôi cho rằng chị ấy là một người tốt bụng.	彼女はいい人だと思います	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1128	Tôi tin là anh ấy không bao giờ nói dối.	彼は決して嘘をつかないと信じています	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1129	Tôi nghi là anh ấy nói dối.	彼は嘘をついているのではないかと疑っています	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1130	Tôi sợ là cơn bão đổ bộ vào miền này.	台風がこの地方に上陸するのではと恐れています	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1131	Mẹ anh ấy lo là anh ấy bị tai nạn trong du lịch.	彼の母親は旅行中彼が事故に遭わないか心配しています	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1132	Mẹ tôi sai tôi đi mua rau. 	母は私に野菜を買ってくるように言いました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1133	Bố tôi bảo tôi không thức khuya. 	父は私に夜更かししないよう言いつけました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1134	Thầy giáo bảo các sinh viên ôn tập nhiều.	先生は学生たちによく復習するように言いました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1135	Anh ấy khuyên tôi không uống rượu nhiều.	彼は私にあまり酒を飲まないよう忠告しました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1136	Công an yêu cầu tôi xuống xe.	警察は私に車から降りるように要求しました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1137	Tôi nhờ anh ấy làm giúp bài tập này.	彼に宿題を手伝ってもらうよう頼みました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1138	Chị ấy rủ tôi đi xem phim.	彼女は私を映画に誘いました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1139	Tôi đề nghị ngày mai chúng ta nghỉ học.	私は明日は休講にしようと提案しました	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1140	Ủy ban bầu chị Hoa làm chủ tịch. 	委員会はホアさんを委員長に選出しました	null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1141	Chủ quán chọn cô ấy làm tính toán. 	店長は彼女を経理係に選びました	null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1142	Nhân dân Ucraina bầu ông Yuschenco làm tổng thống.	ウクライナの国民はユーシェンコ氏を大統領に選出しました	null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1143	Giám đốc chọn chị ấy làm thư ký mới.	社長は彼女を新しい秘書に選びました	null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1144	Bộ ngoại giao cử ông ấy làm đại sứ Việt Nam.	外務省は彼をベトナム大使に任命しました	null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1145	Chúng ta biếu quà cho cô giáo.	私たちは先生に贈り物を贈りました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1146	Tôi tặng bó hoa cho mẹ. 	母に花束を贈りました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1147	Cô giáo cho các sinh viên từ điển tiếng Việt.	先生は学生たちにベトナム語辞典をあげました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1148	Mẹ cho tôi một chút tiền để mua sách.	母は私に本を買うためのお金をくれました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1149	Hiệu trưởng phát phần thưởng cho học sinh.	校長先生が生徒を表彰しました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1150	Ông Cường phát lương cho nhân viên.	クオンさんが社員に給料を配りました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1151	Nhân ngày sinh nhật, tôi biếu quà cho bà nội.	誕生日を祝して、おばあちゃんに贈り物を贈りました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1152	Anh ấy đưa tài liệu cho tôi.	彼は私に資料を渡しました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1153	Tôi phải gửi những hàng này tới địa chỉ này.	この荷物をこの住所まで送らなくてはなりません	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1241	Chào Vân.	こんにちは、ヴァン。			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1154	Tôi nhờ anh ấy chuyển bức thư cho gia đình tôi.	彼に私の家族に手紙を届けてくれるよう頼みました	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1155	Anh vay tiền của ai? 	あなたは誰からお金を借りたのですか	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1156	Tôi mượn cuốn sách của thư viện 	図書館で本を借りました	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1157	Tôi mượn cuốn sách này của anh ấy.	彼からこの本を借りました	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1158	Em mượn cuốn sách này của ai ?	誰からこの本を借りたの	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1159	Tôi thuê xe của công ty ấy.	その会社から車を借りました	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1160	Tôi đã nhận báo cáo của chị ấy.	彼女からレポートを受け取りました	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1161	Cả chủ Nhật cũng phải đi làm thêm.	（他の日は当然として）日曜日も仕事に行かなければなりません	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1162	Cả chị ấy cũng biết chuyện ấy.	彼女でさえもその話を知っています	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1163	Anh phải làm ngay bây giờ.	あなたは今すぐしなければなりません	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1164	Chính các bạn là những người chủ tương lai.	皆さんこそが未来の担い手です	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
1165	Em đừng có nghĩ như thế.	そのように考えてはなりません	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1166	Mẹ tôi đã lo đến gầy người.	私の母はやせるほど心配していました	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1167	Tôi muốn mua cả hai cái này.	私はこれらを 2 つとも買いたいです	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1168	Mai chúng ta gặp nhau ở đây đúng 3 giờ chiều nhé.	明日午後 3 時ちょうどにここで会いましょう	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1169	Anh ấy uống những 5 chai bia.	彼はビールを 5 本も飲みました	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
1170	Đồng hồ tôi nhanh đến mười ba phút.	私の時計は 13 分も進んでいます	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
1171	Chị ấy chỉ ăn có một bát cơm.	彼女は 1 杯しかご飯を食べていません	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
1172	Ai cũng biết cả.	誰でも知っています	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
1173	Tôi không biết đâu.	私は全く知りません	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	1
1174	xa xa	やや離れた	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1175	xanh xanh	やや青い	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1176	đo đỏ	やや赤い	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1177	nho nhỏ	やや小さい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1178	là lạ	少し変な	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
1179	kho khó	やや難しい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
1180	đèm đẹp	まあまあ美しい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1181	man mát	少し涼しい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1182	Hãy đứng xa xa mà nhìn lại.	少し離れて立ってもう一度見てください	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
1183	Xin cho tôi xem một cái nho nhỏ.	少し小さいのを見せてください	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	\N
1184	đẹp đẽ	美しい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	\N
1185	vui vẻ	うれしい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	\N
1186	khó khăn	困難な	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]	\N	\N	\N
1187	sạch sẽ	清潔な	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]	\N	\N	\N
1188	Tình hình khó khăn	困難な状況	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]	\N	\N	\N
1189	Căn phòng sạch sẽ	清潔な部屋	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]	\N	\N	\N
1190	Nhà cửa ở nông thôn rộng rãi.	農村の家は広いです	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]	\N	\N	1
1191	Tình hình hiện nay rất khó.	現在の状況はとても厳しい	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]	\N	\N	\N
1192	Sáng mai làm ơn đánh thức tôi vào lúc sáu giờ rưỡi.	明日の朝6時半に起こしてください	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1193	Tôi đã đánh rơi tài liệu.	私は資料を落としました	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1194	cho mượn	貸す	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
1196	Gần đây có một ngôi nhà cho thuê.	この近くに貸家が 1 軒あります	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1197	Anh ấy nói：Tôi không đi.	彼は言いました。「私は行きません」	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
1198	Anh ấy nói là anh ấy không đi.	彼は行かないと言いました	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
1199	Anh ấy nói : Khi nào có kết quả thì xin anh cho tôi biết.	彼は言いました。「結果が分かったら私に教えてください」	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1200	Anh ấy đã yêu cầu tôi là khi nào có kết quả thì cho anh ấy biết.	彼は結果が分かり次第知らせるように私に要求しました。	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
1201	Chị ấy là ai?	彼女は誰ですか	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1202	Chị ấy là người nước nào?	彼女はどこの国の人ですか	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1203	Anh có biết chị ấy là ai không?	あなたは彼女が誰だか知っていますか	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
1204	Anh có biết chị ấy là người nước nào không?	あなたは彼女がどこの国の人か知っていますか	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
1205	Em chào anh ạ.	こんにちは。	挨拶する		\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1206	Chào em.	こんにちは。	挨拶をする		\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1207	Lâu lắm rồi không gặp anh.	お久しぶりですね。			\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1208	Anh có khoẻ không?	お元気ですか？	挨拶をする		\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1209	Anh vẫn khoẻ.	はい、元気です。			\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1210	Cả gia đình em có khoẻ không?	ご家族の皆さんはお元気ですか？	挨拶をする		\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1211	Dạ, gia đình em cũng khoẻ cả ạ.	はい、みんな元気です。			\N	dmod	vi01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1212	Hà ơi, đã ăn sáng chưa? 	ハー、もう朝ご飯食べた？ 			\N	dmod	vi02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1213	Tôi chưa ăn.	まだ食べてないの｡ 			\N	dmod	vi02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1214	Có bánh mì và cà phê đây.	パンとコーヒーがあるけど食べる？ 			\N	dmod	vi02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1215	Hay quá!	わーい｡			\N	dmod	vi02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1216	Cảm ơn nhiều nhé.	ありがとう｡	感謝する		\N	dmod	vi02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1217	Không có gì.	いえいえ、どういたしまして｡			\N	dmod	vi02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1218	Hôm nay siêu thị này đông người quá!	今日はこのスーパー混んでるね。			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1219	Ừ, nhỉ. 	うん、そうだね｡ 			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1220	Này, trông kìa!	ねえ、見て！	注意をひく		\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1221	Thầy giáo kìa!	先生がいる！			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1222	Thôi, chúng mình đi thôi.	もう、行きましょうよ｡ 			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1223	Sao?	どうして？			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1224	Chúng mình phải chào hỏi chứ.	挨拶しなきゃ｡			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1225	Không!	だめよ！			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1226	Tôi chưa làm bài tập của thầy mà. 	先生の宿題まだやってないんだから｡			\N	dmod	vi03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1227	Em nhớ tên anh không?	僕の名前覚えてる？			\N	dmod	vi04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1228	Xin lỗi, em không nhớ ạ.	すみません、思い出せないんですけど。 			\N	dmod	vi04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1229	Có lẽ lâu quá rồi.	かなり前のことかもしれません･･･。 			\N	dmod	vi04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1230	Anh tên là gì ạ?	お名前は何とおっしゃいましたか。 			\N	dmod	vi04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
1231	Anh tên là Bình, đang học tiếng Nhật ở trường Đại học Ngoại ngữ Tokyo.	私はビンで、東京外国語大学で日本語を勉強しています。			\N	dmod	vi04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1232	À, em nhớ ra rồi.	 ああ、思いだしました。			\N	dmod	vi04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1233	Chào anh Hải.	おはよう、ハイさん。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1234	Chào Mai.	おはよう、マイ。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1235	Xin lỗi anh.	ごめんなさい。	あやまる		\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1236	Em đến muộn.	遅れちゃった。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1237	Không sao.	大丈夫。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1238	Anh cũng mới đến.	僕も来たばかりなんだ。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1239	Chúng ta đi đi.	行きましょう。			\N	dmod	vi05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1242	Chào Long.	こんにちは、ロン。			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1243	Hôm nay là sinh nhật Vân, đúng không?	今日はヴァンの誕生日だよね？			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1244	Tôi tặng bạn quyển sách này.	この本を君にプレゼントするよ。	何かをあげる		\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1245	Chúc bạn sinh nhật vui vẻ.	お誕生日おめでとう！			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1246	Ôi, cảm ơn bạn.	あっ、どうもありがとう。			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1247	[Mở quà…]	（開ける…）			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1248	A! Sách tiếng Nhật à.	あー！日本語の本ね。			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
1249	Hay quá!	嬉しい！			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
1250	Cám ơn Long nhiều.	どうもありがとう。			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[5]	\N	\N	\N
1251	Không có gì.	どういたしまして。			\N	dmod	vi06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1252	Chị Thu ơi.	トゥーさん、			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1253	Có lẽ em phải về trước ạ.	お先に失礼します。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1254	Sao thế?	どうして？			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1255	Em mệt à?	疲れたの？			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1256	Không ạ.	いいえ、			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1257	Em có hẹn vào 6 giờ tối nay.	今晩6時に約束があるんですよ。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1258	Thế à.	そうなの。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1259	Em gửi lời chào mọi người nhé.	みなさんによろしく。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1260	Ừ.	はい。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1261	Đi cẩn thận nhé.	気をつけてね。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1262	Vâng.	はい。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1263	Tạm biệt chị.	さよなら。	さよならを言う		\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1264	Hẹn gặp lại tuần sau nhé.	また来週。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
1265	Chào em.	さよなら。	さよならを言う		\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1266	Hẹn gặp lại nhé.	またね。			\N	dmod	vi07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1267	Chị ơi.	すみません、			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1268	Cái túi đỏ này bao nhiêu tiền ạ?	この赤いバッグはいくらですか？	情報を求める（金額）		\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1269	Bốn mươi nghìn em ạ.	4万ドンです。			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1270	Đắt quá!	高い！			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1271	Bớt được không ạ?	まけてくれませんか？			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1272	Không được đâu.	まけられませんよ。			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1273	Thế thì ba mươi lăm nghìn nhé.	じゃあ、3万5千ドンで。			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1274	Thế thì rẻ quá.	それでは安すぎます。			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1275	Nhưng mà thôi, bán cho em vậy.	でも、しかたがない、いいですよ。			\N	dmod	vi08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1276	Dạo này có nhiều chương trình đi du lịch nước ngoài nhỉ.	最近は海外旅行のツアーがたくさんあるよね。 			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1277	Em cũng muốn đi. 	私も行きたいな。 			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1278	Dạo này vé máy bay rất rẻ. 	今の時期は航空券は安いよ。 			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1279	Em muốn đi nước nào? 	 どこに行きたいの？			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1280	Nhật. 	日本かな。			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1281	Nghe nói là thành phố nào cũng sạch sẽ và phong cảnh đẹp lắm.	どの都市もきれいだし、景色もとてもいいんだって。			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1282	Thế anh đã đến Nhật lần nào chưa?	ゴックさんは日本に行ったことある？ 	情報を求める（経験） 		\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
1283	Tôi đi 2 lần rồi. 	 2回あるよ。			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1284	Tôi đã từng đi Nagano và Okinawa.	長野と沖縄に行ったよ。			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1285	Thế ạ?	そうなの。			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1286	Thích nhỉ!	いいなぁ。			\N	dmod	vi09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1287	Từ tuần sau là nghỉ hè rồi. 	来週から夏休みだね。 			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1288	Anh có định đi đâu không? 	どこか行く予定ある？ 			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1289	Có. 	 あるよ。			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1290	Anh định đi biển với gia đình. 	家族と海に行くんだ。	 予定を言う		\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1291	Thích nhỉ!	いいねえ。			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1292	Khi nào anh đi? 	 いつ行くの？			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1293	Chủ nhật tuần sau. 	来週の日曜日だよ。			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1294	Lâu lắm rồi anh không đi biển. 	海に行くのは久しぶりだなぁ。 			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1295	Sướng quá nhỉ!	いいわね。			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1296	Em thì không được đi đâu cả.	私はどこにも行けないんだもん。			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1297	Sao thế? 	どうして？ 			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1298	Em phải đi làm thêm, chán lắm. 	 アルバイトしないと。あー、つまらない。			\N	dmod	vi10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1299	Em học tiếng Nhật bao lâu rồi? 	日本語はどのくらい勉強しているんですか？ 			\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1300	Dạ, em học tiếng Nhật được 1 năm. 	1年勉強しています。 			\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1301	Em thấy tiếng Nhật thế nào? 	日本語はどうですか？ 	情報を求める（程度） 		\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1302	Em thấy chữ Hán rất khó. 	漢字はとてもむずかしいと思います。			\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1303	Mặc dù em tập viết nhiều lần nhưng mà vẫn hay quên. 	何度書く練習をしてもすぐに忘れてしまいます。 	ある条件での行動を言う		\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1304	Thế còn phát âm thì sao? 	 じゃあ発音はどうですか？	情報を求める（程度）		\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1305	Phát âm thì em thấy không khó lắm ạ. 	発音はそれほど難しいとは思いません。			\N	dmod	vi11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1306	Hải ơi, bạn anh cho anh 2 vé xem phim.	ハイちゃん、友達に映画のチケットを２枚もらったんだよ。			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1307	Chúng mình cùng đi xem nhé. 	一緒に見に行かない？			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1308	Hay quá!	いいねえ！			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1309	Bao giờ ạ?	いつですか？			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1310	Chiều mai. 	明日の午後だよ。 			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1311	Phim bắt đầu lúc mấy giờ hả anh? 	何時に始まるんですか？ 	情報を求める（時間） 		\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1312	4 giờ chiều đấy. 	 4時だよ。			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1313	Em đợi anh ở nhà nhé.	家で待っててね。			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1314	Anh sẽ đến đón. 	迎えに行くから。			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1315	Thế thì tốt quá, em cảm ơn anh ạ. 	そうしてもらえたら助かります、よろしくお願いします。	感謝をする 		\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1316	Không có gì. 	 どういたしまして。			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1317	Thôi, thế nhé.	それじゃあね。			\N	dmod	vi12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1318	Chị Trang ơi.	チャンさん、			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1319	Cho tôi biết số điện thoại của chị được không?	電話番号教えてくれない？	情報を求める（数字）		\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1320	Dạ, được.	いいわよ。			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1321	Anh ghi đi, 8341765.	書いてね、8341765。			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1322	Tôi đọc lại nhé, 8341765.	繰り返すよ、8341765。			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1323	Đúng không?	あってる？			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1324	Đúng rồi đấy.	あってるよ。			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1325	Cám ơn chị nhé.	ありがとう。			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1326	Không có gì.	どういたしまして。			\N	dmod	vi13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1327	Chị Tú ơi.	トゥさん。			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1328	Ngày mai chị đi Đà Lạt, đúng không?	明日ダラットに行くんでしょ？			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1329	Vâng.	はい。			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1330	Tôi đi nghỉ 1 tuần.	1週間休暇で行くんです。			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1331	Thích nhỉ!	いいねえ。			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1332	Chị đi bằng gì?	何で行くの？			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1333	Tôi đi bằng ô tô.	車で行きます。	何でどのようにするかを言う		\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1334	Chị đi với ai?	誰と行くの？			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1335	Tôi đi với gia đình.	家族と行きます。			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1336	Chúc chị đi chơi vui vẻ nhé.	楽しんできてね。	機能		\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1337	Cảm ơn anh.	ありがとう。			\N	dmod	vi14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1338	Chị Liên ơi.	リェンさん。			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1339	Chị biết chơi nhạc cụ nào?	何か楽器を弾ける？	技能と能力についてたずねる		\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1340	Tôi biết chơi ghi-ta.	ギターが弾けます。	技能と能力についてたずねる		\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1341	Thế à?	そうですか。			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1342	Chị học bao lâu rồi?	どのくらいやってるの？			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1343	Ba năm rồi.	もう3年になるの。			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1344	Thế thì chị chơi giỏi lắm nhỉ?	じゃあ上手なんだね。			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1345	Bình thường thôi. 	普通ですよ。			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1346	Còn anh?	あなたは？			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1347	Tôi biết chơi pianô.	僕はピアノを弾けるよ。	技能と能力についてたずねる		\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1348	À, chị có biết chơi vi-ô-lông không?	あー、ヴァイオリンは弾ける？	技能と能力についてたずねる		\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1349	Không, tôi không biết chơi. 	ヴァイオリンは弾けないのよ。			\N	dmod	vi15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1350	Ở đây có bán từ điển Nhật-Việt không ạ?	ここに日越辞典はありますか？			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1351	Không, em ạ.	ありません。			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1352	Chị có biết ở đâu bán không ạ?	どこで売ってるかご存知ですか？			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1353	Ở hiệu sách Ngoại Văn.	外文書店で売ってますよ。			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1354	Hiệu sách Ngoại Văn ở đâu ạ?	外文書店はどこにありますか？	情報を求める（存在と場所）		\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1355	Ở phố Tràng Tiền.	チャンティエン通りです。			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1356	Dạ, em cám ơn chị.	わかりました、ありがとうございます。			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1357	Không có gì.	どういたしまして。			\N	dmod	vi16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1358	Bạn học tiếng Nhật ở đâu?	あなたはどこで日本語を勉強しましたか。	情報を求める（場所）		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1359	Ở Nhật Bản hay ở Việt Nam?	日本でですか、ベトナムでですか。			\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1360	Ở Việt Nam.	ベトナムでです。	機能		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1361	Giáo viên của bạn tên là gì? 	先生はどなたでしたか。	情報を求める（属性）		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1362	Thầy giáo của tôi tên là Sơn.	ソン先生でした。	機能		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1363	Lớp tiếng Nhật của bạn có bao nhiêu sinh viên?	あなたの日本語のクラスには学生が何名いますか。	機能		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1364	Lớp tiếng Nhật của tôi có 15 sinh viên.	わたしの日本語のクラスには学生が１５名います。	機能		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1365	À, quyển sách này của ai? 	えーっと、この本は誰のですか。	情報を求める（属性）		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1366	Quyển đó của tôi.	それはわたしのです。	機能		\N	dmod	vi17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1367	Nga học tiếng Nga thấy thế nào?	ガーさん、ロシア語の勉強はどうですか。	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1368	Khó lắm anh ạ, nhất là ngữ pháp.	とても難しいです、とくに文法は。	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1369	Tôi cũng nghĩ ngữ pháp tiếng Nga rất khó.	私もロシア語の文法はとても難しいと思います。	意見を言う		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1370	Nhưng phát âm thì không khó lắm.	だけど、発音はそんなに難しくないです。	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1371	Nhiều người cũng nói thế.	多くの人もそう言っています。	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1372	Về ngữ pháp thì Nga nên làm bài tập nhiều. 	文法については練習問題をたくさんするといいですよ。			\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1373	Tôi cũng nghĩ như thế.	わたしもそう思います。	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1374	Bây giờ chúng ta đi uống bia và tập nói tiếng Nga đi.	ビール飲みに行ってロシア語を話す練習しようよ。	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1375	Đồng ý.	賛成！	機能		\N	dmod	vi18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1376	Nga thích ăn cơm Nhật không?	ガーさん、日本料理は好きですか。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1377	Thích lắm.	大好きです。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1378	Nga thích món gì?	何が好きですか。	嗜好について述べる（もの）		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1379	Tôi thích sashimi.	刺身が好きです。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1380	Thế Dũng ăn được sashimi không?	で、ズンさんは刺身は食べられますか。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1381	Ăn được, nhưng mà tôi không thích lắm.	食べられますが、あまり好きではありません。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1382	Tôi chỉ thích ăn cơm Việt Nam thôi.	好きなのはベトナム料理だけです。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1383	Thế, trong món ăn Việt Nam thì Dũng thích món gì nhất?	では、ベトナム料理では何が一番好きですか。	嗜好について述べる（もの）		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1384	Tôi thích chả giò nhất.	チャーゾーが一番好きです。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1385	Thế, hủ tiếu thì Dũng có thích không?	では、フーティエウは好きですか。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1386	Không thích lắm 	あまり好きではありません。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1387	Tôi thích phở hơn. 	フォーの方が好きです。	機能		\N	dmod	vi19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1388	Thứ bảy, chủ nhật Phương thường làm gì?	フォンさんは週末はたいてい何をしますか。			\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1389	Tôi thường đi xem phim.	たいてい映画を見に行きます。	機能		\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1390	Tôi thích xem phim Mỹ.	わたしはアメリカの映画を見るのが好きです。	嗜好について述べる（行動）		\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1391	Còn Minh thường làm gì?	で、ミンさんは何をしますか。	機能		\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
1392	Chơi thể thao.	スポーツをします。	機能		\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1393	Thể thao, Minh thích môn nào nhất?	スポーツでは何が一番好きですか。	比べて述べる（最上級）		\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1394	Tôi thích bóng đá nhất.	サッカーが一番好きです。	比べて述べる（最上級）		\N	dmod	vi20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1395	Chị Minh ơi.	ミンさん、			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1396	Chị có biết thủ tục để đi Nhật không?	日本へ行くための手続き知ってる？			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1397	Biết, anh ạ.	知ってますよ。			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1398	Đầu tiên , anh phải đi làm hộ chiếu.	まず始めにパスポートを作りに行かないといけないのよ。	手順と順序について述べる		\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1399	Sau đó, anh đến Sứ quán Nhật xin visa.	次に、日本大使館でビザの申請をするの。	手順と順序について述べる		\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1400	Cuối cùng, anh đi mua vé máy bay.	そして最後に、航空券を買いに行くのよ。	手順と順序について述べる		\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	\N
1401	Thế làm hộ chiếu và visa mất bao lâu?	で、パスポートとビザの申請にはどのくらいかかるの？			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1402	Hộ chiếu thì 2 tuần.	パスポートは2週間。			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1403	Visa thì khoảng 3 tuần.	ビザはだいたい3週間ね。			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1404	Thế ạ.	そうですか。			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1405	Cám ơn chị.	ありがとう。			\N	dmod	vi21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1406	Chào anh Dũng.	やあ、ズン。			\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1407	Chào Trinh.	やあ、チン。			\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1408	Lâu lắm không gặp anh.	久しぶりね。			\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1409	Dạo này bố mẹ anh thế nào?	最近、ご両親はどう？	どうしているかをたずねる		\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1410	Bố mẹ tôi vẫn bình thường.	相変わらずだよ。			\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1411	À, em gái anh thế nào?	あー、妹さんはどうしてる？	どうしているかをたずねる		\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1412	Em gái tôi mới đi du học ở Nhật.	妹は日本へ留学したばかりなんだよ。			\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1413	Thế ạ.	そうなんだ。			\N	dmod	vi22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1414	Thoa ơi. 	トア、	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1415	Ngày kia trường chúng ta được nghỉ đấy, bạn đã biết chưa?	明後日は学校休みだよ、知ってた？	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1416	Thế à?	本当？	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1417	Thích nhỉ! 	うれしいな。	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1418	Thoa đã đi Bát Tràng chưa?	トアはバッチャンに行ったことがある？	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1419	Tôi định rủ mọi người đi Bát Tràng chơi.	僕は皆をバッチャンに行こうと誘うつもりなんだ。	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1420	Hay đấy!	いいわね。			\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1421	Ôi, nhưng tôi nghe nói ngày kia có thể trời mưa.	あ、でも明後日は雨が降るかもしれないらしいよ。	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1422	Thế à?	そうなの？	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1423	Nếu trời không mưa thì chúng ta đi Bát Tràng.	もし雨が降らなかったら、バッチャンへ行こう。	ある条件での行動を言う		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1424	Nếu trời mưa thì đến nhà tôi chơi nhé.	もし雨が降ったら、僕の家に遊びにおいでよ。	 		\N	dmod	vi23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
1425	Thùy ơi. 	トゥイー、	 		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1426	Cho Long mượn vở tiếng Anh của Thùy một chút có được không?	ちょっと英語のノートを貸してくれない？ 	 		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1427	Ừ. [Đưa vở cho Long]	うん。[ノートをロンに渡す]	 		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1428	[Mở vở] Ôi, chữ Thùy đẹp quá!	[ノートを開く]わあ、トゥイーの字、すごくきれいだね。	 		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1429	Không, chữ Long đẹp hơn chữ Thùy. 	いいえ、ロンの字は私の字よりきれいよ。	比べて述べる（比較と最上級）		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1430	Long nghĩ Thùy viết đẹp nhất lớp mình đấy. 	トゥイーはうちのクラスの中で一番きれいな字を書くと思うよ。 	比べて述べる（比較と最上級） 		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1431	Cám ơn Long. 	ありがとう。 	 		\N	dmod	vi24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1432	Em ơi, anh đói rồi. 	ホア、おなかすいちゃったよ｡ 	 		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1433	Em cũng thế. 	 私も。	 		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1434	Thế thì chúng ta đi ăn đi. 	 それじゃあ、食べに行こうか。	 提案する		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1435	Anh thích ăn phở. 	 フォーが食べたいな。	 		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1436	Em thích ăn gì ?	 ホアは何が食べたい？	 		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
1437	Em lại thích ăn bún chả. 	私はブンチャーが食べたいなぁ。	 		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1438	Thế thì chúng ta đi ăn bún chả nhé. 	それじゃあ、ブンチャーを食べに行こう。	 		\N	dmod	vi25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1439	Linh này, một năm nữa là em sẽ tốt nghiệp đại học nhỉ. 	リン、あと一年で大学卒業だね。	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1440	Dạ, đúng thế ạ. 	はい、そうです。 	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1441	Sau khi tốt nghiệp, em muốn làm nghề gì? 	卒業後はどんな仕事したいの？	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1442	Em muốn trở thành luật sư, anh ạ. 	弁護士になりたいんです。 	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1443	Vì sao em muốn trở thành luật sư? 	 それはどうして？	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1444	Vì em muốn giúp những người đang gặp khó khăn. 	困っている人たちの力になりたいからです。	理由を述べる		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1445	Thế à. 	そうか。 	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1446	Cố lên em nhé.	がんばってね。 	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1447	Dạ, vâng.	 はい。	 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1448	Cảm ơn anh ạ. 	ありがとうございます。	感謝する 		\N	dmod	vi26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1449	Em ơi, anh đang tìm em đấy. 	トゥイ、今ちょうど会いたかったとこなんだよ。 	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1450	Em chào anh ạ, anh có chuyện gì thế ạ ? 	こんにちは、どうかしたんですか？ 	挨拶をする 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1451	Anh muốn nhờ em ghi băng bộ phim tối nay, có được không? 	今夜の映画、録画して欲しいんだけど、いいかな？	依頼する 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1452	Được, phim gì ạ ? 	 はい、わかりました。何の映画ですか？			\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1453	Phim ’Titanic’. 	 ‘タイタニック’なんだけど。	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1454	Anh muốn xem mãi mà hôm nay lại bận, không xem được.	ずっと見たかったんだけど、今日も忙しくて見られないんだよ｡ 	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1455	Thế mấy giờ bắt đầu anh? 	で、何時に始まるんですか？	情報を求める（時間） 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1456	9 giờ. 	9時からだよ｡ 	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1457	Em ghi vào băng này cho anh nhé. 	このテープに録画してね｡ 			\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
1458	Vâng ạ. 	はい。 	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1638	Tôi phải mua áo lót mới.	新しい下着を買わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1459	Mai em sẽ mang băng đến cho anh. 	明日テープを持って来ます。	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1460	Cảm ơn em nhiều ! 	 本当にありがとう！	感謝する 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1461	Không có gì đâu ạ. 	 いいえ、とんでもないです｡	 		\N	dmod	vi27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1462	Huệ à, lâu lắm chúng mình mới gặp nhau nhỉ.	 やあ、フエ｡久しぶりだね｡	 		\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1463	Dạ, anh có khoẻ không ? 	そうですね、お元気ですか？ 			\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1464	Anh vẫn khoẻ. 	元気だよ｡			\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1465	Anh tưởng Huệ đang du học ở Pháp cơ mà. 	 フランスに留学に行ってるんじゃなかったっけ!?			\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1466	Dạ, tuần trước em mới từ Pháp về ạ. 	先週帰ってきたばかりです｡	 		\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1467	À , nghe nói là em rất giỏi tiếng Pháp, đúng không? 	 そうそう、聞いたんだけどフランス語ペラペラなんだって？			\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1468	Bình thường thôi ạ. 	 いえ、そんなことないです｡	 		\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1469	Em học như thế nào vậy ?	 どういうふうに勉強したの？			\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1470	Ví dụ, em đọc báo, nghe đài, nói chuyện với bạn,viết nhật ký, v.v...	例えば、新聞を読んだり、ラジオを聞いたり、友達と話したり、日記を書いたりいろいろです｡	例をあげる		\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1471	Em dùng tiếng Pháp trong tất cả mọi việc. 	 いつもフランス語を使っていました｡	 		\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1472	Em giỏi quá !	 すごいなぁ！			\N	dmod	vi28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1473	Huyền ơi. 	 フェン、	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1474	Thứ bảy này bạn có rảnh không? 	今週の土曜日暇？ 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1475	Rảnh.	暇ですよ。	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1476	Có chuyện gì vậy? 	何かあるの？ 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1477	Tôi nghe nói thầy Phong bị ốm. 	フォン先生が病気だって聞いたんだ。 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1478	Tôi định đến thăm thầy. 	お見舞いに行くつもりなんだよ。 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1479	Ôi, thế à? 	え、そうなの？ 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1480	Cho tôi đi cùng nhé. 	私も連れってよ。	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1481	Vâng, 2 giờ chiều gặp nhau ở cổng trường nhé. 	じゃあ、２時に校門で待ち合わせね。 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1482	Hai giờ chiều à? 	2時？ 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1483	Tôi bận. 	私、用事があるの。 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1484	Ba giờ có được không? 	3時でもいいですか？ 	 		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1485	Được, 3 giờ cũng được. 	うん、3時でもいいよ。 	妥協する		\N	dmod	vi29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1486	Thứ sáu tuần sau cho phép tôi nghỉ, được không ạ?	来週の金曜日、休ませていただいてもいいですか。	許可を求める		\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1487	Có chuyện gì vậy?	何かあるの？			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1488	Tôi đi đám cưới.	結婚式に行くんです。			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1489	Đám cưới của ai?	誰の結婚式なの？			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1490	Đám cưới của chị gái tôi.	姉の結婚式なんです。			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1491	Thế à? 	そうなの？			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1492	Được thôi. 	いいよ。			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
1493	Chúc vui vẻ.	楽しんできてね。			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
1494	Cám ơn anh ạ.	ありがとうございます。			\N	dmod	vi30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
1495	Em ơi.	ねぇ、			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1496	Anh nghe nói Nhà hát Tuổi Trẻ đang có vở kịch hay lắm.	トゥオイ・チェー劇場ですごくいい劇が上演されているって聞いたんだ。			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1497	Chủ nhật này chúng mình đi xem đi.	今度の日曜日に見に行こうよ。			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
1498	Thế à anh?	そう？			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1499	Mấy giờ ạ?	何時なの？			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1500	3 giờ chiều.	午後3時。			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1501	Không được rồi. 	だめよ。			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1543	Linh ơi, Tết này Linh có về Việt Nam không?	リンさん、テト（旧正月）はベトナムに帰りますか。	機能		\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1502	3 giờ rưỡi hôm đó anh phải đưa chị Giang ra sân bay, anh quên rồi ạ?	その日、3時半にザンさんを空港に連れて行かなくてはならないよ、忘れたの？	義務を確認する/肯定する		\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1503	Ừ nhỉ.	そうだった。			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1504	Anh quên mất.	忘れてた。			\N	dmod	vi31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1505	Em không được hút thuốc ở đây.	ここではタバコを吸ってはいけないわよ。	禁止する		\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1506	Em xin lỗi cô ạ.	すみません。			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1507	Nhà trường cấm hút thuốc trong lớp học.	学校は教室での喫煙を禁止しているのよ。	禁止する		\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1508	Em không biết à?	知らないの？			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1509	Dạ, em biết ạ.	はい、知っていましたが…			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1510	Sao biết mà em vẫn hút?	どうして知っているのに、吸おうとしていたの？			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1511	Từ nay em phải chú ý nhé.	これからは気を付けないといけませんよ。			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1512	Dạ, em hiểu rồi ạ.	はい、わかりました。			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1513	Từ nay em sẽ không hút thuốc trong lớp học nữa ạ.	これからは教室ではタバコを吸いません。			\N	dmod	vi32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1514	Các em hãy nhìn lên bảng.	みなさん、黒板を見なさい。	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1515	Chỗ này quan trọng lắm.	ここは大切ですよ。	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1516	Các em phải nhớ.	よく覚えなさい。	指示する		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
1517	Thưa thầy, em muốn hỏi một điều.	先生、ひとつお尋ねしたいことがあります。	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1518	Em hỏi đi.	どうぞ。	指示する		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1519	“những“ và “các“ khác nhau ở chỗ nào ạ?	“những“と“các“はどこが違うのでしょうか	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1520	Em nói to lên một chút.	もう少し大きな声で言ってください。	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1521	Thưa thầy , “những“ và “các“ khác nhau ở chỗ nào ạ?	はい先生、“những“と“các“はどこが違うのでしょうか。	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1522	À, thế này nhé…	あー、こういうことですよ．．．	 		\N	dmod	vi33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1523	Hôm nay các em thi ngữ pháp tiếng Nhật.	今日は日本語文法の試験をします。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1524	Em lo quá.	とても心配です。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1525	Em đừng lo.	心配しないでください。	非行為の依頼		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1526	Nếu chuẩn bị tốt, thi dễ thôi.	よく準備していれば、簡単ですから。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1527	Nhưng mà em vẫn lo lắm ạ.	でも、やっぱりとても心配です。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1528	Chắc chắn là bài thi khó lắm.	試験は絶対に難しいにきまってますから。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1529	Thôi, đến giờ rồi.	さあ、時間になりました。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1530	Chúng ta bắt đầu nhé.	始めましょう。	 		\N	dmod	vi34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1531	Thứ bảy này các em phải lên lớp.	今週の土曜日、みなさんは登校しなければなりません。	義務を確認する		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1532	Thầy dạy thêm ngữ âm tiếng Nhật.	日本語の音声を補講します。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1533	Chết rồi.	えっ、どうしよう。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1534	Em định đi chơi với người yêu.	恋人と遊びに行く予定だったのに。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1535	Bắt buộc phải lên lớp. 	必ず来なければなりません。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1536	Thứ bảy em lên lớp, chủ nhật em đi chơi đi.	土曜日は学校に来て、日曜日に遊びに行きなさい。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1537	Em hiểu rồi ạ.	分かりました。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1538	Các em không phải mang sách đâu.	教科書を持ってくる必要はありません。	義務を否定する		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1539	Chúng ta sẽ học ở phòng ngữ âm.	ＬＬ教室で勉強します。	機能		\N	dmod	vi35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
1540	Alô.	もしもし。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1541	Ai đấy?	誰ですか。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1542	Mình là Chi.	チーです。	機能		\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1544	Có.	はい。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1545	Thế Chi có về Việt Nam không?	で、チーはベトナムに帰りますか。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1546	Có.	はい。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1547	Ngày nào Linh về?	リンさんは何日に帰りますか。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
1548	Ngày 29 Tết.	暮れの２９日です。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1549	Mời Chi đến nhà tôi chơi.	チーさん、わたしの家に遊びに来てください。	招待する		\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1550	Ừ, cám ơn Linh.	リンさんありがとう。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1551	Khi nào Chi đến?	チーさん、いつ来ますか。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1552	Chiều mồng năm.	５日の午後。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
1553	Khoảng sáu giờ được không?	午後６時くらいでいいですか。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
1554	Được	いいですよ。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
1555	Nhà tôi ở 80 Trần Quốc Toản..	わたしの家はチャン・クオック・トアン通り８０番地にあります。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1556	Thôi, chào Chi nhé.	じゃあね、チーさん、さようなら。			\N	dmod	vi36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
1557	Trông em buồn thế.	どうしたの。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1558	Có chuyện gì vậy?	何かあったの？			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1559	Hôm nay em lỡ hẹn với Phương Anh.	今日はフオン・アィンとの約束を破っちゃったんだ。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1560	Em đã xin lỗi nhưng cô ấy vẫn giận.	謝ったけど、彼女はまだ怒ってるんだ。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1561	Gay nhỉ!	まずいわね。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1562	Em nên gọi điện xin lỗi cô ấy một lần nữa.	彼女に電話してもう一度謝ったほうがいいよ。	助言する		\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1563	Nếu chị là em, chị sẽ rủ Phương Anh đi xem phim cuối tuần này.	もしあたしがあなただったら、この週末フオン・アィンを映画に誘うわよ。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
1564	Vâng.	わかった。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1565	Ăn cơm xong em sẽ gọi điện thử.	ご飯を食べた後で電話してみるよ。			\N	dmod	vi37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1566	Hương ơi. 	フオンさん。			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1567	Hương đã viết xong bản báo cáo chưa? 	レポートを書き終わった？			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1568	Chiều nay tôi phải nộp cho giám đốc đấy.	今日の午後社長に提出しなくちゃいけないんだよ。			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
1569	Dạ chưa. 	いえ、まだです。			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1570	Xin lỗi anh.	ごめんなさい。			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1571	Còn nhiều không?	まだたくさん残ってる？			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1572	Còn khoảng 2 trang ạ.	2枚ぐらい残ってます。			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1573	Hãy hoàn thành trước 3 giờ chiều nhé.	午後3時までに完成してくださいね。	要求する		\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
1574	Dạ, em sẽ cố gắng.	はい、頑張ります。			\N	dmod	vi38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1575	Ngọc ơi.	ねぇゴク、			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1576	Em có bạn trai chưa?	ボーイフレンドいる？			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
1577	Dạ chưa.	いえ、まだです。			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1578	Em chưa biết tình yêu là gì.	愛情とは何かがまだ分からないんです。			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1579	Thế à?	そう？			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1580	Sau này, Ngọc muốn lấy người như thế nào?	将来、ゴクはどんな人と結婚したいの？			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1581	Em muốn lấy người trung thực và tử tế.	誠実で優しい人と結婚したいです。	希望を述べる		\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1582	Chúc em sớm tìm được người ấy nhé.	そういう人が早く見つかりますように。			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1583	Dạ, cám ơn anh ạ.	はい、ありがとうございます。			\N	dmod	vi39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
1584	Em chào anh Lương.	ルオンさん、こんにちは。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
1585	Chào em.	こんにちは。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
1586	Lâu lắm mới gặp nhỉ. 	久しぶりだね。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
1587	Anh giới thiệu với em, đây là anh Thịnh, bạn cùng lớp anh. 	紹介するね、こちらはティンさんで僕のクラスメートです。	人を紹介する		\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1637	Chị ấy thích mặc áo len.	彼女はセーターを着るのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1588	Còn đây là em Hiền, sinh viên năm thứ 2 trường Đại học Ngoại ngữ Hà Nội.	で、こちらはヒエンさんでハノイ外国語大学の2年生です。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	1
1589	Chào anh Thịnh.	はじめまして、ティンさん。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
1590	Rất vui được gặp anh.	よろしくお願いします。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
1591	Anh cũng rất vui được gặp em. 	こちらこそよろしく。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1592	Em học khoa nào?	何科で勉強してるの？			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1593	Khoa tiếng Pháp ạ.	フランス語科です。			\N	dmod	vi40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1594	Tôi phải mua áo lót mới.	新しいシャツを買わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1595	Người đàn ông ấy thường mặc áo sơ mi khi làm việc.	その男性は普段仕事に行くときにワイシャツを着ます。	\N		\N	vmod	\N	\N	\N	0	1
1596	Anh tôi làm việc ở sứ quán Nhật Bản.	私の兄は日本大使館で働いています。	\N		\N	vmod	\N	\N	\N	0	1
1597	Anh tôi làm việc ở sứ quán Nhật Bản.	私の兄は日本大使館で働いています。	\N		\N	vmod	\N	\N	\N	0	1
1598	Nó muốn trở thành bác sĩ trong tương lai.	その子は将来医者になりたいと思っています。	\N		\N	vmod	\N	\N	\N	0	1
1599	Trên bàn ăn có mấy quyển sách.	テーブルの上に何冊かの本があります。	\N		\N	vmod	\N	\N	\N	0	1
1600	Nếu tôi có nhiều tiền tôi muốn mua một ngôi nhà cho cha mẹ tôi.	もし私がたくさんのお金を持っていたら、両親に家を買ってあげたいです。	\N		\N	vmod	\N	\N	\N	0	1
1602	Ông ngoại tôi ghét chanh.	私のおじいさんはレモンが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
1603	Có khi chị tôi không ăn tối.	私の姉は時々夕食を食べません。	\N		\N	vmod	\N	\N	\N	0	1
1604	Chiều dài kệ sách này có mấy mét?	この本棚は縦何メートルあるのですか？	\N		\N	vmod	\N	\N	\N	0	1
1605	Tôi cho bạn lưu học sinh mượn một đĩa hát.	私は友達の留学生にレコードを貸します。	\N		\N	vmod	\N	\N	\N	0	1
1606	Hàng tuần vợ chồng ấy đi ăn tối ở nhà hàng.	毎週その夫婦はレストランに夕食を取りに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1607	Có khi chị tôi không ăn tối.	私の姉は時々夕食を食べません。	\N		\N	vmod	\N	\N	\N	0	1
1608	Xin cho tôi một cốc nước.	水を一杯ください。	\N		\N	vmod	\N	\N	\N	0	1
1609	Anh ấy cởi quần để bơi dưới sông.	彼は川で泳ぐためにズボンを脱ぎました。	\N		\N	vmod	\N	\N	\N	0	1
1610	Để con trai ấy ra ngoài chơi đi.	その男の子に外に遊びに行かせてあげなさい。	\N		\N	vmod	\N	\N	\N	0	1
1611	Sáng qua tôi đi dạo công viên.	昨日の朝私は公園を散歩しました。	\N		\N	vmod	\N	\N	\N	0	1
1612			\N		\N	vmod	\N	\N	\N	0	1
1613	Muốn đến cửa hàng rau quả thì anh rẽ phải ở đó, cửa hàng đó ở ngay bên trái đường.	八百屋に行きたいならそこを右に曲がってください、お店は道のすぐ左側にあります。	\N		\N	vmod	\N	\N	\N	0	1
1614	Khi mua ở cửa hàng tổng hợp chúng tôi thường đi bằng tắc xi.	デパートに買い物に行くとき、私たちは普段タクシーで行きます。	\N		\N	vmod	\N	\N	\N	0	1
1615	Ở Nhật Bản có cửa ra vào gọi là Genkan.	日本には玄関と呼ばれる出入り口があります。	\N		\N	vmod	\N	\N	\N	0	1
1616	Vì mùa đông trời rét nên người ta thường không mở cửa sổ.	冬は寒いので普通窓は開けません。	\N		\N	vmod	\N	\N	\N	0	1
1617	Hiện nay ai cũng ăn được bằng nĩa và dao.	今は誰もがフォークとナイフで食事ができます。	\N		\N	vmod	\N	\N	\N	0	1
1619	Đi giày dép này đi.	このスリッパを履きなさい。	\N		\N	vmod	\N	\N	\N	0	1
1620	Nó chưa đi mua hàng một mình lần nào.	その子はまだ一度も一人で買い物に行ったことがありません。	\N		\N	vmod	\N	\N	\N	0	1
1621	Đồ uống hộp thường dở.	缶入りの飲み物は普通まずいものです。	\N		\N	vmod	\N	\N	\N	0	1
1622	Dưới ghế có một con mèo màu nâu.	椅子の下に茶色の猫が一匹います。	\N		\N	vmod	\N	\N	\N	0	1
1623	Tôi không thích ở trong đám đông người.	私は人ごみの中にいるのが好きではありません。	\N		\N	vmod	\N	\N	\N	0	1
1624	Người đàn ông ấy thường mặc áo sơ mi khi làm việc.	その男性は普段仕事に行くときにワイシャツを着ます。	\N		\N	vmod	\N	\N	\N	0	1
1625	Thi tiếng Anh thì tôi thích bài đặt câu.	英語の試験なら私は作文が好きです。	\N		\N	vmod	\N	\N	\N	0	1
1626	Sáng qua tôi đi dạo công viên.	昨日の朝私は公園を散歩しました。	\N		\N	vmod	\N	\N	\N	0	1
1627	Nó chưa đi mua hàng một mình lần nào.	その子はまだ一度も一人で買い物に行ったことがありません。	\N		\N	vmod	\N	\N	\N	0	1
1628	Để con trai ấy ra ngoài chơi đi.	その男の子に外に遊びに行かせてあげなさい。	\N		\N	vmod	\N	\N	\N	0	1
1629	Đĩa này nhẹ quá.	この皿はとても軽いです。	\N		\N	vmod	\N	\N	\N	0	1
1630	Anh tôi làm việc ở sứ quan Nhật Bản.	私の兄は日本大使館に勤めています。	\N		\N	vmod	\N	\N	\N	0	1
1631	Anh tôi làm việc ở sứ quan Nhật Bản.	私の兄は日本大使館に勤めています。	\N		\N	vmod	\N	\N	\N	0	1
1632	Đây là lần đầu tiên em gặp anh họ em.	君は初めていとこに会うね。	\N		\N	vmod	\N	\N	\N	0	1
1633	Đây là lần đầu tiên em gặp anh họ em.	君は初めていとこに会うね。	\N		\N	vmod	\N	\N	\N	0	1
1634	Tôi có hai anh em.	私には二人の兄弟がいます。	\N		\N	vmod	\N	\N	\N	0	1
1635	Khi tôi còn trẻ, tôi thường bơi ở ao.	私がまだ小さかった頃、よく池で泳ぎました。	\N		\N	vmod	\N	\N	\N	0	1
1636	Ở miền bắc mùa đông phải mặc áo khoác.	北部では冬にコートを着なければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1639	Anh mang áo ngoài đi, dự báo thời tiết nói là tối nay trời lạnh.	上着を持っていきなさい、天気予報では今夜は寒いそうです。	\N		\N	vmod	\N	\N	\N	0	1
1640	Người đàn ông ấy thường mặc áo sơ mi khi làm việc.	その男性は普段仕事をするときにワイシャツを着ます。	\N		\N	vmod	\N	\N	\N	0	1
1641	Ở trường đại học tôi học về âm nhạc.	大学で私は音楽を学んでいます。	\N		\N	vmod	\N	\N	\N	0	1
1642	Thanh niên hay nghe nhạc phương Tây.	若者はよく洋楽を聞きます。	\N		\N	vmod	\N	\N	\N	0	1
1643	Ấn nút này để bật điều hoà.	エアコンを付けるならこのボタンを押しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1618	Chân giường này quá to, không đẹp lắm.	このベッドの脚は太すぎて格好悪い。	\N		\N	vmod	\N	\N	\N	0	1
1645	Bà tử tế lắm.	あなたはとても親切ですね。	\N		\N	vmod	\N	\N	\N	0	1
1646	Bà ngoại tôi sống ở ngoại ô.	私の祖母は郊外に住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
1647	Tuần sau gia đình em đi thăm nhà bà nội.	来週私の家族は祖母を訪ねに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1648	Phòng này bẩn quá!	この部屋はずいぶん汚いな！	\N		\N	vmod	\N	\N	\N	0	1
1649	Khi đi thành phố mới chị nên mua một tờ bản đồ.	知らない街に行くときは地図を買うほうがいいですよ。	\N		\N	vmod	\N	\N	\N	0	1
1650	Tôi đã photocopy trang này, nhưng để quên bản sao đó ở chỗ nào đó.	このページをコピーしましたが、そのコピーをどこかに置き忘れてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
1651	Cô Liên làm bánh kẹo rất ngon.	リエンさんはとてもおいしいケーキを作ります。	\N		\N	vmod	\N	\N	\N	0	1
1652	Tôi thích ăn bánh mì với bơ.	私はバターを塗ったパンが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1653	Ấn nút này để bật điều hoà.	エアコンを付けるならこのボタンを押しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1654	Ngày kia tôi bay vào Sài Gòn.	あさって私は飛行機でサイゴンに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1655	Bố tôi mắc bệnh.	私の父は病気になりました。	\N		\N	vmod	\N	\N	\N	0	1
1656	Tôi thích ăn bánh mì với bơ.	私はバターを塗ったパンが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1657	Khi tôi còn trẻ, tôi thường bơi ở ao.	私がまだ小さかった頃、よく池で泳ぎました。	\N		\N	vmod	\N	\N	\N	0	1
1658	Chị ấy luôn luôn ăn sáng với gia đình.	彼女はいつも家族と朝ごはんを食べます。	\N		\N	vmod	\N	\N	\N	0	1
1659	Có khi chị tôi không ăn tối.	私の姉は時々夕食を食べません。	\N		\N	vmod	\N	\N	\N	0	1
1660	Em ăn tối chưa?	もう夕飯は食べましたか？	\N		\N	vmod	\N	\N	\N	0	1
1661	Em họ tôi thường ăn hoa qủa sau bữa trưa.	私のいとこは普段昼食の後に果物を食べます。	\N		\N	vmod	\N	\N	\N	0	1
1662	Sau khi ăn trưa nó làm việc hăng hái hơn.	昼食を食べた後、彼はより張り切って仕事をします。	\N		\N	vmod	\N	\N	\N	0	1
1663	Thế thì treo bức ảnh này trên tường được không?	ではこの写真を壁に掛けてくれますか？	\N		\N	vmod	\N	\N	\N	0	1
1664	Chú tôi rất dễ béo bụng.	私の伯父はお腹が太りやすいです。	\N		\N	vmod	\N	\N	\N	0	1
1665	Chiều này anh đi đâu?	今日の夕方どこへ行きますか？	\N		\N	vmod	\N	\N	\N	0	1
1666	Bố tôi định xây dựng buồng tắm.	私の父は浴室を建設するつもりです。	\N		\N	vmod	\N	\N	\N	0	1
1667	Cho tôi một tờ giấy và một cây bút bi.	紙を一枚と、ボールペンを一本ください。	\N		\N	vmod	\N	\N	\N	0	1
1668	Tôi tặng bút chì chúc anh tôi thi đỡ.	私は兄が試験に合格することを祈って鉛筆を贈りました。	\N		\N	vmod	\N	\N	\N	0	1
1669	Nhiều nhà văn thích dùng bút máy.	作家の多くは万年筆を使うことを好みます。	\N		\N	vmod	\N	\N	\N	0	1
1670	Tôi gửi bưu thiếp cho gia đình.	私は家族に葉書を送りました。	\N		\N	vmod	\N	\N	\N	0	1
1671	Người Việt hay ăn cá sông, còn người Nhật hay ăn cá biển.	ベトナム人は川魚をよく食べますが、日本人は海魚をよく食べます。	\N		\N	vmod	\N	\N	\N	0	1
1672	Không được chơi cả ngày.	一日中遊んでいてはいけません。	\N		\N	vmod	\N	\N	\N	0	1
1673	Cà phê hay trà xanh, em thích loại nào hơn?	コーヒーと緑茶、どちらが好きですか？	\N		\N	vmod	\N	\N	\N	0	1
1674	Chúng ta ăn món ca ri ở quán ăn Ấn Độ.	私たちはインド料理屋でカレーを食べます。	\N		\N	vmod	\N	\N	\N	0	1
1675	Cả ngày anh ấy xem Internet.	彼は一日中インターネットを見ています。	\N		\N	vmod	\N	\N	\N	0	1
1677	Các bà ấy khoẻ lắm.	彼女らはとても元気です。	\N		\N	vmod	\N	\N	\N	0	1
1678	Các chị ấy đi làm bằng xe máy.	彼女らはバイクで仕事に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1679	Các cô ấy nói tiếng Việt rất giỏi.	彼女らはベトナム語を上手に話します。	\N		\N	vmod	\N	\N	\N	0	1
1680	Các ông ấy là giáo sư ở trường đại học này.	彼らはこの大学の教授です。	\N		\N	vmod	\N	\N	\N	0	1
1681	Tôi lớn lên ở căn hộ này.	私はこのアパートで育ちました。	\N		\N	vmod	\N	\N	\N	0	1
1682	Tôi bị thương cánh tay trong khi làm việc.	私は仕事中に腕に怪我をしてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
1683	Em hãy đạt câu.	作文しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1684	Cậu yêu ai?	君は誰を愛しているのですか？	\N		\N	vmod	\N	\N	\N	0	1
1685	Căn hộ này chỉ có cầu thang.	このアパートには階段しかないです。	\N		\N	vmod	\N	\N	\N	0	1
1686	Căn hộ này chỉ có cầu thang.	このアパートには階段しかないです。	\N		\N	vmod	\N	\N	\N	0	1
1687	Món ăn Hàn Quốc rất cay.	韓国料理は辛いです。	\N		\N	vmod	\N	\N	\N	0	1
1688	Cha tôi không bao giờ dậy muộn.	私の父は決して遅く起きません。	\N		\N	vmod	\N	\N	\N	0	1
1689	Con chó này chạy rất chậm.	この犬は走るのがとても遅いです。	\N		\N	vmod	\N	\N	\N	0	1
1690	Ước gì tôi có chị em.	私に姉妹がいたらよかったのに。	\N		\N	vmod	\N	\N	\N	0	1
1691	Tôi chưa bao giờ gặp chị họ của tôi.	私はいとこに一度も会ったことがない。	\N		\N	vmod	\N	\N	\N	0	1
1692	Tôi mất chìa khoá rồi!	鍵をなくしてしまいました！	\N		\N	vmod	\N	\N	\N	0	1
1693	Tôi có hai chị em.	私には姉妹が二人います。	\N		\N	vmod	\N	\N	\N	0	1
1694	Toà này chiều cao ba trăm mét.	この建物は三百メートルの高さがあります。	\N		\N	vmod	\N	\N	\N	0	1
1695	Chiều dài kệ sách này có mấy mét?	この本棚は長さ何メートルあるのですか？	\N		\N	vmod	\N	\N	\N	0	1
1696	Hàng tuần vợ chồng ấy đi ăn tối ở nhà hàng.	毎週その夫婦はレストランに夕食を食べに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1697	Đây là máy ảnh chú tôi mua cho tôi.	これは私の伯父が買ってくれたカメラです。	\N		\N	vmod	\N	\N	\N	0	1
1698	Cháu chào chú.	こんにちは。	\N		\N	vmod	\N	\N	\N	0	1
1699	Trời có mây.	空が曇っています。	\N		\N	vmod	\N	\N	\N	0	1
1700	Trời có mây.	空が曇っています。	\N		\N	vmod	\N	\N	\N	0	1
1701	Anh ấy cởi quần để qua sông.	彼は川を渡るためにズボンを脱ぎました。	\N		\N	vmod	\N	\N	\N	0	1
1676	Ca vát không quen thì thắt rất khó.	慣れないとネクタイを結ぶのはとても難しいです。	\N		\N	vmod	\N	\N	\N	0	1
1702	Không chỉ vào mùa đông mà còn vào mủa hè một số người Nhật cũng mặc com lê.	冬だけでなく、夏でも背広を着ている日本人もいます。	\N		\N	vmod	\N	\N	\N	0	1
1703	Dạo này anh ấy hay đi ra ngoài với một con gái.	最近彼は一人の女の子とよく出かけています。	\N		\N	vmod	\N	\N	\N	0	1
1704	Hai công an đứng trước cửa vào toà nhà kia đang nói chuyện với nhau.	あの建物の入り口に立っている二人のおまわりさんは話をしています。	\N		\N	vmod	\N	\N	\N	0	1
1705	Hàng ngày tôi đi công viên tập thể dục.	私は毎日公園に行って運動をします。	\N		\N	vmod	\N	\N	\N	0	1
1706	Khi nghe nhạc anh đóng cửa đi.	音楽を聴くときはドアを閉めなさい。	\N		\N	vmod	\N	\N	\N	0	1
1707	Sách này được in ba nghìn cuốn.	この本は三千部印刷されました。	\N		\N	vmod	\N	\N	\N	0	1
1708	Cửa hàng này 5 giờ sáng mở cửa.	このお店は朝五時に開店します。	\N		\N	vmod	\N	\N	\N	0	1
1709	Cha tôi không bao giờ dậy muộn.	私の父は決して遅く起きません。	\N		\N	vmod	\N	\N	\N	0	1
1710	Tôi thường dọn phòng vào thứ hai.	私は普段月曜日に部屋を掃除します。	\N		\N	vmod	\N	\N	\N	0	1
1711	Người đàn ông ấy thường mặc áo sơ mi khi làm việc.	その男性は普段仕事をするときにワイシャツを着ます。	\N		\N	vmod	\N	\N	\N	0	1
1712	Thi tiếng Anh thì tôi thích bài đặt câu.	英語の試験では私は作文が好きです。	\N		\N	vmod	\N	\N	\N	0	1
1713	Em hãy đạt câu.	作文しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1714	Đấy là bản đồ thế giới.	それは世界地図です。	\N		\N	vmod	\N	\N	\N	0	1
1715	Tôi cho bạn lưu học sinh mượn một đĩa hát.	私は友達の留学生にレコードを貸します。	\N		\N	vmod	\N	\N	\N	0	1
1716	Hôm nay nóng quá, chắc chắn hơn ba mươi lăm độ.	今日はとても暑い、きっと３５度以上あるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1717	Núi Phụ Sĩ có độ cao hơn ba nghìn mét.	富士山は３０００メートル以上の高さです。	\N		\N	vmod	\N	\N	\N	0	1
1718	Đồ uống hộp thường dở.	缶入りの飲み物は普通まずいものです。	\N		\N	vmod	\N	\N	\N	0	1
1719	Trời nắng lắm, đội mũ vào đi.	日が照っているから、帽子を被りなさい。	\N		\N	vmod	\N	\N	\N	0	1
1720	Bên phải nhà tôi có đồn công an.	私の家の隣には交番があります。	\N		\N	vmod	\N	\N	\N	0	1
1721	Trời lạnh đấy, đóng cửa lại đi.	寒いから、ドアを閉めなさい。	\N		\N	vmod	\N	\N	\N	0	1
1722	Khi nghe nhạc anh đóng cửa đi.	音楽を聴くときはドアを閉めなさい。	\N		\N	vmod	\N	\N	\N	0	1
1723	Tôi biết ăn đũa.	私は箸が使えます。	\N		\N	vmod	\N	\N	\N	0	1
1724	Muốn đến cửa hàng rau quả thì anh rẽ phải ở đó, cửa hàng đó ở ngay bên trái đường.	八百屋に行きたいならそこを右に曲がってください、お店は道のすぐ左側にあります。	\N		\N	vmod	\N	\N	\N	0	1
1725	Tôi muốn uống trà Lipton không đường.	砂糖が入っていない紅茶が飲みたいです。	\N		\N	vmod	\N	\N	\N	0	1
1726	Em họ tôi thường ăn hoa qủa sau bữa trưa.	私のいとこは普段昼食の後に果物を食べます。	\N		\N	vmod	\N	\N	\N	0	1
1727	Đừng hút thuốc ở đây, không có gạt tàn mà.	ここでタバコを吸わないでください、灰皿がないのですから。	\N		\N	vmod	\N	\N	\N	0	1
1728	Dưới ghế có một con mèo màu nâu.	椅子の下に茶色の猫が一匹います。	\N		\N	vmod	\N	\N	\N	0	1
1729	Ông ngoại tôi ghét chanh.	私のおじいさんはレモンが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
1730	Kiểm tra kỹ túi áo trước khi giặt.	洗濯の前に服のポケットをよく調べなさい。	\N		\N	vmod	\N	\N	\N	0	1
1731	Kiểm tra kỹ túi áo trước khi giặt.	洗濯の前に服のポケットをよく調べなさい。	\N		\N	vmod	\N	\N	\N	0	1
1732	Giày này đẹp mà đắt thế.	この靴きれいだけど、高いなぁ。	\N		\N	vmod	\N	\N	\N	0	1
1733	Cho tôi một tờ giấy và một cây bút bi.	紙を一枚と、ボールペンを一本ください。	\N		\N	vmod	\N	\N	\N	0	1
1734	Mùa thu không có nhiều ngày mưa gió.	秋はあまり風や雨のある日がありません。	\N		\N	vmod	\N	\N	\N	0	1
1736	Tháng tám hàng năm có rất nhiều khách du lịch ở sân bay.	毎年八月は多くの旅行客で空港は一杯になります。	\N		\N	vmod	\N	\N	\N	0	1
1737	Hàng tuần vợ chồng ấy đi ăn tối ở nhà hàng.	毎週その夫婦はレストランに夕食を食べに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1738	Anh đến đây mang mấy chiếc hành lý?	ここに来るのにいくつ荷物を持ってきましたか？	\N		\N	vmod	\N	\N	\N	0	1
1739	Ông nội tôi hay đi quán cà phê.	私の祖父はよく喫茶店に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1740	Nhà cửa ở Tokyo thường hẹp.	東京の家屋は大体狭いです。	\N		\N	vmod	\N	\N	\N	0	1
1741	Mặc dù đứa trẻ ấy mới bốn tuổi, nhưng nó biết viết tất cả các chữ Hiragana.	その子はまだ四歳にもかかわらず、全てのひらがなを書けます。	\N		\N	vmod	\N	\N	\N	0	1
1742	Em họ tôi thường ăn hoa qủa sau bữa trưa.	私のいとこは普段昼食の後に果物を食べます。	\N		\N	vmod	\N	\N	\N	0	1
1743	Người nước ngoài đó học tập chăm chỉ.	その外国人は真面目に勉強します。	\N		\N	vmod	\N	\N	\N	0	1
1744	Hôm kia tôi đã mua một chiếc khăn tay cho mẹ tôi.	一昨日私はお母さんのためにハンカチを一枚買いました。	\N		\N	vmod	\N	\N	\N	0	1
1746	Người ta sử dụng chữ Katakana khi viết địa danh và tên người nước ngoài.	私たちは外国人の名前や外国の地名を書く時にカタカナを使います。	\N		\N	vmod	\N	\N	\N	0	1
1747	Không có gì để làm cả, kể một chuyện vui nào đó cho tôi!	何もすることがない、何か面白い話をしてください。	\N		\N	vmod	\N	\N	\N	0	1
1748	Chiều dài kệ sách này có mấy mét?	この本棚は長さ何メートルあるのですか？	\N		\N	vmod	\N	\N	\N	0	1
1749	Tiếng Anh của tôi còn kém lắm.	私の英語はまだとても下手です。	\N		\N	vmod	\N	\N	\N	0	1
1750	Trẻ con rất thích ăn kẹo.	子供は飴を舐めるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1751	Hôm kia tôi đã mua một chiếc khăn tay cho mẹ tôi.	一昨日私はお母さんのためにハンカチを一枚買いました。	\N		\N	vmod	\N	\N	\N	0	1
1752	Có quá nhiều muối thì không ngon miệng.	塩が多すぎるとおいしくありません。	\N		\N	vmod	\N	\N	\N	0	1
1753	Cha tôi đeo kính khi xem ti vi.	私の父はテレビを見るとき眼鏡を掛けます。	\N		\N	vmod	\N	\N	\N	0	1
1754	Sưởi lò hiện đại nhất của công ty này rất tiện.	この会社の最新のストーブはとても便利です。	\N		\N	vmod	\N	\N	\N	0	1
1755	Lời nói phải đi đôi với việc làm.	言葉は行動を伴わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1756	Xin lỗi, lối ra ở đâu?	すみません、出口はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1757	Tôi không thể tìm lối vào được.	入り口が見つからない。	\N		\N	vmod	\N	\N	\N	0	1
1758	Tôi không thể tìm ra lối vào được.	入り口が見つけられない。	\N		\N	vmod	\N	\N	\N	0	1
1759	Đi thẳng qua ngã tư đó có một ngân hàng lớn.	そこの交差点をまっすぐ行くと、大きな銀行があります。	\N		\N	vmod	\N	\N	\N	0	1
1760	Tôi cho bạn lưu học sinh mượn một đĩa hát.	私は友達の留学生にレコードを貸します。	\N		\N	vmod	\N	\N	\N	0	1
1761	Chị ấy tập chơi pi-a-nô suốt ngày.	彼女は一日中ピアノの練習をしています。	\N		\N	vmod	\N	\N	\N	0	1
1762	Người đàn ông ấy thường mặc áo sơ mi khi làm việc.	その男性は普段仕事をするときにワイシャツを着ます。	\N		\N	vmod	\N	\N	\N	0	1
1763	Không chỉ vào mùa đông mà còn vào mủa hè một số người Nhật cũng mặc com lê.	冬だけでなく、夏でも背広を着ている日本人もいます。	\N		\N	vmod	\N	\N	\N	0	1
1764	Mùa đông chỉ mặc váy và bít tất thì chắc lạnh lắm.	冬にスカートと靴下だけではきっととても寒いでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1765	Tháng mười ở Nhật Bản trời mát đấy.	日本の十月はとても涼しいです。	\N		\N	vmod	\N	\N	\N	0	1
1766	Buổi sáng tôi đánh răng, rửa mặt.	朝私は歯を磨いて顔を洗います。	\N		\N	vmod	\N	\N	\N	0	1
1768	Đây là máy ảnh chú tôi mua cho tôi.	これは私の伯父が買ってくれたカメラです。	\N		\N	vmod	\N	\N	\N	0	1
1769	Có máy ảnh mà không có phim thì không có ý nghĩa.	カメラがあってもフィルムがないのでは意味がありません。	\N		\N	vmod	\N	\N	\N	0	1
1770	Sử dụng máy ghi âm, máy ra-đi-ô cát-xét sẽ giúp anh học tiếng Việt tốt hơn.	テープレコーダーやラジカセを使えばベトナム語をより良く学べるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1771	Sử dụng máy ghi âm, máy ra-đi-ô cát-xét sẽ giúp anh học tiếng Việt tốt hơn.	テープレコーダーやラジカセを使えばベトナム語をより良く学べるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1772	Anh ấy cho rằng phụ nữ miệng nhỏ mũi cao đẹp hơn.	彼は口が小さく鼻の高い女性がより美しいとみなしています。	\N		\N	vmod	\N	\N	\N	0	1
1773	Cửa hàng này 5 giờ sáng mở cửa.\n\n	このお店は朝五時に開店します。	\N		\N	vmod	\N	\N	\N	0	1
1775	Phụ nữ sợ khi gặp phải một người nào đó không quen trên đường tối.	女性は暗い道で見知らぬ誰かに会ってしまったら怖いものです。	\N		\N	vmod	\N	\N	\N	0	1
1776	Tôi đi du lịch một tháng.	一ヶ月旅行に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1777	Trời nắng lắm, đội mũ vào đi.	日が照っているから、帽子を被りなさい。	\N		\N	vmod	\N	\N	\N	0	1
1778	Mùa thu không có nhiều ngày mưa gió.	秋はあまり風や雨のある日がありません。	\N		\N	vmod	\N	\N	\N	0	1
1779	Mùa thu không có nhiều ngày mưa gió.	秋はあまり風や雨のある日がありません。	\N		\N	vmod	\N	\N	\N	0	1
1780	Anh ấy cho rằng phụ nữ miệng nhỏ mũi cao đẹp hơn.	彼は口が小さく鼻の高い女性がより美しいとみなしています。	\N		\N	vmod	\N	\N	\N	0	1
1781	Có quá nhiều muối thì không ngon miệng.	塩が多すぎるとおいしくありません。	\N		\N	vmod	\N	\N	\N	0	1
1782	Tháng sáu năm kia hai người ấy đã kết hôn.	おととしの六月に二人は結婚しました。	\N		\N	vmod	\N	\N	\N	0	1
1783	Tháng mười hai năm ngoái tôi làm quen với cô ấy.	去年の十二月私は彼女と知り合いました。	\N		\N	vmod	\N	\N	\N	0	1
1745	Hộp thư ở Việt Nam màu gì ?	ベトナムのポストは何色ですか？	\N		\N	vmod	\N	\N	\N	0	1
1774	Phong bì này mỏng mà nặng, không biết có gì bên trong không ?	この封筒は薄いのに重い、中に何が入っているのかしら。	\N		\N	vmod	\N	\N	\N	0	1
1784	Năm sau hay là năm sau nữa, tôi sẽ đến sống một thành phố náo nhiệt hơn.	来年か再来年に、私はもっとにぎやかな街に移り住みます。	\N		\N	vmod	\N	\N	\N	0	1
1785	Năm sau hay là năm sau nữa, tôi sẽ đến sống một thành phố náo nhiệt hơn.	来年か再来年に、私はもっとにぎやかな街に移り住みます。	\N		\N	vmod	\N	\N	\N	0	1
1787	Năm sau hay là năm sau nữa, tôi sẽ đến sống một thành phố náo nhiệt hơn.	来年か再来年に、私はもっとにぎやかな街に移り住みます。	\N		\N	vmod	\N	\N	\N	0	1
1788	Dưới ghế có một con mèo màu nâu.	椅子の下に茶色の猫が一匹います。	\N		\N	vmod	\N	\N	\N	0	1
1789	Đi thẳng qua ngã tư đó có một ngân hàng lớn.	そこの交差点をまっすぐ行くと、大きな銀行があります。	\N		\N	vmod	\N	\N	\N	0	1
1790	Đi thẳng qua ngã tư đó có một ngân hàng lớn.	そこの交差点をまっすぐ行くと、大きな銀行があります。	\N		\N	vmod	\N	\N	\N	0	1
1791	Người ta cảm thấy ngày nghỉ ngắn lắm.	休みの日はとても短く感じるものです。	\N		\N	vmod	\N	\N	\N	0	1
1792	Ngày kia tôi sẽ đi Tokyo bằng xe điện.	あさって私は電車で東京に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1793	Người ta cảm thấy ngày nghỉ ngắn lắm.	休みの日はとても短く感じるものです。	\N		\N	vmod	\N	\N	\N	0	1
1794	Nghỉ hè bắt đầu từ cuối tháng bảy đến cuối tháng chín.	夏休みは七月末に始まり九月末までです。	\N		\N	vmod	\N	\N	\N	0	1
1795	Cô Liên làm bánh kẹo rất ngon.	リエンさんはとてもおいしいケーキを作ります。	\N		\N	vmod	\N	\N	\N	0	1
1796	Chắc cô thích ăn ngọt, phải không?	あなたはおそらく甘いものが好きでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1797	Trách nhiệm của người lớn là gì?	大人の責任とは何ですか？	\N		\N	vmod	\N	\N	\N	0	1
1798	Người nước ngoài đó học tập chăm chỉ.	その外国人は真面目に勉強します。	\N		\N	vmod	\N	\N	\N	0	1
1799	Hàng tuần vợ chồng ấy đi ăn tối ở nhà hàng.	毎週その夫婦はレストランに夕食を食べに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1800	Hàng ngày tôi dọn sạch phòng vệ sinh.	私は毎日トイレを掃除します。	\N		\N	vmod	\N	\N	\N	0	1
1801	Phòng vệ sinh chỉ có ở tầng một thôi.	トイレは一階にしかありません。	\N		\N	vmod	\N	\N	\N	0	1
1802	Em thích màu nhạt hơn.	私は淡い色のほうが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1803	Đĩa này nhẹ quá.	この皿はとても軽いです。	\N		\N	vmod	\N	\N	\N	0	1
1804	Hiện nay ai cũng ăn được bằng nĩa và dao.	今は誰もがフォークとナイフで食事ができます。	\N		\N	vmod	\N	\N	\N	0	1
1805	Ô màu xanh da trời này của ai?	この青い傘は誰のですか？	\N		\N	vmod	\N	\N	\N	0	1
1806	Ông ngoại tôi ghét chanh.	私のおじいさんはレモンが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
1807	Ông nội tôi hay đi quán cà phê.	私の祖父はよく喫茶店に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1808	Muốn đến cửa hàng rau quả thì anh rẽ phải ở đó, cửa hàng đó ở ngay bên trái đường.	八百屋に行きたいならそこを右に曲がってください、お店は道のすぐ左側にあります。	\N		\N	vmod	\N	\N	\N	0	1
1809	Phía bắc Việt Nam là Trung Quốc, phía đông và phía nam là biển, còn phía tây là Căm-pu-chia.	ベトナムの北には中国が、東と南には海が、そして西にはカンボジアがあります。	\N		\N	vmod	\N	\N	\N	0	1
1810	Phía bắc Việt Nam là Trung Quốc, phía đông và phía nam là biển, còn phía tây là Căm-pu-chia.	ベトナムの北には中国が、東と南には海が、そして西にはカンボジアがあります。	\N		\N	vmod	\N	\N	\N	0	1
1811	Phía bắc Việt Nam là Trung Quốc, phía đông và phía nam là biển, còn phía tây là Căm-pu-chia.	ベトナムの北には中国が、東と南には海が、そして西にはカンボジアがあります。	\N		\N	vmod	\N	\N	\N	0	1
1812	Phía bắc Việt Nam là Trung Quốc, phía đông và phía nam là biển, còn phía tây là Căm-pu-chia.	ベトナムの北には中国が、東と南には海が、そして西にはカンボジアがあります。	\N		\N	vmod	\N	\N	\N	0	1
1813	Có máy ảnh mà không có phim thì không có ý nghĩa.	カメラがあってもフィルムがないのでは意味がありません。	\N		\N	vmod	\N	\N	\N	0	1
1814	Ăn quá nhiều phó mát, sữa, trứng cũng không tốt lắm.	チーズや牛乳、卵を食べ過ぎるのも良くありません。	\N		\N	vmod	\N	\N	\N	0	1
1815	Photocopy tài liệu đó cho tôi được không?\n	この資料のコピーを取ってもらえますか？\n	\N		\N	vmod	\N	\N	\N	0	1
1816	Tôi đã photocopy trang này, nhưng để quên bản sao đó ở chỗ nào đó.	このページをコピーしましたが、そのコピーをどこかに置き忘れてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
1818	Phụ nữ sợ khi gặp phải một người nào đó không quen trên đường tối.	女性は暗い道で見知らぬ誰かに会ってしまったら怖いものです。	\N		\N	vmod	\N	\N	\N	0	1
1819	Anh ấy cởi quần để qua sông.	彼は川を渡るためにズボンを脱ぎました。	\N		\N	vmod	\N	\N	\N	0	1
1820	Ông nội tôi hay đi quán cà phê.\n	私の祖父はよく喫茶店に行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
1821	Trong xe điện ngầm người ta không thể nghe ra-đi-ô được.	地下鉄の中ではラジオは聞けません。	\N		\N	vmod	\N	\N	\N	0	1
1822	Buổi sáng tôi đánh răng, rửa mặt.	朝私は歯を磨いて顔を洗います。	\N		\N	vmod	\N	\N	\N	0	1
1823	Trẻ con rất thích ăn kẹo.	子供は飴を舐めるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1824	Buổi sáng tôi đánh răng, rửa mặt.	朝私は歯を磨いて顔を洗います。	\N		\N	vmod	\N	\N	\N	0	1
1817	Phong bì này mỏng mà nặng, không biết có gì bên trong không ?	この封筒は薄いのに重い、中に何が入っているのかしら。	\N		\N	vmod	\N	\N	\N	0	1
1825	Tắt đèn đi, bây giờ đã sáng lắm rồi.	電気を消しなさい、もうとても明るくなりました。	\N		\N	vmod	\N	\N	\N	0	1
1826	Xe buýt sắp đến, chị thấy không? Xe màu xanh lá cây đó.	もうすぐバスが来ます、見えますか？　あの緑色のバスですよ。	\N		\N	vmod	\N	\N	\N	0	1
1827	Sau khi ăn trưa nó làm việc hăng hái hơn.	昼食を食べた後、彼はより張り切って仕事をします。	\N		\N	vmod	\N	\N	\N	0	1
1828	Sau khi ăn trưa nó làm việc hăng hái hơn.	昼食を食べた後、彼はより張り切って仕事をします。	\N		\N	vmod	\N	\N	\N	0	1
1829	Ăn quá nhiều phó mát, sữa, trứng cũng không tốt lắm.	チーズや牛乳、卵を食べ過ぎるのも良くありません。	\N		\N	vmod	\N	\N	\N	0	1
1830	Chị ấy tập chơi pi-a-nô suốt ngày.	彼女は一日中ピアノの練習をしています。	\N		\N	vmod	\N	\N	\N	0	1
1831	Hàng tháng anh ấy về quê.	彼は毎月故郷に帰ります。	\N		\N	vmod	\N	\N	\N	0	1
1832	Khi mua ở cửa hàng tổng hợp chúng tôi thường đi bằng tắc xi.	デパートに買い物に行くとき、私たちは普段タクシーで行きます。	\N		\N	vmod	\N	\N	\N	0	1
1833	Ông ấy thích sưu tập tách cổ châu Âu.	彼はヨーロッパのアンティークカップを集めるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1834	Tai con voi rất lớn.	象の耳はとても大きい。	\N		\N	vmod	\N	\N	\N	0	1
1835	Hôm nay trời nóng nên tôi tắm nhiều lần rồi.	今日は暑いので何回もシャワーを浴びました。	\N		\N	vmod	\N	\N	\N	0	1
1836	Phòng vệ sinh chỉ có ở tầng một thôi.	トイレは一階にしかありません。	\N		\N	vmod	\N	\N	\N	0	1
1837	Tôi đọc tạp chí Việt Nam nhưng có nhiều từ không biết ý nghĩa.	ベトナムの雑誌を読んでいますが、意味の分からない単語がたくさんあります。	\N		\N	vmod	\N	\N	\N	0	1
1838	Tắt đèn đi, bây giờ đã sáng lắm rồi.	電気を消しなさい、もうとても明るくなりました。	\N		\N	vmod	\N	\N	\N	0	1
1839	Ngày kia tôi sẽ đi Tokyo bằng xe điện.\n	あさって私は電車で東京に行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
1840	Trong xe điện ngầm người ta không thể nghe ra-đi-ô được.	地下鉄の中ではラジオは聞けません。	\N		\N	vmod	\N	\N	\N	0	1
1841	Trước khi ăn, phải rửa tay.	食事の前には手を洗わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1842	Xin cho tôi ba con tem mười nghìn đồng.	一万ドンの切手を三枚ください。	\N		\N	vmod	\N	\N	\N	0	1
1843	Em ấy không thích màu đỏ thẫm.	あの子は濃い赤が好きではない。	\N		\N	vmod	\N	\N	\N	0	1
1844	Đi thẳng qua ngã tư đó có một ngân hàng lớn.\n	そこの交差点をまっすぐ行くと、大きな銀行があります。\n	\N		\N	vmod	\N	\N	\N	0	1
1845	Ở Nhật mùa xuân bắt đầu từ tháng ba.\n\n	日本では春は三月に始まります。	\N		\N	vmod	\N	\N	\N	0	1
1846	Nghỉ hè bắt đầu từ cuối tháng bảy đến cuối tháng chín.	夏休みは七月末に始まり九月末までです。	\N		\N	vmod	\N	\N	\N	0	1
1847	Nghỉ hè bắt đầu từ cuối tháng bảy đến cuối tháng chín.	夏休みは七月末に始まり九月末までです。	\N		\N	vmod	\N	\N	\N	0	1
1848	Ngày mười bốn tháng hai là ngày Valentine.	二月十四日はヴァレンタインデーです。	\N		\N	vmod	\N	\N	\N	0	1
1849	Tôi không thích thang máy vì bên trong rất bí.	中がむっとしているのでエレベーターは好きではありません。	\N		\N	vmod	\N	\N	\N	0	1
1850	Tháng một ở Việt Nam có tết tây, còn tháng hai có tết ta.	ベトナムでは一月に新暦のお正月が、二月に旧暦のお正月があります。	\N		\N	vmod	\N	\N	\N	0	1
1851	Tháng mười ở Nhật Bản trời mát đấy.	日本の十月はとても涼しいです。	\N		\N	vmod	\N	\N	\N	0	1
1852	Tháng mười hai năm ngoái tôi làm quen với cô ấy.\n	去年の十二月私は彼女と知り合いました。\n	\N		\N	vmod	\N	\N	\N	0	1
1853	Tháng mười một ở Hokkaido có tuyết rơi chưa?	北海道では十一月もう雪が降りますか？	\N		\N	vmod	\N	\N	\N	0	1
1854	Tháng năm nhiều người cảm thấy buồn ngủ vì trời ấm áp.\n	五月は暖かいので多くの人が眠たいと感じます。\n	\N		\N	vmod	\N	\N	\N	0	1
1855	Tháng sáu năm kia hai người ấy đã kết hôn.	おととしの六月に二人は結婚しました。	\N		\N	vmod	\N	\N	\N	0	1
1856	Tháng tám hàng năm có rất nhiều khách du lịch ở sân bay.	毎年八月は多くの旅行客で空港は一杯になります。	\N		\N	vmod	\N	\N	\N	0	1
1857	Tháng trước một người bạn Việt Nam của tôi tới Nhật Bản.	先月私のベトナム人の友人が日本に着きました。	\N		\N	vmod	\N	\N	\N	0	1
1858	Từ tháng tư năm sau con trai tôi sẽ bắt đầu vào học trung học.\n	来年の四月から私の息子は中学に進みます。\n	\N		\N	vmod	\N	\N	\N	0	1
1859	Mây trên trời càng ở xa thấy càng thấp.	空の雲は遠くにあればあるほど低く見えます。	\N		\N	vmod	\N	\N	\N	0	1
1860	Không quen thì thắt ca vát rất khó.\n	慣れないとネクタイを結ぶのはとても難しいです。\n	\N		\N	vmod	\N	\N	\N	0	1
1861	Tôi phải đi ngay bây giờ, thế nhé!\n	今すぐ行かなきゃ、じゃあね！\n	\N		\N	vmod	\N	\N	\N	0	1
1862	Món này nhạt, thêm một chút xì dầu sẽ ngon hơn.\n	この料理は味が薄い、少し醤油を加えたらおいしくなるでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
1863	Người Hàn Quốc thường ăn cơm bằng thìa.\n	韓国人は普通スプーンでご飯を食べます。\n	\N		\N	vmod	\N	\N	\N	0	1
1864	Thịt bò, thịt gà và thịt lợn, chị thích nhất là thịt nào?\n	牛肉と鶏肉と豚肉、あなたはどの肉が一番好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1865	Thịt bò, thịt gà và thịt lợn, chị thích nhất là thịt nào?\n	牛肉と鶏肉と豚肉、あなたはどの肉が一番好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1866	Thịt bò, thịt gà và thịt lợn, chị thích nhất là thịt nào?\n	牛肉と鶏肉と豚肉、あなたはどの肉が一番好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1867	Thịt bò, thịt gà và thịt lợn, chị thích nhất là thịt nào?\n	牛肉と鶏肉と豚肉、あなたはどの肉が一番好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1868	Không còn thời gian nữa, nhanh lên!	もう時間がないよ、急いで！	\N		\N	vmod	\N	\N	\N	0	1
1869	Tôi làm thêm vào thứ ba và thứ năm.\n	私は火曜日と木曜日にアルバイトをします。\n	\N		\N	vmod	\N	\N	\N	0	1
1870	Tôi thường dọn phòng vào thứ hai.\n\n	私は普段月曜日に部屋を掃除します。	\N		\N	vmod	\N	\N	\N	0	1
1871	Tôi làm thêm vào thứ ba và thứ năm.\n\n	私は火曜日と木曜日にアルバイトをします。	\N		\N	vmod	\N	\N	\N	0	1
1872	Hôm nay trời đẹp bạn sẽ có chuyến du lịch thú vị.\n\n	今日は晴れているから、楽しい旅行になるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1873	Tiệm này bán nhiều loại thức ăn nước ngoài.\n\n	このお店はたくさんの種類の外国食品を売っています。	\N		\N	vmod	\N	\N	\N	0	1
1874	Sưởi lò hiện đại nhất của công ty này rất tiện.\n	この会社の最新のストーブはとても便利です。\n	\N		\N	vmod	\N	\N	\N	0	1
1875	Sử dụng máy ghi âm, máy ra-đi-ô cát-xét sẽ giúp anh học tiếng Việt tốt hơn.\n	テープレコーダーやラジカセを使えばベトナム語をより良く学べるでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
1876	Cha tôi đeo kính khi xem ti vi.\n\n	私の父はテレビを見るとき眼鏡を掛けます。	\N		\N	vmod	\N	\N	\N	0	1
1877	Cho tôi một tờ giấy và một cây bút bi.\n\n	紙を一枚と、ボールペンを一本ください。	\N		\N	vmod	\N	\N	\N	0	1
1878	Hai công an đứng trước cửa vào toà nhà kia đang nói chuyện với nhau.\n	あの建物の入り口に立っている二人のおまわりさんは話をしています。\n	\N		\N	vmod	\N	\N	\N	0	1
1879	Phụ nữ sợ khi gặp phải một người nào đó không quen trên đường tối.\n	女性は暗い道で見知らぬ誰かに会ってしまったら怖いものです。\n	\N		\N	vmod	\N	\N	\N	0	1
1880	Tháng trước một người bạn Việt Nam của tôi tới Nhật Bản.\n	先月私のベトナム人の友人が日本に着きました。\n	\N		\N	vmod	\N	\N	\N	0	1
1881	Tôi tên là Nguyễn Văn Hùng.\n	私の名前はグエン・ヴァン・フンです。\n	\N		\N	vmod	\N	\N	\N	0	1
1882	Tôi muốn uống trà Lipton không đường.\n	砂糖が入っていない紅茶が飲みたいです。\n	\N		\N	vmod	\N	\N	\N	0	1
1883	Tôi muốn uống trà Lipton không đường.\n	砂糖が入っていない紅茶が飲みたいです。\n	\N		\N	vmod	\N	\N	\N	0	1
1884	Cà phê hay trà xanh, em thích loại nào hơn?\n	コーヒーと緑茶、どちらが好きですか？	\N		\N	vmod	\N	\N	\N	0	1
1885	Muốn đến cửa hàng rau quả thì anh rẽ phải ở đó, cửa hàng đó ở ngay bên trái đường.\n	八百屋に行きたいならそこを右に曲がってください、お店は道のすぐ左側にあります。\n	\N		\N	vmod	\N	\N	\N	0	1
1886	Trẻ con rất thích ăn kẹo.\n\n	子供は飴を舐めるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1887	Thế thì treo bức ảnh này trên tường được không?\n	ではこの写真を壁に掛けてくれますか？\n	\N		\N	vmod	\N	\N	\N	0	1
1888	Hôm nay trời đẹp bạn sẽ có chuyến du lịch thú vị.\n	今日は晴れているから、楽しい旅行になるでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
1889	Ăn quá nhiều phó mát, sữa, trứng cũng không tốt lắm.\n	チーズや牛乳、卵を食べ過ぎるのも良くありません。\n	\N		\N	vmod	\N	\N	\N	0	1
1890	Hai công an đứng trước cửa vào toà nhà kia đang nói chuyện với nhau.\n	あの建物の入り口に立っている二人のおまわりさんは話をしています。\n	\N		\N	vmod	\N	\N	\N	0	1
1891	Từ nhà tôi đến trường học rất gần.\n\n	私の家から学校まではとても近いです。	\N		\N	vmod	\N	\N	\N	0	1
1892	Tôi đọc tạp chí Việt Nam nhưng có nhiều từ không biết ý nghĩa.\n\n	ベトナムの雑誌を読んでいますが、意味の分からない単語がたくさんあります。	\N		\N	vmod	\N	\N	\N	0	1
1893	Kiểm tra kỹ túi áo trước khi giặt.\n	洗濯の前に服のポケットをよく調べなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
1894	Rượu vang Beaujolais Nouveau được bán rất nhiều tại Nhật Bản.\n\n	ボジョレー・ヌーヴォーは日本でたくさん売れます。\n	\N		\N	vmod	\N	\N	\N	0	1
1895	Vòi hoa sen màu vàng này bị hỏng rồi.\n\n	この黄色いシャワーは壊れてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
1896	Mùa đông chỉ mặc váy và bít tất thì chắc lạnh lắm.\n	冬にスカートと靴下だけではきっととても寒いでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
1897	Đối với tôi ví càng nhỏ càng dễ dùng.\n	私にとって財布は小さければ小さいほど使いやすいです。\n	\N		\N	vmod	\N	\N	\N	0	1
1898	Anh ấy tốt nghiệp đại học nổi tiếng rồi mà chưa có việc làm.\n	彼は有名な大学を卒業しているのに、いまだ仕事が見つかりません。\n	\N		\N	vmod	\N	\N	\N	0	1
1899	Mùa đông chỉ mặc váy và bít tất thì chắc lạnh lắm.\n	冬にスカートと靴下だけではきっととても寒いでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
1900	Hàng tuần vợ chồng ấy đi ăn tối ở nhà hàng.\n\n	毎週その夫婦はレストランに夕食を食べに行きます。	\N		\N	vmod	\N	\N	\N	0	1
1901	Vòi hoa sen màu vàng này bị hỏng rồi.\n\n	この黄色いシャワーは壊れてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
1902	Mây trên trời càng ở xa thấy càng thấp.\n	空の雲は遠くにあればあるほど低く見えます。\n	\N		\N	vmod	\N	\N	\N	0	1
1903	Ô màu xanh da trời này của ai?\n\n	この青い傘は誰のですか？	\N		\N	vmod	\N	\N	\N	0	1
1904	Xe buýt sắp đến, chị thấy không? Xe màu xanh lá cây đó.\n\n	もうすぐバスが来ます、見えますか？　あの緑色のバスですよ。	\N		\N	vmod	\N	\N	\N	0	1
1905	Ở đâu cũng có người xấu.	どこにでも悪い人間はいます。	\N		\N	vmod	\N	\N	\N	0	1
1906	Xe buýt sắp đến, chị thấy không? Xe màu xanh lá cây đó.\n	もうすぐバスが来ます、見えますか？　あの緑色のバスですよ。\n	\N		\N	vmod	\N	\N	\N	0	1
1907	Món này nhạt, thêm một chút xì dầu sẽ ngon hơn.\n	この料理は味が薄い、少し醤油を加えたらおいしくなるでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
1767	Hộp thư ở Việt Nam màu gì ?	ベトナムのポストは何色ですか？	\N		\N	vmod	\N	\N	\N	0	1
1908	Tôi đọc tạp chí Việt Nam nhưng có nhiều từ không biết ý nghĩa.\n\n	ベトナムの雑誌を読んでいますが、意味の分からない単語がたくさんあります。	\N		\N	vmod	\N	\N	\N	0	1
1909	Thành phố này yên tĩnh lắm.\n	この街はとても静かです。\n	\N		\N	vmod	\N	\N	\N	0	1
1910	Phái mạnh phải bảo vệ phái yếu.\n	強い者は弱い者を守らねばなりません。\n	\N		\N	vmod	\N	\N	\N	0	1
1911	Muốn đến cửa hàng rau quả thì anh rẽ phải ở đó, cửa hàng đó ở ngay bên trái đường.\n\n	八百屋に行きたいならそこを右に曲がってください、お店は道のすぐ左側にあります。	\N		\N	vmod	\N	\N	\N	0	1
1912	Hai công an đứng trước cửa vào toà nhà kia đang nói chuyện với nhau.\n	あの建物の入り口に立っている二人のおまわりさんは話をしています。\n	\N		\N	vmod	\N	\N	\N	0	1
1913	Kia là nhà tôi.	あそこが私の家です。	\N		\N	vmod	\N	\N	\N	0	1
1914	Bưu thiếp này không cần dán tem.\n\n	この葉書は切手を貼る必要がありません。	\N		\N	vmod	\N	\N	\N	0	1
1915	Quyển sách ấy dày đến nỗi không thể đọc hết được.\n\n	その本は読みきれないほど厚いです。	\N		\N	vmod	\N	\N	\N	0	1
1916	Có khi chị tôi không ăn tối.\n\n	私の姉は時々夕食を食べません。	\N		\N	vmod	\N	\N	\N	0	1
1917	Em ăn tối chưa?\n\n	もう夕飯は食べましたか？	\N		\N	vmod	\N	\N	\N	0	1
1918	Hôm nay trời đẹp bạn sẽ có chuyến du lịch thú vị.\n\n	今日は晴れているから、楽しい旅行になるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1919	Chú tôi rất dễ béo bụng.\n\n	私の伯父はお腹が太りやすいです。	\N		\N	vmod	\N	\N	\N	0	1
1920	Khi nghe nhạc anh đóng cửa đi.\n	音楽を聴くときはドアを閉めなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
1921	Cha tôi không bao giờ dậy muộn.\n\n	私の父は決して遅く起きません。	\N		\N	vmod	\N	\N	\N	0	1
1922	Có khi chị tôi không ăn tối.\n\n	私の姉は時々夕食を食べません。	\N		\N	vmod	\N	\N	\N	0	1
1923	Tôi thường dọn phòng vào thứ hai.\n\n	私は普段月曜日に部屋を掃除します。	\N		\N	vmod	\N	\N	\N	0	1
1924	Hiện nay bạo lực là một vấn đề gia đình rất lớn.	現在暴力は大きな家庭の問題です。	\N		\N	vmod	\N	\N	\N	0	1
1925	Kiểm tra kỹ túi áo trước khi giặt.\n\n	洗濯の前に服のポケットをよく調べなさい。	\N		\N	vmod	\N	\N	\N	0	1
1926	Tắm nước lạnh không tốt cho sức khoẻ.	冷たい水を浴びるのは健康によくありません。	\N		\N	vmod	\N	\N	\N	0	1
1927	Tôi đi trước nhé.	先に行くね。	\N		\N	vmod	\N	\N	\N	0	1
1928	Từ nhà tôi đến trường học rất gần.\n	私の家から学校まではとても近いです。\n	\N		\N	vmod	\N	\N	\N	0	1
1929			\N		\N	vmod	\N	\N	\N	0	1
1930		ああ	\N		\N	vmod	\N	\N	\N	0	1
1931	Ai cũng biết cả.	誰でも知っています。	\N		\N	vmod	\N	\N	\N	0	1
1932	Cái này của ai?	これは誰のですか？	\N		\N	vmod	\N	\N	\N	0	1
1933	Ai bấm chuông đấy?	呼び鈴を押したのは誰？	\N		\N	vmod	\N	\N	\N	0	1
1934	Ông ấy là ai?	彼は誰ですか？	\N		\N	vmod	\N	\N	\N	0	1
1935	Bên cạnh cái bàn có thùng rác.	机の横にゴミ箱がある。	\N		\N	vmod	\N	\N	\N	0	1
1936	Bên cạnh tủ lạnh có bếp ga.	冷蔵庫の横にガス台がある。	\N		\N	vmod	\N	\N	\N	0	1
1937	Bên cạnh cái bàn có thùng rác.	机の横にゴミ箱がある。	\N		\N	vmod	\N	\N	\N	0	1
1938	Bên cạnh tủ lạnh có bếp ga.	冷蔵庫の横にガス台がある。	\N		\N	vmod	\N	\N	\N	0	1
1939	Hôm kia tôi đã mua một chiếc khăn tay cho mẹ tôi.\n\n	一昨日私はお母さんのためにハンカチを一枚買いました。	\N		\N	vmod	\N	\N	\N	0	1
1940	Anh nên xin lỗi vợ, nếu không chị ấy sẽ giận lắm.	あなたは奥さんに謝るべきです。そうしないと彼女は非常に怒りますよ	\N		\N	vmod	\N	\N	\N	0	1
1601	Chân giường này quá to, không đẹp lắm.	このベッドの脚は太すぎて格好悪い。	\N		\N	vmod	\N	\N	\N	0	1
1735	Chân giường này quá to, không đẹp lắm.	このベッドの脚は太すぎて格好悪い。	\N		\N	vmod	\N	\N	\N	0	1
1644	Bộ quần áo  này rất ăn với cô ấy.	このスーツは彼女にとてもよく似合います。	\N		\N	vmod	\N	\N	\N	0	1
1786	Phong bì này mỏng mà nặng, không biết có gì bên trong không ?	この封筒は薄いのに重い、中に何が入っているのかしら。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: vi
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	149	行く	1	1
2	150	英語	2	1
3	151	飛行機	1	1
4	152	外国	1	1
5	153	外国人	1	1
6	154	フランス語	1	1
7	155	ホテル	1	1
8	156	日本語	1	1
9	157	出掛ける	1	1
10	158	国（くに）	1	1
11	159	会う	1	1
12	160	休み	1	1
13	161	旅行	1	1
14	162	旅行する	1	1
15	163	遊ぶ	1	1
16	164	大使館	1	1
17	165	大好き	1	1
18	166	好き	1	1
19	167	上手（じょうず）	1	1
20	168	走る	1	1
21	169	ゆっくり	1	1
22	170	下手（へた）	1	1
23	171	歩く	1	1
24	172	泳ぐ	1	1
25	173	速い［スピードが～］	1	1
26	174	飛ぶ	1	1
27	175	スポーツ	1	1
28	176	嫌い	1	1
29	177	嫌い	1	1
30	178	プール	1	1
31	179	バス	1	1
32	180	自転車	1	1
33	181	交差点	1	1
34	182	道（みち）	1	1
35	183	池	1	1
36	184	散歩	1	1
37	185	かわ（川・河）	1	1
38	186	タクシー	1	1
39	187	自動車，車（くるま）	1	1
40	188	曲がる	1	1
41	189	ネクタイ	1	1
42	190	ワイシャツ	1	1
43	191	会社	1	1
44	192	背広	1	1
45	193	やる	1	1
46	194	吸う	1	1
47	195	電話	1	1
48	196	仕事	1	1
49	197	働く・勤める	1	1
50	198	忙しい	1	1
51	199	図書館	1	1
52	200	辞書，字引	1	1
53	201	借りる	1	1
54	202	新聞	1	1
55	203	読む	1	1
56	204	本	1	1
57	205	コピー	1	1
58	206	コピーする	1	1
59	207	雑誌	1	1
60	208	冊	1	1
61	209	牛肉	1	1
62	210	安い	1	1
63	211	店	1	1
64	212	高い	1	1
65	213	いくつ	1	1
66	214	いくつ	1	1
67	215	いくら	1	1
68	216	果物	1	1
69	217	果物	1	1
70	218	野菜	1	1
71	219	魚	1	1
72	220	豚肉	1	1
73	221	鳥肉	1	1
74	222	肉	1	1
75	223	欲しい	1	1
76	224	渡す	1	1
77	225	八百屋	2	1
78	226	かぎ（鍵）	1	1
79	227	料理	1	1
80	228	買い物する	1	1
81	229	洗濯する	2	1
82	230	掃除する	1	1
83	231	家族　（「家庭」も「家族」も同じです）	1	1
84	232	家庭	1	1
85	233	庭（にわ）	1	1
86	234	洗濯	1	1
87	235	うち（家）	1	\N
88	236	家（いえ）	1	1
89	237	掃除	1	1
90	238	かえる（帰・返）	1	1
91	239	本棚	1	1
92	240	机	1	1
93	241	椅子（いす）	1	1
94	242	部屋	1	1
95	243	冷蔵庫	1	1
96	244	洗う	1	1
97	245	洗う	1	1
98	246	ベッド	1	1
99	247	ラジオ	1	1
100	248	ラジカセ	1	1
101	249	～という名前です	1	1
102	250	寝る	1	1
103	251	起きる	1	1
104	252	テーブル	1	1
105	253	テレビ	1	1
106	254	お巡りさん　（ベトナム語では「警官」と「お巡りさん」の区別はありません）	1	1
107	255	警官	1	1
108	256	地図	1	1
109	257	そば	1	1
110	258	ここ,こちら, こっち	1	1
111	259	そこ,そちら, そっち	1	1
112	260	あちら, あっち，あそこ	1	1
113	261	どこ,どちら,どっち	1	1
114	262	交番	1	1
115	263	近く　（「近い」も「近く」も同じです）	1	1
116	264	隣	1	1
117	265	きく	1	1
118	266	切る	1	1
119	267	短い	1	1
120	268	後ろ	1	1
121	269	前	1	1
122	270	右	1	1
123	271	左	1	1
124	272	長い	1	1
125	273	座る	1	1
126	274	立つ	1	1
127	275	友達	1	1
128	276	クラス	1	1
129	277	教室	1	1
130	278	廊下	1	1
131	279	学校	1	1
132	280	生徒	1	1
133	281	勉強	1	1
134	282	学生	1	1
135	283	留学生	1	1
136	284	夏休み	1	1
137	285	先生　（男性の先生を指します）	1	1
138	286	先生　（女性の先生を指します）	1	1
139	287	大学	1	1
140	288	ノート	1	1
141	289	授業	1	1
142	290	作文	1	1
143	291	宿題	1	1
144	292	難しい	1	1
145	293	教える	1	1
146	294	テスト	1	1
147	295	練習	1	1
148	296	易しい	1	1
149	297	練習する	1	1
150	298	質問	1	1
151	299	問題	1	1
152	300	答える	1	1
153	301	痛い	1	1
154	302	歯	1	1
155	303	医者	1	1
156	304	病院	1	1
157	305	病気	1	1
158	306	薬（くすり）	1	1
159	307	死ぬ	1	1
160	308	風邪（かぜ）	1	1
161	309	頭（あたま）	1	1
162	310	お腹	1	1
163	311	度（ど）	1	1
164	312	エレベーター	1	1
165	313	切符	1	1
166	314	おりる	1	1
167	315	階段	1	1
168	316	閉める	1	1
169	317	駅	1	1
170	318	地下鉄　（xe điện ngầm とも言います）	1	1
171	319	乗る	1	1
172	320	乗る	1	1
173	321	乗る	1	1
174	322	乗る	1	1
175	323	開ける	1	1
176	324	お手洗い	1	1
177	325	トイレ	1	\N
178	326	電車　（xe điện とも言います）	1	1
179	327	飲み物	1	1
180	328	コーヒー	1	1
181	329	喫茶店	1	1
182	330	レモン	1	1
183	331	牛乳	1	1
184	332	砂糖	1	1
185	333	カップ	1	1
186	334	お茶	1	1
187	335	紅茶	1	1
188	336	コップ	1	1
189	337	入れる	1	1
190	338	甘い	1	1
191	339	飲む	1	1
192	340	はし	1	1
193	341	酒	1	1
194	342	おいしい	1	1
195	343	ナイフ	1	1
196	344	スプーン	1	1
197	345	フォーク	1	1
198	346	チーズ	1	1
199	347	食べる	1	1
200	348	まずい	1	1
201	349	まずい	1	1
202	350	パン	1	1
203	351	辛い	1	1
204	352	レストラン	1	1
205	353	食堂	1	1
206	354	酒・ワイン	1	1
207	355	食べ物	1	1
208	356	食べ物　（đồ ăn という言い方もあります）	1	1
209	357	食べ物　（thức ăn と同じです）	1	1
210	358	カレー	1	1
211	359	お金	1	1
212	360	銀行	1	1
213	361	入り口	1	1
214	362	どうぞ,どういたしまして	1	\N
215	363	いいえ	1	1
216	364	ええ	1	1
217	365	ええ	1	1
218	366	すみません	1	1
219	367	どうぞ	1	1
220	368	出口	1	1
221	369	着く	1	1
222	370	ポスト	1	1
223	371	はがき	1	1
224	372	貼る	1	1
225	373	封筒	1	1
226	374	手紙	1	1
227	375	郵便局	1	1
228	376	返す	1	1
229	377	出す	1	1
230	378	切手	1	1
231	379	荷物	1	1
232	380	枚	1	1
233	381	貸す	1	1
234	382	買う	1	1
235	383	帽子	1	1
236	384	靴	1	1
237	385	買い物	1	1
238	386	階	1	1
239	387	デパート	1	1
240	388	スカート	1	1
241	389	コート	1	1
242	390	ズボン	1	1
243	391	セーター	1	1
244	392	…てください	1	1
245	393	かばん	1	1
246	394	売る	1	1
247	395	上着	1	1
248	396	ふろ	1	1
249	397	建物	1	1
250	398	台所	1	1
251	399	シャワー（ヘッド）　（「シャワーを浴びる」は tắm となります）	1	1
252	400	窓	1	1
253	401	住む	1	1
254	402	公園	1	1
255	403	ドア （ベトナム語では「戸」も「ドア」も同じです）	1	1
256	404	浴びる［一風呂～］	1	1
257	405	アパート	1	1
258	406	玄関	1	1
259	407	彼　（自分より年上の男性への三人称になります）	1	1
260	408	彼　（年配の男性への三人称になります）	1	1
261	409	彼女　（自分より年上の女性への三人称になります）	1	1
262	410	彼女　（自分より年上の女性への三人称になります）	1	1
263	411	彼女　（年配の女性への三人称になります）	1	1
264	412	彼ら　（自分より年上の男性への三人称になります）	1	1
265	413	彼ら　（年配の男性への三人称になります）	1	1
266	414	彼女たち　（自分より年上の女性への三人称になります）	1	1
267	415	彼女たち　（自分より年上の女性への三人称になります）	1	1
268	416	彼女たち　（年配の女性への三人称になります）	1	1
269	417	私（わたし）	1	1
270	418	私たち　（聞き手を含めた言い方です）	1	1
271	419	私たち　（聞き手を含めない言い方です）	1	1
272	420	だれか	1	1
273	421	だれ　（ベトナム語では「どなた」と「だれ」の区別はありません）	2	1
274	422	どなた	1	1
275	423	きみ　（年齢の若い男性、女性への二人称になります）	1	1
276	424	あなた　（「兄」という意味以外に、自分より年上の男性への二人称になります）	3	1
277	425	あなた　（「姉」という意味以外に、自分より年上の女性への二人称になります）	1	1
278	426	あなた　（年配の男性への二人称になります）	1	1
279	427	あなた　（「祖母」という意味以外に、年配の女性への二人称になります）	1	1
280	428	あなた　（「伯母、叔母」という意味以外に、自分より年上の女性への二人称になります）	1	1
281	429	あなた　（「叔父」という意味以外に、自分より年上の男性への二人称になります）	1	1
282	430	あなた　（自分より年下の男性、女性への二人称になります）	1	1
283	431	あなた　（自分よりかなり年下の男性、女性への二人称になります）	1	1
284	432	この	1	1
285	433	その，あの	1	1
286	434	その，あの	1	1
287	435	いかが，どう	1	1
288	436	どの	1	1
289	437	どの	1	1
290	438	どんな	1	1
291	439	こんな	1	1
292	440	自分	1	1
293	441	そう	1	1
294	442	厚い	1	1
295	443	狭い	1	1
296	444	細い	1	0
297	445	大きい	1	1
298	446	大きい	1	1
299	447	太い	1	1
300	448	若い	1	1
301	449	広い	1	1
302	450	軽い	1	1
303	451	遠い	1	1
304	452	重い	1	1
305	453	薄い	1	1
306	454	新しい	1	1
307	455	小さい	1	1
308	456	近い	1	1
309	457	古い	1	1
310	458	楽しい	1	1
311	459	にぎやか	1	1
312	460	低い	1	1
313	461	よい	1	1
314	462	明るい	1	1
315	463	弱い	1	1
316	464	強い	1	1
317	465	おもしろい	1	1
318	466	きれい	1	1
319	467	遅い	1	1
320	468	悪い	1	1
321	469	多い	1	1
322	470	暗い	1	1
323	471	静か	1	1
324	472	少ない	1	1
325	473	汚い	1	1
326	474	つまらない	1	1
327	475	横　（そば、隣、横は全て bên cạnh で表現できます）	1	1
328	476	中（なか）	1	1
329	477	外（そと）	1	1
330	478	東（ひがし）	1	1
331	479	高さ	1	1
332	480	高さ	1	1
333	481	縦	1	1
334	482	北（きた）	1	1
335	483	西（にし）	1	1
336	484	下（した）	1	1
337	485	南（みなみ）	1	1
338	486	上（うえ）	1	1
339	487	先（さき）	1	1
340	488	後（あと）	1	1
341	489	いとこ　（年上の男性のいとこ、という意味になります）	1	1
342	490	いとこ　（年上の女性のいとこ、という意味になります）	1	1
343	491	いとこ　（年下の男性、女性のいとこ、という意味になります）	1	1
344	492	兄	1	1
345	493	兄弟（きょうだい）	1	1
346	494	おばあさん　（母方の祖母を指します）	1	1
347	495	おばあさん　（父方の祖母を指します）	1	1
348	496	おじいさん　（母方の祖父を指します）	1	1
349	497	おじいさん　（父方の祖父を指します）	1	1
350	498	奥さん　（「妻」も「奥さん」も同じです）	1	1
351	499	母　（ベトナム語では「お母さん」と「母」の区別はありません）	1	1
352	500	父方の伯父、伯母	1	1
353	501	叔父，伯父	1	1
354	502	両親　（cha mẹ と同様です）	1	1
355	503	両親　（bố mẹ と同様です）	1	1
356	504	父（北部）　（ベトナム語では「お父さん」と「父」の区別はありません）	1	1
357	505	父（南部）　（ベトナム語では「お父さん」と「父」の区別はありません）	1	1
358	506	姉	1	1
359	507	姉妹	1	1
360	508	叔母，伯母	1	1
361	509	お兄さん	1	1
362	510	お姉さん	1	1
363	511	お父さん	1	1
364	512	お父さん	1	1
365	513	お母さん	1	1
366	514	靴下	1	1
367	515	シャツ	1	1
368	516	脱ぐ	1	1
369	517	架ける	1	1
370	518	は（穿）く［ズボンを～］	1	1
371	519	着る	1	1
372	520	かぶる	1	1
373	521	ハンカチ	1	1
374	522	スリッパ	1	1
375	523	傘	1	1
376	524	ポケット	1	1
377	525	財布	1	1
378	526	着ている	1	1
379	527	服	1	1
381	529	口	1	1
382	530	腕（うで）	1	1
383	531	体（からだ）	1	1
384	532	顔	1	1
385	533	脚（あし）　（「足、脚」どちらも指します）	1	1
386	534	手（て）	1	1
387	535	鼻	1	1
388	536	目（め）	1	1
389	537	耳	1	1
390	538	足（あし）	1	1
391	539	おなか　（ベトナム語では「腹」と「おなか」の区別はありません）	1	1
392	540	皿（さら）	1	1
393	541	バター	1	1
394	542	茶わん	1	1
395	543	あめ	1	1
396	544	昼御飯　（「昼食を取る」という場合は ăn trưa となります）	1	1
397	545	夕飯（ゆうはん）　（「夕食を取る」という場合は ăn tối となります）	1	1
398	546	お菓子	1	1
399	547	卵	1	1
400	548	朝御飯　（「朝食を取る」という場合は ăn sáng となります）	1	1
401	549	御飯（ごはん）	1	1
402	550	醤油	1	1
403	551	塩（しお）	1	1
404	552	晩御飯　（「夕食を取る」という場合は ăn tối となります）	1	1
405	553	くわえる	1	1
406	554	つける	1	1
407	555	カメラ	1	1
408	556	ストーブ	1	1
409	557	鉛筆	1	1
410	558	消す	1	1
411	559	眼鏡（めがね）	1	1
412	560	テープレコーダー	1	1
413	561	時計	1	1
414	562	コンピュータ	1	1
415	563	フィルム	1	1
416	564	戸（と）	1	1
417	565	門（もん）	1	1
418	566	ペン	1	1
419	567	万年筆	1	1
420	568	ボールペン	1	1
421	569	八月	1	1
422	570	四月	1	1
423	571	今月	1	1
424	572	毎月（まいつき）	1	1
425	573	十二月	1	1
426	574	二月	1	1
427	575	一月	1	1
428	576	七月	1	1
429	577	六月	1	1
430	578	来月	1	1
431	579	五月	1	1
432	580	三月	1	1
433	581	先月	1	1
434	582	十一月	1	1
435	583	十月	1	1
436	584	九月	1	1
437	585	ひとつき	1	1
438	586	今週	1	1
439	587	毎週	1	1
440	588	日曜日	1	1
441	589	木曜日	1	1
442	590	来週	1	1
443	591	月曜日	1	1
444	592	火曜日	1	1
445	593	水曜日	1	1
446	594	土曜日	1	1
447	595	週間	1	1
448	596	先週	1	1
449	597	金曜日	1	1
450	598	年（ねん）	1	1
451	599	秋	1	1
452	600	今年（ことし）	1	1
453	601	毎年（まいとし）	1	1
454	602	夏（なつ）	1	1
455	603	冬	1	1
456	604	去年	1	1
457	605	去年	1	1
458	606	来年	1	1
459	607	来年	1	1
460	608	来年	1	1
461	609	春	1	1
462	610	再来年	1	1
463	611	おととし	1	1
464	612	午後　（「この、あの」などの言葉が付くと buổi を付けません）	1	1
465	613	今日（きょう）	1	1
466	614	明日（あした）	1	1
467	615	時（じ）	1	1
468	616	昨日（きのう）	1	1
469	617	夕べ	1	1
470	618	午前　（「この、あの」などの言葉が付くと buổi を付けません）	1	1
471	619	朝	1	1
472	620	昼	1	1
473	621	夜（よる）	1	1
474	622	夕方	1	1
475	623	あさって	1	1
476	624	おととい	1	1
477	625	もう	1	1
478	626	ながら	1	1
479	627	まだ	1	1
480	628	中(ちゅう)	1	1
481	629	中(ちゅう)	1	1
482	630	時（とき）	1	1
483	631	いつ	1	1
484	632	ときどき	1	1
485	633	しばしば	1	1
486	634	しばしば	1	1
487	635	時間	1	1
488	636	すぐ	1	1
489	637	灰皿	1	1
490	638	歌（うた）	1	1
491	639	歌う	1	1
492	640	たばこ	1	1
493	641	映画	1	1
494	642	レコード	1	1
495	643	ギター	1	1
496	644	弾く	1	1
497	645	音楽　（「音楽を聴く」という場合は nghe nhạc となります）	1	1
498	646	絵（え）	1	1
499	647	写真	1	1
500	648	好き，気に入る	1	1
501	649	声	1	1
502	650	晴れ	1	1
503	651	暑い	1	1
504	652	晴れる	1	1
505	653	涼しい	1	1
506	654	寒い　（「冷たい」も「寒い」も同じです）	1	1
507	655	寒い	1	1
508	656	雪（ゆき）	1	1
509	657	雨が降る	1	1
510	658	雨（あめ）	1	1
511	659	天気	1	1
512	660	あたたかい（暖・温）	1	1
513	661	風（かぜ）	1	1
514	662	曇り	1	1
515	663	冷たい	1	1
516	664	曇る	1	1
517	665	漢字	1	1
518	666	言う	1	1
519	667	書く	1	1
520	668	話（はなし）	1	1
521	669	言葉	1	1
522	670	～語	1	1
523	671	語（ご）	1	1
524	672	話す	1	1
525	673	文章	1	1
526	674	語る	1	1
527	675	意味	1	1
528	676	平仮名	1	1
529	677	片仮名	1	1
530	678	大人（おとな）	1	1
531	679	大勢	1	1
532	680	夫婦	1	1
533	681	子供	1	1
534	682	妻	1	1
535	683	女（おんな）	1	1
536	684	男の子	1	1
537	685	人（ひと）	1	1
538	686	男（おとこ）	1	1
539	687	女の子	1	1
540	688	夫	1	1
541	689	人	1	1
542	690	みんな	1	1
543	691	白（しろ），白い	1	1
544	692	青，青い	1	1
545	693	茶色	1	1
546	694	明るい，淡い	1	1
547	695	明るい，淡い	1	1
548	696	色（いろ）	1	1
549	697	濃い，暗い	1	1
550	698	濃い，暗い	1	1
551	699	黄色（きいろ），黄色い	1	1
552	700	黒（くろ），黒い	1	1
553	701	赤，赤い	1	1
554	702	緑	1	1
555	703	便利	1	1
556	704	パーティー	1	1
557	705	紙	1	1
558	706	～になる	1	1
559	707	～になる	1	1
560	708	締める	1	1
561	709	押す	1	1
562	710	始まる	1	1
563	711	ちょうど	1	1
564	712	ない	1	1
565	713	まっすぐ	1	1
566	714	有名	1	1
567	715	元気	1	1
568	716	じゃあ	1	1
569	717	じゃあ	1	1
570	718	多分	1	1
571	719	では	1	1
572	421	どなた　（ベトナム語では「どなた」と「だれ」の区別はありません）	1	1
573	492	兄	1	1
574	424	兄　（ベトナム語では「お兄さん」と「兄」の区別はありません）	2	1
575	424	お兄さん　（ベトナム語では「お兄さん」と「兄」の区別はありません）	1	1
576	275	あなた （「友」という意味以外に、親しい男性、女性への二人称になります）	1	1
577	475	隣　（そば、隣、横は全て bên cạnh で表現できます）	1	1
578	504	お父さん（北部）　（ベトナム語では「お父さん」と「父」の区別はありません）	1	1
579	539	腹　（ベトナム語では「腹」と「おなか」の区別はありません）	1	1
580	428	父方の伯母，叔母	1	1
581	662	曇る	1	1
582	254	警官　（ベトナム語では「警官」と「お巡りさん」の区別はありません）	1	1
583	403	戸（と） （ベトナム語では「戸」も「ドア」も同じです）	1	1
584	505	お父さん（南部）　（ベトナム語では「お父さん」と「父」の区別はありません）	1	1
585	467	ゆっくり	1	1
586	533	足（あし）　（「足、脚」どちらも指します）	1	1
587	425	姉　（ベトナム語では「お姉さん」と「姉」の区別はありません）	1	1
588	425	お姉さん　（ベトナム語では「お姉さん」と「姉」の区別はありません）	1	1
589	470	夕方	1	0
590	429	父方の叔父	1	1
592	230	掃除	1	1
593	720	あさって	1	1
594	299	文章	1	1
595	721	そこ,そちら, そっち	1	1
596	231	家庭　（「家庭」も「家族」も同じです）	1	1
597	229	洗濯	1	1
598	260	その，あの	1	1
599	654	冷たい　（「冷たい」も「寒い」も同じです）	1	1
600	518	着ている	1	1
601	518	着る	1	1
602	499	お母さん　（ベトナム語では「お母さん」と「母」の区別はありません）	1	1
603	444	薄い	1	1
604	657	雨（あめ）	1	1
605	531	人	1	1
606	531	人（ひと）	1	1
607	462	朝	1	1
608	462	明るい，淡い	1	0
609	268	後（あと）	1	1
610	649	～語	1	1
611	470	濃い，暗い	1	0
612	470	夜（よる）	1	1
613	393	ポケット	1	1
614	650	晴れる	1	1
615	269	先（さき）	1	1
616	498	妻　（「妻」も「奥さん」も同じです）	1	1
617	648	好き	1	1
618	438	いかが，どう	1	1
619	717	では	1	1
620	319	～しなさい	1	1
621	319	行く	1	1
622	475	そば　（そば、隣、横は全て bên cạnh で表現できます）	1	1
623	552	夕飯（ゆうはん）　（「夕食を取る」という場合は ăn tối となります）	1	1
624	644	遊ぶ	1	1
625	263	近い　（「近い」も「近く」も同じです）	1	1
626	641	フィルム	1	1
627	314	乗る	1	0
628	150		1	0
629	424		3	0
630	424		3	0
631	183		1	0
632	722	起きる	1	1
633	496		1	0
634	356		1	0
635	225		1	0
636	723	ベトナム語	1	1
637	269		1	0
638	421		2	\N
380	528	スーツ	1	1
591	442	太い	1	0
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
555	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
482	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
483	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
439	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
424	7865	1.1612	1.16	体	関係	時間	毎日・毎度	毎月（まいつき）	毎月	まいつき
453	7870	1.1612	1.16	体	関係	時間	毎日・毎度	毎年（まいとし）	毎年	まいとし
461	8361	1.1624	1.16	体	関係	時間	季節	春	春	はる
454	8375	1.1624	1.16	体	関係	時間	季節	夏（なつ）	夏	なつ
451	8389	1.1624	1.16	体	関係	時間	季節	秋	秋	あき
455	8403	1.1624	1.16	体	関係	時間	季節	冬	冬	ふゆ
431	8510	1.1631	1.16	体	関係	時間	月	五月（さつき）	五月	さつき
443	8555	1.1632	1.16	体	関係	時間	週・週日	月曜日	月曜日	げつようび
444	8556	1.1632	1.16	体	関係	時間	週・週日	火曜日	火曜日	かようび
445	8557	1.1632	1.16	体	関係	時間	週・週日	水曜日	水曜日	すいようび
441	8558	1.1632	1.16	体	関係	時間	週・週日	木曜日	木曜日	もくようび
449	8559	1.1632	1.16	体	関係	時間	週・週日	金曜日	金曜日	きんようび
446	8560	1.1632	1.16	体	関係	時間	週・週日	土曜日	土曜日	どようび
440	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
470	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
464	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
471	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
607	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
472	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
474	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
589	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
473	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
612	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
452	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
423	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
438	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
465	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
456	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
457	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
463	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
433	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
448	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
468	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
476	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
469	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
458	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
459	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
460	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
462	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
430	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
442	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
466	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
475	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
593	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
111	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
595	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
112	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
113	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
339	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
615	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
110	10765	1.173	1.17	体	関係	空間	方向・方角	こちら	こちら	こちら
330	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
335	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
337	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
334	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
123	10954	1.174	1.17	体	関係	空間	左右・前後・たてよこ	左（ひだり）	左	ひだり
122	10956	1.174	1.17	体	関係	空間	左右・前後・たてよこ	右（みぎ）	右	みぎ
121	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
120	10983	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後ろ	後ろ	うしろ
340	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
609	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
333	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
327	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
338	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
336	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
329	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
328	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
622	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
109	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
116	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
577	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
115	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
220	12247	1.183	1.18	体	関係	形	穴・口	出口	出口	でぐち
213	12249	1.183	1.18	体	関係	形	穴・口	入（い）り口	入り口	いりぐち
531	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
331	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
332	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
542	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
437	14623	1.196	1.19	体	関係	量	数記号（一二三）	ひとつき	ひとつき	ひとつき
65	14656	1.196	1.19	体	関係	量	数記号（一二三）	いくつ	いくつ	いくつ
66	14656	1.196	1.19	体	関係	量	数記号（一二三）	いくつ	いくつ	いくつ
67	14658	1.196	1.19	体	関係	量	数記号（一二三）	いくら	いくら	いくら
427	14674	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	一月	一月	いちがつ
426	14675	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	二月	二月	にがつ
432	14676	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	三月	三月	さんがつ
422	14677	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	四月	四月	しがつ
429	14679	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	六月	六月	ろくがつ
428	14680	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	七月	七月	しちがつ
421	14681	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	八月	八月	はちがつ
436	14682	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	九月	九月	くがつ
435	14683	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十月	十月	じゅうがつ
434	14684	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十一月	十一月	じゅういちがつ
425	14685	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十二月	十二月	じゅうにがつ
450	14871	1.1962	1.19	体	関係	量	助数接辞	年（ねん）	年	ねん
447	14890	1.1962	1.19	体	関係	量	助数接辞	週間	週間	しゅうかん
467	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
487	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
163	15048	1.1962	1.19	体	関係	量	助数接辞	度（ど）	度	ど
238	15092	1.1962	1.19	体	関係	量	助数接辞	階	階	かい
60	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
232	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
537	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
541	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
606	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
605	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
269	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
270	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
271	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
282	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
276	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
281	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
283	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
277	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
280	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
279	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
576	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
278	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
275	15527	1.201	1.20	体	主体	人間	われ・なれ・かれ	君（きみ）	君	きみ
264	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
268	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
266	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
267	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
261	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
259	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
263	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
265	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
262	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
260	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
273	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
274	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
572	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
272	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
292	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
538	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
536	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
535	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
539	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
533	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
530	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
348	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
349	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
346	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
347	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
83	16247	1.21	1.21	体	主体	家族	家族	家族	家族	かぞく
532	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
540	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
534	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
616	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
350	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
354	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
355	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
356	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
357	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
351	16496	1.212	1.21	体	主体	家族	親・先祖	母	母	はは
578	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
584	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
363	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
364	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
365	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
602	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
345	16780	1.214	1.21	体	主体	家族	兄弟	兄弟（きょうだい）	兄弟	きょうだい
344	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
573	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
574	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
575	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
361	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
587	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
358	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
359	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
588	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
362	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
353	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
352	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
590	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
580	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
360	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
341	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
342	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
343	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
127	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
5	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
138	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
137	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
155	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
107	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
582	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
106	20065	1.2417001	1.24	体	主体	成員	保安サービス	お巡りさん	お巡りさん	おまわりさん
134	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
132	20241	1.2419	1.24	体	主体	成員	学徒	生徒	生徒	せいと
135	20281	1.2419	1.24	体	主体	成員	学徒	留学生	留学生	りゅうがくせい
84	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
596	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
10	21338	1.253	1.25	体	主体	公私	国	国（くに）	国	くに
4	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
131	22471	1.263	1.26	体	主体	社会	社寺・学校	学校	学校	がっこう
129	22500	1.263	1.26	体	主体	社会	社寺・学校	教室	教室	きょうしつ
139	22517	1.263	1.26	体	主体	社会	社寺・学校	大学	大学	だいがく
43	22666	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	会社	会社	かいしゃ
212	22692	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	銀行	銀行	ぎんこう
169	22785	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	駅	駅	えき
30	22810	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	プール	プール	ぷうる
63	22828	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	店（みせ）	店	みせ
204	22888	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	レストラン	レストラン	れすとらん
205	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
181	22917	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	喫茶店	喫茶店	きっさてん
77	22952	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	八百屋	八百屋	やおや
239	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
7	23065	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	ホテル	ホテル	ほてる
156	23103	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	病院	病院	びょういん
51	23121	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	図書館	図書館	としょかん
254	23140	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	公園	公園	こうえん
114	23216	1.266	1.26	体	主体	社会	教室・兵営など	交番	交番	こうばん
16	23402	1.271	1.27	体	主体	機関	政府機関	大使館	大使館	たいしかん
227	23439	1.272	1.27	体	主体	機関	公共機関	郵便局	郵便局	ゆうびんきょく
128	23913	1.276	1.27	体	主体	機関	同盟・団体	クラス	クラス	くらす
501	25605	1.3031	1.30	体	活動	心	声	声	声	こえ
147	26691	1.3049999	1.30	体	活動	心	学習・習慣・記憶	練習	練習	れんしゅう
133	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
146	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
527	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
143	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
521	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
522	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
523	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
610	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
636	30555	1.3101	1.31	体	活動	言語	言語	外国語	外国語	がいこくご
8	30562	1.3101	1.31	体	活動	言語	言語	日本語	日本語	にほんご
2	30580	1.3101	1.31	体	活動	言語	言語	英語	英語	えいご
6	30586	1.3101	1.31	体	活動	言語	言語	フランス語	フランス語	ふらんすご
142	30813	1.3103	1.31	体	活動	言語	表現	作文	作文	さくぶん
620	31353	1.3111	1.31	体	活動	言語	文法	命令形	命令形	めいれいけい
517	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
528	31558	1.3113	1.31	体	活動	言語	文字	平仮名	平仮名	ひらがな
529	31559	1.3113	1.31	体	活動	言語	文字	片仮名	片仮名	かたかな
108	32060	1.3115	1.31	体	活動	言語	表・図・譜・式	地図	地図	ちず
226	32261	1.3122	1.31	体	活動	言語	通信	手紙	手紙	てがみ
223	32265	1.3122	1.31	体	活動	言語	通信	はがき	はがき	はがき
47	32370	1.3122	1.31	体	活動	言語	通信	電話	電話	でんわ
520	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
150	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
151	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
57	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
594	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
525	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
56	34173	1.316	1.31	体	活動	言語	文献・図書	本（ほん）	本	ほん
59	34482	1.316	1.31	体	活動	言語	文献・図書	雑誌	雑誌	ざっし
54	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
52	34541	1.316	1.31	体	活動	言語	文献・図書	辞書	辞書	じしょ
490	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
498	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
499	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
497	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
493	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
48	36429	1.332	1.33	体	活動	生活	労働・作業・休暇	仕事	仕事	しごと
136	36595	1.332	1.33	体	活動	生活	労働・作業・休暇	夏休み	夏休み	なつやすみ
12	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
401	36910	1.3331	1.33	体	活動	生活	食生活	御飯（ごはん）	御飯	ごはん
400	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
396	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
623	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
397	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
404	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
13	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
36	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
27	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
19	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
22	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
556	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
141	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
237	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
86	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
597	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
89	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
592	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
231	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
211	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
165	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
230	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
557	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
379	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
380	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
247	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
44	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
243	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
42	49847	1.4220001	1.42	体	生産物	衣料	上着・コート	ワイシャツ	ワイシャツ	わいしゃつ
241	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
242	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
240	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
367	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
376	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
613	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
235	50073	1.425	1.42	体	生産物	衣料	帽子・マスクなど	帽子	帽子	ぼうし
41	50149	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	ネクタイ	ネクタイ	ねくたい
366	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
236	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
374	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
375	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
98	50330	1.427	1.42	体	生産物	衣料	寝具	ベッド	ベッド	べっど
208	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
207	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
209	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
79	50577	1.431	1.43	体	生産物	食料	料理	料理	料理	りょうり
202	50788	1.431	1.43	体	生産物	食料	料理	パン	パン	ぱん
70	51101	1.432	1.43	体	生産物	食料	米・ぬか・小麦粉など	野菜	野菜	やさい
74	51286	1.4323	1.43	体	生産物	食料	魚・肉	肉	肉	にく
73	51294	1.4323	1.43	体	生産物	食料	魚・肉	鳥肉	鳥肉	とりにく
61	51299	1.4323	1.43	体	生産物	食料	魚・肉	牛肉	牛肉	ぎゅうにく
72	51303	1.4323	1.43	体	生産物	食料	魚・肉	豚肉	豚肉	ぶたにく
184	51376	1.433	1.43	体	生産物	食料	調味料・こうじなど	砂糖	砂糖	さとう
403	51398	1.433	1.43	体	生産物	食料	調味料・こうじなど	塩（しお）	塩	しお
402	51442	1.433	1.43	体	生産物	食料	調味料・こうじなど	醤油	醤油	しょうゆ
393	51476	1.433	1.43	体	生産物	食料	調味料・こうじなど	バター	バター	ばたあ
198	51478	1.433	1.43	体	生産物	食料	調味料・こうじなど	チーズ	チーズ	ちいず
210	51510	1.433	1.43	体	生産物	食料	調味料・こうじなど	カレー	カレー	かれえ
398	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
395	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
179	51732	1.4349999	1.43	体	生産物	食料	飲料・たばこ	飲み物	飲み物	のみもの
186	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
187	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
180	51777	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーヒー	コーヒー	こおひい
193	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
206	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
492	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
158	51929	1.436	1.43	体	生産物	食料	薬剤・薬品	薬（くすり）	薬	くすり
88	52391	1.4400001	1.44	体	生産物	住居	住居	家（いえ）	家	いえ
87	52392	1.4400001	1.44	体	生産物	住居	住居	うち（家）	うち	うち
249	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
417	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
94	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
257	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
258	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
250	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
177	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
176	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
130	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
167	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
252	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
91	53263	1.4450001	1.44	体	生産物	住居	棚・台・壇など	本棚	本棚	ほんだな
416	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
583	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
255	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
92	53456	1.447	1.44	体	生産物	住居	家具	机	机	つくえ
104	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
93	53482	1.447	1.44	体	生産物	住居	家具	椅子（いす）	椅子	いす
408	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
248	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
489	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
222	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
225	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
377	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
245	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
392	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
394	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
188	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
185	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
192	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
197	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
196	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
409	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
419	54238	1.4529999	1.45	体	生産物	道具	文具	万年筆	万年筆	まんねんひつ
420	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
418	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
78	54498	1.4541	1.45	体	生産物	道具	日用品	かぎ（鍵）	かぎ	かぎ
373	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
251	54653	1.4541	1.45	体	生産物	道具	日用品	シャワー	シャワー	しゃわあ
195	54781	1.455	1.45	体	生産物	道具	刃物	ナイフ	ナイフ	ないふ
495	55090	1.456	1.45	体	生産物	道具	楽器・レコードなど	ギター	ギター	ぎたあ
494	55164	1.456	1.45	体	生産物	道具	楽器・レコードなど	レコード	レコード	れこおど
140	55740	1.459	1.45	体	生産物	道具	札・帳など	ノート	ノート	のおと
411	55889	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	眼鏡（めがね）	眼鏡	めがね
407	55928	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	カメラ	カメラ	かめら
415	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
626	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
95	55970	1.462	1.46	体	生産物	機械	電気器具・部品	冷蔵庫	冷蔵庫	れいぞうこ
99	55992	1.462	1.46	体	生産物	機械	電気器具・部品	ラジオ	ラジオ	らじお
105	55994	1.462	1.46	体	生産物	機械	電気器具・部品	テレビ	テレビ	てれび
412	56004	1.462	1.46	体	生産物	機械	電気器具・部品	テープレコーダー	テープレコーダー	てえぷれこおだあ
414	56126	1.462	1.46	体	生産物	機械	電気器具・部品	コンピューター	コンピューター	こんぴゅうたあ
100	56144	1.462	1.46	体	生産物	機械	電気器具・部品	ラジカセ	ラジカセ	らじかせ
413	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
32	56482	1.465	1.46	体	生産物	機械	乗り物（陸上）	自転車	自転車	じてんしゃ
39	56506	1.465	1.46	体	生産物	機械	乗り物（陸上）	自動車	自動車	じどうしゃ
38	56572	1.465	1.46	体	生産物	機械	乗り物（陸上）	タクシー	タクシー	たくしい
31	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
178	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
170	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
164	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
3	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
85	57040	1.47	1.47	体	生産物	土地利用	地類（土地利用）	庭（にわ）	庭	にわ
34	57152	1.471	1.47	体	生産物	土地利用	道路・橋	道（みち）	道	みち
33	57316	1.471	1.47	体	生産物	土地利用	道路・橋	交差点	交差点	こうさてん
548	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
552	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
553	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
545	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
551	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
554	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
544	58059	1.502	1.50	体	自然	自然	色	青	青	あお
513	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
510	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
604	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
508	59878	1.5153	1.51	体	自然	物質	雨・雪	雪（ゆき）	雪	ゆき
511	59928	1.5154001	1.51	体	自然	物質	天気	天気	天気	てんき
502	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
514	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
37	60947	1.525	1.52	体	自然	天地	川・湖	かわ（川・河）	かわ	かわ
35	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
182	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
68	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
69	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
71	63577	1.5504	1.55	体	自然	動物	魚類	魚（さかな）	魚	さかな
383	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
161	64318	1.5601	1.56	体	自然	身体	頭・目鼻・顔	頭（あたま）	頭	あたま
384	64388	1.5601	1.56	体	自然	身体	頭・目鼻・顔	顔	顔	かお
388	64415	1.5601	1.56	体	自然	身体	頭・目鼻・顔	目（め）	目	め
387	64470	1.5601	1.56	体	自然	身体	頭・目鼻・顔	鼻	鼻	はな
389	64491	1.5601	1.56	体	自然	身体	頭・目鼻・顔	耳	耳	みみ
381	64505	1.5601	1.56	体	自然	身体	頭・目鼻・顔	口	口	くち
162	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
579	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
391	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
386	64713	1.5603	1.56	体	自然	身体	手足・指	手（て）	手	て
382	64741	1.5603	1.56	体	自然	身体	手足・指	腕	腕	うで
390	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
586	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
385	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
154	65338	1.5606	1.56	体	自然	身体	骨・歯・爪・角・甲	歯	歯	は
183	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
399	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
157	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
160	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
558	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
559	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
229	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
103	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
632	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
410	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
560	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
561	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
369	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
221	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
90	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
621	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
189	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
372	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
166	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
509	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
171	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
172	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
173	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
174	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
627	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
175	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
168	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
406	72782	2.1559999	2.15	用	関係	作用	接近・接触・隔離	付ける	付ける	つける
224	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
40	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
118	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
405	73997	2.158	2.15	用	関係	作用	増減・補充	加える	加える	くわえる
562	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
491	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
149	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
518	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
101	79593	2.3102	2.31	用	活動	言語	名	名のる	名のる	なのる
524	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
526	80001	2.3131001	2.31	用	活動	言語	話・談話	語る	語る	かたる
117	80087	2.3132	2.31	用	活動	言語	問答	きく（聞・聴）	きく	きく
152	80142	2.3132	2.31	用	活動	言語	問答	答える	答える	こたえる
55	80639	2.3150001	2.31	用	活動	言語	読み	読む	読む	よむ
519	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
58	80748	2.3151	2.31	用	活動	言語	書き	コピーする	コピーする	こぴいする
496	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
199	81700	2.3331001	2.33	用	活動	生活	食生活	食べる	食べる	たべる
371	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
378	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
600	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
601	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
370	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
368	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
253	81948	2.3333001	2.33	用	活動	生活	住生活	住む	住む	すむ
256	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
15	82317	2.3369999	2.33	用	活動	生活	遊楽	遊ぶ	遊ぶ	あそぶ
624	82317	2.3369999	2.33	用	活動	生活	遊楽	遊ぶ	遊ぶ	あそぶ
14	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
24	82483	2.3374	2.33	用	活動	生活	スポーツ	泳ぐ	泳ぐ	およぐ
126	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
102	82694	2.3390999	2.33	用	活動	生活	立ち居	寝る	寝る	ねる
125	82724	2.3390999	2.33	用	活動	生活	立ち居	座る	座る	すわる
191	83154	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	飲む	飲む	のむ
46	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
45	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
49	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
11	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
145	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
244	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
246	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
80	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
234	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
76	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
233	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
53	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
228	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
96	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
97	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
81	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
82	88631	2.3843	2.38	用	活動	事業	掃除など	掃除する	掃除する	そうじする
516	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
581	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
504	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
614	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
159	90096	2.5702	2.57	用	自然	生命	死	死ぬ	死ぬ	しぬ
284	90777	3.1010001	3.10	相	関係	真偽	こそあど・他	この	この	この
291	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
293	90799	3.1010001	3.10	相	関係	真偽	こそあど・他	そう	そう	そう
286	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
285	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
598	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
288	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
289	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
290	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
287	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
618	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
563	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
564	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
313	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
320	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
305	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
603	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
318	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
325	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
144	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
148	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
316	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
315	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
485	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
486	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
484	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
306	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
309	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
300	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
319	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
479	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
477	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
488	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
478	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
565	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
321	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
324	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
124	94000	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	長い	長い	ながい
119	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
64	94023	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	高い	高い	たかい
312	94030	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	低い	低い	ひくい
294	94048	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	厚い	厚い	あつい
303	94059	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	遠い	遠い	とおい
308	94068	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	近い	近い	ちかい
625	94068	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	近い	近い	ちかい
301	94080	3.1912	3.19	相	関係	量	広狭・大小	広い	広い	ひろい
295	94110	3.1912	3.19	相	関係	量	広狭・大小	狭い	狭い	せまい
299	94124	3.1912	3.19	相	関係	量	広狭・大小	太い	太い	ふとい
591	94124	3.1912	3.19	相	関係	量	広狭・大小	太い	太い	ふとい
296	94125	3.1912	3.19	相	関係	量	広狭・大小	細い	細い	ほそい
297	94142	3.1912	3.19	相	関係	量	広狭・大小	大きい	大きい	おおきい
298	94142	3.1912	3.19	相	関係	量	広狭・大小	大きい	大きい	おおきい
307	94186	3.1912	3.19	相	関係	量	広狭・大小	小さい	小さい	ちいさい
25	94225	3.1912999	3.19	相	関係	量	速度	速い［スピードが～］	速い	はやい
21	94288	3.1912999	3.19	相	関係	量	速度	ゆっくり	ゆっくり	ゆっくり
585	94288	3.1912999	3.19	相	関係	量	速度	ゆっくり	ゆっくり	ゆっくり
304	94318	3.1914001	3.19	相	関係	量	軽重	重い	重い	おもい
302	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
503	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
505	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
507	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
506	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
480	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
481	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
153	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
310	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
317	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
326	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
18	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
500	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
617	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
17	95587	3.302	3.30	相	活動	心	好悪・愛憎	大好き	大好き	だいすき
28	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
29	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
75	96159	3.3041999	3.30	相	活動	心	欲望・期待・失望	欲しい	欲しい	ほしい
566	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
50	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
567	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
62	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
608	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
546	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
547	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
314	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
322	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
543	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
323	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
311	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
194	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
200	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
201	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
190	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
203	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
549	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
550	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
611	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
599	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
515	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
512	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
568	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
569	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
218	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
570	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
214	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
219	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
216	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
217	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
215	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
571	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
619	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
168	1	599	0	đi	0	\N	\N
169	1	606	0	đi	0	\N	\N
171	1	1418	0	đi	0	\N	\N
361	471	727	0	sáng	0	\N	\N
362	471	728	0	sáng	0	\N	\N
364	471	1212	0	sáng	0	\N	\N
383	501	933	0	tiếng	0	\N	\N
707	124	557	1	dài	0	\N	0
708	195	1617	1		0	\N	0
709	591	1618	1		0	\N	0
710	145	1532	1	dạy	0	\N	0
711	145	956	2	dạy	0	\N	0
716	80	1620	1		0	\N	0
766	575	1630	1		0	\N	0
767	574	1631	1		0	\N	0
768	276	1346	1	anh	0	\N	0
769	276	1337	2	anh	0	\N	0
770	276	1208	3	anh	0	\N	0
771	276	678	4	anh	0	\N	0
772	276	575	5	anh	0	\N	0
776	259	1131	1	anh ấy	0	\N	0
777	259	1026	2	anh ấy	0	\N	0
778	259	569	3	anh ấy	0	\N	0
780	341	1633	1		0	\N	0
781	345	1634	1		0	\N	0
782	35	1635	1		0	\N	0
783	379	597	1	áo	0	\N	0
784	241	1636	1		0	\N	0
785	243	1637	1		0	\N	0
786	367	1638	1		0	\N	0
787	247	1639	1		0	\N	0
788	42	1640	1		0	\N	0
789	199	1435	1	ăn	0	\N	0
790	199	1376	2	ăn	0	\N	0
791	199	1212	3	ăn	0	\N	0
792	512	1075	1	ấm	0	\N	0
793	497	1641	1		0	\N	0
794	497	1642	2		0	\N	0
795	561	1643	1		0	\N	0
796	380	1644	1		0	\N	0
797	285	1162	1	ấy	0	\N	0
798	285	1159	2	ấy	0	\N	0
799	279	1645	1		0	\N	0
802	263	875	1	bà ấy	0	\N	0
803	347	1647	1		0	\N	0
804	346	1646	1		0	\N	0
805	352	911	1	bác	0	\N	0
806	155	1598	1		0	\N	0
809	151	1528	1	bài	0	\N	0
810	151	1226	2	bài	0	\N	0
811	151	577	3	bài	0	\N	0
812	490	832	1	bài hát	0	\N	0
813	143	1372	1	bài tập	0	\N	0
814	143	852	2	bài tập	0	\N	0
815	143	577	3	bài tập	0	\N	0
816	246	1352	1	bán	0	\N	0
817	246	1350	2	bán	0	\N	0
818	92	1031	1	bàn	0	\N	0
819	92	835	2	bàn	0	\N	0
820	325	1648	1		0	\N	0
821	576	1474	1	bạn	0	\N	0
822	576	1246	2	bạn	0	\N	0
823	576	1244	3	bạn	0	\N	0
824	576	1164	4	bạn	0	\N	0
825	127	1587	1	bạn	0	\N	0
826	127	728	2	bạn	0	\N	0
827	50	1483	1	bận	0	\N	0
828	50	1454	2	bận	0	\N	0
829	104	1599	1		0	\N	0
830	108	1649	1		0	\N	0
831	57	1650	1		0	\N	0
832	398	1651	1		0	\N	0
836	202	1214	1	bánh mì	0	\N	0
837	202	1652	2		0	\N	0
838	54	1470	1	báo	0	\N	0
839	54	746	2	báo	0	\N	0
840	66	1363	1	bao nhiêu	0	\N	0
841	66	713	2	bao nhiêu	0	\N	0
842	66	708	3	bao nhiêu	0	\N	0
843	67	1268	1	bao nhiêu tiền	0	\N	0
844	67	711	2	bao nhiêu tiền	0	\N	0
845	394	1171	1	bát	0	\N	0
846	406	1653	1		0	\N	0
847	562	1530	1	bắt đầu	0	\N	0
848	562	1311	2	bắt đầu	0	\N	0
849	562	1007	3	bắt đầu	0	\N	0
850	26	1654	1		0	\N	0
851	30	1061	1	bể bơi	0	\N	0
854	157	1655	1		0	\N	0
857	156	875	1	bệnh viện	0	\N	0
858	156	756	2	bệnh viện	0	\N	0
859	160	917	1	bị cảm	0	\N	0
863	393	1656	1		0	\N	0
864	354	1409	1	bố mẹ	0	\N	0
865	354	910	2	bố mẹ	0	\N	0
866	354	620	3	bố mẹ	0	\N	0
867	24	834	1	bơi	0	\N	0
868	24	1657	2		0	\N	0
869	400	1658	1		0	\N	0
873	396	1661	1		0	\N	0
874	396	1662	2		0	\N	0
875	499	665	1	bức ảnh	0	\N	0
876	499	1663	2		0	\N	0
878	464	1665	1		0	\N	0
879	470	727	1	buổi sáng	0	\N	0
880	248	1666	1		0	\N	0
881	418	809	1	bút	0	\N	0
882	418	1064	2	bút	0	\N	0
883	420	1667	1		0	\N	0
884	409	1668	1		0	\N	0
885	419	1669	1		0	\N	0
886	227	596	1	bưu điện	0	\N	0
887	223	1670	1		0	\N	0
888	71	1671	1		0	\N	0
890	180	1214	1	cà phê	0	\N	0
891	180	1673	2		0	\N	0
892	210	1674	1		0	\N	0
893	480	1675	1		0	\N	0
894	41	1676	1		0	\N	0
895	264	1065	1	các anh ấy	0	\N	0
896	268	1677	1		0	\N	0
897	266	1678	1		0	\N	0
898	267	1679	1		0	\N	0
899	265	1680	1		0	\N	0
901	382	1682	1		0	\N	0
902	118	1081	1	cắt	0	\N	0
903	525	1683	1		0	\N	0
904	594	1120	1	bài	0	\N	0
905	594	928	2	bài	0	\N	0
906	275	1684	1		0	\N	0
907	167	1685	1		0	\N	0
908	257	1681	1		0	\N	0
909	257	1686	2		0	\N	0
910	203	1687	1		0	\N	0
912	355	1600	1		0	\N	0
913	319	1689	1		0	\N	0
914	585	949	1	chậm	0	\N	0
915	326	1298	1	chán	0	\N	0
916	326	928	2	chán	0	\N	0
919	182	1602	1		0	\N	0
922	20	937	1	chạy	0	\N	0
923	20	654	2	chạy	0	\N	0
924	159	1054	1	chết	0	\N	0
926	277	1563	1	chị	0	\N	0
927	277	1267	2	chị	0	\N	0
928	277	534	3	chị	0	\N	0
929	261	1116	1	chị ấy	0	\N	0
930	261	1201	2	chị ấy	0	\N	0
932	342	1691	1		0	\N	0
933	78	1692	1		0	\N	0
934	359	1690	1		0	\N	0
935	359	1693	2		0	\N	0
936	474	1568	1	chiều	0	\N	0
937	331	1694	1		0	\N	0
938	333	1695	1		0	\N	0
939	233	1605	1		0	\N	0
940	624	1549	1	chơi	0	\N	0
941	624	1536	2	chơi	0	\N	0
942	624	853	3	chơi	0	\N	0
943	496	1349	1	chơi	0	\N	0
944	496	1348	2	chơi	0	\N	0
945	496	1347	3	chơi	0	\N	0
946	496	1340	4	chơi	0	\N	0
947	540	1696	1		0	\N	0
948	590	1697	1		0	\N	0
949	283	956	1	cháu	0	\N	0
950	283	952	2	cháu	0	\N	0
951	281	1698	1		0	\N	0
952	517	1302	1	chữ Hán	0	\N	0
953	517	828	2	chữ Hán	0	\N	0
954	440	1536	1	chủ nhật	0	\N	0
955	440	1497	2	chủ nhật	0	\N	0
956	440	1161	3	chủ nhật	0	\N	0
957	479	1578	1	chưa	0	\N	0
958	479	1213	2	chưa	0	\N	0
959	479	1040	3	chưa	0	\N	0
960	270	1530	1	chúng ta	0	\N	0
961	270	1239	2	chúng ta	0	\N	0
962	270	646	3	chúng ta	0	\N	0
963	271	1106	1	chúng tôi	0	\N	0
964	520	1558	1	chuyện	0	\N	0
965	520	1162	2	chuyện	0	\N	0
966	520	1006	3	chuyện	0	\N	0
967	520	1450	4	chuyện	0	\N	0
968	217	1544	1	có	0	\N	0
969	217	578	2	có	0	\N	0
970	217	565	3	có	0	\N	0
971	580	748	1	cô	0	\N	0
972	280	1506	1	cô	0	\N	0
973	262	1560	1	cô ấy	0	\N	0
974	262	1076	2	cô ấy	0	\N	0
975	262	1054	3	cô ấy	0	\N	0
976	138	1147	1	cô giáo	0	\N	0
977	138	1145	2	cô giáo	0	\N	0
978	138	909	3	cô giáo	0	\N	0
979	484	1607	1		0	\N	0
980	570	1253	1	có lẽ	0	\N	0
981	570	1229	2	có lẽ	0	\N	0
982	514	1699	1		0	\N	0
983	581	1700	1		0	\N	0
984	188	1608	1		0	\N	0
985	368	1701	1		0	\N	0
986	401	1565	1	cơm	0	\N	0
987	401	879	2	cơm	0	\N	0
988	401	575	3	cơm	0	\N	0
989	44	1702	1		0	\N	0
990	539	1703	1		0	\N	0
991	536	1610	1		0	\N	0
992	417	1481	1	cổng	0	\N	0
995	43	1159	1	công ty	0	\N	0
996	43	848	2	công ty	0	\N	0
997	43	683	3	công ty	0	\N	0
998	254	1611	1		0	\N	0
999	254	1705	2		0	\N	0
1000	309	418	1	cũ	0	\N	0
1003	239	1614	1		0	\N	0
1004	258	1615	1		0	\N	0
1005	252	1616	1		0	\N	0
1007	63	1613	1		0	\N	0
1008	63	1708	2		0	\N	0
1009	60	1707	1		0	\N	0
1010	632	1709	1		0	\N	0
1011	148	1526	1	dễ	0	\N	0
1012	148	28	2	dễ	0	\N	0
1014	200	1621	1		0	\N	0
1018	13	1276	1	du lịch	0	\N	0
1019	13	1035	2	du lịch	0	\N	0
1020	13	606	3	du lịch	0	\N	0
1021	13	588	4	du lịch	0	\N	0
1022	336	1622	1		0	\N	0
1023	477	1212	1	đã	0	\N	0
1024	477	872	2	đã	0	\N	0
1025	477	222	3	đã	0	\N	0
1026	531	1623	1		0	\N	0
1027	495	1340	1	đàn ghi-ta	0	\N	0
1028	538	1711	1		0	\N	0
1029	64	1270	1	đắt	0	\N	0
1030	64	553	2	đắt	0	\N	0
1032	142	1712	1		0	\N	0
1033	142	1713	2		0	\N	0
1034	153	608	1	đau	0	\N	0
1035	153	601	2	đau	0	\N	0
1036	113	1288	1	đâu	0	\N	0
1037	113	599	2	đâu	0	\N	0
1038	113	596	3	đâu	0	\N	0
1039	161	608	1	đầu	0	\N	0
1044	110	1587	1	đây	0	\N	0
1045	110	1505	2	đây	0	\N	0
1046	110	585	3	đây	0	\N	0
1047	110	538	4	đây	0	\N	0
1048	111	1714	1		0	\N	0
1049	552	1016	1	đen	0	\N	0
1050	318	1428	1	đẹp	0	\N	0
1051	318	1069	2	đẹp	0	\N	0
1052	318	974	3	đẹp	0	\N	0
1053	621	606	1	đi	0	\N	0
1054	621	599	2	đi	0	\N	0
1055	621	1418	3	đi	0	\N	0
1056	620	1536	1	đi	0	\N	0
1057	620	950	2	đi	0	\N	0
1058	171	743	1	đi	0	\N	0
1059	23	740	1	đi bộ	0	\N	0
1060	36	1626	1		0	\N	0
1061	14	1276	1	đi du lịch	0	\N	0
1062	14	606	2	đi du lịch	0	\N	0
1063	14	588	3	đi du lịch	0	\N	0
1065	237	1627	1		0	\N	0
1066	102	127	1	đi ngủ	0	\N	0
1067	9	1628	1		0	\N	0
1068	392	1629	1		0	\N	0
1069	494	1715	1		0	\N	0
1070	47	1319	1	điện thoại	0	\N	0
1071	595	1366	1	đó	0	\N	0
1072	595	1052	2	đó	0	\N	0
1073	553	1268	1	đỏ	0	\N	0
1074	163	1716	1		0	\N	0
1075	332	1717	1		0	\N	0
1076	179	1718	1		0	\N	0
1077	55	1470	1	đọc	0	\N	0
1078	55	881	2	đọc	0	\N	0
1079	372	1719	1		0	\N	0
1080	114	1720	1		0	\N	0
1081	168	1721	1		0	\N	0
1082	168	1722	2		0	\N	0
1083	413	1170	1	đồng hồ	0	\N	0
1084	192	1723	1		0	\N	0
1085	126	1182	1	đứng	0	\N	0
1087	34	843	1	đường	0	\N	0
1088	34	1724	2		0	\N	0
1089	184	1725	1		0	\N	0
1090	282	1451	1	em	0	\N	0
1091	282	709	2	em	0	\N	0
1092	343	1726	1		0	\N	0
1093	169	998	1	ga	0	\N	0
1095	11	1102	1	gặp	0	\N	0
1096	11	871	2	gặp	0	\N	0
1097	489	1727	1		0	\N	0
1098	93	1728	1		0	\N	0
1099	28	1729	1		0	\N	0
1100	288	1217	1	gì	0	\N	0
1101	288	1441	2	gì	0	\N	0
1102	288	68	3	gì	0	\N	0
1103	288	66	4	gì	0	\N	0
1108	236	1732	1		0	\N	0
1109	557	1733	1		0	\N	0
1110	513	1734	1		0	\N	0
1111	467	1014	1	giờ	0	\N	0
1112	467	1455	2	giờ	0	\N	0
1113	467	719	3	giờ	0	\N	0
1114	467	718	4	giờ	0	\N	0
1115	141	746	1	giờ học	0	\N	0
1116	19	1472	1	giỏi	0	\N	0
1117	19	1467	2	giỏi	0	\N	0
1118	19	549	3	giỏi	0	\N	0
1119	98	1735	1		0	\N	0
1120	229	1259	1	gửi	0	\N	0
1121	229	489	2	gửi	0	\N	0
1122	453	1736	1		0	\N	0
1123	439	1737	1		0	\N	0
1124	130	937	1	hành lang	0	\N	0
1125	231	1738	1		0	\N	0
1126	491	832	1	hát	0	\N	0
1127	485	1739	1		0	\N	0
1128	295	1740	1		0	\N	0
1129	528	1741	1		0	\N	0
1130	69	1742	1		0	\N	0
1131	132	1149	1	học sinh	0	\N	0
1132	133	1743	1		0	\N	0
1133	150	1517	1	hỏi	0	\N	0
1134	150	1049	2	hỏi	0	\N	0
1135	476	1744	1		0	\N	0
1136	465	1218	1	hôm nay	0	\N	0
1137	465	802	2	hôm nay	0	\N	0
1138	465	800	3	hôm nay	0	\N	0
1139	465	796	4	hôm nay	0	\N	0
1140	468	1023	1	hôm qua	0	\N	0
1141	468	870	2	hôm qua	0	\N	0
1142	222	1745	1		0	\N	0
1143	46	1507	1	hút	0	\N	0
1144	46	1505	2	hút	0	\N	0
1145	324	600	1	ít	0	\N	0
1146	529	1746	1		0	\N	0
1147	526	1747	1		0	\N	0
1148	91	1748	1		0	\N	0
1149	22	1749	1		0	\N	0
1150	395	1750	1		0	\N	0
1151	7	1028	1	khách sạn	0	\N	0
1152	7	968	2	khách sạn	0	\N	0
1153	373	1751	1		0	\N	0
1154	482	1199	1	khi	0	\N	0
1155	482	753	2	khi	0	\N	0
1156	483	1551	1	khi nào	0	\N	0
1157	483	595	2	khi nào	0	\N	0
1158	483	594	3	khi nào	0	\N	0
1159	144	1528	1	khó	0	\N	0
1160	144	1370	2	khó	0	\N	0
1161	144	1302	3	khó	0	\N	0
1162	567	943	1	khỏe	0	\N	0
1163	567	762	2	khỏe	0	\N	0
1164	215	1386	1	không	0	\N	0
1165	215	1228	2	không	0	\N	0
1166	215	1173	3	không	0	\N	0
1167	564	1461	1	không có	0	\N	0
1168	564	1108	2	không có	0	\N	0
1169	564	1029	3	không có	0	\N	0
1170	201	1752	1		0	\N	0
1171	29	1381	1	không thích	0	\N	0
1172	29	935	2	không thích	0	\N	0
1173	598	855	1	kia	0	\N	0
1174	598	654	2	kia	0	\N	0
1175	411	1753	1		0	\N	0
1176	45	1298	1	làm	0	\N	0
1177	45	872	2	làm	0	\N	0
1178	45	1441	3	làm	0	\N	0
1179	49	1109	1	làm việc	0	\N	0
1180	49	853	2	làm việc	0	\N	0
1181	49	637	3	làm việc	0	\N	0
1182	506	1056	1	lạnh	0	\N	0
1183	173	1003	1	lên	0	\N	0
1184	556	884	1	liên hoan	0	\N	0
1185	408	1754	1		0	\N	0
1186	521	1755	1		0	\N	0
1187	220	1756	1		0	\N	0
1188	213	1758	1		0	\N	0
1189	298	1759	1		0	\N	0
1190	128	1587	1	lớp	0	\N	0
1191	128	1531	2	lớp	0	\N	0
1192	128	681	3	lớp	0	\N	0
1193	129	1513	1	lớp học	0	\N	0
1194	129	1507	2	lớp học	0	\N	0
1195	135	1760	1		0	\N	0
1196	147	1761	1		0	\N	0
1197	601	1762	1		0	\N	0
1198	600	1763	1		0	\N	0
1199	370	1764	1		0	\N	0
1200	316	989	1	mạnh	0	\N	0
1201	316	304	2	mạnh	0	\N	0
1202	505	1765	1		0	\N	0
1203	388	609	1	mắt	0	\N	0
1204	384	1766	1		0	\N	0
1205	548	1767	1		0	\N	0
1206	65	1455	1	mấy	0	\N	0
1207	65	762	2	mấy	0	\N	0
1208	65	716	3	mấy	0	\N	0
1209	407	1768	1		0	\N	0
1210	407	1769	2		0	\N	0
1211	3	1278	1	máy bay	0	\N	0
1212	3	1114	2	máy bay	0	\N	0
1213	412	1770	1		0	\N	0
1214	100	1771	1		0	\N	0
1215	414	830	1	máy tính	0	\N	0
1218	381	1772	1		0	\N	0
1219	292	1542	1	mình	0	\N	0
1220	292	1430	2	mình	0	\N	0
1221	292	972	3	mình	0	\N	0
1222	175	1773	1		0	\N	0
1223	306	1143	1	mới	0	\N	0
1224	219	1549	1	mời ...	0	\N	0
1225	219	957	2	mời ...	0	\N	0
1226	219	948	3	mời ...	0	\N	0
1227	542	1419	1	mọi người	0	\N	0
1228	542	1259	2	mọi người	0	\N	0
1229	542	1036	3	mọi người	0	\N	0
1230	207	1383	1	món ăn	0	\N	0
1231	207	1095	2	món ăn	0	\N	0
1232	603	1774	1		0	\N	0
1233	272	1775	1		0	\N	0
1234	437	1776	1		0	\N	0
1235	235	1777	1		0	\N	0
1236	234	1167	1	mua	0	\N	0
1237	234	1009	2	mua	0	\N	0
1238	234	597	3	mua	0	\N	0
1239	509	1423	1	mưa	0	\N	0
1240	509	1421	2	mưa	0	\N	0
1241	509	997	3	mưa	0	\N	0
1242	604	1778	1		0	\N	0
1243	455	981	1	mùa đông	0	\N	0
1244	454	1071	1	mùa hè	0	\N	0
1245	451	1779	1		0	\N	0
1246	461	980	1	mùa xuân	0	\N	0
1247	387	1780	1		0	\N	0
1248	403	1781	1		0	\N	0
1249	75	1517	1	muốn	0	\N	0
1250	75	1045	2	muốn	0	\N	0
1251	75	1035	3	muốn	0	\N	0
1252	53	1426	1	mượn	0	\N	0
1253	53	1156	2	mượn	0	\N	0
1254	450	1300	1	năm	0	\N	0
1255	450	1060	2	năm	0	\N	0
1256	463	1782	1		0	\N	0
1257	452	808	1	năm nay	0	\N	0
1258	452	710	2	năm nay	0	\N	0
1259	456	1783	1		0	\N	0
1260	458	1784	1		0	\N	0
1261	462	1785	1		0	\N	0
1262	304	1786	1		0	\N	0
1263	289	1592	1	nào	0	\N	0
1264	289	1202	2	nào	0	\N	0
1265	311	1787	1		0	\N	0
1266	545	1788	1		0	\N	0
1267	79	869	1	nấu ăn	0	\N	0
1268	284	1515	1	này	0	\N	0
1269	284	1244	2	này	0	\N	0
1270	284	1120	3	này	0	\N	0
1271	33	1789	1		0	\N	0
1272	212	1790	1		0	\N	0
1273	119	1791	1		0	\N	0
1274	593	1421	1	ngày kia	0	\N	0
1275	593	1415	2	ngày kia	0	\N	0
1276	466	1328	1	ngày mai	0	\N	0
1277	466	995	2	ngày mai	0	\N	0
1278	475	1792	1		0	\N	0
1279	12	1793	1		0	\N	0
1280	117	1470	1	nghe	0	\N	0
1281	117	1066	2	nghe	0	\N	0
1283	136	1287	1	nghỉ hè	0	\N	0
1284	136	1794	2		0	\N	0
1285	329	838	1	ngoài	0	\N	0
1286	125	966	1	ngồi	0	\N	0
1287	125	957	2	ngồi	0	\N	0
1288	194	1795	1		0	\N	0
1289	190	1796	1		0	\N	0
1294	530	1797	1		0	\N	0
1295	5	1798	1		0	\N	0
1296	88	1555	1	nhà	0	\N	0
1297	88	1313	2	nhà	0	\N	0
1298	88	998	3	nhà	0	\N	0
1299	204	1799	1		0	\N	0
1300	176	1800	1		0	\N	0
1301	176	1801	2		0	\N	0
1302	25	654	1	nhanh	0	\N	0
1303	547	1802	1		0	\N	0
1304	302	1803	1		0	\N	0
1305	321	1571	1	nhiều	0	\N	0
1306	321	1134	2	nhiều	0	\N	0
1307	321	1460	3	nhiều	0	\N	0
1308	486	1303	1	nhiều lần	0	\N	0
1309	486	756	2	nhiều lần	0	\N	0
1310	307	1080	1	nhỏ	0	\N	0
1311	197	1804	1		0	\N	0
1312	518	1520	1	nói	0	\N	0
1313	518	1371	2	nói	0	\N	0
1314	518	604	3	nói	0	\N	0
1315	524	1470	1	nói chuyện	0	\N	0
1316	524	1006	2	nói chuyện	0	\N	0
1317	566	1076	1	nổi tiếng	0	\N	0
1318	503	1071	1	nóng	0	\N	0
1319	503	964	2	nóng	0	\N	0
1320	10	1202	1	nước	0	\N	0
1321	4	1086	1	nước ngoài	0	\N	0
1322	4	1060	2	nước ngoài	0	\N	0
1323	375	1805	1		0	\N	0
1324	278	855	1	ông	0	\N	0
1325	260	1090	1	ông ấy	0	\N	0
1326	260	584	2	ông ấy	0	\N	0
1327	348	1806	1		0	\N	0
1328	349	1807	1		0	\N	0
1329	122	1808	1		0	\N	0
1330	334	1809	1		0	\N	0
1331	330	1810	1		0	\N	0
1332	337	1811	1		0	\N	0
1333	335	1812	1		0	\N	0
1334	493	1390	1	phim	0	\N	0
1335	493	1138	2	phim	0	\N	0
1336	493	1451	3	phim	0	\N	0
1337	626	1813	1		0	\N	0
1338	198	1814	1		0	\N	0
1339	58	1815	1		0	\N	0
1340	58	1816	2		0	\N	0
1341	94	1070	1	phòng	0	\N	0
1342	94	930	2	phòng	0	\N	0
1343	250	1070	1	phòng bếp	0	\N	0
1344	225	1817	1		0	\N	0
1346	535	415	1	phụ nữ	0	\N	0
1347	535	1818	2		0	\N	0
1348	242	1819	1		0	\N	0
1349	205	246	1	quán ăn	0	\N	0
1350	181	1820	1		0	\N	0
1351	99	1821	1		0	\N	0
1352	154	1822	1		0	\N	0
1353	17	1823	1		0	\N	0
1354	70	1132	1	rau	0	\N	0
1355	40	942	1	rẽ	0	\N	0
1356	62	1278	1	rẻ	0	\N	0
1357	62	1274	2	rẻ	0	\N	0
1358	507	981	1	rét	0	\N	0
1359	301	1190	1	rộng	0	\N	0
1360	97	1824	1		0	\N	0
1361	193	752	1	rượu	0	\N	0
1362	193	568	2	rượu	0	\N	0
1363	56	1365	1	sách	0	\N	0
1364	56	1248	2	sách	0	\N	0
1365	56	881	3	sách	0	\N	0
1366	85	838	1	sân	0	\N	0
1367	607	1212	1	sáng	0	\N	0
1368	607	728	2	sáng	0	\N	0
1369	314	963	1	sáng	0	\N	0
1370	314	1825	2		0	\N	0
1371	488	1826	1		0	\N	0
1372	120	1827	1		0	\N	0
1373	609	1828	1		0	\N	0
1374	134	1364	1	sinh viên	0	\N	0
1375	134	635	2	sinh viên	0	\N	0
1376	37	1021	1	sông	0	\N	0
1377	37	840	2	sông	0	\N	0
1378	253	620	1	sống	0	\N	0
1379	253	583	2	sống	0	\N	0
1380	16	1399	1	sứ quán	0	\N	0
1381	183	1829	1		0	\N	0
1382	481	1830	1		0	\N	0
1383	424	1831	1		0	\N	0
1384	38	1832	1		0	\N	0
1385	185	1833	1		0	\N	0
1386	389	1834	1		0	\N	0
1387	256	1835	1		0	\N	0
1388	238	1836	1		0	\N	0
1389	149	1374	1	tập	0	\N	0
1390	149	1303	2	tập	0	\N	0
1391	59	1837	1		0	\N	0
1392	410	1838	1		0	\N	0
1393	178	1839	1		0	\N	0
1394	170	1840	1		0	\N	0
1395	386	1841	1		0	\N	0
1396	230	1842	1		0	\N	0
1397	550	1843	1		0	\N	0
1398	565	1844	1		0	\N	0
1399	432	1845	1		0	\N	0
1400	428	1846	1		0	\N	0
1401	436	1847	1		0	\N	0
1402	426	1848	1		0	\N	0
1403	164	1849	1		0	\N	0
1404	427	1850	1		0	\N	0
1405	435	1851	1		0	\N	0
1406	425	1852	1		0	\N	0
1407	434	1853	1		0	\N	0
1408	431	1854	1		0	\N	0
1409	423	806	1	tháng này	0	\N	0
1410	423	805	2	tháng này	0	\N	0
1411	430	1027	1	tháng sau	0	\N	0
1412	429	1855	1		0	\N	0
1413	421	1856	1		0	\N	0
1414	433	1857	1		0	\N	0
1415	422	1858	1		0	\N	0
1416	312	1859	1		0	\N	0
1417	560	1860	1		0	\N	0
1418	137	1362	1	thầy giáo	0	\N	0
1419	137	1221	2	thầy giáo	0	\N	0
1420	137	1030	3	thầy giáo	0	\N	0
1421	293	1304	1	thế	0	\N	0
1422	293	1274	2	thế	0	\N	0
1423	293	1165	3	thế	0	\N	0
1424	293	932	4	thế	0	\N	0
1425	618	1469	1	thế nào	0	\N	0
1426	618	1411	2	thế nào	0	\N	0
1427	618	1367	3	thế nào	0	\N	0
1428	618	995	4	thế nào	0	\N	0
1429	290	1580	1	thế nào	0	\N	0
1430	291	1522	1	thế này	0	\N	0
1431	291	1108	2	thế này	0	\N	0
1432	568	1861	1		0	\N	0
1433	27	1393	1	thể thao	0	\N	0
1434	27	1392	2	thể thao	0	\N	0
1435	619	1315	1	thế thì	0	\N	0
1436	619	1274	2	thế thì	0	\N	0
1437	569	1438	1	thế thì	0	\N	0
1438	569	1344	2	thế thì	0	\N	0
1439	569	1273	3	thế thì	0	\N	0
1440	405	1862	1		0	\N	0
1441	146	1528	1	thi	0	\N	0
1442	146	1523	2	thi	0	\N	0
1443	146	1117	3	thi	0	\N	0
1444	196	1863	1		0	\N	0
1445	617	1394	1	thích	0	\N	0
1446	617	1387	2	thích	0	\N	0
1447	617	591	3	thích	0	\N	0
1448	500	1385	1	thích	0	\N	0
1449	500	1379	2	thích	0	\N	0
1450	500	1376	3	thích	0	\N	0
1451	74	1864	1		0	\N	0
1452	61	1865	1		0	\N	0
1453	73	1866	1		0	\N	0
1454	72	1867	1		0	\N	0
1455	487	1868	1		0	\N	0
1456	511	1075	1	thời tiết	0	\N	0
1457	511	995	2	thời tiết	0	\N	0
1458	226	1154	1	thư	0	\N	0
1459	226	892	2	thư	0	\N	0
1460	226	576	3	thư	0	\N	0
1461	444	1869	1		0	\N	0
1462	446	1536	1	thứ bảy	0	\N	0
1463	446	1531	2	thứ bảy	0	\N	0
1464	446	1388	3	thứ bảy	0	\N	0
1465	443	1870	1		0	\N	0
1466	441	1871	1		0	\N	0
1467	449	1486	1	thứ sáu	0	\N	0
1468	445	803	1	thứ tư	0	\N	0
1469	445	699	2	thứ tư	0	\N	0
1470	317	1872	1		0	\N	0
1471	51	1156	1	thư viện	0	\N	0
1472	51	740	2	thư viện	0	\N	0
1474	158	1103	1	thuốc	0	\N	0
1475	158	752	2	thuốc	0	\N	0
1476	492	225	1	thuốc lá	0	\N	0
1477	211	1268	1	tiền	0	\N	0
1478	211	1148	2	tiền	0	\N	0
1479	211	971	3	tiền	0	\N	0
1480	555	1874	1		0	\N	0
1481	610	1367	1	tiếng	0	\N	0
1482	610	1301	2	tiếng	0	\N	0
1483	610	1593	3	tiếng	0	\N	0
1484	610	825	4	tiếng	0	\N	0
1485	636	1875	1		0	\N	0
1486	105	1876	1		0	\N	0
1487	297	1520	1	to	0	\N	0
1488	297	996	2	to	0	\N	0
1489	297	561	3	to	0	\N	0
1490	232	1877	1		0	\N	0
1491	249	1878	1		0	\N	0
1492	269	1483	1	tôi	0	\N	0
1493	269	1387	2	tôi	0	\N	0
1494	269	1347	3	tôi	0	\N	0
1495	269	1167	4	tôi	0	\N	0
1498	322	1879	1		0	\N	0
1499	221	1880	1		0	\N	0
1500	469	1056	1	tối qua	0	\N	0
1501	469	729	2	tối qua	0	\N	0
1502	101	1881	1		0	\N	0
1503	313	1526	1	tốt	0	\N	0
1504	313	969	2	tốt	0	\N	0
1505	313	558	3	tốt	0	\N	0
1507	228	1030	1	trả	0	\N	0
1508	187	1883	1		0	\N	0
1509	152	1119	1	trả lời	0	\N	0
1510	186	1882	1		0	\N	0
1511	186	1884	2		0	\N	0
1512	123	1885	1		0	\N	0
1513	543	550	1	trắng	0	\N	0
1514	498	684	1	tranh	0	\N	0
1515	498	281	2	tranh	0	\N	0
1516	2	742	1	tiếng Anh	0	\N	0
1517	8	1523	1	tiếng Nhật	0	\N	0
1518	8	1364	2	tiếng Nhật	0	\N	0
1519	8	1301	3	tiếng Nhật	0	\N	0
1520	6	1471	1	tiếng Pháp	0	\N	0
1521	6	1467	2	tiếng Pháp	0	\N	0
1522	300	1118	1	trẻ	0	\N	0
1523	533	1886	1		0	\N	0
1524	338	941	1	trên	0	\N	0
1525	338	835	2	trên	0	\N	0
1526	369	1887	1		0	\N	0
1527	559	1079	1	trở nên	0	\N	0
1528	559	1078	2	trở nên	0	\N	0
1529	559	1074	3	trở nên	0	\N	0
1530	558	1077	1	trở thành	0	\N	0
1531	558	1076	2	trở thành	0	\N	0
1532	558	1442	3	trở thành	0	\N	0
1534	328	1383	1	trong	0	\N	0
1535	328	939	2	trong	0	\N	0
1536	328	938	3	trong	0	\N	0
1537	399	1889	1		0	\N	0
1539	139	1588	1	trường đại học	0	\N	0
1540	139	1231	2	trường đại học	0	\N	0
1541	139	745	3	trường đại học	0	\N	0
1542	131	1891	1		0	\N	0
1543	523	1892	1		0	\N	0
1544	52	1350	1	từ điển	0	\N	0
1545	52	666	2	từ điển	0	\N	0
1547	447	1330	1	tuần	0	\N	0
1548	447	1287	2	tuần	0	\N	0
1549	438	1563	1	tuần này	0	\N	0
1550	438	748	2	tuần này	0	\N	0
1551	442	1486	1	tuần sau	0	\N	0
1552	442	1287	2	tuần sau	0	\N	0
1553	448	1466	1	tuần trước	0	\N	0
1554	448	1041	2	tuần trước	0	\N	0
1555	613	1893	1		0	\N	0
1556	245	1268	1	túi	0	\N	0
1557	508	991	1	tuyết	0	\N	0
1558	508	1056	2	tuyết	0	\N	0
1559	191	1374	1	uống	0	\N	0
1560	191	1045	2	uống	0	\N	0
1561	191	858	3	uống	0	\N	0
1562	206	1894	1		0	\N	0
1563	551	1895	1		0	\N	0
1564	216	1481	1	vâng	0	\N	0
1565	216	1458	2	vâng	0	\N	0
1566	216	1447	3	vâng	0	\N	0
1567	240	1896	1		0	\N	0
1568	165	1306	1	vé	0	\N	0
1569	165	878	2	vé	0	\N	0
1570	90	1543	1	về	0	\N	0
1571	90	1253	2	về	0	\N	0
1572	90	1010	3	về	0	\N	0
1573	377	1897	1		0	\N	0
1574	48	1898	1		0	\N	0
1575	519	1303	1	viết	0	\N	0
1576	519	1040	2	viết	0	\N	0
1577	519	663	3	viết	0	\N	0
1578	366	1899	1		0	\N	0
1579	140	1426	1	vở	0	\N	0
1581	532	1900	1		0	\N	0
1582	251	1901	1		0	\N	0
1583	563	1024	1	vừa	0	\N	0
1584	563	881	2	vừa	0	\N	0
1585	478	1067	1	vừa ... vừa ... 	0	\N	0
1586	478	1066	2	vừa ... vừa ... 	0	\N	0
1587	310	1336	1	vui	0	\N	0
1588	310	1591	2	vui	0	\N	0
1589	310	425	3	vui	0	\N	0
1590	310	253	4	vui	0	\N	0
1591	303	1902	1		0	\N	0
1592	544	1903	1		0	\N	0
1593	554	1904	1		0	\N	0
1594	320	1905	1		0	\N	0
1595	31	1906	1		0	\N	0
1596	32	558	1	xe đạp	0	\N	0
1597	39	1333	1	xe ô tô	0	\N	0
1598	39	743	2	xe ô tô	0	\N	0
1599	402	1907	1		0	\N	0
1600	244	958	1	xin ...	0	\N	0
1601	244	949	2	xin ...	0	\N	0
1602	244	925	3	xin ...	0	\N	0
1603	218	1560	1	xin lỗi	0	\N	0
1604	218	1506	2	xin lỗi	0	\N	0
1605	218	1235	3	xin lỗi	0	\N	0
1606	166	1136	1	xuống	0	\N	0
1607	527	1908	1		0	\N	0
1608	323	1909	1		0	\N	0
1609	315	1910	1		0	\N	0
1610	77	1911	1		0	\N	0
1611	208	1873	1		0	\N	0
1612	95	836	1	tủ lạnh	0	\N	0
1613	582	1136	1	công an	0	\N	0
1614	582	1704	2		0	\N	0
1615	106	1912	1		0	\N	0
1616	112	1913	1		0	\N	0
1617	224	1914	1		0	\N	0
1618	294	1915	1		0	\N	0
1621	623	1659	1		0	\N	0
1622	623	1660	2		0	\N	0
1623	404	1916	1		0	\N	0
1624	404	1917	2		0	\N	0
1625	614	1888	1		0	\N	0
1626	502	1918	1		0	\N	0
1640	391	1664	1		0	\N	0
1641	579	1919	1		0	\N	0
1642	255	1706	1		0	\N	0
1643	583	1920	1		0	\N	0
1644	357	1688	1		0	\N	0
1645	584	1921	1		0	\N	0
1648	587	1603	1		0	\N	0
1649	588	1922	1		0	\N	0
1655	83	1335	1	gia đình	0	\N	0
1656	83	1210	2	gia đình	0	\N	0
1657	596	1924	1		0	\N	0
1658	96	1730	1		0	\N	0
1661	597	1925	1		0	\N	0
1662	81	1731	1		0	\N	0
1663	599	1926	1		0	\N	0
1668	606	1582	1	người	0	\N	0
1669	605	681	1	người	0	\N	0
1670	605	542	2	người	0	\N	0
1671	383	503	1	người	0	\N	0
1672	121	1890	1		0	\N	0
1673	615	1927	1		0	\N	0
1674	115	1196	1	gần	0	\N	0
1675	625	1928	1		0	\N	0
1681	273	1172	0	ai	0	\N	0
1682	273	823	1	ai	0	\N	0
1683	273	676	2	ai	0	\N	0
1684	273	584	3	ai	0	\N	0
1685	572	1931	1	ai	0	\N	0
1686	572	1932	2	ai	0	\N	0
1687	572	1933	3	ai	0	\N	0
1688	572	1934	4	ai	0	\N	0
1689	327	841	1	bên cạnh	0	\N	0
1690	327	836	2	bên cạnh	0	\N	0
1691	622	1935	1	bên cạnh	0	\N	0
1692	622	1936	2	bên cạnh	0	\N	0
1693	577	1937	1	bên cạnh	0	\N	0
1694	577	1938	2	bên cạnh	0	\N	0
1701	385	1601	0		0	\N	0
1702	586	610	1	chân	0	\N	0
1703	612	1257	1	tối	0	\N	0
1704	612	1056	2	tối	0	\N	0
1705	592	1923	1		0	\N	0
1706	82	754	1	dọn phòng	0	\N	0
1707	82	1710	2		0	\N	0
1708	374	1619	1		0	\N	0
1715	356	1133	0	bố	0	\N	0
1716	356	1022	1	bố	0	\N	0
1717	578	833	1	bố	0	\N	0
1718	351	1101	1	mẹ	0	\N	0
1719	351	920	2	mẹ	0	\N	0
1720	602	1939	1		0	\N	0
1721	616	1122	1	vợ	0	\N	0
1722	350	1940	1		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: vi
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
30	2
31	3
32	3
33	3
34	3
35	3
36	3
37	3
38	3
39	3
40	3
41	4
42	4
43	4
44	4
45	4
46	4
47	4
48	4
49	4
50	4
51	5
52	5
53	5
54	5
55	5
56	5
57	5
58	5
59	5
60	5
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
75	6
76	6
77	6
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
88	7
89	7
90	7
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
102	8
103	8
104	8
105	8
106	9
107	9
108	9
109	9
110	9
111	9
112	9
113	9
114	9
115	9
116	9
117	9
118	10
119	10
120	10
121	10
122	10
123	10
124	10
125	10
126	10
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
148	11
149	11
150	11
151	11
152	11
153	13
154	13
155	13
156	13
157	13
158	13
159	13
160	13
161	13
162	13
163	13
164	14
165	14
166	14
167	14
168	14
169	14
170	14
171	14
172	14
173	14
174	14
175	14
176	14
177	14
178	14
179	15
180	15
181	15
182	15
183	15
184	15
185	15
186	15
187	15
188	15
189	15
190	15
191	15
192	16
193	16
194	16
195	16
196	16
197	16
198	16
199	16
200	16
201	16
202	16
203	16
204	16
205	16
206	16
207	16
208	16
209	16
210	16
211	17
212	17
213	17
214	17
215	17
216	17
217	17
218	17
219	17
220	17
221	18
222	18
223	18
224	18
225	18
226	18
227	18
228	18
229	18
230	18
231	18
232	18
233	18
234	19
235	19
236	19
237	19
238	19
239	19
240	19
241	19
242	19
243	19
244	19
245	19
246	19
247	19
248	20
249	20
250	20
251	20
252	20
253	20
254	20
255	20
256	20
257	20
258	20
259	21
260	21
261	21
262	21
263	21
264	21
265	21
266	21
267	21
268	21
269	21
270	21
271	21
272	21
273	21
274	21
275	21
276	21
277	21
278	21
279	21
280	21
281	21
282	21
283	21
284	21
285	21
286	21
287	21
288	21
289	21
290	21
291	21
292	21
293	21
294	22
295	22
296	22
297	22
298	22
299	22
300	22
301	22
302	22
303	22
304	22
305	22
306	22
307	22
308	22
309	22
310	23
311	23
312	23
313	23
314	23
315	23
316	23
317	23
318	23
319	23
320	23
321	23
322	23
323	23
324	23
325	23
326	23
327	24
328	24
329	24
330	24
331	24
332	24
333	24
334	24
335	24
336	24
337	24
338	24
339	24
340	24
341	25
342	25
343	25
344	25
345	25
346	25
347	25
348	25
349	25
350	25
351	25
352	25
353	25
354	25
355	25
356	25
357	25
358	25
359	25
360	25
361	25
362	25
363	25
364	25
365	25
366	26
367	26
368	26
369	26
370	26
371	26
372	26
373	26
374	26
375	26
376	26
377	26
378	26
379	26
380	26
381	27
382	27
383	27
384	27
385	27
386	27
387	27
388	27
389	27
390	27
391	27
392	28
393	28
394	28
395	28
396	28
397	28
398	28
399	28
400	28
401	28
402	28
403	28
404	28
405	29
406	29
407	29
408	29
409	29
410	29
411	29
412	29
413	29
414	29
415	29
416	29
417	29
418	29
419	29
420	29
421	30
422	30
423	30
424	30
425	30
426	30
427	30
428	30
429	30
430	30
431	30
432	30
433	30
434	30
435	30
436	30
437	31
438	31
439	31
440	31
441	31
442	31
443	31
444	31
445	31
446	31
447	31
448	31
449	31
450	30
451	32
452	32
453	32
454	32
455	32
456	32
457	32
458	32
459	32
460	32
461	32
462	32
463	32
464	33
465	33
466	33
467	33
468	33
469	33
470	33
471	33
472	33
473	33
474	33
475	33
476	33
477	34
478	34
479	34
480	34
481	34
482	34
483	34
484	34
485	34
486	34
487	34
488	34
489	35
490	35
491	35
492	35
493	35
494	35
495	35
496	35
497	35
498	35
499	35
500	35
501	35
502	36
503	36
504	36
505	36
506	36
507	36
508	36
509	36
510	36
511	36
512	36
513	36
514	36
515	36
516	37
517	37
518	37
519	37
520	37
521	37
522	37
523	37
524	37
525	37
526	37
527	37
528	37
529	37
530	38
531	38
532	38
533	38
534	38
535	38
536	38
537	38
538	38
539	38
540	38
541	38
542	38
543	39
544	39
545	39
546	39
547	39
548	39
549	39
550	39
551	39
552	39
553	39
554	39
572	21
573	25
574	25
575	25
576	38
577	9
578	25
579	13
580	25
581	37
582	9
583	29
584	25
585	2
586	27
587	25
588	25
589	33
590	25
591	22
592	7
593	33
594	37
595	9
596	7
597	7
598	21
599	36
600	26
601	26
602	25
603	22
604	36
605	38
606	38
607	33
608	39
609	24
610	37
611	39
612	33
613	26
614	36
615	24
616	38
617	2
618	21
620	37
621	1
622	9
623	28
624	1
625	22
626	29
627	14
629	25
632	8
636	37
322	39
314	39
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
1	 khoẻ 	\N	\N	\N
2	 gia đình 	\N	\N	\N
3	 cũng 	\N	\N	\N
4	 sáng 	\N	\N	\N
5	 bánh mì 	\N	\N	\N
6	 cà phê 	\N	\N	\N
7	 siêu thị 	\N	\N	\N
8	 đông	\N	\N	\N
9	 bài tập	\N	\N	\N
10	 nhớ 	\N	\N	\N
11	 trường đại học 	\N	\N	\N
12	 nhớ ra 	\N	\N	\N
13	 muộn 	\N	\N	\N
14	sao	\N	\N	\N
15	mới 	\N	\N	\N
16	 sinh nhật 	\N	\N	\N
17	 tặng 	\N	\N	\N
18	 vui vẻ 	\N	\N	\N
19	 tiếng Nhật 	\N	\N	\N
20	 hẹn 	\N	\N	\N
21	 cẩn thận 	\N	\N	\N
22	 tạm biệt 	\N	\N	\N
23	 tiền 	\N	\N	\N
24	 đắt 	\N	\N	\N
25	 bớt 	\N	\N	\N
26	 chương trình 	\N	\N	\N
27	 du lịch 	\N	\N	\N
28	 thành phố 	\N	\N	\N
29	 sạch sẽ 	\N	\N	\N
30	 phong cảnh 	\N	\N	\N
31	 từng 	\N	\N	\N
32	 nghỉ hè 	\N	\N	\N
33	 biển 	\N	\N	\N
34	 sướng 	\N	\N	\N
35	làm thêm	\N	\N	\N
36	 chán 	\N	\N	\N
37	 chữ Hán 	\N	\N	\N
38	 phát âm 	\N	\N	\N
39	 bao giờ 	\N	\N	\N
40	bắt đầu 	\N	\N	\N
41	 đợi 	\N	\N	\N
42	 đón 	\N	\N	\N
43	 thôi 	\N	\N	\N
44	 điện thoại 	\N	\N	\N
45	 ghi 	\N	\N	\N
46	 đúng 	\N	\N	\N
47	 nghỉ 	\N	\N	\N
48	 bằng 	\N	\N	\N
49	 với 	\N	\N	\N
50	 chơi 	\N	\N	\N
51	 nhạc cụ 	\N	\N	\N
52	 bình thường 	\N	\N	\N
53	 từ điển 	\N	\N	\N
54	 hiệu sách 	\N	\N	\N
55	 ngoại văn 	\N	\N	\N
56	 học 	\N	\N	\N
57	giáo viên	\N	\N	\N
58	 tên 	\N	\N	\N
59	 lớp 	\N	\N	\N
60	 sinh viên 	\N	\N	\N
61	 quyển 	\N	\N	\N
62	 sách 	\N	\N	\N
63	 tiếng Nga 	\N	\N	\N
64	 ngữ pháp 	\N	\N	\N
65	 đồng ý 	\N	\N	\N
66	 thích 	\N	\N	\N
67	 món ăn 	\N	\N	\N
68	 thứ bảy 	\N	\N	\N
69	 chủ nhật 	\N	\N	\N
70	 làm 	\N	\N	\N
71	 xem 	\N	\N	\N
72	 phim 	\N	\N	\N
73	 Mỹ 	\N	\N	\N
74	 thể thao	\N	\N	\N
75	 bóng đá 	\N	\N	\N
76	 thủ tục 	\N	\N	\N
77	 hộ chiếu 	\N	\N	\N
78	 sứ quán 	\N	\N	\N
79	 vé 	\N	\N	\N
80	 máy bay 	\N	\N	\N
81	 dạo này 	\N	\N	\N
82	 bố mẹ 	\N	\N	\N
83	 em gái 	\N	\N	\N
84	 rủ 	\N	\N	\N
85	 có thể 	\N	\N	\N
86	(trời) mưa 	\N	\N	\N
87	 vở 	\N	\N	\N
88	 chữ 	\N	\N	\N
89	 đói 	\N	\N	\N
90	 tốt nghiệp 	\N	\N	\N
91	 nghề 	\N	\N	\N
92	 giúp 	\N	\N	\N
93	 gặp khó khăn 	\N	\N	\N
94	 tìm 	\N	\N	\N
95	 ghi băng 	\N	\N	\N
96	 mãi 	\N	\N	\N
97	 du học 	\N	\N	\N
98	 ví dụ 	\N	\N	\N
99	 nghe đài 	\N	\N	\N
100	 nhật ký 	\N	\N	\N
101	 tất cả 	\N	\N	\N
102	rảnh	\N	\N	\N
103	thăm	\N	\N	\N
104	cổng trường	\N	\N	\N
105	thứ sáu tuần sau	\N	\N	\N
106	đám cưới	\N	\N	\N
107	nhà hát	\N	\N	\N
108	vở kịch	\N	\N	\N
109	từ nay	\N	\N	\N
110	chú ý	\N	\N	\N
111	 muốn 	\N	\N	\N
112	 hỏi 	\N	\N	\N
113	 khác 	\N	\N	\N
114	 hôm nay 	\N	\N	\N
115	 thi 	\N	\N	\N
116	 lo 	\N	\N	\N
117	 chuẩn bị 	\N	\N	\N
118	 dễ 	\N	\N	\N
119	 bắt đầu 	\N	\N	\N
120	 dạy 	\N	\N	\N
121	 thêm 	\N	\N	\N
122	 ngữ âm 	\N	\N	\N
123	 chết 	\N	\N	\N
124	 định 	\N	\N	\N
125	 người yêu 	\N	\N	\N
126	 chủ nhật	\N	\N	\N
127	 hiểu	\N	\N	\N
128	 mang 	\N	\N	\N
129	 phòng ngữ âm 	\N	\N	\N
130	 tết 	\N	\N	\N
131	 về 	\N	\N	\N
132	 mời 	\N	\N	\N
133	 đến 	\N	\N	\N
134	 nhà	\N	\N	\N
135	 cám ơn 	\N	\N	\N
136	 chiều 	\N	\N	\N
137	lỡ (hẹn)	\N	\N	\N
138	giận	\N	\N	\N
139	bản báo cáo	\N	\N	\N
140	giám đốc	\N	\N	\N
141	nộp	\N	\N	\N
142	cố gắng	\N	\N	\N
143	bạn trai	\N	\N	\N
144	tình yêu	\N	\N	\N
145	lấy	\N	\N	\N
146	giới thiệu	\N	\N	\N
147	ngoại ngữ	\N	\N	\N
148	khoa	\N	\N	\N
149	đi	0	Đ	\N
150	tiếng Anh	1	T	\N
151	máy bay	1	M	\N
152	nước ngoài	1	N	\N
153	người nước ngoài	1	N	\N
154	tiếng Pháp	1	T	\N
155	khách sạn	1	K	\N
156	tiếng Nhật	1	T	\N
157	đi ra ngoài	1	Đ	\N
158	nước	1	N	\N
159	gặp	1	G	\N
160	ngày nghỉ	1	N	\N
161	du lịch	1	D	\N
162	đi du lịch	1	Đ	\N
164	sứ quán	1	S	\N
165	rất thích	1	R	\N
167	giỏi	1	G	\N
168	chạy	1	C	\N
170	kém	1	K	\N
171	đi bộ	1	Đ	\N
172	bơi	1	B	\N
173	nhanh	1	N	\N
174	bay	1	B	\N
175	thể thao	1	T	\N
176	ghét	1	G	\N
177	không thích	1	K	\N
178	bể bơi	1	B	\N
179	xe buýt	1	X	\N
180	xe đạp	1	X	\N
181	ngã tư	1	N	\N
182	đường	1	Đ	\N
183	ao	1	A	\N
184	đi dạo	1	Đ	\N
185	sông	1	S	\N
186	tắc xi	1	T	\N
187	xe ô tô	1	X	\N
188	rẽ	1	R	\N
189	ca vát	1	C	\N
190	áo sơ mi	1	A	\N
191	công ty	1	C	\N
192	com lê	1	C	\N
193	làm	1	L	\N
194	hút	1	H	\N
195	điện thoại	1	Đ	\N
196	việc làm	1	V	\N
197	làm việc	1	L	\N
198	bận	1	B	\N
199	thư viện	1	T	\N
200	từ điển	1	T	\N
201	mượn	1	M	\N
202	báo	1	B	\N
203	đọc	1	Đ	\N
204	sách	1	S	\N
205	bản sao	1	B	\N
206	photocopy	1	P	\N
207	tạp chí	1	T	\N
208	cuốn	1	C	\N
209	thịt bò	1	T	\N
210	rẻ	1	R	\N
211	cửa hàng	1	C	\N
212	đắt	1	Đ	\N
213	mấy	1	M	\N
214	bao nhiêu	1	B	\N
215	bao nhiêu tiền	1	B	\N
217	hoa quả	1	H	\N
218	rau	1	R	\N
219	cá	1	C	\N
220	thịt lợn	1	T	\N
221	thịt gà	1	T	\N
222	thịt	1	T	\N
223	muốn	1	M	\N
225	cửa hàng rau quả	1	C	\N
226	chìa khoá	1	C	\N
227	nấu ăn	1	N	\N
228	đi mua hàng	0	D	\N
229	giặt	1	G	\N
230	dọn phòng	1	D	\N
231	gia đình	1	G	\N
233	sân	1	S	\N
235	nhà tôi?	\N		\N
236	nhà	1	N	\N
238	về	1	V	\N
239	kệ sách	1	K	\N
240	bàn	1	B	\N
241	ghế	1	G	\N
242	phòng	1	P	\N
243	tủ lạnh	1	T	\N
244	giặt	0	G	\N
245	rửa	1	R	\N
246	giường	1	G	\N
247	ra-đi-ô	1	R	\N
248	máy ra-đi-ô cát-xét	1	M	\N
249	tôi tên là ...	1	T	\N
250	đi ngủ	1	Đ	\N
252	bàn ăn	1	B	\N
253	ti-vi	1	T	\N
254	công an	1	C	\N
256	bản đồ	1	B	\N
258	đây	1	Đ	\N
259	đấy	1	Đ	\N
260	kia	1	K	\N
261	đâu	1	Đ	\N
262	đồn công an	1	Đ	\N
263	gần	1	G	\N
265	nghe	1	N	\N
266	cắt	1	C	\N
267	ngắn	1	N	\N
268	sau	1	S	\N
269	trước	1	T	\N
270	phải	1	P	\N
271	trái	1	T	\N
272	dài	1	D	\N
273	ngồi	1	N	\N
274	đứng	1	Đ	\N
275	bạn	1	B	\N
276	lớp	1	L	\N
277	lớp học	1	L	\N
278	hành lang	1	H	\N
279	trường học	1	T	\N
280	học sinh	1	H	\N
281	học tập	1	H	\N
282	sinh viên	1	S	\N
283	lưu học sinh	1	L	\N
284	nghỉ hè	1	N	\N
285	thầy giáo	1	T	\N
286	cô giáo	1	C	\N
287	trường đại học	1	T	\N
288	vở	1	V	\N
289	giờ học	1	G	\N
290	đặt câu	1	Đ	\N
291	bài tập	1	B	\N
292	khó	1	K	\N
293	dạy	1	D	\N
294	thi	1	T	\N
295	tập	1	T	\N
296	dễ	1	D	\N
297	tập	1	T	\N
298	hỏi	1	H	\N
299	bài	1	B	\N
300	trả lời	1	T	\N
301	đau	1	Đ	\N
302	răng	1	R	\N
303	bác sĩ	1	B	\N
304	bệnh viện	1	B	\N
305	bệnh	1	B	\N
306	thuốc	1	T	\N
307	chết	1	C	\N
308	bị cảm	1	B	\N
309	đầu	1	Đ	\N
311	độ	1	Đ	\N
312	thang máy	1	T	\N
313	vé	1	V	\N
314	xuống	1	X	\N
315	cầu thang	1	C	\N
316	đóng	1	Đ	\N
317	ga	1	G	\N
318	tàu điện ngầm	1	T	\N
319	đi	1	Đ	\N
321	lên	1	L	\N
323	mở	1	M	\N
324	phòng vệ sinh	1	P	\N
325	phòng vệ sinh	\N	P	\N
326	tàu điện	1	T	\N
327	đồ uống	1	Đ	\N
328	cà phê	1	C	\N
329	quán cà phê	1	Q	\N
330	chanh	1	C	\N
331	sữa	1	S	\N
332	đường	1	Đ	\N
333	tách	1	T	\N
334	trà	1	T	\N
335	trà Lipton	1	T	\N
336	cốc	1	C	\N
338	ngọt	1	N	\N
339	uống	1	U	\N
340	đũa	1	Đ	\N
341	rượu	1	R	\N
342	ngon	1	N	\N
343	dao	1	D	\N
344	thìa	1	T	\N
345	nĩa	1	N	\N
346	phó mát	1	P	\N
347	ăn	1	Ă	\N
348	dở	1	D	\N
349	không ngon miệng	1	K	\N
350	bánh mì	1	B	\N
351	cay	1	C	\N
352	nhà hàng	1	N	\N
353	quán ăn	1	Q	\N
354	vang	1	V	\N
355	món ăn	1	M	\N
356	thức ăn	1	T	\N
358	ca ri	1	C	\N
359	tiền	1	T	\N
360	ngân hàng	1	N	\N
361	lối vào	1	L	\N
362		\N		\N
363	không	1	K	\N
364	vâng	1	V	\N
365	có	1	C	\N
366	xin lỗi	1	X	\N
367	mời ...	1	M	\N
368	lối ra	1	L	\N
369	tới	1	T	\N
370	hộp thư	1	H	\N
371	bưu thiếp	1	B	\N
372	dán	1	D	\N
373	phong bì	1	P	\N
374	thư	1	T	\N
375	bưu điện	1	B	\N
376	trả	1	T	\N
377	gửi	1	G	\N
378	tem	1	T	\N
379	hành lý	1	H	\N
380	tờ	1	T	\N
381	cho mượn	1	C	\N
382	mua	1	M	\N
383	mũ	1	M	\N
384	giày	1	G	\N
385	đi mua hàng	1	Đ	\N
386	tầng	1	T	\N
387	cửa hàng tổng hợp	1	C	\N
388	váy	1	V	\N
389	áo khoác	1	A	\N
390	quần	1	Q	\N
391	áo len	1	A	\N
392	xin ...	1	X	\N
393	túi	1	T	\N
394	bán	1	B	\N
395	áo ngoài	1	A	\N
396	buồng tắm	1	B	\N
397	toà nhà	1	T	\N
398	phòng bếp	1	P	\N
399	vòi hoa sen	1	V	\N
400	cửa sổ	1	C	\N
401	sống	1	S	\N
402	công viên	1	C	\N
403	cửa	1	C	\N
404	tắm	1	T	\N
405	căn hộ	1	C	\N
406	cửa ra vào	1	C	\N
407	anh ấy	1	A	\N
408	ông ấy	1	Ô	\N
409	chị ấy	1	C	\N
410	cô ấy	1	C	\N
411	bà ấy	1	B	\N
412	các anh ấy	1	C	\N
413	các ông ấy	1	C	\N
414	các chị ấy	1	C	\N
415	các cô ấy	1	C	\N
416	các bà ấy	1	C	\N
417	tôi	1	T	\N
418	chúng ta	1	C	\N
419	chúng tôi	1	C	\N
420	một người nào đó	1	M	\N
421	ai	1	A	\N
423	cậu	1	C	\N
424	anh	1	A	\N
425	chị	1	C	\N
426	ông	1	Ô	\N
427	bà	1	B	\N
428	cô	1	C	\N
429	chú	1	C	\N
430	em	1	E	\N
431	cháu	1	C	\N
432	này	1	N	\N
433	ấy	1	Â	\N
436	gì	1	G	\N
437	nào	1	N	\N
438	thế nào	1	T	\N
439	thế này	1	T	\N
440	mình	1	M	\N
441	thế	1	T	\N
442	dày	1	D	\N
443	hẹp	1	H	\N
444	mỏng	1	M	\N
445	to	1	T	\N
446	lớn	1	L	\N
448	trẻ	1	T	\N
449	rộng	1	R	\N
450	nhẹ	1	N	\N
451	xa	1	X	\N
452	nặng	1	N	\N
454	mới	1	M	\N
455	nhỏ	1	N	\N
457	cũ	1	C	\N
458	vui	1	V	\N
459	náo nhiệt	1	N	\N
460	thấp	1	T	\N
461	tốt	1	T	\N
462	sáng	1	S	\N
463	yếu	1	Y	\N
464	mạnh	1	M	\N
465	thú vị	1	T	\N
466	đẹp	1	Đ	\N
467	chậm	1	C	\N
468	xấu	1	X	\N
469	nhiều	1	N	\N
470	tối	1	T	\N
471	yên tĩnh	1	Y	\N
472	ít	1	I	\N
473	bẩn	1	B	\N
474	chán	1	C	\N
475	bên cạnh	1	B	\N
476	trong	1	T	\N
477	ngoài	1	N	\N
478	phía đông	1	P	\N
479	chiều cao	1	C	\N
480	độ cao	1	Đ	\N
481	chiều dài	1	C	\N
482	phía bắc	1	P	\N
483	phía tây	1	P	\N
484	dưới	1	D	\N
485	phía nam	1	P	\N
486	trên	1	T	\N
489	anh họ	1	A	\N
490	chị ho	1	C	\N
491	em họ	1	E	\N
493	anh em	1	A	\N
494	bà ngoại	1	B	\N
495	bà nội	1	B	\N
496	ông ngoại	1	Ô	\N
497	ông nội	1	Ô	\N
498	vợ	1	V	\N
499	mẹ	1	M	\N
500	bác	1	B	\N
502	bố mẹ	1	B	\N
503	cha mẹ	1	C	\N
504	bố	1	B	\N
505	cha	1	C	\N
507	chị em	1	C	\N
514	bít tất	1	B	\N
515	áo lót	1	A	\N
516	cởi	1	C	\N
517	treo	1	T	\N
518	mặc	1	M	\N
520	đội	1	Đ	\N
521	khăn tay	1	K	\N
522	dép	1	D	\N
523	ô	1	Ô	\N
525	ví	1	V	\N
527	áo	1	A	\N
529	miệng	1	M	\N
530	cánh tay	1	C	\N
531	người	1	N	\N
532	mặt	1	M	\N
533	chân	1	C	\N
534	tay	1	T	\N
535	mũi	1	M	\N
536	mắt	1	M	\N
537	tai	1	T	\N
539	bụng	1	B	\N
540	đĩa	1	Đ	\N
541	bơ	1	B	\N
542	bát	1	B	\N
543	kẹo	1	K	\N
544	bữa trưa	1	B	\N
546	bánh kẹo	1	B	\N
547	trứng	1	T	\N
548	bữa sáng	1	B	\N
549	cơm	1	C	\N
550	xì dầu	1	X	\N
551	muối	1	M	\N
552	bữa tối	1	B	\N
553	thêm	1	T	\N
554	bật	1	B	\N
555	máy ảnh	1	M	\N
556	sưởi lò	1	S	\N
557	bút chì	1	B	\N
558	tắt	1	T	\N
559	kính	1	K	\N
560	máy ghi âm	1	M	\N
561	đồng hồ	1	Đ	\N
562	máy tính	1	M	\N
565	cổng	1	C	\N
566	bút	1	B	\N
567	bút máy	1	B	\N
568	bút bi	1	B	\N
569	tháng tám	1	T	\N
570	tháng tư	1	T	\N
571	tháng này	1	T	\N
572	hàng tháng	1	T	\N
573	tháng mười hai	1	T	\N
574	tháng hai	1	T	\N
575	tháng một	1	T	\N
576	tháng bảy	1	T	\N
577	tháng sáu	1	T	\N
578	tháng sau	1	T	\N
579	tháng năm	1	T	\N
580	tháng ba	1	T	\N
581	tháng trước	1	T	\N
582	tháng mười một	1	T	\N
583	tháng mười	1	T	\N
584	tháng chín	1	T	\N
585	một tháng	1	M	\N
586	tuần này	1	T	\N
587	hàng tuần	1	H	\N
588	chủ nhật	1	C	\N
589	thứ năm	1	T	\N
590	tuần sau	1	T	\N
591	thứ hai	1	T	\N
592	thứ ba	1	T	\N
593	thứ tư	1	T	\N
594	thứ bảy	1	T	\N
595	tuần	1	T	\N
596	tuần trước	1	T	\N
597	thứ sáu	1	T	\N
598	năm	1	N	\N
599	mùa thu	1	M	\N
600	năm nay	1	N	\N
601	hàng năm	1	H	\N
602	mùa hè	1	M	\N
603	mùa đông	1	M	\N
604	năm ngoái	1	N	\N
606	năm sau	1	N	\N
609	mùa xuân	1	M	\N
610	năm sau nữa	1	N	\N
611	năm kia	1	N	\N
612	buổi chiều	1	B	\N
613	hôm nay	1	H	\N
614	ngày mai	1	N	\N
615	giờ	1	G	\N
616	hôm qua	1	H	\N
617	tối qua	1	T	\N
618	buổi sáng	1	B	\N
619	sáng	0	S	\N
622	chiều	1	C	\N
623	ngày mốt	0	N	\N
624	hôm kia	1	H	\N
625	đã	1	Đ	\N
626	vừa ... vừa ... 	1	V	\N
627	chưa	1	C	\N
628	cả	1	C	\N
629	suốt	1	S	\N
630	khi	1	K	\N
631	khi nào	1	K	\N
632	có khi	1	C	\N
633	hay	1	H	\N
634	nhiều lần	1	N	\N
635	thời gian	1	T	\N
636	sắp	1	S	\N
637	gạt tàn	1	G	\N
638	bài hát	1	B	\N
639	hát	1	H	\N
640	thuốc lá	1	T	\N
641	phim	1	P	\N
642	đĩa hát	1	Đ	\N
643	đàn ghi-ta	1	Đ	\N
644	chơi	1	C	\N
645	âm nhạc	1	Â	\N
646	tranh	1	T	\N
647	bức ảnh	1	B	\N
648	thích	1	T	\N
649	tiếng	1	T	\N
650	trời đẹp	1	T	\N
651	nóng	1	N	\N
653	mát	1	M	\N
654	lạnh	1	L	\N
655	rét	1	R	\N
656	tuyết	1	T	\N
657	mưa	1	M	\N
659	thời tiết	1	T	\N
660	ấm	1	Â	\N
661	gió	1	G	\N
662	có mây	1	C	\N
665	chữ Hán	1	C	\N
666	nói	1	N	\N
667	viết	1	V	\N
668	chuyện	1	C	\N
669	lời nói	1	L	\N
671	từ	1	T	\N
672	nói chuyện	1	N	\N
673	câu	1	C	\N
674	kể	1	K	\N
675	ý nghĩa	1	Y	\N
676	Hiragana	1	H	\N
677	Katakana	1	K	\N
678	người lớn	1	N	\N
679	đám đông	1	Đ	\N
680	vợ chồng	1	V	\N
681	trẻ con	1	T	\N
683	phụ nữ	1	P	\N
684	con trai	1	C	\N
686	đàn ông	1	Đ	\N
687	con gái	1	C	\N
688	chồng	1	C	\N
690	mọi người	1	M	\N
691	trắng	1	T	\N
692	xanh da trời	1	X	\N
693	nâu	1	N	\N
695	nhạt	1	N	\N
696	màu	1	M	\N
698	thẫm	1	T	\N
699	vàng	1	V	\N
700	đen	1	Đ	\N
701	đỏ	1	Đ	\N
702	xanh lá cây	1	X	\N
703	tiện	1	T	\N
704	liên hoan	1	L	\N
705	giấy	1	G	\N
706	trở thành	1	T	\N
707	trở nên	1	T	\N
708	thắt	1	T	\N
709	ấn	1	Â	\N
710	bắt đầu	1	B	\N
711	vừa	1	V	\N
712	không có	1	K	\N
713	thẳng	1	T	\N
714	nổi tiếng	1	N	\N
715	khỏe	1	K	\N
716	thế nhé!	1	T	\N
717	thế thì	1	T	\N
718	có lẽ	1	C	\N
720	ngày kia	1	N	\N
721	đó	1	Đ	\N
722	dậy	1	D	\N
723	tiếng Việt	1	T	\N
163	chơi	0	C	\N
166	thích	0	T	\N
169	chậm	0	C	\N
216	trái cây	0	T	\N
224	trao	0	T	\N
232	gia đình	0	G	\N
234	giặt áo	0	G	\N
237	dọn phòng	0	D	\N
251	thức dậy	0	T	\N
255	công an	0	C	\N
257	bên cạnh	0	B	\N
264	bên cảnh	0	B	\N
310	bùng	0	B	\N
320	cưỡi	0	C	\N
322	xuống	0	X	\N
337	đổ	0	Đ	\N
357	đồ ăn	0	Đ	\N
422	ai	0	A	\N
434	kia	0	K	\N
435	thế nào?	0	T	\N
447	dày	0	D	\N
453	mỏng	0	M	\N
456	gần	0	G	\N
487	trước	0	T	\N
488	sau	0	S	\N
501	chú	0	C	\N
506	chị	0	C	\N
508	cô	0	C	\N
509	anh	0	A	\N
510	chị	0	C	\N
511	bố	0	B	\N
512	cha	0	C	\N
513	mẹ	0	M	\N
519	mặc	0	M	\N
524	túi	0	T	\N
526	mặc	0	M	\N
538	chân	0	C	\N
545	bữa tối	0	B	\N
563	phim	0	P	\N
564	cửa	0	C	\N
605	năm qua	0	N	\N
607	năm tới	0	N	\N
608	sang năm	0	S	\N
620	trưa	0	T	\N
621	tối	0	T	\N
652	trời đẹp	0	T	\N
658	mưa	0	M	\N
663	lạnh	0	L	\N
664	có mây	0	C	\N
670	tiếng	0	T	\N
682	vợ	0	V	\N
685	người	0	N	\N
689	người	0	N	\N
694	sáng	0	S	\N
697	tối	0	T	\N
719	thế thì	0	T	\N
492	anh	0	A	\N
528	bộ quần áo	1	B	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: vi
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
1	 khoẻ 	元気な	形容詞	\N	\N	\N	1208	\N
2	 gia đình 	家族	名詞	\N	\N	\N	1210	\N
3	 cũng 	～も	副詞	\N	\N	\N	1211	\N
4	 sáng 	朝 	名詞 	\N	\N	\N	1212	\N
5	 bánh mì 	パン 	 名詞	\N	\N	\N	1214	\N
6	 cà phê 	コーヒー 	 名詞	\N	\N	\N	1214	\N
7	 siêu thị 	 スーパーマーケット	 名詞	\N	\N	\N	1218	\N
8	 đông	混んでいる、人が多い 	形容詞	\N	\N	\N	1218	\N
9	 bài tập	 宿題	名詞 	\N	\N	\N	1226	\N
10	 nhớ 	覚えている 	名詞 	\N	\N	\N	1227	\N
11	 trường đại học 	 大学	名詞 	\N	\N	\N	1231	\N
12	 nhớ ra 	思い出す	動詞句	\N	\N	\N	1232	\N
13	 muộn 	遅く	副詞	\N	\N	\N	1236	\N
14	sao	問題である	動詞	\N	\N	\N	1237	\N
15	mới 	～したばかり	副詞	\N	\N	\N	1238	\N
16	 sinh nhật 	誕生日	名詞	\N	\N	\N	1243	\N
17	 tặng 	贈る	動詞	\N	\N	\N	1244	\N
18	 vui vẻ 	楽しい	形容詞	\N	\N	\N	1245	\N
19	 tiếng Nhật 	日本語	名詞	\N	\N	\N	1248	\N
20	 hẹn 	約束する	動詞	\N	\N	\N	1257	\N
21	 cẩn thận 	注意深く	形容詞	\N	\N	\N	1261	\N
22	 tạm biệt 	さよならを言う	動詞	\N	\N	\N	1263	\N
23	 tiền 	お金	名詞	\N	\N	\N	1268	\N
24	 đắt 	高い	形容詞	\N	\N	\N	1270	\N
25	 bớt 	割引する	動詞	\N	\N	\N	1271	\N
26	 chương trình 	プログラム 	名詞	\N	\N	\N	1276	\N
27	 du lịch 	旅行	名詞	\N	\N	\N	1276	\N
28	 thành phố 	 都市	名詞 	\N	\N	\N	1281	\N
29	 sạch sẽ 	 きれいな，清潔な	形容詞	\N	\N	\N	1281	\N
30	 phong cảnh 	景色	名詞	\N	\N	\N	1281	\N
31	 từng 	 ～したことがある	副詞	\N	\N	\N	1284	\N
32	 nghỉ hè 	夏休み 	動詞 	\N	\N	\N	1287	\N
33	 biển 	海 	 名詞	\N	\N	\N	1290	\N
34	 sướng 	幸せな	形容詞	\N	\N	\N	1295	\N
35	làm thêm	 アルバイトをする	動詞	\N	\N	\N	1298	\N
36	 chán 	 つまらない、がっかりだ	形容詞	\N	\N	\N	1298	\N
37	 chữ Hán 	漢字	名詞	\N	\N	\N	1302	\N
38	 phát âm 	発音	名詞	\N	\N	\N	1304	\N
39	 bao giờ 	いつ 	副詞 	\N	\N	\N	1309	\N
40	bắt đầu 	始まる	動詞	\N	\N	\N	1311	\N
41	 đợi 	待つ	動詞	\N	\N	\N	1313	\N
42	 đón 	 迎える	 動詞	\N	\N	\N	1314	\N
43	 thôi 	それでは	語気詞	\N	\N	\N	1317	\N
44	 điện thoại 	電話	名詞	\N	\N	\N	1319	\N
45	 ghi 	書く	動詞	\N	\N	\N	1321	\N
46	 đúng 	正しい	形容詞	\N	\N	\N	1323	\N
47	 nghỉ 	休む	動詞	\N	\N	\N	1330	\N
48	 bằng 	～で	関係詞	\N	\N	\N	1332	\N
49	 với 	～と	関係詞	\N	\N	\N	1334	\N
50	 chơi 	演奏する	動詞	\N	\N	\N	1339	\N
51	 nhạc cụ 	楽器	名詞	\N	\N	\N	1339	\N
52	 bình thường 	普通の	形容詞	\N	\N	\N	1345	\N
53	 từ điển 	辞典	名詞	\N	\N	\N	1350	\N
54	 hiệu sách 	本屋	名詞	\N	\N	\N	1353	\N
55	 ngoại văn 	洋書	名詞	\N	\N	\N	1354	\N
56	 học 	学ぶ、勉強する	動詞	\N	\N	\N	1358	\N
19	 tiếng Nhật 	日本語	名詞	\N	\N	\N	1358	\N
57	giáo viên	教員、教師	名詞	\N	\N	\N	1361	\N
58	 tên 	名前	名詞	\N	\N	\N	1361	\N
59	 lớp 	クラス、教室	名詞	\N	\N	\N	1364	\N
60	 sinh viên 	大学生	名詞	\N	\N	\N	1364	\N
61	 quyển 	（本や帳面の）冊	類別詞	\N	\N	\N	1365	\N
62	 sách 	本	名詞	\N	\N	\N	1365	\N
63	 tiếng Nga 	ロシア語	名詞	\N	\N	\N	1367	\N
64	 ngữ pháp 	文法	名詞	\N	\N	\N	1369	\N
65	 đồng ý 	同意する、賛同する	動詞	\N	\N	\N	1375	\N
66	 thích 	好む、好きである	動詞	\N	\N	\N	1376	\N
67	 món ăn 	料理	名詞	\N	\N	\N	1383	\N
68	 thứ bảy 	土曜日	名詞	\N	\N	\N	1388	\N
69	 chủ nhật 	日曜日	名詞	\N	\N	\N	1388	\N
70	 làm 	する	動詞	\N	\N	\N	1388	\N
71	 xem 	見る	動詞	\N	\N	\N	1389	\N
72	 phim 	映画	名詞	\N	\N	\N	1389	\N
73	 Mỹ 	アメリカ	名詞	\N	\N	\N	1390	\N
74	 thể thao	スポーツ	名詞	\N	\N	\N	1392	\N
75	 bóng đá 	サッカー	名詞	\N	\N	\N	1394	\N
76	 thủ tục 	手続き	名詞	\N	\N	\N	1396	\N
77	 hộ chiếu 	パスポート	名詞	\N	\N	\N	1398	\N
78	 sứ quán 	大使館	名詞	\N	\N	\N	1399	\N
79	 vé 	切符	名詞	\N	\N	\N	1400	\N
80	 máy bay 	飛行機	名詞	\N	\N	\N	1400	\N
81	 dạo này 	最近	副詞	\N	\N	\N	1409	\N
82	 bố mẹ 	父母	名詞	\N	\N	\N	1409	\N
83	 em gái 	妹	名詞	\N	\N	\N	1411	\N
84	 rủ 	誘う	動詞	\N	\N	\N	1419	\N
85	 có thể 	かもしれない	副詞	\N	\N	\N	1421	\N
86	(trời) mưa 	（雨が）降る	動詞	\N	\N	\N	1421	\N
87	 vở 	ノート	名詞	\N	\N	\N	1431	\N
88	 chữ 	文字	名詞	\N	\N	\N	1431	\N
89	 đói 	空腹な	形容詞	\N	\N	\N	1432	\N
90	 tốt nghiệp 	卒業する	 動詞	\N	\N	\N	1439	\N
91	 nghề 	職業 	 名詞	\N	\N	\N	1441	\N
92	 giúp 	手助けする、助ける 	動詞	\N	\N	\N	1444	\N
93	 gặp khó khăn 	 困難に遭う	 動詞句	\N	\N	\N	1444	\N
94	 tìm 	 探す	 動詞	\N	\N	\N	1449	\N
95	 ghi băng 	録画する 	 動詞	\N	\N	\N	1451	\N
96	 mãi 	 ずっと	 副詞	\N	\N	\N	1454	\N
97	 du học 	留学する	 動詞	\N	\N	\N	1465	\N
98	 ví dụ 	例えば	副詞	\N	\N	\N	1470	\N
99	 nghe đài 	ラジオを聞く 	 動詞	\N	\N	\N	1470	\N
100	 nhật ký 	 日記	 名詞	\N	\N	\N	1470	\N
101	 tất cả 	全て 	 数量詞	\N	\N	\N	1471	\N
102	rảnh	暇な	形容詞	\N	\N	\N	1474	\N
103	thăm	訪問する	動詞	\N	\N	\N	1478	\N
104	cổng trường	校門	名詞	\N	\N	\N	1481	\N
105	thứ sáu tuần sau	来週の金曜日	名詞句	\N	\N	\N	1486	\N
106	đám cưới	結婚式	名詞	\N	\N	\N	1488	\N
107	nhà hát	劇場	名詞	\N	\N	\N	1504	\N
108	vở kịch	劇	名詞	\N	\N	\N	1504	\N
109	từ nay	これから，今後	副詞	\N	\N	\N	1513	\N
110	chú ý	気をつける、注意する	動詞	\N	\N	\N	1513	\N
111	 muốn 	欲する、～したい	動詞	\N	\N	\N	1517	\N
112	 hỏi 	尋ねる、質問する	動詞	\N	\N	\N	1517	\N
113	 khác 	別の、異なる	形容詞	\N	\N	\N	1519	\N
114	 hôm nay 	今日	名詞	\N	\N	\N	1523	\N
115	 thi 	試験をする	動詞	\N	\N	\N	1523	\N
64	 ngữ pháp 	文法	名詞	\N	\N	\N	1523	\N
116	 lo 	心配する	動詞	\N	\N	\N	1524	\N
117	 chuẩn bị 	準備する	動詞	\N	\N	\N	1526	\N
118	 dễ 	簡単な、容易な	形容詞	\N	\N	\N	1526	\N
119	 bắt đầu 	始める	動詞	\N	\N	\N	1530	\N
68	 thứ bảy 	土曜日	名詞	\N	\N	\N	1531	\N
59	 lớp 	教室	名詞	\N	\N	\N	1531	\N
120	 dạy 	教える	動詞	\N	\N	\N	1532	\N
121	 thêm 	付け加える	動詞	\N	\N	\N	1532	\N
122	 ngữ âm 	音声	名詞	\N	\N	\N	1532	\N
123	 chết 	死ぬ	動詞	\N	\N	\N	1533	\N
124	 định 	～するつもりである、予定する	動詞	\N	\N	\N	1534	\N
50	 chơi 	遊ぶ	動詞	\N	\N	\N	1534	\N
125	 người yêu 	恋人	名詞	\N	\N	\N	1534	\N
126	 chủ nhật	日曜日	名詞	\N	\N	\N	1536	\N
127	 hiểu	理解する	動詞	\N	\N	\N	1537	\N
128	 mang 	携行する	動詞	\N	\N	\N	1538	\N
62	 sách 	本	名詞	\N	\N	\N	1538	\N
129	 phòng ngữ âm 	ＬＬ教室	名詞	\N	\N	\N	1539	\N
130	 tết 	旧正月	名詞	\N	\N	\N	1543	\N
131	 về 	帰る	動詞	\N	\N	\N	1543	\N
132	 mời 	招待する	動詞	\N	\N	\N	1549	\N
133	 đến 	来る、到達する	動詞	\N	\N	\N	1549	\N
134	 nhà	家	名詞	\N	\N	\N	1549	\N
135	 cám ơn 	感謝する	動詞	\N	\N	\N	1550	\N
136	 chiều 	午後	名詞	\N	\N	\N	1552	\N
137	lỡ (hẹn)	（約束を）破る	動詞	\N	\N	\N	1559	\N
138	giận	怒る	動詞	\N	\N	\N	1560	\N
139	bản báo cáo	レポート	名詞	\N	\N	\N	1567	\N
140	giám đốc	社長	名詞	\N	\N	\N	1568	\N
141	nộp	提出する	動詞	\N	\N	\N	1568	\N
142	cố gắng	頑張る	動詞	\N	\N	\N	1574	\N
143	bạn trai	ボーイフレンド	名詞	\N	\N	\N	1576	\N
144	tình yêu	愛情	名詞	\N	\N	\N	1578	\N
145	lấy	結婚する	動詞	\N	\N	\N	1581	\N
146	giới thiệu	紹介する	動詞	\N	\N	\N	1587	\N
147	ngoại ngữ	外国語	名詞	\N	\N	\N	1588	\N
148	khoa	学科	名詞	\N	\N	\N	1592	\N
421	ai	\N		\N	\N	\N	584	\N
421	ai	\N		\N	\N	\N	676	\N
421	ai	\N		\N	\N	\N	823	\N
421	ai	\N		\N	\N	\N	1172	\N
424	anh	\N		\N	\N	\N	575	\N
424	anh	\N		\N	\N	\N	678	\N
424	anh	\N		\N	\N	\N	1208	\N
424	anh	\N		\N	\N	\N	1337	\N
424	anh	\N		\N	\N	\N	1346	\N
407	anh ấy	\N		\N	\N	\N	569	\N
407	anh ấy	\N		\N	\N	\N	1026	\N
407	anh ấy	\N		\N	\N	\N	1131	\N
527	áo	\N		\N	\N	\N	597	\N
660	ấm	\N		\N	\N	\N	1075	\N
433	ấy	\N		\N	\N	\N	1159	\N
433	ấy	\N		\N	\N	\N	1162	\N
347	ăn	\N		\N	\N	\N	1212	\N
347	ăn	\N		\N	\N	\N	1376	\N
347	ăn	\N		\N	\N	\N	1435	\N
411	bà ấy	\N		\N	\N	\N	875	\N
500	bác	\N		\N	\N	\N	911	\N
299	bài	\N		\N	\N	\N	577	\N
299	bài	\N		\N	\N	\N	1226	\N
299	bài	\N		\N	\N	\N	1528	\N
638	bài hát	\N		\N	\N	\N	832	\N
291	bài tập	\N		\N	\N	\N	577	\N
291	bài tập	\N		\N	\N	\N	852	\N
291	bài tập	\N		\N	\N	\N	1372	\N
394	bán	\N		\N	\N	\N	1350	\N
394	bán	\N		\N	\N	\N	1352	\N
240	bàn	\N		\N	\N	\N	835	\N
240	bàn	\N		\N	\N	\N	1031	\N
275	bạn	\N		\N	\N	\N	728	\N
275	bạn	\N		\N	\N	\N	1587	\N
275	bạn	\N		\N	\N	\N	1164	\N
275	bạn	\N		\N	\N	\N	1244	\N
275	bạn	\N		\N	\N	\N	1246	\N
275	bạn	\N		\N	\N	\N	1474	\N
198	bận	\N		\N	\N	\N	1454	\N
198	bận	\N		\N	\N	\N	1483	\N
350	bánh mì	\N		\N	\N	\N	1214	\N
202	báo	\N		\N	\N	\N	746	\N
202	báo	\N		\N	\N	\N	1470	\N
214	bao nhiêu	\N		\N	\N	\N	708	\N
214	bao nhiêu	\N		\N	\N	\N	713	\N
214	bao nhiêu	\N		\N	\N	\N	1363	\N
215	bao nhiêu tiền	\N		\N	\N	\N	711	\N
215	bao nhiêu tiền	\N		\N	\N	\N	1268	\N
542	bát	\N		\N	\N	\N	1171	\N
710	bắt đầu	\N		\N	\N	\N	1007	\N
710	bắt đầu	\N		\N	\N	\N	1311	\N
710	bắt đầu	\N		\N	\N	\N	1530	\N
475	bên cạnh	\N		\N	\N	\N	836	\N
475	bên cạnh	\N		\N	\N	\N	841	\N
304	bệnh viện	\N		\N	\N	\N	756	\N
304	bệnh viện	\N		\N	\N	\N	875	\N
308	bị cảm	\N		\N	\N	\N	917	\N
504	bố	\N		\N	\N	\N	833	\N
504	bố	\N		\N	\N	\N	1022	\N
504	bố	\N		\N	\N	\N	1133	\N
178	bể bơi	\N		\N	\N	\N	1061	\N
502	bố mẹ	\N		\N	\N	\N	620	\N
502	bố mẹ	\N		\N	\N	\N	910	\N
502	bố mẹ	\N		\N	\N	\N	1409	\N
172	bơi	\N		\N	\N	\N	834	\N
647	bức ảnh	\N		\N	\N	\N	665	\N
618	buổi sáng	\N		\N	\N	\N	727	\N
566	bút	\N		\N	\N	\N	1064	\N
566	bút	\N		\N	\N	\N	809	\N
375	bưu điện	\N		\N	\N	\N	596	\N
328	cà phê	\N		\N	\N	\N	1214	\N
412	các anh ấy	\N		\N	\N	\N	1065	\N
266	cắt	\N		\N	\N	\N	1081	\N
365	có	\N		\N	\N	\N	565	\N
365	có	\N		\N	\N	\N	578	\N
365	có	\N		\N	\N	\N	1544	\N
428	cô	\N		\N	\N	\N	1506	\N
428	cô	\N		\N	\N	\N	748	\N
410	cô ấy	\N		\N	\N	\N	1054	\N
410	cô ấy	\N		\N	\N	\N	1076	\N
410	cô ấy	\N		\N	\N	\N	1560	\N
683	phụ nữ	\N		\N	\N	\N	415	\N
286	cô giáo	\N		\N	\N	\N	909	\N
286	cô giáo	\N		\N	\N	\N	1145	\N
286	cô giáo	\N		\N	\N	\N	1147	\N
718	có lẽ	\N		\N	\N	\N	1229	\N
718	có lẽ	\N		\N	\N	\N	1253	\N
549	cơm	\N		\N	\N	\N	575	\N
549	cơm	\N		\N	\N	\N	879	\N
549	cơm	\N		\N	\N	\N	1565	\N
565	cổng	\N		\N	\N	\N	1481	\N
254	công an	\N		\N	\N	\N	1136	\N
191	công ty	\N		\N	\N	\N	683	\N
191	công ty	\N		\N	\N	\N	848	\N
191	công ty	\N		\N	\N	\N	1159	\N
457	cũ	\N		\N	\N	\N	418	\N
467	chậm	\N		\N	\N	\N	949	\N
474	chán	\N		\N	\N	\N	928	\N
474	chán	\N		\N	\N	\N	1298	\N
533	chân	\N		\N	\N	\N	610	\N
431	cháu	\N		\N	\N	\N	952	\N
431	cháu	\N		\N	\N	\N	956	\N
168	chạy	\N		\N	\N	\N	654	\N
168	chạy	\N		\N	\N	\N	937	\N
307	chết	\N		\N	\N	\N	1054	\N
425	chị	\N		\N	\N	\N	534	\N
425	chị	\N		\N	\N	\N	1267	\N
425	chị	\N		\N	\N	\N	1563	\N
409	chị ấy	\N		\N	\N	\N	1201	\N
409	chị ấy	\N		\N	\N	\N	1116	\N
622	chiều	\N		\N	\N	\N	1568	\N
644	chơi	\N		\N	\N	\N	1340	\N
644	chơi	\N		\N	\N	\N	1347	\N
644	chơi	\N		\N	\N	\N	1348	\N
644	chơi	\N		\N	\N	\N	1349	\N
665	chữ Hán	\N		\N	\N	\N	828	\N
665	chữ Hán	\N		\N	\N	\N	1302	\N
588	chủ nhật	\N		\N	\N	\N	1161	\N
588	chủ nhật	\N		\N	\N	\N	1497	\N
588	chủ nhật	\N		\N	\N	\N	1536	\N
627	chưa	\N		\N	\N	\N	1040	\N
627	chưa	\N		\N	\N	\N	1213	\N
627	chưa	\N		\N	\N	\N	1578	\N
418	chúng ta	\N		\N	\N	\N	646	\N
418	chúng ta	\N		\N	\N	\N	1239	\N
418	chúng ta	\N		\N	\N	\N	1530	\N
419	chúng tôi	\N		\N	\N	\N	1106	\N
668	chuyện	\N		\N	\N	\N	1450	\N
668	chuyện	\N		\N	\N	\N	1006	\N
668	chuyện	\N		\N	\N	\N	1162	\N
668	chuyện	\N		\N	\N	\N	1558	\N
272	dài	\N		\N	\N	\N	557	\N
293	dạy	\N		\N	\N	\N	956	\N
293	dạy	\N		\N	\N	\N	1532	\N
296	dễ	\N		\N	\N	\N	28	\N
296	dễ	\N		\N	\N	\N	1526	\N
230	dọn phòng	\N		\N	\N	\N	754	\N
161	du lịch	\N		\N	\N	\N	588	\N
161	du lịch	\N		\N	\N	\N	606	\N
161	du lịch	\N		\N	\N	\N	1035	\N
161	du lịch	\N		\N	\N	\N	1276	\N
625	đã	\N		\N	\N	\N	222	\N
625	đã	\N		\N	\N	\N	872	\N
625	đã	\N		\N	\N	\N	1212	\N
643	đàn ghi-ta	\N		\N	\N	\N	1340	\N
212	đắt	\N		\N	\N	\N	553	\N
212	đắt	\N		\N	\N	\N	1270	\N
301	đau	\N		\N	\N	\N	601	\N
301	đau	\N		\N	\N	\N	608	\N
261	đâu	\N		\N	\N	\N	596	\N
261	đâu	\N		\N	\N	\N	599	\N
261	đâu	\N		\N	\N	\N	1288	\N
309	đầu	\N		\N	\N	\N	608	\N
258	đây	\N		\N	\N	\N	538	\N
258	đây	\N		\N	\N	\N	585	\N
258	đây	\N		\N	\N	\N	1505	\N
258	đây	\N		\N	\N	\N	1587	\N
721	đó	\N		\N	\N	\N	1052	\N
721	đó	\N		\N	\N	\N	1366	\N
700	đen	\N		\N	\N	\N	1016	\N
466	đẹp	\N		\N	\N	\N	974	\N
466	đẹp	\N		\N	\N	\N	1069	\N
466	đẹp	\N		\N	\N	\N	1428	\N
319	đi	\N		\N	\N	\N	743	\N
149	đi	\N		\N	\N	\N	599	\N
149	đi	\N		\N	\N	\N	606	\N
149	đi	\N		\N	\N	\N	1284	\N
149	đi	\N		\N	\N	\N	1418	\N
171	đi bộ	\N		\N	\N	\N	740	\N
162	đi du lịch	\N		\N	\N	\N	588	\N
162	đi du lịch	\N		\N	\N	\N	606	\N
162	đi du lịch	\N		\N	\N	\N	1276	\N
250	đi ngủ	\N		\N	\N	\N	127	\N
195	điện thoại	\N		\N	\N	\N	1319	\N
701	đỏ	\N		\N	\N	\N	1268	\N
203	đọc	\N		\N	\N	\N	881	\N
203	đọc	\N		\N	\N	\N	1470	\N
561	đồng hồ	\N		\N	\N	\N	1170	\N
274	đứng	\N		\N	\N	\N	1182	\N
182	đường	\N		\N	\N	\N	843	\N
430	em	\N		\N	\N	\N	709	\N
430	em	\N		\N	\N	\N	1451	\N
317	ga	\N		\N	\N	\N	998	\N
263	gần	\N		\N	\N	\N	1196	\N
159	gặp	\N		\N	\N	\N	871	\N
159	gặp	\N		\N	\N	\N	1102	\N
377	gửi	\N		\N	\N	\N	489	\N
377	gửi	\N		\N	\N	\N	1259	\N
436	gì	\N		\N	\N	\N	66	\N
436	gì	\N		\N	\N	\N	68	\N
436	gì	\N		\N	\N	\N	1441	\N
436	gì	\N		\N	\N	\N	1217	\N
231	gia đình	\N		\N	\N	\N	1210	\N
231	gia đình	\N		\N	\N	\N	1335	\N
615	giờ	\N		\N	\N	\N	718	\N
615	giờ	\N		\N	\N	\N	719	\N
615	giờ	\N		\N	\N	\N	1455	\N
615	giờ	\N		\N	\N	\N	1014	\N
289	giờ học	\N		\N	\N	\N	746	\N
167	giỏi	\N		\N	\N	\N	549	\N
167	giỏi	\N		\N	\N	\N	1467	\N
167	giỏi	\N		\N	\N	\N	1472	\N
278	hành lang	\N		\N	\N	\N	937	\N
639	hát	\N		\N	\N	\N	832	\N
280	học sinh	\N		\N	\N	\N	1149	\N
298	hỏi	\N		\N	\N	\N	1049	\N
298	hỏi	\N		\N	\N	\N	1517	\N
613	hôm nay	\N		\N	\N	\N	796	\N
613	hôm nay	\N		\N	\N	\N	800	\N
613	hôm nay	\N		\N	\N	\N	802	\N
613	hôm nay	\N		\N	\N	\N	1218	\N
616	hôm qua	\N		\N	\N	\N	870	\N
616	hôm qua	\N		\N	\N	\N	1023	\N
194	hút	\N		\N	\N	\N	1505	\N
194	hút	\N		\N	\N	\N	1507	\N
472	ít	\N		\N	\N	\N	600	\N
260	kia	\N		\N	\N	\N	654	\N
260	kia	\N		\N	\N	\N	855	\N
155	khách sạn	\N		\N	\N	\N	968	\N
155	khách sạn	\N		\N	\N	\N	1028	\N
630	khi	\N		\N	\N	\N	753	\N
630	khi	\N		\N	\N	\N	1199	\N
631	khi nào	\N		\N	\N	\N	594	\N
631	khi nào	\N		\N	\N	\N	595	\N
631	khi nào	\N		\N	\N	\N	1551	\N
292	khó	\N		\N	\N	\N	1302	\N
292	khó	\N		\N	\N	\N	1370	\N
292	khó	\N		\N	\N	\N	1528	\N
715	khỏe	\N		\N	\N	\N	762	\N
715	khỏe	\N		\N	\N	\N	943	\N
363	không	\N		\N	\N	\N	1173	\N
363	không	\N		\N	\N	\N	1228	\N
363	không	\N		\N	\N	\N	1386	\N
712	không có	\N		\N	\N	\N	1029	\N
712	không có	\N		\N	\N	\N	1108	\N
712	không có	\N		\N	\N	\N	1461	\N
177	không thích	\N		\N	\N	\N	935	\N
177	không thích	\N		\N	\N	\N	1381	\N
193	làm	\N		\N	\N	\N	1441	\N
193	làm	\N		\N	\N	\N	872	\N
193	làm	\N		\N	\N	\N	1298	\N
197	làm việc	\N		\N	\N	\N	637	\N
197	làm việc	\N		\N	\N	\N	853	\N
197	làm việc	\N		\N	\N	\N	1109	\N
654	lạnh	\N		\N	\N	\N	1056	\N
321	lên	\N		\N	\N	\N	1003	\N
704	liên hoan	\N		\N	\N	\N	884	\N
276	lớp	\N		\N	\N	\N	681	\N
276	lớp	\N		\N	\N	\N	1531	\N
276	lớp	\N		\N	\N	\N	1587	\N
277	lớp học	\N		\N	\N	\N	1507	\N
277	lớp học	\N		\N	\N	\N	1513	\N
655	rét	\N		\N	\N	\N	981	\N
464	mạnh	\N		\N	\N	\N	304	\N
464	mạnh	\N		\N	\N	\N	989	\N
536	mắt	\N		\N	\N	\N	609	\N
213	mấy	\N		\N	\N	\N	716	\N
213	mấy	\N		\N	\N	\N	762	\N
213	mấy	\N		\N	\N	\N	1455	\N
151	máy bay	\N		\N	\N	\N	1114	\N
151	máy bay	\N		\N	\N	\N	1278	\N
562	máy tính	\N		\N	\N	\N	830	\N
499	mẹ	\N		\N	\N	\N	920	\N
499	mẹ	\N		\N	\N	\N	1101	\N
440	mình	\N		\N	\N	\N	972	\N
440	mình	\N		\N	\N	\N	1430	\N
440	mình	\N		\N	\N	\N	1542	\N
454	mới	\N		\N	\N	\N	1143	\N
690	mọi người	\N		\N	\N	\N	1036	\N
690	mọi người	\N		\N	\N	\N	1259	\N
690	mọi người	\N		\N	\N	\N	1419	\N
355	món ăn	\N		\N	\N	\N	1095	\N
355	món ăn	\N		\N	\N	\N	1383	\N
382	mua	\N		\N	\N	\N	597	\N
382	mua	\N		\N	\N	\N	1009	\N
382	mua	\N		\N	\N	\N	1167	\N
657	mưa	\N		\N	\N	\N	997	\N
657	mưa	\N		\N	\N	\N	1421	\N
657	mưa	\N		\N	\N	\N	1423	\N
603	mùa đông	\N		\N	\N	\N	981	\N
602	mùa hè	\N		\N	\N	\N	1071	\N
609	mùa xuân	\N		\N	\N	\N	980	\N
223	muốn	\N		\N	\N	\N	1035	\N
223	muốn	\N		\N	\N	\N	1045	\N
223	muốn	\N		\N	\N	\N	1517	\N
201	mượn	\N		\N	\N	\N	1156	\N
201	mượn	\N		\N	\N	\N	1426	\N
598	năm	\N		\N	\N	\N	1060	\N
598	năm	\N		\N	\N	\N	1300	\N
600	năm nay	\N		\N	\N	\N	710	\N
600	năm nay	\N		\N	\N	\N	808	\N
437	nào	\N		\N	\N	\N	1202	\N
437	nào	\N		\N	\N	\N	1592	\N
227	nấu ăn	\N		\N	\N	\N	869	\N
432	này	\N		\N	\N	\N	1120	\N
432	này	\N		\N	\N	\N	1244	\N
432	này	\N		\N	\N	\N	1515	\N
666	nói	\N		\N	\N	\N	604	\N
666	nói	\N		\N	\N	\N	1371	\N
666	nói	\N		\N	\N	\N	1520	\N
672	nói chuyện	\N		\N	\N	\N	1006	\N
672	nói chuyện	\N		\N	\N	\N	1470	\N
714	nổi tiếng	\N		\N	\N	\N	1076	\N
651	nóng	\N		\N	\N	\N	964	\N
651	nóng	\N		\N	\N	\N	1071	\N
158	nước	\N		\N	\N	\N	1202	\N
152	nước ngoài	\N		\N	\N	\N	1060	\N
152	nước ngoài	\N		\N	\N	\N	1086	\N
720	ngày kia	\N		\N	\N	\N	1415	\N
720	ngày kia	\N		\N	\N	\N	1421	\N
614	ngày mai	\N		\N	\N	\N	995	\N
614	ngày mai	\N		\N	\N	\N	1328	\N
265	nghe	\N		\N	\N	\N	1066	\N
265	nghe	\N		\N	\N	\N	1470	\N
284	nghỉ hè	\N		\N	\N	\N	1287	\N
477	ngoài	\N		\N	\N	\N	838	\N
273	ngồi	\N		\N	\N	\N	957	\N
273	ngồi	\N		\N	\N	\N	966	\N
531	người	\N		\N	\N	\N	542	\N
531	người	\N		\N	\N	\N	681	\N
531	người	\N		\N	\N	\N	1582	\N
531	người	\N		\N	\N	\N	503	\N
236	nhà	\N		\N	\N	\N	998	\N
236	nhà	\N		\N	\N	\N	1313	\N
236	nhà	\N		\N	\N	\N	1555	\N
173	nhanh	\N		\N	\N	\N	654	\N
469	nhiều	\N		\N	\N	\N	1460	\N
469	nhiều	\N		\N	\N	\N	1134	\N
469	nhiều	\N		\N	\N	\N	1571	\N
634	nhiều lần	\N		\N	\N	\N	756	\N
634	nhiều lần	\N		\N	\N	\N	1303	\N
455	nhỏ	\N		\N	\N	\N	1080	\N
426	ông	\N		\N	\N	\N	855	\N
408	ông ấy	\N		\N	\N	\N	584	\N
408	ông ấy	\N		\N	\N	\N	1090	\N
242	phòng	\N		\N	\N	\N	930	\N
242	phòng	\N		\N	\N	\N	1070	\N
398	phòng bếp	\N		\N	\N	\N	1070	\N
353	quán ăn	\N		\N	\N	\N	246	\N
218	rau	\N		\N	\N	\N	1132	\N
188	rẽ	\N		\N	\N	\N	942	\N
210	rẻ	\N		\N	\N	\N	1274	\N
210	rẻ	\N		\N	\N	\N	1278	\N
449	rộng	\N		\N	\N	\N	1190	\N
341	rượu	\N		\N	\N	\N	568	\N
341	rượu	\N		\N	\N	\N	752	\N
204	sách	\N		\N	\N	\N	881	\N
204	sách	\N		\N	\N	\N	1248	\N
204	sách	\N		\N	\N	\N	1365	\N
233	sân	\N		\N	\N	\N	838	\N
462	sáng	\N		\N	\N	\N	963	\N
619	sáng	\N		\N	\N	\N	727	\N
619	sáng	\N		\N	\N	\N	728	\N
619	sáng	\N		\N	\N	\N	1212	\N
462	sáng	\N		\N	\N	\N	728	\N
462	sáng	\N		\N	\N	\N	1212	\N
282	sinh viên	\N		\N	\N	\N	635	\N
282	sinh viên	\N		\N	\N	\N	1364	\N
185	sông	\N		\N	\N	\N	840	\N
185	sông	\N		\N	\N	\N	1021	\N
401	sống	\N		\N	\N	\N	583	\N
401	sống	\N		\N	\N	\N	620	\N
164	sứ quán	\N		\N	\N	\N	1399	\N
297	tập	\N		\N	\N	\N	1303	\N
297	tập	\N		\N	\N	\N	1374	\N
359	tiền	\N		\N	\N	\N	971	\N
359	tiền	\N		\N	\N	\N	1148	\N
359	tiền	\N		\N	\N	\N	1268	\N
649	tiếng	\N		\N	\N	\N	825	\N
649	tiếng	\N		\N	\N	\N	1593	\N
649	tiếng	\N		\N	\N	\N	1301	\N
649	tiếng	\N		\N	\N	\N	1367	\N
649	tiếng	\N		\N	\N	\N	933	\N
150	tiếng Anh	\N		\N	\N	\N	742	\N
156	tiếng Nhật	\N		\N	\N	\N	1301	\N
156	tiếng Nhật	\N		\N	\N	\N	1364	\N
156	tiếng Nhật	\N		\N	\N	\N	1523	\N
154	tiếng Pháp	\N		\N	\N	\N	1467	\N
154	tiếng Pháp	\N		\N	\N	\N	1471	\N
445	to	\N		\N	\N	\N	561	\N
445	to	\N		\N	\N	\N	996	\N
445	to	\N		\N	\N	\N	1520	\N
417	tôi	\N		\N	\N	\N	1167	\N
417	tôi	\N		\N	\N	\N	1347	\N
417	tôi	\N		\N	\N	\N	1387	\N
417	tôi	\N		\N	\N	\N	1483	\N
470	tối	\N		\N	\N	\N	1056	\N
470	tối	\N		\N	\N	\N	1257	\N
617	tối qua	\N		\N	\N	\N	729	\N
617	tối qua	\N		\N	\N	\N	1056	\N
461	tốt	\N		\N	\N	\N	558	\N
461	tốt	\N		\N	\N	\N	969	\N
461	tốt	\N		\N	\N	\N	1526	\N
376	trả	\N		\N	\N	\N	1030	\N
200	từ điển	\N		\N	\N	\N	666	\N
200	từ điển	\N		\N	\N	\N	1350	\N
243	tủ lạnh	\N		\N	\N	\N	836	\N
595	tuần	\N		\N	\N	\N	1287	\N
595	tuần	\N		\N	\N	\N	1330	\N
586	tuần này	\N		\N	\N	\N	748	\N
586	tuần này	\N		\N	\N	\N	1563	\N
590	tuần sau	\N		\N	\N	\N	1287	\N
590	tuần sau	\N		\N	\N	\N	1486	\N
596	tuần trước	\N		\N	\N	\N	1041	\N
596	tuần trước	\N		\N	\N	\N	1466	\N
393	túi	\N		\N	\N	\N	1268	\N
656	tuyết	\N		\N	\N	\N	1056	\N
656	tuyết	\N		\N	\N	\N	991	\N
339	uống	\N		\N	\N	\N	858	\N
339	uống	\N		\N	\N	\N	1045	\N
339	uống	\N		\N	\N	\N	1374	\N
180	xe đạp	\N		\N	\N	\N	558	\N
187	xe ô tô	\N		\N	\N	\N	743	\N
187	xe ô tô	\N		\N	\N	\N	1333	\N
392	xin ...	\N		\N	\N	\N	925	\N
392	xin ...	\N		\N	\N	\N	949	\N
392	xin ...	\N		\N	\N	\N	958	\N
366	xin lỗi	\N		\N	\N	\N	1235	\N
366	xin lỗi	\N		\N	\N	\N	1506	\N
366	xin lỗi	\N		\N	\N	\N	1560	\N
314	xuống	\N		\N	\N	\N	1136	\N
364	vâng	\N		\N	\N	\N	1447	\N
364	vâng	\N		\N	\N	\N	1458	\N
364	vâng	\N		\N	\N	\N	1481	\N
313	vé	\N		\N	\N	\N	878	\N
313	vé	\N		\N	\N	\N	1306	\N
238	về	\N		\N	\N	\N	1010	\N
238	về	\N		\N	\N	\N	1253	\N
238	về	\N		\N	\N	\N	1543	\N
667	viết	\N		\N	\N	\N	663	\N
667	viết	\N		\N	\N	\N	1040	\N
667	viết	\N		\N	\N	\N	1303	\N
288	vở	\N		\N	\N	\N	1426	\N
498	vợ	\N		\N	\N	\N	1122	\N
626	vừa ... vừa ... 	\N		\N	\N	\N	1066	\N
626	vừa ... vừa ... 	\N		\N	\N	\N	1067	\N
711	vừa	\N		\N	\N	\N	881	\N
711	vừa	\N		\N	\N	\N	1024	\N
458	vui	\N		\N	\N	\N	253	\N
458	vui	\N		\N	\N	\N	425	\N
458	vui	\N		\N	\N	\N	1591	\N
458	vui	\N		\N	\N	\N	1336	\N
300	trả lời	\N		\N	\N	\N	1119	\N
691	trắng	\N		\N	\N	\N	550	\N
646	tranh	\N		\N	\N	\N	281	\N
646	tranh	\N		\N	\N	\N	684	\N
448	trẻ	\N		\N	\N	\N	1118	\N
486	trên	\N		\N	\N	\N	835	\N
486	trên	\N		\N	\N	\N	941	\N
707	trở nên	\N		\N	\N	\N	1074	\N
707	trở nên	\N		\N	\N	\N	1078	\N
707	trở nên	\N		\N	\N	\N	1079	\N
706	trở thành	\N		\N	\N	\N	1442	\N
706	trở thành	\N		\N	\N	\N	1076	\N
706	trở thành	\N		\N	\N	\N	1077	\N
476	trong	\N		\N	\N	\N	938	\N
476	trong	\N		\N	\N	\N	939	\N
476	trong	\N		\N	\N	\N	1383	\N
287	trường đại học	\N		\N	\N	\N	745	\N
287	trường đại học	\N		\N	\N	\N	1231	\N
287	trường đại học	\N		\N	\N	\N	1588	\N
571	tháng này	\N		\N	\N	\N	805	\N
571	tháng này	\N		\N	\N	\N	806	\N
578	tháng sau	\N		\N	\N	\N	1027	\N
285	thầy giáo	\N		\N	\N	\N	1030	\N
285	thầy giáo	\N		\N	\N	\N	1221	\N
285	thầy giáo	\N		\N	\N	\N	1362	\N
441	thế	\N		\N	\N	\N	932	\N
441	thế	\N		\N	\N	\N	1165	\N
441	thế	\N		\N	\N	\N	1274	\N
441	thế	\N		\N	\N	\N	1304	\N
438	thế nào	\N		\N	\N	\N	995	\N
438	thế nào	\N		\N	\N	\N	1367	\N
438	thế nào	\N		\N	\N	\N	1411	\N
438	thế nào	\N		\N	\N	\N	1469	\N
438	thế nào	\N		\N	\N	\N	1580	\N
439	thế này	\N		\N	\N	\N	1108	\N
439	thế này	\N		\N	\N	\N	1522	\N
175	thể thao	\N		\N	\N	\N	1392	\N
175	thể thao	\N		\N	\N	\N	1393	\N
717	thế thì	\N		\N	\N	\N	1274	\N
717	thế thì	\N		\N	\N	\N	1344	\N
717	thế thì	\N		\N	\N	\N	1438	\N
717	thế thì	\N		\N	\N	\N	1273	\N
717	thế thì	\N		\N	\N	\N	1315	\N
294	thi	\N		\N	\N	\N	1117	\N
294	thi	\N		\N	\N	\N	1523	\N
294	thi	\N		\N	\N	\N	1528	\N
648	thích	\N		\N	\N	\N	591	\N
648	thích	\N		\N	\N	\N	1387	\N
648	thích	\N		\N	\N	\N	1394	\N
648	thích	\N		\N	\N	\N	1376	\N
648	thích	\N		\N	\N	\N	1379	\N
648	thích	\N		\N	\N	\N	1385	\N
659	thời tiết	\N		\N	\N	\N	995	\N
659	thời tiết	\N		\N	\N	\N	1075	\N
374	thư	\N		\N	\N	\N	576	\N
374	thư	\N		\N	\N	\N	892	\N
374	thư	\N		\N	\N	\N	1154	\N
594	thứ bảy	\N		\N	\N	\N	1388	\N
594	thứ bảy	\N		\N	\N	\N	1531	\N
594	thứ bảy	\N		\N	\N	\N	1536	\N
597	thứ sáu	\N		\N	\N	\N	1486	\N
593	thứ tư	\N		\N	\N	\N	699	\N
593	thứ tư	\N		\N	\N	\N	803	\N
199	thư viện	\N		\N	\N	\N	740	\N
199	thư viện	\N		\N	\N	\N	1156	\N
306	thuốc	\N		\N	\N	\N	752	\N
306	thuốc	\N		\N	\N	\N	1103	\N
640	thuốc lá	\N		\N	\N	\N	225	\N
319	đi	\N		\N	\N	\N	1418	\N
319	đi	\N		\N	\N	\N	599	\N
319	đi	\N		\N	\N	\N	606	\N
299	bài	\N		\N	\N	\N	928	\N
299	bài	\N		\N	\N	\N	1120	\N
644	chơi	\N		\N	\N	\N	853	\N
644	chơi	\N		\N	\N	\N	1536	\N
644	chơi	\N		\N	\N	\N	1549	\N
319	đi	\N		\N	\N	\N	950	\N
319	đi	\N		\N	\N	\N	1536	\N
367	mời ...	\N		\N	\N	\N	948	\N
367	mời ...	\N		\N	\N	\N	957	\N
367	mời ...	\N		\N	\N	\N	1549	\N
641	phim	\N		\N	\N	\N	1451	\N
641	phim	\N		\N	\N	\N	1138	\N
641	phim	\N		\N	\N	\N	1390	\N
303		\N		\N	\N	\N	1598	\N
252		\N		\N	\N	\N	1599	\N
503		\N		\N	\N	\N	1600	\N
533		\N		\N	\N	\N	1601	\N
330		\N		\N	\N	\N	1602	\N
425		\N		\N	\N	\N	1603	\N
381		\N		\N	\N	\N	1605	\N
632		\N		\N	\N	\N	1607	\N
336		\N		\N	\N	\N	1608	\N
684		\N		\N	\N	\N	1610	\N
402		\N		\N	\N	\N	1611	\N
211		\N		\N	\N	\N	1613	\N
387		\N		\N	\N	\N	1614	\N
406		\N		\N	\N	\N	1615	\N
400		\N		\N	\N	\N	1616	\N
343		\N		\N	\N	\N	1617	\N
442		\N		\N	\N	\N	1618	\N
522		\N		\N	\N	\N	1619	\N
228		\N		\N	\N	\N	1620	\N
348		\N		\N	\N	\N	1621	\N
484		\N		\N	\N	\N	1622	\N
679		\N		\N	\N	\N	1623	\N
184		\N		\N	\N	\N	1626	\N
385		\N		\N	\N	\N	1627	\N
157		\N		\N	\N	\N	1628	\N
540		\N		\N	\N	\N	1629	\N
424		\N		\N	\N	\N	1630	\N
424		\N		\N	\N	\N	1631	\N
489		\N		\N	\N	\N	1633	\N
493		\N		\N	\N	\N	1634	\N
183		\N		\N	\N	\N	1635	\N
389		\N		\N	\N	\N	1636	\N
391		\N		\N	\N	\N	1637	\N
515		\N		\N	\N	\N	1638	\N
395		\N		\N	\N	\N	1639	\N
190		\N		\N	\N	\N	1640	\N
645		\N		\N	\N	\N	1641	\N
645		\N		\N	\N	\N	1642	\N
709		\N		\N	\N	\N	1643	\N
528		\N		\N	\N	\N	1644	\N
427		\N		\N	\N	\N	1645	\N
494		\N		\N	\N	\N	1646	\N
495		\N		\N	\N	\N	1647	\N
473		\N		\N	\N	\N	1648	\N
256		\N		\N	\N	\N	1649	\N
205		\N		\N	\N	\N	1650	\N
546		\N		\N	\N	\N	1651	\N
350		\N		\N	\N	\N	1652	\N
554		\N		\N	\N	\N	1653	\N
174		\N		\N	\N	\N	1654	\N
305		\N		\N	\N	\N	1655	\N
541		\N		\N	\N	\N	1656	\N
172		\N		\N	\N	\N	1657	\N
548		\N		\N	\N	\N	1658	\N
552		\N		\N	\N	\N	1659	\N
552		\N		\N	\N	\N	1660	\N
544		\N		\N	\N	\N	1661	\N
544		\N		\N	\N	\N	1662	\N
647		\N		\N	\N	\N	1663	\N
539		\N		\N	\N	\N	1664	\N
612		\N		\N	\N	\N	1665	\N
396		\N		\N	\N	\N	1666	\N
568		\N		\N	\N	\N	1667	\N
557		\N		\N	\N	\N	1668	\N
567		\N		\N	\N	\N	1669	\N
371		\N		\N	\N	\N	1670	\N
219		\N		\N	\N	\N	1671	\N
328		\N		\N	\N	\N	1673	\N
358		\N		\N	\N	\N	1674	\N
628		\N		\N	\N	\N	1675	\N
189		\N		\N	\N	\N	1676	\N
416		\N		\N	\N	\N	1677	\N
414		\N		\N	\N	\N	1678	\N
415		\N		\N	\N	\N	1679	\N
413		\N		\N	\N	\N	1680	\N
405		\N		\N	\N	\N	1681	\N
530		\N		\N	\N	\N	1682	\N
673		\N		\N	\N	\N	1683	\N
423		\N		\N	\N	\N	1684	\N
315		\N		\N	\N	\N	1685	\N
405		\N		\N	\N	\N	1686	\N
351		\N		\N	\N	\N	1687	\N
505		\N		\N	\N	\N	1688	\N
467		\N		\N	\N	\N	1689	\N
507		\N		\N	\N	\N	1690	\N
490		\N		\N	\N	\N	1691	\N
226		\N		\N	\N	\N	1692	\N
507		\N		\N	\N	\N	1693	\N
479		\N		\N	\N	\N	1694	\N
481		\N		\N	\N	\N	1695	\N
688		\N		\N	\N	\N	1696	\N
429		\N		\N	\N	\N	1697	\N
429		\N		\N	\N	\N	1698	\N
662		\N		\N	\N	\N	1699	\N
662		\N		\N	\N	\N	1700	\N
516		\N		\N	\N	\N	1701	\N
192		\N		\N	\N	\N	1702	\N
687		\N		\N	\N	\N	1703	\N
254		\N		\N	\N	\N	1704	\N
402		\N		\N	\N	\N	1705	\N
403		\N		\N	\N	\N	1706	\N
208		\N		\N	\N	\N	1707	\N
211		\N		\N	\N	\N	1708	\N
722		\N		\N	\N	\N	1709	\N
230		\N		\N	\N	\N	1710	\N
686		\N		\N	\N	\N	1711	\N
290		\N		\N	\N	\N	1712	\N
290		\N		\N	\N	\N	1713	\N
259		\N		\N	\N	\N	1714	\N
642		\N		\N	\N	\N	1715	\N
311		\N		\N	\N	\N	1716	\N
480		\N		\N	\N	\N	1717	\N
327		\N		\N	\N	\N	1718	\N
520		\N		\N	\N	\N	1719	\N
262		\N		\N	\N	\N	1720	\N
316		\N		\N	\N	\N	1721	\N
316		\N		\N	\N	\N	1722	\N
340		\N		\N	\N	\N	1723	\N
182		\N		\N	\N	\N	1724	\N
332		\N		\N	\N	\N	1725	\N
491		\N		\N	\N	\N	1726	\N
637		\N		\N	\N	\N	1727	\N
241		\N		\N	\N	\N	1728	\N
176		\N		\N	\N	\N	1729	\N
244		\N		\N	\N	\N	1730	\N
229		\N		\N	\N	\N	1731	\N
384		\N		\N	\N	\N	1732	\N
705		\N		\N	\N	\N	1733	\N
661		\N		\N	\N	\N	1734	\N
246		\N		\N	\N	\N	1735	\N
601		\N		\N	\N	\N	1736	\N
587		\N		\N	\N	\N	1737	\N
379		\N		\N	\N	\N	1738	\N
633		\N		\N	\N	\N	1739	\N
443		\N		\N	\N	\N	1740	\N
676		\N		\N	\N	\N	1741	\N
217		\N		\N	\N	\N	1742	\N
281		\N		\N	\N	\N	1743	\N
624		\N		\N	\N	\N	1744	\N
370		\N		\N	\N	\N	1745	\N
677		\N		\N	\N	\N	1746	\N
674		\N		\N	\N	\N	1747	\N
239		\N		\N	\N	\N	1748	\N
170		\N		\N	\N	\N	1749	\N
543		\N		\N	\N	\N	1750	\N
521		\N		\N	\N	\N	1751	\N
349		\N		\N	\N	\N	1752	\N
559		\N		\N	\N	\N	1753	\N
556		\N		\N	\N	\N	1754	\N
669		\N		\N	\N	\N	1755	\N
368		\N		\N	\N	\N	1756	\N
361		\N		\N	\N	\N	1758	\N
446		\N		\N	\N	\N	1759	\N
283		\N		\N	\N	\N	1760	\N
295		\N		\N	\N	\N	1761	\N
518		\N		\N	\N	\N	1762	\N
518		\N		\N	\N	\N	1763	\N
518		\N		\N	\N	\N	1764	\N
653		\N		\N	\N	\N	1765	\N
532		\N		\N	\N	\N	1766	\N
696		\N		\N	\N	\N	1767	\N
555		\N		\N	\N	\N	1768	\N
555		\N		\N	\N	\N	1769	\N
560		\N		\N	\N	\N	1770	\N
248		\N		\N	\N	\N	1771	\N
529		\N		\N	\N	\N	1772	\N
323		\N		\N	\N	\N	1773	\N
444		\N		\N	\N	\N	1774	\N
420		\N		\N	\N	\N	1775	\N
585		\N		\N	\N	\N	1776	\N
383		\N		\N	\N	\N	1777	\N
657		\N		\N	\N	\N	1778	\N
599		\N		\N	\N	\N	1779	\N
535		\N		\N	\N	\N	1780	\N
551		\N		\N	\N	\N	1781	\N
611		\N		\N	\N	\N	1782	\N
604		\N		\N	\N	\N	1783	\N
606		\N		\N	\N	\N	1784	\N
610		\N		\N	\N	\N	1785	\N
452		\N		\N	\N	\N	1786	\N
459		\N		\N	\N	\N	1787	\N
693		\N		\N	\N	\N	1788	\N
181		\N		\N	\N	\N	1789	\N
360		\N		\N	\N	\N	1790	\N
267		\N		\N	\N	\N	1791	\N
623		\N		\N	\N	\N	1792	\N
160		\N		\N	\N	\N	1793	\N
284		\N		\N	\N	\N	1794	\N
342		\N		\N	\N	\N	1795	\N
338		\N		\N	\N	\N	1796	\N
678		\N		\N	\N	\N	1797	\N
153		\N		\N	\N	\N	1798	\N
352		\N		\N	\N	\N	1799	\N
324		\N		\N	\N	\N	1800	\N
324		\N		\N	\N	\N	1801	\N
695		\N		\N	\N	\N	1802	\N
450		\N		\N	\N	\N	1803	\N
345		\N		\N	\N	\N	1804	\N
523		\N		\N	\N	\N	1805	\N
496		\N		\N	\N	\N	1806	\N
497		\N		\N	\N	\N	1807	\N
270		\N		\N	\N	\N	1808	\N
482		\N		\N	\N	\N	1809	\N
478		\N		\N	\N	\N	1810	\N
485		\N		\N	\N	\N	1811	\N
483		\N		\N	\N	\N	1812	\N
641		\N		\N	\N	\N	1813	\N
346		\N		\N	\N	\N	1814	\N
206		\N		\N	\N	\N	1815	\N
206		\N		\N	\N	\N	1816	\N
373		\N		\N	\N	\N	1817	\N
683		\N		\N	\N	\N	1818	\N
390		\N		\N	\N	\N	1819	\N
329		\N		\N	\N	\N	1820	\N
247		\N		\N	\N	\N	1821	\N
302		\N		\N	\N	\N	1822	\N
165		\N		\N	\N	\N	1823	\N
245		\N		\N	\N	\N	1824	\N
462		\N		\N	\N	\N	1825	\N
636		\N		\N	\N	\N	1826	\N
268		\N		\N	\N	\N	1827	\N
268		\N		\N	\N	\N	1828	\N
331		\N		\N	\N	\N	1829	\N
629		\N		\N	\N	\N	1830	\N
572		\N		\N	\N	\N	1831	\N
186		\N		\N	\N	\N	1832	\N
333		\N		\N	\N	\N	1833	\N
537		\N		\N	\N	\N	1834	\N
404		\N		\N	\N	\N	1835	\N
386		\N		\N	\N	\N	1836	\N
207		\N		\N	\N	\N	1837	\N
558		\N		\N	\N	\N	1838	\N
326		\N		\N	\N	\N	1839	\N
318		\N		\N	\N	\N	1840	\N
534		\N		\N	\N	\N	1841	\N
378		\N		\N	\N	\N	1842	\N
698		\N		\N	\N	\N	1843	\N
713		\N		\N	\N	\N	1844	\N
580		\N		\N	\N	\N	1845	\N
576		\N		\N	\N	\N	1846	\N
584		\N		\N	\N	\N	1847	\N
574		\N		\N	\N	\N	1848	\N
312		\N		\N	\N	\N	1849	\N
575		\N		\N	\N	\N	1850	\N
583		\N		\N	\N	\N	1851	\N
573		\N		\N	\N	\N	1852	\N
582		\N		\N	\N	\N	1853	\N
579		\N		\N	\N	\N	1854	\N
577		\N		\N	\N	\N	1855	\N
569		\N		\N	\N	\N	1856	\N
581		\N		\N	\N	\N	1857	\N
570		\N		\N	\N	\N	1858	\N
460		\N		\N	\N	\N	1859	\N
708		\N		\N	\N	\N	1860	\N
716		\N		\N	\N	\N	1861	\N
553		\N		\N	\N	\N	1862	\N
344		\N		\N	\N	\N	1863	\N
222		\N		\N	\N	\N	1864	\N
209		\N		\N	\N	\N	1865	\N
221		\N		\N	\N	\N	1866	\N
220		\N		\N	\N	\N	1867	\N
635		\N		\N	\N	\N	1868	\N
592		\N		\N	\N	\N	1869	\N
591		\N		\N	\N	\N	1870	\N
589		\N		\N	\N	\N	1871	\N
465		\N		\N	\N	\N	1872	\N
356		\N		\N	\N	\N	1873	\N
703		\N		\N	\N	\N	1874	\N
723		\N		\N	\N	\N	1875	\N
253		\N		\N	\N	\N	1876	\N
380		\N		\N	\N	\N	1877	\N
397		\N		\N	\N	\N	1878	\N
470		\N		\N	\N	\N	1879	\N
369		\N		\N	\N	\N	1880	\N
249		\N		\N	\N	\N	1881	\N
334		\N		\N	\N	\N	1882	\N
335		\N		\N	\N	\N	1883	\N
334		\N		\N	\N	\N	1884	\N
271		\N		\N	\N	\N	1885	\N
681		\N		\N	\N	\N	1886	\N
517		\N		\N	\N	\N	1887	\N
650		\N		\N	\N	\N	1888	\N
547		\N		\N	\N	\N	1889	\N
269		\N		\N	\N	\N	1890	\N
279		\N		\N	\N	\N	1891	\N
671		\N		\N	\N	\N	1892	\N
393		\N		\N	\N	\N	1893	\N
354		\N		\N	\N	\N	1894	\N
699		\N		\N	\N	\N	1895	\N
388		\N		\N	\N	\N	1896	\N
525		\N		\N	\N	\N	1897	\N
196		\N		\N	\N	\N	1898	\N
514		\N		\N	\N	\N	1899	\N
680		\N		\N	\N	\N	1900	\N
399		\N		\N	\N	\N	1901	\N
451		\N		\N	\N	\N	1902	\N
692		\N		\N	\N	\N	1903	\N
702		\N		\N	\N	\N	1904	\N
468		\N		\N	\N	\N	1905	\N
179		\N		\N	\N	\N	1906	\N
550		\N		\N	\N	\N	1907	\N
675		\N		\N	\N	\N	1908	\N
471		\N		\N	\N	\N	1909	\N
463		\N		\N	\N	\N	1910	\N
225		\N		\N	\N	\N	1911	\N
254		\N		\N	\N	\N	1912	\N
260		\N		\N	\N	\N	1913	\N
372		\N		\N	\N	\N	1914	\N
442		\N		\N	\N	\N	1915	\N
552		\N		\N	\N	\N	1916	\N
552		\N		\N	\N	\N	1917	\N
650		\N		\N	\N	\N	1918	\N
539		\N		\N	\N	\N	1919	\N
403		\N		\N	\N	\N	1920	\N
505		\N		\N	\N	\N	1921	\N
425		\N		\N	\N	\N	1922	\N
230		\N		\N	\N	\N	1923	\N
231		\N		\N	\N	\N	1924	\N
229		\N		\N	\N	\N	1925	\N
654		\N		\N	\N	\N	1926	\N
269		\N		\N	\N	\N	1927	\N
263		\N		\N	\N	\N	1928	\N
421	ai	\N		\N	\N	\N	1931	\N
421	ai	\N		\N	\N	\N	1932	\N
421	ai	\N		\N	\N	\N	1933	\N
421	ai	\N		\N	\N	\N	1934	\N
475	bên cạnh	\N		\N	\N	\N	1935	\N
475	bên cạnh	\N		\N	\N	\N	1936	\N
475	bên cạnh	\N		\N	\N	\N	1937	\N
475	bên cạnh	\N		\N	\N	\N	1938	\N
499		\N		\N	\N	\N	1939	\N
498		\N		\N	\N	\N	1940	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: vi
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

