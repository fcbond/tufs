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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO tr;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO tr;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO tr;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: tr
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


ALTER TABLE public.t_instance OWNER TO tr;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO tr;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO tr;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: tr
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


ALTER TABLE public.t_usage_classified_rel OWNER TO tr;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: tr
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


ALTER TABLE public.t_usage_inst_rel OWNER TO tr;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO tr;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO tr;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: tr
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO tr;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: tr
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


ALTER TABLE public.t_word_inst_rel OWNER TO tr;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: tr
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO tr;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: tr
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO tr;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: tr
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_index_char (id, index_char) FROM stdin;
1	A
2	B
3	C
4	Ç
5	D
6	E
7	F
8	G
9	Ğ
10	H
11	I
12	İ
13	J
14	K
15	L
16	M
17	N
18	O
19	Ö
20	P
21	R
22	S
23	Ş
24	T
25	U
26	Ü
27	V
28	Y
29	Z
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
40	Ahmet geldi.	アフメットは来た。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
253	Evet.	はい、あります。			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
449	Olur.	はい。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
490	Evet, girdim.	うん、入ったよ。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
683	Hadi içeriye girin.	さあ中に入りなさい。	\N		\N	vmod	\N	\N	\N	0	1
1	Ahmet hemen gitmeli.        	アフメットはすぐ行かなければならない。	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
2	Ben hemen gitmeliyim.                  	私はすぐ行かなければならない。       	null		\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
3	Fatma Deniz’in arkasında oturuyor.	ファトマはデニズの後ろに座っている。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
4	Fotoğrafları zarfın içine koydum.	写真を封筒の中に入れた。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
5	Arabanın altından bir kedi çıktı.	車の下から猫が出てきた	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
6	Şehrin ortasında çarşı var. 	町のまんなかに商店街がある。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
7	Uğur’un sayesinde iş çabuk bitti.      	ウウルのおかげで仕事ははやく終わった。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
8	Türkiye hakkında biraz konuşalım.	トルコについて少し話しましょう。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
9	Bu roman Yaşar Kemal tarafından yazıldı.	この小説はヤシャル・ケマルによって書かれた。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
10	Ben babamın yerine geldim. 	私は父の代わりに来ました。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
11	Trenin gecikmesi yüzünden derse geç kaldım. 	列車の遅れのため授業に遅刻した。	null		\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
12	Ahmet Bey doktor mu?　Evet, doktor./ Hayır, doktor değil.	アフメット氏は医者ですか？　はい、医者です。/いいえ、医者ではありません。	null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
13	Çiçekler güzel mi? Evet, güzel./ Hayır, güzel değil.	花々は美しいですか？はい、美しいです。/いいえ、美しくありません。	null		\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
14	Merhaba, nasılsınız ?          	 こんにちは、ごきげんいかがですか。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
15	İyiyim, teşekkür ederim. 	元気です、ありがとう。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
16	 Siz nasılsınız ?     	あなたはいかがですか？	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
17	Ben de iyiyim, teşekkür ederim.	私も元気です。ありがとう。	null		\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
18	Ahmet Japonca öğreniyor.	アフメットは日本語を学んでいる。	null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
19	Her gün Japonca gazete okuyor.	彼は毎日日本語の新聞を読んでいる。	null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
20	Türkçe öğreniyor.	彼はトルコ語を学んでいる。	null		\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
21	Ahmet Japonca biliyor mu ?	アフメットは日本語を知っていますか？	null		\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
22	Öğrenciler derste hiç uyumuyor.	学生たちは授業中決して眠らない。	null		\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
23	Türkçe öğreniyoruz.	私たちはトルコ語を学んでいます。	null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
24	Şimdi çalışıyor musunuz ?	今、働いているのですか。	null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
25	Sigara içmiyorum.	私は煙草は吸わない。	null		\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
26	Üniversitede Türkçe öğreniyoruz.	私たちは大学でトルコ語を学んでいます。	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
27	Nerede oturuyorsunuz ?	どこに住んでいますか？	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
28	Tokyo'da oturuyorum.	東京に住んでいます。 	null		\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
29	Konser saat yedide başladı.	コンサートは７時に始まった。	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
30	Ayhan Bey bugün geç kalktı.	アイハン氏は今日遅く起きた。	null		\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
31	Ders başladı mı?	授業は始まったかい。	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
32	Ahmet ödev yaptı mı?	アフメットは宿題をやったのか？	null		\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
33	Süleyman dün okula gelmedi.	スレイマンは昨日学校に来なかった。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
34	Henüz karar vermedi.	彼はまだ決めていない。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
35	Evde ekmek kalmadı.	家にパンが残っていない。	null		\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
36	Ali İstanbul’a gitti.	アリはイスタンブルへ行った。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
37	Okula yeni öğrenciler geldi．	学校に新しい学生たちが来た。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
38	Öğretmen bize soru sordu.	先生は私達に質問した。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
39	Okul istasyona yakın.	学校は駅に近い。	null		\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
41	Ben geldim.	私は来た。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
42	Biz geldik.	私たちは来た。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
43	Geldin.	君は来た。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
44	Geldiniz.	君たち/あなた/あなたがたは来た。	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
45	Hoş geldin.	「よく来たね。」（客を迎える表現　senに対して）	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
46	Hoş geldiniz.	「君たちよく来たね。」「よくいらっしゃいました。」（客を迎える表現　sizに対して）	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
47	Hoş bulduk.	直訳すると、「お会いできて喜ばしいことです。」の意。（上の２つに対する返答）	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	\N
48	Memnun oldum.	「お知り合いになれてうれしく思います。」（初対面の時のあいさつ）	null		\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
49	Osman dün gelmiş.	きのうオスマンが来たらしい／来たそうだ。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
50	Yağmur yağmış.	雨が降ったらしい／降ったそうだ。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
51	Kahve bitmiş.	コーヒーが終わっちゃってるよ。	null		\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
52	Nasıl ? Yemekler güzel olmuş mu ?　	どう、料理はおいしくできている？	null		\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
53	Süleyman dün işe gitmemiş.	スレイマンはきのう仕事に行かなかったそうだ。	null		\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
54	Dün çok içmişim.	私はきのうたくさん飲んだみたいだ。	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
55	İyi çalışmamışsın.	君はちゃんと勉強しなかったようだね。	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
56	İyi seçmiş miyim ?	私はうまく選んだだろうか。 	null		\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
57	Mustafa arka kapıdan çıktı.	ムスタファは裏のドアから出た。	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
58	Yoğurt sütten yapılır.	ヨーグルトはミルクから作られる。	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
59	İstanbul Tokyo’dan güzel.	イスタンブルは東京より美しい。	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
60	Nereden geliyorsunuz ? (Hangi ülkedensiniz ?)	どちらからですか。（どちらのお国からですか。）	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
61	İngiltere’den geliyorum. (İngiltere’denim.)	　イギリスからです。	null		\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
62	Bugün Ahmet gelecek.	今日はアフメットが来る。	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
63	Yarın okul başlayacak.	明日（から）学校が始まる。	null		\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
64	Ağustosta ders olmayacak mı?	8月に授業はないですか。	null		\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
65	　　Ağustosta ders olmayacak.　	8月に授業はない。	null		\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
66	Kışın yağmur yağar.	冬には雨が降る。（地中海性気候だから）	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
67	Fatma sabah erken kalkar. 	ファトマは朝早く起きる。 （そういう習慣だ、早起きする人だ）	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
68	Acele işe şeytan karışır.	急ぐ仕事には悪魔が口を出す。［諺］	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
69	Mehmet yarın gelir.	メフメットは明日来るだろう。（と私は思うが、客観的な根拠があるわけではない） 	null		\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
70	O çocuklar Türkçe konuşur mu ?     	あの子どもたちはトルコ語が話せるのか。	null		\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
71	Murat öyle şey yapmaz.	ムラトはそんなことはしない。	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
72	Dağ dağa kavuşmaz, insan insana kavuşur.　　　　	山は山にめぐり会わないが、人は人にめぐり会う。［諺］	null		\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
776	Beraber öğle yemeği yiyelim.	一緒にお昼ご飯を食べよう。	\N		\N	vmod	\N	\N	\N	0	1
73	Ahmet artık kalkmalı mı ?            	アフメットはもう出発しないといけないのか。	null		\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
74	Otobüsler, trenler geç kalmamalı.	バスや電車は遅れてはならない。	null		\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
75	Daha çok çalışmalıyız. 	私たちはもっと働かなければならない。	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
76	Sağlığınıza daha çok dikkat etmelisiniz.                                                      	あなたはもっと健康に注意しなければなりません。	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
77	Saat kaçta istasyonda olmalısın ?    	君は何時に駅にいないといけないのか。	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
78	Hemen gitmeli miyim?      	すぐに行かなければなりませんか。	null		\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
79	Yardım edeyim mi ?          	手伝いましょうか。	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
80	Yavaş yavaş kalkalım mı ?                     	そろそろ行こうか。	null		\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
81	Bu akşam sinemaya gitmeyelim de evde kalalım.　　	今晩は映画に行かないで家にいましょう。	null		\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
82	Deftere bu cümleyi yaz.                   	ノートにこの文を書きなさい（senに対して）	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
83	Deftere bu cümleyi yazın.       	ノートにこの文を書きなさい。（sizに対して）	null		\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
84	Yağmur yağsın.　　	雨が降りますように。	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
85	Ahmet hemen buraya gelsin.　　 	アフメットにすぐここへ来てもらいなさい。/アフメットをすぐここへ来させなさい。	null		\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
86	Ahmet buraya gelsin mi ?	アフメットをここへ来させましょうか。 	null		\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
87	Çocoklar havuzun kenarında oynamasınlar.　　　	池の近くで子供たちが遊ばないように。/池の近くで子供たちを遊ばせるな。 	null		\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
88	Raftaki mallar pahalı.                      	棚にある品物は高い。 	null		\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
89	Ağabeyimin bisikleti yeni, benimki eski.	兄の自転車は新しいが私のは古い。	null		\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
90	Türkiye’nin başkenti Ankara’dır.                	トルコの首都はアンカラです。	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
91	Sigara içmek yasaktır.     	タバコを吸うことは禁じられています。	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
92	Nasılsınız ? İyisinizdir inşallah.                                  	ご機嫌いかがですか。きっとお元気のことでしょう。	null		\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
93	Osman çok çalışkan. Her gün çalışıyor.　	オスマンはとても勤勉だ。毎日働いている。	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
94	Osman çok çalışkandı. Her gün çalışıyordu.　　　	オスマンはとても勤勉だった。毎日働いていた。	null		\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
95	Şimdi televizyon seyrediyormuş.      	今テレビを見ているそうだ。	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
96	O şarkıcı çok ünlüymüş.                     	その歌手はとても有名だそうだ。	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
97	Güzel bir prenses varmış.                        	一人の美しい王女がいたそうだ。	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
98	Yarından itibaren hava sıcaklığı artacakmış.    	明日から気温が高くなるそうだ。	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
99	Her sabah bu parka yaşlı bir adam gelirmiş.　　	毎朝この公園に一人の老人が来るそうだ。	null		\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
100	Bundan başka ne istiyorsunuz ?   	 このほかに何がほしいですか。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
101	Dünden beri boğazım ağrıyor.	昨日から喉が痛い。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
102	Tatilden önce sınav var.     	休みの前に試験がある。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
103	Türkiye’ye gitmeden önce biraz Türkçe öğrenin.	トルコに行く前に少しトルコ語を学びなさい。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
104	Bu işi bitirdikten sonra yemeğe çıkalım.	この仕事を終わらせた後で食事に出かけよう。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
105	Sınavdan sonra sinemaya gittik.         	試験の後で映画館に行った。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
106	Başka sorunuz var mı ?       	他に質問はありますか。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
107	Önce suyu kaynatın, sonra içine sebzeleri koyun.	まずお湯をわかして下さい。それからその中に野菜を入れて下さい。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
108	İki yıl önce Japonya’ya geldim.	２年前に日本に来ました。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	\N
109	Otuz dakika sonra uçağımız kalkacak. 	３０分後に私たちの飛行機が出る。 	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
110	Zamanında çalışmadı. Onun için sınıfta kaldı.	必要な時に勉強しなかった。そのため、留年した。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
111	Türkiye’ye gitmek için para biriktiriyorum.	トルコに行くためにお金をためています。	null		\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
112	Fatma Deniz’in arkasında oturuyor.	ファトマはデニズの後ろに座っている。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
113	Fotoğrafları zarfın içine koydum.	写真を封筒の中に入れた。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
114	Arabanın altından bir kedi çıktı.	車の下から猫が出てきた	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
115	Şehrin ortasında çarşı var. 	町のまんなかに商店街がある。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
116	Uğur’un sayesinde iş çabuk bitti.      	ウウルのおかげで仕事ははやく終わった。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	\N
117	Türkiye hakkında biraz konuşalım.	トルコについて少し話しましょう。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
118	Bu roman Yaşar Kemal tarafından yazıldı.	この小説はヤシャル・ケマルによって書かれた。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	\N
119	Ben babamın yerine geldim. 	私は父の代わりに来ました。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
120	Trenin gecikmesi yüzünden derse geç kaldım. 	列車の遅れのため授業に遅刻した。	null		\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
121	Öğrenciler o kitabı okuyor.  	学生たちはその本を読んでいる。	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
122	O gazete tüm Türkiye'de okunuyor.	その新聞はトルコ中で読まれている。	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
123	Yazarlar jürisi Uğur’a ödül verdi.	書評委員はウウルに賞を与えた。	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
124	Yazarlar jürisi tarafından Uğur’a ödül verildi.	書評委員によってウウルに賞が与えられた。	null		\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
125	Bayramlarda yaşlılar ziyaret edilir ve elleri öpülür.	バイラムでは（みんな）お年寄りを訪問し、彼らの手にキスする。	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
126	Dünkü partide yenildi, içildi, çok eğlenildi.	昨日のパーティーでは（みんな）食べて、飲んで、とても楽しんだ。	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
127	Burada sigara içilmez. 	ここではたばこは吸えない。	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
128	Harajuku’ya nasıl gidilir ?	原宿にはどうやって行けますか。	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
129	Burada park edilmez.	 ここには駐車できない。駐車してはいけない。	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
130	Bu kapıdan girilmez. 	この入り口からは入れない。	null		\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
131	Sana borç verebilirim.	君にお金をあげてもいいよ。	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
132	Buraya oturabilir miyim?	 ここにすわってもいいですか。	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
133	Beni her zaman telefonla arayabilirsiniz.	いつでも私に電話してかまわない。	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
134	Bugün yağmur yağabilir. 	今日雨が降るかもしれない。	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
135	Kapıyı açabilir misiniz ?	ドアを開けてもらえますか。	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
136	Buraya gelebilir misiniz ?	ここまで来てもらえますか。	null		\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
137	Biraz Türkçe'yi anlıyorum. Ama iyi konuşamıyorum.	トルコ語は少しわかります。でもうまくは話せません。	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
138	Konuşmacı çok hızlı konuştu. Anlayabildiniz mi?	講師はとても速く話しました。理解できましたか。	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
139	Hayır, hiç anlayamadık.	いいえ、全く理解できませんでした。	null		\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
140	Hangi ülkeye gitmek istiyorsunuz ?	 どの国に行きたいですか。	null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
141	Size bir şey söylemek istiyorum. 	あなたにひとつ言いたい。	null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
142	Ne yemek istersiniz ? 	何が食べたいですか。	null		\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
143	Belediye Başkanı "metro inşaatını bitirmekteyiz" dedi.	市長は「地下鉄建設を終わらせているところだ」と言った。	null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
144	Otobanlar inşa edilmektedir.	高速道路が建設されつつある。	null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
145	Depremin ilk gününde her yerden yardım gelmekteydi.	地震の当日、各地から援助が来ていた。	null		\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
146	Altı ay önce Türkçeöğrenmeye başladım.	６ヶ月前にトルコ語を勉強し始めました	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
147	Ama ders çalışmayı hiç sevmedim.	しかし授業の勉強をするのは大嫌いでした。	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
148	Artık Türkçe öğrenmekten vazgeçtim.	もうトルコ語を学ぶことはあきらめました。	null		\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
149	Hatice çarşıya gitti. Alışveriş yaptı.	ハティージェは商店街へ行った。買い物をした。	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
150	Hatice çarşıya gidip alışveriş yaptı.	ハティージェは商店街へ行って買い物をした。	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
151	Çarşıya gidip alışveriş yaptım. 	私は商店街に行って買い物をした。	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
152	Telefon edip soralım.  	電話して聞いてみましょう。	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
153	Oturup çay için, bekleyin.	座ってお茶を飲んで下さい、待ってください。	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
154	Fatma çarşıya gidip alışveriş yapmadan eve döndü.	ファトマは商店街に行って買い物をせずに家へ帰った。	null		\N	gmod	instances076.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	\N
155	Selim gülerek anlattı.	セリムは笑いながら説明した。	null		\N	gmod	instances077.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
156	Çocuk annesini görünce sustu.	子供は母親を見るとおとなしくなった。	null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
157	O yazıyı okuyunca şaşırdım.  	その記事を読んで驚いた。	null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
158	Yalan söyleyince yüzü kızarır.	嘘をつくと顔が赤くなる。	null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
159	Yücel gelince çıkalım. 	ユジェルが来たら、出かけよう。	null		\N	gmod	instances078.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	\N
160	Enver hiç durmadan çalışıyor.            	エンヴェルは全然休まないで働いている。	null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
161	Yanlışlık yapmadan yabancı dil öğrenemezsiniz.	間違いをせずに外国語を身につけることはできません。	null		\N	gmod	instances079.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
162	Türkiye’ye gitmeden önce biraz Türkçe öğrenin.	トルコに行く前に少しトルコ語を学びなさい。	null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
163	Bu işi bitirdikten sonra yemeğe çıkalım.	この仕事を終わらせた後で食事に出かけよう。	null		\N	gmod	instances080.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
164	İbrahim Japonya’ya geldi. Doğru.	イブラヒムは日本に来た。確かだ。	null		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	\N
165	İbrahim’in Japonya’ya geldiği doğru.	イブラヒムが日本に来たということは確かだ。	null		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	\N
166	İbrahim’in Japonya’ya geldiğini duydum.	イブラヒムが日本に来たということを聞いた。 	null		\N	gmod	instances087.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	\N
167	Merhaba Nilgün Hanım.	こんにちは、ニルギュンさん。			\N	dmod	tr01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
168	Merhaba Mehmet Bey.	こんにちは、メフメットさん。			\N	dmod	tr01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
169	Nasılsınız?	お元気ですか？			\N	dmod	tr01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
170	İyiyim, teşekkür ederim.	元気です、ありがとうございます。			\N	dmod	tr01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
171	Siz nasılsınız?	あなたはお元気ですか？			\N	dmod	tr01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
172	Ben de iyiyim, teşekkür ederim.	私も元気です、ありがとうございます。			\N	dmod	tr01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
173	A, Pınar, merhaba.	あ、プナルさん、こんにちは。			\N	dmod	tr02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
174	Merhaba.	こんにちは。			\N	dmod	tr02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
175	Gönderdiğin kitapları aldım ve çok sevindim.	送ってくださった本を受け取りました、どうもありがとうございます。			\N	dmod	tr02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
176	Kitapların eline geçmesine ben de çok sevindim.	届いて本当によかったですね。			\N	dmod	tr02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
177	Çok teşekkür ederim, sana çok zahmet oldu.	本当にありがとうございました、お忙しいところを。			\N	dmod	tr02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
178	Rica ederim、hiç önemli değil.	いいえ、とんでもありません。			\N	dmod	tr02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
179	Mehmet, gel sana balkondan manzarayı göstereyim.	メフメット、ちょっと来て、バルコニーから景色を見せてあげよう。			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
180	Buranın manzarası çok güzel.	ここからの景色はとてもきれいだよ。			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
181	Evet, gerçekten de manzarası çok güzelmiş.	うん、ほんとうだ、とてもいい景色だね。			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
182	Bak, şu karşıdaki yüksek binayı görüyor musun?	ほら、あそこにある高いビルが見える？			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
183	Hangi bina?	どれ？			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
184	Sol tarafında büyük bir cami olan bina.	左側に大きいモスクがあるビルだよ。			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
185	A, evet.	あ、うん。			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
186	Gördüm.	見えるよ。			\N	dmod	tr03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
187	Merhaba.	こんにちは。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
188	Merhaba.	こんにちは。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
189	Benim ismim Fehmi.	私の名前はフェヒミです。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
190	Ankaralıyım.	アンカラ出身です。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
191	Üçüncü sınıf öğrencisiyim.	３年生です。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
192	Benim adım da Gülsüm.	私の名前はギュルスムです。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
193	Ben de Ankaralıyım.	私もアンカラ出身です。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
194	Tanıştığımıza memnun oldum.	お会いできてうれしいです。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
195	Ben de memnun oldum.	私もお会いできてうれしいです。			\N	dmod	tr04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
196	Alo, Emine?	もしもし、エミネ？			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
197	Efendim Cemil.	はい、ジェミル。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
198	Şu anda müsait misin?	今大丈夫？			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
199	Evet, müsaidim.	うん、大丈夫。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
200	Dün beni niçin aramadın?	昨日どうして電話くれなかったの？			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
201	Bütün gün senden telefon bekledim.	一日中あなたからの電話を待っていたのに。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
202	Ben de onun için aradım.	私もそのことで電話したんです。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
203	Dün arayamadığım için özür dilerim.	昨日電話できなくてごめんなさい。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
204	Kusura bakma.	許してね。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
205	Peki, affettim.	いいよ、許してあげるよ。			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
206	Ama bir daha olmasın!	でも、二度としないようにね！			\N	dmod	tr05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
207	Doğum günün kutlu olsun Aslı!	誕生日おめでとう、アスル！			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
208	Çok teşekkür ederim Bülent.	どうもありがとう、ビュレントさん。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
209	Bu da senin doğum günü hediyen!	これは君の誕生日プレゼント。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
210	Buyur.	どうぞ。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
211	Ay, hiç gereği yoktu.	わー、必要ないのに。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
212	Aaa, en sevdiğim çikolata.	あ、一番好きなチョコレートだ。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
213	Çok teşekkürler.	どうもありがとう。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
214	Nasıl, hediyeni beğendin mi?	どう、プレゼントは気に入った？			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
215	Evet, çok beğendim.	はい、とても。			\N	dmod	tr06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
216	Oldukça uzun bir yolculuk oldu, değil mi?	ずいぶん長旅になりましたね。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
217	Evet, çok yoruldum.	ええ、とても疲れました。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
218	Ama sonunda geldik.	でもようやく着きました。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
219	Ben buradan taksiye bineceğim.	私はここからタクシーに乗ります。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
220	Benim evim buradan fazla uzak değil.	私の家はここからあまり遠くありません。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
221	O yüzden yürüyeceğim.	ですから歩きます。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
222	Anladım.	わかりました。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
223	Hoşça kalın.	さようなら。			\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
224	Hoşça kalın.	さようなら。	挨拶する		\N	dmod	tr07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
225	Hoş geldiniz efendim.	いらっしゃいませ。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
226	Hoş bulduk.	どうも。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
227	Büyük boy bir defter arıyorum.	大判のノートを探しています。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
228	Kaç yaprak olsun?	何ページのものですか？			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
229	Yüz yirmi yaprak.	１２０ページです。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
230	Burada bir tane var.	ここに１冊あります。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
231	Buyurun.	どうぞ			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
232	Kaç lira acaba?	おいくらでしょうか？			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
233	Dört milyon.	４ミリオンです。（４００万トルコリラです。）			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
234	Oo, bayağı pahalıymış.	え、ずいぶん高いんですね。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
235	Daha ucuzu yok mu?	もっと安いのはありませんか。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
236	Var, ama o birinci hamur değil.	ありますけど、最高級ではないですよ。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
237	Onun fiyatı iki milyon lira.	値段は２ミリオンです。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
238	Olsun, ben ucuz olanını alayım.	いいです、私は安い方を買います。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
239	Buyurun.	どうぞ。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	\N
240	Teşekkür ederim.	ありがとう。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	\N
241	Hayırlı işler.	商売が繁盛しますように。			\N	dmod	tr08.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[2]	\N	\N	\N
242	Emine, İran'a gideceğini duydum.	エミネさん、イランに行くって聞いたんだけど。			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
243	Evet, bu ay sonunda gidiyorum.	うん、今月末に行くよ。			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
244	Sen daha önce hiç İran'a gittin mi?	あなた前にイランに行ったことがある？			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
245	Evet, geçen sene gittim.	うん、去年行ったよ。			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
246	Çok eğlenceliydi.	とても楽しかった。			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
247	Öyle mi?	あ、そう。			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
248	Peki, İran ile ilgili bana bir tavsiyen var mı?	じゃ、イランについて何かアドバイスがある？			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
249	Yanında mutlaka baş örtüsü götür.	スカーフを絶対持っていくこと！			\N	dmod	tr09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
250	Merhaba Ayşe.	こんにちは、アイシェさん。			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
251	Merhaba.	こんにちは。			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
252	Yarın için herhangi bir planın var mı?	明日何か予定がありますか？			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
254	Sabah erkenden Beşiktaş’a gitmeyi düşünüyorum.	朝早くからベシクタシュに行こうと思っています。			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
255	Öğleden sonra da randevum var.	それから、午後待ち合わせがあります。			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
256	Peki, akşam için bir planın var mı?	じゃ、夜は予定がありますか？			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
257	Hayır, yok.	いえ、ありません。			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
258	Neden?	なぜですか？			\N	dmod	tr10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
259	Alo, Rıza?	もしもし、ルザ？			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
260	Alo?	もしもし、			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
261	Buyur Neşe.	何、ネシェ。			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
262	Rıza, şu anda buluşacağımız yere geldim ama sen yoksun.	ルザ、今私たちが会うことにした所に着きましたが、あなたがいません。			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
263	Özür dilerim Neşe, ben şu anda yoldayım.	ごめんなさい、ネシェ、今行くところです。			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
264	Biraz geç kalacağım.	少し遅れます。			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
265	Ne kadar geç kalacaksın?	どのくらい遅くなりますか？			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
266	Fazla değil, beş dakika kadar geç kalacağım.	そんなに遅れません、５分ぐらいです。			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
267	Tamam, bekliyorum.	わかりました、待っています。			\N	dmod	tr11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
268	Merhaba Osman.	こんにちは、オスマン			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
269	Merhaba Nur.	こんにちは、ヌル。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
270	Ne haber?	元気？			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
271	İyilik.	元気よ。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
272	Bugün akşamki partiye geliyor musun?	今晩のパーティーに来る？			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
273	Ne partisi?	何のパーティー？			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
274	Benim haberim yok.	私は聞いてないけど。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
275	Ayşegül'ün doğum günü partisi.	アイシェギュルの誕生日パーティーだよ。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
276	Sen de gelsene.	君も来いよ。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
277	Olur, geleyim.	いいよ、行くね。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
278	Parti saat kaçta başlıyor?	パーティーは何時に始まるの？			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
279	Saat yedide başlayacak.	７時に始まるよ。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
280	Ama gitmeden önce hediye almamız lazım.	でも行く前にプレゼントを買わなきゃ。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
281	O yüzden akşam saat 5’te burada buluşalım.	だから夕方５時にここで会おう。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
282	Yani iki saat sonra.	つまり２時間後だね。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
283	Evet.	そうだよ。			\N	dmod	tr12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
284	Yemek için masayı hazırlayayım mı?	私は食事の準備をしようかと思うのですが。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
285	Evet.	はい。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
286	Misafirler gelmek üzeredir.	お客様がそろそろ来ますからね。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
287	Masaya kaç tane tabak lazım?	テーブルに何枚お皿が必要ですか？			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
288	Toplam yedi tane tabak lazım.	全部で７枚のお皿が必要です。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
289	Pardon, bir tane de salata için lazım.	あ、ごめんなさい、もう１枚サラダに必要です。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
290	Toplam sekiz tabak olacak.	全部で８枚になります。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
291	Anladım.	わかりました。			\N	dmod	tr13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
292	Altay, bana yardım edebilir misin?	アルタイ、私を手伝ってくれる？			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
293	Tabii.	もちろん。			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
294	Akşam yemeği için masayı hazırlayalım.	お夕飯の机の準備をしましょう。			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
295	Ben tabakları getireyim, sen de tabaklara yemek doldur, tamam mı?	私はお皿を持ってくるから、あなたはお皿に食べ物を盛りつけてね。			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
296	Tamam.	いいよ。			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
297	Ne ile doldurayım?	何で入れようか？			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
298	Çorbayı kepçe ile yavaşça doldur.	スープはお玉でゆっくり入れて、			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
299	Pilavı ise kaşık ile bol bol koy.	ピラフはスプーンでたくさん入れてね。			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
300	Peki.	わかったよ。			\N	dmod	tr14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
301	Hoş geldiniz Mehmet Bey.	ようこそ、メフメットさん。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
302	Hoş bulduk efendim.	失礼します。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
303	Öz geçmişinizi okudum.	履歴書を拝見しました。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
304	İngilizce ve Fransızca bildiğiniz yazıyor.	英語とフランス語ができると書いてあります。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
305	Ne derecede İngilizce biliyorsunuz?	英語はどの程度できますか。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
306	İyi derecede biliyorum efendim.	上級レベルです。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
307	Fransızcanız hangi seviyededir?	フランス語はどの程度ですか？			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
308	Orta seviyededir.	中級レベルです。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
309	Başka ne gibi yetenekleriniz var?	他にどのような技能がありますか？			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
310	Bilgisayar kullanabiliyorum.	コンピュータが使えます。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
311	Ayrıca biraz Almanca biliyorum.	それから、少しドイツ語ができます。			\N	dmod	tr15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
312	İsmail Hoca’yı arıyorum.	イスマイル先生を探しています。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
313	Şu anda okulda mı?	今学校にいらっしゃいますか？			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
314	Evet, okulda.	はい、いらっしゃいます。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
315	Biraz önce gördüm.	先ほど見ました。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
316	Şu anda nerede, biliyor musunuz?	今どこにいらっしゃるか、ご存じですか？			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
317	Okulun toplantı salonunda.	学校の会議室にいらっしゃいます。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
318	Öyle mi?	そうですか。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
319	Toplantı salonu nerede?	会議室はどこですか。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
320	Ana binanın üçüncü katında.	本館の三階です。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
321	Teşekkür ederim.	ありがとうございます。			\N	dmod	tr16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
322	Merhaba.	こんにちは。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
323	Merhaba.	こんにちは。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
324	Yeni elemanı gördün mü?	新しい社員を見た？			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
325	İşe bugün başladı.	仕事を今日始めたんだけど。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
326	Onu arıyorum.	彼のことを探しているんだ。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
327	Nasıl biri?	どんな人？			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
328	Yirmi beş－otuz yaşlarında.	２５－３０歳ぐらい。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
329	Boyu ne kadar?	身長はどれぐらいあるの？			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
330	Bir metre seksen santim kadar.	１８０センチぐらい。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
331	Saçı ne renk?	髪の毛のいろは？			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
332	Siyah.	くろ。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
333	Kısa, kıvırcık saçlı.	短くて、ちぢんだ髪の毛の人。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
334	Burada kimse gördün mü?	ここで誰か見ましたか。			\N	dmod	tr17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
335	İsmail Bey, iyi günler.	イスマイルさん、こんにちは。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
336	İyi günler.	こんにちは。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
337	Bugün yapacağımız toplantıyı yarına erteledik.	今日の会議を明日に延期しました。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
338	Siz ne dersiniz?	あなたはどうですか？			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
339	Yarın sizin için uygun mu?	明日は都合がいいですか？			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
340	Bana göre yarın çok uygun.	私には明日がとても都合がいいです。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
341	Toplantı yarın saat kaçta başlayacak?	会議は明日何時に始まりますか？			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
342	Öğleden sonra saat dörtte başlayacak.	午後４時に始まります。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
343	Bana sorarsanız yarın saat beşte başlamak en iyisidir.	私にとっては明日５時に始まるのが一番いいです。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
344	Çünkü herkesin işi saat beşte bitiyor.	なぜならみんなの仕事が５時に終わるからです。			\N	dmod	tr18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
345	Merhaba Burcu.	こんにちは、ブルジュ。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
347	Dünkü parti çok güzeldi, çok eğlendim.	昨日のパーティーはとても良かった、とても楽しかったね。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
348	Ben de çok eğlendim.	ぼくも本当に楽しかった。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
349	Sabaha kadar içtim.	朝まで飲みました。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
350	Evet, hepimiz sarhoş olduk.	はい、みんな酔っ払いました。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
351	Sen galiba en çok rakı içmeyi seviyorsun.	あなたはラクを飲むのが一番好きみたいですね。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
352	Evet, rakı içmeyi severim.	ええ、ラクを飲むのが好きです。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
353	Ayrıca şarabı da severim.	それからワインも好きです。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
354	Ben de şarabı çok severim.	私もワインが大好きです。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
355	Bir dahaki sefere birlikte içelim, tamam mı?	また今度一緒に飲みましょう、いいですか？			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
356	Tamam!	はい！			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
357	Sevim, televizyon seyrederken ne yapmayı seviyorsun?	セヴィム、テレビを見ながら何をするのが好き？			\N	dmod	tr20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
358	Patlamış mısır yemeyi çok seviyorum.	ポップコーンを食べるのが好き。			\N	dmod	tr20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
359	Başka ne yapmayı seviyorsun?	他に何をするのが好き？			\N	dmod	tr20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
360	Dondurma yemeye bayılıyorum.	アイスクリームを食べるのが大好き。			\N	dmod	tr20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
361	Benim de en çok bira içmek hoşuma gidiyor.	僕もビールを飲むのが一番気に入ってるんだ。			\N	dmod	tr20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
362	Alo?	もしもし。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
363	İyi günler.	こんにちは。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
364	Alo?	もしもし。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
365	İyi günler efendim, nasıl yardımcı olabilirim?	こんにちは、どうなさいましたか？			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
366	Firmanızdan geçen ay bir bilgisayar aldım.	おたくの会社から先月にコンピュータを買いました。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
367	Ancak bilgisayar şimdi çalışmıyor.	でもコンピュータが今動きません。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
368	Ne yapmam gerekir acaba?	どうすればいいでしょうか？			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
369	Önce, evde elektrik olup olmadığını kontrol ediniz.	まず、家に電気が来ているかどうか確認してください。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
370	Daha sonra, bilgisayarınızın tüm fişlerinin prize takılı olup olmadığını kontrol ediniz lütfen.	その後コンピュータのすべてのプラグがコンセントに差し込んであるかチェックしてください。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
371	Son olarak, bilgisayarınızın “başlat” tuşuna basınız.	最後にコンピュータの「スタート」キーを押してください。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
372	Evet, bastım ama bir değişiklik yok.	はい、押しましたが何も変わりません。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
373	Anladım.	わかりました。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
374	Tamir için size bir görevli göndereceğim.	修理のために、お宅に係りの者を行かせます。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
375	Çok teşekkürler.	どうもありがとうございます。			\N	dmod	tr21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
376	Şebnem, görüşmeyeli çok uzun zaman oldu.	シェブネム、ずいぶん久しぶりですね。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
377	Evet, oldukça uzun zaman oldu.	はい、本当に久しぶりです。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
378	Görmeyeli ne yapıyorsun?	会わない間はどうしていました？			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
379	Her gün ders çalışıyorum.	毎日授業の勉強をしていました。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
380	Sınavlara hazırlanıyorum.	試験の準備をしています。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
381	Anladım.	そうですか。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
382	Yarın ne yapıyorsun? 	明日は何をしますか。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
383	Yarın bir şey yapmıyorum, boşum.	明日は何もしません、暇です。			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
384	O zaman beraber sinemaya gidelim mi?	それなら一緒に映画を見に行きましょうか？			\N	dmod	tr22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
385	Şenay, duydun mu? 	シェナイ、聞いた？			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
386	İstanbul’da büyük bir deprem olacakmış.	イスタンブールで大きい地震が起こるんだって。			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
387	Evet, uzmanlar televizyonda devamlı uyarıyorlar.	うん、専門家がテレビでずっと注意していますね。			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
388	Evet. 	ええ、			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
389	Deprem olursa paniğe kapılmamalısın.	地震が起きたらパニックになってはいけません。			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
390	Önce, yakınındaki bir masanın altına girmelisin.	まず、近くの机の下に入らなければなりません。			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
391	Daha sonra?	それから？			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
392	Deprem bittikten sonra dışarı çıkmalısın.	地震がおさまったら外に出なければなりません。			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
393	Anladım.	わかりました。			\N	dmod	tr23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
394	Japonya'ya hoş geldin.	日本へようこそ。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
395	Hoş bulduk.	どうも。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
396	Japonya'ya geleli ne kadar oldu?	日本に来てどのくらいになりますか？			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
397	Yaklaşık iki ay oldu.	約２ヶ月になります。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
398	Daha yeni geldim sayılır.	まだ来たばかりです。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
399	Japon yemeklerine alıştın mı?	日本料理には慣れましたか？			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
400	Evet, bayağı alıştım.	はい、ずいぶん慣れました。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
401	En çok hangi yemeği seviyorsun?	一番好きな料理は何ですか？			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
402	En çok Tempura yemeğini seviyorum.	てんぷらが一番好きです。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
403	Peki, Türk yemekleri mi daha lezzetli yoksa Japon yemekleri mi?	では、トルコ料理の方がおいしいですか、それとも日本料理ですか？			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
404	Japon yemekleri Türk yemeklerinden daha lezzetli.	日本料理の方がトルコ料理よりもおいしいです。			\N	dmod	tr24.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
405	Günaydın Murat.	おはよう、ムラット。			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
406	Günaydın.	おはよう。			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
407	Murat, buradan Beşiktaş’a nasıl gidebilirim?	ムラット、ここからベシクタシへどうやって行くの？			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
408	Önce, biraz ilerideki duraktan otobüse binip Taksim’e gitmen gerekiyor. 	まず、少し先の停留所からバスに乗ってタクシムへ行かなきゃならないよ。			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
409	Sonra......	それから…			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
410	Oo, oldukça uzakmış.	へぇ、ずいぶん遠いんだね。			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
411	Oraya kadar ben götüreyim mi?	そこまで僕が連れて行こうか？			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
412	Hayır, teşekkürler.	いいよ、ありがとう。			\N	dmod	tr25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
413	Yarın akşam sinemaya gidelim mi?	明日の夜映画を見に行こうか？			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
414	Yarın akşam mı?	明日の夜？			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
415	Ben gidemem.	私は行けないけど。			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
416	Neden?	なんで？			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
417	Çünkü yarın bütün gün ders çalışmam gerekiyor.	なぜって明日一日中勉強しなければならないから。			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
418	Ne dersi?	何の勉強？			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
419	Sınavlara daha üç hafta var.	試験までまだ３週間あるよ。			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
420	Ders, sadece sınav zamanı çalışılmaz!	勉強は試験のときだけするもんじゃないでしょう！			\N	dmod	tr26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
421	Merhaba.	こんにちは。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
422	Merhaba.	こんにちは。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
423	Canan, senden bir isteğim olacak.	ジャナンさん、ちょっとお願いがあるんですけど。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
424	Tabii Onur.	いいですよ、オヌルさん。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
425	Buyur, seni dinliyorum.	どうぞ、何でしょうか。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
426	Yarın benim yerime sen çalışır mısın?	明日私の代わりに働いてくれますか？			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
427	Biraz rahatsızım da.	ちょっと調子が悪いから。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
428	Elbette.	もちろん。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
429	Sen biraz yat ve dinlen.	あなたは少し休んでいなさい。			\N	dmod	tr27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
430	Japonya’da trenler hızlı mıdır?	日本では電車は速いですか？			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
431	Evet, çok hızlıdır.	はい、とても速いです。			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
432	Mesela, Tokyo ile Osaka arası 550 km’dir ve ekspres tren ile 2,5 saat sürer.	例えば東京と大阪の間は550キロありますが、新幹線で2.5時間です。			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
433	Öyle mi?	そうですか。			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
434	Gerçekten çok hızlıymış.	本当に速いんですね。			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
435	Maalesef Türkiye’deki trenler çok yavaştır.	残念ですが、トルコの電車はとても遅いです。			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
436	Örneğin, trenler otobüsten daha yavaş gider.	例えば、電車はバスよりずっとゆっくり走ります。			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	1
437	İnanmıyorum!	信じられない！			\N	dmod	tr28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
438	Arzu Hanım, bu haftaki toplantıyı hangi gün yapalım?	アルズさん、今週の会議は何曜日にしましょうか？			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
439	Salı günü sizin için uygun mu?	火曜日はあなたの都合はどうですか？			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
440	Maalesef uygun değil.	残念ですが、都合が悪いです。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
441	O gün başka bir toplantım var.	その日は他の会議があります。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
442	Öyleyse cuma günü olsun.	それなら金曜日にしましょう。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
443	Ne dersiniz?	どうですか？			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
444	Maalesef, cuma günü müdür ile buluşmam gerekiyor. 	残念ですが、金曜日は部長と会わなければなりません。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
445	Peki, perşembe günü nasıl?	では、木曜日はどうですか？			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
446	Perşembe günü de meşgulüm ama öğleden sonra 	木曜日も忙しいですが、午後なら時間がありますよ。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
447	olursa zamanım var.	午後でもよろしいでしょうか。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
448	Öğleden sonra olur mu?	午後でもよろしいでしょうか。			\N	dmod	tr29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
450	Günaydın.	おはよう。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
451	Bugün "Japon mucizesi"ni anlatacağım.	今日「日本の奇跡」を説明します。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
452	Affedersin.	すみません。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
453	Buyur, Özgür.	なんでしょうか、オズギュルさん。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
454	Prezantasyona başlamadan önce beş dakika	発表を始める前に５分間、外へ出てもいいですか？			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
455	dışarıya çıkabilir miyim?				\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
456	Ne oldu Özgür?	どうしたんですか、オズギュルさん？			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
457	Rahatsız mısın yoksa?	もしかして具合が悪いんですか？			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
458	Hayır.	いいえ。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
459	Müsaade edersen, biraz dışarı çıkmak istiyorum.	すみませんが、少し外へ出たいのです。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
460	Tabii, çıkabilirsin.	もちろん、出てもいいですよ。			\N	dmod	tr30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
461	Meici Dönemini haftaya kim anlatacak?	明治時代を来週だれが説明してくれますか？			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
462	Ben anlatacağım.	私が説明します。			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
463	Meici Dönemi Japon tarihinde çok önemli.	明治時代は日本の歴史の中で大変重要です。			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
464	O yüzden çok iyi hazırlanman gerekir.	ですからよく準備しなければなりません。			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
465	Kaynak kitap da getirmem gerekir mi? 	参考の本も持ってこなければいけませんか？			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
466	Evet. 	はい。			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
467	Getirmen gerekir.	持ってこなければいけません。			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
468	Tamam, anladım.	はい、わかりました。			\N	dmod	tr31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
469	Affedersiniz hanımefendi.	ちょっと、すみません。			\N	dmod	tr32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
470	Buyurun.	はい。			\N	dmod	tr32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
471	Bu odada sigara içmek yasaktır.	この部屋は喫煙です。			\N	dmod	tr32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
472	Burada sigara içmeyiniz lütfen.	ここではタバコを吸わないでください。			\N	dmod	tr32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
473	Çok özür dilerim.	申し訳ございません。			\N	dmod	tr32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
474	Levhayı fark etmemişim.	標識に気づきませんでした。			\N	dmod	tr32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
475	Aylin, kalemimi kaybettim.	アイリン、鉛筆をなくしちゃった。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
476	Gördün mü?	見かけた？			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
477	Hayır görmedim.	いいえ、見ていないよ。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
478	Ne renk bir kalemdi?	何色の鉛筆だったの？			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
479	Kırmızı renk.	赤い色だよ。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
480	Burada masanın üzerinde bir tane var.	ここに、机の上に１本あるよ。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
481	Bu senin kalemin mi?	これはあなたの鉛筆なの？			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
482	Hayır, o benim değil.	いや、それは僕の鉛筆じゃない。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
483	Benim kalemim ondan daha kısa.	僕の鉛筆の方が短いよ。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
484	Ah, gördüm!	あれ、あった！			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
485	İşte benim kalemim burada!	ほら、僕の鉛筆はここにある。			\N	dmod	tr33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[4]	\N	\N	\N
486	Benim ağabeyim doktor.	私の兄は医者です。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
487	Efendim Dilek.	いいよ。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
488	Ne oldu?	どうしたの？			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
489	Bugün benim odama girdin mi?	今日私の部屋に入った？			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
491	Benim bilgisayarımı sen mi kullandın?	私のパソコンをあなた使ったでしょ？			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
492	Evet, ben kullandım.	うん、使ったよ。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
493	Benim bilgisayarımı bir daha kullanma lütfen.	私のパソコンを二度と使わないでください。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
494	Özür dilerim. 	ごめんね。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
495	Benim bilgisayarım bozuldu.	僕のコンピュータが壊れちゃったんだ。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
496	O yüzden kullandım.	だから使ったんだよ。			\N	dmod	tr34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
497	Ayça Hanım, günaydın. 	アイチャさん、おはようございます。			\N	dmod	tr35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
498	Günaydın efendim.	おはようございます。			\N	dmod	tr35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
499	Bugün mesaiye sizin kalmanız gerekiyormuş, doğru mu?	今日残業してくださるようですが、そうですか？			\N	dmod	tr35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
500	Hayır efendim, maalesef ben kalmıyorum.	いいえ、残念ながら私は残業しません。			\N	dmod	tr35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
501	Sevinç Hanım kalıyor.	セヴィンチさんが残業します。			\N	dmod	tr35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
502	Anladım, teşekkür ederim.	わかりました、ありがとうございます。			\N	dmod	tr35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
503	Osman ders çalışmayı hiç sevmiyor.	オスマンは勉強するのが嫌いだ。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
504	Öyle mi?	ほんと？			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
505	Çok sevindim.	よかったね。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
506	Nereye gidiyormuş?	どこに行くの？			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
507	Fransa’ya gidecekmiş.	フランスに行くそうだ。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
508	O gitmeden önce bir veda partisi vermeyi düşünüyoruz.	彼が行く前に送別会をしようと思うんだ。 			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
509	Çok güzel.	いいね。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
510	Ne zaman?	いつ？ 			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
511	Ayın 25’inde.	今月の２５日。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
512	Sen de gelir misin?	あなたも来る？			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
513	Tabii gelirim.	もちろん、行くよ。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
514	Parti nerede olacak?	パーティーはどこであるの？			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
515	Benim evimde olacak.	私の家で。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
516	İstersen sana ev adresimi yazıp vereyim.	よければ私の家の住所を書いておくけど。			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
517	Lütfen.	そうしてくれる？			\N	dmod	tr36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
518	Doktor Bey, son günlerde göğsüm ağrıyor.	先生、最近胸が痛むんです。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
519	Neden acaba?	なぜでしょうか？			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
520	İçki kullanıyor musunuz?	お酒を飲みますか？			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
521	Evet, haftada birkaç defa kullanıyorum.	はい、週に何度か飲みます。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
522	Peki, sigara içiyor musunuz?	そうですか。たばこは吸いますか？			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
523	Evet, günde bir paket içiyorum.	はい、１日に１箱吸います。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
524	Çok sigara içtiğiniz için göğsünüz ağrıyor sanırım.	たばこの吸いすぎで、胸が痛いのだと思います。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
525	Sigarayı hemen bırakmalısınız.	たばこをすぐにやめなければいけません。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
526	Ayrıca, spor yapmaya başlarsanız iyi olur.	それに、スポーツを始めるといいでしょう。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
527	Teşekkür ederim.	どうもありがとうございます。			\N	dmod	tr37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
528	Geçen ay sizden sipariş ettiğimiz mallar henüz bize ulaşmadı.	先月御社に注文した品物がまだこちらに届きません。			\N	dmod	tr38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
529	Evet, gerçekten özür dileriz.	はい、本当に申し訳ありません。			\N	dmod	tr38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
530	En kısa zamanda mallar elinizde olacak.	すぐに品物はそちらに届けます。			\N	dmod	tr38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
531	Bu ayın 15’ine kadar tüm siparişlerin bize ulaşmasını istiyorum.	今月の１５日までにすべての品物がこちらに届いていてほしいです。			\N	dmod	tr38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
532	Tamam efendim.	かしこまりました。			\N	dmod	tr38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
533	Ayın 15’inde benimle mutlaka irtibata geçin.	今月の１５日に私に必ず連絡してください。			\N	dmod	tr38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
534	Hoş geldiniz efendim.	いらっしゃいませ。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
535	Hoş bulduk.	こんにちは。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
536	Rezervasyonunuz var mı?	ご予約はうけたまわっておりますか？			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
537	Hayır.	いいえ。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
538	Tek kişilik bir oda istiyorum.	シングルの部屋が希望なんですが。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
539	Yeriniz var mi?	お部屋は空いていますか？			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
540	Evet efendim.	ございます。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
541	Nasıl bir oda istersiniz?	どんなお部屋がよろしいでしょうか。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
542	Mümkünse birinci katta bir oda istiyorum.	できれば、２階の部屋をお願いします。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
543	Bir dakika lütfen....	少々お待ちください。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
544	Evet, istediğiniz gibi bir odamız var.	ご希望のとおりのお部屋がございます。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
545	Çok güzel.	それはよかった。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
546	Hemen yerleşmek istiyorum.	すぐにチェックインしたいです。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
547	Elbette.	かしこまりました。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
548	Buyurun, sizi odanıza kadar götüreyim.	どうぞ、お部屋までご案内いたします。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
549	Teşekkür ederim.	ありがとう。			\N	dmod	tr39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
550	Günaydın.	おはよう。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
551	Günaydın Emek.	おはよう、エメッキ。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
552	Nasılsın?	元気？			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
553	İyiyim, sağ ol.	元気だよ、ありがとう。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
554	Bu, arkadaşım Arzu.	こちらが、私の友人のアルズさんです。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
555	Kendisi dün İzmir’den geldi.	昨日イズミルから来ました。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
556	Arzu, bu arkadaşım, Emek.	アルズさん、こちらが友人のエメッキさんです。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
557	Merhaba Arzu.	こんにちは、アルズさん。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
558	Tanıştığımıza çok memnun oldum.	お知り合いになれてうれしいです。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
559	Ben de memnun oldum.	私もうれしいです。			\N	dmod	tr40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
560	Yürüyerek yeme.	歩きながら食べるな。	\N		\N	vmod	\N	\N	\N	0	1
561	Ahmet kapıyı açtı.	アフメットはドアを開けた。	\N		\N	vmod	\N	\N	\N	0	1
562	O benim ablam.	あの人が私の姉です。	\N		\N	vmod	\N	\N	\N	0	1
563	Abla, buna bakar mısın?	お姉さん、これ見てくれる？	\N		\N	vmod	\N	\N	\N	0	1
564	Kırmızıbiber çok acıdır.	唐辛子はとても辛い。	\N		\N	vmod	\N	\N	\N	0	1
565	Mehmet açık mavi bir kazak aldı.	メフメットは水色のセーターを買った。	\N		\N	vmod	\N	\N	\N	0	1
566	Bugün hava açık.	今日は晴れている。	\N		\N	vmod	\N	\N	\N	0	1
567	Bunun adı dolma kalem.	これの名前は万年筆です。	\N		\N	vmod	\N	\N	\N	0	1
568	Affedersiniz, hanımefendi!	すみません、奥さん	\N		\N	vmod	\N	\N	\N	0	1
569	Kurşun ağır bir madendir.	鉛は重い鉱物だ。	\N		\N	vmod	\N	\N	\N	0	1
571	Dişim ağrıyor.	（私の）歯が痛い。	\N		\N	vmod	\N	\N	\N	0	1
572	Benim ailem Antalya'da oturuyor.	私の家族はアンタルヤに住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
573	Bakkaldan bir paket sigara aldım.	店で一箱のタバコを買った。	\N		\N	vmod	\N	\N	\N	0	1
574	Alçak tavanlı bir oda.	天井の低い部屋	\N		\N	vmod	\N	\N	\N	0	1
575	Hadi, tekrar alıştırma yapalım.	さあ、もう一度練習しよう。	\N		\N	vmod	\N	\N	\N	0	1
576	Ali'nin evinin anahtarını kaybettim.	（私は）アリの家の鍵をなくしてしまった。	\N		\N	vmod	\N	\N	\N	0	1
577	Anne, bunu alır mısın?	お母さん、これ買ってくれる？	\N		\N	vmod	\N	\N	\N	0	1
578	Meryem'in annebabası yok.	メルイェムには両親がいない。	\N		\N	vmod	\N	\N	\N	0	1
579	Girişte duran portmantonun aynasına göz attı.	彼は玄関にある帽子掛けの鏡に目をやった。	\N		\N	vmod	\N	\N	\N	0	1
580	Ben o apartmanın beşinci katında oturuyorum.	私はあのアパートの五階に住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
581	Ankara'da Aralık'ta kar yağıyor mu?	アンカラでは１２月に雪が降りますか。	\N		\N	vmod	\N	\N	\N	0	1
582	Asansörü beklerken cep telefonum çaldı.	エレベーターを待っているときに携帯電話が鳴った。	\N		\N	vmod	\N	\N	\N	0	1
583	Murat yeni ayakkabıyla okula geldi.	ムラトは新しい靴で学校に来た。	\N		\N	vmod	\N	\N	\N	0	1
584	Japonya'da Türkçe konuşabilen insan az denebilir.	日本でトルコ語を話せる人は少ないと言える。	\N		\N	vmod	\N	\N	\N	0	1
585	Seda'nın bacakları çok uzun.	セダの脚はとても長い。	\N		\N	vmod	\N	\N	\N	0	1
586	Bir otelin ağaçlıklı, çiçeklerle süslü bahçesinin önünde durmuştuk.	私たちはあるホテルの、木が生い茂って花で飾られた庭の前で立ち止まった。	\N		\N	vmod	\N	\N	\N	0	1
587	Buralarda banka var mı?	この辺りに銀行はありますか。	\N		\N	vmod	\N	\N	\N	0	1
588	Banyoda sıcak su akıyor mu?	お風呂でお湯が出ますか。	\N		\N	vmod	\N	\N	\N	0	1
589	Dışarı çıkmadan önce banyo yapayım.	出かける前に風呂を浴びよう。	\N		\N	vmod	\N	\N	\N	0	1
590	Bulaşık yıkarken bir bardak kırdı.	洗い物をしていてコップを割った。	\N		\N	vmod	\N	\N	\N	0	1
591	Soğuk almışım. Başım ağrıyor.	風邪をひいたようだ。頭が痛い。	\N		\N	vmod	\N	\N	\N	0	1
592	Bir şey olursa bu düğmeye basın.	何かあったらこのボタンを押しなさい。	\N		\N	vmod	\N	\N	\N	0	1
593	Türkiye'nin batısında Yunanistan var.	トルコの西にはギリシアがあります。	\N		\N	vmod	\N	\N	\N	0	1
594	Bazen bu yeknesak hayat beni çok sıkıyor.	ときどき、この単調な生活は私をうんざりさせる。	\N		\N	vmod	\N	\N	\N	0	1
595	O belki buradan kalkmıştır.	彼はたぶんここから出発したんだろう。	\N		\N	vmod	\N	\N	\N	0	1
596	Müdür, sırtına beyaz gömlek giymiş, ellerini göbeğinin üstünden kavuşturmuş.	所長は白いワイシャツを身に着け、手を腹の上で握っていた。	\N		\N	vmod	\N	\N	\N	0	1
598	Japonya'ya gidiyorum, biletlerim hazır.	私は日本に行くんだ。チケットも準備してある。	\N		\N	vmod	\N	\N	\N	0	1
599	Parkta atla dolaşırız.	公園で馬に乗って散歩しよう。	\N		\N	vmod	\N	\N	\N	0	1
600	Bir ay Türkiye'de kalacağım.	ひとつきトルコに滞在します。	\N		\N	vmod	\N	\N	\N	0	1
601	- Çok teşekkür ederim.\n- Bir şey değil.	「どうもありがとう」\n「どういたしまして」	\N		\N	vmod	\N	\N	\N	0	1
602	Gelecek yıl değil, bir sonraki yıl gitmeyi düşünüyorum. 	来年ではなく再来年行こうと思っています。	\N		\N	vmod	\N	\N	\N	0	1
603	Gelecek sene değil, bir sonraki sene gitmeyi düşünüyorum.	来年ではなく再来年行こうと思っています。	\N		\N	vmod	\N	\N	\N	0	1
604	Bu yıl hiç kar yağmadı.	今年は雪がまったく降らなかった。	\N		\N	vmod	\N	\N	\N	0	1
605	Hava bulutlu.	曇った天気だ。	\N		\N	vmod	\N	\N	\N	0	1
606	Burası benim memleketim.	ここは私の出身地です。	\N		\N	vmod	\N	\N	\N	0	1
607	Burnum tıkandı.	鼻が詰まった。	\N		\N	vmod	\N	\N	\N	0	1
608	Büyüklerin yanında sesim çıkmazdı.	大人たちのそばで、声を出すことができなかった。	\N		\N	vmod	\N	\N	\N	0	1
609	Kızılay'da yeni bir büyük mağaza yapıldı.	クズライに新しいデパートができた。	\N		\N	vmod	\N	\N	\N	0	1
610	Turgut buzdolabından, biraları çıkardı.	トゥルグットは冷蔵庫からビールなどを取り出した。	\N		\N	vmod	\N	\N	\N	0	1
611	Japon dilinde buna ne denir?	日本語でこれはなんと言いますか。	\N		\N	vmod	\N	\N	\N	0	1
612	Ali yeni bir ceket almış.	アリは新しいジャケットを買ったようだ。	\N		\N	vmod	\N	\N	\N	0	1
613	Elleri ceplerinde, kapıdan kapıya gidip geliyor.	手をポケットに入れ、ドアからドアへと行ったり来たりしている。	\N		\N	vmod	\N	\N	\N	0	1
614	Dünkü cumhuriyet bayramı kutlamaları gerçekten coşkuluydu.	昨日の建国祝賀会は本当ににぎやかだった。	\N		\N	vmod	\N	\N	\N	0	1
615	Cumartesi günü işin var mı?	土曜日、用事ある？	\N		\N	vmod	\N	\N	\N	0	1
616	Sultan Ahmet'te cüzdanım çalındı.	スルタン・アフメットで財布を盗まれた。	\N		\N	vmod	\N	\N	\N	0	1
617	Arkadaşım bankada çalışıyor. 	友人は銀行で働いています。	\N		\N	vmod	\N	\N	\N	0	1
618	Ahmet her akşam piano çalar.	アフメットは毎晩ピアノを弾く。	\N		\N	vmod	\N	\N	\N	0	1
619	Çantam nerede?	私のかばんはどこ？	\N		\N	vmod	\N	\N	\N	0	1
620	Her Çarşamba günü teyzeme giderim.	毎水曜日におばのところへ行きます。	\N		\N	vmod	\N	\N	\N	0	1
621	Çatalı elinden düştü, ağzı açık kaldı.	彼のフォークが手から落ち、口は開けっぱなしのままになった。	\N		\N	vmod	\N	\N	\N	0	1
622	Simdi çıkmak üzereyim.	今出かけるところです。	\N		\N	vmod	\N	\N	\N	0	1
623	Shinjuku İstasyonunda çıkış bir tane değil.	新宿駅では出口はひとつではない。	\N		\N	vmod	\N	\N	\N	0	1
624	Köşede bağdaş kurmuş, önce kunduralarını, sonra da çoraplarını çıkarmış.	隅であぐらをかいて、まず靴を、それから靴下を脱いだ。	\N		\N	vmod	\N	\N	\N	0	1
625	Japonlar çubukla yemek yerler.	日本人は箸で食事をする。	\N		\N	vmod	\N	\N	\N	0	1
626	dar ev.	狭い家	\N		\N	vmod	\N	\N	\N	0	1
627	Dedem 70 yaşında.	私のおじいさんは７０歳です。	\N		\N	vmod	\N	\N	\N	0	1
628	Bugün kaç derece?	今日は何度ですか。	\N		\N	vmod	\N	\N	\N	0	1
629	Getirdiği dergiyi çıkarıp okumaya başladı.	もってきた雑誌を取り出し、読み始めた。	\N		\N	vmod	\N	\N	\N	0	1
630	Hafta sonunda şehrin dışına çıkıyoruz.	週末、町の外に出かけます。	\N		\N	vmod	\N	\N	\N	0	1
631	Binanın doğu tarafında hastane var.	建物の東側に病院があります。	\N		\N	vmod	\N	\N	\N	0	1
632	Türkiye'de domuz eti bulmak çok zor.	トルコで豚肉を見つけるのはとても難しい。	\N		\N	vmod	\N	\N	\N	0	1
633	Saat kaçta eve döneceksin?	何時に家に帰ってくるの？	\N		\N	vmod	\N	\N	\N	0	1
634	O köşeden dönerseniz hemen evimi görürsünüz.	そこの角を曲がったらすぐに私の家が見えます。	\N		\N	vmod	\N	\N	\N	0	1
635	Hangi dükkandan aldınız?	どの店で買ったのですか。	\N		\N	vmod	\N	\N	\N	0	1
636	Dün akşam Osman'ın evine gittik, parti yaptık.	夕べオスマンの家に行ってパーティをした。	\N		\N	vmod	\N	\N	\N	0	1
637	Üç gündür duş almıyorum.	三日間シャワーを浴びていない。	\N		\N	vmod	\N	\N	\N	0	1
638	Japonların saçı genellikle düzdür.	日本人の髪はたいていまっすぐだ。	\N		\N	vmod	\N	\N	\N	0	1
639	Ekim'in hangi gününde toplantı var?	十月の何日に会議がありますか。	\N		\N	vmod	\N	\N	\N	0	1
640	Bu baharatı yemeğe eklerseniz daha iyi olur.	この香辛料を料理にくわえるともっといいですよ。	\N		\N	vmod	\N	\N	\N	0	1
641	Yeni elbise mi alacaksın?	新しい服を買うの？	\N		\N	vmod	\N	\N	\N	0	1
642	Japon Büyükelçiliği Ankara'da.	日本大使館はアンカラにある。	\N		\N	vmod	\N	\N	\N	0	1
643	Sınıfında kaç erkek var?	あなたのクラスには何人の男の子がいますか。	\N		\N	vmod	\N	\N	\N	0	1
644	Eşiniz nasıl?	奥さんはお元気ですか。	\N		\N	vmod	\N	\N	\N	0	1
645	Eşim iş için Avrupa'da oturuyor.	妻は仕事でヨーロッパに住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
646	Ankara'ya paket göndermek istiyorum.	アンカラに荷物を送りたい。	\N		\N	vmod	\N	\N	\N	0	1
647	Et ve balık, hangisini daha çok seviyorsunuz?	肉と魚、どちらのほうが好きですか。	\N		\N	vmod	\N	\N	\N	0	1
648	Son günlerde kısa etek çok moda.	最近、ミニスカートがとても流行している。	\N		\N	vmod	\N	\N	\N	0	1
649	Evvelki gün İstanbul'a varmış.	おとといイスタンブルに着いたそうだ。	\N		\N	vmod	\N	\N	\N	0	1
650	O evvelki yıl, ilk defa Japonya'ya geldi.	彼はおととし初めて日本に来た。	\N		\N	vmod	\N	\N	\N	0	1
651	Okul Eylül'de mi başlıyor?	学校は九月から始まるのですか。	\N		\N	vmod	\N	\N	\N	0	1
652	Pazar günü hep evde film seyrediyorum.	日曜はいつも家で映画を観ている。	\N		\N	vmod	\N	\N	\N	0	1
653	Fotoğraf makinen ne marka?	あなたのカメラはどこのメーカーの？	\N		\N	vmod	\N	\N	\N	0	1
654	Artık geç oldu, eve gidelim.	もう遅くなった。家に帰ろう。	\N		\N	vmod	\N	\N	\N	0	1
655	Geçen hafta sınavın sonucu belli oldu.	先週、テストの結果が出た。	\N		\N	vmod	\N	\N	\N	0	1
656	Geçen yıl hiç Türkiye'ye gidemedim.	去年は一度もトルコに行かれなかった。	\N		\N	vmod	\N	\N	\N	0	1
657	Gelecek ay önemli bir yarış var.	来月、大事な試合があります。	\N		\N	vmod	\N	\N	\N	0	1
658	Gelecek hafta görüşürüz.	来週会いましょう。	\N		\N	vmod	\N	\N	\N	0	1
659	Annem gençken şarkıcıydı.	母は若いころ歌手だった。	\N		\N	vmod	\N	\N	\N	0	1
660	Çok geniş bir odada ikimiz kaldık.	とても広い部屋に私たち二人が泊まった。	\N		\N	vmod	\N	\N	\N	0	1
661	Ona hiç bir şey verme. Aldıktan sonra bir daha geri vermez.	彼には何も貸すな。もらったあと二度と返さないから。	\N		\N	vmod	\N	\N	\N	0	1
662	Girişte mi para vereceğiz?	入り口で料金を払うのですか。	\N		\N	vmod	\N	\N	\N	0	1
663	Nereye gidiyorsun? Daha işin bitmedi.	どこに行くの。まだ仕事が終わってないよ。	\N		\N	vmod	\N	\N	\N	0	1
664	Gitar çalmayı biliyor musun?	ギターの弾き方を知っていますか。	\N		\N	vmod	\N	\N	\N	0	1
665	Yeni pantalon giydim ama kimse fark etmedi.	新しいズボンをはいたが誰も気づかなかった。	\N		\N	vmod	\N	\N	\N	0	1
666	Partide ne giyeceğimi bilmiyorum.	パーティで何を着ればいいのかわからない。	\N		\N	vmod	\N	\N	\N	0	1
667	O zaman saat 4'te okulda görüşelim.	じゃあ4時に学校で会おう。	\N		\N	vmod	\N	\N	\N	0	1
668	Ben gözlük takmayı hiç sevmem.	私は眼鏡をかけるのがちっとも好きではない。	\N		\N	vmod	\N	\N	\N	0	1
669	Erkek güçlü olmalıdır.	男は強くなくてはならない。	\N		\N	vmod	\N	\N	\N	0	1
670	Güney Afrika'da deprem olmuş.	南アフリカで地震があったそうだ。	\N		\N	vmod	\N	\N	\N	0	1
671	Bu yemek çok güzel olmuş.	この料理はとてもおいしくできてるよ。	\N		\N	vmod	\N	\N	\N	0	1
672	Hadi ben gidiyorum. Yarın görüşürüz.	では私は行きます。明日会いましょう。	\N		\N	vmod	\N	\N	\N	0	1
673	Bu eşya çok hafif.	この荷物はとても軽い。	\N		\N	vmod	\N	\N	\N	0	1
674	İşim hala bitmedi.	仕事がまだ終わらない。	\N		\N	vmod	\N	\N	\N	0	1
675	Dünya haritasını arıyorum da.	世界地図を探しているのですが。	\N		\N	vmod	\N	\N	\N	0	1
676	Babamın hastalığı ne?	お父さんの病気はなに？	\N		\N	vmod	\N	\N	\N	0	1
677	Nihayet hava açtı.	やっと晴れたね。	\N		\N	vmod	\N	\N	\N	0	1
678	3 Haziran'da parti yapacağız.	六月三日にパーティをします。	\N		\N	vmod	\N	\N	\N	0	1
679	Her ay aileme para gönderiyorum.	毎月家族にお金を送っています。	\N		\N	vmod	\N	\N	\N	0	1
680	Her hafta hastaneye gitmem gerekiyor.	私は毎週病院へ行かなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
681	Bu toplantı her yıl yapılıyor mu?	この会議は毎年行われていますか。	\N		\N	vmod	\N	\N	\N	0	1
682	Size ilginç bir hikaye anlatayım.	あなたたちに面白い話をしてあげましょう。	\N		\N	vmod	\N	\N	\N	0	1
684	Bunun içinde ne var?	この中には何が入ってるんですか。	\N		\N	vmod	\N	\N	\N	0	1
685	İlk defa bu kadar güzel şarap içtim.	初めてこんなにおいしいワインを飲んだよ。	\N		\N	vmod	\N	\N	\N	0	1
686	Başka içecek var mı?	ほかに飲み物はありますか。	\N		\N	vmod	\N	\N	\N	0	1
687	Sizin içinizde içki içmeyen var mı?	あなた方の中でお酒を飲まない人はいますか。	\N		\N	vmod	\N	\N	\N	0	1
688	Mutlaka ilaç alman lazım.	必ず薬を飲まなくてはいけないよ。	\N		\N	vmod	\N	\N	\N	0	1
689	Japonya'da okullar ilkbaharda açılır.	日本では学校は春に始まる。	\N		\N	vmod	\N	\N	\N	0	1
690	Hangi durakta ineceğiz?	どの停留所で降りるのですか。	\N		\N	vmod	\N	\N	\N	0	1
691	Duygu'nun çok ince parmakları var.	ドゥイグの指はとても細い。	\N		\N	vmod	\N	\N	\N	0	1
692	Bu kağıt çok inceymiş.	この紙はとても薄いようだ。	\N		\N	vmod	\N	\N	\N	0	1
693	Oradaki kırmızı çantayı istiyorum.	あそこの赤いバッグが欲しい。	\N		\N	vmod	\N	\N	\N	0	1
694	Bence de o çok iyi fikir.	私もそれはとてもよい考えだと思います。	\N		\N	vmod	\N	\N	\N	0	1
695	Kaç tane istiyorsun?	いくつ欲しいの？	\N		\N	vmod	\N	\N	\N	0	1
696	Kadınlar alışveriş yapmayı sever.	女の人は買い物をするのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
697	Siz, Türkler kahvaltıda ne yiyiyorsunuz?	あなたたちトルコ人は朝ごはんに何を食べるのですか。	\N		\N	vmod	\N	\N	\N	0	1
698	Kahverengi bir mont aldım.	茶色のコートを買った。	\N		\N	vmod	\N	\N	\N	0	1
699	Kafede oturalım mı?	喫茶店で座ろうか。	\N		\N	vmod	\N	\N	\N	0	1
700	Kalabalık insanların önünde konuşmaya alışık değilim.	大勢の人の前で話すことに慣れていません。	\N		\N	vmod	\N	\N	\N	0	1
701	Orada tükenmez kalem var mı?	そこにボールペンがありますか。	\N		\N	vmod	\N	\N	\N	0	1
702	Çok kalın bir kitap okuyorsun.	とても厚い本を読んでるね。	\N		\N	vmod	\N	\N	\N	0	1
703	Daha kalın kalem yok mu?	もっと太いペンないの？	\N		\N	vmod	\N	\N	\N	0	1
704	Bugün saat kaçta kalktın?	今日何時に起きたの。	\N		\N	vmod	\N	\N	\N	0	1
705	Hoca geldi. Hemen kalktık.	先生がやってきた。私たちはすぐに立った。	\N		\N	vmod	\N	\N	\N	0	1
707	Okulun kapısında görüşürüz.	学校の門のところで会おう。	\N		\N	vmod	\N	\N	\N	0	1
708	Buralarda karakol var mı?	このあたりに交番はありますか。	\N		\N	vmod	\N	\N	\N	0	1
709	Karanlıkta hiç bir şey göremiyorum.	暗いので何も見えない。	\N		\N	vmod	\N	\N	\N	0	1
710	Kaç kardeşiniz var?	何人兄弟がいますか。	\N		\N	vmod	\N	\N	\N	0	1
711	Yanında bir karıkoca oturuyordu.	隣に一組の夫婦が住んでいた。	\N		\N	vmod	\N	\N	\N	0	1
712	Karnım ağrıyor.	おなかが痛い。	\N		\N	vmod	\N	\N	\N	0	1
713	Karnım açtı.	おなかが空いた。	\N		\N	vmod	\N	\N	\N	0	1
714	Arkadaşıma kartpostal gönderdim.	友人にはがきを送った。	\N		\N	vmod	\N	\N	\N	0	1
715	Ayşe hala kasetçalar kullanıyor.	アイシェはいまだにラジカセを使っている。	\N		\N	vmod	\N	\N	\N	0	1
716	Kasım onbirinci ay.	11月は11番目の月です。	\N		\N	vmod	\N	\N	\N	0	1
717	Kavşakta arkadaşımla karşılaştım.	交差点で友人に出会った。	\N		\N	vmod	\N	\N	\N	0	1
718	Kendim yapabilirim.	自分でできます。	\N		\N	vmod	\N	\N	\N	0	1
719	Parmağımı kestim.	指を切った。	\N		\N	vmod	\N	\N	\N	0	1
720	Kim geldi?	誰が来たの？	\N		\N	vmod	\N	\N	\N	0	1
721	Kiminle görüşüyorum?	〔電話で〕どちら様ですか。	\N		\N	vmod	\N	\N	\N	0	1
722	Ben kız okulunda okudum.	私は女子校で学びました。	\N		\N	vmod	\N	\N	\N	0	1
723	İki kız kardeşim var.	私には二人の姉妹がいます。	\N		\N	vmod	\N	\N	\N	0	1
724	Kocam avukat.	私の夫は弁護士です。	\N		\N	vmod	\N	\N	\N	0	1
725	Ali beni kolumdan tuttu.	アリは私の腕をつかんだ。	\N		\N	vmod	\N	\N	\N	0	1
726	Türkler için Japonca kolay mı?	トルコ人にとって日本語は易しいですか。	\N		\N	vmod	\N	\N	\N	0	1
727	Kompozisyon yazmam lazım.	作文を書かなければならない。	\N		\N	vmod	\N	\N	\N	0	1
728	Yarın onunla konuşmayı düşünüyorum.	明日彼と話そうと思っています。	\N		\N	vmod	\N	\N	\N	0	1
729	Bunun kopyası var mı?\n	これのコピーはありますか。	\N		\N	vmod	\N	\N	\N	0	1
730	Hindistan'da çok çeşitli köri var.	インドにはとてもたくさんの種類のカレーがある。	\N		\N	vmod	\N	\N	\N	0	1
731	Öğrenciler koridorda toplandılar.	生徒たちは廊下に集まった。	\N		\N	vmod	\N	\N	\N	0	1
732	Sağlık için her gün koşuyorum.	健康のために毎日走っている。	\N		\N	vmod	\N	\N	\N	0	1
733	Durum çok kötü!	状況はとても悪い。	\N		\N	vmod	\N	\N	\N	0	1
734	Basketbolu çok kötü oynarım.	私はバスケットボールが下手です。	\N		\N	vmod	\N	\N	\N	0	1
735	Şeker koymuyor musun?	お砂糖入れないの？	\N		\N	vmod	\N	\N	\N	0	1
736	Ben koyu renk severim.	私は濃い色が好きです。	\N		\N	vmod	\N	\N	\N	0	1
737	Babama kravat hediye etmeyi düşünüyorum.	父にネクタイをプレゼントしようと思う。	\N		\N	vmod	\N	\N	\N	0	1
738	Oradaki kül tablasını alır mısın?	そこの灰皿をとってくれる？	\N		\N	vmod	\N	\N	\N	0	1
739	Onun kulağında üç tane küpe vardı.	彼女の耳には三つのピアスがあった。	\N		\N	vmod	\N	\N	\N	0	1
740	Çubuk bizim için çok kullanışlı.	箸は私たちにとってとても便利です。	\N		\N	vmod	\N	\N	\N	0	1
741	Kaseye pilav koydum.	お椀にピラフを入れた。	\N		\N	vmod	\N	\N	\N	0	1
742	Sınavda kurşun kalem kullanmalısınız.	テストでは鉛筆を使わなくてはなりません。	\N		\N	vmod	\N	\N	\N	0	1
743	Kütüphanede ders çalışıyorum.	図書館で勉強しています。	\N		\N	vmod	\N	\N	\N	0	1
744	Yarın kuzenimin düğününe gideceğim.	明日いとこの結婚式に行きます。	\N		\N	vmod	\N	\N	\N	0	1
745	Kuzey bölgede savaş başlamış.	北部で戦争が始まったらしい。	\N		\N	vmod	\N	\N	\N	0	1
746	Affedersiniz, lavabo nerede?	すみません、お手洗いはどこですか。	\N		\N	vmod	\N	\N	\N	0	1
747	Türkiye'de salata için mutlaka limon lazım.	トルコではサラダには必ずレモンが要る。	\N		\N	vmod	\N	\N	\N	0	1
748	O lokantada yemek yiyelim.	あのレストランで食事をしよう。	\N		\N	vmod	\N	\N	\N	0	1
749	Lütfen bana da yardım edebilir misiniz?	どうか私にも手伝ってくださいませんか。	\N		\N	vmod	\N	\N	\N	0	1
750	Manavda taze patlıcan buldum.	八百屋で新鮮なナスビを見つけた。	\N		\N	vmod	\N	\N	\N	0	1
751	8 Mart Dünya Kadınlar Günü'dür.	3月8日は「世界女性の日」だ。	\N		\N	vmod	\N	\N	\N	0	1
752	Mavi gözlü kız.	青い目の少女。	\N		\N	vmod	\N	\N	\N	0	1
753	5 Mayıs Çocuklar Günü'dür.	5月5日は子供の日だ。	\N		\N	vmod	\N	\N	\N	0	1
754	Bana mektup yazar mısın?	私に手紙を書いてくれますか。	\N		\N	vmod	\N	\N	\N	0	1
755	Mendil getirmeyi unuttum.	ハンカチを持ってくるのを忘れた。	\N		\N	vmod	\N	\N	\N	0	1
756	Çocuk merdivenden düşmüş.	子供が階段から落ちたようだ。	\N		\N	vmod	\N	\N	\N	0	1
757	İstanbul'da metro yapılmaktadır.	イスタンブルで地下鉄がつくられているところだ。	\N		\N	vmod	\N	\N	\N	0	1
758	Türkiye'de meyveler ucuz.	トルコでは果物が安い。	\N		\N	vmod	\N	\N	\N	0	1
759	Mutfaktan annemin beni çağırdığını duydum.	台所から母が私を呼ぶのを聞いた。	\N		\N	vmod	\N	\N	\N	0	1
760	Müzik sanatlardan biridir.	音楽は芸術のひとつだ。	\N		\N	vmod	\N	\N	\N	0	1
761	Ne zaman onu öğrendin?	いつそれを知ったの？	\N		\N	vmod	\N	\N	\N	0	1
762	O fotoğrafın negatifi bende.	その写真のフィルムは私のところだよ。	\N		\N	vmod	\N	\N	\N	0	1
763	Kahraman Maraş neresi?	カフラマンマラシュってどこ？	\N		\N	vmod	\N	\N	\N	0	1
764	Nisan'da benim doğum günüm var.	4月に私の誕生日があります。	\N		\N	vmod	\N	\N	\N	0	1
765	Türkiye'de 1 Ocak tatil mi?	トルコで1月1日は休みですか。	\N		\N	vmod	\N	\N	\N	0	1
766	Ben kitap okumayı çok severim.	私は本を読むのがとても好きです。	\N		\N	vmod	\N	\N	\N	0	1
767	Murat Japonya'ya gittikten sonra çok çalışkan oldu.	ムラトは日本へ行ってからとても勤勉になった。	\N		\N	vmod	\N	\N	\N	0	1
768	Onlar nereye gittiler acaba?	彼らはどこへ行ったんだろう。	\N		\N	vmod	\N	\N	\N	0	1
769	Orası çok sakin bir yer.	そこはとても静かなところです。	\N		\N	vmod	\N	\N	\N	0	1
770	Orada bekleyen benim abim.	あそこで待ってるのは私の兄です。	\N		\N	vmod	\N	\N	\N	0	1
771	Biraz oturup muhabbet ederiz.	ちょっと座っておしゃべりしよう。	\N		\N	vmod	\N	\N	\N	0	1
772	Ablan nerede oturuyor?	お姉さんはどこに住んでいるの？	\N		\N	vmod	\N	\N	\N	0	1
773	Çocuklar bahçede oynarken yağmur yağmaya başladı.	子供たちが庭で遊んでいると雨が降り出した。	\N		\N	vmod	\N	\N	\N	0	1
774	Yarın işim var ama öbür gün boşum.	明日は用事があるけどあさってなら空いてるよ。	\N		\N	vmod	\N	\N	\N	0	1
775	Bunu öğleye kadar bitirmem gerekiyor.	これを昼までに終わらせなくてはならない。	\N		\N	vmod	\N	\N	\N	0	1
777	Öğleden önce işim var.	午前は用事がある。	\N		\N	vmod	\N	\N	\N	0	1
778	Babam bana matematik öğretti.	父が数学を教えてくれた。	\N		\N	vmod	\N	\N	\N	0	1
779	Sizin bölümde kaç Japon öğretmen var?	あなたたちの学科には何人の日本人の先生がいますか。	\N		\N	vmod	\N	\N	\N	0	1
780	Herkes cennete gitmek ister. Öyleyse neden ölmek isteyen yok?	誰もが天国に行きたがる。なのにどうして死にたがる人はいないんだろう。	\N		\N	vmod	\N	\N	\N	0	1
781	Yeni palto almam gerekiyor.	新しいコートを買わなくてはならない。	\N		\N	vmod	\N	\N	\N	0	1
782	Kot pantolon alalım.	ジーンズを買おう。	\N		\N	vmod	\N	\N	\N	0	1
783	Her Pazartesi toplantı var.	毎月曜に会議があります。	\N		\N	vmod	\N	\N	\N	0	1
784	Hırsız pencereden eve girmiş.	泥棒は窓から家に入ったようだ。	\N		\N	vmod	\N	\N	\N	0	1
785	Peynir, Türkler için vazgeçilmez bir yiyecektir.	チーズはトルコ人にとって不可欠な"食べ物だ。	\N		\N	vmod	\N	\N	\N	0	1
786	Dokunma! O çok pis!	触らないで。すごく汚いよ。	\N		\N	vmod	\N	\N	\N	0	1
787	Son günlerde plak çok az kullanılıyor.	最近はレコードはほとんど使われていない。	\N		\N	vmod	\N	\N	\N	0	1
788	Bak orada polis var.	見て、あそこにお巡りさんがいるよ。	\N		\N	vmod	\N	\N	\N	0	1
789	Oğlum polis oldu.	息子は警官になった。	\N		\N	vmod	\N	\N	\N	0	1
790	Buralarda posta kutusu var mı?	このへんにポストはありますか。	\N		\N	vmod	\N	\N	\N	0	1
791	Postane kaça kadar açık?	郵便局は何時まで開いていますか。	\N		\N	vmod	\N	\N	\N	0	1
792	Daha pratik yapman lazım.	君はもっと練習しなくてはいけないよ。	\N		\N	vmod	\N	\N	\N	0	1
793	Nerede pul alabilirim?	切手をどこで買うことができますか。	\N		\N	vmod	\N	\N	\N	0	1
794	Radyo dinlemeyi severim.	ラジオを聴くのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
795	Çocuklar boyayla resim çiziyorlardı.	子供たちは絵の具で絵を描いていた。	\N		\N	vmod	\N	\N	\N	0	1
796	İstanbul'da kaç tane Japon restoranı var?	イスタンブルにはいくつ日本レストランがありますか。	\N		\N	vmod	\N	\N	\N	0	1
797	Rüzgar esiyor.	風が吹いている。	\N		\N	vmod	\N	\N	\N	0	1
798	Ona kol saati almayı düşünüyorum.	彼に腕時計を買おうと思っている。	\N		\N	vmod	\N	\N	\N	0	1
799	Senin sağ tarafında kim oturuyor?	君の右側には誰が座っているの。	\N		\N	vmod	\N	\N	\N	0	1
800	Sandalyede kedi oturuyor.	いすに猫が座っている。	\N		\N	vmod	\N	\N	\N	0	1
801	Saçları sapsarı olmuş, başka insan gibiydi.	髪はまっ黄色になり、別の人のようだった。	\N		\N	vmod	\N	\N	\N	0	1
802	Orada neler satılıyor?	そこでは何が売られているの？	\N		\N	vmod	\N	\N	\N	0	1
803			\N		\N	vmod	\N	\N	\N	0	1
804	Yavaş yavaş serin oluyor.	だんだん涼しくなってきた。	\N		\N	vmod	\N	\N	\N	0	1
805	Sessiz olun!	静かにしなさい！	\N		\N	vmod	\N	\N	\N	0	1
806	Seni çok seviyorum.	あなたが大好き。	\N		\N	vmod	\N	\N	\N	0	1
807	Yabancı dil öğrenmeyi severim.	外国語を勉強するのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
808	Ben kedileri sevmiyorum.	私は猫が嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
809	Japon yemeğini sevdin mi?	日本料理を気に入りましたか。	\N		\N	vmod	\N	\N	\N	0	1
810	İki hafta tatil alıp seyahate çıkacağız.	二週間休みを取って旅行するつもりです。	\N		\N	vmod	\N	\N	\N	0	1
811	Yarın seyahate çıkıyorum.	明日旅行に行きます。	\N		\N	vmod	\N	\N	\N	0	1
812	Dışarısı çok sıcak.	外はとても暑い。	\N		\N	vmod	\N	\N	\N	0	1
813	Bir kilo dana eti alalım.	一キロの牛肉を買おう。	\N		\N	vmod	\N	\N	\N	0	1
814	Burada sık sık kavga çıkar.	ここではしばしば喧嘩がおこる。	\N		\N	vmod	\N	\N	\N	0	1
815	Bu ders çok sıkıcı.	この授業はてともつまらない。	\N		\N	vmod	\N	\N	\N	0	1
816	Silgiyle sil.	消しゴムで消して。	\N		\N	vmod	\N	\N	\N	0	1
817	Sınıfta öğrenciler bekliyor.	教室で学生が待っている。	\N		\N	vmod	\N	\N	\N	0	1
818	'Kırmızı ve Siyah'I yazan kimdi?	「赤と黒」を書いたのはだれだっけ。	\N		\N	vmod	\N	\N	\N	0	1
819	Bugün çok soğuktu, soba yaktım.	今日はとても寒かった。ストーブをたいた。	\N		\N	vmod	\N	\N	\N	0	1
820	Soğuk içecek istiyorum.	冷たい飲み物が欲しい。	\N		\N	vmod	\N	\N	\N	0	1
821	Bu sonbaharda ablam evlenecek.	この秋に姉が結婚します。	\N		\N	vmod	\N	\N	\N	0	1
822	Hocaya soralım.	先生に聞こう。	\N		\N	vmod	\N	\N	\N	0	1
823	Bir sorun mu var?	なにか問題があるの？	\N		\N	vmod	\N	\N	\N	0	1
824	Nerede soya sosu buldun?	どこで醤油を見つけたの。	\N		\N	vmod	\N	\N	\N	0	1
825	Şarkı söyleyerek yemek yapıyor.	歌を歌いながら料理をしている。	\N		\N	vmod	\N	\N	\N	0	1
826	O kendi deneyimini anlattı.	彼は自分の経験を語った。	\N		\N	vmod	\N	\N	\N	0	1
827	Çok ıslandım. Hemen soyunup banyoya girdim.	とても濡れた。すぐに服を抜いで風呂に入った。	\N		\N	vmod	\N	\N	\N	0	1
828	O her zaman sözünü tutar.	彼女はいつも約束を守る。	\N		\N	vmod	\N	\N	\N	0	1
829	Japonca'da suyla ilgili sözcük çok.	日本語には水に関する単語が多い。	\N		\N	vmod	\N	\N	\N	0	1
830	Bilmediğiniz kelime varsa sözlüğe bakın.	知らない単語があったら辞書を引きなさい。	\N		\N	vmod	\N	\N	\N	0	1
831	Akşam yağmur yağacakmış, yanına şemsiye al.	夕方雨が降るらしい。傘をもっていって。	\N		\N	vmod	\N	\N	\N	0	1
832	Kırmızı şapka takan benim oğlum.	赤い帽子をかぶっているのが私の息子です。	\N		\N	vmod	\N	\N	\N	0	1
833	Bayramda komşular çocuklara şeker verir.	お祭りでは近所の人が子供たちに飴をあたえる。	\N		\N	vmod	\N	\N	\N	0	1
834	Baban hangi şirkette çalışıyor?	お父さんはどこの会社で働いてるの？	\N		\N	vmod	\N	\N	\N	0	1
835	Türkiye'de Şubat'ta tatil var.	トルコでは二月に休みがある。	\N		\N	vmod	\N	\N	\N	0	1
836	Murat yeni takım elbise almış.	ムラトは新しい背広を買ったそうだ。	\N		\N	vmod	\N	\N	\N	0	1
837	Oğlum şapka takmayı hiç sevmiyor.	息子は帽子をかぶるのが好きじゃない。	\N		\N	vmod	\N	\N	\N	0	1
838	Ben takı takmayı sevmem.	私はアクセサリーをつけるのが好きじゃない。	\N		\N	vmod	\N	\N	\N	0	1
839	Tam seni arayacaktım.	ちょうど君に電話しようとしてたんだ。	\N		\N	vmod	\N	\N	\N	0	1
840	Çok tatlı olmasın.	あんまり甘くしないで。	\N		\N	vmod	\N	\N	\N	0	1
841	Tatlı sever misin?	お菓子は好きですか。	\N		\N	vmod	\N	\N	\N	0	1
842	Yemek yaptım. Ama tatsız tuzsuz olmuş.	料理を作ったけど、まずくなってしまった。	\N		\N	vmod	\N	\N	\N	0	1
843	Bugün tavuk yiyelim.	今日は鶏を食べよう。	\N		\N	vmod	\N	\N	\N	0	1
844	Misafir gelmeden önce evi temizlemem lazım.	お客さんが来る前に家を掃除しなくちゃいけない。	\N		\N	vmod	\N	\N	\N	0	1
845	Annem temizlik yapmayı sevmez.	母は掃除をするのが好きではない。	\N		\N	vmod	\N	\N	\N	0	1
846	Temmuz'da yaz tatili başlar.	七月から夏休みが始まる。	\N		\N	vmod	\N	\N	\N	0	1
847	Tereyağı da alalım mı?	バターも買おうか？	\N		\N	vmod	\N	\N	\N	0	1
848	Terlik nerede?	スリッパはどこ？	\N		\N	vmod	\N	\N	\N	0	1
849	Teyp kullanarak sesini kaydettik.	テープレコーダーを使って彼の声を録音した。	\N		\N	vmod	\N	\N	\N	0	1
850	Bu metni Japonca'ya çevirin.	この文章を日本語に訳しなさい。	\N		\N	vmod	\N	\N	\N	0	1
851	Tuvalete gidiyorum.	トイレに行ってくる。	\N		\N	vmod	\N	\N	\N	0	1
852	Biraz tuz verir misin?	塩を渡してくれる？	\N		\N	vmod	\N	\N	\N	0	1
853	Kuşlar uçuyor.	鳥が飛んでいる。	\N		\N	vmod	\N	\N	\N	0	1
854	Uçakla gidersek daha pahalı olur.	飛行機で行くともっと高くなるよ。	\N		\N	vmod	\N	\N	\N	0	1
855	Dün hiç uyumadan ders çalıştım.	昨日寝ないで勉強した。	\N		\N	vmod	\N	\N	\N	0	1
856	İstanbul'a varınca hemen beni ara.	イスタンブルに着いたらすぐに電話して。	\N		\N	vmod	\N	\N	\N	0	1
857	Ne zaman ödevini vereceksin?	いつ宿題を渡すつもりなの？	\N		\N	vmod	\N	\N	\N	0	1
858	Onun vücudu çok esnek.	彼の体はとても柔らかい。	\N		\N	vmod	\N	\N	\N	0	1
859	Buna bakın.	これを見てください。	\N		\N	vmod	\N	\N	\N	0	1
860	Yabancı da katılabilir mi?	外国人も参加できますか。	\N		\N	vmod	\N	\N	\N	0	1
861	Japonya'da yabancı öğrenci olarak bir sene kaldım.	日本で留学生として一年暮らしました。	\N		\N	vmod	\N	\N	\N	0	1
862	Hiç yabancı ülkeye gittin mi?	外国に行ったことがありますか。	\N		\N	vmod	\N	\N	\N	0	1
863	Bugün yağmur yağacak.	今日は雨が降る。	\N		\N	vmod	\N	\N	\N	0	1
864	Hemen yakında.	すぐそこです。	\N		\N	vmod	\N	\N	\N	0	1
865	Yakında hastane var mı acaba?	近くに病院があるかなあ。	\N		\N	vmod	\N	\N	\N	0	1
866	Ahmet'le Ayşe yan yana oturdular.	アフメットとアイシェは隣同士に座った。	\N		\N	vmod	\N	\N	\N	0	1
867	Gelecekte ne yapmak istiyorsun?	将来なにをしたいですか。	\N		\N	vmod	\N	\N	\N	0	1
868	Pulu zarfa yapıştırdım.	切手を封筒に貼った。	\N		\N	vmod	\N	\N	\N	0	1
870	Evde hiç yemek kalmadı.	家には何にも食べ物が残っていない。	\N		\N	vmod	\N	\N	\N	0	1
871	Hadi yemek yiyelim.	さあごはんを食べよう。	\N		\N	vmod	\N	\N	\N	0	1
872	Evimin etrafında yeşillik var.	家の周りには緑がある。	\N		\N	vmod	\N	\N	\N	0	1
873	Hiç yeşil çay içmemiştim.	緑茶を飲んだことがありせん。	\N		\N	vmod	\N	\N	\N	0	1
874	Lokantalar yukarıda galiba.	レストランはたぶん上だろう。	\N		\N	vmod	\N	\N	\N	0	1
875	Bu binanın yüksekliği ne kadar?	このビルの高さはどれくらいですか。	\N		\N	vmod	\N	\N	\N	0	1
876	Markete gidip 10 tane yumurta al.	店に行って卵を十個買ってきて。	\N		\N	vmod	\N	\N	\N	0	1
877	Buraya kadar yürüyerek mi geldin?	ここまで歩いて来たの？	\N		\N	vmod	\N	\N	\N	0	1
878	Önce yüzünü yıka, sonra yemeğe gel.	まず顔を洗って、それから食事に来なさい。	\N		\N	vmod	\N	\N	\N	0	1
879	Yüzmeyi bilmiyorum.	泳げないんです。	\N		\N	vmod	\N	\N	\N	0	1
880	Çocuklar yüzme havuzunu çok sever.	子供たちはプールが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
881	Evlendiğim zaman İstanbul'a taşındım.	結婚したときにイスタンブルに引っ越しました。	\N		\N	vmod	\N	\N	\N	0	1
882	Zamanınız varsa yardım eder misiniz?	時間があるなら手伝ってくれますか。	\N		\N	vmod	\N	\N	\N	0	1
883	Bu sezon Beşiktaş çok zayıftı.	今シーズンベシクタシュはとても弱かった。	\N		\N	vmod	\N	\N	\N	0	1
884	Çamaşırın varsa hemen çıkart.	洗濯物があるならすぐに出して。	\N		\N	vmod	\N	\N	\N	0	1
885	Biraz güneş çıktı ama hemen bulutlandı.	少し太陽が出たが、すぐに曇ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
886	Böyle bir şey olamaz.	こんなことあり得ないよ。	\N		\N	vmod	\N	\N	\N	0	1
887	Migros'ta alışveriş yapalım.	ミグロスで買い物しよう。	\N		\N	vmod	\N	\N	\N	0	1
888	Dumanı içine çekme!	煙を吸わないように。	\N		\N	vmod	\N	\N	\N	0	1
889	Ahmet her zaman arkamdan geliyor.	アフメットはいつも私の後からついてくる。	\N		\N	vmod	\N	\N	\N	0	1
890	Çok yürüdüğüm için ayağım ağrıyor.	たくさん歩いたので足が痛い。	\N		\N	vmod	\N	\N	\N	0	1
891	Onun üstüne hiçbir şey koyma.	それの上には何も置かないで。	\N		\N	vmod	\N	\N	\N	0	1
892	Bu işin gerisini bana bırakın.	この仕事のあとは私に任せなさい。	\N		\N	vmod	\N	\N	\N	0	1
893	Sözlük orada kitaplıkta.	辞書はそこの本棚にあるよ。	\N		\N	vmod	\N	\N	\N	0	1
894	Çin yazısını okuyabiliyor musun?	漢字を読むことができますか。	\N		\N	vmod	\N	\N	\N	0	1
895	Bügün çamaşır yıkayacağım.	今日は洗濯をするつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
896	Neden cevap vermiyorsun?	なんで返事をしないんだい。	\N		\N	vmod	\N	\N	\N	0	1
897	Evimin yanında ırmak var.	家のそばに川があります。	\N		\N	vmod	\N	\N	\N	0	1
898	Fincan kırıldı.	カップが割れた。	\N		\N	vmod	\N	\N	\N	0	1
899	Teyzeme gideceğim.	おばさんに会いに行く。	\N		\N	vmod	\N	\N	\N	0	1
900	Bugün hava ılık.	今日は暖かい。	\N		\N	vmod	\N	\N	\N	0	1
901	Anneannem doksan yaşında.	祖母は９０歳だ。	\N		\N	vmod	\N	\N	\N	0	1
902	Babaannem yarın evimize gelecek.	祖母が明日家にくる。	\N		\N	vmod	\N	\N	\N	0	1
903	Amcam şirkette çalışıyor.	おじは会社で働いている。	\N		\N	vmod	\N	\N	\N	0	1
904	Dayım Japonya'da çalışıyor.	おじは日本で働いている。	\N		\N	vmod	\N	\N	\N	0	1
905	o, on, alt		\N		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-1-1/1.html	0	1
906	su, tür, sırt		\N		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-1-1/1.html	0	1
907	spor, bronz		\N		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-1-1/1.html	0	1
908	a b c ç d		\N		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-2/1.html	0	1
909	e f g ğ h		\N		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-2/1.html	0	1
910	ı i j k l		\N		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-2/1.html	0	1
911	m n o ö p		\N		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-2/1.html	0	1
912	r s ş t u		\N		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	2-2/1.html	0	1
913	ü v y z		\N		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	2-2/1.html	0	1
914	baba, babalar, babaların		\N		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-1-2/1.html	0	1
915	okul, okula		\N		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-1-2/1.html	0	1
916	çiçek, çiçeği		\N		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	3-1-2/1.html	0	1
917	baş, baştan		\N		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	3-1-2/1.html	0	1
918	Türk, Türk’ten, Türkiye		\N		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	3-1-2/1.html	0	1
919	kitap, bahçe, istasyon		\N		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2-2-2/1.html	0	1
920	başvekil, Karadeniz		\N		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-2-2-2/1.html	0	1
921	akmak, ekmek		\N		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2-2-4/1.html	0	1
922	kitap, kitabı		\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-3-2/1.html	0	1
923	ayak, ayağa		\N		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-3-2/1.html	0	1
924	geldi, gitti		\N		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-3-1/1.html	0	1
925	çene, bacak		\N		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2-2-1/1.html	0	1
926	kirpik, bıyık		\N		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-2-2-1/1.html	0	1
927	sümük, burun		\N		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	3-2-2-1/1.html	0	1
928	ağız, ağzı		\N		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-4/1.html	0	1
929	vakit, vaktiniz		\N		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-4/1.html	0	1
930	resim, resmin		\N		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	3-4/1.html	0	1
931	kil, kıl		\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-2/1.html	0	1
932	kül, kul		\N		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-2/1.html	0	1
933	gel, göl, gol		\N		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-3/1.html	0	1
934	demek, yemek		\N		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-3/1.html	0	1
935	hep, her		\N		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-3/1.html	0	1
936	kar, kâr		\N		\N	pmod	page019.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-4/1.html	0	1
937	pul, bul		\N		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-1/1.html	0	1
938	kapak, bebek		\N		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-1/1.html	0	1
939	yaprak, tablo, ip, şarap		\N		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-1/1.html	0	1
940	kel, gel, keçe, geçe		\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-3/1.html	0	1
941	akmak, ekmek		\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-3/1.html	0	1
942	dik, lig		\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-3/1.html	0	1
943	kaka, gaga, yonga		\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	5-3/1.html	0	1
944	kar, kâr, gar, rüzgâr		\N		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	5-3/1.html	0	1
945	rahat, rıza		\N		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-5/1.html	0	1
946	kara, kere, orta		\N		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-5/1.html	0	1
947	nar, var, bir		\N		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-5/1.html	0	1
948	bir dakika, bir dakika（rの脱落）, bir tane, bir tane（rの脱落）		\N		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	5-5/1.html	0	1
949	çan, can		\N		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-6/1.html	0	1
950	geçe, gece	（時間が）～時過ぎ、夜（発音の違いに気をつけましょう）	\N		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-6/1.html	0	1
951	hac, hacca		\N		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-6/1.html	0	1
952	hiç, geç		\N		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-6/1.html	0	1
953	meme, nere, mal, nal		\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-4/1.html	0	1
954	yamaç, yanak		\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-4/1.html	0	1
955	memnun, anne		\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-4/1.html	0	1
956	cam, can		\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-4/1.html	0	1
957	inmek, İstanbul		\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-4/1.html	0	1
958	hangi, yangın		\N		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	5-4/1.html	0	1
959	fark, kafa, teftiş, tef		\N		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-7/1.html	0	1
960	vatan, vücüt, sınav, ödev		\N		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-7/1.html	0	1
961	teşvik, cetvel		\N		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-7/1.html	0	1
962	kovan, savan		\N		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-7/1.html	0	1
963	kovmak, sevmek		\N		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-7/1.html	0	1
964	af, av, kafa, kaval		\N		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	5-7/1.html	0	1
965	sor, zor		\N		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-8/1.html	0	1
966	kasap, Kazak, pazar		\N		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-8/1.html	0	1
967	kısmak, kızmak		\N		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-8/1.html	0	1
968	tenis, deniz		\N		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-8/1.html	0	1
969	şarap, Japon, şans, jant		\N		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-9/1.html	0	1
970	paşa, kaş, kaşık, kaşlı		\N		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-9/1.html	0	1
971	beş, bej		\N		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-9/1.html	0	1
972	hava, hiç, hurma, hükümet		\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-10/1.html	0	1
973	ilham, ishal, şüphe		\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-10/1.html	0	1
974	daha, tohum		\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-10/1.html	0	1
975	sahte, ahçı, mahsus, kahve		\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-10/1.html	0	1
976	sabah, tarih		\N		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-10/1.html	0	1
977	yaya, yemek, yiyecek, yıl		\N		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-11/1.html	0	1
978	yom, yön, yum, yün		\N		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-11/1.html	0	1
979	ay, pay, tay		\N		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-11/1.html	0	1
980	öyle, iyi		\N		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-11/1.html	0	1
981	kaybet, seyret		\N		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-11/1.html	0	1
982	tenis, deniz		\N		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-2/1.html	0	1
983	atmak, etmek		\N		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-2/1.html	0	1
984	tutak, dudak		\N		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-2/1.html	0	1
985	at, ad		\N		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-2/1.html	0	1
986	lapa, limon		\N		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-12/1.html	0	1
987	tatlı, gelecek, başlık, gözlük		\N		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-12/1.html	0	1
988	dilbilim, kollu, altın		\N		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-12/1.html	0	1
989	dal, dil, kabul, bul		\N		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-12/1.html	0	1
990	dağ, dağa, bağ, bağa		\N		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-13/1.html	0	1
991	boğaz, değil, soğuk		\N		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-13/1.html	0	1
992	bağdaş, sağcı, iğne, öğle		\N		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-13/1.html	0	1
993	müze, müzede, müzeler, müzelerde		\N		\N	pmod	page038.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	6-2/1.html	0	1
994	gel, gelen, gelenler, gelenlerin		\N		\N	pmod	page038.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	6-2/1.html	0	1
995	teyze, İstanbul		\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	6-3-1/1.html	0	1
996	mısır, Mısır		\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	6-3-1/1.html	0	1
997	teyze, teyzem, teyzeler, teyzelerin		\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	6-3-1/1.html	0	1
998	İstanbul, İstanbul’da		\N		\N	pmod	page039.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	6-3-1/1.html	0	1
999	baba gibi, baba ile, teyze ile		\N		\N	pmod	page040.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	6-3-2/1.html	0	1
1000	babada, baba da		\N		\N	pmod	page040.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	6-3-2/1.html	0	1
1001	İstanbul’da, İstanbul da		\N		\N	pmod	page040.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	6-3-2/1.html	0	1
1002	gel, geldi, gelindi, gelmedi, gelinmedi		\N		\N	pmod	page041.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	6-3-3/1.html	0	1
1003	gelmiş, gelmişse, gelmişseler, gelmişlerse		\N		\N	pmod	page041.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	6-3-3/1.html	0	1
1004	baş, vekil, başvekil		\N		\N	pmod	page042.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	6-4/1.html	0	1
1005	kara, deniz, Karadeniz		\N		\N	pmod	page042.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	6-4/1.html	0	1
1006	Karadeniz, Karadenizde		\N		\N	pmod	page042.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	6-4/1.html	0	1
1007	Saat yedide başlayacak.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1008	Dondurma yemeye bayılıyorum.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1009	Ama sonunda geldik.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1010	Evet, geçen sene gittim.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1011	Ben gidemem.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1012	Hayır, öyle birisini hiç görmedim.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1013	Dünkü parti çok güzeldi, çok eğlendim.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1014	Gönderdiğin kitapları aldım ve çok sevindim.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1015	Burada bir tane var.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1016	Öğleden sonra da randevum var.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1017	Ay, hiç gereği yoktu.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[11]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1018	Benim haberim yok.		\N		\N	pmod	page045.xml	/pmod:page[1]/pmod:block[12]/pmod:examples[1]/pmod:example[1]	7-1-1/1.html	0	1
1019	Merhaba Mehmet Bey.		\N		\N	pmod	page043.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1020	Günaydın.		\N		\N	pmod	page043.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	7/1.html	0	1
1021	Nasılsınız?		\N		\N	pmod	page043.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1022	Yüz yirmi yaprak.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1023	Benim ismim Fehmi.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1024	Dört milyon.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1025	Hayır, o benim değil.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1026	Maalesef uygun değil.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1027	Var, ama o birinci hamur değil.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1028	Buranın manzarası çok güzel.	ここの景色はとてもきれいだ。	\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1029	Toplam yedi tane tabak lazım.		\N		\N	pmod	page046.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	7-1-2/1.html	0	1
1030	Daha ucuzu yok mu?		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7-2-1/1.html	0	1
1031	Yarın için herhangi bir planın var mı?		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7-2-1/1.html	0	1
1032	O zaman beraber sinemaya gidelim mi?		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	7-2-1/1.html	0	1
1033	Yarın akşam mı?		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	7-2-1/1.html	0	1
1034	İçki kullanıyor musunuz?		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	7-2-1/1.html	0	1
1035	Peki, sigara içiyor musunuz?		\N		\N	pmod	page048.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	7-2-1/1.html	0	1
1036	Parti saat kaçta başlıyor?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1037	Masaya kaç tane tabak lazım?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1038	Hangi bina?	どの建物ですか？	\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1039	Ne kadar geç kalacaksın?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1040	Başka ne yapmayı seviyorsun?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1041	Neden?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1042	Nasıl, hediyeni beğendin mi?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1043	Ne dersi?		\N		\N	pmod	page049.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	7-2-2/1.html	0	1
1044	Kaç lira acaba?		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7-3/1.html	0	1
1045	Oldukça uzun bir yolculuk oldu, değil mi?		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7-3/1.html	0	1
1046	Rahatsız mısın yoksa?		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	7-3/1.html	0	1
1047	Ders, sadece sınav zamanı çalışılmaz!		\N		\N	pmod	page050.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	7-3/1.html	0	1
1048	boğazın, bahçenin		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2-2-3/1.html	0	1
1049	karının, başvekilin		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-2-2-3/1.html	0	1
1050	istasyonun, gölün		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	3-2-2-3/1.html	0	1
1051	omuzun, göğüsün		\N		\N	pmod	page053.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	3-2-2-3/1.html	0	1
1052	omuz, göğüs		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2-2-1/1.html	0	1
1053	karın, dirsek		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-2-2-1/1.html	0	1
1054	boğaz, göbek		\N		\N	pmod	page052.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-2-2-1/1.html	0	1
1055	boğazda, bahçede		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2-2-3/1.html	0	1
1056	karında, Karadenizde		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-2-2-3/1.html	0	1
1057	istasyonda, gölde		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	3-2-2-3/1.html	0	1
1058	omuzda, göğüste		\N		\N	pmod	page054.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	3-2-2-3/1.html	0	1
1059	Tamam.		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1060	Tamam, anladım.		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	7/1.html	0	1
1061	Olur.		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1062	Öyle mi?		\N		\N	pmod	page059.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	7/1.html	0	1
1063	Evet.		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1064	Evet, çok beğendim.		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	7/1.html	0	1
1065	Hayır.		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1066	Hayır efendim, maalesef ben kalmıyorum.		\N		\N	pmod	page060.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	7/1.html	0	1
1067	Ben de iyiyim, teşekkür ederim.		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
1068	Teşekkür ederim.		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	7/1.html	0	1
1069	Affedersin.		\N		\N	pmod	page058.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	7/1.html	0	1
346	Merhaba.	こんにちは。			\N	dmod	tr19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
570	Küçük bir ağız.	小さい口	\N		\N	vmod	\N	\N	\N	0	1
597	Ekmek bıçağı.	パン切りナイフ	\N		\N	vmod	\N	\N	\N	0	1
706	Kapıyı kapat.	ドアを閉めて。	\N		\N	vmod	\N	\N	\N	0	1
869	Babam yatak odasında.	父は寝室にいる。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: tr
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	1476	行く	1	1
2	1477	英語	1	1
3	1478	飛行機	1	1
4	1479	外国	1	1
5	1480	外国人	1	1
6	1481	フランス語	1	1
7	1482	ホテル	1	1
8	1483	日本語	1	1
9	1484	出掛ける	1	1
10	1485	国（くに）	1	1
11	1486	会う	1	1
12	1487	休み	1	1
13	1488	旅行	1	1
14	1489	旅行する	1	1
15	1490	遊ぶ	1	1
16	1491	大使館	1	1
17	1930	大好き	1	1
18	1930	好き	1	1
19	1494	上手（じょうず）	1	1
20	1495	走る	1	1
21	1496	ゆっくり	1	1
22	1764	下手（へた）	1	1
23	1498	歩く	1	1
24	1499	泳ぐ	1	1
25	1500	速い［スピードが～］	1	1
26	1501	飛ぶ	1	1
27	1502	スポーツ	1	1
28	1503	嫌い	1	1
29	1504	プール	1	1
30	1505	バス	1	1
31	1506	自転車	1	1
32	1507	交差点	1	1
33	1508	道（みち）	1	1
34	1509	池	1	1
35	1510	散歩	1	1
36	1511	かわ（川・河）	1	1
37	1512	タクシー	1	1
38	1513	自動車，車（くるま）	1	1
39	1562	曲がる	1	1
40	1515	ネクタイ	1	1
41	1802	ワイシャツ	1	1
42	1517	会社	1	1
43	1518	背広	1	1
44	1519	やる	1	1
45	1520	吸う、（煙などを）吸う	1	1
46	1521	電話	1	1
47	1522	仕事・用事	1	1
48	1523	働く・勤める	1	1
49	1524	忙しい	1	1
50	1525	図書館	1	1
51	1526	辞書，字引	1	1
53	1528	新聞	1	1
54	1529	読む	1	1
55	1530	本	1	1
56	1531	コピー	1	1
57	1532	コピーする	1	1
58	1533	雑誌	1	1
59	1534	冊	1	1
60	1535	牛肉	1	1
61	1536	安い	1	1
62	1537	店	1	1
63	1538	高い	1	1
64	1539	いくつ	1	1
65	1540	いくら・どれくらい	1	1
66	1541	果物	1	1
67	1542	野菜	1	1
68	1543	魚	1	1
69	1544	豚肉	1	1
70	1545	鳥肉	1	1
71	1546	肉	1	1
72	1547	欲しい	1	1
73	1548	渡す	1	1
74	1549	八百屋	1	1
75	1550	かぎ（鍵）	1	1
76	1551	料理	1	1
77	1552	買い物する	1	1
78	1553	洗濯する	1	1
79	1554	掃除する	1	1
80	1555	家族	1	1
81	1555	家庭	1	1
82	1557	庭（にわ）	1	1
83	1558	洗濯	1	1
84	1559	うち（家）	1	1
85	1559	家（いえ）	1	1
86	1561	掃除	1	1
87	1562	かえる（帰・返）	1	1
88	1563	本棚	1	1
89	1564	机	1	1
90	1565	椅子（いす）	1	1
91	1566	部屋	1	1
92	1567	冷蔵庫	1	1
93	1568	洗う	1	1
94	1569	ベッド	1	1
95	1570	ラジオ	1	1
96	1571	ラジカセ	1	1
97	1572	～という名前です	1	1
98	1573	寝る	1	1
99	1574	起きる	1	1
100	1564	テーブル	1	1
101	1576	テレビ	1	1
102	1577	お巡りさん	1	1
103	1577	警官	1	1
104	1579	地図	1	1
105	1580	そば	1	1
106	1581	ここ,こちら, こっち	1	1
107	1582	そこ,そちら, そっち	1	1
108	1582	あちら, あっち，あそこ	1	1
109	1584	どこ,どちら,どっち	1	1
110	1585	交番	1	1
111	1580	近く	1	1
112	1587	隣	1	1
113	1588	きく	1	1
114	1589	切る	1	1
115	1590	短い	1	1
116	1591	後ろ	1	1
117	1592	前	1	1
118	1593	右	1	1
119	1594	左	1	1
120	1595	長い	1	1
121	1596	座る	1	1
122	1574	立つ	1	1
123	1598	友達	1	1
124	1599	クラス	1	1
125	1599	教室	1	1
126	1601	廊下	1	1
127	1602	学校	1	1
128	1603	生徒	1	1
129	1604	勉強	1	1
130	1603	学生	1	1
131	1606	留学生	1	1
132	1607	夏休み	1	1
133	1608	先生	1	1
134	1609	大学	1	1
135	1610	ノート	1	1
136	1611	授業	1	1
137	1612	作文	1	1
138	1613	宿題	1	1
139	1614	難しい	1	1
140	1615	教える	1	1
141	1616	テスト	1	1
142	1617	練習	1	1
143	1618	易しい	1	1
144	1619	練習する	1	1
145	1620	質問	1	1
146	1621	問題	1	1
147	1622	答える	1	1
148	1623	痛い	1	1
149	1624	歯	1	1
150	1625	医者	1	1
151	1626	病院	1	1
152	1627	病気	1	1
153	1628	薬（くすり）	1	1
154	1629	死ぬ	1	1
155	1630	風邪（かぜ）	1	1
156	1631	頭（あたま）	1	1
157	1632	お腹	1	1
158	1633	度（ど）	1	1
159	1634	エレベーター	1	1
160	1635	切符	1	1
161	1636	おりる	1	1
162	1637	階段	1	1
163	1638	閉める	1	1
164	1639	駅	1	1
165	1640	地下鉄	1	1
166	1641	乗る	1	1
167	1642	開ける	1	1
168	1643	お手洗い	1	1
169	1644	トイレ	1	1
170	1645	電車	1	1
171	1646	飲み物	1	1
172	1647	コーヒー	1	1
173	1648	喫茶店	1	1
174	1649	レモン	1	1
175	1650	牛乳	1	1
176	1651	砂糖	1	1
177	1652	カップ	1	1
178	1653	お茶	1	1
179	1654	紅茶	1	1
180	1655	コップ	1	1
181	1656	入れる	1	1
182	1657	甘い	1	1
183	1658	飲む	1	1
184	1659	はし	1	1
185	1660	酒	1	1
186	1661	おいしい	1	1
187	1662	ナイフ	1	1
188	1663	スプーン	1	1
189	1664	フォーク	1	1
190	1665	チーズ	1	1
191	1666	食べる	1	1
192	1667	まずい、あじがない、tatsız tuzsuz　は特に食べ物について	1	1
193	1668	パン	1	1
194	1669	辛い	1	1
195	1670	レストラン	1	1
196	1671	食堂	1	1
197	1672	酒・ワイン	1	1
198	1551	食べ物	1	1
199	1674	カレー	1	1
200	1675	お金	1	1
201	1676	銀行	1	1
202	1677	入り口	1	1
203	1678	どうぞ,どういたしまして	1	1
204	1679	いいえ	1	1
205	1680	ええ	1	1
206	1681	すみません	1	1
207	1682	どうか	1	1
208	1683	出口	1	1
209	1684	着く	1	1
210	1685	ポスト	1	1
211	1686	はがき	1	1
212	1687	貼る	1	1
213	1688	封筒	1	1
214	1689	手紙	1	1
215	1690	郵便局	1	1
216	1691	返す	1	1
217	1692	出す・送る	1	1
218	1693	切手	1	1
219	1694	荷物	1	1
220	1534	枚	1	1
221	1696	貸す	1	1
222	1697	買う	1	1
223	1698	帽子	1	1
224	1699	靴	1	1
225	1700	買い物	1	1
226	1701	階	1	1
227	1702	デパート	1	1
228	1703	スカート	1	1
229	1704	コート	1	1
230	1705	ズボン	1	1
231	1706	セーター	1	1
232	1707	…てください	1	1
233	1708	かばん	1	1
234	1709	売る	1	1
235	1710	上着	1	1
236	1711	ふろ	1	1
237	1712	建物	1	1
238	1713	台所	1	1
239	1714	シャワー	1	1
240	1715	窓	1	1
241	1596	住む	1	1
242	1717	公園	1	1
243	1718	ドア	1	1
244	1719	浴びる［一風呂～］	1	1
245	1720	アパート	1	1
246	1721	玄関	1	1
247	1722	彼，彼女	1	1
248	1723	彼ら，彼女たち	1	1
249	1724	私（わたし）	1	1
250	1725	私たち	1	1
251	1726	だれか	1	1
252	1727	だれ	1	1
253	1727	どなた	1	1
254	1729	きみ	1	1
255	1730	あなた	1	1
256	1731	この	1	1
257	1722	その，あの	1	1
258	1733	いかが，どう	1	1
259	1734	どの	1	1
260	1733	どんな	1	1
261	1736	こんな	1	1
262	1737	自分	1	1
263	1738	そう	1	1
264	1739	厚い	1	1
265	1740	狭い	1	1
266	1741	細い	1	1
267	1742	大きい	1	1
268	1739	太い	1	1
269	1744	若い	1	1
270	1745	広い	1	1
271	1746	軽い	1	1
272	1747	遠い	1	1
273	1748	重い	1	1
274	1741	薄い	1	1
275	1750	新しい	1	1
276	1751	小さい	1	1
277	1752	近い	1	1
278	1753	古い	1	1
279	1754	楽しい	1	1
280	1755	にぎやか	1	1
281	1756	低い	1	1
282	1757	よい	1	1
283	1758	明るい	1	1
284	1759	弱い	1	1
285	1760	強い	1	1
286	1761	おもしろい	1	1
287	1661	きれい・よい	1	1
288	1763	遅い	1	1
289	1764	悪い	1	1
290	1765	多い	1	1
291	1766	暗い	1	1
292	1767	静か	1	1
293	1768	少ない	1	1
294	1769	汚い	1	1
295	1770	つまらない	1	1
296	1771	横	1	1
297	1772	中（なか）	1	1
298	1773	外（そと）	1	1
299	1774	東（ひがし）	1	1
300	1775	高さ	1	1
302	1777	北（きた）	1	1
303	1778	西（にし）	1	1
304	1779	下（した）	1	1
305	1780	南（みなみ）	1	1
306	1781	上（うえ）	1	1
307	1782	先（さき）	1	1
308	1783	後（あと）	1	1
309	1784	いとこ	1	1
310	1785	兄	1	1
311	1786	兄弟（きょうだい）	1	1
312	1787	（父方の）祖母、おばあさん	1	1
313	1788	おじいさん	1	1
314	1789	奥さん	1	1
315	1790	母	1	1
316	1791	（父方の）叔父，伯父	1	1
317	1792	両親（anne ve baba も一般的）	1	1
318	1793	父	1	1
319	1794	姉	1	1
320	1795	姉妹	1	1
321	1796	（母方の）叔母，伯母	1	1
322	1797	お兄さん	1	1
323	1794	お姉さん、呼びかけに用いる	1	1
324	1793	お父さん	1	1
325	1790	お母さん	1	1
326	1801	靴下	1	1
327	1802	シャツ	1	1
328	1803	脱ぐ	1	1
329	1804	架ける	1	\N
330	1805	は（穿）く［ズボンを～］	1	1
331	1805	着る	1	1
332	1807	かぶる	1	1
333	1808	ハンカチ	1	1
334	1809	スリッパ	1	1
335	1810	傘	1	1
336	1811	ポケット	1	1
337	1812	財布	1	1
338	1813	着ている	1	\N
339	1814	服	1	1
340	1814	洋服	1	1
341	1816	口	1	1
342	1817	腕（うで）	1	1
343	1818	体（からだ）	1	1
344	1819	顔	1	1
345	1820	脚（あし）	1	1
346	1821	手（て）	1	1
347	1822	鼻	1	1
348	1823	目（め）	1	1
349	1824	耳	1	1
350	1825	足（あし）	1	1
351	1632	おなか	1	1
352	1827	皿（さら）	1	1
353	1828	バター	1	1
354	1829	茶わん	1	1
355	1651	あめ	1	1
356	1831	昼御飯	1	1
357	1832	夕飯（ゆうはん）	1	1
358	1657	お菓子	1	1
359	1834	卵	1	1
360	1835	朝御飯	1	1
361	1551	御飯（ごはん）	1	1
362	1837	醤油	1	1
363	1838	塩（しお）	1	1
364	1832	晩御飯	1	1
365	1840	くわえる	1	1
366	1807	つける	1	1
367	1842	カメラ	1	1
368	1843	ストーブ	1	1
369	1844	鉛筆	1	1
370	1845	消す	1	1
371	1846	眼鏡（めがね）	1	1
372	1847	テープレコーダー	1	1
373	1848	時計	1	1
374	1849	コンピュータ	1	1
375	1850	フィルム	1	1
376	1718	戸（と）	1	1
377	1718	門（もん）	1	1
378	1853	ペン	1	1
379	1854	万年筆	1	1
380	1855	ボールペン	1	1
381	1856	八月	1	1
382	1857	四月	1	1
383	1858	今月	1	1
384	1859	毎月（まいつき）	1	1
385	1860	十二月	1	1
386	1861	二月	1	1
387	1862	一月	1	1
388	1863	七月	1	1
389	1864	六月	1	1
390	1865	来月	1	1
391	1866	五月	1	1
392	1867	三月	1	1
393	1868	先月	1	1
394	1869	十一月	1	1
395	1870	十月	1	1
396	1871	九月	1	1
397	1872	ひとつき	1	1
398	1873	今週	1	1
399	1874	毎週	1	1
400	1875	日曜日	1	1
401	1876	木曜日	1	1
402	1877	来週	1	1
403	1878	月曜日	1	1
404	1879	火曜日	1	1
405	1880	水曜日	1	1
406	1881	土曜日	1	1
407	1882	週間	1	1
408	1883	先週	1	1
409	1884	金曜日	1	1
410	1885	年（ねん）	1	1
411	1886	秋	1	1
412	1887	今年（ことし）	1	1
413	1888	毎年（まいとし）	1	1
414	1889	夏（なつ）	1	1
415	1890	冬	1	1
416	1891	去年	1	1
417	1892	来年	1	1
418	1893	春	1	1
419	1894	再来年	1	1
420	1895	おととし	1	1
421	1896	午後	1	1
422	1897	今日（きょう）	1	1
423	1898	明日（あした）	1	1
424	1848	時（じ）	1	1
425	1900	昨日（きのう）	1	1
426	1901	夕べ	1	1
427	1902	午前	1	1
428	1903	朝	1	1
429	1904	昼	1	1
430	1905	夜（よる）	1	1
431	1906	夕方	1	1
432	1907	あさって	1	1
433	1908	おととい	1	1
434	1909	もう	1	1
435	1910	ながら、～しながら	1	1
436	1911	まだ	1	1
437	1912	中(ちゅう)	1	1
438	1913	時（とき）	1	1
439	1914	いつ	1	1
440	1915	ときどき	1	1
441	1916	しばしば	1	1
442	1913	時間	1	1
443	1918	すぐ	1	1
444	1919	灰皿	1	1
445	1920	歌（うた）	1	1
446	1921	歌う	1	1
447	1922	たばこ	1	1
448	1923	映画	1	1
449	1924	レコード	1	1
450	1925	ギター	1	1
451	1926	弾く	1	1
452	1927	音楽	1	1
453	1928	絵（え）	1	1
454	1929	写真	1	1
455	1930	好き，気に入る	1	1
456	1931	声	1	1
457	1932	晴れ	1	1
458	1933	暑い	1	1
459	1934	晴れる、晴れている	1	1
460	1935	涼しい	1	1
461	1630	寒い	1	1
462	1937	雪（ゆき）	1	1
463	1938	雨が降る	1	1
464	1939	雨（あめ）	1	1
465	1940	天気	1	1
466	1941	あたたかい（暖・温）	1	1
467	1942	風（かぜ）	1	1
468	1943	曇り	1	1
469	1630	冷たい	1	1
470	1945	曇る	1	1
471	1946	漢字	1	\N
472	1921	言う	1	1
473	1948	書く	1	1
474	1949	話（はなし）	1	1
475	1950	言葉・約束	1	1
476	1951	～語	1	1
477	1952	語（ご）	1	1
478	1953	話す	1	1
479	1954	文章	1	1
480	1955	語る	1	1
481	1956	意味	1	1
482	1957	平仮名	1	\N
483	1958	片仮名	1	\N
484	1742	大人（おとな）	1	1
485	1960	大勢	1	1
486	1961	夫婦	1	1
487	1962	子供	1	1
488	1789	妻	1	1
489	1964	女（おんな）	1	1
490	1965	男の子	1	1
491	1966	人（ひと）	1	1
492	1967	男（おとこ）	1	1
493	1968	女の子	1	1
494	1969	夫	1	1
495	1970	人	1	1
496	1971	みんな	1	1
497	1972	白（しろ），白い	1	1
498	1973	青，青い	1	1
499	1974	茶色	1	1
500	1975	明るい，淡い	1	1
501	1976	色（いろ）	1	1
502	1977	濃い，暗い	1	1
503	1978	黄色（きいろ），黄色い	1	1
504	1979	黒（くろ），黒い	1	1
505	1980	赤，赤い	1	1
506	1981	緑	1	1
507	1982	便利	1	1
508	1983	パーティー	1	1
509	1984	紙	1	1
510	1985	～になる	1	1
511	1986	締める	1	1
512	1987	押す	1	1
513	1988	始まる	1	1
514	1989	ちょうど	1	1
515	1990	ない	1	1
516	1991	まっすぐ	1	1
517	1992	有名	1	1
518	1757	元気	1	1
519	1994	じゃあ・それなら	1	1
520	1995	多分	1	1
521	1996	では	1	1
522	1997	再来年	1	1
523	1776	縦	1	1
524	306	外（そと）	1	1
525	1998	中（⇔dışarı)	1	1
527	1999	上	1	1
528	2000	漢字	1	1
529	487	トルコ語	1	1
530	2001	（母方の）祖母、おばあさん	1	1
531	2002	（母方の）叔父、伯父、おじさん	1	1
532	1574	出発する・出る	1	1
533	387	どこへ	1	1
534	2003	学ぶ・勉強する	1	1
535	2003	知る	1	1
536	132	前に	1	1
537	1534	個	1	1
538	1534	本	1	1
539	113	ある・存在する	1	1
540	1480	外国の	1	1
541	1750	新しく・あらたに	1	1
542	92	旅・旅行	1	1
543	2004	だから・ですから	1	1
544	1975	開いた・空いた	1	1
545	1975	晴れた	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: tr
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
297	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
298	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
299	10903	1.173	1.17	体	関係	空間	方向・方角	東（ひがし）	東	ひがし
300	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
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
323	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
324	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
325	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
326	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
327	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
328	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
330	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
331	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
332	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
333	54580	1.4541	1.45	体	生産物	道具	日用品	ハンカチ	ハンカチ	はんかち
334	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
335	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
336	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
337	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
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
516	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
517	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
519	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
522	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
523	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
524	10049	1.17	1.17	体	関係	空間	空間・場所	外（そと）	外	そと
525	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
527	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
528	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
529	30514	1.3101	1.31	体	活動	言語	言語	言語	言語	げんご
530	16592	1.212	1.21	体	主体	家族	親・先祖	祖母	祖母	そぼ
531	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
532	4849	1.1521	1.15	体	関係	作用	移動・発着	出発	出発	しゅっぱつ
533	9998	1.17	1.17	体	関係	空間	空間・場所	どこ	どこ	どこ
534	77166	2.3050001	2.30	用	活動	心	学習・習慣・記憶	学ぶ	学ぶ	まなぶ
535	77592	2.3062	2.30	用	活動	心	注意・認知・了解	知る	知る	しる
536	9698	1.1670001	1.16	体	関係	時間	時間的前後	前（まえ）	前	まえ
537	15151	1.1962	1.19	体	関係	量	助数接辞	－個（こ）	－個	こ
538	15140	1.1962	1.19	体	関係	量	助数接辞	本（ほん）	本	ほん
539	1483	1.12	1.12	体	関係	存在	存在	存在	存在	そんざい
540	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
541	93392	3.1659999	3.16	相	関係	時間	新旧・遅速	新た	新た	あらた
542	38056	1.3371	1.33	体	活動	生活	旅・行楽	旅	旅	たび
543	100210	4.112	4.11	他		接続	展開	だから	だから	だから
544	72632	2.1552999	2.15	用	関係	作用	開閉・封	開く	開く	あく
545	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	310	486	0	\N	0	\N	\N
2	435	560	1		0	\N	\N
3	322	486	0	\N	0	\N	\N
4	167	561	1		0	\N	\N
5	319	562	1		0	\N	\N
6	323	563	1		0	\N	\N
7	194	564	1		0	\N	\N
8	500	565	1		0	\N	\N
10	492	99	0	\N	0	\N	\N
12	457	566	1		0	\N	\N
13	97	567	1		0	\N	\N
14	206	568	1		0	\N	\N
15	273	569	1		0	\N	\N
16	341	570	1		0	\N	\N
17	148	571	1		0	\N	\N
18	381	64	0	\N	0	\N	\N
19	80	572	1		0	\N	\N
21	431	281	0	\N	0	\N	\N
22	357	294	0	\N	0	\N	\N
23	364	294	0	\N	0	\N	\N
24	222	573	1		0	\N	\N
25	281	574	1		0	\N	\N
26	142	575	1		0	\N	\N
27	225	150	0	\N	0	\N	\N
28	304	5	0	\N	0	\N	\N
29	75	576	1		0	\N	\N
30	315	156	0	\N	0	\N	\N
31	325	577	1		0	\N	\N
32	317	578	1		0	\N	\N
33	246	579	1		0	\N	\N
34	38	114	0	\N	0	\N	\N
35	245	580	1		0	\N	\N
36	385	581	1		0	\N	\N
37	116	3	0	\N	0	\N	\N
40	123	554	0	\N	0	\N	\N
41	434	148	0	\N	0	\N	\N
42	159	582	1		0	\N	\N
43	224	583	1		0	\N	\N
44	293	584	1		0	\N	\N
45	318	10	0	\N	0	\N	\N
46	324	119	0	\N	0	\N	\N
47	345	585	1		0	\N	\N
48	82	586	1		0	\N	\N
50	201	587	1		0	\N	\N
51	236	588	1		0	\N	\N
52	244	589	1		0	\N	\N
53	180	590	1		0	\N	\N
54	156	591	1		0	\N	\N
55	513	343	0	\N	0	\N	\N
56	512	592	1		0	\N	\N
57	303	593	1		0	\N	\N
58	440	594	1		0	\N	\N
59	520	595	1		0	\N	\N
61	497	596	1		0	\N	\N
62	187	597	1		0	\N	\N
63	160	598	1		0	\N	\N
64	374	495	0	\N	0	\N	\N
66	237	182	0	\N	0	\N	\N
67	397	600	1		0	\N	\N
68	203	601	1		0	\N	\N
69	419	602	1		0	\N	\N
70	522	603	1		0	\N	\N
71	251	334	0	\N	0	\N	\N
72	31	89	0	\N	0	\N	\N
74	523	227	0	\N	0	\N	\N
76	383	243	0	\N	0	\N	\N
77	398	438	0	\N	0	\N	\N
78	412	604	1		0	\N	\N
79	422	62	0	\N	0	\N	\N
80	468	605	1		0	\N	\N
81	106	606	1		0	\N	\N
82	347	607	1		0	\N	\N
83	437	201	0	\N	0	\N	\N
84	267	184	0	\N	0	\N	\N
85	484	608	1		0	\N	\N
86	227	609	1		0	\N	\N
87	92	610	1		0	\N	\N
88	476	611	1		0	\N	\N
89	235	612	1		0	\N	\N
90	336	613	1		0	\N	\N
91	280	614	1		0	\N	\N
92	409	444	0	\N	0	\N	\N
93	406	615	1		0	\N	\N
94	337	616	1		0	\N	\N
95	48	617	1		0	\N	\N
96	451	618	1		0	\N	\N
97	233	619	1		0	\N	\N
98	405	620	1		0	\N	\N
99	189	621	1		0	\N	\N
100	179	153	0	\N	0	\N	\N
101	9	622	1		0	\N	\N
102	208	623	1		0	\N	\N
103	487	70	0	\N	0	\N	\N
104	290	54	0	\N	0	\N	\N
105	326	624	1		0	\N	\N
106	184	625	1		0	\N	\N
107	265	626	1		0	\N	\N
108	313	627	1		0	\N	\N
109	135	82	0	\N	0	\N	\N
110	158	628	1		0	\N	\N
111	58	629	1		0	\N	\N
112	136	31	0	\N	0	\N	\N
113	149	571	0	\N	0	\N	\N
114	298	630	1		0	\N	\N
115	524	459	0		0	\N	\N
116	299	631	1		0	\N	\N
117	150	12	0	\N	0	\N	\N
118	379	567	0	\N	0	\N	\N
119	69	632	1		0	\N	\N
120	87	633	1		0	\N	\N
121	39	634	1		0	\N	\N
122	62	635	1		0	\N	\N
123	425	49	0	\N	0	\N	\N
124	426	636	1		0	\N	\N
125	239	637	1		0	\N	\N
126	516	638	1		0	\N	\N
127	279	246	0	\N	0	\N	\N
128	395	639	1		0	\N	\N
129	365	640	1		0	\N	\N
130	193	35	0	\N	0	\N	\N
131	346	621	0	\N	0	\N	\N
132	339	641	1		0	\N	\N
133	16	642	1		0	\N	\N
134	490	643	1		0	\N	\N
135	314	644	1		0	\N	\N
136	488	645	1		0	\N	\N
137	278	89	0	\N	0	\N	\N
138	219	646	1		0	\N	\N
139	71	647	1		0	\N	\N
140	228	648	1		0	\N	\N
141	85	516	0	\N	0	\N	\N
142	84	633	0	\N	0	\N	\N
143	205	352	0	\N	0	\N	\N
144	433	649	1		0	\N	\N
145	420	650	1		0	\N	\N
146	396	651	1		0	\N	\N
147	448	652	1		0	\N	\N
148	454	4	0	\N	0	\N	\N
149	367	653	1		0	\N	\N
150	6	307	0	\N	0	\N	\N
151	53	19	0	\N	0	\N	\N
152	288	654	1		0	\N	\N
153	393	528	0	\N	0	\N	\N
154	408	655	1		0	\N	\N
155	416	656	1		0	\N	\N
156	390	657	1		0	\N	\N
157	402	658	1		0	\N	\N
158	417	602	0	\N	0	\N	\N
159	269	659	1		0	\N	\N
160	270	660	1		0	\N	\N
161	216	661	1		0	\N	\N
162	202	662	1		0	\N	\N
163	1	663	1		0	\N	\N
164	450	664	1		0	\N	\N
165	330	665	1		0	\N	\N
166	331	666	1		0	\N	\N
167	327	596	0	\N	0	\N	\N
168	41	596	0	\N	0	\N	\N
169	11	667	1		0	\N	\N
170	348	579	0	\N	0	\N	\N
171	371	668	1		0	\N	\N
172	285	669	1		0	\N	\N
173	305	670	1		0	\N	\N
174	186	671	1		0	\N	\N
175	287	97	0	\N	0	\N	\N
176	521	672	1		0	\N	\N
177	271	673	1		0	\N	\N
178	436	674	1		0	\N	\N
179	259	635	0	\N	0	\N	\N
180	104	675	1		0	\N	\N
181	152	676	1		0	\N	\N
182	151	631	0	\N	0	\N	\N
183	465	566	0	\N	0	\N	\N
184	459	677	1		0	\N	\N
185	34	87	0	\N	0	\N	\N
186	204	477	0	\N	0	\N	\N
187	389	678	1		0	\N	\N
188	443	1	0	\N	0	\N	\N
189	384	679	1		0	\N	\N
190	399	680	1		0	\N	\N
191	413	681	1		0	\N	\N
192	496	344	0	\N	0	\N	\N
193	474	682	1		0	\N	\N
194	2	304	0	\N	0	\N	\N
195	525	683	1		0	\N	\N
196	297	684	1		0	\N	\N
197	183	685	1		0	\N	\N
198	171	686	1		0	\N	\N
199	185	687	1		0	\N	\N
200	153	688	1		0	\N	\N
201	307	408	0	\N	0	\N	\N
202	286	682	0	\N	0	\N	\N
203	418	689	1		0	\N	\N
204	161	690	1		0	\N	\N
205	266	691	1		0	\N	\N
206	274	692	1		0	\N	\N
207	491	584	0	\N	0	\N	\N
208	47	104	0	\N	0	\N	\N
209	164	77	0	\N	0	\N	\N
210	72	693	1		0	\N	\N
211	282	694	1		0	\N	\N
212	518	15	0	\N	0	\N	\N
213	8	19	0	\N	0	\N	\N
214	64	695	1		0	\N	\N
215	489	696	1		0	\N	\N
216	509	692	0	\N	0	\N	\N
217	360	697	1		0	\N	\N
218	172	51	0	\N	0	\N	\N
219	499	698	1		0	\N	\N
220	173	699	1		0	\N	\N
221	485	700	1		0	\N	\N
222	378	701	1		0	\N	\N
223	380	701	0	\N	0	\N	\N
224	264	702	1		0	\N	\N
225	268	703	1		0	\N	\N
226	99	704	1		0	\N	\N
227	122	705	1		0	\N	\N
228	163	706	1		0	\N	\N
229	243	135	0	\N	0	\N	\N
231	377	707	1		0	\N	\N
232	462	604	0	\N	0	\N	\N
233	110	708	1		0	\N	\N
234	291	709	1		0	\N	\N
235	311	710	1		0	\N	\N
236	486	711	1		0	\N	\N
237	157	712	1		0	\N	\N
238	351	713	1		0	\N	\N
239	211	714	1		0	\N	\N
240	96	715	1		0	\N	\N
241	188	299	0	\N	0	\N	\N
242	394	716	1		0	\N	\N
243	226	320	0	\N	0	\N	\N
244	32	717	1		0	\N	\N
245	231	565	0	\N	0	\N	\N
246	262	718	1		0	\N	\N
247	114	719	1		0	\N	\N
248	252	720	1		0	\N	\N
249	253	721	1		0	\N	\N
250	505	693	0	\N	0	\N	\N
251	415	66	0	\N	0	\N	\N
252	115	483	0	\N	0	\N	\N
253	55	702	0	\N	0	\N	\N
254	493	722	1		0	\N	\N
255	320	723	1		0	\N	\N
256	494	724	1		0	\N	\N
257	342	725	1		0	\N	\N
258	143	726	1		0	\N	\N
259	137	727	1		0	\N	\N
260	478	728	1		0	\N	\N
261	56	729	1		0	\N	\N
262	199	730	1		0	\N	\N
263	126	731	1		0	\N	\N
264	20	732	1		0	\N	\N
265	289	733	1		0	\N	\N
266	22	734	1		0	\N	\N
267	181	735	1		0	\N	\N
268	502	736	1		0	\N	\N
269	40	737	1		0	\N	\N
270	276	570	0	\N	0	\N	\N
271	444	738	1		0	\N	\N
272	349	739	1		0	\N	\N
273	507	740	1		0	\N	\N
274	354	741	1		0	\N	\N
275	369	742	1		0	\N	\N
276	50	743	1		0	\N	\N
277	309	744	1		0	\N	\N
278	302	745	1		0	\N	\N
279	168	746	1		0	\N	\N
280	174	747	1		0	\N	\N
281	196	748	1		0	\N	\N
282	207	749	1		0	\N	\N
283	74	750	1		0	\N	\N
284	392	751	1		0	\N	\N
285	89	390	0	\N	0	\N	\N
286	100	287	0	\N	0	\N	\N
287	498	752	1		0	\N	\N
288	391	753	1		0	\N	\N
289	214	754	1		0	\N	\N
290	333	755	1		0	\N	\N
291	162	756	1		0	\N	\N
292	49	446	0	\N	0	\N	\N
293	165	757	1		0	\N	\N
294	66	758	1		0	\N	\N
295	238	759	1		0	\N	\N
296	452	760	1		0	\N	\N
297	258	214	0	\N	0	\N	\N
298	260	541	0	\N	0	\N	\N
299	65	329	0	\N	0	\N	\N
300	439	761	1		0	\N	\N
301	375	762	1		0	\N	\N
302	109	763	1		0	\N	\N
303	382	764	1		0	\N	\N
304	247	19	0	\N	0	\N	\N
305	257	762	0	\N	0	\N	\N
306	519	667	0	\N	0	\N	\N
307	387	765	1		0	\N	\N
308	91	548	0	\N	0	\N	\N
309	54	766	1		0	\N	\N
310	127	317	0	\N	0	\N	\N
311	129	503	0	\N	0	\N	\N
312	510	767	1		0	\N	\N
313	248	768	1		0	\N	\N
314	107	769	1		0	\N	\N
315	108	770	1		0	\N	\N
316	7	586	0	\N	0	\N	\N
317	30	436	0	\N	0	\N	\N
318	121	771	1		0	\N	\N
319	241	772	1		0	\N	\N
320	15	773	1		0	\N	\N
321	432	774	1		0	\N	\N
322	138	32	0	\N	0	\N	\N
323	429	775	1		0	\N	\N
324	356	776	1		0	\N	\N
325	427	777	1		0	\N	\N
326	421	342	0	\N	0	\N	\N
328	128	731	0	\N	0	\N	\N
329	130	37	0	\N	0	\N	\N
330	130	121	0	\N	0	\N	\N
331	140	778	1		0	\N	\N
332	133	779	1		0	\N	\N
333	154	780	1		0	\N	\N
334	117	700	0	\N	0	\N	\N
335	263	318	0	\N	0	\N	\N
336	63	234	0	\N	0	\N	\N
337	229	781	1		0	\N	\N
338	230	782	1		0	\N	\N
339	200	679	0	\N	0	\N	\N
340	242	99	0	\N	0	\N	\N
341	508	273	0	\N	0	\N	\N
342	400	652	0	\N	0	\N	\N
343	403	783	1		0	\N	\N
344	240	784	1		0	\N	\N
345	401	445	0	\N	0	\N	\N
346	190	785	1		0	\N	\N
347	294	786	1		0	\N	\N
348	449	787	1		0	\N	\N
349	102	788	1		0	\N	\N
350	103	789	1		0	\N	\N
351	210	790	1		0	\N	\N
352	215	791	1		0	\N	\N
353	144	792	1		0	\N	\N
354	218	793	1		0	\N	\N
355	95	794	1		0	\N	\N
357	501	331	0	\N	0	\N	\N
358	453	795	1		0	\N	\N
359	195	796	1		0	\N	\N
360	467	797	1		0	\N	\N
361	373	798	1		0	\N	\N
362	424	667	0	\N	0	\N	\N
363	428	67	0	\N	0	\N	\N
364	118	799	1		0	\N	\N
365	404	439	0	\N	0	\N	\N
366	90	800	1		0	\N	\N
367	503	801	1		0	\N	\N
368	234	802	1		0	\N	\N
369	67	107	0	\N	0	\N	\N
371	460	804	1		0	\N	\N
372	456	608	0	\N	0	\N	\N
373	292	805	1		0	\N	\N
374	17	806	1		0	\N	\N
375	18	807	1		0	\N	\N
376	28	808	1		0	\N	\N
377	455	809	1		0	\N	\N
378	13	810	1		0	\N	\N
379	14	811	1		0	\N	\N
380	458	812	1		0	\N	\N
381	447	522	0	\N	0	\N	\N
382	447	524	0	\N	0	\N	\N
383	447	525	0	\N	0	\N	\N
384	447	573	0	\N	0	\N	\N
385	60	813	1		0	\N	\N
386	441	814	1		0	\N	\N
387	295	815	1		0	\N	\N
388	370	816	1		0	\N	\N
389	141	655	0	\N	0	\N	\N
390	124	643	0	\N	0	\N	\N
391	125	817	1		0	\N	\N
392	504	818	1		0	\N	\N
393	255	171	0	\N	0	\N	\N
394	368	819	1		0	\N	\N
396	155	591	0	\N	0	\N	\N
397	461	819	0	\N	0	\N	\N
398	469	820	1		0	\N	\N
399	119	184	0	\N	0	\N	\N
400	411	821	1		0	\N	\N
401	113	822	1		0	\N	\N
402	145	106	0	\N	0	\N	\N
403	146	823	1		0	\N	\N
404	362	824	1		0	\N	\N
405	446	825	1		0	\N	\N
406	472	141	0	\N	0	\N	\N
407	480	826	1		0	\N	\N
408	328	827	1		0	\N	\N
409	475	828	1		0	\N	\N
410	477	829	1		0	\N	\N
411	51	830	1		0	\N	\N
412	27	526	0	\N	0	\N	\N
413	175	58	0	\N	0	\N	\N
415	223	832	1		0	\N	\N
416	197	685	0	\N	0	\N	\N
417	445	825	0	\N	0	\N	\N
418	176	735	0	\N	0	\N	\N
419	355	833	1		0	\N	\N
420	42	834	1		0	\N	\N
421	386	835	1		0	\N	\N
422	352	295	0	\N	0	\N	\N
423	43	836	1		0	\N	\N
424	332	837	1		0	\N	\N
425	366	838	1		0	\N	\N
426	37	219	0	\N	0	\N	\N
427	514	839	1		0	\N	\N
430	59	230	0	\N	0	\N	\N
431	220	287	0	\N	0	\N	\N
432	220	288	0	\N	0	\N	\N
433	12	102	0	\N	0	\N	\N
434	182	840	1		0	\N	\N
435	358	841	1		0	\N	\N
436	192	842	1		0	\N	\N
437	70	843	1		0	\N	\N
438	46	152	0	\N	0	\N	\N
439	101	95	0	\N	0	\N	\N
440	79	844	1		0	\N	\N
441	86	845	1		0	\N	\N
442	388	846	1		0	\N	\N
443	353	847	1		0	\N	\N
444	334	848	1		0	\N	\N
445	372	849	1		0	\N	\N
446	170	436	0	\N	0	\N	\N
447	479	850	1		0	\N	\N
448	169	851	1		0	\N	\N
449	363	852	1		0	\N	\N
450	26	853	1		0	\N	\N
451	3	854	1		0	\N	\N
452	61	758	0	\N	0	\N	\N
453	61	235	0	\N	0	\N	\N
454	98	855	1		0	\N	\N
455	272	220	0	\N	0	\N	\N
456	272	410	0	\N	0	\N	\N
457	120	216	0	\N	0	\N	\N
459	134	26	0	\N	0	\N	\N
460	517	96	0	\N	0	\N	\N
461	209	856	1		0	\N	\N
462	73	857	1		0	\N	\N
463	343	858	1		0	\N	\N
464	232	859	1		0	\N	\N
465	5	860	1		0	\N	\N
466	131	861	1		0	\N	\N
467	4	862	1		0	\N	\N
469	463	863	1		0	\N	\N
470	277	39	0	\N	0	\N	\N
471	105	864	1		0	\N	\N
472	111	865	1		0	\N	\N
473	296	866	1		0	\N	\N
474	112	711	0	\N	0	\N	\N
475	44	867	1		0	\N	\N
476	212	868	1		0	\N	\N
477	423	774	0	\N	0	\N	\N
478	423	382	0	\N	0	\N	\N
479	423	383	0	\N	0	\N	\N
480	94	869	1		0	\N	\N
481	21	804	0	\N	0	\N	\N
482	414	846	0	\N	0	\N	\N
483	132	846	0	\N	0	\N	\N
484	473	818	0	\N	0	\N	\N
485	473	83	0	\N	0	\N	\N
486	191	625	0	\N	0	\N	\N
487	191	776	0	\N	0	\N	\N
488	76	52	0	\N	0	\N	\N
489	76	399	0	\N	0	\N	\N
490	198	870	1		0	\N	\N
491	361	871	1		0	\N	\N
492	275	641	0	\N	0	\N	\N
493	506	872	1		0	\N	\N
494	178	873	1		0	\N	\N
495	93	590	0	\N	0	\N	\N
496	410	656	0	\N	0	\N	\N
497	515	235	0	\N	0	\N	\N
498	33	263	0	\N	0	\N	\N
499	306	874	1		0	\N	\N
500	300	875	1		0	\N	\N
501	359	876	1		0	\N	\N
502	23	877	1		0	\N	\N
503	344	878	1		0	\N	\N
504	24	879	1		0	\N	\N
505	29	880	1		0	\N	\N
506	438	881	1		0	\N	\N
507	442	882	1		0	\N	\N
508	213	868	0	\N	0	\N	\N
509	213	4	0	\N	0	\N	\N
510	284	883	1		0	\N	\N
511	139	632	0	\N	0	\N	\N
512	83	884	1		0	\N	\N
513	19	464	0	\N	0	\N	\N
514	340	641	0	\N	0	\N	\N
515	470	885	1		0	\N	\N
516	261	886	1		0	\N	\N
517	77	887	1		0	\N	\N
518	45	888	1		0	\N	\N
520	350	890	1		0	\N	\N
521	81	572	0	\N	0	\N	\N
522	527	891	1		0	\N	\N
523	308	892	1		0	\N	\N
525	335	831	1		0	\N	\N
526	25	430	0	\N	0	\N	\N
527	88	893	1		0	\N	\N
528	528	894	1		0	\N	\N
529	78	895	1		0	\N	\N
530	147	896	1		0	\N	\N
531	36	897	1		0	\N	\N
532	177	898	1		0	\N	\N
533	321	899	1		0	\N	\N
534	466	900	1		0	\N	\N
535	530	901	1		0	\N	\N
536	312	902	1		0	\N	\N
537	316	903	1		0	\N	\N
538	531	904	1		0	\N	\N
539	529	23	0		0	\N	\N
540	529	137	0		0	\N	\N
541	202	579	2	\N	0	\N	\N
542	10	862	1		0	\N	0
543	68	647	0		0	\N	0
544	254	839	0		0	\N	0
545	254	244	0		0	\N	0
546	254	276	0		0	\N	0
547	254	481	0		0	\N	0
548	254	512	0		0	\N	0
549	254	516	0		0	\N	0
550	247	595	0		0	\N	0
551	247	650	0		0	\N	0
552	247	826	0		0	\N	0
553	247	508	0		0	\N	0
554	257	634	0		0	\N	0
555	257	667	0		0	\N	0
556	257	748	0		0	\N	0
557	257	786	0		0	\N	0
558	257	891	0		0	\N	0
559	250	38	0		0	\N	0
560	250	42	0		0	\N	0
561	250	531	0		0	\N	0
562	250	740	0		0	\N	0
563	256	604	0		0	\N	0
564	256	671	0		0	\N	0
565	256	9	0		0	\N	0
566	256	209	0		0	\N	0
567	256	471	0		0	\N	0
568	256	481	0		0	\N	0
569	256	554	0		0	\N	0
570	127	37	0		0	\N	0
571	127	39	0		0	\N	0
572	127	63	0		0	\N	0
573	127	313	0		0	\N	0
574	247	828	0		0	\N	0
575	47	645	0		0	\N	0
576	47	7	0		0	\N	0
577	308	661	0		0	\N	0
578	249	2	0		0	\N	0
579	249	17	0		0	\N	0
580	532	595	0		0	\N	0
581	532	73	0		0	\N	0
582	532	80	0		0	\N	0
583	532	109	0		0	\N	0
584	99	30	0		0	\N	0
585	99	67	0		0	\N	0
586	376	130	0		0	\N	0
587	243	613	0		0	\N	0
588	243	706	0		0	\N	0
589	243	57	0		0	\N	0
590	243	561	0		0	\N	0
591	462	581	0		0	\N	0
592	311	723	0		0	\N	0
593	226	580	0		0	\N	0
594	226	542	0		0	\N	0
595	262	826	0		0	\N	0
596	262	555	0		0	\N	0
597	252	799	0		0	\N	0
598	252	818	0		0	\N	0
599	252	334	0		0	\N	0
600	252	461	0		0	\N	0
601	251	665	0		0	\N	0
602	505	832	0		0	\N	0
603	505	818	0		0	\N	0
604	505	479	0		0	\N	0
605	115	648	0		0	\N	0
606	115	333	0		0	\N	0
607	115	530	0		0	\N	0
608	55	766	0		0	\N	0
609	55	175	0		0	\N	0
610	55	176	0		0	\N	0
611	55	465	0		0	\N	0
612	493	752	0		0	\N	0
613	478	700	0		0	\N	0
614	478	8	0		0	\N	0
615	478	70	0		0	\N	0
616	478	137	0		0	\N	0
617	181	891	0		0	\N	0
618	181	4	0		0	\N	0
619	181	107	0		0	\N	0
620	181	299	0		0	\N	0
621	181	741	0		0	\N	0
622	196	874	0		0	\N	0
623	207	370	0		0	\N	0
624	207	472	0		0	\N	0
625	207	493	0		0	\N	0
626	207	543	0		0	\N	0
627	89	294	1		0	\N	0
628	89	480	2		0	\N	0
629	100	284	1		0	\N	0
630	498	565	2		0	\N	0
631	165	143	2		0	\N	0
632	258	16	1		0	\N	0
633	260	327	1		0	\N	0
634	258	644	2		0	\N	0
635	258	128	3		0	\N	0
636	258	365	4		0	\N	0
637	258	14	5		0	\N	0
638	258	407	6		0	\N	0
639	260	52	2		0	\N	0
640	258	92	7		0	\N	0
641	258	445	8		0	\N	0
642	65	875	0		0	\N	0
643	65	396	0		0	\N	0
644	65	265	0		0	\N	0
645	439	857	0		0	\N	0
646	439	510	0		0	\N	0
647	109	619	0		0	\N	0
648	109	746	0		0	\N	0
649	109	772	0		0	\N	0
650	109	793	0		0	\N	0
651	109	848	0		0	\N	0
652	109	824	0		0	\N	0
653	109	27	0		0	\N	0
654	109	316	0		0	\N	0
655	109	319	0		0	\N	0
656	109	514	0		0	\N	0
657	533	506	1	Nereye	0	\N	0
658	533	663	2		0	\N	0
659	533	768	3		0	\N	0
660	519	384	0		0	\N	0
661	91	660	0		0	\N	0
662	91	869	0		0	\N	0
663	91	471	0		0	\N	0
664	91	538	0		0	\N	0
665	91	541	0		0	\N	0
666	91	542	0		0	\N	0
667	91	544	0		0	\N	0
668	91	574	0		0	\N	0
669	54	629	0		0	\N	0
670	54	894	0		0	\N	0
671	54	702	0		0	\N	0
672	54	121	0		0	\N	0
673	54	122	0		0	\N	0
674	54	157	0		0	\N	0
675	54	303	0		0	\N	0
676	127	651	0		0	\N	0
677	127	667	0		0	\N	0
678	127	689	0		0	\N	0
679	127	707	0		0	\N	0
680	127	33	0		0	\N	0
681	127	314	0		0	\N	0
682	127	722	0		0	\N	0
683	510	640	0		0	\N	0
684	510	655	0		0	\N	0
685	510	670	0		0	\N	0
686	510	671	0		0	\N	0
687	510	789	0		0	\N	0
688	510	840	0		0	\N	0
689	510	854	0		0	\N	0
690	510	886	0		0	\N	0
691	510	805	0		0	\N	0
692	510	228	0		0	\N	0
693	510	238	0		0	\N	0
694	510	277	0		0	\N	0
695	510	449	0		0	\N	0
696	510	488	0		0	\N	0
697	108	788	0		0	\N	0
698	108	693	0		0	\N	0
699	107	893	0		0	\N	0
700	107	701	0		0	\N	0
701	107	802	0		0	\N	0
702	107	411	0		0	\N	0
703	107	738	0		0	\N	0
704	30	74	0		0	\N	0
705	30	408	0		0	\N	0
706	241	580	0		0	\N	0
707	241	711	0		0	\N	0
708	241	27	0		0	\N	0
709	241	28	0		0	\N	0
710	241	572	0		0	\N	0
711	121	799	0		0	\N	0
712	121	800	0		0	\N	0
713	121	866	0		0	\N	0
714	121	699	0		0	\N	0
715	121	3	0		0	\N	0
716	121	112	0		0	\N	0
717	121	153	0		0	\N	0
718	15	87	0		0	\N	0
719	15	734	0		0	\N	0
720	138	857	0		0	\N	0
723	429	255	0		0	\N	0
724	429	448	0		0	\N	0
726	421	255	1		0	\N	0
728	421	448	3		0	\N	0
729	130	817	0		0	\N	0
730	130	22	0		0	\N	0
731	128	191	0		0	\N	0
732	534	18	1		0	\N	0
733	534	146	2		0	\N	0
734	534	148	3		0	\N	0
735	534	778	4		0	\N	0
736	534	20	5		0	\N	0
737	534	23	6		0	\N	0
738	534	103	7		0	\N	0
739	534	26	8		0	\N	0
740	534	807	9		0	\N	0
741	535	761	0		0	\N	0
742	133	38	0		0	\N	0
743	117	586	0		0	\N	0
744	536	146	1		0	\N	0
745	536	280	2		0	\N	0
746	536	508	3		0	\N	0
747	536	244	4	önce	0	\N	0
748	536	102	5		0	\N	0
749	536	103	6		0	\N	0
750	263	71	0		0	\N	0
751	263	247	0		0	\N	0
752	263	442	0		0	\N	0
753	263	504	0		0	\N	0
754	63	88	1		0	\N	0
755	63	854	2		0	\N	0
756	219	523	0		0	\N	0
757	219	573	0		0	\N	0
758	200	662	0		0	\N	0
759	200	111	0		0	\N	0
760	242	599	0		0	\N	0
761	242	129	0		0	\N	0
762	508	636	0		0	\N	0
763	508	666	0		0	\N	0
764	508	678	0		0	\N	0
765	508	126	0		0	\N	0
766	508	275	0		0	\N	0
767	508	278	0		0	\N	0
768	508	347	0		0	\N	0
769	508	514	0		0	\N	0
770	401	446	0		0	\N	0
771	218	868	0		0	\N	0
772	501	478	0		0	\N	0
773	501	479	0		0	\N	0
774	501	736	0		0	\N	0
775	424	633	0		0	\N	0
776	424	704	0		0	\N	0
777	424	77	0		0	\N	0
778	424	278	0		0	\N	0
779	424	279	0		0	\N	0
780	424	281	0		0	\N	0
781	424	342	0		0	\N	0
782	424	343	0		0	\N	0
783	424	344	0		0	\N	0
784	428	99	0		0	\N	0
785	428	254	0		0	\N	0
786	428	349	0		0	\N	0
787	456	849	0		0	\N	0
789	18	647	0		0	\N	0
790	18	766	0		0	\N	0
791	18	794	0		0	\N	0
794	18	841	0		0	\N	0
797	18	353	0		0	\N	0
799	18	359	0		0	\N	0
800	18	352	0		0	\N	0
802	18	736	0		0	\N	0
803	17	402	2		0	\N	0
804	17	880	0		0	\N	0
805	17	354	0		0	\N	0
807	28	668	0		0	\N	0
808	28	837	0		0	\N	0
809	28	838	0		0	\N	0
810	28	845	0		0	\N	0
811	28	147	0		0	\N	0
813	14	810	0		0	\N	0
814	458	588	0		0	\N	0
815	447	25	0		0	\N	0
816	447	91	0		0	\N	0
817	447	127	0		0	\N	0
818	447	471	0		0	\N	0
819	447	472	0		0	\N	0
820	141	380	0		0	\N	0
821	141	102	0		0	\N	0
822	141	105	0		0	\N	0
823	141	419	0		0	\N	0
824	141	420	0		0	\N	0
825	141	742	0		0	\N	0
827	125	110	0		0	\N	0
828	504	332	0		0	\N	0
829	255	682	0		0	\N	0
830	255	687	0		0	\N	0
831	255	697	0		0	\N	0
832	255	141	0		0	\N	0
833	255	338	0		0	\N	0
835	113	152	0		0	\N	0
836	113	343	0		0	\N	0
837	145	38	0		0	\N	0
838	51	893	0		0	\N	0
839	42	903	0		0	\N	0
840	332	832	0		0	\N	0
841	366	668	0		0	\N	0
842	538	480	0		0	\N	0
843	537	623	0		0	\N	0
844	537	876	0		0	\N	0
845	537	695	0		0	\N	0
846	537	739	0		0	\N	0
847	12	765	0		0	\N	0
848	12	835	0		0	\N	0
849	46	582	0		0	\N	0
850	46	133	0		0	\N	0
851	46	201	0		0	\N	0
852	101	357	0		0	\N	0
853	101	387	0		0	\N	0
854	321	620	0		0	\N	0
855	170	11	0		0	\N	0
856	170	74	0		0	\N	0
857	170	430	0		0	\N	0
858	170	432	0		0	\N	0
859	170	435	0		0	\N	0
860	529	584	0		0	\N	0
861	529	20	0		0	\N	0
862	529	26	0		0	\N	0
863	529	70	0		0	\N	0
865	529	146	0		0	\N	0
866	529	148	0		0	\N	0
867	529	162	0		0	\N	0
868	61	238	0		0	\N	0
869	98	22	0		0	\N	0
870	120	585	0		0	\N	0
871	120	376	0		0	\N	0
872	120	377	0		0	\N	0
873	10	140	2		0	\N	0
875	527	596	0		0	\N	0
876	539	106	1		0	\N	0
877	539	230	2	var	0	\N	0
878	539	256	3		0	\N	0
879	539	587	0		0	\N	0
880	539	593	0		0	\N	0
881	539	615	0		0	\N	0
882	539	790	0		0	\N	0
883	539	6	0		0	\N	0
884	539	97	0		0	\N	0
885	539	102	0		0	\N	0
886	539	115	0		0	\N	0
887	539	236	0		0	\N	0
888	539	252	0		0	\N	0
889	539	309	0		0	\N	0
890	539	419	0		0	\N	0
891	539	536	0		0	\N	0
892	539	539	0		0	\N	0
893	73	852	0		0	\N	0
894	73	833	0		0	\N	0
895	73	516	0		0	\N	0
897	540	807	0		0	\N	0
898	540	161	0		0	\N	0
899	464	831	0		0	\N	0
900	464	863	0		0	\N	0
901	464	50	0		0	\N	0
902	464	66	0		0	\N	0
903	464	134	0		0	\N	0
904	463	134	2		0	\N	0
905	463	66	3		0	\N	0
906	463	84	4		0	\N	0
907	463	831	5		0	\N	0
908	277	864	0		0	\N	0
912	112	608	0		0	\N	0
913	112	897	0		0	\N	0
914	112	249	0		0	\N	0
915	44	589	0		0	\N	0
916	44	609	0		0	\N	0
917	44	678	0		0	\N	0
918	44	792	0		0	\N	0
919	44	368	0		0	\N	0
920	44	382	0		0	\N	0
921	423	672	0		0	\N	0
922	423	902	0		0	\N	0
923	423	811	0		0	\N	0
924	423	63	0		0	\N	0
925	423	69	0		0	\N	0
926	423	252	0		0	\N	0
927	423	339	0		0	\N	0
928	423	340	0		0	\N	0
929	423	414	0		0	\N	0
930	21	298	0		0	\N	0
931	21	436	0		0	\N	0
932	473	9	0		0	\N	0
933	473	82	0		0	\N	0
934	473	304	0		0	\N	0
935	473	516	0		0	\N	0
936	473	727	0		0	\N	0
937	191	748	0		0	\N	0
938	191	785	0		0	\N	0
939	191	843	0		0	\N	0
940	191	871	0		0	\N	0
941	191	697	0		0	\N	0
942	198	748	0		0	\N	0
943	198	284	0		0	\N	0
944	76	671	0		0	\N	0
945	76	842	0		0	\N	0
946	76	403	0		0	\N	0
947	76	404	0		0	\N	0
948	275	583	0		0	\N	0
949	275	609	0		0	\N	0
950	275	665	0		0	\N	0
951	275	781	0		0	\N	0
952	275	836	0		0	\N	0
953	275	37	0		0	\N	0
954	275	89	0		0	\N	0
955	275	324	0		0	\N	0
956	541	398	0		0	\N	0
958	410	602	0		0	\N	0
959	410	604	0		0	\N	0
960	410	650	0		0	\N	0
961	410	681	0		0	\N	0
962	515	578	0		0	\N	0
963	515	703	0		0	\N	0
964	515	372	0		0	\N	0
965	515	257	0		0	\N	0
966	515	274	0		0	\N	0
967	515	457	0		0	\N	0
968	542	216	1	yolculuk	0	\N	0
969	344	158	0		0	\N	0
970	543	221	0		0	\N	0
971	543	281	0		0	\N	0
972	543	464	0		0	\N	0
973	543	496	0		0	\N	0
975	136	147	1		0	\N	0
976	136	815	2		0	\N	0
977	136	379	3		0	\N	0
978	136	418	4		0	\N	0
979	322	770	1		0	\N	0
980	323	772	2		0	\N	0
984	206	469	2		0	\N	0
985	206	746	3		0	\N	0
986	310	89	1		0	\N	0
987	80	679	2		0	\N	0
988	431	618	1		0	\N	0
989	431	81	2		0	\N	0
990	431	256	3		0	\N	0
991	431	414	4		0	\N	0
993	116	57	2		0	\N	0
994	123	617	1		0	\N	0
995	123	714	2		0	\N	0
996	123	556	3		0	\N	0
997	123	717	4		0	\N	0
998	434	73	1		0	\N	0
999	434	654	2		0	\N	0
1000	82	773	2		0	\N	0
1001	236	827	2		0	\N	0
1002	236	589	3		0	\N	0
1003	374	367	1		0	\N	0
1004	374	310	2		0	\N	0
1005	237	631	1		0	\N	0
1006	237	875	2		0	\N	0
1007	237	1038	3		0	\N	0
1008	523	329	1		0	\N	0
1009	383	531	1		0	\N	0
1010	422	30	1		0	\N	0
1011	422	451	2		0	\N	0
1012	422	489	3		0	\N	0
1013	422	819	4		0	\N	0
1014	422	566	5		0	\N	0
1015	422	900	6		0	\N	0
1016	422	628	7		0	\N	0
1017	422	704	8		0	\N	0
1018	422	134	9		0	\N	0
1019	437	417	1		0	\N	0
1020	267	386	1		0	\N	0
1021	267	227	2		0	\N	0
1022	336	582	2		0	\N	0
1023	409	442	1		0	\N	0
1024	83	895	2		0	\N	0
1025	233	693	2		0	\N	0
1026	179	873	1		0	\N	0
1027	487	753	1		0	\N	0
1028	487	833	2		0	\N	0
1029	487	156	3		0	\N	0
1030	487	756	4		0	\N	0
1031	487	880	5		0	\N	0
1032	290	601	1		0	\N	0
1033	290	673	2		0	\N	0
1034	290	1028	3		0	\N	0
1035	290	660	4		0	\N	0
1036	290	509	5		0	\N	0
1037	290	208	6		0	\N	0
1038	290	375	7		0	\N	0
1039	290	75	8		0	\N	0
1040	290	786	9		0	\N	0
1041	290	215	10		0	\N	0
1042	290	96	11		0	\N	0
1043	290	769	12		0	\N	0
1044	290	585	13		0	\N	0
1045	19	694	1		0	\N	0
1046	184	740	2		0	\N	0
1047	135	227	1		0	\N	0
1048	158	306	2		0	\N	0
1049	158	305	3		0	\N	0
1050	129	855	1		0	\N	0
1051	129	379	2		0	\N	0
1052	129	743	3		0	\N	0
1053	476	807	2		0	\N	0
1054	476	161	3		0	\N	0
1055	524	392	1	dışarı	0	\N	0
1056	524	589	2		0	\N	0
1057	524	812	3		0	\N	0
1058	150	486	1		0	\N	0
1059	150	518	2		0	\N	0
1060	425	200	1		0	\N	0
1061	425	54	2		0	\N	0
1062	425	101	3		0	\N	0
1063	425	614	4		0	\N	0
1064	425	33	5		0	\N	0
1065	193	597	1		0	\N	0
1066	346	596	1		0	\N	0
1067	340	836	1		0	\N	0
1068	71	813	2		0	\N	0
1069	71	632	3		0	\N	0
1070	85	654	1		0	\N	0
1071	85	220	2		0	\N	0
1072	85	515	3		0	\N	0
1073	84	654	1		0	\N	0
1074	84	636	2		0	\N	0
1075	85	897	4		0	\N	0
1076	85	784	5		0	\N	0
1077	205	12	1		0	\N	0
1078	205	13	2		0	\N	0
1079	205	215	3		0	\N	0
1080	205	217	4		0	\N	0
1081	205	199	5		0	\N	0
1082	454	113	1		0	\N	0
1083	454	762	2		0	\N	0
1084	6	304	1		0	\N	0
1085	53	122	1		0	\N	0
1086	288	30	2		0	\N	0
1087	288	264	3		0	\N	0
1088	288	265	4		0	\N	0
1089	288	74	5		0	\N	0
1090	288	120	6		0	\N	0
1091	1	1	2		0	\N	0
1092	1	36	3		0	\N	0
1093	1	280	4		0	\N	0
1094	1	245	5		0	\N	0
1095	1	680	6		0	\N	0
1096	1	780	7		0	\N	0
1097	1	862	8		0	\N	0
1098	1	768	9		0	\N	0
1099	217	646	1		0	\N	0
1100	217	714	2		0	\N	0
1101	217	679	3		0	\N	0
1102	217	374	4		0	\N	0
1103	11	658	2		0	\N	0
1104	11	672	3		0	\N	0
1105	11	721	4		0	\N	0
1106	11	707	5		0	\N	0
1107	186	685	2		0	\N	0
1108	186	52	3		0	\N	0
1109	521	683	2		0	\N	0
1110	521	871	3		0	\N	0
1111	521	575	4		0	\N	0
1112	436	715	2		0	\N	0
1113	259	834	1		0	\N	0
1114	259	401	2		0	\N	0
1115	259	647	3		0	\N	0
1116	259	307	4		0	\N	0
1117	259	690	5		0	\N	0
1118	259	140	6		0	\N	0
1119	151	680	1		0	\N	0
1120	151	865	2		0	\N	0
1121	465	900	1		0	\N	0
1122	465	605	2		0	\N	0
1123	465	98	3		0	\N	0
1124	459	566	2		0	\N	0
1125	204	12	1		0	\N	0
1126	204	13	2		0	\N	0
1127	204	139	3		0	\N	0
1128	204	482	4		0	\N	0
1129	204	412	5		0	\N	0
1130	204	257	6		0	\N	0
1131	443	85	1		0	\N	0
1132	443	2	2		0	\N	0
1133	443	884	3		0	\N	0
1134	443	78	4		0	\N	0
1135	443	864	5		0	\N	0
1136	443	546	6		0	\N	0
1137	443	705	7		0	\N	0
1138	443	856	8		0	\N	0
1139	443	525	9		0	\N	0
1140	496	780	1		0	\N	0
1141	25	431	1		0	\N	0
1142	25	434	2		0	\N	0
1143	25	138	3		0	\N	0
1144	232	683	2		0	\N	0
1145	232	107	3		0	\N	0
1146	232	153	4		0	\N	0
1147	297	4	2		0	\N	0
1148	297	687	3		0	\N	0
1149	183	686	2		0	\N	0
1150	183	54	3		0	\N	0
1151	183	873	4		0	\N	0
1152	183	349	5		0	\N	0
1153	171	820	2		0	\N	0
1154	2	305	1		0	\N	0
1155	491	72	1		0	\N	0
1156	491	700	2		0	\N	0
1157	491	801	3		0	\N	0
1159	47	892	2		0	\N	0
1160	47	615	3		0	\N	0
1161	47	344	4		0	\N	0
1162	47	663	5		0	\N	0
1163	47	777	6		0	\N	0
1164	164	39	1		0	\N	0
1165	72	646	2		0	\N	0
1166	72	100	3		0	\N	0
1167	72	867	4		0	\N	0
1168	72	140	5		0	\N	0
1169	72	546	6		0	\N	0
1170	72	780	7		0	\N	0
1171	72	695	8		0	\N	0
1172	72	541	9		0	\N	0
1173	72	142	10		0	\N	0
1174	72	820	11		0	\N	0
1175	72	538	12		0	\N	0
1176	282	526	2		0	\N	0
1177	282	343	3		0	\N	0
1178	282	137	4		0	\N	0
1179	282	640	5		0	\N	0
1180	282	335	6		0	\N	0
1181	282	56	7		0	\N	0
1182	282	464	8		0	\N	0
1183	8	21	1		0	\N	0
1184	8	18	2		0	\N	0
1185	8	850	3		0	\N	0
1186	8	829	4		0	\N	0
1187	8	726	5		0	\N	0
1188	64	628	2		0	\N	0
1189	64	796	3		0	\N	0
1190	64	710	4		0	\N	0
1191	64	232	5		0	\N	0
1192	64	228	6		0	\N	0
1193	64	287	7		0	\N	0
1194	64	791	8		0	\N	0
1195	64	633	9		0	\N	0
1196	64	77	10		0	\N	0
1197	64	643	11		0	\N	0
1198	64	779	12		0	\N	0
1199	489	751	2		0	\N	0
1200	378	475	2		0	\N	0
1201	378	481	3		0	\N	0
1202	378	567	4		0	\N	0
1203	378	703	5		0	\N	0
1204	378	478	6		0	\N	0
1205	378	742	7		0	\N	0
1207	536	162	7		0	\N	0
1208	223	837	2		0	\N	0
1209	352	287	1		0	\N	0
1210	352	290	2		0	\N	0
1211	352	288	3		0	\N	0
1212	209	649	2		0	\N	0
1213	545	566	1		0	\N	0
1214	544	791	1		0	\N	0
1215	544	621	2		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: tr
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
330	26
331	26
332	26
333	26
334	26
335	26
336	26
337	26
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
522	32
523	24
524	24
525	24
527	24
528	37
529	1
530	7
531	7
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
28	gelmek	\N	\N	\N
29	balkon	\N	\N	\N
30	manzara	\N	\N	\N
31	göstermek	\N	\N	\N
32	bura	\N	\N	\N
33	güzel	\N	\N	\N
34	evet	\N	\N	\N
35	gerçekten	\N	\N	\N
36	miş/mış	\N	\N	\N
37	bak	\N	\N	\N
38	şu	\N	\N	\N
39	karşı＋da＋ki	\N	\N	\N
40	yüksek	\N	\N	\N
41	bina	\N	\N	\N
42	görmek	\N	\N	\N
43	mu	\N	\N	\N
44	hangi	\N	\N	\N
45		\N	\N	\N
46	sol	\N	\N	\N
47	taraf	\N	\N	\N
48	büyük	\N	\N	\N
49	bir	\N	\N	\N
50	cami	\N	\N	\N
51	olan	\N	\N	\N
52	isim	\N	\N	\N
53	Ankara	\N	\N	\N
54	üçüncü	\N	\N	\N
55	sınıf	\N	\N	\N
56	öğrenci	\N	\N	\N
57	ad	\N	\N	\N
58	tanışmak	\N	\N	\N
59	memnun	\N	\N	\N
60	alo	\N	\N	\N
61	efendim	\N	\N	\N
62	an	\N	\N	\N
63	müsait	\N	\N	\N
64	mi	\N	\N	\N
65	ｄün	\N	\N	\N
66	niçin	\N	\N	\N
67	aramak	\N	\N	\N
68	bütün	\N	\N	\N
69	gün	\N	\N	\N
70	telefon	\N	\N	\N
71	beklemek	\N	\N	\N
72	o	\N	\N	\N
73	için	\N	\N	\N
74	özür＋dilemek	\N	\N	\N
75	kusura＋bakma	\N	\N	\N
76	peki	\N	\N	\N
77	affetmek	\N	\N	\N
78	ama	\N	\N	\N
79	daha	\N	\N	\N
80	doğum günü	\N	\N	\N
81	kutlu	\N	\N	\N
82	hediye	\N	\N	\N
83	buyurmak	\N	\N	\N
84	gerek	\N	\N	\N
85	yok	\N	\N	\N
86	en	\N	\N	\N
87	sevmek	\N	\N	\N
88	çikolata	\N	\N	\N
89	beğenmek	\N	\N	\N
90	oldukça	\N	\N	\N
91	uzun	\N	\N	\N
92	yolculuk	1	Y	\N
93	yorulmak	\N	\N	\N
94	sonunda	\N	\N	\N
95	buradan	\N	\N	\N
96	taksi	\N	\N	\N
97	binmek	\N	\N	\N
98	ev	\N	\N	\N
99	fazla	\N	\N	\N
100	uzak	\N	\N	\N
101	yüz	\N	\N	\N
102	yürümek	\N	\N	\N
103	Anlamak	\N	\N	\N
104	Hoşça kal/kalın	\N	\N	\N
105	hoş geldin/geldiniz	\N	\N	\N
106	hoş bulduk	\N	\N	\N
107	boy	\N	\N	\N
108	defter	\N	\N	\N
109	kaç	\N	\N	\N
110	yaprak	\N	\N	\N
111	burada	\N	\N	\N
112	tane	\N	\N	\N
113	var	1	V	\N
114	lira	\N	\N	\N
115	acaba	\N	\N	\N
116	dört	\N	\N	\N
117	milyon	\N	\N	\N
118	bayağı	\N	\N	\N
119	pahalı	\N	\N	\N
120	ucuz	\N	\N	\N
121	birinci	\N	\N	\N
122	hamur	\N	\N	\N
123	fiyat	\N	\N	\N
124	iki	\N	\N	\N
125	almak	\N	\N	\N
126	hayırlı işler	\N	\N	\N
127	İran	\N	\N	\N
128	gitmek	\N	\N	\N
129	duymak	\N	\N	\N
130	ay	\N	\N	\N
131	son	\N	\N	\N
132	önce	1	Ö	\N
133	geçen sene	\N	\N	\N
134	eğlenceli	\N	\N	\N
135	öyle mi	\N	\N	\N
136	ile	\N	\N	\N
137	ilgili	\N	\N	\N
138	tavsiye	\N	\N	\N
139	yan	\N	\N	\N
140	mutlaka	\N	\N	\N
141	baş örtüsü	\N	\N	\N
142	götürmek	\N	\N	\N
143	yarın	\N	\N	\N
144	herhangi	\N	\N	\N
145	plan	\N	\N	\N
146	sabah	\N	\N	\N
147	erkenden	\N	\N	\N
148	Beşiktaş	\N	\N	\N
149	düşünmek	\N	\N	\N
150	öğleden sonra	\N	\N	\N
151	randevu	\N	\N	\N
152	akşam	\N	\N	\N
153	hayır	\N	\N	\N
154	neden	\N	\N	\N
155	buluşmak	\N	\N	\N
156	yer	\N	\N	\N
157	biraz	\N	\N	\N
158	geç kalmak	\N	\N	\N
159	ne kadar	\N	\N	\N
160	dakika	\N	\N	\N
161	kadar	\N	\N	\N
162	tamam	\N	\N	\N
163	ne haber	\N	\N	\N
164	iyilik	\N	\N	\N
165	bugün	\N	\N	\N
166	parti	\N	\N	\N
167	haber(i) yok	\N	\N	\N
168	gelsene	\N	\N	\N
169	olur	\N	\N	\N
170	saat kaçta	\N	\N	\N
171	başlamak	\N	\N	\N
172	gitmeden önce	\N	\N	\N
173	lazım	\N	\N	\N
174	yani	\N	\N	\N
175	sonra	\N	\N	\N
176	yemek	\N	\N	\N
177	masa	\N	\N	\N
178	hazırlamak	\N	\N	\N
179	misafir	\N	\N	\N
180	üzere	\N	\N	\N
181	tabak	\N	\N	\N
182	toplam	\N	\N	\N
183	yedi	\N	\N	\N
184	pardon	\N	\N	\N
185	salata	\N	\N	\N
186	sekiz	\N	\N	\N
187	etmek	\N	\N	\N
188	tabii	\N	\N	\N
189	getirmek	\N	\N	\N
190	doldurmak	\N	\N	\N
191	çorba	\N	\N	\N
192	kepçe	\N	\N	\N
193	yavaşça	\N	\N	\N
194	pilav	\N	\N	\N
195	kaşık	\N	\N	\N
196	bol bol	\N	\N	\N
197	koymak	\N	\N	\N
198	öz geçmi	\N	\N	\N
199	okumak	\N	\N	\N
200	İngilizce	\N	\N	\N
201	Fransızca	\N	\N	\N
202	bilmek	\N	\N	\N
203	yazmak	\N	\N	\N
204	ne	\N	\N	\N
205	derece	\N	\N	\N
206	iyi	\N	\N	\N
207	seviye	\N	\N	\N
208	orta	\N	\N	\N
209	başka	\N	\N	\N
210	gibi	\N	\N	\N
211	yetenekl	\N	\N	\N
212	bilgisayar	\N	\N	\N
213	kullanmak	\N	\N	\N
214	ayrıca	\N	\N	\N
215	Almanca	\N	\N	\N
216	hoca	\N	\N	\N
217	okul	\N	\N	\N
218	nerede	\N	\N	\N
219	toplantı	\N	\N	\N
220	salon	\N	\N	\N
221	ana bina	\N	\N	\N
222	üçüncü kat	\N	\N	\N
223	yeni	\N	\N	\N
224	eleman	\N	\N	\N
225	mü	\N	\N	\N
226	iş	\N	\N	\N
227	biri	\N	\N	\N
228	yaş	\N	\N	\N
229	metre	\N	\N	\N
230	santim	\N	\N	\N
231	saç	\N	\N	\N
232	renk	\N	\N	\N
233	siyah	\N	\N	\N
234	kısa	\N	\N	\N
235	kıvırcık	\N	\N	\N
236	öyle	\N	\N	\N
237	birisi	\N	\N	\N
238	iyi günler	\N	\N	\N
239	yapmak	\N	\N	\N
240	ertelemek	\N	\N	\N
241	ne dersiniz	\N	\N	\N
242	uygun	\N	\N	\N
243	göre	\N	\N	\N
244	kaçta	\N	\N	\N
245	sormak	\N	\N	\N
246	çünkü	\N	\N	\N
247	herkes	\N	\N	\N
248	bitmek	\N	\N	\N
249	dünkü	\N	\N	\N
250	eğlenmek	\N	\N	\N
251	içmek	\N	\N	\N
252	hep	\N	\N	\N
253	sarhoş	\N	\N	\N
254	galiba	\N	\N	\N
255	rakı 	\N	\N	\N
256	şarap	\N	\N	\N
257	birlikte	\N	\N	\N
258	televizyon	\N	\N	\N
259	seyretmek	\N	\N	\N
260	patlamış mısır	\N	\N	\N
261	dondurma	\N	\N	\N
262	bayılmak	\N	\N	\N
263	bira	\N	\N	\N
264	hoşuma gitmek	\N	\N	\N
265	firma	\N	\N	\N
266	geçen ay	\N	\N	\N
267	ancak	\N	\N	\N
268	şimdi	\N	\N	\N
269	çalışmak	\N	\N	\N
270	yapmam	\N	\N	\N
271	gerekmek	\N	\N	\N
272	elektrik	\N	\N	\N
273	kontrol	\N	\N	\N
274	tüm	\N	\N	\N
275	fiş	\N	\N	\N
276	priz	\N	\N	\N
277	takılı	\N	\N	\N
278	lütfen	\N	\N	\N
279	son olarak	\N	\N	\N
280	başlat tuşu	\N	\N	\N
281	basmak	\N	\N	\N
282	değişiklik	\N	\N	\N
283	tamir	\N	\N	\N
284	görevli	\N	\N	\N
285	göndermek	\N	\N	\N
286	görüşmeyeli	\N	\N	\N
287	görmeyeli	\N	\N	\N
288	her gün	\N	\N	\N
289	ders	\N	\N	\N
290	sınav	\N	\N	\N
291	hazırlanmak	\N	\N	\N
292	bir şey	\N	\N	\N
293	boş	\N	\N	\N
294	beraber	\N	\N	\N
295	sinema	\N	\N	\N
296	İstanbul	\N	\N	\N
297	deprem	\N	\N	\N
298	uzmanl	\N	\N	\N
299	devamlı	\N	\N	\N
300	uyarmak	\N	\N	\N
301	panik	\N	\N	\N
302	kapılmak	\N	\N	\N
303	yakın	\N	\N	\N
304	alt	\N	\N	\N
305	girmek	\N	\N	\N
306	dışarı	1	D	\N
307	çıkmak	\N	\N	\N
308	Japonya	\N	\N	\N
309	hoş gelmek	\N	\N	\N
310	yaklaşık	\N	\N	\N
311	sayılmak	\N	\N	\N
312	alışmak	\N	\N	\N
313	lezzetli	\N	\N	\N
314	yoksa	\N	\N	\N
315	ｇünaydın	\N	\N	\N
316	ileri	\N	\N	\N
317	durak	\N	\N	\N
318	otobüs	\N	\N	\N
319	ora	\N	\N	\N
320	ders çalışmak	\N	\N	\N
321	üç	\N	\N	\N
322	hafta	\N	\N	\N
323	sadece	\N	\N	\N
324	zaman	\N	\N	\N
325	istek	\N	\N	\N
326	dinlemek	\N	\N	\N
327	yerine	\N	\N	\N
328	rahatsız	\N	\N	\N
329	da	\N	\N	\N
330	elbette	\N	\N	\N
331	yatmak	\N	\N	\N
332	dinlenmek	\N	\N	\N
333	tren	\N	\N	\N
334	hızlı	\N	\N	\N
335	mı	\N	\N	\N
336	mesela	\N	\N	\N
337	ara	\N	\N	\N
338	ekspres	\N	\N	\N
339	sürmek	\N	\N	\N
340	maalesef	\N	\N	\N
341	yavaş	\N	\N	\N
342	örneğin	\N	\N	\N
343	otobüst	\N	\N	\N
344	inanmak	\N	\N	\N
345	hanım	\N	\N	\N
346	bu hafta	\N	\N	\N
347	salı	\N	\N	\N
348	öyleyse	\N	\N	\N
349	cuma	\N	\N	\N
350	müdür	\N	\N	\N
351	perşembe	\N	\N	\N
352	meşgul	\N	\N	\N
353	mucize	\N	\N	\N
354	anlatmak	\N	\N	\N
355	prezantasyon	\N	\N	\N
356	müsaade＋etmek	\N	\N	\N
357	istemek	\N	\N	\N
358	dönem	\N	\N	\N
359	haftaya	\N	\N	\N
360	kim	\N	\N	\N
361	tarih	\N	\N	\N
362	kaynak	\N	\N	\N
363	kitap	\N	\N	\N
364	anlamak	\N	\N	\N
365	affeｔmek	\N	\N	\N
366	hanımefendi	\N	\N	\N
367	oda	\N	\N	\N
368	sigara	\N	\N	\N
369	yasak	\N	\N	\N
370	levha	\N	\N	\N
371	fark＋etmek	\N	\N	\N
372	kalem	\N	\N	\N
373	kaybetmek	\N	\N	\N
374	kırmızı	\N	\N	\N
375	üzerinde	\N	\N	\N
376	ondan	\N	\N	\N
377	işte	\N	\N	\N
378	orada	\N	\N	\N
379	ağabey	\N	\N	\N
380	bozulmak	\N	\N	\N
381	mesaiye kalmak	\N	\N	\N
382	doğru	\N	\N	\N
383	kalmak	\N	\N	\N
384	yurt	\N	\N	\N
385	dış	\N	\N	\N
386	sevinmek	\N	\N	\N
387	nereye	1	N	\N
388	veda＋partisi	\N	\N	\N
389	vermek	\N	\N	\N
390	ne zaman	\N	\N	\N
391	adres	\N	\N	\N
392	doktor	\N	\N	\N
393	son＋günlerde	\N	\N	\N
394	göğüs	\N	\N	\N
395	ağrımak	\N	\N	\N
396	içki	\N	\N	\N
397	birkaç	\N	\N	\N
399	paket	\N	\N	\N
400	sanmak	\N	\N	\N
401	hemen	\N	\N	\N
402	bırakmak	\N	\N	\N
403	spor	\N	\N	\N
404	sipariş	\N	\N	\N
405	mal	\N	\N	\N
406	henüz	\N	\N	\N
407	biz	\N	\N	\N
408	ulaşmak	\N	\N	\N
409	irtibat＋geçmek	\N	\N	\N
410	hoş＋gelmek	\N	\N	\N
411	rezervasyon	\N	\N	\N
412	tek	\N	\N	\N
413	kişilik	\N	\N	\N
414	mümkün	\N	\N	\N
415	kat	\N	\N	\N
416	yerleşmek	\N	\N	\N
417	nasıl	\N	\N	\N
418	sağ＋olmak	\N	\N	\N
419	arkadaş	\N	\N	\N
420	kendi	\N	\N	\N
421	dün	\N	\N	\N
422	İzmir	\N	\N	\N
423	Ahmet	\N	\N	\N
424	gitmeli.       	\N	\N	\N
425	Ben	\N	\N	\N
426	gitmeliyim.                 	\N	\N	\N
427	Fatma	\N	\N	\N
428	Deniz’in	\N	\N	\N
429	arkasında	\N	\N	\N
430	oturuyor.	\N	\N	\N
431	Fotoğrafları	\N	\N	\N
432	zarfın	\N	\N	\N
433	içine	\N	\N	\N
434	koydum.	\N	\N	\N
435	Arabanın	\N	\N	\N
436	altından	\N	\N	\N
437	kedi	\N	\N	\N
438	çıktı.	\N	\N	\N
439	Şehrin	\N	\N	\N
440	ortasında	\N	\N	\N
441	çarşı	\N	\N	\N
442	var. 	\N	\N	\N
443	Uğur’un	\N	\N	\N
444	sayesinde	\N	\N	\N
445	çabuk	\N	\N	\N
446	bitti.      	\N	\N	\N
447	Türkiye	\N	\N	\N
448	hakkında	\N	\N	\N
449	konuşalım.	\N	\N	\N
450	Bu	\N	\N	\N
451	roman	\N	\N	\N
452	Yaşar	\N	\N	\N
453	Kemal	\N	\N	\N
454	tarafından	\N	\N	\N
455	yazıldı.	\N	\N	\N
456	babamın	\N	\N	\N
457	geldim.	\N	\N	\N
458	Trenin	\N	\N	\N
459	gecikmesi	\N	\N	\N
460	yüzünden	\N	\N	\N
461	derse	\N	\N	\N
462	geç	\N	\N	\N
463	kaldım. 	\N	\N	\N
464	Bey	\N	\N	\N
465	mu?　Evet,	\N	\N	\N
466	doktor./	\N	\N	\N
467	Hay"r,	\N	\N	\N
468	değil.	\N	\N	\N
469	Çiçekler	\N	\N	\N
470	mi?	\N	\N	\N
471	Evet,Çiçekler	\N	\N	\N
472	güzel./	\N	\N	\N
473	Hay"r,Çiçekler	\N	\N	\N
474	Merhaba,	\N	\N	\N
475	nasılsınız	\N	\N	\N
476	?          	\N	\N	\N
477	İyiyim,	\N	\N	\N
478	ederim.	\N	\N	\N
479	 Siz	\N	\N	\N
480	?    	\N	\N	\N
481	iyiyim,	\N	\N	\N
482	Japonca	\N	\N	\N
483	öğreniyor.	\N	\N	\N
484	Her	\N	\N	\N
485	gazete	\N	\N	\N
486	okuyor.	\N	\N	\N
487	Türkçe	1	T	\N
488	biliyor	\N	\N	\N
489	?	\N	\N	\N
490	Öğrenciler	\N	\N	\N
491	derste	\N	\N	\N
492	uyumuyor.	\N	\N	\N
493	Biz	\N	\N	\N
494	öğreniyoruz.	\N	\N	\N
495	Şimdi	\N	\N	\N
496	çalışıyor	\N	\N	\N
497	musunuz	\N	\N	\N
498	içmiyorum.	\N	\N	\N
499	üniversitede	\N	\N	\N
500	Nerede	\N	\N	\N
501	oturuyorsunuz	\N	\N	\N
502	Konser	\N	\N	\N
503	saat	\N	\N	\N
504	yedide	\N	\N	\N
505	başladı.	\N	\N	\N
506	Ayhan	\N	\N	\N
507	kalktı.	\N	\N	\N
508	Ders	\N	\N	\N
509	başladı	\N	\N	\N
510	mı?	\N	\N	\N
511	ödev	\N	\N	\N
512	yaptı	\N	\N	\N
513	Süleyman	\N	\N	\N
514	okula	\N	\N	\N
515	gelmedi.	\N	\N	\N
516	Henüz	\N	\N	\N
517	karar	\N	\N	\N
518	vermedi.	\N	\N	\N
519	Evde	\N	\N	\N
520	ekmek	\N	\N	\N
521	kalmadı.	\N	\N	\N
522	Ali	\N	\N	\N
523	İstanbul’a	\N	\N	\N
524	gitti.	\N	\N	\N
525	Okula	\N	\N	\N
526	öğrenciler	\N	\N	\N
527	geldi．	\N	\N	\N
528	Öğretmen	\N	\N	\N
529	bize	\N	\N	\N
530	soru	\N	\N	\N
531	sordu.	\N	\N	\N
532	Okul	\N	\N	\N
533	istasyona	\N	\N	\N
534	yakın.	\N	\N	\N
535	Ahmet geldi.	\N	\N	\N
536	Biz geldik.	\N	\N	\N
537	Sen	\N	\N	\N
538	geldin.	\N	\N	\N
539	Siz geldiniz.	\N	\N	\N
540	Hoş	\N	\N	\N
541	geldiniz.	\N	\N	\N
542	bulduk.	\N	\N	\N
543	Memnun	\N	\N	\N
544	oldum.	\N	\N	\N
545	Dün	\N	\N	\N
546	Osman	\N	\N	\N
547	gelmiş.	\N	\N	\N
548	Yağmur	\N	\N	\N
549	yağmış.	\N	\N	\N
550	Kahve	\N	\N	\N
551	bitmiş.	\N	\N	\N
552	Nasıl	\N	\N	\N
553	Yemekler	\N	\N	\N
554	olmuş	\N	\N	\N
555	?　	\N	\N	\N
556	işe	\N	\N	\N
557	gitmemiş.	\N	\N	\N
558	içmişim.	\N	\N	\N
559	çalışmışsın.	\N	\N	\N
560	İyi	\N	\N	\N
561	seçmiş	\N	\N	\N
562	miyim	\N	\N	\N
563	Mustafa	\N	\N	\N
564	arka	\N	\N	\N
565	kapıdan	\N	\N	\N
566	Yoğurt	\N	\N	\N
567	sütten	\N	\N	\N
568	yapılır.	\N	\N	\N
569	Tokyo’dan	\N	\N	\N
570	güzel.	\N	\N	\N
571	Nereden	\N	\N	\N
572	geliyorsunuz	\N	\N	\N
573	(Hangi	\N	\N	\N
574	ülkedensiniz	\N	\N	\N
575	?)	\N	\N	\N
576	İngiltere’den	\N	\N	\N
577	geliyorum.	\N	\N	\N
578	(İngiltere’denim.)	\N	\N	\N
579	Bugün	\N	\N	\N
580	gelecek.	\N	\N	\N
581	Yarın	\N	\N	\N
582	başlayacak.	\N	\N	\N
583	Ağustosta	\N	\N	\N
584	olmayacak.　	\N	\N	\N
585	Kışın	\N	\N	\N
586	yağmur	\N	\N	\N
587	yağar.	\N	\N	\N
588	erken	\N	\N	\N
589	kalkar.	\N	\N	\N
590	Acele	\N	\N	\N
591	şeytan	\N	\N	\N
592	karışır.	\N	\N	\N
593	gelir.	\N	\N	\N
594	O	\N	\N	\N
595	çocuklar	\N	\N	\N
596	konuşur	\N	\N	\N
597	Murat	\N	\N	\N
598	şey	\N	\N	\N
599	yapmaz.	\N	\N	\N
600	Dağ	\N	\N	\N
601	dağa	\N	\N	\N
602	kavuşmaz,	\N	\N	\N
603	insan	\N	\N	\N
604	insana	\N	\N	\N
605	kavuşur.　　　　	\N	\N	\N
606	artık	\N	\N	\N
607	kalkmalı	\N	\N	\N
608	?            	\N	\N	\N
609	gölde	\N	\N	\N
610	balık	\N	\N	\N
611	tutmamalı.	\N	\N	\N
612	çalışmalıyız.	\N	\N	\N
613	Sağlığınıza	\N	\N	\N
614	dikkat	\N	\N	\N
615	etmelisiniz.                                                     	\N	\N	\N
616	Saat	\N	\N	\N
617	istasyonda	\N	\N	\N
618	olmalısın	\N	\N	\N
619	?   	\N	\N	\N
620	Hemen	\N	\N	\N
621	gitmeli	\N	\N	\N
622	miyim?     	\N	\N	\N
623	Yardım	\N	\N	\N
624	edeyim	\N	\N	\N
625	?         	\N	\N	\N
626	Yavaş	\N	\N	\N
627	kalkalım	\N	\N	\N
628	?                    	\N	\N	\N
629	sinemaya	\N	\N	\N
630	gitmeyelim	\N	\N	\N
631	evde	\N	\N	\N
632	kalalım.　　	\N	\N	\N
633	Deftere	\N	\N	\N
634	bu	\N	\N	\N
635	cümleyi	\N	\N	\N
636	yaz.                  	\N	\N	\N
637	yazın.       	\N	\N	\N
638	yağsın.　　	\N	\N	\N
639	buraya	\N	\N	\N
640	gelsin.　　 	\N	\N	\N
641	gelsin	\N	\N	\N
642	Havuzun	\N	\N	\N
643	kenarında	\N	\N	\N
644	oynamasınlar.　　　	\N	\N	\N
645	Raftaki	\N	\N	\N
646	mallar	\N	\N	\N
647	pahalı.                     	\N	\N	\N
648	Ağabeyimin	\N	\N	\N
649	bisikleti	\N	\N	\N
650	yeni,	\N	\N	\N
651	benimki	\N	\N	\N
652	eski.	\N	\N	\N
653	Türkiye’nin	\N	\N	\N
654	başkenti	\N	\N	\N
655	Ankara’dır.               	\N	\N	\N
656	Sigara	\N	\N	\N
657	yasaktır.     	\N	\N	\N
658	Nasılsınız	\N	\N	\N
659	İyisinizdir	\N	\N	\N
660	inşallah.                                  	\N	\N	\N
661	çalışkan.	\N	\N	\N
662	çalışıyor.　	\N	\N	\N
663	çalışkandı.	\N	\N	\N
664	çalışıyordu.　　　	\N	\N	\N
665	seyrediyormuş.      	\N	\N	\N
666	şarkıcı	\N	\N	\N
667	ünlüymüş.                     	\N	\N	\N
668	Bir	\N	\N	\N
669	prenses	\N	\N	\N
670	varmış.                       	\N	\N	\N
671	Yarından	\N	\N	\N
672	itibaren	\N	\N	\N
673	hava	\N	\N	\N
674	sıcaklığı	\N	\N	\N
675	artacakmış.    	\N	\N	\N
676	yaşlı	\N	\N	\N
677	adam	\N	\N	\N
678	parka	\N	\N	\N
679	gelirmiş.　　	\N	\N	\N
680	Bundan	\N	\N	\N
681	istiyorsunuz	\N	\N	\N
682	Dünden	\N	\N	\N
683	beri	\N	\N	\N
684	boğazım	\N	\N	\N
685	ağrıyor.	\N	\N	\N
686	Tatilden	\N	\N	\N
687	var.     	\N	\N	\N
688	Türkiye’ye	\N	\N	\N
689	gitmeden	\N	\N	\N
690	öğrenin.	\N	\N	\N
691	işi	\N	\N	\N
692	bitirdikten	\N	\N	\N
693	yemeğe	\N	\N	\N
694	çıkalım.	\N	\N	\N
695	Sınavdan	\N	\N	\N
696	gittik.        	\N	\N	\N
697	Başka	\N	\N	\N
698	sorunuz	\N	\N	\N
699	?      	\N	\N	\N
700	Önce	\N	\N	\N
701	su	\N	\N	\N
702	kaynatın,	\N	\N	\N
703	sebze	\N	\N	\N
704	koyun.	\N	\N	\N
705	İki	\N	\N	\N
706	yıl	\N	\N	\N
707	Japonya’ya	\N	\N	\N
708	Otuz	\N	\N	\N
709	uçağımız	\N	\N	\N
710	kalkacak. 	\N	\N	\N
711	Zamanında	\N	\N	\N
712	çalışmadı.	\N	\N	\N
713	Onun	\N	\N	\N
714	sınıfta	\N	\N	\N
715	kaldı.	\N	\N	\N
716	para	\N	\N	\N
717	biriktiriyorum.	\N	\N	\N
718	kitabı	\N	\N	\N
719	okuyor. 	\N	\N	\N
720	okunuyor.	\N	\N	\N
721	Jüri	\N	\N	\N
722	Uğur’a	\N	\N	\N
723	ödül	\N	\N	\N
724	verdi.	\N	\N	\N
725	verildi.	\N	\N	\N
726	bayramda	\N	\N	\N
727	yaşlılar	\N	\N	\N
728	ziyaret	\N	\N	\N
729	edilir	\N	\N	\N
730	onların	\N	\N	\N
731	elleri	\N	\N	\N
732	öpülür.	\N	\N	\N
733	Dünkü	\N	\N	\N
734	partide	\N	\N	\N
735	yendi,	\N	\N	\N
736	içildi,	\N	\N	\N
737	eğlenildi.	\N	\N	\N
738	Burada	\N	\N	\N
739	içilir. 	\N	\N	\N
740	Harajuku’ya	\N	\N	\N
741	gidilir	\N	\N	\N
742	park	\N	\N	\N
743	edilmez.	\N	\N	\N
744	girilmez. 	\N	\N	\N
745	konuşabilirim.	\N	\N	\N
746	Buraya	\N	\N	\N
747	oturabilir	\N	\N	\N
748	miyim?	\N	\N	\N
749	Beni	\N	\N	\N
750	her	\N	\N	\N
751	telefonla	\N	\N	\N
752	arayabilirsiniz.	\N	\N	\N
753	yağabilir. 	\N	\N	\N
754	Kapıyı	\N	\N	\N
755	açabilir	\N	\N	\N
756	misiniz	\N	\N	\N
757	gelebilir	\N	\N	\N
758	Ama	\N	\N	\N
759	konuşamıyorum.	\N	\N	\N
760	Bugünkü	\N	\N	\N
761	dersi	\N	\N	\N
762	anlayabildiniz	\N	\N	\N
763	Hayır,	\N	\N	\N
764	anlayamadık.	\N	\N	\N
765	Hangi	\N	\N	\N
766	ülkeye	\N	\N	\N
767	Size	\N	\N	\N
768	söylemek	\N	\N	\N
769	istiyorum. 	\N	\N	\N
770	Ne	\N	\N	\N
771	istersiniz	\N	\N	\N
772	? 	\N	\N	\N
773	Belediyede	\N	\N	\N
774	çalışmaktayım.	\N	\N	\N
775	Otobanlar	\N	\N	\N
776	inşa	\N	\N	\N
777	edilmektedir.	\N	\N	\N
778	çalışmaktaydı. 	\N	\N	\N
779	Altı	\N	\N	\N
780	öğrenmeye	\N	\N	\N
781	başladım.	\N	\N	\N
782	çalışmayı	\N	\N	\N
783	sevmedim.	\N	\N	\N
784	Artık	\N	\N	\N
785	öğrenmekten	\N	\N	\N
786	vazgeçtim.	\N	\N	\N
787	Hatice	\N	\N	\N
788	çarşıya	\N	\N	\N
789	Alışveriş	\N	\N	\N
790	yaptı.	\N	\N	\N
791	gidip	\N	\N	\N
792	alışveriş	\N	\N	\N
793	Çarşıya	\N	\N	\N
794	yaptım. 	\N	\N	\N
795	Telefon	\N	\N	\N
796	edip	\N	\N	\N
797	soralım.  	\N	\N	\N
798	Oturup	\N	\N	\N
799	çay	\N	\N	\N
800	için.	\N	\N	\N
801	yapmadı.	\N	\N	\N
802	Selim	\N	\N	\N
803	gülerek	\N	\N	\N
804	konuşuyor.セリムは笑いながら話している。	\N	\N	\N
805	Çocuk	\N	\N	\N
806	annesini	\N	\N	\N
807	görünce	\N	\N	\N
808	ağladı. 	\N	\N	\N
809	yazıyı	\N	\N	\N
810	okuyunca	\N	\N	\N
811	şaşırırsınız    	\N	\N	\N
812	onu	\N	\N	\N
813	söyleyince	\N	\N	\N
814	güler.	\N	\N	\N
815	Yücel	\N	\N	\N
816	gelince	\N	\N	\N
817	çıkalım. 	\N	\N	\N
818	Enver	\N	\N	\N
819	durmadan	\N	\N	\N
820	çalışıyor.           	\N	\N	\N
821	Yanlışlık	\N	\N	\N
822	yapmadan	\N	\N	\N
823	yabancı	\N	\N	\N
824	dil	\N	\N	\N
825	öğrenemezsiniz.	\N	\N	\N
826	İbrahim	\N	\N	\N
827	geldi.	\N	\N	\N
828	İbrahim’in	\N	\N	\N
829	geldiği　	\N	\N	\N
830	geldiğini	\N	\N	\N
831	duydum.	\N	\N	\N
832	Merhaba	\N	\N	\N
833	Hanım.	\N	\N	\N
834	Bey.	\N	\N	\N
835	Nasılsınız?	\N	\N	\N
836	Siz	\N	\N	\N
837	nasılsınız?	\N	\N	\N
838	A,	\N	\N	\N
839	Pınar,	\N	\N	\N
840	merhaba.	\N	\N	\N
841	Merhaba.	\N	\N	\N
842	Gönderdiğin	\N	\N	\N
843	kitapları	\N	\N	\N
844	aldım	\N	\N	\N
845	sevindim.	\N	\N	\N
846	Kitapların	\N	\N	\N
847	eline	\N	\N	\N
848	geçmesine	\N	\N	\N
849	Çok	\N	\N	\N
850	ederim,	\N	\N	\N
851	sana	\N	\N	\N
852	oldu.	\N	\N	\N
853	Rica	\N	\N	\N
854	ederim、hiç	\N	\N	\N
855	Mehmet,	\N	\N	\N
856	gel	\N	\N	\N
857	balkondan	\N	\N	\N
858	manzarayı	\N	\N	\N
859	göstereyim.	\N	\N	\N
860	Buranın	\N	\N	\N
861	manzarası	\N	\N	\N
862	Evet,	\N	\N	\N
863	güzelmiş.	\N	\N	\N
864	Bak,	\N	\N	\N
865	karşıdaki	\N	\N	\N
866	binayı	\N	\N	\N
867	görüyor	\N	\N	\N
868	musun?	\N	\N	\N
869	bina?	\N	\N	\N
870	Sol	\N	\N	\N
871	tarafında	\N	\N	\N
872	bina.	\N	\N	\N
873	evet.	\N	\N	\N
874	Gördüm.	\N	\N	\N
875	Benim	\N	\N	\N
876	ismim	\N	\N	\N
877	Fehmi.	\N	\N	\N
878	Ankaralıyım.	\N	\N	\N
879	Üçüncü	\N	\N	\N
880	öğrencisiyim.	\N	\N	\N
881	adım	\N	\N	\N
882	Gülsüm.	\N	\N	\N
883	Tanıştığımıza	\N	\N	\N
884	Alo,	\N	\N	\N
885	Emine?	\N	\N	\N
886	Efendim	\N	\N	\N
887	Cemil.	\N	\N	\N
888	Şu	\N	\N	\N
889	anda	\N	\N	\N
890	misin?	\N	\N	\N
891	müsaidim.	\N	\N	\N
892	beni	\N	\N	\N
893	aramadın?	\N	\N	\N
894	Bütün	\N	\N	\N
895	senden	\N	\N	\N
896	bekledim.	\N	\N	\N
897	onun	\N	\N	\N
898	aradım.	\N	\N	\N
899	arayamadığım	\N	\N	\N
900	özür	\N	\N	\N
901	dilerim.	\N	\N	\N
902	Kusura	\N	\N	\N
903	bakma.	\N	\N	\N
904	Peki,	\N	\N	\N
905	affettim.	\N	\N	\N
906	olmasın!	\N	\N	\N
907	Doğum	\N	\N	\N
908	günün	\N	\N	\N
909	olsun	\N	\N	\N
910	Aslı!	\N	\N	\N
911	ederim	\N	\N	\N
912	Bülent.	\N	\N	\N
913	senin	\N	\N	\N
914	doğum	\N	\N	\N
915	günü	\N	\N	\N
916	hediyen!	\N	\N	\N
917	Buyur.	\N	\N	\N
918	Ay,	\N	\N	\N
919	gereği	\N	\N	\N
920	yoktu.	\N	\N	\N
921	Aaa,	\N	\N	\N
922	sevdiğim	\N	\N	\N
923	çikolata.	\N	\N	\N
924	teşekkürler.	\N	\N	\N
925	Nasıl,	\N	\N	\N
926	hediyeni	\N	\N	\N
927	beğendin	\N	\N	\N
928	beğendim.	\N	\N	\N
929	Oldukça	\N	\N	\N
930	oldu,	\N	\N	\N
931	yoruldum.	\N	\N	\N
932	geldik.	\N	\N	\N
933	taksiye	\N	\N	\N
934	bineceğim.	\N	\N	\N
935	evim	\N	\N	\N
936	yüzden	\N	\N	\N
937	yürüyeceğim.	\N	\N	\N
938	Anladım.	\N	\N	\N
939	Hoşça	\N	\N	\N
940	kalın.	\N	\N	\N
941	geldiniz	\N	\N	\N
942	efendim.	\N	\N	\N
943	Büyük	\N	\N	\N
944	arıyorum.	\N	\N	\N
945	Kaç	\N	\N	\N
946	olsun?	\N	\N	\N
947	Yüz	\N	\N	\N
948	yirmi	\N	\N	\N
949	yaprak.	\N	\N	\N
950	var.	\N	\N	\N
951	Buyurun.	\N	\N	\N
952	acaba?	\N	\N	\N
953	Dört	\N	\N	\N
954	milyon.	\N	\N	\N
955	Oo,	\N	\N	\N
956	pahalıymış.	\N	\N	\N
957	Daha	\N	\N	\N
958	ucuzu	\N	\N	\N
959	mu?	\N	\N	\N
960	Var,	\N	\N	\N
961	fiyatı	\N	\N	\N
962	lira.	\N	\N	\N
963	Olsun,	\N	\N	\N
964	olanını	\N	\N	\N
965	alayım.	\N	\N	\N
966	Teşekkür	\N	\N	\N
967	Hayırlı	\N	\N	\N
968	işler.	\N	\N	\N
969	Emine,	\N	\N	\N
970	gideceğini	\N	\N	\N
971	gidiyorum.	\N	\N	\N
972	gittin	\N	\N	\N
973	geçen	\N	\N	\N
974	sene	\N	\N	\N
975	gittim.	\N	\N	\N
976	eğlenceliydi.	\N	\N	\N
977	Öyle	\N	\N	\N
978	bana	\N	\N	\N
979	tavsiyen	\N	\N	\N
980	Yanında	\N	\N	\N
981	baş	\N	\N	\N
982	örtüsü	\N	\N	\N
983	götür.	\N	\N	\N
984	Ayşe.	\N	\N	\N
985	planın	\N	\N	\N
986	Evet.	\N	\N	\N
987	Sabah	\N	\N	\N
988	Beşiktaş’a	\N	\N	\N
989	gitmeyi	\N	\N	\N
990	düşünüyorum.	\N	\N	\N
991	Öğleden	\N	\N	\N
992	randevum	\N	\N	\N
993	yok.	\N	\N	\N
994	Neden?	\N	\N	\N
995	Rıza?	\N	\N	\N
996	Alo?	\N	\N	\N
997	Buyur	\N	\N	\N
998	Neşe.	\N	\N	\N
999	Rıza,	\N	\N	\N
1000	buluşacağımız	\N	\N	\N
1001	yere	\N	\N	\N
1002	geldim	\N	\N	\N
1003	yoksun.	\N	\N	\N
1004	Özür	\N	\N	\N
1005	dilerim	\N	\N	\N
1006	Neşe,	\N	\N	\N
1007	yoldayım.	\N	\N	\N
1008	Biraz	\N	\N	\N
1009	kalacağım.	\N	\N	\N
1010	kalacaksın?	\N	\N	\N
1011	Fazla	\N	\N	\N
1012	değil,	\N	\N	\N
1013	beş	\N	\N	\N
1014	Tamam,	\N	\N	\N
1015	bekliyorum.	\N	\N	\N
1016	Osman.	\N	\N	\N
1017	Nur.	\N	\N	\N
1018	haber?	\N	\N	\N
1019	İyilik.	\N	\N	\N
1020	akşamki	\N	\N	\N
1021	partiye	\N	\N	\N
1022	geliyor	\N	\N	\N
1023	partisi?	\N	\N	\N
1024	haberim	\N	\N	\N
1025	partisi.	\N	\N	\N
1026	gelsene.	\N	\N	\N
1027	Olur,	\N	\N	\N
1028	geleyim.	\N	\N	\N
1029	Parti	\N	\N	\N
1030	başlıyor?	\N	\N	\N
1031	almamız	\N	\N	\N
1032	lazım.	\N	\N	\N
1033	5’te	\N	\N	\N
1034	buluşalım.	\N	\N	\N
1035	Yani	\N	\N	\N
1036	sonra.	\N	\N	\N
1037	Yemek	\N	\N	\N
1038	masayı	\N	\N	\N
1039	hazırlayayım	\N	\N	\N
1040	Misafirler	\N	\N	\N
1041	üzeredir.	\N	\N	\N
1042	Masaya	\N	\N	\N
1043	lazım?	\N	\N	\N
1044	Toplam	\N	\N	\N
1045	Pardon,	\N	\N	\N
1046	olacak.	\N	\N	\N
1047	Altay,	\N	\N	\N
1048	yardım	\N	\N	\N
1049	edebilir	\N	\N	\N
1050	Tabii.	\N	\N	\N
1051	Akşam	\N	\N	\N
1052	yemeği	\N	\N	\N
1053	hazırlayalım.	\N	\N	\N
1054	tabakları	\N	\N	\N
1055	getireyim,	\N	\N	\N
1056	tabaklara	\N	\N	\N
1057	doldur,	\N	\N	\N
1058	Tamam.	\N	\N	\N
1059	doldurayım?	\N	\N	\N
1060	Çorbayı	\N	\N	\N
1061	doldur.	\N	\N	\N
1062	Pilavı	\N	\N	\N
1063	ise	\N	\N	\N
1064	bol	\N	\N	\N
1065	koy.	\N	\N	\N
1066	Peki.	\N	\N	\N
1067	bulduk	\N	\N	\N
1068	Öz	\N	\N	\N
1069	geçmişinizi	\N	\N	\N
1070	okudum.	\N	\N	\N
1071	bildiğiniz	\N	\N	\N
1072	yazıyor.	\N	\N	\N
1073	derecede	\N	\N	\N
1074	biliyorsunuz?	\N	\N	\N
1075	biliyorum	\N	\N	\N
1076	Fransızcanız	\N	\N	\N
1077	seviyededir?	\N	\N	\N
1078	Orta	\N	\N	\N
1079	seviyededir.	\N	\N	\N
1080	yetenekleriniz	\N	\N	\N
1081	var?	\N	\N	\N
1082	Bilgisayar	\N	\N	\N
1083	kullanabiliyorum.	\N	\N	\N
1084	Ayrıca	\N	\N	\N
1085	biliyorum.	\N	\N	\N
1086	İsmail	\N	\N	\N
1087	Hoca’yı	\N	\N	\N
1088	okulda	\N	\N	\N
1089	okulda.	\N	\N	\N
1090	gördüm.	\N	\N	\N
1091	nerede,	\N	\N	\N
1092	musunuz?	\N	\N	\N
1093	Okulun	\N	\N	\N
1094	salonunda.	\N	\N	\N
1095	Toplantı	\N	\N	\N
1096	salonu	\N	\N	\N
1097	nerede?	\N	\N	\N
1098	Ana	\N	\N	\N
1099	binanın	\N	\N	\N
1100	katında.	\N	\N	\N
1101	Yeni	\N	\N	\N
1102	elemanı	\N	\N	\N
1103	gördün	\N	\N	\N
1104	mü?	\N	\N	\N
1105	İşe	\N	\N	\N
1106	Onu	\N	\N	\N
1107	biri?	\N	\N	\N
1108	Yirmi	\N	\N	\N
1109	beş－otuz	\N	\N	\N
1110	yaşlarında.	\N	\N	\N
1111	Boyu	\N	\N	\N
1112	kadar?	\N	\N	\N
1113	seksen	\N	\N	\N
1114	kadar.	\N	\N	\N
1115	Saçı	\N	\N	\N
1116	renk?	\N	\N	\N
1117	Siyah.	\N	\N	\N
1118	Kısa,	\N	\N	\N
1119	saçlı.	\N	\N	\N
1120	birisini	\N	\N	\N
1121	görmedim.	\N	\N	\N
1122	Bey,	\N	\N	\N
1123	günler.	\N	\N	\N
1124	yapacağımız	\N	\N	\N
1125	toplantıyı	\N	\N	\N
1126	yarına	\N	\N	\N
1127	erteledik.	\N	\N	\N
1128	dersiniz?	\N	\N	\N
1129	sizin	\N	\N	\N
1130	Bana	\N	\N	\N
1131	uygun.	\N	\N	\N
1132	başlayacak?	\N	\N	\N
1133	dörtte	\N	\N	\N
1134	sorarsanız	\N	\N	\N
1135	beşte	\N	\N	\N
1136	iyisidir.	\N	\N	\N
1137	Çünkü	\N	\N	\N
1138	herkesin	\N	\N	\N
1139	bitiyor.	\N	\N	\N
1140	Burcu.	\N	\N	\N
1141	güzeldi,	\N	\N	\N
1142	eğlendim.	\N	\N	\N
1143	Sabaha	\N	\N	\N
1144	içtim.	\N	\N	\N
1145	hepimiz	\N	\N	\N
1146	olduk.	\N	\N	\N
1147	rakı	\N	\N	\N
1148	içmeyi	\N	\N	\N
1149	seviyorsun.	\N	\N	\N
1150	severim.	\N	\N	\N
1151	şarabı	\N	\N	\N
1152	dahaki	\N	\N	\N
1153	sefere	\N	\N	\N
1154	içelim,	\N	\N	\N
1155	Tamam!	\N	\N	\N
1156	Sevim,	\N	\N	\N
1157	seyrederken	\N	\N	\N
1158	yapmayı	\N	\N	\N
1159	seviyorsun?	\N	\N	\N
1160	Patlamış	\N	\N	\N
1161	mısır	\N	\N	\N
1162	yemeyi	\N	\N	\N
1163	seviyorum.	\N	\N	\N
1164	Dondurma	\N	\N	\N
1165	yemeye	\N	\N	\N
1166	bayılıyorum.	\N	\N	\N
1167	hoşuma	\N	\N	\N
1168	gidiyor.	\N	\N	\N
1169	günler	\N	\N	\N
1170	efendim,	\N	\N	\N
1171	yardımcı	\N	\N	\N
1172	olabilirim?	\N	\N	\N
1173	Firmanızdan	\N	\N	\N
1174	aldım.	\N	\N	\N
1175	Ancak	\N	\N	\N
1176	çalışmıyor.	\N	\N	\N
1177	gerekir	\N	\N	\N
1178	Önce,	\N	\N	\N
1179	olup	\N	\N	\N
1180	olmadığını	\N	\N	\N
1181	ediniz.	\N	\N	\N
1182	sonra,	\N	\N	\N
1183	bilgisayarınızın	\N	\N	\N
1184	fişlerinin	\N	\N	\N
1185	prize	\N	\N	\N
1186	ediniz	\N	\N	\N
1187	lütfen.	\N	\N	\N
1188	Son	\N	\N	\N
1189	olarak,	\N	\N	\N
1190	“başlat”	\N	\N	\N
1191	tuşuna	\N	\N	\N
1192	basınız.	\N	\N	\N
1193	bastım	\N	\N	\N
1194	Tamir	\N	\N	\N
1195	size	\N	\N	\N
1196	göndereceğim.	\N	\N	\N
1197	Şebnem,	\N	\N	\N
1198	Görmeyeli	\N	\N	\N
1199	yapıyorsun?	\N	\N	\N
1200	çalışıyorum.	\N	\N	\N
1201	Sınavlara	\N	\N	\N
1202	hazırlanıyorum.	\N	\N	\N
1203	yapmıyorum,	\N	\N	\N
1204	boşum.	\N	\N	\N
1205	gidelim	\N	\N	\N
1206	Şenay,	\N	\N	\N
1207	duydun	\N	\N	\N
1208	İstanbul’da	\N	\N	\N
1209	olacakmış.	\N	\N	\N
1210	uzmanlar	\N	\N	\N
1211	televizyonda	\N	\N	\N
1212	uyarıyorlar.	\N	\N	\N
1213	Deprem	\N	\N	\N
1214	olursa	\N	\N	\N
1215	paniğe	\N	\N	\N
1216	kapılmamalısın.	\N	\N	\N
1217	yakınındaki	\N	\N	\N
1218	masanın	\N	\N	\N
1219	altına	\N	\N	\N
1220	girmelisin.	\N	\N	\N
1221	sonra?	\N	\N	\N
1222	bittikten	\N	\N	\N
1223	çıkmalısın.	\N	\N	\N
1224	hoş	\N	\N	\N
1225	geleli	\N	\N	\N
1226	oldu?	\N	\N	\N
1227	Yaklaşık	\N	\N	\N
1228	sayılır.	\N	\N	\N
1229	Japon	\N	\N	\N
1230	yemeklerine	\N	\N	\N
1231	alıştın	\N	\N	\N
1232	alıştım.	\N	\N	\N
1233	En	\N	\N	\N
1234	Tempura	\N	\N	\N
1235	yemeğini	\N	\N	\N
1236	Türk	\N	\N	\N
1237	yemekleri	\N	\N	\N
1238	yemeklerinden	\N	\N	\N
1239	lezzetli.	\N	\N	\N
1240	Günaydın	\N	\N	\N
1241	Murat.	\N	\N	\N
1242	Günaydın.	\N	\N	\N
1243	Murat,	\N	\N	\N
1244	gidebilirim?	\N	\N	\N
1245	ilerideki	\N	\N	\N
1246	duraktan	\N	\N	\N
1247	otobüse	\N	\N	\N
1248	binip	\N	\N	\N
1249	Taksim’e	\N	\N	\N
1250	gitmen	\N	\N	\N
1251	gerekiyor.	\N	\N	\N
1252	Sonra......	\N	\N	\N
1253	uzakmış.	\N	\N	\N
1254	Oraya	\N	\N	\N
1255	götüreyim	\N	\N	\N
1256	gidemem.	\N	\N	\N
1257	çalışmam	\N	\N	\N
1258	dersi?	\N	\N	\N
1259	Ders,	\N	\N	\N
1260	zamanı	\N	\N	\N
1261	çalışılmaz!	\N	\N	\N
1262	Canan,	\N	\N	\N
1263	isteğim	\N	\N	\N
1264	Tabii	\N	\N	\N
1265	Onur.	\N	\N	\N
1266	Buyur,	\N	\N	\N
1267	seni	\N	\N	\N
1268	dinliyorum.	\N	\N	\N
1269	benim	\N	\N	\N
1270	yerime	\N	\N	\N
1271	çalışır	\N	\N	\N
1272	mısın?	\N	\N	\N
1273	rahatsızım	\N	\N	\N
1274	da.	\N	\N	\N
1275	Elbette.	\N	\N	\N
1276	yat	\N	\N	\N
1277	dinlen.	\N	\N	\N
1278	Japonya’da	\N	\N	\N
1279	trenler	\N	\N	\N
1280	mıdır?	\N	\N	\N
1281	hızlıdır.	\N	\N	\N
1282	Mesela,	\N	\N	\N
1283	Tokyo	\N	\N	\N
1284	Osaka	\N	\N	\N
1285	arası	\N	\N	\N
1286	550	\N	\N	\N
1287	km’dir	\N	\N	\N
1288	2,5	\N	\N	\N
1289	sürer.	\N	\N	\N
1290	Gerçekten	\N	\N	\N
1291	hızlıymış.	\N	\N	\N
1292	Maalesef	\N	\N	\N
1293	Türkiye’deki	\N	\N	\N
1294	yavaştır.	\N	\N	\N
1295	Örneğin,	\N	\N	\N
1296	otobüsten	\N	\N	\N
1297	gider.	\N	\N	\N
1298	İnanmıyorum!	\N	\N	\N
1299	Arzu	\N	\N	\N
1300	Hanım,	\N	\N	\N
1301	haftaki	\N	\N	\N
1302	yapalım?	\N	\N	\N
1303	Salı	\N	\N	\N
1304	toplantım	\N	\N	\N
1305	Öyleyse	\N	\N	\N
1306	olsun.	\N	\N	\N
1307	Maalesef,	\N	\N	\N
1308	buluşmam	\N	\N	\N
1309	nasıl?	\N	\N	\N
1310	Perşembe	\N	\N	\N
1311	meşgulüm	\N	\N	\N
1312	öğleden	\N	\N	\N
1313	zamanım	\N	\N	\N
1314	Olur.	\N	\N	\N
1315	"Japon	\N	\N	\N
1316	mucizesi"ni	\N	\N	\N
1317	anlatacağım.	\N	\N	\N
1318	Affedersin.	\N	\N	\N
1319	Özgür.	\N	\N	\N
1320	Prezantasyona	\N	\N	\N
1321	başlamadan	\N	\N	\N
1322	dışarıya	\N	\N	\N
1323	çıkabilir	\N	\N	\N
1324	oldu	\N	\N	\N
1325	Özgür?	\N	\N	\N
1326	Rahatsız	\N	\N	\N
1327	mısın	\N	\N	\N
1328	yoksa?	\N	\N	\N
1329	Hayır.	\N	\N	\N
1330	Müsaade	\N	\N	\N
1331	edersen,	\N	\N	\N
1332	istiyorum.	\N	\N	\N
1333	Tabii,	\N	\N	\N
1334	çıkabilirsin.	\N	\N	\N
1335	Meici	\N	\N	\N
1336	Dönemini	\N	\N	\N
1337	anlatacak?	\N	\N	\N
1338	Dönemi	\N	\N	\N
1339	tarihinde	\N	\N	\N
1340	önemli.	\N	\N	\N
1341	hazırlanman	\N	\N	\N
1342	gerekir.	\N	\N	\N
1343	Kaynak	\N	\N	\N
1344	getirmem	\N	\N	\N
1345	Getirmen	\N	\N	\N
1346	anladım.	\N	\N	\N
1347	Affedersiniz	\N	\N	\N
1348	hanımefendi.	\N	\N	\N
1349	odada	\N	\N	\N
1350	yasaktır.	\N	\N	\N
1351	içmeyiniz	\N	\N	\N
1352	Levhayı	\N	\N	\N
1353	fark	\N	\N	\N
1354	etmemişim.	\N	\N	\N
1355	Aylin,	\N	\N	\N
1356	kalemimi	\N	\N	\N
1357	kaybettim.	\N	\N	\N
1358	Gördün	\N	\N	\N
1359	Hayır	\N	\N	\N
1360	kalemdi?	\N	\N	\N
1361	Kırmızı	\N	\N	\N
1362	renk.	\N	\N	\N
1363	kalemin	\N	\N	\N
1364	kalemim	\N	\N	\N
1365	kısa.	\N	\N	\N
1366	Ah,	\N	\N	\N
1367	gördüm!	\N	\N	\N
1368	İşte	\N	\N	\N
1369	burada!	\N	\N	\N
1370	Abi,	\N	\N	\N
1371	gelir	\N	\N	\N
1372	Dilek.	\N	\N	\N
1373	odama	\N	\N	\N
1374	girdin	\N	\N	\N
1375	girdim.	\N	\N	\N
1376	bilgisayarımı	\N	\N	\N
1377	kullandın?	\N	\N	\N
1378	kullandım.	\N	\N	\N
1379	kullanma	\N	\N	\N
1380	bilgisayarım	\N	\N	\N
1381	bozuldu.	\N	\N	\N
1382	Ayça	\N	\N	\N
1383	günaydın.	\N	\N	\N
1384	mesaiye	\N	\N	\N
1385	kalmanız	\N	\N	\N
1386	gerekiyormuş,	\N	\N	\N
1387	kalmıyorum.	\N	\N	\N
1388	Sevinç	\N	\N	\N
1389	Hanım	\N	\N	\N
1390	kalıyor.	\N	\N	\N
1391	Anladım,	\N	\N	\N
1392	dışına	\N	\N	\N
1393	okumaya	\N	\N	\N
1394	gidiyormuş.	\N	\N	\N
1395	Nereye	\N	\N	\N
1396	gidiyormuş?	\N	\N	\N
1397	Fransa’ya	\N	\N	\N
1398	gidecekmiş.	\N	\N	\N
1399	veda	\N	\N	\N
1400	partisi	\N	\N	\N
1401	vermeyi	\N	\N	\N
1402	düşünüyoruz.	\N	\N	\N
1403	zaman?	\N	\N	\N
1404	Ayın	\N	\N	\N
1405	25’inde.	\N	\N	\N
1406	gelirim.	\N	\N	\N
1407	olacak?	\N	\N	\N
1408	evimde	\N	\N	\N
1409	İstersen	\N	\N	\N
1410	adresimi	\N	\N	\N
1411	yazıp	\N	\N	\N
1412	vereyim.	\N	\N	\N
1413	Lütfen.	\N	\N	\N
1414	Doktor	\N	\N	\N
1415	günlerde	\N	\N	\N
1416	göğsüm	\N	\N	\N
1417	Neden	\N	\N	\N
1418	İçki	\N	\N	\N
1419	kullanıyor	\N	\N	\N
1420	haftada	\N	\N	\N
1421	kullanıyorum.	\N	\N	\N
1422	içiyor	\N	\N	\N
1423	günde	\N	\N	\N
1424	içiyorum.	\N	\N	\N
1425	içtiğiniz	\N	\N	\N
1426	göğsünüz	\N	\N	\N
1427	ağrıyor	\N	\N	\N
1428	sanırım.	\N	\N	\N
1429	Sigarayı	\N	\N	\N
1430	bırakmalısınız.	\N	\N	\N
1431	Ayrıca,	\N	\N	\N
1432	yapmaya	\N	\N	\N
1433	başlarsanız	\N	\N	\N
1434	olur.	\N	\N	\N
1435	Geçen	\N	\N	\N
1436	sizden	\N	\N	\N
1437	ettiğimiz	\N	\N	\N
1438	ulaşmadı.	\N	\N	\N
1439	dileriz.	\N	\N	\N
1440	zamanda	\N	\N	\N
1441	elinizde	\N	\N	\N
1442	ayın	\N	\N	\N
1443	15’ine	\N	\N	\N
1444	siparişlerin	\N	\N	\N
1445	ulaşmasını	\N	\N	\N
1446	Tamam	\N	\N	\N
1447	15’inde	\N	\N	\N
1448	benimle	\N	\N	\N
1449	irtibata	\N	\N	\N
1450	geçin.	\N	\N	\N
1451	Rezervasyonunuz	\N	\N	\N
1452	Tek	\N	\N	\N
1453	Yeriniz	\N	\N	\N
1454	Evet	\N	\N	\N
1455	istersiniz?	\N	\N	\N
1456	Mümkünse	\N	\N	\N
1457	katta	\N	\N	\N
1458	lütfen....	\N	\N	\N
1459	istediğiniz	\N	\N	\N
1460	odamız	\N	\N	\N
1461	Buyurun,	\N	\N	\N
1462	sizi	\N	\N	\N
1463	odanıza	\N	\N	\N
1464	götüreyim.	\N	\N	\N
1465	Emek.	\N	\N	\N
1466	Nasılsın?	\N	\N	\N
1467	sağ	\N	\N	\N
1468	ol.	\N	\N	\N
1469	Bu,	\N	\N	\N
1470	arkadaşım	\N	\N	\N
1471	Arzu.	\N	\N	\N
1472	Kendisi	\N	\N	\N
1473	İzmir’den	\N	\N	\N
1474	Arzu,	\N	\N	\N
1475	arkadaşım,	\N	\N	\N
1476	git-	1	G	\N
1477	İngilizce	1	İ	\N
1478	uçak	1	U	\N
1479	yabancı ülke	1	Y	\N
1480	yabancı	1	Y	\N
1481	Fransızca	1	F	\N
1482	otel	1	O	\N
1483	Japonca	1	J	\N
1484	çık-	1	Ç	\N
1485	ülke	1	Ü	\N
1486	görüş-	1	G	\N
1487	tatil	1	T	\N
1488	seyahat	1	S	\N
1489	seyahate çık-	1	S	\N
1490	oyna-	1	O	\N
1491	büyükelçilik	1	B	\N
1492	sev-	0	S	\N
1493	sev-	0	S	\N
1494	çok iyi	1	Ç	\N
1495	koş-	1	K	\N
1496	yavaş	1	Y	\N
1497	kötü	0	K	\N
1498	yürü-	1	Y	\N
1499	yüz-	1	Y	\N
1500	hızlı	1	H	\N
1501	uç-	1	U	\N
1502	spor	1	S	\N
1503	sevme-	1	S	\N
1504	yüzme havuzu	1	Y	\N
1505	otobüs	1	O	\N
1506	bisiklet	1	B	\N
1507	kavşak	1	K	\N
1508	yol	1	Y	\N
1509	havuz	1	H	\N
1511	ırmak	1	I	\N
1512	taksi	1	T	\N
1513	araba	1	A	\N
1514	dön-	0	D	\N
1515	kravat	1	K	\N
1516	gömlek	0	G	\N
1517	şirket	1	Ş	\N
1518	takım elbise	1	T	\N
1519	yap-	1	Y	\N
1520	içine çek-	1	İ	\N
1521	telefon	1	T	\N
1522	iş	1	İ	\N
1523	çalış-	1	Ç	\N
1524	meşgul	1	M	\N
1525	kütüphane	1	K	\N
1526	sözlük	1	S	\N
1527	ödünç al-	0	Ö	\N
1528	gazete	1	G	\N
1529	oku-	1	O	\N
1530	kitap	1	K	\N
1531	kopya	1	K	\N
1533	dergi	1	D	\N
1534	tane	1	T	\N
1535	dana eti	1	D	\N
1536	ucuz	1	U	\N
1537	dükkan	1	D	\N
1538	pahalı	1	P	\N
1539	kaç	1	K	\N
1540	ne kadar	1	N	\N
1541	meyve	1	M	\N
1542	sebze	1	S	\N
1543	balık	1	B	\N
1544	domuz eti	1	D	\N
1545	tavuk	1	T	\N
1546	et	1	E	\N
1547	iste-	1	İ	\N
1548	ver-	1	V	\N
1549	manav	1	M	\N
1550	anahtar	1	A	\N
1551	yemek	1	Y	\N
1552	alışveriş yap-	1	A	\N
1553	çamaşır yıka-	1	Ç	\N
1554	temizle-	1	T	\N
1555	aile	1	A	\N
1556	aile	0	A	\N
1557	bahçe	1	B	\N
1558	çamaşır	1	Ç	\N
1559	ev	1	E	\N
1560	ev	0	E	\N
1561	temizlik	1	T	\N
1562	dön-	1	D	\N
1563	kitaplık	1	K	\N
1564	masa	1	M	\N
1565	sandalye	1	S	\N
1566	oda	1	O	\N
1567	buzdolabı	1	B	\N
1568	yıka-	1	Y	\N
1569	yatak	1	Y	\N
1570	radyo	1	R	\N
1571	kasetçalar	1	K	\N
1572	adı　～	1	A	\N
1573	uyu-	1	U	\N
1574	kalk-	1	K	\N
1575	masa	0	M	\N
1576	televizyon	1	T	\N
1577	polis	1	P	\N
1578	polis	0	P	\N
1579	harita	1	H	\N
1580	yakında	1	Y	\N
1581	burası,burada	1	B	\N
1582	orası,orada	1	O	\N
1583	orası,orada	0	O	\N
1584	neresi,nerede	1	N	\N
1585	karakol	1	K	\N
1586	yakında	0	Y	\N
1587	yanında	1	Y	\N
1588	sor-	1	S	\N
1589	kes-	1	K	\N
1590	kısa	1	K	\N
1591	arka	1	A	\N
1592	ön	1	Ö	\N
1593	sağ	1	S	\N
1594	sol	1	S	\N
1595	uzun	1	U	\N
1596	otur-	1	O	\N
1597	kalk-	0	K	\N
1598	arkadaş	1	A	\N
1599	sınıf	1	S	\N
1600	sınıf	0	S	\N
1601	koridor	1	K	\N
1602	okul	1	O	\N
1603	öğrenci	1	Ö	\N
1604	ders çalış-	1	D	\N
1605	öğrenci	0	Ö	\N
1606	yabancı öğrenci	1	Y	\N
1607	yaz tatili	1	Y	\N
1608	öğretmen	1	Ö	\N
1609	üniversite	1	Ü	\N
1610	defter	1	D	\N
1611	ders	1	D	\N
1612	kompozisyon	1	K	\N
1613	ödev	1	Ö	\N
1614	zor	1	Z	\N
1615	öğret-	1	Ö	\N
1616	sınav	1	S	\N
1617	alıştırma	1	A	\N
1618	kolay	1	K	\N
1619	pratik yap-	1	P	\N
1620	soru	1	S	\N
1621	sorun	1	S	\N
1622	cevap ver-	1	C	\N
1623	ağır-	1	A	\N
1624	diş	1	D	\N
1625	doktor	1	D	\N
1626	hastane	1	H	\N
1627	hastalık	1	H	\N
1628	ilaç	1	İ	\N
1629	öl-	1	Ö	\N
1630	soğuk	1	S	\N
1631	baş	1	B	\N
1632	karın	1	K	\N
1633	derece	1	D	\N
1634	asansör	1	A	\N
1635	bilet	1	B	\N
1636	in-	1	İ	\N
1637	merdiven	1	M	\N
1638	kapat-	1	K	\N
1639	istasyon	1	İ	\N
1640	metro	1	M	\N
1642	aç-	1	A	\N
1643	lavabo	1	L	\N
1644	tuvalet	1	T	\N
1645	tren	1	T	\N
1646	içecek	1	İ	\N
1647	kahve	1	K	\N
1648	kafe	1	K	\N
1649	limon	1	L	\N
1650	süt	1	S	\N
1651	şeker	1	Ş	\N
1652	fincan	1	F	\N
1653	yeşil çay	1	Y	\N
1654	çay	1	Ç	\N
1655	bardak	1	B	\N
1656	koy-	1	K	\N
1657	tatlı	1	T	\N
1658	iç-	1	İ	\N
1659	çubuk	1	Ç	\N
1660	içki	1	İ	\N
1661	güzel	1	G	\N
1662	bıçak	1	B	\N
1663	kaşık	1	K	\N
1664	çatal	1	Ç	\N
1665	peynir	1	P	\N
1666	ye-	1	Y	\N
1667	tatsız, tatsız tuzsuz	1	T	\N
1668	ekmek	1	E	\N
1669	acı	1	A	\N
1670	restoran	1	R	\N
1671	lokanta	1	L	\N
1672	şarap	1	Ş	\N
1673	yemek	0	Y	\N
1674	köri	1	K	\N
1675	para	1	P	\N
1676	banka	1	B	\N
1677	giriş	1	G	\N
1678	bir şey değil	1	B	\N
1679	hayır	1	H	\N
1680	evet	1	E	\N
1681	affedersiniz	1	A	\N
1682	lütfen	1	L	\N
1683	çıkış	1	Ç	\N
1684	var-	1	V	\N
1685	posta kutusu	1	P	\N
1686	kartpostal	1	K	\N
1687	yapıştır-	1	Y	\N
1688	zarf	1	Z	\N
1689	mektup	1	M	\N
1690	postane	1	P	\N
1691	geri ver-	1	G	\N
1692	gönder-	1	G	\N
1693	pul	1	P	\N
1694	paket	1	P	\N
1695	tane	0	T	\N
1697	al-	1	A	\N
1698	şapka	1	Ş	\N
1699	ayakkabı	1	A	\N
1700	alışveriş	1	A	\N
1701	kat	1	K	\N
1702	büyük mağaza	1	B	\N
1703	etek	1	E	\N
1704	palto	1	P	\N
1705	pantolon	1	P	\N
1706	kazak	1	K	\N
1707	…(y)ın	1	I	\N
1708	çanta	1	Ç	\N
1709	sat-	1	S	\N
1710	ceket	1	C	\N
1711	banyo	1	B	\N
1712	bina	1	B	\N
1713	mutfak	1	M	\N
1714	duş	1	D	\N
1715	pencere	1	P	\N
1716	otur-	0	O	\N
1717	park	1	P	\N
1718	kapı	1	K	\N
1719	banyo yap-	1	B	\N
1720	apartman	1	A	\N
1721	antre	\N	A	\N
1722	o	1	O	\N
1723	onlar	1	O	\N
1724	ben	1	B	\N
1725	biz	1	B	\N
1726	kimse	1	K	\N
1727	kim	1	K	\N
1728	kim	0	K	\N
1729	sen	1	S	\N
1730	siz	1	S	\N
1731	bu	1	B	\N
1732	o	0	O	\N
1733	nasıl	1	N	\N
1734	hangi	1	H	\N
1735	nasıl	0	N	\N
1736	böyle	1	B	\N
1737	kendim	1	K	\N
1738	öyle	1	Ö	\N
1739	kalın	1	K	\N
1740	dar	1	D	\N
1741	ince	1	İ	\N
1742	büyük	1	B	\N
1743	kalın	0	K	\N
1744	genç	1	G	\N
1745	geniş	1	G	\N
1746	hafif	1	H	\N
1747	uzak	1	U	\N
1748	ağır	1	A	\N
1749	ince	0	İ	\N
1750	yeni	1	Y	\N
1751	küçük	1	K	\N
1752	yakın	1	Y	\N
1753	eski	1	E	\N
1754	eğlenceli	1	E	\N
1755	coşkulu	1	C	\N
1756	alçak	1	A	\N
1757	iyi	1	İ	\N
1759	zayıf	1	Z	\N
1760	güçlü	1	G	\N
1761	ilginç	1	İ	\N
1762	güzel	0	G	\N
1763	geç	1	G	\N
1764	kötü	1	K	\N
1765	çok	1	Ç	\N
1766	karanlık	1	K	\N
1767	sessiz	1	S	\N
1768	az	1	A	\N
1769	pis	1	P	\N
1770	sıkıcı	1	S	\N
1771	yan	1	Y	\N
1772	iç	1	İ	\N
1773	dış	1	D	\N
1774	doğu	1	D	\N
1775	yükseklik	1	Y	\N
1776	boy	1	B	\N
1777	kuzey	1	K	\N
1778	batı	1	B	\N
1779	alt	1	A	\N
1780	güney	1	G	\N
1781	yukarı	1	Y	\N
1782	ileri	1	İ	\N
1783	geri	1	G	\N
1784	kuzen	1	K	\N
1785	ağabey	1	A	\N
1786	kardeş	1	K	\N
1787	baba anne	1	B	\N
1788	dede	1	D	\N
1789	eş	1	E	\N
1790	anne	1	A	\N
1791	amca	1	A	\N
1792	anne baba, anne babası	1	A	\N
1793	baba	1	B	\N
1794	abla	1	A	\N
1795	kız kardeş	1	K	\N
1796	teyze	1	T	\N
1797	abi	1	A	\N
1798	abla	0	A	\N
1799	baba	0	B	\N
1800	anne	0	A	\N
1801	çorap	1	Ç	\N
1802	gömlek	1	G	\N
1803	soyun-	1	S	\N
1804		\N		\N
1805	giy-	1	G	\N
1806	giy-	0	G	\N
1807	tak-	1	T	\N
1808	mendil	1	M	\N
1809	terlik	1	T	\N
1810	şemsiye	1	Ş	\N
1811	cep	1	C	\N
1812	cüzdan	1	C	\N
1813		\N		\N
1814	elbise	1	E	\N
1815	elbise	0	E	\N
1816	ağız	1	A	\N
1817	kol	1	K	\N
1818	vücut	1	V	\N
1819	yüz	1	Y	\N
1820	bacak	1	B	\N
1821	el	1	E	\N
1822	burun	1	B	\N
1823	göz	1	G	\N
1824	kulak	1	K	\N
1825	ayak	1	A	\N
1826	karın	0	K	\N
1827	tabak	1	T	\N
1828	tereyağı	1	T	\N
1829	kase	1	K	\N
1830	şeker	0	Ş	\N
1831	öğle yemeği	1	Ö	\N
1832	akşam yemeği	1	A	\N
1833	tatlı	0	T	\N
1834	yumurta	1	Y	\N
1835	kahvaltı	1	K	\N
1836	yemek	0	Y	\N
1837	soya sosu	1	S	\N
1838	tuz	1	T	\N
1839	akşam yemeği	0	A	\N
1840	eklemek	1	E	\N
1841	tak-	0	T	\N
1842	fotoğraf makinesi	1	F	\N
1843	soba	1	S	\N
1844	kurşun kalem	1	K	\N
1845	sil-	1	S	\N
1846	gözlük	1	G	\N
1847	teyp	1	T	\N
1848	saat	1	S	\N
1849	bilgisayar	1	B	\N
1850	negatif	1	N	\N
1851	kapı	0	K	\N
1852	kapı	0	K	\N
1853	kalem	1	K	\N
1854	dolma kalem	1	D	\N
1855	tükenmez kalem	1	K	\N
1856	Ağustos	1	A	\N
1857	Nisan	1	N	\N
1858	bu ay	1	B	\N
1859	her ay	1	H	\N
1860	Aralık	1	A	\N
1861	Şubat	1	Ş	\N
1862	Ocak	1	O	\N
1863	Temmuz	1	T	\N
1864	Haziran	1	H	\N
1865	gelecek ay	1	G	\N
1866	Mayıs	1	M	\N
1867	Mart	1	M	\N
1868	geçen ay	1	G	\N
1869	Kasım	1	K	\N
1870	Ekim	1	E	\N
1871	Eylül	1	E	\N
1872	bir ay	1	B	\N
1873	bu hafta	1	B	\N
1874	her hafta	1	H	\N
1875	Pazar 	1	P	\N
1876	Perşembe	1	P	\N
1877	gelecek hafta	1	G	\N
1878	Pazartesi	1	P	\N
1879	Salı	1	S	\N
1880	Çarşamba	1	Ç	\N
1881	Cumartesi	1	C	\N
1883	geçen hafta	1	G	\N
1884	Cuma	1	C	\N
1885	yıl	1	Y	\N
1886	sonbahar	1	S	\N
1887	bu yıl	1	B	\N
1888	her yıl	1	H	\N
1889	yaz	1	Y	\N
1890	kış	1	K	\N
1891	geçen yıl	1	G	\N
1892	gelecek yıl	1	G	\N
1893	ilkbahar	1	İ	\N
1894	bir sonraki yıl	1	B	\N
1895	evvelki yıl	1	E	\N
1896	öğleden sonra	1	Ö	\N
1897	bugün	1	B	\N
1898	yarın	1	Y	\N
1899	saat	0	S	\N
1900	dün	1	D	\N
1901	dün akşam	1	D	\N
1902	öğleden önce	1	Ö	\N
1903	sabah	1	S	\N
1904	öğle	1	Ö	\N
1906	akşam	1	A	\N
1907	öbür gün	1	Ö	\N
1908	evvelki gün	1	E	\N
1909	artık	1	A	\N
1910	-arak/-erek (yürü-yerek)	1	A	\N
1911	hala 	1	H	\N
1912	bütün	1	B	\N
1913	zaman	1	Z	\N
1914	ne zaman	1	N	\N
1915	bazen	1	B	\N
1916	sık sık	1	S	\N
1917	zaman	0	Z	\N
1918	hemen	1	H	\N
1919	kül tablası	1	K	\N
1920	şarkı	1	Ş	\N
1921	söyle-	1	S	\N
1922	sigara	1	S	\N
1923	film	1	F	\N
1924	plak	1	P	\N
1925	gitar	1	G	\N
1926	çalmak	1	Ç	\N
1927	müzik	1	M	\N
1928	resim	1	R	\N
1929	fotoğraf	1	F	\N
1930	sev-	1	S	\N
1931	ses	1	S	\N
1932	açık hava	1	A	\N
1933	sıcak	1	S	\N
1934	hava açık	1	H	\N
1935	serin	1	S	\N
1936	soğuk	0	S	\N
1937	kar	1	K	\N
1938	yağmur yağ-	1	Y	\N
1939	yağmur	1	Y	\N
1940	hava	1	H	\N
1941	ılık	1	I	\N
1942	rüzgar	1	R	\N
1943	bulutlu	1	B	\N
1944	soğuk	0	S	\N
1945	bulutlan-	1	B	\N
1946		\N		\N
1947	söyle-	0	S	\N
1948	yaz-	1	Y	\N
1949	hikaye	1	H	\N
1950	söz	1	S	\N
1951	dil	1	D	\N
1952	sözcük	1	S	\N
1953	konuş-	1	K	\N
1954	metin	1	M	\N
1955	anlat-	1	A	\N
1957		\N		\N
1958		\N		\N
1959	büyük	0	B	\N
1960	kalabalık	1	K	\N
1961	karıkoca	1	K	\N
1962	çocuk	1	Ç	\N
1963	eş	0	E	\N
1964	kadın	1	K	\N
1965	erkek	1	E	\N
1966	insan	1	İ	\N
1967	adam	1	A	\N
1968	kız	1	K	\N
1969	koca	1	K	\N
1971	herkes	1	H	\N
1972	beyaz	1	B	\N
1973	mavi	1	M	\N
1974	kahverengi	1	K	\N
1975	açık	1	A	\N
1976	renk	1	R	\N
1977	koyu	1	K	\N
1978	sarı	1	S	\N
1979	siyah	1	S	\N
1980	kırmızı	1	K	\N
1981	yeşil	1	Y	\N
1982	kullanışlı	1	K	\N
1983	parti	1	P	\N
1984	kağıt	1	K	\N
1985	ol-	1	O	\N
1987	basmak	1	B	\N
1988	başlamak	1	B	\N
1989	tam	1	T	\N
1990	yok	1	Y	\N
1991	düz	1	D	\N
1992	ünlü	1	Ü	\N
1993	iyi	0	İ	\N
1994	o zaman	1	Z	\N
1995	belki	1	B	\N
1996	hadi	1	H	\N
1997	bir sonraki sene	1	B	\N
1998	içeri	1	İ	\N
1999	üst	1	Ü	\N
2000	Çin yazısı	1	Ç	\N
2001	anneanne	1	A	\N
2002	dayı	1	D	\N
2003	öğren-	1	Ö	0
2004	o yüzden	1	Y	0
1510	yürüyüş	0	Y	\N
1532	kopya çek-	0	K	\N
1641	bin-	0	B	\N
1696	ödünç ver-	0	Ö	\N
1758	ışıklı	0	A	\N
1882	haftalık	0	H	\N
1905	gece	0	G	\N
1956	anlam	0	A	\N
1970	insan	0	İ	\N
1986	kapat-	0	K	\N
398	defa	\N	\N	\N
1	merhaba	\N	\N	\N
2	Nilgün	\N	\N	\N
3	Mehmet	\N	\N	\N
4	bey	\N	\N	\N
5	nasıl＋sınız	\N	\N	\N
6	iyi＋y＋im	\N	\N	\N
7	teşekkür	\N	\N	\N
8	etmek＋im	\N	\N	\N
9	siz	\N	\N	\N
10	ben	\N	\N	\N
11	de	\N	\N	\N
12	Pınar	\N	\N	\N
13	göndermek＋dik＋in	\N	\N	\N
14	kitap＋lar＋ı	\N	\N	\N
15	almak＋dı＋m	\N	\N	\N
16	ve	\N	\N	\N
17	çok	\N	\N	\N
18	sevinmek＋di＋m	\N	\N	\N
19	el	\N	\N	\N
20	geçmek＋si＋n＋e	\N	\N	\N
21	sen	\N	\N	\N
22	zahmet	\N	\N	\N
23	olmak	\N	\N	\N
24	rica	\N	\N	\N
25	hiç	\N	\N	\N
26	önemli	\N	\N	\N
27	değil	\N	\N	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: tr
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: tr
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

