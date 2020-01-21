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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO zh;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO zh;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO zh;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: zh
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


ALTER TABLE public.t_instance OWNER TO zh;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO zh;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO zh;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: zh
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


ALTER TABLE public.t_usage_classified_rel OWNER TO zh;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: zh
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


ALTER TABLE public.t_usage_inst_rel OWNER TO zh;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO zh;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO zh;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: zh
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO zh;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: zh
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


ALTER TABLE public.t_word_inst_rel OWNER TO zh;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: zh
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO zh;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: zh
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO zh;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: zh
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_index_char (id, index_char) FROM stdin;
1	a
2	b
3	c
4	d
5	e
6	f
7	g
8	h
9	j
10	k
11	l
12	m
13	n
14	o
15	p
16	q
17	r
18	s
19	t
20	w
21	x
22	y
23	z
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
1208	大家安静一下。	みなさんちょっと静かに。	\N		\N	vmod	\N	\N	\N	0	1
1	他也是留学生。	彼も留学生です。	null	Tā yě shì liúxuéshēng.	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
122	一个小时	１時間	null	yí ge xiǎoshí	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
2	他们都是老师。	彼らはみんな先生です。	null	Tāmen dōu shì lǎoshī.	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
87	讨论的题目	議論のテーマ	null	tǎolùn de tímù	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
417	星期天,星期日	日曜日	null	xīngqītiān ,xīngqīrì	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
601	他们吃午饭呢。	彼らは昼食を食べています。	null	Tāmen chī wǔfàn ne.	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
27	你怎么来了?	あなたはなぜ来たのですか。	null	 Nǐ zěnme lái le?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
998	你好。	あら，元気？	挨拶をする	Nǐ hǎo.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1218	她昨天傍晚才回来。	彼女は昨日	\N		\N	vmod	\N	\N	\N	0	1
1382	要糖吗?	砂糖いる？\n	\N		\N	vmod	\N	\N	\N	0	1
19	你家	あなたの家	null	nǐ jiā	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
152	小陈病了。	陳さんは病気になった。	null	Xiǎo Chén bìng le.	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
223	我高兴得很。	私はとてもうれしい。	null	Wǒ gāoxìng de hěn.	\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
485	不少书	少なからぬ本	null	bù shǎo shū	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
602	他在沙发上坐着。	彼はソファに座っています。	null	Tā zài shāfā shang zuòzhe.	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
695	邻居家死了一只猫。	隣で猫が１匹死んだ。	null	Línjū jiā sǐle yì zhī māo.	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
716	他两个星期理一次发。	彼は２週間に一度散髪する。	null	Tā liǎng ge xīngqī lǐ yí cì fà.	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
786	不，	いいえ，		Bù,	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
882	对了，	そうだ，	注意をひく	Duì le,	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
921	没有。	言ってないよ。		Méiyou.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
994	你就要毕业了。	もうすぐ卒業でしょう。		nǐ jiù yào bìyè le.	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1045	因为我生病了。	病気だったんだ。	理由を述べる	Yīnwèi wǒ shēng bìng le.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
3	他不是美国人。	彼はアメリカ人ではありません。	null	Tā bú shì Měiguórén.	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
4	她也不是老师。	彼女も先生ではありません。	null	Tā yě bú shì lǎoshī.	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
5	她是学生吗?	彼女は学生ですか。	null	Tā shì xuésheng ma?	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
6	他也是日本人吗?	彼も日本人ですか。	null	Tā yě shì Rìběnrén ma? 	\N	gmod	explanation004.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
7	这是词典。	これは辞書です。	null	Zhè shì cídiǎn.	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
8	我要这个。	私はこれが要ります。	null	Wǒ yào zhèige.	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
9	这个面包	このパン	null	zhèige miànbāo	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
10	哪个是你的?	どれがあなたのですか。	null	Něige shì nǐ de?	\N	gmod	explanation005.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
11	老师的词典	先生の辞書	null	lǎoshī de cídiǎn	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
12	图书馆的杂志	図書館の雑誌	null	túshūguǎn de zázhì	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
13	我的大衣	私のコート	null	wǒ de dàyī	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
14	中文杂志	中国語雑誌	null	Zhōngwén zázhì	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
15	体育老师	体育の先生	null	tǐyù lǎoshī	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
16	历史问题	歴史問題	null	lìshǐ wèntí	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
17	纸箱子	紙の箱	null	zhǐ xiāngzi	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
18	我爸爸	私のお父さん	null	wǒ bàba	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
20	你们班	あなたたちのクラス	null	nǐmen bān	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
1240	这桌子太低。	この机は低すぎる。\n	\N		\N	vmod	\N	\N	\N	0	1
21	我们学校	私たちの学校	null	wǒmen xuéxiào	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
22	这是他的笔吗?	これは彼のペンですか。	null	Zhè shì tā de bǐ ma?	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
23	不，这是我的。	いいえ，これは私のです。	null	Bù, zhè shì wǒ de.	\N	gmod	explanation006.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
24	你哥哥工作不工作? 	あなたのお兄さんは働いていますか。	null	Nǐ gēge gōngzuò bù gōngzuò?	\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
25	她是不是留学生? 	彼女は留学生ですか。	null	Tā shì bu shì liúxuéshēng?	\N	gmod	explanation007.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
26	这件衣服怎么洗?	この服はどうやって洗うのですか。	null	Zhè jiàn yīfu zěnme xǐ?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
28	屋里怎么这么黑? 	なんで部屋がこんなに暗いのだろう。	null	Wūli zěnme zhème hēi?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
29	你怎么了?	あなたどうしたの。	null	Nǐ zěnme le?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
30	怎么办? 	どうしよう。	null	Zěnme bàn?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
31	怎么回事?	何事ですか。	null	Zěnme huí shì?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
32	不怎么好。	大してよくない。	null	Bù zěnme hǎo.	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
33	怎么，你不同意?	何だ，同意しないのか。	null	Zěnme, nǐ bù tóngyì?	\N	gmod	explanation009.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
34	是你去，还是我去?	あなたが行きますか，それとも私が行きますか。	null	Shì nǐ qù, háishi wǒ qù?	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
35	你今天去，还是明天去? 	あなたは今日行きますか，それとも明日行きますか。	null	Nǐ jīntiān qù, háishi míngtiān qù?	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
36	你喜欢听音乐还是喜欢看电影?	あなたは音楽を聴くのが好きですか，それとも映画を見るのが好きですか。	null	Nǐ xǐhuan tīng yīnyuè háishi xǐhuan kàn diànyǐng?	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
37	她是医生还是护士? 	彼女は医者ですか，それとも看護婦ですか。	null	Tā shì yīshēng háishi hùshi?	\N	gmod	explanation010.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
38	老李呢? 我怎么没看见他? 	李さんは？なんで姿を見かけなかったんだろう。	null	Lǎo Lǐ ne? Wǒ zěnme méi kànjian tā?	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
39	我去北京。你呢?	私は北京に行きます。あなたは？	null	Wǒ qù Běijīng. Nǐ ne?	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
40	你上午值班，下午呢?	あなたは午前は当直ですが，午後は？	null	Nǐ shàngwǔ zhíbān, xiàwǔ ne?	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
41	她不同意呢?	彼女が同意しなかったら？（どうしよう）	null	Tā bù tóngyì ne?	\N	gmod	explanation011.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
42	你有几个孩子?	あなたは子供が何人いますか。	null	Nǐ yǒu jǐ ge háizi?	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
43	那个幼儿园有多少孩子?	あの幼稚園は子供が何人いますか。	null	 Nèige yòu’éryuán yǒu duōshao háizi?	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
44	几个字?	何字ですか？	null	Jǐ ge zì?	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
45	多少(个)字?	何字ですか？	null	Duōshao (ge) zì?	\N	gmod	explanation014.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
46	明年二○○五年。	来年は2005年です。	null	Míngnián èr líng líng wǔ nián.	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
47	今天四月十七号。	今日は4月17日です。	null	Jīntiān sìyuè shíqī hào.	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
48	明天星期天。	明日は日曜日です。	null	Míngtiān xīngqītiān.	\N	gmod	explanation015.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
49	哥哥十八岁，我十五岁。	兄は18歳で，私は15歳です。	null	Gēge shíbā suì, wǒ shíwǔ suì.	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
50	你是哪一年生的?	あなたは何年生まれですか。	null	Nǐ shì nǎ yì nián shēng de? 	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
51	我是一九六五年生的。	私は1965年生まれです。	null	Wǒ shì yī jiǔ liù wǔ nián shēng de.	\N	gmod	explanation017.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
52	这本书八十块钱。	この本は80元です。	null	Zhè běn shū bāshí kuài qián.	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
53	这本书不是八十块钱。	この本は80元ではありません。	null	Zhè běn shū bú shì bāshí kuài qián.	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
1241	请吃点儿点心。	お菓子を食べてください。\n	\N		\N	vmod	\N	\N	\N	0	1
54	这个多少钱?	これはいくらですか。	null	Zhèige duōshao qián?	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
55	找你五块。	５元のおつりです。	null	Zhǎo nǐ wǔ kuài.	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
56	找不开。有零的吗？	おつりがありません。細かいのお持ちですか。	null	Zhǎobukāi. Yǒu ling de ma?	\N	gmod	explanation018.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
57	我没有电脑。	私はパソコンを持っていません。	null	Wǒ méi yǒu diànnǎo.	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
58	你现在有时间吗? 	あなたは今時間がありますか。	null	Nǐ xiànzài yǒu shíjiān ma?	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
59	你现在有没有时间? 	あなたは今時間がありますか。	null	Nǐ xiànzài yǒu méi yǒu shíjiān?	\N	gmod	explanation019.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
60	这本是我的，那本是他的。	これは私ので，あれは彼のです。	null	Zhè běn shì wǒ de, nà běn shì tā de.	\N	gmod	explanation020.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
61	学校旁边有一个邮局。	学校のそばに郵便局があります。	null	Xuéxiào pángbiānr yǒu yí ge yóujú.	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
62	屋子里没有人。	部屋には人はいません。	null	Wūzi li méi yǒu rén.	\N	gmod	explanation021.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
63	里边儿没有人。	中には人はいません。	null	Lǐbianr méi yǒu rén.	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
64	中文杂志在上边儿，外文杂志在下边儿。	中国語の雑誌は上にあり，外国語の雑誌は下にあります。	null	Zhōngwén zázhì zài shàngbianr, wàiwén zázhì zài xiàbianr.	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
65	窗户前边儿有一盆花。	窓の前に鉢植えの花が一つある。	null	Chuānghu qiánbianr yǒu yì pén huā.	\N	gmod	explanation023.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
66	我的本子在老师那儿。	私のノートは先生のところにあります。	null	Wǒ de běnzi zài lǎoshī nàr.	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
67	我这里没有资料。	私のところには資料がありません。	null	Wǒ zhèli méi yǒu zīliào.	\N	gmod	explanation024.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
68	这间屋子非常干净。	この部屋はとてもきれいです。	null	Zhèi jiān wūzi fēicháng gānjìng.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
69	这个办法比较好。	この方法は比較的よいです。	null	Zhèige bànfǎ bǐjiào hǎo.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
70	这碗汤太咸。	このスープはしょっぱすぎます。	null	Zhèi wǎn tāng tài xián.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
71	这件衣服有点儿贵。	この服は少し高いです。	null	Zhèi jiàn yīfu yǒudiǎnr guì.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
72	今天很热。	今日は暑いです。	null	Jīntiān hěn rè.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
73	他很胖。	彼は太っています。	null	Tā hěn pàng.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
74	今天不热。	今日は暑くありません。	null	Jīntiān bú rè.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
75	她不很漂亮。	彼女はそれほどきれいではありません。	null	Tā bù hěn piàoliang.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
76	她很不漂亮。	彼女は全然きれいではありません。	null	Tā hěn bú piàoliang.	\N	gmod	explanation025.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
77	新书	新しい本	null	xīn shū	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
78	酸苹果	すっぱいリンゴ	null	suān píngguǒ	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
79	脏衣服	汚れた服	null	zāng yīfu	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
80	老实人	誠実な人	null	lǎoshi rén	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
81	重要问题	重要な問題	null	zhòngyào wèntí	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
82	很漂亮的衣服	とてもきれいな服	null	hěn piàoliang de yīfu	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
83	厚厚的地毯	ぶ厚いじゅうたん	null	hòuhòu de dìtǎn	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
84	挺贵的手绢儿	高価なハンカチ	null	tǐng guì de shǒujuànr	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
85	非常聪明的动物	非常に賢い動物	null	fēicháng cōngming de dòngwù	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
86	来的人	来る人，来た人	null	lái de rén	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
88	工作(的)条件	仕事の条件	null	gōngzuò (de) tiáojiàn	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
89	我要的书	私のほしい本	null	wǒ yào de shū	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
90	个子高的学生	背の高い学生	null	gèzi gāo de xuésheng	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
91	老师讲的课本	先生が講義する教科書	null	lǎoshī jiǎng de kèběn	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
92	很多书	たくさんの本	null	hěn duō shū	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
93	不少书	少なからぬ本	null	bù shǎo shū	\N	gmod	explanation026.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
94	天上没有月光，连星星也没有。	空には月の光がなく，星さえもない。	null	Tiān shang méi yǒu yuèguāng, lián xīngxing yě méi yǒu.	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
95	连我都知道了，他当然知道。	私でさえ知っているのだから，彼は当然知っている。	null	Lián wǒ dōu zhīdao le, tā dāngrán zhīdao.	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
96	这么大的事，你怎么连问都不问?	こんなに大きなことなのに，あなたはどうして尋ねもしないのですか。	null	Zhème dà de shì, nǐ zěnme lián wèn dōu bú wèn?	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
97	朋友给他的信，他连看也没看。	友人が彼にあげた手紙を彼は見もしなかった。	null	Péngyou gěi tā de xìn, tā lián kàn yě méi kàn.	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
98	到这儿以后，我连一天也没休息。	ここに来てから，私は１日も休んでいない。	null	Dào zhèr yǐhòu, wǒ lián yì tiān yě méi xiūxi.	\N	gmod	explanation031.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
99	时间还早，一个人都没来。	時間がまだ早く，一人も来ていない。	null	Shíjiān hái zǎo, yí ge rén dōu méi lái.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
100	那个地方我一次也没去过。	Nèige dìfang wǒ yí cì yě méi qùguo.	null	Nèige dìfang wǒ yí cì yě méi qùguo.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
101	今天一点儿也不冷。		null	Jīntiān yìdiǎnr yě bù lěng.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
102	我们一点儿都不累。	私たちは少しも疲れていない。	null	Wǒmen yìdiǎnr dōu bú lèi.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
103	我什么也听不见。	私は何も聞こえません。	null	Wǒ shénme yě tīngbujiàn.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
104	这件事谁都不知道。	このことは誰も知らない。	null	Zhè jiàn shì shéi dōu bù zhīdào.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
105	今天想休息，哪儿也不去。	今日は休みたいので，どこにも行きません。	null	Jīntiān xiǎng xiūxi, nǎr yě bú qù.	\N	gmod	explanation032.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
106	他开门出去了。	彼はドアを開けて出て行った。	null	Tā kāi mén chūqu le.	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
107	他出去开门了。	彼は出て行ってドアを開けた。	null	Tā chūqu kāi mén le.	\N	gmod	explanation033.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
108	休息室里可以吸烟。	休憩室ではタバコを吸ってもよい。	null	Xiūxishì li kěyǐ xīyān.	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
109	休息室里不能吸烟。	休憩室ではタバコを吸ってはいけない。	null	Xiūxishì li bù néng xīyān.	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
110	可以进来吗? 不行。	入ってよろしいですか。ダメです。	null	Kěyǐ jìnlai ma? Bù xíng.	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
111	他会游泳。	彼は泳ぐことができる。	null	Tā huì yóuyǒng.	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
112	他一分钟能游二十米。	彼は１分間に20メートル泳ぐことができる。	null	Tā yì fēn zhōng néng yóu èrshí mǐ.	\N	gmod	explanation034.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
113	他病了，我们去看看他吧。	彼は病気になったので，彼をちょっと見舞いに行きましょう。	null	Tā bìng le, wǒmen qù kànkan ba.	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
114	这个问题需要考虑考虑。	この問題はちょっと考えてみる必要がある。	null	Zhèige wèntí xūyào kǎolǜkaolü.	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
115	她想了想说:“还是你去吧!”	彼女はちょっと考えると「やはりあなたが行ってよ」と言った。	null	Tā xiǎnglexiang shuō:“Háishi nǐ qù ba!”	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
116	这个收音机坏了，不信你听听。	このラジオは壊れた，信じないならちょっと聴いてみてごらん。	null	Zhèige shōuyīnjī huài le, bú xìn nǐ tīngting.	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
117	这个菜怎么样，尝尝就知道了。	この料理はどうか，味をみてみればわかる。	null	Zhèige cài zěnmeyàng, chángchang jiù zhīdao le.	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
353	这	これ	null	zhè	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
118	我的钥匙不见了，你帮我找找! 	私の鍵がなくなりました，探すのを手伝ってくれませんか。	null	Wǒ de yàoshi bú jiàn le, nǐ bāng wǒ zhǎozhao!	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
119	王老师，您休息休息吧!	王先生，ちょっと休まれればいかがですか。	null	Wáng lǎoshī, nín xiūxixiuxi ba!	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
120	早晨起来跑跑步，做做操，对身体有好处。	朝起きてジョギングしたり，体操したりすると，体によい。	null	Zǎochén qǐlai pǎo pao bù, zuò zuo cāo, duì shēntǐ yǒu hǎochu.	\N	gmod	explanation036.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
121	一分(钟)	１分間	null	yì fēn (zhōng)	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
123	一天	１日間	null	yì tiān	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
124	一个星期	１週間	null	yí ge xīngqī	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
125	一个月	１ヶ月	null	yí ge yuè	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
126	一年	１年間	null	yì nián	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
127	休息十分钟	10分間休む	null	xiūxi shí fēn zhōng	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
128	看两个小时	２時間見る	null	kàn liǎng ge xiǎoshí	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
129	学四年	４年間勉強する	null	xué sì nián	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
130	他走了两天了。	彼が去ってから２日がたった。	null	Tā zǒule liǎng tiān le.	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
131	他回来半个小时了。	彼が帰ってきてから30分たった。	null	Tā huílai bàn ge xiǎoshí le.	\N	gmod	explanation038.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
132	我去过北京。	私は北京に行ったことがあります。	null	Wǒ qùguo Běijīng.	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
133	这本小说我看过。	この小説は私は読んだことがある。	null	Zhè běn xiǎoshuō wǒ kànguo.	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
134	他曾经学过法语。	彼はかつてフランス語を学んだことがある。	null	Tā céngjīng xuéguo Fǎyǔ.	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
135	这本小说我没看过。	この小説は私は読んだことがない。	null	Zhè běn xiǎoshuō wǒ méi kànguo.	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
136	我从来没学过法语。	私はこれまでフランス語を学んだことはない。	null	Wǒ cónglái méi xuéguo Fǎyǔ.	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
137	你爬过那座山吗?	あなたはあの山に登ったことがありますか。	null	Nǐ páguo nà zuò shān ma?	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
138	你爬过那座山没有?	あなたはあの山に登ったことがありますか。	null	Nǐ páguo nà zuò shān méiyou?	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
139	这个孩子小时候胖过，后来瘦下来了。	この子は小さい頃太っていたことがあるが，その後やせた。	null	Zhèige háizi xiǎo shíhou pàngguo, hòulái shòuxiàlai le.	\N	gmod	explanation039.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
140	这本书我看过了，你拿走吧。	この本は私は読み終わりました，持って行ってください。	null	Zhè běn shū wǒ kànguo le, nǐ názǒu ba.	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
141	行李检查过了，没问题。	荷物は検査し終わりました，問題はありませんでした。	null	Xíngli jiǎncháguo le, méi wèntí.	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
142	明天你吃过晚饭来一趟。	明日夕食が済んだら来てください。	null	Míngtiān nǐ chīguò wǎnfàn lái yí tàng.	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
143	午饭你吃过了吗?  还没吃呢。	お昼は済ませましたか。まだです。	null	Wǔfàn nǐ chīguo le ma? Hái méi chī ne.	\N	gmod	explanation040.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
144	我昨天买了一本词典。	私は昨日辞書を１冊買いました。	null	Wǒ zuótiān mǎile yì běn cídiǎn.	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
145	上星期六我们看了一个外国电影。	先週の土曜日私たちは外国映画を見ました。	null	Shàng xīngqīliù wǒmen kànle yí ge wàiguó diànyǐng.	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
146	我回家后给他写了一封信。	私は家に帰ってから彼に手紙を一通書きました。	null	Wǒ huí jiā hòu gěi tā xiěle yì fēng xìn.	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
147	明天下了课，我去找你。	明日授業が終わったら私はあなたを訪ねに行きます。	null	Míngtiān xiàle kè, wǒ qù zhǎo nǐ.	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
148	你看了今天的报吗? 	あなたは今日の新聞を読みましたか。	null	Nǐ kànle jīntiān de bào ma?	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
354	那	あれ，それ	null	nà	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
149	你看了今天的报没有? 	あなたは今日の新聞を読みましたか。	null	Nǐ kànle jīntiān de bào méiyou?	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
150	你看没看今天的报? 	あなたは今日の新聞を読みましたか。	null	Nǐ kàn méi kàn jīntiān de bào?	\N	gmod	explanation041.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
151	春天到了，天气暖和了。	春になった，気候が暖かくなった。	null	Chūntiān dào le, tiānqì nuǎnhuo le.	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
153	已经十二点了，你快睡觉吧。	もう12時だ，あなたは早く寝なさいよ。	null	Yǐjing shí diǎn le, nǐ kuài shuìjiào ba.	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
154	她又想去了。	彼女はまた行きたくなった。	null	Tā yòu xiǎng qù le.	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
155	我明天不去动物园了。	私は明日動物園に行かないことにした。	null	Wǒ míngtiān bú qù dòngwùyuán le.	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
156	昨天下午你去商店了没有?	昨日の午後あなたは店に行きましたか。	null	Zuótiān xiàwǔ nǐ qù shāngdiàn le méiyou?	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
157	昨天下午我没去商店。	昨日の午後私は店には行きませんでした。	null	Zuótiān xiàwǔ wǒ méi qù shāngdiàn.	\N	gmod	explanation042.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
158	我学汉语学了两年。	私は中国語を２年間勉強しました。	null	Wǒ xué Hànyǔ xuéle liǎng nián.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
159	我学汉语学了两年了。	私は中国語を２年間勉強しています。	null	Wǒ xué Hànyǔ xuéle liǎng nián le.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
160	昨天，我翻译了五个句子。	昨日，私は文を五つ訳しました。	null	Zuótiān, wǒ fānyìle wǔ ge jùzi.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
161	我翻译了五个句子了，现在要翻译下边的。	私は文を五つ訳したところです。今から次のを訳します。	null	Wǒ fānyìle wǔ ge jùzi le, xiànzài yào fānyì xiàbian de.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
162	这本书我看了三天了，还得两天才能看完。	この本は私は３日間読んできたところだ。もうあと２日かければ読み終わることができる。	null	Zhè běn shū wǒ kànle sān tiān le, hái děi liǎng tiān cái néng kànwán.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
163	这本书我看了三天了，不想看下去了。	この本は私は３日間読んできたところだが，もう読み続けたくなくなった。	null	Zhè běn shū wǒ kànle sān tiān le, bù xiǎng kànxiàqu le.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
164	他死了五年了。	彼は死んで５年になります。	null	Tā sǐle wǔ nián le.	\N	gmod	explanation043.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
165	火车快要到站了。	汽車がもうすぐ駅に到着します。	null	Huǒchē kuài yào dào zhàn le.	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
166	李老师快回国了。	李先生はもうすぐ帰国されます。	null	Lǐ lǎoshī kuài huí guó le.	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
167	电影要开始了，我们进去吧。	映画がもうすぐ始まります，入りましょう。	null	Diànyǐng yào kāishǐ le, wǒmen jìnqu ba.	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
168	四年的大学生活就要结束了。	4年間の大学生活がもうすぐ終わります。	null	Sì nián de dàxué shēnghuó jiù yào jiéshù le.	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
169	我们下星期就要考试了。	私たちは来週にはもう試験があります。	null	Wǒmen xià xīngqī jiù yào kǎoshì le.	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
170	快到十一点的时候，他才回家。	もうすぐ12時になろうかというときになって彼はやっと家に帰った。	null	Kuài dào shíyī diǎn de shíhou, tā cái huí jiā.	\N	gmod	explanation044.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
171	他们在开会呢。	彼らは会議中です。	null	Tāmen zài kāi huì ne.	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
172	他正钓鱼呢。	彼はちょうど魚釣りをしているところです。	null	Tā zhèng diào yú ne.	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
173	李老师正在给同学们上课。	李先生はちょうど学生たちに授業をしているところです。	null	Lǐ lǎoshī zhèngzài gěi tóngxuémen shàng kè.	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
174	他们吃午饭呢。	彼らは昼食を食べています。	null	Tāmen chī wǔfàn ne.	\N	gmod	explanation045.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
175	他在沙发上坐着。	彼はソファに座っています。	null	Tā zài shāfā shang zuòzhe.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
176	他在床上躺着。	彼はベッドで横になっています。	null	Tā zài chuáng shang tǎngzhe.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
177	我去的时候，发现门开着。	私が行ったとき，ドアが開いているのに気づきました。	null	Wǒ qù de shíhou, fāxiàn mén kāizhe.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
178	房间里没有人，门都锁着呢。	部屋には人はいません，ドアはみな鍵がかかっています。	null	Fángjiān li méi yǒu rén, mén dōu suǒzhe ne.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
179	今天她穿着一件很好看的衬衫。	今日は彼女はきれいなブラウスを着ています。	null	Jīntiān tā chuānzhe yí jiàn hěn hǎokàn de chènshān.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
180	躺着看书对眼睛不好。	寝転がって本を読むのは目によくありません。	null	Tǎngzhe kàn shū duì yǎnjing bù hǎo.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
181	开着窗户睡觉很凉快。	窓を開けて寝るのは涼しいです。	null	Kāizhe chuānghu shuìjiào hěn liángkuai.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
182	桌子上放着一本词典。	机に辞書が１冊置いてあります。	null	Zhuōzi shang fàngzhe yì běn cídiǎn.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
183	客厅里坐着两位客人。	応接間にお客が２人座られています。	null	Kètīng li zuòzhe liǎng wèi kèren.	\N	gmod	explanation046.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
184	我听懂了他的话。	私は彼の話が（聞いて）わかりました。	null	Wǒ tīngdǒngle tā de huà.	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
185	这本小说我还没看完呢。	この小説は私はまだ読み終えていません。	null	Zhè běn xiǎoshuō wǒ hái méi kànwán ne.	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
186	你不写清楚，我们怎么看?	あなたがはっきりと書いてくれなければ，どうやって読めばいいのですか。	null	Nǐ bù xiěqīngchu, wǒmen zěnme kàn?	\N	gmod	explanation047.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
187	他们把书放在桌子上就走了。	彼らは本を机の上に置くと立ち去った。	null	Tāmen bǎ shū fang zài zhuōzi shang jiù zǒu le.	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
188	别坐在地上啊！	地べたに座らないで。	null	Bié zuò zài dìshang a!	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
189	邮票最好贴在信封正面。	切手は封筒の表面に貼るのがよい。	null	Yóupiào zuì hǎo tiē zài xìnfēng zhèngmiàn.	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
190	把号码写在右上角吧！	番号を右上の隅に書いてください。	null	Bǎ hàomǎ xiě zài yòu shàng jiǎo ba!	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
191	他从前天起一直躺在床上。	彼はおとといからずっとベッドに伏せている。	null	Tā cóng qiántiān qǐ yìzhí tǎng zài chuáng shang.	\N	gmod	explanation048.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
192	他明天回来。	彼は明日帰って来る。	null	Tā míngtiān huílai.	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
193	他给我寄来一件生日礼物。	彼は私に誕生日プレゼントを一つ送って来た。	null	Tā gěi wǒ jìlai yí jiàn shēngrì lǐwù.	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
194	这儿有几封信，你们拿去吧。	ここに手紙がいくつかあるから，あなたたち持って行ってください。	null	Zhèr yǒu jǐ fēng xìn, nǐmen náqu ba.	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
195	他朝宿舍的方向走去。	彼は宿舎の方向へ歩いて行った。	null	Tā cháo sùshè de fāngxiàng zǒuqu.	\N	gmod	explanation049.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
196	他把信放进抽屉里。	彼は手紙を引き出しの中に入れた。	null	Tā bǎ xìn fàngjìn chōuti li.	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
197	孩子们排着队走出了校门。	子供たちは列になって校門を出た。	null	Háizimen páizhe duì zǒuchūle xiàomén.	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
198	报刊阅读后，请放回原处。	新聞・雑誌は読んだ後は元の場所に戻してください。	null	Bàokān yuèdú hòu, qǐng fànghuí yuánchù.	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
199	他穿过马路，来到书店门前。	彼は通りを渡って本屋の入り口の前に来た。	null	Tā chuānguò mǎlù, láidào shūdiàn ménqián.	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
200	他提起行李走出门去。	彼は荷物を持つと出口を出た。	null	Tā tíqǐ xíngli zǒuchū mén qù.	\N	gmod	explanation050.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
201	电梯坏了，我们走上去吧。	エレベータが壊れたから，歩いて上がりましょう。	null	Diàntī huài le, wǒmen zǒushàngqu ba.	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
202	这些家具没有用了，你搬下楼去吧。	これらの家具は役に立たなくなったから下の階に運んでください。	null	Zhèxiē jiāju méiyou yòng le, nǐ bānxià lóu qù ba.	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
203	上课了，学生们走进教室来。	授業が始まり，学生たちが教室に入って来た。	null	Shàng kè le, xuéshengmen zǒujìn jiàoshì lái.	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
204	那本新小说已经借出去了。	その新しい小説はもう借り出されました。	null	Nà běn xīn xiǎoshuō yǐjing jièchūqu le.	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
355	哪	どれ	null	nǎ	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
205	机票还没取回来吗? 	航空券はまだもらって来てないのですか。	null	Jīpiào hái méi qǔhuílai ma?	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
206	他朝这边走过来了。	彼はこちらのほうへ歩いて来た。	null	Tā cháo zhèbian zǒuguòlai le.	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
207	他一听就站起来了。	彼は聞くとすぐ立ち上がった。	null	Tā yì tīng jiù zhànqǐlai le.	\N	gmod	explanation051.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
208	我的话你听得懂吗?听得懂。	私の話はあなたは聞いてわかりますか。わかります。	null	Wǒ de huà nǐ tīngdedǒng ma? Tīngdedǒng.	\N	gmod	explanation054.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
209	今天下雨，去不了动物园了。	今日は雨で，動物園に行けなくなった。	null	Jīntiān xiàyǔ, qùbuliǎo dòngwùyuán le.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
210	他病了，上不了课了。	彼は病気になって，授業に出られなくなった。	null	Tā bìng le, shàngbuliǎo kè le.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
211	这雨看来大不了。	この雨はどうも激しくはなりっこない。	null	Zhè yǔ kànlái dàbuliǎo.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
212	这件行李轻不了。	この荷物は軽いわけがない。	null	Zhè jiàn xíngli qīngbuliǎo.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
213	这本词典太贵了，买不起。	この辞書は高すぎて，買えない。	null	Zhè běn cídiǎn tài guì le, mǎibuqǐ.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
214	这是杀虫剂，吃不得。	これは殺虫剤だから，食べられません。	null	Zhè shì shāchóngjì, chībude.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
215	坐这趟火车已经来不及了。	この汽車に乗ってももう間に合いません。	null	Zuò zhè tàng huǒchē yǐjing láibují le.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
216	这个礼堂坐得下多少人?	この講堂には何人座れますか。	null	Zhèige lǐtáng zuòdexià duōshao rén?	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
217	他看不起别人，只觉得他自己最了不起。	彼は他人をばかにして，自分だけがえらいと思っている。	null	Tā kànbuqǐ biéren, zhǐ juéde tā zìjǐ zuì liǎobuqǐ.	\N	gmod	explanation055.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
218	他每天睡得很晚。	彼は毎日寝るのがとても遅いです。	null	Tā měitiān shuì de hěn wǎn.	\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
219	他激动得说不出话来。	彼は感激のあまり言葉が出なかった。	null	Tā jīdòng de shuōbuchū huà lái.	\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
220	大风吹得他睁不开眼睛。	強風が吹いてきて彼は目を開けられなかった。	null	Dàfēng chuī de tā zhēngbukāi yǎnjing.	\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
221	他唱得不太好。	彼は歌うのがあまり上手くない。	null	Tā chàng de bú tài hǎo.	\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
222	他跑得快不快?	彼は走るのが速いですか。	null	Tā pǎo de kuài bu kuài?	\N	gmod	explanation056.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
224	我渴得要命，快给我一点儿水喝。	すごくのどが渇いた，水をちょっとください。	null	Wǒ kě de yàomìng, kuài gěi wǒ yìdiǎnr shuǐ hē.	\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
225	那个地方夏天热得不得了。	そこは夏は暑くてたまらない。	null	Nèige dìfang xiàtiān rè de bùdéliǎo.	\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
226	考试结束了，我们高兴极了。	試験が終わったので私たちはうれしくてたまらない。	null	Kǎoshì jiéshù le, wǒmen gāoxìngjí le.	\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
227	累死了。	疲れてくたくただ。	null	Lèisǐ le.	\N	gmod	explanation057.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
228	上海比北京热。	上海は北京より暑い。	null	Shànghǎi bǐ Běijīng rè.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
229	他们班的学生比我们班少两个。	彼らのクラスの学生は私たちのクラスより２名少ない。	null	Tāmen bān de xuésheng bǐ wǒmen bān shǎo liǎng ge.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
230	她家比我家远一点儿。	彼女の家は私の家より少し遠い。	null	Tā jiā bǐ wǒ jiā yuǎn yìdiǎnr.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
231	弟弟比妹妹高得多。	弟は妹よりずっと背が高い。	null	Dìdi bǐ mèimei gāo de duō.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
232	我比她更了解这里的情况。	私は彼女より更にここの状況を知っている。	null	Wǒ bǐ tā gèng liǎojiě zhèli de qíngkuàng.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
233	我去比你来更方便。	私が行くほうがあなたが来るよりももっと都合がいい。	null	Wǒ qù bǐ nǐ lái gèng fāngbiàn.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
234	他的汉语水平比我高。	彼の中国語のレベルは私より高い。	null	Tā de Hànyǔ shuǐpíng bǐ wǒ gāo.	\N	gmod	explanation058.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
235	今天没有昨天冷。	今日は昨日ほど寒くない。	null	Jīntiān méiyou zuótiān lěng.	\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
236	这座楼没有那座楼高。	このビルはあのビルほど高くない。	null	Zhè zuò lóu méiyou nà zuò lóu gāo.	\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
237	姐姐没有弟弟那么爱打球。	お姉さんは弟ほど球技をするのが好きではない。	null	Jiějie méiyou dìdi nàme ài dǎ qiú.	\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
238	小李比你高吧？	李さんはあなたより背が高いでしょう？	null	Xiǎo Lǐ bǐ nǐ gāo ba?	\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
239	他不比我高。我一米七，他也一米七。	彼は私より高いなんてことはないですよ。私は１メートル70センチで，彼も１メートル70センチです。	null	Tā bù bǐ wǒ gāo. Wǒ yì mǐ qī, tā yě yì mǐ qī.	\N	gmod	explanation059.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
240	我的词典跟你的词典一样。	私の辞書はあなたの辞書と同じだ。	null	Wǒ de cídiǎn gēn nǐ de cídiǎn yíyàng.	\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
241	这间屋子跟那间屋子一样大。	この部屋はあの部屋と同じくらい大きい。	null	Zhè jiān wūzi gēn nà jiān wūzi yíyàng dà.	\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
242	橘子跟苹果一样有营养。	ミカンはリンゴと同じくらい栄養がある。	null	Júzi gēn píngguǒ yíyàng yǒu yíngyǎng.	\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
243	南方的城市跟北方的城市不一样。	南方の町は北方の町と違う。	null	Nánfāng de chéngshì gēn běifāng de chéngshì bù yíyàng.	\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
244	他的意见跟你的意见一样不一样?	彼の意見はあなたの意見と同じですか。	null	Tā de yìjiàn gēn nǐ de yìjiàn yíyàng bu yíyàng？	\N	gmod	explanation060.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
245	我哥哥比我高一点儿。	私の兄は私より少し背が高い。	null	Wǒ gēge bǐ wǒ gāo yìdiǎnr.	\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
246	今天有点儿冷，你多穿点儿衣服吧。	今日は少し寒い，あなたは服を少し多めに着なさい。	null	Jīntiān yǒudiǎnr lěng, nǐ duō chuān diǎnr yīfu ba.	\N	gmod	explanation061.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
247	墙上贴着一张中国地图。	壁に中国の地図が１枚貼ってある。	null	Qiáng shang tiēzhe yì zhāng Zhōngguó dìtú.	\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
248	床上躺着一个病人。	ベッドに病人が１人横たわっている。	null	Chuáng shang tǎngzhe yí ge bìngrén.	\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
249	门口停着一辆汽车。	入り口に車が１台止まっている。	null	Ménkǒu tíngzhe yí liàng qìchē.	\N	gmod	explanation062.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
250	我们宿舍来了一个新同学。	私たちの宿舎に新しい同級生が一人やって来た。	null	Wǒmen sùshè láile yí ge xīn tóngxué.	\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
251	大路上走过来两个人。	大通りを二人の人が歩いて来た。	null	Dàlù shang zǒuguòlai liǎng ge rén.	\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
252	我们楼里搬走了一家人。	私たちの棟から１軒引っ越していった。	null	Wǒmen lóu li bānzǒule yì jiā rén.	\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
253	邻居家死了一只猫。	隣で猫が１匹死んだ。	null	Línjū jiā sǐle yì zhī māo.	\N	gmod	explanation063.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
254	妈妈常常叫我打扫屋子。	お母さんはしばしば私に部屋を掃除させる。	null	Māma chángcháng jiào wǒ dǎsǎo wūzi.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
255	他叫我替他寄一封信。	彼は私にかわりに彼のために手紙を投函させる。	null	Tā jiào wǒ tì tā jì yì fēng xìn.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
256	让他去玩儿吧，别管他。	彼を遊ばせてあげなさい，かまわないで。	null	Ràng tā qù wánr ba, bié guǎn tā.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
257	他不让我看他的照片。	彼は私に彼の写真を見せてくれない。	null	Tā bú ràng wǒ kàn tā de zhàopiàn.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
258	你请他帮你复习功课吧。	あなたは彼に勉強の復習を手伝ってもらいなさい。	null	Nǐ qǐng tā bāng nǐ fùxí gōngkè ba.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
259	我们请王先生作报告。	私たちは王さんにお話しをしてもらう。	null	Wǒmen qǐng Wáng xiānsheng zuò bàogào.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
260	工人们要求厂长听一听他们的意见。	労働者たちは工場長に彼らの意見を聞くよう要求した。	null	Gōngrenmen yāoqiú chǎngzhǎng tīng yi ting tāmen de yìjiàn.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
261	医生嘱咐我戒烟。	医者は私に禁煙するよう言いつけた。	null	Yīshēng zhǔfu wǒ jièyān.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
356	这个	これ，この	null	zhège／zhèige	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
262	张老师叫你马上就去。	張先生があなたにすぐ来るよう言っています。	null	Zhāng lǎoshī jiào nǐ mǎshàng jiù qù.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
263	我叫你休息，你怎么还在这儿？	休むように言ったのに，君はどうしてまだここにいるんだ。	null	Wǒ jiào nǐ xiūxi, nǐ zěnme hái zài zhèr?	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
264	明天星期天，我妈让你到我家去玩儿。	明日は日曜日だから，母がうちへ遊びに来るよう言っています。	null	Míngtiān xīngqītiān, wǒ mā rang nǐ dào wǒ jiā qù wánr.	\N	gmod	explanation064.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
265	“给你一百块。”“找你三块。”	「はい，100元です。」「３元のおつりです。」	null	Gěi nǐ yì bǎi kuài. Zhǎo nǐ sān kuài.	\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
266	他送我一本参考书。	彼は私に参考書を１冊くれる。	null	Tā sòng wǒ yì běn cānkǎoshū.	\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
267	李老师教我们汉语。	李先生は私たちに中国語を教える。	null	Lǐ lǎoshī jiāo wǒmen Hànyǔ.	\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
268	我告诉你一个好消息。	私はあなたにいい知らせを伝える。	null	Wǒ gàosu nǐ yí ge hǎo xiāoxi.	\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
269	我想问你一个问题。	私はあなたに一つ質問したいことがある。	null	Wǒ xiǎng wèn nǐ yí ge wèntí.	\N	gmod	explanation065.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
270	来！	来い！	null	Lái!	\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
271	你好好儿休息吧！	しっかり休んでください。	null	Nǐ hǎohāor xiūxi ba!	\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
272	请坐一会儿。	ちょっとおかけください。	null	Qǐng zuò yíhuìr!	\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
273	冷静点儿！	落ち着いて！	null	Lěngjìng diǎnr!	\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
274	别走！	行くな！	null	Bié zǒu!	\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
275	不要相信他！	彼を信用しないで！	null	Bú yào xiāngxìn tā!	\N	gmod	explanation066.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
276	复印机叫人修好了。	コピー機は修理された。	null	Fùyìnjī jiào rén xiūhǎo le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
277	不用的家具让工人搬出去了。	不要な家具が労働者によって運び出された。	null	Bú yòng de jiājù rang gōngrén bānchūqù le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
278	房子被拆掉了。	家は取り壊された。	null	Fángzi bèi chāidiào le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
279	小张被分配在研究所工作。	Xiǎo Zhāng bèi fēnpèi zài yánjiūsuǒ gōngzuò.	null	Xiǎo Zhāng bèi fēnpèi zài yánjiūsuǒ gōngzuò.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
280	他被敌人捆了起来。	彼は敵に縛り上げられた。	null	Tā bèi dírén kǔnleqǐlái.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
281	小偷儿被警察抓住了。	泥棒は警察に捕まえられた。	null	Xiǎotōur bèi jǐngchá zhuāzhù le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
282	桌子上的资料被风刮乱了。	机の上の資料は風に吹かれてばらばらになった。	null	Zhuōzi shang de zīliào bèi fēng guāluàn le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
283	我们都被眼前的景色吸引住了。	私たちは皆目の前の景色に引きつけられた。	null	Wǒmen dōu bèi yǎnqián de jǐngsè xīyǐnzhù le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
284	深夜我们突然被吵闹声惊醒了。	深夜に私たちは突然騒ぎ声で起こされた。	null	Shēnyè wǒmen tūrán bèi chǎonàoshēng jīngxǐng le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[4]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
285	他被大家选为代表了。	彼は皆から代表に選ばれた。	null	Tā bèi dàjiā xuǎnwéi dàibiǎo le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[5]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
286	不被人们理解是很痛苦的。	人々に理解されないのは苦痛である。	null	Bú bèi rénmen lǐjiě shì hěn tòngkǔ de.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
287	他违反纪律,可能被开除了。	彼は規律に違反したので，職を解かれたかもしれない。	null	Tā wéifǎn jìlǜ, kěnéng bèi kāichú le.	\N	gmod	explanation069.xml	/gmod:explanation[1]/gmod:ExplaBlock[6]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
288	你是什么时候来的？我是昨天来的。	あなたはいつ来たのですか。私は昨日来たのです。	null	Nǐ shì shénme shíhou lái de? Wǒ shì zuótiān lái de.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
289	他是从北京来的。	彼は北京から来たのです。	null	Tā shì cóng Běijīng lái de.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
290	我们是坐地铁来的。	私たちは地下鉄に乗って来たのです。	null	Wǒmen shì zuò dìtiě lái de.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
357	那个	あれ，あの，それ，その	null	nàge／nèige	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
291	我是跟朋友一起到中国来的。	私は友人と一緒に中国に来たのです。	null	Wǒ shì gēn péngyou yìqǐ dào Zhōngguó lái de.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
292	我们是在公园照的相。	私たちは公園で写真を撮ったのです。	null	Wǒmen shì zài gōngyuán zhào de xiàng.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
293	我是在学校门口看见他的。	私は学校の正門で彼を見かけたのです。	null	Wǒ shì zài xuéxiào ménkǒu kànjiàn tā de.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
294	这个问题，我们也是很注意的。	この問題は私たちも関心を持っている。	null	Zhèige wèntí, wǒmen yě shì hěn zhùyì de.	\N	gmod	explanation070.xml	/gmod:explanation[1]/gmod:ExplaBlock[3]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
295	虽然我以前看过这本小说，但是主要内容都忘了。	私はこの小説は以前読んだことがあるが，主な内容は忘れてしまった。	null	Suīrán wǒ yǐqián kànguo zhè běn xiǎoshuō, dànshì zhǔyào nèiróng dōu wàng le.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
296	他因为病了，所以昨天没来上课。	彼は病気なったので，昨日は授業に来なかった。	null	Tā yīnwèi bìng le, suǒyǐ zuótiān méi lái shàngkè.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
297	今天晚上你要是有时间，就到我家来玩儿吧。	今晩もし時間があったら，私の家に遊びに来てください。	null	Jīntiān wǎnshang nǐ yàoshi yǒu shíjiān, jiù dào wǒ jiā lái wánr ba.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
298	如果生活上有什么困难，就跟我说一声。	もし生活の上で何か困ったことがあったら，私に声をかけてください。	null	Rúguǒ shēnghuó shang yǒu shénme kùnnan, jiù gēn wǒ shuō yì shēng.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
299	他不但发音好，而且说得也很流利。	彼は発音がいいだけでなく，話すのも流暢だ。	null	Tā búdàn fāyīn hǎo, érqiě shuō de yě hěn liúlì.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
300	只有经常复习，才能巩固学过的知识。	頻繁に復習してはじめて学んだ知識をゆるぎないものにすることができる。	null	Zhǐyǒu jīngcháng fùxí, cái néng gǒnggù xuéguo de zhīshi.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
301	只要有勇气，就一定能够克服困难。	勇気さえあれば必ず困難を克服することができる。	null	Zhǐyào yǒu yǒngqì, jiù yídìng nénggòu kèfú kùnnan.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
302	我们不管做什么工作，都应该认真做好。	私たちは何の仕事をする場合でも真剣にやりとげるべきである。	null	Wǒmen bùguǎn zuò shénme gōngzuò, dōu yīnggāi rènzhēn zuòhǎo.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
303	无论工作怎么忙，他都抽时间来看我。	仕事がどんなに忙しくても，彼は時間を割いて私に会いに来てくれる。	null	Wúlùn gōngzuò zěnme máng, tā dōu chōu shíjiān lái kàn wǒ.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
304	即使明天下雨，我们也要去。	たとえ明日雨が降っても私たちは行かなければならない。	null	Jíshǐ míngtiān xiàyǔ, wǒmen yě yào qù.	\N	gmod	explanation071.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
305	他越着急，越说不出话来。	彼は焦れば焦るほど言葉が出てこなくなった。	null	Tā yuè zháojí, yuè shuōbuchū huà lái.	\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
306	这件事他越思量越不明白。	この件は彼は考えれば考えるほどわからなくなった。	null	Zhè jiàn shì tā yuè sīliang yuè bù míngbai.	\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
307	讨论越深入，道理越清楚。	議論が深まれば深まるほど，道理は明確になる。	null	Tǎolùn yuè shēnrù, dàoli yuè qīngchu.	\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
308	他越来越爱喝酒了。	彼はますます酒を飲むのが好きになった。	null	Tā yuè lái yuè ài hē jiǔ le.	\N	gmod	explanation072.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
309	他一边儿说话，一边儿收拾工具。	彼は話しをしながら道具を片付けている。	null	Tā yìbiānr shuōhuà, yìbiānr shōushi gōngjù.	\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
310	Jì Hànzì de shíhou, kěyǐ yìbiānr niàn, yìbiānr xiě.	漢字を覚えるときは読みながら書くといい。	null		\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
311	孩子们一边儿唱，一边儿跳。	子供たちは歌いながら踊っている。	null	Háizimen yìbiānr chàng, yìbiānr tiào.	\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
312	她喜欢边看电视边织毛衣。	彼女はテレビを見ながらセーターを編むのが好きだ。	null	Tā xǐhuan biān kàn diànshì biān zhī máoyī.	\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
313	他一面听，一面做笔记。	Tā yímiàn tīng, yímiàn zuò bǐjì.	null	Tā yímiàn tīng, yímiàn zuò bǐjì.	\N	gmod	explanation073.xml	/gmod:explanation[1]/gmod:ExplaBlock[2]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
314	工人们一到工地就干了起来。	労働者たちは工事現場に着くとすぐに働き始めた。	null	Gōngrénmen yí dào gōngdì jiù gànle qǐlái.	\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
315	他一想到做饭就头疼。	彼は食事の用意のことを思い出すとうんざりしてしまう。	null	Tā yì xiǎngdào zuò fàn jiù tóu téng.	\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
316	使用说明很清楚，一看就明白。	使用説明ははっきり書いてあって，読めばすぐにわかる。	null	Shǐyòng shuōmíng hěn qīngchu, yí kàn jiù míngbai.	\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
317	他一和女孩子说话，脸就红。	彼は女の子と話しをするとすぐに顔が赤くなる。	null	Tā yì hé nǚháizi shuō huà, liǎn jiù hóng.	\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
318	一到那儿，天就冷了。	そこに着くとすぐに寒くなった。	null	Yí dào nàr, tiān jiù lěng le.	\N	gmod	explanation074.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
319	你喜欢哪个，我给你哪个。	あなたの好みのものをどれでもあげます。	null	Nǐ xǐhuan nǎge, wǒ gěi nǐ nǎge.	\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
320	你愿意怎么去就怎么去。	あなたが行きたい方法で行きなさい。	null	Nǐ yuànyi zěnme qù jiù zěnme qù.	\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
321	这个演员演什么像什么。	この俳優は何を演じても似ている。	null	Zhèige yǎnyuán yǎn shénme xiàng shénme.	\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
322	哪里有困难，他就出现在哪里。	困難がある所にはどこでも彼は現れる。	null	Nǎli yǒu kùnnan, tā jiù chūxiàn zài nǎli.	\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
323	能干多少干多少，不要勉强。	できるだけをやりなさい，無理をしないように。	null	Néng gàn duōshao gàn duōshao, bú yào miǎnqiǎng.	\N	gmod	explanation075.xml	/gmod:explanation[1]/gmod:ExplaBlock[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
324	他来。	彼は来ます。	null	Tā lái.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
325	我们去。	私たちは行きます」。	null	Wǒmen qù.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
326	她学习英语。	彼女は英語を勉強します。	null	Tā xuéxī Hànyǔ.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
327	他们看电影。	彼らは映画を見ます。	null	Tāmen kàn diànyǐng.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
328	我不知道。	私は知りません。	null	Wǒ bù zhīdào.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
329	她不抽烟。	彼女はタバコを吸いません。	null	Tā bù chōu yān.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
330	我也去学校。	私も学校へ行きます。	null	Wǒ yě qù xuéxiào.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
331	他也不喝啤酒。	彼もビールを飲みません。	null	Tā yě bù hē píjiǔ.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
332	我们都学习语法。	私たちはみな文法を勉強します。	null	Wǒmen dōu xuéxí yǔfǎ.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
333	他们也都不吃面包。	彼らもみなパンを食べません。	null	Tāmen yě dōu bù chī miànbāo.	\N	gmod	instances001.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
334	他来吗?	彼は来ますか。	null	Tā lái ma?	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
335	你们吃面包吗?	あなたたちはパンを食べますか。	null	Nǐmen chī miànbāo ma?	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
336	你不知道吗?	あなたは知らないのですか。	null	Nǐ bù zhīdào ma?	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
337	他也买书吗?	彼も本を買いますか。	null	Tā yě mǎi shū ma?	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
338	你们都去吗?	あなたたちはみな行きますか。	null	Nǐmen dōu qù ma?	\N	gmod	instances002.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
339	我	私	null	wǒ	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
340	你	あなた	null	nǐ	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
341	您	あなた（敬語）	null	nín	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
342	他 / 她	彼 / 彼女	null	tā	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
343	我们	私たち	null	wǒmen	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
344	你们	あなたたち	null	nǐmen	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
345	他们 / 她们	彼ら / 彼女たち	null	tāmen	\N	gmod	instances003.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
346	我是学生。	私は学生です。	null	Wǒ shì xuésheng.	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
347	他也是留学生。	彼も留学生です。	null	Tā yě shì liúxuéshēng.	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
348	他们都是老师。	彼らはみんな先生です。	null	Tāmen dōu shì lǎoshī.	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
349	他不是美国人。	彼はアメリカ人ではありません。	null	Tā bú shì Měiguórén.	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
350	她也不是老师。	彼女も先生ではありません。	null	Tā yě bú shì lǎoshī.	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
351	她是学生吗?	彼は学生ですか。	null	Tā shì xuésheng ma?	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
352	他也是日本人吗?	彼も日本人ですか。	null	Tā yě shì Rìběnrén ma?	\N	gmod	instances004.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
358	哪个	どれ，どの	null	nǎge／něige	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
359	这些	これら（の）	null	zhèxiē／zhèixiē	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
360	那些	あれら（の），それら（の）	null	nàxiē／nèixiē	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
361	哪些	どれら（の）	null	nǎxiē／něixiē	\N	gmod	instances005.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
362	老师的词典	先生の辞書	null	lǎoshī de cídiǎn	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
363	图书馆的杂志	図書館の雑誌	null	túshūguǎn de zázhì	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
364	我的大衣	私のコート	null	wǒ de dàyī	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
365	中文杂志	中国語雑誌	null	Zhōngwén zázhì	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
366	体育老师	体育教師	null	tǐyù lǎoshī	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
367	我爸爸	私のお父さん	null	wǒ bàba	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
368	你家 	あなたの家	null	nǐ jiā	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
369	你们班	あなたたちのクラス	null	nǐmen bān	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
370	我们学校	私たちの学校	null	wǒmen xuéxiào	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
371	这是他的笔吗?	これは彼のペンですか。	null	Zhè shì tā de bǐ ma?	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
372	不，这是我的。	いいえ，これは私のです。	null	Bù, zhè shì wǒ de.	\N	gmod	instances006.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
373	他来不来?	彼は来ますか。	null	Tā lái bu lái?	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
374	你哥哥工作不工作?	あなたのお兄さんは働いていますか。	null	Nǐ gēge gōngzuò bù gōngzuò?	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
375	他是不是留学生?	彼は留学生ですか。	null	Tā shì bu shì liúxuéshēng? 	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
376	你喝不喝啤酒?	あなたはビールを飲みますか。	null	Nǐ hē bu hē píjiǔ? 	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
377	你喝啤酒不喝?	あなたはビールを飲みますか。	null	Nǐ hē píjiǔ bù hē?	\N	gmod	instances007.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
378	你们吃什么?	あなたたちは何を食べますか。	null	Nǐmen chī shénme?	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
379	她是谁?	彼女は誰ですか。	null	Tā shì shéi?	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
380	你去哪儿?	あなたはどこに行きますか。	null	Nǐ qù nǎr?	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
381	你什么时候回来?	あなたはいつ帰って来ますか。	null	Nǐ shénme shíhou huílai?	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
382	他的病怎么样?	彼の病気はいかがですか。	null	Tā de bìng zěnmeyàng?	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
383	你要哪个?	あなたはどれが欲しいですか。	null	Nǐ yào něige?	\N	gmod	instances008.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
384	到火车站怎么走?	駅へはどういけばいいですか。	null	Dào huǒchēzhàn zěnme zǒu?	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
385	这个汉字怎么念? 	この漢字はどう読むのですか。	null	Zhèige Hànzì zěnme niàn?	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
386	她怎么还不起来?	彼女はなぜまだ起きないのですか。	null	Tā zěnme hái bù qǐlai?	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
387	你怎么来了? 	あなたはなぜ来たのですか。	null	Nǐ zěnme lái le?	\N	gmod	instances009.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
388	是你去，还是我去?	あなたが行きますか，それとも私が行きますか。	null	Shì nǐ qù, háishi wǒ qù?	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
389	你今天去，还是明天去?	あなたは今日行きますか，それとも明日行きますか。	null	Nǐ jīntiān qù, háishi míngtiān qù?	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
390	你喜欢听音乐还是喜欢看电影? 	あなたは音楽を聴くのが好きですか，それとも映画を見るのが好きですか。	null	Nǐ xǐhuan tīng yīnyuè háishi xǐhuan kàn diànyǐng?	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
391	她是医生还是护士? 	彼女は医者ですか，それとも看護婦ですか。	null	Tā shì yīshēng háishi hùshi?	\N	gmod	instances010.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
392	我的自行车呢?	私の自転車は？	null	Wǒ de zìxíngchē ne?	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
393	老李呢?我怎么没看见他?	李さんは？なんで姿を見かけなかったんだろう。	null	Lǎo Lǐ ne? Wǒ zěnme méi kànjian tā?	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
394	我喜欢吃上海菜，你呢?	私は上海料理が好きですが，あなたは？	null	Wǒ xǐhuan chī Shànghǎi cài, nǐ ne?	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
395	我去北京。你呢?	私は北京に行きます。あなたは？	null	Wǒ qù Běijīng. Nǐ ne?	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
396	你上午值班，下午呢?	あなたは午前は当直ですが，午後は？	null	你上午值班，下午呢?	\N	gmod	instances011.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
397	你是郭老师吧?	あなたは郭先生ですよね？	null	Nǐ shì Guō lǎoshī ba?	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
398	这是你的书吧?	これはあなたの本でしょう？	null	Zhè shì nǐ de shū ba?	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
399	我们明天出发吧。	私たちは明日出発しましょう。	null	Wǒmen míngtiān chūfā ba.	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
400	你们里边儿坐吧。	中でかけてください。	null	Nǐmen lǐbianr zuò ba.	\N	gmod	instances012.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
401	一，二，三，四，五，六，七，八，九，十	1,2,3,4,5,6,7,8,9,10	null	yī,èr,sān,sì,wǔ,liù,qī,bā,jiǔ,shí	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
402	十一，十八，四十三，六十五，九十九	11,18,43,65,99	null	shíyī,shíbā,sìshisān,liùshiwǔ,jiǔshijiǔ	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
403	一百，一百零一，一百一，一百一十一，二百	100,101,110,111,200	null	yìbǎi,yìbǎi líng yī,yìbǎi yī,yìbǎi yīshiyī,èrbǎi	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
404	一千，一万	1000,10000	null	yìqiān,yíwàn	\N	gmod	instances013.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
405	你有几个孩子?	あなたは子供が何人いますか。	null	Nǐ yǒu jǐ ge háizi?	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
406	那个幼儿园有多少孩子?	あの幼稚園は子供が何人いますか。	null	Nèige yòu’éryuán yǒu duōshao háizi?	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
407	几个字?	何字ですか？	null	Jǐ ge zì?	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
408	多少(个)字?	何字ですか？	null	Duōshao (ge) zì?	\N	gmod	instances014.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
409	一九九七年	1997年	null	yī jiǔ jiǔ qī nián	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
410	十一月二十三号	11月23日	null	shíyīyuè èrshisān hào	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
411	星期一	月曜日	null	xīngqīyī	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
412	星期二	火曜日	null	xīngqī’èr	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
413	星期三	水曜日	null	xīngqīsān	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
414	星期四	木曜日	null	xīngqīsì	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
415	星期五	金曜日	null	xīngqīwǔ	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
416	星期六	土曜日	null	xīngqīliù	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
418	明年二○○五年。	来年は2005年です。	null	Míngnián èr líng líng wǔ nián.	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
419	今天四月十七号。	今日は４月１７日です。	null	Jīntiān sìyuè shíqī hào.	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
420	明天星期天。	明日は日曜日です。	null	Míngtiān xīngqītiān.	\N	gmod	instances015.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[12]	\N	\N	1
421	两点(钟)	2時	null	liǎng diǎn (zhōng)	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
422	十点十三分	10時13分	null	shí diǎn shísān fēn	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
423	三点十五分 / 三点一刻	3時15分	null	sān diǎn shíwǔ fēn / sān diǎn yí kè	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
424	八点三十分 / 八点半 	8時30分 / 8時半	null	bā diǎn sānshí fēn / bā diǎn bàn	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
425	十一点四十五分 / 十一点三刻 	11時45分	null	shíyī diǎn sìshiwǔ fēn / shíyī diǎn sān kè	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
426	九点五十五分 / 差五分十点	9時55分 / 10時5分前	null	jiǔ diǎn wǔshiwǔ fēn / chà wǔ fēn shí diǎn	\N	gmod	instances016.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
427	哥哥十八岁，我十五岁。	兄は18歳で，私は15歳です。	null	Gēge shíbā suì, wǒ shíwǔ suì.	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
428	你多大(了)?	おいくつですか	null	Nǐ duō dà (le)?	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
429	您多大岁数(了)?	おいくつでいらっしゃいますか	null	Nín duō dà suìshu (le)?	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
430	您多大年纪(了)?	おいくつでいらっしゃいますか	null	Nín duō dà niánjì (le)?	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
431	你是哪一年生的?	あなたは何年生まれですか。	null	Nǐ shì nǎ yì nián shēng de?	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
432	我是一九六五年生的。	私は1965年生まれです。	null	Wǒ shì yī jiǔ liù wǔ nián shēng de.	\N	gmod	instances017.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
433	三十五块五毛	35元5角	null	sānshiwǔ kuài wǔ máo	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
434	七块零五分	7元5分	null	qī kuài líng wǔ fēn	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
435	这本书八十块钱。	この本は80元です。	null	Zhè běn shū bāshí kuài qián.	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
436	这本书不是八十块钱。	この本は80元ではありません。	null	Zhè běn shū bú shì bāshí kuài qián.	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
437	这个多少钱?	これはいくらですか。	null	Zhèige duōshao qián?	\N	gmod	instances018.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
438	我有数码相机。	私はデジカメを持っている。	null	Wǒ yǒu shùmǎ xiàngjī.	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
439	他有很多中文书。	彼は中国語の本をたくさん持っています。	null	Tā yǒu hěn duō Zhōngwén shū.	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
440	我没有电脑。	私はパソコンを持っていません。	null	Wǒ méi yǒu diànnǎo.	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
441	你现在有时间吗?	あなたは今時間がありますか。	null	Nǐ xiànzài yǒu shíjiān ma?	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
442	你现在有没有时间?	あなたは今時間がありますか。	null	Nǐ xiànzài yǒu méi yǒu shíjiān?	\N	gmod	instances019.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
443	一个鸡蛋	１個の卵	null	yí ge jīdàn	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
444	我家前面有两条河。	私の家の前には２本の川がある。	null	liǎng tiáo hé	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
445	三本杂志	３冊の雑誌	null	sān běn zázhì	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
446	这本书	この本	null	zhè běn shū	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
447	那张票	あのチケット	null	nà zhāng piào	\N	gmod	instances020.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
448	墙上有一张地图。	壁に地図が１枚あります。	null	Qiáng shang yǒu yì zhāng dìtú.	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
449	桌子上有一本词典。	机の上に辞書が１冊あります。	null	Zhuōzi shang yǒu yì běn cídiǎn.	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
450	书架上有很多书。	書棚に本がたくさんあります。	null	Shūjià shang yǒu hěn duō shū.	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
451	学校旁边有一个邮局。	学校のそばに郵便局があります。	null	Xuéxiào pángbiānr yǒu yí ge yóujú.	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
452	屋子里没有人。	部屋には人はいません。	null	Wūzi li méi yǒu rén.	\N	gmod	instances021.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
453	他在屋子里。	彼は部屋にいます。	null	Tā zài wūzi li.	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
454	那本词典在书架上。	あの辞書は書棚の上にあります。	null	Nèi běn cídiǎn zài shūjià shang.	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
455	钥匙在抽屉里。	キーは引き出しの中にあります。	null	Yàoshi zài chōuti li.	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
456	张老师在吗?	張先生はいらっしゃいますか。	null	Zhāng lǎoshī zài ma? 	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
457	图书馆不在这儿，在那座楼后边儿。	図書館はここにはありません。あの建物の後ろにあります。	null	Túshūguǎn bú zài zhèr, zài nèi zuò lóu hòubianr.	\N	gmod	instances022.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
458	里边儿没有人。	中には人はいません。	null	Lǐbianr méi yǒu rén.	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
459	中文杂志在上边儿，外文杂志在下边儿。	中国語の雑誌は上にあり，外国語の雑誌は下にあります。	null	Zhōngwén zázhì zài shàngbianr, wàiwén zázhì zài xiàbianr.	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
460	窗户前边儿有一盆花。	窓の前に鉢植えの花が一つあります。	null	Chuānghu qiánbianr yǒu yì pén huā.	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
461	你的钥匙在桌子上。	あなたのキーはテーブルの上にあります。	null	Nǐ de yàoshi zài zhuōzi shang.	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
462	可乐在冰箱里。	コーラは冷蔵庫の中にあります。	null	Kělè zài bīngxiāng li.	\N	gmod	instances023.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
463	这儿，这里	ここ	null	zhèr，zhèli	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
464	那儿，那里	あそこ	null	nàr，nàli	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
465	哪儿，哪里	どこ	null	nǎr，nǎli	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
466	我的本子在老师那儿。	私のノートは先生のところにあります。	null	Wǒ de běnzi zài lǎoshī nàr.	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
467	我这里没有资料。	私のところには資料がありません。	null	Wǒ zhèli méi yǒu zīliào.	\N	gmod	instances024.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
468	这间屋子非常干净。	この部屋はとてもきれいです。	null	Zhèi jiān wūzi fēicháng gānjìng.	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
469	这个办法比较好。	この方法は比較的よいです。	null	Zhèige bànfǎ bǐjiào hǎo.	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
470	今天很热。	今日は暑いです。	null	Jīntiān hěn rè.	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
471	今天不热。	今日は暑くありません。	null	Jīntiān bú rè.	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
472	汉语难吗?	中国語は難しいですか。	null	Hànyǔ nán ma?	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
473	汉语难不难?	中国語は難しいですか。	null	Hànyǔ nán bu nán?	\N	gmod	instances025.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
474	新书	新しい本	null	xīn shū	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
475	脏衣服	汚れた服	null	zāng yīfu	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
476	老实人	誠実な人	null	lǎoshi rén	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
477	很漂亮的衣服	とてもきれいな服	null	hěn piàoliang de yīfu	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
478	厚厚的地毯	ぶ厚いじゅうたん	null	hòuhòu de dìtǎn	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
479	非常聪明的动物	非常に賢い動物	null	fēicháng cōngming de dòngwù	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
480	来的人	来る人，来た人	null	lái de rén	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
481	讨论的题目	議論のテーマ	null	tǎolùn de tímù	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
482	我要的书	私のほしい本	null	wǒ yào de shū	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
483	个子高的学生	背の高い学生	null	gèzi gāo de xuésheng	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
484	很多书	たくさんの本	null	hěn duō shū	\N	gmod	instances026.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
486	大胆地想	大胆に考える	null	dàdǎn de xiǎng	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
487	细心地算	注意深く計算する	null	xìxīn de suàn	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
488	感动地说	感動して言う	null	gǎndòng de shuō	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
489	怀疑地说	疑わしそうに言う	null	huáiyí de shuō	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
490	很顺利地办好了	順調におこなった	null	hěn shùnlì de bànhǎo le	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
491	手忙脚乱地解开了包袱	慌てて包みを解いた	null	shǒu máng jiǎo luàn de jiěkāile bāofu	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
492	彻底（地）解决	徹底的に解決する	null	chèdǐ (de) jiějué	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
493	仔细（地）看了一下	注意深く見た	null	zǐxì (de) kànle yíxià	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
494	好好儿（地）工作	しっかり仕事をする	null	hǎohāor(de)gōngzuò	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
495	热热闹闹（地）过个生日	にぎやかに誕生日を祝う	null	rèrènàonào de guò ge shēngri	\N	gmod	instances027.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
496	胖胖的人	太った人	null	pàngpàngde rén	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
497	老老实实的工人	誠実な労働者	null	lǎolaoshíshíde gōngrén	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
498	屋子里静悄悄的。	部屋はひっそりとしています。	null	Wūzi li jìngqiāoqiāode.	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
499	台布雪白雪白的。	テーブルクロスは真っ白です。	null	Táibù xuěbáixuěbáide.	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
500	慢慢儿地看	ゆっくり見る	null	mànmānrde kàn	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
501	好好儿介绍介绍	しっかり紹介する	null	hǎohāor jièshàojieshao	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
502	走得远远的	遠くまで行く	null	zǒu de yuǎnyuǎnde	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
503	写得清清楚楚的	はっきりと書いてある	null	xiě de qīngqingchǔchǔde	\N	gmod	instances028.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
504	我在图书馆看书。	私は図書館で本を読みます。	null	Wǒ zài túshūguǎn kàn shū.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
505	我家离火车站不远。	私の家は駅から遠くない。	null	Wǒ jiā lí huǒchēzhàn bù yuǎn.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
506	他从中国回来了。	彼は中国から帰ってきた。	null	Tā cóng Zhōngguó huílai le.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
507	他对这件事有意见。	彼はこの件に不満がある。	null	Tā duì zhè jiàn shì yǒu yìjian.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
508	你跟他一起去吧。	あなたは彼と一緒に行きなさいよ。	null	Nǐ gēn tā yìqǐ qù ba.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
509	一直往南走吧。	まっすぐ南へ行きなさい。	null	Yìzhí wǎng nán zǒu ba.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
510	大家都替你高兴。	みんな君のために喜んでいる。	null	Dàjiā dōu tì nǐ gāoxìng.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
511	她给我介绍了这儿的情况。	彼女は私にここの状況を紹介してくれた。	null	Tā gěi wǒ jièshàole zhèr de qíngkuàng.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
799	对，	ええ，		Duì,	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
512	大门朝南开。	正門は南向きです。	null	Dàmén cháo nán kāi.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
513	列车向东奔驰。	列車が東へ向かって疾走する。	null	Lièchē xiàng dōng bēnchí.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
514	他为这本书写了一篇序。	彼はこの本のために序文を書いた。	null	Tā wèi zhè běn shū xiěle yì piān xù.	\N	gmod	instances029.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[11]	\N	\N	1
515	除了他以外，别人都不知道这件事。	彼を除いて，他の人はみなこのことを知らない。	null	Chúle tā yǐwài, biéren dōu bù zhīdào zhè jiàn shì.	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
516	除了他喝酒以外，别的人都喝可乐。	彼がお酒を飲むのを除いて，他の人はみなコーラを飲む。	null	Chúle tā hē jiǔ yǐwài, bié de rén dōu hē kělè.	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
517	他除了喜欢滑雪以外，还喜欢滑冰。	彼はスキーが好きなほかにも，さらにスケートも好きだ。	null	Tā chúle xǐhuan huáxuě yǐwài, hái xǐhuan huábīng.	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
518	我除了学习汉语以外，还学习法语。	私は中国語を勉強している以外にもさらにフランス語も勉強している。	null	Wǒ chúle xuéxí Hànyǔ yǐwài, hái xuéxí Fǎyǔ.	\N	gmod	instances030.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
519	连五岁的孩子都懂得这个道理。	５歳の子供でさえこの道理はわかる。	null	Lián wǔ suì de háizi dōu dǒngde zhèige dàoli.	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
520	天上没有月光，连星星也没有。	空には月の光がなく，星さえもない。	null	Tiān shang méi yǒu yuèguāng, lián xīngxing yě méi yǒu.	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
521	这么大的事，你怎么连问都不问?	こんなに大きなことなのに，あなたはどうして尋ねもしないのですか。	null	Zhème dà de shì, nǐ zěnme lián wèn dōu bú wèn?	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
522	到这儿以后，我连一天也没休息。	ここに来てから，私は１日も休んでいない。	null	Dào zhèr yǐhòu, wǒ lián yì tiān yě méi xiūxi.	\N	gmod	instances031.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
523	时间还早，一个人都没来。	時間がまだ早く，一人も来ていない。	null	Shíjiān hái zǎo, yí ge rén dōu méi lái.	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
524	那个地方我一次也没去过。	その場所は私は一度も行ったことがない。	null	Nèige dìfang wǒ yí cì yě méi qùguo.	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
525	今天一点儿也不冷。	今日はまったく寒くない。	null	Jīntiān yìdiǎnr yě bù lěng.	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
526	我们一点儿都不累。	私たちは少しも疲れていない。	null	Wǒmen yìdiǎnr dōu bú lèi.	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
527	我什么也听不见。	私は何も聞こえません。	null	Wǒ shénme yě tīngbujiàn.	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
528	这件事谁都不知道。	このことは誰も知らない。	null	Zhè jiàn shì shéi dōu bù zhīdào.	\N	gmod	instances032.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
529	我买瓶汽水喝。	私はサイダーを１本買って飲みます。	null	Wǒ mǎi píng qìshuǐ hē.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
530	我去机场接朋友。	私は空港に友達を迎えに行きます。	null	Wǒ qù jīchǎng jiē péngyou.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
531	我去邮局买邮票。	私は郵便局に切手を買いに行きます。	null	Wǒ qù yóujú mǎi yóupiào.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
532	我骑自行车去。	私は自転車に乗って行きます。	null	Wǒ qí zìxíngchē qù.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
533	他坐飞机去北京。	彼は飛行機に乗って北京に行きます。	null	Tā zuò fēijī qù Běijīng.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
534	我打电话告诉他。	私は電話で彼に言います。	null	Wǒ dǎ diànhuà gàosu tā.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
535	他紧握朋友的手不放。	彼は友人の手をしっかりと握って放しませんでした。	null	Tā jǐn wò péngyou de shǒu bú fàng.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
536	我有件事跟你商量。	私はあなたに相談することがあります。	null	Wǒ yǒu jiàn shì gēn nǐ shāngliang.	\N	gmod	instances033.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
537	他的病好了，能走路了。	彼は病気が治って，歩けるようになった。	null	Tā de bìng hǎo le, néng zǒu lù le.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
538	九点以前他能到这儿。	９時以前に彼はここに来ることができる。	null	Jiǔ diǎn yǐqián tā néng dào zhèr.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
539	这间屋子可以放三张床。	この部屋はベッドを３つ置くことができる。	null	Zhè jiān wūzi kěyǐ fàng sān zhāng chuáng.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
540	这次考试，可以带词典。	今回の試験は辞書を持ち込んでよい。	null	Zhè cì kǎoshì, kěyǐ dài cídiǎn.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
541	这本书写得不错，你可以看看。	この本は良く書かれているから，ちょっと読んでみたらどうですか。	null	Zhè běn shū xiě de búcuò, nǐ kěyǐ kànkan.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
1147	好，	分かりました。		Hǎo,	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
542	他会说汉语。	彼は中国語を話せます。	null	Tā huì shuō Hànyǔ.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
543	那件事别人是不会知道的。	その件は他の人は知っているはずがない。	null	Nà jiàn shì biéren shì bú huì zhīdao de.	\N	gmod	instances034.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
544	我想看电视。	私はテレビが見たい。	null	Wǒ xiǎng kàn diànshì.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
545	我要喝咖啡。	私はコーヒーが飲みたい。	null	Wǒ yào hē kāfēi.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
546	衣服脏了，要洗。	服が汚れたので，洗わなければならない。	null	Yīfu zāng le, yào xǐ.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
547	他不肯来。	彼は来ようとしない。	null	Tā bù kěn lái.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
548	我一个人不敢去旅行。	私は一人では旅行に行く勇気がない。	null	Wǒ yí ge rén bù gǎn qù lǚxíng.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
549	我们应该好好儿学习。	私たちはちゃんと勉強すべきだ。	null	Wǒmen yīnggāi hǎohāor xuéxí.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
550	我明天还得来一趟。	私はまた明日一度来なければならない。	null	Wǒ míngtiān hái děi lái yí tàng.	\N	gmod	instances035.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
551	他病了，我们去看看他吧。	彼は病気になったので，彼をちょっと見舞いに行きましょう。	null	Tā bìng le, wǒmen qù kànkan ba.	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
552	这个问题需要考虑考虑。	この問題はちょっと考えてみる必要がある。	null	Zhèige wèntí xūyào kǎolǜkaolü.	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
553	她想了想说:“还是你去吧!”	彼女はちょっと考えると「やはりあなたが行ってよ」と言った。	null	Tā xiǎnglexiang shuō:“Háishi nǐ qù ba!”	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
554	这个收音机坏了，不信你听听。	このラジオは壊れた，信じないならちょっと聴いてみてごらん。	null	Zhèige shōuyīnjī huài le, bú xìn nǐ tīngting.	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
555	我的钥匙不见了，你帮我找找!	私の鍵がなくなりました，探すのを手伝ってくれませんか。	null	 Wǒ de yàoshi bú jiàn le, nǐ bāng wǒ zhǎozhao!	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
556	王老师，您休息休息吧!	王先生，ちょっと休まれればいかがですか。	null	Wáng lǎoshī, nín xiūxixiuxi ba!	\N	gmod	instances036.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
557	那个问题，我们讨论过两次，还准备再讨论一次。	その問題は，私たちは２回議論したことがあるが，まだもう一度議論する予定である。	null	Nèige wèntí, wǒmen tǎolùnguo liǎng cì, hái zhǔnbèi zài tǎolùn yí cì.	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
558	我看了一遍展览会。	私は展覧会を１遍見ました。	null	Wǒ kànle yí biàn zhǎnlǎnhuì.	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
559	我去过上海一次。	私は上海に一度行ったことがあります。	null	Wǒ qùguo Shànghǎi yí cì.	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
560	我见过他一次。	私は彼に一度会ったことがあります。	null	Wǒ jiànguo tā yí cì.	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
561	他打了我一拳。	彼は私を一発ガンとなぐった。	null	Tā dǎle wǒ yì quán.	\N	gmod	instances037.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
562	我们坐车坐了四十多分钟。	私たちは車に40分あまり乗りました。	null	Wǒmen zuò chē zuòle sìshí duō fēn zhōng.	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
563	昨天晚上他看了两个小时电视。	昨晩彼はテレビを２時間見ました。	null	Zuótiān wǎnshang tā kànle liǎng ge xiǎoshí diànshì.	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
564	你等一会儿小张吧。	あなたは張さんをしばらく待ったらどうですか。	null	Nǐ děng yíhuìr Xiǎo Zhāng ba.	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
565	我找了他一个多小时。	私は彼を１時間あまり探しました。	null	Wǒ zhǎole tā yí ge duō xiǎoshí.	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
566	他毕业三年了。	彼は卒業して３年になります。	null	Tā bìyè sān nián le.	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
567	他来日本两年了。	彼は日本に来て２年になります。	null	Tā lái Rìběn liǎng nián le.	\N	gmod	instances038.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
568	我去过北京。	私は北京に行ったことがあります。	null	Wǒ qùguo Běijīng.	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
569	他曾经学过法语。	彼はかつてフランス語を学んだことがある。	null	Tā céngjīng xuéguo Fǎyǔ.	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
570	这本小说我没看过。	この小説は私は読んだことがない。	null	Zhè běn xiǎoshuō wǒ méi kànguo.	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
571	我从来没学过法语。	私はこれまでフランス語を学んだことはない。	null	Wǒ cónglái méi xuéguo Fǎyǔ.	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
572	你爬过那座山吗? 	あなたはあの山に登ったことがありますか。	null	Nǐ páguo nà zuò shān ma?	\N	gmod	instances039.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
842	再见！	さようなら	さよならを言う	Zàijiàn!	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
573	这本书我看过了，你拿走吧。	この本は私は読み終わりました，持って行ってください。	null	Zhè běn shū wǒ kànguo le, nǐ názǒu ba.	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
574	行李检查过了，没问题。	荷物は検査し終わりました，問題はありませんでした。	null	Xíngli jiǎncháguo le, méi wèntí.	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
575	明天你吃过晚饭来一趟。	明日夕食が済んだら来てください。	null	Míngtiān nǐ chīguò wǎnfàn lái yí tàng.	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
576	午饭你吃过了吗? 还没吃呢。	お昼は済ませましたか。まだです。	null	Wǔfàn nǐ chīguo le ma? Hái méi chī ne.	\N	gmod	instances040.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
577	我昨天买了一本词典。	私は昨日辞書を１冊買いました。	null	Wǒ zuótiān mǎile yì běn cídiǎn.	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
578	上星期六我们看了一个外国电影。	先週の土曜日私たちは外国映画を見ました。	null	Shàng xīngqīliù wǒmen kànle yí ge wàiguó diànyǐng.	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
579	我回家后给他写了一封信。	私は家に帰ってから彼に手紙を一通書きました。	null	Wǒ huí jiā hòu gěi tā xiěle yì fēng xìn.	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
580	明天下了课，我去找你。	明日授業が終わったら私はあなたを訪ねに行きます。	null	Míngtiān xiàle kè, wǒ qù zhǎo nǐ.	\N	gmod	instances041.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
581	春天到了，天气暖和了。	春になった，気候が暖かくなった。	null	Chūntiān dào le, tiānqì nuǎnhuo le.	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
582	小陈病了。	陳さんは病気になった。	null	Xiǎo Chén bìng le.	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
583	已经十点了，你快睡觉吧。	もう10時だ，あなたは早く寝なさいよ。	null	Yǐjing shí diǎn le, nǐ kuài shuìjiào ba.	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
584	她又想去了。	彼女はまた行きたくなった。	null	Tā yòu xiǎng qù le.	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
585	我明天不去动物园了。	私は明日動物園に行かないことにした。	null	Wǒ míngtiān bú qù dòngwùyuán le.	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
586	昨天下午你去商店了没有?	昨日の午後あなたは店に行きましたか。	null	Zuótiān xiàwǔ nǐ qù shāngdiàn le méiyou?	\N	gmod	instances042.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
587	我学汉语学了两年。	私は中国語を２年間勉強しました。	null	Wǒ xué Hànyǔ xuéle liǎng nián.	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
588	我学汉语学了两年了。	私は中国語を２年間勉強しています。	null	Wǒ xué Hànyǔ xuéle liǎng nián le.	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
589	昨天，我翻译了五个句子。	昨日，私は文を五つ訳しました。	null	Zuótiān, wǒ fānyìle wǔ ge jùzi.	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
590	我翻译了五个句子了，现在要翻译下边的。	私は文を五つ訳したところです。今から次のを訳します。	null	Wǒ fānyìle wǔ ge jùzi le, xiànzài yào fānyì xiàbian de.	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
591	这本书我看了三天了，还得两天才能看完。	この本は私は３日間読んできたところだ。もうあと２日かければ読み終わることができる。	null	Zhè běn shū wǒ kànle sān tiān le, hái děi liǎng tiān cái néng kànwán.	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
592	这本书我看了三天了，不想看下去了。	この本は私は３日間読んできたところだが，もう読み続けたくなくなった。	null	Zhè běn shū wǒ kànle sān tiān le, bù xiǎng kànxiàqu le.	\N	gmod	instances043.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
593	火车快要到站了。	汽車がもうすぐ駅に到着します。	null	Huǒchē kuài yào dào zhàn le.	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
594	李老师快回国了。	李先生はもうすぐ帰国されます。	null	Lǐ lǎoshī kuài huí guó le.	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
595	电影要开始了，我们进去吧。	映画がもうすぐ始まります，入りましょう。	null	Diànyǐng yào kāishǐ le, wǒmen jìnqu ba.	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
596	四年的大学生活就要结束了。	4年間の大学生活がもうすぐ終わります。	null	Sì nián de dàxué shēnghuó jiù yào jiéshù le.	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
597	我们下星期就要考试了。	私たちは来週にはもう試験があります。	null	Wǒmen xià xīngqī jiù yào kǎoshì le.	\N	gmod	instances044.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
598	他们在开会呢。	彼らは会議中です。	null	Tāmen zài kāi huì ne.	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
599	他正钓鱼呢。	彼はちょうど魚釣りをしているところです。	null	Tā zhèng diào yú ne.	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
600	李老师正在给同学们上课。	李先生はちょうど学生たちに授業をしているところです。	null	Lǐ lǎoshī zhèngzài gěi tóngxuémen shàng kè.	\N	gmod	instances045.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
603	我去的时候，发现门开着。	私が行ったとき，ドアが開いているのに気づきました。	null	Wǒ qù de shíhou, fāxiàn mén kāizhe.	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
664	他唱得不太好。	彼は歌うのがあまり上手くない。	null	Tā chàng de bú tài hǎo.	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
604	房间里没有人，门都锁着呢。	部屋には人はいません，ドアはみな鍵がかかっています。	null	Fángjiān li méi yǒu rén, mén dōu suǒzhe ne.	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
605	今天她穿着一件很好看的衬衫。	今日は彼女はきれいなブラウスを着ています。	null	Jīntiān tā chuānzhe yí jiàn hěn hǎokàn de chènshān.	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
606	躺着看书对眼睛不好。	寝転がって本を読むのは目によくありません。	null	Tǎngzhe kàn shū duì yǎnjing bù hǎo.	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
607	桌子上放着一本词典。	机に辞書が１冊置いてあります。	null	Zhuōzi shang fàngzhe yì běn cídiǎn.	\N	gmod	instances046.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
608	我们都走累了，坐下来歇一会儿吧。	私たち歩いて疲れたから座って少し休みましょう。	null	Wǒmen dōu zǒulèi le, zuòxiàlai xiē yíhuìr ba.	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
609	这件衣服没洗干净。	この服は洗ってもきれいになっていない。	null	Zhèi jiàn yīfu méi xǐgānjìng.	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
610	这个字你又念错了。	この字はあなたはまた読み間違えた。	null	Zhèige zì nǐ yòu niàncuò le.	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
611	工作找着了没有?	仕事はみつかりましたか。	null	Gōngzuò zhǎozháo le méiyou?	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
612	他的电话号码你记住了吗?	彼の電話番号はしっかり覚えましたか。	null	Tā de diànhuà hàomǎ nǐ jìzhù le ma?	\N	gmod	instances047.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
613	他们把书放在桌子上就走了。	彼らは本を机の上に置くと立ち去った。	null	Tāmen bǎ shū fang zài zhuōzi shang jiù zǒu le.	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
614	别坐在地上啊！	地べたに座らないで。	null	Bié zuò zài dìshang a!	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
615	邮票最好贴在信封正面。	切手は封筒の表面に貼るのがよい。	null	Yóupiào zuì hǎo tiē zài xìnfēng zhèngmiàn.	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
616	把号码写在右上角吧！	番号を右上の隅に書いてください。	null	Bǎ hàomǎ xiě zài yòu shàng jiǎo ba!	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
617	他从前天起一直躺在床上。	彼はおとといからずっとベッドに伏せている。	null	Tā cóng qiántiān qǐ yìzhí tǎng zài chuáng shang.	\N	gmod	instances048.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
618	他明天回来。	彼は明日帰って来る。	null	Tā míngtiān huílai.	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
619	他给我寄来一件生日礼物。	彼は私に誕生日プレゼントを一つ送って来た。	null	Tā gěi wǒ jìlai yí jiàn shēngrì lǐwù.	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
620	这儿有几封信，你们拿去吧。	ここに手紙がいくつかあるから，あなたたち持って行ってください。	null	Zhèr yǒu jǐ fēng xìn, nǐmen náqu ba.	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
621	他朝宿舍的方向走去。	彼は宿舎の方向へ歩いて行った。	null	Tā cháo sùshè de fāngxiàng zǒuqu.	\N	gmod	instances049.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
622	他把信放进抽屉里。	彼は手紙を引き出しの中に入れた。	null	Tā bǎ xìn fàngjìn chōuti li.	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
623	孩子们排着队走出了校门。	子供たちは列になって校門を出た。	null	Háizimen páizhe duì zǒuchūle xiàomén.	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
624	报刊阅读后，请放回原处。	新聞・雑誌は読んだ後は元の場所に戻してください。	null	Bàokān yuèdú hòu, qǐng fànghuí yuánchù.	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
625	他穿过马路，来到书店门前。	彼は通りを渡って本屋の入り口の前に来た。	null	Tā chuānguò mǎlù, láidào shūdiàn ménqián.	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
626	他提起行李走出门去。	彼は荷物を持つと出口を出た。	null	Tā tíqǐ xíngli zǒuchū mén qù.	\N	gmod	instances050.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
627	电梯坏了，我们走上去吧。	エレベータが壊れたから，歩いて上がりましょう。	null	Diàntī huài le, wǒmen zǒushàngqu ba.	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
628	这些家具没有用了，你搬下楼去吧。	これらの家具は役に立たなくなったから下の階に運んでください。	null	Zhèxiē jiāju méiyou yòng le, nǐ bānxià lóu qù ba.	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
629	上课了，学生们走进教室来。	授業が始まり，学生たちが教室に入って来た。	null	Shàng kè le, xuéshengmen zǒujìn jiàoshì lái.	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
630	那本新小说已经借出去了。	その新しい小説はもう借り出されました。	null	Nà běn xīn xiǎoshuō yǐjing jièchūqu le.	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
631	机票还没取回来吗? 	航空券はまだもらって来てないのですか。	null	Jīpiào hái méi qǔhuílai ma?	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
632	他朝这边走过来了。	彼はこちらのほうへ歩いて来た。	null	Tā cháo zhèbian zǒuguòlai le.	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
633	他一听就站起来了。	彼は聞くとすぐ立ち上がった。	null	Tā yì tīng jiù zhànqǐlai le.	\N	gmod	instances051.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
1232	她的腰粗起来了。	彼女のウエストは太くなってきた。\n	\N		\N	vmod	\N	\N	\N	0	1
634	老师讲的话你都记下来了吗?	先生が話したことはあなたはすべて書き留めましたか。	null	Lǎoshī jiǎng de huà nǐ dōu jìxiàlai le ma?	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
635	那件事他们决定做下去。	その件は彼らはやり続けることに決めた。	null	Nà jiàn shì tāmen juédìng zuòxiàqu.	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
636	这儿有一个错字，你们看出来了吗?	ここには誤字が一つありますが，見てわかりましたか。	null	Zhèr yǒu yí ge cuòzì, nǐmen kànchūlai le ma?	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
637	他从昏迷中醒过来了。	彼は人事不省の状態から気がついた。	null	Tā cóng hūnmí zhōng xǐngguòlai le.	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
638	用过的书你可以收起来了。	使い終わった本は片付けていいです。	null	Yòngguo de shū nǐ kěyǐ shōuqǐlai le.	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
639	听了他的话，大家都笑起来了。	彼の話しを聞いて皆は笑い出した。	null	Tīngle tā de huà, dàjiā dōu xiàoqǐlai le.	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
640	这枝笔用起来很方便。	このペンは使って見ると便利だ。	null	Zhè zhī bǐ yòngqǐlai hěn fāngbiàn.	\N	gmod	instances052.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
641	天黑了，快回家去。	暗くなったから，早く家に帰ろう。	null	Tiān hēi le, kuài huí jiā qù.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
642	端一碗汤来！	スープを１杯持ってきて！	null	Duān yì wǎn tāng lái!	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
643	他给我买了一本词典来。	彼は私に辞書を１冊買ってきてくれた。	null	Tā gěi wǒ mǎile yì běn cídiǎn lái.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
644	他给我买来了一本词典。	彼は私に辞書を１冊買ってきてくれた。	null	Tā gěi wǒ mǎiláile yì běn cídiǎn.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
645	运动员走进比赛大厅去了。	選手は競技場に入って行った。	null	Yùndòngyuán zǒujìn bǐsài dàtīng qù le.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
646	你拿出本子来。	ノートを出して。	null	Nǐ náchū běnzi lái.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
647	他从房间里搬出一把椅子来。	彼は部屋から椅子を１脚運び出して来た。	null	Tā cóng fángjiān li bānchū yì bǎ yǐzi lái.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
648	他从房间里搬出来一把椅子。	彼は部屋から椅子を１脚運び出して来た。	null	Tā cóng fángjiān li bānchūlai yì bǎ yǐzi.	\N	gmod	instances053.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
649	你看得见黑板上的字吗? 看得见，但是看不清楚。	あなたは黒板の字が見えますか。見えますが，はっきりとは見えません。	null	Nǐ kàndejiàn hēibǎn shang de zì ma?Kàndejiàn, dànshì kànbuqīngchu.	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
650	这张桌子我一个人搬不动。	このテーブルは私は一人では運べない。	null	Zhè zhāng zhuōzi wǒ yí ge rén bānbudòng.	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
651	生词太多了，记不住。	新出単語が多すぎて，覚え切れない。	null	Shēngcí tài duō le, jìbuzhù.	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
652	这个包太小了，装不进去。	このかばんは小さすぎて，入れることができない。	null	Zhèige bāo tài xiǎo le, zhuāngbujìnqu.	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
653	现在去，六点以前回得来吗?	今行けば，６時より前には帰って来ることができますか。	null	Xiànzài qù, liù diǎn yǐqián huídelái ma?	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
654	这些作业今天晚上做得完做不完?	これらの宿題は今晩やり終えることができますか。	null	Zhèxiē zuòyè jīntiān wǎnshang zuòdewán zuòbuwán?	\N	gmod	instances054.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
655	他病了，上不了课了。	彼は病気になって，授業に出られなくなった。	null	Tā bìng le, shàngbuliǎo kè le.	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
656	这雨看来大不了。	この雨はどうも激しくはなりっこない。	null	Zhè yǔ kànlái dàbuliǎo.	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
657	这本词典太贵了，买不起。	この辞書は高すぎて，買えない。	null	Zhè běn cídiǎn tài guì le, mǎibuqǐ.	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
658	这是杀虫剂，吃不得。	これは殺虫剤だから，食べられません。	null	Zhè shì shāchóngjì, chībude.	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
659	坐这趟火车已经来不及了。	この汽車に乗ってももう間に合いません。	null	Zuò zhè tàng huǒchē yǐjing láibují le.	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
660	这个礼堂坐得下多少人?	この講堂には何人座れますか。	null	Zhèige lǐtáng zuòdexià duōshao rén?	\N	gmod	instances055.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
661	他每天睡得很晚。	彼は毎日寝るのがとても遅いです。	null	Tā měitiān shuì de hěn wǎn.	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
662	他激动得说不出话来。	彼は感激のあまり言葉が出なかった。	null	Tā jīdòng de shuōbuchū huà lái.	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
663	大风吹得他睁不开眼睛。	強風が吹いてきて彼は目を開けられなかった。	null	Dàfēng chuī de tā zhēngbukāi yǎnjing.	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
665	他跑得快不快?	彼は走るのが速いですか。	null	Tā pǎo de kuài bu kuài?	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
666	他说汉语说得很流利。	彼は中国語を話すのがとても流暢だ。	null	Tā shuō Hànyǔ shuō de hěn liúlì.	\N	gmod	instances056.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
667	我高兴得很。	私はとてもうれしい。	null	Wǒ gāoxìng de hěn.	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
668	我渴得要命，快给我一点儿水喝。	すごくのどが渇いた，水をちょっとください。	null	Wǒ kě de yàomìng, kuài gěi wǒ yìdiǎnr shuǐ hē.	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
669	那个地方夏天热得不得了。	そこは夏は暑くてたまらない。	null	Nèige dìfang xiàtiān rè de bùdéliǎo.	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
670	考试结束了，我们高兴极了。	試験が終わったので私たちはうれしくてたまらない。	null	Kǎoshì jiéshù le, wǒmen gāoxìngjí le.	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
671	累死了。	疲れてくたくただ。	null	Lèisǐ le.	\N	gmod	instances057.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
672	上海比北京热。	上海は北京より暑い。	null	Shànghǎi bǐ Běijīng rè.	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
673	他们班的学生比我们班少两个。	彼らのクラスの学生は私たちのクラスより２名少ない。	null	Tāmen bān de xuésheng bǐ wǒmen bān shǎo liǎng ge.	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
674	她家比我家远一点儿。	彼女の家は私の家より少し遠い。	null	Tā jiā bǐ wǒ jiā yuǎn yìdiǎnr.	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
675	弟弟比妹妹高得多。	弟は妹よりずっと背が高い。	null	Dìdi bǐ mèimei gāo de duō.	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
676	我比她更了解这里的情况。	私は彼女より更にここの状況を知っている。	null	Wǒ bǐ tā gèng liǎojiě zhèli de qíngkuàng.	\N	gmod	instances058.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
677	今天没有昨天冷。	今日は昨日ほど寒くない。	null	Jīntiān méiyou zuótiān lěng.	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
678	这座楼没有那座楼高。	このビルはあのビルほど高くない。	null	Zhè zuò lóu méiyou nà zuò lóu gāo.	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
679	姐姐没有弟弟那么爱打球。	お姉さんは弟ほど球技をするのが好きではない。	null	Jiějie méiyou dìdi nàme ài dǎ qiú.	\N	gmod	instances059.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
680	我的词典跟你的词典一样。	私の辞書はあなたの辞書と同じだ。	null	Wǒ de cídiǎn gēn nǐ de cídiǎn yíyàng.	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
681	这间屋子跟那间屋子一样大。	この部屋はあの部屋と同じくらい大きい。	null	Zhè jiān wūzi gēn nà jiān wūzi yíyàng dà.	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
682	橘子跟苹果一样有营养。	ミカンはリンゴと同じくらい栄養がある。	null	Júzi gēn píngguǒ yíyàng yǒu yíngyǎng.	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
683	南方的城市跟北方的城市不一样。	南方の町は北方の町と違う。	null	Nánfāng de chéngshì gēn běifāng de chéngshì bù yíyàng.	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
684	他的意见跟你的意见一样不一样?	彼の意見はあなたの意見と同じですか。	null	Tā de yìjiàn gēn nǐ de yìjiàn yíyàng bu yíyàng？	\N	gmod	instances060.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
685	我哥哥比我高一点儿。	私の兄は私より少し背が高い。	null	Wǒ gēge bǐ wǒ gāo yìdiǎnr.	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
686	今天比昨天冷一点儿。	今日は昨日より少し寒い。	null	Jīntiān bǐ zuótiān lěng yìdiǎnr.	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
687	今天有点儿冷，你多穿点儿衣服吧。	今日は少し寒い，あなたは服を少し多めに着なさい。	null	Jīntiān yǒudiǎnr lěng, nǐ duō chuān diǎnr yīfu ba.	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
688	我有点儿累了，先走了。	私は少し疲れましたので，先に失礼します。	null	Wǒ yǒudiǎnr lèi le, xiān zǒu le.	\N	gmod	instances061.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
689	墙上贴着一张中国地图。	壁に中国の地図が１枚貼ってある。	null	Qiáng shang tiēzhe yì zhāng Zhōngguó dìtú.	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
690	床上躺着一个病人。	ベッドに病人が１人横たわっている。	null	Chuáng shang tǎngzhe yí ge bìngrén.	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
691	门口停着一辆汽车。	入り口に車が１台止まっている。	null	Ménkǒu tíngzhe yí liàng qìchē.	\N	gmod	instances062.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
692	我们宿舍来了一个新同学。	私たちの宿舎に新しい同級生が一人やって来た。	null	Wǒmen sùshè láile yí ge xīn tóngxué.	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
693	大路上走过来两个人。	大通りを二人の人が歩いて来た。	null	Dàlù shang zǒuguòlai liǎng ge rén.	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
694	我们楼里搬走了一家人。	私たちの棟から１軒引っ越していった。	null	Wǒmen lóu li bānzǒule yì jiā rén.	\N	gmod	instances063.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
696	妈妈常常叫我打扫屋子。	お母さんはしばしば私に部屋を掃除させる。	null	Māma chángcháng jiào wǒ dǎsǎo wūzi.	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1233	请喝茶。	お茶をどうぞ。\n	\N		\N	vmod	\N	\N	\N	0	1
697	他叫我替他寄一封信。	彼は私にかわりに彼のために手紙を投函させる。	null	Tā jiào wǒ tì tā jì yì fēng xìn.	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
698	让他去玩儿吧，别管他。	彼を遊ばせてあげなさい，かまわないで。	null	Ràng tā qù wánr ba, bié guǎn tā.	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
699	他不让我看他的照片。	彼は私に彼の写真を見せてくれない。	null	Tā bú ràng wǒ kàn tā de zhàopiàn.	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
700	你请他帮你复习功课吧。	あなたは彼に勉強の復習を手伝ってもらいなさい。	null	Nǐ qǐng tā bāng nǐ fùxí gōngkè ba.	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
701	我们请王先生作报告。	私たちは王さんにお話しをしてもらう。	null	Wǒmen qǐng Wáng xiānsheng zuò bàogào.	\N	gmod	instances064.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
702	“给你一百块。”“找你三块。”	「はい，100元です。」「３元のおつりです。」	null	Gěi nǐ yì bǎi kuài. Zhǎo nǐ sān kuài.	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
703	他送我一本参考书。	彼は私に参考書を１冊くれる。	null	Tā sòng wǒ yì běn cānkǎoshū.	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
704	李老师教我们汉语。	李先生は私たちに中国語を教える。	null	Lǐ lǎoshī jiāo wǒmen Hànyǔ.	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
705	我告诉你一个好消息。	私はあなたにいい知らせを伝える。	null	Wǒ gàosu nǐ yí ge hǎo xiāoxi.	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
706	我想问你一个问题。	私はあなたに一つ質問したいことがある。	null	Wǒ xiǎng wèn nǐ yí ge wèntí.	\N	gmod	instances065.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
707	来！	来い！	null	Lái!	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
708	你好好儿休息吧！	しっかり休んでください。	null	Nǐ hǎohāor xiūxi ba!	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
709	请坐一会儿。	ちょっとおかけください。	null	Qǐng zuò yíhuìr!	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
710	冷静点儿！	落ち着いて！	null	Lěngjìng diǎnr!	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
711	别走！	行くな！	null	Bié zǒu!	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
712	不要相信他！	彼を信用しないで！	null	Bú yào xiāngxìn tā!	\N	gmod	instances066.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
713	我来帮你的忙。	私があなたの手伝いをしましょう。	null	Wǒ lái bāng nǐ de máng.	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
714	他们一共见了三次面。	彼らは合わせて３回会った。	null	Tāmen yígòng jiànle sān cì miàn.	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
715	他以前结过一次婚。	彼は以前一度結婚したことがある。	null	Tā yǐqián jiéguo yí cì hūn. 	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
717	别生我的气呀! 	私のことを怒らないでください。	null	Bié shēng wǒ de qì ya!	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
718	他洗完澡已经十一点了。	彼は風呂からあがるともう11時だった。	null	Tā xǐwán zǎo yǐjing shíyī diǎn le.	\N	gmod	instances067.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
719	我把这本书看完了。	私はこの本を読み終わった。	null	Wǒ bǎ zhè běn shū kànwán le.	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
720	我把那个书架搬出去了。	私はあの書棚を運び出した。	null	Wǒ bǎ nèige shūjià bānchūqu le.	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
721	他把衣服洗得很干净。	彼は服をきれいに洗った。	null	Tā bǎ yīfu xǐ de hěn gānjìng.	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
722	他把地图挂在墙上了。	彼は地図を壁に掛けた。	null	Tā bǎ dìtú guà zài qiáng shang le.	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
723	请你把这个句子翻译成英文。	この文を英語に訳してください。	null	Qǐng nǐ bǎ zhèige jùzi fānyìchéng Yīngwén.	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
724	请把这本小说还给小王。	この小説を王さんに返してください。	null	Qǐng bǎ zhè běn xiǎoshuō huángěi Xiǎo Wáng.	\N	gmod	instances068.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
725	小偷儿被警察抓住了。	泥棒は警察に捕まえられた。	null	Xiǎotōur bèi jǐngchá zhuāzhù le. 	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
726	桌子上的资料被风刮乱了。	机の上の資料は風に吹かれてばらばらになった。	null	Zhuōzi shang de zīliào bèi fēng guāluàn le. 	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
727	我们都被眼前的景色吸引住了。	私たちは皆目の前の景色に引きつけられた。	null	Wǒmen dōu bèi yǎnqián de jǐngsè xīyǐnzhù le.	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
728	深夜我们突然被吵闹声惊醒了。	深夜に私たちは突然騒ぎ声で起こされた。	null	Shēnyè wǒmen tūrán bèi chǎonàoshēng jīngxǐng le.	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
729	他被大家选为代表了。	彼は皆から代表に選ばれた。	null	Tā bèi dàjiā xuǎnwéi dàibiǎo le.	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
730	房子被拆掉了。	家は取り壊された。	null	Fángzi bèi chāidiào le.	\N	gmod	instances069.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
1234	车票丢了。	切符がなくなった。\n	\N		\N	vmod	\N	\N	\N	0	1
731	你是什么时候来的?	あなたはいつ来たのですか。	null	Nǐ shì shénme shíhou lái de?	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
732	他是从北京来的。	彼は北京から来たのです。	null	Tā shì cóng Běijīng lái de.	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
733	我们是坐地铁来的。	私たちは地下鉄に乗って来たのです。	null	Wǒmen shì zuò dìtiě lái de.	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
734	我是跟朋友一起到中国来的。	私は友人と一緒に中国に来たのです。	null	Wǒ shì gēn péngyou yìqǐ dào Zhōngguó lái de.	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
735	我们是在公园照的相。	私たちは公園で写真を撮ったのです。	null	Wǒmen shì zài gōngyuán zhào de xiàng.	\N	gmod	instances070.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
736	虽然我以前看过这本小说，但是主要内容都忘了。	私はこの小説は以前読んだことがあるが，主な内容は忘れてしまった。	null	Suīrán wǒ yǐqián kànguo zhè běn xiǎoshuō, dànshì zhǔyào nèiróng dōu wàng le.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
737	他因为病了，所以昨天没来上课。	彼は病気なったので，昨日は授業に来なかった。	null	Tā yīnwèi bìng le, suǒyǐ zuótiān méi lái shàngkè.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
738	今天晚上你要是有时间，就到我家来玩儿吧。	今晩もし時間があったら，私の家に遊びに来てください。	null	Jīntiān wǎnshang nǐ yàoshi yǒu shíjiān, jiù dào wǒ jiā lái wánr ba.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
739	如果生活上有什么困难，就跟我说一声。	もし生活の上で何か困ったことがあったら，私に声をかけてください。	null	Rúguǒ shēnghuó shang yǒu shénme kùnnan, jiù gēn wǒ shuō yì shēng.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
740	他不但发音好，而且说得也很流利。	彼は発音がいいだけでなく，話すのも流暢だ。	null	Tā búdàn fāyīn hǎo, érqiě shuō de yě hěn liúlì.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
741	只有经常复习，才能巩固学过的知识。	頻繁に復習してはじめて学んだ知識をゆるぎないものにすることができる。	null	Zhǐyǒu jīngcháng fùxí, cái néng gǒnggù xuéguo de zhīshi.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[6]	\N	\N	1
742	只要有勇气，就一定能够克服困难。	勇気さえあれば必ず困難を克服することができる。	null	Zhǐyào yǒu yǒngqì, jiù yídìng nénggòu kèfú kùnnan.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[7]	\N	\N	1
743	我们不管做什么工作，都应该认真做好。	私たちは何の仕事をする場合でも真剣にやりとげるべきである。	null	Wǒmen bùguǎn zuò shénme gōngzuò, dōu yīnggāi rènzhēn zuòhǎo.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[8]	\N	\N	1
744	无论工作怎么忙，他都抽时间来看我。	仕事がどんなに忙しくても，彼は時間を割いて私に会いに来てくれる。	null	Wúlùn gōngzuò zěnme máng, tā dōu chōu shíjiān lái kàn wǒ.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[9]	\N	\N	1
745	即使明天下雨，我们也要去。	たとえ明日雨が降っても私たちは行かなければならない。	null	Jíshǐ míngtiān xiàyǔ, wǒmen yě yào qù.	\N	gmod	instances071.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[10]	\N	\N	1
746	这件事他越思量越不明白。	この件は彼は考えれば考えるほどわからなくなった。	null	Zhè jiàn shì tā yuè sīliang yuè bù míngbai.	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
747	讨论越深入，道理越清楚。	議論が深まれば深まるほど，道理は明確になる。	null	Tǎolùn yuè shēnrù, dàoli yuè qīngchu.	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
748	他越来越爱喝酒了。	彼はますます酒を飲むのが好きになった。	null	Tā yuè lái yuè ài hē jiǔ le.	\N	gmod	instances072.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
749	他一边说话，一边收拾工具。	彼は話しをしながら道具を片付けている。	null	Tā yìbiānr shuōhuà, yìbiānr shōushi gōngjù.	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
750	记汉字的时候，可以一边儿念，一边儿写。	漢字を覚えるときは読みながら書くといい。	null	Jì Hànzì de shíhou, kěyǐ yìbiānr niàn, yìbiānr xiě.	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
751	孩子们一边儿唱，一边儿跳。	子供たちは歌いながら踊っている。	null	Háizimen yìbiānr chàng, yìbiānr tiào.	\N	gmod	instances073.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
752	工人们一到工地就干了起来。	労働者たちは工事現場に着くとすぐに働き始めた。	null	Gōngrénmen yí dào gōngdì jiù gànle qǐlái.	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
753	他一想到做饭就头疼。	彼は食事の用意のことを思い出すとうんざりしてしまう。	null	Tā yì xiǎngdào zuò fàn jiù tóu téng.	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
754	使用说明很清楚，一看就明白。	使用説明ははっきり書いてあって，読めばすぐにわかる。	null	Shǐyòng shuōmíng hěn qīngchu, yí kàn jiù míngbai.	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
755	他一和女孩子说话，脸就红。	彼は女の子と話しをするとすぐに顔が赤くなる。	null	Tā yì hé nǚháizi shuō huà, liǎn jiù hóng.	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[4]	\N	\N	1
756	一到那儿，天就冷了。	そこに着くとすぐに寒くなった。	null	Yí dào nàr, tiān jiù lěng le.	\N	gmod	instances074.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[5]	\N	\N	1
757	这个演员演什么像什么。	この俳優は何を演じても似ている。	null	Zhèige yǎnyuán yǎn shénme xiàng shénme.	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[1]	\N	\N	1
1235	把窗户打开。	窓を開ける。	\N		\N	vmod	\N	\N	\N	0	1
758	你喜欢哪个，我给你哪个。	あなたの好みのものをどれでもあげます。	null	Nǐ xǐhuan nǎge, wǒ gěi nǐ nǎge.	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[2]	\N	\N	1
759	你愿意怎么去就怎么去。	あなたが行きたい方法で行きなさい。	null	Nǐ yuànyi zěnme qù jiù zěnme qù.	\N	gmod	instances075.xml	/gmod:instances[1]/gmod:instanceblock[1]/gmod:instance[3]	\N	\N	1
760	马老师，您好！	馬先生，こんにちは。	挨拶をする	Mǎ lǎoshī, nín hǎo!	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
761	你好！	こんにちは，	挨拶する	Nǐ hǎo!	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
762	你姓什么？	あなたは。	特徴についてたずねる	Nǐ xìng shénme?	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
763	我姓李，	わたくしは李と申します，	自己紹介する	Wǒ xìng Lǐ,	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
764	我叫李环。	李環です。	自己紹介する	wǒ jiào Lǐ Huán.	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
765	哦，你是李环。	ああ，李環さん。		O, nǐ shì Lǐ Huán.	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
766	你是中文系的学生吗？	君は中文学科の学生なの。	特徴についてたずねる	Nǐ shì Zhōngwénxì de xuésheng ma?	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
767	是，老师。	そうです，先生。		Shì, lǎoshī.	\N	dmod	zh01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
768	小张，等一会儿，	張さん，ちょっと待って。	注意をひく	Xiǎo Zhāng, děng yíhuìr,	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
769	这是你的吧？	これ君のでしょ。	情報を求める（属性）	zhè shì nǐ de ba?	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
770	是我的，	私のだわ。		Shì wǒ de,	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
771	唉，我的钱包怎么在你这儿？	ねえ，どうしてあなたが私の財布を持っているの。		ai, wǒ de qiánbāo zěnme zài nǐ zhèr?	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
772	刚才你的钱包掉在地上了。	さっき君の財布が下に落ちたんだよ。		Gāngcái nǐ de qiánbāo diàozài dìshang le.	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
773	是吗，	そうなの，		Shì ma?	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
774	谢谢你帮我把钱包捡起来。	拾ってくれてありがとう。	感謝する	Xièxie nǐ bāng wǒ bǎ qiánbāo jiǎn qilai.	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
775	不客气，	どういたしまして。		Bú kèqi,	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
776	以后小心点儿！	これから気をつけてよ。	助言する	yǐhòu xiǎoxin diǎnr!	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
777	太感谢你了。	本当にありがとう。	感謝する	Tài gǎnxiè nǐ le.	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
778	我以后一定注意。	これから注意します。		Wǒ yǐhòu yídìng zhùyì.	\N	dmod	zh02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
779	你们的校园真漂亮啊！	君たちのキャンパスってほんときれいだね！		Nǐmen de xiàoyuán zhēn piàoliang a!	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
780	是啊。	でしょう。		Shì a.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
781	你看，	ほら，	注意をひく	Nǐ kàn,	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
782	这是图书馆。	これが図書館よ。		zhè shì túshūguǎn.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
783	图书馆的西边儿是教学楼。	図書館の西側は教室棟。		Túshūguǎn de xībiānr shì jiàoxuélóu.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[4]	\N	\N	1
784	我们的教室在教学楼里边儿。	私たちの教室は教室棟にあるの。		Wǒmen de jiàoshì zài jiàoxuélóu lǐbiānr.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[5]	\N	\N	1
785	那是礼堂吗？	あれは講堂？	情報を求める（存在と場所）	Nà shì lǐtáng ma?	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
787	是电教楼，	ＬＬ棟よ，		shì diànjiàolóu,	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
788	那里有很多教室。	あの中には教室がたくさんあるの。		nàli yǒu hěn duō jiàoshì.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
789	对了，	そうだ，	注意をひく	Duì le,	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
790	我想问你一下。	ちょっと聞きたいんだけど。		wǒ xiǎng wèn nǐ yíxià.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
791	校园里有邮局吗？	キャンパス内に郵便局あるか。	場所についてたずねる	Xiàoyuán li yǒu yóujú ma?	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
792	我想寄一封信。	手紙を一通出したいんだけど。		Wǒ xiǎng jì yì fēng xìn.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[4]	\N	\N	1
793	有。	あるわよ。		Yǒu.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
794	那儿就是。	そこがそうよ。		Nàr jiù shì.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
795	你们的学校很方便。	君たちの学校って便利だね。		Nǐmen de xuéxiào hěn fāngbiàn.	\N	dmod	zh03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
796	这里有人坐吗？	ここ空いていますか。	場所についてたずねる	Zhèli yǒu rén zuò ma?	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
797	没有。	空いていますよ。		Méiyou.	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
798	你第一次上这门课吗？	この授業は初めてですか。	経験についてたずねる	Nǐ dì-yī cì shàng zhè mén kè ma？	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
800	我上次没来上课。	前回休んでたもので。		wǒ shàng cì méi lái shàng kè.	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
801	你叫什么？	お名前は何ですか。	特徴についてたずねる	Nǐ jiào shénme?	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
802	我叫李明，	李明と言います。	自己紹介する	Wǒ jiào Lǐ Míng,	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
803	你呢？	あなたは。	特徴についてたずねる	nǐ ne?	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
804	我叫王刚。	王剛と言います。	自己紹介する	Wǒ jiào Wáng Gāng.	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
805	以后请多关照。	今後ともよろしく。	挨拶をする	Yǐhòu qǐng duō guānzhào.	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
806	请多关照。	よろしく。	挨拶をする	Qǐng duō guānzhào.	\N	dmod	zh04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
807	请问，	あのう，	注意をひく	Qǐng wèn,	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
808	你是中文系的学生吗？	あなた中文学科の学生さんですか。	特徴についてたずねる	nǐ shì Zhōngwénxì de xuésheng ma?	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
809	是。	はい。		Shì.	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
810	你认识马华教授吗？	馬教授をご存知ですか。		Nǐ rènshi Mǎ Huá jiàoshòu ma?	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
811	认识。	はい。		Rènshi.	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
812	你找他吗？	お探しですか。		Nǐ zhǎo tā ma?	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
813	对。	ええ。		Duì.	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
814	他在教研室吗？	ご自分の研究室にいらっしゃいますでしょうか。	場所についてたずねる	Tā zài jiàoyánshì ma?	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
815	对不起，	ごめんなさい，	あやまる	Duìbuqǐ,	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
816	我不知道。	知らないんです。		wǒ bù zhīdào.	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
817	去他们教研室怎么走？	研究室にはどういったらいいのですか。	場所についてたずねる	Qù tāmen jiàoyánshì zěnme zǒu?	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
818	很抱歉，	すみませんが，	あやまる	Hěn bàoqiàn,	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
819	我不清楚。	わかりません。		wǒ bù qīngchu.	\N	dmod	zh05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
820	早上好！	おはよう。	挨拶をする	Zǎoshang hǎo!	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
821	早上好！	おはよう，	挨拶をする	Zǎoshang hǎo!	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
822	你回来了？	帰ってきたんだ。		Nǐ huílai le?	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
823	玩儿得怎么样？	旅行どうだった。	情報を求める（属性）	Wánrde zěnmeyàng?	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
824	不错。	結構良かったわ。		búcuò	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
825	这次旅游一共去了几天？	今回の旅行は，全部で何日行ってたんだっけ。	情報を求める（時間）	Zhè cì lǚyóu yígòng qùle jǐ tiān?	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
826	一共一个星期。	全部で1週間ね。		Yígòng yí ge xīngqī.	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
827	对了，	そうそう，	注意をひく	Duì le,	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
828	我给你买了点儿礼物。	お土産を買ってきたの。		wǒ gěi nǐ mǎile diǎnr lǐwù.	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
829	这个给你。	これあげるわ。	何かをあげる	Zhège gěi nǐ.	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[4]	\N	\N	1
830	谢谢。	ありがとう。	感謝する	Xièxie.	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
831	还有，	それから，	注意をひく	Hái yǒu,	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
832	这个也给你。	これもあげます。	何かをあげる	zhège yě gěi nǐ.	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
833	你给我买这么多礼物，	こんなにたくさん買ってきたんだ，		Nǐ gěi wǒ mǎi zhème duō lǐwù,	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
834	真不好意思。	本当に悪いね。	感謝する	zhēn bù hǎo yìsi.	\N	dmod	zh06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
835	你去哪儿？	どこ行くの？	情報を求める（存在と場所）	Nǐ qù nǎr?	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
836	我去办公室办手续。	事務室に手続きしに行くんだ。		Wǒ qù bàngōngshì bàn shǒuxù.	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
837	办公室今天有人吗？	事務室って今日人いるの？	情報を求める（存在と場所）	Bàngōngshì jīntiān yǒu rén ma?	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
838	听说有人。	いるそうだよ。		Tīngshuō yǒu rén.	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
839	你去哪儿？	君はどこ行くの？	情報を求める（存在と場所）	Nǐ qù nǎr?	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
840	我去商店买东西。	お店に買い物に行くの。		Wǒ qù shāngdiàn mǎi dōngxi.	\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
841	再见！	じゃ，さようなら。	さよならを言う		\N	dmod	zh07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
843	欢迎光临。	いらっしゃいませ。	挨拶をする	Huānyíng guānglín.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
844	您买点儿什么？	何をお探しですか。		Nín mǎi diǎnr shénme?	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
845	鞋在哪儿卖？	靴はどこに売ってますか。	情報を求める（存在と場所）	Xié zài nǎr mài?	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
846	在那儿。	あちらにあります。		Zài nàr.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
847	这双多少钱？	これいくら。	情報を求める（金額）	Zhèi shuāng duōshao qián?	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
848	一双一百五十块。	一足150元です。	一足150元です。	Yì shuāng yìbǎi wǔshi kuài.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
849	有便宜点儿的吗？	もっと安いのないですか。	情報を求める（存在と場所）	Yǒu piányi diǎnr de ma?	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
850	这双怎么样？	これはどうでしょうか。	提案する	Zhè shuāng zěnmeyàng?	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
851	九十块钱一双，	一足90元です。		Jiǔshí kuài qián yì shuāng,	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
852	又便宜又结实。	お安くしかも丈夫です。		yòu piányi yòu jiēshi.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
853	那我要这双。	では，これを。	要求する	Nà wǒ yào zhèi shuāng.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
854	收您一百块钱，	100元おあずかりいたしました。		Shōu nín yìbǎi kuài qián,	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
855	找您十块钱。	10元のお返しです。		zhǎo nín shí kuài qián.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
856	欢迎再来。	またのお越しを。	さよならを言う	Huānyíng zài lái.	\N	dmod	zh08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
857	你去过外国吗？	あなた外国に行ったことある？	情報を求める（経験）	Nǐ qùguo wàiguó ma?	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
858	我去过两次德国。	僕はドイツに２回行ったことがある。		Wǒ qùguo liǎng cì Déguó.	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
859	那你喝过德国啤酒吧？	じゃ，ドイツビール飲んだことあるよね。	情報を求める（経験）	Nà nǐ hēguo Déguó píjiǔ ba?	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
860	喝过。	ある。		Hēguo.	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
861	你呢？	君は。	情報を求める（経験）	Nǐ ne?	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
862	我没去过外国。	私は外国には行ったことがないの。		Wǒ méi qùguo wàiguó.	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
863	如果有机会，你想去哪儿？	機会があったらどこ行きたい。	ある条件での行動を言う	Rúguǒ yǒu jīhuì, nǐ xiǎng qù nǎr?	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
864	我想去美国。	アメリカに行きたいわ。	希望を述べる	Wǒ xiǎng qù Měiguó.	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
865	我也想去美国看看。	僕も行ってみたいな。	希望を述べる	Wǒ yě xiǎng qù Měiguó kànkan.	\N	dmod	zh09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
866	今天晚上七点半在中山音乐堂有一个中国民族音乐会。	今晩７時半から中山音楽堂で中国民族音楽のコンサートがあるんだ。		Jīntiān wǎnshang qī diǎn bàn zài Zhōngshān Yīnyuètáng yǒu yí ge Zhōngguó mínzú yīnyuèhuì.	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
867	我们一起去听，怎么样？	一緒に聞きに行かない？	提案する	Wǒmen yìqǐ qù tīng, zěnmeyàng?	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
868	好啊。	いいわよ。		Hǎo a.	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
869	咱们什么时候见面？	何時に会う？	予定を言う	Zánmen shénme shíhou jiànmiàn?	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
870	七点钟，好吗？	７時でどう。	提案する	Qī diǎn zhōng, hǎo ma?	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
871	七点钟太早，	７時じゃ早すぎるわ，		Qī diǎn zhōng tài zǎo,	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
872	七点一刻吧。	７時１５分にしましょう。	提案する	qī diǎn yí kè ba.	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
873	好吧。	いいよ。		Hǎo ba.	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
874	咱们在哪儿见面？	どこで会う？	予定を述べる	Zánmen zài nǎr jiàn miàn?	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
875	你在音乐堂门口等我，	音楽堂の入口で待ってて，	指示する	Nǐ zài yīnyuètáng ménkǒur děng wǒ,	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
876	我现在就去买票。	僕，今からチケット買いに行ってくるから。		wǒ xiànzài jiù qù mǎi piào.	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
877	好的，	うん，		Hǎo de,	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
878	一会儿见。	あとでね。	さよならを言う	yíhuìr jiàn.	\N	dmod	zh10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
879	这个周末你去哪儿？	あなた今度の週末，どこ行くの。	情報を求める（存在と場所）	Zhège zhōumò nǐ qù nǎr?	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
880	我打算去司马台。	司馬台に行こうかと思っているんだ。	予定を言う	Wǒ dǎsuan qù Sīmǎ Tái.	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1236	他戴着红色的帽子。	彼は赤色の帽子をかぶっている。\n	\N		\N	vmod	\N	\N	\N	0	1
881	司马台，我也想去。	司馬台ねえ，私も行ってみたいな。	希望を述べる	Sīmǎ Tái, wǒ yě xiǎng qù.	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
883	你知道长城有多长吗？	君長城ってどれくらいの長さか知ってる。	情報を求める（程度）	nǐ zhīdao Chángchéng yǒu duō cháng ma?	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
884	大概五千公里左右吧。	5000kmくらいでしょ。		Dàgài wǔqiān gōnglǐ zuǒyòu ba.	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
885	不止五千公里，	5000kmどころか，		Bù zhǐ wǔqiān gōnglǐ,	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
886	有六千公里左右。	6000kmくらいだよ。		yǒu liùqiān gōnglǐ zuǒyòu.	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
887	司马台离这儿有多远？	司馬台ってここからどれ位離れているの。	情報を求める（程度）	Sīmǎ Tái lí zhèr yǒu duō yuǎn?	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
888	大概有二百公里。	200km位かな。		Dàgài yǒu èrbǎi gōnglǐ.	\N	dmod	zh11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
889	李刚，现在几点？	李剛君，今何時。	情報を求める（時間）	Lǐ Gāng, xiànzài jǐ diǎn?	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
890	快两点了。	もうすぐ２時だよ。		Kuài liǎng diǎn le.	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
891	我两点上课，	私２時授業なの，		Wǒ liǎng diǎn shàng kè,	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
892	得走了。	行かなくっちゃ。		děi zǒu le.	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
893	你上哪门课？	何の授業にでるの。		Nǐ shàng nǎ ménr kè?	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
894	我上德语课。	ドイツ語の授業よ。	予定を言う	Wǒ shàng Déyǔ kè.	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
895	哦，你在学习德语！	君ドイツ語を習っているんだ。		O, nǐ zài xuéxí Déyǔ!	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
896	你学了多长时间了？	どれ位習ったの。	情報を求める（時間）	Nǐ xuéle duō cháng shíjiān le?	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
897	我学了两年了，	２年習ったわよ。		Wǒ xuéle liǎng nián le,	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
898	你学过吗？	あなた習ったことある？	情報を求める（経験）	nǐ xuéguo ma?	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
899	没有。	習ったことないね。		Méiyou.	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
900	外语，除了英语我什么都没学过。	外国語は英語以外習ってない。		Wàiyǔ, chúle Yīngyǔ wǒ shénme dōu méi xuéguo.	\N	dmod	zh12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
901	王刚，我想托你一件事。	王剛君，頼みたいことがあるんだけど。	依頼する	Wáng Gāng, wǒ xiǎng tuō nǐ yí jiàn shì.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
902	什么事？	何。		shénme shì?	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
903	我的电脑有点儿毛病，	パソコンが少しおかしくなって。		Wǒ de diànnǎo yǒu diǎnr máobing,	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
904	你可以给看一下吗？	ちょっと見てもらえるしら。	依頼する	nǐ kěyǐ gěi kàn yíxiàr ma?	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
905	好的。	いいけど。		Hǎo de.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
906	你什么时候方便？	いつごろ都合がいい。	予定を言う	Nǐ shénme shíhòu fāngbiàn?	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
907	现在说不好，	今ははっきりいえないので，		Xiànzài shuōbuhǎo,	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
908	回头给你打电话商量。	後から電話するよ。	手順と順序について述べる	huítóu gěi nǐ dǎ diànhuà shāngliang.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
909	你的电话是多少？	君の電話番号はいくつ。	情報を求める（数字）	Nǐ de diànhuà shì duōshao?	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
910	是62768875。	62768875よ。		Shì liù-èr-qī-liù-bā-bā-qī-wǔ.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
911	你住几号楼？	君何号棟に住んでいるの。	情報を求める（数字）	Nǐ zhù jǐ hào lóu?	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
912	我住四十五号楼。	45号棟よ。		Wǒ zhù sìshiwǔ hào lóu.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
913	你的房间号码是多少？	部屋番号はいくつ。	情報を求める（数字）	Nǐ de fángjiān hàomǎ shì duǒshao?	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
914	房间号码是4512。	部屋番号は4512よ。		Fángjiān hàomǎ shì sì-wǔ-yāo-èr.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
915	那好，	じゃそういうことで，		Nà hǎo,	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[1]	\N	\N	1
916	我先走了，	先に失礼するよ。	さよならを言う	wǒ xiān zǒu le,	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[2]	\N	\N	1
917	一会儿给你打电话。	後から電話するから。	手順と順序について述べる	yíhuìr gěi nǐ dǎ diànhuà.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[12]/sentence[3]	\N	\N	1
918	回头见。	また後で。	さよならを言う	Huítóu jiàn.	\N	dmod	zh13.xml	/dmodule[1]/body[1]/dialogue[1]/line[13]/sentence[1]	\N	\N	1
919	今天中午有个人来找过你。	今日の午後，君を訪ねて来た人がいたよ。		Jīntiān zhōngwǔ yǒu ge rén lái zhǎoguo nǐ.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1237	日本大使馆在哪儿？	日本大使館はどこですか。\n	\N		\N	vmod	\N	\N	\N	0	1
920	她没说叫什么名字？	彼女何て名前か言ってなかった？	情報を求める（属性）	Tā méi shuō jiào shénme míngzi?	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
922	她一听你不在就走了。	君がいないって聞いたらすぐに行っちゃった。		Tā yì tīng nǐ bú zài jiù zǒu le.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
923	她是怎么来的？	彼女どうやって来たって？		Tā shì zěnme lái de?	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
924	是骑自行车来的。	自転車で来たんだって。	何でどのようにするかを言う	Shì qí zìxíngchē lái de.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
925	她让你晚上给她打个电话。	君に夜電話してほしいってさ。	指示する	Tā ràng nǐ wǎnshang gěi tā dǎ ge diànhuà.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
926	她留下电话号码了吗？	電話番号残してる？		Tā liúxià diànhuà hàomǎ le ma?	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
927	留了，	残してるよ。		Liú le,	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
928	她的电话号码写在我的本子上。	電話番号は僕のノートに書いてあるよ。		tā de diànhuà hàomǎr xiězài wǒ de běnzi shang.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
929	等等，	ちょっと待って，	注意をひく	Děngdeng,	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
930	我给你找找。	探してあげる。		wǒ gěi nǐ zhǎozhao.	\N	dmod	zh14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	1
931	你在干什么？	何してるの？	どうしているかをたずねる	Nǐ zài gàn shénme?	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
932	我在写报告呢，	レポート書いてるの，		Wǒ zài xiě bàogào ne,	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
933	明天早上第一节就交。	明日の朝１限に提出なの。	手順と順序について述べる	míngtiān zǎoshang dì-yī jié jiù jiāo.	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
934	我帮你打出来。	タイプするの手伝うよ。		Wǒ bāng nǐ dǎ chulai.	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
935	你会打字吗？	タイプできるの？	技能と能力についてたずねる	Nì huì dǎ zì ma?	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
936	会。	できるよ。		Huì.	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
937	一分钟能打多少？	１分間にどれ位打てる？	技能と能力についてたずねる	Yì fēnzhōng néng dǎ duōshao?	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
938	能打二百个字。	２００字打てる。		Néng dǎ èrbǎi ge zì.	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
939	是吗！	よかった！		Shì ma!	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
940	那请你帮忙给打出来，好吗？	ちょっと手伝ってくださいな。	依頼する	Nà qǐng nǐ bāngmáng gěi dǎ chulai, hǎo ma?	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
941	好。	いいよ。		Hǎo.	\N	dmod	zh15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
942	对不起，请问，	すいません，お尋ねします。	注意をひく	Duìbuqǐ, qǐngwèn,	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
943	301教室在哪儿？	301教室はどこですか。	情報を求める（存在と場所）	sān-líng-yāo jiàoshì zài nǎr?	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
944	从这儿一直往前走，	ここからまっすぐ行って，	手順と順序について述べる	Cóng zhèr yìzhí wàng qián zǒu,	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
945	走到头儿往右拐就是。	突き当りを右に曲がったところです。	手順と順序について述べる	zǒudào tóur wàng yòu guǎi jiù shì.	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
946	你说的是那儿吗？	あそこですか。	情報を求める（存在と場所）	Nǐ shuō de shì nàr ma?	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
947	对。	そうです。		Duì.	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
948	知道了，	分かりました。		Zhīdao le,	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
949	谢谢。	ありがとうございます。	感謝する	xièxie.	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
950	还有，	それから，	注意をひく	Háiyǒu,	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
951	厕所在哪儿？	トイレどこにありますか。	情報を求める（存在と場所）	cèsuǒ zài nǎr?	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[4]	\N	\N	1
952	就在301教室旁边儿。	301教室の隣よ。		Jiù zài sān-líng-yāo jiàoshì pángbiānr.	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
953	谢谢。	ありがとうございます。	感謝する	Xièxie.	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
954	不客气。	どういたしまして。		Bú kèqi.	\N	dmod	zh16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
955	这个周末咱们去哪儿玩儿玩儿吧。	今度の週末どこか遊びに行こうよ。	提案する	Zhèige zhōumò zánmen qù nǎr wánrwanr ba.	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
956	好，	いいわよ。		Hǎo,	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
957	有什么好地方吗？	どこか良い場所あるかしら。	情報を求める（存在と場所）	yǒu shénme hǎo dìfang ma?	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
958	长城怎么样？	長城はどう。	情報を求める（属性）	Chángchéng zěnmeyàng?	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
959	长城也行，	長城もいいけど，		Chángchéng yě xíng,	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
960	可是有点儿远。	ちょっと遠いわね。		kěshì yǒudiǎnr yuǎn.	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
961	动物园怎么样？	動物園はどう。	情報を求める（属性）	Dòngwùyuánr zěnmeyàng?	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
962	动物园一点儿意思也没有，	動物園はちっとも面白くないよ。	意見を言う	Dòngwùyuánr yìdiǎnr yìsi yě méiyou,	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
963	香山怎么样？	香山はどう。	情報を求める（属性）	Xiāng Shān zěnmeyàng?	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
964	香山最好秋天去，	香山は秋に行くのが一番よ。	比べて述べる（比較と最上級）	Xiāng Shān zuì hǎo qiūtiān qù,	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
965	现在不是时候。	今は時期じゃないわ。		xiànzài bú shì shíhou.	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
966	那么，王府井呢？	じゃ，王府井はどう。	情報を求める（属性）	Nàme, Wángfǔjǐng ne?	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
967	王府井还行，	王府井は良い場所ですね。	意見を言う	Wángfújǐng hái xíng,	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
968	那我们去王府井买东西吧。	じゃ王府井に買い物に行きましょう。	提案する	nà wǒmen qù Wángfǔjǐng mǎi dōngxi ba.	\N	dmod	zh17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
969	我觉得这部电影不错。	私，この映画よかったと思う。	意見を言う	Wǒ juéde zhè bù diànyǐng bú cuò.	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
970	女演员演得很好。	女優の演技がすばらしかったわ。	理由を述べる	Nǚ yǎnyuán yǎn de hěn hǎo.	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
971	我不同意这种看法。	僕はそう思わないな。	意見を言う	Wǒ bù tóngyì zhèi zhǒng kànfǎ.	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
972	女演员长得太难看了。	女優が非常にぶさいくだったんだ。	理由を述べる	Nǚ yǎnyuán zhǎng de tài nánkàn le.	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
973	我反对用演员漂亮不漂亮来评价一部电影的好坏。	私，役者の美醜で映画の善し悪しを評価することには反対だわ。	意見を言う	Wǒ fǎnduì yòng yǎnyuán piàoliang bu piàoliang lái píngjià yí bù diànyǐng de hǎo huài.	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
974	我看这部电影很一般，	僕はさ，この映画は平凡だったと思うよ。	意見を言う	Wǒ kàn zhèi bù diànyǐng hěn yìbān,	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
975	内容过于简单。	内容が単純すぎだよ。	理由を述べる	nèiróng guòyú jiǎndān.	\N	dmod	zh18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
976	你喜欢音乐吗？	君は音楽好き？	嗜好について述べる（もの）	Nǐ xǐhuan yīnyuè ma?	\N	dmod	zh19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
977	喜欢。	好きよ。	嗜好について述べる（もの）	Xǐhuan.	\N	dmod	zh19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
978	喜欢什么音乐？	どんな音楽が好き？	嗜好について述べる（もの）	Xǐhuan shénme yīnyuè?	\N	dmod	zh19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
979	我喜欢古典音乐、爵士乐、民歌，	クラシック，ジャズ，民謡，	嗜好について述べる（もの）	Wǒ xǐhuan gǔdiǎn yīnyuè、juéshìyuè、míngē,	\N	dmod	zh19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
980	流行歌曲也喜欢。	それに流行歌も好き。	嗜好について述べる（もの）	liúxíng gēqǔ yě xǐhuan.	\N	dmod	zh19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
981	我对音乐有兴趣，	僕は音楽も興味あるけど，	嗜好について述べる（もの）	Wǒ duì yīnyùe yǒu xìngqu,	\N	dmod	zh20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
982	但是我更喜欢运动。	スポーツの方が好きだな。	嗜好について述べる（行動）	dànshì wǒ gèng xǐhuan yùndong.	\N	dmod	zh20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
983	你喜欢什么运动？	どんなスポーツが好き？	嗜好について述べる（行動）	Nǐ xǐhuan shénme yùndòng?	\N	dmod	zh20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
984	我喜欢打篮球、踢足球、游泳。	バスケット，サッカー，水泳が好きだな。	嗜好について述べる（行動）	Wǒ xǐhuan dǎ lánqiú、tī zúqiú、yóuyǒng.	\N	dmod	zh20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
985	我只喜欢打排球，	私が好きなのはバレーボールだけ，	嗜好について述べる（行動）	Wǒ zhǐ xǐhuan dǎ páiqiú,	\N	dmod	zh20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
986	对别的运动都不感兴趣。	他のスポーツには興味ないわ。	嗜好について述べる（行動）	duì biéde yùndòng wǒ dōu bù gǎn xìngqu.	\N	dmod	zh20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
987	你暑假打算干什么？	夏休みはどうする予定？	予定を言う	Nǐ shǔjià dǎsuan gàn shénme?	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
988	我打算先到日本参加一个短期日语学习班，	まず日本に行って短期の日本語学習クラスに参加して，	手順と順序について述べる	Wǒ dǎsuan xiān dào Rìběn qù cānjiā yí ge duǎnqī Rìyǔ xuéxíbān,	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
989	然后在日本旅游一个星期，	それから日本を１週間旅行して，	手順と順序について述べる	ránhòu zài Rìběn lǚyóu yí ge xīngqī,	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
990	八月底回来。	８月末に戻って来るつもりです。	予定を言う	bā yuè dǐ huílai.	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
991	这个计划很好，	それはいい計画ね，	意見を言う	Zhège jìhuà hěn hǎo,	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1029	当然是足球了。	当然サッカーだね。		Dāngrán shì zúqiú le.	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
992	既可以学习日语，又能了解日本。	日本語も勉強できるし，日本のこともわかるわね。	理由を述べる	jì kěyǐ xuéxí Rìyǔ, yòu néng liǎojiě Rìběn.	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
993	你跟我不一样，	あなたは僕と違って	比べて述べる（比較と最上級）	Nǐ gēn wǒ bù yíyàng,	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
995	毕业后有什么打算？	卒業したらどうするつもりですか？	予定を言う	bìyè hòu yǒu shénme dǎsuan?	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
996	我已经决定报考硕士研究生了，	すでに修士を受験することに決めてるの，	予定を言う	Wǒ yǐjing juédìng bàokǎo shuòshì yánjiūshēng le,	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
997	读完硕士再读博士。	修士が終わったら博士に進学するわ。	手順と順序について述べる	dúwán shuòshì zài dú bóshì.	\N	dmod	zh21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
999	你好，	やあ，	挨拶をする	Nǐ hǎo,	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1000	好久不见了。	お久しぶり。	挨拶をする	hǎo jiǔ bú jiàn le.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1001	最近怎么样？	最近どう。	どうしているかをたずねる	Zuìjìn zěnmeyàng?	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1002	还可以，	まあまあだね。		Hái kěyǐ,	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1003	你呢？	君は。	どうしているかをたずねる	nǐ ne?	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1004	还行。	まあまあね。		Hái xíng.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1005	对了，	そういえば，	注意をひく	Duì le,	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1006	你弟弟现在干什么呢？	あなたの弟さんどうしてるの。	どうしているかをたずねる	nǐ dìdi xiànzài gàn shénme ne?	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
1007	他现在已经是高中生了。	今高校生になったんだよ。		Tā xiànzài yǐjing shì gāozhōngshēng le.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1008	你姐姐好吗？	君のお姉さん元気？	どうしているかをたずねる	Nǐ jiějie hǎo ma?	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1009	挺好的，	元気よ。		Tǐng hǎo de,	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1010	她最近结婚了。	最近結婚したの。		tā zuìjìn jiéhūn le.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1011	是吗？	そうなの，		shì ma?	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1012	太好了。	それは良かったね。		Tài hǎo le.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1013	恭喜，恭喜。	おめでとう。		Gōngxǐ, gōngxǐ.	\N	dmod	zh22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	1
1014	你日语说得真好。	あなたの日本語ってほんとに上手よね。		Nǐ Rìyǔ shuō de zhēn hǎo.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1015	要是只听你说话，还以为你是日本人呢。	あなたが話すのだけ聞いていたら，日本人だと思ってしまうわ。		Yàoshi zhǐ tīng nǐ shuō huà, hái yǐwéi nǐ shì Rìběnrén ne.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1016	过奖，过奖，	誉めすぎですよ，誉めすぎ。		Guòjiǎng, guòjiǎng,	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1017	还差得远呢。	まだ下手です。		hái chà de yuǎn ne.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1018	你觉得日语难学吗？	日本語は難しいと思う？	情報を求める（属性）	Nǐ juéde Rìyǔ nán xué ma?	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1019	总的来说，日语不难学。	全般的に言って，難しくないです。	意見を言う	Zǒngde lái shuō, Rìyǔ bù nán xué.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1020	汉字的音读和训读难吧？	漢字の音読みと訓読みは難しいでしょう？	情報を求める（属性）	Hànzì de yīndú hé xùndú nán ba?	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1021	音读、训读是难。	音読み，訓読みは確かに難しいです。	意見を言う	Yīndú、xùndú shì nán.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1022	不过，要是学的时间长了，就会觉得越来越有意思。	でも，長く学んだら，だんだんと面白くなります。		Búguò, yàoshi xué de shíjiān cháng le, jiù huì juéde yùe lái yuè yǒu yìsi.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1023	要想真正学好一门外语，必须同时把文字学好。	本当にきちんと一つの外国語を学ぼうと思うなら，同時に文字もきちんと学ばなければなりませんね。	ある条件での行動を言う	Yào xiǎng zhēnzhèng xuéhǎo yì ménr wàiyǔ, bìxū tóngshí bǎ wénzì xuéhǎo.	\N	dmod	zh23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1024	昨天你看足球比赛了吗？	昨日サッカーの試合見た？	情報を求める（経験）	Zuótiān nǐ kàn zúqiú bǐsài le ma?	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1025	没看。	見てないわ。		Méi kàn.	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1026	你喜欢足球吗？	あなたサッカー好きなの？	好きな行動について述べる	Nǐ xǐhuan zúqiú ma?	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1027	挺喜欢的。	とても好きだよ。	嗜好について述べる（行動）	Tǐng xǐhuan de.	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1028	足球跟棒球比起来，你喜欢哪个？	サッカーと野球を比べたらどっちが好き？	比べて述べる（比較と最上級）	Zúqiú gēn bàngqiú bǐ qilai, nǐ xǐhuan nǎ ge?	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1238	他是大夫。	彼は医者です。\n	\N		\N	vmod	\N	\N	\N	0	1
1030	你觉得哪个有意思？	君はどっちが面白いと思う？	比べる	Nǐ juéde nǎge yǒu yìsi?	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1031	我觉得棒球比足球有意思。	野球のほうがサッカーより面白いわね。	比べて述べる（比較と最上級）	Wǒ juéde bàngqiú bǐ zúqiú yǒu yìsi.	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1032	你最喜欢什么运动？	一番好きなスポーツは何？	比べる	Nǐ zuì xǐhuan shénme yùndong?	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1033	网球。	テニスよ。		Wǎngqiú.	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1034	我觉得网球比什么运动都有意思。	どのスポーツよりもテニスの方が面白いわ。	比べて述べる（比較と最上級）	Wǒ juéde wǎngqiú bǐ shénme yùndòng dōu yǒu yìsi.	\N	dmod	zh24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1035	徐强的生日晚会是今天晚上吧？	徐強の誕生パーティって今晩よね。	情報を求める（時間）	Xú Qiáng de shēngri wǎnhuì shì jīntiān wǎnshang ba?	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1036	糟糕！	しまった！		Zāogāo!	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1037	我还没准备好礼物呢。	僕まだプレゼント準備してないよ。		Wǒ hái méi zhǔnbèi hǎo lǐwù ne.	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1038	你说，给他买什么好呢？	ねえ，彼に何を買ってあげたらいいかな？		Nǐ shuō, gěi tā mǎi shénme hǎo ne?	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1039	你给他买一张古典音乐ＣＤ盘，怎么样？	クラシック音楽のＣＤを１枚買ってあげたらどう。	提案する	Nǐ gěi tā mǎi yì zhāng gǔdiǎn yīnyuè CD pán, zěnmeyàng?	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1040	他有ＣＤ的随身听吗？	彼ＣＤウォークマン持っているかな？	情報を求める（存在と場所）	Tā yǒu CD de suíshēntīng ma?	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1041	他有。	彼は持っているよ。		Tā yǒu.	\N	dmod	zh25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1042	你好。	やあ。	挨拶をする	Nǐ hǎo.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1043	你好。	こんにちは。	挨拶をする	Nǐ hǎo.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1044	你怎么好几天不来上课呀?	なんで何日も授業にこなかったの？		Nǐ zěnme hǎo jǐ tiān bù lái shàng kè ya?	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1046	是吗？	そうなの。		Shì ma?	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1047	现在身体怎么样了？	今は体の調子どう。	どうしているかをたずねる	Xiànzài shēntǐ zěnmeyàng le?	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1048	好多了。	ずっと良くなったよ。		Hǎoduō le.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1049	对了，	そうだ，	注意をひく	Duì le,	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1050	下星期三我去不了了。	次の水曜日，僕行けなくなったんだ。		xià xīngqī sān wǒ qùbuliǎo le.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
1051	为什么？	どうして。		Wèishénme?	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1052	因为我要去医院。	病院に行かなければいけないんだ。	理由を述べる	Yīnwèi wǒ yào qù yīyuàn.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1053	好的。	分かったわ。		Hǎo de.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1054	那改天吧。	じゃまたにしましょう。	予定を言う	Nà gǎitiān ba.	\N	dmod	zh26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1055	我来申请签证。	ビザ申請に来たのですが。		Wǒ lái shēnqǐng qiānzhèng.	\N	dmod	zh27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1056	请您填张表。	表に記入して下さい。	依頼する	Qǐng nín tián zhāng biǎo.	\N	dmod	zh27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1057	我没带笔，	書くもの持っていないんです，		Wǒ méi dài bǐ,	\N	dmod	zh27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1058	能不能借给我一枝笔？	ペンを１本貸して下さいませんか。	依頼する	néng bu néng jiègěi wǒ yì zhī bǐ?	\N	dmod	zh27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1059	好的。	はい。		Hǎo de.	\N	dmod	zh27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1060	请您在这儿签个字。	ここにサインして下さい。	依頼する	Qǐng nín zài zhèr qiān ge zì.	\N	dmod	zh27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1061	你吃过日本菜吗？	君日本料理食べたことある？	情報を求める（経験）	Nǐ chīguo Rìběn cài ma?	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1062	吃过。	あるわ。		Chīguo.	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1063	吃过什么？	何食べたの。	情報を求める（経験）	Chīguo shénme?	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1064	比如生鱼片、寿司、荞麦面等等。	例えば刺身，寿司，蕎麦等ね。	例をあげて述べる	Bǐrú shēngyúpiàn、shòusi、qiáomàimiàn děngděng.	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1065	你吃过吗？	あなたは食べたことある？	情報を求める（経験）	Nǐ chīguo ma?	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1066	没有。	ないね。		Méiyou.	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1067	我吃过韩国菜。	韓国料理は食べたことあるけどね。		Wǒ chīguo Hánguó cài.	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1068	你吃过什么？	どんなものを食べたの。	情報を求める（経験）	Nǐ chīguo shénme?	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1069	拌饭、泡菜、参鸡汤什么的。	ビビンバ，キムチ，サンゲタン等だね。	例をあげて述べる	Bànfàn、pàocài、shēnjītāng shénme de.	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1070	我也想尝尝。	私も食べてみたいな。	希望を述べる	Wǒ yě xiǎng chángchang.	\N	dmod	zh28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1071	昨天的足球比赛你看了吗？	昨日のサッカーの試合見た？	情報を求める（経験）	Zuótiān de zúqiú bǐsài nǐ kànle ma?	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1072	没有。	いいえ。		Méiyou.	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1073	我去机场接朋友了。	空港に友達を迎えに行ってましたから。	理由を述べる	Wǒ qù jīchǎng jiē péngyou le.	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1074	这场比赛没看，太遗憾了！	あの試合を見なかったとは残念だわ！		Zhè chǎng bǐsài méi kàn, tài yíhàn le!	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1075	双方踢得都很精彩。	両チームともすばらしかったわ。	意見を言う	Shuāngfāng tī de dōu hěn jīngcǎi.	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1076	没办法，	仕方ありません，	妥協する	Méi bànfǎ,	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1077	我不能不去接朋友，	友達を迎えに行かざるを得ませんでした，	妥協する	wǒ bù néng bú qù jiē péngyou,	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1078	在这儿他只认识我。	ここでの彼の知り合いは僕だけですからね。	理由を述べる	zài zhèr tā zhǐ rènshi wǒ.	\N	dmod	zh29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
1079	小张，我想求你一件事。	張さん，一つお願いがあるのだけど。	依頼する	Xiǎo Zhāng, wǒ xiǎng qiú nǐ yí jiàn shìr.	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1080	什么事？	何。		Shénme shìr?	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1081	我想借一下你的日语参考书，	君の日本語の参考書をちょっと借りたいのだけど，	依頼する	Wǒ xiǎng jiè yíxiàr nǐ de Rìyǔ cānkǎoshū,	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1082	可以吗？	いいかな。	許可を求める	kěyǐ ma?	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1083	现在不行，	今は無理ね。		Xiànzài bù xíng,	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1084	要先借给别人，	先に他の人に貸すことになってるの。	手順と順序について述べる	yào xiān jiègěi biéren,	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1085	然后再借给你，好吗？	その後であなたに貸してあげるわ。	手順と順序について述べる	ránhòu zài jiègěi nǐ, hǎo ma?	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
1086	好的，	わかった，		Hǎo de,	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1087	谢谢。	ありがとう。	感謝する	xièxie.	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1088	那么以后你再跟我联系吧。	じゃ，また連絡ちょうだい。	指示する	Nàme yǐhòu nǐ zài gēn wǒ liánxì ba.	\N	dmod	zh30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1089	我借这本书。	この本を借ります。		Wǒ jiè zhèi běnr shū.	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1090	还有别的书要借吗？	他に借りたい本はありますか？		Hái yǒu biéde shū yào jiè ma?	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1091	没有。	ありません。		Méiyou.	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1092	带借书证了吗？	貸出証持って来ましたか？	情報を求める（存在と場所）	Dài jièshūzhèng le ma?	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1093	带了，	はい，		Dài le,	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1094	给您。	これです。		gěi nín.	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1095	这本书必须在二十号以前还给图书馆。	この本は２０日までに図書館に返さなくてはなりません。	義務を確認する/肯定する	Zhè běn shū bìxū zài èrshi hào yǐqián huángěi túshūguǎn.	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1096	知道了。	わかりました。	義務を確認する/肯定する	Zhīdao le.	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1097	还书的时候，要不要带借书证？	返却の際，貸出証は必要ですか？	義務を確認する/肯定する	Huán shū de shíhour, yào bu yào dài jièshūzhèngr?	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1098	要。	必要です。	義務を確認する/肯定する	Yào.	\N	dmod	zh31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1099	你又迟到了。	君また遅刻ね。		Nǐ yòu chídào le.	\N	dmod	zh32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1100	对不起。	すみません。	あやまる	Duìbuqǐ.	\N	dmod	zh32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1101	你为什么迟到？	なぜ遅れたの。		Nǐ wèishénme chídào?	\N	dmod	zh32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1102	我起晚了。	寝坊しまして。	理由を述べる	Wǒ qǐwǎn le.	\N	dmod	zh32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1103	下次不要再迟到了。	今度は遅刻しないでね。	禁止する	Xià cì bú yào zài chídào le.	\N	dmod	zh32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1104	明白了。	分かりました。	義務を確認する/肯定する	Míngbai le.	\N	dmod	zh32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1105	下午给你打电话，	午後君に電話したけど，		Xiàwǔ gěi nǐ dǎ diànhuà,	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1106	你不在。	君いなかった。		nǐ bú zài.	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1107	我去超市买东西了。	スーパーに買い物に行ってたの。		Wǒ qù chāoshì mǎi dōngxi le.	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1108	你找我有事吗？	私に何か用かしら？		Nǐ zhǎo wǒ yǒu shìr ma?	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1109	系主任通知，	学科主任からの連絡で，		Xìzhǔrèn tōngzhī,	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1110	要你明天下午参加一个会。	君に明日会議に参加するようにって。	指示する	yào nǐ míngtiān xiàwǔ cānjiā yí ge huì.	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1111	好的。	はい。	義務を確認する/肯定する	Hǎo de.	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1112	还有一件事，	それにもう一つ，	注意をひく	Hái yǒu yí jiàn shì,	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1113	马老师让我通知你，	馬先生からの連絡で，		Mǎ lǎoshī ràng wǒ tōngzhī nǐ,	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1114	后天上午十点参加口试。	あさって午前１０時口述試験を受けるようにって。	指示する	hòutiān shàngwǔ shí diǎn cānjiā kǒushì.	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
1115	知道了，	わかったわ，	義務を確認する/肯定する	Zhīdào le,	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1116	谢谢你。	ありがとう。	感謝する	xièxie nǐ.	\N	dmod	zh33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1117	这个周末可以去找你吗？	今度の週末君の家行ってもいい？	許可を求める	Zhèige zhōumò kěyǐ qù zhǎo nǐ ma?	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1118	可以，	いいけど，		Kěyǐ,	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1119	你什么时候来？	いつごろ来る。	予定を言う	Nǐ shénmé shihou lái?	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1120	星期六可以吗？	土曜日いい？	許可を求める	Xīngqī liù kěyǐ ma?	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1121	可以，	いいけど，		Kěyǐ,	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1122	可是你最好不要上午来。	午前中は遠慮して。	非行為を依頼する	kěshì nǐ zuì hǎo bú yào shàngwǔ lái.	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1123	那么下午一点钟怎么样？	じゃ，午後１時位どう。	許可を求める	Nàme xiàwǔ yì diǎn zhōng zěnmeyàng?	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1124	好，	いいわよ。		Hǎo,	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1125	那就这样吧。	じゃそういうことで。	義務を確認する/肯定する	nà jiù zhèyàng ba.	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1126	再见。	さよなら。	さよならを言う	Zàijiàn.	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1127	再见。	さよなら。	さよならを言う	Zàijiàn.	\N	dmod	zh34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1128	上哪儿啊？	どこ行くの？	情報を求める（存在と場所）	Shàng nǎr a?	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1129	去邮局取行李。	郵便局に荷物を取りに行くの。		Qù yóujú qǔ xíngli.	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1130	大概是妈妈寄给我的。	たぶん母が送ってくれたものよ。		dàgài shì māma jìgěi wǒ de.	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1131	我陪你去吧。	僕，一緒に行くよ。	提案する	Wǒ péi nǐ qù ba.	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1132	谢谢，	ありがとう，	感謝する	Xièxie,	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1133	不用了。	でもいいわ。	義務を確認する/否定する	bú yòng le.	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1134	会不会很重？	とても重いでしょうかね？	情報を求める（属性）	Huì bu huì hěn zhòng?	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1135	需要我帮忙吗？	僕の助けが必要ですか？	義務を確認する/否定する	Xūyào wǒ bāngmáng ma?	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1136	不会吧，	そんな重くないでしょう，		Bú huì ba,	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1137	不用了。	大丈夫だと思うわ。	しなくともよいと言う	bú yòng le.	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1138	谢谢。	ありがとう。	感謝する	Xièxie.	\N	dmod	zh35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	1
1139	李强。	李強君。	挨拶をする	Lǐ Qiáng.	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1140	老师，您好。	先生，こんにちは。	挨拶をする	Lǎoshī, Nín hǎo.	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1141	你下星期六有时间吗？	君今度の土曜日あいていますか？	予定を述べる	Nǐ xià xīngqī liù yǒu shíjiān ma?	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1142	有。	あります。	予定を言う	Yǒu.	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1143	那么你来我家吃饭怎么样？	だったら私の所にご飯を食べに来ませんか。	招待する	Nàme nǐ lái wǒ jiā chī fàn zěnmeyàng?	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1144	谢谢，	ありがとうございます。	感謝する	Xièxie,	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1145	我几点去好呢？	何時にお伺いしたらいいですか。	予定を言う	wǒ jǐ diǎn qù hǎo ne?	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1146	六点钟来吧。	６時に来なさい。	招待する	Liù diǎn zhōng lái ba.	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1148	再见。	さようなら。	さよならを言う	zàijiàn.	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1149	再见。	さようなら。	さよならを言う	Zàijiàn.	\N	dmod	zh36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1150	这么好的天气，	こんなにいい天気だっていうのに，		Zhème hǎo de tiānqì,	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1151	呆在房间里干什么，	部屋にこもって何してるんだい？		dāizài fángjiān li gàn shénme,	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
1152	你不出去吗？	出かけないのかい？		nǐ bù chūqu ma?	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
1153	你说，什么地方最好玩儿呢？	じゃああなたどこが面白いと思う。	情報を求める（属性）	Nǐ shuō, shénme dìfang zuì hǎowánr ne?	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1154	当然是十渡啦，	もちろん十渡さ，		Dāngrán shì Shídù le,	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1155	怎么样，	どう，		zěnmeyàng,	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1156	想去十渡玩儿吗？	十渡に遊びに行きたいかい？	提案する	xiǎng qù Shídù wánr ma?	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
1157	好啊。	いいわ。		Hǎo a.	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1158	哎，什么时候出发呀？	ねえ，いつ出発する？	予定を言う	Ai, shénme shíhou chūfā ya?	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1159	我呆会儿去接你。	ちょっとしたら迎えに行くよ。	手順と順序について述べる	Wǒ dāi huǐr qù jiē nǐ.	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1160	别忘了带上照相机。	カメラ持って行くの忘れるなよ。	助言する	Bié wàngle dàishang zhàoxiàngjī.	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1161	你还应该准备点儿吃的。	それから食べるものも少し準備しなきゃ駄目だよ。	助言する	Nǐ hái yīnggāi zhǔnbèi diǎnr chī de.	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
1162	王刚，把你的雨伞带上吧。	王君，傘持つようにね。	助言する	Wáng Gāng, bǎ nǐ de yǔsǎn dàishang ba.	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1163	天气预报说，今天晚上有小雨。	天気予報で今夜小雨が降るって言ってたから。		Tiānqì yùbào shuō, jīntiān wǎngshang yǒu xiǎoyǔ.	\N	dmod	zh37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1164	今天晚上我想请你帮个忙。	今日の夜助けてほしいのだけど。	要求する	Jīntiān wǎnshang wǒ xiǎng qǐng nǐ bāng ge máng.	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1165	怎么了？	どうしたの。		zěnme le?	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1166	我的电脑坏了，	パソコンが壊れてしまって。		Wǒ de diànnǎo huài le,	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1167	你可以给看一看吗？	ちょっと見てくれる。	依頼する	nǐ kěyǐ gěi kàn yi kan ma?	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1168	好的。	いいよ。		Hǎo de.	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1169	是台式机还是笔记本？	デスクトップそれともノート。	情報を求める（属性）	Shì táishìjī háishi bǐjìběnr?	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
1170	是笔记本。	ノートよ。		Shì bǐjìběnr.	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1171	那么，七点左右你来我房间的时候，把它带来吧。	じゃ，７時頃僕の部屋に来るとき，持って来て。	指示する	Nàme, qī diǎn zuǒyòu nǐ lái wǒ fángjiān de shíhour, bǎ tā dàilai ba.	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1172	好，	分かった。		Hǎo,	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1173	一会儿见。	それじゃ。	さよならを言う	yíhuìr jiàn.	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1174	一会儿见。	また。	さよならを言う	Yíhuìrjian.	\N	dmod	zh38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1175	昨天我去一家计算机公司面试了。	昨日私，コンピューター会社の面接に行ったの。		Zuótiān wǒ qù yì jiā jìsuànjī gōngsī miànshì le.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1176	面试的情况怎么样？	面接試験はどうでしたか？	情報を求める（経験）	Miànshì de qíngkuàng zěnmeyàng?	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1177	负责面试的是两位日本男青年。	私に面接したのは２人の若い日本人の男の人だったの。		Fùzé miànshì de shì liǎng wèi Rìběn nán qīngnián.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1178	他们让我把汉语译成日语。	彼らは私に中国語を日本語に訳させたわ。	要求する	Tāmen ràng wǒ bǎ Hànyǔ yìchéng Rìyǔ.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1179	你翻译得怎么样？	翻訳はどうでしたか？	情報を求める（経験）	Nǐ fānyì de zěnmeyàng?	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1180	除了几个技术方面的词以外，我觉得翻译得还可以。	いくつかの技術関連の単語以外はまずまずだったわ。		Chúle jǐ ge jìshù fāngmiàn de cí yǐwài, wǒ juéde fānyì de hái kěyǐ.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1181	他们是怎么说的？	彼らは何と言ってましたか？	情報を求める（経験）	Tāmen shì zěnme shuō de?	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1182	他们说，希望我能接受他们的聘请，到他们公司工作。	彼らが言うには，私が要請を受けて，この会社に仕事に来て欲しいそうよ。	希望を述べる	Tāmen shuō, xīwàng wǒ néng jiēshòu tāmen de pìnqǐng, dào tāmen gōngsī gōngzuò.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1239	这条裙子太短了。	このスカートは短すぎる。\n	\N		\N	vmod	\N	\N	\N	0	1
1183	他们还说下个月会通知我的。	それから，来月には通知して下さるって。		Tāmen hái shuō xià ge yuè huì tōngzhī wǒ de.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
1184	你以前不是说，毕业后要考研究生吗？	あなた以前，卒業したら大学院を受験すると言っていませんでしたか？		Nǐ yǐqián bú shì shuō, bìyè yǐhòu yào kǎo yánjiūshēng ma?	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1185	我本来希望能有机会继续学日语。	私，もともとは日本語を勉強しつづける機会があるよう希望していたの。	希望を述べる	Wǒ běnlái xīwàng néng yǒu jīhuì jìxù xué Rìyǔ.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1186	最近我的想法变了，	最近考え方が変わってね，		Zuìjìn wǒ de xiǎngfa biàn le,	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
1187	我想先工作一段时间，在社会上体验体验，再考研究生，	まず一定期間仕事をして，社会を体験したうえで大学院を受験すれば，	手順と順序について述べる	Wǒ xiǎng xiān gōngzuò yí duàn shíjiān, zài shèhuì shang tǐyàn tǐyàn, zài kǎo yánjiūshēng,	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
1188	这样有利于开阔眼界，进行研究。	視野が広がって，研究活動を行うのに有利だと思うの。	理由を述べる	zhèyàng yǒulìyú kāikuò yǎnjiè, jìnxíng yánjiū.	\N	dmod	zh39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[4]	\N	\N	1
1189	你好。	元気？	挨拶をする	Nǐ hǎo.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
1190	你好。	ええ。	挨拶をする	Nǐ hǎo.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
1191	我来介绍一下。	ちょっと紹介するわ。	人を紹介する	Wǒ lái jièshào yíxià.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
1192	这是张明。	こちら張明。	人を紹介する	Zhè shì Zhāng Míng.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
1193	你好，	こんにちは，	挨拶をする	Nǐ hǎo,	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
1194	我是张明。	張明です。	自己紹介する	wǒ shì Zhāng Míng.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
1195	这是王晶。	こちらは，王晶。	人を紹介する	Zhè shì Wáng Jīng.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
1196	我是王晶。	王晶です。	自己紹介する	Wǒ shì Wáng Jīng.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
1197	你是哪儿的人？	ご出身はどちらですか。	情報を求める（属性）	Nǐ shì nǎr de rén?	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
1198	黑龙江人。	黒龍江です。	自己紹介する	Hēilóngjiāng rén.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
1199	你呢？	あなたは？	情報を求める（属性）	Nǐ ne?	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
1200	山西人。	山西省です。	自己紹介する	Shānxī rén.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
1201	都中午了，	もうお昼ね，		Dōu zhōngwǔ le,	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
1202	咱们三个人一起吃饭吧。	３人で一緒に食事しませんか。	提案する	zánmen sān ge rén yìqǐ chī fàn ba.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
1203	可以啊。	いいですよ。		Kěyǐ a.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
1204	好啊。	そうしましょう。		Hǎo a.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
1205	那咱们走吧。	じゃ，行きましょう。	提案する	Nà zánmen zǒu ba.	\N	dmod	zh40.xml	/dmodule[1]/body[1]/dialogue[1]/line[11]/sentence[1]	\N	\N	1
1206	你的姥姥身体好吗?	あなたの(母方の)おばあさんはおたっしゃですか?	\N		\N	vmod	\N	\N	\N	0	1
1207	因为屋子太暗,安了扇窗户。	部屋が暗いので窓を付けた。\n	\N		\N	vmod	\N	\N	\N	0	1
1209	你把杯子拿过来。	コップ持ってきて。	\N		\N	vmod	\N	\N	\N	0	1
1210	你把杯子拿过来。	そのカップ取ってきて。	\N		\N	vmod	\N	\N	\N	0	1
1211	她穿着一身白色的衣服。	彼女は全身白の服を着ている。	\N		\N	vmod	\N	\N	\N	0	1
1212	他是我伯父。	彼は私の伯父です。	\N		\N	vmod	\N	\N	\N	0	1
1213	他打白天就一直喝酒。	彼は昼間っから酒を飲んでる。	\N		\N	vmod	\N	\N	\N	0	1
1214	她穿的衣服太薄了。	彼女の服は薄すぎる。	\N		\N	vmod	\N	\N	\N	0	1
1215	别抠鼻子。	鼻くそをほじるんじゃない。	\N		\N	vmod	\N	\N	\N	0	1
1216	我到百货公司去买东西。	私はデパートへ買い物に行く。	\N		\N	vmod	\N	\N	\N	0	1
1217	把包裹寄给他。	小包を彼に送る。	\N		\N	vmod	\N	\N	\N	0	1
1219	她昨天傍晚才回来。	彼女は昨日夕方になってから帰ってきた。	\N		\N	vmod	\N	\N	\N	0	1
1220	剧场北边儿有一个家具店。	劇場の北側には家具屋がある。	\N		\N	vmod	\N	\N	\N	0	1
1221	冰箱里有一瓶冰的啤酒。	冷蔵庫に冷えたビールが一本有る。	\N		\N	vmod	\N	\N	\N	0	1
1222	谢谢。别客气。	ありがとう。どういたしまして。	\N		\N	vmod	\N	\N	\N	0	1
1223	我家订了三份报纸。	私の家では新聞を三紙取っている。	\N		\N	vmod	\N	\N	\N	0	1
1224	西方人用叉子吃饭。	西洋人はフォークで食事をする。	\N		\N	vmod	\N	\N	\N	0	1
1225	用橡皮擦掉。	消しゴムで消す。	\N		\N	vmod	\N	\N	\N	0	1
1226	在餐厅吃饭。	レストランで食事をする。\n	\N		\N	vmod	\N	\N	\N	0	1
1227	出口在哪儿?	出口はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
1228	她唱歌儿唱得很好听。	彼女は歌を歌うのが上手だ。	\N		\N	vmod	\N	\N	\N	0	1
1229	把唱片儿放在唱机上。	プレイヤーにレコードをかける。\n	\N		\N	vmod	\N	\N	\N	0	1
1230	在厨房做菜。	台所で料理を作る。\n	\N		\N	vmod	\N	\N	\N	0	1
1231	成年人才可以看这种录像带。	大人だけがこの種のビデオを見れる。\n	\N		\N	vmod	\N	\N	\N	0	1
1505	国力很强。	国力が強い。	\N		\N	vmod	\N	\N	\N	0	1
1242	发烧都三十八度了。	３８度も熱がある。\n	\N		\N	vmod	\N	\N	\N	0	1
1243	冬天到了。	冬になった。\n	\N		\N	vmod	\N	\N	\N	0	1
1244	这把刀子真快。	このナイフは本当によく切れる。\n	\N		\N	vmod	\N	\N	\N	0	1
1245	肚子疼得厉害。	お腹がすごく痛い。\n	\N		\N	vmod	\N	\N	\N	0	1
1246	学校东边儿有一家饭馆。	学校の東側に料理屋が一軒ある。\n\n	\N		\N	vmod	\N	\N	\N	0	1
1247	他耳朵很尖。	彼は地獄耳だ。\n	\N		\N	vmod	\N	\N	\N	0	1
1248	今天二月一号。	今日は二月一日だ。	\N		\N	vmod	\N	\N	\N	0	1
1249	夫妻关系很好。	夫婦の仲がいい。\n	\N		\N	vmod	\N	\N	\N	0	1
1250	你父母好吗？	ご両親は元気ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1251	您父亲好吗？	お父様は元気ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1252	天晴了。	空が晴れた。	\N		\N	vmod	\N	\N	\N	0	1
1253	到北京游玩时，在北京饭店住了三天。\n	北京に遊びに行ったとき、北京飯店に三日間泊まった。	\N		\N	vmod	\N	\N	\N	0	1
1254	感冒了。	風邪をひいた。\n	\N		\N	vmod	\N	\N	\N	0	1
1255	光亮的颜色。	明るい色。	\N		\N	vmod	\N	\N	\N	0	1
1256	他坐公共汽车上班儿。	彼はバスで出勤する。\n	\N		\N	vmod	\N	\N	\N	0	1
1257	我们公寓是三室一厅的。	私たちのアパートは３LDKです。\n	\N		\N	vmod	\N	\N	\N	0	1
1258	他爸爸是国家干部。	彼のお父さんは国家幹部だ。	\N		\N	vmod	\N	\N	\N	0	1
1259	把门关上。	ドアを閉めて。\n	\N		\N	vmod	\N	\N	\N	0	1
1260	我做的咖哩饭怎么样？\n	わたしが作ったカレーどう？\n	\N		\N	vmod	\N	\N	\N	0	1
1261	胳膊酸了。	腕が痛くなった。\n	\N		\N	vmod	\N	\N	\N	0	1
1262	这枝钢笔很好写。	この万年筆は書きやすい。\n	\N		\N	vmod	\N	\N	\N	0	1
1263	别横着放。	横にして置くな。\n	\N		\N	vmod	\N	\N	\N	0	1
1264	别看黄色小说儿。	エロ小説を読むな。\n	\N		\N	vmod	\N	\N	\N	0	1
1265	他每天早上都吃黄油面包。	彼は毎朝バターを付けたパンを食べる。\n	\N		\N	vmod	\N	\N	\N	0	1
1266	他画儿画的不好。	彼は絵がへただ。\n	\N		\N	vmod	\N	\N	\N	0	1
1267	她昨天晚上没回家。	彼女は昨日の晩家に帰らなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
1268	回答正确！	正解！\n	\N		\N	vmod	\N	\N	\N	0	1
1269	我打算后年去中国留学去。\n	私は再来年中国に留学に行く予定だ。\n	\N		\N	vmod	\N	\N	\N	0	1
1270	请再把后面的头发剪短一点儿。	もう少し後ろ髪を短くしてください。\n	\N		\N	vmod	\N	\N	\N	0	1
1271	你做的菜好吃极了。	君の料理は最高だよ。\n	\N		\N	vmod	\N	\N	\N	0	1
1272	今天是黑色星期五。	今日は１３日の金曜日だ。\n	\N		\N	vmod	\N	\N	\N	0	1
1273	带着红色彩条的是翻译人员。\n	赤いリボンを付けている者が通訳です。\n	\N		\N	vmod	\N	\N	\N	0	1
1274	我爱喝红茶。	私は紅茶が好きです。	\N		\N	vmod	\N	\N	\N	0	1
1275	加点儿水。	水を加える。	\N		\N	vmod	\N	\N	\N	0	1
1276	向您家人问好。	ご家族によろしくお伝えください。	\N		\N	vmod	\N	\N	\N	0	1
1277	女性的成功在于家庭。	女性の成功は家庭にあり。\n	\N		\N	vmod	\N	\N	\N	0	1
1278	他不会弹吉他。\n	彼はギターを弾けない。	\N		\N	vmod	\N	\N	\N	0	1
1279	他腿太短。	彼は短足だ。	\N		\N	vmod	\N	\N	\N	0	1
1280	这件衣服太旧了。	この服は古すぎる。\n	\N		\N	vmod	\N	\N	\N	0	1
1281	我家离学校很近。	私の家は学校から近い。\n	\N		\N	vmod	\N	\N	\N	0	1
1282	农历九月九日是重阳节。	旧暦の9月9日は重陽の節句です。\n	\N		\N	vmod	\N	\N	\N	0	1
1283	每天早上我爱人都给我系领带。\n	毎朝妻はネクタイを結んでくれる。\n	\N		\N	vmod	\N	\N	\N	0	1
1284	前面儿的建筑物是什么呢?	前の建物は何ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1285	他交给我一本书。\n	彼は私にある本を渡した。\n	\N		\N	vmod	\N	\N	\N	0	1
1286	你妹妹今年多大了?	妹さん今年何歳ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1287	我一点儿精神都没有。	私は全く元気がないです。\n	\N		\N	vmod	\N	\N	\N	0	1
1288	我打算今年暑假去中国旅行。	私は今年の夏休みに中国へ旅行に行くつもりです。	\N		\N	vmod	\N	\N	\N	0	1
1289	请再把前面的头发剪短一点儿。\n	もう少し前髪を短くしてください。	\N		\N	vmod	\N	\N	\N	0	1
1290	把胶卷装到相机里。	カメラにフイルムを入れる。\n	\N		\N	vmod	\N	\N	\N	0	1
1291	咱们打的去吧。	俺たちタクシーで行こう。\n	\N		\N	vmod	\N	\N	\N	0	1
1292	加点儿酱油。	醤油を少々加えます。\n	\N		\N	vmod	\N	\N	\N	0	1
1293	我爱吃肌肉。	私は鶏肉が好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
1294	他从口袋里掏出钱来。	彼はポケットから金を出した。\n	\N		\N	vmod	\N	\N	\N	0	1
1295	前面有一家咖啡厅。	前に喫茶店がある。\n	\N		\N	vmod	\N	\N	\N	0	1
1296	这条河有多宽?	この川の幅はどれくらいですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1297	中国人一般用筷子吃饭。\n	中国人は普通箸で食事をする。\n	\N		\N	vmod	\N	\N	\N	0	1
1298	这裤子有点儿肥。	このズボンは少しゆるい。\n	\N		\N	vmod	\N	\N	\N	0	1
1299	那间屋子很明亮。\n	あの部屋はとても明るい。\n	\N		\N	vmod	\N	\N	\N	0	1
1300	她正在洗淋浴。	彼女はシャワーを浴びているところだ。\n	\N		\N	vmod	\N	\N	\N	0	1
1301	生炉子。	ストーブに火をつける。\n	\N		\N	vmod	\N	\N	\N	0	1
1302	走到十字路口,往右拐,就是车站。	交差点を右に曲がると駅です。\n	\N		\N	vmod	\N	\N	\N	0	1
1303	我住在八楼,他住在九楼。	私は8階、彼は9階に住んでいる。\n	\N		\N	vmod	\N	\N	\N	0	1
1304	楼梯在哪儿?	階段はどこですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1305	叫我爷爷!	おじいさんと呼びなさい！（罵り言葉）	\N		\N	vmod	\N	\N	\N	0	1
1306	他终于娶了个老婆。\n	彼はようやく奥さんをもらった。\n	\N		\N	vmod	\N	\N	\N	0	1
1307	今天六月一号国际儿童节。\n	今日は6月1日国際児童デーだ。\n	\N		\N	vmod	\N	\N	\N	0	1
1308	咱俩聊聊天儿吧。		\N		\N	vmod	\N	\N	\N	0	1
1309	你要是有空,到我家来玩儿玩儿,咱们聊聊天。	ヒマあったら、うちに遊びに来てよ、おしゃべりしよう。	\N		\N	vmod	\N	\N	\N	0	1
1310	这个菜辣死了。	この料理死ぬほど辛い。	\N		\N	vmod	\N	\N	\N	0	1
1311	录音机坏了。	テープレコーダーが壊れた。\n	\N		\N	vmod	\N	\N	\N	0	1
1312	他正在做练习。	彼は練習問題をしているところだ。\n	\N		\N	vmod	\N	\N	\N	0	1
1313	他戴着绿色的帽子。\n	彼は緑色の帽子をかぶっている。	\N		\N	vmod	\N	\N	\N	0	1
1314	她系着蓝色的领带。	彼女は青いネクタイをしている。\n	\N		\N	vmod	\N	\N	\N	0	1
1315	每天早上我爱人都给我系领带。	毎朝妻は私にネクタイをしてくれる。\n	\N		\N	vmod	\N	\N	\N	0	1
1316	她们姐妹都已经出嫁了。\n	あの姉妹はみなお嫁に行った。	\N		\N	vmod	\N	\N	\N	0	1
1317	我没有姐姐。	私には姉はいない。\n	\N		\N	vmod	\N	\N	\N	0	1
1318	他戴着绿色的帽子。	彼はグリーンの帽子をかぶっている。\n	\N		\N	vmod	\N	\N	\N	0	1
1319	开慢点儿,行吗?	ゆっくり運転してくれませんか？\n	\N		\N	vmod	\N	\N	\N	0	1
1320	他去邮局寄明信片了。\n	彼は郵便局にはがきを出しに行った。\n	\N		\N	vmod	\N	\N	\N	0	1
1321	他去菜铺买蔬菜了。	彼は八百屋に野菜を買いに行った。\n	\N		\N	vmod	\N	\N	\N	0	1
1322	我每个星期去一次中国。	私は毎週一回中国に行く。\n	\N		\N	vmod	\N	\N	\N	0	1
1323	我每年夏天都去中国旅行去。	私は毎年夏は中国に旅行へ行く。\n	\N		\N	vmod	\N	\N	\N	0	1
1324	每个月开两次会。\n	毎月２回会議を開く。\n	\N		\N	vmod	\N	\N	\N	0	1
1325	我特别爱吃牛肉。\n	私は牛肉がとても好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
1326	我想喝新鲜的牛奶。	新鮮な牛乳を飲みたいなぁ。\n	\N		\N	vmod	\N	\N	\N	0	1
1327	新来的老师是男的,还是女的?\n	新しく来た先生は男？女？\n	\N		\N	vmod	\N	\N	\N	0	1
1328	新来的老师是男的,还是女的?	新しく来た先生は男？女？	\N		\N	vmod	\N	\N	\N	0	1
1329	我不喜欢这么个男孩儿。	私そういう男の子は好きじゃないわ。	\N		\N	vmod	\N	\N	\N	0	1
1330	百货大楼南边儿有一个家具店。	デパートの南の方に家具屋が一軒ある。\n	\N		\N	vmod	\N	\N	\N	0	1
1331	你还年轻,不应该看这种书。	お前はまだ小さいのだから、この手の本を見るべきではない。\n	\N		\N	vmod	\N	\N	\N	0	1
1332	你的拿手菜是什么?	君の得意料理はなに？\n	\N		\N	vmod	\N	\N	\N	0	1
1333	她是我奶奶。		\N		\N	vmod	\N	\N	\N	0	1
1334	她是我奶奶。	彼女は私の祖母です。\n	\N		\N	vmod	\N	\N	\N	0	1
1335	红茶里放入一片柠檬。	紅茶にレモンを入れる。	\N		\N	vmod	\N	\N	\N	0	1
1336	这个菜难吃死了。\n	この料理は死ぬほどまずい。	\N		\N	vmod	\N	\N	\N	0	1
1337	他有时发脾气。\n	彼は時々キレる。\n	\N		\N	vmod	\N	\N	\N	0	1
1338	她有时发脾气。	彼女は時々キレる。\n	\N		\N	vmod	\N	\N	\N	0	1
1339	她有时发脾气。	彼女は時々かんしゃくを起こす\n。\n	\N		\N	vmod	\N	\N	\N	0	1
1340	派出所在哪儿?\n	交番はどこですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1341	我喜欢喝葡萄酒。	私は葡萄酒が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1342	日语有平假名和片假名。	日本語には平仮名と片仮名があります。\n	\N		\N	vmod	\N	\N	\N	0	1
1343	日语有平假名和片假名。	日本語には平仮名と片仮名があります。\n	\N		\N	vmod	\N	\N	\N	0	1
1344	请给我小碟子。	小皿をいただけますか。\n	\N		\N	vmod	\N	\N	\N	0	1
1345	我每天早上五点起床。\n	私は毎朝5時に起きます。\n	\N		\N	vmod	\N	\N	\N	0	1
1346	我去年毕的业。\n	私は去年卒業したのです。\n	\N		\N	vmod	\N	\N	\N	0	1
1347	这是我妻子。	こちらは妻です。\n	\N		\N	vmod	\N	\N	\N	0	1
1348	农历七月初七是七夕。	旧暦7月７日は七夕です。\n	\N		\N	vmod	\N	\N	\N	0	1
1349	明天是晴天。	明日は晴れです。\n	\N		\N	vmod	\N	\N	\N	0	1
1350	我们前年结的婚。	私たちが結婚したのはおととしです。\n	\N		\N	vmod	\N	\N	\N	0	1
1351	我们是前年结的婚。	私たちが結婚したのはおととしです。	\N		\N	vmod	\N	\N	\N	0	1
1352	房子前面有一棵树。	家に前に一本の木がある。	\N		\N	vmod	\N	\N	\N	0	1
1353	她穿着一条红色裙子。	彼女は赤い色のスカートをはいています。	\N		\N	vmod	\N	\N	\N	0	1
1354	据说四川是中国西部综合经济实力最强的省份。	四川は中国西部で総合経済力の最も強い省だそうです。\n	\N		\N	vmod	\N	\N	\N	0	1
1355	你先请。	お先にどうぞ。\n	\N		\N	vmod	\N	\N	\N	0	1
1356	她一个钱儿也不值。	彼女は一銭の値打ちもない。\n	\N		\N	vmod	\N	\N	\N	0	1
1357	请你把铅笔借给我用用,好吗?	その鉛筆貸していただけないでしょうか？\n	\N		\N	vmod	\N	\N	\N	0	1
1358	小王喜欢吃蔬菜, 小李喜欢吃肉。	王くんは野菜を食べるのが好きです、李くんは肉を食べるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
1359	我喜欢一边吃干酪,一边喝葡萄酒。	私はチーズとワインが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1360	车站入口在哪儿?	駅の入り口はどこですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1361	学汉语容易吗?	中国語は簡単ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1362	她病后身体软弱。	彼女は病気をしてから体が弱い。\n	\N		\N	vmod	\N	\N	\N	0	1
1363	今天三月一号星期一。	今日は三月一日月曜日です。\n	\N		\N	vmod	\N	\N	\N	0	1
1364	咱们去散散步吧。	ちょっと散歩に行こうよ。	\N		\N	vmod	\N	\N	\N	0	1
1365	今天十月二十号。	今日は十月二十日です。\n	\N		\N	vmod	\N	\N	\N	0	1
1366	十二月二十五号是圣诞节。	十二月二十五日はクリスマスです。\n	\N		\N	vmod	\N	\N	\N	0	1
1367	上个月我去过一次。	先月一度行きました。\n	\N		\N	vmod	\N	\N	\N	0	1
1368	我在学生食堂吃午饭。	私は学生食堂で昼食を食べます。\n	\N		\N	vmod	\N	\N	\N	0	1
1369	有没有什么吃的？	何か食べ物ありませんか？\n	\N		\N	vmod	\N	\N	\N	0	1
1370	颜色太深。	色が濃すぎる。\n	\N		\N	vmod	\N	\N	\N	0	1
1371	黄瓜不是水果。	キュウリは果物ではありません。	\N		\N	vmod	\N	\N	\N	0	1
1372	声音大点儿。	大きな声で話してください。\n	\N		\N	vmod	\N	\N	\N	0	1
1373	我没有收录机。	私はラジカセを持っていません。\n	\N		\N	vmod	\N	\N	\N	0	1
1374	他买菜去了。	彼は野菜を買いに行った。\n	\N		\N	vmod	\N	\N	\N	0	1
1375	我的书包不见了。	私のかばんがなくなった。	\N		\N	vmod	\N	\N	\N	0	1
1376	这件行李别竖着放。	この荷物は縦に置いてはいけません。\n	\N		\N	vmod	\N	\N	\N	0	1
1377	轻轻的推她坐在沙发上。	そっと彼女をソファーに座らせた。	\N		\N	vmod	\N	\N	\N	0	1
1378	她的腿太粗。	彼女の足はすごく太い。\n	\N		\N	vmod	\N	\N	\N	0	1
1379	快脱衣服。	早く服を脱ぎなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
1380	她突然站起来要往湖里跳。	彼女は急に立ち上がり湖に飛び込もうとした。\n	\N		\N	vmod	\N	\N	\N	0	1
1381	他爱吃甜的。\n	彼は甘いものが好きです。\n	\N		\N	vmod	\N	\N	\N	0	1
1383	哎哟!疼死了!	ああ、痛い！\n	\N		\N	vmod	\N	\N	\N	0	1
1384	头疼。	頭痛い。	\N		\N	vmod	\N	\N	\N	0	1
1385	她会弹钢琴。	彼女はピアノを弾ける。	\N		\N	vmod	\N	\N	\N	0	1
1386	进和室也就是日式房间时不必穿拖鞋。\n		\N		\N	vmod	\N	\N	\N	0	1
1387	进和室时不必穿拖鞋。	和室に入る時はスリッパを履く必要はありません。	\N		\N	vmod	\N	\N	\N	0	1
1388	用勺子吃。	スプーンで食べます。\n	\N		\N	vmod	\N	\N	\N	0	1
1389	前面有个池子。	前に池があります。\n	\N		\N	vmod	\N	\N	\N	0	1
1390	他讨厌这个地方的风沙。	彼はこの地方の風と砂ぼこりが嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
1391	我要这个。	これ下さい。\n	\N		\N	vmod	\N	\N	\N	0	1
1392	你怎么不脱外衣。	なんで上着を脱がないの？\n	\N		\N	vmod	\N	\N	\N	0	1
1393	我不是外国人。	僕は外国人じゃありません。\n	\N		\N	vmod	\N	\N	\N	0	1
1394	外面冷,里面暖和。	外は寒いが、中は暖かい。\n	\N		\N	vmod	\N	\N	\N	0	1
1395	今天五月一号星期一。	今日は五月一日月曜日です。\n	\N		\N	vmod	\N	\N	\N	0	1
1396	他写的文章有点儿那个…	彼の文章はちょっと…\n	\N		\N	vmod	\N	\N	\N	0	1
1397	往右拐。	右に曲がります。\n	\N		\N	vmod	\N	\N	\N	0	1
1398	把饭盛到饭碗里。	ご飯を茶碗に盛る。	\N		\N	vmod	\N	\N	\N	0	1
1399	真无聊。	本当につまらない。\n	\N		\N	vmod	\N	\N	\N	0	1
1400	不换拖鞋吗?穿着袜子进去吗?	スリッパに履き替えないのですか？靴下のまま入るのですか？\n	\N		\N	vmod	\N	\N	\N	0	1
1401	我有些问题。	質問がいくつかあります。\n	\N		\N	vmod	\N	\N	\N	0	1
1402	下一站下车。	次の駅で下ります。	\N		\N	vmod	\N	\N	\N	0	1
1403	从山顶上往下面看。	山頂から下の方見下ろす。\n	\N		\N	vmod	\N	\N	\N	0	1
1404	我不会抽烟。	私はタバコは吸えません。	\N		\N	vmod	\N	\N	\N	0	1
1405	你有兄弟姐妹吗?\n	兄弟はいますか。\n	\N		\N	vmod	\N	\N	\N	0	1
1406	他穿着一身笔挺的西装。\n	彼はぱりっとした背広を着ています。\n	\N		\N	vmod	\N	\N	\N	0	1
1407	定做了一套西服。	洋服をあつらえた。\n	\N		\N	vmod	\N	\N	\N	0	1
1408	下起雪来了。	雪が降り出しました。\n	\N		\N	vmod	\N	\N	\N	0	1
1409	快洗衣服吧。	早く洗濯しなさい。	\N		\N	vmod	\N	\N	\N	0	1
1410	洗手间在哪儿?	お手洗いはどこですか。	\N		\N	vmod	\N	\N	\N	0	1
1411	赶快洗个澡,睡个好觉。	さっさとひとっ風呂浴びてぐっすり眠りなさい。	\N		\N	vmod	\N	\N	\N	0	1
1412	请在这儿脱了鞋再进去。	ここで靴を脱いでから入ってください。	\N		\N	vmod	\N	\N	\N	0	1
1413	她眉毛细细的。	彼女は細い眉毛をしている。	\N		\N	vmod	\N	\N	\N	0	1
1414	“双赢”是什么意思?	“双赢”ってどういう意味ですか。\n	\N		\N	vmod	\N	\N	\N	0	1
1415	今天一月一号星期一。		\N		\N	vmod	\N	\N	\N	0	1
1416	今天一月一号星期一。\n	今日は一月一日月曜日です。\n	\N		\N	vmod	\N	\N	\N	0	1
1417	我家没有院子。	うちには庭はありません。\n	\N		\N	vmod	\N	\N	\N	0	1
1418	右边儿看到的是东京铁塔。\n	右手に見えますのが東京タワーです。\n	\N		\N	vmod	\N	\N	\N	0	1
1419	要想说对四和十,得靠舌头和牙齿。	四と十を正しく発音したいなら、舌と歯に頼らなければならない。\n	\N		\N	vmod	\N	\N	\N	0	1
1420	我的眼镜在哪儿呢?	私の眼鏡どこだろう？	\N		\N	vmod	\N	\N	\N	0	1
1421	她也许喜欢我,。	彼女はたぶんおれが好きなんだ。	\N		\N	vmod	\N	\N	\N	0	1
1422	祝你在日本逗留期间过得愉快。	日本滞在が楽しいものになるようお祈りもうしあげます。	\N		\N	vmod	\N	\N	\N	0	1
1423	她是有名的音乐家。	彼女は有名な音楽家です。\n	\N		\N	vmod	\N	\N	\N	0	1
1424	她到游泳池游泳去了。	彼女はプールへ泳ぎに行きました。\n	\N		\N	vmod	\N	\N	\N	0	1
1425	给我烟灰缸。	灰皿下さい。\n	\N		\N	vmod	\N	\N	\N	0	1
1426	这枝圆珠笔很好写。	このボールペンはとても書きやすい。\n	\N		\N	vmod	\N	\N	\N	0	1
1427	放点儿盐。	塩を少々。\n	\N		\N	vmod	\N	\N	\N	0	1
1428	我不想吃药。	私は薬を飲みたくないです。\n	\N		\N	vmod	\N	\N	\N	0	1
1429	研究语言是特别难的。\n	言葉の研究は大変難しい。\n	\N		\N	vmod	\N	\N	\N	0	1
1430	请把信投入邮筒里。	手紙をポストに入れて下さい。\n	\N		\N	vmod	\N	\N	\N	0	1
1431	我去银行取钱。	銀行へお金をおろしに行ってきます。	\N		\N	vmod	\N	\N	\N	0	1
1432	明天是阴天。	明日は曇りです。	\N		\N	vmod	\N	\N	\N	0	1
1433	颜色太艳了。	色が派手すぎます。\n	\N		\N	vmod	\N	\N	\N	0	1
1434	有什么饮料?\n	飲み物は何がありますか？	\N		\N	vmod	\N	\N	\N	0	1
1435	我不爱吃鱼。	私は魚が嫌いです。\n	\N		\N	vmod	\N	\N	\N	0	1
1436	左边儿看到的是什么呢?	左手に見えるのはなんですか。	\N		\N	vmod	\N	\N	\N	0	1
1437	快把作文写完。	早く作文を書き上げなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
1438	这条路很窄。\n	この道は狭いです。\n	\N		\N	vmod	\N	\N	\N	0	1
1439	这张照片是谁照的?	この写真は誰が撮ったのですか。\n	\N		\N	vmod	\N	\N	\N	0	1
1440	她已经有丈夫了。	彼女はもう夫がいます。\n	\N		\N	vmod	\N	\N	\N	0	1
1441	正好五个人。	ちょうど五人です。\n	\N		\N	vmod	\N	\N	\N	0	1
1442	这儿是家的正门。		\N		\N	vmod	\N	\N	\N	0	1
1443	这儿是家的正门。	ここが家の玄関です。	\N		\N	vmod	\N	\N	\N	0	1
1444	早饭还没吃呢。	朝ご飯はまだ食べてません。\n	\N		\N	vmod	\N	\N	\N	0	1
1445	他的房间在走廊的尽头。	彼の部屋は廊下をつきあたった所です。\n	\N		\N	vmod	\N	\N	\N	0	1
1446	我干了一整天活儿。	私は一日中働きました。\n	\N		\N	vmod	\N	\N	\N	0	1
1447	我不喜欢吃猪肉。	私は豚肉が嫌いです。\n	\N		\N	vmod	\N	\N	\N	0	1
1448	闭嘴!	だまれ！\n	\N		\N	vmod	\N	\N	\N	0	1
1449	众多的市民参加了她的婚礼。\n	大勢の市民が彼女の結婚式に出席した。\n	\N		\N	vmod	\N	\N	\N	0	1
1450	送钟和送终发音一样。	時計を贈ると死に水を取るは発音が一緒です。\n	\N		\N	vmod	\N	\N	\N	0	1
1451	这个月的工资怎么样了?	今月の給料はどうなりましたか。\n	\N		\N	vmod	\N	\N	\N	0	1
1452	这个星期非常忙。	今週は非常に忙しい。\n	\N		\N	vmod	\N	\N	\N	0	1
1453	他是我叔父。	彼は私のおじです。\n	\N		\N	vmod	\N	\N	\N	0	1
1454	他是我姑夫。	彼は私のおじです。	\N		\N	vmod	\N	\N	\N	0	1
1455	他是我舅父。	彼は私のおじです。	\N		\N	vmod	\N	\N	\N	0	1
1456	他是我姨夫。	彼は私のおじです。\n	\N		\N	vmod	\N	\N	\N	0	1
1457	她是我表妹。		\N		\N	vmod	\N	\N	\N	0	1
1458	她是我表妹。	彼女は私の従妹です。	\N		\N	vmod	\N	\N	\N	0	1
1459	从昨夜开始下的雨好容易停了。	昨夜からの雨がようやくあがった。\n	\N		\N	vmod	\N	\N	\N	0	1
1460	她穿着一条白色的裤子。	彼女は白いズボンをはいています。\n	\N		\N	vmod	\N	\N	\N	0	1
1461	这件汗衫太脏。	このシャツはひどく汚い。\n	\N		\N	vmod	\N	\N	\N	0	1
1462	打扫得很彻底。	掃除が行き届いている。	\N		\N	vmod	\N	\N	\N	0	1
1463	请帮我复印一下。	コピーするのを手伝ってください。\n	\N		\N	vmod	\N	\N	\N	0	1
1464	她是我伯母。	彼女は私の伯母です。\n	\N		\N	vmod	\N	\N	\N	0	1
1465	她是我婶母。	彼女は私のおばです。	\N		\N	vmod	\N	\N	\N	0	1
1466	她是我姨母。	彼女は私のおばです。	\N		\N	vmod	\N	\N	\N	0	1
1467	这座大楼有多高?	このビルはどれくらいの高さがありますか。	\N		\N	vmod	\N	\N	\N	0	1
1468	你哥哥今年多大了?	お兄さんは今年何歳ですか。\n	\N		\N	vmod	\N	\N	\N	0	1
1469	跟在队伍的后面。	行列の後に続く。	\N		\N	vmod	\N	\N	\N	0	1
1470	我没有房子住。	私はホームレスです。\n	\N		\N	vmod	\N	\N	\N	0	1
1471	附近有没有派出所?	近くに交番ありますか。	\N		\N	vmod	\N	\N	\N	0	1
1472	我爱吃鸡肉。	私は鶏肉が好きです。\n	\N		\N	vmod	\N	\N	\N	0	1
1473	我非常想去中国旅行。	私はとても中国へ旅行に行きたいです。	\N		\N	vmod	\N	\N	\N	0	1
1474	他也总算娶上了个老婆。	彼もようやく奥さんをもらった。\n	\N		\N	vmod	\N	\N	\N	0	1
1475	要每天练习。	毎日練習しなければだめです。	\N		\N	vmod	\N	\N	\N	0	1
1476	每个星期开一次会。	毎週一回会議を開きます。\n	\N		\N	vmod	\N	\N	\N	0	1
1477	她显得很年轻,其实…\n	彼女は若く見えるけど、実は…	\N		\N	vmod	\N	\N	\N	0	1
1478	前面可能发生了交通事故。	この先で交通事故が起こったらしい。	\N		\N	vmod	\N	\N	\N	0	1
1479	您是哪位呀?	どなたさまでしょうか。	\N		\N	vmod	\N	\N	\N	0	1
1480	好像有人来了。	誰か来たみたいだ。	\N		\N	vmod	\N	\N	\N	0	1
1481	我爱吃糖。	私は飴が好きです。\n	\N		\N	vmod	\N	\N	\N	0	1
1482	这个问题太难。	この問題は難しすぎる。\n	\N		\N	vmod	\N	\N	\N	0	1
1483	你喜欢听音乐吗?	音楽を聞くのが好きですか。	\N		\N	vmod	\N	\N	\N	0	1
1484	放在那儿吧。	そこに置いてください。	\N		\N	vmod	\N	\N	\N	0	1
1485	安静点儿,行吗?	ちょと静かにしてくれないか。	\N		\N	vmod	\N	\N	\N	0	1
1486	我出去一下。	ちょっと出かけてきます。	\N		\N	vmod	\N	\N	\N	0	1
1487	他爱吃黄油面包。	彼はバターつきパンが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
1488	他的画不怎么样。	彼の絵は大したことありません。\n	\N		\N	vmod	\N	\N	\N	0	1
1489	我打算后年到中国去留学。	私は再来年中国へ留学に行くつもりです。	\N		\N	vmod	\N	\N	\N	0	1
1490	你姥姥身体好吗?	おばあさんは元気ですか。	\N		\N	vmod	\N	\N	\N	0	1
1491	你老爷身体好吗?	おじいさんは元気ですか。\n	\N		\N	vmod	\N	\N	\N	0	1
1492	我每年夏天都去中国旅行。	私は毎年夏に中国へ旅行に行きます。	\N		\N	vmod	\N	\N	\N	0	1
1493	她是我的学生。	彼女は私の生徒です。	\N		\N	vmod	\N	\N	\N	0	1
1494	找着了,大概。	見つかったよ、多分。\n	\N		\N	vmod	\N	\N	\N	0	1
1495	我家前面有两条河。	私の家の前には２本の川がある。	\N		\N	vmod	\N	\N	\N	0	1
1496	你哥哥工作不工作？	あなたのお兄さんは働いていますか?	\N		\N	vmod	\N	\N	\N	0	1
1497	他要一个口琴。	彼はハーモニカを一つ欲しい。	\N		\N	vmod	\N	\N	\N	0	1
1498	几十年前, 我成长在贫困家庭。	何十年前、私は貧しい家庭に育った。	\N		\N	vmod	\N	\N	\N	0	1
1499	这条路很长。	この道はとても長い。	\N		\N	vmod	\N	\N	\N	0	1
1500	他公司的电话号码写在笔记本上。	彼の会社の電話番号はノートに書いた。	\N		\N	vmod	\N	\N	\N	0	1
1501	我每天花十分种刷牙, 牙齿很干净。	私は毎日十分間歯を磨いているので、歯はとても清潔だ。	\N		\N	vmod	\N	\N	\N	0	1
1502	他准备在天津站下车。	彼は天津駅で車から降りようとしている。	\N		\N	vmod	\N	\N	\N	0	1
1503	我去银行取钱去。	銀行へお金をおろしに行ってきます。	\N		\N	vmod	\N	\N	\N	0	1
1504	星期天, 家里就热闹了。	日曜日になると家はにぎやかになる。	\N		\N	vmod	\N	\N	\N	0	1
1506	电影院很少。	映画館が少ない。	\N		\N	vmod	\N	\N	\N	0	1
1507	我爷爷会说英语。	私のおじいさんは英語を話せます。	\N		\N	vmod	\N	\N	\N	0	1
1508	我爸爸会说日语。	私のお父さんは日本語を話せます。	\N		\N	vmod	\N	\N	\N	0	1
1509	大象的鼻子很长。	象の鼻は長い。	\N		\N	vmod	\N	\N	\N	0	1
1510	医生发现她的右腿骨折了。	医者は彼女の右足が骨折しているのを発見した。	\N		\N	vmod	\N	\N	\N	0	1
1511	冬天早上要到教室去生炉子。	冬の朝は教室に行ってストーブに火をつけます。	\N		\N	vmod	\N	\N	\N	0	1
1512	闹钟、手表、电钟都是钟表。	目覚まし時計、腕時計、電気時計は全て時計です。	\N		\N	vmod	\N	\N	\N	0	1
1513	星期天我们去看电影吧。	日曜日に映画を見に行きましょう。	\N		\N	vmod	\N	\N	\N	0	1
1514	从白天到晚上，写了一篇文章。	日中から夕方までかかって一篇書いた。	\N		\N	vmod	\N	\N	\N	0	1
1515	我写好了三篇文章。	私は文章を3本書きました。	\N		\N	vmod	\N	\N	\N	0	1
1516	 成年人应该承担一定的社会义务。	大人は一定の社会的義務を負わなければならない。	\N		\N	vmod	\N	\N	\N	0	1
1517	我家男孩子都喜欢喝牛奶。	我が家の男の子はみな牛乳が好きです。	\N		\N	vmod	\N	\N	\N	0	1
1518	院子里晾着黄色手帕。	庭に黄色いハンカチが干してある。	\N		\N	vmod	\N	\N	\N	0	1
1519	他买了一个黑色的书包。\n	彼は黒い鞄を買いました。	\N		\N	vmod	\N	\N	\N	0	1
1520	他带着一顶绿色的军帽。	彼は緑の軍帽をかぶっています。\n	\N		\N	vmod	\N	\N	\N	0	1
1521	他推着自行车去接孩子。	彼は自転車を押して子供を迎えに行く。	\N		\N	vmod	\N	\N	\N	0	1
1522	我想他大概会同意。	私は、彼が多分賛成すると思う。	\N		\N	vmod	\N	\N	\N	0	1
1523	咱们坐出租车去吧。	私たちはタクシーで行きましょう。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: zh
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	1	行く	1	1
2	2	英語	1	1
3	3	飛行機	1	1
4	4	外国	1	1
5	5	外国人	1	1
6	6	中国語	1	1
7	7	ホテル	1	1
8	8	日本語	1	1
9	9	出掛ける	1	1
10	10	国（くに）	1	1
11	11	会う	1	1
12	12	休み	1	1
13	13	旅行	1	1
14	14	旅行する	1	1
15	15	遊ぶ	1	1
16	16	大使館	1	1
17	17	大好き	1	1
18	18	好き	1	1
19	19	得意な	1	1
20	20	走る	1	1
21	21	ゆっくり	1	1
22	22	下手（へた）	1	1
23	23	歩く	1	1
24	24	泳ぐ	1	1
25	25	速い［スピードが～］	1	1
26	26	飛ぶ	1	1
27	27	スポーツ	1	1
28	28	嫌い	1	1
29	29	プール	1	1
30	30	バス	1	1
31	31	自転車	1	1
32	32	交差点	1	1
33	33	道（みち）	1	1
34	34	池	1	1
35	35	散歩	1	1
36	36	かわ（川・河）	1	1
37	37	タクシー	1	1
38	38	自動車，車（くるま）	1	1
39	39	曲がる	1	1
40	40	ネクタイ	1	1
41	41	ワイシャツ、ブラウス\n	1	1
42	42	会社	1	1
43	43	背広	1	1
44	44	やる	1	1
45	45	吸う	1	1
46	46	電話	1	1
47	47	仕事	1	1
48	48	働く・勤める	1	1
49	49	忙しい	1	1
50	50	図書館	1	1
51	51	辞書，字引	1	1
52	52	借りる	1	1
53	53	新聞	1	1
54	54	読む	1	1
55	55	本	1	1
56	56	コピー	1	1
57	57	コピーする	1	1
58	58	雑誌	1	1
59	59	冊	1	1
60	60	牛肉	1	1
61	61	安い	1	1
62	62	店	1	1
63	63	高い	1	1
64	64	いくつ	1	1
65	65	いくら、いくつ	1	1
66	66	果物	1	1
67	67	野菜	1	1
68	68	魚	1	1
69	69	豚肉	1	1
70	70	鳥肉	1	1
71	71	肉	1	1
72	72	欲しい	1	1
73	73	渡す	1	1
74	74	八百屋	1	1
75	75	かぎ（鍵）	1	1
76	76	料理	1	1
77	77	買い物する	1	0
78	78	洗濯する	1	1
79	79	掃除する	1	1
80	80	家族	1	1
81	81	家庭	1	1
82	82	庭（にわ）	1	1
83	83	洗濯	1	1
84	84	うち（家）	1	1
85	85	家（いえ）	1	1
86	86	掃除	1	1
87	87	かえる（帰・返）	1	1
88	88	本棚	1	1
89	89	机	1	1
90	90	椅子（いす）	1	1
91	91	部屋	1	1
92	92	冷蔵庫	1	1
93	93	洗う	1	1
94	94	ベッド	1	1
95	95	ラジオ	1	1
96	96	ラジカセ	1	1
97	97	～という姓です	1	1
98	98	寝る	1	1
99	99	起きる	1	1
100	100	テーブル	1	1
101	101	テレビ	1	1
102	102	お巡りさん	1	1
103	103	警官	1	1
104	104	地図	1	1
105	105	そば	2	1
106	106	ここ,こちら, こっち	1	1
107	107	そこ,そちら, そっち	1	1
108	108	あちら, あっち，あそこ	1	1
109	109	どこ,どちら,どっち	1	1
110	110	交番	1	1
111	111	近く	1	1
112	112	隣	1	1
113	113	きく	1	1
114	114	切る	1	1
115	115	短い	1	1
116	116	後ろ	2	1
117	117	前	2	1
118	118	右	1	1
119	119	左	1	1
120	120	長い	1	1
121	121	座る	1	1
122	122	立つ	1	1
123	123	友達	1	1
124	124	クラス	1	1
125	125	教室	1	1
126	126	廊下	1	1
127	127	学校	1	1
128	128	生徒	1	1
129	129	勉強	1	1
130	130	学生	1	1
131	131	留学生	1	1
132	132	夏休み	1	1
133	133	先生	1	1
134	134	大学	1	1
135	135	ノート	1	1
136	136	授業に出る、授業をする	1	1
137	137	作文	1	1
138	138	宿題	1	1
139	139	難しい	1	1
140	140	教える	1	1
141	141	テスト	1	1
142	142	練習問題\n	2	1
143	143	易しい	1	1
144	144	練習する	1	1
145	145	質問	1	1
146	146	問題	1	1
147	147	答える	1	1
148	148	痛い	1	1
149	149	歯	1	1
150	150	医者	1	1
151	151	病院	1	1
152	152	病気	1	1
153	153	薬（くすり）	1	1
154	154	死ぬ	1	1
155	155	風邪（かぜ）	1	1
156	156	頭（あたま）	1	1
157	157	お腹	1	1
158	158	度（ど）	1	1
159	159	エレベーター	1	1
160	160	切符	1	1
161	161	おりる	1	1
162	162	階段	1	1
163	163	閉める	1	1
164	164	駅	1	1
165	165	地下鉄	1	1
166	166	乗る	1	1
167	167	開ける	1	1
168	168	お手洗い	1	1
169	169	トイレ	1	1
170	170	電車	1	1
171	171	飲み物	1	1
172	172	コーヒー	1	1
173	173	喫茶店	1	1
174	174	レモン	1	1
175	175	牛乳	1	1
176	176	砂糖	1	1
177	177	カップ	2	1
178	178	お茶	1	1
179	179	紅茶	1	1
180	180	コップ	1	1
181	181	入れる	1	1
182	182	甘い	1	1
183	183	飲む	1	1
184	184	はし	1	1
185	185	酒	1	1
186	186	おいしい	1	1
187	187	ナイフ	1	1
188	188	スプーン	1	1
189	189	フォーク	1	1
190	190	チーズ	1	1
191	191	食べる	1	1
192	192	まずい	1	1
193	193	パン	1	1
194	194	辛い	1	1
195	195	レストラン	1	1
196	196	食堂	1	1
197	197	酒・ワイン	1	1
198	198	食べ物	1	1
199	199	カレー（ライス）	1	1
200	200	お金	1	1
201	201	銀行	1	1
202	202	入り口	1	1
203	203	どうぞ,どういたしまして	1	1
204	204	いいえ	1	1
205	205	ええ	1	1
206	206	すみません	1	1
207	207	どうぞ	1	1
208	208	出口	1	1
209	209	着く	1	1
210	210	ポスト	1	1
211	211	はがき	1	1
212	212	貼る	1	1
213	213	封筒	1	1
214	214	手紙	1	1
215	215	郵便局	1	1
216	216	返す	1	1
217	217	（手紙、小包などを）出す\n	1	1
218	218	切手	1	1
219	219	荷物	1	1
220	220	枚	1	1
221	221	貸す	1	1
222	222	買う	1	1
223	223	帽子	1	1
224	224	靴	1	1
225	225	買い物	1	1
226	226	階	1	1
227	227	デパート	1	1
228	228	スカート	1	1
229	229	コート	1	1
230	230	ズボン	1	1
231	231	セーター	1	1
232	232	…てください	1	1
233	233	かばん	1	1
234	234	売る	1	1
235	235	上着	1	1
236	236	ふろ	1	1
237	237	建物	1	1
238	238	台所	1	1
239	239	シャワー	1	1
240	240	窓	1	1
241	241	住む	1	1
242	242	公園	1	1
243	243	ドア	1	1
244	244	浴びる［一風呂～］	1	1
245	245	アパート	1	1
246	246	玄関	1	1
247	247	彼，彼女	1	1
248	248	彼ら，彼女たち	1	1
249	249	私（わたし）	1	1
250	250	私たち	1	1
251	251	だれか	1	1
252	252	だれ	1	1
253	253	どなた	1	1
254	254	きみ	1	1
255	255	あなた	1	1
256	256	この	1	1
257	257	その，あの	1	1
258	258	いかが，どう	1	1
259	259	どの	1	1
260	260	どんな	1	1
261	261	こんな	1	1
262	262	自分	1	1
263	263	そう	1	1
264	264	厚い	1	1
265	265	狭い	1	1
266	266	細い	1	1
267	267	大きい	1	1
268	268	太い	1	1
269	269	若い	1	1
270	270	広い	1	1
271	271	軽い	1	1
272	272	遠い	1	1
273	273	重い	1	1
274	274	薄い	1	1
275	275	新しい	1	1
276	276	小さい	1	1
277	277	近い	1	1
278	278	古い	1	1
279	279	楽しい	1	1
280	280	にぎやか	1	1
281	281	低い	1	1
282	282	よい	1	1
283	283	明るい	1	1
284	284	弱い	1	1
285	285	強い	1	1
286	286	おもしろい	1	1
287	287	きれい	1	1
288	288	遅い	1	1
289	289	悪い	1	1
290	290	多い	1	1
291	291	暗い	1	1
292	292	静か	1	1
293	293	少ない	1	1
294	294	汚い	1	1
295	295	つまらない	1	1
296	296	横	1	1
297	297	中（なか）	1	1
298	298	外（そと）	1	1
299	299	東（ひがし）	1	1
300	300	高さ	1	1
301	301	縦	1	1
302	302	北（きた）	1	1
303	303	西（にし）	1	1
304	304	下（した）	1	1
305	305	南（みなみ）	1	1
306	306	(～の)上	1	1
307	307	先（さき）	1	1
308	308	後（あと）	1	1
309	309	従妹\n	1	1
310	310	兄	1	1
311	311	兄弟（きょうだい）	1	1
312	312	父方の祖母	1	1
313	313	おじいさん	1	1
314	314	奥さん	1	0
315	315	母	1	1
316	316	伯父(父親の兄）\n	1	1
317	317	両親	1	1
318	318	父	1	1
319	319	姉	1	1
320	320	姉妹	1	1
321	321	叔母，伯母	1	1
322	322	お兄さん	1	1
323	323	お姉さん	1	1
324	324	お父さん	1	1
325	325	お母さん	1	1
326	326	靴下	1	1
327	327	シャツ	1	1
328	328	脱ぐ	1	1
329	329	架ける	1	1
330	330	は（穿）く［ズボンを～］	1	1
331	331	着る	1	1
332	332	かぶる	1	1
333	333	ハンカチ	1	1
334	334	スリッパ	1	1
335	335	傘	1	1
336	336	ポケット	1	1
337	337	財布	1	1
338	338	着ている	1	1
339	339	服	1	1
340	340	洋服	1	1
341	341	口	1	1
342	342	腕（うで）	1	1
343	343	体（からだ）	1	1
344	344	顔	1	1
345	345	脚（あし）	1	1
346	346	手（て）	1	1
347	347	鼻	1	1
348	348	目（め）	1	1
349	349	耳	1	1
350	350	足（あし）	1	1
351	351	おなか	1	1
352	352	皿（さら）	1	1
353	353	バター	1	1
354	354	茶わん	1	1
355	355	あめ	1	1
356	356	昼御飯	1	1
357	357	夕飯（ゆうはん）	1	1
358	358	お菓子	1	1
359	359	卵	1	1
360	360	朝御飯	1	1
361	361	御飯（ごはん）	1	1
362	362	醤油	1	1
363	363	塩（しお）	1	1
364	364	晩御飯	1	1
365	365	くわえる	1	1
366	366	付ける	1	1
367	367	カメラ	1	1
368	368	ストーブ	1	1
369	369	鉛筆	1	1
370	370	消す	1	1
371	371	眼鏡（めがね）	1	1
372	372	テープレコーダー	1	1
373	373	時計	1	1
374	374	コンピュータ	1	1
375	375	フィルム	1	1
376	376	戸（と）	1	1
377	377	門（もん）	1	1
378	378	ペン	1	1
379	379	万年筆	1	1
380	380	ボールペン	1	1
381	381	八月	1	1
382	382	四月	1	1
383	383	今月	1	1
384	384	毎月（まいつき）	1	1
385	385	十二月	1	1
386	386	二月	1	1
387	387	一月	1	1
388	388	七月	1	1
389	389	六月	1	1
390	390	来月	1	1
391	391	五月	1	1
392	392	三月	1	1
393	393	先月	1	1
394	394	十一月	1	1
395	395	十月	1	1
396	396	九月	1	1
397	397	ひとつき	1	1
398	398	今週	1	1
399	399	毎週	1	0
400	400	日曜日	1	1
401	401	木曜日	1	1
402	402	来週	1	1
403	403	月曜日	1	1
404	404	火曜日	1	1
405	405	水曜日	1	1
406	406	土曜日	1	1
407	407	週間	1	1
408	408	先週	1	1
409	409	金曜日	1	1
410	410	年（ねん）	1	1
411	411	秋	1	1
412	412	今年（ことし）	1	1
413	413	毎年（まいとし）	1	1
414	414	夏（なつ）	1	1
415	415	冬	1	1
416	416	去年	1	1
417	417	来年	1	1
418	418	春	1	1
419	419	再来年	1	1
420	420	おととし	1	0
421	421	午後	1	1
422	422	今日（きょう）	1	1
423	423	明日（あした）	1	1
424	424	時（じ）	1	1
425	425	昨日（きのう）	1	1
426	426	 夕べ	2	0
427	427	午前	1	1
428	428	朝	1	1
429	429	昼	1	1
430	430	夜（よる）	1	1
431	431	夕方	1	1
432	432	あさって	1	1
433	433	おととい	1	1
434	434	もう	1	1
435	435	ながら	1	1
436	436	まだ	1	1
437	437	中(ちゅう)	1	1
438	438	時（とき）	1	1
439	439	いつ	1	1
440	440	ときどき	1	1
441	441	しばしば	1	1
442	442	時間	1	1
443	443	すぐ	1	1
444	444	灰皿	1	1
445	445	歌（うた）	1	1
446	446	歌う	1	1
447	447	たばこ	1	1
448	448	映画	1	1
449	449	レコード	1	1
450	450	ギター	1	1
451	451	弾く	1	1
452	452	音楽	1	1
453	453	絵（え）	1	1
454	454	写真	1	1
455	455	好き，気に入る	1	1
456	456	声	1	1
457	457	晴れ	1	1
458	458	暑い	1	1
459	459	晴れる	1	1
460	460	涼しい	1	1
461	461	寒い	1	1
462	462	雪（ゆき）	1	1
463	463	雨が降る	1	1
464	464	雨（あめ）	1	1
465	465	天気	1	1
466	466	あたたかい（暖・温）	1	1
467	467	風（かぜ）	1	1
468	468	曇り	1	1
469	469	冷たい	1	1
470	470	曇る	1	1
471	471	漢字	1	1
472	472	言う	1	1
473	473	書く	1	1
474	474	話（はなし）	1	1
475	475	言葉	1	1
476	476	～語	1	1
477	477	語（ご）	1	1
478	478	話す	1	1
479	479	文章	1	1
480	480	語る	1	1
481	481	意味	1	1
482	482	平仮名	1	1
483	483	片仮名	1	1
484	484	大人（おとな）	1	1
485	485	大勢	1	1
486	486	夫婦	1	1
487	487	子供	1	1
488	488	妻	1	1
489	489	女（おんな）	1	1
490	490	男の子	1	1
491	491	人（ひと）	1	1
492	492	男（おとこ）	1	1
493	493	女の子	1	1
494	494	夫	1	1
495	495	人	1	1
496	496	みんな	1	1
497	497	白（しろ），白い	1	1
498	498	青，青い	1	1
499	499	茶色	1	1
500	500	明るい	1	1
501	501	色（いろ）	1	1
502	502	（色が）濃い，暗い	1	1
503	503	黄色（きいろ），黄色い	1	1
504	504	黒（くろ），黒い	1	1
505	505	赤，赤い	1	1
506	506	緑	1	1
507	507	便利	1	1
508	508	パーティー	1	1
509	509	紙	1	1
510	510	～になる	1	1
511	511	締める	1	1
512	512	押す	1	1
513	513	始まる	1	1
514	514	ちょうど	1	1
515	515	ない	1	1
516	516	まっすぐ	1	1
517	517	有名	1	1
518	518	元気	1	1
519	519	じゃあ	1	1
520	520	多分	1	1
521	521	では	1	1
522	333		1	0
523	523	母方の祖母	1	1
524	177	コップ	1	1
525	314		1	0
526	524	奥さん\n	1	0
527	426	夕方	1	1
528	157	おなか	1	0
529	525	楽しい	1	1
530	526		1	0
531	526	ときどき\n	1	1
532	527	皿（さら）\n	1	1
533	420	おととし	1	1
534	528	チーズ\n	1	1
535	529	上着\n\n	1	1
536	530	食べ物\n	1	1
537	531	質問	1	1
538	532	スプーン	1	1
539	533	池\n	1	1
540	534	曲がる\n	1	1
541	535	茶わん\n	1	1
542	536	吸う	1	1
543	537	玄関\n	1	1
544	538	夫\n	1	1
545	539	写真\n	1	1
546	540	中（じゅう）	1	1
547	541	おじ（父親の弟）	1	1
548	542	おじ（父の姉妹の夫）\n	1	1
549	543	おじ（母の兄弟）	1	1
550	544	おじ（母の姉妹の夫）\n	1	1
551	545	ゆうべ\n\n	1	1
552	331	は（穿）く〔ズボンを～〕\n	1	1
553	546	シャツ\n	1	1
554	79	掃除\n	1	1
555	56	コピーする\n	1	1
556	547	伯母（父親の兄の妻）	1	1
557	548	おば（父親の弟の妻）	1	1
558	549	おば（母の姉妹）	1	1
559	63	高さ\n	1	1
560	310	お兄さん	1	1
561	116	後（あと）	1	1
562	205	よい	1	1
563	550	家（いえ）\n	1	1
564	551	近く	1	1
565	102	警官	1	0
566	102		1	0
567	102	警官\n	1	1
568	13	旅行する	1	0
569	13	旅行する	1	1
570	524	奥さん	1	1
571	142	練習する\n	1	1
572	77	買い物\n	1	1
573	315	お母さん\n	1	1
574	399	毎週	1	1
575	243	門（もん）	1	1
576	243	戸（と）	1	0
577	519	では	1	1
578	105	隣	1	1
579	117	先（さき）	1	1
580	207	…てください\n	1	1
581	491	人	1	1
582	252	どなた\n	1	0
583	552	どなた\n	1	1
584	553	だれか\n	1	1
585	176	あめ\n	1	1
586	531	問題	1	1
587	357	晩御飯\n	1	1
588	455	好き	1	1
589	121	乗る	1	1
590	89	テーブル	1	1
591	108	そこ、そちら、そっち	1	1
592	554	（母方の）おじいさん	1	1
593	128	学生	1	1
594	555	多分\n	1	1
595	556	タクシー	1	1
596	47	働く・勤める	1	1
597	557	日曜日	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
507	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
438	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
439	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
399	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
574	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
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
597	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
427	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
421	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
428	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
429	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
431	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
527	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
430	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
412	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
383	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
398	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
422	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
416	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
420	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
533	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
393	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
408	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
425	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
433	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
426	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
551	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
417	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
419	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
390	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
402	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
423	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
432	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
107	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
591	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
108	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
109	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
307	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
579	10137	1.17	1.17	体	関係	空間	空間・場所	先（さき）	先	さき
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
561	10985	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後（あと）	後	あと
301	11034	1.174	1.17	体	関係	空間	左右・前後・たてよこ	縦	縦	たて
296	11035	1.174	1.17	体	関係	空間	左右・前後・たてよこ	横	横	よこ
306	11063	1.1741	1.17	体	関係	空間	上下	上（うえ）	上	うえ
304	11065	1.1741	1.17	体	関係	空間	上下	下（した）	下	した
298	11437	1.177	1.17	体	関係	空間	内外	外（そと）	外	そと
297	11443	1.177	1.17	体	関係	空間	内外	中（なか）	中	なか
105	11633	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	そば	そば	そば
112	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
578	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
111	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
564	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
208	12247	1.183	1.18	体	関係	形	穴・口	出口	出口	でぐち
202	12249	1.183	1.18	体	関係	形	穴・口	入（い）り口	入り口	いりぐち
485	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
300	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
559	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
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
581	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
249	15476	1.201	1.20	体	主体	人間	われ・なれ・かれ	私（わたし）	私	わたし
250	15479	1.201	1.20	体	主体	人間	われ・なれ・かれ	私たち	私たち	わたしたち
255	15524	1.201	1.20	体	主体	人間	われ・なれ・かれ	あなた	あなた	あなた
254	15527	1.201	1.20	体	主体	人間	われ・なれ・かれ	君（きみ）	君	きみ
247	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
248	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
252	15603	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれ	だれ	だれ
253	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
582	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
583	15605	1.201	1.20	体	主体	人間	われ・なれ・かれ	どなた	どなた	どなた
251	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
584	15612	1.201	1.20	体	主体	人間	われ・なれ・かれ	だれか	だれか	だれか
262	15636	1.202	1.20	体	主体	人間	自他	自分	自分	じぶん
492	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
490	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
489	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
493	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
487	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
484	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
313	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
312	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
523	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
80	16247	1.21	1.21	体	主体	家族	家族	家族	家族	かぞく
486	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
494	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
544	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
488	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
314	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
525	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
526	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
570	16402	1.211	1.21	体	主体	家族	夫婦	奥さん	奥さん	おくさん
317	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
318	16495	1.212	1.21	体	主体	家族	親・先祖	父	父	ちち
315	16496	1.212	1.21	体	主体	家族	親・先祖	母	母	はは
324	16500	1.212	1.21	体	主体	家族	親・先祖	お父さん	お父さん	おとうさん
325	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
573	16507	1.212	1.21	体	主体	家族	親・先祖	お母さん	お母さん	おかあさん
592	16593	1.212	1.21	体	主体	家族	親・先祖	おじいさん	おじいさん	おじいさん
311	16780	1.214	1.21	体	主体	家族	兄弟	兄弟（きょうだい）	兄弟	きょうだい
310	16785	1.214	1.21	体	主体	家族	兄弟	兄	兄	あに
322	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
560	16797	1.214	1.21	体	主体	家族	兄弟	お兄さん	お兄さん	おにいさん
319	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
320	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
323	16806	1.214	1.21	体	主体	家族	兄弟	お姉さん	お姉さん	おねえさん
316	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
547	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
548	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
549	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
550	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
321	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
557	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
558	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
556	16870	1.215	1.21	体	主体	家族	親戚	伯母（おば）	伯母	おば
309	16892	1.215	1.21	体	主体	家族	親戚	いとこ	いとこ	いとこ
123	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
5	17302	1.2301	1.23	体	主体	人物	国民・住民	外国人	外国人	がいこくじん
133	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
150	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
103	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
565	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
566	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
567	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
102	20065	1.2417001	1.24	体	主体	成員	保安サービス	お巡りさん	お巡りさん	おまわりさん
130	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
593	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
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
537	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
146	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
586	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
56	33488	1.3151	1.31	体	活動	言語	書き	コピー	コピー	こぴい
479	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
55	34173	1.316	1.31	体	活動	言語	文献・図書	本（ほん）	本	ほん
58	34482	1.316	1.31	体	活動	言語	文献・図書	雑誌	雑誌	ざっし
53	34508	1.316	1.31	体	活動	言語	文献・図書	新聞	新聞	しんぶん
51	34541	1.316	1.31	体	活動	言語	文献・図書	辞書	辞書	じしょ
445	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
453	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
454	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
545	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
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
587	36954	1.3331	1.33	体	活動	生活	食生活	晩御飯	晩御飯	ばんごはん
13	38057	1.3371	1.33	体	活動	生活	旅・行楽	旅行	旅行	りょこう
35	38140	1.3371	1.33	体	活動	生活	旅・行楽	散歩	散歩	さんぽ
27	38202	1.3374	1.33	体	活動	生活	スポーツ	スポーツ	スポーツ	すぽおつ
19	39927	1.3421	1.34	体	活動	行為	才能	上手（じょうず）	上手	じょうず
22	39936	1.3421	1.34	体	活動	行為	才能	下手（へた）	下手	へた
508	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
136	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
225	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
572	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
83	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
86	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
554	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
219	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
200	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
160	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
218	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
509	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
339	49629	1.421	1.42	体	生産物	衣料	衣服	服	服	ふく
340	49632	1.421	1.42	体	生産物	衣料	衣服	洋服	洋服	ようふく
235	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
535	49803	1.4220001	1.42	体	生産物	衣料	上着・コート	上着	上着	うわぎ
43	49814	1.4220001	1.42	体	生産物	衣料	上着・コート	背広	背広	せびろ
231	49843	1.4220001	1.42	体	生産物	衣料	上着・コート	セーター	セーター	せえたあ
41	49847	1.4220001	1.42	体	生産物	衣料	上着・コート	ワイシャツ	ワイシャツ	わいしゃつ
229	49881	1.4220001	1.42	体	生産物	衣料	上着・コート	コート	コート	こおと
230	49909	1.4220001	1.42	体	生産物	衣料	上着・コート	ズボン	ズボン	ずぼん
228	49927	1.4220001	1.42	体	生産物	衣料	上着・コート	スカート	スカート	すかあと
327	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
553	49945	1.423	1.42	体	生産物	衣料	下着・寝巻き	シャツ	シャツ	しゃつ
336	50065	1.424	1.42	体	生産物	衣料	そで・襟・身ごろ・ポケットなど	ポケット	ポケット	ぽけっと
223	50073	1.425	1.42	体	生産物	衣料	帽子・マスクなど	帽子	帽子	ぼうし
40	50149	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	ネクタイ	ネクタイ	ねくたい
326	50205	1.4251	1.42	体	生産物	衣料	ネクタイ・帯・手袋・靴下など	靴下	靴下	くつした
224	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
334	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
335	50300	1.4261	1.42	体	生産物	衣料	雨具・日よけなど	傘	傘	かさ
94	50330	1.427	1.42	体	生産物	衣料	寝具	ベッド	ベッド	べっど
198	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
536	50441	1.4299999	1.43	体	生産物	食料	食料	食べ物	食べ物	たべもの
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
534	51478	1.433	1.43	体	生産物	食料	調味料・こうじなど	チーズ	チーズ	ちいず
199	51510	1.433	1.43	体	生産物	食料	調味料・こうじなど	カレー	カレー	かれえ
358	51546	1.434	1.43	体	生産物	食料	菓子	お菓子	お菓子	おかし
355	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
585	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
171	51732	1.4349999	1.43	体	生産物	食料	飲料・たばこ	飲み物	飲み物	のみもの
178	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
179	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
172	51777	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーヒー	コーヒー	こおひい
185	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
197	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
447	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
153	51929	1.436	1.43	体	生産物	食料	薬剤・薬品	薬（くすり）	薬	くすり
85	52391	1.4400001	1.44	体	生産物	住居	住居	家（いえ）	家	いえ
563	52391	1.4400001	1.44	体	生産物	住居	住居	家（いえ）	家	いえ
84	52392	1.4400001	1.44	体	生産物	住居	住居	うち（家）	うち	うち
237	52553	1.441	1.44	体	生産物	住居	家屋・建物	建物	建物	たてもの
377	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
575	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
91	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
245	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
246	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
543	53018	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	玄関	玄関	げんかん
238	53027	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	台所	台所	だいどころ
169	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
168	53064	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	お手洗い	お手洗い	おてあらい
126	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
162	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
240	53210	1.444	1.44	体	生産物	住居	屋根・柱・壁・窓・天井など	窓	窓	まど
88	53263	1.4450001	1.44	体	生産物	住居	棚・台・壇など	本棚	本棚	ほんだな
376	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
576	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
243	53347	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	ドア	ドア	どあ
89	53456	1.447	1.44	体	生産物	住居	家具	机	机	つくえ
100	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
590	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
90	53482	1.447	1.44	体	生産物	住居	家具	椅子（いす）	椅子	いす
368	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
236	53579	1.447	1.44	体	生産物	住居	家具	ふろ	ふろ	ふろ
444	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
210	53950	1.4513	1.45	体	生産物	道具	箱など	ポスト	ポスト	ぽすと
213	53969	1.4514	1.45	体	生産物	道具	袋・かばんなど	封筒	封筒	ふうとう
337	54008	1.4514	1.45	体	生産物	道具	袋・かばんなど	財布	財布	さいふ
233	54021	1.4514	1.45	体	生産物	道具	袋・かばんなど	かばん	かばん	かばん
352	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
532	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
354	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
541	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
180	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
524	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
177	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
184	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
189	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
188	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
538	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
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
595	56572	1.465	1.46	体	生産物	機械	乗り物（陸上）	タクシー	タクシー	たくしい
30	56602	1.465	1.46	体	生産物	機械	乗り物（陸上）	バス	バス	ばす
170	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
165	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
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
34	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
539	61030	1.525	1.52	体	自然	天地	川・湖	池	池	いけ
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
528	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
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
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
540	69959	2.152	2.15	用	関係	作用	進行・過程・経由	曲がる	曲がる	まがる
9	70119	2.1521001	2.15	用	関係	作用	移動・発着	出掛ける	出掛ける	でかける
209	70181	2.1521001	2.15	用	関係	作用	移動・発着	着く	着く	つく
23	70238	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	歩く	歩く	あるく
20	70265	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	走る	走る	はしる
26	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
87	70931	2.1526	2.15	用	関係	作用	進退	かえる（帰・返）	かえる	かえる
1	71127	2.1526999	2.15	用	関係	作用	往復	行（い）く	行く	いく
181	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
332	71811	2.1535001	2.15	用	関係	作用	包み・覆いなど	かぶる	かぶる	かぶる
161	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
463	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
166	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
589	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
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
571	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
472	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
97	79593	2.3102	2.31	用	活動	言語	名	名のる	名のる	なのる
478	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
480	80001	2.3131001	2.31	用	活動	言語	話・談話	語る	語る	かたる
113	80087	2.3132	2.31	用	活動	言語	問答	きく（聞・聴）	きく	きく
147	80142	2.3132	2.31	用	活動	言語	問答	答える	答える	こたえる
54	80639	2.3150001	2.31	用	活動	言語	読み	読む	読む	よむ
473	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
57	80748	2.3151	2.31	用	活動	言語	書き	コピーする	コピーする	こぴいする
555	80748	2.3151	2.31	用	活動	言語	書き	コピーする	コピーする	こぴいする
451	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
596	81423	2.332	2.33	用	活動	生活	労働・作業・休暇	勤める	勤める	つとめる
191	81700	2.3331001	2.33	用	活動	生活	食生活	食べる	食べる	たべる
331	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
338	81835	2.3332	2.33	用	活動	生活	衣生活	着る	着る	きる
330	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
552	81858	2.3332	2.33	用	活動	生活	衣生活	は（穿）く［ズボンを～］	はく	はく
328	81872	2.3332	2.33	用	活動	生活	衣生活	脱ぐ	脱ぐ	ぬぐ
241	81948	2.3333001	2.33	用	活動	生活	住生活	住む	住む	すむ
244	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
15	82317	2.3369999	2.33	用	活動	生活	遊楽	遊ぶ	遊ぶ	あそぶ
14	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
568	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
569	82358	2.3371	2.33	用	活動	生活	旅・行楽	旅行する	旅行する	りょこうする
24	82483	2.3374	2.33	用	活動	生活	スポーツ	泳ぐ	泳ぐ	およぐ
122	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
98	82694	2.3390999	2.33	用	活動	生活	立ち居	寝る	寝る	ねる
121	82724	2.3390999	2.33	用	活動	生活	立ち居	座る	座る	すわる
183	83154	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	飲む	飲む	のむ
45	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
542	83250	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	吸う	吸う	すう
44	83509	2.3429999	2.34	用	活動	行為	行為・活動	やる	やる	やる
48	83625	2.3429999	2.34	用	活動	行為	行為・活動	働く	働く	はたらく
11	84044	2.352	2.35	用	活動	交わり	応接・送迎	会う	会う	あう
140	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
232	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
580	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
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
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
562	91632	3.1331999	3.13	相	関係	様相	良不良・適不適	よい	よい	よい
282	91633	3.1331999	3.13	相	関係	様相	良不良・適不適	いい	いい	いい
289	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
274	91975	3.1341	3.13	相	関係	様相	弛緩・粗密・繁簡	薄い	薄い	うすい
287	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
294	92133	3.1345	3.13	相	関係	様相	美醜	汚い	汚い	きたない
139	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
143	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
285	92331	3.1400001	3.14	相	関係	力	力	強い	強い	つよい
284	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
441	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
440	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
530	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
531	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
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
437	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
546	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
148	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
279	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
529	95240	3.3011	3.30	相	活動	心	快・喜び	楽しい	楽しい	たのしい
286	95258	3.3011	3.30	相	活動	心	快・喜び	おもしろい	おもしろい	おもしろい
295	95270	3.3011	3.30	相	活動	心	快・喜び	つまらない	つまらない	つまらない
18	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
455	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
588	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
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
594	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
207	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
577	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	206	834	0	不好意思	0	\N	\N
2	381	990	0	八月	0	\N	\N
3	124	229	0	班	0	\N	\N
4	152	382	0	病	0	\N	\N
5	204	257	0	不	0	\N	\N
6	204	4	0	不	0	\N	\N
7	204	23	0	不	0	\N	\N
8	204	24	0	不	0	\N	\N
9	204	101	0	不	0	\N	\N
10	204	103	0	不	0	\N	\N
11	204	104	0	不	0	\N	\N
12	204	105	0	不	0	\N	\N
13	204	210	0	不	0	\N	\N
14	204	214	0	不	0	\N	\N
15	59	52	0	本	0	\N	\N
18	378	640	0	笔	0	\N	\N
21	191	378	0	吃	0	\N	\N
22	191	394	0	吃	0	\N	\N
23	191	1067	0	吃	0	\N	\N
27	418	151	0	春天	0	\N	\N
28	94	539	0	床	0	\N	\N
29	441	254	0	常常	0	\N	\N
30	409	415	0	星期五	0	\N	\N
31	331	179	0	穿	0	\N	\N
32	240	65	0	窗户	0	\N	\N
33	169	951	0	厕所	0	\N	\N
34	41	179	0	衬衫	0	\N	\N
35	327	605	0		0	\N	\N
36	51	7	0	词典	0	\N	\N
37	164	384	0	车站	0	\N	\N
40	330	246	0		0	\N	\N
41	290	246	0	多	0	\N	\N
42	290	92	0	多	0	\N	\N
43	290	231	0	多	0	\N	\N
44	290	651	0	多	0	\N	\N
45	290	1048	0	多	0	\N	\N
46	65	54	0	多少	0	\N	\N
49	65	909	0	多少	0	\N	\N
50	79	254	0	打扫	0	\N	\N
51	86	254	0		0	\N	\N
52	267	241	0	大	0	\N	\N
53	229	13	0	大衣	0	\N	\N
54	496	285	0	大家	0	\N	\N
55	134	168	0	大学	0	\N	\N
56	104	448	0	地图	0	\N	\N
57	165	290	0	地铁	0	\N	\N
58	438	170	0	的时候	0	\N	\N
59	438	177	0	的时候	0	\N	\N
60	438	750	0	的时候	0	\N	\N
61	424	421	0	点	0	\N	\N
62	424	422	0	点	0	\N	\N
63	424	870	0	点	0	\N	\N
64	424	872	0	点	0	\N	\N
65	209	165	0	到	0	\N	\N
66	209	318	0	到	0	\N	\N
67	209	1099	0	到	0	\N	\N
68	448	36	0	电影	0	\N	\N
69	448	145	0	电影	0	\N	\N
70	448	327	0	电影	0	\N	\N
71	159	201	0	电梯	0	\N	\N
72	374	903	0	电脑	0	\N	\N
73	374	1166	0	电脑	0	\N	\N
74	101	563	0	电视	0	\N	\N
75	46	534	0	电话	0	\N	\N
76	46	917	0	电话	0	\N	\N
77	46	926	0	电话	0	\N	\N
78	181	196	0	放	0	\N	\N
79	507	640	0	方便	0	\N	\N
80	91	178	0	房间	0	\N	\N
81	91	914	0	房间	0	\N	\N
82	56	276	0	复印	0	\N	\N
83	467	282	0	风	0	\N	\N
84	3	533	0	飞机	0	\N	\N
85	361	1143	0	饭	0	\N	\N
86	445	980	1	歌	0	\N	\N
87	44	323	0	干	0	\N	\N
88	44	931	0	干	0	\N	\N
89	44	752	0	干	0	\N	\N
90	42	1175	0	公司	0	\N	\N
91	242	292	0	公园	0	\N	\N
93	47	611	0	工作	0	\N	\N
94	48	374	0		0	\N	\N
95	63	234	0	高	0	\N	\N
96	63	236	0	高	0	\N	\N
97	63	238	0	高	0	\N	\N
98	63	90	0	高	0	\N	\N
99	310	427	0	哥哥	0	\N	\N
100	322	427	0		0	\N	\N
101	329	722	0	挂	0	\N	\N
103	170	215	0	火车	0	\N	\N
104	87	166	0	回	0	\N	\N
105	87	198	0	回	0	\N	\N
106	87	506	0	回	0	\N	\N
107	183	224	0	喝	0	\N	\N
108	183	331	0	喝	0	\N	\N
109	264	83	0	厚	0	\N	\N
110	432	1114	0	后天	0	\N	\N
111	205	873	0	好	0	\N	\N
112	205	877	0	好	0	\N	\N
113	205	956	0	好	0	\N	\N
114	282	69	0		0	\N	\N
115	289	973	0	坏	0	\N	\N
116	487	42	0	孩子	0	\N	\N
117	487	197	0	孩子	0	\N	\N
118	291	28	0	黑	0	\N	\N
119	471	385	0	汉字	0	\N	\N
120	6	158	0	汉语	0	\N	\N
121	6	159	0	汉语	0	\N	\N
122	6	472	0	汉语	0	\N	\N
123	474	184	0	话	0	\N	\N
124	436	263	0	还	0	\N	\N
125	216	724	0	还	0	\N	\N
126	323	1008	0	姐姐	0	\N	\N
127	84	264	0	家	0	\N	\N
128	85	264	0		0	\N	\N
129	217	1130	0	寄	0	\N	\N
130	140	704	0	教	0	\N	\N
131	125	203	0	教室	0	\N	\N
132	125	943	0	教室	0	\N	\N
134	103	281	0		0	\N	\N
135	422	235	0	今天	0	\N	\N
136	52	204	0	借	0	\N	\N
137	52	1058	0	借	0	\N	\N
138	221	1084	0	借给	0	\N	\N
139	185	308	0	酒	0	\N	\N
140	64	194	0	几	0	\N	\N
141	11	869	0	见面	0	\N	\N
142	11	874	0	见面	0	\N	\N
143	359	443	0	鸡蛋	0	\N	\N
144	25	222	0	快	0	\N	\N
145	54	140	0	看	0	\N	\N
146	141	169	0	考试	0	\N	\N
147	172	545	0	咖啡	0	\N	\N
148	513	167	0	开始	0	\N	\N
150	131	1	0	留学生	0	\N	\N
151	131	25	0	留学生	0	\N	\N
152	13	548	0	旅行	0	\N	\N
153	14	548	0		0	\N	\N
154	461	686	0	冷	0	\N	\N
155	33	251	0	路	0	\N	\N
156	133	262	0	老师	0	\N	\N
157	133	2	0	老师	0	\N	\N
158	460	181	0	凉快	0	\N	\N
159	344	317	0	脸	0	\N	\N
160	49	303	0	忙	0	\N	\N
161	515	57	0	没有	0	\N	\N
162	21	500	0	慢慢儿	0	\N	\N
163	423	48	0	明天	0	\N	\N
164	417	46	0	明年	0	\N	\N
165	193	335	0	面包	0	\N	\N
166	231	312	0	毛衣	0	\N	\N
167	222	144	0	买	0	\N	\N
168	222	213	0	买	0	\N	\N
169	77	840	0		0	\N	\N
170	225	968	0		0	\N	\N
171	234	845	0	卖	0	\N	\N
172	315	1130	0	妈妈	0	\N	\N
173	325	1130	0		0	\N	\N
174	243	107	0	门	0	\N	\N
175	376	107	0		0	\N	\N
176	377	197	0		0	\N	\N
177	377	293	0		0	\N	\N
178	377	512	0		0	\N	\N
179	443	262	0	马上	0	\N	\N
180	493	317	0	女孩子	0	\N	\N
181	466	151	0	暖和	0	\N	\N
182	519	859	0	那	0	\N	\N
183	519	1205	0	那	0	\N	\N
184	521	853	0		0	\N	\N
186	257	557	0	那个	0	\N	\N
187	257	669	0	那个	0	\N	\N
188	108	66	0	那儿	0	\N	\N
190	108	946	0	那儿	0	\N	\N
191	108	756	0	那儿	0	\N	\N
192	410	46	0	年	0	\N	\N
193	254	340	0	你	0	\N	\N
194	254	428	0	你	0	\N	\N
195	259	10	0	哪个	0	\N	\N
196	259	358	0	哪个	0	\N	\N
197	259	383	0	哪个	0	\N	\N
198	109	105	0	哪儿	0	\N	\N
199	109	380	0	哪儿	0	\N	\N
201	255	341	1	您	0	\N	\N
202	255	119	2	您	0	\N	\N
203	255	1140	3	您	0	\N	\N
204	139	472	0	难	0	\N	\N
205	139	473	0	难	0	\N	\N
206	287	75	0	漂亮	0	\N	\N
207	287	82	0	漂亮	0	\N	\N
208	61	852	0	便宜	0	\N	\N
209	123	97	0	朋友	0	\N	\N
210	105	61	0	旁边	0	\N	\N
211	76	117	0	菜	0	\N	\N
212	76	1061	0	菜	0	\N	\N
213	112	952	0		0	\N	\N
214	20	222	0	跑	0	\N	\N
215	38	249	0	汽车	0	\N	\N
216	1	233	0	去	0	\N	\N
217	1	132	0	去	0	\N	\N
218	433	191	0	前天	0	\N	\N
219	232	198	0		0	\N	\N
220	232	272	0		0	\N	\N
221	271	212	0	轻	0	\N	\N
226	337	774	0	钱包	0	\N	\N
227	491	62	0	人	0	\N	\N
228	495	349	0		0	\N	\N
229	8	1185	0	日语	0	\N	\N
230	8	1014	0	日语	0	\N	\N
231	458	72	0	热	0	\N	\N
233	382	47	0	四月	0	\N	\N
234	154	253	0	死	0	\N	\N
235	154	164	0	死	0	\N	\N
236	346	535	0	手	0	\N	\N
237	333	84	0	手绢	0	\N	\N
238	260	978	0	什么	0	\N	\N
239	439	381	0	什么时候	0	\N	\N
240	394	410	0	十一月	0	\N	\N
241	132	987	0	暑假	0	\N	\N
242	62	840	0	商店	0	\N	\N
244	166	533	0		0	\N	\N
245	427	1114	0	上午	0	\N	\N
246	306	449	0	上	0	\N	\N
247	136	173	0	上课	0	\N	\N
248	136	203	0	上课	0	\N	\N
249	343	1047	0	身体	0	\N	\N
250	98	153	0	睡觉	0	\N	\N
251	95	116	0	收音机	0	\N	\N
252	88	450	0	书架	0	\N	\N
253	472	488	0	说	0	\N	\N
254	472	553	0	说	0	\N	\N
255	478	309	0	说话	0	\N	\N
257	251	379	0		0	\N	\N
258	252	528	0	谁	0	\N	\N
259	253	379	0		0	\N	\N
260	247	324	0	他	0	\N	\N
261	247	342	0	他	0	\N	\N
262	248	327	0	他们	0	\N	\N
263	248	345	0	他们	0	\N	\N
264	465	581	0	天气	0	\N	\N
265	465	1163	0	天气	0	\N	\N
266	113	36	0	听	0	\N	\N
267	113	184	0	听	0	\N	\N
268	50	12	0	图书馆	0	\N	\N
269	50	504	0	图书馆	0	\N	\N
270	212	189	0	贴	0	\N	\N
272	250	325	0	我们	0	\N	\N
273	250	343	0	我们	0	\N	\N
274	4	857	0	外国	0	\N	\N
275	15	256	0	玩儿	0	\N	\N
276	356	601	0	午饭	0	\N	\N
277	411	964	0	秋天	0	\N	\N
278	508	1035	0	晚会	0	\N	\N
279	430	1163	0	晚上	0	\N	\N
280	357	142	0	晚饭	0	\N	\N
281	364	142	0		0	\N	\N
282	463	209	0	下雨	0	\N	\N
283	421	40	0	下午	0	\N	\N
284	402	169	0	下个星期	0	\N	\N
285	402	1050	0	下个星期	0	\N	\N
286	390	1183	0	下个月	0	\N	\N
287	414	225	0	夏天	0	\N	\N
288	127	21	0	学校	0	\N	\N
289	127	61	0	学校	0	\N	\N
291	130	346	0		0	\N	\N
292	129	326	0	学习	0	\N	\N
293	18	976	0		0	\N	\N
294	455	758	0	喜欢	0	\N	\N
295	473	146	0	写	0	\N	\N
296	447	108	0	烟	0	\N	\N
297	276	139	0	小	0	\N	\N
298	442	122	0	小时	0	\N	\N
299	442	128	0	小时	0	\N	\N
300	214	255	0	信	0	\N	\N
301	213	189	0	信封	0	\N	\N
302	275	250	0	新	0	\N	\N
303	97	762	0	姓	0	\N	\N
304	97	763	0	姓	0	\N	\N
305	403	411	0	星期一	0	\N	\N
306	405	413	0	星期三	0	\N	\N
307	401	414	0	星期四	0	\N	\N
308	404	412	0	星期二	0	\N	\N
309	400	417	0	星期日	0	\N	\N
310	406	416	0	星期六	0	\N	\N
311	406	578	0	星期六	0	\N	\N
312	303	783	0	西边	0	\N	\N
313	93	546	0	洗	0	\N	\N
314	90	647	0	椅子	0	\N	\N
315	339	71	0	衣服	0	\N	\N
316	151	1052	0	医院	0	\N	\N
317	397	125	0	一个月	0	\N	\N
318	407	124	0	一个星期	0	\N	\N
319	407	826	0	一个星期	0	\N	\N
320	435	749	0	一边	0	\N	\N
321	464	211	0	雨	0	\N	\N
322	464	1163	0	雨	0	\N	\N
323	335	1162	0	雨伞	0	\N	\N
324	2	326	0	英语	0	\N	\N
325	452	981	0	音乐	0	\N	\N
326	348	180	0	眼睛	0	\N	\N
327	286	1034	0	有意思	0	\N	\N
329	434	153	0	已经	0	\N	\N
330	24	111	0	游泳	0	\N	\N
331	476	134	0	语	0	\N	\N
332	476	158	0	语	0	\N	\N
333	476	326	0	语	0	\N	\N
334	476	894	0	语	0	\N	\N
335	476	1014	0	语	0	\N	\N
336	476	1023	0	语	0	\N	\N
337	477	1180	0	词	0	\N	\N
338	27	983	0	运动	0	\N	\N
339	272	230	0	远	0	\N	\N
340	215	531	0	邮局	0	\N	\N
341	218	531	0	邮票	0	\N	\N
342	75	118	0	钥匙	0	\N	\N
343	121	175	0	坐	0	\N	\N
344	138	654	0	作业	0	\N	\N
345	425	577	0	昨天	0	\N	\N
346	262	217	0	自己	0	\N	\N
347	31	532	0	自行车	0	\N	\N
348	241	911	0	住	0	\N	\N
349	273	1134	0	重	0	\N	\N
350	367	1160	0	照相机	0	\N	\N
351	428	933	0	早上	0	\N	\N
352	23	251	0	走	0	\N	\N
353	516	509	0	一直	0	\N	\N
354	258	1001	0	怎么	0	\N	\N
355	122	207	0	站	0	\N	\N
356	220	448	0	张	0	\N	\N
357	58	12	0	杂志	0	\N	\N
358	58	64	0	杂志	0	\N	\N
359	89	187	0	桌子	0	\N	\N
360	100	650	0		0	\N	\N
361	509	17	0	纸	0	\N	\N
362	294	546	0	脏	0	\N	\N
364	256	294	0	这个	0	\N	\N
366	106	944	0	这儿	0	\N	\N
367	261	96	0	这么	0	\N	\N
368	261	833	0	这么	0	\N	\N
369	263	1125	0	这样	0	\N	\N
375	177	1210	1	杯子	0	\N	\N
376	524	1209	1	杯子	0	\N	\N
377	497	1211	1	白色	0	\N	\N
378	316	1212	1	伯父	0	\N	\N
380	274	1214	1	薄	0	\N	\N
382	227	1216	1	百货公司	0	\N	\N
383	219	1217	1	包裹	0	\N	\N
384	527	1219	1	傍晚	0	\N	\N
385	302	1220	1	北边	0	\N	\N
386	469	1221	1	冰	0	\N	\N
387	92	462	1	冰箱	0	\N	\N
388	203	1222	1	别客气	0	\N	\N
389	53	1223	1	报纸	0	\N	\N
390	189	1224	1	叉子	0	\N	\N
391	370	1225	1	擦掉	0	\N	\N
392	195	1226	1	餐厅	0	\N	\N
393	208	1227	1	出口	0	\N	\N
394	446	1228	1	唱歌	0	\N	\N
395	449	1229	1	唱片	0	\N	\N
396	238	1230	1	厨房	0	\N	\N
398	268	1232	1	粗	0	\N	\N
399	178	1233	1	茶	0	\N	\N
400	160	1234	1	车票	0	\N	\N
401	167	1235	1	打开	0	\N	\N
402	332	1236	1	戴	0	\N	\N
403	16	1237	1	大使馆	0	\N	\N
404	150	1238	1	大夫	0	\N	\N
405	115	1239	1	短	0	\N	\N
406	281	1240	1	低	0	\N	\N
407	358	1241	1	点心	0	\N	\N
408	158	1242	1	度	0	\N	\N
409	415	1243	1	冬天	0	\N	\N
410	187	1244	1	刀子	0	\N	\N
411	157	1245	1	肚子	0	\N	\N
412	299	1246	1	东边	0	\N	\N
413	349	1247	1	耳朵	0	\N	\N
414	386	1248	1	二月	0	\N	\N
415	486	1249	1	夫妻	0	\N	\N
416	317	1250	1	父母	0	\N	\N
417	318	1251	1	父亲	0	\N	\N
418	459	1252	1	晴	0	\N	\N
419	7	1253	1	饭店	0	\N	\N
420	155	1254	1	感冒	0	\N	\N
421	500	1255	1	光亮	0	\N	\N
422	30	1256	1	公共汽车	0	\N	\N
423	245	1257	1	公寓	0	\N	\N
424	10	1258	1	国家	0	\N	\N
425	163	1259	1	关	0	\N	\N
426	199	1260	1	咖喱饭	0	\N	\N
427	342	1261	1	胳膊	0	\N	\N
428	379	1262	1	钢笔	0	\N	\N
429	296	1263	1	横	0	\N	\N
434	147	1268	1	回答	0	\N	\N
436	116	1270	1	后面	0	\N	\N
437	186	1271	1	好吃	0	\N	\N
439	505	1273	1	红色	0	\N	\N
440	179	1274	1	红茶	0	\N	\N
441	365	1275	1	加	0	\N	\N
442	80	1276	1	家人	0	\N	\N
444	450	1278	1	吉他	0	\N	\N
445	350	1279	1	腿	0	\N	\N
446	278	1280	1	旧	0	\N	\N
447	111	1281	1		0	\N	\N
448	396	1282	1	九月	0	\N	\N
449	511	1283	1	系	0	\N	\N
450	237	1284	1	建筑物	0	\N	\N
451	73	1285	1	交	0	\N	\N
452	412	1286	1	今年	0	\N	\N
453	518	1287	1	精神	0	\N	\N
454	12	1288	1	假	0	\N	\N
455	114	1289	1	剪	0	\N	\N
456	375	1290	1	胶卷	0	\N	\N
457	37	1291	1		0	\N	\N
460	336	1294	1	口袋	0	\N	\N
461	173	1295	1	咖啡厅	0	\N	\N
462	270	1296	1	宽	0	\N	\N
463	184	1297	1	筷子	0	\N	\N
464	230	1298	1	裤子	0	\N	\N
465	297	63	1	里边	0	\N	\N
466	283	1299	1	明亮	0	\N	\N
467	239	1300	1	淋浴	0	\N	\N
469	32	1302	1	十字路口	0	\N	\N
470	226	1303	1	楼	0	\N	\N
471	162	1304	1	楼梯	0	\N	\N
473	526	1306	1		0	\N	\N
474	389	1307	1	六月	0	\N	\N
475	480	1309	1	聊天	0	\N	\N
476	194	1310	1	辣	0	\N	\N
477	372	1311	1	录音机	0	\N	\N
478	142	1312	1	练习	0	\N	\N
480	498	1314	1	蓝色	0	\N	\N
481	40	1315	1	领带	0	\N	\N
482	320	1316	1	姐妹	0	\N	\N
483	319	1317	1		0	\N	\N
484	223	1318	1	帽子	0	\N	\N
485	288	1319	1	慢	0	\N	\N
486	211	1320	1	明信片	0	\N	\N
487	74	1321	1	菜铺	0	\N	\N
488	399	1322	1		0	\N	\N
490	384	1324	1	每个月	0	\N	\N
491	60	1325	1	牛肉	0	\N	\N
492	175	1326	1	牛奶	0	\N	\N
493	489	1327	1	女的	0	\N	\N
494	492	1328	1	男的	0	\N	\N
496	305	1330	1	南边	0	\N	\N
498	19	1332	1	拿手	0	\N	\N
499	312	1334	1	奶奶	0	\N	\N
500	174	1335	1	柠檬	0	\N	\N
501	192	1336	1	难吃	0	\N	\N
502	440	1337	1		0	\N	\N
503	530	1338	1		0	\N	\N
504	531	1339	1	有时	0	\N	\N
505	110	1340	1	派出所	0	\N	\N
506	197	1341	1	葡萄酒	0	\N	\N
507	482	1342	1	平假名	0	\N	\N
508	483	1343	1	片假名	0	\N	\N
509	532	1344	1	碟子	0	\N	\N
510	99	1345	1	起床	0	\N	\N
511	416	1346	1	去年	0	\N	\N
512	488	1347	1	妻子	0	\N	\N
513	388	1348	1	七月	0	\N	\N
514	457	1349	1	晴天	0	\N	\N
515	420	1350	1		0	\N	\N
516	533	1351	1	前年	0	\N	\N
517	117	1352	1	前面	0	\N	\N
518	228	1353	1	裙子	0	\N	\N
520	207	1355	1	请	0	\N	\N
522	369	1357	1	铅笔	0	\N	\N
523	71	1358	1	肉	0	\N	\N
524	534	1359	1	干酪	0	\N	\N
525	202	1360	1	入口	0	\N	\N
526	143	1361	1	容易	0	\N	\N
527	284	1362	1	软弱	0	\N	\N
528	392	1363	1	三月	0	\N	\N
529	35	1364	1	散步	0	\N	\N
530	395	1365	1	十月	0	\N	\N
531	385	1366	1	十二月	0	\N	\N
532	393	1367	1	上个月	0	\N	\N
533	196	1368	1	食堂	0	\N	\N
534	536	1369	1	吃的	0	\N	\N
535	502	1370	1	深	0	\N	\N
536	66	1371	1	水果	0	\N	\N
537	456	1372	1	声音	0	\N	\N
538	96	1373	1	收录机	0	\N	\N
539	67	1374	1	蔬菜	0	\N	\N
540	233	1375	1	书包	0	\N	\N
541	301	1376	1	竖	0	\N	\N
544	328	1379	1	脱	0	\N	\N
545	26	1380	1	跳	0	\N	\N
546	182	1381	1	甜	0	\N	\N
547	176	1382	1	糖	0	\N	\N
548	148	1383	1	疼	0	\N	\N
549	156	1384	1	头	0	\N	\N
550	451	1385	1	弹	0	\N	\N
551	334	1387	1	拖鞋	0	\N	\N
552	538	1388	1	勺子	0	\N	\N
553	539	1389	1	池子	0	\N	\N
554	28	1390	1	讨厌	0	\N	\N
555	249	1391	1	我	0	\N	\N
556	535	1392	1	外衣	0	\N	\N
557	5	1393	1	外国人	0	\N	\N
558	298	1394	1	外面	0	\N	\N
559	391	1395	1	五月	0	\N	\N
561	540	1397	1	拐	0	\N	\N
562	541	1398	1	饭碗	0	\N	\N
563	295	1399	1	无聊	0	\N	\N
564	326	1400	1	袜子	0	\N	\N
565	537	1401	1	问题	0	\N	\N
567	304	1403	1	下面	0	\N	\N
568	542	1404	1	抽	0	\N	\N
569	311	1405	1	兄弟	0	\N	\N
570	43	1406	1	西装	0	\N	\N
571	340	1407	1		0	\N	\N
572	462	1408	1	雪	0	\N	\N
573	78	1409	1	洗衣服	0	\N	\N
574	168	1410	1	洗手间	0	\N	\N
575	244	1411	1	洗澡	0	\N	\N
576	224	1412	1	鞋	0	\N	\N
577	266	1413	1	细	0	\N	\N
578	481	1414	1	意思	0	\N	\N
579	387	1416	1	一月	0	\N	\N
580	82	1417	1	院子	0	\N	\N
581	118	1418	1	右边	0	\N	\N
583	371	1420	1	眼镜	0	\N	\N
584	520	1421	1	也许	0	\N	\N
585	529	1422	1	愉快	0	\N	\N
586	517	1423	1	有名	0	\N	\N
587	29	1424	1	游泳池	0	\N	\N
588	444	1425	1	烟灰缸	0	\N	\N
589	380	1426	1	圆珠笔	0	\N	\N
590	363	1427	1	盐	0	\N	\N
591	153	1428	1	药	0	\N	\N
592	475	1429	1	语言	0	\N	\N
593	210	1430	1	邮筒	0	\N	\N
594	201	1431	1	银行	0	\N	\N
595	468	1432	1	阴天	0	\N	\N
596	501	1433	1	颜色	0	\N	\N
597	171	1434	1	饮料	0	\N	\N
598	68	1435	1	鱼	0	\N	\N
599	119	1436	1	左边	0	\N	\N
600	137	1437	1	作文	0	\N	\N
601	265	1438	1	窄	0	\N	\N
602	545	1439	1	照片	0	\N	\N
603	544	1440	1	丈夫	0	\N	\N
604	514	1441	1	正好	0	\N	\N
605	543	1443	1	正门	0	\N	\N
606	360	1444	1	早饭	0	\N	\N
607	126	1445	1	走廊	0	\N	\N
608	546	1446	1	整	0	\N	\N
609	69	1447	1	猪肉	0	\N	\N
610	341	1448	1	嘴	0	\N	\N
611	485	1449	1	众多	0	\N	\N
613	383	1451	1	这个月	0	\N	\N
614	398	1452	1	这个星期	0	\N	\N
615	366	1207	1	安	0	\N	\N
616	547	1453	1	叔父	0	\N	\N
617	548	1454	1	姑夫	0	\N	\N
618	549	1455	1	舅父	0	\N	\N
619	550	1456	1	姨夫	0	\N	\N
621	309	1458	2		0	\N	\N
622	551	1459	1	昨夜	0	\N	\N
623	552	1460	1	穿	0	\N	\N
624	553	1461	1	汗衫	0	\N	\N
626	554	1462	1	打扫	0	\N	\N
627	555	1463	1	复印	0	\N	\N
628	556	1464	1	伯母	0	\N	\N
629	557	1465	1	婶母	0	\N	\N
630	558	1466	1	姨母	0	\N	\N
631	559	1467	1	高	0	\N	\N
632	560	1468	1	哥哥	0	\N	\N
633	561	1469	1	后面	0	\N	\N
634	562	69	0	好	0	\N	\N
635	563	1470	1	房子	0	\N	\N
636	277	1281	0	近	0	\N	\N
637	564	1471	1	附近	0	\N	\N
638	102	281	1	警察	0	\N	\N
639	567	281	0	警察	0	\N	\N
640	70	1472	1	鸡肉	0	\N	\N
641	568	1288	0		0	\N	\N
642	569	1473	1	旅行	0	\N	\N
643	570	1474	1	老婆	0	\N	\N
644	571	1475	1	练习	0	\N	\N
645	572	968	0	买东西	0	\N	\N
646	573	254	0	妈妈	0	\N	\N
647	574	1476	1	每个星期	0	\N	\N
648	575	512	0	门	0	\N	\N
649	576	1259	0		0	\N	\N
650	577	853	0	那	0	\N	\N
651	269	1477	0	年轻	0	\N	\N
652	578	952	0	旁边	0	\N	\N
653	579	1478	1	前面	0	\N	\N
654	580	272	0	请	0	\N	\N
655	580	198	0	请	0	\N	\N
656	581	3	0	人	0	\N	\N
657	583	1479	1	哪位	0	\N	\N
658	584	1480	1	有人	0	\N	\N
659	585	1481	1	糖	0	\N	\N
660	586	1482	1	问题	0	\N	\N
661	587	142	0	晚饭	0	\N	\N
662	588	1483	1	喜欢	0	\N	\N
663	589	290	0	坐	0	\N	\N
664	590	650	0	桌子	0	\N	\N
665	591	1484	1	那儿	0	\N	\N
666	292	1485	1	安静	0	\N	\N
667	9	1486	1	出去	0	\N	\N
668	353	1487	1	黄油	0	\N	\N
669	453	1488	1	画	0	\N	\N
671	419	1489	1	后年	0	\N	\N
672	523	1490	1	姥姥	0	\N	\N
673	592	1491	1	老爷	0	\N	\N
675	413	1492	1	每年	0	\N	\N
676	593	346	0	学生	0	\N	\N
677	128	1493	1	学生	0	\N	\N
680	36	1495	2	河	0	\N	\N
681	596	1496	1	工作	0	\N	\N
682	72	1497	0	要	0	\N	\N
683	81	1498	0	家庭	0	\N	\N
684	120	1022	1	长	0	\N	\N
685	120	883	2	长	0	\N	\N
686	120	1499	3	长	0	\N	\N
687	135	1500	0	笔记本	0	\N	\N
688	149	1501	0	牙齿	0	\N	\N
689	161	1502	0	下	0	\N	\N
690	200	1503	0	钱	0	\N	\N
691	280	1504	1	热闹	0	\N	\N
692	280	495	2	热闹	0	\N	\N
695	293	1506	1	少	0	\N	\N
696	293	93	2	少	0	\N	\N
697	313	1507	1	爷爷	0	\N	\N
698	324	18	1	爸爸	0	\N	\N
699	324	1508	2	爸爸	0	\N	\N
700	347	1509	1	鼻子	0	\N	\N
701	345	1510	0	腿	0	\N	\N
702	368	1301	1	炉子	0	\N	\N
703	368	1511	2	炉子	0	\N	\N
704	373	1512	1	钟表	0	\N	\N
705	597	1513	1	星期天	0	\N	\N
706	429	1514	1	白天	0	\N	\N
707	479	1396	1	文章	0	\N	\N
708	479	1515	2	文章	0	\N	\N
709	484	1516	1	成年人	0	\N	\N
710	490	1517	1	男孩子	0	\N	\N
711	503	1518	1	黄色	0	\N	\N
712	504	1519	1	黑色	0	\N	\N
713	506	1520	1	绿色	0	\N	\N
714	512	1521	1	推	0	\N	\N
715	594	1522	1	大概	0	\N	\N
716	595	1523	1	出租车	0	\N	\N
717	574	1322	0	每个星期	0	\N	\N
718	362	1292	1	酱油	0	\N	\N
719	285	1505	0	强	0	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: zh
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
523	25
524	15
527	33
528	13
529	23
531	34
532	28
533	32
534	16
535	19
536	16
537	11
538	16
539	3
540	3
541	28
542	4
543	20
544	38
545	35
546	34
547	25
548	25
549	25
550	25
551	33
552	26
553	26
554	7
555	5
556	25
557	25
558	25
559	24
560	25
561	24
562	23
563	7
564	9
565	9
566	9
567	9
568	1
569	1
570	25
571	11
572	19
573	25
574	31
575	29
576	29
578	9
579	24
580	19
581	38
582	21
583	21
584	21
585	28
586	11
587	28
588	2
589	14
590	8
591	9
592	25
593	11
595	3
596	4
597	31
572	7
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
376	门	0	m	\N
1	去　qù	1	q	\N
2	英语 yīngyǔ	1	y	\N
3	飞机 fēijī	1	f	\N
4	外国　wàiguó	1	w	\N
5	外国人 wàiguórén	1	w	\N
6	汉语 hànyǔ	1	h	\N
7	饭店 fàndiàn	1	f	\N
8	日语　Rìyǔ	1	r	\N
9	出去　chūqù	1	c	\N
10	国家 guójiā	1	g	\N
11	见面　jiàn miàn	1	j	\N
12	假　jià	1	j	\N
13	旅行 lǚxíng	1	l	\N
14	旅行	0	l	\N
15	玩儿　wánr	1	w	\N
16	大使馆 dàshǐguǎn	1	d	\N
18	喜欢 xǐhuan	0	x	\N
19	拿手　náshǒu	1	n	\N
20	跑 pǎo	1	p	\N
21	慢慢儿　mànmānr	1	m	\N
23	走　zǒu	1	z	\N
24	游泳 yóuyǒng	1	y	\N
25	快 kuài	1	k	\N
26	跳　tiào	1	t	\N
27	运动　yùndòng	1	y	\N
28	讨厌　tǎoyàn	1	t	\N
29	游泳池 yóuyǒngchí	1	y	\N
30	公共汽车　gōnggòngqìchē	1	g	\N
31	自行车 zìxíngchē	1	z	\N
32	十字路口 shízìlùkǒu	1	l	\N
33	路　lù	1	l	\N
35	散步　sànbù	1	s	\N
36	河　hé	1	h	\N
37	的士 díshì	0	j	\N
38	汽车 qìchē	1	q	\N
40	领带　lǐngdài	1	l	\N
41	衬衫 chènshān	1	c	\N
42	公司　gōngsī	1	g	\N
43	西装 xīzhuāng	1	x	\N
44	干 gàn	1	g	\N
46	电话 diànhuà	1	d	\N
47	工作 gōngzuò	1	g	\N
48	工作	0	g	\N
49	忙　máng	1	m	\N
50	图书馆　túshūguǎn	1	t	\N
51	词典 cídiǎn	1	c	\N
52	借　jiè	1	j	\N
53	报纸　bàozhǐ	1	b	\N
54	看　kàn	1	k	\N
56	复印 fùyìn	1	f	\N
58	杂志 zázhì	1	z	\N
59	本　běn	1	b	\N
60	牛肉 niúròu	1	n	\N
61	便宜　piányi	1	p	\N
62	商店 shāngdiàn	1	s	\N
63	高 gāo	1	g	\N
64	几 jǐ	1	j	\N
65	多少 duōshao	1	d	\N
66	水果 shuǐguǒ	1	s	\N
67	蔬菜　shūcài	1	s	\N
68	鱼　yú	1	y	\N
69	猪肉 zhūròu	1	z	\N
70	鸡肉 jīròu	1	j	\N
71	肉 ròu	1	r	\N
72	要　yào	1	y	\N
73	交　jiāo	1	j	\N
74	菜铺 càipù	1	c	\N
75	钥匙 yàoshi	1	y	\N
76	菜　cài	1	c	\N
77	买东西　mǎidōngxi	1	m	\N
78	洗衣服 xǐyīfu	1	x	\N
79	打扫　dǎsǎo	1	d	\N
80	家人 jiārén	1	j	\N
81	家庭 jiātíng	1	j	\N
82	院子 yuànzi	1	y	\N
84	家　jiā	1	j	\N
85	家	0	j	\N
86	打扫	0	d	\N
87	回　huí	1	h	\N
88	书架　shūjià	1	s	\N
89	桌子 zhuōzi	1	z	\N
90	椅子　yǐzi	1	y	\N
91	房间 fángjiān	1	f	\N
92	冰箱　bīngxiāng	1	b	\N
93	洗 xǐ	1	x	\N
94	床　chuáng	1	c	\N
95	收音机　shōuyīnjī	1	s	\N
96	收录机 shōulùjī	1	s	\N
97	姓 xìng	1	x	\N
98	睡觉　shuìjiào	1	s	\N
99	起床 qǐchuáng	1	q	\N
100	桌子	0	z	\N
101	电视 diànshì	1	d	\N
102	警察　jǐngchá	1	j	\N
103	警察	0	j	\N
104	地图 dìtú	1	d	\N
105	旁边 pángbiān	1	p	\N
106	这儿 zhèr	1	z	\N
108	那儿 nàr	1	n	\N
109	哪儿 nǎr	1	n	\N
110	派出所 pàichūsuǒ	1	p	\N
111	近 jìn	0	j	\N
112	旁边	0	p	\N
113	听　tīng	1	t	\N
114	剪 jiǎn	1	j	\N
115	短　duǎn	1	d	\N
116	后面　hòumian	1	h	\N
117	前面　qiánmian	1	q	\N
118	右边 yòubian	1	y	\N
119	左边 zuǒbian	1	z	\N
120	长 cháng	1	c	\N
121	坐　zuò	1	z	\N
122	站 zhàn	1	z	\N
123	朋友 péngyou	1	p	\N
124	班 bān	1	b	\N
125	教室 jiàoshì	1	j	\N
126	走廊 zǒuláng	1	z	\N
127	学校 xuéxiào	1	x	\N
128	学生 xuésheng	1	x	\N
129	学习 xuéxí	1	x	\N
130	学生	0	x	\N
131	留学生 liúxuéshēng	1	l	\N
132	暑假 shǔjià	1	s	\N
133	老师　lǎoshī	1	l	\N
134	大学 dàxué	1	d	\N
135	笔记本 bǐjìběn	1	b	\N
136	上课　shàngkè	1	s	\N
137	作文 zuòwén	1	z	\N
138	作业　zuòyè	1	z	\N
139	难　nán	1	n	\N
140	教　jiāo	1	j	\N
141	考试　kǎoshì	1	k	\N
142	练习　liànxí	1	l	\N
143	容易　róngyì	1	r	\N
147	回答 huídá	1	h	\N
148	疼 téng	1	t	\N
149	牙齿 yáchǐ	1	y	\N
150	大夫　dàifu	1	d	\N
151	医院 yīyuàn	1	y	\N
152	病　bìng	1	b	\N
153	药　yào	1	y	\N
154	死 sǐ	1	s	\N
155	感冒 gǎnmào	1	g	\N
156	头 tóu	1	t	\N
157	肚子 dùzi	1	d	\N
158	度 dù	1	d	\N
159	电梯 diàntī	1	d	\N
160	车票 chēpiào	1	c	\N
161	下　xià	1	x	\N
162	楼梯　lóutī	1	l	\N
163	关 guān	1	g	\N
164	车站　chēzhàn	1	c	\N
165	地铁 dìtiě	1	d	\N
166	坐	0	z	\N
167	打开 dǎkāi	1	d	\N
168	洗手间　xǐshǒujiān	1	x	\N
169	厕所 cèsuǒ	1	c	\N
170	火车 huǒchē	1	h	\N
171	饮料　yǐnliào	1	y	\N
172	咖啡 kāfēi	1	k	\N
173	咖啡厅 kāfēitīng	1	k	\N
174	柠檬 níngméng	1	n	\N
175	牛奶　niúnǎi	1	n	\N
176	糖　táng	1	t	\N
177	杯子 bēizi	1	b	\N
178	茶　chá	1	c	\N
179	红茶　hóngchá	1	h	\N
181	放 fàng	1	f	\N
182	甜 tián	1	t	\N
183	喝　hē	1	h	\N
184	筷子 kuàizi	1	k	\N
185	酒 jiǔ	1	j	\N
186	好吃 hǎochī	1	h	\N
187	刀子　dāozi	1	d	\N
189	叉子 chāzi	1	c	\N
191	吃 chī	1	c	\N
192	难吃 nánchī	1	n	\N
193	面包 miànbāo	1	m	\N
194	辣　là	1	l	\N
195	餐厅　cāntīng	1	c	\N
196	食堂 shítáng	1	s	\N
197	葡萄酒 pútaojiǔ	1	p	\N
199	咖喱饭　gālífàn	1	g	\N
200	钱 qián	1	q	\N
201	银行 yínháng	1	y	\N
202	入口 rùkǒu	1	r	\N
203	别客气 biékèqi	1	b	\N
204	不 bù	1	b	\N
205	好　hǎo	1	h	\N
206	不好意思 bùhǎoyìsi	1	b	\N
207	请　qǐng	1	q	\N
208	出口 chūkǒu	1	c	\N
209	到　dào	1	d	\N
210	邮筒 yóutǒng	1	y	\N
211	明信片 míngxìnpiàn	1	m	\N
212	贴　tiē	1	t	\N
213	信封 xìnfēng	1	x	\N
214	信 xìn	1	x	\N
215	邮局 yóujú	1	y	\N
216	还 huán	1	h	\N
217	寄　jì	1	j	\N
218	邮票　yóupiào	1	y	\N
219	包裹 bāoguǒ	1	b	\N
220	张　zhāng	1	z	\N
221	借给 jiègěi	1	j	\N
222	买 mǎi	1	m	\N
223	帽子　màozi	1	m	\N
224	鞋 xié	1	x	\N
225	买东西	0	m	\N
226	楼 lóu	1	l	\N
227	百货公司　bǎihuògōngsī	1	b	\N
228	裙子 qúnzi	1	q	\N
229	大衣 dàyī	1	d	\N
230	裤子　kùzì	1	k	\N
231	毛衣 máoyī	1	m	\N
232	请	0	q	\N
233	书包 shūbāo	1	s	\N
234	卖 mài	1	m	\N
237	建筑物 jiànzhùwù	1	j	\N
238	厨房 chúfáng	1	c	\N
239	淋浴　línyù	1	l	\N
240	窗户　chuānghu	1	c	\N
241	住 zhù	1	z	\N
242	公园 gōngyuán	1	g	\N
243	门　mén	1	m	\N
244	洗澡　xǐzǎo	1	x	\N
245	公寓　gōngyù	1	g	\N
247	他 tā	1	t	\N
248	他们 tāmen	1	t	\N
249	我 wǒ	1	w	\N
250	我们　wǒmen	1	w	\N
251	谁 shéi	0	s	\N
252	谁 shéi	1	s	\N
253	谁	0	s	\N
254	你　nǐ	1	n	\N
255	您　nín	1	n	\N
256	这个 zhèige	1	z	\N
257	那个 nèige	1	n	\N
258	怎么　zěnme	1	z	\N
259	哪个 něige	1	n	\N
260	什么  shénme	1	s	\N
261	这么 zhème	1	z	\N
262	自己　zìjǐ	1	z	\N
263	这样　zhèiyang	1	z	\N
264	厚 hòu	1	h	\N
265	窄 zhǎi	1	z	\N
266	细 xì	1	x	\N
267	大　dà	1	d	\N
268	粗 cū	1	c	\N
269	年轻 niánqīng	1	n	\N
270	宽　kuān	1	k	\N
271	轻　qīng	1	q	\N
272	远 yuǎn	1	y	\N
273	重 zhòng	1	z	\N
274	薄　báo	1	b	\N
275	新 xīn	1	x	\N
276	小 xiǎo	1	x	\N
277	近 jìn	1	j	\N
278	旧 jiù	1	j	\N
280	热闹 rènao	1	r	\N
281	低 dī	1	d	\N
282	好	0	h	\N
283	明亮 míngliàng	1	l	\N
284	软弱 ruǎnruò	1	r	\N
285	强　qiáng	1	q	\N
286	有意思　yǒuyìsi	1	y	\N
287	漂亮　piàoliang	1	p	\N
288	慢 màn	1	m	\N
289	坏　huài	1	h	\N
290	多 duō	1	d	\N
291	黑 hēi	1	h	\N
292	安静　ānjìng	1	a	\N
293	少 shǎo	1	s	\N
294	脏 zāng	1	z	\N
295	无聊 wúliáo	1	w	\N
296	横　héng	1	h	\N
297	里边 lǐbian	1	l	\N
298	外面　wàimian	1	w	\N
299	东边 dōngbian	1	d	\N
301	竖　shù	1	s	\N
302	北边 běibian	1	b	\N
303	西边　xībian	1	x	\N
304	下面 xiàmian	1	x	\N
305	南边 nánbian	1	n	\N
306	上 shang	1	s	\N
309	表妹 biǎomèi	0	b	\N
310	哥哥　gēge	1	g	\N
311	兄弟 xiōngdì	1	x	\N
312	奶奶 nǎinai	1	n	\N
313	爷爷　yéye	1	y	\N
314	爱人	0	a	\N
315	妈妈 māma	1	m	\N
316	伯父 bófù	1	b	\N
317	父母 fùmǔ	1	f	\N
318	父亲　fùqin	1	f	\N
319	姐姐 jiějie	0	j	\N
320	姐妹 jiěmèi	1	j	\N
322	哥哥	0	g	\N
323	姐姐 jiějie	1	j	\N
324	爸爸　bàba	1	b	\N
325	妈妈	0	m	\N
326	袜子 wàzi	1	w	\N
327	衬衫	0	c	\N
328	脱　tuō	1	t	\N
329	挂 guà	1	g	\N
330	穿 chuān	0	c	\N
331	穿 chuān	1	c	\N
332	戴 dài	1	d	\N
333	手绢 shǒujuàn	1	s	\N
334	拖鞋　tuōxié	1	t	\N
335	雨伞 yǔsǎn	1	y	\N
336	口袋　 kǒudài	1	k	\N
337	钱包　qiánbāo	1	q	\N
339	衣服 yīfu	1	y	\N
340	西服　xīfú	0	x	\N
341	嘴　zuǐ	1	z	\N
342	胳膊　gēbo	1	g	\N
343	身体　shēntǐ	1	s	\N
344	脸　liǎn	1	l	\N
345	腿 tuǐ	1	t	\N
346	手 shǒu	1	s	\N
347	鼻子 bízi	1	b	\N
348	眼睛　yǎnjing	1	y	\N
349	耳朵 ěrduo	1	e	\N
350	腿 tuǐ	1	j	\N
353	黄油　huángyóu	1	h	\N
356	午饭　wǔfàn	1	w	\N
357	晚饭 wǎnfàn	1	w	\N
358	点心 diǎnxin	1	d	\N
359	鸡蛋 jīdàn	1	j	\N
360	早饭 zǎofàn	1	z	\N
361	饭 fàn	1	f	\N
362	酱油　jiàngyóu	1	j	\N
363	盐　yán	1	y	\N
364	晚饭	0	w	\N
365	加 jiā	1	j	\N
366	安 ān	1	a	\N
367	照相机 zhàoxiàngjī	1	z	\N
368	炉子 lúzi	1	l	\N
369	铅笔 qiānbǐ	1	q	\N
370	擦掉 cādiào	1	c	\N
371	眼镜 yǎnjìng	1	y	\N
372	录音机　lùyīnjī	1	l	\N
373	钟表 zhōngbiǎo	1	z	\N
374	电脑 diànnǎo	1	d	\N
375	胶卷　jiāojuǎn	1	j	\N
377	门	0	m	\N
378	笔 bǐ	1	b	\N
379	钢笔　gāngbǐ	1	g	\N
380	圆珠笔　yuánzhūbǐ	1	y	\N
381	八月 bāyuè	1	b	\N
382	四月　sìyuè	1	s	\N
383	这个月 zhèigeyuè	1	z	\N
384	每个月　měigeyuè　	1	m	\N
385	十二月　shíèryuè	1	s	\N
386	二月　èryuè	1	e	\N
387	一月 yīyuè	1	y	\N
388	七月　qīyuè	1	q	\N
389	六月 liùyuè	1	l	\N
390	下个月　xiàgeyuè	1	x	\N
391	五月 wǔyuè	1	w	\N
392	三月　sānyuè	1	s	\N
393	上个月 shànggeyuè	1	s	\N
394	十一月 shíyīyuè	1	s	\N
395	十月 shíyuè	1	s	\N
396	九月　jiǔyuè	1	j	\N
397	一个月 yígeyuè	1	y	\N
398	这个星期 zhèigexīngqī	1	z	\N
399	每个星期 měigexīngqī	1	m	\N
529	外衣 wàiyī	1	w	\N
400	星期日 xīngqīrì	1	x	\N
401	星期四 xīngqīsì	1	x	\N
402	下个星期 xiàgexīngqī	1	x	\N
403	星期一 xīngqīyī	1	x	\N
404	星期二 xīngqīèr	1	x	\N
405	星期三 xīngqīsān	1	x	\N
406	星期六 xīngqīliù	1	x	\N
407	一个星期 yígexīngqī	1	y	\N
409	星期五　xīngqīwǔ	1	c	\N
410	年　nián	1	n	\N
411	秋天 qiūtiān	1	w	\N
412	今年 jīnnián	1	j	\N
413	每年　měinián	1	m	\N
414	夏天 xiàtiān	1	x	\N
415	冬天　dōngtiān	1	d	\N
416	去年 qùnián	1	q	\N
417	明年 míngnián	1	m	\N
418	春天　chūntiān	1	c	\N
419	后年 hòunián	1	h	\N
420	前年 qiánnián	1	q	\N
421	下午 xiàwǔ	1	x	\N
422	今天　jīntiān	1	j	\N
423	明天　míngtiān	1	m	\N
424	点 diǎn	1	d	\N
425	昨天 zuótiān	1	z	\N
426	傍晚　bàngwǎn	1	b	\N
427	上午 shàngwǔ	1	s	\N
428	早上　zǎoshang	1	z	\N
429	白天 báitiān	1	b	\N
430	晚上 wǎnshang	1	w	\N
432	后天 hòutiān	1	h	\N
433	前天　qiántiān	1	q	\N
434	已经 yǐjing	1	y	\N
435	一边 yìbiān	1	y	\N
436	还 hái	1	h	\N
438	的时候　deshíhou	1	d	\N
439	什么时候 shénmeshíhou	1	s	\N
440	有时 yǒushí	0	o	\N
441	常常 chángcháng	1	c	\N
442	小时 xiǎoshí	1	x	\N
443	马上 mǎshang	1	m	\N
444	烟灰缸 yānhuīgāng	1	y	\N
445	歌　gē	1	g	\N
446	唱歌 chànggē	1	c	\N
447	烟　yān	1	y	\N
448	电影　diànyǐng	1	d	\N
449	唱片　chàngpiàn	1	c	\N
450	吉他 jítā	1	j	\N
451	弹　tán	1	t	\N
452	音乐 yīnyuè	1	y	\N
453	画 huà	1	h	\N
455	喜欢 xǐhuan	1	x	\N
456	声音 shēngyīn	1	s	\N
457	晴天　qíngtiān	1	q	\N
458	热　rè	1	r	\N
459	晴 qíng	1	f	\N
460	凉快　liángkuai	1	l	\N
461	冷　lěng	1	l	\N
462	雪 xuě	1	x	\N
463	下雨　xiàyǔ	1	x	\N
464	雨 yǔ	1	y	\N
465	天气 tiānqì	1	t	\N
466	暖和 nuǎnhuo	1	n	\N
467	风 fēng	1	f	\N
468	阴天　yīntiān	1	y	\N
469	冰 bīng	1	b	\N
471	汉字　hànzì	1	h	\N
472	说　shuō	1	s	\N
473	写 xiě	1	x	\N
474	话　huà	1	h	\N
475	语言 yǔyán	1	y	\N
476	语　yǔ	1	y	\N
477	词 cí	1	c	\N
478	说话 shuōhuà	1	s	\N
479	文章 wénzhāng	1	w	\N
480	聊天 liáotiān	1	l	\N
481	意思 yìsi	1	y	\N
482	平假名　píngjiǎmíng	1	p	\N
483	片假名　piànjiǎmíng	1	p	\N
484	成年人　chéngniánrén	1	c	\N
485	众多 zhòngduō	1	z	\N
486	夫妻 fūqī	1	f	\N
487	孩子 háizi	1	h	\N
488	妻子　qīzi	1	q	\N
489	女的 nǚde	1	n	\N
490	男孩子 nánháizi	1	n	\N
491	人　rén	1	r	\N
492	男的 nánde	1	n	\N
493	女孩子 nǚháizi	1	n	\N
495	人	0	r	\N
496	大家  dàjiā	1	d	\N
497	白色 báisè	1	b	\N
498	蓝色 lánsè	1	l	\N
500	光亮　guāngliàng	1	g	\N
501	颜色　yánsè	1	y	\N
502	深 shēn	1	s	\N
503	黄色　huángsè	1	h	\N
504	黑色 hēisè	1	h	\N
505	红色 hóngsè	1	h	\N
506	绿色　lǜsè	1	l	\N
507	方便　fāngbiàn	1	f	\N
508	晚会　wǎnhuì	1	w	\N
509	纸 zhǐ	1	z	\N
511	系　jì	1	j	\N
512	推 tuī	1	t	\N
513	开始　kāishǐ	1	k	\N
514	正好　zhènghǎo	1	z	\N
515	没有 méiyǒu	1	m	\N
516	一直　yìzhí	1	y	\N
517	有名 yǒumíng	1	y	\N
518	精神 jīngshen	1	j	\N
519	那　nà	1	n	\N
520	也许　yěxǔ	1	y	\N
521	那	0	n	\N
522	安静	0	a	\N
523	姥姥　lǎolao	1	l	\N
524	老婆 lǎopo	1	l	\N
525	愉快　yúkuài	1	y	\N
526	有时 yǒushí	1	y	\N
527	碟子 diézi	1	d	\N
528	干酪 gānlào	1	g	\N
530	吃的 chīde	1	c	\N
531	问题　wèntí	1	w	\N
532	勺子　sháozi	1	s	\N
533	池子　chízi	1	c	\N
534	拐 guǎi	1	g	\N
535	饭碗 fànwǎn	1	f	\N
536	抽 chōu	1	c	\N
537	正门　zhèngmén	1	z	\N
538	丈夫 zhàngfu	1	z	\N
539	照片 zhàopiān	1	z	\N
540	整 zhěng	1	z	\N
541	叔父 shūfù	1	s	\N
542	姑夫 gūfu	1	g	\N
543	舅父 jiùfù	1	j	\N
544	姨夫 yífu	1	y	\N
545	昨夜 zuóyè	1	z	\N
546	汗衫 hànshān	1	h	\N
547	伯母 bómǔ	1	b	\N
548	婶母 shěnmǔ	1	s	\N
549	姨母 yímǔ	1	y	\N
550	房子 fángzi	1	f	\N
551	附近 fùjìn	1	f	\N
552	哪位 něiwèi	1	n	\N
553	有人 yǒurén	1	y	\N
554	老爷 lǎoye	1	l	\N
555	大概 dàgài	1	d	\N
556	出租车 chūzūchē	1	c	\N
557	星期天 xīngqītiān	1	x	\N
17		0		\N
22		0		\N
34	汤池	0	t	\N
39	歪着	0	w	\N
45	吸	0	x	\N
55	书	0	s	\N
57	复印	0	f	\N
83	洗衣服	0	x	\N
107	这儿	0	z	\N
144	练习	0	l	\N
145	提问	0	t	\N
146	题目	0	t	\N
180	杯子	0	b	\N
188	汤匙	0	t	\N
190	乳酪	0	r	\N
198	食物	0	s	\N
235	上衣 shàngyī	0	s	\N
236	浴缸	0	y	\N
246	玄关	0	x	\N
279	快乐	0	k	\N
300	高	0	g	\N
307	前面	0	q	\N
308	后面	0	h	\N
321	姑姑	0	g	\N
338		0		\N
351	肚子	0	d	\N
352	盘子	0	p	\N
354	碗	0	w	\N
355	糖果	0	t	\N
408	上星期	0	s	\N
431	傍晚	0	b	\N
437	中	0	z	\N
454	相片	0	x	\N
470		0		\N
494	先生	0	x	\N
499		0		\N
510		0		\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: zh
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
206		\N		\N	\N	\N	834	\N
381		\N		\N	\N	\N	990	\N
124		\N		\N	\N	\N	229	\N
152		\N		\N	\N	\N	382	\N
204		\N		\N	\N	\N	257	\N
204		\N		\N	\N	\N	4	\N
204		\N		\N	\N	\N	23	\N
204		\N		\N	\N	\N	24	\N
204		\N		\N	\N	\N	101	\N
204		\N		\N	\N	\N	103	\N
204		\N		\N	\N	\N	104	\N
204		\N		\N	\N	\N	105	\N
204		\N		\N	\N	\N	210	\N
204		\N		\N	\N	\N	214	\N
59		\N		\N	\N	\N	52	\N
92		\N		\N	\N	\N	462	\N
324		\N		\N	\N	\N	18	\N
378		\N		\N	\N	\N	640	\N
135		\N		\N	\N	\N	1169	\N
135		\N		\N	\N	\N	1170	\N
191		\N		\N	\N	\N	378	\N
191		\N		\N	\N	\N	394	\N
191		\N		\N	\N	\N	1067	\N
418		\N		\N	\N	\N	151	\N
94		\N		\N	\N	\N	539	\N
441		\N		\N	\N	\N	254	\N
409		\N		\N	\N	\N	415	\N
331		\N		\N	\N	\N	179	\N
240		\N		\N	\N	\N	65	\N
169		\N		\N	\N	\N	951	\N
41		\N		\N	\N	\N	179	\N
327		\N		\N	\N	\N	605	\N
51		\N		\N	\N	\N	7	\N
164		\N		\N	\N	\N	384	\N
120		\N		\N	\N	\N	883	\N
120		\N		\N	\N	\N	1022	\N
330		\N		\N	\N	\N	246	\N
290		\N		\N	\N	\N	246	\N
290		\N		\N	\N	\N	92	\N
290		\N		\N	\N	\N	231	\N
290		\N		\N	\N	\N	651	\N
290		\N		\N	\N	\N	1048	\N
65		\N		\N	\N	\N	54	\N
65		\N		\N	\N	\N	847	\N
65		\N		\N	\N	\N	909	\N
79		\N		\N	\N	\N	254	\N
86		\N		\N	\N	\N	254	\N
267		\N		\N	\N	\N	241	\N
229		\N		\N	\N	\N	13	\N
496		\N		\N	\N	\N	285	\N
134		\N		\N	\N	\N	168	\N
104		\N		\N	\N	\N	448	\N
165		\N		\N	\N	\N	290	\N
438		\N		\N	\N	\N	170	\N
438		\N		\N	\N	\N	177	\N
438		\N		\N	\N	\N	750	\N
424		\N		\N	\N	\N	421	\N
424		\N		\N	\N	\N	422	\N
424		\N		\N	\N	\N	870	\N
424		\N		\N	\N	\N	872	\N
209		\N		\N	\N	\N	165	\N
209		\N		\N	\N	\N	318	\N
209		\N		\N	\N	\N	1099	\N
448		\N		\N	\N	\N	36	\N
448		\N		\N	\N	\N	145	\N
448		\N		\N	\N	\N	327	\N
159		\N		\N	\N	\N	201	\N
374		\N		\N	\N	\N	903	\N
374		\N		\N	\N	\N	1166	\N
101		\N		\N	\N	\N	563	\N
46		\N		\N	\N	\N	534	\N
46		\N		\N	\N	\N	917	\N
46		\N		\N	\N	\N	926	\N
181		\N		\N	\N	\N	196	\N
507		\N		\N	\N	\N	640	\N
91		\N		\N	\N	\N	178	\N
91		\N		\N	\N	\N	914	\N
56		\N		\N	\N	\N	276	\N
467		\N		\N	\N	\N	282	\N
3		\N		\N	\N	\N	533	\N
361		\N		\N	\N	\N	1143	\N
445		\N		\N	\N	\N	980	\N
44		\N		\N	\N	\N	323	\N
44		\N		\N	\N	\N	931	\N
44		\N		\N	\N	\N	752	\N
42		\N		\N	\N	\N	1175	\N
242		\N		\N	\N	\N	292	\N
47		\N		\N	\N	\N	88	\N
47		\N		\N	\N	\N	611	\N
48		\N		\N	\N	\N	374	\N
63		\N		\N	\N	\N	234	\N
63		\N		\N	\N	\N	236	\N
63		\N		\N	\N	\N	238	\N
63		\N		\N	\N	\N	90	\N
310		\N		\N	\N	\N	427	\N
322		\N		\N	\N	\N	427	\N
329		\N		\N	\N	\N	722	\N
170		\N		\N	\N	\N	215	\N
87		\N		\N	\N	\N	166	\N
87		\N		\N	\N	\N	198	\N
87		\N		\N	\N	\N	506	\N
183		\N		\N	\N	\N	224	\N
183		\N		\N	\N	\N	331	\N
264		\N		\N	\N	\N	83	\N
432		\N		\N	\N	\N	1114	\N
205		\N		\N	\N	\N	873	\N
205		\N		\N	\N	\N	877	\N
205		\N		\N	\N	\N	956	\N
282		\N		\N	\N	\N	69	\N
289		\N		\N	\N	\N	973	\N
487		\N		\N	\N	\N	42	\N
487		\N		\N	\N	\N	197	\N
291		\N		\N	\N	\N	28	\N
471		\N		\N	\N	\N	385	\N
6		\N		\N	\N	\N	158	\N
6		\N		\N	\N	\N	159	\N
6		\N		\N	\N	\N	472	\N
474		\N		\N	\N	\N	184	\N
436		\N		\N	\N	\N	263	\N
216		\N		\N	\N	\N	724	\N
323		\N		\N	\N	\N	1008	\N
84		\N		\N	\N	\N	264	\N
85		\N		\N	\N	\N	264	\N
217		\N		\N	\N	\N	1130	\N
140		\N		\N	\N	\N	704	\N
125		\N		\N	\N	\N	203	\N
125		\N		\N	\N	\N	943	\N
102		\N		\N	\N	\N	281	\N
103		\N		\N	\N	\N	281	\N
422		\N		\N	\N	\N	235	\N
52		\N		\N	\N	\N	204	\N
52		\N		\N	\N	\N	1058	\N
221		\N		\N	\N	\N	1084	\N
185		\N		\N	\N	\N	308	\N
64		\N		\N	\N	\N	194	\N
11		\N		\N	\N	\N	869	\N
11		\N		\N	\N	\N	874	\N
359		\N		\N	\N	\N	443	\N
25		\N		\N	\N	\N	222	\N
54		\N		\N	\N	\N	140	\N
141		\N		\N	\N	\N	169	\N
172		\N		\N	\N	\N	545	\N
513		\N		\N	\N	\N	167	\N
297		\N		\N	\N	\N	63	\N
131		\N		\N	\N	\N	1	\N
131		\N		\N	\N	\N	25	\N
13		\N		\N	\N	\N	548	\N
14		\N		\N	\N	\N	548	\N
461		\N		\N	\N	\N	686	\N
33		\N		\N	\N	\N	251	\N
133		\N		\N	\N	\N	262	\N
133		\N		\N	\N	\N	2	\N
460		\N		\N	\N	\N	181	\N
344		\N		\N	\N	\N	317	\N
49		\N		\N	\N	\N	303	\N
515		\N		\N	\N	\N	57	\N
21		\N		\N	\N	\N	500	\N
423		\N		\N	\N	\N	48	\N
417		\N		\N	\N	\N	46	\N
193		\N		\N	\N	\N	335	\N
231		\N		\N	\N	\N	312	\N
222		\N		\N	\N	\N	144	\N
222		\N		\N	\N	\N	213	\N
77		\N		\N	\N	\N	840	\N
225		\N		\N	\N	\N	968	\N
234		\N		\N	\N	\N	845	\N
315		\N		\N	\N	\N	1130	\N
325		\N		\N	\N	\N	1130	\N
243		\N		\N	\N	\N	107	\N
376		\N		\N	\N	\N	107	\N
377		\N		\N	\N	\N	197	\N
377		\N		\N	\N	\N	293	\N
377		\N		\N	\N	\N	512	\N
443		\N		\N	\N	\N	262	\N
493		\N		\N	\N	\N	317	\N
466		\N		\N	\N	\N	151	\N
519		\N		\N	\N	\N	859	\N
519		\N		\N	\N	\N	1205	\N
521		\N		\N	\N	\N	853	\N
257		\N		\N	\N	\N	357	\N
257		\N		\N	\N	\N	557	\N
257		\N		\N	\N	\N	669	\N
108		\N		\N	\N	\N	66	\N
108		\N		\N	\N	\N	464	\N
108		\N		\N	\N	\N	946	\N
108		\N		\N	\N	\N	756	\N
410		\N		\N	\N	\N	46	\N
254		\N		\N	\N	\N	340	\N
254		\N		\N	\N	\N	428	\N
259		\N		\N	\N	\N	10	\N
259		\N		\N	\N	\N	358	\N
259		\N		\N	\N	\N	383	\N
109		\N		\N	\N	\N	105	\N
109		\N		\N	\N	\N	380	\N
109		\N		\N	\N	\N	465	\N
255		\N		\N	\N	\N	119	\N
255		\N		\N	\N	\N	341	\N
255		\N		\N	\N	\N	1140	\N
139		\N		\N	\N	\N	472	\N
139		\N		\N	\N	\N	473	\N
287		\N		\N	\N	\N	75	\N
287		\N		\N	\N	\N	82	\N
61		\N		\N	\N	\N	852	\N
123		\N		\N	\N	\N	97	\N
105		\N		\N	\N	\N	61	\N
76		\N		\N	\N	\N	117	\N
76		\N		\N	\N	\N	1061	\N
112		\N		\N	\N	\N	952	\N
20		\N		\N	\N	\N	222	\N
38		\N		\N	\N	\N	249	\N
1		\N		\N	\N	\N	233	\N
1		\N		\N	\N	\N	132	\N
433		\N		\N	\N	\N	191	\N
232		\N		\N	\N	\N	198	\N
232		\N		\N	\N	\N	272	\N
271		\N		\N	\N	\N	212	\N
337		\N		\N	\N	\N	774	\N
491		\N		\N	\N	\N	62	\N
495		\N		\N	\N	\N	349	\N
8		\N		\N	\N	\N	1185	\N
8		\N		\N	\N	\N	1014	\N
458		\N		\N	\N	\N	72	\N
280		\N		\N	\N	\N	495	\N
382		\N		\N	\N	\N	47	\N
154		\N		\N	\N	\N	253	\N
154		\N		\N	\N	\N	164	\N
346		\N		\N	\N	\N	535	\N
333		\N		\N	\N	\N	84	\N
260		\N		\N	\N	\N	978	\N
439		\N		\N	\N	\N	381	\N
394		\N		\N	\N	\N	410	\N
132		\N		\N	\N	\N	987	\N
62		\N		\N	\N	\N	840	\N
293		\N		\N	\N	\N	93	\N
166		\N		\N	\N	\N	533	\N
427		\N		\N	\N	\N	1114	\N
306		\N		\N	\N	\N	449	\N
136		\N		\N	\N	\N	173	\N
136		\N		\N	\N	\N	203	\N
343		\N		\N	\N	\N	1047	\N
98		\N		\N	\N	\N	153	\N
95		\N		\N	\N	\N	116	\N
88		\N		\N	\N	\N	450	\N
472		\N		\N	\N	\N	488	\N
472		\N		\N	\N	\N	553	\N
478		\N		\N	\N	\N	309	\N
251		\N		\N	\N	\N	104	\N
251		\N		\N	\N	\N	379	\N
252		\N		\N	\N	\N	528	\N
253		\N		\N	\N	\N	379	\N
247		\N		\N	\N	\N	324	\N
247		\N		\N	\N	\N	342	\N
248		\N		\N	\N	\N	327	\N
248		\N		\N	\N	\N	345	\N
465		\N		\N	\N	\N	581	\N
465		\N		\N	\N	\N	1163	\N
113		\N		\N	\N	\N	36	\N
113		\N		\N	\N	\N	184	\N
50		\N		\N	\N	\N	12	\N
50		\N		\N	\N	\N	504	\N
212		\N		\N	\N	\N	189	\N
249		\N		\N	\N	\N	8	\N
250		\N		\N	\N	\N	325	\N
250		\N		\N	\N	\N	343	\N
4		\N		\N	\N	\N	857	\N
15		\N		\N	\N	\N	256	\N
356		\N		\N	\N	\N	601	\N
411		\N		\N	\N	\N	964	\N
508		\N		\N	\N	\N	1035	\N
430		\N		\N	\N	\N	1163	\N
357		\N		\N	\N	\N	142	\N
364		\N		\N	\N	\N	142	\N
463		\N		\N	\N	\N	209	\N
421		\N		\N	\N	\N	40	\N
402		\N		\N	\N	\N	169	\N
402		\N		\N	\N	\N	1050	\N
390		\N		\N	\N	\N	1183	\N
414		\N		\N	\N	\N	225	\N
127		\N		\N	\N	\N	21	\N
127		\N		\N	\N	\N	61	\N
128		\N		\N	\N	\N	346	\N
130		\N		\N	\N	\N	346	\N
129		\N		\N	\N	\N	326	\N
18		\N		\N	\N	\N	976	\N
455		\N		\N	\N	\N	758	\N
473		\N		\N	\N	\N	146	\N
447		\N		\N	\N	\N	108	\N
276		\N		\N	\N	\N	139	\N
442		\N		\N	\N	\N	122	\N
442		\N		\N	\N	\N	128	\N
214		\N		\N	\N	\N	255	\N
213		\N		\N	\N	\N	189	\N
275		\N		\N	\N	\N	250	\N
97		\N		\N	\N	\N	762	\N
97		\N		\N	\N	\N	763	\N
403		\N		\N	\N	\N	411	\N
405		\N		\N	\N	\N	413	\N
401		\N		\N	\N	\N	414	\N
404		\N		\N	\N	\N	412	\N
400		\N		\N	\N	\N	417	\N
406		\N		\N	\N	\N	416	\N
406		\N		\N	\N	\N	578	\N
303		\N		\N	\N	\N	783	\N
93		\N		\N	\N	\N	546	\N
90		\N		\N	\N	\N	647	\N
339		\N		\N	\N	\N	71	\N
151		\N		\N	\N	\N	1052	\N
397		\N		\N	\N	\N	125	\N
407		\N		\N	\N	\N	124	\N
407		\N		\N	\N	\N	826	\N
435		\N		\N	\N	\N	749	\N
464		\N		\N	\N	\N	211	\N
464		\N		\N	\N	\N	1163	\N
335		\N		\N	\N	\N	1162	\N
2		\N		\N	\N	\N	326	\N
452		\N		\N	\N	\N	981	\N
348		\N		\N	\N	\N	180	\N
286		\N		\N	\N	\N	1034	\N
72		\N		\N	\N	\N	482	\N
434		\N		\N	\N	\N	153	\N
24		\N		\N	\N	\N	111	\N
476		\N		\N	\N	\N	134	\N
476		\N		\N	\N	\N	158	\N
476		\N		\N	\N	\N	326	\N
476		\N		\N	\N	\N	894	\N
476		\N		\N	\N	\N	1014	\N
476		\N		\N	\N	\N	1023	\N
477		\N		\N	\N	\N	1180	\N
27		\N		\N	\N	\N	983	\N
272		\N		\N	\N	\N	230	\N
215		\N		\N	\N	\N	531	\N
218		\N		\N	\N	\N	531	\N
75		\N		\N	\N	\N	118	\N
121		\N		\N	\N	\N	175	\N
138		\N		\N	\N	\N	654	\N
425		\N		\N	\N	\N	577	\N
262		\N		\N	\N	\N	217	\N
31		\N		\N	\N	\N	532	\N
241		\N		\N	\N	\N	911	\N
273		\N		\N	\N	\N	1134	\N
367		\N		\N	\N	\N	1160	\N
428		\N		\N	\N	\N	933	\N
23		\N		\N	\N	\N	251	\N
516		\N		\N	\N	\N	509	\N
258		\N		\N	\N	\N	1001	\N
122		\N		\N	\N	\N	207	\N
220		\N		\N	\N	\N	448	\N
58		\N		\N	\N	\N	12	\N
58		\N		\N	\N	\N	64	\N
89		\N		\N	\N	\N	187	\N
100		\N		\N	\N	\N	650	\N
509		\N		\N	\N	\N	17	\N
294		\N		\N	\N	\N	546	\N
256		\N		\N	\N	\N	9	\N
256		\N		\N	\N	\N	294	\N
106		\N		\N	\N	\N	463	\N
106		\N		\N	\N	\N	944	\N
261		\N		\N	\N	\N	96	\N
261		\N		\N	\N	\N	833	\N
263		\N		\N	\N	\N	1125	\N
366		\N		\N	\N	\N	1207	\N
177		\N		\N	\N	\N	1209	\N
177		\N		\N	\N	\N	1210	\N
497		\N		\N	\N	\N	1211	\N
316		\N		\N	\N	\N	1212	\N
429		\N		\N	\N	\N	1213	\N
274		\N		\N	\N	\N	1214	\N
347		\N		\N	\N	\N	1215	\N
227		\N		\N	\N	\N	1216	\N
219		\N		\N	\N	\N	1217	\N
426		\N		\N	\N	\N	1218	\N
426		\N		\N	\N	\N	1219	\N
302		\N		\N	\N	\N	1220	\N
469		\N		\N	\N	\N	1221	\N
203		\N		\N	\N	\N	1222	\N
53		\N		\N	\N	\N	1223	\N
189		\N		\N	\N	\N	1224	\N
370		\N		\N	\N	\N	1225	\N
195		\N		\N	\N	\N	1226	\N
208		\N		\N	\N	\N	1227	\N
446		\N		\N	\N	\N	1228	\N
449		\N		\N	\N	\N	1229	\N
238		\N		\N	\N	\N	1230	\N
484		\N		\N	\N	\N	1231	\N
268		\N		\N	\N	\N	1232	\N
178		\N		\N	\N	\N	1233	\N
160		\N		\N	\N	\N	1234	\N
167		\N		\N	\N	\N	1235	\N
332		\N		\N	\N	\N	1236	\N
16		\N		\N	\N	\N	1237	\N
150		\N		\N	\N	\N	1238	\N
115		\N		\N	\N	\N	1239	\N
281		\N		\N	\N	\N	1240	\N
358		\N		\N	\N	\N	1241	\N
158		\N		\N	\N	\N	1242	\N
415		\N		\N	\N	\N	1243	\N
187		\N		\N	\N	\N	1244	\N
157		\N		\N	\N	\N	1245	\N
299		\N		\N	\N	\N	1246	\N
349		\N		\N	\N	\N	1247	\N
386		\N		\N	\N	\N	1248	\N
486		\N		\N	\N	\N	1249	\N
317		\N		\N	\N	\N	1250	\N
318		\N		\N	\N	\N	1251	\N
459		\N		\N	\N	\N	1252	\N
7		\N		\N	\N	\N	1253	\N
155		\N		\N	\N	\N	1254	\N
500		\N		\N	\N	\N	1255	\N
30		\N		\N	\N	\N	1256	\N
245		\N		\N	\N	\N	1257	\N
10		\N		\N	\N	\N	1258	\N
163		\N		\N	\N	\N	1259	\N
199		\N		\N	\N	\N	1260	\N
342		\N		\N	\N	\N	1261	\N
379		\N		\N	\N	\N	1262	\N
296		\N		\N	\N	\N	1263	\N
503		\N		\N	\N	\N	1264	\N
147		\N		\N	\N	\N	1267	\N
147		\N		\N	\N	\N	1268	\N
116		\N		\N	\N	\N	1270	\N
186		\N		\N	\N	\N	1271	\N
504		\N		\N	\N	\N	1272	\N
505		\N		\N	\N	\N	1273	\N
179		\N		\N	\N	\N	1274	\N
365		\N		\N	\N	\N	1275	\N
80		\N		\N	\N	\N	1276	\N
81		\N		\N	\N	\N	1277	\N
450		\N		\N	\N	\N	1278	\N
350		\N		\N	\N	\N	1279	\N
278		\N		\N	\N	\N	1280	\N
111		\N		\N	\N	\N	1281	\N
396		\N		\N	\N	\N	1282	\N
511		\N		\N	\N	\N	1283	\N
237		\N		\N	\N	\N	1284	\N
73		\N		\N	\N	\N	1285	\N
412		\N		\N	\N	\N	1286	\N
518		\N		\N	\N	\N	1287	\N
12		\N		\N	\N	\N	1288	\N
114		\N		\N	\N	\N	1289	\N
375		\N		\N	\N	\N	1290	\N
37		\N		\N	\N	\N	1291	\N
362		\N		\N	\N	\N	1292	\N
336		\N		\N	\N	\N	1294	\N
173		\N		\N	\N	\N	1295	\N
270		\N		\N	\N	\N	1296	\N
184		\N		\N	\N	\N	1297	\N
230		\N		\N	\N	\N	1298	\N
283		\N		\N	\N	\N	1299	\N
239		\N		\N	\N	\N	1300	\N
368		\N		\N	\N	\N	1301	\N
32		\N		\N	\N	\N	1302	\N
226		\N		\N	\N	\N	1303	\N
162		\N		\N	\N	\N	1304	\N
313		\N		\N	\N	\N	1305	\N
524		\N		\N	\N	\N	1306	\N
389		\N		\N	\N	\N	1307	\N
480		\N		\N	\N	\N	1308	\N
480		\N		\N	\N	\N	1309	\N
194		\N		\N	\N	\N	1310	\N
372		\N		\N	\N	\N	1311	\N
142		\N		\N	\N	\N	1312	\N
506		\N		\N	\N	\N	1313	\N
498		\N		\N	\N	\N	1314	\N
40		\N		\N	\N	\N	1315	\N
320		\N		\N	\N	\N	1316	\N
319		\N		\N	\N	\N	1317	\N
223		\N		\N	\N	\N	1318	\N
288		\N		\N	\N	\N	1319	\N
211		\N		\N	\N	\N	1320	\N
74		\N		\N	\N	\N	1321	\N
399		\N		\N	\N	\N	1322	\N
384		\N		\N	\N	\N	1324	\N
60		\N		\N	\N	\N	1325	\N
175		\N		\N	\N	\N	1326	\N
489		\N		\N	\N	\N	1327	\N
492		\N		\N	\N	\N	1328	\N
490		\N		\N	\N	\N	1329	\N
305		\N		\N	\N	\N	1330	\N
19		\N		\N	\N	\N	1332	\N
312		\N		\N	\N	\N	1333	\N
312		\N		\N	\N	\N	1334	\N
174		\N		\N	\N	\N	1335	\N
192		\N		\N	\N	\N	1336	\N
440		\N		\N	\N	\N	1337	\N
526		\N		\N	\N	\N	1338	\N
526		\N		\N	\N	\N	1339	\N
110		\N		\N	\N	\N	1340	\N
197		\N		\N	\N	\N	1341	\N
482		\N		\N	\N	\N	1342	\N
483		\N		\N	\N	\N	1343	\N
527		\N		\N	\N	\N	1344	\N
99		\N		\N	\N	\N	1345	\N
416		\N		\N	\N	\N	1346	\N
488		\N		\N	\N	\N	1347	\N
388		\N		\N	\N	\N	1348	\N
457		\N		\N	\N	\N	1349	\N
420		\N		\N	\N	\N	1350	\N
420		\N		\N	\N	\N	1351	\N
117		\N		\N	\N	\N	1352	\N
228		\N		\N	\N	\N	1353	\N
285		\N		\N	\N	\N	1354	\N
207		\N		\N	\N	\N	1355	\N
200		\N		\N	\N	\N	1356	\N
369		\N		\N	\N	\N	1357	\N
71		\N		\N	\N	\N	1358	\N
528		\N		\N	\N	\N	1359	\N
202		\N		\N	\N	\N	1360	\N
143		\N		\N	\N	\N	1361	\N
284		\N		\N	\N	\N	1362	\N
392		\N		\N	\N	\N	1363	\N
35		\N		\N	\N	\N	1364	\N
395		\N		\N	\N	\N	1365	\N
385		\N		\N	\N	\N	1366	\N
393		\N		\N	\N	\N	1367	\N
196		\N		\N	\N	\N	1368	\N
530		\N		\N	\N	\N	1369	\N
502		\N		\N	\N	\N	1370	\N
66		\N		\N	\N	\N	1371	\N
456		\N		\N	\N	\N	1372	\N
96		\N		\N	\N	\N	1373	\N
67		\N		\N	\N	\N	1374	\N
233		\N		\N	\N	\N	1375	\N
301		\N		\N	\N	\N	1376	\N
512		\N		\N	\N	\N	1377	\N
345		\N		\N	\N	\N	1378	\N
328		\N		\N	\N	\N	1379	\N
26		\N		\N	\N	\N	1380	\N
182		\N		\N	\N	\N	1381	\N
176		\N		\N	\N	\N	1382	\N
148		\N		\N	\N	\N	1383	\N
156		\N		\N	\N	\N	1384	\N
451		\N		\N	\N	\N	1385	\N
334		\N		\N	\N	\N	1387	\N
532		\N		\N	\N	\N	1388	\N
533		\N		\N	\N	\N	1389	\N
28		\N		\N	\N	\N	1390	\N
249		\N		\N	\N	\N	1391	\N
529		\N		\N	\N	\N	1392	\N
5		\N		\N	\N	\N	1393	\N
298		\N		\N	\N	\N	1394	\N
391		\N		\N	\N	\N	1395	\N
479		\N		\N	\N	\N	1396	\N
534		\N		\N	\N	\N	1397	\N
535		\N		\N	\N	\N	1398	\N
295		\N		\N	\N	\N	1399	\N
326		\N		\N	\N	\N	1400	\N
531		\N		\N	\N	\N	1401	\N
161		\N		\N	\N	\N	1402	\N
304		\N		\N	\N	\N	1403	\N
536		\N		\N	\N	\N	1404	\N
311		\N		\N	\N	\N	1405	\N
43		\N		\N	\N	\N	1406	\N
340		\N		\N	\N	\N	1407	\N
462		\N		\N	\N	\N	1408	\N
78		\N		\N	\N	\N	1409	\N
168		\N		\N	\N	\N	1410	\N
244		\N		\N	\N	\N	1411	\N
224		\N		\N	\N	\N	1412	\N
266		\N		\N	\N	\N	1413	\N
481		\N		\N	\N	\N	1414	\N
387		\N		\N	\N	\N	1416	\N
82		\N		\N	\N	\N	1417	\N
118		\N		\N	\N	\N	1418	\N
149		\N		\N	\N	\N	1419	\N
371		\N		\N	\N	\N	1420	\N
520		\N		\N	\N	\N	1421	\N
525		\N		\N	\N	\N	1422	\N
517		\N		\N	\N	\N	1423	\N
29		\N		\N	\N	\N	1424	\N
444		\N		\N	\N	\N	1425	\N
380		\N		\N	\N	\N	1426	\N
363		\N		\N	\N	\N	1427	\N
153		\N		\N	\N	\N	1428	\N
475		\N		\N	\N	\N	1429	\N
210		\N		\N	\N	\N	1430	\N
201		\N		\N	\N	\N	1431	\N
468		\N		\N	\N	\N	1432	\N
501		\N		\N	\N	\N	1433	\N
171		\N		\N	\N	\N	1434	\N
68		\N		\N	\N	\N	1435	\N
119		\N		\N	\N	\N	1436	\N
137		\N		\N	\N	\N	1437	\N
265		\N		\N	\N	\N	1438	\N
539		\N		\N	\N	\N	1439	\N
538		\N		\N	\N	\N	1440	\N
514		\N		\N	\N	\N	1441	\N
537		\N		\N	\N	\N	1443	\N
360		\N		\N	\N	\N	1444	\N
126		\N		\N	\N	\N	1445	\N
540		\N		\N	\N	\N	1446	\N
69		\N		\N	\N	\N	1447	\N
341		\N		\N	\N	\N	1448	\N
485		\N		\N	\N	\N	1449	\N
373		\N		\N	\N	\N	1450	\N
383		\N		\N	\N	\N	1451	\N
398		\N		\N	\N	\N	1452	\N
541		\N		\N	\N	\N	1453	\N
542		\N		\N	\N	\N	1454	\N
543		\N		\N	\N	\N	1455	\N
544		\N		\N	\N	\N	1456	\N
309		\N		\N	\N	\N	1458	\N
545		\N		\N	\N	\N	1459	\N
331		\N		\N	\N	\N	1460	\N
546		\N		\N	\N	\N	1461	\N
79		\N		\N	\N	\N	1462	\N
56		\N		\N	\N	\N	1463	\N
547		\N		\N	\N	\N	1464	\N
548		\N		\N	\N	\N	1465	\N
549		\N		\N	\N	\N	1466	\N
63		\N		\N	\N	\N	1467	\N
310		\N		\N	\N	\N	1468	\N
116		\N		\N	\N	\N	1469	\N
205		\N		\N	\N	\N	69	\N
550		\N		\N	\N	\N	1470	\N
277		\N		\N	\N	\N	1281	\N
551		\N		\N	\N	\N	1471	\N
70		\N		\N	\N	\N	1472	\N
13		\N		\N	\N	\N	1288	\N
13		\N		\N	\N	\N	1473	\N
524		\N		\N	\N	\N	1474	\N
142		\N		\N	\N	\N	1475	\N
77		\N		\N	\N	\N	968	\N
315		\N		\N	\N	\N	254	\N
399		\N		\N	\N	\N	1476	\N
243		\N		\N	\N	\N	512	\N
243		\N		\N	\N	\N	1259	\N
519		\N		\N	\N	\N	853	\N
269		\N		\N	\N	\N	1477	\N
105		\N		\N	\N	\N	952	\N
117		\N		\N	\N	\N	1478	\N
207		\N		\N	\N	\N	272	\N
207		\N		\N	\N	\N	198	\N
491		\N		\N	\N	\N	3	\N
552		\N		\N	\N	\N	1479	\N
553		\N		\N	\N	\N	1480	\N
176		\N		\N	\N	\N	1481	\N
531		\N		\N	\N	\N	1482	\N
455		\N		\N	\N	\N	1483	\N
121		\N		\N	\N	\N	290	\N
89		\N		\N	\N	\N	650	\N
108		\N		\N	\N	\N	1484	\N
292		\N		\N	\N	\N	1485	\N
9		\N		\N	\N	\N	1486	\N
353		\N		\N	\N	\N	1487	\N
453		\N		\N	\N	\N	1488	\N
419		\N		\N	\N	\N	1489	\N
523		\N		\N	\N	\N	1490	\N
554		\N		\N	\N	\N	1491	\N
413		\N		\N	\N	\N	1492	\N
128		\N		\N	\N	\N	1493	\N
555		\N		\N	\N	\N	1494	\N
36		\N		\N	\N	\N	1495	\N
47		\N		\N	\N	\N	1496	\N
72		\N		\N	\N	\N	1497	\N
81		\N		\N	\N	\N	1498	\N
120		\N		\N	\N	\N	1499	\N
135		\N		\N	\N	\N	1500	\N
149		\N		\N	\N	\N	1501	\N
161		\N		\N	\N	\N	1502	\N
200		\N		\N	\N	\N	1503	\N
280		\N		\N	\N	\N	1504	\N
285		\N		\N	\N	\N	1505	\N
293		\N		\N	\N	\N	1506	\N
313		\N		\N	\N	\N	1507	\N
324		\N		\N	\N	\N	1508	\N
347		\N		\N	\N	\N	1509	\N
345		\N		\N	\N	\N	1510	\N
368		\N		\N	\N	\N	1511	\N
373		\N		\N	\N	\N	1512	\N
557		\N		\N	\N	\N	1513	\N
429		\N		\N	\N	\N	1514	\N
479		\N		\N	\N	\N	1515	\N
484		\N		\N	\N	\N	1516	\N
490		\N		\N	\N	\N	1517	\N
503		\N		\N	\N	\N	1518	\N
504		\N		\N	\N	\N	1519	\N
506		\N		\N	\N	\N	1520	\N
512		\N		\N	\N	\N	1521	\N
555		\N		\N	\N	\N	1522	\N
556		\N		\N	\N	\N	1523	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: zh
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

