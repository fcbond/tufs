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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO ru;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO ru;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO ru;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: ru
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


ALTER TABLE public.t_instance OWNER TO ru;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO ru;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO ru;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: ru
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


ALTER TABLE public.t_usage_classified_rel OWNER TO ru;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: ru
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


ALTER TABLE public.t_usage_inst_rel OWNER TO ru;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO ru;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO ru;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: ru
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO ru;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: ru
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


ALTER TABLE public.t_word_inst_rel OWNER TO ru;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: ru
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO ru;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: ru
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO ru;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: ru
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_index_char (id, index_char) FROM stdin;
34	-
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
18	Р
19	С
20	Т
21	У
22	Ф
23	Х
24	Ц
25	Ч
26	Ш
27	Щ
28	Ъ
29	Ы
30	Ь
31	Э
32	Ю
33	Я
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
80	Мы гуляли по Летнем сáду.	私たちは夏の園を散歩した。	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
131			null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
182	Который сейчас час?	今何時ですか？	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
265	Понятно.	分かりました。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
936	Я послала открытку маме.	私は母にはがきを送った。	\N		\N	vmod	\N	\N	\N	0	1
1063			\N		\N	vmod	\N	\N	\N	0	1
1130	Я рада, что родилась в дружной семье.	私は仲のよい家庭に生まれたことがうれしい。	\N		\N	vmod	\N	\N	\N	0	1
1131	Сколько стоит билет?	切符はいくらしたの？	\N		\N	vmod	\N	\N	\N	0	1
1132	Из Москвы в Санкт-Петербург я летел на самолёте.	私はモスクワからサンクト・ペテルブルグまで飛行機で行った．	\N		\N	vmod	\N	\N	\N	0	1
1133	У нас нет времени.	僕らには時間がない	\N		\N	vmod	\N	\N	\N	0	1
1134	Ближайший магазин находится перед нашим домом.	最寄のお店は私たちの家の前にある。	\N		\N	vmod	\N	\N	\N	0	1
1135	Я не могу одалживать ему деньги каждый раз!	毎回毎回彼にお金を貸すなんて僕にはできない！	\N		\N	vmod	\N	\N	\N	0	1
149	Это Большой театр.	あれはボリショイ劇場だ	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
275	Меня зовут Мария.	私はマリーヤです。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
428	Да...	えぇ。	承諾する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
446	Ты не скажешь её телефон?	彼女の電話番号教えてくれない？			\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
621	Нет.	ありません。	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
685	Да, но не звони после десяти.	ええ、でも10時過ぎには電話しないで。	しないでくれと言う		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
843	Во сколько будет завтрак?	朝食は何時ですか？	\N		\N	vmod	\N	\N	\N	0	1
974			\N		\N	vmod	\N	\N	\N	0	1
999			\N		\N	vmod	\N	\N	\N	0	1
1058			\N		\N	vmod	\N	\N	\N	0	1
1	мисс	ミス	null		\N	gmod	explanation002.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
2	Это   виза?	これはビザですか？	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
3	Да,  это  виза.	はい，これはビザです．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
4	Он студéнт?	彼は学生ですか？	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
5	Да, он  студéнт	はい，彼は学生です．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
6	Кто  это?	あれはどなたですか．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
7	Это Володя.	あれはヴァローヂャです．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
8	Что это?	これは何ですか．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
37	этот дом	この家	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
59	Мы видели вдали море（対格）.	私達は遠くに海が見えた	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
257	Понятно.	わかりました。	承諾する		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
419	Три года.	３年です。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
454	У вас ещё остались билеты на сегодняшний концерт?	まだ今日のコンサートの切符はありますか？	場所についてたずねる		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
517	Хорошо.	いいですよ。	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
554	Так....	そうだな。	間をつくる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
583	Понятно.	わかった。	納得する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
742	Хорошо.	分かりました。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
770	новое слово	新出語	\N		\N	vmod	\N	\N	\N	0	1
848	Наступила зима.	冬がきた。	\N		\N	vmod	\N	\N	\N	0	1
1002			\N		\N	vmod	\N	\N	\N	0	1
1101	Взбейте яйца.	卵を泡立ててください。	\N		\N	vmod	\N	\N	\N	0	1
9	Это виза. 	それはビザです．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
10	Это виза? 	これはビザですか？	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
11	Нет,  это  не виза.	いいえ，これはビザではありません．	null		\N	gmod	explanation003.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
12	У нас чёрные глазá.	私達の目は黒い.	null		\N	gmod	explanation027.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
13	У нас чёрные глазá.	私達の目は黒い.	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
817	У неё красивое лицо.	彼女は美しい顔をしている。	\N		\N	vmod	\N	\N	\N	0	1
14	студéнт「男子学生」 трамвáй「路面電車」  музéй「博物館」 словарь「辞典」		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
15	студéнтка「女性学生」 Япóния「日本」 стáнция「駅」 новость「ニュース」		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
16	окнó「窓」 мóре「海 」 пóле 「野原」 здáние「建物」 время「時間」		null		\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	\N
17	юноша 「若者」, дядя「おじさん」, Ваня「ワーニャ（男性名の愛称形）」		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
18	мадам「マダム」, леди「～夫人」		null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
19	硬音で終わる男性名詞:　студент → студенты　「学生」　　 стол → столы　「机」		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
20	軟音で終わる男性名詞:　музей  → музеи   　「博物館」　 день → дни　「日」		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
21	硬音で終わる女性名詞:газета → газеты　「新聞」　　машина → машины　「自動車」		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
22	軟音で終わる女性名詞:станция → станции　「駅」　　дверь → двери　「ドア」		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
23	硬音で終わる中性名詞:　 слово → слова　「単語」　　место → места　「場所」		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	\N
24	軟音で終わる中性名詞:  море → моря　「海」　　поле → поля　「草原」		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
25	母音を落とすもの　　　стол→столы 食卓     японец→японцы 日本人　 день→ дни 日    головá→гóловы 頭    слóво →словá 単語       мóре →  моря 海		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]	\N	\N	\N
26	 -а, -яに終わる男性名詞    папа → папыパパ    дядя → дядиおじ		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[2]	\N	\N	\N
27	  -ьяに終わる中性名詞　　　　дéрево → дерéвья 木    перó → пéрья　ペン　　　крылó → крырья翼		null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[3]	\N	\N	\N
28	Дом новый.　　    「家は新しい」           Машина новая.　   「車は新しい」          Окно новое.　     「窓は新しい」          Карандаши новые.　「鉛筆[複数形]は新しい」		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
29	новый дом　 「新しい家」         новая машина　「新しい車」         новое слово　「新しい単語」         новые слова　「新しい単語[複数形]」		null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
30	Он　 был　 в 　России.	彼はロシアにいた／行ったことがある	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
31	Вы　 были　 в 　Японии?	あなたは日本に行ったことがありますか	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
32	Мать одевáтет мáльчика.	母が少年の身支度を整えている	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
33	Мáльчик одевáется.	少年は身支度している	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
34	Я сейчáс пишý книгу.	私はいま本を書いている	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
35	Он чáсто пишет письма.	彼はよく手紙を書く。	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
36	Мы интересýемся мýзыкой.	私達は音楽に興味があります	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
38	эта газета	この新聞	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
39	это море	この海	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
40	эти люди	この人たち	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
41	тот дом	あの家	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
42	та газета	あの新聞	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
43	то море	あの海	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	\N
44	те люди	あの人たち	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[4]	\N	\N	\N
45	весь дом	家全体	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
46	вся газета	新聞全部	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
47	всё море	海全体	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[3]	\N	\N	\N
48	все люди	全部の人々	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[4]	\N	\N	\N
49	―Вы говорите по-русски?	あなたはロシア語を話しますか？	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
50	―Да, я  говорю по-русски.	ええ，話します	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
51	Вы говорите и понимáете по-япóнски?	あなたは日本語を話し聞いて分かりますか？	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
52	Вы знáете япóнский язык?	あなたは日本語を知っていますか？	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
53	Я хочу есть.	私はおなかが空いている〈私は食べたい〉	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
54	Есть хотите?	おなかがすいていますか〈あなたは食べたいですか〉	null		\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
55	Мне 　хорошо.	僕は快適だ！	null		\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
56	извините	すみません	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
57	Скажите, пожалуйста,	すみません、教えていただけますか	null		\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
58	Там море（主格）.	あそこに海がある	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
60	Прошу прощения.	お許し下さい！	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
61	У меня есть  интересная  книга.	私は面白い本を持っています	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
62	Завтра я бýду читáть.	明日、私は読書するでしょう／読書するつもりです．	null		\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
63	Я люблю вас.	私はあなたを愛しています	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
64	Ты меня  любишь?	君は私を愛してはいるの？	null		\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
65	Ты меня  любишь?	君は私を愛してはいるの？	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
66	Вам не хóлодно?	あなたは寒くないですか？	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
67	Сегóдня вéчером я бýду у негó.	今晩私は彼のところにいます	null		\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
68	У нас нет машины.	私たちには車がない．	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
69	У нас не было машины.	私たちには車がなかった．	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
70	У нас не будет машины.	私たちには車がないだろう．	null		\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
71	Онá смотрéла на себя  в  зéркало.	彼女は鏡を見た（鏡で自分をみた）。	null		\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
72	О чём идёт  речь?	何について話しているのですか？	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
73	О ком ты дýмаешь?	誰のことを考えているの？	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
74	Я не могу работать в воскресенье.	私は，日曜日は働けません	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
75	Зáвтра мы не мóжем быть в шкóле.	明日私達は学校にいけません	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
76	Вы знáете назвáние красивого óзера?	あなたは美しい湖の名前を知っていますか？	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
77	Желáю вам счастливого пути.	道中ご無事で！	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
78	Вы говорите о старом Нóвом гóде?	あなたは旧正月について話しているのですか？	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
79	Вы говорите о красивом здáнии?	あなたは美しい建物について話しますか？	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
81	Поздравляю Вас с Новым гóдом!	新年おめでとう！	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
82	Вчерá я видел красивую дéвушку.	私はきれいな娘さんに会った。	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
83	Вы читáете Вечéрнюю Москвý?	あなたは「夕刊モスクワ」を読みますか？	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
84	– Что ты дéлали вчерá вéчером?	昨日の夕方あなたは何をしていましたか？	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
85	– Я читáла ромáн .	私は読書をしていました．	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
86	– Ты егó прочитáла?	あなたはそれを読んでしまいましたか？	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
87	– Нет. Тóлько вчерá началá читáть,  поэтому ещё не прочитáла	いいえ．つい昨日読み始めたので、まだ読んでしまっていません．	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
88	– Вы когда-нибудь читали Харуки Муракми?	あなたはかつて村上春樹を読んだことがありますか	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
89	– Да, читáл.	ええ，読んだことがあります．	null		\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
90	Завтра я прочитаю этот роман.	明日私はこの長編を読み終えよう	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
91	Завтра я буду читать этот роман.	明日私はこの長編を読みます／読むつもりです．	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
92	Что вы будете делать, когда прочитаете роман?	あなたは長編を読んだﾞら何をするのですか	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
93	Без вас  ваш друг приходил.	あなたの留守中にお友達が来ていましたよ．	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	\N
94	Без вас  ваш друг пришёл.	あなたの留守中にお友達が来ましたよ．	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	1
95	Я прочитáл письсмо.	私は手紙を読み終えた。	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
96	Я прочитáл газету и посмотрел телевизор.	私は新聞を読み終わり、テレビを見終えた。	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
97	Я читáл газету и смотрел телевизор.	私は新聞を読み、テレビを見た。	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	\N
98	Рáньше  она  газéту ýтром.	以前、彼女は朝に新聞を読んでいた.（反復）	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[4]/gmod:instance[1]	\N	\N	\N
99	Я обычно говорю по-русски.	私は、ふつうロシア語で話します	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
100	Я скажу это по-русски.	私はそれをロシア語で話しましょう	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
101	Она долго решала задачу и наконец решила её.	彼女は長いあいだ問題を解いていてようやく解けました	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
102	Я вам дам эти книги.	あなたにこれらの本をあげましょう．	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
103	Вы дадите мне эти книги?	私にこれらの本をくださるのですか？	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
104	Ты дашь мне эти книги?	私にこれらの本をくれるのかい？	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
105			null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
106	Я даю емý подáрок – япóнский гáлстук.	わたしは彼に贈り物をします．日本製のネクタイです．	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
107	Марико даёт емý красивый шарф, а подрýги дают прекрáсные цветы.	まりこは彼にきれいなマフラーを渡します．一方,女友達らは美しい花束を渡します．	null		\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
108	Он должен это сделать сегодня.	彼は今日それを仕上げねばならない．	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
109	Вы должны рáно ложиться спать и рáно вставáть.	あなたは早く寝て早く起きなくてはいけない．	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
110	Мы должны помочь сыну.	私達は息子を助けねばならない．	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
111	Что посеешь, то и пожнёшь.	まいた種は刈らねばならない.	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
112	Без труда не вынешь и рыбку из пруда.	労なくしては小魚一匹池から引き上げることは出来ない.	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
113	Давáйте говорить по-рýсски.	ロシア語を話しましょう.	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
114	Давáйте поговорим.	話してみましょう	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
115	Давáйте бýдем говорить по-рýсски.	ロシア語を話してみましょう	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
116	Тогдá я был дипломáтом.	当時私は学生だった	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
117	Через год я бýду врачом.	私は一年後に医者になる	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
118	Я хочý быть президентом.	私は大統領になりたい	null		\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
119	Вдруг небо стало синим.	不意に空が青くなった	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
120	Мой спутник оказался интересным человеком.	私の道連れは面白い人だった	null		\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
121	Наш учитель часто даёт нам хорошие советы.	私達の先生はよく私達に有益なアドバイスをしてくれます	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
122	Дайте мне ключ  от комнаты.	私に部屋の鍵を渡してください	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
123	Мы даём емý подáрок – французский гáлстук.	私たちは彼に贈り物－フランス製のネクタイをします	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
124	Я люблю матери.	私は母親を愛している	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
125	Мать очень волнуется за дочери.	母は娘のことをとても心配している	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
126	В России я часто вспоминаю о матери.	ロシアで私はしばしば母のことを思い出した	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
127	Вчера ночью мы позвонили матери.	昨日の夜私たちは母に電話した	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
128	Надо купить зимние вещи.	冬に使う品物を買わなくてはならない	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
129	Муж работает с утра до ночи.	夫は朝から夜まで働いている	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
130	Он всегда возвращается к ночи.	彼はいつも夜までに帰る	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
132	Сколько сейчас временя?	今何時ですか	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
133	Утром я ем много.	朝に私はたくさん食べます	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
134	Они не едят ни рыбы, ни мяса.	彼らは魚も肉も食べません	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
135	Я иду в магазин.	私はお店へ行くところです。	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
136	Я еду в Санкт-Петербург на поезде.	私は汽車でサンクトペテルブルグへ行くところです。	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
137	Из Москвы в Санкт-Петербург я летел на самолёте.		null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
138	Мы едем на такси.	私たちはタクシーに乗って移動中だ。	null		\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
139	Посмотрите на эту девушку!	あの娘さんを見てごらんなさい	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
140	Я прочитáла всю книгу за неделю.	私は1週間で（一冊の）本を始めから終わりまで通読しました．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
141	Я прочитáл все эти книги.	私はこれらの本をすべて読みました．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
142	Посóл знáет всё.	大使は何でも知っています．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
143	Все за одногó, один за всех.	みんなは一人のために、一人はみんなのために．	null		\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
144	По рáдио передают интересные извéстия.	ラジオで面白いニュースを報じています．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
145	Меня ждут.	私は待たれています→待っている人がいるのです．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
146	Тебé сегóдня звонили.	今日、君に電話があったよ．	null		\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
147	Сегодня хорошая погода.	今日はよい天気です	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
148	Мы изучаем японский язык.	私達は日本語を勉強しています	null		\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
150	Я выпил воды.	私は水を少し飲んだ.	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
151	Дайте, пожалуйста,  хлеба.	パンを少々下さい.	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
152	Я выпил воду.	私は水を飲んだ(ジュース、お茶などでなく）.	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
153	Дайте, пожалуйста, этот хлеб.	このパンを下さい.	null		\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	1
154	Идёт фильм.	映画が上映されている．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
155	Идёт дождь / снег.	雨/雪が降っている．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
156	Время идёт.	時が経つ．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
157	О чём идёт речь?	何のことを話しているのですか．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
158	Время летит .	時は飛ぶように過ぎます（光陰矢のごとし）．	null		\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
159	Общежитие для студентов	学生寮	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
160	нéсколько слов	いくつかの言葉	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
161	У них с собóй мнóго вещéй?	彼らは荷物を多く持っていますか	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
162	Это – одно из самых высоких зданий Москвы.	それはモスクワの高層建築のひとつです	null		\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
163	Население Японии составляет примерно 120,000,000 (сто двадцать миллионов) человек.	日本の人口は約1億2000万人です	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
164	У нас в грýппе четыре студéнта.	私たちのグループには4人の学生がいます	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
165	Он знáет мнóго рýсских слов.	彼はロシア語の単語をたくさん知っている	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
166	Скóлько человéк у вас в семьé?  - У нас четыре человéка.	「あなたの家族は何人ですか?」　「4人です」	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
167	Скóлько тебé лет?  - Мне 5 лет.	「君はいくつ？」　「5歳です」	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
168	Котóрый сейчас час? 　- 3 часá.	「いま何時ですか?」　「3時です」	null		\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
169	Можно войти?	入っていいですか?	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
170	Приезжайте в Японию.	日本にいらしてください	null		\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
171	Он всегда помогает друзьям.	彼はいつも友達の手伝いをします	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
172	Он играл в футбол с друзьями.　	彼は友達とサッカーをした	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
173	Они передали привет своим школьным друзьям.	彼らは学校時代の友達によろしくと伝えた	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
174	Государство заботится о матерях. 	国家は母親のことを配慮しています	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
175	Я помогаю друзьям изучакть русский язык.	私は友達のロシア語の勉強を手伝っています	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
176	Я часто разговаривал с молодыми студентами.	私はしょっちゅう若い学生と話しました	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
177	Мы покупаем кинги в новых книжных магазинах.	私達は新しい書店で本を買います	null		\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
178	Какое сегодня число?  － Сегодня двадцать трéтье января.	「今日は何日ですか？」　「今日は1月3日です」	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
179	   － Когда вы приехали в Японию? 　–  Трéтьго января.	   「いつ日本にいらっしゃいましたか？」　「1月3日です」	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
180	В каком году вы родились? 　－ В тысяча девятьсот девяносто третьем году.	「あなたは何年に生まれましたか？」　「1993年です」	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
181	    Во сколько вы встали сегодня?	何時に今朝は起きましたか？	null		\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
183	    Сейчас сколько времени?	今何時ですか？	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
184	В которому часу вы встали сегодня?  	何時に今朝は起きましたか？	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
185	    Во сколько вы встали сегодня?	何時に今朝は起きましたか？	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
186	Кто-нибудь звонил без меня?	私の留守中に誰かから電話がありましたか	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
187	Да, кто-то звонил.	ええ，誰かから電話がありました	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
188	Давайте встретимся где-нибудь в Москве.	モスクワの（どこでも良いから）どこかで会いましょうよ	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
189	Пойдём куда-нибудь сегодня вечером.	今晩どこかへ出かけようよ	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
190	Она ничего не знает.	彼女は何も知らない	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
191	   Зимой они нигде не были.	冬には彼らはどこへも行きませんでした	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
192	   Искать свой талант никогда не поздно.	才能を探すのは決して遅いということはありません	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
193	Мне некого спросить.	私の質問に答えてくれる人がいない	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
194	   －Подожди меня, Саша!	サーシャ，待って	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
195	   －Мне некогда. Я опоздываю на работу.	時間がないんだ，会社に遅れそうなので	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[3]	\N	\N	1
196	Ему не с кем будет поговорить.	彼には話し相手がいないだろう	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	\N
197	Вот мой друг, который живёт в Москве.      （主格）	ほら,モスクワに住んでいる私の友人です.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
198	Вот мой друг, сестра  которого  хорошо знает русский язык.   　 （属（生）格）	ほら,（彼の）お姉さんがロシア語をよく知っている，私の友人です.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
199	Вот мой друг, которого мы ждали так долго.          （対格）	ほらこちらが,私たちがこんなに長いこと待っていた，私の友人ですよ.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
200	Вот мой друг, с которым я тебя познакомлю сегодня.              （具（造）格）	ほら,今日君に紹介する私の友人です.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
201	Вот мой друг, о котором писали во всех газетах.                  （前置（詞）格）	ほら,あらゆる新聞に書かれている私の友人です.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
202	Я знал то, что он вам рассказал. 	私は彼が君に話したことを知っている.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	\N
203	Не откладывай на завтра то, что можешь сделать сегодня.	今日出来ることは明日に延ばすな.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
204	Кто не работает, тот не ест.	働かざるもの,食うべからず	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[1]	\N	\N	1
205	Всë хорошо, что хорошо кончается.	終わりよければすべてよし.	null		\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[3]/gmod:instance[2]	\N	\N	\N
206	Я часто вспоминаю день, когда мы в первый раз встретились.  　　　→Я часто вспоминаю день, в который～	私は，私たちが最初に出会った場所をよく思い出します．	null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
207	Вы знаете дом, где она живет?	あなたは彼女が住んでいる家を知っていますか．	null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
208	Сейчас мы находимся в самой новой части Москвы.	私たちは今,モスクワでもっとも新しい地区にいる.	null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
209	Ломоносов был крупнейшим ученым ⅩⅤⅢ века.	ロマノソフは18世紀最大の学者だった.	null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
210	Это более важный вопрос.	これはより重要な問題だ.	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
211	   Этот фильм более интересен.	このフィルムはより興味深い.（文章語的）	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
212	Этот вопрос является более интресным.	この問題はより興味深いものである.(形容詞は具格（造格）)	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
213	Иди сюда. Здесь светлее.	こっちに来いよ.ここは明るいよ.	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[1]	\N	\N	1
214	Подходит он ближе и ближе.	彼がだんだん近づいてくる.	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[2]/gmod:instance[2]	\N	\N	\N
215	Мой чемодан больше, чем твой.	私のかばんは君のよりも大きい.	null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
216	Дети любят белый хлеб больше чёрного.	子どもらは黒パンよりも白パンのほうが好きだ.	null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
217	Жена старше мужа на три года.	妻は夫よりも３歳年上だ.	null		\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
218	В один прекрасный день	ある日のこと	null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
219	Мы с ним учились в одной школе.	私と彼は同窓生です（同じ学校でまなびました）.	null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
220	Одни изучают русский язык, а другие - английский.	ロシア語を勉強するものもあれば,英語を勉強するものもある．	null		\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
221	У них две книги.	彼らは2冊の本がある.	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
222	Каждый день они работают до четырёх часов.	彼らは毎日4時まで働きます	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
223	У них шесть книг.	彼らは6冊の本がある.	null		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
224	Каждый день они работают до шести часов.	彼らは毎日6時まで働きます.	null		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
225	В Японии живёт примерно сто двадцать миллионов жителей.	日本には約120,000,000人がすんでいます.	null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
226	Сейчас у меня в кармане 800 рулбей.	今私のポケットには800ルーブルあります.	null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
264	Тогда вы увидите книжный магазин.	そうすると本屋さんが見えてきますから。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
227	Если бы вчера/сегодня  была хорошая погода, мы поехали бы в лес.	昨日／今日天気がよかったら,私達は公園に出かけたのですが.	null		\N	gmod	instances666.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
228	Если завтра будет хорошая погода, мы поедем в парк.	明日天気がよければ,私達は公園に出かけます.	null		\N	gmod	instances666.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
229	Мне хотéлось бы пить.	私は（できれば）飲み物をとりたいのです.	null		\N	gmod	instances666.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
230	Я завтра напишу им, что они приехали.　	彼らがやってきたと彼らに明日手紙を書きます.	null		\N	gmod	instances666.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
231	Я завтра напишу им, чтóбы　они приехали. 	彼らにやってこいと彼らに明日手紙を書きます.	null		\N	gmod	instances666.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
232	Я хочу, чтобы вы меня правильно поняли.	私の言うことを正しく理解して欲しい.	null		\N	gmod	instances667.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
233	Скажи, чтобы мне дали воды.	私に水をくれるよう言ってくれ.	null		\N	gmod	instances667.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
234	Я попросил, чтобы он мне купил билеты в кино.	私は彼に映画のチケットを買ってきてくれるよう頼んだ.	null		\N	gmod	instances667.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
235	Я говорил громко, чтобы всем было хорошо слышно.	私は全員によく聞こえるように大きな声で話した.	null		\N	gmod	instances667.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
236	Здравствуйте, Мария Яковлевна!	こんにちは、マリーヤ・ヤーカヴレヴナ！	挨拶をする		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
237	Добрый день, Иван Иванович!	こんにちは、イワン・イワーナヴィチ！	挨拶をする		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
238	Как поживаете?	ご機嫌いかがですか？	どうしているかをたずねる		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
239	Спасибо, хорошо.	ありがとう。上々ですよ。			\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
240	А вы?	あなたは？	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
241	Спасибо, неважно.	ええ、余り良くないです。	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
242	Что случилось?	どうかされたんですか？	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
243	Вчера все данные в компьютере потерялись.	昨日、コンピューターのデータが全部消えてしまったんです。	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
244	Вы не копировали данные?	バックアップは取ってらっしゃらなかったんですか？	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
245	Копировал, но не все.	取ってありましたが、全部じゃなかったのです。	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
246	Сочувствую вам.	お気の毒様です。	機能		\N	dmod	ru01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
247	Здравствуйте, Иван Иванович.	こんにちは、イワン・イワーナヴィチ。	挨拶する		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
248	Добрый день, Мария.	こんにちは、マリーヤ。	挨拶をする		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
249	У вас есть время?	お時間ありますか？	状況についてたずねる		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
250	Я хотела бы посоветоваться о моей статье.	論文について助言を頂きたいのですが。	希望を述べる		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
251	Хорошо, но не сейчас.	いいですよ。でも今はちょっと。	予定を述べる		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
252	Сейчас у меня будет заседание.	これから会議があるので。	予定を述べる		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
253	Заходи ко мне в кабинет попозже.	後で私の研究室にいらっしゃい。	指示する		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
254	Спасибо.	ありがとうございます。	感謝する		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
255	Пожалуйста.	どういたしまして。	感謝に対する受け答え		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
256	Я приду к вам после занятия.	授業の後で伺います。	予定を述べる		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
258	Я буду ждать.	お待ちしています。	予定を述べる		\N	dmod	ru02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
259	Извините, вы не знаете, где находится ближайший книжный магазин?	すみませんが、最寄りの本屋さんはどこにあるかご存知ありませんか？	注意をひく		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
260	Да, знаю.	ええ、知っていますよ。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
261	Там белое здание, видите?	あそこに白い建物が見えるでしょう？	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
262	Да, вижу.	ええ、見えます。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
263	Там поверните направо.	そこで右に曲がってください。	指示する		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
266	А как он называется?	何という名前でしょうか。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
267	"Мир книг".	「本の世界」です。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
268	Спасибо.	どうもありがとうございます。	感謝する		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
269	Не за что.	どういたしまして。	機能		\N	dmod	ru03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
270	Простите.	すみません。	注意をひく		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
271	Давайте познакомимся.	自己紹介をさせてください（知り合いになりましょう）。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
272	Меня зовут Иван.	私はイワンといいます。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
273	Я аспирант этого университета.	この大学の大学院生です。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[4]	\N	\N	\N
274	А я студентка.	私は学生です。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
276	Очень рад с вами познакомиться.	お会いできてうれしいです。	意見を言う		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
277	Очень рада.	こちらこそ。	意見を言う		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
278	Иван, откуда вы?	イワン、あなたはどちらのご出身ですか？	情報を求める(場所)		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
279	Я из Санкт-Петербурга.	私はサンクト・ペテルブルク出身です。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
280	Мой отец и моя мать живут там.	父と母はそこで暮らしています。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
281	А вы, Мария?	あなたは（どちらのご出身ですか）、マリーヤ？	情報を求める(場所)		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
282	А я москвичка.	私はモスクワっ子です。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
283	Но раньше я жила в Санкт-Петербурге.	でも以前サンクト・ペテルブルクに住んでいたんですよ。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
284	Там я прожила пять лет.	5年くらい住んでいました。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
285	Так долго?	そんなに長くですか？	驚きを表現する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
286	А когда вы возвратились в Москву?	いつモスクワにお戻りになったんですか？	情報を求める(時間)		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
287	Два года назад.	2年前です。	自己紹介する		\N	dmod	ru04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
288	Извините, пожалуйста, что я опоздал.	遅くなってすみません。	あやまる		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
289	Вы долго ждали?	ずいぶん待たれましたか？	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
290	Вы не замёрзли?	寒かったでしょう？	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
291	Нет.	いいえ。	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
292	Я только что пришла.	来たばっかりですから。	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
293	Спасибо, что вы позвонили вчера.	昨日はお電話を頂いてどうもありがとうございました。	感謝する		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
294	Не за что.	どういたしまして。	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
295	А я должна извиниться за то, что вчера звонила вам очень поздно.	私の方こそ昨日はずいぶん遅くにお電話をしてしまって申し訳ありませんでした。	あやまる		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
296	Ну, что вы!	とんでもない。	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
297	Не беспокойтесь.	お気になさらないで下さい。	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
298	Ведь я сова.	私は宵っ張りですから。	機能		\N	dmod	ru05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
299	Добрый вечер, Мария.	こんばんは。	挨拶をする		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
300	Поздравляю тебя с днём рождения.	マリーヤ、お誕生日おめでとう。	お祝いを言う		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
301	Иван Иванович, как я рада вас видеть.	イワン・イワーナヴィチ、お見えいただいてうれしいです。	感謝する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
302	Проходите, пожалуйста.	どうぞ奥へ。	指示する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
303	Вот, пожалуйста.	はい、どうぞ。	人にものをあげる		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
304	Это тебе.	これを君に。	人にものをあげる		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
305	Спасибо.	ありがとうございます。	感謝する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
345	Да, возьму.	はい、もらいます。	承諾する		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
306	Моя жена сказала, что тебе нравятся красные розы.	君は赤いバラが好きだって私の妻が教えてくれたよ。	理由を述べる		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
307	Да, совершенно верно!	本当にそうなんです。	相槌を打つ		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
308	Я долго думал, что тебе подарить.	何をプレゼントしていいかずいぶん考えたんだがね。	意見を言う		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
309	Это подарок для хорошего настроения: французские духи "Шанель".	これは素敵な気分のために。フランス製の香水で「シャネル」だ。	何かをあげる		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
310	Спасибо большое, Иван Иванович.	本当にありがとうございます、イワン・イワーナヴィチ。	感謝する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
311	Какие прекрасные духи!	何て素敵な香水なんでしょう！	感嘆する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
312	Я рад, что тебе нравится подарок.	君がプレゼントを気に入ってくれて、私も嬉しいよ。	意見を言う		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
313	Да, очень нравится.	とても気に入りました。	意見を言う		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
314	Спасибо.	ありがとうございます。	感謝する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
315	Ну, прошу к столу.	さぁ、テーブルの方へどうぞ。	指示する		\N	dmod	ru06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	1
316	Спасибо, но мне уже пора.	ありがとう。でももう時間だから。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
317	Надо уходить.	行かなくちゃ。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
318	Спасибо за угощение.	すっかりご馳走になっちゃって。	感謝する		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
319	Почему?	どうして？	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
320	Ещё рано.	まだ早いじゃない。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
321	Надо встретить друга в аэропорту.	空港で友達の出迎えをしなくちゃいけないんだ。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
322	Откуда он прилетает?	その人はどこから来るの？	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
323	Из Японии.	日本だよ。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
324	Он впервые в России.	ロシアは初めてなんだ。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
325	Если я не встречу его, он обязательно заблудится.	迎えに行かないと、きっと迷っちゃうから。	ある条件での行動を言う		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
326	Может быть.	かもね。	相づちを打つ		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
327	В котором часу его нужно встретить?	何時にお出迎えするの？	情報を求める（時間）		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
328	В шесть.	６時。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
329	Надо спешить.	いそがなくちゃ。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
330	До свидания, Маша!	さよなら、マーシャ！	さよならを言う		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
331	Завтра позвоню.	明日電話するよ。	機能		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	1
332	До завтра!	じゃあ、また明日！	さよならを言う		\N	dmod	ru07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
333	Будьте добры, покажите мне тот японско-русский словарь.	すみません、あの和露辞典を見せてください。	指示する		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
334	Этот?	これですか？	情報を確認する		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
335	Справа.	右です。	情報を修正する		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
336	Вон, вон.	それです、それです。	指示する		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
337	Пожалуйста.	どうぞ。	人にものをあげる		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
338	Я никогда не видел этот словарь.	この辞書は今まで見たことがないな。	経験を述べる		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
339	Это новый?	これは新しいんですか？	情報を求める(属性)		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
340	Да, новейший.	はい、最新ですよ。	情報を与える(属性)		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
341	Напечатан в прошлом месяце.	先月出版されたばかりですから。	情報を与える(属性)		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
342	Сколько он стоит?	いくらですか？	金額についてたずねる		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
343	Триста восемьдесят рублей.	380ルーブリです。	情報を与える(金額)		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
344	Возьмёте?	お求めになりますか？	意向を尋ねる		\N	dmod	ru08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
870	Вадим вошёл в класс.	ワヂムは教室に入った。	\N		\N	vmod	\N	\N	\N	0	1
346	Вы читали "Преступление и наказание" Достоевского?	ドストエフスキーの『罪と罰』は読んだことがありますか？	経験についてたずねる		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
347	Да, читал.	ええ、読みました。	機能		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
348	Этот роман мне нравится.	あの小説は好きです。	嗜好について述べる（もの）		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
349	А ещё какие русские произведения вы читали?	他にどんなロシアの作品を読まれましたか？	経験についてたずねる		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
350	"Белую ночь".	『白夜』です。	機能		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
351	Это моя любимая повесть.	あれは私のお気に入りの小説です。	機能		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
352	Писатель очень красиво изобразил Санкт-Петербург того времени.	作者は当時のサンクト・ペテルブルクを非常に美しく描いていますね。	機能		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
353	А вы, кстати, были в Санкт-Петербурге?	ところで、サンクト・ペテルブルクにいらしたことは？	経験についてたずねる		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
354	Нет ещё.	まだです。	機能		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
355	Я очень хочу посмотреть его.	すごく見てみたいんですがね。	希望を述べる		\N	dmod	ru09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
356	Маша, привет.	やぁ、マーシャ。	挨拶をする		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
357	Ой, Иван, привет.	こんにちは、イワン。	挨拶をする		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
358	Скажи, Маша, ты занята завтра?	ねぇマーシャ、明日暇かな？	予定を尋ねる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
359	Что ты будешь делать?	何をする予定？	予定を尋ねる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
360	Утром я буду заниматься в библиотеке.	午前中は図書館で勉強ね。	予定を言う		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
361	Днём у меня будут занятия.	午後は授業があるけど、	予定を述べる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
362	Но вечером я буду свободна.	でも、晩は暇よ。	予定を言う		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
363	Как хорошо!	あぁ、よかった。	感嘆する		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
364	У меня два билета в Большой театр, но завтра вечером у меня будет гость.	ボリショイ劇場の切符が２枚あるんだけど、明日僕にお客さんが来るんだ。	存在を述べる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
365	Ты хочешь послушать оперу "Борис Годунов"?	オペラの「ボリス・ゴドゥノフ」は見たいかい？	意向を尋ねる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
366	"Борис Годунов"?	「ボリス・ゴドゥノフ」？	情報を確認する		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
367	Да, очень хочу.	えぇ、とても見たいわ。	希望を述べる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
368	Сколько стоит билет?	切符はいくらしたの？	情報を求める(金額)		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
369	Нет, не надо платить.	いや、お金は払わなくていいよ。	非行為を依頼する		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
370	Мне эти билеты подарил друг.	このチケットは友だちがくれたんだ。	理由を述べる		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
371	Спасибо большое.	本当にありがとう。	感謝する		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
372	Пока.	じゃぁね。	挨拶をする		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
373	Всего хорошего!	またね。	挨拶をする		\N	dmod	ru10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
374	Здравствуйте, Мария Яковлевна!	こんにちは、マリーヤ・ヤーカヴレヴナ！	挨拶をする		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
375	Я Кэн Судзуки.	私が鈴木健（すずき・けん）です。	自己紹介する		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
376	Вы не русский!?	あなた、ロシア人じゃなかったんですか！？	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
377	Я не поняла, что вы иностранец, когда мы с вами вчера разговаривали по телефону.	昨日お電話でお話しした時にはあなたが外国人だとは分かりませんでした。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
378	Ведь вы очень хорошо говорите по-русски.	ずいぶんお上手にロシア語をお話しになるから。	理由を述べる		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
379	Спасибо за комплимент.	お褒めいただいてありがとうございます。	感謝する		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
380	Извините, что не сказал вам своего имени вчера.	昨日は名前を申し上げずにすみませんでした。	あやまる		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
381	Не беспокойтесь.	気になさらないで下さい。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
382	Рада с вами познакомиться.	お知り合いになれて嬉しいです。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
383	А как долго вы учите русский язык?	ところで、どれくらいロシア語を勉強されているんですか？	程度についてたずねる		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
384	Уже 7 лет.	もう７年になります。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
385	Но в Японии, знаете, совсем мало возможности слушать и говорить по-русски.	しかし日本では、ロシア語で聞いたり、話したりする機会が非常に少ないので。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
386	Как долго вы жили в России?	どれくらい長くロシアに住まれていたのですか？	情報を求める（程度）		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
387	Я был в России в туристической поездке.	観光以外ではロシアには行ったことはありません。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
388	Всего три недели.	３週間だけですね。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
389	Поэтому я не уверен, могу ли я общаться на русском языке без проблем.	なのでロシア語で問題なくコミュニケーションが取れるかどうか自信が無いのです。	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
390	Что вы, что вы!	何をおっしゃいますやら！	機能		\N	dmod	ru11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
391	Здравствуй, Иван.	やぁ、イワン。	挨拶をする		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
392	Привет, Маша.	やあ、マーシャ。	挨拶をする		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
393	Ты когда сегодня кончаешь заниматься?	今日は何時に勉強が終わるの？	時間についてたずねる		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
394	В четыре.	４時だよ。	情報を与える(時間)		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
395	А что?	どうして？	理由を尋ねる		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
396	Ты не хочешь пойти с нами на футбол?	私たちと一緒にサッカーに行きたくない？	勧誘する		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
397	Конечно, хочу.	もちろん行くさ。	勧誘に応ずる		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
398	Я очень люблю спорт.	スポーツは大好きなんだよ。	嗜好について述べる(行動)		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
399	Так, где мы встретимся?	さて、どこで待ち合わせにする？	情報を求める(場所)		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
400	И в котором часу?	それから何時に？	時間についてたずねる		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	\N
401	В шесть часов у метро "Спортивная", около выхода к стадиону.	６時に地下鉄「スパルチーヴナヤ」駅のスタジアム側の出口あたりよ。	情報を与える(時間)		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
402	Хорошо?	大丈夫？	都合を尋ねる		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
403	Хорошо.	大丈夫だよ。	承諾する		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
404	До вечера.	じゃぁ、また晩にね。	挨拶をする		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
405	До вечера.	またね。	挨拶をする		\N	dmod	ru12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
406	Сколько человек в вашей семье?	ご家族は何人ですか？	情報を求める（数字）		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
407	Четверо.	４人です。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
408	Вот моя семья.	（写真を見せながら）これが私の家族です。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
409	Папа, мама, брат и я.	父、母、弟、そして私です。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
410	О!	おぉ！	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
411	Ваш брат похож на вас.	弟さんはあなたに似てますね。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
412	Часто так говорят.	よく言われます。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
413	Но я так не думаю.	でも私はそうは思わないんですけど。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
414	Очень похож.	そっくりですよ。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
415	Как зовут вашего брата?	お名前は？	名前を尋ねる		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
416	Валентин.	ヴァレンチーンです。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
417	Он ещё студент.	まだ大学生です。	機能		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
418	Сколько лет он учится в университете?	大学で何年勉強されているんですか。	情報を求める（数字）		\N	dmod	ru13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
420	Здравствуйте.	こんにちは。	挨拶する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
421	Здравствуйте.	こんにちは。	挨拶をする		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
422	Я хочу взять роман Достоевского "Братья Карамазовы".	ドストエフスキーの「カラマーゾフの兄弟」を借りたいのです。	意見を述べる		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
423	Но, я не могу найти его.	でも、それが見あたりません。	情報を伝える(存在)		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
424	Сейчас посмотрим.	いま探してみましょう。	依頼を受ける		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
425	Но, сначала заполните этот бланк.	でもまずこちらの空欄に記入してください。	指示する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
426	Можно вписать карандашом?	鉛筆で書いてもいいですか？	何でどのようにするかを言う		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
427	У меня нет ручки.	ペンは持ってないので。	理由を述べる		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
429	Но, ручкой лучше.	あ、でもペンの方がいいですね。	比べる		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
430	Вот, пожалуйста.	はい、こちらをどうぞ。	何かをあげる		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
431	Спасибо.	ありがとうございます。	感謝する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
432	Так хорошо?	これでよろしいですか？	情報を確認する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
433	Да, хорошо.	結構です。	承諾する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
434	Одну минуточку.	少々お待ちください。	指示する		\N	dmod	ru14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
435	Маша, ты говоришь по-английски?	マーシャ、君英語話せる？	能力についてたずねる		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
436	Да, а почему ты спрашиваешь?	ええ、でもどうして？	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
437	Завтра один учёный приедет из Англии к нам на международную конференцию.	明日ある学者がイギリスから国際会議に来るんだよ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
438	Но наш гид-переводчик заболел, поэтому мы ищем кого-нибудь, кто говорит по-английски.	でも通訳ガイドが病気になっちゃって。だから誰か英語を話せる人を探してるんだ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
439	Ты завтра будешь свободна?	明日は空いてるかい？	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
440	Извини, Иван, завтра я буду занята.	ごめんね、イワン、明日はふさがってるのよ。	あやまる		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
441	Не могу помочь тебе.	お手伝いできないわ。			\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
442	Среди твоих друзей нет кого-нибудь, кто знает английский язык.	君の友達で誰か英語の分かるひといないかな？	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
443	Моя подруга, Наташа, тоже может переводить с английского языка.	友達のナターシャも英語の通訳できるわよ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
444	Но она занимается письменным переводом, поэтому, может быть, она не захочет.	でも彼女普段は翻訳をやっているから、ひょっとしたらやりたがらないかもしれないわね。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
445	Я сам спрошу её.	僕自分で彼女に聞いてみるよ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
447	Сейчас не могу.	今はだめだわ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
448	Я забыла мою книжку дома.	家に手帳を置いてきちゃったの。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
449	Вечером позвоню.	今晩電話するわ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
450	Пожалуйста.	頼むよ。	機能		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
451	Заранее спасибо.	よろしく。	感謝する		\N	dmod	ru15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
452	Добрый вечер.	こんばんは。	挨拶をする		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
453	Здравствуйте.	こんばんは。	挨拶をする		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
455	Да, есть.	ありますよ。	情報を伝える(存在)		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
456	Но, остались только на втором ярусе.	でも２階席しか残っていません。	情報を与える(場所)		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
457	Какие места?	席はどこですか？	場所についてたずねる		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
458	Вот это схема этого театра.	これがこの劇場の見取り図です。	ものを見せる		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
459	Остались места в третьем ряду, семнадцатое, восемнадцатое, девятнадцатое и двадцатое.	３列目の17、18、19、20番。	情報を与える(存在と場所)		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
460	И ещё остались в четвёртом ряду, пятое и шестое.	それから４列目の５番と６番ですね。	情報を与える(存在と場所)		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
461	Я возьму билеты в третьем ряду.	３列目の切符を買います。	情報を伝える(存在と場所)		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
462	Семнадцатое и восемнадцатое, пожалуйста.	17番と18番を下さい。	情報を伝える(存在と場所)		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
463	Хорошо.	かしこまりました。	承諾する		\N	dmod	ru16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
464	Какой словарь у тебя?	何の辞書を持ってるの？	情報を求める（属性）		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
465	Это?	これ？	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
466	Это русско-английский словарь.	これは露英辞典よ。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
467	Я начала учить английский язык.	英語の勉強を始めたの。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
468	Молодец!	すごい！	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
469	А почему?	でもなんで？	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
470	Летом прошлого года я познакомилась с девушкой из Англии.	去年の夏、イギリスの女の子と知り合ったのよ。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
471	Сейчас мы с ней переписываемся.	今彼女と文通してるの。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
472	Поэтому я изучаю английский язык.	だから英語を勉強してるのよ。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
473	К тому же, знание английского языка открывает мне возможность общаться с людьми из разных стран.	それに、英語を知っていれば、様々な国の人々とコミュニケーションをとる可能性が開かれるでしょ。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	1
474	Действительно.	確かに。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
475	Постоянно общаться на иностранных языках с носителями этих языков - самый лучший метод для изучения иностранных языков.	外国語でその言葉のネーティヴスピーカーとやり取りするのは、外国語を勉強する一番良い方法だからね。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
476	А какой она человек?	彼女はどんな人なの？	特徴についてたずねる		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
477	Она очень скромная, серьёзная.	とても控えめで、きちんとしたひとよ。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
478	Я хочу, чтобы ты познакомился с ней.	あなたにも知り合いになってほしいわ。	機能		\N	dmod	ru17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
479	Мария, скажи, пожалуйста, ты читала роман Л.Н.Толстого "Анна Каренина"?	マリーヤ、ちょっと聞くんだが、君はトルストイの「アンナ・カレーニナ」は読んだことがあるかね？	経験をたずねる		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
480	Да, читала.	はい、読んだことがあります。	経験を言う		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
481	До конца прочитала? 	最後まで読んだのかね？	経験をたずねる		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
482	Да, до конца.	えぇ、最後まで。	経験を言う		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
483	Я читала несколько раз.	数回通読しました。	経験を言う		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
484	Один из моих студентов сказал, что "Анна Каренина" - слишком большой роман и скучно читать.	私の学生の１人が、「アンナ・カレーニナ」は長すぎて退屈だと言っていたんだ。	伝聞を伝える		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
485	А как ты думаешь?	君はどう思うかね？	意見をたずねる		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
486	Я так не думаю.	私はそうは思いません。	意見を述べる		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
487	Хотя он большой, но мне интересно.	確かに長いですが、私にとっては面白いです。	意見を言う		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
488	Всегда, когда я читала его, я думала о любви.	読むたびに愛について考えてしまいます。	意見を言う		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
489	А вы как думаете, Иван Иванович?	先生はどうお考えですか、イワン・イワーナヴィチ？	意見をきく		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[4]	\N	\N	\N
490	Я думаю, что "Анна Каренина" - важная русская классика.	私はロシアの大切な古典だと思う。	意見を述べる		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
491	Всегда, когда я читал его, я думал о семье.	そして読むたびに家族について考えてしまうよ。	意見を言う		\N	dmod	ru18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
492	Как вам нравится наш город?	私たちの町はいかがですか？	情報を求める（程度）		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
493	Очень нравится.	とても気に入っています。	嗜好について述べる（もの）		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
568	Давай пойдём в кино!	映画に行こうよ！	提案する		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
494	Воздух чистый, еда вкусная, и, самое главное, люди тёплые.	空気がきれいで、食事も美味しくて、それに一番重要なことだけど、人々も暖かいし。	機能		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
495	Я очень рад, что вам нравится наш город.	私たちの町が気に入って頂けて、私も嬉しいです。	機能		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
496	Между прочим, вы уже пробовали наши яблоки?	ところで私たちの町のリンゴはもうお試しになりましたか？	情報を求める（経験）		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
497	Наш город очень известен яблоками.	この町はリンゴで有名なんですよ。	機能		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
498	Да, пробовала.	ええ、食べました。	機能		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
499	Очень вкусно.	とても美味しいです。	機能		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
500	Я очень люблю яблоки, каждый день их ем.	私はリンゴが大好きなので、毎日食べていますよ。	好きなものについて述べる		\N	dmod	ru19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
501	Какая хорошая погода!	なんていい天気なんでしょう。	感嘆する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
502	Чистый воздух, голубое небо....	空気はきれいだし、空は青いし。	状況を描写する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
503	Да....	そうだね。	相槌を打つ		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
504	Давай погуляем в парке, да?	公園で散歩しましょうよ。ね？	勧誘する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
505	Я очень люблю гулять.	私、散歩するのが大好きなの。	好きな行動について述べる		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
506	Извини, не хочется.	ごめん、そういう気分じゃないんだ。	あやまる		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
507	Что случилось?	どうしたの？	心配する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
508	Вчера я спал только три часа.	昨日３時間しか眠れなかったんだよ。	状況を説明する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
509	Почему-то мне не спалось.	なぜだか寝付けなかったんだ。	状況を説明する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
510	А теперь я хочу пойти домой поспать.	今になって家で眠たくなっちゃったよ。	状況を説明する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
511	Что за человек.	なんて人かしら。	あきれる		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
512	Не надо оправдываться.	言い訳なんかしなくていいわよ。	義務を否定する		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
513	Ты всё время хочешь спать.	あなたはいつだって眠るのが好きですものね。	理由を述べる		\N	dmod	ru20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
514	Мария Яковлевна, я впервые за компьютером.	マリーヤ・ヤーカヴレヴナ、私はコンピューターが初めてなんです。	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
515	Скажите, как им пользоваться.	どうやって使うか教えてください。	指示する		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
516	Я хотел бы послать электронное письмо другу за рубеж.	外国にいる友達に電子メールを送りたいのですが。	希望を述べる		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
518	Сначала вам надо включить компьютер.	最初にコンピューターの電源を入れなければいけません。	手順と順序について述べる		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
519	Нажмите эту кнопку.	このボタンを押してください。	指示する		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
520	Так?	こう？	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
521	Да.	そうです。	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
522	Немного подождите...	しばらく待ってください・・・。	指示する		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
523	А потом дважды щёлкните этот значок.	それから、このアイコンをダブルクリックしてください。	手順と順序について述べる		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
524	Дважды щёлкнуть... (щёлкает значок дважды)	ダブルクリック、と・・・。（アイコンをダブルクリックする）	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
525	Хорошо.	そうです。	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
526	Тогда запускается программа для электронной почты.	そうすると、メールソフトが立ち上がりますから。	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
527	Теперь вы можете послать письмо через Интернет!	これでインターネットを通じて手紙を出すことが出来ますよ！	機能		\N	dmod	ru21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
528	Маша, ты знаешь Нину?	マーシャ、君はニーナと知り合いだっけ？	情報を確認する		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
529	Да, конечно.	ええ、もちろん。	情報を与える		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
530	Ведь мы учимся в одной группе.	同じグループで勉強しているもの。	理由を述べる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
531	А что?	で、何か？	理由を尋ねる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
532	Что-то её давно не видно.	最近彼女を見ないなぁ、と思って。	理由を述べる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
533	Что с ней?	彼女どうしたんだろう？	状況についてたずねる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
534	Сейчас её нет в Москве.	彼女は今モスクワにいないわ。	情報を与える(存在)		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
535	А почему?	どうして？	理由を尋ねる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
536	Она поехала учиться в США.	彼女はアメリカに留学したわ。	理由を述べる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
537	Она вернётся в Москву через десять месяцев.	10ヵ月後にモスクワに帰ってくるわ。	予定を言う		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
538	Ах, вот как.	そうなのか。	納得する		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
539	Она так хорошо говорит по-английски?	彼女はそんなに英語が上手なの？	機情報を求める(程度)		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
540	А ты не знаешь?	知らないの？	情報を確認する		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
541	Она очень хорошо говорит по-английски.	とても上手に英語を話すわ。	情報を与える(程度)		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
542	Потому что её мама - американка.	なぜなら彼女のお母さまはアメリカ人なんですもの。	理由を述べる		\N	dmod	ru22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
543	Что ты будешь делать завтра?	明日は何するつもり？	機能		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
544	Пойду в кино.	映画に行くわ。	予定を言う		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
545	Но завтра испортится погода, будет дождь, так говорят по радио.	でも、明日は天気が崩れて、雨が降るってラジオで言ってたよ。	機能		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
546	Правда?	本当？	機能		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
547	Если пойдёт дождь, не пойду.	もし雨が降るんなら行かないわ。	条件をつける		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
548	Буду читать дома.	家で本でも読む。	予定を言う		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
549	А ты что будешь делать?	あなたはどうするの？	機能		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
550	Если не будет дождя, поеду с семьёй на дачу за город.	雨が降らなかったら、家族と郊外のダーチャに行くよ。	ある条件での行動を言う		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
551	Собирать грибы и ягоды.	キノコとベリーを摘むんだ。	機能		\N	dmod	ru23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
552	Иван, ты будешь что-нибудь пить?	イワン、あなた何か飲む？	意向を尋ねる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
553	Вот меню.	はい、メニュー。	何かをあげる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
555	Давай закажем вино.	ワインを頼もうよ。	勧誘する		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
556	Ты любишь белое вино?	君は白ワイン好きかい？	嗜好について述べる(もの)		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
557	Да, люблю, но красное больше люблю.	えぇ、好きだけど、赤ワインの方がもっと好きよ。	比べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
558	Тогда закажем красное.	じゃぁ赤ワインにしよう。	妥協する		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
559	Ты любишь красное вино больше всего?	君は赤ワインが一番好きなのかい？	比べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
560	Да, самый любимый алкогольный напиток.	そうね。一番好きなアルコールだわ。	比べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
561	А ты что любишь?	あなたは何が好き？	好きなものについて述べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
562	Я люблю пиво, вино и водку.	僕が好きなのはビールとワインとウォッカだね。	好きなものについて述べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
563	Из них, особенно водку.	その中では特にウォッカが好きだね。	比べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
564	А теперь выбери, Маша: грузинское вино или французское?	マリーヤ、選びなよ。グルジア産のワインにする、それともフランス産にする？	比べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
565	Давай грузинское.	グルジア産ね。	決断する		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
566	Потому что грузинское - более ароматное.	だってグルジア産の方がより香りがいいもの。	比べる		\N	dmod	ru24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
567	Маша, ты свободна завтра?	マーシャ、明日暇かい？	機能		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
569	Да, свободна.	ええ、暇よ。	機能		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
570	С удовольствием пойду.	喜んで行くわ。	機能		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
571	Но я хочу пойти и в Третьяковку.	でもトレチャコフ美術館にも行きたいんだけど。	希望を述べる		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
572	Во сколько начинается фильм?	映画は何時に始まるの？	情報を求める（時間）		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	1
573	В 6 часов.	６時だよ。	機能		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
574	Тогда не хочешь ли ты пойти в музей сначала?	じゃあ、最初に美術館に行かない？	提案する		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
575	Хорошо.	いいよ。	機能		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
576	Тогда в котором часу мы встретимся?	じゃあ、何時に待ち合わせようか？	情報を求める（時間）		\N	dmod	ru25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
577	Мария, вчера тебя не было на моём занятии, да?	マリーヤ、君は昨日私の授業にいなかったよね？	情報を確認する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
578	Да, извините, Иван Иванович.	はい、申し訳ありません、イワン・イワーナヴィチ。	あやまる		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
579	Почему тебя не было?	なぜ休んだのかね？	理由をたずねる		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
580	Потому что я простудилась.	風邪をひいてしまったからです。	理由を述べる		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
581	У меня была высокая температура.	高熱が出てしまって。	状況を説明する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
582	Было 38.	38度もあったんです。	状況を説明する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
584	А сегодня выздоровела?	で、今日は良くなったのかい？	状況をたずねる		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
585	Простуда прошла?	風邪は治ったのかね？	状況をたずねる		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
586	Да, совсем здорова.	ええ、すっかりよくなりました。	状況を説明する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
587	Вчера я была у врача и приняла лекарство.	昨日医者に行きまして、薬をもらって飲みました。	理由を説明する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
588	Вот как.	そうか。	納得する		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
589	Ну, всего хорошего.	では、さようなら。	挨拶をする		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
590	До встречи.	はい、失礼します。	挨拶をする		\N	dmod	ru26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
591	Можно войти?	よろしいですか？	許可を求める		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
592	Пожалуйста.	どうぞ。	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
593	Вы не заняты?	今お忙しくないですか？	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
594	У меня к вам просьба.	お願いがあるんですが。	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
595	Я написал тезисы моей последней статьи на русском языке.	最新の論文の要旨をロシア語で書いたのですが。	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
596	Я хотел бы, чтобы вы исправили их.	直しを入れていただきたいのです。	依頼する		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	\N
597	С удовольствием.	喜んで。	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
598	Но на этой неделе я занята.	でも今週は忙しいのです。	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
599	Вы не можете принести их в следующую среду?	今度の水曜日に持ってきてもらえませんか？	指示する		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
600	Хорошо?	それでいいですか？	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
601	Хорошо.	結構です。	機能		\N	dmod	ru27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
602	Иван, привет.	あら、イワン。	挨拶をする		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
603	Давно не виделись.	久しぶりね。	挨拶する		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
604	Привет, Маша.	やぁ、マーシャ。	挨拶をする		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
605	Я только что вернулся из поездки.	旅行から帰ってきたばかりなんだ。	状況を説明する		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
606	Куда ты ездил?	どこへ行っていたの？	情報を求める(場所)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
607	В Западную Европу.	西ヨーロッパさ。	情報を与える(場所)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
608	Во Францию и Италию.	フランスとイタリアにね。	情報を与える(場所)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
609	Ну, как?	旅行はどうだった？	情報を求める(状態)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
610	Интересно было?	面白かった？	情報を求める(経験)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
611	Да, очень интересно.	すごくよかったよ。	情報を与える(程度)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
612	Париж особенно понравился.	特にパリが気に入ったよ。	情報を与える(場所)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
613	Я снимал много фотографий.	写真もいっぱい撮っちゃった。	情報を与える(経験)		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
614	Например?	例えば？	例示を求める		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
615	Например, Триумфальную арку, Эйфелеву башню, ...	凱旋門でしょ、エッフェル塔でしょ…。	例をあげる		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
616	Как хорошо!	わぁ、すてき。	感嘆する		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
617	Ты мне покажешь фотографии?	写真見せてもらえる？	依頼する		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
618	Сегодня у меня нет.	いや、今日は持ってない。	拒絶する		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
619	Я покажу в следующий раз.	今度見せるよ。	予定を言う		\N	dmod	ru28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
620	У вас нет шоколадок "Октябрь"?	チョコレートの「アクチャーブリ」はありませんか？	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
622	А "Ребёнок" есть?	じゃあ、「リビョーナク」はありますか？	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
623	Тоже нет.	それもありません。	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
624	А какой шоколад у вас есть?	何がありますか？	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
625	У нас есть "Президент".	「プレジヂェント」があります。	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
626	Это тоже вкусно.	これも美味しいですよ。	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
627	Ну, ладно.	まあいいか。	妥協する		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
628	Это лучше, чем ничего.	何もないよりはましだ。	比べる		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
629	Я это возьму.	これを下さい。	機能		\N	dmod	ru29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
630	Да, пожалуйста.	はい、どうぞ！	指示する		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
631	Здравствуйте, Иван Иванович.	こんにちは、イワン・イワーナヴィチ先生。	挨拶をする		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
632	Можно войти?	入っていいですか？	許可を求める		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
633	А-а, Мария, входи, входи.	やぁ、マリーヤ。どうぞ、どうぞ。	指示する		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
634	Извините, я опоздала.	すみません、遅れてしまって。	あやまる		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
635	Ничего.	気にしないでいいよ。	許す		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
636	Вот книга, которую ты ищешь.	はい、君が探している本だよ。	何かをあげる		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
637	Спасибо большое.	ありがとうございます。	感謝する		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
638	Можно взять на время?	しばらくお借りしてもよろしいですか？	許可を求める		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
639	Да, конечно.	あぁ、もちろん。	承諾する		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
640	Сделай копию, если нужно.	必要に応じてコピーをしなさい。	指示する		\N	dmod	ru30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
641	Иван Иванович, я хотела бы уточнить.	イワン・イワーナヴィチ、確認いたしたいのですが。	希望を述べる		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
642	Нужно принести вам статью до этой субботы?	今週の金曜日までに論文を先生のところに持ってこなければいけないのですか？	しなければならないと言う		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
643	Да.	そうです。	機能		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
644	Но, если вам не нужны мои замечания, то не надо приносить.	しかし、私のコメントが必要なければ、持ってくる必要はないですよ。	ある条件での行動を言う		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
645	Конечно нужны.	もちろん必要です。	機能		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
646	Обязательно принесу в пятницу.	金曜日に必ず持ってきます。	機能		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
647	Тогда принесите после обеда.	では昼食後に持ってきてください。	指示する		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
648	Я буду в кабинете.	研究室にいますから。	機能		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
649	Хорошо?	いいですか？	機能		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
650	Хорошо.	はい。	機能		\N	dmod	ru31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
651	Добрый день, доктор.	先生、こんにちは。	挨拶する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
652	Здравствуйте.	こんにちは。	挨拶する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
653	На что вы жалуетесь?	どうかしましたか？	状況をたずねる		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
654	У меня болит живот.	私はおなかが痛いのです。	状況を説明する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
655	Это плохо.	それはよくないな。	同情する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
656	Я вам дам таблетки для желудка.	胃の錠剤をあげましょう。	人にものをあげる		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
657	Спасибо.	ありがとうございます。	感謝する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
658	Сегодня вам нельзя есть ничего острого.	今日は刺激の強いものを食べちゃダメだよ。	禁止する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
659	Понятно.	わかりました。	承諾する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
660	И ещё нельзя есть холодного.	それから冷たいものも食べちゃだめだよ。	禁止する		\N	dmod	ru32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
661	Иван, что ты делаешь?	イワン、何してるの？	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
662	Мне надо написать статью до завтра.	明日までに論文を書き上げないといけないんだ。	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
663	У меня времени очень мало.	時間が全然ない。	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
664	Ты не думаешь, что в этой комнате очень душно?	この部屋蒸し暑いと思わない？	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
665	Открой окно.	窓を開けて。	指示する		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
666	Хорошо.  (Иван открывает окно.)	いいよ。（イワンは窓を開ける）	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
667	Спасибо.	ありがとう。	感謝する		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
668	Дай мне словарь, пожалуйста.	辞書を貸してくれないかしら。	指示する		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
669	Вот.  (Иван передаёт Марии свой словарь.)	はい。（イワンはマリーヤに自分の辞書を手渡す）	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
670	Спасибо.	ありがとう。	感謝する		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
671	Посмотри...	ねえ見て・・・	指示する		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
672	...Маша, очень прошу, не мешай мне, пожалуйста!	マーシャ、お願いだから邪魔しないでくれないか。	機能		\N	dmod	ru33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
673	Попробуй этот шоколад.	このチョコレート、食べて。	何かをあげる		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
674	Не стесняйся.	遠慮しないで。	しないでくれと言う		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
675	Спасибо.	ありがとう。	感謝する		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
676	М-м, очень вкусно.	うーん、とてもおいしいよ。	意見を言う		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
677	Так, что делать завтра?	さて、明日はどうする？	予定をたずねる		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
678	Мне хочется посмотреть новый фильм.	私は新しい映画が見たいわ。	嗜好について述べる(行動)		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
679	Хорошо, давай.	いいよ、そうしよう。	承諾する		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
680	В котором часу мы встретимся?	何時に待ち合わせにする？	情報を求める(時間)		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
681	Дома я посмотрю в Интернете, когда начинается фильм.	家でインターネットを見て何時に映画が始まるかを見てみるわ。	予定を言う		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
682	Понятно.	わかった。	承諾する		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
683	Тогда я позвоню вечером.	じゃぁ晩に電話するよ。	予定を言う		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
684	Ладно?	いいかい？	承諾を求める		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
686	Моя мама сейчас больна, и, может быть, она будет спать.	お母さんが今病気で、寝ているかもしれないから。	状況を説明する		\N	dmod	ru34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
687	Маша, нам нужно сдать свои статьи Ивану Ивановичу до этой среды?	マーシャ、今週の火曜日までにイワン・イワーナヴィチに論文を提出しなくちゃいけないの？			\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
688	Нет, не надо сдавать ему.	いいえ、その必要はないわよ。	しなくともよいと言う		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
689	Почему не надо?	なんで必要ないの？	機能		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
816	У меня болит голова.	私は頭が痛い。	\N		\N	vmod	\N	\N	\N	0	1
690	Я слышал, что на прошлой неделе он так сказал.	先週イワン・イワーナヴィチがそう言ったって聞いたよ。	機能		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
691	Видно, обстоятельства изменились.	事情が変わったらしいわ。	機能		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
692	Он сказал, что слишком занят на этой неделе, ему некогда читать.	今週は余りに忙しいから、読む時間がないってイワン・イワーナヴィチが言っていたわ。	機能		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
693	Поэтому он решил не заставлять нас сдавать статьи.	だから私たちに論文を提出させないことにしたのよ。	理由を述べる		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
694	Вот как!	そうだったのか！	機能		\N	dmod	ru35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
695	Алло.	もしもし。	電話に答える		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
696	Аллё, это говорит Мария.	もしもし、マリーヤです。	電話で名乗る		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
697	Можно попросить Ивана?	イワンをお願いします。	希望を述べる		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
698	Да, это я.	僕だよ。	電話で名乗る		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
699	Здравствуй, Маша.	こんにちは、マリヤ。	挨拶をする		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
700	Здравствуй.	こんにちは	挨拶をする		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
701	Я хотела бы пригласить тебя в гости.	あなたをお客さんとして招待したいのだけれど。	招待する		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
702	У моей сестры, Тани, будет день рождения.	私の妹のターニャが誕生日なのよ。	理由を述べる		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
703	Правда?	本当？	情報を確認する		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
704	Когда её день рождения?	いつが彼女の誕生日なの？	情報を求める(時間)		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
705	В следующее воскресенье.	今度の日曜よ。	情報を与える(時間)		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
706	У тебя есть планы?	何か予定がある？	予定をたずねる		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
707	Нет, я буду свободен.	いや、暇だよ。	予定を言う		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
708	Тогда приходи.	じゃぁ、いらしてよ。	招待する		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
709	В шесть часов.	６時にね。	情報を与える(時間)		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
710	Хорошо.	わかった。	承諾する		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
711	Я приду, с удовольствием.	喜んで行くよ。	承諾する		\N	dmod	ru36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
712	Мария Яковлевна, я хотел бы лучше говорить по-русски.	マリーヤ・ヤーカヴレヴナ、もっと上手にロシア語を話せるようになりたいのですが。	希望を述べる		\N	dmod	ru37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
713	Я знаю очень мало слов.	知っている語彙が少ないんです。	機能		\N	dmod	ru37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
714	Что мне делать?	どうすればいいでしょうか？	機能		\N	dmod	ru37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
715	Хорошо было бы больше читать по-русски.	もっとたくさん読むのがいいと思いますが。	助言する		\N	dmod	ru37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
716	Какие книги, например?	例えば、どんな本を？	機能		\N	dmod	ru37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
717	Я советую вам читать книги по русской культуре, истории, литературе.	ロシア文化、ロシアの歴史、ロシア文学に関する本を読むことをお勧めします。	助言する		\N	dmod	ru37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
718	Привет, Иван.	イワン、ねぇ。	挨拶をする		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
719	Маша, привет.	マーシャ、やぁ。	挨拶をする		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
720	Ты был на уроке английского языка?	あなた英語の授業に出席した？	情報を求める(存在と場所)		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
721	Да, был.	ああ、出席したよ。	情報を与える(存在と場所)		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
722	А что?	それが何か？	理由をたずねる		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
723	Мне хочется, чтобы ты показал мне твою тетрадь.	あなたのノートを私に見せてほしいんだけど。	要求する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
724	Ой, опять?	え、また？	情報を確認する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
725	Ты опять заснула?	また寝ちゃったの？	情報を確認する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
726	Это в пятый раз я показываю тебе тетрадь.	君にノート見せるのこれが５回目だよ。	情報を与える(回数)		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
727	Извини.	ごめんなさい。	あやまる		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
728	Не сердись.	怒らないで。	非行為を依頼する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
729	Я очень тебе благодарна.	あなたにはとても感謝しているのよ。	感謝する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
730	Да, ладно.	全く、しょうがないなぁ。	妥協する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
731	Я просто хочу, чтобы ты лучше училась.	君にはもっとちゃんと勉強してもらいたいよ。	要求する		\N	dmod	ru38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
732	Добро пожаловать в Россию!	ロシアへようこそ！	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
733	Как долетели?	道中いかがでしたか？	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
734	Спасибо, отлично.	ありがとう、快適でした。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
735	Но я должен сказать, что я немного устал.	しかし、やはりちょっと疲れましたね。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
736	Сегодня вечером отдохните в гостинице.	今晩はホテルで休息をお取りになってください。	指示する		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
737	Надо выспаться.	よく眠った方がいいですよ。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
738	О, я вспомнила.	ああ、思い出した。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
739	Я хотела бы спросить у вас заранее.	あらかじめお聞きしておきたいのですが。	希望を述べる		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	\N
740	Какие города вы хотите посетить кроме Москвы?	モスクワ以外にどんな都市に行きたいですか？	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[5]	\N	\N	\N
741	Я хочу посмотреть Казань.	カザンを見たいです。	希望を述べる		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
743	А ещё?	他にはありますか？	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
744	Санкт-Петербург.	サンクト・ペテルブルクです。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
745	Я ещё не был там.	まだ行ったことが無いので。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
746	Это мой родной город.	サンクト・ペテルブルクは私の生まれた町です。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
747	Там живут мои родители.	両親が住んでるんですよ。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
748	Кстати, вам не хочется есть?	ところで、お腹は空いていませんか？			\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
749	Уже пора ужинать.	もう夕食の時間ですが。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	1
750	Да, на самом деле, я очень хочу есть.	ええ、実を言うと、とてもお腹が空いています。	希望を述べる		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
751	Тогда давайте пойдём в гостиницу.	それならホテルに行きましょう。	提案する		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
752	В вашей гостинице есть хороший ресторан.	あなたが泊まるホテルには良いレストランがありますから。	機能		\N	dmod	ru39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
753	Здравствуйте, дорогие друзья.	こんにちは、みなさん。	挨拶をする		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
754	Разрешите представить вам новую студентку.	新しい女子学生をご紹介します。	人を紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
755	Это Мария Сидорова.	こちらはマリーヤ・シーダラヴァさんです。	人を紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
756	Пожалуйста.	では、どうぞ。	動作を促す		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[4]	\N	\N	\N
757	Разрешите представиться.	自己紹介させていただきます。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
758	Меня зовут Мария.	私はマリーヤといいます。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
759	Пожалуйста, просто Маша.	マーシャと呼んでください。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
760	Я из Петербурга.	ペテルブルク出身です。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	\N
761	Я приехала в Москву пять дней назад.	モスクワには５日前に来ました。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[5]	\N	\N	\N
762	Я сейчас живу у моей бабушки.	今、祖母の家に住んでいます。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[6]	\N	\N	1
763	На каком факультете вы учитесь?	学部はどちらですか？	情報を求める(属性)		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
764	Я учусь на филологическом факультете.	文学部で勉強しています。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
765	На отделении славянских языков.	スラヴ諸語学科です。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
766	На каком курсе?	何年生ですか？	情報を求める(属性)		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
767	На третьем курсе.	３年生です。	自己紹介する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
768	Так спасибо.	ありがとうございました。	感謝する		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
769	Дорогие друзья, у вас есть вопросы?	さて皆さん、質問はありますか？	質問を募る		\N	dmod	ru40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
771	Мой друг родился девятнадцатого августа.	私の友人は8月19日に生まれた。	\N		\N	vmod	\N	\N	\N	0	1
772	Ушёл последний автобус.	最終バスが行ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
773	Обычно я пишу авторучкой.	私はふだん万年筆で書きます。	\N		\N	vmod	\N	\N	\N	0	1
774	Он умер от отравления алкоголем.	彼はアルコール中毒で死んだ。	\N		\N	vmod	\N	\N	\N	0	1
775	В апреле все любуются сакурой.	4月にはみんなお花見をする。	\N		\N	vmod	\N	\N	\N	0	1
776	Я сдал багаж в камеру хранения.	私は手荷物を預かり所に預けた。	\N		\N	vmod	\N	\N	\N	0	1
777	Мама открыла счёт в банке.	母は銀行に口座を開いた。	\N		\N	vmod	\N	\N	\N	0	1
778	Дети бегают во дворе .	子供たちは中庭を駆け回っている。	\N		\N	vmod	\N	\N	\N	0	1
779	Самый близкий для меня человек – это мама.	私にとって最も近しい人は母だ。	\N		\N	vmod	\N	\N	\N	0	1
780	-Отсюда недалеко?\n-Нет, совсем близко. Станция находится недалеко от университета.	「ここから遠くないですか？」\n「ええ、本当に近いですよ。駅は大学の近くにあります。」	\N		\N	vmod	\N	\N	\N	0	1
781	Моё любимое блюдо - борщ.	私の好物はボルシチだ。	\N		\N	vmod	\N	\N	\N	0	1
782	У него всегда бодрый вид.	彼はいつも元気はつらつだ。	\N		\N	vmod	\N	\N	\N	0	1
783	Она поправилась после тяжёлой болезни.	彼女は重病から回復した。	\N		\N	vmod	\N	\N	\N	0	1
784	Мой сын лежит в больнице.	私の息子は入院している。	\N		\N	vmod	\N	\N	\N	0	1
785	В её комнате большое зеркало.	彼女の部屋には大きな鏡がある。	\N		\N	vmod	\N	\N	\N	0	1
786	Я часто беру книги в библиотеке.	私はよく図書館で本を借ります。	\N		\N	vmod	\N	\N	\N	0	1
787	Брюки ему велики.	そのズボンは彼には大きい。	\N		\N	vmod	\N	\N	\N	0	1
788	Антон купил туалетную бумагу.	アントンはトイレットペーパーを買った。	\N		\N	vmod	\N	\N	\N	0	1
789	Внук подарил дедушке кожаный бумажник.	孫は祖父に皮製の財布（札入れ）を贈った。	\N		\N	vmod	\N	\N	\N	0	1
790	Быстрый поток нёс его к водопаду.	急流は彼を滝のほうへと流していった。	\N		\N	vmod	\N	\N	\N	0	1
791	Мой старший брат работает в Токио.	私の兄は東京で働いています。	\N		\N	vmod	\N	\N	\N	0	1
792	Где находится ванная?	浴室はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
793	Каждый день я езжу в школу на велосипеде.	私は毎日自転車で学校へ行きます。	\N		\N	vmod	\N	\N	\N	0	1
794	Весёлое было время.	楽しい時間だった。	\N		\N	vmod	\N	\N	\N	0	1
795	Её весёлый смех слышен даже на улице.	彼女のにぎやかな笑い声は通りにまで響いている。	\N		\N	vmod	\N	\N	\N	0	1
796	Наступила весна, и снег растаял.	春が来て雪が溶けた。	\N		\N	vmod	\N	\N	\N	0	1
797	Я весь день думаю о вас.	一日中あなたのことを考えています。	\N		\N	vmod	\N	\N	\N	0	1
798	Ветер дует с моря.	海から風が吹いている。	\N		\N	vmod	\N	\N	\N	0	1
799	Меня пригласили на новогодний вечер.	私は新年パーティーに招待された。	\N		\N	vmod	\N	\N	\N	0	1
800	Она вешает пальто на вешалку.	彼女はハンガーにコートをかけている。	\N		\N	vmod	\N	\N	\N	0	1
801	Взрослые тоже иногда плачут.	大人も時には泣くこともある。	\N		\N	vmod	\N	\N	\N	0	1
802	Я ем салат вилкой.	私はサラダをフォークで食べる。	\N		\N	vmod	\N	\N	\N	0	1
803	Эти ворота открываются в девять часов утра.	この門は朝9時に開かれる。	\N		\N	vmod	\N	\N	\N	0	1
804	Солнце встаёт на востоке.	太陽は東から昇る。	\N		\N	vmod	\N	\N	\N	0	1
805	Полотенце впитывает пот.	タオルは汗を吸う。	\N		\N	vmod	\N	\N	\N	0	1
806	Он　медленно встал из-за стола и пошёл к двери.	彼はおもむろにテーブルを立つとドアのほうに向かって歩き出した。	\N		\N	vmod	\N	\N	\N	0	1
807	Вчера в театре Марина встретила профессора Иванова.	昨日マリーナは劇場でイワノフ教授に会った。	\N		\N	vmod	\N	\N	\N	0	1
808	По вторникам мы ходим в театр.	毎週火曜日に私達は劇場へ行きます。	\N		\N	vmod	\N	\N	\N	0	1
809	Давай встретимся у входа в кинотеатр.	映画館の入り口で会おうよ。	\N		\N	vmod	\N	\N	\N	0	1
810	Вчера вечером мы с мужем посмотрели фильм.	夕べ私と夫は映画を見ました。	\N		\N	vmod	\N	\N	\N	0	1
811	Высота этой горы две тысячи метров над уровнем моря.	この山の高さは海抜2000メートルです。	\N		\N	vmod	\N	\N	\N	0	1
812	Он мне позвонил, когда я выходила из дома.	私が出かけようとした時、彼は私に電話をくれた。	\N		\N	vmod	\N	\N	\N	0	1
813	Моя девушка подарила мне этот галстук.	僕の彼女は僕にこのネクタイをくれた。	\N		\N	vmod	\N	\N	\N	0	1
814	Гриша очень хорошо играет на гитаре.	グリーシャはギターがとても上手だ。	\N		\N	vmod	\N	\N	\N	0	1
815	Я люблю щи с говядиной.	私は牛肉入りのスープが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
818	Отдел головных уборов находится на третьем этаже.	帽子売り場は３階にあります。	\N		\N	vmod	\N	\N	\N	0	1
819	Я люблю её нежный голос.	私は彼女の優しい声が大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
820	Термометр показывает двадцать шесть градусов тепла.	温度計は＋２６度を示している。	\N		\N	vmod	\N	\N	\N	0	1
821	Дети идут по грязной дороге.	子供たちががぬかるんだ道路を歩いていく。	\N		\N	vmod	\N	\N	\N	0	1
822	Вымойте грязные руки!	汚い手をきれいに洗いなさい！	\N		\N	vmod	\N	\N	\N	0	1
823	Мне часто снится далёкий африканский берег. 	私はよく遠いアフリカの岸の夢を見ます。	\N		\N	vmod	\N	\N	\N	0	1
824	Мама закрыла  дверь.	母がドアを閉めた。	\N		\N	vmod	\N	\N	\N	0	1
825	Дверь открыта.	戸が開いている。	\N		\N	vmod	\N	\N	\N	0	1
826	Девочки любят конфеты.	女の子はお菓子が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
827	Дедушка любит гулять с внучкой.	おじいさんは孫娘とお散歩に行くのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
828	Мой день рождения – двадцать седьмого декабря.	僕の誕生日は12月27日だ。	\N		\N	vmod	\N	\N	\N	0	1
829	Скоро зима, дни становятся короче.	もうじき冬で、昼間が短くなっている。	\N		\N	vmod	\N	\N	\N	0	1
830	У меня нет денег.	私にはお金がない。	\N		\N	vmod	\N	\N	\N	0	1
831	Какой фотоаппарат самый дешёвый?	どのカメラが一番安いですか？	\N		\N	vmod	\N	\N	\N	0	1
832	У неё длинные волосы.	彼女は髪が長い。	\N		\N	vmod	\N	\N	\N	0	1
833	После обеда Максим сделал домашнее задание.	昼食のあと、マクシムは宿題をやった。	\N		\N	vmod	\N	\N	\N	0	1
834	На дороге лежит снег.	道には雪が積もっている。	\N		\N	vmod	\N	\N	\N	0	1
835	Он купил очень дорогую машину.	彼は非常に高価な車を買った。	\N		\N	vmod	\N	\N	\N	0	1
836	Моя сестра принимает душ.	私の姉はシャワーを浴びている。	\N		\N	vmod	\N	\N	\N	0	1
837	У моего дяди длинная борода.	私のおじはあごひげが長い。	\N		\N	vmod	\N	\N	\N	0	1
838	Каждый месяц мы платим за квартиру.	私達は毎月家賃を払います。	\N		\N	vmod	\N	\N	\N	0	1
839	В жаркий день хорошо у моря.	暑い日は海辺がいい。	\N		\N	vmod	\N	\N	\N	0	1
840	Осенью листья становятся жёлтыми.	秋には葉は黄色くなる。	\N		\N	vmod	\N	\N	\N	0	1
841	Женщина, которая сидит у окна,  моя жена.	窓辺に座っている女性は私の妻です。	\N		\N	vmod	\N	\N	\N	0	1
842	В самолёте он читал журнал.	彼は飛行機の中で雑誌を読んでいた。	\N		\N	vmod	\N	\N	\N	0	1
844	Наша страна наконец-то начала торговать с заграницей.	我が国はとうとう外国との貿易を開始した。	\N		\N	vmod	\N	\N	\N	0	1
845	Папа закрыл окно.	父が窓を閉めた。	\N		\N	vmod	\N	\N	\N	0	1
846	Поезда шли на запад.	汽車は西へ向かって走っていった。	\N		\N	vmod	\N	\N	\N	0	1
847	Мой сын рисует зелёным карандашом.	私の息子は緑色の鉛筆で絵を描いている。	\N		\N	vmod	\N	\N	\N	0	1
849	Это движение имеет огромное значение.	この運動は重要な意味を持っている。	\N		\N	vmod	\N	\N	\N	0	1
850	Женя держит зонт.	ジェーニャは傘をさしている。	\N		\N	vmod	\N	\N	\N	0	1
851	После завтрака я чищу зубы.	朝食後私は歯を磨く。	\N		\N	vmod	\N	\N	\N	0	1
852	Японцы используют китайские иероглифы.	日本人は漢字を使う。	\N		\N	vmod	\N	\N	\N	0	1
853	Дима хорошо играет на гармонике.	ヂーマはアコーディオンを上手に弾く。	\N		\N	vmod	\N	\N	\N	0	1
854	Дети играют во дворе.	子供たちが中庭で遊んでいる。	\N		\N	vmod	\N	\N	\N	0	1
855	Известный актёр вышел на сцену.	有名な役者が舞台に出てきた。	\N		\N	vmod	\N	\N	\N	0	1
856	Я иногда не понимаю его.	私は時々彼が理解できない。	\N		\N	vmod	\N	\N	\N	0	1
857	В июле я поеду в Москву.	私は7月にモスクワへ行く。	\N		\N	vmod	\N	\N	\N	0	1
858	В июне в Японии очень часто идёт дождь.	日本では6月には非常によく雨が降ります。	\N		\N	vmod	\N	\N	\N	0	1
859	Желаю вам больших успехов в учёбе.	あなたの学業の多大な成功をお祈りしております。	\N		\N	vmod	\N	\N	\N	0	1
860	Карри можно попробовать в индийском ресторане.	カレーはインド料理レストランで食べることができます。	\N		\N	vmod	\N	\N	\N	0	1
861	-Вам положить сахар?\n-Нет, не кладите.	「お砂糖は入れますか？」\n「いいえ、入れないで下さい。」	\N		\N	vmod	\N	\N	\N	0	1
862	Каждую неделю мы с женой ходим в кино.	私と妻は毎週映画を見に行きます。	\N		\N	vmod	\N	\N	\N	0	1
863	Каждый год мы ездим в Ялту.	私達は毎年ヤルタへ行きます。	\N		\N	vmod	\N	\N	\N	0	1
864	Во время летних каникул мы с друзьями путешествовали по Японии.	夏休みの間、僕は友人達と日本中を旅しました。	\N		\N	vmod	\N	\N	\N	0	1
865	У вас есть карта Окинавы?	沖縄の地図はありますか？	\N		\N	vmod	\N	\N	\N	0	1
866	Художник рисует картину.	画家が絵を描いている。	\N		\N	vmod	\N	\N	\N	0	1
867	Пойдём в кафе!	喫茶店に行こうよ！	\N		\N	vmod	\N	\N	\N	0	1
868	Я живу в однокомнатной квартире.	私はワンルームマンション（アパート）に住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
869	В этом классе тридцать учеников.	このクラスには30人の生徒がいる。	\N		\N	vmod	\N	\N	\N	0	1
871	Дайте мне, пожалуйста, два конверта.	封筒を二つください。	\N		\N	vmod	\N	\N	\N	0	1
872	Мальчик подарил девочке конфеты.	男の子は女の子にあめをあげた。	\N		\N	vmod	\N	\N	\N	0	1
873	Нельзя бегать по коридору.	廊下を走り回ってはいけません。	\N		\N	vmod	\N	\N	\N	0	1
874	Где коричневый карандаш?	茶色の色鉛筆はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
875	У моего брата короткие волосы.	私の兄は髪が短い。	\N		\N	vmod	\N	\N	\N	0	1
876	Какая из этих книг тебе больше всего нравится?	これらの本のうちどの本が一番君は気に入っているの？	\N		\N	vmod	\N	\N	\N	0	1
877	Каждое утро папа пьёт кофе с молоком.	お父さんは毎朝ミルクコーヒーを飲みます。	\N		\N	vmod	\N	\N	\N	0	1
878	Катя лежала на кровати.	カーチャはベッドに横になっていた。	\N		\N	vmod	\N	\N	\N	0	1
879	Взвесте мне, пожалуйста, вот эту курицу.	この鶏肉を量ってください。	\N		\N	vmod	\N	\N	\N	0	1
880	Мама на кухне готовит ужин.	母は台所で夕飯を作っている。	\N		\N	vmod	\N	\N	\N	0	1
881	Летние каникулы продолжаются два месяца.	夏休みは2ヶ月続く。	\N		\N	vmod	\N	\N	\N	0	1
882	Наша фирма занимается оптовой торговлей.	我が社は卸売業を行っています。	\N		\N	vmod	\N	\N	\N	0	1
883	Упражнения по русскому языку лёгкие?	ロシア語の練習問題は易しいですか？	\N		\N	vmod	\N	\N	\N	0	1
884	Этот чемодан очень лёгкий.	このスーツケースは非常に軽い。	\N		\N	vmod	\N	\N	\N	0	1
885	Она поднялась по лестнице на четвёртый этаж.	彼女は階段で4階へ上がった。	\N		\N	vmod	\N	\N	\N	0	1
886	Лето - моё любимое время года.	夏は私の好きな季節だ。	\N		\N	vmod	\N	\N	\N	0	1
887	Чай с лимоном, пожалуйста.	レモンティーをお願いします。	\N		\N	vmod	\N	\N	\N	0	1
888	Поднимитесь на этом лифте на девятый этаж.	このエレベーターで9階に上ってください。	\N		\N	vmod	\N	\N	\N	0	1
889	Я ем суп ложкой.	私はスープをスプーンで食べます。	\N		\N	vmod	\N	\N	\N	0	1
890	Дай мне на день твою магнитолу.	君のラジカセを1日貸してよ。	\N		\N	vmod	\N	\N	\N	0	1
891	Я хочу купить новый магнитофон.	私は新しいテープレコーダーを買いたい。	\N		\N	vmod	\N	\N	\N	0	1
892	Девятое мая - День Победы.	5月9日は戦勝記念日です。	\N		\N	vmod	\N	\N	\N	0	1
893	Маша живёт в маленьком домике.	マーシャは小さな家に住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
894	В этом магазине маленький выбор.	この店は品数が少ない。	\N		\N	vmod	\N	\N	\N	0	1
895	Мальчики играют в футбол на спортивной площадке.	男の子たちは運動場でサッカーをしている。	\N		\N	vmod	\N	\N	\N	0	1
896	Дайте, пожалуйста, три марки по десять рублей.	10ルーブルの切手を3枚ください。	\N		\N	vmod	\N	\N	\N	0	1
897	Восьмое марта - Международный женский день.	3月8日は国際婦人デーです。	\N		\N	vmod	\N	\N	\N	0	1
898	Я мажу хлеб маслом.	私はパンにバターを塗っています。	\N		\N	vmod	\N	\N	\N	0	1
899	Вы умеете водить машину?	あなたは車を運転できますか？	\N		\N	vmod	\N	\N	\N	0	1
900	Моя бабушка говорит медленно.	私の祖母はゆっくり話す。	\N		\N	vmod	\N	\N	\N	0	1
901	Многие из моих друзей уже побывали в Москве.	私の友人のうちの多くはモスクワに行ったことがある。	\N		\N	vmod	\N	\N	\N	0	1
902	На стадионе много народу.	競技場には大勢の人がいる。	\N		\N	vmod	\N	\N	\N	0	1
903	Вскипятите молоко.	牛乳を沸騰させてください。	\N		\N	vmod	\N	\N	\N	0	1
904	Мужчина кормит собаку.	男の人が犬に餌をあげている。	\N		\N	vmod	\N	\N	\N	0	1
905	Я слушаю музыку.	私は音楽を聴いている。	\N		\N	vmod	\N	\N	\N	0	1
906	Сестра моет посуду на кухне.	姉は台所で食器を洗っている。	\N		\N	vmod	\N	\N	\N	0	1
907	Наверное он не придёт сегодня.	多分今日は彼は来ないだろう。	\N		\N	vmod	\N	\N	\N	0	1
908	Папа надевает брюки.	父はズボンをはくところだ。	\N		\N	vmod	\N	\N	\N	0	1
909	Я наклеиваю марку на конверт.	私は封筒に切手を貼っているところです。	\N		\N	vmod	\N	\N	\N	0	1
910	Поверните налево.	左に曲がってください。	\N		\N	vmod	\N	\N	\N	0	1
911	Какой невкусный торт!	なんてまずいケーキだ！	\N		\N	vmod	\N	\N	\N	0	1
912	Какая скучная лекция!	なんてつまらない講義だ！	\N		\N	vmod	\N	\N	\N	0	1
913	Я ненавижу этого человека.	私はその人が嫌いだ。	\N		\N	vmod	\N	\N	\N	0	1
914	Сегодня утром я выстирала всё нижнее бельё. 	私は今朝下着を全部洗濯した。	\N		\N	vmod	\N	\N	\N	0	1
915	У него низкий голос.	彼は声が低い。	\N		\N	vmod	\N	\N	\N	0	1
916	У них длинные ноги.	彼らは足が長い。	\N		\N	vmod	\N	\N	\N	0	1
917	У меня болит левая нога.	私は左足が痛い。	\N		\N	vmod	\N	\N	\N	0	1
918	Разрежьте мясо этим ножом.	お肉をこの包丁で切ってください。	\N		\N	vmod	\N	\N	\N	0	1
919	У дедушки большой нос.	祖父は鼻が大きい。	\N		\N	vmod	\N	\N	\N	0	1
920	Он носит чёрное пальто.	彼は黒いコートを着ている。	\N		\N	vmod	\N	\N	\N	0	1
921	Там продаются носки.	あそこで靴下が売られている。	\N		\N	vmod	\N	\N	\N	0	1
922	Она вытерла слёзы носовым платком.	彼女はハンカチで涙をぬぐった。	\N		\N	vmod	\N	\N	\N	0	1
923	Моя подруга родилась третьего ноября.	私の友達は11月3日に生まれました。	\N		\N	vmod	\N	\N	\N	0	1
924	Эта кожаная обувь мне не подходит.	この革靴は私には似合わない。	\N		\N	vmod	\N	\N	\N	0	1
925	Там продают свежие овощи.	あそこでは新鮮な野菜を売っている。	\N		\N	vmod	\N	\N	\N	0	1
926	Овощной магазин находится рядом с почтой.	八百屋さんは郵便局の隣にあります。	\N		\N	vmod	\N	\N	\N	0	1
927	Мальчик медленно одевается.	男の子はのろのろ身支度を整えています。	\N		\N	vmod	\N	\N	\N	0	1
928	Мне нужна зимняя одежда.	私には冬服が必要だ。	\N		\N	vmod	\N	\N	\N	0	1
929	Я одолжу ему две тысячи рублей.	私は彼に2000ルーブル貸します。	\N		\N	vmod	\N	\N	\N	0	1
930	Моя сестра поедет в Киото четвёртого октября.	私の姉は10月4日に京都へ行く。	\N		\N	vmod	\N	\N	\N	0	1
931	Я опускаю письмо в ящик.	私はポストに手紙を出しています。	\N		\N	vmod	\N	\N	\N	0	1
932	Наступила осень, и листья пожелтели.	秋になり、木の葉は黄色く色づいた。	\N		\N	vmod	\N	\N	\N	0	1
933	Моя младшая сестра очень любит острые блюда.	私の妹は辛い料理が大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
934	Он всегда очень быстро отвечает на вопросы.	彼はいつも即座に質問に答える。	\N		\N	vmod	\N	\N	\N	0	1
935	Он потом отдаст вам ручку.	彼は後であなたにペンを返します。	\N		\N	vmod	\N	\N	\N	0	1
937	Он обычно не носит очки.	彼はふだん眼鏡をしていない。	\N		\N	vmod	\N	\N	\N	0	1
938	В апреле часто бывает пасмурная погода.	四月は曇りの日が多い。	\N		\N	vmod	\N	\N	\N	0	1
939	Небо покрывается облаками.	空は雲で覆われている。	\N		\N	vmod	\N	\N	\N	0	1
940	Весь день они плавали в бассейне.	彼らは一日中プールで泳いでいた。	\N		\N	vmod	\N	\N	\N	0	1
941	Поставьте эту книгу на книжную полку.	この本を本棚に入れてください。	\N		\N	vmod	\N	\N	\N	0	1
942	Наташа хорошо ест палочками.	ナターシャは上手におはしを使います。	\N		\N	vmod	\N	\N	\N	0	1
943	Повесьте пальто на вешалку.	コートをハンガーにかけてください。	\N		\N	vmod	\N	\N	\N	0	1
944	Пепельница на столе.	灰皿は机の上にある。	\N		\N	vmod	\N	\N	\N	0	1
945	Утром я попал в пробку на перекрёстке.	朝、私は交差点のところで渋滞につかまった。	\N		\N	vmod	\N	\N	\N	0	1
946	Мы поём русские народные песни.	私達はロシア民謡を歌っています。	\N		\N	vmod	\N	\N	\N	0	1
947	Тот певец очень хорошо поёт.	その歌手はとても上手に歌う。	\N		\N	vmod	\N	\N	\N	0	1
948	Затопите печь.	ストーブを焚いてください。	\N		\N	vmod	\N	\N	\N	0	1
949	Где продаются пиджаки?	上着はどこで売っていますか？	\N		\N	vmod	\N	\N	\N	0	1
950	Мама сшила мне этот пиджак.	母が私にこの背広を仕立ててくれた。	\N		\N	vmod	\N	\N	\N	0	1
951	Письменный стол в кабинете.	机は書斎にあります。	\N		\N	vmod	\N	\N	\N	0	1
952	Больному трудно глотать пищу.	病人は食べ物を飲み込むのがつらい。	\N		\N	vmod	\N	\N	\N	0	1
953	Вы умеете плавать?	あなたは泳げますか？	\N		\N	vmod	\N	\N	\N	0	1
954	Мама любит слушать пластинки.	母はレコードを聞くのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
955	Проявите плёнку, пожалуйста.	フィルムを現像してください。	\N		\N	vmod	\N	\N	\N	0	1
956	Я ещё плохо говорю по-русски.	私はまだロシア語を話すのが下手です。	\N		\N	vmod	\N	\N	\N	0	1
957	Он плохой человек.	彼は悪い人です。	\N		\N	vmod	\N	\N	\N	0	1
958	Машина поворачивает за угол.	車が角を曲がっている。	\N		\N	vmod	\N	\N	\N	0	1
959	Позавчера мы вернулись из Турции.	おととい私達はトルコから帰ってきました。	\N		\N	vmod	\N	\N	\N	0	1
960	В позапрошлом году я училась на втором курсе.	おととし私は2年生でした。	\N		\N	vmod	\N	\N	\N	0	1
961	Я люблю лес поздней осенью.	私は晩秋の森が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
962	Сегодня очень холодно.Надо надеть шапку.	今日はとても寒いので、帽子をかぶらなければならない。	\N		\N	vmod	\N	\N	\N	0	1
963	Пойдём за покупками！	買い物に行こうよ！	\N		\N	vmod	\N	\N	\N	0	1
964	Полицейская будка находится недалеко от нашего дома.	交番は私達の家の近くにある。	\N		\N	vmod	\N	\N	\N	0	1
965	Полицейский идёт по улице.	おまわりさんが通りを歩いている。	\N		\N	vmod	\N	\N	\N	0	1
966	Мой папа служит полицейским.	私の父は警官だ。	\N		\N	vmod	\N	\N	\N	0	1
967	В понедельник у меня будет экзамен по русскому языку.	月曜日に私はロシア語の試験がある。	\N		\N	vmod	\N	\N	\N	0	1
968	Послезавтра моя подруга приедет в Японию.	あさってわたしの友達が日本にやってくる。	\N		\N	vmod	\N	\N	\N	0	1
969	Посольство Российской Федерации находится в Токио.	ロシア連邦大使館は東京にある。	\N		\N	vmod	\N	\N	\N	0	1
970	Я сама подстригаю себе волосы.	私は自分で髪を切っている。	\N		\N	vmod	\N	\N	\N	0	1
971	Мне надо сходить на почту.	私は郵便局に行ってこなくてはならない。	\N		\N	vmod	\N	\N	\N	0	1
972	Молодой человек опустил письмо в почтовый ящик.	若者は手紙をポストに投函した。	\N		\N	vmod	\N	\N	\N	0	1
973	Составьте какое-нибудь предложение.	何か文章を作ってください。	\N		\N	vmod	\N	\N	\N	0	1
975	Не надо ничего прибавлять, юбка и так длинная.	何も付け足す必要はないよ、スカートはそのままでも十分長いじゃない。	\N		\N	vmod	\N	\N	\N	0	1
976	Оксана приедет вовремя.	オクサーナは時間通りに到着します。	\N		\N	vmod	\N	\N	\N	0	1
977	Папа подсоединяет антенну к телевизору.	父はテレビにアンテナをつなげています。	\N		\N	vmod	\N	\N	\N	0	1
978	Прими ванну!	お風呂に入りなさい！	\N		\N	vmod	\N	\N	\N	0	1
979	Прихожая находится на первом этаже.	玄関は一階にある。	\N		\N	vmod	\N	\N	\N	0	1
980	Завтра на уроке математики будет проверочная работа.	明日数学の授業でテストがある。	\N		\N	vmod	\N	\N	\N	0	1
981	Чудесная была прогулка!	お散歩はすばらしかったなぁ！	\N		\N	vmod	\N	\N	\N	0	1
982	Здесь продают мужские костюмы.	ここでは紳士服を売っています。	\N		\N	vmod	\N	\N	\N	0	1
983	Завтра будет прохладный день.	明日は涼しい（肌寒い）日になるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
984	В прошлом году я путешествовала по России.	去年私はロシアを旅行した。	\N		\N	vmod	\N	\N	\N	0	1
985	Завтра небо прояснится.	明日は晴れるだろう。	\N		\N	vmod	\N	\N	\N	0	1
986	Я люблю путешествовать.	私は旅行が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
987	Давайте закончим этот разговор.	この話は終わりにしましょう。	\N		\N	vmod	\N	\N	\N	0	1
988	Перед сном бабушка всегда рассказывает мне сказку.	いつも私が眠る前におばあちゃんはおとぎばなしを聞かせてくれる。	\N		\N	vmod	\N	\N	\N	0	1
989	Река течёт быстро.	川が勢いよく流れている。	\N		\N	vmod	\N	\N	\N	0	1
990	Мы обычно едим на завтрак варёный рис и «мисо»-суп (суп из соевой пасты).	私達はふだん朝ごはんにご飯とお味噌汁を食べます。	\N		\N	vmod	\N	\N	\N	0	1
991	Он держит косточку во рту.	彼は口に骨をくわえている。	\N		\N	vmod	\N	\N	\N	0	1
992	Погладьте рубашку.	ワイシャツにアイロンをかけてください。	\N		\N	vmod	\N	\N	\N	0	1
993	Антон скрестил руки на груди.	アントンは腕組みをした。	\N		\N	vmod	\N	\N	\N	0	1
994	Студенты пожали друг другу руки.	学生達はお互いに握手をかわした。	\N		\N	vmod	\N	\N	\N	0	1
995	На этой фабрике выпускают шариковые ручки.	この工場ではボールペンを生産しています。	\N		\N	vmod	\N	\N	\N	0	1
996	Рядом с книжным магазином находится универсам.	本屋さんの隣にスーパーがあります。	\N		\N	vmod	\N	\N	\N	0	1
997	Рядом со столом стоит шкаф.	机の横に棚がある。	\N		\N	vmod	\N	\N	\N	0	1
998	На следующей неделе будет ясная погода.	来週はお天気になるでしょう。	\N		\N	vmod	\N	\N	\N	0	1
1000	Сегодня я буду обедать с иностранным студентом.	今日私は留学生と昼食をとる予定です。	\N		\N	vmod	\N	\N	\N	0	1
1001	Садитесь, пожалуйста.	どうぞおかけください。	\N		\N	vmod	\N	\N	\N	0	1
1003	Эта комната светлая.	この部屋は明るい。	\N		\N	vmod	\N	\N	\N	0	1
1004			\N		\N	vmod	\N	\N	\N	0	1
1005	Вам кофе с сахаром?	コーヒーにお砂糖は入れますか？	\N		\N	vmod	\N	\N	\N	0	1
1006	Я приготовил котлеты из свинины.	僕はとんかつを作った。	\N		\N	vmod	\N	\N	\N	0	1
1007	Степан купил новый свитер.	ステパンは新しいセーターを買った。	\N		\N	vmod	\N	\N	\N	0	1
1008	Эта птица живёт на севере нашей страны.	この鳥は私たちの国の北に棲息している。	\N		\N	vmod	\N	\N	\N	0	1
1009			\N		\N	vmod	\N	\N	\N	0	1
1010	В Токио в сентябре ещё жарко.	東京では9月はまだ暑い。	\N		\N	vmod	\N	\N	\N	0	1
1011	У меня две сестры - старшая и младшая.	私には二人の姉妹がいる、姉と妹だ。	\N		\N	vmod	\N	\N	\N	0	1
1012	Я сжимаю ручку в руке.	私は手の中にペンを握り締めている。	\N		\N	vmod	\N	\N	\N	0	1
1013	У дяди сильные руки.	おじは腕が強い。	\N		\N	vmod	\N	\N	\N	0	1
1014	У Коли слабое сердце.	コーリャは心臓が弱い。	\N		\N	vmod	\N	\N	\N	0	1
1015	Слишком сладкое пирожное.	甘すぎるケーキ。	\N		\N	vmod	\N	\N	\N	0	1
1016	Все девочки любят сладости.	女の子はみんな甘いものが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1017	На следующей неделе мама вышлет мне посылку.	来週母が私に小包を送ってくれる。	\N		\N	vmod	\N	\N	\N	0	1
1018	В следующем году я выхожу замуж.	来年私は結婚します。	\N		\N	vmod	\N	\N	\N	0	1
1019	В следующем месяце мой друг вернётся из Санкт-Петербурга.	来月私の友人がサンクトペテルブルグから帰ってくる。	\N		\N	vmod	\N	\N	\N	0	1
1020	Спрашивайте, не стесняйтесь!	質問してください、ご遠慮なさらずに！	\N		\N	vmod	\N	\N	\N	0	1
1021	Миша снимает носки.	ミーシャが靴下を脱いでいる。	\N		\N	vmod	\N	\N	\N	0	1
1022	Добавьте соевый соус.	しょうゆを加えてください。	\N		\N	vmod	\N	\N	\N	0	1
1023	Передай мне соль, пожалуйста.	塩をとってください。	\N		\N	vmod	\N	\N	\N	0	1
1024	Домашнее задание - сочинение на тему «Музыка в моей жизни». 	宿題は『私の人生における音楽』という題の作文だ。	\N		\N	vmod	\N	\N	\N	0	1
1025	Он пришёл сразу после звонка.	電話の後彼はすぐにやってきた。	\N		\N	vmod	\N	\N	\N	0	1
1026	Моей старшей сестре тридцать лет.	私の姉は30歳だ。	\N		\N	vmod	\N	\N	\N	0	1
1027			\N		\N	vmod	\N	\N	\N	0	1
1028			\N		\N	vmod	\N	\N	\N	0	1
1029	Дайте мне стакан воды.	水を一杯ください。	\N		\N	vmod	\N	\N	\N	0	1
1030	Следующая станция - "Менделеевская".	次の駅は『メンデレーエフスカヤ』です。	\N		\N	vmod	\N	\N	\N	0	1
1031	Что сталось с ним потом?	そのあと彼はどうなってしまったの？	\N		\N	vmod	\N	\N	\N	0	1
1032	Папа стирает.	父が洗濯している。	\N		\N	vmod	\N	\N	\N	0	1
1033	Брось платье в стирку.	服を洗濯に出しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1034	В столовой пусто.	食堂はからっぽだ。	\N		\N	vmod	\N	\N	\N	0	1
1035	Врач сел на стул.	お医者さんは椅子に座った。	\N		\N	vmod	\N	\N	\N	0	1
1036	Давай встретимся в субботу.	土曜日に会おう。	\N		\N	vmod	\N	\N	\N	0	1
1037	Я положила мобильник в сумку.	私は携帯電話をバッグに入れた。	\N		\N	vmod	\N	\N	\N	0	1
1038	Супруги Петровы приехали к нам в гости.	ペトロフ夫妻がうちへお客に来た。	\N		\N	vmod	\N	\N	\N	0	1
1039	Каждое утро я выхожу на станции "Тама".	私は毎朝多磨駅で降りる。	\N		\N	vmod	\N	\N	\N	0	1
1040	Я очень люблю сыр.	私はチーズが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1041	Вымойте чашки, пожалуйста.	カップを洗ってください。	\N		\N	vmod	\N	\N	\N	0	1
1042	Дайте, пожалуйста, пачку сигарет.	たばこを一箱ください。	\N		\N	vmod	\N	\N	\N	0	1
1043	Такие книги нам нужны.	こんな本が私たちには必要なのだ。	\N		\N	vmod	\N	\N	\N	0	1
1044	Люди так говорят.	人々はそう言っている。	\N		\N	vmod	\N	\N	\N	0	1
1045	Тётя разбила тарелку.	おばはお皿を割ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
1046	В здоровом теле - здоровый дух. 	健康な体に健康な精神が宿る。	\N		\N	vmod	\N	\N	\N	0	1
1047	Мальчик спит в тёмной комнате.	少年は暗い部屋で眠っている。	\N		\N	vmod	\N	\N	\N	0	1
1048	Мне нравится тёмный цвет.	私は暗い色が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1049	Молоко тёплое?	牛乳は温かいですか？	\N		\N	vmod	\N	\N	\N	0	1
1050	У тёти две дочери.	おばには娘が二人いる。	\N		\N	vmod	\N	\N	\N	0	1
1051	Мне нравится тихая музыка.	私は静かな音楽が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1052	Кто-то толкает меня в спину.	誰かが私の背中を押している。	\N		\N	vmod	\N	\N	\N	0	1
1053	Эта книга толстая.	この本は分厚い。	\N		\N	vmod	\N	\N	\N	0	1
1054	Тот мужчина толстый.	その男性は太っている。	\N		\N	vmod	\N	\N	\N	0	1
1055	Сочинения Пушкина в трёх томах.	プーシキン全集は全三巻です。	\N		\N	vmod	\N	\N	\N	0	1
1056	У неё тонкие пальцы.	彼女は指が細い。	\N		\N	vmod	\N	\N	\N	0	1
1057	Тонкий лёд покрывает озеро.	薄い氷が湖を覆っている。	\N		\N	vmod	\N	\N	\N	0	1
1059	Родион приехал ровно в три часа.	ロヂオンは3時ちょうどにやってきた。	\N		\N	vmod	\N	\N	\N	0	1
1060	Это трудный вопрос.	これは難しい問題だ。	\N		\N	vmod	\N	\N	\N	0	1
1061	Скажите, пожалуйста, где туалет?	すみません、お手洗いはどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1062	Это мужской туалет, а это - женский.	これは紳士用トイレで、これは婦人用トイレです。	\N		\N	vmod	\N	\N	\N	0	1
1064	Мне нельзя поднимать тяжёлые вещи.	私は重い荷物を持ち上げることができない。	\N		\N	vmod	\N	\N	\N	0	1
1065	У ворот стояла красивая девушка.	門のそばに美しい娘が立っていた。	\N		\N	vmod	\N	\N	\N	0	1
1066	По воскресеньям я убираю в комнате.	毎週日曜日に私は部屋の片づけをします。	\N		\N	vmod	\N	\N	\N	0	1
1067	Я попросил сестру сделать уборку в моей комнате.	僕は妹に僕の部屋の掃除をするよう頼んだ。	\N		\N	vmod	\N	\N	\N	0	1
1068	Наша кухня очень удобная.	うちの台所はとても便利です。	\N		\N	vmod	\N	\N	\N	0	1
1069	Сегодня на ужин мы ели гречневую лапшу.	今日は私達は夕飯におそばを食べた。	\N		\N	vmod	\N	\N	\N	0	1
1070	Перед ужином мы пойдём гулять.	晩御飯の前に散歩に行こう。	\N		\N	vmod	\N	\N	\N	0	1
1071	Узкая тропинка ведет к нашему дому.	狭い通りが私たちの家に続いている。	\N		\N	vmod	\N	\N	\N	0	1
1072	Она умирает от горя.	彼女は悲しさのあまり死にそうだ。	\N		\N	vmod	\N	\N	\N	0	1
1073	По средам я хожу в универмаг.	毎週水曜日に私はデパートへ行きます。	\N		\N	vmod	\N	\N	\N	0	1
1074	Я сделала все упражнения из учебника.	私は教科書の練習問題を全部やった。	\N		\N	vmod	\N	\N	\N	0	1
1075	Упражняйся каждый день!	毎日練習しなさいよ！	\N		\N	vmod	\N	\N	\N	0	1
1076	У слона большие уши.	ゾウの耳は大きい。	\N		\N	vmod	\N	\N	\N	0	1
1077	Он примерный ученик.	彼は模範生だ。	\N		\N	vmod	\N	\N	\N	0	1
1078	Преподаватель учит студентов произносить новые слова.	先生は学生たちに新出単語の発音を教えている。	\N		\N	vmod	\N	\N	\N	0	1
1079	Двадцать третье февраля - День защитника Отечества.	2月23日は祖国防衛者の日です。	\N		\N	vmod	\N	\N	\N	0	1
1080	Фотограф-любитель обычно снимает недорогим фотоаппаратом.	アマチュアカメラマンはふつう安いカメラで撮影している。	\N		\N	vmod	\N	\N	\N	0	1
1081	Мария изучает французский язык.	マリヤはフランス語を勉強している。	\N		\N	vmod	\N	\N	\N	0	1
1082	На рынке я купила свежие фрукты.	私は市場で新鮮なくだものを買った。	\N		\N	vmod	\N	\N	\N	0	1
1083	Мы ходим по саду.	私達は庭園を歩いている。	\N		\N	vmod	\N	\N	\N	0	1
1084	Положите яйцо в холодильник.	卵を冷蔵庫に入れてください。	\N		\N	vmod	\N	\N	\N	0	1
1085	Холодные дни продолжаются.	寒い日が続いている。	\N		\N	vmod	\N	\N	\N	0	1
1086	Я хочу чай с лимоном, а не с молоком.	ミルクティーではなく、レモンティーが欲しいです。	\N		\N	vmod	\N	\N	\N	0	1
1087	Цвет у неба всегда разный.	空の色はいつも違う。	\N		\N	vmod	\N	\N	\N	0	1
1088	Положите в миску варёный рис.	お茶碗にご飯をよそってください。	\N		\N	vmod	\N	\N	\N	0	1
1089	Моя мама пьёт все сорта чая, кроме зелёного.	私の母は緑茶以外のお茶は何でも飲む。	\N		\N	vmod	\N	\N	\N	0	1
1090	Муж подарил мне наручные часы.	夫が私に腕時計をくれた。	\N		\N	vmod	\N	\N	\N	0	1
1091	Моя мама любит чай.	私の母はお茶が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1092	В четверг мы с папой поедем в зоопарк.	木曜日に私とお父さんは動物園に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1093	Перед нами простирается широкое поле.	私達の前には広大な草原が広がっている。	\N		\N	vmod	\N	\N	\N	0	1
1094	Дома я хожу в тапочках.	私は家ではスリッパをはいている。	\N		\N	vmod	\N	\N	\N	0	1
1095	На каком этаже вы живёте?	何階に住んでいらっしゃるんですか？	\N		\N	vmod	\N	\N	\N	0	1
1096	В этом году я буду учиться в Москве.	今年私はモスクワへ留学する予定です。	\N		\N	vmod	\N	\N	\N	0	1
1097	В этом месяце я не буду есть сладости.	今月私は甘いものを控えるつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
1098	Анна носит красивые юбки.	アンナはきれいなスカートをはいている。	\N		\N	vmod	\N	\N	\N	0	1
1099	Весной с юга прилетают птицы.	春には南から鳥が飛んでくる。	\N		\N	vmod	\N	\N	\N	0	1
1100	Это выражение используется только в разговорном языке.	この表現は話し言葉でのみ使用されます。	\N		\N	vmod	\N	\N	\N	0	1
1102	Копирование более пятидесяти страниц запрещено.	50ページ以上のコピーは禁止されています。	\N		\N	vmod	\N	\N	\N	0	1
1103	В первой половине дня ученики занимаются математикой.	生徒たちは午前中は数学の勉強をする。	\N		\N	vmod	\N	\N	\N	0	1
1104	Во второй половине дня будут соревнования по плаванию.	午後には水泳の競技会がある。	\N		\N	vmod	\N	\N	\N	0	1
1105	Юбилейная марка вышла тиражом два миллиона экземпляров.	記念切手が200万枚発行された。	\N		\N	vmod	\N	\N	\N	0	1
1106	Сколько яиц вам нужно?	卵はいくついりますか？	\N		\N	vmod	\N	\N	\N	0	1
1107	Там есть все виды алкоголя.	あそこにはあらゆる種類のお酒がある。	\N		\N	vmod	\N	\N	\N	0	1
1108	Мой брат изучает русский язык.	私の弟（兄）はロシア語を勉強している。	\N		\N	vmod	\N	\N	\N	0	1
1109	Подарки лежат под ёлкой.	モミの木の下にプレゼントが置いてある。	\N		\N	vmod	\N	\N	\N	0	1
1110	Мне больше нравится йогурт, чем кефир.	私はケフィールよりもヨーグルトの方が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1111	Мама поцеловала сына в щёку.	お母さんは息子のほほにキスをした。	\N		\N	vmod	\N	\N	\N	0	1
1112	Вступительные экзамены в Японии сдают в феврале.	日本では2月に入学試験がある。	\N		\N	vmod	\N	\N	\N	0	1
1113	Моего двоюродного брата зовут Игорь.	私のいとこはイーゴリといいます。	\N		\N	vmod	\N	\N	\N	0	1
1114	Галя будет в Москве на неделю.	ガーリャはモスクワに1週間いる予定だ。	\N		\N	vmod	\N	\N	\N	0	1
1115	Могли бы вы жить вне России?	あなたはロシアを離れて生きられますか。	\N		\N	vmod	\N	\N	\N	0	1
1116	Надо сделать продольный разрез.	縦に切らなくてはいけません。	\N		\N	vmod	\N	\N	\N	0	1
1117	Впереди стоит высокий дуб.	前方に大きなカシの木が立っている。	\N		\N	vmod	\N	\N	\N	0	1
1118	Начерти прямую линию.	まっすぐな線をひいてください。	\N		\N	vmod	\N	\N	\N	0	1
1119	Пётр следует за мной.	ピョートルが私の後についてくる。	\N		\N	vmod	\N	\N	\N	0	1
1120	Японские слова записываются иероглифами, хираганой и катаканой.	日本語は漢字、平仮名、カタカナで書かれます。	\N		\N	vmod	\N	\N	\N	0	1
1121	Катакана - одна из двух японских азбук.	片仮名は二種類の仮名のうちのひとつである。	\N		\N	vmod	\N	\N	\N	0	1
1122	Через два года я окончу университет.	再来年私は大学を卒業します。	\N		\N	vmod	\N	\N	\N	0	1
1123	Читая письмо матери, она улыбалась.\n	母の手紙を読みながら彼女はニコニコしていた.	\N		\N	vmod	\N	\N	\N	0	1
1124	Мы дадим этот магнитофóн на час.	わたしたちは一時間このテープレコーダーを貸しますよ．	\N		\N	vmod	\N	\N	\N	0	1
1125	Где живёт твоя старшая сестра?	君のお姉さんはどこに住んでいるの？	\N		\N	vmod	\N	\N	\N	0	1
1126	Твой старший брат женился будучи студентом?	君のお兄さんは学生結婚だったの？	\N		\N	vmod	\N	\N	\N	0	1
1127	Зачем стираешь с доски? Я ещё переписываю!	なんで黒板消してるの？まだ書き途中なのに！	\N		\N	vmod	\N	\N	\N	0	1
1128	Настя садится на велосипед.	ナースチャは自転車に乗るところだ。	\N		\N	vmod	\N	\N	\N	0	1
1129	Саша носит светлые костюмы.	サーシャは明るい色のスーツを着ている。	\N		\N	vmod	\N	\N	\N	0	1
1136	Он всегда вовремя отдаёт долги.	彼はいつも期日どおりに借金を返す。	\N		\N	vmod	\N	\N	\N	0	1
1137	«Чаван» - это японская чашка для варёного риса.	「茶わん」とは、御飯を入れるための日本の器である。	\N		\N	vmod	\N	\N	\N	0	1
1138	Налейте молоко в миску.	ミルクをうつわに注いでください。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: ru
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	588	（乗り物に乗って）行く（不定動詞・不完了体）\n\n対をなす動詞\n定動詞・不完了体 ： ехать\n完了体 ： поехать\n\n「（歩いて）行く」の場合\n不定動詞・不完了体 ： ходить\n定動詞・不完了体 ： идти\n完了体 ： пойти	1	1
2	589	英語	1	1
3	590	飛行機	1	1
4	591	外国	1	1
5	592	外国人（男性）\n\n女性形 ： иностранка	1	1
6	593	フランス語	1	1
7	594	ホテル	1	1
8	595	日本語	1	1
9	596	（歩いて）出掛ける（不完了体）\n\n対をなす動詞\n完了体 ： выйти\n\n「（乗り物に乗って）出掛ける」の場合\n不完了体 ： выезжать\n完了体 ： выехать	1	1
10	597	国（くに）	1	1
11	598	会う（完了体）\n\n対をなす動詞\n不完了体 ： встречать	1	1
12	599	（学校の長期の）休み、休暇\n\n仕事の休暇の場合 ： отпуск	1	1
13	600	旅行	1	1
14	601	旅行する（不完了体）\n\n対をなす完了体はありません。	1	1
15	602	遊ぶ（不完了体）\n\nこの単語には、「遊ぶ」という意味では、対をなす完了体はありません。	1	1
16	603	大使館	1	1
17	604	大好き、愛する（不完了体）\n\n対をなす動詞\n完了体 ： полюбить	1	1
18	605	好き（不完了体）\n\n対をなす動詞\n完了体 ： понравиться	1	1
19	606	上手（じょうず）	1	1
20	607	走る（不定動詞・不完了体）\n\n対をなす動詞\n定動詞・不完了体 ： бежать\n完了体 ： побежать	1	1
21	608	ゆっくり	1	1
22	609	下手（へた）	1	1
23	610	歩く、（歩いて）行く（不定動詞・不完了体）\n\n対をなす動詞\n定動詞・不完了体 ： идти\n完了体 ： пойти	1	1
24	611	泳ぐ（不定動詞・不完了体）\n\n対をなす動詞\n定動詞・不完了体 ： плыть\n完了体 ： поплыть	1	1
25	612	速い［スピードが～］	1	1
26	613	飛ぶ（不定動詞・不完了体）\n\n対をなす動詞\n定動詞・不完了体 ： лететь\n完了体 ： полететь	1	1
27	614	スポーツ	1	1
28	615	嫌い（不完了体）\n\n対をなす完了体はありません。	1	1
29	616	プール	1	1
30	617	バス	1	1
31	618	自転車	1	1
32	619	交差点	1	1
33	620	道（みち）	1	1
34	621	池	1	1
35	622	散歩	1	1
36	623	かわ（川・河）	1	1
37	624	タクシー	1	1
38	625	自動車，車（くるま）	1	1
39	626	曲がる（不完了体）\n\n対をなす動詞\n完了体 ： поворотить	1	1
40	627	ネクタイ	1	1
41	628	ワイシャツ	1	1
42	629	会社	1	1
43	630	背広	1	1
44	631	やる（不完了体）\n\n対をなす動詞\n完了体 ： сделать	1	1
45	632	（湿気・熱などを）吸う、吸収する（不完了体）\n\n対をなす動詞\n完了体 ： впитать	1	1
46	633	電話	1	1
47	634	仕事	1	1
48	635	働く・勤める（不完了体）\n\n対をなす完了体はありません。	1	1
49	636	忙しい\nこの単語は短語尾形(занят, занята, занято, заняты)で使用されることが多い。	1	1
50	637	図書館	1	1
51	638	辞書，字引	1	1
52	639	借りる（不完了体）\n\n対をなす動詞\n完了体 ： взять	1	1
53	640	新聞	1	1
54	641	読む（不完了体）\n\n対をなす動詞\n完了体 ： прочитать	1	1
55	642	本	1	1
56	643	コピー	1	1
57	644	コピーする（不完了体）\n\n対をなす動詞\n完了体 ： скопировать	1	1
58	645	雑誌	1	1
59	646	巻	1	1
60	647	牛肉	1	1
61	648	安い	1	1
62	649	店	1	1
63	650	高い	1	1
64	651	いくつ	1	1
65	652	いくら	1	1
66	653	果物\n複数形（фрукты）で使用することが多い。	1	1
67	654	野菜\n複数形（овощи）で使用することが多い。	1	1
68	655	魚	1	1
69	656	豚肉	1	1
70	657	鳥肉	1	1
71	658	肉	1	1
72	659	欲しい（不完了体）\n\n対をなす動詞\n完了体 ： захотеть	1	1
73	660	渡す（不完了体）\n\n対をなす動詞\n完了体 ： передать	1	1
74	661	八百屋	1	1
75	662	かぎ（鍵）	1	1
76	663	料理	1	1
77	664	買い物する（不完了体）\n\n対をなす動詞\n完了体 ： купить	1	1
78	665	洗濯する（不完了体）\n\n対をなす動詞\n完了体 ： выстирать	1	1
79	666	掃除する（不完了体）\n\n対をなす動詞\n完了体 ： убрать	1	1
80	667	家族	1	1
81	668	家庭	1	1
82	669	庭（にわ）	1	1
83	670	洗濯	1	1
84	672	うち（家）	1	1
85	672	家（いえ）	1	1
86	673	掃除	1	1
87	674	かえる（帰・返）（不完了体）\n\n対をなす動詞\n完了体 ： возвратиться	1	1
88	675	本棚	1	1
89	676	机	1	1
90	677	椅子（いす）	1	1
91	678	部屋	1	1
92	679	冷蔵庫	1	1
93	680	洗う（不完了体）\n\n対をなす動詞\n完了体 ： вымыть	1	1
94	681	ベッド	1	1
95	682	ラジオ	1	1
96	683	ラジカセ	1	1
97	684	～という名前です	1	1
98	685	寝る、眠る（不完了体）\n\n対をなす動詞\n完了体 ： лечь спать	1	1
99	686	起きる（不完了体）\n\n対をなす動詞\n完了体 ： встать	1	1
100	687	テーブル	1	1
101	688	テレビ	1	1
102	690	お巡りさん（日本人）\n（ロシア人の「お巡りさん」にはмилиционерを用いる。）	1	1
103	690	警官（日本人）\n（ロシア人の「警官」にはмилиционерを用いる。）	1	1
104	691	地図	1	1
105	692	そば	1	1
106	693	ここ,こちら, こっち	1	1
107	695	そこ,そちら, そっち	1	1
108	695	あちら, あっち，あそこ	1	1
109	696	どこ、どちら、どっち	1	1
110	697	交番（日本のもの）\n（ロシアの「交番」にはмилицейский пост, пост милиции, отделение милицииなどを用いる。）	1	1
111	698	近く	1	1
112	883	隣	1	1
113	700	きく	1	0
114	701	（髪・爪を）切る（不完了体）\n\n対をなす動詞\n完了体 ： подстричь	1	1
115	702	短い	1	1
116	703	後ろ	1	1
117	704	前	1	1
118	705	右	1	1
119	706	左	1	1
120	707	長い	1	1
121	708	座る（不完了体）\n\n対をなす動詞\n完了体 ： сесть	1	1
122	709	立つ（完了体）\n\n対をなす動詞\n不完了体 ： вставать	1	1
123	710	友達	1	1
124	711	クラス	1	1
125	711	（小・中学校の）教室\n\n「（大学の）教室」の場合 ： аудитория	1	1
126	713	廊下	1	1
127	714	学校	1	1
128	715	生徒（男性）\n\n女性形  ： ученица	1	1
129	716	勉強	1	1
130	717	学生（男性）\n\n女性形 ： студентка	1	1
131	718	留学生（男性）\n\n女性形 ： иностранная студентка	1	1
132	719	夏休み	1	1
133	720	小・中・高校の先生\n（大学の先生にはпреподавательを用いる。）	1	1
134	721	大学	1	1
135	722	ノート	1	1
136	723	授業	1	1
137	724	作文	1	1
138	725	宿題	1	1
139	726	難しい	1	1
140	727	教える（不完了体）\n\n対をなす動詞\n完了体 ： научить	1	1
141	728	テスト	1	1
142	729	練習	1	1
143	858	易しい	1	1
144	731	練習する（不完了体）\n\n対をなす完了体はありません。	1	1
145	733	質問	1	1
146	733	問題	1	1
147	734	答える（不完了体）\n\n対をなす動詞\n完了体 ： ответить	1	1
148	735	痛い（不完了体）\n\n対をなす完了体はありません。	1	1
149	736	歯	1	1
150	737	医者	1	1
151	738	病院	1	1
152	739	病気	1	1
153	740	薬（くすり）	1	1
154	741	死ぬ（不完了体）\n\n対をなす動詞\n完了体 ： умереть	1	1
155	742	風邪（かぜ）	1	1
156	743	頭（あたま）	1	1
157	744	お腹	1	1
158	745	度（ど）	1	1
159	746	エレベーター	1	1
160	747	切符	1	1
161	748	（電車・バスを）おりる（不完了体）\n\n対をなす動詞\n完了体 ： выйти	1	1
162	749	階段	1	1
163	750	閉める（完了体）\n\n対をなす動詞\n不完了体 ： закрывать	1	1
164	751	駅	1	1
165	752	地下鉄	1	1
166	753		1	1
167	754	開ける（不完了体）\n\n対をなす動詞\n完了体 ： открыть	1	1
168	756	お手洗い	1	1
169	756	トイレ	1	1
170	757	汽車	1	1
171	758	飲み物	1	1
172	759	コーヒー	1	1
173	760	喫茶店	1	1
174	761	レモン	1	1
175	762	牛乳	1	1
176	763	砂糖	1	1
177	764	カップ	1	1
178	765	お茶（緑茶）	1	1
179	766	紅茶	1	1
180	767	コップ	1	1
181	768	入れる、置く（不完了体）\n\n対をなす動詞\n完了体 ： положить	1	1
182	769	甘い	1	1
183	770	飲む（不完了体）\n\n対をなす動詞\n完了体 ： выпить	1	1
184	771	はし	1	1
185	772	酒	1	1
186	773	おいしい	1	1
187	774	ナイフ	1	1
188	775	スプーン	1	1
189	776	フォーク	1	1
190	777	チーズ	1	1
191	778	食べる（不完了体）\n\n対をなす動詞\n完了体 ： съесть	1	1
192	779	まずい	1	1
193	780	パン	1	1
194	781	辛い	1	1
195	782	レストラン	1	1
196	783	食堂	1	1
197	784	酒・ワイン	1	1
198	785	食べ物	1	1
199	786	カレー	1	1
200	787	お金	1	1
201	788	銀行	1	1
202	789	入り口	1	1
203	790	どうぞ,どういたしまして	1	1
204	791	いいえ	1	1
205	792	ええ、はい	1	1
206	793	すみません	1	1
207	794	どうぞ	1	1
208	795	出口	1	1
209	796	（乗り物に乗って）着く、来る（不完了体）\n\n対をなす動詞\n完了体 ：приехать	1	1
210	797	ポスト	1	1
211	798	はがき	1	1
212	799	貼る（不完了体）\n\n対をなす動詞\n完了体 ： наклеить	1	1
213	800	封筒	1	1
214	801	手紙	1	1
215	802	郵便局	1	1
216	803	返す（不完了体）\n\n対をなす動詞\n完了体 ： отдать	1	1
217	804	出す（不完了体）\n\n対をなす動詞\n完了体 ： опустить	1	1
218	805	切手	1	1
219	806	荷物	1	1
220	807	枚	1	1
221	808	（主にお金を）貸す（不完了体）\n\n対をなす動詞\n完了体 ： одолжить	1	1
222	809	買う（不完了体）\n\n対をなす動詞\n完了体 ： купить	1	1
223	810	帽子	1	1
224	811	靴	1	1
225	812	買い物	1	1
226	813	階	1	1
227	814	デパート	1	1
228	815	スカート	1	1
229	816	コート	1	1
230	817	ズボン	1	1
231	818	セーター	1	1
232	819	…てください	1	1
233	820	かばん	1	1
234	821	売る（不完了体）\n\n対をなす動詞\n完了体 ： продать	1	1
235	822	上着	1	1
236	823	ふろ	1	1
237	824	建物	1	1
238	825	台所	1	1
239	826	シャワー	1	1
240	827	窓	1	1
241	828	住む（不完了体）\n\n対をなす完了体はありません。	1	1
242	829	公園	1	1
243	963	ドア	1	1
244	831	浴びる［一風呂～］（不完了体）\n\n対をなす動詞\n完了体 ： принять душ/ванну	1	1
245	832	アパート	1	1
246	833	玄関	1	1
247	834	彼，彼女	1	1
248	835	彼ら，彼女たち	1	1
249	836	私（わたし）	1	1
250	837	私たち	1	1
251	838	（特定の）だれか\n\n「（誰でもよいから）誰か」という場合 ： кто-нибудь	1	1
252	839	だれ	1	1
253	839	どなた	1	1
254	841	きみ	1	1
255	842	あなた	1	1
256	843	この	1	1
257	844	その，あの	1	1
258	845	いかが，どう	1	1
259	846	どの	1	1
260	847	どんな	1	1
261	848	こんな	1	1
262	849	自分で	1	1
263	850	そう	1	1
264	855	厚い	1	1
265	852	狭い	1	1
266	861	細い	1	1
267	854	大きい	1	1
268	855	太い	1	1
269	856	若い	1	1
270	857	広い	1	1
271	858	軽い	1	1
272	859	遠い	1	1
273	860	重い	1	1
274	861	薄い	1	1
275	862	新しい	1	1
276	880	小さい	1	1
277	864	近い\n\n\nСамый близкий：合成最上級（相対最上級：（他と比べて）一番～）\nБлижайший：単一最上級（絶対最上級：きわめて・とびきり～）\n（文法モジュールの「形容詞、副詞の比較級と最上級」の項目を参照。）	1	1
278	865	古い	1	1
279	867	楽しい	1	1
280	867	にぎやかな	1	1
281	868	低い	1	1
282	869	よい	1	1
283	870	明るい	1	1
284	871	弱い	1	1
285	872	強い	1	1
286	873	おもしろい	1	1
287	874	きれい	1	1
288	875	遅い	1	1
289	876	悪い	1	1
290	877	多い\n（複数形でのみ用いる）	1	1
291	1089	暗い	1	1
292	879	静か	1	1
293	880	少ない	1	1
294	881	汚い	1	1
295	882	つまらない	1	1
296	883	横	1	1
297	884	中（なか）	1	\N
298	885	外（そと）	1	\N
299	886	東（ひがし）	1	1
300	887	高さ	1	1
301	888	縦	1	\N
302	889	北（きた）	1	1
303	890	西（にし）	1	1
304	891	下（した）	1	\N
305	892	南（みなみ）	1	1
306	893	上（うえ）	1	1
307	894	先（さき）	1	1
308	895	後（あと）	1	1
309	896	いとこ（男性）\n\n女性の場合 ： двоюродная сестра	1	1
310	897	兄	1	1
311	898	兄弟（きょうだい）	1	1
312	899	おばあさん	1	1
313	900	おじいさん	1	1
314	1075	奥さん	1	1
315	912	母	1	1
316	903	叔父，伯父	1	1
317	904	両親	1	1
318	911	父	1	1
319	906	姉	1	1
320	907	姉妹	1	1
321	908	叔母，伯母	1	1
322	909	お兄さん	1	1
323	910	お姉さん	1	1
324	911	お父さん	1	1
325	912	お母さん	1	1
326	913	靴下	1	1
327	914	シャツ（肌着）	1	1
328	915	脱ぐ（不完了体）\n\n対をなす動詞\n完了体 ： снять	1	1
329	916	架ける（不完了体）\n\n対をなす動詞\n完了体 ： повесить	1	1
330	917	は（穿）く［ズボンを～］　（不完了体）\n\n対をなす動詞\n完了体 ： надеть	1	1
331	918	着る（不完了体）\n\n対をなす動詞\n完了体 ： одеться	1	1
332	919	かぶる（完了体）\n\n対をなす動詞\n不完了体 ： надевать	1	1
333	920	ハンカチ	1	1
334	921	スリッパ	1	1
335	922	傘	1	1
336	923	ポケット	1	1
337	924	（男性用）財布\n（女性用にはкошелёкを用いる。)	1	1
338	925	着ている（不完了体）\n\nこの単語には、「着ている」という意味では、完了体はありません。	1	1
339	926	服	1	1
340	927	洋服	1	1
341	928	口	1	1
342	933	腕（うで）	1	1
343	930	体（からだ）	1	1
344	931	顔	1	1
345	932	脚（あし）	1	1
346	933	手（て）	1	1
347	934	鼻	1	1
348	935	目（め）	1	1
349	936	耳	1	1
350	937	足（あし）	1	1
351	938	おなか	1	1
352	939	皿（さら）	1	1
353	940	バター	1	1
354	941	茶わん	1	1
355	942	あめ	1	1
356	943	昼御飯	1	1
357	951	夕飯（ゆうはん）	1	1
358	945	お菓子\n（複数形（сладости）で用いることが多い。）	1	1
359	946	卵	1	1
360	947	朝御飯	1	1
361	948	御飯（ごはん）	1	1
362	949	醤油	1	1
363	950	塩（しお）	1	1
364	951	晩御飯	1	1
365	952	くわえる（不完了体）\n\n対をなす動詞\n完了体 ： прибавить	1	1
366	953	つなぐ、接続する（不完了体）\n\n対をなす動詞\n完了体 ： подсоединить	1	1
367	954	カメラ	1	1
368	955	ストーブ	1	1
369	956	鉛筆	1	1
370	957		1	1
371	958	眼鏡（めがね）	1	1
372	959	テープレコーダー	1	1
373	960	時計	1	1
374	961	コンピュータ	1	1
375	962	フィルム	1	1
376	963	戸（と）	1	1
377	964	門（もん）	1	1
378	967	ペン	1	1
379	966	万年筆	1	1
380	967	ボールペン	1	1
381	968	八月	1	1
382	969	四月	1	1
383	970	今月	1	1
384	971	毎月（まいつき）	1	1
385	972	十二月	1	1
386	973	二月	1	1
387	974	一月	1	1
388	975	七月	1	1
389	976	六月	1	1
390	977	来月	1	1
391	978	五月	1	1
392	979	三月	1	1
393	980	先月	1	1
394	981	十一月	1	1
395	982	十月	1	1
396	983	九月	1	1
397	984	ひとつき	1	1
398	985	今週	1	1
399	986	毎週	1	1
400	987	日曜日	1	1
401	988	木曜日	1	1
402	989	来週	1	1
403	990	月曜日	1	1
404	991	火曜日	1	1
405	992	水曜日	1	1
406	993	土曜日	1	1
407	994	週間	1	1
408	995	先週	1	1
409	996	金曜日	1	1
410	997	年（ねん）	1	1
411	998	秋	1	1
412	999	今年（ことし）	1	1
413	1000	毎年（まいとし）	1	1
414	1001	夏（なつ）	1	1
415	1002	冬	1	1
416	1003	去年	1	1
417	1004	来年	1	1
418	1005	春	1	1
419	1006	再来年	1	1
420	1007	おととし	1	1
421	1008	午後	1	1
422	1009	今日（きょう）	1	1
423	1010	明日（あした）	1	1
424	1011	時（じ）	1	1
425	1012	昨日（きのう）	1	1
426	1013	夕べ	1	1
427	1014	午前	1	1
428	1015	朝	1	1
429	1016	昼	1	1
430	1017	夜（よる）	1	1
431	1018	夕方	1	1
432	1019	あさって	1	1
433	1020	おととい	1	1
434	1021	もう	1	1
435	1022	ながら	1	\N
436	1023	まだ	1	1
437	1024	中(ちゅう)	1	1
438	1025	時（とき）	1	1
439	1026	いつ	1	1
440	1027	ときどき	1	1
441	1028	しばしば	1	1
442	1029	時間	1	1
443	1030	すぐ	1	1
444	1031	灰皿	1	1
445	1032	歌（うた）	1	1
446	1033	歌う（不完了体）\n\n対をなす動詞\n完了体 ： спеть	1	1
447	1034	たばこ	1	1
448	1035	映画	1	1
449	1036	レコード	1	1
450	1037	ギター	1	1
451	602	弾く（不完了体）\n\n対をなす動詞\n完了体 ： сыграть	1	1
452	1039	音楽	1	1
453	1040	絵（え）	1	1
454	1041	写真	1	1
455	1042	気に入る（不完了体）\n\n対をなす動詞\n完了体 ： понравиться	1	1
456	1043	声	1	1
457	1044	晴れ	1	1
458	1045	暑い	1	1
459	1046	晴れる（不完了体）\n\n対をなす動詞\n完了体 ： проясниться	1	1
460	1047	涼しい	1	1
461	1056	寒い	1	1
462	1049	雪（ゆき）	1	1
463	1050	雨が降っている	1	1
464	1051	雨（あめ）	1	1
465	1052	天気	1	1
466	1053	あたたかい（暖・温）	1	1
467	1054	風（かぜ）	1	1
468	1055	曇り	1	1
469	1056	冷たい	1	1
470	1057	曇る（不完了体）\n\n対をなす動詞\n完了体 ： покрыться облаками	1	1
471	1058	漢字	1	1
472	1065	言う（不完了体）\n\n対をなす動詞\n完了体 ： сказать	1	1
473	1060	書く（不完了体）\n\n対をなす動詞\n完了体 ： написать	1	1
474	1061	話（はなし）	1	1
475	1063	言葉	1	1
476	1063	～語	1	1
477	1064	語（ご）	1	1
478	1065	話す（不完了体）\n\n対をなす完了体はありません。	1	1
479	1066	文章	1	1
480	1067	語る（不完了体）\n\n対をなす動詞\n完了体 ： рассказать	1	1
481	1068	意味	1	1
482	1069	平仮名	1	1
483	1070	片仮名	1	1
484	1071	大人（おとな）	1	1
485	1072	大勢	1	1
486	1073	夫婦	1	1
487	1074	子供	1	1
488	1075	妻	1	1
489	1076	女（おんな）	1	1
490	1077	男の子	1	1
491	1078	人（ひと）	1	1
492	1079	男（おとこ）	1	1
493	1080	女の子	1	1
494	1081	夫	1	1
495	1082	人（ひと）	1	1
496	1083	みんな	1	1
497	1084	白（しろ），白い	1	1
498	1085	青，青い	1	1
499	1086	茶色	1	1
500	1087	明るい，淡い	1	1
501	1088	色（いろ）	1	1
502	1089	濃い，暗い	1	1
503	1090	黄色（きいろ），黄色い	1	1
504	1091	黒（くろ），黒い	1	1
505	1092	赤，赤い	1	1
506	1093	緑	1	1
507	1094	便利な	1	1
508	1095	パーティー	1	1
509	1096	紙	1	1
510	1097	～になる（完了体）\n\n対をなす不完了体はありません。\nまた、この単語は３人称にのみ用いられ、１・２人称では用いません。	1	1
511	1098	締める（不完了体）\n\n対をなす動詞\n完了体 ： сжать	1	1
512	1099	押す（不完了体）\n\n対をなす動詞\n完了体 ： толкнуть	1	1
513	1100	始まる（不完了体）\n\n対をなす動詞\n完了体 ： начаться	1	1
514	1101	ちょうど	1	1
515	1102	ない	1	1
516	1103	まっすぐ	1	\N
517	1104	有名	1	1
518	1105	元気な	1	1
519	1106	じゃあ	1	1
520	1107	多分	1	1
521	1108	では	1	1
522	1109		1	1
523	700	きく（聞・聴）、質問をする　（不完）\n\n対をなす動詞\n完了体 ： спросить	1	1
524	1110	ロシア語	1	1
525	1111	モミの木	1	1
526	1112	ヨーグルト	1	1
527	1113	ほほ	1	1
528	1114	試験	1	1
529	223	週間	1	1
530	1115	再来年	1	1
531	16	中（なか）	1	1
532	1116	外（そと）	1	1
533	1117	縦	1	1
534	1119	下（した）	1	1
535	1120	上（うえ）	1	1
536	1122	先（さき）	1	1
537	1123	後（あと）	1	1
538	94	後（あと）	1	1
539	1124	まっすぐ	1	1
540	1121	前（まえ）	1	1
541	1125	平仮名	1	1
542	1126	片仮名	1	1
543	926	洋服	1	1
544	664	買う（不完了体）\n\n対をなす動詞\n完了体 ： купить	1	1
545	1042	好き（不完了体）\n\n対をなす動詞\n完了体 ： понравиться	1	1
546	1127	～ながら\n\n（文法モジュール：副詞的分詞（副動詞）参照）	1	1
547	1011	時間	1	1
548	906	お姉さん	1	1
549	897	お兄さん	1	1
550	665	（字・画などを）消す（不完了体）\n\n対をなす動詞\n完了体 ： стереть	1	1
551	708	乗る（不完了体）\n\n対をなす動詞\n完了体 ： сесть	1	1
552	870	明るい、淡い	1	1
553	667	家庭	1	1
554	651	いくら	1	1
555	791	ない	1	1
556	932	足（あし）	1	1
557	822	背広	1	1
558	790	どうぞ	1	1
559	790	…てください	1	1
560	1018	パーティー	1	1
561	847	どの	1	1
562	764	茶わん	1	1
563	596	（電車・バスなどを）降りる\n\n対をなす動詞\n完了体 ： выйти	1	1
564	1128	器、ボール\n（猫や犬用の食べ物を入れる器などとしてよく用いられる）	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: ru
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
59	15215	1.1962	1.19	体	関係	量	助数接辞	巻（かん）	巻	かん
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
170	56643	1.465	1.46	体	生産物	機械	乗り物（陸上）	汽車	汽車	きしゃ
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
247	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
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
299	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
300	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
302	10912	1.173	1.17	体	関係	空間	方向・方角	北（きた）	北	きた
303	10905	1.173	1.17	体	関係	空間	方向・方角	西（にし）	西	にし
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
366	72834	2.1559999	2.15	用	関係	作用	接近・接触・隔離	つなぐ	つなぐ	つなぐ
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
511	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
513	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
517	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
519	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
523	32745	1.3132	1.31	体	活動	言語	問答	問答	問答	もんどう
524	30591	1.3101	1.31	体	活動	言語	言語	ロシア語	ロシア語	ろしあご
525	62079	1.5401	1.54	体	自然	植物	木本	もみ（樅）	もみ	もみ
526	50438	1.4299999	1.43	体	生産物	食料	食料	食料品	食料品	しょくりょうひん
527	64134	1.5599999	1.56	体	自然	身体	身体	身体	身体	しんたい
529	14890	1.1962	1.19	体	関係	量	助数接辞	週間	週間	しゅうかん
530	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
531	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
532	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
533	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
534	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
535	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
536	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
537	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
538	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
539	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
540	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
541	31558	1.3113	1.31	体	活動	言語	文字	平仮名	平仮名	ひらがな
542	31559	1.3113	1.31	体	活動	言語	文字	片仮名	片仮名	かたかな
543	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
544	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
545	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
546	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
547	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
548	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
549	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
550	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
551	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
552	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
553	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
554	14658	1.196	1.19	体	関係	量	数記号（一二三）	いくら	いくら	いくら
555	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
556	64769	1.5603	1.56	体	自然	身体	手足・指	足（あし）	足	あし
557	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
558	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
559	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
560	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
561	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
562	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
563	71951	2.154	2.15	用	関係	作用	上がり・下がり	降りる	降りる	おりる
564	53677	1.451	1.45	体	生産物	道具	器・ふた	器（うつわ）	器	うつわ
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	2	467	1	\N	0	\N	\N
2	477	770	1		0	\N	\N
3	312	762	1	бабушки	0	\N	\N
4	160	368	1	билет	0	\N	\N
5	50	360	1	библиотеке	0	\N	\N
6	311	409	1	брат	0	\N	\N
8	497	216	1	\N	0	\N	\N
9	148	654	0	болит	0	\N	\N
11	431	452	1	вечер	0	\N	\N
12	431	189	2	\N	0	\N	\N
13	197	562	1	вино	0	\N	\N
14	186	499	1	\N	0	\N	\N
15	87	130	1	\N	0	\N	\N
16	145	769	1		0	\N	\N
17	146	210	1	\N	0	\N	\N
18	400	74	1	\N	0	\N	\N
19	150	117	1	\N	0	\N	\N
20	438	158	1	\N	0	\N	\N
21	442	105	1	\N	0	\N	\N
22	496	143	1	\N	0	\N	\N
23	99	109	1	\N	0	\N	\N
24	425	127	1	\N	0	\N	\N
25	255	31	1	\N	0	\N	\N
26	208	401	1	выхода	0	\N	\N
27	53	201	1	\N	0	\N	\N
28	53	38	2	\N	0	\N	\N
29	109	399	1	где	0	\N	\N
30	348	12	1	\N	0	\N	\N
31	472	412	1		0	\N	\N
32	478	113	1	\N	0	\N	\N
33	410	117	1	\N	0	\N	\N
34	7	751	1	гостиницу	0	\N	\N
35	205	260	1	Да	0	\N	\N
36	205	643	2	Да	0	\N	\N
37	44	677	1	делать	0	\N	\N
38	44	714	2	делать	0	\N	\N
39	487	216	1	\N	0	\N	\N
40	464	550	1	\N	0	\N	\N
41	464	155	2	\N	0	\N	\N
42	84	548	1		0	\N	\N
43	85	207	1	\N	0	\N	\N
44	123	94	1	\N	0	\N	\N
45	463	155	1	\N	0	\N	\N
46	1	606	1	ездил	0	\N	\N
48	191	133	1	\N	0	\N	\N
49	191	53	2	\N	0	\N	\N
50	436	354	1	ещё	0	\N	\N
51	436	417	2	ещё	0	\N	\N
52	314	217	1		0	\N	\N
53	488	306	1	жена	0	\N	\N
54	157	654	1	живот	0	\N	\N
55	351	654	1	живот	0	\N	\N
56	241	225	1	\N	0	\N	\N
57	241	207	2	\N	0	\N	\N
58	423	331	1	\N	0	\N	\N
59	49	593	1	заняты	0	\N	\N
60	237	261	1	здание	0	\N	\N
61	106	213	1	\N	0	\N	\N
62	97	272	1	\N	0	\N	\N
63	97	275	2	\N	0	\N	\N
64	206	259	1	\N	0	\N	\N
65	5	377	1	иностранец	0	\N	\N
66	286	61	1	\N	0	\N	\N
67	258	485	1	как	0	\N	\N
68	258	238	2	Как	0	\N	\N
69	260	464	1	Какой	0	\N	\N
70	369	426	1	карандашом	0	\N	\N
71	336	226	1	\N	0	\N	\N
72	448	568	1	\N	0	\N	\N
73	75	122	1	\N	0	\N	\N
74	55	61	1	\N	0	\N	\N
75	439	704	1	Когда	0	\N	\N
76	91	122	1		0	\N	\N
77	374	518	1	\N	0	\N	\N
78	57	244	1	копировали	0	\N	\N
80	287	107	1	\N	0	\N	\N
81	505	559	1	красное	0	\N	\N
82	252	6	1	\N	0	\N	\N
83	253	6	1	\N	0	\N	\N
84	251	187	1	\N	0	\N	\N
85	98	109	1	\N	0	\N	\N
86	153	587	1	лекарство	0	\N	\N
87	26	158	1	\N	0	\N	\N
88	17	63	1	\N	0	\N	\N
89	17	398	2	люблю	0	\N	\N
90	62	135	1	\N	0	\N	\N
91	315	280	1	мать	0	\N	\N
92	325	280	1	мать	0	\N	\N
94	397	537	1	месяцев	0	\N	\N
95	165	401	1	метро	0	\N	\N
96	269	176	1	\N	0	\N	\N
97	494	129	1	\N	0	\N	\N
98	250	36	1	\N	0	\N	\N
99	71	134	1	\N	0	\N	\N
100	171	560	1	напиток	0	\N	\N
101	118	263	1	направо	0	\N	\N
102	513	572	1	начинается	0	\N	\N
103	204	369	1	\N	0	\N	\N
104	204	291	2	Нет	0	\N	\N
105	515	131	1	\N	0	\N	\N
106	275	678	1	новый	0	\N	\N
107	430	129	1	\N	0	\N	\N
108	455	493	1	нравится	0	\N	\N
109	455	312	2	нравится	0	\N	\N
110	18	493	1	\N	0	\N	\N
111	18	348	2	\N	0	\N	\N
112	519	589	1	Ну	0	\N	\N
113	356	647	1	обеда	0	\N	\N
114	240	665	1	окно	0	\N	\N
115	247	30	1	\N	0	\N	\N
116	247	190	2	\N	0	\N	\N
117	248	134	1	\N	0	\N	\N
118	248	173	2	\N	0	\N	\N
119	318	280	1	отец	0	\N	\N
120	324	280	1	отец	0	\N	\N
121	167	473	1	открывает	0	\N	\N
122	242	504	1	парке	0	\N	\N
123	73	669	1	передаёт	0	\N	\N
124	473	35	1	\N	0	\N	\N
125	214	527	1	\N	0	\N	\N
126	183	552	1	будешь ... питьでの形	0	\N	\N
127	465	147	1	\N	0	\N	\N
128	170	136	1	\N	0	\N	\N
129	13	387	1	поездке	0	\N	\N
130	13	605	2	поездки	0	\N	\N
131	203	303	1	пожалуйста	0	\N	\N
132	203	255	2	Пожалуйста	0	\N	\N
133	207	303	1	\N	0	\N	\N
134	232	153	1	\N	0	\N	\N
135	232	57	2	\N	0	\N	\N
136	521	372	1	Пока	0	\N	\N
137	77	177	1	\N	0	\N	\N
138	222	177	1	\N	0	\N	\N
139	155	585	1	Простуда	0	\N	\N
140	408	690	1	\N	0	\N	\N
141	393	341	1	\N	0	\N	\N
142	34	112	1	\N	0	\N	\N
143	409	646	1	пятницу	0	\N	\N
144	136	720	1	уроке	0	\N	\N
145	48	224	1	\N	0	\N	\N
146	48	204	2	\N	0	\N	\N
147	95	545	1	радио	0	\N	\N
148	195	752	1	ресторан	0	\N	\N
149	317	747	1	родители	0	\N	\N
150	378	427	1		0	\N	\N
151	68	112	1	\N	0	\N	\N
152	68	134	2	\N	0	\N	\N
153	262	445	1	сам	0	\N	\N
155	422	147	1	\N	0	\N	\N
156	80	408	1	\N	0	\N	\N
158	498	119	1	\N	0	\N	\N
160	65	368	1	\N	0	\N	\N
161	51	466	1	\N	0	\N	\N
162	113	385	1	\N	0	\N	\N
163	462	155	1	\N	0	\N	\N
164	27	398	1	спорт	0	\N	\N
165	405	599	1	среду	0	\N	\N
166	278	78	1	\N	0	\N	\N
167	100	315	1	столу	0	\N	\N
168	10	473	1	стран	0	\N	\N
169	130	417	1	студент	0	\N	\N
170	37	138	1		0	\N	\N
171	107	263	1		0	\N	\N
172	108	261	1	Там	0	\N	\N
173	101	96	1	\N	0	\N	\N
174	46	377	1	телефону	0	\N	\N
175	135	723	1	тетрадь	0	\N	\N
176	257	333	1	тот	0	\N	\N
177	257	41	2	\N	0	\N	\N
178	254	556	1	\N	0	\N	\N
179	254	64	2	\N	0	\N	\N
180	434	749	1	\N	0	\N	\N
181	134	418	1	университете	0	\N	\N
182	133	121	1	\N	0	\N	\N
183	454	617	1	фотографии	0	\N	\N
184	193	151	1	\N	0	\N	\N
185	469	660	1	\N	0	\N	\N
186	282	752	1	хороший	0	\N	\N
187	19	541	1	хорошо	0	\N	\N
188	424	222	1	\N	0	\N	\N
189	424	168	2	\N	0	\N	\N
190	441	126	1	\N	0	\N	\N
191	441	412	2	Часто	0	\N	\N
192	491	120	1	\N	0	\N	\N
193	495	120	1	\N	0	\N	\N
194	495	406	2	человек	0	\N	\N
195	504	216	1	\N	0	\N	\N
196	504	12	2	\N	0	\N	\N
197	54	91	1	\N	0	\N	\N
198	127	219	1	\N	0	\N	\N
199	398	598	1	\N	0	\N	\N
200	256	673	1	этот	0	\N	\N
201	256	37	2	\N	0	\N	\N
202	249	63	1	\N	0	\N	\N
203	476	148	1	\N	0	\N	\N
204	476	220	2	\N	0	\N	\N
205	387	178	1	\N	0	\N	\N
206	8	52	1	\N	0	\N	\N
207	8	148	2	\N	0	\N	\N
208	381	771	1		0	\N	\N
209	30	772	1		0	\N	\N
210	379	773	1		0	\N	\N
212	382	775	1		0	\N	\N
213	219	776	1		0	\N	\N
214	201	777	1		0	\N	\N
215	20	778	1		0	\N	\N
217	111	780	1		0	\N	\N
218	76	781	1		0	\N	\N
219	518	782	1		0	\N	\N
220	152	783	1		0	\N	\N
221	151	784	1		0	\N	\N
222	267	785	1		0	\N	\N
223	52	786	1		0	\N	\N
224	230	787	1		0	\N	\N
225	509	788	1		0	\N	\N
226	337	789	1		0	\N	\N
227	25	790	1		0	\N	\N
228	310	791	1		0	\N	\N
229	236	792	1		0	\N	\N
230	31	793	1		0	\N	\N
231	279	794	1		0	\N	\N
232	280	795	1		0	\N	\N
233	418	796	1		0	\N	\N
234	437	45	1	\N	0	\N	\N
235	437	797	2		0	\N	\N
236	467	798	1		0	\N	\N
237	508	799	1		0	\N	\N
238	329	800	1		0	\N	\N
239	484	801	1		0	\N	\N
240	189	802	1		0	\N	\N
241	377	803	1		0	\N	\N
242	299	804	1		0	\N	\N
243	45	805	1		0	\N	\N
244	122	806	1		0	\N	\N
245	11	807	1		0	\N	\N
246	404	808	1		0	\N	\N
247	202	809	1		0	\N	\N
248	426	810	1		0	\N	\N
249	300	811	1		0	\N	\N
250	9	812	1		0	\N	\N
251	40	813	1		0	\N	\N
252	450	814	1		0	\N	\N
253	60	815	1		0	\N	\N
254	156	816	1		0	\N	\N
255	344	817	1		0	\N	\N
256	223	818	1		0	\N	\N
257	456	819	1		0	\N	\N
258	158	820	1		0	\N	\N
261	294	822	2		0	\N	\N
262	272	823	1		0	\N	\N
263	243	824	1		0	\N	\N
264	376	825	1		0	\N	\N
265	493	826	1		0	\N	\N
266	313	827	1		0	\N	\N
267	385	828	1		0	\N	\N
268	429	829	1		0	\N	\N
269	200	830	1		0	\N	\N
270	61	831	1		0	\N	\N
271	120	832	1		0	\N	\N
272	138	833	1		0	\N	\N
273	33	834	1		0	\N	\N
274	63	835	1		0	\N	\N
275	239	836	1		0	\N	\N
276	316	837	1		0	\N	\N
277	384	838	1		0	\N	\N
278	458	839	1		0	\N	\N
279	503	840	1		0	\N	\N
280	489	841	1		0	\N	\N
281	58	842	1		0	\N	\N
282	360	843	1		0	\N	\N
283	4	844	1		0	\N	\N
284	163	845	1		0	\N	\N
285	303	846	1		0	\N	\N
286	506	847	1		0	\N	\N
287	415	848	1		0	\N	\N
288	481	849	1		0	\N	\N
289	335	850	1		0	\N	\N
290	149	851	1		0	\N	\N
291	471	852	1		0	\N	\N
292	451	853	1		0	\N	\N
293	15	854	1		0	\N	\N
294	517	855	1		0	\N	\N
295	440	856	1		0	\N	\N
296	388	857	1		0	\N	\N
297	389	858	1		0	\N	\N
298	129	859	1		0	\N	\N
300	181	861	1		0	\N	\N
301	399	862	1		0	\N	\N
302	413	863	1		0	\N	\N
303	12	864	1		0	\N	\N
304	104	865	1		0	\N	\N
305	453	866	1		0	\N	\N
306	173	867	1		0	\N	\N
307	245	868	1		0	\N	\N
308	124	869	1		0	\N	\N
309	125	870	1		0	\N	\N
310	213	871	1		0	\N	\N
311	355	872	1		0	\N	\N
312	126	873	1		0	\N	\N
313	499	874	1		0	\N	\N
314	115	875	1		0	\N	\N
315	259	182	1	\N	0	\N	\N
317	172	877	1		0	\N	\N
318	94	878	1		0	\N	\N
319	70	879	1		0	\N	\N
320	238	880	1		0	\N	\N
321	199	860	1		0	\N	\N
322	132	881	1		0	\N	\N
323	42	882	1		0	\N	\N
324	143	883	1		0	\N	\N
325	271	884	1		0	\N	\N
326	162	885	1		0	\N	\N
327	414	886	1		0	\N	\N
328	174	887	1		0	\N	\N
329	159	888	1		0	\N	\N
330	188	889	1		0	\N	\N
331	96	890	1		0	\N	\N
332	372	891	1		0	\N	\N
333	391	892	1		0	\N	\N
334	276	893	1		0	\N	\N
335	293	894	1		0	\N	\N
336	490	895	1		0	\N	\N
337	218	896	1		0	\N	\N
338	392	897	1		0	\N	\N
339	353	898	1		0	\N	\N
340	38	899	1		0	\N	\N
341	21	900	1		0	\N	\N
342	290	901	1		0	\N	\N
343	485	902	1		0	\N	\N
344	175	903	1		0	\N	\N
345	492	904	1		0	\N	\N
346	452	905	1		0	\N	\N
347	93	906	1		0	\N	\N
348	520	907	1		0	\N	\N
349	330	908	1		0	\N	\N
350	212	909	1		0	\N	\N
351	119	910	1		0	\N	\N
352	192	911	1		0	\N	\N
353	295	912	1		0	\N	\N
354	28	913	1		0	\N	\N
355	327	914	1		0	\N	\N
356	281	915	1		0	\N	\N
357	345	916	1		0	\N	\N
358	350	917	1		0	\N	\N
359	187	918	1		0	\N	\N
360	347	919	1		0	\N	\N
361	338	920	1		0	\N	\N
362	326	921	1		0	\N	\N
363	333	922	1		0	\N	\N
364	394	923	1		0	\N	\N
365	224	924	1		0	\N	\N
366	67	925	1		0	\N	\N
367	74	926	1		0	\N	\N
368	331	927	1		0	\N	\N
369	339	928	1		0	\N	\N
371	395	930	1		0	\N	\N
372	217	931	1		0	\N	\N
373	411	932	1		0	\N	\N
374	194	933	1		0	\N	\N
375	147	934	1		0	\N	\N
377	211	936	1		0	\N	\N
378	371	937	1		0	\N	\N
379	468	938	1		0	\N	\N
380	470	939	1		0	\N	\N
381	29	940	1		0	\N	\N
382	88	941	1		0	\N	\N
383	184	942	1		0	\N	\N
384	229	943	1		0	\N	\N
385	444	944	1		0	\N	\N
386	32	945	1		0	\N	\N
387	445	946	1		0	\N	\N
388	446	947	1		0	\N	\N
389	368	948	1		0	\N	\N
390	235	949	1		0	\N	\N
391	43	950	1		0	\N	\N
392	89	951	1		0	\N	\N
393	198	952	1		0	\N	\N
394	24	953	1		0	\N	\N
395	449	954	1		0	\N	\N
396	375	955	1		0	\N	\N
397	22	956	1		0	\N	\N
398	289	957	1		0	\N	\N
399	39	958	1		0	\N	\N
400	433	959	1		0	\N	\N
401	420	960	1		0	\N	\N
402	288	961	1		0	\N	\N
403	332	962	1		0	\N	\N
404	225	963	1		0	\N	\N
405	110	964	1		0	\N	\N
406	102	965	1		0	\N	\N
407	103	966	1		0	\N	\N
408	403	967	1		0	\N	\N
409	432	968	1		0	\N	\N
410	16	969	1		0	\N	\N
411	114	970	1		0	\N	\N
412	215	971	1		0	\N	\N
413	210	972	1		0	\N	\N
414	479	973	1		0	\N	\N
415	365	975	1		0	\N	\N
416	209	976	1		0	\N	\N
417	366	977	1		0	\N	\N
418	244	978	1		0	\N	\N
419	246	979	1		0	\N	\N
420	141	980	1		0	\N	\N
421	35	981	1		0	\N	\N
422	234	982	1		0	\N	\N
423	460	983	1		0	\N	\N
424	416	984	1		0	\N	\N
425	459	985	1		0	\N	\N
426	14	986	1		0	\N	\N
427	47	195	0	\N	0	\N	\N
428	474	987	1		0	\N	\N
429	480	988	1		0	\N	\N
430	36	989	1		0	\N	\N
431	361	990	1		0	\N	\N
432	341	991	1		0	\N	\N
433	41	992	1		0	\N	\N
434	342	993	1		0	\N	\N
435	346	994	1		0	\N	\N
436	380	995	1		0	\N	\N
437	112	996	1		0	\N	\N
438	296	997	1		0	\N	\N
439	457	998	1		0	\N	\N
440	370	999	1		0	\N	\N
441	131	1000	1		0	\N	\N
442	121	1001	1		0	\N	\N
443	166	1002	1		0	\N	\N
444	283	1003	1		0	\N	\N
445	500	1004	1		0	\N	\N
446	176	1005	1		0	\N	\N
447	69	1006	1		0	\N	\N
448	231	1007	1		0	\N	\N
449	302	1008	1		0	\N	\N
450	81	1009	1		0	\N	\N
451	396	1010	1		0	\N	\N
452	320	1011	1		0	\N	\N
453	511	1012	1		0	\N	\N
454	285	1013	1		0	\N	\N
455	284	1014	1		0	\N	\N
456	182	1015	1		0	\N	\N
457	358	1016	1		0	\N	\N
458	402	1017	1		0	\N	\N
459	417	1018	1		0	\N	\N
460	390	1019	1		0	\N	\N
461	523	1020	1		0	\N	\N
462	328	1021	1		0	\N	\N
463	362	1022	1		0	\N	\N
464	363	1023	1		0	\N	\N
465	137	1024	1		0	\N	\N
466	443	1025	1		0	\N	\N
467	319	1026	1		0	\N	\N
468	323	1027	1		0	\N	\N
469	322	1028	1		0	\N	\N
470	180	1029	1		0	\N	\N
471	164	1030	1		0	\N	\N
472	510	1031	1		0	\N	\N
473	78	1032	1		0	\N	\N
474	83	1033	1		0	\N	\N
475	196	1034	1		0	\N	\N
476	90	1035	1		0	\N	\N
477	406	1036	1		0	\N	\N
478	233	1037	1		0	\N	\N
479	486	1038	1		0	\N	\N
480	161	1039	1		0	\N	\N
481	190	1040	1		0	\N	\N
482	177	1041	1		0	\N	\N
483	447	1042	1		0	\N	\N
484	261	1043	1		0	\N	\N
485	263	1044	1		0	\N	\N
486	352	1045	1		0	\N	\N
487	343	1046	1		0	\N	\N
488	291	1047	1		0	\N	\N
489	502	1048	1		0	\N	\N
490	466	1049	1		0	\N	\N
491	321	1050	1		0	\N	\N
492	292	1051	1		0	\N	\N
493	512	1052	1		0	\N	\N
494	264	1053	1		0	\N	\N
495	268	1054	1		0	\N	\N
496	59	1055	1		0	\N	\N
497	266	1056	1		0	\N	\N
498	274	1057	1		0	\N	\N
500	514	1059	2		0	\N	\N
501	139	1060	1		0	\N	\N
502	168	1061	1		0	\N	\N
503	169	1062	1		0	\N	\N
504	273	1064	1		0	\N	\N
505	105	1065	1		0	\N	\N
506	79	1066	1		0	\N	\N
507	86	1067	1		0	\N	\N
508	507	1068	1		0	\N	\N
509	357	1069	1		0	\N	\N
510	364	1070	1		0	\N	\N
511	265	1071	1		0	\N	\N
512	154	1072	1		0	\N	\N
513	227	1073	1		0	\N	\N
514	142	1074	1		0	\N	\N
515	144	1075	1		0	\N	\N
516	428	129	0	\N	0	\N	\N
517	349	1076	1		0	\N	\N
518	128	1077	1		0	\N	\N
519	140	1078	1		0	\N	\N
520	386	1079	1		0	\N	\N
521	367	1080	1		0	\N	\N
522	6	1081	1		0	\N	\N
523	66	1082	1		0	\N	\N
524	23	1083	1		0	\N	\N
525	92	1084	1		0	\N	\N
526	461	1085	1		0	\N	\N
527	72	1086	1		0	\N	\N
528	501	1087	1		0	\N	\N
529	354	1088	1		0	\N	\N
530	178	1089	1		0	\N	\N
531	373	1090	1		0	\N	\N
532	179	1091	1		0	\N	\N
533	401	1092	1		0	\N	\N
534	270	1093	1		0	\N	\N
535	334	1094	1		0	\N	\N
536	226	1095	1		0	\N	\N
537	412	1096	1		0	\N	\N
538	383	1097	1		0	\N	\N
539	228	1098	1		0	\N	\N
540	305	1099	1		0	\N	\N
541	475	1100	1		0	\N	\N
542	359	1101	1		0	\N	\N
543	56	1102	1		0	\N	\N
544	427	1103	1		0	\N	\N
545	421	1104	1		0	\N	\N
546	220	1105	1		0	\N	\N
547	64	406	1	Сколько	0	\N	\N
548	64	1106	2		0	\N	\N
549	185	774	1		0	\N	\N
550	185	1107	2		0	\N	\N
551	524	1108	1		0	\N	\N
552	525	1109	1		0	\N	\N
553	526	1110	1		0	\N	\N
554	527	1111	1		0	\N	\N
555	528	1112	1		0	\N	\N
556	82	1083	1		0	\N	\N
557	309	1113	1		0	\N	\N
559	529	388	2	недели	0	\N	\N
560	524	383	2	\N	0	\N	\N
561	524	220	3	\N	0	\N	\N
562	531	1047	1	\N	0	\N	\N
563	531	648	2	\N	0	\N	\N
564	532	1115	1		0	\N	\N
565	533	1116	1		0	\N	\N
566	534	1109	1	\N	0	\N	\N
567	535	944	1	\N	0	\N	\N
568	536	1117	1		0	\N	\N
569	539	1118	1		0	\N	\N
570	538	1119	1		0	\N	\N
571	540	1093	1	\N	0	\N	\N
573	541	1120	1		0	\N	\N
574	542	1121	1		0	\N	\N
575	543	928	0		0	\N	\N
576	544	177	0	\N	0	\N	\N
577	530	1122	1		0	\N	\N
578	545	348	0	нравится	0	\N	\N
579	546	1123	1		0	\N	\N
580	547	1124	1		0	\N	\N
581	548	1125	1		0	\N	\N
582	549	1126	1		0	\N	\N
583	550	1127	1		0	\N	\N
584	551	1128	1		0	\N	\N
585	552	1129	1		0	\N	\N
586	553	1130	1		0	\N	\N
587	554	1131	1		0	\N	\N
589	3	1132	2		0	\N	\N
590	555	1133	1		0	\N	\N
591	556	917	0	\N	0	\N	\N
592	557	950	0	\N	0	\N	\N
593	558	303	0	пожалуйста	0	\N	\N
594	559	57	0	\N	0	\N	\N
595	559	153	0	\N	0	\N	\N
596	277	779	1		0	\N	\N
597	277	1134	2		0	\N	\N
598	560	799	0	\N	0	\N	\N
599	561	876	0	\N	0	\N	\N
600	221	929	1		0	\N	\N
601	221	1135	2		0	\N	\N
602	216	935	1		0	\N	\N
603	216	1136	2		0	\N	\N
605	562	1137	1		0	\N	\N
606	563	1039	0	\N	0	\N	\N
607	564	1138	1		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: ru
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
157	27
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
299	24
300	24
302	24
303	24
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
523	9
524	37
526	28
527	27
528	11
529	31
530	32
531	24
532	24
533	24
534	24
535	24
536	24
537	24
538	24
540	24
541	37
542	37
543	6
543	26
544	19
545	2
546	34
547	34
548	25
549	25
550	29
551	14
552	39
553	7
554	6
556	27
557	4
558	17
559	19
560	35
561	6
562	28
563	14
564	7
564	28
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
902	мать	0	М	\N
903	дядя	1	Д	526
1025	время	1	В	329
1026	когда	1	К	1125
1027	иногда	1	И	906
1028	часто	1	Ч	2405
1029	час	0	Ч	\N
1030	сразу	1	С	1840
1031	пепельница	1	П	1605
128	уже	\N	\N	\N
283	кто	\N	\N	\N
571	родной	\N	\N	\N
1	здравствуй(те)	\N	\N	\N
2	добрый	\N	\N	\N
3	день	\N	\N	\N
4	как	\N	\N	\N
5	поживать	\N	\N	\N
6	спасибо	\N	\N	\N
7	хорошо	\N	\N	\N
8	а	\N	\N	\N
9	вы	\N	\N	\N
10	неважно	\N	\N	\N
11	что	\N	\N	\N
12	случиться	\N	\N	\N
13	вчера	\N	\N	\N
14	весь	\N	\N	\N
15	данные	\N	\N	\N
16	в	1	В	301
17	компьютер	\N	\N	\N
18	потеряться	\N	\N	\N
19	не	\N	\N	\N
20	копировать	\N	\N	\N
21	сочувствовать	\N	\N	\N
22	здравствуй	\N	\N	\N
23	есть	\N	\N	\N
24	время	\N	\N	\N
25	хотеть	\N	\N	\N
26	бы	\N	\N	\N
27	советоваться	\N	\N	\N
28	статья	\N	\N	\N
29	но	\N	\N	\N
30	сейчас	\N	\N	\N
31	быть	\N	\N	\N
32	заседание	\N	\N	\N
33	зайти	\N	\N	\N
34	кабинет	\N	\N	\N
35	поздно	\N	\N	\N
36	пожалуйста	\N	\N	\N
37	прийти	\N	\N	\N
38	занятие	\N	\N	\N
39	понятно	\N	\N	\N
40	ждать	\N	\N	\N
41	где	\N	\N	\N
42	находиться	\N	\N	\N
43	ближайший	\N	\N	\N
44	книжный	\N	\N	\N
45	магазин	\N	\N	\N
46	да	\N	\N	\N
47	знать	\N	\N	\N
48	там	\N	\N	\N
49	белый	\N	\N	\N
50	здание	\N	\N	\N
51	видеть	\N	\N	\N
52	повернуть	\N	\N	\N
53	направо	\N	\N	\N
54	тогда	\N	\N	\N
55	он	\N	\N	\N
56	называться	\N	\N	\N
57	мир	\N	\N	\N
58	книга	\N	\N	\N
59	что（成句）	\N	\N	\N
60	простить	\N	\N	\N
61	дать	\N	\N	\N
62	знакомиться	\N	\N	\N
63	звать	\N	\N	\N
645	журнал	1	Ж	709
896	двоюродный брат	1	Д	506
897	старший брат	1	С	1846
898	брат	1	Б	218
901	жена	0	Ж	\N
64	аспирант	\N	\N	\N
65	этот	\N	\N	\N
66	университет	\N	\N	\N
67	студентка	\N	\N	\N
68	очень	\N	\N	\N
69	рад	\N	\N	\N
70	откуда	\N	\N	\N
71	Санкт-Петербург	\N	\N	\N
72	отец	\N	\N	\N
73	мать	\N	\N	\N
74	жить	\N	\N	\N
75	москвичка	\N	\N	\N
76	раньше	\N	\N	\N
77	прожить	\N	\N	\N
78	пять	\N	\N	\N
79	год	\N	\N	\N
80	так	\N	\N	\N
81	долго	\N	\N	\N
82	когда	\N	\N	\N
83	возвратиться	\N	\N	\N
84	Москва	\N	\N	\N
85	два	\N	\N	\N
86	назад	\N	\N	\N
87	я	\N	\N	\N
88	опоздать	\N	\N	\N
89	замёрзнуть	\N	\N	\N
90	нет	\N	\N	\N
91	позвонить	\N	\N	\N
92	должен	\N	\N	\N
93	извиниться	\N	\N	\N
94	за	1	З	801
95	тот	\N	\N	\N
96	звонить	\N	\N	\N
97	беспокоиться	\N	\N	\N
98	ведь	\N	\N	\N
99	сова	\N	\N	\N
100	вечер	\N	\N	\N
101	поздравить	\N	\N	\N
102	рождение	\N	\N	\N
103	пройти	\N	\N	\N
104	вот	\N	\N	\N
105	это	\N	\N	\N
106	жена	\N	\N	\N
107	сказать	\N	\N	\N
108	нравиться	\N	Н	\N
109	красный	\N	\N	\N
110	роза	\N	\N	\N
111	совершенный	\N	\N	\N
112	верный	\N	\N	\N
113	думать	\N	\N	\N
114	дарить	\N	\N	\N
115	подарок	\N	\N	\N
116	хороший	\N	\N	\N
117	настроение	\N	\N	\N
118	французский	\N	\N	\N
119	духи	\N	\N	\N
120	Шанель	\N	\N	\N
121	Спасибо	\N	\N	\N
122	большой	\N	\N	\N
123	какой	\N	\N	\N
124	прекрасный	\N	\N	\N
125	ну	\N	\N	\N
126	просить	\N	\N	\N
127	стол	\N	\N	\N
129	пора	\N	\N	\N
130	надо	\N	\N	\N
131	уходить	\N	\N	\N
132	угощение	\N	\N	\N
133	почему	\N	\N	\N
134	ещё	\N	\N	\N
135	рано	\N	\N	\N
136	встретить	\N	\N	\N
137	друг	\N	\N	\N
138	аэропорт	\N	\N	\N
139	прилетать	\N	\N	\N
140	из	\N	\N	\N
141	Япония	\N	\N	\N
142	впервые	\N	\N	\N
143	Россия	\N	\N	\N
144	если	\N	\N	\N
145	обязательно	\N	\N	\N
146	заблудиться	\N	\N	\N
147	мочь	\N	\N	\N
148	который	\N	\N	\N
149	час	\N	\N	\N
150	шесть	\N	\N	\N
151	спешить	\N	\N	\N
152	до	\N	\N	\N
153	свидание	\N	\N	\N
154	завтра	\N	\N	\N
155	показать	\N	\N	\N
156	японско-	\N	\N	\N
157	русский	\N	\N	\N
158	словарь	\N	\N	\N
159	справа	\N	\N	\N
160	вон	\N	\N	\N
161	никогда	\N	\N	\N
162	новый	\N	\N	\N
163	печатать	\N	\N	\N
164	прошлый	\N	\N	\N
165	месяц	\N	\N	\N
166	сколько	\N	\N	\N
167	стоить	\N	\N	\N
168	триста	\N	\N	\N
169	восемьдесят	\N	\N	\N
170	рубль	\N	\N	\N
171	брать	\N	\N	\N
172	читать	\N	\N	\N
173	преступление	\N	\N	\N
174	наказание	\N	\N	\N
175	роман	\N	\N	\N
176	произведение	\N	\N	\N
177	ночь	\N	\N	\N
178	мой	\N	\N	\N
179	любимый	\N	\N	\N
180	повесть	\N	\N	\N
181	писатель	\N	\N	\N
182	красиво	\N	\N	\N
183	изобразить	\N	\N	\N
184	кстати	\N	\N	\N
185	посмотреть	\N	\N	\N
186	привет	\N	\N	\N
187	ой	\N	\N	\N
188	занятый	\N	\N	\N
189	делать	\N	\N	\N
190	утром	\N	\N	\N
191	заниматься	\N	\N	\N
192	библиотека	\N	\N	\N
193	днём	\N	\N	\N
194	вечером	\N	\N	\N
195	свободный	\N	\N	\N
196	билет	\N	\N	\N
197	Большой театр	\N	\N	\N
198	вечером 	\N	\N	\N
199	гость	\N	\N	\N
200	слушать	\N	\N	\N
201	опера	\N	\N	\N
202	Борис Годунов	\N	\N	\N
203	платить	\N	\N	\N
204	пока	\N	\N	\N
205	всего	\N	\N	\N
206	понять	\N	\N	\N
207	иностранец	\N	\N	\N
208	разговаривать	\N	\N	\N
209	телефон	\N	\N	\N
210	по-русски	\N	\N	\N
211	комплимент	\N	\N	\N
212	свой	\N	\N	\N
213	имя	\N	\N	\N
214	беспокойться	\N	\N	\N
215	познакомиться	\N	\N	\N
216	учить	\N	\N	\N
217	совсем	\N	\N	\N
218	мало	\N	\N	\N
219	возможность	\N	\N	\N
220	говорить	\N	\N	\N
221	туристический	\N	\N	\N
222	поездка	\N	\N	\N
223	неделя	1	Н	1411
224	поэтому	\N	\N	\N
225	уверенный	\N	\N	\N
226	общаться	\N	\N	\N
227	без	\N	\N	\N
228	проблема	\N	\N	\N
229	сегодня	\N	\N	\N
230	кончить	\N	\N	\N
231	четыре	\N	\N	\N
232	пойти	\N	\N	\N
233	футбол	\N	\N	\N
234	конечно	\N	\N	\N
235	любить	\N	\N	\N
236	спорт	\N	\N	\N
237	встретиться	\N	\N	\N
238	метро	\N	\N	\N
239	Спортивная	\N	\N	\N
240	около	\N	\N	\N
241	выход	\N	\N	\N
242	стадион	\N	\N	\N
243	человек	\N	\N	\N
244	ваш	\N	\N	\N
245	семья	\N	\N	\N
246	четверо	\N	\N	\N
247	показывать	\N	\N	\N
248	фотография	\N	\N	\N
249	папа	\N	\N	\N
250	мама	\N	\N	\N
251	брат	\N	\N	\N
252	о	\N	\N	\N
253	похож	\N	\N	\N
254	часто	\N	\N	\N
255	похожий	\N	\N	\N
256	Валентин	\N	\N	\N
257	студент	\N	\N	\N
258	учиться	\N	\N	\N
259	Достоевский	\N	\N	\N
260	Братья Карамазовы	\N	\N	\N
261	найти	\N	\N	\N
262	смотреть	\N	\N	\N
263	сначала	\N	\N	\N
264	заполнить	\N	\N	\N
265	бланк	\N	\N	\N
266	можно	\N	\N	\N
267	вписать	\N	\N	\N
268	карандаш	\N	\N	\N
269	ручка	\N	\N	\N
270	лучше	\N	\N	\N
271	один	\N	\N	\N
272	минута	\N	\N	\N
273	по-английски	\N	\N	\N
274	спрашивать	\N	\N	\N
275	учёный	\N	\N	\N
276	приехать	\N	\N	\N
277	международный	\N	\N	\N
278	конференция	\N	\N	\N
279	гид-переводчик	\N	\N	\N
280	заболеть	\N	\N	\N
281	искать	\N	\N	\N
282	кто-нибудь	\N	\N	\N
284	помочь	\N	\N	\N
285	ты	\N	\N	\N
286	среди	\N	\N	\N
287	твой	\N	\N	\N
288	подруга	\N	\N	\N
289	переводить	\N	\N	\N
290	письменный	\N	\N	\N
291	перевод	\N	\N	\N
292	захотеть	\N	\N	\N
293	сам	\N	\N	\N
294	спросить	\N	\N	\N
295	она	\N	\N	\N
296	её	\N	\N	\N
297	забыть	\N	\N	\N
298	книжка	\N	\N	\N
299	дома	\N	\N	\N
300	заранее	\N	\N	\N
301	есть(быть)	\N	\N	\N
302	сегодняшний	\N	\N	\N
303	концерт	\N	\N	\N
304	остаться	\N	\N	\N
305	только	\N	\N	\N
306	второй	\N	\N	\N
307	ярус	\N	\N	\N
308	место	\N	\N	\N
309	схема	\N	\N	\N
310	театр	\N	\N	\N
311	третий	\N	\N	\N
312	ряд	\N	\N	\N
313	семнадцатый	\N	\N	\N
314	восемнадцатый	\N	\N	\N
315	девятнадцатый	\N	\N	\N
316	двадцатый	\N	\N	\N
317	и	\N	\N	\N
318	четвёртый	\N	\N	\N
319	пятый	\N	\N	\N
320	шестой	\N	\N	\N
321	русско-английский	\N	\N	\N
322	начать	\N	\N	\N
323	молодец	\N	\N	\N
324	летом	\N	\N	\N
325	девушка	\N	\N	\N
326	переписываться	\N	\N	\N
327	изучать	\N	\N	\N
328	знание	\N	\N	\N
329	открывать	\N	\N	\N
330	люди	\N	\N	\N
331	разный	\N	\N	\N
332	страна	\N	\N	\N
333	действительно	\N	\N	\N
334	постоянно	\N	\N	\N
335	иностранный	\N	\N	\N
336	носитель	\N	\N	\N
337	самый	\N	\N	\N
338	лучший	\N	\N	\N
339	метод	\N	\N	\N
340	изучение	\N	\N	\N
341	скромный	\N	\N	\N
342	серьёзный	\N	\N	\N
343	чтобы	\N	\N	\N
344	Толстой	\N	\N	\N
345	Анна Каренина	\N	\N	\N
346	конец	\N	\N	\N
347	прочитать	\N	\N	\N
348	несколько	\N	\N	\N
349	раз	\N	\N	\N
350	слишком	\N	\N	\N
351	скучно	\N	\N	\N
352	хотя	\N	\N	\N
353	интересно	\N	\N	\N
354	всегда	\N	\N	\N
355	любовь	\N	\N	\N
356	важный	\N	\N	\N
357	классика	\N	\N	\N
358	наш	\N	\N	\N
359	город	\N	\N	\N
360	воздух	\N	\N	\N
361	чистый	\N	\N	\N
362	еда	\N	\N	\N
363	вкусный	\N	\N	\N
364	главное	\N	\N	\N
365	тёплый	\N	\N	\N
366	пробовать	\N	\N	\N
367	яблоко	\N	\N	\N
368	известный	\N	\N	\N
369	каждый	\N	\N	\N
370	погода	\N	\N	\N
371	голубой	\N	\N	\N
372	небо	\N	\N	\N
373	погулять	\N	\N	\N
374	парк	\N	\N	\N
375	гулять	\N	\N	\N
376	извинить	\N	\N	\N
377	хотеться	\N	\N	\N
378	спать	\N	\N	\N
379	три	\N	\N	\N
380	почему-то	\N	\N	\N
381	спаться	\N	\N	\N
382	теперь	\N	\N	\N
383	домой	\N	\N	\N
384	поспать	\N	\N	\N
385	оправдаться	\N	\N	\N
386	пользоваться	\N	\N	\N
387	послать	\N	\N	\N
388	электронный	\N	\N	\N
389	письмо	\N	\N	\N
390	рубеж	\N	\N	\N
391	включить	\N	\N	\N
392	нажать	\N	\N	\N
393	кнопка	\N	\N	\N
394	немного	\N	\N	\N
395	подождать	\N	\N	\N
396	потом	\N	\N	\N
397	дважды	\N	\N	\N
398	щёлкнуть	\N	\N	\N
399	значок	\N	\N	\N
400	щёлкать	\N	\N	\N
401	запускаться	\N	\N	\N
402	программа	\N	\N	\N
403	для	\N	\N	\N
404	почта	\N	\N	\N
405	через	\N	\N	\N
406	Интернет	\N	\N	\N
407	группа	\N	\N	\N
408	что-то	\N	\N	\N
409	давно	\N	\N	\N
410	видно	\N	\N	\N
411	с	\N	\N	\N
412	поехать	\N	\N	\N
413	США	\N	\N	\N
414	вернуться	\N	\N	\N
415	десять	\N	\N	\N
416	ах	\N	\N	\N
417	вот как	\N	\N	\N
418	потому что	\N	\N	\N
419	американка	\N	\N	\N
420	кино	\N	\N	\N
421	испортиться	\N	\N	\N
422	дождь	\N	\N	\N
423	радио	\N	\N	\N
424	правда	\N	\N	\N
425	дача	\N	\N	\N
426	собирать	\N	\N	\N
427	гриб	\N	\N	\N
428	ягод	\N	\N	\N
429	пить	\N	\N	\N
430	что-нибудь	\N	\N	\N
431	меню	\N	\N	\N
432	заказать	\N	\N	\N
433	вино	\N	\N	\N
434	больше	\N	\N	\N
435	алкогольный	\N	\N	\N
436	напиток	\N	\N	\N
437	пиво	\N	\N	\N
438	водка	\N	\N	\N
439	особенно	\N	\N	\N
440	выбрать	\N	\N	\N
441	грузинский	\N	\N	\N
442	давай	\N	\N	\N
443	более	\N	\N	\N
444	ароматный	\N	\N	\N
445	удовольствие	\N	\N	\N
446	Третьяковка	\N	\N	\N
447	начинаться	\N	\N	\N
448	фильм	\N	\N	\N
449	музей	\N	\N	\N
450	語彙項目の辞書記載形	\N	\N	\N
451	простудиться	\N	\N	\N
452	у	\N	\N	\N
453	высокий	\N	\N	\N
454	температура	\N	\N	\N
455	выздороветь	\N	\N	\N
456	простуда	\N	\N	\N
457	здоровый	\N	\N	\N
458	врач	\N	\N	\N
459	принять	\N	\N	\N
460	лекарство	\N	\N	\N
461	встреча	\N	\N	\N
462	войти	\N	\N	\N
463	просьба	\N	\N	\N
464	написать	\N	\N	\N
465	тезис	\N	\N	\N
466	последний	\N	\N	\N
467	исправить	\N	\N	\N
468	они	\N	\N	\N
469	принести	\N	\N	\N
470	следующий	\N	\N	\N
471	среда	\N	\N	\N
472	видеться	\N	\N	\N
473	только что	\N	\N	\N
474	куда	\N	\N	\N
475	ездить	\N	\N	\N
476	западная	\N	\N	\N
477	Европа	\N	\N	\N
478	Франция	\N	\N	\N
479	Италия	\N	\N	\N
480	Париж	\N	\N	\N
481	снять	\N	\N	\N
482	много	\N	\N	\N
483	например	\N	\N	\N
484	триумфальная	\N	\N	\N
485	арка	\N	\N	\N
486	Эйфелева башня	\N	\N	\N
487	шоколадка	\N	\N	\N
488	октябрь	\N	\N	\N
489	ребёнок	\N	\N	\N
490	тоже	\N	\N	\N
491	шоколад	\N	\N	\N
492	президент	\N	\N	\N
493	ладно	\N	\N	\N
494	чем	\N	\N	\N
495	ничего	\N	\N	\N
496	взять	\N	\N	\N
497	копия	\N	\N	\N
498	нужно	\N	\N	\N
499	уточнить	\N	\N	\N
500	суббота	\N	\N	\N
501	нужный	\N	\N	\N
502	замечание	\N	\N	\N
503	пятница	\N	\N	\N
504	после	\N	\N	\N
505	обед	\N	\N	\N
506	доктор	\N	\N	\N
507	здравствуйте	\N	\N	\N
508	жаловаться	\N	\N	\N
509	болеть	\N	\N	\N
510	живот	\N	\N	\N
511	плохо	\N	\N	\N
512	таблетка	\N	\N	\N
513	желудок	\N	\N	\N
514	нельзя	\N	\N	\N
515	ничто	\N	\N	\N
516	острый	\N	\N	\N
517	холодный	\N	\N	\N
518	комната	\N	\N	\N
519	душно	\N	\N	\N
520	открыть	\N	\N	\N
521	окно	\N	\N	\N
522	передавать	\N	\N	\N
523	спасибо 	\N	\N	\N
524	мешать	\N	\N	\N
525	стесниться	\N	\N	\N
526	вкусно	\N	\N	\N
527	начаться	\N	\N	\N
528	больной	\N	\N	\N
529	может быть	\N	\N	\N
530	сдать	\N	\N	\N
531	сдавать	\N	\N	\N
532	слышать	\N	\N	\N
533	обстоятельство	\N	\N	\N
534	измениться	\N	\N	\N
535	некогда	\N	\N	\N
536	решить	\N	\N	\N
537	заставлять	\N	\N	\N
538	алло	\N	\N	\N
539	аллё	\N	\N	\N
540	пригласить	\N	\N	\N
541	сестра	\N	\N	\N
542	воскресенье	\N	\N	\N
543	есть, быть	\N	\N	\N
544	план	\N	\N	\N
545	слово	\N	\N	\N
546	больше, много	\N	\N	\N
547	советовать	\N	\N	\N
548	культура	\N	\N	\N
549	история	\N	\N	\N
550	литература	\N	\N	\N
551	урок	\N	\N	\N
552	английский	\N	\N	\N
553	язык	\N	\N	\N
554	тетрадь	\N	\N	\N
555	опять	\N	\N	\N
556	заснуть	\N	\N	\N
557	сердиться	\N	\N	\N
558	благодарный	\N	\N	\N
559	просто	\N	\N	\N
560	добро（成句）	\N	\N	\N
561	долететь	\N	\N	\N
562	отлично	\N	\N	\N
563	устать	\N	\N	\N
564	отдохнуть	\N	\N	\N
565	гостиница	\N	\N	\N
566	выспаться	\N	\N	\N
567	вспомнить	\N	\N	\N
568	посетить	\N	\N	\N
569	кроме	\N	\N	\N
570	Казань	\N	\N	\N
572	родители	\N	\N	\N
573	ужинать	\N	\N	\N
574	дело（成句）	\N	\N	\N
575	ресторан	\N	\N	\N
576	дорогой	\N	\N	\N
577	разрешить	\N	\N	\N
578	представить	\N	\N	\N
579	представиться	\N	\N	\N
580	Петербург	\N	\N	\N
581	бабушка	\N	\N	\N
582	факультет	\N	\N	\N
583	филологический	\N	\N	\N
584	отделение	\N	\N	\N
585	славянский	\N	\N	\N
586	курс	\N	\N	\N
587	вопрос	\N	\N	\N
588	ездить	1	Е	601
589	английский язык	1	А	106
590	самолёт	1	С	1805
591	заграница	1	З	804
592	иностранец	1	И	907
593	французский язык	1	Ф	2105
594	гостиница	1	Г	414
595	японский язык	1	Я	2907
596	выходить	1	В	342
597	страна	1	С	1855
598	встретить	1	В	333
599	каникулы	1	К	1108
600	поездка	1	П	1631
601	путешествовать	1	П	1671
602	играть	1	И	901
603	посольство	1	П	1651
604	любить	1	Л	1213
605	нравиться	\N	Н	\N
606	хорошо	1	Х	2208
607	бегать	1	Б	205
608	медленно	1	М	1314
609	плохо	1	П	1623
610	ходить	1	Х	2203
611	плавать	1	П	1620
612	быстрый	1	Б	223
613	летать	1	Л	1205
614	спорт	1	С	1838
615	ненавидеть	1	Н	1412
616	бассейн	1	Б	204
617	автобус	1	А	102
618	велосипед	1	В	304
619	перекрёсток	1	П	1609
620	дорога	1	Д	522
621	пруд	1	П	1669
622	прогулка	1	П	1660
623	река	1	Р	1707
624	такси	1	Т	1903
625	машина	1	М	1313
626	поворачивать	1	П	1625
627	галстук	1	Г	403
628	рубашка	1	Р	1712
629	фирма	1	Ф	2102
630	пиджак	0	П	\N
631	делать	1	Д	510
632	впитывать	1	В	327
633	телефон	1	Т	1909
634	работа	1	Р	1701
635	работать	1	Р	1702
636	занятый	1	З	806
637	библиотека	1	Б	207
638	словарь	1	С	1831
639	брать	1	Б	219
640	газета	1	Г	401
641	читать	1	Ч	2416
642	книга	1	К	1123
643	копирование	1	К	1130
644	копировать	1	К	1131
646	том	1	Т	1920
647	говядина	1	Г	409
648	дешёвый	1	Д	515
649	магазин	1	М	1301
650	дорогой	1	Д	523
651	сколько	1	С	1821
652	сколько	0	С	\N
653	фрукт	1	Ф	2106
654	овощь	1	О	1504
655	рыба	1	Р	1720
656	свинина	1	С	1809
657	курица	1	К	1143
658	мясо	1	М	1329
659	хотеть	1	Х	2209
660	передавать	1	П	1608
661	овощной магазин	1	О	1503
662	ключ	1	К	1122
663	блюдо	1	Б	212
664	покупать	1	П	1643
665	стирать	1	С	1850
666	убирать	1	У	2002
667	семья	1	С	1813
668	семья	0	С	\N
669	сад	1	С	1801
670	стирка	1	С	1852
671	дом	0	Д	\N
672	дом	1	Д	519
673	уборка	1	У	2003
674	возвращаться	1	В	320
675	книжная полка	1	К	1124
676	письменный стол	1	П	1616
677	стул	1	С	1857
678	комната	1	К	1126
679	холодильник	1	Х	2204
680	мыть	1	М	1328
681	кровать	1	К	1139
682	радио	1	Р	1704
683	магнитола	1	М	1302
684	меня зовут ～	1	М	1315
685	ложиться спать	1	Л	1211
686	вставать	1	В	331
687	стол	1	С	1853
688	телевизор	1	Т	1908
689	полицейский	0	П	\N
690	полицейский	1	П	1647
691	карта	1	К	1112
692	у	1	У	2001
693	здесь	1	З	809
694	там	0	Т	\N
695	там	1	Т	1904
696	где	1	Г	404
697	полицейская будка	1	П	1646
698	близко	1	Б	211
699	рядом	0	Р	\N
700	спрашивать	1	С	1839
701	подстригать	1	П	1629
702	короткий	1	К	1134
705	направо	1	Н	1408
706	налево	1	Н	1406
707	длинный	1	Д	516
708	садиться	1	С	1802
709	встать	1	В	332
710	друг	1	Д	524
711	класс	1	К	1119
712	класс	0	К	\N
713	коридор	1	К	1132
714	школа	1	Ш	2502
715	ученик	1	У	2018
716	учёба	1	У	2017
717	студент	1	С	1856
718	иностранный студент	1	И	908
719	летние каникулы	1	Л	1206
720	учитель	1	У	2019
721	университет	1	У	2011
722	тетрадь	1	Т	1914
723	урок	1	У	2014
724	сочинение	1	С	1837
725	домашнее задание	1	Д	521
726	трудный	1	Т	1925
727	учить	1	У	2020
728	проверочная работа	1	П	1659
729	упражнение	1	У	2012
730	лёгкий	0	Л	\N
731	упражняться	1	У	2013
732	вопрос	0	В	\N
733	вопрос	1	В	321
734	отвечать	1	О	1519
735	болеть	1	Б	215
736	зуб	1	З	815
737	врач	1	В	328
738	больница	1	Б	216
739	болезнь	1	Б	214
740	лекарство	1	Л	1203
741	умирать	1	У	2009
742	простуда	1	П	1663
743	голова	1	Г	411
744	живот	1	Ж	706
745	градус	1	Г	415
746	лифт	1	Л	1209
747	билет	1	Б	208
748	выходить	0	С	\N
749	лестница	1	Л	1204
750	закрыть	1	З	805
751	станция	1	С	1843
752	метро	1	М	1318
753	садиться	0	С	\N
754	открывать	1	О	1524
755	туалет	0	Т	\N
756	туалет	1	Т	1926
757	поезд	1	П	1630
758	напиток	1	Н	1407
759	кофе	1	К	1136
760	кафе	1	К	1115
761	лимон	1	Л	1208
762	молоко	1	М	1323
763	сахар	1	С	1806
764	чашка	1	Ч	2408
765	зелёный чай	1	З	811
766	чай	1	Ч	2401
767	стакан	1	С	1842
768	класть	1	К	1121
769	сладкий	1	С	1826
770	пить	1	П	1618
771	палочки	1	П	1601
772	алкоголь	1	А	104
773	вкусно	1	В	318
774	нож	1	Н	1421
775	ложка	1	Л	1212
776	вилка	1	В	316
777	сыр	1	С	1861
778	есть	1	Е	603
779	невкусный	1	Н	1410
780	хлеб	1	Х	2202
781	острый	1	О	1518
782	ресторан	1	Р	1708
783	столовая	1	С	1854
784	вино	1	В	317
785	пища	1	П	1619
786	карри	1	К	1111
787	деньги	1	Д	513
788	банк	1	Б	203
789	вход	1	В	336
790	пожалуйста	1	П	1633
791	нет	1	Н	1413
792	да	1	Д	501
793	извините	1	И	905
794	пожалуйста	0	П	\N
795	выход	1	В	341
796	приезжать	1	П	1656
797	почтовый ящик	1	П	1653
798	открытка	1	О	1525
799	наклеивать	1	Н	1405
800	конверт	1	К	1128
801	письмо	1	П	1617
802	почта	1	П	1652
803	отдавать	1	О	1520
804	опускать	1	О	1516
805	марка	1	М	1308
806	багаж	1	Б	202
807	экземпляр	1	Э	2702
808	одалживать	1	О	1505
809	покупать	\N	П	\N
810	головной убор	1	Г	412
811	обувь	1	О	1502
812	покупка	1	П	1645
813	этаж	1	Э	2704
814	универмаг	1	У	2010
815	юбка	1	Ю	2801
816	пальто	1	П	1602
817	брюки	1	Б	220
818	свитер	1	С	1810
819	пожалуйста	0	П	\N
820	сумка	1	С	1859
821	продавать	1	П	1661
822	пиджак	1	П	1613
823	ванная	1	В	303
824	здание	1	З	808
825	кухня	1	К	1144
826	душ	1	Д	525
827	окно	1	О	1510
828	жить	1	Ж	707
829	парк	1	П	1603
830	дверь	0	Д	\N
831	принимать душ/ванну	1	П	1657
832	квартира	1	К	1116
833	прихожая	1	П	1658
834	он / она	1	О	1512
835	они	1	О	1514
836	я	1	Я	2901
837	мы	1	М	1327
838	кто-то	1	К	1142
839	кто	1	К	1140
840	кто	0	К	\N
841	ты	1	Т	1928
842	вы	1	В	339
843	этот	1	Э	2705
844	тот	1	Т	1923
845	как	1	К	1104
846	который	1	К	1135
847	какой	1	К	1106
848	такой	1	Т	1902
849	сам	1	С	1804
850	так	1	Т	1901
851	толстый	0	Т	\N
852	узкий	1	У	2008
853	тонкий	0	Т	\N
854	большой	1	Б	217
855	толстый	1	Т	1918
856	молодой	1	М	1322
857	широкий	1	Ш	2501
858	лёгкий	1	Л	1201
859	далёкий	1	Д	503
860	тяжёлый	1	Т	1930
861	тонкий	1	Т	1921
862	новый	1	Н	1418
863	маленький	0	М	\N
864	близкий	1	Б	209
865	старый	1	С	1848
866	весёлый	0	В	\N
867	весёлый	1	В	305
868	низкий	1	Н	1417
869	хороший	1	Х	2207
870	светлый	1	С	1807
871	слабый	1	С	1825
872	сильный	1	С	1819
873	интересный	1	И	909
874	красивый	1	К	1137
875	поздний	1	П	1640
876	плохой	1	П	1624
877	многие	1	М	1320
878	тёмный	0	Т	\N
879	тихий	1	Т	1916
880	маленький	1	М	1305
881	грязный	1	Г	416
882	скучный	1	С	1824
883	рядом	1	Р	1722
884		\N		\N
885		\N		\N
886	восток	1	В	325
887	высота	1	В	340
888		\N		\N
889	север	1	С	1811
890	запад	1	З	807
891		\N		\N
892	юг	1	Ю	2802
899	бабушка	1	Б	201
900	дедушка	1	Д	508
904	родители	1	Р	1710
905	отец	0	О	\N
906	старшая сестра	1	С	1844
907	сестра	1	С	1816
908	тётя	1	Т	1915
909	старший брат	0	С	\N
910	старшая сестра	0	С	\N
911	отец	1	О	1522
912	мать	1	М	1311
913	носки	1	Н	1424
914	нижнее бельё	1	Н	1416
915	снимать	1	С	1834
916	вешать	1	В	314
917	надевать	1	Н	1403
918	одеваться	1	О	1507
919	надеть	1	Н	1404
920	носовой платок	1	Н	1425
921	тапочки	1	Т	1906
922	зонт	1	З	814
923	карман	1	К	1110
924	бумажник	1	Б	222
925	носить	1	Н	1423
926	одежда	1	О	1508
928	рот	1	Р	1711
929	рука	0	Р	\N
930	тело	1	Т	1910
931	лицо	1	Л	1210
932	нога	1	Н	1419
933	рука	1	Р	1713
934	нос	1	Н	1422
935	глаз	1	Г	406
936	ухо	1	У	2016
937	нога	0	Н	\N
938	живот	\N	Ж	\N
939	тарелка	1	Т	1907
940	масло	1	М	1310
941	чашка	0	М	\N
942	конфета	1	К	1129
943	обед	1	О	1501
944	ужин	0	У	\N
945	сладость	1	С	1827
946	яйцо	1	Я	2905
947	завтрак	1	З	803
948	варёный рис	0	В	\N
949	соевый соус	1	С	1835
950	соль	1	С	1836
951	ужин	1	У	2006
952	прибавлять	1	П	1655
953	подсоединять	1	П	1628
954	фотоаппарат	1	Ф	2103
955	печь	1	П	1612
956	карандаш	1	К	1109
957	стирать	0	С	\N
958	очки	1	О	1526
959	магнитофон	1	М	1303
960	часы	1	Ч	2407
961	компьютер	1	К	1127
962	плёнка	1	П	1622
963	дверь	1	Д	504
964	ворота	1	В	323
965	ручка	0	Р	\N
966	авторучка	1	А	103
967	ручка	1	Р	1718
968	август	1	А	101
969	апрель	1	А	107
970	этот месяц	1	Э	2708
971	каждый месяц	1	К	1103
972	декабрь	1	Д	509
973	февраль	1	Ф	2101
974	январь	1	Я	2906
975	июль	1	И	910
976	июнь	1	И	911
977	следующий месяц	1	С	1830
978	май	1	М	1304
979	март	1	М	1309
980	прошлый месяц	1	П	1667
981	ноябрь	1	Н	1427
982	октябрь	1	О	1511
983	сентябрь	1	С	1815
984	месяц	1	М	1317
985	эта неделя	1	Э	2703
986	каждая неделя	1	К	1101
987	воскресенье	1	В	324
988	четверг	1	Ч	2415
989	следующая неделя	1	С	1828
990	понедельник	1	П	1649
991	вторник	1	В	335
992	среда	1	С	1841
993	суббота	1	С	1858
995	прошлая неделя	1	П	1665
996	пятница	1	П	1672
997	год	1	Г	410
998	осень	1	О	1517
999	этот год	1	Э	2707
1000	каждый год	1	К	1102
1001	лето	1	Л	1207
1002	зима	1	З	812
1003	прошлый год	1	П	1666
1004	следующий год	1	С	1829
1005	весна	1	В	307
1007	позапрошлый год	1	П	1639
1008	вторая половина дня	1	В	334
1009	сегодня	1	С	1812
1010	завтра	1	З	802
1011	час	1	Ч	2402
1012	вчера	1	В	337
1013	вчера вечером	1	В	338
1014	первая половина дня	1	П	1606
1015	утро	1	У	2015
1016	день	1	Д	512
1017	ночь	1	Н	1426
1018	вечер	1	В	311
1019	послезавтра	1	П	1650
1020	позавчера	1	П	1638
1021	уже	1	У	2005
1022	注）	\N		\N
1023	ещё	1	Е	605
1024	весь	1	В	308
1032	песня	1	П	1610
1033	петь	1	П	1611
1034	сигарета	1	С	1818
1035	кино	1	К	1117
1036	пластинка	1	П	1621
1037	гитара	1	Г	405
1038	играть	0	И	\N
1039	музыка	1	М	1326
1040	картина	1	К	1113
1041	фотография	1	Ф	2104
1042	нравиться	1	Н	1428
1043	голос	1	Г	413
1044	ясная погода	1	Я	2909
1045	жаркий	1	Ж	701
1046	проясняться	1	П	1668
1047	прохладный	1	П	1664
1048	холодный	0	Х	\N
1049	снег	1	С	1833
1050	идёт дождь	1	И	903
1051	дождь	1	Д	517
1052	погода	1	П	1626
1053	тёплый	1	Т	1913
1054	ветер	1	В	310
1055	пасмурная погода	1	П	1604
1056	холодный	1	Х	2205
1057	покрываться облаками 	1	П	1642
1058	китайский иероглиф	1	К	1118
1059	говорить	0	Г	\N
1060	писать	1	П	1615
1061	разговор	1	Р	1705
1062	язык	0	Я	\N
1063	язык	1	Я	2902
1064	слово	1	С	1832
1065	говорить	1	Г	407
1066	предложение	1	П	1654
1067	рассказывать	1	Р	1706
1068	значение	1	З	813
1071	взрослый	1	В	315
1072	много народу	1	М	1321
1073	супруги	1	С	1860
1074	дети	1	Д	514
1075	жена	1	Ж	703
1076	женщина	1	Ж	705
1077	мальчик	1	М	1307
1078	человек	0	Ч	\N
1079	мужчина	1	М	1325
1080	девочка	1	Д	507
1081	муж	1	М	1324
1082	человек	1	Ч	2410
1083	все	1	В	330
1084	белый	1	Б	206
1085	синий	1	С	1820
1086	коричневый	1	К	1133
1087	светлый	0	С	\N
1088	цвет	1	Ц	2301
1089	тёмный	1	Т	1911
1090	жёлтый	1	Ж	702
1091	чёрный	1	Ч	2413
1092	красный	1	К	1138
1093	зелёный	1	З	810
1094	удобный	1	У	2004
1095	вечер	0	В	\N
1096	бумага	1	Б	221
1097	статься	1	С	1849
1098	сжимать	1	С	1817
1099	толкать	1	Т	1917
1100	начинаться	1	Н	1409
1101	ровно	1	Р	1709
1102	нет	0	Н	\N
1103		\N		\N
1104	известный	1	И	904
1105	бодрый	1	Б	213
1106	ну	1	Н	1431
1107	наверное	1	Н	1402
1108	пока	1	П	1641
1110	русский язык	1	Р	1715
1111	ёлка	1	Ё	602
1112	йогурт	1	Й	1001
1113	щека	1	Щ	2601
1114	экзамен	1	Э	2701
1115	через два года	1	Ч	2412
1116	вне	1	В	319
1117	продольный	1	П	1662
1118	внизу	\N	В	\N
1119	под	1	П	1627
1120	на	1	Н	1401
1121	перед	1	П	1607
1122	впереди	1	В	326
1124	прямой	1	П	1670
1125	хирагана	1	Х	2201
1126	катакана	1	К	1114
1127	-	1	-	\N
1128	миска	1	М	1319
703		0		\N
704		0		\N
893		0		\N
894		0		\N
895		0		\N
927		0		\N
994	конец недели	0	К	\N
1006	▲через два года	0		\N
1069	▲	0		\N
1070	▲	0		\N
1109		0		\N
1123	позади	0	П	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: ru
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
416	Ах	ああ	間投詞	\N	\N	\N	538	\N
417	вот как	なるほど・そうだったのか		\N	\N	\N	538	\N
80	так	そんなに・それほど	副詞	\N	\N	\N	539	\N
7	хорошо	上手に	副詞	\N	\N	\N	539	\N
220	говорит	話す	動詞	\N	\N	\N	539	\N
273	по-английски	英語で	副詞	\N	\N	\N	539	\N
47	знаешь	知っている	動詞	\N	\N	\N	540	\N
68	очень	とても	副詞	\N	\N	\N	541	\N
7	хорошо	上手に	副詞	\N	\N	\N	541	\N
220	говорит	話す	動詞	\N	\N	\N	541	\N
273	по-английски	英語で	副詞	\N	\N	\N	541	\N
418	Потому что	なぜならば	接続詞	\N	\N	\N	542	\N
250	мама	お母さん	名詞	\N	\N	\N	542	\N
419	американка	アメリカ人(女性)	名詞	\N	\N	\N	542	\N
189	делать	する	動詞	\N	\N	\N	543	\N
232	Пойду	行く、出かける	動詞	\N	\N	\N	544	\N
420	кино	映画館	名詞	\N	\N	\N	544	\N
421	испортится	崩れる、悪くなる、そこなわれる	動詞	\N	\N	\N	545	\N
370	погода	天気	名詞	\N	\N	\N	545	\N
422	дождь	雨	名詞	\N	\N	\N	545	\N
423	радио	ラジオ	名詞	\N	\N	\N	545	\N
424	Правда	本当	間投詞	\N	\N	\N	546	\N
144	Если	もし～なら	接続詞	\N	\N	\N	547	\N
172	читать	読書する	動詞	\N	\N	\N	548	\N
299	дома	家で、家に	副詞	\N	\N	\N	548	\N
8	А	ところで、それに対して	接続詞	\N	\N	\N	549	\N
412	поеду	（乗り物で）行く、出かける	動詞	\N	\N	\N	550	\N
245	семьёй	家族	名詞	\N	\N	\N	550	\N
425	дачу	ダーチャ、別荘	名詞	\N	\N	\N	550	\N
426	Собирать	集める、収集する、採取する	動詞	\N	\N	\N	551	\N
427	грибы	キノコ	名詞	\N	\N	\N	551	\N
428	ягоды	ベリー類	名詞	\N	\N	\N	551	\N
429	будешь ... питьでの形	飲む	動詞	\N	\N	\N	552	\N
430	что-нибудь	(不特定の)何か	(不定)代名詞	\N	\N	\N	552	\N
104	Вот	(目前のものをさして)ほら	助詞	\N	\N	\N	553	\N
431	меню	メニュー	名詞	\N	\N	\N	553	\N
80	Так	さて	接続詞	\N	\N	\N	554	\N
61	Давай	～しよう	動詞	\N	\N	\N	555	\N
432	закажем	注文する	動詞	\N	\N	\N	555	\N
433	вино	ワイン	名詞	\N	\N	\N	555	\N
235	любишь	好きである	動詞	\N	\N	\N	556	\N
49	белое	白い	形容詞	\N	\N	\N	556	\N
433	вино	ワイン	名詞	\N	\N	\N	556	\N
235	люблю	好きである	動詞	\N	\N	\N	557	\N
29	но	しかし	接続詞	\N	\N	\N	557	\N
109	красное	赤い	形容詞	\N	\N	\N	557	\N
434	больше	より多く	副詞	\N	\N	\N	557	\N
54	Тогда	それなら	副詞	\N	\N	\N	558	\N
432	закажем	注文する	動詞	\N	\N	\N	558	\N
109	красное	赤い	形容詞	\N	\N	\N	558	\N
235	любишь	好きである	動詞	\N	\N	\N	559	\N
109	красное	赤い	形容詞	\N	\N	\N	559	\N
433	вино	ワイン	名詞	\N	\N	\N	559	\N
434	больше	より多く	副詞	\N	\N	\N	559	\N
14	всего	何よりも	代名詞	\N	\N	\N	559	\N
337	самый	もっとも・一番	代名詞	\N	\N	\N	560	\N
179	любимый	愛する	形容詞	\N	\N	\N	560	\N
435	алкогольный	アルコールの	語彙項目の品詞	\N	\N	\N	560	\N
436	напиток	飲みもの	名詞	\N	\N	\N	560	\N
8	А	ところで	接続詞	\N	\N	\N	561	\N
11	что	何	代名詞	\N	\N	\N	561	\N
235	любишь	好きである	動詞	\N	\N	\N	561	\N
235	люблю	好きである	動詞	\N	\N	\N	562	\N
437	пиво	ビール	名詞	\N	\N	\N	562	\N
433	вино	ワイン	名詞	\N	\N	\N	562	\N
438	водку	ウォッカ	名詞	\N	\N	\N	562	\N
140	Из	～の中から	前置詞	\N	\N	\N	563	\N
439	особенно	とくに	副詞	\N	\N	\N	563	\N
438	водку	ウォッカ	名詞	\N	\N	\N	563	\N
382	теперь	それでは	副詞	\N	\N	\N	564	\N
440	выбери	選択する	動詞	\N	\N	\N	564	\N
441	грузинское	グルジア(産)の	形容詞	\N	\N	\N	564	\N
433	вино	ワイン	名詞	\N	\N	\N	564	\N
118	французское	フランス(産)の	形容詞	\N	\N	\N	564	\N
442	Давай	～しよう	動詞	\N	\N	\N	565	\N
441	грузинское	グルジア(産)の	形容詞	\N	\N	\N	565	\N
418	Потому что	なぜならば	接続詞	\N	\N	\N	566	\N
441	грузинское	グルジア(産)の	形容詞	\N	\N	\N	566	\N
443	более	より・さらに	副詞	\N	\N	\N	566	\N
444	ароматное	匂いのよい・芳しい	形容詞	\N	\N	\N	566	\N
195	свободна	暇な、空いている、自由な	形容詞	\N	\N	\N	567	\N
232	пойдём	行く、出かける	動詞	\N	\N	\N	568	\N
195	свободна	暇な、空いている、自由な 	形容詞	\N	\N	\N	569	\N
445	удовольствием	喜び	名詞	\N	\N	\N	570	\N
446	Третьяковку	トレチャコフ美術館（Третьяковская галереяの愛称・略称）	名詞	\N	\N	\N	571	\N
447	начинается	始まる	動詞	\N	\N	\N	572	\N
448	фильм	映画	名詞	\N	\N	\N	572	\N
149	часов	～時	名詞	\N	\N	\N	573	\N
449	музей	美術館	名詞	\N	\N	\N	574	\N
263	сначала	はじめに、最初に	副詞	\N	\N	\N	574	\N
450	語彙項目の文中での形	語彙項目の文中での意味	語彙項目の品詞	\N	\N	\N	575	\N
148	котором	何番目の、いくつめの	疑問形容詞	\N	\N	\N	576	\N
149	часу	～時	語彙項目の品詞	\N	\N	\N	576	\N
237	встретимся	会う	動詞	\N	\N	\N	576	\N
13	вчера	昨日	副詞	\N	\N	\N	577	\N
31	было	いる		\N	\N	\N	577	\N
38	занятии	授業	名詞	\N	\N	\N	577	\N
46	да	(同意を求めて)そうですね	助詞	\N	\N	\N	577	\N
376	извините	ごめんなさい	動詞	\N	\N	\N	578	\N
133	Почему	なぜ	副詞	\N	\N	\N	579	\N
31	было	いる		\N	\N	\N	579	\N
418	Потому что	なぜならば	接続詞	\N	\N	\N	580	\N
451	простудилась	風邪をひく	動詞	\N	\N	\N	580	\N
452	У	～のもとで・～のところでは	前置詞	\N	\N	\N	581	\N
31	была	ある・いる		\N	\N	\N	581	\N
453	высокая	高い	形容詞	\N	\N	\N	581	\N
454	температура	熱	名詞	\N	\N	\N	581	\N
31	Было	ある		\N	\N	\N	582	\N
39	Понятно	わかった・いいです	副詞	\N	\N	\N	583	\N
229	сегодня	今日	副詞	\N	\N	\N	584	\N
455	выздоровела	回復する・全快する	動詞	\N	\N	\N	584	\N
456	Простуда	風邪	名詞	\N	\N	\N	585	\N
103	прошла	通り過ぎる	動詞	\N	\N	\N	585	\N
217	совсем	すっかり	副詞	\N	\N	\N	586	\N
457	здорова	健康な	形容詞	\N	\N	\N	586	\N
13	Вчера	昨日	副詞	\N	\N	\N	587	\N
31	была	行く		\N	\N	\N	587	\N
452	у	～のところに	前置詞	\N	\N	\N	587	\N
458	врача	医者	名詞	\N	\N	\N	587	\N
459	приняла	(薬などを)のむ	動詞	\N	\N	\N	587	\N
460	лекарство	薬	名詞	\N	\N	\N	587	\N
417	Вот как	なるほど・そうだったのか	(間投詞)	\N	\N	\N	588	\N
125	Ну	さあ	間投詞	\N	\N	\N	589	\N
14	всего	すべての	代名詞	\N	\N	\N	589	\N
116	хорошего	よい	形容詞	\N	\N	\N	589	\N
152	До	～まで	前置詞	\N	\N	\N	590	\N
461	встречи	出会い	名詞	\N	\N	\N	590	\N
266	Можно	～してよい	無人称述語	\N	\N	\N	591	\N
462	войти	入る	動詞	\N	\N	\N	591	\N
36	Пожалуйста	どうぞ	助詞	\N	\N	\N	592	\N
188	заняты	ふさがっている、忙しい	形容詞	\N	\N	\N	593	\N
463	просьба	願い、頼み、依頼	名詞	\N	\N	\N	594	\N
464	написал	書く、書き上げる	動詞	\N	\N	\N	595	\N
465	тезисы	要旨、骨組み、要点	名詞	\N	\N	\N	595	\N
466	последней	最近の、最新の	形容詞	\N	\N	\N	595	\N
28	статьи	論文	名詞	\N	\N	\N	595	\N
467	исправили	直す	動詞	\N	\N	\N	596	\N
468	их	それらを	人称代名詞	\N	\N	\N	596	\N
445	удовольствием	喜び	名詞	\N	\N	\N	597	\N
469	принести	持って来る、持って行く	動詞	\N	\N	\N	599	\N
470	следующую	次の	語彙項目の品詞	\N	\N	\N	599	\N
471	среду	水曜日	名詞	\N	\N	\N	599	\N
116	Хорошо	よい	形容詞	\N	\N	\N	600	\N
116	Хорошо	よい 	形容詞 	\N	\N	\N	601	\N
186	привет	あら	名詞	\N	\N	\N	602	\N
409	Давно	長い間	副詞	\N	\N	\N	603	\N
472	виделись	会う	動詞	\N	\N	\N	603	\N
186	привет	あら	名詞	\N	\N	\N	604	\N
473	только что	たったいま(～したばかり)	副詞	\N	\N	\N	605	\N
414	вернулся	帰る・戻る	動詞	\N	\N	\N	605	\N
140	из	～から	前置詞	\N	\N	\N	605	\N
222	поездки	(短期間の)旅行	名詞	\N	\N	\N	605	\N
474	Куда	どこへ	副詞	\N	\N	\N	606	\N
475	ездил	(繰り返し･さまざまな方向へ)乗り物で行く	動詞	\N	\N	\N	606	\N
476	Западная	西方の・西側の	形容詞	\N	\N	\N	607	\N
477	Европу	ヨーロッパ	固有名詞	\N	\N	\N	607	\N
478	Францию	フランス	固有名詞	\N	\N	\N	608	\N
479	Италию	イタリア	固有名詞	\N	\N	\N	608	\N
125	Ну	それで	間投詞	\N	\N	\N	609	\N
4	как	どうか・どのような状態か	副詞	\N	\N	\N	609	\N
353	Интересно	面白い	形容詞・短語尾中性形	\N	\N	\N	610	\N
31	было	(無人称文の過去を表す)		\N	\N	\N	610	\N
68	очень	とても	副詞	\N	\N	\N	611	\N
353	интересно	面白い	形容詞・短語尾中性形	\N	\N	\N	611	\N
480	Париж	パリ(フランスの首都)	固有名詞	\N	\N	\N	612	\N
439	особенно	特に	副詞	\N	\N	\N	612	\N
108	понравился	気に入る	動詞	\N	\N	\N	612	\N
481	снимал	撮影する	動詞	\N	\N	\N	613	\N
482	много	多くの・たくさんの	数詞	\N	\N	\N	613	\N
248	фотографий	写真	名詞	\N	\N	\N	613	\N
483	Например	例えば	挿入語	\N	\N	\N	614	\N
483	Например	例えば	挿入語	\N	\N	\N	615	\N
484	Триумфальную	凱旋の	形容詞	\N	\N	\N	615	\N
485	арку	アーチ	名詞	\N	\N	\N	615	\N
1	Здравствуйте	ごきげんよう、こんにちは	間投詞	\N	\N	\N	236	\N
2	Добрый	よい	形容詞	\N	\N	\N	237	\N
3	день	日・１日	名詞	\N	\N	\N	237	\N
4	Как	どのように	疑問（副）詞	\N	\N	\N	238	\N
5	поживаете	過ごす	動詞	\N	\N	\N	238	\N
6	Спасибо	ありがとう	間投詞	\N	\N	\N	239	\N
7	хорошо	（気分が）良い	述語副詞	\N	\N	\N	239	\N
8	А	ところで《対比を表わす》	接続詞	\N	\N	\N	240	\N
9	вы	あなたは	代名詞	\N	\N	\N	240	\N
10	неважно	（口語的）余り良くない、芳しくない	述語副詞	\N	\N	\N	241	\N
11	Что	何が	疑問詞	\N	\N	\N	242	\N
12	случилось	起きる	動詞	\N	\N	\N	242	\N
13	Вчера	昨日	副詞	\N	\N	\N	243	\N
14	все	全ての	代名詞	\N	\N	\N	243	\N
90	Нет	いいえ	助詞	\N	\N	\N	291	\N
15	данные	データ	名詞	\N	\N	\N	243	\N
17	компьютере	コンピューター内の	名詞	\N	\N	\N	243	\N
18	потерялись	無くなる、消える	動詞	\N	\N	\N	243	\N
9	Вы	あなたは、あなたが	人称代名詞	\N	\N	\N	244	\N
19	не	～ではない	助詞	\N	\N	\N	244	\N
20	копировали	（データの）バックアップを取る、バックアップする	動詞	\N	\N	\N	244	\N
14	все	すべての	定代名詞	\N	\N	\N	245	\N
21	Сочувствую	同情する・気の毒に思う	動詞	\N	\N	\N	246	\N
22	Здравствуйте	こんにちは	間投詞	\N	\N	\N	247	\N
2	Добрый	よい	形容詞	\N	\N	\N	248	\N
3	день	昼間・1日	名詞	\N	\N	\N	248	\N
23	есть	ある・いる	　　	\N	\N	\N	249	\N
24	время	時間	名詞	\N	\N	\N	249	\N
25	хотела	（+不定形で）～したい	動詞	\N	\N	\N	250	\N
26	бы	～したい	助詞	\N	\N	\N	250	\N
27	посоветоваться	相談する	動詞	\N	\N	\N	250	\N
28	статье	論文	名詞	\N	\N	\N	250	\N
7	хорошо	同意だ・よろしい	助詞	\N	\N	\N	251	\N
29	но	しかし・でも	接続詞	\N	\N	\N	251	\N
19	не	～でない	助詞	\N	\N	\N	251	\N
30	сейчас	今	副詞	\N	\N	\N	251	\N
31	будет	（未来に）ある		\N	\N	\N	252	\N
32	заседание	会議	名詞	\N	\N	\N	252	\N
33	Заходи	立ち寄る	動詞	\N	\N	\N	253	\N
34	кабинет	研究室	名詞	\N	\N	\N	253	\N
35	попозже	遅く	副詞	\N	\N	\N	253	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	254	\N
36	Пожалуйста	どういたしまして	助詞	\N	\N	\N	255	\N
37	приду	（歩いて）来る	動詞	\N	\N	\N	256	\N
38	занятия	授業	名詞	\N	\N	\N	256	\N
39	Понятно	わかった・いいです	助詞	\N	\N	\N	257	\N
40	буду ждать	待つ・待っている	動詞	\N	\N	\N	258	\N
41	где	どこに	疑問詞	\N	\N	\N	259	\N
42	находится	ある	動詞	\N	\N	\N	259	\N
43	ближайший	近くの	形容詞	\N	\N	\N	259	\N
44	книжный	本の	形容詞	\N	\N	\N	259	\N
45	магазин	店	名詞	\N	\N	\N	259	\N
46	Да	はい	助詞	\N	\N	\N	260	\N
47	знаю	知っている	動詞	\N	\N	\N	260	\N
48	Там	あそこに	副詞	\N	\N	\N	261	\N
49	белое	白い	形容詞	\N	\N	\N	261	\N
50	здание	建物	名詞	\N	\N	\N	261	\N
51	видите	見える	動詞	\N	\N	\N	261	\N
51	вижу	見える	動詞	\N	\N	\N	262	\N
52	поверните	曲がる	動詞	\N	\N	\N	263	\N
53	направо	右に、右へ	副詞	\N	\N	\N	263	\N
54	Тогда	すると、そうすると	副詞	\N	\N	\N	264	\N
9	вы	あなたは	代名詞	\N	\N	\N	264	\N
39	Понятно	分かりました	述語副詞	\N	\N	\N	265	\N
55	он	それは	代名詞	\N	\N	\N	266	\N
56	называется	～という名前である	動詞	\N	\N	\N	266	\N
57	Мир	世界	名詞	\N	\N	\N	267	\N
58	книг	本の	名詞	\N	\N	\N	267	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	268	\N
59	Не за что.	どういたしまして	成句	\N	\N	\N	269	\N
60	Простите	すみません	動詞	\N	\N	\N	270	\N
61	Давайте	さあ、～しよう	動詞	\N	\N	\N	271	\N
62	познакомимся	知り合いになる	動詞	\N	\N	\N	271	\N
63	зовут	呼ぶ	動詞	\N	\N	\N	272	\N
64	аспирант	大学院生	名詞	\N	\N	\N	273	\N
65	этого	この	代名詞	\N	\N	\N	273	\N
66	университета	大学	名詞	\N	\N	\N	273	\N
67	студентка	（女子）大学生	動詞	\N	\N	\N	274	\N
63	зовут	呼ぶ	名詞	\N	\N	\N	275	\N
68	Очень	とても	副詞	\N	\N	\N	276	\N
69	рад	うれしい	形容詞	\N	\N	\N	276	\N
62	познакомиться	知り合いになる	動詞	\N	\N	\N	276	\N
68	Очень	とても	副詞	\N	\N	\N	277	\N
69	рада	うれしい	形容詞	\N	\N	\N	277	\N
70	откуда	どこから	副詞	\N	\N	\N	278	\N
71	Санкт-Петербурга	サンクト・ペテルブルク	（固有）名詞	\N	\N	\N	279	\N
72	отец	父	名詞	\N	\N	\N	280	\N
73	мать	母	名詞	\N	\N	\N	280	\N
74	живут	住む・暮らす	動詞	\N	\N	\N	280	\N
48	там	そこで・そこに	副詞	\N	\N	\N	280	\N
8	А	それでは・一方	接続詞	\N	\N	\N	281	\N
75	москвичка	モスクワっ子(女性)	名詞	\N	\N	\N	282	\N
76	раньше	以前	副詞	\N	\N	\N	283	\N
74	жил	住む・暮らす	動詞	\N	\N	\N	283	\N
71	Санкт-Петербурге	サンクト・ペテルブルク	名詞	\N	\N	\N	283	\N
77	прожил	(ある期間)暮らす	動詞	\N	\N	\N	284	\N
78	пять	5	数詞	\N	\N	\N	284	\N
79	лет	年	名詞	\N	\N	\N	284	\N
80	Так	そんなに・それほど	副詞	\N	\N	\N	285	\N
81	долго	長く	副詞	\N	\N	\N	285	\N
82	когда	いつ	副詞	\N	\N	\N	286	\N
83	возвратились	戻る・帰る	動詞	\N	\N	\N	286	\N
84	Москву	モスクワ	名詞	\N	\N	\N	286	\N
85	Два	2	数詞	\N	\N	\N	287	\N
79	года	年	名詞	\N	\N	\N	287	\N
86	назад	～前に	副詞	\N	\N	\N	287	\N
87	я	私は	人称代名詞	\N	\N	\N	288	\N
88	опоздал	遅れた	動詞	\N	\N	\N	288	\N
81	долго	長く、長い間	副詞	\N	\N	\N	289	\N
40	ждали	待つ	動詞	\N	\N	\N	289	\N
19	не	～ない	否定詞	\N	\N	\N	290	\N
89	замёрзли	体が凍える	動詞	\N	\N	\N	290	\N
37	пришла	来る	動詞	\N	\N	\N	292	\N
91	позвонили	電話する	動詞	\N	\N	\N	293	\N
13	вчера	昨日	副詞	\N	\N	\N	293	\N
59	Не за что.	どういたしまして	成句	\N	\N	\N	294	\N
92	должна	～しなければならない	形容詞短語尾	\N	\N	\N	295	\N
93	извиниться	お詫びする、許しを乞う、あやまる	動詞	\N	\N	\N	295	\N
94	за	～のことで	前置詞	\N	\N	\N	295	\N
95	то	～のこと、もの	代名詞	\N	\N	\N	295	\N
11	что	～するところの	関係代名詞	\N	\N	\N	295	\N
96	звонила	電話する	動詞	\N	\N	\N	295	\N
9	вам	あなたに	人称代名詞	\N	\N	\N	295	\N
68	очень	とても、たいへん	副詞	\N	\N	\N	295	\N
35	поздно	遅くに、遅い時間に	副詞	\N	\N	\N	295	\N
11	что	何	疑問（代名）詞	\N	\N	\N	296	\N
97	беспокойтесь	心配する	動詞	\N	\N	\N	297	\N
98	Ведь	だって、なぜなら	接続詞	\N	\N	\N	298	\N
99	сова	ふくろう；夜型人間	名詞	\N	\N	\N	298	\N
2	Добрый	よい	形容詞	\N	\N	\N	299	\N
100	вечер	晩	名詞	\N	\N	\N	299	\N
101	поздравляю	祝う	動詞	\N	\N	\N	300	\N
3	днём	日	名詞	\N	\N	\N	300	\N
102	рождения	誕生	名詞	\N	\N	\N	300	\N
4	как	何と・とても	副詞	\N	\N	\N	301	\N
69	рада	うれしい	形容詞	\N	\N	\N	301	\N
51	видеть	会う・出会う	動詞	\N	\N	\N	301	\N
103	Проходите	通る	動詞	\N	\N	\N	302	\N
36	пожалуйста	どうぞ	助詞	\N	\N	\N	302	\N
104	Вот	はい	助詞	\N	\N	\N	303	\N
36	пожалуйста	どうぞ	助詞	\N	\N	\N	303	\N
105	Это	これ	代名詞	\N	\N	\N	304	\N
6	Спасибо	ありがとう	間投詞	\N	\N	\N	305	\N
106	жена	妻	名詞	\N	\N	\N	306	\N
107	сказала	言う	動詞	\N	\N	\N	306	\N
11	что	～ということ	接続詞	\N	\N	\N	306	\N
108	нравятся	気に入る・好みに合う	動詞	\N	\N	\N	306	\N
109	красные	赤い	形容詞	\N	\N	\N	306	\N
110	розы	バラ	名詞	\N	\N	\N	306	\N
111	совершенно	完全に	副詞	\N	\N	\N	307	\N
112	верно	正しい	形容詞	\N	\N	\N	307	\N
81	долго	長く・長いこと	副詞	\N	\N	\N	308	\N
113	думал	考える	動詞	\N	\N	\N	308	\N
11	что	何	代名詞	\N	\N	\N	308	\N
114	подарить	贈る	動詞	\N	\N	\N	308	\N
105	Это	これ	代名詞	\N	\N	\N	309	\N
115	подарок	プレゼント・贈り物	名詞	\N	\N	\N	309	\N
116	хорошего	よい	形容詞	\N	\N	\N	309	\N
117	настроения	気分	名詞	\N	\N	\N	309	\N
118	французские	フランスの・フランス製の	形容詞	\N	\N	\N	309	\N
119	духи	香水	名詞	\N	\N	\N	309	\N
120	Шанель	シャネル	（固有）名詞	\N	\N	\N	309	\N
121	Спасибо	ありがとう	助詞	\N	\N	\N	310	\N
122	большое	大きい	形容詞	\N	\N	\N	310	\N
123	Какие	何と	代名詞	\N	\N	\N	311	\N
124	прекрасные	すばらしい・素敵な	形容詞	\N	\N	\N	311	\N
119	духи	香水	名詞	\N	\N	\N	311	\N
69	рад	うれしい	形容詞	\N	\N	\N	312	\N
11	что	～ということ	接続詞	\N	\N	\N	312	\N
108	нравится	気に入る・好みに合う	動詞	\N	\N	\N	312	\N
115	подарок	プレゼント・贈り物	名詞	\N	\N	\N	312	\N
68	очень	とても	副詞	\N	\N	\N	313	\N
108	нравится	気に入る・好みに合う	動詞	\N	\N	\N	313	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	314	\N
125	Ну	さあ	間投詞	\N	\N	\N	315	\N
126	прошу	求める・頼む	動詞	\N	\N	\N	315	\N
127	столу	机・テーブル	名詞	\N	\N	\N	315	\N
128	уже	もう	副詞	\N	\N	\N	316	\N
129	пора	（～すべき）時間だ	無人称述語	\N	\N	\N	316	\N
130	надо	～しなければならない	無人称述語	\N	\N	\N	317	\N
131	уходить	去る、立ち去る	動詞	\N	\N	\N	317	\N
132	угощение	御馳走、もてなし	名詞	\N	\N	\N	318	\N
133	Почему	なぜ、どうして	疑問副詞	\N	\N	\N	319	\N
134	Ещё	まだ	副詞	\N	\N	\N	320	\N
135	рано	早い	無人称述語	\N	\N	\N	320	\N
136	встретить	出迎える	動詞	\N	\N	\N	321	\N
137	друга	友人、友達	名詞	\N	\N	\N	321	\N
138	аэропорту	空港	名詞	\N	\N	\N	321	\N
70	Откуда	どこから	疑問副詞	\N	\N	\N	322	\N
139	прилетает	（飛行機などで）やってくる	動詞	\N	\N	\N	322	\N
140	Из	～から	前置詞	\N	\N	\N	323	\N
141	Японии	日本	名詞	\N	\N	\N	323	\N
142	впервые	初めて	副詞	\N	\N	\N	324	\N
143	России	ロシア	名詞	\N	\N	\N	324	\N
144	Если	もし～なら	接続詞	\N	\N	\N	325	\N
145	обязательно	必ず	副詞	\N	\N	\N	325	\N
146	заблудится	（道に）迷う	動詞	\N	\N	\N	325	\N
147	может	～できる・～でありうる	動詞	\N	\N	\N	326	\N
31	быть	～である		\N	\N	\N	326	\N
148	котором	何番目の～	疑問形容詞	\N	\N	\N	327	\N
149	часу	～時	名詞	\N	\N	\N	327	\N
150	шесть	６	数詞	\N	\N	\N	328	\N
151	спешить	急ぐ	動詞	\N	\N	\N	329	\N
152	До	～まで	前置詞	\N	\N	\N	330	\N
153	свидания	出会うこと	名詞	\N	\N	\N	330	\N
91	позвоню	電話する	動詞	\N	\N	\N	331	\N
152	До	～まで	前置詞	\N	\N	\N	332	\N
154	завтра	明日	名詞	\N	\N	\N	332	\N
31	Будьте	～であれ		\N	\N	\N	333	\N
2	добры	よい	形容詞	\N	\N	\N	333	\N
155	покажите	見せる	動詞	\N	\N	\N	333	\N
95	тот	あの	代名詞	\N	\N	\N	333	\N
156	японско-	日本と	形容詞（造語形）	\N	\N	\N	333	\N
157	русский	ロシアの	形容詞	\N	\N	\N	333	\N
158	словарь	辞書・辞典	名詞	\N	\N	\N	333	\N
65	Этот	この	代名詞	\N	\N	\N	334	\N
159	Справа	右に	副詞	\N	\N	\N	335	\N
160	вон	(少し遠いところのものを差して)それ	助詞	\N	\N	\N	336	\N
36	Пожалуйста	どうぞ	助詞	\N	\N	\N	337	\N
161	никогда	(неと共に)１度も(～ない)	副詞	\N	\N	\N	338	\N
51	видел	見かける	動詞	\N	\N	\N	338	\N
65	этот	この	代名詞	\N	\N	\N	338	\N
158	словарь	辞書	名詞	\N	\N	\N	338	\N
105	Это	これは	代名詞	\N	\N	\N	339	\N
162	новый	新しい	形容詞	\N	\N	\N	339	\N
162	новейший	最新の	形容詞	\N	\N	\N	340	\N
163	Напечатан	出版された	被動形動詞過去	\N	\N	\N	341	\N
164	прошлом	この前の・前回の	形容詞	\N	\N	\N	341	\N
165	месяце	(暦としての)月	名詞	\N	\N	\N	341	\N
166	Сколько	いくら	数詞	\N	\N	\N	342	\N
167	стоит	(値段が)～である	動詞	\N	\N	\N	342	\N
168	Триста	300	数詞	\N	\N	\N	343	\N
169	восемьдесят	80	数詞	\N	\N	\N	343	\N
170	рублей	ルーブリ(ロシアの通貨単位)	名詞	\N	\N	\N	343	\N
171	Возьмёте	手に入れる・買う	動詞	\N	\N	\N	344	\N
171	возьму	手に入れる・買う	動詞	\N	\N	\N	345	\N
172	читали	読んだ	動詞	\N	\N	\N	346	\N
173	Преступление	罪、犯罪	名詞	\N	\N	\N	346	\N
174	наказание	罰、処罰	名詞	\N	\N	\N	346	\N
172	читал	読む	動詞	\N	\N	\N	347	\N
65	Этот	あの、この	指示代名詞	\N	\N	\N	348	\N
175	роман	（長編）小説	名詞	\N	\N	\N	348	\N
108	нравится	気に入られている	動詞	\N	\N	\N	348	\N
134	ещё	他に	副詞	\N	\N	\N	349	\N
123	какие	どんな、いかなる	疑問形容詞	\N	\N	\N	349	\N
157	русские	ロシアの	形容詞	\N	\N	\N	349	\N
176	произведения	作品、創作物	名詞	\N	\N	\N	349	\N
49	Белую	白い	形容詞	\N	\N	\N	350	\N
177	ночь	夜	名詞	\N	\N	\N	350	\N
178	моя	私の	所有代名詞	\N	\N	\N	351	\N
179	любимая	お気に入りの	形容詞	\N	\N	\N	351	\N
180	повесть	（中編）小説	名詞	\N	\N	\N	351	\N
181	Писатель	作家	名詞	\N	\N	\N	352	\N
182	красиво	美しく	副詞	\N	\N	\N	352	\N
183	изобразил	描く、描写する	動詞	\N	\N	\N	352	\N
71	Санкт-Петербург	サンクト・ペテルブルク	名詞	\N	\N	\N	352	\N
24	времени	時代	名詞	\N	\N	\N	352	\N
184	Кстати	ところで、ちなみに	接続詞	\N	\N	\N	353	\N
31	были	いた	動詞	\N	\N	\N	353	\N
134	ещё	まだ	副詞	\N	\N	\N	354	\N
25	хочу	～したい	動詞	\N	\N	\N	355	\N
185	посмотреть	見る	動詞	\N	\N	\N	355	\N
186	привет	やあ	名詞	\N	\N	\N	356	\N
187	Ой	あら・まあ	間投詞	\N	\N	\N	357	\N
186	привет	やあ	名詞	\N	\N	\N	357	\N
107	Скажи	言う	動詞	\N	\N	\N	358	\N
188	занята	忙しい	形容詞	\N	\N	\N	358	\N
154	завтра	明日	副詞	\N	\N	\N	358	\N
11	Что	何	代名詞	\N	\N	\N	359	\N
189	будешь делать	する	動詞	\N	\N	\N	359	\N
190	Утром	午前に	副詞	\N	\N	\N	360	\N
191	буду заниматься	勉強する	動詞	\N	\N	\N	360	\N
192	библиотеке	図書館	名詞	\N	\N	\N	360	\N
193	Днём	午後に・日中に	副詞	\N	\N	\N	361	\N
31	будут	ある		\N	\N	\N	361	\N
38	занятия	授業	名詞	\N	\N	\N	361	\N
29	Но	しかし	接続詞	\N	\N	\N	362	\N
194	вечером	晩に・夕方に	副詞	\N	\N	\N	362	\N
31	буду	～である		\N	\N	\N	362	\N
195	свободна	暇な	形容詞	\N	\N	\N	362	\N
4	Как	何と	副詞	\N	\N	\N	363	\N
7	хорошо	よい	(述語)副詞	\N	\N	\N	363	\N
85	два	2	数詞	\N	\N	\N	364	\N
196	билета	切符	名詞	\N	\N	\N	364	\N
197	Большой театр	ボリショイ劇場	固有名詞	\N	\N	\N	364	\N
154	завтра	明日は	副詞	\N	\N	\N	364	\N
198	вечером	晩に・夕方に	副詞 	\N	\N	\N	364	\N
31	будет	ある・いる 		\N	\N	\N	364	\N
199	гость	客・来客	名詞 	\N	\N	\N	364	\N
25	хочешь	～したい	動詞	\N	\N	\N	365	\N
200	послушать	聴く	動詞	\N	\N	\N	365	\N
201	оперу	オペラ	名詞	\N	\N	\N	365	\N
202	Борис Годунов	ボリス・ゴドゥノフ(オペラの名前)	固有名詞	\N	\N	\N	365	\N
202	Борис Годунов	ボリス・ゴドゥノフ(オペラの名前)	固有名詞	\N	\N	\N	366	\N
68	очень	とても	副詞	\N	\N	\N	367	\N
25	хочу	～したい	動詞	\N	\N	\N	367	\N
166	Сколько	いくら	数詞	\N	\N	\N	368	\N
167	стоит	(値段が)～である	動詞	\N	\N	\N	368	\N
196	билет	切符	名詞	\N	\N	\N	368	\N
130	надо	～ねばならない	(無人称述語)	\N	\N	\N	369	\N
203	платить	(金を)払う	動詞	\N	\N	\N	369	\N
65	эти	この	代名詞	\N	\N	\N	370	\N
196	билеты	切符	名詞	\N	\N	\N	370	\N
114	подарил	与える	動詞	\N	\N	\N	370	\N
137	друг	友だち	名詞	\N	\N	\N	370	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	371	\N
122	большое	大きい	形容詞	\N	\N	\N	371	\N
204	Пока	じゃあね	助詞	\N	\N	\N	372	\N
205	Всего	すべての	代名詞	\N	\N	\N	373	\N
116	хорошего	よい	形容詞	\N	\N	\N	373	\N
22	Здравствуйте	こんにちは	間投詞	\N	\N	\N	374	\N
87	Я	私は	（人称）代名詞	\N	\N	\N	375	\N
157	русский	ロシア人	名詞	\N	\N	\N	376	\N
206	поняла	分かる、理解する	動詞	\N	\N	\N	377	\N
207	иностранец	外国人	名詞	\N	\N	\N	377	\N
82	когда	～する時	接続詞	\N	\N	\N	377	\N
9	вами	あなたと	人称代名詞	\N	\N	\N	377	\N
208	разговаривали	話をする	動詞	\N	\N	\N	377	\N
209	телефону	電話で	名詞	\N	\N	\N	377	\N
98	Ведь	なぜなら、というのも	接続詞	\N	\N	\N	378	\N
210	по-русски	ロシア語で	副詞	\N	\N	\N	378	\N
211	комплимент	褒め言葉	名詞	\N	\N	\N	379	\N
107	сказал	言う、伝える	動詞	\N	\N	\N	380	\N
212	своего	自分の	物主形容詞	\N	\N	\N	380	\N
213	имени	名前	名詞	\N	\N	\N	380	\N
214	беспокойтесь	心配する	動詞	\N	\N	\N	381	\N
215	познакомиться	知り合う、知り合いになる	動詞	\N	\N	\N	382	\N
4	как	どれくらい	疑問副詞	\N	\N	\N	383	\N
81	долго	長く	副詞	\N	\N	\N	383	\N
216	учите	勉強する、習う	動詞	\N	\N	\N	383	\N
79	лет	年	名詞	\N	\N	\N	384	\N
217	совсем	非常に、全く、全然	副詞	\N	\N	\N	385	\N
218	мало	少ない	述語副詞	\N	\N	\N	385	\N
219	возможности	可能性	名詞	\N	\N	\N	385	\N
200	слушать	聴く	動詞	\N	\N	\N	385	\N
220	говорить	話す、しゃべる	動詞	\N	\N	\N	385	\N
74	жили	住む、生活する	動詞	\N	\N	\N	386	\N
31	был	行った（いた）ことがある	動詞	\N	\N	\N	387	\N
221	туристической	観光の、ツアーの、旅行の	形容詞	\N	\N	\N	387	\N
222	поездке	旅行	名詞	\N	\N	\N	387	\N
205	Всего	全部で、合計して	副詞	\N	\N	\N	388	\N
223	недели	週	名詞	\N	\N	\N	388	\N
224	Поэтому	だから、そのため	接続詞	\N	\N	\N	389	\N
225	уверен	自信、確信がある	形容詞短語尾	\N	\N	\N	389	\N
147	могу	～できる	動詞	\N	\N	\N	389	\N
226	общаться	交流する、コミュニケーションをとる	動詞	\N	\N	\N	389	\N
227	без	～なしで、なしに	前置詞	\N	\N	\N	389	\N
228	проблем	問題、支障	名詞	\N	\N	\N	389	\N
11	что	何	疑問（代名）詞	\N	\N	\N	390	\N
22	Здравствуй	こんにちは	間投詞	\N	\N	\N	391	\N
186	Привет	やあ	名詞	\N	\N	\N	392	\N
82	когда	いつ	副詞	\N	\N	\N	393	\N
229	сегодня	今日は	副詞	\N	\N	\N	393	\N
230	кончаешь	終える	動詞	\N	\N	\N	393	\N
191	заниматься	勉強する	動詞	\N	\N	\N	393	\N
231	четыре	4	数詞	\N	\N	\N	394	\N
8	А	ところで	接続詞	\N	\N	\N	395	\N
11	что	何	代名詞	\N	\N	\N	395	\N
25	хочешь	～したい	動詞	\N	\N	\N	396	\N
232	пойти	出かける	動詞	\N	\N	\N	396	\N
233	футбол	サッカー	名詞	\N	\N	\N	396	\N
234	Конечно	もちろん	副詞	\N	\N	\N	397	\N
25	хочу	～したい	動詞	\N	\N	\N	397	\N
68	очень	とても	副詞	\N	\N	\N	398	\N
235	люблю	好きである・好む	動詞	\N	\N	\N	398	\N
236	спорт	スポーツ	名詞	\N	\N	\N	398	\N
80	Так	さて	接続詞	\N	\N	\N	399	\N
41	где	どこで	副詞	\N	\N	\N	399	\N
237	встретимся	待ち合わせる	動詞	\N	\N	\N	399	\N
148	котором	何番目の	代名詞	\N	\N	\N	400	\N
149	часу	時	名詞	\N	\N	\N	400	\N
150	шесть	6	数詞	\N	\N	\N	401	\N
149	часов	時	名詞	\N	\N	\N	401	\N
238	метро	地下鉄の駅	名詞	\N	\N	\N	401	\N
239	Спортивная	スパルチーヴナヤ(地下鉄の駅名)	（固有）名詞	\N	\N	\N	401	\N
240	около	～のそばに	前置詞	\N	\N	\N	401	\N
241	выхода	出口	名詞	\N	\N	\N	401	\N
242	стадиону	スタジアム	名詞	\N	\N	\N	401	\N
7	Хорошо	よい	(述語)副詞	\N	\N	\N	402	\N
7	Хорошо	よい	(述語)副詞	\N	\N	\N	403	\N
152	До	～まで	前置詞	\N	\N	\N	404	\N
100	вечера	晩・夕方	名詞	\N	\N	\N	404	\N
152	До	～まで	前置詞	\N	\N	\N	405	\N
100	вечера	晩・夕方	名詞	\N	\N	\N	405	\N
166	Сколько	いくつ、いくら	疑問数詞	\N	\N	\N	406	\N
243	человек	～人（にん）	名詞	\N	\N	\N	406	\N
244	вашей	あなたの	物主形容詞	\N	\N	\N	406	\N
245	семье	家族	名詞	\N	\N	\N	406	\N
246	Четверо	４人	集合数詞	\N	\N	\N	407	\N
247	Показывая	見せる	動詞	\N	\N	\N	408	\N
248	фотографию	写真	名詞	\N	\N	\N	408	\N
178	моя	私の	物主形容詞	\N	\N	\N	408	\N
249	Папа	パパ、お父さん	名詞	\N	\N	\N	409	\N
250	мама	ママ、お母さん	名詞	\N	\N	\N	409	\N
251	брат	兄（弟）	名詞	\N	\N	\N	409	\N
252	О	おお、ああ、わあ	間投詞	\N	\N	\N	410	\N
253	похож	似ている	形容詞短語尾	\N	\N	\N	411	\N
254	Часто	しばしば、よく	副詞	\N	\N	\N	412	\N
80	так	そのように	副詞	\N	\N	\N	412	\N
113	думаю	思う、考える	動詞	\N	\N	\N	413	\N
255	похож	似ている	形容詞	\N	\N	\N	414	\N
244	вашего	あなたの	代名詞	\N	\N	\N	415	\N
251	брата	兄･弟	名詞	\N	\N	\N	415	\N
256	Валентин	ヴァレンチーン	名詞	\N	\N	\N	416	\N
134	ещё	まだ	副詞	\N	\N	\N	417	\N
257	студент	学生	名詞	\N	\N	\N	417	\N
79	лет	年	名詞	\N	\N	\N	418	\N
258	учится	学んでいる、勉強している、在籍している	動詞	\N	\N	\N	418	\N
66	университете	大学	名詞	\N	\N	\N	418	\N
79	года	年	名詞	\N	\N	\N	419	\N
22	Здравствуйте	こんにちは	間投詞	\N	\N	\N	420	\N
22	Здравствуйте.	こんにちは	間投詞	\N	\N	\N	421	\N
25	хочу	～したい	動詞	\N	\N	\N	422	\N
171	взять	借りる	動詞	\N	\N	\N	422	\N
175	роман	長編小説	名詞	\N	\N	\N	422	\N
259	Достоевского	ドストエフスキー(作家の名前)	固有名詞	\N	\N	\N	422	\N
260	Братья Карамазовы	カラマーゾフの兄弟(小説の名前)	固有名詞	\N	\N	\N	422	\N
29	но	しかし	接続詞	\N	\N	\N	423	\N
147	могу	～できる	動詞	\N	\N	\N	423	\N
261	найти	見つける	動詞	\N	\N	\N	423	\N
30	Сейчас	今	副詞	\N	\N	\N	424	\N
262	посмотрим	調べる	動詞	\N	\N	\N	424	\N
29	Но	しかし	接続詞	\N	\N	\N	425	\N
263	сначала	初めに・まず	副詞	\N	\N	\N	425	\N
264	заполните	埋める	動詞	\N	\N	\N	425	\N
65	этот	この	代名詞	\N	\N	\N	425	\N
265	бланк	空白・空欄	名詞	\N	\N	\N	425	\N
266	Можно	～してよろしい	(無人称述語)	\N	\N	\N	426	\N
267	вписать	書き込む	動詞	\N	\N	\N	426	\N
268	карандашом	鉛筆	名詞	\N	\N	\N	426	\N
90	нет	ない	(無人称述語)	\N	\N	\N	427	\N
269	ручки	ペン	名詞	\N	\N	\N	427	\N
46	Да	はい	助詞	\N	\N	\N	428	\N
29	Но	しかし	接続詞	\N	\N	\N	429	\N
269	ручкой	ペン	名詞	\N	\N	\N	429	\N
270	лучше	より良い	(無人称述語)	\N	\N	\N	429	\N
104	Вот	(目前のものをさして)ほら	助詞	\N	\N	\N	430	\N
36	пожалуйста	どうぞ	助詞	\N	\N	\N	430	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	431	\N
80	Так	このように	副詞	\N	\N	\N	432	\N
7	хорошо	よい	(無人称述語)	\N	\N	\N	432	\N
7	хорошо	よい	(無人称述語)	\N	\N	\N	433	\N
271	Одну	1	数詞	\N	\N	\N	434	\N
272	минуточку	(時間としての)分	名詞	\N	\N	\N	434	\N
220	говоришь	話す	動詞	\N	\N	\N	435	\N
273	по-английски	英語で	副詞	\N	\N	\N	435	\N
133	почему	なぜ、どうして	疑問副詞	\N	\N	\N	436	\N
274	спрашиваешь	尋ねる、質問する	動詞	\N	\N	\N	436	\N
275	учёный	学者	名詞	\N	\N	\N	437	\N
276	приедет	（乗り物で）来る	動詞	\N	\N	\N	437	\N
277	международную	国際的な	形容詞	\N	\N	\N	437	\N
278	конференцию	会議	名詞	\N	\N	\N	437	\N
279	гид-переводчик	通訳ガイド	名詞	\N	\N	\N	438	\N
280	заболел	病気になる	動詞	\N	\N	\N	438	\N
281	ищем	探す	動詞	\N	\N	\N	438	\N
282	кого-нибудь	（任意の）誰か	不定代名詞	\N	\N	\N	438	\N
283	кто	～するところの	関係代名詞	\N	\N	\N	438	\N
31	будешь	（未来を表す）～だろう		\N	\N	\N	439	\N
195	свободна	暇だ、空いている	形容詞	\N	\N	\N	439	\N
188	занята	ふさがっている、忙しい	形容詞	\N	\N	\N	440	\N
284	помочь	手伝う	動詞	\N	\N	\N	441	\N
285	тебе	あなたを	人称代名詞	\N	\N	\N	441	\N
286	Среди	～のなかから、～のなかで	前置詞	\N	\N	\N	442	\N
287	твоих	あなたの	所有代名詞	\N	\N	\N	442	\N
137	друзей	友人、友達	名詞	\N	\N	\N	442	\N
288	подруга	（女性の）友達	名詞	\N	\N	\N	443	\N
289	переводить	訳す	動詞	\N	\N	\N	443	\N
191	занимается	従事する	動詞	\N	\N	\N	444	\N
290	письменным	書面での、書面による	形容詞	\N	\N	\N	444	\N
291	переводом	訳すこと、通訳、翻訳	名詞	\N	\N	\N	444	\N
292	захочет	～したがる、～したいと思う	動詞	\N	\N	\N	444	\N
293	сам	自分で、自ら	代名詞	\N	\N	\N	445	\N
294	спрошу	尋ねる、質問する	動詞	\N	\N	\N	445	\N
295	её	彼女に	人称代名詞	\N	\N	\N	445	\N
296	её	彼女の	物主代名詞	\N	\N	\N	446	\N
209	телефон	電話番号	名詞	\N	\N	\N	446	\N
147	могу	～できる	動詞	\N	\N	\N	447	\N
297	забыла	忘れる	動詞	\N	\N	\N	448	\N
298	книжку	手帳	名詞	\N	\N	\N	448	\N
299	дома	家で、家に	副詞	\N	\N	\N	448	\N
194	Вечером	晩に	副詞	\N	\N	\N	449	\N
91	позвоню	電話する	動詞	\N	\N	\N	449	\N
36	Пожалуйста	どうぞ・どうか	間投詞	\N	\N	\N	450	\N
300	Заранее	あらかじめ、前もって	副詞	\N	\N	\N	451	\N
2	Добрый	よい	形容詞	\N	\N	\N	452	\N
100	вечер	晩・夕方	名詞	\N	\N	\N	452	\N
22	Здравствуйте	こんばんは	間投詞	\N	\N	\N	453	\N
134	ещё	まだ	副詞	\N	\N	\N	454	\N
301	есть	ある		\N	\N	\N	454	\N
196	билеты	切符	名詞	\N	\N	\N	454	\N
302	сегодняшний	今日の	形容詞	\N	\N	\N	454	\N
303	концерт	コンサート	名詞	\N	\N	\N	454	\N
301	есть	ある		\N	\N	\N	455	\N
29	Но	しかし	接続詞	\N	\N	\N	456	\N
304	остались	残る	動詞	\N	\N	\N	456	\N
305	только	～だけ・～のみ	副詞	\N	\N	\N	456	\N
306	втором	2番目の	数詞	\N	\N	\N	456	\N
307	ярусе	劇場の桟敷席	名詞	\N	\N	\N	456	\N
123	Какие	どんな	代名詞	\N	\N	\N	457	\N
308	места	座席	名詞	\N	\N	\N	457	\N
104	Вот	(目前のものをさして)ほら	助詞	\N	\N	\N	458	\N
105	это	これ	代名詞	\N	\N	\N	458	\N
309	схема	見取り図	名詞	\N	\N	\N	458	\N
65	этого	この	代名詞	\N	\N	\N	458	\N
310	театра	劇場	名詞	\N	\N	\N	458	\N
304	Остались	残る	動詞	\N	\N	\N	459	\N
308	места	座席	名詞	\N	\N	\N	459	\N
311	третьем	3番目の	数詞	\N	\N	\N	459	\N
312	ряду	列	名詞	\N	\N	\N	459	\N
313	семнадцатое	17番目の	数詞	\N	\N	\N	459	\N
314	восемнадцатое	18番目の	数詞	\N	\N	\N	459	\N
315	девятнадцатое	19番目の	数詞	\N	\N	\N	459	\N
316	двадцатое	20番目の	数詞	\N	\N	\N	459	\N
317	И	そして	接続詞	\N	\N	\N	460	\N
134	ещё	まだ	副詞	\N	\N	\N	460	\N
304	остались	残る	動詞	\N	\N	\N	460	\N
318	четвёртом	4番目の	数詞	\N	\N	\N	460	\N
312	ряду	列	名詞	\N	\N	\N	460	\N
319	пятое	5番目の	数詞	\N	\N	\N	460	\N
320	шестое	6番目の	数詞	\N	\N	\N	460	\N
171	возьму	手に入れる・買う	動詞	\N	\N	\N	461	\N
196	билеты	切符	名詞	\N	\N	\N	461	\N
311	третьем	3番目の	数詞	\N	\N	\N	461	\N
312	ряду	列	名詞	\N	\N	\N	461	\N
313	семнадцатое	17番目の	数詞	\N	\N	\N	462	\N
314	восемнадцатое	18番目の	数詞	\N	\N	\N	462	\N
36	пожалуйста	どうか・なにとぞ	助詞	\N	\N	\N	462	\N
7	Хорошо	よい	(無人称述語)	\N	\N	\N	463	\N
123	Какой	どんな、いかなる	疑問代名詞	\N	\N	\N	464	\N
158	словарь	辞書	名詞	\N	\N	\N	464	\N
105	Это	これは	代名詞	\N	\N	\N	465	\N
321	русско-английский	ロシア‐英語の、露英の	形容詞	\N	\N	\N	466	\N
322	начала	始める	動詞	\N	\N	\N	467	\N
216	учить	勉強する、教わる	動詞	\N	\N	\N	467	\N
323	Молодец	すごい、えらい、よくやった	間投詞	\N	\N	\N	468	\N
133	почему	なぜ	疑問（副）詞	\N	\N	\N	469	\N
324	Летом	夏に	副詞	\N	\N	\N	470	\N
164	прошлого	過ぎ去った	形容詞	\N	\N	\N	470	\N
79	года	年	名詞	\N	\N	\N	470	\N
215	познакомилась	知り合う、知り合いになる	動詞	\N	\N	\N	470	\N
325	девушкой	女の子	名詞	\N	\N	\N	470	\N
326	переписываемся	文通する	動詞	\N	\N	\N	471	\N
327	изучаю	勉強する、研究する	動詞	\N	\N	\N	472	\N
328	знание	知識	名詞	\N	\N	\N	473	\N
329	открывает	開く	動詞	\N	\N	\N	473	\N
219	возможность	可能性	名詞	\N	\N	\N	473	\N
226	общаться	交流する、コミュニケーションする	動詞	\N	\N	\N	473	\N
330	людьми	人々	名詞	\N	\N	\N	473	\N
331	разных	異なる、様々な	形容詞	\N	\N	\N	473	\N
332	стран	国	名詞	\N	\N	\N	473	\N
333	Действительно	確かに、なるほど	間投詞	\N	\N	\N	474	\N
334	Постоянно	常に、絶えず、不断に	副詞	\N	\N	\N	475	\N
335	иностранных	外国の	形容詞	\N	\N	\N	475	\N
336	носителями	保持者、所有者；ネーティヴスピーカー	名詞	\N	\N	\N	475	\N
337	самый	最上の、非常に	形容詞	\N	\N	\N	475	\N
338	лучший	最良の	形容詞	\N	\N	\N	475	\N
339	метод	方法	名詞	\N	\N	\N	475	\N
340	изучения	研究、勉強	名詞	\N	\N	\N	475	\N
123	какой	どんな、いかなる	疑問形容詞	\N	\N	\N	476	\N
243	человек	ひと	名詞	\N	\N	\N	476	\N
341	скромная	控えめな、慎ましやかな	形容詞	\N	\N	\N	477	\N
342	серьёзная	真面目な、きちんとした	形容詞	\N	\N	\N	477	\N
25	хочу	～したい	動詞	\N	\N	\N	478	\N
343	чтобы	～するように	接続詞	\N	\N	\N	478	\N
107	скажи	言う	動詞	\N	\N	\N	479	\N
36	пожалуйста	どうか	助詞	\N	\N	\N	479	\N
172	читала	読む	動詞	\N	\N	\N	479	\N
175	роман	長編小説	名詞	\N	\N	\N	479	\N
344	Толстого	トルストイ(作家の名前)	固有名詞	\N	\N	\N	479	\N
345	Анна Каренина	アンナ・カレーニナ(小説の名前)	固有名詞	\N	\N	\N	479	\N
172	читала	読む	動詞	\N	\N	\N	480	\N
152	До	～まで	前置詞	\N	\N	\N	481	\N
346	конца	終わり・最後	名詞	\N	\N	\N	481	\N
347	прочитала	読む	動詞	\N	\N	\N	481	\N
152	до	～まで	前置詞	\N	\N	\N	482	\N
346	конца	終わり・最後	名詞	\N	\N	\N	482	\N
347	прочитала	読む	動詞	\N	\N	\N	483	\N
348	несколько	いくつかの・若干の	数詞	\N	\N	\N	483	\N
349	раз	回・度	名詞	\N	\N	\N	483	\N
271	Один	1	数詞	\N	\N	\N	484	\N
140	из	～から	前置詞	\N	\N	\N	484	\N
178	моих	私の	代名詞	\N	\N	\N	484	\N
257	студентов	学生	名詞	\N	\N	\N	484	\N
107	сказал	言う	動詞	\N	\N	\N	484	\N
11	что	～ということ	接続詞	\N	\N	\N	484	\N
345	Анна Каренина	アンナ・カレーニナ(小説の名前)	固有名詞	\N	\N	\N	484	\N
350	слишком	副詞	あまりに	\N	\N	\N	484	\N
122	большой	大きい	形容詞	\N	\N	\N	484	\N
175	роман	長編小説	名詞	\N	\N	\N	484	\N
351	скучно	つまらない・退屈だ	(無人称述語)	\N	\N	\N	484	\N
172	читать	読む	動詞	\N	\N	\N	484	\N
8	А	ところで	接続詞	\N	\N	\N	485	\N
4	как	どのように	副詞	\N	\N	\N	485	\N
113	думаешь	考える・思う	動詞	\N	\N	\N	485	\N
80	так	そのように	副詞	\N	\N	\N	486	\N
113	думаю	考える・思う	動詞	\N	\N	\N	486	\N
352	Хотя	～であるけれども	接続詞	\N	\N	\N	487	\N
122	большой	大きい	形容詞	\N	\N	\N	487	\N
29	но	しかし	接続詞	\N	\N	\N	487	\N
353	интересно	面白い	述語副詞	\N	\N	\N	487	\N
354	Всегда	いつも	副詞	\N	\N	\N	488	\N
82	когда	～する時	接続詞	\N	\N	\N	488	\N
172	читала	読む	動詞	\N	\N	\N	488	\N
113	думала	考える・思う	動詞	\N	\N	\N	488	\N
252	о	～について	前置詞	\N	\N	\N	488	\N
355	любви	愛	名詞	\N	\N	\N	488	\N
8	А	ところで	接続詞	\N	\N	\N	489	\N
4	как	どのように	副詞	\N	\N	\N	489	\N
113	думаете	考える・思う	動詞	\N	\N	\N	489	\N
113	думаю	考える・思う	動詞	\N	\N	\N	490	\N
11	что	～ということ	接続詞	\N	\N	\N	490	\N
345	Анна Каренина	アンナ・カレーニナ(小説の名前)	固有名詞	\N	\N	\N	490	\N
356	важная	重要な	形容詞	\N	\N	\N	490	\N
157	русская	ロシアの	形容詞	\N	\N	\N	490	\N
357	классика	第1級の文学作品・古典的作品	名詞	\N	\N	\N	490	\N
354	Всегда	いつも	副詞	\N	\N	\N	491	\N
82	когда	～する時	接続詞	\N	\N	\N	491	\N
172	читал	読む	動詞	\N	\N	\N	491	\N
113	думал	考える・思う	動詞	\N	\N	\N	491	\N
245	семье	家族	名詞	\N	\N	\N	491	\N
108	нравится	気に入っている	動詞	\N	\N	\N	492	\N
358	наш	私たちの	所有代名詞	\N	\N	\N	492	\N
359	город	町、都市	名詞	\N	\N	\N	492	\N
108	нравится	気に入っている	動詞	\N	\N	\N	493	\N
360	Воздух	空気	名詞	\N	\N	\N	494	\N
361	чистый	きれいな	形容詞	\N	\N	\N	494	\N
362	еда	食べ物、食事	名詞	\N	\N	\N	494	\N
363	вкусная	美味しい	形容詞	\N	\N	\N	494	\N
364	главное	重要なのは、大事なのは、何と言っても	挿入語	\N	\N	\N	494	\N
365	тёплые	暖かい	形容詞	\N	\N	\N	494	\N
69	рад	うれしい	形容詞	\N	\N	\N	495	\N
108	нравится	気に入っている	動詞	\N	\N	\N	495	\N
359	город	町･都市	名詞	\N	\N	\N	495	\N
366	пробовали	試す、味見する、試食する	動詞	\N	\N	\N	496	\N
367	яблоки	リンゴ	名詞	\N	\N	\N	496	\N
368	известен	有名な、知られている	形容詞	\N	\N	\N	497	\N
366	пробовала	試す	動詞	\N	\N	\N	498	\N
363	вкусно	おいしい	形容詞	\N	\N	\N	499	\N
235	люблю	好きである、愛している	動詞	\N	\N	\N	500	\N
369	каждый	毎～、おのおのの	形容詞	\N	\N	\N	500	\N
23	ем	食べる	動詞	\N	\N	\N	500	\N
123	Какая	何という～だろう	代名詞	\N	\N	\N	501	\N
116	хорошая	よい	形容詞	\N	\N	\N	501	\N
370	погода	天気	名詞	\N	\N	\N	501	\N
361	Чистый	澄んだ・きれいな	形容詞	\N	\N	\N	502	\N
360	воздух	空気	名詞	\N	\N	\N	502	\N
371	голубое	空色の・淡青色の	形容詞	\N	\N	\N	502	\N
372	небо	空	名詞	\N	\N	\N	502	\N
46	Да	はい・そうです	助詞	\N	\N	\N	503	\N
61	Давай	～しよう	動詞	\N	\N	\N	504	\N
373	погуляем	しばらく散歩する	動詞	\N	\N	\N	504	\N
374	парке	公園	名詞	\N	\N	\N	504	\N
46	да	(同意を求めて)そうでしょう？	助詞	\N	\N	\N	504	\N
68	очень	とても	副詞	\N	\N	\N	505	\N
235	люблю	好きである	動詞	\N	\N	\N	505	\N
375	гулять	散歩する	動詞	\N	\N	\N	505	\N
376	Извини	許す	動詞	\N	\N	\N	506	\N
377	хочется	～したい	動詞	\N	\N	\N	506	\N
11	Что	何	代名詞	\N	\N	\N	507	\N
12	случилось	起こる・生ずる	動詞	\N	\N	\N	507	\N
13	Вчера	昨日	副詞	\N	\N	\N	508	\N
378	спал	眠る	動詞	\N	\N	\N	508	\N
305	только	～しか	副詞	\N	\N	\N	508	\N
379	три	3	数詞	\N	\N	\N	508	\N
149	часа	時間	名詞	\N	\N	\N	508	\N
380	Почему-то	なぜか・どういうわけか	副詞	\N	\N	\N	509	\N
381	спалось	眠れる	動詞	\N	\N	\N	509	\N
382	теперь	だから今・それで	副詞	\N	\N	\N	510	\N
25	хочу	～したい	動詞	\N	\N	\N	510	\N
232	пойти	出発する	動詞	\N	\N	\N	510	\N
383	домой	家へ・自宅へ	副詞	\N	\N	\N	510	\N
384	поспать	(しばらく)眠る	動詞	\N	\N	\N	510	\N
11	Что	何	代名詞	\N	\N	\N	511	\N
243	человек	人	名詞	\N	\N	\N	511	\N
130	надо	～ねばならない	(無人称述語)	\N	\N	\N	512	\N
385	оправдываться	自分の行為を釈明する	動詞	\N	\N	\N	512	\N
14	всё	すべての	代名詞	\N	\N	\N	513	\N
24	время	時間	名詞	\N	\N	\N	513	\N
25	хочешь	～したい	動詞	\N	\N	\N	513	\N
378	спать	眠る	動詞	\N	\N	\N	513	\N
142	впервые	初めて	述語副詞	\N	\N	\N	514	\N
17	компьютером	コンピューター	名詞	\N	\N	\N	514	\N
4	как	どのように、いかに	疑問（副）詞	\N	\N	\N	515	\N
55	им	それを	人称代名詞	\N	\N	\N	515	\N
386	пользоваться	使う、利用する	動詞	\N	\N	\N	515	\N
387	послать	送る	動詞	\N	\N	\N	516	\N
388	электронное	電子の	形容詞	\N	\N	\N	516	\N
389	письмо	手紙	名詞	\N	\N	\N	516	\N
390	рубеж	海外、外国	名詞	\N	\N	\N	516	\N
7	Хорошо	いい、結構だ	助詞	\N	\N	\N	517	\N
263	Сначала	はじめに	副詞	\N	\N	\N	518	\N
130	надо	～しなければならない	無人称述語	\N	\N	\N	518	\N
391	включить	電源を入れる	動詞	\N	\N	\N	518	\N
392	Нажмите	押す	動詞	\N	\N	\N	519	\N
65	эту	この、その	指示代名詞	\N	\N	\N	519	\N
393	кнопку	ボタン	名詞	\N	\N	\N	519	\N
80	Так	こう、このように	副詞	\N	\N	\N	520	\N
46	Да	はい	間投詞	\N	\N	\N	521	\N
394	Немного	少し、ちょっと	副詞	\N	\N	\N	522	\N
395	подождите	待つ	動詞	\N	\N	\N	522	\N
396	потом	それから、あとで	副詞	\N	\N	\N	523	\N
397	дважды	２回、２度	副詞	\N	\N	\N	523	\N
398	щёлкните	カチッと押す	動詞	\N	\N	\N	523	\N
399	значок	アイコン	名詞	\N	\N	\N	523	\N
397	Дважды	２度･２回	副詞	\N	\N	\N	524	\N
398	щёлкнуть	クリックする・押す	動詞	\N	\N	\N	524	\N
400	щёлкает	クリックする・押す	動詞	\N	\N	\N	524	\N
399	значок	アイコン	名詞	\N	\N	\N	524	\N
116	Хорошо	よい	形容詞	\N	\N	\N	525	\N
54	Тогда	そうすると、その場合	副詞	\N	\N	\N	526	\N
401	запускается	起動する、立ち上がる	動詞	\N	\N	\N	526	\N
402	программа	ソフトウェア、プログラム	名詞	\N	\N	\N	526	\N
403	для	～のための	前置詞	\N	\N	\N	526	\N
404	почты	郵便	名詞	\N	\N	\N	526	\N
382	Теперь	今、（前とは違って）今では	副詞	\N	\N	\N	527	\N
147	можете	～できる	動詞	\N	\N	\N	527	\N
405	через	～を通じて	前置詞	\N	\N	\N	527	\N
406	Интернет	インターネット	名詞	\N	\N	\N	527	\N
47	знаешь	知っている	動詞	\N	\N	\N	528	\N
234	конечно	もちろん	副詞	\N	\N	\N	529	\N
98	Ведь	だって～だから	接続詞	\N	\N	\N	530	\N
258	учимся	勉強する	動詞	\N	\N	\N	530	\N
271	одной	同じ	形容詞	\N	\N	\N	530	\N
407	группе	グループ	名詞	\N	\N	\N	530	\N
8	А	ところで	接続詞	\N	\N	\N	531	\N
11	что	何	代名詞	\N	\N	\N	531	\N
408	Что-то	なんとなく	副詞	\N	\N	\N	532	\N
295	её	彼女	代名詞	\N	\N	\N	532	\N
409	давно	長い間・ずっと前から	副詞	\N	\N	\N	532	\N
410	видно	見える	(無人称述語)	\N	\N	\N	532	\N
11	Что	何	代名詞	\N	\N	\N	533	\N
411	с	～は(状態の主体)	前置詞	\N	\N	\N	533	\N
295	ней	彼女	代名詞	\N	\N	\N	533	\N
30	Сейчас	今	副詞	\N	\N	\N	534	\N
90	нет	いない・ない	(無人称述語)	\N	\N	\N	534	\N
84	Москве	モスクワ	固有名詞	\N	\N	\N	534	\N
133	почему	なぜ	副詞	\N	\N	\N	535	\N
412	поехала	(乗り物に乗って)出発する	動詞	\N	\N	\N	536	\N
258	учиться	勉強する	動詞	\N	\N	\N	536	\N
413	США	アメリカ合衆国(Соединённые Штаты Америкиの略)	固有名詞	\N	\N	\N	536	\N
414	вернётся	戻る・帰る	動詞	\N	\N	\N	537	\N
84	Москву	モスクワ	固有名詞	\N	\N	\N	537	\N
405	через	～後に	前置詞	\N	\N	\N	537	\N
415	десять	10	数詞	\N	\N	\N	537	\N
165	месяцев	(時間としての)月	名詞	\N	\N	\N	537	\N
486	Эйфелеву башню	(パリの)エッフェル塔	固有名詞	\N	\N	\N	615	\N
4	Как	なんと・非常に	副詞	\N	\N	\N	616	\N
7	хорошо	よい	(無人称述語)	\N	\N	\N	616	\N
155	покажешь	語彙見せる	動詞	\N	\N	\N	617	\N
248	фотографии	写真	名詞	\N	\N	\N	617	\N
229	Сегодня	今日	副詞	\N	\N	\N	618	\N
452	у	～のもとに	前置詞	\N	\N	\N	618	\N
90	нет	ない	(無人称述語)	\N	\N	\N	618	\N
155	покажу	語彙見せる	動詞	\N	\N	\N	619	\N
470	следующий	次の	形容詞	\N	\N	\N	619	\N
349	раз	回	名詞	\N	\N	\N	619	\N
487	шоколадок	（板）チョコレート	名詞	\N	\N	\N	620	\N
488	Октябрь	（ここでは商品名）アクチャーブリ；１０月	名詞	\N	\N	\N	620	\N
90	Нет	ない	述語	\N	\N	\N	621	\N
489	Ребёнок	（ここでは商品名）リビョーナク；幼児、子供	語彙項目の品詞	\N	\N	\N	622	\N
23	есть	ある	述語	\N	\N	\N	622	\N
490	Тоже	～もまた	副詞	\N	\N	\N	623	\N
123	какой	どんな、いかなる	疑問形容詞	\N	\N	\N	624	\N
491	шоколад	（板）チョコレート	名詞	\N	\N	\N	624	\N
452	у	～のところに	前置詞	\N	\N	\N	624	\N
492	Президент	（ここでは商品名）プレジヂェント；大統領	名詞	\N	\N	\N	625	\N
490	тоже	～もまた	副詞	\N	\N	\N	626	\N
363	вкусно	おいしい	形容詞	\N	\N	\N	626	\N
493	ладно	いい	述語副詞	\N	\N	\N	627	\N
270	лучше	より良い	形容詞	\N	\N	\N	628	\N
494	чем	～より	前置詞	\N	\N	\N	628	\N
495	ничего	何も、ひとつも～無い	述語	\N	\N	\N	628	\N
496	возьму	取る	動詞	\N	\N	\N	629	\N
36	пожалуйста	どうぞ	助詞	\N	\N	\N	630	\N
22	Здравствуйте	こんにちは	間投詞	\N	\N	\N	631	\N
266	Можно	～してよろしい	(無人称述語)	\N	\N	\N	632	\N
462	войти	(ある場所へ)入る	動詞	\N	\N	\N	632	\N
462	входи	(ある場所に)入る	動詞	\N	\N	\N	633	\N
376	Извините	すみません・ごめんなさい	動詞	\N	\N	\N	634	\N
88	опоздала	遅れる・遅刻する	動詞	\N	\N	\N	634	\N
495	Ничего	何でもない・平気だ・かまわない	述語副詞	\N	\N	\N	635	\N
104	Вот	(目前のものを指して)ほら・これ	助詞	\N	\N	\N	636	\N
58	книга	本	名詞	\N	\N	\N	636	\N
148	которую	～するところの	関係代名詞	\N	\N	\N	636	\N
281	ищешь	捜す・探す	動詞	\N	\N	\N	636	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	637	\N
122	большое	大変(な)	形容詞	\N	\N	\N	637	\N
266	Можно	～してよろしい	(無人称述語)	\N	\N	\N	638	\N
496	взять	借りる	動詞	\N	\N	\N	638	\N
24	время	時	名詞	\N	\N	\N	638	\N
234	конечно	もちろん	助詞	\N	\N	\N	639	\N
189	Сделай	(～を)する	動詞	\N	\N	\N	640	\N
497	копию	コピー・複写	名詞	\N	\N	\N	640	\N
144	если	もし～ならば	接続詞	\N	\N	\N	640	\N
498	нужно	必要である	(無人称述語)	\N	\N	\N	640	\N
499	уточнить	確認する	動詞	\N	\N	\N	641	\N
498	Нужно	～する必要がある	無人称述語	\N	\N	\N	642	\N
469	принести	持って来る、持って行く	動詞	\N	\N	\N	642	\N
28	статью	論文	名詞	\N	\N	\N	642	\N
152	до	～までに、～の前に	前置詞	\N	\N	\N	642	\N
500	субботы	土曜日	名詞	\N	\N	\N	642	\N
46	Да	はい	助詞	\N	\N	\N	643	\N
144	если	もし～なら、もし～の場合には	接続詞	\N	\N	\N	644	\N
501	нужны	必要である	形容詞	\N	\N	\N	644	\N
178	мои	私の	物主形容詞	\N	\N	\N	644	\N
502	замечания	コメント	名詞	\N	\N	\N	644	\N
234	Конечно	もちろん	挿入語	\N	\N	\N	645	\N
145	Обязательно	必ず	副詞	\N	\N	\N	646	\N
503	пятницу	金曜日	名詞	\N	\N	\N	646	\N
504	после	～のあとに、～のあとに	前置詞	\N	\N	\N	647	\N
505	обеда	昼食	名詞	\N	\N	\N	647	\N
34	кабинет	書斎、研究室	名詞	\N	\N	\N	648	\N
116	Хорошо	よい	形容詞	\N	\N	\N	649	\N
116	Хорошо	よい	形容詞	\N	\N	\N	650	\N
2	Добрый	よい	形容詞	\N	\N	\N	651	\N
3	день	昼間・日中	名詞	\N	\N	\N	651	\N
506	доктор	(医者への呼びかけとして)先生	名詞	\N	\N	\N	651	\N
507	Здравствуйте	こんにちは	間投詞	\N	\N	\N	652	\N
11	Что	何	代名詞	\N	\N	\N	653	\N
508	жалуетесь	(на+対格を)訴える・(на+対格が)不満である	動詞	\N	\N	\N	653	\N
452	У	～のもとでは	前置詞	\N	\N	\N	654	\N
509	болит	痛む・痛い	動詞	\N	\N	\N	654	\N
510	живот	お腹・腹部	名詞	\N	\N	\N	654	\N
105	Это	それは	助詞	\N	\N	\N	655	\N
511	плохо	悪い	(無人称述語)	\N	\N	\N	655	\N
61	дам	あげる・与える	動詞	\N	\N	\N	656	\N
512	таблетки	錠剤	名詞	\N	\N	\N	656	\N
403	для	～のための	前置詞	\N	\N	\N	656	\N
513	желудка	胃	名詞	\N	\N	\N	656	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	657	\N
229	Сегодня	今日	副詞	\N	\N	\N	658	\N
514	нельзя	(+不完了体動詞の不定形)～してはいけない	(無人称述語)	\N	\N	\N	658	\N
23	есть	食べる	動詞	\N	\N	\N	658	\N
515	ничего	何も～ない	代名詞	\N	\N	\N	658	\N
516	острого	(味について)刺激性の・辛い	形容詞	\N	\N	\N	658	\N
39	Понятно	わかった	助詞	\N	\N	\N	659	\N
317	И	それから	接続詞	\N	\N	\N	660	\N
134	ещё	さらに	副詞	\N	\N	\N	660	\N
514	нельзя	(+不完了体動詞の不定形)～してはいけない	(無人称述語)	\N	\N	\N	660	\N
23	есть	食べる	動詞	\N	\N	\N	660	\N
517	холодного	冷たい	形容詞	\N	\N	\N	660	\N
189	делаешь	する	動詞	\N	\N	\N	661	\N
154	завтра	明日	名詞	\N	\N	\N	662	\N
24	времени	時間	名詞	\N	\N	\N	663	\N
218	мало	少ない	述語副詞	\N	\N	\N	663	\N
113	думаешь	思う、考える	動詞	\N	\N	\N	664	\N
11	что	～ということ	接続詞	\N	\N	\N	664	\N
518	комнате	部屋	名詞	\N	\N	\N	664	\N
519	душно	蒸している、蒸し暑い	述語副詞	\N	\N	\N	664	\N
520	Открой	開ける	動詞	\N	\N	\N	665	\N
521	окно	窓	名詞	\N	\N	\N	665	\N
116	Хорошо	よい 	形容詞 	\N	\N	\N	666	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	667	\N
61	Дай	あげる、与える	動詞	\N	\N	\N	668	\N
104	Вот	はい、ほら	間投詞	\N	\N	\N	669	\N
522	передаёт	手渡す	動詞	\N	\N	\N	669	\N
212	свой	自分の	物主形容詞	\N	\N	\N	669	\N
523	Спасибо	ありがとう 	助詞 	\N	\N	\N	670	\N
185	Посмотри	見る	動詞	\N	\N	\N	671	\N
126	прошу	頼む	動詞	\N	\N	\N	672	\N
524	мешай	邪魔する	動詞	\N	\N	\N	672	\N
366	Попробуй	試食(試飲)する	動詞	\N	\N	\N	673	\N
65	этот	この	代名詞	\N	\N	\N	673	\N
491	шоколад	チョコレート	名詞	\N	\N	\N	673	\N
525	стесняйся	遠慮する	動詞	\N	\N	\N	674	\N
6	Спасибо	ありがとう	助詞	\N	\N	\N	675	\N
68	очень	とても	副詞	\N	\N	\N	676	\N
526	вкусно	おいしい	述語副詞	\N	\N	\N	676	\N
80	Так	さて	接続詞	\N	\N	\N	677	\N
11	что	何	代名詞	\N	\N	\N	677	\N
189	делать	する・行動する	動詞	\N	\N	\N	677	\N
154	завтра	明日	副詞	\N	\N	\N	677	\N
377	хочется	(+動詞不定形)～したい	動詞	\N	\N	\N	678	\N
262	посмотреть	観る・見る	動詞	\N	\N	\N	678	\N
162	новый	新しい	形容詞	\N	\N	\N	678	\N
448	фильм	映画	名詞	\N	\N	\N	678	\N
7	Хорошо	よい	(無人称述語)	\N	\N	\N	679	\N
61	давай	～しよう	動詞	\N	\N	\N	679	\N
148	котором	いずれの	代名詞	\N	\N	\N	680	\N
149	часу	時間・時	名詞	\N	\N	\N	680	\N
237	встретимся	待ち合わせする	動詞	\N	\N	\N	680	\N
299	Дома	家で・自宅で	副詞	\N	\N	\N	681	\N
262	посмотрю	見る	動詞	\N	\N	\N	681	\N
406	Интернете	インターネット	名詞	\N	\N	\N	681	\N
82	когда	いつ	副詞	\N	\N	\N	681	\N
527	начинается	始まる	動詞	\N	\N	\N	681	\N
448	фильм	映画	名詞	\N	\N	\N	681	\N
39	Понятно	わかった	述語副詞	\N	\N	\N	682	\N
54	Тогда	それでは	副詞	\N	\N	\N	683	\N
96	позвоню	電話をする	動詞	\N	\N	\N	683	\N
194	вечером	晩に・夕方に	副詞	\N	\N	\N	683	\N
493	Ладно	よい・結構だ	(無人称述語)	\N	\N	\N	684	\N
29	но	しかし	接続詞	\N	\N	\N	685	\N
96	звони	電話をかける	動詞	\N	\N	\N	685	\N
504	после	～の後で	前置詞	\N	\N	\N	685	\N
415	десяти	10	数詞	\N	\N	\N	685	\N
178	Моя	私の	代名詞	\N	\N	\N	686	\N
250	мама	母・母親	名詞	\N	\N	\N	686	\N
30	сейчас	今	副詞	\N	\N	\N	686	\N
528	больна	病気の	形容詞(短語尾女性形)	\N	\N	\N	686	\N
317	и	そして	接続詞	\N	\N	\N	686	\N
529	может быть	～かもしれない	挿入語句	\N	\N	\N	686	\N
378	будет спать	眠っている	動詞	\N	\N	\N	686	\N
530	сдать	提出する	動詞	\N	\N	\N	687	\N
531	сдавать	提出する	動詞	\N	\N	\N	688	\N
133	Почему	なぜ、どうして	疑問詞	\N	\N	\N	689	\N
532	слышал	聞く	動詞	\N	\N	\N	690	\N
410	Видно	～らしい	挿入語	\N	\N	\N	691	\N
533	обстоятельства	事情、状況	名詞	\N	\N	\N	691	\N
534	изменились	変わる	動詞	\N	\N	\N	691	\N
350	слишком	余りに、過度に、～過ぎる	副詞	\N	\N	\N	692	\N
535	некогда	～する暇が無い	述語	\N	\N	\N	692	\N
536	решил	～することにする、決心する	動詞	\N	\N	\N	693	\N
537	заставлять	～させる	動詞	\N	\N	\N	693	\N
450	語彙項目の文中での形	語彙項目の文中での意味	語彙項目の品詞	\N	\N	\N	694	\N
538	Алло	もしもし	間投詞	\N	\N	\N	695	\N
539	Аллё	もしもし	間投詞	\N	\N	\N	696	\N
105	это	(強調)	助詞	\N	\N	\N	696	\N
220	говорит	話す	動詞	\N	\N	\N	696	\N
266	Можно	～できる	(無人称述語)	\N	\N	\N	697	\N
126	попросить	呼ぶ	動詞	\N	\N	\N	697	\N
87	я	私（が）	代名詞	\N	\N	\N	698	\N
22	Здравствуй	こんにちは	間投詞	\N	\N	\N	699	\N
22	Здравствуй	こんにちは	間投詞	\N	\N	\N	700	\N
25	хотела	(+動詞不定形)～したい	動詞	\N	\N	\N	701	\N
26	бы	～したい(仮定法)	助詞	\N	\N	\N	701	\N
540	пригласить	招く	動詞	\N	\N	\N	701	\N
199	гости	客	名詞	\N	\N	\N	701	\N
452	У	～のもとには	前置詞	\N	\N	\N	702	\N
178	моей	私の	代名詞(女性単数生格形)	\N	\N	\N	702	\N
541	сестры	姉または妹	名詞	\N	\N	\N	702	\N
31	будет	ある		\N	\N	\N	702	\N
3	день	日	名詞	\N	\N	\N	702	\N
102	рождения	誕生	名詞	\N	\N	\N	702	\N
424	Правда	本当である	述語副詞	\N	\N	\N	703	\N
82	Когда	いつ	副詞	\N	\N	\N	704	\N
3	день	日	名詞	\N	\N	\N	704	\N
102	рождения	誕生	名詞	\N	\N	\N	704	\N
470	следующее	次の	形容詞	\N	\N	\N	705	\N
542	воскресенье	日曜日	名詞	\N	\N	\N	705	\N
543	есть	ある		\N	\N	\N	706	\N
544	планы	予定	名詞	\N	\N	\N	706	\N
90	Нет	いいえ	助詞	\N	\N	\N	707	\N
31	буду	(未来をあらわす)		\N	\N	\N	707	\N
195	свободен	用事のない・暇な	形容詞(短語尾男性単数)	\N	\N	\N	707	\N
54	Тогда	それでは	接続詞	\N	\N	\N	708	\N
37	приходи	来る・やって来る	動詞	\N	\N	\N	708	\N
150	шесть	6	数詞	\N	\N	\N	709	\N
149	часов	時・時間	名詞	\N	\N	\N	709	\N
7	Хорошо	わかった	述語副詞	\N	\N	\N	710	\N
37	приду	来る・行く	動詞	\N	\N	\N	711	\N
411	с	～とともに	前置詞	\N	\N	\N	711	\N
445	удовольствием	喜び	名詞	\N	\N	\N	711	\N
7	лучше	よりよく	副詞	\N	\N	\N	712	\N
218	мало	少ない	数量代名詞	\N	\N	\N	713	\N
545	слов	語・単語	名詞	\N	\N	\N	713	\N
189	делать	する	動詞	\N	\N	\N	714	\N
116	Хорошо	よい	形容詞	\N	\N	\N	715	\N
546	больше	（もっと）多く	副詞（比較級）	\N	\N	\N	715	\N
172	читать	読む	動詞	\N	\N	\N	715	\N
123	Какие	いかなる、どんな	疑問詞	\N	\N	\N	716	\N
58	книги	本	名詞	\N	\N	\N	716	\N
483	например	例えば	挿入語	\N	\N	\N	716	\N
547	советую	助言する	動詞	\N	\N	\N	717	\N
548	культуре	文化	名詞	\N	\N	\N	717	\N
549	истории	歴史	名詞	\N	\N	\N	717	\N
550	литературе	文学	名詞	\N	\N	\N	717	\N
186	Привет	やあ	名詞	\N	\N	\N	718	\N
186	Привет	やあ	名詞	\N	\N	\N	719	\N
31	был	いる		\N	\N	\N	720	\N
551	уроке	授業	名詞	\N	\N	\N	720	\N
552	английского	イギリスの・英語の	形容詞	\N	\N	\N	720	\N
553	языка	言語・～語	名詞	\N	\N	\N	720	\N
31	был	いる		\N	\N	\N	721	\N
8	А	ところで	接続詞	\N	\N	\N	722	\N
11	что	何	代名詞	\N	\N	\N	722	\N
377	хочется	～したい	動詞	\N	\N	\N	723	\N
343	чтобы	～すること	接続詞	\N	\N	\N	723	\N
155	показал	見せる	動詞	\N	\N	\N	723	\N
287	твою	きみの	代名詞	\N	\N	\N	723	\N
554	тетрадь	ノート	名詞	\N	\N	\N	723	\N
187	Ой	ああ・まあ	間投詞	\N	\N	\N	724	\N
555	опять	再び	副詞	\N	\N	\N	724	\N
555	опять	再び	副詞	\N	\N	\N	725	\N
556	заснула	寝入る・眠り込む	動詞	\N	\N	\N	725	\N
105	Это	(強調)	助詞	\N	\N	\N	726	\N
319	пятый	5番目の	数詞	\N	\N	\N	726	\N
349	раз	回・回数	名詞	\N	\N	\N	726	\N
155	показываю	見せる	動詞	\N	\N	\N	726	\N
554	тетрадь	ノート	名詞	\N	\N	\N	726	\N
376	Извини	許す	動詞	\N	\N	\N	727	\N
557	сердись	怒る	動詞	\N	\N	\N	728	\N
68	очень	とても	副詞	\N	\N	\N	729	\N
558	благодарна	感謝している	形容詞(短語尾・女性単数)	\N	\N	\N	729	\N
493	ладно	仕方がない	(無人称述語)	\N	\N	\N	730	\N
559	просто	まったく・本当に	助詞	\N	\N	\N	731	\N
25	хочу	～したい	動詞	\N	\N	\N	731	\N
343	чтобы	～ということ	接続詞	\N	\N	\N	731	\N
270	лучше	より良く	形容詞(比較級)	\N	\N	\N	731	\N
258	училась	勉強する	動詞	\N	\N	\N	731	\N
560	Добро пожаловать 	ようこそ	成句	\N	\N	\N	732	\N
561	долетели	（飛行機で）行き着く、到着する	動詞	\N	\N	\N	733	\N
562	отлично	すばらしい気分だ、非常に満足だ	無人称述語	\N	\N	\N	734	\N
92	должен	～しなければいけない	形容詞短語尾	\N	\N	\N	735	\N
394	немного	少し、ちょっと	副詞	\N	\N	\N	735	\N
563	устал	疲れる	動詞	\N	\N	\N	735	\N
564	отдохните	休息する	動詞	\N	\N	\N	736	\N
565	гостинице	ホテル	名詞	\N	\N	\N	736	\N
566	выспаться	しっかり眠る、十分睡眠を取る	動詞	\N	\N	\N	737	\N
567	вспомнила	思い出す	動詞	\N	\N	\N	738	\N
294	спросить	尋ねる	動詞	\N	\N	\N	739	\N
300	заранее	あらかじめ、前もって	副詞	\N	\N	\N	739	\N
359	города	町、都市	名詞	\N	\N	\N	740	\N
568	посетить	訪れる、訪問する	動詞	\N	\N	\N	740	\N
569	кроме	～以外に、～の他に	前置詞	\N	\N	\N	740	\N
25	хочу	～（動詞の不定形）したい	動詞	\N	\N	\N	741	\N
262	посмотреть	見る	動詞	\N	\N	\N	741	\N
570	Казань	カザン	（固有）名詞	\N	\N	\N	741	\N
116	Хорошо	よい	形容詞	\N	\N	\N	742	\N
134	ещё	他に	副詞	\N	\N	\N	743	\N
71	Санкт-Петербург	サンクト・ペテルブルク	（固有）名詞	\N	\N	\N	744	\N
48	там	そこに（で）、あそこに（で）	副詞	\N	\N	\N	745	\N
571	родной	自分の生まれた	形容詞	\N	\N	\N	746	\N
74	живут	住んでいる、生活している	動詞	\N	\N	\N	747	\N
572	родители	両親	名詞	\N	\N	\N	747	\N
184	Кстати	ところで	接続詞	\N	\N	\N	748	\N
377	хочется	～したいと思う	動詞	\N	\N	\N	748	\N
129	пора	～する時間だ	無人称述語	\N	\N	\N	749	\N
573	ужинать	夕食をとる	動詞	\N	\N	\N	749	\N
574	на самом деле	実際、実を言うと	成句	\N	\N	\N	750	\N
54	Тогда	それなら、では	副詞	\N	\N	\N	751	\N
61	давайте	～しよう	動詞	\N	\N	\N	751	\N
232	пойдём	行く、出かける	動詞	\N	\N	\N	751	\N
565	гостиницу	ホテル	名詞	\N	\N	\N	751	\N
116	хороший	良い	形容詞	\N	\N	\N	752	\N
575	ресторан	レストラン	名詞	\N	\N	\N	752	\N
22	Здравствуйте	こんにちは	間投詞	\N	\N	\N	753	\N
576	дорогие	親愛なる	形容詞	\N	\N	\N	753	\N
137	друзья	友人	名詞	\N	\N	\N	753	\N
577	Разрешите	許す	動詞	\N	\N	\N	754	\N
578	представить	紹介する	動詞	\N	\N	\N	754	\N
162	новую	新しい	形容詞	\N	\N	\N	754	\N
67	студентку	(女子の)大学生	名詞	\N	\N	\N	754	\N
65	Это	こちら	代名詞	\N	\N	\N	755	\N
36	Пожалуйста	どうぞ	助詞	\N	\N	\N	756	\N
577	Разрешите	許す	動詞	\N	\N	\N	757	\N
579	представиться	自己紹介する	動詞	\N	\N	\N	757	\N
63	зовут	呼ぶ	動詞	\N	\N	\N	758	\N
36	Пожалуйста	どうか・どうぞ	助詞	\N	\N	\N	759	\N
559	просто	簡単に	副詞	\N	\N	\N	759	\N
140	из	～から	前置詞	\N	\N	\N	760	\N
580	Петербурга	(サンクト・)ペテルブルク	固有名詞	\N	\N	\N	760	\N
276	приехала	(乗り物で)来る・到着する	動詞	\N	\N	\N	761	\N
84	Москву	モスクワ	固有名詞	\N	\N	\N	761	\N
78	пять	5	数詞	\N	\N	\N	761	\N
3	дней	日	名詞	\N	\N	\N	761	\N
86	назад	～前に	副詞	\N	\N	\N	761	\N
30	сейчас	今	副詞	\N	\N	\N	762	\N
74	живу	住んでいる	動詞	\N	\N	\N	762	\N
452	у	～のもとに	前置詞	\N	\N	\N	762	\N
178	моей	私の	代名詞	\N	\N	\N	762	\N
581	бабушки	祖母・おばあちゃん	名詞	\N	\N	\N	762	\N
123	каком	どんな	代名詞	\N	\N	\N	763	\N
582	факультете	(大学の)学部	名詞	\N	\N	\N	763	\N
258	учитесь	勉強する	動詞	\N	\N	\N	763	\N
258	учусь	勉強する	動詞	\N	\N	\N	764	\N
583	филологическом	言語-文学研究の・文献学の	形容詞	\N	\N	\N	764	\N
1021		\N		\N	\N	\N	749	\N
582	факультете	(大学の)学部	名詞	\N	\N	\N	764	\N
584	отделении	(大学の)学科	名詞	\N	\N	\N	765	\N
585	славянских	スラヴの	形容詞	\N	\N	\N	765	\N
553	языков	言語	名詞	\N	\N	\N	765	\N
123	каком	どんな	代名詞	\N	\N	\N	766	\N
586	курсе	学年	名詞	\N	\N	\N	766	\N
311	третьем	3番目の	数詞	\N	\N	\N	767	\N
586	курсе	学年	名詞	\N	\N	\N	767	\N
80	Так	では	接続詞	\N	\N	\N	768	\N
6	спасибо	ありがとう	助詞	\N	\N	\N	768	\N
576	дорогие	親愛なる	形容詞	\N	\N	\N	769	\N
137	друзья	友人	名詞	\N	\N	\N	769	\N
543	есть	ある		\N	\N	\N	769	\N
587	вопросы	質問	名詞	\N	\N	\N	769	\N
589		\N		\N	\N	\N	467	\N
898	брат	\N		\N	\N	\N	409	\N
1084		\N		\N	\N	\N	216	\N
747	билет	\N		\N	\N	\N	368	\N
849	сам	\N		\N	\N	\N	445	\N
1009		\N		\N	\N	\N	147	\N
667		\N		\N	\N	\N	408	\N
651	Сколько	\N		\N	\N	\N	406	\N
652		\N		\N	\N	\N	368	\N
638		\N		\N	\N	\N	466	\N
1064		\N		\N	\N	\N	770	\N
1049		\N		\N	\N	\N	155	\N
614	спорт	\N		\N	\N	\N	398	\N
687	столу	\N		\N	\N	\N	315	\N
717	студент	\N		\N	\N	\N	417	\N
1010		\N		\N	\N	\N	331	\N
824	здание	\N		\N	\N	\N	261	\N
693		\N		\N	\N	\N	213	\N
793		\N		\N	\N	\N	259	\N
592	иностранец	\N		\N	\N	\N	377	\N
640		\N		\N	\N	\N	38	\N
640		\N		\N	\N	\N	201	\N
696	где	\N		\N	\N	\N	399	\N
935		\N		\N	\N	\N	12	\N
997		\N		\N	\N	\N	117	\N
836		\N		\N	\N	\N	63	\N
1063		\N		\N	\N	\N	148	\N
1063		\N		\N	\N	\N	220	\N
1024		\N		\N	\N	\N	45	\N
1018		\N		\N	\N	\N	189	\N
1018	вечер	\N		\N	\N	\N	452	\N
784	вино	\N		\N	\N	\N	562	\N
773		\N		\N	\N	\N	499	\N
732	вопросы	\N		\N	\N	\N	769	\N
733		\N		\N	\N	\N	210	\N
987		\N		\N	\N	\N	74	\N
737		\N		\N	\N	\N	117	\N
1025		\N		\N	\N	\N	158	\N
1083		\N		\N	\N	\N	143	\N
1012		\N		\N	\N	\N	127	\N
842		\N		\N	\N	\N	31	\N
795	выхода	\N		\N	\N	\N	401	\N
845	Как	\N		\N	\N	\N	238	\N
845	как	\N		\N	\N	\N	485	\N
847	Какой	\N		\N	\N	\N	464	\N
956	карандашом	\N		\N	\N	\N	426	\N
923		\N		\N	\N	\N	226	\N
1035		\N		\N	\N	\N	568	\N
662		\N		\N	\N	\N	122	\N
642		\N		\N	\N	\N	61	\N
1026	Когда	\N		\N	\N	\N	704	\N
961		\N		\N	\N	\N	518	\N
846		\N		\N	\N	\N	182	\N
874		\N		\N	\N	\N	107	\N
839		\N		\N	\N	\N	6	\N
840		\N		\N	\N	\N	6	\N
838		\N		\N	\N	\N	187	\N
829	парке	\N		\N	\N	\N	504	\N
801		\N		\N	\N	\N	527	\N
770	будешь ... питьでの形	\N		\N	\N	\N	552	\N
1052		\N		\N	\N	\N	147	\N
757		\N		\N	\N	\N	136	\N
790	Пожалуйста	\N		\N	\N	\N	255	\N
790	пожалуйста	\N		\N	\N	\N	303	\N
794		\N		\N	\N	\N	303	\N
819		\N		\N	\N	\N	57	\N
819		\N		\N	\N	\N	153	\N
1108	Пока	\N		\N	\N	\N	372	\N
742	Простуда	\N		\N	\N	\N	585	\N
621		\N		\N	\N	\N	112	\N
723	уроке	\N		\N	\N	\N	720	\N
740	лекарство	\N		\N	\N	\N	587	\N
1023	ещё	\N		\N	\N	\N	354	\N
1023	ещё	\N		\N	\N	\N	417	\N
780		\N		\N	\N	\N	151	\N
869	хороший	\N		\N	\N	\N	752	\N
606	хорошо	\N		\N	\N	\N	541	\N
649		\N		\N	\N	\N	135	\N
902	мать	\N		\N	\N	\N	280	\N
912	мать	\N		\N	\N	\N	280	\N
984	месяцев	\N		\N	\N	\N	537	\N
752	метро	\N		\N	\N	\N	401	\N
1081		\N		\N	\N	\N	129	\N
837		\N		\N	\N	\N	36	\N
758	напиток	\N		\N	\N	\N	560	\N
705	направо	\N		\N	\N	\N	263	\N
791	Нет	\N		\N	\N	\N	291	\N
791		\N		\N	\N	\N	369	\N
1102		\N		\N	\N	\N	131	\N
862	новый	\N		\N	\N	\N	678	\N
1106	Ну	\N		\N	\N	\N	589	\N
792	Да	\N		\N	\N	\N	260	\N
792	Да	\N		\N	\N	\N	643	\N
1074		\N		\N	\N	\N	216	\N
1051		\N		\N	\N	\N	155	\N
671		\N		\N	\N	\N	548	\N
672		\N		\N	\N	\N	207	\N
710		\N		\N	\N	\N	94	\N
1050		\N		\N	\N	\N	155	\N
682	радио	\N		\N	\N	\N	545	\N
904	родители	\N		\N	\N	\N	747	\N
624		\N		\N	\N	\N	138	\N
694		\N		\N	\N	\N	263	\N
695	Там	\N		\N	\N	\N	261	\N
688		\N		\N	\N	\N	96	\N
633	телефону	\N		\N	\N	\N	377	\N
722	тетрадь	\N		\N	\N	\N	723	\N
844		\N		\N	\N	\N	41	\N
844	тот	\N		\N	\N	\N	333	\N
841		\N		\N	\N	\N	64	\N
841		\N		\N	\N	\N	556	\N
1011		\N		\N	\N	\N	168	\N
1011		\N		\N	\N	\N	222	\N
1028		\N		\N	\N	\N	126	\N
1028	Часто	\N		\N	\N	\N	412	\N
1078		\N		\N	\N	\N	120	\N
1082		\N		\N	\N	\N	120	\N
901		\N		\N	\N	\N	217	\N
1075	жена	\N		\N	\N	\N	306	\N
744	живот	\N		\N	\N	\N	654	\N
938	живот	\N		\N	\N	\N	654	\N
943	обеда	\N		\N	\N	\N	647	\N
827	окно	\N		\N	\N	\N	665	\N
835		\N		\N	\N	\N	134	\N
835		\N		\N	\N	\N	173	\N
905		\N		\N	\N	\N	280	\N
911	отец	\N		\N	\N	\N	280	\N
720		\N		\N	\N	\N	121	\N
843		\N		\N	\N	\N	37	\N
843	этот	\N		\N	\N	\N	673	\N
899	бабушки	\N		\N	\N	\N	762	\N
637	библиотеке	\N		\N	\N	\N	360	\N
1085		\N		\N	\N	\N	119	\N
700		\N		\N	\N	\N	385	\N
597	стран	\N		\N	\N	\N	473	\N
636	заняты	\N		\N	\N	\N	593	\N
873		\N		\N	\N	\N	61	\N
1041	фотографии	\N		\N	\N	\N	617	\N
1059		\N		\N	\N	\N	412	\N
1065		\N		\N	\N	\N	113	\N
594	гостиницу	\N		\N	\N	\N	751	\N
974		\N		\N	\N	\N	178	\N
674		\N		\N	\N	\N	130	\N
686		\N		\N	\N	\N	109	\N
678		\N		\N	\N	\N	122	\N
1092	красное	\N		\N	\N	\N	559	\N
1060		\N		\N	\N	\N	35	\N
735	болит	\N		\N	\N	\N	654	\N
992	среду	\N		\N	\N	\N	599	\N
865		\N		\N	\N	\N	78	\N
684		\N		\N	\N	\N	272	\N
684		\N		\N	\N	\N	275	\N
644	копировали	\N		\N	\N	\N	244	\N
660	передаёт	\N		\N	\N	\N	669	\N
600	поездке	\N		\N	\N	\N	387	\N
600	поездки	\N		\N	\N	\N	605	\N
664		\N		\N	\N	\N	177	\N
809		\N		\N	\N	\N	177	\N
995		\N		\N	\N	\N	690	\N
980		\N		\N	\N	\N	341	\N
996	пятницу	\N		\N	\N	\N	646	\N
685		\N		\N	\N	\N	109	\N
613		\N		\N	\N	\N	158	\N
604		\N		\N	\N	\N	63	\N
604	люблю	\N		\N	\N	\N	398	\N
588	ездил	\N		\N	\N	\N	606	\N
778		\N		\N	\N	\N	133	\N
778		\N		\N	\N	\N	53	\N
1056		\N		\N	\N	\N	660	\N
856		\N		\N	\N	\N	176	\N
658		\N		\N	\N	\N	134	\N
1100	начинается	\N		\N	\N	\N	572	\N
1017		\N		\N	\N	\N	129	\N
1042	нравится	\N		\N	\N	\N	312	\N
1042	нравится	\N		\N	\N	\N	493	\N
631	делать	\N		\N	\N	\N	677	\N
631	делать	\N		\N	\N	\N	714	\N
1051		\N		\N	\N	\N	550	\N
782	ресторан	\N		\N	\N	\N	752	\N
635		\N		\N	\N	\N	204	\N
635		\N		\N	\N	\N	224	\N
965	ручки	\N		\N	\N	\N	427	\N
655		\N		\N	\N	\N	112	\N
655		\N		\N	\N	\N	134	\N
1082	человек	\N		\N	\N	\N	406	\N
1091		\N		\N	\N	\N	12	\N
1091		\N		\N	\N	\N	216	\N
641		\N		\N	\N	\N	91	\N
828		\N		\N	\N	\N	207	\N
828		\N		\N	\N	\N	225	\N
834		\N		\N	\N	\N	30	\N
834		\N		\N	\N	\N	190	\N
754	открывает	\N		\N	\N	\N	473	\N
714		\N		\N	\N	\N	219	\N
985		\N		\N	\N	\N	598	\N
884		\N		\N	\N	\N	648	\N
605		\N		\N	\N	\N	348	\N
605		\N		\N	\N	\N	493	\N
1029		\N		\N	\N	\N	105	\N
721	университете	\N		\N	\N	\N	418	\N
595		\N		\N	\N	\N	52	\N
595		\N		\N	\N	\N	148	\N
968		\N		\N	\N	\N	771	\N
617		\N		\N	\N	\N	772	\N
966		\N		\N	\N	\N	773	\N
772		\N		\N	\N	\N	774	\N
969		\N		\N	\N	\N	775	\N
806		\N		\N	\N	\N	776	\N
788		\N		\N	\N	\N	777	\N
607		\N		\N	\N	\N	778	\N
864		\N		\N	\N	\N	779	\N
698		\N		\N	\N	\N	780	\N
663		\N		\N	\N	\N	781	\N
1105		\N		\N	\N	\N	782	\N
739		\N		\N	\N	\N	783	\N
738		\N		\N	\N	\N	784	\N
854		\N		\N	\N	\N	785	\N
639		\N		\N	\N	\N	786	\N
817		\N		\N	\N	\N	787	\N
1096		\N		\N	\N	\N	788	\N
924		\N		\N	\N	\N	789	\N
612		\N		\N	\N	\N	790	\N
897		\N		\N	\N	\N	791	\N
823		\N		\N	\N	\N	792	\N
618		\N		\N	\N	\N	793	\N
866		\N		\N	\N	\N	794	\N
867		\N		\N	\N	\N	795	\N
1005		\N		\N	\N	\N	796	\N
1024		\N		\N	\N	\N	797	\N
1054		\N		\N	\N	\N	798	\N
1095		\N		\N	\N	\N	799	\N
916		\N		\N	\N	\N	800	\N
1071		\N		\N	\N	\N	801	\N
776		\N		\N	\N	\N	802	\N
964		\N		\N	\N	\N	803	\N
886		\N		\N	\N	\N	804	\N
632		\N		\N	\N	\N	805	\N
709		\N		\N	\N	\N	806	\N
598		\N		\N	\N	\N	807	\N
991		\N		\N	\N	\N	808	\N
789		\N		\N	\N	\N	809	\N
1013		\N		\N	\N	\N	810	\N
887		\N		\N	\N	\N	811	\N
596		\N		\N	\N	\N	812	\N
627		\N		\N	\N	\N	813	\N
1037		\N		\N	\N	\N	814	\N
647		\N		\N	\N	\N	815	\N
743		\N		\N	\N	\N	816	\N
931		\N		\N	\N	\N	817	\N
810		\N		\N	\N	\N	818	\N
1043		\N		\N	\N	\N	819	\N
745		\N		\N	\N	\N	820	\N
881		\N		\N	\N	\N	821	\N
881		\N		\N	\N	\N	822	\N
859		\N		\N	\N	\N	823	\N
830		\N		\N	\N	\N	824	\N
963		\N		\N	\N	\N	825	\N
1080		\N		\N	\N	\N	826	\N
900		\N		\N	\N	\N	827	\N
972		\N		\N	\N	\N	828	\N
1016		\N		\N	\N	\N	829	\N
787		\N		\N	\N	\N	830	\N
648		\N		\N	\N	\N	831	\N
707		\N		\N	\N	\N	832	\N
725		\N		\N	\N	\N	833	\N
620		\N		\N	\N	\N	834	\N
650		\N		\N	\N	\N	835	\N
826		\N		\N	\N	\N	836	\N
903		\N		\N	\N	\N	837	\N
971		\N		\N	\N	\N	838	\N
1045		\N		\N	\N	\N	839	\N
1090		\N		\N	\N	\N	840	\N
1076		\N		\N	\N	\N	841	\N
645		\N		\N	\N	\N	842	\N
947		\N		\N	\N	\N	843	\N
591		\N		\N	\N	\N	844	\N
750		\N		\N	\N	\N	845	\N
890		\N		\N	\N	\N	846	\N
1093		\N		\N	\N	\N	847	\N
1002		\N		\N	\N	\N	848	\N
1068		\N		\N	\N	\N	849	\N
922		\N		\N	\N	\N	850	\N
736		\N		\N	\N	\N	851	\N
1058		\N		\N	\N	\N	852	\N
1038		\N		\N	\N	\N	853	\N
602		\N		\N	\N	\N	854	\N
1104		\N		\N	\N	\N	855	\N
1027		\N		\N	\N	\N	856	\N
975		\N		\N	\N	\N	857	\N
976		\N		\N	\N	\N	858	\N
716		\N		\N	\N	\N	859	\N
786		\N		\N	\N	\N	860	\N
768		\N		\N	\N	\N	861	\N
986		\N		\N	\N	\N	862	\N
1000		\N		\N	\N	\N	863	\N
599		\N		\N	\N	\N	864	\N
691		\N		\N	\N	\N	865	\N
1040		\N		\N	\N	\N	866	\N
760		\N		\N	\N	\N	867	\N
832		\N		\N	\N	\N	868	\N
711		\N		\N	\N	\N	869	\N
712		\N		\N	\N	\N	870	\N
800		\N		\N	\N	\N	871	\N
942		\N		\N	\N	\N	872	\N
713		\N		\N	\N	\N	873	\N
1086		\N		\N	\N	\N	874	\N
702		\N		\N	\N	\N	875	\N
846		\N		\N	\N	\N	876	\N
759		\N		\N	\N	\N	877	\N
681		\N		\N	\N	\N	878	\N
657		\N		\N	\N	\N	879	\N
825		\N		\N	\N	\N	880	\N
719		\N		\N	\N	\N	881	\N
629		\N		\N	\N	\N	882	\N
730		\N		\N	\N	\N	883	\N
858		\N		\N	\N	\N	884	\N
749		\N		\N	\N	\N	885	\N
1001		\N		\N	\N	\N	886	\N
761		\N		\N	\N	\N	887	\N
746		\N		\N	\N	\N	888	\N
775		\N		\N	\N	\N	889	\N
683		\N		\N	\N	\N	890	\N
959		\N		\N	\N	\N	891	\N
978		\N		\N	\N	\N	892	\N
863		\N		\N	\N	\N	893	\N
880		\N		\N	\N	\N	894	\N
1077		\N		\N	\N	\N	895	\N
805		\N		\N	\N	\N	896	\N
979		\N		\N	\N	\N	897	\N
940		\N		\N	\N	\N	898	\N
625		\N		\N	\N	\N	899	\N
608		\N		\N	\N	\N	900	\N
877		\N		\N	\N	\N	901	\N
1072		\N		\N	\N	\N	902	\N
762		\N		\N	\N	\N	903	\N
1079		\N		\N	\N	\N	904	\N
1039		\N		\N	\N	\N	905	\N
680		\N		\N	\N	\N	906	\N
1107		\N		\N	\N	\N	907	\N
917		\N		\N	\N	\N	908	\N
799		\N		\N	\N	\N	909	\N
706		\N		\N	\N	\N	910	\N
779		\N		\N	\N	\N	911	\N
882		\N		\N	\N	\N	912	\N
615		\N		\N	\N	\N	913	\N
914		\N		\N	\N	\N	914	\N
868		\N		\N	\N	\N	915	\N
932		\N		\N	\N	\N	916	\N
937		\N		\N	\N	\N	917	\N
774		\N		\N	\N	\N	918	\N
934		\N		\N	\N	\N	919	\N
925		\N		\N	\N	\N	920	\N
913		\N		\N	\N	\N	921	\N
920		\N		\N	\N	\N	922	\N
981		\N		\N	\N	\N	923	\N
811		\N		\N	\N	\N	924	\N
654		\N		\N	\N	\N	925	\N
661		\N		\N	\N	\N	926	\N
918		\N		\N	\N	\N	927	\N
926		\N		\N	\N	\N	928	\N
808		\N		\N	\N	\N	929	\N
982		\N		\N	\N	\N	930	\N
804		\N		\N	\N	\N	931	\N
998		\N		\N	\N	\N	932	\N
781		\N		\N	\N	\N	933	\N
734		\N		\N	\N	\N	934	\N
803		\N		\N	\N	\N	935	\N
798		\N		\N	\N	\N	936	\N
958		\N		\N	\N	\N	937	\N
1055		\N		\N	\N	\N	938	\N
1057		\N		\N	\N	\N	939	\N
616		\N		\N	\N	\N	940	\N
675		\N		\N	\N	\N	941	\N
771		\N		\N	\N	\N	942	\N
816		\N		\N	\N	\N	943	\N
1031		\N		\N	\N	\N	944	\N
619		\N		\N	\N	\N	945	\N
1032		\N		\N	\N	\N	946	\N
1033		\N		\N	\N	\N	947	\N
955		\N		\N	\N	\N	948	\N
822		\N		\N	\N	\N	949	\N
630		\N		\N	\N	\N	950	\N
676		\N		\N	\N	\N	951	\N
785		\N		\N	\N	\N	952	\N
611		\N		\N	\N	\N	953	\N
1036		\N		\N	\N	\N	954	\N
962		\N		\N	\N	\N	955	\N
609		\N		\N	\N	\N	956	\N
876		\N		\N	\N	\N	957	\N
626		\N		\N	\N	\N	958	\N
1020		\N		\N	\N	\N	959	\N
1007		\N		\N	\N	\N	960	\N
875		\N		\N	\N	\N	961	\N
919		\N		\N	\N	\N	962	\N
812		\N		\N	\N	\N	963	\N
697		\N		\N	\N	\N	964	\N
689		\N		\N	\N	\N	965	\N
690		\N		\N	\N	\N	966	\N
990		\N		\N	\N	\N	967	\N
1019		\N		\N	\N	\N	968	\N
603		\N		\N	\N	\N	969	\N
701		\N		\N	\N	\N	970	\N
802		\N		\N	\N	\N	971	\N
797		\N		\N	\N	\N	972	\N
1066		\N		\N	\N	\N	973	\N
952		\N		\N	\N	\N	975	\N
796		\N		\N	\N	\N	976	\N
953		\N		\N	\N	\N	977	\N
831		\N		\N	\N	\N	978	\N
833		\N		\N	\N	\N	979	\N
728		\N		\N	\N	\N	980	\N
622		\N		\N	\N	\N	981	\N
821		\N		\N	\N	\N	982	\N
1047		\N		\N	\N	\N	983	\N
1003		\N		\N	\N	\N	984	\N
1046		\N		\N	\N	\N	985	\N
601		\N		\N	\N	\N	986	\N
634		\N		\N	\N	\N	195	\N
1061		\N		\N	\N	\N	987	\N
1067		\N		\N	\N	\N	988	\N
623		\N		\N	\N	\N	989	\N
948		\N		\N	\N	\N	990	\N
928		\N		\N	\N	\N	991	\N
628		\N		\N	\N	\N	992	\N
929		\N		\N	\N	\N	993	\N
933		\N		\N	\N	\N	994	\N
967		\N		\N	\N	\N	995	\N
699		\N		\N	\N	\N	996	\N
883		\N		\N	\N	\N	997	\N
1044		\N		\N	\N	\N	998	\N
957		\N		\N	\N	\N	999	\N
718		\N		\N	\N	\N	1000	\N
708		\N		\N	\N	\N	1001	\N
753		\N		\N	\N	\N	1002	\N
870		\N		\N	\N	\N	1003	\N
1087		\N		\N	\N	\N	1004	\N
763		\N		\N	\N	\N	1005	\N
656		\N		\N	\N	\N	1006	\N
818		\N		\N	\N	\N	1007	\N
889		\N		\N	\N	\N	1008	\N
668		\N		\N	\N	\N	1009	\N
983		\N		\N	\N	\N	1010	\N
907		\N		\N	\N	\N	1011	\N
1098		\N		\N	\N	\N	1012	\N
872		\N		\N	\N	\N	1013	\N
871		\N		\N	\N	\N	1014	\N
769		\N		\N	\N	\N	1015	\N
945		\N		\N	\N	\N	1016	\N
989		\N		\N	\N	\N	1017	\N
1004		\N		\N	\N	\N	1018	\N
977		\N		\N	\N	\N	1019	\N
700		\N		\N	\N	\N	1020	\N
915		\N		\N	\N	\N	1021	\N
949		\N		\N	\N	\N	1022	\N
950		\N		\N	\N	\N	1023	\N
724		\N		\N	\N	\N	1024	\N
1030		\N		\N	\N	\N	1025	\N
906		\N		\N	\N	\N	1026	\N
910		\N		\N	\N	\N	1027	\N
909		\N		\N	\N	\N	1028	\N
767		\N		\N	\N	\N	1029	\N
751		\N		\N	\N	\N	1030	\N
1097		\N		\N	\N	\N	1031	\N
665		\N		\N	\N	\N	1032	\N
670		\N		\N	\N	\N	1033	\N
783		\N		\N	\N	\N	1034	\N
677		\N		\N	\N	\N	1035	\N
993		\N		\N	\N	\N	1036	\N
820		\N		\N	\N	\N	1037	\N
1073		\N		\N	\N	\N	1038	\N
748		\N		\N	\N	\N	1039	\N
777		\N		\N	\N	\N	1040	\N
764		\N		\N	\N	\N	1041	\N
1034		\N		\N	\N	\N	1042	\N
848		\N		\N	\N	\N	1043	\N
850		\N		\N	\N	\N	1044	\N
939		\N		\N	\N	\N	1045	\N
930		\N		\N	\N	\N	1046	\N
878		\N		\N	\N	\N	1047	\N
1089		\N		\N	\N	\N	1048	\N
1053		\N		\N	\N	\N	1049	\N
908		\N		\N	\N	\N	1050	\N
879		\N		\N	\N	\N	1051	\N
1099		\N		\N	\N	\N	1052	\N
851		\N		\N	\N	\N	1053	\N
855		\N		\N	\N	\N	1054	\N
646		\N		\N	\N	\N	1055	\N
853		\N		\N	\N	\N	1056	\N
861		\N		\N	\N	\N	1057	\N
1101		\N		\N	\N	\N	1059	\N
726		\N		\N	\N	\N	1060	\N
755		\N		\N	\N	\N	1061	\N
756		\N		\N	\N	\N	1062	\N
860		\N		\N	\N	\N	1064	\N
692		\N		\N	\N	\N	1065	\N
666		\N		\N	\N	\N	1066	\N
673		\N		\N	\N	\N	1067	\N
1094		\N		\N	\N	\N	1068	\N
944		\N		\N	\N	\N	1069	\N
951		\N		\N	\N	\N	1070	\N
852		\N		\N	\N	\N	1071	\N
741		\N		\N	\N	\N	1072	\N
814		\N		\N	\N	\N	1073	\N
729		\N		\N	\N	\N	1074	\N
731		\N		\N	\N	\N	1075	\N
1015		\N		\N	\N	\N	129	\N
936		\N		\N	\N	\N	1076	\N
715		\N		\N	\N	\N	1077	\N
727		\N		\N	\N	\N	1078	\N
973		\N		\N	\N	\N	1079	\N
954		\N		\N	\N	\N	1080	\N
593		\N		\N	\N	\N	1081	\N
653		\N		\N	\N	\N	1082	\N
610		\N		\N	\N	\N	1083	\N
679		\N		\N	\N	\N	1084	\N
1048		\N		\N	\N	\N	1085	\N
659		\N		\N	\N	\N	1086	\N
1088		\N		\N	\N	\N	1087	\N
941		\N		\N	\N	\N	1088	\N
765		\N		\N	\N	\N	1089	\N
960		\N		\N	\N	\N	1090	\N
766		\N		\N	\N	\N	1091	\N
988		\N		\N	\N	\N	1092	\N
857		\N		\N	\N	\N	1093	\N
921		\N		\N	\N	\N	1094	\N
813		\N		\N	\N	\N	1095	\N
999		\N		\N	\N	\N	1096	\N
970		\N		\N	\N	\N	1097	\N
815		\N		\N	\N	\N	1098	\N
892		\N		\N	\N	\N	1099	\N
1062		\N		\N	\N	\N	1100	\N
946		\N		\N	\N	\N	1101	\N
643		\N		\N	\N	\N	1102	\N
1014		\N		\N	\N	\N	1103	\N
1008		\N		\N	\N	\N	1104	\N
807		\N		\N	\N	\N	1105	\N
651		\N		\N	\N	\N	1106	\N
772		\N		\N	\N	\N	1107	\N
1110		\N		\N	\N	\N	1108	\N
1111		\N		\N	\N	\N	1109	\N
1112		\N		\N	\N	\N	1110	\N
1113		\N		\N	\N	\N	1111	\N
1114		\N		\N	\N	\N	1112	\N
669		\N		\N	\N	\N	1083	\N
896		\N		\N	\N	\N	1113	\N
1110		\N		\N	\N	\N	220	\N
1110		\N		\N	\N	\N	383	\N
16		\N		\N	\N	\N	648	\N
16		\N		\N	\N	\N	1047	\N
1116		\N		\N	\N	\N	1115	\N
1117		\N		\N	\N	\N	1116	\N
1119		\N		\N	\N	\N	1109	\N
1120		\N		\N	\N	\N	944	\N
1122		\N		\N	\N	\N	1117	\N
1124		\N		\N	\N	\N	1118	\N
94		\N		\N	\N	\N	1119	\N
1121		\N		\N	\N	\N	1093	\N
1121		\N		\N	\N	\N	779	\N
1125		\N		\N	\N	\N	1120	\N
1126		\N		\N	\N	\N	1121	\N
1115		\N		\N	\N	\N	1122	\N
1042	нравится	\N		\N	\N	\N	348	\N
1127		\N		\N	\N	\N	1123	\N
1011		\N		\N	\N	\N	1124	\N
906		\N		\N	\N	\N	1125	\N
897		\N		\N	\N	\N	1126	\N
665		\N		\N	\N	\N	1127	\N
708		\N		\N	\N	\N	1128	\N
870		\N		\N	\N	\N	1129	\N
667		\N		\N	\N	\N	1130	\N
651		\N		\N	\N	\N	1131	\N
590		\N		\N	\N	\N	1132	\N
791		\N		\N	\N	\N	1133	\N
932		\N		\N	\N	\N	917	\N
822		\N		\N	\N	\N	950	\N
790		\N		\N	\N	\N	57	\N
790		\N		\N	\N	\N	153	\N
864		\N		\N	\N	\N	1134	\N
1018		\N		\N	\N	\N	799	\N
847		\N		\N	\N	\N	876	\N
808		\N		\N	\N	\N	1135	\N
803		\N		\N	\N	\N	1136	\N
764		\N		\N	\N	\N	1137	\N
596		\N		\N	\N	\N	1039	\N
1128		\N		\N	\N	\N	1138	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ru
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

