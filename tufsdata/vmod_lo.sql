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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO lo;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO lo;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO lo;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: lo
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


ALTER TABLE public.t_instance OWNER TO lo;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO lo;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO lo;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: lo
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


ALTER TABLE public.t_usage_classified_rel OWNER TO lo;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: lo
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


ALTER TABLE public.t_usage_inst_rel OWNER TO lo;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO lo;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO lo;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: lo
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO lo;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: lo
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


ALTER TABLE public.t_word_inst_rel OWNER TO lo;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: lo
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO lo;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: lo
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO lo;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: lo
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_index_char (id, index_char) FROM stdin;
1	ກ
2	ຂ
3	ຄ
4	ງ
5	ຈ
7	ຊ
8	ຍ
9	ດ
10	ຕ
11	ຖ
12	ທ
13	ນ
14	ບ
15	ປ
16	ຜ
17	ຝ
18	ພ
19	ຟ
20	ມ
21	ຢ
22	ລ
23	ວ
6	ສ
24	ຫ
31	ຫຼ
27	ຫງ
28	ຫຍ
32	ຫວ
25	ອ
26	ຮ
29	ໜ
30	ໝ
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
1489	ຮູບແຕ້ມນີ້ຂອງໃຜ?	この絵は誰のもの？	\N		\N	vmod	\N	\N	\N	0	1
1533	ມີເງິນກີບບໍ?	キープ（ラオスの通貨）持ってますか？	\N		\N	vmod	\N	\N	\N	0	1
16	ເຜັດໜ້ອຍໜຶ່ງ ແຕ່ແຊບຫຼາຍ	少し辛かったけれど、とてもおいしかったわ。	程度について述べる		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
17	ເອີ້, ໃຄແດ່.	ああ、よかった。			\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
18	ມື້ໜ້າຂ້ອຍຊິພາເຈົ້າໄປກິນອາຫານຍີ່ປຸ່ນເດີ.	今度は私が日本料理を食べに連れて行きますね。	提案する		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
19	ບຸນພັນ, ມານີ້ ! ມານີ້ !	ブンパンさん、来て、来て！	注意をひく		\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
20	ຢູ່ທົ່ງນາ, ນັ້ນແມ່ນຄວາຍບໍ?	田んぼにいるのは水牛ですか？			\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
21	ແມ່ນແລ້ວ.	そのとおりです。			\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
22	ຄວາຍຊ່ອຍໄຖນາໄດ໋.	水牛は田んぼを耕すのを手伝ってくれるのですよ。			\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
23	ຢູ່ລາວບໍ່ມີລົດໄຖບໍ?	ラオスには耕耘機がないのですか？	状況についてたずねる		\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
24	ມີຢູ່.	ありますよ。			\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
25	ແຕ່ຍັງແພງຫຼາຍ.	でもまだとても高いのです。	程度について述べる		\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
30	ຂ້ອຍຊື່ ເອມິ	私はエミです。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
31	ຍິນດີທີ່ໄດ້ຮູ້ຈັກ.	初めまして。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
32	ຍິນດີທີ່ໄດ້ຮູ້ຈັກຄືກັນ.	こちらこそ。	挨拶する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
33	ເຈົ້າແມ່ນຄົນລາວບໍ່?	ラオス人ですか？	属性についてたずねる		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
34	ບໍ່, ຂ້ອຍແມ່ນຄົນຍີ່ປຸ່ນ.	いいえ、日本人です。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
35	ເປັນນັກສຶກສາມະຫາວິທະຍາໄລການສຶກສາຕ່າງປະເທດແຫ່ງໂຕກຽວ	東京外国語大学の学生です。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
36	ຂ້ອຍມາຮຽນພາສາລາວຢູ່ດົງໂດກ	ラオス語を勉強しにドンドークに来ました。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
37	ຂ້ອຍກໍຮຽນຢູ່ດົງໂດກຄືກັນ.	私もドンドークで学んでいます。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
38	ຢູ່ຄະນະນິຕິສາດ ປີ 3	政治学部の３年生です。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
39	ຂໍໂທດຫຼາຍໆທີ່ມາຊ້າ	遅くなって本当にごめんなさい。	謝る		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
40	ຖ້າດົນບໍ່?	待ちましたか？	程度についてたずねる		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
41	ບໍ່, ບໍ່ດົນປານໃດ.	いいえ、そんなに待ってないですよ。	程度について述べる		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
42	ຂ້ອຍຫາກໍມາຄືກັນ.	私もさっき来たところです。			\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
43	ແມ່ນບໍ?	そうですか？			\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
44	ມາຮອດຈັກໂມງ?	何時に来たんですか？	時間についてたずねる		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
45	ປະມານ 6 ໂມງເຄິ່ງ	６時半ごろです。	時間について述べる		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
46	ຂໍໂທດເດີ	すみません。	謝る		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
47	ບໍ່ເປັນຫຍັງດອກ.	気にしないでください。	謝る		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
48	ຄັນຊັ້ນໄປເລີຍເນາະ.	それじゃあ行きましょうか。	提案する		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
49	ລະຄອນໃກ້ຊິເລີ່ມແລ້ວ	もうすぐ劇が始まってしまいますよ。	予定を述べる		\N	dmod	lo05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
50	ວັນອາທິດນີ້ແມ່ນວັນເກີດຂອງຄຳດີ	今週の日曜日はカムディーさんの誕生日ですね。	予定を述べる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
51	ເຈົ້າຊິເອົາຫຍັງໃຫ້?	何をあげるつもりですか？	人にものをあげる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
52	ຂ້ອຍຊິຊື້ວັດຈະນານຸກົມພາສາຍີ່ປຸ່ນໃຫ້ລາວ	日本語の辞書を買ってあげようと思っています。	人にものをあげる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
53	ແຕ່ລາຄາແພງຫຼາຍ.	でも値段が高くてね。	程度について述べる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
54	ເອົ້າ !	えっ！			\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
55	ລາວມີຫົວໜຶ່ງແລ້ວ, ບໍ່ແມ່ນບໍ?	彼は一冊持ってませんでしたか？	状況についてたずねる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
56	ແມ່ນແລ້ວ.	そうなんですけど。			\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
57	ໄດ້ຍິນວ່າລາວຊິເອົາໃຫ້ນ້ອງສາວ	妹にあげるって聞きましたよ。	人にものをあげる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
58	ຄັນຊັ້ນຊື້ນຳກັນໃຫ້ລາວເນາະ !	それじゃあ一緒に買ってあげましょう。	人にものをあげる		\N	dmod	lo06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
59	ມື້ຮື ຂ້ອຍຊິກັບຍີ່ປຸ່ນ.	明後日、私は日本に帰ります。	予定を述べる		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
60	ຂອບໃຈຫຼາຍໆເດີ ສຳລັບທຸກສິ່ງທຸກຢ່າງ.	いろいろどうもありがとうございました。	感謝する		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
61	ກັບເມືອຍີ່ປຸ່ນໄວແທ້	日本にもう帰ってしまうんですか。	意見を述べる		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
62	ສອງອາທິດຈັ່ງແມ່ນໄວນໍ	２週間っていうのはあっという間ですね。	意見を述べる		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
63	ໄປຮອດຍີ່ປຸ່ນແລ້ວຂຽນຈົດໝາຍມາຫາຂ້ອຍແດ່ເດີ	日本に着いたら手紙を書いて下さいね。	依頼する		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
64	ເຈົ້າ, ແນ່ນອນ	はい、もちろんです。			\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
65	ໂຊກດີເດີ.	さようなら。	さよならを言う		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
66	ພົບກັນໃໝ່	また会いましょう。	さよならを言う		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
67	ເຈົ້າ, ພົບກັນໃໝ່.	はい、また会いましょう。	さよならを言う		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
68	ໂຊກດີ.	さようなら。	さよならを言う		\N	dmod	lo07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
69	ສະບາຍດີ.	いらっしゃいませ。	挨拶する		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
70	ຢາກໄດ້ຫຍັງນໍ?	何になさいますか？			\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
71	ຂໍເບິ່ງເສື້ອໂຕນັ້ນແດ່	あのシャツを見せてください。	依頼する		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
72	ໂຕນີ້ລາຄາເທົ່າໃດ?	これはいくらですか？	金額についてたずねる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
73	40,000 ກີບ	４万キープです。	金額について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
74	ແພງແທ້ !	とても高いですね！	程度について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
75	ຫຼຸດໄດ້ບໍ່?	まけてくれますか？	金額についてたずねる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
76	ຊິຫຼຸດໃຫ້ 5,000 ກີບ.	５千キープおまけしましょう。	金額について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
77	ຍັງແພງຢູ່.	まだ高いなぁ。	程度について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
78	ຖ້າຊື້ 2 ໂຕ, ໂຕລະ 30,000 ກີບໄດ້ບໍ່?	２着買ったら、１着３万キープにしてくれますか？	条件をつける		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
79	ບໍ່ໄດ້. 	できません。			\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
80	ຂາດທຶນ.	赤字になっちゃいますよ。	金額について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
81	2 ໂຕ 65,000 ກີບຊະ.	２着６万５千キープにしましょう。	金額について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
82	ຕໍ່ເກັ່ງເນາະ	値切るのが上手ですねえ！	金額について述べる		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	1
83	ເທື່ອໜ້າຊື້ຊ່ອຍອີກແດ່ເດີ.	またいらしてくださいね。	依頼する		\N	dmod	lo08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[5]	\N	\N	1
84	ສະບາຍດີ.	こんばんは。	挨拶する		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
85	ມີຈັກຄົນນໍ?	何名様ですか？	数字についてたずねる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
86	2 ຄົນ	２名です。	数字について述べる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
87	ຈອງໄວ້ແລ້ວ	もう予約してあります。			\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
88	ເຈົ້າ.	かしこまりました。			\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
89	ເຊີນທາງພີ້	こちらへどうぞ。			\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
90	ຮ້ານນີ້ບັນຍາກາດດີນໍ	この店は雰囲気がいいですね。	意見を述べる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
91	ເອມິເຄີຍມາແລ້ວບໍ່?	エミさんはここに来たことがあるのですか？	経験についてたずねる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
163	ກໍເປັນຢູ່ .​..	できるけど・・・。	能力について述べる		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
92	ເຈົ້າ, ເຄີຍມາເທື່ອໜຶ່ງແລ້ວ	ええ、一度来たことがあります。	経験について述べる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
93	ບຸນມີເດ?	ブンミーさんは？			\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
94	ບໍ່ເຄີຍ.	ないです。	経験についてたずねる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
95	ມື້ນີ້ແມ່ນເທື່ອທຳອິດ.	今日が初めてです。			\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
96	ເອົາອັນໃດດີນໍ?	何を注文したらいいでしょうか？	意見をたずねる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
97	ອັນໃດກໍໄດ້	どれでもいいですよ。			\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
98	ຮ້ານນີ້ອັນໃດກໍແຊບ	この店は何でもおいしいですから。	意見を述べる		\N	dmod	lo09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
99	ອາໂຫຼ.	もしもし。			\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
100	ອາໂຫຼ. ແສງບໍ?	もしもし、セーンさん？			\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
101	ເຈົ້າ.	はい。			\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
102	ກຳລັງເວົ້າ.	セーンです。			\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
103	ມີວຽກຫຍັງບໍ່?	どうしたの？	状況についてたずねる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
104	ອັນນາ, ມື້ແລງນີ້ ມີເວລາຫວ່າງບໍ່?	えーっと、今晩、時間空いてる？	予定をたずねる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
105	ມີ, ມື້ນີ້ບໍ່ມີຫຍັງ.	ええ、今日は何もないけれど。	予定を述べる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
106	ມີຫຍັງບໍ?	何かあるの？	予定をたずねる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
107	ມື້ແລງນີ້ ຂ້ອຍຊິໄປກິນດອງໝູ່.	今晩友達の結婚式に行くんだ。	予定を述べる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
108	ຂ້ອຍຢາກຊວນແສງໄປນຳ. 	誘ってみようかと思って。	希望を述べる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
109	ໄປບໍ່?	行く？	意見をたずねる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
111	ຕອນແລງ ບໍ່ມີລົດໄດ໋	今夜は車がないの。			\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
112	ບໍ່ເປັນຫຍັງ.	大丈夫。			\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
113	ຂ້ອຍຊິໄປຮັບແສງຢູ່ບ້ານ.	僕が家まで迎えに行くよ。	予定を述べる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
114	ເອມິເຮັດຫຍັງຢູ່?	エミさん、何してるの？	状況についてたずねる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
115	ອ່ານໜັງສືພິມລາວຢູ່.	ラオスの新聞を読んでるの。	状況について述べる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
116	ອ່ານເຂົ້າໃຈບໍ?	わかるの？	状況についてたずねる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
117	ຖ້າໃຊ້ວັດຈະນານຸກົມກໍພໍເຂົ້າໃຈ	辞書を使えば大体わかる。	条件をつける		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
118	ແຕ່ຖ້າບໍ່ໃຊ້, ກໍບໍ່ເຂົ້າໃຈປານໃດ.	でも辞書がないとあまりわからないの。	条件をつける		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
119	ຂ້ອຍກໍຢາກໄດ້ວັດຈະນານຸກົມພາສາຍີ່ປຸ່ນນາ	僕も日本語の辞書が欲しいなあ。	希望を述べる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
120	ໂອ້, ສົນໃຈພາສາຍີ່ປຸ່ນບໍ?	あら、日本語に興味があるの？	意見をたずねる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
121	ສົນໃຈຫຼາຍ.	すごくあるよ。	意見を述べる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
122	ຮຽນພາສາຍີ່ປຸ່ນຍາກແມ່ນບໍ?	日本語を勉強するのは難しいでしょう？	程度についてたずねる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
123	ບໍ່ຍາກດອກ.	難しくないわ。	程度について述べる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
125	ໄດ້ຍິນວ່າຊິໄປອາເມຣິກາ, ຊິໄປເຮັດວຽກບໍ?	アメリカに行くって聞いたのですが、仕事で行くのですか？	予定をたずねる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
126	ແມ່ນແລ້ວ.	そうです。			\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
127	ມີປະຊຸມຢູ່ນິວຢອກ.	ニューヨークで会議があって。			\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
128	ຊິໄປມື້ໃດ?	いつ行くのですか？	時間についてたずねる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
129	ວັນທີ 15 ເດືອນ 3.	３月１５日です。	時間について述べる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
130	ໄປຈັກມື້?	何日間行きますか？	時間についてたずねる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
131	ປະມານ 3 ອາທິດ.	大体３週間ぐらいです。	時間について述べる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
132	ຖ້າມີເວລາ, ຂ້ອຍຊິໄປຢາມພີ່ນ້ອງຢູ່ຄາລິຟໍເນຍອີກ.	時間があればカリフォルニアにいる親戚を訪ねるつもりです。	予定を述べる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
133	ຈາກນິວຢອກໄປຄາລິຟໍເນຍ ໃຊ້ເວລາດົນປານໃດ?	ニューヨークからカリフォルニアまでどれくらいかかりますか？	時間についてたずねる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
134	ຂີ່ຍົນໄປປະມານ 5 ຊົ່ວໂມງ	飛行機で約５時間です。	時間について述べる		\N	dmod	lo12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
135	ຄອບຄົວບຸນມີ ມີຈັກຄົນ?	ブンミーさんの家族は何人いますか？	数字についてたずねる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
136	ມີພໍ່ເຖົ້າ, ແມ່ເຖົ້າ, ພໍ່ແມ່, ອ້າຍ 2 ຄົນ, ເອື້ອຍຄົນໜຶ່ງ, ນ້ອງສາວຄົນໜຶ່ງ ແລະຂ້ອຍ, ທັງໝົດ 9 ຄົນ	祖父、祖母、両親、兄が２人、姉が１人、妹が１人と僕、全部で９人です。	数字について述べる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
137	ເປັນຄອບຄົວໃຫຍ່ເນາະ	大家族ですね。	意見を述べる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
138	ອ້າຍເອື້ອຍແຕ່ງດອງແລ້ວບໍ່?	お兄さんとお姉さんはもう結婚してるんですか？	状況についてたずねる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
139	ອ້າຍຜູ້ທີໜຶ່ງ ກັບເອື້ອຍແຕ່ງແລ້ວ.	一人目の兄と姉は結婚していますよ。	状況について述べる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
140	ອ້າຍຜູ້ທີສອງຍັງເປັນໂສດຢູ່	二人目の兄はまだ独身なんです。	状況について述べる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
141	ນ້ອງສາວເດ, ອາຍຸຈັກປີແລ້ວ?	妹さんは、何歳ですか？	数字についてたずねる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
142	14 ປີ, ຍັງເປັນນັກຮຽນມັດທະຍົມປີທີ 3	１４歳、まだ中学３年生です。	数字について述べる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
143	ອາຍຸເທົ່າກັນກັບນ້ອງຊາຍຫຼ້າຂ້ອຍນໍ.	私の下の弟と同い年ですね。	比べる		\N	dmod	lo13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
144	ເຊີນເດີ.	どうぞ。			\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
145	ຂອບໃຈ.	ありがとう。	感謝する		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
146	ເຂົ້າໜົມນີ້ແຊບເນາະ	このお菓子おいしいわね。	意見を述べる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
147	ເຮັດດ້ວຍຫຍັງ?	何でできているの？	特徴についてたずねる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
148	ອັນນີ້ແມ່ນ ” ເຂົ້າຕົ້ມຫວານ”, ເຮັດດ້ວຍເຂົ້າໜຽວ, ໝາກກ້ວຍ ແລະນ້ຳກະທິ.	これは「カオトムワーン」といって、もち米とバナナとココナッツミルクでできているんだよ。			\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
149	ຄົນລາວມັກກິນເຂົ້າໜຽວບໍ?	ラオス人はもち米をよく食べるの？	状況についてたずねる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
150	ແນ່ນອນ, ເພາະວ່າເຂົ້າໜຽວແມ່ນອາຫານຫຼັກຂອງຄົນລາວ.	もちろん、もち米はラオス人の主食だからね。	状況について述べる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
151	ກິນແນວໃດ?	どうやって食べるの？	手段についてたずねる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
152	ໜຶ້ງໃສ່ຫວດນີ້ ແລ້ວເອົາໃສ່ໃນຕິບເຂົ້າແບບນັ້ນໄວ້.	この竹ザルで蒸して、ああいう竹のおひつに入れておくんだ。	順序について述べる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
153	ຊິໃຊ້ໄມ້ຖູ່ຫຼືໃຊ້ບ່ວງ?	お箸を使って食べるの？それともスプーン？	手段についてたずねる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
154	ບໍ່ໃຊ້ຫຍັງ ! 	何も使わないよ！			\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
155	ໃຊ້ມືກິນ.	手で食べるんだよ。	状況について述べる		\N	dmod	lo14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
156	ໍວັນເສົານີ້ ໄປທ່ຽວເຂື່ອນນ້ຳງື່ມນຳກັນບໍ່?	今度の土曜日一緒にナムグムダムに行かない？	提案する		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
157	ຂີ່ລົດເມໄປບໍ?	バスで行くの？	手段についてたずねる		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
158	ອ້າຍຂ້ອຍຫາກໍຊື້ລົດໃໝ່, ຂີ່ລົດໃຫຍ່ໄປເນາະ	兄が新しい車を買ったばかりだから、それで行こう。	提案する		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
160	ບຸນມີຂັບລົດເປັນຫວາ?	ブンミーさんは運転できるの？	能力についてたずねる		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
161	ບໍ່, ບໍ່ເປັນ	いや、できないよ。	能力について述べる		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
162	ແຕ່ແສງຂັບເປັນຕົ໋ວະ.	セーンさんはできたよね？	能力についてたずねる		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
164	ແຕ່ບໍ່ໄດ້ຂັບດົນແລ້ວ, ບໍ່ກ້າປານໃດ.	しばらく運転していないから不安だわ。	意見を述べる		\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
165	ຊິເປັນຫຍັງ !	大丈夫だよ！			\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
166	ບໍ່ເປັນຫຍັງດອກ.	平気だよ。			\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
167	ປີໃໝ່ລາວນີ້ ບຸນມີຊິໄປໃສ?	ブンミーさん、今年のラオス正月にはどこに行くの？	場所についてたずねる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
168	ຂ້ອຍຊິໄປຫຼວງພະບາງ	ルアンパバーンに行くつもりだよ。	予定を述べる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
169	ຫຼວງພະບາງຢູ່ໃສ?	ルアンパバーンはどこにあるの？	場所についてたずねる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
170	ພາກເໜືອຂອງລາວ.	ラオスの北部にあるんだよ。	場所について述べる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
171	ບໍ່ເຄີຍໄປບໍ?	行ったことないの？	経験についてたずねる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
172	ບໍ່. 	いいえ。			\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
173	ມີຫຍັງແດ່ຢູ່ຫັ້ນ?	そこには何があるの？	状況についてたずねる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
174	ຢູ່ເມືອງຫຼວງ, ມີຫຼາຍອັນທີ່ເປັນຕາເບິ່ງ	ルアンパバーンには見る所が数多くあるんだよ。	状況について述べる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
175	ມີວັດຫຼາຍ, ມີຖ້ຳຕິ່ງແດ່, ມີຫໍພິພິດທະພັນແດ່, ແລະຫຼາຍໆອັນ.	たくさんのお寺でしょ、ティン洞窟でしょ、博物館でしょ、それから、その他にもいろいろあるよ。	例をあげる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
176	ໜ້າສົນໃຈນໍ !	おもしろそうね！	意見を述べる		\N	dmod	lo16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
177	ປຶ້ມຫົວນີ້ຂອງໃຜ?	この本は誰の？	属性についてたずねる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
178	ຂອງຄຳດີ.	カムディーさんのだよ。	属性について述べる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
179	ຄຳດີແມ່ນໃຜ?	カムディーさんって誰？			\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
180	ລາວເປັນໝູ່ຂ້ອຍ	彼は僕の友達だよ。	属性について述べる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
181	ເອມິກໍເຄີຍພົບກັບລາວແລ້ວ.	エミさんも会ったことがあるでしょ。	経験について述べる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
182	ລາວເປັນນັກຮຽນຄະນະເສດຖະສາດ	経済学部の生徒だよ。	属性について述べる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
185	ເອົ້າ !	えーっ！			\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
186	ຈັ່ງແມ່ນລືມໄວນໍ !	ほんとにすぐ忘れるよね。			\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
187	ລາວເປັນຄົນສູງຈ່ອຍ	彼は背が高くてやせている人です。	特徴について述べる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
188	ໂອ້, ຮູ້ແລ້ວ.	ああ、わかった。			\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
189	ຜູ້ທີ່ມັກເວົ້າຕະຫຼົກແມ່ນບໍ?	ひょうきんな人でしょ？	特徴について述べる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
190	ຂ້ອຍຢາກຮຽນພາສາຕ່າງປະເທດ, ເອມິຄິດວ່າຮຽນພາສາຫຍັງດີ?	外国語を学びたいんだけれども、何語を学んだらいいと思う？	意見をたずねる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
191	ຢູ່ໂຮງຮຽນນີ້ ສອນພາສາຫຍັງແດ່?	この学校には何語の授業があるの？	状況についてたずねる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
192	ມີອັງກິດ, ຝຣັ່ງ, ຈີນ ແລະຍີ່ປຸ່ນ.	英語、フランス語、中国語、それから日本語。	状況について述べる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
193	ເຈົ້າສົນໃຈພາສາໃດ?	どの言語に興味があるの？	意見をたずねる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
194	ພາສາຍີ່ປຸ່ນ.	日本語。			\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
195	ແຕ່ຄົງຈະຍາກຫຼາຍ.	でもきっとすごく難しいよねえ。	程度について述べる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
196	ຂ້ອຍຄິດວ່າ ແລ້ວແຕ່ເຈົ້າເລືອກ.	ブンミーさん次第だと思うわ。	意見を述べる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
197	ຍາກ ຫຼືງ່າຍ, ບໍ່ເປັນບັນຫາ	難易は問題じゃないと思う。	意見を述べる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
198	ເຈົ້າເລືອກພາສາທີ່ເຈົ້າສົນໃຈທີ່ສຸດດີກວ່າ	一番興味のある言語を学ぶのがいいんじゃないかしら。	意見を述べる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
200	ແມ່ນໄດ໋ນໍ.	そうだね。			\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
458	練習３(3)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
201	ບຸນມີມັກກິນເຂົ້າປຽກນໍ.	ほんとにカオピヤックが好きね。	好きなものについて述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
202	ເຫັນແຕ່ກິນເຂົ້າປຽກ.	カオピヤックを食べてるところしか見たことないんだけど。	状況について述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
203	ເປັນຫຍັງ?	なんで？	理由をたずねる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
204	ບໍ່ມັກບໍ?	嫌いなの？	意見をたずねる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
205	ບໍ່ມັກປານໃດ	あまり好きじゃないわ。	好きなものについて述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
206	ເພາະວ່າເຂົາເຈົ້າໃສ່ເລືອດໝູ.	だって、カオピヤックの中に豚の血豆腐を入れるでしょ。	理由を述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
207	ມັນເປັນຕາຢ້ານ.	気持ち悪いじゃない。	意見を述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
208	ແຕ່ວ່າແຊບໄດ໋ !	でもおいしいよ！	意見を述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
209	ກິນແລ້ວຊິຕິດໃຈ.	食べたらやみつきになっちゃうのに。	好きなものについて述べる		\N	dmod	lo19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
210	ເວລາຫວ່າງ, ຄົນລາວມັກເຮັດຫຍັງ?	ラオス人はひまなときは何をしているの？	状況についてたずねる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
211	ສ່ວນຫຼາຍ ຜູ້ຊາຍມັກຫຼິ້ນກິລາ, ຜູ້ຍິງມັກໄປຊື້ເຄື່ອງ.	大体男性はスポーツをして、女性は買い物かな。	好きな行動について述べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
212	ເອມິເດ?	エミさんは？			\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
213	ຂ້ອຍກໍມັກໄປຊື້ເຄື່ອງຄືກັນ.	私も買い物が好きよ。	好きな行動について述べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
214	ຜູ້ຍິງຢູ່ໃສກໍມັກແນວດຽວກັນນໍ.	どこの女性も好きなのは一緒だね。	比べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
215	ຜູ້ຊາຍຍີ່ປຸ່ນເດ, ເປັນແນວໃດ?	日本人の男性は、どう？	状況についてたずねる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
216	ເຂົາເຈົ້າກໍມັກຫຼິ້ນກິລາຄືກັນ	彼らもスポーツが好きよ。	好きな行動について述べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
217	ແຕ່ຜູ້ໃຫຍ່ ສ່ວນຫຼາຍເຂົາເຈົ້າມັກນອນ.	だけど大部分の大人はよく寝ているわ。	好きな行動について述べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
218	ມື້ພັກພໍ່ຂ້ອຍກໍມັກນອນໝົດມື້	私の父も休日は寝てばっかりだし。	好きな行動について述べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
219	ໂອ້ !	えっ！			\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
220	ແມ່ນບໍ່?	そうなの？			\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
221	ແຕ່ແມ່ກັບຂ້ອຍກໍບໍ່ເວົ້າຫຍັງ.	でも、母と私は文句言ったりしないの。			\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
222	ເພາະພວກເຮົາຮູ້ວ່າພໍ່ເຮັດວຽກໜັກຫຼາຍ.	だって、仕事がすごく忙しいから。	理由を述べる		\N	dmod	lo20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
223	ບຸນມີຮູ້ຈັກວິທີເຮັດລາບບໍ່?	ラープの作り方知ってる？			\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
224	ຮູ້,ທຳອິດຂົ້ວຊີ້ນມຸ່ນກ່ອນ.	知ってるよ､最初にひき肉を炒めるんだ。	順序について述べる		\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
225	ຊີ້ນຫຍັງ?	何の肉？			\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
226	ຊີ້ນຫຍັງກໍໄດ້, ປາກໍໄດ້	何の肉でもいいよ､魚でもいいよ。			\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
227	ຕໍ່ໄປ ຊອຍໝາກເຜັດ, ຂ່າ ແລະຫົວສີໄຄໃຫ້ແລບໆ.	次に唐辛子とカーとレモングラスを細かく刻む。	順序について述べる		\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
228	ໃສ່ໝາກເຜັດຈັກໜ່ວຍ?	唐辛子はいくつ入れるの？	数字についてたずねる		\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
229	ແລ້ວແຕ່ເຈົ້າມັກ.	好きなだけ。	好きなものについて述べる		\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
230	ສຸດທ້າຍ ເອົາຊີ້ນທີ່ຂົ້ວແລ້ວ, ເຂົ້າຂົ້ວ ແລະຜັກຫອມຕ່າງໆ ຄົນໃສ່ກັນ ແລ້ວຈຶ່ງປຸງລົດຕາມຄວາມມັກ.	最後に炒めた肉と炒った米といろんなハーブ類を混ぜ合わせて､好きなように味付けをするんだよ。	順序について述べる		\N	dmod	lo21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
231	ອ້າຍບຸນພັນ !	ブンパンさん！	呼びかける		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
232	ໂອ້, ແສງບໍ, ເປັນຈັ່ງໃດ?	あぁ、セーンさんじゃないか、調子はどう？	状況についてたずねる		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
459	練習３(4)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
233	ໄດ້ເຮັດວຽກແລ້ວບໍ?	もう仕事してるの？	状況についてたずねる		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
234	ເຈົ້າ.	はい。	肯定する		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
235	ເຮັດຢູ່ບໍລິສັດໂຕກຽວການຄ້າ	東京商社で働いています。	状況について述べる		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
236	ອ້າຍເດ? 	ブンパンさんは？			\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
237	ເຮັດວຽກຢູ່ໃສ?	どこで働いているんですか？	状況についてたずねる		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	1
238	ອ້າຍເຮັດວຽກຢູ່ກະຊວງກະສິກຳ-ປ່າໄມ້ ຢູ່ໃກ້ປະຕູໄຊ.	パトゥーサイ(凱旋門)の近くの農林省で働いているよ。	状況について述べる		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
239	ມີແຟນແລ້ວບໍ?	恋人はできた？	状況についてたずねる		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
240	ມີແລ້ວ, ແຟນນ້ອງເປັນພະນັກງານຢູ່ບ່ອນດຽວກັນ.	はい､彼は私と同じところの社員です。	人を紹介する		\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
241	ເປັນຕາອິດສານໍ !	うらやましいなぁ！			\N	dmod	lo22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
242	ຊົ່ວໂມງນີ້ອາຈານຄືຊິບໍ່ມາເນາະ	この時間には先生は来ないみたいね。	推量する		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
243	ເປັນຫຍັງຈຶ່ງວ່າຊັ້ນ?	どうしてわかるの？	理由をたずねる		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
244	ດຽວນີ້ 10 ໂມງປາຍແລ້ວໄດ໋	今、もう10時過ぎよ。	時間について述べる		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
245	ຕາມທຳມະດາອາຈານມາ 10 ໂມງຍັງ.	普通なら先生は１０時前に来るはずよね。	j時間について述べる		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
246	ຖ້າອາຈານບໍ່ມາ ເອມິຊິໄປໃສ?	もし先生が来なかったらエミさんはどこに行くの？	条件をつける		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
247	ຊິເມືອບ້ານ.	家に帰るわ。	予定を述べる		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
248	ເອົ້າ, ເມືອເລີຍຫວາ?	え、帰っちゃうの？			\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
249	ໄປຫໍພິພິດທະພັນ ທ່ານ ໄກສອນ ນຳກັນເນາະ.	カイソーン博物館に一緒に行こうよ。	提案する		\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
250	ໄປກໍໄປ.	いいわよ。			\N	dmod	lo23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
251	ຢູ່ລາວມີຍາມຝົນກັບຍາມແລ້ງ	ラオスには雨季と乾季があるのよね。	状況についてたずねる		\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
252	ເດືອນໃດຮ້ອນທີ່ສຸດ?	何月が一番暑いの？	比べる		\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
254	ລະດູຮ້ອນ ຮ້ອນກວ່າລະດູຮ້ອນຢູ່ຍີ່ປຸ່ນອີກ	日本の夏よりも暑いよ。	比べる		\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
255	ຝົນເດ?	雨は？			\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
256	ເດືອນໃດຕົກຫຼາຍທີ່ສຸດ.	何月が一番降るの？	比べる		\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
257	ເດືອນ 8 ຫຼືເດືອນ 9.	８月か９月かな。			\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
258	ກາງເດືອນ 9 ຫາກາງເດືອນ 10 ແມ່ນໄລຍະທີ່ນ້ຳຖ້ວມຫຼາຍ.	９月の中旬から10月の中旬はよく洪水になるんだよ。	状況について述べる		\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
259	ຢູ່ວຽງຈັນ ນ້ຳຂອງເຄີຍຖ້ວມບໍ່?	ヴィエンチャンでも、メコン河が洪水になったことはあるの？	経験についてたずねる		\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
260	ເຄີຍ.	あるよ。			\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
261	ແຕ່ດົນແລ້ວ.	でもずっと前のことだよ。			\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
262	ບຸນມີ, ເປັນຫຍັງບໍ?	ブンミーさん、どうしたの？	状況についてたずねる		\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
263	ເຈັບຫົວແລ້ວກໍຍັງຮູ້ສຶກເມື່ອຍອີກ	頭が痛くて、だるいんだ。	状況について述べる		\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
264	ເປັນໄຂ້ຫວັດບໍ?	風邪をひいたの？			\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
265	ຢ້ານແມ່ນຢູ່.	そうかもしれない。			\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
266	ຄືບໍ່ໄປຫາທ່ານໝໍ?	どうしてお医者さんに行かないの？	提案する		\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
267	ຂ້ອຍບໍ່ມັກໄປໂຮງໝໍ	病院が好きじゃないんだ。	好きなものについて述べる		\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
268	ແຕ່ວ່າຄັນໄປໂຮງໝໍ ກໍຈະດີຂຶ້ນໄວໄດ໋.	でも病院に行ったら早く治るわよ。	意見を述べる		\N	dmod	lo25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
269	ມື້ນີ້ ຄຳດີບໍ່ໄດ້ມາຮຽນນໍ.	今日､カムディーさん、学校に来なかったわね。	状況について述べる		\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
270	ບຸນມີຮູ້ບໍ່ວ່າເປັນຫຍັງ?	ブンミーさんは何でか知ってる？	理由をたずねる		\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
271	ເພາະວ່າດຽວນີ້ ລາວຍັງຢູ່ຫຼວງພະບາງ.	だって今まだルアンパバーンにいるからだよ。	理由を述べる		\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
272	ແມ່ນຫວາ?	そうなの？			\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
273	ຄືວ່າຊິກັບມາວຽງຈັນມື້ວານນີ້.	昨日ヴィエンチャンに帰ってくるって言ってたのに。			\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
274	ໄດ້ຍິນວ່າມື້ວານນີ້ຍົນຂຶ້ນບໍ່ໄດ້ ຍ້ອນວ່າຝົນຕົກໜັກຫຼາຍ	昨日は大雨のせいで飛行機が飛ばなかったんだって。	理由を述べる		\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
275	ເລີຍກັບມາບໍ່ໄດ້.	それで帰ってこられなかったらしいよ。			\N	dmod	lo26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
276	ສະບາຍດີ.	こんにちは。	挨拶する		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
277	ເຊັກອິນບໍ?	チェックインですか？			\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
278	ເຈົ້າ, ຂ້ອຍຊື່ ຊະໂຕ.	はい､佐藤です。	自己紹介する		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
279	ຂໍເບິ່ງໜັງສືຜ່ານແດນແດ່.	パスポートを見せてください。	要求する		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
280	ກະລຸນາຂຽນຊື່ ແລະທີ່ຢູ່ຂອງທ່ານຢູ່ບ່ອນນີ້ດ້ວຍ	恐れ入りますがこちらにお客様のお名前とご住所をご記入いただけますでしょうか。	依頼する		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
281	ຂອບໃຈຫຼາຍໆ.	どうもありがとうございます。	感謝する		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
282	ມື້ອື່ນເຊົ້າປຸກຂ້ອຍ 6 ໂມງແດ່ເດີ	明日の朝６時に起こしてくださいね。	依頼する		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
283	ໂດຍ. 	かしこまりました。			\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
284	6 ໂມງນໍ.	６時ですね。	時間について述べる		\N	dmod	lo27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
285	ຂ້ອຍຢາກຖາມກ່ຽວກັບພາສາລາວ	ラオス語について質問があるんですが。	希望を述べる		\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
286	ກ່ຽວກັບຫຍັງ?	何？			\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
287	ຂ້ອຍບໍ່ເຂົ້າໃຈຄວາມໝາຍຄຳວ່າ ”ໄກຕາ, ໄກໃຈ”	「カイター､カイチャイ」の意味がわかりません。			\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
288	ໂອ້ . .​​ .​ . ໄດ້ຍິນມາແຕ່ໃສ?	へぇ……どこで習ってきたの？	場所についてたずねる		\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
289	ມັນແມ່ນສຳນວນພາສາລາວໄດ໋	これはラオスの慣用句だよ。			\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
290	ຕົວຢ່າງ, ໝາຍຄວາມວ່າ ມີແຟນຢູ່ໄກກັນ ແລະບໍ່ໄດ້ພົບກັນ ຫົວໃຈກໍຈະຫ່າງກັນໄປ.	例えば､遠くに恋人がいて会ってないと心まで離れていくってことだよ。	例をあげる		\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
291	ຖ້າມີແຟນແລ້ວຕ້ອງຢູ່ໃກ້ກັນ ແລະພົບກັນເລື້ອຍໆໄດ໋	恋人ができたらそばにいて､よく会わなくちゃいけないってこと。			\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	1
292	ເອີ ! ຜູ້ຊາຍລາວຄິດແບບນັ້ນນໍ	ふーん、ラオスの男性ってそんな風に考えるんだねえ。	意見を述べる		\N	dmod	lo28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
293	ມື້ແລງນີ້ ກິນຫຍັງດີນໍ?	今晩何食べましょうか？	意見をたずねる		\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
294	ຄິດເບິ່ງກ່ອນ.	考えさせて。			\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
295	ຊີ້ນດາດບໍ?	焼肉かしら？			\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
296	ຊຸກີ້ບໍ?	それともすき焼きがいいかしら？			\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
297	ຊົ້ນດາດກໍດີ, ຊຸກີ້ກໍດີຄືກັນ.	焼肉でもいいし、すき焼きでもいいよ。	妥協する		\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
298	ເອົ້າ ! ເວົ້າບໍ່ຄືຜູ້ຊາຍແທ້.	もう！　男らしく言いなさいよ。	比べる		\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
299	ຕັດສິນໃຈແມ໋.	決めて。	要求する		\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
300	ກິນອັນໃດດີລະ?	どっちがいいの？	意見をたずねる		\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
301	ອັນໃດກໍໄດ້.ແລ້ວແຕ່ເຈົ້າຈ່າຍ.	何でもいいよ、セーンさんのおごりなら。	妥協する		\N	dmod	lo29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
337	ເມົາແຕ່ເບິ່ງໂທລະທັດ	テレビに夢中だ。			\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
302	ທ່ານ ຊະໂຕ, ຂໍລົມນຳທ່ານໜ້ອຍໜຶ່ງໄດ້ບໍ່?	佐藤さん、お話がありますがよろしいですか？	許可を求める		\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
303	ໄດ້. 	はい。			\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
304	ມີຫຍັງ?	何ですか？	状況についてたずねる		\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
305	ອາທິດໜ້າຂ້ອຍຢາກຂໍພັກຈັກ 2-3 ມື້	来週２、３日休暇をいただきたいのですが。	許可を求める		\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
306	ໄປທ່ຽວບໍ?	遊びに行くの？			\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
307	ເຈົ້າ.	はい。	肯定する		\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
308	ພີ່ນ້ອງຊິມາຢາມແຕ່ຝຣັ່ງ, ແລ້ວຊິພາເຂົາເຈົ້າໄປຈຳປາສັກ.	フランスから親戚が来るので、チャムパーサックに連れて行こうと思っています。	予定を述べる		\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
309	ແມ່ນບໍ?	そうなの？			\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
310	ຊື້ຂອງຕ້ອນມາຝາກແດ່ເດີ	おみやげ買うの忘れないでね。	依頼する		\N	dmod	lo30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
311	ປີໜ້າເຈົ້າຊິຮຽນຢູ່ມະຫາວິທະຍາໄລແຫ່ງຊາດແມ່ນບໍ?	あなたは来年からラオス国立大学に通うのですよね？	予定をたずねる		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
312	ແມ່ນແລ້ວ.	そうです。			\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
313	ມີເສື້ອຂາວແລ້ວບໍ?	白いシャツはもう持っていますか？	状況についてたずねる		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
314	ຍັງບໍ່ທັນມີ	まだ持っていません。	状況について述べる		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
315	ຂ້ອຍຕ້ອງນຸ່ງເສື້ອຂາວຄືກັນບໍ?	私も白いシャツを着ないといけませんか？	しなければならないと言う		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
316	ຕ້ອງນຸ່ງຕົ໋ວະ.	着ないといけないですね。	しなければならないと言う		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
317	ຄັນຊັ້ນຕ້ອງໄປຊື້ກ່ອນ	それでは新しいのを買いに行かなくてはいけません。	しなければならないと言う		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
318	ຄວນຈະມີຈັກໂຕ?	何着要りますか？	数字についてたずねる		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
319	ມີ 2-3 ໂຕ ກໍພໍແລ້ວ.	２、３着あれば十分です。	数字について述べる		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
320	ຜູ້ຍິງຕ້ອງນຸ່ງສິ້ນອີກ	女性はシンもはかないといけないですよ。	しなければならないと言う		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
321	ສິ້ນແບບໃດ?	どんなシンですか？	特徴についてたずねる		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
322	ຈະຕ້ອງແມ່ນສີດຳ ຫຼືສີຟ້າແກ່	黒色か紺色でないといけません。	しなければならないと言う		\N	dmod	lo31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
323	ໂອ້ ! ມື້ນີ້ຮ້ອນຫຼາຍເນາະ.	あぁ！　今日は暑いわねぇ。	程度について述べる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
324	ຄືບໍ່ເປີດພັດລົມ?	どうして扇風機をつけてないの？	理由をたずねる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
325	ພັດລົມເພແລ້ວ, ຍັງບໍ່ທັນໄດ້ແປງ.	壊れちゃって、まだ直してないんだ。	状況について述べる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
326	ຄັນໄຂປະຕູຄືຊິເຢັນຂຶ້ນ	ドアを開ければ涼しくなるかしら。	意見を述べる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
327	ຢ່າໄຂປະຕູນັ້ນໄດ໋	そのドアを開けないで。	禁止する		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
328	ຂີ້ຝຸ່ນຊິເຂົ້າມາ	ほこりが入ってきそう。	予定を述べる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
329	ປ່ອງຢ່ຽມນີ້ ກໍໄຂບໍ່ໄດ້ຫວາ?	こっちの窓も開けちゃだめなの？	許可を求める		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
330	ບໍ່ໄດ້. 	だめ。	禁止する		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
331	ບໍ່ຮ້ອນຫວາ?	暑くないの？	程度についてたずねる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
332	ຮ້ອນຕົ໋ວະ !	暑いよ！	程度について述べる		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
333	ໄປກິນເບຍຢູ່ນອກກັນເນາະ	外に冷たいラオスビールでも飲みに行こう。	提案する		\N	dmod	lo32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
334	ມະນີ, ຍັງຢູ່ຫວາ?	マニー、まだいたの？			\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
335	ຄືວ່າຊິໄປສົ່ງລຸງຢູ່ເດີ່ນຍົນ	おじさんを見送りに空港へ行くんでしょ。	指示する		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
336	ໂອ້ຍ, ເກືອບລືມ.	あ、あやうく忘れるところだったわ。			\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
338	ຕອນນີ້ຈັກໂມງແລ້ວ?	今何時？	時間についてたずねる		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
339	11 ໂມງເຄິ່ງ.	11時半だよ。	時間について述べる		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
340	ຍົນຊິຂຶ້ນຈັກໂມງ?	飛行機は何時に出発するの？	時間についてたずねる		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
341	12 ໂມງ 10 ນາທີ ຕິເບາະ.	12時10分だったかしら。	時間について述べる		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
342	ຟ້າວໄປແມ໋.	急いで行きなよ。	指示する		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
343	ຊິບໍ່ທັນໄດ໋.	間に合わないよ。	意見を述べる		\N	dmod	lo33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
344	ອາໂຫຼ, ອ້າຍບຸນມີຫວາ?	もしもし、ブンミー兄さん？			\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
345	ແມ່ໄປການແລ້ວບໍ?	お母さんはもう仕事に行った？	状況についてたずねる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
346	ເອີ, ໄປແລ້ວ.	うん、行ったよ。	状況について述べる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
347	ຈັກໜ້ອຍອ້າຍກໍຊິອອກໄປບໍ?	お兄さんももう少ししたら出かける？	予定をたずねる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
348	ຊິໄປຊື້ເຄື່ອງຢູ່ຕະຫຼາດເຊົ້າ	タラート・サオに買い物に行く。	予定を述べる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
349	ບໍ່ຕ້ອງໃສ່ກະແຈເຮືອນເດີ	鍵をかけないでね。	しないでくれと言う		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
350	ຢ່າລືມໄດ໋.	忘れないでね。	しないでくれと言う		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
351	ເປັນຫຍັງ?	どうして？	理由をたずねる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
352	ລືມເອົາກະແຈມາ.	鍵を持ってくるの忘れちゃったの。	理由を述べる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
354	ຄັນຊັ້ນຊິຖ້າ.	じゃあ待ってるよ。	予定を述べる		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
355	ກັບມາໄວໆເດີ.	早く帰ってきな。	指示する		\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
356	ອາຈານ, ວຽກບ້ານຕ້ອງອ່ານວັນນະຄະດີລາວຈັກເລື່ອງ?	先生、宿題はラオスの文学作品をいくつ読まなければなりませんか？	しなければならないと言う		\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
357	ບໍ່ຕ້ອງອ່ານຫຼາຍກໍໄດ້.	たくさん読まなくてもいいよ。	しなくともよいと言う		\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
358	ອ່ານເລື່ອງດຽວກໍພໍ.	１つで十分。	数字について述べる		\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
359	ແມ່ນບໍ.	そうですか。			\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
360	ຄັນຊັ້ນນ້ອງຊິອ່ານເລື່ອງ ”ສັງສິນໄຊ”	それでは私は『サンシンサイ』を読みます。	予定を述べる		\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
361	ແຕ່ວ່າ ”ສັງສິນໄຊ” ມີ 5 ເຫຼັ້ມໄດ໋.	でも『サンシンサイ』は５巻まであるよ。			\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
362	ອ່ານໄຫວຫວາ?	読めるかな？	能力についてたずねる		\N	dmod	lo35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
363	ທ່ານ ຊະໂຕ, ວັນຈັນໜ້າທ່ານມີເວລາບໍ່?	佐藤さん､来週の月曜日はお時間ありますか？	予定をたずねる		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
364	ມີ, ຍັງບໍ່ທັນມີວຽກຫຍັງເທື່ອ.	はい､今のところ何もないよ。	予定を述べる		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
365	ມີຫຍັງບໍ?	何かあるの？	状況についてたずねる		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
366	ຢາກເຊີນທ່ານ ໄປກິນດອງນ້ອງ.	佐藤さんを私の結婚式にご招待したいと思いまして。	招待する		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
367	ວັນຈັນໜ້າສູ່ຂວັນ ເລີ່ມແຕ່ 10 ໂມງເຊົ້າ ແລະກິນລ້ຽງຕອນແລງ.	来週の月曜日に10時からバーシーの式があり､夜にパーティーをします。	予定を述べる		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
368	ເລີ່ມແຕ່ 7 ໂມງແລງຢູ່ໂຮງແຮມລາວ.	ラオホテルで7時から始まります。	時間について述べる		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
369	ຂໍເຊີນເມຍທ່ານມານຳແດ່ເດີ	どうか奥様もご一緒にいらしてくださいね。	招待する		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	1
370	ເອີ, ຂ້ອຍຕ້ອງໄປຮ່ວມສະຫຼອງພວກເຈົ້າໄດ໋ນໍ	ああ､君たちをぜひともお祝いしに行かなくちゃね。	しなければならないと言う		\N	dmod	lo36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
371	ຂ້ອຍມີເລ່ືອງຢາກປຶກສານຳເອມິ.	エミさんに相談したいことがあるんだ。	希望を述べる		\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
372	ມີຫຍັງບໍ?	何？	状況についてたずねる		\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
373	ຂ້ອຍຢາກໄປຮຽນຢູ່ຍີ່ປຸ່ນ, ແຕ່ແມ່ຂ້ອຍບໍ່ຢາກໃຫ້ໄປ	日本に留学したいけれど、母が反対していて。	状況について述べる		\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
374	ເຮັດຈັ່ງໃດດີນໍ?	どうしたらいいかな？			\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
375	ຂ້ອຍຄິດວ່າບຸນມີຄວນລົມກັບແມ່ດີໆ ແລະໃຫ້ແມ່ເຂົ້າໃຈກ່ອນດີກວ່າ.	ちゃんと話し合って、お母さんに分かってもらうべきだと思うわ。	助言する		\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
376	ຄັນມີເຫດຜົນດີ ເພິ່ນກໍຄົງເຂົ້າໃຈ.	きちんとした理由があればお母さんも分かってくれるはずよ。	助言する		\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
377	ລອງພະຍາຍາມອະທິບາຍເບິ່ງ.	がんばって説明してみたら。	助言する		\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
378	ແມ່ນໄດ໋ນໍ.	そうだね。			\N	dmod	lo37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
379	ເອມິ, ມື້ອື່ນຢືມຄອມພິວເຕີແດ່ເດີ	エミさん､明日パソコン貸してよ。	要求する		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
380	ຂ້ອຍຕ້ອງການໃຊ້.	使いたいんだ。	希望を述べる		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
381	ໄດ້. 	いいわよ。			\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
382	ຊິເຮັດຫຍັງ	何をするの？	状況についてたずねる		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
383	ຕ້ອງຂຽນບົດລາຍງານເປັນພາສາຍີ່ປຸ່ນ	日本語でレポートを書かなければならないんだ。	しなければならないと言う		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
384	ຫາກໍເລີ່ມຮຽນພາສາຍີ່ປຸ່ນບໍ່ແມ່ນບໍ?	日本語を勉強し始めたばかりではなかったの？	状況についてたずねる		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
385	ແມ່ນແລ້ວ.	そうなんだ。			\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
386	ຖ້າບໍ່ໄດ້ໃຊ້ຄອມພິວເຕີ, ຊິລຳບາກຫຼາຍ.	もし、パソコンを使わないととても大変で.	条件をつける		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
387	. .​​ . . ຄວາມຈິງ, ຂ້ອຍບໍ່ຮູ້ວິທີໃຊ້, ເອມິຕ້ອງສອນໃຫ້ຂ້ອຍແດ່ເດີ	……本当は使い方がわからないから、エミさん、教えてね。	依頼する		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
388	ໄດ້. 	いいわよ。			\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
389	ບໍ່ມີບັນຫາ, ຖ້າແມ່ນຕອນແລງ	午後なら問題ないよ。	条件をつける		\N	dmod	lo38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
390	ໃນອະນາຄົດ ບຸນມີຢາກເປັນຫຍັງ?	将来、ブンミーさんは、何になりたいの？			\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
391	ຂ້ອຍຢາກເປັນຊ່ຽວຊານກ່ຽວກັບຄອມພິວເຕີ.	コンピュータの専門家になりたいんだ。	希望を述べる		\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
392	ແລ້ວກໍຢາກມີເງິນຫຼາຍ ແລະເຮືອນຫຼັງໃຫຍ່ໆ	それからお金持ちになって大きな家に住みたいな。	希望を述べる		\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
393	ຖ້າເປັນໄປໄດ້, ມີເມຍງາມໆອີກ	できればきれいな奥さんももらえたらいいな。	希望を述べる		\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
394	ໂອ້ຍ ! ຢາກໄດ້ຫຼາຍແນວໂພດ	えーっ！　欲張りすぎよ。	意見を述べる		\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
395	ຂໍໃຫ້ສົມຫວັງເດີ.	望みどおりになればいいわね。	希望を述べる		\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
396	. .​ . . ແລ້ວປັນຂ້ອຍແດ່ເດີ.	……で､私にも分けてね。	依頼する		\N	dmod	lo39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
397	ຜູ້ນີ້ແມ່ນອ້າຍຂ້ອຍ ຊື່ບຸນພັນ	こちらは兄のブンパンです。	人を紹介する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
398	ລາວເຮັດວຽກຢູ່ກະຊວງກະສິກຳ-ປ່າໄມ້.	彼は農林省で働いています。	人を紹介する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
399	ສະບາຍດີ.	こんにちは。	挨拶する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
400	ຍິນດີທີ່ໄດ້ຮູ້ຈັກ.	お会いできてうれしいです。	挨拶する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
401	ຜູ້ນີ້ແມ່ນໝູ່ຂ້ອຍ ຊື່ເອມິ ມາຈາກຍີ່ປຸ່ນ.	こちらは友人のエミさんで、日本から来てるんだよ。	人を紹介する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
402	ຮຽນນຳກັນຢູ່ດົງໂດກ.	ドンドークで一緒に勉強してるんだ。	状況について述べる		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
403	ສະບາຍດີ.	こんにちは。	挨拶する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
404	ເຈົ້າເວົ້າພາສາລາວເກັ່ງເນາະ	ラオス語がお上手ですね。	意見を述べる		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
457	練習３(2)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
405	ມື້ໜ້າໄປຢາມເຮືອນພວກເຮົາແດ່ເດີ.	今度家に遊びに来てくださいね。	招待する		\N	dmod	lo40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
406	ບຸນ	祭	\N		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
407	ບ້ານ	村	\N		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
408	ມິດ	友好，静かだ	\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
409	ມີດ	包丁，ナイフ	\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
410	ເຫັດ	キノコ	\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
411	ເຫດ	原因	\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
412	ແປະ	ぴったりくっつく	\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]		0	1
413	ແປ 	平ら	\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]		0	1
414	ໄປ	行く	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
415	ໃຜ　	誰	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
416	ໃບ	葉	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
417	ໄຕ	這う	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
418	ໄຖ	耕す	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]		0	1
419	ໃດ	どの	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]		0	1
420	ໃຈ	心	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]		0	1
421	ໄກ	遠い	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]		0	1
422	ໄຂ	開ける	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[9]		0	1
423	ໄອ	咳をする	\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[10]		0	1
424	ຄ່າ	価値	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
425	ຂ້າ	殺す	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
426	ຄ້າ	商う	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
427	ຄາ	とどまる	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
428	ຂັດ	磨く	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]		0	1
429	ຂາ	脚	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]		0	1
430	ຫຼັງ 	背中	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]		0	1
431	ຫຼັງຄາ	屋根	\N		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]		0	1
432	ຫຼັງ	「背中」	\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
433	ຫຼັງຄາ	「屋根」	\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
434	ລັດຖະບານ  	政府	\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
435	ອຸບັດຕິເຫດ 	事故	\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
436	ກໍ	「〜も」	\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
437	ກອງ	「太鼓」	\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
438	ຂຸ 	「落ちる」	\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
439	ຂຸດ 	 「掘る」	\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
440	ກ້າ 	勇ましい	\N		\N	pmod	page035.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
441	ຂ້າ	殺す	\N		\N	pmod	page035.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
442	ຄ້າ	商売する	\N		\N	pmod	page035.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
443	ຂວາ	「右」	\N		\N	pmod	page038.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
444	ຄວາຍ	「水牛」	\N		\N	pmod	page038.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
445	ລາວ	ラオス	\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
446	ປຶ້ມ	本	\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
447	ຍີ່ປຸ່ນ	日本	\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
448	ຍູງ     →   ຍຸງ	蚊	\N		\N	pmod	page041.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
449	ເທີງ    →  ເທິງ	上	\N		\N	pmod	page041.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
450	ເລື່ອຍໆ    → ເລື້ອຍໆ	ずっと	\N		\N	pmod	page041.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
451	練習１(1)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
452	練習１(2)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
453	練習１(3)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
454	練習１(4)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
455	練習１(5)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
456	練習３(1)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
460	練習３(5)		\N		\N	pmod	page044.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
461	練習１(1)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
462	練習１(2)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
463	練習１(3)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
464	練習１(4)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
465	練習１(5)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
466	練習３(1)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
467	練習３(2)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
468	練習３(3)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
469	練習３(4)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
470	練習３(5)		\N		\N	pmod	page047.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
471	練習１(1)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
472	練習１(2)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
473	練習１(3)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
474	練習１(4)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
475	練習１(5)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
476	練習３(1)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
477	練習３(2)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
478	練習３(3)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
479	練習３(4)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
480	練習３(5)		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
481	練習１(1)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
482	練習１(2)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
483	練習１(3)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
484	練習１(4)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
485	練習１(5)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
486	練習１(6)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[6]		0	1
487	練習１(7)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[7]		0	1
488	練習１(8)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[8]		0	1
489	練習１(9)		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[9]		0	1
490	/ia/　中平調　　　　k・・・		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
491	/ia/　低降調　　　　k・・・		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
492	/ia/　下降調　　　　c・・		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
493	/ia/　中高調　　　　m・・		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
494	/ia/　上昇調　　　　k・・・・		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
495	/うa/　中平調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
496	/うa/　低降調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
497	/うa/　下降調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
498	/うa/　中高調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
499	/うa/　上昇調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
500	/ua/　中平調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
501	/ua/　低降調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
502	/ua/　下降調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
503	/ua/　中高調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
504	/ua/　上昇調		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
505	練習３　(1)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
506	練習３　(2)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
507	練習３　(3)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
508	練習３　(4)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[4]		0	1
509	練習３　(5)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[5]		0	1
510	練習３　(6)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[6]		0	1
511	練習３　(7)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[7]		0	1
512	練習３　(8)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[8]		0	1
513	練習３　(9)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[9]		0	1
514	練習３　(10)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[10]		0	1
515	練習３　(11)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[11]		0	1
516	練習３　(12)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[12]		0	1
517	練習３　(13)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[13]		0	1
518	練習３　(14)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[14]		0	1
519	練習３　(15)		\N		\N	pmod	page051.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[15]		0	1
520	練習１　中平調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
521	練習１　中平調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
522	練習１　中平調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
523	練習１　中平調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
524	練習１　中平調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
525	練習１　低降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
526	練習１　低降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
527	練習１　低降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
528	練習１　低降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
529	練習１　低降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
530	練習１　下降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
531	練習１　下降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
532	練習１　下降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
533	練習１　下降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
534	練習１　下降調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
535	練習１　中高調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
536	練習１　中高調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
537	練習１　中高調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
538	練習１　中高調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[4]		0	1
539	練習１　中高調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[5]		0	1
540	練習１　上昇調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
541	練習１　上昇調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
542	練習１　上昇調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
543	練習１　上昇調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[4]		0	1
544	練習１　上昇調		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[5]		0	1
545	練習２　(1)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
546	練習２　(2)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
547	練習２　(3)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
548	練習２　(4)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
549	練習２　(5)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[5]		0	1
550	練習２　(6)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[6]		0	1
551	練習２　(7)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[7]		0	1
552	練習２　(8)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[8]		0	1
553	練習２　(9)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[9]		0	1
554	練習２　(10)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[10]		0	1
555	練習２　(11)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[11]		0	1
556	練習２　(12)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[12]		0	1
557	練習２　(13)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[13]		0	1
558	練習２　(14)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[14]		0	1
559	練習２　(15)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[15]		0	1
560	練習２　(16)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[16]		0	1
561	練習２　(17)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[17]		0	1
562	練習２　(18)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[18]		0	1
563	練習２　(19)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[19]		0	1
564	練習２　(20)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[20]		0	1
565	練習２　(21)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[21]		0	1
566	練習２　(22)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[22]		0	1
567	練習２　(23)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[23]		0	1
568	練習２　(24)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[24]		0	1
569	練習２　(25)		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[25]		0	1
570	中平調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
571	中平調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
572	中平調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
573	低降調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
574	低降調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
575	低降調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
576	下降調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
577	下降調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
578	下降調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
579	中高調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
580	中高調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
581	中高調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
582	上昇調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
583	上昇調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
584	上昇調		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
585	練習２　(1)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
586	練習２　(2)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
587	練習２　(3)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
588	練習２　(4)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
589	練習２　(5)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[5]		0	1
590	練習２　(6)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[6]		0	1
591	練習２　(7)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[7]		0	1
592	練習２　(8)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[8]		0	1
593	練習２　(9)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[9]		0	1
594	練習２　(10)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[10]		0	1
595	練習２　(11)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[11]		0	1
596	練習２　(12)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[12]		0	1
597	練習２　(13)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[13]		0	1
598	練習２　(14)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[14]		0	1
599	練習２　(15)		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[15]		0	1
600	練習１　中平調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
601	練習１　中平調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
602	練習１　中平調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
603	練習１　中平調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
604	練習１　低降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
605	練習１　低降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
606	練習１　低降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
607	練習１　低降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
608	練習１　下降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
609	練習１　下降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
610	練習１　下降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
611	練習１　下降調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
612	練習１　中高調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
613	練習１　中高調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
614	練習１　中高調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
615	練習１　中高調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[4]		0	1
616	練習１　上昇調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
617	練習１　上昇調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
618	練習１　上昇調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
619	練習１　上昇調		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[4]		0	1
620	練習２　(1)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
621	練習２　(2)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
622	練習２　(3)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
623	練習２　(4)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
624	練習２　(5)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[5]		0	1
625	練習２　(6)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[6]		0	1
626	練習２　(7)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[7]		0	1
627	練習２　(8)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[8]		0	1
628	練習２　(9)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[9]		0	1
629	練習２　(10)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[10]		0	1
630	練習２　(11)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[11]		0	1
631	練習２　(12)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[12]		0	1
632	練習２　(13)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[13]		0	1
633	練習２　(14)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[14]		0	1
634	練習２　(15)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[15]		0	1
635	練習２　(16)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[16]		0	1
636	練習２　(17)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[17]		0	1
637	練習２　(18)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[18]		0	1
638	練習２　(19)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[19]		0	1
639	練習２　(20)		\N		\N	pmod	page055.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[20]		0	1
641	中平調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
642	低降調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
643	低降調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
644	下降調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
645	下降調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
646	中高調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
647	中高調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
648	上昇調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
649	上昇調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
650	練習２　(1)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
651	練習２　(2)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
652	練習２　(3)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
653	練習２　(4)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
654	練習２　(5)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[5]		0	1
655	練習２　(6)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[6]		0	1
656	練習２　(7)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[7]		0	1
657	練習２　(8)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[8]		0	1
658	練習２　(9)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[9]		0	1
659	練習２　(10)		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[10]		0	1
660	練習１　中平調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
661	練習１　低降調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
662	練習１　下降調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
663	練習１　中高調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
664	練習１　上昇調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
665	練習１　中平調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[6]		0	1
666	練習１　低降調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[7]		0	1
667	練習１　下降調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[8]		0	1
668	練習１　中高調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[9]		0	1
669	練習１　上昇調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[10]		0	1
670	練習１　中平調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
671	練習１　低降調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
672	練習１　下降調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
673	練習１　中高調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
674	練習１　上昇調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
675	練習１　中平調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[6]		0	1
676	練習１　低降調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[7]		0	1
677	練習１　下降調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[8]		0	1
678	練習１　中高調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[9]		0	1
679	練習１　上昇調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[10]		0	1
680	練習１　中平調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
681	練習１　低降調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
682	練習１　下降調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
683	練習１　中高調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
684	練習１　上昇調短母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
685	練習１　中平調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[6]		0	1
686	練習１　低降調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[7]		0	1
687	練習１　下降調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[8]		0	1
688	練習１　中高調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[9]		0	1
689	練習１　上昇調長母音		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[10]		0	1
690	(1)m		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
691	(2)n		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
692	(3)ng		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
693	(2)/m/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
694	(2)/n/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
695	(2)/ng/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
696	(3)/m/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]		0	1
697	(3)/n/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[2]		0	1
698	(3)/ng/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[3]		0	1
699	(4)/m/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]		0	1
700	(3)/n/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[2]		0	1
701	(3)/ng/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[3]		0	1
702	(4)/m/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[1]		0	1
703	(4)/n/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[2]		0	1
704	(4)/ng/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[3]		0	1
705	(5)/m/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[1]		0	1
706	(5)/n/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[2]		0	1
707	(5)/ng/		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[3]		0	1
708	練習１　中平調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
709	練習１　中平調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
710	練習１　中平調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
711	練習１　低降調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
712	練習１　低降調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
713	練習１　低降調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
714	練習１　下降調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
715	練習１　下降調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
716	練習１　下降調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
717	練習１　中高調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
718	練習１　中高調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
719	練習１　中高調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
720	練習１　上昇調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
721	練習１　上昇調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
722	練習１　上昇調		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
723	練習２　(1)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
724	練習２　(2)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
725	練習２　(3)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
726	練習２　(4)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
727	練習２　(5)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[5]		0	1
728	練習２　(6)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[6]		0	1
729	練習２　(7)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[7]		0	1
730	練習２　(8)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[8]		0	1
731	練習２　(9)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[9]		0	1
732	練習２　(10)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[10]		0	1
733	練習２　(11)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[11]		0	1
734	練習２　(12)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[12]		0	1
735	練習２　(13)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[13]		0	1
736	練習２　(14)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[14]		0	1
737	練習２　(15)		\N		\N	pmod	page057.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[15]		0	1
738	練習１　中平調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
739	練習１　中平調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
740	練習１　中平調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
741	練習１　低降調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
742	練習１　低降調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
743	練習１　低降調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
744	練習１　下降調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
745	練習１　下降調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
746	練習１　下降調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
747	練習１　中高調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
748	練習１　中高調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
749	練習１　中高調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
750	練習１　上昇調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
751	練習１　上昇調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
752	練習１　上昇調		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
753	練習２　(1)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
754	練習２　(2)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
756	練習２　(4)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
757	練習２　(5)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[5]		0	1
758	練習２　(6)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[6]		0	1
759	練習２　(7)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[7]		0	1
760	練習２　(8)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[8]		0	1
761	練習２　(9)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[9]		0	1
762	練習２　(10)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[10]		0	1
763	練習２　(11)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[11]		0	1
764	練習２　(12)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[12]		0	1
765	練習２　(13)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[13]		0	1
766	練習２　(14)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[14]		0	1
767	練習２　(15)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[15]		0	1
768	練習１　中平調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
769	練習１　低降調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
770	練習１　下降調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
771	練習１　中高調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
772	練習１　上昇調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
773	練習１　中平調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[6]		0	1
774	練習１　低降調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[7]		0	1
775	練習１　下降調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[8]		0	1
776	練習１　中高調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[9]		0	1
777	練習１　上昇調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[10]		0	1
778	練習１　中平調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
779	練習１　低降調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
780	練習１　下降調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
781	練習１　中高調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
782	練習１　上昇調短母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
783	練習１　中平調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[6]		0	1
784	練習１　低降調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[7]		0	1
785	練習１　下降調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[8]		0	1
786	練習１　中高調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[9]		0	1
787	練習１　上昇調長母音		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[10]		0	1
788	(1)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
789	(2)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
790	(3)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
791	(4)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[4]		0	1
792	(5)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[5]		0	1
793	(6)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[6]		0	1
794	(7)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[7]		0	1
795	(8)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[8]		0	1
796	(9)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[9]		0	1
797	(10)		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[10]		0	1
798	練習１　中平調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
799	練習１　低降調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
800	練習１　下降調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
801	練習１　中高調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
802	練習１　中平調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
803	練習１　低降調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
804	練習１　下降調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
805	練習１　中高調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
806	練習１　中平調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
807	練習１　低降調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
808	練習１　下降調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
809	練習１　中高調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
810	練習１　中平調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
811	練習１　中高調		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
812	(1)/p/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
813	(1)/t/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
814	(1)/k/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
815	(1)/?/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[4]		0	1
816	(2)/p/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]		0	1
817	(2)/t/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[2]		0	1
818	(2)/k/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[3]		0	1
819	(2)/?/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[4]		0	1
820	(3)/p/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]		0	1
821	(3)/t/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[2]		0	1
822	(3)/k/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[3]		0	1
823	(3)/?/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[4]		0	1
824	(4)/p/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[1]		0	1
825	(4)/t/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[2]		0	1
826	(4)/k/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[3]		0	1
827	(4)/?/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[4]		0	1
828	(5)/p/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[1]		0	1
829	(5)/t/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[2]		0	1
830	(5)/k/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[3]		0	1
831	(5)/?/		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[4]		0	1
832	練習１　中平調　　短母音＋末子音		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
833	練習１　低降調　　短母音＋末子音		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
834	練習１　下降調　　短母音＋末子音		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
835	練習１　中高調　　短母音＋末子音		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
836	練習１　上昇調　　短母音＋末子音		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
837	練習１　中平調　　長母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
838	練習１　低降調　　長母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
839	練習１　下降調　　長母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
840	練習１　中高調　　長母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
841	練習１　上昇調　　長母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
842	練習１　中平調　　二重母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
843	練習１　低降調　　二重母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
844	練習１　下降調　　二重母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
845	練習１　中高調　　二重母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
846	練習１　上昇調　　二重母音(＋末子音)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
847	(1)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
848	(2)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
849	(3)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
850	(4)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[4]		0	1
851	(5)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[5]		0	1
852	(6)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[6]		0	1
853	(7)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[7]		0	1
854	(8)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[8]		0	1
855	(9)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[9]		0	1
856	(10)		\N		\N	pmod	page061.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[10]		0	1
857	練習１　中平調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
858	練習１　低降調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
859	練習１　下降調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
860	練習１　中高調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
861	練習１　上昇調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
862	練習１　中平調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
863	練習１　低降調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
864	練習１　下降調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
865	練習１　中高調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
866	練習１　上昇調		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
867	中平調/ee/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
868	中平調/EE/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
869	低降調/ee/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
870	低降調/EE/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
871	下降調/ee/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
872	下降調/EE/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
873	中高調/ee/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]		0	1
874	中高調/EE/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[2]		0	1
875	上昇調/ee/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]		0	1
876	上昇調/EE/		\N		\N	pmod	page063.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[2]		0	1
877	（１）中平調		\N		\N	pmod	page062.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
878	（２）低降調		\N		\N	pmod	page062.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
879	（３）下降調		\N		\N	pmod	page062.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
880	（４）中高調		\N		\N	pmod	page062.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
881	（５）上昇調		\N		\N	pmod	page062.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
882	練習１(1)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
883	練習１(2)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
884	練習１(3)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
885	練習１(4)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
886	練習１(5)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
887	練習３(1)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
888	練習３(2)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
889	練習３(3)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
890	練習３(4)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
891	練習３(5)		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
892	練習１(1)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
893	練習１(2)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
894	練習１(3)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
895	練習１(4)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
896	練習１(5)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
897	練習３(1)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
898	練習３(2)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
899	練習３(3)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
900	練習３(4)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
901	練習３(5)		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
902	練習１　中平調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
903	練習１　低降調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
904	練習１　下降調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
905	練習１　中高調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
906	練習１　上昇調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
907	練習１　中平調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
908	練習１　低降調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
909	練習１　下降調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
910	練習１　中高調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
911	練習１　上昇調		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
912	中平調/oo/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
915	低降調/・・/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
916	下降調/oo/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
917	下降調/・・/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
918	中高調/oo/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]		0	1
919	中高調/・・/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[2]		0	1
920	上昇調/oo/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]		0	1
921	上昇調/・・/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[2]		0	1
922	(1)1		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
923	(1)2		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
924	(2)1		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
925	(2)2		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
926	(3)1		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
927	(3)2		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
928	(4)1		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
929	(4)2		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
930	(5)1		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]		0	1
931	(5)2		\N		\N	pmod	page065.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[2]		0	1
932	練習１　/p/中平調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
933	練習１　/ph/中平調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
934	練習１　/t/中平調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
935	練習１　/th/中平調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
936	練習１　/k/中平調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
937	練習１　/kh/中平調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[6]		0	1
938	練習１　/p/低降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
939	練習１　/ph/低降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
940	練習１　/t/低降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
941	練習１　/th/低降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
942	練習１　/k/低降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
943	練習１　/kh/低降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[6]		0	1
944	練習１　/p/下降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]		0	1
945	練習１　/ph/下降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]		0	1
946	練習１　/t/下降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]		0	1
947	練習１　/th/下降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]		0	1
948	練習１　/k/下降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]		0	1
949	練習１　/kh/下降調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[6]		0	1
950	練習１　/p/中高調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]		0	1
951	練習１　/ph/中高調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
952	練習１　/t/中高調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[3]		0	1
953	練習１　/th/中高調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[4]		0	1
954	練習１　/k/中高調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[5]		0	1
955	練習１　/kh/中高調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[6]		0	1
956	練習１　/p/上昇調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
957	練習１　/ph/上昇調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[2]		0	1
958	練習１　/t/上昇調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[3]		0	1
959	練習１　/th/上昇調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[4]		0	1
960	練習１　/k/上昇調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[5]		0	1
961	練習１　/kh/上昇調		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[6]		0	1
962	A		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]		0	1
963	B		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[2]		0	1
964	C		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[3]		0	1
965	D		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[4]		0	1
966	F		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[5]		0	1
967	G		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[6]		0	1
968	H		\N		\N	pmod	page066.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[7]		0	1
969	（１）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
970	（２）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
971	（３）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
972	（４）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
973	（５）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
974	（１）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
975	（２）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
976	（３）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
977	（４）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
978	（５）		\N		\N	pmod	page067.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
979	（１）指示：		\N		\N	pmod	page069.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
980	（２）勧誘：		\N		\N	pmod	page069.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
981	（３）不服：		\N		\N	pmod	page069.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
982	（４）共有化：		\N		\N	pmod	page069.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
983	（５）喚起・働きかけ：		\N		\N	pmod	page069.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
984	（１）		\N		\N	pmod	page068.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]		0	1
985	（２）		\N		\N	pmod	page068.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]		0	1
986	（３）		\N		\N	pmod	page068.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]		0	1
987	（４）		\N		\N	pmod	page068.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]		0	1
988	（５）		\N		\N	pmod	page068.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]		0	1
989	（１）平叙文：		\N		\N	pmod	page071.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
990	（２）諾否疑問文：		\N		\N	pmod	page071.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
991	（３）疑問詞疑問文：		\N		\N	pmod	page071.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
992	（４）命令文：		\N		\N	pmod	page071.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
993	（５）感嘆文：		\N		\N	pmod	page071.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
994	（１）		\N		\N	pmod	page070.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
995	（２）		\N		\N	pmod	page070.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]		0	1
996	（３）		\N		\N	pmod	page070.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]		0	1
997	（４）		\N		\N	pmod	page070.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]		0	1
998	（５）		\N		\N	pmod	page070.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]		0	1
999	ເພິ	泥んこの	\N		\N	pmod	page014-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1000	ເຜີ	ぼんやりする	\N		\N	pmod	page014-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1001	ຈັນ	月	\N		\N	pmod	page014-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1002	ຈານ	皿	\N		\N	pmod	page014-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
1003	ຂຶ້ນ	上がる	\N		\N	pmod	page014-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1004	ຂືນ	反抗する	\N		\N	pmod	page014-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1005	ລຶບ	（消しゴムで）消す	\N		\N	pmod	page014-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1006	ລືບ	はがれる，むける	\N		\N	pmod	page014-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
1007	ດຸດ	地面を押して掘る	\N		\N	pmod	page014-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1008	ດູດ	吸う	\N		\N	pmod	page014-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1009	ຄົນ	人	\N		\N	pmod	page014-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1010	ໂຄນ	幹（根元の方）	\N		\N	pmod	page014-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
1011	ເພາະ	なぜならば	\N		\N	pmod	page014-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]		0	1
1012	ພໍ່	父	\N		\N	pmod	page014-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]		0	1
1013	ເມຍ	妻	\N		\N	pmod	page014-4.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1014	ເມືອ	帰る	\N		\N	pmod	page014-4.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1015	ມົວ	薄暗い	\N		\N	pmod	page014-4.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1016	ມັດ	縛る	\N		\N	pmod	page017-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1017	ນັດ	約束する	\N		\N	pmod	page017-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1018	ຍັດ	つめこむ	\N		\N	pmod	page017-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1019	ງັດ	押し開ける	\N		\N	pmod	page017-1.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
1020	ໄຝ	ほくろ	\N		\N	pmod	page017-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1021	ໃສ	透明だ	\N		\N	pmod	page017-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1022	ສີ	色	\N		\N	pmod	page017-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1023	ໄຫ	陶製のつぼ	\N		\N	pmod	page017-2.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
1024	ໄຫຼ	流れる	\N		\N	pmod	page017-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]		0	1
1025	ໄຫວ	できる	\N		\N	pmod	page017-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]		0	1
1026	ວີ	扇子	\N		\N	pmod	page017-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]		0	1
1027	ຢູ່	いる，在る	\N		\N	pmod	page017-3.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]		0	1
1028	ຂ້ອຍຮຽນພາສາອັງກິດ	私は英語を勉強する。	\N	\N	\N	vmod	\N	\N	\N	0	1
1029	ຂ້ອຍຢາກມີຫມູ່ຄົນຕ່າງປະເທດ	私は外国人の友人が欲しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1030	ການນອນແມ່ນການພັກຜ່ອນທີ່ດີ	寝ることは一番いい休みだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1031	ຂໍໃຫ້ເດີນທາງດ້ວຍຄວາມປອດໄພ	どうぞご無事でご旅行を。	\N	\N	\N	vmod	\N	\N	\N	0	1
1032	ລາວໄປທ່ຽວຮອບໂລກ	彼は世界中を旅行した。	\N		\N	vmod	\N	\N	\N	0	1
1033	ຄົນລາວຢູ່ຍີ່ປຸ່ນຈະຈັດງານປີໃໝ່ລາວຢູ່ສະຖານທູດ	日本にいるラオス人は大使館でラオス正月パーティーを行う。	\N		\N	vmod	\N	\N	\N	0	1
1034	ຄົນລາວມັກຕຳໝາກຫຸ່ງຫຼາຍ	ラオス人はパパイヤサラダが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1036	ລາວເວົ້າພາສາລາວບໍ່ເກັ່ງ	彼はラオス語を話すのが下手だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1037	ຄົນຍີ່ປຸ່ນຍ່າງໄວ	日本人は歩くのが速い。	\N		\N	vmod	\N	\N	\N	0	1
1038	ໝູ່ຂອງຂ້ອຍລອຍນ້ຳເກັ່ງ	私の友人は泳ぐのが上手い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1039	ຢາກບິນໄດ້ຄືນົກ	鳥のように飛びたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1040	ຢູ່ເຮືອນລາວມີສະລອຍນ້ຳ	彼の家にはプールがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1041	ລົດຖີບຂອງຂ້ອຍເສຍ	私の自転車がなくなった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1042	ທາງສີ່ແຍກນີ້ມັກມີອຸບັດເຫດ	この交差点はよく事故がある。	\N		\N	vmod	\N	\N	\N	0	1
1043	ຢູ່ໜອງນີ້ມີປາຫຼາຍ	この池には魚が沢山いる。	\N		\N	vmod	\N	\N	\N	0	1
1044	ທຸກເຊົ້າພໍ່ຂ້ອຍຍ່າງຫຼິ້ນ	私のお父さんは毎朝散歩する。	\N		\N	vmod	\N	\N	\N	0	1
1045	ຢູ່ລາວມີແມ່ນ້ຳຫຼາຍ	ラオスには沢山の川がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1046	ເອື້ອຍເມົາລົດຕັກຊີ່	お姉さんがタクシーに酔った。	\N		\N	vmod	\N	\N	\N	0	1
1047	ຂ້ອຍຜູກກາລະວັດບໍ່ເປັນ	私はネクタイを締められない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1048	ເວລາໄປສຳພາດຄວນນຸ່ງເສື້ອເຊີດໄປ	面接に行く時はワイシャツを着て行くべきだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1403	ປີໜ້າຂ້ອຍຊິໄປລາວ	来年私はラオスへ行きます。	\N		\N	vmod	\N	\N	\N	0	1
1049	ພະນັກງານຢູ່ຍີ່ປຸ່ນໃສ່ສູດໄປການ	日本の会社員はスーツを着て仕事に行く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1050	ບໍ່ຄວນສູບຢາຢູ່ຕາມສະຖານທີ່ສາທາລະນະ	公共の場では喫煙すべきでない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1051	ຂໍໃຊ້ໂທລະສັບໄດ້ບໍ່?	電話を使わせていただけますか？	\N		\N	vmod	\N	\N	\N	0	1
1052	ວຽກຫຍຸ້ງຫຼາຍຈົນບໍ່ມີເວລາກິນເຂົ້າ	御飯を食べる時間がないほど仕事がとても忙しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1053	ຫໍສະໝຸດຢູ່ໂຮງຮຽນຂ້ອຍໃຫຍ່ຫຼາຍ	私の学校の図書館はとても大きい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1054	ເອົາເຈ້ຍກັອບປີ້ນີ້ຍື່ນໃຫ້ລາວແດ່	このコピー用紙を彼に渡して下さい。	\N		\N	vmod	\N	\N	\N	0	1
1055	ຂ້ອຍອັດເອກະສານໃຫ້ໝູ່	私は資料を友達にコピーしてあけた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1056	ລາວມັກອ່ານວາລະສານກ່ຽວກັບແຟຊັ່ນ	彼女はファッションに関する雑誌をよく読む。	\N	\N	\N	vmod	\N	\N	\N	0	1
1057	ຂ້ອຍບໍ່ມັກກິນຊີ້ນງົວ	私は牛肉をあまり食べない。	\N		\N	vmod	\N	\N	\N	0	1
1058	ຢູ່ນີ້ມີເຄື່ອງຖືກຫຼາຍ	ここには安い物が沢山ある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1059	ຢໍ່ໍຂາວນີ້ແມ່ນບຸບເຟ່ ສະນັ້ນເອົາຈັກອັນກໍໄດ້	この生春巻きはブッフェ形式なので、いくつとってもよい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1060	ໝາກໄມ້ຢູ່ລາວມີແຕ່ແນວແຊບໆ	ラオスの果物はおいしいものばかりだ。	\N		\N	vmod	\N	\N	\N	0	1
1061	ເຂົ້າແລງມື້ນີ້ ກິນຂົ້ວຊີ້ນໝູດີກວ່າ	今日の夕飯は豚肉の炒めものがいい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1062	ມາຍີ່ປຸ່ນມັກຈະໄດ້ກິນຊີ້ນໄກ່	日本に来てからは鶏肉をよく食べた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1063	ຂ້ອຍຈະຊື້ໝາກແຕງຢູ່ຮ້ານຂາຍຜັກ	私は八百屋できゅうりを買うつもりだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1064	ຂ້ອຍຊັກເຄື່ອງອາທິດໜຶ່ງປະມານ 3 ເທື່ອ 	私は一週間にだいたい３回洗濯する。	\N	\N	\N	vmod	\N	\N	\N	0	1
1065	ໝູ່ຂ້ອຍອະນາໄມຫ້ອງທຸກໆມື້	私の友人は毎日部屋を掃除する。	\N	\N	\N	vmod	\N	\N	\N	0	1
1066	ແມ່ປູກດອກໄມ້ຢູ່ສວນ	母は庭に花を植える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1067	ຂ້ອຍມັກຊັກເຄື່ອງຫຼາຍກວ່າລີດເຄື່ອງ	アイロンより洗濯の方が好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1068	ຖ້າແມ່ນການເຮັດອະນາໄມໄວ້ໃຈລາວໂລດ	掃除なら彼女に任せよう。	\N		\N	vmod	\N	\N	\N	0	1
1069	ອ່ານປຶ້ມແລ້ວໃຫ້ມ້ຽນໄວ້ໃນຕູ້ປຶ້ມເດີ	本を読み終えたら、本棚にしまっておいて下さい。	\N		\N	vmod	\N	\N	\N	0	1
1070	ມີຄອມພິວເຕີຢູ່ເທິງໂຕະ	机の上にコンピューターがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1071	ຄວນມ້ຽນຕັ່ງໃຫ້ເປັນລະບຽບ	椅子をきれいに片付けるべきだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1072	ຫ້ອງນີ້ກວ້າງຫຼາຍ	この部屋はとても広い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1073	ຢູ່ໃນຕູ້ເຢັນມີນ້ຳໝາກໄມ້ຫຼາຍ	冷蔵庫の中にはフルーツジュースがいっぱいある。	\N		\N	vmod	\N	\N	\N	0	1
1074	ກ່ອນກິນເຂົ້າ ຄວນລ້າງມືໃຫ້ສະອາດ	御飯を食べる前に手をきれいに洗うべきだ。	\N		\N	vmod	\N	\N	\N	0	1
1075	ລາວບໍ່ລຶ້ງນອນຕຽງ	彼はベッドで寝ることに慣れていない。	\N		\N	vmod	\N	\N	\N	0	1
1076	ຕອນຍັງນ້ອຍຂ້ອຍມັກຟັງເພງຢູ່ວິທະຍຸ	小さい頃、私はよくラジオで歌を聴いていた。	\N		\N	vmod	\N	\N	\N	0	1
1077	ດຽວນີ້ບໍ່ຄ່ອຍໄດ້ຟັງເທັບ	今はあまりテープを聞かない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1078	ວັນອາທິດຂ້ອຍຕື່ນສວາຍ	日曜日、私は遅く起きる。	\N		\N	vmod	\N	\N	\N	0	1
1079	ໂຕະໜ່ວຍນັ້ນເພແລ້ວໃຊ້ບໍ່ໄດ້	あのテーブルは壊れて使えない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1080	ຖ້າຫຼົງທາງໃຫ້ຖາມຕຳຫຼວດ	道に迷ったらお巡りさんに聞きなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1081	ຂ້ອຍຖາມທາງນຳຕຳຫຼວດ	私は警官に道を聞いた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1082	ຮ້ານຂາຍປຶ້ມນີ້ມີແຜນທີ່ຂາຍບໍ່?	この本屋では、地図を売っていますか？	\N		\N	vmod	\N	\N	\N	0	1
1083	ຢູ່ໃກ້ໆເຮືອນຂ້ອຍ ມີຕະຫຼາດ	私の家のそばには市場がある。	\N		\N	vmod	\N	\N	\N	0	1
1084	ຢູ່ນີ້ຢູ່ໃສ?	ここはどこですか。	\N		\N	vmod	\N	\N	\N	0	1
1085	ເຈົ້າສາມາດກິນນ້ຳໄດ້ຢູ່ຫັ້ນ	あなたはそこで水を飲むことができる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1086	ລາວເຮັດວຽກຢູ່ພຸ້ນ	彼はあそこで仕事をしている。	\N		\N	vmod	\N	\N	\N	0	1
1087	ມື້ອື່ນນັດພົບກັນຢູ່ໜ້າປ້ອມຕຳຫຼວດ	明日交番の前で会う約束をしている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1088	ສາວງາມນັ່ງຢູ່ຂ້າງລາວ ແມ່ນນັກຮ້ອງ	彼の隣に座っているきれいな女の子は歌手です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1089	ຂ້ອຍຟັງເພງທຸກມື້	私は毎日音楽を聴く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1090	ຈົ່ງຂຽນຄຳເຫັນສັ້ນໆໃສ່ເຈ້ຍນີ້	この紙に短いコメントを書いてください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1091	ຫ້ອງນ້ຳຢູ່ທາງຊ້າຍ	トイレは左にあります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1092	ປຶ້ມເລື່ອງນີ້ຍາວໂພດ	この小説は長すぎる。	\N		\N	vmod	\N	\N	\N	0	1
1093	ເປັນຜູ້ຍິງຕ້ອງນັ່ງໃຫ້ຮຽບຮ້ອຍ	女性ならばきちんと座ろう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1096	ຊົ່ວໂມງຕໍ່ໄປຮຽນຢູ່ຫ້ອງຮຽນ 643	次の時間は６４３の教室の授業です。	\N		\N	vmod	\N	\N	\N	0	1
1097	ມື້ຄືນນີ້ໄດ້ຍິນສຽງຄົນຍ່າງໄປມາຢູ່ລະບຽງ	昨夜、廊下を人が行ったり来たりする音が聞こえた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1098	ການຟັງຄຳໂອ້ລົມຈາກຜູ້ອື່ນກໍເປັນການຮຽນຢ່າງໜຶ່ງ	他の人の話を聞くことも一種の勉強でもある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1099	ຂ້ອຍມາຍີ່ປຸ່ນໃນນາມນັກສຶກສາຕ່າງປະເທດ	私は留学生として日本に来た。	\N	\N	\N	vmod	\N	\N	\N	0	1
1100	ພັກລະດູຮ້ອນປີນີ້ ຂ້ອຍຈະໄປທ່ຽວຈີນ	今年の夏休みは私は中国に旅行するつもりです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1101	ຈົດຄຳອະທິບາຍຂອງອາຈານໃສ່ປຶ້ມຂຽນ	先生の説明をノートに書きとめておく。	\N	\N	\N	vmod	\N	\N	\N	0	1
1102	ເວລາບໍ່ມີຊົ່ວໂມງຮຽນ ລາວຈະເຮັດວຽກເພີ່ມ	授業が無い時、彼はアルバイトをしている。	\N		\N	vmod	\N	\N	\N	0	1
1103	ຕອນຍັງນ້ອຍລາວເກັ່ງຫັດແຕ່ງ 	小さい頃彼は作文が得意だった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1104	ວິຊານີ້ຈະມີກວດກາທຸກອາທິດ	この授業は毎週テストがあります。	\N		\N	vmod	\N	\N	\N	0	1
1105	ຂ້ອຍເຮັດບົດຝຶກຫັດຄັນຈິທຸກໆມື້	私は毎日、漢字の練習をやっている。	\N		\N	vmod	\N	\N	\N	0	1
1106	ຢາກເກັ່ງຕ້ອງຝຶກຫັດທຸກມື້	上手になりたければ、毎日練習しなければならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1107	ເວລາມີຄຳຖາມໃຫ້ຍົກມືຂຶ້ນ	質問がある時は手を挙げなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1108	ກ່ອນຕອບຄວນຄິດໃຫ້ຄັກແນ່	答える前によく考えるべきだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1109	ຕ້ອງຖູແຂ້ວຢ່າງໜ້ອຍບໍ່ຕຳ່ກວ່າ 2 ເທື່ອຕໍ່ມື້	毎日最低2回は歯磨きしなければならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1110	ຂ້ອຍຈະຄິດຮອດບ້ານຫຼາຍເວລາເຈັບປ່ວຍ	病気の時、私は故郷がとても恋しくなる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1111	ປາທອງທີ່ເອື້ອຍລ້ຽງໄວ້ຕາຍແລ້ວ	姉が飼っていた金魚が死んだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1112	ລາວເປັນຫວັດເລີຍສຽງແຫບ	彼は風邪なので声がかすれている。	\N		\N	vmod	\N	\N	\N	0	1
1113	ເຂົາເຈົ້າກິນຕຳໝາກຫຸ່ງຫຼາຍ ເລີຍເຈັບທ້ອງ	彼らはパパイヤサラダを食べ過ぎてお腹が痛い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1114	ນ້ຳຟົດຢູ່ອຸນຫະພູມ 100 ອົງສາເຊ	水は１００℃で沸騰する。	\N		\N	vmod	\N	\N	\N	0	1
1115	ລິບບໍ່ມາຈັກເທື່ອ 	エレベーターが全く来ない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1116	ໝູ່ຂ້ອຍຊື້ປີ້ຄອນເສີດໃຫ້	私の友人がコンサートのチケットを買ってくれた。	\N		\N	vmod	\N	\N	\N	0	1
1117	ຂ້ອຍສວນກັບລາວຕອນລົງຂັ້ນໄດ	私は階段を降りるとき彼女とすれちがった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1118	ບໍ່ມີເວລາແລ້ວ ຂຶ້ນຂັ້ນໄດເອົາດີກວ່າ	時間がないので、階段を上る方がよい。	\N		\N	vmod	\N	\N	\N	0	1
1119	ອັດປະຕູໃຫ້ແດ່	ドアを閉めてください。	\N		\N	vmod	\N	\N	\N	0	1
1120	ຂ້ອຍຈະໄປສົ່ງເຈົ້າຮອດສະຖານີ	私があなたを駅まで送っていく。	\N		\N	vmod	\N	\N	\N	0	1
1121	ຂ້ອຍບໍ່ຄ່ອຍໄດ້ນັ່ງລົດໄຟໃຕ້ດິນ	私はあまり地下鉄に乗らない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1122	ລາວເຮັດເງິນເຮ່ຍ ຕອນກຳລັງຈະຂຶ້ນລົດເມ	彼女はバスに乗ろうとした時にお金を落とした。	\N		\N	vmod	\N	\N	\N	0	1
1123	ຢູ່ຍີ່ປຸ່ນໄປໃສກໍມີຫ້ອງນ້ຳ ຈຶ່ງສະດວກ	日本ではどこに行ってもお手洗いがあり、便利です。	\N		\N	vmod	\N	\N	\N	0	1
1124	ຫ້ອງນ້ຳຢູ່ໃສ?	トイレはどこですか？	\N	\N	\N	vmod	\N	\N	\N	0	1
1125	ຢູ່ລາວຍັງບໍ່ມີລົດໄຟຟ້າ	ラオスにはまだ電車がない。	\N		\N	vmod	\N	\N	\N	0	1
1126	ລາວລືມເຄື່ອງດື່ມຢູ່ເທິງລົດເມ	彼はバスに飲み物を忘れた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1127	ຂ້ອຍມັກກ່ິນກາເຟແຕ່ກິນບໍ່ໄດ້	私はコーヒーの香りが好きだが飲めない。	\N		\N	vmod	\N	\N	\N	0	1
1128	ສາມາດສັ່ງກະແລ້ມໄດ້ຢູ່ຮ້ານກິນດື່ມນີ້	この喫茶店でアイスクリームを注文することができる。	\N		\N	vmod	\N	\N	\N	0	1
1129	ລະດູຝົນໝາກນາວລາຄາຖືກ	雨季はレモンの値段が安い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1130	ກິນນົມທຸກມື້ຈະດີຕໍ່ສຸຂະພາບ	毎日牛乳を飲むと健康にいい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1131	ພໍ່ມັກກິນກາເຟບໍ່ໃສ່ນ້ຳຕານ	父は砂糖を入れていないコーヒーを飲むのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1135	ຄວນດື່ມນ້ຳຢ່າງໜ້ອຍມື້ລະ 8 ຈອກ	１日少なくとも８杯水を飲むべきだ。	\N		\N	vmod	\N	\N	\N	0	1
1136	ຂ້ອຍໃຊ້ໄມ້ຖູ່ບໍ່ເກັ່ງ	私は箸を使うのが下手です。	\N		\N	vmod	\N	\N	\N	0	1
1137	ຜູ້ທີ່ອາຍຸບໍ່ເຖິງ 20 ປີ ບໍ່ຄວນດື່ມເຫຼົ້າ	２０歳未満の人は酒を飲むべきではない。	\N		\N	vmod	\N	\N	\N	0	1
1138	ເວລາກິນເຄັກໃຊ້ສ້ອມຈະດີກວ່າ	ケーキを食べる時はフォークを使った方がいい。	\N		\N	vmod	\N	\N	\N	0	1
1139	ຂ້ອຍບໍ່ມັກເນີຍແຂງ	私はチーズが嫌いだ。	\N		\N	vmod	\N	\N	\N	0	1
1140	ອາຫານນີ້ບໍ່ແຊບເລີຍ	この料理はまずい（全然おいしくない）。	\N		\N	vmod	\N	\N	\N	0	1
1141	ເຂົ້າຈີ່ຢູ່ລາວແຊບຫຼາຍ	ラオスのパンはとてもおいしい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1142	ຂ້ອຍເຮັດວຽກພິເສດຢູ່ຮ້ານອາຫານໄດ້ 5 ປີ	私は５年間レストランでバイトをしている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1143	ໂຮງອາຫານຂອງໂຮງຮຽນທັງແຊບທັງຖືກ	学校の食堂は美味しいし安い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1144	ລາວມັກດື່ມເຫຼົ້າກ່ອນກິນເຂົ້າ	彼は御飯を食べる前によく酒を飲む。	\N	\N	\N	vmod	\N	\N	\N	0	1
1145	ຢູ່ຍີ່ປຸ່ນເຄື່ອງກິນແພງຫຼາຍ	日本は食べ物がとても高い。	\N		\N	vmod	\N	\N	\N	0	1
1146	ລາວບໍ່ເຄີຍກິນແກງກະຫຼີ່ຂອງຍີ່ປຸ່ນ	彼はまだ日本のカレーを食べたことがない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1147	ທະນາຄານປິດຕອນ 3 ໂມງແລງ	銀行は午後3時に閉まる。	\N		\N	vmod	\N	\N	\N	0	1
1148	ທາງນີ້ບໍ່ແມ່ນທາງເຂົ້າ	こちらは入り口ではありません。	\N		\N	vmod	\N	\N	\N	0	1
1150	ຂ້ອຍຫາທາງອອກບໍ່ເຫັນ	私は出口を探したけれど見つからなかった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1151	ຈັກໃຜເອົາເງິນມາເຊື່ອງໄວ້ໃນຕູ້ໄປສະນີ	いったい誰がポストにお金を隠しておいたんだろう。	\N		\N	vmod	\N	\N	\N	0	1
1152	ທຸກເດືອນຂ້ອຍສົ່ງໂປດສະກາດໃຫ້ໝູ່	毎月、私は友人にはがきを出します。	\N		\N	vmod	\N	\N	\N	0	1
1153	ຂ້ອຍຢາກໄດ້ຊອງໃຫຍ່ 	私は大きい封筒が欲しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1154	ໄປສະນີຢູ່ໃກ້ໆນີ້ຍ່າງໄປ 10 ນາທີກໍຮອດ	最寄りの郵便局は歩いて10分で着く。	\N		\N	vmod	\N	\N	\N	0	1
1155	ຂ້ອຍລືມຄືນປຶ້ມໃຫ້ຫໍສະໝຸດ	私は本を図書館に返すのを忘れていた。	\N		\N	vmod	\N	\N	\N	0	1
1156	ການສະສົມສະແຕັມແມ່ນງານອະດິເຫຼກຂອງລາວ	切手収集は、彼の趣味である。	\N	\N	\N	vmod	\N	\N	\N	0	1
1157	ຂ້ອຍເອົາລົດຖີບໃຫ້ລາວຢືມ	私は彼女に自転車を貸した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1158	ແດດກ້າຫຼາຍ ໃສ່ໝວກດີກວ່າ	日光が強いので、帽子をかぶる方がよい。	\N		\N	vmod	\N	\N	\N	0	1
1159	ເກີບແພງໆບໍ່ແມ່ນວ່າຈະໃສ່ສະບາຍສະເໝີໄປ	高い靴がいつもはきやすいとは限らない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1160	ຖ້າວ່າມີຮ້ານສັບພະສິນຄ້າຢູ່ໃກ້ໆນີ້ຄົງຈະດີ	もし近くにデパートがあったらきっといいのに。	\N		\N	vmod	\N	\N	\N	0	1
1161	ລາວມັກນຸ່ງກະໂປ່ງ	彼女はよくスカートをはく。	\N		\N	vmod	\N	\N	\N	0	1
1162	ເສື້ອຄຸມຢູ່ຍີ່ປຸ່ນແພງແຕ່ມີຄຸນນະພາບດີ	日本のコートは高いけれど、品質がよい。	\N		\N	vmod	\N	\N	\N	0	1
1163	ມື້ນີ້ຄັນຊິຊັກເຄື່ອງເອົາໂສ້ງຂອງພໍ່ໄປຊັກນຳ	今日、もし洗濯するならば、お父さんのズボンも一緒に洗って。	\N		\N	vmod	\N	\N	\N	0	1
1164	ເສື້ອແລນໂຕນີ້ທັງງາມທັງອຸ່ນ	このセーターはきれいで暖かい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1165	ເຈົ້າມີກະເປົາງາມຫຼາຍໜ່ວຍນໍ	あなたはきれいなかばんを沢山持っていますね。	\N	\N	\N	vmod	\N	\N	\N	0	1
1166	ຂ້ອຍເຄີຍໄປຂາຍໝາກມ່ວງຢູ່ຕະຫຼາດ	私はマンゴーを市場に売りに行ったことがある。	\N		\N	vmod	\N	\N	\N	0	1
1167	ລາວນຸ່ງເສື້ອຈັກເກັດໂຕນີ້ເຮັດໃຫ້ລາວເຈົ້າຊູ້ຂຶ້ນ	彼はこの上着を着たらハンサムになった。	\N		\N	vmod	\N	\N	\N	0	1
1168	ເຮືອນທີ່ຂ້ອຍເຊົ່າຢູ່ບໍ່ມີອ່າງອາບນ້ຳ	私が借りている家には風呂が無い。	\N		\N	vmod	\N	\N	\N	0	1
1169	ຢູ່ຍີ່ປຸ່ນມີຕຶກສູງຫຼາຍ	日本には高い建物が沢山ある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1170	ຂ້ອຍຢາກໄດ້ຫ້ອງແຕ່ງກິນກວ້າງໆ	私はとても広い台所がほしい。	\N		\N	vmod	\N	\N	\N	0	1
1171	ເຖິງວ່າຈະບໍ່ມີອ່າງອາບນ້ຳມີນ້ຳຝັກບົວກໍພໍແລ້ວ	たとえお風呂がなくても、シャワーがついていればいい。	\N		\N	vmod	\N	\N	\N	0	1
1172	ເບິ່ງຈາກປ່ອງຢ້ຽມນີ້ ສາມາດເຫັນພູຟູຈິ	この窓から富士山が見える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1173	ຂ້ອຍແລະໝູ່ມັກໄປເບິ່ງດອກຊະກຸລະຢູ່ສວນສາທາລະນະ	私と友達は、公園に桜を観にいくのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1174	ນ້ອງຊາຍຂອງຂ້ອຍອາບນ້ຳແລ້ວຈຶ່ງກິນເຂົ້າແລງທຸກມື້	私の弟は毎日ひと風呂浴びてから夕飯を食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1175	ຂ້ອຍເຊົ່າເຮືອນຊຸດຢູ່ກັບໝູ່ຄົນລາວ 4 ຄົນ	私はラオス人の友人４人とアパートを借りている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1176	ໄດ້ຍິນສຽງໃຜມາຢູ່ໜ້າບ້ານ	玄関に誰か来た音が聞こえた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1177	ໄຂປະຕູເບິ່ງດຸວ່າຜູ້ໃດມາ	どなたが来たか、ドアを開けてみて。	\N		\N	vmod	\N	\N	\N	0	1
1178	ຂ້ອຍບໍ່ຄິດເລີຍວ່າລາວຈະເປັນຄົນແນວນີ້	私は彼がこんな人だとは全く思わなかった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1179	ຄົນໃນສັງຄົມປັດຈຸບັນມັກຄິດເຫັນຜົນປະໂຫຍດຂອງຕົວເອງ	現代社会の人々は、自分の利益を考えがちだ。	\N		\N	vmod	\N	\N	\N	0	1
1181	ປຶ້ມໜາຄືແນວນີ້ໃຜຊິອ່ານໝົດໃນມື້ດຽວ	このような分厚い本を誰が一日で読み終えるだろうか。	\N		\N	vmod	\N	\N	\N	0	1
1182	ທາງແຄບຄວນຂັບລົດຢ່າງລະມັດລະວັງ	狭い道は気をつけて運転しなければいけない。	\N		\N	vmod	\N	\N	\N	0	1
1183	ຄົນຕຸ້ຍມັກນຸ່ງເສື້ອຫຼົມ	太っている人は、ゆるい洋服を着るのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1184	ຕອນຍັງໜຸ່ມ ຕ້ອງເຮັດວຽກຫຼາຍເພື່ອເກັບເງິນ	まだ若いころは、貯金するためにたくさん働かなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1185	ເຮືອນເຈົ້າເບິ່ງທາງນອກຄືວ່ານ້ອຍ ແຕ່ທາງໃນກວ້າງຫຼາຍ	あなたの家は見た目は小さいが、中はとても広い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1186	ກະເປົານີ້ເບິ່ງຄືໃຫຍ່ແຕ່ເບົາ	このかばんは大きく見えるが軽い。	\N		\N	vmod	\N	\N	\N	0	1
1187	ພັບໃຫ້ນ້ອຍເທົ່າທີ່ສາມາດພັບໄດ້	できるだけ小さく折ってください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1188	ເຖິງຈະເກົ່າແຕ່ຍັງໃຊ້ໄດ້ດີຢູ່	古いけれども、まだよく使える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1189	ຫ້ອງທາງຂ້າງມັກເຮັດອຶກກະທຶກ	隣の部屋はしょっちゅうにぎやかだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1190	ຢູ່ຊົນນະບົດມີແຕ່ຕຶກຕຳ່ໆ	田舎は低い建物ばかりだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1191	ເວລາເບິ່ງໂທລະທັດ ຄວນເບິ່ງຢູ່ບ່ອນແຈ້ງ	テレビを見る時は明るい場所で見るべきだ。	\N		\N	vmod	\N	\N	\N	0	1
1192	ໄຟອ່ອນລົງແລ້ວ	火が弱くなった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1193	ຄົນຕຸ້ຍບໍ່ແຂງແຮງສະເໝີໄປ	太っている人がいつも強いとはいえない。	\N		\N	vmod	\N	\N	\N	0	1
1194	ລາວມາຊ້າຕະຫຼອດ	彼はいつも遅く来る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1195	ລາວຢ້ານບ່ອນມືດ	彼は暗い所が怖い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1196	ເຮັດຫຍັງມາຄືເຄື່ອງເປື້ອນແທ້?	何をしたらこんなに服が汚くなるの？	\N		\N	vmod	\N	\N	\N	0	1
1197	ຂ້ອຍບໍ່ລຶ້ງຂຽນທາງຂວາງ	私は横書きに慣れていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1198	ຕາເວັນຂຶ້ນທາງທິດຕາເວັນອອກ	太陽は東から昇る。	\N		\N	vmod	\N	\N	\N	0	1
1199	ປຶ້ມຍີ່ປຸ່ນສ່ວນຫຼາຍຂຽນທາງຕັ້ງ	大部分の日本語の本は縦書きだ。	\N		\N	vmod	\N	\N	\N	0	1
1200	ຫ້ອງນີ້ປິ່ນໜ້າໄປທາງທິດເໜືອ	この部屋は北向きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1201	ປະເທດໄທຕັ້ງຢູ່ທິດຕາເວັນຕົກຂອງລາວ	タイはラオスの西に位置している。	\N		\N	vmod	\N	\N	\N	0	1
1203	ທິດໃຕ້ຂອງລາວຕິດກັບກຳປູເຈຍ	ラオスの南はカンボジアに接している。	\N		\N	vmod	\N	\N	\N	0	1
1204	ຂ້ອຍສະໜິດກັບລູກເອື້ອຍລູກນ້ອງທາງແມ່ຫຼາຍກວ່າທາງພໍ່	私は父方より母方のいとことの方が親しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1205	ເປັນອ້າຍນ້ອງກັນຕ້ອງຮັກແພງແລະຊ່ອຍເຫຼືອກັນ	兄弟ならば、信じあい、助け合わなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1206	ສອງເອື້ອຍນ້ອງຄູ່ນີ້ບໍ່ຄ່ອຍຖືກກັນ	この２人姉妹はあまり仲がよくない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1207	ຕອນໄປຮຽນຢູ່ວຽງຈັນ ຂ້ອຍຢູ່ເຮືອນປ້າຂອງຂ້ອຍ	ヴィエンチャンで勉強していたときは、私は伯母の家にいた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1209	ແກ້ເຄື່ອງແລ້ວໄປອາບນ້ຳ	服を脱いでシャワーを浴びに行く。	\N		\N	vmod	\N	\N	\N	0	1
1210	ເຈົ້ານຸ່ງໂສ້ງຄືກວ່ານຸ່ງກະໂປ່ງ	あなたはスカートよりもズボンをはいた方が似合う。	\N		\N	vmod	\N	\N	\N	0	1
1211	ຂ້ອຍບໍ່ຮູ້ວ່າຊິນຸ່ງຫຍັງໄປງານແຕ່ງດອງຂອງລຸ້ນເອື້ອຍ	私は、先輩の結婚式に何を着ていったらいいか、わからない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1212	ເຈົ້າມີແພມົນຫຼາຍໃຫ້ຂ້ອຍແດ່ຈັກຜືນ	あなたはハンカチをたくさん持っているから、私に少しちょうだい。	\N		\N	vmod	\N	\N	\N	0	1
1213	ຍາມຮ້ອນໃສ່ເກີບແຕະສະບາຍ	夏はサンダルをはくと気持ちいい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1214	ຂ້ອຍບໍ່ໄດ້ເອົາຄັນຮົ່ມມາ	私は傘を持ってこなかった。	\N		\N	vmod	\N	\N	\N	0	1
1215	ໂທລະສັບມືຖືຢູ່ໃນຖົງ	携帯電話はポケットの中です。	\N		\N	vmod	\N	\N	\N	0	1
1216	ລາວຕິດຮູບແຟນລາວໃສ່ກະເປົາເງິນ	彼女は財布の中に恋人の写真を貼っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1217	ຜູ້ຍິງທີ່ນຸ່ງຊຸດສີບົວນັ້ນແມ່ນອາຈານຂ້ອຍ	あのピンクのドレスを着ている女性が私の先生です。	\N		\N	vmod	\N	\N	\N	0	1
1218	ລຸ້ນເອື້ອຍຂ້ອຍມັກຊື້ເຄື່ອງນຸ່ງ	私の先輩は服を買うのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1219	ເຄື່ອງນຸ່ງຫົ່ມເປັນປັດໄຈໜຶ່ງໃນການດຳລົງຊີວິດ	衣服は一つの生活の要素である。	\N		\N	vmod	\N	\N	\N	0	1
1220	ເຈັບແຂນເລີຍຂຽນໜັງສືບໍ່ຄ່ອຍໄດ້	腕が痛いので、文字があまり書けない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1221	ຮ່າງກາຍຂອງຄົນເຮົາແບ່ງເປັນ 3 ພາກສ່ວນໃຫຍ່	我々人間の体は大きく３つに分けることができる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1222	ຍ່າງຫຼາຍເລີຍປວດຂາ	沢山歩いたので、足が痛い。	\N		\N	vmod	\N	\N	\N	0	1
1223	ຕອນກຳລັງຮຽນຢູ່ ຄັນດັງຢາກຈາມ	勉強している時に鼻がかゆくなり、くしゃみをしたくなった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1561	ຊ້າງກຳລັງອາບນ້ຳ	象が水浴びしている。	\N		\N	vmod	\N	\N	\N	0	1
1224	ລາວຫູດີ ເວົ້າຄ່ອຍໆກໍໄດ້ຍິນ 	彼は耳がいいので小さい声で話しても聞こえる。	\N		\N	vmod	\N	\N	\N	0	1
1225	ມື້ວານນີ້ຂ້ອຍກິນເຜັດ ເລີຍເຈັບທ້ອງ	昨日、辛い物を食べたので、おなかが痛かった。	\N		\N	vmod	\N	\N	\N	0	1
1226	ກິນເບີຫຼາຍເຮັດໃຫ້ຕຸ້ຍ	バターをたくさん食べると太る。	\N		\N	vmod	\N	\N	\N	0	1
1227	ຖ້ວຍໃບນີ້ແພງຫຼາຍ ເວລາຈັບຕ້ອງລະວັງໃຫ້ດີ	この茶碗はとても高いので、持つときは注意しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1228	ກິນເຂົ້າໜົມອົມຫຼາຍ ລະວັງເປັນແຂ້ວແມງ	たくさんあめを食べたら虫歯になるから気をつけてね。	\N		\N	vmod	\N	\N	\N	0	1
1229	ມື້ນີ້ກິນເຂົ້າທ່ຽງຢູ່ໂຮງອາຫານຂອງໂຮງຮຽນ	今日は食堂で昼御飯を食べる。	\N		\N	vmod	\N	\N	\N	0	1
1230	ຂ້ອຍມີນັດກິນເຂົ້າແລງກັບໝູ່	私は友人と夕飯を食べる約束がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1231	ໄຂ່ມີຄໍແລັດຊະໂຕລອນສູງ	卵はコレステロールが高い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1232	ຂ້ອຍກິນເຂົ້າເຊົ້າກ່ອນໄປໂຮງຮຽນທຸກມື້	私は毎日学校へ行く前に朝御飯を食べる。	\N		\N	vmod	\N	\N	\N	0	1
1233	ເວລາກິນປາດິບບໍ່ຈ້ຳນ້ຳສະອິ້ວ ບໍ່ແຊບ	刺身を食べるとき、醤油をつけないとおいしくない。	\N		\N	vmod	\N	\N	\N	0	1
1234	ກຳລັງລົດຫຸ່ນຢູ່ ຈຶ່ງບໍ່ກິນເຂົ້າແລງ	ダイエット中なので、晩御飯を食べない。	\N		\N	vmod	\N	\N	\N	0	1
1235	ແກງນີ້ຈາງ ຕື່ມເກືອໃສ່ແດ່ໜ້ອຍໜຶ່ງ	このスープは薄いのでもう少し塩を足してください。	\N		\N	vmod	\N	\N	\N	0	1
1236	ຂ້ອຍກຳລັງທ້ອນເງິນຊື້ກ້ອງຖ່າຍຮູບ	私はカメラを買うために貯金している。	\N	\N	\N	vmod	\N	\N	\N	0	1
1237	ຍາມໜາວຖ້າບໍ່ມີເຕົາຝີງໄຟກໍລຳບາກ	冬はストーブがなければ困る。	\N		\N	vmod	\N	\N	\N	0	1
1238	ໝູ່ຂອງຂ້ອຍມັກສະສົມສໍ	私の友達は鉛筆を集めることが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1239	ລາວສາຍຕາສັ້ນ ແຕ່ບໍ່ຍອມໃສ່ແວ່ນຕາ	彼女は視力が悪いけれど、眼鏡を掛けたがらない。	\N		\N	vmod	\N	\N	\N	0	1
1240	ຢ້ານຟັງຄຳອະທິບາຍບໍ່ທັນ ເລີຍລັກໃຊ້ເຄື່ອງອັດເທັບ	説明が聞き取れないと思ったので、内緒でテープレコーダーを使った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1241	ຊື້ຄອມພິວເຕີຢູ່ຍີ່ປຸ່ນຈະຖືກກວ່າ ແລະທັງມີຫຼາຍແບບໃຫ້ເລືອກອີກ	日本でコンピューターを買った方が安いし、たくさんの種類がある。	\N		\N	vmod	\N	\N	\N	0	1
1242	ຊື້ຟີມມາໃຫ້ແດ່ 2 ກໍ້	２つフィルムを買って来て下さい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1243	ພາກັນໄປຖ່າຍຮູບຢູ່ໜ້າປະຕູໃຫຍ່ກັນເທາະ	門の前で一緒に写真を撮りましょう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1244	ແມ່ຊື້ບິກກ້ານນີ້ໃຫ້ເປັນຂອງຂວັນທີ່ຂ້ອຍເສັງໄດ້	お母さんが私の合格祝いにこのぺんを買ってくれた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1245	ລາວໄດ້ຊື້ປາກກາເປັນຂອງຂວັນວັນເກີດໃຫ້ອ້າຍ	彼は兄への誕生日プレゼントとして万年筆を買った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1246	ຂໍເບິ່ງບິກນັ້ນແດ່	そのボールペンを見せて下さい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1247	ຂ້ອຍຈະໄປຕັ້ງຄ້າຍເດືອນ 8	私は８月、キャンプに行くつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
1248	ຢູ່ຍີ່ປຸ່ນເປີດພາກຮຽນໃໝ່ຕອນເດືອນ 4	日本では４月に新学期が始まる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1249	ຄ່າໄຟຟ້າເດືອນນີ້ຍັງບໍ່ທັນໄດ້ຈ່າຍ	今月の電気料金はまだ払っていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1250	ລາວໄປວັດທຸກເດືອນ	彼は毎月、寺へお参りに行く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1251	ຢູ່ລາວມັກຈັດງານແຕ່ງດອງເດືອນ 12	ラオスでは１２月に結婚式がよく行われる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1252	ຂ້ອຍເກີດເດືອນ 2  	私は２月生まれです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1253	ຂ້ອຍຕ້ອງສົ່ງບົດລາຍງານພາຍໃນເດືອນ 1	私は１月中にレポートを提出しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1254	ທຸກປີເດືອນ 7 ພວກເຮົາຈະໄປຫຼິ້ນທະເລ	毎年７月、私達は海へ遊びに行く。	\N		\N	vmod	\N	\N	\N	0	1
1255	ລະດູຝົນຢູ່ຍີ່ປຸ່ນເລີ່ມແຕ່ເດືອນ 6	日本の梅雨は６月から始まる。	\N		\N	vmod	\N	\N	\N	0	1
1256	ເດືອນໜ້າຂ້ອຍຈະໄປຫຼິ້ນຈີນກັບໝູ່	来月私は友人と中国へ遊びに行くつもりだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1257	ເອື້ອຍສີຈະເກີດລູກເດືອນ 5	シー姉さんは５月に子供を生む予定だ。	\N		\N	vmod	\N	\N	\N	0	1
1258	ຢູ່ຍີ່ປຸ່ນເດືອນ 3 ຍັງໜາວຢູ່	日本では３月はまだ寒い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1259	ຂ້ອຍສົ່ງອີເມວຫາລາວຕັ້ງແຕ່ເດືອນແລ້ວ ແຕ່ຍັງບໍ່ທັນເຫັນລາວຕອບມາເທື່ອ	私は先月、彼にメールを送ったが、返事がまだ来ない。	\N		\N	vmod	\N	\N	\N	0	1
1260	ບຸນໂຮງຮຽນຈະຈັດໃນເດືອນ 11 ຂອງ ທຸກປີ	学園祭は毎年１１月に行われる。	\N		\N	vmod	\N	\N	\N	0	1
1261	ຢູ່ຍີ່ປຸ່ນພາກຮຽນທີ 2 ແມ່ນເລີ່ມແຕ່ເດືອນ 10 	日本では２学期は１０月から始まる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1262	ຢູ່ລາວເດືອນ 9 ຍັງມີຝົນຕົກຫຼາຍຢູ່	ラオスでは９月はまだ雨がたくさん降る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1263	ລາວເຮັດວຽກຫຼາຍ ຈຶ່ງໄດ້ຮັບເງິນຫຼາຍໃນໜຶ່ງເດືອນ	彼はたくさん仕事をしているので、ひと月にたくさん稼ぐ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1264	ທຸກອາທິດຂ້ອຍມາຫຼິ້ນຢູໂດຢູ່ໂຮງຮຽນ	毎週、私は学校で柔道をしている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1265	ວັນພະຫັດເຈົ້າມີຮຽນແຕ່ຊົ່ວໂມງດຽວແມ່ນບໍ່?	木曜日、あなたは授業が一つだけですよね？	\N		\N	vmod	\N	\N	\N	0	1
1266	ຂ້ອຍມີເສັງສຳພາດໃນວັນອັງຄານນີ້	私は今週の火曜日に面接試験がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1267	ຢາກໃຫ້ເຈົ້າມາພົບຂ້ອຍໃນວັນພຸດໜ້າ	次の水曜日に私に会いに来てほしい。	\N		\N	vmod	\N	\N	\N	0	1
1268	ອາທິດແລ້ວໄດ້ຮັບໂທລະສັບຈາກຄົນແປກໜ້າ	先週知らない人から電話がかかってきた。	\N		\N	vmod	\N	\N	\N	0	1
1269	ຂ້ອຍມັກວັນສຸກຫຼາຍທີ່ສຸດ	私は金曜日が一番好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1270	ເມື່ອຮອດລະດູໃບໄມ້ຫຼົ່ນຂ້ອຍມັກຄິດຮອດບ້ານ	秋になると私はよく故郷が恋しくなる。	\N		\N	vmod	\N	\N	\N	0	1
1271	ປີນີ້ຂ້ອຍກໍຈະຮຽນຈົບແລ້ວ	私は今年卒業する予定です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1272	ກັບໄປຢາມບ້ານທຸກປີ	毎年故郷に帰る。	\N		\N	vmod	\N	\N	\N	0	1
1273	ລະດູໜາວຢູ່ຮັອກໄກໂດໜາວຫຼາຍ	北海道の冬はとても寒い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1274	ລາວຫາກໍມາຍີ່ປຸ່ນປີກາຍນີ້ ແຕ່ພາສາຍີ່ປຸ່ນເກັ່ງຫຼາຍ	彼は去年日本に着たばかりだが、日本語がとても上手い。	\N		\N	vmod	\N	\N	\N	0	1
1275	ໃນສີ່ລະດູຂ້ອຍມັກລະດູໃບໄມ້ປົ່ງທີ່ສຸດ	四季の中で春が一番好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1276	ລາວມີແຜນຈະແຕ່ງດອງປິໃນ	彼は再来年結婚する予定だ。	\N		\N	vmod	\N	\N	\N	0	1
1277	ປີກ່ອນຂ້ອຍໄປທ່ຽວໂອກິນາວາ	おととし私は沖縄に旅行に行った。	\N		\N	vmod	\N	\N	\N	0	1
1278	ມື້ຄືນນີ້ຝົນຕົກໜັກຫຼາຍ ຈຶ່ງຢ້ານນ້ຳຖ້ວມ	夕べ、雨がすごく激しく降ったので、洪水にならないかと心配だ。	\N		\N	vmod	\N	\N	\N	0	1
1279	ເຈົ້າຕ້ອງເຮັດວຽກນີ້ໃຫ້ແລ້ວພາຍໃນຕອນເຊົ້າ	あなたは午前中のうちにこの仕事を終わらせなければならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1280	ພັກຕອນທ່ຽງ 12 ໂມງຫາ 1 ໂມງ	１２時から１時までお昼休みです。	\N		\N	vmod	\N	\N	\N	0	1
1281	ບໍ່ຄວນຈະຫຼິ້ນດົນຕີໃນຕອນກາງຄືນ	夜、音楽を演奏するべきではない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1283	ຂ້ອຍພົບລາວມື້ຊືນແຕ່ບໍ່ເຫັນລາວເວົ້າຫຍັງໃຫ້ຟັງ	私はおととい彼に会ったけれども、彼は何も言わなかった。	\N		\N	vmod	\N	\N	\N	0	1
1284	ທັງເຮັດວຽກທັງຮຽນໄປນຳ ເລີຍບໍ່ຄ່ອຍມີເວລາທ່ຽວຫຼິ້ນກັບໝູ່	働きながら勉強しているので、友人と遊ぶ時間がない。	\N		\N	vmod	\N	\N	\N	0	1
1286	ມາຮອດສະຖານີແລ້ວໂທຫາຂ້ອຍທັນທີໂລດເດີ	駅に着いたらすぐに私に電話ください。	\N		\N	vmod	\N	\N	\N	0	1
1287	ໝູ່ຂ້ອຍຊື້ອັນເຂ່ຍຂີ້ກອກຢາໃຫ້ແຟນຂອງລາວ	私の友達は彼女の恋人に灰皿を買ってあげた。	\N		\N	vmod	\N	\N	\N	0	1
1288	ຂ້ອຍຮ້ອງເພງຍີ່ປຸ່ນໄດ້ຫຼາຍກວ່າເພງລາວ	私は日本の歌の方がラオスの歌よりもたくさん歌える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1289	ລາວມັກໄປຮ້ອງເພງຢູ່ຄາລາໂອເກະຄົນດຽວ	彼は一人でカラオケに歌いに行くのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1290	ຫ້າມຂາຍຢາສູບໃຫ້ເດັກນ້ອຍເດັດຂາດ	子供にタバコを絶対売ってはいけない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1291	ລາວມີແຜ່ນສຽງຫຼາຍ ແຕ່ບໍ່ຄ່ອຍໄດ້ຟັງ	彼はレコードをたくさん持っているが、あまり聞かない。	\N		\N	vmod	\N	\N	\N	0	1
1292	ຂ້ອຍຢາກຫຼິ້ນກີຕາເກັ່ງ 	私はギターが上手になりたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1293	ກ່ອນນອນຂ້ອຍມັກຟັງດົນຕີ	私は寝る前によく音楽を聞く。	\N		\N	vmod	\N	\N	\N	0	1
1294	ລາວແຕ້ມຮູບຄືຫຼາຍ ໃຫ້ລາວແຕ້ມຮູບໃຫ້ເຈົ້າແມ້	彼の描く絵はそっくりだ。彼に似顔絵を描いてもらいなさいよ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1295	ເມື່ອເບິ່ງຮູບເກົ່າທີ່ຖ່າຍກັບໝູ່ ກໍພາໃຫ້ຄິດຮອດວັນເກົ່າ	友人と撮った古い写真を見ると、昔の日が思い出される。	\N	\N	\N	vmod	\N	\N	\N	0	1
1296	ສຽງບໍ່ດີແຕ່ມັກຮ້ອງເພງ	声は良くないけど、歌うことは好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1297	ຂ້ອຍຊິຖ້າຢູ່ນອກເດີ	私、外で待ってるね。	\N		\N	vmod	\N	\N	\N	0	1
1298	ໄດ້ຍິນວ່າອາກາດປອດໂປ່ງຕະຫຼອດອາທິດ	一週間ずっと晴天らしい。	\N		\N	vmod	\N	\N	\N	0	1
1299	ຂ້ອຍຢູ່ບ່ອນໜາວບໍ່ໄດ້	私は寒い所に住むことができない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1300	ຫິມະຕົກໜັກເຮັດໃຫ້ການຈະລາຈອນຕິດຂັດ	大雪だったので交通事情が麻痺した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1301	ອາກາດບໍ່ຄ່ອຍດີກັບໄປກິນເຂົ້າຢູ່ເຮືອນດີກວ່າ	天気がそれほど良くないので、帰って家で御飯を食べた方がいい。	\N		\N	vmod	\N	\N	\N	0	1
1302	ເສື້ອຄຸມນີ້ຊົງຊິອຸ່ນນໍ ຊື້ຢູ່ໃສ?	このコートは暖かそうだね、どこで買ったの？	\N		\N	vmod	\N	\N	\N	0	1
1303	ຟ້າບົດບໍ່ຊັກເຄື່ອງດີກວ່າ	曇りなので、洗濯しない方がいい。	\N		\N	vmod	\N	\N	\N	0	1
1304	ຟ້າຄຶ້ມມາແລ້ວຟ້າວກູ້ເຄື່ອງໄວ	空が曇ってきたので、急いで洋服をとり込もう。	\N		\N	vmod	\N	\N	\N	0	1
1305	ເຈົ້າອ່ານຕົວອັກສອນຄັນຈິໄດ້ຫຼາຍນໍ	あなたは漢字が沢山読めますね。	\N		\N	vmod	\N	\N	\N	0	1
1306	ຂ້ອຍບໍ່ເຂົ້າໃຈຄວາມໝາຍຂອງປະໂຫຍກນີ້ປານໃດ 	私はこの文の意味があまりよくわからない。	\N		\N	vmod	\N	\N	\N	0	1
1307	ແມ່ເຖົ້າຂ້ອຍມັກເລົ່ານິທານໃຫ້ຟັງ	私のおばあさんはよく物語を語ってくれた。	\N		\N	vmod	\N	\N	\N	0	1
1308	ຖ້າຂຽນເປັນຕົວອັກສອນຮິລະກະນະໝົດຈະເຂົ້າໃຈຍາກ	もし全部ひらがなで書いたら、わかりにくい。	\N		\N	vmod	\N	\N	\N	0	1
1309	ລາວຍັງຈື່ຕົວອັກສອນຄະຕະກະນະບໍ່ທັນໄດ້ໝົດ	彼はまだカタカナをすべて覚えていない。	\N		\N	vmod	\N	\N	\N	0	1
1310	ຜົວເມຍຜິດຖຽງກັນເປັນເລື່ອງທຳມະດາ	夫婦喧嘩は普通のことだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1311	ລູກຂອງເອື້ອຍຂ້ອຍໜ້າຮັກຫຼາຍ	私の姉の子供はとてもかわいい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1312	ເດັກນ້ອຍຜູ້ຊາຍມັກຫຼິ້ນກິລາ	男の子はスポーツが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1313	ເອົາຕຸກກະຕານີ້ໃຫ້ເດັກນ້ອຍຜູ້ຍິງຄົນນັ້ນ	この人形をあの女の子にあげなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1314	ຜົວຂອງລາວໄປການແຕ່ເຊົ້າທຸກມື້	彼女の夫は毎朝早く仕事に出かける。	\N		\N	vmod	\N	\N	\N	0	1
1315	ໝູ່ຂອງຂ້ອຍທຸກຄົນໃຈດີຫຼາຍ	私の友達はみんなとても親切だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1316	ເສື້ອຢືດສີຂາວຂອງຂ້ອຍຂາດແລ້ວ	私の白いＴシャツが破れてしまった。	\N		\N	vmod	\N	\N	\N	0	1
1318	ເຈົ້ານຸ່ງເຄື່ອງສີອ່ອນຈະຄືກວ່າ	あなたは淡い色の服を着た方が似合う。	\N	\N	\N	vmod	\N	\N	\N	0	1
1319	ຂ້ອຍບໍ່ມີໂສ້ງສີເຫຼືອງຈັກໂຕ	私は黄色のズボンを一本も持っていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1321	ຂ້ອຍຢາກໄດ້ຈັກເກັດສີຂຽວນັ້ນ 	私はその緑色のジャケットがほしい。	\N		\N	vmod	\N	\N	\N	0	1
1322	ຢູ່ຍີ່ປຸ່ນມີຮ້ານຂາຍເຄື່ອງທີ່ເປີດຕະຫຼອດ 24 ຊົ່ວໂມງ 	日本には２４時間開いている店がある。	\N		\N	vmod	\N	\N	\N	0	1
1323	ຂ້ອຍໄດ້ພົບກັບລາວຢູ່ງານລ້ຽງ	私はパーティーで彼に会った。	\N		\N	vmod	\N	\N	\N	0	1
1324	ເຈ້ຍໃກ້ຈະໝົດແລ້ວຊື້ມາເພີ່ມແດ່ເດີ້	紙がなくなりかけているので、買ってたしておいて下さい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1325	ລາວກາຍເປັນຄົນດັງ	彼は有名人になった。	\N		\N	vmod	\N	\N	\N	0	1
1326	ຢ່າຍູ້ກັນ ຈັກໜ້ອຍຊິລົ້ມ	押さないで。倒れちゃうよ。	\N		\N	vmod	\N	\N	\N	0	1
1327	ຂ້ອຍກຳລັງຊິໂທຫາເຈົ້າພໍດີ	私はちょうどあなたに電話するところでした。	\N	\N	\N	vmod	\N	\N	\N	0	1
1328	ຮ້ານອາຫານນີ້ມີຊື່ສຽງທີ່ສຸດໃນຮ່ອມນີ້	このレストランはこの通りで最も有名だ。	\N		\N	vmod	\N	\N	\N	0	1
1329	ລາວເກີດລູກຜູ້ຊາຍທີ່ແຂງແຮງດີ	彼女は元気な男の子を産んだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1330	ມື້ນີ້ກັບບ້ານຈັກໂມງ?	今日は何時に帰宅しますか？	\N		\N	vmod	\N	\N	\N	0	1
1331	ຂ້ອຍຊິໄປໂຮງຮຽນກັບເຈົ້າ	私はあなたと学校に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1332	ເອົາກັບສໍໃຫ້ແດ່	筆箱をとってください。	\N		\N	vmod	\N	\N	\N	0	1
1333	ເສັງໄວຍາກອນມື້ໃດ?	文法のテストはいつですか？	\N		\N	vmod	\N	\N	\N	0	1
1334	ຂ້ອຍຢາກໄດ້ຖົງໃໝ່	私は新しいかばんが欲しい。	\N		\N	vmod	\N	\N	\N	0	1
1335	ຂ້ອຍລືມກະແຈເຮືອນ	私は家の鍵を忘れました。	\N		\N	vmod	\N	\N	\N	0	1
1336	ຂ້ອຍນຸ່ງສະເກິດຄືບໍ່?	私、スカート似合う？	\N		\N	vmod	\N	\N	\N	0	1
1337	ເອົາເກືອໃຫ້ແດ່	塩を取ってください。	\N		\N	vmod	\N	\N	\N	0	1
1338	ນຸ່ງເຄື່ອງສີເຂັ້ມເບິ່ງຄືຈ່ອຍ	濃い色の服を着ると細く見える。	\N		\N	vmod	\N	\N	\N	0	1
1339	ເຮືອນຂ້ອຍໄກຈາກໂຮງຮຽນ	私の家は学校から遠い。	\N		\N	vmod	\N	\N	\N	0	1
1340	ຢ່າໄປຫຼິ້ນໄກຫຼາຍ	遠くに遊びに行っちゃだめよ。	\N		\N	vmod	\N	\N	\N	0	1
1341	ຢູ່ເຮືອນຂ້ອຍມີໄກ່ຫຼາຍ\n	私の家には鶏がたくさんいます。	\N		\N	vmod	\N	\N	\N	0	1
1342	ຢາກກິນປີ້ງໄກ່	焼き鳥が食べたい。	\N		\N	vmod	\N	\N	\N	0	1
1343	ຂ້ອຍຍ່າງຂຶ້ນຂັ້ນໄດທຸກມື້	私は毎日階段を上る。	\N		\N	vmod	\N	\N	\N	0	1
1344	ຢູ່ລາວຂັບລົດເບື້ອງຂວາ	ラオスでは右側通行です。	\N		\N	vmod	\N	\N	\N	0	1
1345	ຢາກຂາງາມຄືນາງແບບ	モデルのようなきれいな足が欲しい。	\N		\N	vmod	\N	\N	\N	0	1
1346	ເຊີນເຂົ້າມາໂລດ	どうぞお入りください。	\N		\N	vmod	\N	\N	\N	0	1
1347	ກິນເຂົ້າສວາຍແລ້ວບໍ?	昼御飯食べた？	\N		\N	vmod	\N	\N	\N	0	1
1348	ແມ່ເຖົ້າຂ້ອຍແຂງແຮງດີ	私のおばあさんは元気だ。	\N		\N	vmod	\N	\N	\N	0	1
1349	ຕອນເຊົ້າມັກກິນຈືນໄຂ່	朝、よく目玉焼きを食べる。	\N		\N	vmod	\N	\N	\N	0	1
1350	ລາວອາດຈະມາຊ້າ	彼女は多分遅れるかもしれない。	\N		\N	vmod	\N	\N	\N	0	1
1351	ທາງນີ້ຄົດຫຼາຍ ລະວັງແດ່ເດີ	この道はとてもカーブが多いので気をつけてください。	\N		\N	vmod	\N	\N	\N	0	1
1352	ຄັນຊັ້ນຂ້ອຍເມືອກ່ອນເດີ	じゃあ私は先に帰りますね。	\N		\N	vmod	\N	\N	\N	0	1
1353	ຄອບຄົວລາວອົບອຸ່ນຫຼາຍ	彼の家庭はとても暖かい。	\N		\N	vmod	\N	\N	\N	0	1
1354	ລາວເກັ່ງຄອມພິວເຕີ	彼はコンピューターが得意だ。	\N		\N	vmod	\N	\N	\N	0	1
1355	ຂໍຊີມແດ່ຄຳໜຶ່ງໄດ້ບໍ່?	一口、味見してもいい？	\N		\N	vmod	\N	\N	\N	0	1
1356	ລາວໄດ້ຮັບຫຼຽນຄຳ	彼は金メダルを獲得した。	\N		\N	vmod	\N	\N	\N	0	1
1357	ຂ້ອຍຈືິ່ຄຳສັບມື້ລະ 5 ຄຳ	私は１日５語ずつ単語を覚える。	\N		\N	vmod	\N	\N	\N	0	1
1358	ຂ້ອຍເອົາເຄື່ອງວາງໄວ້ນີ້ໄດ້ບໍ?	ここに荷物を置いてもいいでしょうか？	\N		\N	vmod	\N	\N	\N	0	1
1361	ລາວຈ່ອຍລົງ	彼女は細くなった。	\N		\N	vmod	\N	\N	\N	0	1
1362	ເອົາຈານໃຫ້ແດ່	お皿をとってください。	\N		\N	vmod	\N	\N	\N	0	1
1363	ໄປຊືື່ໆແລ້ວລ້ຽວຂວາ	まっすぐ行ってから右に曲がる。	\N		\N	vmod	\N	\N	\N	0	1
1364	ຫ້ອງຮຽນຂອງຂ້ອຍຢູ່ຊັ້ນ 3	私の教室は３階にあります。	\N		\N	vmod	\N	\N	\N	0	1
1365	ເຮັດດີເຮັດຍາກ ເຮັດຊົ່ວເຮັດງ່າຍ	善いことを行うのは難しいが、悪いことを行うのは易しい。	\N		\N	vmod	\N	\N	\N	0	1
1366	ກະລຸນາເວົ້າຊ້າໆແດ່	ゆっくり話してください。	\N		\N	vmod	\N	\N	\N	0	1
1367	ຂ້ອຍມັກດື່ມຊາຂຽວຍີ່ປຸ່ນ	私はよく日本の緑茶を飲みます。	\N		\N	vmod	\N	\N	\N	0	1
1368	ຂ້ອຍມັກຊື້ເຄື່ອງ	私は買い物するのが好き。	\N		\N	vmod	\N	\N	\N	0	1
1369	ຂ້ອຍມັກຜູ້ຍິງຜົມຍາວ	僕は髪の長い女性が好き。	\N		\N	vmod	\N	\N	\N	0	1
1370	ຢາກດັງໂມຄືເຈົ້າ	あなたのような高い鼻になりたい。	\N		\N	vmod	\N	\N	\N	0	1
1371	ເອົານ້ຳມາໃຫ້ກິນແດ່	お水持ってきてちょうだい。	\N		\N	vmod	\N	\N	\N	0	1
1372	ເປັນໄຂ້ຕ້ອງກິນຢາ	熱を出したら薬を飲まなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1373	ເດືອນແລ້ວນີ້ຂ້ອຍໄປທ່ຽວກຽວໂຕ	先月私は京都に旅行しに行った。	\N		\N	vmod	\N	\N	\N	0	1
1374	ຂ້ອຍບໍ່ກິນເພາະວ່າຢ້ານຕຸ້ຍ	太るのが心配なので私は食べません。	\N		\N	vmod	\N	\N	\N	0	1
1375	ລາວຕັດຜົມໃໝ່	彼女は髪を切った。	\N		\N	vmod	\N	\N	\N	0	1
1376	ເອົາປະກາດນີ້ໄປຕິດໃຫ້ແດ່	このお知らせを貼ってください。	\N		\N	vmod	\N	\N	\N	0	1
1377	ຕິດສະແຕັມໃສ່ກ່ອນແລ້ວຄ່ອຍສົ່ງເດີ	先に切手を貼ってから出してね。	\N		\N	vmod	\N	\N	\N	0	1
1378	ລາວຢຽບຕີນຂ້ອຍ	彼は私の足を踏んだ。	\N		\N	vmod	\N	\N	\N	0	1
1379	ລາວເປັນຄົນຕະຫຼົກນໍ	彼、おもしろい人だね。	\N		\N	vmod	\N	\N	\N	0	1
1380	ຫຼິ້ນຄອມພິວເຕີຫຼາຍເລີຍເຈັບຕາ	コンピューターをたくさんしたので、目が痛いです。	\N		\N	vmod	\N	\N	\N	0	1
1381	ເອົາເຄື່ອງກິນໃສ່ຕູ້ເຢັນໄວ້ແດ່	食べ物を冷蔵庫に入れておいてください。	\N		\N	vmod	\N	\N	\N	0	1
1382	ຂ້ອຍຢາກເຮັດດ້ວຍຕົນເອງ	私は自分でやりたい。	\N		\N	vmod	\N	\N	\N	0	1
1383	ເລືອກຄຳຕອບທີ່ຖືກຕ້ອງທີ່ສຸດ	最も正しい答えを選びなさい。	\N		\N	vmod	\N	\N	\N	0	1
1384	ຂ້ອຍຢາກໄດ້ຖົງໃໝ່	新しいかばんが欲しい。	\N		\N	vmod	\N	\N	\N	0	1
1385	ຫິວເຂົ້າຈົນທ້ອງຮ້ອງ	おなかが鳴る程おなかがすいた。	\N		\N	vmod	\N	\N	\N	0	1
1386	ຂ້ອຍຢາກເຮັດວຽກຢູ່ສະຖານີໂທລະພາບ	私はテレビ局で働きたい。	\N		\N	vmod	\N	\N	\N	0	1
1387	ຄົນຍີ່ປຸ່ນມັກກິນນ້ຳສະອິ້ວ	日本人はよく醤油を使う。	\N		\N	vmod	\N	\N	\N	0	1
1388	ຂໍນ້ຳຕານແດ່	お砂糖ください。	\N		\N	vmod	\N	\N	\N	0	1
1389	ເຮັດແບບນີ້ບໍ?	こんな風にするの？	\N		\N	vmod	\N	\N	\N	0	1
1390	ຂ້ອຍບໍ່ໄດ້ເວົ້າແບບນັ້ນນ່າ	私そんな風に言ってないのになぁ。	\N		\N	vmod	\N	\N	\N	0	1
1391	ຂ້ອຍແຕ້ມຮູບບໍ່ເກັ່ງ	私は絵を描くのが下手だ。	\N		\N	vmod	\N	\N	\N	0	1
1392	ບໍ່, ຂ້ອຍບໍ່ໄດ້ເຮັດ	いいえ、私はやってません。	\N		\N	vmod	\N	\N	\N	0	1
1393	ຢູ່ແຕ່ເຮືອນບໍ່ມ່ວນ	家にいるばかりでつまらない。	\N		\N	vmod	\N	\N	\N	0	1
1394	ປຶ້ມຫົວນີ້ບາງເນາະ	この本は薄いですね。	\N		\N	vmod	\N	\N	\N	0	1
1395	ບາງເທື່ອຂ້ອຍກໍມາຊ້າ	時々私も遅刻します。	\N		\N	vmod	\N	\N	\N	0	1
1396	ຂ້ອຍມັກກິນເຂົ້າຈີ່ທາເບີ 	私はパンにバターをぬって食べるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1397	ເຈົ້າຢູ່ຫ້ອງເບີໃດ?	あなたは何号室にいるの？	\N		\N	vmod	\N	\N	\N	0	1
1398	ເອົາເຈ້ຍໃຫ້ແດ່ 5 ໃບ	紙を５枚下さい。	\N		\N	vmod	\N	\N	\N	0	1
1399	ຂ້ອຍມັກນັ່ງຢູ່ຂ້າງປ່ອງຢ້ຽມ	私は窓側に座るのが好き。	\N		\N	vmod	\N	\N	\N	0	1
1400	ຄົນຍີ່ປຸ່ນມັກກິນປາ	日本人はよく魚を食べる。	\N		\N	vmod	\N	\N	\N	0	1
1401	ປ້າຂ້ອຍເປັນທ່ານໝໍ	私の伯母は医者です。	\N		\N	vmod	\N	\N	\N	0	1
1402	ອາຫານນີ້ບໍ່ຄ່ອຍຖືກປາກປານໃດ	この料理はあまり口に合わない。	\N		\N	vmod	\N	\N	\N	0	1
1410	ຜູ້ຍິງມັກແຕ່ງຕົວ	女性はオシャレするのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1411	ຜູ້ໃຫຍ່ມັກຄິດວ່າຕົນເອງຖືກສະເໝີ	大人は常に自分が正しいと思いがちだ。	\N		\N	vmod	\N	\N	\N	0	1
1412	ເວລາລົມກັບຜູ້ໃຫຍ່ຕ້ອງເວົ້າສຸພາບ	大人と会話するときは、丁寧に話さなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1413	ພໍ່ເຖົ້າຂ້ອຍຍັງແຂງແຮງ	私のおじいさんはまだ元気だ。	\N		\N	vmod	\N	\N	\N	0	1
1414	ຂ້ອຍມັກຖືກພໍ່ເຖົ້າຮ້າຍ	私はよく祖父に怒られた。	\N		\N	vmod	\N	\N	\N	0	1
1415	ຂ້ອຍອາໄສຢູ່ນຳພໍ່ແມ່	私は両親と一緒に暮らしています。	\N		\N	vmod	\N	\N	\N	0	1
1416	ລາວຮ້ອງເພງມ່ວນຫຼາຍ	彼女はとても歌を歌うのが上手です。	\N		\N	vmod	\N	\N	\N	0	1
1417	ລ້າງມືກ່ອນກິນເຂົ້າ	食事の前に手を洗う。	\N		\N	vmod	\N	\N	\N	0	1
1418	ມັດແໜ້ນໆໃຫ້ແດ່	ちゃんときつく縛ってね	\N		\N	vmod	\N	\N	\N	0	1
1419	ຂ້ອຍມັກສະຖານທີ່ມິດງຽບ	私は静かな場所が好きです。	\N		\N	vmod	\N	\N	\N	0	1
1420	ເປັນຫຍັງຄືມິດແທ້?	何でそんなに静かなの？	\N		\N	vmod	\N	\N	\N	0	1
1421	ລະວັງມີດບາດມື	ナイフで手を切らないように気をつけなさい。	\N		\N	vmod	\N	\N	\N	0	1
1422	ບຸນມື້ວານນີ້ມ່ວນຫຼາຍ	昨日のお祭りはとても楽しかったです。	\N		\N	vmod	\N	\N	\N	0	1
1423	ໄປທ່ຽວມ່ວນບໍ?	旅行楽しかった？	\N		\N	vmod	\N	\N	\N	0	1
1424	ລາວໄດ້ເມຍງາມນໍ	彼はきれい奥さんをもらったねぇ。	\N		\N	vmod	\N	\N	\N	0	1
1425	ຂ້ອຍໂທຫາແມ່ເລື້ອຍໆ	私はしょっちゅうお母さんに電話する。	\N		\N	vmod	\N	\N	\N	0	1
1426	ແມ່ເຖົ້າຂ້ອຍອາຍຸ 99 ປີ	私の祖母は９９歳です。	\N		\N	vmod	\N	\N	\N	0	1
1427	ດຽວນີ້ຈັກໂມງແລ້ວ?	今何時？	\N		\N	vmod	\N	\N	\N	0	1
1428	ໂມງນີ້ງາມນໍ	この時計きれいね。	\N		\N	vmod	\N	\N	\N	0	1
1429	ຂ້ອຍຢາກໄດ້ໂມງໃໝ່	私は新しい時計が欲しい。	\N		\N	vmod	\N	\N	\N	0	1
1430	ໄມ້ຖູ່ຢູ່ໃສ?	お箸どこ？	\N		\N	vmod	\N	\N	\N	0	1
1431	ຢືນເຮັດຫຍັງຢູ່ຫັ້ນ?	そこに立って何してるの？	\N		\N	vmod	\N	\N	\N	0	1
1432	ຂ້ອຍບໍ່ມັກກິນຢາ	私は薬を飲むのが嫌い。	\N		\N	vmod	\N	\N	\N	0	1
1433	ຂໍເບຍເຢັນໆແດ່	冷たいビールをください。	\N		\N	vmod	\N	\N	\N	0	1
1434	ລາວຕ້ອງໄປຊ່ວຍລຸງເຮັດວຽກ	彼はおじさんの仕事を手伝いにいかなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1435	ຂຶ້ນລິບເອົາດີກວ່າ	エレベーターに乗る方がいい。	\N		\N	vmod	\N	\N	\N	0	1
1436	ລຶບກະດານກ່ອນອາຈານມາ	先生が来る前に黒板を消す。	\N		\N	vmod	\N	\N	\N	0	1
1437	ໂອ້! ລົມເຢັນນໍ	ああ、風が涼しいねえ。	\N		\N	vmod	\N	\N	\N	0	1
1438	ມື້ນີ້ບໍ່ມີລົມ	今日は風がない。	\N		\N	vmod	\N	\N	\N	0	1
1439	ຢູ່ອາຊີລະດູຮ້ອນຝົນຕົກຫຼາຍ	アジアでは夏にたくさん雨が降る。	\N		\N	vmod	\N	\N	\N	0	1
1440	ຢູ່ຍີ່ປຸ່ນລະດູໃບໄມ້ຫຼົ່ນ ໃບໄມ້ປ່ຽນເປັນສີແດງ	日本では秋に紅葉する。	\N		\N	vmod	\N	\N	\N	0	1
1441	ກິນເຂົ້າແລ້ວລ້າງຖ້ວຍແດ່ເດີ	ご飯を食べたら茶碗をあらってちょうだいね。	\N		\N	vmod	\N	\N	\N	0	1
1442	ລາວໄປຫຼິ້ນກິລາເລື້ອຍໆ	彼はよく運動しに行った。	\N		\N	vmod	\N	\N	\N	0	1
1443	ຂ້ອຍແລ່ນທຸກເຊົ້າ	私は毎朝走ってます。	\N		\N	vmod	\N	\N	\N	0	1
1444	ທຸກວັນຈັນຕອນເຊົ້າມີປະຊຸມ	毎週月曜の午前中は会議があります。	\N		\N	vmod	\N	\N	\N	0	1
1445	ຂ້ອຍບໍ່ໄປໂຮງຮຽນວັນເສົາ	私は土曜日、学校へは行かない。	\N		\N	vmod	\N	\N	\N	0	1
1446	ພັກແລ້ງແຕ່ຍັງຕ້ອງເຮັດວຽກບ້ານສົ່ງອາຈານ	夏休みなのに先生に提出する宿題をしなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1447	ແຫຼມສໍໃຫ້ຂ້ອຍແດ່	鉛筆を削ってちょうだい。	\N		\N	vmod	\N	\N	\N	0	1
1448	ປຶ້ມແນະນຳຈະສົ່ງໃຫ້ຕາມຫຼັງເດີ	あとで案内書を送りますね。	\N		\N	vmod	\N	\N	\N	0	1
1449	ເປັນຫຍັງຄືນຸ່ງກະໂປ່ງສັ້ນແທ້?	なんでそんなに短いスカートはいてるの？	\N		\N	vmod	\N	\N	\N	0	1
1450	ກະເປົາສີນ້ຳຕານນັ້ນງາມເນາະ	あの茶色いかばんすてきね。	\N		\N	vmod	\N	\N	\N	0	1
1451	ລາວຊື້ລົດສີຟ້າ	彼は青い車を買った。	\N		\N	vmod	\N	\N	\N	0	1
1452	ສອນພາສາຍີ່ປຸ່ນໃຫ້ຂ້ອຍແດ່	私に日本語を教えてください。	\N		\N	vmod	\N	\N	\N	0	1
1453	ຖ້າມີລົດຈັກຄືຊິສະດວກ	もしバイクがあったら便利だろう。	\N		\N	vmod	\N	\N	\N	0	1
1454	ຂ້ອຍຕ້ອງໄປເອົາວີຊາຢູ່ສະຖານທູດ	大使館にビザを取りに行かなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1455	ຕິດສະແຕັມໃສ່ກ່ອນແລ້ວຄ່ອຍສົ່ງເດີ	先に切手を貼ってから出してね。	\N		\N	vmod	\N	\N	\N	0	1
1456	ລາວສາຍຕາສັ້ນ ແຕ່ບໍ່ຍອມໃສ່ແວ່ນຕາ	彼女は視力が悪いけれど、眼鏡をかけたがらない。	\N		\N	vmod	\N	\N	\N	0	1
1457	ປີນີ້ຫິມະຕົກຫຼາຍ	今年はたくさん雪が降った。	\N		\N	vmod	\N	\N	\N	0	1
1458	ມື້ນີ້ຂ້ອຍຢືມປຶ້ມ 3 ຫົວຢູ່ຫໍສະໝຸດ	今日私は図書館で本を３冊借りた。	\N		\N	vmod	\N	\N	\N	0	1
1459	ມື້ນີ້ຂ້ອຍຢືມປຶ້ມ 3 ຫົວຢູ່ຫໍສະໝຸດ	今日私は図書館で本を３冊借りた。	\N		\N	vmod	\N	\N	\N	0	1
1460	ຂ້ອຍຈະກິນເຂົ້າຫຼັງຈາກອາບນ້ຳແລ້ວ	シャワーを浴びた後にご飯を食べます。	\N		\N	vmod	\N	\N	\N	0	1
1461	ລາວຢືນຢູ່ທາງຫຼັງເຈົ້າຫັ້ນນ່າ	彼はあなたの後ろに立っているってば。	\N		\N	vmod	\N	\N	\N	0	1
1462	ມື້ນີ້ຮູ້ສຶກເຈັບຫຼັງເຈັບແອວ	今日はなんだか背中と腰が痛い。	\N		\N	vmod	\N	\N	\N	0	1
1463	ລາວມີເຮືອນ 2 ຫຼັງ	彼女は家を２軒持っている。	\N		\N	vmod	\N	\N	\N	0	1
1464	ກິນເຂົ້ານຳກັນຫຼາຍຄົນຈຶ່ງແຊບ	大勢でご飯を食べるとおいしい。	\N		\N	vmod	\N	\N	\N	0	1
1465	ກິນຫວານຫຼາຍລະວັງຕຸ້ຍໄດ໋	甘いものたくさん食べると太っちゃうよ。	\N		\N	vmod	\N	\N	\N	0	1
1466	ເຮືອນຂ້ອຍມີຫ້ອງນອນ 3 ຫ້ອງ	私の家には寝室が３部屋あります。	\N		\N	vmod	\N	\N	\N	0	1
1467	ລາວກິນເຝີ 2 ຖ້ວຍ	彼はフォーを２杯食べた。	\N		\N	vmod	\N	\N	\N	0	1
1468	ທຸກເຊົ້າ ລາວກິນກາເຟ 1 ຈອກກ່ອນໄປການ	毎朝彼は仕事に行く前にコーヒーを一杯飲む。	\N		\N	vmod	\N	\N	\N	0	1
1469	ຄອບຄົວຂ້ອຍມີ 5 ຄົນ	私の家族は５人家族です。	\N		\N	vmod	\N	\N	\N	0	1
1470	ຢູ່ຫ້ອງຮຽນມີກັບສໍຂາວ 2 ກັບ	教室にはチョーク箱が２箱ある。	\N		\N	vmod	\N	\N	\N	0	1
1471	ເນື້ອທີ່ເທົ່າກັບລວງກວ້າງຄູນລວງຍາວ	面積は縦かける横である。	\N		\N	vmod	\N	\N	\N	0	1
1472	ແທກເບິ່ງລວງຍາວໃຫ້ແດ່	横を測ってみてちょうだい。	\N		\N	vmod	\N	\N	\N	0	1
1473	ຂ້ອຍຮູ້ສຶກເມື່ອຍຫຼາຍ	なんだかとても疲れたなぁ。	\N		\N	vmod	\N	\N	\N	0	1
1474	ອາຫານນີ້ແຊບຫຼາຍ	この料理はとてもおいしい。	\N		\N	vmod	\N	\N	\N	0	1
1475	ໂຕກຽວເປັນເມືອງອຶກກະທຶກ	東京はにぎやかな街だ。	\N		\N	vmod	\N	\N	\N	0	1
1476	ມື້ນີ້ອາກາດອຸ່ນ	今日は暖かい。	\N		\N	vmod	\N	\N	\N	0	1
1477	ເອົາອັນເຂ່ຍຂີ້ກອກຢາໃຫ້ແດ່	灰皿下さい。	\N		\N	vmod	\N	\N	\N	0	1
1478	ມື້ນີ້ຂ້ອຍຊິອອກໄປທ່ຽວກັບໝູ່	今日私は友達と遊びに出かける。	\N		\N	vmod	\N	\N	\N	0	1
1479	ຂໍເບິ່ງເສື້ອສີບົວອ່ອນນັ້ນແດ່	あの薄ピンクのシャツを見せてください。	\N		\N	vmod	\N	\N	\N	0	1
1480	ໄຟອ່ອນລົງແລ້ວ	火が弱くなった。	\N		\N	vmod	\N	\N	\N	0	1
1481	ຂ້ອຍບໍ່ຄິດວ່າລາວຊິເປັນຄົນອ່ອນແອ	私は彼が弱い人だとは思いません。	\N		\N	vmod	\N	\N	\N	0	1
1482	ມື້ນີ້ອາກາດດີ	今日はいい天気だ。	\N		\N	vmod	\N	\N	\N	0	1
1483	ຂ້ອຍຕ້ອງເຮັດວຽກນີ້ໃຫ້ແລ້ວພາຍໃນອາທິດນີ້	私は今週中にこの仕事をしなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1484	ເອື້ອຍແຕ່ງດອງແລ້ວບໍ?	お姉さんは結婚してますか？	\N		\N	vmod	\N	\N	\N	0	1
1485	ອ້າຍຂ້ອຍໄປຮຽນຢູ່ຕ່າງປະເທດ	私のお兄さんは留学してます。	\N		\N	vmod	\N	\N	\N	0	1
1486	ເອົາເອກະສານນີ້ໃຫ້ລາວແດ່	この書類を彼に渡してください。	\N		\N	vmod	\N	\N	\N	0	1
1487	ຂ້ອຍເອົາຂອງຂວັນໃຫ້ລາວ	私は彼にプレゼントをあげた。	\N		\N	vmod	\N	\N	\N	0	1
1488	ຖ່າຍຮູບໃຫ້ຂ້ອຍແດ່	私の写真撮って下さい。	\N		\N	vmod	\N	\N	\N	0	1
1490	ລາວຮ້ອງເພງມ່ວນ	彼女は歌を歌うのが上手だ。	\N		\N	vmod	\N	\N	\N	0	1
1491	ຢູ່ແຖວນີ້ມີຮ້ານຂາຍຜັກບໍ?	この辺に八百屋はありますか？	\N		\N	vmod	\N	\N	\N	0	1
9	ຍັງ.	まだです。			\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1492	ລາວມັກໄປກິນເຂົ້າກັບແຟນຢູ່ຮ້ານອາຫານ	彼女はよく彼氏とレストランに食事をしに行く。	\N		\N	vmod	\N	\N	\N	0	1
1493	ນັກສຶກສາຍີ່ປຸ່ນມັກເຊົ່າເຮືອນຊຸດ	日本の学生はよくアパートを借りる。	\N		\N	vmod	\N	\N	\N	0	1
1494	ລາວຈອງໂຮງແຮມໄວ້ແລ້ວ	彼はホテルを予約しておいた。	\N		\N	vmod	\N	\N	\N	0	1
1495	ກະເປົາເຈົ້າໜັກແທ້	あなたのかばん、ずいぶん重いね。	\N		\N	vmod	\N	\N	\N	0	1
1496	ຄືຊິໜັກນໍ	重そうですね。	\N		\N	vmod	\N	\N	\N	0	1
1497	ລາວມັກເຮັດອາຫານ	彼女はよくご飯を作る。	\N		\N	vmod	\N	\N	\N	0	1
1498	ກະເປົານີ້ເຮັດດ້ວຍໜັງງູ	このカバンは蛇の皮でできている。	\N		\N	vmod	\N	\N	\N	0	1
1499	ເກີບໜັງໃຊ້ທົນ	革靴はながく使える。	\N		\N	vmod	\N	\N	\N	0	1
1500	ເຈົ້າກິນໜ້ອຍນໍ	少ししか食べないね。	\N		\N	vmod	\N	\N	\N	0	1
1502	ຂ້ອຍຫາກໍອ່ານໄດ້ 10 ໜ້າ	私はまだ１０ページしか読んでません。	\N		\N	vmod	\N	\N	\N	0	1
1503	ຢູ່ໜ້າມະຫາວິທະຍາໄລມີຮ້ານອາຫານ	大学の前にはレストランがある。	\N		\N	vmod	\N	\N	\N	0	1
1504	ແມ່ນໃຜກິນໝົດ?	誰が全部食べちゃったの？	\N		\N	vmod	\N	\N	\N	0	1
1505	ເງິນໝົດແລ້ວ 	お金がなくなった。	\N		\N	vmod	\N	\N	\N	0	1
1506	ປີນີ້ໝາກໄມ້ລາຄາແພງຫຼາຍ	今年は果物がとても高い。	\N		\N	vmod	\N	\N	\N	0	1
1507	ຂ້ອຍຢູ່ບ້ານໂພນຕ້ອງ	私はポーントーン村に住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
1508	ມື້ວານນີ້ແດດອອກໝົດມື້	昨日は一日中晴れていた。	\N		\N	vmod	\N	\N	\N	0	1
1509	ມື້ອື່ນຖ້າແດດອອກຊິໄປກິນເຂົ້າປ່າກັບໝູ່	明日もし晴れたら友達とピクニックに行くつもりです。	\N		\N	vmod	\N	\N	\N	0	1
1510	ຢ່າລືມຊັກເຄື່ອງເດີ	洗濯するの忘れないでね。	\N		\N	vmod	\N	\N	\N	0	1
1511	ມື້ນີ້ຟ້າວຫຼາຍເລີຍບໍ່ໄດ້ສະຜົມ	今日はともて疲れたので、髪の毛を洗わなかった。	\N		\N	vmod	\N	\N	\N	0	1
1512	ຂ້ອຍເຊົ່າເຮືອນຢູ່່ກັບໝູ່	私は友達と一緒に家を借りた。	\N		\N	vmod	\N	\N	\N	0	1
1513	ຂ້ອຍຢູ່ຍີ່ປຸ່ນ	私は日本にいます。	\N		\N	vmod	\N	\N	\N	0	1
1514	ລາວຊື້ກ້ອງຖ່າຍຮູບຢູ່ອະກິຮະບາລາ	彼は秋葉原でカメラを買った。	\N		\N	vmod	\N	\N	\N	0	1
1515	ການທ່ອງທ່ຽວແມ່ນທຸລະກິດທີ່ດີອັນໜຶ່ງ	旅行はひとつの良いビジネスだ。	\N		\N	vmod	\N	\N	\N	0	1
1516	ຢູ່ນີ້ໃກ້ກັບສະຖານີບໍ?	ここは駅に近いですか？	\N		\N	vmod	\N	\N	\N	0	1
1517	ເຊີນຮັບປະທານອາຫານ	どうぞお召し上がりください。	\N		\N	vmod	\N	\N	\N	0	1
1518	ກະເປົາເງິນຢູ່ເທິງໂທລະທັດ	財布はテレビの上にある。	\N		\N	vmod	\N	\N	\N	0	1
1519	ຂ້ອຍຢາກເຮັດວຽກຢູ່ບໍລິສັດການຢາ	私は製薬会社で働きたい。	\N		\N	vmod	\N	\N	\N	0	1
1520	ຢ່າລືມເອົາປີ້ໄປນຳເດີ	切符持って行くのを忘れないでね。	\N		\N	vmod	\N	\N	\N	0	1
1521	ແຕ່ລະປະເທດໃຊ້ພາສາຕ່າງກັນ	国によって使う言葉が違う。	\N		\N	vmod	\N	\N	\N	0	1
1522	ຂ້ອຍໄດ້ຮັບແພມົນເປັນຂອງຂວັນ	私はハンカチをプレゼントしてもらった。	\N		\N	vmod	\N	\N	\N	0	1
1523	ເອົານ້ຳມາໃຫ້ກິນແດ່	水を持ってきてちょうだい。	\N		\N	vmod	\N	\N	\N	0	1
1524	ເວລາເຈັບຄໍບໍ່ຄວນກິນນ້ຳເຢັນ	のどが痛いときは冷たい水を飲むべきではない。	\N		\N	vmod	\N	\N	\N	0	1
1525	ຂ້ອຍຢາກຮຽນກົດໝາຍ	私は法律を勉強したい。	\N		\N	vmod	\N	\N	\N	0	1
1526	ເປັນນັກຮຽນຕ້ອງຮຽນໜັງສື	学生なら勉強しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1527	ມາກັບໃຜ?	誰と来たの？	\N		\N	vmod	\N	\N	\N	0	1
1528	ຊິມາມື້ໃດ?	いつ来ますか？	\N		\N	vmod	\N	\N	\N	0	1
1529	ຕອນຍັງນ້ອຍ ແມ່ຂ້ອຍຫວີຜົມໃຫ້ທຸກມື້	幼いころ、私の母は毎日髪をとかしてくれた。	\N		\N	vmod	\N	\N	\N	0	1
1530	ໝູ່ຂ້ອຍຊື້ຫວີໃຫ້	私の友達がくしを買ってくれた。	\N		\N	vmod	\N	\N	\N	0	1
1531	ເຈົ້າມີລົດຈັກບໍ່?	バイク持ってる？	\N		\N	vmod	\N	\N	\N	0	1
1532	ມີໂທລະທັດຢູ່ໃນຫ້ອງນອນ	寝室にテレビがあります。	\N		\N	vmod	\N	\N	\N	0	1
1534	ມີປຶ້ມຢູ່ໃນຖົງ 3 ຫົວ	カバンの中に本が３冊あります。	\N		\N	vmod	\N	\N	\N	0	1
1535	ພູທີ່ສູງທີ່ສຸດໃນໂລກຢູ່ໃສ?	世界で一番高い山はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1536	ຂອງຫວານມື້ນີ້ແມ່ນໝາກໄມ້	今日のデザートは果物です。	\N		\N	vmod	\N	\N	\N	0	1
1537	ຂ້ອຍໄປເບິ່ງໜັງກັບແຟນ	私は恋人と映画を見に行った。	\N		\N	vmod	\N	\N	\N	0	1
1538	ໜັງເລື່ອງນີ້ມື້ໃດຊິສາຍ?	この映画、いつ放映されるの？	\N		\N	vmod	\N	\N	\N	0	1
1539	ລາວອ່ານໜັງສືພິມທຸກມື້	彼は毎日新聞を読む。	\N		\N	vmod	\N	\N	\N	0	1
1540	ມື້ນີ້ບໍ່ມີວຽກບ້ານ	今日は宿題がありません。	\N		\N	vmod	\N	\N	\N	0	1
1541	ລາວແມ່ນລູກເອື້ອຍລູກນ້ອງຂອງຂ້ອຍ	彼女は私のいとこです。	\N		\N	vmod	\N	\N	\N	0	1
1542	ມື້ຄືນນີ້ນອນເດິກ	夕べは夜遅く寝た。	\N		\N	vmod	\N	\N	\N	0	1
1543	ຂ້ອຍກັບມາຍີ່ປຸ່ນມື້ຊືນ	私はおととい日本に帰ってきた。	\N		\N	vmod	\N	\N	\N	0	1
1544	ກະລຸນາລໍຖ້າບຶດໜຶ່ງ	恐れ入りますが、少々お待ちください。	\N		\N	vmod	\N	\N	\N	0	1
1545	ຢາກກິນນ້ຳ	水が飲みたい。	\N		\N	vmod	\N	\N	\N	0	1
1546	ອົງການທ່ອງທ່ຽວແຫ່ງຊາດຢູ່ໃສ?	国立観光局はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1547	ໄປໂຄ້ງທາງພຸ້ນ	あそこで曲がってください。	\N		\N	vmod	\N	\N	\N	0	1
1548	ຂໍຕຳໜາກຫຸ່ງ 3 ຈານ	パパイヤサラダを３皿下さい。	\N		\N	vmod	\N	\N	\N	0	1
1549	ເຈົ້າເວົ້າໄດ້ຈັກພາສາ?	あなたは何ヶ国語話せますか？	\N		\N	vmod	\N	\N	\N	0	1
1550	ແມ່ຂ້ອຍຊື້ຜັກບົ່ວ 2 ມັດ	私の母はネギを２束買った。	\N		\N	vmod	\N	\N	\N	0	1
1551	ເມຍຂ້ອຍເປັນຄົນລາວ	私の妻はラオス人です。	\N		\N	vmod	\N	\N	\N	0	1
1552	ແລ້ວໆບໍ?	もう終わりましたか？	\N		\N	vmod	\N	\N	\N	0	1
1553	ມີວຽກຫຍັງບໍ່?	何か用事ですか？	\N		\N	vmod	\N	\N	\N	0	1
1554	ມື້ນີ້ມີເວລາບໍ່?	今日、時間がありますか？	\N		\N	vmod	\N	\N	\N	0	1
1555	ມື້ນີ້ຄົນບໍ່ຫຼາຍ	今日は人が多くない。	\N		\N	vmod	\N	\N	\N	0	1
1556	ຂ້ອຍບໍ່ຢາກໄປ	僕は行きたくない。	\N		\N	vmod	\N	\N	\N	0	1
1557	ພວກເຂົາບໍ່ເຂົ້າໃຈວ່າຂ້ອຍເວົ້າຫຍັງ	彼らは私が何を話しているのかわからない。	\N		\N	vmod	\N	\N	\N	0	1
1558	ຂ້ອຍຢາກໄປເກັບໃບຊາ	私はお茶の葉を摘みに行きたい。	\N		\N	vmod	\N	\N	\N	0	1
1559	ລາວຫາກໍອອກໄປ	彼はたった今出て行った。	\N		\N	vmod	\N	\N	\N	0	1
1560	ອາກາດຢູ່ລາວຮ້ອນຫຼາຍ	ラオスの気候はとても暑い。	\N		\N	vmod	\N	\N	\N	0	1
1562	ລ້ຽງລູກດ້ວຍນົມແມ່ດີທີ່ສຸດ	お母さんのお乳で子供を育てるのが一番良い。	\N		\N	vmod	\N	\N	\N	0	1
1563	ຂ້ອຍອາຍຸ 28 ປີ	私は２８歳です。	\N		\N	vmod	\N	\N	\N	0	1
1564	ຂ້ອຍຊິໄປຂໍໂທດລາວ	私は彼にあやまりに行くつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
1565	ດຽວນີ້ເຄື່ອງຕ່າງໆຂຶ້ນລາຄາເກືອບທົບເຄິ່ງ	今、いろいろな物の値段が２倍近くに上がっている。	\N		\N	vmod	\N	\N	\N	0	1
1566	ອຸນຫະພູມຫຼຸດລົງເລື້ອຍໆ	気温がどんどん下がっている。	\N		\N	vmod	\N	\N	\N	0	1
1567	ພໍ່ຂ້ອຍເຮັດຕູ້ໃຫ້ຂ້ອຍ	父が私のために棚を作ってくれた。	\N		\N	vmod	\N	\N	\N	0	1
1568	ເຈົ້າຢາກໄດ້ຫຍັງເປັນຂອງຂວັນວັນເກີດ?	誕生日プレゼントに何が欲しい？	\N		\N	vmod	\N	\N	\N	0	1
1569	ນ້ອງຊາຍຂ້ອຍເປັນນັກບິນ	私の弟はパイロットです。	\N		\N	vmod	\N	\N	\N	0	1
1570	ນ້ອງສາວຂອງລາວເປັນອາຈານສອນ	彼の妹は先生です。	\N		\N	vmod	\N	\N	\N	0	1
1571	ຂ້ອຍໄປຫາປາຢູ່ນ້ຳຂອງ	私はメコン河に魚をとりに行きました。	\N		\N	vmod	\N	\N	\N	0	1
1572	ຂ້ອຍຕ້ອງສົ່ງເອກະສານພາຍໃນອາທິດນີ້	私は今週中に書類を提出しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1573	ປາຍທາງຂອງລາວຢູ່ໂອຊາກາ	彼の行き先は大阪だ。	\N		\N	vmod	\N	\N	\N	0	1
1574	ພວກເຮົາເລີກຮຽນເວລາ 6 ໂມງແລງ	私たちは午後６時に授業が終わります。	\N		\N	vmod	\N	\N	\N	0	1
1575	ຄົນຍີ່ປຸ່ນເລີກການ 5 ໂມງ ແຕ່ກັບບ້ານ 9 ໂມງ	日本人は５時に仕事が終わりますが、帰宅するのは９時です。	\N		\N	vmod	\N	\N	\N	0	1
1576	ພວກເຮົາເລີກຮຽນເວລາ 6 ໂມງແລງ	私たちは午後６時に授業が終わります。	\N		\N	vmod	\N	\N	\N	0	1
1577	ປິດວິທະຍຸໃຫ້ແດ່	ラジオを消して下さい。	\N		\N	vmod	\N	\N	\N	0	1
1578	ຖ້າແມ່ນເລື່ອງອະນາໄມ ໄວ້ໃຈລາວໂລດ	掃除なら彼女に任せよう。	\N		\N	vmod	\N	\N	\N	0	1
110	ຢາກໄປຢູ່ …	行きたいけれど。	希望を述べる		\N	dmod	lo10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
199	ຮຽນພາສາທີ່ເຈົ້າບໍ່ສົນໃຈກໍບໍ່ມ່ວນ ແລະກໍໜ້າເບື່ອອີກ	興味のない言語を学んでもつまらないし、飽きるでしょ。	理由を述べる		\N	dmod	lo18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	1
755	練習２　(3)		\N		\N	pmod	page056.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[3]		0	1
1035	ຂ້ອຍແລ່ນຊ້າ	私は走るのが遅い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1202	ເດັກນ້ອຍຫຼິ້ນຢູ່ກ້ອງໂຕະ	子供が机の下で遊んでいる。	\N		\N	vmod	\N	\N	\N	0	1
1501	ລ້າງໜ້າແລ້ວບໍ?	顔洗った？	\N		\N	vmod	\N	\N	\N	0	1
3	ບໍ່ໄດ້ພົບກັນດົນແລ້ວນໍ.	久しぶりですね。	挨拶する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
4	ສະບາຍດີຢູ່ບໍ່?	元気？	挨拶する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
5	ເຈົ້າ, ສະບາຍດີ	はい，元気です。			\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
6	ຊິໄປໃສ?	どこへ行くのですか？	挨拶する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
7	ຊິເມືອບ້ານ.	家へ帰るところです。	予定を述べる		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
8	ກິນເຂົ້າແລ້ວບໍ?	ご飯はもう食べましたか？	挨拶する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
10	ໄປກິນເຝິນຳກັນເນາະ	一緒にフーを食べに行きましょう。	提案する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
11	ຂອບໃຈຫຼາຍໆທີ່ລ້ຽງອາຫານລາວມື້ວານນີ້	昨日はラオス料理をごちそうしてくれてどうもありがとう。	感謝する		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
12	ບໍ່ເປັນຫຍັງ.	どういたしまして。	感謝する		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
13	ແຊບບໍ່?	おいしかったですか？	程度についてたずねる		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
14	ເຈົ້າ, ແຊບຫຼາຍ.	はい、とてもおいしかったです。	程度について述べる		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
15	ບໍ່ເຜັດບໍ?	辛くなかったですか？	程度についてたずねる		\N	dmod	lo02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
26	ສ່ວນຫຼາຍຍັງໃຊ້ຄວາຍໄຖຢູ່.	大体は水牛を使って耕しています。			\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
27	ບໍ່ຄືຢູ່ຍີ່ປຸ່ນເນາະ.	日本とは違うのですね。	比べる		\N	dmod	lo03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
28	ຂໍໂທດ, ເຈົ້າຊື່ຫຍັງ?	失礼ですが、お名前は？	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
29	ຂ້ອຍຊື່ ບຸນມີ	ブンミーと申します。	自己紹介する		\N	dmod	lo04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
124	ໂຕຄັນຈິຍາກຫຼາຍ	漢字はとても難しい。	意見を述べる		\N	dmod	lo11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
159	ແມ່ນບໍ.	そうなの。			\N	dmod	lo15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
183	ຈື່ບໍ່ໄດ້.	覚えてないわ。			\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
184	ລາວເປັນຄົນແນວໃດ?	彼はどんな人ですか？	特徴についてたずねる		\N	dmod	lo17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
253	ເດືອນ 4.	４月だね。			\N	dmod	lo24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
353	ຊັ້ນບໍ?	そうなの？			\N	dmod	lo34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
640	中平調		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]		0	1
913	中平調/・・/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[2]		0	1
914	低降調/oo/		\N		\N	pmod	page064.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]		0	1
1094	ຢືນດົນແລ້ວນັ່ງດີກວ່າ	長い間立ったので、座る方がいい。	\N		\N	vmod	\N	\N	\N	0	1
1095	ຫ້ອງນີ້ມີນັກຮຽນເກັ່ງຫຼາຍຄົນ	このクラスには、優秀な生徒がたくさんいる。	\N		\N	vmod	\N	\N	\N	0	1
1132	ເອົາຈອກໃຫ້ລາວແດ່	彼にカップを取ってあげて。	\N		\N	vmod	\N	\N	\N	0	1
1133	ຊາຝຣັ່ງນີ້ຫອມ	この紅茶はいい香りがする。	\N	\N	\N	vmod	\N	\N	\N	0	1
1134	ຂ້ອຍຈະເຫຍັ້ນນ້ຳໝາກໄມ້ໃສ່ຈອກໄວ້ຖ້າ	私はコップにフルーツジュースを入れて待っています。	\N		\N	vmod	\N	\N	\N	0	1
1149	ເຊີນເຂົ້າມາໂລດ	どうぞお入り下さい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1180	ຢ່າເວົ້າແນວນັ້ນ	そんな風に言うな。	\N		\N	vmod	\N	\N	\N	0	1
1208	ຍາມຮ້ອນບໍ່ຢາກໃສ່ຖົງຕີນ	暑いときは靴下を履きたくない。	\N		\N	vmod	\N	\N	\N	0	1
1282	ຕອນຄຳ່ໄປຕີດອກກັນເທາະ	夕方、バドミントンを一緒にしましょう。	\N		\N	vmod	\N	\N	\N	0	1
1285	ບາງເທື່ອລາວກໍໃຈຮ້າຍ	時々彼だって怒ります。	\N		\N	vmod	\N	\N	\N	0	1
1317	ລາວຍ້ອມຜົມສີນ້ຳຕານ ຂ້ອຍຈົນເກືອບຈື່ລາວບໍ່ໄດ້	彼女は髪の毛を茶色に染めたので、私は彼女がわからなかった。	\N		\N	vmod	\N	\N	\N	0	1
1320	ຂ້ອຍໄດ້ຮັບກຸຫຼາບສີແດງ	私は赤いバラをもらった。	\N		\N	vmod	\N	\N	\N	0	1
1359	ແຟນຂ້ອຍຊື້ສາຍຄໍເງິນໃຫ້ຂ້ອຍ	私の彼氏が銀のネックレスを買ってくれた。	\N		\N	vmod	\N	\N	\N	0	1
1360	ເຈົ້າຊິເອົາຈັກອັນ?	あなたはいくついりますか？	\N		\N	vmod	\N	\N	\N	0	1
1	ສະບາຍດີ, ແສງ.	セーンさん，こんにちは。	挨拶する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2	ສະບາຍດີ. 	こんにちは。	挨拶する		\N	dmod	lo01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1404	ເປີດໄຟໃຫ້ແດ່	電気をつけてください。	\N		\N	vmod	\N	\N	\N	0	1
1405	ແມ່ນໃຜເປີດປະຕູໄວ້?	誰がドア開けっぱなしにしたの？	\N		\N	vmod	\N	\N	\N	0	1
1406	ເປັນແນວໃດ? ແຊບບໍ່?	どうですか？おいしいですか？	\N		\N	vmod	\N	\N	\N	0	1
1407	ໄປທ່ຽວຮັອກໄກໂດ, ເປັນຈັ່ງໃດ?	北海道旅行はどうでしたか？	\N		\N	vmod	\N	\N	\N	0	1
1408	ເຈົ້າມັກຜູ້ໃດ?	あなたはどの人が好き？	\N		\N	vmod	\N	\N	\N	0	1
1409	ຂ້ອຍກິນຂົ້ວຜັກລວມມິດ	私は野菜炒めを食べます。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: lo
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	1	行く	1	1
2	2	英語	1	1
3	3	飛行機	1	1
4	4	外国	1	1
5	5	外国人	1	1
6	6	ラオス語	1	1
7	7	ホテル	1	1
8	8	日本語	1	1
9	9	出かける	1	1
10	10	国（くに）	1	1
11	11	会う	1	1
12	12	休み、休む（ພັກも同じ意味）	1	1
13	13	旅行\n（ເດີນທາງも同じ意味）	1	1
14	14	旅行、旅行する\n（ທ່ອງທ່ຽວ, ເດີນທາງも同じ意味）	1	1
15	15	遊ぶ	1	1
16	16	大使館	1	1
17	17	大好きだ	1	1
18	18	好き	1	0
19	19	上手（じょうず）	1	1
20	20	走る	1	1
21	21	ゆっくり	1	0
22	22	下手（へた）	1	1
23	23	歩く	1	1
24	24	泳ぐ	1	1
25	25	速い（速度）	1	1
26	26	飛ぶ	1	1
27	27	スポーツ、運動	1	1
28	28	嫌い	1	1
29	29	プール	1	1
30	30	バス	1	1
31	31	自転車	1	1
32	32	交差点	1	1
33	33	道（みち）（ຫົນທາງ, ຖະໜົນも同じ意味）	1	1
34	34	池	1	1
35	35	散歩する	1	1
36	36	かわ（川・河）（ນ້ຳ（～川））	1	1
37	37	タクシー	1	1
38	38	自動車、車（くるま）	1	1
39	39	曲がる（ໂຄ້ງも同じ意味）	1	1
40	40	ネクタイ	1	1
41	41	ワイシャツ	1	1
42	42	会社	1	1
43	43	背広	1	1
44	44	する	1	1
45	45	吸う（ດູດも同じ意味）	1	1
46	46	電話	1	1
47	47	仕事	1	1
48	48	働く・勤める	1	1
49	49	忙しい\n（ຄາວຽກも同じ意味）	1	1
50	50	図書館	1	1
51	51	辞書，字引	1	1
52	52	借りる\n（賃借の場合はເຊົ່າ）	1	1
53	53	新聞	1	1
54	54	読む	1	1
55	55	本	1	1
56	56	コピー （ອັດເອກະສານ ともいう）	1	1
57	57	コピーする	1	1
58	58	雑誌	1	1
59	59	～冊、～個（本、根菜類の類別詞）	2	1
60	60	牛肉	1	1
61	61	安い	1	1
62	62	店	1	1
63	63	（値段が）高い	1	1
64	64	いくつの～、幾～	1	1
65	65	いくら、いくつ	1	1
66	66	果物	1	1
67	67	野菜	1	1
68	68	魚	1	1
69	69	豚肉	1	1
70	70	鶏肉	1	1
71	71	肉	1	1
72	72	欲しい	1	1
73	73	渡す	2	0
74	74	八百屋	1	1
75	75	かぎ（鍵）	1	1
76	76	料理	1	1
77	77	買い物、買い物する	1	1
78	78	洗濯、洗濯する	1	1
79	79	掃除する、掃除	1	1
80	80	家族	2	1
81	80	家庭	1	1
82	81	庭（にわ）	1	1
83	78	洗濯	1	0
84	82	うち（家）	1	1
85	82	家（いえ）	1	1
86	83	掃除	1	1
87	84	帰る\n（ກັບບ້ານ, ກັບເມືອ, ເມືອບ້ານ, ເມືອも同じ意味）	1	1
88	85	本棚	1	1
89	86	机	1	1
90	87	椅子（いす）（ຕັ່ງອີ້も同じ意味）	1	1
91	88	部屋	2	1
92	89	冷蔵庫	1	1
93	90	洗う\n（ຊັກ(衣服), ສະ(髪)）	1	1
94	91	ベッド	1	1
95	92	ラジオ	1	1
96	93	テープ	1	1
97	94	名前	1	1
98	95	寝る	1	1
99	96	起きる（ຕື່ນນອນも同じ意味）	1	1
100	86	テーブル	1	1
101	97	テレビ\n（ໂທລະພາບも同じ意味）	1	1
102	98	お巡りさん	1	1
103	98	警官	1	1
104	99	地図	1	1
105	100	そば	1	1
106	101	ここ,こちら, こっち	1	1
107	102	そこ,そちら, そっち	1	1
108	103	あそこ,あちら, あっち	1	1
109	104	どこ,どちら,どっち	1	1
110	105	交番	1	1
111	106	近く	1	0
112	107	隣	1	1
113	108	聞く、聴く	1	1
114	109	切る	1	1
115	110	短い	1	1
116	111	後ろ	1	1
117	112	～ページ（ページの類別詞）	3	1
118	113	右	1	1
119	114	左	1	1
120	115	長い	1	1
121	116	座る	1	1
122	117	立つ	1	1
123	118	友達	1	1
124	88	クラス	1	1
125	119	教室	1	1
126	120	廊下	1	1
127	121	学校	1	1
128	122	生徒	1	1
129	123	勉強	1	1
130	124	学生	1	1
131	125	留学生	1	1
132	126	夏休み\n（ພັກຮ້ອນも同じ意味）	1	1
133	127	先生	1	1
134	128	大学	1	1
135	129	ノート	1	1
136	130	授業（ຮຽນも同じ意味）	1	1
137	131	作文	1	1
138	132	宿題	1	1
139	133	難しい	1	1
140	134	教える	1	1
141	135	テスト\n（ສອບເສັງ, ເສັງ も同じ意味）	1	1
142	136	練習	1	1
143	137	易しい	1	1
144	138	練習する	1	1
145	139	質問	1	1
146	140	問題	1	1
147	141	答える	1	1
148	142	痛い	1	1
149	143	歯	1	1
150	144	医者	1	1
151	145	病院	1	1
152	146	病気（ພະຍາດも同じ意味）	1	1
153	147	薬（くすり）	1	1
154	148	死ぬ	1	1
155	149	風邪（かぜ）	1	1
156	59	頭（あたま）	1	1
157	150	お腹	1	0
158	151	～度（温度、気温の類別詞）	1	1
159	152	エレベーター	1	1
160	153	切符、チケット	1	1
161	154	おりる	1	1
162	155	階段	1	1
163	156	閉める、閉まる\n（ອັດも同じ意味）	1	1
164	157	駅、局	1	1
165	158	地下鉄	1	1
166	159	乗る	3	1
167	160	開ける、開く\n（ໄຂも同じ意味）	1	1
168	161	お手洗い	1	0
169	161	トイレ、お手洗い	1	1
170	162	電車	1	1
171	163	飲み物	1	1
172	164	コーヒー	1	1
173	165	喫茶店	1	1
174	166	レモン	1	1
175	167	牛乳	1	1
176	168	砂糖	1	1
177	169	カップ	2	1
178	170	お茶（ນ້ຳຊາも同じ意味）	1	1
179	171	紅茶	1	1
180	169	コップ	1	1
181	172	入れる	1	1
182	173	甘い	1	1
183	174	飲む\n（ກິນも同じ意味。「薬を飲む」場合はກິນ）	1	1
184	175	はし	1	1
185	176	酒	1	1
186	177	おいしい	1	1
187	178	ナイフ、包丁	1	1
188	179	スプーン	1	1
189	180	フォーク	1	1
190	181	チーズ	1	1
191	182	食べる	1	1
192	183	まずい	1	1
193	184	パン	1	1
194	185	辛い	1	1
195	186	レストラン（ພັດຕະຄານも同じ意味（高級））	1	1
196	187	食堂	1	1
197	176	酒・ワイン	1	0
198	188	食べ物	1	1
199	189	カレー	1	1
200	190	お金	1	1
201	191	銀行	1	1
202	192	入り口	1	1
203	193	どうぞ,どういたしまして	1	1
204	194	いいえ	1	1
205	195	はい（返答、返礼）	1	1
206	196	すみません	1	1
207	197	どうぞ	1	1
208	198	出口	1	1
209	199	着く	1	1
210	200	ポスト	1	1
211	201	はがき	1	1
212	202	貼る、つける	1	1
213	203	封筒	1	1
214	204	手紙	1	1
215	205	郵便局	1	1
216	206	返す	1	1
217	207	出す	1	1
218	208	切手	1	1
219	209	物、荷物	1	1
220	210	～枚（薄いものの類別詞）	2	1
221	211	貸す	1	1
222	212	買う	1	1
223	213	帽子	1	1
224	214	靴	1	1
225	77	買い物	1	0
226	215	階	1	1
227	216	デパート	1	1
228	217	スカート\n（タイトスカートのようなものはສະເກິດ）	1	1
229	218	コート	1	1
230	219	ズボン	1	1
231	220	セーター	1	1
232	221	…てください	1	1
233	222	かばん\n（ຖົງも同じ意味）	1	1
234	223	売る	1	1
235	224	上着	1	1
236	225	風呂	1	1
237	226	建物	1	1
238	227	台所\n（ເຮືອນຄົວ, ຫ້ອງຄົວも同じ意味）	1	1
239	228	シャワー	1	1
240	229	窓	1	1
241	230	～で、～に	1	1
242	231	公園	1	1
243	232	ドア、戸	1	1
244	233	浴びる	1	1
245	234	アパート	1	1
246	235	玄関	1	1
247	236	彼，彼女	1	1
248	237	彼ら，彼女たち\n（ພວກເຂົາ, ພວກລາວも同じ意味） 	1	1
249	238	私（わたし）	1	1
250	239	私たち\n（ພວກຂ້ອຍも同じ意味）	1	1
251	240	だれか	1	0
252	240	だれ、だれか	1	1
253	241	どの人、どなた	1	1
254	195	きみ	1	0
255	195	あなた	1	1
256	242	この	1	1
257	243	その，あの	1	1
258	244	どう\n（ເປັນຈັ່ງໃດも同じ意味。口語）\n	1	1
259	245	どの	1	1
260	246	どんな\n（ແບບໃດも同じ意味）	1	1
261	247	こんな\n（ແບບນີ້も同じ意味）	1	1
262	248	自分\n（ຕົນເອງ,​ ໂຕເອງも同じ意味）	1	1
263	249	そんな\n（ແບບນັ້ນも同じ意味）	1	1
264	250	厚い	1	1
265	251	狭い	1	1
266	252	細い	1	1
267	253	大きい	1	1
268	254	太い	1	1
269	255	若い	1	1
270	256	広い	1	1
271	257	軽い	1	1
272	258	遠い	1	1
273	259	重い	1	1
274	260	薄い	1	1
275	261	新しい	1	1
276	262	小さい	1	1
277	106	近い	1	1
278	263	古い	1	1
279	264	楽しい、おもしろい	1	1
280	265	にぎやか	1	1
281	266	低い	1	1
282	267	よい	1	1
283	268	明るい	1	1
284	269	弱い（体力）	1	1
285	270	強い、じょうぶだ	1	1
286	271	おもしろい（ມ່ວນも同じ意味）	1	1
287	272	きれい、美しい	1	1
288	273	遅い	1	1
289	274	悪い	1	1
290	275	多い、多くの	1	1
291	276	暗い	1	1
292	277	静か（ມິດງຽບも同じ意味）	1	1
293	278	少ない	1	1
294	279	汚い	1	1
295	280	つまらない	1	1
296	281	横	1	1
297	282	中（なか）	1	1
298	283	外（そと）	1	1
299	284	東（ひがし）	1	1
300	285	高い	1	1
301	286	縦	1	1
302	287	北（きた）	1	1
303	288	西（にし）	1	1
304	289	下（した）	1	1
305	290	南（みなみ）	1	1
306	291	上（うえ）	1	1
307	292	～過ぎ	1	1
308	111	～（の）後（あと）	3	1
309	293	いとこ	1	1
310	294	兄	1	1
311	295	兄弟（きょうだい）	1	1
312	296	おばあさん	1	1
313	297	おじいさん	1	1
314	298	奥さん	1	1
315	299	母	1	1
316	300	伯父（父母の兄）\n（父方の叔父はອາວ、母方の叔父はນ້າບ່າວ）	1	1
317	301	両親	1	1
318	302	父	1	1
319	303	姉	1	1
320	304	姉妹	1	1
321	305	伯母（父母の姉）\n（父方の叔母はອາ、母方の叔母はນ້າສາວ）	1	1
322	294	お兄さん	1	1
323	303	お姉さん	1	1
324	302	お父さん	1	1
325	299	お母さん	1	1
326	306	靴下	1	1
327	307	シャツ	1	1
328	308	脱ぐ	1	1
329	172	掛ける	3	1
330	309	は（穿）く［ズボンを～］	1	0
331	309	着る、はく	1	1
332	172	かぶる	2	1
333	310	ハンカチ	1	1
334	311	サンダル、スリッパ	1	1
335	312	傘	1	1
336	313	ポケット	1	1
337	314	財布	1	1
338	309	着ている	2	1
339	315	服（ເຄື່ອງນຸ່ງຫົ່ມも同じ意味）	1	1
340	316	衣服	1	1
341	317	口	1	1
342	318	腕（うで）	1	1
343	319	体（からだ）（ໂຕ, ຕົນໂຕも同じ意味）	1	1
344	112	顔	1	1
345	320	足（くるぶしから下の部分）	1	1
346	321	手（て）	1	1
347	322	鼻	1	1
348	323	目（め）	1	1
349	324	耳	1	1
350	325	脚（あし）	1	1
351	150	おなか	1	1
352	326	～皿（皿の類別詞）	2	1
353	327	バター\n（ເນີຍも同じ意味）	1	1
354	328	茶わん	1	1
355	329	飴	1	1
356	330	昼御飯\n（ເຂົ້າສວາຍも同じ意味）	1	1
357	331	夕飯（ゆうはん）	1	0
358	332	お菓子	1	1
359	333	卵	1	1
360	334	朝御飯	1	1
361	335	御飯（ごはん）	1	1
362	336	醤油	1	1
363	337	塩（しお）	1	1
364	331	晩御飯	1	1
365	338	加える	1	1
366	202	つける	1	0
367	339	カメラ	1	1
368	340	ストーブ	1	1
369	341	鉛筆	1	1
370	342	消す	1	1
371	343	眼鏡（めがね）	1	1
372	344	テープレコーダー	1	1
373	345	時計	1	1
374	346	コンピューター	1	1
375	347	フィルム	1	1
376	232	戸（と）	1	0
377	348	門（もん）	1	1
378	349	ペン、ボールペン	1	1
379	350	万年筆	1	1
380	349	ボールペン	1	0
381	351	八月\n（書き言葉ເດືອນສິງຫາも同じ意味）	1	1
382	352	四月\n（書き言葉ເດືອນເມສາも同じ意味）	1	1
383	353	今月	1	1
384	354	毎月（まいつき）	1	1
385	355	十二月\n（書き言葉ເດືອນທັນວາも同じ意味）	1	1
386	356	二月\n（書き言葉ເດືອນກຸມພາも同じ意味）	1	1
387	357	一月\n（書き言葉ເດືອນມັງກອນも同じ意味）	1	1
388	358	七月\n（書き言葉ເດືອນກໍລະກົດも同じ意味）	1	1
389	359	六月\n（書き言葉ເດືອນມິຖຸນາも同じ意味）	1	1
390	360	来月	1	1
391	361	五月\n（書き言葉ເດືອນພຶດສະພາも同じ意味）	1	1
392	362	三月\n（書き言葉ເດືອນມີນາも同じ意味）	1	1
393	363	先月	1	1
394	364	十一月\n（書き言葉ເດືອນພະຈິກも同じ意味）	1	1
395	365	十月\n（書き言葉ເດືອນຕຸລາも同じ意味）	1	1
396	366	九月\n（書き言葉ເດືອນກັນຍາも同じ意味）	1	1
397	367	ひと月\n	1	1
398	368	今週	1	1
399	369	毎週	1	1
400	370	日曜日	1	1
401	371	木曜日	1	1
402	372	来週	1	1
403	373	月曜日	1	1
404	374	火曜日	1	1
405	375	水曜日	1	1
406	376	土曜日	1	1
407	377	～週（間）（週の類別詞）	2	1
408	378	先週	1	1
409	379	金曜日	1	1
410	380	年（ねん）	1	1
411	381	秋	1	1
412	382	今年（ことし）	1	1
413	383	毎年（まいとし）	1	1
414	384	夏（なつ）\n（ຍາມຮ້ອນも同じ意味）	1	1
415	385	冬\n（ຍາມໜາວも同じ意味）	1	1
416	386	去年	1	1
417	387	来年	1	1
418	388	春	1	1
419	389	再来年	1	1
420	390	おととし	1	1
421	391	午後	1	1
422	392	今日（きょう）	1	1
423	393	明日（あした）	1	1
424	345	～時（時刻の類別詞）	2	1
425	394	昨日（きのう）	1	1
426	395	夕べ、昨夜	1	1
427	396	午前	1	1
428	397	朝	1	1
429	398	昼	1	1
430	399	夜（よる）	1	1
431	400	夕方	1	1
432	401	あさって	1	1
433	402	おととい	1	1
434	403	もう～た（完了）	1	1
435	404	ながら	1	1
436	405	まだ	1	1
437	406	尽きる	1	1
438	407	時（とき）	1	1
439	408	いつ	1	1
440	409	ときどき	1	1
441	410	よく、頻繁に	1	1
442	411	～時間（時間の類別詞）	2	1
443	412	すぐ	1	1
444	413	灰皿	1	1
445	414	歌（うた）	1	1
446	415	歌う	1	1
447	416	たばこ	1	1
448	417	映画\n（ຮູບເງົາも同じ意味）	1	1
449	418	レコード	1	1
450	419	ギター	1	1
451	15	演奏する	2	1
452	420	音楽	1	1
453	421	絵（え）	1	1
454	422	写真	1	1
455	18	好きだ	1	1
456	423	声	1	1
457	424	晴れ	1	1
458	425	暑い	1	1
459	426	晴天	1	1
460	427	涼しい	1	1
461	428	寒い	1	1
462	429	雪（ゆき）	1	1
463	430	雨が降る	1	1
464	431	雨（あめ）	1	1
465	432	天気	1	1
466	433	あたたかい（暖・温）	1	1
467	434	風（かぜ）	1	1
468	435	曇り	1	1
469	427	冷たい	1	1
470	436	曇る	1	1
471	437	漢字\n（ໂຕໜັງສືຄັນຈິ, ໂຕຄັນຈິも同じ意味）	1	1
472	438	言う	1	1
473	439	書く	1	1
474	440	話（はなし）、事（こと）	1	1
475	441	言語	1	1
476	441	～語（言語の類別詞）	2	1
477	442	単語（ຄຳສັບも同じ意味）	2	1
478	438	話す	1	1
479	443	文、文章	1	1
480	444	語る	1	1
481	445	意味	1	1
482	446	平仮名\n（ໂຕໜັງສືຮິລະກະນະ, ໂຕຮິລະກະນະも同じ意味）	1	1
483	447	片仮名\n（ໂຕໜັງສືກະຕະກະນະ,​ ໂຕຄະຕະກະນະも同じ意味）	1	1
484	448	大人（おとな）	1	1
485	275	大勢	1	0
486	449	夫婦	1	1
487	450	子供	1	1
488	298	妻	1	1
489	451	女（ແມ່ຍິງも同じ意味）	1	1
490	452	男の子	1	1
491	453	人（ひと）	2	0
492	454	男	1	1
493	455	女の子	1	1
494	456	夫	1	1
495	453	人	1	1
496	457	みんな	1	1
497	458	白（しろ），白い	1	1
498	459	青，青い	1	1
499	460	茶、茶色い	1	1
500	461	淡い	1	1
501	462	色（いろ）	1	1
502	463	濃い\n（ເຂັ້ມも同じ意味）	1	1
503	464	黄色（きいろ），黄色い	1	1
504	465	黒（くろ），黒い	1	1
505	466	赤，赤い	1	1
506	467	緑	1	1
507	468	便利、便利だ	1	1
508	469	パーティー	1	1
509	470	紙	1	1
510	471	～になる（変化）	1	1
511	472	縛る	1	1
512	473	押す	1	1
513	474	始まる	1	1
514	475	ちょうど	1	1
515	476	ない	1	1
516	94	まっすぐ	1	1
517	477	有名だ	1	1
518	270	元気だ	1	1
519	478	じゃあ	1	0
520	479	多分	1	1
521	478	では	1	1
522	480	ニワトリ	1	1
523	84	～と	2	1
524	84	小箱	3	1
525	159	のぼる	1	1
526	335	入る	1	1
527	442	～くち、～語（語彙などの類別詞）	3	1
528	442	金	1	1
529	190	銀	2	1
530	21	遅い	1	1
531	61	正しい	1	1
532	313	かばん\n（ກະເປົາも同じ意味）	1	1
533	327	番号	1	1
534	160	つける	1	1
535	297	祖父（母方）\n（父方の祖母はປູ່）	1	1
536	296	祖母（母方）\n（父方の祖母はຍ່າ）	1	1
537	207	送る	1	1
538	111	背中	2	1
539	111	～軒（家屋の類別詞）	4	1
540	88	～部屋（部屋の類別詞）	3	1
541	328	～杯（茶碗、どんぶりの類別詞）	2	1
542	169	～杯（コップ、カップの類別詞）	3	1
543	453	～人（人間の類別詞）\n	3	1
544	84	～箱（小箱の類別詞）	4	1
545	275	とても	1	1
546	461	弱い	2	1
547	73	あげる（ໃຫ້も同じ意味）	1	1
548	417	皮（動物の皮）、皮膚	2	1
549	44	作る	1	1
550	112	前	2	1
551	481	晴れ、晴れる	1	1
552	483	叔父（父方の弟）	1	1
553	482	叔母（父方の妹）	1	1
554	236	ラオス	1	1
555	230	住む	1	1
556	230	いる	1	1
557	484	水	1	1
558	485	勉強する	1	1
559	486	来る	1	1
560	487	櫛（くし）\n	1	1
561	487	（髪を）とかす	1	1
562	488	ある	1	1
563	488	持っている	1	1
564	489	山	1	1
565	182	飲む	1	1
566	326	～皿	1	0
567	326	皿（さら）	1	1
568	411	時間	1	1
569	440	～話（話の類別詞）	2	1
570	403	終える	2	1
571	194	～ない（否定辞）	2	1
572	210	葉（ໃບໄມ້も同じ意味）	1	1
573	9	出て行く	2	1
574	432	気候	2	1
575	377	週	1	1
576	167	乳	2	1
577	380	～年（間）、～才（年、年齢の類別詞）	2	1
578	156	消す	2	1
579	292	先	2	1
580	196	あやまる	2	1
581	18	よく～する	2	1
582	159	上がる	2	1
583	154	下がる	2	1
584	423	音	2	1
585	472	束（束状になっているものの類別詞）	1	1
586	47	用事	2	1
587	407	時間	1	1
588	490	棚	1	1
589	491	何	1	1
590	493	弟	1	1
591	492	妹	1	1
592	451	（ແມ່ຍິງも同じ意味）	1	0
593	494		1	0
594	494	終わる	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: lo
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
334	50240	1.426	1.42	体	生産物	衣料	履き物	履き物	履き物	はきもの
224	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
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
285	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
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
551	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
468	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
36	60947	1.525	1.52	体	自然	天地	川・湖	かわ（川・河）	かわ	かわ
34	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
174	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
66	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
522	63268	1.5502	1.55	体	自然	動物	鳥類	鳥（とり）	鳥	とり
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
350	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
345	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
149	65338	1.5606	1.56	体	自然	身体	骨・歯・爪・角・甲	歯	歯	は
175	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
359	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
152	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
155	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
510	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
217	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
99	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
534	67766	2.1210999	2.12	用	関係	存在	発生・復活	火が付く／を付ける	火が付く／を付ける	ひがつく・ひをつける
370	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
511	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
437	69338	2.1503	2.15	用	関係	作用	終了・中止・停止	尽きる	尽きる	つきる
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
209	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
87	71160	2.1526999	2.15	用	関係	作用	往復	帰る	帰る	かえる
181	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
332	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
525	71927	2.154	2.15	用	関係	作用	上がり・下がり	上る	上る	のぼる
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
338	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
331	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
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
531	90914	3.1029999	3.10	相	関係	真偽	真偽・是非	正しい	正しい	ただしい
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
282	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
289	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
274	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
287	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
294	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
139	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
143	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
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
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	2	1028	\N	ພາສາອັງກິດ	0	\N	\N
2	5	1029	\N	ຄົນຕ່າງປະເທດ	0	\N	\N
3	12	1030	\N	ພັກຜ່ອນ	0	\N	\N
7	17	1034	\N	ມັກຫຼາຍ	0	\N	\N
10	23	1037	\N	ຍ່າງ	0	\N	\N
11	24	1038	\N	ລອຍນຳ້	0	\N	\N
12	26	1039	\N	ບິນ	0	\N	\N
13	29	1040	\N	ສະລອຍນ້ຳ	0	\N	\N
14	31	1041	\N	ລົດຖີບ	0	\N	\N
15	32	1042	\N	ທາງສີ່ແຍກ	0	\N	\N
16	34	1043	\N	ໜອງ	0	\N	\N
17	35	1044	\N	ຍ່າງຫຼິ້ນ	0	\N	\N
19	37	1046	\N	ຕັກຊີ່	0	\N	\N
20	40	1047	\N	ກາລະວັດ	0	\N	\N
21	41	1048	\N	ເສື້ອເຊີດ	0	\N	\N
22	43	1049	\N	ສູດ	0	\N	\N
23	45	1050	\N	ສູບ	0	\N	\N
24	46	1051	\N	ໂທລະສັບ	0	\N	\N
25	49	1052	\N	ຫຍຸ້ງ	0	\N	\N
27	56	1054	\N	ກັອບປີ້	0	\N	\N
28	57	1055	\N	ອັດ 	0	\N	\N
29	58	1056	\N	ວາລະສານ	0	\N	\N
30	60	1057	\N	ຊີ້ນງົວ	0	\N	\N
31	61	1058	\N	ຖືກ	0	\N	\N
34	69	1061	\N	ຊີ້ນໝູ	0	\N	\N
35	70	1062	\N	ຊີ້ນໄກ່	0	\N	\N
37	78	1064	\N	ຊັກເຄື່ອງ	0	\N	\N
39	82	1066	\N	ສວນ	0	\N	\N
40	83	1067	\N	ຊັກເຄື່ອງ	0	\N	\N
41	86	1068	\N	ການເຮັດອະນາໄມ	0	\N	\N
42	88	1069	\N	ຕູ້ປຶ້ມ	0	\N	\N
43	89	1070	\N	ໂຕະ	0	\N	\N
44	90	1071	\N	ຕັ່ງ	0	\N	\N
45	91	1072	\N	ຫ້ອງ	0	\N	\N
48	94	1075	\N	ຕຽງ	0	\N	\N
49	95	1076	\N	ວິທະຍຸ	0	\N	\N
50	96	1077	\N	ເທັບ	0	\N	\N
51	99	1078	\N	ຕື່ນ	0	\N	\N
52	100	1079	\N	ໂຕະ	0	\N	\N
53	102	1080	\N	ຕຳຫຼວດ	0	\N	\N
54	103	1081	\N	ຕຳຫຼວດ	0	\N	\N
55	104	1082	\N	ແຜນທີ່	0	\N	\N
56	105	1083	\N	ໃກ້ໆ	0	\N	\N
57	106	1084	\N	ຢູ່ນີ້	0	\N	\N
58	107	1085	\N	ຢູ່ຫັ້ນ 	0	\N	\N
59	108	1086	\N	ຢູ່ພຸ້ນ	0	\N	\N
60	110	1087	\N	ປ້ອມຕຳຫຼວດ	0	\N	\N
61	112	1088	\N	ຂ້າງ	0	\N	\N
64	119	1091	\N	ຊ້າຍ	0	\N	\N
66	121	1093	\N	ນັ່ງ	0	\N	\N
68	124	1095	\N	ຫ້ອງ	0	\N	\N
69	125	1096	\N	ຫ້ອງຮຽນ	0	\N	\N
70	126	1097	\N	ລະບຽງ	0	\N	\N
71	129	1098	\N	ການຮຽນ	0	\N	\N
72	131	1099	\N	ນັກສຶກສາຕ່າງປະເທດ	0	\N	\N
73	132	1100	\N	ພັກລະດູຮ້ອນ	0	\N	\N
74	135	1101	\N	ປຶ້ມຂຽນ	0	\N	\N
75	136	1102	\N	ຊົ່ວໂມງຮຽນ	0	\N	\N
76	137	1103	\N	ຫັດແຕ່ງ	0	\N	\N
78	142	1105	\N	ບົດຝຶກຫັດ	0	\N	\N
79	144	1106	\N	ຝຶກຫັດ	0	\N	\N
80	145	1107	\N	ຄຳຖາມ	0	\N	\N
81	147	1108	\N	ຕອບ	0	\N	\N
82	149	1109	\N	ແຂ້ວ	0	\N	\N
83	152	1110	\N	ເຈັບປ່ວຍ	0	\N	\N
84	154	1111	\N	ຕາຍ	0	\N	\N
85	155	1112	\N	ເປັນຫວັດ	0	\N	\N
86	157	1113	\N	ທ້ອງ	0	\N	\N
87	158	1114	\N	ອົງສາ	0	\N	\N
90	161	1117	\N	ລົງ	0	\N	\N
91	162	1118	\N	ຂັ້ນໄດ	0	\N	\N
92	163	1119	\N	ປິດ	0	\N	\N
93	164	1120	\N	ສະຖານີ	0	\N	\N
94	165	1121	\N	ລົດໄຟໃຕ້ດິນ	0	\N	\N
95	166	1122	\N	ຂຶ້ນ	0	\N	\N
96	168	1123	\N	ຫ້ອງນ້ຳ	0	\N	\N
97	169	1124	\N	ຫ້ອງນ້ຳ	0	\N	\N
98	170	1125	\N	ລົດໄຟຟ້າ	0	\N	\N
99	171	1126	\N	ເຄື່ອງດື່ມ	0	\N	\N
100	172	1127	\N	ກາເຟ	0	\N	\N
101	173	1128	\N	ຮ້ານກິນດື່ມ	0	\N	\N
102	174	1129	\N	ໝາກນາວ	0	\N	\N
103	175	1130	\N	ນົມ	0	\N	\N
105	177	1132	\N	ຈອກ	0	\N	\N
106	179	1133	\N	ຊາຝຣັ່ງ	0	\N	\N
107	180	1134	\N	ຈອກ	0	\N	\N
110	185	1137	\N	ເຫຼົ້າ	0	\N	\N
111	189	1138	\N	ສ້ອມ	0	\N	\N
112	190	1139	\N	ເນີຍແຂງ	0	\N	\N
113	192	1140	\N	ບໍ່ແຊບ	0	\N	\N
114	193	1141	\N	ເຂົ້າຈີ່	0	\N	\N
116	196	1143	\N	ໂຮງອາຫານ	0	\N	\N
117	197	1144	\N	ເຫຼົ້າ	0	\N	\N
118	198	1145	\N	ເຄື່ອງກິນ	0	\N	\N
119	199	1146	\N	ກະຫຼີ່	0	\N	\N
120	201	1147	\N	ທະນາຄານ	0	\N	\N
121	202	1148	\N	ທາງເຂົ້າ	0	\N	\N
122	203	1149	\N	ເຊີນ, ບໍ່ເປັນຫຍັງ	0	\N	\N
123	208	1150	\N	ທາງອອກ	0	\N	\N
124	210	1151	\N	ຕູ້ໄປສະນີ	0	\N	\N
125	211	1152	\N	ໂປດສະກາດ	0	\N	\N
126	213	1153	\N	ຊອງ	0	\N	\N
127	215	1154	\N	ໄປສະນີ	0	\N	\N
128	216	1155	\N	ຄືນ	0	\N	\N
130	221	1157	\N	ໃຫ້ຢືມ	0	\N	\N
131	223	1158	\N	ໝວກ	0	\N	\N
132	224	1159	\N	ເກີບ	0	\N	\N
133	227	1160	\N	ຮ້ານສັບພະສິນຄ້າ	0	\N	\N
135	229	1162	\N	ເສື້ອຄຸມ	0	\N	\N
136	230	1163	\N	ໂສ້ງ	0	\N	\N
137	231	1164	\N	ເສື້ອແລນ	0	\N	\N
139	234	1166	\N	ຂາຍ	0	\N	\N
140	235	1167	\N	ເສື້ອຈັກເກັດ	0	\N	\N
141	236	1168	\N	ອ່າງອາບນ້ຳ	0	\N	\N
142	237	1169	\N	ຕຶກ	0	\N	\N
143	238	1170	\N	ຫ້ອງແຕ່ງກິນ	0	\N	\N
144	239	1171	\N	ນ້ຳຝັກບົວ	0	\N	\N
146	242	1173	\N	ສວນສາທາລະນະ	0	\N	\N
149	246	1176	\N	ໜ້າບ້ານ	0	\N	\N
154	264	1181	\N	ໜາ	0	\N	\N
155	265	1182	\N	ແຄບ	0	\N	\N
157	269	1184	\N	ໜຸ່ມ	0	\N	\N
159	271	1186	\N	ເບົາ	0	\N	\N
160	276	1187	\N	ນ້ອຍ	0	\N	\N
161	278	1188	\N	ເກົ່າ	0	\N	\N
163	281	1190	\N	ຕຳ່	0	\N	\N
164	283	1191	\N	ແຈ້ງ	0	\N	\N
166	285	1193	\N	ແຂງແຮງ	0	\N	\N
167	288	1194	\N	ໍຊ້າ	0	\N	\N
168	291	1195	\N	ມືດ	0	\N	\N
169	294	1196	\N	ເປື້ອນ	0	\N	\N
171	299	1198	\N	ທິດຕາເວັນອອກ	0	\N	\N
173	302	1200	\N	ທິດເໜືອ	0	\N	\N
174	303	1201	\N	ທິດຕາເວັນຕົກ	0	\N	\N
175	304	1202	\N	ກ້ອງ	0	\N	\N
176	305	1203	\N	ທິດໃຕ້	0	\N	\N
178	311	1205	\N	ອ້າຍນ້ອງ	0	\N	\N
179	320	1206	\N	ເອື້ອຍນ້ອງ	0	\N	\N
181	326	1208	\N	ຖົງຕີນ	0	\N	\N
182	328	1209	\N	ແກ້ເຄື່ອງ	0	\N	\N
183	330	1210	\N	ນຸ່ງ 	0	\N	\N
184	331	1211	\N	ນຸ່ງ 	0	\N	\N
186	334	1213	\N	ເກີບແຕະ	0	\N	\N
187	335	1214	\N	ຄັນຮົ່ມ	0	\N	\N
188	336	1215	\N	ຖົງ	0	\N	\N
189	337	1216	\N	ກະເປົາເງິນ	0	\N	\N
190	338	1217	\N	ນຸ່ງ 	0	\N	\N
191	339	1218	\N	ເຄື່ອງນຸ່ງ	0	\N	\N
192	340	1219	\N	ເຄື່ອງນຸ່ງຫົ່ມ	0	\N	\N
193	342	1220	\N	ແຂນ	0	\N	\N
194	343	1221	\N	ຮ່າງກາຍ	0	\N	\N
197	349	1224	\N	ຫູ	0	\N	\N
200	354	1227	\N	ຖ້ວຍ	0	\N	\N
201	355	1228	\N	ເຂົ້າໜົມອົມ	0	\N	\N
203	357	1230	\N	ເຂົ້າແລງ	0	\N	\N
205	360	1232	\N	ເຂົ້າເຊົ້າ	0	\N	\N
207	364	1234	\N	ເຂົ້າແລງ	0	\N	\N
208	365	1235	\N	ຕື່ມ	0	\N	\N
209	367	1236	\N	ກ້ອງຖ່າຍຮູບ	0	\N	\N
210	368	1237	\N	ເຕົາໄຟ	0	\N	\N
212	371	1239	\N	ແວ່ນຕາ	0	\N	\N
213	372	1240	\N	ເຄື່ອງອັດເທັບ	0	\N	\N
215	375	1242	\N	ຟີມ	0	\N	\N
216	377	1243	\N	ປະຕູໃຫຍ່	0	\N	\N
217	378	1244	\N	ບິກ	0	\N	\N
218	379	1245	\N	ປາກກາ	0	\N	\N
219	380	1246	\N	ບິກ	0	\N	\N
220	381	1247	\N	ເດືອນ8	0	\N	\N
221	382	1248	\N	ເດືອນ4	0	\N	\N
222	383	1249	\N	ເດືອນນີ້	0	\N	\N
223	384	1250	\N	ທຸກເດືອນ	0	\N	\N
224	385	1251	\N	ເດືອນ12	0	\N	\N
225	386	1252	\N	ເດືອນ2	0	\N	\N
226	387	1253	\N	ເດືອນ1	0	\N	\N
227	388	1254	\N	ເດືອນ7	0	\N	\N
228	389	1255	\N	ເດືອນ6	0	\N	\N
229	390	1256	\N	ເດືອນໜ້າ	0	\N	\N
230	391	1257	\N	ເດືອນ5	0	\N	\N
231	392	1258	\N	ເດືອນ3	0	\N	\N
233	394	1260	\N	ເດືອນ11	0	\N	\N
234	395	1261	\N	ເດືອນ10	0	\N	\N
235	396	1262	\N	ເດືອນ9	0	\N	\N
236	397	1263	\N	ໜຶ່ງເດືອນ	0	\N	\N
237	399	1264	\N	ທຸກອາທິດ	0	\N	\N
238	401	1265	\N	ວັນພະຫັດ	0	\N	\N
239	404	1266	\N	ວັນອັງຄານ	0	\N	\N
240	405	1267	\N	ວັນພຸດ	0	\N	\N
241	408	1268	\N	ອາທິດແລ້ວ	0	\N	\N
242	409	1269	\N	ວັນສຸກ	0	\N	\N
244	412	1271	\N	ປີນີ້	0	\N	\N
245	413	1272	\N	ທຸກປີ	0	\N	\N
246	415	1273	\N	ລະດູໜາວ	0	\N	\N
247	416	1274	\N	ປີກາຍ	0	\N	\N
248	418	1275	\N	ລະດູໃບໄມ້ປົ່ງ	0	\N	\N
249	419	1276	\N	ປີໃນ	0	\N	\N
250	420	1277	\N	ປີກ່ອນ	0	\N	\N
252	427	1279	\N	ຕອນເຊົ້າ	0	\N	\N
253	429	1280	\N	ຕອນທ່ຽງ	0	\N	\N
254	430	1281	\N	ຕອນກາງຄືນ	0	\N	\N
255	431	1282	\N	ຕອນຄຳ່	0	\N	\N
257	435	1284	\N	ທັງ -  ທັງ	0	\N	\N
259	443	1286	\N	ທັນທີ	0	\N	\N
263	447	1290	\N	ຢາສູບ	0	\N	\N
264	449	1291	\N	ແຜ່ນສຽງ	0	\N	\N
265	450	1292	\N	ກີຕ້າ	0	\N	\N
266	452	1293	\N	ດົນຕີ	0	\N	\N
269	456	1296	\N	ສຽງ	0	\N	\N
271	459	1298	\N	ອາກາດປອດໂປ່ງ	0	\N	\N
272	461	1299	\N	ໜາວ	0	\N	\N
276	468	1303	\N	ຟ້າບົດ	0	\N	\N
277	470	1304	\N	ຄຶ້ມ	0	\N	\N
278	471	1305	\N	ຕົວອັກສອນຄັນຈິ	0	\N	\N
279	479	1306	\N	ປະໂຫຍກ	0	\N	\N
280	480	1307	\N	ເລົ່າ	0	\N	\N
281	482	1308	\N	ຕົວອັກສອນຮິລະກະນະ	0	\N	\N
282	483	1309	\N	ຕົວອັກສອນຄະຕະກະນະ	0	\N	\N
283	486	1310	\N	ຜົວເມຍ	0	\N	\N
284	487	1311	\N	ລູກ	0	\N	\N
285	490	1312	\N	ເດັກນ້ອຍຜູ້ຊາຍ	0	\N	\N
286	493	1313	\N	ເດັກນ້ອຍຜູ້ຍິງ	0	\N	\N
287	494	1314	\N	ຜົວ	0	\N	\N
288	496	1315	\N	ທຸກຄົນ	0	\N	\N
289	497	1316	\N	ສີຂາວ	0	\N	\N
292	503	1319	\N	ສີເຫຼືອງ	0	\N	\N
293	505	1320	\N	ສີແດງ	0	\N	\N
294	506	1321	\N	ສີຂຽວ	0	\N	\N
296	508	1323	\N	ງານລ້ຽງ	0	\N	\N
298	510	1325	\N	ກາຍເປັນ	0	\N	\N
299	512	1326	\N	ຍູ້	0	\N	\N
300	514	1327	\N	ພໍດີ	0	\N	\N
301	517	1328	\N	ມີຊື່ສຽງ	0	\N	\N
305	27	1312	0	ກິລາ	0	\N	\N
308	111	291	0	ໃກ້	0	\N	\N
323	206	28	0	ຂໍໂທດ	0	\N	\N
324	206	39	0	ຂໍໂທດ	0	\N	\N
325	206	46	0	ຂໍໂທດ	0	\N	\N
334	520	242	0	ຄືຊິ	0	\N	\N
335	520	326	0	ຄືຊິ	0	\N	\N
344	519	354	0	ຄັນຊັ້ນ	0	\N	\N
346	481	287	0	ຄວາມໝາຍ	0	\N	\N
347	481	1306	0	ຄວາມໝາຍ	0	\N	\N
348	80	135	0	ຄອບຄົວ	0	\N	\N
349	80	137	0	ຄອບຄົວ	0	\N	\N
350	143	197	1	ງ່າຍ	0	\N	\N
351	200	392	1	ເງິນ	0	\N	\N
352	287	1088	0	ງາມ	0	\N	\N
353	287	1164	0	ງາມ	0	\N	\N
354	214	63	1	ຈົດໝາຍ	0	\N	\N
356	509	1054	0	ເຈ້ຍ	0	\N	\N
357	509	1090	0	ເຈ້ຍ	0	\N	\N
360	255	1265	0	ເຈົ້າ	0	\N	\N
361	255	1305	0	ເຈົ້າ	0	\N	\N
362	255	1318	0	ເຈົ້າ	0	\N	\N
363	254	370	0	ເຈົ້າ	0	\N	\N
364	255	1327	0	ເຈົ້າ	0	\N	\N
377	78	1303	0	ຊັກເຄື່ອງ	0	\N	\N
382	442	134	0	ຊົ່ວໂມງ	0	\N	\N
389	225	213	0	ຊື້ເຄື່ອງ	0	\N	\N
390	225	1218	0	ຊື້ເຄື່ອງ	0	\N	\N
395	428	282	0	ເຊົ້າ	0	\N	\N
396	428	1044	0	ເຊົ້າ	0	\N	\N
397	428	1232	0	ເຊົ້າ	0	\N	\N
407	3	274	0	ຍົນ	0	\N	\N
408	3	340	0	ຍົນ	0	\N	\N
409	139	124	0	ຍາກ	0	\N	\N
410	139	197	0	ຍາກ	0	\N	\N
411	23	1222	0	ຍ່າງ	0	\N	\N
412	282	90	0	ດີ	0	\N	\N
413	282	374	0	ດີ	0	\N	\N
414	282	1158	0	ດີ	0	\N	\N
415	452	1281	0	ດົນຕີ	0	\N	\N
424	237	1190	0	ຕຶກ	0	\N	\N
425	421	389	0	ຕອນແລງ	0	\N	\N
427	4	35	0	ຕ່າງປະເທດ	0	\N	\N
428	4	1029	0	ຕ່າງປະເທດ	0	\N	\N
429	281	1109	0	ຕຳ່	0	\N	\N
430	89	1202	0	ໂຕະ	0	\N	\N
431	61	1129	0	ຖືກ	0	\N	\N
432	61	1143	0	ຖືກ	0	\N	\N
433	33	1080	0	ທາງ	0	\N	\N
434	150	266	0	ທ່ານໝໍ	0	\N	\N
437	65	72	0	ເທົ່າໃດ	0	\N	\N
439	46	1268	0	ໂທລະສັບ	0	\N	\N
440	256	146	0	ນີ້	0	\N	\N
441	256	177	0	ນີ້	0	\N	\N
443	130	35	0	ນັກສຶກສາ	0	\N	\N
451	298	333	0	ນອກ	0	\N	\N
452	298	1297	0	ນອກ	0	\N	\N
453	276	1076	0	ນ້ອຍ	0	\N	\N
454	98	218	0	ນອນ	0	\N	\N
455	98	1293	0	ນອນ	0	\N	\N
461	297	1328	0	ໃນ	0	\N	\N
465	515	1052	0	ບໍ່ມີ	0	\N	\N
466	515	1102	0	ບໍ່ມີ	0	\N	\N
467	515	1125	0	ບໍ່ມີ	0	\N	\N
473	188	153	0	ບ່ວງ	0	\N	\N
474	410	38	0	ປີ	0	\N	\N
476	163	1147	0	ປິດ	0	\N	\N
486	307	244	0	ປາຍ	0	\N	\N
508	251	1176	0	ໃຜ	0	\N	\N
516	318	218	0	ພໍ່	0	\N	\N
517	318	1131	0	ພໍ່	0	\N	\N
518	11	66	0	ພົບ	0	\N	\N
519	11	1267	0	ພົບ	0	\N	\N
520	250	1254	0	ພວກເຮົາ	0	\N	\N
524	475	198	0	ພາສາ	0	\N	\N
525	475	199	0	ພາສາ	0	\N	\N
526	8	122	0	ພາສາຍີ່ປຸ່ນ	0	\N	\N
527	8	383	0	ພາສາຍີ່ປຸ່ນ	0	\N	\N
528	6	289	0	ພາສາລາວ	0	\N	\N
529	6	404	0	ພາສາລາວ	0	\N	\N
552	432	59	0	ມື້ຮື	0	\N	\N
569	106	1058	0	ຢູ່ນີ້	0	\N	\N
578	460	326	0	ເຢັນ	0	\N	\N
579	487	1257	0	ລູກ	0	\N	\N
581	38	111	0	ລົດ	0	\N	\N
583	38	160	0	ລົດ	0	\N	\N
586	38	158	0	ລົດ	0	\N	\N
587	30	157	0	ລົດເມ	0	\N	\N
588	30	1126	0	ລົດເມ	0	\N	\N
600	474	360	0	ເລື່ອງ	0	\N	\N
605	51	117	0	ວັດຈະນານຸກົມ	0	\N	\N
606	51	119	0	ວັດຈະນານຸກົມ	0	\N	\N
610	47	237	0	ວຽກ	0	\N	\N
611	47	1052	0	ວຽກ	0	\N	\N
612	47	1142	0	ວຽກ	0	\N	\N
614	438	1102	0	ເວລາ	0	\N	\N
615	438	1107	0	ເວລາ	0	\N	\N
616	478	404	0	ເວົ້າ	0	\N	\N
617	478	1224	0	ເວົ້າ	0	\N	\N
618	472	1180	0	ເວົ້າ	0	\N	\N
624	217	1152	0	ສົ່ງ	0	\N	\N
625	217	1253	0	ສົ່ງ	0	\N	\N
626	504	322	0	ສີດຳ	0	\N	\N
629	164	1286	0	ສະຖານີ	0	\N	\N
630	456	1112	0	ສຽງ	0	\N	\N
631	327	71	0	ເສື້ອ	0	\N	\N
632	327	313	0	ເສື້ອ	0	\N	\N
634	229	1302	0	ເສື້ອຄຸມ	0	\N	\N
635	230	1210	0	ໂສ້ງ	0	\N	\N
636	332	1158	0	ໃສ່	0	\N	\N
637	181	228	0	ໃສ່	0	\N	\N
638	181	1235	0	ໃສ່	0	\N	\N
640	156	263	0	ຫົວ 	0	\N	\N
645	451	1281	0	ຫຼິ້ນ	0	\N	\N
646	451	1292	0	ຫຼິ້ນ	0	\N	\N
647	15	1202	0	ຫຼິ້ນ	0	\N	\N
648	15	1256	0	ຫຼິ້ນ	0	\N	\N
650	197	1137	0	ເຫຼົ້າ	0	\N	\N
652	133	242	0	ອາຈານ	0	\N	\N
653	133	245	0	ອາຈານ	0	\N	\N
656	310	140	0	ອ້າຍ	0	\N	\N
657	310	397	0	ອ້າຍ	0	\N	\N
662	402	305	0	ອາທິດໜ້າ	0	\N	\N
670	319	1311	0	ເອື້ອຍ	0	\N	\N
671	458	252	0	ຮ້ອນ	0	\N	\N
672	458	323	0	ຮ້ອນ	0	\N	\N
673	458	331	0	ຮ້ອນ	0	\N	\N
674	62	90	0	ຮ້ານ	0	\N	\N
675	62	98	0	ຮ້ານ	0	\N	\N
676	44	114	0	ເຮັດ	0	\N	\N
677	44	210	0	ເຮັດ	0	\N	\N
683	84	405	0	ເຮືອນ	0	\N	\N
685	196	1229	0	ໂຮງອາຫານ	0	\N	\N
686	127	1053	0	ໂຮງຮຽນ	0	\N	\N
687	127	1264	0	ໂຮງຮຽນ	0	\N	\N
691	151	267	1	ໂຮງໝໍ	0	\N	\N
692	151	268	2	ໂຮງໝໍ	0	\N	\N
694	461	1237	0	ໜາວ	0	\N	\N
695	461	1258	0	ໜາວ	0	\N	\N
696	461	1273	0	ໜາວ	0	\N	\N
705	270	1072	1	ກວ້າງ	0	\N	\N
706	270	1170	2	ກວ້າງ	0	\N	\N
708	249	30	1	ຂ້ອຍ	0	\N	\N
709	249	180	2	ຂ້ອຍ	0	\N	\N
710	249	1327	3	ຂ້ອຍ	0	\N	\N
711	361	8	1	ເຂົ້າ	0	\N	\N
712	361	1074	2	ເຂົ້າ	0	\N	\N
713	361	149	3	ເຂົ້າ	0	\N	\N
714	248	1113	1	ເຂົາເຈົ້າ	0	\N	\N
716	248	216	3	ເຂົາເຈົ້າ	0	\N	\N
720	519	349	0	ຄັນຊັ້ນ	0	\N	\N
721	87	61	1	ກັບ　	0	\N	\N
722	87	1330	2	ກັບ　	0	\N	\N
723	523	1331	1	ກັບ　	0	\N	\N
724	524	1332	1	ກັບ　	0	\N	\N
725	141	1104	1	ກວດກາ	0	\N	\N
726	141	1333	2	ກວດກາ	0	\N	\N
728	233	1165	1	ກະເປົາ	0	\N	\N
729	233	1186	2	ກະເປົາ	0	\N	\N
730	233	1334	3	ກະເປົາ	0	\N	\N
731	75	349	1	ກະແຈ	0	\N	\N
732	75	1335	2	ກະແຈ	0	\N	\N
733	228	1161	1	ກະໂປ່ງ	0	\N	\N
734	228	1336	2	ກະໂປ່ງ	0	\N	\N
735	363	1337	1	ເກືອ	0	\N	\N
736	363	1235	2	ເກືອ	0	\N	\N
737	502	322	1	ແກ່	0	\N	\N
738	502	1338	2	ແກ່	0	\N	\N
739	272	1339	1	ໄກ	0	\N	\N
740	272	1340	2	ໄກ	0	\N	\N
741	522	1341	1	ໄກ່	0	\N	\N
742	522	1342	2	ໄກ່	0	\N	\N
743	525	1343	1	ຂຶ້ນ	0	\N	\N
744	118	1344	1	ຂວາ	0	\N	\N
745	350	1345	1	ຂາ	0	\N	\N
746	526	328	1	ເຂົ້າ	0	\N	\N
747	526	1346	2	ເຂົ້າ	0	\N	\N
748	356	1229	1	ເຂົ້າທ່ຽງ	0	\N	\N
749	356	1347	2	ເຂົ້າທ່ຽງ	0	\N	\N
750	518	1329	1	ແຂງແຮງ	0	\N	\N
751	518	1348	2	ແຂງແຮງ	0	\N	\N
758	491	1221	0	ຄົນ	0	\N	\N
759	521	317	1	ຄັນຊັ້ນ	0	\N	\N
760	521	360	2	ຄັນຊັ້ນ	0	\N	\N
761	521	1352	3	ຄັນຊັ້ນ	0	\N	\N
762	81	1353	1	ຄອບຄົວ	0	\N	\N
765	374	1354	1	ຄອມພິວເຕີ	0	\N	\N
766	374	1241	2	ຄອມພິວເຕີ	0	\N	\N
769	477	1357	1	ຄຳ	0	\N	\N
770	300	187	1	ສູງ	0	\N	\N
771	219	1358	1	ເຄື່ອງ	0	\N	\N
772	529	1359	1	ເງິນ	0	\N	\N
774	64	1360	2	ຈັກ -	0	\N	\N
778	516	1363	1	ຊື່	0	\N	\N
779	226	1364	1	ຊັ້ນ	0	\N	\N
780	289	1365	1	ຊົ່ວ	0	\N	\N
784	21	1366	0	ຊ້າ	0	\N	\N
785	530	39	0	ຊ້າ	0	\N	\N
786	530	1035	0	ຊ້າ	0	\N	\N
787	530	1194	0	ຊ້າ	0	\N	\N
788	178	1367	1	ຊາ	0	\N	\N
791	186	13	1	ແຊບ	0	\N	\N
792	186	16	2	ແຊບ	0	\N	\N
793	186	98	3	ແຊບ	0	\N	\N
797	347	1223	1	ດັງ	0	\N	\N
798	347	1370	2	ດັງ	0	\N	\N
799	120	1369	1	ຍາວ	0	\N	\N
800	120	1092	2	ຍາວ	0	\N	\N
806	393	1373	1	ເດືອນແລ້ວ	0	\N	\N
807	393	1259	2	ເດືອນແລ້ວ	0	\N	\N
808	268	1183	1	ຕຸ້ຍ	0	\N	\N
809	268	1374	2	ຕຸ້ຍ	0	\N	\N
810	114	1375	1	ຕັດ	0	\N	\N
811	366	1376	1	ຕິດ	0	\N	\N
813	212	1376	1	ຕິດ	0	\N	\N
814	212	1377	2	ຕິດ	0	\N	\N
815	345	1378	1	ຕີນ	0	\N	\N
818	348	1380	1	ຕາ	0	\N	\N
819	92	1073	1	ຕູ້ເຢັນ	0	\N	\N
820	92	1381	2	ຕູ້ເຢັນ	0	\N	\N
823	262	1382	1	ຕົວເອງ	0	\N	\N
824	262	1179	2	ຕົວເອງ	0	\N	\N
825	531	1383	1	ຖືກ	0	\N	\N
826	532	1384	1	ຖົງ	0	\N	\N
827	351	1225	1	ທ້ອງ	0	\N	\N
828	351	1385	2	ທ້ອງ	0	\N	\N
834	256	191	0	ນີ້	0	\N	\N
835	256	242	0	ນີ້	0	\N	\N
838	362	1233	1	ນ້ຳສະອິ້ວ	0	\N	\N
839	362	1387	2	ນ້ຳສະອິ້ວ	0	\N	\N
840	176	1388	1	ນ້ຳຕານ	0	\N	\N
841	176	1131	2	ນ້ຳຕານ	0	\N	\N
842	261	1178	1	ແນວນີ້	0	\N	\N
843	261	1389	2	ແນວນີ້	0	\N	\N
844	263	1180	1	ແນວນັ້ນ	0	\N	\N
845	263	1390	2	ແນວນັ້ນ	0	\N	\N
846	260	215	1	ແນວໃດ	0	\N	\N
847	260	184	2	ແນວໃດ	0	\N	\N
848	260	151	3	ແນວໃດ	0	\N	\N
849	260	321	4	ແນວໃດ	0	\N	\N
850	297	1275	0	ໃນ	0	\N	\N
851	297	1279	0	ໃນ	0	\N	\N
852	22	1036	1	 ບໍ່ເກັ່ງ	0	\N	\N
853	22	1391	2	 ບໍ່ເກັ່ງ	0	\N	\N
856	295	1393	1	ບໍ່ມ່ວນ	0	\N	\N
857	295	199	2	ບໍ່ມ່ວນ	0	\N	\N
858	274	1394	1	ບາງ	0	\N	\N
859	440	1285	1	ບາງເທື່ອ	0	\N	\N
860	440	1395	2	ບາງເທື່ອ	0	\N	\N
861	353	1226	1	ເບີ	0	\N	\N
862	353	1396	2	ເບີ	0	\N	\N
863	533	1397	1	ເບີ	0	\N	\N
864	220	1398	1	ໃບ	0	\N	\N
868	240	1399	1	ປ່ອງຢ້ຽມ	0	\N	\N
869	240	1172	2	ປ່ອງຢ້ຽມ	0	\N	\N
871	68	1043	0	ປາ	0	\N	\N
872	68	1400	2	ປາ	0	\N	\N
873	321	1401	1	ປ້າ	0	\N	\N
874	321	1207	2	ປ້າ	0	\N	\N
875	341	1402	1	ປາກ	0	\N	\N
876	417	1403	1	ປີໜ້າ	0	\N	\N
877	417	311	2	ປີໜ້າ	0	\N	\N
881	167	1322	1	ເປີດ	0	\N	\N
882	167	1405	2	ເປີດ	0	\N	\N
891	253	1177	1	 ຜູ້ໃດ	0	\N	\N
892	253	1408	2	 ຜູ້ໃດ	0	\N	\N
893	67	1409	1	ຜັກ	0	\N	\N
897	484	1411	1	ຜູ້ໃຫຍ່	0	\N	\N
898	484	1412	2	ຜູ້ໃຫຍ່	0	\N	\N
904	464	251	0	ຝົນ	0	\N	\N
905	313	1413	1	ພໍ່ເຖົ້າ	0	\N	\N
906	535	1414	1	ພໍ່ເຖົ້າ	0	\N	\N
907	317	1415	1	ພໍ່ແມ່	0	\N	\N
908	317	136	2	ພໍ່ແມ່	0	\N	\N
909	445	1416	1	ເພງ	0	\N	\N
910	445	1288	2	ເພງ	0	\N	\N
911	346	1417	1	ມື	0	\N	\N
912	511	1418	1	ມັດ	0	\N	\N
914	292	1419	1	ມິດ	0	\N	\N
915	292	1420	2	ມິດ	0	\N	\N
916	187	1421	1	ມີດ	0	\N	\N
918	279	1422	1	ມ່ວນ	0	\N	\N
919	279	1423	2	ມ່ວນ	0	\N	\N
923	536	1426	1	ແມ່ເຖົ້າ	0	\N	\N
924	312	1307	0	ແມ່ເຖົ້າ	0	\N	\N
928	373	1428	1	ໂມງ	0	\N	\N
929	373	1429	2	ໂມງ	0	\N	\N
930	184	1136	1	ໄມ້ຖູ່	0	\N	\N
931	184	1430	2	ໄມ້ຖູ່	0	\N	\N
932	122	1094	1	ຢືນ	0	\N	\N
933	122	1431	2	ຢືນ	0	\N	\N
934	153	1432	1	ຢາ	0	\N	\N
935	109	1124	0	ຢູ່ໃສ	0	\N	\N
936	109	237	2	ຢູ່ໃສ	0	\N	\N
937	469	1433	1	ເຢັນ	0	\N	\N
938	316	1434	1	ລຸງ	0	\N	\N
939	316	335	2	ລຸງ	0	\N	\N
940	159	1115	1	ລິບ	0	\N	\N
941	159	1435	2	ລິບ	0	\N	\N
942	370	1436	1	ລຶບ	0	\N	\N
943	467	1437	0	ລົມ	0	\N	\N
944	467	1438	2	ລົມ	0	\N	\N
947	411	1270	1	ລະດູໃບໄມ້ຫຼົ່ນ	0	\N	\N
948	411	1440	2	ລະດູໃບໄມ້ຫຼົ່ນ	0	\N	\N
951	513	1255	0	ເລີ່ມ	0	\N	\N
952	513	49	1	ເລີ່ມ	0	\N	\N
955	20	1035	1	ແລ່ນ	0	\N	\N
956	20	1443	2	ແລ່ນ	0	\N	\N
959	406	1445	1	ວັນເສົາ	0	\N	\N
962	369	1238	1	ສໍ	0	\N	\N
963	369	1447	2	ສໍ	0	\N	\N
964	537	1448	1	ສົ່ງ	0	\N	\N
965	537	1120	0	ສົ່ງ	0	\N	\N
966	115	1090	1	ສັ້ນ	0	\N	\N
967	115	1449	2	ສັ້ນ	0	\N	\N
970	499	1450	1	ສີນ້ຳຕານ	0	\N	\N
971	499	1317	2	ສີນ້ຳຕານ	0	\N	\N
972	498	1451	1	ສີຟ້າ	0	\N	\N
975	140	1452	1	ສອນ	0	\N	\N
976	140	387	2	ສອນ	0	\N	\N
977	507	1453	1	ສະດວກ	0	\N	\N
978	16	1033	1	ສະຖານທູດ	0	\N	\N
979	16	1454	2	ສະຖານທູດ	0	\N	\N
980	218	1156	1	ສະແຕັມ	0	\N	\N
981	218	1455	2	ສະແຕັມ	0	\N	\N
984	462	1457	1	ຫິມະ	0	\N	\N
985	462	1300	2	ຫິມະ	0	\N	\N
986	59	1458	1	ຫົວ 	0	\N	\N
987	50	1053	1	ຫໍສະໝຸດ	0	\N	\N
988	50	1459	2	ຫໍສະໝຸດ	0	\N	\N
989	308	1460	1	ຫຼັງ	0	\N	\N
990	116	1461	1	ຫຼັງ	0	\N	\N
991	538	1462	1	ຫຼັງ	0	\N	\N
992	539	1463	1	ຫຼັງ	0	\N	\N
993	485	1464	1	ຫຼາຍ	0	\N	\N
994	182	1465	1	ຫວານ	0	\N	\N
995	540	1466	1	ຫ້ອງ	0	\N	\N
996	541	1467	1	ຖ້ວຍ	0	\N	\N
997	542	1468	1	ຈອກ	0	\N	\N
999	544	1470	1	ກັບ　	0	\N	\N
1000	301	1471	1	ລວງກວ້າງ	0	\N	\N
1001	296	1472	1	ລວງຍາວ	0	\N	\N
1003	545	1473	1	ຫຼາຍ	0	\N	\N
1004	545	1474	2	ຫຼາຍ	0	\N	\N
1005	280	1475	1	ອຶກກະທຶກ	0	\N	\N
1006	466	1302	1	ອຸ່ນ	0	\N	\N
1007	466	1476	2	ອຸ່ນ	0	\N	\N
1008	444	1477	1	ອັນເຂ່ຍຂີ້ກອກຢາ	0	\N	\N
1009	444	1287	2	ອັນເຂ່ຍຂີ້ກອກຢາ	0	\N	\N
1012	500	1318	1	ອ່ອນ	0	\N	\N
1013	500	1479	2	ອ່ອນ	0	\N	\N
1014	546	1480	1	ອ່ອນ	0	\N	\N
1015	284	1481	1	ອ່ອນແອ	0	\N	\N
1018	398	1483	1	ອາທິດນີ້	0	\N	\N
1019	323	1046	1	ເອື້ອຍ	0	\N	\N
1020	323	1484	2	ເອື້ອຍ	0	\N	\N
1023	73	1486	1	ເອົາໃຫ້	0	\N	\N
1028	453	1489	1	ຮູບແຕ້ມ	0	\N	\N
1029	446	1289	1	ຮ້ອງເພງ	0	\N	\N
1030	446	1490	2	ຮ້ອງເພງ	0	\N	\N
1031	74	1063	1	ຮ້ານຂາຍຜັກ	0	\N	\N
1032	74	1491	2	ຮ້ານຂາຍຜັກ	0	\N	\N
1033	195	1142	1	ຮ້ານອາຫານ	0	\N	\N
1034	195	1492	2	ຮ້ານອາຫານ	0	\N	\N
1035	245	1175	0	ເຮືອນຊຸດ	0	\N	\N
1036	245	1493	2	ເຮືອນຊຸດ	0	\N	\N
1037	7	1494	1	ໂຮງແຮມ	0	\N	\N
1038	7	368	2	ໂຮງແຮມ	0	\N	\N
1039	273	1495	1	ໜັກ	0	\N	\N
1040	273	1496	2	ໜັກ	0	\N	\N
1041	549	1497	1	ເຮັດ	0	\N	\N
1042	548	1498	1	ໜັງ	0	\N	\N
1043	548	1499	2	ໜັງ	0	\N	\N
1044	293	1500	1	ໜ້ອຍ	0	\N	\N
1045	344	1501	1	ໜ້າ	0	\N	\N
1046	117	1502	1	ໜ້າ	0	\N	\N
1047	550	1503	1	ໜ້າ	0	\N	\N
1051	437	1504	1	ໝົດ	0	\N	\N
1052	437	1505	2	ໝົດ	0	\N	\N
1057	551	1508	1	ແດດອອກ	0	\N	\N
1058	551	1509	2	ແດດອອກ	0	\N	\N
1059	93	1074	1	ລ້າງ	0	\N	\N
1060	93	1441	2	ລ້າງ	0	\N	\N
1061	93	1510	3	ລ້າງ	0	\N	\N
1062	93	1511	4	ລ້າງ	0	\N	\N
1067	556	1513	1	ຢູ່	0	\N	\N
1069	13	1515	1	ການທ່ອງທ່ຽວ	0	\N	\N
1070	13	1031	2	ການທ່ອງທ່ຽວ	0	\N	\N
1071	19	404	0	ເກັ່ງ	0	\N	\N
1072	19	82	1	ເກັ່ງ	0	\N	\N
1075	277	1516	0	ໃກ້	0	\N	\N
1076	358	146	0	ເຂົ້າໜົມ	0	\N	\N
1077	359	1349	1	ໄຂ່	0	\N	\N
1078	359	1231	2	ໄຂ່	0	\N	\N
1079	495	1037	0	ຄົນ	0	\N	\N
1080	495	1034	1	ຄົນ	0	\N	\N
1081	495	33	2	ຄົນ	0	\N	\N
1082	495	1095	3	ຄົນ	0	\N	\N
1085	543	85	1	ຄົນ	0	\N	\N
1086	543	86	2	ຄົນ	0	\N	\N
1087	543	1469	3	ຄົນ	0	\N	\N
1088	266	1361	1	ຈ່ອຍ	0	\N	\N
1089	266	187	2	ຈ່ອຍ	0	\N	\N
1090	205	64	1	ເຈົ້າ	0	\N	\N
1091	205	5	2	ເຈົ້າ	0	\N	\N
1092	205	92	3	ເຈົ້າ	0	\N	\N
1093	97	28	1	ຊື່	0	\N	\N
1094	97	29	2	ຊື່	0	\N	\N
1095	71	225	1	ຊີ້ນ	0	\N	\N
1096	71	226	2	ຊີ້ນ	0	\N	\N
1099	207	1149	1	ເຊີນ	0	\N	\N
1100	207	89	2	ເຊີນ	0	\N	\N
1102	306	1070	0	ເທິງ	0	\N	\N
1103	306	1518	2	ເທິງ	0	\N	\N
1104	257	71	1	ນັ້ນ	0	\N	\N
1105	257	327	2	ນັ້ນ	0	\N	\N
1106	204	1392	1	ບໍ່	0	\N	\N
1107	204	161	2	ບໍ່	0	\N	\N
1108	146	197	1	ບັນຫາ	0	\N	\N
1109	146	389	2	ບັນຫາ	0	\N	\N
1110	28	204	1	ບໍ່ມັກ	0	\N	\N
1111	28	205	2	ບໍ່ມັກ	0	\N	\N
1112	28	267	3	ບໍ່ມັກ	0	\N	\N
1115	42	1519	1	ບໍລິສັດ	0	\N	\N
1116	42	235	2	ບໍລິສັດ	0	\N	\N
1117	160	1520	1	ປີ້	0	\N	\N
1118	160	1116	2	ປີ້	0	\N	\N
1121	10	1521	1	ປະເທດ	0	\N	\N
1122	10	1201	2	ປະເທດ	0	\N	\N
1125	324	1044	1	ພໍ່	0	\N	\N
1126	324	1163	2	ພໍ່	0	\N	\N
1127	333	1522	1	ແພມົນ	0	\N	\N
1128	333	1212	2	ແພມົນ	0	\N	\N
1129	557	1523	1	ນ້ຳ	0	\N	\N
1130	557	1524	2	ນ້ຳ	0	\N	\N
1131	558	1525	1	ຮຽນ	0	\N	\N
1132	558	1526	2	ຮຽນ	0	\N	\N
1133	559	1527	1	ມາ	0	\N	\N
1134	559	1528	2	ມາ	0	\N	\N
1135	561	1529	1	ຫວີ	0	\N	\N
1136	560	1530	1	ຫວີ	0	\N	\N
1139	563	1531	1	ມີ	0	\N	\N
1140	563	1533	2	ມີ	0	\N	\N
1141	562	1532	1	ມີ	0	\N	\N
1142	562	1534	2	ມີ	0	\N	\N
1143	564	1535	1	ພູ	0	\N	\N
1144	66	1060	0	ໝາກໄມ້	0	\N	\N
1145	66	1506	1	ໝາກໄມ້	0	\N	\N
1146	66	1536	3	ໝາກໄມ້	0	\N	\N
1147	448	1537	1	ໜັງ	0	\N	\N
1148	448	1538	2	ໜັງ	0	\N	\N
1149	53	1539	1	ໜັງສືພິມ	0	\N	\N
1150	53	115	2	ໜັງສືພິມ	0	\N	\N
1151	454	1488	1	ຮູບ	0	\N	\N
1152	454	1295	2	ຮູບ	0	\N	\N
1153	465	1482	1	ອາກາດ	0	\N	\N
1154	465	1301	2	ອາກາດ	0	\N	\N
1158	309	1541	1	ລູກເອື້ອຍລູກນ້ອງ	0	\N	\N
1159	309	1204	2	ລູກເອື້ອຍລູກນ້ອງ	0	\N	\N
1160	441	1442	1	ເລື້ອຍໆ	0	\N	\N
1161	441	291	2	ເລື້ອຍໆ	0	\N	\N
1162	434	239	0	ແລ້ວ	0	\N	\N
1163	434	87	1	ແລ້ວ	0	\N	\N
1164	72	70	1	ຢາກໄດ້	0	\N	\N
1165	72	119	2	ຢາກໄດ້	0	\N	\N
1166	72	394	3	ຢາກໄດ້	0	\N	\N
1169	426	1542	1	ມື້ຄືນນີ້	0	\N	\N
1170	426	1278	2	ມື້ຄືນນີ້	0	\N	\N
1171	433	1543	1	ມື້ຊືນ	0	\N	\N
1172	433	1283	2	ມື້ຊືນ	0	\N	\N
1173	422	95	1	ມື້ນີ້	0	\N	\N
1174	422	323	2	ມື້ນີ້	0	\N	\N
1175	422	269	3	ມື້ນີ້	0	\N	\N
1176	134	35	1	ມະຫາວິທະຍາໄລ	0	\N	\N
1177	134	311	2	ມະຫາວິທະຍາໄລ	0	\N	\N
1187	314	369	1	ເມຍ	0	\N	\N
1188	314	393	2	ເມຍ	0	\N	\N
1189	424	1427	1	ໂມງ	0	\N	\N
1190	424	44	2	ໂມງ	0	\N	\N
1191	424	45	3	ໂມງ	0	\N	\N
1192	113	1089	1	ຟັງ	0	\N	\N
1193	113	1076	2	ຟັງ	0	\N	\N
1195	463	1262	1	ຝົນຕົກ	0	\N	\N
1196	463	1278	2	ຝົນຕົກ	0	\N	\N
1197	232	1544	1	ກະລຸນາ	0	\N	\N
1198	232	280	2	ກະລຸນາ	0	\N	\N
1203	565	1372	1	ກິນ	0	\N	\N
1204	565	1545	2	ກິນ	0	\N	\N
1208	277	291	0	ໃກ້	0	\N	\N
1209	277	1160	0	ໃກ້	0	\N	\N
1211	527	1355	0	ຄຳ	0	\N	\N
1212	528	1356	0	ຄຳ	0	\N	\N
1213	567	1362	0	ຈານ	0	\N	\N
1214	568	242	0	ຊົ່ວໂມງ	0	\N	\N
1215	568	1096	0	ຊົ່ວໂມງ	0	\N	\N
1216	442	1322	0	ຊົ່ວໂມງ	0	\N	\N
1218	555	1507	0	ຢູ່	0	\N	\N
1219	241	1514	0	ຢູ່	0	\N	\N
1220	169	1123	0	ຫ້ອງນ້ຳ	0	\N	\N
1221	314	1424	0	ເມຍ	0	\N	\N
1222	569	356	0	ເລື່ອງ	0	\N	\N
1223	378	1246	0	ບິກ	0	\N	\N
1229	331	1161	0	ນຸ່ງ 	0	\N	\N
1230	331	1210	0	ນຸ່ງ 	0	\N	\N
1232	339	1219	0	ເຄື່ອງນຸ່ງ	0	\N	\N
1233	78	1067	0	ຊັກເຄື່ອງ	0	\N	\N
1236	153	1372	0	ຢາ	0	\N	\N
1237	525	1198	0	ຂຶ້ນ	0	\N	\N
1238	164	1386	0	ສະຖານີ	0	\N	\N
1239	584	1097	0	ສຽງ	0	\N	\N
1240	584	1176	0	ສຽງ	0	\N	\N
1241	39	1351	1	ຄົດ	0	\N	\N
1242	39	1547	2	ຄົດ	0	\N	\N
1243	352	1548	1	ຈານ	0	\N	\N
1244	476	1549	1	ພາສາ	0	\N	\N
1245	585	1550	1	ມັດ	0	\N	\N
1246	488	1551	1	ເມຍ	0	\N	\N
1247	570	1552	1	ແລ້ວ	0	\N	\N
1248	586	1553	1	ວຽກ	0	\N	\N
1249	587	1554	1	ເວລາ	0	\N	\N
1252	571	1556	1	ບໍ່	0	\N	\N
1253	571	1557	2	ບໍ່	0	\N	\N
1254	572	1558	1	ໃບ	0	\N	\N
1255	573	1559	1	ອອກໄປ	0	\N	\N
1256	574	1560	1	ອາກາດ	0	\N	\N
1257	244	1174	1	ອາບ	0	\N	\N
1258	244	1561	2	ອາບ	0	\N	\N
1259	576	1562	1	ນົມ	0	\N	\N
1260	577	1142	1	ປີ	0	\N	\N
1261	577	1563	2	ປີ	0	\N	\N
1262	580	1564	1	ຂໍໂທດ	0	\N	\N
1263	582	1565	1	ຂຶ້ນ	0	\N	\N
1264	583	1566	1	ລົງ	0	\N	\N
1265	588	1567	1	ຕູ້	0	\N	\N
1266	589	1568	1	ຫຍັງ	0	\N	\N
1267	590	1569	1	ນ້ອງຊາຍ	0	\N	\N
1268	591	1570	1	ນ້ອງສາວ	0	\N	\N
1269	36	1045	1	ແມ່ນ້ຳ	0	\N	\N
1270	36	1571	2	ແມ່ນ້ຳ	0	\N	\N
1271	575	1572	1	ອາທິດ	0	\N	\N
1272	579	1573	1	ປາຍ	0	\N	\N
1273	593	1574	1	ເລີກ	0	\N	\N
1274	593	1575	2	ເລີກ	0	\N	\N
1280	594	1576	1	ເລີກ	0	\N	\N
1281	594	1575	2	ເລີກ	0	\N	\N
1282	191	1234	1	ກິນ	0	\N	0
1283	191	8	2	ກິນ	0	\N	0
1284	191	10	3	ກິນ	0	\N	0
1285	222	310	0	ຊື້	0	\N	0
1286	222	52	1	ຊື້	0	\N	0
1287	436	1258	1	ຍັງ	0	\N	0
1288	436	1188	2	ຍັງ	0	\N	0
1289	436	1184	3	ຍັງ	0	\N	0
1290	436	314	4	ຍັງ	0	\N	0
1291	436	334	5	ຍັງ	0	\N	0
1292	259	1177	1	ໃດ	0	\N	0
1293	259	97	2	ໃດ	0	\N	0
1294	259	184	3	ໃດ	0	\N	0
1295	286	1379	1	ຕະຫຼົກ	0	\N	0
1296	286	189	2	ຕະຫຼົກ	0	\N	0
1297	14	1032	1	ທ່ຽວ	0	\N	0
1298	14	1515	2	ທ່ຽວ	0	\N	0
1299	14	1546	3	ທ່ຽວ	0	\N	0
1300	14	1031	4	ທ່ຽວ	0	\N	0
1305	55	1082	1	ປຶ້ມ	0	\N	0
1306	55	1069	2	ປຶ້ມ	0	\N	0
1307	55	177	3	ປຶ້ມ	0	\N	0
1308	534	1404	1	ເປີດ	0	\N	0
1309	534	324	2	ເປີດ	0	\N	0
1310	455	1296	1	ມັກ	0	\N	0
1311	455	1269	2	ມັກ	0	\N	0
1312	455	205	3	ມັກ	0	\N	0
1313	325	1425	1	ແມ່	0	\N	0
1314	325	345	2	ແມ່	0	\N	0
1315	414	1439	1	ລະດູຮ້ອນ	0	\N	0
1316	414	254	2	ລະດູຮ້ອນ	0	\N	0
1317	403	1444	1	ວັນຈັນ	0	\N	0
1318	403	363	2	ວັນຈັນ	0	\N	0
1319	138	1540	1	ວຽກບ້ານ	0	\N	0
1320	138	1446	2	ວຽກບ້ານ	0	\N	0
1321	138	356	3	ວຽກບ້ານ	0	\N	0
1322	329	1456	1	ໃສ່	0	\N	0
1323	329	349	2	ໃສ່	0	\N	0
1327	290	1555	1	ຫຼາຍ	0	\N	0
1328	290	174	2	ຫຼາຍ	0	\N	0
1329	9	1478	1	ອອກໄປ	0	\N	0
1330	9	347	2	ອອກໄປ	0	\N	0
1331	54	1305	1	ອ່ານ	0	\N	0
1332	54	115	2	ອ່ານ	0	\N	0
1333	54	357	3	ອ່ານ	0	\N	0
1334	322	1485	1	ອ້າຍ	0	\N	0
1335	322	347	2	ອ້າຍ	0	\N	0
1336	547	1487	1	ເອົາໃຫ້	0	\N	0
1337	547	57	2	ເອົາໃຫ້	0	\N	0
1338	48	1184	1	ເຮັດວຽກ	0	\N	0
1339	48	125	2	ເຮັດວຽກ	0	\N	0
1340	48	398	3	ເຮັດວຽກ	0	\N	0
1341	123	1230	1	ໝູ່	0	\N	0
1342	123	1065	2	ໝູ່	0	\N	0
1343	123	180	3	ໝູ່	0	\N	0
1344	52	1512	1	ຢືມ	0	\N	0
1345	52	379	2	ຢືມ	0	\N	0
1346	439	1528	1	ມື້ໃດ	0	\N	0
1347	439	1333	2	ມື້ໃດ	0	\N	0
1348	439	1538	3	ມື້ໃດ	0	\N	0
1349	439	128	4	ມື້ໃດ	0	\N	0
1352	252	1176	1	ໃຜ	0	\N	0
1353	252	1181	2	ໃຜ	0	\N	0
1354	252	179	3	ໃຜ	0	\N	0
1355	194	1225	1	ເຜັດ	0	\N	0
1356	194	15	2	ເຜັດ	0	\N	0
1357	194	16	3	ເຜັດ	0	\N	0
1365	258	1406	1	ເປັນແນວໃດ	0	\N	0
1366	258	1407	2	ເປັນແນວໃດ	0	\N	0
1367	258	215	3	ເປັນແນວໃດ	0	\N	0
1368	101	1191	1	ໂທລະທັດ	0	\N	0
1369	101	1386	2	ໂທລະທັດ	0	\N	0
1370	101	337	3	ໂທລະທັດ	0	\N	0
1371	77	1368	1	ຊື້ເຄື່ອງ	0	\N	0
1372	77	348	2	ຊື້ເຄື່ອງ	0	\N	0
1373	578	1577	1	ປິດ	0	\N	0
1374	1	6	1	ໄປ	0	\N	0
1375	1	1289	2	ໄປ	0	\N	0
1376	1	168	3	ໄປ	0	\N	0
1377	1	347	4	ໄປ	0	\N	0
1378	1	345	5	ໄປ	0	\N	0
1379	209	44	1	ມາຮອດ	0	\N	0
1380	209	1286	2	ມາຮອດ	0	\N	0
1381	489	320	1	ຜູ້ຍິງ	0	\N	0
1382	489	1410	2	ຜູ້ຍິງ	0	\N	0
1383	473	1199	1	ຂຽນ	0	\N	0
1384	473	383	2	ຂຽນ	0	\N	0
1385	473	63	3	ຂຽນ	0	\N	0
1386	148	1225	1	ເຈັບ	0	\N	0
1387	148	263	2	ເຈັບ	0	\N	0
1388	183	1135	1	ດື່ມ	0	\N	0
1389	183	1137	2	ດື່ມ	0	\N	0
1390	183	1126	3	ດື່ມ	0	\N	0
1391	128	1095	1	ນັກຮຽນ	0	\N	0
1392	128	182	2	ນັກຮຽນ	0	\N	0
1393	128	142	3	ນັກຮຽນ	0	\N	0
1394	243	1119	1	ປະຕູ	0	\N	0
1395	243	1177	2	ປະຕູ	0	\N	0
1396	243	327	3	ປະຕູ	0	\N	0
1397	243	326	4	ປະຕູ	0	\N	0
1398	492	1329	1	ຜູ້ຊາຍ	0	\N	0
1399	492	1312	2	ຜູ້ຊາຍ	0	\N	0
1400	492	292	3	ຜູ້ຊາຍ	0	\N	0
1401	63	1145	1	ແພງ	0	\N	0
1402	63	74	2	ແພງ	0	\N	0
1403	581	1042	1	ມັກ	0	\N	0
1404	581	149	2	ມັກ	0	\N	0
1405	425	1225	1	ມື້ວານນີ້	0	\N	0
1406	425	274	2	ມື້ວານນີ້	0	\N	0
1407	425	11	3	ມື້ວານນີ້	0	\N	0
1408	423	1087	1	ມື້ອື່ນ	0	\N	0
1409	423	379	2	ມື້ອື່ນ	0	\N	0
1410	423	282	3	ມື້ອື່ນ	0	\N	0
1411	315	1066	1	ແມ່	0	\N	0
1412	315	373	2	ແມ່	0	\N	0
1413	247	1216	1	ລາວ	0	\N	0
1414	247	1167	2	ລາວ	0	\N	0
1415	247	1032	3	ລາວ	0	\N	0
1416	247	180	4	ລາວ	0	\N	0
1417	554	1403	1	ລາວ	0	\N	0
1418	554	251	2	ລາວ	0	\N	0
1419	400	1078	1	ວັນອາທິດ	0	\N	0
1420	400	50	2	ວັນອາທິດ	0	\N	0
1421	25	1037	1	ໄວ	0	\N	0
1422	25	62	2	ໄວ	0	\N	0
1423	501	1321	1	ສີ	0	\N	0
1424	501	322	2	ສີ	0	\N	0
1425	267	1186	1	ໃຫຍ່	0	\N	0
1426	267	1153	2	ໃຫຍ່	0	\N	0
1427	267	392	3	ໃຫຍ່	0	\N	0
1428	407	1104	1	ອາທິດ	0	\N	0
1429	407	1064	2	ອາທິດ	0	\N	0
1430	407	131	3	ອາທິດ	0	\N	0
1431	76	1140	1	ອາຫານ	0	\N	0
1432	76	11	2	ອາຫານ	0	\N	0
1433	85	1040	1	ເຮືອນ	0	\N	0
1434	85	392	2	ເຮືອນ	0	\N	0
1435	275	1248	1	ໃໝ່	0	\N	0
1436	275	158	2	ໃໝ່	0	\N	0
1437	79	1065	1	ອະນາໄມ	0	\N	0
1438	79	1578	2	ອະນາໄມ	0	\N	0
773	64	1059	1	ຈັກ -	0	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: lo
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
455	2
530	2
547	6
277	9
351	13
77	19
212	29
243	29
290	38
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
367	ໜຶ່ງເດືອນ	1	ໜ	31121
25	ໄວ	1	ວ	23250
54	ອ່ານ	1	ອ	27533
55	ປຶ້ມ	1	ປ	15550
56	ກັອບປີ້	1	ກ	160
57	ອັດ 	1	ອ	27530
58	ວາລະສານ	1	ວ	23025
59	ຫົວ 	1	ຫ	24240
60	ຊີ້ນງົວ	1	ຊ	7602
61	ຖືກ	1	ຖ	11000
62	ຮ້ານ	1	ຮ	28299
63	ແພງ	1	ພ	18506
64	ຈັກ -	1	ຈ	5500
65	ເທົ່າໃດ	1	ທ	11014
66	ໝາກໄມ້	1	ໝ	32502
67	ຜັກ	1	ຜ	16500
68	ປາ	1	ປ	15020
69	ຊີ້ນໝູ	1	ຊ	7603
70	ຊີ້ນໄກ່	1	ຊ	7601
71	ຊີ້ນ	1	ຊ	7600
72	ຢາກໄດ້	1	ຢ	21500
73	ເອົາໃຫ້	1	ອ	27270
74	ຮ້ານຂາຍຜັກ	1	ຮ	28301
75	ກະແຈ	1	ກ	101
76	ອາຫານ	1	ອ	27029
77	ຊື້ເຄື່ອງ	1	ຊ	7043
78	ຊັກເຄື່ອງ	1	ຊ	7501
79	ອະນາໄມ	1	ອ	27010
80	ຄອບຄົວ	1	ຄ	3601
81	ສວນ	1	ສ	6518
82	ເຮືອນ	1	ຮ	28399
83	ການເຮັດ	0	ກ	150
84	ກັບ　	1	ກ	155
85	ຕູ້ປຶ້ມ	1	ຕ	10081
86	ໂຕະ	1	ຕ	10130
87	ຕັ່ງ	1	ຕ	10510
88	ຫ້ອງ	1	ຫ	24500
89	ຕູ້ເຢັນ	1	ຕ	10083
90	ລ້າງ	1	ລ	22510
91	ຕຽງ	1	ຕ	10512
92	ວິທະຍຸ	1	ວ	23030
93	ເທັບ	1	ທ	12530
94	ຊື່	1	ຊ	7041
95	ນອນ	1	ນ	13532
96	ຕື່ນ	1	ຕ	10531
97	ໂທລະທັດ	1	ທ	11013
98	ຕຳຫຼວດ	1	ຕ	10280
99	ແຜນທີ່	1	ຜ	16509
100	ໃກ້ໆ	1	ກ	133
101	ຢູ່ນີ້	1	ຢ	21085
102	ຢູ່ຫັ້ນ 	1	ຢ	21087
103	ຢູ່ພຸ້ນ	1	ຢ	21086
104	ຢູ່ໃສ	1	ຢ	21082
105	ປ້ອມຕຳຫຼວດ	1	ປ	15555
106	ໃກ້	1	ກ	132
107	ຂ້າງ	1	ຂ	2500
108	ຟັງ	1	ຟ	19500
109	ຕັດ	1	ຕ	10521
110	ສັ້ນ	1	ສ	6511
111	ຫຼັງ	1	ຫຼ	33500
112	ໜ້າ	1	ໜ	31020
113	ຂວາ	1	ຂ	2999
114	ຊ້າຍ	1	ຊ	7505
115	ຍາວ	1	ຍ	8999
116	ນັ່ງ	1	ນ	13510
117	ຢືນ	1	ຢ	21501
118	ໝູ່	1	ໝ	32080
119	ຫ້ອງຮຽນ	1	ຫ	24505
120	ລະບຽງ	1	ລ	22019
121	ໂຮງຮຽນ	1	ຮ	28143
122	ນັກຮຽນ	1	ນ	13502
123	ການຮຽນ	0	ກ	\N
124	ນັກສຶກສາ	1	ນ	13500
125	ນັກສຶກສາຕ່າງປະເທດ	1	ນ	13501
126	ພັກລະດູຮ້ອນ	1	ພ	18501
127	ອາຈານ	1	ອ	27020
128	ມະຫາວິທະຍາໄລ	1	ມ	20010
129	ປຶ້ມຂຽນ	1	ປ	15551
130	ຊົ່ວໂມງຮຽນ	1	ຊ	7242
131	ຫັດແຕ່ງ	1	ຫ	24520
132	ວຽກບ້ານ	1	ວ	23501
133	ຍາກ	1	ຍ	8100
134	ສອນ	1	ສ	6514
135	ກວດກາ	1	ກ	146
136	ບົດຝຶກຫັດ	1	ບ	14520
137	ງ່າຍ	1	ງ	4000
138	ຝຶກຫັດ	1	ຝ	17000
139	ຄຳຖາມ	1	ຄ	3281
140	ບັນຫາ	1	ບ	14524
141	ຕອບ	1	ຕ	10540
142	ເຈັບ	1	ຈ	5506
143	ແຂ້ວ	1	ຂ	2998
144	ທ່ານໝໍ	1	ທ	12521
145	ໂຮງໝໍ	1	ຮ	28144
146	ເຈັບປ່ວຍ	1	ຈ	5507
147	ຢາ	1	ຢ	21020
148	ຕາຍ	1	ຕ	10519
149	ເປັນຫວັດ	1	ປ	15541
150	ທ້ອງ	1	ທ	12505
151	ອົງສາ	1	ອ	27512
152	ລິບ	1	ລ	22540
153	ປີ້	1	ປ	15046
154	ລົງ	1	ລ	22512
155	ຂັ້ນໄດ	1	ຂ	2700
156	ປິດ	1	ປ	15530
157	ສະຖານີ	1	ສ	6013
158	ລົດໄຟໃຕ້ດິນ	1	ລ	22522
159	ຂຶ້ນ	1	ຂ	2701
160	ເປີດ	1	ປ	15532
161	ຫ້ອງນ້ຳ	1	ຫ	24502
162	ລົດໄຟຟ້າ	1	ລ	22523
163	ເຄື່ອງດື່ມ	1	ຄ	3502
164	ກາເຟ	1	ກ	107
165	ຮ້ານກິນດື່ມ	1	ຮ	28300
166	ໝາກນາວ	1	ໝ	32501
167	ນົມ	1	ນ	13535
168	ນ້ຳຕານ	1	ນ	13283
169	ຈອກ	1	ຈ	5501
170	ຊາ	1	ຊ	7020
171	ຊາຝຣັ່ງ	1	ຊ	7021
172	ໃສ່	1	ສ	6261
173	ຫວານ	1	ຫວ	34001
174	ດື່ມ	1	ດ	9700
175	ໄມ້ຖູ່	1	ມ	20250
176	ເຫຼົ້າ	1	ຫຼ	33270
177	ແຊບ	1	ຊ	7700
178	ມີດ	1	ມ	20520
179	ບ່ວງ	1	ບ	14515
180	ສ້ອມ	1	ສ	6522
181	ເນີຍແຂງ	1	ນ	13521
182	ກິນ	1	ກ	151
183	ບໍ່ແຊບ	1	ບ	14161
184	ເຂົ້າຈີ່	1	ຂ	2272
185	ເຜັດ	1	ຜ	16501
186	ຮ້ານອາຫານ	1	ຮ	28303
187	ໂຮງອາຫານ	1	ຮ	28141
188	ເຄື່ອງກິນ	1	ຄ	3501
189	ກະຫຼີ່	1	ກ	106
190	ເງິນ	1	ງ	4001
191	ທະນາຄານ	1	ທ	11010
192	ທາງເຂົ້າ	1	ທ	12502
193	ເຊີນ, ບໍ່ເປັນຫຍັງ	0	ຊ	\N
194	ບໍ່	1	ບ	14159
195	ເຈົ້າ	1	ຈ	5270
196	ຂໍໂທດ	1	ຂ	2160
197	ເຊີນ	1	ຊ	7605
198	ທາງອອກ	1	ທ	12504
199	ມາຮອດ	1	ມ	20021
200	ຕູ້ໄປສະນີ	1	ຕ	10082
201	ໂປດສະກາດ	1	ປ	15531
202	ຕິດ	1	ຕ	10522
203	ຊອງ	1	ຊ	7502
204	ຈົດໝາຍ	1	ຈ	5504
205	ໄປສະນີ	1	ປ	15251
206	ຄືນ	1	ຄ	3512
207	ສົ່ງ	1	ສ	6501
208	ສະແຕັມ	1	ສ	6012
209	ເຄື່ອງ	1	ຄ	3500
210	ໃບ	1	ບ	14260
211	ໃຫ້ຢືມ	1	ຫ	24260
212	ຊື້	1	ຊ	7042
213	ໝວກ	1	ໝ	32505
214	ເກີບ	1	ກ	161
215	ຊັ້ນ	1	ຊ	7599
216	ຮ້ານສັບພະສິນຄ້າ	1	ຮ	28302
217	ກະໂປ່ງ	1	ກ	104
218	ເສື້ອຄຸມ	1	ສ	6221
219	ໂສ້ງ	1	ສ	6502
220	ເສື້ອແລນ	1	ສ	6229
221	ກະລຸນາ	1	ກ	105
222	ກະເປົາ	1	ກ	102
223	ຂາຍ	1	ຂ	2600
224	ເສື້ອຈັກເກັດ	1	ສ	6222
225	ອ່າງອາບນ້ຳ	1	ອ	27511
226	ຕຶກ	1	ຕ	10502
227	ຫ້ອງແຕ່ງກິນ	1	ຫ	24501
228	ນ້ຳຝັກບົວ	1	ນ	13285
229	ປ່ອງຢ້ຽມ	1	ປ	15513
230	ຢູ່	1	ຢ	21080
231	ສວນສາທາລະນະ	1	ສ	6519
232	ປະຕູ	1	ປ	15010
233	ອາບ	1	ອ	27539
234	ເຮືອນຊຸດ	1	ຮ	28400
235	ໜ້າບ້ານ	1	ໜ	31021
236	ລາວ	1	ລ	22550
237	ເຂົາເຈົ້າ	1	ຂ	2273
238	ຂ້ອຍ	1	ຂ	2601
239	ພວກເຮົາ	1	ພ	18502
240	ໃຜ	1	ຜ	16260
241	 ຜູ້ໃດ	1	ຜ	16086
242	ນີ້	1	ນ	13040
243	ນັ້ນ	1	ນ	13531
244	ເປັນແນວໃດ	1	ປ	15540
245	ໃດ	1	ດ	9260
246	ແນວໃດ	1	ນ	13539
247	ແນວນີ້	1	ນ	13541
248	ຕົວເອງ	1	ຕ	10243
249	ແນວນັ້ນ	1	ນ	13540
250	ໜາ	1	ໜ	31019
251	ແຄບ	1	ຄ	3600
252	ຈ່ອຍ	1	ຈ	5503
253	ໃຫຍ່	1	ຫຍ	30260
254	ຕຸ້ຍ	1	ຕ	10520
255	ໜຸ່ມ	1	ໜ	31140
256	ກວ້າງ	1	ກ	142
257	ເບົາ	1	ບ	14270
258	ໄກ	1	ກ	130
259	ໜັກ	1	ໜ	31110
260	ບາງ	1	ບ	14510
261	ໃໝ່	1	ໝ	32260
262	ນ້ອຍ	1	ນ	13520
263	ເກົ່າ	1	ກ	134
264	ມ່ວນ	1	ມ	20540
265	ອຶກກະທຶກ	1	ອ	27503
266	ຕຳ່	1	ຕ	10281
267	ດີ	1	ດ	9040
268	ແຈ້ງ	1	ຈ	5502
269	ອ່ອນແອ	1	ອ	27535
270	ແຂງແຮງ	1	ຂ	2501
271	ຕະຫຼົກ	1	ຕ	10010
272	ງາມ	1	ງ	4003
273	ໍຊ້າ	0	ຊ	\N
274	ຊົ່ວ	1	ຊ	7240
275	ຫຼາຍ	1	ຫຼ	33502
276	ມືດ	1	ມ	20521
277	ມິດ	1	ມ	20519
278	ໜ້ອຍ	1	ໜ	31130
279	ເປື້ອນ	1	ປ	15542
280	ບໍ່ມ່ວນ	1	ບ	14165
281	ລວງຍາວ	1	ລ	22513
282	ໃນ	1	ນ	13260
283	ນອກ	1	ນ	13505
284	ທິດຕາເວັນອອກ	1	ທ	12512
285	ສູງ	1	ສ	6500
286	ລວງກວ້າງ	1	ລ	22512
287	ທິດເໜືອ	1	ທ	12514
288	ທິດຕາເວັນຕົກ	1	ທ	12511
289	ກ້ອງ	1	ກ	143
290	ທິດໃຕ້	1	ທ	12513
291	ເທິງ	1	ທ	12506
292	ປາຍ	1	ປ	15520
293	ລູກເອື້ອຍລູກນ້ອງ	1	ລ	22503
294	ອ້າຍ	1	ອ	27521
295	ອ້າຍນ້ອງ	1	ອ	27522
296	ແມ່ເຖົ້າ	1	ມ	20122
316	ເຄື່ອງນຸ່ງຫົ່ມ	0	ຄ	\N
317	ປາກ	1	ປ	15501
318	ແຂນ	1	ຂ	2702
319	ຮ່າງກາຍ	1	ຮ	28139
320	ຕີນ	1	ຕ	10530
321	ມື	1	ມ	20060
322	ດັງ	1	ດ	9503
323	ຕາ	1	ຕ	10020
324	ຫູ	1	ຫ	24080
325	ຂາ	1	ຂ	2020
326	ຈານ	1	ຈ	5505
327	ເບີ	1	ບ	14170
328	ຖ້ວຍ	1	ຖ	11003
329	ເຂົ້າໜົມອົມ	1	ຂ	2288
330	ເຂົ້າທ່ຽງ	1	ຂ	2275
331	ເຂົ້າແລງ	1	ຂ	2276
332	ເຂົ້າໜົມ	1	ຂ	2277
333	ໄຂ່	1	ຂ	2260
334	ເຂົ້າເຊົ້າ	1	ຂ	2271
335	ເຂົ້າ	1	ຂ	2270
336	ນ້ຳສະອິ້ວ	1	ນ	13281
337	ເກືອ	1	ກ	129
338	ຕື່ມ	1	ຕ	10545
339	ກ້ອງຖ່າຍຮູບ	1	ກ	144
340	ເຕົາຝີງໄຟ	1	ຕ	10270
341	ສໍ	1	ສ	6160
342	ລຶບ	1	ລ	22541
343	ແວ່ນຕາ	1	ວ	23700
344	ເຄື່ອງອັດເທັບ	0	ຄ	\N
345	ໂມງ	1	ມ	20510
346	ຄອມພິວເຕີ	1	ຄ	3702
347	ຟີມ	1	ຟ	19501
348	ປະຕູໃຫຍ່	1	ປ	15011
349	ບິກ	1	ບ	14503
350	ປາກກາ	1	ປ	15502
351	ເດືອນ8	1	ດ	9608
352	ເດືອນ4	1	ດ	9604
353	ເດືອນນີ້	1	ດ	9615
354	ທຸກເດືອນ	1	ທ	11502
355	ເດືອນ12	1	ດ	9612
356	ເດືອນ2	1	ດ	9602
357	ເດືອນ1	1	ດ	9601
358	ເດືອນ7	1	ດ	9607
359	ເດືອນ6	1	ດ	9606
360	ເດືອນໜ້າ	1	ດ	9617
361	ເດືອນ5	1	ດ	9605
362	ເດືອນ3	1	ດ	9603
363	ເດືອນແລ້ວ	1	ດ	9616
364	ເດືອນ11	1	ດ	9611
365	ເດືອນ10	1	ດ	9610
366	ເດືອນ9	1	ດ	9609
368	ອາທິດນີ້	1	ອ	27022
369	ທຸກອາທິດ	1	ທ	11505
370	ວັນອາທິດ	1	ວ	23609
371	ວັນພະຫັດ	1	ວ	23602
372	ອາທິດໜ້າ	1	ອ	27023
373	ວັນຈັນ	1	ວ	23599
374	ວັນອັງຄານ	1	ວ	23600
375	ວັນພຸດ	1	ວ	23601
376	ວັນເສົາ	1	ວ	23604
377	ອາທິດ	1	ອ	27021
378	ອາທິດແລ້ວ	1	ອ	27025
379	ວັນສຸກ	1	ວ	23603
380	ປີ	1	ປ	15037
381	ລະດູໃບໄມ້ຫຼົ່ນ	1	ລ	22011
382	ປີນີ້	1	ປ	15040
383	ທຸກປີ	1	ທ	11503
384	ລະດູຮ້ອນ	1	ລ	22012
385	ລະດູໜາວ	1	ລ	22013
386	ປີກາຍ	1	ປ	15038
387	ປີໜ້າ	1	ປ	15042
388	ລະດູໃບໄມ້ປົ່ງ	1	ລ	22010
389	ປີໃນ	1	ປ	15041
390	ປີກ່ອນ	1	ປ	15039
391	ຕອນແລງ	1	ຕ	10536
392	ມື້ນີ້	1	ມ	20064
393	ມື້ອື່ນ	1	ມ	20066
394	ມື້ວານນີ້	1	ມ	20065
395	ມື້ຄືນນີ້	1	ມ	20061
396	ຕອນເຊົ້າ	1	ຕ	10534
397	ເຊົ້າ	1	ຊ	7271
398	ຕອນທ່ຽງ	1	ຕ	10535
399	ຕອນກາງຄືນ	1	ຕ	10532
400	ຕອນຄຳ່	1	ຕ	10533
10	ປະເທດ	1	ປ	15012
11	ພົບ	1	ພ	18807
12	ພັກຜ່ອນ	1	ພ	18500
13	ການທ່ອງທ່ຽວ	0	ກ	\N
14	ທ່ຽວ	1	ທ	12531
15	ຫຼິ້ນ	1	ຫຼ	33501
16	ສະຖານທູດ	1	ສ	6014
17	ມັກຫຼາຍ	1	ມ	20501
18	ມັກ	1	ມ	20500
19	ເກັ່ງ	1	ກ	140
20	ແລ່ນ	1	ລ	22530
21	ຊ້າ	1	ຊ	7022
22	 ບໍ່ເກັ່ງ	1	ບ	14160
23	ຍ່າງ	1	ຍ	8210
24	ລອຍນຳ້	1	ລ	22518
26	ບິນ	1	ບ	14525
27	ກິລາ	1	ກ	111
28	ບໍ່ມັກ	1	ບ	14163
29	ສະລອຍນ້ຳ	1	ສ	6015
30	ລົດເມ	1	ລ	22529
31	ລົດຖີບ	1	ລ	22521
32	ທາງສີ່ແຍກ	1	ທ	12503
33	ທາງ	1	ທ	12501
34	ໜອງ	1	ໜ	31125
35	ຍ່າງຫຼິ້ນ	1	ຍ	8211
36	ແມ່ນ້ຳ	1	ມ	20123
37	ຕັກຊີ່	1	ຕ	10501
38	ລົດ	1	ລ	22520
39	ຄົດ	1	ຄ	3505
40	ກາລະວັດ	1	ກ	108
41	ເສື້ອເຊີດ	1	ສ	6223
42	ບໍລິສັດ	1	ບ	14158
43	ສູດ	1	ສ	6510
44	ເຮັດ	1	ຮ	28200
45	ສູບ	1	ສ	6520
46	ໂທລະສັບ	1	ທ	11012
47	ວຽກ	1	ວ	23500
48	ເຮັດວຽກ	1	ຮ	28201
49	ຫຍຸ້ງ	1	ຫຍ	30262
50	ຫໍສະໝຸດ	1	ຫ	24160
51	ວັດຈະນານຸກົມ	1	ວ	23505
52	ຢືມ	1	ຢ	21505
53	ໜັງສືພິມ	1	ໜ	31120
1	ໄປ	1	ປ	15250
2	ພາສາອັງກິດ	1	ພ	18029
3	ຍົນ	1	ຍ	8300
4	ຕ່າງປະເທດ	1	ຕ	10511
5	ຄົນຕ່າງປະເທດ	1	ຄ	3514
6	ພາສາລາວ	1	ພ	18028
7	ໂຮງແຮມ	1	ຮ	28142
8	ພາສາຍີ່ປຸ່ນ	1	ພ	18025
9	ອອກໄປ	1	ອ	27505
297	ພໍ່ເຖົ້າ	1	ພ	18162
298	ເມຍ	1	ມ	20200
299	ແມ່	1	ມ	20120
300	ລຸງ	1	ລ	22511
301	ພໍ່ແມ່	1	ພ	18165
302	ພໍ່	1	ພ	18160
303	ເອື້ອຍ	1	ອ	27523
304	ເອື້ອຍນ້ອງ	1	ອ	27524
305	ປ້າ	1	ປ	15022
306	ຖົງຕີນ	1	ຖ	11002
307	ເສື້ອ	1	ສ	6220
308	ແກ້ເຄື່ອງ	1	ກ	122
309	ນຸ່ງ 	1	ນ	13511
310	ແພມົນ	1	ພ	18120
311	ເກີບແຕະ	1	ກ	162
312	ຄັນຮົ່ມ	1	ຄ	3511
313	ຖົງ	1	ຖ	11001
314	ກະເປົາເງິນ	1	ກ	103
315	ເຄື່ອງນຸ່ງ	1	ຄ	3503
401	ມື້ຮື	1	ມ	20067
402	ມື້ຊືນ	1	ມ	20062
403	ແລ້ວ	1	ລ	22551
404	ທັງ -  ທັງ	1	ທ	12500
405	ຍັງ	1	ຍ	8200
406	ໝົດ	1	ໝ	32506
407	ເວລາ	1	ວ	23100
408	ມື້ໃດ	1	ມ	20063
409	ບາງເທື່ອ	1	ບ	14511
410	ເລື້ອຍໆ	1	ລ	22519
411	ຊົ່ວໂມງ	1	ຊ	7241
412	ທັນທີ	1	ທ	12520
413	ອັນເຂ່ຍຂີ້ກອກຢາ	1	ອ	27532
414	ເພງ	1	ພ	18505
415	ຮ້ອງເພງ	1	ຮ	28140
416	ຢາສູບ	1	ຢ	21021
417	ໜັງ	1	ໜ	31119
418	ແຜ່ນສຽງ	1	ຜ	16510
419	ກີຕ້າ	1	ກ	112
420	ດົນຕີ	1	ດ	9600
421	ຮູບແຕ້ມ	1	ຮ	28405
422	ຮູບ	1	ຮ	28403
423	ສຽງ	1	ສ	6509
425	ຮ້ອນ	1	ຮ	28366
426	ອາກາດປອດໂປ່ງ	1	ອ	27502
427	ເຢັນ	1	ຢ	21502
428	ໜາວ	1	ໜ	31150
429	ຫິມະ	1	ຫ	24030
430	ຝົນຕົກ	1	ຝ	17001
431	ຝົນ	1	ຝ	17002
432	ອາກາດ	1	ອ	27019
433	ອຸ່ນ	1	ອ	27533
434	ລົມ	1	ລ	22542
435	ຟ້າບົດ	1	ຟ	19020
436	ຄຶ້ມ	1	ຄ	3701
437	ຕົວອັກສອນຄັນຈິ	1	ຕ	10241
438	ເວົ້າ	1	ວ	23270
439	ຂຽນ	1	ຂ	2705
440	ເລື່ອງ	1	ລ	22512
441	ພາສາ	1	ພ	18021
442	ຄຳ	1	ຄ	3280
443	ປະໂຫຍກ	1	ປ	15019
444	ເລົ່າ	1	ລ	22271
445	ຄວາມໝາຍ	1	ຄ	3703
446	ຕົວອັກສອນຮິລະກະນະ	1	ຕ	10242
447	ຕົວອັກສອນຄະຕະກະນະ	1	ຕ	10240
448	ຜູ້ໃຫຍ່	1	ຜ	16089
449	ຜົວເມຍ	1	ຜ	16241
450	ລູກ	1	ລ	22501
451	ຜູ້ຍິງ	1	ຜ	16085
452	ເດັກນ້ອຍຜູ້ຊາຍ	1	ດ	9502
453	ຄົນ	1	ຄ	3513
454	ຜູ້ຊາຍ	1	ຜ	16080
455	ເດັກນ້ອຍຜູ້ຍິງ	1	ດ	9501
456	ຜົວ	1	ຜ	16240
457	ທຸກຄົນ	1	ທ	11501
458	ສີຂາວ	1	ສ	6041
459	ສີຟ້າ	1	ສ	6047
460	ສີນ້ຳຕານ	1	ສ	6046
461	ອ່ອນ	1	ອ	27534
462	ສີ	1	ສ	6040
463	ແກ່	1	ກ	121
464	ສີເຫຼືອງ	1	ສ	6048
465	ສີດຳ	1	ສ	6044
466	ສີແດງ	1	ສ	6045
467	ສີຂຽວ	1	ສ	6042
468	ສະດວກ	1	ສ	6011
469	ງານລ້ຽງ	1	ງ	4002
470	ເຈ້ຍ	1	ຈ	5200
471	ກາຍເປັນ	1	ກ	145
472	ມັດ	1	ມ	20518
473	ຍູ້	1	ຍ	8000
474	ເລີ່ມ	1	ລ	22543
475	ພໍດີ	1	ພ	18159
476	ບໍ່ມີ	1	ບ	14162
477	ມີຊື່ສຽງ	1	ມ	20042
478	ຄັນຊັ້ນ	1	ຄ	3510
479	ຄືຊິ	1	ຄ	3060
480	ໄກ່	1	ກ	131
481	ແດດອອກ	1	ດ	9504
484	ນ້ຳ	1	ນ	13280
485	ຮຽນ	1	ຮ	28377
486	ມາ	1	ມ	20020
487	ຫວີ	1	ຫວ	34000
488	ມີ	1	ມ	20040
489	ພູ	1	ພ	18080
490	ຕູ້	1	ຕ	10080
491	ຫຍັງ	1	ຫຍ	30261
492	ນ້ອງສາວ	1	ນ	13512
493	ນ້ອງຊາຍ	1	ນ	13513
494	ເລີກ	1	ລ	22505
424	ຟ້າແຈ້ງ	0	ຟ	\N
483	ອາວ	0	ອ	\N
482	ອາ	0	ອ	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: lo
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
182		\N		\N	\N	\N	8	\N
182		\N		\N	\N	\N	10	\N
182		\N		\N	\N	\N	18	\N
182		\N		\N	\N	\N	107	\N
182		\N		\N	\N	\N	149	\N
182		\N		\N	\N	\N	151	\N
182		\N		\N	\N	\N	153	\N
182		\N		\N	\N	\N	155	\N
182		\N		\N	\N	\N	201	\N
182		\N		\N	\N	\N	202	\N
182		\N		\N	\N	\N	209	\N
182		\N		\N	\N	\N	293	\N
182		\N		\N	\N	\N	300	\N
182		\N		\N	\N	\N	333	\N
182		\N		\N	\N	\N	366	\N
182		\N		\N	\N	\N	367	\N
84		\N		\N	\N	\N	61	\N
27		\N		\N	\N	\N	211	\N
27		\N		\N	\N	\N	216	\N
221		\N		\N	\N	\N	280	\N
75		\N		\N	\N	\N	349	\N
75		\N		\N	\N	\N	352	\N
113		\N		\N	\N	\N	443	\N
238		\N		\N	\N	\N	18	\N
238		\N		\N	\N	\N	29	\N
238		\N		\N	\N	\N	30	\N
238		\N		\N	\N	\N	34	\N
238		\N		\N	\N	\N	36	\N
238		\N		\N	\N	\N	37	\N
238		\N		\N	\N	\N	42	\N
238		\N		\N	\N	\N	52	\N
238		\N		\N	\N	\N	59	\N
238		\N		\N	\N	\N	63	\N
238		\N		\N	\N	\N	107	\N
238		\N		\N	\N	\N	108	\N
238		\N		\N	\N	\N	113	\N
238		\N		\N	\N	\N	119	\N
238		\N		\N	\N	\N	132	\N
238		\N		\N	\N	\N	136	\N
238		\N		\N	\N	\N	143	\N
238		\N		\N	\N	\N	158	\N
238		\N		\N	\N	\N	168	\N
238		\N		\N	\N	\N	180	\N
238		\N		\N	\N	\N	190	\N
238		\N		\N	\N	\N	196	\N
238		\N		\N	\N	\N	213	\N
238		\N		\N	\N	\N	218	\N
238		\N		\N	\N	\N	221	\N
238		\N		\N	\N	\N	267	\N
238		\N		\N	\N	\N	278	\N
238		\N		\N	\N	\N	282	\N
238		\N		\N	\N	\N	285	\N
238		\N		\N	\N	\N	287	\N
238		\N		\N	\N	\N	305	\N
238		\N		\N	\N	\N	315	\N
238		\N		\N	\N	\N	370	\N
238		\N		\N	\N	\N	371	\N
238		\N		\N	\N	\N	373	\N
238		\N		\N	\N	\N	375	\N
238		\N		\N	\N	\N	380	\N
238		\N		\N	\N	\N	387	\N
238		\N		\N	\N	\N	391	\N
238		\N		\N	\N	\N	396	\N
238		\N		\N	\N	\N	397	\N
238		\N		\N	\N	\N	401	\N
325		\N		\N	\N	\N	80	\N
325		\N		\N	\N	\N	313	\N
325		\N		\N	\N	\N	315	\N
325		\N		\N	\N	\N	429	\N
439		\N		\N	\N	\N	63	\N
439		\N		\N	\N	\N	280	\N
439		\N		\N	\N	\N	383	\N
196		\N		\N	\N	\N	28	\N
196		\N		\N	\N	\N	39	\N
196		\N		\N	\N	\N	46	\N
479		\N		\N	\N	\N	242	\N
479		\N		\N	\N	\N	326	\N
39		\N		\N	\N	\N	390	\N
453		\N		\N	\N	\N	33	\N
453		\N		\N	\N	\N	34	\N
453		\N		\N	\N	\N	85	\N
453		\N		\N	\N	\N	86	\N
453		\N		\N	\N	\N	135	\N
453		\N		\N	\N	\N	136	\N
453		\N		\N	\N	\N	149	\N
453		\N		\N	\N	\N	150	\N
453		\N		\N	\N	\N	184	\N
453		\N		\N	\N	\N	187	\N
453		\N		\N	\N	\N	210	\N
453		\N		\N	\N	\N	230	\N
453		\N		\N	\N	\N	1009	\N
478		\N		\N	\N	\N	10	\N
478		\N		\N	\N	\N	48	\N
478		\N		\N	\N	\N	58	\N
478		\N		\N	\N	\N	317	\N
478		\N		\N	\N	\N	349	\N
478		\N		\N	\N	\N	354	\N
478		\N		\N	\N	\N	360	\N
445		\N		\N	\N	\N	287	\N
80		\N		\N	\N	\N	135	\N
80		\N		\N	\N	\N	137	\N
442		\N		\N	\N	\N	50	\N
442		\N		\N	\N	\N	178	\N
442		\N		\N	\N	\N	179	\N
442		\N		\N	\N	\N	269	\N
442		\N		\N	\N	\N	287	\N
137		\N		\N	\N	\N	197	\N
272		\N		\N	\N	\N	393	\N
204		\N		\N	\N	\N	63	\N
252		\N		\N	\N	\N	187	\N
326		\N		\N	\N	\N	242	\N
326		\N		\N	\N	\N	245	\N
326		\N		\N	\N	\N	246	\N
326		\N		\N	\N	\N	356	\N
326		\N		\N	\N	\N	1002	\N
94		\N		\N	\N	\N	28	\N
94		\N		\N	\N	\N	29	\N
94		\N		\N	\N	\N	30	\N
94		\N		\N	\N	\N	278	\N
94		\N		\N	\N	\N	280	\N
94		\N		\N	\N	\N	397	\N
94		\N		\N	\N	\N	401	\N
212		\N		\N	\N	\N	52	\N
212		\N		\N	\N	\N	58	\N
212		\N		\N	\N	\N	78	\N
212		\N		\N	\N	\N	83	\N
212		\N		\N	\N	\N	158	\N
212		\N		\N	\N	\N	211	\N
212		\N		\N	\N	\N	213	\N
212		\N		\N	\N	\N	310	\N
212		\N		\N	\N	\N	317	\N
212		\N		\N	\N	\N	348	\N
215		\N		\N	\N	\N	10	\N
215		\N		\N	\N	\N	48	\N
215		\N		\N	\N	\N	58	\N
215		\N		\N	\N	\N	243	\N
215		\N		\N	\N	\N	317	\N
215		\N		\N	\N	\N	349	\N
215		\N		\N	\N	\N	353	\N
215		\N		\N	\N	\N	354	\N
215		\N		\N	\N	\N	360	\N
71		\N		\N	\N	\N	224	\N
71		\N		\N	\N	\N	225	\N
71		\N		\N	\N	\N	226	\N
71		\N		\N	\N	\N	230	\N
71		\N		\N	\N	\N	295	\N
274		\N		\N	\N	\N	134	\N
274		\N		\N	\N	\N	242	\N
411		\N		\N	\N	\N	134	\N
411		\N		\N	\N	\N	242	\N
170		\N		\N	\N	\N	143	\N
170		\N		\N	\N	\N	211	\N
170		\N		\N	\N	\N	215	\N
170		\N		\N	\N	\N	292	\N
170		\N		\N	\N	\N	298	\N
170		\N		\N	\N	\N	311	\N
170		\N		\N	\N	\N	391	\N
21		\N		\N	\N	\N	39	\N
77		\N		\N	\N	\N	211	\N
77		\N		\N	\N	\N	213	\N
77		\N		\N	\N	\N	348	\N
405		\N		\N	\N	\N	9	\N
405		\N		\N	\N	\N	12	\N
405		\N		\N	\N	\N	25	\N
405		\N		\N	\N	\N	26	\N
405		\N		\N	\N	\N	28	\N
405		\N		\N	\N	\N	47	\N
405		\N		\N	\N	\N	51	\N
405		\N		\N	\N	\N	70	\N
405		\N		\N	\N	\N	77	\N
405		\N		\N	\N	\N	103	\N
405		\N		\N	\N	\N	105	\N
405		\N		\N	\N	\N	106	\N
405		\N		\N	\N	\N	112	\N
405		\N		\N	\N	\N	114	\N
405		\N		\N	\N	\N	140	\N
405		\N		\N	\N	\N	142	\N
405		\N		\N	\N	\N	147	\N
405		\N		\N	\N	\N	154	\N
405		\N		\N	\N	\N	165	\N
405		\N		\N	\N	\N	166	\N
405		\N		\N	\N	\N	173	\N
405		\N		\N	\N	\N	190	\N
405		\N		\N	\N	\N	191	\N
405		\N		\N	\N	\N	203	\N
405		\N		\N	\N	\N	210	\N
405		\N		\N	\N	\N	221	\N
405		\N		\N	\N	\N	225	\N
405		\N		\N	\N	\N	226	\N
405		\N		\N	\N	\N	243	\N
405		\N		\N	\N	\N	245	\N
405		\N		\N	\N	\N	262	\N
405		\N		\N	\N	\N	263	\N
405		\N		\N	\N	\N	270	\N
405		\N		\N	\N	\N	271	\N
405		\N		\N	\N	\N	286	\N
405		\N		\N	\N	\N	293	\N
405		\N		\N	\N	\N	304	\N
405		\N		\N	\N	\N	314	\N
405		\N		\N	\N	\N	325	\N
405		\N		\N	\N	\N	334	\N
405		\N		\N	\N	\N	351	\N
405		\N		\N	\N	\N	364	\N
405		\N		\N	\N	\N	365	\N
405		\N		\N	\N	\N	372	\N
405		\N		\N	\N	\N	382	\N
405		\N		\N	\N	\N	390	\N
3		\N		\N	\N	\N	134	\N
3		\N		\N	\N	\N	274	\N
3		\N		\N	\N	\N	335	\N
3		\N		\N	\N	\N	340	\N
133		\N		\N	\N	\N	90	\N
133		\N		\N	\N	\N	122	\N
133		\N		\N	\N	\N	123	\N
133		\N		\N	\N	\N	124	\N
133		\N		\N	\N	\N	195	\N
133		\N		\N	\N	\N	197	\N
267		\N		\N	\N	\N	1	\N
267		\N		\N	\N	\N	2	\N
267		\N		\N	\N	\N	4	\N
267		\N		\N	\N	\N	5	\N
267		\N		\N	\N	\N	18	\N
267		\N		\N	\N	\N	31	\N
267		\N		\N	\N	\N	32	\N
267		\N		\N	\N	\N	46	\N
267		\N		\N	\N	\N	50	\N
267		\N		\N	\N	\N	60	\N
267		\N		\N	\N	\N	63	\N
267		\N		\N	\N	\N	65	\N
267		\N		\N	\N	\N	68	\N
267		\N		\N	\N	\N	69	\N
267		\N		\N	\N	\N	83	\N
267		\N		\N	\N	\N	84	\N
267		\N		\N	\N	\N	90	\N
267		\N		\N	\N	\N	96	\N
267		\N		\N	\N	\N	144	\N
267		\N		\N	\N	\N	178	\N
267		\N		\N	\N	\N	179	\N
267		\N		\N	\N	\N	190	\N
267		\N		\N	\N	\N	198	\N
267		\N		\N	\N	\N	268	\N
267		\N		\N	\N	\N	269	\N
267		\N		\N	\N	\N	276	\N
267		\N		\N	\N	\N	282	\N
267		\N		\N	\N	\N	293	\N
267		\N		\N	\N	\N	297	\N
267		\N		\N	\N	\N	300	\N
267		\N		\N	\N	\N	310	\N
267		\N		\N	\N	\N	335	\N
267		\N		\N	\N	\N	349	\N
267		\N		\N	\N	\N	355	\N
267		\N		\N	\N	\N	356	\N
267		\N		\N	\N	\N	369	\N
267		\N		\N	\N	\N	374	\N
267		\N		\N	\N	\N	375	\N
267		\N		\N	\N	\N	376	\N
267		\N		\N	\N	\N	379	\N
267		\N		\N	\N	\N	387	\N
267		\N		\N	\N	\N	395	\N
267		\N		\N	\N	\N	396	\N
267		\N		\N	\N	\N	399	\N
267		\N		\N	\N	\N	400	\N
267		\N		\N	\N	\N	403	\N
267		\N		\N	\N	\N	405	\N
109		\N		\N	\N	\N	299	\N
202		\N		\N	\N	\N	209	\N
391		\N		\N	\N	\N	111	\N
391		\N		\N	\N	\N	367	\N
391		\N		\N	\N	\N	389	\N
271		\N		\N	\N	\N	189	\N
323		\N		\N	\N	\N	174	\N
323		\N		\N	\N	\N	207	\N
323		\N		\N	\N	\N	230	\N
323		\N		\N	\N	\N	241	\N
323		\N		\N	\N	\N	245	\N
323		\N		\N	\N	\N	287	\N
4		\N		\N	\N	\N	35	\N
4		\N		\N	\N	\N	190	\N
33		\N		\N	\N	\N	89	\N
144		\N		\N	\N	\N	266	\N
242		\N		\N	\N	\N	11	\N
242		\N		\N	\N	\N	19	\N
242		\N		\N	\N	\N	50	\N
242		\N		\N	\N	\N	72	\N
242		\N		\N	\N	\N	90	\N
242		\N		\N	\N	\N	95	\N
242		\N		\N	\N	\N	98	\N
242		\N		\N	\N	\N	104	\N
242		\N		\N	\N	\N	105	\N
242		\N		\N	\N	\N	107	\N
242		\N		\N	\N	\N	146	\N
242		\N		\N	\N	\N	148	\N
242		\N		\N	\N	\N	152	\N
242		\N		\N	\N	\N	156	\N
242		\N		\N	\N	\N	167	\N
242		\N		\N	\N	\N	177	\N
242		\N		\N	\N	\N	191	\N
242		\N		\N	\N	\N	242	\N
242		\N		\N	\N	\N	244	\N
242		\N		\N	\N	\N	269	\N
242		\N		\N	\N	\N	271	\N
242		\N		\N	\N	\N	273	\N
242		\N		\N	\N	\N	274	\N
242		\N		\N	\N	\N	280	\N
242		\N		\N	\N	\N	293	\N
242		\N		\N	\N	\N	323	\N
242		\N		\N	\N	\N	329	\N
242		\N		\N	\N	\N	338	\N
242		\N		\N	\N	\N	397	\N
242		\N		\N	\N	\N	401	\N
124		\N		\N	\N	\N	35	\N
122		\N		\N	\N	\N	142	\N
122		\N		\N	\N	\N	182	\N
243		\N		\N	\N	\N	20	\N
243		\N		\N	\N	\N	71	\N
243		\N		\N	\N	\N	152	\N
243		\N		\N	\N	\N	291	\N
243		\N		\N	\N	\N	292	\N
243		\N		\N	\N	\N	327	\N
283		\N		\N	\N	\N	333	\N
95		\N		\N	\N	\N	64	\N
95		\N		\N	\N	\N	150	\N
95		\N		\N	\N	\N	217	\N
95		\N		\N	\N	\N	218	\N
194		\N		\N	\N	\N	3	\N
194		\N		\N	\N	\N	4	\N
194		\N		\N	\N	\N	12	\N
194		\N		\N	\N	\N	13	\N
194		\N		\N	\N	\N	15	\N
194		\N		\N	\N	\N	23	\N
194		\N		\N	\N	\N	27	\N
194		\N		\N	\N	\N	33	\N
194		\N		\N	\N	\N	34	\N
194		\N		\N	\N	\N	40	\N
194		\N		\N	\N	\N	41	\N
194		\N		\N	\N	\N	47	\N
194		\N		\N	\N	\N	55	\N
194		\N		\N	\N	\N	75	\N
194		\N		\N	\N	\N	78	\N
194		\N		\N	\N	\N	79	\N
194		\N		\N	\N	\N	91	\N
194		\N		\N	\N	\N	94	\N
194		\N		\N	\N	\N	103	\N
194		\N		\N	\N	\N	104	\N
194		\N		\N	\N	\N	105	\N
194		\N		\N	\N	\N	109	\N
194		\N		\N	\N	\N	111	\N
194		\N		\N	\N	\N	112	\N
194		\N		\N	\N	\N	118	\N
194		\N		\N	\N	\N	123	\N
194		\N		\N	\N	\N	138	\N
194		\N		\N	\N	\N	154	\N
194		\N		\N	\N	\N	156	\N
194		\N		\N	\N	\N	158	\N
194		\N		\N	\N	\N	161	\N
194		\N		\N	\N	\N	164	\N
194		\N		\N	\N	\N	166	\N
194		\N		\N	\N	\N	171	\N
194		\N		\N	\N	\N	172	\N
194		\N		\N	\N	\N	183	\N
194		\N		\N	\N	\N	197	\N
194		\N		\N	\N	\N	199	\N
194		\N		\N	\N	\N	204	\N
194		\N		\N	\N	\N	205	\N
194		\N		\N	\N	\N	220	\N
194		\N		\N	\N	\N	221	\N
194		\N		\N	\N	\N	223	\N
194		\N		\N	\N	\N	242	\N
194		\N		\N	\N	\N	246	\N
194		\N		\N	\N	\N	259	\N
194		\N		\N	\N	\N	266	\N
194		\N		\N	\N	\N	267	\N
194		\N		\N	\N	\N	269	\N
194		\N		\N	\N	\N	270	\N
194		\N		\N	\N	\N	274	\N
194		\N		\N	\N	\N	275	\N
194		\N		\N	\N	\N	287	\N
194		\N		\N	\N	\N	290	\N
194		\N		\N	\N	\N	298	\N
194		\N		\N	\N	\N	302	\N
194		\N		\N	\N	\N	311	\N
194		\N		\N	\N	\N	313	\N
194		\N		\N	\N	\N	314	\N
194		\N		\N	\N	\N	324	\N
194		\N		\N	\N	\N	325	\N
194		\N		\N	\N	\N	329	\N
194		\N		\N	\N	\N	330	\N
194		\N		\N	\N	\N	331	\N
194		\N		\N	\N	\N	343	\N
194		\N		\N	\N	\N	345	\N
194		\N		\N	\N	\N	347	\N
194		\N		\N	\N	\N	349	\N
194		\N		\N	\N	\N	357	\N
194		\N		\N	\N	\N	363	\N
194		\N		\N	\N	\N	364	\N
194		\N		\N	\N	\N	373	\N
194		\N		\N	\N	\N	384	\N
194		\N		\N	\N	\N	386	\N
194		\N		\N	\N	\N	387	\N
194		\N		\N	\N	\N	389	\N
140		\N		\N	\N	\N	197	\N
140		\N		\N	\N	\N	389	\N
476		\N		\N	\N	\N	23	\N
476		\N		\N	\N	\N	105	\N
476		\N		\N	\N	\N	111	\N
476		\N		\N	\N	\N	389	\N
28		\N		\N	\N	\N	204	\N
28		\N		\N	\N	\N	205	\N
28		\N		\N	\N	\N	267	\N
280		\N		\N	\N	\N	199	\N
42		\N		\N	\N	\N	235	\N
179		\N		\N	\N	\N	153	\N
260		\N		\N	\N	\N	168	\N
260		\N		\N	\N	\N	169	\N
260		\N		\N	\N	\N	271	\N
380		\N		\N	\N	\N	38	\N
380		\N		\N	\N	\N	141	\N
380		\N		\N	\N	\N	142	\N
380		\N		\N	\N	\N	167	\N
380		\N		\N	\N	\N	311	\N
380		\N		\N	\N	\N	324	\N
55		\N		\N	\N	\N	177	\N
55		\N		\N	\N	\N	446	\N
232		\N		\N	\N	\N	238	\N
232		\N		\N	\N	\N	326	\N
232		\N		\N	\N	\N	327	\N
10		\N		\N	\N	\N	35	\N
10		\N		\N	\N	\N	190	\N
68		\N		\N	\N	\N	41	\N
68		\N		\N	\N	\N	118	\N
68		\N		\N	\N	\N	133	\N
68		\N		\N	\N	\N	164	\N
68		\N		\N	\N	\N	205	\N
68		\N		\N	\N	\N	226	\N
68		\N		\N	\N	\N	244	\N
68		\N		\N	\N	\N	308	\N
317		\N		\N	\N	\N	226	\N
292		\N		\N	\N	\N	244	\N
387		\N		\N	\N	\N	311	\N
67		\N		\N	\N	\N	230	\N
454		\N		\N	\N	\N	211	\N
454		\N		\N	\N	\N	215	\N
454		\N		\N	\N	\N	292	\N
454		\N		\N	\N	\N	298	\N
451		\N		\N	\N	\N	211	\N
451		\N		\N	\N	\N	214	\N
451		\N		\N	\N	\N	320	\N
448		\N		\N	\N	\N	217	\N
431		\N		\N	\N	\N	251	\N
431		\N		\N	\N	\N	255	\N
431		\N		\N	\N	\N	274	\N
430		\N		\N	\N	\N	274	\N
302		\N		\N	\N	\N	136	\N
302		\N		\N	\N	\N	218	\N
302		\N		\N	\N	\N	222	\N
302		\N		\N	\N	\N	1012	\N
11		\N		\N	\N	\N	3	\N
11		\N		\N	\N	\N	66	\N
11		\N		\N	\N	\N	67	\N
11		\N		\N	\N	\N	181	\N
11		\N		\N	\N	\N	290	\N
11		\N		\N	\N	\N	291	\N
239		\N		\N	\N	\N	222	\N
239		\N		\N	\N	\N	405	\N
441		\N		\N	\N	\N	36	\N
441		\N		\N	\N	\N	52	\N
441		\N		\N	\N	\N	119	\N
441		\N		\N	\N	\N	120	\N
441		\N		\N	\N	\N	122	\N
441		\N		\N	\N	\N	190	\N
441		\N		\N	\N	\N	191	\N
441		\N		\N	\N	\N	193	\N
441		\N		\N	\N	\N	194	\N
441		\N		\N	\N	\N	198	\N
441		\N		\N	\N	\N	199	\N
441		\N		\N	\N	\N	285	\N
441		\N		\N	\N	\N	289	\N
441		\N		\N	\N	\N	383	\N
441		\N		\N	\N	\N	384	\N
441		\N		\N	\N	\N	404	\N
8		\N		\N	\N	\N	122	\N
8		\N		\N	\N	\N	383	\N
6		\N		\N	\N	\N	36	\N
6		\N		\N	\N	\N	285	\N
6		\N		\N	\N	\N	289	\N
6		\N		\N	\N	\N	404	\N
297		\N		\N	\N	\N	136	\N
301		\N		\N	\N	\N	136	\N
321		\N		\N	\N	\N	7	\N
321		\N		\N	\N	\N	11	\N
321		\N		\N	\N	\N	18	\N
321		\N		\N	\N	\N	59	\N
321		\N		\N	\N	\N	61	\N
321		\N		\N	\N	\N	95	\N
321		\N		\N	\N	\N	104	\N
321		\N		\N	\N	\N	105	\N
321		\N		\N	\N	\N	107	\N
321		\N		\N	\N	\N	128	\N
321		\N		\N	\N	\N	130	\N
321		\N		\N	\N	\N	155	\N
321		\N		\N	\N	\N	174	\N
321		\N		\N	\N	\N	218	\N
321		\N		\N	\N	\N	247	\N
321		\N		\N	\N	\N	248	\N
321		\N		\N	\N	\N	263	\N
321		\N		\N	\N	\N	269	\N
321		\N		\N	\N	\N	273	\N
321		\N		\N	\N	\N	274	\N
321		\N		\N	\N	\N	282	\N
321		\N		\N	\N	\N	293	\N
321		\N		\N	\N	\N	305	\N
321		\N		\N	\N	\N	323	\N
321		\N		\N	\N	\N	379	\N
321		\N		\N	\N	\N	405	\N
321		\N		\N	\N	\N	1014	\N
18		\N		\N	\N	\N	149	\N
18		\N		\N	\N	\N	189	\N
18		\N		\N	\N	\N	201	\N
18		\N		\N	\N	\N	204	\N
18		\N		\N	\N	\N	205	\N
18		\N		\N	\N	\N	210	\N
18		\N		\N	\N	\N	211	\N
18		\N		\N	\N	\N	213	\N
18		\N		\N	\N	\N	214	\N
18		\N		\N	\N	\N	216	\N
18		\N		\N	\N	\N	217	\N
18		\N		\N	\N	\N	218	\N
18		\N		\N	\N	\N	229	\N
18		\N		\N	\N	\N	230	\N
18		\N		\N	\N	\N	267	\N
472		\N		\N	\N	\N	142	\N
472		\N		\N	\N	\N	1016	\N
277		\N		\N	\N	\N	408	\N
178		\N		\N	\N	\N	409	\N
392		\N		\N	\N	\N	95	\N
392		\N		\N	\N	\N	105	\N
392		\N		\N	\N	\N	269	\N
392		\N		\N	\N	\N	323	\N
264		\N		\N	\N	\N	199	\N
394		\N		\N	\N	\N	11	\N
394		\N		\N	\N	\N	273	\N
394		\N		\N	\N	\N	274	\N
393		\N		\N	\N	\N	282	\N
393		\N		\N	\N	\N	379	\N
401		\N		\N	\N	\N	59	\N
128		\N		\N	\N	\N	35	\N
128		\N		\N	\N	\N	311	\N
199		\N		\N	\N	\N	44	\N
408		\N		\N	\N	\N	128	\N
230		\N		\N	\N	\N	4	\N
230		\N		\N	\N	\N	20	\N
230		\N		\N	\N	\N	23	\N
230		\N		\N	\N	\N	24	\N
230		\N		\N	\N	\N	26	\N
230		\N		\N	\N	\N	27	\N
230		\N		\N	\N	\N	36	\N
230		\N		\N	\N	\N	37	\N
230		\N		\N	\N	\N	38	\N
230		\N		\N	\N	\N	77	\N
230		\N		\N	\N	\N	110	\N
230		\N		\N	\N	\N	113	\N
230		\N		\N	\N	\N	114	\N
230		\N		\N	\N	\N	115	\N
230		\N		\N	\N	\N	127	\N
230		\N		\N	\N	\N	132	\N
230		\N		\N	\N	\N	140	\N
230		\N		\N	\N	\N	163	\N
230		\N		\N	\N	\N	169	\N
230		\N		\N	\N	\N	174	\N
230		\N		\N	\N	\N	191	\N
230		\N		\N	\N	\N	214	\N
230		\N		\N	\N	\N	235	\N
230		\N		\N	\N	\N	237	\N
230		\N		\N	\N	\N	238	\N
230		\N		\N	\N	\N	240	\N
230		\N		\N	\N	\N	251	\N
230		\N		\N	\N	\N	254	\N
230		\N		\N	\N	\N	259	\N
230		\N		\N	\N	\N	265	\N
230		\N		\N	\N	\N	271	\N
230		\N		\N	\N	\N	280	\N
230		\N		\N	\N	\N	290	\N
230		\N		\N	\N	\N	291	\N
230		\N		\N	\N	\N	311	\N
230		\N		\N	\N	\N	333	\N
230		\N		\N	\N	\N	334	\N
230		\N		\N	\N	\N	335	\N
230		\N		\N	\N	\N	348	\N
230		\N		\N	\N	\N	368	\N
230		\N		\N	\N	\N	373	\N
230		\N		\N	\N	\N	398	\N
230		\N		\N	\N	\N	402	\N
230		\N		\N	\N	\N	1027	\N
52		\N		\N	\N	\N	379	\N
147		\N		\N	\N	\N	70	\N
147		\N		\N	\N	\N	108	\N
147		\N		\N	\N	\N	110	\N
147		\N		\N	\N	\N	119	\N
147		\N		\N	\N	\N	132	\N
147		\N		\N	\N	\N	190	\N
147		\N		\N	\N	\N	285	\N
147		\N		\N	\N	\N	305	\N
147		\N		\N	\N	\N	308	\N
147		\N		\N	\N	\N	366	\N
147		\N		\N	\N	\N	371	\N
147		\N		\N	\N	\N	373	\N
147		\N		\N	\N	\N	390	\N
147		\N		\N	\N	\N	391	\N
147		\N		\N	\N	\N	392	\N
147		\N		\N	\N	\N	394	\N
147		\N		\N	\N	\N	405	\N
72		\N		\N	\N	\N	70	\N
72		\N		\N	\N	\N	119	\N
72		\N		\N	\N	\N	394	\N
104		\N		\N	\N	\N	169	\N
104		\N		\N	\N	\N	214	\N
104		\N		\N	\N	\N	237	\N
300		\N		\N	\N	\N	335	\N
38		\N		\N	\N	\N	23	\N
38		\N		\N	\N	\N	111	\N
38		\N		\N	\N	\N	157	\N
38		\N		\N	\N	\N	158	\N
38		\N		\N	\N	\N	160	\N
38		\N		\N	\N	\N	230	\N
30		\N		\N	\N	\N	157	\N
342		\N		\N	\N	\N	1005	\N
434		\N		\N	\N	\N	302	\N
434		\N		\N	\N	\N	324	\N
434		\N		\N	\N	\N	325	\N
434		\N		\N	\N	\N	375	\N
384		\N		\N	\N	\N	254	\N
236		\N		\N	\N	\N	11	\N
236		\N		\N	\N	\N	23	\N
236		\N		\N	\N	\N	33	\N
236		\N		\N	\N	\N	36	\N
236		\N		\N	\N	\N	52	\N
236		\N		\N	\N	\N	55	\N
236		\N		\N	\N	\N	57	\N
236		\N		\N	\N	\N	58	\N
236		\N		\N	\N	\N	115	\N
236		\N		\N	\N	\N	149	\N
236		\N		\N	\N	\N	150	\N
236		\N		\N	\N	\N	167	\N
236		\N		\N	\N	\N	170	\N
236		\N		\N	\N	\N	180	\N
236		\N		\N	\N	\N	181	\N
236		\N		\N	\N	\N	182	\N
236		\N		\N	\N	\N	184	\N
236		\N		\N	\N	\N	187	\N
236		\N		\N	\N	\N	210	\N
236		\N		\N	\N	\N	251	\N
236		\N		\N	\N	\N	271	\N
236		\N		\N	\N	\N	285	\N
236		\N		\N	\N	\N	289	\N
236		\N		\N	\N	\N	292	\N
236		\N		\N	\N	\N	333	\N
236		\N		\N	\N	\N	356	\N
236		\N		\N	\N	\N	368	\N
236		\N		\N	\N	\N	398	\N
236		\N		\N	\N	\N	404	\N
236		\N		\N	\N	\N	445	\N
51		\N		\N	\N	\N	52	\N
51		\N		\N	\N	\N	117	\N
51		\N		\N	\N	\N	119	\N
373		\N		\N	\N	\N	363	\N
373		\N		\N	\N	\N	367	\N
370		\N		\N	\N	\N	50	\N
376		\N		\N	\N	\N	156	\N
47		\N		\N	\N	\N	103	\N
47		\N		\N	\N	\N	125	\N
47		\N		\N	\N	\N	222	\N
47		\N		\N	\N	\N	233	\N
47		\N		\N	\N	\N	237	\N
47		\N		\N	\N	\N	238	\N
47		\N		\N	\N	\N	356	\N
47		\N		\N	\N	\N	364	\N
47		\N		\N	\N	\N	398	\N
132		\N		\N	\N	\N	356	\N
462		\N		\N	\N	\N	227	\N
462		\N		\N	\N	\N	322	\N
462		\N		\N	\N	\N	1022	\N
285		\N		\N	\N	\N	187	\N
207		\N		\N	\N	\N	335	\N
465		\N		\N	\N	\N	322	\N
459		\N		\N	\N	\N	322	\N
134		\N		\N	\N	\N	191	\N
134		\N		\N	\N	\N	249	\N
134		\N		\N	\N	\N	387	\N
111		\N		\N	\N	\N	392	\N
111		\N		\N	\N	\N	430	\N
111		\N		\N	\N	\N	431	\N
111		\N		\N	\N	\N	432	\N
111		\N		\N	\N	\N	433	\N
15		\N		\N	\N	\N	211	\N
15		\N		\N	\N	\N	216	\N
59		\N		\N	\N	\N	263	\N
173		\N		\N	\N	\N	148	\N
275		\N		\N	\N	\N	11	\N
275		\N		\N	\N	\N	14	\N
275		\N		\N	\N	\N	16	\N
275		\N		\N	\N	\N	25	\N
275		\N		\N	\N	\N	26	\N
275		\N		\N	\N	\N	39	\N
275		\N		\N	\N	\N	53	\N
275		\N		\N	\N	\N	60	\N
275		\N		\N	\N	\N	121	\N
275		\N		\N	\N	\N	174	\N
275		\N		\N	\N	\N	175	\N
275		\N		\N	\N	\N	195	\N
275		\N		\N	\N	\N	211	\N
275		\N		\N	\N	\N	217	\N
275		\N		\N	\N	\N	222	\N
275		\N		\N	\N	\N	256	\N
275		\N		\N	\N	\N	258	\N
275		\N		\N	\N	\N	274	\N
275		\N		\N	\N	\N	281	\N
275		\N		\N	\N	\N	323	\N
275		\N		\N	\N	\N	357	\N
275		\N		\N	\N	\N	386	\N
275		\N		\N	\N	\N	392	\N
275		\N		\N	\N	\N	394	\N
9		\N		\N	\N	\N	347	\N
127		\N		\N	\N	\N	242	\N
127		\N		\N	\N	\N	245	\N
127		\N		\N	\N	\N	246	\N
127		\N		\N	\N	\N	356	\N
294		\N		\N	\N	\N	136	\N
294		\N		\N	\N	\N	138	\N
294		\N		\N	\N	\N	139	\N
294		\N		\N	\N	\N	140	\N
294		\N		\N	\N	\N	158	\N
294		\N		\N	\N	\N	231	\N
294		\N		\N	\N	\N	236	\N
294		\N		\N	\N	\N	238	\N
294		\N		\N	\N	\N	344	\N
294		\N		\N	\N	\N	347	\N
294		\N		\N	\N	\N	397	\N
377		\N		\N	\N	\N	50	\N
377		\N		\N	\N	\N	62	\N
377		\N		\N	\N	\N	131	\N
377		\N		\N	\N	\N	305	\N
368		\N		\N	\N	\N	50	\N
372		\N		\N	\N	\N	305	\N
54		\N		\N	\N	\N	115	\N
54		\N		\N	\N	\N	116	\N
54		\N		\N	\N	\N	356	\N
54		\N		\N	\N	\N	357	\N
54		\N		\N	\N	\N	358	\N
54		\N		\N	\N	\N	360	\N
54		\N		\N	\N	\N	362	\N
76		\N		\N	\N	\N	11	\N
76		\N		\N	\N	\N	18	\N
76		\N		\N	\N	\N	150	\N
425		\N		\N	\N	\N	251	\N
425		\N		\N	\N	\N	252	\N
425		\N		\N	\N	\N	254	\N
425		\N		\N	\N	\N	323	\N
425		\N		\N	\N	\N	331	\N
425		\N		\N	\N	\N	332	\N
62		\N		\N	\N	\N	90	\N
62		\N		\N	\N	\N	98	\N
19		\N		\N	\N	\N	82	\N
19		\N		\N	\N	\N	404	\N
337		\N		\N	\N	\N	336	\N
335		\N		\N	\N	\N	8	\N
335		\N		\N	\N	\N	116	\N
335		\N		\N	\N	\N	117	\N
335		\N		\N	\N	\N	118	\N
335		\N		\N	\N	\N	146	\N
335		\N		\N	\N	\N	148	\N
335		\N		\N	\N	\N	149	\N
335		\N		\N	\N	\N	150	\N
335		\N		\N	\N	\N	152	\N
335		\N		\N	\N	\N	201	\N
335		\N		\N	\N	\N	202	\N
335		\N		\N	\N	\N	230	\N
335		\N		\N	\N	\N	287	\N
335		\N		\N	\N	\N	328	\N
335		\N		\N	\N	\N	375	\N
335		\N		\N	\N	\N	376	\N
237		\N		\N	\N	\N	206	\N
237		\N		\N	\N	\N	216	\N
237		\N		\N	\N	\N	217	\N
237		\N		\N	\N	\N	308	\N
332		\N		\N	\N	\N	146	\N
209		\N		\N	\N	\N	211	\N
209		\N		\N	\N	\N	213	\N
209		\N		\N	\N	\N	348	\N
190		\N		\N	\N	\N	392	\N
142		\N		\N	\N	\N	263	\N
195		\N		\N	\N	\N	5	\N
195		\N		\N	\N	\N	14	\N
195		\N		\N	\N	\N	18	\N
195		\N		\N	\N	\N	28	\N
195		\N		\N	\N	\N	33	\N
195		\N		\N	\N	\N	51	\N
195		\N		\N	\N	\N	64	\N
195		\N		\N	\N	\N	67	\N
195		\N		\N	\N	\N	88	\N
195		\N		\N	\N	\N	92	\N
195		\N		\N	\N	\N	101	\N
195		\N		\N	\N	\N	193	\N
195		\N		\N	\N	\N	196	\N
195		\N		\N	\N	\N	198	\N
195		\N		\N	\N	\N	199	\N
195		\N		\N	\N	\N	206	\N
195		\N		\N	\N	\N	216	\N
195		\N		\N	\N	\N	217	\N
195		\N		\N	\N	\N	229	\N
195		\N		\N	\N	\N	234	\N
195		\N		\N	\N	\N	278	\N
195		\N		\N	\N	\N	301	\N
195		\N		\N	\N	\N	307	\N
195		\N		\N	\N	\N	308	\N
195		\N		\N	\N	\N	311	\N
195		\N		\N	\N	\N	370	\N
195		\N		\N	\N	\N	404	\N
197		\N		\N	\N	\N	89	\N
197		\N		\N	\N	\N	144	\N
197		\N		\N	\N	\N	366	\N
197		\N		\N	\N	\N	369	\N
397		\N		\N	\N	\N	282	\N
397		\N		\N	\N	\N	348	\N
397		\N		\N	\N	\N	367	\N
291		\N		\N	\N	\N	449	\N
65		\N		\N	\N	\N	72	\N
160		\N		\N	\N	\N	324	\N
244		\N		\N	\N	\N	215	\N
185		\N		\N	\N	\N	15	\N
185		\N		\N	\N	\N	16	\N
185		\N		\N	\N	\N	227	\N
185		\N		\N	\N	\N	228	\N
298		\N		\N	\N	\N	369	\N
298		\N		\N	\N	\N	393	\N
298		\N		\N	\N	\N	1013	\N
427		\N		\N	\N	\N	326	\N
427		\N		\N	\N	\N	333	\N
474		\N		\N	\N	\N	49	\N
474		\N		\N	\N	\N	367	\N
474		\N		\N	\N	\N	368	\N
474		\N		\N	\N	\N	384	\N
440		\N		\N	\N	\N	356	\N
440		\N		\N	\N	\N	358	\N
440		\N		\N	\N	\N	360	\N
410		\N		\N	\N	\N	291	\N
410		\N		\N	\N	\N	450	\N
407		\N		\N	\N	\N	104	\N
407		\N		\N	\N	\N	132	\N
407		\N		\N	\N	\N	133	\N
407		\N		\N	\N	\N	210	\N
407		\N		\N	\N	\N	363	\N
438		\N		\N	\N	\N	102	\N
438		\N		\N	\N	\N	189	\N
438		\N		\N	\N	\N	221	\N
438		\N		\N	\N	\N	298	\N
438		\N		\N	\N	\N	404	\N
307		\N		\N	\N	\N	71	\N
307		\N		\N	\N	\N	313	\N
307		\N		\N	\N	\N	315	\N
303		\N		\N	\N	\N	136	\N
303		\N		\N	\N	\N	138	\N
303		\N		\N	\N	\N	139	\N
73		\N		\N	\N	\N	57	\N
44		\N		\N	\N	\N	114	\N
44		\N		\N	\N	\N	125	\N
44		\N		\N	\N	\N	147	\N
44		\N		\N	\N	\N	148	\N
44		\N		\N	\N	\N	151	\N
44		\N		\N	\N	\N	210	\N
44		\N		\N	\N	\N	222	\N
44		\N		\N	\N	\N	223	\N
44		\N		\N	\N	\N	233	\N
44		\N		\N	\N	\N	235	\N
44		\N		\N	\N	\N	237	\N
44		\N		\N	\N	\N	238	\N
44		\N		\N	\N	\N	374	\N
44		\N		\N	\N	\N	382	\N
44		\N		\N	\N	\N	398	\N
48		\N		\N	\N	\N	125	\N
48		\N		\N	\N	\N	222	\N
48		\N		\N	\N	\N	233	\N
48		\N		\N	\N	\N	237	\N
48		\N		\N	\N	\N	238	\N
48		\N		\N	\N	\N	398	\N
82		\N		\N	\N	\N	349	\N
82		\N		\N	\N	\N	392	\N
82		\N		\N	\N	\N	405	\N
463		\N		\N	\N	\N	322	\N
177		\N		\N	\N	\N	13	\N
177		\N		\N	\N	\N	14	\N
177		\N		\N	\N	\N	16	\N
177		\N		\N	\N	\N	98	\N
177		\N		\N	\N	\N	146	\N
177		\N		\N	\N	\N	208	\N
246		\N		\N	\N	\N	151	\N
246		\N		\N	\N	\N	184	\N
246		\N		\N	\N	\N	215	\N
246		\N		\N	\N	\N	321	\N
63		\N		\N	\N	\N	25	\N
63		\N		\N	\N	\N	53	\N
63		\N		\N	\N	\N	74	\N
63		\N		\N	\N	\N	77	\N
299		\N		\N	\N	\N	20	\N
299		\N		\N	\N	\N	21	\N
299		\N		\N	\N	\N	33	\N
299		\N		\N	\N	\N	34	\N
299		\N		\N	\N	\N	43	\N
299		\N		\N	\N	\N	50	\N
299		\N		\N	\N	\N	55	\N
299		\N		\N	\N	\N	56	\N
299		\N		\N	\N	\N	62	\N
299		\N		\N	\N	\N	95	\N
299		\N		\N	\N	\N	122	\N
299		\N		\N	\N	\N	126	\N
299		\N		\N	\N	\N	136	\N
299		\N		\N	\N	\N	148	\N
299		\N		\N	\N	\N	150	\N
299		\N		\N	\N	\N	159	\N
299		\N		\N	\N	\N	179	\N
299		\N		\N	\N	\N	186	\N
299		\N		\N	\N	\N	189	\N
299		\N		\N	\N	\N	200	\N
299		\N		\N	\N	\N	220	\N
299		\N		\N	\N	\N	221	\N
299		\N		\N	\N	\N	258	\N
299		\N		\N	\N	\N	265	\N
299		\N		\N	\N	\N	272	\N
299		\N		\N	\N	\N	289	\N
299		\N		\N	\N	\N	309	\N
299		\N		\N	\N	\N	311	\N
299		\N		\N	\N	\N	312	\N
299		\N		\N	\N	\N	322	\N
299		\N		\N	\N	\N	345	\N
299		\N		\N	\N	\N	359	\N
299		\N		\N	\N	\N	373	\N
299		\N		\N	\N	\N	375	\N
299		\N		\N	\N	\N	378	\N
299		\N		\N	\N	\N	384	\N
299		\N		\N	\N	\N	385	\N
299		\N		\N	\N	\N	389	\N
299		\N		\N	\N	\N	397	\N
299		\N		\N	\N	\N	401	\N
296		\N		\N	\N	\N	136	\N
403		\N		\N	\N	\N	3	\N
403		\N		\N	\N	\N	8	\N
403		\N		\N	\N	\N	21	\N
403		\N		\N	\N	\N	49	\N
403		\N		\N	\N	\N	55	\N
403		\N		\N	\N	\N	56	\N
403		\N		\N	\N	\N	63	\N
403		\N		\N	\N	\N	87	\N
403		\N		\N	\N	\N	91	\N
403		\N		\N	\N	\N	92	\N
403		\N		\N	\N	\N	126	\N
403		\N		\N	\N	\N	138	\N
403		\N		\N	\N	\N	139	\N
403		\N		\N	\N	\N	141	\N
403		\N		\N	\N	\N	152	\N
403		\N		\N	\N	\N	164	\N
403		\N		\N	\N	\N	181	\N
403		\N		\N	\N	\N	188	\N
403		\N		\N	\N	\N	196	\N
403		\N		\N	\N	\N	209	\N
403		\N		\N	\N	\N	229	\N
403		\N		\N	\N	\N	230	\N
403		\N		\N	\N	\N	233	\N
403		\N		\N	\N	\N	239	\N
403		\N		\N	\N	\N	240	\N
403		\N		\N	\N	\N	244	\N
403		\N		\N	\N	\N	261	\N
403		\N		\N	\N	\N	263	\N
403		\N		\N	\N	\N	291	\N
403		\N		\N	\N	\N	301	\N
403		\N		\N	\N	\N	308	\N
403		\N		\N	\N	\N	312	\N
403		\N		\N	\N	\N	313	\N
403		\N		\N	\N	\N	319	\N
403		\N		\N	\N	\N	325	\N
403		\N		\N	\N	\N	338	\N
403		\N		\N	\N	\N	345	\N
403		\N		\N	\N	\N	346	\N
403		\N		\N	\N	\N	385	\N
403		\N		\N	\N	\N	392	\N
403		\N		\N	\N	\N	396	\N
97		\N		\N	\N	\N	337	\N
345		\N		\N	\N	\N	44	\N
345		\N		\N	\N	\N	45	\N
345		\N		\N	\N	\N	134	\N
345		\N		\N	\N	\N	242	\N
345		\N		\N	\N	\N	244	\N
345		\N		\N	\N	\N	245	\N
345		\N		\N	\N	\N	282	\N
345		\N		\N	\N	\N	284	\N
345		\N		\N	\N	\N	338	\N
345		\N		\N	\N	\N	339	\N
345		\N		\N	\N	\N	340	\N
345		\N		\N	\N	\N	341	\N
345		\N		\N	\N	\N	367	\N
345		\N		\N	\N	\N	368	\N
121		\N		\N	\N	\N	191	\N
7		\N		\N	\N	\N	368	\N
145		\N		\N	\N	\N	267	\N
145		\N		\N	\N	\N	268	\N
106		\N		\N	\N	\N	49	\N
106		\N		\N	\N	\N	238	\N
106		\N		\N	\N	\N	291	\N
245		\N		\N	\N	\N	41	\N
245		\N		\N	\N	\N	72	\N
245		\N		\N	\N	\N	96	\N
245		\N		\N	\N	\N	97	\N
245		\N		\N	\N	\N	98	\N
245		\N		\N	\N	\N	118	\N
245		\N		\N	\N	\N	128	\N
245		\N		\N	\N	\N	133	\N
245		\N		\N	\N	\N	151	\N
245		\N		\N	\N	\N	164	\N
245		\N		\N	\N	\N	184	\N
245		\N		\N	\N	\N	193	\N
245		\N		\N	\N	\N	205	\N
245		\N		\N	\N	\N	215	\N
245		\N		\N	\N	\N	232	\N
245		\N		\N	\N	\N	252	\N
245		\N		\N	\N	\N	256	\N
245		\N		\N	\N	\N	300	\N
245		\N		\N	\N	\N	301	\N
245		\N		\N	\N	\N	321	\N
245		\N		\N	\N	\N	374	\N
245		\N		\N	\N	\N	419	\N
282		\N		\N	\N	\N	152	\N
282		\N		\N	\N	\N	390	\N
210		\N		\N	\N	\N	416	\N
240		\N		\N	\N	\N	177	\N
240		\N		\N	\N	\N	179	\N
240		\N		\N	\N	\N	415	\N
172		\N		\N	\N	\N	152	\N
172		\N		\N	\N	\N	206	\N
172		\N		\N	\N	\N	228	\N
172		\N		\N	\N	\N	230	\N
172		\N		\N	\N	\N	349	\N
253		\N		\N	\N	\N	137	\N
253		\N		\N	\N	\N	158	\N
253		\N		\N	\N	\N	217	\N
253		\N		\N	\N	\N	392	\N
261		\N		\N	\N	\N	66	\N
261		\N		\N	\N	\N	67	\N
261		\N		\N	\N	\N	158	\N
261		\N		\N	\N	\N	167	\N
258		\N		\N	\N	\N	249	\N
258		\N		\N	\N	\N	287	\N
258		\N		\N	\N	\N	290	\N
258		\N		\N	\N	\N	421	\N
1		\N		\N	\N	\N	6	\N
1		\N		\N	\N	\N	10	\N
1		\N		\N	\N	\N	18	\N
1		\N		\N	\N	\N	48	\N
1		\N		\N	\N	\N	63	\N
1		\N		\N	\N	\N	107	\N
1		\N		\N	\N	\N	108	\N
1		\N		\N	\N	\N	109	\N
1		\N		\N	\N	\N	110	\N
1		\N		\N	\N	\N	113	\N
1		\N		\N	\N	\N	125	\N
1		\N		\N	\N	\N	128	\N
1		\N		\N	\N	\N	130	\N
1		\N		\N	\N	\N	132	\N
1		\N		\N	\N	\N	133	\N
1		\N		\N	\N	\N	134	\N
1		\N		\N	\N	\N	156	\N
1		\N		\N	\N	\N	157	\N
1		\N		\N	\N	\N	158	\N
1		\N		\N	\N	\N	167	\N
1		\N		\N	\N	\N	168	\N
1		\N		\N	\N	\N	171	\N
1		\N		\N	\N	\N	211	\N
1		\N		\N	\N	\N	213	\N
1		\N		\N	\N	\N	227	\N
1		\N		\N	\N	\N	246	\N
1		\N		\N	\N	\N	249	\N
1		\N		\N	\N	\N	250	\N
1		\N		\N	\N	\N	266	\N
1		\N		\N	\N	\N	267	\N
1		\N		\N	\N	\N	268	\N
1		\N		\N	\N	\N	290	\N
1		\N		\N	\N	\N	306	\N
1		\N		\N	\N	\N	308	\N
1		\N		\N	\N	\N	317	\N
1		\N		\N	\N	\N	333	\N
1		\N		\N	\N	\N	335	\N
1		\N		\N	\N	\N	342	\N
1		\N		\N	\N	\N	345	\N
1		\N		\N	\N	\N	346	\N
1		\N		\N	\N	\N	347	\N
1		\N		\N	\N	\N	348	\N
1		\N		\N	\N	\N	366	\N
1		\N		\N	\N	\N	370	\N
1		\N		\N	\N	\N	373	\N
1		\N		\N	\N	\N	393	\N
1		\N		\N	\N	\N	405	\N
1		\N		\N	\N	\N	414	\N
25		\N		\N	\N	\N	61	\N
25		\N		\N	\N	\N	62	\N
25		\N		\N	\N	\N	87	\N
25		\N		\N	\N	\N	152	\N
25		\N		\N	\N	\N	186	\N
25		\N		\N	\N	\N	268	\N
25		\N		\N	\N	\N	355	\N
259		\N		\N	\N	\N	222	\N
259		\N		\N	\N	\N	274	\N
417		\N		\N	\N	\N	115	\N
417		\N		\N	\N	\N	279	\N
53		\N		\N	\N	\N	115	\N
278		\N		\N	\N	\N	16	\N
278		\N		\N	\N	\N	124	\N
278		\N		\N	\N	\N	302	\N
278		\N		\N	\N	\N	347	\N
112		\N		\N	\N	\N	18	\N
112		\N		\N	\N	\N	83	\N
112		\N		\N	\N	\N	176	\N
112		\N		\N	\N	\N	199	\N
112		\N		\N	\N	\N	305	\N
112		\N		\N	\N	\N	311	\N
112		\N		\N	\N	\N	363	\N
112		\N		\N	\N	\N	367	\N
112		\N		\N	\N	\N	405	\N
118		\N		\N	\N	\N	180	\N
118		\N		\N	\N	\N	401	\N
406		\N		\N	\N	\N	136	\N
406		\N		\N	\N	\N	218	\N
27		\N		\N	\N	\N	1312	\N
19		\N		\N	\N	\N	1036	\N
337		\N		\N	\N	\N	1235	\N
256		\N		\N	\N	\N	1072	\N
256		\N		\N	\N	\N	1170	\N
238		\N		\N	\N	\N	1327	\N
439		\N		\N	\N	\N	1199	\N
335		\N		\N	\N	\N	1074	\N
237		\N		\N	\N	\N	1113	\N
237		\N		\N	\N	\N	1274	\N
332		\N		\N	\N	\N	1228	\N
453		\N		\N	\N	\N	1095	\N
445		\N		\N	\N	\N	1306	\N
272		\N		\N	\N	\N	1088	\N
272		\N		\N	\N	\N	1164	\N
470		\N		\N	\N	\N	1054	\N
470		\N		\N	\N	\N	1090	\N
142		\N		\N	\N	\N	1225	\N
195		\N		\N	\N	\N	1265	\N
195		\N		\N	\N	\N	1305	\N
195		\N		\N	\N	\N	1318	\N
195		\N		\N	\N	\N	1327	\N
268		\N		\N	\N	\N	1191	\N
268		\N		\N	\N	\N	1297	\N
78		\N		\N	\N	\N	1067	\N
78		\N		\N	\N	\N	1064	\N
78		\N		\N	\N	\N	1303	\N
71		\N		\N	\N	\N	1057	\N
71		\N		\N	\N	\N	1061	\N
411		\N		\N	\N	\N	1096	\N
170		\N		\N	\N	\N	1133	\N
21		\N		\N	\N	\N	1035	\N
21		\N		\N	\N	\N	1194	\N
77		\N		\N	\N	\N	1218	\N
197		\N		\N	\N	\N	1149	\N
397		\N		\N	\N	\N	1044	\N
397		\N		\N	\N	\N	1232	\N
177		\N		\N	\N	\N	1140	\N
405		\N		\N	\N	\N	1184	\N
405		\N		\N	\N	\N	1188	\N
405		\N		\N	\N	\N	1258	\N
23		\N		\N	\N	\N	1037	\N
23		\N		\N	\N	\N	1222	\N
267		\N		\N	\N	\N	1158	\N
420		\N		\N	\N	\N	1293	\N
420		\N		\N	\N	\N	1281	\N
174		\N		\N	\N	\N	1135	\N
174		\N		\N	\N	\N	1126	\N
174		\N		\N	\N	\N	1137	\N
245		\N		\N	\N	\N	1177	\N
226		\N		\N	\N	\N	1169	\N
226		\N		\N	\N	\N	1190	\N
254		\N		\N	\N	\N	1183	\N
4		\N		\N	\N	\N	1029	\N
266		\N		\N	\N	\N	1190	\N
266		\N		\N	\N	\N	1109	\N
86		\N		\N	\N	\N	1070	\N
86		\N		\N	\N	\N	1202	\N
61		\N		\N	\N	\N	1058	\N
61		\N		\N	\N	\N	1129	\N
61		\N		\N	\N	\N	1143	\N
313		\N		\N	\N	\N	1215	\N
33		\N		\N	\N	\N	1080	\N
291		\N		\N	\N	\N	1070	\N
291		\N		\N	\N	\N	1126	\N
97		\N		\N	\N	\N	1191	\N
46		\N		\N	\N	\N	1051	\N
46		\N		\N	\N	\N	1268	\N
242		\N		\N	\N	\N	1172	\N
124		\N		\N	\N	\N	1099	\N
122		\N		\N	\N	\N	1095	\N
283		\N		\N	\N	\N	1297	\N
262		\N		\N	\N	\N	1187	\N
262		\N		\N	\N	\N	1076	\N
95		\N		\N	\N	\N	1293	\N
282		\N		\N	\N	\N	1073	\N
282		\N		\N	\N	\N	1328	\N
476		\N		\N	\N	\N	1052	\N
476		\N		\N	\N	\N	1102	\N
476		\N		\N	\N	\N	1125	\N
380		\N		\N	\N	\N	1142	\N
156		\N		\N	\N	\N	1119	\N
156		\N		\N	\N	\N	1147	\N
55		\N		\N	\N	\N	1069	\N
55		\N		\N	\N	\N	1082	\N
232		\N		\N	\N	\N	1177	\N
10		\N		\N	\N	\N	1201	\N
68		\N		\N	\N	\N	1043	\N
160		\N		\N	\N	\N	1322	\N
1		\N		\N	\N	\N	1289	\N
454		\N		\N	\N	\N	1312	\N
454		\N		\N	\N	\N	1329	\N
451		\N		\N	\N	\N	1313	\N
185		\N		\N	\N	\N	1225	\N
240		\N		\N	\N	\N	1181	\N
240		\N		\N	\N	\N	1176	\N
431		\N		\N	\N	\N	1262	\N
430		\N		\N	\N	\N	1262	\N
430		\N		\N	\N	\N	1278	\N
302		\N		\N	\N	\N	1044	\N
302		\N		\N	\N	\N	1163	\N
302		\N		\N	\N	\N	1131	\N
11		\N		\N	\N	\N	1267	\N
239		\N		\N	\N	\N	1254	\N
6		\N		\N	\N	\N	1036	\N
63		\N		\N	\N	\N	1145	\N
108		\N		\N	\N	\N	1089	\N
108		\N		\N	\N	\N	1076	\N
108		\N		\N	\N	\N	1307	\N
18		\N		\N	\N	\N	1034	\N
18		\N		\N	\N	\N	1269	\N
18		\N		\N	\N	\N	1296	\N
264		\N		\N	\N	\N	1277	\N
394		\N		\N	\N	\N	1225	\N
393		\N		\N	\N	\N	1087	\N
199		\N		\N	\N	\N	1286	\N
298		\N		\N	\N	\N	1310	\N
299		\N		\N	\N	\N	1066	\N
296		\N		\N	\N	\N	1307	\N
101		\N		\N	\N	\N	1084	\N
101		\N		\N	\N	\N	1058	\N
52		\N		\N	\N	\N	1157	\N
416		\N		\N	\N	\N	1290	\N
104		\N		\N	\N	\N	1124	\N
450		\N		\N	\N	\N	1311	\N
450		\N		\N	\N	\N	1257	\N
38		\N		\N	\N	\N	1041	\N
38		\N		\N	\N	\N	1125	\N
30		\N		\N	\N	\N	1126	\N
384		\N		\N	\N	\N	1100	\N
236		\N		\N	\N	\N	1032	\N
236		\N		\N	\N	\N	1167	\N
236		\N		\N	\N	\N	1216	\N
474		\N		\N	\N	\N	1255	\N
444		\N		\N	\N	\N	1307	\N
403		\N		\N	\N	\N	1316	\N
92		\N		\N	\N	\N	1076	\N
370		\N		\N	\N	\N	1078	\N
47		\N		\N	\N	\N	1052	\N
47		\N		\N	\N	\N	1142	\N
407		\N		\N	\N	\N	1102	\N
407		\N		\N	\N	\N	1107	\N
438		\N		\N	\N	\N	1224	\N
438		\N		\N	\N	\N	1180	\N
25		\N		\N	\N	\N	1037	\N
462		\N		\N	\N	\N	1320	\N
462		\N		\N	\N	\N	1321	\N
207		\N		\N	\N	\N	1152	\N
207		\N		\N	\N	\N	1253	\N
110		\N		\N	\N	\N	1090	\N
460		\N		\N	\N	\N	1317	\N
45		\N		\N	\N	\N	1050	\N
81		\N		\N	\N	\N	1066	\N
81		\N		\N	\N	\N	1173	\N
157		\N		\N	\N	\N	1120	\N
157		\N		\N	\N	\N	1286	\N
423		\N		\N	\N	\N	1296	\N
423		\N		\N	\N	\N	1112	\N
307		\N		\N	\N	\N	1183	\N
218		\N		\N	\N	\N	1162	\N
218		\N		\N	\N	\N	1302	\N
219		\N		\N	\N	\N	1163	\N
219		\N		\N	\N	\N	1210	\N
172		\N		\N	\N	\N	1158	\N
172		\N		\N	\N	\N	1235	\N
161		\N		\N	\N	\N	1124	\N
161		\N		\N	\N	\N	1123	\N
253		\N		\N	\N	\N	1153	\N
253		\N		\N	\N	\N	1186	\N
15		\N		\N	\N	\N	1281	\N
15		\N		\N	\N	\N	1292	\N
15		\N		\N	\N	\N	1202	\N
15		\N		\N	\N	\N	1256	\N
176		\N		\N	\N	\N	1144	\N
176		\N		\N	\N	\N	1137	\N
461		\N		\N	\N	\N	1318	\N
377		\N		\N	\N	\N	1064	\N
377		\N		\N	\N	\N	1104	\N
54		\N		\N	\N	\N	1305	\N
233		\N		\N	\N	\N	1174	\N
76		\N		\N	\N	\N	1140	\N
303		\N		\N	\N	\N	1046	\N
303		\N		\N	\N	\N	1311	\N
319		\N		\N	\N	\N	1221	\N
48		\N		\N	\N	\N	1184	\N
82		\N		\N	\N	\N	1040	\N
234		\N		\N	\N	\N	1175	\N
234		\N		\N	\N	\N	1168	\N
187		\N		\N	\N	\N	1143	\N
187		\N		\N	\N	\N	1229	\N
121		\N		\N	\N	\N	1053	\N
121		\N		\N	\N	\N	1264	\N
367		\N		\N	\N	\N	1263	\N
428		\N		\N	\N	\N	1299	\N
428		\N		\N	\N	\N	1237	\N
428		\N		\N	\N	\N	1258	\N
428		\N		\N	\N	\N	1273	\N
261		\N		\N	\N	\N	1248	\N
118		\N		\N	\N	\N	1065	\N
118		\N		\N	\N	\N	1230	\N
66		\N		\N	\N	\N	1060	\N
66		\N		\N	\N	\N	1073	\N
182		\N		\N	\N	\N	1234	\N
222		\N		\N	\N	\N	1165	\N
222		\N		\N	\N	\N	1186	\N
84		\N		\N	\N	\N	1330	\N
84		\N		\N	\N	\N	1331	\N
84		\N		\N	\N	\N	1332	\N
135		\N		\N	\N	\N	1333	\N
222		\N		\N	\N	\N	1334	\N
75		\N		\N	\N	\N	1335	\N
217		\N		\N	\N	\N	1336	\N
337		\N		\N	\N	\N	1337	\N
463		\N		\N	\N	\N	1338	\N
258		\N		\N	\N	\N	1339	\N
258		\N		\N	\N	\N	1340	\N
480		\N		\N	\N	\N	1341	\N
480		\N		\N	\N	\N	1342	\N
159		\N		\N	\N	\N	1343	\N
113		\N		\N	\N	\N	1344	\N
325		\N		\N	\N	\N	1345	\N
335		\N		\N	\N	\N	1346	\N
330		\N		\N	\N	\N	1347	\N
270		\N		\N	\N	\N	1348	\N
333		\N		\N	\N	\N	1349	\N
479		\N		\N	\N	\N	1350	\N
39		\N		\N	\N	\N	1351	\N
453		\N		\N	\N	\N	1034	\N
453		\N		\N	\N	\N	1037	\N
453		\N		\N	\N	\N	1221	\N
478		\N		\N	\N	\N	1352	\N
80		\N		\N	\N	\N	1353	\N
346		\N		\N	\N	\N	1354	\N
442		\N		\N	\N	\N	1355	\N
442		\N		\N	\N	\N	1356	\N
442		\N		\N	\N	\N	1357	\N
209		\N		\N	\N	\N	1358	\N
190		\N		\N	\N	\N	1359	\N
64		\N		\N	\N	\N	1360	\N
252		\N		\N	\N	\N	1361	\N
326		\N		\N	\N	\N	1362	\N
94		\N		\N	\N	\N	1363	\N
215		\N		\N	\N	\N	1364	\N
274		\N		\N	\N	\N	1365	\N
21		\N		\N	\N	\N	1366	\N
170		\N		\N	\N	\N	1367	\N
77		\N		\N	\N	\N	1368	\N
115		\N		\N	\N	\N	1369	\N
322		\N		\N	\N	\N	1370	\N
182		\N		\N	\N	\N	1371	\N
182		\N		\N	\N	\N	1372	\N
363		\N		\N	\N	\N	1373	\N
254		\N		\N	\N	\N	1374	\N
109		\N		\N	\N	\N	1375	\N
202		\N		\N	\N	\N	1376	\N
202		\N		\N	\N	\N	1377	\N
320		\N		\N	\N	\N	1378	\N
271		\N		\N	\N	\N	1379	\N
323		\N		\N	\N	\N	1380	\N
89		\N		\N	\N	\N	1381	\N
248		\N		\N	\N	\N	1382	\N
61		\N		\N	\N	\N	1383	\N
313		\N		\N	\N	\N	1384	\N
150		\N		\N	\N	\N	1385	\N
97		\N		\N	\N	\N	1386	\N
336		\N		\N	\N	\N	1387	\N
168		\N		\N	\N	\N	1388	\N
247		\N		\N	\N	\N	1389	\N
249		\N		\N	\N	\N	1390	\N
282		\N		\N	\N	\N	1275	\N
282		\N		\N	\N	\N	1279	\N
22		\N		\N	\N	\N	1391	\N
194		\N		\N	\N	\N	1392	\N
280		\N		\N	\N	\N	1393	\N
260		\N		\N	\N	\N	1394	\N
409		\N		\N	\N	\N	1395	\N
327		\N		\N	\N	\N	1396	\N
327		\N		\N	\N	\N	1397	\N
210		\N		\N	\N	\N	1398	\N
229		\N		\N	\N	\N	1399	\N
232		\N		\N	\N	\N	1119	\N
68		\N		\N	\N	\N	1400	\N
305		\N		\N	\N	\N	1401	\N
317		\N		\N	\N	\N	1402	\N
387		\N		\N	\N	\N	1403	\N
160		\N		\N	\N	\N	1404	\N
160		\N		\N	\N	\N	1405	\N
244		\N		\N	\N	\N	1406	\N
244		\N		\N	\N	\N	1407	\N
241		\N		\N	\N	\N	1408	\N
67		\N		\N	\N	\N	1409	\N
451		\N		\N	\N	\N	1410	\N
448		\N		\N	\N	\N	1411	\N
448		\N		\N	\N	\N	1412	\N
297		\N		\N	\N	\N	1413	\N
297		\N		\N	\N	\N	1414	\N
301		\N		\N	\N	\N	1415	\N
414		\N		\N	\N	\N	1416	\N
321		\N		\N	\N	\N	1417	\N
472		\N		\N	\N	\N	1418	\N
277		\N		\N	\N	\N	1419	\N
277		\N		\N	\N	\N	1420	\N
178		\N		\N	\N	\N	1421	\N
264		\N		\N	\N	\N	1422	\N
264		\N		\N	\N	\N	1423	\N
298		\N		\N	\N	\N	1424	\N
299		\N		\N	\N	\N	1425	\N
296		\N		\N	\N	\N	1426	\N
345		\N		\N	\N	\N	1427	\N
345		\N		\N	\N	\N	1428	\N
345		\N		\N	\N	\N	1429	\N
175		\N		\N	\N	\N	1430	\N
117		\N		\N	\N	\N	1431	\N
147		\N		\N	\N	\N	1432	\N
427		\N		\N	\N	\N	1433	\N
300		\N		\N	\N	\N	1434	\N
152		\N		\N	\N	\N	1435	\N
342		\N		\N	\N	\N	1436	\N
434		\N		\N	\N	\N	1437	\N
434		\N		\N	\N	\N	1438	\N
384		\N		\N	\N	\N	1439	\N
381		\N		\N	\N	\N	1440	\N
90		\N		\N	\N	\N	1441	\N
410		\N		\N	\N	\N	1442	\N
20		\N		\N	\N	\N	1443	\N
373		\N		\N	\N	\N	1444	\N
376		\N		\N	\N	\N	1445	\N
132		\N		\N	\N	\N	1446	\N
341		\N		\N	\N	\N	1447	\N
207		\N		\N	\N	\N	1448	\N
207		\N		\N	\N	\N	1120	\N
110		\N		\N	\N	\N	1449	\N
460		\N		\N	\N	\N	1450	\N
459		\N		\N	\N	\N	1451	\N
134		\N		\N	\N	\N	1452	\N
468		\N		\N	\N	\N	1453	\N
16		\N		\N	\N	\N	1454	\N
208		\N		\N	\N	\N	1455	\N
172		\N		\N	\N	\N	1456	\N
429		\N		\N	\N	\N	1457	\N
59		\N		\N	\N	\N	1458	\N
50		\N		\N	\N	\N	1459	\N
111		\N		\N	\N	\N	1460	\N
111		\N		\N	\N	\N	1461	\N
111		\N		\N	\N	\N	1462	\N
111		\N		\N	\N	\N	1463	\N
275		\N		\N	\N	\N	1464	\N
173		\N		\N	\N	\N	1465	\N
88		\N		\N	\N	\N	1466	\N
328		\N		\N	\N	\N	1467	\N
169		\N		\N	\N	\N	1468	\N
453		\N		\N	\N	\N	1469	\N
84		\N		\N	\N	\N	1470	\N
286		\N		\N	\N	\N	1471	\N
281		\N		\N	\N	\N	1472	\N
275		\N		\N	\N	\N	1473	\N
275		\N		\N	\N	\N	1474	\N
265		\N		\N	\N	\N	1475	\N
433		\N		\N	\N	\N	1476	\N
413		\N		\N	\N	\N	1477	\N
9		\N		\N	\N	\N	1478	\N
461		\N		\N	\N	\N	1479	\N
461		\N		\N	\N	\N	1480	\N
269		\N		\N	\N	\N	1481	\N
432		\N		\N	\N	\N	1482	\N
368		\N		\N	\N	\N	1483	\N
303		\N		\N	\N	\N	1484	\N
294		\N		\N	\N	\N	1485	\N
73		\N		\N	\N	\N	1486	\N
73		\N		\N	\N	\N	1487	\N
422		\N		\N	\N	\N	1488	\N
421		\N		\N	\N	\N	1489	\N
415		\N		\N	\N	\N	1490	\N
74		\N		\N	\N	\N	1491	\N
186		\N		\N	\N	\N	1492	\N
234		\N		\N	\N	\N	1493	\N
7		\N		\N	\N	\N	1494	\N
259		\N		\N	\N	\N	1495	\N
259		\N		\N	\N	\N	1496	\N
44		\N		\N	\N	\N	1497	\N
417		\N		\N	\N	\N	1498	\N
417		\N		\N	\N	\N	1499	\N
278		\N		\N	\N	\N	1500	\N
112		\N		\N	\N	\N	1501	\N
112		\N		\N	\N	\N	1502	\N
112		\N		\N	\N	\N	1503	\N
406		\N		\N	\N	\N	1504	\N
406		\N		\N	\N	\N	1505	\N
66		\N		\N	\N	\N	1506	\N
230		\N		\N	\N	\N	1507	\N
481		\N		\N	\N	\N	1508	\N
481		\N		\N	\N	\N	1509	\N
90		\N		\N	\N	\N	1510	\N
90		\N		\N	\N	\N	1511	\N
52		\N		\N	\N	\N	1512	\N
236		\N		\N	\N	\N	1403	\N
230		\N		\N	\N	\N	1513	\N
230		\N		\N	\N	\N	1514	\N
13		\N		\N	\N	\N	1515	\N
106		\N		\N	\N	\N	1516	\N
197		\N		\N	\N	\N	1517	\N
291		\N		\N	\N	\N	1518	\N
42		\N		\N	\N	\N	1519	\N
153		\N		\N	\N	\N	1520	\N
10		\N		\N	\N	\N	1521	\N
310		\N		\N	\N	\N	1522	\N
484		\N		\N	\N	\N	1523	\N
484		\N		\N	\N	\N	1524	\N
485		\N		\N	\N	\N	1525	\N
485		\N		\N	\N	\N	1526	\N
486		\N		\N	\N	\N	1527	\N
486		\N		\N	\N	\N	1528	\N
487		\N		\N	\N	\N	1529	\N
487		\N		\N	\N	\N	1530	\N
488		\N		\N	\N	\N	1531	\N
488		\N		\N	\N	\N	1532	\N
488		\N		\N	\N	\N	1533	\N
488		\N		\N	\N	\N	1534	\N
489		\N		\N	\N	\N	1535	\N
66		\N		\N	\N	\N	1536	\N
417		\N		\N	\N	\N	1537	\N
417		\N		\N	\N	\N	1538	\N
53		\N		\N	\N	\N	1539	\N
132		\N		\N	\N	\N	1540	\N
293		\N		\N	\N	\N	1541	\N
395		\N		\N	\N	\N	1542	\N
402		\N		\N	\N	\N	1543	\N
408		\N		\N	\N	\N	1528	\N
408		\N		\N	\N	\N	1538	\N
408		\N		\N	\N	\N	1333	\N
221		\N		\N	\N	\N	1544	\N
182		\N		\N	\N	\N	1545	\N
14		\N		\N	\N	\N	1546	\N
14		\N		\N	\N	\N	1032	\N
14		\N		\N	\N	\N	1515	\N
106		\N		\N	\N	\N	1160	\N
411		\N		\N	\N	\N	1322	\N
349		\N		\N	\N	\N	1244	\N
349		\N		\N	\N	\N	1246	\N
14		\N		\N	\N	\N	1031	\N
309		\N		\N	\N	\N	1211	\N
309		\N		\N	\N	\N	1161	\N
309		\N		\N	\N	\N	1210	\N
315		\N		\N	\N	\N	1218	\N
315		\N		\N	\N	\N	1219	\N
18		\N		\N	\N	\N	1042	\N
147		\N		\N	\N	\N	1372	\N
159		\N		\N	\N	\N	1198	\N
157		\N		\N	\N	\N	1386	\N
423		\N		\N	\N	\N	1097	\N
423		\N		\N	\N	\N	1176	\N
39		\N		\N	\N	\N	1547	\N
326		\N		\N	\N	\N	1548	\N
441		\N		\N	\N	\N	1549	\N
472		\N		\N	\N	\N	1550	\N
298		\N		\N	\N	\N	1551	\N
403		\N		\N	\N	\N	1552	\N
47		\N		\N	\N	\N	1553	\N
407		\N		\N	\N	\N	1554	\N
275		\N		\N	\N	\N	1555	\N
194		\N		\N	\N	\N	1556	\N
194		\N		\N	\N	\N	1557	\N
210		\N		\N	\N	\N	1558	\N
9		\N		\N	\N	\N	1559	\N
432		\N		\N	\N	\N	1560	\N
233		\N		\N	\N	\N	1561	\N
167		\N		\N	\N	\N	1562	\N
380		\N		\N	\N	\N	1563	\N
196		\N		\N	\N	\N	1564	\N
159		\N		\N	\N	\N	1565	\N
154		\N		\N	\N	\N	1566	\N
490		\N		\N	\N	\N	1567	\N
491		\N		\N	\N	\N	1568	\N
493		\N		\N	\N	\N	1569	\N
492		\N		\N	\N	\N	1570	\N
36		\N		\N	\N	\N	1571	\N
377		\N		\N	\N	\N	1572	\N
292		\N		\N	\N	\N	1573	\N
494		\N		\N	\N	\N	1574	\N
494		\N		\N	\N	\N	1575	\N
494		\N		\N	\N	\N	1576	\N
156		\N		\N	\N	\N	1577	\N
79		\N		\N	\N	\N	1578	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: lo
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

