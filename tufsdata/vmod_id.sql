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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO id;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO id;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO id;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: id
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


ALTER TABLE public.t_instance OWNER TO id;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO id;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO id;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: id
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


ALTER TABLE public.t_usage_classified_rel OWNER TO id;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: id
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


ALTER TABLE public.t_usage_inst_rel OWNER TO id;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO id;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO id;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: id
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO id;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: id
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


ALTER TABLE public.t_word_inst_rel OWNER TO id;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: id
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO id;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: id
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO id;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: id
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: id
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
15	O
16	P
17	Q
18	R
19	S
20	T
21	U
22	V
23	W
24	X
25	Y
26	Z
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
13	Ya, ada apa?	はい，何でしょうか。	状況についてたずねる		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
14	Saya ingin mengambil daftar nilai semester ini.	今学期の成績表をいただきたいんですが。	依頼する		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
15	Nama saya Rini Puspita.	私の名前はリニ・プスピタです。	自己紹介する		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
16	Berapa nomor mahasiswa Anda dan jurusan apa?	学籍番号は？そして何学科ですか？	数字についてたずねる		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
17	Nomor mahasiswa saya 191297.	私の学籍番号は191297です。	機能		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
18	Jurusan Bahasa Indonesia.	インドネシア語学科です。	機能		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
19	Tunggu sebentar, ya.	ちょっと待ってください。	依頼する		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
20	Ya, Pak.	はい。	機能		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
21	Ini daftar nilai Anda.	これがあなたの成績表です。	人にものをあげる		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
22	Terima kasih.	ありがとうございます。	感謝する		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
23	Sama-sama.	どういたしまして。	機能		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
24	Permisi.	すみません。	注意をひく		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
25	Ada apa, Mbak?	なんでしょうか。	機能		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
26	Tolong ambilkan baju yang digantung di situ.	あそこに掛けてある服を取ってください。	依頼する		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
27	Baju yang mana, Mbak?	どちらの服ですか？	機能		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
28	Yang merah itu.	あの赤いのです。	機能		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
29	Tunggu sebentar, ya, Mbak.	少しお待ちください。	指示する		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
30	Boleh dicoba dulu?	ちょっと試着してみて良いですか？	許可を求める		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
31	Silakan.	どうぞ。	許可を与える		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
32	Di mana kamar pasnya?	試着室はどこですか？	場所についてたずねる		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
33	Ada di pojok sana.	あちらのかどにあります。	機能		\N	dmod	id03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
34	Selamat siang, Bu.	こんにちは，先生。	挨拶する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
35	Selamat siang.	こんにちは。	挨拶する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
36	Perkenalkan, nama saya Ani.	はじめまして，私の名前はアニです。	自己紹介する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
37	Saya dari Jakarta.	私はジャカルタから来ました。	自己紹介する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
38	Senang bisa berkenalan dengan Anda.	どうぞよろしく。	自己紹介する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	1
39	Tanya, Bu, Jakartanya di mana?	あの，ジャカルタのどちらですか？	場所についてたずねる		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
40	Kebayoran Baru.	クバヨラン・バルです。	機能		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
41	Apa ada pertanyaan yang lain?	他に質問はありますか？	状況についてたずねる		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
42	Kalau tidak ada, tolong perkenalkan diri.	なければ，自己紹介をして下さい。	依頼する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
43	Mulai dari mahasiswa paling depan.	一番前の学生から始めます。	機能		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	1
44	Selamat siang, nama saya Joko.	こんにちは，私の名前はジョコです。	自己紹介する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
45	Asal Surabaya.	スラバヤ出身です。	挨拶する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
46	Senang berkenalan dengan Anda.	どうぞよろしくお願いします。	挨拶する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
47	Berapa umurnya, dan apa hobinya, Joko?	ジョコさんは何歳ですか？趣味は何ですか？	数字についてたずねる		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
48	Bulan Oktober ini saya dua puluh tahun.	私は，今年の10月で20歳です。	自己紹介する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
49	Hobi saya membaca.	趣味は読書です。	自己紹介する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
50	Terima kasih, Joko.	ジョコさん，ありがとうございました。	感謝する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
51	Mahasiswa berikutnya, silakan!	次の学生，どうぞ。	依頼する		\N	dmod	id04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
52	Permisi, Bu.	先生，失礼します。	注意をひく		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
53	Ya, silakan.	はい，どうぞ。	機能		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
54	Ada apa?	どうしたの？	状況についてたずねる		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
55	Saya akan menyerahkan tugas minggu yang lalu.	先週の課題を提出いたします。	人にものをあげる		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
56	Mengapa terlambat?	どうして遅れたの？	状況についてたずねる		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
57	Saya minta maaf, Bu, karena minggu yang lalu saya sakit.	申し訳ありません。先週は病気だったんです。	謝る		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
58	Ada surat keterangan dari dokter?	医者の診断書はありますか？	状況についてたずねる		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
59	Ada, Bu, ini suratnya.	あります。これです。	人にものをあげる		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
60	Hmmm, baiklah.	う～ん，わかりました。	機能		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
61	Sekali lagi, Bu, saya minta maaf karena saya terlambat menyerahkan tugas.	課題を提出するのが遅くなってしまったこと，改めてお詫びします。	謝る		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
62	Tidak apa-apa.	大丈夫ですよ。	機能		\N	dmod	id05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
63	Apa kabar, Joko?	ジョコ，元気？	挨拶する		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
64	Baik.	元気だよ。	機能		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
65	Kalau Rini?	リニは？	機能		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
66	Baik juga.	私も元気よ。	機能		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
67	Eh, sudah makan siang?	そうだ，もうお昼ごはんを食べた？	状況についてたずねる		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
69	Ini, saya membawa kue, lho!	これ，お菓子を持ってきたの。	人にものをあげる		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
70	Silakan dimakan!	どうぞ食べて。	人にものをあげる		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
71	Kue apa ini?	何っていうお菓子，これ？	機能		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
72	Ini namanya kue onde-onde.	これは，オンデオンデっていうの。	機能		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
73	Enak sekali.	すごくおいしいよ。	意見を述べる		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
74	Terima kasih.	ありがとう。	感謝する		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
75	Syukurlah kalau suka.	良かった，気に入ってくれたなら。	意見を述べる		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
76	Rini pandai membuat kue, ya!	リニはお菓子を作るのがじょうずだね。	意見を述べる		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
77	Eehh... Iwan!	あ～，イワンさん。	注意をひく		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
78	Sedang apa?	何をしているの？	状況についてたずねる		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
79	Selamat sore, Bu.	先生，こんにちは。	挨拶する		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
80	Selamat sore.	こんにちは。	機能		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
81	Masih ada kuliah?	まだ授業があるの？	状況についてたずねる		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
82	Tidak ada, Bu.	いいえ，ありません。	機能		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
83	Saya baru saja selesai latihan gamelan.	今，ガムランの練習が終わったところです。	予定を述べる		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
84	Iwan ikut unit gamelan, ya?	ガムランのサークルに入っているの？	状況についてたずねる		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
85	Ya, tapi saya baru belajar, Bu.	はい，でも，まだ習いたてです。	機能		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
86	Gamelan itu sulit?	ガムランって難しいの。	特徴についてたずねる		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
87	Tidak terlalu sulit.	そんなに難しくないです。	意見を述べる		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
88	Maaf, Bu, saya ada janji dengan teman...	すみません，友達と約束があるので…。	さよならを言う		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
90	Mari, Bu.	それでは先生。	さよならを言う		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
91	Permisi, saya mencari buku Linguistik Indonesia.	すみません，『インドネシア言語学』という本を探しているんですが。	依頼する		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
92	Apa nama penerbitnya?	出版社の名前は何ですか？	特徴についてたずねる		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
93	PT Gramedia Jakarta.	グラメディア・ジャカルタです。	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
94	Tunggu sebentar, ya.	少々お待ちください。	依頼する		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
95	Buku ini?	こちらの本ですか？	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
96	Ya, betul.	はい，そうです。	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
97	Berapa harganya?	値段はいくらですか？	金額についてたずねる		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
98	Buku ini harganya 25,000 rupiah.	こちらの本は25,000ルピアです。	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
99	Tidak ada diskon?	割引はありませんか？	許可を求める		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
100	Maaf, sekarang tidak ada diskon.	すみません，今は割引はないんです。	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
101	Oh, ya.	そうですか。	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
102	Kalau begitu, saya beli buku ini.	じゃあ，この本を買います。	希望を述べる		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
103	Baik.	かしこまりました。	機能		\N	dmod	id08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
104	Hai, Tini.	やあ，ティ二。	挨拶する		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
105	Eh, Roni.	あ，ロニ。	機能		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
106	Pernah mengambil kuliah sastra Indonesia?	インドネシア文学の授業を取ったことがある？	経験についてたずねる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
107	Pernah.	あるよ。	機能		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
108	Ujiannya sulit?	試験は難しい？	程度についてたずねる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
109	Tidak sulit, tetapi harus membaca banyak karya sastra.	難しくないけれど，たくさんの文学作品を読まなければならないんだ。	機能		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
110	Misalnya, puisi W. S. Rendra atau novel karya Pramoediya.	たとえば，レンドラの詩とかプラムディヤの小説とかね。	例をあげる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
112	Wah, kelihatannya menarik juga, ya.	なんだか面白そうね。	意見を述べる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
113	Omong-omong, banyak mahasiswa yang mengambil kuliah itu?	ところで，あの授業を取っている学生って多いの？	程度についてたずねる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
114	Mmm..., lumayan banyak.	う～ん，まあまあ多いよ。	機能		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
115	Kalau begitu, saya juga akan mengambil semester berikut.	それじゃ，来学期に私も取ろう。	予定を述べる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
116	Ya, ambil saja, tetapi setiap minggu ada PR, lho!	うん，そうしなよ。だけど，毎週宿題があるよ。	意見を述べる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
117	Oh, ya.	そうなんだ。	機能		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
118	Tidak apa-apa.	平気よ。	意見を述べる		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
119	Minggu depan mulai libur panjang, ya?	来週から長期休暇が始まるね。	機能		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
120	Ya, kita akan libur kira-kira dua bulan.	そうだね，２ヵ月ぐらい休みだね。	機能		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
121	Bagaimana rencana liburannya?	休みの予定はどう？	状況についてたずねる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
122	Saya punya rencana pergi ke Sumatera Utara.	僕は北スマトラに行く予定。	予定を述べる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
123	Oh, ya!	そう。	機能		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
124	Ada apa di sana?	そこには何があるの？	場所についてたずねる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
125	Saya ingin melihat Danau Toba.	トバ湖を見たいんだ。	意見を述べる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
126	Bagaimana dengan rencana Ria?	リアの予定は？	状況についてたずねる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
127	Saya akan pergi ke Lombok.	私はロンボックに行くわ。	予定を述べる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
128	Untuk berenang di pantai?	ビーチで泳ぐため？	機能		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
129	Bukan, saya akan mengunjungi nenek saya.	いいえ。祖母を訪問するの。	理由を述べる		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
130	Oh, begitu.	ああそう。	機能		\N	dmod	id10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
131	Ria sudah mengerjakan laporan Linguistik?	もう言語学のレポートやった？	状況についてたずねる		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
132	Ya, tapi belum selesai.	うん，でもまだ終わってない。	機能		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
133	Iwan sudah mengerjakan sampai mana?	イワンはどこまでやったの？	程度についてたずねる		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
134	Baru setengah.	やっと半分だよ。	機能		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
135	Ria sudah berapa halaman?	リアはもう何ページ書いたの？	数字についてたずねる		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
136	Lima halaman, tapi kata dosen minimal delapan halaman.	５ページ。だけど，先生は最低８ページっていってた。	機能		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
137	Bagian terakhir paling sulit, ya.	最後の部分が一番難しいよね。	意見を述べる		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
138	Ya, benar.	うん，そうなの。	意見を述べる		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
139	Bagaimana kalau kita mengerjakan bersama?	一緒にやらない？	提案する		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
140	Itu ide bagus.	それは良い考えね。	意見を述べる		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
141	Setelah makan siang saja, ya.	お昼ご飯の後にしましょ。	条件をつける		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
142	Baiklah, kita bertemu di perpustakaan lantai satu.	わかった。図書館の１階で会おう。	提案する		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
143	Di depan pintu masuk, ya.	入口の前でね。	機能		\N	dmod	id11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
144	Maaf, Pak.	すみません。	注意をひく		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
145	Ya, ada apa?	はい，何か？	状況についてたずねる		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
146	Apa syarat untuk menjadi anggota perpustakaan?	図書館の会員になる条件は何ですか？	手段についてたずねる		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
147	Mengisi formulir pendaftaran.	申込書に記入することです。	しなければならないと言う		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
148	Kalau begitu, saya ingin mendaftar.	では，申し込みをしたいんですが。	希望を述べる		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
149	Silakan mengisi formulir ini.	こちらの申込書に記入してください。	依頼する		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
150	Baik.	分かりました。	機能		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
151	Pak, apakah ini sudah benar?	あの，これで良いですか？	状況についてたずねる		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
152	Ya, sudah benar.	はい，良いですよ。	機能		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
153	Perpustakaan ini buka mulai jam berapa?	この図書館は，何時から開いていますか？	時間についてたずねる		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
154	Mulai jam sembilan pagi sampai jam enam sore setiap hari Senin sampai hari Sabtu.	毎週月曜日から土曜日の朝９時から夕方６時まで開いています。	機能		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
155	Hari Minggu tutup.	日曜日は休みです。	機能		\N	dmod	id12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
156	Saya ingin meminjam beberapa buah buku.	何冊か本をお借りしたいのですが。	手段についてたずねる		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
157	Ya, silakan.	はい，どうぞ。	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
158	Anda bisa melihat katalog di sana.	あちらで目録をご覧になれますよ。	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
159	Bisa pinjam berapa buku?	何冊借りられますか？	数字についてたずねる		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
160	Paling banyak empat buku.	最大4冊です。	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
161	Waktu peminjamannya berapa hari?	貸し出し期間は何日間ですか？	数字についてたずねる		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
162	Paling lama dua minggu.	最長２週間です。	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
163	Bisakah saya memperpanjang?	延長できますか？	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
164	Bisa, tetapi tidak lebih dari satu bulan.	できますが，１ヵ月以内です。	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
165	Baik.	わかりました。	機能		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
166	Terima kasih.	ありがとうございます。	感謝する		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
167	Sama-sama.	どういたしまして。	感謝する		\N	dmod	id13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
168	Ria, ini pemberitahuan tentang apa, ya?	リア，これ何の通知だろう？	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
169	Aaah, ini surat pemberitahuan bahwa Iwan mendapat paket dari seseorang dan harus mengambilnya ke kantor pos sendiri.	あ～，これは，イワンに誰かから小包が届いているから，自分で郵便局まで取りに行かなくちゃいけないっていう通知よ。	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
170	Ooo, begitu.	へぇ，そうなんだ。	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
171	Bagaimana caranya, ya?	どうすれば良いのかな？	手段についてたずねる		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
172	Iwan tahu, 'kan, kantor pos besar di sini?	知ってるでしょ，この辺の大きな郵便局。	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
173	Ya, tapi maksud saya cara mengambilnya.	あぁ。でも，僕が聞きたいのは，小包の受け取り方のことさ。	手段についてたずねる		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
174	Setahu saya, hanya membawa KTP dan kartu mahasiswa saja.	私の知る限りでは，ただ住民登録証と学生証を持って行くだけよ。	助言する		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
175	Lalu?	それから？	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
176	Lalu, tunjukkan surat ini, KTP, dan kartu mahasiswa kepada petugas kantor pos.	それから，郵便局員にこの通知と住民登録証，それと学生証を見せるの。	助言する		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
177	Hanya itu saja.	それだけよ。	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
178	Kalau begitu, besok saya ke sana.	それじゃ，明日行ってくる。	予定を述べる		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
179	Mungkin itu kiriman dari orang tua saya di kampung.	たぶん，故郷の両親からの小包だな。	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
180	Wah, senang, ya!	わぁ，嬉しいでしょ。	機能		\N	dmod	id14.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
181	Besok akan datang mahasiswa dari Jepang.	明日，日本から大学生が来るわよ。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
182	Oh, ya? Berapa orang?	そうなの？何人？	数字についてたずねる		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
183	Kira-kira lima orang.	５人ぐらい。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
184	Gawat!	大変だ。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
185	Kita harus mencari mahasiswa yang bisa berbahasa Jepang.	日本語ができる学生を探さなくちゃ。	提案する		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
186	Jangan khawatir.	心配いらないわ。	しなくともよいと言う		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
187	Ria bisa berbicara bahasa Jepang.	リアが日本語を話せるもの。	理由を述べる		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
188	Betul?	本当？	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
189	Dia hebat, ya.	すごいね。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
190	Dia juga pintar bahasa Inggris.	彼女は英語もうまいよ。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
191	Sayang, ya. Kita tidak bisa bahasa Jepang.	残念ね，私たちは日本語ができないもんね。	意見を述べる		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
192	Sekarang saya sedang belajar bahasa Jepang di Pusat Studi Jepang.	僕は今，日本研究センターで日本語を勉強しているよ。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
193	Hebat!	すごいじゃん。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
194	Tapi, saya belum mahir.	でも，まだマスターしてないし。	機能		\N	dmod	id15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
195	Maaf, Bu.	すみません。	注意をひく		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
196	Saya ingin bertanya.	お尋ねしたいのですが。	注意をひく		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
197	Ya, silakan.	はい，どうぞ。	機能		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
198	Saya ingin mendaftarkan diri ke asrama mahasiswa. Di mana, ya?	学生寮の申し込みをしたいのですが，どちらでしょうか？	場所についてたずねる		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
199	Silakan langsung daftar saja ke asrama mahasiswa.	学生寮のほうに直接申し込んでください。	指示する		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
200	Asramanya di mana?	寮はどちらですか？	場所についてたずねる		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
201	Dari sini naik angkot 08, turun di terminal Depok.	ここから08番のミニバスに乗って，デポックのターミナルで降りてください。	助言する		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
202	Lalu, naik becak, turun di Jalan Merapi.	それから，ベチャッに乗って，ムラピ通りで降りてください。	助言する		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
203	Di sebelah mana, ya, di Jalan Merapi?	ムラピ通りのどちら側ですか？	場所についてたずねる		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
204	Asramanya berada di Jalan Merapi No.18, tepat di samping warung kopi.	寮はムラピ通りの18番地で，ちょうどコーヒーワルンの隣です。	助言する		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
205	Oo, begitu.	そうですか。	機能		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
206	Pendaftarannya langsung di sana, ya, Bu.	申し込みは直接そこでですね。	機能		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
207	Terima kasih, Bu.	ありがとうございました。	感謝する		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
208	Ya, silakan langsung ke sana saja.	はい。直接むこうへ行ってください。	助言する		\N	dmod	id16.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
209	Eh, Tini, katanya punya pacar baru, ya?	あっ、ティニ、新しい恋人ができたんだって？	状況についてたずねる		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
210	Ehm... iya...	うふっ、そうなの。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
211	Eh, kok, tahu?	えっ、でもなんで知ってるの。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
212	Iya, dong.	そりゃ知ってるさ。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
213	Namanya Robi, 'kan?	ロビーって奴だろ。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
214	Iya.	うん。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
215	Dia orangnya seperti apa?	どんな奴なの？	特徴についてたずねる		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
216	Dia baik, ramah, tapi... terlalu serius.	いい人よ。やさしいし。でも、ちょっとまじめ過ぎるの。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
217	Oh, begitu..., tapi Robi cakap, 'kan?	へぇ、そうなんだ。でも、ロビーって格好良いんだろ？	特徴についてたずねる		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
218	Menurut saya, cakap.	私に言わせれば格好良いよ。	意見を述べる		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
219	Apa, ya.	なんて言うか、	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
379	Baik.	元気よ。	挨拶する		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
220	Matanya besar dan hidungnya mancung.	目が大きくて、鼻が高いの。	好きなものについて述べる		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
221	Kalau begitu, seperti saya, bukan?	それじゃ、僕みたいじゃない。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
222	Enak saja!	よく言うわ。	機能		\N	dmod	id17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
223	Anda mahasiswa jurusan bahasa Prancis?	フランス語学科の学生ですか？	機能		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
224	Ya.	はい。	機能		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
225	Anda mahasiswa jurusan bahasa Jepang, 'kan?	あなたは日本語学科の学生ですよね。	機能		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
226	Ya.	はい。	機能		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
227	Apakah bahasa Prancis sulit?	フランス語は難しいですか？	特徴についてたずねる		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
228	Menurut saya, tidak seluruhnya sulit.	私としては，すべてが難しいというわけではないです。	意見を述べる		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
229	Apa yang paling sulit?	何が一番難しいんですか？	特徴についてたずねる		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
230	Cara membaca dan cara menulisnya tidak sama.	読み方と書き方が一致しないところです。	機能		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
231	Oh, ya.	あぁ，そうなんですか。	機能		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
232	Bagaimana dengan bahasa Jepang?	日本語はどうですか？	特徴についてたずねる		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
233	Menurut saya, yang paling sulit dalam bahasa Jepang itu adalah Kanji.	私的には，日本語では漢字が一番難しいです。	意見を述べる		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
234	O begitu..., tetapi saya kira huruf Jepang itu lucu!	なるほど。でも，日本の文字っておもしろいですよね。	意見を述べる		\N	dmod	id18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
235	CD apa itu?	それ何のCD？	特徴についてたずねる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
236	CD Sheila On Seven.	「シェイラ・オン・セブン」のCDよ。	機能		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
237	Sekarang grup Sheila On Seven sedang populer, ya.	今，「シェイラ・オン・セブン」は人気があるよね。	機能		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
238	Ya, lagu-lagunya enak didengar.	うん，彼らの歌は聞きやすいもんね。	意見を述べる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
239	Tapi saya lebih suka lagu-lagu dangdut.	でもさ，僕はダンドゥッのほうが好きだな。	好きなものについて述べる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
240	Hee?	え～。	機能		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
241	Dangdut?	ダンドゥッ？	機能		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
242	Ya, karena iramanya mendayu-dayu.	そう，だってリズムが心にしみるからさ。	理由を述べる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
243	Ooo, saya lebih suka musik pop daripada dangdut.	ふ～ん，私はダンドゥッよりもポップスのほうが好き。	好きなものについて述べる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
244	Selera orang memang berbeda, kan?	やっぱり人の好みは違うものだね。	意見を述べる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
245	Ya, tapi kedua aliran musik itu sama bagusnya.	そうね，でもその２つのジャンルはどちらもいいわ。	好きなものについて述べる		\N	dmod	id19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
246	Rini kelihatan capek, ya?	リニ，疲れているみたいだね。	状況についてたずねる		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
247	Ya, baru selesai latihan tenis.	うん，テニスの練習が終わったばかりなの。	理由を述べる		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
248	Rini ikut klub tenis?	テニスのサークルに入っているの？	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
250	Tenis adalah salah satu hobi saya.	テニスは私の趣味のひとつ。	好きな行動について述べる		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
251	Omong-omong, apa hobi Iwan?	ところで，あなたの趣味は何？	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
252	Hobi saya memancing.	僕の趣味は魚釣りだよ。	好きな行動について述べる		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
253	Memancing?	魚釣り？	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
254	Di mana?	どこで？	場所についてたずねる		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
255	Di Bogor banyak tempat pemancingan ikan.	ボゴールには釣り堀がたくさんあるんだ。	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
256	O, begitu.	あぁ，そう。	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
257	Kapan Iwan pergi memancing?	いつ魚釣りに行くの？	時間についてたずねる		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
258	Hari Minggu saja.	日曜日だけ。	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
259	Dari pagi sampai sore saya memancing.	朝から夕方まで魚釣りしてるよ。	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
260	Kapan-kapan ajak saya, ya!	いつか私を誘ってね。	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
261	Ayu, tahu cara masak nasi goreng yang enak, tidak?	アユ，おいしいナシ･ゴレンの作り方知ってる？	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
262	Oh, nasi goreng?	えっ，ナシ・ゴレン？	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
263	Iya.	うん。	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
264	Gampang.	簡単よ。	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
265	Pertama-tama, siapkan dulu bahan-bahannya.	まず初めに，材料をそろえて。	順序について述べる		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
266	Apa saja?	何？	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
267	Telur, nasi, cabai, bawang putih dan bawang merah.	卵，ご飯，唐辛子，にんにく，それにバワン･メラ。			\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
268	Kalau mau, bisa ditambahkan daging ayam atau sosis.	お好みで，鶏肉かソーセージを加えて。	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
269	Lalu?	それから？	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
270	Bawang putih dan bawang merah diiris halus, cabe diiris miring.	にんにくとバワン･メラを細かく刻んで。唐辛子は斜めに刻むの。			\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
271	Setelah dua sendok makan minyak goreng dipanaskan, semua bumbu yang telah diiris masukkan ke dalam wajan.	大さじ２杯の食用油を熱してから，刻んだ香辛料を全部フライパンに入れるの。	順序について述べる		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
272	Kalau sudah matang, baru dimasukkan nasinya dan ditambahkan garam, gula, sedikit kecap manis.	火が通ってから、ご飯を入れて，塩，砂糖，ケチャップ･マニスを少し加えるのよ。	順序について述べる		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
273	O, begitu.	なるほど。	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
274	Bagaimana telurnya?	卵はどうするの？	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
275	Telurnya diceplok lebih enak, diletakkan di atas nasi goreng akan terlihat lebih mengundang selera.	卵は目玉焼きにするともっとおいしいよ。ナシ･ゴレンの上にのせると食欲をそそるわ。	機能		\N	dmod	id21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
276	Halo, selamat siang.	もしもし，こんにちは。	挨拶する		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
277	Selamat siang.	こんにちは。	挨拶する		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
278	Bisa bicara dengan Ayu?	アユさんとお話しできますか？	機能		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
279	Ya, saya sendiri.	はい，私ですが。	機能		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
280	Saya Joko.	僕，ジョコだよ。	自己紹介する		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
281	Bagaimana keadaan Ayu?	調子はどう？	状況についてたずねる		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
282	Baik.	元気よ。	状況を説明する		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
283	Ada apa?	どうかしたの？	状況についてたずねる		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
284	Saya khawatir akhir-akhir ini Ayu tidak masuk kuliah.	最近，授業に出てこないから心配でね。	機能		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
285	Maaf, akhir-akhir ini saya memang sedang sibuk.	ごめん。最近忙しくって。	謝る		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
286	Oh, sibuk.	ああ、忙しいんだ。	機能		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
287	Sibuk melakukan apa?	何に忙しいの？	状況についてたずねる		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
288	Sibuk membantu persiapan pesta pernikahan kakak saya.	姉の結婚式の準備を手伝っていて忙しいのよ。	状況を説明する		\N	dmod	id22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
289	Ria, hari Minggu ini ada rencana?	リア，今週の日曜日は予定がある？	予定を聞く		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
290	Tidak ada.	ないよ。	機能		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
291	Mengapa?	どうして？	理由を聞く		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
292	Hari Minggu ini saya dan teman-teman ada rencana piknik ke Puncak.	今週の日曜日，僕と友達でプンチャックへピクニックに行く予定なんだ。	予定を述べる		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
293	Ria mau ikut, tidak?	リアも一緒に来る？	誘う		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
294	Mau, saya mau ikut.	行きたい，私も行く。	希望を述べる		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
295	Kalau begitu, kami akan jemput Ria pada jam delapan pagi.	それなら，僕たちが朝８時にリアを迎えにいくよ。	予定を述べる		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
296	Oke, tapi kalau hujan bagaimana?	オッケー。でも、もし雨が降ったらどうするの？	状況についてたずねる		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
297	Meskipun hujan, kami memutuskan tetap berangkat.	雨が降っても，僕たちは変わらず出発することに決めたんだ。	条件をつける		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
298	Eh, tetapi bukannya jalanan ke Puncak licin kalau turun hujan?	えっ，でも雨が降ったら，プンチャックへ行く道が滑るんじゃない？	確認する		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
510	Selamat siang, Pak.	こんにちは。	挨拶する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
299	Ya, tetapi mungkin di perjalanan ke Puncak hujannya sudah berhenti.	うん。でもたぶん，プンチャックに行く途中で雨は止んでしまうよ。	機能		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
300	Benar juga ya.	確かにね。	機能		\N	dmod	id23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
301	Ani, liburan Lebaran nanti mau ke mana?	アニ，今度のルバラン休みにどこか行く？	場所についてたずねる		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
302	Oh, mungkin saya akan berlibur ke Bali dan Lombok.	あぁ，たぶん私はバリとロンボックに行くわ。	予定を述べる		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
303	Naik apa?	何で？	手段についてたずねる		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
304	Saya masih belum tahu.	まだわからない。	機能		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
305	Mungkin naik bis atau pesawat terbang.	たぶんバスか飛行機かな。	予定を述べる		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
306	Oh, begitu. Kalau naik bis, 'kan, lama.	あぁ，そう。バスに乗ったら時間かかるじゃん。	機能		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
307	Iya, sih. Tapi kalau naik bis itu lebih murah dibandingkan naik pesawat terbang.	まあね，でもバスに乗るほうが飛行機に乗るのと比べて安いでしょ。	比べる		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
308	Iya, ya.	そうだね。	機能		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
309	Kalau naik pesawat terbang itu cepat, tetapi biayanya paling mahal.	飛行機に乗れば早いけれど，費用は一番高いしね。	比べる		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
310	Memang.	そういうものよ。	機能		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
311	Ya, segala sesuatu memang ada kelebihan dan kekurangannya.	うん，すべての物事には長所と短所があるからね。	機能		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
312	Iya.	そうね。	機能		\N	dmod	id24.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
313	Joko, sudah membaca informasi ini?	ジョコ，もうこの情報を読んだ？	確認する		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
314	Belum.	まだだけど。	機能		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
315	Tentang apa?	何について？	機能		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
316	Kerja paruh waktu.	アルバイトよ。	機能		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
317	Saya dengar Joko sedang mencari.	ジョコが今探しているって聞いたわよ。	機能		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
318	Ya, betul.	うん，そうなんだ。	機能		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
319	Di informasi ini ada lowongan sebagai pramuniaga di Toserba Matahari, lho.	ここにマタハリ・デパートでの店員の募集があるわよ。			\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
320	Ah, itu sangat memakan waktu.	あぁ，それはすごく時間がとられるなぁ。	意見を述べる		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
322	Itu bagus, tetapi sanggup, tidak, ya?	それはいいな，でも僕にできるかな。	意見を述べる		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
323	Saya yakin Joko pasti bisa.	ジョコならきっとできると思うわ。	意見を述べる		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
324	Terima kasih.	ありがとう。	感謝する		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
325	Permisi, Pak.	先生，失礼します。	挨拶する		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
326	Ya, silakan.	はい，どうぞ。	機能		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
327	Ada apa?	何か？	機能		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
328	Maaf, Pak.	先生，すみません。	謝る		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
329	Besok saya minta izin tidak masuk kuliah.	明日，授業を欠席させていただきたいのですが。	許可を求める		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
330	Kenapa?	どうして？	理由を聞く		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
331	Saya harus pulang ke kampung karena ada urusan mendadak.	急用ができて，田舎に帰らなければならないんです。	理由を述べる		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
332	O, begitu.	ああ，そう。	機能		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
333	Kira-kira berapa lama kamu di kampung?	大体どのぐらい田舎にいるの？	数字についてたずねる		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
334	Hanya tiga hari.	３日間だけです。	機能		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
335	Baiklah.	わかりました。	機能		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
336	Tidak apa-apa.	大丈夫だよ。	許可を与える		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
337	Terima kasih, Pak.	ありがとうございます。	感謝する		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
338	Ya.	ええ。	機能		\N	dmod	id26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
339	Pak, saya mendapat informasi tentang beasiswa dari universitas.	先生，大学からの奨学金について聞いたのですが。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
340	Ya, lalu?	ええ，それで？	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
561	batuk	(咳）	null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	2-4/1.html	\N	1
341	Saya ingin mendaftar beasiswa itu.	私、その奨学金に申し込みたいと思っているんです。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
342	Bagus.	いいですね。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
343	Tetapi ada persyaratan harus ada surat rekomendasi.	でも，推薦状が必要だという条件がありまして。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
344	Karena itu, saya mohon Bapak membuatkan surat rekomendasi untuk saya.	ですので，先生に推薦状を書いていただきたいのですが。	依頼する		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
345	Harus ada rekomendasi dari dosen?	教師の推薦がなければいけないの？	確認する		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
346	Ya, Pak.	そうなんです。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
347	Baiklah.	わかりました。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
348	Nanti akan saya buatkan.	あとで書きましょう。	予定を述べる		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
349	Silakan kamu ambil minggu depan.	来週，取りに来てください。	指示する		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
350	Tetapi batas terakhirnya hari Kamis minggu ini, Pak...	あの，先生，締め切りが今週の木曜日なんです…。	状況を説明する		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
351	Jadi, kalau bisa, saya mohon dibuatkan dalam minggu ini.	ですから，できれば今週中に書いていただけないでしょうか。	依頼する		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
352	Oh, ya, sudah.	えっ，そうなの。	機能		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
353	Kalau begitu, hari Rabu saja.	それじゃぁ，水曜日で。	予定を述べる		\N	dmod	id27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
354	Mas Robi, yang disebut "Festival Kebudayaan Jepang" itu apa?	ロビーさん，「日本文化フェスティバル」って何ですか?	特徴についてたずねる		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
355	O, biasanya di Jepang setiap musim gugur diadakan festival kampus.	日本では普通，秋に学園祭をやるんだよ。	機能		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
356	Tetapi universitas kita, 'kan, ada di Indonesia?	でも，私たちの大学はインドネシアにありますよね。	機能		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
357	Ya, tetapi biasanya jurusan bahasa Jepang membuat acara seperti di Jepang.	そうだけど，日本語学科は日本と同じようにイベントをやるんだ。	特徴について述べる		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
358	O, begitu.	なるほど。	機能		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
359	Acaranya apa saja?	催し物には何があるんですか？	特徴についてたずねる		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
360	Pada saat itu mahasiswa jurusan bahasa Jepang mengenalkan kebudayaan Jepang.	そのとき，日本語学科の学生は日本文化を紹介するんだよ。	機能		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
361	Misalnya?	たとえば？	機能		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
362	Misalnya, ada demo masak makanan Jepang, acara minum teh, dan juga pemutaran film Jepang.	たとえば，日本料理の模擬店やお茶会，それに日本映画の上映もあるよ。	例をあげる		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
363	Acaranya selama berapa hari?	フェスティバルは何日間ですか？	数字についてたずねる		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
364	Kira-kira satu minggu.	１週間ぐらいだよ。	機能		\N	dmod	id28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
365	Mau pesan apa, Mbak?	ご注文は？	注文を取る		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
366	Bakso satu porsi.	バソを１人前ください。	注文する		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
367	Dibungkus, ya, Pak.	持ち帰り用に包んでくださいね。	依頼する		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
368	Maaf, Mbak, baksonya sudah habis.	すみません，バソはもうなくなったんですが。	謝る		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
369	Kalau begitu, mi ayam saja.	それじゃ，ミ・アヤムをください。	妥協する		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
370	Jangan lupa sambalnya, Pak!	サンバルも忘れないでね。	しないでくれと言う		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
371	Maaf, sambalnya juga sudah habis.	申し訳ありません。サンバルも切らしてしまいまして。	謝る		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
372	Mi ayam tanpa sambal juga tidak apa-apa.	サンバル抜きのミ・アヤムでもいいわ。	妥協する		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
373	Saya pesan es jeruk juga.	あと，オレンジジュースもください。	注文する		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
374	Tunggu sebentar, ya, Mbak.	少々お待ちください。	指示する		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
375	Jadi, berapa semuanya?	全部でおいくらになりますか？	金額についてたずねる		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
376	Tiga ribu rupiah.	3,000ルピアです。	機能		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
377	Ini uangnya, Pak.	はい，これ，お金です。	人にものをあげる		\N	dmod	id29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
378	Bagaimana kabarnya, Ayu?	元気？	挨拶する		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
850	Berapa nomor telepon Anda?	あなたの電話番号はいくつですか。	\N		\N	vmod	\N	\N	\N	0	1
380	Ayu sudah mengerjakan PR bahasa Inggris?	もう英語の宿題をやった？	確認する		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
381	Sudah.	やったわ。	機能		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
382	Apakah Ayu punya Kamus Bahasa Inggris-Indonesia?	アユは『英語－インドネシア語辞典』を持っている？	確認する		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
383	Punya.	持ってるよ。	機能		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
384	Kenapa?	どうして？	理由を聞く		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
385	Bolehkah saya meminjam kamus itu?	その辞書，借りてもいいかな？	許可を求める		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
386	Boleh.	いいわよ。	許可を与える		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
387	Kapan mau dipakai?	いつ使いたいの？	時間についてたずねる		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
388	Besok.	明日なんだ。	機能		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
389	Baiklah, besok saya akan membawa kamus itu.	わかったわ。明日持ってくるね。	予定を述べる		\N	dmod	id30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
390	Permisi, Bu.	先生，失礼します。	注意をひく		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
391	Ada apa?	何か？	機能		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
392	Saya belum mengumpulkan tugas minggu yang lalu.	先週の課題をまだ提出していないのですが。	状況を説明する		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
393	Mengapa?	どうして？	理由を聞く		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
394	Karena kakak saya menikah, minggu yang lalu saya pulang ke kampung.	姉が結婚したので，先週は田舎に帰っていたんです。	理由を述べる		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
395	O, begitu.	あ，そうなの。	機能		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
396	Kapan mau dikumpulkan?	それで，いつ提出するの？	時間についてたずねる		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
397	Apakah saya harus mengumpulkan dalam minggu ini, Bu?	今週中に提出しなければなりませんか？	しなければならないか聞く		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
398	Ya, Anda harus mengumpulkan dalam minggu ini.	そうね，今週中に提出しなくてはいけないわね。	しなければならないと言う		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
399	Baiklah, Bu.	わかりました。	機能		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
400	Hari Jumat saya akan mengumpulkannya.	金曜日に提出します。	予定を述べる		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
401	Saya tunggu di ruangan saya jam setengah sepuluh pagi.	朝９時半に，研究室で待っていますよ。	予定を述べる		\N	dmod	id31.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
402	Permisi.	すみません。	注意をひく		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
403	Ya?	はい。	機能		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
404	Apakah Anda tahu pemilik motor itu?	このバイクの所有者を知っていますか？	機能		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
405	Itu motor saya, Pak.	それは私のバイクですが。	機能		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
406	Di sini dilarang parkir motor.	ここは駐車禁止ですよ。	禁止する		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
407	Tidak boleh parkir motor?	駐車禁止なんですか？	確認する		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
408	Ya. Di halaman ini dilarang parkir motor.	はい。この庭は駐車禁止です。	禁止する		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
409	Di mana tempat parkirnya?	駐車場はどこですか？	場所についてたずねる		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
410	Di belakang gedung itu.	その建物の裏です。	機能		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
411	Baiklah. Saya akan parkir di sana.	わかりました。向こうに駐車します。	機能		\N	dmod	id32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
412	Bu, sedang membuat apa?	何を作っているんですか？	機能		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
413	Kue untuk Hari Natal nanti.	今度のクリスマスのためのお菓子よ。	機能		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
414	Banyak pesanan, ya, Bu.	たくさん注文があったんですね。	機能		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
415	Iya.	そうよ。	機能		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
416	Nah, Sep, bantuin Ibu, ya.	だから、アセップも手伝って。	依頼する		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
417	Tolong kue ini diantar sekarang.	これからこのお菓子を届けてちょうだい。	指示する		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
418	Mau diantar ke mana?	どこに届ければいいんですか？	場所についてたずねる		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
419	Ke rumah Ibu Ani.	アニさんのお宅へよ。	機能		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
420	Ya, Bu, tapi saya tidak tahu harus naik apa, ya.	はい。でも何に乗ればいいかわからないんですけど。	手段についてたずねる		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
511	Senang berkenalan dengan Anda.	どうぞよろしく。	挨拶する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
421	Pertama, naik angkot nomor D02, turun di Jalan Mawar.	最初に，D02番のミニバスに乗って，マワール通りで降りるの。	順序について述べる		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
422	Terus?	それから？			\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
423	Terus, jalan sampai warung "Berkat".	それから，「ブルカット」っていうワルンまで歩いて。	順序について述べる		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
424	Rumah Ibu Ani tepat di sebelahnya.	アニさんのお宅はちょうどその隣よ。	状況を説明する		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
425	Hati-hati, ya.	気をつけてね。	機能		\N	dmod	id33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	1
426	Ada apa?	どうしましたか？	状況についてたずねる		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
427	Sudah dua hari ini kepala dan tenggorokan saya sakit, Dok.	この２日間，頭と喉が痛いのですが。	状況を説明する		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
428	Coba saya periksa dulu.	ちょっと診てみましょう。	機能		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
429	Bagaimana, Dok?	先生，どうですか？	状況についてたずねる		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
430	Anda demam.	熱がありますね。	状況を説明する		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
431	Harus banyak istirahat.	ゆっくり休まなければなりませんね。	しなければならないと言う		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
432	Bagaimana dengan makanan?	食べ物はどうですか？	確認する		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
433	Sementara jangan makan makanan berminyak.	しばらく油っぽいものは食べないでください。	しないでくれと言う		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
435	Sementara jangan mandi dulu, ya.	しばらく水浴しないでくださいね。	しないでくれと言う		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
436	Tidak boleh mandi?	水浴してはいけないんですか？	確認する		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
437	Baiklah.	わかりました。	機能		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
438	Pak, saya ingin mengembalikan buku.	先生，本をお返ししたいのですが。	機能		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
439	Buku apa?	何の本？	機能		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
440	Buku sejarah.	歴史の本です。	機能		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
441	Sudah selesai membaca?	もう読み終わったんですか？	機能		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
442	Sebetulnya, belum.	実はまだなんです。	機能		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
443	Kalau begitu, silakan selesaikan dulu.	それでは，どうぞ読み終えてください。	勧める		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
444	Tapi, saya harus mengembalikan hari ini, Pak?	でも，今日お返ししなければならないんですよね？	しなければならないか確認する		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
445	Tidak.	いいえ。	機能		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
446	Tidak mengembalikan hari ini juga boleh.	今日返さなくてもいいですよ。	しなくともよいと言う		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
447	Tidak apa-apa, Pak?	大丈夫ですか？	確認する		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
448	Ya, silakan baca sampai selesai.	ええ，どうぞ最後まで読んでください。	勧める		\N	dmod	id35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
449	Besok ada acara di unit gamelan.	明日，ガムランサークルのイベントがあるんだ。	予定を述べる		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
450	Di mana?	どこで？	場所についてたずねる		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
451	Di kampus.	キャンパスだよ。	機能		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
452	Ayu mau datang?	来ない？	誘う		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
453	Tapi, besok teman saya akan datang.	でも，明日は友達が来るの。	状況を説明する		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
454	Kalau begitu, silakan datang dengan teman Ayu juga.	それじゃ，友達と一緒に来てよ。	招待する		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
455	Boleh?	いいの？	許可を求める		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
456	Tentu saja.	もちろん。	機能		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
457	Ajaklah teman Ayu itu.	その友達も誘いなよ。	招待する		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
458	Berapa harga tiketnya?	チケットの値段はいくら？	金額についてたずねる		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
459	Ini ada dua tiket gratis untuk Ayu.	これ，アユのための無料チケット２枚。	人にものをあげる		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
460	Sungguh?	本当に？	機能		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
461	Terima kasih.	ありがとう。	感謝する		\N	dmod	id36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
462	Kelihatannya Anda terlalu lelah.	疲れ過ぎのようですね。	機能		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
463	Ya, Dok.	はい。	機能		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
464	Minggu ini saya kurang tidur.	今週は寝不足なんです。	状況を説明する		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
465	Tapi Anda harus istirahat yang cukup.	でも，十分に休まなければいけませんよ。	しなければならないと言う		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
466	Ya, Dok.	はい。	機能		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
467	Apa saya harus minum obat?	薬を飲まなければなりませんか？	しなければならないか聞く		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
469	Saya akan buat resep.	処方箋を作ります。	機能		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
470	Terima kasih.	ありがとうございます。	感謝する		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
471	Sebaiknya Anda cukup tidur.	よく寝たほうがいいですよ。	助言する		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
472	Tapi saya punya banyak tugas.	でも，課題がたくさんあるんです。	状況を説明する		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
473	Karena sedang sakit, sebaiknya Anda menjelaskan kepada dosen.	今は病気ですから，先生に説明したほうがいいですね。	助言する		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
475	Iwan, tolong kemari sebentar.	イワン，ちょっとこっちに来て。	依頼する		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
476	Ada apa, Bu?	なんでしょうか？	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
477	Hari ini Iwan sempat bertemu dengan Rini?	今日，リニに会うかしら。	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
478	Ya, Bu.	はい。	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
479	Nanti saya bertemu dengannya.	後で会いますが。	予定を述べる		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
480	O, begitu?	あら，そう。	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
481	Bisa Ibu minta tolong?	じゃ，ちょっとお願いしても良いかしら。	依頼する		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
482	Tentu, Bu.	もちろんです，先生。	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
483	Tolong sampaikan pada Rini Ibu ingin agar ia datang ke ruangan Ibu.	彼女に，私の研究室へ来るようにって伝えてほしいんだけど。	要求する		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
484	Jam berapa, Bu?	何時にですか？	時間についてたずねる		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
485	Jam dua belas.	12時。	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
486	Baik, Bu.	わかりました。	機能		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
487	Nanti akan saya sampaikan padanya.	後でリニに伝えておきます。	予定を述べる		\N	dmod	id38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
488	Ayo, makan siang.	お昼ご飯を食べよう。	誘う		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
489	Saya traktir.	おごるよ。	機能		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
490	Sungguh?	本当？	機能		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
491	Ya, hari ini saya ulang tahun.	うん，今日は僕の誕生日なんだ。	機能		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
492	Wah, Selamat ulang tahun!	お誕生日おめでとう。	挨拶する		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
493	Terima kasih.	ありがとう。	感謝する		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
494	Nah, mau makan apa?	さあ，何が食べたい？	希望を聞く		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
495	Terserah Ari, deh.	アリに任せるわ。	希望を述べる		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
496	Bilang saja mau makan apa.	何が食べたいか言ってよ。	希望を聞く		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
497	Kalau begitu, saya mau makan masakan Padang.	それじゃ，パダン料理が食べたいな。	希望を述べる		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
498	Oke.	オーケー。	機能		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
499	Mari kita pergi.	じゃ，行こう。	誘う		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
500	Asyik!	やった～。	機能		\N	dmod	id39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
501	Permisi, Pak.	先生，失礼します。	注意をひく		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
502	Silakan.	どうぞ。	許可を与える		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
503	Ada apa?	どうしましたか？	機能		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
504	Saya ingin memperkenalkan mahasiswa asing dari Jepang.	日本からの留学生を紹介したいのですが。	人を紹介する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
505	Silakan, silakan.	どうぞ，どうぞ。	許可を与える		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
506	Perkenalkan.	ご紹介します。	人を紹介する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
507	Ini Akiko Tanaka dari Jepang.	こちらは日本からの田中明子さんです。	人を紹介する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
508	Akiko, ini Bapak Yanto.	明子，こちらはヤント先生です。	機能		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
509	Selamat siang, Akiko.	こんにちは。	挨拶する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
512	Akiko, Pak Yanto adalah dosen tata bahasa.	明子さん，ヤント先生は文法の先生です。	人を紹介する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
513	Saya tertarik dengan tata bahasa Indonesia.	私は，インドネシア語の文法に興味があるんです。	好きなものについて述べる		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
514	Senang berkenalan dengan Bapak.	どうぞよろしくお願いいたします。	挨拶する		\N	dmod	id40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
515	a		null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-1/1.html	\N	1
516	i		null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-1/1.html	\N	1
517	u		null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-1/1.html	\N	1
518	é		null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-1/1.html	\N	1
519	o		null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	2-1/1.html	\N	1
520	e		null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	2-1/1.html	\N	1
521	apa	(何)	null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	2-1/1.html	\N	1
522	nama	(名前)	null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]	2-1/1.html	\N	1
523	ini	(これ)	null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]	2-1/1.html	\N	1
524	béda	(違い)	null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]	2-1/1.html	\N	1
525	toko	(店)	null		\N	pmod	page003.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]	2-1/1.html	\N	1
526	ibu	(母)	null		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	2-2/1.html	\N	1
527	susu	(ミルク)	null		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[2]	2-2/1.html	\N	1
528	buku	(本)	null		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[3]	2-2/1.html	\N	1
529	peta	(地図)	null		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[4]	2-2/1.html	\N	1
530	sepatu	靴	null		\N	pmod	page004.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[5]	2-2/1.html	\N	1
531	ai(ay)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-3/1.html	\N	1
532	au(aw)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-3/1.html	\N	1
533	oi(oy)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-3/1.html	\N	1
534	ai(éy)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-3/1.html	\N	1
535	ai(é)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	2-3/1.html	\N	1
536	au(ow)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	2-3/1.html	\N	1
537	au(o)		null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	2-3/1.html	\N	1
538	pandai	(上手だ)	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-3/1.html	\N	1
539	kain	（布）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-3/1.html	\N	1
540	mau	(～したい)	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-3/1.html	\N	1
541	memakai（memakay）	（使う：二重母音）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	2-3/1.html	\N	1
542	memakai（memakéy）	（使う：二重母音：口語）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	2-3/1.html	\N	1
543	bermain	（遊ぶ：母音連続）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	2-3/1.html	\N	1
544	kalau（kalaw）	（もし～なら：二重母音）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	2-3/1.html	\N	1
545	kalau（kalow）	（もし～なら：二重母音：口語）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	2-3/1.html	\N	1
546	saudara (sowdara)	（兄弟：二重母音：saw- はまれ）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[6]	2-3/1.html	\N	1
547	lampau(lampaw)	（過ぎた：二重母音：ow- はまれ）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[7]	2-3/1.html	\N	1
548	mau	（～したい：母音連続）	null		\N	pmod	page005.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[8]	2-3/1.html	\N	1
549	pa		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-4/1.html	\N	1
550	ba		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-4/1.html	\N	1
551	ta		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-4/1.html	\N	1
552	da		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-4/1.html	\N	1
553	ka		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	2-4/1.html	\N	1
554	ga		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	2-4/1.html	\N	1
555	ti		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	2-4/1.html	\N	1
556	di		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]	2-4/1.html	\N	1
557	tu		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[9]	2-4/1.html	\N	1
558	du		null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[10]	2-4/1.html	\N	1
559	bapak	(父)	null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	2-4/1.html	\N	1
560	tutup	（蓋）	null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	2-4/1.html	\N	1
959	Dia meminjamkan uang kepada saya.	彼は僕にお金を貸してくれた。	\N		\N	vmod	\N	\N	\N	0	1
562	kakak	（兄，姉）	null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	2-4/1.html	\N	1
563	bukit	（丘）	null		\N	pmod	page006.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	2-4/1.html	\N	1
564	sa		null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-5/1.html	\N	1
565	si		null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-5/1.html	\N	1
566	habis	(なくなる)	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-5/1.html	\N	1
567	habisu	はびす（語末のsに余計な母音を加えてしまった場合）	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-5/1.html	\N	1
568	satu	(１)	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	2-5/1.html	\N	1
569	situ	（そこ）	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	2-5/1.html	\N	1
570	tas	(かばん）	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	2-5/1.html	\N	1
571	bis	（バス）	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	2-5/1.html	\N	1
572	batas	（境界）	null		\N	pmod	page007.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	2-5/1.html	\N	1
573	ha		null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-6/1.html	\N	1
574	susah	(難しい)	null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-6/1.html	\N	1
575	hari	(日)	null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-6/1.html	\N	1
576	hebat	（すごい）	null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-6/1.html	\N	1
577	kisah	(物語）	null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-6/1.html	\N	1
578	sudah	（すでに）	null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	2-6/1.html	\N	1
579	tubuh	（体）	null		\N	pmod	page008.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	2-6/1.html	\N	1
580	ca		null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-7/1.html	\N	1
581	ja		null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-7/1.html	\N	1
582	coba	(試す)	null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-7/1.html	\N	1
583	cita-cita	(夢)	null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-7/1.html	\N	1
584	cucu	(孫)	null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-7/1.html	\N	1
585	jadi	(なる)	null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	2-7/1.html	\N	1
586	tujuh	(７)	null		\N	pmod	page009.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	2-7/1.html	\N	1
587	A(lupa)		null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-8/1.html	\N	1
588	B(rupa)		null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-8/1.html	\N	1
589	la		null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-8/1.html	\N	1
590	ra(rrrra)	(べらんめえ調)	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-8/1.html	\N	1
591	ra(ra)	（はじき音）	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-8/1.html	\N	1
592	lupa	(忘れる)	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	2-8/1.html	\N	1
593	lari	(走る)	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	2-8/1.html	\N	1
594	pergi	(行く)	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	2-8/1.html	\N	1
595	kol	(キャベツ)	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	2-8/1.html	\N	1
596	lapar	(おなかがすいた)	null		\N	pmod	page010.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	2-8/1.html	\N	1
597	ma	(m+母音)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-9/1.html	\N	1
598	na	(n+母音)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-9/1.html	\N	1
599	nya	(ny+母音)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-9/1.html	\N	1
600	nga	(ng+母音)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-9/1.html	\N	1
601	nama	(名前)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-9/1.html	\N	1
602	ngantuk	(眠い)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-9/1.html	\N	1
603	ngeri	(ぞっとする)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-9/1.html	\N	1
604	hangat	(暖かい)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	2-9/1.html	\N	1
605	nyamuk	(蚊)	null		\N	pmod	page011.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	2-9/1.html	\N	1
606	am	「かんぱい（乾杯）」の「ん」	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-10/1.html	\N	1
607	an	「かんだい（寛大）」の「ん」	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-10/1.html	\N	1
608	ang	「かんがい（灌漑）」の「ん」	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-10/1.html	\N	1
609	alam	(自然)	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-10/1.html	\N	1
610	tangan	(腕)	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-10/1.html	\N	1
611	nyaman	(心地よい)	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-10/1.html	\N	1
612	Jepang	(日本)	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	2-10/1.html	\N	1
613	bingung	(迷う，混乱する)	null		\N	pmod	page012.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	2-10/1.html	\N	1
615	wa		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-11/1.html	\N	1
616	wi		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-11/1.html	\N	1
617	wu		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-11/1.html	\N	1
618	wé		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	2-11/1.html	\N	1
619	wo		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	2-11/1.html	\N	1
620	we		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	2-11/1.html	\N	1
621	wajah	(顔)	null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-11/1.html	\N	1
622	kawan	(同僚)	null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-11/1.html	\N	1
623	wisata	(観光)	null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-11/1.html	\N	1
624	yén	(日本円)	null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	2-11/1.html	\N	1
625	saya	(私)	null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	2-11/1.html	\N	1
626	sya	(sy+母音)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-12/1.html	\N	1
627	za	(z+母音)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	2-12/1.html	\N	1
628	fa	(f+母音)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	2-12/1.html	\N	1
629	va	(v+母音)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	2-12/1.html	\N	1
630	kha	(kh+母音)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	2-12/1.html	\N	1
631	syarat	(条件)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	2-12/1.html	\N	1
632	zaman	(時代)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	2-12/1.html	\N	1
633	aktif	(アクティブ：active)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	2-12/1.html	\N	1
634	vidéo	(ビデオ：video)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	2-12/1.html	\N	1
635	khas	(独特な)	null		\N	pmod	page014.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	2-12/1.html	\N	1
636	a	　a	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-1/1.html	\N	1
637	b	　bé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-1/1.html	\N	1
638	c	　cé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-1/1.html	\N	1
639	d	　dé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-1/1.html	\N	1
640	e	　é	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-1/1.html	\N	1
641	f	　éf	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	5-1/1.html	\N	1
642	g	　gé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	5-1/1.html	\N	1
643	h	　ha	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]	5-1/1.html	\N	1
644	i	　i	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[9]	5-1/1.html	\N	1
645	j	　jé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[10]	5-1/1.html	\N	1
646	k	　ka	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[11]	5-1/1.html	\N	1
647	l	　él	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[12]	5-1/1.html	\N	1
648	m	　ém	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[13]	5-1/1.html	\N	1
649	n	　én	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[14]	5-1/1.html	\N	1
650	o	　o	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[15]	5-1/1.html	\N	1
651	p	　pé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[16]	5-1/1.html	\N	1
652	q	　ki	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[17]	5-1/1.html	\N	1
653	r	　ér	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[18]	5-1/1.html	\N	1
654	s	　és	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[19]	5-1/1.html	\N	1
655	t	　té	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[20]	5-1/1.html	\N	1
656	u	　u	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[21]	5-1/1.html	\N	1
657	v	　vé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[22]	5-1/1.html	\N	1
658	w	　wé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[23]	5-1/1.html	\N	1
659	x	　éks	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[24]	5-1/1.html	\N	1
660	y	　yé	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[25]	5-1/1.html	\N	1
661	z	　zét	null		\N	pmod	page015.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[26]	5-1/1.html	\N	1
662	1    satu		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-2/1.html	\N	1
663	2    dua		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-2/1.html	\N	1
664	3    tiga		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-2/1.html	\N	1
665	4    empat		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-2/1.html	\N	1
666	5    lima		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-2/1.html	\N	1
667	6    enam		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	5-2/1.html	\N	1
668	7    tujuh		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	5-2/1.html	\N	1
669	8    delapan		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]	5-2/1.html	\N	1
670	9    sembilan		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[9]	5-2/1.html	\N	1
671	10   sepuluh		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[10]	5-2/1.html	\N	1
672	11   sebelas		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[11]	5-2/1.html	\N	1
673	12   dua belas		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[12]	5-2/1.html	\N	1
674	20   dua puluh		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[13]	5-2/1.html	\N	1
675	30   tiga puluh		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[14]	5-2/1.html	\N	1
676	99   sembilan puluh sembilan		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[15]	5-2/1.html	\N	1
677	100  seratus		null		\N	pmod	page016.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[16]	5-2/1.html	\N	1
678	Senin	(月曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-3/1.html	\N	1
680	Rabu	(水曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-3/1.html	\N	1
681	Kamis	(木曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-3/1.html	\N	1
682	Jumat(jum-at)	(金曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-3/1.html	\N	1
683	Sabtu	(土曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	5-3/1.html	\N	1
684	Minggu	(日曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	5-3/1.html	\N	1
685	1月  Januari		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	5-4/1.html	\N	1
686	2月  Fébruari		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-4/1.html	\N	1
687	3月  Marét		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	5-4/1.html	\N	1
688	4月  April		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	5-4/1.html	\N	1
689	5月  Méi		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	5-4/1.html	\N	1
690	6月  Juni		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	5-4/1.html	\N	1
691	7月  Juli		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	5-4/1.html	\N	1
692	8月  Agustus		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]	5-4/1.html	\N	1
693	9月  Séptémber		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[9]	5-4/1.html	\N	1
694	10月  Oktober		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[10]	5-4/1.html	\N	1
695	11月  Novémber		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[11]	5-4/1.html	\N	1
696	12月  Désémber		null		\N	pmod	page018.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[12]	5-4/1.html	\N	1
697	buku saya	（本　私　→　私の本）	null		\N	pmod	page020.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-1/1.html	\N	1
698	buku	（本）	null		\N	pmod	page020.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	3-1/1.html	\N	1
699	itu	（それ，その）	null		\N	pmod	page020.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	3-1/1.html	\N	1
700	buku itu	（本　その　→　その本）	null		\N	pmod	page020.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-1/1.html	\N	1
701	adik saya	（弟・妹　私　→　私の弟・妹）	null		\N	pmod	page020.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-1/1.html	\N	1
702	buku adik saya	（本　弟・妹　私　→　私の弟の本）	null		\N	pmod	page020.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	3-1/1.html	\N	1
703	buku saya	（本　私　→　私の本）	null		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-2/1.html	\N	1
704	itu	（それ，その）	null		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	3-2/1.html	\N	1
705	buku itu	（本　その　→　その本）	null		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	3-2/1.html	\N	1
706	orang itu	（人　その　→　その人）	null		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-2/1.html	\N	1
707	nama saya	（名前　私　→　私の名前）	null		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-2/1.html	\N	1
708	nama adik saya	（名前　弟・妹　私　→　私の弟の名前）	null		\N	pmod	page021.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	3-2/1.html	\N	1
709	itu buku saya	（それは私の本です。）	null		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-3/1.html	\N	1
710	Itu adik saya.	（それ　弟・妹　私　→　それは，私の弟です。）	null		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	3-3/1.html	\N	1
711	Nama saya Joko.	（名前　私　ジョコ　→　私の名前は，ジョコです。）	null		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	3-3/1.html	\N	1
712	Buku itu buku saya.	（本　それ　本　私　→　その本は，私の本です。）	null		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-3/1.html	\N	1
713	Nama adik saya Ayu.	（名前　弟・妹　私　アユ　→　私の妹の名前は，アユです）	null		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-3/1.html	\N	1
714	Buku itu buku adik saya.	（本　その　本　弟・妹　私　→　その本は私の弟の本です。）	null		\N	pmod	page022.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	3-3/1.html	\N	1
715	buku saya itu	（本　私　それ　→　私の本は，それです。）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
716	itu buku saya	（それ　本　私　→　それです，私の本は。） 	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
717	itu buku saya	（それ　本　私　→　それは私の本です。）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
718	Itu adik saya.	（それ　弟・妹　私　→　それは，私の弟です。）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
719	Adik saya, itu.	（弟・妹　私　それ　→　私の弟です，それは。）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
720	Itu, adik saya.	（それ　弟・妹　私　→　それです，私の弟は。）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
721	Nama adik saya Ayu.	（名前　弟・妹　私　アユ　→　私の妹の名前は，アユです）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
722	Ayu, nama adik saya.	（アユ　名前　弟・妹　私　→　アユです，私の妹の名前は。）	null		\N	pmod	page023.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[1]	3-4/1.html	\N	1
723	Saya tinggal di Bali	（私　住む　～に　バリ　→　私はバリに住んでいます。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
724	Tinggal di Bali saya	（住む　～に　バリ　私　→　バリに住んでいます，私は。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
725	Buku saya baru	（本　私　新しい　→　私の本は新しいです。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
726	Baru buku saya	（新しい　本　私　→　新しいです，私の本は。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
727	Saya punya buku.	（私　持っている　本　→　私は本を持っています。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
728	Adik saya akan pergi ke Bali.	（弟・妹　私　～する（予定）　行く　～へ　バリ　→　私の妹はバリへ行きます。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
729	Akan pergi ke Bali, adik saya.	（～する（予定）　行く　～へ　バリ　弟・妹　私　→　バリへ行きます，私の妹は。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
730	Orang itu cantik.	（人　その　美人だ　→　その人は，美人です。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[9]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
731	Cantik, orang itu.	（美人だ　その　人　→　美人です，その人は。）	null		\N	pmod	page024.xml	/pmod:page[1]/pmod:block[10]/pmod:examples[1]/pmod:example[1]	3-5/1.html	\N	1
732	itu buku siapa?	（それ　本　だれ　→　それは誰の本ですか。）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
733	apakah buku itu buku saya	（<疑問>　本　その　本　私　→　その本は私の本ですか。）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
734	Anda tinggal di mana?	（あなた　住んでいる　～に　どこ　→　あなたはどこに住んでいますか。）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
735	Orang itu Ayu?	（人　その　アユ　→　その人はアユですか。）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
736	Apakah orang itu Ayu?	（<疑問>　人　その　アユ　→　その人はアユですか。）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
737	Tinggal di Bali, orang itu?	（住んでいる　～に　バリ　人　その　→　バリに住んでいますか，その人は。）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
738	Siapa nama Anda?	（誰　名前　あなた　→　あなたの名前は？）	null		\N	pmod	page025.xml	/pmod:page[1]/pmod:block[8]/pmod:examples[1]/pmod:example[1]	3-6/1.html	\N	1
739	Orang itu adik saya.	（人　その　弟・妹　私　→　その人は私の妹です。）	null		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	3-7/1.html	\N	1
740	Adik saya, orang itu.	（弟・妹　私　その　人　→　私の妹です，その人は。）	null		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[4]/pmod:examples[1]/pmod:example[1]	3-7/1.html	\N	1
741	Buku itu baru.	（本　その　新しい　→　その本は新しい。）	null		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[5]/pmod:examples[1]/pmod:example[1]	3-7/1.html	\N	1
742	Siapa nama Anda ?	（誰  名前　あなた　　→　あなたの名前は？）	null		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[6]/pmod:examples[1]/pmod:example[1]	3-7/1.html	\N	1
743	Nama saya Ayu?	（名前　私　アユ　→　私の名前はアユです。）	null		\N	pmod	page026.xml	/pmod:page[1]/pmod:block[7]/pmod:examples[1]/pmod:example[1]	3-7/1.html	\N	1
744	tangan	(手)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-8/1.html	\N	1
745	tangga	(階段)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-8/1.html	\N	1
746	ta-ngan		null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	3-8/1.html	\N	1
747	tang-ga		null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	3-8/1.html	\N	1
748	tang-gan		null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-8/1.html	\N	1
749	ingin	(欲する)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	3-8/1.html	\N	1
750	mengerti	(理解する)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	3-8/1.html	\N	1
751	mengubah	(変える)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	3-8/1.html	\N	1
752	bingung	(迷う，混乱する)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	3-8/1.html	\N	1
753	mengganggu	(邪魔する)	null		\N	pmod	page027.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	3-8/1.html	\N	1
754	maaf	(すみません)	null		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	3-9/1.html	\N	1
755	keempat	（4番目：ke+4）	null		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	3-9/1.html	\N	1
756	saat	（瞬間，時）	null		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	3-9/1.html	\N	1
757	koordinasi	（調整）	null		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	3-9/1.html	\N	1
758	keenam	（6番目：ke+6）	null		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	3-9/1.html	\N	1
759	taat	（従う）	null		\N	pmod	page028.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	3-9/1.html	\N	1
760	drama	（劇）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-1/1.html	\N	1
761	struktur	（構造）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	4-1/1.html	\N	1
762	pribadi	（個人の）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-1/1.html	\N	1
763	swasta	（民間の）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-1/1.html	\N	1
764	status	（身分）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	4-1/1.html	\N	1
765	sastra	（文学）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	4-1/1.html	\N	1
766	stratégi	（戦略）	null		\N	pmod	page029.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	4-1/1.html	\N	1
767	Selamat pagi	(おはようございます)	null		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-2/1.html	\N	1
768	satpam	（警備員）	null		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-2/1.html	\N	1
769	manfaat	（利用価値）	null		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-2/1.html	\N	1
770	Selamat malam.	（こんばんは。）	null		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	4-2/1.html	\N	1
771	teman baru	（友人　新しい　→　新しい友人）	null		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	4-2/1.html	\N	1
772	yang mana	（どの，どちらの）	null		\N	pmod	page030.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	4-2/1.html	\N	1
773	air	（水）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-3/1.html	\N	1
774	pengairan	（灌漑）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	4-3/1.html	\N	1
775	masuk	（入る）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-3/1.html	\N	1
776	masukan	（意見）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-3/1.html	\N	1
777	masukkan	（～を入れる）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	4-3/1.html	\N	1
778	ma-su-kan		null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	4-3/1.html	\N	1
779	ma-suk-kan		null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	4-3/1.html	\N	1
780	masuk → memasuki	（入る） → （～へ入る）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	4-3/1.html	\N	1
781	banyak → kebanyakan（多くの）	（多い）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	4-3/1.html	\N	1
782	masak → memasakkan	（料理する） → （～のために料理する）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	4-3/1.html	\N	1
783	panjang → kepanjangan	（長い） → （長すぎる）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	4-3/1.html	\N	1
784	pesan → pesanan	（注文する） → （注文品）	null		\N	pmod	page031.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	4-3/1.html	\N	1
785	ua	(uwa)	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-4/1.html	\N	1
786	ui	(uwi)	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	4-4/1.html	\N	1
787	ué	(uwé)	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	4-4/1.html	\N	1
788	ia	(iya)	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	4-4/1.html	\N	1
789	iu	(iyu)	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[5]	4-4/1.html	\N	1
790	io	(iyo)	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[6]	4-4/1.html	\N	1
791	uang	（→uwang）（お金）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[7]	4-4/1.html	\N	1
792	dia	（→diya）（彼・彼女）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[8]	4-4/1.html	\N	1
793	dua（→duwa）	（2）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-4/1.html	\N	1
794	kuil（→kuwil）	（寺院）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-4/1.html	\N	1
795	kué（→kuwé）	（お菓子）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	4-4/1.html	\N	1
796	siang（→siyang）	（昼）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	4-4/1.html	\N	1
797	tiap（→tiyap）	（～毎）	null		\N	pmod	page032.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	4-4/1.html	\N	1
798	ひ		null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-5/1.html	\N	1
799	ふ		null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	4-5/1.html	\N	1
800	hi		null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[3]	4-5/1.html	\N	1
801	hu		null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[4]	4-5/1.html	\N	1
802	hidup	（生きる）	null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-5/1.html	\N	1
803	hujan	（雨）	null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-5/1.html	\N	1
804	hilang	（消える）	null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[3]	4-5/1.html	\N	1
805	suhu	（温度）	null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[4]	4-5/1.html	\N	1
806	pahit	（苦い）	null		\N	pmod	page033.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[5]	4-5/1.html	\N	1
807	hutang	(hutang)	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	4-6/1.html	\N	1
808	hutang	(utang)	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	4-6/1.html	\N	1
809	tahu	(tau: 知っている)	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[1]	4-6/1.html	\N	1
810	tahu	(tahu: 豆腐)	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[2]/pmod:examples[1]/pmod:example[2]	4-6/1.html	\N	1
811	hutan（→hutan）	（森）	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[1]	4-6/1.html	\N	1
812	hutan（→utan）	（森）	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[2]	4-6/1.html	\N	1
813	boleh（→boleh）	（～してもよい）	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[3]	4-6/1.html	\N	1
814	boleh（→bole）	（～してもよい）	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[4]	4-6/1.html	\N	1
815	tahu（→tau）	（知っている）	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[5]	4-6/1.html	\N	1
816	tahu（→tahu）	（豆腐）	null		\N	pmod	page034.xml	/pmod:page[1]/pmod:block[3]/pmod:examples[1]/pmod:example[6]	4-6/1.html	\N	1
818	pergi	出掛ける	\N		\N	vmod	\N	\N	\N	0	1
819	menyenangkan	楽しい	\N		\N	vmod	\N	\N	\N	0	1
820	Apakah Anda pernah pergi ke luar negeri?	外国へ行ったことはありますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
821	Banyak orang asing tinggal di kota ini.	この町にはたくさんの外国人が住んでいる。	\N	\N	\N	vmod	\N	\N	\N	0	1
822	Dia memesan kamar hotel di Kyoto.	彼は京都のホテルを予約した。	\N	\N	\N	vmod	\N	\N	\N	0	1
823	Ada empat musim di negeri ini.	この国には4つの季節がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
824	Saya datang ke Indonesia dalam rangka pariwisata.	私は旅行でインドネシアへ来た。	\N		\N	vmod	\N	\N	\N	0	1
825	Banyak turis berpariwisata ke Pulau Bali.	多くの観光客がバリ島へ旅行する。	\N		\N	vmod	\N	\N	\N	0	1
826	Kami harus pergi ke Kedutaan Besar untuk mengambil visa.	私たちはビザを取得するために大使館に行かなければならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
827	Penyanyi itu cantik. Saya suka sekali.	あの歌手は美しい。私は大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
828	Dia pasti berlari pagi setiap hari.	彼は毎朝必ず走っている。	\N		\N	vmod	\N	\N	\N	0	1
829	Kami harus berbicara perlahan-lahan di hadapan orang yang tua.	年配の人たちの前ではゆっくりと話さなければならない。	\N		\N	vmod	\N	\N	\N	0	1
830	Saya tidak pintar berbahasa Indonesia.	私はインドネシア語が上手ではない。	\N		\N	vmod	\N	\N	\N	0	1
831	Dia berjalan kaki ke stasiun.	彼女は歩いて駅へ行く。	\N		\N	vmod	\N	\N	\N	0	1
832	Kuda itu bisa melompat palang setinggi 1 meter.	あの馬は1メートルのバーを跳ぶことができる。	\N	\N	\N	vmod	\N	\N	\N	0	1
833	Saya sering menonton olahraga dengan teman-teman.	僕はよく友達と一緒にスポーツを観戦する。	\N		\N	vmod	\N	\N	\N	0	1
834	Anak-anak biasanya tidak suka minum obat.	子どもたちは普通薬を飲むのが好きではない	\N		\N	vmod	\N	\N	\N	0	1
835	Waktu kecil, kami sering pergi ke kolam renang.	小さい頃、私たちはよくプールへ行った。	\N		\N	vmod	\N	\N	\N	0	1
836	Saya jarang naik bus.	私はめったにバスに乗らない。	\N		\N	vmod	\N	\N	\N	0	1
837	Dia naik sepeda ke sekolah.	彼は自転車で学校へ行く。	\N		\N	vmod	\N	\N	\N	0	1
838	Belok kanan di persimpangan itu.	その交差点を右折してください。	\N		\N	vmod	\N	\N	\N	0	1
839	Mereka sering memancing ikan di kolam itu.	彼らはよくその池で魚釣りをする。	\N		\N	vmod	\N	\N	\N	0	1
840	Jalan-jalan baik untuk kesehatan.	散歩は健康によい。	\N	\N	\N	vmod	\N	\N	\N	0	1
841	Ada sungai di dekat rumah saya.	私の家の近くに川がある。	\N		\N	vmod	\N	\N	\N	0	1
842	Saya melambaikan tangan untuk memanggil taksi.	タクシーを捕まえるために手を振った。	\N		\N	vmod	\N	\N	\N	0	1
843	Keluarga saya berangkat ke Osaka dengan mobil.	私の家族は車で大阪へ行った。	\N		\N	vmod	\N	\N	\N	0	1
844	Tiang listrik itu bengkok karena tertabrak truk.	トラックにぶつけられてあの電柱は曲がっている。	\N		\N	vmod	\N	\N	\N	0	1
845	Kakak saya memberikan dasi baru kepada ayahnya.	姉は父に新しいネクタイを買ってあげた。	\N		\N	vmod	\N	\N	\N	0	1
846	Kemeja ini terlalu kecil untuk saya.	このワイシャツは私には小さすぎる。	\N		\N	vmod	\N	\N	\N	0	1
847	Dia bekerja sebagai pegawai perusahaan.	彼は会社員として働いている。	\N		\N	vmod	\N	\N	\N	0	1
848	Laki-laki itu memakai setelan jas berwarna cokelat.	その男性は茶色のスーツを着ている。	\N		\N	vmod	\N	\N	\N	0	1
849	Kupu-kupu mengisap sari bunga.	蝶は花の蜜を吸う。	\N		\N	vmod	\N	\N	\N	0	1
851	Dia harus menyelesaikan pekerjaan ini sampai besok.	彼女は明日までにこの仕事を終わらせなければならない。	\N		\N	vmod	\N	\N	\N	0	1
852	Anda bekerja di mana?	君はどこで働いてるの。	\N		\N	vmod	\N	\N	\N	0	1
853	Ayah saya membaca surat kabar setiap pagi.	父は毎朝新聞を読む。	\N		\N	vmod	\N	\N	\N	0	1
854	Inilah fotokopi resep yang saya tulis.	これが、私が書いたレシピのコピーです。	\N		\N	vmod	\N	\N	\N	0	1
855	Boleh saya memfotokopi buku ini?	この本をコピーしてもいいですか。	\N		\N	vmod	\N	\N	\N	0	1
856	Dia membeli majalah sebulan sekali.	彼女は月に一回雑誌を買う。	\N		\N	vmod	\N	\N	\N	0	1
857	Buku seri ini terdiri dari tiga jilid.	このシリーズ本は３冊で成り立っている。	\N		\N	vmod	\N	\N	\N	0	1
858	Ibu saya membeli daging sapi untuk membuat kari.	母はカレーを作るために牛肉を買った。	\N		\N	vmod	\N	\N	\N	0	1
859	Harga barang di negeri itu lebih murah daripada di negeri saya.	その国の物価は日本よりも安い。	\N		\N	vmod	\N	\N	\N	0	1
860	Buah ini disebut apa dalam bahasa Indonesia?	この果物はインドネシア語で何と言いますか。	\N		\N	vmod	\N	\N	\N	0	1
861	Orang Jepang suka makan sayur mentah.	日本人は生野菜を食べるのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
862	Penganut agama Islam tidak boleh makan daging babi.	イスラム教徒は豚肉を食べてはならない。	\N		\N	vmod	\N	\N	\N	0	1
863	Orang muda lebih suka makan daging daripada ikan.	若者は魚よりも肉が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
864	Dia memberi hadiah kepada pacarnya.	彼女は恋人にプレゼントをあげた。	\N		\N	vmod	\N	\N	\N	0	1
865	Kalau Anda belok kanan di jalan itu, ada toko sayur di sebelah kiri jalan.	その道を右に曲がると、左側に八百屋があります。	\N		\N	vmod	\N	\N	\N	0	1
866	Adik saya sering kehilangan kunci.	私の妹はよく鍵をなくす。	\N		\N	vmod	\N	\N	\N	0	1
867	Karena sakit, dia tidak bisa berbelanja hari ini.	病気のため彼女は今日買い物に行けない。	\N		\N	vmod	\N	\N	\N	0	1
868	Karena kotor, saya harus mencuci sepatu saya.	汚れたので靴を洗わなければならない。	\N	\N	\N	vmod	\N	\N	\N	0	1
869	Saya sudah membersihkan kamar saya.	私はもう自分の部屋を掃除した。	\N		\N	vmod	\N	\N	\N	0	1
870	Pada hari Minggu saya akan berangkat ke pantai dengan keluarga.	日曜日に僕は家族と海へ行く予定だ。	\N		\N	vmod	\N	\N	\N	0	1
871	Setiap hari Ibu Rini mengerjakan banyak pekerjaan rumah tangga.	毎日リニさんはたくさんの家事をこなしている。	\N		\N	vmod	\N	\N	\N	0	1
872	Di rumah saya tidak ada kebun.	私の家には庭がない。	\N		\N	vmod	\N	\N	\N	0	1
873	Program pembersihan lingkungan akan diadakan di kampung kami.	環境クリーン計画が我々の村で行われる予定だ。	\N		\N	vmod	\N	\N	\N	0	1
874	Kembalikanlah buku-buku yang sudah Anda baca ke rak buku.	読んだ本は本棚に返しましょう。	\N		\N	vmod	\N	\N	\N	0	1
875	Tolong pindahkan meja itu ke sana.	その机をそっちに移して下さい。	\N		\N	vmod	\N	\N	\N	0	1
876	Boleh saya duduk di kursi ini?	ここのいすに座ってもいいですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
877	Saya mau kulkas baru.	私は新しい冷蔵庫が欲しい。	\N		\N	vmod	\N	\N	\N	0	1
878	Sebelum memasak, Anda harus mencuci tangan.	料理をする前には手を洗わなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
879	Kemarin saya jatuh dari tempat tidur, sehingga tangan saya terluka.	昨日ベットから落ちて手を怪我した。	\N		\N	vmod	\N	\N	\N	0	1
880	Dia mendengarkan radio setiap malam.	彼は毎晩ラジオを聴く。	\N		\N	vmod	\N	\N	\N	0	1
881	Akhir-akhir ini kami jarang menggunakan tep untuk meputar lagu.	最近私たちはめったにカセットを使って音楽を聴かない。	\N		\N	vmod	\N	\N	\N	0	1
882	Orang yang datang dari Indonesia itu bernama Budi.	インドネシアから来たその人はブディという名前だ。	\N		\N	vmod	\N	\N	\N	0	1
883	Karena besok hari Minggu, Anda tidak usah bangun pagi-pagi.	明日は日曜日なので早く起きる必要はない。	\N		\N	vmod	\N	\N	\N	0	1
884	Makan siang sudah disiapkan di atas meja.	昼ごはんがテ－ブルの上にもう用意されている。	\N	\N	\N	vmod	\N	\N	\N	0	1
885	Jangan menonton televisi sampai tengah malam.	夜遅くまでテレビを見てはいけません。	\N		\N	vmod	\N	\N	\N	0	1
886	Anda lebih baik bertanya kepada polisi.	お巡りさんに尋ねたほうがいいですよ。	\N		\N	vmod	\N	\N	\N	0	1
887	Hari ini banyak polisi mengelilingi rumah itu.	今日、大勢の警察がその家を囲っている。	\N		\N	vmod	\N	\N	\N	0	1
889	Di pos polisi, mereka menyerahkan dompet yang mereka temukan di jalan.	彼らは道で見つけた財布を交番に届けた。	\N		\N	vmod	\N	\N	\N	0	1
890	Di dekat universitas kami akan segera dibuka restoran Korea.	私たちの大学の近くに、もうすぐ韓国レストランができる。	\N		\N	vmod	\N	\N	\N	0	1
891	Kemarin saya memotong rambut saya sendiri.	昨日私は自分で髪の毛を切った。	\N		\N	vmod	\N	\N	\N	0	1
892	Wanita yang rambutnya pendek itu siapa?	あの髪の短い女性は誰ですか。	\N		\N	vmod	\N	\N	\N	0	1
893	Coba lihat ke arah kanan.	右の方をご覧ください。	\N		\N	vmod	\N	\N	\N	0	1
894	Luka di kaki kiri saya terasa sakit sekali.	左足の傷がとても痛む。	\N		\N	vmod	\N	\N	\N	0	1
895	Boleh saya duduk di sini?	ここに座ってもよろしいですか。	\N		\N	vmod	\N	\N	\N	0	1
896	Anak itu sudah bisa berdiri.	あの子はもう立てる。	\N		\N	vmod	\N	\N	\N	0	1
897	Bagaimana kelas baru Anda?	君の新しいクラスはどう？	\N		\N	vmod	\N	\N	\N	0	1
898	Ruang kelas itu kecil sukali.	その教室はとても小さい。	\N		\N	vmod	\N	\N	\N	0	1
899	Tidak boleh berlari-lari di koridor.	廊下を走ってはいけません。	\N		\N	vmod	\N	\N	\N	0	1
900	Saya terlambat masuk sekolah karena kesiangan.	寝坊したので学校に遅刻した。	\N		\N	vmod	\N	\N	\N	0	1
901	Murid itu sering bertanya kepada guru.	その生徒はよく先生に質問する。	\N		\N	vmod	\N	\N	\N	0	1
902	Saya tidak suka pelajaran matematika.	私は数学の勉強が好きではない。	\N		\N	vmod	\N	\N	\N	0	1
903	Tahun ini saya tidak akan ke mana-mana selama liburan musim panas.	今年の夏休みはどこへも行かない。	\N		\N	vmod	\N	\N	\N	0	1
1013	Saya mempunyai tujuh saudara sepupu.	私には７人のいとこがいます。	\N	\N	\N	vmod	\N	\N	\N	0	1
904	Buku catatan kuliah ini tertinggal di ruang kelas tadi.	この講義用のノートをさっきの教室に置いてきてしまった。	\N		\N	vmod	\N	\N	\N	0	1
905	Kami harus menulis karangan sampai dengan hari Senin minggu depan.	私たちは来週の月曜日までに作文を書かなければならない。	\N		\N	vmod	\N	\N	\N	0	1
906	Saya sudah menyelesaikan pekerjaan rumah.	私はもう宿題をやり終えた。	\N		\N	vmod	\N	\N	\N	0	1
907	Dulu kakak saya mengajar matematika.	私の兄は以前数学を教えていた。	\N		\N	vmod	\N	\N	\N	0	1
908	Ujian hari ini mudah bagi saya.	今日のテストは僕には簡単だった。	\N		\N	vmod	\N	\N	\N	0	1
909	Anak itu berlatih menulis huruf kanji.	その子供は漢字を書く練習をしている。	\N		\N	vmod	\N	\N	\N	0	1
910	Soal ini sulit, jadi saya perlu bantuan Anda.	この問題は難しい。なので、あなたの助けが必要だ。	\N		\N	vmod	\N	\N	\N	0	1
911	Apakah Anda bisa menjawab pertanyaan itu?	あなたはその質問に答えられますか。	\N		\N	vmod	\N	\N	\N	0	1
912	Gosoklah gigi menjelang tidur.	寝る前に歯を磨きましょう。	\N		\N	vmod	\N	\N	\N	0	1
913	Tolong antarkan saya ke rumah sakit.	私を病院に連れて行ってください。	\N		\N	vmod	\N	\N	\N	0	1
914	Dia menderita bermacam-macam penyakit.	彼女はいろいろな病気を患っている。	\N		\N	vmod	\N	\N	\N	0	1
915	Anjing kesayanganku mati kemarin.	僕の愛犬が昨日死んだ。	\N		\N	vmod	\N	\N	\N	0	1
916	Flu burung sedang merajalela di daerah itu.	その地域では鳥インフルエンザが流行っている。	\N		\N	vmod	\N	\N	\N	0	1
917	Saya sakit perut karena makan banyak.	たくさん食べたのでお腹が痛い。	\N		\N	vmod	\N	\N	\N	0	1
918	Suhu badan saya rata-rata 36.2 derajat Celcius.	私の平均体温はだいたい36.2度くらいです。	\N		\N	vmod	\N	\N	\N	0	1
919	Sekarang lift ini sedang rusak.	現在このエレベーターは壊れている。	\N		\N	vmod	\N	\N	\N	0	1
920	Apakah Anda sudah membeli karcis kereta?	もう電車のチケットは買いましたか。	\N		\N	vmod	\N	\N	\N	0	1
921	Pemilik toko itu cepat menutup toko setiap malam.	あの店の主人は毎晩早くに店を閉める。	\N		\N	vmod	\N	\N	\N	0	1
922	Saya mau turun di Stasiun Shinjuku.	私は新宿駅で降ります。	\N		\N	vmod	\N	\N	\N	0	1
923	Anda lebih baik pergi dengan kereta bawah tanah.	地下鉄を使って行った方がいいですよ。	\N		\N	vmod	\N	\N	\N	0	1
924	Dia membuka jendela untuk memasukkan udara segar.	彼女は新鮮な空気を入れるために窓を開けた。	\N		\N	vmod	\N	\N	\N	0	1
925	Dia belum kembali dari kamar kecil.	彼女はまだお手洗いから戻ってこない。	\N		\N	vmod	\N	\N	\N	0	1
927	Kereta listrik ini selalu penuh.	この電車はいつも混んでいる。	\N		\N	vmod	\N	\N	\N	0	1
928	Sudah memesan minuman dan makanan?	もう飲み物と食べ物を注文しましたか。	\N		\N	vmod	\N	\N	\N	0	1
929	Mereka sering mengobrol di warung kopi ini.	彼らはよくこの喫茶店でおしゃべりしている。	\N		\N	vmod	\N	\N	\N	0	1
930	Saya mau minum teh sitrun.	私はレモンティーが飲みたい。	\N		\N	vmod	\N	\N	\N	0	1
931	Setiap hari saya minum teh hijau 5 cangkir atau lebih.	毎日、私は５杯以上緑茶を飲みます。	\N		\N	vmod	\N	\N	\N	0	1
932	Anda mau minum teh atau kopi?	紅茶かコーヒー、どちらが飲みたいですか。	\N		\N	vmod	\N	\N	\N	0	1
933	Karena haus, dia minum tiga gelas air.	のどが渇いたので、彼女は３杯水を飲んだ。	\N		\N	vmod	\N	\N	\N	0	1
934	Dia tidak memasukkan gula ke dalam kopi.	彼はコーヒーに砂糖を入れない。	\N		\N	vmod	\N	\N	\N	0	1
935	Jeruk ini sangat manis dan enak.	このオレンジはとても甘くておいしい。	\N		\N	vmod	\N	\N	\N	0	1
936	Anda bisa memakai sumpit?	あなたはお箸が使えますか。	\N		\N	vmod	\N	\N	\N	0	1
937	Dia berhenti minum minuman keras setelah dinasihati dokter.	彼は医者に忠告されてお酒を飲むのをやめた。	\N		\N	vmod	\N	\N	\N	0	1
938	Silakan pakai pisau ini untuk memotong daging.	肉を切るのにこのナイフをお使いください。	\N		\N	vmod	\N	\N	\N	0	1
939	Anak saya belum bisa makan dengan pisau dan garpu.	私のこどもはまだナイフとフォークを使って食べることができない。	\N		\N	vmod	\N	\N	\N	0	1
940	Kemarin saya membuat kue keju dengan kakak saya.	昨日私は姉と一緒にチーズケーキを作った。	\N		\N	vmod	\N	\N	\N	0	1
941	Sayur ini tidak enak karena tidak segar.	この野菜は新鮮でないのでおいしくない。	\N		\N	vmod	\N	\N	\N	0	1
942	Toko roti itu buka pagi-pagi.	そのパン屋は朝早くから開いている。	\N		\N	vmod	\N	\N	\N	0	1
943	Dia suka makanan pedas.	彼女は辛い料理が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
944	Restoran itu sangat populer, tetapi harganya mahal.	そのレストランは有名だが値段が高い。	\N		\N	vmod	\N	\N	\N	0	1
945	Mari kita makan siang di kantin.	食堂でお昼ご飯を食べよう。	\N		\N	vmod	\N	\N	\N	0	1
946	Anda suka minum anggur?	ワインは好きですか。	\N		\N	vmod	\N	\N	\N	0	1
947	Hari ini saya akan memasak kari.	今日私はカレーを作るつもりだ。	\N		\N	vmod	\N	\N	\N	0	1
948	Anto menabung uang di bank swasta.	アントは民営銀行に預金している。	\N		\N	vmod	\N	\N	\N	0	1
949	Silakan masuk.	どうぞお入りください。	\N	\N	\N	vmod	\N	\N	\N	0	1
950	Di mana pintu keluar?	出口はどこですか。	\N		\N	vmod	\N	\N	\N	0	1
951	Pukul enam pagi kami akan sampai di situ.	我々は六時にそこに着くでしょう。	\N		\N	vmod	\N	\N	\N	0	1
952	Anda bisa membeli kartu pos di kantor pos.	郵便局ではがきを買うことができますよ。	\N		\N	vmod	\N	\N	\N	0	1
953	Kami mohon izin menempelkan stiker ini di sini.	ここにこのステッカーを貼らせて頂きたいのですが。	\N		\N	vmod	\N	\N	\N	0	1
954	Tolong masukkan surat ke dalam amplop.	手紙を封筒に入れてください。	\N		\N	vmod	\N	\N	\N	0	1
955	Saya mengirim kartu pos kepada teman yang tinggal di Osaka.	私は大阪に住んでいる友達にはがきを送った。	\N		\N	vmod	\N	\N	\N	0	1
956	Jangan lupa menempelkan perangko pada amplop.	封筒に切手を貼るのを忘れないように。	\N		\N	vmod	\N	\N	\N	0	1
957	Mohon titipkan barang Anda di sini.	ここにあなたの荷物を預けてください。	\N		\N	vmod	\N	\N	\N	0	1
958	Anda mau berapa helai kertas?	紙、何枚ほしいですか。	\N		\N	vmod	\N	\N	\N	0	1
960	Anak itu membeli sari buah dalam kaleng di mesin penjualan otomatis.	その子供は自動販売機で缶ジュースを買っている。	\N		\N	vmod	\N	\N	\N	0	1
961	Pakailah topi karena hari ini sangat panas.	今日はとても暑いので帽子をかぶりましょう。	\N		\N	vmod	\N	\N	\N	0	1
962	Mereka itu belanjanya di pasar saja.	あいつらは、買い物は市場でするだけだ。	\N		\N	vmod	\N	\N	\N	0	1
963	Bermacam-macam barang dijual di toko serba ada.	いろいろな商品がデパートで売られている。	\N		\N	vmod	\N	\N	\N	0	1
964	Dia jarang memakai rok yang berwarna hitam.	彼女はめったに黒色のスカートをはかない。	\N		\N	vmod	\N	\N	\N	0	1
965	Hari ini ayah saya pergi ke kantor dengan memakai jas.	今日父はコートを着て会社に行った。	\N		\N	vmod	\N	\N	\N	0	1
966	Saya suka memakai celana pendek.	私はよく半ズボンをはく。	\N		\N	vmod	\N	\N	\N	0	1
967	Apakah Anda bisa merajut sweter?	あなたはセーターを編めますか。	\N		\N	vmod	\N	\N	\N	0	1
968	Apa saja yang dijual di toko itu?	その店では何が売られていますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
969	Saya memakai jas karena merasa dingin.	寒くなったので上着を着た。	\N		\N	vmod	\N	\N	\N	0	1
970	Kamar mandi ada di sebelah kamar kecil.	浴室はトイレのとなりにある。	\N		\N	vmod	\N	\N	\N	0	1
971	Ibu saya memasak di dapur.	母が台所で料理をしている。	\N		\N	vmod	\N	\N	\N	0	1
972	Sekarang shower itu rusak.	今、そのシャワーは壊れている。	\N		\N	vmod	\N	\N	\N	0	1
973	Boleh saya membuka jendela?	窓を開けてもいいですか。	\N		\N	vmod	\N	\N	\N	0	1
974	Anak-anak bermain sepak bola di taman.	子供たちが公園でサッカーをしている。	\N		\N	vmod	\N	\N	\N	0	1
975	Seseorang mengetuk pintu.	誰かがドアをノックした。	\N	\N	\N	vmod	\N	\N	\N	0	1
976	Dia menyewa apartemen selama dua tahun.	彼は2年間アパートを借りている。	\N	\N	\N	vmod	\N	\N	\N	0	1
977	Tolong masuk dari pitu masuk.	入り口からお入りください。	\N	\N	\N	vmod	\N	\N	\N	0	1
978	Mereka berangkat ke mana tadi?	彼らはさっきどこに出かけたのですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
979	Mengapa kamar ini masih kotor begini?	どうしてこの部屋はまだこんなに汚いのか。	\N	\N	\N	vmod	\N	\N	\N	0	1
980	Cobalah bertanya kepada diri sendiri, apakah kita selalu benar.	我々がいつも正しいのだろうか、と自分自身に問い尋ねてみましょう。	\N	\N	\N	vmod	\N	\N	\N	0	1
981	Saya harus membaca buku yang tebal ini selama liburan musim panas ini.	私はこの夏休み中にこの分厚い本を読まなければならない。	\N		\N	vmod	\N	\N	\N	0	1
982	Karena jalan itu sempit, mobil tidak bisa masuk.	道路が狭いので車が入れない。	\N	\N	\N	vmod	\N	\N	\N	0	1
983	Wanita itu sangat kurus.	あの女性はとてもスリムだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
984	Tulislah huruf ini dengan menggunakan garis tebal.	この文字は太線を使って書きなさい。	\N		\N	vmod	\N	\N	\N	0	1
985	Acara televisi ini sangat populer di kalangan orang muda.	このテレビ番組は若い人たちの間で大変人気がある。	\N	\N	\N	vmod	\N	\N	\N	0	1
986	Bapak Yamada mempunyai tanah yang luas.	山田氏は広い土地を持っている。	\N	\N	\N	vmod	\N	\N	\N	0	1
987	Saya mau memakai sepatu yang lebih ringan.	僕はもっと軽い靴を買いたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
988	Apakah rumah Anda jauh dari sini?	あなたの家はここから遠いですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
989	Saya tidak mau membawa barang yang berat.	私は重い荷物は持ちたくない。	\N	\N	\N	vmod	\N	\N	\N	0	1
990	Majalah yang tipis ini milik siapa?	この薄い雑誌は誰のですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
991	Saya mau yang lebih kecil.	もっと小さいのが欲しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
992	Apakah rumah Anda dekat dari sekolah?	あなたの家は学校から近いですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
993	Kemarin saya makan malam dengan teman-teman lama.	昨日私は古い友人たちと一緒に夕飯を食べた。	\N	\N	\N	vmod	\N	\N	\N	0	1
994	Daerah ini sangat ramai karena hari ini diadakan festival.	今日はお祭りが行われているので、この地域はとてもにぎやかだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
995	Tinggi badan saya lebih rendah daripada adik saya.	私の身長は妹よりも低い。	\N	\N	\N	vmod	\N	\N	\N	0	1
996	Dia itu tenaganya lemah, tetapi mentalnya sangat kuat.	あいつは力は弱いが、心はとても強い。	\N		\N	vmod	\N	\N	\N	0	1
997	Tim itu sangat kuat dan belum pernah kalah dalam pertandingan.	そのチームはとても強くてまだ試合で負けたことがない。	\N	\N	\N	vmod	\N	\N	\N	0	1
998	Kamar ini bersih.	この部屋はきれいだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
999	Nilai ujiannya buruk karena dia tidak belajar.	彼は勉強していなかったので、テストの成績が悪かった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1000	Lebih baik tidak berjalan di jalan gelap.	暗い道は歩かないほうがいい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1001	Teman saya berkata bahwa daerah itu tenang dan indah.	私の友人は、この地域は静かで美しいところだと言っていました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1002	Saya mau mencuci tangan dulu karena tangan saya kotor.	手が汚れたのでまず洗いたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1003	Saya sudah bosan menonton film ini.	この映画はもう見飽きた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1004	Sawah ini lebarnya berapa meter?	この田んぼの幅はどれくらいですか。	\N		\N	vmod	\N	\N	\N	0	1
1005	Kemarin saya tidak pergi ke luar.	昨日は外出していません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1006	Matahari terbit di timur.	太陽は東から昇る。	\N	\N	\N	vmod	\N	\N	\N	0	1
1007	Tinggi badan saya kira-kira 160 cm.	私の身長は約160センチメートルです。	\N		\N	vmod	\N	\N	\N	0	1
1008	Gambarlah persegi panjang yang panjangnya 5cm dan lebarnya 10cm.	縦５センチメートル横10センチメートルの長方形を描きましょう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1009	Kota Bandung adalah ibukota Provinsi Jawa Barat.	バンドゥンは西ジャワ州の州都である。	\N		\N	vmod	\N	\N	\N	0	1
1010	Ada sesuatu di bawah meja.	机の下に何かあります。	\N		\N	vmod	\N	\N	\N	0	1
1011	Dosen pembimbing saya berasal dari Sulawesi Selatan.	私の指導教官は南スラウェシ出身です。	\N		\N	vmod	\N	\N	\N	0	1
1012	Rumah saya ada di belakang bengkel mobil.	私の家は車の修理工場の裏にあります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1014	Kakak laki-laki saya malas sekali sehingga tinggal kelas.	私の兄は怠慢すぎて留年しました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1015	Kakek itu suka menyanyi lagu Bengawan Solo.	あのおじいさんはブンガワン・ソロを歌うのが好きです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1016	Nyonya Duta Besar juga hadir dalam acara itu.	大使の奥さんもそのイベントに出席していた。	\N		\N	vmod	\N	\N	\N	0	1
1017	Paman saya mempekerjakan lebih dari 30 orang di kebun tehnya.	私のおじは茶畑で３０人以上の人を雇っています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1018	Dia dimarahi ayahnya karena pulang malam-malam.	彼女は夜遅くに帰ったのでお父さんに怒られました。	\N		\N	vmod	\N	\N	\N	0	1
1019	Kedua kakak perempuan saya sedang mengandung.	私の姉は二人とも妊娠中です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1020	Bibi saya pintar menari.	私のおばは踊りが得意です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1021	Anak itu menangis karena merasa kehilangan kakaknya.	その子供はお兄さんがいなくなったのを感じて泣きました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1022	Dia dimarahi ayahnya karena pulang malam-malam.	彼女は夜遅くに帰ったのでお父さんに怒られました。	\N		\N	vmod	\N	\N	\N	0	1
1023	Dia selalu mengenakan kaus kaki yang berwarna-warni.	彼女はいつも色とりどりの靴下をはいている。	\N		\N	vmod	\N	\N	\N	0	1
1024	Saya masuk angin karena tidur tanpa memakai kaus.	私はシャツを着ずに寝たので風邪を引きました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1025	Jangan membuka sepatu di sini.	ここで靴を脱がないでください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1026	Kamu bisa menggantungkan bajumu di situ.	そこに服を架けておいていいですよ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1027	Anak yang memakai celana pendek ini bernama Abi.	この短パンをはいている子供はアビといいます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1028	Anda harus mengenakan sabuk pengaman selama Anda duduk.	座っている間はシートベルトを着用しなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1029	Ria selalu memakai jilbab berwarna merah muda.	リアはいつもピンク色のジルバブをかぶっています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1030	Sapu tangan bergambar sakura ini oleh-oleh dari Jepang.	この桜の柄のハンカチは日本からのお土産です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1031	Harap menggunakan selop di dalam ruang ini.	この部屋ではスリッパをお使いください。	\N		\N	vmod	\N	\N	\N	0	1
1032	Sedia payung sebelum hujan.	雨が降る前に傘を用意する（転ばぬ先の杖）。	\N	\N	\N	vmod	\N	\N	\N	0	1
1033	Saku celana saya berlubang.	私のズボンのポケットは穴が開いています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1034	Dompet saya dicopet di jalan.	私は道で財布をすられました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1035	Dia selalu berpakaian seksi.	彼女はいつもセクシーな服を着ています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1036	Kamu tunggu sebentar di sini. Saya berganti pakaian dulu.	ここでちょっと待っててね。服を着替えちゃうから。	\N	\N	\N	vmod	\N	\N	\N	0	1
1037	Dia tidak membeli pakaian selain waktu obral.	彼は安売りのとき以外は洋服を買いません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1038	Manis di mulut, jahat di hati.	口では甘いことを言うが心は悪である。	\N	\N	\N	vmod	\N	\N	\N	0	1
1039	Lengan saya digigit nyamuk.	私は腕を蚊に刺されました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1040	Lebih baik tidur cepat biar besok badannya enak.	明日、体が楽なように早く寝た方がいいですよ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1041	Mukanya tidak begitu cantik, tetapi suaranya merdu sekali.	顔はそれほどきれいではないが、声はとても美しい。	\N		\N	vmod	\N	\N	\N	0	1
1042	Kaki saya sakit. Saya mau dipijat.	あしが痛いです。マッサージをお願いします。	\N	\N	\N	vmod	\N	\N	\N	0	1
1043	Masuk ke telinga kanan, keluar dari telinga kiri.	右の耳から入って左の耳へ抜ける（馬耳東風）。	\N	\N	\N	vmod	\N	\N	\N	0	1
1044	Kaki Anda ukurannya berapa?	足のサイズはいくつですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1045	Dia itu perutnya besar karena selalu kebanyakan makan.	あいつはいつも食べすぎなのでお腹が大きい。	\N		\N	vmod	\N	\N	\N	0	1
1046	Ayo, ambil piring. Kita makan!	さあ、お皿を持ってきて。食べましょう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1047	Masukkan mentega yang sudah dilumerkan.	溶かしたバターを入れます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1048	Ada dua cangkir di meja itu.	その机の上に２つの茶わんがあります。	\N		\N	vmod	\N	\N	\N	0	1
1049	Permen jahe baik untuk kerongkongan.	しょうが飴はのどにいいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1050	Tidak boleh menghindari makan malam untuk menurunkan berat badan.	体重を落とすために夕飯を抜いてはいけません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1051	Kalau tidak makan pagi, mahasiswa tidak bisa belajar dengan baik.	朝食を食べなければ、学生はよく勉強できません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1052	Di Indonesia terdapat dua jenis kecap, yaitu kecap asin dan kecap manis.	インドネシアには２種類のケチャップ、すなわち、ケチャップ・アシンとケチャップ・マニスがあります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1053	Besok saya diajak makan malam oleh Kak Tomo.	明日、私はトモさんに晩御飯に誘われています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1054	Orang tua saya akan menambah uang saku saya tahun ini.	両親が今年の私のお小遣いを上げてくれます。	\N		\N	vmod	\N	\N	\N	0	1
1056	Kamera ini canggih sekali, ya.	このカメラはとても高性能ですね。	\N		\N	vmod	\N	\N	\N	0	1
1057	Hotel ini dilengkapi dengan pemanas ruangan di setiap kamarnya.	このホテルはすべての部屋に暖房が備えられている。	\N		\N	vmod	\N	\N	\N	0	1
1058	Tini sudah bisa memegang pensil secara benar.	ティニはもうちゃんと鉛筆がもてます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1059	Lebih baik mematikan televisi pada saat jam belajar anak.	子供の勉強時間にはテレビを消した方がいいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1060	Saya merasa terganggu dengan kacamata atau lensa kontak.	眼鏡やコンタクトレンズをするのは煩わしいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1061	Tep model ini sudah menjadi barang antik.	このモデルのテープはもう骨董品となっている。	\N		\N	vmod	\N	\N	\N	0	1
1062	Di sini jam seperti itu sudah ketinggalan zaman.	ここではそのような腕時計はもう時代遅れですよ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1112	Menurut ramalan cuaca, besok cerah.	天気予報によると明日は晴れます。	\N		\N	vmod	\N	\N	\N	0	1
1063	Pada saat ini komputer seolah menjadi sebuah kebutuhan pokok bagi siapa saja.	現在、コンピュータは誰もの必需品となっているようである。	\N		\N	vmod	\N	\N	\N	0	1
1064	Saya mau film ASA 400, 36 lembar.		\N		\N	vmod	\N	\N	\N	0	1
1065	Kalau Buka Pintu, Harap Tutup Lagi.	戸を開けたら、また閉めてください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1066	Dia meminta dibukakan pintu karena membawa banyak barang.	彼はたくさん物を持っていたので、門を開けてくれるよう頼みました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1067	Boleh saya pinjam pulpen sebentar?	ちょっとペンを借りてもいいですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1068	Pulpen ini dibeli nenek saya sebagai hadiah ulang tahun saya.	この万年筆はおばあさんが私の誕生日プレゼントに買ってくれました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1069	Formulir ini diisi dengan bolpoin bertinta hitam.	この申請書は黒インクのボールペンで書いてください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1070	PR ini harus dikumpulkan dalam bulan ini.	この宿題は今月中に提出しなければなりません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1071	Setiap bulan saya menabung 20,000 yen.	毎月、私は２万円貯金します。	\N	\N	\N	vmod	\N	\N	\N	0	1
1072	Pada bulan Desember kota-kota menjadi ramai dengan berbagai hiasan hari Natal.	１２月になると街はクリスマスの様々な飾りでにぎやかになります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1073	Hari ulang tahun saya tanggal 17 Februari.	私の誕生日は２月１７日です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1074	Sampai akhir bulan depan saya sibuk bekerja.	来月の終わりまで、私は仕事で忙しいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1075	Saat gempa 27 Mei 2006 terjadi, saya berada di Boyolali.	２００６年５月２７日の地震が起きたとき、私はボヨラリにいました。	\N		\N	vmod	\N	\N	\N	0	1
1076	Saya akan datang ke sini lagi, selambat-lambatnya bulan Maret.	遅くとも３月にはまたここに来ます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1077	Kakak saya menikah bulan yang lalu.	姉は先月結婚しました。	\N		\N	vmod	\N	\N	\N	0	1
1078	Festival TUFS diadakan pada bulan November.	外語祭は１１月に行われます。	\N		\N	vmod	\N	\N	\N	0	1
1079	Sepanjang bulan September saya berlibur di Pulau Lombok.	９月中ずっと、私はロンボク島を旅行していました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1080	Sejak sebulan terakhir kakak saya sukses menghindari merokok.	ひとつき前から私の兄は禁煙に成功しています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1081	Sudah enam tahun saya tidak bertemu dengan adik saya.	もう６年も妹に会っていません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1082	Tahun ini saya tidak sempat mengujungi kota Bandung.	今年はバンドゥンの町を訪れる機会がありませんでした。	\N	\N	\N	vmod	\N	\N	\N	0	1
1083	Universitas ini setiap tahun menerima mahasiswa baru dari Indonesia.	この大学は毎年、インドネシアから新しい留学生を受け入れている。	\N		\N	vmod	\N	\N	\N	0	1
1084	Pada musim panas udara di Tokyo terasa lebih panas daripada di Jakarta.	夏には東京の気温はジャカルタよりも暑く感じます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1085	Selama musim dingin ini, salju belum pernah turun hingga sekarang.	この冬の間、今までのところまだ雪が降っていない。	\N		\N	vmod	\N	\N	\N	0	1
1086	Saya menari tari Pendet di pesta tahun yang lalu.	去年のパーティーではペンデットを踊りました。	\N		\N	vmod	\N	\N	\N	0	1
1087	Tahun depan saya akan belajar di Universitas Indonesia.	来年、私はインドネシア大学で勉強します。	\N		\N	vmod	\N	\N	\N	0	1
1088	Musim semi adalah musim pertemuan dan perpisahan.	春は出会いと別れの季節です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1089	Dua tahun lagi, saya akan ditugaskan di Indonesia.	再来年、私はインドネシアで働いている。	\N		\N	vmod	\N	\N	\N	0	1
1090	Saya sudah menikah dua tahun yang lalu.	私はおととしにもう結婚しました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1091	Kemarin hujannya deras sekali, ya.	昨日は雨がひどかったですね。	\N		\N	vmod	\N	\N	\N	0	1
1092	Hasil ujian ini akan diberitahukan besok atau lusa.	この試験の結果は明日かあさってにお知らせします。	\N	\N	\N	vmod	\N	\N	\N	0	1
1093	Hariyanto sudah pulang ke Makassar kemarin dulu.	ハリヤントはおとといマカッサルに帰りました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1094	Dia sudah berkeluarga.	彼はもう家庭をもっています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1095	Dia menyiapkan makanan sambil merawat bayi.	彼女は赤ちゃんの面倒を見ながら食事の支度をします。	\N		\N	vmod	\N	\N	\N	0	1
1096	Kami mengobrol sepanjang malam tanpa tidur .	私たちは寝ずに夜通しおしゃべりしました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1097	Waktu masih kecil, saya suka bermain-main bersama kucing.	幼い頃、私は猫と遊ぶのが好きでした。	\N	\N	\N	vmod	\N	\N	\N	0	1
1098	Kadang-kadang Sakti menelepon ayahnya.	ときどきサクティはお父さんに電話します。	\N	\N	\N	vmod	\N	\N	\N	0	1
1099	Mereka sering makan di restoran cepat saji.	彼らはしばしばファーストフード店で食べます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1100	Saya harus segera pulang.	私はすぐ帰らなければなりません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1101	Boleh saya minta asbak? Saya mau merokok.	灰皿はありますか。タバコを吸いたいです。	\N		\N	vmod	\N	\N	\N	0	1
1102	Nyanyian ini mengundang air mata.	この歌は涙を誘う。	\N	\N	\N	vmod	\N	\N	\N	0	1
1103	Mereka suka menyanyi sambil nongkrong di pinggir jalan.	彼らはよく道端でたむろして歌っています。	\N		\N	vmod	\N	\N	\N	0	1
1104	Ayah saya menyukai rokok kretek.	父は丁子入りタバコが好きです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1105	Dia suka mengumpulkan piringan hitam lagu-lagu klasik opera.	彼はクラシックオペラのレコードを集めるのが好きです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1106	Nino selalu membawa gitar ke mana-mana.	ニノはどこへ行くにもいつもギターを持っていきます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1107	Gambar ini baru saya beli di toko.	この絵はお店で買ったばかりです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1108	Foto pesta pernikahan kami sudah jadi.	私たちの結婚式の写真が出来上がりました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1109	Suara Kakak berbeda dengan biasanya. Masuk angin?	お兄さんの声、いつもと違いますね。風邪を引きましたか。	\N		\N	vmod	\N	\N	\N	0	1
1110	Gunung Fuji dapat dilihat dari sini jika cuaca cerah.	もし晴れならばここから富士山が見えます。	\N		\N	vmod	\N	\N	\N	0	1
1111	Di luar panas, 'kan?	外は暑いでしょう。	\N	\N	\N	vmod	\N	\N	\N	0	1
1113	Mana yang lebih sejuk, Makassar atau Tokyo?	マカッサルと東京ではどちらが涼しいですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1114	Lebih baik membawa jaket karena nanti malam akan dingin.	夜には寒くなるのでジャケットを持っていった方がいいですよ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1115	Di tempat kamu saljunya turun banyak?	君のところでは雪はたくさん降る？	\N		\N	vmod	\N	\N	\N	0	1
1116	Sudah mulai musim hujan?	もう雨季がはじまりましたか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1117	Bagaimana cuaca di Surabaya sekarang?	現在のスラバヤの天気はどうですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1118	Pohon itu tumbang karena angin ribut.	あの木は強風のため倒れた。	\N		\N	vmod	\N	\N	\N	0	1
1119	Hari ini mendung, tetapi udaranya cukup panas.	今日は曇っていますが気温はじゅうぶん暑いです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1120	Saya mau minuman dingin.	冷たい飲み物がほしいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1121	Agak mendung. Saya khawatir hujan akan turun.	ちょっと曇っています。雨が降ってきそうです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1122	Bagi saya, hal yang paling sulit dalam bahasa Jepang adalah huruf kanji.	私にとって、日本語の中で最も難しいのは漢字です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1123	Maia mengatakan dia percaya kepada suaminya.	マイアは夫を信じていると言いました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1124	Saya sangat tertarik pada cerita rakyat dari Jawa Tengah.	私は中部ジャワの民話にとても興味があります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1125	Karangan kali ini sesedikitnya harus memuat 200 kata.	今回の作文は少なくとも２００語なければなりません。	\N		\N	vmod	\N	\N	\N	0	1
1126	Tulisan tentang Jepang tidak jarang kita temukan dalam surat kabar ni.	日本についての文章はこの新聞の中に珍しくはない。	\N		\N	vmod	\N	\N	\N	0	1
1127	Wanita karier itu bercerita tentang rahasia kesuksesannya.	そのキャリアウーマンは成功の秘訣について語りました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1129	Kelas huruf hiragana diadakan dari jam 10.00 sampai jam 11.00.	ひらがな教室は10時から１１時までやっています。	\N		\N	vmod	\N	\N	\N	0	1
1130	Huruf katakana dibuat dengan menggunakan bagian-bagian dari huruf kanji.	カタカナは漢字の部分部分を使って作られた。	\N		\N	vmod	\N	\N	\N	0	1
1131	Dia masih berumur 17 tahun, tetapi pikirannya sudah dewasa.	彼はまだ１７歳ですが、考えはもう大人です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1132	Di Indonesia, banyak orang yang biasa makan nasi.	インドネシアでは多くの人が普通ご飯を食べる。	\N		\N	vmod	\N	\N	\N	0	1
1133	Suami istri itu sering bertengkar.	その夫婦はよく喧嘩します。	\N	\N	\N	vmod	\N	\N	\N	0	1
1134	Anak kami masuk sekolah tahun depan.	私たちの子供は来年学校へ入ります。	\N	\N	\N	vmod	\N	\N	\N	0	1
1135	Saya senang karena istri saya pintar memasak.	妻が料理上手なので私は嬉しいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1136	Sudah tiga tahun saya tidak berjalan-jalan bersama perempuan.	もう３年も女性と一緒に出かけていません。	\N		\N	vmod	\N	\N	\N	0	1
1137	Anak laki-laki suka bermain sepak bola.	男の子はサッカーをするのが好きです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1138	Dia tidak disukai teman perempuannya karena selalu genit di depan laki-laki.	男性の前ではいつもぶりっこなので、彼女は女友達に好かれていません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1139	Hampir semua anak perempuan memakai anting-anting.	ほとんどすべての女の子がピアスをしています。	\N		\N	vmod	\N	\N	\N	0	1
1140	Setiap malam Minggu Rina pasti berkencan dengan suaminya.	毎週土曜の夜、リナは必ず夫とデートします。	\N	\N	\N	vmod	\N	\N	\N	0	1
1141	Motor biru itu milik siapa?	その青いバイクは誰のですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1142	Saya ingin rambut saya diwarnai cokelat.	髪を茶色に染めたいんですけど。	\N	\N	\N	vmod	\N	\N	\N	0	1
1143	Ibu Widji usianya sudah tua, tetapi suka memakai baju merah muda.	ウィジーさんはもう年配ですが、ピンクの服を着るのが好きです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1144	Ada berapa warna dalam pelangi?	虹の中には何色ありますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1145	Pak Ari salalu memakai jas biru tua.	アリさんはいつも濃い青のスーツを着ています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1146	Saya mau baju yang kuning itu.	あの黄色の服がほしいです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1147	Rambut hitam membuat kulit tampak lebih putih.	黒髪は肌をより白く見せます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1148	Konon, memakai pakaian berwarna hijau di pantai selatan Jawa itu berbahaya.	ジャワの南海岸で緑色の服を着るのは危険だそうです。	\N		\N	vmod	\N	\N	\N	0	1
1149	Kalau mau membeli rumah, sebaiknya Anda memperhatikan kemudahan transportasi.	家を買いたいなら、交通の便利さに注意したほうがいいです。	\N		\N	vmod	\N	\N	\N	0	1
1150	Uang kertas yang paling besar di Indonesia adalah Rp 100.000,00.	インドネシアで一番大きい紙幣は１０万ルピアです。	\N	\N	\N	vmod	\N	\N	\N	0	1
1151	Kalau berisik, silakan menutup pintunya.	うるさかったら、どうぞドアを閉めてください。	\N		\N	vmod	\N	\N	\N	0	1
1152	Mereka mendorong mobil itu sampai bengkel.	彼らは修理工場までその車を押しました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1153	Kalau berjalan lurus ke arah ini. Stasiun Balapan akan kelihatan di sebelah kanan.	この方向にまっすぐ歩いていけば、バラパン駅は右側に見えます。	\N		\N	vmod	\N	\N	\N	0	1
1154	Kota Yogyakarta terkenal dengan Candi Borobudur.	ジョグジャカルタはボロブドゥール寺院で有名です。	\N	\N	\N	vmod	\N	\N	\N	0	1
1155	Semoga Bapak sekeluarga selalu dalam keadaan sehat.	おじ様とご家族皆様がいつも健康でありますように。	\N		\N	vmod	\N	\N	\N	0	1
1156	Jadi, kamu tidak datang?	じゃあ、君は来ないの？	\N		\N	vmod	\N	\N	\N	0	1
1157	Barangkali Kak Tomo sekarang tidak ada di rumah.	多分トモさんは今、家にいません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1158	Pohon itu tumbang karena angin ribut.	強風のためあの木は倒れた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1159	Tidak boleh merokok di sini.	ここでタバコを吸ってはいけません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1160	Saya mau pergi ke belakang dulu.	ちょっとトイレに行ってきます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1161	Kami sedang mencari nafkah di negeri asing.	我々は今外国で生計を立てている。	\N	\N	\N	vmod	\N	\N	\N	0	1
888	Mereka selalu ada di dekat saya.	彼らはいつも私のそばにいる。	\N		\N	vmod	\N	\N	\N	0	1
1162	Para atlet dari berbagai negara berkumpul untuk mengikuti Olimpiade.	オリンピックに参加するためにいろいろな国からアスリートたちが集まる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1163	Saya berjumpa dengan teman saya di jalan.	道で友人に会った。	\N	\N	\N	vmod	\N	\N	\N	0	1
1164	Ibu saya gemar minum kopi.	母はコーヒーを飲むのが好きだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1165	Tolong berbicara pelan-pelan.	ゆっくり話してください。	\N	\N	\N	vmod	\N	\N	\N	0	1
1166	Saya benci kepada orang yang suka berbohong.	私はよくうそをつく人が嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
1167	Ketika berjalan-jalan, saya menemukan toko baru.	散歩しているときに新しい店を見つけた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1168	Kali Brantas mengalir di Jawa Timur.	ブランタス河は東ジャワを流れている。	\N		\N	vmod	\N	\N	\N	0	1
1169	Mobil itu berbelok ke kiri.	その車は左へ曲がった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1170	Laki-laki yang baru saja masuk ke kantor itu adalah kakak saya.	たった今その会社へ入っていった人は私の兄です。	\N		\N	vmod	\N	\N	\N	0	1
1171	Peristiwa kecelakan lalu lintas itu diberitakan dalam koran kemarin.	その交通事故の出来事は昨日の新聞で報じられていた。	\N		\N	vmod	\N	\N	\N	0	1
1172	Murid-murid menggambar buah-buahan dalam pelajaran menggambar.	生徒たちは図画の授業で果物を描いている。	\N		\N	vmod	\N	\N	\N	0	1
1173	Guru memberikan daftar nilai pada akhir semester kepada murid-murid.	先生は生徒に学期末の成績表を渡した。	\N	\N	\N	vmod	\N	\N	\N	0	1
1174	Tidak ada bis surat di sekitar sini.	この付近に郵便ポストはない。	\N		\N	vmod	\N	\N	\N	0	1
1175	Ibu saya menyapu lantai rumah setiap hari.	母は毎日家の床を掃いている。	\N		\N	vmod	\N	\N	\N	0	1
1176	Surat yang dikirimkan minggu yang lalu kembali karena alamatnya tidak dikenal.	先週送った手紙が宛名不明で戻ってきた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1177	Saya sangat sedih karena sahabat saya akan pindah rumah.	親友が引っ越すのでとても寂しい。	\N		\N	vmod	\N	\N	\N	0	1
1178	Sama-sama. Saya juga berterima kasih atas kebaikan Anda.	どういたしまして。私こそあなたの親切に感謝しています。	\N	\N	\N	vmod	\N	\N	\N	0	1
1179	Orang tua itu mengirimkan uang untuk anaknya.	あの親は子供のために仕送りしている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1180	Bunga ini berdaun bunga lima lembar.	この花は５枚の花びらがついている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1181	Kami tiba di Yogyakarta dengan selamat.	我々は無事にジョグジャカルタに着いた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1182	Pada tahun ini bangunan itu akan selesai dibangun.	今年にこの建物は完成する予定だ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1186	Kipas angin ini sudah tua, tetapi masih berguna.	この扇風機はもう古いが、まだ使える。	\N	\N	\N	vmod	\N	\N	\N	0	1
1187	Dia marah karena menerima jawaban yang kurang menyenangkan.	彼女は喜ばしくない返事をもらって怒った。	\N		\N	vmod	\N	\N	\N	0	1
1188	Saya tidak gembira atas hasil ujian itu.	私はそのテストの結果に喜んでいない。	\N		\N	vmod	\N	\N	\N	0	1
1189	Pemandangan dari sini sangat indah.	そこからの景色はとても美しい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1190	Pelayanan hotel itu jelek sakali.	そのホテルのサービスはとても悪い。	\N	\N	\N	vmod	\N	\N	\N	0	1
1191	Belakangan ini orang jahat bertambah banyak.	最近悪い人が増えてきた。	\N	\N	\N	vmod	\N	\N	\N	0	1
1192	Pada pagi hari jalan ini masih sepi.	朝、この道はまだ静かである。	\N		\N	vmod	\N	\N	\N	0	1
1193	Menurut teman saya, buku komik ini membosankan.	私の友達によるとこの漫画はつまらない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1194	Tadi malam kamu pulang jam berapa?	夕べは何時に帰ったのですか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1195	Ketika dia pergi, temannya datang.	彼が出かけているときに友達が来ました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1196	Kemarin, setelah pulang kerja, saya langsung jatuh tidur karena capai sekali.	昨日仕事から帰った後、とても疲れていたのですぐに寝てしまいました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1197	Lukisan ini bisa menyembuhkan luka hati.	この絵は心の傷を癒すことができます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1198	Mereka tidak berani berkata ''tidak'' pada bosnya.	彼らはボスに「いいえ」という勇気がなかった。	\N		\N	vmod	\N	\N	\N	0	1
1199	Kalimat ini ambigu, ya.	この文は曖昧ですね。	\N	\N	\N	vmod	\N	\N	\N	0	1
1200	Banyak wanita lajang benar-benar bahagia tanpa keberadaan suami.	多くの独身女性が夫の存在なしでほんとうに幸せでいます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1201	Kasihan pria itu karena pacarnya ternyata tidak setia.	恋人が誠実でないとわかって、その男性はかわいそうだ。	\N		\N	vmod	\N	\N	\N	0	1
1202	Sebagai manusia, terkadang kita melakukan kesalahan.	人間として、時々私たちは間違いをおかします。	\N	\N	\N	vmod	\N	\N	\N	0	1
1203	Anak ini belum bisa mengikat tali sepatu sendiri.	この子はまだ自分で靴のひもを結ぶことができません。	\N	\N	\N	vmod	\N	\N	\N	0	1
1204	Ayo, kita pulang.	じゃ、帰りましょう。	\N		\N	vmod	\N	\N	\N	0	1
1205	Drama ini ceritanya menarik, hanya aktornya tidak begitu baik.	このドラマは話は面白いが俳優があまりよくない。	\N		\N	vmod	\N	\N	\N	0	1
1206	Dia sering memakai baju longgar.	彼女はよくゆったりした服を着ます。	\N	\N	\N	vmod	\N	\N	\N	0	1
1207	Apakah ada menu sarapan khas Bandung?	バンドゥン特有の朝食メニューはありますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1208	Acara televisi itu mulai pukul 22.00 Waktu Indonesia Barat.	そのテレビ番組は西部インドネシア時間２２時に始まります。	\N		\N	vmod	\N	\N	\N	0	1
1209	Dokter telah memberi tahu saya tentang penyakit ibu saya.	医者が母の病気について知らせてくれました。	\N	\N	\N	vmod	\N	\N	\N	0	1
1210	Masih terdapat banyak masalah mengenai program magang di Jepang.	日本の研修制度に関してまだたくさんの問題があります。	\N		\N	vmod	\N	\N	\N	0	1
1211	Saya mau membuat kue akhir pekan ini.	私は今週末にお菓子を作りたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1212	Cuci tangan sepulang dari luar adalah penting.	外から帰ってきたらすぐに手を洗うことは大切だ。	\N		\N	vmod	\N	\N	\N	0	1
1213	Jangan biarkan pintu lemari es terbuka.	冷蔵庫のドアを開けっ放しにしないで。	\N		\N	vmod	\N	\N	\N	0	1
1214	Teman saya tidak mempunyai lemari es.	私の友達は冷蔵庫を持っていない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1215	Saya sedang belajar bahasa Indonesia.	私はインドネシア語を勉強している。	\N	\N	\N	vmod	\N	\N	\N	0	1
1216	Menurut pendapat saya, hal ini sukar dilakukan.	私の意見としてはこのことは実行しがたい。	\N	\N	\N	vmod	\N	\N	\N	0	1
1217	Kami susah mendapat kamus Indonesia di Jepang.	我々が日本でインドネシア語の辞書を手に得るのは難しい	\N	\N	\N	vmod	\N	\N	\N	0	1
1218	Kemarin ada tes fisik waktu kuliah olahraga.	昨日体育の授業のときに体力テストがあった。	\N	\N	\N	vmod	\N	\N	\N	0	1
1219	Tes bahasa Inggris kali ini susah sekali.	今回の英語のテストはとても難しかった。	\N		\N	vmod	\N	\N	\N	0	1
1220	Semua murid mendapat angka yang baik dalam tes kemarin.	全生徒が昨日のテストでよい点を取った。	\N		\N	vmod	\N	\N	\N	0	1
1221	Orang itu mengajarkan IPS di sekolah dasar.	その人は小学校で社会を教えている。	\N		\N	vmod	\N	\N	\N	0	1
1222	Saya pernah memerah susu sapi.	私は牛の乳を搾ったことがある。	\N	\N	\N	vmod	\N	\N	\N	0	1
1223	Banyak warung yang buka sampai malam di daerah ini.	この地域には夜まで開いているワルンがたくさんある。	\N		\N	vmod	\N	\N	\N	0	1
1224	Tubuh saya tidak kuat.	私の体は強くない。	\N	\N	\N	vmod	\N	\N	\N	0	1
1225	Dia bisa mengambil cuti dari perusahaannya.	彼女は会社から休暇をもらうことが出来た。	\N	\N	\N	vmod	\N	\N	\N	0	1
1226	Hobi saya adalah melakukan perjalanan ke luar negeri.	私の趣味は外国へ旅行をすることだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1227	Dilarang parkir sepeda di samping stasiun.	駅付近の自転車の駐車は禁止。	\N	\N	\N	vmod	\N	\N	\N	0	1
1229	Jeruk lemon ini segar sekali.	このレモンはとてもフレッシュだ。	\N	\N	\N	vmod	\N	\N	\N	0	1
1230	Bagaimana rencana liburannya?	休みの予定は？	\N		\N	vmod	\N	\N	\N	0	1
1231	Mobil yang lambat harap menggunakan jalur kiri.	遅い車は左の車線を使ってください。	\N		\N	vmod	\N	\N	\N	0	1
1232	Jangan biarkan pintu lemari es terbuka.	冷蔵庫を開けっ放しにしないで。	\N		\N	vmod	\N	\N	\N	0	1
1233	Kita perlu bermain untuk menghilangkan stres.	ストレスを発散するために遊ぶ必要がある。	\N		\N	vmod	\N	\N	\N	0	1
1234	Saya suka bermain piano, sedangkan adik saya suka bermain biola.	私はピアノを弾くのが好きだ。一方、妹はバイオリンを弾くのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1235	Bendera Kebangsaan Indonesia disebut Sang Saka Merah Putih.	インドネシアの国旗はサン・サカ・メラ・プティと呼ばれる。	\N		\N	vmod	\N	\N	\N	0	1
1236	Para penumpang dipersilakan untuk menunggu di ruang tunggu.	乗客の皆様は待合室でお待ちください。	\N		\N	vmod	\N	\N	\N	0	1
1237	Saya merasa senang dapat bertemu dengan Anda.	あなたにお会いできて嬉しいです。	\N		\N	vmod	\N	\N	\N	0	1
1238	Harap membuka sepatu.	靴をお脱ぎください。	\N		\N	vmod	\N	\N	\N	0	1
1239	Kamar ini akan kelihatan lebih terang kalau dicat dengan warna putih.	この部屋は白く塗ればより明るく見える。	\N		\N	vmod	\N	\N	\N	0	1
1240	Akhir-akhir ini kami jarang menggunakan tep untuk meputar lagu.	最近私たちはめったにカセットを使って音楽を聴かない。	\N		\N	vmod	\N	\N	\N	0	1
1241	Tep model ini sudah menjadi barang antik.	このモデルのテープレコーダーはもう骨董品となっている。	\N		\N	vmod	\N	\N	\N	0	1
68	Belum.	まだ。	機能		\N	dmod	id06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
111	Oh, begitu.	あぁ，そうなの。	機能		\N	dmod	id09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
474	Ya.	はい。	機能		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
817	test	テスト	\N		\N	vmod	\N	\N	\N	0	1
926	Di mana kamar kecilnya?	トイレはどこですか。	\N		\N	vmod	\N	\N	\N	0	1
1055	Bapak mau memasang AC?	エアコンつけますか。	\N	\N	\N	vmod	\N	\N	\N	0	1
1128	Kata ini artinya apa?	この単語の意味は何ですか。	\N		\N	vmod	\N	\N	\N	0	1
1	Selamat pagi, Pak.	先生，おはようございます。	挨拶する		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
2	Selamat pagi.	おはよう。	挨拶する		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
3	Ada kuliah?	授業があるんですか？	状況についてたずねる		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
4	Ya, Pak.	はい，あります。	機能		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
5	Kuliah apa?	何の授業ですか？	特徴についてたずねる		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
6	Kuliah linguistik, Pak.	言語学の授業です。	機能		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
7	O, begitu.	あぁ，そう。	機能		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
8	Maaf, Pak, saya permisi dulu.	先生，すみませんがお先に失礼します。	さよならを言う		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
9	Ya, silakan.	ええ，どうぞ。	許可をする		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
10	Permisi, Pak	失礼します。	さよならを言う		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
11	Ya.	はい。	機能		\N	dmod	id01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
12	Permisi.	すみません。	注意をひく		\N	dmod	id02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
89	Silakan.	どうぞ。	機能		\N	dmod	id07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
249	Ya.	そう。	機能		\N	dmod	id20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
321	Kalau guru privat, bagaimana?	家庭教師はどう？	提案する		\N	dmod	id25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
434	Baik.	はい。	機能		\N	dmod	id34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
468	Ya. 	そうですね。	機能		\N	dmod	id37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
614	ya		null		\N	pmod	page013.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[1]	2-11/1.html	\N	1
679	Selasa	(火曜日)	null		\N	pmod	page017.xml	/pmod:page[1]/pmod:block[1]/pmod:examples[1]/pmod:example[2]	5-3/1.html	\N	1
1183	Saya menitipkan jaket saya kepada teman saya.	私は自分のコートを友達に預けている。	\N	\N	\N	vmod	\N	\N	\N	0	1
1184	Kalau mau datang, siapa saja bisa datang.	来たいなら誰でも来ることができる。	\N	\N	\N	vmod	\N	\N	\N	0	1
1185	Ayah saya tidak suka lagu seperti ini.	私の父はこのような歌が好きではない。	\N	\N	\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: id
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	152	行く	1	1
2	495	英語	1	1
3	496	飛行機	1	1
4	497	外国	1	1
5	498	外国人	1	1
6	499	フランス語	1	1
7	500	ホテル	1	1
8	501	日本語	1	1
9	359	出掛ける	1	1
10	502	国（くに）	1	1
11	178	会う	1	1
12	141	休み	1	1
13	503	旅行	1	1
14	504	旅行する	1	1
15	505	遊ぶ	1	1
16	506	大使館	1	1
17	507	大好き	1	1
18	97	好き	1	1
19	236	上手（じょうず）	1	1
20	508	走る	1	1
21	509	ゆっくり	1	1
22	510	下手（へた）	1	1
23	511	歩く	1	1
24	156	泳ぐ	1	1
25	369	速い［スピードが～］	1	1
26	512	飛ぶ	1	1
27	513	スポーツ	1	1
28	514	嫌い	1	1
29	515	プール	1	1
30	516	バス	1	1
31	517	自転車	1	1
32	518	交差点	1	1
33	247	道（みち）	1	1
34	519	池	1	1
35	520	散歩	1	1
36	521	かわ（川・河）	1	1
37	522	タクシー	1	1
38	523	自動車，車（くるま）	1	1
39	524	曲がる	1	1
40	525	ネクタイ	1	1
41	526	ワイシャツ	1	1
42	527	会社	1	1
43	528	背広	1	1
44	161	やる	1	1
45	529	吸う	1	1
46	530	電話	1	1
47	531	仕事	1	1
48	532	働く・勤める	1	1
49	340	忙しい	1	1
50	179	図書館	1	1
51	434	辞書，字引	1	1
52	194	借りる	1	1
53	533	新聞	1	1
54	70	読む	1	1
55	117	本	1	1
56	534	コピー	1	1
57	535	コピーする	1	1
58	536	雑誌	1	1
59	537	冊	1	1
60	538	牛肉	1	1
61	367	安い	1	1
62	539	店	1	1
63	540	高い	1	0
64	21	いくつ	1	1
65	21	いくら	1	1
66	196	果物	1	1
67	541	野菜	1	1
68	296	魚	1	1
69	542	豚肉	1	1
70	543	鳥肉	1	1
71	313	肉	1	1
72	311	欲しい	1	1
73	544	渡す	1	1
74	545	八百屋	1	1
75	546	かぎ（鍵）	1	1
76	417	料理	1	1
77	547	買い物する	1	1
78	548	洗う，洗濯する	1	1
79	549	掃除する	1	1
80	550	家族	1	1
81	551	家庭	1	1
82	552	庭（にわ）	1	1
83	553	洗濯	1	1
84	450	うち（家）	1	0
85	450	家（いえ）	1	1
86	554	掃除	1	1
87	390	かえる（帰・返）	1	1
88	555	本棚	1	1
89	556	机	1	1
90	557	椅子（いす）	1	1
91	558	部屋	1	1
92	559	冷蔵庫	1	1
93	548	洗う	1	0
94	560	ベッド	1	1
95	561	ラジオ	1	1
96	562	ラジカセ	1	1
97	563	～という名前です	1	1
98	474	寝る	1	1
99	564	起きる	1	1
100	556	テーブル	1	1
101	565	テレビ	1	1
102	566	お巡りさん	1	1
103	566	警官	1	1
104	567	地図	1	1
105	568	そば	1	1
106	216	ここ,こちら, こっち	1	1
107	38	そこ,そちら, そっち	1	1
108	46	あちら, あっち，あそこ	1	1
109	39	どこ,どちら,どっち	1	1
110	569	交番	1	1
111	568	近く	1	1
112	251	隣	1	1
113	55	きく	1	1
114	570	切る	1	1
115	571	短い	1	1
116	445	後ろ	1	1
117	64	前	1	1
118	572	右	1	1
119	573	左	1	1
120	142	長い	1	1
121	574	座る	1	1
122	575	立つ	1	1
123	114	友達	1	1
124	576	クラス	1	1
125	577	教室	1	1
126	578	廊下	1	1
127	579	学校	1	1
128	580	生徒	1	1
129	581	勉強	1	1
130	23	学生	1	1
131	582	留学生	1	1
132	583	夏休み	1	1
133	383	先生	1	1
134	396	大学	1	1
135	584	ノート	1	1
136	4	授業	1	1
137	585	作文	1	1
138	586	宿題	1	1
139	111	難しい	1	1
140	587	教える	1	1
141	128	テスト	1	1
142	105	練習	1	1
143	588	易しい	1	1
144	589	練習する	1	1
145	57	質問	1	1
146	590	問題	1	1
147	591	答える	1	1
148	80	痛い	1	1
149	592	歯	1	1
150	83	医者	1	1
151	593	病院	1	1
152	594	病気	1	1
153	476	薬（くすり）	1	1
154	595	死ぬ	1	1
155	596	風邪（かぜ）	1	1
156	456	頭（あたま）	1	1
157	597	お腹	1	1
158	598	度（ど）	1	1
159	599	エレベーター	1	1
160	600	切符	1	1
161	244	おりる	1	1
162	601	階段	1	1
163	602	閉める	1	1
164	603	駅	1	1
165	604	地下鉄	1	1
166	242	乗る	1	1
167	605	開ける	1	1
168	606	お手洗い	1	1
169	606	トイレ	1	1
170	607	電車	1	1
171	608	飲み物	1	1
172	253	コーヒー	1	1
173	609	喫茶店	1	1
174	610	レモン	1	1
175	611	牛乳	1	1
176	329	砂糖	1	1
177	612	カップ	1	1
178	419	お茶	1	1
179	419	紅茶	1	1
180	613	コップ	1	1
181	325	入れる	1	1
182	614	甘い	1	1
183	418	飲む	1	1
184	615	はし	1	1
185	616	酒	1	1
186	95	おいしい	1	1
187	617	ナイフ	1	1
188	319	スプーン	1	1
189	618	フォーク	1	1
190	619	チーズ	1	1
191	93	食べる	1	1
192	620	まずい	1	1
193	621	パン	1	1
194	622	辛い	1	1
195	623	レストラン	1	1
196	624	食堂	1	1
197	625	酒・ワイン	1	1
198	461	食べ物	1	1
199	626	カレー	1	1
200	432	お金	1	1
201	627	銀行	1	1
202	628	入り口	1	1
203	13	どうぞ	1	1
204	60	いいえ	1	1
205	5	ええ	1	1
206	11	すみません	1	1
207	13	どうぞ	1	0
208	629	出口	1	1
209	163	着く	1	1
210	630	ポスト	1	1
211	631	はがき	1	1
212	632	貼る	1	1
213	633	封筒	1	1
214	81	手紙	1	1
215	634	郵便局	1	1
216	465	返す	1	1
217	635	送る	1	1
218	636	切手	1	1
219	637	荷物	1	1
220	638	枚	1	1
221	639	貸す	1	1
222	125	買う	1	1
223	640	帽子	1	1
224	641	靴	1	1
225	642	買い物	1	1
226	643	階	1	1
227	644	デパート	1	1
228	645	スカート	1	1
229	646	コート	1	1
230	647	ズボン	1	1
231	648	セーター	1	1
232	32	…てください	1	1
233	649	かばん	1	1
234	650	売る	1	1
235	646	上着	1	0
236	651	ふろ	1	1
237	446	建物	1	1
238	652	台所	1	1
239	653	シャワー	1	1
240	654	窓	1	1
241	655	住む	1	1
242	656	公園	1	1
243	657	ドア	1	1
244	464	浴びる［一風呂～］	1	1
245	658	アパート	1	1
246	628	玄関	1	1
247	234	彼，彼女	1	1
248	659	彼ら，彼女たち	1	1
249	10	私（わたし）	1	1
250	143	私たち	1	1
251	211	だれか	1	1
252	660	だれ，どなた	1	1
253	660	どなた	1	0
254	393	きみ	1	1
255	24	あなた	1	1
256	19	これ，この	1	1
257	41	それ，その，あれ，あの	1	1
258	148	いかが，どう，どんな	1	1
259	39	どの	1	1
260	148	どんな	1	0
261	661	こんな	1	1
262	662	自分	1	1
263	8	そう	1	1
264	663	厚い	1	1
265	664	狭い	1	1
266	665	細い	1	1
267	215	大きい	1	1
268	663	太い	1	1
269	666	若い	1	1
270	667	広い	1	1
271	668	軽い	1	1
272	669	遠い	1	1
273	670	重い	1	1
274	671	薄い	1	1
275	102	新しい	1	1
276	672	小さい	1	1
277	568	近い	1	1
278	201	古い	1	1
279	51	楽しい，嬉しい	1	1
280	673	にぎやか	1	1
281	674	低い	1	1
282	84	よい	1	1
283	675	明るい	1	1
284	676	弱い	1	1
285	677	強い	1	1
286	272	おもしろい	1	1
287	678	きれい	1	1
288	679	遅い	1	1
289	680	悪い	1	1
290	130	多い	1	1
291	681	暗い	1	1
292	682	静か	1	1
293	330	少ない	1	1
294	683	汚い	1	1
295	684	つまらない	1	1
296	685	横	1	1
297	268	中（なか）	1	1
298	686	外（そと）	1	1
299	687	東（ひがし）	1	1
300	540	高さ	1	1
301	142	縦	1	1
302	688	北（きた）	1	1
303	689	西（にし）	1	1
304	690	下（した）	1	1
305	691	南（みなみ）	1	1
306	333	上（うえ）	1	1
307	64	先（さき）	1	0
308	445	後（あと）	1	0
309	692	いとこ	1	1
310	693	兄	1	1
311	694	兄弟（きょうだい），姉妹	1	1
312	160	おばあさん	1	1
313	695	おじいさん	1	1
314	696	奥さん	1	1
315	47	母	2	1
316	697	叔父，伯父	1	1
317	698	両親	1	1
318	699	父	1	1
319	700	姉	1	1
320	694	姉妹	1	0
321	701	叔母，伯母	1	1
322	346	お兄さん	1	1
323	346	お姉さん	1	1
324	699	お父さん	1	0
325	47	お母さん	1	0
326	702	靴下	1	1
327	703	シャツ	1	1
328	605	脱ぐ	1	1
329	704	架ける	1	1
330	435	は（穿）く［ズボンを～］	1	1
331	705	着る	1	1
332	435	かぶる	1	1
333	706	ハンカチ	1	1
334	707	スリッパ	1	1
335	708	傘	1	1
336	709	ポケット	1	1
337	710	財布	1	1
338	711	着ている	1	1
339	712	服	1	1
340	712	洋服	1	0
341	713	口	1	1
342	714	腕（うで）	1	1
343	715	体（からだ）	1	1
344	716	顔	1	1
345	717	脚（あし）	1	1
346	718	手（て）	1	1
347	263	鼻	1	1
348	262	目（め）	1	1
349	719	耳	1	1
350	717	足（あし）	1	1
351	597	おなか	1	1
352	720	皿（さら）	1	1
353	721	バター	1	1
354	612	茶わん	1	1
355	722	あめ	1	1
356	723	昼御飯	1	1
357	724	夕飯（ゆうはん）	1	1
358	91	お菓子	1	1
359	307	卵	1	1
360	725	朝御飯	1	1
361	301	御飯（ごはん）	1	1
362	726	醤油	1	1
363	328	塩（しお）	1	1
364	724	晩御飯，夕飯	1	0
365	727	くわえる	1	1
366	728	つける	1	1
367	729	カメラ	1	1
368	730	ストーブ	1	1
369	731	鉛筆	1	1
370	732	消す	1	1
371	733	眼鏡（めがね）	1	1
372	562	テープレコーダー	1	1
373	190	時計	1	1
374	734	コンピュータ	1	1
375	421	フィルム	1	1
376	657	戸（と）	1	1
377	657	門（もん）	1	1
378	735	ペン	1	1
379	735	万年筆	1	1
380	736	ボールペン	1	1
381	737	八月	1	1
382	738	四月	1	1
383	739	今月	1	1
384	740	毎月（まいつき）	1	1
385	741	十二月	1	1
386	742	二月	1	1
387	743	一月	1	1
388	744	七月	1	1
389	745	六月	1	1
390	746	来月	1	1
391	747	五月	1	1
392	748	三月	1	1
393	749	先月	1	1
394	750	十一月	1	1
395	751	十月	1	1
396	752	九月	1	1
397	753	ひとつき	1	1
398	754	今週	1	1
399	755	毎週	1	1
400	75	日曜日	1	1
401	402	木曜日	1	1
402	756	来週	1	1
403	757	月曜日	1	1
404	758	火曜日	1	1
405	404	水曜日	1	1
406	759	土曜日	1	1
407	75	週間	1	1
408	760	先週	1	1
409	761	金曜日	1	1
410	69	年（ねん）	1	1
411	762	秋	1	1
412	763	今年（ことし）	1	1
413	764	毎年（まいとし）	1	1
414	765	夏（なつ）	1	1
415	766	冬	1	1
416	767	去年	1	1
417	768	来年	1	1
418	769	春	1	1
419	770	再来年	1	1
420	771	おととし	1	1
421	1	午後	1	1
422	772	今日（きょう）	1	1
423	222	明日（あした）	1	1
424	190	時（じ）	1	1
425	773	昨日（きのう）	1	1
426	774	夕べ	1	0
427	1	午前	1	1
428	191	朝	1	1
429	775	昼	1	1
430	774	夜（よる）	1	1
431	192	夕方	1	1
432	776	あさって	1	1
433	777	おととい	1	1
434	88	もう	1	1
435	778	ながら	1	1
436	89	まだ	1	1
437	779	中(ちゅう)	1	1
438	199	時（とき）	1	1
439	297	いつ	1	1
440	780	ときどき	1	1
441	781	しばしば	1	1
442	199	時間	1	1
443	782	すぐ	1	1
444	783	灰皿	1	1
445	784	歌（うた）	1	1
446	785	歌う	1	1
447	786	たばこ	1	1
448	421	映画	1	1
449	787	レコード	1	1
450	788	ギター	1	1
451	505	弾く	1	1
452	789	音楽	1	1
453	790	絵（え）	1	1
454	791	写真	1	1
455	97	好き，気に入る	1	1
456	792	声	1	1
457	793	晴れ	1	1
458	794	暑い	1	1
459	795	晴れる	1	1
460	796	涼しい	1	1
461	797	寒い	1	1
462	798	雪（ゆき）	1	1
463	799	雨が降る	1	1
464	355	雨（あめ）	1	1
465	800	天気	1	1
466	801	あたたかい（暖・温）	1	1
467	802	風（かぜ）	1	1
468	803	曇り	1	1
469	797	冷たい	1	1
470	803	曇る	1	1
471	804	漢字	1	1
472	805	言う	1	1
473	267	書く	1	1
474	806	話（はなし）	1	1
475	167	言葉	1	1
476	27	～語	1	1
477	167	語（ご）	1	1
478	233	話す	1	1
479	807	文章	1	1
480	808	語る	1	1
481	809	意味	1	1
482	810	平仮名	1	1
483	811	片仮名	1	1
484	812	大人（おとな）	1	1
485	813	大勢	1	1
486	814	夫婦	1	1
487	815	子供	1	1
488	816	妻	1	1
489	817	女（おんな）	1	1
490	818	男の子	1	1
491	228	人（ひと）	1	1
492	819	男（おとこ）	1	1
493	820	女の子	1	1
494	821	夫	1	1
495	228	人	1	1
496	322	みんな	1	1
497	310	白（しろ），白い	1	1
498	822	青，青い	1	1
499	823	茶色	1	1
500	666	明るい，淡い	1	1
501	824	色（いろ）	1	1
502	825	濃い，暗い	1	1
503	826	黄色（きいろ），黄色い	1	1
504	827	黒（くろ），黒い	1	1
505	40	赤，赤い	1	1
506	828	緑	1	1
507	829	便利	1	1
508	344	パーティー	1	1
509	830	紙	1	1
510	182	～になる	1	1
511	602	締める	1	0
512	831	押す	1	1
513	62	始まる	1	1
514	250	ちょうど	1	1
515	832	ない	1	1
516	833	まっすぐ	1	1
517	834	有名	1	1
518	835	元気	1	1
519	403	じゃあ	1	1
520	836	多分	1	1
521	115	では	1	1
522	837		1	0
523	837	(父方の)おばあさん	1	1
524	350	（聞き手を含まない）私たち	1	1
525	802	風邪	1	0
526	838	（たばこを）吸う	1	1
527	445	お手洗い	1	1
528	303	易しい	1	1
529	839	外国	1	1
530	840	国（くに）	1	1
531	841	会う	1	1
532	842	休み	1	1
533	843	好き	1	1
534	844	ゆっくり\n	1	1
535	845	嫌い	1	1
536	366	バス	1	1
537	846	散歩	1	1
538	847	かわ（川・河）	1	1
539	848	曲がる	1	1
540	849	会社	1	1
541	341	やる	1	1
542	74	仕事	1	1
543	850	新聞	1	1
544	196	冊	1	1
545	371	高い	1	1
546	851	果物	1	1
547	14	～たい，欲する	1	1
548	852	渡す	1	1
549	853	ポスト	1	1
550	125	買い物する	1	0
551	854	掃除する	1	1
552	855	かえる（帰・返）	1	1
553	856	部屋	1	1
554	248	隣	1	1
555	857	友達	1	1
556	168	先生	1	1
557	140	宿題	1	1
558	469	切符	1	1
559	859	どういたしまして	1	1
560	860	送る	1	1
561	210	荷物	1	1
562	861	枚	1	1
563	380		1	0
564	380	デパート	1	1
565	862	着く	1	1
566	863	建物	1	1
567	864	上着	1	1
568	34	上衣	1	1
569	865	だれか	1	1
570	485	彼、彼女	1	1
571	866	こんな	1	1
572	867	どんな	1	1
573	868	自分	1	1
574	825	古い	1	1
575	869	楽しい	1	1
576	870	喜ぶ	1	1
577	176	よい	1	1
578	871	きれい	1	1
579	872	きれい	1	1
580	873	悪い	1	1
581	874	悪い	1	1
582	875	静か	1	1
583	876	つまらない	1	1
584	877	夕べ	1	1
585	878	時（とき）	1	1
586	241	すぐ	1	1
587	276	歌（うた）	1	1
588	879	絵（え）	1	1
589	880	言う	1	1
590	881	インドネシア語	1	1
591	882	文章	1	1
592	883	女（おんな）	1	1
593	884	男（おとこ）	1	1
594	885	人	1	1
595	886	束ねる，結ぶ	1	1
596	223	多分	1	1
597	487	では	1	1
598	137	おもしろい	1	1
599	435	着る	1	1
600	887	朝御飯	1	1
601	888	時（じ）	1	1
602	324	もう	1	1
603	101	まだ	1	1
604	99	作る	1	1
605	889	洗う，洗濯，洗うこと	1	1
606	890		1	0
607	890	冷蔵庫	1	1
608	110	勉強	1	1
609	891	難しい	1	1
610	892	難しい	1	1
611	893		1	0
612	893	テスト	1	0
613	893	テスト	1	1
614	894	教える	1	1
615	895	牛乳	1	1
616	252	簡易店舗	1	1
617	896	体（からだ）	1	1
618	897	休み	1	1
619	362	旅行	1	1
620	251	そば	1	1
621	898	地下鉄	1	1
622	899	レモン	1	1
623	435	使う	1	1
624	900	カセット	1	1
625	900	ラジカセ，テープレコーダー	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
507	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
438	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
585	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
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
584	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
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
620	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
112	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
554	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
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
601	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
442	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
158	15048	1.1962	1.19	体	関係	量	助数接辞	度（ど）	度	ど
226	15092	1.1962	1.19	体	関係	量	助数接辞	階	階	かい
59	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
220	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
562	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
544	15216	1.1962	1.19	体	関係	量	助数接辞	冊	冊	さつ
491	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
495	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
594	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
249	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
250	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
524	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
255	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
254	15527	1.201	1.20	体	主体	人間	われ・なれ・かれ	君（きみ）	君	きみ
247	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
248	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
570	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
252	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
253	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
251	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
569	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
262	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
573	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
492	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
593	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
490	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
489	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
592	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
493	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
487	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
484	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
313	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
312	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
522	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
523	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
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
555	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
5	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
133	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
556	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
150	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
103	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
102	20065	1.2417001	1.24	体	主体	成員	保安サービス	お巡りさん	お巡りさん	おまわりさん
130	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
128	20241	1.2419	1.24	体	主体	成員	学徒	生徒	生徒	せいと
131	20281	1.2419	1.24	体	主体	成員	学徒	留学生	留学生	りゅうがくせい
81	21220	1.251	1.25	体	主体	公私	家	家庭	家庭	かてい
10	21338	1.253	1.25	体	主体	公私	国	国（くに）	国	くに
530	21338	1.253	1.25	体	主体	公私	国	国（くに）	国	くに
4	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
529	21365	1.253	1.25	体	主体	公私	国	外国	外国	がいこく
127	22471	1.263	1.26	体	主体	社会	社寺・学校	学校	学校	がっこう
125	22500	1.263	1.26	体	主体	社会	社寺・学校	教室	教室	きょうしつ
134	22517	1.263	1.26	体	主体	社会	社寺・学校	大学	大学	だいがく
42	22666	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	会社	会社	かいしゃ
540	22666	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	会社	会社	かいしゃ
201	22692	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	銀行	銀行	ぎんこう
164	22785	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	駅	駅	えき
29	22810	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	プール	プール	ぷうる
62	22828	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	店（みせ）	店	みせ
195	22888	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	レストラン	レストラン	れすとらん
196	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
616	22896	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	食堂	食堂	しょくどう
173	22917	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	喫茶店	喫茶店	きっさてん
74	22952	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	八百屋	八百屋	やおや
227	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
563	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
564	23049	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	デパート	デパート	でぱあと
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
608	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
141	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
611	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
613	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
481	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
339	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
138	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
557	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
475	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
476	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
477	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
590	30555	1.3101	1.31	体	活動	言語	言語	外国語	外国語	がいこくご
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
591	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
55	34173	1.316	1.31	体	活動	言語	文献・図書	本（ほん）	本	ほん
58	34482	1.316	1.31	体	活動	言語	文献・図書	雑誌	雑誌	ざっし
53	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
543	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
51	34541	1.316	1.31	体	活動	言語	文献・図書	辞書	辞書	じしょ
445	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
587	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
453	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
588	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
454	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
452	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
448	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
47	36429	1.332	1.33	体	活動	生活	労働・作業・休暇	仕事	仕事	しごと
542	36429	1.332	1.33	体	活動	生活	労働・作業・休暇	仕事	仕事	しごと
132	36595	1.332	1.33	体	活動	生活	労働・作業・休暇	夏休み	夏休み	なつやすみ
12	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
532	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
618	36602	1.332	1.33	体	活動	生活	労働・作業・休暇	休み	休み	やすみ
361	36910	1.3331	1.33	体	活動	生活	食生活	御飯（ごはん）	御飯	ごはん
360	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
600	36929	1.3331	1.33	体	活動	生活	食生活	朝御飯	朝御飯	あさごはん
356	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
357	36950	1.3331	1.33	体	活動	生活	食生活	夕飯（ゆうはん）	夕飯	ゆうはん
364	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
13	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
619	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
35	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
537	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
27	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
19	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
22	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
508	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
136	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
225	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
83	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
605	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
86	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
219	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
561	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
200	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
160	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
558	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
218	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
509	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
340	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
235	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
567	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
568	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
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
566	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
377	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
91	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
245	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
553	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
246	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
238	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
169	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
168	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
527	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
126	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
162	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
240	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
88	53263	1.4450001	1.44	体	生産物	住居	棚・台・壇など	本棚	本棚	ほんだな
376	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
446	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
243	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
89	53456	1.447	1.44	体	生産物	住居	家具	机	机	つくえ
100	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
90	53482	1.447	1.44	体	生産物	住居	家具	椅子（いす）	椅子	いす
368	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
236	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
444	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
210	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
549	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
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
606	55970	1.462	1.46	体	生産物	機械	電気器具・部品	冷蔵庫	冷蔵庫	れいぞうこ
607	55970	1.462	1.46	体	生産物	機械	電気器具・部品	冷蔵庫	冷蔵庫	れいぞうこ
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
536	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
170	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
165	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
621	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
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
538	60947	1.525	1.52	体	自然	天地	川・湖	かわ（川・河）	かわ	かわ
34	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
174	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
622	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
546	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
66	62825	1.541	1.54	体	自然	植物	枝・葉・花・実	果物	果物	くだもの
68	63577	1.5504	1.55	体	自然	動物	魚類	魚（さかな）	魚	さかな
343	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
617	64143	1.5599999	1.56	体	自然	身体	身体	体（からだ）	体	からだ
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
615	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
359	65581	1.5608	1.56	体	自然	身体	卵	卵（たまご）	卵	たまご
152	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
155	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
525	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
510	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
99	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
604	67904	2.122	2.12	用	関係	存在	成立	作る	作る	つくる
370	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
511	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
209	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
565	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
87	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
552	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
181	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
332	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
161	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
463	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
166	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
595	72420	2.1551001	2.15	用	関係	作用	統一・組み合わせ	束ねる	束ねる	たばねる
167	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
163	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
366	72782	2.1559999	2.15	用	関係	作用	接近・接触・隔離	付ける	付ける	つける
212	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
39	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
539	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
114	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
365	73997	2.158	2.15	用	関係	作用	増減・補充	加える	加える	くわえる
513	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
576	75494	2.3011	2.30	用	活動	心	快・喜び	喜ぶ	喜ぶ	よろこぶ
144	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
472	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
589	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
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
599	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
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
526	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
44	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
541	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
48	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
11	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
531	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
140	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
614	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
232	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
234	87238	2.3761001	2.37	用	活動	経済	売買	売る	売る	うる
77	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
222	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
550	87307	2.3761001	2.37	用	活動	経済	売買	買う	買う	かう
73	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
548	87493	2.3770001	2.37	用	活動	経済	授受	渡す	渡す	わたす
221	87572	2.378	2.37	用	活動	経済	貸借	貸す	貸す	かす
52	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
216	87624	2.378	2.37	用	活動	経済	貸借	返す	返す	かえす
560	88102	2.3829999	2.38	用	活動	事業	運輸	送る	送る	おくる
217	88102	2.3829999	2.38	用	活動	事業	運輸	送る	送る	おくる
93	88468	2.3841	2.38	用	活動	事業	染色・洗濯など	洗う	洗う	あらう
78	88469	2.3841	2.38	用	活動	事業	染色・洗濯など	洗濯する	洗濯する	せんたくする
79	88631	2.3843	2.38	用	活動	事業	掃除など	掃除する	掃除する	そうじする
551	88631	2.3843	2.38	用	活動	事業	掃除など	掃除する	掃除する	そうじする
470	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
459	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
154	90096	2.5702	2.57	用	自然	生命	死	死ぬ	死ぬ	しぬ
256	90777	3.1010001	3.10	相	関係	真偽	こそあど・他	この	この	この
261	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
571	90778	3.1010001	3.10	相	関係	真偽	こそあど・他	こんな	こんな	こんな
263	90799	3.1010001	3.10	相	関係	真偽	こそあど・他	そう	そう	そう
257	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
259	90820	3.1010001	3.10	相	関係	真偽	こそあど・他	どの	どの	どの
260	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
572	90821	3.1010001	3.10	相	関係	真偽	こそあど・他	どんな	どんな	どんな
258	90827	3.1010001	3.10	相	関係	真偽	こそあど・他	いかが	いかが	いかが
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
577	91632	3.1331999	3.13	相	関係	様相	良不良・適不適	よい	よい	よい
282	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
289	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
580	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
581	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
274	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
287	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
578	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
579	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
294	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
139	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
609	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
610	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
143	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
528	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
285	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
284	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
441	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
440	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
275	93391	3.1659999	3.16	相	関係	時間	新旧・遅速	新しい	新しい	あたらしい
278	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
574	93413	3.1659999	3.16	相	関係	時間	新旧・遅速	古い	古い	ふるい
269	93460	3.1659999	3.16	相	関係	時間	新旧・遅速	若い	若い	わかい
288	93490	3.1659999	3.16	相	関係	時間	新旧・遅速	遅い	遅い	おそい
436	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
603	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
434	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
602	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
443	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
586	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
435	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
516	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
290	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
293	93928	3.191	3.19	相	関係	量	多少	少ない	少ない	すくない
120	94000	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	長い	長い	ながい
115	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
63	94023	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	高い	高い	たかい
545	94023	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	高い	高い	たかい
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
534	94288	3.1912999	3.19	相	関係	量	速度	ゆっくり	ゆっくり	ゆっくり
273	94318	3.1914001	3.19	相	関係	量	軽重	重い	重い	おもい
271	94320	3.1914001	3.19	相	関係	量	軽重	軽い	軽い	かるい
458	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
460	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
461	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
437	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
148	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
575	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
279	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
286	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
598	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
295	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
583	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
18	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
455	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
533	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
17	95587	3.302	3.30	相	活動	心	好悪・愛憎	大好き	大好き	だいすき
28	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
535	95610	3.302	3.30	相	活動	心	好悪・愛憎	嫌い	嫌い	きらい
72	96159	3.3041999	3.30	相	活動	心	欲望・期待・失望	欲しい	欲しい	ほしい
547	96160	3.3041999	3.30	相	活動	心	欲望・期待・失望	－たい	－たい	たい
517	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
49	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
518	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
61	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
283	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
500	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
291	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
497	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
292	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
582	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
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
596	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
207	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
559	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
597	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	381	692	0		\N	\N	\N
2	382	688	0		\N	\N	\N
4	524	295	0		0	\N	\N
5	524	297	0		0	\N	\N
7	346	744	0		0	\N	\N
8	162	745	0		0	\N	\N
9	233	570	0		0	\N	\N
10	62	525	0		0	\N	\N
11	406	683	0		0	\N	\N
12	404	679	0		0	\N	\N
13	403	678	0		0	\N	\N
15	175	527	0		0	\N	\N
16	104	529	0		0	\N	\N
17	395	694	0		0	\N	\N
19	6	223	0		0	\N	\N
20	6	227	0		0	\N	\N
21	70	268	0		0	\N	\N
22	409	400	0		0	\N	\N
23	91	32	0		0	\N	\N
24	215	172	0		0	\N	\N
25	215	176	0		0	\N	\N
28	226	142	0		0	\N	\N
29	515	99	0		0	\N	\N
30	2	190	0		0	\N	\N
32	8	187	0		0	\N	\N
33	8	225	0		0	\N	\N
35	422	477	0		0	\N	\N
36	528	264	0		0	\N	\N
37	1	127	0		0	\N	\N
38	1	257	0		0	\N	\N
39	3	309	0		0	\N	\N
40	9	297	0		0	\N	\N
41	11	142	0		0	\N	\N
42	11	477	0		0	\N	\N
45	12	119	0		0	\N	\N
49	19	190	0		0	\N	\N
50	24	128	0		0	\N	\N
51	25	309	0		0	\N	\N
52	33	202	0		0	\N	\N
54	44	380	0		0	\N	\N
55	49	285	0		0	\N	\N
56	50	153	0		0	\N	\N
57	51	385	0		0	\N	\N
58	52	156	0		0	\N	\N
59	54	313	0		0	\N	\N
60	55	98	0		0	\N	\N
61	65	458	0		0	\N	\N
62	64	47	0		0	\N	\N
63	64	182	0		0	\N	\N
64	68	255	0		0	\N	\N
65	72	365	0		0	\N	\N
66	72	497	0		0	\N	\N
67	76	497	0		0	\N	\N
68	87	331	0		0	\N	\N
69	98	471	0		0	\N	\N
70	106	406	0		0	\N	\N
71	107	26	0		0	\N	\N
72	107	569	0		0	\N	\N
73	108	124	0		0	\N	\N
75	108	208	0		0	\N	\N
76	85	424	0		0	\N	\N
77	84	424	0		0	\N	\N
78	259	27	0		0	\N	\N
79	259	203	0		0	\N	\N
80	109	133	0		0	\N	\N
81	109	200	0		0	\N	\N
82	112	204	0		0	\N	\N
83	113	196	0		0	\N	\N
84	532	431	0		0	\N	\N
85	532	465	0		0	\N	\N
86	536	307	0		0	\N	\N
87	541	287	0		0	\N	\N
88	542	392	0		0	\N	\N
89	544	156	0		0	\N	\N
90	545	309	0		0	\N	\N
91	547	196	0		0	\N	\N
92	547	504	0		0	\N	\N
93	547	749	0		0	\N	\N
95	554	424	0		0	\N	\N
96	117	43	0		0	\N	\N
97	117	143	0		0	\N	\N
98	120	119	0		0	\N	\N
99	120	163	0		0	\N	\N
100	123	292	0		0	\N	\N
101	123	454	0		0	\N	\N
102	130	113	0		0	\N	\N
103	130	225	0		0	\N	\N
104	131	504	0		0	\N	\N
105	133	321	0		0	\N	\N
106	556	136	0		0	\N	\N
107	556	512	0		0	\N	\N
108	134	339	0		0	\N	\N
109	136	5	0		0	\N	\N
110	136	284	0		0	\N	\N
111	557	380	0		0	\N	\N
112	139	108	0		0	\N	\N
113	139	229	0		0	\N	\N
114	141	108	0		0	\N	\N
115	142	83	0		0	\N	\N
116	145	41	0		0	\N	\N
117	148	427	0		0	\N	\N
118	150	58	0		0	\N	\N
119	153	467	0		0	\N	\N
120	156	427	0		0	\N	\N
121	161	202	0		0	\N	\N
122	558	458	0		0	\N	\N
123	558	459	0		0	\N	\N
124	166	420	0		0	\N	\N
125	178	362	0		0	\N	\N
126	172	204	0		0	\N	\N
127	176	272	0		0	\N	\N
128	183	467	0		0	\N	\N
129	186	222	0		0	\N	\N
130	186	238	0		0	\N	\N
131	186	261	0		0	\N	\N
132	188	271	0		0	\N	\N
136	198	432	0		0	\N	\N
137	198	433	0		0	\N	\N
139	207	70	0		0	\N	\N
140	207	454	0		0	\N	\N
141	204	118	0		0	\N	\N
142	204	164	0		0	\N	\N
143	204	293	0		0	\N	\N
144	206	8	0		0	\N	\N
145	206	52	0		0	\N	\N
146	206	91	0		0	\N	\N
150	214	58	0		0	\N	\N
151	214	344	0		0	\N	\N
152	216	438	0		0	\N	\N
153	561	169	0		0	\N	\N
154	564	319	0		0	\N	\N
155	232	26	0		0	\N	\N
156	232	475	0		0	\N	\N
158	237	410	0		0	\N	\N
159	568	26	0		0	\N	\N
160	568	27	0		0	\N	\N
161	241	723	0		0	\N	\N
162	241	734	0		0	\N	\N
163	244	435	0		0	\N	\N
164	244	436	0		0	\N	\N
165	247	215	0		0	\N	\N
166	247	216	0		0	\N	\N
167	249	373	0		0	\N	\N
168	249	401	0		0	\N	\N
169	249	453	0		0	\N	\N
170	250	139	0		0	\N	\N
171	250	142	0		0	\N	\N
172	250	499	0		0	\N	\N
173	251	169	0		0	\N	\N
174	252	732	0		0	\N	\N
175	252	738	0		0	\N	\N
176	253	742	0		0	\N	\N
177	254	333	0		0	\N	\N
178	254	349	0		0	\N	\N
179	255	21	0		0	\N	\N
180	255	46	0		0	\N	\N
181	255	471	0		0	\N	\N
182	256	48	0		0	\N	\N
183	256	153	0		0	\N	\N
184	256	284	0		0	\N	\N
185	257	28	0		0	\N	\N
186	257	360	0		0	\N	\N
187	257	385	0		0	\N	\N
188	572	215	0		0	\N	\N
189	573	42	0		0	\N	\N
190	573	198	0		0	\N	\N
191	263	234	0		0	\N	\N
192	263	454	0		0	\N	\N
193	267	172	0		0	\N	\N
194	267	220	0		0	\N	\N
196	275	209	0		0	\N	\N
198	282	66	0		0	\N	\N
199	282	142	0		0	\N	\N
200	282	216	0		0	\N	\N
201	577	140	0		0	\N	\N
203	286	234	0		0	\N	\N
204	579	730	0		0	\N	\N
205	290	109	0		0	\N	\N
206	290	160	0		0	\N	\N
207	293	272	0		0	\N	\N
208	297	271	0		0	\N	\N
209	302	122	0		0	\N	\N
210	306	275	0		0	\N	\N
211	307	119	0		0	\N	\N
212	116	410	0		0	\N	\N
213	311	546	0		0	\N	\N
214	320	546	0		0	\N	\N
215	312	129	0		0	\N	\N
216	315	526	0		0	\N	\N
217	325	526	0		0	\N	\N
218	317	179	0		0	\N	\N
219	323	288	0		0	\N	\N
220	347	220	0		0	\N	\N
221	348	220	0		0	\N	\N
222	356	67	0		0	\N	\N
223	356	141	0		0	\N	\N
224	358	71	0		0	\N	\N
225	358	76	0		0	\N	\N
226	359	274	0		0	\N	\N
227	359	275	0		0	\N	\N
228	361	261	0		0	\N	\N
229	361	272	0		0	\N	\N
230	363	272	0		0	\N	\N
231	424	153	0		0	\N	\N
232	424	401	0		0	\N	\N
233	448	362	0		0	\N	\N
234	399	116	0		0	\N	\N
235	387	685	0		0	\N	\N
236	388	691	0		0	\N	\N
237	389	690	0		0	\N	\N
238	395	48	0		0	\N	\N
239	398	397	0		0	\N	\N
240	398	464	0		0	\N	\N
241	400	289	0		0	\N	\N
242	401	350	0		0	\N	\N
243	401	681	0		0	\N	\N
244	402	119	0		0	\N	\N
245	405	353	0		0	\N	\N
246	405	680	0		0	\N	\N
247	407	162	0		0	\N	\N
248	407	364	0		0	\N	\N
249	408	392	0		0	\N	\N
250	408	394	0		0	\N	\N
251	411	355	0		0	\N	\N
252	423	178	0		0	\N	\N
253	423	449	0		0	\N	\N
254	430	770	0		0	\N	\N
255	428	1	0		0	\N	\N
256	428	259	0		0	\N	\N
257	428	295	0		0	\N	\N
258	429	276	0		0	\N	\N
259	431	79	0		0	\N	\N
260	431	259	0		0	\N	\N
261	436	132	0		0	\N	\N
262	436	194	0		0	\N	\N
263	436	304	0		0	\N	\N
264	442	316	0		0	\N	\N
265	442	320	0		0	\N	\N
266	439	257	0		0	\N	\N
267	439	387	0		0	\N	\N
268	587	238	0		0	\N	\N
269	587	239	0		0	\N	\N
270	452	243	0		0	\N	\N
271	452	245	0		0	\N	\N
272	455	75	0		0	\N	\N
273	18	239	0		0	\N	\N
275	463	298	0		0	\N	\N
276	466	604	0		0	\N	\N
277	473	230	0		0	\N	\N
278	475	136	0		0	\N	\N
280	476	382	0		0	\N	\N
281	590	513	0		0	\N	\N
282	478	187	0		0	\N	\N
283	491	244	0		0	\N	\N
284	491	730	0		0	\N	\N
285	495	182	0		0	\N	\N
287	505	28	0		0	\N	\N
289	508	288	0		0	\N	\N
290	510	146	0		0	\N	\N
291	513	119	0		0	\N	\N
292	514	424	0		0	\N	\N
293	596	302	0		0	\N	\N
294	596	305	0		0	\N	\N
295	521	90	0		0	\N	\N
296	205	318	0		0	\N	\N
297	205	398	0		0	\N	\N
298	202	143	0		0	\N	\N
301	260	121	0		0	\N	\N
303	515	100	0		0	\N	\N
304	496	375	0		0	\N	\N
305	200	377	0		0	\N	\N
717	4	820	0	\N	0	\N	0
718	5	821	0	\N	0	\N	0
719	7	822	0	\N	0	\N	0
720	10	823	0	\N	0	\N	0
721	13	824	0		0	\N	0
722	14	825	0		0	\N	0
723	16	826	0	\N	0	\N	0
724	17	827	0		0	\N	0
725	20	828	0		0	\N	0
726	21	829	0		0	\N	0
727	22	830	0		0	\N	0
728	23	831	0		0	\N	0
729	26	832	0	\N	0	\N	0
730	27	833	0		0	\N	0
731	28	834	0		0	\N	0
732	29	835	0		0	\N	0
733	30	836	0		0	\N	0
734	31	837	0		0	\N	0
735	32	838	0		0	\N	0
736	34	839	0		0	\N	0
737	35	840	0	\N	0	\N	0
738	36	841	0		0	\N	0
739	37	842	0		0	\N	0
740	38	843	0		0	\N	0
741	39	844	0		0	\N	0
742	40	845	0		0	\N	0
743	41	846	0		0	\N	0
744	42	847	0		0	\N	0
745	43	848	0		0	\N	0
746	45	849	0		0	\N	0
747	46	850	0		0	\N	0
748	47	851	0		0	\N	0
749	48	852	0		0	\N	0
750	53	853	0		0	\N	0
751	56	854	0		0	\N	0
752	57	855	0		0	\N	0
753	58	856	0		0	\N	0
754	59	857	0		0	\N	0
755	60	858	0		0	\N	0
756	61	859	0		0	\N	0
757	66	860	0		0	\N	0
758	67	861	0		0	\N	0
759	69	862	0		0	\N	0
760	71	863	0		0	\N	0
761	73	864	0		0	\N	0
762	74	865	0		0	\N	0
763	75	866	0		0	\N	0
764	77	867	0		0	\N	0
765	78	868	0	\N	0	\N	0
766	79	869	0		0	\N	0
767	80	870	0		0	\N	0
768	81	871	0		0	\N	0
769	82	872	0		0	\N	0
770	86	873	0		0	\N	0
771	88	874	0		0	\N	0
772	89	875	0		0	\N	0
773	90	876	0	\N	0	\N	0
774	92	877	0		0	\N	0
775	93	878	0		0	\N	0
776	94	879	0		0	\N	0
777	95	880	0		0	\N	0
778	96	881	0		0	\N	0
779	97	882	0		0	\N	0
780	99	883	0		0	\N	0
781	100	884	0	\N	0	\N	0
782	101	885	0		0	\N	0
783	102	886	0		0	\N	0
784	103	887	0		0	\N	0
785	105	888	0		0	\N	0
786	110	889	0		0	\N	0
787	111	890	0		0	\N	0
788	114	891	0		0	\N	0
789	115	892	0		0	\N	0
790	118	893	0		0	\N	0
791	119	894	0		0	\N	0
792	121	895	0		0	\N	0
793	122	896	0		0	\N	0
794	124	897	0		0	\N	0
795	125	898	0		0	\N	0
796	126	899	0		0	\N	0
797	127	900	0		0	\N	0
798	128	901	0		0	\N	0
799	129	902	0		0	\N	0
800	132	903	0		0	\N	0
801	135	904	0		0	\N	0
802	137	905	0		0	\N	0
803	138	906	0		0	\N	0
804	140	907	0		0	\N	0
805	143	908	0		0	\N	0
806	144	909	0		0	\N	0
807	146	910	0		0	\N	0
808	147	911	0		0	\N	0
809	149	912	0		0	\N	0
810	151	913	0		0	\N	0
811	152	914	0		0	\N	0
812	154	915	0		0	\N	0
813	155	916	0		0	\N	0
814	157	917	0		0	\N	0
815	158	918	0		0	\N	0
816	159	919	0		0	\N	0
817	160	920	0		0	\N	0
818	163	921	0		0	\N	0
819	164	922	0		0	\N	0
820	165	923	0		0	\N	0
821	167	924	0		0	\N	0
822	168	925	0		0	\N	0
823	169	926	0		0	\N	0
824	170	927	0		0	\N	0
825	171	928	0		0	\N	0
826	173	929	0		0	\N	0
827	174	930	0		0	\N	0
828	177	931	0		0	\N	0
829	179	932	0		0	\N	0
830	180	933	0		0	\N	0
831	181	934	0		0	\N	0
832	182	935	0		0	\N	0
833	184	936	0		0	\N	0
834	185	937	0		0	\N	0
835	187	938	0		0	\N	0
836	189	939	0		0	\N	0
837	190	940	0		0	\N	0
838	192	941	0		0	\N	0
839	193	942	0		0	\N	0
840	194	943	0		0	\N	0
841	195	944	0		0	\N	0
842	196	945	0		0	\N	0
843	197	946	0		0	\N	0
844	199	947	0		0	\N	0
845	201	948	0		0	\N	0
846	203	949	0	\N	0	\N	0
847	208	950	0		0	\N	0
848	209	951	0		0	\N	0
849	211	952	0		0	\N	0
850	212	953	0		0	\N	0
851	213	954	0		0	\N	0
852	217	955	0		0	\N	0
853	218	956	0		0	\N	0
854	219	957	0		0	\N	0
855	220	958	0		0	\N	0
856	221	959	0		0	\N	0
857	222	960	0		0	\N	0
858	223	961	0		0	\N	0
859	225	962	0		0	\N	0
860	227	963	0		0	\N	0
861	228	964	0		0	\N	0
862	229	965	0		0	\N	0
863	230	966	0		0	\N	0
864	231	967	0		0	\N	0
865	234	968	0	\N	0	\N	0
866	235	969	0		0	\N	0
867	236	970	0		0	\N	0
868	238	971	0		0	\N	0
869	239	972	0		0	\N	0
870	240	973	0		0	\N	0
871	242	974	0		0	\N	0
872	243	975	0	\N	0	\N	0
873	245	976	0	\N	0	\N	0
874	246	977	0	\N	0	\N	0
875	248	978	0	\N	0	\N	0
876	261	979	0	\N	0	\N	0
877	262	980	0	\N	0	\N	0
878	264	981	0		0	\N	0
879	265	982	0	\N	0	\N	0
880	266	983	0	\N	0	\N	0
881	268	984	0		0	\N	0
882	269	985	0	\N	0	\N	0
883	270	986	0	\N	0	\N	0
884	271	987	0	\N	0	\N	0
885	272	988	0	\N	0	\N	0
886	273	989	0	\N	0	\N	0
887	274	990	0	\N	0	\N	0
888	276	991	0	\N	0	\N	0
889	277	992	0	\N	0	\N	0
890	278	993	0	\N	0	\N	0
891	280	994	0	\N	0	\N	0
892	281	995	0	\N	0	\N	0
893	284	996	0		0	\N	0
894	285	997	0	\N	0	\N	0
895	287	998	0	\N	0	\N	0
896	289	999	0	\N	0	\N	0
897	291	1000	0	\N	0	\N	0
898	292	1001	0	\N	0	\N	0
899	294	1002	0	\N	0	\N	0
900	295	1003	0	\N	0	\N	0
901	296	1004	0		0	\N	0
902	298	1005	0	\N	0	\N	0
903	299	1006	0	\N	0	\N	0
904	300	1007	0		0	\N	0
905	301	1008	0	\N	0	\N	0
906	303	1009	0		0	\N	0
907	304	1010	0		0	\N	0
908	305	1011	0		0	\N	0
909	308	1012	0	\N	0	\N	0
910	309	1013	0	\N	0	\N	0
911	310	1014	0	\N	0	\N	0
912	313	1015	0	\N	0	\N	0
913	314	1016	0		0	\N	0
914	316	1017	0	\N	0	\N	0
915	318	1018	0		0	\N	0
916	319	1019	0	\N	0	\N	0
917	321	1020	0	\N	0	\N	0
918	322	1021	0	\N	0	\N	0
919	324	1022	0		0	\N	0
920	326	1023	0		0	\N	0
921	327	1024	0	\N	0	\N	0
922	328	1025	0	\N	0	\N	0
923	329	1026	0	\N	0	\N	0
924	330	1027	0	\N	0	\N	0
925	331	1028	0		0	\N	0
926	332	1029	0	\N	0	\N	0
927	333	1030	0	\N	0	\N	0
928	334	1031	0		0	\N	0
929	335	1032	0	\N	0	\N	0
930	336	1033	0	\N	0	\N	0
931	337	1034	0	\N	0	\N	0
932	338	1035	0	\N	0	\N	0
933	339	1036	0	\N	0	\N	0
934	340	1037	0	\N	0	\N	0
935	341	1038	0	\N	0	\N	0
936	342	1039	0	\N	0	\N	0
937	343	1040	0	\N	0	\N	0
938	344	1041	0		0	\N	0
939	345	1042	0	\N	0	\N	0
940	349	1043	0	\N	0	\N	0
941	350	1044	0	\N	0	\N	0
942	351	1045	0		0	\N	0
943	352	1046	0	\N	0	\N	0
944	353	1047	0	\N	0	\N	0
945	354	1048	0		0	\N	0
946	355	1049	0	\N	0	\N	0
947	357	1050	0	\N	0	\N	0
948	360	1051	0	\N	0	\N	0
949	362	1052	0	\N	0	\N	0
950	364	1053	0	\N	0	\N	0
951	365	1054	0		0	\N	0
952	366	1055	0	\N	0	\N	0
953	367	1056	0		0	\N	0
954	368	1057	0		0	\N	0
955	369	1058	0	\N	0	\N	0
956	370	1059	0	\N	0	\N	0
957	371	1060	0	\N	0	\N	0
958	372	1061	0		0	\N	0
959	373	1062	0	\N	0	\N	0
960	374	1063	0		0	\N	0
961	375	1064	0		0	\N	0
962	376	1065	0	\N	0	\N	0
963	377	1066	0	\N	0	\N	0
964	378	1067	0	\N	0	\N	0
965	379	1068	0	\N	0	\N	0
966	380	1069	0	\N	0	\N	0
967	383	1070	0	\N	0	\N	0
968	384	1071	0	\N	0	\N	0
970	386	1073	0	\N	0	\N	0
971	390	1074	0	\N	0	\N	0
972	391	1075	0		0	\N	0
973	392	1076	0	\N	0	\N	0
974	393	1077	0		0	\N	0
975	394	1078	0		0	\N	0
976	396	1079	0	\N	0	\N	0
977	397	1080	0	\N	0	\N	0
978	410	1081	0	\N	0	\N	0
979	412	1082	0	\N	0	\N	0
980	413	1083	0		0	\N	0
981	414	1084	0	\N	0	\N	0
982	415	1085	0		0	\N	0
983	416	1086	0		0	\N	0
984	417	1087	0		0	\N	0
985	418	1088	0	\N	0	\N	0
986	419	1089	0		0	\N	0
987	420	1090	0	\N	0	\N	0
988	425	1091	0		0	\N	0
989	432	1092	0	\N	0	\N	0
990	433	1093	0	\N	0	\N	0
991	434	1094	0	\N	0	\N	0
992	435	1095	0		0	\N	0
993	437	1096	0	\N	0	\N	0
994	438	1097	0	\N	0	\N	0
995	440	1098	0	\N	0	\N	0
996	441	1099	0	\N	0	\N	0
997	443	1100	0	\N	0	\N	0
998	444	1101	0		0	\N	0
999	445	1102	0	\N	0	\N	0
1000	446	1103	0		0	\N	0
1001	447	1104	0	\N	0	\N	0
1002	449	1105	0	\N	0	\N	0
1003	450	1106	0	\N	0	\N	0
1004	453	1107	0	\N	0	\N	0
1005	454	1108	0	\N	0	\N	0
1006	456	1109	0		0	\N	0
1007	457	1110	0		0	\N	0
1008	458	1111	0	\N	0	\N	0
1009	459	1112	0		0	\N	0
1010	460	1113	0	\N	0	\N	0
1011	461	1114	0	\N	0	\N	0
1012	462	1115	0		0	\N	0
1013	464	1116	0	\N	0	\N	0
1014	465	1117	0	\N	0	\N	0
1015	467	1118	0		0	\N	0
1016	468	1119	0	\N	0	\N	0
1017	469	1120	0	\N	0	\N	0
1018	470	1121	0	\N	0	\N	0
1019	471	1122	0	\N	0	\N	0
1020	472	1123	0	\N	0	\N	0
1021	474	1124	0	\N	0	\N	0
1022	477	1125	0		0	\N	0
1023	479	1126	0		0	\N	0
1024	480	1127	0	\N	0	\N	0
1025	481	1128	0		0	\N	0
1026	482	1129	0		0	\N	0
1027	483	1130	0		0	\N	0
1028	484	1131	0	\N	0	\N	0
1029	485	1132	0		0	\N	0
1030	486	1133	0	\N	0	\N	0
1031	487	1134	0	\N	0	\N	0
1032	488	1135	0	\N	0	\N	0
1033	489	1136	0		0	\N	0
1034	490	1137	0	\N	0	\N	0
1035	492	1138	0	\N	0	\N	0
1036	493	1139	0		0	\N	0
1037	494	1140	0	\N	0	\N	0
1038	498	1141	0	\N	0	\N	0
1039	499	1142	0	\N	0	\N	0
1040	500	1143	0	\N	0	\N	0
1041	501	1144	0	\N	0	\N	0
1042	502	1145	0	\N	0	\N	0
1043	503	1146	0	\N	0	\N	0
1044	504	1147	0	\N	0	\N	0
1045	506	1148	0		0	\N	0
1046	507	1149	0		0	\N	0
1047	509	1150	0	\N	0	\N	0
1048	511	1151	0		0	\N	0
1049	512	1152	0	\N	0	\N	0
1050	516	1153	0		0	\N	0
1051	517	1154	0	\N	0	\N	0
1052	518	1155	0		0	\N	0
1053	519	1156	0		0	\N	0
1054	520	1157	0	\N	0	\N	0
1055	525	1158	0	\N	0	\N	0
1056	526	1159	0	\N	0	\N	0
1057	527	1160	0	\N	0	\N	0
1058	529	1161	0	\N	0	\N	0
1059	530	1162	0	\N	0	\N	0
1060	531	1163	0	\N	0	\N	0
1061	533	1164	0	\N	0	\N	0
1062	534	1165	0	\N	0	\N	0
1063	535	1166	0		0	\N	0
1064	537	1167	0	\N	0	\N	0
1065	538	1168	0		0	\N	0
1066	539	1169	0	\N	0	\N	0
1067	540	1170	0		0	\N	0
1068	543	1171	0		0	\N	0
1069	546	1172	0		0	\N	0
1070	548	1173	0	\N	0	\N	0
1071	549	1174	0		0	\N	0
1072	551	1175	0		0	\N	0
1073	552	1176	0	\N	0	\N	0
1074	555	1177	0		0	\N	0
1075	559	1178	0	\N	0	\N	0
1076	560	1179	0	\N	0	\N	0
1077	562	1180	0	\N	0	\N	0
1078	565	1181	0	\N	0	\N	0
1079	566	1182	0	\N	0	\N	0
1080	567	1183	0	\N	0	\N	0
1081	569	1184	0	\N	0	\N	0
1082	571	1185	0	\N	0	\N	0
1083	574	1186	0	\N	0	\N	0
1084	575	1187	0		0	\N	0
1085	576	1188	0		0	\N	0
1086	578	1189	0	\N	0	\N	0
1087	580	1190	0	\N	0	\N	0
1088	581	1191	0	\N	0	\N	0
1089	582	1192	0		0	\N	0
1090	583	1193	0	\N	0	\N	0
1091	584	1194	0	\N	0	\N	0
1092	585	1195	0	\N	0	\N	0
1093	586	1196	0	\N	0	\N	0
1094	588	1197	0	\N	0	\N	0
1095	589	1198	0		0	\N	0
1096	591	1199	0	\N	0	\N	0
1097	592	1200	0	\N	0	\N	0
1098	593	1201	0		0	\N	0
1099	594	1202	0	\N	0	\N	0
1100	595	1203	0	\N	0	\N	0
1101	597	1204	0		0	\N	0
1102	598	1205	0		0	\N	0
1103	599	1206	0	\N	0	\N	0
1104	600	1207	0	\N	0	\N	0
1105	601	1208	0		0	\N	0
1106	602	1209	0	\N	0	\N	0
1107	603	1210	0		0	\N	0
1108	604	1211	0	\N	0	\N	0
1109	605	1212	0		0	\N	0
1110	606	1213	0		0	\N	0
1112	608	1215	0	\N	0	\N	0
1113	609	1216	0	\N	0	\N	0
1114	610	1217	0	\N	0	\N	0
1115	611	1218	0	\N	0	\N	0
1116	612	1219	0		0	\N	0
1117	613	1220	0		0	\N	0
1118	614	1221	0		0	\N	0
1119	615	1222	0	\N	0	\N	0
1120	616	1223	0		0	\N	0
1121	617	1224	0	\N	0	\N	0
1122	618	1225	0	\N	0	\N	0
1123	619	1226	0	\N	0	\N	0
1124	620	1227	0	\N	0	\N	0
1126	622	1229	0	\N	0	\N	0
1127	258	281	1		0	\N	0
1128	258	139	2		0	\N	0
1129	258	1230	3		0	\N	0
1130	256	72	0		0	\N	0
1131	257	320	0		0	\N	0
1132	288	61	1		0	\N	0
1133	288	56	2		0	\N	0
1134	288	1231	3		0	\N	0
1135	607	1214	1		0	\N	0
1136	607	1232	2		0	\N	0
1143	497	270	1		0	\N	0
1144	497	1235	2		0	\N	0
1146	553	1236	2		0	\N	0
1147	279	819	1		0	\N	0
1148	279	1237	2		0	\N	0
1149	224	530	1		0	\N	0
1150	224	1238	2		0	\N	0
1152	283	1239	2		0	\N	0
1154	451	1234	0		0	\N	0
1155	15	1233	1		0	\N	0
1156	15	543	2		0	\N	0
1157	191	496	0		0	\N	0
1158	191	70	1		0	\N	0
1159	623	387	0	dipakai	0	\N	0
1160	623	542	1		0	\N	0
1161	385	1072	1		0	\N	0
1162	315	971	0		0	\N	0
1163	624	1240	1		0	\N	0
1164	625	1241	1		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: id
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
590	1
116	24
117	24
78	8
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
62	mulai	1	M	\N
63	paling	\N	\N	\N
64	depan	1	D	\N
65	asal	\N	\N	\N
66	umur	\N	\N	\N
67	hobi	\N	\N	\N
68	dua puluh	\N	\N	\N
69	tahun	1	T	\N
70	membaca	1	B	\N
71	berikut	\N	\N	\N
72	akan	\N	\N	\N
73	menyerahkan	\N	\N	\N
74	tugas	1	T	\N
75	minggu	1	M	\N
76	lalu	\N	\N	\N
77	mengapa	\N	\N	\N
78	terlambat	\N	\N	\N
79	karena	\N	\N	\N
80	sakit	1	S	\N
81	surat	1	S	\N
82	keterangan	\N	\N	\N
83	dokter	1	D	\N
84	baik	1	B	\N
85	sekali	\N	\N	\N
86	lagi	\N	\N	\N
87	juga	\N	\N	\N
88	sudah	1	S	\N
89	belum	1	B	\N
90	membawa	\N	\N	\N
91	kue	1	K	\N
92	lho	\N	\N	\N
93	makan	1	M	\N
94	onde-onde	\N	\N	\N
95	enak	1	E	\N
96	syukur	\N	\N	\N
97	suka	1	S	\N
98	pandai	\N	\N	\N
99	membuat	1	B	\N
100	sedang	\N	\N	\N
101	masih	1	M	\N
102	baru	1	B	\N
103	saja	\N	\N	\N
104	selesai	\N	\N	\N
105	latihan	1	L	\N
106	gamelan	\N	\N	\N
107	ikut	\N	\N	\N
108	unit	\N	\N	\N
109	tetapi	\N	\N	\N
110	belajar	1	A	\N
111	sulit	1	S	\N
112	terlalu	\N	\N	\N
113	janji	\N	\N	\N
114	teman	1	T	\N
115	mari	1	M	\N
116	mencari	\N	\N	\N
117	buku	1	B	\N
118	penerbit	\N	\N	\N
119	PT	\N	\N	\N
120	betul	\N	\N	\N
121	harga	\N	\N	\N
122	rupiah	\N	\N	\N
123	diskon	\N	\N	\N
124	sekarang	\N	\N	\N
125	membeli	1	B	\N
126	pernah	\N	\N	\N
127	sastra	\N	\N	\N
128	ujian	1	U	\N
129	harus	\N	\N	\N
130	banyak	1	B	\N
131	karya	\N	\N	\N
132	misalnya	\N	\N	\N
133	puisi	\N	\N	\N
134	atau	\N	\N	\N
135	novel	\N	\N	\N
136	kelihatannya	\N	\N	\N
137	menarik	1	T	\N
138	lumayan	\N	\N	\N
139	setiap	\N	\N	\N
140	PR	1	P	\N
141	libur	1	L	\N
142	panjang	1	P	\N
143	kita	1	K	\N
144	berlibur	\N	\N	\N
145	kira-kira	\N	\N	\N
146	dua	\N	\N	\N
147	bulan	\N	\N	\N
148	bagaimana	1	B	\N
149	rencana	\N	\N	\N
150	liburan	\N	\N	\N
151	punya	\N	\N	\N
152	pergi	1	P	\N
153	ke	\N	\N	\N
154	melihat	\N	\N	\N
155	untuk	\N	\N	\N
156	berenang	1	R	\N
157	pantai	\N	\N	\N
158	bukan	\N	\N	\N
159	mengunjungi	\N	\N	\N
160	nenek	1	N	\N
161	mengerjakan	1	K	\N
162	laporan	\N	\N	\N
163	sampai	1	S	\N
164	setengah	\N	\N	\N
165	halaman	\N	\N	\N
166	lima	\N	\N	\N
167	kata	1	K	\N
168	dosen	1	D	\N
169	minimal	\N	\N	\N
170	delapan	\N	\N	\N
171	bagian	\N	\N	\N
172	terakhir	\N	\N	\N
173	benar	\N	\N	\N
174	bersama	\N	\N	\N
175	ide	\N	\N	\N
176	bagus	1	B	\N
177	setelah	\N	\N	\N
178	bertemu	1	T	\N
179	perpustakaan	1	P	\N
180	satu	\N	\N	\N
181	syarat	\N	\N	\N
182	menjadi	1	J	\N
183	anggota	\N	\N	\N
184	mengisi	\N	\N	\N
185	formulir	\N	\N	\N
186	pendaftaran	\N	\N	\N
187	mendaftar	\N	\N	\N
188	apakah	\N	\N	\N
189	buka	\N	\N	\N
190	jam	1	J	\N
191	pagi	1	P	\N
192	sore	1	S	\N
193	tutup	\N	\N	\N
194	meminjam	1	P	\N
195	beberapa	\N	\N	\N
196	buah	1	B	\N
197	katalog	\N	\N	\N
198	empat	\N	\N	\N
199	waktu	1	W	\N
200	peminjaman	\N	\N	\N
201	lama	1	L	\N
202	-kah	\N	\N	\N
203	memperpanjang	\N	\N	\N
204	lebih dari	\N	\N	\N
205	sama	\N	\N	\N
206	pemberitahuan	\N	\N	\N
207	tentang	\N	\N	\N
208	bahwa	\N	\N	\N
209	mendapat	\N	\N	\N
210	paket	1	P	\N
211	seseorang	1	S	\N
212	sendiri	\N	\N	\N
213	cara	\N	\N	\N
214	tahu	\N	\N	\N
215	besar	1	B	\N
216	sini	1	S	\N
217	maksud	\N	\N	\N
218	hanya	\N	\N	\N
219	kartu	\N	\N	\N
220	menunjukkan	\N	\N	\N
221	kepada	\N	\N	\N
222	besok	1	B	\N
223	mungkin	1	M	\N
224	kiriman	\N	\N	\N
225	kampung	\N	\N	\N
226	datang	\N	\N	\N
227	Jepang	\N	\N	\N
228	orang	1	O	\N
229	gawat	\N	\N	\N
230	berbahasa	\N	\N	\N
231	jangan	\N	\N	\N
232	mengkhawatirkan	\N	\N	\N
233	berbicara	1	B	\N
234	dia	1	D	\N
235	hebat	\N	\N	\N
236	pintar	1	P	\N
237	Inggris	\N	\N	\N
238	sayang	\N	\N	\N
239	mahir	\N	\N	\N
240	asrama	\N	\N	\N
241	langsung	1	L	\N
242	naik	1	N	\N
243	angkot	\N	\N	\N
244	turun	1	T	\N
245	terminal	\N	\N	\N
246	becak	\N	\N	\N
247	jalan	1	J	\N
248	sebelah	1	B	\N
249	berada	\N	\N	\N
250	tepat	1	T	\N
251	samping	1	S	\N
252	warung	1	W	\N
253	kopi	1	K	\N
254	katanya	\N	\N	\N
255	pacar	\N	\N	\N
256	kok	\N	\N	\N
257	seperti	\N	\N	\N
258	ramah	\N	\N	\N
259	serius	\N	\N	\N
260	cakap	\N	\N	\N
261	menurut	\N	\N	\N
262	mata	1	M	\N
263	hidung	1	H	\N
264	mancung	\N	\N	\N
265	Prancis	\N	\N	\N
266	seluruh	\N	\N	\N
267	menulis	1	T	\N
268	dalam	1	D	\N
269	adalah	\N	\N	\N
270	mengira	\N	\N	\N
271	huruf	\N	\N	\N
272	lucu	1	L	\N
273	CD	\N	\N	\N
274	grup	\N	\N	\N
275	populer	\N	\N	\N
276	lagu	1	L	\N
277	mendengar	\N	\N	\N
278	lebih	\N	\N	\N
279	dangdut	\N	\N	\N
280	irama	\N	\N	\N
281	mendayu-dayu	\N	\N	\N
282	daripada	\N	\N	\N
283	selera	\N	\N	\N
284	memang	\N	\N	\N
285	berbeda	\N	\N	\N
286	kedua	\N	\N	\N
287	aliran	\N	\N	\N
288	kelihatan	\N	\N	\N
289	capek	\N	\N	\N
290	tenis	\N	\N	\N
291	mengikuti	\N	\N	\N
292	klub	\N	\N	\N
293	memancing	\N	\N	\N
294	tempat	\N	\N	\N
295	pemancingan	\N	\N	\N
296	ikan	1	I	\N
297	kapan	1	K	\N
298	kapan-kapan	\N	\N	\N
299	mengajak	\N	\N	\N
300	memasak	\N	\N	\N
301	nasi	1	N	\N
302	goreng	\N	\N	\N
303	gampang	1	G	\N
304	pertama-tama	\N	\N	\N
305	menyiapkan	\N	\N	\N
306	bahan	\N	\N	\N
307	telur	1	T	\N
308	cabai	\N	\N	\N
309	bawang	\N	\N	\N
310	putih	1	P	\N
311	mau	1	M	\N
312	menambahkan	\N	\N	\N
313	daging	1	D	\N
314	ayam	\N	\N	\N
315	sosis	\N	\N	\N
316	mengiris	\N	\N	\N
317	halus	\N	\N	\N
318	miring	\N	\N	\N
319	sendok	1	S	\N
320	minyak	\N	\N	\N
321	memanaskan	\N	\N	\N
322	semua	1	S	\N
323	bumbu	\N	\N	\N
324	telah	1	T	\N
325	memasukkan	1	M	\N
326	wajan	\N	\N	\N
327	matang	\N	\N	\N
328	garam	1	G	\N
329	gula	1	G	\N
330	sedikit	1	S	\N
331	menceplok	\N	\N	\N
332	meletakkan	\N	\N	\N
333	atas	1	A	\N
334	terlihat	\N	\N	\N
335	mengundang	\N	\N	\N
336	halo	\N	\N	\N
337	keadaan	\N	\N	\N
338	tidak 	\N	\N	\N
339	masuk	\N	\N	\N
340	sibuk	1	S	\N
341	melakukan	1	L	\N
342	membantu	\N	\N	\N
343	persiapan	\N	\N	\N
344	pesta	1	P	\N
345	pernikahan	\N	\N	\N
346	kakak	1	K	\N
347	hari	\N	\N	\N
348	Minggu	\N	\N	\N
349	piknik	\N	\N	\N
350	kami	1	K	\N
351	menjemput	\N	\N	\N
352	pada	\N	\N	\N
353	jam delapan	\N	\N	\N
354	oke	\N	\N	\N
355	hujan	1	H	\N
356	meskipun	\N	\N	\N
357	memutuskan	\N	\N	\N
358	tetap	\N	\N	\N
359	berangkat	1	B	\N
360	jalanan	\N	\N	\N
361	licin	\N	\N	\N
362	perjalanan	1	J	\N
363	berhenti	\N	\N	\N
364	Lebaran	\N	\N	\N
365	nanti	\N	\N	\N
366	bis	1	B	\N
367	murah	1	M	\N
368	membandingkan	\N	\N	\N
369	cepat	1	C	\N
370	biaya	\N	\N	\N
371	mahal	1	M	\N
372	segala	\N	\N	\N
373	sesuatu	\N	\N	\N
374	kelebihan	\N	\N	\N
375	kekurangan	\N	\N	\N
377	lowongan	\N	\N	\N
378	sebagai	\N	\N	\N
379	pramuniaga	\N	\N	\N
380	toserba	1	T	\N
381	Matahari	\N	\N	\N
382	sangat	\N	\N	\N
383	guru	1	G	\N
384	sanggup	\N	\N	\N
385	yakin	\N	\N	\N
386	pasti	\N	\N	\N
387	minta	\N	\N	\N
388	izin	\N	\N	\N
389	kenapa	\N	\N	\N
390	pulang	1	P	\N
391	urusan	\N	\N	\N
392	mendadak	\N	\N	\N
393	kamu	1	K	\N
394	tiga	\N	\N	\N
395	beasiswa	\N	\N	\N
396	universitas	1	U	\N
397	persyaratan	\N	\N	\N
398	rekomendasi	\N	\N	\N
399	mohon	\N	\N	\N
400	membuatkan	\N	\N	\N
401	batas	\N	\N	\N
402	Kamis	1	K	\N
403	jadi	1	J	\N
404	Rabu	1	R	\N
405	Mas	\N	\N	\N
406	menyebut	\N	\N	\N
407	festival	\N	\N	\N
408	kebudayaan	\N	\N	\N
409	biasanya	\N	\N	\N
410	musim	\N	\N	\N
411	gugur	\N	\N	\N
412	mengadakan	\N	\N	\N
413	kampus	\N	\N	\N
414	acara	\N	\N	\N
415	mengenalkan	\N	\N	\N
416	demo	\N	\N	\N
417	masakan	1	M	\N
418	minum	1	M	\N
419	teh	1	T	\N
420	pemutaran	\N	\N	\N
421	film	1	F	\N
422	selama	\N	\N	\N
423	memesan	\N	\N	\N
424	bakso	\N	\N	\N
425	porsi	\N	\N	\N
426	membungkus	\N	\N	\N
427	habis	\N	\N	\N
428	mi	\N	\N	\N
429	lupa	\N	\N	\N
430	sambal	\N	\N	\N
431	tanpa	\N	\N	\N
432	uang	1	U	\N
433	kabar	\N	\N	\N
434	kamus	1	K	\N
435	memakai	1	P	\N
436	mengumpulkan	\N	\N	\N
437	menikah	\N	\N	\N
438	ruangan	\N	\N	\N
439	sepuluh	\N	\N	\N
440	pemilik	\N	\N	\N
441	(sepeda) motor	\N	\N	\N
442	melarang	\N	\N	\N
443	memarkir	\N	\N	\N
444	tempat parkir	\N	\N	\N
445	belakang	1	B	\N
446	gedung	1	G	\N
447	pesanan	\N	\N	\N
448	nah	\N	\N	\N
449	mengantar	\N	\N	\N
450	rumah	1	R	\N
451	pertama	\N	\N	\N
452	terus	\N	\N	\N
453	berjalan	\N	\N	\N
454	berhati-hati	\N	\N	\N
455	dua hari	\N	\N	\N
456	kepala	1	K	\N
457	tenggorokan	\N	\N	\N
458	memeriksa	\N	\N	\N
459	demam	\N	\N	\N
460	beristirahat	\N	\N	\N
461	makanan	1	M	\N
462	sementara	\N	\N	\N
463	berminyak	\N	\N	\N
464	mandi	1	M	\N
465	mengembalikan	1	K	\N
466	sejarah	\N	\N	\N
467	sebetulnya	\N	\N	\N
468	menyelesaikan	\N	\N	\N
469	tiket	1	T	\N
470	gratis	\N	\N	\N
471	sungguh	\N	\N	\N
472	lelah	\N	\N	\N
473	kurang	\N	\N	\N
474	tidur	1	T	\N
475	cukup	\N	\N	\N
476	obat	1	O	\N
477	resep	\N	\N	\N
478	sebaiknya	\N	\N	\N
479	menjelaskan	\N	\N	\N
480	kemari	\N	\N	\N
481	sempat	\N	\N	\N
482	tentu	\N	\N	\N
483	menyampaikan	\N	\N	\N
484	agar	\N	\N	\N
486	jam dua belas	\N	\N	\N
487	mari	0	M	\N
488	mentraktir	\N	\N	\N
489	selamat	\N	\N	\N
490	terserah	\N	\N	\N
491	deh	\N	\N	\N
492	asyik	\N	\N	\N
493	asing	\N	\N	\N
494	tertarik	\N	\N	\N
495	bahasa Inggris	1	B	\N
496	pesawat terbang	1	P	\N
497	luar negeri	1	L	\N
498	orang asing	1	O	\N
499	bahasa Prancis	0	B	\N
500	hotel	1	H	\N
501	bahasa Jepang	1	B	\N
502	negeri	1	N	\N
503	pariwisata	1	P	\N
504	berpariwisata	1	P	\N
505	bermain	1	M	\N
506	kedutaan besar	1	D	\N
507	suka sekali	1	S	\N
508	berlari	1	L	\N
509	perlahan-lahan	1	P	\N
510	tidak pintar	1	P	\N
511	berjalan kaki	1	J	\N
512	melompat	1	L	\N
513	olahraga	1	O	\N
514	tidak suka	1	S	\N
515	kolam renang	1	K	\N
516	bus	1	B	\N
517	sepeda	1	S	\N
518	persimpangan	1	S	\N
519	kolam	1	K	\N
520	jalan-jalan	1	J	\N
521	sungai	1	S	\N
522	taksi	1	T	\N
523	mobil	1	M	\N
524	bengkok	1	B	\N
525	dasi	1	D	\N
526	kemeja	1	K	\N
527	perusahaan	1	U	\N
530	telepon	1	T	\N
531	pekerjaan	1	K	\N
532	bekerja	1	K	\N
533	surat kabar	1	S	\N
534	fotokopi	1	F	\N
535	memfotokopi	1	F	\N
536	majalah	1	M	\N
537	jilid	1	J	\N
538	daging sapi	1	D	\N
539	toko	1	T	\N
540	tinggi	1	T	\N
541	sayur	1	S	\N
542	daging babi	1	D	\N
543	daging ayam	1	D	\N
544	memberi	1	B	\N
545	toko sayur	1	T	\N
546	kunci	1	K	\N
547	berbelanja	1	B	\N
548	mencuci	1	C	\N
549	membersihkan	1	B	\N
550	keluarga	1	K	\N
551	rumah tangga	1	R	\N
552	kebun	1	K	\N
554	pembersihan	1	B	\N
555	rak buku	1	R	\N
556	meja	1	M	\N
557	kursi	1	K	\N
558	kamar	1	K	\N
559	kulkas	1	K	\N
560	tempat tidur	1	T	\N
561	radio	1	R	\N
562	kaset	0	K	\N
563	bernama	1	N	\N
564	bangun	1	B	\N
565	televisi	1	T	\N
566	polisi	1	P	\N
567	peta	1	P	\N
568	dekat	1	D	\N
569	pos polisi	1	P	\N
570	memotong	1	P	\N
571	pendek	1	P	\N
572	kanan	1	K	\N
573	kiri	1	K	\N
574	duduk	1	D	\N
575	berdiri	1	D	\N
576	kelas	1	K	\N
577	ruang kelas	1	R	\N
578	koridor	1	K	\N
579	sekolah	1	S	\N
580	murid	1	M	\N
581	pelajaran	1	A	\N
582	mahasiswa asing	1	M	\N
583	liburan musim panas	1	L	\N
584	buku catatan	1	B	\N
585	karangan	1	K	\N
586	pekerjaan rumah	1	K	\N
587	mengajar	1	A	\N
588	mudah	1	M	\N
589	berlatih	1	L	\N
590	soal	1	S	\N
591	menjawab	1	J	\N
592	gigi	1	G	\N
593	rumah sakit	1	R	\N
594	penyakit	1	S	\N
595	mati	1	M	\N
596	flu	1	F	\N
597	perut	1	P	\N
598	derajat	1	D	\N
599	lift	1	L	\N
600	karcis	1	K	\N
601	tangga	1	T	\N
602	menutup	1	T	\N
603	stasiun	1	S	\N
604	kereta bawah tanah	1	K	\N
605	membuka	1	B	\N
606	kamar kecil	1	K	\N
607	kereta listrik	1	K	\N
608	minuman	1	M	\N
609	warung kopi	1	W	\N
610	sitrun	1	S	\N
611	susu	1	S	\N
612	cangkir 	1	C	\N
613	gelas	1	G	\N
614	manis	1	M	\N
615	sumpit	1	S	\N
616	minuman keras	1	M	\N
617	pisau	1	P	\N
618	garpu	1	G	\N
619	keju	1	K	\N
620	tidak enak	1	E	\N
621	roti	1	R	\N
622	pedas	1	P	\N
623	restoran	1	R	\N
624	kantin	1	K	\N
625	anggur	1	A	\N
626	kari	1	K	\N
627	bank	1	B	\N
628	pintu masuk	1	P	\N
629	pintu keluar	1	P	\N
631	kartu pos	1	K	\N
632	menempelkan	1	T	\N
633	amplop	1	A	\N
634	kantor pos	1	K	\N
635	mengirim	1	K	\N
636	perangko	1	P	\N
637	barang	1	B	\N
638	helai	1	H	\N
639	meminjamkan	1	P	\N
640	topi	1	T	\N
641	sepatu	1	S	\N
642	belanja	1	B	\N
643	lantai	1	L	\N
644	toko serba ada	1	T	\N
645	rok	1	R	\N
646	jas	1	J	\N
647	celana	1	C	\N
648	sweter	1	S	\N
649	tas	1	T	\N
650	menjual	1	J	\N
651	kamar mandi	1	K	\N
652	dapur	1	D	\N
653	shower	1	S	\N
654	jendela	1	J	\N
655	tinggal	1	T	\N
656	taman	1	T	\N
657	pintu	1	P	\N
658	apartemen	1	A	\N
659	mereka	1	M	\N
660	siapa	1	S	\N
661	begini	1	B	\N
662	diri sendiri	1	D	\N
663	tebal	1	T	\N
664	sempit	1	S	\N
665	kurus	1	K	\N
666	muda	1	M	\N
667	luas	1	L	\N
668	ringan	1	R	\N
669	jauh	1	J	\N
670	berat	1	B	\N
671	tipis	1	T	\N
672	kecil	1	K	\N
673	ramai	1	R	\N
674	rendah	1	R	\N
675	terang	1	T	\N
676	lemah	1	L	\N
677	kuat	1	K	\N
678	bersih	1	B	\N
679	lambat	1	L	\N
680	buruk	1	B	\N
681	gelap	1	G	\N
682	tenang	1	T	\N
683	kotor	1	K	\N
684	bosan	1	B	\N
685	lebar	1	L	\N
686	luar	1	L	\N
687	timur	1	T	\N
688	utara	1	U	\N
689	barat	1	B	\N
690	bawah	1	B	\N
691	selatan	1	S	\N
692	saudara sepupu	1	S	\N
693	kakak laki-laki	1	K	\N
694	saudara	1	S	\N
695	kakek	1	K	\N
696	nyonya	1	N	\N
697	paman	1	P	\N
698	orang tua	1	O	\N
699	ayah	1	A	\N
700	kakak perempuan	1	K	\N
701	bibi	1	B	\N
702	kaus kaki	1	K	\N
703	kaus	1	K	\N
704	menggantungkan	1	G	\N
705	mengenakan	1	K	\N
706	sapu tangan	1	S	\N
707	selop	1	S	\N
708	payung	1	P	\N
709	saku	1	S	\N
710	dompet	1	D	\N
711	berpakaian	1	P	\N
712	pakaian	1	P	\N
713	mulut	1	M	\N
714	lengan	1	L	\N
715	badan	1	B	\N
716	muka	1	M	\N
717	kaki	1	K	\N
718	tangan	1	T	\N
719	telinga	1	T	\N
720	piring	1	P	\N
721	mentega	1	M	\N
722	permen	1	P	\N
723	makan siang	1	M	\N
724	makan malam	1	M	\N
725	makan pagi	1	M	\N
726	kecap asin	1	K	\N
727	menambah	1	T	\N
728	memasang	1	P	\N
729	kamera	1	K	\N
730	pemanas	1	P	\N
731	pensil	1	P	\N
732	mematikan	1	M	\N
733	kacamata	1	K	\N
734	komputer	1	K	\N
735	pulpen	1	P	\N
736	bolpoin	1	B	\N
737	Agustus	1	A	\N
738	April	1	A	\N
739	bulan ini	1	B	\N
740	setiap bulan	1	S	\N
741	Desember	1	D	\N
742	Februari	1	F	\N
743	Januari	1	J	\N
744	Juli	1	J	\N
745	Juni	1	J	\N
746	bulan depan	1	B	\N
747	Mei	1	M	\N
748	Maret	1	M	\N
749	bulan yang lalu	1	B	\N
750	November	1	N	\N
751	Oktober	1	O	\N
752	September	1	S	\N
753	sebulan	1	B	\N
754	minggu ini	1	M	\N
755	setiap minggu	1	S	\N
756	minggu depan	1	M	\N
757	Senin	1	S	\N
758	Selasa	1	S	\N
759	Sabtu	1	S	\N
760	minggu yang lalu	1	M	\N
761	Jumat	1	J	\N
762	musim gugur	1	M	\N
763	tahun ini	1	T	\N
764	setiap tahun	1	S	\N
765	musim panas	1	M	\N
766	musim dingin	1	M	\N
767	tahun yang lalu	1	T	\N
768	tahun depan	1	T	\N
769	musim semi	1	M	\N
770	dua tahun lagi	1	D	\N
771	dua tahun yang lalu	1	D	\N
772	hari ini	1	H	\N
773	kemarin  	1	K	\N
774	malam	1	M	\N
775	siang	1	S	\N
776	lusa	1	L	\N
777	kemarin dulu	1	K	\N
778	sambil	1	S	\N
779	sepanjang	1	P	\N
780	kadang-kadang	1	K	\N
781	sering	1	S	\N
782	segera	1	S	\N
783	asbak	1	A	\N
784	nyanyian	1	N	\N
785	menyanyi	1	N	\N
786	rokok	1	R	\N
787	piringan hitam	1	P	\N
788	gitar	1	G	\N
789	musik	1	M	\N
790	gambar	1	G	\N
791	foto	1	F	\N
792	suara	1	S	\N
793	cuaca cerah	1	C	\N
794	panas	1	P	\N
816	istri	1	I	\N
817	perempuan	1	P	\N
818	anak laki-laki	1	A	\N
819	laki-laki	1	L	\N
820	anak perempuan	1	A	\N
821	suami	1	S	\N
822	biru	1	B	\N
823	cokelat	1	C	\N
824	warna	1	W	\N
825	tua	1	T	\N
826	kuning	1	K	\N
827	hitam	1	H	\N
828	hijau	1	H	\N
829	kemudahan	1	M	\N
830	kertas	1	K	\N
831	mendorong	1	D	\N
832	tidak ada	0	T	\N
833	lurus	1	L	\N
834	terkenal	1	K	\N
835	sehat	1	S	\N
836	barangkali	1	B	\N
838	merokok	1	R	\N
839	negeri asing	1	N	\N
840	negara	1	N	\N
841	berjumpa	1	J	\N
842	istirahat	1	I	\N
843	gemar	1	G	\N
844	pelan-pelan	1	P	\N
845	benci	1	B	\N
846	berjalan-jalan	1	J	\N
847	kali	1	K	\N
848	berbelok	1	B	\N
849	kantor	1	K	\N
850	koran	1	K	\N
851	buah-buahan	1	B	\N
852	memberikan	1	B	\N
853	bis surat	1	B	\N
854	menyapu	1	S	\N
855	kembali	1	K	\N
856	ruang	1	R	\N
857	sahabat	1	S	\N
858	galpu	0	G	\N
859	sama-sama	1	S	\N
860	mengirimkan	1	K	\N
861	lembar	1	L	\N
862	tiba	1	T	\N
863	bangunan	1	B	\N
864	jaket	1	J	\N
865	siapa saja	1	S	\N
866	seperti ini	1	S	\N
867	seperti apa	1	S	\N
868	diri	1	D	\N
869	menyenangkan	1	S	\N
870	gembira	1	G	\N
871	indah	1	I	\N
872	cantik	1	C	\N
873	jelek	1	J	\N
874	jahat	1	J	\N
875	sepi	1	S	\N
876	membosankan	1	B	\N
877	tadi malam	1	T	\N
878	ketika	1	K	\N
879	lukisan	1	L	\N
880	berkata	1	K	\N
881	bahasa Indonesia	1	B	\N
882	kalimat	1	K	\N
883	wanita	1	W	\N
884	pria	1	P	\N
885	manusia	1	M	\N
886	mengikat	1	I	\N
887	sarapan	1	S	\N
888	pukul	1	P	\N
889	cuci	1	C	\N
890	lemari es	1	L	\N
891	sukar	1	S	\N
892	susah	1	S	\N
893	tes	1	T	\N
894	mengajarkan	1	A	\N
895	susu sapi	1	S	\N
896	tubuh	1	T	\N
897	cuti	1	C	\N
899	jeruk lemon	1	J	\N
900	tep	1	T	0
553	pencucian	0	C	\N
630	pos surat	0	P	\N
1		0	\N	\N
837	abulibo	0	B	\N
485	ia	0	I	\N
898	metro	0	M	\N
2	Bapak	\N	\N	\N
3	ada	\N	\N	\N
4	kuliah	1	K	\N
5	ya	1	Y	\N
6	apa	\N	\N	\N
7	linguistik	\N	\N	\N
8	begitu	1	B	\N
9	maaf	\N	\N	\N
10	saya	1	S	\N
11	permisi	1	P	\N
12	dulu	\N	\N	\N
13	silakan	1	S	\N
14	ingin	1	I	\N
15	mengambil	\N	\N	\N
16	daftar	\N	\N	\N
17	nilai	\N	\N	\N
18	semester	\N	\N	\N
19	ini	1	I	\N
20	nama	\N	\N	\N
21	berapa	1	B	\N
22	nomor	\N	\N	\N
23	mahasiswa	1	M	\N
24	Anda	1	A	\N
25	dan	\N	\N	\N
26	jurusan	\N	\N	\N
27	bahasa	1	B	\N
28	Indonesia	\N	\N	\N
29	menunggu	\N	\N	\N
30	sebentar	\N	\N	\N
31	Mbak	\N	\N	\N
32	tolong	1	T	\N
33	mengambilkan	\N	\N	\N
34	baju	1	B	\N
35	yang	\N	\N	\N
36	menggantung	\N	\N	\N
37	di	\N	\N	\N
38	situ	1	S	\N
39	mana	1	M	\N
40	merah	1	M	\N
41	itu	1	I	\N
42	boleh	\N	\N	\N
43	mencoba	\N	\N	\N
44	kamar pas	\N	\N	\N
45	pojok	\N	\N	\N
46	sana	1	S	\N
47	ibu	1	I	\N
48	memperkenalkan	\N	\N	\N
49	dari	\N	\N	\N
50	Jakarta	\N	\N	\N
51	senang	1	S	\N
52	bisa	\N	\N	\N
53	berkenalan	\N	\N	\N
54	dengan	\N	\N	\N
55	bertanya	1	T	\N
56	apa(kah)	\N	\N	\N
57	pertanyaan	1	T	\N
58	lain	\N	\N	\N
59	kalau	\N	\N	\N
60	tidak	1	T	\N
61	memperkenalkan diri	\N	\N	\N
376	informasi	\N	\N	\N
528	setelan	1	S	\N
529	mengisap	1	I	\N
795	cerah	1	C	\N
796	sejuk	1	S	\N
797	dingin	1	D	\N
798	salju	1	S	\N
799	turun hujan	1	T	\N
800	cuaca	1	C	\N
801	hangat	1	H	\N
802	angin	1	A	\N
803	mendung	1	M	\N
804	huruf kanji	1	H	\N
805	mengatakan	1	K	\N
806	cerita	1	C	\N
807	tulisan	1	T	\N
808	bercerita	1	C	\N
809	arti	1	A	\N
810	huruf hiragana	1	H	\N
811	huruf katakana	1	H	\N
812	dewasa	1	D	\N
813	banyak orang	1	B	\N
814	suami istri	1	S	\N
815	anak	1	A	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: id
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, ptoken, inst_id) FROM stdin;
1	selamat pagi	おはようございます		\N	\N	\N	\N	1
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	1
3	ada	ある，いる		\N	\N	\N	\N	3
4	kuliah	講義		\N	\N	\N	\N	3
6	apa	何		\N	\N	\N	\N	5
7	linguistik	言語学		\N	\N	\N	\N	6
8	begitu	そのような，そのように		\N	\N	\N	\N	7
9	maaf	ごめんなさい		\N	\N	\N	\N	8
10	saya	私		\N	\N	\N	\N	8
11	permisi	失礼します（挨拶），すみません（呼びかけ）		\N	\N	\N	\N	8
12	dulu	まず，ちょっと，先に		\N	\N	\N	\N	8
13	silakan	どうぞ		\N	\N	\N	\N	9
11	permisi	失礼します（挨拶），すみません（呼びかけ）		\N	\N	\N	\N	12
3	ada	ある，いる		\N	\N	\N	\N	13
10	saya	私		\N	\N	\N	\N	14
14	ingin	～したい		\N	\N	\N	\N	14
15	mengambil	取る		\N	\N	\N	\N	14
16	daftar	表		\N	\N	\N	\N	14
17	nilai	価値，成績		\N	\N	\N	\N	14
18	semester	学期		\N	\N	\N	\N	14
20	nama	名前		\N	\N	\N	\N	15
21	berapa	いくつ，いくら		\N	\N	\N	\N	16
22	nomor	番号		\N	\N	\N	\N	16
23	mahasiswa	大学生		\N	\N	\N	\N	16
24	Anda	あなた		\N	\N	\N	\N	16
25	dan	～と～，そして		\N	\N	\N	\N	16
26	jurusan	学科		\N	\N	\N	\N	16
6	apa	何		\N	\N	\N	\N	16
27	bahasa	言語		\N	\N	\N	\N	18
28	Indonesia	インドネシア		\N	\N	\N	\N	18
29	tunggu	待つ		\N	\N	\N	\N	19
30	sebentar	少しの間		\N	\N	\N	\N	19
1	terima kasih	ありがとう		\N	\N	\N	\N	22
1	sama-sama	どういたしまして		\N	\N	\N	\N	23
11	permisi	失礼します（挨拶），すみません（呼びかけ）		\N	\N	\N	\N	24
3	ada	ある，いる		\N	\N	\N	\N	25
6	apa	何		\N	\N	\N	\N	25
31	Mbak	お姉さん，年上の女性に対する呼称		\N	\N	\N	\N	25
32	tolong	～してください		\N	\N	\N	\N	26
33	ambilkan	取ってやる		\N	\N	\N	\N	26
34	baju	服		\N	\N	\N	\N	26
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	26
36	digantung	掛ける		\N	\N	\N	\N	26
37	di	～に，～で		\N	\N	\N	\N	26
38	situ	そこ		\N	\N	\N	\N	26
39	mana	どこ，どちら		\N	\N	\N	\N	27
40	merah	赤い		\N	\N	\N	\N	28
41	itu	その，それ		\N	\N	\N	\N	28
29	tunggu	待つ		\N	\N	\N	\N	29
30	sebentar	少しの間		\N	\N	\N	\N	29
42	boleh	～しても良い		\N	\N	\N	\N	30
43	dicoba	試す		\N	\N	\N	\N	30
12	dulu	まず，ちょっと，先に		\N	\N	\N	\N	30
13	silakan	どうぞ		\N	\N	\N	\N	31
44	kamar pasnya	試着室		\N	\N	\N	\N	32
45	pojok	かど，すみ		\N	\N	\N	\N	33
46	sana	あそこ，向こう		\N	\N	\N	\N	33
1	selamat siang	こんにちは		\N	\N	\N	\N	34
47	Bu	目上の女性に対する呼称、先生		\N	\N	\N	\N	34
48	perkenalkan	紹介する		\N	\N	\N	\N	36
20	nama	名前		\N	\N	\N	\N	36
10	saya	私		\N	\N	\N	\N	36
49	dari	～から		\N	\N	\N	\N	37
50	Jakarta	ジャカルタ		\N	\N	\N	\N	37
51	senang	嬉しい		\N	\N	\N	\N	38
52	bisa	～できる		\N	\N	\N	\N	38
53	berkenalan	知り合いになる		\N	\N	\N	\N	38
54	dengan	～（人）と，～（もの）で		\N	\N	\N	\N	38
24	Anda	あなた		\N	\N	\N	\N	38
55	tanya	質問する		\N	\N	\N	\N	39
37	di	～で，～に		\N	\N	\N	\N	39
39	mana	どこ，どちら		\N	\N	\N	\N	39
56	apa	～か？		\N	\N	\N	\N	41
3	ada	ある，いる		\N	\N	\N	\N	41
57	pertanyaan	質問		\N	\N	\N	\N	41
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	41
58	lain	他の		\N	\N	\N	\N	41
59	kalau	もし～なら		\N	\N	\N	\N	42
60	tidak	～ない		\N	\N	\N	\N	42
32	tolong	～してください		\N	\N	\N	\N	42
61	perkenalkan diri	自己紹介する		\N	\N	\N	\N	42
62	mulai	始める		\N	\N	\N	\N	43
49	dari	～から		\N	\N	\N	\N	43
23	mahasiswa	大学生		\N	\N	\N	\N	43
63	paling	最も		\N	\N	\N	\N	43
64	depan	前		\N	\N	\N	\N	43
65	asal	出身		\N	\N	\N	\N	45
21	berapa	いくつ，いくら		\N	\N	\N	\N	47
66	umurnya	年齢		\N	\N	\N	\N	47
25	dan	～と～，そして		\N	\N	\N	\N	47
6	apa	何		\N	\N	\N	\N	47
67	hobinya	趣味		\N	\N	\N	\N	47
1	bulan Oktober	10月		\N	\N	\N	\N	48
68	dua puluh	20		\N	\N	\N	\N	48
69	tahun	年，歳		\N	\N	\N	\N	48
70	membaca	読む		\N	\N	\N	\N	49
1	terima kasih	ありがとう		\N	\N	\N	\N	50
71	berikutnya	次の		\N	\N	\N	\N	51
13	silakan	どうぞ		\N	\N	\N	\N	51
11	permisi	失礼します（挨拶），すみません（呼びかけ）		\N	\N	\N	\N	52
47	Bu	目上の女性に対する呼称，先生		\N	\N	\N	\N	52
13	silakan	どうぞ		\N	\N	\N	\N	53
3	ada	ある，いる		\N	\N	\N	\N	54
6	apa	何		\N	\N	\N	\N	54
10	saya	私		\N	\N	\N	\N	55
72	akan	～する（予定）		\N	\N	\N	\N	55
73	menyerahkan	提出する		\N	\N	\N	\N	55
74	tugas	課題，任務		\N	\N	\N	\N	55
75	minggu	週		\N	\N	\N	\N	55
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	55
76	lalu	過ぎた		\N	\N	\N	\N	55
77	mengapa	なぜ		\N	\N	\N	\N	56
78	terlambat	遅れる		\N	\N	\N	\N	56
1	minta maaf	ごめんなさい		\N	\N	\N	\N	57
79	karena	～なので		\N	\N	\N	\N	57
80	sakit	痛い，病気だ		\N	\N	\N	\N	57
81	surat	手紙，書類		\N	\N	\N	\N	58
82	keterangan	説明		\N	\N	\N	\N	58
49	dari	～から		\N	\N	\N	\N	58
83	dokter	医者		\N	\N	\N	\N	58
84	baiklah	よい，わかりました		\N	\N	\N	\N	60
85	sekali	一度		\N	\N	\N	\N	61
86	lagi	また		\N	\N	\N	\N	61
1	tidak apa-apa	大丈夫		\N	\N	\N	\N	62
1	apa kabar?	元気ですか。		\N	\N	\N	\N	63
84	baik	よい，元気だ		\N	\N	\N	\N	64
59	kalau	もし～ならば，～は		\N	\N	\N	\N	65
87	juga	～も		\N	\N	\N	\N	66
88	sudah	もう，既に		\N	\N	\N	\N	67
1	makan siang	昼食をとる		\N	\N	\N	\N	67
89	belum	まだ～ない		\N	\N	\N	\N	68
10	saya	私		\N	\N	\N	\N	69
90	membawa	持ってくる，持っていく		\N	\N	\N	\N	69
91	kue	お菓子		\N	\N	\N	\N	69
92	lho	～よ		\N	\N	\N	\N	69
13	silakan	どうぞ		\N	\N	\N	\N	70
93	dimakan	食べる		\N	\N	\N	\N	70
6	apa	何		\N	\N	\N	\N	71
20	namanya	名前		\N	\N	\N	\N	72
94	onde-onde	オンデオンデ（お菓子の名前）：ゴマ団子のようなお菓子		\N	\N	\N	\N	72
95	enak	おいしい，心地よい		\N	\N	\N	\N	73
85	sekali	とても		\N	\N	\N	\N	73
1	terima kasih	ありがとう		\N	\N	\N	\N	74
96	syukurlah	良かった（神に感謝して）		\N	\N	\N	\N	75
97	suka	好む，気に入る		\N	\N	\N	\N	75
98	pandai	上手だ		\N	\N	\N	\N	76
99	membuat	作る		\N	\N	\N	\N	76
100	sedang	～している		\N	\N	\N	\N	78
6	apa	何		\N	\N	\N	\N	78
1	selamat sore	こんにちは		\N	\N	\N	\N	79
47	Bu	目上の女性に対する呼称，先生		\N	\N	\N	\N	79
101	masih	まだ		\N	\N	\N	\N	81
3	ada	ある，いる		\N	\N	\N	\N	81
4	kuliah	講義		\N	\N	\N	\N	81
60	tidak	～ない		\N	\N	\N	\N	82
10	saya	私		\N	\N	\N	\N	83
102	baru	新しい，たった今～した		\N	\N	\N	\N	83
103	saja	～だけ		\N	\N	\N	\N	83
104	selesai	終わる，終える		\N	\N	\N	\N	83
105	latihan	練習		\N	\N	\N	\N	83
106	gamelan	ガムラン（インドネシア地域の伝統音楽）		\N	\N	\N	\N	83
107	ikut	参加する，ついて行く		\N	\N	\N	\N	84
108	unit	サークル		\N	\N	\N	\N	84
109	tapi	でも		\N	\N	\N	\N	85
110	belajar	勉強する，習う		\N	\N	\N	\N	85
41	itu	その，それ		\N	\N	\N	\N	86
111	sulit	難しい		\N	\N	\N	\N	86
112	terlalu	～すぎる		\N	\N	\N	\N	87
9	maaf	ごめんなさい		\N	\N	\N	\N	88
113	janji	約束		\N	\N	\N	\N	88
54	dengan	～（人）と，～（もの）で		\N	\N	\N	\N	88
114	teman	友達		\N	\N	\N	\N	88
13	silakan	どうぞ		\N	\N	\N	\N	89
115	mari	それでは，失礼します		\N	\N	\N	\N	90
11	permisi	失礼します（挨拶），すみません（呼びかけ）		\N	\N	\N	\N	91
10	saya	私		\N	\N	\N	\N	91
116	mencari	探す		\N	\N	\N	\N	91
117	buku	本		\N	\N	\N	\N	91
7	Linguistik	言語学		\N	\N	\N	\N	91
28	Indonesia	インドネシア		\N	\N	\N	\N	91
6	apa	何		\N	\N	\N	\N	92
20	nama	名前		\N	\N	\N	\N	92
118	penerbitnya	出版社		\N	\N	\N	\N	92
119	PT	株式会社(perseroan terbatas の略)		\N	\N	\N	\N	93
29	tunggu	待つ		\N	\N	\N	\N	94
30	sebentar	少しの間		\N	\N	\N	\N	94
120	betul	正しい		\N	\N	\N	\N	96
21	berapa	いくら，いくつ		\N	\N	\N	\N	97
121	harganya	値段		\N	\N	\N	\N	97
122	rupiah	ルピア（インドネシアの通貨）		\N	\N	\N	\N	98
60	tidak	～ない		\N	\N	\N	\N	99
3	ada	ある，いる		\N	\N	\N	\N	99
123	diskon	割引，ディスカウント		\N	\N	\N	\N	99
9	maaf	ごめんなさい		\N	\N	\N	\N	100
124	sekarang	今		\N	\N	\N	\N	100
1	kalau begitu	それでは		\N	\N	\N	\N	102
125	beli	買う		\N	\N	\N	\N	102
84	baik	良い，わかりました		\N	\N	\N	\N	103
126	pernah	～したことがある		\N	\N	\N	\N	106
15	mengambil	取る		\N	\N	\N	\N	106
4	kuliah	講義		\N	\N	\N	\N	106
127	sastra	文学		\N	\N	\N	\N	106
28	Indonesia	インドネシア		\N	\N	\N	\N	106
128	ujiannya	試験		\N	\N	\N	\N	108
111	sulit	難しい		\N	\N	\N	\N	108
60	tidak	～ない		\N	\N	\N	\N	109
109	tetapi	しかし		\N	\N	\N	\N	109
129	harus	～しなければならない		\N	\N	\N	\N	109
70	membaca	読む		\N	\N	\N	\N	109
130	banyak	多い，たくさん		\N	\N	\N	\N	109
131	karya	作品		\N	\N	\N	\N	109
132	misalnya	例えば		\N	\N	\N	\N	110
133	puisi	詩		\N	\N	\N	\N	110
134	atau	～または～		\N	\N	\N	\N	110
135	novel	小説，ノベル		\N	\N	\N	\N	110
136	kelihatannya	～のようだ		\N	\N	\N	\N	112
137	menarik	興味をそそる		\N	\N	\N	\N	112
1	omong-omong	ところで		\N	\N	\N	\N	113
23	mahasiswa	大学生		\N	\N	\N	\N	113
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	113
41	itu	その，それ		\N	\N	\N	\N	113
138	lumayan	まあまあ		\N	\N	\N	\N	114
1	kalau begitu	それでは		\N	\N	\N	\N	115
10	saya	私		\N	\N	\N	\N	115
87	juga	～も		\N	\N	\N	\N	115
72	akan	～する（予定）		\N	\N	\N	\N	115
18	semester	学期		\N	\N	\N	\N	115
71	berikut	次の		\N	\N	\N	\N	115
139	setiap	毎～		\N	\N	\N	\N	116
75	minggu	週		\N	\N	\N	\N	116
3	ada	ある，いる		\N	\N	\N	\N	116
140	PR	宿題(pekerjaan rumah の略)		\N	\N	\N	\N	116
92	lho	～よ		\N	\N	\N	\N	116
1	tidak apa-apa	大丈夫		\N	\N	\N	\N	118
75	minggu	週		\N	\N	\N	\N	119
64	depan	前，次の（曜日，週，月，年）		\N	\N	\N	\N	119
62	mulai	始まる		\N	\N	\N	\N	119
141	libur	休暇		\N	\N	\N	\N	119
142	panjang	長い		\N	\N	\N	\N	119
143	kita	私達（聞き手を含む）		\N	\N	\N	\N	120
72	akan	～する（予定）		\N	\N	\N	\N	120
144	libur	休暇をとる		\N	\N	\N	\N	120
145	kira-kira	だいたい		\N	\N	\N	\N	120
146	dua	2		\N	\N	\N	\N	120
147	bulan	月		\N	\N	\N	\N	120
1	dua bulan	２ヵ月		\N	\N	\N	\N	120
148	bagaimana	どのような，どのように		\N	\N	\N	\N	121
149	rencana	予定		\N	\N	\N	\N	121
150	liburannya	休暇期間		\N	\N	\N	\N	121
10	saya	私		\N	\N	\N	\N	122
151	punya	持っている		\N	\N	\N	\N	122
152	pergi	行く		\N	\N	\N	\N	122
153	ke	～へ		\N	\N	\N	\N	122
1	Sumatera Utara	北スマトラ（州の名前）		\N	\N	\N	\N	122
3	ada	ある，いる		\N	\N	\N	\N	124
6	apa	何		\N	\N	\N	\N	124
37	di	～に，～で		\N	\N	\N	\N	124
46	sana	あそこ，向こう		\N	\N	\N	\N	124
14	ingin	～したい		\N	\N	\N	\N	125
154	melihat	見る		\N	\N	\N	\N	125
1	Danau Toba	トバ湖		\N	\N	\N	\N	125
1	bagaimana dengan ～?	～はどうですか。		\N	\N	\N	\N	126
155	untuk	～のために		\N	\N	\N	\N	128
156	berenang	泳ぐ		\N	\N	\N	\N	128
157	pantai	海岸		\N	\N	\N	\N	128
158	bukan	～ではない		\N	\N	\N	\N	129
159	mengunjungi	～を訪れる		\N	\N	\N	\N	129
160	nenek	祖母		\N	\N	\N	\N	129
8	begitu	そのような，そのように		\N	\N	\N	\N	130
88	sudah	もう，既に		\N	\N	\N	\N	131
161	mengerjakan	～する		\N	\N	\N	\N	131
162	laporan	レポート		\N	\N	\N	\N	131
7	Linguistik	言語学		\N	\N	\N	\N	131
109	tapi	しかし		\N	\N	\N	\N	132
89	belum	まだ～ない		\N	\N	\N	\N	132
104	selesai	終わる		\N	\N	\N	\N	132
39	mana	どこ，どちら		\N	\N	\N	\N	133
102	baru	新しい，やっと		\N	\N	\N	\N	134
164	setengah	半分		\N	\N	\N	\N	134
21	berapa	いくつ，いくら		\N	\N	\N	\N	135
165	halaman	ページ		\N	\N	\N	\N	135
166	lima	５		\N	\N	\N	\N	136
167	kata	語，～（人）が言うには		\N	\N	\N	\N	136
168	dosen	（大学の）先生		\N	\N	\N	\N	136
169	minimal	最低，ミニマル		\N	\N	\N	\N	136
170	delapan	８		\N	\N	\N	\N	136
171	bagian	部分		\N	\N	\N	\N	137
172	terakhir	最後		\N	\N	\N	\N	137
63	paling	最も		\N	\N	\N	\N	137
111	sulit	難しい		\N	\N	\N	\N	137
173	benar	正しい		\N	\N	\N	\N	138
1	bagaimana kalau...?	～はどうですか。		\N	\N	\N	\N	139
143	kita	私たち（聞き手を含む）		\N	\N	\N	\N	139
174	bersama	一緒に		\N	\N	\N	\N	139
41	itu	それ，その		\N	\N	\N	\N	140
175	ide	考え，アイデア		\N	\N	\N	\N	140
176	bagus	良い		\N	\N	\N	\N	140
177	setelah	～の後		\N	\N	\N	\N	141
1	makan siang	昼食をとる		\N	\N	\N	\N	141
84	baiklah	よい，わかりました		\N	\N	\N	\N	142
178	bertemu	会う		\N	\N	\N	\N	142
37	di	～で，～に		\N	\N	\N	\N	142
179	perpustakaan	図書館		\N	\N	\N	\N	142
1	lantai	床		\N	\N	\N	\N	142
180	satu	1		\N	\N	\N	\N	142
64	depan	前		\N	\N	\N	\N	143
1	pintu masuk	入口		\N	\N	\N	\N	143
9	maaf	ごめんなさい，すみません（呼びかけ）		\N	\N	\N	\N	144
2	Pak	目上の男性に対する呼称		\N	\N	\N	\N	144
5	ya	はい		\N	\N	\N	\N	145
3	ada	ある，いる		\N	\N	\N	\N	145
6	apa	何		\N	\N	\N	\N	145
181	syarat	条件		\N	\N	\N	\N	146
155	untuk	～のため，～するため		\N	\N	\N	\N	146
182	menjadi	～になる		\N	\N	\N	\N	146
183	anggota	メンバー，会員		\N	\N	\N	\N	146
179	perpustakaan	図書館		\N	\N	\N	\N	146
184	mengisi	記入する		\N	\N	\N	\N	147
185	formulir	用紙		\N	\N	\N	\N	147
186	pendaftaran	申し込み		\N	\N	\N	\N	147
1	kalau begitu	それでは		\N	\N	\N	\N	148
10	saya	私		\N	\N	\N	\N	148
14	ingin	～したい		\N	\N	\N	\N	148
187	mendaftar	申し込む		\N	\N	\N	\N	148
13	silakan	どうぞ，～してください		\N	\N	\N	\N	149
84	baik	良い，わかりました		\N	\N	\N	\N	150
188	apakah	～か？		\N	\N	\N	\N	151
173	benar	正しい		\N	\N	\N	\N	151
189	buka	開く，開いている		\N	\N	\N	\N	153
62	mulai	始まる，～から		\N	\N	\N	\N	153
190	jam	～時（間）		\N	\N	\N	\N	153
21	berapa	いくら、いくつ		\N	\N	\N	\N	153
1	jam berapa	何時		\N	\N	\N	\N	153
1	jam sembilan	９時		\N	\N	\N	\N	154
191	pagi	朝		\N	\N	\N	\N	154
192	sore	夕方		\N	\N	\N	\N	154
139	setiap	毎～		\N	\N	\N	\N	154
1	hari Minggu	日曜日		\N	\N	\N	\N	155
193	tutup	閉まっている，蓋		\N	\N	\N	\N	155
10	saya	私		\N	\N	\N	\N	156
14	ingin	～したい		\N	\N	\N	\N	156
194	meminjam	借りる		\N	\N	\N	\N	156
195	beberapa	いくつか		\N	\N	\N	\N	156
196	buah	個，冊		\N	\N	\N	\N	156
117	buku	本		\N	\N	\N	\N	156
13	silakan	どうぞ		\N	\N	\N	\N	157
24	Anda	あなた		\N	\N	\N	\N	158
52	bisa	～できる		\N	\N	\N	\N	158
154	melihat	見る		\N	\N	\N	\N	158
197	katalog	目録		\N	\N	\N	\N	158
37	di	～で，～に		\N	\N	\N	\N	158
46	sana	あそこ，向こう		\N	\N	\N	\N	158
42	boleh	～しても良い		\N	\N	\N	\N	159
194	pinjam	借りる		\N	\N	\N	\N	159
21	berapa	いくつ，いくら		\N	\N	\N	\N	159
63	paling	最も		\N	\N	\N	\N	160
130	banyak	多い		\N	\N	\N	\N	160
198	empat	４		\N	\N	\N	\N	160
199	waktu	時間，期間		\N	\N	\N	\N	161
200	peminjamannya	貸し出し		\N	\N	\N	\N	161
1	hari	日		\N	\N	\N	\N	161
201	lama	長い(時間）		\N	\N	\N	\N	162
146	dua	２		\N	\N	\N	\N	162
75	minggu	週		\N	\N	\N	\N	162
1	dua minggu	２週間		\N	\N	\N	\N	162
52	bisakah	～できる		\N	\N	\N	\N	163
202	-kah	～か？		\N	\N	\N	\N	163
203	memperpanjang	長くする，延長する		\N	\N	\N	\N	163
109	tetapi	しかし		\N	\N	\N	\N	164
60	tidak	～ない		\N	\N	\N	\N	164
204	lebih dari	～以上		\N	\N	\N	\N	164
180	satu	1		\N	\N	\N	\N	164
147	bulan	月		\N	\N	\N	\N	164
1	satu bulan	一ヶ月		\N	\N	\N	\N	164
84	baik	良い、わかりました		\N	\N	\N	\N	165
1	terima kasih	ありがとうございます		\N	\N	\N	\N	166
205	sama-sama	どういたしまして		\N	\N	\N	\N	167
19	ini	これ，この		\N	\N	\N	\N	168
206	pemberitahuan	知らせ，通知		\N	\N	\N	\N	168
207	tentang	～について		\N	\N	\N	\N	168
6	apa	何		\N	\N	\N	\N	168
81	surat	手紙，書類		\N	\N	\N	\N	169
208	bahwa	～と，～という		\N	\N	\N	\N	169
209	mendapat	得る		\N	\N	\N	\N	169
210	paket	小包		\N	\N	\N	\N	169
49	dari	～から		\N	\N	\N	\N	169
211	seseorang	誰か		\N	\N	\N	\N	169
25	dan	～と～，そして		\N	\N	\N	\N	169
129	harus	～しなければならない		\N	\N	\N	\N	169
15	mengambil(-nya)	とる		\N	\N	\N	\N	169
153	ke	～へ		\N	\N	\N	\N	169
1	kantor pos	郵便局		\N	\N	\N	\N	169
212	sendiri	自分で		\N	\N	\N	\N	169
8	begitu	そのような，そのように		\N	\N	\N	\N	170
148	bagaimana	どのように，どのような		\N	\N	\N	\N	171
213	caranya	方法		\N	\N	\N	\N	171
214	tahu	知っている		\N	\N	\N	\N	172
158	'kan	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	172
215	besar	大きい		\N	\N	\N	\N	172
216	sini	ここ		\N	\N	\N	\N	172
109	tapi	しかし		\N	\N	\N	\N	173
217	maksud	意図		\N	\N	\N	\N	173
1	setahu saya	私の知る限りでは		\N	\N	\N	\N	174
218	hanya	～だけ		\N	\N	\N	\N	174
90	membawa	持っていく，持ってくる		\N	\N	\N	\N	174
219	kartu	カード		\N	\N	\N	\N	174
23	mahasiswa	大学生		\N	\N	\N	\N	174
103	saja	～だけ		\N	\N	\N	\N	174
76	lalu	それから		\N	\N	\N	\N	175
220	tunjukkan	見せる，提示する		\N	\N	\N	\N	176
81	surat	手紙，書類		\N	\N	\N	\N	176
41	itu	その，それ		\N	\N	\N	\N	176
87	juga	～も		\N	\N	\N	\N	176
221	kepada	～（人）に		\N	\N	\N	\N	176
1	petugas	係員		\N	\N	\N	\N	176
1	kalau begitu	それでは		\N	\N	\N	\N	178
222	besok	明日		\N	\N	\N	\N	178
46	sana	あそこ、向こう		\N	\N	\N	\N	178
223	mungkin	たぶん		\N	\N	\N	\N	179
224	kiriman	送られたもの		\N	\N	\N	\N	179
1	orang tua	両親		\N	\N	\N	\N	179
225	kampung	故郷		\N	\N	\N	\N	179
51	senang	楽しい，嬉しい		\N	\N	\N	\N	180
222	besok	明日		\N	\N	\N	\N	181
72	akan	～する(予定)		\N	\N	\N	\N	181
226	datang	来る		\N	\N	\N	\N	181
23	mahasiswa	大学生		\N	\N	\N	\N	181
49	dari	～から		\N	\N	\N	\N	181
227	Jepang	日本		\N	\N	\N	\N	181
21	berapa	いくつ，いくら		\N	\N	\N	\N	182
228	orang	人		\N	\N	\N	\N	182
145	kira-kira	だいたい		\N	\N	\N	\N	183
1	lima orang	５人		\N	\N	\N	\N	183
229	gawat	大変だ		\N	\N	\N	\N	184
143	kita	私たち（聞き手を含む）		\N	\N	\N	\N	185
129	harus	～しなければならない		\N	\N	\N	\N	185
116	mencari	探す		\N	\N	\N	\N	185
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	185
52	bisa	～できる		\N	\N	\N	\N	185
230	berbahasa	（言語を）話す		\N	\N	\N	\N	185
231	jangan	～するな		\N	\N	\N	\N	186
232	khawatir	心配する		\N	\N	\N	\N	186
233	berbicara	話す		\N	\N	\N	\N	187
27	bahasa 	言語		\N	\N	\N	\N	187
120	betul	正しい		\N	\N	\N	\N	188
234	dia	彼女，彼		\N	\N	\N	\N	189
235	hebat	すごい		\N	\N	\N	\N	189
87	juga	～も		\N	\N	\N	\N	190
236	pintar	うまい		\N	\N	\N	\N	190
237	Inggris	イギリス		\N	\N	\N	\N	190
238	sayang	残念だ，もったいない		\N	\N	\N	\N	191
60	tidak	～ない		\N	\N	\N	\N	191
124	sekarang	今		\N	\N	\N	\N	192
10	saya	私		\N	\N	\N	\N	192
100	sedang	～している		\N	\N	\N	\N	192
110	belajar	勉強する		\N	\N	\N	\N	192
37	di	～で，～に		\N	\N	\N	\N	192
1	Pusat Studi Jepang	日本研究センター		\N	\N	\N	\N	192
109	tapi	しかし		\N	\N	\N	\N	194
89	belum	まだ～ない		\N	\N	\N	\N	194
239	mahir	習熟している		\N	\N	\N	\N	194
280	iramanya	リズム		\N	\N	\N	\N	242
9	maaf	ごめんなさい、すみません（呼びかけ）		\N	\N	\N	\N	195
47	Bu	目上の女性に対する呼称		\N	\N	\N	\N	195
10	saya	私		\N	\N	\N	\N	196
14	ingin	～したい		\N	\N	\N	\N	196
55	bertanya	質問する		\N	\N	\N	\N	196
13	silakan	どうぞ		\N	\N	\N	\N	197
1	mendaftarkan diri	申し込む		\N	\N	\N	\N	198
153	ke	～へ		\N	\N	\N	\N	198
240	asrama	寮		\N	\N	\N	\N	198
23	mahasiswa	大学生		\N	\N	\N	\N	198
37	di	～に，～で		\N	\N	\N	\N	198
39	mana	どこ，どちら		\N	\N	\N	\N	198
13	silakan	どうぞ，～してください		\N	\N	\N	\N	199
241	langsung	直接		\N	\N	\N	\N	199
187	daftar	申し込む		\N	\N	\N	\N	199
103	saja	～だけ		\N	\N	\N	\N	199
49	dari	～から		\N	\N	\N	\N	201
216	sini	ここ		\N	\N	\N	\N	201
242	naik	乗る，上がる		\N	\N	\N	\N	201
243	angkot	市内ミニバス (angkutan kota の略)		\N	\N	\N	\N	201
244	turun	降りる，下がる		\N	\N	\N	\N	201
245	terminal	（バスなどの）ターミナル		\N	\N	\N	\N	201
76	lalu	それから		\N	\N	\N	\N	202
246	becak	ベチャッ（3輪自転車タクシー）		\N	\N	\N	\N	202
247	jalan	道，通り		\N	\N	\N	\N	202
248	sebelah	～側		\N	\N	\N	\N	203
249	berada	ある，いる		\N	\N	\N	\N	204
250	tepat	ちょうど		\N	\N	\N	\N	204
251	samping	隣		\N	\N	\N	\N	204
252	warung	ワルン（屋台，小店）		\N	\N	\N	\N	204
253	kopi	コーヒー		\N	\N	\N	\N	204
8	begitu	そのような，そのように		\N	\N	\N	\N	205
186	pendaftarannya	申し込み		\N	\N	\N	\N	206
46	sana	あそこ，向こう		\N	\N	\N	\N	206
1	terima kasih	ありがとう		\N	\N	\N	\N	207
254	katanya	～らしい（人から聞いたことについていう）		\N	\N	\N	\N	209
151	punya	持っている		\N	\N	\N	\N	209
255	pacar	恋人		\N	\N	\N	\N	209
102	baru	新しい		\N	\N	\N	\N	209
256	kok	なぜ（kenapaの短縮形，口語でのみ使う）		\N	\N	\N	\N	211
214	tahu	知っている		\N	\N	\N	\N	211
1	"iya, dong"	「そりゃそうさ。」		\N	\N	\N	\N	212
20	namanya	名前		\N	\N	\N	\N	213
158	'kan	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	213
234	dia	彼，彼女		\N	\N	\N	\N	215
228	orangnya	人		\N	\N	\N	\N	215
257	seperti	～のような，～のように		\N	\N	\N	\N	215
6	apa	何		\N	\N	\N	\N	215
84	baik	良い		\N	\N	\N	\N	216
258	ramah	やさしい，親切だ		\N	\N	\N	\N	216
109	tapi	しかし		\N	\N	\N	\N	216
112	terlalu	～過ぎる		\N	\N	\N	\N	216
259	serius	まじめだ		\N	\N	\N	\N	216
8	begitu	そのような、そのように		\N	\N	\N	\N	217
260	cakap	容姿が良い，格好良い		\N	\N	\N	\N	217
261	menurut	～によると		\N	\N	\N	\N	218
10	saya	私		\N	\N	\N	\N	218
262	matanya	目		\N	\N	\N	\N	220
215	besar	大きい		\N	\N	\N	\N	220
263	hidungnya	鼻		\N	\N	\N	\N	220
264	mancung	（鼻が）高い		\N	\N	\N	\N	220
1	kalau begitu	それでは		\N	\N	\N	\N	221
95	enak	おいしい，心地よい，都合が良い		\N	\N	\N	\N	222
103	saja	～だけ		\N	\N	\N	\N	222
24	Anda	あなた		\N	\N	\N	\N	223
23	mahasiswa	大学生		\N	\N	\N	\N	223
26	jurusan	学科		\N	\N	\N	\N	223
27	bahasa	言語		\N	\N	\N	\N	223
265	Prancis	フランス		\N	\N	\N	\N	223
227	Jepang	日本		\N	\N	\N	\N	225
158	'kan	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	225
188	apakah	～か？		\N	\N	\N	\N	227
111	sulit	難しい		\N	\N	\N	\N	227
261	menurut	～によると		\N	\N	\N	\N	228
10	saya	私		\N	\N	\N	\N	228
60	tidak	～ない		\N	\N	\N	\N	228
266	seluruhnya	全て		\N	\N	\N	\N	228
6	apa	何		\N	\N	\N	\N	229
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	229
63	paling	最も		\N	\N	\N	\N	229
213	cara	方法		\N	\N	\N	\N	230
70	membaca	読む		\N	\N	\N	\N	230
25	dan	～と～，そして		\N	\N	\N	\N	230
267	menulisnya	書く		\N	\N	\N	\N	230
205	sama	同じ		\N	\N	\N	\N	230
1	bagaimana dengan...?	～はどうですか。		\N	\N	\N	\N	232
268	dalam	中		\N	\N	\N	\N	233
41	itu	その，それ		\N	\N	\N	\N	233
269	adalah	～である		\N	\N	\N	\N	233
8	begitu	そのような，そのように		\N	\N	\N	\N	234
109	tetapi	しかし		\N	\N	\N	\N	234
270	kira	思う		\N	\N	\N	\N	234
271	huruf	文字		\N	\N	\N	\N	234
272	lucu	おもしろい，かわいらしい		\N	\N	\N	\N	234
273	CD	CD		\N	\N	\N	\N	235
6	apa	何		\N	\N	\N	\N	235
41	itu	その，それ		\N	\N	\N	\N	235
1	Sheila On Seven	「シェイラ・オン・セブン」（インドネシアの音楽グループ）		\N	\N	\N	\N	236
124	sekarang	今		\N	\N	\N	\N	237
274	grup	グループ		\N	\N	\N	\N	237
100	sedang	～している，現在～である		\N	\N	\N	\N	237
275	populer	人気がある		\N	\N	\N	\N	237
276	lagu-lagunya	歌		\N	\N	\N	\N	238
95	enak	おいしい，心地良い		\N	\N	\N	\N	238
277	didengar	聞く		\N	\N	\N	\N	238
109	tapi	しかし		\N	\N	\N	\N	239
10	saya	私		\N	\N	\N	\N	239
278	lebih	より～		\N	\N	\N	\N	239
97	suka	好き		\N	\N	\N	\N	239
279	dangdut	ダンドゥッ（音楽のジャンル：インドネシアの大衆音楽）		\N	\N	\N	\N	239
79	karena	～なので		\N	\N	\N	\N	242
281	mendayu-dayu	子供を寝かしつける，（歌が）心にしみる		\N	\N	\N	\N	242
1	musik pop	ポップミュージック		\N	\N	\N	\N	243
282	daripada	～よりも		\N	\N	\N	\N	243
283	selera	好み		\N	\N	\N	\N	244
228	orang	人　		\N	\N	\N	\N	244
284	memang	もちろん，やはり		\N	\N	\N	\N	244
285	berbeda	異なる		\N	\N	\N	\N	244
158	kan	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	244
286	kedua	2番目，両方の		\N	\N	\N	\N	245
287	aliran	流れ，系統，ジャンル		\N	\N	\N	\N	245
1	sama	同じ		\N	\N	\N	\N	245
176	bagusnya	良い		\N	\N	\N	\N	245
288	kelihatan	見えている，～のように見える		\N	\N	\N	\N	246
289	capek	疲れている		\N	\N	\N	\N	246
102	baru	新しい，たった今～した		\N	\N	\N	\N	247
104	selesai	終わる		\N	\N	\N	\N	247
105	latihan	練習		\N	\N	\N	\N	247
290	tenis	テニス		\N	\N	\N	\N	247
291	ikut	参加する，ついて行く		\N	\N	\N	\N	248
292	klub	クラブ，サークル		\N	\N	\N	\N	248
269	adalah	～である		\N	\N	\N	\N	250
1	salah satu	～の１つ		\N	\N	\N	\N	250
67	hobi	趣味		\N	\N	\N	\N	250
10	saya	私		\N	\N	\N	\N	250
1	omong-omong	ところで		\N	\N	\N	\N	251
6	apa	何		\N	\N	\N	\N	251
293	memancing	魚釣りをする		\N	\N	\N	\N	252
37	di	～で，～に		\N	\N	\N	\N	254
39	mana	どこ，どちら		\N	\N	\N	\N	254
130	banyak	多い		\N	\N	\N	\N	255
294	tempat	場所		\N	\N	\N	\N	255
295	pemancingan	釣り		\N	\N	\N	\N	255
296	ikan	魚		\N	\N	\N	\N	255
8	begitu	そのような，そのように		\N	\N	\N	\N	256
297	kapan	いつ		\N	\N	\N	\N	257
152	pergi	行く		\N	\N	\N	\N	257
1	hari Minggu	日曜日		\N	\N	\N	\N	258
103	saja	～だけ		\N	\N	\N	\N	258
49	dari	～から		\N	\N	\N	\N	259
191	pagi	朝		\N	\N	\N	\N	259
192	sore	夕方		\N	\N	\N	\N	259
298	kapan-kapan	いつか		\N	\N	\N	\N	260
299	ajak	誘う		\N	\N	\N	\N	260
214	tahu	知っている		\N	\N	\N	\N	261
213	cara	方法		\N	\N	\N	\N	261
300	masak	料理する		\N	\N	\N	\N	261
301	nasi	ご飯		\N	\N	\N	\N	261
302	goreng	揚げる，炒める		\N	\N	\N	\N	261
1	nasi goreng	ナシ・ゴレン（料理の名前）：インドネシアの焼飯		\N	\N	\N	\N	261
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	261
95	enak	おいしい，心地よい		\N	\N	\N	\N	261
303	gampang	簡単だ		\N	\N	\N	\N	264
304	pertama-tama	まず初めに		\N	\N	\N	\N	265
305	siapkan	用意する		\N	\N	\N	\N	265
12	dulu	まず，ちょっと，先に		\N	\N	\N	\N	265
306	bahan-bahannya	材料		\N	\N	\N	\N	265
6	apa	何		\N	\N	\N	\N	266
307	telur	卵		\N	\N	\N	\N	267
308	cabai	唐辛子		\N	\N	\N	\N	267
309	bawang	葱類		\N	\N	\N	\N	267
310	putih	白い		\N	\N	\N	\N	267
1	bawang putih	にんにく		\N	\N	\N	\N	267
25	dan	～と～		\N	\N	\N	\N	267
40	merah	赤い		\N	\N	\N	\N	267
59	kalau	もし～なら		\N	\N	\N	\N	268
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	268
52	bisa	できる		\N	\N	\N	\N	268
312	ditambahkan	加える		\N	\N	\N	\N	268
313	daging	肉		\N	\N	\N	\N	268
314	ayam	鶏		\N	\N	\N	\N	268
134	atau	～または～		\N	\N	\N	\N	268
315	sosis	ソーセージ		\N	\N	\N	\N	268
76	lalu	それから		\N	\N	\N	\N	269
316	diiris	刻む		\N	\N	\N	\N	270
317	halus	細かい		\N	\N	\N	\N	270
318	miring	斜め		\N	\N	\N	\N	270
177	setelah	～の後		\N	\N	\N	\N	271
146	dua	2		\N	\N	\N	\N	271
319	sendok	スプーン		\N	\N	\N	\N	271
93	makan	食べる		\N	\N	\N	\N	271
1	dua sendok makan	大さじ２杯		\N	\N	\N	\N	271
320	minyak	油		\N	\N	\N	\N	271
321	dipanaskan	熱する		\N	\N	\N	\N	271
322	semua	すべて		\N	\N	\N	\N	271
323	bumbu	香辛料		\N	\N	\N	\N	271
324	telah	もう～した		\N	\N	\N	\N	271
325	masukkan	入れる		\N	\N	\N	\N	271
153	ke	～に，～へ		\N	\N	\N	\N	271
268	dalam	中，内		\N	\N	\N	\N	271
326	wajan	フライパン		\N	\N	\N	\N	271
327	matang	熟した，火が通った		\N	\N	\N	\N	272
102	baru	新しい，～したばかり，やっと		\N	\N	\N	\N	272
325	dimasukkan	入れる		\N	\N	\N	\N	272
328	garam	塩		\N	\N	\N	\N	272
329	gula	砂糖		\N	\N	\N	\N	272
330	sedikit	少し，少ない		\N	\N	\N	\N	272
1	kecap manis	ケチャップ・マニス（調味料の一種）		\N	\N	\N	\N	272
8	begitu	そのような，そのように		\N	\N	\N	\N	273
148	bagaimana	どのような，どのように		\N	\N	\N	\N	274
331	diceplok	目玉焼きにする		\N	\N	\N	\N	275
278	lebih	より～，もっと		\N	\N	\N	\N	275
332	diletakkan	置く		\N	\N	\N	\N	275
37	di	～に，～で		\N	\N	\N	\N	275
333	atas	上		\N	\N	\N	\N	275
72	akan	～する（予定）		\N	\N	\N	\N	275
334	terlihat	見える		\N	\N	\N	\N	275
335	mengundang	招待する，そそる		\N	\N	\N	\N	275
283	selera	食欲		\N	\N	\N	\N	275
336	halo	やあ，もしもし		\N	\N	\N	\N	276
1	selamat siang	こんにちは		\N	\N	\N	\N	276
52	bisa	できる		\N	\N	\N	\N	278
233	bicara	話す		\N	\N	\N	\N	278
54	dengan	～と，～で		\N	\N	\N	\N	278
10	saya	私		\N	\N	\N	\N	279
104	selesai	終わる		\N	\N	\N	\N	441
212	sendiri	自身，自分で，ひとりで		\N	\N	\N	\N	279
148	bagaimana	どのような，どのように		\N	\N	\N	\N	281
337	keadaan	状態，状況		\N	\N	\N	\N	281
84	baik	よい，わかりました		\N	\N	\N	\N	282
3	ada	ある，いる		\N	\N	\N	\N	283
6	apa	何		\N	\N	\N	\N	283
232	khawatir	心配する		\N	\N	\N	\N	284
1	akhir-akhir ini	最近		\N	\N	\N	\N	284
338	tidak	～ない，いいえ		\N	\N	\N	\N	284
339	masuk	入る，出席する		\N	\N	\N	\N	284
4	kuliah	講義		\N	\N	\N	\N	284
9	maaf	ごめんなさい		\N	\N	\N	\N	285
284	memang	そのとおり，まさしく		\N	\N	\N	\N	285
100	sedang	～している，今～である		\N	\N	\N	\N	285
340	sibuk	忙しい		\N	\N	\N	\N	285
341	melakukan	する		\N	\N	\N	\N	287
6	apa	何		\N	\N	\N	\N	287
342	membantu	手伝う		\N	\N	\N	\N	288
343	persiapan	準備		\N	\N	\N	\N	288
344	pesta	パーティー		\N	\N	\N	\N	288
345	pernikahan	結婚		\N	\N	\N	\N	288
346	kakak	兄，姉		\N	\N	\N	\N	288
347	hari	日，曜日		\N	\N	\N	\N	289
348	Minggu	日曜日		\N	\N	\N	\N	289
3	ada	ある，いる		\N	\N	\N	\N	289
149	rencana	計画，予定		\N	\N	\N	\N	289
60	tidak	～ない，いいえ		\N	\N	\N	\N	290
77	mengapa	どうして		\N	\N	\N	\N	291
10	saya	私		\N	\N	\N	\N	292
25	dan	～と～		\N	\N	\N	\N	292
114	teman-teman	友達		\N	\N	\N	\N	292
349	piknik	ピクニック		\N	\N	\N	\N	292
153	ke	～に，～へ		\N	\N	\N	\N	292
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	293
107	ikut	参加する，一緒に行く		\N	\N	\N	\N	293
59	kalau	もし～なら		\N	\N	\N	\N	295
8	begitu	そのような，そのように		\N	\N	\N	\N	295
350	kami	私達（聞き手を含まない）		\N	\N	\N	\N	295
72	akan	～する（予定）		\N	\N	\N	\N	295
351	jemput	迎えにいく		\N	\N	\N	\N	295
352	pada	～に		\N	\N	\N	\N	295
190	jam	時間		\N	\N	\N	\N	295
170	delapan	8		\N	\N	\N	\N	295
353	jam delapan	８時		\N	\N	\N	\N	295
191	pagi	朝，午前		\N	\N	\N	\N	295
354	oke	オッケー		\N	\N	\N	\N	296
109	tapi	しかし		\N	\N	\N	\N	296
355	hujan	雨，雨が降る		\N	\N	\N	\N	296
148	bagaimana	どのような，どのように		\N	\N	\N	\N	296
356	meskipun	たとえ～でも		\N	\N	\N	\N	297
357	memutuskan	決定する		\N	\N	\N	\N	297
358	tetap	依然として		\N	\N	\N	\N	297
359	berangkat	出発する		\N	\N	\N	\N	297
109	tetapi	しかし		\N	\N	\N	\N	298
158	bukannya	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	298
360	jalanan	道		\N	\N	\N	\N	298
361	licin	滑りやすい		\N	\N	\N	\N	298
244	turun	下りる，降りる		\N	\N	\N	\N	298
223	mungkin	たぶん		\N	\N	\N	\N	299
37	di	～に，～で		\N	\N	\N	\N	299
362	perjalanan	道中		\N	\N	\N	\N	299
88	sudah	もう～した		\N	\N	\N	\N	299
363	berhenti	止まる		\N	\N	\N	\N	299
173	benar	正しい		\N	\N	\N	\N	300
150	liburan	休暇		\N	\N	\N	\N	301
364	Lebaran	ルバラン（イスラム教の断食月明けの祝日）		\N	\N	\N	\N	301
365	nanti	後，今度		\N	\N	\N	\N	301
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	301
153	ke	～に，～へ		\N	\N	\N	\N	301
39	mana	どこ，どちら		\N	\N	\N	\N	301
223	mungkin	おそらく		\N	\N	\N	\N	302
10	saya	私		\N	\N	\N	\N	302
72	akan	～する（予定）		\N	\N	\N	\N	302
144	berlibur	休暇を過ごす		\N	\N	\N	\N	302
25	dan	～と～		\N	\N	\N	\N	302
242	naik	乗る，上がる		\N	\N	\N	\N	303
6	apa	何		\N	\N	\N	\N	303
101	masih	まだ		\N	\N	\N	\N	304
89	belum	まだ～ない		\N	\N	\N	\N	304
214	tahu	知っている		\N	\N	\N	\N	304
366	bis	バス		\N	\N	\N	\N	305
134	atau	～または～		\N	\N	\N	\N	305
1	pesawat terbang	飛行機		\N	\N	\N	\N	305
8	begitu	そのような，そのように		\N	\N	\N	\N	306
59	kalau	もし～なら		\N	\N	\N	\N	306
158	'kan	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	306
201	lama	（時間が）長い，期間		\N	\N	\N	\N	306
109	tapi	しかし		\N	\N	\N	\N	307
278	lebih	より～，もっと		\N	\N	\N	\N	307
367	murah	安い		\N	\N	\N	\N	307
368	dibandingkan	比べる		\N	\N	\N	\N	307
369	cepat	速い		\N	\N	\N	\N	309
370	biayanya	費用		\N	\N	\N	\N	309
63	paling	最も		\N	\N	\N	\N	309
371	mahal	（値段が）高い		\N	\N	\N	\N	309
284	memang	そのとおり，まさしく		\N	\N	\N	\N	310
372	segala	すべて		\N	\N	\N	\N	311
373	sesuatu	あること，何か		\N	\N	\N	\N	311
3	ada	ある，いる		\N	\N	\N	\N	311
374	kelebihan	長所		\N	\N	\N	\N	311
375	kekurangannya	短所		\N	\N	\N	\N	311
70	membaca	読む		\N	\N	\N	\N	313
376	informasi	情報		\N	\N	\N	\N	313
89	belum	まだ～ない		\N	\N	\N	\N	314
207	tentang	～について		\N	\N	\N	\N	315
6	apa	何		\N	\N	\N	\N	315
1	kerja paruh waktu	アルバイト		\N	\N	\N	\N	316
10	saya	私		\N	\N	\N	\N	317
277	dengar	聞く		\N	\N	\N	\N	317
100	sedang	～している		\N	\N	\N	\N	317
116	mencari	探す		\N	\N	\N	\N	317
5	ya	はい		\N	\N	\N	\N	318
120	betul	正しい		\N	\N	\N	\N	318
3	ada	ある，いる		\N	\N	\N	\N	319
377	lowongan	（職の）空き		\N	\N	\N	\N	319
378	sebagai	～として		\N	\N	\N	\N	319
379	pramuniaga	店員		\N	\N	\N	\N	319
37	di	～に，～で		\N	\N	\N	\N	319
380	Toserba	デパート （toko serba ada の略）		\N	\N	\N	\N	319
381	Matahari	マタハリ（デパートの名前：太陽の意）		\N	\N	\N	\N	319
41	itu	それ，その		\N	\N	\N	\N	320
382	sangat	とても		\N	\N	\N	\N	320
1	memakan waktu	時間がかかる		\N	\N	\N	\N	320
59	kalau	もし～なら		\N	\N	\N	\N	321
383	guru	先生		\N	\N	\N	\N	321
148	bagaimana	どのような，どのように		\N	\N	\N	\N	321
176	bagus	すばらしい		\N	\N	\N	\N	322
109	tetapi	しかし		\N	\N	\N	\N	322
384	sanggup	できる		\N	\N	\N	\N	322
60	tidak	～ない，いいえ		\N	\N	\N	\N	322
1	sanggup, tidak, ya?	できるかなぁ？		\N	\N	\N	\N	322
385	yakin	確信する		\N	\N	\N	\N	323
386	pasti	確実に，きっと		\N	\N	\N	\N	323
52	bisa	できる		\N	\N	\N	\N	323
1	terima kasih	ありがとう		\N	\N	\N	\N	324
11	permisi	すみません（呼びかけ），失礼します（挨拶）		\N	\N	\N	\N	325
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	325
13	silakan	どうぞ		\N	\N	\N	\N	326
3	ada	ある，いる		\N	\N	\N	\N	327
6	apa	何		\N	\N	\N	\N	327
9	maaf	ごめんなさい		\N	\N	\N	\N	328
222	besok	明日		\N	\N	\N	\N	329
10	saya	私		\N	\N	\N	\N	329
387	minta	頼む，求める		\N	\N	\N	\N	329
388	izin	許可		\N	\N	\N	\N	329
60	tidak	～ない，いいえ		\N	\N	\N	\N	329
339	masuk	入る，出席する		\N	\N	\N	\N	329
4	kuliah	講義		\N	\N	\N	\N	329
389	kenapa	なぜ		\N	\N	\N	\N	330
129	harus	～しなければならない		\N	\N	\N	\N	331
390	pulang	帰る		\N	\N	\N	\N	331
153	ke	～に，～へ		\N	\N	\N	\N	331
225	kampung	田舎		\N	\N	\N	\N	331
79	karena	～なので		\N	\N	\N	\N	331
391	urusan	用事		\N	\N	\N	\N	331
392	mendadak	急の		\N	\N	\N	\N	331
8	begitu	そのような，そのように		\N	\N	\N	\N	332
145	kira-kira	およそ		\N	\N	\N	\N	333
21	berapa	いくつ，いくら		\N	\N	\N	\N	333
201	lama	（時間が）長い，期間		\N	\N	\N	\N	333
393	kamu	君		\N	\N	\N	\N	333
37	di	～に，～で		\N	\N	\N	\N	333
218	hanya	～だけ		\N	\N	\N	\N	334
394	tiga	3		\N	\N	\N	\N	334
347	hari	日，曜日		\N	\N	\N	\N	334
1	tiga hari	３日間		\N	\N	\N	\N	334
84	baiklah	よい，わかりました		\N	\N	\N	\N	335
1	tidak apa-apa	大丈夫		\N	\N	\N	\N	336
1	terima kasih	ありがとう		\N	\N	\N	\N	337
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	339
10	saya	私		\N	\N	\N	\N	339
209	mendapat	得る		\N	\N	\N	\N	339
376	informasi	情報		\N	\N	\N	\N	339
207	tentang	～について		\N	\N	\N	\N	339
395	beasiswa	奨学金		\N	\N	\N	\N	339
49	dari	～から		\N	\N	\N	\N	339
396	universitas	大学		\N	\N	\N	\N	339
76	lalu	それから		\N	\N	\N	\N	340
14	ingin	欲する，～したい		\N	\N	\N	\N	341
187	mendaftar	申し込む		\N	\N	\N	\N	341
41	itu	それ，その		\N	\N	\N	\N	341
176	bagus	すばらしい		\N	\N	\N	\N	342
109	tetapi	しかし		\N	\N	\N	\N	343
3	ada	ある，いる		\N	\N	\N	\N	343
397	persyaratan	条件		\N	\N	\N	\N	343
129	harus	～しなければならない		\N	\N	\N	\N	343
81	surat	手紙，書類		\N	\N	\N	\N	343
398	rekomendasi	推薦		\N	\N	\N	\N	343
79	karena	～なので		\N	\N	\N	\N	344
41	itu	それ，その		\N	\N	\N	\N	344
399	mohon	頼む，求める（mintaの尊敬語）		\N	\N	\N	\N	344
2	Bapak	目上の男性に対する呼称，先生		\N	\N	\N	\N	344
400	membuatkan	作ってやる		\N	\N	\N	\N	344
155	untuk	～のために		\N	\N	\N	\N	344
168	dosen	（大学の）先生		\N	\N	\N	\N	345
84	baiklah	よい，わかりました		\N	\N	\N	\N	347
365	nanti	後		\N	\N	\N	\N	348
72	akan	～する（予定）		\N	\N	\N	\N	348
400	buatkan	作ってやる		\N	\N	\N	\N	348
13	silakan	どうぞ		\N	\N	\N	\N	349
393	kamu	君		\N	\N	\N	\N	349
15	ambil	取る		\N	\N	\N	\N	349
75	minggu	週		\N	\N	\N	\N	349
64	depan	前，次の（曜日，週，月，年）		\N	\N	\N	\N	349
401	batas	境		\N	\N	\N	\N	350
172	terakhirnya	最後の，最終の		\N	\N	\N	\N	350
347	hari	日，曜日		\N	\N	\N	\N	350
402	Kamis	木曜日		\N	\N	\N	\N	350
403	jadi	だから		\N	\N	\N	\N	351
59	kalau	もし～なら		\N	\N	\N	\N	351
52	bisa	できる		\N	\N	\N	\N	351
400	dibuatkan	作ってやる		\N	\N	\N	\N	351
268	dalam	中，内		\N	\N	\N	\N	351
1	kalau begitu	それでは		\N	\N	\N	\N	353
404	Rabu	水曜日		\N	\N	\N	\N	353
405	Mas	お兄さん，年上の男性に対する呼称		\N	\N	\N	\N	354
35	yang	～の（もの，人，こと）		\N	\N	\N	\N	354
406	disebut	言う		\N	\N	\N	\N	354
407	Festival	フェスティバル，祭り		\N	\N	\N	\N	354
408	Kebudayaan	文化		\N	\N	\N	\N	354
227	Jepang	日本		\N	\N	\N	\N	354
41	itu	それ，その		\N	\N	\N	\N	354
6	apa	何		\N	\N	\N	\N	354
409	biasanya	普通は		\N	\N	\N	\N	355
37	di	～に，～で		\N	\N	\N	\N	355
139	setiap	毎～		\N	\N	\N	\N	355
410	musim	季節		\N	\N	\N	\N	355
411	gugur	落ちる，散る		\N	\N	\N	\N	355
412	diadakan	催す		\N	\N	\N	\N	355
413	kampus	キャンパス		\N	\N	\N	\N	355
109	tetapi	しかし		\N	\N	\N	\N	356
396	universitas	大学		\N	\N	\N	\N	356
143	kita	私達（聞き手を含む）		\N	\N	\N	\N	356
158	'kan	～ではない，～じゃない？（付加疑問文に使う）		\N	\N	\N	\N	356
3	ada	ある，いる		\N	\N	\N	\N	356
26	jurusan	学科		\N	\N	\N	\N	357
27	bahasa	言語		\N	\N	\N	\N	357
227	Jepang	日本		\N	\N	\N	\N	357
99	membuat	作る，～にする		\N	\N	\N	\N	357
414	acara	予定，イベント		\N	\N	\N	\N	357
257	seperti	～のように		\N	\N	\N	\N	357
8	begitu	そのような，そのように		\N	\N	\N	\N	358
352	pada	～に		\N	\N	\N	\N	360
23	mahasiswa	大学生		\N	\N	\N	\N	360
415	mengenalkan	紹介する		\N	\N	\N	\N	360
132	misalnya	たとえば		\N	\N	\N	\N	361
416	demo	デモンストレーション		\N	\N	\N	\N	362
300	masak	料理する		\N	\N	\N	\N	362
417	masakan	料理		\N	\N	\N	\N	362
418	minum	飲む		\N	\N	\N	\N	362
419	teh	お茶		\N	\N	\N	\N	362
25	dan	～と～，そして		\N	\N	\N	\N	362
87	juga	～も		\N	\N	\N	\N	362
420	pemutaran	上映		\N	\N	\N	\N	362
421	film	映画		\N	\N	\N	\N	362
422	selama	～の間		\N	\N	\N	\N	363
21	berapa	いくつ，いくら		\N	\N	\N	\N	363
347	hari	日，曜日		\N	\N	\N	\N	363
145	kira-kira	およそ		\N	\N	\N	\N	364
180	satu	1		\N	\N	\N	\N	364
75	minggu	週		\N	\N	\N	\N	364
1	satu minggu	１週間		\N	\N	\N	\N	364
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	365
423	pesan	注文する		\N	\N	\N	\N	365
6	apa	何		\N	\N	\N	\N	365
31	Mbak	お姉さん，女性に対する呼称		\N	\N	\N	\N	365
424	bakso	バソ （肉団子のような食べ物）		\N	\N	\N	\N	366
180	satu	1		\N	\N	\N	\N	366
425	porsi	皿 （食べ物の量）		\N	\N	\N	\N	366
1	satu porsi	１人前		\N	\N	\N	\N	366
426	dibungkus	包む		\N	\N	\N	\N	367
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	367
9	maaf	ごめんなさい		\N	\N	\N	\N	368
427	habis	なくなる，売り切れる		\N	\N	\N	\N	368
1	kalau begitu	それでは		\N	\N	\N	\N	369
428	mi	麺		\N	\N	\N	\N	369
314	ayam	鶏		\N	\N	\N	\N	369
231	jangan	～しないでください		\N	\N	\N	\N	370
429	lupa	忘れる		\N	\N	\N	\N	370
430	sambalnya	サンバル （唐辛子をつぶした調味料，チリソース）		\N	\N	\N	\N	370
87	juga	～も		\N	\N	\N	\N	371
431	tanpa	～抜きの		\N	\N	\N	\N	372
1	tidak apa-apa	大丈夫		\N	\N	\N	\N	372
10	saya	私		\N	\N	\N	\N	373
1	es juruk	（氷の入った）オレンジジュース		\N	\N	\N	\N	373
29	tunggu	待つ		\N	\N	\N	\N	374
30	sebentar	少しの間		\N	\N	\N	\N	374
403	jadi	そうすると，～になる		\N	\N	\N	\N	375
21	berapa	いくつ，いくら		\N	\N	\N	\N	375
322	semuanya	全部		\N	\N	\N	\N	375
1	tiga ribu	3,000		\N	\N	\N	\N	376
122	rupiah	ルピア（インドネシアの通貨単位）		\N	\N	\N	\N	376
432	uangnya	お金		\N	\N	\N	\N	377
148	bagaimana	どのような，どのように		\N	\N	\N	\N	378
433	kabarnya	知らせ，調子		\N	\N	\N	\N	378
84	baik	よい，わかりました		\N	\N	\N	\N	379
161	mengerjakan	行う		\N	\N	\N	\N	380
140	PR	宿題（pekerjaan rumah の略）		\N	\N	\N	\N	380
27	bahasa	言語		\N	\N	\N	\N	380
237	Inggris	イギリス		\N	\N	\N	\N	380
188	apakah	～か？		\N	\N	\N	\N	382
151	punya	持っている		\N	\N	\N	\N	382
434	Kamus	辞書		\N	\N	\N	\N	382
28	Indonesia	インドネシア		\N	\N	\N	\N	382
389	kenapa	なぜ		\N	\N	\N	\N	384
42	bolehkah	～しても良い		\N	\N	\N	\N	385
10	saya	私		\N	\N	\N	\N	385
194	meminjam	借りる		\N	\N	\N	\N	385
41	itu	それ，その		\N	\N	\N	\N	385
297	kapan	いつ		\N	\N	\N	\N	387
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	387
435	dipakai	使う		\N	\N	\N	\N	387
222	besok	明日		\N	\N	\N	\N	388
84	baiklah	よい，わかりました		\N	\N	\N	\N	389
72	akan	～する（予定）		\N	\N	\N	\N	389
90	membawa	持ってくる，持っていく		\N	\N	\N	\N	389
11	permisi	すみません（呼びかけ），失礼します（挨拶）		\N	\N	\N	\N	390
47	Bu	目上の女性に対する呼称，先生		\N	\N	\N	\N	390
3	ada	ある，いる		\N	\N	\N	\N	391
6	apa	何		\N	\N	\N	\N	391
10	saya	私		\N	\N	\N	\N	392
89	belum	まだ～ない		\N	\N	\N	\N	392
436	mengumpulkan	提出する		\N	\N	\N	\N	392
74	tugas	課題，任務		\N	\N	\N	\N	392
75	minggu	週		\N	\N	\N	\N	392
35	yang	～の（人，もの，こと）		\N	\N	\N	\N	392
76	lalu	過ぎた		\N	\N	\N	\N	392
77	mengapa	どうして		\N	\N	\N	\N	393
79	karena	～なので		\N	\N	\N	\N	394
346	kakak	兄，姉		\N	\N	\N	\N	394
437	menikah	結婚する		\N	\N	\N	\N	394
390	pulang	帰る		\N	\N	\N	\N	394
153	ke	～に，～へ		\N	\N	\N	\N	394
225	kampung	田舎		\N	\N	\N	\N	394
8	begitu	そのような，そのように		\N	\N	\N	\N	395
297	kapan	いつ		\N	\N	\N	\N	396
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	396
436	dikumpulkan	提出する		\N	\N	\N	\N	396
188	apakah	～か？		\N	\N	\N	\N	397
129	harus	～しなければならない		\N	\N	\N	\N	397
268	dalam	中，内		\N	\N	\N	\N	397
24	Anda	あなた		\N	\N	\N	\N	398
84	baiklah	よい，わかりました		\N	\N	\N	\N	399
347	hari	日，曜日		\N	\N	\N	\N	400
1	Jumat	金曜日		\N	\N	\N	\N	400
72	akan	～する（予定）		\N	\N	\N	\N	400
29	tunggu	待つ		\N	\N	\N	\N	401
37	di	～に，～で		\N	\N	\N	\N	401
438	ruangan	（大きい）部屋		\N	\N	\N	\N	401
190	jam	時間		\N	\N	\N	\N	401
164	setengah	半分		\N	\N	\N	\N	401
439	sepuluh	10		\N	\N	\N	\N	401
1	jam setengah sepuluh	９時半		\N	\N	\N	\N	401
191	pagi	朝，午前		\N	\N	\N	\N	401
11	permisi	すみません（呼びかけ），失礼します（挨拶）		\N	\N	\N	\N	402
188	apakah	～か？		\N	\N	\N	\N	404
24	Anda	あなた		\N	\N	\N	\N	404
214	tahu	知っている		\N	\N	\N	\N	404
440	pemilik	所有者		\N	\N	\N	\N	404
441	motor	バイク		\N	\N	\N	\N	404
41	itu	それ，その		\N	\N	\N	\N	404
10	saya	私		\N	\N	\N	\N	405
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	405
37	di	～に，～で		\N	\N	\N	\N	406
216	sini	ここ		\N	\N	\N	\N	406
442	dilarang	禁止する		\N	\N	\N	\N	406
443	parkir	駐車する		\N	\N	\N	\N	406
60	tidak	～ない，いいえ		\N	\N	\N	\N	407
42	boleh	～しても良い		\N	\N	\N	\N	407
165	halaman	庭		\N	\N	\N	\N	408
39	mana	どこ，どちら		\N	\N	\N	\N	409
444	tempat parkirnya	駐車場		\N	\N	\N	\N	409
445	belakang	裏		\N	\N	\N	\N	410
446	gedung	建物		\N	\N	\N	\N	410
84	baiklah	よい，わかりました		\N	\N	\N	\N	411
72	akan	～する（予定）		\N	\N	\N	\N	411
46	sana	あそこ，向こう		\N	\N	\N	\N	411
47	Bu	目上の女性に対する呼称		\N	\N	\N	\N	412
100	sedang	～している		\N	\N	\N	\N	412
99	membuat	作る		\N	\N	\N	\N	412
6	apa	何		\N	\N	\N	\N	412
91	kue	お菓子		\N	\N	\N	\N	413
155	untuk	～のために		\N	\N	\N	\N	413
1	Hari Natal	クリスマス		\N	\N	\N	\N	413
365	nanti	後，今度		\N	\N	\N	\N	413
130	banyak	多い		\N	\N	\N	\N	414
447	pesanan	注文		\N	\N	\N	\N	414
448	nah	だから，さぁ		\N	\N	\N	\N	416
342	bantuin	手伝う		\N	\N	\N	\N	416
47	Ibu	目上の女性に対する呼称		\N	\N	\N	\N	416
32	tolong	～してください		\N	\N	\N	\N	417
449	diantar	案内する，届ける		\N	\N	\N	\N	417
124	sekarang	今		\N	\N	\N	\N	417
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	418
153	ke	～に，～へ		\N	\N	\N	\N	418
39	mana	どこ，どちら		\N	\N	\N	\N	418
450	rumah	家		\N	\N	\N	\N	419
109	tapi	しかし		\N	\N	\N	\N	420
10	saya	私		\N	\N	\N	\N	420
60	tidak	～ない，いいえ		\N	\N	\N	\N	420
214	tahu	知っている		\N	\N	\N	\N	420
129	harus	～しなければならない		\N	\N	\N	\N	420
242	naik	乗る		\N	\N	\N	\N	420
451	pertama	最初に		\N	\N	\N	\N	421
243	angkot	ミニバス（angkutan kota の略）		\N	\N	\N	\N	421
22	nomor	番号		\N	\N	\N	\N	421
244	turun	降りる，下りる		\N	\N	\N	\N	421
37	di	～に，～で		\N	\N	\N	\N	421
1	Jalan Mawar	マワール通り		\N	\N	\N	\N	421
452	terus	それから		\N	\N	\N	\N	422
453	jalan	動く，進む		\N	\N	\N	\N	423
252	warung	ワルン（屋台，小店）		\N	\N	\N	\N	423
250	tepat	ちょうど		\N	\N	\N	\N	424
248	sebelahnya	隣，側		\N	\N	\N	\N	424
454	hati-hati	気をつける		\N	\N	\N	\N	425
3	ada	ある，いる		\N	\N	\N	\N	426
6	apa	何		\N	\N	\N	\N	426
88	sudah	もう，既に		\N	\N	\N	\N	427
146	dua	2		\N	\N	\N	\N	427
347	hari	日，曜日		\N	\N	\N	\N	427
455	dua hari	２日間		\N	\N	\N	\N	427
456	kepala	頭		\N	\N	\N	\N	427
25	dan	～と～		\N	\N	\N	\N	427
457	tenggorokan	喉		\N	\N	\N	\N	427
10	saya	私		\N	\N	\N	\N	427
80	sakit	痛い，病気だ		\N	\N	\N	\N	427
83	Dok	医者		\N	\N	\N	\N	427
43	coba	～してみる		\N	\N	\N	\N	428
458	periksa	点検する，診察する		\N	\N	\N	\N	428
12	dulu	まず，ちょっと，先に		\N	\N	\N	\N	428
148	bagaimana	どのような，どのように		\N	\N	\N	\N	429
24	Anda	あなた		\N	\N	\N	\N	430
459	demam	熱がある		\N	\N	\N	\N	430
129	harus	～しなければならない		\N	\N	\N	\N	431
130	banyak	多い，たくさん		\N	\N	\N	\N	431
460	istirahat	休む，休養する		\N	\N	\N	\N	431
54	dengan	～と，～で		\N	\N	\N	\N	432
1	bagaimana dengan...?	～はどうですか。		\N	\N	\N	\N	432
461	makanan	食べ物		\N	\N	\N	\N	432
462	sementara	しばらく，とりあえず		\N	\N	\N	\N	433
231	jangan	～しないでください		\N	\N	\N	\N	433
93	makan	食べる		\N	\N	\N	\N	433
463	berminyak	油っぽい		\N	\N	\N	\N	433
84	baik	よい，わかりました		\N	\N	\N	\N	434
464	mandi	水浴する		\N	\N	\N	\N	435
60	tidak	～ない，いいえ		\N	\N	\N	\N	436
42	boleh	～しても良い		\N	\N	\N	\N	436
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	438
10	saya	私		\N	\N	\N	\N	438
14	ingin	～したい，欲する		\N	\N	\N	\N	438
465	mengembalikan	返す		\N	\N	\N	\N	438
117	buku	本		\N	\N	\N	\N	438
6	apa	何		\N	\N	\N	\N	439
466	sejarah	歴史		\N	\N	\N	\N	440
70	membaca	読む		\N	\N	\N	\N	441
467	sebetulnya	実は		\N	\N	\N	\N	442
89	belum	まだ～ない		\N	\N	\N	\N	442
1	kalau begitu	それでは		\N	\N	\N	\N	443
13	silakan	どうぞ		\N	\N	\N	\N	443
468	selesaikan	終わらせる		\N	\N	\N	\N	443
12	dulu	まず，ちょっと，先に		\N	\N	\N	\N	443
109	tapi	しかし		\N	\N	\N	\N	444
129	harus	～しなければならない		\N	\N	\N	\N	444
347	hari	日，曜日		\N	\N	\N	\N	444
60	tidak	～ない，いいえ		\N	\N	\N	\N	445
87	juga	～も		\N	\N	\N	\N	446
42	boleh	～しても良い		\N	\N	\N	\N	446
1	tidak apa-apa	大丈夫		\N	\N	\N	\N	447
222	besok	明日		\N	\N	\N	\N	449
3	ada	ある，いる		\N	\N	\N	\N	449
414	acara	予定，イベント		\N	\N	\N	\N	449
108	unit	サークル		\N	\N	\N	\N	449
106	gamelan	ガムラン（インドネシア地域の伝統音楽）		\N	\N	\N	\N	449
37	di	～に，～で		\N	\N	\N	\N	450
39	mana	どちら，どこ		\N	\N	\N	\N	450
413	kampus	キャンパス		\N	\N	\N	\N	451
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	452
226	datang	来る		\N	\N	\N	\N	452
109	tapi	しかし		\N	\N	\N	\N	453
114	teman	友達		\N	\N	\N	\N	453
10	saya	私		\N	\N	\N	\N	453
72	akan	～する（予定）		\N	\N	\N	\N	453
1	kalau begitu	それでは		\N	\N	\N	\N	454
13	silakan	どうぞ		\N	\N	\N	\N	454
54	dengan	～と，～で		\N	\N	\N	\N	454
87	juga	～も		\N	\N	\N	\N	454
42	boleh	～しても良い		\N	\N	\N	\N	455
1	tentu saja	もちろん		\N	\N	\N	\N	456
299	ajaklah	誘う		\N	\N	\N	\N	457
41	itu	それ，その		\N	\N	\N	\N	457
21	berapa	いくつ，いくら		\N	\N	\N	\N	458
121	harga	値段		\N	\N	\N	\N	458
469	tiketnya	チケット		\N	\N	\N	\N	458
146	dua	2		\N	\N	\N	\N	459
470	gratis	無料		\N	\N	\N	\N	459
155	untuk	～のために		\N	\N	\N	\N	459
471	sungguh	本当に		\N	\N	\N	\N	460
1	terima kasih	ありがとう		\N	\N	\N	\N	461
136	kelihatannya	～のようだ		\N	\N	\N	\N	462
24	Anda	あなた		\N	\N	\N	\N	462
112	terlalu	～すぎる		\N	\N	\N	\N	462
472	lelah	疲れた		\N	\N	\N	\N	462
83	Dok	医者		\N	\N	\N	\N	463
75	minggu	週		\N	\N	\N	\N	464
10	saya	私		\N	\N	\N	\N	464
473	kurang	足りない		\N	\N	\N	\N	464
474	tidur	寝る		\N	\N	\N	\N	464
109	tapi	しかし		\N	\N	\N	\N	465
129	harus	～しなければならない		\N	\N	\N	\N	465
460	istirahat	休む		\N	\N	\N	\N	465
35	yang	～な（人，もの，こと）		\N	\N	\N	\N	465
475	cukup	十分だ		\N	\N	\N	\N	465
418	minum	飲む		\N	\N	\N	\N	467
476	obat	薬		\N	\N	\N	\N	467
72	akan	～する（予定）		\N	\N	\N	\N	469
99	buat	作る		\N	\N	\N	\N	469
477	resep	処方箋		\N	\N	\N	\N	469
1	terima kasih	ありがとう		\N	\N	\N	\N	470
478	sebaiknya	～すべきだ，～したほうがいい		\N	\N	\N	\N	471
151	punya	持っている		\N	\N	\N	\N	472
130	banyak	多い		\N	\N	\N	\N	472
74	tugas	課題		\N	\N	\N	\N	472
79	karena	～なので		\N	\N	\N	\N	473
100	sedang	～している，今～である		\N	\N	\N	\N	473
80	sakit	痛い，病気だ		\N	\N	\N	\N	473
479	menjelaskan	説明する		\N	\N	\N	\N	473
221	kepada	～（人）に		\N	\N	\N	\N	473
168	dosen	（大学の）先生		\N	\N	\N	\N	473
32	tolong	～してください		\N	\N	\N	\N	475
480	kemari	ここへ		\N	\N	\N	\N	475
30	sebentar	少しの間		\N	\N	\N	\N	475
3	ada	ある，いる		\N	\N	\N	\N	476
6	apa	何		\N	\N	\N	\N	476
47	Bu	目上の女性に対する呼称，先生		\N	\N	\N	\N	476
347	hari	日，曜日		\N	\N	\N	\N	477
481	sempat	～する時間がある		\N	\N	\N	\N	477
178	bertemu	会う		\N	\N	\N	\N	477
54	dengan	～と，～で		\N	\N	\N	\N	477
365	nanti	後		\N	\N	\N	\N	479
10	saya	私		\N	\N	\N	\N	479
8	begitu	そのような，そのように		\N	\N	\N	\N	480
52	bisa	できる		\N	\N	\N	\N	481
47	Ibu	目上の女性に対する呼称，先生		\N	\N	\N	\N	481
387	minta	頼む		\N	\N	\N	\N	481
482	tentu	もちろん		\N	\N	\N	\N	482
483	sampaikan	伝える		\N	\N	\N	\N	483
352	pada	～に		\N	\N	\N	\N	483
14	ingin	～したい，欲する		\N	\N	\N	\N	483
484	agar	～ように		\N	\N	\N	\N	483
485	ia	彼，彼女		\N	\N	\N	\N	483
226	datang	来る		\N	\N	\N	\N	483
153	ke	～に，～へ		\N	\N	\N	\N	483
438	ruangan	（大きな）部屋		\N	\N	\N	\N	483
190	jam	時間		\N	\N	\N	\N	484
21	berapa	いくつ，いくら		\N	\N	\N	\N	484
1	dua belas	12		\N	\N	\N	\N	485
486	jam dua belas	12時		\N	\N	\N	\N	485
84	baik	よい，わかりました		\N	\N	\N	\N	486
72	akan	～する（予定）		\N	\N	\N	\N	487
487	ayo	さあ		\N	\N	\N	\N	488
1	makan siang	昼食をとる		\N	\N	\N	\N	488
10	saya	私		\N	\N	\N	\N	489
488	traktir	おごる		\N	\N	\N	\N	489
471	sungguh	本当に		\N	\N	\N	\N	490
1	hari	日，曜日		\N	\N	\N	\N	491
489	selamat	おめでとう		\N	\N	\N	\N	492
1	terima kasih	ありがとう		\N	\N	\N	\N	493
448	nah	さあ		\N	\N	\N	\N	494
311	mau	欲しい，したい，つもり		\N	\N	\N	\N	494
93	makan	食べる		\N	\N	\N	\N	494
6	apa	何		\N	\N	\N	\N	494
490	terserah	～に委ねる		\N	\N	\N	\N	495
491	deh	～わ，～よ		\N	\N	\N	\N	495
1	bilang saja	言ってよ		\N	\N	\N	\N	496
1	kalau begitu	それでは		\N	\N	\N	\N	497
354	oke	オーケー		\N	\N	\N	\N	498
115	mari	～しよう		\N	\N	\N	\N	499
143	kita	私達（聞き手を含む）		\N	\N	\N	\N	499
152	pergi	行く		\N	\N	\N	\N	499
492	asyik	夢中になる，嬉しい		\N	\N	\N	\N	500
11	permisi	すみません（呼びかけ），失礼します（挨拶）		\N	\N	\N	\N	501
2	Pak	目上の男性に対する呼称，先生		\N	\N	\N	\N	501
13	silakan	どうぞ		\N	\N	\N	\N	502
3	ada	ある，いる		\N	\N	\N	\N	503
6	apa	何		\N	\N	\N	\N	503
10	saya	私		\N	\N	\N	\N	504
14	ingin	欲しい，したい，つもり		\N	\N	\N	\N	504
48	memperkenalkan	紹介する		\N	\N	\N	\N	504
23	mahasiswa	大学生		\N	\N	\N	\N	504
493	asing	外国の		\N	\N	\N	\N	504
49	dari	～から		\N	\N	\N	\N	504
227	Jepang	日本		\N	\N	\N	\N	504
48	perkenalkan	紹介する		\N	\N	\N	\N	506
2	Bapak	目上の男性に対する呼称，先生		\N	\N	\N	\N	508
1	selamat siang	こんにちは		\N	\N	\N	\N	509
51	senang	嬉しい		\N	\N	\N	\N	511
53	berkenalan	知り合いになる		\N	\N	\N	\N	511
54	dengan	～と，～で		\N	\N	\N	\N	511
24	Anda	あなた		\N	\N	\N	\N	511
269	adalah	～である		\N	\N	\N	\N	512
168	dosen	（大学の）先生		\N	\N	\N	\N	512
1	tata bahasa	文法		\N	\N	\N	\N	512
494	tertarik	興味がある		\N	\N	\N	\N	513
414		\N		\N	\N	\N	\N	359
414		\N		\N	\N	\N	\N	362
414		\N		\N	\N	\N	\N	363
3		\N		\N	\N	\N	\N	33
3		\N		\N	\N	\N	\N	42
3		\N		\N	\N	\N	\N	58
3		\N		\N	\N	\N	\N	59
3		\N		\N	\N	\N	\N	82
3		\N		\N	\N	\N	\N	88
3		\N		\N	\N	\N	\N	100
3		\N		\N	\N	\N	\N	176
3		\N		\N	\N	\N	\N	204
3		\N		\N	\N	\N	\N	233
3		\N		\N	\N	\N	\N	243
3		\N		\N	\N	\N	\N	250
3		\N		\N	\N	\N	\N	281
3		\N		\N	\N	\N	\N	290
3		\N		\N	\N	\N	\N	292
3		\N		\N	\N	\N	\N	295
3		\N		\N	\N	\N	\N	331
3		\N		\N	\N	\N	\N	345
3		\N		\N	\N	\N	\N	355
3		\N		\N	\N	\N	\N	360
3		\N		\N	\N	\N	\N	362
3		\N		\N	\N	\N	\N	459
3		\N		\N	\N	\N	\N	473
3		\N		\N	\N	\N	\N	483
3		\N		\N	\N	\N	\N	487
3		\N		\N	\N	\N	\N	497
3		\N		\N	\N	\N	\N	512
737		\N		\N	\N	\N	\N	692
72		\N		\N	\N	\N	\N	9
72		\N		\N	\N	\N	\N	31
72		\N		\N	\N	\N	\N	51
72		\N		\N	\N	\N	\N	53
72		\N		\N	\N	\N	\N	67
72		\N		\N	\N	\N	\N	70
72		\N		\N	\N	\N	\N	89
72		\N		\N	\N	\N	\N	127
72		\N		\N	\N	\N	\N	129
72		\N		\N	\N	\N	\N	131
72		\N		\N	\N	\N	\N	133
72		\N		\N	\N	\N	\N	139
72		\N		\N	\N	\N	\N	141
72		\N		\N	\N	\N	\N	149
72		\N		\N	\N	\N	\N	157
72		\N		\N	\N	\N	\N	197
72		\N		\N	\N	\N	\N	199
72		\N		\N	\N	\N	\N	208
72		\N		\N	\N	\N	\N	271
72		\N		\N	\N	\N	\N	320
72		\N		\N	\N	\N	\N	326
72		\N		\N	\N	\N	\N	349
72		\N		\N	\N	\N	\N	355
72		\N		\N	\N	\N	\N	362
72		\N		\N	\N	\N	\N	380
72		\N		\N	\N	\N	\N	410
72		\N		\N	\N	\N	\N	432
72		\N		\N	\N	\N	\N	433
72		\N		\N	\N	\N	\N	443
72		\N		\N	\N	\N	\N	448
72		\N		\N	\N	\N	\N	454
72		\N		\N	\N	\N	\N	488
72		\N		\N	\N	\N	\N	494
72		\N		\N	\N	\N	\N	496
72		\N		\N	\N	\N	\N	497
72		\N		\N	\N	\N	\N	502
72		\N		\N	\N	\N	\N	505
72		\N		\N	\N	\N	\N	728
72		\N		\N	\N	\N	\N	729
72		\N		\N	\N	\N	\N	781
815		\N		\N	\N	\N	\N	507
24		\N		\N	\N	\N	\N	21
24		\N		\N	\N	\N	\N	46
24		\N		\N	\N	\N	\N	76
24		\N		\N	\N	\N	\N	225
24		\N		\N	\N	\N	\N	465
24		\N		\N	\N	\N	\N	471
24		\N		\N	\N	\N	\N	473
24		\N		\N	\N	\N	\N	538
24		\N		\N	\N	\N	\N	734
24		\N		\N	\N	\N	\N	738
24		\N		\N	\N	\N	\N	742
6		\N		\N	\N	\N	\N	13
6		\N		\N	\N	\N	\N	41
6		\N		\N	\N	\N	\N	56
6		\N		\N	\N	\N	\N	62
6		\N		\N	\N	\N	\N	63
6		\N		\N	\N	\N	\N	97
6		\N		\N	\N	\N	\N	118
6		\N		\N	\N	\N	\N	135
6		\N		\N	\N	\N	\N	136
6		\N		\N	\N	\N	\N	146
6		\N		\N	\N	\N	\N	151
6		\N		\N	\N	\N	\N	153
6		\N		\N	\N	\N	\N	156
6		\N		\N	\N	\N	\N	159
6		\N		\N	\N	\N	\N	161
6		\N		\N	\N	\N	\N	169
6		\N		\N	\N	\N	\N	182
6		\N		\N	\N	\N	\N	219
6		\N		\N	\N	\N	\N	227
6		\N		\N	\N	\N	\N	257
6		\N		\N	\N	\N	\N	260
6		\N		\N	\N	\N	\N	288
6		\N		\N	\N	\N	\N	291
6		\N		\N	\N	\N	\N	295
6		\N		\N	\N	\N	\N	330
6		\N		\N	\N	\N	\N	333
6		\N		\N	\N	\N	\N	336
6		\N		\N	\N	\N	\N	339
6		\N		\N	\N	\N	\N	344
6		\N		\N	\N	\N	\N	359
6		\N		\N	\N	\N	\N	363
6		\N		\N	\N	\N	\N	372
6		\N		\N	\N	\N	\N	375
6		\N		\N	\N	\N	\N	382
6		\N		\N	\N	\N	\N	384
6		\N		\N	\N	\N	\N	387
6		\N		\N	\N	\N	\N	393
6		\N		\N	\N	\N	\N	396
6		\N		\N	\N	\N	\N	397
6		\N		\N	\N	\N	\N	404
6		\N		\N	\N	\N	\N	420
6		\N		\N	\N	\N	\N	447
6		\N		\N	\N	\N	\N	458
6		\N		\N	\N	\N	\N	467
6		\N		\N	\N	\N	\N	484
6		\N		\N	\N	\N	\N	496
6		\N		\N	\N	\N	\N	508
6		\N		\N	\N	\N	\N	514
6		\N		\N	\N	\N	\N	521
6		\N		\N	\N	\N	\N	559
6		\N		\N	\N	\N	\N	596
6		\N		\N	\N	\N	\N	669
6		\N		\N	\N	\N	\N	732
6		\N		\N	\N	\N	\N	733
6		\N		\N	\N	\N	\N	736
6		\N		\N	\N	\N	\N	738
6		\N		\N	\N	\N	\N	742
188		\N		\N	\N	\N	\N	733
188		\N		\N	\N	\N	\N	736
738		\N		\N	\N	\N	\N	688
240		\N		\N	\N	\N	\N	199
240		\N		\N	\N	\N	\N	200
240		\N		\N	\N	\N	\N	204
333		\N		\N	\N	\N	\N	350
333		\N		\N	\N	\N	\N	572
314		\N		\N	\N	\N	\N	372
487		\N		\N	\N	\N	\N	40
148		\N		\N	\N	\N	\N	126
148		\N		\N	\N	\N	\N	139
148		\N		\N	\N	\N	\N	232
148		\N		\N	\N	\N	\N	432
27		\N		\N	\N	\N	\N	185
27		\N		\N	\N	\N	\N	190
27		\N		\N	\N	\N	\N	191
27		\N		\N	\N	\N	\N	192
27		\N		\N	\N	\N	\N	225
27		\N		\N	\N	\N	\N	227
27		\N		\N	\N	\N	\N	232
27		\N		\N	\N	\N	\N	233
27		\N		\N	\N	\N	\N	360
27		\N		\N	\N	\N	\N	382
27		\N		\N	\N	\N	\N	512
27		\N		\N	\N	\N	\N	513
495		\N		\N	\N	\N	\N	190
495		\N		\N	\N	\N	\N	380
495		\N		\N	\N	\N	\N	382
501		\N		\N	\N	\N	\N	185
501		\N		\N	\N	\N	\N	187
501		\N		\N	\N	\N	\N	191
501		\N		\N	\N	\N	\N	192
501		\N		\N	\N	\N	\N	225
501		\N		\N	\N	\N	\N	232
501		\N		\N	\N	\N	\N	233
501		\N		\N	\N	\N	\N	357
501		\N		\N	\N	\N	\N	360
499		\N		\N	\N	\N	\N	223
499		\N		\N	\N	\N	\N	227
84		\N		\N	\N	\N	\N	66
84		\N		\N	\N	\N	\N	437
84		\N		\N	\N	\N	\N	471
84		\N		\N	\N	\N	\N	473
34		\N		\N	\N	\N	\N	27
424		\N		\N	\N	\N	\N	368
130		\N		\N	\N	\N	\N	113
130		\N		\N	\N	\N	\N	114
130		\N		\N	\N	\N	\N	781
2		\N		\N	\N	\N	\N	514
2		\N		\N	\N	\N	\N	559
102		\N		\N	\N	\N	\N	40
102		\N		\N	\N	\N	\N	85
102		\N		\N	\N	\N	\N	725
102		\N		\N	\N	\N	\N	726
102		\N		\N	\N	\N	\N	741
102		\N		\N	\N	\N	\N	771
401		\N		\N	\N	\N	\N	572
309		\N		\N	\N	\N	\N	270
395		\N		\N	\N	\N	\N	341
8		\N		\N	\N	\N	\N	102
8		\N		\N	\N	\N	\N	111
8		\N		\N	\N	\N	\N	115
8		\N		\N	\N	\N	\N	148
8		\N		\N	\N	\N	\N	178
8		\N		\N	\N	\N	\N	221
8		\N		\N	\N	\N	\N	353
8		\N		\N	\N	\N	\N	369
8		\N		\N	\N	\N	\N	443
8		\N		\N	\N	\N	\N	454
8		\N		\N	\N	\N	\N	497
173		\N		\N	\N	\N	\N	152
21		\N		\N	\N	\N	\N	156
21		\N		\N	\N	\N	\N	161
53		\N		\N	\N	\N	\N	46
53		\N		\N	\N	\N	\N	514
505		\N		\N	\N	\N	\N	543
178		\N		\N	\N	\N	\N	479
222		\N		\N	\N	\N	\N	389
222		\N		\N	\N	\N	\N	453
120		\N		\N	\N	\N	\N	442
409		\N		\N	\N	\N	\N	357
366		\N		\N	\N	\N	\N	38
366		\N		\N	\N	\N	\N	158
366		\N		\N	\N	\N	\N	159
366		\N		\N	\N	\N	\N	163
366		\N		\N	\N	\N	\N	164
366		\N		\N	\N	\N	\N	185
366		\N		\N	\N	\N	\N	187
366		\N		\N	\N	\N	\N	191
366		\N		\N	\N	\N	\N	268
366		\N		\N	\N	\N	\N	278
366		\N		\N	\N	\N	\N	306
366		\N		\N	\N	\N	\N	307
366		\N		\N	\N	\N	\N	323
366		\N		\N	\N	\N	\N	351
366		\N		\N	\N	\N	\N	368
366		\N		\N	\N	\N	\N	371
366		\N		\N	\N	\N	\N	481
366		\N		\N	\N	\N	\N	566
366		\N		\N	\N	\N	\N	567
366		\N		\N	\N	\N	\N	571
52		\N		\N	\N	\N	\N	159
52		\N		\N	\N	\N	\N	164
52		\N		\N	\N	\N	\N	187
52		\N		\N	\N	\N	\N	191
42		\N		\N	\N	\N	\N	386
42		\N		\N	\N	\N	\N	813
42		\N		\N	\N	\N	\N	814
189		\N		\N	\N	\N	\N	129
189		\N		\N	\N	\N	\N	221
189		\N		\N	\N	\N	\N	298
158		\N		\N	\N	\N	\N	221
117		\N		\N	\N	\N	\N	95
117		\N		\N	\N	\N	\N	98
117		\N		\N	\N	\N	\N	102
117		\N		\N	\N	\N	\N	159
117		\N		\N	\N	\N	\N	160
117		\N		\N	\N	\N	\N	439
117		\N		\N	\N	\N	\N	440
117		\N		\N	\N	\N	\N	528
117		\N		\N	\N	\N	\N	697
117		\N		\N	\N	\N	\N	698
117		\N		\N	\N	\N	\N	700
117		\N		\N	\N	\N	\N	702
117		\N		\N	\N	\N	\N	703
117		\N		\N	\N	\N	\N	705
117		\N		\N	\N	\N	\N	709
117		\N		\N	\N	\N	\N	712
117		\N		\N	\N	\N	\N	714
117		\N		\N	\N	\N	\N	715
117		\N		\N	\N	\N	\N	716
117		\N		\N	\N	\N	\N	717
117		\N		\N	\N	\N	\N	725
117		\N		\N	\N	\N	\N	726
117		\N		\N	\N	\N	\N	727
117		\N		\N	\N	\N	\N	732
117		\N		\N	\N	\N	\N	733
117		\N		\N	\N	\N	\N	741
147		\N		\N	\N	\N	\N	48
260		\N		\N	\N	\N	\N	218
213		\N		\N	\N	\N	\N	173
213		\N		\N	\N	\N	\N	187
213		\N		\N	\N	\N	\N	278
213		\N		\N	\N	\N	\N	357
213		\N		\N	\N	\N	\N	359
213		\N		\N	\N	\N	\N	362
213		\N		\N	\N	\N	\N	363
213		\N		\N	\N	\N	\N	449
273		\N		\N	\N	\N	\N	236
475		\N		\N	\N	\N	\N	471
16		\N		\N	\N	\N	\N	21
16		\N		\N	\N	\N	\N	147
16		\N		\N	\N	\N	\N	148
16		\N		\N	\N	\N	\N	198
16		\N		\N	\N	\N	\N	199
16		\N		\N	\N	\N	\N	206
16		\N		\N	\N	\N	\N	341
543		\N		\N	\N	\N	\N	268
268		\N		\N	\N	\N	\N	398
25		\N		\N	\N	\N	\N	78
25		\N		\N	\N	\N	\N	125
25		\N		\N	\N	\N	\N	174
25		\N		\N	\N	\N	\N	176
25		\N		\N	\N	\N	\N	192
25		\N		\N	\N	\N	\N	220
25		\N		\N	\N	\N	\N	237
25		\N		\N	\N	\N	\N	239
25		\N		\N	\N	\N	\N	241
25		\N		\N	\N	\N	\N	243
25		\N		\N	\N	\N	\N	270
25		\N		\N	\N	\N	\N	272
25		\N		\N	\N	\N	\N	275
25		\N		\N	\N	\N	\N	285
25		\N		\N	\N	\N	\N	311
25		\N		\N	\N	\N	\N	317
25		\N		\N	\N	\N	\N	412
25		\N		\N	\N	\N	\N	473
25		\N		\N	\N	\N	\N	487
25		\N		\N	\N	\N	\N	497
279		\N		\N	\N	\N	\N	241
279		\N		\N	\N	\N	\N	243
49		\N		\N	\N	\N	\N	164
49		\N		\N	\N	\N	\N	179
49		\N		\N	\N	\N	\N	243
49		\N		\N	\N	\N	\N	345
49		\N		\N	\N	\N	\N	507
525		\N		\N	\N	\N	\N	343
525		\N		\N	\N	\N	\N	344
525		\N		\N	\N	\N	\N	345
226		\N		\N	\N	\N	\N	453
226		\N		\N	\N	\N	\N	454
170		\N		\N	\N	\N	\N	669
54		\N		\N	\N	\N	\N	46
54		\N		\N	\N	\N	\N	126
54		\N		\N	\N	\N	\N	232
54		\N		\N	\N	\N	\N	479
54		\N		\N	\N	\N	\N	513
54		\N		\N	\N	\N	\N	514
37		\N		\N	\N	\N	\N	30
37		\N		\N	\N	\N	\N	32
37		\N		\N	\N	\N	\N	33
37		\N		\N	\N	\N	\N	42
37		\N		\N	\N	\N	\N	70
37		\N		\N	\N	\N	\N	93
37		\N		\N	\N	\N	\N	99
37		\N		\N	\N	\N	\N	100
37		\N		\N	\N	\N	\N	110
37		\N		\N	\N	\N	\N	128
37		\N		\N	\N	\N	\N	143
37		\N		\N	\N	\N	\N	146
37		\N		\N	\N	\N	\N	169
37		\N		\N	\N	\N	\N	172
37		\N		\N	\N	\N	\N	179
37		\N		\N	\N	\N	\N	189
37		\N		\N	\N	\N	\N	190
37		\N		\N	\N	\N	\N	200
37		\N		\N	\N	\N	\N	201
37		\N		\N	\N	\N	\N	202
37		\N		\N	\N	\N	\N	203
37		\N		\N	\N	\N	\N	204
37		\N		\N	\N	\N	\N	206
37		\N		\N	\N	\N	\N	215
37		\N		\N	\N	\N	\N	216
37		\N		\N	\N	\N	\N	238
37		\N		\N	\N	\N	\N	255
37		\N		\N	\N	\N	\N	268
37		\N		\N	\N	\N	\N	270
37		\N		\N	\N	\N	\N	271
37		\N		\N	\N	\N	\N	272
37		\N		\N	\N	\N	\N	279
37		\N		\N	\N	\N	\N	307
37		\N		\N	\N	\N	\N	351
37		\N		\N	\N	\N	\N	354
37		\N		\N	\N	\N	\N	356
37		\N		\N	\N	\N	\N	357
37		\N		\N	\N	\N	\N	367
37		\N		\N	\N	\N	\N	375
37		\N		\N	\N	\N	\N	387
37		\N		\N	\N	\N	\N	396
37		\N		\N	\N	\N	\N	408
37		\N		\N	\N	\N	\N	409
37		\N		\N	\N	\N	\N	410
37		\N		\N	\N	\N	\N	411
37		\N		\N	\N	\N	\N	417
37		\N		\N	\N	\N	\N	418
37		\N		\N	\N	\N	\N	424
37		\N		\N	\N	\N	\N	435
37		\N		\N	\N	\N	\N	436
37		\N		\N	\N	\N	\N	449
37		\N		\N	\N	\N	\N	451
37		\N		\N	\N	\N	\N	556
37		\N		\N	\N	\N	\N	585
37		\N		\N	\N	\N	\N	701
37		\N		\N	\N	\N	\N	702
37		\N		\N	\N	\N	\N	708
37		\N		\N	\N	\N	\N	710
37		\N		\N	\N	\N	\N	713
37		\N		\N	\N	\N	\N	714
37		\N		\N	\N	\N	\N	718
37		\N		\N	\N	\N	\N	719
37		\N		\N	\N	\N	\N	720
37		\N		\N	\N	\N	\N	721
37		\N		\N	\N	\N	\N	722
37		\N		\N	\N	\N	\N	723
37		\N		\N	\N	\N	\N	724
37		\N		\N	\N	\N	\N	728
37		\N		\N	\N	\N	\N	729
37		\N		\N	\N	\N	\N	734
37		\N		\N	\N	\N	\N	737
37		\N		\N	\N	\N	\N	739
37		\N		\N	\N	\N	\N	740
37		\N		\N	\N	\N	\N	757
37		\N		\N	\N	\N	\N	762
37		\N		\N	\N	\N	\N	792
234		\N		\N	\N	\N	\N	93
234		\N		\N	\N	\N	\N	190
234		\N		\N	\N	\N	\N	216
234		\N		\N	\N	\N	\N	355
234		\N		\N	\N	\N	\N	417
234		\N		\N	\N	\N	\N	418
234		\N		\N	\N	\N	\N	792
123		\N		\N	\N	\N	\N	100
146		\N		\N	\N	\N	\N	48
146		\N		\N	\N	\N	\N	245
146		\N		\N	\N	\N	\N	485
146		\N		\N	\N	\N	\N	663
146		\N		\N	\N	\N	\N	673
146		\N		\N	\N	\N	\N	674
146		\N		\N	\N	\N	\N	793
68		\N		\N	\N	\N	\N	674
12		\N		\N	\N	\N	\N	435
198		\N		\N	\N	\N	\N	255
198		\N		\N	\N	\N	\N	409
198		\N		\N	\N	\N	\N	477
198		\N		\N	\N	\N	\N	665
198		\N		\N	\N	\N	\N	755
95		\N		\N	\N	\N	\N	275
407		\N		\N	\N	\N	\N	355
185		\N		\N	\N	\N	\N	149
106		\N		\N	\N	\N	\N	84
106		\N		\N	\N	\N	\N	86
302		\N		\N	\N	\N	\N	262
302		\N		\N	\N	\N	\N	271
302		\N		\N	\N	\N	\N	275
427		\N		\N	\N	\N	\N	371
427		\N		\N	\N	\N	\N	566
427		\N		\N	\N	\N	\N	567
165		\N		\N	\N	\N	\N	136
801		\N		\N	\N	\N	\N	604
218		\N		\N	\N	\N	\N	177
121		\N		\N	\N	\N	\N	98
347		\N		\N	\N	\N	\N	154
347		\N		\N	\N	\N	\N	155
347		\N		\N	\N	\N	\N	161
347		\N		\N	\N	\N	\N	258
347		\N		\N	\N	\N	\N	292
347		\N		\N	\N	\N	\N	319
347		\N		\N	\N	\N	\N	353
347		\N		\N	\N	\N	\N	413
347		\N		\N	\N	\N	\N	446
347		\N		\N	\N	\N	\N	491
347		\N		\N	\N	\N	\N	575
772		\N		\N	\N	\N	\N	427
772		\N		\N	\N	\N	\N	444
772		\N		\N	\N	\N	\N	446
772		\N		\N	\N	\N	\N	477
772		\N		\N	\N	\N	\N	491
129		\N		\N	\N	\N	\N	345
129		\N		\N	\N	\N	\N	398
129		\N		\N	\N	\N	\N	467
235		\N		\N	\N	\N	\N	193
235		\N		\N	\N	\N	\N	576
67		\N		\N	\N	\N	\N	49
67		\N		\N	\N	\N	\N	251
67		\N		\N	\N	\N	\N	252
355		\N		\N	\N	\N	\N	297
355		\N		\N	\N	\N	\N	298
355		\N		\N	\N	\N	\N	299
355		\N		\N	\N	\N	\N	803
485		\N		\N	\N	\N	\N	3
485		\N		\N	\N	\N	\N	5
485		\N		\N	\N	\N	\N	6
485		\N		\N	\N	\N	\N	18
485		\N		\N	\N	\N	\N	34
485		\N		\N	\N	\N	\N	35
485		\N		\N	\N	\N	\N	44
485		\N		\N	\N	\N	\N	67
485		\N		\N	\N	\N	\N	81
485		\N		\N	\N	\N	\N	91
485		\N		\N	\N	\N	\N	93
485		\N		\N	\N	\N	\N	98
485		\N		\N	\N	\N	\N	106
485		\N		\N	\N	\N	\N	108
485		\N		\N	\N	\N	\N	113
485		\N		\N	\N	\N	\N	116
485		\N		\N	\N	\N	\N	126
485		\N		\N	\N	\N	\N	131
485		\N		\N	\N	\N	\N	135
485		\N		\N	\N	\N	\N	137
485		\N		\N	\N	\N	\N	141
485		\N		\N	\N	\N	\N	154
485		\N		\N	\N	\N	\N	168
485		\N		\N	\N	\N	\N	187
485		\N		\N	\N	\N	\N	189
485		\N		\N	\N	\N	\N	190
485		\N		\N	\N	\N	\N	215
485		\N		\N	\N	\N	\N	216
485		\N		\N	\N	\N	\N	265
485		\N		\N	\N	\N	\N	276
485		\N		\N	\N	\N	\N	277
485		\N		\N	\N	\N	\N	284
485		\N		\N	\N	\N	\N	288
485		\N		\N	\N	\N	\N	289
485		\N		\N	\N	\N	\N	293
485		\N		\N	\N	\N	\N	295
485		\N		\N	\N	\N	\N	309
485		\N		\N	\N	\N	\N	319
485		\N		\N	\N	\N	\N	329
485		\N		\N	\N	\N	\N	355
485		\N		\N	\N	\N	\N	356
485		\N		\N	\N	\N	\N	357
485		\N		\N	\N	\N	\N	376
485		\N		\N	\N	\N	\N	382
485		\N		\N	\N	\N	\N	417
485		\N		\N	\N	\N	\N	418
485		\N		\N	\N	\N	\N	488
485		\N		\N	\N	\N	\N	509
485		\N		\N	\N	\N	\N	510
485		\N		\N	\N	\N	\N	513
485		\N		\N	\N	\N	\N	732
485		\N		\N	\N	\N	\N	738
485		\N		\N	\N	\N	\N	742
485		\N		\N	\N	\N	\N	788
485		\N		\N	\N	\N	\N	792
485		\N		\N	\N	\N	\N	796
485		\N		\N	\N	\N	\N	797
47		\N		\N	\N	\N	\N	119
47		\N		\N	\N	\N	\N	120
47		\N		\N	\N	\N	\N	121
47		\N		\N	\N	\N	\N	285
47		\N		\N	\N	\N	\N	286
47		\N		\N	\N	\N	\N	287
47		\N		\N	\N	\N	\N	288
47		\N		\N	\N	\N	\N	301
47		\N		\N	\N	\N	\N	302
47		\N		\N	\N	\N	\N	351
47		\N		\N	\N	\N	\N	367
47		\N		\N	\N	\N	\N	376
47		\N		\N	\N	\N	\N	419
47		\N		\N	\N	\N	\N	424
47		\N		\N	\N	\N	\N	483
47		\N		\N	\N	\N	\N	526
175		\N		\N	\N	\N	\N	238
296		\N		\N	\N	\N	\N	438
296		\N		\N	\N	\N	\N	443
296		\N		\N	\N	\N	\N	444
296		\N		\N	\N	\N	\N	446
296		\N		\N	\N	\N	\N	483
296		\N		\N	\N	\N	\N	487
107		\N		\N	\N	\N	\N	51
107		\N		\N	\N	\N	\N	115
107		\N		\N	\N	\N	\N	248
107		\N		\N	\N	\N	\N	294
28		\N		\N	\N	\N	\N	356
28		\N		\N	\N	\N	\N	513
376		\N		\N	\N	\N	\N	319
237		\N		\N	\N	\N	\N	382
14		\N		\N	\N	\N	\N	198
14		\N		\N	\N	\N	\N	749
41		\N		\N	\N	\N	\N	7
41		\N		\N	\N	\N	\N	26
41		\N		\N	\N	\N	\N	102
41		\N		\N	\N	\N	\N	111
41		\N		\N	\N	\N	\N	115
41		\N		\N	\N	\N	\N	130
41		\N		\N	\N	\N	\N	148
41		\N		\N	\N	\N	\N	170
41		\N		\N	\N	\N	\N	177
41		\N		\N	\N	\N	\N	178
41		\N		\N	\N	\N	\N	179
41		\N		\N	\N	\N	\N	205
41		\N		\N	\N	\N	\N	217
41		\N		\N	\N	\N	\N	221
41		\N		\N	\N	\N	\N	234
41		\N		\N	\N	\N	\N	245
41		\N		\N	\N	\N	\N	256
41		\N		\N	\N	\N	\N	273
41		\N		\N	\N	\N	\N	295
41		\N		\N	\N	\N	\N	306
41		\N		\N	\N	\N	\N	307
41		\N		\N	\N	\N	\N	309
41		\N		\N	\N	\N	\N	322
41		\N		\N	\N	\N	\N	332
41		\N		\N	\N	\N	\N	353
41		\N		\N	\N	\N	\N	358
41		\N		\N	\N	\N	\N	360
41		\N		\N	\N	\N	\N	369
41		\N		\N	\N	\N	\N	389
41		\N		\N	\N	\N	\N	395
41		\N		\N	\N	\N	\N	405
41		\N		\N	\N	\N	\N	410
41		\N		\N	\N	\N	\N	443
41		\N		\N	\N	\N	\N	454
41		\N		\N	\N	\N	\N	480
41		\N		\N	\N	\N	\N	497
41		\N		\N	\N	\N	\N	569
41		\N		\N	\N	\N	\N	699
41		\N		\N	\N	\N	\N	700
41		\N		\N	\N	\N	\N	704
41		\N		\N	\N	\N	\N	705
41		\N		\N	\N	\N	\N	706
41		\N		\N	\N	\N	\N	709
41		\N		\N	\N	\N	\N	710
41		\N		\N	\N	\N	\N	712
41		\N		\N	\N	\N	\N	714
41		\N		\N	\N	\N	\N	715
41		\N		\N	\N	\N	\N	716
41		\N		\N	\N	\N	\N	717
41		\N		\N	\N	\N	\N	718
41		\N		\N	\N	\N	\N	719
41		\N		\N	\N	\N	\N	720
41		\N		\N	\N	\N	\N	730
41		\N		\N	\N	\N	\N	731
41		\N		\N	\N	\N	\N	732
41		\N		\N	\N	\N	\N	733
41		\N		\N	\N	\N	\N	735
41		\N		\N	\N	\N	\N	736
41		\N		\N	\N	\N	\N	737
41		\N		\N	\N	\N	\N	739
41		\N		\N	\N	\N	\N	740
41		\N		\N	\N	\N	\N	741
403		\N		\N	\N	\N	\N	146
403		\N		\N	\N	\N	\N	585
50		\N		\N	\N	\N	\N	39
50		\N		\N	\N	\N	\N	93
247		\N		\N	\N	\N	\N	203
247		\N		\N	\N	\N	\N	204
247		\N		\N	\N	\N	\N	298
247		\N		\N	\N	\N	\N	299
247		\N		\N	\N	\N	\N	421
247		\N		\N	\N	\N	\N	423
360		\N		\N	\N	\N	\N	299
190		\N		\N	\N	\N	\N	154
190		\N		\N	\N	\N	\N	156
190		\N		\N	\N	\N	\N	159
190		\N		\N	\N	\N	\N	161
190		\N		\N	\N	\N	\N	385
190		\N		\N	\N	\N	\N	485
231		\N		\N	\N	\N	\N	435
231		\N		\N	\N	\N	\N	783
743		\N		\N	\N	\N	\N	685
227		\N		\N	\N	\N	\N	185
227		\N		\N	\N	\N	\N	187
227		\N		\N	\N	\N	\N	191
227		\N		\N	\N	\N	\N	192
227		\N		\N	\N	\N	\N	232
227		\N		\N	\N	\N	\N	233
227		\N		\N	\N	\N	\N	234
227		\N		\N	\N	\N	\N	355
227		\N		\N	\N	\N	\N	360
227		\N		\N	\N	\N	\N	362
227		\N		\N	\N	\N	\N	507
227		\N		\N	\N	\N	\N	612
87		\N		\N	\N	\N	\N	112
87		\N		\N	\N	\N	\N	300
87		\N		\N	\N	\N	\N	372
87		\N		\N	\N	\N	\N	373
744		\N		\N	\N	\N	\N	691
761		\N		\N	\N	\N	\N	400
761		\N		\N	\N	\N	\N	682
745		\N		\N	\N	\N	\N	690
26		\N		\N	\N	\N	\N	18
26		\N		\N	\N	\N	\N	225
26		\N		\N	\N	\N	\N	360
433		\N		\N	\N	\N	\N	63
346		\N		\N	\N	\N	\N	562
59		\N		\N	\N	\N	\N	75
59		\N		\N	\N	\N	\N	102
59		\N		\N	\N	\N	\N	115
59		\N		\N	\N	\N	\N	139
59		\N		\N	\N	\N	\N	148
59		\N		\N	\N	\N	\N	178
59		\N		\N	\N	\N	\N	221
59		\N		\N	\N	\N	\N	272
59		\N		\N	\N	\N	\N	296
59		\N		\N	\N	\N	\N	298
59		\N		\N	\N	\N	\N	307
59		\N		\N	\N	\N	\N	309
59		\N		\N	\N	\N	\N	353
59		\N		\N	\N	\N	\N	369
59		\N		\N	\N	\N	\N	443
59		\N		\N	\N	\N	\N	454
59		\N		\N	\N	\N	\N	497
59		\N		\N	\N	\N	\N	544
59		\N		\N	\N	\N	\N	545
558		\N		\N	\N	\N	\N	32
350		\N		\N	\N	\N	\N	297
350		\N		\N	\N	\N	\N	350
350		\N		\N	\N	\N	\N	681
402		\N		\N	\N	\N	\N	681
225		\N		\N	\N	\N	\N	333
393		\N		\N	\N	\N	\N	382
393		\N		\N	\N	\N	\N	385
393		\N		\N	\N	\N	\N	389
434		\N		\N	\N	\N	\N	385
434		\N		\N	\N	\N	\N	389
572		\N		\N	\N	\N	\N	362
572		\N		\N	\N	\N	\N	432
572		\N		\N	\N	\N	\N	433
634		\N		\N	\N	\N	\N	169
634		\N		\N	\N	\N	\N	172
634		\N		\N	\N	\N	\N	176
297		\N		\N	\N	\N	\N	260
79		\N		\N	\N	\N	\N	61
219		\N		\N	\N	\N	\N	176
131		\N		\N	\N	\N	\N	110
167		\N		\N	\N	\N	\N	158
167		\N		\N	\N	\N	\N	209
153		\N		\N	\N	\N	\N	36
153		\N		\N	\N	\N	\N	38
153		\N		\N	\N	\N	\N	40
153		\N		\N	\N	\N	\N	42
153		\N		\N	\N	\N	\N	46
153		\N		\N	\N	\N	\N	58
153		\N		\N	\N	\N	\N	112
153		\N		\N	\N	\N	\N	127
153		\N		\N	\N	\N	\N	176
153		\N		\N	\N	\N	\N	178
153		\N		\N	\N	\N	\N	199
153		\N		\N	\N	\N	\N	208
153		\N		\N	\N	\N	\N	245
153		\N		\N	\N	\N	\N	246
153		\N		\N	\N	\N	\N	272
153		\N		\N	\N	\N	\N	281
153		\N		\N	\N	\N	\N	296
153		\N		\N	\N	\N	\N	298
153		\N		\N	\N	\N	\N	299
153		\N		\N	\N	\N	\N	302
153		\N		\N	\N	\N	\N	311
153		\N		\N	\N	\N	\N	316
153		\N		\N	\N	\N	\N	330
153		\N		\N	\N	\N	\N	354
153		\N		\N	\N	\N	\N	360
153		\N		\N	\N	\N	\N	384
153		\N		\N	\N	\N	\N	419
153		\N		\N	\N	\N	\N	427
153		\N		\N	\N	\N	\N	458
153		\N		\N	\N	\N	\N	459
153		\N		\N	\N	\N	\N	462
153		\N		\N	\N	\N	\N	473
153		\N		\N	\N	\N	\N	475
153		\N		\N	\N	\N	\N	498
153		\N		\N	\N	\N	\N	504
153		\N		\N	\N	\N	\N	506
153		\N		\N	\N	\N	\N	511
153		\N		\N	\N	\N	\N	514
153		\N		\N	\N	\N	\N	728
153		\N		\N	\N	\N	\N	729
153		\N		\N	\N	\N	\N	755
153		\N		\N	\N	\N	\N	758
153		\N		\N	\N	\N	\N	781
153		\N		\N	\N	\N	\N	783
408		\N		\N	\N	\N	\N	360
288		\N		\N	\N	\N	\N	112
288		\N		\N	\N	\N	\N	462
573		\N		\N	\N	\N	\N	179
143		\N		\N	\N	\N	\N	142
143		\N		\N	\N	\N	\N	191
91		\N		\N	\N	\N	\N	71
91		\N		\N	\N	\N	\N	72
91		\N		\N	\N	\N	\N	76
91		\N		\N	\N	\N	\N	417
4		\N		\N	\N	\N	\N	5
4		\N		\N	\N	\N	\N	6
4		\N		\N	\N	\N	\N	113
473		\N		\N	\N	\N	\N	311
276		\N		\N	\N	\N	\N	239
76		\N		\N	\N	\N	\N	57
76		\N		\N	\N	\N	\N	87
76		\N		\N	\N	\N	\N	176
76		\N		\N	\N	\N	\N	216
76		\N		\N	\N	\N	\N	394
76		\N		\N	\N	\N	\N	462
201		\N		\N	\N	\N	\N	1
201		\N		\N	\N	\N	\N	2
201		\N		\N	\N	\N	\N	34
201		\N		\N	\N	\N	\N	35
201		\N		\N	\N	\N	\N	44
201		\N		\N	\N	\N	\N	79
201		\N		\N	\N	\N	\N	80
201		\N		\N	\N	\N	\N	135
201		\N		\N	\N	\N	\N	136
201		\N		\N	\N	\N	\N	276
201		\N		\N	\N	\N	\N	277
201		\N		\N	\N	\N	\N	363
201		\N		\N	\N	\N	\N	408
201		\N		\N	\N	\N	\N	492
201		\N		\N	\N	\N	\N	509
201		\N		\N	\N	\N	\N	510
201		\N		\N	\N	\N	\N	767
201		\N		\N	\N	\N	\N	770
679		\N		\N	\N	\N	\N	56
679		\N		\N	\N	\N	\N	61
241		\N		\N	\N	\N	\N	206
241		\N		\N	\N	\N	\N	208
643		\N		\N	\N	\N	\N	142
685		\N		\N	\N	\N	\N	301
278		\N		\N	\N	\N	\N	164
278		\N		\N	\N	\N	\N	243
278		\N		\N	\N	\N	\N	311
92		\N		\N	\N	\N	\N	319
141		\N		\N	\N	\N	\N	120
141		\N		\N	\N	\N	\N	121
141		\N		\N	\N	\N	\N	301
141		\N		\N	\N	\N	\N	302
166		\N		\N	\N	\N	\N	183
166		\N		\N	\N	\N	\N	666
429		\N		\N	\N	\N	\N	587
429		\N		\N	\N	\N	\N	592
9		\N		\N	\N	\N	\N	57
9		\N		\N	\N	\N	\N	61
9		\N		\N	\N	\N	\N	371
9		\N		\N	\N	\N	\N	754
23		\N		\N	\N	\N	\N	17
23		\N		\N	\N	\N	\N	51
23		\N		\N	\N	\N	\N	176
23		\N		\N	\N	\N	\N	185
23		\N		\N	\N	\N	\N	199
23		\N		\N	\N	\N	\N	225
582		\N		\N	\N	\N	\N	504
93		\N		\N	\N	\N	\N	67
93		\N		\N	\N	\N	\N	141
93		\N		\N	\N	\N	\N	320
93		\N		\N	\N	\N	\N	362
93		\N		\N	\N	\N	\N	432
93		\N		\N	\N	\N	\N	488
93		\N		\N	\N	\N	\N	496
93		\N		\N	\N	\N	\N	497
723		\N		\N	\N	\N	\N	67
723		\N		\N	\N	\N	\N	141
723		\N		\N	\N	\N	\N	488
461		\N		\N	\N	\N	\N	362
461		\N		\N	\N	\N	\N	433
774		\N		\N	\N	\N	\N	770
39		\N		\N	\N	\N	\N	32
39		\N		\N	\N	\N	\N	121
39		\N		\N	\N	\N	\N	126
39		\N		\N	\N	\N	\N	139
39		\N		\N	\N	\N	\N	171
39		\N		\N	\N	\N	\N	200
39		\N		\N	\N	\N	\N	203
39		\N		\N	\N	\N	\N	232
39		\N		\N	\N	\N	\N	274
39		\N		\N	\N	\N	\N	281
39		\N		\N	\N	\N	\N	296
39		\N		\N	\N	\N	\N	321
39		\N		\N	\N	\N	\N	378
39		\N		\N	\N	\N	\N	429
39		\N		\N	\N	\N	\N	432
39		\N		\N	\N	\N	\N	734
39		\N		\N	\N	\N	\N	772
464		\N		\N	\N	\N	\N	436
614		\N		\N	\N	\N	\N	272
115		\N		\N	\N	\N	\N	475
405		\N		\N	\N	\N	\N	81
405		\N		\N	\N	\N	\N	143
405		\N		\N	\N	\N	\N	261
405		\N		\N	\N	\N	\N	271
405		\N		\N	\N	\N	\N	272
405		\N		\N	\N	\N	\N	284
405		\N		\N	\N	\N	\N	304
405		\N		\N	\N	\N	\N	313
405		\N		\N	\N	\N	\N	319
405		\N		\N	\N	\N	\N	329
405		\N		\N	\N	\N	\N	339
405		\N		\N	\N	\N	\N	362
405		\N		\N	\N	\N	\N	497
405		\N		\N	\N	\N	\N	775
405		\N		\N	\N	\N	\N	776
405		\N		\N	\N	\N	\N	777
405		\N		\N	\N	\N	\N	780
405		\N		\N	\N	\N	\N	782
417		\N		\N	\N	\N	\N	497
339		\N		\N	\N	\N	\N	143
339		\N		\N	\N	\N	\N	271
339		\N		\N	\N	\N	\N	272
339		\N		\N	\N	\N	\N	775
339		\N		\N	\N	\N	\N	776
339		\N		\N	\N	\N	\N	777
339		\N		\N	\N	\N	\N	780
262		\N		\N	\N	\N	\N	272
262		\N		\N	\N	\N	\N	319
311		\N		\N	\N	\N	\N	294
311		\N		\N	\N	\N	\N	496
311		\N		\N	\N	\N	\N	497
311		\N		\N	\N	\N	\N	540
311		\N		\N	\N	\N	\N	548
31		\N		\N	\N	\N	\N	27
31		\N		\N	\N	\N	\N	29
31		\N		\N	\N	\N	\N	368
31		\N		\N	\N	\N	\N	374
435		\N		\N	\N	\N	\N	541
435		\N		\N	\N	\N	\N	542
293		\N		\N	\N	\N	\N	253
293		\N		\N	\N	\N	\N	257
293		\N		\N	\N	\N	\N	259
284		\N		\N	\N	\N	\N	311
300		\N		\N	\N	\N	\N	782
99		\N		\N	\N	\N	\N	344
187		\N		\N	\N	\N	\N	198
15		\N		\N	\N	\N	\N	113
15		\N		\N	\N	\N	\N	115
15		\N		\N	\N	\N	\N	173
465		\N		\N	\N	\N	\N	444
465		\N		\N	\N	\N	\N	446
161		\N		\N	\N	\N	\N	133
161		\N		\N	\N	\N	\N	139
184		\N		\N	\N	\N	\N	149
436		\N		\N	\N	\N	\N	397
436		\N		\N	\N	\N	\N	398
436		\N		\N	\N	\N	\N	400
261		\N		\N	\N	\N	\N	233
73		\N		\N	\N	\N	\N	61
40		\N		\N	\N	\N	\N	270
428		\N		\N	\N	\N	\N	8
428		\N		\N	\N	\N	\N	10
428		\N		\N	\N	\N	\N	12
428		\N		\N	\N	\N	\N	24
428		\N		\N	\N	\N	\N	52
428		\N		\N	\N	\N	\N	55
428		\N		\N	\N	\N	\N	57
428		\N		\N	\N	\N	\N	61
428		\N		\N	\N	\N	\N	91
428		\N		\N	\N	\N	\N	110
428		\N		\N	\N	\N	\N	116
428		\N		\N	\N	\N	\N	119
428		\N		\N	\N	\N	\N	136
428		\N		\N	\N	\N	\N	155
428		\N		\N	\N	\N	\N	156
428		\N		\N	\N	\N	\N	161
428		\N		\N	\N	\N	\N	162
428		\N		\N	\N	\N	\N	201
428		\N		\N	\N	\N	\N	258
428		\N		\N	\N	\N	\N	270
428		\N		\N	\N	\N	\N	271
428		\N		\N	\N	\N	\N	289
428		\N		\N	\N	\N	\N	292
428		\N		\N	\N	\N	\N	295
428		\N		\N	\N	\N	\N	297
428		\N		\N	\N	\N	\N	325
428		\N		\N	\N	\N	\N	329
428		\N		\N	\N	\N	\N	349
428		\N		\N	\N	\N	\N	350
428		\N		\N	\N	\N	\N	351
428		\N		\N	\N	\N	\N	361
428		\N		\N	\N	\N	\N	362
428		\N		\N	\N	\N	\N	364
428		\N		\N	\N	\N	\N	372
428		\N		\N	\N	\N	\N	385
428		\N		\N	\N	\N	\N	390
428		\N		\N	\N	\N	\N	392
428		\N		\N	\N	\N	\N	394
428		\N		\N	\N	\N	\N	397
428		\N		\N	\N	\N	\N	398
428		\N		\N	\N	\N	\N	402
428		\N		\N	\N	\N	\N	404
428		\N		\N	\N	\N	\N	433
428		\N		\N	\N	\N	\N	464
428		\N		\N	\N	\N	\N	467
428		\N		\N	\N	\N	\N	481
428		\N		\N	\N	\N	\N	501
428		\N		\N	\N	\N	\N	681
428		\N		\N	\N	\N	\N	684
75		\N		\N	\N	\N	\N	57
75		\N		\N	\N	\N	\N	155
75		\N		\N	\N	\N	\N	258
75		\N		\N	\N	\N	\N	289
75		\N		\N	\N	\N	\N	292
75		\N		\N	\N	\N	\N	350
75		\N		\N	\N	\N	\N	351
75		\N		\N	\N	\N	\N	394
75		\N		\N	\N	\N	\N	397
75		\N		\N	\N	\N	\N	398
75		\N		\N	\N	\N	\N	684
348		\N		\N	\N	\N	\N	55
348		\N		\N	\N	\N	\N	57
348		\N		\N	\N	\N	\N	116
348		\N		\N	\N	\N	\N	119
348		\N		\N	\N	\N	\N	155
348		\N		\N	\N	\N	\N	162
348		\N		\N	\N	\N	\N	258
348		\N		\N	\N	\N	\N	292
348		\N		\N	\N	\N	\N	349
348		\N		\N	\N	\N	\N	350
348		\N		\N	\N	\N	\N	351
348		\N		\N	\N	\N	\N	364
348		\N		\N	\N	\N	\N	392
348		\N		\N	\N	\N	\N	394
348		\N		\N	\N	\N	\N	397
348		\N		\N	\N	\N	\N	398
348		\N		\N	\N	\N	\N	464
348		\N		\N	\N	\N	\N	684
756		\N		\N	\N	\N	\N	119
756		\N		\N	\N	\N	\N	349
754		\N		\N	\N	\N	\N	289
754		\N		\N	\N	\N	\N	292
754		\N		\N	\N	\N	\N	350
754		\N		\N	\N	\N	\N	351
754		\N		\N	\N	\N	\N	397
754		\N		\N	\N	\N	\N	398
754		\N		\N	\N	\N	\N	464
760		\N		\N	\N	\N	\N	55
760		\N		\N	\N	\N	\N	57
760		\N		\N	\N	\N	\N	392
760		\N		\N	\N	\N	\N	394
387		\N		\N	\N	\N	\N	57
387		\N		\N	\N	\N	\N	61
320		\N		\N	\N	\N	\N	433
132		\N		\N	\N	\N	\N	362
399		\N		\N	\N	\N	\N	351
62		\N		\N	\N	\N	\N	154
223		\N		\N	\N	\N	\N	305
789		\N		\N	\N	\N	\N	243
789		\N		\N	\N	\N	\N	245
762		\N		\N	\N	\N	\N	355
448		\N		\N	\N	\N	\N	106
448		\N		\N	\N	\N	\N	107
242		\N		\N	\N	\N	\N	202
242		\N		\N	\N	\N	\N	305
242		\N		\N	\N	\N	\N	306
242		\N		\N	\N	\N	\N	307
242		\N		\N	\N	\N	\N	309
242		\N		\N	\N	\N	\N	421
20		\N		\N	\N	\N	\N	44
20		\N		\N	\N	\N	\N	522
20		\N		\N	\N	\N	\N	601
20		\N		\N	\N	\N	\N	707
20		\N		\N	\N	\N	\N	708
20		\N		\N	\N	\N	\N	711
20		\N		\N	\N	\N	\N	713
20		\N		\N	\N	\N	\N	721
20		\N		\N	\N	\N	\N	722
20		\N		\N	\N	\N	\N	738
20		\N		\N	\N	\N	\N	742
20		\N		\N	\N	\N	\N	743
365		\N		\N	\N	\N	\N	487
301		\N		\N	\N	\N	\N	262
301		\N		\N	\N	\N	\N	267
301		\N		\N	\N	\N	\N	272
301		\N		\N	\N	\N	\N	275
301		\N		\N	\N	\N	\N	757
17		\N		\N	\N	\N	\N	21
22		\N		\N	\N	\N	\N	17
751		\N		\N	\N	\N	\N	48
751		\N		\N	\N	\N	\N	694
228		\N		\N	\N	\N	\N	169
228		\N		\N	\N	\N	\N	179
228		\N		\N	\N	\N	\N	183
228		\N		\N	\N	\N	\N	706
228		\N		\N	\N	\N	\N	730
228		\N		\N	\N	\N	\N	731
228		\N		\N	\N	\N	\N	735
228		\N		\N	\N	\N	\N	736
228		\N		\N	\N	\N	\N	737
228		\N		\N	\N	\N	\N	739
228		\N		\N	\N	\N	\N	740
698		\N		\N	\N	\N	\N	179
352		\N		\N	\N	\N	\N	176
352		\N		\N	\N	\N	\N	243
352		\N		\N	\N	\N	\N	473
352		\N		\N	\N	\N	\N	487
352		\N		\N	\N	\N	\N	497
191		\N		\N	\N	\N	\N	1
191		\N		\N	\N	\N	\N	2
191		\N		\N	\N	\N	\N	767
63		\N		\N	\N	\N	\N	162
63		\N		\N	\N	\N	\N	233
794		\N		\N	\N	\N	\N	271
98		\N		\N	\N	\N	\N	538
142		\N		\N	\N	\N	\N	163
142		\N		\N	\N	\N	\N	783
206		\N		\N	\N	\N	\N	169
152		\N		\N	\N	\N	\N	127
152		\N		\N	\N	\N	\N	594
152		\N		\N	\N	\N	\N	728
152		\N		\N	\N	\N	\N	729
11		\N		\N	\N	\N	\N	10
126		\N		\N	\N	\N	\N	107
179		\N		\N	\N	\N	\N	153
451		\N		\N	\N	\N	\N	265
447		\N		\N	\N	\N	\N	784
496		\N		\N	\N	\N	\N	305
496		\N		\N	\N	\N	\N	307
496		\N		\N	\N	\N	\N	309
567		\N		\N	\N	\N	\N	529
657		\N		\N	\N	\N	\N	143
628		\N		\N	\N	\N	\N	143
140		\N		\N	\N	\N	\N	110
140		\N		\N	\N	\N	\N	223
140		\N		\N	\N	\N	\N	227
140		\N		\N	\N	\N	\N	319
140		\N		\N	\N	\N	\N	321
140		\N		\N	\N	\N	\N	688
140		\N		\N	\N	\N	\N	762
265		\N		\N	\N	\N	\N	227
119		\N		\N	\N	\N	\N	693
151		\N		\N	\N	\N	\N	383
151		\N		\N	\N	\N	\N	727
310		\N		\N	\N	\N	\N	270
404		\N		\N	\N	\N	\N	680
398		\N		\N	\N	\N	\N	344
398		\N		\N	\N	\N	\N	345
149		\N		\N	\N	\N	\N	122
149		\N		\N	\N	\N	\N	126
149		\N		\N	\N	\N	\N	292
645		\N		\N	\N	\N	\N	427
450		\N		\N	\N	\N	\N	424
759		\N		\N	\N	\N	\N	154
759		\N		\N	\N	\N	\N	683
103		\N		\N	\N	\N	\N	116
103		\N		\N	\N	\N	\N	141
103		\N		\N	\N	\N	\N	177
103		\N		\N	\N	\N	\N	208
103		\N		\N	\N	\N	\N	266
103		\N		\N	\N	\N	\N	353
103		\N		\N	\N	\N	\N	359
103		\N		\N	\N	\N	\N	369
103		\N		\N	\N	\N	\N	456
103		\N		\N	\N	\N	\N	496
205		\N		\N	\N	\N	\N	23
205		\N		\N	\N	\N	\N	139
205		\N		\N	\N	\N	\N	245
430		\N		\N	\N	\N	\N	371
430		\N		\N	\N	\N	\N	372
46		\N		\N	\N	\N	\N	208
46		\N		\N	\N	\N	\N	414
46		\N		\N	\N	\N	\N	784
127		\N		\N	\N	\N	\N	109
127		\N		\N	\N	\N	\N	765
180		\N		\N	\N	\N	\N	250
180		\N		\N	\N	\N	\N	568
180		\N		\N	\N	\N	\N	662
694		\N		\N	\N	\N	\N	546
10		\N		\N	\N	\N	\N	15
10		\N		\N	\N	\N	\N	17
10		\N		\N	\N	\N	\N	37
10		\N		\N	\N	\N	\N	44
10		\N		\N	\N	\N	\N	48
10		\N		\N	\N	\N	\N	49
10		\N		\N	\N	\N	\N	57
10		\N		\N	\N	\N	\N	61
10		\N		\N	\N	\N	\N	85
10		\N		\N	\N	\N	\N	88
10		\N		\N	\N	\N	\N	102
10		\N		\N	\N	\N	\N	125
10		\N		\N	\N	\N	\N	127
10		\N		\N	\N	\N	\N	129
10		\N		\N	\N	\N	\N	163
10		\N		\N	\N	\N	\N	173
10		\N		\N	\N	\N	\N	174
10		\N		\N	\N	\N	\N	178
10		\N		\N	\N	\N	\N	179
10		\N		\N	\N	\N	\N	191
10		\N		\N	\N	\N	\N	194
10		\N		\N	\N	\N	\N	198
10		\N		\N	\N	\N	\N	221
10		\N		\N	\N	\N	\N	233
10		\N		\N	\N	\N	\N	234
10		\N		\N	\N	\N	\N	243
10		\N		\N	\N	\N	\N	252
10		\N		\N	\N	\N	\N	259
10		\N		\N	\N	\N	\N	260
10		\N		\N	\N	\N	\N	280
10		\N		\N	\N	\N	\N	284
10		\N		\N	\N	\N	\N	285
10		\N		\N	\N	\N	\N	288
10		\N		\N	\N	\N	\N	294
10		\N		\N	\N	\N	\N	304
10		\N		\N	\N	\N	\N	323
10		\N		\N	\N	\N	\N	331
10		\N		\N	\N	\N	\N	341
10		\N		\N	\N	\N	\N	344
10		\N		\N	\N	\N	\N	348
10		\N		\N	\N	\N	\N	351
10		\N		\N	\N	\N	\N	389
10		\N		\N	\N	\N	\N	394
10		\N		\N	\N	\N	\N	397
10		\N		\N	\N	\N	\N	400
10		\N		\N	\N	\N	\N	401
10		\N		\N	\N	\N	\N	411
10		\N		\N	\N	\N	\N	428
10		\N		\N	\N	\N	\N	444
10		\N		\N	\N	\N	\N	467
10		\N		\N	\N	\N	\N	469
10		\N		\N	\N	\N	\N	472
10		\N		\N	\N	\N	\N	487
10		\N		\N	\N	\N	\N	491
10		\N		\N	\N	\N	\N	497
10		\N		\N	\N	\N	\N	513
10		\N		\N	\N	\N	\N	625
10		\N		\N	\N	\N	\N	697
10		\N		\N	\N	\N	\N	701
10		\N		\N	\N	\N	\N	702
10		\N		\N	\N	\N	\N	703
10		\N		\N	\N	\N	\N	707
10		\N		\N	\N	\N	\N	708
10		\N		\N	\N	\N	\N	709
10		\N		\N	\N	\N	\N	710
10		\N		\N	\N	\N	\N	711
10		\N		\N	\N	\N	\N	712
10		\N		\N	\N	\N	\N	713
10		\N		\N	\N	\N	\N	714
10		\N		\N	\N	\N	\N	715
10		\N		\N	\N	\N	\N	716
10		\N		\N	\N	\N	\N	717
10		\N		\N	\N	\N	\N	718
10		\N		\N	\N	\N	\N	719
10		\N		\N	\N	\N	\N	720
10		\N		\N	\N	\N	\N	721
10		\N		\N	\N	\N	\N	722
10		\N		\N	\N	\N	\N	723
10		\N		\N	\N	\N	\N	724
10		\N		\N	\N	\N	\N	725
10		\N		\N	\N	\N	\N	726
10		\N		\N	\N	\N	\N	727
10		\N		\N	\N	\N	\N	728
10		\N		\N	\N	\N	\N	729
10		\N		\N	\N	\N	\N	733
10		\N		\N	\N	\N	\N	739
10		\N		\N	\N	\N	\N	740
10		\N		\N	\N	\N	\N	743
478		\N		\N	\N	\N	\N	473
422		\N		\N	\N	\N	\N	1
422		\N		\N	\N	\N	\N	2
422		\N		\N	\N	\N	\N	34
422		\N		\N	\N	\N	\N	35
422		\N		\N	\N	\N	\N	44
422		\N		\N	\N	\N	\N	79
422		\N		\N	\N	\N	\N	80
422		\N		\N	\N	\N	\N	276
422		\N		\N	\N	\N	\N	277
422		\N		\N	\N	\N	\N	492
422		\N		\N	\N	\N	\N	509
422		\N		\N	\N	\N	\N	510
422		\N		\N	\N	\N	\N	767
422		\N		\N	\N	\N	\N	770
489		\N		\N	\N	\N	\N	1
489		\N		\N	\N	\N	\N	2
489		\N		\N	\N	\N	\N	34
489		\N		\N	\N	\N	\N	35
489		\N		\N	\N	\N	\N	44
489		\N		\N	\N	\N	\N	79
489		\N		\N	\N	\N	\N	80
489		\N		\N	\N	\N	\N	276
489		\N		\N	\N	\N	\N	277
489		\N		\N	\N	\N	\N	509
489		\N		\N	\N	\N	\N	510
489		\N		\N	\N	\N	\N	767
489		\N		\N	\N	\N	\N	770
758		\N		\N	\N	\N	\N	679
104		\N		\N	\N	\N	\N	443
104		\N		\N	\N	\N	\N	448
462		\N		\N	\N	\N	\N	435
51		\N		\N	\N	\N	\N	46
51		\N		\N	\N	\N	\N	514
757		\N		\N	\N	\N	\N	154
757		\N		\N	\N	\N	\N	678
641		\N		\N	\N	\N	\N	530
257		\N		\N	\N	\N	\N	221
439		\N		\N	\N	\N	\N	671
755		\N		\N	\N	\N	\N	116
775		\N		\N	\N	\N	\N	34
775		\N		\N	\N	\N	\N	35
775		\N		\N	\N	\N	\N	44
775		\N		\N	\N	\N	\N	67
775		\N		\N	\N	\N	\N	141
775		\N		\N	\N	\N	\N	276
775		\N		\N	\N	\N	\N	277
775		\N		\N	\N	\N	\N	488
775		\N		\N	\N	\N	\N	509
775		\N		\N	\N	\N	\N	510
775		\N		\N	\N	\N	\N	796
660		\N		\N	\N	\N	\N	288
660		\N		\N	\N	\N	\N	732
660		\N		\N	\N	\N	\N	738
660		\N		\N	\N	\N	\N	742
340		\N		\N	\N	\N	\N	286
340		\N		\N	\N	\N	\N	287
340		\N		\N	\N	\N	\N	288
13		\N		\N	\N	\N	\N	208
13		\N		\N	\N	\N	\N	448
13		\N		\N	\N	\N	\N	505
38		\N		\N	\N	\N	\N	569
192		\N		\N	\N	\N	\N	79
192		\N		\N	\N	\N	\N	80
88		\N		\N	\N	\N	\N	371
97		\N		\N	\N	\N	\N	243
97		\N		\N	\N	\N	\N	776
111		\N		\N	\N	\N	\N	87
111		\N		\N	\N	\N	\N	109
111		\N		\N	\N	\N	\N	228
111		\N		\N	\N	\N	\N	229
111		\N		\N	\N	\N	\N	233
81		\N		\N	\N	\N	\N	59
81		\N		\N	\N	\N	\N	344
611		\N		\N	\N	\N	\N	527
181		\N		\N	\N	\N	\N	343
181		\N		\N	\N	\N	\N	631
214		\N		\N	\N	\N	\N	48
214		\N		\N	\N	\N	\N	168
214		\N		\N	\N	\N	\N	169
214		\N		\N	\N	\N	\N	174
214		\N		\N	\N	\N	\N	491
214		\N		\N	\N	\N	\N	492
214		\N		\N	\N	\N	\N	809
214		\N		\N	\N	\N	\N	810
214		\N		\N	\N	\N	\N	815
214		\N		\N	\N	\N	\N	816
69		\N		\N	\N	\N	\N	491
69		\N		\N	\N	\N	\N	492
718		\N		\N	\N	\N	\N	610
718		\N		\N	\N	\N	\N	744
601		\N		\N	\N	\N	\N	745
649		\N		\N	\N	\N	\N	275
649		\N		\N	\N	\N	\N	339
649		\N		\N	\N	\N	\N	350
649		\N		\N	\N	\N	\N	356
649		\N		\N	\N	\N	\N	570
649		\N		\N	\N	\N	\N	572
324		\N		\N	\N	\N	\N	141
307		\N		\N	\N	\N	\N	274
307		\N		\N	\N	\N	\N	275
114		\N		\N	\N	\N	\N	454
114		\N		\N	\N	\N	\N	457
114		\N		\N	\N	\N	\N	771
294		\N		\N	\N	\N	\N	409
290		\N		\N	\N	\N	\N	248
290		\N		\N	\N	\N	\N	250
482		\N		\N	\N	\N	\N	456
675		\N		\N	\N	\N	\N	58
78		\N		\N	\N	\N	\N	61
452		\N		\N	\N	\N	\N	423
358		\N		\N	\N	\N	\N	109
358		\N		\N	\N	\N	\N	116
358		\N		\N	\N	\N	\N	164
358		\N		\N	\N	\N	\N	234
358		\N		\N	\N	\N	\N	298
358		\N		\N	\N	\N	\N	299
358		\N		\N	\N	\N	\N	309
358		\N		\N	\N	\N	\N	322
358		\N		\N	\N	\N	\N	343
358		\N		\N	\N	\N	\N	350
358		\N		\N	\N	\N	\N	356
358		\N		\N	\N	\N	\N	357
109		\N		\N	\N	\N	\N	116
109		\N		\N	\N	\N	\N	299
109		\N		\N	\N	\N	\N	309
109		\N		\N	\N	\N	\N	350
109		\N		\N	\N	\N	\N	357
60		\N		\N	\N	\N	\N	62
60		\N		\N	\N	\N	\N	87
60		\N		\N	\N	\N	\N	100
60		\N		\N	\N	\N	\N	118
60		\N		\N	\N	\N	\N	230
60		\N		\N	\N	\N	\N	261
60		\N		\N	\N	\N	\N	284
60		\N		\N	\N	\N	\N	293
60		\N		\N	\N	\N	\N	336
60		\N		\N	\N	\N	\N	372
60		\N		\N	\N	\N	\N	446
60		\N		\N	\N	\N	\N	447
338		\N		\N	\N	\N	\N	42
338		\N		\N	\N	\N	\N	62
338		\N		\N	\N	\N	\N	82
338		\N		\N	\N	\N	\N	87
338		\N		\N	\N	\N	\N	99
338		\N		\N	\N	\N	\N	100
338		\N		\N	\N	\N	\N	109
338		\N		\N	\N	\N	\N	118
338		\N		\N	\N	\N	\N	164
338		\N		\N	\N	\N	\N	191
338		\N		\N	\N	\N	\N	228
338		\N		\N	\N	\N	\N	230
338		\N		\N	\N	\N	\N	290
338		\N		\N	\N	\N	\N	329
338		\N		\N	\N	\N	\N	336
338		\N		\N	\N	\N	\N	372
338		\N		\N	\N	\N	\N	407
338		\N		\N	\N	\N	\N	420
338		\N		\N	\N	\N	\N	436
338		\N		\N	\N	\N	\N	446
338		\N		\N	\N	\N	\N	447
832		\N		\N	\N	\N	\N	42
832		\N		\N	\N	\N	\N	82
832		\N		\N	\N	\N	\N	99
832		\N		\N	\N	\N	\N	100
832		\N		\N	\N	\N	\N	290
474		\N		\N	\N	\N	\N	471
394		\N		\N	\N	\N	\N	376
394		\N		\N	\N	\N	\N	664
394		\N		\N	\N	\N	\N	675
469		\N		\N	\N	\N	\N	459
655		\N		\N	\N	\N	\N	723
655		\N		\N	\N	\N	\N	724
655		\N		\N	\N	\N	\N	734
655		\N		\N	\N	\N	\N	737
539		\N		\N	\N	\N	\N	525
32		\N		\N	\N	\N	\N	481
32		\N		\N	\N	\N	\N	483
825		\N		\N	\N	\N	\N	179
74		\N		\N	\N	\N	\N	61
74		\N		\N	\N	\N	\N	176
244		\N		\N	\N	\N	\N	202
799		\N		\N	\N	\N	\N	298
193		\N		\N	\N	\N	\N	560
432		\N		\N	\N	\N	\N	401
432		\N		\N	\N	\N	\N	483
432		\N		\N	\N	\N	\N	791
391		\N		\N	\N	\N	\N	16
391		\N		\N	\N	\N	\N	18
391		\N		\N	\N	\N	\N	223
391		\N		\N	\N	\N	\N	225
391		\N		\N	\N	\N	\N	357
391		\N		\N	\N	\N	\N	360
688		\N		\N	\N	\N	\N	122
688		\N		\N	\N	\N	\N	362
199		\N		\N	\N	\N	\N	316
199		\N		\N	\N	\N	\N	320
609		\N		\N	\N	\N	\N	204
5		\N		\N	\N	\N	\N	208
35		\N		\N	\N	\N	\N	27
35		\N		\N	\N	\N	\N	28
35		\N		\N	\N	\N	\N	57
35		\N		\N	\N	\N	\N	191
35		\N		\N	\N	\N	\N	233
35		\N		\N	\N	\N	\N	271
35		\N		\N	\N	\N	\N	394
35		\N		\N	\N	\N	\N	772
35		\N		\N	\N	\N	\N	796
842		\N		\N	\N	\N	\N	431
842		\N		\N	\N	\N	\N	465
856		\N		\N	\N	\N	\N	401
867		\N		\N	\N	\N	\N	215
868		\N		\N	\N	\N	\N	42
868		\N		\N	\N	\N	\N	198
872		\N		\N	\N	\N	\N	730
881		\N		\N	\N	\N	\N	513
5		\N		\N	\N	\N	\N	398
359		\N		\N	\N	\N	\N	818
51		\N		\N	\N	\N	\N	819
148		\N		\N	\N	\N	\N	1230
19		\N		\N	\N	\N	\N	284
19		\N		\N	\N	\N	\N	153
19		\N		\N	\N	\N	\N	48
19		\N		\N	\N	\N	\N	72
679		\N		\N	\N	\N	\N	1231
890		\N		\N	\N	\N	\N	1232
505		\N		\N	\N	\N	\N	1233
505		\N		\N	\N	\N	\N	1234
310		\N		\N	\N	\N	\N	1235
856		\N		\N	\N	\N	\N	1236
51		\N		\N	\N	\N	\N	1237
641		\N		\N	\N	\N	\N	1238
675		\N		\N	\N	\N	\N	1239
47		\N		\N	\N	\N	\N	971
718		\N		\N	\N	\N	\N	879
900		\N		\N	\N	\N	\N	1240
900		\N		\N	\N	\N	\N	1241
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: id
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

