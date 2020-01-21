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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO mn;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO mn;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO mn;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: mn
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


ALTER TABLE public.t_instance OWNER TO mn;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO mn;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO mn;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: mn
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


ALTER TABLE public.t_usage_classified_rel OWNER TO mn;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: mn
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


ALTER TABLE public.t_usage_inst_rel OWNER TO mn;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO mn;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO mn;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: mn
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO mn;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: mn
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


ALTER TABLE public.t_word_inst_rel OWNER TO mn;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: mn
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO mn;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: mn
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO mn;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: mn
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_index_char (id, index_char) FROM stdin;
1	А
2	Б
3	В
4	Г
5	Д
6	Е
7	Ё
8	Ж
9	З
10	И
11	Й
12	К
13	Л
14	М
15	Н
16	О
17	П
18	Ө
19	Р
20	С
21	Т
22	У
23	Ү
24	Ф
25	Х
26	Ц
27	Ч
28	Ш
29	Щ
30	Ъ
31	Ы
32	Ь
33	Э
34	Ю
35	Я
36	-
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
127	Тэгэхдээ гайгүй байх.	でも大丈夫よ。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
162	Улс төрийн тухай сэдэв байгаа.	政治に関するテーマです。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
485	Өчигдөр анхны бороо орлоо.	昨日、今年初めての雨が降りました。	\N		\N	vmod	\N	\N	\N	0	1
559	Нөгөөдөр манай дүүгийн төрсөн өдөр.	あさっては弟の誕生日です。	\N		\N	vmod	\N	\N	\N	0	1
1043	Чи одоо битгий уу.	君はもう飲むな。	\N		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1157	Манай эмээ 87 настай.	祖母は87歳です。	\N		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
9	Хаа хүрч явна даа?	どこに行くの。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
10	Ажилдаа явж байна.	仕事よ。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
11	Аа, за баяртай.	そう、じゃあね。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
12	Баяртай.	じゃあね。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
13	Би хоёр дугтуй, дөрвөн ил захидал авъя. 	封筒２枚と絵はがき４枚ください。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
14	За, та ил захидлаа сонгоно уу?	はい、どのはがきにしますか、選んでください。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
15	За тэгье. Бас энэ захиаг Япон луу явуулах гэсэн юм.	はい。それからこの手紙を日本に出したいんですが。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
16	Энгийнээр үү, буухиагаар уу?	普通ですか、速達ですか。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
17	Энгийнээр, баталгаатай захиа явуулахад ямар үнэтэй вэ? 	書留で出すといくらですか。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
18	1500 төгрөг болж байна.	１５００トゥグリグになります。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
19	Энэ захиа хэд хоноод хүрэх вэ?	この手紙、何日で着きますか。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
20	Долоо хоноод л хүрэх байх.	1週間で届くと思います。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
21	За, үүнийг явуулъя.	ではこれをお願いします。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
22	Та баталгааны бичгээ авна уу?	書留の受領書をお受け取りください。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
23	Баярлалаа.	どうもお世話さま。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
24	Баяртай.	どういたしまして。			\N	dmod	mn02.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
25	Чи хэдэн настай вэ?	何歳ですか。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
26	Би хорин настай.	二十歳です。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
27	Хэдэн онд төрсөн бэ?	何年生まれですか。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
28	Би 1982 онд төрсөн.	1982年生まれです。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
29	Ямар жилтэй вэ?	何どしですか。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
30	Би  нохой жилтэй. 	戌どしです。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
31	Харин чи хэдэн настай вэ?	で、あなたは何歳ですか。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
32	Би энэ жил хорин гурав хүрч байна.	わたしは、ことし23になります。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
33	Чи надаас гурван насаар ах юм байна.	わたしより３歳年上なんですね。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
34	Хүүе! Чи хаана төрсөн бэ?	あれ、どちらのお生まれですか？			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
35	Би Улаанбаатар хотод төрсөн.	ウランバートル生まれです。			\N	dmod	mn03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
36	Сайн байна уу?	こんにちは。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
37	Сайн, сайн байна уу?	こんにちは。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
38	Би тантай танилцах гэсэн юм?	はじめまして。ちょっとよろしいですか。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
39	Өө, тэг тэг, бололгүй яах вэ?	はい、どうぞどうぞ。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
40	Миний нэр Алимаа.	わたくしはアリマーと申します。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
41	Таныг хэн гэдэг вэ?	先生のお名前は何とおっしゃいますか？			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
42	Миний нэр Сүх.	スフです。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
43	Өө,  Сүх гуай юу? Тантай танилцсандаа их баяртай байна.	あっ スフ先生ですか。お目にかかれて光栄です。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
304	35-р хичээлийнх. 	35課のよ。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
44	Би ч гэсэн. Сайхан танилцлаа.	こちらこそ。どうぞよろしく。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
45	Таны тухай би их сонссон юм байна.	お噂は、以前からうかがっておりました。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
46	Өө тийм үү?	あっ、そうですか。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
47	Тиймээ, таны номыг уншиж байсан.	ええ、先生のご本を読んだことがあります。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
48	Аан, за танил болцгоолоо.	なるほど。今後とも、よろしく。			\N	dmod	mn04.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
49	Уучлаарай. 	すみません。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
50	Танаас нэг юм гуймаар байна.	ちょっとお願いがあるんです。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
51	Тэг тэг, юу гээ вэ?	はい、何ですか。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
52	Та цаад толь бичгээ нааш нь аваад өгөхгүй юу? 	その辞書を取ってくださいますか。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
53	Тэгье, тэгье. 	はい、はい。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
54	Энэ чинь шинээр гарсан толь бичиг үү?	これ、新刊の辞書ですか。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
55	Тиймээ. Энэ жил хэвлэгдсэн шинэ толь бичиг.	ええ。今年出たばかりの辞書なんです			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
56	Энэ толь бичгийг хаана зарж байгааг нь та зааж өгч болох уу?	この辞書、どこで売っているか教えてもらえますか。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
57	Бололгүй яах вэ, тэгье.	ええ、いいですよ。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
58	За би хаягийг нь бичээд авъя.	本屋の住所をメモしておきたいんです。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
59	Та үзгээ түр өгөөч? 	ペンをちょっと貸してくれますか。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
60	Би хаягыг нь бичээд өгье.	住所を書いてあげましょう。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
61	За, тэг. 	では、お願いします。			\N	dmod	mn05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
63	Байна, байна. 	はい、どちらさまですか。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
64	Хэн бэ? Хэнтэй ярих вэ?	誰にお取り次ぎしましょうか。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
65	Хонгор байна. 	ホンゴルです。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
67	Сайн, сайн байна уу? 	こんにちは。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
68	Сонин сайхан юутай байна.	おかわりありませんか。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
69	Онц сонин юмгүй дээ, Баттай ярих гэсэн юм.	あいかわらずです。バトさんをお願いしたいんですが。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
70	Бат одоохондоо алга, гадагшаа гарсан.	バトは今いません、出かけましたよ。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
71	Аан тийм үү,  хэзээ ирэх бол?	ああそうですか。いつお戻りになりますか。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
72	10 цагийн үед ирэх байх, чи гар утас уруу нь залгахгүй юу?	１０時ごろに帰ってくると思います。携帯電話にかけてもらえませんか。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
73	Гар утасны дугаар нь хэд вэ?	携帯の番号は何番ですか。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
74	9917-0495. Хөөе! 	９９１７－０４９５です。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
75	Би чиний номыг Батад өгчихсөн шүү.	あのう、あなたの本はバトにもう渡しておきましたよ。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
76	За, баяртай.	わかりました、失礼します。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
77	Баяртай.	さようなら。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
78	Орж болох уу?	入ってもよろしいですか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
79	Ор! ор!	どうぞ。どうぞ。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
80	Та завтай байна уу?	いま、お時間、あいていますか？			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
81	Одоохондоо, зав муутай байна. 	いまは、ちょっと忙しいんですが。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
82	Та надтай уулзах гэсэн юм уу?	わたしに用ですか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
83	Тиймээ, би тантай ярих юм байгаа юмсан. 	えっと、ぼく、ちょっとおりいって話があるんですが。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
84	Тантай хэдийд уулзаж болох вэ?	いつならいいですか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
85	За, тэгвэл маргааш уулзах уу?	じゃ、あしたにしましょうか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
86	Тэгье, маргааш өглөө завтай байх уу?	そうしましょう。あしたの朝は、お時間がありますか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
87	Маргааш, бүтэн өдөржин ажилтай. Орой л зав гарна даа.	あしたは、一日中仕事が入っています。晩しかあいていませんね。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
88	За тэгвэл, орой хэдэн цагт боломжтой вэ?	それでは、晩の何時が都合がよろしいですか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
89	Ажил тарсны дараа ирэх үү?	仕事が終わってから来てくれますか。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
90	За тэгье, баяртай.	そうします。じゃあ、また。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
91	Баяртай.	では。			\N	dmod	mn07.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
92	Танайд сул өрөө бий юу?	空いている部屋はありますか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
93	Бий, 	あります。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
94	хэдэн хүний ямар өрөө танд хэрэгтэй вэ?	どんな部屋をご希望ですか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
95	Хоёр хүний, гудамж уруу харсан тагттай, онгоцтой өрөө авмаар байна.	二人部屋で通りに面していて、バルコニーがあって、バス付きがいいんですが。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
96	3-р давхарт болох уу?	三階でよろしいですか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
97	Болно, болно. 	いいですよ。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
98	Хоногт ямар үнэтэй вэ? 	一泊いくらですか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
99	Эхлээд өрөөг чинь үзэж болох уу?	先に部屋を見てもかまいませんか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
100	Хоногийн хөлс хоёр хүн 160000 төгрөг, өрөө үзэж бололгүй яахав.	もちろんご覧になってかまいません。一泊の料金はツインで１６万トゥグリグです。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
101	Өрөөний үнэнд өглөөний цайны үнэ орох уу?	朝食代は部屋代に含まれていますか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
102	Орно, орно. 	含まれています。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
103	За тэгвэл эхлээд үүнийг бөглөнө үү? 	じゃあ、まず、これにご記入ください			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
104	За, нм... ! Энэ хавьд ойрхон их дэлгүүр бий юу? 	はい、ええっと・・・この近くにデパートはありますか。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
105	Байгаа, та энэ газрын зургийг авна уу? 	あります。この地図をどうぞ。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
106	Үүн дээр бүгдийг нь тэмдэглэсэн байгаа.	ここになんでも載っています。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
107	Баярлалаа.	ありがとうございます。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
108	Зүгээр.	どういたしまして。			\N	dmod	mn08.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
109	Өнөөдөр хэн багш орох　вэ?	今日はどの先生の授業があるの。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
110	Түүхийн Бат багш орно. 	歴史のバト先生だよ。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
111	Багшийн хичээлд сууж байсан уу?	彼の授業は出たことある？			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
112	Сууж байсан, Бат багш жаахан сулхан дуутай шүү.	出たことはあるよ。バト先生はちょっと声が小さいね。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
113	Харин тийм, гэхдээ хичээл нь сонирхолтой байдаг.	うんそうだね。でも授業はおもしろいな。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
114	Би түүхийн хичээлд сонирхолгүй ч, Бат багш сонирхолтой заадаг.	わたし、歴史の勉強には関心ないんだけど、バト先生の教え方はおもしろいわ。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
115	Тиймээ, их сайхан заадаг багш.	そうだね、教え方はすごくうまい先生だ。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
116	Бат багш эрдмийн ямар зэрэг цолтой вэ?	バト先生は、どんな学位をもっていらっしゃるの。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
117	Доктор гэсэн байхаа.	博士だそうだよ。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
118	Багш ч оюутнуудад их нэр хүндтэй шүү.	先生って、みんなに尊敬されてるよね。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
119	Харин тийм, их сайн багш.	うんそうだね、とてもいい先生だ。			\N	dmod	mn09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
120	Шалгалтанд орсон уу?	試験を受けたの？			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
121	Шалгалт өгөөд гарч ирж байна.	試験、ちょうどおわったところなの。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
122	Юуны шалгалт өгсөн бэ?	何の試験を受けたの。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
123	Хоёр хэлний орчуулга. 	翻訳。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
124	Японоос монгол руу, монголоос япон луу орчуулах.	和文モ訳とモ文和訳よ。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
125	Сэдэв нь хүнд юм уу? Гайгүй юу?	難しいテーマだった？簡単だった？			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
126	Аа бас нилээн хэцүү юм байна. 	うん、かなり難しかったわね。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
128	Цагтаа багтааж дуусгасан уу? 	時間内に終わった？			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
129	Бичгээр үү, амаар уу?	筆記なの？口頭なの？			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
130	Бичгээр, цагтаа арай чүү л амжсан.	筆記よ。時間内になんとかできたわ。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
131	Шалгалтын дүн хэзээ гарах вэ?	試験結果はいつわかるの。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
132	Одоо 2 цагийн дараа энэ самбарт хадна гэсэн.	２時間後にこの掲示板に張り出されるんだって。			\N	dmod	mn10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
133	Баатар аа! 	バータルさん。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
134	Чи ямар мэргэжилтэй вэ? 	何のお仕事ですか。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
135	Би эмчийн мэргэжилтэй. 	医師です。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
136	Харин чи?	あなたは？			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
137	Би багш мэргэжилтэй. 	教師をしています。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
138	Чи хаана ажилладаг вэ? 	どちらにお勤めですか。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
139	Улсын нэгдсэн 2-р эмнэлэгт ажилладаг.	国立総合第二病院に勤務しています。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
140	Энэ ажлаа олон жил хийж байна уу?	お仕事してもう長いんですか。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
141	Бараг 15 жил болж байна.	１５年くらいになります。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
142	Долоо хоногт хэдэн өдөр ажилладаг вэ?	週何日勤務ですか。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
143	Таван өдөр.	５日です。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
144	Ажилдаа сонирхолтой юу?	お仕事は充実していますか。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
145	Их сонирхолтой.	とても面白いです。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
146	Харин зав их багатай.	でも、かなり忙しいです。			\N	dmod	mn11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
147	Хэдэн цаг болж байна вэ? 	何時かな。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
148	Хоёр цаг дөхөж байгаа байхаа.	２時近くだと思うけど。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
149	Яг хэд болж байна?	正確には何時？			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
150	Одоо 2 цаг 10 минут болж байна.	２時１０分だよ。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
151	Би вагоноосоо хоцрох нь байна шүү.	列車に遅れそうだよ。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
152	Хэдэн цагт явах вагон бэ?	何時発の列車なの。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
153	Хоёр цаг 30 минутанд хөдлөнө.	２時２０分発だよ。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
154	Таксинд суухгүй бол цагтаа амжихгүйнээ, хурдлаарай!	タクシーに乗らないと間に合わないわ。急ぎましょう。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
155	За тэгье. Жаахан эртхэн гэрээсээ гарахгүй яасан юм бэ?	うん。どうしてもう少し早くうちを出てこなかったの。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
156	За за, тэр яахав. Наад таксинд чинь сууя.	まあ、いいじゃない。そのタクシーに乗りましょう。			\N	dmod	mn12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
157	Сайн байцгаана уу?	みなさん、こんにちは。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
158	Сайн, сайн байна уу?	こんにちは。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
159	Өнөөдөр шинэ хичээл үзнэ.	きょうは新しい課をやります。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
160	Номын хэддүгээр хуудас вэ? Багшаа!	何ページですか。先生!			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
161	33-р хуудас. 	３３ページです。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
163	Багшаа, орчуулах юм уу?	先生、訳すんですか。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
164	Тийм, энэ сэдвээ орчуулахаасаа өмнө, самбар дахь шинэ үгийг бичиж аваарай!	そうです。でも、その文章を訳す前に、黒板の新出単語を書き写してください。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
165	Энэ сэдвийн холбогдолтой шинэ үгс үү?	このテーマと関係のある新しい単語ですか。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
166	Тиймээ, гэртээ сайн давтаад цээжлээрэй!	そうです。うちでしっかり復習して暗記してください。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
167	За, ойлголоо.	はい、わかりました。			\N	dmod	mn13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
168	Ууганаа, чи маргааш нүүх байхаа. 	あなた、あした引っ越すんでしょ。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
169	Ирж туслалцах уу?	手伝いましょうか。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
170	Тэг тэг, юун сайн юм бэ!	おねがい。助かるよ。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
171	Юмаа янзалж боосон уу? 	荷物は梱包したの？			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
172	Хэдэн цагт нүүх вэ?	何時に引っ越すの。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
173	Янзалсан. 	まとめたよ。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
174	10-н цагийн үед ирэхэд болно.	１０時ごろ来てくれればいいよ。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
175	Өөр хүн ирж нүүлгэлцэх үү?	他の人も、手伝いにくるの？			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
176	Батаа, Насан хоёр ирнэ гэсэн.	バターとナサンも来るって言ってた。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
177	Юугаар нүүх юм бэ?	どうやって荷物を運ぶの。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
178	Найзынхаа жижиг машинаар.	友達の軽自動車で。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
179	Үдийн хоолоо яах вэ?	昼ごはんはどうするの。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
180	Харин ээ. 	そうだね。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
181	Гуанзанд хооллодог юм билүү гэж бодож байна.	食堂で食べようかなって思っているけど。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
182	Тэгвэл би үдийн хоол цай хийгээд аваад ирэх үү?	それなら、わたしが昼食を作って持って来ようか。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
183	Өө, тэг тэг. 	うん、そうしてくれる。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
184	Их баярлалаа	すまないね。			\N	dmod	mn14.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[2]	\N	\N	1
185	Та ямар хэлээр ярьдаг вэ?	あなたは、何語が話せますか。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
186	Би орос, монгол хэлээр ярьдаг.	ロシア語とモンゴル語が話せます。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
187	Та япон хэл мэдэх үү? 	日本語はわかりますか。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
188	Японоор жаахан ярьж чадна.	日本語は少し話せます。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
189	Та оросоор тун сайн ярьж байна. 	ロシア語がとってもお上手ですね。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
190	Хаана орос хэл сурсан бэ?	どこでロシア語を習ったんですか。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
191	Москвад орос хэл сурч байсан.	モスクワで勉強しました。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
192	Би оросоор ойлгодог мөртлөө, харин өөрөө ярих гэхээр жаахан хэцүү байдаг юм.	わたしはロシア語はわかりますが、自分で話すのは、ちょっとたいへんです。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
193	Аргагүй байхаа, танд оросоор ярих орчин байхгүй болохоор тэр.	むりもないと思います。ロシア語をしゃべる環境にないわけですから。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
194	Харин тиймээ. Би голдуу оросоор ном л уншдаг юм. 	たしかにそうですね。わたしは、ロシア語は本を読むだけなんです。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
195	Орос хүнтэй яриад байхад ярьдаг болчихноо.	ロシア人といつも話をしていれば、話せるようになりますよ。			\N	dmod	mn15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
196	Уучлаарай, жимс зардаг тасаг хаана вэ?	すみません果物売り場はどこですか。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
197	Баруун гар талд чинь байна.	お客さんの右手にあります。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
198	Та сагстай зүйлээ энд тавина уу?	かごをここにおいて下さい。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
199	Энэ өнөөдрийн шинэ жимс үү?	これは今日入荷した果物ですか。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
200	Тиймээ. Их сайхан амттай шүү.	そうです。とてもおいしいですよ。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
201	За.., хэдэн төгрөг болж байна вэ?	はい..、いくらですか。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
202	Нийтдээ 600 төгрөг болж байна. 	全部で600トゥグリグになります。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
204	Та хариулт мөнгөө, тасалбартайгаа авна уу? Баярлалаа. 	おつりとレシートをどうぞ。ありがとうございました。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
205	Дахин манай дэлгүүрээр ирж үйлчлүүлээрэй!	またお越しくださいませ。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
206	Баярлалаа. Баяртай.	どうも。じゃあまた。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
207	Өнөөдөр тэнгэр ямар байна вэ?	きょうは天気はどうですか？			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
208	Өнөө өглөө бүрхэг байсан.	今朝は曇っていました。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
209	Одоо тэнгэр цэлмэг байна.	今は晴れています。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
210	Гадаа хэдэн хэм байна вэ?	外の気温は何度ですか。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
211	Барагцаагаар 15 орчим хэм байх шиг байна. 	１５度くらいみたいです。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
212	Өнөөдөр дулаахан байна.	暖かいですね。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
213	Цаг агаарын мэдээ сонссон уу? 	天気予報を聞きましたか。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
214	Маргааш тэнгэр ямар байна гэсэн бэ?	あしたの天気はどうなるって言ってましたか。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
215	Маргаашнаас цас орж хүйтрэнэ гэсэн шүү. 	あしたから雪が降って、寒くなるそうです。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
216	Монголын цаг агаар ямар вэ?	モンゴルの気候はどんなですか。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
217	Монголд жилийн дөрвөн улиралтай.	モンゴルには四季があります。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
218	Өвөлдөө хүйтэн, зундаа дулаан. 	冬は寒くて、夏は暖かいです。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
219	Танайд хамгийн хүйтэн сар хэддүгээр сар вэ?	モンゴルでいちばん寒い月は何月ですか。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
220	Нэгдүгээр сард цас их орж, их хүйтэн байдаг.	一月は雪がたくさん降って、とても寒いです。			\N	dmod	mn17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
221	Та хаана суудаг вэ?	どこに住んでいるんですか。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
222	Би 3-р хороололд суудаг.	わたしは、第３区に住んでいます。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
223	Танайх эндээс хол уу?	お宅は、ここから遠いですか。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
224	Эндээс автобусаар таван буудал яваад, автобусны буудлаасаа гурван минут хиртэй алхдаг.	ここから、バスで５つ目の停留所で、そこから、３分くらい歩きます。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
225	Монголчууд гэрт амьдардаг байхаа?	モンゴルの人はゲルに住んでいるんでしょ？			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
226	Тиймээ. Хотдоо голдуу орон сууцанд суудаг, харин малчид маань монгол гэрт амьдардаг.	ええ、都市では、だいたいアパートに住んでいますが、遊牧民は、モンゴル風のゲルで暮らしています。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
227	Гэрт даардаггүй юу?	ゲルの中は寒くないんですか？			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
228	Гэрт зундаа сэрүүхэн, өвөлдөө дулаахан байдаг.	ゲルは、夏は涼しく、冬は暖かいです。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
229	Ямар сонин юм бэ? 	不思議ですね。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
230	Гэрт орж үзэхсэн.	ゲルに入ってみたいですね。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
231	Аа, энэ чинь сайхан санаа байна.	ああ、いい考えですね。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
232	Би таныг маргааш монгол айлд оруулж үзүүлье.	あした、あなたをモンゴル風のゲルに連れていってあげましょう。			\N	dmod	mn18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
233	Чи чөлөөт цагаа яаж өнгөрөөдөг вэ? 	暇な時間は何をして過ごしていますか。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
234	Би голдуу уран зохиолын ном уншиж, цуглуулгаа үздэг.	たいてい小説を読んだり、コレクションを眺めたりしています。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
235	Чи юу сонирхдог вэ?	何に興味があるのですか。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
236	Би марк цуглуулдаг бас байгалийн гэрэл зураг их сонирхдог.	切手収集と風景写真に興味があります。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
237	Аа, тийм үү? Чи зургуудаа надад үзүүлж болох уу?	ああ、そうなんですか。その写真を見せてもらっていいですか。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
238	Бололгүй яах вэ!  	もちろん、いいですよ。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
239	Чи хөгжим сонирхдог уу?	音楽は関心がありますか。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
240	Би үндэсний хөгжимд дуртай шүү. 	私は民族音楽が好きです。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
241	Бас сонгодог хөгжим сонсдог.	それにクラシックも聞きます。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
242	Ямар хөгжим тоглож чадах вэ?	何か楽器を演奏できますか。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
243	Би морин хуураар хуурдаж чадна. Хоёрхон чавхдастай сонин хөгжим шүү.	馬頭琴が弾けます。弦が２本しかないユニークな楽器なんです。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
244	Тийм шүү! 	すてきですね。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
245	Дараа би чиний морин хуурыг үзнээ.	こんどあなたの馬頭琴を見たいですね。			\N	dmod	mn19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
246	Мөнхөө, чи ямар спортод дуртай вэ?	ムンホーさん、どんなスポーツが好きですか。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
247	Би үндэсний бөх, японы сумо үзэх дуртай.	ぼくは、モンゴルと日本の相撲を観るのが好きです。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
248	Чи өөрөө барилддаг уу?	自分では相撲をやりますか。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
249	Үгүй. Харин бага байхдаа найзуудтайгаа барилддаг байлаа. 	いいえ。でも小さいときは友達とやっていました。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
250	Одоо бол харин бөх сонирхогч.	でも今は観るだけのファンです。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
251	Монгол бөхийн барилдаан үзэх юмсан.	モンゴル相撲を観たいですね。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
252	Зун Монголд очвол үзэж болно шүү дээ.	夏にモンゴルに行ったら観ることができますよ。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
253	Энэ зун бөхийн барилдаан хэзээ болох вэ? 	この夏は、相撲大会はいつありますか。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
254	7-р сарын 11-нд Улсын Үндэсний Баяр наадамаар бөх барилдаж, морь уралдаж, сур харвадаг.	７月１１日に、全国ナーダム（民族スポーツ）大会で、相撲と馬と弓の競技をやります。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
255	Сонирхолтой байхаа? 	面白いんでしょうね。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
256	Тийм шүү. Манай монголчууд цөмөөрөө бөхийн барилдаан үзэх дуртай.	そうですよ。モンゴル人はみんな、相撲観戦が好きなんですよ。			\N	dmod	mn20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
257	Би энэ жороор эм авах гэсэн юм. Танайд энэ эм байна уу?	この処方箋で薬をいただきたいんですが。こちらには、この薬はありますか。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
258	Алив үзье.  Энэ эм байгаа.	どれどれ拝見しましょう。この薬ならあります。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
259	Энэ эмийг яаж уух вэ? Хоолны дараа юу?	この薬の飲み方は？食後ですか。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
260	Өдөрт гурван удаа хоол идэхээсээ  арван минутын өмнө ууна.	１日３回、食事の１０分前に飲んでください。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
261	Хэд хоног уух вэ?	何日間飲めばいいんですか。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
262	Бүтэн долоо хоног тасралтгүй уугаарай! Энэ эмийн хэрэглэх заавар энэ байна.	まる一週間ずっと飲んでください。この薬の服用説明書は、こちらになります。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
263	За. Надад бас ходоодны эм өгнө үү?	はい。それから胃の薬もいただけませんか。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
264	Уучлаарай, эмчийн жороор өгдөг юм.	すみません。お医者さんの処方箋によってお出ししているんです。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
265	Аа, тийм үү. Баярлалаа.	あっ、そうですか。ありがとうございます。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
266	За баяртай! Түргэн эдгээрэй!	では、お大事に。			\N	dmod	mn21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
268	Би гадаад хэлний их сургуульд сурдаг.Манай сургууль тэр харагдаж байна! 	外国語大学よ。あそこが学校よ。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
554	Миний нагац ах жолооч.	私の（母方の）おじは運転手です。	\N		\N	vmod	\N	\N	\N	0	1
269	Аан! Тэр өндөр хүрэн барилга уу? Ямар хэл сурч байна даа? 	あぁ、あの高い茶色の建物？何語を勉強しているの。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
270	Тийм, би одоо япон, франц хэл сурч байна. 	うん。今は、日本語とフランス語をやってるの。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
271	Япон хэл ямархуу байна даа? 	日本語の勉強はどう。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
272	Ханз их хэцүү шүү. 	漢字がすごくむずかしいわ。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
273	Хэзээ сургуулиа төгсөх вэ? 	卒業はいつなの。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
274	Нэг жилийн дараа их сургуулиа төгсөнө. 	一年後に卒業だよ。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
275	Төгсөхдөө улсын шалгалт өгч, дипломын ажил бичнэ биз дээ? 	卒業するときは、国家試験をうけたり、卒業論文を書いたりするんでしょ？			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
276	Өө тэгнээ, төгсөхдөө баклавар зэрэгтэй төгсөнө. 	うん、そうよ。卒業すると、学士号がもらえるわ。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
277	Чамайг Франц явах гэж байгааг сонслоо. Үнэн юм уу? 	あなたがフランスに行くって聞いたけど、ほんとう？			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
278	Тиймээ, би Францад суралцахаар явах гэж байгаа. 	そうだよ。ぼく、フランスに留学することになったんだ。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
279	Суралцахаар аа? Баяр хүргэе! Хэзээ явах вэ? 	留学？おめでとう！いつ出発するの？			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
280	Баярлалаа. Би долоо хоногийн дараа явна. 	ありがとう。一週間後に出発だよ。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
281	Ямар сургуульд сурах юм бэ? Ямар гоё юм бэ! 	どこの学校で勉強するの？いいわね。 			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
283	Хэдэн жил суралцах вэ? 	何年留学するの。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
284	Эхний нэг жил хэлний бэлтгэл хийчихээд дараа нь хуулийн чиглэлээр 4-н жил суралцана. 	最初の一年は語学の準備コースで、そのあと、法律の専門コースで４年間勉強するんだ。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
285	Суралцах хугацаандаа оюутны тэтгэлэгтэй юу? Хаана амьдрах вэ? 	留学中は奨学金が出るの。どこに住むの。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
286	Сар бүр тэтгэлэг авч оюутны байранд амьдрана. 	毎月、奨学金をもらって、学生寮に住むんだ。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
287	Мундаг юм аа! За тэгээд сайн суралцаарай! 	すごいわねぇ。それじゃあ、勉強がんばってね。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
288	Баярлалаа. Хичээнээ! 	ありがとう。がんばるよ。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
289	Та гэр бүлтэй юу? 	結婚していらっしゃるんですか。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
290	Гэр бүлтэй. 	結婚しています。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
291	Танайх ам бүл хэд вэ? 	ご家族は何人ですか。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
292	Бид гурвуулаа хоёр өрөө байранд амьдардаг. 	うちは３人で、二部屋のマンションに住んでいます。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
293	Хүүхэдтэй юу? 	お子さんはいらっしゃるの？			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
294	Зургаан настай  нэг хүүтэй, ирэх жил сургуульд орно. 	６歳の息子です。来年、学校にあがります。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
295	Та гэрлээд удаж байна уу? 	結婚されてもう長いんですか。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
296	Найман жил гаруй болж байна. Харин чи? 	８年あまりになります。ところであなたは？			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
297	Би охинтойгоо хамт амьдардаг. Манай охин танай хүүгээс 2 насаар дүү юм байна. 	わたしは娘といっしょに住んでいます。うちの娘はおたくの坊ちゃんより２歳年下なんですね。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
299	Өнөөдөр аль ангид хичээл орох вэ? 	きょうは、どの教室で授業があるの？			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
300	102 номерт.	102号室だよ。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
301	Өчигдөр хичээл орсон уу? Би ирж чадаагүй. 	きのう授業あった？ぼく行けなかった。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
302	Орсон, чиний гэрийн даалгаварыг би авсан шүү. 	あったよ。あなたの分の宿題を、受け取っておいたわ。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
303	Өө тийм үү. Баярлалаа. Хэддүгээр хичээлийнх вэ? 	そう。ありがとう。第何課の。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
305	Өнөөдөр номын санд хамт даалгавараа хийх үү? 	きょうは図書館でいっしょに宿題やる？			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
306	За байз. Би хичээлийн дараа багштай уулзаж юм асууна. Амжихгүй байхаа. 	えーっと、放課後、先生のところに行って、ききたいことがあるの。時間ないと思うわ。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
307	За за, тэгвэл яахав. Баяртай. 	あっそう、じゃあいいよ。またね。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
308	За, баяртай. 	じゃあ、また。			\N	dmod	mn25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
309	Ойрд театрт юу гарч байгаа бол? 	いま劇場では何をやってるんだろう。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
310	Мэдэхгүй ээ! Хамтдаа явж зарлал үзэх үү? 	わからないわ。一緒にプログラムを見ましょうか。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
311	Тэгье. Би маргааш орой концерт үзмээр байна. Хоёулаа үзэх үү? 	うん。ぼく、明日の晩、コンサートに行きたいんだ。一緒に観ない。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
312	Ойрдоо би ажил ихтэй болохоор хамтдаа үзэж чадахгүй нь. 	この頃、仕事がいっぱいだから、一緒には行けないわ。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
314	Билетийг нь одоо авахгүй бол маргааш дуусчих байх шүү. Одоо билетээ авсан дээр байхаа. 	いいわ。でもチケットは、いま手に入れないと、明日は売切れてしまうわ。いま買ったほうがいいでしょうよ。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
315	Харин тийм, билет нь их үнэтэй юм байна гэсэн. 	うん、そうだ。チケット、とても高いんだそうだ。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
316	Тоглолтын билет ямар үнэтэй гэнэ? 	チケット、いくらだって。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
317	8000 төгрөг гэсэн. 	８０００トゥグリグだそうだよ。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
318	Жоохон үнэтэй юм аа. 	ちょっと高いわねぇ。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
319	Гэхдээ их гоё болж байна гэсэн, өчигдөр манай ах үзсэн гэсэн. 	でも、すごく素晴らしいそうだ。きのううちの兄貴が観たんだって。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
320	Уучлаарай, Монгол Улсын Их Сургууль хаана байдаг вэ? 	すみません、モンゴル国立大学はどこにあるんですか。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
321	Хотын төвд байдаг. 	市内の真ん中にあります。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
322	Би яаж очих вэ? 	どうやって行くのがいいですか。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
323	Та автобусаар явж болно, гэхдээ таксигаар явбал арай хурдан очно. 	バスで行けます。でもタクシーで行くと少し早く着きます。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
324	Эндээс хол уу ойрхон уу? 	ここから遠いですか、近いですか。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
325	Алхвал нилээн хол шүү. 	歩くとかなり遠いですよ。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
326	Би гадаадын хүн. Зам мэдэхгүй, яаж явахыг зааж өгөөч! 	わたしは外国人です。道がわかりませんので、行き方を教えてください。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
327	Та, энэ автобусанд суугаад таван буудал яваад буухад байгаа. 	このバスに乗って、５つ目の停留所で降りるとあります。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
328	Автобусны билетээ хаанаас авах вэ?	バスの切符はどこで買うんですか。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
329	Автобусан дотор билет таслагч бий.	バスの中に車掌さんがいます。			\N	dmod	mn27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
330	Чи аялах дуртай юу? 	旅行は好き。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
331	Тийм ээ, дуртай шүү. 	ええ、好きよ。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
332	Гадаадад аялаж үзсэн үү? 	海外旅行したことある。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
333	Би нилээд олон орноор явж үзсэн дээ. Жишээ нь: Америк, Герман, Франц, Япон гэх мэт улс орнуудаар.	けっこういろんな国に行ったわ。たとえばアメリカやドイツやフランスや日本とかの国にね。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
334	Энэ өвлийн амралтаараа аялалд явах уу? 	こんどの冬休みには旅行にでかけるの。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
335	Найз нартайгаа ойрхон ууланд явж цанаар гулгана. 	友達と近くの山に行って、スキーするのよ。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
336	Хэдийд, юугаар явах вэ? 	いつ行くの。どうやって行くの。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
337	Ирэх сарын 15-нд, машинаар явна. 	来月の１５日に車で行くのよ。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
338	Чадвал би чамайг гаргаж өгнө өө. 	できれば見送りにいくよ。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
339	Баярлалаа. 	ありがとう。			\N	dmod	mn28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
340	Би япон-монгол толь, японы түүхийн ном авах гэсэн юм. 	あのう、日・蒙辞典と日本史の本がほしいんですが。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
341	Хэлний ном энэ тавиурт, түүхийн ном тэр тавиурт байна. 	語学の本はこの棚に、歴史の本はあの棚にあります。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
342	Уучлаарай, би ханз сайн уншиж чадахгүй болохоор та надад туслана  уу? 	すみません、わたし、漢字が読めないので、ちょっとお願いします。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
344	Японы түүхийн ямар ном авах гэсэн юм бэ? 	日本史のどんな本がほしいんですか。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
345	Уншихад амархан үгээр бичсэн ном байвал зүгээр. 	読みやすいことばで書いてある本があればいいんですが。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
346	Японы аль үеийн түүхийн ном бэ? 	日本のどの時代の歴史の本ですか？			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
347	Японы Мэйжигийн үеийн түүхийн ном.	明治時代の歴史の本です。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
348	За тэгвэл энэ хирагана, катаканагаар бичсэн хуучны товч түүх байна. Та үз дээ?	それなら、これはひらがなとカタカナで書いてある古い版の簡略史です。ごらんください。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
349	Хуучныхаа? за яахав тэгэхдээ болно. Танд их баярлалаа. 	古い版ですか。うーん、まあ、いいでしょう。どうもありがとうございます。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
350	Уучлаарай, ном гэрээр авч болох уу? 	すみません。本、借りられますか。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
351	Болно, болно. 	借りられますよ。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
352	Ном гэрээр авахад ямар бичиг баримт шаардлагатай вэ? 	本を借りるには、どんな手続きが必要ですか。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
353	Таны оюутны үнэмлэх хэрэгтэй. 	学生証が要ります。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
354	Хэдэн ном, хэд хоногийн хугацаатай авч болох вэ? 	何冊、何日間借りることができますか。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
355	Нэг удаадаа 10 ном 30 хоногийн хугацаатай авч болно. 	１回に、10冊、30日間借りられます。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
356	За тэгвэл, энэ 3 номыг гэрээр авъя. 	それでは、この3冊を借ります。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
357	Та оюутны үнэмлэхээ өгнө үү? 	学生証をみせてください。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
358	За, энэ байна. 	はい、これです。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
359	За, боллоо. Та номоо авч болно. 	はい、結構です。もういいですよ。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
360	Монголын уран зохиолын ном хаана байдаг вэ? 	モンゴル文学の本はどこにありますか。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
361	4-р давхарын баруун жигүүрт монгол номууд бий. 	４階の西側にモンゴルの本があります。			\N	dmod	mn30.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
362	Мөнхөө! Маргааш чи миний төрсөн өдөрт ирнэ биз дээ? 	ムンホー君、あした、わたしの誕生日に来てくれるでしょ？			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
363	Маргааш билүү? За байз... Би маргааш ер нь завтай. Хэдэн цагт вэ? 	あしただっけ？ええと…ぼくはあしたは、まあ時間があるよ。何時から？			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
364	7 цаг 30 минутанд ирэхэд  л болно. Эхлээд хоол идчихээд дараа нь дисконд орно гэж бодож байгаа. 	7時30分に来てくれればいいよ。はじめに食事をして、そのあと、ディスコに行こうと思ってるの。			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
365	Аа! Тийм үү? Ямар гоё юм бэ! Би очилгүй яахав. Өөр хэн хэн ирэх вэ? 	あっ、そう。それはいいね。もちろん行くよ。ほかに誰と誰が来るの？			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
366	Миний найзуудаас Батаас бусад нь бүгд ирнэ гэсэн. 	わたしの友だちでは、バト君以外はみんな来るそうよ。			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
367	Аа, тийм үү! Чи төрсөн өдрийн бэлгэнд юу авмаар байна вэ? 	あっ、そうなの。誕生日のプレゼントは何がいい？			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
368	За, тэр яахав. Чи өөрөө мэд! Харин чи битгий хоцроорой! 	何でもいいわ。あなた自分で決めて！じゃあ遅れないでね。			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
550	Ер нь 800 мянгаас дээш хүн амтай хотод метро байгуулдаг. 	一般に、人口80万以上の都市で地下鉄が作られます。	\N		\N	vmod	\N	\N	\N	0	1
369	За, за, би шинэ СD-нүүдээ авчрах уу? Яахав? 	うん。ぼく、新しいCDをもって来よう。どう？			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
370	Дисконд орох юм чинь хэрэггүй биз дээ. 	ディスコに行くんだもの。必要ないんじゃないの。			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
372	Та миний цагийг үзэж өгнө үү? 	ちょっとこの時計を見ていただけませんか。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
373	Таны цаг яагаад байна вэ? 	この時計、どうされたんですか。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
374	Миний цаг заримдаа хоцроод байх юм. Би хэд хэдэн удаа унагачихсан юм. 	ときどき遅れるんですよ。何回か落としてしまったんです。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
375	Энэ цагийг засах хэрэгтэй. 	これは修理しないといけません。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
376	Хэзээ засаж дуусах вэ? 	修理は、いつ終わりますか。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
377	Маргааш болох уу? 	あしたでよろしいですか。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
378	Уучлаарай, одоохон  засаж өгөөч! 	すみませんが、今すぐ直してください。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
379	Болно, гэхдээ яаралтай засварын нэмэгдэл мөнгө төлөх болно шүү дээ. 	できますが、急ぎの修理の場合は、追加料金を払っていただくことになります。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
380	Өө, тэгэлгүй яахав. Хир удах бол? 	ええ、ぜんぜんかまいません。時間はどのくらいかかるんでしょう？			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
381	Та хорин минутын дараа авч болно. 	20分後に、お渡しできます。			\N	dmod	mn33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
382	Та үсэндээ ямар үйлчилгээ хийлгэх вэ? 	どのような整髪をいたしましょうか。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
383	Би үсээ засуулах гэсэн юм.  	カットしていただきたいんですが。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
384	Та үсээ яаж засуулах вэ? 	どのようにカットしましょうか。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
385	Битгий нэг их богиносгоорой! 	あまり短くは切らないでください。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
386	Энэ засалт танд таалагдаж байна уу? 	こんな風でいいですか。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
387	Энэ ер болж байна, гэхдээ ар талаас нь сайн нимгэлчихээрэй! 	これでOKです。でも後ろの方を、もう少し、すいてください。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
388	Дараа нь үсээ угаалгах уу? 	このあと洗髪なさいますか。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
389	Угаалгая! 	お願いします。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
390	Үсний тос түрхэх үү?	整髪料をつけましょうか。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
391	Үгүй ээ, хэрэггүй.	いいえ、いいです。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
392	За, ойлголоо.	はい。わかりました。			\N	dmod	mn34.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
393	Би мөнгө солих гэсэн юм. 	換金したいのですが。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
394	Ямар валют вэ? 	どちらの国のお金ですか。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
395	Японы иен солиход ямар ханштай вэ? 	日本の円の交換レートはどうなっていますか。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
396	Өнөөдөр 1 иен есөн төгрөг гучин мөнгөний ханштай байна. 	今日は、１円は９．３トゥグリグです。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
397	10000 иен хэдэн төгрөг болох вэ? 	１万円は何トゥグリグになりますか。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
398	За байз, 93000 төгрөг болж байна. Бүгдийг нь бүхэл мөнгөөр солих хэрэгтэй юу? 	ええっと、９万３０００トゥグリグになります。大きなお札にしたほうがいいですか。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
399	Үгүйээ, хагасыг нь задгай мөнгөөр авъя. 	いいえ、半分は小さなお札でお願いします。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
400	За, та тоолж аваарай! 	承知しました。お確かめください。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
401	За тэгье, баярлалаа.	はい、ありがとうございました。			\N	dmod	mn35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
402	Энэ сайхан хоолтой газар шүү.	ここの料理はおいしいよね。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
403	Харин тийм ээ.	うん、そうだね。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
404	За, чи ямар хоол захиалах вэ?  	ええっと、何にする。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
551	Манай ах хоол хийхдээ муу.	兄は料理が下手です。	\N		\N	vmod	\N	\N	\N	0	1
405	Би их өлсөж байна. Ногоотой шөл, бууз иднээ. Харин чи?	すごくおなかがすいているんだ。野菜スープとボーズ（餃子）にするよ。きみは。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
406	За байз, юу иддэг юм билээ...  Чи юу уух вэ? 	うーん、わたし何を食べようかしら・・・あなたは何を飲む。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
407	Цай уунаа. 	お茶にするよ。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
408	Наад хоолны цэсээ аваад өг дөө. 	メニューを取ってくれない。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
409	За, май. 	はい、どうぞ。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
410	Өнөөдөр энэ шинэ хоолыг идэж үзнээ. Өчигдөр Бат намайг энд хоолонд урьсан. 	今日はこの新メニューにするわ。昨日、バトが私にここでご馳走してくれたのよ。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
411	Өө, тийм үү. Үйлчлэгчээ, хоол захиалъя! 	へえそう。すみません！注文をお願いします。			\N	dmod	mn36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
412	Чи яагаа вэ? 	どうしたの。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
413	Миний бие тааруухан байна. Энэ хавьд эмч бий юу? 	調子がよくないの。近くにお医者さんがあったっけ。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
414	Яг хаана нь, юу өвдөөд байна вэ? 	どこが痛いの。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
415	Толгой эргээд гэдэс өвдөөд байна. 	頭がふらふらして、おなかがとても痛いの。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
416	Тэгвэл эмчид үзүүлэх хэрэгтэй шүү. Би эмч дуудъя! 	それならお医者さんにみてもらったほうがいいよ。お医者さんを呼んでこようか。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
417	Хэрэггүй, харин чи намайг эмчид шууд хүргээд өгнө үү? 	そうじゃなくて、お医者さんに連れて行ってよ。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
418	Тэгэлгүй яахав. Хамгийн ойрхон эмнэлэг рүү явъя! 	もちろん。いちばん近くの病院に行こう。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
419	Баярлалаа. Харин яаж явах вэ? 	ありがとう。どうやって行くの。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
420	Би одоохон такси дуудаадхъя! 	すぐにタクシーを呼ぼう。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
421	За тэг, баярлалаа. 	そうして。ありがとう。			\N	dmod	mn37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
422	Хаашаа явах вэ? 	どちらまでですか。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
423	Намайг ”Буянт-Ухаа” нисэх онгоцны буудал хүргэж өгнө үү? 	ボヤント・オハー空港までお願いします。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
424	За, тэгье.  	承知しました。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
425	Буянт-Ухаа хүртэл ойролцоогоор хэдэн километр бол? 	ボヤント・オハー空港までだいたい何キロメートルくらいでしょう。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
426	Арван таван километр орчим. 	約15キロです。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
427	Хэдэн минут явах вэ? 	何分かかりますか。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
428	Арван минут явна. 	10分です。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
429	Энд түр зогсооч! Би дэлгүүрээс ундаа аваадхъя.	(店の前に車をとめる。)ここでちょっと止まってください。ちょっと店で飲み物を買ってきますから。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
430	За,тэгье. Хүлээж байя. 	はい、わかりました。お待ちしています。			\N	dmod	mn38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
431	Уучлаарай. Тэр компьютерыг хэрэглэж болох уу? 	すみません、このコンピュータを使ってもいいですか。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
432	Аа, та е-mail шалгах юм уу? 	えっと、ｅ-メールをチェックされるんですか。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
433	Тиймээ, би е-mail бичиж, шалгах гэсэн юм. 	はい、ｅ-メールを書いたり、チェックしたりしたいんですが。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
434	За тэгвэл, энэ компьютерыг хэрэглэнэ үү? 	それなら、このコンピュータをご利用ください。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
435	Өө, баярлалаа. Интернетэд яаж холбогдох вэ? 	はい、どうも。インターネットへの接続のしかたは？			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
436	Энэ дээр дараад интернетэд холбогдтол хүлээнэ үү? 	このキーを押して、インターネットにつながるまでお待ちください。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
437	Япон хэлээр е-mail бичмээр байна. Яах вэ? 	日本語でｅ-メールを書きたいんですが、やり方は？			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
552	Энэ муухай цүнх хэнийх вэ?	この汚いカバンは誰のですか。	\N		\N	vmod	\N	\N	\N	0	1
438	Та энэ товчийг дараад бичих хэлээ сонгож болно. 	これを押していただくと、入力する言語が選択できます。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
439	Баярлалаа. 	どうも。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
440	Зүгээр, зүгээр. 	いえ、いえ。			\N	dmod	mn39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
441	Сайн байна уу? сайн явж ирэв үү? 	こんにちは。ようこそ。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
442	Сайн, сайн явж ирлээ. 	どうも。無事に着きました。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
443	Та Сайто гуай юу?	斉藤さんでいらっしゃいますか。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
444	Тиймээ, миний нэр Сайто. 	はい、斉藤と申します。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
445	Танилцъя, миний нэр Үнэнбат. Би таныг угтаж авахаар ирлээ.	はじめまして。わたくし、ウネンバトです。あなたをお迎えに参りました。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
446	Баярлалаа,тантай  танилцсандаа баяртай байна. 	ありがとうございます。お目にかかれて光栄です。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
447	Би ч гэсэн баяртай байна. Өнөөдөр би таныг гэр бүлийнхэнтэйгээ танилцуулнаа.  	こちらこそ。きょう斉藤さんにうちの家族をご紹介します。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
448	Аа, за тэгээрэй. 	あ、お願いします。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
449	Та ачаагаа авсан уу? 	お荷物は受け取られましたか。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
450	Одоо гарч ирэх ёстой. 	もう出て来るはずです。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
451	За тэгвэл жаахан хүлээх үү? 	じゃあ，そういうことでしたら少し待ちますか。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
452	За, тэгье. 	はい、そうしましょう。			\N	dmod	mn40.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
453	Аав чинь түүхийн багш юм уу?	君のお父さんは歴史の先生なの？	\N		\N	vmod	\N	\N	\N	0	1
454	Манай аав аймгийн арслан цолтой хүн байж билээ.	父はアイマグのアルスランの称号を持っていました。	\N		\N	vmod	\N	\N	\N	0	1
455	Түүний аав ээж, ах дүүтэй нь бид их ойр дотно байдаг.	彼の両親や兄弟とはとても親しいんですよ。	\N		\N	vmod	\N	\N	\N	0	1
456	Миний авга ах эмч.	私の（父方の）おじは医者です。	\N		\N	vmod	\N	\N	\N	0	1
457	Эрэгтэй хүн олны дунд явахдаа индүүдээгүй бохир нусны алчуур гаргаж хэрэглэвэл соёлч бус байдлын илрэл гэж үздэг юм.	男性が人前でアイロンのかかっていない汚いハンカチを取り出して使えば、洗練されていない証と見なされます。	\N		\N	vmod	\N	\N	\N	0	1
458	Амтгүй их хоолноос амттай бага хоол нь дээр.	まずい料理をたくさん食べるよりおいしい料理を少しだけ食べた方がいい。	\N		\N	vmod	\N	\N	\N	0	1
459	Төмсийг амттай болгохын тулд түүхий төмсөө шарахын өмнө 2—3 минут халуун усанд байлгана.	じゃがいもをおいしくするために、焼く前に生のじゃがいもを２－３分お湯につけます。	\N		\N	vmod	\N	\N	\N	0	1
460	Бид хоёрыг ажлаа дуусахад шоколад, зөгийн бал,  ёотон гээд л дандаа амттай юм бэлдээд тавьсан байна.	私たち2人が仕事を終えると、チョコレート、蜂蜜、角砂糖など甘いものばかりが用意されていました。	\N		\N	vmod	\N	\N	\N	0	1
461	Ноднин шинээр Герман, Франц хэлний анги нээв. 	昨年新たに、ドイツ語、フランス語クラスを開設しました。	\N		\N	vmod	\N	\N	\N	0	1
462	Манай ээж англи хэлтэй.	母は英語がわかります。	\N		\N	vmod	\N	\N	\N	0	1
463	Би 1985 оны аравдугаар сарын 15-нд төрсөн.	私は1985年10月１５日に生まれました。	\N		\N	vmod	\N	\N	\N	0	1
464	Таныг эмнэлгээс гаргах арай болоогүй шүү.	まだ退院させられませんよ。	\N		\N	vmod	\N	\N	\N	0	1
465	Ер нь арван нэгдүгээр сард цас ордог уу?	11月には雪は降りますか？	\N		\N	vmod	\N	\N	\N	0	1
466	Арван хоёрдугаар сарын 24-ний орой энд уулзацгаая.	12月24日の晩、ここで会いましょう。	\N		\N	vmod	\N	\N	\N	0	1
467	Ханан дээрх бичээсийг бушуухан арилга.	壁の落書きをすぐに消しなさい。	\N		\N	vmod	\N	\N	\N	0	1
468	Архи хүний биед муу нөлөөтэй.	酒は人体に悪影響を及ぼします。	\N		\N	vmod	\N	\N	\N	0	1
469	Ажилгүйдэл нийгмийн өмнө тулгамдаж буй асуудлуудын нэг болоод байгаа. 	失業は社会につきつけられた諸問題の一つになっている。	\N		\N	vmod	\N	\N	\N	0	1
470	Энэ сэдэвтэй холбоотой аливаа асуулт байвал чөлөөтэй хандана уу.	このテーマに関する質問がありましたら何でもご自由にお寄せください。	\N		\N	vmod	\N	\N	\N	0	1
471	Таны эцэг эх, ах дүү нар одоо хаана ямар ажил хийж байна вэ?	あなたのご両親、兄弟は今、どこでどんな仕事をしているのですか？	\N		\N	vmod	\N	\N	\N	0	1
472	Би өглөө босоод нэг аяга кофе уучихаад мэйлээ шалгадаг. \n	私は朝起きるとコーヒーを一杯飲んでメールをチェックします。	\N		\N	vmod	\N	\N	\N	0	1
473	Энэ халуунд нэг аяга хүйтэн шар айраг залгилчихвал мөн  сайхан аа.	こんな暑いときに冷たいビールを一杯やったら最高だなあ。	\N		\N	vmod	\N	\N	\N	0	1
474	Та турахыг хүсч байвал хооллохдоо нэг удаа 2-оос илүү таваг аяга хоол бүү идээрэй.	痩せたいのなら食事のとき2杯以上食べてはいけません。	\N		\N	vmod	\N	\N	\N	0	1
475	Зун цагаан идээг түлхүү хэрэглэж, махан хоол бага хэрэглэдэг.	夏には乳製品をより多く用い、肉料理は少ししか食べない。	\N		\N	vmod	\N	\N	\N	0	1
476	Би Японд сурч байсан гээд л та байн байн ярих юм.	あなたは日本留学経験があるとしばしばおっしゃいますね。	\N		\N	vmod	\N	\N	\N	0	1
477	Тамхи татдаг, өтгөн байхуу цай, кофе уудаг хүмүүсийн шүд амархан шарладаг. 	煙草を吸ったり、濃い紅茶・コーヒーを飲む人の歯は黄色くなりやすい。	\N		\N	vmod	\N	\N	\N	0	1
478	Болдынх хувийн байшинтай.\n 	ボルドのところは一戸建ての家を所有 しています。	\N		\N	vmod	\N	\N	\N	0	1
479	Энэ бал чинийх үү?	このボールペン、君の？	\N		\N	vmod	\N	\N	\N	0	1
480	Танай банкинд харилцах данс нээхэд ямар давуу талууд байгаа вэ? 	おたくの銀行に口座を開くとどんな利点がありますか？	\N		\N	vmod	\N	\N	\N	0	1
481	Бие засах газар хаа байна вэ?	お手洗いはどこですか。	\N		\N	vmod	\N	\N	\N	0	1
482	Бие засах газар орсны дараа гараа сайн угаах хэрэгтэй.	トイレに入った後は手をしっかり洗わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
483	Богино хугацаанд бид сайн найз нөхдүүд болж чадлаа.	短い間に僕たちはとても仲良しになれました。	\N		\N	vmod	\N	\N	\N	0	1
484	Одоо бороо орох шинжтэй шүү.	雨が降りそうですよ。	\N		\N	vmod	\N	\N	\N	0	1
486	Маргааш бороо орохгүй байхаа.	明日は雨が降らなさそうです。	\N		\N	vmod	\N	\N	\N	0	1
487	Бат суудлаасаа босч асуултанд нь хариулав.	バトは席から立ち上がって質問に答えた。	\N		\N	vmod	\N	\N	\N	0	1
488	Би орой эрт унтаж , өглөө эрт босдог . 	私は早寝早起きをしています。	\N		\N	vmod	\N	\N	\N	0	1
489	Манай аав бүдүүн хүзүүтэй.	父は首が太いです。	\N		\N	vmod	\N	\N	\N	0	1
490	Дараагийн бүтэн сайн өдөр юу хийх вэ?	次の日曜日、何をしますか？	\N		\N	vmod	\N	\N	\N	0	1
491	Уншигч нь номын санд байгаа номыг уншлагын танхимаар төлбөргvй авч, тодорхой хугацаагаар ашиглаад, буцааж өгдөг.	利用者は図書館にある図書を閲覧室で無料で受け取り、一定の期間利用した後、返却します。	\N		\N	vmod	\N	\N	\N	0	1
492	Монголчууд яаж бяслаг хийдгийг чи мэдэх үү?	モンゴル人がどうやってチーズを作るか、君は知っていますか。	\N		\N	vmod	\N	\N	\N	0	1
493	Чи гадаад орноор явж үзсэн үү?	外国に行ったことはありますか。	\N		\N	vmod	\N	\N	\N	0	1
494	Би их сургуулийн гадаад оюутны байранд суудаг.	私は大学の留学生寮に住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
495	Аяга тавгаа гал тогооны өрөөнөөс авч ирээрэй.	食器を台所からもっていらっしゃい。	\N		\N	vmod	\N	\N	\N	0	1
496	Асуултанд хариулахдаа гараа өргөөрөй.	質問に答えるときには手を上げてください。	\N		\N	vmod	\N	\N	\N	0	1
497	Асуулт байвал гараа өргөөрөй.	質問があるなら手を挙げてください。	\N		\N	vmod	\N	\N	\N	0	1
498	Хүмүүс Дашийг Доржийн баруун гар гэж нэрлэдэг.	皆はダシのことをドルジの右腕と呼びます。	\N		\N	vmod	\N	\N	\N	0	1
499	Би Болдтой Тэнгэр кино театрийн гарах хаалганы ойролцоо өнөөдөр орой 7 цагт уулзахаар тохиролцов.	僕はボルドと今日の夜7時にテンゲル映画館の出口付近で会う約束をした。	\N		\N	vmod	\N	\N	\N	0	1
500	Би гахайн мах бага иддэг.	私は豚肉をあまり食べません。	\N		\N	vmod	\N	\N	\N	0	1
501	Би долдугаар ангид байхдаа гитар тоглож сурсан.	私は7年生のときにギターが弾けるようになりました。	\N		\N	vmod	\N	\N	\N	0	1
502	Орхон　голд олон төрлийн загас бий.	オルホン川には多種多様な魚がいます。	\N		\N	vmod	\N	\N	\N	0	1
503	Би гэр үрүү нь гүйгээд очлоо.	私は彼の家に走っていきました。	\N		\N	vmod	\N	\N	\N	0	1
504	Гуравдахь өдөр тооны хичээлтэй юү?	水曜日、数学の授業はある？	\N		\N	vmod	\N	\N	\N	0	1
505	Гуравдугаар сарын найманд юуны баяр тэмдэглэдэг вэ?	3月8日は何をお祝いする日ですか？	\N		\N	vmod	\N	\N	\N	0	1
506	Манай өвөө Монгол гутлаа өөрөө хийгээд өмсчихдөг хүн байсан юм шүү.	僕のおじいさんはモンゴル靴を自分で作って履いていましたよ。	\N		\N	vmod	\N	\N	\N	0	1
507	Давс их идэх нь хэдэн зүйлийн өвчинтэй нягт холбоотой.	塩をたくさん摂取することはいくつかの病気と密接な関係があります。	\N		\N	vmod	\N	\N	\N	0	1
508	Манай хорооллын гудамжинууд  маш давчуу юм.	私たちの地区の通りはとても狭い。	\N		\N	vmod	\N	\N	\N	0	1
509	Хоёулаа гараад нэг шил дарс аваад ирэх үү?	いっしょにワインを一本買って来ましょうか？	\N		\N	vmod	\N	\N	\N	0	1
510	Өнөөдрийн хичээлээр бид ярианы дасгал хийлээ.	今日の授業で私たちは会話の練習をしました。	\N		\N	vmod	\N	\N	\N	0	1
511	Үндэсний их баяр наадам жил бүрийн долдугаар сард болдог.	国民の祭典ナーダムは毎年7月に行なわれます。	\N		\N	vmod	\N	\N	\N	0	1
512	Энэ нэвтрүүлэг долоо хоног бүр нэг удаа нэгдүгээр сувгаар гардаг.	この番組は毎週1回1チャンネルで放映されます。	\N		\N	vmod	\N	\N	\N	0	1
553	Үүнд марк наах хэрэгтэй.	これに切手を貼る必要があります。	\N		\N	vmod	\N	\N	\N	0	1
513	Орой, унтахынхаа өмнө хүзүүгээ угаахдаа дээрээс нь доошоо, доороос нь дээшээ массаж хийгээрэй. 	夜寝る前、首を洗うときに、上から下へ、下から上へマッサージをして下さい。	\N		\N	vmod	\N	\N	\N	0	1
514	Японд хичээлийн шинэ жил дөрөвдүгээр сард эхэлдэг.\n	日本の学年は4月に始まります。	\N		\N	vmod	\N	\N	\N	0	1
515	Манай номын сан дөрөвдэх өдөр амардаг.	私どもの図書館は木曜日に休館します。	\N		\N	vmod	\N	\N	\N	0	1
516	Манай ах дандаа дугуйгаар явдаг.	兄はいつも自転車に乗っています。	\N		\N	vmod	\N	\N	\N	0	1
517	Дорж ногоотой шөлөнд дургүй.	ドルジは野菜スープが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
518	Би монгол ардын дуунд дуртай болчихлоо.	私はモンゴル民謡が好きになってしまいました。	\N		\N	vmod	\N	\N	\N	0	1
519	Онгоцны нислэгийн ажиллагаанд дамаар нөлөөлж болох цахим тоног төхөөрөмж, тухайлбал дуу хураагуур, видео камер, радио, үүрэн телефон, тоглоом зэргийг онгоц хөөрөх, буух үед хэрэглэхийг хориглоно.	飛行機の計器類に影響を及ぼす可能性のある電化製品、たとえばテープレコーダー、ビデオカメラ、ラジオ、携帯電話、ゲーム機などを離着陸の時に使用することを禁止いたします。	\N		\N	vmod	\N	\N	\N	0	1
520	Дулмаа, чи нэг сайхан дуу дуулаач!	ドルマー、きれいな歌を1曲歌ってくれよ。	\N		\N	vmod	\N	\N	\N	0	1
521	Өнөөдөр хичээлтэй шүү. Дэвтрээ авахаа мартуузай.	今日は授業がありますよ。ノートを持っていくのを忘れないように。	\N		\N	vmod	\N	\N	\N	0	1
522	Бат талх авахаар дэлгүүрт очив.	バトはパンを買いに店に行きました。	\N		\N	vmod	\N	\N	\N	0	1
523	Би сүүтэй цайнд их дуртай.	私はスーテイツァイが大好きです。	\N		\N	vmod	\N	\N	\N	0	1
524	Есдүгээр сарын эхээр шинэ кино гарна.	9月初めに新作映画が公開されます。	\N		\N	vmod	\N	\N	\N	0	1
525	Үндэсний баяр наадамд жил бүр 512 бөх барилддаг юм.	国民の祭典ナーダムでは毎年512人の力士が相撲をとります。	\N		\N	vmod	\N	\N	\N	0	1
526	Манай ээж одоогоор зав муутай байх шиг байна.	母は今とても忙しいようです。	\N		\N	vmod	\N	\N	\N	0	1
527	Тэр хуралд залуу багш нар ч  оролцов.	その会議には若い教師たちも参加しました。	\N		\N	vmod	\N	\N	\N	0	1
528	Би зангиа зүүх  дургүй.	僕はネクタイをするのが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
529	Бүгдээрээ зоогийн газар орж сайхан  хоололцгооё.	みんなでレストランに入っておいしい食事をしましょう。	\N		\N	vmod	\N	\N	\N	0	1
530	Бид багаасаа зохион бичлэг хийдэг байсан.	私たちは幼い頃から作文を書いていました。	\N		\N	vmod	\N	\N	\N	0	1
531	Талбайн хажууд бас нэг шинэ зочид буудал бариж байна.	広場の隣にまた新しいホテルを建てています。	\N		\N	vmod	\N	\N	\N	0	1
532	Би монголын түүхийн тухай зузаан ном уншиж дуусгалаа.	私はモンゴル史に関する厚い本を読み終えました。	\N		\N	vmod	\N	\N	\N	0	1
533	Зуны амралтаараа хөдөө явах уу?	夏休みに田舎へ行きますか？	\N		\N	vmod	\N	\N	\N	0	1
534	Та энэ зургийг надад тайлбарлаж өгөөч!	この絵について私に説明してください。	\N		\N	vmod	\N	\N	\N	0	1
535	Зургадугаар сарын нэгэнд монголчууд Эх үрсийн баярыг тэмдэглэдэг.	6月1日、モンゴル人は「母と子の祝日」を祝います。	\N		\N	vmod	\N	\N	\N	0	1
536	Би энэ зургийн аппаратыг их дэлгүүрээс авсан юм.	私はこのカメラを百貨店で買いました。	\N		\N	vmod	\N	\N	\N	0	1
537	Манай сургуулийн зүүн талд номын дэлгүүр байсан юм. 	私たちの学校の東側に書店がありました。	\N		\N	vmod	\N	\N	\N	0	1
538	Энхтайвны гүүрээр гараад зүүн гар тийшээ эргээд яваарай.	平和橋を渡って左手に曲がってください。	\N		\N	vmod	\N	\N	\N	0	1
539	Гэртээ очтол ээж маань зуухны хажууд сууж байлаа.	家に着くと、母はストーブのそばに座っていました。	\N		\N	vmod	\N	\N	\N	0	1
540	Бvх материалууд ганц ганц хувь учир зээлж авсан тохиолдолд ном, сэтгүүлийг болгоомжтой ашиглаж, гэмтээхгүй байх ёстой. 	すべての資料はそれぞれ1部ずつしかないので、借りた場合には本や雑誌を慎重に利用し、破損しないようにしなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
541	Эрдэм номтой хүн байна гэдэг ийм сайхан бахархамаар зүйл байдаг юм байна.	学識を身につけた人であるということはこんなに誇らしいものなのだね。	\N		\N	vmod	\N	\N	\N	0	1
542	Энэ боодлыг шуудангаар явуулах гэсэн юм.	この包みを郵便で送りたいのですが。	\N		\N	vmod	\N	\N	\N	0	1
543	Ирэх долоо хоногт цаг агаар ямар байх вэ?	来週、天気はどうでしょう？	\N		\N	vmod	\N	\N	\N	0	1
544	Хандаа эгч том компанид ажилладаг.	ハンダー姉さんは大きな会社に勤めています。	\N		\N	vmod	\N	\N	\N	0	1
545	Хүүхдүүд сургуулийн коридор, анги, гадаа хаа сайгvй л барилдана.	子供たちは、学校の廊下、教室、外、いたるところでとっくみあいをします。	\N		\N	vmod	\N	\N	\N	0	1
546	Та цай уух уу, кофе уух уу?	お茶になさいますか、それともコーヒー?	\N		\N	vmod	\N	\N	\N	0	1
547	Өвөл цагт малгайгүй явбал даарна.	冬、帽子なしでいれば凍えます。	\N		\N	vmod	\N	\N	\N	0	1
548	Хүнсний дэлгүүрээс 1 кг масло аваад ирэв.	食料品店でバターを1キロ買ってきました。	\N		\N	vmod	\N	\N	\N	0	1
549	1 кг мах ямар үнэтэй вэ?	肉1キロはいくらですか。	\N		\N	vmod	\N	\N	\N	0	1
555	Наймдугаар сард би зуны амралтаа авна.	8月に私は夏休みをとります。	\N		\N	vmod	\N	\N	\N	0	1
556	Монголчууд "наадмын дараа намар" гэж ярьдаг.	モンゴル人は「ナーダムの後は秋」と言います。	\N		\N	vmod	\N	\N	\N	0	1
557	Сургуулийн баруун талд нэг намхан байшин байдаг.	学校の西側に背の低い建物があります。	\N		\N	vmod	\N	\N	\N	0	1
558	Монголд нарийн ноосны хонь бий юү?	モンゴルには細い羊毛（ファインウール）の羊はいますか？	\N		\N	vmod	\N	\N	\N	0	1
560	Цайндаа сүү хийх үү, нимбэг хийх үү?	お茶にミルクを入れますか、それともレモンを入れますか？	\N		\N	vmod	\N	\N	\N	0	1
561	Энэ ном нимгэн ч гэсэн их сонирхолтой.	この本は薄いですがとても面白いです。	\N		\N	vmod	\N	\N	\N	0	1
562	Хандаа хоёр ногоон харандаатай байжээ.	ハンダーは緑色の鉛筆を2本持っていました。	\N		\N	vmod	\N	\N	\N	0	1
563	Номын тавиураас дуртай номоо авч уншаарай!	本棚から好きな本をとってお読みなさい。	\N		\N	vmod	\N	\N	\N	0	1
565	Би тэр үеийн үйл явдлыг нүдээр үзэж , биеэр оролцож байсан хүмүүсийн нэг шүү.	私は当時の出来事を自分の目で見、（それに）みずから参加した人たち（当事者）の1人なのですよ。	\N		\N	vmod	\N	\N	\N	0	1
566	Тэр нүдний шилтэй залуу хэн бэ?	あの眼鏡をかけた青年は誰ですか。	\N		\N	vmod	\N	\N	\N	0	1
567	Унтахаасаа өмнө нүүрээ халуун бүлээн усаар савандаж угаах хэрэгтэй.	寝る前に顔をお湯と石鹸で洗わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
568	Миний нөхөр эмч.	私の夫は医者です。	\N		\N	vmod	\N	\N	\N	0	1
569	Наашаа ирээд нэг сар боллоо.	こちらに来てひとつきになります。	\N		\N	vmod	\N	\N	\N	0	1
570	Нэгдэх өдөр манайд очоорой.	月曜日に私の家にいらっしゃい。	\N		\N	vmod	\N	\N	\N	0	1
571	Түүний үгэн дээр би нэг зүйл нэмж хэлье.	彼の発言に私はひとつつけたします。	\N		\N	vmod	\N	\N	\N	0	1
572	Манай багш дэлхийд алдартай тэр сургуулийг төгссөн хүн.	私たちの先生は世界でも有名なあの学校を卒業した人物です。	\N		\N	vmod	\N	\N	\N	0	1
573	Гадаа хүйтэн шүү. Оймс өмсөөд яваарай!	外は寒いですよ。靴下を履いてお行きなさい。	\N		\N	vmod	\N	\N	\N	0	1
574	Тэр жүжгийг олон хүн үзсэн гэнэ.	その演劇を大勢の人が観たそうです。	\N		\N	vmod	\N	\N	\N	0	1
575	Цонх онгойлгоод агаар оруулаач!	窓を開けて風を入れてちょうだい！	\N		\N	vmod	\N	\N	\N	0	1
576	Тэр өрөөнд ширээ, сандал, ор гээд бүх юм бэлэн байжээ.	その部屋には机、椅子、ベッドなどあらゆるものがそろっていました。	\N		\N	vmod	\N	\N	\N	0	1
577	Оройн хоолонд юу идэх вэ?	夕飯に何を食べようか？	\N		\N	vmod	\N	\N	\N	0	1
578	Арва н цагаас бүү оройтоорой!	10時より遅くなってはいけません！	\N		\N	vmod	\N	\N	\N	0	1
580	Энэ байшингийн орох хаалга нь хоёрдугаар давхарт байгаа.	この建物の入口は2階にあります。	\N		\N	vmod	\N	\N	\N	0	1
581	Эрт дээр цагт нэгэн ядуу өвгөн, ач хүүтэйгээ амьдарч байжээ. 	昔々、ひとりの貧しいおじいさんが孫といっしょに暮らしていました。	\N		\N	vmod	\N	\N	\N	0	1
582	Миний өвчин сүрьеэ биш байсан.	私の病気は結核ではありませんでした。	\N		\N	vmod	\N	\N	\N	0	1
583	Өглөөний хоолоо идээд ирсэн үү?	朝食を済ませてきましたか。	\N		\N	vmod	\N	\N	\N	0	1
584	Хувцасаа өлгүүрт өлгөөрөй!	服は洋服かけにおかけなさい。	\N		\N	vmod	\N	\N	\N	0	1
585	Ээжээ, миний унтлагны өмдийг хаана хийсэн бэ?	お母さん、僕のねまきのズボンをどこに入れたの？	\N		\N	vmod	\N	\N	\N	0	1
586	Хубилай хаан Монгол гүрний улс төрийн төвийг өмнө зүг Бээжин үрүү шилжүүлжээ.	ホビライ=ハーンはモンゴル帝国の政治の中心地を南の北京に移しました。	\N		\N	vmod	\N	\N	\N	0	1
587	Цэдэн гуай малгайгаа өмсөнгүүтээ л яваад өглөө.	ツェデンさんは帽子をかぶると行ってしまいました。	\N		\N	vmod	\N	\N	\N	0	1
588	Цагаан сараар би дээл өмсдөг.	ツァガーン･サル（旧正月）に私はデールを着ます。	\N		\N	vmod	\N	\N	\N	0	1
589	Танай машин ямар өнгөтэй вэ?	あなたがたの車は何色ですか。	\N		\N	vmod	\N	\N	\N	0	1
590	Өнөөдөр, өнгөрсөн долоо хоногт болсон гэмт хэргийн талаар авч хэлэлцэнэ.	今日は、先週起きた犯罪について話し合います。	\N		\N	vmod	\N	\N	\N	0	1
591	Манай охин өнгөрсөн жил сургуулиа төгсөв.	うちの娘は去年学校を卒業した。	\N		\N	vmod	\N	\N	\N	0	1
592	Өнгөрсөн сард бөхийн тухай шинэ ном гарлаа.	先月、相撲についての新しい本が出ました。	\N		\N	vmod	\N	\N	\N	0	1
593	Би өндөг идэж чаддаггүй.	私は卵が食べられません。	\N		\N	vmod	\N	\N	\N	0	1
594	Хөшөө нь хааш хаашаа нэг метр 80 см, өндөр нь нэг метр 50 см.	記念碑は1メートル80センチ四方で、高さは1メートル50センチです。	\N		\N	vmod	\N	\N	\N	0	1
595	Дорнод аймгийн  зүүн өмнөд хэсгээр Мэнэн, Тамсаг, Матадын өргөн уудам талууд оршдог.	ドルノド・アイマグの東南部には、メネン、タムサグ、マタドの広大な平原があります。	\N		\N	vmod	\N	\N	\N	0	1
596	Төсөлд зааснаар талбай нь уртаашаа 400 м, өргөөшөө 350 м юм байна.	計画に示されたところによると、その広場は縦400メートル、横350メートルです。	\N		\N	vmod	\N	\N	\N	0	1
641	Энэ ямар утгатай вэ?	これにはどんな意味がありますか。	\N		\N	vmod	\N	\N	\N	0	1
597	Унтахын өмнө кофе , өтгөн байхуу , тамхи зэргийг хэрэглэж болохгүй.	寝る前にコーヒーや濃い紅茶、煙草などを口にしてはいけません。	\N		\N	vmod	\N	\N	\N	0	1
598	Хөргөгчинд жимс байгаа.	冷蔵庫の中に果物があります。	\N		\N	vmod	\N	\N	\N	0	1
599	Билет дууссан байсан учир  өчигдөр орой жүжиг үзсэнгүй. 	チケットが売り切れたので昨夜は 芝居を見ませんでした。	\N		\N	vmod	\N	\N	\N	0	1
600	Тэр хүүхний пальто нь үнэгэн захтай.	その女性のコートにはキツネ皮の襟がついています。	\N		\N	vmod	\N	\N	\N	0	1
601	Эрэгтэй хүнд хамгийн гоё зохидог хувцас бол пиджак. 	男性にもっともよく似合う服は背広です。	\N		\N	vmod	\N	\N	\N	0	1
602	Сүүлийн үед хүмүүс пянз тоглуулагчаар хөгжим сонсохоо больжээ.	最近、皆、音楽を聴くときにレコードをかけなくなりました。	\N		\N	vmod	\N	\N	\N	0	1
603	Чи шугамын радио гэдэг юм мэдэхгүй юм уу?	君、有線ラジオというものを知らないの？	\N		\N	vmod	\N	\N	\N	0	1
604	Монголчууд савх хэрэглэдэг үү?	モンゴル人は箸を使いますか？	\N		\N	vmod	\N	\N	\N	0	1
605	Бат радио сонсч байна уу?	バトはラジオを聞いていますか。	\N		\N	vmod	\N	\N	\N	0	1
606	Солонго олон сайхан шинэ ном авлаа.	ソロンゴは多くのきれいな新刊書を買いました。	\N		\N	vmod	\N	\N	\N	0	1
607	Өнөөдөр салхитай ч гэсэн дулаахан байна.	今日は風がありますが、暖かです。	\N		\N	vmod	\N	\N	\N	0	1
608	Өнөөдөр сайхан өдөр байна. Салхинд гаръя.	今日は天気がいい。散歩に行こう。	\N		\N	vmod	\N	\N	\N	0	1
609	Байр нь цэвэрхэн, саруул, тохилог байв.	寮は清潔で明るく、快適でした。	\N		\N	vmod	\N	\N	\N	0	1
610	Энэ тухай өдөр тутмын нэгэн сонины өчигдрийн дугаарт мэдээлсэн байна.	これについて、ある日刊紙の昨日の号に報道されています。	\N		\N	vmod	\N	\N	\N	0	1
611	Энэ сэтгүүл огтхон ч сонирхолгүй шүү дээ.	この雑誌、ちっとも面白くないよ。	\N		\N	vmod	\N	\N	\N	0	1
612	Тамхичид харьцангуй сул дорой биетэй байдаг.	煙草を吸う人は比較的身体が弱い。	\N		\N	vmod	\N	\N	\N	0	1
613	Манай сургууль 1000 гаруй сурагчидтай.	わが校には1000名余りの生徒がいます。	\N		\N	vmod	\N	\N	\N	0	1
614	Наашаа ирээд суугаарай.	こっちへ来てお座りなさい。	\N		\N	vmod	\N	\N	\N	0	1
615	Бороо орж сэрүүн салхи салхилав.	雨が降って涼しい風が吹きました。	\N		\N	vmod	\N	\N	\N	0	1
616	Эхлээд халбагаар шөлийг уугаад, дараа нь сэрээ хутга хэрэглэж махыг иднэ.	初めにスプーンでスープを飲み、次にフォークとナイフを使って肉を食べます。	\N		\N	vmod	\N	\N	\N	0	1
617	Өчигдөр орой би аяга таваг хагарах　чимээ сонслоо. Юу болсон бэ?	昨夜、私は茶碗や皿が割れる音を聞きました。何があったのですか。	\N		\N	vmod	\N	\N	\N	0	1
619	Тавдугаар сард шинэ багш ирэх гэнэ.	5月に新しい先生がいらっしゃるそうです。	\N		\N	vmod	\N	\N	\N	0	1
620	Наад муухай хувцасаа тайлаад, энэ цэвэрхэн хувцасыг өмс.	そんな汚い服は脱いでこのきれいな服を着なさい。	\N		\N	vmod	\N	\N	\N	0	1
621	Үзүүрийг нь тайраад л байвал үс сайхан ургана . 	毛先だけ切っていれば髪の毛はきれいに伸びます。	\N		\N	vmod	\N	\N	\N	0	1
622	Талх дуусчихсан уу? 	パンは売切れてしまいましたか。	\N		\N	vmod	\N	\N	\N	0	1
623	Сүүлийн үед гахай, тахианы махыг өргөн хэрэглэх болж байна. \n	最近は豚肉や鶏肉が幅広く用いられるようになっています。	\N		\N	vmod	\N	\N	\N	0	1
624	Миний дүү телевиз үзэх дуртай.	私の弟はテレビを観るのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
625	Хүүхдүүд гадаа тоглож байгаа.	子供たちは外で遊んでいます。	\N		\N	vmod	\N	\N	\N	0	1
626	Билетний үнэ нь том хүн 2000 төгрөг, хүүхэд 200 төгрөг болно.	チケットの価格は、大人2000トゥグルグ、子供200トゥグルグです。	\N		\N	vmod	\N	\N	\N	0	1
627	Түлхүүрээ авахаа мартуузай.	鍵を忘れないようにね!	\N		\N	vmod	\N	\N	\N	0	1
628	Түрийвчээ хаана орхисон юм болоо.	財布をどこに忘れたんだろう。	\N		\N	vmod	\N	\N	\N	0	1
629	Тэд салхинд зугаалангаа голоос ус авчирчээ.	彼らは風に当たって散歩したついでに、川から水を汲んできました。	\N		\N	vmod	\N	\N	\N	0	1
630	Тэнд том номын сан байна.	あそこに大きな図書館があります。	\N		\N	vmod	\N	\N	\N	0	1
631	Тэнд олон оюутан суралцаж байна.	そこでは多くの学生が勉強しています。	\N		\N	vmod	\N	\N	\N	0	1
632	Тэр удахгүй ирэх байхаа.	彼（彼女）は間もなく来るでしょう。	\N		\N	vmod	\N	\N	\N	0	1
633	Одоо би угаалга хийнэ.	これから私は洗濯をします。	\N		\N	vmod	\N	\N	\N	0	1
634	Арай удаан ярьж өгөхгүй юү?	少しゆっくり話してもらえませんか。	\N		\N	vmod	\N	\N	\N	0	1
635	Улаан харандаа байвал надад өгөөч.	赤鉛筆があるなら私に（貸して）ください。	\N		\N	vmod	\N	\N	\N	0	1
636	Зарим нутгаар уржигдар хүчтэй шороон шуурга шуурчээ.	ところによってはおととい、強い砂嵐が吹きました。	\N		\N	vmod	\N	\N	\N	0	1
637	Уржнан, Дулмаа хүүхдүүдээ дагуулаад хотод орж ирсэн. 	おととしドルマーは子供たちを連れて町へ来ました。	\N		\N	vmod	\N	\N	\N	0	1
638	Хамгийн урт үстэй нь хэн бэ?	一番髪が長いのは誰ですか。	\N		\N	vmod	\N	\N	\N	0	1
639	Дараа утсаар ярья.	後で電話します。	\N		\N	vmod	\N	\N	\N	0	1
640	Энэ гар утас уу? 	これは携帯電話ですか？	\N		\N	vmod	\N	\N	\N	0	1
642	Замын уулзвар дээр зохицуулагч байнга байх хэрэгтэй болжээ.	交差点に交通整理係が常にいることが必要になりました。	\N		\N	vmod	\N	\N	\N	0	1
643	Өчигдөр орой Баянгол зоогийн газарт том цайллага болжээ. 	ゆうべバヤンゴル・レストランで大きなパーティーが催されました。	\N		\N	vmod	\N	\N	\N	0	1
644	Оройгоор сургууль дээр нэг үдэшлэгтэй.	夕方学校でパーティーがあります。	\N		\N	vmod	\N	\N	\N	0	1
645	Өчигдөр би үдээс өмнө гэрээ цэвэрлээд үдээс хойш ном уншив.	昨日私は午前中、家を掃除し、午後は読書をしました。	\N		\N	vmod	\N	\N	\N	0	1
646	Ширээн дээр үнсний сав байна.	テーブルの上に灰皿があります。	\N		\N	vmod	\N	\N	\N	0	1
647	Тэр хүүхэд хоёр давхраас үсэрч буулаа.	その子供は２階から飛び降りました。	\N		\N	vmod	\N	\N	\N	0	1
648	Маргааш хоёр цагт үүдэн дээр уулзъя.	明日2時に玄関で会いましょう。	\N		\N	vmod	\N	\N	\N	0	1
649	Маргааш зарим нутгаар үүлшинэ.	明日は一部の地方で曇るでしょう。	\N		\N	vmod	\N	\N	\N	0	1
651	Өнгөрсөн жилийн зуднаар олон мал үхжээ.	去年のゾドによってたくさんの家畜が死んだ。	\N		\N	vmod	\N	\N	\N	0	1
652	Цэнгэлдэх хүрээлэнгийн хаалга бүр дээр олон хүн байжээ.	スタジアムのどの門にも大勢の人がいました。	\N		\N	vmod	\N	\N	\N	0	1
653	Хэн нэгэн хүн хаалга тогшиж байна.	誰かがドアをノックしています。	\N		\N	vmod	\N	\N	\N	0	1
654	Хаалгаа хаагаад яваач!	戸を閉めてから行って！	\N		\N	vmod	\N	\N	\N	0	1
655	Танай анги энэ хавар ямар ямар шалгалт өгөх вэ?	あなたたちのクラスは今年の春どんな試験を受けますか。	\N		\N	vmod	\N	\N	\N	0	1
656	Өргөдөл дээрээ зургаа хавсаргана уу.	申請書には写真を添付してください。	\N		\N	vmod	\N	\N	\N	0	1
657	Хоёрдохь өдөр таны үзсэн киног би хагас сайн өдөр үзнэ. 	火曜日にあなたが観た映画を私は土曜日に観ます。	\N		\N	vmod	\N	\N	\N	0	1
658	Аав халаасандаа гараа хийв.	父はポケットに手を入れた。	\N		\N	vmod	\N	\N	\N	0	1
659	Чи халуун ногоотой хоол идэж чаддаг уу?	香辛料の入った料理は食べられる？	\N		\N	vmod	\N	\N	\N	0	1
660	Энэ оюутны байр давхар бүртээ угаалгын өрөөтэй.	この学生寮は各階にバスルームがあります。	\N		\N	vmod	\N	\N	\N	0	1
661	Гэрэл зургийн хальсаа хаана угаалгаж авах вэ?	写真のフィルムをどこで現像してもらいましょうか？	\N		\N	vmod	\N	\N	\N	0	1
662	Миний хамар битүүрээд байна.	鼻がつまっています。	\N		\N	vmod	\N	\N	\N	0	1
663	Нимгэн хувцастай гадаа гарснаас болж ханиад хүрчээ.	薄着で外出したために風邪をひいてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
664	Дорж хар нүдтэй. 	ドルジは黒い目をしています。 	\N		\N	vmod	\N	\N	\N	0	1
665	Цахилгаан тасраад гэв гэнэт харанхуй болжээ.	停電になり、突然暗くなりました。	\N		\N	vmod	\N	\N	\N	0	1
666	Хосчимэг гэртээ харина гэж хэлэв.	ホスチメグは（自分が）家に帰ると言いました。	\N		\N	vmod	\N	\N	\N	0	1
667	Наадмаар нэг хөгжилтэй явдал боллоо. 	ナーダムのとき、楽しいことが起こりました。	\N		\N	vmod	\N	\N	\N	0	1
668	Дорж хөл муутай. 	ドルジは脚が悪いです。	\N		\N	vmod	\N	\N	\N	0	1
669	Бага байхдаа  би хөл нүцгэн гүйдэг байлаа. 	幼い頃私は裸足で走ったものでした。	\N		\N	vmod	\N	\N	\N	0	1
670	Өнөөдөр Сүхбаатарын талбай хөл хөгжөөнтэй байлаа. 	今日、スフバータル広場はにぎやかでした。	\N		\N	vmod	\N	\N	\N	0	1
671	Өнөөдөр хөнгөн жингийн эмэгтэйчүүдийн чөлөөт бөхийн тэмцээн болно. 	今日、軽量級女子のレスリングの試合があります。	\N		\N	vmod	\N	\N	\N	0	1
672	Миний үнэмлэх хоёрдугаар сар хүртэл хүчинтэй.	私の身分証明書は2月まで有効です。	\N		\N	vmod	\N	\N	\N	0	1
673	Маргааш төвийн нутгийн хойд хэсгээр бороо орно.	明日、中央地域の北部では雨が降るでしょう。	\N		\N	vmod	\N	\N	\N	0	1
674	Болд хойтонгийн хойтон жил япон явах санаатай.	ボルドは再来年日本に行くつもりです。	\N		\N	vmod	\N	\N	\N	0	1
675	Энэ бичгийг хувилаад ирье.	この書類をコピーして来よう。	\N		\N	vmod	\N	\N	\N	0	1
676	Би хувцсаа өөрөө угаадаг.	私は自分の服を自分で洗濯します。	\N		\N	vmod	\N	\N	\N	0	1
677	Их дэлгүүрт оёдолын машин худалддаг уу?	百貨店ではミシンを売っていますか。	\N		\N	vmod	\N	\N	\N	0	1
678	Энэ маш хүнд хайрцаг. Би үүнийг авч явж чадахгүй.	これはとても重い箱です。私には持てません。	\N		\N	vmod	\N	\N	\N	0	1
679	Савхин хүрэмтэй хүн зочид буудлаас гарч ирлээ.	革の上着を着た人がホテルから出てきた。	\N		\N	vmod	\N	\N	\N	0	1
680	Багш цүнхнээсээ хоёр хуудас цаас, үзэг гаргаад ширээн дээр тавив.	先生はカバンから2枚の紙とペンを取り出して机の上に置きました。	\N		\N	vmod	\N	\N	\N	0	1
681	Зөвшөөрөл авахад оюутны үнэмлэхийн хуулбар хэрэгтэй.	許可をもらうには学生証のコピーが必要です。	\N		\N	vmod	\N	\N	\N	0	1
682	Өчигдөр би нэг хуучны ном уишлаа.	昨日私は一冊の古い本を読みました。	\N		\N	vmod	\N	\N	\N	0	1
683	Монголд хамгийн хүчтэй бөх хэн бэ?	モンゴルで一番強い力士は誰ですか。	\N		\N	vmod	\N	\N	\N	0	1
684	Намайг идэхгүй байлаа гэхэд өөр хэн нэгэн нь үүнийг иднэ.	私が食べなければ他の誰かがこれを食べます。	\N		\N	vmod	\N	\N	\N	0	1
685	Блог бичихэд энэ программ их дөхөмтэй.\n	ブログを書くときにはこのプログラムがとても便利です。	\N		\N	vmod	\N	\N	\N	0	1
686	Дорж тэр машныг хямд үнээр авсан гэнэ.	ドルジはその車を安く買ったそうです。	\N		\N	vmod	\N	\N	\N	0	1
687	Мэгий сүү шиг цагаан сэтгэлтэй. 	メギーはミルクのように白い（純真なの意）心をして います。	\N		\N	vmod	\N	\N	\N	0	1
688	Цагдаа, хүмүүсийг холдуулав. 	警官が人々を遠ざけた。	\N		\N	vmod	\N	\N	\N	0	1
689	Хэрэг гарвал цагдаагийн хэсэгт хандаарай.	問題が生じたら交番に届けてください。	\N		\N	vmod	\N	\N	\N	0	1
690	Хөмсөгний доод  хэсгийг цайвар өнгөөр будна.\n	淡い色を眉毛の下の部分に塗ります。	\N		\N	vmod	\N	\N	\N	0	1
691	Би цайны газар ажиллуулах гэсэн юм.	私、喫茶店を経営しようと思うの。	\N		\N	vmod	\N	\N	\N	0	1
692	Костюмныхаа өнгөнөөс илүү бараан цамц, бас түүнээс илүү цайвар зангиа зүүж болохгүй	スーツよりも暗い色のシャツ、それよりも薄い色のネクタイをしてはいけません。	\N		\N	vmod	\N	\N	\N	0	1
693	Бид Наритагаас цахилгаан галт тэргээр хотын төв рүү явлаа. 	私たちは成田から電車で東京の中心へ向かいました。	\N		\N	vmod	\N	\N	\N	0	1
694	Манай байранд цахилгаан шат байхгүй.	うちのアパートにはエレベーターがありません。	\N		\N	vmod	\N	\N	\N	0	1
695	Цэнд өөрийн хүч, хөрөнгөөр борооны ус хуримтлуулж цөөрөм байгуулав.	ツェンドは自前で雨水をため、貯水池を作りました。	\N		\N	vmod	\N	\N	\N	0	1
697	Нар мандах үеэр манантай байвал өдөртөө цэлмэг бүгчим болно. 	日の出の時に霧が出ていれば日中晴れて蒸し暑くなります。	\N		\N	vmod	\N	\N	\N	0	1
698	Цэнхэр дээл чамд сайхан зохих байхаа.	青いデールはあなたによく似合うでしょうね。	\N		\N	vmod	\N	\N	\N	0	1
699	Агаарын бохирдлоосоо салахын тулд энэ хотын ойр орчимд хэд хэдэн сайхан цэцэрлэгт хүрээлэн байгуулах хэрэгтэй.	大気汚染を解決するために、この町にはいくつかのきれいな公園を作る必要がある。	\N		\N	vmod	\N	\N	\N	0	1
700	Суудлын даруулгаа чангална уу.	シートベルトをお締めください。	\N		\N	vmod	\N	\N	\N	0	1
701	Ийм нам гүм орчинд амьдрах сайхан байхаа.	こんな静かな環境で暮らすのは素敵でしょうね。	\N		\N	vmod	\N	\N	\N	0	1
702	Гар утас чихэнд сөрөг нөлөөтэй гэнэ. 	携帯電話は耳に良くない影響があるそうです。	\N		\N	vmod	\N	\N	\N	0	1
703	За, одоо чихэр ид.	さあ、お菓子をどうぞ。	\N		\N	vmod	\N	\N	\N	0	1
704	Япон айлд орохдоо үүдэнд нь гутлаа тайлаад гэрийн шаахайнаас өмсөөрөй.	日本の家庭に上がるときには玄関で靴を脱ぎ、スリッパをおはきなさい。	\N		\N	vmod	\N	\N	\N	0	1
705	Шар талын дунд хэдэн цагаан гэр, шар дээл дээр хадсан цагаан товч мэт гялалзан харагдана.	黄色い平原の中にいくつかの白いゲルが、まるで黄色いデールについた白いボタンのように輝いて見える。	\N		\N	vmod	\N	\N	\N	0	1
706	Гуравдугаар давхар уруу энэ шатаар гараарай.	3階へはこの階段で上がってください。	\N		\N	vmod	\N	\N	\N	0	1
707	Энэ шулуун замаар чигээрээ яваарай.	このまっすぐな道を道なりにお行きなさい。	\N		\N	vmod	\N	\N	\N	0	1
708	Халуун, хүйтэн усан шүршүүрээр цохиулсны дүнд цусны эргэлт сайжрав.	お湯と水のシャワーに打たれた結果、血行がよくなった。	\N		\N	vmod	\N	\N	\N	0	1
709	Төв шуудангаас олон сайхан марк аваад ирлээ.	中央郵便局で数多くのきれいな切手を買ってきました。	\N		\N	vmod	\N	\N	\N	0	1
710	Чи яагаад шүхэртэй зогсоод байгаа юм бэ?	君はなぜ傘をさして立っているの？	\N		\N	vmod	\N	\N	\N	0	1
711	Сая би танай эгчтэй тааралдсан шүү дээ.	さっきあなたのお姉さんとばったり会ったよ。	\N		\N	vmod	\N	\N	\N	0	1
712	Авга эгчтэйгээ маргааш уулзна.	（父方の）おばと明日会います。	\N		\N	vmod	\N	\N	\N	0	1
713	Танай багш миний нагац эгч.	あなたの先生は私の（母方の）おばです。	\N		\N	vmod	\N	\N	\N	0	1
714	Чи манай ахтай уулзаж байсан билүү?	君、僕のおじさんと会ったことあったっけ	\N		\N	vmod	\N	\N	\N	0	1
715	Одоо би эгчийндээ очно.	これから私はおばのところへ行きます。	\N		\N	vmod	\N	\N	\N	0	1
716	Эгч надаар дээл оёулуулав.	姉が私に命じて（さらに別の誰かに）モンゴル服を縫わせた。	\N		\N	vmod	\N	\N	\N	0	1
717	Тэр хоёр эгч дүүс.	その二人は姉妹です。	\N		\N	vmod	\N	\N	\N	0	1
718	Та өчигдөр их дэлгүүрээс элсэн чихэр 2 кг-ыг авсан уу?	あなたは昨日百貨店で砂糖を2キロ買いましたか。	\N		\N	vmod	\N	\N	\N	0	1
719	Жаахан элсэн чихэр авмаар байна. Цаасанд боож өгөх үү?	砂糖を少し買いたいのですが。紙に包んでいただけますか。	\N		\N	vmod	\N	\N	\N	0	1
720	Японы элчин сайдын яам хаана байдаг вэ?	日本大使館はどこですか。	\N		\N	vmod	\N	\N	\N	0	1
721	Эрт урьд цагт эмгэн өвгөн хоёр амьдран суудаг байжээ. 	むかしむかし、おばあさんとおじいさんが暮らしていました。	\N		\N	vmod	\N	\N	\N	0	1
722	Энэ кинонд нэгэн эмэгтэйн хувь заяаг харуулсан байдаг.	この映画は一人の女性の運命を描いています。	\N		\N	vmod	\N	\N	\N	0	1
723	Миний захиалсан ном энэ долоо хоногт ирнэ.	私の注文した本は今週届く。	\N		\N	vmod	\N	\N	\N	0	1
724	Би энэ сарын сүүлээр явна.	私は今月末に出発します。	\N		\N	vmod	\N	\N	\N	0	1
725	Чимээгүй, жүжиг эхэллээ шүү.	静かに！お芝居が始まりますよ。	\N		\N	vmod	\N	\N	\N	0	1
726	Манай эхнэр тамхинд дургүй. 	うちの家内はたばこが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
727	Дамба гуайн гэргийг Оюун гэдэг.	ダムバさんの奥さんはオヨンさんといいます。	\N		\N	vmod	\N	\N	\N	0	1
728	Солонго богино банзал өмсөх дуртай.	ソロンゴはミニスカートをはくのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
729	Одоо барааны дэлгүүүр орж юм авъя.	これから雑貨店で買い物をしましょう。	\N		\N	vmod	\N	\N	\N	0	1
730	"Хүн төрөлхтний ирээдүй" гэсэн сэдвээр хийсэн миний яриа ойлгоход хүнд байсан байх даа.  \n	「人類の未来」というテーマでした私の話は理解するのが大変だったでしょう。	\N		\N	vmod	\N	\N	\N	0	1
731	Энэ самбар.	これは黒板です。	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
732	Тэр цонх.	あれは窓です。	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
733	Сарнай сурагч.	サルナイは（11年制学校の）生徒です。	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
734	Хулан оюутан.	ホランは（大学の）学生です。	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
735	Сарнай оюутан биш.	サルナイは（大学の）学生ではありません。	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
736	Хулан сурагч биш.	ホランは（11年制学校の）生徒ではありません。	\N		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
737	Энэ толь бичиг үү?	これは辞書ですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
738	Тийм, энэ толь бичиг.	はい、これは辞書です。	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
739	Тэр Хүрлээ юү?	彼はフルレーですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
740	Үгүй, тэр Хүрлээ биш.	いいえ、彼はフルレーではありません。	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
741	Энэ юу вэ?	これは何ですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
742	Тэр хэн бэ?	あれは誰ですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
743	Цаг агаар ямар вэ?	天気はどうですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
744	Аль хүн бэ?	どの人ですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
745	Хэдэн төгрөг вэ?	何トゥグルグですか？	\N		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
746	Онгоц сая буулаа.	飛行機はつい先ほど着陸しました。	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
747	Өчигдөр цас оржээ.	昨日雪が降りました。	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
748	Үүр цайв.	夜が明けた。	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
749	Сувдаа ирэл үү?	ソブダーは来たんでしたっけ？	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
750	Ямар машин ирлээ?	どんな自動車が来たんでしたっけ？	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
751	Энхболд явж уу?	エンフボルドは出かけましたか？	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
752	Аль автобус ирж вэ?	どのバスが来ましたか？	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
753	Хэдэн хүүхэд ирэв?	何人の子どもが来ましたか？	\N		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
754	Өчигдөр та тэр номыг уншив уу?	昨日あなたはあの本を読みましたか？	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
755	Өчигдөр та ном уншив уу?	昨日あなたは読書をしましたか？	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
756	Би сая тэр киног үзлээ.	私はさっきあの映画を見ました。	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
757	Би сая кино үзлээ.	私はさっき映画を見ました。	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
759	Энэ эмийг дөнгөж сая уулаа.	この薬はついさっき飲みました。	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
760	Тэр шувуу шар будаа иднэ.	あの鳥はキビを食べます。	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
761	Энд шуудан байна.	ここに郵便局があります。	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
762	Бүх амьтан заавал үхнэ.	すべての生物は必ず死にます。	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
763	Би нөгөөдөр явна.	私はあさって出発します。	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
764	Баясгалан одоо энд байна.	バヤスガランは今ここにいます。	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
765	Маргааш бороо орох уу?	明日雨が降りますか？	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
766	Та ирэх жил тэнд байх уу?	あなたは来年あそこにいますか？	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
767	Энд цэцэрлэг байна уу?	ここに幼稚園がありますか？	\N		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
768	Өчигдөр цас ороогүй.	昨日雪が降りませんでした。	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
769	Ноднин цас орсонгүй.	昨年は雪が（降るはずだったのに結局）降りませんでした。	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
770	Маргааш бид нар очихгүй.	明日私たちは行きません。	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
771	Тэнд нялх хүүхэд байхгүй.	あそこに赤ちゃんはいません。	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
772	Жавхлан очоогүй юү?	ジャヴフランは行きませんでしたか？	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
773	Автобус ирсэнгүй юү?	バスは（来るはずだったのに結局）来ませんでしたか？	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
774	Гурил байхгүй юү?	小麦粉はありませんか？	\N		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
775	Энэ миний эгчийн дээл.	これは私の姉のモンゴル服です。	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
776	Миний машины аккумулятор суулаа.	私の自動車のバッテリがあがりました。	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
777	Өвөө өнөөдрийн автобусаар ирнэ.	祖父は今日のバスで来ます。	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
778	Сарнай Оросын дээд сургуулийн оюутан.	サルナイはロシアの大学の学生です。	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
779	Манай ээж хувийн эмнэлгийн сувилагч.	うちの母は私立の病院の看護師です。	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
780	Доржийн ах хувцасны наймаачин.	ドルジの兄は服の商人です。	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
781	Танай байр энэ үү?	おたくのアパートはこれですか？	\N		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
782	Би энэ номыг Тунгалагт өгнө.	私はこの本をトンガラグにやります。	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
783	Монголд зэрлэг бар байна уу?	モンゴルに野生のトラはいますか？	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
784	Амьтанд оюун ухаан байхгүй.	動物に知恵はありません。	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
785	Та дараа жил Монголд очих уу?	あなたは来年モンゴルに行きますか？	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
786	Манай хүүхэд насанд хүрээгүй.	うちの子どもは未成年です。	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
787	Би чамайг тэр үед таниагүй. 	私はそのとき君に気づきませんでした。	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
788	Ээж сая түлээнд явлаа.	お母さんはさっき薪を取りに行きました。	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
789	Аав маргааш аймаг очно.	お父さんは明日県庁所在地に行きます。	\N		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
790	Насаа одоо усанд орж байна.	ナサーは今風呂に入っています。	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
791	Би тэр үед нам унтаж байлаа.	私はそのときぐっすり眠っていました。	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
792	Ундраа энд байж байна.	オンドラーはここにいます。	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
793	Миний толгой өвдөж байна.	私の頭が痛い状態が続いています。	\N		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
794	Дээр үед энэ байшин сургуулийн биеийн тамирын зал байжээ.	昔、この建物は学校の体育館でした。	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
795	Батзулын ээж энэ эмнэлгийн сувилагч байв.	バトゾルのお母さんはこの病院の医者でした。	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
796	Өчигдөр тийм хүйтэн биш байлаа.	昨日はそれほど寒くありませんでした。	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
797	Мөнхжаргал удахгүй сурагч болно.	ムンフジャルガルはまもなく（11年制学校の）生徒になります。	\N		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
798	Манай аав сая Германаас ирлээ.	うちのお父さんはついさっきドイツから着きました。	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
799	Би өнөөдрөөс тамхи татахгүй.	私は今日からたばこを吸いません。	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
800	Энэ номыг Тамираас авав.	この本はタミルから借りました。	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
801	Үхрийн махнаас авлаа.	牛肉を買いました。	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
802	Чиний алдаанаас ийм юм боллоо.	君の失敗のためにこのようなことが起こりました。	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
803	Шинэ Элчин сайдыг Засгийн газраас удахгүй томилно.	新しい大使は内閣がまもなく任命します。	\N		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
804	Одоо энийг яах вэ?	今これをどうしますか？	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
805	Чи өчигдөр яалаа?	君、昨日どうしたっけ？	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
806	Концерт хэзээ эхлэх вэ?	コンサートはいつ始まりますか？	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
807	Одоо хаашаа эргэх вэ?	今度はどちらへ曲がりますか？	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
808	Чи яагаад очсонгүй вэ?	君はなぜ行きませんでしたか？	\N		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
809	Манай сургуульд 8 （найман） гадаад оюутан суралцаж байна.	うちの学校では８人の留学生が学んでいます。	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
810	Хүлээн авалтанд анх удаа 68 （жаран найман） долларын шампанскийг уулаа.	レセプションで初めて68ドルのシャンペンを飲みました。	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
811	Тухайн үед манай аавын цалин 750 （долоон зуун тавин） төгрөг байжээ.	当時、父の給料は750トクグルグでした。	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
812	Одоо 6-аас （зургаагаас） 2-ыг （хоёрыг） хасна.	今度は６から２を引きます。	\N		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
813	Энэ зургийг усан будгаар будлаа.	この絵は水彩絵の具で塗りました。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
814	Японы буцалтгүй тусламжаар манай сургуулийн шинэ дотуур байрыг барьжээ.	日本の無償資金協力によってわが校の新しい寄宿舎を建設しました。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
815	Эмээ ноосоор цамц нэхэж байна.	おばあさんはウールでセーターを編んでいます。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
816	Энэ автобус Олимпын гудамжаар явахгүй.	このバスはオリンピック通りを通りません。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
818	Нөгөө асуудлыг хурлаар шийдвэрлэнэ.	例の問題は会議で処理します。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
819	Мөнхжин энэ эмнэлэгт чих хамар хоолойн эмчээр ажиллаж байв.	ムンフジンはこの病院で耳鼻咽喉科医として働いていました。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
820	Тэр толь бичгийг номын дэлгүүрт 900 （есөн зуун） төгрөгөөр зарж байна.	あの辞書は書店で900トゥグルグで売っています。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
821	Долларын ханш 10 төгрөгөөр уналаа.	ドル相場は10トゥグルグ下落しました。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
822	Энэ бялууг гурил, молоко, өндөг гурваар хийнэ.	このケーキは、小麦粉、コンデンスミルク及び卵で作ります。	\N		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
823	Өчигдөр Чулуут, Батболд хоёр нэлээн их уулаа.	昨日、チョロートとバトボルドは相当飲みました。	\N		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
824	Эрүүл мэндийн сайд Япон болон Солонгосын төлөөлөгчтэй уулзлаа. 	保健大臣は日本及び韓国の代表者と会見しました。	\N		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
825	Мөнхөөгийн мэргэжил газар зүй болон аялал жуулчлал.	ムンフーの専攻は地理と観光です。	\N		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
826	Би ээжтэй хамт ирлээ.	私は母と一緒に来ました。	\N		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
827	Маргааш шинэ багштай уулзана.	明日新しい先生と会います。	\N		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
828	Та намайг манай ихэр дүүтэй андуурч байна.	あなたは私を双子の弟と間違えています。	\N		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
829	Чи өнөөдөр машинтай явж байна уу?	君は今日自動車で移動していますか？	\N		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
5	Ажил төрөл сайн уу?	仕事のほうは、順調？			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
830	Манай аав удахгүй Солонгос руу ажлаар явна.	父はもうすぐ韓国へ仕事で行きます。	\N		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
831	Маргааш чам руу утасдана.	明日君に電話します。	\N		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
832	Та хэзээ хот явах вэ?	あなたはいつ首都に行きますか？	\N		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
833	Аав хүний туслалцаагүй энэ байшинг барьж байна.	父は他人の手助けなしにこの建物を建てています。	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
834	Би өнөөдрөөс чам шиг идэвхтэй хичээл хийнэ.	私は今日から君のように熱心に勉強します。	\N		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
835	Энэ ажлыг маргааш гэхэд дуусгана.	この仕事は明日までに終了させます。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
836	Бүх юм төлөвлөгөө ёсоор явагдаж байна.	すべては計画どおりに行なわれています。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
837	Би одоо ажил дээрээс ярьж байна.	私は今仕事場から電話しています。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
838	Бид нар зуны турш хөдөө амарлаа.	私たちは夏の間中いなかで静養しました。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
839	Шинэ хүрээлэнг манай их сургуулийн дэргэд байгуулжээ.  	新しい研究所はうちの大学の付属で設置しました。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
840	Байрны гадаа олон хүүхэд сагс тоглож байна.	アパートの外でたくさんの子どもたちがバスケットボールをしています。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
841	Нөгөө номыг хичээлийн өмнө чамаас авна.	例の本は授業の直前に君から受け取ります。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
842	Танай эгчийн царай яг чамтай адилхан байна.	おたくのお姉さんの顔はまさに君と同じです。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
843	Түүнээс гадна ямар асуудал байна вэ?	そのほかにどんな問題がありますか？	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
844	Отгонтэнгэр уул далайн түвшнээс дээш хэдэн метр өндөр вэ?	オトゴンテンゲル山は海抜何メートルの高さですか？	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
845	Түүнтэй зэрэг хичээл амарлаа.	それと同時に学期が終了しました。	\N		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]		0	1
846	Би Монголын түүхийг сонирхож байна.	私はモンゴルの歴史に興味を持っています。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
847	Сөрөг хүчин Засгийн газрын саналыг эсэргүүцэж байна.	野党は政府案に反対しています。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
849	Монгол улсын Ерөнхийлөгч Японд айлчилжээ.	モンゴル国大統領は日本を訪問しました。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
850	Энэ асуудал чухам юунаас шалтгаалж байна вэ?	この問題は一体何に起因していますか？	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
851	Энэ номыг их дэлгүүрээс авлаа.	この本はデパートで買いました。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
852	Манай хүүхэд нохойноос нэг их айхгүй.	うちの子どもは犬をそれほど怖がりません。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
853	Бид нар бүгд чамаар бахархаж байна.	私たちはみんな君を誇りに思っています。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
854	Энийг доллараар солих уу?	これをドルと交換しますか？	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
855	Та одоо гэртээ байна уу?	あなたは今（自分の）家にいますか？	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
856	Би хүүгээрээ бахархаж байна.	私は（自分の）息子を誇りに思っています。	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
857	Чи өнөөдөр аавынхаа машинаар явж байна уу?	君は今日（自分の）お父さんの自動車で移動していますか？	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
858	Түргэн хоолны газарт өөрөө өөртөө үйлчилнэ.	ファーストフード店では自分で自分にサービスします。	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
859	Өөрөө хэн бэ?	どなたですか？	\N		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
860	Манай яамны жолоочид энэ өрөөнд байна.	うちの役所の運転手たちはこの部屋にいます。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
861	Монгол улсын Ерөнхий сайд Зүүн Европын орнуудад айлчилж байна.	モンゴル国首相は東ヨーロッパ諸国を歴訪しています。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
862	Дотуур байрны хүүхдүүд гадаа тоглож байна.	寄宿舎の子どもたちが外で遊んでいます。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
863	Өнөөдөр төв гудамжинд оюутнуудын жагсаалт болжээ.	今日中央通りで学生たちのデモ行進が行なわれました。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
864	Айлууд цагаан сарынхаа буузыг чимхэж байна.	各家庭は旧正月のボーズを作っています。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
865	Миний төрсөн өдрийн баярт Сэр-Од нар ирлээ.	私の誕生日会にセルオドたちが来ました。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
866	Сувд, Азжаргал нар миний дүү.	ソブドとアズジャルガルは私の妹弟です。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
867	Энэ багш нарын өрөө.	これは職員室です。	\N		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
868	Аав маань хэзээ ирэх вэ?	（１人称複数と関係のある）お父さんはいつ来ますか？	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
869	Би энийг дэлгүүрээс чинь авлаа.	私はこれを（２人称単数と関係のある）店で買いました。	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
870	Чи одоо гэрт нь очих уу?	君は今（３人称と関係のある）家に行きますか？	\N		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
871	Миний өгсөн шалгалт их хэцүү байлаа.	私が受けた試験はとても難しかったです。	\N		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
872	Та кино гарах цагт амжих уу?	あなたはドラマが始まる時刻に間に合いますか？	\N		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
873	Энэ дандаа бид нар луу хуцдаг нохой.	これはいつも私たちに吠える犬です。	\N		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
874	Засгийн газраас гаргасан тогтоол удахгүй сонинд гарна.	内閣が発出した政令はまもなく新聞に掲載されます。	\N		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
875	Дэлхийн хэмжээний тамирчин бэлтгэх ажил үнэхээр хэцүү.	世界レベルのアスリートを養成する仕事は本当に大変です。	\N		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
876	Өчигдөр өвөө эмээ хоёр Архангайгаас ирсэн.	昨日祖父と祖母がアルハンガイから来ました。	\N		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
877	Өнөө өглөө хичээлдээ амжсан уу?	今朝授業に間に合いましたか？	\N		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
878	Багш маань ирээ юү?	先生はもう来たでしょうか？	\N		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
879	Энэ машин манай компанийнх.	この自動車はうちの会社のです。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
880	Гарын тосны оронд нүүрнийхийг түрхсэн.	ハンドクリームの代わりにフェイス用のを塗りました。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
881	Манай найзынх гэр бүлээрээ Казахстан руу нүүсэн.	友だちのところは家族でカザフスタンに移住しました。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
882	Манайх гадаадад мөнгө гуйвуулах үйлчилгээ үзүүлж байна.	わが社では外国に送金する業務を取り扱っています。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
883	Бид нар одоо ингээд танайх руу явна. 	私たちはそろそろおたくへ向かいます。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
884	Би сая Батбаярынд хоол идсэн.	私はさっきバトバヤルのところで食事しました。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
885	Манай ангийнхан бүгд Сансарт амьдарч байна.	うちのクラスメイトは全員サンサル地区に住んでいます。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
887	Би ажлын өдөр өглөө эрт босдог.	私は平日は朝早く起きます。	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
888	Та Монголоор ярьдаг уу?	あなたはモンゴル語で話しますか？	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
889	Манай аав тамхи огт хэрэглэдэггүй.	うちの父は煙草を全然吸いません。	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
890	Ээж одоо хөдөө ажиллаж байгаа.	母は今いなかで働いています。	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
891	Бид нар тун удахгүй хөдөллөө.	私たちはまもなく出発します。	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
892	Чи одоо гэрээсээ гарлаа юу?	君はもう家を出ますか？	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
893	Замдаа хальтрав аа.	道路で滑らないように。	\N		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
6	Сайн сайн, давгүй ээ.	まあまあね。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
894	Өчигдөр ирсэн нь сайн болжээ.	昨日来たことはよい結果になりました。	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
895	Япон руу явахыг аав ээждээ хэлсэн үү?	日本に行くことを両親に言いましたか？	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
896	Уянгыг Англиар сайн ярьдгаар нь танилаа.	英語で上手に話すことからオヤンガであるとわかりました。	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
897	Манай суманд одоо байгаагаас хамаагүй олон хүн амьдарч байжээ.	うちのソムには今いるのよりもずっと多くの人が住んでいました。	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
898	Би өчигдөр уулзалтанд оролцоогүйгээс болж шинэ багштай танилцаагүй.	私は昨日会合に参加しなかったせいで新しい先生と知り合いませんでした。	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
899	Шуурав багш намайг цагтаа ирсэнгүйг хатуу загинав.	ショーラヴ先生は私が時間どおりに来なかったことをきつく叱りました。	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
900	Маргааш явахгүйг яаж мэдсэн бэ?	明日行かないことをどうやって知りましたか？	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
901	Манай нөхөр намайг уурладаггүйд баярлаж байна.	夫は私が怒らないことを喜んでいます。	\N		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
902	Мөндөр олон малтай айлд өссөн.	ムンドゥルは多くの家畜がいる家庭で育ちました。	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
903	Би зураг зурах авьяасгүй хүн.	私は絵をかく才能のない人間です。	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
904	Туул том нүдтэй.	トーラは大きな目をしています。	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
905	Дондовдоржийнх хоёр том машинтай.	ドンドヴドルジのところには２台の大きな自動車があります。	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
906	Надад одоохондоо 600 доллар байна.	私には今のところ600ドルあります。	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
907	Аав өрөөнд алга уу?	お父さんは部屋にいませんか？	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
908	Танай байранд дулаан гараж бий юү?	おたくのアパートには暖房付車庫がありますか？	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
909	Тус улсын нийслэлд таван одтой зочид буудал байхгүй.	その国の首都には五ツ星のホテルはありません。	\N		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
910	Ээж цагаан винонд дуртай.	母は白ワインが好きです。	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
911	Би бейсболд ёстой дургүй.	私は野球が本当に嫌いです。	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
912	Манай эмэгтэй дүү завтай үедээ дэлгүүр хэсэх дуртай.	妹は暇があるときにお店を回るのが好きです。	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
913	Би бүжиглэх дургүй.	私は踊るのが嫌いです。	\N		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
914	Сувд дэлгүүрээс хоол унд цуглуулж, Азжаргал гэр орноо цэвэрлэлээ.	ソブドは店で食料品を買い、アズジャルガルは家を掃除しました。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
915	Манайх шинэ жилийг гэртээ хэвтэж өнгөрөөсөн.	うちは新年を家でゴロゴロして過ごしました。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
916	Би гэрээсээ гарч шууд сургууль руу очлоо.	私は家を出てそのまま学校に行きました。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
917	Энхжин хүүхдээ цэцэрлэгт хүргээд ажил руугаа явдаг.	エンフジンは子どもを幼稚園に届けてから職場に向かいます。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
918	Та энд жаахан байж байгаад явахгүй юү? 	少しここにいてから行きませんか？	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
919	Би намраас Чехэд очиж ажиллах бөгөөд дараа жил ирнэ.	私は秋からチェコに行って働き、来年来ます。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
920	Батчулуун багш факультетийн декан бөгөөд шалгалтын комиссийн дарга.	バトチョローン先生は学部長で試験委員会の委員長です。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
921	Миний хүү өнөөдөр сургуульдаа явахгүйгээр гэртээ унтаж байна.	息子は今日は学校へ行かずに家で寝ています。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
922	Нөгөө номыг дүүдээ өгөлгүй хүүдээ өгсөн.	例の本は弟にやらないで息子にやりました。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
923	Би одоохондоо багш биш бөгөөд докторант.	私は今のところは教師ではなく博士課程の学生です。	\N		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
924	Бээжингийн онгоцны тийз аль хэдийн дууссан байлаа.	北京便の飛行機のチケットはとっくに売り切れていました。	\N		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
925	Би чамаас өмнө очсон байх болно.	私は君よりも先に行っています。	\N		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
926	Нөгөө номыг чиний ширээн дээр тавьсан байна.	例の本は君の机の上に置いてあります。	\N		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
927	Япон улсын Гадаад хэргийн сайд 1988 онд анх удаа БНМАУ-д айлчилсан байна.	日本の外務大臣は1988年に初めてモンゴル人民共和国を訪問しています。	\N		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
929	Би түүний учрыг хэнээс ч асуугаагүй.	私はその事情を誰にもたずねませんでした。	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
930	Миний хүү ямар ч ногоо иддэг.	息子はどんな野菜でも食べます。	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
931	Тийм газар манай хотын хаана ч байхгүй.	そんな場所はわが街のどこにもありません。	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
932	Ийм машиныг хэзээ ч авахгүй.	こんな自動車は絶対に買いません。	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
933	Намайг талбайд очиход жагсаалт тарсан байлаа.	私が広場に行ったとき、デモは解散していました。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
934	Би Монголд буцахдаа аавдаа япон сакэ авдаг.	私はモンゴルに帰るとき、父親に日本酒を買うことにしています。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
935	Би шөнө нойр хүртэл хөгжим сонсдог.	私は夜眠くなるまで音楽を聴きます。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
936	Аав залуудаа үхтлээ ажиллаад их хөгширчээ.	父は若いとき死ぬほど働いてとても老けてしまいました。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
937	Манайх анх хотод нүүж ирсээр Сансарт амьдарч байна.	我が家は初めて首都に来て以来ずっとサンサル地区に住んでいます。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
938	Бид нар чамайг утсаар ярьсны дараа явна.	私たちは君が電話したあとで出かけます。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
939	Намайг бага байх үед автобусны билет 50 мөнгө байсан.	私が小さかったとき、バスの切符は50ムングでした。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
940	Багш надтай уулзах болгондоо манай эгчийн тухай асуудаг. 	先生は私と会うたびに姉のことをたずねます。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
941	Хонх дуугарахтай зэрэг ангиас хүүхдүүд гараад ирлээ.	チャイムが鳴ると同時に、校舎から子どもたちが出てきました。	\N		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
942	Намайг бага байх үед ээж өглөө эрт босож цай чанадаг байлаа.	私が小さかったとき、母は朝早く起きてお茶を沸かしていました。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
943	Тухайн үед дэлгүүрт хэн ч авахгүй давс байдаг байлаа. 	当時、店には誰も買わない塩が（いつも）ありました。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
944	Хүлээн авалтанд дарга нар ирээд байна.	レセプションには幹部たちが（次々と）到着しています。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
945	Түрүүнээс хойш миний гэдэс өвдөөд байна.	さっきから私の腹が痛い状態が続いています。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
946	Би өчигдөр өдөржингөө гэртээ хичээл хийсээр байсан.	私は昨日は一日中（ずっと）家で勉強していました。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
947	Нөгөө ном дэлгүүрт байсаар байна.	例の本は店に（ずっと）あります。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
948	Миний хүү компьютерээр тоглосоор л байна.	息子はパソコンで（まだ）遊んでいます。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
949	Би япон хэлийг бараг 10 жилийн турш сурсаар ирсэн.	私は日本語をほぼ10年の間勉強し続けてきました。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
950	Энэ номыг уншиж уншиж арай гэж ойлголоо.	この本は読み続けてようやっと理解しました。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
951	Миний хүү уйлан уйлан сая унтлаа.	息子は泣き続けてついさきほど寝ました。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
7	Танайхан сайн биз дээ?	ご家族ははみんな、元気？			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
952	Би Цэцэгмааг хайгаад хайгаад олсонгүй.	私はツェツェグマーを探し続けて（結局）見つけませんでした。	\N		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]		0	1
953	Би яг одоо хичээл хийгээгүй байна.	私は今現在は勉強をしないでいます。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
954	Би одоогоор арай хичээл хийгээгүй байна.	私は今のところはまだ勉強をしていません。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
955	Би түрүүнээс хойш хичээл хийгээгүй байна.	私はさっきから勉強をしないでいます。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
956	Би түрүүнээс хойш хичээл хийгээгүй байгаа.	私はさっきから勉強をしないでいます。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
957	Би яг тэр үед хичээл хийгээгүй байсан.	私はちょうどそのときは勉強をしないでいました。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
958	Би тэр үед арай хичээл хийгээгүй байсан.	私はそのときはまだ勉強をしていませんでした。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
959	Би зуны амралтаас хойш намар болтол хичээл хийгээгүй байсан.	私は夏休み以降秋まで勉強をしないでいました。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
960	Би багадаа бараг хичээл хийдэггүй байсан.	私は子どものころほとんど勉強をしませんでした。	\N		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
961	Сарнай, чи маргааш ирэх үү?	サルナイ（さん）、君明日来る？	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
962	Авхинсүх багшийнх манай байранд байдаг.	アヴヒンスフ先生の家はうちのアパートにあります。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
963	Манай сургуулийн арга хэмжээнд Болормаа гишүүн оролцож үг хэлнэ.	うちの学校の行事にはボロルマー議員が参加してスピーチします。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
964	Цэндээ эгч хаачсан бэ?	ツェンデーさんはどこに行きましたか？	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
965	Элчин сайд Амарсанааг эх орондоо эгүүлэн татлаа.	アマルサナー大使を本国に召還しました。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
966	Монгол улсын Гадаад хэргийн сайд Ц.Мөнх-Оргил БНСУ-д албан ёсны айлчлал хийлээ.	ムンフオルギル外務大臣は韓国を公式訪問しました。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
968	Санжмятав гуайгаас ярилцлага авлаа.	サンジミャタヴ氏にインタビューを行ないました。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
969	Нөхөр Лувсан та бүхэнд үг хэлнэ.	ロブサン同志より皆様にご挨拶をいたします。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
970	2002 онд Эрхэм дээд Ханхүү Акишино Гүнжийн хамт Монгол улсад айлчилсан байна.	秋篠宮同妃両殿下はに2002年にモンゴル国をご訪問されています。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
971	Монгол улсаас Япон улсад суугаа Онц бөгөөд Бүрэн эрхт Элчин сайд, Эрхэмсэг ноён З. Батжаргал	駐日モンゴル国特命全権大使ザムビーン・バトジャルガル閣下	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]		0	1
972	Өглөө эрт цас орж эхэллээ.	朝早く雪が降り始めました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
973	Номин түүний ярихыг сонсоод гэнэт уйлж гарлаа.	ノミンは彼が話すのを聞いて突然泣き出しました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
974	Чи миний толь бичгийг хэрэглэж дууссан уу?	私の辞書を使い終わりましたか？	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
975	Энэ сарын эцэс гэхэд эхийг бичиж дуусгана.	今月の末までに原稿を書き終えます。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
976	Баярмаа багаасаа ширээний теннисээр хичээллэж ирсэн.	バヤルマーは子どものころから卓球をしてきました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
977	Сая яг чам руу ярих гэж байсан.	さっきまさに君に電話するところでした。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
978	Энэ хүүхэд худлаа ярих гээд байна.	この子はうそをつこうとしています。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
979	Өчигдөр манайд дайн болох шахсан.	昨日うちでは紛争が起こりそうになりました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
980	Намайг гэртээ ирэхэд хулгайч цонхоор орохоор завдаж байлаа. 	私が帰宅したとき、泥棒が窓から侵入しようとしていました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
981	Азжаргал ирэх жилээс АНУ-д суралцахаар боллоо.	アズジャルガルは来年から米国に留学することになりました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
982	Би оюутан болсноос хойш тамхи татдаг болсон.	私は学生になってから（＝大学に入ってから）喫煙するようになりました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]		0	1
983	Тантай дахиж уулзах тэр өдрийг тэсэн ядан хүлээж сууна.	再びお会いするその日を楽しみに待っています。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]		0	1
984	Өчигдөр бид нар далайн эрэг дээр сайхан амарч хэвтлээ.	昨日、私たちはビーチでしっかり静養しました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]		0	1
985	Дээрэмчин таксигаар зугтаж харагдлаа.	強盗がタクシーで逃走するのが目撃されました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]		0	1
986	Юу ч гэсэн манай ангийнхан үзэж тарсан.	うちのクラスではとにかく調べてはみました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]		0	1
987	Ямар ч байсан энийг орчуулж алдлаа.	いずれにしてもこれを翻訳してみました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[16]		0	1
988	Та түүхий загаснаас амсаж үзэхгүй юү?	刺身を味見してみませんか？	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[17]		0	1
989	Үүний учрыг Энхнасан надад тайлбарлаж өгсөн.	この事情をエンフナサンが私に説明してくれました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[18]		0	1
990	Социализмын үеийн оюутнууд багшийн ярьсан үгийг дэвтэртээ шууд бичиж авдаг байсан.	社会主義時代の学生は教官が話したことをノートにそのまま書き写していました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[19]		0	1
991	Миний машин эвдрээд хаясан.	私の自動車は壊れてしまいました。	\N		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[20]		0	1
992	Би энэ компьютерийг найзаасаа 336.800 （гурван зуун гучин зургаан мянга найман зуун） төгрөгөөр авсан. 	私はこのパソコンを友だちから33万6800トゥグルグで買いました。	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
993	Монгол улс 2.564.032 （хоёр сая таван зуун жаран дөрвөн мянга гучин хоёр） хүн амтай.	モンゴル国は256万4032人の人口を有しています。	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
994	Энэ үйлдвэрийг 476.256.000.000 （дөрвөн зуун далан зургаан тэрбум хоёр зуун тавин зургаан сая） иений өртгөөр байгуулжээ.	この工場は4762億5600万円の費用で建設しました。	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
995	Өнгөрсөн онд Японы улсын төсвийн хэмжээ ойролцоогоор 88.780.000.000.000 （наян найман триллион долоон зуун наян тэрбум） иен байсан.	昨年度の国の予算額は約88兆7800億円でした。	\N		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
996	Энэ дэлгүүрээс авмаар юм байна уу?	この店で買いたいものがありますか？	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
997	Тэр үнэхээр хамт баймааргүй хүн.	あの人は本当に一緒にいたくない人です。	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
998	Миний хүүгийн чадахуйц ажил байна уу?	息子にできそうな仕事はありますか？	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
999	Энэ та нарын анхаарууштай асуудал.	これはあなたたちが取り上げるべき問題です。	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1000	Жавхлан шинийг санаачлагч хүн.	ジャヴフランは新しいことを提案する人です。	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1001	Манай эгч герман хэлний орчуулагчаар ажилладаг.	姉はドイツ語の通訳として働いています。	\N		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1002	Би амьдралдаа тэгж хоол хийж үзээгүй.	私は生まれてからそのように料理を作ったことはありません。	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1003	Энэ гийгүүлэгчийг дуудахдаа хэлээ ингэж тагнайд наана.	この子音を発音するときには、舌をこのようにして口蓋に付けます。	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1004	Өнөөдөр хичээлийн дараа номын санд суух уу?  Тэгнэ.	今日放課後に図書館で勉強しますか？はい、そうします。	\N		\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1005	Та нар аав ээжтэйгээ сайн зөвлө.	君たちは両親とよく相談しなさい。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1007	Та дахиад ярьж өг дөө.	もう一度言ってください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1008	Одоо манайд ир л дээ.	今度はうちに来てくださいな。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1009	За, ид ид.	さあ、食べてください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1010	Үдээс хойш багш нарын өрөөнд ирээрэй.	午後職員室に来てください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1011	Та энэ бэлдмэлийг өдөр бүр уугаарай.	このサプリメントを毎日お飲みください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1012	Чи хурдан яваач.	君、早く行けよ。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1013	Та надад нэг туслаад өгөөч.	ちょっと手伝ってもらえませんかね。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
1014	Та дээшээ сууна уу.	上座にお座りになってください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
1015	Та надад кофе чанах аргыг зааж өгөх үү?	私にコーヒーを沸かす方法を教えていただけますか？	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]		0	1
1016	Орон бүхний пролетари нар нэгдэгтүн!	万国の労働者団結せよ！	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]		0	1
1017	Та нар хоорондоо сайн тунгааж ярилц, за юу.	君たちはお互いにしっかり話し合いなさい、いいですね。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]		0	1
1018	Надаас зайл, мэдэв үү.	私から離れろ（＝近づくな）、わかったな。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[14]		0	1
1019	Үүнээс хойш байнга захиа бичиж байгаарай.	これからはずっと手紙を書いてください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[15]		0	1
1020	Миний найзууд бүгд 11-р （арван нэгдүгээр） хороололд амьдардаг.	私の友だちはみんな第11団地に住んでいます。	\N		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1021	Би 33-р （гучин гуравдугаар） сургуулийн биологийн сонгоныг төгссөн.	私は第33学校の生物特別クラスを卒業しました。	\N		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1022	Эмээ II (хоёрдугаар) эмнэлэгт хэвтэж байна.	おばあさんは第２病院に入院しています。	\N		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1023	Намайг Дорноговьд ирснээс хойш 2 жил 9 сар өнгөрлөө.	私がドルノゴビに来てから２年９ヶ月がたちました。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1024	Хуулийн төслийг өргөн мэдүүлсэн өдрөөс хойш 45 хоногийн дотор батална.	法案は上程した日から45日以内に可決します。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1025	Шалгалт 2 цаг 40 минутын дараа эхэлнэ.	試験は２時間40分後に始まります。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1026	Та Японд хэдэн жил амьдарч байна вэ?	あなたは日本に何年いますか？	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1028	БНМАУ, Япон улс хоёр 1972 оны 2 сарын 24-ний өдөр дипломат харилцаа тогтоосон байна.  	モンゴル人民共和国と日本国は1972年２月24日に外交関係を樹立しています。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1029	Та хэдэн сарын хэдэнд нутагтаа буцах вэ?	あなたは何月何日に里帰りしますか？	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1030	Өчигдөр 20 цаг 46 минутанд метро дотор гэнэт тэсрэх бодис дэлбэрчээ.	昨日20時46分に地下鉄の中で突然爆発物が爆発しました。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1031	Одоо цаг хэд болж байна вэ?	今何時になっていますか？	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
1032	12:40 （арван хоёр дөч） болж байна.	12時40分です。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
1033	13 цагт 20 минут дутуу байна.	13時20分前です。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]		0	1
1034	Сарнаас авчирсан чулууг 2 сараас төв музейд байрлуулна.	月から持ってきた石を２月から中央博物館に収蔵します。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]		0	1
1035	3 цагийн дараа их дэлгүүрийн цагны тасагт уулзах уу?	３時間後にデパートの時計売り場で会いましょうか？	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[13]		0	1
1036	Миний хүү цэцгийг ягаанаар будлаа.	息子は花の絵をピンクで塗りました。	\N		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1037	Хоёр залуу манай хаалгыг тогшсон.	２人の若者が我が家のドアをノックしました。	\N		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1038	Энэ аппаратаар агаарын халуун хүйтнийг хэмждэг.	この装置で大気の寒暖を測定します。	\N		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1039	Амгалан надаас "Чи хэзээ Япон явах вэ?" гэж асуусан.	アムガランは私に「君はいつ日本に行きますか？」とたずねました。	\N		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1069	Аюуш Англиар сайн ярьдаггүй бол, Уянга чөлөөтэй.	アヨーシは英語でよく話しませんが、オヤンガは流暢です。	\N		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1040	Хэлтсийн дарга ажилтнуудад "Та нар ажлаа гүйцэд хий. Ажлын цагаар хэн мессеж бичиж байна" гэж загинав.	課長は職員に「仕事をきちんとしなさい。勤務時間中に誰がメールをしている」と叱りました。	\N		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1041	Мэндбаяр хоол идэхгүй гэж хэлсэн.	メンドバヤルは食事をしないと言いました。	\N		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1042	Би Санжаа багшийг энэ жил тэтгэвэрт гарсан гэж бодож байсан.	私はサンジャー先生が今年定年退職したと思っていました。	\N		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1044	Та тийм юм битгий ярьж байгаарай.	そんなことを（もうこれからは）言わないでください。	\N		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1045	Чи өнөөдөр унтаж болохгүй, хичээлээ давт.	君は今日は寝てはいけません、復習をしなさい。	\N		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1046	Олон нийтийн газар согтууруулах ундаа хэрэглэхийг хориглоно.	公共の場所でアルコール飲料を飲むことを禁じます。	\N		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1047	Та нар маргааш гэртээ амарч болно.	君たちは明日自宅で休んでもかまいません。	\N		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1048	Бид нар одоо явж болох уу?	私たちはもう行ってもいいですか？	\N		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1049	Энэ ямар гоё бэлэг вэ!	これは何とすてきなプレゼントでしょう。	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1050	Яасан халуун амтлагч вэ!	何と辛い調味料でしょう。	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1051	Чи ямар чалчаа юм бэ!	君は何とおしゃべりなんだろう。	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1052	Чи яасан сонин ярьдаг юм бэ!	君は何とおかしな話し方をするんだ。	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1053	Өө, цамцаа ингэж индүүддэг юм байна.	へえ、シャツはこうやってアイロンをかけるんだ。	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1054	Танай хүүхэд ганцаараа алхдаг болсон юм байна.	おたくのお子さんはもう一人で歩くようになったんですね。	\N		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1055	Зулаа хүүхдээ гадаа тоглууллаа.	ゾラーは子どもを外で遊ばせました。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1056	Хүчтэй салхи лааны галыг унтраасан.	強い風がろうそくの火を消しました。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1057	Цогбадрал багш бид нараар том глобус хийлгэсэн.	ツォグバドラル先生は私たちに大きな地球儀を作らせました。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1058	Би дүүгээрээ чам руу мөнгө явуулуулсан.	私は弟を通じて君にお金を送らせました。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1059	Архи даадаггүй хүнд хүчээр уулгаж болохгүй.	酒が飲めない人に無理やり飲ませてはいけません。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1060	Захирал ажилчдаар шинэ харилцагчийг олуулах гэж байна.	社長は社員たちに新しい取引先を見つけさせようとしています。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1061	Захирал ажилчдад урамшуулал олгох гэж байна.	社長は社員たちにボーナスを支給しようとしています。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1062	Түрүүн авсан зургийг зурагчинд угаалгасан.	先日撮った写真を写真屋で現像しました。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1063	Би эгчээрээ хонхны баярт өмсөх дээлийг оёулсан.	私は姉に卒業式で着るモンゴル服を縫ってもらいました。	\N		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
1064	Манай ямаа бүгд чононд идүүлсэн.	うちのヤギはみんなオオカミに食べられました。	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1065	Өчигдөр манай ангийнхан бүгдээрээ Хадбаатар багшид загинуулсан.	昨日うちのクラスメイトは全員ハドバートル先生に叱られました。	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1066	Гадаадын хөрөнгө оруулалтаар Улаанбаатарт том хэмжээний орон сууцны хорооллууд баригдсаар байна.	外国からの投資によってウランバートルに大規模な住宅団地が建設され続けています。	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1067	Энэ санаа надад маш сайхан санагддаг.	このアイディアは私にはとてもすばらしく思われます。	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1068	Ардчиллаас хойш Монголын амьдрал нэлээн өөрчлөгджээ.	脱社会主義以降、モンゴルの生活はかなり変化しました。	\N		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1070	Японд хоол болгонд заавал цагаан будаа иддэг байхад, Германд чанасан төмс иддэг.	日本では毎食必ず白米を食べますが、ドイツではゆでたジャガイモを食べます。	\N		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1071	Би загасанд дуртай байхад, манай нөхөр огт иддэггүй.	私は魚が好きですが、夫は全然食べません。	\N		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1072	Гадаад хэргийн сайд Малайз, Индонез зэрэг Зүүн Өмнөд Азийн орнуудаар айлчиллаа.	外務大臣はマレーシア・インドネシアなどの東南アジア諸国を歴訪しました。	\N		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1073	Ямааны ноолуурыг алт, зэс гэх мэттэй зүйрлэж болохгүй.	カシミアを金や銅に例えてはいけません。	\N		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1074	Би энэ зуны амралтаар Герман мерманд очно.	私はこの夏休みにはドイツかどこかに行きます。	\N		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1075	Сургуулийн баярт гадаад оюутнууд нутаг нутгийнхаа хоол хийдэг.	学校祭では外国人留学生がそれぞれの故郷の料理を作ります。	\N		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1076	Шинэ нийслэлд өндөр өндөр барилга баригдаж байна.	新首都では多くの高いビルが建設されています。	\N		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1077	Та нар энэ гүүрээр гурав гурваараа гараарай.	君たちはこの橋を３人ずつ渡ってください。	\N		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1078	Тухайн үед үндсэндээ айлын эзэн цэвэрлэгээнд оролцох ёстой байжээ.	当時は原則として世帯主が清掃に参加しなければなりませんでした。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1079	Бурхан багшийг шүтдэг хүн энэрэнгүй сэтгэлтэй байх учиртай.	仏様を信じる人間は慈悲の心をもっていて当然です。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1080	Энэ номыг та бүхэн бүгдээрээ уншууштай байна.	この本は君たち全員で読むべきです。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1081	Өнөөдрийн дотор АНУ руу мөнгө гуйвуулах хэрэгтэй.	今日中に米国に送金する必要があります。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1082	Маргааш бид нар өглөө 6 цагт босохгүй бол болохгүй.	明日私たちは朝６時に起きなければなりません。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1083	Ийм чухал асуудалд хайнга хандаж болохгүй.	このような重要な問題に対してはいい加減に対処すべきではありません。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1084	Та нар одоо явсны хэрэггүй.	君たちはもう出かける必要はありません。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1085	Чи тийм жижиг юманд санаа зоволтгүй.	そんな小さなことを心配する必要はありません。	\N		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1086	Чи миний машиныг хамт түлхэлцэж өгөхгүй юү?	君、私の自動車を一緒に押してくれませんか？	\N		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1087	Паспортын газарт хоёр жилийн дараа Дүүрэнжаргалтай тааралдлаа. 	旅券センターで２年ぶりにドゥーレンジャルガルと出くわしました。	\N		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1088	Та нар хоорондоо сайн тунгааж ярилцаарай.	君たちはお互いに十分話し合ってください。	\N		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1090	Өчигдөр бороо орсон тул спартакиад болсонгүй.	昨日雨が降ったので運動会はありませんでした。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1091	Онгоцны тийз олдсонгүй учир энэ зун нутагтаа очоогүй.	飛行機のチケットが手に入らなかったのでこの夏は里帰りしませんでした。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1092	Гадаа харанхуй болсон байсан учраас салхинд гараагүй.	外は暗くなっていたので散歩には出かけませんでした。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1093	Манай ах байнга уудаг болохоор элэг нь хатуужсан байна.	うちの兄はいつも酒を飲むので（すでに）肝硬変になっています。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1094	Одоо мөнгөөр суусан болох дээр гэр лүүгээ алхаж явна.	今一文無しになったんで家まで歩いて行きます。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1095	Надад ямар ч сонирхол байхгүй юм чинь мэдэх юм алга.	私には何の興味もないので知っていることなどありません。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1096	Чамайг орчуулах хойно би санаа амарлаа.	君が通訳する以上私は安心です。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1110	Хэн ч ирэхгүй юм чинь одоо явчих уу?	誰も来ないんでもう行ってしまいましょうか？	\N		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1097	Нэгэнт хийхээс хойш гүйцэт ажиллах хэрэгтэй.	いったん取りかかる以上、完璧に行なう必要があります。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1098	Би анхнаасаа хайнга сурснаас болж одоо болтол буруу ярьдаг.	私は初めからいい加減に学んだせいで今に至るまで間違って話します。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
1099	Багадаа байнга шоколад иддэг байснаар хамаг шүд хорхойтсон. 	小さいころいつもチョコレートを食べていたことによって全部の歯が虫歯になりました。	\N		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]		0	1
1100	Энэ хоолыг үхрийн мах юмуу гахайн махаар хийдэг.	この料理は牛肉または豚肉で作ります。	\N		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1101	Гэрлээгийн утсыг Баярмаагаас юмуу, аль эсвэл Батболдоос асуугаарай.	ゲルレーの電話（番号）はバヤルマーかバトボルドにきいてください。	\N		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1102	Бид нар маргааш автобусаар, үгүй бол манай машинаар явна.	私たちは明日バスまたはうちの自動車で行きます。	\N		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1103	Анкетийн хуудсыг нэг бол харандаа, нэг бол хар балаар бөглөнө үү.	申込用紙は鉛筆または黒のボールペンでご記入ください。	\N		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1104	Японы нутаг дэвсгэрийн 75 хувь буюу ойролцоогоор 290.000 ам дөрвөлжин километр талбайг ой мод эзэлдэг.	日本の国土の75％すなわち約29万平方kmの面積を森林が占めています。	\N		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1105	Өглөө манай нөхөр, хүүхдээ хоёулангий нь цэцэрлэгт хүргэжээ.	朝、夫が子どもをふたりとも幼稚園に送りました。	\N		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1106	Одоо гурвуулаа мөнгөө нийлүүлэх үү?	今度は３人でお金を出し合いますか？	\N		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1107	Манайх 2 өрөөтэй байранд олуулаа амьдардаг байсан. 	我が家は２部屋のアパートに大勢で生活していました。	\N		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1108	Шүдээ хурдан угаачих л даа.	早く歯を磨いてしまいなさいよ。	\N		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1109	Би химийн хичээлийг бүгдийг нь мартчихаж.	私は化学の授業を全部忘れてしまいました。	\N		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1111	Би багадаа ой сайтай хүүхэд байлаа.	私は小さいころ記憶力がいい子どもでした。	\N		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1112	Сайнбаярынх ам бүл олонтой.	サインバヤルのところは家族が多いです。	\N		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1113	Япон орон төрөл бүрийн загасаар баян.	日本は各種の魚類が豊かです。	\N		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1114	Мөндөр зохион бичлэгт мундаг.	ムンドゥルは作文が得意です。	\N		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1115	Энэ мах цагаан сарын бууз хийхэд хангалттай.	この肉は旧正月のボーズを作るのに十分です。	\N		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1116	Би сүүлийн үед архи муу даадаг болсон.	私は最近お酒が飲めなくなりました。	\N		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1117	Төмсний хальсыг дутуу цэвэрлэх нь аюултай байдаг.	ジャガイモの皮をちゃんとむかないのは危険です。	\N		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1118	Би хоршоонд 1200-аад долларын хадгаламжтай.	私は組合に約1200ドルの預金を持っています。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1119	1990-ээд оноос хойш Монголын нийгэм эрс өөрчлөгджээ.	1990年代以降、モンゴルの社会は劇的に変化しました。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1120	Сангийн аж ахуйн ургац хураалтанд манайхаас 200 гаруй оюутан очихоор боллоо.	国営農場の収穫作業にうちからは200人あまりの学生が行くことになりました。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1121	Манай сургуульд 90 орчим гадаад оюутан суралцдаг.	うちの学校では約90人の外国人留学生が学んでいます。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1122	Манайх 70 шахам малтай байлаа.	我が家は約70頭の家畜を持っていました。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1123	Хагалгаанд гурав, дөрвөн эмч оролцжээ.	手術には３～４人の医師が参加しました。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1124	Манай яам нийт дөрөв, таван зуун ажилтантай.	わが省には全部で4～500人の職員がいます。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1186	Түрийвчээ хаана орхисон бол.	財布をどこに忘れたんだろう。	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1125	Хандармаа Австралийн сугалаанд олон сая доллар хожсон.	ハンダルマーはオーストラリアの宝くじで数百万ドルを当てました。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1126	Даваахүү багшийнд Японы тухай хэд хэдэн ном бий.	ダワーフー先生のところに日本についての何冊かの本があります。	\N		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
1127	Гадаа их хүйтэн байгаа учраас таксигаар явъя.	外は寒いのでタクシーで行きます。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1128	Үсээ хараар будуулъя.	髪を黒く染めたいです。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1129	Монгол улсын Үндсэн хуулийн албан ёсны эхийг Төрийн мэдээлэл сэтгүүлд нийтэлж, Монголын радио, телевизээр дамжуулсугай.	モンゴル国憲法の正文原本を官報に掲載し、モンゴル国営ラジオ・テレビを通じて周知せしめる。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1130	За, за, хэн ч ирэхгүй юм чинь одоо явахаас даа.	あーあ、誰も来ないんでもう行こうかな。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1131	Бид нар маргааш өглөө эрт гэрээсээ гарах санаатай.	私たちは明日の朝早く家を出るつもりです。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1132	Одоо хоол иддэг юм уу.	そろそろ食事にしようかな。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1133	Энэ удаа би хоол хийе, тэгэх үү?	今回は私が食事を作りますよ。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1134	Гурвуулаа хамт кино үзье л дээ.	３人で一緒に映画を見ましょうよ。	\N		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1135	Өглөө эрт босох учраас арай эртхэн унтъя.	朝早く起きるので少し早めに寝ましょう。	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1136	Намайг анх Монголд очиход 1 доллар гурван зуухан төгрөг байлаа.	私が初めてモンゴルに行ったとき１ドルはわずか300トゥグルグでした。	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1137	Чи улаавтар өнгөтэй цамцнаас авахгүй юү?	君は赤っぽいシャツを買いませんか？	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1138	Үс чинь ёстой чамайг хөгшиндүү харагдуулж байна.	君のヘアスタイルは本当に老けて見えます。	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1139	Тэр үнэг мэт зальтай хүн байлаа.	彼はキツネのようにずるがしこい人でした。	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1140	Дэлхийн хамгийн өндөр уул хаана байдаг вэ?	世界でもっとも高い山はどこにありますか？	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1141	Тэд нар дугуйгаар холын хол зам туулж сая Монголд орж ирлээ.	彼らは自転車で非常に遠い道のりを走破してやっとモンゴルに入国しました。	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1142	Үүний тухай Монгол улсын Эрүүгийн хуульд тов тодорхой заасан байгаа.	これについてはモンゴル国刑法に非常にはっきりと示してあります。	\N		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1143	Би морь унаж чаддаггүй.	私は馬に乗ることができません。	\N		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1144	Та энэ үгийг ханз үсгээр бичиж чадах уу?	あなたはこの単語を漢字で書くことができますか？	\N		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1145	Насанд хүрээгүй хүүхэд архи тамхи хэрэглэж болохгүй.	未成年の子どもは飲酒と喫煙をすることができません。	\N		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1146	Энэ тохиолдолд урдаа явж байгаа авто хэрэгслийг гүйцэд түрүүлж болох уу?	この場合に前を走っている自動車を追い越すことができますか？	\N		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1147	Өнөө орой танайд очиж амжихгүй юм байна.	今晩はおたくに行くことができないですね。	\N		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1148	Гэрийн даалгавраа яг цагтаа дуусгаж амжсан уу?	宿題は時間内に終えることができましたか？	\N		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1149	Автобус хурдан ирээсэй.	バスが早く来ればいいのに。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1150	Маргааш битгий цас ороосой.	明日雪が降らないといいのに。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1151	Сайн үйлс дэлгэрэх болтугай.	善行が広がりますように。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1152	Би танайхаас нэг юм асуух гэсэн юм.	そちらにひとつお聞きしたいことがあるのですが。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1	Сайн байна уу?	こんにちは。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1153	Сүүлийн үед машин бариагүй учраас жаахан барьж үзмээр байна.	最近自動車を運転しなかったので少し運転してみたいです。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1154	Өмнөд туйлд зогсож үзэх юмсан.	南極点に立ってみたいものです。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1155	Би танай сургуульд мэргэжил дээшлүүлэх хүсэлтэй.	私は貴校で研修する希望を持っております。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1156	Нислэгийн үед тамхи татахгүй байхыг хүсье.	飛行中は喫煙しないようお願いいたします。	\N		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1158	Чи хэдтэйгээсээ төгөлдөр хуур сурч эхэлсэн бэ?	君は何歳のときからピアノを学び始めましたか？	\N		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1159	Азжаргал 17-тойдоо их сургуульд орсон.	アズジャルガルは17歳で大学に入りました。	\N		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1160	Хулан түүхий загасаар барахгүй, шарсан загасыг ч иддэггүй. 	ホランは刺身どころか焼き魚さえ食べません。	\N		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1161	Би механик төдийгүй, автомат машиныг ч барьж чаддаггүй. 	私はマニュアルどころかオートマチック車さえ運転できません。	\N		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1162	Энэ хоолонд амтлагчуудыг төдий биш, дан давс ч хийдэггүй.	この料理には、調味料はおろかただの塩さえ入れません。	\N		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1163	Аялалын төлбөрт онгоцны тийз, зочид буудлын үнэ байтугай, 3 удаагийн хоол ч багтаж байна.	旅行代金には、航空券とホテル代だけではなく３度の食事も含まれます。	\N		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1164	Та онгоцоор аймгийн төв битгий хэл, амралтын газрын хажууд ч шууд бууж болно.	飛行機で県庁所在地どころかキャンプ場の横にさえそのまま着陸することができます。	\N		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1165	Анкетийн хуудсыг харандаагаар ч, үзгээр ч бөглөж болно.	申込用紙は鉛筆でもペンでも記入できます。	\N		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1166	Маргааш бид нарыг дүрмээ зөв цээжилсэн эсэхийг шалгана. 	明日、私たちが文法を正しく覚えたかどうかをテストします。	\N		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1167	Дэлгүүрт өндөг байна уу, үгүй юү гэдгийг сайн хараарай.	店に卵があるかどうかをよく見てください。	\N		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1168	Чиний цалинг Оросоор хэр ярьдгаар чинь тогтоох санаатай.	君の給料はロシア語でどの程度話すかによって決定する予定です。	\N		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1169	Би тэр хүнийг хаанаас ирсэн оюутан болохыг сайн мэдэхгүй.	私はあの人がどこから来た学生なのかよく知りません。	\N		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1170	Тус улсын нутаг дэвсгэрийн 2／3-ыг （гуравны хоёрыг）  экваторын чийглэг ой эзэлдэг.	当国の国土の２／３を熱帯雨林が占めます。	\N		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1171	4／5-өөс 6／7-г （тавны дөрвөөс долооны зургааг） хасаж болох уу?	４／５から６／７を引くことができますか？	\N		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1172	Дугуйн тойргийг бодоход диаметрийг 3,14-өөр （гурван бүхэл зууны арван дөрвөөр） үржүүлдэг.	円周を求めるときは直径に3.14をかけます。	\N		\N	gmod	instances081.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1173	Гадаад хүмүүс Монголд ирсэн эхний өдрүүдэд жаахан амьсгаадаж магадгүй.	外国人はモンゴルに来た初めの数日間少し息切れするかもしれません。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1174	Миний дансанд ойролцоогоор 6 сая төгрөг байх ёстой.	私の口座には約600万トゥグルグあるはずです。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1175	Удахгүй аккумулятор суучих нь ээ.	すぐバッテリがあがってしまいそうです。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1176	Одоо нэлээн оройтсон болохоор хэн ч байхгүй нь ээ.	もうかなり遅くなったので誰もいなさそうです。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1177	"Богино хугацаа" ангиллын виз авахад урилга хэрэггүй болсон байх аа.	「短期滞在」の在留資格の査証を取得するのに招聘状は不要になったと思います。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1178	Тэр арай Энхнасан биш байлгүй.	あれはまさかエンフナサンではないでしょう。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
2	Сайн, сайн байна уу?	こんにちは。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1179	Намын удирдлага өчигдрийн шөнө 2 цагт Төв хорооны яаралтай хуралдааныг хийсэн бололтой.	党執行部は昨日深夜２時に中央委員会の緊急集会を行なったようです。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1180	Одоогийн залуучууд ер бусын үзэгдэлд амархан итгэчихдэг юм шиг байна.	今の若者は超常現象を簡単に信じてしまうようです。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1181	Манай аавыг Зүүнбаянд ангийн захирагч байхад цалин нь 750 төгрөг байсан гэнэ ээ.	父がズーンバヤンで部隊の司令官だったとき給料は750トゥグルグだったそうです。	\N		\N	gmod	instances082.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]		0	1
1182	Та тухайн үед НАХЯ-ны （Нийгмийг аюулаас хамгаалах яамны） ажилтан биш байсан гэж үү.	あなたは当時公安省の職員ではなかったというのですか。	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1183	Ким Ир Сен 1986 онд Монголд айлчилсан биш үү.	金日成は1986年にモンゴルを訪問したのではありませんか。	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1184	Энэ таны хадгаламжийн дэвтэр биз?	これはあなたの預金通帳ですよね？	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1185	Уучлаарай, таны алдар хэн билээ?	すみません、あなたのお名前は何でしたっけ？	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1187	Эрхэмсэг ноён та Монголд айлчилж байсан болов уу?	閣下はモンゴルを訪問されたことがおありですか？	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1188	Энэ тохиолдолд эгшиг үсэг гээгддэг, тийм ээ?	この場合は母音字が脱落しますよね？	\N		\N	gmod	instances083.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1189	Манай эрэгтэй дүү ирэх жилээс АНУ-д суралцахаар одоо англи хэлний дамжаанд явж байна.	弟は来年から米国で学ぶために現在英語教室に通っています。	\N		\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1190	Шагдар багш шинэ ном бичих гэж материал цуглуулж байгаа гэнэ ээ.	シャグダル先生は新しい本を執筆しようと資料を集めているそうです。	\N		\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1191	Би одоо нутаг буцах гээд бичиг баримтын ажил хөөцөлдөж байна.	私は今帰郷しようと書類作りにかかっています。	\N		\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1192	Гадаад хэлийг зөв эзэмшүүлэхийн тулд юу юу хэрэгтэй бол?	外国語を正しく習得させるために何が必要でしょうか？	\N		\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1193	Замдаа хальтрахгүйн тулд дугуйндаа гинж хэрэглэе.	道路でスリップしないようにタイヤにチェーンを巻きましょう。	\N		\N	gmod	instances084.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1194	Сүүлийн үед нохойнд хүртэл хувцас өмсгөдөг болсон.	最近は犬にさえ服を着せるようになりました。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1195	Баттөр ах Германаар ч бас ярьж чаддаг.	バトトゥルさんはドイツ語でも話すことができます。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1196	Монгол улс бол тусгаар тогтносон, бүрэн эрхт, Бүгд найрамдах улс мөн.	モンゴル国は、独立し全権を有する共和国である／モンゴル国憲法第１条第１項／。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1197	Цусан дахь шээсний хүчил ихдэлт гэж ямар өвчин бэ?	高尿酸血症とはどんな病気ですか？	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1198	"Есийн тос" гэдэг нь тухайн үед 9 төгрөгөөр зарагдаж байсан Германы тосыг хэлнэ.	「９の油」というのは当時９トゥグルグで売られていたドイツの油を指します。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1199	Ангийнхнаас би л онц авсан.	クラスメイトの中で私だけが優をとりました。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1200	Үдээс хойш намайг сургуульд очиход ангид 2, 3 оюутан л байлаа. 	午後私が学校に着いたとき教室には２～３人の学生しかいませんでした。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1201	Манай хамаатнууд зөвхөн цагаан сарын үеэр барахгүй, наадмын үед ч цуглардаг.  	うちの親戚は旧正月のときだけではなく、ナーダムのころにも集まります。	\N		\N	gmod	instances085.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
1202	Өнөө өглөө бүгдээрээ эрт боссон юм. Тэгсэн чинь….	今朝はみんなで早く起きたんです。そうしたら…	\N		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1203	Ямар ч байсан их сургуулиа төгсөөд шууд Америкт очсон юм. Тэгээд….	とにかく大学を卒業してそのままアメリカに行ったんです。それで…	\N		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
3	Сонин юу байна даа?	最近、どう。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
4	Өө, онцын сонин юмгүй.	そうね、あいかわらずよ。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1204	Тэгээд аргагүйн эрхэнд Элчин сайдын яам руу утасдаад асууж үзсэн байхгүй юү. Тэгсэн чинь….	そして仕方がないので大使館に電話してきいてみたんです。そうしたら…	\N		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1205	Арай гэж билетийг нь олоод анх удаа түүний тоглолтыг үзэхгүй юү. Тэгээд….	やっとのことでチケットを入手して初めて彼女のライブを見たんですよ。それで…	\N		\N	gmod	instances086.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1206	Өглөө эрт явавч өдөртөө хүрэхгүй байх аа.	朝早く出発したとしてもその日のうちには着かないでしょう。	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1207	Өнөөдөр их дэлгүүрт очсон боловч юу ч авахгүйгээр харилаа.	今日デパートに行きましたが、何も買わないで帰りました。	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1208	Би Англиар уншихдаа сайн ч гэсэн чөлөөтэй ярьж чадахгүй юм.	私は英語で読むのは得意ですが自由に話すことができないのです。	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1209	Би цайнд хичнээн дуртай ч гэлээ оройн цагаар уудаггүй.	私はお茶がいくら好きだといっても夜は飲みません。	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1210	Энэ хүүхэд сайн ярьдаг мөртлөө бичихдээ муу.	この子はよくしゃべりますが書くのは苦手です。	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1211	Эртхэн ирээрэй гээд байхад чинь яагаад ийм хожигдоо вэ?	早めに来なさいと言っているのになぜこんなに遅刻した？	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]		0	1
1212	Манай эгч махлаг байж ийм нарийн өсгийтэй гутал авах гээд байх юм.	姉は太っているのにこんな細いヒールの靴を買おうとしているんです。	\N		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1213	Би Отгонболд багшийг огт танихгүй шүү.	私はオトゴンボルド先生とまったく面識がありませんよ。	\N		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1214	Гадаад хэлийг төгс эзэмших нь үнэхээр хэцүү шүү.	外国語を完全にマスターするのは本当に難しいですよ。	\N		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1215	Чи өчигдөр надад тэгж хэлсэн шүү дээ.	君は昨日私にそのように言ったじゃありませんか。	\N		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1216	Энэ үгийн утга шал өөр шүү дээ.	この単語の意味は全然違うじゃありませんか。	\N		\N	gmod	instances088.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1217	Маргааш утсаар ярихаа мартуузай.	明日電話するのを忘れないように。	\N		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1218	Ийм зочин ихтэй байхад ток тасруузай.	このような客が多いときに停電しないといいのですが。	\N		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1219	Тэр жаахан хүүхэд сандлаас уначих вий дээ.	あの小さな子が椅子から落ちないといいのですが。	\N		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1220	Та тийм нимгэн хувцастай даарчих вий.	そんな薄着で寒くしないようにしてください。	\N		\N	gmod	instances089.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
1221	Би чиний ирээдүйн төлөө ингэж санаа тавьж байгаа юм.	私は君の将来のためにこうして気にかけているのです。＝私が気にかけているのは君の将来のためです。	\N		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1222	Би өчигдөр Чулууттай уулзсан биш.	私は昨日チョロートと会ったのではありません。＝私が昨日会ったのはチョロートではありません。	\N		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
62	Байна уу?	もしもし。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
66	Сайн байна уу?	こんにちは。			\N	dmod	mn06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
267	Чи ямар сургуульд сурдаг вэ? 	どこの学校で勉強しているの。			\N	dmod	mn22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
298	Өө тийм үү. 	あぁ、そうですか。			\N	dmod	mn24.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
564	Би завтай үедээ ноосон цамц нэхдэг.	私は余暇にセーターを編みます。	\N		\N	vmod	\N	\N	\N	0	1
650	2 кило үхрийн мах авъя.	牛肉2キロをください。	\N		\N	vmod	\N	\N	\N	0	1
758	Өчигдөр чи юу авлаа?	昨日君何買った？	\N		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
817	Манай ах ирэх сарын эхээр ирнэ.	兄は来月の初めごろに来ます。	\N		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
848	Би тэр үгэнд огт итгэхгүй.	私はあのことばを信じません。	\N		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
928	Энэ зохиолын тухай хэн ч мэднэ.	この作品については誰でも知っています。	\N		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1089	Гэр гэртээ хурдан харьцгаа.	（それぞれの）家に早く帰りなさい。	\N		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]		0	1
8	Сайн сайн, бүгд ажил төрлөө хийж байна.	うん、みんな元気になんとかやってるわ。			\N	dmod	mn01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
203	За.	はい。			\N	dmod	mn16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
282	Сорбонийн Их Сургуульд... 	ソルボンヌ大学だよ。			\N	dmod	mn23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
313	Хүүе! Маргааш орой «Харанга» хамтлагийн тоглолт байна. Үзье байз. 	でも明日の晩はハランガのコンサートがあるよ。観ようよ。			\N	dmod	mn26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
343	Тэгье, тэгье. 	はい、わかりました。			\N	dmod	mn29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
371	Нээрээ тийм. 	たしかにそうだね。			\N	dmod	mn32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
579	Ямар халуун өдөр вэ. Одоо усанд оръё.	なんて暑い日だ。一風呂浴びるとするか。	\N		\N	vmod	\N	\N	\N	0	1
618	Тавдахь өдөр Дорж багш ирдэг үү?	金曜日、ドルジ先生はいらっしゃいますか。	\N		\N	vmod	\N	\N	\N	0	1
696	Япончууд хоолондоо цуу их хэрэглэдэг.\n	日本人は料理をするとき醤油を多く用います。	\N		\N	vmod	\N	\N	\N	0	1
886	Өчигдөр өрөөнийхэнтэйгээ цонхоо дулааллаа.	昨日ルームメイトと一緒に窓の目張りをしました。	\N		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]		0	1
967	Дуучин Дэлгэрмөрөнгийн шинэ цомог гарлаа.	歌手のデルゲルムルンのニューアルバムがリリースされました。	\N		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]		0	1
1006	Та ундаа уу.	飲み物を飲んでください。	\N		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1027	Миний хүү хонин жилтэй.	息子は未年です。	\N		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]		0	1
1223	Нөгөө орчуулгыг Хатанбаатараар хийлгэсэн юм уу?	例の翻訳はハタンバートルにやってもらったのですか？＝例の翻訳をやってもらったのはハタンバートルですか？	\N		\N	gmod	instances090.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]		0	1
1224	Би Амгалантай тааралдаад их гайхлаа. Тэр ганц жилийн дотор нэлээн өөрчлөгдсөн юм.	私はアムガランと出くわしてとても驚きました。彼はわずか１年の間にすっかり変わったのです。	\N		\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]		0	1
1225	Танай орц хав харанхуй байна. Ток тасарсан юм уу?	（アパートの）階段が真っ暗です。停電したのですか？	\N		\N	gmod	instances091.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]		0	1
1226	Өчигдөр би үд болтол унтлаа.	昨日、私は昼まで寝ました。	\N		\N	vmod	\N	\N	\N	0	1
1227	Чи усанд сэлж  чадах уу?	君、泳げる？	\N		\N	vmod	\N	\N	\N	0	1
1228	Төмсийг амттай шарж болгохын тулд 2-3 минут урьдчилан халуун бүлээн усанд байлгана.	じゃがいもをおいしくするために、焼く前に生のじゃがいもを２－３分お湯につけます。	\N		\N	vmod	\N	\N	\N	0	1
1229	Удахгүй бороо орох шинжтэй дэг шүү.\n	雨が降りそうですよ。\n	\N		\N	vmod	\N	\N	\N	0	1
1230	Ажил хийгээд ядарсан үед зайрмаг ч юмуу чихэрлэг зүйл идэхээр сэтгэл сайхан болдог.	仕事で疲れたときにアイスクリームか何か甘いものを食べるとほっとします。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: mn
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	4	行く	1	1
2	5	英語	1	1
3	6	飛行機	1	1
4	7	外国	1	1
5	8	外国人	1	1
6	9	モンゴル語	1	1
7	10	ホテル	1	1
8	11	日本語	1	1
9	4	出掛ける	1	1
10	12	国（くに）	1	1
11	13	会う	1	1
12	14	休み	1	1
13	15	旅行	1	1
14	16	旅行する	1	1
15	17	遊ぶ	1	1
16	18	大使館	1	1
17	19	大好き	1	1
18	20	好き	1	1
19	21	上手（じょうず）	1	1
20	22	走る	1	1
21	23	ゆっくり	1	1
22	24	下手（へた）	1	1
23	25	歩く	1	1
24	26	泳ぐ	1	1
25	27	速い［スピードが～］	1	1
26	28	飛ぶ	1	1
27	29	スポーツ	1	1
28	30	嫌い	1	1
29	31	プール	1	1
30	32	バス	1	1
31	33	自転車	1	1
32	34	交差点	1	1
33	35	道（みち）	1	1
34	36	池	1	1
35	37	散歩	1	1
36	38	かわ（川・河）	1	1
37	39	タクシー	1	1
38	40	自動車，車（くるま）	1	1
39	41	曲がる	1	1
40	42	ネクタイ	1	1
41	43	ワイシャツ	1	1
42	44	会社	1	1
43	45	背広	1	1
44	46	やる	1	1
45	47	吸う	1	1
46	48	電話	1	1
47	49	仕事	1	1
48	50	働く・勤める	1	1
49	51	忙しい	1	1
50	52	図書館	1	1
51	53	辞書，字引	1	1
52	54	借りる	1	1
53	55	新聞	1	1
54	56	読む	1	1
55	57	本	1	1
56	58	コピー	1	1
57	59	コピーする	1	1
58	60	雑誌	1	1
60	61	牛肉	1	1
61	62	安い	1	1
62	63	店	1	1
63	64	高い	1	1
64	65	いくつ	1	1
65	66	いくら	1	1
66	67	果物	1	1
67	68	野菜	1	1
68	69	魚	1	1
69	70	豚肉	1	1
70	71	鳥肉	1	1
71	72	肉	1	1
72	73	欲しい	1	1
73	74	渡す	1	1
74	75	八百屋	1	1
75	76	かぎ（鍵）	1	1
76	77	料理	1	1
77	78	買い物する	1	1
78	79	洗濯する	1	1
79	80	掃除する	1	1
80	81	家族	1	1
81	82	家庭	1	1
83	83	洗濯	1	1
84	84	うち（家）	1	1
85	84	家（いえ）	1	1
87	85	かえる（帰・返）	1	1
88	86	本棚	1	1
89	87	机	1	1
90	88	椅子（いす）	1	1
91	89	部屋	1	1
92	90	冷蔵庫	1	1
93	91	洗う	1	1
94	92	ベッド	1	1
95	93	ラジオ	1	1
97	94	～という名前です	1	1
98	95	寝る	1	1
99	96	起きる	1	1
100	87	テーブル	1	1
101	97	テレビ	1	1
102	98	お巡りさん	1	1
103	98	警官	1	1
104	99	地図	1	1
105	100	そば	2	1
106	101	ここ,こちら, こっち	1	1
107	102	そこ,そちら, そっち	1	1
108	102	あちら, あっち，あそこ	1	1
109	103	どこ,どちら,どっち	1	1
110	104	交番	1	1
111	105	近く	2	1
112	100	隣	1	1
113	106	きく	1	1
114	107	切る	1	1
115	108	短い	1	1
116	109	後ろ	1	1
117	110	前	1	1
118	111	右	1	1
119	112	左	1	1
120	113	長い	1	1
121	114	座る	1	1
122	96	立つ	1	1
123	115	友達	1	1
124	116	クラス	1	1
125	116	教室	1	1
126	117	廊下	1	1
127	118	学校	1	1
128	119	生徒	1	1
130	121	学生	1	1
131	122	留学生	1	1
132	123	夏休み	1	1
133	124	先生	1	1
134	125	大学	1	1
135	126	ノート	1	1
136	120	授業	1	1
137	127	作文	1	1
138	128	宿題	1	1
139	129	難しい	1	1
140	130	教える	1	1
141	131	テスト	1	1
142	132	練習	1	1
143	133	易しい	1	1
144	134	練習する	1	1
145	135	質問	1	1
147	136	答える	1	1
148	137	痛い	1	1
149	138	歯	1	1
150	139	医者	1	1
151	140	病院	1	1
152	141	病気	1	1
153	142	薬（くすり）	1	1
154	143	死ぬ	1	1
155	144	風邪（かぜ）	1	1
156	145	頭（あたま）	1	1
157	146	お腹	1	1
158	147	度（ど）	1	1
159	148	エレベーター	1	1
160	149	切符	1	1
161	150	おりる	1	1
162	151	階段	1	1
163	152	閉める	1	1
164	153	駅	1	1
165	154	地下鉄	1	1
166	114	乗る	1	1
167	155	開ける	1	1
168	156	お手洗い	1	1
169	156	トイレ	1	1
170	157	電車	1	1
171	158	飲み物	1	1
172	159	コーヒー	1	1
173	160	喫茶店	1	1
174	161	レモン	1	1
175	162	牛乳	1	1
176	163	砂糖	1	1
177	164	カップ	1	1
178	165	お茶	1	1
179	166	紅茶	1	1
180	167	コップ	1	1
181	46	入れる	1	1
183	169	飲む	1	1
184	170	はし	1	1
185	171	酒	1	1
186	168	おいしい	1	1
187	172	ナイフ	1	1
188	173	スプーン	1	1
189	174	フォーク	1	1
190	175	チーズ	1	1
191	176	食べる	1	1
192	177	まずい	1	1
193	178	パン	1	1
194	179	辛い	1	1
195	180	レストラン	1	1
196	181	食堂	1	1
197	182	酒・ワイン	1	1
198	77	食べ物	1	1
200	183	お金	1	1
201	184	銀行	1	1
202	185	入り口	1	1
203	186	どうぞ,どういたしまして	1	1
204	187	いいえ	1	1
205	188	ええ	1	1
206	189	すみません	1	1
208	190	出口	1	1
209	191	着く	1	1
210	192	ポスト	1	1
211	193	はがき	1	1
212	194	張る	1	1
213	195	封筒	1	1
214	196	手紙	1	1
215	197	郵便局	1	1
216	198	返す	1	1
217	199	出す	1	1
218	200	切手	1	1
219	201	荷物	1	1
220	202	枚	1	1
221	203	貸す	1	1
222	204	買う	1	1
223	205	帽子	1	1
224	206	靴	1	1
226	207	階	1	1
227	208	デパート	1	1
228	209	スカート	1	1
229	210	コート	1	1
230	211	ズボン	1	1
231	212	セーター	1	1
232	213	…てください	1	1
233	214	かばん	1	1
234	215	売る	1	1
235	216	上着	1	1
236	217	ふろ	1	1
237	218	建物	1	1
238	219	台所	1	1
239	220	シャワー	1	1
240	221	窓	1	1
241	114	住む	1	1
242	222	公園	1	1
243	223	ドア	1	1
244	224	浴びる［一風呂～］	1	1
245	225	アパート	1	1
247	226	彼，彼女	1	1
248	227	彼ら，彼女たち	1	1
249	228	私（わたし）	1	1
250	229	私たち	1	1
251	230	だれか	1	1
252	231	だれ	1	1
253	231	どなた	1	1
254	232	きみ	1	1
255	233	あなた	1	1
256	234	この	1	1
257	226	その，あの	1	1
258	235	いかが，どう	1	1
259	236	どの	1	1
260	237	どんな	1	1
261	238	こんな	1	1
263	239	そう	1	1
264	240	厚い	1	1
265	241	狭い	1	1
266	242	細い	1	1
267	243	大きい	1	1
268	244	太い	1	1
269	245	若い	1	1
270	246	広い	1	1
271	247	軽い	1	1
272	248	遠い	1	1
273	249	重い	1	1
274	250	薄い	1	1
275	251	新しい	1	1
276	252	小さい	1	1
277	105	近い	1	1
278	253	古い	1	1
279	254	楽しい	1	1
280	255	にぎやか	1	1
281	256	低い	1	1
282	21	よい	1	1
283	257	明るい	1	1
284	258	弱い	1	1
285	259	強い	1	1
286	260	おもしろい	1	1
287	261	きれい	1	1
289	24	悪い	1	1
290	262	多い	1	1
291	263	暗い	1	1
292	264	静か	1	1
293	252	少ない	1	1
294	265	汚い	1	1
295	266	つまらない	1	1
296	267	横	1	1
297	268	中（なか）	1	1
298	269	外（そと）	1	1
299	112	東（ひがし）	1	1
300	64	高さ	1	1
301	270	縦	1	1
303	111	西（にし）	1	1
304	271	下（した）	1	1
306	272	上（うえ）	1	1
307	273	先（さき）	1	1
310	274	兄	1	1
311	275	兄弟（きょうだい）	1	1
312	276	おばあさん	1	1
313	277	おじいさん	1	1
315	279	母	1	1
317	280	両親	1	1
318	281	父	1	1
319	282	姉	1	1
320	283	姉妹	1	1
322	274	お兄さん	1	1
323	282	お姉さん	1	1
324	281	お父さん	1	1
325	279	お母さん	1	1
326	284	靴下	1	1
327	43	シャツ	1	1
328	285	脱ぐ	1	1
329	286	架ける	1	1
330	287	は（穿）く［ズボンを～］	1	1
331	287	着る	1	1
332	287	かぶる	1	1
334	289	スリッパ	1	1
335	290	傘	1	1
336	291	ポケット	1	1
337	292	財布	1	1
338	293	着ている	1	1
339	294	服	1	1
340	294	洋服	1	1
341	295	口	1	1
342	296	腕（うで）	1	1
343	297	体（からだ）	1	1
344	298	顔	1	1
345	299	脚（あし）	1	1
346	296	手（て）	1	1
347	300	鼻	1	1
348	301	目（め）	1	1
349	302	耳	1	1
350	299	足（あし）	1	1
351	146	おなか	1	1
352	303	皿（さら）	1	1
353	304	バター	1	1
354	164	茶わん	1	1
355	305	あめ	1	1
356	306	昼御飯	1	1
357	307	夕飯（ゆうはん）	1	1
358	305	お菓子	1	1
359	308	卵	1	1
360	309	朝御飯	1	1
361	77	御飯（ごはん）	1	1
362	310	醤油	1	1
363	311	塩（しお）	1	1
364	307	晩御飯	1	1
365	312	くわえる	1	1
366	313	つける	1	1
367	314	カメラ	1	1
368	315	ストーブ	1	1
369	316	鉛筆	1	1
370	317	消す	1	1
371	318	眼鏡（めがね）	1	1
372	319	テープレコーダー	1	1
373	320	時計	1	1
374	321	コンピュータ	1	1
375	322	フィルム	1	1
376	223	戸（と）	1	1
378	324	ペン	1	1
381	325	八月	1	1
382	326	四月	1	1
383	327	今月	1	1
384	328	毎月（まいつき）	1	1
385	329	十二月	1	1
386	330	二月	1	1
387	331	一月	1	1
388	332	七月	1	1
389	333	六月	1	1
390	334	来月	1	1
391	335	五月	1	1
392	336	三月	1	1
393	337	先月	1	1
394	338	十一月	1	1
395	339	十月	1	1
396	340	九月	1	1
397	341	ひとつき	1	1
398	342	今週	1	1
399	343	毎週	1	1
400	344	日曜日	1	1
401	345	木曜日	1	1
402	346	来週	1	1
403	347	月曜日	1	1
404	348	火曜日	1	1
405	349	水曜日	1	1
406	350	土曜日	1	1
407	351	週間	1	1
408	352	先週	1	1
409	353	金曜日	1	1
410	354	年（ねん）	1	1
411	355	秋	1	1
412	356	今年（ことし）	1	1
413	357	毎年（まいとし）	1	1
414	358	夏（なつ）	1	1
415	359	冬	1	1
416	360	去年	1	1
417	361	来年	1	1
418	362	春	1	1
419	363	再来年	1	1
420	364	おととし	1	1
421	365	午後	1	1
423	366	明日（あした）	1	1
424	320	時（じ）	1	1
425	367	昨日（きのう）	1	1
426	368	夕べ	1	1
427	369	午前	1	1
428	370	朝	1	1
429	371	昼	1	1
430	372	夜（よる）	1	1
431	372	夕方	1	1
432	373	あさって	1	1
433	374	おととい	1	1
434	375	もう	1	1
435	376	ながら	1	1
436	377	まだ	1	1
437	378	中(ちゅう)	1	1
439	379	いつ	1	1
440	380	ときどき	1	1
441	381	しばしば	1	1
442	320	時間	1	1
443	382	すぐ	1	1
444	383	灰皿	1	1
445	384	歌（うた）	1	1
446	385	歌う	1	1
447	386	たばこ	1	1
448	387	映画	1	1
449	388	レコード	1	1
450	389	ギター	1	1
451	17	弾く	1	1
452	390	音楽	1	1
453	391	絵（え）	1	1
454	392	写真	1	1
455	393	好き，気に入る	1	1
456	384	声	1	1
457	394	晴れ	1	1
458	179	暑い	1	1
459	395	晴れる	1	1
460	396	涼しい	1	1
461	397	寒い	1	1
462	398	雪（ゆき）	1	1
463	399	雨が降る	1	1
464	400	雨（あめ）	1	1
465	401	天気	1	1
466	402	あたたかい（暖・温）	1	1
467	403	風（かぜ）	1	1
468	404	曇り	1	1
469	397	冷たい	1	1
470	405	曇る	1	1
471	406	漢字	1	1
472	407	言う	1	1
473	408	書く	1	1
474	409	話（はなし）	1	1
475	410	言葉	1	1
476	411	～語	1	1
477	410	語（ご）	1	1
478	412	話す	1	1
480	412	語る	1	1
481	413	意味	1	1
484	414	大人（おとな）	1	1
485	415	大勢	1	1
486	416	夫婦	1	1
487	417	子供	1	1
488	278	妻	1	1
489	418	女（おんな）	1	1
490	419	男の子	1	1
491	420	人（ひと）	1	1
492	421	男（おとこ）	1	1
493	422	女の子	1	1
494	423	夫	1	1
495	420	人	1	1
496	424	みんな	1	1
497	425	白（しろ），白い	1	1
498	426	青，青い	1	1
499	427	茶色	1	1
500	428	明るい，淡い	1	1
501	429	色（いろ）	1	1
502	430	濃い，暗い	1	1
503	431	黄色（きいろ），黄色い	1	1
504	432	黒（くろ），黒い	1	1
505	433	赤，赤い	1	1
506	434	緑	1	1
507	435	便利	1	1
508	436	パーティー	1	1
509	437	紙	1	1
510	438	～になる	1	1
511	439	締める	1	1
512	440	押す	1	1
513	441	始まる	1	1
514	442	ちょうど	1	1
516	443	まっすぐ	1	1
517	444	有名	1	1
518	445	元気	1	1
519	446	じゃあ	1	1
520	447	多分	1	1
521	188	では	1	1
522	21	元気	1	1
523	450	もう	1	1
524	451	吸う	1	1
525	452	後（あと）	1	1
526	453	北（きた）	1	1
527	454	叔父・伯父	1	1
528	455	叔父・伯父	1	1
529	456	パーティー	1	1
530	457	曲がる	1	1
531	458	貸す	1	1
533	459	遅い	1	1
534	460	切る	1	1
535	461	先（さき）	1	1
536	462	弱い	1	1
537	463	ときどき	1	1
538	464	しばしば	1	1
539	465	勉強	1	1
540	466	後（あと）	1	1
541	467	ない	1	1
542	468	ボールペン	1	1
543	469	曇り	1	1
544	471	スカート	1	1
545	472	締める	1	1
546	473	昼御飯	1	1
547	474	・・・てください	1	1
548	475	にぎやか	1	1
549	476	エレベーター	1	1
550	477	家庭	1	1
551	3	今日	1	1
552	1	自分	1	1
553	478	南	1	1
554	288	ハンカチ	1	1
555	479	ハンカチ	1	1
556	480	問題	1	1
557	164	コップ	1	1
558	481	横	1	1
559	482	縦	1	1
560	484	明るい	1	1
561	485	下	1	1
562	486	荷物	1	1
563	488	多分	1	1
564	489	静か	1	1
565	490	有名	1	1
566	110	南	1	1
567	483	横	1	1
568	487	背広	1	1
569	491	曲がる	1	1
570	492	パーティー	1	1
571	323	玄関	1	1
572	223	門	1	1
573	493	ふろ	1	1
574	91	洗濯する	1	1
575	494	便利	1	1
577	495	濃い、暗い	1	1
578	496	伯母・叔母	1	1
579	497	伯母・叔母	1	1
580	274	伯父・叔父	1	1
581	282	伯母・叔母	1	1
582	498	奥さん	1	1
583	499		1	1
584	500		1	1
586	224	入る	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
507	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
575	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
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
583	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
431	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
430	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
412	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
383	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
398	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
551	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
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
540	9700	1.1670001	1.16	体	関係	時間	時間的前後	後（あと）	後	あと
107	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
108	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
109	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
307	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
535	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
106	10765	1.173	1.17	体	関係	空間	方向・方角	こちら	こちら	こちら
299	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
303	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
553	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
566	10910	1.173	1.17	体	関係	空間	方向・方角	南（みなみ）	南	みなみ
526	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
119	10954	1.174	1.17	体	関係	空間	左右・前後・たてよこ	左（ひだり）	左	ひだり
118	10956	1.174	1.17	体	関係	空間	左右・前後・たてよこ	右（みぎ）	右	みぎ
117	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
116	10983	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後ろ	後ろ	うしろ
525	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
301	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
559	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
296	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
558	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
567	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
306	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
304	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
561	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
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
552	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
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
582	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
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
527	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
528	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
580	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
578	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
579	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
581	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
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
550	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
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
539	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
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
104	32060	1.3115	1.31	体	活動	言語	表・図・譜・式	地図	地図	ちず
214	32261	1.3122	1.31	体	活動	言語	通信	手紙	手紙	てがみ
211	32265	1.3122	1.31	体	活動	言語	通信	はがき	はがき	はがき
46	32370	1.3122	1.31	体	活動	言語	通信	電話	電話	でんわ
474	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
145	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
556	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
56	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
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
546	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
357	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
364	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
13	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
35	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
27	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
19	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
22	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
508	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
529	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
570	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
136	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
83	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
219	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
562	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
200	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
160	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
218	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
509	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
339	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
340	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
235	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
43	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
568	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
231	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
41	49847	1.4220001	1.42	体	生産物	衣料	上着・コート	ワイシャツ	ワイシャツ	わいしゃつ
229	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
230	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
228	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
544	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
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
572	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
91	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
245	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
571	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
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
573	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
444	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
210	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
213	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
337	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
233	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
352	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
354	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
180	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
557	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
177	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
184	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
189	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
188	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
369	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
542	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
378	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
75	54498	1.4541	1.45	体	生産物	道具	日用品	かぎ（鍵）	かぎ	かぎ
554	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
555	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
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
373	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
31	56482	1.465	1.46	体	生産物	機械	乗り物（陸上）	自転車	自転車	じてんしゃ
38	56506	1.465	1.46	体	生産物	機械	乗り物（陸上）	自動車	自動車	じどうしゃ
37	56572	1.465	1.46	体	生産物	機械	乗り物（陸上）	タクシー	タクシー	たくしい
30	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
170	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
165	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
159	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
549	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
3	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
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
543	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
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
545	68584	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	締める	締める	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
209	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
87	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
586	71454	2.1531999	2.15	用	関係	作用	入り・入れ	入（はい）る	入る	はいる
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
530	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
569	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
114	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
534	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
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
524	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
44	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
48	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
11	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
140	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
232	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
547	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
234	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
77	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
222	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
73	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
221	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
531	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
52	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
216	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
93	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
78	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
574	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
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
541	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
282	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
289	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
274	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
287	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
294	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
139	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
143	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
285	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
284	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
536	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
538	93170	3.1612	3.16	相	関係	時間	毎日・毎度	しばしば	しばしば	しばしば
441	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
440	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
537	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
275	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
278	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
269	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
533	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
436	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
434	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
523	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
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
565	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
49	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
522	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
61	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
283	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
500	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
560	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
291	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
497	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
292	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
564	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
280	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
548	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
186	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
192	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
584	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
194	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
502	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
577	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
469	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
466	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
519	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
206	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
563	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
2	222	328	0		0	\N	\N
3	258	322	0		0	\N	\N
4	9	279	0		0	\N	\N
5	1	326	0		0	\N	\N
6	217	17	0		0	\N	\N
7	514	149	0		0	\N	\N
8	260	344	0		0	\N	\N
9	65	316	0		0	\N	\N
10	8	187	0		0	\N	\N
13	72	367	0		0	\N	\N
14	30	328	0		0	\N	\N
15	47	89	0		0	\N	\N
16	259	299	0		0	\N	\N
17	341	129	0		0	\N	\N
18	143	345	0		0	\N	\N
19	12	334	0		0	\N	\N
21	125	299	0		0	\N	\N
22	322	319	0		0	\N	\N
23	310	319	0		0	\N	\N
24	13	334	0		0	\N	\N
25	14	330	0		0	\N	\N
26	123	335	0		0	\N	\N
27	3	423	0		0	\N	\N
28	67	405	0		0	\N	\N
29	55	341	0		0	\N	\N
30	50	305	0		0	\N	\N
31	387	220	0		0	\N	\N
32	196	181	0		0	\N	\N
33	351	415	0		0	\N	\N
34	157	415	0		0	\N	\N
36	84	155	0		0	\N	\N
37	85	155	0		0	\N	\N
38	80	447	0		0	\N	\N
39	138	302	0		0	\N	\N
40	454	236	0		0	\N	\N
41	423	214	0		0	\N	\N
42	218	236	0		0	\N	\N
43	38	337	0		0	\N	\N
44	200	393	0		0	\N	\N
45	6	186	0		0	\N	\N
46	521	21	0		0	\N	\N
47	205	15	0		0	\N	\N
48	33	326	0		0	\N	\N
49	214	15	0		0	\N	\N
50	203	440	0		0	\N	\N
51	414	253	0		0	\N	\N
52	10	275	0		0	\N	\N
53	54	345	0		0	\N	\N
55	183	406	0		0	\N	\N
56	206	264	0		0	\N	\N
58	37	323	0		0	\N	\N
59	263	164	0		0	\N	\N
60	156	415	0		0	\N	\N
61	51	54	0		0	\N	\N
62	519	182	0		0	\N	\N
63	257	341	0		0	\N	\N
64	153	259	0		0	\N	\N
66	150	413	0		0	\N	\N
67	106	198	0		0	\N	\N
68	256	19	0		0	\N	\N
69	412	32	0		0	\N	\N
70	226	361	0		0	\N	\N
71	407	142	0		0	\N	\N
72	213	13	0		0	\N	\N
73	466	218	0		0	\N	\N
74	18	240	0		0	\N	\N
75	456	112	0		0	\N	\N
77	134	320	0		0	\N	\N
79	19	189	0		0	\N	\N
80	384	286	0		0	\N	\N
81	286	145	0		0	\N	\N
82	27	246	0		0	\N	\N
83	127	294	0		0	\N	\N
84	166	154	0		0	\N	\N
85	109	56	0		0	\N	\N
86	452	240	0		0	\N	\N
87	44	305	0		0	\N	\N
88	136	111	0		0	\N	\N
89	272	324	0		0	\N	\N
90	361	179	0		0	\N	\N
91	76	402	0		0	\N	\N
92	461	218	0		0	\N	\N
93	495	175	0		0	\N	\N
94	491	175	0		0	\N	\N
95	25	323	0		0	\N	\N
96	499	269	0		0	\N	\N
97	209	19	0		0	\N	\N
98	490	294	0		0	\N	\N
99	487	293	0		0	\N	\N
100	64	354	0		0	\N	\N
101	439	253	0		0	\N	\N
102	476	186	0		0	\N	\N
103	158	210	0		0	\N	\N
104	253	41	0		0	\N	\N
105	252	64	0		0	\N	\N
106	139	126	0		0	\N	\N
107	475	345	0		0	\N	\N
108	204	249	0		0	\N	\N
109	276	249	0		0	\N	\N
110	133	110	0		0	\N	\N
112	303	361	0		0	\N	\N
113	118	197	0		0	\N	\N
114	249	26	0		0	\N	\N
115	250	292	0		0	\N	\N
116	343	413	0		0	\N	\N
117	160	328	0		0	\N	\N
118	510	397	0		0	\N	\N
119	496	8	0		0	\N	\N
120	437	87	0		0	\N	\N
121	161	327	0		0	\N	\N
122	442	233	0		0	\N	\N
123	424	72	0		0	\N	\N
124	373	373	0		0	\N	\N
125	465	213	0		0	\N	\N
126	178	407	0		0	\N	\N
127	462	220	0		0	\N	\N
128	457	209	0		0	\N	\N
129	374	431	0		0	\N	\N
130	415	228	0		0	\N	\N
131	428	208	0		0	\N	\N
132	117	164	0		0	\N	\N
133	91	92	0		0	\N	\N
134	425	301	0		0	\N	\N
135	410	284	0		0	\N	\N
136	66	196	0		0	\N	\N
137	141	275	0		0	\N	\N
138	275	159	0		0	\N	\N
139	277	324	0		0	\N	\N
140	111	335	0		0	\N	\N
141	431	311	0		0	\N	\N
142	430	311	0		0	\N	\N
143	493	297	0		0	\N	\N
144	211	13	0		0	\N	\N
145	417	294	0		0	\N	\N
146	390	337	0		0	\N	\N
147	290	220	0		0	\N	\N
148	227	104	0		0	\N	\N
149	254	25	0		0	\N	\N
150	48	138	0		0	\N	\N
151	23	325	0		0	\N	\N
152	113	306	0		0	\N	\N
153	97	41	0		0	\N	\N
154	522	7	0		0	\N	\N
155	480	83	0		0	\N	\N
156	478	193	0		0	\N	\N
157	116	387	0		0	\N	\N
158	5	326	0		0	\N	\N
159	298	210	0		0	\N	\N
160	104	105	0		0	\N	\N
161	140	114	0		0	\N	\N
162	531	59	0		0	\N	\N
163	11	85	0		0	\N	\N
164	255	185	0		0	\N	\N
165	455	386	0		0	\N	\N
166	451	242	0		0	\N	\N
167	151	139	0		0	\N	\N
168	535	99	0		0	\N	\N
169	512	438	0		0	\N	\N
170	297	329	0		0	\N	\N
172	282	119	0		0	\N	\N
173	241	221	0		0	\N	\N
175	537	374	0		0	\N	\N
176	471	342	0		0	\N	\N
177	539	267	0		0	\N	\N
178	540	89	0		0	\N	\N
179	198	260	0		0	\N	\N
180	477	164	0		0	\N	\N
181	378	59	0		0	\N	\N
182	541	193	0		0	\N	\N
183	473	275	0		0	\N	\N
184	543	208	0		0	\N	\N
185	164	224	0		0	\N	\N
186	148	414	0		0	\N	\N
187	73	75	0		0	\N	\N
188	546	179	0		0	\N	\N
189	63	269	0		0	\N	\N
190	130	353	0		0	\N	\N
191	191	406	0		0	\N	\N
192	547	14	0		0	\N	\N
193	550	232	0		0	\N	\N
194	551	109	0		0	\N	\N
195	552	248	0		0	\N	\N
201	317	455	1		0	\N	\N
202	318	454	1		0	\N	\N
203	324	453	1		0	\N	\N
204	527	456	1		0	\N	\N
205	554	457	1		0	\N	\N
206	192	458	1		0	\N	\N
209	124	461	1		0	\N	\N
210	2	462	1		0	\N	\N
211	395	463	1		0	\N	\N
212	436	464	1		0	\N	\N
213	394	465	1		0	\N	\N
214	385	466	1		0	\N	\N
215	370	467	1		0	\N	\N
216	185	468	1		0	\N	\N
217	555	457	0		0	\N	\N
218	556	469	1		0	\N	\N
219	145	470	1		0	\N	\N
220	311	471	1		0	\N	\N
221	177	472	1		0	\N	\N
222	557	473	1		0	\N	\N
224	293	475	1		0	\N	\N
225	538	476	1		0	\N	\N
226	179	477	1		0	\N	\N
227	237	478	1		0	\N	\N
228	542	479	1		0	\N	\N
229	201	480	1		0	\N	\N
230	168	481	1		0	\N	\N
231	169	482	1		0	\N	\N
232	115	483	1		0	\N	\N
234	464	485	1		0	\N	\N
236	122	487	1		0	\N	\N
237	99	488	1		0	\N	\N
238	268	489	1		0	\N	\N
239	400	490	1		0	\N	\N
240	216	491	1		0	\N	\N
241	190	492	1		0	\N	\N
242	4	493	1		0	\N	\N
243	131	494	1		0	\N	\N
244	238	495	1		0	\N	\N
246	346	497	1		0	\N	\N
247	342	498	1		0	\N	\N
248	208	499	1		0	\N	\N
249	69	500	1		0	\N	\N
250	450	501	1		0	\N	\N
251	36	502	1		0	\N	\N
252	20	503	1		0	\N	\N
253	405	504	1		0	\N	\N
254	392	505	1		0	\N	\N
255	224	506	1		0	\N	\N
256	363	507	1		0	\N	\N
257	265	508	1		0	\N	\N
258	197	509	1		0	\N	\N
259	142	510	1		0	\N	\N
260	144	510	0		0	\N	\N
261	388	511	1		0	\N	\N
262	399	512	1		0	\N	\N
263	561	513	1		0	\N	\N
264	382	514	1		0	\N	\N
265	401	515	1		0	\N	\N
266	31	516	1		0	\N	\N
267	28	517	1		0	\N	\N
268	445	518	1		0	\N	\N
269	372	519	1		0	\N	\N
270	446	520	1		0	\N	\N
271	135	521	1		0	\N	\N
272	62	104	1		0	\N	\N
273	62	522	2		0	\N	\N
274	306	513	0		0	\N	\N
275	17	523	1		0	\N	\N
276	396	524	1		0	\N	\N
277	413	525	1		0	\N	\N
278	49	526	1		0	\N	\N
279	68	502	0		0	\N	\N
280	269	527	1		0	\N	\N
281	40	528	1		0	\N	\N
282	195	529	1		0	\N	\N
283	137	530	1		0	\N	\N
284	7	531	1		0	\N	\N
285	264	532	1		0	\N	\N
286	132	533	1		0	\N	\N
287	453	534	1		0	\N	\N
288	389	535	1		0	\N	\N
289	367	536	1		0	\N	\N
290	299	537	1		0	\N	\N
291	119	538	1		0	\N	\N
292	368	539	1		0	\N	\N
293	52	540	1		0	\N	\N
294	261	541	1		0	\N	\N
295	219	542	1		0	\N	\N
296	562	542	0		0	\N	\N
297	402	543	1		0	\N	\N
298	448	524	0		0	\N	\N
299	42	544	1		0	\N	\N
300	126	545	1		0	\N	\N
301	172	546	1		0	\N	\N
302	563	148	0		0	\N	\N
303	223	547	1		0	\N	\N
304	353	548	1		0	\N	\N
305	71	549	1		0	\N	\N
306	165	550	1		0	\N	\N
307	289	468	0		0	\N	\N
308	22	551	1		0	\N	\N
309	294	552	1		0	\N	\N
310	212	553	1		0	\N	\N
311	528	554	1		0	\N	\N
312	381	555	1		0	\N	\N
313	411	556	1		0	\N	\N
314	281	557	1		0	\N	\N
315	266	558	1		0	\N	\N
316	432	559	1		0	\N	\N
317	174	560	1		0	\N	\N
318	274	561	1		0	\N	\N
319	506	562	1		0	\N	\N
320	88	563	1		0	\N	\N
321	231	564	1		0	\N	\N
322	348	565	1		0	\N	\N
323	371	566	1		0	\N	\N
324	344	567	1		0	\N	\N
325	494	568	1		0	\N	\N
326	397	569	1		0	\N	\N
327	403	570	1		0	\N	\N
328	365	571	1		0	\N	\N
329	565	572	1		0	\N	\N
330	326	573	1		0	\N	\N
331	485	574	1		0	\N	\N
332	167	575	1		0	\N	\N
333	94	576	1		0	\N	\N
334	364	577	1		0	\N	\N
335	357	577	0		0	\N	\N
336	533	578	1		0	\N	\N
337	244	579	1		0	\N	\N
338	202	580	1		0	\N	\N
339	313	581	1		0	\N	\N
340	152	582	1		0	\N	\N
341	360	583	1		0	\N	\N
342	329	584	1		0	\N	\N
343	230	585	1		0	\N	\N
344	566	586	1		0	\N	\N
345	332	587	1		0	\N	\N
346	331	588	1		0	\N	\N
347	330	573	0		0	\N	\N
348	501	589	1		0	\N	\N
349	408	590	1		0	\N	\N
350	416	591	1		0	\N	\N
351	393	592	1		0	\N	\N
352	359	593	1		0	\N	\N
353	300	594	1		0	\N	\N
354	270	595	1		0	\N	\N
355	567	596	1		0	\N	\N
356	502	597	1		0	\N	\N
357	92	598	1		0	\N	\N
358	426	599	1		0	\N	\N
359	229	600	1		0	\N	\N
360	568	601	1		0	\N	\N
361	449	602	1		0	\N	\N
363	184	604	1		0	\N	\N
364	95	605	1		0	\N	\N
365	287	606	1		0	\N	\N
366	467	607	1		0	\N	\N
367	35	608	1		0	\N	\N
368	90	576	0		0	\N	\N
369	560	609	1		0	\N	\N
370	53	610	1		0	\N	\N
371	295	611	1		0	\N	\N
372	284	612	1		0	\N	\N
373	128	613	1		0	\N	\N
374	175	560	0		0	\N	\N
375	121	111	1		0	\N	\N
376	121	614	2		0	\N	\N
377	460	615	1		0	\N	\N
378	189	616	1		0	\N	\N
379	58	611	0		0	\N	\N
380	352	617	1		0	\N	\N
381	409	618	1		0	\N	\N
382	391	619	1		0	\N	\N
383	328	620	1		0	\N	\N
384	114	621	1		0	\N	\N
385	193	622	1		0	\N	\N
386	447	477	0		0	\N	\N
387	524	477	0		0	\N	\N
388	70	623	1		0	\N	\N
389	101	624	1		0	\N	\N
390	15	625	1		0	\N	\N
391	569	538	0		0	\N	\N
392	267	544	0		0	\N	\N
393	484	626	1		0	\N	\N
394	75	627	1		0	\N	\N
395	337	628	1		0	\N	\N
396	248	629	1		0	\N	\N
397	108	630	1		0	\N	\N
398	107	631	1		0	\N	\N
399	247	632	1		0	\N	\N
400	83	633	1		0	\N	\N
401	93	482	0		0	\N	\N
402	21	634	1		0	\N	\N
403	443	632	0		0	\N	\N
404	505	635	1		0	\N	\N
405	171	429	0		0	\N	\N
406	98	567	0		0	\N	\N
407	433	636	1		0	\N	\N
408	420	637	1		0	\N	\N
409	120	638	1		0	\N	\N
410	559	596	0		0	\N	\N
412	46	639	1		0	\N	\N
413	46	640	2		0	\N	\N
414	481	641	1		0	\N	\N
415	32	642	1		0	\N	\N
416	570	643	1		0	\N	\N
417	529	644	1		0	\N	\N
418	427	645	1		0	\N	\N
419	421	645	0		0	\N	\N
420	444	646	1		0	\N	\N
421	26	647	1		0	\N	\N
422	571	648	1		0	\N	\N
423	470	649	1		0	\N	\N
424	60	650	1		0	\N	\N
425	154	651	1		0	\N	\N
426	188	616	0		0	\N	\N
427	458	473	0		0	\N	\N
428	369	635	0		0	\N	\N
429	340	584	0		0	\N	\N
430	340	601	0		0	\N	\N
431	339	584	0		0	\N	\N
432	339	601	0		0	\N	\N
433	469	473	0		0	\N	\N
434	187	616	0		0	\N	\N
435	472	571	0		0	\N	\N
436	240	575	0		0	\N	\N
437	233	552	0		0	\N	\N
438	79	645	0		0	\N	\N
439	254	603	0		0	\N	\N
441	492	457	0		0	\N	\N
442	492	601	0		0	\N	\N
443	325	585	0		0	\N	\N
444	315	462	0		0	\N	\N
445	435	629	0		0	\N	\N
446	572	652	1		0	\N	\N
447	243	653	1		0	\N	\N
448	376	654	1		0	\N	\N
449	163	654	0		0	\N	\N
450	418	655	1		0	\N	\N
451	366	656	1		0	\N	\N
452	406	657	1		0	\N	\N
453	112	531	0		0	\N	\N
454	105	539	0		0	\N	\N
455	336	658	1		0	\N	\N
456	194	659	1		0	\N	\N
457	573	660	1		0	\N	\N
458	375	661	1		0	\N	\N
459	347	662	1		0	\N	\N
460	155	663	1		0	\N	\N
461	504	664	1		0	\N	\N
462	291	665	1		0	\N	\N
463	147	496	0		0	\N	\N
464	87	666	1		0	\N	\N
465	279	667	1		0	\N	\N
466	181	560	0		0	\N	\N
467	345	668	1		0	\N	\N
468	350	669	1		0	\N	\N
469	548	670	1		0	\N	\N
470	271	671	1		0	\N	\N
471	404	657	0		0	\N	\N
472	386	672	1		0	\N	\N
473	526	673	1		0	\N	\N
474	419	674	1		0	\N	\N
475	57	675	1		0	\N	\N
476	574	676	1		0	\N	\N
477	234	677	1		0	\N	\N
478	273	678	1		0	\N	\N
479	235	679	1		0	\N	\N
480	220	680	1		0	\N	\N
481	56	681	1		0	\N	\N
482	278	682	1		0	\N	\N
483	285	683	1		0	\N	\N
484	251	684	1		0	\N	\N
485	575	685	1		0	\N	\N
486	61	686	1		0	\N	\N
487	509	680	0		0	\N	\N
488	497	687	1		0	\N	\N
489	103	688	1		0	\N	\N
490	102	688	0		0	\N	\N
491	110	689	1		0	\N	\N
492	178	546	0		0	\N	\N
493	500	690	1		0	\N	\N
494	173	691	1		0	\N	\N
495	327	692	1		0	\N	\N
497	577	692	0		0	\N	\N
498	500	692	0		0	\N	\N
499	40	692	0		0	\N	\N
500	41	692	0		0	\N	\N
501	170	693	1		0	\N	\N
502	549	694	1		0	\N	\N
503	34	695	1		0	\N	\N
504	233	680	0		0	\N	\N
505	362	696	1		0	\N	\N
506	459	697	1		0	\N	\N
507	498	698	1		0	\N	\N
508	242	699	1		0	\N	\N
509	545	700	1		0	\N	\N
510	292	701	1		0	\N	\N
511	349	702	1		0	\N	\N
512	358	703	1		0	\N	\N
513	355	703	0		0	\N	\N
514	334	704	1		0	\N	\N
515	550	704	0		0	\N	\N
516	224	704	0		0	\N	\N
517	571	704	0		0	\N	\N
518	328	704	0		0	\N	\N
519	141	655	0		0	\N	\N
520	503	705	1		0	\N	\N
521	162	706	1		0	\N	\N
522	100	646	0		0	\N	\N
523	89	680	0		0	\N	\N
524	89	576	0		0	\N	\N
525	516	707	1		0	\N	\N
526	239	708	1		0	\N	\N
527	215	709	1		0	\N	\N
528	335	710	1		0	\N	\N
529	323	544	1		0	\N	\N
530	323	711	2		0	\N	\N
531	579	712	1		0	\N	\N
532	578	713	1		0	\N	\N
533	580	714	1		0	\N	\N
534	581	715	1		0	\N	\N
535	319	716	1		0	\N	\N
536	320	717	1		0	\N	\N
538	176	719	1		0	\N	\N
539	16	720	1		0	\N	\N
540	312	721	1		0	\N	\N
541	489	722	1		0	\N	\N
542	398	723	1		0	\N	\N
543	383	724	1		0	\N	\N
544	513	725	1		0	\N	\N
545	488	726	1		0	\N	\N
546	582	727	1		0	\N	\N
547	228	728	1		0	\N	\N
548	77	729	1		0	\N	\N
549	474	730	1		0	\N	\N
550	583	1226	1		0	\N	\N
551	324	789	0		0	\N	\N
552	317	1005	0		0	\N	\N
553	259	752	0		0	\N	\N
554	143	1180	0		0	\N	\N
555	12	1074	0		0	\N	\N
556	125	1200	0		0	\N	\N
557	124	655	0		0	\N	\N
558	2	1189	0		0	\N	\N
559	185	1059	0		0	\N	\N
560	556	843	0		0	\N	\N
561	145	496	0		0	\N	\N
562	13	1163	0		0	\N	\N
563	276	939	0		0	\N	\N
564	133	923	0		0	\N	\N
565	245	781	0		0	\N	\N
566	245	1107	0		0	\N	\N
567	541	931	0		0	\N	\N
568	237	794	0		0	\N	\N
569	542	1103	0		0	\N	\N
570	250	938	0		0	\N	\N
571	473	1210	0		0	\N	\N
572	115	1177	0		0	\N	\N
573	149	1108	1		0	\N	\N
574	24	1227	1		0	\N	\N
575	99	1082	0		0	\N	\N
576	496	1064	0		0	\N	\N
577	298	840	0		0	\N	\N
578	131	1121	0		0	\N	\N
579	346	197	0		0	\N	\N
580	354	617	0		0	\N	\N
581	186	200	1		0	\N	\N
582	186	1228	2		0	\N	\N
583	463	486	1		0	\N	\N
584	463	1229	2		0	\N	\N
585	584	1230	1		0	\N	\N
586	586	78	0		0	\N	0
587	586	230	0		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: mn
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
83	7
84	7
85	7
87	7
88	8
89	8
90	8
91	8
92	8
93	8
94	8
95	8
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
200	17
201	17
202	17
203	17
204	17
205	17
206	17
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
303	24
304	24
306	24
307	24
310	25
311	25
312	25
313	25
315	25
317	25
318	25
319	25
320	25
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
378	29
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
480	37
481	37
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
523	34
524	4
525	24
526	24
527	25
528	25
530	3
531	18
533	23
534	10
535	24
536	23
537	34
538	34
539	11
542	29
543	36
544	19
546	28
547	19
548	23
549	14
550	25
551	33
552	21
553	24
554	26
555	26
556	11
557	15
558	24
559	24
561	24
562	18
564	23
567	24
568	26
571	20
572	29
574	7
577	39
578	25
579	25
580	25
581	25
582	25
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
11	япон хэл	1	Я	132
12	улс	1	У	124
13	уулзах	1	У	134
14	амралт	1	А	116
15	аялал	1	А	134
16	аялах	1	А	135
17	тоглох	1	Т	131
18	элчин сайдын яам	1	Э	127
19	их дуртай	1	Д	125
20	дуртай	1	Д	124
21	сайн	1	С	118
22	гүйх	1	Г	118
23	удаан	1	У	121
24	муу	1	М	119
25	алхах	1	А	112
26	сэлэх	1	С	135
27	хурдан	1	Х	156
28	үсрэх	1	Ү	128
29	спорт	1	С	128
30	дургүй	1	Д	123
32	автобус	1	А	107
33	дугуй	1	Д	121
34	уулзвар	1	У	135
35	зам	1	З	112
36	цөөрөм	1	Ц	135
37	салхинд гарах	1	С	121
38	гол	1	Г	113
39	такси	1	Т	124
40	машин	1	М	115
42	зангиа	1	З	113
43	цамц	1	Ц	130
44	компани	1	К	110
46	хийх	1	Х	139
48	утас	1	У	132
49	ажил	1	А	108
50	ажиллах	1	А	109
51	зав муутай	1	З	109
52	номын сан	1	Н	126
53	толь бичиг	1	Т	133
54	зээлэх	1	З	128
55	сонин	1	С	125
56	унших	1	У	127
57	ном	1	Н	125
58	хуулбар	1	Х	159
59	хувилах	1	Х	153
60	сэтгүүл	1	С	138
61	үхрийн мах	1	Ү	131
62	хямд	1	Х	178
63	дэлгүүр	1	Д	130
64	өндөр	1	Ө	129
65	хэд	1	Х	170
66	ямар үнэтэй	1	Я	131
67	жимс	1	Ж	108
68	ногоо	1	Н	123
69	загас	1	З	110
70	гахайн мах	1	Г	111
71	тахианы мах	1	Т	128
72	мах	1	М	114
73	авмаар байна	1	А	106
74	өгөх	1	Ө	119
76	түлхүүр	1	Т	136
77	хоол	1	Х	146
78	юм авах	1	Ю	125
80	цэвэрлэх	1	Ц	138
81	гэр бүл	1	Г	122
83	угаалга	1	У	118
84	гэр	1	Г	121
85	харих	1	Х	138
86	номын тавиур	1	Н	127
87	ширээ	1	Ш	128
88	сандал	1	С	122
89	өрөө	1	Ө	134
90	хөргөгч	1	Х	152
91	угаах	1	У	120
92	ор	1	О	116
93	радио	1	Р	115
94	гэдэг	1	Г	119
95	унтах	1	У	126
96	босох	1	Б	126
97	телевиз	1	Т	129
98	цагдаа	1	Ц	125
99	газрын зураг	1	Г	107
100	хажуу	1	Х	126
101	энд	1	Э	133
102	тэнд	1	Т	141
103	хаана	1	Х	121
104	цагдаагийн хэсэг	1	Ц	126
105	ойрхон	1	О	113
106	асуух	1	А	130
107	тайрах	1	Т	123
108	богино	1	Б	121
109	ар	1	А	121
110	өмнө	1	Ө	122
111	баруун	1	Б	114
112	зүүн	1	З	127
113	урт	1	У	130
114	суух	1	С	133
115	найз	1	Н	114
116	анги	1	А	119
117	коридор	1	К	112
118	сургууль	1	С	132
119	сурагч	1	С	130
120	хичээл	1	Х	140
121	оюутан	1	О	123
122	гадаад оюутан	1	Г	105
123	зуны амралт	1	З	121
124	багш	1	Б	103
125	их сургууль	0	И	\N
126	дэвтэр	1	Д	129
127	зохион бичлэг	1	З	117
128	гэрийн даалгавар	1	Г	124
129	хэцүү	1	Х	177
130	заах	1	З	108
131	шалгалт	1	Ш	124
132	дасгал	1	Д	110
133	амархан	1	А	115
134	дасгал хийх	1	Д	111
135	асуулт	1	А	129
136	хариулах	1	Х	137
137	өвдөх	1	Ө	114
138	шүд	1	Ш	131
139	эмч	1	Э	131
140	эмнэлэг	1	Э	130
141	өвчин	1	Ө	116
142	эм	1	Э	128
143	үхэх	1	Ү	132
144	ханиад	1	Х	133
145	толгой	1	Т	132
146	гэдэс	1	Г	120
147	хэм	1	Х	174
149	билет	1	Б	119
150	буух	1	Б	128
151	шат	1	Ш	126
152	хаах	1	Х	122
153	буудал	1	Б	127
154	метро	1	М	116
155	онгойлгох	1	О	115
156	бие засах газар	1	Б	118
157	цахилгаан галт тэрэг	1	Ц	132
158	ундаа	1	У	125
159	кофе	1	К	113
160	цайны газар	1	Ц	129
161	нимбэг	1	Н	120
162	сүү	1	С	134
163	элсэн чихэр	1	Э	126
164	аяга	1	А	133
165	цай	1	Ц	127
166	байхуу цай	1	Б	108
168	амттай	1	А	118
169	уух	1	У	136
170	савх	1	С	117
171	архи	1	А	127
172	хутга	1	Х	157
173	халбага	1	Х	128
174	сэрээ	1	С	137
175	бяслаг	1	Б	135
176	идэх	1	И	108
177	амтгүй	1	А	117
178	талх	1	Т	125
179	халуун	1	Х	129
180	зоогийн газар	1	З	116
181	гуанз	1	Г	114
182	дарс	1	Д	109
183	мөнгө	1	М	118
184	банк	1	Б	112
185	орох хаалга	1	О	121
186	зүгээр, зүгээр	1	З	126
187	үгүй	1	Ү	120
188	за	1	З	107
189	уучлаарай	1	У	137
190	гарах хаалга	1	Г	110
191	хүрэх	1	Х	166
193	ил захидал	1	И	110
194	наах	1	Н	111
195	дугтуй	1	Д	120
196	захиа	1	З	115
197	шуудан	1	Ш	130
198	буцаах	1	Б	129
199	явуулах	1	Я	128
200	марк	1	М	112
201	илгээмж	0	И	\N
202	хуудас	1	Х	158
204	авах	1	А	103
205	малгай	1	М	110
206	гутал	1	Г	117
207	давхар	1	Д	105
208	их дэлгүүр	1	И	115
209	банзал	1	Б	111
210	пальто	1	п	138
211	өмд	1	Ө	121
212	ноосон цамц	1	Н	128
214	цүнх	1	Ц	137
215	худалдах	1	Х	155
216	хүрэм	1	Х	164
218	байшин	1	Б	109
219	гал тогооны өрөө	1	Г	108
220	шүршүүр	1	Ш	132
221	цонх	1	Ц	134
222	цэцэрлэгт хүрээлэн	1	Ц	142
223	хаалга	1	Х	120
224	орох	1	О	120
225	байр	1	Б	105
226	тэр	1	Т	142
227	тэд	1	Т	140
228	би	1	Б	115
229	бид	1	Б	116
230	хэн нэгэн	1	Х	176
231	хэн	1	Х	175
232	чи	1	Ч	123
233	та	1	Т	117
234	энэ	1	Э	134
235	яаж	1	Я	126
236	аль	1	А	113
237	ямар	1	Я	130
238	ийм	1	И	109
239	тийм	1	Т	130
240	зузаан	1	З	119
241	давчуу	1	Д	106
242	нарийн	1	Н	119
243	том	1	Т	134
244	бүдүүн	1	Б	131
245	залуу	1	З	111
246	өргөн	1	Ө	132
247	хөнгөн	1	Х	151
248	хол	1	Х	145
249	хүнд	1	Х	163
250	нимгэн	1	Н	121
251	шинэ	1	Ш	127
252	бага	1	Б	102
253	хуучин	1	Х	160
254	хөгжилтэй	1	Х	147
256	намхан	1	Н	118
258	сул	1	С	129
259	хүчтэй	1	Х	169
260	сонирхолтой	1	С	127
261	сайхан	1	С	119
262	их	1	И	114
263	харанхуй	1	Х	136
264	нам гүм	1	Н	116
265	муухай	1	М	120
266	сонирхолгүй	1	С	126
268	дотор	1	Д	116
269	гадаа	1	Г	103
272	дээр	1	Д	131
274	ах	1	А	131
275	ах дүү	1	А	132
276	эмгэн	1	Э	129
277	өвгөн	1	Ө	113
278	эхнэр	1	Э	142
279	ээж	1	Э	143
280	аав ээж	1	А	102
281	аав	1	А	101
282	эгч	1	Э	124
283	эгч дүүс	1	Э	125
284	оймс	1	О	112
285	тайлах	1	Т	122
286	өлгөх	1	Ө	120
287	өмсөх	1	Ө	123
288	алчуур	0	А	\N
289	шаахай	1	Ш	123
290	шүхэр	1	Ш	133
291	халаас	1	Х	127
292	түрийвч	1	Т	137
294	хувцас	1	Х	154
295	ам	1	А	114
296	гар	1	Г	109
297	бие	1	Б	117
298	нүүр	1	Н	134
299	хөл	1	Х	149
300	хамар	1	Х	131
301	нүд	1	Н	132
302	чих	1	Ч	124
303	таваг	1	Т	119
304	масло	1	М	113
305	чихэр	1	Ч	125
307	оройн хоол	1	О	118
308	өндөг	1	Ө	128
309	өглөөний хоол	1	Ө	118
310	цуу	1	Ц	136
311	давс	1	Д	104
312	нэмэх	1	Н	138
313	хавсаргах	1	Х	124
314	зургийн аппарат	1	З	124
315	зуух	1	З	125
316	харандаа	1	Х	135
317	арилгах	1	А	126
318	нүдний шил	1	Н	133
319	дуу хураагуур	1	Д	127
320	цаг	1	Ц	122
321	компьютер	1	К	111
322	хальс	1	Х	130
323	үүд	1	Ү	129
324	үзэг	1	Ү	126
325	наймдугаар сар	1	Н	115
326	дөрөвдүгээр сар	1	Д	117
327	энэ сар	1	Э	137
328	сар бүр	1	С	123
329	арван хоёрдугаар сар	1	А	125
330	хоёрдугаар сар	1	Х	142
331	нэгдүгээр сар	1	Н	136
332	долдугаар сар	1	Д	112
333	зургадугаар сар	1	З	123
334	ирэх сар	1	И	113
335	тавдугаар сар	1	Т	121
336	гуравдугаар сар	1	Г	116
337	өнгөрсөн сар	1	Ө	127
338	арван нэгдүгээр сар	1	А	124
339	аравдугаар сар	1	А	122
340	есдүгээр сар	1	Е	105
341	нэг сар	1	Н	135
342	энэ долоо хоног	1	Э	135
343	долоо хоног бүр	1	Д	114
344	бүтэн сайн өдөр	1	Б	134
345	дөрөвдэх өдөр	1	Д	118
346	ирэх долоо хоног	1	И	111
347	нэгдэх өдөр	1	Н	137
348	хоёрдохь өдөр	1	Х	141
349	гуравдахь өдөр	1	Г	115
350	хагас сайн өдөр	1	Х	125
351	долоо хоног	1	Д	113
352	өнгөрсөн долоо хоног	1	Ө	125
353	тавдахь өдөр	1	Т	120
354	жил	1	Ж	106
355	намар	1	Н	117
356	энэ жил	1	Э	136
357	жил бүр	1	Ж	107
358	зун	1	З	120
359	өвөл	1	Ө	115
360	өнгөрсөн жил	1	Ө	126
361	ирэх жил	1	И	112
362	хавар	1	Х	123
363	хойтонгийн хойтон жил	1	Х	144
364	уржнан	1	У	129
365	үдээс хойш	1	Ү	125
366	маргааш	1	М	111
367	өчигдөр	1	Ө	135
368	өчигдөр орой	1	Ө	136
369	үдээс өмнө	1	Ү	124
370	өглөө	1	Ө	117
372	орой	1	О	117
373	нөгөөдөр	1	Н	129
374	уржигдар	1	У	128
376	-нгаа  ...	1	-	128
377	арай болоогүй	1	А	123
378	бүтэн	1	Б	133
379	хэзээ	1	Х	171
382	удахгүй	1	У	122
383	үнсний сав	1	Ү	127
384	дуу	1	Д	126
385	дуулах	1	Д	128
386	тамхи	1	Т	126
387	кино	1	К	109
388	пянз	1	п	140
389	гитар	1	Г	112
390	хөгжим	1	Х	148
391	зураг	1	З	122
392	гэрэл зураг	1	Г	125
393	таалагдах	1	Т	118
394	цэлмэг	1	Ц	139
395	цэлмэг болох	1	Ц	140
396	сэрүүн	1	С	136
397	хүйтэн	1	Х	161
398	цас	1	Ц	131
399	бороо орох	1	Б	125
400	бороо	1	Б	124
401	цаг агаар	1	Ц	123
402	дулаан	1	Д	122
403	салхи	1	С	120
405	үүлших	1	Ү	130
406	ханз	1	Х	132
407	хэлэх	1	Х	173
408	бичих	1	Б	120
409	яриа	1	Я	133
410	үг	1	Ү	119
411	хэл	1	Х	172
412	ярих	1	Я	134
413	утга	1	У	133
414	том хүн	1	Т	135
415	олон хүн	1	О	114
417	хүүхэд	1	Х	168
418	эмэгтэй	1	Э	132
419	хүү	1	Х	167
420	хүн	1	Х	162
421	эрэгтэй	1	Э	139
422	охин	1	О	122
423	нөхөр	1	Н	130
424	бүгд	1	Б	130
425	цагаан	1	Ц	124
426	цэнхэр	1	Ц	141
427	хүрэн	1	Х	165
428	цайвар	1	Ц	128
429	өнгө	1	Ө	124
430	өтгөн	0	Ө	\N
431	шар	1	Ш	125
432	хар	1	Х	134
433	улаан	1	У	123
434	ногоон	1	Н	124
437	цаас	1	Ц	121
438	болох	1	Б	122
440	дарах	1	Д	108
441	эхлэх	1	Э	140
442	яг	1	Я	129
443	шулуун	1	Ш	129
446	тэгвэл	1	Т	139
448	бат	0	Б	\N
449	үнэ	0	Ү	\N
451	татах	1	Т	127
453	хойд	1	Х	143
454	авга ах	1	А	104
455	нагац ах	1	Н	112
456	үдэшлэг	1	Ү	123
458	түр өгөх	1	Т	138
459	оройтох	1	О	119
461	эхлээд	1	Э	141
463	заримдаа	1	З	114
464	байн байн	1	Б	104
465	сурах	1	С	131
466	дараа	1	Д	107
467	байхгүй	1	Б	107
468	бал	1	Б	110
469	бүрхэг	1	Б	132
472	чангалах	1	Ч	122
473	үдийн хоол	1	Ү	122
474	-на уу	1	-	127
475	хөл хөгжөөнтэй	1	Х	150
476	цахилгаан шат	1	Ц	133
477	айл	1	А	110
479	нусны алчуур	1	Н	131
480	асуудал	1	А	128
482	уртааш	1	У	131
483	өргөөш	1	Ө	133
484	саруул	1	С	124
485	доошоо	1	Д	115
486	боодол	1	Б	123
487	пиджак	1	П	139
488	байхаа 	1	Б	106
490	алдартай	1	А	111
491	эргэх	1	Э	138
492	цайллага	0	Ц	\N
493	угаалгын өрөө	1	У	119
494	дөхөмтэй	1	Д	119
495	бараан	1	Б	113
496	нагац эгч	1	Н	113
497	авга эгч	1	А	105
498	гэргий	1	Г	123
499	үд	1	Ү	121
500	чихэрлэг	1	Ч	126
31	бассейн	0	Б	\N
41	муруйх	0	М	\N
45	костюм	0	К	\N
47	амьсгаалах	0	А	\N
404	үүлтэй	0	Ү	\N
75	хүнсний ногооны дэлгүүр	0	Х	\N
79	хувцас угаах	0	Х	\N
82	өрх гэр	0	Ө	\N
148	лифт	0	Л	\N
167	стакан	0	С	\N
192	шуудангийн хайрцаг	0	Ш	\N
203	зээлүүлэх	0	З	\N
213	-ж өгнө үү	0	Ө	\N
217	халуун усны газар	0	Х	\N
255	шуугиантай	0	Ш	\N
257	гэрэлтэй	0	Г	\N
267	хэвтээ	0	Х	\N
270	босоо	0	Б	\N
271	дор	0	Д	\N
273	түрүү	0	Т	\N
293	хувцастай	0	Х	\N
306	өдрийн хоол	0	Ө	\N
371	өдөр	0	Ө	\N
375	аль хэдийд	0	А	\N
380	хааяа нэг	0	Х	\N
381	хааяа	0	Х	\N
416	эхнэр нөхөр хоёр	0	Э	\N
435	хялбар	0	Х	\N
436	найр	0	Н	\N
439	боох	0	Б	\N
444	нэртэй	0	Н	\N
445	сайн	0	Х	\N
447	магадгүй	0	М	\N
450	нэгэнт	0	Н	\N
452	хойно	0	Х	\N
457	тойрох	0	Т	\N
460	засах	0	З	\N
462	дорой	0	Д	\N
471	юбка	0	Ю	\N
478	өмнөд	0	Ө	\N
481	хөндлөн	0	Х	\N
489	чимээгүй	0	Ч	\N
1	өөрөө	1	Ө	131
2	байх	\N	\N	\N
3	өнөөдөр	1	Ө	130
4	явах	1	Я	127
5	англи хэл	1	А	120
6	нисэх онгоц	1	Н	122
7	гадаад орон	1	Г	104
8	гадаадын хүн	1	Г	106
9	монгол хэл	1	М	117
10	зочид буудал	1	З	118
470	я	0	Ю	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: mn
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: mn
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

