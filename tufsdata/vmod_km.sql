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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO km;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO km;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO km;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: km
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


ALTER TABLE public.t_instance OWNER TO km;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO km;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO km;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: km
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


ALTER TABLE public.t_usage_classified_rel OWNER TO km;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: km
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


ALTER TABLE public.t_usage_inst_rel OWNER TO km;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO km;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO km;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: km
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO km;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: km
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


ALTER TABLE public.t_word_inst_rel OWNER TO km;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: km
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO km;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: km
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO km;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: km
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_index_char (id, index_char) FROM stdin;
1	ក
2	ខ
3	គ
4	ឃ
5	ង
6	ច
7	ឆ
8	ជ
9	ឈ
10	ញ
11	ដ
12	ឋ
13	ឌ
14	ឍ
15	ណ
16	ត
17	ថ
18	ទ
19	ធ
20	ន
21	ប
22	ផ
23	ព
24	ភ
25	ម
26	យ
27	រ
28	ល
29	វ
30	ស
31	ហ
32	ឡ
33	អ
34	ឥ
35	ឦ
36	ឧ
37	ឩ
38	ឪ
39	ឫ
40	ឬ
41	ឭ
42	ឮ
43	ឯ
44	ឰ
45	ឱ
46	ឳ
47	ឲ្យ
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
17	ស៊ីចេក។	食う＋バナナ＝バナナを食う。	null	シー・チェーク　siː ceːk	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
63	ខ្លានោះ	虎＋それ＝その虎	null	クラー・ヌフ　kʰlaː nuh	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
370	អរគុណ។	喜ぶ＋恩＝ありがとう。	null	オー・クン　ʔɔː kʊn	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
449	ល្អណាស់។	それはよかった。	さよならを言う		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
813	កា		null	kaː	\N	pmod	page007.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
839	ឆ្មា	猫	null	cʰmaː	\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
1000	ទ្វារផ្ទះបោរបិទមិនជិត។	戸がしっかり閉まらない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1058	ស្ទីឡូនេះហៀរទឹកប្រឡាក់អាវអស់។	この万年筆はインクがこぼれて服が汚れた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1171	គ្រានោះ មានឈ្នួលម្នាក់លីវ៉ាលីសស្បែកមួយធំនៅលើស្មាឆ្វេងនិងយួរកូនវ៉ាលីសតូចមួយនៅដៃស្ដាំ ដើរតាមក្រោយស្ត្រីទាំងបីប្រាណ។	その時、左肩に大きな皮のスーツケースを担ぎ、右手に小さなスーツケースをさげた荷物持ちが、３人の女性の後から歩いていった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1173	ភិក្ខុទាំងប៉ុន្មានសឹងស្រុះស្រួលគ្រប់អង្គជួយចិញ្ចឹមនិងបង្រៀនសូផាត។	僧侶は全員で、ソパートを養い育て、教えた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1174	នាងជឿជាក់ពាក្យលោកសួនពីរោះឈ្ងុយឆ្ងាញ់ចុកក្នុងត្រចៀកនាង។	彼女は、耳に心地よい響きのスオンのことばをすっかり信じていた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1175	ចំនួនប្រាំម៉ោងក្រោយមកគ្រូពេទ្យអញ្ជើញមកដល់។	５時間後、医者が到着した。	\N	\N	\N	vmod	\N	\N	\N	0	1
51	ត្រីធំ	魚＋大きい＝大きい魚	null	トライ・トム　trəi tʰom	\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
124	មិនញ៉ាំឬ?	～ない＋食べる＋か＝食べないのですか。	null	ムン・ニャム・ルー　mɯn ɲam rɯː	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
149	ជម្រាបលា។	告げる＋別れる＝さようなら。	null	チョムリアップ・リア　cʊmriˑəp liˑə	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
419	ពីរនាក់	２＋人＝２人	null	ピー・ネアック　piː nɛ̀ək	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
519	ចាស បាន។	はい、どうぞ。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
861	ត្រា	印鑑	null	traː	\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	\N	\N	\N
1042	ក្មេងចូលចិត្តបៀមស្ករគ្រាប់។	子どもは飴をなめるのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1083	ស្លឹកឈើប្រែពណ៌នៅរដូវលំហើយ។	木の葉は秋に色が変わる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1143	ហេតុអ្វីក៏អ្នកបងរត់ចេញពីផ្ទះឪពុកខ្ញុំ។	どうして私のお父さんの家から逃げ出したのですか。	\N		\N	vmod	\N	\N	\N	0	1
1144	ញ៉ាំទឹកតែទេ?	お茶を飲みませんか。	\N		\N	vmod	\N	\N	\N	0	1
1145	នាងអ៊ូរីឈរនៅជិតតុសូផាត ឥតមានវាចាអ្វី។	ウリーは、何もいわずにソパートの机の近くに立った。	\N		\N	vmod	\N	\N	\N	0	1
1146	ជួនកាលមានរទេះអូសមួយៗរត់យឺតៗ ដោយអ្នកអូសអស់កម្លាំងខ្លាំងពេកណាស់។	ときどき、ひき手が疲れきった荷車が、ゆっくりと走っていった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1147	ក្នុងគ្រានោះ នាងវិធាវីពាក់អាវទំនើបថ្មីពណ៌កុលាបខ្ចី។	その時、ヴィティアヴィーは淡いピンク色の新しい服を着ていた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1148	សាច់គោថ្លៃជាងសាច់មាន់។	牛肉は鶏肉より高い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1152	អត់ទេ អត់យល់ទេ។	いいえ、わかりません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1	ស្អែកទៅស្រុកខ្មែរ។	明日＋行く＋国＋カンボジア＝明日はカンボジアに行く。	null	スアエク・タウ・スロック・クマエ　sʔaek tə̀w srok kʰmae	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2	ទៅ​(ស្រុកខ្មែរ)ស្អែក។	行く＋（国＋カンボジア＋）明日＝明日（カンボジアに）行く。	null	タウ（・スロック・クマエ）・スアエク 　tə̀w (srok kʰmae) sʔaek	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
3	រៀនពូកែ។	学ぶ＋上手な＝（学習した結果、）覚えがいい。	null	リアン・プーカエ　riˑən puːkae	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
4	ពូកែរៀន។	上手な＋学ぶ＝がんばって学習している。（けれど、効果があがっているとは限らない。）	null	プーカエ・リアン　puːkae riˑən	\N	gmod	explanation001.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
5	ភាសាខ្មែរ	言語＋カンボジア＝カンボジア語	null	ピアサー・クマエ　pʰiˑəsaː kʰmae	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
6	ម្ហូបខ្មែរ	料理＋カンボジア＝カンボジア料理	null	ムホープ・クマエ　mhoːp kʰmae	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
7	រៀនច្រើន។	学ぶ＋たくさん＝たくさん学ぶ。	null	リアン・チラウン　riˑən craən	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
8	ចង់រៀន។	たい＋学ぶ＝学びたい。	null	チョン・リアン　cɔŋ riˑən	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
9	មិនរៀន។	ない＋学ぶ＝学ばない。	null	ムン・リアン　mɯn riˑən	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
10	នៅសាលា	で＋学校＝学校で	null	ナウ・サーラー　nə̀w saːlaː	\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
11	ទន្សាយបោកយាយ។	うさぎ＋だます＋おばあさん＝うさぎがおばあさんをだます。	null	トンサーイ・バオク・ジアイ　tʷɔ̀ｎsaːi baok yiˑəi	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
12	យាយបោកទន្សាយ។	おばあさん＋だます＋うさぎ＝おばあさんがうさぎをだます。	null	ジアイ・バオク・トンサーイ　yiˑəi baok tʷɔ̀ｎsaːi	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
13	ទន្សាយស៊ីចេក។​	うさぎ＋食う＋バナナ＝うさぎがバナナを食う。	null	トンサーイ・シー・チェーク　tʷɔ̀ｎsaːi siː ceːk	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
14	ចេកស៊ីទន្សាយ។​	バナナ＋食う＋うさぎ＝バナナがうさぎを食う。	null	チェーク・シー・トンサーイ　ceːk siː tʷɔ̀ｎsaːi	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
15	យាយជេរទន្សាយ។	おばあさん＋ののしる＋うさぎ＝おばあさんがうさぎをののしる。	null	ジアイ・チェー・トンサーイ　yiˑəi cèː tʷɔ̀ｎsaːi	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
16	ទន្សាយជេរយាយ។	うさぎ＋ののしる＋おばあさん＝うさぎがおばあさんをののしる。	null	トンサーイ・チェー・ジアイ 　tʷɔ̀ｎsaːi cèː yiˑəi	\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
18	ទន្សាយបោក។	うさぎ＋だます＝うさぎがだます。	null	トンサーイ・バオク　 tʷɔ̀ｎsaːi baok 	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
19	យាយជេរ។	おばあさん＋ののしる＝おばあさんがののしる。	null	ジアイ・チェー　yiˑəi cèː	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
20	បោកយាយខ្លាំង។	だます＋おばあさん＋ひどく＝おばあさんをひどくだます。	null	バオク・ジアイ・クラン　baok yiˑəi kʰlaŋ	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
21	ស៊ីចេកលឿន។	食う＋バナナ＋すばやく＝すばやくバナナを食う。	null	シー・チェーク・ルアン　siː ceːk lɯˑən	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
22	ទៅស្រុកជប៉ុន។	行く＋日本＝日本に行く。	null	タウ・スロック・チャポン　tə̀w srok capon	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
23	នឹកផ្ទះ។	恋しい＋家＝家が恋しい。	null	ヌック・プテアハ　nɯk pʰtɛ̀əh	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
24	វាយខ្លា។	殴る＋虎＝虎を（棒で）殴る。	null	ヴィアイ・クラー　viˑəi kʰlaː	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
25	វាយដំបង។	殴る＋棒＝（虎を）棒で殴る。	null	ヴィアイ・ドンボーン　viˑəi dɔmbɔːŋ	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
26	វាយខ្លាដោយដំបង។	殴る＋虎＋で＋棒＝虎を棒で殴る。	null	ヴィアイ・クラー・ダオイ・ドンボーン　viˑəi kʰlaː　daoi dɔmbɔːŋ	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
27	វាយដោយដំបង។	殴る＋で＋棒＝（虎を）棒で殴る。	null	ヴィアイ・ダオイ・ドンボーン　viˑəi daoi dɔmbɔːŋ	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
28	បង្រៀនភាសាខ្មែរខ្ញុំ។	教える＋語＋カンボジア＋私＝カンボジア語を私に教える。	null	ボンリアン・ピアサー・クマエ・クニョム　bɔŋriˑən pʰiˑəsaː kʰmae kʰɲom	\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
29	ឲ្យចេកទន្សាយ។	与える＋バナナ＋うさぎ＝バナナをうさぎに与える。	null	アオイ・チェーク・トンサーイ　ʔaoi ceːk tʷɔ̀nsaːi	\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
30	ទន្សាយឆ្លាត	うさぎ＋賢い＝賢いうさぎ	null	トンサーイ・チラート　tʷɔ̀nsaːi cʰlaːt	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
31	ខ្លាល្ងង់	虎＋間抜けな＝間抜けな虎	null	クラー・ルゴン　kʰlaː lŋʷɔ̀ŋ	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
32	ម្ហូបឆ្ងាញ់	料理＋おいしい＝おいしい料理	null	ムホープ・チガニュ　mhoːp cʰŋaɲ	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
33	ម្ហូបខ្មែរ	料理＋カンボジア＝カンボジア料理	null	ムホープ・クマエ　mhoːp kʰmae	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
64	ទិញនេះ	買う＋これ＝これを買う。	null	テニュ・ニヒ　teɲ nih	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
34	ទន្សាយដែលនៅក្នុងរឿងព្រេងខ្មែរ	うさぎ＋カンボジアの民話に出てくる＝カンボジアの民話に出てくるうさぎ	null	トンサーイ・ダエル・ナウ・クノン・ルアン・プレーン・クマエ　tʷɔ̀nsaːi dael nə̀w knoŋ rɯˑəŋ prèːŋ kʰmae  	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
35	ត្រីដែលខ្ញុំស្ទូចពីម្សិលមិញ	魚＋私が昨日釣った＝私が昨日釣った魚	null	トライ・ダエル・クニョム・ストゥーイ・ピー・ムサルマニュ　ｔｒəi dael kʰɲom stuːc piː msəlməɲ	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
36	មកយឺត។	来る＋遅い＝遅く来る。	null	モーク・ユート　mɔ̀ːk yɯːt	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
37	ញ៉ាំច្រើន។​​​	食べる＋たくさん＝たくさん食べる。	null	ニャム・チラウン　ɲam craəｎ	\N	gmod	explanation008.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
38	ចង់ស៊ី។	たい＋食う＝食いたい。	null	チョン・シー　cɔŋ siː	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
39	មិនទៅ។	ない＋行く＝行かない。	null	ムン・タウ　mɯn tə̀ｗ	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
40	អំពីទន្សាយ	～について＋うさぎ＝うさぎについて（話す）。	null	オンピー・トンサーイ　ʔɔmpiː tʷɔ̀nsaːi	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
41	ជាងនេះ	～より＋これ＝これより（おいしい）。	null	チアン・ニヒ　ciˑəŋ nih	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
42	ស្រុកខ្មែរ	国＋カンボジア＝カンボジア国	null	スロック・クマエ　srok kʰmae	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
43	ផ្ទះខ្ញុំ	家＋私＝私の家	null	プテアハ・クニョム　ptɛ̀əh kʰɲom	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
44	ភាសាជប៉ុន	言語＋日本＝日本語	null	ピアサー・チャポン　pʰiˑəsaː capon	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
45	ទឹកភ្នែក	水＋目＝涙	null	トゥック・プネーク　tɯk pʰnɛ̀ːk	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
46	ទឹកដោះគោ	水＋乳＋牛＝牛乳	null	トゥック・ドホ・コー　ｔɯk dɔh kòː	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
47	ប្រាជ្ញារបស់ទន្សាយ	知恵＋の＋うさぎ＝うさぎの知恵	null	プラチニャー・ロボホ・トンサーイ　pracɲaː rɔ̀bɔh tʷɔ̀nsaːi	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
48	ផ្ទះរបស់ខ្ញុំ	家＋の＋私＝私の家	null	プテアハ・ロボホ・クニョム 　ptɛ̀əh rɔ̀bɔh kʰɲom	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
49	ផ្ទះខ្ញុំ	家＋私＝私の家	null	プテアハ・クニョム　ptɛ̀əh kʰɲom	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
50	របស់ខ្ញុំ	の＋私＝の	null	ロボホ・クニョム　rɔ̀bɔh kʰɲom	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
52	ឆ្កែខ្មៅ	犬＋黒い＝黒い犬	null	チカエ・クマウ　cʰkae kʰmaw	\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
53	របស់ខ្ញុំ	の＋私＝私の	null	ロボホ・クニョム　rɔ̀bɔh kʰɲom	\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
54	អាធំ	の＋大きい＝大きいの	null	アー・トム　ʔaː tʰom	\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
55	អាខ្មៅ	の＋黒い＝黒いの	null	アー・クマウ　ʔaː kʰmaw	\N	gmod	explanation012.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
56	ត្រីអាំង	魚＋焼く＝焼き魚	null	トライ・アン　trəi ʔaŋ	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
57	ផ្កាស្រពោន	花＋しおれた＝しおれた花	null	プカー・スロポーン　pʰkaː srɔpòːn	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
58	ថ្មបាក់	石＋崩れた＝崩れた石（危ない橋）	null	トゥモー・バック　tʰmɔː bak	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
59	ត្រីខ្ញុំអាំង	魚＋私＋焼く＝私が焼いた魚	null	トライ・クニョム・アン　trəi kʰɲom ʔaŋ	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
60	ត្រីដែលខ្ញុំអាំង	魚＋サイン＋私＋焼く＝私が焼いた魚	null	トライ・ダエル・クニョム・アン　trəi dael kʰɲom ʔaŋ	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
61	ឆ្កែអណ្ដាតពាំព្រីង	犬＋舌＋くわえる＋プリン＝プリンの実をくわえた舌の（紫の斑点のある）犬	null	チカエ・オンダート・ポアム・プリーン　cʰkae ʔɔndaːt pɔəm　priːŋ	\N	gmod	explanation013.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
62	ឆ្មានេះ	猫＋これ＝この猫	null	チマー・ニヒ　cʰmaː nih	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
269	ផ្ទះខ្ញុំ	家＋私＝私の家	null	プテアハ・クニョム　ptɛ̀əh kʰɲom	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
65	ទិញអាវនេះ	買う＋シャツ＋これ＝このシャツを買う。	null	テニュ・アーウ・ニヒ　teɲ ʔaːw nih	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
66	ចេកនិងស្វា	バナナ＋と＋猿＝バナナと猿	null	チェーク・ヌン・スヴァー　ceːk nɯŋ svaː	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
67	ស្រមោចនិងស្ករ	アリ＋と＋砂糖＝アリと砂糖	null	スロマオイ・ヌン・スコー　srɔmaoc nɯŋ skɔː	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
68	សៀវភៅនេះនិងសៀភៅនោះ	本＋これ＋と＋本＋それ＝この本とその本	null	シアウパウ・ニヒ・ヌン・シアウパウ・ヌフ　siˑəwpʰə̀w nih nɯŋ siˑəwpʰə̀w nuh 	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
69	ចាបស្រុកនិងចាបព្រៃ	雀＋里＋と＋雀＋森＝里雀と野生の雀	null	チャープ・スロック・ヌン・チャープ・プレイ　caːｐ srok nɯŋ caːｐ prèi	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
70	គោ ក្របី ជ្រូកនិងមាន់	牛＋水牛＋豚＋と＋鶏＝牛と水牛と豚と鶏	null	コー・クロバイ・チルーク・ヌン・モアン　kòː krɔｂəi cruːk nɯŋ mɔən	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
71	ទន្សាយដែលចង់ស៊ីចេក	うさぎ＋サイン＋バナナを食いたい＝バナナを食いたいうさぎ	null	トンサーイ・ダエル・チョン・シー・チェーク　ｔʷɔ̀nsaːi dael cɔŋ siː ceːk	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
72	យាយដែលចាញ់បោកទន្សាយ	老婆＋サイン＋うさぎにだまされた＝うさぎにだまされたおばあさん	null	ジアイ・ダエル・チャニュ・バオク・トンサーイ　yiˑəi dael caɲ baok ｔʷɔ̀nsaːi 	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
73	ទន្សាយចង់ស៊ីចេក	うさぎ＋バナナを食いたい＝バナナを食いたいうさぎ	null	トンサーイ・チョン・シー・チェーク　ｔʷɔ̀nsaːi  cɔŋ siː ceːk	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
74	ដែលស៊ីចេក	サイン＋バナナを食う＝バナナを食ったの（はあいつだ）。	null	ダエル・シー・チェーク　dael  siː ceːk	\N	gmod	explanation016.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
76	ស្រីៗ	女＋女（繰り返し記号）＝女たち	null	スライ・スライ　srəi srəi	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
77	ត្រីច្រើនៗ	魚＋たくさん＋繰り返し記号＝いろいろな種類のたくさんの魚	null	トライ・チラウン・チラウン　trəi craən craəｎ	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
78	ក្របីជម្រាបសួរទន្សាយ ទន្សាយក៏ជម្រាបសួរវិញ។	水牛＋挨拶する＋うさぎ　繰り返し記号＋も＋挨拶する＋戻す＝水牛はうさぎに挨拶し、うさぎも挨拶を返した。	null	クロバイ・チョムリアプ・スオ・トンサーイ・トンサーイ・コー・チョムリアプ・スオ・ヴニュ　krɔbəi cʊｍriˑəp suˑo tʷɔ̀nsaːi tʷɔ̀nsaːi kɔː cʊｍriˑəp suˑo  vɯŋ 	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
79	មកយឺត។	来る＋遅く＝遅れて来た。	null	モーク・ユート　mɔ̀ːk yɯːt	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
80	មកពីម្សិលមិញ។	来る＋昨日＝昨日来た。	null	モーク・ピー・ムサルマニュ　mɔ̀ːk piː msəlməɲ	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
81	មកបីដង។	来る＋３回＝３回来た。	null	モーク・バイ・ドーン　mɔ̀ːk bəi dɔːŋ 	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
82	ក្ដៅខ្លួន។	暑い＋身体＝熱がある。	null	クダウ・クルオン　kdaw kluˑon	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
83	ពូកែធ្វើការ។	上手な＋働く＝仕事ができる。	null	プーカエ・トゥヴー・カー　puːkae tʰvə̀ː kaː	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
84	ទន្សាយត្រចៀកវែង។	うさぎ＋耳＋長い＝うさぎは耳が長い。	null	トンサーイ・トロチアク・ヴェーン　tʷɔ̀nsaːi trɔciˑək vɛ̀ːŋ	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
85	ឡើងឆ្ងាញ់។	なる＋おいしい＝おいしくなる。（前はまずかった。）	null	ラウン・チガニュ　laəŋ cʰŋaɲ	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
86	ឆ្ងាញ់ឡើង។	おいしい＋なる＝ますますおいしくなる。（前もおいしかったが、おいしさの程度が増した。）	null	チガニュ・ラウン　cʰŋaɲ laəŋ 	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
87	ឆ្ងាញ់ឡើងៗ។	おいしい＋なる＋繰り返し記号＝ますますおいしくなる。	null	チガニュ・ラウン・チガニュ・ラウン　cʰŋaɲ laəŋ cʰŋaɲ laəŋ	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
88	កាន់តែឆ្ងាញ់ឡើង។	ますます＋おいしい＋なる＝ますますおいしくなる	null	カン・タエ・チガニュ・ラウン 　kan tae cʰŋaɲ laəŋ	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
89	មិនរៀន។	～ない＋学ぶ＝勉強しない。	null	ムン・リアン　mɯn riˑən	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
90	អត់ល្អ។	～ない＋よい＝よくない。	null	オット・ルオー　ʔɔｔ　ｌʔɔː	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
91	មិនទៅទេ។	～ない＋行く＋よ＝（行くと思っているだろうけど）行かないよ！	null	ムン・タウ・テー　mɯn tə̀w tèː	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
92	មិនរៀនសោះ។	～ない＋学ぶ＋全く＝全く勉強しない。	null	ムン・リアン・ソホ　mɯn riˑən sɔh	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
93	មិនសូវល្អ។	～ない＋あまり＋よい＝あまりよくない。	null	ムン・サウ・ルオー　mɯn səw lʔɔː	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
94	មើលខ្លា។	見る＋虎＝虎を見る。	null	ムール・クラー　mə̀ːl kʰlaː	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
95	ឃើញខ្លា។	見える＋虎＝虎が見える。	null	クーニュ・クラー　kʰə̀ːɲ kʰlaː	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
96	ខ្លាមើល។	虎＋見る＝虎が（何かを）見る。	null	クラー・ムール　kʰlaː mə̀ːl 	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
97	ខ្លាឃើញ។	虎＋見える＝虎には（何かが）見える。	null	クラー・クーニュ　kʰlaː kʰə̀ːɲ 	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
98	ស្ដាប់ចម្រៀង។	聞く＋歌＝歌を聞く。	null	スダップ・チョムリアン　sdap cɔmriˑəŋ	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
99	ឮចម្រៀង។	聞こえる＋歌＝歌が聞こえる。	null	ルー・チョムリアン　lɯː cɔmriˑəŋ	\N	gmod	explanation022.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
100	អាំងត្រីញ៉ាំ។	焼く＋魚＋食べる（＋魚）＝魚を焼いて（魚を）食べる。	null	アン・トライ・ニャム　ʔaŋ trəi ɲam	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
101	ទៅរៀន។	行く＋学ぶ＝勉強しに行く。（学校に行く。）	null	タウ・リアン　ｔə̀w riˑən	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
102	មើលឃើញ។	見る＋見える＝（見ようとして）見えた。	null	ムール・クーニュ　mə̀ːl kʰə̀ːɲ	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
103	រកមិនឃើញ។	探す＋～ない＋見える＝探しても見つからない。	null	ローク・ムン・クーニュ　rɔ̀ːk mɯn kʰə̀ːɲ	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
104	មិនយកទៅ។	～ない＋持つ＋行く＝持って行かない。	null	ムン・ヨーク・タウ　mɯn yɔ̀ːk tə̀w	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
105	ខ្ញុំញ៉ាំនំ។	私＋食べる＋菓子＝私が菓子を食べる。私は（何をするかというと）菓子を食べる。（カンボジア語では、この２文の区別はできません。）	null	クニョム・ニャム・ノム　kʰɲom ɲam nʊm	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
106	នំខ្ញុំញ៉ាំ	菓子＋私＋食べる＝菓子は（菓子について言えば）私が食べる。	null	ノム・クニョム・ニャム　nʊm kʰɲom ɲam 	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
107	គាត់ខ្នងវែង។	彼＋背中＋長い＝彼は怠け者だ。	null	コアット・クノーン・ヴェーン　kɔət kʰnɔːŋ vɛ̀ːŋ	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
108	គាត់ថ្លើមខ្មៅ។	彼＋肝＋黒い＝彼は意地悪だ。	null	コアット・トラウム・クマウ　kɔət tʰlaəm kʰmaw	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
109	ស្អែកទៅស្រុកខ្មែរ។	明日＋行く＋国＋カンボジア＝明日はカンボジアに行く。	null	スアエク・タウ・スロック・クマエ　sʔaek tə̀w srok kʰmae	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
110	ទៅ​(ស្រុកខ្មែរ)ស្អែក។	行く＋（国＋カンボジア＋）明日＝明日（カンボジアに）行く。	null	タウ（・スロック・クマエ）・スアエク　tə̀w(srok kʰmae) sʔaek	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
111	បីថ្ងៃទៀត ទៅ​ស្រុកខ្មែរ។	３日＋あと＋行く＋カンボジア国＝あと３日でカンボジアに行く。（「３日」の言い方は後のステップで説明します。）	null	バイ・トゥガイ・ティアット・タウ・スロック・クマエ　bəi tʰŋai tiˑət tə̀w srok kʰmae	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
112	នៅ​ស្រុកខ្មែរបីថ្ងៃទៀត។	いる＋カンボジア国＋３日＋あと＝あと３日カンボジアにいる。	null	ナウ・スロック・クマエ・バイ・トゥガイ・ティアット　nə̀w srok kʰmae bəi tʰŋai tiˑət 	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
113	ញ៉ាំឬទេ?	食べる＋か否か＝食べますか、食べませんか。	null	ニャム・ルー・テー　ɲam rɯː tèː	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
114	ញ៉ាំទេ?	食べる＋否か＝食べませんか、食べますよね。	null	ニャム・テー　ɲam tèː	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
115	ញ៉ាំឬ?	食べる＋か＝食べますか、食べるのですか。	null	ニャム・ルー　ɲam rɯː	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
116	បាទ / ចាស  ញ៉ាំ។	はい＋食べる＝はい、食べます。	null	バート／チャー・ニャム　baːt / caːh  ɲam	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
117	ទេ មិនញ៉ាំ។	いいえ＋～ない＋食べる＝いいえ、食べません。	null	テー・ムン・ニャム　tèː mɯn ɲam	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
118	ញ៉ាំនំ។	食べる＋菓子＝菓子を食べる。	null	ニャム・ノム　ɲam nʊm	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
119	ញ៉ាំអី?	食べる＋何＝何を食べますか。	null	ニャム・アイ　ɲam ʔəi	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
120	ញ៉ាំប៉ុន្មាន?	食べる＋いくつ＝いくつ食べますか。	null	ニャム・ポンマーン　ɲam ponmaːn	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
121	ទៅ(កន្លែង)ណា?	行く＋どこ＝どこへ行きますか。	null	タウ（・コンラエン）・ナー　tə̀w (kɔnlaeŋ) naː	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
122	ទៅពេលណា?	行く＋いつ＝いつ行きますか。	null	タウ・ペール・ナー　tə̀w pèːl naː	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
123	អ្នកណាទៅ?	誰＋行く＝誰が行きますか。	null	ネアック・ナー・タウ　nɛ̀ək naː tə̀w	\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
125	ចុះអ្នកវិញ?	では＋あなた＋戻る＝（お元気ですか。）では、あなたは。	null	チョホ・ネアック・ヴニュ　coh nɛ̀ək vəɲ	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
126	ចុះស្វាយនេះវិញ?	では＋マンゴー＋これ＋戻る＝（このみかんはいくらですか。）では、このマンゴーは。	null	チョホ・スヴァーイ・ニヒ・ヴニュ　coh svaːi nih vəɲ	\N	gmod	explanation028.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
127	នេះផ្ទះខ្ញុំ។	これ＋家＋私＝これは私の家です。	null	ニヒ・プテアハ・クニョム　nih pʰtɛ̀əh kʰɲom	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
128	នេះមិនមែនផ្ទះគាត់។	これ＋～ない＋本当に＋家＋彼＝これは彼の家ではありません。	null	ニヒ・ムン・メーン・プテアハ・コアット　nih mɯn mɛ̀ːn pʰtɛ̀əh kɔət	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
129	នេះផ្ទះគាត់ឬ?	これ＋家＋彼＋か＝これは彼の家ですか。	null	ニヒ・プテアハ・コアット・ルー　nih pʰtɛ̀əh kɔət rɯː	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
130	មិនញ៉ាំ។	～ない＋食べる＝食べない。（食べる意志はない。）	null	ムン・ニャム　mɯn ɲam	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
131	មិនមែនញ៉ាំ។	～ない＋本当に＋食べる＝食べるのではない。（捨てるのだ。）	null	ムン・メーン・ニャム　mɯn mɛ̀ːn ɲam	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
132	មិនមែនខ្ញុំញ៉ាំ។	～ない＋本当に＋私＋食べる＝私が食べるのではない。（妹が食べるのだ。）	null	ムン・メーン・クニョム・ニャム　mɯn mɛ̀ːn kʰɲom ɲam	\N	gmod	explanation029.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
133	ញ៉ាំអីបន្តិច។	食べる＋何＋ちょっと＝ちょっと何か食べる。	null	ニャム・アイ・ボンタイ　ɲam ʔəi bɔntəc	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
134	ញ៉ាំអីឬ?	食べる＋何＋か＝何か食べますか。	null	ニャム・アイ・ルー　ɲam ʔəi rɯː	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
135	ញ៉ាំអី?	食べる＋何＝何を食べますか。	null	ニャム・アイ　ɲam ʔəi 	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
136	ទៅកន្លែងណា?	行く＋どこ＝どこへ行きますか。	null	タウ・コンラエン・ナー　tə̀w kɔnlaeŋ naː	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
137	ទៅកន្លែងណាឬ?	行く＋どこ＋か＝どこかへ行きますか。	null	タウ・コンラエン・ナー・ルー　tə̀w kɔnlaeŋ naː rɯː	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
138	ពេលណាក៏បាន។	いつ＋も＋いい＝いつでもいい。	null	ペール・ナー・コー・バーン　pèːl naː kɔː baːn	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
139	ទៅពេលណាក៏បាន។	行く＋いつ＋も＋いい＝いつ行ってもいい。	null	タウ・ペール・ナー・コー・バーン　tə̀w pèːl naː kɔː baːn	\N	gmod	explanation030.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
140	ខ្ញុំ  យើង  លោក  លោកស្រី  គាត់  គេ  វា	私、私たち、あなた（男性）、あなた（女性）、彼（女）、彼（ら）、やつ・それ	null	クニョム、ジューン、ローク、ローク・スライ、コアット、ケー、ヴィア　kʰɲom,　yə̀ːŋ,　lòːk,　lòːk srəi,　kɔət,　kèː,　viˑə	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
141	កូនខ្ញុំវា	子＋私＋やつ＝私の子、あいつは～	null	コーン・クニョム・ヴィア　koːn kʰɲom viˑə	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
270	របស់ខ្ញុំ	の＋私＝私の	null	ロボホ・クニョム　rɔ̀bɔh kʰɲom	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
142	ជីតា  ជីដូន  (យាយ)  ឪពុក  ម្ដាយ	祖父、祖母、父、母	null	チー・ター、チー・ドーン（ジアイ）、アウプック、ムダーイ　ciːtaː,　ciːdoːŋ(yiˑəi),　ʔəwpʊk,　mdaːi	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
143	អ៊ំប្រុស  អ៊ំស្រី  ពូ  មីង	伯父・母（親より年上）、叔父（親より年下）、叔母（親より年下）	null	オム（プロホ／スライ）、プー、ミーン　ʔom (proh / srəi),　puː,　miːŋ	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
144	បងប្រុស  បងស្រី  ប្អូនប្រុស  ប្អូនស្រី	兄・姉、弟・妹、子、孫、甥・姪	null	ボーン（プロホ／スライ）、プオーン（プロホ／スライ）　 bɔːŋ(proh / srəi),　pʔoːn (proh / srəi)	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
145	កូនប្រុស  កូនស្រី  ចៅប្រុស  ចៅស្រី  ក្មួយប្រុស  ក្មួយស្រី	兄・姉、弟・妹、子、孫、甥・姪	null	コーン（プロホ／スライ）、チャウ（プロホ／スライ）、クムオイ（プロホ／スライ）　koːn(proh / srəi),　caw(proh / srəi),　kmuˑoi(proh / srəi)	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
146	ជម្រាបសួរ។	告げる＋尋ねる＝はじめまして、こんにちは。（会ったときの挨拶）	null	チョムリアップ・スオ　cʊmriˑəp suˑo	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
147	ខ្ញុំឈ្មោះ   ～   ។	私＋名前＋～＝名前は～です。	null	クニョム・チモホ・～　kʰɲom cʰmʷɔ̀h	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
148	ខ្ញុំអាយុ    ～   ឆ្នាំ។	私＋年齢＋～＋歳＝年齢は～歳です。	null	クニョム・アーユ・～・チナム　kʰɲom ʔaːyuʔ ～ cʰnam	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
150	អរគុណ។	喜ぶ＋恩＝ありがとう。	null	オー・クン　ʔɔː kʊn	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
151	មិនអីទេ។	～ない＋何＋よ＝どういたしまして。	null	ムン・アイ・テー　mɯn ʔəi tèː	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
152	សូមទោស។	請う＋罪＝すみません。	null	ソーム・トーホ　soːm tòːh	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
153	ទៅ!	行く＝行け。	null	タウ　tə̀w	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
154	កុំទៅ!	～するな＋行く＝行くな。	null	コム・タウ　kom tə̀w	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
155	ហាមជក់បារី។	禁じる＋吸う＋タバコ＝禁煙。	null	ハーム・チュオック・バライ　haːm cʷɔ̀k baːrəi	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
156	សូមញ៉ាំ។	お願い＋食べる＝食べてください。	null	ソーム・ニャム　soːm ɲam	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
157	សូមកុំញ៉ាំ។	お願い＋禁止＋食べる＝食べないでください。 	null	ソーム・コム・ニャム　soːm kom ɲam	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
158	អញ្ជើញ។	どうぞ＝どうぞ。	null	オンチューニュ　ʔɔɲcə̀ːɲ	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
159	មានភ្នំ។	ある＋山＝山がある。	null	ミアン・プノム　miˑən pʰnʊm	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
160	អត់មានមនុស្ស។	～ない＋ある＋人＝人がいない。	null	オット・ミアン・モヌフ　ʔɔt miˑən mɔ̀nuh	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
161	មានស្វាយឬ?	ある＋マンゴー＋か＝マンゴーはありますか。	null	ミアン・スヴァーイ・ルー　miˑən svaːi rɯː	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
162	ខ្ញុំមានសៀវភៅ។	私＋ある＋本＝私は本を持っている。	null	クニョム・ミアン・シアウパウ　kʰɲom miˑən siˑəwpʰəw	\N	gmod	explanation035.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
164	ម្ដាយអត់នៅផ្ទះ។	母＋～ない＋ある＋家＝母は家にいない。	null	ムダーイ・オット・ナウ・プテアハ　mdaːi ʔɔt nə̀w pʰtɛ̀əh	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
165	មានខ្លានៅព្រៃនោះ។	ある＋虎＋ある＋森＋それ＝その森に虎がいる。	null	ミアン・クラー・ナウ・プレイ・ヌフ　miˑən kʰlaː nə̀w prèi nuh	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
166	មានមីននៅជិតនេះឬ?	ある＋地雷＋に＋近い＋これ＋か＝この近くに地雷がありますか。	null	ミアン・ミーン・ナウ・チュット・ニヒ・ルー　miˑən miːn nə̀w cɯt nih rɯː 	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
167	ញ៉ាំថ្ងៃនេះ។	食べる＋今日＝今日食べる。	null	ニャム・トゥガイ・ニヒ　ɲam tʰŋai nih	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
168	ញ៉ាំពីម្សិលមិញ។	食べる＋昨日＝昨日食べた。	null	ニャム・ピー・ムサル・マニュ　ɲam piː msəl məɲ	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
489	មិនអីទេ។	どういたしまして。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
169	ញ៉ាំហើយ។	食べる＋た＝もう食べた。	null	ニャム・ハウイ　ɲam haəi	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
170	ញ៉ាំហើយឬនៅ?	食べる＋た＋か＋まだ＝もう食べましたか。	null	ニャム・ハウイ・ルー・ナウ　ɲam haəi rɯː nə̀w	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
171	មិនទាន់ញ៉ាំ។	～ない＋間に合う＋食べる＝まだ食べていません。	null	ムン・トアン・ニャム　mɯn tɔən ɲam	\N	gmod	explanation037.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
172	ទៅស្អែក។	行く＋明日＝明日行く。	null	タウ・スアエク　tə̀w sʔaek	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
173	នឹងទៅស្អែក។	つもり＋行く＋明日＝明日行くつもりだ。	null	ヌン・タウ・スアエク　nɯŋ tə̀w sʔaek	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
174	នឹងទៅតែមិនបានទៅ។	つもり＋行く＋しかし＋～ない＋できる＋行く＝行くつもりだったが、行けなかった。	null	ヌン・タウ・タエ・ムン・バーン・タウ　nɯŋ tə̀w tae mɯn baːn tə̀w	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
175	កំពុងរៀនភាសាខ្មែរ។	ている＋学ぶ＋語＋カンボジア＝今まさにカンボジア語を勉強している。（今のあなたの状態ですね。）	null	コンポン・リアン・ピアサー・クマエ　kɔmpʊŋ riˑən pʰiˑəsaː kʰmae	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
176	មើលទៅគាត់មនុស្សល្អ។	見る＋行く＋彼＋人＋良い＝彼はいい人みたいだね。	null	ムール・タウ・コアット・モヌフ・ルオー　mə̀ːl tə̀w kɔət mɔ̀nuh lʔɔː	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
177	ឲ្យគាត់រៀនភាសាខ្មែរ។	与える＋彼＋学ぶ＋語＋カンボジア＝彼にカンボジア語を勉強させる。	null	アオイ・コアット・リアン・ピアサー・クマエ　ʔaoi kɔət riˑən pʰiˑəsaː kʰmae	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
178	ឲ្យកូនញ៉ាំបាយ។	与える＋子＋食べる＋ご飯＝子どもにご飯を食べさせる。	null	アオイ・コーン・ニャム・バーイ　ʔaoi koːn ɲam baːi	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
179	បង្ខំគាត់ឲ្យទៅ។	強制する＋彼＋させる＋行く＝彼に命じて（彼あるいは別の人に）行かせる。	null	ボンコム・コアット・アオイ・タウ　bɔŋkʰɔm kɔət ʔaoi tə̀w	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
180	បង្ខំឲ្យគាត់ទៅ។	強制する＋させる＋彼＋行く＝（彼あるいは別の人に）強制して彼に行かせる。	null	ボンコム・アオイ・コアット・タウ　bɔŋkʰɔm ʔaoi kɔət tə̀w	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
181	បង្ខំគាត់ឲ្យកូនគាត់ទៅ។	強制する＋彼＋させる＋子＋彼＋行く＝彼に強制して、彼の子どもに行かせる。	null	ボンコム・コアット・アオイ・コーン・コアット・タウ　bɔŋkʰɔm kɔət ʔaoi koːn kɔət tə̀w	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
182	ខ្ញុំធ្វើឲ្យគាត់ពិបាក។	私＋作る＋させる＋彼＋困難な＝彼を困らせる。	null	クニョム・トゥヴー・アオイ・コアット・ピバーク　kʰɲom tʰvə̀ː ʔaoi kɔ̀ət piʔbaːk	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
183	គាត់និយាយដូច្នេះ នាំឲ្យខ្ញុំខឹង។	彼＋話す＋そのよう＋連れる＋させる＋私＋怒る＝彼がそのように言ったことが、私を怒らせた。	null	コアット・ニジアイ・ドーチネヘ・ノアム・アオイ・クニョム・カン　kɔ̀ət niːyiˑəi doːcneh nɔəm ʔaoi kʰɲom kʰəŋ	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
184	ខ្ញុំត្រូវចោរលួចកាបូបលុយ។	私＋受ける＋泥棒＋盗む＋かばん＋金＝私は泥棒に財布を盗まれた。	null	クニョム・トラウ・チャオ・ルオイ・カボープ・ルイ　kʰɲom trəw cao luˑoc kaboːp lʊi	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
185	ចោរលួចកាបូបលុយខ្ញុំ។	泥棒＋盗む＋財布＋私の＝泥棒に財布を盗まれた。（泥棒が私の財布を盗んだ。）	null	チャオ・ルオイ・カボープ・ルイ・クニョム　cao luˑoc kaboːp lʊi kʰɲom	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
186	គេនិយាយថា   ។	彼ら＋言う＋～と＝～と言われている。（みんなが～と言っている。）	null	ケー・ニジアイ・ター・～　kèː niːyiˑəi tʰaː	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
187	នេះឆ្ងាញ់ជាងនោះ។	これ＋おいしい＋より＋それ＝これはそれよりおいしい。	null	ニヒ・チガニュ・チアン・ヌフ　nih cʰŋaɲ ciˑəŋ nuh	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
188	នេះឆ្ងាញ់ជាង។	これ＋おいしい＋より＝これの方がおいしい。	null	ニヒ・チガニュ・チアン　nih cʰŋaɲ ciˑəŋ	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
189	នេះឆ្ងាញ់ជាងគេ។	これ＋おいしい＋より＋他＝これは最もおいしい。	null	ニヒ・チガニュ・チアン・ケー　nih cʰŋaɲ ciˑəŋ kèː	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
238	ទន្សាយបោក។	うさぎ＋だます＝うさぎがだます。	null	トンサーイ・バオク　tʷɔ̀ｎsaːi baok 	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
190	នេះឆ្ងាញ់ដូចនោះ។	これ＋おいしい＋同じ＋それ＝これはそれと同じくらいおいしい。	null	ニヒ・チガニュ・ドーイ・ヌフ　nih cʰŋaɲ doːc nuh	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
191	នេះធំប៉ុននោះ។	これ＋大きい＋サイズが同じ＋それ＝これはそれと同じくらい大きい。	null	ニヒ・トム・ポン・ヌフ　nih tʰom pon nuh	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
192	ទៅបាន។	行く＋得る＝行ける。（行ってもいい。）	null	タウ・バーン　tə̀w baːn	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
193	ទៅមិនបាន។	行く＋～ない＋得る＝行けない。	null	タウ・ムン・バーン　tə̀w mɯn baːn	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
194	ចេះនិយាយភាសាខ្មែរទេ?	知る＋話す＋語＋カンボジア＋か＝カンボジア語を話せますか。	null	チェヘ・ニジアイ・ピアサー・クマエ・テー　ceh niːyiˑəi pʰiˑəsaː kʰmae tèː	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
195	ដែលទៅស្រុកខ្មែរ។	～したことがある＋行く＋国＋カンボジア＝カンボジアに行ったことがある。	null	ダエル・タウ・スロック・クマエ　dael tə̀w srok kʰmae	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
196	មិនដែលរៀនភាសាខ្មែរ។	～ない＋～したことがある＋学ぶ＋言語＋カンボジア＝カンボジア語を習ったことがない。	null	ムン・ダエル・リアン・ピアサー・クマエ　mɯn dael riˑən pʰiˑəsaː kʰmae	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
197	សរសេរទុក។	書く＋置く＝書いておく。	null	ソセー・トック　sɔseːtʊk 	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
198	សរសេរមើល។	書く＋見る＝書いてみる。	null	ソセー・ムール　sɔseːmə̀ːl	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
199	ពីរនាក់	２＋人＝２人	null	ピー・ネアック　piː nɛ̀ək	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
200	ស្រីពីរនាក់	女＋２＋人＝２人の女性	null	スライ・ピー・ネアック　srəi piː nɛ̀ək 	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
201	សៀវភៅមួយ	本＋１＝本１冊	null	シアウパウ・ムオイ　siˑəwpʰə̀w muˑoi	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
202	ថ្ងៃសៅរ៍ទីមួយ ខែតុលា ឆ្នាំពីរពាន់ប្រាំ	日＋土曜＋第＋１＋月＋１０月の名＋年＋２００５＝２００５年１０月１日土曜日	null	トゥガイ・サウ・ティー・ムオイ・カエ・トラー・チナム・ピー・ポアン・プラム　tʰŋai saw tiː muˑoi kʰae tolaː cʰnam piː pɔən pram	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
203	ម៉ោងប្រាំ	時間＋５＝５時	null	マオン・プラム　maoŋ pram	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
204	នេះធ្វើអំពីឈើ។	これ＋作る＋で＋木＝これは木でできている。	null	ニヒ・トゥヴー・オンピー・チュー　nih tʰvə̀ː ʔɔmpiː cʰə̀ː	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
205	ខ្ញុំមកពីស្រុកជប៉ុន។	私＋来る＋から＋国＋日本＝私は日本から来ました。	null	クニョム・モーク・ピー・スロック・チャポン　kʰɲom mɔ̀ːk piː srok capon	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
206	គាត់រៀនតាំងពីម៉ោងមួយរហូតដល់ម៉ោងបី។	彼＋学ぶ＋から＋時間＋１＋ずっと＋まで＋時間＋３＝彼は１時から３時まで勉強する。	null	コアット・リアン・タンピー・マオン・ムオイ・ロホート・ドル・マオン・バイ　kɔət riˑən taŋ piː maoŋ muˑoi rɔ̀hoːt dɔl maoŋ bəi	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
207	វាយដោយដំបង។	叩く＋で＋棒＝棒で殴る。	null	ヴィアイ・ダオイ・ドンボーン　viˑəi daoi dɔmbɔːŋ	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
208	រៀនតាមសៀវភៅនេះ។	学ぶ＋沿って＋本＋これ＝この本で学ぶ。	null	リアン・ターム・シアウパウ・ニヒ　riˑən taːm siˑəwpʰə̀w nih	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
209	គាត់ប្រាប់ខ្ញុំថាទៅ។	彼＋告げる＋私＋～と＋行く＝彼は私に行くと言った。	null	コアット・プラップ・クニョム・ター・タウ　kɔət prap kʰɲom tʰaː tə̀w	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
210	គាត់ទៅជាមួយបងប្រុសគាត់។	彼＋行く＋一緒に＋兄姉＋男＋彼＝彼は兄と一緒に行った。	null	コアット・タウ・チアムオイ・ボーン・プロホ・コアト　kɔət tə̀w ciˑə muˑoi bɔːŋ proh kɔət	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
211	ទៅណាដែរ?	行く＋どこ＋か＝どちらへおでかけですか。	null	タウ・ナー・ダエ　tə̀w naː dae	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
212	អត់ដឹងផង។	～ない＋知る＋よ＝知らないよ！	null	オット・ダン・ポーン　ʔɔt dəŋ pʰɔːŋ	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
239	យាយជេរ។	おばあさん＋ののしる＝おばあさんがののしる。	null	ジアイ・チェー　yiˑəi cèː	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
213	មកលេងទៀតណ៎ា។	来る＋遊ぶ＋また＋ね＝また遊びに来てね。	null	モーク・レーン・ティアット・ナー　mɔ̀ːk lèːŋ tiˑət naː	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
214	ចូលមកចុះ។	入る＋来る＋～さいよ＝入りなさい。	null	チョール・モーク・チョホ　coːl mɔ̀ːk coh	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
215	ហេតុអ្វីមិនមក?	理由＋何＋～ない＋来る＝なぜ来なかったのですか。	null	ハエット・アヴァイ・ムン・モーク　haet ʔəvəi mɯn mɔ̀ːk    	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
216	ព្រោះខ្ញុំផ្ដាសាយ។	なぜなら＋私＋風邪をひく＝風邪をひいたからです。	null	（ピー・）プルオホ・クニョム・プダサーイ　(piː) prʷɔ̀h kʰɲom pʰdaːsaːi	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
217	បើទៅស្រុកខ្មែរ គួរមើលប្រាសាទអង្គរវត្ត។	もし＋行く＋国＋カンボジア＋すべき＋見る＋宮殿＋アンコールワット＝もしカンボジアに行くならアンコールワットを見るべきだ。	null	バウ・タウ・スロック・クマエ・クオ・ムール・プラサート・オンコー・ヴォアット　baə tə̀w srok kʰmae kuˑo mə̀ːl praːsaːt ʔɔŋkɔ̀ː vɔət　 　	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
218	សន្សំលុយដើម្បីទៅស្រុកខ្មែរ។	貯める＋金＋～ために＋行く＋国＋カンボジア＝カンボジアに行くために、貯金する。	null	ソンソム・ルイ・ダウムバイ・タウ・スロック・クマエ　sɔnsɔm lʊi daəmbəi tə̀w srok kʰmae	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
219	សន្សំលុយដើម្បីឲ្យកូនទៅស្រុកខ្មែរ។	貯める＋金＋～ために＋与える＋子＋行く＋国＋カンボジア＝子どもをカンボジアに行かせるために、貯金する。	null	ソンソム・ルイ・ダウムバイ・アオイ・コーン・タウ・スロック・クマエ　sɔnsɔm lʊi daəmbəi ʔaoi koːn tə̀w srok kʰmae	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
220	ប្រយ័ត្នដើម្បីកុំឲ្យផ្ដាសាយ។	気をつける＋～ために＋～するな＋与える＋風邪を引く＝風邪をひかないように、気をつける。	null	プロヤット・ダウムバイ・コム・アオイ・プダサーイ　prɔyat daəmbəi kom ʔaoi pʰdaːsaːi	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
221	ស្អែកទៅស្រុកខ្មែរ។	明日＋行く＋国＋カンボジア＝明日はカンボジアに行く。	null	スアエク・タウ・スロック・クマエ　sʔaek tə̀w srok kʰmae	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
222	ទៅ​(ស្រុកខ្មែរ)ស្អែក។	行く＋（国＋カンボジア＋）明日＝明日（カンボジアに）行く。	null	タウ（・スロック・クマエ）・スアエク　tə̀w (srok kʰmae) sʔaek	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
223	រៀនពូកែ។	学ぶ＋上手な＝覚えがいい。	null	リアン・プーカエ　riˑən puːkae	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
224	ពូកែរៀន។	上手な＋学ぶ＝がんばって学習している。	null	プーカエ・リアン　puːkae riˑən	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
225	ភាសាខ្មែរ	言語＋カンボジア＝カンボジア語	null	ピアサー・クマエ　pʰiˑəsaː kʰmae	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
226	ម្ហូបខ្មែរ	料理＋カンボジア＝カンボジア料理	null	ムホープ・クマエ　mhoːp kʰmae	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
227	រៀនច្រើន។	学ぶ＋たくさん＝たくさん学ぶ。	null	リアン・チラウン　riˑən craən	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
229	មិនរៀន។	ない＋学ぶ＝学ばない。	null	ムン・リアン　mɯn riˑən	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
230	នៅសាលា	で＋学校＝学校で	null	ナウ・サーラー　nə̀w saːlaː	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
231	ទន្សាយបោកយាយ។	うさぎ＋だます＋おばあさん＝うさぎがおばあさんをだます。	null	トンサーイ・バオク・ジアイ　tʷɔ̀ｎsaːi baok yiˑəi	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
232	យាយបោកទន្សាយ។	おばあさん＋だます＋うさぎ＝おばあさんがうさぎをだます。	null	ジアイ・バオク・トンサーイ　yiˑəi baok tʷɔ̀ｎsaːi	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
233	ទន្សាយស៊ីចេក។​	うさぎ＋食う＋バナナ＝うさぎがバナナを食う。	null	トンサーイ・シー・チェーク　tʷɔ̀ｎsaːi siː ceːk	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
234	ចេកស៊ីទន្សាយ។​	バナナ＋食う＋うさぎ＝バナナがうさぎを食う。	null	チェーク・シー・トンサーイ　ceːk siː tʷɔ̀ｎsaːi	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
235	យាយជេរទន្សាយ។	おばあさん＋ののしる＋うさぎ＝おばあさんがうさぎをののしる。	null	ジアイ・チェー・トンサーイ　yiˑəi cèː tʷɔ̀ｎsaːi	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
236	ទន្សាយជេរយាយ។	うさぎ＋ののしる＋おばあさん＝うさぎがおばあさんをののしる。	null	トンサーイ・チェー・ジアイ　tʷɔ̀ｎsaːi cèː yiˑəi	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
237	ស៊ីចេក។	食う＋バナナ＝バナナを食う。	null	シー・チェーク　siː ceːk	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
240	បោកយាយខ្លាំង។	だます＋おばあさん＋ひどく＝おばあさんをひどくだます。	null	バオク・ジアイ・クラン　baok yiˑəi kʰlaŋ	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
241	ស៊ីចេកលឿន។	食う＋バナナ＋すばやく＝すばやくバナナを食う。	null	シー・チェーク・ルアン　siː ceːk lɯˑən	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
242	ទៅស្រុកជប៉ុន។	行く＋日本＝日本に行く。	null	タウ・スロック・チャポン　tə̀w srok capon	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
243	នឹកផ្ទះ។	恋しい＋家＝家が恋しい。	null	ヌック・プテアハ　nɯk pʰtɛ̀əh	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
244	វាយខ្លា។	殴る＋虎＝虎を（棒で）殴る。	null	ヴィアイ・クラー　viˑəi kʰlaː	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
245	វាយដំបង។	殴る＋棒＝（虎を）棒で殴る。	null	ヴィアイ・ドンボーン　viˑəi dɔmbɔːŋ	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
246	វាយខ្លាដោយដំបង។	殴る＋虎＋で＋棒＝虎を棒で殴る。	null	ヴィアイ・クラー・ダオイ・ドンボーン　viˑəi kʰlaː　daoi dɔmbɔːŋ	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
247	វាយដោយដំបង។	殴る＋で＋棒＝（虎を）棒で殴る。	null	ヴィアイ・ダオイ・ドンボーン　viˑəi daoi dɔmbɔːŋ	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
248	បង្រៀនភាសាខ្មែរខ្ញុំ។	教える＋語＋カンボジア＋私＝カンボジア語を私に教える。	null	ボンリアン・ピアサー・クマエ・クニョム　bɔŋriˑən pʰiˑəsaː kʰmae kʰɲom	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
249	ឲ្យចេកទន្សាយ។	与える＋バナナ＋うさぎ＝バナナをうさぎに与える。	null	アオイ・チェーク・トンサーイ　ʔaoi ceːk tʷɔ̀nsaːi	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
250	ទន្សាយឆ្លាត	うさぎ＋賢い＝賢いうさぎ	null	トンサーイ・チラート　tʷɔ̀nsaːi cʰlaːt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
251	ខ្លាល្ងង់	虎＋間抜けな＝間抜けな虎	null	クラー・ルゴン　kʰlaː lŋʷɔ̀ŋ	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
252	ម្ហូបឆ្ងាញ់	料理＋おいしい＝おいしい料理	null	ムホープ・チガニュ　mhoːp cʰŋaɲ	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
253	ម្ហូបខ្មែរ	料理＋カンボジア＝カンボジア料理	null	ムホープ・クマエ　mhoːp kʰmae	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
254	ទន្សាយដែលនៅក្នុងរឿងព្រេងខ្មែរ	うさぎ＋カンボジアの民話に出てくる＝カンボジアの民話に出てくるうさぎ	null	トンサーイ・ダエル・ナウ・クノン・ルアン・プレーン・クマエ　tʷɔ̀nsaːi dael nə̀w knoŋ rɯˑəŋ prèːŋ kʰmae 	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
255	ត្រីដែលខ្ញុំស្ទូចពីម្សិលមិញ	魚＋私が昨日釣った＝私が昨日釣った魚	null	トライ・ダエル・クニョム・ストゥーイ・ピー・ムサルマニュ　ｔｒəi dael kʰɲom stuːc piː msəlməɲ	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
256	មកយឺត។	来る＋遅い＝遅く来る。	null	モーク・ユート　mɔ̀ːk yɯːt	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
257	ញ៉ាំច្រើន។​​​	食べる＋たくさん＝たくさん食べる。	null	ニャム・チラウン　ɲam craəｎ	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
258	ចង់ស៊ី។	たい＋食う＝食いたい。	null	チョン・シー　cɔŋ siː	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
259	មិនទៅ។	ない＋行く＝行かない。	null	ムン・タウ　mɯn tə̀ｗ	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
260	អំពីទន្សាយ	～について＋うさぎ＝うさぎについて（話す）。	null	オンピー・トンサーイ　ʔɔmpiː tʷɔ̀nsaːi	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
261	ជាងនេះ	～より＋これ＝これより（おいしい）。	null	チアン・ニヒ　ciˑəŋ nih	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
262	ស្រុកខ្មែរ	国＋カンボジア＝カンボジア国	null	スロック・クマエ　srok kʰmae	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
263	ផ្ទះខ្ញុំ	家＋私＝私の家	null	プテアハ・クニョム　ptɛ̀əh kʰɲom	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
264	ភាសាជប៉ុន	言語＋日本＝日本語	null	ピアサー・チャポン　pʰiˑəsaː capon	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
265	ទឹកភ្នែក	水＋目＝涙	null	トゥック・プネーク　tɯk pʰnɛ̀ːk	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
266	ទឹកដោះគោ	水＋乳＋牛＝牛乳	null	トゥック・ドホ・コー　ｔɯk dɔh kòː	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
267	ប្រាជ្ញារបស់ទន្សាយ	知恵＋の＋うさぎ＝うさぎの知恵	null	プラチニャー・ロボホ・トンサーイ　pracɲaː rɔ̀bɔh tʷɔ̀nsaːi	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
268	ផ្ទះរបស់ខ្ញុំ	家＋の＋私＝私の家	null	プテアハ・ロボホ・クニョム　ptɛ̀əh rɔ̀bɔh kʰɲom	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
746	ហេតុអី?	どうしてですか。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
271	ត្រីធំ	魚＋大きい＝大きい魚	null	トライ・トム　trəi tʰom	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
272	ឆ្កែខ្មៅ	犬＋黒い＝黒い犬	null	チカエ・クマウ　cʰkae kʰmaw	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
273	របស់ខ្ញុំ	の＋私＝私の	null	ロボホ・クニョム　rɔ̀bɔh kʰɲom	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
274	អាធំ	の＋大きい＝大きいの	null	アー・トム　ʔaː tʰom	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
275	អាខ្មៅ	の＋黒い＝黒いの	null	アー・クマウ　ʔaː kʰmaw	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
276	ត្រីអាំង	魚＋焼く＝焼き魚	null	トライ・アン　trəi ʔaŋ	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
277	ផ្កាស្រពោន	花＋しおれた＝しおれた花	null	プカー・スロポーン　pʰkaː srɔpòːn	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
278	ថ្មបាក់	石＋崩れた＝崩れた石（危ない橋）	null	トゥモー・バック　tʰmɔː bak	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
279	ត្រីខ្ញុំអាំង	魚＋私＋焼く＝私が焼いた魚	null	トライ・クニョム・アン　trəi kʰɲom ʔaŋ	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
280	ត្រីដែលខ្ញុំអាំង	魚＋サイン＋私＋焼く＝私が焼いた魚	null	トライ・ダエル・クニョム・アン　trəi dael kʰɲom ʔaŋ	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
281	ឆ្កែអណ្ដាតពាំព្រីង	犬＋舌＋くわえる＋プリン＝プリンの実をくわえた舌の（紫の斑点のある）犬	null	チカエ・オンダート・ポアム・プリーン　cʰkae ʔɔndaːt pɔəm　priːŋ	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
282	ឆ្មានេះ	猫＋これ＝この猫	null	チマー・ニヒ　cʰmaː nih	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
283	ខ្លានោះ	虎＋それ＝その虎	null	クラー・ヌフ　kʰlaː nuh	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
284	ទិញនេះ	買う＋これ＝これを買う。	null	テニュ・ニヒ　teɲ nih	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
285	ទិញអាវនេះ	買う＋シャツ＋これ＝このシャツを買う。	null	テニュ・アーウ・ニヒ　teɲ ʔaːw nih	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
286	ចេកនិងស្វា	バナナ＋と＋猿＝バナナと猿	null	チェーク・ヌン・スヴァー　ceːk nɯŋ svaː	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
287	ស្រមោចនិងស្ករ	アリ＋と＋砂糖＝アリと砂糖	null	スロマオイ・ヌン・スコー　srɔmaoc nɯŋ skɔː	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
288	សៀវភៅនេះនិងសៀភៅនោះ	本＋これ＋と＋本＋それ＝この本とその本	null	シアウパウ・ニヒ・ヌン・シアウパウ・ヌフ　siˑəwpʰə̀w nih nɯŋ siˑəwpʰə̀w nuh 	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
289	ចាបស្រុកនិងចាបព្រៃ	雀＋里＋と＋雀＋森＝里雀と野生の雀	null	チャープ・スロック・ヌン・チャープ・プレイ　caːｐ srok nɯŋ caːｐ prèi	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
290	គោ ក្របី ជ្រូកនិងមាន់	牛＋水牛＋豚＋と＋鶏＝牛と水牛と豚と鶏	null	コー・クロバイ・チルーク・ヌン・モアン　kòː krɔｂəi cruːk nɯŋ mɔən	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
291	ទន្សាយដែលចង់ស៊ីចេក	うさぎ＋サイン＋バナナを食いたい＝バナナを食いたいうさぎ	null	トンサーイ・ダエル・チョン・シー・チェーク　ｔʷɔ̀nsaːi dael cɔŋ siː ceːk	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
292	យាយដែលចាញ់បោកទន្សាយ	老婆＋サイン＋うさぎにだまされた＝うさぎにだまされたおばあさん	null	ジアイ・ダエル・チャニュ・バオク・トンサーイ　yiˑəi dael caɲ baok ｔʷɔ̀nsaːi 	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
293	ទន្សាយចង់ស៊ីចេក	うさぎ＋バナナを食いたい＝バナナを食いたいうさぎ	null	トンサーイ・チョン・シー・チェーク　ｔʷɔ̀nsaːi cɔŋ siː ceːk	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
294	ដែលស៊ីចេក	サイン＋バナナを食う＝バナナを食ったの（はあいつだ）。	null	ダエル・シー・チェーク　dael siː ceːk	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
295	អ្នកខ្លះ	人＋いくつかの＝人によっては～	null	ネアック・クラハ　nɛ̀ək kʰlah	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
296	ស្រីៗ	女＋女（繰り返し記号）＝女たち	null	スライ・スライ　srəi srəi	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
297	ត្រីច្រើនៗ	魚＋たくさん＋繰り返し記号＝いろいろな種類のたくさんの魚	null	トライ・チラウン・チラウン　trəi craən craəｎ	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
298	ក្របីជម្រាបសួរទន្សាយ ទន្សាយក៏ជម្រាបសួរវិញ។	水牛＋挨拶する＋うさぎ　繰り返し記号＋も＋挨拶する＋戻す＝水牛はうさぎに挨拶し、うさぎも挨拶を返した。	null	クロバイ・チョムリアプ・スオ・トンサーイ・トンサーイ・コー・チョムリアプ・スオ・ヴニュ　krɔbəi cʊｍriˑəp suˑo tʷɔ̀nsaːi tʷɔ̀nsaːi kɔː cʊｍriˑəp suˑo vɯŋ 	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
299	មកយឺត។	来る＋遅く＝遅れて来た。	null	モーク・ユート　mɔ̀ːk yɯːt	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
300	មកពីម្សិលមិញ។	来る＋昨日＝昨日来た。	null	モーク・ピー・ムサルマニュ　mɔ̀ːk piː msəlməɲ	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
301	មកបីដង។	来る＋３回＝３回来た。	null	モーク・バイ・ドーン　mɔ̀ːk bəi dɔːŋ 	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
302	ក្ដៅខ្លួន។	暑い＋身体＝熱がある。	null	クダウ・クルオン　kdaw kluˑon	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
303	ពូកែធ្វើការ។	上手な＋働く＝仕事ができる。	null	プーカエ・トゥヴー・カー　puːkae tʰvə̀ː kaː	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
304	ទន្សាយត្រចៀកវែង។	うさぎ＋耳＋長い＝うさぎは耳が長い。	null	トンサーイ・トロチアク・ヴェーン　tʷɔ̀nsaːi trɔciˑək vɛ̀ːŋ	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
305	ឡើងឆ្ងាញ់។	なる＋おいしい＝おいしくなる。（前はまずかった。）	null	ラウン・チガニュ　laəŋ cʰŋaɲ	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
306	ឆ្ងាញ់ឡើង។	おいしい＋なる＝ますますおいしくなる。（前もおいしかったが、おいしさの程度が増した。）	null	チガニュ・ラウン　cʰŋaɲ laəŋ 	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
307	ឆ្ងាញ់ឡើងៗ។	おいしい＋なる＋繰り返し記号＝ますますおいしくなる。	null	チガニュ・ラウン・チガニュ・ラウン　cʰŋaɲ laəŋ cʰŋaɲ laəŋ	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
308	កាន់តែឆ្ងាញ់ឡើង។	ますます＋おいしい＋なる＝ますますおいしくなる。	null	カン・タエ・チガニュ・ラウン　kan tae cʰŋaɲ laəŋ	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
309	មិនរៀន។	～ない＋学ぶ＝勉強しない。	null	ムン・リアン　mɯn riˑən	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
310	អត់ល្អ។	～ない＋よい＝よくない。	null	オット・ルオー　ʔɔｔ　ｌʔɔː	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
311	មិនទៅទេ។	～ない＋行く＋よ＝（行くと思っているだろうけど）行かないよ！	null	ムン・タウ・テー　mɯn tə̀w tèː	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
312	មិនរៀនសោះ។	～ない＋学ぶ＋全く＝全く勉強しない。	null	ムン・リアン・ソホ　mɯn riˑən sɔh	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
313	មិនសូវល្អ។	～ない＋あまり＋よい＝あまりよくない。	null	ムン・サウ・ルオー　mɯn səw lʔɔː	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
314	មើលខ្លា។	見る＋虎＝虎を見る。	null	ムール・クラー　mə̀ːl kʰlaː	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
315	ឃើញខ្លា។	見える＋虎＝虎が見える。	null	クーニュ・クラー　kʰə̀ːɲ kʰlaː	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
316	ខ្លាមើល។	虎＋見る＝虎が（何かを）見る。	null	クラー・ムール　kʰlaː mə̀ːl 	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
317	ខ្លាឃើញ។	虎＋見える＝虎には（何かが）見える。	null	クラー・クーニュ　kʰlaː kʰə̀ːɲ 	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
318	ស្ដាប់ចម្រៀង។	聞く＋歌＝歌を聞く。	null	スダップ・チョムリアン　sdap cɔmriˑəŋ	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
319	ឮចម្រៀង។	聞こえる＋歌＝歌が聞こえる。	null	ルー・チョムリアン　lɯː cɔmriˑəŋ	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
320	អាំងត្រីញ៉ាំ។	焼く＋魚＋食べる（＋魚）＝魚を焼いて（魚を）食べる。	null	アン・トライ・ニャム　ʔaŋ trəi ɲam	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
321	ទៅរៀន។	行く＋学ぶ＝勉強しに行く。（学校に行く。）	null	タウ・リアン　ｔə̀w riˑən	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
322	មើលឃើញ។	見る＋見える＝（見ようとして）見えた。	null	ムール・クーニュ　mə̀ːl kʰə̀ːɲ	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
323	រកមិនឃើញ។	探す＋～ない＋見える＝探しても見つからない。	null	ローク・ムン・クーニュ　rɔ̀ːk mɯn kʰə̀ːɲ	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
324	មិនយកទៅ។	～ない＋持つ＋行く＝持って行かない。	null	ムン・ヨーク・タウ　mɯn yɔ̀ːk tə̀w	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
325	ខ្ញុំញ៉ាំនំ។	私＋食べる＋菓子＝私が菓子を食べる。私は（何をするかというと）菓子を食べる。（カンボジア語では、この２文の区別はできません。）	null	クニョム・ニャム・ノム　kʰɲom ɲam nʊm	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
326	នំខ្ញុំញ៉ាំ	菓子＋私＋食べる＝菓子は（菓子について言えば）私が食べる。	null	ノム・クニョム・ニャム　nʊm kʰɲom ɲam 	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
327	គាត់ខ្នងវែង។	彼＋背中＋長い＝彼は怠け者だ。	null	コアット・クノーン・ヴェーン　kɔət kʰnɔːŋ vɛ̀ːŋ	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
328	គាត់ថ្លើមខ្មៅ។	彼＋肝＋黒い＝彼は意地悪だ。	null	コアット・トラウム・クマウ　kɔət tʰlaəm kʰmaw	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
329	ស្អែកទៅស្រុកខ្មែរ។	明日＋行く＋国＋カンボジア＝明日はカンボジアに行く。	null	スアエク・タウ・スロック・クマエ　sʔaek tə̀w srok kʰmae	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
330	ទៅ​(ស្រុកខ្មែរ)ស្អែក។	行く＋（国＋カンボジア＋）明日＝明日（カンボジアに）行く。	null	タウ（・スロック・クマエ）・スアエク　tə̀w(srok kʰmae) sʔaek	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
331	បីថ្ងៃទៀត ទៅ​ស្រុកខ្មែរ។	３日＋あと＋行く＋カンボジア国＝あと３日でカンボジアに行く。（「３日」の言い方は後のステップで説明します。）	null	バイ・トゥガイ・ティアット・タウ・スロック・クマエ　bəi tʰŋai tiˑət tə̀w srok kʰmae	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
332	នៅ​ស្រុកខ្មែរបីថ្ងៃទៀត។	いる＋カンボジア国＋３日＋あと＝あと３日カンボジアにいる。	null	ナウ・スロック・クマエ・バイ・トゥガイ・ティアット　nə̀w srok kʰmae bəi tʰŋai tiˑət 	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
333	ញ៉ាំឬទេ?	食べる＋か否か＝食べますか、食べませんか。	null	ニャム・ルー・テー　ɲam rɯː tèː	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
334	ញ៉ាំទេ?	食べる＋否か＝食べませんか、食べますよね。	null	ニャム・テー　ɲam tèː	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
335	ញ៉ាំឬ?	食べる＋か＝食べますか、食べるのですか。	null	ニャム・ルー　ɲam rɯː	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
336	បាទ / ចាស  ញ៉ាំ។	はい＋食べる＝はい、食べます。	null	バート／チャー・ニャム　baːt / caːh ɲam	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
337	ទេ មិនញ៉ាំ។	いいえ＋～ない＋食べる＝いいえ、食べません。	null	テー・ムン・ニャム　tèː mɯn ɲam	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
338	ញ៉ាំនំ។	食べる＋菓子＝菓子を食べる。	null	ニャム・ノム　ɲam nʊm	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
339	ញ៉ាំអី?	食べる＋何＝何を食べますか。	null	ニャム・アイ　ɲam ʔəi	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
340	ញ៉ាំប៉ុន្មាន?	食べる＋いくつ＝いくつ食べますか。	null	ニャム・ポンマーン　ɲam ponmaːn	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
341	ទៅ(កន្លែង)ណា?	行く＋どこ＝どこへ行きますか。	null	タウ（・コンラエン）・ナー　tə̀w (kɔnlaeŋ) naː	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
342	ទៅពេលណា?	行く＋いつ＝いつ行きますか。	null	タウ・ペール・ナー　tə̀w pèːl naː	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
343	អ្នកណាទៅ?	誰＋行く＝誰が行きますか。	null	ネアック・ナー・タウ　nɛ̀ək naː tə̀w	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
344	មិនញ៉ាំឬ?	～ない＋食べる＋か＝食べないのですか。	null	ムン・ニャム・ルー　mɯn ɲam rɯː	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
345	ចុះអ្នកវិញ?	では＋あなた＋戻る＝（お元気ですか。）では、あなたは。	null	チョホ・ネアック・ヴニュ　coh nɛ̀ək vəɲ	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
346	ចុះស្វាយនេះវិញ?	では＋マンゴー＋これ＋戻る＝（このみかんはいくらですか。）では、このマンゴーは。	null	チョホ・スヴァーイ・ニヒ・ヴニュ　coh svaːi nih vəɲ	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
347	នេះផ្ទះខ្ញុំ។	これ＋家＋私＝これは私の家です。	null	ニヒ・プテアハ・クニョム　nih pʰtɛ̀əh kʰɲom	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
348	នេះមិនមែនផ្ទះគាត់។	これ＋～ない＋本当に＋家＋彼＝これは彼の家ではありません。	null	ニヒ・ムン・メーン・プテアハ・コアット　nih mɯn mɛ̀ːn pʰtɛ̀əh kɔət	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
349	នេះផ្ទះគាត់ឬ?	これ＋家＋彼＋か＝これは彼の家ですか。	null	ニヒ・プテアハ・コアット・ルー　nih pʰtɛ̀əh kɔət rɯː	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
350	មិនញ៉ាំ។	～ない＋食べる＝食べない。（食べる意志はない。）	null	ムン・ニャム　mɯn ɲam	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
351	មិនមែនញ៉ាំ។	～ない＋本当に＋食べる＝食べるのではない。（捨てるのだ。）	null	ムン・メーン・ニャム　mɯn mɛ̀ːn ɲam	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
352	មិនមែនខ្ញុំញ៉ាំ។	～ない＋本当に＋私＋食べる＝私が食べるのではない。（妹が食べるのだ。）	null	ムン・メーン・クニョム・ニャム　mɯn mɛ̀ːn kʰɲom ɲam	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
353	ញ៉ាំអីបន្តិច។	食べる＋何＋ちょっと＝ちょっと何か食べる。	null	ニャム・アイ・ボンタイ　ɲam ʔəi bɔntəc	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
354	ញ៉ាំអីឬ?	食べる＋何＋か＝何か食べますか。	null	ニャム・アイ・ルー　ɲam ʔəi rɯː	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
355	ញ៉ាំអី?	食べる＋何＝何を食べますか。	null	ニャム・アイ　ɲam ʔəi 	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
356	ទៅកន្លែងណា?	行く＋どこ＝どこへ行きますか。	null	タウ・コンラエン・ナー　tə̀w kɔnlaeŋ naː	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
357	ទៅកន្លែងណាឬ?	行く＋どこ＋か＝どこかへ行きますか。	null	タウ・コンラエン・ナー・ルー　tə̀w kɔnlaeŋ naː rɯː	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
358	ពេលណាក៏បាន។	いつ＋も＋いい＝いつでもいい。	null	ペール・ナー・コー・バーン　pèːl naː kɔː baːn	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
359	ទៅពេលណាក៏បាន។	行く＋いつ＋も＋いい＝いつ行ってもいい。	null	タウ・ペール・ナー・コー・バーン　tə̀w pèːl naː kɔː baːn	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
360	ខ្ញុំ  យើង  លោក  លោកស្រី  គាត់  គេ  វា	私、私たち、あなた（男性）、あなた（女性）、彼（女）、彼（ら）、やつ・それ	null	クニョム、ジューン、ローク、ローク・スライ、コアット、ケー、ヴィア　kʰɲom,　yə̀ːŋ,　lòːk,　lòːk srəi,　kɔət,　kèː,　viˑə	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
361	កូនខ្ញុំវា	子＋私＋やつ＝私の子、あの子は～	null	コーン・クニョム・ヴィア　koːn kʰɲom viˑə	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
362	ជីតា  ជីដូន  (យាយ)  ឪពុក  ម្ដាយ	祖父、祖母、父、母	null	チー・ター、チー・ドーン／ジアイ、アウプック、ムダーイ　ciːtaː,　ciːdoːŋ(yiˑəi),　ʔəwpʊk,　mdaːi	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
363	អ៊ំប្រុស  អ៊ំស្រី  ពូ  មីង	伯父・母（親より年上）、叔父（親より年下）、叔母（親より年下）	null	オム（プロホ／スライ）、プー、ミーン　ʔom (proh / srəi),　puː,　miːŋ	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
364	បងប្រុស  បងស្រី  ប្អូនប្រុស  ប្អូនស្រី	兄・姉、弟・妹、子、孫、甥・姪	null	ボーン（プロホ／スライ）、プオーン（プロホ／スライ）　 bɔːŋ(proh / srəi),　pʔoːn (proh / srəi)	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
365	កូនប្រុស  កូនស្រី  ចៅប្រុស  ចៅស្រី  ក្មួយប្រុស  ក្មួយស្រី	兄・姉、弟・妹、子、孫、甥・姪	null	コーン（プロホ／スライ）、チャウ（プロホ／スライ）、クムオイ（プロホ／スライ）　koːn(proh / srəi),　caw(proh / srəi),　kmuˑoi(proh / srəi)	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
366	ជម្រាបសួរ។	告げる＋尋ねる＝はじめまして、こんにちは。（会ったときの挨拶）	null	チョムリアップ・スオ　cʊmriˑəp suˑo	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
367	ខ្ញុំឈ្មោះ   ～   ។	私＋名前＋～＝名前は～です。	null	クニョム・チモホ・～　kʰɲom cʰmʷɔ̀h	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
368	ខ្ញុំអាយុ   ～    ឆ្នាំ។	私＋年齢＋～＋歳＝年齢は～歳です。	null	クニョム・アーユ・～・チナム　kʰɲom ʔaːyuʔ ～ cʰnam	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
369	ជម្រាបលា។	告げる＋別れる＝さようなら。	null	チョムリアップ・リア　cʊmriˑəp liˑə	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
371	មិនអីទេ។	～ない＋何＋よ＝どういたしまして。	null	ムン・アイ・テー　mɯn ʔəi tèː	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
372	សូមទោស។	請う＋罪＝すみません。	null	ソーム・トーホ　soːm tòːh	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
373	ទៅ!	行く＝行け。	null	タウ　tə̀w	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
374	កុំទៅ!	～するな＋行く＝行くな。	null	コム・タウ　kom tə̀w	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
375	ហាមជក់បារី។	禁じる＋吸う＋タバコ＝禁煙。	null	ハーム・チュオック・バライ　haːm cʷɔ̀k baːrəi	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
376	សូមញ៉ាំ។	お願い＋食べる＝食べてください。	null	ソーム・ニャム　soːm ɲam	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
377	សូមកុំញ៉ាំ។	お願い＋禁止＋食べる＝食べないでください。 	null	ソーム・コム・ニャム　soːm kom ɲam	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
378	អញ្ជើញ។	どうぞ＝どうぞ。	null	オンチューニュ　ʔɔɲcə̀ːɲ	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
379	មានភ្នំ។	ある＋山＝山がある。	null	ミアン・プノム　miˑən pʰnʊm	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
380	អត់មានមនុស្ស។	～ない＋ある＋人＝人がいない。	null	オット・ミアン・モヌフ　ʔɔt miˑən mɔ̀nuh	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
381	មានស្វាយឬ?	ある＋マンゴー＋か＝マンゴーはありますか。	null	ミアン・スヴァーイ・ルー　miˑən svaːi rɯː	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
383	សៀវភៅនៅសាលា។	本＋ある＋学校＝本は学校にある。	null	シアウパウ・ナウ・サラー　siˑəwpʰə̀w nə̀w saːlaː	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
384	ម្ដាយអត់នៅផ្ទះ។	母＋～ない＋ある＋家＝母は家にいない。	null	ムダーイ・オット・ナウ・プテアハ　mdaːi ʔɔt nə̀w pʰtɛ̀əh	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
385	មានខ្លានៅព្រៃនោះ។	ある＋虎＋ある＋森＋それ＝その森に虎がいる。	null	ミアン・クラー・ナウ・プレイ・ヌフ　miˑən kʰlaː nə̀w prèi nuh	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
386	មានមីននៅជិតនេះឬ?	ある＋地雷＋に＋近い＋これ＋か＝この近くに地雷がありますか。	null	ミアン・ミーン・ナウ・チュット・ニヒ・ルー　miˑən miːn nə̀w cɯt nih rɯː 	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
387	ញ៉ាំថ្ងៃនេះ។	食べる＋今日＝今日食べる。	null	ニャム・トゥガイ・ニヒ　ɲam tʰŋai nih	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
388	ញ៉ាំពីម្សិលមិញ។	食べる＋昨日＝昨日食べた。	null	ニャム・ピー・ムサル・マニュ　ɲam piː msəl məɲ	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
389	ញ៉ាំហើយ។	食べる＋た＝もう食べた。	null	ニャム・ハウイ　ɲam haəi	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
390	ញ៉ាំហើយឬនៅ?	食べる＋た＋か＋まだ＝もう食べましたか。	null	ニャム・ハウイ・ルー・ナウ　ɲam haəi rɯː nə̀w	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
391	មិនទាន់ញ៉ាំ។	～ない＋間に合う＋食べる＝まだ食べていません。	null	ムン・トアン・ニャム　mɯn tɔən ɲam	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
392	ទៅស្អែក។	行く＋明日＝明日行く。	null	タウ・スアエク　tə̀w sʔaek	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
393	នឹងទៅស្អែក។	つもり＋行く＋明日＝明日行くつもりだ。	null	ヌン・タウ・スアエク　nɯŋ tə̀w sʔaek	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
394	នឹងទៅតែមិនបានទៅ។	つもり＋行く＋しかし＋～ない＋できる＋行く＝行くつもりだったが、行けなかった。	null	ヌン・タウ・タエ・ムン・バーン・タウ　nɯŋ tə̀w tae mɯn baːn tə̀w	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
395	កំពុងរៀនភាសាខ្មែរ។	ている＋学ぶ＋語＋カンボジア＝今まさにカンボジア語を勉強している。（今のあなたの状態ですね。）	null	コンポン・リアン・ピアサー・クマエ　kɔmpʊŋ riˑən pʰiˑəsaː kʰmae	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
396	មើលទៅគាត់មនុស្សល្អ។	見る＋行く＋彼＋人＋良い＝彼はいい人みたいだね。	null	ムール・タウ・コアット・モヌフ・ルオー　mə̀ːl tə̀w kɔət mɔ̀nuh lʔɔː	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
397	ឲ្យគាត់រៀនភាសាខ្មែរ។	与える＋彼＋学ぶ＋語＋カンボジア＝彼にカンボジア語を勉強させる。	null	アオイ・コアット・リアン・ピアサー・クマエ　ʔaoi kɔət riˑən pʰiˑəsaː kʰmae	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
398	ឲ្យកូនញ៉ាំបាយ។	与える＋子＋食べる＋ご飯＝子どもにご飯を食べさせる。	null	アオイ・コーン・ニャム・バーイ　ʔaoi koːn ɲam baːi	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
399	បង្ខំគាត់ឲ្យទៅ។	強制する＋彼＋させる＋行く＝彼に命じて（彼あるいは別の人に）行かせる。	null	ボンコム・コアット・アオイ・タウ　bɔŋkʰɔm kɔət ʔaoi tə̀w	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
400	បង្ខំឲ្យគាត់ទៅ។	強制する＋させる＋彼＋行く＝（彼あるいは別の人に）強制して彼に行かせる。	null	ボンコム・アオイ・コアット・タウ　bɔŋkʰɔm ʔaoi kɔət tə̀w	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
401	បង្ខំគាត់ឲ្យកូនគាត់ទៅ។	強制する＋彼＋させる＋子＋彼＋行く＝彼に強制して、彼の子どもに行かせる。	null	ボンコム・コアット・アオイ・コーン・コアット・タウ　bɔŋkʰɔm kɔət ʔaoi koːn kɔət tə̀w	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
402	ខ្ញុំធ្វើឲ្យគាត់ពិបាក។	私＋作る＋させる＋彼＋困難な＝彼を困らせる。	null	クニョム・トゥヴー・アオイ・コアット・ピバーク　kʰɲom tʰvə̀ː ʔaoi kɔ̀ət piʔbaːk	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
403	គាត់និយាយដូច្នេះ នាំឲ្យខ្ញុំខឹង។	彼＋話す＋そのよう＋連れる＋させる＋私＋怒る＝彼がそのように言ったことが、私を怒らせた。	null	コアット・ニジアイ・ドーチネヘ・ノアム・アオイ・クニョム・カン　kɔ̀ət niːyiˑəi doːcneh nɔəm ʔaoi kʰɲom kʰəŋ	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
404	ខ្ញុំត្រូវចោរលួចកាបូបលុយ។	私＋受ける＋泥棒＋盗む＋かばん＋金＝私は泥棒に財布を盗まれた。	null	クニョム・トラウ・チャオ・ルオイ・カボープ・ルイ　kʰɲom trəw cao luˑoc kaboːp lʊi	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
405	ចោរលួចកាបូបលុយខ្ញុំ។	泥棒＋盗む＋財布＋私の＝泥棒に財布を盗まれた。（泥棒が私の財布を盗んだ。）	null	チャオ・ルオイ・カボープ・ルイ・クニョム　cao luˑoc kaboːp lʊi kʰɲom	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
406	គេនិយាយថា   ។	彼ら＋言う＋～と＝～と言われている。（みんなが～と言っている。）	null	ケー・ニジアイ・ター・～　kèː niːyiˑəi tʰaː	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
817	ក្រាល	敷く	null	kraːl	\N	pmod	page007.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	\N	\N	\N
407	នេះឆ្ងាញ់ជាងនោះ។	これ＋おいしい＋より＋それ＝これはそれよりおいしい。	null	ニヒ・チガニュ・チアン・ヌフ　nih cʰŋaɲ ciˑəŋ nuh	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
408	នេះឆ្ងាញ់ជាង។	これ＋おいしい＋より＝これの方がおいしい。	null	ニヒ・チガニュ・チアン　nih cʰŋaɲ ciˑəŋ	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
409	នេះឆ្ងាញ់ជាងគេ។	これ＋おいしい＋より＋他＝これは最もおいしい。	null	ニヒ・チガニュ・チアン・ケー　nih cʰŋaɲ ciˑəŋ kèː	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
410	នេះឆ្ងាញ់ដូចនោះ។	これ＋おいしい＋同じ＋それ＝これはそれと同じくらいおいしい。	null	ニヒ・チガニュ・ドーイ・ヌフ　nih cʰŋaɲ doːc nuh	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
411	នេះធំប៉ុននោះ។	これ＋大きい＋サイズが同じ＋それ＝これはそれと同じくらい大きい。	null	ニヒ・トム・ポン・ヌフ　nih tʰom pon nuh	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
412	ទៅបាន។	行く＋得る＝行ける。（行ってもいい。）	null	タウ・バーン　tə̀w baːn	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
413	ទៅមិនបាន។	行く＋～ない＋得る＝行けない。	null	タウ・ムン・バーン　tə̀w mɯn baːn	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
414	ចេះនិយាយភាសាខ្មែរទេ?	知る＋話す＋語＋カンボジア＋か＝カンボジア語を話せますか。	null	チェヘ・ニジアイ・ピアサー・クマエ・テー　ceh niːyiˑəi pʰiˑəsaː kʰmae tèː	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
415	ដែលទៅស្រុកខ្មែរ។	～したことがある＋行く＋国＋カンボジア＝カンボジアに行ったことがある。	null	ダエル・タウ・スロック・クマエ　dael tə̀w srok kʰmae	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
416	មិនដែលរៀនភាសាខ្មែរ។	～ない＋～したことがある＋学ぶ＋言語＋カンボジア＝カンボジア語を習ったことがない。	null	ムン・ダエル・リアン・ピアサー・クマエ　mɯn dael riˑən pʰiˑəsaː kʰmae	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
417	សរសេរទុក។	書く＋置く＝書いておく。	null	ソセー・トック　sɔseːtʊk 	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
418	សរសេរមើល។	書く＋見る＝書いてみる。	null	ソセー・ムール　sɔseːmə̀ːl	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
420	ស្រីពីរនាក់	女＋２＋人＝２人の女性	null	スライ・ピー・ネアック　srəi piː nɛ̀ək 	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
421	សៀវភៅមួយ	本＋１＝本１冊	null	シアウパウ・ムオイ　siˑəwpʰə̀w muˑoi	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
422	ថ្ងៃសៅរ៍ទីមួយ ខែតុលា ឆ្នាំពីរពាន់ប្រាំ	日＋土曜＋第＋１＋月＋１０月の名＋年＋２００５＝２００５年１０月１日土曜日	null	トゥガイ・サウ・ティー・ムオイ・カエ・トラー・チナム・ピー・ポアン・プラム　tʰŋai saw tiː muˑoi kʰae tolaː cʰnam piː pɔən pram	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
423	ម៉ោងប្រាំ	時間＋５＝５時	null	マオン・プラム　maoŋ pram	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
424	នេះធ្វើអំពីឈើ។	これ＋作る＋で＋木＝これは木でできている。	null	ニヒ・トゥヴー・オンピー・チュー　nih tʰvə̀ː ʔɔmpiː cʰə̀ː	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
425	ខ្ញុំមកពីស្រុកជប៉ុន។	私＋来る＋から＋国＋日本＝私は日本から来ました。	null	クニョム・モーク・ピー・スロック・チャポン　kʰɲom mɔ̀ːk piː srok capon	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
426	គាត់រៀនតាំងពីម៉ោងមួយរហូតដល់ម៉ោងបី។	彼＋学ぶ＋から＋時間＋１＋ずっと＋まで＋時間＋３＝彼は１時から３時まで勉強する。	null	コアット・リアン・タンピー・マオン・ムオイ・ロホート・ドル・マオン・バイ　kɔət riˑən taŋ piː maoŋ muˑoi rɔ̀hoːt dɔl maoŋ bəi	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
427	វាយដោយដំបង។	叩く＋で＋棒＝棒で殴る。	null	ヴィアイ・ダオイ・ドンボーン　viˑəi daoi dɔmbɔːŋ	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
428	រៀនតាមសៀវភៅនេះ។	学ぶ＋沿って＋本＋これ＝この本で学ぶ。	null	リアン・ターム・シアウパウ・ニヒ　riˑən taːm siˑəwpʰə̀w nih	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
429	គាត់ប្រាប់ខ្ញុំថាទៅ។	彼＋告げる＋私＋～と＋行く＝彼は私に行くと言った。	null	コアット・プラップ・クニョム・ター・タウ　kɔət prap kʰɲom tʰaː tə̀w	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
430	គាត់ទៅជាមួយបងប្រុសគាត់។	彼＋行く＋一緒に＋兄姉＋男＋彼＝彼は兄と一緒に行った。	null	コアット・タウ・チアムオイ・ボーン・プロホ・コアト　kɔət tə̀w ciˑə muˑoi bɔːŋ proh kɔət	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
431	ទៅណាដែរ?	行く＋どこ＋か＝どちらへおでかけですか。	null	タウ・ナー・ダエ　tə̀w naː dae	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
432	អត់ដឹងផង។	～ない＋知る＋よ＝知らないよ！	null	オット・ダン・ポーン　ʔɔt dəŋ pʰɔːŋ	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
433	មកលេងទៀតណ៎ា។	来る＋遊ぶ＋また＋ね＝また遊びに来てね。	null	モーク・レーン・ティアット・ナー　mɔ̀ːk lèːŋ tiˑət naː	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
434	ចូលមកចុះ។	入る＋来る＋～さいよ＝入りなさい。	null	チョール・モーク・チョホ　coːl mɔ̀ːk coh	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
435	ហេតុអ្វីមិនមក?	理由＋何＋～ない＋来る＝なぜ来なかったのですか。	null	ハエット・アヴァイ・ムン・モーク　haet ʔəvəi mɯn mɔ̀ːk 	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
436	ព្រោះខ្ញុំផ្ដាសាយ។	なぜなら＋私＋風邪をひく＝風邪をひいたからです。	null	（ピー・）プルオホ・クニョム・プダサーイ　(piː) prʷɔ̀h kʰɲom pʰdaːsaːi	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
437	បើទៅស្រុកខ្មែរ គួរមើលប្រាសាទអង្គរវត្ត។	もし＋行く＋国＋カンボジア＋すべき＋見る＋宮殿＋アンコールワット＝もしカンボジアに行くならアンコールワットを見るべきだ。	null	バウ・タウ・スロック・クマエ・クオ・ムール・プラサート・オンコー・ヴォアット　baə tə̀w srok kʰmae kuˑo mə̀ːl praːsaːt ʔɔŋkɔ̀ː vɔət	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
438	សន្សំលុយដើម្បីទៅស្រុកខ្មែរ។	貯める＋金＋～ために＋行く＋国＋カンボジア＝カンボジアに行くために、貯金する。	null	ソンソム・ルイ・ダウムバイ・タウ・スロック・クマエ　sɔnsɔm lʊi daəmbəi tə̀w srok kʰmae	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
439	សន្សំលុយដើម្បីឲ្យកូនទៅស្រុកខ្មែរ។	貯める＋金＋～ために＋与える＋子＋行く＋国＋カンボジア＝子どもをカンボジアに行かせるために、貯金する。	null	ソンソム・ルイ・ダウムバイ・アオイ・コーン・タウ・スロック・クマエ　sɔnsɔm lʊi daəmbəi ʔaoi koːn tə̀w srok kʰmae	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
440	ប្រយ័ត្នដើម្បីកុំឲ្យផ្ដាសាយ។	気をつける＋～ために＋～するな＋与える＋風邪を引く＝風邪をひかないように、気をつける。	null	プロヤット・ダウムバイ・コム・アオイ・プダサーイ　prɔyat daəmbəi kom ʔaoi pʰdaːsaːi	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
442	ធីតា មកស្រុកខែ្មរវិញពីអង្កាល់?	ティダーさん、いつ帰国したんですか。	状況についてたずねる		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
443	ចាស លោកគ្រូ ខ្ញុំទើបតែមកពីម្សិលមិញ។	はい、先生、昨日帰ってきたばかりです。	意見を述べる		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
444	រៀននៅស្រុកជប៉ុនមួយឆ្នាំ យ៉ាងម៉េចដែរ?	日本で１年間勉強してどうでしたか。	状況についてたずねる		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
445	ចាស សប្បាយណាស់។	はい、とても楽しかったです。	意見を述べる		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
446	ប៉ុន្តែមុនដំបូង ពិបាកបន្តិច ដោយនឹកផ្ទះផង ចាញ់រងារផង។	でも、最初は、ホームシックになったし、寒くて少し困りました。			\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
447	ឥឡូវ ចេះភាសាជប៉ុនច្រើនហើយឬ?	日本語は上手になったでしょうね。	状況についてたずねる		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
448	ចាស ចេះគួរសមដែរ។	はい、ある程度は使えるようになりました。	意見を述べる		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
450	អញ្ចឹង ខំរៀនតទៅទៀតណា៎។	では、またしっかり勉強してくださいね。			\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
451	លោកគ្រូ រឿងចុះបំពេញកម្មសិក្សារបស់ខ្ញុំ យ៉ាងម៉េចដែរ?	先生、私のインターンシップのことですけれど、どうなったでしょうか。	状況についてたずねる		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
452	រឿងនេះ អត់បញ្ហាទេ។	そのことなら問題ありませんよ。	意見を述べる		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
453	អញ្ចឹង ខ្ញុំអាចទៅចុះបំពេញកម្មសិក្សាបាន មែនទេ?	では、インターンシップに行けるのですね。	意見を述べる		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
454	បាទ មិនចាំបាច់ព្រួយបារម្ភអីទេ។	ええ、心配いりませんよ。	意見を述べる		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
455	លោកគ្រូជួយខ្ញុំច្រើន។	先生には、いろいろとお世話になりました。	感謝する		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
456	ខ្ញុំសូមអរគុណ លោកគ្រូ។	本当に感謝しています。	感謝する		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
457	បាទ មិនអីទេ។ នេះគឺការងារខ្ញុំទេ។	どういたしまして。それが仕事だからね。	挨拶する		\N	dmod	km02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
458	ប្រយ័ត្ន! លោកស្ទើរតែត្រូវឡានកៀរ អម្បាញ់មិញ។	気をつけて。今、もう少しで車にひかれるところでしたよ。	注意をひく		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
490	មានអី ខាងក្នុង?	何が入っているんでしょう。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
459	ខ្ញុំភ័យបន្តិចដែរ។ សព្វថ្ងៃ ចំនួនឡាន រឹតតែកើនច្រើនឡើងៗ	ちょっとこわかったです。最近、車が増えてきましたね。	意見を述べる		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
460	ចាស ហើយគ្រោះថា្នក់ ក៏កាន់តែមានច្រើនឡើងដែរ។	ええ、それに、事故もどんどん増えています。	助言する		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
462	សូមប្រយ័ត្នរបស់របរ នៅកនែ្លងដែលមានមនុស្សច្រើន។	人の多いところでは、身の回りのものに気をつけてください。	助言する		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
463	បញ្ហាមានញឹកញយឬ?	よく問題が起きるんですか。	状況についてたずねる		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
464	ពាក្យចាស់លោកថា ប្រហែសបាត់ ប្រយ័ត្នគង់។	「怠れば失い、心がければ長持ちする」ということですよ。	助言する		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
465	បាទ ខ្ញុំនឹងប្រយ័ត្ន។	はい、気をつけます。	さよならを言う		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
466	សូមទោសលោក លោកជាលោកតាណាកា មែនទេ?	すみません、田中さんでしょうか。	状況についてたずねる		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
467	បាទ គឺខ្ញុំ។	はい、そうです。	意見を述べる		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
468	ជំរាបសួរ ខ្ញុំឈ្មោះទេវី មកពីក្រសួងកសិកម្ម។	初めまして、農業省のテビーです。	自己紹介する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
469	ខ្ញុំជាដៃគូការងាររបស់លោក ក្នុងកម្មវិធីអភិវឌ្ឍន៍ជនបទថ្មីនេះ។	今度の農村開発プロジェクトでご一緒することになりました。	自己紹介する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
470	ជំរាបសួរ ខ្ញុំឈ្មោះតាណាកា។	初めまして、田中です。	自己紹介する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
471	សូមជួយណែនាំខ្ញុំ ក្នុងពេលមួយឆាំ្នខាងមុខនេះផង។	1年間、よろしくお願いします。	自己紹介する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
472	ខ្ញុំរីករាយណាស់ ដោយបានសា្គល់លោក។	お目にかかれて光栄です。	挨拶する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
473	ខ្ញុំត្រេកអរណាស់។	こちらこそ。	挨拶する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
474	លោកតាណាកា ធា្លប់អញ្ជើញមកស្រុកខែ្មរទេ?	田中さんはカンボジアにいらっしゃるのは初めてですか。	状況についてたずねる		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
475	បាទ មិនដែលទេ។	はい、初めてです。	意見を述べる		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
476	ខ្ញុំសប្បាយចិត្តណាស់ ដោយមានឱកាសចូលរួមក្នុងកម្មវិធីនេះ។	今回のプロジェクトに参加する機会をいただいて、本当にうれしいです。	挨拶する		\N	dmod	km04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
477	សូមទោស លោកតាណាកា។ ខ្ញុំមកយឺតពេល។	すみません、田中さん。遅くなりました。	謝る		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
478	បាទ មិនអីទេ។	大丈夫ですよ。	挨拶する		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
479	ខ្ញុំមកយឺតនេះ មកពីស្ទះចរាចរណ៍។	道が混んでいたので遅れました。	謝る		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
480	លោកចាំខ្ញុំយូរទេ?	長い間、お待たせしたでしょうか。	謝る		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
481	មិនអីទេ កុំខ្វល់អី។	いえいえ、気にしないでください。	意見を述べる		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
482	ខ្ញុំឮថា ជនជាតិជប៉ុន គោរពពេលម៉ោងណាស់។	日本の方は時間にとても正確だと聞いています。	状況についてたずねる		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
483	ខ្ញុំវិញ ធ្វើឲ្យទេវីពិបាក ដោយនាងត្រូវមកទទួលខ្ញុំ។	こちらこそ、わざわざ迎えに来ていただいて、テビーさんにご迷惑をおかけしました。	謝る		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
484	ចាប់ពីសែ្អកទៅ ខ្ញុំទៅដោយខ្លួនឯង។	明日からは一人で参ります。	挨拶する		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
485	លោកអាចទៅមា្នក់ឯងបាន មែនទេ?	お一人で大丈夫ですよね。	状況についてたずねる		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
486	បាទ ទៅបាន។	はい、もちろんです。	挨拶する		\N	dmod	km05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
487	ទេវី នេះកាដូមកពីជប៉ុន ខ្ញុំចង់ជូននាង។	テビーさん、これは日本からのお土産ですが、どうぞ。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
488	សម្រាប់ខ្ញុំឬ?  សូមអរគុណ។	私にですか。ありがとうございます。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
491	តែខៀវនិងនំជប៉ុន។	日本のお茶とお菓子です。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
492	នំនេះធ្វើពីអ្វី?	このお菓子は何から作られているんですか。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
493	គឺជានំផែ្អម ធ្វើពីសណែ្តក។	これは、甘いお菓子で、豆から作ったものです。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
494	មើលទៅ គួរឲ្យឆ្ងាញ់ណាស់។  អរគុណ។	おいしそうですね。ありがとうございます。			\N	dmod	km06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
495	ទេវី សូមអរគុណ ដោយមកជូនដំណើរខ្ញុំ។	テビーさん、見送りに来ていただいて、ありがとうございます。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
496	ចាស មិនអីទេ។	いえいえ。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
497	ខ្ញុំសូមអរគុណលោកតាណាកា ដោយបានជួយខ្ញុំ ក្នុងរយៈពេលមួយឆាំ្នកន្លងមកនេះ។	１年間、田中さんには本当にお世話になりました。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
498	ទេវីបានជួយខ្ញុំច្រើនជាង។	こちらこそ、お世話になりました。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
499	បើអត់ទេវីទេ កម្មវិធីយើង មិនអាចមានដំណើរការបានទេ។	テビーさんがいなかったら、プロジェクトは成功しなかったと思います。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
500	លោកនិយាយដូចនេះ ធ្វើឲ្យខ្ញុំសប្បាយចិត្តណាស់។	そう言っていただいて嬉しいです。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
501	បើមានឱកាសមកស្រុកខែ្មរម្តងទៀត សូមជូនដំណឹងឲ្យខ្ញុំដឹងផង។	また、カンボジアにいらっしゃることがあれば、ぜひ連絡してください。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
502	បាទ បើមានឱកាស ខ្ញុំចង់មកធ្វើការជាមួយទេវីម្តងទៀត។	はい、また機会があれば、ぜひテビーさんとお仕事をしたいです。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
503	សូមអញ្ជើញឲ្យបានសុខសប្បាយតាមផ្លូវ។	どうぞお気をつけていらしてください。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
504	បាទ អរគុណ។	ありがとうございます。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
505	ចំណែកទេវី ក៏សូមឲ្យបានសុខសប្បាយដែរ។ ជំរាបលា។	テビーさんもお元気で。さようなら。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
506	ជំរាបលា។	さようなら。			\N	dmod	km07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
507	អាវយឺតនេះ ថ្លៃប៉ុន្មាន?	このＴシャツ、いくらですか。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
508	ចាស មួយថ្លៃ មួយម៉ឺនប្រាំ។	１枚、１万５千リエルです。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
509	មួយម៉ឺនប្រាំពាន់រៀលឬ? ថ្លៃម៉្លេះ?	１万５千ですか。高いなあ。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
510	លោកយកប៉ុន្មាន? បើយកច្រើន ខ្ញុំចុះជូន។	何枚お買い上げですか。たくさん買うならまけますよ。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
511	យកបួន យ៉ាងម៉េចដែរ?	では、４枚でどうでしょう。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
512	ជួយទិញដប់ទៅ។ ខ្ញុំលក់ជូនមួយម៉ឺនបួន។	１０枚買ってくださいな。１枚、１万４千でいいですよ。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
513	មួយម៉ឺន បានទេ?	１万になりませんか。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
514	ចូលដើមហើយ។ មួយម៉ឺនបីចុះ។	赤字になっちゃうわ。１万３千でどうですか。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
515	អញ្ចឹង ខ្ញុំយកដប់។	じゃあ、１０枚もらいます。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
516	អរគុណលោក។	ありがとうございます。			\N	dmod	km08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
517	សូមអរគុណនាង ដោយអញ្ជើញដាក់ពាក្យសុំចូលធ្វើការក្នុងអង្គការយើង។	この仕事に応募してくださってありがとうございます。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
518	សូមសួរបន្តិច បានទេ?	いくつか伺いますが、よろしいでしょうか。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
520	នាងដែលធ្វើការនៅអង្គការមនុស្សធម៌ណាមួយទេ?	これまでに、どこかの援助団体で働いたことがありますか。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
521	ចាសទេ មិនដែលទេ។	いいえ、ありません。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
522	តាមប្រវត្តិរូបរបស់នាង នាងបានទៅរៀនប្រទេសជប៉ុន មែនទេ?	履歴書によると、日本に留学したことがあるそうですね。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
523	ចាស ខ្ញុំរៀននៅតូក្យូមួយឆាំ្ន។	はい、東京で１年間勉強しました。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
524	ហេតុអ្វី នាងសម្រេចចិត្តទៅរៀនប្រទេសជប៉ុន?	なぜ日本に留学しようと思ったんですか。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
525	ចាស ពីព្រោះឪពុកខ្ញុំធា្លប់ធ្វើការជាមួយជនជាតិជប៉ុន ហើយគាត់និយាយសរសើរពីជប៉ុនច្រើន។	はい、父が日本人と一緒に仕事をしたことがあって、いい話をたくさん聞いていたからです。			\N	dmod	km09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
526	យើងសម្រេចចិត្តថា នឹងទទួលនាងជាបុគ្គលិកថ្មី។	ティダーさんを採用することになりました。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
527	ខ្ញុំរីករាយណាស់។ សូមអរគុណ។	光栄です。ありがとうございます。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
528	សូមចូលធ្វើការចាប់ពីខែក្រោយ។	来月から仕事に来てください。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
529	ខ្ញុំមកថ្ងៃទីមួយខែក្រោយ មែនទេ?	一日に伺えばよろしいのですか。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
530	បាទ នាងនឹងទទួលខុសត្រូវខាងកម្មវិធីអក្ខរកម្ម។	はい、ティダーさんには、識字教育プロジェクトを担当してもらうつもりです。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
531	ចាស។	はい。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
532	យើងសង្ឃឹមថា នាងនឹងធ្វើការបានល្អ។	期待していますよ。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
533	ចាស ខ្ញុំនឹងខំប្រឹងប្រែងឲ្យអស់ពីសមត្ថភាព។	はい、一所懸命がんばります。			\N	dmod	km10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
534	លោកយ៉ាម៉ាដា ខ្ញុំឮថា លោកទៅស្ទូចត្រីពីម្សិលមិញ។	山田さん、昨日、釣りに行ったんですって。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
535	បាទ ខ្ញុំស្ទូចត្រីបានច្រើនណាស់។	ええ、たくさん釣れましたよ。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
536	បានត្រីធំៗច្រើនឬ?	大きな魚がたくさん釣れましたか。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
537	ច្រើន រហូតដល់រកកន្រ្តកដាក់មិនអស់។	魚籠（びく）に入りきらないくらいですよ。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
538	ហើយត្រីធំប៉ុនណា?	どれくらい大きな魚ですか。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
539	ប៉ុនកំភួនដៃ។	この腕くらいです。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
540	អស្ចារ្យណាស់។	すごいですね。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
541	ខ្ញុំនឹងធ្វើត្រីឆៅឲ្យញ៉ាំសាកមើលម្តង។	刺身にして食べさせてあげましょう。			\N	dmod	km11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
542	លោកយ៉ាម៉ាដា រាល់ថ្ងៃ ក្រោកពីគេងម៉ោងប៉ុន្មាន?	山田さんは毎日何時に起きるんですか。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
543	បាទ ក្រោកម៉ោង៤។	４時起きです。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
544	ឆាប់ម៉្លេះ? មុននឹងចេញទៅធ្វើការ លោកធ្វើអ្វីខ្លះ?	早起きですね。出勤前は何をしているんですか。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
545	បាទ លុបមុខ បោសសំអាតផ្ទះ បោកខោអាវ ហើយរៀបចំបាយព្រឹកសម្រាប់់ប្រពន្ធកូនខ្ញុំ។	顔を洗って掃除と洗濯をし、家内と子供のために朝食を用意します。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
546	គួរឲ្យសរសើរមែន។	すばらしいですね。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
547	ប៉ុនែ្តខ្ញុំក៏ឆាប់គេងដែរ។	でも寝るのは早いんですよ。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
548	លោកគេងម៉ោងប៉ុន្មាន?	何時に寝るんですか。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
549	បាទ គេងម៉ោង៨។	８時に寝ます。			\N	dmod	km12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
550	ធីតា ចំនួនប្រជារាស្រ្តនៅព្រះរាជាណាចក្រកម្ពុជា មានប៉ុន្មាននាក់?	ティダーさん、カンボジアの総人口はどれくらいですか。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
551	ចាស តាមរបាយការណ៍ជំរឿនទូទៅឆាំ្ន ១៩៩៨ នេះ មានប្រមាណ ១២ លាននាក់។	この1998年の国勢調査報告によれば、約1200万人です。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
552	ក្នុងនោះ មានកេ្មងអាយុក្រោម ១៥ ឆាំ្ន ប៉ុន្មានភាគរយ?	そのうち15歳未満の人口は何パーセントですか。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
553	ចាស ៤២,៨ ភាគរយ។	42.8パーセントです。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
554	ចុះអត្រាអក្ខរភាពមនុស្សពេញវ័យ ប៉ុន្មានភាគរយ?	では、成人識字率はどれくらいですか。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
555	ចាស ៦៧,៣ ភាគរយ។	67.3パーセントです。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
556	មានសិត្ថិតាមភេទឬទេ?	男女別の統計もありますか。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
557	ចាស មាន។	はい、あります。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
558	ប្រុស ៧៩,៥ ភាគរយ ចំណែកស្រី ៥៧,០ ភាគរយ។	男性は79.5パーセント、女性は57.0パーセントです。			\N	dmod	km13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
559	ធីតា ជួយធ្វើសមា្ភរៈអក្ខរកម្ម បានឬទេ?	ティダーさん、教材の作成を手伝ってくださいませんか。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
560	ចាស បាន។	はい、もちろんです。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
561	មុនដំបូង យកកន្រ្តៃកាត់រូបអក្សរនេះចេញ។	まず、はさみで文字一つずつを切り離してください。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
562	ចាស រួចធ្វើអ្វី?	それからどうするのですか。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
563	រួចហើយ យកកាវបិទលើកា្តរតូចនេះឲ្យជាប់។	次に、のりでこの小さな板の上にしっかり貼り付けて下さい。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
564	ចាស យល់ហើយ។	はい、わかりました。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
565	ចាំកាវនេះស្ងួតល្អហើយ យកផា្លសី្ទកនេះបិទពីលើ។	のりが乾いたら、ビニールで覆ってください。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
566	មើលទៅ វានឹងកា្លយទៅជាសមា្ភរៈគួរឲ្យចង់រៀនមិនខាន។	すてきな教材ができそうですね。			\N	dmod	km14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
567	ធីតា ចេះប្រើកុំព្យូទ័រឬទេ?	ティダーさん、コンピュータは使えますよね。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
569	ធ្វើរបាយការណ៍បែបនេះ បានឬទេ?	このような月例報告書を作成できますか。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
570	ចាស អត់បញ្ហាទេ។	はい、問題ありません。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
571	ចេះធ្វើតារាងនិងរូបភាពទេ?	表やグラフも作成できますか。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
572	ចាស ខ្ញុំធា្លប់ធ្វើតារាងនិងរូបភាពច្រើន ពេលខ្ញុំសរសេរនិក្ខេបបទ។	はい、卒論で表やグラフをたくさん作ったので慣れています。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
573	ពូកែមែន។	さすがですね。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
574	អញ្ចឹង ចេះជួសជុលកុំព្យូទ័រខូចទៀតទេ?	では、壊れたコンピュータの修理もできますか。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
575	ចាសទេ មិនចេះទេ។	それは、無理です。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
576	ធីតា នៅក្នុងផែនទីនេះ ខេត្តរតនគីរីនៅត្រង់ណា?	ティダーさん、この地図でラタナキリ州はどこにありますか。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
577	ចាស ត្រង់នេះ។	ここです。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
578	ខ្ញុំឮថា នៅខេត្តរតនគីរីនេះ មានប្រជាជន ដែលមិនចេះនិយាយភាសាខែ្មរ ច្រើន។	ラタナキリ州には、カンボジア語を話さない人が多いと聞きましたが。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
579	ចាស មែនហើយ។	はい、そうです。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
580	នៅទីនោះ មានប្រជាជន ដែលគេហៅថា ជនជាតិភាគតិច ដូចជាព្នងនិងគួយ ជាដើម។	プノン人やクイ人など、いわゆる少数民族がいます。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
581	ចុះសម្រាប់់ប្រជាជននោះ គេធ្វើកម្មវិធីអក្ខរកម្មយ៉ាងម៉េចដែរ?	その人たちにはどのような識字教育が行われているんですか。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
582	ចាស ក្រសួងធ្វើសៀវភៅមេរៀនអក្ខរកម្ម ទាំងភាសាគេ និងភាសាខែ្មរ ដោយប្រើអក្សរខែ្មរតែមួយ។	カンボジア文字を使って、民族語とカンボジア語の両方を書き表す教科書を教育省が作っています。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
583	សៀវភៅមេរៀននោះ មាននៅណា?	その教科書はどこにありますか。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
584	ចាស នៅការិយាល័យយើង ក៏មានដែរ។	この事務所にもあります。			\N	dmod	km16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
585	ទេវី វចនានុក្រមអេឡិចត្រូនិចនេះ របស់អ្នកណា?	テビーさん、この電子辞書は誰のものですか。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
586	របស់ខ្ញុំ។	私のものです。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
587	អូ៎ របស់ជប៉ុនសុទ្ធ។	日本製ですね。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
588	តាមពិត របស់ឪពុកខ្ញុំ តែខ្ញុំខ្ចីមកប្រើថ្ងែនេះ។	本当は父のものですが、今日だけ借りてきたんです。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
589	ប៉ានាងស្រឡាញ់កូនស្រីណាស់ មើលទៅ។	お父さんは娘がかわいいみたいですね。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
590	វចនានុក្រមរបស់មា្តយខ្ញុំ ថ្មីហើយល្អជាងនេះទៀត តែគាត់មិនឲ្យអ្នកណាប្រើទេ។	母のはもっと新しくて性能がいいんですけど、貸してくれません。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
591	មានន័យថា គាត់មិនទុកចិត្តនាងឬ?	テビーさんが信用ないっていうことですか。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
592	ជាកម្មសិទ្ធរួមរបស់អង្គការគាត់។	母の職場のものなんです。			\N	dmod	km17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
593	ទេវី យល់ឃើញថា ប្រធានថ្មី យ៉ាងម៉េចដែរ?	テビーさん、新しい所長のことをどう思いますか。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
594	មើលទៅ គាត់ជាមនុស្សស្លូត។	おとなしそうな人ですね。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
595	នាងគិតថា យើងអាចធ្វើការជាមួយគាត់ ដោយអត់បញ្ហា មែនទេ?	うまくやっていけると思っているようですね。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
596	ចាស ប្រហែលជា មិនអីទេ។	大丈夫でしょう。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
597	មិនសូវកាចប៉ុន្មានទេ មើលទៅ។	そんなにきびしそうな人には見えないし。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
598	ទេវី ចេះមើលមនុស្សតែតាមចរិតស្លូត ឬ កាច តែប៉ុណ្ណឹងទេឬ?	テビーさんは、人の性格をおとなしいか、きびしいかにしか分けないんですね。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
599	ក្រៅពីនេះ មានអីទៀត?	他に何があるんでしょう。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
600	ឧទាហរណ៍ ចេះសា្តប់យោបល់កូនចៅ ឬអត់។	部下の意見に耳を傾けるかどうか、とか。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
601	ប្រហែលជា គាត់មិនសា្តប់លោកទេ។	ソムナーンさんの意見には耳を傾けないかもしれませんね。			\N	dmod	km18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
602	លោកសំណាង ពិសាអ្វីហឹ្នង?	ソムナーンさん、何を飲んでいるんですか。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
603	បាទ ខ្ញុំផឹកកាហ្វេ។	コーヒーです。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
604	លោកមិនដាក់ទឹកដោះគោទេឬ?	ミルクを入れないんですか。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
605	បាទ ខ្ញុំមិនចេះផឹកទឹកដោះគោទេ។	ええ、ミルクは好きではありません。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
606	លោកចូលចិត្តកាហ្វេខ្មៅមែនឬ?	ブラックが好きなんですか。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
607	បាទ តែខ្ញុំចូលចិត្តកាហ្វេដាក់ស្ករ។	いいえ、砂糖は入れますよ。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
608	អញ្ចឹង ប្រាកដជាចូលចិត្តបងែ្អមហើយ។	じゃあ、甘いものが好きなんですね。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
609	អូ៎ទេ ខ្ញុំមិនចូលចិត្តបងែ្អមទេ។	いいえ、甘いお菓子は好きではありません。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
610	កាហ្វេខ្មៅ វាចត់ពេក ពិបាកផឹក។	でもブラックコーヒーは苦くて飲みにくいですから。			\N	dmod	km19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
611	លោកសំណាង សូមជួយយកសំបុត្រនេះទៅប៉ុស្តិ៍ផង។	ソムナーンさん、この手紙を郵便局まで出しに行ってくれませんか。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
612	បាទ បើការងារចេញទៅក្រៅ ខ្ញុំគិតថា លោកភិរម្យចង់ទៅជាង។	外回りなら、ピロムさんが行きたがると思いますよ。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
613	អញ្ចឹង សូមជួយវាយឯកសារនេះ បានទេ?	では、この書類を、タイプしてくれませんか。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
614	បាទ បើការងារវាយកុំព្យូទ័រ លោកវុធី ប្រាកដជាចូលចិត្តធ្វើ។	タイプなら、ヴティーさんが喜んでやってくれるでしょう。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
615	អញ្ចឹង សូមជួយយកឯកសារនេះទៅជូនលោកប្រធានចុះហត្ថលេខា បានទេ?	では、この書類に所長のサインをもらってきてくれませんか。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
616	លោកប្រធាន គាត់មិនចូលចិត្តឃើញមុខខ្ញុំទេ មើលទៅ។	所長は、僕に会いたがらないんです。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
617	អញ្ចឹង លោកសំណាង ពេញចិត្តការងារបែបណា?	ソムナーンさんは、一体、どんな仕事ならやる気があるんですか。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
618	បាទ ខ្ញុំពេញចិត្តអង្គុយធ្វើព្រងើយ។	座ってぼんやりしていることです。			\N	dmod	km20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
619	ទេវី ជួយប្រាប់របៀបធ្វើល្ពៅសង់ខ្យាផង បានទេ?	テビーさん、かぼちゃプリンの作り方を教えてくれませんか。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
621	មុនដំបូង ចោះត្រង់ក្បាលល្ពៅទំហំ៧cm បួនជ្រុង រួចយកគ្រាប់ចេញឲ្យអស់។	まず、かぼちゃの上の方を７センチ角にくり抜いて、それから種を取り除きます。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
622	បាទ យល់ហើយ។	はい、わかりました。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
623	បនា្ទប់មក យកខ្ទិះដូង ស្ករ ពងមាន់ ដាក់ក្នុងចានគោមហើយវាយឲ្យសព្វចូលគា្ន។	次にココナツミルク、砂糖、卵を深い器に入れて、よくかき混ぜます。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
624	ហើយធ្វើអីទៀត?	それからどうするんですか。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
625	ចាក់ល្បាយនេះ ចូលទៅក្នុងល្ពៅ ហើយដាក់ចំហុយ។	混ぜ合わせたものをかぼちゃに流し込み、蒸します。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
626	ចំហុយប៉ុន្មាននាទី?	何分くらい蒸すんですか。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
627	ចាស ប្រហែលកន្លះម៉ោង។	ええ、だいたい３０分ぐらいですね。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
628	អាឡូ។	もしもし。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
629	ចាស។	はい。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
630	ជំរាបសួរ ខ្ញុំឈ្មោះសំណាង ចង់ជួបលោកតាណាកា។	こんにちは、ソムナーンと申します。田中さんはいらっしゃいますか。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
631	អូ៎ លោកសំណាងឬ?	まあ、ソムナーンさんですか。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
632	ខ្ញុំជាប្រពន្ឋគាត់។	田中の家内です。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
633	បី្តខ្ញុំបានធូរស្រាលហើយ។	主人はもうかなりよくなりました。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
634	អញ្ចឹង បន្តិចទៀត គាត់អាចចេញពីមនី្ទរពេទ្យបានហើយ មែនទេ?	ではもうすぐ退院できそうなんですね。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
635	ចាស លោកគ្រូពេទ្យថា អាទិត្យក្រោយ ប្តីខ្ញុំអាចទៅធ្វើការបានហើយ។	ええ、お医者様からは、来週は仕事に行っていいと言われました。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
636	អញ្ចឹង ល្អណាស់។	それはよかった。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
637	ខ្ញុំព្រួយបារម្ភអំពីជំងឺគាត់។	とても心配していたんですよ。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
638	ចាស អរគុណច្រើន ដោយលោកយកចិត្តទុកដាក់ចំពោះប្តីខ្ញុំ។	お心にかけていただき、本当にありがとうございます。			\N	dmod	km22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
639	លោកសំណាង បើមានពេលសំរាកមួយអាទិត្យ លោកចង់ទៅលេងណា?	ソムナーンさん、もし１週間休みがとれたらどこに行きたいですか。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
640	ចង់ទៅកំពង់សោម។	コンポン・ソムに行きたいです。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
641	នៅទីនោះ មានកនែ្លងអ្វីសប្បាយ?	そこで何をしますか。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
642	ខ្ញុំគ្រាន់តែចង់មុជទឹកសមុទ្រ និង ញ៉ាំកា្តម។	泳いだり、かにを食べたりしたいですね。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
643	ចុះបើមានព្យុះ ធ្វើអី?	もし嵐になったらどうしますか。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
644	បើមានភ្លៀងដើរក្រៅមិនកើត យើងនៅក្នុងផ្ទះសំណាក់ ជជែកគា្នលេង ឬមើលវីដេអូ។	雨が降ったら外に出られないから、ゲストハウスでおしゃべりしたり、ビデオを観たりします。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
645	សា្តយណាស់។	もったいないですね。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
646	បើខ្ញុំវិញ នឹងរកតូបនៅក្បែរឆេ្នរទឹក អង្គុយមើលទេសភាព ពេលភ្លៀងធា្លក់។	私だったら、海辺の小屋で雨が降る風景を見ますけど。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
647	គំនិតនេះល្អណាស់។	いい考えですね。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
648	យើងនឹងទៅហាងតាមឆេ្នរ ផឹកស្រាបៀរ ជជែកគា្នឲ្យអស់ដៃម្តង។	じゃあ、海辺のレストランに行って、思う存分ビールを飲みながら、おしゃべりすることにしましょうか。			\N	dmod	km23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
649	លោកសំណាង បាល់ទាត់និងវ៉ៃបុក ចូលចិត្តមួយណា?	ソムナーンさん、サッカーとボクシングとどちらが好きですか。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
650	បាទ ខ្ញុំចូលចិត្តបាល់ទាត់ជាង។	はい、サッカーの方が好きです。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
651	អញ្ចឹង ក្នុងចំណោមកីឡាទាំងអស់ លោកចូលចិត្តមួយណាជាងគេ?	ではスポーツの中で一番好きなのは何ですか。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
652	បាទ ចូលចិត្តហែលទឹក។	水泳です。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
653	អ្ហា លោកពូកែហែលទឹក មែនទេ?	まあ、泳ぐのが上手なんですね。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
654	បាទទេ ខ្ញុំចូលចិត្តមើលគេហែលទឹកតាមទូរទស្សន៍ទេ។	いや、テレビで見るのが好きなんです。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
655	ចុះលោកចូលចិត្តរាំច្រៀងដែរឬទេ?	歌や踊りは好きですか。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
656	ហ្អូ៎ អារឿងរាំច្រៀង ខ្ញុំចូលចិត្តលេខមួយ។	あ、歌や踊りは一番好きですね。			\N	dmod	km24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
657	ទេវី សែ្អកទំនេរទេ?	テビーさん、明日、暇ですか。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
658	ចាស មានការអី?	ええ、何か用ですか。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
659	នាងចង់ទៅមើលកុនទេ?	映画を見に行きませんか。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
660	រឿងអី?	何の映画ですか。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
661	រឿង "កូនពស់កេងកង"។	『蛇娘』です。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
662	ចង់ទៅណាស់។ អ្នកណាទៅខ្លះ?	行きたいわ。他に誰が行きますか。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
663	បាទ អារីប្អូនស្រីខ្ញុំ និងពួកម៉ាកវា ដែលនាំបងស្រីមកជាមួយដែរ។	僕の妹のアリーと、その友達と、その子のお姉さんです。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
664	អញ្ចឹង ខ្ញុំបបួលលោកភិរម្យទៅជាមួយដែរ។	では、ピロムさんも誘って行きます。			\N	dmod	km25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
665	ធីតា ហេតុអ្វីបានជានាងឈប់ មិនមកម្សិលមិញ?	ティダーさん、昨日はどうして休んだんですか。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
666	ចាស សូមទោស លោកយ៉ាម៉ាដា។	はい、すみません、山田さん。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
667	ខ្ញុំក្តៅខ្លួន។	熱が出たからです。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
668	ប្រហែលផា្តសាយហើយ។	風邪をひいたんですね。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
669	ចាស មកពីម្សិលម៉្ងៃ ខ្ញុំត្រូវទឹកភ្លៀង។	はい、一昨日、雨に濡れたからです。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
670	ហេតុអីបានជាបណ្តោយឲ្យត្រូវទឹកភ្លៀងអញ្ចឹង?	どうして雨に濡れたんですか。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
671	ចាស ពីព្រោះខ្យល់ខាំ្លងធ្វើឲ្យឆ័ត្រខូចអស់។	はい、風が強くて傘が壊れてしまったんです。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
672	ស្រុកខែ្មរ ទទួលឥទ្ឋិពលមូស្សុងធ្វើឲ្យមានភ្លៀងខ្យល់ខាំ្លង។	カンボジアはモンスーンの影響を受けて雨風がひどくなるんですね。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
673	ចាស ខ្ញុំមិននឹកស្មានថា ភ្លៀងខាំ្លងយ៉ាងនេះសោះ ម្សិលម្ង៉ៃ។	ええ、あんなにひどい雨が降るとは全然思いませんでした。			\N	dmod	km26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
674	សូមអញ្ជើញ។	いらっしゃいませ。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
675	លោកអញ្ជើញមានការអី?	ご用件は何でしょうか。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
676	បាទ ខ្ញុំចង់បើកកុងធនាគារថ្មី។	はい、新しい口座を開きたいんですが。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
677	សូមបំពេញបែបបទក្នុងក្រដាសនេះ។	この用紙に記入してください。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
678	សូមជួយប្រាប់របៀបបំពេញផង បានទេ?	書き方を教えていただけますか。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
679	ចាស សូមបំពេញអាស័យដ្ឋាន ឈ្មោះ លេខទូរស័ព្ទ ហើយចុះហត្ថលេខាផង។	はい、ご住所、お名前、お電話番号を記入してから、ご署名をお願いします。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
680	យល់ហើយ។	わかりました。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
681	សុំមើលអត្តសញ្ញាណប័ណ្ណបន្តិច។	身分証明書を拝見します。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
682	ខ្ញុំមានតែលិខិតឆ្លងដែនទេ។	旅券しかありません。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
683	ចាស អត់អីទេ។	かまいません。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
684	ប៉ាស្ព័រក៏បានដែរ។	パスポートで結構です。			\N	dmod	km27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
685	ដានី ពាក្យខែ្មរ "ប្រកាន់" មានន័យយ៉ាងម៉េច?	ダニーさん、カンボジア語の「プロカン」という単語はどういう意味ですか。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
686	ចាស ខ្ញុំគិតថា មានន័យ ពីរយ៉ាង។	ええ、それには２つ意味があると思います。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
687	សូមជួយពន្យល់បន្តិច បានទេ?	説明してもらえますか。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
688	ចាស ឧទាហរណ៍ទីមួយ នៅស្រុកខែ្មរ គេជិះយានយន្ត ប្រកាន់ស្តាំ។	例えば、カンボジアでは、車は右側を「守り」ます。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
689	យល់ហើយ។	わかりました。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
690	គឺ ត្រូវធ្វើតាមច្បាប់តាមទមា្លប់។	つまり法律や慣例に従うということですね。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
691	ផ្ទុយទៅវិញ បើលោកមិនគោរពតាម លោកទាយទៅមើល។	逆に、もし従わなければ、どうなると思いますか。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
692	ហ្អា ដឹងហើយ។	ああ、わかりました。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
693	គឺប៉ូលិសប្រកាន់ទោសខ្ញុំ។	警察に罪を「問わ」れるんですね。			\N	dmod	km28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
694	លោក ត្រូវការអ្វី?	何をお探しですか。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
695	វចនានុក្រមអេឡិចត្រូនិចនេះ ស្អាតហើយតូច ស្រួលដាក់ហោប៉ៅ។	この電子辞書は、見た目もいいし、小さくてポケットにも入れられますね。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
696	ចាស នេះ ជាស៊េរីថ្មី។	はい、新型です。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
697	ប៉ុន្តែ ថ្លៃណាស់។	でも高いですね。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
698	ចុះថ្លៃបន្តិច បានទេ?	もう少し安くなりませんか。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
699	ចាស ដាច់ថ្លៃហើយ។	お安くなっているんですよ。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
700	ខ្ញុំធានាដំឡៃជូន។	値段はサービスしています。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
701	វាដើរល្អទេ?	ちゃんと動きますか。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
702	ចាស ខ្ញុំធានាថា វាជារបស់សុទ្ធ។	ええ、お品も保証します。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
703	អត់កែ្លងកា្លយទេ។	偽物ではありません。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
704	សូមជួយរកស៊េរីថ្មី។	新型も見せてください。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
705	តែឲ្យថោកជាងមុនបន្តិច។	でももう少し安くしてください。			\N	dmod	km29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
706	ដានី ចាំបន្តិចទៀត បានទេ?	ダニーさん、もう少し待っていてもらえますか。	依頼する		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
707	ចាស អត់អីទេ។	大丈夫です。	応答する		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
708	ខ្ញុំអានសៀវភៅចាំ។	本を読んでいますから。	状況について述べる		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
709	មើលសៀវភៅអី?	何を読んでいるんですか。	状況についてたずねる		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
710	រឿងប្រលោមលោក "បំភេ្លចមិនបាន" និពន្ធដោយអ្នកស្រី ប៉ាល់ វណ្ណារីរក្ស។	パル・ヴァンナリレアクの『忘れ得ず』という小説です。	状況について述べる		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
711	ល្អមើលទេ?	おもしろいですか。	状況についてたずねる		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
712	ចាស រឿងនេះ បានទទួលរង្វាន់អក្សរសិល្ប៍ព្រះសីហនុរាជ នៅឆាំ្ន១៩៩៥។	はい、１９９５年のシハヌーク国王文学賞をとったんですよ。	状況について述べる		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
713	ដល់ពេលអានចប់ សុំខ្ចី បានទេ?	読み終わったら貸してもらえませんか。	依頼する		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
714	ចាស មានអី។	ええ、いいですよ。	応答する		\N	dmod	km30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
715	ដានី ខាងគណនេយ្យ គឺជាការងាររបស់អ្នកណា?	ダニーさん、会計は誰の仕事ですか。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
716	ចាស ការងារខ្ញុំ។	はい、私の仕事です。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
717	ហ្អា នាងទទួលបន្ទុកតែខាងគណនេយ្យ ទេឬអី?	ああ、あなたは会計担当なんですね。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
718	ចាសទេ ការងារផ្សេង ក៏ខ្ញុំធ្វើដែរ។	いいえ、他の仕事もしています。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
719	ការងារអ្វីខ្លះទៅ?	どんな仕事をしているんですか。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
720	វាយឯកសារផង ចែកសំបុត្រផង។	書類をタイプしたり、郵便物を整理したりしています。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
721	ការងារណា ពិបាកជាងគេ?	どの仕事が一番大変ですか。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
722	គណនេយ្យ។	会計です。			\N	dmod	km31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
723	លោកកាន់ដា នេះជាវត្តឧណ្ណាលោម។	神田さん、ほら、ここがウナロム寺院です。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
724	ធំណាស់ហ៎្ន។	大きいですね。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
725	លោកត្រូវដោះមួកចេញ ពេលចូលវត្ត។	お寺に入る時には帽子を脱がないとだめなんですよ。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
726	សូមទោស ខ្ញុំមិនដឹង។	すみません、知りませんでした。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
727	ហើយពេលចូលទៅក្នុងវិហារ ត្រូវដោះស្បែកជើងទៀតផង។	それから、本堂に入る時には、靴を脱がないといけません。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
728	បាទ យល់ហើយ។	はい、わかりました。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
729	លោកសង្ឃមិនអាចប៉ះនារីភេទបានទេ។	僧侶は女性に触れることはできません。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
730	គួរឲ្យចាប់អារម្មណ៍មែន។	本当におもしろいですね。			\N	dmod	km32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
731	លោកឈឺអី?	どうなさいましたか。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
732	ឈឺពោះរាក តាំងពីព្រឹកមក។	今朝からおなかが痛くて、下痢が止まらないんです			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
733	អញ្ចឹង ខ្ញុំចាក់ថាំ្នឲ្យមួយម្ជុល។	では、注射を１本打ちましょう。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
734	ខ្ញុំខា្លចម្ជុលណាស់ មិនចាក់ថាំ្នទេ អ្នកគ្រូ។	先生、注射は怖いので、嫌です。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
735	អញ្ចឹង ខ្ញុំជូនថាំ្នលេបសម្រាប់លោកពិសាវិញ។	では、飲み薬をさしあげましょう。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
736	បាទ អរគុណណាស់។	はい、ありがとうございます。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
737	ញ៉ាំម្តង ២គ្រាប់ ១ថ្ងៃ ៣ដង ក្រោយពេលពិសាបាយរួច។	毎食後に２錠ずつ、１日３回、飲んでください。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
738	បាទ យល់ហើយ។	はい、わかりました。			\N	dmod	km33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
739	ខ្ញុំមកយកអីវ៉ាន់ផ្ញើមកពីជប៉ុន។	日本からの小包を受け取りに来ました。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
741	ចាំបន្តិច។	ちょっとお待ちください。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
742	នេះ គឺឈ្មោះលោក មែនទេ?	これは、あなたのお名前ですね。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
743	ហ្អា កុំទាន់បើកអី បាទ។	ああ、開けないでください。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
744	ខ្ញុំត្រូវតែឆែកមើលខាងក្នុង។	中に何が入っているのか調べないといけないんです。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
745	អញ្ចឹង សូមកុំប្រើកាំបិតអី។	ではカッターを使わないでください。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
747	វាធ្វើឲ្យរហែកខោអាវក្នុងកពា្ចប់នេះ។	中の洋服が切れてしまいます。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
748	អត់អីទេ។	大丈夫ですよ。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
749	ទុកចិត្តចុះ ខ្ញុំធានា។	ちゃんと気をつけますから。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
750	ដានី ខ្ញុំសុំសួរអំពីរឿងគម្រោងនៅខេត្តតាកែវបន្តិច។	ダニーさん、タケオ州のプロジェクトのことで聞きたいんですが。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
751	គម្រោងនេះ មិនមែនខ្ញុំជាអ្នកទទួលខុសត្រូវទេ។	そのプロジェクトは私の担当ではありません。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
752	ខ្ញុំមិនដឹងទេ។	私ではわかりません。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
753	អញ្ចឹង អ្នកណាកាន់ការងារនោះ?	それでは誰の担当ですか。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
754	ចាស គឺ លោកភិរម្យ។	ピロムさんです。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
755	ចុះគម្រោងនៅខេត្តបាត់ដំបងវិញ?	では、バッタンバン州のプロジェクトはどうですか。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
756	គម្រោងនោះ ក៏មិនមែនការងារខ្ញុំដែរ។	そのプロジェクトも私の担当ではありません。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
757	ចុះដានី ធ្វើការខាងអី?	ダニーさんは、何を担当しているんですか。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
758	គឺខាងថែរក្សាលោកកាន់ដាទេតើ។	神田さんのお世話ですよ。			\N	dmod	km35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
759	លោកកាន់ដា ខ្ញុំសូមអញ្ជើញលោក។	神田さん、どうぞ。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
760	នេះ សំបុត្រអី?	これは、何の手紙ですか。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
761	គឺសំបុត្រពិសាការរបស់បងប្អូនខ្ញុំ។	私の親戚の結婚式の招待状です。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
762	ហ្អា អ្នកណាការ?	ああ、どなたが結婚なさるんですか。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
763	បងស្រីជីដូនមួយរបស់ខ្ញុំ។	私の従姉です。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
764	អញ្ចឹង ខ្ញុំនឹងទៅមិនខាន។	では、必ず伺います。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
765	ខ្ញុំត្រូវទៅម៉ោង៤រសៀល មែនទេ?	午後４時に伺えばいいんですね。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
766	ចាស ម៉ោង៤ជាងបន្តិច ក៏អត់អីដែរ។	４時すぎからでもかまいません。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
767	ព្រោះធម្មតា ភ្ញៀវណាមកមុន គេទទួលមុន ភ្ញៀវក្រោយ ទទួលក្រោយ។	早く着いたお客様から先にお迎えして、ゆっくりいらしたお客様は後からお迎えするので。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
768	បាទ យល់ហើយ។	はい、わかりました。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
769	ខុសពីរបៀបជប៉ុនទាំងស្រុង។	日本の結婚式とはずいぶん違うんですね。			\N	dmod	km36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
770	ដានី ទៅញ៉ាំការនេះដែរឬទេ?	ダニーさんも、この結婚式には出席なさいますか。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
771	ចាស ទៅ។	ええ、出席します。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
772	ត្រូវស្លៀកពាក់យ៉ាងម៉េចដែរ?	どんな服装で伺えばいいんでしょうか。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
773	ប្រុសៗ ពាក់អាវកឌុបធម្មតា បានហើយ។	普通のＹシャツで大丈夫ですよ。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
774	ចុះចងដៃ ធ្វើយ៉ាងម៉េច?	お祝いはどうすればいいんでしょうか。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
775	ដាក់លុយនៅក្នុងស្រោមសំបុត្រអញ្ជើញនេះហើយញ៉ាំរួចហើយយកស្រោមសំបុត្រនេះ ឲ្យអ្នកដែលចាំទទួលចំណងដៃនៅតុ ក្បែរកនែ្លងទទួលភ្ញៀវតែម្តង។	結婚式の招待状が入っていた袋にお祝いを入れて、食事が済んだら、受付で渡せばいいんですよ。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
776	ចងដៃប៉ុន្មាន បានសម?	どれくらいが相場なんでしょう。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
777	ស្រេចតែលោកទេ។	お気持ち次第です。			\N	dmod	km37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
778	លោកអញ្ជើញហៅអី?	何になさいますか			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
779	មានអីខ្លះ?	何がありますか。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
780	ចាស មានគុយទាវ បបរ និងបាយសាច់ជ្រូក។	はい、そば、お粥、豚肉ご飯です。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
781	អញ្ចឹង យកគុយទាវធម្មតាមួយ។	では、そばを下さい。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
782	អញ្ជើញពិសាទឹកអី?	飲み物は何になさいますか。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
783	យកកាហ្វេទឹកដោះគោ។	ミルク入りコーヒーを下さい。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
784	ដាក់ទឹកកកទេ?	アイスにしますか。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
786	ខ្ញុំឈ្មោះ កាន់ដា បានកក់បន្ទប់សម្រាប់បីយប់។	３泊で予約していた神田です。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
787	ចាស ត្រូវការបន្ទប់បែបណា?	はい、どのようなお部屋をご希望ですか。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
788	ខ្ញុំចង់បានបន្ទប់នៅជាន់ទីបី បង្អួចបែរទៅរកថ្នល់ធំខាងមុខ។	道路に面した３階の部屋をお願いします。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
789	ចាស បើបន្ទប់លេខ៣០២ ប្រាកដជាលោកពេញចិត្ត។	はい、302号室でしたらご希望通りです。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
790	ប៉ុនែ្តមិនទាន់រៀបចំហើយនៅឡើយ។	でも、お部屋のご用意がまだ終わっておりません。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
791	ម៉ោងប៉ុន្មាន អាចចូលបាន?	何時になりますか。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
792	ចាស ប្រហែលម៉ោង៥។	５時頃になります。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
793	អញ្ចឹង សុំផ្ញើអីវ៉ាន់នេះ បានទេ?	では、この荷物を預かってもらえますか。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
794	នៅខាងក្នុងនេះ អត់មានអីសំខាន់ទេ។	貴重品は入っていません。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
795	ចាស ខ្ញុំនឹងទុកជូន។	承知いたしました。			\N	dmod	km39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
796	នេះ ជាលោកអ៊ីតូ។	ほら、これが伊藤さんです。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
797	អ្នកជំនាញការមកជំនួសលោក មែនទេ?	神田さんの後任の方ですね。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
798	បាទ គាត់មនុស្សល្អណាស់។	ええ、伊藤さんはとてもいい人ですよ。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
799	មើលទៅ ដូចសុភាពណាស់។	やさしそうに見えますね。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
800	មិនត្រឹមតែប៉ុណ្ណឹងទេ គាត់ក៏ឧស្សាហ៍ការងារទៀតផង។	それだけではなくて、仕事もできますよ。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
801	ខ្ញុំគិតថា ជនជាតិជប៉ុន អ្នកណា ក៏ដូចអ្នកណាដែរ គឺពូកែធ្វើការដូចគា្ន។	日本人はみんな同じで仕事熱心だと思いますけど。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
802	អេ៎ មិនមែនទាំងអស់នោះទេ។	え、そんなことはありませんよ。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
803	យ៉ាងណាក៏ដោយ ខ្ញុំនឹងរង់ចាំជួបគាត់។	とにかく伊藤さんにお目にかかるのが楽しみです。			\N	dmod	km40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
804	ស៊ី	食う	null	siː	\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
805	សើច	笑う	null	saəc	\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	1
806	ស្ងោរ	煮る	null	sŋao	\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	1
807	ស្អែក	明日	null	sʔaek	\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	\N	\N	1
808	លក់	売る	null	lʷɔ̀k	\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	\N	\N	1
809	ល្ហុង	パパイヤ	null	lhoŋ	\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	\N	\N	\N
810	បំផុត  បន្តិច  បញ្ចូល  បង្ខំ	最も、少し、入れる、強いる	null	bɔmpʰot, bɔntəc, bɔɲcoːl, bɔŋkʰom	\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
811	សាច់គោ  សាច់មាន់  សាច់ជ្រូក	牛肉、鶏肉、豚肉	null	sac kòː, sac mɔən, sac cruːk	\N	pmod	page005.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	\N	\N	1
812	ទេវី	テヴィー（人名）	null	tèˑviː	\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
814	គា		null	kiˑə	\N	pmod	page007.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
815	ក្ដារ	板	null	kʰdaː	\N	pmod	page007.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
816	ក្បាល	頭	null	kʰbaːl	\N	pmod	page007.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	\N	\N	1
818	បាន	得る	null	baːn	\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
819	ប្ដូរ	交換する	null	pʰdoː	\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
820	បក្ស	党	null	pak	\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	\N	\N	1
821	ខ្មែរ	カンボジア（クメール）	null	kʰmae	\N	pmod	page008.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
822	ក្រដាស	紙	null	krɔˑdaːh	\N	pmod	page008.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	\N	\N	1
823	កញ្ញា	９月	null	kaɲɲaː	\N	pmod	page008.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
824	បន្តិច	少し	null	bɔntəc	\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	\N	\N	1
825	កណ្ដុរ	ねずみ	null	kɔndol	\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
826	ស្ដាយ	悔やむ	null	sdaːi	\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	\N	\N	1
827	ប្រាជ្ញា	知恵	null	praˑcɲaː	\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	\N	\N	\N
828	កញ្ញា	９月	null	kaɲɲaː	\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	\N	\N	\N
829	បាន	得る	null	baːn	\N	pmod	page010.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
830	ដំបៅ	できもの	null	dɔmbaw	\N	pmod	page010.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
831	ស្រីៗ	女たち	null	srəi srəi	\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
832	ឆ្ងាញ់ៗ	（いろいろな味があって）おいしい	null	cʰŋaɲ	\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	1
833	អីវ៉ាន់	荷物	null	ʔəivan	\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
834	ឥឡូវ	今	null	ʔəiləw	\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
835	តា	祖父	null	taː	\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
836	ទា	あひる	null	tiˑə	\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
837	កាត	身分証明書	null	kaːt	\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	\N
838	គាត	しっかり縛る	null	kiˑət	\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	\N	\N	\N
840	ផ្ទះ	家	null	pʰtɛ̀əh	\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	1
841	ម្ចាស់	主人	null	mcah	\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	1
842	ល្ងាច	夕方	null	lŋiˑəc	\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	\N	\N	\N
843	កន្លែង	場所	null	kɔnlaeŋ	\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
844	សង្ឃឹម	希望する	null	sɔŋkʰɯm	\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	1
845	ភាសា	言語	null	pʰiˑəsaː	\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	1
846	ជម្រាប	告げる	null	cʊmriˑəp	\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	\N	\N	\N
847	គី  កេរ្តិ៍  គឺ  កឺ  ការ  គូ  កូរ  ក	海えび、名誉、即ち、（語なし）、用事、対、かきまぜる、首	null	kiː, keː, kɯː、kəː, kaː, kuː, koː, kɔː	\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
848	គេ  គែ  គើ  គោ  គ	彼ら、のどぼとけ、（語なし）、牛、口のきけない	null	kèː, kɛ̀ː, kə̀ː, kòː, kɔ̀ː	\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
849	កៀរ  កឿ  កើ  កែ  កោរ  គួរ  គភ៌  គះ	かき集める、（語なし）、旗、直す、引き金、剃る、ふさわしい、妊娠している、はねつける	null	kiˑə, kɯˑə, kaə, kae, kao, kuˑo, kɔə, kɛ̀əh	\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
850	ប៉ា  ផា	父、布	null	paː, pʰaː	\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	\N
851	តា  ថា	祖父、～と（言う）	null	taː, tʰaː	\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	1
852	ចារ  ឆា	書く、炒める	null	caː, cʰaː	\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	\N
853	ការ  ខារ	用事、巻き上げる	null	kaː, kʰaː	\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	\N	\N	\N
854	សាប់   សត្វ   សាច់   សក្ដិ	切る　動物　肉　階級	null	sap, sat, sac, sak (saʔ)	\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
855	សាំ  សាន់  សាញ់   សាំង	反復する　鈍い　（語なし）　ガソリン	null	sam, san, saɲ, saŋ	\N	pmod	page028.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	\N	\N	1
856	ផ្សារ	市場	null	pʰsaː	\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
857	ផ្កា	花	null	pʰkaː	\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	\N
858	ច្បារ	庭	null	cʰbaː	\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	\N
859	ឆ្មា	猫	null	cʰmaː	\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	\N	\N	\N
860	ថ្លា	澄んだ	null	tʰlaː	\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	\N	\N	\N
862	ក   កក   កក់   ការ   កី   ក្ដារ   ក្បាល   ក្អែក	首、固まる、洗う、用事、織機、板、頭、カラス	null	kɔː, kɔːk, kɔk, kaː, kəi, kʰdaː, kʰbaːl, kʰʔaek	\N	pmod	page030.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
863	ពេទ្យ	医（者）	null	pɛ̀ːt	\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	\N	\N	1
864	មនុស្ស	人間	null	mɔ̀ˑnuh	\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	\N	\N	1
865	សត្វ	動物	null	sat	\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	\N	\N	1
866	ក្នុងពិភពលោក ភាសាអង់គ្លេសត្រូវគេនិយាយច្រើនជាងគេ។	世界中で英語は最も多くの人に話されている。	\N	\N	\N	vmod	\N	\N	\N	0	1
867	គាត់កក់សំបុត្រកប៉ាល់ហោះទៅបាងកកហើយ។	彼はバンコク行きのチケットを予約した。	\N	\N	\N	vmod	\N	\N	\N	0	1
868	គាត់ត្រូវការសំបុត្រឆ្លងដែន ដើម្បីធ្វើដំណើរទៅបរទេស។	彼は外国に行くには旅券が必要だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
869	ជនបរទេសមកសុំទិដ្ឋាការនៅស្ថានទូតកម្ពុជា។	外国人はビザを申請しにカンボジア大使館に来る。	\N	\N	\N	vmod	\N	\N	\N	0	1
870	ភាសាខ្មែរមានវេយ្យាករណ៍ស្រួល ។	カンボジア語は文法が簡単だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
871	ឥឡូវនៅសៀមរាបមានសណ្ឋាគារច្រើនដុះដូចផ្សិត ។	いま、シアム・リアプでは、雨後の筍のようにホテルが増えている。	\N	\N	\N	vmod	\N	\N	\N	0	1
872	នៅជប៉ុន ខែឧសភាមានថ្ងៃឈប់ជាប់ៗគ្នាច្រើនជាងគេ។	日本では、５月に連休が最も多い。	\N	\N	\N	vmod	\N	\N	\N	0	1
873	ទើបតែឥឡូវនេះ ការធ្វើដំណើរតាមរទេះគោលែងមានទៀតហើយ ។	最近になって、牛車での移動はなくなった。	\N	\N	\N	vmod	\N	\N	\N	0	1
874	យើងធ្វើដំណើរទៅលេងឆ្នេរសមុទ្រជាគ្រួសារ ។	私たちは家族で海辺に旅行に行った。	\N	\N	\N	vmod	\N	\N	\N	0	1
875	ស្ថានទូតសង់បែរមុខទៅសមុទ្រ ។	大使館は海に面して建てられている。	\N	\N	\N	vmod	\N	\N	\N	0	1
876	ខ្ញុំដើរផងរត់ផង ទើបទៅដល់ទាន់ពេល។	私は歩いたり走ったりして、やっと時間に間に合った。	\N	\N	\N	vmod	\N	\N	\N	0	1
877	គាត់មិនពូកែច្រៀង។	彼は歌が下手だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
878	ឆ្មាឆក់ត្រីអាំងយកបាត់រហ័សមើលមិនទាន់។	ネコが目にもとまらぬ早業で焼き魚をひったくり逃げた。	\N	\N	\N	vmod	\N	\N	\N	0	1
879	កង្កែបលោតចូលទឹក។	カエルが水にとびこんだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
880	គាត់មិនចូលចិត្តស្រីៗដើរយប់។	彼は女性が夜遅くまで出歩くのを嫌う。	\N	\N	\N	vmod	\N	\N	\N	0	1
881	ផ្ទះវីឡាធំៗច្រើនមានអាងហែលទឹក។	大きな一軒家には、たいていプールがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
882	ឡានក្រុងមិនរត់តាមមហាវិថីសំខាន់ៗទេ។	バスは大通り沿いには走っていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
883	កង់មីយ៉ាតាធាក់ធូរជាងកង់មីគី។	ミヤタの自転車はミキの自転車よりも蹴りだしが軽い。	\N	\N	\N	vmod	\N	\N	\N	0	1
884	ប៉ូលីសឈរតាមកាច់ជ្រុងថ្នល់។	警察官が交差点に立っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
885	គេចូលចិត្តដាំឈូកក្នុងស្រះដើម្បីឲ្យទឹកស្អាត។	水をきれいにするために池に蓮を植えるのが好まれている。	\N	\N	\N	vmod	\N	\N	\N	0	1
886	ថ្ងៃសៅរ៍ល្ងាចៗ មានមនុស្សដើរលេងតាមមាត់ទន្លេច្រើន។	土曜日の夕方は河岸を歩く人が多い。	\N	\N	\N	vmod	\N	\N	\N	0	1
887	ទឹកទន្លេឡើងខ្លាំងក្នុងខែកញ្ញា។	河は９月に水位が上がる。	\N	\N	\N	vmod	\N	\N	\N	0	1
888	បេនឡានតាក់ស៊ីភ្នំពេញ–តាកែវនៅផ្សារដើមគរ។	プノンペン、タケオ間のタクシー乗り場は、ダウム・コー市場にある。	\N	\N	\N	vmod	\N	\N	\N	0	1
889	ដើម្បីបត់ឆ្វេង គេលើកដៃឆ្វេង។	左折するには、左手を上げる。	\N	\N	\N	vmod	\N	\N	\N	0	1
890	គាត់ពូកែចងក្រវាត់កបានស្អាតណាស់។	彼はネクタイをきれいにしめるのが上手だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
891	ឯកសណ្ឋានសិស្សគឺខោខៀវអាវសឺមីស។	学生の制服は、紺のズボンと白のワイシャツだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
892	ក្រុមហ៊ុនមានច្រើន ការរកស៊ីប្រជែងគ្នាក៏ច្រើន។	会社が多いと、競争も激しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
893	ពាក់អាវធំមើលទៅសង្ហារ។	背広を着ると見た目がよい。	\N	\N	\N	vmod	\N	\N	\N	0	1
894	ឥឡូវខ្ញុំកំពុងរវល់​ សឹមរួចដៃសិន បានទៅ ។	いま、私は忙しいから手が空いたら行きます。	\N	\N	\N	vmod	\N	\N	\N	0	1
895	បណ្ណាល័យរបស់សាលានេះបើកថ្ងៃអាទិត្យ តែបិទថ្ងៃចន្ទ។	この学校の図書館は、日曜日に開館し、月曜日に休館する。	\N	\N	\N	vmod	\N	\N	\N	0	1
896	កាសែតគាំទ្ររដ្ឋាភិបាលគេមិនសូវចង់អាន។	政府を支持する新聞は、あまり読まれない。	\N	\N	\N	vmod	\N	\N	\N	0	1
897	កុំដាក់សញ្ញាបត្រជាច្បាប់ចម្លងភ្ជាប់មកជាមួយពាក្យសុំ។	願書に証明書の写しを添付してはならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
898	យកមេរៀននេះទៅថតចម្លងចែកគ្នារៀន។	この課題をコピーしてみんなで勉強しなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
899	ទស្សនាវដ្តីវិទ្យាសាស្ត្របច្ចេកទេសកំពុងពេញនិយមក្នុងចំណោមយុវសិស្ស។	専門雑誌は若い学生の間で人気がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1050	កុមាររៀនសរសេរនឹងខ្មៅដៃ។	子どもたちは鉛筆で書きかたを習う。	\N	\N	\N	vmod	\N	\N	\N	0	1
900	ផ្សារចាស់មានលក់ផ្លែឈើច្រើនមុខ។	チャハ市場ではたくさんの種類の果物を売っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
901	ផ្សារច្បារអំពៅមានលក់បន្លែបោះដុំ។	チバー・オンパウ市場では、野菜を卸売りしている。	\N	\N	\N	vmod	\N	\N	\N	0	1
902	ក្មេងត្រូវកាន់របស់ដៃពីរ ហុចឲ្យចាស់ៗ។	若い人は物を両手で持って目上の人に手渡さなければならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
903	ហាងលក់បន្លែនេះចូលច្រើនតែបរទេស។	この青果店は、外国人ばかりだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
904	ក្នុងក្រុមគ្រួសារយើង យាយអាយុច្រើនជាងគេ។	私の家族では、祖母が一番年上だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
905	បរិយាកាសក្នុងក្រុមគ្រួសារយើងកក់ក្តៅណាស់។	私の家庭の雰囲気は暖かい。	\N	\N	\N	vmod	\N	\N	\N	0	1
906	ផ្ទះវីឡាម្តុំទួលគោក មានសួនច្បារធំៗ។	トゥオル・コーク近辺の一軒家は広い庭付きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
907	រាល់ថ្ងៃអាទិត្យ ខ្ញុំបោកគក់ខោអាវច្រើន។	毎日曜日、私はたくさん洗濯する。	\N	\N	\N	vmod	\N	\N	\N	0	1
908	សិស្សត្រឡប់ទៅផ្ទះជាក្រុម។	生徒は集団下校する。	\N	\N	\N	vmod	\N	\N	\N	0	1
909	ទូដាក់សៀវភៅនេះវែង ហើយមាន៧ជាន់។	この本棚は、長くて７段ある。	\N	\N	\N	vmod	\N	\N	\N	0	1
910	តុរោងការនីមួយៗ គេរៀបកៅអី១០។	結婚式披露宴のテーブルには、10脚ずつ椅子を用意する。	\N	\N	\N	vmod	\N	\N	\N	0	1
911	មានទូទឹកកកមួយ តែប្រើភ្លើងចុះណាស់។	冷蔵庫ひとつで電気を食う。	\N	\N	\N	vmod	\N	\N	\N	0	1
912	គេជូតកញ្ចក់ដោយប្រើកាសែតចាស់ជ្រលក់ទឹក។	古新聞を水で濡らして窓ガラスを拭く。	\N	\N	\N	vmod	\N	\N	\N	0	1
913	មន្ទីរពេទ្យនេះមាន១០០គ្រែ។	この病院は100床ある。	\N	\N	\N	vmod	\N	\N	\N	0	1
914	យាយក្រោកពីម៉ោង៥ភ្លឺស្តាប់ធម៌តាមរ៉ាត់យ៉ូ។	祖母は朝５時に起き、ラジオで仏法を聴く。	\N	\N	\N	vmod	\N	\N	\N	0	1
915	ម៉ាញេវ៉ាត់ធំ ស្តាប់ពិរោះ។	ワット数の大きいラジカセは、音が良い。	\N	\N	\N	vmod	\N	\N	\N	0	1
916	លួចគេធ្លាប់ដៃ ដេកថ្ងៃធ្លាប់ភ្នែក។	盗みは癖になり、日中は寝ていると目が慣れる。	\N	\N	\N	vmod	\N	\N	\N	0	1
917	ឥឡូវមានប៉ូលិសយាមតាមសាលា។	いまは、学校をお巡りさんが見回る。	\N	\N	\N	vmod	\N	\N	\N	0	1
918	ប៉ូលីសដើរល្បាតតាមកន្លែងស្ងាត់។	警察官が人気のない場所をパトロールする。	\N	\N	\N	vmod	\N	\N	\N	0	1
919	នៅម្តុំផ្សារថ្មីមានមនុស្សកុះករ។	トゥマイ市場にはたくさんの人がいる。	\N	\N	\N	vmod	\N	\N	\N	0	1
920	ឯងត្រូវឈរកន្លែងនេះ កុំទៅណា។	ここに立っていなさい、どこにも行くな。	\N	\N	\N	vmod	\N	\N	\N	0	1
921	ឡានចតត្រង់កន្លែងនោះ ត្រូវប៉ូលីសស្ទូចបាត់។	車をそこにとめると、警察に持っていかれる。	\N	\N	\N	vmod	\N	\N	\N	0	1
922	កន្លែងនោះគ្មានអ្វីសំគាល់ឲ្យស្រួលរកសោះ។	あそこには目印になるようなものが何もない。	\N	\N	\N	vmod	\N	\N	\N	0	1
923	គាត់ថាទុកសៀវភៅខ្ញុំត្រង់នេះ តែនៅឯណាទៅមិនឃើញ?	彼は、私の本をここにおいておくと言ったが、どこにも見当たらない。	\N	\N	\N	vmod	\N	\N	\N	0	1
924	ប៉ុស្ត៍ប៉ូលីសនៅកណ្តាលវាល ស្រួលរកណាស់។	広いところにある交番は探しやすい。	\N	\N	\N	vmod	\N	\N	\N	0	1
925	ខោខ្លីលេចជើងវែង។	短パンから長い脚が見える。	\N	\N	\N	vmod	\N	\N	\N	0	1
926	ចរាចរស្រុកខ្មែរប្រកាន់ស្តាំ។	カンボジアの交通は右側を走る。	\N	\N	\N	vmod	\N	\N	\N	0	1
927	ឡានចង្កូតឆ្វេងស្រួលបើកបរនៅក្នុងស្រុកខ្មែរ។	左ハンドルの車はカンボジアでは運転しやすい。	\N	\N	\N	vmod	\N	\N	\N	0	1
928	សិស្សឈរតម្រៀបគ្នា គោរពទង់ជាតិ។	生徒は整列し、国旗を掲揚する。	\N	\N	\N	vmod	\N	\N	\N	0	1
929	មិត្តល្អកម្ររកបាន។	良友は得がたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
930	ថ្នាក់ទី១១ ចែកជាក្រុមរៀនព្រឹកនិងក្រុមរៀនល្ងាច។	11年生は午前中の組と午後の組に分けられている。	\N	\N	\N	vmod	\N	\N	\N	0	1
931	ក្នុងបន្ទប់រៀនមានបិទពាក្យស្លោកច្រើន។	教室には、たくさんの標語が貼ってある。	\N	\N	\N	vmod	\N	\N	\N	0	1
932	សណ្ឋាគារនេះមានប្រឡោះផ្លូវដើរក្រាលព្រំក្រហម។	このホテルは赤い絨毯を敷いた通路がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
933	សិស្សយកចិត្តទុកដាក់ស្តាប់គ្រូពន្យល់។	生徒は先生の説明に耳を傾けた。	\N	\N	\N	vmod	\N	\N	\N	0	1
934	និសិ្សតចាប់អារម្មណ៍ការសិក្សាភាសាបរទេស។	生徒は外国語の勉強に関心を持っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
935	និស្សិតឆ្នាំទី៤កំពុងចុះកម្មសិក្សា។	４年生は実習に出ている。	\N	\N	\N	vmod	\N	\N	\N	0	1
936	និសិ្សតបរទេសនិយាយភាសាខ្មែរបានល្អណាស់។	留学生はとても上手にカンボジア語を話す。	\N	\N	\N	vmod	\N	\N	\N	0	1
975	គេជឿថាស្រាទំពាំងបាយជូរផឹកទៅល្អនឹងសុខភាព។	ワインは健康にいいと思われている。	\N	\N	\N	vmod	\N	\N	\N	0	1
937	វ៉ាកងធំ សិស្ស និស្សិត ត្រឡប់ទៅជួយការងារស្រែចំការរបស់ឪពុកម្តាយខ្លួន។	夏休みになると、学生たちは帰省して両親の農作業を手伝う。	\N	\N	\N	vmod	\N	\N	\N	0	1
938	សាកលវិទ្យាល័យនេះមានសាខានៅតាមខេត្តចំនួន៥។	この大学は５つの州にキャンパスがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
939	ចូលកងវិញ មានការចែកសៀវភៅសរសេរដល់សិស្សានុសិស្ស។	新学期になると、生徒にノートが配られる。	\N	\N	\N	vmod	\N	\N	\N	0	1
940	ថ្ងៃនេះថ្នាក់គីមីគ្រូមិនបានមកទេ។	今日は、化学の授業で先生が来なかった。	\N		\N	vmod	\N	\N	\N	0	1
941	ក្នុងវិញ្ញាសាតែងសេចក្តី ខ្ញុំបានពិន្ទុមធ្យម។	作文のクラスで、私は平均点だった。	\N	\N	\N	vmod	\N	\N	\N	0	1
942	កិច្ចការផ្ទះធ្វើមិនទាន់ នៅសល់ច្រើន។	宿題が間に合わず、まだたくさん残っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
943	ការខ្សិបសួរគ្នាក្នុងពេលប្រឡង នឹងត្រូវពិន័យ។	試験のときにこっそり相談すると罰を受ける。	\N	\N	\N	vmod	\N	\N	\N	0	1
944	គ្រូដាក់លំហាត់ឲ្យធ្វើនៅផ្ទះ។	先生は宿題を出した。	\N	\N	\N	vmod	\N	\N	\N	0	1
945	ខ្ញុំហាត់សរសេរអក្សរចិន។	私は漢字の書き取りをした。	\N	\N	\N	vmod	\N	\N	\N	0	1
946	សិស្សឆ្លាតមានសំណួរច្រើន។	賢い生徒はよく質問する。	\N	\N	\N	vmod	\N	\N	\N	0	1
947	មានច្បាប់មែន តែសំណួរស្ថិតនៅត្រង់ការអនុវត្តន៍។	法はあっても、問題は実践にある。	\N	\N	\N	vmod	\N	\N	\N	0	1
948	គាត់ឆ្លើយមិនចំសំណួរ។	彼は質問そのものに答えなかった。	\N	\N	\N	vmod	\N	\N	\N	0	1
949	គោអត់មានធ្មេញលើ។	牛には上の歯がない。	\N	\N	\N	vmod	\N	\N	\N	0	1
950	មន្ទីរពេទ្យសម្ភពជាពេទ្យសំរាប់ស្ត្រីមានគភ៌។	産院とは妊婦のための病院である。	\N	\N	\N	vmod	\N	\N	\N	0	1
951	ថ្នាំបុរាណព្យាបាលជម្ងឺបានស័ក្តិសិទ្ធិ។	伝統薬はよく効く。	\N	\N	\N	vmod	\N	\N	\N	0	1
952	គាត់ខ្លាចចាក់ថ្នាំ ចង់លេបថ្នាំគ្រាប់វិញ។	彼は注射がこわく、丸薬の方がのみたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
953	កុំស្លាប់ដូចពស់ កុំរស់ដូចកង្កែប។	ヘビのように死ぬな、カエルのように生きるな。	\N	\N	\N	vmod	\N	\N	\N	0	1
954	ស្រុកខ្មែរមិនប្រើអង្សាហ្វារ៉ិនហៃទេ។	カンボジアでは、華氏を使わない。	\N	\N	\N	vmod	\N	\N	\N	0	1
955	មនុស្សជិះអាស់សង់សឺរច្រើនលើសកំរឹត វាមិនដើរទេ។	制限より多く人がエレベータに乗ると、動かない。	\N	\N	\N	vmod	\N	\N	\N	0	1
956	ឡើងជណ្តើរដល់ជាន់ទី១០ហត់ហារមាត់គឃូស។	10階まで階段を登ると、疲れて息が切れる。	\N	\N	\N	vmod	\N	\N	\N	0	1
957	ស្ថានីយអយស្ម័យានខេត្ត ផ្អាកដំណើរការ។	州の鉄道の駅は、一時休止している。	\N	\N	\N	vmod	\N	\N	\N	0	1
958	គាត់វង្វេងមិនចេះដូររទេះភ្លើងក្រោមដី។	彼は地下鉄の乗換えがわからず迷った。	\N	\N	\N	vmod	\N	\N	\N	0	1
959	បន្ទប់ទឹកសាធារណៈយកលុយ។	公衆便所は有料だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
960	ប្រើបង្គន់ហើយ សូមចាក់ទឹក។	便所を使ったら、水を流してください。	\N	\N	\N	vmod	\N	\N	\N	0	1
961	ផ្លូវរទេះភ្លើងចាស់ទ្រុឌទ្រោម។	鉄道のレールは古くてぼろぼろだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
962	គេរៀបភេសជ្ជៈទទួលភ្ញៀវចូលបុណ្យ។	彼は祭りに来る客に飲み物を用意した。	\N	\N	\N	vmod	\N	\N	\N	0	1
963	ហាងកាហ្វេក៏មានធ្វើគុយទាវ និងបាយដែរ។	喫茶店にもそばや飯がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
964	ក្រូចឆ្មារដើមនេះ ទឹកច្រើន។	この木のライムは、汁が多い。	\N	\N	\N	vmod	\N	\N	\N	0	1
965	ពែងកែវនេះ ផឹកកាហ្វេឆ្ងាញ់ណាស់។	このカップでコーヒーを飲むとおいしい。	\N	\N	\N	vmod	\N	\N	\N	0	1
966	គាត់មិនចេះឆុងតែជប៉ុនទេ ប៉ុន្ដែចូលចិត្ដផឹកតែជប៉ុនណាស់។	彼は日本茶のいれかたを知らないが、日本茶を飲むのは好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
967	ញ៉ាំគុយទាវពេលព្រឹក និងផឹកតែលីបតុងក្រូចឆ្មារ ឆ្ងាញ់ណាស់។	朝のそばとレモンティーはおいしい。	\N	\N	\N	vmod	\N	\N	\N	0	1
968	កាហ្វេទឹកដោះគោផ្អែមស្រាប់ហើយ នៅតែថែមស្ករទៀត?	カフェオレは甘いのにまだ砂糖を入れるの？	\N	\N	\N	vmod	\N	\N	\N	0	1
969	ខ្មែរមិនប្រើចង្កើះសំរាប់ញ៉ាំបាយទេ។	カンボジア人は食事に箸を使わない。	\N	\N	\N	vmod	\N	\N	\N	0	1
970	យួនប្រើចង្កើះស៊ីបាយជំនួសស្លាបព្រា។	ベトナム人はスプーンではなく箸を使って食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
971	ចុងភៅថ្មីស្លអត់ឆ្ងាញ់សោះ។	新しいコックは料理が全然おいしくない。	\N	\N	\N	vmod	\N	\N	\N	0	1
972	គាត់ញ៉ាំនំបុ័ងដាក់សាច់ប៉ាតេរាល់ព្រឹក។	彼は毎朝バゲットサンドを食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
973	ម្ទេសខ្មាំងតូច តែហឹរខ្លាំង។	キダチドウガラシは小さいがとても辛い。	\N		\N	vmod	\N	\N	\N	0	1
976	ម្ហូបអាហារអឺរ៉ុបប្រើទឹកដោះគោច្រើន។	西洋の食事はたくさん牛乳を使う。	\N	\N	\N	vmod	\N	\N	\N	0	1
977	ញ៉ាំសម្លការីជាមួយនំបញ្ចុក និងនំបុ័ង។	そうめんかパンをつけてカレーを食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
978	ទ្វារចូលវត្តពីខាងត្បូងត្រូវគេបិទ។	寺院の南門は閉められている。	\N	\N	\N	vmod	\N	\N	\N	0	1
979	ក្នុងផ្សារគេដើរជាន់ជើងគ្នាមិនចាំបាច់និយាយអត់ទោសទេ។	市場では足を踏んでも謝らなくていい。	\N	\N	\N	vmod	\N	\N	\N	0	1
980	យើងណាត់ជួបគ្នានៅត្រង់ទ្វារចេញ។	出口のところで会おうと約束した。	\N	\N	\N	vmod	\N	\N	\N	0	1
981	ស្រុកខ្មែរមិនទាន់មានប្រអប់សំបុត្រសាធារណៈនៅឡើយទេ។	カンボジアではまだポストがあるわけではない。	\N	\N	\N	vmod	\N	\N	\N	0	1
982	គាត់ទិញកាតប៉ុស្តាល់សំរាប់សរសេរទៅមិត្តគាត់។	彼は友人に書くはがきを買った。	\N	\N	\N	vmod	\N	\N	\N	0	1
983	សំបុត្រទៅកាណាដាបិទតែមប្រ៍ថ្លៃប៉ុន្មាន?	カナダへの郵便にはいくらの切手を貼りますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
984	សុំដូរយកក្រដាស៥.០០០៛មួយសន្លឹក ក្រដាស១.០០០៛ប្រាំសន្លឹក។	5,000リエル紙幣１枚を1,000リエル紙幣５枚に換えてください。	\N	\N	\N	vmod	\N	\N	\N	0	1
985	គាត់កំណាញ់មិនឲ្យខ្ចីរបស់របរគាត់ទេ។	彼はけちで誰にも自分の物を貸さない。	\N	\N	\N	vmod	\N	\N	\N	0	1
986	ទៅទិញអីវ៉ាន់សំរាប់ទៅបុណ្យស្អែក។	明日の祭りに行くために買い物に行く。	\N	\N	\N	vmod	\N	\N	\N	0	1
987	យុវតីនេះចូលចិត្តស្លៀកសំពត់ខើចមុខខើចក្រោយ។	この娘はミニスカートをはくのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
988	ពាក់អាវរងារោមចៀមហើយ នៅមិនបាត់រងាទៀត។	羊毛のセーターを着てもまだ寒い。	\N	\N	\N	vmod	\N	\N	\N	0	1
989	ខែរងានេះ មិនត្រជាក់ដល់ពាក់អាវរងាពេញមួយថ្ងៃទេ។	この冬は一日中コートをきるほど寒くはない。	\N	\N	\N	vmod	\N	\N	\N	0	1
991	ផ្ទះជប៉ុន បន្ទប់ទឹក និងបង្គន់ច្រើនតែនៅដាច់ពីគ្នា។	日本の家はたいてい風呂とトイレが別々にある。	\N	\N	\N	vmod	\N	\N	\N	0	1
992	រាជធានីភ្នំពេញមិនមានអគារខ្ពស់ស្កឹមស្កៃច្រើនទេ។	首都プノンペンには高層ビルがそれほどない。	\N	\N	\N	vmod	\N	\N	\N	0	1
993	ផ្ទះបាយត្រូវសង់ដាច់ពីកន្លែងនៅ កុំឲ្យធំក្លិនផ្សែង។	台所は煙でくさくならないように居間から離すべきだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
994	ក្រោយលេងកីឡា យើងនាំគ្នាងូតទឹកផ្កាឈូក។	スポーツの後はシャワーを浴びる。	\N	\N	\N	vmod	\N	\N	\N	0	1
995	ការរស់នៅក្នុងក្រុងកំពុងជួបបញ្ហាស្ទះចរាចរ។	都市の生活では交通渋滞の問題がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
996	ក្រុងភ្នំពេញមានសួនច្បារសាធារណៈច្រើន។	プノンペン市には公園がたくさんある。	\N	\N	\N	vmod	\N	\N	\N	0	1
997	ទ្វារនេះធ្វើពីដើមផ្ចឹក។	このドアは沙羅双樹でできている。	\N	\N	\N	vmod	\N	\N	\N	0	1
998	គាត់ទិញសំបុត្រដើម្បីចូលត្រាំទឹកក្ដៅ។	彼は入浴券を買った。	\N	\N	\N	vmod	\N	\N	\N	0	1
999	ផ្ទះល្វែងសង់ជាប់ៗគ្នាត្រង់ភ្លឹងតាមដងមហាវិថីធំៗ។	アパートは大通りに沿って密着しあって建てられている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1001	គ្រូៗសាលានេះកំពុងជួបគ្នា ដើម្បីរើសប្រធានរបស់ពួកគេ។	この学校の教師が校長選出のために集まっている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1002	ពួកខ្ញុំមិនសុខចិត្តនឹងទង្វើរបស់លោកឯងទេ។	私たちはあなたのしたことに同意できない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1003	អ្នកណាគេថ្លើមធំហ៊ានហែកសំបុត្រយើងមើល?	誰が我々の手紙を破れるものか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1004	លោកអញ្ជើញពីខាងណាមានការអ្វីដែរបាទ?	どちらからいらして何のご用でしょうか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1005	យើងមិនបានធ្វើអ្វីដែលគាត់ឯងចោទនោះទេ។	私たちはきみが非難するようなことをしていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1006	ហាងយើងមានស្រា និងស្រាបៀគ្រប់ប្រភេទ តើត្រូវការអ្វីចាស?	私どもの店にはあらゆる種類の酒とビールがありますが、何になさいますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1007	ថង់នេះក្រាស់មែន តែផុយ។	この袋は本当に厚いがもろい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1008	ផ្ទះចង្អៀត តែចិត្តម្ចាស់ផ្ទះទូលាយ។	家は狭いが家の主人の心は広い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1009	ក្មេងនេះស្គម ព្រោះអត់អីហូប។	この子は食べるものがなくてやせている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1010	ថៅកែចិនធាត់ដុះក្បាលពោះស៊្អុយ។	中国人社長は太って腹がでている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1011	ខំរៀនទាន់ខ្លួននៅក្មេង។	若いうちに一生懸命勉強しなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1012	ផ្ទះនេះទូលាយ គ្មានតុទូអ្វីទេ។	この家は広く、家具がない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1013	ជួរភ្នំដងរែកស្ថិតនៅឆ្ងាយពីទីរួមខេត្ត។	ドンレーク山脈は州都から遠くにある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1014	កាបូបនេះធ្ងន់ណាស់យួរមិនរួចទេ។	このかばんはとても重くて持ち上げられない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1015	នៅខែក្ដៅ គេស្លៀកពាក់អាវស្ដើង។	夏には薄い服を着る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1016	ពេលចេញលេង សិស្សស្រែកលេងអឺងកង។	外に出ると生徒たちはにぎやかに叫んだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1017	ឆ្កែឈរ ទាបជាងអង្គុយ។	犬は立つと座っているより背が低い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1018	មេឃស្រឡះផ្កាយរះភ្លឺព្រោងព្រាត។	空は晴れて星がぴかぴかと明るく輝く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1019	គាត់ងើបពីឈឺ មានកម្លាំងខ្សោយ។	彼は病気が治ったばかりでまだ弱っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1020	ស្ថានភាពសង្គមកាន់តែអាក្រក់ទៅៗ។	社会の状況はますます悪くなっていく。	\N	\N	\N	vmod	\N	\N	\N	0	1
1021	មេឃងងឹតជិតភ្លៀង។	空が暗くて雨が降りそうだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1022	អង្គប្រជុំចាប់ផ្ដើមហើយ សូមស្ងាត់។	会議が始まります。静かにしてください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1023	ផ្ទះឡើងកខ្វក់ អត់បោសជូតសោះ។	家が汚くなって、掃除をしていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1024	ថ្ងៃនេះ ពួកម៉ាកមិនមកលេងផ្ទះ អផ្សុកណាស់។	今日は友だちが家に遊びに来ないので退屈だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1025	ផ្លូវជាតិនេះធំ ទទឹងផ្លូវបើកឡាន៤ទន្ទឹមគ្នាបាន។	この国道は広くて４車線分ある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1026	ផ្ទៃរាងត្រីកោណ ស្មើនឹងបាតគុណនឹងកំពស់ ហើយចែកនឹង២។	三角形の面積は底辺と高さの積を２で割る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1027	ដីឡូនេះមានក្បាល៣០ម៉ែត្រ បណ្ដោយ៥០ម៉ែត្រ។	この土地は区画が30メートルで、縦が50メートルだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1028	ប្រទេសខ្មែរមានព្រំប្រទល់ខាងលិចទល់នឹងប្រទេសថៃ និងឈូងសមុទ្រសៀម។	カンボジアは、西の国境が、タイとシャム湾に面している。	\N	\N	\N	vmod	\N	\N	\N	0	1
1029	គេដេកបែរក្បាលទៅត្បូង។	南枕で寝る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1030	នៅស្រុកជប៉ុន បងប្អូនជីដូនមួយគេមិនសូវរាប់គ្នាដូចនៅស្រុកខ្មែរទេ។	日本では、カンボジアほどいとこどうしが親しく付き合わない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1031	គាត់មានបងប្អូនប្រុស៣នាក់​ហើយគាត់ជាកូនច្បង។	彼は男兄弟が３人いて長男だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1032	ឳពុកម្ដាយធ្វើការឥតស្រាក ដើម្បីចិញ្ចឹមកូន។	両親は子どもたちを養うために休みなく働いた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1033	បងប្អូនស្រីគេនេះ មិនដែលឈ្លោះទាស់គ្នាទេ។	この姉妹は喧嘩をしたことがない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1034	កូនសិស្សនេះមិនទាន់ចេះពាក់ស្រោមជើងនៅឡើយ។	この生徒はまだ靴下がはけない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1035	កុមារីចេះប៉ាក់ផ្កាលើកន្សែងដៃ។	少女はハンカチに花を刺繍できる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1036	ពាក់ស្បែកជើងផ្ទាត់ ផ្ទាត់ភក់ប្រឡាក់ខោអស់។	サンダルをはいて泥を蹴ってズボンを汚した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1037	ភ្លៀងខ្យល់ខ្លាំង បាំងឆត្រមិនជិតទេ។	雨風が強く傘をさせない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1038	អាចារ្យនេះពាក់អាវកាប៉ៅ៤។	この祭司はポケットが４つあるシャツを着ている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1039	ផ្ទះខ្ញុំមាត់ច្រើនណាស់ មួយខែស៊ីអស់អង្ករមួយបាវ។	私の家は口が多く、月に米を１袋（60キロ）食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1040	គាត់ផ្ដាសាយតឹងច្រមុះ និយាយសម្លេងក្ងួរ។	彼は風邪をひいて鼻がつまり鼻声で話した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1041	គាត់ចូលចិត្តក្លែមស្រាជាមួយកង្កែបចៀនបឺរ។	彼はカエルのムニエルで酒を飲むのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1043	ញ៉ាំបាយថ្ងៃត្រង់ហើយ គាត់តែងតែសំរាកថ្ងៃ។	昼食後は、彼は昼寝をする習慣だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1044	បាយល្ងាចសំបូរម្ហូបជាងបាយថ្ងៃត្រង់។	夕食は昼食より料理の品数が多い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1045	មុនទៅស្រែ គាត់ហូបបបរច្រូចទឹកស៊ីអ៊ីវ។	田んぼに出る前に彼は醤油粥を食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1046	អំបិលក្រាមផលិតនៅកំពត សល្អ។	カンポートの結晶塩は白くて品質が良い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1047	គាត់ចង់ស្គម រាល់បាយល្ងាច ហូបតែបបរសត្រីងៀតប៉ុណ្ណោះ។	彼は痩せたくて、夕食は魚の干物の白粥しか食べない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1048	បបរស្ករនេះ បើថែមអំបិលបន្ដិច វានឹងផ្អែមឆ្ងាញ់។	この甘粥は、塩を少し入れれば、甘さがひきたつ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1049	កាមេរ៉ាផលិតនៅស្រុកជប៉ុន តូចៗស្អាតណាស់់	日本製のカメラは小さくてかっこいい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1051	បើមិនពាក់វ៉ែនតា គាត់មើលអក្សរមិនឃើញទេ។	眼鏡をかけないと、彼は文字が読めない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1052	ហាងលក់ម៉ាញេថតសម្លេងជជុះ មានមនុស្សច្រើន។	中古テープレコーダーを売る店は客がいっぱいだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1053	នាឡិកាប៉ោលវាយម៉ោង១២ថ្ងៃត្រង់។	振り子時計が正午１２時を打った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1054	ឥឡូវមិនងាយរកទិញហ្វីលម៍សខ្មៅទេ។	いま、白黒フィルムを買うのは難しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1055	ទំនប់នេះមានទឹកពេញព្រៀប ត្រូវការបើកទ្វារទឹកបញ្ចេញខ្លះ។	このダムは水があふれそうで、水門をあけて水を流さなくてはいけない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1056	ពីខ្លោងទ្វារវត្ត ទៅដល់វត្ត ចម្ងាយ១គីឡូម៉ែត្រ។	門から寺まで１キロある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1057	សូមគូសចំណាំដោយប៊ិកផឺតទឹកលុបមិនជ្រះ។	洗ってもおちないインクのボールペンで線をひいて覚えなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1059	គាត់រកទិញប៊ិកថ្លៃៗ ដើម្បីធ្វើជាកាដូ។	彼は贈り物にしようと、高いボールペンを買った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1060	ជួនកាល កូនរដូវប្រាំងមានក្នុងខែសីហា។	８月にはときどき、雨季の最中に小さな乾季がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1061	ជនជាតិខ្មែរចូលឆ្នាំថ្មី នៅថ្ងៃទី១៣ឬ១៤​ ខែមេសា។	カンボジアでは、４月13日か14日に新年を迎える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1062	ខែនេះ មានថ្ងៃឈប់ច្រើន។	今月は休日が多い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1063	រាល់ខែ នៅសប្ដាហ៍ទី១ មានការប្រជុំការងារ។	毎月第一週には会議がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1064	ដើរលេងតាមស្រុកស្រែក្នុងខែធ្នូ គេឃើញស្រូវទុំក្រហមពេញស្រែ។	12月に田園地帯を歩くと、実った稲穂が見える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1065	ថ្ងៃទី១៤ខែកុម្ភៈជាទិវានៃសេចក្ដីស្រឡាញ់។	２月14日は愛の日だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1066	ខែមករាមានអាកាសធាតុត្រជាក់ស្ងួតស្រួលដើរកំសាន្ដ។	１月は気候が乾燥して涼しく、旅行しやすい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1067	ខែកក្កដាជាខែមានប្រឡងច្រើន។	７月は試験がたくさんある月だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1068	នៅជប៉ុន ខែមិថុនាជារដូវភ្លៀងធ្លាក់សស្រិច។	日本では、６月はしとしとと雨が降る季節だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1069	សប្ដាហ៍មាសក្នុងដើមខែឧសភា មានថ្ងៃឈប់បន្ដបន្ទាប់គ្នា។	５月はじめのゴールデンウィークは連休がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1070	យើងនាំគ្នាទៅលេងឆ្នេរសមុទ្រ នៅពាក់កណ្ដាលខែមីនា។	３月の半ばに海辺に旅行した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1071	ខែមុន ខ្ញុំមិនបានដើរលេងសោះ។	先月はまったく出歩かなかった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1072	ខែវិច្ឆិកា ខ្យល់ធ្លាក់ពីជើង រហើយណាស់។	11月は北風が吹いて涼しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1073	ទឹកទន្លេមេគង្គឡើងខ្ពស់អតិបរមាក្នុងខែកញ្ញា។	メコン川の水位は９月に最高になる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1074	អាទិត្យនេះ យើងមានសិក្ខាសាលា។	今週はシンポジウムがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1075	រាល់អាទិត្យ គាត់ទៅវត្ត១ដងយ៉ាងតិច។	彼は毎週最低１回は寺におまいりする。	\N	\N	\N	vmod	\N	\N	\N	0	1
1076	សិស្សឆ្លៀតធ្វើការថ្ងៃអាទិត្យ ដើម្បីរកកម្រៃ។	学生は日曜日にアルバイトをする。	\N	\N	\N	vmod	\N	\N	\N	0	1
1077	សាលាបឋមសិក្សាខ្លះ ឈប់រៀនថ្ងៃព្រហស្បតិ៍។	小学校は木曜日が休みだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1078	ជាទូទៅថ្ងៃចន្ទ ក្មេងច្រើនយំក្រាញមិនទៅសាលា។	一般に月曜日には子どもたちは学校に行きたくないと泣く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1079	តាមជំនឿ គេមិនបូជាសពថ្ងៃអង្គារទេ។	火曜日には葬式をしないことになっている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1080	សិស្សនេះធ្វើពុតឈឺមិនទៅរៀនថ្ងៃពុធ។	この学生は仮病を使って水曜日に学校を休んだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1081	អាទិត្យមុន យើងមិនបានឈប់១ថ្ងៃសោះ។	先週は一日も休まなかった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1082	រាល់ល្ងាចថ្ងៃសុក្រ សិស្សម្នាក់ៗសប្បាយចិត្ត។	金曜日の夕方は学生たちは嬉しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1084	ឆ្នាំនេះ មានការប្រកួតបាល់ទាត់ពិភពលោក។	今年はサッカーのワールドカップがあった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1085	រាល់ឆ្នាំ ប្រទេសនេះប្រារព្ធបុណ្យឯករាជ្យតាមខេត្តនីមួយៗរបស់ខ្លួន។	毎年この国では州ごとに独立記念日を祝う。	\N	\N	\N	vmod	\N	\N	\N	0	1
1086	រដូវក្ដៅនៅតូក្យូ ក្ដៅស្អុះណាស់។	東京の夏は蒸し暑い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1087	រដូវរងាឆ្នាំនេះ ក្ដៅជាងធម្មតា។	今年の冬は例年より暖かい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1088	វិស្សមកាលឆ្នាំមុន យើងបានទៅលេងអង្គរវត្ត។	去年の夏休み、アンコール・ワットに行った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1089	បវេសនកាលឆ្នាំក្រោយ គាត់ចូលរៀនថ្នាក់បណ្ឌិត។	来年度彼は博士課程に入学する。	\N	\N	\N	vmod	\N	\N	\N	0	1
1090	រដូវផ្ការីក មានទេសភាពស្រស់បំព្រង។	春は景色が明るく美しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1091	គាត់នឹងចូលនិវត្តន៍ពីរឆ្នាំក្រោយ។	再来年、彼は定年を迎える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1092	ដើមឈើដែលដកដាំកាលពីឆ្នាំទៅមួយ ចេញផ្កាហើយ។	一昨年植え替えた木に花が咲いた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1093	ម៉ោង៥ពេលល្ងាច សិស្សគោរពបង្ហូតទង់ជាតិចុះ។	午後５時に学生たちは国旗をおろす。	\N	\N	\N	vmod	\N	\N	\N	0	1
1094	គាត់ថាថ្ងៃស្អែកនឹងសងលុយវិញ តែស្អែកមួយពាន់ដង។	彼は明日金を返すと言ったが、もう明日は1000回目だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1095	យប់មិញ ដេកជ្រុលមិនបានមើលរឿងតាមទូរទស្សន៍។	ゆうべは寝過ごしてテレビの映画を見損ねた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1096	ពេលព្រឹកម៉ោង៧កន្លះ ជាពេលគោរពទង់ជាតិ។	朝７時半は国旗掲揚の時間だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1097	នៅជប៉ុន គាត់ញ៉ាំអាហារពេលព្រឹកប្រញាប់ពេកសឹងតែច្រកអាហារខុសមាត់។	日本では彼は朝食を急いで食べ過ぎて喉につかえそうになる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1098	ញ៉ាំបាយពេលថ្ងៃហើយ ទន់ត្របកភ្នែក។	昼食を食べるとまぶたが重くなる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1099	ពេលយប់ គាត់មកពីធ្វើការវិញម៉ោង១១។	夜彼は11時に仕事から帰宅する。	\N	\N	\N	vmod	\N	\N	\N	0	1
1100	ពេលល្ងាចព្រះអាទិត្យហៀបលិច បក្សាបក្សីវិលរកទ្រនំ។	夕方日が沈む頃鳥たちはねぐらに帰る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1101	ថ្ងៃនេះមិនមករៀន ថ្ងៃស្អែករវល់ បើខានស្អែកមិនមកទេ ពួកយើងមិនអត់អោនឲ្យគាត់ទេ។	今日は授業に来ない、明日は忙しい、もし明後日来なければ、私たちは彼を許さない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1102	រថភ្លើងរត់ទៀងម៉ោងណាស់ តែពេលខ្លះក៏មានយឺតដែរ។	電車は時刻に正確だが、ときどき遅れる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1103	ក្នុងថ្នាក់នៅពេលជិតដល់ម៉ោង សិស្សនៅស្ងៀមចាំគ្រូឲ្យចេញទៅផ្ទះ។	教室で授業の終わりの時間が近づくと生徒たちは先生が終わりの合図をするのを静かに待つ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1104	ទិញបារីនេះមួយសុង គេលើសឲ្យចានគោះបារីមួយ។	このタバコを１買うと、灰皿がもらえる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1105	សម័យនេះ គេឈប់ប្រើថាសចម្រៀងចាក់ពិគុបទៀតហើយ។	近年では、レコードが使われなくなった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1106	គាត់ដេញហ្គីតាស្ទាត់ណាស់។	彼は上手にギターを弾く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1107	លោកតាពូកែដេញចាប៉ី ហើយច្រៀងពិរោះទៀត។	老人は上手にチャパイを弾き、美しい声で歌う。	\N	\N	\N	vmod	\N	\N	\N	0	1
1108	ភោជនីយដ្ឋាននេះ មានគេប្រគំភ្លេងកំដរផងដែរ។	このレストランでは音楽の演奏もある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1109	ផ្ទាំងគំនូរដ៏រស់រវើកមួយនេះ គូរដោយលោកញឹក ឌឹម។	この生き生きとした絵は、ニュク・ドゥム氏によるものである。	\N	\N	\N	vmod	\N	\N	\N	0	1
1110	ដើម្បីសុំទិដ្ឋាការ គេត្រូវការរូបថត៤x៦ មួយសន្លឹក។	ビザの申請には、４ｘ６の写真が一枚必要だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1111	នាងមានសំឡេងស្រួយដូចសារិកា។	彼女は九官鳥のようなよく通る声だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1112	មេឃស្រឡះគ្មានពពកមួយដុំសោះ។	空は晴れて雲ひとつない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1113	ក្រោយភ្លៀងមួយមេ មេឃស្រឡះ។	一降りした後、空は晴れた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1114	យប់ត្រជាក់ ធ្លាក់សន្សើមជោគស្មៅ។	涼しい夜には露が草を濡らす。	\N	\N	\N	vmod	\N	\N	\N	0	1
1115	ព្រឹលធ្លាក់សក្បុសលើដំបូលផ្ទះ។	雪が屋根に真っ白に降る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1116	អាកាសធាតុមនោរម្យលើកំពូលភ្នំបូកគោ។	ボコー山上では気候は心地良い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1117	ដោយសារឡកំដៅប្រើឧស ក្នុងផ្ទះនេះក្ដៅស្រួលណាស់។	薪ストーブのおかげで家の中は心地良く暖かい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1118	កសិករសាស្រូវ ព្រោះមេឃស្រទំជិតភ្លៀង។	空が曇って雨が降りそうなので、農民は稲をとりこんだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1119	ទឹកជ្រោះត្រជាក់ហូរធ្លាក់ពីខ្នងភ្នំ។	冷たい谷川の水が、山頂から流れ落ちる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1120	យើងបន់ឲ្យមេឃស្រទំ ព្រោះថ្ងៃក្ដៅពេក។	あまりにも暑くて、曇るように願った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1121	ក្នុងសង្កាត់ចិន គេឃើញមានយីហោអក្សរចិនព្រោងព្រាត។	中華街では、漢字の屋号をたくさん見かける。	\N	\N	\N	vmod	\N	\N	\N	0	1
1122	គាត់សម្រាយអត្ថបទនេះពីពាក្យកាព្យ។	彼はこの文章を韻文から訳した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1123	ក្មេងៗស្ដាប់ចំហរមាត់លោកតានិទានរឿងសុភាទន្សាយ។	子どもたちは、おじいさんがうさぎの裁判官の物語を語るのを口をあけて聞いた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1124	ហ្វូងមនុស្សកកកុញទៅមើលបុណ្យអុំទូក។	大勢の人が水祭りを見に行った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1125	ចាស់ទុំផ្សំផ្គុំឲ្យបានគ្នាជាប្ដីប្រពន្ធ។	年配者が夫婦として娶わせる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1126	ការងារជាប្ដីគឺ រកឧស ភ្ជួររាស់ ឡើងត្នោត។	夫の務めは、薪を探し、耕し、ヤシの木に登ることである。	\N	\N	\N	vmod	\N	\N	\N	0	1
1127	អ្នកភូមិទាំងអស់គ្នារួមគ្នាលើកថ្នល់។	村人たちはみんなで道路を作った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1128	គោនេះឈ្មោះអាត្នោត ព្រោះមានសម្បុរត្នោតទុំ។	この牛は茶色なので、「茶」という名前だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1129	ការរើសអើងពណ៌សម្បុរគឺខុសច្បាប់។	肌の色で差別することは法に反している。	\N	\N	\N	vmod	\N	\N	\N	0	1
1130	លោកសង្ឃគ្រងចីពរពណ៌លឿង។	僧侶は黄色い衣をつけている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1131	មេឃក្រហមព្រឿងៗឯកើត បក្សីស្រែកខ្ញៀវខ្ញារ។	東の空が黄味がかった赤になると、鳥たちはにぎやかにさわぐ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1132	ពណ៌លឿង និងពណ៌បៃតងជាពណ៌ជាតិរបស់ប្រទេសប្រេស៊ីល។	黄色と緑色は、ブラジルの国旗の色だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1133	ផ្ទះគាត់នៅជិតស្ថានីយរថភ្លើង ងាយស្រួលធ្វើដំណើរណាស់។	彼の家は駅に近く移動に便利だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1134	យើងរៀបចំជប់លៀងទទួលស្វាគមន៍និសិ្សតចូលថ្មី។	新入生の歓迎パーティーの用意をした。	\N	\N	\N	vmod	\N	\N	\N	0	1
1135	ការសេពគប់មិត្តល្អ ធ្វើឲ្យកូនគាត់ក្លាយជាក្មេងស្លូតបូត។	良い友人との付き合いが、彼の子をおとなしい子にした。	\N	\N	\N	vmod	\N	\N	\N	0	1
1136	ឡាននេះអស់អាគុយ ទាល់តែរុញទើបបញ្ឆេះឆេះ។	この車はバッテリーがあがって押しがけしないとエンジンがかからない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1137	សន្និបាតនេះចាប់ផ្ដើមឡើង បន្ទាប់ពីរដ្ឋមន្ដ្រីប្រកាសបើកហើយ។	この会議は大臣の開会の辞で始まった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1138	ស្គរវត្តបន្លឺនៅម៉ោង១២គត់ថ្ងៃត្រង់។	寺の太鼓は正午ちょうどに鳴る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1139	ស្លឹកឈើនឹងថ្កល់ គ្មានខ្យល់បន្ដិចសោះ។	風が全くないので、葉が動かない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1140	គាត់ជាគ្រូដែលល្បីថាកាចជាងគេ។	彼女は一番厳しいという評判の先生だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1141	ឥឡូវនេះ ខ្ញុំសូមឧទ្ទេសនាមជូនអំពីនិក្ខេបបទខ្ញុំ។	では卒論の発表を始めます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1142	សំណាងឧស្សាហ៍ចូលមកញឹកញយសួរលោកសួន។	ソムナーンはしばしばスオン氏を訪ねてきた。	\N		\N	vmod	\N	\N	\N	0	1
1150	គ្រាន់តែចូលទៅក្នុងបន្ទប់ភ្លាមលោកចាក់សោភ្លាម។	部屋に入るや否や、彼はすぐに鍵を閉めた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1151	ខ្មែរប្រើស្លាបព្រានិងសមសំរាប់ញ៉ាំបាយ។	カンボジア人はスプーンとフォークで食べる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1153	ទៅផ្សារទិញអាវថ្មី។	デパートに新しい服を買いに行く。	\N	\N	\N	vmod	\N	\N	\N	0	1
1154	ផ្លូវខ្សាច់មួយ សំរាប់នាំអ្នកដើរចុះពីថ្នល់ធំទៅកាន់ជណ្ដើរឈើដែលលាបពណ៌ខៀវចាស់។	一本の道が、広い道からおりた人を濃い緑色で塗った木の階段へ導いていた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1155	គាត់ទៅជាមួយបងប្រុសគាត់។	彼は兄と一緒に行った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1156	ក្សិណនោះ ស្រីម្នាក់បានឡើងមកឲ្យដំណឹងនាងថា សង្សារនាងគេមានប្រពន្ធថ្មីទៀតហើយ។	その時、一人の女が、彼女の恋人には既に新しい奥さんがいるという知らせを持ってきた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1157	ម្ដាយនាងឈឺពេញដប់ខែ ស្រែនាងទាំងប៉ុន្មាននាងលក់មើលរោគម្ដាយអស់។	彼女の母が１０か月寝込むと、彼女は田んぼをすべて売り払い看病にあてた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1159	ខ្ញុំមានពូ៣នាក់។	私には叔父が３人いる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1160	នាងម៉ានយ៉ានជាបងស្រីបង្កើតរបស់ណារិន។	マンヤーンはナルンの実の姉だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1162	បើរបស់អ្នកមីងឬលោកប៉ា ម្ដេចក៏អញមិនដែលឃើញ?	もし叔母さんかお父さんのものなら、なぜこれまで目にしたことがないんだろう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1163	បន្តិចមកសូផាតប្រដាប់ដោយខោអាវដូចអ្នកស្រែធម្មតាគឺពាក់មួកខ្មៅហាមធំ អាវចិនខោចិនខ្មៅយ៉ាងជំនុំ ស្ពាយបង្វិចតូចមួយដើរបៀមបារីស្លឹកសង្កែកាន់ជន្លួញនៅដៃ។	ソパートは、普通の農民と同じ格好をして、つばの広い黒い帽子をかぶり、黒い中華風の上下を着て、タバコをくわえ、棒を手にした。	\N	\N	\N	vmod	\N	\N	\N	0	1
1164	គាត់លុបអក្សរចោល។	彼は文字を消した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1165	គេសប្បាយនឹងស្ដាប់ចម្រៀងយ៉ាងពីរោះ។	人々は美しい歌を楽しんだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1166	នាងសម្រាលបានកូនប្រុសរូបល្អសមសួន។	彼女は美しい男の子を生んだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1167	គាត់់ឱបរឹតកូន។	彼は子どもを抱きしめた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1168	ផ្លូវហ្នឹងហើយចៅ ចៅដើរឲ្យត្រង់ទៅ។	その道だよ。まっすぐ歩いていきなさい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1169	សូផាតដោះចិញ្ចៀនទុកនៅក្បែរពាងទឹក។	ソパートは指輪をはずして水がめの隣に置いた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1170	នាងទាំងពីរចុះតាមជណ្ដើរក្រោយ។	二人は、後ろの階段から降りた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1172	មិនយូរប៉ុន្មានគេក៏ឮសូររថយន្តមួយបើកមកឈប់នៅចំមុខផ្ទះ។	しばらくすると、車が家のすぐ前にとまる音がした。	\N	\N	\N	vmod	\N	\N	\N	0	1
75	អ្នកខ្លះ	人＋いくつかの＝人によっては～	null	ネアック・クラハ　nɛ̀ək kʰlah	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
163	សៀវភៅនៅសាលា។	本＋ある＋学校＝本は学校にある。	null	シアウパウ・ナウ・サラー　siˑəwpʰə̀w nə̀w saːlaː	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
228	ចង់រៀន។	たい＋学ぶ＝学びたい。	null	チョン・リアン　cɔŋ riˑən	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
382	ខ្ញុំមានសៀវភៅ។	私＋ある＋本＝私は本を持っている。	null	クニョム・ミアン・シアウパウ　kʰɲom miˑən siˑəwpʰəw	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
441	ជំរាបសួរ លោកគ្រូ	こんにちは、先生。	挨拶する		\N	dmod	km01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
461	បាទ យល់ហើយ។	はい、わかりました。	謝る		\N	dmod	km03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
568	ចាស ចេះ។	はい、使えます。			\N	dmod	km15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
620	ចាស មានអី។ 	いいですよ。			\N	dmod	km21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
740	ខ្ញុំឈ្មោះ កាន់ដា។	神田です。			\N	dmod	km34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
974	ហាងបាយតាមសាលាលក់ថោក។	学食は安い。	\N	\N	\N	vmod	\N	\N	\N	0	1
990	អាវធំនេះធ្វើពីឡែន។	この上着はウールでできている。	\N	\N	\N	vmod	\N	\N	\N	0	1
785	កុំអី យកកាហ្វេក្ដៅ។	いいえ、ホットをお願いします。			\N	dmod	km38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: km
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	1	行く	1	1
2	2	英語	1	1
3	3	飛行機	1	1
4	4	外国	1	1
5	5	外国人	1	1
6	6	カンボジア語	1	1
7	7	ホテル	1	1
8	8	日本語	1	1
9	9	出掛ける	1	1
10	10	国（くに）	1	1
11	11	会う	1	1
12	12	休み	1	1
13	13	旅行	1	1
14	13	旅行する	1	1
15	14	遊ぶ	1	1
16	15	大使館	1	1
17	16	大好き	1	1
18	17	好き	1	1
19	18	上手（じょうず）	1	1
20	19	走る	1	1
21	20	ゆっくり	1	1
22	21	下手（へた）	1	1
23	22	歩く	1	1
24	23	泳ぐ	1	1
25	24	速い［スピードが～］	1	1
26	25	飛ぶ	1	1
27	26	スポーツ	1	1
28	27	嫌い	1	1
29	28	プール	1	1
30	29	バス	1	1
31	30	自転車	1	1
32	31	交差点	1	1
33	32	道（みち）	1	1
34	33	池	1	1
35	34	散歩	1	1
36	35	かわ（川・河）	1	1
37	36	タクシー	1	1
38	37	自動車，車（くるま）	1	1
39	38	曲がる	1	1
40	39	ネクタイ	1	1
41	40	ワイシャツ	1	1
42	41	会社	1	1
43	42	背広	1	1
44	43	やる	1	1
45	44	吸う	1	1
46	45	電話	1	1
47	46	仕事	1	1
48	47	働く・勤める	1	1
49	48	忙しい	1	1
50	49	図書館	1	1
51	50	辞書，字引	1	1
52	51	借りる	1	1
53	52	新聞	1	1
54	53	読む	1	1
55	54	本	1	1
56	55	コピー	1	1
57	56	コピーする	1	1
58	57	雑誌	1	1
59	58	冊	1	1
60	59	牛肉	1	1
61	60	安い	1	1
62	61	店	1	1
63	62	高い	1	1
64	63	いくつ	1	1
65	63	いくら	1	1
66	64	果物	1	1
67	65	野菜	1	1
68	66	魚	1	1
69	67	豚肉	1	1
70	68	鳥肉	1	1
71	69	肉	1	1
72	70	欲しい	1	1
73	71	渡す	1	1
74	72	八百屋	1	1
75	73	かぎ（鍵）	1	1
76	74	料理	1	1
77	75	買い物する	1	1
78	76	洗濯する	1	1
79	77	掃除する	1	1
80	78	家族	1	1
81	78	家庭	1	1
82	79	庭（にわ）	1	1
83	80	洗濯	1	1
84	81	うち（家）	1	1
85	81	家（いえ）	1	1
86	82	掃除	1	1
87	83	かえる（帰・返）	1	1
88	84	本棚	1	1
89	85	机	1	1
90	86	椅子（いす）	1	1
91	87	部屋	1	1
92	88	冷蔵庫	1	1
93	89	洗う	1	1
94	90	ベッド	1	1
95	91	ラジオ	1	1
96	92	ラジカセ	1	1
97	93	～という名前です	1	1
98	94	寝る	1	1
99	95	起きる	1	1
100	85	テーブル	1	1
101	96	テレビ	1	1
102	97	お巡りさん	1	1
103	98	警官	1	1
104	99	地図	1	1
105	100	そば	1	1
106	101	ここ,こちら, こっち	1	1
107	102	そこ,そちら, そっち	1	1
108	102	あちら, あっち，あそこ	1	1
109	103	どこ,どちら,どっち	1	1
110	104	交番	1	1
111	105	近く	1	1
112	106	隣	1	1
113	107	きく	1	1
114	108	切る	1	1
115	109	短い	1	1
116	110	後ろ	1	1
117	111	前	1	1
118	112	右	1	1
119	113	左	1	1
120	114	長い	1	1
121	115	座る	1	1
122	116	立つ	1	1
123	117	友達	1	1
124	118	クラス	1	1
125	119	教室	1	1
126	120	廊下	1	1
127	121	学校	1	1
128	122	生徒	1	1
129	123	勉強	1	1
130	124	学生	1	1
131	125	留学生	1	1
132	126	夏休み	1	1
133	127	先生	1	1
134	128	大学	1	1
135	129	ノート	1	1
136	118	授業	1	1
137	130	作文	1	1
138	131	宿題	1	1
139	132	難しい	1	1
140	133	教える	1	1
141	134	テスト	1	1
142	135	練習	1	1
143	136	易しい	1	1
144	137	練習する	1	1
145	138	質問	1	1
146	138	問題	1	1
147	139	答える	1	1
148	140	痛い	1	1
149	141	歯	1	1
150	142	医者	1	1
151	143	病院	1	1
152	144	病気	1	1
153	145	薬（くすり）	1	1
154	146	死ぬ	1	1
155	147	風邪（かぜ）	1	1
156	148	頭（あたま）	1	1
157	149	お腹	1	1
158	150	度（ど）	1	1
159	151	エレベーター	1	1
160	152	切符	1	1
161	153	おりる	1	1
162	154	階段	1	1
163	155	閉める	1	1
164	156	駅	1	1
165	157	地下鉄	1	1
166	158	乗る	1	1
167	159	開ける	1	1
168	160	お手洗い	1	1
169	161	トイレ	1	1
170	162	電車	1	1
171	163	飲み物	1	1
172	164	コーヒー	1	1
173	165	喫茶店	1	1
174	166	レモン	1	1
175	167	牛乳	1	1
176	168	砂糖	1	1
177	169	カップ	1	1
178	170	お茶	1	1
179	171	紅茶	1	1
180	172	コップ	1	1
181	173	入れる	1	1
182	174	甘い	1	1
183	175	飲む	1	1
184	176	はし	1	1
185	177	酒	1	1
186	178	おいしい	1	1
187	179	ナイフ	1	1
188	180	スプーン	1	1
189	181	フォーク	1	1
190	175	食べる	1	1
191	182	まずい	1	1
192	183	パン	1	1
193	184	辛い	1	1
194	61	レストラン	1	1
195	185	食堂	1	1
196	186	酒・ワイン	1	1
197	187	食べ物	1	1
198	188	カレー	1	1
199	189	お金	1	1
200	190	銀行	1	1
201	191	入り口	1	1
202	192	どうぞ,どういたしまして	1	1
203	193	いいえ	1	1
204	194	ええ	1	1
205	195	すみません	1	1
206	192	どうぞ	1	1
207	196	出口	1	1
208	197	着く	1	1
209	198	ポスト	1	1
210	199	はがき	1	1
211	155	張る	1	1
212	200	封筒	1	1
213	152	手紙	1	1
214	201	郵便局	1	1
215	202	返す	1	1
216	203	出す	1	1
217	204	切手	1	1
218	205	荷物	1	1
219	206	枚	1	1
220	207	貸す	1	1
221	75	買う	1	1
222	208	帽子	1	1
223	209	靴	1	1
224	210	買い物	1	1
225	211	階	1	1
226	212	デパート	1	1
227	213	スカート	1	1
228	214	コート	1	1
229	215	ズボン	1	1
230	214	セーター	1	1
231	216	…てください	1	1
232	217	かばん	1	1
233	218	売る	1	1
234	42	上着	1	1
235	160	ふろ	1	1
236	219	建物	1	1
237	220	台所	1	1
238	221	シャワー	1	1
239	222	窓	1	1
240	223	住む	1	1
241	79	公園	1	1
242	224	ドア	1	1
243	225	浴びる［一風呂～］	1	1
244	226	アパート	1	1
245	227	玄関	1	1
246	228	彼，彼女	1	1
247	229	彼ら，彼女たち	1	1
248	230	私（わたし）	1	1
249	231	私たち	1	1
250	232	だれか	1	1
251	233	だれ	1	1
252	234	どなた	1	1
253	235	きみ	1	1
254	236	あなた	1	1
255	237	この	1	1
256	238	その，あの	1	1
257	239	いかが，どう	1	1
258	240	どの	1	1
259	241	どんな	1	1
260	242	こんな	1	1
261	243	自分	1	1
262	244	そう	1	1
263	245	厚い	1	1
264	246	狭い	1	1
265	247	細い	1	1
266	248	大きい	1	1
267	249	太い	1	1
268	250	若い	1	1
269	251	広い	1	1
270	252	軽い	1	1
271	253	遠い	1	1
272	254	重い	1	1
273	255	薄い	1	1
274	256	新しい	1	1
275	257	小さい	1	1
276	105	近い	1	1
277	258	古い	1	1
278	259	楽しい	1	1
279	260	にぎやか	1	1
280	261	低い	1	1
281	262	よい	1	1
282	263	明るい	1	1
283	264	弱い	1	1
284	265	強い	1	1
285	266	おもしろい	1	1
286	267	きれい	1	1
287	20	遅い	1	1
288	268	悪い	1	1
289	269	多い	1	1
290	270	暗い	1	1
291	271	静か	1	1
292	272	少ない	1	1
293	273	汚い	1	1
294	274	つまらない	1	1
295	275	横	1	1
296	276	中（なか）	1	1
297	277	外（そと）	1	1
298	278	東（ひがし）	1	1
299	279	高さ	1	1
300	280	縦	1	1
301	281	北（きた）	1	1
302	282	西（にし）	1	1
303	283	下（した）	1	1
304	284	南（みなみ）	1	1
305	285	上（うえ）	1	1
306	111	先（さき）	1	1
307	110	後（あと）	1	1
308	286	いとこ	1	1
309	287	兄	1	1
310	288	兄弟（きょうだい）	1	1
311	289	おばあさん	1	1
312	290	おじいさん	1	1
313	291	奥さん	1	1
314	292	母	1	1
315	293	叔父，伯父	1	1
316	294	両親	1	1
317	295	父	1	1
318	296	姉	1	1
319	297	姉妹	1	1
320	298	叔母，伯母	1	1
321	287	お兄さん	1	1
322	296	お姉さん	1	1
323	295	お父さん	1	1
324	292	お母さん	1	1
325	299	靴下	1	1
326	300	シャツ	1	1
327	301	脱ぐ	1	1
328	302	架ける	1	1
329	303	は（穿）く［ズボンを～］	1	1
330	302	着る	1	1
331	302	かぶる	1	1
332	304	ハンカチ	1	1
333	305	スリッパ	1	1
334	306	傘	1	1
335	307	ポケット	1	1
336	308	財布	1	1
337	302	着ている	1	1
338	300	服	1	1
339	309	洋服	1	1
340	310	口	1	1
341	311	腕（うで）	1	1
342	312	体（からだ）	1	1
343	111	顔	1	1
344	281	脚（あし）	1	1
345	311	手（て）	1	1
346	313	鼻	1	1
347	314	目（め）	1	1
348	315	耳	1	1
349	281	足（あし）	1	1
350	149	おなか	1	1
351	316	皿（さら）	1	1
352	317	バター	1	1
353	316	茶わん	1	1
354	318	あめ	1	1
355	319	昼御飯	1	1
356	320	夕飯（ゆうはん）	1	1
357	321	お菓子	1	1
358	322	卵	1	1
359	323	朝御飯	1	1
360	324	御飯（ごはん）	1	1
361	325	醤油	1	1
362	326	塩（しお）	1	1
363	320	晩御飯	1	1
364	327	くわえる	1	1
365	173	つける	1	1
366	328	カメラ	1	1
367	329	鉛筆	1	1
368	330	消す	1	1
369	331	眼鏡（めがね）	1	1
370	332	テープレコーダー	1	1
371	333	時計	1	1
372	334	コンピュータ	1	1
373	335	フィルム	1	1
374	224	戸（と）	1	1
375	224	門（もん）	1	1
376	337	ペン	1	1
377	336	万年筆	1	1
378	337	ボールペン	1	1
379	338	八月	1	1
380	339	四月	1	1
381	340	今月	1	1
382	341	毎月（まいつき）	1	1
383	342	十二月	1	1
384	343	二月	1	1
385	344	一月	1	1
386	345	七月	1	1
387	346	六月	1	1
388	347	来月	1	1
389	348	五月	1	1
390	349	三月	1	1
391	350	先月	1	1
392	351	十一月	1	1
393	352	十月	1	1
394	353	九月	1	1
395	354	ひとつき	1	1
396	355	今週	1	1
397	356	毎週	1	1
398	357	日曜日	1	1
399	358	木曜日	1	1
400	359	来週	1	1
401	360	月曜日	1	1
402	361	火曜日	1	1
403	362	水曜日	1	1
404	363	土曜日	1	1
405	364	週間	1	1
406	365	先週	1	1
407	366	金曜日	1	1
408	367	年（ねん）	1	1
409	368	秋	1	1
410	369	今年（ことし）	1	1
411	370	毎年（まいとし）	1	1
412	371	夏（なつ）	1	1
413	372	冬	1	1
414	373	去年	1	1
415	374	来年	1	1
416	375	春	1	1
417	376	再来年	1	1
418	377	おととし	1	1
419	378	午後	1	1
420	379	今日（きょう）	1	1
421	380	明日（あした）	1	1
422	381	時（じ）	1	1
423	382	昨日（きのう）	1	1
424	383	夕べ	1	1
425	384	午前	1	1
426	384	朝	1	1
427	385	昼	1	1
428	386	夜（よる）	1	1
429	378	夕方	1	1
430	387	あさって	1	1
431	388	おととい	1	1
432	389	もう	1	1
433	390	ながら	1	1
434	391	まだ	1	1
435	392	中(ちゅう)	1	1
436	393	時（とき）	1	1
437	394	いつ	1	1
438	395	ときどき	1	1
439	396	しばしば	1	1
440	381	時間	1	1
441	397	すぐ	1	1
442	398	灰皿	1	1
443	399	歌（うた）	1	1
444	400	歌う	1	1
445	401	たばこ	1	1
446	402	映画	1	1
447	403	レコード	1	1
448	404	ギター	1	1
449	405	弾く	1	1
450	406	音楽	1	1
451	407	絵（え）	1	1
452	408	写真	1	1
453	17	好き，気に入る	1	1
454	409	声	1	1
455	410	晴れ	1	1
456	411	暑い	1	1
457	412	晴れる	1	1
458	413	涼しい	1	1
459	414	寒い	1	1
460	415	雪（ゆき）	1	1
461	416	雨が降る	1	1
462	417	雨（あめ）	1	1
463	418	天気	1	1
464	419	あたたかい（暖・温）	1	1
465	420	風（かぜ）	1	1
466	421	曇り	1	1
467	413	冷たい	1	1
468	422	曇る	1	1
469	423	漢字	1	1
470	424	言う	1	1
471	425	書く	1	1
472	426	話（はなし）	1	1
473	427	言葉	1	1
474	428	～語	1	1
475	428	語（ご）	1	1
476	429	話す	1	1
477	430	文章	1	1
478	431	語る	1	1
479	432	意味	1	1
480	433	大人（おとな）	1	1
481	434	大勢	1	1
482	435	夫婦	1	1
483	436	子供	1	1
484	291	妻	1	1
485	437	女（おんな）	1	1
486	438	男の子	1	1
487	439	人（ひと）	1	1
488	440	男（おとこ）	1	1
489	441	女の子	1	1
490	442	夫	1	1
491	439	人	1	1
492	443	みんな	1	1
493	444	白（しろ），白い	1	1
494	445	青，青い	1	1
495	446	茶色	1	1
496	51	明るい，淡い	1	1
497	447	色（いろ）	1	1
498	258	濃い，暗い	1	1
499	448	黄色（きいろ），黄色い	1	1
500	449	黒（くろ），黒い	1	1
501	450	赤，赤い	1	1
502	451	緑	1	1
503	452	便利	1	1
504	453	パーティー	1	1
505	454	紙	1	1
506	455	～になる	1	1
507	456	締める	1	1
508	457	押す	1	1
509	458	始まる	1	1
510	459	ちょうど	1	1
511	460	ない	1	1
512	461	まっすぐ	1	1
513	462	有名	1	1
514	463	元気	1	1
515	244	じゃあ	1	1
516	464	多分	1	1
517	465	では	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: km
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
190	81700	2.3331001	2.33	用	活動	生活	食生活	食べる	食べる	たべる
191	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
192	50788	1.431	1.43	体	生産物	食料	料理	パン	パン	ぱん
193	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
194	22888	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	レストラン	レストラン	れすとらん
195	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
196	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
197	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
198	51510	1.433	1.43	体	生産物	食料	調味料・こうじなど	カレー	カレー	かれえ
199	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
200	22692	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	銀行	銀行	ぎんこう
201	12249	1.183	1.18	体	関係	形	穴・口	入（い）り口	入り口	いりぐち
202	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
203	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
204	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
205	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
206	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
207	12247	1.183	1.18	体	関係	形	穴・口	出口	出口	でぐち
208	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
209	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
210	32265	1.3122	1.31	体	活動	言語	通信	はがき	はがき	はがき
211	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
212	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
213	32261	1.3122	1.31	体	活動	言語	通信	手紙	手紙	てがみ
214	23439	1.272	1.27	体	主体	機関	公共機関	郵便局	郵便局	ゆうびんきょく
215	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
216	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
217	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
218	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
219	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
220	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
221	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
222	50073	1.425	1.42	体	生産物	衣料	帽子・マスクなど	帽子	帽子	ぼうし
223	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
224	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
225	15092	1.1962	1.19	体	関係	量	助数接辞	階	階	かい
226	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
227	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
228	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
229	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
230	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
231	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
232	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
233	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
234	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
235	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
236	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
237	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
238	54653	1.4541	1.45	体	生産物	道具	日用品	シャワー	シャワー	しゃわあ
239	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
240	81948	2.3333001	2.33	用	活動	生活	住生活	住む	住む	すむ
241	23140	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	公園	公園	こうえん
242	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
243	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
244	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
245	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
246	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
247	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
248	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
249	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
250	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
251	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
252	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
253	15527	1.201	1.20	体	主体	人間	われ・なれ・かれ	君（きみ）	君	きみ
254	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
255	90777	3.1010001	3.10	相	関係	真偽	こそあど・他	この	この	この
256	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
257	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
258	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
259	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
260	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
261	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
262	90799	3.1010001	3.10	相	関係	真偽	こそあど・他	そう	そう	そう
263	94048	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	厚い	厚い	あつい
264	94110	3.1912	3.19	相	関係	量	広狭・大小	狭い	狭い	せまい
265	94125	3.1912	3.19	相	関係	量	広狭・大小	細い	細い	ほそい
266	94142	3.1912	3.19	相	関係	量	広狭・大小	大きい	大きい	おおきい
267	94124	3.1912	3.19	相	関係	量	広狭・大小	太い	太い	ふとい
268	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
269	94080	3.1912	3.19	相	関係	量	広狭・大小	広い	広い	ひろい
270	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
271	94059	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	遠い	遠い	とおい
272	94318	3.1914001	3.19	相	関係	量	軽重	重い	重い	おもい
273	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
274	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
275	94186	3.1912	3.19	相	関係	量	広狭・大小	小さい	小さい	ちいさい
276	94068	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	近い	近い	ちかい
277	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
278	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
279	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
280	94030	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	低い	低い	ひくい
281	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
282	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
283	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
284	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
285	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
286	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
287	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
288	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
289	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
290	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
291	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
292	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
293	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
294	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
295	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
296	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
297	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
298	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
299	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
300	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
301	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
302	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
303	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
304	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
305	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
306	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
307	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
308	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
309	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
310	16780	1.214	1.21	体	主体	家族	兄弟	兄弟（きょうだい）	兄弟	きょうだい
311	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
312	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
313	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
314	16496	1.212	1.21	体	主体	家族	親・先祖	母	母	はは
315	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
316	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
317	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
318	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
319	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
320	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
321	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
322	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
323	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
324	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
325	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
326	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
327	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
328	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
329	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
330	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
331	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
332	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
333	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
334	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
335	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
336	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
337	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
338	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
339	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
340	64505	1.5601	1.56	体	自然	身体	頭・目鼻・顔	口	口	くち
341	64741	1.5603	1.56	体	自然	身体	手足・指	腕	腕	うで
342	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
343	64388	1.5601	1.56	体	自然	身体	頭・目鼻・顔	顔	顔	かお
344	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
345	64713	1.5603	1.56	体	自然	身体	手足・指	手（て）	手	て
346	64470	1.5601	1.56	体	自然	身体	頭・目鼻・顔	鼻	鼻	はな
347	64415	1.5601	1.56	体	自然	身体	頭・目鼻・顔	目（め）	目	め
348	64491	1.5601	1.56	体	自然	身体	頭・目鼻・顔	耳	耳	みみ
349	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
350	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
351	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
352	51476	1.433	1.43	体	生産物	食料	調味料・こうじなど	バター	バター	ばたあ
353	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
354	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
355	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
356	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
357	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
358	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
359	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
360	36910	1.3331	1.33	体	活動	生活	食生活	御飯（ごはん）	御飯	ごはん
361	51442	1.433	1.43	体	生産物	食料	調味料・こうじなど	醤油	醤油	しょうゆ
362	51398	1.433	1.43	体	生産物	食料	調味料・こうじなど	塩（しお）	塩	しお
363	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
364	73997	2.158	2.15	用	関係	作用	増減・補充	加える	加える	くわえる
365	72782	2.1559999	2.15	用	関係	作用	接近・接触・隔離	付ける	付ける	つける
366	55928	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	カメラ	カメラ	かめら
367	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
368	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
369	55889	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	眼鏡（めがね）	眼鏡	めがね
370	56004	1.462	1.46	体	生産物	機械	電気器具・部品	テープレコーダー	テープレコーダー	てえぷれこおだあ
371	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
372	56126	1.462	1.46	体	生産物	機械	電気器具・部品	コンピューター	コンピューター	こんぴゅうたあ
373	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
374	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
375	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
376	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
377	54238	1.4529999	1.45	体	生産物	道具	文具	万年筆	万年筆	まんねんひつ
378	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
379	14681	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	八月	八月	はちがつ
380	14677	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	四月	四月	しがつ
381	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
382	7865	1.1612	1.16	体	関係	時間	毎日・毎度	毎月（まいつき）	毎月	まいつき
383	14685	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十二月	十二月	じゅうにがつ
384	14675	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	二月	二月	にがつ
385	14674	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	一月	一月	いちがつ
386	14680	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	七月	七月	しちがつ
387	14679	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	六月	六月	ろくがつ
388	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
389	8510	1.1631	1.16	体	関係	時間	月	五月（さつき）	五月	さつき
390	14676	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	三月	三月	さんがつ
391	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
392	14684	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十一月	十一月	じゅういちがつ
393	14683	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十月	十月	じゅうがつ
394	14682	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	九月	九月	くがつ
395	14623	1.196	1.19	体	関係	量	数記号（一二三）	ひとつき	ひとつき	ひとつき
396	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
397	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
398	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
399	8558	1.1632	1.16	体	関係	時間	週・週日	木曜日	木曜日	もくようび
400	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
401	8555	1.1632	1.16	体	関係	時間	週・週日	月曜日	月曜日	げつようび
402	8556	1.1632	1.16	体	関係	時間	週・週日	火曜日	火曜日	かようび
403	8557	1.1632	1.16	体	関係	時間	週・週日	水曜日	水曜日	すいようび
404	8560	1.1632	1.16	体	関係	時間	週・週日	土曜日	土曜日	どようび
405	14890	1.1962	1.19	体	関係	量	助数接辞	週間	週間	しゅうかん
406	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
407	8559	1.1632	1.16	体	関係	時間	週・週日	金曜日	金曜日	きんようび
408	14871	1.1962	1.19	体	関係	量	助数接辞	年（ねん）	年	ねん
409	8389	1.1624	1.16	体	関係	時間	季節	秋	秋	あき
410	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
411	7870	1.1612	1.16	体	関係	時間	毎日・毎度	毎年（まいとし）	毎年	まいとし
412	8375	1.1624	1.16	体	関係	時間	季節	夏（なつ）	夏	なつ
413	8403	1.1624	1.16	体	関係	時間	季節	冬	冬	ふゆ
414	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
415	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
416	8361	1.1624	1.16	体	関係	時間	季節	春	春	はる
417	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
418	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
419	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
420	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
421	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
422	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
423	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
424	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
425	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
426	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
427	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
428	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
429	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
430	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
431	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
432	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
433	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
434	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
435	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
436	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
437	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
438	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
439	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
440	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
441	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
442	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
443	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
444	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
445	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
446	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
447	55164	1.456	1.45	体	生産物	道具	楽器・レコードなど	レコード	レコード	れこおど
448	55090	1.456	1.45	体	生産物	道具	楽器・レコードなど	ギター	ギター	ぎたあ
449	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
450	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
451	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
452	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
453	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
454	25605	1.3031	1.30	体	活動	心	声	声	声	こえ
455	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
456	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
457	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
458	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
459	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
460	59878	1.5153	1.51	体	自然	物質	雨・雪	雪（ゆき）	雪	ゆき
461	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
462	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
463	59928	1.5154001	1.51	体	自然	物質	天気	天気	天気	てんき
464	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
465	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
466	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
467	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
468	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
469	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
470	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
471	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
472	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
473	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
474	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
475	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
476	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
477	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
478	80001	2.3131001	2.31	用	活動	言語	話・談話	語る	語る	かたる
479	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
480	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
481	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
482	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
483	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
484	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
485	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
486	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
487	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
488	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
489	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
490	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
491	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
492	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
493	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
494	58059	1.502	1.50	体	自然	自然	色	青	青	あお
495	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
496	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
497	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
498	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
499	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
500	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
501	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
502	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
503	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
504	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
505	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
506	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
507	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
508	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
509	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
510	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
511	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
512	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
513	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
514	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
515	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
516	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
517	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	2	866	0	ភាសាអង់គ្លេស	0	\N	\N
2	3	867	0	កប៉ាល់ហោះ	0	\N	\N
3	4	868	0	បរទេស	0	\N	\N
4	5	869	0	ជនបរទេស	0	\N	\N
5	6	870	0	ភាសាខ្មែរ	0	\N	\N
6	7	871	0	សណ្ឋាគារ	0	\N	\N
7	12	872	0	ថ្ងៃឈប់	0	\N	\N
8	13	873	0	ធ្វើដំណើរ	0	\N	\N
9	14	874	0	ធ្វើដំណើរ	0	\N	\N
10	16	875	0	ស្ថានទូត	0	\N	\N
11	20	876	0	រត់	0	\N	\N
12	22	877	0	មិនពូកែ	0	\N	\N
13	25	878	0	រហ័ស	0	\N	\N
14	26	879	0	លោត	0	\N	\N
15	28	880	0	មិនចូលចិត្ត	0	\N	\N
16	29	881	0	អាងហែល	0	\N	\N
17	30	882	0	ឡានក្រុង	0	\N	\N
18	31	883	0	កង់	0	\N	\N
19	32	884	0	កាច់ជ្រុងថ្នល់	0	\N	\N
20	34	885	0	ស្រះ	0	\N	\N
21	35	886	0	ដើរលេង	0	\N	\N
22	36	887	0	ទន្លេ	0	\N	\N
23	37	888	0	ឡានតាក់ស៊ី	0	\N	\N
24	39	889	0	បត់	0	\N	\N
25	40	890	0	ក្រវាត់ក	0	\N	\N
26	41	891	0	អាវសឺមី	0	\N	\N
27	42	892	0	ក្រុមហ៊ុន	0	\N	\N
28	43	893	0	អាវធំ	0	\N	\N
29	49	894	0	រវល់	0	\N	\N
30	50	895	0	បណ្ណាល័យ	0	\N	\N
31	53	896	0	កាសែត	0	\N	\N
32	56	897	0	ច្បាប់ចម្លង	0	\N	\N
33	57	898	0	ចម្លង	0	\N	\N
34	58	899	0	ទស្សនាវដ្ដី	0	\N	\N
35	66	900	0	ផ្លែឈើ	0	\N	\N
36	67	901	0	បន្លែ	0	\N	\N
37	73	902	0	ហុចឲ្យ	0	\N	\N
38	74	903	0	ហាងលក់បន្លែ	0	\N	\N
39	80	904	0	ក្រុមគ្រួសារ	0	\N	\N
40	81	905	0	ក្រុមគ្រួសារ	0	\N	\N
41	82	906	0	សួនច្បារ	0	\N	\N
42	83	907	0	បោកគក់	0	\N	\N
43	87	908	0	ត្រឡប់ទៅ	0	\N	\N
44	88	909	0	ទូដាក់សៀវភៅ	0	\N	\N
45	90	910	0	កៅអី	0	\N	\N
46	92	911	0	ទូទឹកកក	0	\N	\N
47	93	912	0	ជូត	0	\N	\N
48	94	913	0	គ្រែ	0	\N	\N
49	95	914	0	រ៉ាត់យ៉ូ	0	\N	\N
50	96	915	0	ម៉ាញេ	0	\N	\N
51	98	916	0	ដេក	0	\N	\N
52	102	917	0	ប៉ូលីស	0	\N	\N
53	103	918	0	ប៉ូលីស	0	\N	\N
55	106	920	0	កន្លែងនេះ	0	\N	\N
56	107	921	0	កន្លែងនោះ	0	\N	\N
57	108	922	0	កន្លែងនោះ	0	\N	\N
58	109	923	0	ឯណា	0	\N	\N
59	110	924	0	ប៉ុស្តិ៍ប៉ូលីស	0	\N	\N
60	115	925	0	ខ្លី	0	\N	\N
61	118	926	0	ស្ដាំ	0	\N	\N
62	119	927	0	ឆ្វេង	0	\N	\N
63	122	928	0	ឈរ	0	\N	\N
64	123	929	0	មិត្ត	0	\N	\N
65	124	930	0	ថ្នាក់	0	\N	\N
66	125	931	0	បន្ទប់រៀន	0	\N	\N
67	126	932	0	ផ្លូវដើរ	0	\N	\N
68	128	933	0	សិស្ស	0	\N	\N
69	129	934	0	ការសិក្សា	0	\N	\N
70	130	935	0	និស្សិត	0	\N	\N
71	131	936	0	និស្សិតបរទេស	0	\N	\N
72	132	937	0	វ៉ាកងធំ	0	\N	\N
73	134	938	0	សាកលវិទ្យាល័យ	0	\N	\N
74	135	939	0	សៀវភៅសរសេរ	0	\N	\N
75	136	940	0	ថ្នាក់	0	\N	\N
76	137	941	0	តែងសេចក្ដី	0	\N	\N
77	138	942	0	កិច្ចការផ្ទះ	0	\N	\N
78	141	943	0	ប្រឡង	0	\N	\N
79	142	944	0	លំហាត់	0	\N	\N
80	144	945	0	ហាត់	0	\N	\N
81	145	946	0	សំណួរ	0	\N	\N
82	146	947	0	សំណួរ	0	\N	\N
83	147	948	0	ឆ្លើយ	0	\N	\N
84	149	949	0	ធ្មេញ	0	\N	\N
85	151	950	0	មន្ទីរពេទ្យ	0	\N	\N
86	152	951	0	ជម្ងឺ	0	\N	\N
87	153	952	0	ថ្នាំ	0	\N	\N
88	154	953	0	ស្លាប់	0	\N	\N
89	158	954	0	អង្សា	0	\N	\N
90	159	955	0	អាស់សង់ស័រ	0	\N	\N
91	162	956	0	ជណ្ដើរ	0	\N	\N
92	164	957	0	ស្ថានីយ	0	\N	\N
93	165	958	0	រទេះភ្លើងក្រោមដី	0	\N	\N
94	168	959	0	បន្ទប់ទឹក	0	\N	\N
95	169	960	0	បង្គន់	0	\N	\N
96	170	961	0	រទេះភ្លើង	0	\N	\N
97	171	962	0	ភេសជ្ជៈ	0	\N	\N
98	173	963	0	ហាងកាហ្វេ	0	\N	\N
99	174	964	0	ក្រូចឆ្មារ	0	\N	\N
100	177	965	0	ពែងកែវ	0	\N	\N
101	178	966	0	ទឹកតែ	0	\N	\N
102	179	967	0	ទឹកតែលីបតុង	0	\N	\N
103	182	968	0	ផ្អែម	0	\N	\N
104	184	969	0	ចង្កើះ	0	\N	\N
105	188	970	0	ស្លាបព្រា	0	\N	\N
107	192	972	0	នំប៉័ង	0	\N	\N
108	193	973	0	ហឹរ	0	\N	\N
109	195	974	0	ហាងបាយ	0	\N	\N
110	196	975	0	ស្រាទំពាំងបាយជូរ	0	\N	\N
111	197	976	0	ម្ហូបអាហារ	0	\N	\N
112	198	977	0	សម្លការី	0	\N	\N
113	201	978	0	ទ្វារចូល	0	\N	\N
114	205	979	0	អត់ទោស	0	\N	\N
115	207	980	0	ទ្វារចេញ	0	\N	\N
116	209	981	0	ប្រអប់សំបុត្រ	0	\N	\N
117	210	982	0	កាតប៉ុស្តាល់	0	\N	\N
118	217	983	0	តែមប្រិ៍	0	\N	\N
119	219	984	0	សន្លឹក	0	\N	\N
120	220	985	0	ឲ្យខ្ចី	0	\N	\N
121	224	986	0	ទិញអីវ៉ាន់	0	\N	\N
122	227	987	0	សំពត់	0	\N	\N
123	228	989	0	អាវរងារ	0	\N	\N
124	230	988	0	អាវរងារ	0	\N	\N
125	234	990	0	អាវធំ	0	\N	\N
126	235	991	0	បន្ទប់ទឹក	0	\N	\N
127	236	992	0	អាគារ	0	\N	\N
128	237	993	0	ផ្ទះបាយ	0	\N	\N
129	238	994	0	ងូតទឹកផ្កាឈូក	0	\N	\N
130	240	995	0	រស់នៅ	0	\N	\N
131	241	996	0	សួនច្បារ	0	\N	\N
132	242	997	0	ទ្វារ	0	\N	\N
133	243	998	0	ត្រាំទឹកក្តៅ	0	\N	\N
134	244	999	0	ផ្ទះល្វែង	0	\N	\N
135	245	1000	0	មាត់ទ្វារ	0	\N	\N
136	247	1001	0	ពួកគេ	0	\N	\N
137	249	1002	0	ពួកខ្ញុំ	0	\N	\N
138	250	1003	0	អ្នកណាគេ	0	\N	\N
139	252	1004	0	អញ្ជើញពីខាងណា	0	\N	\N
140	253	1005	0	គាត់ឯង	0	\N	\N
141	257	1006	0	ត្រូវការអី	0	\N	\N
142	263	1007	0	ក្រាស់	0	\N	\N
143	264	1008	0	ចង្អៀត	0	\N	\N
144	265	1009	0	ស្គម	0	\N	\N
145	267	1010	0	ធាត់	0	\N	\N
146	268	1011	0	ក្មេង	0	\N	\N
147	269	1012	0	ទូលាយ	0	\N	\N
148	271	1013	0	ឆ្ងាយ	0	\N	\N
149	272	1014	0	ធ្ងន់	0	\N	\N
150	273	1015	0	ស្ដើង	0	\N	\N
151	279	1016	0	អឺងកង	0	\N	\N
152	280	1017	0	ទាប	0	\N	\N
153	282	1018	0	ភ្លឺ	0	\N	\N
154	283	1019	0	ខ្សោយ	0	\N	\N
155	288	1020	0	អាក្រក់	0	\N	\N
156	290	1021	0	ងងឹត	0	\N	\N
157	291	1022	0	ស្ងាត់	0	\N	\N
158	293	1023	0	កខ្វក់	0	\N	\N
159	294	1024	0	អផ្សុក	0	\N	\N
160	295	1025	0	ទទឹង	0	\N	\N
161	299	1026	0	កំពស់	0	\N	\N
162	300	1027	0	បណ្ដោយ	0	\N	\N
163	302	1028	0	លិច	0	\N	\N
164	304	1029	0	ត្បូង	0	\N	\N
165	308	1030	0	បងប្អូនជីដូនមួយ	0	\N	\N
166	310	1031	0	បងប្អូនប្រុស	0	\N	\N
167	316	1032	0	ឪពុកម្ដាយ	0	\N	\N
168	319	1033	0	បងប្អូនស្រី	0	\N	\N
169	325	1034	0	ស្រោមជើង	0	\N	\N
170	332	1035	0	កន្សែងដៃ	0	\N	\N
171	333	1036	0	ស្បែកជើងផ្ទាត់	0	\N	\N
172	334	1037	0	ឆត្រ	0	\N	\N
173	335	1038	0	កាប៉ៅ	0	\N	\N
174	340	1039	0	មាត់	0	\N	\N
175	346	1040	0	ច្រមុះ	0	\N	\N
176	352	1041	0	បឺរ	0	\N	\N
177	354	1042	0	ស្ករគ្រាប់	0	\N	\N
178	355	1043	0	បាយថ្ងៃ	0	\N	\N
179	356	1044	0	បាយល្ងាច	0	\N	\N
180	361	1045	0	ទឹកស៊ីអ៊ីវ	0	\N	\N
181	362	1046	0	អំបិល	0	\N	\N
182	363	1047	0	បាយល្ងាច	0	\N	\N
183	364	1048	0	ថែម	0	\N	\N
184	366	1049	0	កាមេរ៉ា	0	\N	\N
185	367	1050	0	ខ្មៅដៃ	0	\N	\N
186	369	1051	0	វ៉ែនតា	0	\N	\N
187	370	1052	0	ម៉ាញេថតសំឡេង	0	\N	\N
188	371	1053	0	នាឡិកា	0	\N	\N
189	373	1054	0	ហ្វីលម៍	0	\N	\N
191	375	1056	0	ទ្វារ	0	\N	\N
192	376	1057	0	ប៊ិក	0	\N	\N
193	377	1058	0	ស្ទីឡូ	0	\N	\N
194	378	1059	0	ប៊ិក	0	\N	\N
195	379	1060	0	ខែសីហា	0	\N	\N
196	380	1061	0	ខែមេសា	0	\N	\N
197	381	1062	0	ខែនេះ	0	\N	\N
198	382	1063	0	រាល់ខែ	0	\N	\N
199	383	1064	0	ខែធ្នូ	0	\N	\N
200	384	1065	0	ខែកុម្ភៈ	0	\N	\N
201	385	1066	0	ខែមករា	0	\N	\N
202	386	1067	0	ខែកក្កដា	0	\N	\N
203	387	1068	0	ខែមិថុនា	0	\N	\N
204	389	1069	0	ខែឧសភា	0	\N	\N
205	390	1070	0	ខែមីនា	0	\N	\N
206	391	1071	0	ខែមុន	0	\N	\N
207	392	1072	0	ខែវិច្ឆិកា	0	\N	\N
208	394	1073	0	ខែកញ្ញា	0	\N	\N
209	396	1074	0	អាទិត្យនេះ	0	\N	\N
210	397	1075	0	រាល់អាទិត្យ	0	\N	\N
211	398	1076	0	ថ្ងៃអាទិត្យ	0	\N	\N
212	399	1077	0	ថ្ងៃព្រហស្បតិ៍	0	\N	\N
213	401	1078	0	ថ្ងៃចន្ទ	0	\N	\N
214	402	1079	0	ថ្ងៃអង្គារ	0	\N	\N
215	403	1080	0	ថ្ងៃពុធ	0	\N	\N
216	406	1081	0	អាទិត្យមុន	0	\N	\N
217	407	1082	0	ថ្ងៃសុក្រ	0	\N	\N
218	409	1083	0	រដូវលំហើយ	0	\N	\N
219	410	1084	0	ឆ្នាំនេះ	0	\N	\N
220	411	1085	0	រាល់ឆ្នាំ	0	\N	\N
221	412	1086	0	រដូវក្ដៅ	0	\N	\N
222	413	1087	0	រដូវរងារ	0	\N	\N
223	414	1088	0	ឆ្នាំមុន	0	\N	\N
224	415	1089	0	ឆ្នាំក្រោយ	0	\N	\N
225	416	1090	0	រដូវផ្ការីក	0	\N	\N
226	417	1091	0	ពីរឆ្នាំក្រោយ	0	\N	\N
227	418	1092	0	ឆ្នាំទៅមួយ	0	\N	\N
228	419	1093	0	ពេលល្ងាច	0	\N	\N
229	421	1094	0	ថ្ងៃស្អែក	0	\N	\N
230	424	1095	0	យប់មិញ	0	\N	\N
231	425	1096	0	ពេលព្រឹក	0	\N	\N
232	426	1097	0	ពេលព្រឹក	0	\N	\N
233	427	1098	0	ពេលថ្ងៃ	0	\N	\N
234	428	1099	0	ពេលយប់	0	\N	\N
235	429	1100	0	ពេលល្ងាច	0	\N	\N
236	430	1101	0	ខានស្អែក	0	\N	\N
237	438	1102	0	ពេលខ្លះ	0	\N	\N
238	441	1103	0	ជិតដល់	0	\N	\N
239	442	1104	0	ចានគោះបារី	0	\N	\N
240	447	1105	0	ថាសចម្រៀង	0	\N	\N
241	448	1106	0	ហ្គីតា	0	\N	\N
242	449	1107	0	ដេញ	0	\N	\N
243	450	1108	0	ភ្លេង	0	\N	\N
244	451	1109	0	គំនូរ	0	\N	\N
245	452	1110	0	រូបថត	0	\N	\N
246	454	1111	0	សំឡេង	0	\N	\N
247	455	1112	0	មេឃស្រឡះ	0	\N	\N
248	457	1113	0	ស្រឡះ	0	\N	\N
249	458	1114	0	ត្រជាក់	0	\N	\N
250	460	1115	0	ព្រឹល	0	\N	\N
251	463	1116	0	អាកាសធាតុ	0	\N	\N
252	464	1117	0	ក្ដៅស្រួល	0	\N	\N
253	466	1118	0	មេឃស្រទំ	0	\N	\N
254	467	1119	0	ត្រជាក់	0	\N	\N
255	468	1120	0	ស្រទំ	0	\N	\N
256	469	1121	0	អក្សរចិន	0	\N	\N
257	477	1122	0	អត្ថបទ	0	\N	\N
258	478	1123	0	និទាន	0	\N	\N
259	481	1124	0	ហ្វូង	0	\N	\N
260	482	1125	0	ប្ដីប្រពន្ធ	0	\N	\N
261	490	1126	0	ប្ដី	0	\N	\N
262	492	1127	0	ទាំងអស់គ្នា	0	\N	\N
263	495	1128	0	ត្នោត	0	\N	\N
264	497	1129	0	ពណ៌	0	\N	\N
265	499	1130	0	លឿង	0	\N	\N
266	501	1131	0	ក្រហម	0	\N	\N
267	502	1132	0	បៃតង	0	\N	\N
268	503	1133	0	ងាយស្រួល	0	\N	\N
269	504	1134	0	ជប់លៀង	0	\N	\N
270	506	1135	0	ក្លាយជា	0	\N	\N
271	508	1136	0	រុញ	0	\N	\N
272	509	1137	0	ចាប់ផ្ដើម	0	\N	\N
273	510	1138	0	គត់	0	\N	\N
274	511	1139	0	គ្មាន	0	\N	\N
275	513	1140	0	ល្បី	0	\N	\N
276	517	1141	0	ឥឡូវនេះ	0	\N	\N
277	317	525	1	ឪពុក	0	\N	\N
278	317	588	2	ឪពុក	0	\N	\N
280	316	937	1	ឪពុកម្ដាយ	0	\N	\N
283	255	898	1	នេះ	0	\N	\N
287	190	977	5	ញ៉ាំ	0	\N	\N
288	190	1098	6	ញ៉ាំ	0	\N	\N
289	439	1142	1	ឧស្សាហ៍	0	\N	\N
290	323	1143	1	ឪពុក	0	\N	\N
291	183	1144	1	ញ៉ាំ	0	\N	\N
293	256	583	2	នោះ	0	\N	\N
294	256	552	3	នោះ	0	\N	\N
295	256	922	4	នោះ	0	\N	\N
296	357	493	1	នំ	0	\N	\N
297	357	492	2	នំ	0	\N	\N
298	479	686	1	ន័យ	0	\N	\N
299	479	685	2	ន័យ	0	\N	\N
303	122	1017	3	ឈរ	0	\N	\N
304	148	732	1	ឈឺ	0	\N	\N
305	148	731	2	ឈឺ	0	\N	\N
306	119	889	1	ឆ្វេង	0	\N	\N
307	186	971	1	ឆ្ងាញ់	0	\N	\N
309	186	494	3	ឆ្ងាញ់	0	\N	\N
311	408	444	2	ឆ្នាំ	0	\N	\N
312	410	1087	1	ឆ្នាំនេះ	0	\N	\N
314	133	441	2	គ្រូ	0	\N	\N
315	133	1001	3	គ្រូ	0	\N	\N
316	246	867	1	គាត់	0	\N	\N
317	246	1140	2	គាត់	0	\N	\N
318	246	1133	3	គាត់	0	\N	\N
319	285	730	1	គួរឲ្យចាប់អារម្មណ៍	0	\N	\N
320	511	922	1	គ្មាន	0	\N	\N
322	68	878	1	ត្រី	0	\N	\N
324	68	1047	3	ត្រី	0	\N	\N
325	87	937	1	ត្រឡប់ទៅ	0	\N	\N
326	100	910	1	តុ	0	\N	\N
327	89	1145	1	តុ	0	\N	\N
328	275	973	1	តូច	0	\N	\N
329	275	1049	2	តូច	0	\N	\N
330	275	563	3	តូច	0	\N	\N
331	304	978	1	ត្បូង	0	\N	\N
332	312	1123	1	តា	0	\N	\N
334	458	1066	1	ត្រជាក់	0	\N	\N
335	52	588	1	ខ្ចី	0	\N	\N
336	52	713	2	ខ្ចី	0	\N	\N
337	97	470	1	ខ្ញុំឈ្មោះ	0	\N	\N
338	97	630	2	ខ្ញុំឈ្មោះ	0	\N	\N
339	229	891	1	ខោ	0	\N	\N
340	229	1036	2	ខោ	0	\N	\N
341	248	739	1	ខ្ញុំ	0	\N	\N
342	248	763	2	ខ្ញុំ	0	\N	\N
343	248	455	3	ខ្ញុំ	0	\N	\N
344	261	484	1	ខ្លួនឯង	0	\N	\N
345	284	1037	1	ខ្លាំង	0	\N	\N
346	339	747	1	ខោអាវ	0	\N	\N
347	339	907	2	ខោអាវ	0	\N	\N
349	342	667	1	ខ្លួន	0	\N	\N
350	388	528	1	ខែក្រោយ	0	\N	\N
352	500	1054	1	ខ្មៅ	0	\N	\N
353	500	606	2	ខ្មៅ	0	\N	\N
355	494	891	1	ខៀវ	0	\N	\N
356	465	1037	1	ខ្យល់	0	\N	\N
357	465	672	2	ខ្យល់	0	\N	\N
358	334	671	1	ឆត្រ	0	\N	\N
359	394	887	1	ខែកញ្ញា	0	\N	\N
360	393	202	1	ខែតុលា	0	\N	\N
361	389	872	1	ខែឧសភា	0	\N	\N
362	51	695	1	វចនានុក្រម	0	\N	\N
363	51	585	2	វចនានុក្រម	0	\N	\N
364	120	909	1	វែង	0	\N	\N
367	33	1025	2	ផ្លូវ	0	\N	\N
368	85	881	1	ផ្ទះ	0	\N	\N
369	85	908	2	ផ្ទះ	0	\N	\N
370	84	1039	1	ផ្ទះ	0	\N	\N
371	84	446	2	ផ្ទះ	0	\N	\N
372	104	576	1	ផែនទី	0	\N	\N
374	155	1040	2	ផ្ដាសាយ	0	\N	\N
375	182	1048	1	ផ្អែម	0	\N	\N
376	216	793	1	ផ្ញើ	0	\N	\N
377	433	876	1	ផង	0	\N	\N
378	433	720	2	ផង	0	\N	\N
379	38	927	1	ឡាន	0	\N	\N
380	38	921	2	ឡាន	0	\N	\N
381	38	458	3	ឡាន	0	\N	\N
382	54	896	1	អាន	0	\N	\N
384	121	618	1	អង្គុយ	0	\N	\N
385	121	646	2	អង្គុយ	0	\N	\N
387	202	674	1	អញ្ជើញ	0	\N	\N
388	202	675	2	អញ្ជើញ	0	\N	\N
389	218	739	1	អីវ៉ាន់	0	\N	\N
390	218	793	2	អីវ៉ាន់	0	\N	\N
391	251	801	1	អ្នកណា	0	\N	\N
392	251	715	2	អ្នកណា	0	\N	\N
393	515	515	1	អញ្ចឹង	0	\N	\N
394	515	764	2	អញ្ចឹង	0	\N	\N
395	262	670	1	អញ្ចឹង	0	\N	\N
396	326	1038	1	អាវ	0	\N	\N
397	338	1015	1	អាវ	0	\N	\N
398	326	507	2	អាវ	0	\N	\N
399	362	1048	1	អំបិល	0	\N	\N
400	400	635	1	អាទិត្យក្រោយ	0	\N	\N
401	405	639	1	អាទិត្យ	0	\N	\N
402	405	1075	2	អាទិត្យ	0	\N	\N
403	463	1066	1	អាកាសធាតុ	0	\N	\N
404	469	945	1	អក្សរចិន	0	\N	\N
406	24	653	2	ហែល	0	\N	\N
407	62	1006	1	ហាង	0	\N	\N
408	194	974	1	ហាង	0	\N	\N
410	62	1052	2	ហាង	0	\N	\N
411	432	633	1	ហើយ	0	\N	\N
412	432	1022	2	ហើយ	0	\N	\N
413	23	918	1	ដើរ	0	\N	\N
414	23	644	2	ដើរ	0	\N	\N
415	98	1095	1	ដេក	0	\N	\N
416	181	604	1	ដាក់	0	\N	\N
417	365	897	1	ដាក់	0	\N	\N
418	181	972	2	ដាក់	0	\N	\N
419	208	876	1	ដល់	0	\N	\N
420	208	1056	2	ដល់	0	\N	\N
421	327	725	1	ដោះ	0	\N	\N
422	327	727	2	ដោះ	0	\N	\N
423	449	1106	1	ដេញ	0	\N	\N
424	76	976	1	ម្ហូប	0	\N	\N
425	76	1044	2	ម្ហូប	0	\N	\N
426	105	906	1	ម្តុំ	0	\N	\N
428	306	471	1	មុខ	0	\N	\N
429	343	545	1	មុខ	0	\N	\N
430	343	616	2	មុខ	0	\N	\N
431	123	982	1	មិត្ត	0	\N	\N
432	222	725	1	មួក	0	\N	\N
434	258	651	2	មួយណា	0	\N	\N
435	340	1123	1	មាត់	0	\N	\N
436	395	1039	1	មួយខែ	0	\N	\N
437	422	914	1	ម៉ោង	0	\N	\N
438	422	1053	2	ម៉ោង	0	\N	\N
439	440	627	1	ម៉ោង	0	\N	\N
440	423	534	1	ម្សិលមិញ	0	\N	\N
441	423	665	2	ម្សិលមិញ	0	\N	\N
442	431	669	1	ម្សិលម៉្ងៃ	0	\N	\N
443	455	1018	1	មេឃស្រឡះ	0	\N	\N
444	455	1113	2	មេឃស្រឡះ	0	\N	\N
445	480	554	1	មនុស្សពេញវ័យ	0	\N	\N
446	487	919	1	មនុស្ស	0	\N	\N
447	491	598	1	មនុស្ស	0	\N	\N
448	487	886	2	មនុស្ស	0	\N	\N
449	287	1102	1	យឺត	0	\N	\N
450	287	479	2	យឺត	0	\N	\N
451	259	803	1	យ៉ាងណា	0	\N	\N
452	260	673	1	យ៉ាងនេះ	0	\N	\N
453	311	914	1	យាយ	0	\N	\N
454	311	904	2	យាយ	0	\N	\N
455	20	882	1	រត់	0	\N	\N
456	472	1123	1	រឿង	0	\N	\N
457	472	451	2	រឿង	0	\N	\N
458	19	890	1	ពូកែ	0	\N	\N
459	19	653	2	ពូកែ	0	\N	\N
461	139	721	2	ពិបាក	0	\N	\N
462	150	635	1	ពេទ្យ	0	\N	\N
463	350	1010	1	ពោះ	0	\N	\N
464	157	732	1	ពោះ	0	\N	\N
465	337	893	1	ពាក់	0	\N	\N
466	330	1034	1	ពាក់	0	\N	\N
467	337	1038	2	ពាក់	0	\N	\N
468	330	989	2	ពាក់	0	\N	\N
469	328	1051	1	ពាក់	0	\N	\N
470	358	623	1	ពងមាន់	0	\N	\N
471	435	1064	1	ពេញ	0	\N	\N
473	436	876	1	ពេល	0	\N	\N
474	436	943	2	ពេល	0	\N	\N
475	437	139	1	ពេលណា	0	\N	\N
476	437	122	2	ពេលណា	0	\N	\N
477	473	931	1	ពាក្យ	0	\N	\N
478	473	464	2	ពាក្យ	0	\N	\N
479	497	1083	1	ពណ៌	0	\N	\N
480	15	1024	1	លេង	0	\N	\N
481	15	1071	2	លេង	0	\N	\N
482	199	1094	1	លុយ	0	\N	\N
483	199	775	2	លុយ	0	\N	\N
484	233	900	1	លក់	0	\N	\N
485	233	974	2	លក់	0	\N	\N
486	499	1132	1	លឿង	0	\N	\N
487	305	949	1	លើ	0	\N	\N
488	305	1035	2	លើ	0	\N	\N
489	281	936	1	ល្អ	0	\N	\N
490	281	975	2	ល្អ	0	\N	\N
491	14	868	1	ធ្វើដំណើរ	0	\N	\N
492	44	944	1	ធ្វើ	0	\N	\N
493	44	718	2	ធ្វើ	0	\N	\N
494	48	528	1	ធ្វើការ	0	\N	\N
495	48	1032	2	ធ្វើការ	0	\N	\N
496	200	676	1	ធនាគារ	0	\N	\N
497	266	1025	1	ធំ	0	\N	\N
498	266	536	2	ធំ	0	\N	\N
499	61	974	1	ថោក	0	\N	\N
500	61	705	2	ថោក	0	\N	\N
501	63	1059	1	ថ្លៃ	0	\N	\N
502	63	509	2	ថ្លៃ	0	\N	\N
503	153	951	1	ថ្នាំ	0	\N	\N
504	364	968	1	ថែម	0	\N	\N
505	398	895	1	ថ្ងៃអាទិត្យ	0	\N	\N
506	404	886	1	ថ្ងៃសៅរ៍	0	\N	\N
507	420	1024	1	ថ្ងៃនេះ	0	\N	\N
508	420	1101	2	ថ្ងៃនេះ	0	\N	\N
509	470	1094	1	ថា	0	\N	\N
510	470	464	2	ថា	0	\N	\N
511	9	1016	1	ចេញ	0	\N	\N
512	9	612	2	ចេញ	0	\N	\N
515	18	651	2	ចូលចិត្ត	0	\N	\N
516	18	652	3	ចូលចិត្ត	0	\N	\N
517	453	885	2	ចូលចិត្ត	0	\N	\N
518	59	897	1	ច្បាប់	0	\N	\N
519	72	788	1	ចង់បាន	0	\N	\N
520	161	451	1	ចុះ	0	\N	\N
521	277	912	1	ចាស់	0	\N	\N
522	277	961	2	ចាស់	0	\N	\N
523	289	903	1	ច្រើន	0	\N	\N
524	289	996	2	ច្រើន	0	\N	\N
525	353	623	1	ចាន	0	\N	\N
526	351	1104	1	ចាន	0	\N	\N
527	444	877	1	ច្រៀង	0	\N	\N
528	444	1107	2	ច្រៀង	0	\N	\N
529	444	656	3	ច្រៀង	0	\N	\N
530	7	932	1	សណ្ឋាគារ	0	\N	\N
531	16	869	1	ស្ថានទូត	0	\N	\N
532	17	589	1	ស្រឡាញ់	0	\N	\N
533	55	709	1	សៀវភៅ	0	\N	\N
534	55	708	2	សៀវភៅ	0	\N	\N
535	69	780	1	សាច់ជ្រូក	0	\N	\N
536	71	972	1	សាច់	0	\N	\N
537	71	780	2	សាច់	0	\N	\N
538	113	1123	1	ស្ដាប់	0	\N	\N
539	127	895	1	សាលា	0	\N	\N
540	127	1078	2	សាលា	0	\N	\N
542	128	928	2	សិស្ស	0	\N	\N
543	160	867	1	សំបុត្រ	0	\N	\N
544	213	983	1	សំបុត្រ	0	\N	\N
545	213	981	2	សំបុត្រ	0	\N	\N
546	160	998	2	សំបុត្រ	0	\N	\N
547	164	1133	1	ស្ថានីយ	0	\N	\N
548	176	1048	1	ស្ករ	0	\N	\N
549	176	623	2	ស្ករ	0	\N	\N
550	185	1041	1	ស្រា	0	\N	\N
551	185	1006	2	ស្រា	0	\N	\N
552	212	775	1	ស្រោមសំបុត្រ	0	\N	\N
553	215	1094	1	សង	0	\N	\N
554	219	1110	1	សន្លឹក	0	\N	\N
556	223	727	2	ស្បែកជើង	0	\N	\N
557	231	503	1	សូម	0	\N	\N
558	231	462	2	សូម	0	\N	\N
559	265	1047	1	ស្គម	0	\N	\N
560	270	633	1	ស្រាល	0	\N	\N
561	278	1082	1	សប្បាយ	0	\N	\N
563	278	641	3	សប្បាយ	0	\N	\N
564	286	885	1	ស្អាត	0	\N	\N
565	286	890	2	ស្អាត	0	\N	\N
566	291	918	1	ស្ងាត់	0	\N	\N
567	329	987	1	ស្លៀក	0	\N	\N
568	457	1018	1	ស្រឡះ	0	\N	\N
569	457	1112	2	ស្រឡះ	0	\N	\N
570	471	945	1	សរសេរ	0	\N	\N
571	471	982	2	សរសេរ	0	\N	\N
572	485	880	1	ស្រី	0	\N	\N
573	485	663	2	ស្រី	0	\N	\N
574	514	503	1	សុខសប្បាយ	0	\N	\N
575	514	505	2	សុខសប្បាយ	0	\N	\N
576	493	891	1	ស	0	\N	\N
577	493	1054	2	ស	0	\N	\N
578	11	980	1	ជួប	0	\N	\N
579	11	803	2	ជួប	0	\N	\N
580	45	155	1	ជក់	0	\N	\N
581	276	1133	1	ជិត	0	\N	\N
582	111	1133	1	ជិត	0	\N	\N
583	166	955	1	ជិះ	0	\N	\N
584	166	688	2	ជិះ	0	\N	\N
585	225	956	1	ជាន់	0	\N	\N
586	225	788	2	ជាន់	0	\N	\N
587	344	925	1	ជើង	0	\N	\N
588	349	979	1	ជើង	0	\N	\N
589	301	1072	1	ជើង	0	\N	\N
592	10	1085	1	ប្រទេស	0	\N	\N
593	10	524	2	ប្រទេស	0	\N	\N
594	65	507	1	ប៉ុន្មាន	0	\N	\N
595	65	983	2	ប៉ុន្មាន	0	\N	\N
596	64	510	1	ប៉ុន្មាន	0	\N	\N
597	64	550	2	ប៉ុន្មាន	0	\N	\N
598	67	903	1	បន្លែ	0	\N	\N
599	78	907	1	បោក	0	\N	\N
600	78	545	2	បោក	0	\N	\N
601	79	1023	1	បោស	0	\N	\N
602	79	545	2	បោស	0	\N	\N
603	86	545	1	បោសសំអាត	0	\N	\N
604	91	787	1	បន្ទប់	0	\N	\N
607	141	1067	1	ប្រឡង	0	\N	\N
608	141	930	2	ប្រឡង	0	\N	\N
609	211	563	1	បិទ	0	\N	\N
610	163	895	1	បិទ	0	\N	\N
611	163	978	2	បិទ	0	\N	\N
612	211	931	2	បិទ	0	\N	\N
613	167	895	1	បើក	0	\N	\N
614	167	1055	2	បើក	0	\N	\N
615	204	461	1	បាទ	0	\N	\N
617	169	991	1	បង្គន់	0	\N	\N
618	214	611	1	ប៉ុស្តិ៍	0	\N	\N
619	239	788	1	បង្អួច	0	\N	\N
620	309	210	1	បងប្រុស	0	\N	\N
621	484	1125	1	ប្រពន្ធ	0	\N	\N
622	355	1044	1	បាយថ្ងៃ	0	\N	\N
623	359	545	1	បាយព្រឹក	0	\N	\N
624	360	969	1	បាយ	0	\N	\N
625	360	737	2	បាយ	0	\N	\N
626	445	1104	1	បារី	0	\N	\N
627	488	1031	1	ប្រុស	0	\N	\N
628	516	668	1	ប្រហែល	0	\N	\N
629	516	596	2	ប្រហែល	0	\N	\N
630	27	994	1	កីឡា	0	\N	\N
631	27	651	2	កីឡា	0	\N	\N
632	53	912	1	កាសែត	0	\N	\N
633	99	914	1	ក្រោក	0	\N	\N
634	99	543	2	ក្រោក	0	\N	\N
635	112	775	1	ក្បែរ	0	\N	\N
636	114	561	1	កាត់	0	\N	\N
638	156	1029	1	ក្បាល	0	\N	\N
639	172	783	1	កាហ្វេ	0	\N	\N
640	172	603	2	កាហ្វេ	0	\N	\N
641	174	967	1	ក្រូចឆ្មារ	0	\N	\N
642	180	965	1	កែវ	0	\N	\N
643	187	745	1	កាំបិត	0	\N	\N
644	232	1014	1	កាបូប	0	\N	\N
645	268	902	1	ក្មេង	0	\N	\N
646	505	677	1	ក្រដាស	0	\N	\N
647	501	932	1	ក្រហម	0	\N	\N
648	489	589	1	កូនស្រី	0	\N	\N
649	483	545	1	កូន	0	\N	\N
650	483	1135	2	កូន	0	\N	\N
651	456	1120	1	ក្ដៅ	0	\N	\N
653	456	1086	3	ក្ដៅ	0	\N	\N
654	446	659	1	កុន	0	\N	\N
655	372	567	1	កុំព្យូទ័រ	0	\N	\N
656	372	574	2	កុំព្យូទ័រ	0	\N	\N
657	336	185	1	កាបូបលុយ	0	\N	\N
658	303	552	1	ក្រោម	0	\N	\N
659	298	1000	1	កើត	0	\N	\N
660	298	1131	2	កើត	0	\N	\N
661	297	612	1	ក្រៅ	0	\N	\N
662	297	644	2	ក្រៅ	0	\N	\N
663	296	931	1	ក្នុង	0	\N	\N
664	296	744	2	ក្នុង	0	\N	\N
665	6	936	1	ភាសាខ្មែរ	0	\N	\N
667	8	447	1	ភាសាជប៉ុន	0	\N	\N
668	347	916	1	ភ្នែក	0	\N	\N
669	347	1098	2	ភ្នែក	0	\N	\N
670	461	1021	1	ភ្លៀង	0	\N	\N
671	461	1068	2	ភ្លៀង	0	\N	\N
672	474	934	1	ភាសា	0	\N	\N
673	475	870	1	ភាសា	0	\N	\N
674	475	578	2	ភាសា	0	\N	\N
675	462	669	1	ទឹកភ្លៀង	0	\N	\N
676	462	670	2	ទឹកភ្លៀង	0	\N	\N
677	269	1008	1	ទូលាយ	0	\N	\N
678	374	1000	1	ទ្វារ	0	\N	\N
679	375	1055	1	ទ្វារ	0	\N	\N
680	175	976	1	ទឹកដោះគោ	0	\N	\N
681	175	783	2	ទឹកដោះគោ	0	\N	\N
682	101	1095	1	ទូរទស្សន៍	0	\N	\N
683	101	654	2	ទូរទស្សន៍	0	\N	\N
684	221	982	1	ទិញ	0	\N	\N
685	77	986	1	ទិញ	0	\N	\N
686	221	1054	2	ទិញ	0	\N	\N
687	46	679	1	ទូរស័ព្ទ	0	\N	\N
688	36	1073	1	ទន្លេ	0	\N	\N
689	1	1124	1	ទៅ	0	\N	\N
690	1	1045	2	ទៅ	0	\N	\N
691	1	524	3	ទៅ	0	\N	\N
692	47	721	0	ការងារ	0	\N	\N
693	47	800	0	ការងារ	0	\N	\N
694	143	870	0	ស្រួល	0	\N	\N
695	143	924	0	ស្រួល	0	\N	\N
696	254	1002	0	លោក	0	\N	\N
697	254	1004	0	លោក	0	\N	\N
699	274	971	0	ថ្មី	0	\N	\N
700	274	676	0	ថ្មី	0	\N	\N
701	292	1075	0	តិច	0	\N	\N
703	341	889	0	ដៃ	0	\N	\N
704	341	539	0	ដៃ	0	\N	\N
705	345	894	0	ដៃ	0	\N	\N
706	345	902	0	ដៃ	0	\N	\N
707	434	942	0	នៅ	0	\N	\N
708	434	981	0	នៅ	0	\N	\N
709	434	988	0	នៅ	0	\N	\N
710	459	988	0	រងារ	0	\N	\N
711	459	446	0	រងារ	0	\N	\N
712	476	866	0	និយាយ	0	\N	\N
713	476	1040	0	និយាយ	0	\N	\N
714	21	1146	0	យឺត	0	\N	\N
715	496	1147	0	ខ្ចី	0	\N	\N
716	60	1148	0	សាច់គោ	0	\N	\N
717	70	1148	0	សាច់មាន់	0	\N	\N
718	75	1150	0	សោ	0	\N	\N
719	189	1151	0	សម	0	\N	\N
720	203	1152	0	អត់ទេ	0	\N	\N
721	226	1153	0	ផ្សារ	0	\N	\N
722	498	1154	0	ចាស់	0	\N	\N
723	321	1155	0	បងប្រុស	0	\N	\N
724	313	1156	0	ប្រពន្ធ	0	\N	\N
725	314	1157	0	ម្ដាយ	0	\N	\N
726	324	1157	0	ម្ដាយ	0	\N	\N
727	315	1159	0	ពូ	0	\N	\N
728	318	1160	0	បងស្រី	0	\N	\N
729	322	1160	0	បងស្រី	0	\N	\N
730	320	1162	0	មីង	0	\N	\N
731	331	1163	0	ពាក់	0	\N	\N
732	368	1164	0	លុប	0	\N	\N
733	443	1165	0	ចម្រៀង	0	\N	\N
734	486	1166	0	កូនប្រុស	0	\N	\N
735	507	1167	0	រឹត	0	\N	\N
736	512	1168	0	ត្រង់	0	\N	\N
737	112	1169	0	ក្បែរ	0	\N	\N
738	116	1170	0	ក្រោយ	0	\N	\N
739	307	1171	0	ក្រោយ	0	\N	\N
740	117	1172	0	មុខ	0	\N	\N
741	140	1173	0	បង្រៀន	0	\N	\N
742	348	1174	0	ត្រចៀក	0	\N	\N
743	440	1175	0	ម៉ោង	0	\N	\N
744	191	971	0	អត់ឆ្ងាញ់	0	\N	\N
745	206	674	0	អញ្ជើញ	0	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: km
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
199	17
200	17
201	17
202	17
203	17
204	17
205	17
206	17
207	17
208	18
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
221	19
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
235	20
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
246	21
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
263	22
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
278	23
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
295	24
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
308	25
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
325	26
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
340	27
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
351	28
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
364	29
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
379	30
380	30
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
396	31
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
408	32
409	32
410	32
411	32
412	32
413	32
414	32
415	32
416	32
417	32
418	32
419	33
420	33
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
432	34
433	34
434	34
435	34
436	34
437	34
438	34
439	34
440	34
441	34
442	35
443	35
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
455	36
456	36
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
469	37
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
480	38
481	38
482	38
483	38
484	38
485	38
486	38
487	38
488	38
489	38
490	38
491	38
492	38
493	39
494	39
495	39
496	39
497	39
498	39
499	39
500	39
501	39
502	39
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
355	អាទិត្យនេះ	1	អ	\N
132	ពិបាក	1	ព	\N
354	មួយខែ	1	ម	\N
14	លេង	1	ល	\N
15	ស្ថានទូត	1	ស	\N
16	ស្រឡាញ់	1	ស	\N
17	ចូលចិត្ត	1	ច	\N
18	ពូកែ	1	ព	\N
19	រត់	1	រ	\N
20	យឺត	1	យ	\N
21	មិនពូកែ	1	ម	\N
22	ដើរ	1	ដ	\N
23	ហែល	1	ហ	\N
24	រហ័ស	1	រ	\N
25	លោត	1	ល	\N
26	កីឡា	1	ក	\N
27	មិនចូលចិត្ត	1	ម	\N
28	អាងហែល	1	អ	\N
29	ឡានក្រុង	1	ឡ	\N
30	កង់	1	ក	\N
31	កាច់ជ្រុងថ្នល់	1	ក	\N
32	ផ្លូវ	1	ផ	\N
33	ស្រះ	1	ស	\N
34	ដើរលេង	1	ដ	\N
35	ទន្លេ	1	ទ	\N
36	ឡានតាក់ស៊ី	1	ឡ	\N
37	ឡាន	1	ឡ	\N
38	បត់	1	ប	\N
39	ក្រវាត់ក	1	ក	\N
40	អាវសឺមី	1	អ	\N
41	ក្រុមហ៊ុន	1	ក	\N
42	អាវធំ	1	អ	\N
43	ធ្វើ	1	ធ	\N
44	ជក់	1	ជ	\N
45	ទូរស័ព្ទ	1	ទ	\N
46	ការងារ	1	ក	\N
47	ធ្វើការ	1	ធ	\N
48	រវល់	1	រ	\N
49	បណ្ណាល័យ	1	ប	\N
50	វចនានុក្រម	1	វ	\N
51	ខ្ចី	1	ខ	\N
52	កាសែត	1	ក	\N
53	អាន	1	អ	\N
54	សៀវភៅ	1	ស	\N
55	ច្បាប់ចម្លង	1	ច	\N
56	ចម្លង	1	ច	\N
57	ទស្សនាវដ្ដី	1	ទ	\N
58	ច្បាប់	1	ច	\N
59	សាច់គោ	1	ស	\N
60	ថោក	1	ថ	\N
61	ហាង	1	ហ	\N
62	ថ្លៃ	1	ថ	\N
63	ប៉ុន្មាន	1	ប	\N
64	ផ្លែឈើ	1	ផ	\N
65	បន្លែ	1	ប	\N
66	ត្រី	1	ត	\N
67	សាច់ជ្រូក	1	ស	\N
68	សាច់មាន់	1	ស	\N
69	សាច់	1	ស	\N
70	ចង់បាន	1	ច	\N
71	ហុចឲ្យ	1	ហ	\N
72	ហាងលក់បន្លែ	1	ហ	\N
73	សោ	1	ស	\N
74	ម្ហូប	1	ម	\N
75	ទិញ	1	ទ	\N
76	បោក	1	ប	\N
77	បោស	1	ប	\N
78	ក្រុមគ្រួសារ	1	ក	\N
79	សួនច្បារ	1	ស	\N
80	បោកគក់	1	ប	\N
81	ផ្ទះ	1	ផ	\N
82	បោសសំអាត	1	ប	\N
83	ត្រឡប់ទៅ	1	ត	\N
84	ទូដាក់សៀវភៅ	1	ទ	\N
85	តុ	1	ត	\N
86	កៅអី	1	ក	\N
87	បន្ទប់	1	ប	\N
88	ទូទឹកកក	1	ទ	\N
89	ជូត	1	ជ	\N
90	គ្រែ	1	គ	\N
91	រ៉ាត់យ៉ូ	1	រ	\N
92	ម៉ាញេ	1	ម	\N
93	ខ្ញុំឈ្មោះ	1	ខ	\N
94	ដេក	1	ដ	\N
95	ក្រោក	1	ក	\N
96	ទូរទស្សន៍	1	ទ	\N
97	ប៉ូលីស	1	ប	\N
98	ប៉ូលីស	1	ប	\N
99	ផែនទី	1	ផ	\N
100	ម្តុំ	1	ម	\N
101	កន្លែងនេះ	1	ក	\N
102	កន្លែងនោះ	1	ក	\N
103	ឯណា	1	ឯ	\N
104	ប៉ុស្តិ៍ប៉ូលីស	1	ប	\N
105	ជិត	1	ជ	\N
106	ក្បែរ	1	ក	\N
107	ស្ដាប់	1	ស	\N
108	កាត់	1	ក	\N
109	ខ្លី	1	ខ	\N
110	ក្រោយ	1	ក	\N
111	មុខ	1	ម	\N
112	ស្ដាំ	1	ស	\N
113	ឆ្វេង	1	ឆ	\N
114	វែង	1	វ	\N
115	អង្គុយ	1	អ	\N
116	ឈរ	1	ឈ	\N
117	មិត្ត	1	ម	\N
118	ថ្នាក់	1	ថ	\N
119	បន្ទប់រៀន	1	ប	\N
120	ផ្លូវដើរ	1	ផ	\N
121	សាលា	1	ស	\N
122	សិស្ស	1	ស	\N
123	ការសិក្សា	1	ក	\N
124	និស្សិត	1	ន	\N
125	និស្សិតបរទេស	1	ន	\N
126	វ៉ាកងធំ	1	វ	\N
127	គ្រូ	1	គ	\N
128	សាកលវិទ្យាល័យ	1	ស	\N
129	សៀវភៅសរសេរ	1	ស	\N
130	តែងសេចក្ដី	1	ត	\N
131	កិច្ចការផ្ទះ	1	ក	\N
133	បង្រៀន	1	ប	\N
134	ប្រឡង	1	ប	\N
135	លំហាត់	1	ល	\N
136	ស្រួល	1	ស	\N
137	ហាត់	1	ហ	\N
138	សំណួរ	1	ស	\N
139	ឆ្លើយ	1	ឆ	\N
140	ឈឺ	1	ឈ	\N
141	ធ្មេញ	1	ធ	\N
142	ពេទ្យ	1	ព	\N
143	មន្ទីរពេទ្យ	1	ម	\N
144	ជម្ងឺ	1	ជ	\N
145	ថ្នាំ	1	ថ	\N
146	ស្លាប់	1	ស	\N
147	ផ្ដាសាយ	1	ផ	\N
148	ក្បាល	1	ក	\N
149	ពោះ	1	ព	\N
150	អង្សា	1	អ	\N
151	អាស់សង់ស័រ	1	អ	\N
152	សំបុត្រ	1	ស	\N
153	ចុះ	1	ច	\N
154	ជណ្ដើរ	1	ជ	\N
155	បិទ	1	ប	\N
156	ស្ថានីយ	1	ស	\N
157	រទេះភ្លើងក្រោមដី	1	រ	\N
158	ជិះ	1	ជ	\N
159	បើក	1	ប	\N
160	បន្ទប់ទឹក	1	ប	\N
161	បង្គន់	1	ប	\N
162	រទេះភ្លើង	1	រ	\N
163	ភេសជ្ជៈ	1	ភ	\N
164	កាហ្វេ	1	ក	\N
165	ហាងកាហ្វេ	1	ហ	\N
166	ក្រូចឆ្មារ	1	ក	\N
167	ទឹកដោះគោ	1	ទ	\N
168	ស្ករ	1	ស	\N
169	ពែងកែវ	1	ព	\N
170	ទឹកតែ	1	ទ	\N
171	ទឹកតែលីបតុង	1	ទ	\N
172	កែវ	1	ក	\N
173	ដាក់	1	ដ	\N
174	ផ្អែម	1	ផ	\N
175	ញ៉ាំ	1	ញ	\N
176	ចង្កើះ	1	ច	\N
177	ស្រា	1	ស	\N
178	ឆ្ងាញ់	1	ឆ	\N
179	កាំបិត	1	ក	\N
180	ស្លាបព្រា	1	ស	\N
181	សម	1	ស	\N
182	អត់ឆ្ងាញ់	1	អ	\N
183	នំប៉័ង	1	ន	\N
184	ហឹរ	1	ហ	\N
185	ហាងបាយ	1	ហ	\N
186	ស្រាទំពាំងបាយជូរ	1	ស	\N
187	ម្ហូបអាហារ	1	ម	\N
188	សម្លការី	1	ស	\N
189	លុយ	1	ល	\N
190	ធនាគារ	1	ធ	\N
191	ទ្វារចូល	1	ទ	\N
192	អញ្ជើញ	1	អ	\N
193	អត់ទេ	1	អ	\N
194	បាទ	1	ប	\N
195	អត់ទោស	1	អ	\N
196	ទ្វារចេញ	1	ទ	\N
197	ដល់	1	ដ	\N
198	ប្រអប់សំបុត្រ	1	ប	\N
199	កាតប៉ុស្តាល់	1	ក	\N
200	ស្រោមសំបុត្រ	1	ស	\N
201	ប៉ុស្តិ៍	1	ប	\N
202	សង	1	ស	\N
203	ផ្ញើ	1	ផ	\N
204	តែមប្រិ៍	1	ត	\N
205	អីវ៉ាន់	1	អ	\N
206	សន្លឹក	1	ស	\N
207	ឲ្យខ្ចី	1	ឲ្យ	\N
208	មួក	1	ម	\N
209	ស្បែកជើង	1	ស	\N
210	ទិញអីវ៉ាន់	1	ទ	\N
211	ជាន់	1	ជ	\N
212	ផ្សារ	1	ផ	\N
213	សំពត់	1	ស	\N
214	អាវរងារ	1	អ	\N
215	ខោ	1	ខ	\N
216	សូម	1	ស	\N
217	កាបូប	1	ក	\N
218	លក់	1	ល	\N
219	អាគារ	1	អ	\N
220	ផ្ទះបាយ	1	ផ	\N
221	ងូតទឹកផ្កាឈូក	1	ង	\N
222	បង្អួច	1	ប	\N
223	រស់នៅ	1	រ	\N
224	ទ្វារ	1	ទ	\N
225	ត្រាំទឹកក្តៅ	1	ត	\N
226	ផ្ទះល្វែង	1	ផ	\N
227	មាត់ទ្វារ	1	ម	\N
228	គាត់	1	គ	\N
229	ពួកគេ	1	ព	\N
230	ខ្ញុំ	1	ខ	\N
231	ពួកខ្ញុំ	1	ព	\N
232	អ្នកណាគេ	1	អ	\N
233	អ្នកណា	1	អ	\N
234	អញ្ជើញពីខាងណា	1	អ	\N
235	គាត់ឯង	1	គ	\N
236	លោក	1	ល	\N
237	នេះ	1	ន	\N
238	នោះ	1	ន	\N
239	ត្រូវការអី	1	ត	\N
240	មួយណា	1	ម	\N
241	យ៉ាងណា	1	យ	\N
242	យ៉ាងនេះ	1	យ	\N
243	ខ្លួនឯង	1	ខ	\N
244	អញ្ចឹង	1	អ	\N
245	ក្រាស់	1	ក	\N
246	ចង្អៀត	1	ច	\N
247	ស្គម	1	ស	\N
248	ធំ	1	ធ	\N
249	ធាត់	1	ធ	\N
250	ក្មេង	1	ក	\N
251	ទូលាយ	1	ទ	\N
252	ស្រាល	1	ស	\N
253	ឆ្ងាយ	1	ឆ	\N
254	ធ្ងន់	1	ធ	\N
255	ស្ដើង	1	ស	\N
256	ថ្មី	1	ថ	\N
257	តូច	1	ត	\N
258	ចាស់	1	ច	\N
259	សប្បាយ	1	ស	\N
260	អឺងកង	1	អ	\N
261	ទាប	1	ទ	\N
262	ល្អ	1	ល	\N
263	ភ្លឺ	1	ភ	\N
264	ខ្សោយ	1	ខ	\N
265	ខ្លាំង	1	ខ	\N
266	គួរឲ្យចាប់អារម្មណ៍	1	គ	\N
267	ស្អាត	1	ស	\N
268	អាក្រក់	1	អ	\N
269	ច្រើន	1	ច	\N
270	ងងឹត	1	ង	\N
271	ស្ងាត់	1	ស	\N
272	តិច	1	ត	\N
273	កខ្វក់	1	ក	\N
274	អផ្សុក	1	អ	\N
275	ទទឹង	1	ទ	\N
276	ក្នុង	1	ក	\N
277	ក្រៅ	1	ក	\N
278	កើត	1	ក	\N
279	កំពស់	1	ក	\N
280	បណ្ដោយ	1	ប	\N
281	ជើង	1	ជ	\N
282	លិច	1	ល	\N
283	ក្រោម	1	ក	\N
284	ត្បូង	1	ត	\N
285	លើ	1	ល	\N
286	បងប្អូនជីដូនមួយ	1	ប	\N
287	បងប្រុស	1	ប	\N
288	បងប្អូនប្រុស	1	ប	\N
289	យាយ	1	យ	\N
290	តា	1	ត	\N
291	ប្រពន្ធ	1	ប	\N
292	ម្ដាយ	1	ម	\N
293	ពូ	1	ព	\N
294	ឪពុកម្ដាយ	1	ឪ	\N
295	ឪពុក	1	ឪ	\N
296	បងស្រី	1	ប	\N
297	បងប្អូនស្រី	1	ប	\N
298	មីង	1	ម	\N
299	ស្រោមជើង	1	ស	\N
300	អាវ	1	អ	\N
301	ដោះ	1	ដ	\N
302	ពាក់	1	ព	\N
303	ស្លៀក	1	ស	\N
304	កន្សែងដៃ	1	ក	\N
305	ស្បែកជើងផ្ទាត់	1	ស	\N
306	ឆត្រ	1	ឆ	\N
307	កាប៉ៅ	1	ក	\N
308	កាបូបលុយ	1	ក	\N
309	ខោអាវ	1	ខ	\N
310	មាត់	1	ម	\N
311	ដៃ	1	ដ	\N
312	ខ្លួន	1	ខ	\N
313	ច្រមុះ	1	ច	\N
314	ភ្នែក	1	ភ	\N
315	ត្រចៀក	1	ត	\N
316	ចាន	1	ច	\N
317	បឺរ	1	ប	\N
318	ស្ករគ្រាប់	1	ស	\N
319	បាយថ្ងៃ	1	ប	\N
320	បាយល្ងាច	1	ប	\N
321	នំ	1	ន	\N
322	ពងមាន់	1	ព	\N
323	បាយព្រឹក	1	ប	\N
324	បាយ	1	ប	\N
325	ទឹកស៊ីអ៊ីវ	1	ទ	\N
326	អំបិល	1	អ	\N
327	ថែម	1	ថ	\N
328	កាមេរ៉ា	1	ក	\N
329	ខ្មៅដៃ	1	ខ	\N
330	លុប	1	ល	\N
331	វ៉ែនតា	1	វ	\N
332	ម៉ាញេថតសំឡេង	1	ម	\N
333	នាឡិកា	1	ន	\N
334	កុំព្យូទ័រ	1	ក	\N
335	ហ្វីលម៍	1	ហ	\N
336	ស្ទីឡូ	1	ស	\N
337	ប៊ិក	1	ប	\N
338	ខែសីហា	1	ខ	\N
339	ខែមេសា	1	ខ	\N
340	ខែនេះ	1	ខ	\N
341	រាល់ខែ	1	រ	\N
342	ខែធ្នូ	1	ខ	\N
343	ខែកុម្ភៈ	1	ខ	\N
344	ខែមករា	1	ខ	\N
345	ខែកក្កដា	1	ខ	\N
346	ខែមិថុនា	1	ខ	\N
347	ខែក្រោយ	1	ខ	\N
348	ខែឧសភា	1	ខ	\N
349	ខែមីនា	1	ខ	\N
350	ខែមុន	1	ខ	\N
351	ខែវិច្ឆិកា	1	ខ	\N
352	ខែតុលា	1	ខ	\N
353	ខែកញ្ញា	1	ខ	\N
356	រាល់អាទិត្យ	1	រ	\N
357	ថ្ងៃអាទិត្យ	1	ថ	\N
358	ថ្ងៃព្រហស្បតិ៍	1	ថ	\N
359	អាទិត្យក្រោយ	1	អ	\N
360	ថ្ងៃចន្ទ	1	ថ	\N
361	ថ្ងៃអង្គារ	1	ថ	\N
362	ថ្ងៃពុធ	1	ថ	\N
363	ថ្ងៃសៅរ៍	1	ថ	\N
364	អាទិត្យ	1	អ	\N
365	អាទិត្យមុន	1	អ	\N
366	ថ្ងៃសុក្រ	1	ថ	\N
367	ឆ្នាំ	1	ឆ	\N
368	រដូវលំហើយ	1	រ	\N
369	ឆ្នាំនេះ	1	ឆ	\N
370	រាល់ឆ្នាំ	1	រ	\N
371	រដូវក្ដៅ	1	រ	\N
372	រដូវរងារ	1	រ	\N
373	ឆ្នាំមុន	1	ឆ	\N
374	ឆ្នាំក្រោយ	1	ឆ	\N
375	រដូវផ្ការីក	1	រ	\N
376	ពីរឆ្នាំក្រោយ	1	ព	\N
377	ឆ្នាំទៅមួយ	1	ឆ	\N
378	ពេលល្ងាច	1	ព	\N
379	ថ្ងៃនេះ	1	ថ	\N
380	ថ្ងៃស្អែក	1	ថ	\N
381	ម៉ោង	1	ម	\N
382	ម្សិលមិញ	1	ម	\N
383	យប់មិញ	1	យ	\N
384	ពេលព្រឹក	1	ព	\N
385	ពេលថ្ងៃ	1	ព	\N
386	ពេលយប់	1	ព	\N
387	ខានស្អែក	1	ខ	\N
388	ម្សិលម៉្ងៃ	1	ម	\N
389	ហើយ	1	ហ	\N
390	ផង	1	ផ	\N
391	នៅ	1	ន	\N
392	ពេញ	1	ព	\N
393	ពេល	1	ព	\N
394	ពេលណា	1	ព	\N
395	ពេលខ្លះ	1	ព	\N
396	ឧស្សាហ៍	1	ឧ	\N
397	ជិតដល់	1	ជ	\N
398	ចានគោះបារី	1	ច	\N
399	ចម្រៀង	1	ច	\N
400	ច្រៀង	1	ច	\N
401	បារី	1	ប	\N
402	កុន	1	ក	\N
403	ថាសចម្រៀង	1	ថ	\N
404	ហ្គីតា	1	ហ	\N
405	ដេញ	1	ដ	\N
406	ភ្លេង	1	ភ	\N
407	គំនូរ	1	គ	\N
408	រូបថត	1	រ	\N
409	សំឡេង	1	ស	\N
410	មេឃស្រឡះ	1	ម	\N
411	ក្ដៅ	1	ក	\N
412	ស្រឡះ	1	ស	\N
413	ត្រជាក់	1	ត	\N
414	រងារ	1	រ	\N
415	ព្រឹល	1	ព	\N
416	ភ្លៀង	1	ភ	\N
417	ទឹកភ្លៀង	1	ទ	\N
418	អាកាសធាតុ	1	អ	\N
419	ក្ដៅស្រួល	1	ក	\N
420	ខ្យល់	1	ខ	\N
421	មេឃស្រទំ	1	ម	\N
422	ស្រទំ	1	ស	\N
423	អក្សរចិន	1	អ	\N
424	ថា	1	ថ	\N
425	សរសេរ	1	ស	\N
426	រឿង	1	រ	\N
427	ពាក្យ	1	ព	\N
428	ភាសា	1	ភ	\N
429	និយាយ	1	ន	\N
430	អត្ថបទ	1	អ	\N
431	និទាន	1	ន	\N
432	ន័យ	1	ន	\N
433	មនុស្សពេញវ័យ	1	ម	\N
434	ហ្វូង	1	ហ	\N
435	ប្ដីប្រពន្ធ	1	ប	\N
436	កូន	1	ក	\N
437	ស្រី	1	ស	\N
438	កូនប្រុស	1	ក	\N
439	មនុស្ស	1	ម	\N
440	ប្រុស	1	ប	\N
441	កូនស្រី	1	ក	\N
442	ប្ដី	1	ប	\N
443	ទាំងអស់គ្នា	1	ទ	\N
444	ស	1	ស	\N
445	ខៀវ	1	ខ	\N
446	ត្នោត	1	ត	\N
447	ពណ៌	1	ព	\N
448	លឿង	1	ល	\N
449	ខ្មៅ	1	ខ	\N
450	ក្រហម	1	ក	\N
451	បៃតង	1	ប	\N
452	ងាយស្រួល	1	ង	\N
453	ជប់លៀង	1	ជ	\N
454	ក្រដាស	1	ក	\N
455	ក្លាយជា	1	ក	\N
456	រឹត	1	រ	\N
457	រុញ	1	រ	\N
458	ចាប់ផ្ដើម	1	ច	\N
459	គត់	1	គ	\N
460	គ្មាន	1	គ	\N
461	ត្រង់	1	ត	\N
462	ល្បី	1	ល	\N
463	សុខសប្បាយ	1	ស	\N
464	ប្រហែល	1	ប	\N
465	ឥឡូវនេះ	1	ឥ	\N
1	ទៅ	1	ទ	\N
2	ភាសាអង់គ្លេស	1	ភ	\N
3	កប៉ាល់ហោះ	1	ក	\N
4	បរទេស	1	ប	\N
5	ជនបរទេស	1	ជ	\N
6	ភាសាខ្មែរ	1	ភ	\N
7	សណ្ឋាគារ	1	ស	\N
8	ភាសាជប៉ុន	1	ភ	\N
9	ចេញ	1	ច	\N
10	ប្រទេស	1	ប	\N
11	ជួប	1	ជ	\N
12	ថ្ងៃឈប់	1	ថ	\N
13	ធ្វើដំណើរ	1	ធ	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: km
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
1	ទៅ	\N		\N	\N	\N	867	\N
1	ទៅ	\N		\N	\N	\N	868	\N
1	ទៅ	\N		\N	\N	\N	874	\N
1	ទៅ	\N		\N	\N	\N	875	\N
1	ទៅ	\N		\N	\N	\N	876	\N
1	ទៅ	\N		\N	\N	\N	893	\N
1	ទៅ	\N		\N	\N	\N	894	\N
1	ទៅ	\N		\N	\N	\N	898	\N
1	ទៅ	\N		\N	\N	\N	908	\N
1	ទៅ	\N		\N	\N	\N	920	\N
1	ទៅ	\N		\N	\N	\N	923	\N
1	ទៅ	\N		\N	\N	\N	937	\N
1	ទៅ	\N		\N	\N	\N	975	\N
1	ទៅ	\N		\N	\N	\N	982	\N
1	ទៅ	\N		\N	\N	\N	983	\N
1	ទៅ	\N		\N	\N	\N	986	\N
1	ទៅ	\N		\N	\N	\N	1020	\N
1	ទៅ	\N		\N	\N	\N	1029	\N
1	ទៅ	\N		\N	\N	\N	1045	\N
1	ទៅ	\N		\N	\N	\N	1056	\N
1	ទៅ	\N		\N	\N	\N	1070	\N
1	ទៅ	\N		\N	\N	\N	1075	\N
1	ទៅ	\N		\N	\N	\N	1078	\N
1	ទៅ	\N		\N	\N	\N	1080	\N
1	ទៅ	\N		\N	\N	\N	1088	\N
1	ទៅ	\N		\N	\N	\N	1092	\N
1	ទៅ	\N		\N	\N	\N	1103	\N
1	ទៅ	\N		\N	\N	\N	1124	\N
1	ទៅ	\N		\N	\N	\N	1	\N
1	ទៅ	\N		\N	\N	\N	2	\N
1	ទៅ	\N		\N	\N	\N	22	\N
1	ទៅ	\N		\N	\N	\N	39	\N
1	ទៅ	\N		\N	\N	\N	91	\N
1	ទៅ	\N		\N	\N	\N	101	\N
1	ទៅ	\N		\N	\N	\N	104	\N
1	ទៅ	\N		\N	\N	\N	109	\N
1	ទៅ	\N		\N	\N	\N	110	\N
1	ទៅ	\N		\N	\N	\N	111	\N
1	ទៅ	\N		\N	\N	\N	121	\N
1	ទៅ	\N		\N	\N	\N	122	\N
1	ទៅ	\N		\N	\N	\N	123	\N
1	ទៅ	\N		\N	\N	\N	136	\N
1	ទៅ	\N		\N	\N	\N	137	\N
1	ទៅ	\N		\N	\N	\N	139	\N
1	ទៅ	\N		\N	\N	\N	153	\N
1	ទៅ	\N		\N	\N	\N	154	\N
1	ទៅ	\N		\N	\N	\N	172	\N
1	ទៅ	\N		\N	\N	\N	173	\N
1	ទៅ	\N		\N	\N	\N	174	\N
1	ទៅ	\N		\N	\N	\N	176	\N
1	ទៅ	\N		\N	\N	\N	179	\N
1	ទៅ	\N		\N	\N	\N	180	\N
1	ទៅ	\N		\N	\N	\N	181	\N
1	ទៅ	\N		\N	\N	\N	192	\N
1	ទៅ	\N		\N	\N	\N	193	\N
1	ទៅ	\N		\N	\N	\N	195	\N
1	ទៅ	\N		\N	\N	\N	209	\N
1	ទៅ	\N		\N	\N	\N	210	\N
1	ទៅ	\N		\N	\N	\N	211	\N
1	ទៅ	\N		\N	\N	\N	217	\N
1	ទៅ	\N		\N	\N	\N	218	\N
1	ទៅ	\N		\N	\N	\N	219	\N
1	ទៅ	\N		\N	\N	\N	221	\N
1	ទៅ	\N		\N	\N	\N	222	\N
1	ទៅ	\N		\N	\N	\N	242	\N
1	ទៅ	\N		\N	\N	\N	259	\N
1	ទៅ	\N		\N	\N	\N	311	\N
1	ទៅ	\N		\N	\N	\N	321	\N
1	ទៅ	\N		\N	\N	\N	324	\N
1	ទៅ	\N		\N	\N	\N	329	\N
1	ទៅ	\N		\N	\N	\N	330	\N
1	ទៅ	\N		\N	\N	\N	331	\N
1	ទៅ	\N		\N	\N	\N	341	\N
1	ទៅ	\N		\N	\N	\N	342	\N
1	ទៅ	\N		\N	\N	\N	343	\N
1	ទៅ	\N		\N	\N	\N	356	\N
1	ទៅ	\N		\N	\N	\N	357	\N
1	ទៅ	\N		\N	\N	\N	359	\N
1	ទៅ	\N		\N	\N	\N	373	\N
1	ទៅ	\N		\N	\N	\N	374	\N
1	ទៅ	\N		\N	\N	\N	392	\N
1	ទៅ	\N		\N	\N	\N	393	\N
1	ទៅ	\N		\N	\N	\N	394	\N
1	ទៅ	\N		\N	\N	\N	396	\N
1	ទៅ	\N		\N	\N	\N	399	\N
1	ទៅ	\N		\N	\N	\N	400	\N
1	ទៅ	\N		\N	\N	\N	401	\N
1	ទៅ	\N		\N	\N	\N	412	\N
1	ទៅ	\N		\N	\N	\N	413	\N
1	ទៅ	\N		\N	\N	\N	415	\N
1	ទៅ	\N		\N	\N	\N	429	\N
1	ទៅ	\N		\N	\N	\N	430	\N
1	ទៅ	\N		\N	\N	\N	431	\N
1	ទៅ	\N		\N	\N	\N	437	\N
1	ទៅ	\N		\N	\N	\N	438	\N
1	ទៅ	\N		\N	\N	\N	439	\N
1	ទៅ	\N		\N	\N	\N	450	\N
1	ទៅ	\N		\N	\N	\N	453	\N
1	ទៅ	\N		\N	\N	\N	484	\N
1	ទៅ	\N		\N	\N	\N	485	\N
1	ទៅ	\N		\N	\N	\N	486	\N
1	ទៅ	\N		\N	\N	\N	494	\N
1	ទៅ	\N		\N	\N	\N	512	\N
1	ទៅ	\N		\N	\N	\N	522	\N
1	ទៅ	\N		\N	\N	\N	524	\N
1	ទៅ	\N		\N	\N	\N	534	\N
1	ទៅ	\N		\N	\N	\N	544	\N
1	ទៅ	\N		\N	\N	\N	551	\N
1	ទៅ	\N		\N	\N	\N	566	\N
1	ទៅ	\N		\N	\N	\N	589	\N
1	ទៅ	\N		\N	\N	\N	594	\N
1	ទៅ	\N		\N	\N	\N	597	\N
1	ទៅ	\N		\N	\N	\N	611	\N
1	ទៅ	\N		\N	\N	\N	612	\N
1	ទៅ	\N		\N	\N	\N	615	\N
1	ទៅ	\N		\N	\N	\N	616	\N
1	ទៅ	\N		\N	\N	\N	625	\N
1	ទៅ	\N		\N	\N	\N	635	\N
1	ទៅ	\N		\N	\N	\N	639	\N
1	ទៅ	\N		\N	\N	\N	640	\N
1	ទៅ	\N		\N	\N	\N	648	\N
1	ទៅ	\N		\N	\N	\N	659	\N
1	ទៅ	\N		\N	\N	\N	662	\N
1	ទៅ	\N		\N	\N	\N	664	\N
1	ទៅ	\N		\N	\N	\N	691	\N
1	ទៅ	\N		\N	\N	\N	719	\N
1	ទៅ	\N		\N	\N	\N	727	\N
1	ទៅ	\N		\N	\N	\N	764	\N
1	ទៅ	\N		\N	\N	\N	765	\N
1	ទៅ	\N		\N	\N	\N	770	\N
1	ទៅ	\N		\N	\N	\N	771	\N
1	ទៅ	\N		\N	\N	\N	788	\N
1	ទៅ	\N		\N	\N	\N	799	\N
2	ភាសាអង់គ្លេស	\N		\N	\N	\N	866	\N
3	កប៉ាល់ហោះ	\N		\N	\N	\N	867	\N
4	បរទេស	\N		\N	\N	\N	868	\N
4	បរទេស	\N		\N	\N	\N	869	\N
4	បរទេស	\N		\N	\N	\N	903	\N
4	បរទេស	\N		\N	\N	\N	934	\N
4	បរទេស	\N		\N	\N	\N	936	\N
5	ជនបរទេស	\N		\N	\N	\N	869	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	870	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	936	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	5	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	28	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	175	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	177	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	194	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	196	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	225	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	248	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	395	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	397	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	414	\N
6	ភាសាខ្មែរ	\N		\N	\N	\N	416	\N
7	សណ្ឋាគារ	\N		\N	\N	\N	871	\N
7	សណ្ឋាគារ	\N		\N	\N	\N	932	\N
8	ភាសាជប៉ុន	\N		\N	\N	\N	44	\N
8	ភាសាជប៉ុន	\N		\N	\N	\N	264	\N
8	ភាសាជប៉ុន	\N		\N	\N	\N	447	\N
9	ចេញ	\N		\N	\N	\N	980	\N
9	ចេញ	\N		\N	\N	\N	1016	\N
9	ចេញ	\N		\N	\N	\N	1055	\N
9	ចេញ	\N		\N	\N	\N	1092	\N
9	ចេញ	\N		\N	\N	\N	1103	\N
9	ចេញ	\N		\N	\N	\N	544	\N
9	ចេញ	\N		\N	\N	\N	561	\N
9	ចេញ	\N		\N	\N	\N	612	\N
9	ចេញ	\N		\N	\N	\N	621	\N
9	ចេញ	\N		\N	\N	\N	634	\N
9	ចេញ	\N		\N	\N	\N	725	\N
10	ប្រទេស	\N		\N	\N	\N	1028	\N
10	ប្រទេស	\N		\N	\N	\N	1085	\N
10	ប្រទេស	\N		\N	\N	\N	1132	\N
10	ប្រទេស	\N		\N	\N	\N	522	\N
10	ប្រទេស	\N		\N	\N	\N	524	\N
11	ជួប	\N		\N	\N	\N	980	\N
11	ជួប	\N		\N	\N	\N	995	\N
11	ជួប	\N		\N	\N	\N	1001	\N
11	ជួប	\N		\N	\N	\N	630	\N
11	ជួប	\N		\N	\N	\N	803	\N
12	ថ្ងៃឈប់	\N		\N	\N	\N	872	\N
12	ថ្ងៃឈប់	\N		\N	\N	\N	1062	\N
12	ថ្ងៃឈប់	\N		\N	\N	\N	1069	\N
13	ធ្វើដំណើរ	\N		\N	\N	\N	868	\N
13	ធ្វើដំណើរ	\N		\N	\N	\N	873	\N
13	ធ្វើដំណើរ	\N		\N	\N	\N	874	\N
13	ធ្វើដំណើរ	\N		\N	\N	\N	1133	\N
14	លេង	\N		\N	\N	\N	874	\N
14	លេង	\N		\N	\N	\N	886	\N
14	លេង	\N		\N	\N	\N	994	\N
14	លេង	\N		\N	\N	\N	1016	\N
14	លេង	\N		\N	\N	\N	1024	\N
14	លេង	\N		\N	\N	\N	1040	\N
14	លេង	\N		\N	\N	\N	1052	\N
14	លេង	\N		\N	\N	\N	1064	\N
14	លេង	\N		\N	\N	\N	1070	\N
14	លេង	\N		\N	\N	\N	1071	\N
14	លេង	\N		\N	\N	\N	1088	\N
14	លេង	\N		\N	\N	\N	1108	\N
14	លេង	\N		\N	\N	\N	213	\N
14	លេង	\N		\N	\N	\N	433	\N
14	លេង	\N		\N	\N	\N	639	\N
14	លេង	\N		\N	\N	\N	644	\N
15	ស្ថានទូត	\N		\N	\N	\N	869	\N
15	ស្ថានទូត	\N		\N	\N	\N	875	\N
16	ស្រឡាញ់	\N		\N	\N	\N	1065	\N
16	ស្រឡាញ់	\N		\N	\N	\N	589	\N
17	ចូលចិត្ត	\N		\N	\N	\N	880	\N
17	ចូលចិត្ត	\N		\N	\N	\N	885	\N
17	ចូលចិត្ត	\N		\N	\N	\N	987	\N
17	ចូលចិត្ត	\N		\N	\N	\N	1041	\N
17	ចូលចិត្ត	\N		\N	\N	\N	1042	\N
17	ចូលចិត្ត	\N		\N	\N	\N	606	\N
17	ចូលចិត្ត	\N		\N	\N	\N	607	\N
17	ចូលចិត្ត	\N		\N	\N	\N	608	\N
17	ចូលចិត្ត	\N		\N	\N	\N	609	\N
17	ចូលចិត្ត	\N		\N	\N	\N	614	\N
17	ចូលចិត្ត	\N		\N	\N	\N	616	\N
17	ចូលចិត្ត	\N		\N	\N	\N	649	\N
17	ចូលចិត្ត	\N		\N	\N	\N	650	\N
17	ចូលចិត្ត	\N		\N	\N	\N	651	\N
17	ចូលចិត្ត	\N		\N	\N	\N	652	\N
17	ចូលចិត្ត	\N		\N	\N	\N	654	\N
17	ចូលចិត្ត	\N		\N	\N	\N	655	\N
17	ចូលចិត្ត	\N		\N	\N	\N	656	\N
18	ពូកែ	\N		\N	\N	\N	877	\N
18	ពូកែ	\N		\N	\N	\N	890	\N
18	ពូកែ	\N		\N	\N	\N	1107	\N
18	ពូកែ	\N		\N	\N	\N	3	\N
18	ពូកែ	\N		\N	\N	\N	4	\N
18	ពូកែ	\N		\N	\N	\N	83	\N
18	ពូកែ	\N		\N	\N	\N	223	\N
18	ពូកែ	\N		\N	\N	\N	224	\N
18	ពូកែ	\N		\N	\N	\N	303	\N
18	ពូកែ	\N		\N	\N	\N	573	\N
18	ពូកែ	\N		\N	\N	\N	653	\N
18	ពូកែ	\N		\N	\N	\N	801	\N
19	រត់	\N		\N	\N	\N	876	\N
19	រត់	\N		\N	\N	\N	882	\N
19	រត់	\N		\N	\N	\N	1102	\N
20	យឺត	\N		\N	\N	\N	1102	\N
20	យឺត	\N		\N	\N	\N	36	\N
20	យឺត	\N		\N	\N	\N	79	\N
391	នៅ	\N		\N	\N	\N	523	\N
20	យឺត	\N		\N	\N	\N	256	\N
20	យឺត	\N		\N	\N	\N	299	\N
20	យឺត	\N		\N	\N	\N	477	\N
20	យឺត	\N		\N	\N	\N	479	\N
20	យឺត	\N		\N	\N	\N	507	\N
21	មិនពូកែ	\N		\N	\N	\N	877	\N
22	ដើរ	\N		\N	\N	\N	876	\N
22	ដើរ	\N		\N	\N	\N	880	\N
22	ដើរ	\N		\N	\N	\N	886	\N
22	ដើរ	\N		\N	\N	\N	918	\N
22	ដើរ	\N		\N	\N	\N	932	\N
22	ដើរ	\N		\N	\N	\N	955	\N
22	ដើរ	\N		\N	\N	\N	979	\N
22	ដើរ	\N		\N	\N	\N	1064	\N
22	ដើរ	\N		\N	\N	\N	1066	\N
22	ដើរ	\N		\N	\N	\N	1071	\N
22	ដើរ	\N		\N	\N	\N	644	\N
22	ដើរ	\N		\N	\N	\N	701	\N
23	ហែល	\N		\N	\N	\N	881	\N
23	ហែល	\N		\N	\N	\N	596	\N
23	ហែល	\N		\N	\N	\N	601	\N
23	ហែល	\N		\N	\N	\N	627	\N
23	ហែល	\N		\N	\N	\N	652	\N
23	ហែល	\N		\N	\N	\N	653	\N
23	ហែល	\N		\N	\N	\N	654	\N
23	ហែល	\N		\N	\N	\N	668	\N
23	ហែល	\N		\N	\N	\N	792	\N
24	រហ័ស	\N		\N	\N	\N	878	\N
25	លោត	\N		\N	\N	\N	879	\N
26	កីឡា	\N		\N	\N	\N	994	\N
26	កីឡា	\N		\N	\N	\N	651	\N
28	អាងហែល	\N		\N	\N	\N	881	\N
29	ឡានក្រុង	\N		\N	\N	\N	882	\N
30	កង់	\N		\N	\N	\N	883	\N
31	កាច់ជ្រុងថ្នល់	\N		\N	\N	\N	884	\N
32	ផ្លូវ	\N		\N	\N	\N	932	\N
32	ផ្លូវ	\N		\N	\N	\N	961	\N
32	ផ្លូវ	\N		\N	\N	\N	1025	\N
32	ផ្លូវ	\N		\N	\N	\N	503	\N
33	ស្រះ	\N		\N	\N	\N	885	\N
34	ដើរលេង	\N		\N	\N	\N	886	\N
34	ដើរលេង	\N		\N	\N	\N	1064	\N
34	ដើរលេង	\N		\N	\N	\N	1071	\N
35	ទន្លេ	\N		\N	\N	\N	886	\N
35	ទន្លេ	\N		\N	\N	\N	887	\N
35	ទន្លេ	\N		\N	\N	\N	1073	\N
36	ឡានតាក់ស៊ី	\N		\N	\N	\N	888	\N
37	ឡាន	\N		\N	\N	\N	882	\N
37	ឡាន	\N		\N	\N	\N	888	\N
37	ឡាន	\N		\N	\N	\N	921	\N
37	ឡាន	\N		\N	\N	\N	927	\N
37	ឡាន	\N		\N	\N	\N	1025	\N
37	ឡាន	\N		\N	\N	\N	1136	\N
37	ឡាន	\N		\N	\N	\N	458	\N
37	ឡាន	\N		\N	\N	\N	459	\N
38	បត់	\N		\N	\N	\N	889	\N
39	ក្រវាត់ក	\N		\N	\N	\N	890	\N
40	អាវសឺមី	\N		\N	\N	\N	891	\N
41	ក្រុមហ៊ុន	\N		\N	\N	\N	892	\N
42	អាវធំ	\N		\N	\N	\N	893	\N
42	អាវធំ	\N		\N	\N	\N	990	\N
43	ធ្វើ	\N		\N	\N	\N	868	\N
43	ធ្វើ	\N		\N	\N	\N	873	\N
43	ធ្វើ	\N		\N	\N	\N	874	\N
43	ធ្វើ	\N		\N	\N	\N	942	\N
43	ធ្វើ	\N		\N	\N	\N	944	\N
43	ធ្វើ	\N		\N	\N	\N	963	\N
43	ធ្វើ	\N		\N	\N	\N	990	\N
43	ធ្វើ	\N		\N	\N	\N	997	\N
43	ធ្វើ	\N		\N	\N	\N	1005	\N
43	ធ្វើ	\N		\N	\N	\N	1032	\N
43	ធ្វើ	\N		\N	\N	\N	1059	\N
43	ធ្វើ	\N		\N	\N	\N	1076	\N
43	ធ្វើ	\N		\N	\N	\N	1080	\N
43	ធ្វើ	\N		\N	\N	\N	1099	\N
43	ធ្វើ	\N		\N	\N	\N	1133	\N
43	ធ្វើ	\N		\N	\N	\N	1135	\N
43	ធ្វើ	\N		\N	\N	\N	83	\N
43	ធ្វើ	\N		\N	\N	\N	182	\N
43	ធ្វើ	\N		\N	\N	\N	204	\N
43	ធ្វើ	\N		\N	\N	\N	303	\N
43	ធ្វើ	\N		\N	\N	\N	402	\N
43	ធ្វើ	\N		\N	\N	\N	424	\N
43	ធ្វើ	\N		\N	\N	\N	483	\N
43	ធ្វើ	\N		\N	\N	\N	492	\N
43	ធ្វើ	\N		\N	\N	\N	493	\N
43	ធ្វើ	\N		\N	\N	\N	500	\N
43	ធ្វើ	\N		\N	\N	\N	502	\N
43	ធ្វើ	\N		\N	\N	\N	517	\N
43	ធ្វើ	\N		\N	\N	\N	520	\N
43	ធ្វើ	\N		\N	\N	\N	525	\N
43	ធ្វើ	\N		\N	\N	\N	528	\N
43	ធ្វើ	\N		\N	\N	\N	532	\N
43	ធ្វើ	\N		\N	\N	\N	541	\N
43	ធ្វើ	\N		\N	\N	\N	544	\N
43	ធ្វើ	\N		\N	\N	\N	559	\N
43	ធ្វើ	\N		\N	\N	\N	562	\N
43	ធ្វើ	\N		\N	\N	\N	569	\N
43	ធ្វើ	\N		\N	\N	\N	571	\N
43	ធ្វើ	\N		\N	\N	\N	572	\N
43	ធ្វើ	\N		\N	\N	\N	581	\N
43	ធ្វើ	\N		\N	\N	\N	582	\N
43	ធ្វើ	\N		\N	\N	\N	595	\N
43	ធ្វើ	\N		\N	\N	\N	614	\N
43	ធ្វើ	\N		\N	\N	\N	618	\N
43	ធ្វើ	\N		\N	\N	\N	619	\N
43	ធ្វើ	\N		\N	\N	\N	624	\N
43	ធ្វើ	\N		\N	\N	\N	635	\N
43	ធ្វើ	\N		\N	\N	\N	643	\N
43	ធ្វើ	\N		\N	\N	\N	671	\N
43	ធ្វើ	\N		\N	\N	\N	672	\N
43	ធ្វើ	\N		\N	\N	\N	690	\N
43	ធ្វើ	\N		\N	\N	\N	718	\N
43	ធ្វើ	\N		\N	\N	\N	747	\N
43	ធ្វើ	\N		\N	\N	\N	757	\N
43	ធ្វើ	\N		\N	\N	\N	774	\N
43	ធ្វើ	\N		\N	\N	\N	801	\N
44	ជក់	\N		\N	\N	\N	155	\N
44	ជក់	\N		\N	\N	\N	375	\N
45	ទូរស័ព្ទ	\N		\N	\N	\N	679	\N
46	ការងារ	\N		\N	\N	\N	937	\N
46	ការងារ	\N		\N	\N	\N	1063	\N
46	ការងារ	\N		\N	\N	\N	1126	\N
46	ការងារ	\N		\N	\N	\N	457	\N
46	ការងារ	\N		\N	\N	\N	469	\N
46	ការងារ	\N		\N	\N	\N	612	\N
46	ការងារ	\N		\N	\N	\N	614	\N
46	ការងារ	\N		\N	\N	\N	617	\N
46	ការងារ	\N		\N	\N	\N	715	\N
46	ការងារ	\N		\N	\N	\N	716	\N
46	ការងារ	\N		\N	\N	\N	718	\N
46	ការងារ	\N		\N	\N	\N	719	\N
46	ការងារ	\N		\N	\N	\N	721	\N
46	ការងារ	\N		\N	\N	\N	753	\N
46	ការងារ	\N		\N	\N	\N	756	\N
46	ការងារ	\N		\N	\N	\N	800	\N
47	ធ្វើការ	\N		\N	\N	\N	1032	\N
47	ធ្វើការ	\N		\N	\N	\N	1076	\N
47	ធ្វើការ	\N		\N	\N	\N	1099	\N
47	ធ្វើការ	\N		\N	\N	\N	83	\N
47	ធ្វើការ	\N		\N	\N	\N	303	\N
47	ធ្វើការ	\N		\N	\N	\N	502	\N
47	ធ្វើការ	\N		\N	\N	\N	517	\N
47	ធ្វើការ	\N		\N	\N	\N	520	\N
47	ធ្វើការ	\N		\N	\N	\N	525	\N
47	ធ្វើការ	\N		\N	\N	\N	528	\N
47	ធ្វើការ	\N		\N	\N	\N	532	\N
47	ធ្វើការ	\N		\N	\N	\N	544	\N
47	ធ្វើការ	\N		\N	\N	\N	595	\N
47	ធ្វើការ	\N		\N	\N	\N	635	\N
47	ធ្វើការ	\N		\N	\N	\N	757	\N
47	ធ្វើការ	\N		\N	\N	\N	801	\N
48	រវល់	\N		\N	\N	\N	894	\N
48	រវល់	\N		\N	\N	\N	1101	\N
49	បណ្ណាល័យ	\N		\N	\N	\N	895	\N
50	វចនានុក្រម	\N		\N	\N	\N	585	\N
50	វចនានុក្រម	\N		\N	\N	\N	590	\N
50	វចនានុក្រម	\N		\N	\N	\N	695	\N
51	ខ្ចី	\N		\N	\N	\N	985	\N
51	ខ្ចី	\N		\N	\N	\N	588	\N
51	ខ្ចី	\N		\N	\N	\N	713	\N
52	កាសែត	\N		\N	\N	\N	896	\N
52	កាសែត	\N		\N	\N	\N	912	\N
53	អាន	\N		\N	\N	\N	896	\N
53	អាន	\N		\N	\N	\N	708	\N
53	អាន	\N		\N	\N	\N	713	\N
54	សៀវភៅ	\N		\N	\N	\N	909	\N
54	សៀវភៅ	\N		\N	\N	\N	923	\N
54	សៀវភៅ	\N		\N	\N	\N	939	\N
54	សៀវភៅ	\N		\N	\N	\N	68	\N
54	សៀវភៅ	\N		\N	\N	\N	162	\N
54	សៀវភៅ	\N		\N	\N	\N	163	\N
54	សៀវភៅ	\N		\N	\N	\N	201	\N
54	សៀវភៅ	\N		\N	\N	\N	208	\N
54	សៀវភៅ	\N		\N	\N	\N	288	\N
54	សៀវភៅ	\N		\N	\N	\N	382	\N
54	សៀវភៅ	\N		\N	\N	\N	383	\N
54	សៀវភៅ	\N		\N	\N	\N	421	\N
54	សៀវភៅ	\N		\N	\N	\N	428	\N
54	សៀវភៅ	\N		\N	\N	\N	582	\N
54	សៀវភៅ	\N		\N	\N	\N	583	\N
54	សៀវភៅ	\N		\N	\N	\N	708	\N
54	សៀវភៅ	\N		\N	\N	\N	709	\N
55	ច្បាប់ចម្លង	\N		\N	\N	\N	897	\N
56	ចម្លង	\N		\N	\N	\N	897	\N
56	ចម្លង	\N		\N	\N	\N	898	\N
58	ច្បាប់	\N		\N	\N	\N	897	\N
58	ច្បាប់	\N		\N	\N	\N	947	\N
58	ច្បាប់	\N		\N	\N	\N	1129	\N
58	ច្បាប់	\N		\N	\N	\N	690	\N
59	សាច់គោ	\N		\N	\N	\N	811	\N
60	ថោក	\N		\N	\N	\N	974	\N
60	ថោក	\N		\N	\N	\N	705	\N
61	ហាង	\N		\N	\N	\N	903	\N
61	ហាង	\N		\N	\N	\N	963	\N
61	ហាង	\N		\N	\N	\N	974	\N
61	ហាង	\N		\N	\N	\N	1006	\N
61	ហាង	\N		\N	\N	\N	1052	\N
61	ហាង	\N		\N	\N	\N	648	\N
62	ថ្លៃ	\N		\N	\N	\N	983	\N
62	ថ្លៃ	\N		\N	\N	\N	1059	\N
62	ថ្លៃ	\N		\N	\N	\N	507	\N
62	ថ្លៃ	\N		\N	\N	\N	508	\N
62	ថ្លៃ	\N		\N	\N	\N	509	\N
62	ថ្លៃ	\N		\N	\N	\N	697	\N
62	ថ្លៃ	\N		\N	\N	\N	698	\N
62	ថ្លៃ	\N		\N	\N	\N	699	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	983	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	120	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	340	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	507	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	510	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	542	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	548	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	550	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	552	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	554	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	597	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	626	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	776	\N
63	ប៉ុន្មាន	\N		\N	\N	\N	791	\N
64	ផ្លែឈើ	\N		\N	\N	\N	900	\N
65	បន្លែ	\N		\N	\N	\N	901	\N
65	បន្លែ	\N		\N	\N	\N	903	\N
66	ត្រី	\N		\N	\N	\N	878	\N
66	ត្រី	\N		\N	\N	\N	950	\N
66	ត្រី	\N		\N	\N	\N	1026	\N
66	ត្រី	\N		\N	\N	\N	1047	\N
66	ត្រី	\N		\N	\N	\N	35	\N
66	ត្រី	\N		\N	\N	\N	51	\N
66	ត្រី	\N		\N	\N	\N	56	\N
66	ត្រី	\N		\N	\N	\N	59	\N
66	ត្រី	\N		\N	\N	\N	60	\N
444	ស	\N		\N	\N	\N	926	\N
66	ត្រី	\N		\N	\N	\N	77	\N
66	ត្រី	\N		\N	\N	\N	100	\N
66	ត្រី	\N		\N	\N	\N	255	\N
66	ត្រី	\N		\N	\N	\N	271	\N
66	ត្រី	\N		\N	\N	\N	276	\N
66	ត្រី	\N		\N	\N	\N	279	\N
66	ត្រី	\N		\N	\N	\N	280	\N
66	ត្រី	\N		\N	\N	\N	297	\N
66	ត្រី	\N		\N	\N	\N	320	\N
66	ត្រី	\N		\N	\N	\N	534	\N
66	ត្រី	\N		\N	\N	\N	535	\N
66	ត្រី	\N		\N	\N	\N	536	\N
66	ត្រី	\N		\N	\N	\N	538	\N
66	ត្រី	\N		\N	\N	\N	541	\N
67	សាច់ជ្រូក	\N		\N	\N	\N	780	\N
67	សាច់ជ្រូក	\N		\N	\N	\N	811	\N
68	សាច់មាន់	\N		\N	\N	\N	811	\N
69	សាច់	\N		\N	\N	\N	972	\N
69	សាច់	\N		\N	\N	\N	854	\N
69	សាច់	\N		\N	\N	\N	780	\N
69	សាច់	\N		\N	\N	\N	811	\N
70	ចង់បាន	\N		\N	\N	\N	788	\N
71	ហុចឲ្យ	\N		\N	\N	\N	902	\N
72	ហាងលក់បន្លែ	\N		\N	\N	\N	903	\N
73	សោ	\N		\N	\N	\N	922	\N
73	សោ	\N		\N	\N	\N	971	\N
73	សោ	\N		\N	\N	\N	1019	\N
73	សោ	\N		\N	\N	\N	1023	\N
73	សោ	\N		\N	\N	\N	1071	\N
73	សោ	\N		\N	\N	\N	1081	\N
73	សោ	\N		\N	\N	\N	1112	\N
73	សោ	\N		\N	\N	\N	1139	\N
73	សោ	\N		\N	\N	\N	92	\N
73	សោ	\N		\N	\N	\N	312	\N
73	សោ	\N		\N	\N	\N	640	\N
73	សោ	\N		\N	\N	\N	673	\N
74	ម្ហូប	\N		\N	\N	\N	976	\N
74	ម្ហូប	\N		\N	\N	\N	1044	\N
74	ម្ហូប	\N		\N	\N	\N	6	\N
74	ម្ហូប	\N		\N	\N	\N	32	\N
74	ម្ហូប	\N		\N	\N	\N	33	\N
74	ម្ហូប	\N		\N	\N	\N	226	\N
74	ម្ហូប	\N		\N	\N	\N	252	\N
74	ម្ហូប	\N		\N	\N	\N	253	\N
75	ទិញ	\N		\N	\N	\N	982	\N
75	ទិញ	\N		\N	\N	\N	986	\N
75	ទិញ	\N		\N	\N	\N	998	\N
75	ទិញ	\N		\N	\N	\N	1054	\N
75	ទិញ	\N		\N	\N	\N	1059	\N
75	ទិញ	\N		\N	\N	\N	1104	\N
75	ទិញ	\N		\N	\N	\N	64	\N
75	ទិញ	\N		\N	\N	\N	65	\N
75	ទិញ	\N		\N	\N	\N	284	\N
75	ទិញ	\N		\N	\N	\N	285	\N
75	ទិញ	\N		\N	\N	\N	512	\N
76	បោក	\N		\N	\N	\N	907	\N
76	បោក	\N		\N	\N	\N	11	\N
76	បោក	\N		\N	\N	\N	12	\N
76	បោក	\N		\N	\N	\N	18	\N
76	បោក	\N		\N	\N	\N	20	\N
76	បោក	\N		\N	\N	\N	72	\N
76	បោក	\N		\N	\N	\N	231	\N
76	បោក	\N		\N	\N	\N	232	\N
76	បោក	\N		\N	\N	\N	238	\N
76	បោក	\N		\N	\N	\N	240	\N
76	បោក	\N		\N	\N	\N	292	\N
76	បោក	\N		\N	\N	\N	545	\N
77	បោស	\N		\N	\N	\N	1023	\N
77	បោស	\N		\N	\N	\N	545	\N
78	ក្រុមគ្រួសារ	\N		\N	\N	\N	904	\N
78	ក្រុមគ្រួសារ	\N		\N	\N	\N	905	\N
79	សួនច្បារ	\N		\N	\N	\N	906	\N
79	សួនច្បារ	\N		\N	\N	\N	996	\N
80	បោកគក់	\N		\N	\N	\N	907	\N
81	ផ្ទះ	\N		\N	\N	\N	881	\N
81	ផ្ទះ	\N		\N	\N	\N	906	\N
81	ផ្ទះ	\N		\N	\N	\N	908	\N
81	ផ្ទះ	\N		\N	\N	\N	917	\N
81	ផ្ទះ	\N		\N	\N	\N	942	\N
81	ផ្ទះ	\N		\N	\N	\N	944	\N
81	ផ្ទះ	\N		\N	\N	\N	981	\N
81	ផ្ទះ	\N		\N	\N	\N	991	\N
81	ផ្ទះ	\N		\N	\N	\N	993	\N
81	ផ្ទះ	\N		\N	\N	\N	999	\N
81	ផ្ទះ	\N		\N	\N	\N	1008	\N
81	ផ្ទះ	\N		\N	\N	\N	1012	\N
81	ផ្ទះ	\N		\N	\N	\N	1023	\N
81	ផ្ទះ	\N		\N	\N	\N	1024	\N
81	ផ្ទះ	\N		\N	\N	\N	1039	\N
81	ផ្ទះ	\N		\N	\N	\N	1103	\N
81	ផ្ទះ	\N		\N	\N	\N	1115	\N
81	ផ្ទះ	\N		\N	\N	\N	1117	\N
81	ផ្ទះ	\N		\N	\N	\N	1133	\N
81	ផ្ទះ	\N		\N	\N	\N	23	\N
81	ផ្ទះ	\N		\N	\N	\N	43	\N
81	ផ្ទះ	\N		\N	\N	\N	48	\N
81	ផ្ទះ	\N		\N	\N	\N	49	\N
81	ផ្ទះ	\N		\N	\N	\N	127	\N
81	ផ្ទះ	\N		\N	\N	\N	128	\N
81	ផ្ទះ	\N		\N	\N	\N	129	\N
81	ផ្ទះ	\N		\N	\N	\N	164	\N
81	ផ្ទះ	\N		\N	\N	\N	840	\N
81	ផ្ទះ	\N		\N	\N	\N	243	\N
81	ផ្ទះ	\N		\N	\N	\N	263	\N
81	ផ្ទះ	\N		\N	\N	\N	268	\N
81	ផ្ទះ	\N		\N	\N	\N	269	\N
81	ផ្ទះ	\N		\N	\N	\N	347	\N
81	ផ្ទះ	\N		\N	\N	\N	348	\N
81	ផ្ទះ	\N		\N	\N	\N	349	\N
81	ផ្ទះ	\N		\N	\N	\N	384	\N
81	ផ្ទះ	\N		\N	\N	\N	446	\N
81	ផ្ទះ	\N		\N	\N	\N	545	\N
81	ផ្ទះ	\N		\N	\N	\N	644	\N
82	បោសសំអាត	\N		\N	\N	\N	545	\N
83	ត្រឡប់ទៅ	\N		\N	\N	\N	908	\N
83	ត្រឡប់ទៅ	\N		\N	\N	\N	937	\N
84	ទូដាក់សៀវភៅ	\N		\N	\N	\N	909	\N
85	តុ	\N		\N	\N	\N	906	\N
85	តុ	\N		\N	\N	\N	910	\N
85	តុ	\N		\N	\N	\N	919	\N
85	តុ	\N		\N	\N	\N	967	\N
85	តុ	\N		\N	\N	\N	1012	\N
85	តុ	\N		\N	\N	\N	1066	\N
85	តុ	\N		\N	\N	\N	1116	\N
85	តុ	\N		\N	\N	\N	202	\N
85	តុ	\N		\N	\N	\N	215	\N
85	តុ	\N		\N	\N	\N	422	\N
85	តុ	\N		\N	\N	\N	435	\N
85	តុ	\N		\N	\N	\N	524	\N
85	តុ	\N		\N	\N	\N	665	\N
85	តុ	\N		\N	\N	\N	670	\N
85	តុ	\N		\N	\N	\N	746	\N
85	តុ	\N		\N	\N	\N	775	\N
86	កៅអី	\N		\N	\N	\N	910	\N
87	បន្ទប់	\N		\N	\N	\N	931	\N
87	បន្ទប់	\N		\N	\N	\N	959	\N
87	បន្ទប់	\N		\N	\N	\N	991	\N
87	បន្ទប់	\N		\N	\N	\N	786	\N
87	បន្ទប់	\N		\N	\N	\N	787	\N
87	បន្ទប់	\N		\N	\N	\N	788	\N
87	បន្ទប់	\N		\N	\N	\N	789	\N
88	ទូទឹកកក	\N		\N	\N	\N	911	\N
89	ជូត	\N		\N	\N	\N	912	\N
89	ជូត	\N		\N	\N	\N	1023	\N
90	គ្រែ	\N		\N	\N	\N	913	\N
91	រ៉ាត់យ៉ូ	\N		\N	\N	\N	914	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	147	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	367	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	468	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	470	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	630	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	740	\N
93	ខ្ញុំឈ្មោះ	\N		\N	\N	\N	786	\N
94	ដេក	\N		\N	\N	\N	916	\N
94	ដេក	\N		\N	\N	\N	1029	\N
94	ដេក	\N		\N	\N	\N	1095	\N
95	ក្រោក	\N		\N	\N	\N	914	\N
95	ក្រោក	\N		\N	\N	\N	542	\N
95	ក្រោក	\N		\N	\N	\N	543	\N
96	ទូរទស្សន៍	\N		\N	\N	\N	1095	\N
96	ទូរទស្សន៍	\N		\N	\N	\N	654	\N
97	ប៉ូលីស	\N		\N	\N	\N	917	\N
98	ប៉ូលីស	\N		\N	\N	\N	884	\N
98	ប៉ូលីស	\N		\N	\N	\N	918	\N
98	ប៉ូលីស	\N		\N	\N	\N	921	\N
98	ប៉ូលីស	\N		\N	\N	\N	924	\N
99	ផែនទី	\N		\N	\N	\N	576	\N
100	ម្តុំ	\N		\N	\N	\N	906	\N
100	ម្តុំ	\N		\N	\N	\N	919	\N
101	កន្លែងនេះ	\N		\N	\N	\N	920	\N
102	កន្លែងនោះ	\N		\N	\N	\N	921	\N
102	កន្លែងនោះ	\N		\N	\N	\N	922	\N
103	ឯណា	\N		\N	\N	\N	923	\N
105	ជិត	\N		\N	\N	\N	1021	\N
105	ជិត	\N		\N	\N	\N	1037	\N
105	ជិត	\N		\N	\N	\N	1103	\N
105	ជិត	\N		\N	\N	\N	1118	\N
105	ជិត	\N		\N	\N	\N	1133	\N
105	ជិត	\N		\N	\N	\N	166	\N
105	ជិត	\N		\N	\N	\N	386	\N
106	ក្បែរ	\N		\N	\N	\N	646	\N
106	ក្បែរ	\N		\N	\N	\N	775	\N
107	ស្ដាប់	\N		\N	\N	\N	1123	\N
107	ស្ដាប់	\N		\N	\N	\N	98	\N
107	ស្ដាប់	\N		\N	\N	\N	318	\N
108	កាត់	\N		\N	\N	\N	1121	\N
108	កាត់	\N		\N	\N	\N	561	\N
109	ខ្លី	\N		\N	\N	\N	925	\N
110	ក្រោយ	\N		\N	\N	\N	987	\N
110	ក្រោយ	\N		\N	\N	\N	994	\N
110	ក្រោយ	\N		\N	\N	\N	1089	\N
110	ក្រោយ	\N		\N	\N	\N	1091	\N
110	ក្រោយ	\N		\N	\N	\N	1113	\N
110	ក្រោយ	\N		\N	\N	\N	528	\N
110	ក្រោយ	\N		\N	\N	\N	529	\N
110	ក្រោយ	\N		\N	\N	\N	635	\N
110	ក្រោយ	\N		\N	\N	\N	737	\N
110	ក្រោយ	\N		\N	\N	\N	767	\N
111	មុខ	\N		\N	\N	\N	875	\N
111	មុខ	\N		\N	\N	\N	900	\N
111	មុខ	\N		\N	\N	\N	987	\N
111	មុខ	\N		\N	\N	\N	1000	\N
111	មុខ	\N		\N	\N	\N	471	\N
111	មុខ	\N		\N	\N	\N	545	\N
111	មុខ	\N		\N	\N	\N	616	\N
111	មុខ	\N		\N	\N	\N	788	\N
113	ឆ្វេង	\N		\N	\N	\N	889	\N
113	ឆ្វេង	\N		\N	\N	\N	927	\N
114	វែង	\N		\N	\N	\N	909	\N
114	វែង	\N		\N	\N	\N	925	\N
114	វែង	\N		\N	\N	\N	999	\N
114	វែង	\N		\N	\N	\N	84	\N
114	វែង	\N		\N	\N	\N	107	\N
114	វែង	\N		\N	\N	\N	304	\N
114	វែង	\N		\N	\N	\N	327	\N
115	អង្គុយ	\N		\N	\N	\N	1017	\N
115	អង្គុយ	\N		\N	\N	\N	618	\N
115	អង្គុយ	\N		\N	\N	\N	646	\N
116	ឈរ	\N		\N	\N	\N	884	\N
116	ឈរ	\N		\N	\N	\N	920	\N
116	ឈរ	\N		\N	\N	\N	928	\N
116	ឈរ	\N		\N	\N	\N	1017	\N
117	មិត្ត	\N		\N	\N	\N	929	\N
117	មិត្ត	\N		\N	\N	\N	982	\N
117	មិត្ត	\N		\N	\N	\N	1135	\N
118	ថ្នាក់	\N		\N	\N	\N	930	\N
118	ថ្នាក់	\N		\N	\N	\N	940	\N
118	ថ្នាក់	\N		\N	\N	\N	1089	\N
118	ថ្នាក់	\N		\N	\N	\N	1103	\N
119	បន្ទប់រៀន	\N		\N	\N	\N	931	\N
121	សាលា	\N		\N	\N	\N	895	\N
121	សាលា	\N		\N	\N	\N	974	\N
121	សាលា	\N		\N	\N	\N	1001	\N
121	សាលា	\N		\N	\N	\N	1074	\N
121	សាលា	\N		\N	\N	\N	1077	\N
121	សាលា	\N		\N	\N	\N	1078	\N
121	សាលា	\N		\N	\N	\N	10	\N
121	សាលា	\N		\N	\N	\N	163	\N
121	សាលា	\N		\N	\N	\N	230	\N
121	សាលា	\N		\N	\N	\N	383	\N
122	សិស្ស	\N		\N	\N	\N	891	\N
122	សិស្ស	\N		\N	\N	\N	899	\N
122	សិស្ស	\N		\N	\N	\N	908	\N
122	សិស្ស	\N		\N	\N	\N	928	\N
122	សិស្ស	\N		\N	\N	\N	933	\N
122	សិស្ស	\N		\N	\N	\N	937	\N
122	សិស្ស	\N		\N	\N	\N	939	\N
122	សិស្ស	\N		\N	\N	\N	946	\N
122	សិស្ស	\N		\N	\N	\N	1016	\N
122	សិស្ស	\N		\N	\N	\N	1034	\N
122	សិស្ស	\N		\N	\N	\N	1076	\N
122	សិស្ស	\N		\N	\N	\N	1080	\N
122	សិស្ស	\N		\N	\N	\N	1082	\N
122	សិស្ស	\N		\N	\N	\N	1093	\N
122	សិស្ស	\N		\N	\N	\N	1103	\N
123	ការសិក្សា	\N		\N	\N	\N	934	\N
124	និស្សិត	\N		\N	\N	\N	935	\N
124	និស្សិត	\N		\N	\N	\N	937	\N
126	វ៉ាកងធំ	\N		\N	\N	\N	937	\N
127	គ្រូ	\N		\N	\N	\N	940	\N
127	គ្រូ	\N		\N	\N	\N	944	\N
127	គ្រូ	\N		\N	\N	\N	1001	\N
127	គ្រូ	\N		\N	\N	\N	1103	\N
127	គ្រូ	\N		\N	\N	\N	1140	\N
127	គ្រូ	\N		\N	\N	\N	441	\N
127	គ្រូ	\N		\N	\N	\N	443	\N
127	គ្រូ	\N		\N	\N	\N	451	\N
127	គ្រូ	\N		\N	\N	\N	455	\N
127	គ្រូ	\N		\N	\N	\N	456	\N
127	គ្រូ	\N		\N	\N	\N	635	\N
127	គ្រូ	\N		\N	\N	\N	734	\N
128	សាកលវិទ្យាល័យ	\N		\N	\N	\N	938	\N
129	សៀវភៅសរសេរ	\N		\N	\N	\N	939	\N
131	កិច្ចការផ្ទះ	\N		\N	\N	\N	942	\N
132	ពិបាក	\N		\N	\N	\N	182	\N
132	ពិបាក	\N		\N	\N	\N	402	\N
132	ពិបាក	\N		\N	\N	\N	446	\N
132	ពិបាក	\N		\N	\N	\N	483	\N
132	ពិបាក	\N		\N	\N	\N	610	\N
132	ពិបាក	\N		\N	\N	\N	721	\N
133	បង្រៀន	\N		\N	\N	\N	28	\N
133	បង្រៀន	\N		\N	\N	\N	248	\N
134	ប្រឡង	\N		\N	\N	\N	930	\N
134	ប្រឡង	\N		\N	\N	\N	943	\N
134	ប្រឡង	\N		\N	\N	\N	1067	\N
135	លំហាត់	\N		\N	\N	\N	944	\N
136	ស្រួល	\N		\N	\N	\N	870	\N
136	ស្រួល	\N		\N	\N	\N	922	\N
136	ស្រួល	\N		\N	\N	\N	924	\N
136	ស្រួល	\N		\N	\N	\N	927	\N
136	ស្រួល	\N		\N	\N	\N	1066	\N
136	ស្រួល	\N		\N	\N	\N	1117	\N
136	ស្រួល	\N		\N	\N	\N	1133	\N
136	ស្រួល	\N		\N	\N	\N	695	\N
137	ហាត់	\N		\N	\N	\N	944	\N
137	ហាត់	\N		\N	\N	\N	945	\N
138	សំណួរ	\N		\N	\N	\N	946	\N
138	សំណួរ	\N		\N	\N	\N	947	\N
138	សំណួរ	\N		\N	\N	\N	948	\N
139	ឆ្លើយ	\N		\N	\N	\N	948	\N
140	ឈឺ	\N		\N	\N	\N	1019	\N
140	ឈឺ	\N		\N	\N	\N	1080	\N
140	ឈឺ	\N		\N	\N	\N	731	\N
140	ឈឺ	\N		\N	\N	\N	732	\N
141	ធ្មេញ	\N		\N	\N	\N	949	\N
142	ពេទ្យ	\N		\N	\N	\N	913	\N
142	ពេទ្យ	\N		\N	\N	\N	950	\N
142	ពេទ្យ	\N		\N	\N	\N	863	\N
142	ពេទ្យ	\N		\N	\N	\N	634	\N
142	ពេទ្យ	\N		\N	\N	\N	635	\N
144	ជម្ងឺ	\N		\N	\N	\N	951	\N
145	ថ្នាំ	\N		\N	\N	\N	951	\N
145	ថ្នាំ	\N		\N	\N	\N	952	\N
146	ស្លាប់	\N		\N	\N	\N	953	\N
147	ផ្ដាសាយ	\N		\N	\N	\N	1040	\N
147	ផ្ដាសាយ	\N		\N	\N	\N	216	\N
147	ផ្ដាសាយ	\N		\N	\N	\N	220	\N
147	ផ្ដាសាយ	\N		\N	\N	\N	436	\N
147	ផ្ដាសាយ	\N		\N	\N	\N	440	\N
148	ក្បាល	\N		\N	\N	\N	1010	\N
148	ក្បាល	\N		\N	\N	\N	1027	\N
148	ក្បាល	\N		\N	\N	\N	1029	\N
148	ក្បាល	\N		\N	\N	\N	862	\N
148	ក្បាល	\N		\N	\N	\N	621	\N
148	ក្បាល	\N		\N	\N	\N	816	\N
149	ពោះ	\N		\N	\N	\N	1010	\N
149	ពោះ	\N		\N	\N	\N	638	\N
149	ពោះ	\N		\N	\N	\N	732	\N
150	អង្សា	\N		\N	\N	\N	954	\N
152	សំបុត្រ	\N		\N	\N	\N	867	\N
152	សំបុត្រ	\N		\N	\N	\N	868	\N
152	សំបុត្រ	\N		\N	\N	\N	981	\N
152	សំបុត្រ	\N		\N	\N	\N	983	\N
152	សំបុត្រ	\N		\N	\N	\N	998	\N
152	សំបុត្រ	\N		\N	\N	\N	1003	\N
152	សំបុត្រ	\N		\N	\N	\N	611	\N
152	សំបុត្រ	\N		\N	\N	\N	720	\N
152	សំបុត្រ	\N		\N	\N	\N	760	\N
152	សំបុត្រ	\N		\N	\N	\N	761	\N
152	សំបុត្រ	\N		\N	\N	\N	775	\N
153	ចុះ	\N		\N	\N	\N	911	\N
153	ចុះ	\N		\N	\N	\N	935	\N
153	ចុះ	\N		\N	\N	\N	1093	\N
153	ចុះ	\N		\N	\N	\N	125	\N
153	ចុះ	\N		\N	\N	\N	126	\N
153	ចុះ	\N		\N	\N	\N	214	\N
153	ចុះ	\N		\N	\N	\N	345	\N
153	ចុះ	\N		\N	\N	\N	346	\N
153	ចុះ	\N		\N	\N	\N	434	\N
153	ចុះ	\N		\N	\N	\N	451	\N
153	ចុះ	\N		\N	\N	\N	453	\N
153	ចុះ	\N		\N	\N	\N	510	\N
153	ចុះ	\N		\N	\N	\N	514	\N
153	ចុះ	\N		\N	\N	\N	554	\N
153	ចុះ	\N		\N	\N	\N	581	\N
153	ចុះ	\N		\N	\N	\N	615	\N
153	ចុះ	\N		\N	\N	\N	643	\N
153	ចុះ	\N		\N	\N	\N	655	\N
153	ចុះ	\N		\N	\N	\N	679	\N
153	ចុះ	\N		\N	\N	\N	698	\N
153	ចុះ	\N		\N	\N	\N	749	\N
153	ចុះ	\N		\N	\N	\N	755	\N
153	ចុះ	\N		\N	\N	\N	757	\N
153	ចុះ	\N		\N	\N	\N	774	\N
155	បិទ	\N		\N	\N	\N	895	\N
155	បិទ	\N		\N	\N	\N	931	\N
155	បិទ	\N		\N	\N	\N	978	\N
155	បិទ	\N		\N	\N	\N	983	\N
155	បិទ	\N		\N	\N	\N	563	\N
155	បិទ	\N		\N	\N	\N	565	\N
156	ស្ថានីយ	\N		\N	\N	\N	957	\N
156	ស្ថានីយ	\N		\N	\N	\N	1133	\N
157	រទេះភ្លើងក្រោមដី	\N		\N	\N	\N	958	\N
158	ជិះ	\N		\N	\N	\N	955	\N
158	ជិះ	\N		\N	\N	\N	688	\N
159	បើក	\N		\N	\N	\N	895	\N
159	បើក	\N		\N	\N	\N	927	\N
159	បើក	\N		\N	\N	\N	1025	\N
159	បើក	\N		\N	\N	\N	1055	\N
159	បើក	\N		\N	\N	\N	1137	\N
159	បើក	\N		\N	\N	\N	612	\N
159	បើក	\N		\N	\N	\N	614	\N
159	បើក	\N		\N	\N	\N	676	\N
159	បើក	\N		\N	\N	\N	743	\N
160	បន្ទប់ទឹក	\N		\N	\N	\N	959	\N
160	បន្ទប់ទឹក	\N		\N	\N	\N	991	\N
161	បង្គន់	\N		\N	\N	\N	960	\N
161	បង្គន់	\N		\N	\N	\N	991	\N
162	រទេះភ្លើង	\N		\N	\N	\N	958	\N
162	រទេះភ្លើង	\N		\N	\N	\N	961	\N
163	ភេសជ្ជៈ	\N		\N	\N	\N	962	\N
164	កាហ្វេ	\N		\N	\N	\N	963	\N
164	កាហ្វេ	\N		\N	\N	\N	965	\N
164	កាហ្វេ	\N		\N	\N	\N	968	\N
164	កាហ្វេ	\N		\N	\N	\N	603	\N
164	កាហ្វេ	\N		\N	\N	\N	606	\N
164	កាហ្វេ	\N		\N	\N	\N	607	\N
164	កាហ្វេ	\N		\N	\N	\N	610	\N
164	កាហ្វេ	\N		\N	\N	\N	783	\N
164	កាហ្វេ	\N		\N	\N	\N	785	\N
165	ហាងកាហ្វេ	\N		\N	\N	\N	963	\N
166	ក្រូចឆ្មារ	\N		\N	\N	\N	964	\N
166	ក្រូចឆ្មារ	\N		\N	\N	\N	967	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	968	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	976	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	46	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	266	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	604	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	605	\N
167	ទឹកដោះគោ	\N		\N	\N	\N	783	\N
168	ស្ករ	\N		\N	\N	\N	968	\N
168	ស្ករ	\N		\N	\N	\N	1042	\N
168	ស្ករ	\N		\N	\N	\N	1048	\N
168	ស្ករ	\N		\N	\N	\N	67	\N
168	ស្ករ	\N		\N	\N	\N	287	\N
168	ស្ករ	\N		\N	\N	\N	607	\N
168	ស្ករ	\N		\N	\N	\N	623	\N
169	ពែងកែវ	\N		\N	\N	\N	965	\N
172	កែវ	\N		\N	\N	\N	888	\N
172	កែវ	\N		\N	\N	\N	965	\N
172	កែវ	\N		\N	\N	\N	750	\N
173	ដាក់	\N		\N	\N	\N	897	\N
173	ដាក់	\N		\N	\N	\N	909	\N
173	ដាក់	\N		\N	\N	\N	933	\N
173	ដាក់	\N		\N	\N	\N	944	\N
173	ដាក់	\N		\N	\N	\N	972	\N
173	ដាក់	\N		\N	\N	\N	517	\N
173	ដាក់	\N		\N	\N	\N	537	\N
173	ដាក់	\N		\N	\N	\N	604	\N
173	ដាក់	\N		\N	\N	\N	607	\N
173	ដាក់	\N		\N	\N	\N	623	\N
173	ដាក់	\N		\N	\N	\N	625	\N
173	ដាក់	\N		\N	\N	\N	638	\N
173	ដាក់	\N		\N	\N	\N	695	\N
173	ដាក់	\N		\N	\N	\N	775	\N
173	ដាក់	\N		\N	\N	\N	784	\N
174	ផ្អែម	\N		\N	\N	\N	968	\N
174	ផ្អែម	\N		\N	\N	\N	1048	\N
175	ញ៉ាំ	\N		\N	\N	\N	967	\N
175	ញ៉ាំ	\N		\N	\N	\N	969	\N
175	ញ៉ាំ	\N		\N	\N	\N	972	\N
175	ញ៉ាំ	\N		\N	\N	\N	977	\N
175	ញ៉ាំ	\N		\N	\N	\N	1043	\N
175	ញ៉ាំ	\N		\N	\N	\N	1097	\N
175	ញ៉ាំ	\N		\N	\N	\N	1098	\N
175	ញ៉ាំ	\N		\N	\N	\N	37	\N
175	ញ៉ាំ	\N		\N	\N	\N	100	\N
175	ញ៉ាំ	\N		\N	\N	\N	105	\N
175	ញ៉ាំ	\N		\N	\N	\N	106	\N
175	ញ៉ាំ	\N		\N	\N	\N	113	\N
175	ញ៉ាំ	\N		\N	\N	\N	114	\N
175	ញ៉ាំ	\N		\N	\N	\N	115	\N
175	ញ៉ាំ	\N		\N	\N	\N	116	\N
175	ញ៉ាំ	\N		\N	\N	\N	117	\N
175	ញ៉ាំ	\N		\N	\N	\N	118	\N
175	ញ៉ាំ	\N		\N	\N	\N	119	\N
175	ញ៉ាំ	\N		\N	\N	\N	120	\N
175	ញ៉ាំ	\N		\N	\N	\N	124	\N
175	ញ៉ាំ	\N		\N	\N	\N	130	\N
175	ញ៉ាំ	\N		\N	\N	\N	131	\N
175	ញ៉ាំ	\N		\N	\N	\N	132	\N
175	ញ៉ាំ	\N		\N	\N	\N	133	\N
175	ញ៉ាំ	\N		\N	\N	\N	134	\N
175	ញ៉ាំ	\N		\N	\N	\N	135	\N
175	ញ៉ាំ	\N		\N	\N	\N	156	\N
175	ញ៉ាំ	\N		\N	\N	\N	157	\N
175	ញ៉ាំ	\N		\N	\N	\N	167	\N
175	ញ៉ាំ	\N		\N	\N	\N	168	\N
175	ញ៉ាំ	\N		\N	\N	\N	169	\N
175	ញ៉ាំ	\N		\N	\N	\N	170	\N
175	ញ៉ាំ	\N		\N	\N	\N	171	\N
175	ញ៉ាំ	\N		\N	\N	\N	178	\N
175	ញ៉ាំ	\N		\N	\N	\N	257	\N
175	ញ៉ាំ	\N		\N	\N	\N	320	\N
175	ញ៉ាំ	\N		\N	\N	\N	325	\N
175	ញ៉ាំ	\N		\N	\N	\N	326	\N
175	ញ៉ាំ	\N		\N	\N	\N	333	\N
175	ញ៉ាំ	\N		\N	\N	\N	334	\N
175	ញ៉ាំ	\N		\N	\N	\N	335	\N
175	ញ៉ាំ	\N		\N	\N	\N	336	\N
175	ញ៉ាំ	\N		\N	\N	\N	337	\N
175	ញ៉ាំ	\N		\N	\N	\N	338	\N
175	ញ៉ាំ	\N		\N	\N	\N	339	\N
175	ញ៉ាំ	\N		\N	\N	\N	340	\N
175	ញ៉ាំ	\N		\N	\N	\N	344	\N
175	ញ៉ាំ	\N		\N	\N	\N	350	\N
175	ញ៉ាំ	\N		\N	\N	\N	351	\N
175	ញ៉ាំ	\N		\N	\N	\N	352	\N
175	ញ៉ាំ	\N		\N	\N	\N	353	\N
175	ញ៉ាំ	\N		\N	\N	\N	354	\N
175	ញ៉ាំ	\N		\N	\N	\N	355	\N
175	ញ៉ាំ	\N		\N	\N	\N	376	\N
175	ញ៉ាំ	\N		\N	\N	\N	377	\N
175	ញ៉ាំ	\N		\N	\N	\N	387	\N
175	ញ៉ាំ	\N		\N	\N	\N	388	\N
175	ញ៉ាំ	\N		\N	\N	\N	389	\N
175	ញ៉ាំ	\N		\N	\N	\N	390	\N
175	ញ៉ាំ	\N		\N	\N	\N	391	\N
175	ញ៉ាំ	\N		\N	\N	\N	398	\N
175	ញ៉ាំ	\N		\N	\N	\N	541	\N
175	ញ៉ាំ	\N		\N	\N	\N	642	\N
175	ញ៉ាំ	\N		\N	\N	\N	737	\N
175	ញ៉ាំ	\N		\N	\N	\N	770	\N
175	ញ៉ាំ	\N		\N	\N	\N	775	\N
177	ស្រា	\N		\N	\N	\N	968	\N
177	ស្រា	\N		\N	\N	\N	975	\N
177	ស្រា	\N		\N	\N	\N	1006	\N
177	ស្រា	\N		\N	\N	\N	1032	\N
177	ស្រា	\N		\N	\N	\N	1041	\N
177	ស្រា	\N		\N	\N	\N	633	\N
177	ស្រា	\N		\N	\N	\N	648	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	965	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	967	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	971	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	1048	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	32	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	85	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	86	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	87	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	88	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	187	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	188	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	189	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	190	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	832	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	252	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	305	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	306	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	307	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	308	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	407	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	408	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	409	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	410	\N
178	ឆ្ងាញ់	\N		\N	\N	\N	494	\N
179	កាំបិត	\N		\N	\N	\N	745	\N
180	ស្លាបព្រា	\N		\N	\N	\N	970	\N
181	សម	\N		\N	\N	\N	869	\N
181	សម	\N		\N	\N	\N	874	\N
181	សម	\N		\N	\N	\N	875	\N
181	សម	\N		\N	\N	\N	878	\N
181	សម	\N		\N	\N	\N	950	\N
181	សម	\N		\N	\N	\N	977	\N
181	សម	\N		\N	\N	\N	1028	\N
181	សម	\N		\N	\N	\N	1040	\N
181	សម	\N		\N	\N	\N	1052	\N
181	សម	\N		\N	\N	\N	1070	\N
181	សម	\N		\N	\N	\N	1082	\N
181	សម	\N		\N	\N	\N	1088	\N
181	សម	\N		\N	\N	\N	1097	\N
181	សម	\N		\N	\N	\N	1105	\N
181	សម	\N		\N	\N	\N	1122	\N
181	សម	\N		\N	\N	\N	1128	\N
181	សម	\N		\N	\N	\N	1129	\N
181	សម	\N		\N	\N	\N	448	\N
181	សម	\N		\N	\N	\N	488	\N
181	សម	\N		\N	\N	\N	501	\N
181	សម	\N		\N	\N	\N	524	\N
181	សម	\N		\N	\N	\N	526	\N
181	សម	\N		\N	\N	\N	533	\N
181	សម	\N		\N	\N	\N	545	\N
181	សម	\N		\N	\N	\N	559	\N
181	សម	\N		\N	\N	\N	566	\N
181	សម	\N		\N	\N	\N	581	\N
181	សម	\N		\N	\N	\N	642	\N
181	សម	\N		\N	\N	\N	735	\N
181	សម	\N		\N	\N	\N	776	\N
181	សម	\N		\N	\N	\N	786	\N
182	អត់ឆ្ងាញ់	\N		\N	\N	\N	971	\N
184	ហឹរ	\N		\N	\N	\N	973	\N
185	ហាងបាយ	\N		\N	\N	\N	974	\N
187	ម្ហូបអាហារ	\N		\N	\N	\N	976	\N
188	សម្លការី	\N		\N	\N	\N	977	\N
189	លុយ	\N		\N	\N	\N	959	\N
189	លុយ	\N		\N	\N	\N	1094	\N
189	លុយ	\N		\N	\N	\N	184	\N
189	លុយ	\N		\N	\N	\N	185	\N
189	លុយ	\N		\N	\N	\N	218	\N
189	លុយ	\N		\N	\N	\N	219	\N
189	លុយ	\N		\N	\N	\N	404	\N
189	លុយ	\N		\N	\N	\N	405	\N
189	លុយ	\N		\N	\N	\N	438	\N
189	លុយ	\N		\N	\N	\N	439	\N
189	លុយ	\N		\N	\N	\N	775	\N
190	ធនាគារ	\N		\N	\N	\N	676	\N
191	ទ្វារចូល	\N		\N	\N	\N	978	\N
192	អញ្ជើញ	\N		\N	\N	\N	1004	\N
192	អញ្ជើញ	\N		\N	\N	\N	158	\N
192	អញ្ជើញ	\N		\N	\N	\N	378	\N
192	អញ្ជើញ	\N		\N	\N	\N	474	\N
192	អញ្ជើញ	\N		\N	\N	\N	503	\N
192	អញ្ជើញ	\N		\N	\N	\N	517	\N
192	អញ្ជើញ	\N		\N	\N	\N	674	\N
192	អញ្ជើញ	\N		\N	\N	\N	675	\N
192	អញ្ជើញ	\N		\N	\N	\N	759	\N
192	អញ្ជើញ	\N		\N	\N	\N	775	\N
192	អញ្ជើញ	\N		\N	\N	\N	778	\N
192	អញ្ជើញ	\N		\N	\N	\N	782	\N
193	អត់ទេ	\N		\N	\N	\N	499	\N
194	បាទ	\N		\N	\N	\N	1004	\N
194	បាទ	\N		\N	\N	\N	116	\N
194	បាទ	\N		\N	\N	\N	336	\N
194	បាទ	\N		\N	\N	\N	454	\N
194	បាទ	\N		\N	\N	\N	457	\N
194	បាទ	\N		\N	\N	\N	461	\N
194	បាទ	\N		\N	\N	\N	465	\N
194	បាទ	\N		\N	\N	\N	467	\N
194	បាទ	\N		\N	\N	\N	475	\N
194	បាទ	\N		\N	\N	\N	478	\N
194	បាទ	\N		\N	\N	\N	486	\N
194	បាទ	\N		\N	\N	\N	502	\N
194	បាទ	\N		\N	\N	\N	504	\N
194	បាទ	\N		\N	\N	\N	530	\N
194	បាទ	\N		\N	\N	\N	535	\N
194	បាទ	\N		\N	\N	\N	543	\N
194	បាទ	\N		\N	\N	\N	545	\N
194	បាទ	\N		\N	\N	\N	549	\N
194	បាទ	\N		\N	\N	\N	603	\N
194	បាទ	\N		\N	\N	\N	605	\N
194	បាទ	\N		\N	\N	\N	607	\N
194	បាទ	\N		\N	\N	\N	612	\N
194	បាទ	\N		\N	\N	\N	614	\N
194	បាទ	\N		\N	\N	\N	618	\N
194	បាទ	\N		\N	\N	\N	622	\N
194	បាទ	\N		\N	\N	\N	650	\N
194	បាទ	\N		\N	\N	\N	652	\N
194	បាទ	\N		\N	\N	\N	654	\N
194	បាទ	\N		\N	\N	\N	663	\N
194	បាទ	\N		\N	\N	\N	676	\N
194	បាទ	\N		\N	\N	\N	728	\N
194	បាទ	\N		\N	\N	\N	736	\N
194	បាទ	\N		\N	\N	\N	738	\N
194	បាទ	\N		\N	\N	\N	743	\N
194	បាទ	\N		\N	\N	\N	768	\N
194	បាទ	\N		\N	\N	\N	798	\N
195	អត់ទោស	\N		\N	\N	\N	979	\N
196	ទ្វារចេញ	\N		\N	\N	\N	980	\N
197	ដល់	\N		\N	\N	\N	876	\N
197	ដល់	\N		\N	\N	\N	939	\N
197	ដល់	\N		\N	\N	\N	956	\N
197	ដល់	\N		\N	\N	\N	989	\N
197	ដល់	\N		\N	\N	\N	1056	\N
197	ដល់	\N		\N	\N	\N	1103	\N
197	ដល់	\N		\N	\N	\N	206	\N
197	ដល់	\N		\N	\N	\N	426	\N
197	ដល់	\N		\N	\N	\N	537	\N
197	ដល់	\N		\N	\N	\N	713	\N
198	ប្រអប់សំបុត្រ	\N		\N	\N	\N	981	\N
199	កាតប៉ុស្តាល់	\N		\N	\N	\N	982	\N
200	ស្រោមសំបុត្រ	\N		\N	\N	\N	775	\N
201	ប៉ុស្តិ៍	\N		\N	\N	\N	611	\N
202	សង	\N		\N	\N	\N	875	\N
202	សង	\N		\N	\N	\N	893	\N
202	សង	\N		\N	\N	\N	955	\N
202	សង	\N		\N	\N	\N	993	\N
202	សង	\N		\N	\N	\N	999	\N
202	សង	\N		\N	\N	\N	1020	\N
202	សង	\N		\N	\N	\N	1094	\N
202	សង	\N		\N	\N	\N	1121	\N
202	សង	\N		\N	\N	\N	1130	\N
202	សង	\N		\N	\N	\N	844	\N
202	សង	\N		\N	\N	\N	532	\N
202	សង	\N		\N	\N	\N	619	\N
202	សង	\N		\N	\N	\N	729	\N
203	ផ្ញើ	\N		\N	\N	\N	739	\N
203	ផ្ញើ	\N		\N	\N	\N	793	\N
205	អីវ៉ាន់	\N		\N	\N	\N	986	\N
205	អីវ៉ាន់	\N		\N	\N	\N	833	\N
205	អីវ៉ាន់	\N		\N	\N	\N	739	\N
205	អីវ៉ាន់	\N		\N	\N	\N	793	\N
206	សន្លឹក	\N		\N	\N	\N	984	\N
206	សន្លឹក	\N		\N	\N	\N	1110	\N
207	ឲ្យខ្ចី	\N		\N	\N	\N	985	\N
208	មួក	\N		\N	\N	\N	725	\N
209	ស្បែកជើង	\N		\N	\N	\N	1036	\N
209	ស្បែកជើង	\N		\N	\N	\N	727	\N
210	ទិញអីវ៉ាន់	\N		\N	\N	\N	986	\N
211	ជាន់	\N		\N	\N	\N	909	\N
211	ជាន់	\N		\N	\N	\N	956	\N
211	ជាន់	\N		\N	\N	\N	979	\N
211	ជាន់	\N		\N	\N	\N	788	\N
212	ផ្សារ	\N		\N	\N	\N	888	\N
212	ផ្សារ	\N		\N	\N	\N	900	\N
212	ផ្សារ	\N		\N	\N	\N	901	\N
212	ផ្សារ	\N		\N	\N	\N	919	\N
212	ផ្សារ	\N		\N	\N	\N	979	\N
212	ផ្សារ	\N		\N	\N	\N	856	\N
213	សំពត់	\N		\N	\N	\N	987	\N
214	អាវរងារ	\N		\N	\N	\N	988	\N
215	ខោ	\N		\N	\N	\N	891	\N
215	ខោ	\N		\N	\N	\N	907	\N
215	ខោ	\N		\N	\N	\N	925	\N
215	ខោ	\N		\N	\N	\N	1036	\N
215	ខោ	\N		\N	\N	\N	545	\N
215	ខោ	\N		\N	\N	\N	747	\N
216	សូម	\N		\N	\N	\N	960	\N
216	សូម	\N		\N	\N	\N	1022	\N
216	សូម	\N		\N	\N	\N	1057	\N
216	សូម	\N		\N	\N	\N	1141	\N
216	សូម	\N		\N	\N	\N	152	\N
216	សូម	\N		\N	\N	\N	156	\N
216	សូម	\N		\N	\N	\N	157	\N
216	សូម	\N		\N	\N	\N	372	\N
216	សូម	\N		\N	\N	\N	376	\N
216	សូម	\N		\N	\N	\N	377	\N
216	សូម	\N		\N	\N	\N	456	\N
216	សូម	\N		\N	\N	\N	462	\N
216	សូម	\N		\N	\N	\N	466	\N
216	សូម	\N		\N	\N	\N	471	\N
216	សូម	\N		\N	\N	\N	477	\N
216	សូម	\N		\N	\N	\N	488	\N
216	សូម	\N		\N	\N	\N	495	\N
216	សូម	\N		\N	\N	\N	497	\N
216	សូម	\N		\N	\N	\N	501	\N
216	សូម	\N		\N	\N	\N	503	\N
216	សូម	\N		\N	\N	\N	505	\N
216	សូម	\N		\N	\N	\N	517	\N
216	សូម	\N		\N	\N	\N	518	\N
216	សូម	\N		\N	\N	\N	527	\N
216	សូម	\N		\N	\N	\N	528	\N
216	សូម	\N		\N	\N	\N	611	\N
216	សូម	\N		\N	\N	\N	613	\N
216	សូម	\N		\N	\N	\N	615	\N
216	សូម	\N		\N	\N	\N	666	\N
216	សូម	\N		\N	\N	\N	674	\N
216	សូម	\N		\N	\N	\N	677	\N
216	សូម	\N		\N	\N	\N	678	\N
216	សូម	\N		\N	\N	\N	679	\N
216	សូម	\N		\N	\N	\N	687	\N
216	សូម	\N		\N	\N	\N	704	\N
216	សូម	\N		\N	\N	\N	726	\N
216	សូម	\N		\N	\N	\N	745	\N
216	សូម	\N		\N	\N	\N	759	\N
217	កាបូប	\N		\N	\N	\N	1014	\N
217	កាបូប	\N		\N	\N	\N	184	\N
217	កាបូប	\N		\N	\N	\N	185	\N
217	កាបូប	\N		\N	\N	\N	404	\N
217	កាបូប	\N		\N	\N	\N	405	\N
218	លក់	\N		\N	\N	\N	900	\N
218	លក់	\N		\N	\N	\N	901	\N
218	លក់	\N		\N	\N	\N	903	\N
218	លក់	\N		\N	\N	\N	912	\N
218	លក់	\N		\N	\N	\N	974	\N
218	លក់	\N		\N	\N	\N	1052	\N
218	លក់	\N		\N	\N	\N	512	\N
218	លក់	\N		\N	\N	\N	646	\N
218	លក់	\N		\N	\N	\N	808	\N
220	ផ្ទះបាយ	\N		\N	\N	\N	993	\N
221	ងូតទឹកផ្កាឈូក	\N		\N	\N	\N	994	\N
222	បង្អួច	\N		\N	\N	\N	788	\N
223	រស់នៅ	\N		\N	\N	\N	995	\N
224	ទ្វារ	\N		\N	\N	\N	978	\N
224	ទ្វារ	\N		\N	\N	\N	980	\N
224	ទ្វារ	\N		\N	\N	\N	997	\N
224	ទ្វារ	\N		\N	\N	\N	1000	\N
224	ទ្វារ	\N		\N	\N	\N	1055	\N
224	ទ្វារ	\N		\N	\N	\N	1056	\N
226	ផ្ទះល្វែង	\N		\N	\N	\N	999	\N
227	មាត់ទ្វារ	\N		\N	\N	\N	1000	\N
228	គាត់	\N		\N	\N	\N	867	\N
228	គាត់	\N		\N	\N	\N	877	\N
228	គាត់	\N		\N	\N	\N	880	\N
228	គាត់	\N		\N	\N	\N	890	\N
228	គាត់	\N		\N	\N	\N	923	\N
228	គាត់	\N		\N	\N	\N	948	\N
228	គាត់	\N		\N	\N	\N	952	\N
228	គាត់	\N		\N	\N	\N	958	\N
228	គាត់	\N		\N	\N	\N	966	\N
228	គាត់	\N		\N	\N	\N	972	\N
228	គាត់	\N		\N	\N	\N	982	\N
228	គាត់	\N		\N	\N	\N	985	\N
228	គាត់	\N		\N	\N	\N	998	\N
228	គាត់	\N		\N	\N	\N	1005	\N
228	គាត់	\N		\N	\N	\N	1019	\N
228	គាត់	\N		\N	\N	\N	1031	\N
228	គាត់	\N		\N	\N	\N	1040	\N
228	គាត់	\N		\N	\N	\N	1041	\N
228	គាត់	\N		\N	\N	\N	1043	\N
228	គាត់	\N		\N	\N	\N	1045	\N
228	គាត់	\N		\N	\N	\N	1047	\N
228	គាត់	\N		\N	\N	\N	1051	\N
228	គាត់	\N		\N	\N	\N	1059	\N
228	គាត់	\N		\N	\N	\N	1075	\N
228	គាត់	\N		\N	\N	\N	1089	\N
228	គាត់	\N		\N	\N	\N	1091	\N
228	គាត់	\N		\N	\N	\N	1094	\N
228	គាត់	\N		\N	\N	\N	1097	\N
228	គាត់	\N		\N	\N	\N	1099	\N
228	គាត់	\N		\N	\N	\N	1101	\N
228	គាត់	\N		\N	\N	\N	1106	\N
228	គាត់	\N		\N	\N	\N	1122	\N
228	គាត់	\N		\N	\N	\N	1133	\N
228	គាត់	\N		\N	\N	\N	1135	\N
228	គាត់	\N		\N	\N	\N	1140	\N
228	គាត់	\N		\N	\N	\N	107	\N
228	គាត់	\N		\N	\N	\N	108	\N
228	គាត់	\N		\N	\N	\N	128	\N
228	គាត់	\N		\N	\N	\N	129	\N
228	គាត់	\N		\N	\N	\N	140	\N
228	គាត់	\N		\N	\N	\N	176	\N
228	គាត់	\N		\N	\N	\N	177	\N
228	គាត់	\N		\N	\N	\N	179	\N
228	គាត់	\N		\N	\N	\N	180	\N
228	គាត់	\N		\N	\N	\N	181	\N
228	គាត់	\N		\N	\N	\N	182	\N
228	គាត់	\N		\N	\N	\N	183	\N
228	គាត់	\N		\N	\N	\N	206	\N
228	គាត់	\N		\N	\N	\N	209	\N
228	គាត់	\N		\N	\N	\N	210	\N
228	គាត់	\N		\N	\N	\N	327	\N
228	គាត់	\N		\N	\N	\N	328	\N
228	គាត់	\N		\N	\N	\N	348	\N
228	គាត់	\N		\N	\N	\N	349	\N
228	គាត់	\N		\N	\N	\N	360	\N
228	គាត់	\N		\N	\N	\N	396	\N
228	គាត់	\N		\N	\N	\N	397	\N
228	គាត់	\N		\N	\N	\N	399	\N
228	គាត់	\N		\N	\N	\N	400	\N
228	គាត់	\N		\N	\N	\N	401	\N
228	គាត់	\N		\N	\N	\N	402	\N
228	គាត់	\N		\N	\N	\N	403	\N
228	គាត់	\N		\N	\N	\N	426	\N
228	គាត់	\N		\N	\N	\N	429	\N
228	គាត់	\N		\N	\N	\N	430	\N
228	គាត់	\N		\N	\N	\N	525	\N
228	គាត់	\N		\N	\N	\N	590	\N
228	គាត់	\N		\N	\N	\N	591	\N
228	គាត់	\N		\N	\N	\N	592	\N
228	គាត់	\N		\N	\N	\N	594	\N
228	គាត់	\N		\N	\N	\N	595	\N
228	គាត់	\N		\N	\N	\N	601	\N
228	គាត់	\N		\N	\N	\N	616	\N
228	គាត់	\N		\N	\N	\N	632	\N
228	គាត់	\N		\N	\N	\N	634	\N
228	គាត់	\N		\N	\N	\N	637	\N
228	គាត់	\N		\N	\N	\N	798	\N
228	គាត់	\N		\N	\N	\N	800	\N
228	គាត់	\N		\N	\N	\N	803	\N
229	ពួកគេ	\N		\N	\N	\N	1001	\N
230	ខ្ញុំ	\N		\N	\N	\N	876	\N
230	ខ្ញុំ	\N		\N	\N	\N	894	\N
230	ខ្ញុំ	\N		\N	\N	\N	907	\N
230	ខ្ញុំ	\N		\N	\N	\N	923	\N
230	ខ្ញុំ	\N		\N	\N	\N	941	\N
230	ខ្ញុំ	\N		\N	\N	\N	945	\N
230	ខ្ញុំ	\N		\N	\N	\N	1002	\N
230	ខ្ញុំ	\N		\N	\N	\N	1039	\N
230	ខ្ញុំ	\N		\N	\N	\N	1071	\N
230	ខ្ញុំ	\N		\N	\N	\N	1141	\N
230	ខ្ញុំ	\N		\N	\N	\N	28	\N
230	ខ្ញុំ	\N		\N	\N	\N	35	\N
230	ខ្ញុំ	\N		\N	\N	\N	43	\N
230	ខ្ញុំ	\N		\N	\N	\N	48	\N
230	ខ្ញុំ	\N		\N	\N	\N	49	\N
230	ខ្ញុំ	\N		\N	\N	\N	50	\N
230	ខ្ញុំ	\N		\N	\N	\N	53	\N
230	ខ្ញុំ	\N		\N	\N	\N	59	\N
230	ខ្ញុំ	\N		\N	\N	\N	60	\N
230	ខ្ញុំ	\N		\N	\N	\N	105	\N
230	ខ្ញុំ	\N		\N	\N	\N	106	\N
230	ខ្ញុំ	\N		\N	\N	\N	127	\N
230	ខ្ញុំ	\N		\N	\N	\N	132	\N
230	ខ្ញុំ	\N		\N	\N	\N	140	\N
230	ខ្ញុំ	\N		\N	\N	\N	141	\N
230	ខ្ញុំ	\N		\N	\N	\N	147	\N
230	ខ្ញុំ	\N		\N	\N	\N	148	\N
230	ខ្ញុំ	\N		\N	\N	\N	162	\N
230	ខ្ញុំ	\N		\N	\N	\N	182	\N
230	ខ្ញុំ	\N		\N	\N	\N	183	\N
230	ខ្ញុំ	\N		\N	\N	\N	184	\N
230	ខ្ញុំ	\N		\N	\N	\N	185	\N
230	ខ្ញុំ	\N		\N	\N	\N	205	\N
230	ខ្ញុំ	\N		\N	\N	\N	209	\N
230	ខ្ញុំ	\N		\N	\N	\N	216	\N
230	ខ្ញុំ	\N		\N	\N	\N	248	\N
230	ខ្ញុំ	\N		\N	\N	\N	255	\N
230	ខ្ញុំ	\N		\N	\N	\N	263	\N
230	ខ្ញុំ	\N		\N	\N	\N	268	\N
230	ខ្ញុំ	\N		\N	\N	\N	269	\N
230	ខ្ញុំ	\N		\N	\N	\N	270	\N
230	ខ្ញុំ	\N		\N	\N	\N	273	\N
230	ខ្ញុំ	\N		\N	\N	\N	279	\N
230	ខ្ញុំ	\N		\N	\N	\N	280	\N
230	ខ្ញុំ	\N		\N	\N	\N	325	\N
230	ខ្ញុំ	\N		\N	\N	\N	326	\N
230	ខ្ញុំ	\N		\N	\N	\N	347	\N
230	ខ្ញុំ	\N		\N	\N	\N	352	\N
230	ខ្ញុំ	\N		\N	\N	\N	360	\N
230	ខ្ញុំ	\N		\N	\N	\N	361	\N
230	ខ្ញុំ	\N		\N	\N	\N	367	\N
230	ខ្ញុំ	\N		\N	\N	\N	368	\N
230	ខ្ញុំ	\N		\N	\N	\N	382	\N
230	ខ្ញុំ	\N		\N	\N	\N	402	\N
230	ខ្ញុំ	\N		\N	\N	\N	403	\N
230	ខ្ញុំ	\N		\N	\N	\N	404	\N
230	ខ្ញុំ	\N		\N	\N	\N	405	\N
230	ខ្ញុំ	\N		\N	\N	\N	425	\N
230	ខ្ញុំ	\N		\N	\N	\N	429	\N
230	ខ្ញុំ	\N		\N	\N	\N	436	\N
230	ខ្ញុំ	\N		\N	\N	\N	443	\N
230	ខ្ញុំ	\N		\N	\N	\N	451	\N
230	ខ្ញុំ	\N		\N	\N	\N	453	\N
230	ខ្ញុំ	\N		\N	\N	\N	455	\N
230	ខ្ញុំ	\N		\N	\N	\N	456	\N
230	ខ្ញុំ	\N		\N	\N	\N	457	\N
230	ខ្ញុំ	\N		\N	\N	\N	459	\N
230	ខ្ញុំ	\N		\N	\N	\N	465	\N
230	ខ្ញុំ	\N		\N	\N	\N	467	\N
230	ខ្ញុំ	\N		\N	\N	\N	468	\N
230	ខ្ញុំ	\N		\N	\N	\N	469	\N
230	ខ្ញុំ	\N		\N	\N	\N	470	\N
230	ខ្ញុំ	\N		\N	\N	\N	471	\N
230	ខ្ញុំ	\N		\N	\N	\N	472	\N
230	ខ្ញុំ	\N		\N	\N	\N	473	\N
230	ខ្ញុំ	\N		\N	\N	\N	476	\N
230	ខ្ញុំ	\N		\N	\N	\N	477	\N
230	ខ្ញុំ	\N		\N	\N	\N	479	\N
230	ខ្ញុំ	\N		\N	\N	\N	480	\N
230	ខ្ញុំ	\N		\N	\N	\N	482	\N
230	ខ្ញុំ	\N		\N	\N	\N	483	\N
230	ខ្ញុំ	\N		\N	\N	\N	484	\N
230	ខ្ញុំ	\N		\N	\N	\N	487	\N
230	ខ្ញុំ	\N		\N	\N	\N	488	\N
230	ខ្ញុំ	\N		\N	\N	\N	495	\N
230	ខ្ញុំ	\N		\N	\N	\N	497	\N
230	ខ្ញុំ	\N		\N	\N	\N	498	\N
230	ខ្ញុំ	\N		\N	\N	\N	500	\N
230	ខ្ញុំ	\N		\N	\N	\N	501	\N
230	ខ្ញុំ	\N		\N	\N	\N	502	\N
230	ខ្ញុំ	\N		\N	\N	\N	510	\N
230	ខ្ញុំ	\N		\N	\N	\N	512	\N
230	ខ្ញុំ	\N		\N	\N	\N	515	\N
230	ខ្ញុំ	\N		\N	\N	\N	523	\N
230	ខ្ញុំ	\N		\N	\N	\N	525	\N
230	ខ្ញុំ	\N		\N	\N	\N	527	\N
230	ខ្ញុំ	\N		\N	\N	\N	529	\N
230	ខ្ញុំ	\N		\N	\N	\N	533	\N
230	ខ្ញុំ	\N		\N	\N	\N	534	\N
230	ខ្ញុំ	\N		\N	\N	\N	535	\N
230	ខ្ញុំ	\N		\N	\N	\N	541	\N
230	ខ្ញុំ	\N		\N	\N	\N	545	\N
230	ខ្ញុំ	\N		\N	\N	\N	547	\N
230	ខ្ញុំ	\N		\N	\N	\N	572	\N
230	ខ្ញុំ	\N		\N	\N	\N	578	\N
230	ខ្ញុំ	\N		\N	\N	\N	586	\N
230	ខ្ញុំ	\N		\N	\N	\N	588	\N
230	ខ្ញុំ	\N		\N	\N	\N	590	\N
230	ខ្ញុំ	\N		\N	\N	\N	603	\N
230	ខ្ញុំ	\N		\N	\N	\N	605	\N
230	ខ្ញុំ	\N		\N	\N	\N	607	\N
230	ខ្ញុំ	\N		\N	\N	\N	609	\N
230	ខ្ញុំ	\N		\N	\N	\N	612	\N
230	ខ្ញុំ	\N		\N	\N	\N	616	\N
230	ខ្ញុំ	\N		\N	\N	\N	618	\N
230	ខ្ញុំ	\N		\N	\N	\N	630	\N
230	ខ្ញុំ	\N		\N	\N	\N	632	\N
230	ខ្ញុំ	\N		\N	\N	\N	633	\N
230	ខ្ញុំ	\N		\N	\N	\N	635	\N
230	ខ្ញុំ	\N		\N	\N	\N	637	\N
230	ខ្ញុំ	\N		\N	\N	\N	638	\N
230	ខ្ញុំ	\N		\N	\N	\N	642	\N
230	ខ្ញុំ	\N		\N	\N	\N	646	\N
230	ខ្ញុំ	\N		\N	\N	\N	650	\N
230	ខ្ញុំ	\N		\N	\N	\N	654	\N
230	ខ្ញុំ	\N		\N	\N	\N	656	\N
230	ខ្ញុំ	\N		\N	\N	\N	663	\N
230	ខ្ញុំ	\N		\N	\N	\N	664	\N
230	ខ្ញុំ	\N		\N	\N	\N	667	\N
230	ខ្ញុំ	\N		\N	\N	\N	669	\N
230	ខ្ញុំ	\N		\N	\N	\N	673	\N
230	ខ្ញុំ	\N		\N	\N	\N	676	\N
230	ខ្ញុំ	\N		\N	\N	\N	682	\N
230	ខ្ញុំ	\N		\N	\N	\N	686	\N
230	ខ្ញុំ	\N		\N	\N	\N	693	\N
230	ខ្ញុំ	\N		\N	\N	\N	700	\N
230	ខ្ញុំ	\N		\N	\N	\N	702	\N
230	ខ្ញុំ	\N		\N	\N	\N	708	\N
230	ខ្ញុំ	\N		\N	\N	\N	716	\N
230	ខ្ញុំ	\N		\N	\N	\N	718	\N
230	ខ្ញុំ	\N		\N	\N	\N	726	\N
230	ខ្ញុំ	\N		\N	\N	\N	733	\N
230	ខ្ញុំ	\N		\N	\N	\N	734	\N
230	ខ្ញុំ	\N		\N	\N	\N	735	\N
230	ខ្ញុំ	\N		\N	\N	\N	739	\N
230	ខ្ញុំ	\N		\N	\N	\N	740	\N
230	ខ្ញុំ	\N		\N	\N	\N	744	\N
230	ខ្ញុំ	\N		\N	\N	\N	749	\N
230	ខ្ញុំ	\N		\N	\N	\N	750	\N
230	ខ្ញុំ	\N		\N	\N	\N	751	\N
230	ខ្ញុំ	\N		\N	\N	\N	752	\N
230	ខ្ញុំ	\N		\N	\N	\N	756	\N
230	ខ្ញុំ	\N		\N	\N	\N	759	\N
230	ខ្ញុំ	\N		\N	\N	\N	761	\N
230	ខ្ញុំ	\N		\N	\N	\N	763	\N
230	ខ្ញុំ	\N		\N	\N	\N	764	\N
230	ខ្ញុំ	\N		\N	\N	\N	765	\N
230	ខ្ញុំ	\N		\N	\N	\N	786	\N
230	ខ្ញុំ	\N		\N	\N	\N	788	\N
230	ខ្ញុំ	\N		\N	\N	\N	795	\N
230	ខ្ញុំ	\N		\N	\N	\N	801	\N
230	ខ្ញុំ	\N		\N	\N	\N	803	\N
231	ពួកខ្ញុំ	\N		\N	\N	\N	1002	\N
232	អ្នកណាគេ	\N		\N	\N	\N	1003	\N
233	អ្នកណា	\N		\N	\N	\N	1003	\N
233	អ្នកណា	\N		\N	\N	\N	123	\N
233	អ្នកណា	\N		\N	\N	\N	343	\N
233	អ្នកណា	\N		\N	\N	\N	585	\N
233	អ្នកណា	\N		\N	\N	\N	590	\N
233	អ្នកណា	\N		\N	\N	\N	662	\N
233	អ្នកណា	\N		\N	\N	\N	715	\N
233	អ្នកណា	\N		\N	\N	\N	753	\N
233	អ្នកណា	\N		\N	\N	\N	762	\N
233	អ្នកណា	\N		\N	\N	\N	801	\N
234	អញ្ជើញពីខាងណា	\N		\N	\N	\N	1004	\N
235	គាត់ឯង	\N		\N	\N	\N	1005	\N
236	លោក	\N		\N	\N	\N	866	\N
236	លោក	\N		\N	\N	\N	931	\N
236	លោក	\N		\N	\N	\N	1002	\N
236	លោក	\N		\N	\N	\N	1004	\N
236	លោក	\N		\N	\N	\N	1084	\N
236	លោក	\N		\N	\N	\N	1107	\N
236	លោក	\N		\N	\N	\N	1109	\N
236	លោក	\N		\N	\N	\N	1123	\N
236	លោក	\N		\N	\N	\N	1130	\N
236	លោក	\N		\N	\N	\N	140	\N
236	លោក	\N		\N	\N	\N	360	\N
236	លោក	\N		\N	\N	\N	441	\N
236	លោក	\N		\N	\N	\N	443	\N
236	លោក	\N		\N	\N	\N	451	\N
236	លោក	\N		\N	\N	\N	455	\N
236	លោក	\N		\N	\N	\N	456	\N
236	លោក	\N		\N	\N	\N	458	\N
236	លោក	\N		\N	\N	\N	464	\N
236	លោក	\N		\N	\N	\N	466	\N
236	លោក	\N		\N	\N	\N	469	\N
236	លោក	\N		\N	\N	\N	472	\N
236	លោក	\N		\N	\N	\N	474	\N
236	លោក	\N		\N	\N	\N	477	\N
236	លោក	\N		\N	\N	\N	480	\N
236	លោក	\N		\N	\N	\N	485	\N
236	លោក	\N		\N	\N	\N	497	\N
236	លោក	\N		\N	\N	\N	500	\N
236	លោក	\N		\N	\N	\N	510	\N
236	លោក	\N		\N	\N	\N	516	\N
236	លោក	\N		\N	\N	\N	534	\N
236	លោក	\N		\N	\N	\N	542	\N
236	លោក	\N		\N	\N	\N	544	\N
236	លោក	\N		\N	\N	\N	548	\N
236	លោក	\N		\N	\N	\N	601	\N
236	លោក	\N		\N	\N	\N	602	\N
236	លោក	\N		\N	\N	\N	604	\N
236	លោក	\N		\N	\N	\N	606	\N
236	លោក	\N		\N	\N	\N	611	\N
236	លោក	\N		\N	\N	\N	612	\N
236	លោក	\N		\N	\N	\N	614	\N
236	លោក	\N		\N	\N	\N	615	\N
236	លោក	\N		\N	\N	\N	616	\N
236	លោក	\N		\N	\N	\N	617	\N
236	លោក	\N		\N	\N	\N	630	\N
236	លោក	\N		\N	\N	\N	631	\N
236	លោក	\N		\N	\N	\N	635	\N
236	លោក	\N		\N	\N	\N	638	\N
236	លោក	\N		\N	\N	\N	639	\N
236	លោក	\N		\N	\N	\N	649	\N
236	លោក	\N		\N	\N	\N	651	\N
236	លោក	\N		\N	\N	\N	653	\N
236	លោក	\N		\N	\N	\N	655	\N
236	លោក	\N		\N	\N	\N	664	\N
236	លោក	\N		\N	\N	\N	666	\N
236	លោក	\N		\N	\N	\N	675	\N
236	លោក	\N		\N	\N	\N	691	\N
236	លោក	\N		\N	\N	\N	694	\N
236	លោក	\N		\N	\N	\N	710	\N
236	លោក	\N		\N	\N	\N	723	\N
236	លោក	\N		\N	\N	\N	725	\N
236	លោក	\N		\N	\N	\N	729	\N
236	លោក	\N		\N	\N	\N	731	\N
236	លោក	\N		\N	\N	\N	735	\N
236	លោក	\N		\N	\N	\N	742	\N
236	លោក	\N		\N	\N	\N	754	\N
236	លោក	\N		\N	\N	\N	758	\N
236	លោក	\N		\N	\N	\N	759	\N
236	លោក	\N		\N	\N	\N	777	\N
236	លោក	\N		\N	\N	\N	778	\N
236	លោក	\N		\N	\N	\N	789	\N
236	លោក	\N		\N	\N	\N	796	\N
236	លោក	\N		\N	\N	\N	797	\N
237	នេះ	\N		\N	\N	\N	873	\N
237	នេះ	\N		\N	\N	\N	895	\N
237	នេះ	\N		\N	\N	\N	898	\N
237	នេះ	\N		\N	\N	\N	903	\N
237	នេះ	\N		\N	\N	\N	909	\N
237	នេះ	\N		\N	\N	\N	913	\N
237	នេះ	\N		\N	\N	\N	920	\N
237	នេះ	\N		\N	\N	\N	923	\N
237	នេះ	\N		\N	\N	\N	932	\N
237	នេះ	\N		\N	\N	\N	938	\N
237	នេះ	\N		\N	\N	\N	940	\N
237	នេះ	\N		\N	\N	\N	964	\N
237	នេះ	\N		\N	\N	\N	965	\N
237	នេះ	\N		\N	\N	\N	987	\N
237	នេះ	\N		\N	\N	\N	989	\N
237	នេះ	\N		\N	\N	\N	990	\N
237	នេះ	\N		\N	\N	\N	997	\N
237	នេះ	\N		\N	\N	\N	1001	\N
237	នេះ	\N		\N	\N	\N	1007	\N
237	នេះ	\N		\N	\N	\N	1009	\N
237	នេះ	\N		\N	\N	\N	1012	\N
237	នេះ	\N		\N	\N	\N	1014	\N
237	នេះ	\N		\N	\N	\N	1024	\N
237	នេះ	\N		\N	\N	\N	1025	\N
237	នេះ	\N		\N	\N	\N	1027	\N
237	នេះ	\N		\N	\N	\N	1033	\N
237	នេះ	\N		\N	\N	\N	1034	\N
237	នេះ	\N		\N	\N	\N	1038	\N
237	នេះ	\N		\N	\N	\N	1048	\N
237	នេះ	\N		\N	\N	\N	1055	\N
237	នេះ	\N		\N	\N	\N	1058	\N
237	នេះ	\N		\N	\N	\N	1062	\N
237	នេះ	\N		\N	\N	\N	1074	\N
237	នេះ	\N		\N	\N	\N	1080	\N
237	នេះ	\N		\N	\N	\N	1084	\N
237	នេះ	\N		\N	\N	\N	1085	\N
237	នេះ	\N		\N	\N	\N	1087	\N
237	នេះ	\N		\N	\N	\N	1101	\N
237	នេះ	\N		\N	\N	\N	1104	\N
237	នេះ	\N		\N	\N	\N	1105	\N
237	នេះ	\N		\N	\N	\N	1108	\N
237	នេះ	\N		\N	\N	\N	1109	\N
237	នេះ	\N		\N	\N	\N	1117	\N
237	នេះ	\N		\N	\N	\N	1122	\N
237	នេះ	\N		\N	\N	\N	1128	\N
237	នេះ	\N		\N	\N	\N	1136	\N
237	នេះ	\N		\N	\N	\N	1137	\N
237	នេះ	\N		\N	\N	\N	1141	\N
237	នេះ	\N		\N	\N	\N	41	\N
237	នេះ	\N		\N	\N	\N	62	\N
237	នេះ	\N		\N	\N	\N	64	\N
237	នេះ	\N		\N	\N	\N	65	\N
237	នេះ	\N		\N	\N	\N	68	\N
237	នេះ	\N		\N	\N	\N	126	\N
237	នេះ	\N		\N	\N	\N	127	\N
237	នេះ	\N		\N	\N	\N	128	\N
237	នេះ	\N		\N	\N	\N	129	\N
237	នេះ	\N		\N	\N	\N	166	\N
237	នេះ	\N		\N	\N	\N	167	\N
237	នេះ	\N		\N	\N	\N	183	\N
237	នេះ	\N		\N	\N	\N	187	\N
237	នេះ	\N		\N	\N	\N	188	\N
237	នេះ	\N		\N	\N	\N	189	\N
237	នេះ	\N		\N	\N	\N	190	\N
237	នេះ	\N		\N	\N	\N	191	\N
237	នេះ	\N		\N	\N	\N	204	\N
237	នេះ	\N		\N	\N	\N	208	\N
237	នេះ	\N		\N	\N	\N	261	\N
237	នេះ	\N		\N	\N	\N	282	\N
237	នេះ	\N		\N	\N	\N	284	\N
237	នេះ	\N		\N	\N	\N	285	\N
237	នេះ	\N		\N	\N	\N	288	\N
237	នេះ	\N		\N	\N	\N	346	\N
237	នេះ	\N		\N	\N	\N	347	\N
237	នេះ	\N		\N	\N	\N	348	\N
237	នេះ	\N		\N	\N	\N	349	\N
237	នេះ	\N		\N	\N	\N	386	\N
237	នេះ	\N		\N	\N	\N	387	\N
237	នេះ	\N		\N	\N	\N	403	\N
237	នេះ	\N		\N	\N	\N	407	\N
237	នេះ	\N		\N	\N	\N	408	\N
237	នេះ	\N		\N	\N	\N	409	\N
237	នេះ	\N		\N	\N	\N	410	\N
237	នេះ	\N		\N	\N	\N	411	\N
237	នេះ	\N		\N	\N	\N	424	\N
237	នេះ	\N		\N	\N	\N	428	\N
237	នេះ	\N		\N	\N	\N	452	\N
237	នេះ	\N		\N	\N	\N	457	\N
237	នេះ	\N		\N	\N	\N	469	\N
237	នេះ	\N		\N	\N	\N	471	\N
237	នេះ	\N		\N	\N	\N	476	\N
237	នេះ	\N		\N	\N	\N	479	\N
237	នេះ	\N		\N	\N	\N	487	\N
237	នេះ	\N		\N	\N	\N	492	\N
237	នេះ	\N		\N	\N	\N	497	\N
237	នេះ	\N		\N	\N	\N	500	\N
237	នេះ	\N		\N	\N	\N	507	\N
237	នេះ	\N		\N	\N	\N	551	\N
237	នេះ	\N		\N	\N	\N	561	\N
237	នេះ	\N		\N	\N	\N	563	\N
237	នេះ	\N		\N	\N	\N	565	\N
237	នេះ	\N		\N	\N	\N	569	\N
237	នេះ	\N		\N	\N	\N	576	\N
237	នេះ	\N		\N	\N	\N	577	\N
237	នេះ	\N		\N	\N	\N	578	\N
237	នេះ	\N		\N	\N	\N	585	\N
237	នេះ	\N		\N	\N	\N	588	\N
237	នេះ	\N		\N	\N	\N	590	\N
237	នេះ	\N		\N	\N	\N	599	\N
237	នេះ	\N		\N	\N	\N	611	\N
237	នេះ	\N		\N	\N	\N	613	\N
237	នេះ	\N		\N	\N	\N	615	\N
237	នេះ	\N		\N	\N	\N	625	\N
237	នេះ	\N		\N	\N	\N	647	\N
237	នេះ	\N		\N	\N	\N	673	\N
237	នេះ	\N		\N	\N	\N	677	\N
237	នេះ	\N		\N	\N	\N	695	\N
237	នេះ	\N		\N	\N	\N	696	\N
237	នេះ	\N		\N	\N	\N	712	\N
237	នេះ	\N		\N	\N	\N	723	\N
237	នេះ	\N		\N	\N	\N	742	\N
237	នេះ	\N		\N	\N	\N	747	\N
237	នេះ	\N		\N	\N	\N	751	\N
237	នេះ	\N		\N	\N	\N	760	\N
237	នេះ	\N		\N	\N	\N	770	\N
237	នេះ	\N		\N	\N	\N	775	\N
237	នេះ	\N		\N	\N	\N	793	\N
237	នេះ	\N		\N	\N	\N	794	\N
237	នេះ	\N		\N	\N	\N	796	\N
238	នោះ	\N		\N	\N	\N	921	\N
238	នោះ	\N		\N	\N	\N	922	\N
238	នោះ	\N		\N	\N	\N	1005	\N
238	នោះ	\N		\N	\N	\N	63	\N
238	នោះ	\N		\N	\N	\N	68	\N
238	នោះ	\N		\N	\N	\N	165	\N
238	នោះ	\N		\N	\N	\N	187	\N
238	នោះ	\N		\N	\N	\N	190	\N
238	នោះ	\N		\N	\N	\N	191	\N
238	នោះ	\N		\N	\N	\N	283	\N
238	នោះ	\N		\N	\N	\N	288	\N
238	នោះ	\N		\N	\N	\N	385	\N
238	នោះ	\N		\N	\N	\N	407	\N
238	នោះ	\N		\N	\N	\N	410	\N
238	នោះ	\N		\N	\N	\N	411	\N
238	នោះ	\N		\N	\N	\N	552	\N
238	នោះ	\N		\N	\N	\N	580	\N
238	នោះ	\N		\N	\N	\N	581	\N
238	នោះ	\N		\N	\N	\N	583	\N
238	នោះ	\N		\N	\N	\N	641	\N
238	នោះ	\N		\N	\N	\N	753	\N
238	នោះ	\N		\N	\N	\N	756	\N
238	នោះ	\N		\N	\N	\N	802	\N
239	ត្រូវការអី	\N		\N	\N	\N	1006	\N
240	មួយណា	\N		\N	\N	\N	649	\N
240	មួយណា	\N		\N	\N	\N	651	\N
241	យ៉ាងណា	\N		\N	\N	\N	803	\N
242	យ៉ាងនេះ	\N		\N	\N	\N	673	\N
243	ខ្លួនឯង	\N		\N	\N	\N	484	\N
244	អញ្ចឹង	\N		\N	\N	\N	450	\N
244	អញ្ចឹង	\N		\N	\N	\N	453	\N
244	អញ្ចឹង	\N		\N	\N	\N	515	\N
244	អញ្ចឹង	\N		\N	\N	\N	574	\N
244	អញ្ចឹង	\N		\N	\N	\N	608	\N
244	អញ្ចឹង	\N		\N	\N	\N	613	\N
244	អញ្ចឹង	\N		\N	\N	\N	615	\N
244	អញ្ចឹង	\N		\N	\N	\N	617	\N
244	អញ្ចឹង	\N		\N	\N	\N	634	\N
244	អញ្ចឹង	\N		\N	\N	\N	636	\N
244	អញ្ចឹង	\N		\N	\N	\N	651	\N
244	អញ្ចឹង	\N		\N	\N	\N	664	\N
244	អញ្ចឹង	\N		\N	\N	\N	670	\N
244	អញ្ចឹង	\N		\N	\N	\N	733	\N
244	អញ្ចឹង	\N		\N	\N	\N	735	\N
244	អញ្ចឹង	\N		\N	\N	\N	745	\N
244	អញ្ចឹង	\N		\N	\N	\N	753	\N
244	អញ្ចឹង	\N		\N	\N	\N	764	\N
244	អញ្ចឹង	\N		\N	\N	\N	781	\N
244	អញ្ចឹង	\N		\N	\N	\N	793	\N
245	ក្រាស់	\N		\N	\N	\N	1007	\N
246	ចង្អៀត	\N		\N	\N	\N	1008	\N
247	ស្គម	\N		\N	\N	\N	1009	\N
247	ស្គម	\N		\N	\N	\N	1047	\N
248	ធំ	\N		\N	\N	\N	881	\N
248	ធំ	\N		\N	\N	\N	893	\N
248	ធំ	\N		\N	\N	\N	906	\N
248	ធំ	\N		\N	\N	\N	915	\N
248	ធំ	\N		\N	\N	\N	937	\N
248	ធំ	\N		\N	\N	\N	990	\N
248	ធំ	\N		\N	\N	\N	993	\N
248	ធំ	\N		\N	\N	\N	999	\N
248	ធំ	\N		\N	\N	\N	1003	\N
248	ធំ	\N		\N	\N	\N	1025	\N
248	ធំ	\N		\N	\N	\N	51	\N
248	ធំ	\N		\N	\N	\N	54	\N
248	ធំ	\N		\N	\N	\N	191	\N
248	ធំ	\N		\N	\N	\N	271	\N
248	ធំ	\N		\N	\N	\N	274	\N
248	ធំ	\N		\N	\N	\N	411	\N
248	ធំ	\N		\N	\N	\N	536	\N
248	ធំ	\N		\N	\N	\N	538	\N
248	ធំ	\N		\N	\N	\N	724	\N
248	ធំ	\N		\N	\N	\N	788	\N
249	ធាត់	\N		\N	\N	\N	1010	\N
250	ក្មេង	\N		\N	\N	\N	902	\N
250	ក្មេង	\N		\N	\N	\N	1009	\N
250	ក្មេង	\N		\N	\N	\N	1011	\N
250	ក្មេង	\N		\N	\N	\N	1042	\N
250	ក្មេង	\N		\N	\N	\N	1078	\N
250	ក្មេង	\N		\N	\N	\N	1123	\N
250	ក្មេង	\N		\N	\N	\N	1135	\N
251	ទូលាយ	\N		\N	\N	\N	1008	\N
251	ទូលាយ	\N		\N	\N	\N	1012	\N
252	ស្រាល	\N		\N	\N	\N	633	\N
253	ឆ្ងាយ	\N		\N	\N	\N	1013	\N
254	ធ្ងន់	\N		\N	\N	\N	1014	\N
255	ស្ដើង	\N		\N	\N	\N	1015	\N
256	ថ្មី	\N		\N	\N	\N	919	\N
256	ថ្មី	\N		\N	\N	\N	971	\N
256	ថ្មី	\N		\N	\N	\N	1061	\N
256	ថ្មី	\N		\N	\N	\N	1134	\N
256	ថ្មី	\N		\N	\N	\N	469	\N
256	ថ្មី	\N		\N	\N	\N	526	\N
256	ថ្មី	\N		\N	\N	\N	590	\N
256	ថ្មី	\N		\N	\N	\N	593	\N
256	ថ្មី	\N		\N	\N	\N	676	\N
256	ថ្មី	\N		\N	\N	\N	696	\N
256	ថ្មី	\N		\N	\N	\N	704	\N
257	តូច	\N		\N	\N	\N	973	\N
257	តូច	\N		\N	\N	\N	1049	\N
257	តូច	\N		\N	\N	\N	563	\N
257	តូច	\N		\N	\N	\N	695	\N
258	ចាស់	\N		\N	\N	\N	900	\N
258	ចាស់	\N		\N	\N	\N	902	\N
258	ចាស់	\N		\N	\N	\N	912	\N
258	ចាស់	\N		\N	\N	\N	961	\N
258	ចាស់	\N		\N	\N	\N	1008	\N
258	ចាស់	\N		\N	\N	\N	1125	\N
258	ចាស់	\N		\N	\N	\N	841	\N
258	ចាស់	\N		\N	\N	\N	464	\N
259	សប្បាយ	\N		\N	\N	\N	1082	\N
259	សប្បាយ	\N		\N	\N	\N	445	\N
259	សប្បាយ	\N		\N	\N	\N	476	\N
259	សប្បាយ	\N		\N	\N	\N	500	\N
259	សប្បាយ	\N		\N	\N	\N	503	\N
259	សប្បាយ	\N		\N	\N	\N	505	\N
259	សប្បាយ	\N		\N	\N	\N	641	\N
260	អឺងកង	\N		\N	\N	\N	1016	\N
261	ទាប	\N		\N	\N	\N	1017	\N
261	ទាប	\N		\N	\N	\N	1069	\N
261	ទាប	\N		\N	\N	\N	1137	\N
262	ល្អ	\N		\N	\N	\N	929	\N
262	ល្អ	\N		\N	\N	\N	936	\N
262	ល្អ	\N		\N	\N	\N	975	\N
262	ល្អ	\N		\N	\N	\N	1046	\N
262	ល្អ	\N		\N	\N	\N	1135	\N
262	ល្អ	\N		\N	\N	\N	90	\N
262	ល្អ	\N		\N	\N	\N	93	\N
262	ល្អ	\N		\N	\N	\N	176	\N
262	ល្អ	\N		\N	\N	\N	310	\N
262	ល្អ	\N		\N	\N	\N	313	\N
262	ល្អ	\N		\N	\N	\N	396	\N
262	ល្អ	\N		\N	\N	\N	449	\N
262	ល្អ	\N		\N	\N	\N	532	\N
262	ល្អ	\N		\N	\N	\N	565	\N
262	ល្អ	\N		\N	\N	\N	590	\N
262	ល្អ	\N		\N	\N	\N	636	\N
262	ល្អ	\N		\N	\N	\N	647	\N
262	ល្អ	\N		\N	\N	\N	701	\N
262	ល្អ	\N		\N	\N	\N	711	\N
262	ល្អ	\N		\N	\N	\N	798	\N
263	ភ្លឺ	\N		\N	\N	\N	914	\N
263	ភ្លឺ	\N		\N	\N	\N	1018	\N
264	ខ្សោយ	\N		\N	\N	\N	1019	\N
265	ខ្លាំង	\N		\N	\N	\N	887	\N
265	ខ្លាំង	\N		\N	\N	\N	973	\N
265	ខ្លាំង	\N		\N	\N	\N	1037	\N
265	ខ្លាំង	\N		\N	\N	\N	20	\N
265	ខ្លាំង	\N		\N	\N	\N	240	\N
266	គួរឲ្យចាប់អារម្មណ៍	\N		\N	\N	\N	730	\N
267	ស្អាត	\N		\N	\N	\N	885	\N
267	ស្អាត	\N		\N	\N	\N	890	\N
267	ស្អាត	\N		\N	\N	\N	1049	\N
267	ស្អាត	\N		\N	\N	\N	695	\N
268	អាក្រក់	\N		\N	\N	\N	1020	\N
269	ច្រើន	\N		\N	\N	\N	866	\N
269	ច្រើន	\N		\N	\N	\N	871	\N
269	ច្រើន	\N		\N	\N	\N	872	\N
269	ច្រើន	\N		\N	\N	\N	881	\N
269	ច្រើន	\N		\N	\N	\N	886	\N
269	ច្រើន	\N		\N	\N	\N	892	\N
269	ច្រើន	\N		\N	\N	\N	900	\N
269	ច្រើន	\N		\N	\N	\N	903	\N
269	ច្រើន	\N		\N	\N	\N	904	\N
269	ច្រើន	\N		\N	\N	\N	907	\N
269	ច្រើន	\N		\N	\N	\N	931	\N
269	ច្រើន	\N		\N	\N	\N	942	\N
269	ច្រើន	\N		\N	\N	\N	946	\N
269	ច្រើន	\N		\N	\N	\N	955	\N
269	ច្រើន	\N		\N	\N	\N	964	\N
269	ច្រើន	\N		\N	\N	\N	976	\N
269	ច្រើន	\N		\N	\N	\N	991	\N
269	ច្រើន	\N		\N	\N	\N	992	\N
269	ច្រើន	\N		\N	\N	\N	996	\N
269	ច្រើន	\N		\N	\N	\N	1039	\N
269	ច្រើន	\N		\N	\N	\N	1052	\N
269	ច្រើន	\N		\N	\N	\N	1062	\N
269	ច្រើន	\N		\N	\N	\N	1067	\N
269	ច្រើន	\N		\N	\N	\N	1078	\N
269	ច្រើន	\N		\N	\N	\N	7	\N
269	ច្រើន	\N		\N	\N	\N	37	\N
269	ច្រើន	\N		\N	\N	\N	77	\N
269	ច្រើន	\N		\N	\N	\N	227	\N
269	ច្រើន	\N		\N	\N	\N	257	\N
269	ច្រើន	\N		\N	\N	\N	297	\N
269	ច្រើន	\N		\N	\N	\N	447	\N
269	ច្រើន	\N		\N	\N	\N	455	\N
269	ច្រើន	\N		\N	\N	\N	459	\N
269	ច្រើន	\N		\N	\N	\N	460	\N
269	ច្រើន	\N		\N	\N	\N	462	\N
269	ច្រើន	\N		\N	\N	\N	498	\N
269	ច្រើន	\N		\N	\N	\N	510	\N
269	ច្រើន	\N		\N	\N	\N	525	\N
269	ច្រើន	\N		\N	\N	\N	535	\N
269	ច្រើន	\N		\N	\N	\N	536	\N
269	ច្រើន	\N		\N	\N	\N	537	\N
269	ច្រើន	\N		\N	\N	\N	572	\N
269	ច្រើន	\N		\N	\N	\N	578	\N
269	ច្រើន	\N		\N	\N	\N	638	\N
270	ងងឹត	\N		\N	\N	\N	1021	\N
271	ស្ងាត់	\N		\N	\N	\N	918	\N
271	ស្ងាត់	\N		\N	\N	\N	1022	\N
272	តិច	\N		\N	\N	\N	1075	\N
272	តិច	\N		\N	\N	\N	1093	\N
272	តិច	\N		\N	\N	\N	133	\N
272	តិច	\N		\N	\N	\N	353	\N
272	តិច	\N		\N	\N	\N	446	\N
272	តិច	\N		\N	\N	\N	459	\N
272	តិច	\N		\N	\N	\N	518	\N
272	តិច	\N		\N	\N	\N	580	\N
272	តិច	\N		\N	\N	\N	634	\N
272	តិច	\N		\N	\N	\N	681	\N
272	តិច	\N		\N	\N	\N	687	\N
272	តិច	\N		\N	\N	\N	698	\N
272	តិច	\N		\N	\N	\N	705	\N
272	តិច	\N		\N	\N	\N	706	\N
272	តិច	\N		\N	\N	\N	741	\N
272	តិច	\N		\N	\N	\N	750	\N
272	តិច	\N		\N	\N	\N	766	\N
272	តិច	\N		\N	\N	\N	810	\N
272	តិច	\N		\N	\N	\N	824	\N
273	កខ្វក់	\N		\N	\N	\N	1023	\N
274	អផ្សុក	\N		\N	\N	\N	1024	\N
275	ទទឹង	\N		\N	\N	\N	1025	\N
276	ក្នុង	\N		\N	\N	\N	866	\N
276	ក្នុង	\N		\N	\N	\N	885	\N
276	ក្នុង	\N		\N	\N	\N	887	\N
276	ក្នុង	\N		\N	\N	\N	899	\N
276	ក្នុង	\N		\N	\N	\N	904	\N
276	ក្នុង	\N		\N	\N	\N	905	\N
276	ក្នុង	\N		\N	\N	\N	927	\N
276	ក្នុង	\N		\N	\N	\N	931	\N
276	ក្នុង	\N		\N	\N	\N	941	\N
276	ក្នុង	\N		\N	\N	\N	943	\N
276	ក្នុង	\N		\N	\N	\N	979	\N
276	ក្នុង	\N		\N	\N	\N	995	\N
276	ក្នុង	\N		\N	\N	\N	1060	\N
276	ក្នុង	\N		\N	\N	\N	1064	\N
276	ក្នុង	\N		\N	\N	\N	1069	\N
276	ក្នុង	\N		\N	\N	\N	1073	\N
276	ក្នុង	\N		\N	\N	\N	1103	\N
276	ក្នុង	\N		\N	\N	\N	1117	\N
276	ក្នុង	\N		\N	\N	\N	1121	\N
276	ក្នុង	\N		\N	\N	\N	34	\N
276	ក្នុង	\N		\N	\N	\N	254	\N
276	ក្នុង	\N		\N	\N	\N	469	\N
276	ក្នុង	\N		\N	\N	\N	471	\N
276	ក្នុង	\N		\N	\N	\N	476	\N
276	ក្នុង	\N		\N	\N	\N	490	\N
276	ក្នុង	\N		\N	\N	\N	497	\N
276	ក្នុង	\N		\N	\N	\N	517	\N
276	ក្នុង	\N		\N	\N	\N	552	\N
276	ក្នុង	\N		\N	\N	\N	576	\N
276	ក្នុង	\N		\N	\N	\N	623	\N
276	ក្នុង	\N		\N	\N	\N	625	\N
276	ក្នុង	\N		\N	\N	\N	644	\N
276	ក្នុង	\N		\N	\N	\N	651	\N
276	ក្នុង	\N		\N	\N	\N	677	\N
276	ក្នុង	\N		\N	\N	\N	727	\N
276	ក្នុង	\N		\N	\N	\N	744	\N
276	ក្នុង	\N		\N	\N	\N	747	\N
276	ក្នុង	\N		\N	\N	\N	775	\N
276	ក្នុង	\N		\N	\N	\N	794	\N
277	ក្រៅ	\N		\N	\N	\N	599	\N
277	ក្រៅ	\N		\N	\N	\N	612	\N
277	ក្រៅ	\N		\N	\N	\N	644	\N
278	កើត	\N		\N	\N	\N	1000	\N
278	កើត	\N		\N	\N	\N	1131	\N
278	កើត	\N		\N	\N	\N	644	\N
279	កំពស់	\N		\N	\N	\N	1026	\N
280	បណ្ដោយ	\N		\N	\N	\N	1027	\N
281	ជើង	\N		\N	\N	\N	925	\N
281	ជើង	\N		\N	\N	\N	979	\N
281	ជើង	\N		\N	\N	\N	1034	\N
281	ជើង	\N		\N	\N	\N	1036	\N
281	ជើង	\N		\N	\N	\N	1072	\N
281	ជើង	\N		\N	\N	\N	727	\N
282	លិច	\N		\N	\N	\N	1028	\N
282	លិច	\N		\N	\N	\N	1100	\N
283	ក្រោម	\N		\N	\N	\N	958	\N
283	ក្រោម	\N		\N	\N	\N	552	\N
284	ត្បូង	\N		\N	\N	\N	978	\N
284	ត្បូង	\N		\N	\N	\N	1029	\N
285	លើ	\N		\N	\N	\N	889	\N
285	លើ	\N		\N	\N	\N	911	\N
285	លើ	\N		\N	\N	\N	948	\N
285	លើ	\N		\N	\N	\N	949	\N
285	លើ	\N		\N	\N	\N	955	\N
285	លើ	\N		\N	\N	\N	958	\N
285	លើ	\N		\N	\N	\N	961	\N
285	លើ	\N		\N	\N	\N	1003	\N
285	លើ	\N		\N	\N	\N	1035	\N
285	លើ	\N		\N	\N	\N	1102	\N
285	លើ	\N		\N	\N	\N	1104	\N
285	លើ	\N		\N	\N	\N	1115	\N
285	លើ	\N		\N	\N	\N	1116	\N
285	លើ	\N		\N	\N	\N	1127	\N
285	លើ	\N		\N	\N	\N	1133	\N
285	លើ	\N		\N	\N	\N	108	\N
285	លើ	\N		\N	\N	\N	328	\N
285	លើ	\N		\N	\N	\N	563	\N
285	លើ	\N		\N	\N	\N	565	\N
286	បងប្អូនជីដូនមួយ	\N		\N	\N	\N	1030	\N
287	បងប្រុស	\N		\N	\N	\N	144	\N
287	បងប្រុស	\N		\N	\N	\N	210	\N
287	បងប្រុស	\N		\N	\N	\N	364	\N
287	បងប្រុស	\N		\N	\N	\N	430	\N
288	បងប្អូនប្រុស	\N		\N	\N	\N	1031	\N
289	យាយ	\N		\N	\N	\N	866	\N
289	យាយ	\N		\N	\N	\N	904	\N
289	យាយ	\N		\N	\N	\N	914	\N
289	យាយ	\N		\N	\N	\N	936	\N
289	យាយ	\N		\N	\N	\N	979	\N
289	យាយ	\N		\N	\N	\N	1040	\N
289	យាយ	\N		\N	\N	\N	11	\N
289	យាយ	\N		\N	\N	\N	12	\N
289	យាយ	\N		\N	\N	\N	15	\N
289	យាយ	\N		\N	\N	\N	16	\N
289	យាយ	\N		\N	\N	\N	19	\N
289	យាយ	\N		\N	\N	\N	20	\N
289	យាយ	\N		\N	\N	\N	72	\N
289	យាយ	\N		\N	\N	\N	142	\N
289	យាយ	\N		\N	\N	\N	183	\N
289	យាយ	\N		\N	\N	\N	186	\N
289	យាយ	\N		\N	\N	\N	194	\N
289	យាយ	\N		\N	\N	\N	231	\N
289	យាយ	\N		\N	\N	\N	232	\N
289	យាយ	\N		\N	\N	\N	235	\N
289	យាយ	\N		\N	\N	\N	236	\N
289	យាយ	\N		\N	\N	\N	239	\N
289	យាយ	\N		\N	\N	\N	240	\N
289	យាយ	\N		\N	\N	\N	292	\N
289	យាយ	\N		\N	\N	\N	362	\N
289	យាយ	\N		\N	\N	\N	403	\N
289	យាយ	\N		\N	\N	\N	406	\N
289	យាយ	\N		\N	\N	\N	414	\N
289	យាយ	\N		\N	\N	\N	500	\N
391	នៅ	\N		\N	\N	\N	550	\N
289	យាយ	\N		\N	\N	\N	525	\N
289	យាយ	\N		\N	\N	\N	578	\N
290	តា	\N		\N	\N	\N	873	\N
290	តា	\N		\N	\N	\N	882	\N
290	តា	\N		\N	\N	\N	883	\N
290	តា	\N		\N	\N	\N	884	\N
290	តា	\N		\N	\N	\N	886	\N
290	តា	\N		\N	\N	\N	888	\N
290	តា	\N		\N	\N	\N	914	\N
290	តា	\N		\N	\N	\N	915	\N
290	តា	\N		\N	\N	\N	917	\N
290	តា	\N		\N	\N	\N	918	\N
290	តា	\N		\N	\N	\N	924	\N
290	តា	\N		\N	\N	\N	926	\N
290	តា	\N		\N	\N	\N	933	\N
290	តា	\N		\N	\N	\N	937	\N
290	តា	\N		\N	\N	\N	938	\N
290	តា	\N		\N	\N	\N	974	\N
290	តា	\N		\N	\N	\N	981	\N
290	តា	\N		\N	\N	\N	982	\N
290	តា	\N		\N	\N	\N	999	\N
290	តា	\N		\N	\N	\N	1051	\N
290	តា	\N		\N	\N	\N	1064	\N
290	តា	\N		\N	\N	\N	1079	\N
290	តា	\N		\N	\N	\N	1085	\N
290	តា	\N		\N	\N	\N	1087	\N
290	តា	\N		\N	\N	\N	1095	\N
290	តា	\N		\N	\N	\N	1106	\N
290	តា	\N		\N	\N	\N	1107	\N
290	តា	\N		\N	\N	\N	1123	\N
290	តា	\N		\N	\N	\N	142	\N
290	តា	\N		\N	\N	\N	206	\N
290	តា	\N		\N	\N	\N	208	\N
290	តា	\N		\N	\N	\N	835	\N
290	តា	\N		\N	\N	\N	851	\N
290	តា	\N		\N	\N	\N	362	\N
290	តា	\N		\N	\N	\N	426	\N
290	តា	\N		\N	\N	\N	428	\N
290	តា	\N		\N	\N	\N	442	\N
290	តា	\N		\N	\N	\N	466	\N
290	តា	\N		\N	\N	\N	470	\N
290	តា	\N		\N	\N	\N	474	\N
290	តា	\N		\N	\N	\N	477	\N
290	តា	\N		\N	\N	\N	497	\N
290	តា	\N		\N	\N	\N	503	\N
290	តា	\N		\N	\N	\N	522	\N
290	តា	\N		\N	\N	\N	550	\N
290	តា	\N		\N	\N	\N	551	\N
290	តា	\N		\N	\N	\N	556	\N
290	តា	\N		\N	\N	\N	559	\N
290	តា	\N		\N	\N	\N	567	\N
290	តា	\N		\N	\N	\N	571	\N
290	តា	\N		\N	\N	\N	572	\N
290	តា	\N		\N	\N	\N	576	\N
290	តា	\N		\N	\N	\N	588	\N
290	តា	\N		\N	\N	\N	598	\N
290	តា	\N		\N	\N	\N	630	\N
290	តា	\N		\N	\N	\N	648	\N
290	តា	\N		\N	\N	\N	654	\N
290	តា	\N		\N	\N	\N	665	\N
290	តា	\N		\N	\N	\N	688	\N
290	តា	\N		\N	\N	\N	690	\N
290	តា	\N		\N	\N	\N	691	\N
290	តា	\N		\N	\N	\N	732	\N
290	តា	\N		\N	\N	\N	750	\N
290	តា	\N		\N	\N	\N	767	\N
290	តា	\N		\N	\N	\N	773	\N
290	តា	\N		\N	\N	\N	781	\N
291	ប្រពន្ធ	\N		\N	\N	\N	1125	\N
291	ប្រពន្ធ	\N		\N	\N	\N	545	\N
292	ម្ដាយ	\N		\N	\N	\N	1032	\N
292	ម្ដាយ	\N		\N	\N	\N	142	\N
292	ម្ដាយ	\N		\N	\N	\N	164	\N
292	ម្ដាយ	\N		\N	\N	\N	362	\N
292	ម្ដាយ	\N		\N	\N	\N	384	\N
293	ពូ	\N		\N	\N	\N	877	\N
293	ពូ	\N		\N	\N	\N	890	\N
293	ពូ	\N		\N	\N	\N	1107	\N
293	ពូ	\N		\N	\N	\N	1116	\N
293	ពូ	\N		\N	\N	\N	3	\N
293	ពូ	\N		\N	\N	\N	4	\N
293	ពូ	\N		\N	\N	\N	83	\N
293	ពូ	\N		\N	\N	\N	143	\N
293	ពូ	\N		\N	\N	\N	223	\N
293	ពូ	\N		\N	\N	\N	224	\N
293	ពូ	\N		\N	\N	\N	303	\N
293	ពូ	\N		\N	\N	\N	363	\N
293	ពូ	\N		\N	\N	\N	573	\N
293	ពូ	\N		\N	\N	\N	653	\N
293	ពូ	\N		\N	\N	\N	801	\N
295	ឪពុក	\N		\N	\N	\N	937	\N
295	ឪពុក	\N		\N	\N	\N	142	\N
295	ឪពុក	\N		\N	\N	\N	362	\N
295	ឪពុក	\N		\N	\N	\N	525	\N
295	ឪពុក	\N		\N	\N	\N	588	\N
296	បងស្រី	\N		\N	\N	\N	144	\N
296	បងស្រី	\N		\N	\N	\N	364	\N
296	បងស្រី	\N		\N	\N	\N	663	\N
296	បងស្រី	\N		\N	\N	\N	763	\N
297	បងប្អូនស្រី	\N		\N	\N	\N	1033	\N
298	មីង	\N		\N	\N	\N	143	\N
298	មីង	\N		\N	\N	\N	363	\N
299	ស្រោមជើង	\N		\N	\N	\N	1034	\N
300	អាវ	\N		\N	\N	\N	891	\N
300	អាវ	\N		\N	\N	\N	893	\N
300	អាវ	\N		\N	\N	\N	907	\N
300	អាវ	\N		\N	\N	\N	988	\N
300	អាវ	\N		\N	\N	\N	989	\N
300	អាវ	\N		\N	\N	\N	990	\N
300	អាវ	\N		\N	\N	\N	1015	\N
300	អាវ	\N		\N	\N	\N	1038	\N
300	អាវ	\N		\N	\N	\N	1058	\N
300	អាវ	\N		\N	\N	\N	65	\N
300	អាវ	\N		\N	\N	\N	285	\N
300	អាវ	\N		\N	\N	\N	507	\N
300	អាវ	\N		\N	\N	\N	545	\N
300	អាវ	\N		\N	\N	\N	747	\N
300	អាវ	\N		\N	\N	\N	773	\N
301	ដោះ	\N		\N	\N	\N	968	\N
301	ដោះ	\N		\N	\N	\N	976	\N
301	ដោះ	\N		\N	\N	\N	46	\N
301	ដោះ	\N		\N	\N	\N	266	\N
301	ដោះ	\N		\N	\N	\N	604	\N
301	ដោះ	\N		\N	\N	\N	605	\N
301	ដោះ	\N		\N	\N	\N	725	\N
301	ដោះ	\N		\N	\N	\N	727	\N
301	ដោះ	\N		\N	\N	\N	783	\N
302	ពាក់	\N		\N	\N	\N	893	\N
302	ពាក់	\N		\N	\N	\N	988	\N
302	ពាក់	\N		\N	\N	\N	989	\N
302	ពាក់	\N		\N	\N	\N	1015	\N
302	ពាក់	\N		\N	\N	\N	1034	\N
302	ពាក់	\N		\N	\N	\N	1036	\N
302	ពាក់	\N		\N	\N	\N	1038	\N
302	ពាក់	\N		\N	\N	\N	1051	\N
302	ពាក់	\N		\N	\N	\N	1070	\N
302	ពាក់	\N		\N	\N	\N	772	\N
302	ពាក់	\N		\N	\N	\N	773	\N
303	ស្លៀក	\N		\N	\N	\N	987	\N
303	ស្លៀក	\N		\N	\N	\N	1015	\N
303	ស្លៀក	\N		\N	\N	\N	772	\N
304	កន្សែងដៃ	\N		\N	\N	\N	1035	\N
305	ស្បែកជើងផ្ទាត់	\N		\N	\N	\N	1036	\N
306	ឆត្រ	\N		\N	\N	\N	1037	\N
307	កាប៉ៅ	\N		\N	\N	\N	1038	\N
308	កាបូបលុយ	\N		\N	\N	\N	184	\N
308	កាបូបលុយ	\N		\N	\N	\N	185	\N
308	កាបូបលុយ	\N		\N	\N	\N	404	\N
308	កាបូបលុយ	\N		\N	\N	\N	405	\N
309	ខោអាវ	\N		\N	\N	\N	907	\N
309	ខោអាវ	\N		\N	\N	\N	545	\N
309	ខោអាវ	\N		\N	\N	\N	747	\N
310	មាត់	\N		\N	\N	\N	886	\N
310	មាត់	\N		\N	\N	\N	956	\N
310	មាត់	\N		\N	\N	\N	1000	\N
310	មាត់	\N		\N	\N	\N	1039	\N
310	មាត់	\N		\N	\N	\N	1097	\N
310	មាត់	\N		\N	\N	\N	1123	\N
311	ដៃ	\N		\N	\N	\N	889	\N
311	ដៃ	\N		\N	\N	\N	894	\N
311	ដៃ	\N		\N	\N	\N	902	\N
311	ដៃ	\N		\N	\N	\N	916	\N
311	ដៃ	\N		\N	\N	\N	1035	\N
311	ដៃ	\N		\N	\N	\N	1050	\N
311	ដៃ	\N		\N	\N	\N	469	\N
311	ដៃ	\N		\N	\N	\N	539	\N
311	ដៃ	\N		\N	\N	\N	648	\N
311	ដៃ	\N		\N	\N	\N	774	\N
311	ដៃ	\N		\N	\N	\N	775	\N
311	ដៃ	\N		\N	\N	\N	776	\N
312	ខ្លួន	\N		\N	\N	\N	937	\N
312	ខ្លួន	\N		\N	\N	\N	1011	\N
312	ខ្លួន	\N		\N	\N	\N	1085	\N
312	ខ្លួន	\N		\N	\N	\N	82	\N
312	ខ្លួន	\N		\N	\N	\N	302	\N
312	ខ្លួន	\N		\N	\N	\N	484	\N
312	ខ្លួន	\N		\N	\N	\N	667	\N
313	ច្រមុះ	\N		\N	\N	\N	1040	\N
314	ភ្នែក	\N		\N	\N	\N	916	\N
314	ភ្នែក	\N		\N	\N	\N	1098	\N
314	ភ្នែក	\N		\N	\N	\N	45	\N
314	ភ្នែក	\N		\N	\N	\N	265	\N
315	ត្រចៀក	\N		\N	\N	\N	84	\N
315	ត្រចៀក	\N		\N	\N	\N	304	\N
316	ចាន	\N		\N	\N	\N	1104	\N
316	ចាន	\N		\N	\N	\N	623	\N
317	បឺរ	\N		\N	\N	\N	1041	\N
318	ស្ករគ្រាប់	\N		\N	\N	\N	1042	\N
319	បាយថ្ងៃ	\N		\N	\N	\N	1043	\N
319	បាយថ្ងៃ	\N		\N	\N	\N	1044	\N
320	បាយល្ងាច	\N		\N	\N	\N	1044	\N
320	បាយល្ងាច	\N		\N	\N	\N	1047	\N
321	នំ	\N		\N	\N	\N	888	\N
321	នំ	\N		\N	\N	\N	972	\N
321	នំ	\N		\N	\N	\N	977	\N
321	នំ	\N		\N	\N	\N	992	\N
321	នំ	\N		\N	\N	\N	996	\N
321	នំ	\N		\N	\N	\N	1013	\N
321	នំ	\N		\N	\N	\N	1100	\N
321	នំ	\N		\N	\N	\N	1116	\N
321	នំ	\N		\N	\N	\N	1119	\N
321	នំ	\N		\N	\N	\N	105	\N
321	នំ	\N		\N	\N	\N	106	\N
321	នំ	\N		\N	\N	\N	118	\N
321	នំ	\N		\N	\N	\N	159	\N
321	នំ	\N		\N	\N	\N	325	\N
321	នំ	\N		\N	\N	\N	326	\N
321	នំ	\N		\N	\N	\N	338	\N
321	នំ	\N		\N	\N	\N	379	\N
321	នំ	\N		\N	\N	\N	491	\N
321	នំ	\N		\N	\N	\N	492	\N
321	នំ	\N		\N	\N	\N	493	\N
322	ពងមាន់	\N		\N	\N	\N	623	\N
323	បាយព្រឹក	\N		\N	\N	\N	545	\N
324	បាយ	\N		\N	\N	\N	963	\N
324	បាយ	\N		\N	\N	\N	969	\N
324	បាយ	\N		\N	\N	\N	970	\N
324	បាយ	\N		\N	\N	\N	974	\N
324	បាយ	\N		\N	\N	\N	975	\N
324	បាយ	\N		\N	\N	\N	993	\N
324	បាយ	\N		\N	\N	\N	1043	\N
324	បាយ	\N		\N	\N	\N	1044	\N
324	បាយ	\N		\N	\N	\N	1047	\N
324	បាយ	\N		\N	\N	\N	1082	\N
324	បាយ	\N		\N	\N	\N	1098	\N
324	បាយ	\N		\N	\N	\N	178	\N
324	បាយ	\N		\N	\N	\N	398	\N
324	បាយ	\N		\N	\N	\N	445	\N
324	បាយ	\N		\N	\N	\N	476	\N
324	បាយ	\N		\N	\N	\N	500	\N
324	បាយ	\N		\N	\N	\N	503	\N
324	បាយ	\N		\N	\N	\N	505	\N
324	បាយ	\N		\N	\N	\N	545	\N
324	បាយ	\N		\N	\N	\N	551	\N
324	បាយ	\N		\N	\N	\N	569	\N
324	បាយ	\N		\N	\N	\N	625	\N
324	បាយ	\N		\N	\N	\N	641	\N
324	បាយ	\N		\N	\N	\N	737	\N
324	បាយ	\N		\N	\N	\N	780	\N
325	ទឹកស៊ីអ៊ីវ	\N		\N	\N	\N	1045	\N
326	អំបិល	\N		\N	\N	\N	1046	\N
326	អំបិល	\N		\N	\N	\N	1048	\N
327	ថែម	\N		\N	\N	\N	968	\N
327	ថែម	\N		\N	\N	\N	1048	\N
328	កាមេរ៉ា	\N		\N	\N	\N	1049	\N
329	ខ្មៅដៃ	\N		\N	\N	\N	1050	\N
330	លុប	\N		\N	\N	\N	1057	\N
330	លុប	\N		\N	\N	\N	545	\N
331	វ៉ែនតា	\N		\N	\N	\N	1051	\N
333	នាឡិកា	\N		\N	\N	\N	1053	\N
334	កុំព្យូទ័រ	\N		\N	\N	\N	567	\N
334	កុំព្យូទ័រ	\N		\N	\N	\N	574	\N
334	កុំព្យូទ័រ	\N		\N	\N	\N	614	\N
335	ហ្វីលម៍	\N		\N	\N	\N	1054	\N
336	ស្ទីឡូ	\N		\N	\N	\N	1058	\N
337	ប៊ិក	\N		\N	\N	\N	1059	\N
338	ខែសីហា	\N		\N	\N	\N	1060	\N
339	ខែមេសា	\N		\N	\N	\N	1061	\N
340	ខែនេះ	\N		\N	\N	\N	1062	\N
341	រាល់ខែ	\N		\N	\N	\N	1063	\N
342	ខែធ្នូ	\N		\N	\N	\N	1064	\N
343	ខែកុម្ភៈ	\N		\N	\N	\N	1065	\N
344	ខែមករា	\N		\N	\N	\N	1066	\N
345	ខែកក្កដា	\N		\N	\N	\N	1067	\N
346	ខែមិថុនា	\N		\N	\N	\N	1068	\N
347	ខែក្រោយ	\N		\N	\N	\N	528	\N
347	ខែក្រោយ	\N		\N	\N	\N	529	\N
348	ខែឧសភា	\N		\N	\N	\N	872	\N
348	ខែឧសភា	\N		\N	\N	\N	1069	\N
349	ខែមីនា	\N		\N	\N	\N	1070	\N
350	ខែមុន	\N		\N	\N	\N	1071	\N
351	ខែវិច្ឆិកា	\N		\N	\N	\N	1072	\N
352	ខែតុលា	\N		\N	\N	\N	202	\N
352	ខែតុលា	\N		\N	\N	\N	422	\N
353	ខែកញ្ញា	\N		\N	\N	\N	887	\N
353	ខែកញ្ញា	\N		\N	\N	\N	1073	\N
354	មួយខែ	\N		\N	\N	\N	1039	\N
354	មួយខែ	\N		\N	\N	\N	529	\N
355	អាទិត្យនេះ	\N		\N	\N	\N	1074	\N
356	រាល់អាទិត្យ	\N		\N	\N	\N	1075	\N
357	ថ្ងៃអាទិត្យ	\N		\N	\N	\N	895	\N
357	ថ្ងៃអាទិត្យ	\N		\N	\N	\N	907	\N
357	ថ្ងៃអាទិត្យ	\N		\N	\N	\N	1076	\N
358	ថ្ងៃព្រហស្បតិ៍	\N		\N	\N	\N	1077	\N
359	អាទិត្យក្រោយ	\N		\N	\N	\N	635	\N
360	ថ្ងៃចន្ទ	\N		\N	\N	\N	895	\N
360	ថ្ងៃចន្ទ	\N		\N	\N	\N	1078	\N
361	ថ្ងៃអង្គារ	\N		\N	\N	\N	1079	\N
362	ថ្ងៃពុធ	\N		\N	\N	\N	1080	\N
363	ថ្ងៃសៅរ៍	\N		\N	\N	\N	886	\N
363	ថ្ងៃសៅរ៍	\N		\N	\N	\N	202	\N
363	ថ្ងៃសៅរ៍	\N		\N	\N	\N	422	\N
364	អាទិត្យ	\N		\N	\N	\N	895	\N
364	អាទិត្យ	\N		\N	\N	\N	907	\N
364	អាទិត្យ	\N		\N	\N	\N	1074	\N
364	អាទិត្យ	\N		\N	\N	\N	1075	\N
364	អាទិត្យ	\N		\N	\N	\N	1076	\N
364	អាទិត្យ	\N		\N	\N	\N	1081	\N
364	អាទិត្យ	\N		\N	\N	\N	1100	\N
364	អាទិត្យ	\N		\N	\N	\N	635	\N
364	អាទិត្យ	\N		\N	\N	\N	639	\N
365	អាទិត្យមុន	\N		\N	\N	\N	1081	\N
366	ថ្ងៃសុក្រ	\N		\N	\N	\N	1082	\N
367	ឆ្នាំ	\N		\N	\N	\N	935	\N
367	ឆ្នាំ	\N		\N	\N	\N	1061	\N
367	ឆ្នាំ	\N		\N	\N	\N	1084	\N
367	ឆ្នាំ	\N		\N	\N	\N	1085	\N
367	ឆ្នាំ	\N		\N	\N	\N	1087	\N
367	ឆ្នាំ	\N		\N	\N	\N	1088	\N
367	ឆ្នាំ	\N		\N	\N	\N	1089	\N
367	ឆ្នាំ	\N		\N	\N	\N	1091	\N
367	ឆ្នាំ	\N		\N	\N	\N	1092	\N
367	ឆ្នាំ	\N		\N	\N	\N	148	\N
367	ឆ្នាំ	\N		\N	\N	\N	202	\N
367	ឆ្នាំ	\N		\N	\N	\N	368	\N
367	ឆ្នាំ	\N		\N	\N	\N	422	\N
367	ឆ្នាំ	\N		\N	\N	\N	444	\N
368	រដូវលំហើយ	\N		\N	\N	\N	1083	\N
369	ឆ្នាំនេះ	\N		\N	\N	\N	1084	\N
369	ឆ្នាំនេះ	\N		\N	\N	\N	1087	\N
370	រាល់ឆ្នាំ	\N		\N	\N	\N	1085	\N
371	រដូវក្ដៅ	\N		\N	\N	\N	1086	\N
373	ឆ្នាំមុន	\N		\N	\N	\N	1088	\N
374	ឆ្នាំក្រោយ	\N		\N	\N	\N	1089	\N
374	ឆ្នាំក្រោយ	\N		\N	\N	\N	1091	\N
375	រដូវផ្ការីក	\N		\N	\N	\N	1090	\N
376	ពីរឆ្នាំក្រោយ	\N		\N	\N	\N	1091	\N
377	ឆ្នាំទៅមួយ	\N		\N	\N	\N	1092	\N
378	ពេលល្ងាច	\N		\N	\N	\N	1093	\N
378	ពេលល្ងាច	\N		\N	\N	\N	1100	\N
379	ថ្ងៃនេះ	\N		\N	\N	\N	940	\N
379	ថ្ងៃនេះ	\N		\N	\N	\N	1024	\N
379	ថ្ងៃនេះ	\N		\N	\N	\N	1101	\N
379	ថ្ងៃនេះ	\N		\N	\N	\N	167	\N
379	ថ្ងៃនេះ	\N		\N	\N	\N	387	\N
380	ថ្ងៃស្អែក	\N		\N	\N	\N	1094	\N
380	ថ្ងៃស្អែក	\N		\N	\N	\N	1101	\N
381	ម៉ោង	\N		\N	\N	\N	914	\N
381	ម៉ោង	\N		\N	\N	\N	1053	\N
381	ម៉ោង	\N		\N	\N	\N	1093	\N
381	ម៉ោង	\N		\N	\N	\N	1096	\N
381	ម៉ោង	\N		\N	\N	\N	1099	\N
381	ម៉ោង	\N		\N	\N	\N	1102	\N
381	ម៉ោង	\N		\N	\N	\N	1103	\N
381	ម៉ោង	\N		\N	\N	\N	1138	\N
381	ម៉ោង	\N		\N	\N	\N	203	\N
381	ម៉ោង	\N		\N	\N	\N	206	\N
381	ម៉ោង	\N		\N	\N	\N	423	\N
381	ម៉ោង	\N		\N	\N	\N	426	\N
381	ម៉ោង	\N		\N	\N	\N	482	\N
381	ម៉ោង	\N		\N	\N	\N	542	\N
381	ម៉ោង	\N		\N	\N	\N	543	\N
381	ម៉ោង	\N		\N	\N	\N	548	\N
381	ម៉ោង	\N		\N	\N	\N	549	\N
381	ម៉ោង	\N		\N	\N	\N	627	\N
381	ម៉ោង	\N		\N	\N	\N	765	\N
381	ម៉ោង	\N		\N	\N	\N	766	\N
381	ម៉ោង	\N		\N	\N	\N	791	\N
381	ម៉ោង	\N		\N	\N	\N	792	\N
382	ម្សិលមិញ	\N		\N	\N	\N	35	\N
382	ម្សិលមិញ	\N		\N	\N	\N	80	\N
382	ម្សិលមិញ	\N		\N	\N	\N	168	\N
382	ម្សិលមិញ	\N		\N	\N	\N	255	\N
382	ម្សិលមិញ	\N		\N	\N	\N	300	\N
382	ម្សិលមិញ	\N		\N	\N	\N	388	\N
382	ម្សិលមិញ	\N		\N	\N	\N	443	\N
382	ម្សិលមិញ	\N		\N	\N	\N	534	\N
382	ម្សិលមិញ	\N		\N	\N	\N	665	\N
383	យប់មិញ	\N		\N	\N	\N	1095	\N
384	ពេលព្រឹក	\N		\N	\N	\N	967	\N
384	ពេលព្រឹក	\N		\N	\N	\N	1096	\N
384	ពេលព្រឹក	\N		\N	\N	\N	1097	\N
385	ពេលថ្ងៃ	\N		\N	\N	\N	1098	\N
386	ពេលយប់	\N		\N	\N	\N	1099	\N
387	ខានស្អែក	\N		\N	\N	\N	1101	\N
388	ម្សិលម៉្ងៃ	\N		\N	\N	\N	669	\N
389	ហើយ	\N		\N	\N	\N	867	\N
389	ហើយ	\N		\N	\N	\N	873	\N
389	ហើយ	\N		\N	\N	\N	909	\N
389	ហើយ	\N		\N	\N	\N	960	\N
389	ហើយ	\N		\N	\N	\N	968	\N
389	ហើយ	\N		\N	\N	\N	988	\N
389	ហើយ	\N		\N	\N	\N	1022	\N
389	ហើយ	\N		\N	\N	\N	1026	\N
389	ហើយ	\N		\N	\N	\N	1031	\N
389	ហើយ	\N		\N	\N	\N	1043	\N
389	ហើយ	\N		\N	\N	\N	1072	\N
389	ហើយ	\N		\N	\N	\N	1083	\N
389	ហើយ	\N		\N	\N	\N	1092	\N
389	ហើយ	\N		\N	\N	\N	1098	\N
389	ហើយ	\N		\N	\N	\N	1105	\N
389	ហើយ	\N		\N	\N	\N	1107	\N
389	ហើយ	\N		\N	\N	\N	1137	\N
389	ហើយ	\N		\N	\N	\N	169	\N
389	ហើយ	\N		\N	\N	\N	170	\N
389	ហើយ	\N		\N	\N	\N	389	\N
389	ហើយ	\N		\N	\N	\N	390	\N
389	ហើយ	\N		\N	\N	\N	447	\N
389	ហើយ	\N		\N	\N	\N	460	\N
389	ហើយ	\N		\N	\N	\N	461	\N
389	ហើយ	\N		\N	\N	\N	514	\N
389	ហើយ	\N		\N	\N	\N	525	\N
389	ហើយ	\N		\N	\N	\N	538	\N
389	ហើយ	\N		\N	\N	\N	545	\N
389	ហើយ	\N		\N	\N	\N	563	\N
389	ហើយ	\N		\N	\N	\N	564	\N
389	ហើយ	\N		\N	\N	\N	565	\N
389	ហើយ	\N		\N	\N	\N	579	\N
389	ហើយ	\N		\N	\N	\N	590	\N
389	ហើយ	\N		\N	\N	\N	608	\N
389	ហើយ	\N		\N	\N	\N	622	\N
389	ហើយ	\N		\N	\N	\N	623	\N
389	ហើយ	\N		\N	\N	\N	624	\N
389	ហើយ	\N		\N	\N	\N	625	\N
389	ហើយ	\N		\N	\N	\N	633	\N
389	ហើយ	\N		\N	\N	\N	634	\N
389	ហើយ	\N		\N	\N	\N	635	\N
389	ហើយ	\N		\N	\N	\N	668	\N
389	ហើយ	\N		\N	\N	\N	679	\N
389	ហើយ	\N		\N	\N	\N	680	\N
389	ហើយ	\N		\N	\N	\N	689	\N
389	ហើយ	\N		\N	\N	\N	692	\N
389	ហើយ	\N		\N	\N	\N	695	\N
389	ហើយ	\N		\N	\N	\N	699	\N
389	ហើយ	\N		\N	\N	\N	727	\N
389	ហើយ	\N		\N	\N	\N	728	\N
389	ហើយ	\N		\N	\N	\N	738	\N
389	ហើយ	\N		\N	\N	\N	768	\N
389	ហើយ	\N		\N	\N	\N	773	\N
389	ហើយ	\N		\N	\N	\N	775	\N
389	ហើយ	\N		\N	\N	\N	790	\N
390	ផង	\N		\N	\N	\N	876	\N
390	ផង	\N		\N	\N	\N	1108	\N
390	ផង	\N		\N	\N	\N	212	\N
390	ផង	\N		\N	\N	\N	432	\N
390	ផង	\N		\N	\N	\N	446	\N
390	ផង	\N		\N	\N	\N	471	\N
390	ផង	\N		\N	\N	\N	501	\N
390	ផង	\N		\N	\N	\N	611	\N
390	ផង	\N		\N	\N	\N	619	\N
390	ផង	\N		\N	\N	\N	678	\N
390	ផង	\N		\N	\N	\N	679	\N
390	ផង	\N		\N	\N	\N	720	\N
390	ផង	\N		\N	\N	\N	727	\N
390	ផង	\N		\N	\N	\N	800	\N
391	នៅ	\N		\N	\N	\N	869	\N
391	នៅ	\N		\N	\N	\N	871	\N
391	នៅ	\N		\N	\N	\N	872	\N
391	នៅ	\N		\N	\N	\N	888	\N
391	នៅ	\N		\N	\N	\N	919	\N
391	នៅ	\N		\N	\N	\N	923	\N
391	នៅ	\N		\N	\N	\N	924	\N
391	នៅ	\N		\N	\N	\N	927	\N
391	នៅ	\N		\N	\N	\N	938	\N
391	នៅ	\N		\N	\N	\N	942	\N
391	នៅ	\N		\N	\N	\N	944	\N
391	នៅ	\N		\N	\N	\N	947	\N
391	នៅ	\N		\N	\N	\N	968	\N
391	នៅ	\N		\N	\N	\N	980	\N
391	នៅ	\N		\N	\N	\N	981	\N
391	នៅ	\N		\N	\N	\N	988	\N
391	នៅ	\N		\N	\N	\N	991	\N
391	នៅ	\N		\N	\N	\N	993	\N
391	នៅ	\N		\N	\N	\N	995	\N
391	នៅ	\N		\N	\N	\N	1000	\N
391	នៅ	\N		\N	\N	\N	1011	\N
391	នៅ	\N		\N	\N	\N	1013	\N
391	នៅ	\N		\N	\N	\N	1015	\N
391	នៅ	\N		\N	\N	\N	1030	\N
391	នៅ	\N		\N	\N	\N	1034	\N
391	នៅ	\N		\N	\N	\N	1046	\N
391	នៅ	\N		\N	\N	\N	1049	\N
391	នៅ	\N		\N	\N	\N	1061	\N
391	នៅ	\N		\N	\N	\N	1063	\N
391	នៅ	\N		\N	\N	\N	1068	\N
391	នៅ	\N		\N	\N	\N	1070	\N
391	នៅ	\N		\N	\N	\N	1083	\N
391	នៅ	\N		\N	\N	\N	1086	\N
391	នៅ	\N		\N	\N	\N	1097	\N
391	នៅ	\N		\N	\N	\N	1103	\N
391	នៅ	\N		\N	\N	\N	1133	\N
391	នៅ	\N		\N	\N	\N	1138	\N
391	នៅ	\N		\N	\N	\N	10	\N
391	នៅ	\N		\N	\N	\N	34	\N
391	នៅ	\N		\N	\N	\N	112	\N
391	នៅ	\N		\N	\N	\N	163	\N
391	នៅ	\N		\N	\N	\N	164	\N
391	នៅ	\N		\N	\N	\N	165	\N
391	នៅ	\N		\N	\N	\N	166	\N
391	នៅ	\N		\N	\N	\N	170	\N
391	នៅ	\N		\N	\N	\N	230	\N
391	នៅ	\N		\N	\N	\N	254	\N
391	នៅ	\N		\N	\N	\N	332	\N
391	នៅ	\N		\N	\N	\N	383	\N
391	នៅ	\N		\N	\N	\N	384	\N
391	នៅ	\N		\N	\N	\N	385	\N
391	នៅ	\N		\N	\N	\N	386	\N
391	នៅ	\N		\N	\N	\N	390	\N
391	នៅ	\N		\N	\N	\N	444	\N
391	នៅ	\N		\N	\N	\N	462	\N
391	នៅ	\N		\N	\N	\N	520	\N
391	នៅ	\N		\N	\N	\N	576	\N
391	នៅ	\N		\N	\N	\N	578	\N
391	នៅ	\N		\N	\N	\N	580	\N
391	នៅ	\N		\N	\N	\N	583	\N
391	នៅ	\N		\N	\N	\N	584	\N
391	នៅ	\N		\N	\N	\N	641	\N
391	នៅ	\N		\N	\N	\N	644	\N
391	នៅ	\N		\N	\N	\N	646	\N
391	នៅ	\N		\N	\N	\N	688	\N
391	នៅ	\N		\N	\N	\N	712	\N
391	នៅ	\N		\N	\N	\N	750	\N
391	នៅ	\N		\N	\N	\N	755	\N
391	នៅ	\N		\N	\N	\N	775	\N
391	នៅ	\N		\N	\N	\N	788	\N
391	នៅ	\N		\N	\N	\N	790	\N
391	នៅ	\N		\N	\N	\N	794	\N
392	ពេញ	\N		\N	\N	\N	888	\N
392	ពេញ	\N		\N	\N	\N	899	\N
392	ពេញ	\N		\N	\N	\N	989	\N
392	ពេញ	\N		\N	\N	\N	992	\N
392	ពេញ	\N		\N	\N	\N	996	\N
392	ពេញ	\N		\N	\N	\N	1055	\N
392	ពេញ	\N		\N	\N	\N	1064	\N
392	ពេញ	\N		\N	\N	\N	451	\N
392	ពេញ	\N		\N	\N	\N	453	\N
392	ពេញ	\N		\N	\N	\N	554	\N
392	ពេញ	\N		\N	\N	\N	617	\N
392	ពេញ	\N		\N	\N	\N	618	\N
392	ពេញ	\N		\N	\N	\N	677	\N
392	ពេញ	\N		\N	\N	\N	678	\N
392	ពេញ	\N		\N	\N	\N	679	\N
392	ពេញ	\N		\N	\N	\N	789	\N
393	ពេល	\N		\N	\N	\N	876	\N
393	ពេល	\N		\N	\N	\N	943	\N
393	ពេល	\N		\N	\N	\N	967	\N
393	ពេល	\N		\N	\N	\N	1016	\N
393	ពេល	\N		\N	\N	\N	1093	\N
393	ពេល	\N		\N	\N	\N	1096	\N
393	ពេល	\N		\N	\N	\N	1097	\N
393	ពេល	\N		\N	\N	\N	1098	\N
393	ពេល	\N		\N	\N	\N	1099	\N
393	ពេល	\N		\N	\N	\N	1100	\N
393	ពេល	\N		\N	\N	\N	1102	\N
393	ពេល	\N		\N	\N	\N	1103	\N
393	ពេល	\N		\N	\N	\N	122	\N
393	ពេល	\N		\N	\N	\N	138	\N
393	ពេល	\N		\N	\N	\N	139	\N
393	ពេល	\N		\N	\N	\N	342	\N
393	ពេល	\N		\N	\N	\N	358	\N
393	ពេល	\N		\N	\N	\N	359	\N
393	ពេល	\N		\N	\N	\N	471	\N
393	ពេល	\N		\N	\N	\N	477	\N
393	ពេល	\N		\N	\N	\N	482	\N
393	ពេល	\N		\N	\N	\N	497	\N
393	ពេល	\N		\N	\N	\N	572	\N
393	ពេល	\N		\N	\N	\N	639	\N
393	ពេល	\N		\N	\N	\N	646	\N
393	ពេល	\N		\N	\N	\N	713	\N
393	ពេល	\N		\N	\N	\N	725	\N
393	ពេល	\N		\N	\N	\N	727	\N
393	ពេល	\N		\N	\N	\N	737	\N
394	ពេលណា	\N		\N	\N	\N	122	\N
394	ពេលណា	\N		\N	\N	\N	138	\N
394	ពេលណា	\N		\N	\N	\N	139	\N
394	ពេលណា	\N		\N	\N	\N	342	\N
394	ពេលណា	\N		\N	\N	\N	358	\N
394	ពេលណា	\N		\N	\N	\N	359	\N
395	ពេលខ្លះ	\N		\N	\N	\N	1102	\N
396	ឧស្សាហ៍	\N		\N	\N	\N	800	\N
397	ជិតដល់	\N		\N	\N	\N	1103	\N
398	ចានគោះបារី	\N		\N	\N	\N	1104	\N
399	ចម្រៀង	\N		\N	\N	\N	1105	\N
399	ចម្រៀង	\N		\N	\N	\N	98	\N
399	ចម្រៀង	\N		\N	\N	\N	99	\N
399	ចម្រៀង	\N		\N	\N	\N	318	\N
399	ចម្រៀង	\N		\N	\N	\N	319	\N
400	ច្រៀង	\N		\N	\N	\N	877	\N
400	ច្រៀង	\N		\N	\N	\N	1107	\N
400	ច្រៀង	\N		\N	\N	\N	655	\N
400	ច្រៀង	\N		\N	\N	\N	656	\N
401	បារី	\N		\N	\N	\N	1104	\N
401	បារី	\N		\N	\N	\N	155	\N
401	បារី	\N		\N	\N	\N	375	\N
402	កុន	\N		\N	\N	\N	659	\N
404	ហ្គីតា	\N		\N	\N	\N	1106	\N
405	ដេញ	\N		\N	\N	\N	1106	\N
405	ដេញ	\N		\N	\N	\N	1107	\N
406	ភ្លេង	\N		\N	\N	\N	1108	\N
407	គំនូរ	\N		\N	\N	\N	1109	\N
408	រូបថត	\N		\N	\N	\N	1110	\N
409	សំឡេង	\N		\N	\N	\N	1111	\N
410	មេឃស្រឡះ	\N		\N	\N	\N	1018	\N
410	មេឃស្រឡះ	\N		\N	\N	\N	1112	\N
410	មេឃស្រឡះ	\N		\N	\N	\N	1113	\N
411	ក្ដៅ	\N		\N	\N	\N	998	\N
411	ក្ដៅ	\N		\N	\N	\N	1015	\N
411	ក្ដៅ	\N		\N	\N	\N	1086	\N
411	ក្ដៅ	\N		\N	\N	\N	1087	\N
411	ក្ដៅ	\N		\N	\N	\N	1117	\N
411	ក្ដៅ	\N		\N	\N	\N	1120	\N
411	ក្ដៅ	\N		\N	\N	\N	82	\N
411	ក្ដៅ	\N		\N	\N	\N	302	\N
412	ស្រឡះ	\N		\N	\N	\N	1018	\N
412	ស្រឡះ	\N		\N	\N	\N	1112	\N
412	ស្រឡះ	\N		\N	\N	\N	1113	\N
413	ត្រជាក់	\N		\N	\N	\N	989	\N
413	ត្រជាក់	\N		\N	\N	\N	1066	\N
413	ត្រជាក់	\N		\N	\N	\N	1114	\N
413	ត្រជាក់	\N		\N	\N	\N	1119	\N
414	រងារ	\N		\N	\N	\N	937	\N
414	រងារ	\N		\N	\N	\N	988	\N
414	រងារ	\N		\N	\N	\N	1063	\N
414	រងារ	\N		\N	\N	\N	1126	\N
414	រងារ	\N		\N	\N	\N	446	\N
414	រងារ	\N		\N	\N	\N	457	\N
414	រងារ	\N		\N	\N	\N	469	\N
414	រងារ	\N		\N	\N	\N	612	\N
414	រងារ	\N		\N	\N	\N	614	\N
414	រងារ	\N		\N	\N	\N	617	\N
414	រងារ	\N		\N	\N	\N	715	\N
414	រងារ	\N		\N	\N	\N	716	\N
414	រងារ	\N		\N	\N	\N	718	\N
414	រងារ	\N		\N	\N	\N	719	\N
414	រងារ	\N		\N	\N	\N	721	\N
414	រងារ	\N		\N	\N	\N	753	\N
414	រងារ	\N		\N	\N	\N	756	\N
414	រងារ	\N		\N	\N	\N	800	\N
415	ព្រឹល	\N		\N	\N	\N	1115	\N
416	ភ្លៀង	\N		\N	\N	\N	1021	\N
416	ភ្លៀង	\N		\N	\N	\N	1037	\N
416	ភ្លៀង	\N		\N	\N	\N	1068	\N
416	ភ្លៀង	\N		\N	\N	\N	1113	\N
416	ភ្លៀង	\N		\N	\N	\N	1118	\N
416	ភ្លៀង	\N		\N	\N	\N	644	\N
416	ភ្លៀង	\N		\N	\N	\N	646	\N
416	ភ្លៀង	\N		\N	\N	\N	669	\N
416	ភ្លៀង	\N		\N	\N	\N	670	\N
416	ភ្លៀង	\N		\N	\N	\N	672	\N
416	ភ្លៀង	\N		\N	\N	\N	673	\N
417	ទឹកភ្លៀង	\N		\N	\N	\N	669	\N
417	ទឹកភ្លៀង	\N		\N	\N	\N	670	\N
418	អាកាសធាតុ	\N		\N	\N	\N	1066	\N
418	អាកាសធាតុ	\N		\N	\N	\N	1116	\N
419	ក្ដៅស្រួល	\N		\N	\N	\N	1117	\N
420	ខ្យល់	\N		\N	\N	\N	1037	\N
420	ខ្យល់	\N		\N	\N	\N	1072	\N
420	ខ្យល់	\N		\N	\N	\N	1139	\N
420	ខ្យល់	\N		\N	\N	\N	671	\N
420	ខ្យល់	\N		\N	\N	\N	672	\N
423	អក្សរចិន	\N		\N	\N	\N	945	\N
423	អក្សរចិន	\N		\N	\N	\N	1121	\N
424	ថា	\N		\N	\N	\N	869	\N
424	ថា	\N		\N	\N	\N	875	\N
424	ថា	\N		\N	\N	\N	923	\N
424	ថា	\N		\N	\N	\N	957	\N
424	ថា	\N		\N	\N	\N	975	\N
424	ថា	\N		\N	\N	\N	1020	\N
424	ថា	\N		\N	\N	\N	1094	\N
424	ថា	\N		\N	\N	\N	1105	\N
424	ថា	\N		\N	\N	\N	1133	\N
424	ថា	\N		\N	\N	\N	1140	\N
424	ថា	\N		\N	\N	\N	186	\N
424	ថា	\N		\N	\N	\N	209	\N
424	ថា	\N		\N	\N	\N	851	\N
424	ថា	\N		\N	\N	\N	406	\N
424	ថា	\N		\N	\N	\N	429	\N
424	ថា	\N		\N	\N	\N	460	\N
424	ថា	\N		\N	\N	\N	464	\N
424	ថា	\N		\N	\N	\N	482	\N
424	ថា	\N		\N	\N	\N	526	\N
424	ថា	\N		\N	\N	\N	532	\N
424	ថា	\N		\N	\N	\N	534	\N
424	ថា	\N		\N	\N	\N	578	\N
424	ថា	\N		\N	\N	\N	580	\N
424	ថា	\N		\N	\N	\N	591	\N
424	ថា	\N		\N	\N	\N	593	\N
424	ថា	\N		\N	\N	\N	595	\N
424	ថា	\N		\N	\N	\N	612	\N
424	ថា	\N		\N	\N	\N	635	\N
424	ថា	\N		\N	\N	\N	673	\N
424	ថា	\N		\N	\N	\N	686	\N
424	ថា	\N		\N	\N	\N	702	\N
424	ថា	\N		\N	\N	\N	733	\N
424	ថា	\N		\N	\N	\N	734	\N
424	ថា	\N		\N	\N	\N	735	\N
424	ថា	\N		\N	\N	\N	801	\N
425	សរសេរ	\N		\N	\N	\N	939	\N
425	សរសេរ	\N		\N	\N	\N	945	\N
425	សរសេរ	\N		\N	\N	\N	982	\N
425	សរសេរ	\N		\N	\N	\N	1050	\N
425	សរសេរ	\N		\N	\N	\N	197	\N
425	សរសេរ	\N		\N	\N	\N	198	\N
425	សរសេរ	\N		\N	\N	\N	417	\N
425	សរសេរ	\N		\N	\N	\N	418	\N
425	សរសេរ	\N		\N	\N	\N	572	\N
426	រឿង	\N		\N	\N	\N	1095	\N
426	រឿង	\N		\N	\N	\N	1123	\N
426	រឿង	\N		\N	\N	\N	1131	\N
426	រឿង	\N		\N	\N	\N	34	\N
426	រឿង	\N		\N	\N	\N	254	\N
426	រឿង	\N		\N	\N	\N	451	\N
426	រឿង	\N		\N	\N	\N	452	\N
426	រឿង	\N		\N	\N	\N	656	\N
426	រឿង	\N		\N	\N	\N	660	\N
426	រឿង	\N		\N	\N	\N	661	\N
426	រឿង	\N		\N	\N	\N	710	\N
426	រឿង	\N		\N	\N	\N	712	\N
426	រឿង	\N		\N	\N	\N	750	\N
427	ពាក្យ	\N		\N	\N	\N	897	\N
427	ពាក្យ	\N		\N	\N	\N	931	\N
427	ពាក្យ	\N		\N	\N	\N	1122	\N
427	ពាក្យ	\N		\N	\N	\N	464	\N
427	ពាក្យ	\N		\N	\N	\N	517	\N
427	ពាក្យ	\N		\N	\N	\N	685	\N
428	ភាសា	\N		\N	\N	\N	866	\N
428	ភាសា	\N		\N	\N	\N	870	\N
428	ភាសា	\N		\N	\N	\N	934	\N
428	ភាសា	\N		\N	\N	\N	936	\N
428	ភាសា	\N		\N	\N	\N	5	\N
428	ភាសា	\N		\N	\N	\N	28	\N
428	ភាសា	\N		\N	\N	\N	44	\N
428	ភាសា	\N		\N	\N	\N	175	\N
428	ភាសា	\N		\N	\N	\N	177	\N
428	ភាសា	\N		\N	\N	\N	194	\N
428	ភាសា	\N		\N	\N	\N	196	\N
428	ភាសា	\N		\N	\N	\N	845	\N
428	ភាសា	\N		\N	\N	\N	225	\N
428	ភាសា	\N		\N	\N	\N	248	\N
428	ភាសា	\N		\N	\N	\N	264	\N
428	ភាសា	\N		\N	\N	\N	395	\N
428	ភាសា	\N		\N	\N	\N	397	\N
428	ភាសា	\N		\N	\N	\N	414	\N
428	ភាសា	\N		\N	\N	\N	416	\N
428	ភាសា	\N		\N	\N	\N	447	\N
428	ភាសា	\N		\N	\N	\N	578	\N
428	ភាសា	\N		\N	\N	\N	582	\N
429	និយាយ	\N		\N	\N	\N	866	\N
429	និយាយ	\N		\N	\N	\N	936	\N
429	និយាយ	\N		\N	\N	\N	979	\N
429	និយាយ	\N		\N	\N	\N	1040	\N
429	និយាយ	\N		\N	\N	\N	183	\N
429	និយាយ	\N		\N	\N	\N	186	\N
429	និយាយ	\N		\N	\N	\N	194	\N
429	និយាយ	\N		\N	\N	\N	403	\N
429	និយាយ	\N		\N	\N	\N	406	\N
429	និយាយ	\N		\N	\N	\N	414	\N
429	និយាយ	\N		\N	\N	\N	500	\N
429	និយាយ	\N		\N	\N	\N	525	\N
429	និយាយ	\N		\N	\N	\N	578	\N
430	អត្ថបទ	\N		\N	\N	\N	1122	\N
431	និទាន	\N		\N	\N	\N	1123	\N
432	ន័យ	\N		\N	\N	\N	943	\N
432	ន័យ	\N		\N	\N	\N	591	\N
432	ន័យ	\N		\N	\N	\N	685	\N
432	ន័យ	\N		\N	\N	\N	686	\N
433	មនុស្សពេញវ័យ	\N		\N	\N	\N	554	\N
434	ហ្វូង	\N		\N	\N	\N	1124	\N
435	ប្ដីប្រពន្ធ	\N		\N	\N	\N	1125	\N
436	កូន	\N		\N	\N	\N	1031	\N
436	កូន	\N		\N	\N	\N	1032	\N
436	កូន	\N		\N	\N	\N	1034	\N
436	កូន	\N		\N	\N	\N	1060	\N
436	កូន	\N		\N	\N	\N	1135	\N
436	កូន	\N		\N	\N	\N	141	\N
436	កូន	\N		\N	\N	\N	145	\N
436	កូន	\N		\N	\N	\N	178	\N
436	កូន	\N		\N	\N	\N	181	\N
436	កូន	\N		\N	\N	\N	219	\N
436	កូន	\N		\N	\N	\N	361	\N
436	កូន	\N		\N	\N	\N	365	\N
436	កូន	\N		\N	\N	\N	398	\N
436	កូន	\N		\N	\N	\N	401	\N
436	កូន	\N		\N	\N	\N	439	\N
436	កូន	\N		\N	\N	\N	545	\N
436	កូន	\N		\N	\N	\N	589	\N
436	កូន	\N		\N	\N	\N	600	\N
436	កូន	\N		\N	\N	\N	661	\N
437	ស្រី	\N		\N	\N	\N	880	\N
437	ស្រី	\N		\N	\N	\N	1033	\N
437	ស្រី	\N		\N	\N	\N	76	\N
437	ស្រី	\N		\N	\N	\N	140	\N
437	ស្រី	\N		\N	\N	\N	143	\N
437	ស្រី	\N		\N	\N	\N	144	\N
437	ស្រី	\N		\N	\N	\N	145	\N
437	ស្រី	\N		\N	\N	\N	200	\N
437	ស្រី	\N		\N	\N	\N	296	\N
437	ស្រី	\N		\N	\N	\N	360	\N
437	ស្រី	\N		\N	\N	\N	363	\N
437	ស្រី	\N		\N	\N	\N	364	\N
437	ស្រី	\N		\N	\N	\N	365	\N
437	ស្រី	\N		\N	\N	\N	420	\N
437	ស្រី	\N		\N	\N	\N	558	\N
437	ស្រី	\N		\N	\N	\N	589	\N
437	ស្រី	\N		\N	\N	\N	663	\N
437	ស្រី	\N		\N	\N	\N	710	\N
437	ស្រី	\N		\N	\N	\N	763	\N
437	ស្រី	\N		\N	\N	\N	831	\N
438	កូនប្រុស	\N		\N	\N	\N	145	\N
438	កូនប្រុស	\N		\N	\N	\N	365	\N
439	មនុស្ស	\N		\N	\N	\N	886	\N
439	មនុស្ស	\N		\N	\N	\N	919	\N
439	មនុស្ស	\N		\N	\N	\N	955	\N
439	មនុស្ស	\N		\N	\N	\N	1052	\N
439	មនុស្ស	\N		\N	\N	\N	1124	\N
439	មនុស្ស	\N		\N	\N	\N	160	\N
439	មនុស្ស	\N		\N	\N	\N	176	\N
439	មនុស្ស	\N		\N	\N	\N	864	\N
439	មនុស្ស	\N		\N	\N	\N	380	\N
439	មនុស្ស	\N		\N	\N	\N	396	\N
439	មនុស្ស	\N		\N	\N	\N	462	\N
439	មនុស្ស	\N		\N	\N	\N	520	\N
439	មនុស្ស	\N		\N	\N	\N	554	\N
439	មនុស្ស	\N		\N	\N	\N	594	\N
439	មនុស្ស	\N		\N	\N	\N	598	\N
439	មនុស្ស	\N		\N	\N	\N	798	\N
440	ប្រុស	\N		\N	\N	\N	1031	\N
440	ប្រុស	\N		\N	\N	\N	143	\N
440	ប្រុស	\N		\N	\N	\N	144	\N
440	ប្រុស	\N		\N	\N	\N	145	\N
440	ប្រុស	\N		\N	\N	\N	210	\N
440	ប្រុស	\N		\N	\N	\N	363	\N
440	ប្រុស	\N		\N	\N	\N	364	\N
440	ប្រុស	\N		\N	\N	\N	365	\N
440	ប្រុស	\N		\N	\N	\N	430	\N
440	ប្រុស	\N		\N	\N	\N	558	\N
440	ប្រុស	\N		\N	\N	\N	773	\N
441	កូនស្រី	\N		\N	\N	\N	145	\N
441	កូនស្រី	\N		\N	\N	\N	365	\N
441	កូនស្រី	\N		\N	\N	\N	589	\N
442	ប្ដី	\N		\N	\N	\N	1125	\N
442	ប្ដី	\N		\N	\N	\N	1126	\N
443	ទាំងអស់គ្នា	\N		\N	\N	\N	1127	\N
444	ស	\N		\N	\N	\N	866	\N
444	ស	\N		\N	\N	\N	867	\N
444	ស	\N		\N	\N	\N	868	\N
444	ស	\N		\N	\N	\N	869	\N
444	ស	\N		\N	\N	\N	870	\N
444	ស	\N		\N	\N	\N	871	\N
444	ស	\N		\N	\N	\N	872	\N
444	ស	\N		\N	\N	\N	874	\N
444	ស	\N		\N	\N	\N	875	\N
444	ស	\N		\N	\N	\N	878	\N
444	ស	\N		\N	\N	\N	880	\N
444	ស	\N		\N	\N	\N	882	\N
444	ស	\N		\N	\N	\N	884	\N
444	ស	\N		\N	\N	\N	885	\N
444	ស	\N		\N	\N	\N	886	\N
444	ស	\N		\N	\N	\N	888	\N
444	ស	\N		\N	\N	\N	890	\N
444	ស	\N		\N	\N	\N	891	\N
444	ស	\N		\N	\N	\N	892	\N
444	ស	\N		\N	\N	\N	893	\N
444	ស	\N		\N	\N	\N	894	\N
444	ស	\N		\N	\N	\N	895	\N
444	ស	\N		\N	\N	\N	896	\N
444	ស	\N		\N	\N	\N	897	\N
444	ស	\N		\N	\N	\N	899	\N
444	ស	\N		\N	\N	\N	900	\N
444	ស	\N		\N	\N	\N	901	\N
444	ស	\N		\N	\N	\N	902	\N
444	ស	\N		\N	\N	\N	903	\N
444	ស	\N		\N	\N	\N	904	\N
444	ស	\N		\N	\N	\N	905	\N
444	ស	\N		\N	\N	\N	906	\N
444	ស	\N		\N	\N	\N	908	\N
444	ស	\N		\N	\N	\N	909	\N
444	ស	\N		\N	\N	\N	911	\N
444	ស	\N		\N	\N	\N	912	\N
444	ស	\N		\N	\N	\N	914	\N
444	ស	\N		\N	\N	\N	915	\N
444	ស	\N		\N	\N	\N	917	\N
444	ស	\N		\N	\N	\N	918	\N
444	ស	\N		\N	\N	\N	919	\N
444	ស	\N		\N	\N	\N	921	\N
444	ស	\N		\N	\N	\N	922	\N
444	ស	\N		\N	\N	\N	923	\N
444	ស	\N		\N	\N	\N	924	\N
444	ស	\N		\N	\N	\N	927	\N
444	ស	\N		\N	\N	\N	928	\N
444	ស	\N		\N	\N	\N	931	\N
444	ស	\N		\N	\N	\N	932	\N
444	ស	\N		\N	\N	\N	933	\N
444	ស	\N		\N	\N	\N	934	\N
444	ស	\N		\N	\N	\N	935	\N
444	ស	\N		\N	\N	\N	936	\N
444	ស	\N		\N	\N	\N	937	\N
444	ស	\N		\N	\N	\N	938	\N
444	ស	\N		\N	\N	\N	939	\N
444	ស	\N		\N	\N	\N	941	\N
444	ស	\N		\N	\N	\N	942	\N
444	ស	\N		\N	\N	\N	943	\N
444	ស	\N		\N	\N	\N	945	\N
444	ស	\N		\N	\N	\N	946	\N
444	ស	\N		\N	\N	\N	947	\N
444	ស	\N		\N	\N	\N	948	\N
444	ស	\N		\N	\N	\N	950	\N
444	ស	\N		\N	\N	\N	951	\N
444	ស	\N		\N	\N	\N	953	\N
444	ស	\N		\N	\N	\N	954	\N
444	ស	\N		\N	\N	\N	955	\N
444	ស	\N		\N	\N	\N	956	\N
444	ស	\N		\N	\N	\N	957	\N
444	ស	\N		\N	\N	\N	959	\N
444	ស	\N		\N	\N	\N	960	\N
444	ស	\N		\N	\N	\N	961	\N
444	ស	\N		\N	\N	\N	962	\N
444	ស	\N		\N	\N	\N	965	\N
444	ស	\N		\N	\N	\N	966	\N
444	ស	\N		\N	\N	\N	967	\N
444	ស	\N		\N	\N	\N	968	\N
444	ស	\N		\N	\N	\N	969	\N
444	ស	\N		\N	\N	\N	970	\N
444	ស	\N		\N	\N	\N	971	\N
444	ស	\N		\N	\N	\N	972	\N
444	ស	\N		\N	\N	\N	973	\N
444	ស	\N		\N	\N	\N	974	\N
444	ស	\N		\N	\N	\N	975	\N
444	ស	\N		\N	\N	\N	977	\N
444	ស	\N		\N	\N	\N	979	\N
444	ស	\N		\N	\N	\N	981	\N
444	ស	\N		\N	\N	\N	982	\N
444	ស	\N		\N	\N	\N	983	\N
444	ស	\N		\N	\N	\N	984	\N
444	ស	\N		\N	\N	\N	985	\N
444	ស	\N		\N	\N	\N	986	\N
444	ស	\N		\N	\N	\N	987	\N
444	ស	\N		\N	\N	\N	992	\N
444	ស	\N		\N	\N	\N	993	\N
444	ស	\N		\N	\N	\N	995	\N
444	ស	\N		\N	\N	\N	996	\N
444	ស	\N		\N	\N	\N	998	\N
444	ស	\N		\N	\N	\N	999	\N
444	ស	\N		\N	\N	\N	1000	\N
444	ស	\N		\N	\N	\N	1001	\N
444	ស	\N		\N	\N	\N	1002	\N
444	ស	\N		\N	\N	\N	1003	\N
444	ស	\N		\N	\N	\N	1006	\N
444	ស	\N		\N	\N	\N	1007	\N
444	ស	\N		\N	\N	\N	1008	\N
444	ស	\N		\N	\N	\N	1009	\N
444	ស	\N		\N	\N	\N	1010	\N
444	ស	\N		\N	\N	\N	1013	\N
444	ស	\N		\N	\N	\N	1014	\N
444	ស	\N		\N	\N	\N	1015	\N
444	ស	\N		\N	\N	\N	1016	\N
444	ស	\N		\N	\N	\N	1018	\N
444	ស	\N		\N	\N	\N	1019	\N
444	ស	\N		\N	\N	\N	1020	\N
444	ស	\N		\N	\N	\N	1022	\N
444	ស	\N		\N	\N	\N	1023	\N
444	ស	\N		\N	\N	\N	1024	\N
444	ស	\N		\N	\N	\N	1026	\N
444	ស	\N		\N	\N	\N	1028	\N
444	ស	\N		\N	\N	\N	1030	\N
444	ស	\N		\N	\N	\N	1031	\N
444	ស	\N		\N	\N	\N	1032	\N
444	ស	\N		\N	\N	\N	1033	\N
444	ស	\N		\N	\N	\N	1034	\N
444	ស	\N		\N	\N	\N	1035	\N
444	ស	\N		\N	\N	\N	1036	\N
444	ស	\N		\N	\N	\N	1039	\N
444	ស	\N		\N	\N	\N	1040	\N
444	ស	\N		\N	\N	\N	1041	\N
444	ស	\N		\N	\N	\N	1042	\N
444	ស	\N		\N	\N	\N	1043	\N
444	ស	\N		\N	\N	\N	1044	\N
444	ស	\N		\N	\N	\N	1045	\N
444	ស	\N		\N	\N	\N	1046	\N
444	ស	\N		\N	\N	\N	1047	\N
444	ស	\N		\N	\N	\N	1048	\N
444	ស	\N		\N	\N	\N	1049	\N
444	ស	\N		\N	\N	\N	1050	\N
444	ស	\N		\N	\N	\N	1051	\N
444	ស	\N		\N	\N	\N	1052	\N
444	ស	\N		\N	\N	\N	1054	\N
444	ស	\N		\N	\N	\N	1057	\N
444	ស	\N		\N	\N	\N	1058	\N
444	ស	\N		\N	\N	\N	1060	\N
444	ស	\N		\N	\N	\N	1061	\N
444	ស	\N		\N	\N	\N	1063	\N
444	ស	\N		\N	\N	\N	1064	\N
444	ស	\N		\N	\N	\N	1065	\N
444	ស	\N		\N	\N	\N	1066	\N
444	ស	\N		\N	\N	\N	1068	\N
444	ស	\N		\N	\N	\N	1069	\N
444	ស	\N		\N	\N	\N	1070	\N
444	ស	\N		\N	\N	\N	1071	\N
444	ស	\N		\N	\N	\N	1072	\N
444	ស	\N		\N	\N	\N	1073	\N
444	ស	\N		\N	\N	\N	1074	\N
444	ស	\N		\N	\N	\N	1076	\N
444	ស	\N		\N	\N	\N	1077	\N
444	ស	\N		\N	\N	\N	1078	\N
444	ស	\N		\N	\N	\N	1079	\N
444	ស	\N		\N	\N	\N	1080	\N
444	ស	\N		\N	\N	\N	1081	\N
444	ស	\N		\N	\N	\N	1082	\N
444	ស	\N		\N	\N	\N	1083	\N
444	ស	\N		\N	\N	\N	1085	\N
444	ស	\N		\N	\N	\N	1086	\N
444	ស	\N		\N	\N	\N	1088	\N
444	ស	\N		\N	\N	\N	1089	\N
444	ស	\N		\N	\N	\N	1090	\N
444	ស	\N		\N	\N	\N	1093	\N
444	ស	\N		\N	\N	\N	1094	\N
444	ស	\N		\N	\N	\N	1095	\N
444	ស	\N		\N	\N	\N	1097	\N
444	ស	\N		\N	\N	\N	1100	\N
444	ស	\N		\N	\N	\N	1101	\N
444	ស	\N		\N	\N	\N	1102	\N
444	ស	\N		\N	\N	\N	1103	\N
444	ស	\N		\N	\N	\N	1104	\N
444	ស	\N		\N	\N	\N	1105	\N
444	ស	\N		\N	\N	\N	1106	\N
444	ស	\N		\N	\N	\N	1109	\N
444	ស	\N		\N	\N	\N	1110	\N
444	ស	\N		\N	\N	\N	1111	\N
444	ស	\N		\N	\N	\N	1112	\N
444	ស	\N		\N	\N	\N	1113	\N
444	ស	\N		\N	\N	\N	1114	\N
444	ស	\N		\N	\N	\N	1115	\N
444	ស	\N		\N	\N	\N	1116	\N
444	ស	\N		\N	\N	\N	1117	\N
444	ស	\N		\N	\N	\N	1118	\N
444	ស	\N		\N	\N	\N	1120	\N
444	ស	\N		\N	\N	\N	1121	\N
444	ស	\N		\N	\N	\N	1122	\N
444	ស	\N		\N	\N	\N	1123	\N
444	ស	\N		\N	\N	\N	1124	\N
444	ស	\N		\N	\N	\N	1125	\N
444	ស	\N		\N	\N	\N	1126	\N
444	ស	\N		\N	\N	\N	1127	\N
444	ស	\N		\N	\N	\N	1128	\N
444	ស	\N		\N	\N	\N	1129	\N
444	ស	\N		\N	\N	\N	1130	\N
444	ស	\N		\N	\N	\N	1131	\N
444	ស	\N		\N	\N	\N	1132	\N
444	ស	\N		\N	\N	\N	1133	\N
444	ស	\N		\N	\N	\N	1134	\N
444	ស	\N		\N	\N	\N	1135	\N
444	ស	\N		\N	\N	\N	1136	\N
444	ស	\N		\N	\N	\N	1137	\N
444	ស	\N		\N	\N	\N	1138	\N
444	ស	\N		\N	\N	\N	1139	\N
444	ស	\N		\N	\N	\N	1141	\N
444	ស	\N		\N	\N	\N	1	\N
444	ស	\N		\N	\N	\N	2	\N
444	ស	\N		\N	\N	\N	5	\N
444	ស	\N		\N	\N	\N	10	\N
444	ស	\N		\N	\N	\N	11	\N
444	ស	\N		\N	\N	\N	12	\N
444	ស	\N		\N	\N	\N	13	\N
444	ស	\N		\N	\N	\N	14	\N
444	ស	\N		\N	\N	\N	15	\N
444	ស	\N		\N	\N	\N	16	\N
444	ស	\N		\N	\N	\N	17	\N
444	ស	\N		\N	\N	\N	18	\N
444	ស	\N		\N	\N	\N	21	\N
444	ស	\N		\N	\N	\N	22	\N
444	ស	\N		\N	\N	\N	28	\N
444	ស	\N		\N	\N	\N	29	\N
444	ស	\N		\N	\N	\N	30	\N
444	ស	\N		\N	\N	\N	34	\N
444	ស	\N		\N	\N	\N	35	\N
444	ស	\N		\N	\N	\N	38	\N
444	ស	\N		\N	\N	\N	40	\N
444	ស	\N		\N	\N	\N	42	\N
444	ស	\N		\N	\N	\N	44	\N
444	ស	\N		\N	\N	\N	47	\N
444	ស	\N		\N	\N	\N	48	\N
444	ស	\N		\N	\N	\N	50	\N
444	ស	\N		\N	\N	\N	53	\N
444	ស	\N		\N	\N	\N	57	\N
444	ស	\N		\N	\N	\N	66	\N
444	ស	\N		\N	\N	\N	67	\N
444	ស	\N		\N	\N	\N	68	\N
444	ស	\N		\N	\N	\N	69	\N
444	ស	\N		\N	\N	\N	71	\N
444	ស	\N		\N	\N	\N	72	\N
444	ស	\N		\N	\N	\N	73	\N
444	ស	\N		\N	\N	\N	74	\N
444	ស	\N		\N	\N	\N	76	\N
444	ស	\N		\N	\N	\N	78	\N
444	ស	\N		\N	\N	\N	80	\N
444	ស	\N		\N	\N	\N	84	\N
444	ស	\N		\N	\N	\N	92	\N
444	ស	\N		\N	\N	\N	93	\N
444	ស	\N		\N	\N	\N	98	\N
444	ស	\N		\N	\N	\N	109	\N
444	ស	\N		\N	\N	\N	110	\N
444	ស	\N		\N	\N	\N	111	\N
444	ស	\N		\N	\N	\N	112	\N
444	ស	\N		\N	\N	\N	116	\N
444	ស	\N		\N	\N	\N	126	\N
444	ស	\N		\N	\N	\N	140	\N
444	ស	\N		\N	\N	\N	143	\N
444	ស	\N		\N	\N	\N	144	\N
444	ស	\N		\N	\N	\N	145	\N
444	ស	\N		\N	\N	\N	146	\N
444	ស	\N		\N	\N	\N	152	\N
444	ស	\N		\N	\N	\N	156	\N
444	ស	\N		\N	\N	\N	157	\N
444	ស	\N		\N	\N	\N	160	\N
444	ស	\N		\N	\N	\N	161	\N
444	ស	\N		\N	\N	\N	162	\N
444	ស	\N		\N	\N	\N	163	\N
444	ស	\N		\N	\N	\N	168	\N
444	ស	\N		\N	\N	\N	172	\N
444	ស	\N		\N	\N	\N	173	\N
444	ស	\N		\N	\N	\N	175	\N
444	ស	\N		\N	\N	\N	176	\N
444	ស	\N		\N	\N	\N	177	\N
444	ស	\N		\N	\N	\N	194	\N
444	ស	\N		\N	\N	\N	195	\N
444	ស	\N		\N	\N	\N	196	\N
444	ស	\N		\N	\N	\N	197	\N
444	ស	\N		\N	\N	\N	198	\N
444	ស	\N		\N	\N	\N	200	\N
444	ស	\N		\N	\N	\N	201	\N
444	ស	\N		\N	\N	\N	202	\N
444	ស	\N		\N	\N	\N	205	\N
444	ស	\N		\N	\N	\N	208	\N
444	ស	\N		\N	\N	\N	210	\N
444	ស	\N		\N	\N	\N	841	\N
444	ស	\N		\N	\N	\N	844	\N
444	ស	\N		\N	\N	\N	845	\N
444	ស	\N		\N	\N	\N	854	\N
444	ស	\N		\N	\N	\N	855	\N
444	ស	\N		\N	\N	\N	856	\N
444	ស	\N		\N	\N	\N	864	\N
444	ស	\N		\N	\N	\N	865	\N
444	ស	\N		\N	\N	\N	216	\N
444	ស	\N		\N	\N	\N	217	\N
444	ស	\N		\N	\N	\N	218	\N
444	ស	\N		\N	\N	\N	219	\N
444	ស	\N		\N	\N	\N	220	\N
444	ស	\N		\N	\N	\N	221	\N
444	ស	\N		\N	\N	\N	222	\N
444	ស	\N		\N	\N	\N	225	\N
444	ស	\N		\N	\N	\N	230	\N
444	ស	\N		\N	\N	\N	231	\N
444	ស	\N		\N	\N	\N	232	\N
444	ស	\N		\N	\N	\N	233	\N
444	ស	\N		\N	\N	\N	234	\N
444	ស	\N		\N	\N	\N	235	\N
444	ស	\N		\N	\N	\N	236	\N
444	ស	\N		\N	\N	\N	237	\N
444	ស	\N		\N	\N	\N	238	\N
444	ស	\N		\N	\N	\N	241	\N
444	ស	\N		\N	\N	\N	242	\N
444	ស	\N		\N	\N	\N	248	\N
444	ស	\N		\N	\N	\N	249	\N
444	ស	\N		\N	\N	\N	250	\N
444	ស	\N		\N	\N	\N	254	\N
444	ស	\N		\N	\N	\N	255	\N
444	ស	\N		\N	\N	\N	258	\N
444	ស	\N		\N	\N	\N	260	\N
444	ស	\N		\N	\N	\N	262	\N
444	ស	\N		\N	\N	\N	264	\N
444	ស	\N		\N	\N	\N	267	\N
444	ស	\N		\N	\N	\N	268	\N
444	ស	\N		\N	\N	\N	270	\N
444	ស	\N		\N	\N	\N	273	\N
444	ស	\N		\N	\N	\N	277	\N
444	ស	\N		\N	\N	\N	286	\N
444	ស	\N		\N	\N	\N	287	\N
444	ស	\N		\N	\N	\N	288	\N
444	ស	\N		\N	\N	\N	289	\N
444	ស	\N		\N	\N	\N	291	\N
444	ស	\N		\N	\N	\N	292	\N
444	ស	\N		\N	\N	\N	293	\N
444	ស	\N		\N	\N	\N	294	\N
444	ស	\N		\N	\N	\N	296	\N
444	ស	\N		\N	\N	\N	298	\N
444	ស	\N		\N	\N	\N	300	\N
444	ស	\N		\N	\N	\N	304	\N
444	ស	\N		\N	\N	\N	312	\N
444	ស	\N		\N	\N	\N	313	\N
444	ស	\N		\N	\N	\N	318	\N
444	ស	\N		\N	\N	\N	329	\N
444	ស	\N		\N	\N	\N	330	\N
444	ស	\N		\N	\N	\N	331	\N
444	ស	\N		\N	\N	\N	332	\N
444	ស	\N		\N	\N	\N	336	\N
444	ស	\N		\N	\N	\N	346	\N
444	ស	\N		\N	\N	\N	360	\N
444	ស	\N		\N	\N	\N	363	\N
444	ស	\N		\N	\N	\N	364	\N
444	ស	\N		\N	\N	\N	365	\N
444	ស	\N		\N	\N	\N	366	\N
444	ស	\N		\N	\N	\N	372	\N
444	ស	\N		\N	\N	\N	376	\N
444	ស	\N		\N	\N	\N	377	\N
444	ស	\N		\N	\N	\N	380	\N
444	ស	\N		\N	\N	\N	381	\N
444	ស	\N		\N	\N	\N	382	\N
444	ស	\N		\N	\N	\N	383	\N
444	ស	\N		\N	\N	\N	388	\N
444	ស	\N		\N	\N	\N	392	\N
444	ស	\N		\N	\N	\N	393	\N
444	ស	\N		\N	\N	\N	395	\N
444	ស	\N		\N	\N	\N	396	\N
444	ស	\N		\N	\N	\N	397	\N
444	ស	\N		\N	\N	\N	414	\N
444	ស	\N		\N	\N	\N	415	\N
444	ស	\N		\N	\N	\N	416	\N
444	ស	\N		\N	\N	\N	417	\N
444	ស	\N		\N	\N	\N	418	\N
444	ស	\N		\N	\N	\N	420	\N
444	ស	\N		\N	\N	\N	421	\N
444	ស	\N		\N	\N	\N	422	\N
444	ស	\N		\N	\N	\N	425	\N
444	ស	\N		\N	\N	\N	428	\N
444	ស	\N		\N	\N	\N	430	\N
444	ស	\N		\N	\N	\N	436	\N
444	ស	\N		\N	\N	\N	437	\N
444	ស	\N		\N	\N	\N	438	\N
444	ស	\N		\N	\N	\N	439	\N
444	ស	\N		\N	\N	\N	440	\N
444	ស	\N		\N	\N	\N	441	\N
444	ស	\N		\N	\N	\N	442	\N
444	ស	\N		\N	\N	\N	443	\N
444	ស	\N		\N	\N	\N	444	\N
444	ស	\N		\N	\N	\N	445	\N
444	ស	\N		\N	\N	\N	447	\N
444	ស	\N		\N	\N	\N	448	\N
444	ស	\N		\N	\N	\N	449	\N
444	ស	\N		\N	\N	\N	451	\N
444	ស	\N		\N	\N	\N	453	\N
444	ស	\N		\N	\N	\N	456	\N
444	ស	\N		\N	\N	\N	458	\N
444	ស	\N		\N	\N	\N	459	\N
444	ស	\N		\N	\N	\N	460	\N
444	ស	\N		\N	\N	\N	462	\N
444	ស	\N		\N	\N	\N	464	\N
444	ស	\N		\N	\N	\N	466	\N
444	ស	\N		\N	\N	\N	468	\N
444	ស	\N		\N	\N	\N	469	\N
444	ស	\N		\N	\N	\N	470	\N
444	ស	\N		\N	\N	\N	471	\N
444	ស	\N		\N	\N	\N	472	\N
444	ស	\N		\N	\N	\N	473	\N
444	ស	\N		\N	\N	\N	474	\N
444	ស	\N		\N	\N	\N	476	\N
444	ស	\N		\N	\N	\N	477	\N
444	ស	\N		\N	\N	\N	479	\N
444	ស	\N		\N	\N	\N	482	\N
444	ស	\N		\N	\N	\N	484	\N
444	ស	\N		\N	\N	\N	488	\N
444	ស	\N		\N	\N	\N	493	\N
444	ស	\N		\N	\N	\N	494	\N
444	ស	\N		\N	\N	\N	495	\N
444	ស	\N		\N	\N	\N	496	\N
444	ស	\N		\N	\N	\N	497	\N
444	ស	\N		\N	\N	\N	500	\N
444	ស	\N		\N	\N	\N	501	\N
444	ស	\N		\N	\N	\N	502	\N
444	ស	\N		\N	\N	\N	503	\N
444	ស	\N		\N	\N	\N	505	\N
444	ស	\N		\N	\N	\N	508	\N
444	ស	\N		\N	\N	\N	517	\N
444	ស	\N		\N	\N	\N	518	\N
444	ស	\N		\N	\N	\N	519	\N
444	ស	\N		\N	\N	\N	520	\N
444	ស	\N		\N	\N	\N	521	\N
444	ស	\N		\N	\N	\N	522	\N
444	ស	\N		\N	\N	\N	523	\N
444	ស	\N		\N	\N	\N	524	\N
444	ស	\N		\N	\N	\N	525	\N
444	ស	\N		\N	\N	\N	526	\N
444	ស	\N		\N	\N	\N	527	\N
444	ស	\N		\N	\N	\N	528	\N
444	ស	\N		\N	\N	\N	530	\N
444	ស	\N		\N	\N	\N	531	\N
444	ស	\N		\N	\N	\N	532	\N
444	ស	\N		\N	\N	\N	533	\N
444	ស	\N		\N	\N	\N	534	\N
444	ស	\N		\N	\N	\N	535	\N
444	ស	\N		\N	\N	\N	537	\N
444	ស	\N		\N	\N	\N	540	\N
444	ស	\N		\N	\N	\N	541	\N
444	ស	\N		\N	\N	\N	545	\N
444	ស	\N		\N	\N	\N	546	\N
444	ស	\N		\N	\N	\N	550	\N
444	ស	\N		\N	\N	\N	551	\N
444	ស	\N		\N	\N	\N	553	\N
444	ស	\N		\N	\N	\N	554	\N
444	ស	\N		\N	\N	\N	555	\N
444	ស	\N		\N	\N	\N	556	\N
444	ស	\N		\N	\N	\N	557	\N
444	ស	\N		\N	\N	\N	558	\N
444	ស	\N		\N	\N	\N	559	\N
444	ស	\N		\N	\N	\N	560	\N
444	ស	\N		\N	\N	\N	561	\N
444	ស	\N		\N	\N	\N	562	\N
444	ស	\N		\N	\N	\N	564	\N
444	ស	\N		\N	\N	\N	565	\N
444	ស	\N		\N	\N	\N	566	\N
444	ស	\N		\N	\N	\N	568	\N
444	ស	\N		\N	\N	\N	570	\N
444	ស	\N		\N	\N	\N	572	\N
444	ស	\N		\N	\N	\N	574	\N
444	ស	\N		\N	\N	\N	575	\N
444	ស	\N		\N	\N	\N	577	\N
444	ស	\N		\N	\N	\N	578	\N
444	ស	\N		\N	\N	\N	579	\N
444	ស	\N		\N	\N	\N	581	\N
444	ស	\N		\N	\N	\N	582	\N
444	ស	\N		\N	\N	\N	583	\N
444	ស	\N		\N	\N	\N	584	\N
444	ស	\N		\N	\N	\N	585	\N
444	ស	\N		\N	\N	\N	586	\N
444	ស	\N		\N	\N	\N	587	\N
444	ស	\N		\N	\N	\N	588	\N
444	ស	\N		\N	\N	\N	589	\N
444	ស	\N		\N	\N	\N	590	\N
444	ស	\N		\N	\N	\N	592	\N
444	ស	\N		\N	\N	\N	594	\N
444	ស	\N		\N	\N	\N	596	\N
444	ស	\N		\N	\N	\N	597	\N
444	ស	\N		\N	\N	\N	598	\N
444	ស	\N		\N	\N	\N	600	\N
444	ស	\N		\N	\N	\N	601	\N
444	ស	\N		\N	\N	\N	602	\N
444	ស	\N		\N	\N	\N	607	\N
444	ស	\N		\N	\N	\N	611	\N
444	ស	\N		\N	\N	\N	613	\N
444	ស	\N		\N	\N	\N	615	\N
444	ស	\N		\N	\N	\N	617	\N
444	ស	\N		\N	\N	\N	619	\N
444	ស	\N		\N	\N	\N	620	\N
444	ស	\N		\N	\N	\N	621	\N
444	ស	\N		\N	\N	\N	623	\N
444	ស	\N		\N	\N	\N	627	\N
444	ស	\N		\N	\N	\N	629	\N
444	ស	\N		\N	\N	\N	630	\N
444	ស	\N		\N	\N	\N	631	\N
444	ស	\N		\N	\N	\N	633	\N
444	ស	\N		\N	\N	\N	635	\N
444	ស	\N		\N	\N	\N	636	\N
444	ស	\N		\N	\N	\N	638	\N
444	ស	\N		\N	\N	\N	639	\N
444	ស	\N		\N	\N	\N	640	\N
444	ស	\N		\N	\N	\N	641	\N
444	ស	\N		\N	\N	\N	642	\N
444	ស	\N		\N	\N	\N	644	\N
444	ស	\N		\N	\N	\N	645	\N
444	ស	\N		\N	\N	\N	646	\N
444	ស	\N		\N	\N	\N	647	\N
444	ស	\N		\N	\N	\N	648	\N
444	ស	\N		\N	\N	\N	649	\N
444	ស	\N		\N	\N	\N	651	\N
444	ស	\N		\N	\N	\N	654	\N
444	ស	\N		\N	\N	\N	657	\N
444	ស	\N		\N	\N	\N	658	\N
444	ស	\N		\N	\N	\N	661	\N
444	ស	\N		\N	\N	\N	662	\N
444	ស	\N		\N	\N	\N	663	\N
444	ស	\N		\N	\N	\N	665	\N
444	ស	\N		\N	\N	\N	666	\N
444	ស	\N		\N	\N	\N	668	\N
444	ស	\N		\N	\N	\N	669	\N
444	ស	\N		\N	\N	\N	671	\N
444	ស	\N		\N	\N	\N	672	\N
444	ស	\N		\N	\N	\N	673	\N
444	ស	\N		\N	\N	\N	674	\N
444	ស	\N		\N	\N	\N	677	\N
444	ស	\N		\N	\N	\N	678	\N
444	ស	\N		\N	\N	\N	679	\N
444	ស	\N		\N	\N	\N	681	\N
444	ស	\N		\N	\N	\N	683	\N
444	ស	\N		\N	\N	\N	684	\N
444	ស	\N		\N	\N	\N	686	\N
444	ស	\N		\N	\N	\N	687	\N
444	ស	\N		\N	\N	\N	688	\N
444	ស	\N		\N	\N	\N	693	\N
444	ស	\N		\N	\N	\N	695	\N
444	ស	\N		\N	\N	\N	696	\N
444	ស	\N		\N	\N	\N	697	\N
444	ស	\N		\N	\N	\N	699	\N
444	ស	\N		\N	\N	\N	702	\N
444	ស	\N		\N	\N	\N	704	\N
444	ស	\N		\N	\N	\N	707	\N
444	ស	\N		\N	\N	\N	708	\N
444	ស	\N		\N	\N	\N	709	\N
444	ស	\N		\N	\N	\N	710	\N
444	ស	\N		\N	\N	\N	712	\N
444	ស	\N		\N	\N	\N	713	\N
444	ស	\N		\N	\N	\N	714	\N
444	ស	\N		\N	\N	\N	715	\N
444	ស	\N		\N	\N	\N	716	\N
444	ស	\N		\N	\N	\N	718	\N
444	ស	\N		\N	\N	\N	720	\N
444	ស	\N		\N	\N	\N	724	\N
444	ស	\N		\N	\N	\N	726	\N
444	ស	\N		\N	\N	\N	727	\N
444	ស	\N		\N	\N	\N	729	\N
444	ស	\N		\N	\N	\N	734	\N
444	ស	\N		\N	\N	\N	735	\N
444	ស	\N		\N	\N	\N	736	\N
444	ស	\N		\N	\N	\N	737	\N
444	ស	\N		\N	\N	\N	745	\N
444	ស	\N		\N	\N	\N	750	\N
444	ស	\N		\N	\N	\N	751	\N
444	ស	\N		\N	\N	\N	754	\N
444	ស	\N		\N	\N	\N	758	\N
444	ស	\N		\N	\N	\N	759	\N
444	ស	\N		\N	\N	\N	760	\N
444	ស	\N		\N	\N	\N	761	\N
444	ស	\N		\N	\N	\N	763	\N
444	ស	\N		\N	\N	\N	765	\N
444	ស	\N		\N	\N	\N	766	\N
444	ស	\N		\N	\N	\N	769	\N
444	ស	\N		\N	\N	\N	771	\N
444	ស	\N		\N	\N	\N	772	\N
444	ស	\N		\N	\N	\N	773	\N
444	ស	\N		\N	\N	\N	775	\N
444	ស	\N		\N	\N	\N	776	\N
444	ស	\N		\N	\N	\N	777	\N
444	ស	\N		\N	\N	\N	780	\N
444	ស	\N		\N	\N	\N	782	\N
444	ស	\N		\N	\N	\N	786	\N
444	ស	\N		\N	\N	\N	787	\N
444	ស	\N		\N	\N	\N	789	\N
444	ស	\N		\N	\N	\N	792	\N
444	ស	\N		\N	\N	\N	793	\N
444	ស	\N		\N	\N	\N	794	\N
444	ស	\N		\N	\N	\N	795	\N
444	ស	\N		\N	\N	\N	797	\N
444	ស	\N		\N	\N	\N	798	\N
444	ស	\N		\N	\N	\N	799	\N
444	ស	\N		\N	\N	\N	800	\N
444	ស	\N		\N	\N	\N	802	\N
444	ស	\N		\N	\N	\N	804	\N
444	ស	\N		\N	\N	\N	805	\N
444	ស	\N		\N	\N	\N	806	\N
444	ស	\N		\N	\N	\N	807	\N
444	ស	\N		\N	\N	\N	811	\N
444	ស	\N		\N	\N	\N	820	\N
444	ស	\N		\N	\N	\N	822	\N
444	ស	\N		\N	\N	\N	826	\N
444	ស	\N		\N	\N	\N	831	\N
445	ខៀវ	\N		\N	\N	\N	891	\N
445	ខៀវ	\N		\N	\N	\N	491	\N
446	ត្នោត	\N		\N	\N	\N	1126	\N
446	ត្នោត	\N		\N	\N	\N	1128	\N
447	ពណ៌	\N		\N	\N	\N	1083	\N
447	ពណ៌	\N		\N	\N	\N	1129	\N
447	ពណ៌	\N		\N	\N	\N	1130	\N
447	ពណ៌	\N		\N	\N	\N	1132	\N
448	លឿង	\N		\N	\N	\N	1130	\N
448	លឿង	\N		\N	\N	\N	1132	\N
449	ខ្មៅ	\N		\N	\N	\N	1050	\N
449	ខ្មៅ	\N		\N	\N	\N	1054	\N
449	ខ្មៅ	\N		\N	\N	\N	52	\N
449	ខ្មៅ	\N		\N	\N	\N	55	\N
449	ខ្មៅ	\N		\N	\N	\N	108	\N
449	ខ្មៅ	\N		\N	\N	\N	272	\N
449	ខ្មៅ	\N		\N	\N	\N	275	\N
449	ខ្មៅ	\N		\N	\N	\N	328	\N
449	ខ្មៅ	\N		\N	\N	\N	606	\N
449	ខ្មៅ	\N		\N	\N	\N	610	\N
449	ខ្មៅ	\N		\N	\N	\N	785	\N
450	ក្រហម	\N		\N	\N	\N	932	\N
450	ក្រហម	\N		\N	\N	\N	1064	\N
450	ក្រហម	\N		\N	\N	\N	1131	\N
451	បៃតង	\N		\N	\N	\N	1132	\N
452	ងាយស្រួល	\N		\N	\N	\N	1133	\N
453	ជប់លៀង	\N		\N	\N	\N	1134	\N
454	ក្រដាស	\N		\N	\N	\N	984	\N
454	ក្រដាស	\N		\N	\N	\N	677	\N
454	ក្រដាស	\N		\N	\N	\N	822	\N
455	ក្លាយជា	\N		\N	\N	\N	1135	\N
456	រឹត	\N		\N	\N	\N	955	\N
456	រឹត	\N		\N	\N	\N	459	\N
457	រុញ	\N		\N	\N	\N	1136	\N
458	ចាប់ផ្ដើម	\N		\N	\N	\N	1022	\N
458	ចាប់ផ្ដើម	\N		\N	\N	\N	1137	\N
459	គត់	\N		\N	\N	\N	1138	\N
460	គ្មាន	\N		\N	\N	\N	922	\N
460	គ្មាន	\N		\N	\N	\N	1012	\N
460	គ្មាន	\N		\N	\N	\N	1112	\N
460	គ្មាន	\N		\N	\N	\N	1139	\N
461	ត្រង់	\N		\N	\N	\N	921	\N
461	ត្រង់	\N		\N	\N	\N	923	\N
461	ត្រង់	\N		\N	\N	\N	947	\N
461	ត្រង់	\N		\N	\N	\N	980	\N
461	ត្រង់	\N		\N	\N	\N	999	\N
461	ត្រង់	\N		\N	\N	\N	1043	\N
461	ត្រង់	\N		\N	\N	\N	1044	\N
461	ត្រង់	\N		\N	\N	\N	1053	\N
461	ត្រង់	\N		\N	\N	\N	1138	\N
461	ត្រង់	\N		\N	\N	\N	576	\N
461	ត្រង់	\N		\N	\N	\N	577	\N
461	ត្រង់	\N		\N	\N	\N	621	\N
462	ល្បី	\N		\N	\N	\N	1140	\N
463	សុខសប្បាយ	\N		\N	\N	\N	503	\N
463	សុខសប្បាយ	\N		\N	\N	\N	505	\N
464	ប្រហែល	\N		\N	\N	\N	596	\N
464	ប្រហែល	\N		\N	\N	\N	601	\N
464	ប្រហែល	\N		\N	\N	\N	627	\N
464	ប្រហែល	\N		\N	\N	\N	668	\N
464	ប្រហែល	\N		\N	\N	\N	792	\N
465	ឥឡូវនេះ	\N		\N	\N	\N	873	\N
465	ឥឡូវនេះ	\N		\N	\N	\N	1141	\N
294	ឪពុកម្ដាយ	\N		\N	\N	\N	937	\N
396	ឧស្សាហ៍	\N		\N	\N	\N	1142	\N
295	ឪពុក	\N		\N	\N	\N	1143	\N
175	ញ៉ាំ	\N		\N	\N	\N	1144	\N
85	តុ	\N		\N	\N	\N	1145	\N
306	ឆត្រ	\N		\N	\N	\N	671	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: km
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

