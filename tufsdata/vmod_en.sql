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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO en;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO en;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO en;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: en
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


ALTER TABLE public.t_instance OWNER TO en;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO en;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO en;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: en
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


ALTER TABLE public.t_usage_classified_rel OWNER TO en;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: en
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


ALTER TABLE public.t_usage_inst_rel OWNER TO en;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO en;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO en;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: en
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO en;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: en
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


ALTER TABLE public.t_word_inst_rel OWNER TO en;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: en
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO en;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: en
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO en;

--
-- Name: v_scene2; Type: VIEW; Schema: public; Owner: en
--

CREATE VIEW v_scene2 AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene2 OWNER TO en;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: en
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: en
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
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
13	It sure is.	本当にね。	賛同を示す		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
833	I was taking notes while talking on the phone.	私は電話で話しながらメモをとっていた。	\N		\N	vmod	\N	\N	\N	0	1
834	The news of the flood spread rapidly through the whole country.	洪水のニュースがたちまち国中に広まった。	\N		\N	vmod	\N	\N	\N	0	1
835	Remember to close the window if it starts to rain.	雨が降り始めたら、忘れずに窓を閉めて下さい。	\N		\N	vmod	\N	\N	\N	0	1
836	This book contains a lot of persuasive writing.	この本には説得力のある文章が多数含まれている。	\N		\N	vmod	\N	\N	\N	0	1
837	I have a lot of work to do on Tuesday.	火曜日にはやらなければならない仕事がたくさんあります。	\N		\N	vmod	\N	\N	\N	0	1
842	Whose pen is this?	これは誰のペンですか？	\N		\N	vmod	\N	\N	\N	0	1
40	Excuse me!	すみません！	注意を引く		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
230	Oh, look. 	あ、見てよ。	注意をひく		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
304	Sounds good. 	おいしそうだね。	意見を言う		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
448	OK.   What are they?	うん、どんなこと?	機能		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
537	Why?	どうして?	理由を尋ねる		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
272	Hmm, maybe yokan. 	うーん、ようかんかな。			\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
419	It's a deal.	取り引き成立。	同意する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
461	OK.	うん。	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
492	I won't.	もうしません。	数字についてたずねる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
530	You should go to Kyoto.	京都に行ったらいい。	助言する		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
613	That cap looks good on you.	その帽子はよく似合ってますよ。	\N		\N	vmod	\N	\N	\N	0	1
664	Where is the Japanese embassy?	日本大使館はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
770			\N		\N	vmod	\N	\N	\N	0	1
1	Good morning, Mrs. McDonald.	おはようございます、マクドナルド先生。	挨拶をする		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
2	Good morning, Kei, how are you?	おはよう、圭、元気?	挨拶をする		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
3	Fine, but a bit sleepy.	ええ、でもちょっと眠いです。	挨拶をする		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
4	How are you, Mrs. McDonald?	マクドナルド先生はどうですか?	挨拶をする		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
5	I'm also sleepy.	わたしも眠いのよ。	状態を述べる		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
6	I was reading until late last night.	                  夕べは                  遅くまで                  本を読んでいたから。	理由を述べる		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
7	I was writing E-mails to my friends in America. 	ぼくはアメリカの友達にＥメールを書いてたんです。	理由を述べる		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
8	Do you miss them? 	 (アメリカの友達)に会えなくてさびしい?	質問する		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
9	Not really, because I can always talk to them on the Internet.	そうでもないです、だっていつでもインターネットで話ができるから。	理由を述べる		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
10	Things are different from when I first came to Japan. 	わたしがはじめて日本に来たときとはずいぶん違うわね。	意見を言う		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
11	There wasn't such useful technology then.	そのころはそんな便利な科学技術はなかったから。	意見を言う		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
12	It's a smaller world, isn't it? 	世界は小さくなってきてますよね。	比べて述べる		\N	dmod	en01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
14	Hello. 	もしもし。	挨拶をする		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
15	Hello, Mr. Wilson?	もしもし、ウイルソン先生ですか?	挨拶をする		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
16	This is Kei. 	圭です。	自己紹介する		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
17	Hello, Kei!  	やあ、圭!	挨拶をする		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
18	How are you?  	どうだい、元気かい?  	どうしているかをたずねる		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
19	Oh, did you get our letter? 	ああ、ぼくたちからの手紙は受け取った?	情報を求める（経験）		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
20	Yes, it was very nice.	はい、とてもうれしかったです。	意見を言う		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
21	Thank you very much.	本当にありがとうございました。	感謝する		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
22	You're welcome.	どういたしまして。	挨拶をする		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
23	Also, thank you for the pictures. 	それから、写真をありがとうございました。	感謝する		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
24	They are beautiful! 	とってもよく撮れていますね。	意見を言う		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
25	Don't mention it.	どういたしまして。	挨拶をする		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
26	We really miss you, Kei. 	君がいなくてほんとうにさみしいよ、圭。	意見を言う		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
27	I miss you, too.	ぼくもです	意見を言う		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
28	Thank you for everything, Mr. Wilson.	いろいろとありがとうございました、ウイルソン先生。	感謝する		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
29	No problem, Kei. 	気にしなくていいよ、圭。			\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
30	And thanks for the call.	それから電話をありがとう。	感謝する		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
31	It's my pleasure. 	こちらこそどうも。	挨拶をする		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
32	Well, goodbye.	それじゃ、さようなら。	 さよならを言う		\N	dmod	en02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
33	Excuse me, can I help you?	すみません、何か用ですか? 	注意を引く		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
34	I was just ....	ぼくは、その･･･	言い訳をする		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
35	This room is for staff only.	この部屋は関係者しか入っちゃいけないんですよ。	禁止する		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
36	Oh, sorry, I didn't know. 	ああ、すみません、知らなかったから。	あやまる		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
37	That's OK, there's nothing special in it anyway. 	いいよ、どっちみちたいしたものがあるわけじゃないから。	意見を言う		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
38	I see.	ああ、そう。	相槌を打つ		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
39	Oh, wait!	あっ、ちょっと待って!	注意を引く		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
41	Yes? 	はい？	聞き返す		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
42	How do I get to the cafeteria?	カフェテリアへはどう行ったらいいのかな?	情報を求める（場所）		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
43	I'm lost.	迷っちゃって。	理由を述べる		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
44	Then, I'll show you the way. 	それなら、行き方を教えてあげるよ。	助言する		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
45	Thanks a lot! 	どうもありがとう! 	お礼を言う		\N	dmod	en03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
46	Today, we have a new student ―― Kei.	今日は新しい生徒が来ています ―― 圭。	挨拶する		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
47	Hi, my name is Kei. 	どうも、ぼくの名は圭です。	自己紹介する		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
48	Nice to meet you.	みなさんにお会いできてうれしいです。	挨拶する		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
49	Please tell the class about yourself.	あなたのことをクラスに紹介してください。	情報を求める（属性）		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
50	OK.	はい。	同意する		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
51	Well, I came back from America, from Saint Louis, Missouri last month.	えっと、アメリカの･･･ミズーリ州の、セントルイスから先月帰って来ました･･･。			\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
52	And what are your hobbies?	それで、あなたの趣味は?	嗜好を尋ねる		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
53	I like playing baseball and drawing pictures.	野球をするのと、絵を描くのが好きです。	嗜好について述べる(行動)		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
54	That's nice.	それはすてきね。	意見を言う		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
55	Oh, and I also like making new friends.	あ、それから、新しい友達を作るのも好きです。	嗜好について述べる（行動）		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
56	Good.	それは良かったわ。	同意する		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
57	Well, I think you'll make a lot of new friends here. 	ここでたくさん新しい友達ができると思うわよ。	意見を言う		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
58	Thank you, Mrs. McDonald.	ありがとうございます、マクドナルド先生。	感謝する		\N	dmod	en04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
59	I'm sorry I'm late! 	遅くなってごめんなさい! 	謝罪する		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
60	What happened?	どうしたの？	情報を求める（経験）		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
61	Oh, I took the wrong train.	ちがう電車に乗っちゃったの。			\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
62	I'm so sorry. 	ほんとうにごめんなさい。	謝罪する		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
63	That happens. 	そういうこともあるさ。	謝罪を受ける		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
64	But you could have called us.	でも電話をくれればよかったのに。	意見を言う		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
65	I wanted to, but I didn't know the number.	かけたかったんだけど、電話番号を知らなかったの。	理由を述べる		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
66	Oh, I'm sorry!  	ああ、ごめんよ！	謝罪する		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
67	I should have told you the number.	電話番号を教えてあげとけばよかったね。	ある条件での行動を言う		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
68	It's not your fault.	どっちにしても、あなたのせいじゃないわ。			\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
69	Anyway, I should have been more careful.	私がもっと気をつけていればよかったんだから。			\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
70	I have to apologize to all of you. 	みんなにおわびを言わなくっちゃ。	謝罪する		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
71	I have kept you waiting for half an hour. 	30分も待たせちゃって。	機能		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	\N
72	That's all right.	気にしないでいいよ。	謝罪を受ける		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
73	We had fun talking with each other. 	おしゃべりしていて楽しかったから。			\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
74	I'm glad to hear that.	それならよかった。			\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
75	OK, then let's get started.	よし、じゃあ始めようか。	提案する		\N	dmod	en05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
76	Are you having fun?	楽しんでいる?	状態をたずねる		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
77	Yeah. 	うん。	肯定する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
78	Your friends are great.	みんないい友達なのね。	意見を言う		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
79	Thanks. 	ありがとう。	感謝する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
80	Here.	どうぞ。	何かをあげる		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
81	This is for you. 	これは君に。	何かをあげる		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	1
82	It's from all of us.	ぼくたちみんなから。	何かをあげる		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[4]	\N	\N	\N
83	What is it? 	何かな?	情報を求める（属性）		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
84	Can I open it?	あけてみてもいい?	許可を求める		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
85	Sure.	もちろん。	機能		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
86	It's origami paper.	折り紙だよ。	説明する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
87	You can make different things with it. 	これでいろいろなものが作れるんだ。	説明する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
88	It's really pretty.	とってもかわいい。	意見を言う		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
89	Thanks a lot!	どうもありがとう！	感謝する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
90	Here.	どうぞ。	何かをあげる		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
91	This is also for you. 	これも君に。	何かをあげる		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
92	I made it. 	ぼくが作ったんだ。			\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
93	Oh, wow.	わあ、すごい。	感想を言う		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
94	It's a paper crane.	紙で作った鶴ね。	叙述する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
95	It's beautiful!	きれい！	感想を言う		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
96	I'm glad you like it.	喜んでもらえてうれしいよ。	感謝を受ける		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
97	Thank you, Kei.	ありがとう、圭。	感謝する		\N	dmod	en06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
98	Oh, I've got to go now. 	ああ、そろそろ行かなくっちゃ。	注意を引く		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
99	Yes, that's your flight.	そうだね、あれは君の乗る便だね。	同意する		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
100	Kei, thank you for everything. 	 圭、いろいろとありがとう。	感謝する		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
101	It was my pleasure.	ぼくも楽しかったよ。	お礼の返礼		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
102	Goodbye, Kei, I'll write to you.	さよなら、圭、またメールを書くわね。	さよならを言う		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
103	Goodbye, Julie, take care.	さよなら、ジュリー、気をつけてね。	さよならを言う		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
104	Oh, please give my best regards to your family and friends. 	そうだ、ご家族とお友達にどうぞよろしく伝えてね。	依頼する		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
105	I will.	わかったよ。			\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
106	We'll visit America again someday.	またいつかアメリカを訪ねるから。	希望を述べる		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
107	So, see you there then. 	それじゃ、そのときに会いましょう。	予定を言う		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
108	Bye for now.	とりあえずのさよならね。	さよならを言う		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
109	Have a nice flight!	いい空の旅をね!	挨拶をする		\N	dmod	en07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
110	Can I help you?	いらっしゃいませ。	挨拶をする		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
111	How much is this map of Australia? 	このオーストラリアの地図はいくらですか? 	情報を求める（金額）		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
112	It's 300 yen.	300円です。	値段を言う		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
113	And how about that book? 	その本はいくら?	情報を求める（金額）		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
114	The one about Native Americans? 	アメリカの先住民族の？	確認する		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
115	It's 800 yen.	800円です。	金額を言う		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
116	It looks interesting.	おもしろそうですね。	意見を言う		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
117	I'll take it, and the map.	それをください･･･それと地図も。	要求する		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
118	OK, so that's 1100 yen.	はい、1100円になります。	金額を言う		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
119	Oh, wait.	あ、ちょっと待って。	注意を引く		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
120	I only have 1000 yen.	1000円しか持ってないんです。			\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
121	OK, I'll make it 1000 yen then. 	いいですよ、それなら1000円にしてあげますよ。	妥協する		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
122	Great.	やったー。	喜ぶ		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
123	Thank you.	ありがとう。	感謝する		\N	dmod	en08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
124	Where would you like to go?	どこに行きたい?	希望をたずねる		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
125	I'd like to go to Tokyo Dreamland.	東京ドリームランドに行きたいな。	感謝する		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
126	Oh, Tokyo Dreamland. 	ああ、東京ドリームランドね。	相づちを打つ		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
127	Have you ever been there? 	行ったことがあるの?	情報を求める（経験）		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
128	Yes, I've been there four times. 	ああ、4回行ったことがあるよ。	経験を述べる		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
129	Four times? 	4回?	情報を求める（経験）		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
130	That's a lot!	そんなに!	意見を言う		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
131	Well, one of my classmates has been there more than twenty times.	でも、クラスの友達の一人は20回以上行ったことがあるんだって。	経験を述べる		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
132	That's unbelievable!	信じられない!	意見を言う		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
133	You'd get bored! 	あきちゃうよ!	意見を言う		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
134	Not really.	そうでもないよ。	軽い反論		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
135	It's fun every time.	行くたびに楽しめるよ。	意見を言う		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
136	Then I must go at least once. 	それじゃあぼくも少なくとも一回は行かなくちゃ。	希望を述べる		\N	dmod	en09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
137	Are you enjoying the game?	試合はおもしろい?	感想を聞く		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
138	Yeah, I was just thinking about summer vacation. 	うん、ちょっと夏休みのことを考えてたんだ。			\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
139	Oh, do you have any plans?	へえ、なにか予定があるの?	予定を聞く		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
140	Yeah, I am going to spend time with Julie, my friend from America. 	うん、アメリカから来る友だちのジュリーと過ごす予定なんだ。	予定を言う		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
141	Is she coming to Japan?	彼女が日本に来るの?	予定をきく		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
142	Uh-huh, she's coming in three weeks. 	ああ、そうだよ、あと3週間でやって来るんだ。 	予定を言う		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
143	That sounds nice.	それはいいね。	同意する		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
144	I can't wait for her to come.	彼女が来るのが待ちきれないよ。	期待する		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
145	What about you?	君はどうなの? 	予定をきく		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
146	What are your plans for the vacation? 	夏休みの予定はどんな?	予定をきく		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
147	I'm going back to Switzerland to visit my grandma and grandpa. 	おじいちゃんとおばあちゃんに会いにスイスに戻る予定なんだ。	予定を言う		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
148	I am looking forward to it. 	楽しみにしてるんだ。			\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
149	That should be fun.	それは楽しいだろうね。	意見を言う		\N	dmod	en10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
150	Your dad leaves home so early.	圭のパパはずいぶん早く家を出るのね。			\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
151	His office is rather far from home.	パパの会社は家からけっこう遠いんだ。	理由を述べる		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
152	How far is it?	どのくらい遠いの?	情報を求める（程度）		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
153	It's about an hour by train.	電車で1時間ぐらいかな。	時間を言う		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
154	An hour! 	1時間も!	驚く		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
155	That's far!	それは遠いわ!	驚く		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
156	How about your father?	君のパパは?	質問する		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
157	How far is his office from your house?	家から会社までどれくらいかかるの?	情報を求める（程度		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
158	It's about a fifteen-minute drive.	車で15分ぐらい。	時間を言う		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
159	How nice! 	いいなあ！			\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
160	No wonder your dad seems to be tired everyday. 	どうりで、圭のパパは毎日疲れてみえるの。	事情を理解する		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
161	Yeah, poor Dad.	そうだよね、気の毒なパパ。	同情する		\N	dmod	en11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
162	Are you OK?	だいじょうぶ?	どうしているかをたずねる		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
163	You look tired.	疲れているみたいだけど。	どうしているかをたずねる		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
164	Yeah, a little bit. 	うん、ちょっとね。　	あいまいな肯定		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
165	What time is it?	いま何時?	情報を求める（時間）		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
166	It's 1:15(one fifteen).	1時15分だよ。	時間を言う		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
167	What time is it in New York?　	ニューヨークでは何時かな?	情報を求める（時間）		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
168	Let me see.	ええとね。	答えを保留するつなぎの表現		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
169	It's 12:15(twelve fifteen).	12時15分だ。	時間を言う		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
170	A.m. or p.m.?	午前？午後?	情報を求める（時間）		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
171	It's 12:15 a.m. there.	むこうでは午前12時15分。	時間を言う		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
172	It's after midnight!	真夜中過ぎなの!	情報を求める（時間）		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
173	Wow!	うっそー！	驚く		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
174	That's why you're tired.	だから疲れてるんだ。	理由を述べる		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
175	I know.	そうね。	同意する		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
176	What time do we go to bed?	ねえ、何時に寝るの?	情報を求める（時間）		\N	dmod	en12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
177	Will you send me the ticket, then?	それじゃ、チケットを送ってくれる?	依頼する		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
178	All right.  Write down your address here. 	いいよ。ここに君の住所を書いて。	依頼する		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
179	Sure.	わかった。	同意する		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
180	What's your zip code?	郵便番号は何番?	情報を求める（数字）		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
181	It's 102-something.	102の何とか、だけど。	数字を言う		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
182	I always forget it.	いつも忘れちゃうんだよね。	状態を述べる		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
183	Do you know yours?	君は自分のを覚えてる?	情報を求める（数字）		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
184	Mine is 183-0003.	ぼくのは183-0003だよ。	数字を言う		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
185	So, what's yours?	それで、君のは？	情報を求める（数字）		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
186	I think it's 102-8554, but I'm not sure. 	102-8554だと思うんだけど、自信がないよ。	数字を言う		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
187	I'll call you later.	あとで電話するよ。	予定を言う		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
188	Okay.	オッケー。	同意する		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
189	I'll send you the ticket then.	そしたらチケットを送るから。	ある条件での行動を言う		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
190	Thanks.	ありがとう。	感謝する		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
191	No problem.	いいって。	感謝に対する返答		\N	dmod	en13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
192	I think the drawing is finished.	絵はこれで完成だと思うよ。	意見を言う		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
193	I think so, too.	私もそう思う。	同意する		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
194	Let's color it in.	色をぬっていこう。	提案する		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
195	What should I use for the sky?	空は何を使ったらいいかな?	助言を求める		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
196	You can fill it in with this blue marker. 	この青いマーカーペンでぬったらいいよ。	何でどのようにするかを言う		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
197	OK.	わかった。	同意する		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
198	And why don't you paint the trees with this green spray paint?	それじゃ木はこの緑のスプレー式の絵の具でぬったらどう?	何でどのようにするかを言う		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
199	Alright.	いいよ。	同意する		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
637	It's fairly cool here.	ここはとても涼しいね。	\N		\N	vmod	\N	\N	\N	0	1
200	What about the flowers?	花はどうする?	意見を求める		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
201	We can color them in with these red and yellow crayons.	ここにある赤と黄色のクレヨンでぬったらいいよ。	何でどのようにするかを言う		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
202	OK.	オッケー。	同意する		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
203	Oops.	おっと。	感嘆表現		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
204	I made a mistake. 	まちがえちゃった。			\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
205	Don't worry about it.	心配ないよ。			\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
206	Just cover it with that white paint. 	白い絵の具でぬりつぶせばいいよ。	何でどのようにするかを言う		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
207	That's a good idea.	それはいい考えね。	同意する		\N	dmod	en14.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
208	Your English is very good.	英語がとっても上手だね。	意見を言う		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
209	Thank you.	ありがとう。	感謝する		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
210	Where did you learn it?	どこで習ったの?	技能と能力についてたずねる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
211	I lived abroad for a few years.	何年か海外に住んでいたんだ。	理由を述べる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
212	I see.	なるほど。	納得する		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
213	So, you can speak Japanese and English?	それじゃ日本語と英語が話せるの?	技能と能力についてたずねる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
214	Well, sort of.	まあ、そんなとこかな。			\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
215	Can you speak any other language? 	ほかの言葉は話せるの?	技能と能力についてたずねる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
216	No.	だめ。	否定する		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
217	How about you?	君は?	技能と能力についてたずねる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
218	You said you're from Switzerland.	スイスから来たって言ってたよね。	情報を求める（属性）		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
219	Oh, yes.	ああ、そうだよ。	同意する		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
220	I can speak English, French and German.	英語と、フランス語と、ドイツ語が話せるよ。	例を挙げて述べる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
221	I can also speak some Japanese.	それから日本語も少し。	技能と能力について述べる		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
222	That's great!	すごいね！	意見を言う		\N	dmod	en15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
223	These penguins are cute.	このペンギン、かわいい。	形容する		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
224	They're really funny, aren't they?	ほんと、おもしろいよね。	形容する		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
225	Yeah.  Hey, where are all the big animals?	うん。 ねえ、大きい動物はどこにいるの?	情報を求める（場所）		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
226	Let me see. 	ええっとね。	間を置く		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
227	Well, there are some elephants here ― next to the　monkeys.	ここにゾウがいて―サルのとなりだ。	場所を説明する		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
228	Great.	やったー。	賛同する		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
229	Let's go see them.	見に行きましょ。	誘う		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
231	The hippopotamus and the rhinoceros are near there, too.	カバとサイもその近くだよ。	場所を描写する		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
232	What about lions?	ライオンは?	情報を求める		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
233	Are there any lions at this zoo?	この動物園にライオンはいるの?	情報を求める（存在と場所）		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
234	There are, but they are pretty far away. 	いるけど、けっこう遠くはなれてるよ。	場所･存在を示す		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
235	See?	ほら見て。	機能		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
236	Oh, cool, they're close to the snakes. 	あ、すごい、ヘビの近くなのね。	場所を示す		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
237	Yeah, but I don't want to go there. 	うん、でもぼくはそっちには行きたくないなあ。	希望を述べる		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
238	Lions and snakes are scary.	ライオンとヘビはおっかないよ。	機能		\N	dmod	en16.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
239	Thank you for showing me the way.	行き方を教えてくれてありがとう。	感謝する		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
240	No problem.	どういたしまして。	感謝に対する返答		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
241	I was thirsty, too. 	ぼくものどがかわいていたから。	体調を表す		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
242	You're a student here, aren't you?	君はここの生徒だよね?	情報を求める（属性）		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
243	Yes.	そう。	肯定する		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
244	What grade are you in? 	何年生なの?	情報を尋ねる(属性)		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
245	I'm in the fourth grade. 	４年生。	属性を言う		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
246	How about you?	君は。	同じ質問を聞き返す		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
247	I'm a fifth grade student. 	ぼくは5年生。	属性を言う		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
248	Do you go to a Japanese school?	日本の学校に通ってるの? 	情報を求める(属性)		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
249	Yes. 	そうだよ。	肯定する		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
250	Ah, you're English is good!	へえ、英語が上手だね!	誉める		\N	dmod	en17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
251	I think you should get her a book.	彼女には本をあげるのがいいと思うよ。	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
252	Umm, I don't think that's a good idea.	うーん、ぼくはあんまりいい考えじゃないと思う。	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
253	She can't read Japanese.	彼女は日本語が読めないんだ。			\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
254	How about a video game? 	テレビゲームはどう?	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
255	Yeah, but video games are too expensive.	そうだね･･･でもテレビゲームは高すぎるよ。	形容する		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
256	Yeah, you're right.	そうだね、君の言うとおりだ。	同意する		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
257	Hmm, This is difficult.	うーん、むずかしいなあ。	形容する		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
258	You could give her origami paper. 	折り紙をあげるのがいいと思うよ。	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
259	That's a good idea. 	それはいい考えだ。	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
260	Isn't it?	そうだろ?	同意を求める		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
261	You can teach her how to make things.	君がいろいろなものの作り方を教えてあげられるし。	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
262	I think she'll like that.	彼女も気に入ると思うよ。	意見を言う		\N	dmod	en18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
263	Ooo!  Natto!	ううー! なっとう! 			\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
264	I still can't get used to the smell.	まだそのにおいにはなじめないなあ。			\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
265	But you've come to like Japanese food a lot. 	でもずいぶん日本食が好きになってきたじゃない。 	嗜好について述べる（もの）		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
266	That's true. 	それはそうね。	同意する		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
267	For example, now you like nori.	たとえば、今ではのりは好きでしょ。	嗜好について述べる（もの）		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
268	But at first, it was weird eating black paper. 	でも最初は黒い紙を食べるのは妙な感じだったわ。	心情を述べる		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
269	You also like shirasu, don't you?	しらすも好きだよね?	嗜好を述べる（もの）		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
270	Yes, but it was scary when I first saw these tiny eyes.	ええ、でも初めてこの小さい目玉を見たときはこわかったけど。	心情を述べる		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
271	What's your favorite Japanese food?	いちばん好きな日本食は何かな?	嗜好についてたずねる（もの）		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
273	I love it! 	大好き! 	嗜好について述べる（もの）		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
274	Yuck!	げえっ!  	心情を述べる		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
275	I hate Japanese sweets!	ぼくは日本の甘いものはだめなんだ!	嗜好を述べる（もの）		\N	dmod	en19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
276	I like that one, too.	私もそれ、好きよ。	嗜好について述べる（もの）		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
277	Excuse me?	え、何ですか?	聞き返す		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
278	Your comic book. I like your comic book.	あなたのマンガ、そのマンガ好きよ。	嗜好について述べる（もの）		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
279	It's a good one.	これいいですよね。	意見を言う		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
280	I like reading American comics.	アメリカのマンガを読むのは好きなんです。	嗜好について述べる(行動)		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
281	It's fun, isn't it?	おもしろいでしょう?	嗜好について述べる(行動)		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
282	It's good English practice, too.	それにいい英語の練習にもなるし。			\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
283	I like studying English.	ぼく、英語を勉強するのが好きなんです。	嗜好について述べる(行動)		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
284	I'm glad, Kei. 	それはよかったわ、圭。	心情を表す		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
285	And this comic is about a baseball team. 	それにこのマンガは野球チームについてだし。			\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
286	I like playing baseball.	ぼく、野球をするのが好きなんです。	嗜好について述べる(行動)		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
287	Really? 	ほんとうに?	あいづち		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
288	I've never played baseball, but I like watching it.	私は野球はやったことはないけど、見るのは好き。	嗜好について述べる（行動）		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
289	Yeah, watching baseball is pretty fun.	ええ、野球を見るのはとても楽しいですね。	手段についてたずねる		\N	dmod	en20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
290	Alright. 	いいわ。			\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
291	Let's begin. 	始めましょ。	誘う		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
292	First, put the pancake mix in the bowl. 	はじめに、ホットケーキミックスをボウルに入れる。	手順と順序について述べる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
293	OK.	いいよ	同意する		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
294	Then what?	それから？	手順について尋ねる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
295	Then, put two eggs and some milk into the bowl.	それから、卵2個と牛乳を少し、ボウルに入れる。	手順と順序について述べる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
296	Done.	やったよ。 			\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
297	And after that?	そのあとは?	手順について尋ねる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
298	After that, mix it all together. 	そのあとは、全部をまぜ合わせるの。	手順と順序について述べる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
299	Got it.	わかった。			\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
300	Then what do I do?	それから何をしたらいい?	手順について尋ねる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
301	Next, put the mix in the pan, and flip it after a few minutes. 	次に、まぜたものをフライパンに入れて、何分かたったらひっくり返すの。	手順と順序について述べる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
302	Alright. 	ようし。			\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
303	Finally, we just wait until it's ready. 	最後は、出来上がるまで待つだけよ。	手順と順序について述べる		\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
305	And it smells great. 	それにとってもいいにおい。			\N	dmod	en21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
306	So, how are your parents? 	それで、ご両親はどう？	どうしているかをたずねる		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
307	They're fine, but they are really busy. 	元気だけど、ほんとうに忙しいの。	どうしているか答える		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
308	And how is your brother doing?	それとお兄さんはどうしてる? 	どうしているかたずねる		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
309	He's OK.	まあまあかな。	どうしているか答える		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
310	He's working at a bank.	銀行で働いているわ。			\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
311	That sounds boring.	つまんなさそう。	意見を言う		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
312	Yeah, but he likes it.	でしょ、でも彼は気に入ってるみたい。	嗜好について述べる(行動)		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
313	How about your sister?	妹さんは？			\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
314	How's she? 	どうしてる？	どうしているかたずねる		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
315	She's doing well. 	元気よ。	どうしているか答える		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
316	She's going to summer camp now. 	今はサマーキャンプに行ってる。			\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
317	That's cool.	それはいいなあ。	意見を言う		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
318	And how's Billy?	あと、ビリーはどうしてる?	どうしているかたずねる		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
319	My dog? 	うちの犬?	聞き返し		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
320	He's good, but he misses you. 	元気だけど圭がいなくなってさみしがってるわ。	どうしているか答える		\N	dmod	en22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
321	Are you excited about the picnic this Saturday?	土曜日のピクニック楽しみにしてる? 	心情を尋ねる		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
322	I am, but the weather might not be nice.	うん、でも、天気があまり良くないかも知れないよ。	天気について言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
323	Oh, no. 	ええー、困ったなあ。			\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
324	What do you want to do if the weather is bad?	もし天気が悪かったらどうしたい?	ある条件での行動を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
325	If it's just cloudy, we should still have the picnic.	もしくもってるだけだったら、そのままピクニックをやろうよ。	ある条件での行動を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
326	What about if it rains?	もし雨が降ったら?	ある条件での行動を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
327	If it rains, let's do something else.	もし雨が降ったら、何かほかのことをしよう。	ある条件での行動を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
328	Like what?	たとえばどんなこと?	例をたずねる		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
329	Hmm.  Well, if it rains, we could see a movie.	うーん、そうだなあ、もし雨だったら映画を見てもいいね。	ある条件での行動を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
330	That would be OK.	それはいいかもね。	意見を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
331	But I'd rather have a picnic. 	でも、ぼくはどっちかって言うとピクニックがいいな。	希望を述べる		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
332	Don't worry.	心配ないよ。			\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
333	If the weather is alright, we will. 	天気がだいじょうぶならそうするから。	ある条件での行動を言う		\N	dmod	en23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
334	What are you doing, Kei?	何をしてるの、圭？	どうしているかをたずねる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
335	I'm drawing a picture. 	絵を描いているんだ。			\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
336	It's my superhero. 	ぼくのスーパーヒーローだよ。			\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
337	Really?	ほんとうに？	聞き返し		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
338	Why is he so “super”? 	何がそんなにすごいわけ?	理由をたずねる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
339	Well, he's very strong –– stronger than an elephant.	えーっとね、彼はとても強いんだ。ゾウよりもね。	比べて述べる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
340	But he looks small.	でも彼は小さく見えるけど。			\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
341	Yeah, he's smaller than a human.	そう、人間よりも小さい。	比べて述べる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
342	But he's fast, too –– faster than a jet. 	でも速いんだよ、ジェット機よりも。	比べて言う		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
343	Is he smart?	頭はいいの?			\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
344	Sure.	もちろん。			\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
345	He's smarter than a computer.	コンピューターより頭がいいんだ。	比べて述べる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
346	I like his clothes.	彼の服が好き。	嗜好についてのべる(もの)		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
347	He's the coolest superhero I've ever seen.	今までに見た中でいちばんかっこいいスーパーヒーローよ。	比べて述べる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
348	Yep, he's the best.	でしょ、彼は最高なんだよ。	比べて述べる		\N	dmod	en24.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
349	Let's go to the mountains this weekend.	今週末、山に行こうよ。	提案する		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
350	Hmm, I don't know. 	うーん、どうしよう。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
351	Come on.	行こうよ。	誘う		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
352	It'll be fun.	きっと楽しいよ。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
353	We can go hiking.	ハイキングに行けるよ。	提案する		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
354	Yeah, but it's really hot.	うん、でもとっても暑いから。	天気について言う		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
355	Well,how about going to the beach?	そうだなあ、海に行くのはどう?	提案する		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
356	That sounds like fun. 	楽しそうね。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
357	OK.	オーケー。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
358	Let's go on Saturday then. 	そうしたら土曜日に行こう。	提案する		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
359	What about going on Sunday?	日曜日に行くのはどう?	提案する		\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
360	Isn't there a festival on Saturday? 	土曜日はお祭りがあるんじゃなかったっけ?			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
361	Oh yeah.	ああ、そうだ。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
362	I forgot.	忘れてた。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
363	This weekend is going to be great.	今週末はもりだくさんね。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
364	I can't wait.	待ちきれないな。			\N	dmod	en25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
365	Let's go outside and play.	外に出て遊ぼうよ。	提案する		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
366	No, I don't feel like it.	ううん、そんな気にならないよ。	理由を述べる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
367	Why not?	どうして？	理由をたずねる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
368	Because I'm watching this video.	だってこのビデオを見てるから。	理由を述べる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
369	You've already seen it a few times, haven't you?	もう何回か見たんだよね。	情報を求める（経験）		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
370	Why are you watching again?	なんでまた見ているの？	理由をたずねる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
371	Because it's my favorite American movie, and because it's good English practice.	だってこれはぼくのお気に入りのアメリカ映画で、それに英語のいい練習になるから。	理由を述べる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
372	Well, let's practice English outside.	ねえ、英語の練習は外でやろうよ。	提案する		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
373	Why do you want to play outside so much?	なんでそんなに外で遊びたいの？	理由をたずねる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
374	Because it's a nice, sunny day,	だって日がさして気持ちのいいお天気だし･･･ 	理由を述べる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
375	come on.	行こうよ。	誘う		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
376	Let's go.	いっしょに。	提案する		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
377	Alright.	わかった。	同意する		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
378	Just wait a second.	ちょっとだけ待って。	指示する		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
379	This part is great.	ここがいい場面なんだ。	理由を述べる		\N	dmod	en26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
380	These scissors don't cut so well.	このはさみはあまりよく切れないや。	ある状態についていう		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
381	Can you lend me those?	君のをかしてくれる？	依頼する		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
382	Just a second.	ちょっと待って。			\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
383	OK, here you go.	はい、どうぞ。	機能		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
384	Thanks.	ありがとう。	感謝する		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
385	No problem.	どういたしまして。	感謝に対する返答		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
386	Kei, will you pass me the glue?	圭、のりを取ってくれる？	依頼する		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
387	Sure.	いいよ。	依頼に応じる		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
388	Here you are.	どうぞ。	機能		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
389	Thank you.	ありがとう。	感謝する		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
390	Oh no!	おっと、いけない。	否定的な驚きを示す		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
391	I cut too far.	切りすぎた。	機能		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
392	It's not so bad.	そんなでもないよ。	慰める		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
393	Maybe it's not.	そうかもしれない。	機能		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
394	Can you give me the tape?	セロテープをくれる？	依頼する		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
395	Sure, but I can't find it.	もちろん、でも見つからないわ。	機能		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
396	Oh, here it is.	ああ、ここにあった。	機能		\N	dmod	en27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
397	What kind of store is that?	あれは何の店？	質問する		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
398	It's a futonya.	あれは布団屋。			\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
399	They sell futon there.	布団を売ってるんだ。	答える		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
400	Oh, futons.	ああ、フトンね。	反復する		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
401	That's right, futons.	そのとおり、フトンだよ。	肯定する		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
402	And they sell other things, too, for example, sheets, blankets, pillows.	それからほかのものも売ってる。たとえば、シーツ、毛布、まくらとか。	例をあげて述べる		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
403	And what about that store?	それじゃ、あの店は？	質問する		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
404	That's a kanamonoya.	あれは金物屋。	機能		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
405	What do they sell there?	何を売っているの？	質問する		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
406	They sell lots of things, like buckets, knives, tools, and ladders.	いろんなもの、たとえばバケツ、ナイフ、工具、はしごとか。	陳述文		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
407	Oh, so it's like a hardware store. 	ああ、それじゃ「ハードウェアーストアーみたいなものね。」	納得する		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
408	Well, kind of.	まあ、そんなもんかな。	機能		\N	dmod	en28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
409	That rollercoaster was great.	ジェットコースターはすごかったね。	形容する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
410	Let's go on it again.	また乗ろうよ。	提案する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
411	No. If we go on it again, I might get sick.	やだよ。もう一度乗ったら、気分が悪くなりそう。	ある条件での状態を言う		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
412	Well, what do you want to do then?	じゃあ、それなら君はどうしたい？	希望をたずねる		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
413	Let's ride the Ferris Wheel.	大観覧車に乗ろうよ。	提案する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
414	OK. But if I ride the Ferris Wheel again, will you go on the rollercoaster after that?	いいけど、でももう一度大観覧車に乗ったら、そのあとジェットコースターに乗る?	妥協する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
415	No, I really don't want to.	やだ、ほんとうに乗りたくないんだ。	希望を述べる		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
416	OK, fine.  If I go on the Ferris Wheel, will you go on the big slide after that?	わかった、いいよ。もしぼくが大観覧車に付き合ったら、そのあとビッグ･スライドにつき合ってくれる?	妥協する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
417	I guess so.	たぶんね。	妥協する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
418	But only if we get ice cream first.	でもまず最初にアイスクリームを食べてから。	妥協する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
420	Great.	やったー	喜ぶ		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
421	Let's go.	さ、行こう。	提案する		\N	dmod	en29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
422	Mrs. McDonald, is it alright if I change my report topic from dinosaurs to pirates?	マクドナルド先生、ぼく、レポートの題を恐竜から海ぞくに変えてもかまわないですか?	許可を求める		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
423	Sure.	もちろん。	同意する		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
424	If you want to, go ahead.	そうしたければ、いいわよ。	勧める		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
425	May I borrow that book then?	そしたら、あの本を借りてもいいですか。	許可を求める		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
426	OK.  But make sure to give it back to me.	いいわよ。でも必ず返してね。	妥協する		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
427	No problem.	わかりました。	同意する		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
428	Kei, do you have enough time to finish a new report? 	圭、新しいレポートを仕上げるのに時間は足りそう?	質問する		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
429	Well, I don't know.	さあー、わかりません。	あいまいに返答する		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
430	Could I turn it in after summer vacation?	夏休み後に提出してもいいですか?	許可を求める		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
431	I guess so.	そうね…。	あいまいな許可を与える		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
432	Kei is something the matter?	圭、どうしたの?	質問する		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
433	No, not really, but can I go to the bathroom?	あの、別に、でもトイレに行っていいですか?	許可を求める		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
434	Of course.	もちろん。	許可を与える		\N	dmod	en30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
435	My friend, Hiro, invited me over for dinner, but I'm not sure about Japanese manners.	友達の浩(ヒロ)が夕食に招待してくれたんだけど、日本のマナーについてわからないんだ。	不確信		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
436	Like what?	たとえばどんなこと?	例をたずねる		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
437	For instance, should I bring something?	たとえば、何か持っていくべきか？	義務を確認する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
438	Hmm, you should probably bring something small –– like some sweets.	えーとね、なんかちょっとしたもの、たとえばお菓子とかを持っていったらいいと思うよ。	義務を確認する/肯定する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
439	What do I need to say when I meet his parents?	彼のご両親に会ったらなんて言うの?	義務を確認する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
440	When you go into the house, you have to say “ojamashimasu”; and when you meet his parents, you have to say “hajimemashite.”	家に入るときには｢おじゃまします｣って言わないといけないし、彼のご両親に会ったら「はじめまして」って言わないと。	ある条件での行動を言う		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
441	What about table manners? 	テーブルマナーとかはどうなの?	義務を確認する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
442	Do I have to use chopsticks? 	おはしを使わないとだめかなあ？	義務を確認する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
443	You should try to use them.	使おうとしたほうがいいよ。	助言する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
444	Ok, I'll try.	わかった、やってみる。 	機能		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
445	I want to be polite.	礼儀正しくしたいもんね。 	希望を述べる 		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
446	Well, if you really want to be polite, you need to say “itadakimasu” before you eat. 	まあね、もしほんとうに礼儀正しくしたいなら、食べる前に｢いただきます｣を言わなくっちゃ。	助言する		\N	dmod	en31.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
447	Julie, my parents have a few house rules. 	ジュリー、いくつかうちの両親がきめた家での決まりがあるんだ。	機能		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
449	Well, first, you mustn't wear shoes in the house.	えー、まず、家の中では靴をはかないこと。	禁止する		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
450	I know that.	それは知ってるよ。	機能		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
451	Also, we can't watch TV after 8:00.	それから、8時以降はテレビを見ちゃいけない。	 禁止する		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
452	Alright.	わかった。	承知する		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
453	And we mustn't be too noisy at night.	それと夜はあんまりうるさくしちゃいけない。	禁止する		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
454	OK. Is that it?	うん。それでおしまい?	機能		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
455	I think so.	そうだと思う。	機能		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
456	My parents are strict, huh?	うちの両親は厳しいだろ、ね?	意見をたずねる		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
457	Not really.	別に。	機能		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
458	I think my parents are worse.	うちの親のほうがひどいかも。	比べて述べる		\N	dmod	en32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
459	Oh, this is a new level.	あっ、新しいレベルだ。	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
460	Tell me what to do, Kei.	どうしたらいいか教えて、圭。	依頼する		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
462	First, press the red button and run over there. 	はじめに、赤いボタンを押してそこまで走る。	指示する 		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
463	Got it.	オーケー。	機能 		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
464	Then what?	それからどうするの?	手順について聞く		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
465	Well, let me see.	えっと、ちょっと待って。	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
466	Oh yeah.	ああ、そうそう。	思いつく、思い出す		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
467	Jump into that airplane.	その飛行機に飛び乗って。	指示する		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	1
468	Where do I go? 	どこに行くわけ?	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
469	Fly up there –– toward the castle. 	そこへあがって行って―お城に向かって。	指示する		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
470	Alright.	わかった。			\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
471	This is easy.	これならかんたん。	意見を言う		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
472	But be careful.	でも気をつけて。	指示する、注意する		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
473	And stay away from the black planes.	それから、黒い飛行機はよけて。	指示する、注意する		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
474	Wow!	ええー! 	驚く		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
475	There're so many!	いっぱいいる! 	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
476	Oh, no.	おっと、いけない。 	悲観を表す		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
477	I'm dead.	やられちゃった。 	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[4]	\N	\N	\N
478	Don't worry. 	心配ないよ。	機能		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
479	Just start over.	もう一回最初からやったらいいよ。	助言する		\N	dmod	en33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
480	Kei!	圭!	挨拶する		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
481	Yes, Mrs. McDonald.	はい、マクドナルド先生。	感謝する		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
482	Would you mind not making so much noise?	そんなにうるさくしないでくれる?	注意をひく		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
483	Sure, sorry about that.	わかりました、すみません。	自己紹介する		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
484	And you shouldn't play in the hall.	ろうかで遊んではいけませんよ。	謝る		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
485	I was only kicking the ball around.	ボールをけってただけです。	人にものをあげる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
486	It doesn't matter.	そういうことではありません。	さよならを言う		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
487	Don't play in the school building.	校舎の中で遊んではいけません。	金額についてたずねる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
488	But, Mrs. McDonald, it's raining outside.	でも、マクドナルド先生、外は雨ですよ。	経験についてたずねる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
489	Then go to the gym.	それなら体育館に行きなさい。	予定を述べる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
490	And don't kick that ball in the hall.	とにかく、そのボールをろうかでけるのはだめです。	程度についてたずねる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
491	OK.	はい。	時間についてたずねる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
493	I'm sorry.	ごめんなさい。	手段についてたずねる		\N	dmod	en34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
494	Should I take my dishes to the kitchen?	自分の食器を台所に下げたほうがいいの?	義務を確認する 		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
495	No, you don't have to.	ううん、しなくていいよ。	義務を確認する/否定する		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
496	I'll do it.	ぼくがするから。	機能		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
497	Are you sure?	ほんとに?	確認する		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
498	I'd like to help out.	私もお手伝いしたいな。	希望を述べる、申し出る		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
499	Don't worry about it.	そんな気を使わないで。	機能		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
500	You're our guest.	お客さんなんだから。			\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
501	What about other things?	ほかのことはどう?	機能		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
502	Like what?	たとえばどんなこと?	例をたずねる		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
503	Well, what about my laundry? 	そうね、たとえば洗たく物は?　	機能		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
504	Do I have to wash my own clothes?	自分の服は自分で洗うようにするの?　	義務を確認する		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
505	No, you don't have to.	いいや、しなくていいよ。	義務を確認する/否定する 		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
506	My mom will do it.	お母さんがするから。	機能		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
507	Do I need to clean up my room everyday?	自分の部屋は毎日そうじしなくちゃいけないかな?	義務を確認する		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
508	No, you don't need to.	ううん、しなくてもいいよ。	義務を確認する/否定する		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
509	But you must make your bed. 	でもベッドは毎日ととのえてね。	指示する		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
510	That's it.	それだけ。	機能		\N	dmod	en35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
511	My parents were wondering.	うちの両親がききたいんだけど。			\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
512	Yes?	なあに?	聞き返す(経験)		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
513	Would your family like to come to Japan this summer?	お宅のご家族でこの夏に日本に来るのはどうかな、って。	招待する		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
514	Oh, umm, I'm sorry, but I don't think my parents can this summer.	わあ、うーん、ごめんなさい、でもこの夏うちの親はむりだと思う。	あやまる		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
515	That's too bad.	それは残念。	意見を言う		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
516	It is, isn't it?	そうよね。	同意を求める		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
517	They're terribly busy.	2人ともむちゃくちゃいそがしいのよ。	理由を述べる		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
518	Well, what about you?	それじゃ、君は?　			\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
519	Do you want to come to Japan this summer?	この夏日本に来たい?	招待する、希望を尋ねる		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
520	Me?	私?	聞き返す		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
521	Yeah, I'd love to.	そりゃ、もちろん行きたいわ。	希望を述べる		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
522	How about coming in July?	7月に来るのはどう?	助言する		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
523	I have summer holidays then. 	そのころはぼくの夏休みだから。	理由を述べる		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
524	That sounds good, but I have to ask my parents first. 	それはいい考えだけど、まずうちの親にきいてみなくちゃ。	義務を言う		\N	dmod	en36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
525	My aunt and cousin are visiting this fall. 	ぼくのおばさんといとこがこの秋に訪ねて来るんだ。	機能		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
526	That's nice.	それはいいね。	意見を言う		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
527	What are you going to do with them?	いっしょに何をする予定なの?	予定を尋ねる		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
528	I'm not too sure.	まだよくわからないけど。	不確信		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
529	They want to travel around Japan.	日本をあちこち旅行して回りたいらしいよ。	希望を述べる		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
531	It's beautiful there in the fall.	秋にはとってもきれいだよ。	理由を述べる		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
532	I've never been to Kyoto.	ぼくはまだ京都に行ったことはないな。	経験について言う		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
533	It's fantastic.	すばらしいよ。	意見を言う		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
534	If you go there, you should visit the many temples and shrines.	もし京都に行ったら、たくさんあるお寺や神社を訪ねるといいよ。	助言する		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
535	My aunt would like that.	おばさんはきっと気に入るだろうな。	嗜好について述べる		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
536	But if you want to visit Kyoto then, your family had better make reservations now.	でも、そのころに京都に行きたかったら君のご家族はいまから予約をしたほうがいいよ。	助言する		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
538	Is it crowded there in the fall?	秋の京都は混んでいるの?	理由を尋ねる		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
539	Yeah, there are a lot of tourists, so you should make sure to plan ahead. 	そうだよ、観光客がいっぱいだから早めに計画を立てるようにしたほうがいいよ。	助言する		\N	dmod	en37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
540	Your desk is a mess!	机の上がぐちゃぐちゃですね!	意見を言う		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
541	It's not that messy.	そうでもないですよ。	意見を言う		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
542	Yes, it is.	いいえ、ぐちゃぐちゃです。	意見を言う		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
543	And class is about to begin.	それにもうすぐ授業が始まりますよ。			\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
544	Please clean up your desk right away.	今すぐ机の上を片付けなさい。	指示する		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
545	I will.	はい。			\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
546	First, I want you to throw away that paper. 	まず、その紙を捨ててちょうだい。	要求する		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
547	OK, just a second.	はい、ちょっとだけ待ってください。			\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
548	And after that, I want you to put away those colored pencils. 	それから、その色鉛筆を片付けて。	要求する		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
549	Alright.	わかりました。	承知する		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
550	And stop working on your project.  Right now! 	その課題に取りくむのはやめなさい。今すぐに! 	要求する		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
551	OK. 	はい｡			\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
552	Sorry, Mrs. McDonald.	すみません、マクドナルド先生。	あやまる		\N	dmod	en38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
553	What do you want to do when you grow up?	大人になったら何をしたい?	希望を訪ねる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
554	When I grow up, I want to do something creative.	大人になったら、何かを創つくるようなことをしたいな。	希望を述べる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
555	Oh, yeah?	へえー、ほんとに?	あいづち		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
556	Yeah, I'd like to become an artist.	うん、芸術家になりたいんだ。	希望を述べる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
557	What kind of artist?	どんな芸術家?	情報を求める（属性）		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
558	I want to be a writer or a painter.	作家か、画家になりたいな。	希望を述べる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
559	Why?	どうして?	理由を尋ねる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
560	What do you want to do when you grow up?	君は大きくなったら何になりたいの?	希望を述べる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
561	I want to travel around the world.	私は世界中を旅して回りたいの。	希望を述べる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
562	That sounds exciting.	それはわくわくするね。	意見を言う		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
563	Yeah, so I'd like to become a pilot.	でしょ、だからパイロットになりたいな。	希望を述べる		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
564	That's a great dream.	すごい夢だね。	意見を言う		\N	dmod	en39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
565	Mrs. McDonald, this is my friend, Heinrich.	マクドナルド先生、こちらがぼくの友達のハインリックです。	人を紹介する		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
566	He's from Switzerland.	彼はスイスから来たんです。	感謝する		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
567	Nice to meet you, Heinrich.	会えてうれしいわ、ハインリック。	挨拶する		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
568	Nice to meet you, too.	こちらこそお会いできてうれしいです。	自己紹介する		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
569	Heinrich is a student at the International School.	ハインリックはインターナショナルスクールの生徒なんです。			\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
570	I came to Japan in April.	4月に日本に来ました。	人にものをあげる		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
571	Mrs. McDonald is my English teacher.	マクドナルド先生はぼくの英語の先生。	人を紹介する		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
572	She's from England.	イングランドから来てるんだ。	金額についてたずねる		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
573	Oh, that's nice.	へえ、すてきですね。			\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
574	She's a great teacher.	すごくいい先生だよ。	誉める		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
575	Well, thank you, Kei.	まあ、ありがとう、圭。 	感謝する		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
576	It was nice to meet you, Heinrich.	会えてよかったわ、ハインリック。	挨拶をする		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
577	It was nice to meet you, too, Mrs.McDonald.	こちらこそお会いできてよかったです、マグドナルド先生。	数字についてたずねる		\N	dmod	en40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
578	Please add a little water to the pot.	鍋に少量の水を加えてください。	\N		\N	vmod	\N	\N	\N	0	1
579	Try to behave like an adult.	大人らしく振舞うよう努めなさい。	\N		\N	vmod	\N	\N	\N	0	1
580	I'm going to see a movie this afternoon.	今日の午後は映画に行くつもりです。	\N		\N	vmod	\N	\N	\N	0	1
581	John gave up alcohol ten years ago.	ジョンは10年前に酒をやめました。	\N		\N	vmod	\N	\N	\N	0	1
582	Please answer my question.	私の質問に答えて下さい。	\N		\N	vmod	\N	\N	\N	0	1
583	He lives in an apartment,	彼はアパートに住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
584	Somebody took me by the arm.	誰かが私の腕をつかんだ。	\N		\N	vmod	\N	\N	\N	0	1
585	The train will arrive at 10:30.	その電車は10時半に到着します。	\N		\N	vmod	\N	\N	\N	0	1
586	Don't play with ashtrays.	灰皿で遊んではいけません。	\N		\N	vmod	\N	\N	\N	0	1
587	She put out her cigarette in the ashtray.	彼女はタバコの火を灰皿でもみ消した。	\N		\N	vmod	\N	\N	\N	0	1
588	I'll be on vacation in August.	8月は休みです。	\N		\N	vmod	\N	\N	\N	0	1
589	Mind your back!	後ろを通ります！	\N		\N	vmod	\N	\N	\N	0	1
590	His sandwiches are terrible!	彼のサンドイッチは恐ろしくまずいね！	\N		\N	vmod	\N	\N	\N	0	1
591	Can I help you carry your bag?	かばんを運ぶのを手伝いましょうか？	\N		\N	vmod	\N	\N	\N	0	1
592	I have five pieces of baggage.	私は荷物を4個持っています。	\N		\N	vmod	\N	\N	\N	0	1
593	Attach name tags to all of your baggage.	全ての荷物に名札をつけて下さい。	\N		\N	vmod	\N	\N	\N	0	1
594	My ballpoint pen has run out of ink.	私のボールペンはインクが切れてしまいました。	\N		\N	vmod	\N	\N	\N	0	1
595	The bath is ready.	お風呂が沸いているよ。	\N		\N	vmod	\N	\N	\N	0	1
596	Season the beef with herbs and spices before cooking.	調理をする前に、牛肉にハーブとスパイスで味付けをしてください。	\N		\N	vmod	\N	\N	\N	0	1
597	I practiced riding my bicycle a lot last summer.	私は去年の夏、自転車に乗る練習を一生懸命しました。	\N		\N	vmod	\N	\N	\N	0	1
598	That elephant is very big!	あの象はとても大きいね！	\N		\N	vmod	\N	\N	\N	0	1
599	I have just enough money to buy this book.	ちょうどこの本を買えるだけのお金を持っています。	\N		\N	vmod	\N	\N	\N	0	1
600	Today I'll talk to you about the structure of the human body.	今日は人体の構造についての話をします。	\N		\N	vmod	\N	\N	\N	0	1
601	Look up this word in your dictionary.	この単語を辞書で調べなさい。	\N		\N	vmod	\N	\N	\N	0	1
602	The boy likes to play the guitar.	その男の子はギターを弾くのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
603	Can you cut me a slice of bread?	パンを一切れ切ってくれませんか？	\N		\N	vmod	\N	\N	\N	0	1
604	You must eat breakfast every day.	毎日朝食を食べなければいけません。	\N		\N	vmod	\N	\N	\N	0	1
605	How many brothers and sisters do you have?	兄弟姉妹は何人いらっしゃいますか？	\N		\N	vmod	\N	\N	\N	0	1
606	That man with brown hair is Mr. Smith.	あの茶色の髪の男はスミス氏です。	\N		\N	vmod	\N	\N	\N	0	1
607	Is it possible to get there by bus?	そこへバスで行くことはできますか？	\N		\N	vmod	\N	\N	\N	0	1
608	New York is a large, busy city.	ニューヨークはにぎやかな大都会です。	\N		\N	vmod	\N	\N	\N	0	1
609	Can you spread butter on my toast?	私のトーストにバターを塗ってくれますか？	\N		\N	vmod	\N	\N	\N	0	1
610	Do you see that big tree by the house?	家のそばにあるあの大きな木が見えますか？	\N		\N	vmod	\N	\N	\N	0	1
611	I bought a new camera for my trip to America.	私はアメリカに旅行するので新しいカメラを買った。	\N		\N	vmod	\N	\N	\N	0	1
612	Don't eat so many pieces of candy before dinner.	夕食の前にそんなにたくさんのキャンディーを食べてはいけません。	\N		\N	vmod	\N	\N	\N	0	1
614	You must not drink alcohol before driving.	車を運転する前に酒を飲んではいけません。	\N		\N	vmod	\N	\N	\N	0	1
615	Please sit in the red chair.	どうぞその赤い椅子に座ってください。	\N		\N	vmod	\N	\N	\N	0	1
616	This book was very cheap.	この本はとても安かった。	\N		\N	vmod	\N	\N	\N	0	1
617	Cheese is good for your health.	チーズは健康によい。	\N		\N	vmod	\N	\N	\N	0	1
618	Which would you like, beef or chicken?	牛肉と鶏肉、どちらにしますか？	\N		\N	vmod	\N	\N	\N	0	1
619	Their oldest child will be 15 years old next week.	彼らの一番上の子は来週で15歳になります。	\N		\N	vmod	\N	\N	\N	0	1
620	Eating and drinking are strictly prohibited in this classroom.	この教室での飲食は厳しく禁止されています。	\N		\N	vmod	\N	\N	\N	0	1
621	I always clean my room before my friends come over.	私はいつも友達が来る前に自分の部屋を掃除します。	\N		\N	vmod	\N	\N	\N	0	1
622	The bathroom needs a clean.	その浴室は掃除しないといけない。	\N		\N	vmod	\N	\N	\N	0	1
623	The room is very clean.	その部屋はとてもきれいだ。	\N		\N	vmod	\N	\N	\N	0	1
624	I hope the weather will clear tomorrow.	明日は晴れるといいですね。	\N		\N	vmod	\N	\N	\N	0	1
625	This clock loses one minute a day.	この時計は1日に1分遅れる。	\N		\N	vmod	\N	\N	\N	0	1
626	Please close the door.	ドアを閉めてください。	\N		\N	vmod	\N	\N	\N	0	1
627	Can I help you off with your coat?	コートを脱ぐのをお手伝いしましょうか？	\N		\N	vmod	\N	\N	\N	0	1
628	Do you have coffee with milk or sugar?	コーヒーにはミルクか砂糖を入れますか？	\N		\N	vmod	\N	\N	\N	0	1
629	Starbucks is my favorite coffee shop.	スターバックスは私のお気に入りのコーヒーショップです。	\N		\N	vmod	\N	\N	\N	0	1
630	I have a slight cold today.	今日は風邪気味です。	\N		\N	vmod	\N	\N	\N	0	1
631	It is very cold outside.	外はとても寒い。	\N		\N	vmod	\N	\N	\N	0	1
632	Do you want something cold to drink?	何か冷たい飲み物が欲しいですか？	\N		\N	vmod	\N	\N	\N	0	1
633	He likes quiet colors.	彼は落ち着いた色が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
634	My father works for a well-known company.	私の父は有名な会社に勤めています。	\N		\N	vmod	\N	\N	\N	0	1
635	It's convenient to use traveler's checks when traveling.	旅行の際にはトラベラーズチェックを使うと便利です。	\N		\N	vmod	\N	\N	\N	0	1
636	I love my mother's cooking.	私は母の料理が大好きです。	\N		\N	vmod	\N	\N	\N	0	1
638	Please make a copy of this article for me.	私にこの記事のコピーをとってください。	\N		\N	vmod	\N	\N	\N	0	1
639	Can you copy all the pages of this book for me?	私にこの本を全部コピーしてくれませんか？	\N		\N	vmod	\N	\N	\N	0	1
640	You may not run in the corridor.	廊下を走ってはいけません。	\N		\N	vmod	\N	\N	\N	0	1
641	Many letters were sent from all over the country.	たくさんの手紙が全国から送られてきました。	\N		\N	vmod	\N	\N	\N	0	1
642	They are a well-matched couple.	彼らはお似合いの夫婦です。	\N		\N	vmod	\N	\N	\N	0	1
643	You should look both ways at a crossroads.	交差点では左右を見なければいけません。	\N		\N	vmod	\N	\N	\N	0	1
644	Would you like another cup of tea?	紅茶のお代わりはいかがですか？	\N		\N	vmod	\N	\N	\N	0	1
645	I like curry and rice very much.	私はカレーライスがとても好きです。	\N		\N	vmod	\N	\N	\N	0	1
646	I cut my finger with a knife.	私はナイフで指を切ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
647	Let's go home before it gets dark.	暗くなる前に家に帰ろう。	\N		\N	vmod	\N	\N	\N	0	1
648	She had dark brown hair.	彼女はこげ茶色の髪をしていた。	\N		\N	vmod	\N	\N	\N	0	1
649	Perhaps you can see Santa Claus in December.	12月にはサンタクロースに会えるかもしれないよ。	\N		\N	vmod	\N	\N	\N	0	1
650	Water boils at 100 degrees Celsius.	水は摂氏100度で沸騰する。	\N		\N	vmod	\N	\N	\N	0	1
651	This looks delicious!	おいしそう！	\N		\N	vmod	\N	\N	\N	0	1
652	My uncle runs a department store.	私の叔父はデパートを経営しています。	\N		\N	vmod	\N	\N	\N	0	1
653	Many people die in car accidents every year.	毎年多くの人が自動車事故で亡くなっています。	\N		\N	vmod	\N	\N	\N	0	1
654	The dining room is next to the kitchen.	食堂は台所の隣にあります。	\N		\N	vmod	\N	\N	\N	0	1
655	Please wash your dirty hands before eating dinner.	夕食の前にその汚い手を洗ってください。	\N		\N	vmod	\N	\N	\N	0	1
656	Call a doctor, please.	医者を呼んで下さい。	\N		\N	vmod	\N	\N	\N	0	1
657	Don't look down!	下を見ちゃだめだ！	\N		\N	vmod	\N	\N	\N	0	1
658	Your dress must have been very expensive.	あなたの洋服は高かったに違いありませんね。	\N		\N	vmod	\N	\N	\N	0	1
659	I hate soft drinks because they are bad for your health.	清涼飲料水は健康に良くないので、私は嫌いです。	\N		\N	vmod	\N	\N	\N	0	1
660	How about a drink?	一杯やりませんか？	\N		\N	vmod	\N	\N	\N	0	1
661	My ear itches.	耳がかゆい。	\N		\N	vmod	\N	\N	\N	0	1
662	The sun rises in the east.	太陽は東から昇る。	\N		\N	vmod	\N	\N	\N	0	1
663	I was stuck in the elevator for 20 minutes yesterday.	私は昨日そのエレベーターに20分間閉じ込められました。	\N		\N	vmod	\N	\N	\N	0	1
665	The entrance to the cave was very narrow.	その洞窟への入り口はとても狭かった。	\N		\N	vmod	\N	\N	\N	0	1
666	Could you open this envelope?	この封筒を開けてくれませんか？	\N		\N	vmod	\N	\N	\N	0	1
667	You'd better erase the blackboard before the teacher comes.	先生が来る前に黒板を消しておいたほうがいいよ。	\N		\N	vmod	\N	\N	\N	0	1
668	My teacher told us to write a composition on Japanese movies.	先生は日本映画について作文を書くように言いました。	\N		\N	vmod	\N	\N	\N	0	1
669	We had a pleasant evening yesterday.	昨日は楽しい夕べを過ごしました。	\N		\N	vmod	\N	\N	\N	0	1
670	Come back before evening.	夕方までには戻ってきなさい。	\N		\N	vmod	\N	\N	\N	0	1
671	I go to a movie every month.	毎月映画を見に行きます。	\N		\N	vmod	\N	\N	\N	0	1
672	I clean my room every week.	私は毎週、自分の部屋を掃除します。	\N		\N	vmod	\N	\N	\N	0	1
673	My grandfather visits us every year.	私のおじいちゃんは毎年私たちを訪れます。	\N		\N	vmod	\N	\N	\N	0	1
674	A serious illness requires a visit to the doctor.	重い病気にかかったら、医者に診てもらわないといけません。	\N		\N	vmod	\N	\N	\N	0	1
675	Please make sure you know where the emergency exits are.	どうぞご自分で非常口の位置を確認してください。	\N		\N	vmod	\N	\N	\N	0	1
676	My grandmother has deep lines on her face.	私のおばあちゃんは顔に深いしわがある。	\N		\N	vmod	\N	\N	\N	0	1
677	Green tea is famous as a traditional Japanese drink.	緑茶は日本の伝統的な飲み物として有名です。	\N		\N	vmod	\N	\N	\N	0	1
678	Please fasten your seat belt during take-off and landing.	離着陸の際には必ずシートベルトを締めてください。	\N		\N	vmod	\N	\N	\N	0	1
679	February 14th is Valentine's Day.	2月14日はバレンタイン・デーです。	\N		\N	vmod	\N	\N	\N	0	1
680	There are few students in that classroom.	あの教室には少数の生徒しかいません。	\N		\N	vmod	\N	\N	\N	0	1
681	Is there film in this camera?	このカメラにはフィルムが入っていますか？	\N		\N	vmod	\N	\N	\N	0	1
682	The weather is fine today.	今日は天気が良いですね。	\N		\N	vmod	\N	\N	\N	0	1
683	This fish tastes best with a little lemmon juice drizzled over it.	この魚はレモン汁を少しかけると一番おいしく食べられます。	\N		\N	vmod	\N	\N	\N	0	1
684	Which floor is the shoe department on?	靴売り場は何階ですか？	\N		\N	vmod	\N	\N	\N	0	1
685	My foot goes to sleep soon after I sit on my heels.	正座をするとすぐに足がしびれます。	\N		\N	vmod	\N	\N	\N	0	1
686	I'd like to live in a foreign country in the near future.	私は近い将来外国に住めたらいいなと思います。	\N		\N	vmod	\N	\N	\N	0	1
687	There are many foreign students at this university.	この大学には多くの留学生がいます。	\N		\N	vmod	\N	\N	\N	0	1
688	He was mistaken for a foreigner.	彼は外国人と間違われた。	\N		\N	vmod	\N	\N	\N	0	1
689	Could you bring me another fork?	もう1本フォークを持ってきてくれませんか？	\N		\N	vmod	\N	\N	\N	0	1
690	My mother gave me her favorite fountain pen.	私の母が自分のお気に入りの万年筆を私にくれました。	\N		\N	vmod	\N	\N	\N	0	1
691	Our business hours are from 9 am to 3 pm, Monday through Friday.	営業時間は月曜日から金曜日までの午前9時から午後3時までです。	\N		\N	vmod	\N	\N	\N	0	1
692	Please put this meat in  the fridge.	この肉を冷蔵庫の中に入れてください。	\N		\N	vmod	\N	\N	\N	0	1
693	After the accident, he was rushed to the hospital.	事故のあと、彼は病院にかつぎこまれた。	\N		\N	vmod	\N	\N	\N	0	1
694	What kind of fruit do you like the best?	どの果物がいちばん好きですか？	\N		\N	vmod	\N	\N	\N	0	1
695	In spring there are many beautiful flowers in this garden.	春にはこの庭にたくさんの花が咲きます。	\N		\N	vmod	\N	\N	\N	0	1
696	The mailbox is outside the white gate.	郵便受けはその白い門の外にあります。	\N		\N	vmod	\N	\N	\N	0	1
697	It will get cloudy tomorrow.	明日は曇るでしょう。	\N		\N	vmod	\N	\N	\N	0	1
698	Please get off the train at Tama Station.	多磨駅で降りてください。	\N		\N	vmod	\N	\N	\N	0	1
699	Which bus should I get on to go to the university?	その大学に行くにはどのバスに乗ればよいですか？	\N		\N	vmod	\N	\N	\N	0	1
700	What time do you get up in the morning?	あなたは朝何時に起きますか？	\N		\N	vmod	\N	\N	\N	0	1
701	The girl likes performing music.	その女の子は音楽を演奏するのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
702	Who broke this glass?	このコップを割ったのは誰ですか？	\N		\N	vmod	\N	\N	\N	0	1
703	After I finish dinner I will go out for a walk.	夕食を食べ終えた後で、散歩に出かけるつもりです。	\N		\N	vmod	\N	\N	\N	0	1
704	Let's go shopping next Sunday.	次の日曜日に買い物に行こう。	\N		\N	vmod	\N	\N	\N	0	1
705	Why don't you leave your jacket in the hall?	上着を玄関に置いたらどうですか？	\N		\N	vmod	\N	\N	\N	0	1
706	Could you hand me that book, please?	その本を私に手渡してくれませんか？	\N		\N	vmod	\N	\N	\N	0	1
707	Let's clap our hands now!	さあ拍手をしましょう！	\N		\N	vmod	\N	\N	\N	0	1
708	My father is hanging the washing on the clothesline.	私の父は洗濯物を物干し網にかけています。	\N		\N	vmod	\N	\N	\N	0	1
709	I hope you will be happy in your new job.	新しい仕事が気に入るといいですね。	\N		\N	vmod	\N	\N	\N	0	1
710	Please watch your head.	頭に気をつけて下さい。	\N		\N	vmod	\N	\N	\N	0	1
711	This box is so heavy I can't pick it up.	この箱はとても重いので持ち上げることができません。	\N		\N	vmod	\N	\N	\N	0	1
712	What is the height of this building?	この建物の高さはどのくらいですか？	\N		\N	vmod	\N	\N	\N	0	1
713	There are four character sets in Japanese: Hiragana, Katakana, Kanji and Romaji.	日本語には4つの文字体系があります。それらは、平仮名、片仮名、漢字、ローマ字です。	\N		\N	vmod	\N	\N	\N	0	1
714	The idea that a woman should always stay home is now old-fashioned.	女性はいつも家庭にいるべきだという考えは今や時代遅れだ。	\N		\N	vmod	\N	\N	\N	0	1
715	Did you do your English homework?	英語の宿題やった?	\N		\N	vmod	\N	\N	\N	0	1
716	This food is really hot.	この食べ物は本当に辛い。	\N		\N	vmod	\N	\N	\N	0	1
717	Next week I will stay at the Covent Garden Hotel in London.	私は来週ロンドンのコヴェントガーデンホテルに泊まります。	\N		\N	vmod	\N	\N	\N	0	1
718	Oh, my tooth hurts!	ああ、歯が痛い！	\N		\N	vmod	\N	\N	\N	0	1
719	Her husband is on a business trip until September.	彼女の夫は9月まで出張しています。	\N		\N	vmod	\N	\N	\N	0	1
720	January is the first month of the year.	1月は1年の初めの月です。	\N		\N	vmod	\N	\N	\N	0	1
721	He jumped over a wall.	彼は壁を跳び越えた。	\N		\N	vmod	\N	\N	\N	0	1
722	It is said in the West that you can be happy if you get married in June.	西洋では6月に結婚すると幸せになれると言われている。	\N		\N	vmod	\N	\N	\N	0	1
723	I've just finished my lunch.	ちょうど昼御飯を食べ終わったところです。	\N		\N	vmod	\N	\N	\N	0	1
724	The official language of Jamaica is English.	ジャマイカの公用語は英語です。	\N		\N	vmod	\N	\N	\N	0	1
725	Many people enjoyed the party last week.	先週は多くの人がそのパーティーを楽しみました。	\N		\N	vmod	\N	\N	\N	0	1
726	My wife gave birth to our daughter last year.	妻は去年女の子を出産しました。	\N		\N	vmod	\N	\N	\N	0	1
727	Turn left at that corner.	あの角を左に曲がってください。	\N		\N	vmod	\N	\N	\N	0	1
728	Bend your leg back and grab your ankle.	脚を後ろに曲げて、足首をつかみなさい。	\N		\N	vmod	\N	\N	\N	0	1
729	First, please draw a vertical line.	まず、縦の線を引いてください。	\N		\N	vmod	\N	\N	\N	0	1
730	This umbrella is as light as air.	この傘は空気のように軽い。	\N		\N	vmod	\N	\N	\N	0	1
731	The moon is very bright tonight.	今夜の月はとても明るい。	\N		\N	vmod	\N	\N	\N	0	1
732	The sky over Cape Sounion became light purple at dusk.	スニオン岬の空は夕暮れ時に淡い紫色になった。	\N		\N	vmod	\N	\N	\N	0	1
733	An elephant has a long trunk.	象は鼻が長い。	\N		\N	vmod	\N	\N	\N	0	1
734	This house has a low ceiling.	この家の天井は低い。	\N		\N	vmod	\N	\N	\N	0	1
735	I subscribe to several monthly magazines.	私はいくつかの月刊誌を定期購読しています。	\N		\N	vmod	\N	\N	\N	0	1
736	In Japan, graduation ceremonies are held in March.	日本では卒業式は3月に行われます。	\N		\N	vmod	\N	\N	\N	0	1
737	We have a long holiday season at the beginning of May.	5月の初めには長い休みの日があります。	\N		\N	vmod	\N	\N	\N	0	1
738	Can you please explain the meaning of this word?	この単語の意味を説明してもらえませんか。	\N		\N	vmod	\N	\N	\N	0	1
739	Be sure to take this medicine three times a day.	この薬を1日3回忘れずに飲みなさい。	\N		\N	vmod	\N	\N	\N	0	1
740	See you on Monday!	月曜日に会いましょう！	\N		\N	vmod	\N	\N	\N	0	1
741	Time is money.	時は金なり。	\N		\N	vmod	\N	\N	\N	0	1
742	I haven't seen her for a month.	私は彼女とひとつき会っていない。	\N		\N	vmod	\N	\N	\N	0	1
743	My father reads the newspaper every morning.	私の父は毎朝新聞を読みます。	\N		\N	vmod	\N	\N	\N	0	1
744	The local music shop will have a sale next week.	近所の音楽店は来週セールをする。	\N		\N	vmod	\N	\N	\N	0	1
745	I'm going to become a police officer next year.	私は来年警官になります。	\N		\N	vmod	\N	\N	\N	0	1
746	There are no clouds in the sky today.	今日は空には雲ひとつありません。	\N		\N	vmod	\N	\N	\N	0	1
747	We will come back here before noon.	昼までにはここに戻ってきます。	\N		\N	vmod	\N	\N	\N	0	1
748	Chichijima is to the north of Hahajima.	父島は母島の北にあります。	\N		\N	vmod	\N	\N	\N	0	1
749	My nose is stuffed up.	私の鼻はつまっています。	\N		\N	vmod	\N	\N	\N	0	1
750	I wrote my name on my notebook.	私は自分のノートに名前を書きました。	\N		\N	vmod	\N	\N	\N	0	1
751	November's birth flower is the chrysanthemum.	11月の誕生花は菊です。	\N		\N	vmod	\N	\N	\N	0	1
752	We always have a Halloween party on October 31st.	10月31日にはいつもハロウィーン・パーティーをします。	\N		\N	vmod	\N	\N	\N	0	1
753	Excuse me, officer, could you tell me the way to the station?	すみません、お巡りさん、駅までの道を教えてくれますか？	\N		\N	vmod	\N	\N	\N	0	1
754	Can you fix my old radio-cassette player?	私の古いラジカセを修理してくれますか	\N		\N	vmod	\N	\N	\N	0	1
755	That old woman has thick glasses.	その年老いた女性は分厚い眼鏡をかけています。	\N		\N	vmod	\N	\N	\N	0	1
756	I turned the key in the door and slowly entered the room.	ドアに鍵を差し込んで回し、ゆっくりと中に入った。	\N		\N	vmod	\N	\N	\N	0	1
757	The hospital is near the station.	病院は駅から近い。	\N		\N	vmod	\N	\N	\N	0	1
758	They often sing in the university choir.	彼らはしばしば大学の聖歌隊で歌います。	\N		\N	vmod	\N	\N	\N	0	1
759	Put on your pants and socks right now!	早くズボンと靴下をはきなさい。	\N		\N	vmod	\N	\N	\N	0	1
760	We went out for supper at an Italian restaurant.	私たちはイタリア料理店に夕食に出かけた。	\N		\N	vmod	\N	\N	\N	0	1
761	You're the only person in this class who can speak German.	あなたはこのクラスでドイツ語が話せる唯一の人です。	\N		\N	vmod	\N	\N	\N	0	1
762	You're wanted on the phone.	あなたに電話ですよ。	\N		\N	vmod	\N	\N	\N	0	1
763	I don't like traveling by plane because I'm afraid of heights.	私は高い所が怖いので、飛行機で旅行するのは好きではありません。	\N		\N	vmod	\N	\N	\N	0	1
764	There's a big hole in my pocket.	ポケットに大きい穴が開いています。	\N		\N	vmod	\N	\N	\N	0	1
765	There are no police boxes around this station.	この駅の周りには交番がありません。	\N		\N	vmod	\N	\N	\N	0	1
766	I am jealous of him for having such a big pool in his yard.	庭にそんなに大きなプールがあるなんて、彼がうらやましいよ。	\N		\N	vmod	\N	\N	\N	0	1
767	I'm a poor cook.	私は料理が下手です。	\N		\N	vmod	\N	\N	\N	0	1
768	Pork contains ten times as much vitamin B1 as beef.	豚肉は牛肉の１０倍のビタミンB１を含む。	\N		\N	vmod	\N	\N	\N	0	1
769	Please stick a fifty-yen stamp on this postcard.	このはがきに５０円切手を１枚貼ってください。	\N		\N	vmod	\N	\N	\N	0	1
771	Is there a problem?	何か問題がありますか？	\N		\N	vmod	\N	\N	\N	0	1
772	Push this button to turn on the computer.	このコンピュータのスイッチを入れるためには、このボタンを押してください。	\N		\N	vmod	\N	\N	\N	0	1
773	Attach name tags to all of your baggage.	全ての荷物に名札をつけて下さい。	\N		\N	vmod	\N	\N	\N	0	1
774	You should put on this uniform.	この制服を着なければなりません。	\N		\N	vmod	\N	\N	\N	0	1
775	Put on your hat to avoid sunstroke.	日射病にならないように帽子をかぶりなさい。	\N		\N	vmod	\N	\N	\N	0	1
776	I heard my favorite song on the radio this morning.	今朝、私のお気に入りの歌がラジオから流れてくるのを聞いた。	\N		\N	vmod	\N	\N	\N	0	1
777	Acid rain is one of the most serious environmental problems.	酸性雨は最も深刻な環境問題の１つだ。	\N		\N	vmod	\N	\N	\N	0	1
778	Her father likes collecting jazz records.	彼女の父はジャズのレコードを集めるのが好きです。	\N		\N	vmod	\N	\N	\N	0	1
779	Shall we take a short rest?	短い休憩を取りましょうか。	\N		\N	vmod	\N	\N	\N	0	1
780	Can you tell me where the restroom is?	お手洗いがどこにあるのか教えて下さい。	\N		\N	vmod	\N	\N	\N	0	1
781	Please return the book by Wednesday.	水曜日までにその本を返してください。	\N		\N	vmod	\N	\N	\N	0	1
782	I cooked the rice in a pot because my rice cooker was broken.	炊飯器が壊れたので釜で御飯を炊きました。	\N		\N	vmod	\N	\N	\N	0	1
783	Pour some hot water into this teacup.	この茶わんにお湯を少し注いで下さい。	\N		\N	vmod	\N	\N	\N	0	1
784	Go down this street.  You'll find a vegetable shop on your right.	この道をまっすぐ行ってください。そうすれば、右側に八百屋があります。	\N		\N	vmod	\N	\N	\N	0	1
785	You can't swim in this river.	この川では泳げません。	\N		\N	vmod	\N	\N	\N	0	1
786	This road is closed to traffic during winter because of heavy snow..	この道路は冬には大雪のため通行止めになります。	\N		\N	vmod	\N	\N	\N	0	1
787	Add some salt and pepper.	塩コショウをしてください。	\N		\N	vmod	\N	\N	\N	0	1
788	Take off that dirty shirt now.	すぐにその汚れたシャツを脱ぎなさい。	\N		\N	vmod	\N	\N	\N	0	1
789	Take this dress shirt to the cleaners, please.	このワイシャツをクリーニング店に出してください。	\N		\N	vmod	\N	\N	\N	0	1
790	Wearing a short skirt is becoming popular among young women.	短いスカートをはくのが若い女性たちの間で流行り出している。	\N		\N	vmod	\N	\N	\N	0	1
791	You're dripping with sweat.  You should take a shower.	汗がしたたっていますね。シャワーを浴びなさい。	\N		\N	vmod	\N	\N	\N	0	1
792	The side door is closed on Sunday.	日曜日にはその横の入り口は閉められています。	\N		\N	vmod	\N	\N	\N	0	1
793	You should take off your slippers here.	ここではスリッパを脱いでください。	\N		\N	vmod	\N	\N	\N	0	1
794	She is walking slowly because she hurt her leg.	彼女は足をけがしたので、ゆっくりと歩いている。	\N		\N	vmod	\N	\N	\N	0	1
795	May I smoke in this room?	この部屋でタバコを吸ってもいいですか？	\N		\N	vmod	\N	\N	\N	0	1
796	Put on your pants and socks right now!	早くズボンと靴下をはきなさい！	\N		\N	vmod	\N	\N	\N	0	1
797	Someone spilled soy sauce on my shirt yesterday.	昨日誰かが私のシャツに醤油をこぼした。	\N		\N	vmod	\N	\N	\N	0	1
798	I sometimes work late at night.	私は時々夜遅くまで仕事をします。	\N		\N	vmod	\N	\N	\N	0	1
799	We will soon be arriving at Tama Station.	もうすぐ多磨駅に到着します。	\N		\N	vmod	\N	\N	\N	0	1
800	Wakayama Prefecture is located in the south of Honshu.	和歌山県は本州の南に位置しています。	\N		\N	vmod	\N	\N	\N	0	1
801	I'm going to have a talk with the president the day after tomorrow.		\N		\N	vmod	\N	\N	\N	0	1
802	You need to use a spoon to eat this.	これを食べるにはスプーンを使う必要があります。	\N		\N	vmod	\N	\N	\N	0	1
803	Do you do any sports regularly?	何か定期的にしているスポーツはありますか？	\N		\N	vmod	\N	\N	\N	0	1
804	The stairs are so steep that I can't climb them easily.	この階段はあまりに急なので簡単には上れません。	\N		\N	vmod	\N	\N	\N	0	1
805	We asked a police officer the way to the museum.	私たちは警官にその博物館にどうやって行ったらいいかを尋ねました。	\N		\N	vmod	\N	\N	\N	0	1
806	I wish I had a firm stomach.	お腹が引き締まっていればなあ。	\N		\N	vmod	\N	\N	\N	0	1
807	It's very warm outside.  Why don't you turn off the heater?	外はとても暖かいですよ。ストーブを消したらどうですか？	\N		\N	vmod	\N	\N	\N	0	1
808	Students can buy the tickets at half price.	学生は半額でそのチケットを買うことができます。	\N		\N	vmod	\N	\N	\N	0	1
809	She began the study of Italian two years ago.	彼女は２年前にイタリア語の勉強を始めました。	\N		\N	vmod	\N	\N	\N	0	1
810	I had to go to the office by taxi this morning because subway service was suspended.	地下鉄が不通になったので、今朝は事務所にタクシーで行かなければならなかった。	\N		\N	vmod	\N	\N	\N	0	1
811	I prefer sweet wine to dry wine.	私は辛口のワインよりも甘口のワインの方が好きです。	\N		\N	vmod	\N	\N	\N	0	1
812	My mother knitted this sweater.	私の母がこのセーターを編みました。	\N		\N	vmod	\N	\N	\N	0	1
813	I bought a black suit last Thursday.	私は先週の木曜日に黒い背広を買いました。	\N		\N	vmod	\N	\N	\N	0	1
814	I take a bath every evening before going to bed.	私は毎晩寝る前にお風呂に入ります。	\N		\N	vmod	\N	\N	\N	0	1
815	Do not use a camera, video camera or tape recorder during the concert.	コンサート中は、カメラ、ビデオカメラ、テープレコーダーの使用はやめてください。	\N		\N	vmod	\N	\N	\N	0	1
816	Applicants are required to take the entrance exam administered this week.	志願者は今週行われる入学テストを受けなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
817	Ｉ'm going to have a talk with the president the day after tomorrow.	私はあさって社長と話をすることになっています。	\N		\N	vmod	\N	\N	\N	0	1
818	I enjoyed my travels through Europe on a train the year before last.	私はおととしヨーロッパを鉄道で旅行して楽しみました。	\N		\N	vmod	\N	\N	\N	0	1
819	May I ask who's calling?	（電話で）どなたですか？	\N		\N	vmod	\N	\N	\N	0	1
820	She is as tall and thin as a model.	彼女はファッションモデルのように背が高くてほっそりとしている。	\N		\N	vmod	\N	\N	\N	0	1
821	My glasses have very thin lenses.	私の眼鏡のレンズはとても薄いです。	\N		\N	vmod	\N	\N	\N	0	1
822	What is your New Year's Resolution this year?	今年のあなたの新年の抱負は何ですか？	\N		\N	vmod	\N	\N	\N	0	1
823	Where is the ticket office for the Seibu Line?	西武線の切符売り場はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
824	I was looking up at the sky when a UFO appeared..	空を見上げていると、UFOが現れた。	\N		\N	vmod	\N	\N	\N	0	1
825	We grow a lot of fresh vegetables in our garden.	私たちは庭でたくさんの新鮮な野菜を育てています。	\N		\N	vmod	\N	\N	\N	0	1
826	Please sing in a loud voice.	大きな声で歌ってください。	\N		\N	vmod	\N	\N	\N	0	1
827	Your wallet looks very heavy.	あなたの財布はとても重そうですね。	\N		\N	vmod	\N	\N	\N	0	1
828	My favorite sweat shirt has shrunk in the wash.	私のお気に入りのトレーナーが洗濯中に縮んでしまった。	\N		\N	vmod	\N	\N	\N	0	1
829	I am really weak at chemistry and physics.	私は化学と物理が本当に弱いんです。	\N		\N	vmod	\N	\N	\N	0	1
830	She always wears a T-shirt in summer.	彼女は夏はいつもＴシャツを着ている。	\N		\N	vmod	\N	\N	\N	0	1
831	The bank is on the west side of the station.	銀行は駅の西側にあります。	\N		\N	vmod	\N	\N	\N	0	1
832	I wonder when he will call me.	彼はいつ私に電話をかけてくるつもりだろう。	\N		\N	vmod	\N	\N	\N	0	1
838	There is a flush toilet in this car.	この車両には水洗トイレが１つあります。	\N		\N	vmod	\N	\N	\N	0	1
839	The park is so large that I can't find where I am without a map.	その公園はあまりにも広いので、地図なしでは自分がどこにいるのか分かりません。	\N		\N	vmod	\N	\N	\N	0	1
840	Be quiet!  The baby is sleeping in the next room.	静かにしなさい！　赤ん坊が隣の部屋で寝ています。	\N		\N	vmod	\N	\N	\N	0	1
841	Open your mouth.	口を開けて。	\N		\N	vmod	\N	\N	\N	0	1
843	I hope you can leave hospital by the end of this month.	今月末までに退院できるといいですね。	\N		\N	vmod	\N	\N	\N	0	1
844	I have two morning classes this semester.	今学期は午前中の授業が２つあります。	\N		\N	vmod	\N	\N	\N	0	1
845	Go straight until you get to a railroad crossing.	踏み切りに着くまでまっすぐ行きなさい。	\N		\N	vmod	\N	\N	\N	0	1
846	This xylophone looks very old.	この木琴はとても古そうだ。	\N		\N	vmod	\N	\N	\N	0	1
847	These shirts need washing.	これらのシャツは洗濯しないといけない。	\N		\N	vmod	\N	\N	\N	0	1
848	This book has a lot of cleaning tips.	この本には掃除のコツがいろいろと書いてある。	\N		\N	vmod	\N	\N	\N	0	1
849	There were no seats on the train so I had to stand.	車内に空席はなかったので、立っていないといけませんでした。	\N		\N	vmod	\N	\N	\N	0	1
850	There was a big park with a pond not far from the restaurant.	そのレストランから遠くないところに池のある大きな公園がありました。	\N		\N	vmod	\N	\N	\N	0	1
851	Take off your jacket and make yourself at home.	どうぞ上着を脱いで楽にしてください。	\N		\N	vmod	\N	\N	\N	0	1
852	I took a dictionary from the bookshelf.	本棚から辞書を１冊取りました。	\N		\N	vmod	\N	\N	\N	0	1
853	The Olympic Games will be held in Beijing the year after next.	再来年オリンピックは北京で開かれます。	\N		\N	vmod	\N	\N	\N	0	1
854	He has a short, thick neck.	彼の首は太くて短い。	\N		\N	vmod	\N	\N	\N	0	1
855	I enjoyed my travels by train through Europe last year.	私は去年ヨーロッパを鉄道で旅行して楽しみました。	\N		\N	vmod	\N	\N	\N	0	1
856	I bought a red tie yesterday.	昨日、赤いネクタイを買いました。	\N		\N	vmod	\N	\N	\N	0	1
857	I saw a good movie the day before yesterday.	私はおととい良い映画を観ました。	\N		\N	vmod	\N	\N	\N	0	1
858	You must not drink alcohol before driving.	車を運転する前に酒を飲んではいけません。	\N		\N	vmod	\N	\N	\N	0	1
859	I went to the post office to buy some stamps.	私は郵便局に切手を買いに行った。	\N		\N	vmod	\N	\N	\N	0	1
860	There are many old temples in Kyoto.	京都にはたくさんの古いお寺があります。	\N		\N	vmod	\N	\N	\N	0	1
861	Your wife is a wonderful cook.	あなたの奥さんはとても料理がうまいですね。	\N		\N	vmod	\N	\N	\N	0	1
862	I usually carry a handkerchief.	私はたいていハンカチを持ち歩いています。	\N		\N	vmod	\N	\N	\N	0	1
863	I will have a vacation next month.	私は来月休暇をとります。	\N		\N	vmod	\N	\N	\N	0	1
864	A strong wind blew the rain against the window.	強風で雨が窓にたたきつけた。	\N		\N	vmod	\N	\N	\N	0	1
865	Everyone at the party had a good time.	そのパーティーにいた人たちは、みんな楽しい時を過ごしました。	\N		\N	vmod	\N	\N	\N	0	1
866	Why don't you put on a coat on a cold winter day like this?	こんな冬の寒い日にはコートを着たらどうですか。	\N		\N	vmod	\N	\N	\N	0	1
867	The library is in front of the hospital.	図書館はその病院の前にあります。	\N		\N	vmod	\N	\N	\N	0	1
868	The library is in front of the hospital.	図書館はその病院の前にあります。	\N		\N	vmod	\N	\N	\N	0	1
869	I like having a cold drink on hot summer days.	夏の暑い日に冷たい飲み物を飲むのはいいですね。	\N		\N	vmod	\N	\N	\N	0	1
870	I haven't taken a bath yet.	まだ風呂に入っていません。	\N		\N	vmod	\N	\N	\N	0	1
871	I bought a black tie yesterday.	昨日黒いネクタイを買いました。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: en
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	732	行く	1	1
2	733	英語	1	1
3	734	飛行機	1	1
4	735	外国	1	1
5	736	外国人	1	1
6	737	フランス語	1	1
7	738	ホテル	1	1
8	739	日本語	1	1
9	740	出掛ける	1	1
10	741	国（くに）	1	1
11	742	会う	1	1
12	743	休み	1	1
13	744	旅行	1	1
14	745	旅行する	1	1
15	746	遊ぶ	1	1
16	747	大使館	1	1
17	748	大好き	1	1
18	749	好き	1	1
19	750	上手（じょうず）	1	1
20	751	走る	1	1
21	752	ゆっくり	1	1
22	753	下手（へた）	1	1
23	754	歩く	1	1
24	755	泳ぐ	1	1
25	756	速い［スピードが～］	1	1
26	757	飛ぶ	1	1
27	758	スポーツ	1	1
28	759	嫌い	1	1
29	760	プール	1	1
30	761	バス	1	1
31	762	自転車	1	1
32	763	交差点	1	1
33	764	道（みち）	1	1
34	765	池	1	1
35	766	散歩	1	1
36	767	かわ（川・河）	1	1
37	768	タクシー	1	1
38	769	自動車，車（くるま）	1	1
39	770	曲がる	1	1
40	771	ネクタイ	1	1
41	772	ワイシャツ	1	1
42	773	会社	1	1
43	774	背広	1	1
44	775	やる	1	1
45	776	吸う	1	1
46	777	電話	1	1
47	778	仕事	1	1
48	779	働く・勤める	1	1
49	780	忙しい	1	1
50	781	図書館	1	1
51	782	辞書，字引	1	1
52	783	借りる	1	1
53	784	新聞	1	1
54	785	読む	1	1
55	786	本	1	1
56	787	コピー	1	1
57	788	コピーする	1	1
58	789	雑誌	1	1
59	790	冊	1	0
60	791	牛肉	1	1
61	792	安い	1	1
62	793	店	1	1
63	794	高い	1	1
64	795	いくつ	1	1
65	796	いくら	1	1
66	797	果物	1	1
67	798	野菜	1	1
68	799	魚	1	1
69	800	豚肉	1	1
70	801	鳥肉	1	1
71	802	肉	1	1
72	803	欲しい	1	1
73	804	渡す	1	1
74	805	八百屋	1	1
75	806	かぎ（鍵）	1	1
76	807	料理	1	1
77	808	買い物する	1	1
78	809	洗濯する	1	1
79	810	掃除する	1	1
80	811	家族	1	1
81	812	家庭	1	1
82	813	庭（にわ）	1	1
83	814	洗濯	1	1
84	815	うち（家）	1	1
85	816	家（いえ）	1	1
86	817	掃除	1	1
87	818	かえる（帰・返）	1	1
88	819	本棚	1	1
89	820	机	1	1
90	821	椅子（いす）	1	1
91	822	部屋	1	1
92	823	冷蔵庫	1	1
93	824	洗う	1	1
94	825	ベッド	1	1
95	826	ラジオ	1	1
96	827	ラジカセ	1	1
97	828	～という名前です	1	1
98	829	寝る	1	1
99	830	起きる	1	1
100	831	テーブル	1	1
101	832	テレビ	1	1
102	833	お巡りさん	1	1
103	834	警官	1	1
104	835	地図	1	1
105	836	そば	1	1
106	837	ここ,こちら, こっち	1	1
107	838	そこ,そちら, そっち	1	1
108	839	あちら, あっち，あそこ	1	1
109	840	どこ,どちら,どっち	1	1
110	841	交番	1	1
111	842	近く	1	1
112	843	隣	1	1
113	844	きく	1	1
114	845	切る	1	1
115	846	短い	1	1
116	847	後ろ	1	1
117	848	前	1	1
118	849	右	1	1
119	850	左	1	1
120	851	長い	1	1
121	852	座る	1	1
122	853	立つ	1	1
123	854	友達	1	1
124	855	クラス	1	1
125	856	教室	1	1
126	857	廊下	1	1
127	858	学校	1	1
128	859	生徒	1	1
129	860	勉強	1	1
130	861	学生	1	1
131	862	留学生	1	1
132	863	夏休み	1	1
133	864	先生	1	1
134	865	大学	1	1
135	866	ノート	1	1
136	867	授業	1	1
137	868	作文	1	1
138	869	宿題	1	1
139	870	難しい	1	1
140	871	教える	1	1
141	872	テスト	1	1
142	873	練習	1	1
143	874	易しい	1	1
144	875	練習する	1	1
145	876	質問	1	1
146	877	問題	1	1
147	878	答える	1	1
148	879	痛い	1	1
149	880	歯	1	1
150	881	医者	1	1
151	882	病院	1	1
152	883	病気	1	1
153	884	薬（くすり）	1	1
154	885	死ぬ	1	1
155	886	風邪（かぜ）	1	1
156	887	頭（あたま）	1	1
157	888	お腹	1	1
158	889	度（ど）	1	1
159	890	エレベーター	1	1
160	891	切符	1	1
161	892	おりる	1	1
162	893	階段	1	1
163	894	閉める	1	1
164	895	駅	1	1
165	896	地下鉄	1	1
166	897	乗る	1	1
167	898	開ける	1	1
168	899	お手洗い	1	1
169	900	トイレ	1	1
170	901	電車	1	1
171	902	飲み物	1	1
172	903	コーヒー	1	1
173	904	喫茶店；（ホテルなどの）軽食堂	1	1
174	905	レモン	1	1
175	906	牛乳	1	1
176	907	砂糖	1	1
177	908	カップ	1	1
178	909	お茶	1	1
179	910	紅茶	1	1
180	911	コップ	1	1
181	912	入れる	1	1
182	913	甘い	1	1
183	914	飲む	1	1
184	915	はし	1	1
185	916	酒	1	1
186	917	おいしい	1	1
187	918	ナイフ	1	1
188	919	スプーン	1	1
189	920	フォーク	1	1
190	921	チーズ	1	1
191	922	食べる	1	1
192	923	まずい	1	1
193	924	パン	1	1
194	925	辛い	1	1
195	926	レストラン	1	1
196	927	食堂	1	1
197	928	酒・ワイン	1	1
198	929	食べ物	1	1
199	930	カレー	1	1
200	931	お金	1	1
201	932	銀行	1	1
202	933	入り口	1	1
203	934	どうぞ,どういたしまして	1	\N
204	935	いいえ	1	1
205	936	ええ	1	1
206	937	すみません	1	1
207	938	どうぞ	1	1
208	939	出口	1	1
209	940	着く	1	1
210	941	ポスト	1	1
211	942	はがき	1	1
212	943	張る	1	1
213	944	封筒	1	1
214	945	手紙	1	1
215	946	郵便局	1	1
216	947	返す	1	1
217	948	出す	1	1
218	949	切手	1	1
219	950	荷物	1	1
220	951	枚	1	\N
221	952	貸す	1	1
222	953	買う	1	1
223	954	帽子	1	1
224	955	靴	1	1
225	956	買い物	1	1
226	957	階	1	1
227	958	デパート	1	1
228	959	スカート	1	1
229	960	コート	1	1
230	961	ズボン	1	1
231	962	セーター	1	1
232	963	…てください	1	1
233	964	かばん	1	1
234	965	売る	1	1
235	966	上着	1	1
236	967	ふろ	1	1
237	968	建物	1	1
238	969	台所	1	1
239	970	シャワー	1	1
240	971	窓	1	1
241	972	住む	1	1
242	973	公園	1	1
243	974	ドア	1	1
244	975	浴びる［一風呂～］	1	1
245	976	アパート	1	1
246	977	玄関	1	1
247	978	彼，彼女	1	\N
248	979	彼ら，彼女たち	1	1
249	980	私（わたし）	1	1
250	981	私たち	1	1
251	982	だれか	1	1
252	983	だれ	1	1
253	984	どなた	1	1
254	985	きみ	1	1
255	986	あなた	1	1
256	987	この	1	1
257	988	その，あの	1	1
258	989	いかが，どう	1	1
259	990	どの	1	1
260	991	どんな	1	1
261	992	こんな	1	1
262	993	自分	1	1
263	994	そう	1	1
264	995	厚い	1	1
265	996	狭い	1	1
266	997	細い	1	1
267	998	大きい	1	1
268	999	太い	1	1
269	1000	若い	1	1
270	1001	広い	1	1
271	1002	軽い	1	1
272	1003	遠い	1	1
273	1004	重い	1	1
274	1005	薄い	1	1
275	1006	新しい	1	1
276	1007	小さい	1	1
277	1008	近い	1	1
278	1009	古い	1	1
279	1010	楽しい	1	1
280	1011	にぎやか	1	1
281	1012	低い	1	1
282	1013	よい	1	1
283	1014	明るい	1	1
284	1015	弱い	1	1
285	1016	強い	1	1
286	1017	おもしろい	1	1
287	1018	きれい	1	1
288	1019	遅い	1	1
289	1020	悪い	1	1
290	1021	多い	1	1
291	1022	暗い	1	1
292	1023	静か	1	1
293	1024	少ない	1	1
294	1025	汚い	1	1
295	1026	つまらない	1	1
296	1027	横	1	1
297	1028	中（なか）	1	1
298	1029	外（そと）	1	1
299	1030	東（ひがし）	1	1
300	1031	高さ	1	1
301	1032	縦	1	1
302	1033	北（きた）	1	1
303	1034	西（にし）	1	1
304	1035	下（した）	1	1
305	1036	南（みなみ）	1	1
306	1037	上（うえ）	1	1
307	1038	先（さき）	1	1
308	1039	後（あと）	1	1
309	1040	いとこ	1	1
310	1041	兄	1	1
311	1042	兄弟（きょうだい）	1	1
312	1043	おばあさん	1	1
313	1044	おじいさん	1	1
314	1045	奥さん	1	1
315	1046	母	1	1
316	1047	叔父，伯父	1	1
317	1048	両親	1	1
318	1049	父	1	1
319	1050	姉	1	1
320	1051	姉妹	1	1
321	1052	叔母，伯母	1	1
322	1053	お兄さん	1	1
323	1054	お姉さん	1	1
324	1055	お父さん	1	1
325	1056	お母さん	1	1
326	1057	靴下	1	1
327	1058	シャツ	1	1
328	1059	脱ぐ	1	1
329	1060	架ける	1	1
330	1061	は（穿）く［ズボンを～］	1	1
331	1062	着る	1	1
332	1063	かぶる	1	1
333	1064	ハンカチ	1	1
334	1065	スリッパ	1	1
335	1066	傘	1	1
336	1067	ポケット	1	1
337	1068	財布	1	1
338	1069	着ている	1	1
339	1070	服	1	1
340	1071	洋服	1	1
341	1072	口	1	1
342	1073	腕（うで）	1	1
343	1074	体（からだ）	1	1
344	1075	顔	1	1
345	1076	脚（あし）	1	1
346	1077	手（て）	1	1
347	1078	鼻	1	1
348	1079	目（め）	1	1
349	1080	耳	1	1
350	1081	足（あし）	1	1
351	1082	おなか	1	1
352	1083	皿（さら）	1	1
353	1084	バター	1	1
354	1085	茶わん	1	1
355	1086	あめ	1	1
356	1087	昼御飯	1	1
357	1088	夕飯（ゆうはん）	1	1
358	1089	お菓子	1	1
359	1090	卵	1	1
360	1091	朝御飯	1	1
361	1092	御飯（ごはん）	1	1
362	1093	醤油	1	1
363	1094	塩（しお）	1	1
364	1095	晩御飯	1	1
365	1096	くわえる	1	1
366	1097	つける	1	1
367	1098	カメラ	1	1
368	1099	ストーブ	1	1
369	1100	鉛筆	1	1
370	1101	消す	1	1
371	1102	眼鏡（めがね）	1	1
372	1103	テープレコーダー	1	1
373	1104	時計	1	1
374	1105	コンピュータ	1	1
375	1106	フィルム	1	1
376	1107	戸（と）	1	1
377	1108	門（もん）	1	1
378	1109	ペン	1	1
379	1110	万年筆	1	1
380	1111	ボールペン	1	1
381	1112	八月	1	1
382	1113	四月	1	1
383	1114	今月	1	1
384	1115	毎月（まいつき）	1	1
385	1116	十二月	1	1
386	1117	二月	1	1
387	1118	一月	1	1
388	1119	七月	1	1
389	1120	六月	1	1
390	1121	来月	1	1
391	1122	五月	1	1
392	1123	三月	1	1
393	1124	先月	1	1
394	1125	十一月	1	1
395	1126	十月	1	1
396	1127	九月	1	1
397	1128	ひとつき	1	1
398	1129	今週	1	1
399	1130	毎週	1	1
400	1131	日曜日	1	1
401	1132	木曜日	1	1
402	1133	来週	1	1
403	1134	月曜日	1	1
404	1135	火曜日	1	1
405	1136	水曜日	1	1
406	1137	土曜日	1	1
407	1138	週間	1	1
408	1139	先週	1	1
409	1140	金曜日	1	1
410	1141	年（ねん）	1	1
411	1142	秋	1	1
412	1143	今年（ことし）	1	1
413	1144	毎年（まいとし）	1	1
414	1145	夏（なつ）	1	1
415	1146	冬	1	1
416	1147	去年	1	1
417	1148	来年	1	1
418	1149	春	1	1
419	1150	再来年	1	1
420	1151	おととし	1	1
421	1152	午後	1	1
422	1153	今日（きょう）	1	1
423	1154	明日（あした）	1	1
424	1155	時（じ）	1	1
425	1156	昨日（きのう）	1	1
426	1157	夕べ	1	1
427	1158	午前	1	1
428	1159	朝	1	1
429	1160	昼	1	1
430	1161	夜（よる）	1	1
431	1162	夕方	1	1
432	1163	あさって	1	1
433	1164	おととい	1	1
434	1165	もう	1	1
435	1166	ながら	1	1
436	1167	まだ	1	1
437	1168	中(ちゅう)	1	1
438	1169	時（とき）	1	1
439	1170	いつ	1	1
440	1171	ときどき	1	1
441	1172	しばしば	1	1
442	1173	時間	1	1
443	1174	すぐ	1	1
444	1175	灰皿	1	1
445	1176	歌（うた）	1	1
446	1177	歌う	1	1
447	1178	たばこ	1	1
448	1179	映画	1	1
449	1180	レコード	1	1
450	1181	ギター	1	1
451	1182	弾く	1	1
452	1183	音楽	1	1
453	1184	絵（え）	1	1
454	1185	写真	1	1
455	1186	好き，気に入る	1	1
456	1187	声	1	1
457	1188	晴れ	1	1
458	1189	暑い	1	1
459	1190	晴れる	1	1
460	1191	涼しい	1	1
461	1192	寒い	1	1
462	1193	雪（ゆき）	1	1
463	1194	雨が降る	1	1
464	1195	雨（あめ）	1	1
465	1196	天気	1	1
466	1197	あたたかい（暖・温）	1	1
467	1198	風（かぜ）	1	1
468	1199	曇り	1	1
469	1200	冷たい	1	1
470	1201	曇る	1	1
471	1202	漢字	1	1
472	1203	言う	1	1
473	1204	書く	1	1
474	1205	話（はなし）	1	1
475	1206	言葉	1	1
476	1207	～語	1	1
477	1208	語（ご）	1	1
478	1209	話す	1	1
479	1210	文章	1	1
480	1211	語る	1	1
481	1212	意味	1	1
482	1213	平仮名	1	1
483	1214	片仮名	1	1
484	1215	大人（おとな）	1	1
485	1216	大勢	1	1
486	1217	夫婦	1	1
487	1218	子供	1	1
488	1219	妻	1	1
489	1220	女（おんな）	1	1
490	1221	男の子	1	1
491	1222	人（ひと）	1	1
492	1223	男（おとこ）	1	1
493	1224	女の子	1	1
494	1225	夫	1	1
495	1226	人	1	1
496	1227	みんな	1	1
497	1228	白（しろ），白い	1	1
498	1229	青，青い	1	1
499	1230	茶色	1	1
500	1231	明るい，淡い	1	1
501	1232	色（いろ）	1	1
502	1233	濃い，暗い	1	1
503	1234	黄色（きいろ），黄色い	1	1
504	1235	黒（くろ），黒い	1	1
505	1236	赤，赤い	1	1
506	1237	緑	1	1
507	1238	便利	1	1
508	1239	パーティー	1	1
509	1240	紙	1	1
510	1241	～になる	1	1
511	1242	締める	1	1
512	1243	押す	1	1
513	1244	始まる	1	1
514	1245	ちょうど	1	1
515	1246	ない	1	1
516	1247	まっすぐ	1	1
517	1248	有名	1	1
518	1249	元気	1	1
519	1250	じゃあ	1	1
520	1251	多分	1	1
521	1252	では	1	1
522	1254	彼	1	1
523	1253	木琴	1	1
524	1255	彼女	1	1
525	1256		1	\N
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: en
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
522	15352	1.2	1.20	体	主体	人間	人間	人間	人間	にんげん
524	15352	1.2	1.20	体	主体	人間	人間	人間	人間	にんげん
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
523	54987	1.456	1.45	体	生産物	道具	楽器・レコードなど	楽器	楽器	がっき
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
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
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
512	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
329	69867	2.1513	2.15	用	関係	作用	固定・傾き・転倒など	架ける	架ける	かける
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
167	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
163	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
366	72782	2.1559999	2.15	用	関係	作用	接近・接触・隔離	付ける	付ける	つける
212	72816	2.1559999	2.15	用	関係	作用	接近・接触・隔離	張る	張る	はる
39	73436	2.1570001	2.15	用	関係	作用	成形・変形	曲がる	曲がる	まがる
114	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
365	73997	2.158	2.15	用	関係	作用	増減・補充	加える	加える	くわえる
513	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
525	76199	2.3020999	2.30	用	活動	心	敬意・感謝・信頼など	感謝する	感謝する	かんしゃする
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
514	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
515	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
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
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	308	172	0	\N	\N	\N	\N
2	307	424	0	\N	\N	\N	\N
3	434	369	0	\N	\N	\N	\N
4	382	570	0	\N	\N	\N	\N
5	113	524	0	\N	\N	\N	\N
6	321	525	0	\N	\N	\N	\N
7	289	324	0	\N	\N	\N	\N
8	201	310	0	\N	\N	\N	\N
9	510	556	0	\N	\N	\N	\N
10	94	509	0	\N	\N	\N	\N
11	513	543	0	\N	\N	\N	\N
12	498	196	0	\N	\N	\N	\N
13	55	425	0	\N	\N	\N	\N
14	295	311	0	\N	\N	\N	\N
15	52	425	0	\N	\N	\N	\N
16	310	308	0	\N	\N	\N	\N
17	322	308	0	\N	\N	\N	\N
18	237	487	0	\N	\N	\N	\N
19	49	517	0	\N	\N	\N	\N
20	184	442	0	\N	\N	\N	\N
21	124	49	0	\N	\N	\N	\N
22	136	543	0	\N	\N	\N	\N
23	339	346	0	\N	\N	\N	\N
24	468	325	0	\N	\N	\N	\N
25	374	345	0	\N	\N	\N	\N
26	309	525	0	\N	\N	\N	\N
27	324	150	0	\N	\N	\N	\N
28	89	540	0	\N	\N	\N	\N
29	139	257	0	\N	\N	\N	\N
30	357	435	0	\N	\N	\N	\N
31	364	435	0	\N	\N	\N	\N
32	352	494	0	\N	\N	\N	\N
33	143	471	0	\N	\N	\N	\N
35	191	446	0	\N	\N	\N	\N
36	359	295	0	\N	\N	\N	\N
37	2	283	0	\N	\N	\N	\N
38	63	255	0	\N	\N	\N	\N
39	348	270	0	\N	\N	\N	\N
40	411	531	0	\N	\N	\N	\N
41	80	104	0	\N	\N	\N	\N
42	272	155	0	\N	\N	\N	\N
43	25	342	0	\N	\N	\N	\N
44	318	156	0	\N	\N	\N	\N
45	518	307	0	\N	\N	\N	\N
46	198	271	0	\N	\N	\N	\N
47	6	220	0	\N	\N	\N	\N
48	123	7	0	\N	\N	\N	\N
49	1	98	0	\N	\N	\N	\N
50	98	176	0	\N	\N	\N	\N
51	19	208	0	\N	\N	\N	\N
52	282	207	0	\N	\N	\N	\N
53	506	198	0	\N	\N	\N	\N
54	28	275	0	\N	\N	\N	\N
55	106	57	0	\N	\N	\N	\N
56	84	150	0	\N	\N	\N	\N
57	458	354	0	\N	\N	\N	\N
58	85	449	0	\N	\N	\N	\N
60	258	306	0	\N	\N	\N	\N
61	65	111	0	\N	\N	\N	\N
62	249	241	0	\N	\N	\N	\N
63	297	449	0	\N	\N	\N	\N
64	286	116	0	\N	\N	\N	\N
65	8	221	0	\N	\N	\N	\N
66	388	522	0	\N	\N	\N	\N
67	238	494	0	\N	\N	\N	\N
68	475	215	0	\N	\N	\N	\N
69	393	51	0	\N	\N	\N	\N
70	288	6	0	\N	\N	\N	\N
71	221	381	0	\N	\N	\N	\N
72	214	19	0	\N	\N	\N	\N
73	18	53	0	\N	\N	\N	\N
74	455	262	0	\N	\N	\N	\N
75	241	211	0	\N	\N	\N	\N
76	17	273	0	\N	\N	\N	\N
77	290	534	0	\N	\N	\N	\N
78	104	111	0	\N	\N	\N	\N
79	11	48	0	\N	\N	\N	\N
80	175	295	0	\N	\N	\N	\N
81	325	506	0	\N	\N	\N	\N
82	448	329	0	\N	\N	\N	\N
83	97	47	0	\N	\N	\N	\N
84	111	231	0	\N	\N	\N	\N
85	275	459	0	\N	\N	\N	\N
86	112	227	0	\N	\N	\N	\N
87	430	453	0	\N	\N	\N	\N
88	204	505	0	\N	\N	\N	\N
89	262	49	0	\N	\N	\N	\N
90	167	84	0	\N	\N	\N	\N
91	509	546	0	\N	\N	\N	\N
92	317	456	0	\N	\N	\N	\N
93	369	548	0	\N	\N	\N	\N
94	453	335	0	\N	\N	\N	\N
95	454	23	0	\N	\N	\N	\N
96	15	365	0	\N	\N	\N	\N
97	232	49	0	\N	\N	\N	\N
98	142	282	0	\N	\N	\N	\N
99	144	372	0	\N	\N	\N	\N
100	520	438	0	\N	\N	\N	\N
101	181	295	0	\N	\N	\N	\N
102	463	329	0	\N	\N	\N	\N
103	54	280	0	\N	\N	\N	\N
104	505	462	0	\N	\N	\N	\N
105	91	35	0	\N	\N	\N	\N
106	406	360	0	\N	\N	\N	\N
107	472	439	0	\N	\N	\N	\N
108	127	248	0	\N	\N	\N	\N
109	234	399	0	\N	\N	\N	\N
110	217	189	0	\N	\N	\N	\N
111	224	449	0	\N	\N	\N	\N
112	319	313	0	\N	\N	\N	\N
113	323	313	0	\N	\N	\N	\N
114	276	341	0	\N	\N	\N	\N
115	263	193	0	\N	\N	\N	\N
116	521	107	0	\N	\N	\N	\N
118	478	215	0	\N	\N	\N	\N
119	62	397	0	\N	\N	\N	\N
120	285	339	0	\N	\N	\N	\N
121	128	569	0	\N	\N	\N	\N
123	261	11	0	\N	\N	\N	\N
124	414	519	0	\N	\N	\N	\N
125	132	523	0	\N	\N	\N	\N
126	400	359	0	\N	\N	\N	\N
127	358	438	0	\N	\N	\N	\N
128	100	441	0	\N	\N	\N	\N
129	480	73	0	\N	\N	\N	\N
130	140	261	0	\N	\N	\N	\N
131	133	571	0	\N	\N	\N	\N
132	257	467	0	\N	\N	\N	\N
133	519	44	0	\N	\N	\N	\N
134	107	237	0	\N	\N	\N	\N
135	108	171	0	\N	\N	\N	\N
136	248	529	0	\N	\N	\N	\N
138	256	233	0	\N	\N	\N	\N
139	424	165	0	\N	\N	\N	\N
140	422	46	0	\N	\N	\N	\N
141	170	61	0	\N	\N	\N	\N
143	14	561	0	\N	\N	\N	\N
144	101	451	0	\N	\N	\N	\N
146	78	504	0	\N	\N	\N	\N
147	93	504	0	\N	\N	\N	\N
148	250	26	0	\N	\N	\N	\N
149	465	333	0	\N	\N	\N	\N
150	407	142	0	\N	\N	\N	\N
151	260	557	0	\N	\N	\N	\N
152	109	468	0	\N	\N	\N	\N
153	497	206	0	\N	\N	\N	\N
154	48	310	0	\N	\N	\N	\N
155	473	178	0	\N	\N	\N	\N
156	410	211	0	\N	\N	\N	\N
157	503	201	0	\N	\N	\N	\N
158	205	270	0	\N	\N	\N	\N
160	254	26	0	\N	\N	\N	\N
161	255	577	0	\N	\N	\N	\N
162	365	578	1	\N	\N	\N	\N
163	484	579	1	\N	\N	\N	\N
164	421	580	1	\N	\N	\N	\N
165	185	581	1	\N	\N	\N	\N
166	147	582	1	\N	\N	\N	\N
167	245	583	1	\N	\N	\N	\N
168	342	584	1	\N	\N	\N	\N
169	209	585	1	\N	\N	\N	\N
170	444	587	1	\N	\N	\N	\N
171	381	588	1	\N	\N	\N	\N
172	116	589	1	\N	\N	\N	\N
173	192	590	1	\N	\N	\N	\N
174	233	591	1	\N	\N	\N	\N
176	219	593	1	\N	\N	\N	\N
177	380	594	1	\N	\N	\N	\N
178	236	595	1	\N	\N	\N	\N
179	60	596	1	\N	\N	\N	\N
180	31	597	1	\N	\N	\N	\N
181	267	598	1	\N	\N	\N	\N
183	343	600	1	\N	\N	\N	\N
185	490	602	1	\N	\N	\N	\N
186	193	603	1	\N	\N	\N	\N
187	360	604	1	\N	\N	\N	\N
188	311	605	1	\N	\N	\N	\N
189	499	606	1	\N	\N	\N	\N
190	30	607	1	\N	\N	\N	\N
191	280	608	1	\N	\N	\N	\N
192	353	609	1	\N	\N	\N	\N
193	222	599	0	\N	\N	\N	\N
194	105	610	1	\N	\N	\N	\N
195	367	611	1	\N	\N	\N	\N
196	355	612	1	\N	\N	\N	\N
197	223	613	1	\N	\N	\N	\N
199	90	615	1	\N	\N	\N	\N
200	61	616	1	\N	\N	\N	\N
201	190	617	1	\N	\N	\N	\N
202	70	618	1	\N	\N	\N	\N
203	487	619	1	\N	\N	\N	\N
204	447	587	0	\N	\N	\N	\N
205	125	620	1	\N	\N	\N	\N
206	79	621	1	\N	\N	\N	\N
208	287	623	1	\N	\N	\N	\N
209	459	624	1	\N	\N	\N	\N
210	373	625	1	\N	\N	\N	\N
211	163	626	1	\N	\N	\N	\N
212	229	627	1	\N	\N	\N	\N
213	172	628	1	\N	\N	\N	\N
214	173	629	1	\N	\N	\N	\N
215	155	630	1	\N	\N	\N	\N
216	461	631	1	\N	\N	\N	\N
217	469	632	1	\N	\N	\N	\N
218	501	633	1	\N	\N	\N	\N
219	42	634	1	\N	\N	\N	\N
220	507	635	1	\N	\N	\N	\N
221	76	636	1	\N	\N	\N	\N
222	460	637	1	\N	\N	\N	\N
223	56	638	1	\N	\N	\N	\N
224	57	639	1	\N	\N	\N	\N
225	126	640	1	\N	\N	\N	\N
226	10	641	1	\N	\N	\N	\N
227	486	642	1	\N	\N	\N	\N
228	32	643	1	\N	\N	\N	\N
229	177	644	1	\N	\N	\N	\N
230	199	645	1	\N	\N	\N	\N
231	114	646	1	\N	\N	\N	\N
232	291	647	1	\N	\N	\N	\N
233	502	648	1	\N	\N	\N	\N
234	385	649	1	\N	\N	\N	\N
235	51	601	0	\N	\N	\N	\N
236	158	650	1	\N	\N	\N	\N
237	186	651	1	\N	\N	\N	\N
238	227	652	1	\N	\N	\N	\N
239	154	653	1	\N	\N	\N	\N
240	196	654	1	\N	\N	\N	\N
241	294	655	1	\N	\N	\N	\N
242	150	656	1	\N	\N	\N	\N
243	243	626	0	\N	\N	\N	\N
244	376	626	0	\N	\N	\N	\N
245	304	657	1	\N	\N	\N	\N
246	340	658	1	\N	\N	\N	\N
247	183	614	0	\N	\N	\N	\N
250	349	661	1	\N	\N	\N	\N
251	299	662	1	\N	\N	\N	\N
252	159	663	1	\N	\N	\N	\N
253	87	647	0	\N	\N	\N	\N
254	450	602	0	\N	\N	\N	\N
255	64	605	0	\N	\N	\N	\N
256	187	646	0	\N	\N	\N	\N
257	492	606	0	\N	\N	\N	\N
258	16	664	1	\N	\N	\N	\N
259	202	665	1	\N	\N	\N	\N
260	213	666	1	\N	\N	\N	\N
261	370	667	1	\N	\N	\N	\N
262	137	668	1	\N	\N	\N	\N
263	426	669	1	\N	\N	\N	\N
264	431	670	1	\N	\N	\N	\N
265	384	671	1	\N	\N	\N	\N
266	399	672	1	\N	\N	\N	\N
267	413	673	1	\N	\N	\N	\N
269	208	675	1	\N	\N	\N	\N
270	344	676	1	\N	\N	\N	\N
271	517	677	1	\N	\N	\N	\N
272	511	678	1	\N	\N	\N	\N
273	386	679	1	\N	\N	\N	\N
274	293	680	1	\N	\N	\N	\N
275	375	681	1	\N	\N	\N	\N
276	457	682	1	\N	\N	\N	\N
277	68	683	1	\N	\N	\N	\N
278	226	684	1	\N	\N	\N	\N
279	350	685	1	\N	\N	\N	\N
280	4	686	1	\N	\N	\N	\N
281	131	687	1	\N	\N	\N	\N
282	5	688	1	\N	\N	\N	\N
283	189	689	1	\N	\N	\N	\N
284	379	690	1	\N	\N	\N	\N
285	409	691	1	\N	\N	\N	\N
286	92	692	1	\N	\N	\N	\N
288	66	694	1	\N	\N	\N	\N
289	82	695	1	\N	\N	\N	\N
290	377	696	1	\N	\N	\N	\N
291	470	697	1	\N	\N	\N	\N
292	161	698	1	\N	\N	\N	\N
293	166	699	1	\N	\N	\N	\N
294	99	700	1	\N	\N	\N	\N
295	493	701	1	\N	\N	\N	\N
296	180	702	1	\N	\N	\N	\N
297	9	703	1	\N	\N	\N	\N
298	77	704	1	\N	\N	\N	\N
299	313	673	0	\N	\N	\N	\N
300	312	676	0	\N	\N	\N	\N
301	178	677	0	\N	\N	\N	\N
302	246	705	1	\N	\N	\N	\N
303	73	706	1	\N	\N	\N	\N
304	346	707	1	\N	\N	\N	\N
306	329	708	1	\N	\N	\N	\N
307	279	709	1	\N	\N	\N	\N
308	156	710	1	\N	\N	\N	\N
309	273	711	1	\N	\N	\N	\N
310	300	712	1	\N	\N	\N	\N
311	482	713	1	\N	\N	\N	\N
312	81	714	1	\N	\N	\N	\N
313	138	715	1	\N	\N	\N	\N
314	151	693	0	\N	\N	\N	\N
315	194	716	1	\N	\N	\N	\N
316	7	717	1	\N	\N	\N	\N
317	148	718	1	\N	\N	\N	\N
318	494	719	1	\N	\N	\N	\N
319	152	674	0	\N	\N	\N	\N
321	387	720	1	\N	\N	\N	\N
322	26	721	1	\N	\N	\N	\N
323	389	722	1	\N	\N	\N	\N
324	514	723	1	\N	\N	\N	\N
325	471	713	0	\N	\N	\N	\N
326	483	713	0	\N	\N	\N	\N
327	476	724	1	\N	\N	\N	\N
328	408	725	1	\N	\N	\N	\N
329	416	726	1	\N	\N	\N	\N
330	119	727	1	\N	\N	\N	\N
331	345	728	1	\N	\N	\N	\N
332	174	683	0	\N	\N	\N	\N
333	301	729	1	\N	\N	\N	\N
335	271	730	1	\N	\N	\N	\N
336	283	731	1	\N	\N	\N	\N
337	500	732	1	\N	\N	\N	\N
338	120	733	1	\N	\N	\N	\N
339	281	734	1	\N	\N	\N	\N
340	356	723	0	\N	\N	\N	\N
341	58	735	1	\N	\N	\N	\N
342	210	696	0	\N	\N	\N	\N
343	485	725	0	\N	\N	\N	\N
344	392	736	1	\N	\N	\N	\N
345	391	737	1	\N	\N	\N	\N
346	481	738	1	\N	\N	\N	\N
347	71	692	0	\N	\N	\N	\N
348	153	739	1	\N	\N	\N	\N
349	403	740	1	\N	\N	\N	\N
350	200	741	1	\N	\N	\N	\N
351	397	742	1	\N	\N	\N	\N
352	452	701	0	\N	\N	\N	\N
353	265	665	0	\N	\N	\N	\N
354	53	743	1	\N	\N	\N	\N
356	402	744	1	\N	\N	\N	\N
357	417	745	1	\N	\N	\N	\N
358	515	746	1	\N	\N	\N	\N
359	429	747	1	\N	\N	\N	\N
360	302	748	1	\N	\N	\N	\N
361	347	749	1	\N	\N	\N	\N
362	135	750	1	\N	\N	\N	\N
363	394	751	1	\N	\N	\N	\N
364	395	752	1	\N	\N	\N	\N
365	102	753	1	\N	\N	\N	\N
367	298	365	0	\N	\N	\N	\N
368	508	725	0	\N	\N	\N	\N
369	451	602	0	\N	\N	\N	\N
370	207	675	0	\N	\N	\N	\N
373	145	582	0	\N	\N	\N	\N
374	96	754	0	\N	\N	\N	\N
375	20	640	0	\N	\N	\N	\N
376	396	719	0	\N	\N	\N	\N
377	225	704	0	\N	\N	\N	\N
378	320	605	0	\N	\N	\N	\N
379	121	615	0	\N	\N	\N	\N
380	206	33	0	\N	\N	\N	\N
381	418	695	0	\N	\N	\N	\N
382	164	753	0	\N	\N	\N	\N
383	176	628	0	\N	\N	\N	\N
384	438	741	0	\N	\N	\N	\N
385	423	697	0	\N	\N	\N	\N
386	149	718	0	\N	\N	\N	\N
387	39	727	0	\N	\N	\N	\N
388	335	730	0	\N	\N	\N	\N
389	316	652	0	\N	\N	\N	\N
390	134	687	0	\N	\N	\N	\N
391	35	703	0	\N	\N	\N	\N
392	72	632	0	\N	\N	\N	\N
394	252	702	0	\N	\N	\N	\N
396	488	726	0	\N	\N	\N	\N
397	489	714	0	\N	\N	\N	\N
398	477	738	0	\N	\N	\N	\N
399	425	663	0	\N	\N	\N	\N
400	75	756	1	\N	\N	\N	\N
401	277	757	1	\N	\N	\N	\N
402	441	758	1	\N	\N	\N	\N
403	230	759	1	\N	\N	\N	\N
405	491	761	1	\N	\N	\N	\N
406	495	761	0	\N	\N	\N	\N
407	46	762	1	\N	\N	\N	\N
408	3	763	1	\N	\N	\N	\N
409	336	764	1	\N	\N	\N	\N
410	110	765	1	\N	\N	\N	\N
412	29	766	1	\N	\N	\N	\N
413	22	767	1	\N	\N	\N	\N
414	69	768	1	\N	\N	\N	\N
415	211	769	1	\N	\N	\N	\N
416	211	770	2	\N	\N	\N	\N
417	146	771	1	\N	\N	\N	\N
418	512	772	1	\N	\N	\N	\N
419	366	773	1	\N	\N	\N	\N
421	332	775	1	\N	\N	\N	\N
422	95	776	1	\N	\N	\N	\N
423	464	777	1	\N	\N	\N	\N
424	449	778	1	\N	\N	\N	\N
425	12	779	1	\N	\N	\N	\N
426	195	760	0	\N	\N	\N	\N
427	168	780	1	\N	\N	\N	\N
428	216	781	1	\N	\N	\N	\N
429	361	782	1	\N	\N	\N	\N
430	354	783	1	\N	\N	\N	\N
431	118	784	1	\N	\N	\N	\N
432	36	785	1	\N	\N	\N	\N
433	33	786	1	\N	\N	\N	\N
434	363	787	1	\N	\N	\N	\N
435	327	788	1	\N	\N	\N	\N
436	41	789	1	\N	\N	\N	\N
437	115	790	1	\N	\N	\N	\N
438	239	791	1	\N	\N	\N	\N
439	296	792	1	\N	\N	\N	\N
440	228	790	0	\N	\N	\N	\N
441	334	793	1	\N	\N	\N	\N
442	21	794	1	\N	\N	\N	\N
443	45	795	1	\N	\N	\N	\N
444	462	786	0	\N	\N	\N	\N
445	330	796	1	\N	\N	\N	\N
446	326	759	0	\N	\N	\N	\N
447	251	797	1	\N	\N	\N	\N
448	440	798	1	\N	\N	\N	\N
449	445	776	0	\N	\N	\N	\N
450	443	799	1	\N	\N	\N	\N
451	305	800	1	\N	\N	\N	\N
452	362	797	0	\N	\N	\N	\N
454	188	802	1	\N	\N	\N	\N
455	27	803	1	\N	\N	\N	\N
456	162	804	1	\N	\N	\N	\N
457	218	769	0	\N	\N	\N	\N
459	212	769	0	\N	\N	\N	\N
460	157	806	1	\N	\N	\N	\N
461	351	806	0	\N	\N	\N	\N
463	130	808	1	\N	\N	\N	\N
464	129	809	1	\N	\N	\N	\N
465	165	810	1	\N	\N	\N	\N
466	24	785	0	\N	\N	\N	\N
467	182	811	1	\N	\N	\N	\N
468	231	812	1	\N	\N	\N	\N
469	43	813	1	\N	\N	\N	\N
470	244	814	1	\N	\N	\N	\N
471	328	788	0	\N	\N	\N	\N
472	372	815	1	\N	\N	\N	\N
473	37	810	0	\N	\N	\N	\N
474	179	644	0	\N	\N	\N	\N
475	141	816	1	\N	\N	\N	\N
477	474	817	2	\N	\N	\N	\N
478	432	817	0	\N	\N	\N	\N
481	420	818	1	\N	\N	\N	\N
482	264	755	0	\N	\N	\N	\N
484	266	820	1	\N	\N	\N	\N
485	274	821	1	\N	\N	\N	\N
486	398	816	0	\N	\N	\N	\N
487	412	822	1	\N	\N	\N	\N
488	401	813	0	\N	\N	\N	\N
489	160	823	1	\N	\N	\N	\N
492	306	824	1	\N	\N	\N	\N
493	67	825	1	\N	\N	\N	\N
494	74	784	0	\N	\N	\N	\N
495	456	826	1	\N	\N	\N	\N
496	446	826	0	\N	\N	\N	\N
497	23	794	0	\N	\N	\N	\N
498	337	827	1	\N	\N	\N	\N
499	466	807	0	\N	\N	\N	\N
501	284	829	1	\N	\N	\N	\N
502	338	830	1	\N	\N	\N	\N
503	405	781	0	\N	\N	\N	\N
504	303	831	1	\N	\N	\N	\N
505	439	832	1	\N	\N	\N	\N
506	435	833	1	\N	\N	\N	\N
507	253	819	0	\N	\N	\N	\N
508	437	834	1	\N	\N	\N	\N
510	240	835	1	\N	\N	\N	\N
511	479	836	1	\N	\N	\N	\N
512	269	790	0	\N	\N	\N	\N
514	247	636	0	\N	\N	\N	\N
515	247	253	0	\N	\N	\N	\N
516	203	615	0	\N	\N	\N	\N
517	203	22	0	\N	\N	\N	\N
518	47	837	1	\N	\N	\N	\N
519	169	838	1	\N	\N	\N	\N
520	197	811	0	\N	\N	\N	\N
521	270	839	1	\N	\N	\N	\N
522	292	840	1	\N	\N	\N	\N
523	315	690	0	\N	\N	\N	\N
524	341	841	1	\N	\N	\N	\N
525	371	755	0	\N	\N	\N	\N
526	378	842	1	\N	\N	\N	\N
527	383	843	1	\N	\N	\N	\N
528	404	837	0	\N	\N	\N	\N
529	415	786	0	\N	\N	\N	\N
530	428	700	0	\N	\N	\N	\N
531	427	844	1	\N	\N	\N	\N
532	442	428	0	\N	\N	\N	\N
533	516	845	1	\N	\N	\N	\N
534	522	633	0	\N	\N	\N	\N
535	523	846	1	\N	\N	\N	\N
536	524	794	0	\N	\N	\N	\N
537	44	715	0	\N	\N	\N	\N
538	259	699	0	\N	\N	\N	\N
539	103	805	0	\N	\N	\N	\N
540	83	847	1	\N	\N	\N	\N
541	86	848	1	\N	\N	\N	\N
542	122	849	1	\N	\N	\N	\N
543	34	850	1	\N	\N	\N	\N
544	242	839	0	\N	\N	\N	\N
545	235	851	1	\N	\N	\N	\N
546	88	852	1	\N	\N	\N	\N
548	419	853	1	\N	\N	\N	\N
549	368	807	0	\N	\N	\N	\N
550	268	854	1	\N	\N	\N	\N
551	13	855	1	\N	\N	\N	\N
552	40	856	1	\N	\N	\N	\N
553	433	857	1	\N	\N	\N	\N
554	215	859	1	\N	\N	\N	\N
555	278	860	1	\N	\N	\N	\N
556	314	861	1	\N	\N	\N	\N
557	333	862	1	\N	\N	\N	\N
558	390	863	1	\N	\N	\N	\N
559	467	864	1	\N	\N	\N	\N
560	496	865	1	\N	\N	\N	\N
561	38	653	0	\N	\N	\N	\N
562	331	866	1	\N	\N	\N	\N
563	50	867	1	\N	\N	\N	\N
564	117	868	1	\N	\N	\N	\N
565	171	869	1	\N	\N	\N	\N
566	436	870	1	\N	\N	\N	\N
567	504	871	1	\N	\N	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: en
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
522	21
524	21
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
1208	word	1	W	\N
1209	speak	1	S	\N
1210	writing	1	W	\N
1211	talk	1	T	\N
1212	meaning	1	M	\N
1213	hiragana	1	H	\N
1214	katakana	1	K	\N
1215	adult	1	A	\N
1216	many people	1	M	\N
1217	couple	1	C	\N
1218	child	1	C	\N
1219	wife	1	W	\N
1220	woman	1	W	\N
1221	boy	1	B	\N
1222	person	1	P	\N
1223	man	1	M	\N
1224	girl	1	G	\N
1225	husband	1	H	\N
1226	person	1	P	\N
1227	everyone	1	E	\N
1228	white	1	W	\N
1229	blue	1	B	\N
1230	brown	1	B	\N
1231	light	1	L	\N
1232	color	1	C	\N
1233	dark	1	D	\N
1234	yellow	1	Y	\N
1235	black	1	B	\N
1236	red	1	R	\N
1237	green	1	G	\N
1238	convenient	1	C	\N
1239	party	1	P	\N
1240	paper	1	P	\N
1241	become	1	B	\N
1242	fasten	1	F	\N
1243	push	1	P	\N
1244	begin	1	B	\N
1245	just	1	J	\N
1246	no	1	N	\N
1247	straight	1	S	\N
1248	famous	1	F	\N
1249	fine	1	F	\N
1250	then	1	T	\N
1251	probably	1	P	\N
1252	so	1	S	\N
1253	xylophone	1	X	\N
1254	he	1	H	\N
1255	she	1	S	\N
1256	you're welcome	0	Y	\N
1	good morning	\N	\N	\N
2	how are you?	\N	\N	\N
3	fine	\N	\N	\N
4	a bit	\N	\N	\N
5	sleepy	\N	\N	\N
6	also	\N	\N	\N
7	read	\N	\N	\N
8	 until late 	\N	\N	\N
9	 last night 	\N	\N	\N
10	write	\N	\N	\N
11	 E-mail 	\N	\N	\N
12	 friend 	\N	\N	\N
13	America	\N	\N	\N
14	miss 	\N	\N	\N
15	not really	\N	\N	\N
16	because	\N	\N	\N
17	always 	\N	\N	\N
18	talk 	\N	\N	\N
19	on the Internet 	\N	\N	\N
20	 different	\N	\N	\N
21	first 	\N	\N	\N
22	Japan	\N	\N	\N
23	such 	\N	\N	\N
24	useful 	\N	\N	\N
25	technology	\N	\N	\N
26	then 	\N	\N	\N
27	small	\N	\N	\N
28	world	\N	\N	\N
29	sure	\N	\N	\N
30	Hello	\N	\N	\N
31	 Mr. Wilson 	\N	\N	\N
32	this is ~.	\N	\N	\N
33	oh	\N	\N	\N
34	get	\N	\N	\N
35	letter	\N	\N	\N
36	very	\N	\N	\N
37	nice	\N	\N	\N
38	thank you	\N	\N	\N
39	very much	\N	\N	\N
40	you are welcome	\N	\N	\N
41	picture	\N	\N	\N
42	beautiful	\N	\N	\N
43	Don't mention it.	\N	\N	\N
44	really	\N	\N	\N
45	miss	\N	\N	\N
46	too	\N	\N	\N
47	everything	\N	\N	\N
48	No problem. 	\N	\N	\N
49	 thanks 	\N	\N	\N
50	call	\N	\N	\N
51	It's my pleasure. 	\N	\N	\N
52	goodbye	\N	\N	\N
53	excuse me	\N	\N	\N
54	help	\N	\N	\N
55	 just 	\N	\N	\N
56	 room 	\N	\N	\N
57	 for 	\N	\N	\N
58	 staff 	\N	\N	\N
59	only	\N	\N	\N
60	sorry	\N	\N	\N
61	 know 	\N	\N	\N
62	OK	\N	\N	\N
63	 nothing 	\N	\N	\N
64	special	\N	\N	\N
65	 anyway 	\N	\N	\N
66	 I see 	\N	\N	\N
67	wait	\N	\N	\N
68	excuse me 	\N	\N	\N
69	how do I get to ~?	\N	\N	\N
70	cafeteria	\N	\N	\N
71	I am lost.	\N	\N	\N
72	then	\N	\N	\N
73	 show	\N	\N	\N
74	way	\N	\N	\N
75	thanks a lot	\N	\N	\N
76	today	\N	\N	\N
77	new	\N	\N	\N
78	student	\N	\N	\N
79	hi	\N	\N	\N
80	name	\N	\N	\N
81	nice to meet you	\N	\N	\N
82	please	\N	\N	\N
83	tell	\N	\N	\N
84	class	\N	\N	\N
85	about~	\N	\N	\N
86	yourself	\N	\N	\N
87	well	\N	\N	\N
88	come back	\N	\N	\N
89	 America 	\N	\N	\N
90	Saint Louis	\N	\N	\N
91	Missouri	\N	\N	\N
92	last	\N	\N	\N
93	month	\N	\N	\N
94	hobby	\N	\N	\N
95	like	\N	\N	\N
96	play~	\N	\N	\N
97	baseball	\N	\N	\N
98	draw	\N	\N	\N
99	make	\N	\N	\N
100	friend	\N	\N	\N
101	good	\N	\N	\N
102	a lot of	\N	\N	\N
103	here	\N	\N	\N
104	I'm sorry.	\N	\N	\N
105	late	\N	\N	\N
106	happen	\N	\N	\N
107	take	\N	\N	\N
108	wrong	\N	\N	\N
109	train	\N	\N	\N
110	so	\N	\N	\N
111	That happens	\N	\N	\N
112	but	\N	\N	\N
113	could have	\N	\N	\N
114	want to ~	\N	\N	\N
115	know	\N	\N	\N
116	number	\N	\N	\N
117	should have ~	\N	\N	\N
118	fault	\N	\N	\N
119	anyway	\N	\N	\N
120	careful	\N	\N	\N
121	have to~	\N	\N	\N
122	apologize	\N	\N	\N
123	all of ~	\N	\N	\N
124	keep ~ing	\N	\N	\N
125	half an hour	\N	\N	\N
126	That's all right.	\N	\N	\N
127	have fun	\N	\N	\N
128	talk	\N	\N	\N
129	 with each other 	\N	\N	\N
130	be glad	\N	\N	\N
131	hear	\N	\N	\N
132	let us	\N	\N	\N
133	get started	\N	\N	\N
134	yeah	\N	\N	\N
135	great	\N	\N	\N
136	thanks	\N	\N	\N
137	for	\N	\N	\N
138	from	\N	\N	\N
139	ｗhat	\N	\N	\N
140	open	\N	\N	\N
141	origami paper	\N	\N	\N
142	different	\N	\N	\N
143	thing	\N	\N	\N
144	pretty	\N	\N	\N
145	 thanks a lot	\N	\N	\N
146	wow	\N	\N	\N
147	paper crane	\N	\N	\N
148	have got to ~	\N	\N	\N
149	go	\N	\N	\N
150	now	\N	\N	\N
151	flight	\N	\N	\N
152	thank you 	\N	\N	\N
153	it is my pleasure	\N	\N	\N
154	will ~	\N	\N	\N
155	take care	\N	\N	\N
156	give one’s best regards to ~	\N	\N	\N
157	family	\N	\N	\N
158	will	\N	\N	\N
159	visit	\N	\N	\N
160	again	\N	\N	\N
161	someday	\N	\N	\N
162	see	\N	\N	\N
163	there	\N	\N	\N
164	bye	\N	\N	\N
165	for now	\N	\N	\N
166	 Have a nice ~	\N	\N	\N
167	can I help you	\N	\N	\N
168	how much	\N	\N	\N
169	map	\N	\N	\N
170	Australia	\N	\N	\N
171	yen	\N	\N	\N
172	and	\N	\N	\N
173	how about ~?	\N	\N	\N
174	book	\N	\N	\N
175	one	\N	\N	\N
176	about	\N	\N	\N
177	 Native Americans	\N	\N	\N
178	look	\N	\N	\N
179	interesting	\N	\N	\N
180	have	\N	\N	\N
181	where	\N	\N	\N
182	would like to ~	\N	\N	\N
183	would like to~	\N	\N	\N
184	Tokyo Dreamland	\N	\N	\N
185	have you ever been	\N	\N	\N
186	have been there	\N	\N	\N
187	time	\N	\N	\N
188	a lot	\N	\N	\N
189	one of ~	\N	\N	\N
190	classmate	\N	\N	\N
191	more than ~	\N	\N	\N
192	 unbelievable 	\N	\N	\N
193	would	\N	\N	\N
194	get bored	\N	\N	\N
195	fun	\N	\N	\N
196	every time	\N	\N	\N
197	must	\N	\N	\N
198	at least	\N	\N	\N
199	once	\N	\N	\N
200	enjoy	\N	\N	\N
201	game	\N	\N	\N
202	just	\N	\N	\N
203	think	\N	\N	\N
204	summer vacation	\N	\N	\N
205	do you have ~?	\N	\N	\N
206	any	\N	\N	\N
207	plan	\N	\N	\N
208	be going to ~	\N	\N	\N
209	spend	\N	\N	\N
210	with	\N	\N	\N
211	come	\N	\N	\N
212	uh-huh	\N	\N	\N
213	in~	\N	\N	\N
214	week	\N	\N	\N
215	sound	\N	\N	\N
216	can not	\N	\N	\N
217	to (V)~	\N	\N	\N
218	what about ~?	\N	\N	\N
219	vacation	\N	\N	\N
220	go back	\N	\N	\N
221	 Switzerland 	\N	\N	\N
222	grandma	\N	\N	\N
223	grandpa	\N	\N	\N
224	look forward to ~	\N	\N	\N
225	should	\N	\N	\N
226	dad	\N	\N	\N
227	leave	\N	\N	\N
228	home	\N	\N	\N
229	early	\N	\N	\N
230	office	\N	\N	\N
231	rather	\N	\N	\N
232	far	\N	\N	\N
233	how far is ~?	\N	\N	\N
234	hour	\N	\N	\N
235	father	\N	\N	\N
236	house	\N	\N	\N
237	minute	\N	\N	\N
238	drive	\N	\N	\N
239	no wonder (that) ~	\N	\N	\N
240	seem	\N	\N	\N
241	be tired	\N	\N	\N
242	everyday	\N	\N	\N
243	poor	\N	\N	\N
244	tired	\N	\N	\N
245	a little bit	\N	\N	\N
246	what time is it?	\N	\N	\N
247	New York	\N	\N	\N
248	let me see	\N	\N	\N
249	a.m.	\N	\N	\N
250	p.m.	\N	\N	\N
251	after ~	\N	\N	\N
252	midnight	\N	\N	\N
253	that is why ~	\N	\N	\N
254	I know.	\N	\N	\N
255	what time ~?	\N	\N	\N
256	go to bed	\N	\N	\N
257	will you ~?	\N	\N	\N
258	send	\N	\N	\N
259	ticket	\N	\N	\N
260	all right	\N	\N	\N
261	write down	\N	\N	\N
262	address	\N	\N	\N
263	what is ~?	\N	\N	\N
264	zip code	\N	\N	\N
265	something	\N	\N	\N
266	always	\N	\N	\N
267	forget	\N	\N	\N
268	yours	\N	\N	\N
269	mine	\N	\N	\N
270	think~	\N	\N	\N
271	not	\N	\N	\N
272	later	\N	\N	\N
273	okay	\N	\N	\N
274	no problem	\N	\N	\N
275	drawing	\N	\N	\N
276	finish	\N	\N	\N
277	let’s~	\N	\N	\N
278	color ~ in	\N	\N	\N
279	should~	\N	\N	\N
280	use	\N	\N	\N
281	sky	\N	\N	\N
282	can~	\N	\N	\N
283	fill ~ in	\N	\N	\N
284	with~	\N	\N	\N
285	blue	\N	\N	\N
286	marker	\N	\N	\N
287	O.K./OK/okay	\N	\N	\N
288	 why don’t you ~?	\N	\N	\N
289	paint	\N	\N	\N
290	tree	\N	\N	\N
291	spray	\N	\N	\N
292	what about~? 	\N	\N	\N
293	flower	\N	\N	\N
294	red	\N	\N	\N
295	yellow	\N	\N	\N
296	crayon	\N	\N	\N
297	oops 	\N	\N	\N
298	make a mistake	\N	\N	\N
299	don’t worry	\N	\N	\N
300	cover	\N	\N	\N
301	white	\N	\N	\N
302	 a good idea 	\N	\N	\N
303	English	\N	\N	\N
304	learn	\N	\N	\N
305	live	\N	\N	\N
306	abroad	\N	\N	\N
307	for ~	\N	\N	\N
308	a few ~	\N	\N	\N
309	year	\N	\N	\N
310	I see	\N	\N	\N
311	speak	\N	\N	\N
312	Japanese	\N	\N	\N
313	sort of 	\N	\N	\N
314	other	\N	\N	\N
315	language	\N	\N	\N
316	say	\N	\N	\N
317	from~	\N	\N	\N
318	Switzerland	\N	\N	\N
319	French	\N	\N	\N
320	German	\N	\N	\N
321	some	\N	\N	\N
322	penguin	\N	\N	\N
323	cute	\N	\N	\N
324	funny	\N	\N	\N
325	all	\N	\N	\N
326	big	\N	\N	\N
327	animal	\N	\N	\N
328	Let me see.	\N	\N	\N
329	there be ~	\N	\N	\N
330	elephant	\N	\N	\N
331	next to	\N	\N	\N
332	monkey	\N	\N	\N
333	go see	\N	\N	\N
334	hippopotamus	\N	\N	\N
335	rhinoceros	\N	\N	\N
336	near	\N	\N	\N
337	lion	\N	\N	\N
338	at	\N	\N	\N
339	zoo	0	Z	\N
340	far away	\N	\N	\N
341	cool	\N	\N	\N
342	close to	\N	\N	\N
343	snake	\N	\N	\N
344	want to	\N	\N	\N
345	scary	\N	\N	\N
346	show	\N	\N	\N
347	No problem	\N	\N	\N
348	thirsty	\N	\N	\N
349	what	\N	\N	\N
350	grade	\N	\N	\N
351	fourth	\N	\N	\N
352	How about you?	\N	\N	\N
353	fifth	\N	\N	\N
354	grader	\N	\N	\N
355	school	\N	\N	\N
356	idea	\N	\N	\N
357	cannot	\N	\N	\N
358	video game	\N	\N	\N
359	expensive	\N	\N	\N
360	right	\N	\N	\N
361	hmm	\N	\N	\N
362	this	\N	\N	\N
363	difficult	\N	\N	\N
364	can	\N	\N	\N
365	give	\N	\N	\N
366	Isn’t it?	\N	\N	\N
367	teach	\N	\N	\N
368	how to	\N	\N	\N
369	ooo	\N	\N	\N
370	natto	\N	\N	\N
371	still	\N	\N	\N
372	get used to	\N	\N	\N
373	smell	\N	\N	\N
374	have come to	\N	\N	\N
375	true	\N	\N	\N
376	for example	\N	\N	\N
377	nori	\N	\N	\N
378	weird	\N	\N	\N
379	eat	\N	\N	\N
380	black	\N	\N	\N
381	paper	\N	\N	\N
382	shirasu	\N	\N	\N
383	You ... , don’t you?	\N	\N	\N
384	when	\N	\N	\N
385	at first	\N	\N	\N
386	tiny	\N	\N	\N
387	eye	\N	\N	\N
388	favorite	\N	\N	\N
389	maybe	\N	\N	\N
390	yokan	\N	\N	\N
391	love	\N	\N	\N
392	yuck	\N	\N	\N
393	hate	\N	\N	\N
394	sweet	\N	\N	\N
395	that	\N	\N	\N
396	Excuse	\N	\N	\N
397	comic book	\N	\N	\N
398	American	\N	\N	\N
399	It’s ... , isn’t it?	\N	\N	\N
400	practice	\N	\N	\N
401	study	\N	\N	\N
402	glad	\N	\N	\N
403	team	\N	\N	\N
404	play baseball	\N	\N	\N
405	I have played	\N	\N	\N
406	never	\N	\N	\N
407	watch	\N	\N	\N
408	begin	\N	\N	\N
409	first	\N	\N	\N
410	put	\N	\N	\N
411	pancake mix	\N	\N	\N
412	in	\N	\N	\N
413	bowl	\N	\N	\N
414	two	\N	\N	\N
415	egg	\N	\N	\N
416	milk	\N	\N	\N
417	do	\N	\N	\N
418	after	\N	\N	\N
419	mix	\N	\N	\N
420	together	\N	\N	\N
421	get it	\N	\N	\N
422	next	\N	\N	\N
423	pan	\N	\N	\N
424	flip	\N	\N	\N
425	few	\N	\N	\N
426		\N	\N	\N
427	finally	\N	\N	\N
428	until	\N	\N	\N
429	ready	\N	\N	\N
430	how	\N	\N	\N
431	parent	\N	\N	\N
432	busy	\N	\N	\N
433	brother	\N	\N	\N
434	how is ... doing?	\N	\N	\N
435	work	\N	\N	\N
436	bank	\N	\N	\N
437	boring	\N	\N	\N
438	how about .... ?	\N	\N	\N
439	sister	\N	\N	\N
440	do well	\N	\N	\N
441	to	\N	\N	\N
442	summer 	\N	\N	\N
443	camp	\N	\N	\N
444	Billy	\N	\N	\N
445	dog	\N	\N	\N
446	be excited about	\N	\N	\N
447	picnic	\N	\N	\N
448	Saturday	\N	\N	\N
449	weather	\N	\N	\N
450	may	\N	\N	\N
451	oh no	\N	\N	\N
452	if	\N	\N	\N
453	bad	\N	\N	\N
454	cloudy	\N	\N	\N
455	shall	\N	\N	\N
456	have a picnic	\N	\N	\N
457	What about ～ ?	\N	\N	\N
458	rain	\N	\N	\N
459	else	\N	\N	\N
460	movie	\N	\N	\N
461	I would rather～	\N	\N	\N
462	worry	\N	\N	\N
463	superhero	\N	\N	\N
464	why	\N	\N	\N
465	super	\N	\N	\N
466	strong	\N	\N	\N
467	than	\N	\N	\N
468	human	\N	\N	\N
469	fast	\N	\N	\N
470	jet	\N	\N	\N
471	smart	\N	\N	\N
472	computer	\N	\N	\N
473	clothes	\N	\N	\N
474	ever	\N	\N	\N
475	yep	\N	\N	\N
476	moutain	\N	\N	\N
477	weekend	\N	\N	\N
478	I don't know	\N	\N	\N
479	Come on.	\N	\N	\N
480	it will be～	\N	\N	\N
481	go hiking	\N	\N	\N
482	hot	\N	\N	\N
483	How about －ing ?	\N	\N	\N
484	beach	\N	\N	\N
485	on	\N	\N	\N
486	What about ーing ?	\N	\N	\N
487	Sunday	\N	\N	\N
488	Isn't there ... ?	\N	\N	\N
489	festival	\N	\N	\N
490	be going to	\N	\N	\N
491	let's	\N	\N	\N
492	outside	\N	\N	\N
493	play	\N	\N	\N
494	no	\N	\N	\N
495	feel like ～	\N	\N	\N
496	why not	\N	\N	\N
497	video	\N	\N	\N
498	already	\N	\N	\N
499	a few	\N	\N	\N
500	my	\N	\N	\N
501	why 	\N	\N	\N
502	want to ～	\N	\N	\N
503	sunny 	\N	\N	\N
504	day	\N	\N	\N
505	come on	\N	\N	\N
506	go 	\N	\N	\N
507	wait a second	\N	\N	\N
508	 part	\N	\N	\N
509	these	\N	\N	\N
510	scissors	\N	\N	\N
511	cut	\N	\N	\N
512	can you ～?	\N	\N	\N
513	lend	\N	\N	\N
514	me	\N	\N	\N
515	just a second 	\N	\N	\N
516	here you go	\N	\N	\N
517	will you～?	\N	\N	\N
518	pass	\N	\N	\N
519	glue	\N	\N	\N
520	here you are	\N	\N	\N
521	oh no!	\N	\N	\N
522	tape	\N	\N	\N
523	find	\N	\N	\N
524	here it is	\N	\N	\N
525	kind	\N	\N	\N
526	store	\N	\N	\N
527	sell	\N	\N	\N
528	futon	\N	\N	\N
529	That's right.	\N	\N	\N
530	sheet	\N	\N	\N
531	blanket	\N	\N	\N
532	pillow	\N	\N	\N
533	what about～?	\N	\N	\N
534	what 	\N	\N	\N
535	lots of	\N	\N	\N
536	bucket	\N	\N	\N
537	knife	\N	\N	\N
538	tool	\N	\N	\N
539	ladder	\N	\N	\N
540	hardware	\N	\N	\N
541	kind of	\N	\N	\N
542	rollercoaster	\N	\N	\N
543	Let us～	\N	\N	\N
544	go on	\N	\N	\N
545	we	\N	\N	\N
546	sick	\N	\N	\N
547	ride	\N	\N	\N
548	Ferris Wheel	\N	\N	\N
549	slide	\N	\N	\N
550	I guess so.	\N	\N	\N
551	only if	\N	\N	\N
552	ice cream	\N	\N	\N
553	it's a deal	\N	\N	\N
554	change	\N	\N	\N
555	report	\N	\N	\N
556	topic	\N	\N	\N
557	dinosaur	\N	\N	\N
558	pirate	\N	\N	\N
559	go ahead	\N	\N	\N
560	may I～?	\N	\N	\N
561	borrow	\N	\N	\N
562	make sure to～	\N	\N	\N
563	give back	\N	\N	\N
564	 enough～to... 	\N	\N	\N
565	I don't know.	\N	\N	\N
566	could I～?	\N	\N	\N
567	turn in	\N	\N	\N
568	summer	\N	\N	\N
569	matter	\N	\N	\N
570	bathroom	\N	\N	\N
571	of course	\N	\N	\N
572	invite	\N	\N	\N
573	over	\N	\N	\N
574	dinner	\N	\N	\N
575	manner	\N	\N	\N
576	for instance	\N	\N	\N
577	bring	\N	\N	\N
578	Hmm	\N	\N	\N
579	probably	\N	\N	\N
580	sweets	\N	\N	\N
581	need to～	\N	\N	\N
582	meet	\N	\N	\N
583	his	\N	\N	\N
584	into	\N	\N	\N
585	have to	\N	\N	\N
586	table manners	\N	\N	\N
587	chopstick	\N	\N	\N
588	try to	\N	\N	\N
589	them	\N	\N	\N
590	try	\N	\N	\N
591	polite	\N	\N	\N
592	 really 	\N	\N	\N
593	before	\N	\N	\N
594	house rules	\N	\N	\N
595	must not	\N	\N	\N
596	wear	\N	\N	\N
597	shoe	\N	\N	\N
598	TV	\N	\N	\N
599	noisy	\N	\N	\N
600	night	\N	\N	\N
601	That's it.	\N	\N	\N
602	strict	\N	\N	\N
603	level	\N	\N	\N
604	what to do	\N	\N	\N
605	press	\N	\N	\N
606	button	\N	\N	\N
607	run	\N	\N	\N
608	over there	\N	\N	\N
609	oh yeah	\N	\N	\N
610	jump	\N	\N	\N
611	airplane	\N	\N	\N
612	fly	\N	\N	\N
613	up	\N	\N	\N
614	toward	\N	\N	\N
615	castle	\N	\N	\N
616	easy	\N	\N	\N
617	stay away from～	\N	\N	\N
618	plane	\N	\N	\N
619	there are	\N	\N	\N
620	many	\N	\N	\N
621	oh, no	\N	\N	\N
622	dead	\N	\N	\N
623	don't worry	\N	\N	\N
624	start over	\N	\N	\N
625	yes	\N	\N	\N
626	would you mind not～ing?	\N	\N	\N
627	make noise	\N	\N	\N
628	much	\N	\N	\N
629	sorry about that	\N	\N	\N
630	hall	\N	\N	\N
631	kick	\N	\N	\N
632	ball	\N	\N	\N
633	 around	\N	\N	\N
634	It doesn't matter.	\N	\N	\N
635	do not	\N	\N	\N
636	school building	\N	\N	\N
637	gym	\N	\N	\N
638	will not	\N	\N	\N
639	I'm sorry	\N	\N	\N
640	dish	\N	\N	\N
641	kitchen	\N	\N	\N
642	don't have to	\N	\N	\N
643	Are you sure?	\N	\N	\N
644	would like to	\N	\N	\N
645	help out	\N	\N	\N
646	don't worry about it.	\N	\N	\N
647	our	\N	\N	\N
648	guest	\N	\N	\N
649	 like	\N	\N	\N
650	 what	\N	\N	\N
651	laundry	\N	\N	\N
652	wash	\N	\N	\N
653	own	\N	\N	\N
654	mom	\N	\N	\N
655	need to	\N	\N	\N
656	clean up	\N	\N	\N
657	room	\N	\N	\N
658	don't need to	\N	\N	\N
659	 must	\N	\N	\N
660	make one's bed 	\N	\N	\N
661	that's it	\N	\N	\N
662	wonder	\N	\N	\N
663	would like to ~?	\N	\N	\N
664	your	\N	\N	\N
665	That's too bad.	\N	\N	\N
666	 It is, isn't it? 	\N	\N	\N
667	 terribly	\N	\N	\N
668	 busy	\N	\N	\N
669	you	\N	\N	\N
670	would love to	\N	\N	\N
671	July	\N	\N	\N
672	holidays	\N	\N	\N
673	that sounds good	\N	\N	\N
674	 but 	\N	\N	\N
675	have to 	\N	\N	\N
676	ask	\N	\N	\N
677	aunt	\N	\N	\N
678	cousin	\N	\N	\N
679	fall	\N	\N	\N
680	I'm not too sure.	\N	\N	\N
681	they	\N	\N	\N
682	travel around	\N	\N	\N
683	Kyoto	\N	\N	\N
684	fantastic	\N	\N	\N
685	temples	\N	\N	\N
686	shrines	\N	\N	\N
687	had better	\N	\N	\N
688	make q reservation	\N	\N	\N
689	crowded	\N	\N	\N
690	 a lot of 	\N	\N	\N
691	 tourist 	\N	\N	\N
692	make sure	\N	\N	\N
693	ahead	\N	\N	\N
694	desk	\N	\N	\N
695	mess	\N	\N	\N
696	not that ~	\N	\N	\N
697	messy	\N	\N	\N
698	be about to	\N	\N	\N
699	start	\N	\N	\N
700	right away	\N	\N	\N
701	want･･･to ~	\N	\N	\N
702	throw away	\N	\N	\N
703	just a second	\N	\N	\N
704	after that	\N	\N	\N
705	put away	\N	\N	\N
706	colored pencil	\N	\N	\N
707	stop	\N	\N	\N
708	work on	\N	\N	\N
709	project	\N	\N	\N
710	grow up	\N	\N	\N
711	creative	\N	\N	\N
712	Oh yeah?	\N	\N	\N
713	become	\N	\N	\N
714	artist	\N	\N	\N
715	what kind of?	\N	\N	\N
716	be	\N	\N	\N
717	writer 	\N	\N	\N
718	or	\N	\N	\N
719	painter	\N	\N	\N
720	sound 	\N	\N	\N
721	exciting	\N	\N	\N
722	pilot	\N	\N	\N
723	dream	\N	\N	\N
724	this ~	\N	\N	\N
725	be from	\N	\N	\N
726	International　School	\N	\N	\N
727	a come	\N	\N	\N
728	april	\N	\N	\N
729	teacher	\N	\N	\N
730	England	\N	\N	\N
731	It was nice to meet you.	\N	\N	\N
732	go	1	G	\N
733	English	1	E	\N
734	plane	1	P	\N
735	foreign country	1	F	\N
736	foreigner	1	F	\N
737	French	1	F	\N
738	hotel	1	H	\N
739	Japanese	1	J	\N
740	go out	1	G	\N
741	country	1	C	\N
742	meet	1	M	\N
743	rest	1	R	\N
744	travel	1	T	\N
745	travel	1	T	\N
746	play	1	P	\N
747	embassy	1	E	\N
748	love	1	L	\N
749	like	1	L	\N
750	good	1	G	\N
751	run	1	R	\N
752	slowly	1	S	\N
753	poor	1	P	\N
754	walk	1	W	\N
755	swim	1	S	\N
756	fast	1	F	\N
757	jump	1	J	\N
758	sport	1	S	\N
759	hate	1	H	\N
760	pool	1	P	\N
761	bus	1	B	\N
762	bicycle	1	B	\N
763	crossroad	1	C	\N
764	road	1	R	\N
765	pond	1	P	\N
766	walk	1	W	\N
767	river	1	R	\N
768	taxi	1	T	\N
769	car	1	C	\N
770	turn	1	T	\N
771	tie	1	T	\N
772	dress shirt	1	D	\N
773	company	1	C	\N
774	suit	1	S	\N
775	do	1	D	\N
776	smoke	1	S	\N
777	phone	1	P	\N
778	work	1	W	\N
779	work	1	W	\N
780	busy	1	B	\N
781	library	1	L	\N
782	dictionary	1	D	\N
783	borrow	1	B	\N
784	newspaper	1	N	\N
785	read	1	R	\N
786	book	1	B	\N
787	copy	1	C	\N
788	copy	1	C	\N
789	magazine	1	M	\N
790		0		\N
791	beef	1	B	\N
792	cheap	1	C	\N
793	store	1	S	\N
794	expensive	1	E	\N
795	How many	1	H	\N
796	How much	1	H	\N
797	fruit	1	F	\N
798	vegetable	1	V	\N
799	fish	1	F	\N
800	pork	1	P	\N
801	chicken	1	C	\N
802	meat	1	M	\N
803	want	1	W	\N
804	hand	1	H	\N
805	vegetable shop	1	V	\N
806	key	1	K	\N
807	cooking	1	C	\N
808	go shopping	1	G	\N
809	wash	1	W	\N
810	clean	1	C	\N
811	family	1	F	\N
812	home	1	H	\N
813	garden	1	G	\N
814	washing	1	W	\N
815	home	1	H	\N
816	house	1	H	\N
817	cleaning	1	C	\N
818	go home	1	G	\N
819	bookshelf	1	B	\N
820	desk	1	D	\N
821	chair	1	C	\N
822	room	1	R	\N
823	fridge	1	F	\N
824	wash	1	W	\N
825	bed	1	B	\N
826	radio	1	R	\N
827	radio-cassette player	1	R	\N
828	My name is	1	M	\N
829	go to bed	1	G	\N
830	get up	1	G	\N
831	table	1	T	\N
832	TV	1	T	\N
833	officer	1	O	\N
834	police officer	1	P	\N
835	map	1	M	\N
836	by	1	B	\N
837	here	1	H	\N
838	there	1	T	\N
839	there	1	T	\N
840	where	1	W	\N
841	police box	1	P	\N
842	near	1	N	\N
843	next	1	N	\N
844	ask	1	A	\N
845	cut	1	C	\N
846	short	1	S	\N
847	back	1	B	\N
848	front	1	F	\N
849	right	1	R	\N
850	left	1	L	\N
851	long	1	L	\N
852	sit	1	S	\N
853	stand	1	S	\N
854	friend	1	F	\N
855	class	1	C	\N
856	classroom	1	C	\N
857	corridor	1	C	\N
858	school	1	S	\N
859	student	1	S	\N
860	study	1	S	\N
861	student	1	S	\N
862	foreign student	1	F	\N
863	summer holiday	1	S	\N
864	teacher	1	T	\N
865	university	1	U	\N
866	notebook	1	N	\N
867	class	1	C	\N
868	composition	1	C	\N
869	homework	1	H	\N
870	difficult	1	D	\N
871	teach	1	T	\N
872	exam	1	E	\N
873	practice	1	P	\N
874	easy	1	E	\N
875	practice	1	P	\N
876	question	1	Q	\N
877	problem	1	P	\N
878	answer	1	A	\N
879	hurt	1	H	\N
880	tooth	1	T	\N
881	doctor	1	D	\N
882	hospital	1	H	\N
883	illness	1	I	\N
884	medicine	1	M	\N
885	die	1	D	\N
886	cold	1	C	\N
887	head	1	H	\N
888	stomach	1	S	\N
889	degree	1	D	\N
890	elevator	1	E	\N
891	ticket	1	T	\N
892	get off	1	G	\N
893	stair	1	S	\N
894	close	1	C	\N
895	station	1	S	\N
896	subway	1	S	\N
897	get on	1	G	\N
898	open	1	O	\N
899	restroom	1	R	\N
900	toilet	1	T	\N
901	train	1	T	\N
902	drink	1	D	\N
903	coffee	1	C	\N
904	coffee shop	1	C	\N
905	lemon	1	L	\N
906	milk	1	M	\N
907	sugar	1	S	\N
908	cup	1	C	\N
909	green tea	1	G	\N
910	tea	1	T	\N
911	glass	1	G	\N
912	put	1	P	\N
913	sweet	1	S	\N
914	drink	1	D	\N
915	chopsticks	1	C	\N
916	alcohol	1	A	\N
917	delicious	1	D	\N
918	knife	1	K	\N
919	spoon	1	S	\N
920	fork	1	F	\N
921	cheese	1	C	\N
922	eat	1	E	\N
923	terrible	1	T	\N
924	bread	1	B	\N
925	hot	1	H	\N
926	restaurant	1	R	\N
927	dining room	1	D	\N
928	wine	1	W	\N
929	food	1	F	\N
930	curry	1	C	\N
931	money	1	M	\N
932	bank	1	B	\N
933	entrance	1	E	\N
934	please, You're welcome.	0	P, Y	\N
935	no	1	N	\N
936	yes	1	Y	\N
937	Excuse me.	1	E	\N
938	please	1	P	\N
939	exit	1	E	\N
940	arrive	1	A	\N
941	mailbox	1	M	\N
942	postcard	1	P	\N
943	stick	1	S	\N
944	envelope	1	E	\N
945	letter	1	L	\N
946	post office	1	P	\N
947	return	1	R	\N
948	send	1	S	\N
949	stamp	1	S	\N
950	baggage	1	B	\N
951		0		\N
952	lend	1	L	\N
953	buy	1	B	\N
954	cap	1	C	\N
955	shoe	1	S	\N
956	shopping	1	S	\N
957	floor	1	F	\N
958	department store	1	D	\N
959	skirt	1	S	\N
960	coat	1	C	\N
961	pants	1	P	\N
962	sweater	1	S	\N
963	please	1	P	\N
964	bag	1	B	\N
965	sell	1	S	\N
966	jacket	1	J	\N
967	bath	1	B	\N
968	building	1	B	\N
969	kitchen	1	K	\N
970	shower	1	S	\N
971	window	1	W	\N
972	live	1	L	\N
973	park	1	P	\N
974	door	1	D	\N
975	take a bath	1	T	\N
976	apartment	1	A	\N
977	hall	1	H	\N
978	he, she	0	H, S	\N
979	they	1	T	\N
980	I	1	I	\N
981	we	1	W	\N
982	someone	1	S	\N
983	who	1	W	\N
984	who	1	W	\N
985	you	1	Y	\N
986	you	1	Y	\N
987	this	1	T	\N
988	that	1	T	\N
989	how	1	H	\N
990	which	1	W	\N
991	what	1	W	\N
992	such	1	S	\N
993	oneself	1	O	\N
994	so	1	S	\N
995	thick	1	T	\N
996	narrow	1	N	\N
997	thin	1	T	\N
998	big	1	B	\N
999	thick	1	T	\N
1000	young	1	Y	\N
1001	large	1	L	\N
1002	light	1	L	\N
1003	far	1	F	\N
1004	heavy	1	H	\N
1005	thin	1	T	\N
1006	new	1	N	\N
1007	small	1	S	\N
1008	near	1	N	\N
1009	old	1	O	\N
1010	happy	1	H	\N
1011	busy	1	B	\N
1012	low	1	L	\N
1013	good	1	G	\N
1014	bright	1	B	\N
1015	weak	1	W	\N
1016	strong	1	S	\N
1017	interesting	1	I	\N
1018	clean	1	C	\N
1019	late	1	L	\N
1020	bad	1	B	\N
1021	many	1	M	\N
1022	dark	1	D	\N
1023	quiet	1	Q	\N
1024	few	1	F	\N
1025	dirty	1	D	\N
1026	boring	1	B	\N
1027	side	1	S	\N
1028	in	1	I	\N
1029	outside	1	O	\N
1030	east	1	E	\N
1031	height	1	H	\N
1032	vertical	1	V	\N
1033	north	1	N	\N
1034	west	1	W	\N
1035	down	1	D	\N
1036	south	1	S	\N
1037	up	1	U	\N
1038	ahead	1	A	\N
1039	after	1	A	\N
1040	cousin	1	C	\N
1041	brother	1	B	\N
1042	brother	1	B	\N
1043	grandmother	1	G	\N
1044	grandfather	1	G	\N
1045	wife	1	W	\N
1046	mother	1	M	\N
1047	uncle	1	U	\N
1048	parents	1	P	\N
1049	father	1	F	\N
1050	sister	1	S	\N
1051	sister	1	S	\N
1052	aunt	1	A	\N
1053	brother	1	B	\N
1054	sister	1	S	\N
1055	dad	1	D	\N
1056	mom	1	M	\N
1057	sock	1	S	\N
1058	shirt	1	S	\N
1059	take off	1	T	\N
1060	hang	1	H	\N
1061	put on	1	P	\N
1062	put on	1	P	\N
1063	put on	1	P	\N
1064	handkerchief	1	H	\N
1065	slipper	1	S	\N
1066	umbrella	1	U	\N
1067	pocket	1	P	\N
1068	wallet	1	W	\N
1069	wear	1	W	\N
1070	clothes	1	C	\N
1071	dress	1	D	\N
1072	mouth	1	M	\N
1073	arm	1	A	\N
1074	body	1	B	\N
1075	face	1	F	\N
1076	leg	1	L	\N
1077	hand	1	H	\N
1078	nose	1	N	\N
1079	eye	1	E	\N
1080	ear	1	E	\N
1081	foot	1	F	\N
1082	stomach	1	S	\N
1083	dish	1	D	\N
1084	butter	1	B	\N
1085	teacup	1	T	\N
1086	candy	1	C	\N
1087	lunch	1	L	\N
1088	dinner	1	D	\N
1089	sweet	1	S	\N
1090	egg	1	E	\N
1091	breakfast	1	B	\N
1092	rice	1	R	\N
1093	soy sauce	1	S	\N
1094	salt	1	S	\N
1095	dinner	1	D	\N
1096	add	1	A	\N
1097	attach	1	A	\N
1098	camera	1	C	\N
1099	heater	1	H	\N
1100	pencil	1	P	\N
1101	erase	1	E	\N
1102	glasses	1	G	\N
1103	tape recorder	1	T	\N
1104	clock	1	C	\N
1105	computer	1	C	\N
1106	film	1	F	\N
1107	door	1	D	\N
1108	gate	1	G	\N
1109	pen	1	P	\N
1110	fountain pen	1	F	\N
1111	ballpoint pen	1	B	\N
1112	August	1	A	\N
1113	April	1	A	\N
1114	this month	1	T	\N
1115	every month	1	E	\N
1116	December	1	D	\N
1117	February	1	F	\N
1118	January	1	J	\N
1119	July	1	J	\N
1120	June	1	J	\N
1121	next month	1	N	\N
1122	May	1	M	\N
1123	March	1	M	\N
1124	last month	1	L	\N
1125	November	1	N	\N
1126	October	1	O	\N
1127	September	1	S	\N
1128	month	1	M	\N
1129	this week	1	T	\N
1130	every week	1	E	\N
1131	Sunday	1	S	\N
1132	Thursday	1	T	\N
1133	next week	1	N	\N
1134	Monday	1	M	\N
1135	Tuesday	1	T	\N
1136	Wednesday	1	W	\N
1137	Saturday	1	S	\N
1138	week	1	W	\N
1139	last week	1	L	\N
1140	Friday	1	F	\N
1141	year	1	Y	\N
1142	fall	1	F	\N
1143	this year	1	T	\N
1144	every year	1	E	\N
1145	summer	1	S	\N
1146	winter	1	W	\N
1147	last year	1	L	\N
1148	next year	1	N	\N
1149	spring	1	S	\N
1150	the year after next	1	T	\N
1151	the year before last	1	T	\N
1152	afternoon	1	A	\N
1153	today	1	T	\N
1154	tomorrow	1	T	\N
1155	time	1	T	\N
1156	yesterday	1	Y	\N
1157	evening	1	E	\N
1158	morning	1	M	\N
1159	morning	1	M	\N
1160	noon	1	N	\N
1161	night	1	N	\N
1162	evening	1	E	\N
1163	the day after tomorrow	1	T	\N
1164	the day before yesterday	1	T	\N
1165	already	1	A	\N
1166	while	1	W	\N
1167	yet	1	Y	\N
1168	whole	1	W	\N
1169	time	1	T	\N
1170	when	1	W	\N
1171	sometimes	1	S	\N
1172	often	1	O	\N
1173	time	1	T	\N
1174	soon	1	S	\N
1175	ashtray	1	A	\N
1176	song	1	S	\N
1177	sing	1	S	\N
1178	cigarette	1	C	\N
1179	movie	1	M	\N
1180	record	1	R	\N
1181	guitar	1	G	\N
1182	play	1	P	\N
1183	music	1	M	\N
1184	picture	1	P	\N
1185	picture	1	P	\N
1186	like	1	L	\N
1187	voice	1	V	\N
1188	fine	1	F	\N
1189	hot	1	H	\N
1190	clear	1	C	\N
1191	cool	1	C	\N
1192	cold	1	C	\N
1193	snow	1	S	\N
1194	rain	1	R	\N
1195	rain	1	R	\N
1196	weather	1	W	\N
1197	warm	1	W	\N
1198	wind	1	W	\N
1199	cloudy	1	C	\N
1200	cold	1	C	\N
1201	get cloudy	1	G	\N
1202	kanji	1	K	\N
1203	say	1	S	\N
1204	write	1	W	\N
1205	talk	1	T	\N
1206	language	1	L	\N
1207	language	1	L	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: en
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
1	Good morning	おはようございます	実用表現	\N	\N	\N	1	\N
2	how are you?	元気?	実用表現	\N	\N	\N	2	\N
3	Fine	元気	形容詞	\N	\N	\N	3	\N
4	a bit	ちょっと	名詞句	\N	\N	\N	3	\N
5	sleepy 	眠い	形容詞	\N	\N	\N	3	\N
6	also	～もまた	副詞	\N	\N	\N	5	\N
5	sleepy 	眠い	形容詞	\N	\N	\N	5	\N
7	reading	本を読む	動詞	\N	\N	\N	6	\N
8	 until late 	おそくまで	前置詞句	\N	\N	\N	6	\N
9	 last night 	ゆうべ	形容詞句	\N	\N	\N	6	\N
10	writing	書く	動詞	\N	\N	\N	7	\N
11	 E-mails 	Eメール	名詞	\N	\N	\N	7	\N
12	 friends 	友達	名詞	\N	\N	\N	7	\N
13	America	アメリカ	固有名詞	\N	\N	\N	7	\N
14	miss	さびしく感じる	動詞	\N	\N	\N	8	\N
15	Not really	それほどでもない	実用表現	\N	\N	\N	9	\N
16	because	なぜなら	接続詞	\N	\N	\N	9	\N
17	always	いつでも	副詞	\N	\N	\N	9	\N
18	talk 	話す	動詞	\N	\N	\N	9	\N
19	on the Internet 	インターネットで	前置詞句	\N	\N	\N	9	\N
20	different 	違う	動詞	\N	\N	\N	10	\N
21	first 	はじめて	副詞	\N	\N	\N	10	\N
22	Japan 	日本	固有名詞 	\N	\N	\N	10	\N
23	such 	そのような 	形容詞 	\N	\N	\N	11	\N
24	useful 	便利な	形容詞	\N	\N	\N	11	\N
25	technology	科学技術	名詞	\N	\N	\N	11	\N
26	then 	そのころ	副詞	\N	\N	\N	11	\N
27	smaller 	小さい	形容詞	\N	\N	\N	12	\N
28	world	世界	名詞	\N	\N	\N	12	\N
29	sure	確かである	形容詞	\N	\N	\N	13	\N
30	Hello	もしもし	間投詞	\N	\N	\N	14	\N
31	 Mr. Wilson 	ウイルソン先生	人名	\N	\N	\N	15	\N
32	This is ~.	こちらは～です	実用表現	\N	\N	\N	16	\N
30	Hello	やあ	間投詞	\N	\N	\N	17	\N
2	How are you?	元気ですか？	実用表現	\N	\N	\N	18	\N
33	Oh	ああ	間投詞	\N	\N	\N	19	\N
34	 get 	受け取る	動詞	\N	\N	\N	19	\N
35	letter	手紙	名詞	\N	\N	\N	19	\N
36	very	とても	副詞	\N	\N	\N	20	\N
37	nice	よい、すてきな	形容詞	\N	\N	\N	20	\N
38	Thank you.	ありがとう。	実用表現	\N	\N	\N	21	\N
39	very much	とても	副詞句	\N	\N	\N	21	\N
40	You're welcome.	どういたしまして。	実用表現	\N	\N	\N	22	\N
6	 Also	それから	接続詞	\N	\N	\N	23	\N
41	pictures	写真	名詞	\N	\N	\N	23	\N
42	beautiful	きれい	形容詞	\N	\N	\N	24	\N
43	Don't mention it.	どういたしまして	実用表現	\N	\N	\N	25	\N
44	really	ほんとうに	副詞	\N	\N	\N	26	\N
45	miss	～がいなくてさみしく思う	動詞	\N	\N	\N	26	\N
46	too	～もまた	副詞	\N	\N	\N	27	\N
47	everything	すべて	 代名詞	\N	\N	\N	28	\N
48	No problem. 	気にしないで	実用表現	\N	\N	\N	29	\N
49	thanks	ありがとう	 (間投詞的) 名詞	\N	\N	\N	30	\N
50	call	電話	名詞	\N	\N	\N	30	\N
51	It's my pleasure.	どういたしまして。	実用表現	\N	\N	\N	31	\N
52	goodbye	さようなら	間投詞	\N	\N	\N	32	\N
53	Excuse me	すみません	実用表現	\N	\N	\N	33	\N
54	help	助ける	動詞	\N	\N	\N	33	\N
55	 just 	ただ	副詞	\N	\N	\N	34	\N
56	 room 	部屋	名詞	\N	\N	\N	35	\N
57	 for 	～のため	前置詞	\N	\N	\N	35	\N
58	 staff 	スタッフ	名詞	\N	\N	\N	35	\N
59	only	だけ	形容詞	\N	\N	\N	35	\N
60	sorry	すみません	間投詞	\N	\N	\N	36	\N
61	 know 	知っている	動詞	\N	\N	\N	36	\N
62	OK	よろしい	副詞	\N	\N	\N	37	\N
63	 nothing 	何も~ない	代名詞	\N	\N	\N	37	\N
64	 special	特別な	形容詞	\N	\N	\N	37	\N
65	 anyway 	いずれにせよ	副詞	\N	\N	\N	37	\N
66	 I see 	わかった	実用表現	\N	\N	\N	38	\N
67	wait	待つ	動詞	\N	\N	\N	39	\N
68	 Excuse me. 	すみません	成句	\N	\N	\N	40	\N
69	How do I get to ~?	~へはどう行くのですか？	実用表現	\N	\N	\N	42	\N
70	cafeteria	カフェテリア	名詞	\N	\N	\N	42	\N
71	lost.	道に迷いました。	実用表現	\N	\N	\N	43	\N
72	Then	それなら	接続詞	\N	\N	\N	44	\N
73	 show	示す	動詞	\N	\N	\N	44	\N
74	way	行き方	名詞	\N	\N	\N	44	\N
75	Thanks a lot!	どうもありがとう	実用表現	\N	\N	\N	45	\N
76	Today	今日	名詞	\N	\N	\N	46	\N
77	new	新しい	形容詞	\N	\N	\N	46	\N
78	student	生徒	名詞	\N	\N	\N	46	\N
79	Hi	やあ	挨拶	\N	\N	\N	47	\N
80	name	名前	名詞	\N	\N	\N	47	\N
81	Nice to meet you	会えてうれしいです	実用表現	\N	\N	\N	48	\N
82	Please	どうぞ	間投詞	\N	\N	\N	49	\N
83	tell	言う、教える	動詞	\N	\N	\N	49	\N
84	class	クラス	名詞	\N	\N	\N	49	\N
85	about	～について	前置詞	\N	\N	\N	49	\N
86	yourself	あなた自身	再帰代名詞	\N	\N	\N	49	\N
62	OK	はい	副詞	\N	\N	\N	50	\N
87	Well	ええと	間投詞	\N	\N	\N	51	\N
88	came back	戻る	動詞句	\N	\N	\N	51	\N
89	America	アメリカ	固有名詞	\N	\N	\N	51	\N
90	Saint Louis	セントルイス	固有名詞	\N	\N	\N	51	\N
91	Missouri	ミズーリ州	固有名詞	\N	\N	\N	51	\N
92	last	前の	形容詞	\N	\N	\N	51	\N
93	month	月	名詞	\N	\N	\N	51	\N
94	hobbies	趣味	名詞	\N	\N	\N	52	\N
95	like	好き	動詞	\N	\N	\N	53	\N
96	playing	～する	動詞	\N	\N	\N	53	\N
97	baseball	野球	名詞	\N	\N	\N	53	\N
98	drawing	描く	動詞	\N	\N	\N	53	\N
41	pictures	絵	名詞	\N	\N	\N	53	\N
37	nice	すてき	形容詞	\N	\N	\N	54	\N
6	also	～も	副詞	\N	\N	\N	55	\N
99	making	作る	動詞	\N	\N	\N	55	\N
77	new	新しい	形容詞	\N	\N	\N	55	\N
100	friends	友達	名詞	\N	\N	\N	55	\N
101	Good	よい	間投詞	\N	\N	\N	56	\N
87	Well	それでは	間投詞	\N	\N	\N	57	\N
99	make	作る	動詞	\N	\N	\N	57	\N
102	a lot of	たくさんの	形容詞句	\N	\N	\N	57	\N
103	here	ここで	副詞	\N	\N	\N	57	\N
38	Thank you	ありがとう	実用表現	\N	\N	\N	58	\N
104	I’msorry.	ごめんなさい。	実用表現	\N	\N	\N	59	\N
105	late	遅い	形容詞	\N	\N	\N	59	\N
106	happened	起こる	動詞	\N	\N	\N	60	\N
107	took	乗る	動詞	\N	\N	\N	61	\N
108	wrong	違う	形容詞	\N	\N	\N	61	\N
109	train	電車	名詞	\N	\N	\N	61	\N
110	so	とても	副詞	\N	\N	\N	62	\N
111	That happens	そういうこともあるよ。	実用表現	\N	\N	\N	63	\N
112	But	でも	接続詞	\N	\N	\N	64	\N
113	could have	できたかもしれない	助動詞句	\N	\N	\N	64	\N
50	called	電話する	動詞	\N	\N	\N	64	\N
114	wanted to	～したい	動詞句	\N	\N	\N	65	\N
115	know	知っている	動詞	\N	\N	\N	65	\N
116	number	（電話）番号	名詞	\N	\N	\N	65	\N
117	should have	～すべきであったのに	助動詞句	\N	\N	\N	67	\N
83	told	言う	動詞	\N	\N	\N	67	\N
118	fault	落ち度、せい	名詞	\N	\N	\N	68	\N
119	Anyway	とにかく	副詞	\N	\N	\N	69	\N
120	careful	気をつけて	形容詞	\N	\N	\N	69	\N
121	have to	～しなければならない	助動詞句	\N	\N	\N	70	\N
122	apologize	お詫びを言う	動詞	\N	\N	\N	70	\N
123	all of 	～のすべて	形容詞句	\N	\N	\N	70	\N
124	kept waiting	～し続ける	動詞句	\N	\N	\N	71	\N
67	waiting	待つ	動詞	\N	\N	\N	71	\N
125	half an hour	半時間、30分	名詞句	\N	\N	\N	71	\N
126	That's all right.	だいじょうぶ、気にしなくていいよ。	実用表現	\N	\N	\N	72	\N
127	had fun	楽しむ	動詞句	\N	\N	\N	73	\N
128	talking	話す	動詞	\N	\N	\N	73	\N
129	with each other	お互いに	前置詞句	\N	\N	\N	73	\N
130	'm glad.	良かったと思う	実用表現	\N	\N	\N	74	\N
131	hear	聞く	動詞	\N	\N	\N	74	\N
132	Let’s	～しましょう	動詞句	\N	\N	\N	75	\N
72	then	じゃあ	副詞	\N	\N	\N	75	\N
133	get started	始める	動詞句	\N	\N	\N	75	\N
127	having fun	楽しむ	動詞句	\N	\N	\N	76	\N
134	Yeah	うん	間投詞	\N	\N	\N	77	\N
100	friends	友達	名詞	\N	\N	\N	78	\N
135	great	すばらしい	形容詞	\N	\N	\N	78	\N
136	Thanks	ありがとう	実用表現	\N	\N	\N	79	\N
103	Here	どうぞ	副詞	\N	\N	\N	80	\N
137	for	～のため	前置詞	\N	\N	\N	81	\N
138	from	～から	前置詞	\N	\N	\N	82	\N
123	all of	～みんな	形容詞句	\N	\N	\N	82	\N
139	What	何	疑問詞	\N	\N	\N	83	\N
140	open	開ける	動詞	\N	\N	\N	84	\N
29	Sure	もちろん	副詞	\N	\N	\N	85	\N
141	origami paper	折り紙	複合名詞	\N	\N	\N	86	\N
99	make	作る	名詞句	\N	\N	\N	87	\N
142	different	いろいろな	形容詞	\N	\N	\N	87	\N
143	things	もの	名詞	\N	\N	\N	87	\N
44	really	とても	副詞	\N	\N	\N	88	\N
144	pretty	かわいい	形容詞	\N	\N	\N	88	\N
145	 Thanks a lot!	どうもありがとう	実用表現	\N	\N	\N	89	\N
6	also	～も	副詞	\N	\N	\N	91	\N
146	wow	わあ	間投詞	\N	\N	\N	93	\N
147	paper crane	紙で作った鶴	複合名詞	\N	\N	\N	94	\N
42	beautiful	きれい	形容詞	\N	\N	\N	95	\N
130	n'glad	うれしく思う	動詞句	\N	\N	\N	96	\N
95	like	気に入る	動詞	\N	\N	\N	96	\N
38	Thank you	ありがとう	実用表現	\N	\N	\N	97	\N
148	’ve got to	～しなければならない	助動詞句	\N	\N	\N	98	\N
149	go	行く	動詞	\N	\N	\N	98	\N
150	now	いま	副詞	\N	\N	\N	98	\N
151	flight	（飛行機の）便	名詞	\N	\N	\N	99	\N
152	thank you 	ありがとう	実用表現	\N	\N	\N	100	\N
47	everything	すべて	名詞	\N	\N	\N	100	\N
153	It was my pleasure.	どういたしまして。	実用表現	\N	\N	\N	101	\N
52	Goodbye	さようなら	間投詞	\N	\N	\N	102	\N
154	’ll	～する（つもり）	助動詞	\N	\N	\N	102	\N
10	write	（手紙を）書く	動詞	\N	\N	\N	102	\N
52	Goodbye	さようなら	間投詞	\N	\N	\N	103	\N
155	take care	気をつけて	実用表現	\N	\N	\N	103	\N
82	please	どうぞ	間投詞	\N	\N	\N	104	\N
156	give my best regards to	～によろしく伝える	実用表現	\N	\N	\N	104	\N
157	family	家族	名詞	\N	\N	\N	104	\N
100	friends	友達	名詞	\N	\N	\N	104	\N
158	will	～するつもり	助動詞	\N	\N	\N	105	\N
158	’ll	～するつもり	助動詞	\N	\N	\N	106	\N
159	visit	訪ねる	動詞	\N	\N	\N	106	\N
13	America	アメリカ	固有名詞	\N	\N	\N	106	\N
160	again	また	副詞	\N	\N	\N	106	\N
161	someday	いつか	名詞	\N	\N	\N	106	\N
110	So	それでは	接続詞	\N	\N	\N	107	\N
162	see	会う	動詞	\N	\N	\N	107	\N
163	there	そこ	指示代名詞	\N	\N	\N	107	\N
72	then	そのときに	副詞	\N	\N	\N	107	\N
164	Bye	さよなら	間投詞	\N	\N	\N	108	\N
165	for now	とりあえず	実用表現	\N	\N	\N	108	\N
166	 Have a nice 	良い～を過ごして下さい	実用表現	\N	\N	\N	109	\N
151	flight	飛行機での旅	名詞	\N	\N	\N	109	\N
143	things	もの	名詞	\N	\N	\N	402	\N
167	Can I help you? 	何かお手伝いできることはありますか。いらっしゃいませ。	実用表現	\N	\N	\N	110	\N
168	How much	いくら	副詞句	\N	\N	\N	111	\N
169	map	地図	名詞	\N	\N	\N	111	\N
170	Australia	オーストラリア	固有名詞	\N	\N	\N	111	\N
171	yen	円	名詞	\N	\N	\N	112	\N
172	And	それから	接続詞	\N	\N	\N	113	\N
173	how about	～はどうですか？	実用表現	\N	\N	\N	113	\N
174	book	本	名詞	\N	\N	\N	113	\N
175	one	もの	代名詞	\N	\N	\N	114	\N
176	about	について	前置詞	\N	\N	\N	114	\N
177	Native Americans	アメリカ先住民族	固有名詞	\N	\N	\N	114	\N
178	looks	～に見える	動詞	\N	\N	\N	116	\N
179	interesting	おもしろい	形容詞	\N	\N	\N	116	\N
158	’ll	～するつもり	助動詞	\N	\N	\N	117	\N
107	take	買う	動詞	\N	\N	\N	117	\N
62	OK	はい	間投詞	\N	\N	\N	118	\N
110	so	それでは	接続詞	\N	\N	\N	118	\N
67	wait	待つ	動詞	\N	\N	\N	119	\N
59	only	～しか	副詞	\N	\N	\N	120	\N
180	have	持つ	動詞	\N	\N	\N	120	\N
158	’ll	～する	助動詞	\N	\N	\N	121	\N
99	make	～にする	動詞	\N	\N	\N	121	\N
72	then	それなら	副詞	\N	\N	\N	121	\N
135	 Great 	すごい、すばらしい	間投詞	\N	\N	\N	122	\N
38	Thank you	ありがとう	実用表現	\N	\N	\N	123	\N
181	Where	どこ	疑問詞	\N	\N	\N	124	\N
182	would you like to	～したいと思う	助動詞句	\N	\N	\N	124	\N
149	go	行く	動詞	\N	\N	\N	124	\N
183	’d like to	～したいと思う	助動詞句	\N	\N	\N	125	\N
184	Tokyo Dreamland	東京ドリームランド	固有名詞	\N	\N	\N	125	\N
185	Have you　ever been	行ったことがありますか？	実用表現	\N	\N	\N	127	\N
186	’ve been there	そこに行ったことがある。	実用表現	\N	\N	\N	128	\N
187	times	回	名詞	\N	\N	\N	128	\N
188	a lot	たくさん	成句	\N	\N	\N	130	\N
87	Well	でも	間投詞	\N	\N	\N	131	\N
189	one of 	～うちのひとつ(ひとり)	熟語	\N	\N	\N	131	\N
190	classmates	クラスメイト	名詞	\N	\N	\N	131	\N
186	has been there	そこに行ったことがある。	実用表現	\N	\N	\N	131	\N
191	more than	~以上	形容詞句	\N	\N	\N	131	\N
192	 unbelievable 	信じがたい	形容詞	\N	\N	\N	132	\N
193	’d	～するだろう	助動詞	\N	\N	\N	133	\N
194	get bored	飽きる	動詞句	\N	\N	\N	133	\N
15	Not really	それほどでもない	実用表現	\N	\N	\N	134	\N
195	fun	楽しい	形容詞	\N	\N	\N	135	\N
196	every time	毎回	実用表現	\N	\N	\N	135	\N
72	Then	それなら	副詞	\N	\N	\N	136	\N
197	must	～すべき	助動詞	\N	\N	\N	136	\N
149	go	行く	動詞	\N	\N	\N	136	\N
198	at least	少なくとも	前置詞句	\N	\N	\N	136	\N
199	once	一度	副詞	\N	\N	\N	136	\N
200	enjoying	楽しむ	動詞	\N	\N	\N	137	\N
201	game	試合	名詞	\N	\N	\N	137	\N
134	Yeah	うん	間投詞	\N	\N	\N	138	\N
202	just	ちょっと	副詞	\N	\N	\N	138	\N
203	thinking	考える	動詞	\N	\N	\N	138	\N
176	about ~	～について	前置詞	\N	\N	\N	138	\N
204	summer vacation	夏休み	名詞句	\N	\N	\N	138	\N
205	do you have ~?	～がある？	実用表現	\N	\N	\N	139	\N
206	any	なにか	形容詞	\N	\N	\N	139	\N
207	plans	予定	名詞	\N	\N	\N	139	\N
134	Yeah	うん	間投詞	\N	\N	\N	140	\N
208	am going to ~	~する予定	助動詞句	\N	\N	\N	140	\N
209	spend	過ごす	動詞	\N	\N	\N	140	\N
187	time	時間	名詞	\N	\N	\N	140	\N
210	with	といっしょに	前置詞	\N	\N	\N	140	\N
100	friend	友だち	動詞	\N	\N	\N	140	\N
13	America	アメリカ	固有名詞	\N	\N	\N	140	\N
211	coming	来る	動詞	\N	\N	\N	141	\N
22	Japan	日本	固有名詞	\N	\N	\N	141	\N
212	Uh-huh	うん	間投詞	\N	\N	\N	142	\N
211	coming	来る	動詞	\N	\N	\N	142	\N
213	in	～（以）内に	前置詞	\N	\N	\N	142	\N
214	weeks	週	名詞	\N	\N	\N	142	\N
215	sounds	~に思われる	動詞	\N	\N	\N	143	\N
37	nice	いい	形容詞	\N	\N	\N	143	\N
216	can’t	～できない	助動詞句	\N	\N	\N	144	\N
67	wait	待つ	動詞	\N	\N	\N	144	\N
217	to come	～すること	不定詞句	\N	\N	\N	144	\N
211	come	来る	動詞	\N	\N	\N	144	\N
218	What about ~? 	～はどう？	実用表現	\N	\N	\N	145	\N
207	plans	予定	名詞	\N	\N	\N	146	\N
219	vacation	休暇	名詞	\N	\N	\N	146	\N
220	going back	戻る	動詞句	\N	\N	\N	147	\N
221	Switzerland	スイス	固有名詞	\N	\N	\N	147	\N
159	visit	訪ねる	動詞	\N	\N	\N	147	\N
222	grandma	おばあちゃん	名詞	\N	\N	\N	147	\N
223	grandpa	おじいちゃん	名詞	\N	\N	\N	147	\N
224	looking forward to 	~を楽しみにする	実用表現	\N	\N	\N	148	\N
225	should	～にちがいない	助動詞	\N	\N	\N	149	\N
195	fun	楽しい	形容詞	\N	\N	\N	149	\N
226	dad	お父さん	名詞	\N	\N	\N	150	\N
227	leaves	出発する	動詞	\N	\N	\N	150	\N
228	home	家	名詞	\N	\N	\N	150	\N
110	so	とても	副詞	\N	\N	\N	150	\N
229	early	早く	副詞	\N	\N	\N	150	\N
230	office	会社	名詞	\N	\N	\N	151	\N
231	rather	かなり、けっこう	副詞	\N	\N	\N	151	\N
232	far	遠い	形容詞	\N	\N	\N	151	\N
228	home	家	名詞	\N	\N	\N	151	\N
233	How far is ~?	～はどのくらい遠い？	実用表現	\N	\N	\N	152	\N
176	about	およそ	前置詞	\N	\N	\N	153	\N
234	hour	時間	名詞	\N	\N	\N	153	\N
109	train	電車	名詞	\N	\N	\N	153	\N
232	far	遠い	形容詞	\N	\N	\N	155	\N
173	How about	～はどう？	実用表現	\N	\N	\N	156	\N
235	father	お父さん	名詞	\N	\N	\N	156	\N
236	house	家	名詞	\N	\N	\N	157	\N
237	minute	分	名詞	\N	\N	\N	158	\N
238	drive	車での行程	名詞	\N	\N	\N	158	\N
37	nice	良い	形容詞	\N	\N	\N	159	\N
239	No wonder	～で道理だ	実用表現	\N	\N	\N	160	\N
240	seems	~に見える	動詞	\N	\N	\N	160	\N
241	be tired	疲れている	動詞句	\N	\N	\N	160	\N
242	everyday	毎日	名詞	\N	\N	\N	160	\N
134	Yeah	うん	間投詞	\N	\N	\N	161	\N
243	poor	気の毒な	形容詞	\N	\N	\N	161	\N
62	OK	だいじょうぶ	副詞	\N	\N	\N	162	\N
178	look	～に見える	動詞	\N	\N	\N	163	\N
244	tired	疲れた	動詞	\N	\N	\N	163	\N
134	Yeah	うん	疑問詞	\N	\N	\N	164	\N
245	a little bit	ちょっと	実用表現	\N	\N	\N	164	\N
246	What time is it?	何時？	実用表現	\N	\N	\N	165	\N
247	New York	ニューヨーク	固有名詞	\N	\N	\N	167	\N
248	Let me see	ええと	実用表現	\N	\N	\N	168	\N
249	A.m.	午前	副詞	\N	\N	\N	170	\N
250	p.m.	午後	副詞	\N	\N	\N	170	\N
249	a.m.	午前	副詞	\N	\N	\N	171	\N
163	there	そこ	指示代名詞	\N	\N	\N	171	\N
251	after	～過ぎ	前置詞	\N	\N	\N	172	\N
252	midnight	真夜中	名詞	\N	\N	\N	172	\N
146	Wow	うわあ	間投詞	\N	\N	\N	173	\N
253	That’s why	だから～だ	成句	\N	\N	\N	174	\N
241	’re tired	疲れている	形容詞	\N	\N	\N	174	\N
254	I know.	そうだね。	実用表現	\N	\N	\N	175	\N
255	What time ~?	何時に～?	実用表現	\N	\N	\N	176	\N
256	go to bed	就寝する	動詞句	\N	\N	\N	176	\N
257	Will you	～してくれる？	実用表現	\N	\N	\N	177	\N
258	send	送る	動詞	\N	\N	\N	177	\N
259	ticket	チケット	名詞	\N	\N	\N	177	\N
72	then	それでは	副詞	\N	\N	\N	177	\N
260	All right	いいよ	実用表現	\N	\N	\N	178	\N
261	Write down	書き留める	動詞句	\N	\N	\N	178	\N
262	address	住所	名詞	\N	\N	\N	178	\N
103	here	ここに	副詞	\N	\N	\N	178	\N
29	Sure	もちろん	副詞	\N	\N	\N	179	\N
263	What’s 	～は何?	実用表現	\N	\N	\N	180	\N
264	zip code	郵便番号	複合名詞	\N	\N	\N	180	\N
265	something	何か	名詞	\N	\N	\N	181	\N
266	always	いつも	副詞	\N	\N	\N	182	\N
267	forget	忘れる	動詞	\N	\N	\N	182	\N
115	know	知っている	動詞	\N	\N	\N	183	\N
268	yours	あなたの（もの）	代名詞	\N	\N	\N	183	\N
269	Mine	私の（もの）	代名詞	\N	\N	\N	184	\N
110	So	それで	副詞	\N	\N	\N	185	\N
268	yours	あなたの（もの）	代名詞	\N	\N	\N	185	\N
270	think	~だと思う	動詞	\N	\N	\N	186	\N
112	but	でも	接続詞	\N	\N	\N	186	\N
271	not	～ではない	副詞	\N	\N	\N	186	\N
29	sure	確か	形容詞	\N	\N	\N	186	\N
50	call	電話する	動詞	\N	\N	\N	187	\N
272	later	あとで	副詞	\N	\N	\N	187	\N
273	Okay	いいよ	間投詞	\N	\N	\N	188	\N
72	then	そうしたら	副詞	\N	\N	\N	189	\N
136	Thanks.	ありがとう	間投詞	\N	\N	\N	190	\N
274	No problem.	問題ない、かまわない	実用表現	\N	\N	\N	191	\N
203	think	思う	動詞	\N	\N	\N	192	\N
275	drawing	（線で描いた）絵	名詞	\N	\N	\N	192	\N
276	finished	終える	動詞	\N	\N	\N	192	\N
203	think	思う	動詞	\N	\N	\N	193	\N
110	so	そのように	副詞	\N	\N	\N	193	\N
46	too	～も	副詞	\N	\N	\N	193	\N
277	Let’s	～しよう	動詞句	\N	\N	\N	194	\N
278	color it in	~をぬりつぶす	動詞句	\N	\N	\N	194	\N
279	should	~すべき	助動詞	\N	\N	\N	195	\N
280	use	使う	動詞	\N	\N	\N	195	\N
281	sky	空	名詞	\N	\N	\N	195	\N
282	can	～できる	助動詞	\N	\N	\N	196	\N
283	fill it in	~を（描いて）埋める	動詞句	\N	\N	\N	196	\N
284	with	～で	前置詞	\N	\N	\N	196	\N
285	blue	青い	形容詞	\N	\N	\N	196	\N
286	marker	マーカーペン	名詞	\N	\N	\N	196	\N
287	O.K.	わかった	間投詞	\N	\N	\N	197	\N
288	why don’t you ~?	～したらどうか？	実用表現	\N	\N	\N	198	\N
289	paint	塗る	動詞	\N	\N	\N	198	\N
290	trees	木	名詞	\N	\N	\N	198	\N
291	spray	スプレー式の	形容詞	\N	\N	\N	198	\N
260	Alright	いいよ	副詞	\N	\N	\N	199	\N
292	 What about~? 	～はどう？	実用表現	\N	\N	\N	200	\N
293	flowers	花	名詞	\N	\N	\N	200	\N
282	can	～できる	助動詞	\N	\N	\N	201	\N
278	color them in	~をぬりつぶす	動詞句	\N	\N	\N	201	\N
294	red	赤い	形容詞	\N	\N	\N	201	\N
295	yellow	黄色い	形容詞	\N	\N	\N	201	\N
296	crayons	クレヨン	名詞	\N	\N	\N	201	\N
297	 Oops 	おっと	間投詞	\N	\N	\N	203	\N
298	made a mistake	まちがえる	実用表現	\N	\N	\N	204	\N
299	Don’t worry	心配しないで	実用表現	\N	\N	\N	205	\N
202	Just	ただ	副詞	\N	\N	\N	206	\N
300	cover	上からおおう	動詞	\N	\N	\N	206	\N
284	with	～で	前置詞	\N	\N	\N	206	\N
301	white	白い	形容詞	\N	\N	\N	206	\N
302	 a good idea	いい考え	実用表現	\N	\N	\N	207	\N
303	English	英語	名詞	\N	\N	\N	208	\N
36	very	とても	副詞	\N	\N	\N	208	\N
101	good	上手	形容詞	\N	\N	\N	208	\N
38	Thank you	ありがとう	実用表現	\N	\N	\N	209	\N
181	Where	どこ	疑問詞	\N	\N	\N	210	\N
304	learn	習う	動詞	\N	\N	\N	210	\N
305	lived	住む	動詞	\N	\N	\N	211	\N
306	abroad	海外に	副詞	\N	\N	\N	211	\N
307	for	～のあいだ	前置詞	\N	\N	\N	211	\N
308	a few	２、３の～	形容詞句	\N	\N	\N	211	\N
309	years	年	名詞	\N	\N	\N	211	\N
310	I see.	なるほど	実用表現	\N	\N	\N	212	\N
110	So	それでは	接続詞	\N	\N	\N	213	\N
282	can	～できる	助動詞	\N	\N	\N	213	\N
311	speak	話す	動詞	\N	\N	\N	213	\N
312	Japanese	日本語	名詞	\N	\N	\N	213	\N
303	English	英語	名詞	\N	\N	\N	213	\N
87	Well	まあ	間投詞	\N	\N	\N	214	\N
313	sort of 	いくぶん、のような	実用表現	\N	\N	\N	214	\N
206	any	何か	副詞	\N	\N	\N	215	\N
314	other	ほかの	形容詞	\N	\N	\N	215	\N
315	language	言葉	名詞	\N	\N	\N	215	\N
173	How about	～はどう？	実用表現	\N	\N	\N	217	\N
316	said	言う	動詞	\N	\N	\N	218	\N
317	from	～の出身	前置詞	\N	\N	\N	218	\N
318	Switzerland	スイス	固有名詞	\N	\N	\N	218	\N
282	can	～できる	助動詞	\N	\N	\N	220	\N
319	French	フランス語	名詞	\N	\N	\N	220	\N
320	German	ドイツ語	名詞	\N	\N	\N	220	\N
6	also	～もまた	副詞	\N	\N	\N	221	\N
321	some	いくらかの	形容詞	\N	\N	\N	221	\N
135	great	すごい	副詞	\N	\N	\N	222	\N
322	penguins	ペンギン	名詞	\N	\N	\N	223	\N
323	cute	かわいい	形容詞	\N	\N	\N	223	\N
44	really	本当に	副詞	\N	\N	\N	224	\N
324	funny	おもしろい	形容詞	\N	\N	\N	224	\N
181	where	どこに	疑問詞	\N	\N	\N	225	\N
325	all	皆	副詞	\N	\N	\N	225	\N
326	big	大きい	形容詞	\N	\N	\N	225	\N
327	animals	動物	名詞	\N	\N	\N	225	\N
328	Let me see.	ええとね	実用表現	\N	\N	\N	226	\N
329	there are	～がいる	実用表現	\N	\N	\N	227	\N
321	some	いくつかの	形容詞	\N	\N	\N	227	\N
330	elephants	象	名詞	\N	\N	\N	227	\N
103	here 	ここに	副詞	\N	\N	\N	227	\N
331	next to	～の隣に	副詞	\N	\N	\N	227	\N
332	monkeys	猿	名詞	\N	\N	\N	227	\N
135	Great	すばらしい	形容詞	\N	\N	\N	228	\N
132	Let’s	～しましょう	実用表現	\N	\N	\N	229	\N
333	go see	行って見る	動詞句	\N	\N	\N	229	\N
33	Oh	あっ	間投詞	\N	\N	\N	230	\N
178	look	見る	動詞	\N	\N	\N	230	\N
334	hippopotamus	カバ	名詞	\N	\N	\N	231	\N
335	rhinoceros	サイ	名詞	\N	\N	\N	231	\N
336	near	～のそば	副詞	\N	\N	\N	231	\N
46	too	も（また）	副詞	\N	\N	\N	231	\N
218	What about ~?	～についてはどうか	実用表現	\N	\N	\N	232	\N
337	lions	ライオン	名詞	\N	\N	\N	232	\N
338	at	（場所）に	前置詞	\N	\N	\N	233	\N
339	zoo	動物園	名詞	\N	\N	\N	233	\N
112	but	でも	接続詞	\N	\N	\N	234	\N
144	pretty	けっこう	副詞	\N	\N	\N	234	\N
340	far away	遠く離れている	副詞句	\N	\N	\N	234	\N
162	See	ほらね、見て	動詞	\N	\N	\N	235	\N
341	cool	すごい、かっこいい	副詞	\N	\N	\N	236	\N
342	close to	～の近く	品詞	\N	\N	\N	236	\N
343	snakes	ヘビ	名詞	\N	\N	\N	236	\N
344	want to	～したい	動詞句	\N	\N	\N	237	\N
149	go	行く	動詞	\N	\N	\N	237	\N
163	there	（あ）そこ	副詞	\N	\N	\N	237	\N
345	scary	おっかない	形容詞	\N	\N	\N	238	\N
38	thank you	ありがとう	実用表現	\N	\N	\N	239	\N
346	showing	示す	動詞	\N	\N	\N	239	\N
74	way	道順	名詞	\N	\N	\N	239	\N
347	No problem	どういたしまして	実用表現	\N	\N	\N	240	\N
348	thirsty	のどが渇く	形容詞	\N	\N	\N	241	\N
78	student	生徒	名詞	\N	\N	\N	242	\N
103	here	ここで、ここの	副詞	\N	\N	\N	242	\N
349	what	何の、どの	疑問詞	\N	\N	\N	244	\N
350	grade	学年	名詞	\N	\N	\N	244	\N
351	fourth	４番目の	形容詞	\N	\N	\N	245	\N
350	grade	学年	名詞	\N	\N	\N	245	\N
352	How about you?	あなたはどうですか。	実用表現	\N	\N	\N	246	\N
353	fifth	５番目の	形容詞	\N	\N	\N	247	\N
354	grader	～年生の生徒	名詞	\N	\N	\N	247	\N
149	go	行く、通う	動詞	\N	\N	\N	248	\N
312	Japanese	日本の	形容詞	\N	\N	\N	248	\N
355	school	学校	名詞	\N	\N	\N	248	\N
303	English	英語	名詞	\N	\N	\N	250	\N
101	good	良い、うまい	形容詞	\N	\N	\N	250	\N
203	think	思う	動詞	\N	\N	\N	251	\N
225	should	～すべき	助動詞	\N	\N	\N	251	\N
34	get	手に入れる	動詞	\N	\N	\N	251	\N
174	book	本	名詞	\N	\N	\N	251	\N
101	good	良い	形容詞	\N	\N	\N	252	\N
356	idea	考え、アイディア	名詞	\N	\N	\N	252	\N
357	can’t	～できない	助動詞の否定形	\N	\N	\N	253	\N
7	read	読む	動詞	\N	\N	\N	253	\N
312	Japanese	日本語	名詞	\N	\N	\N	253	\N
173	how about ~?	～はどう	実用表現	\N	\N	\N	254	\N
358	video game	テレビゲーム	複合名詞	\N	\N	\N	254	\N
112	but	でも	接続詞	\N	\N	\N	255	\N
46	too	～すぎる	副詞	\N	\N	\N	255	\N
359	expensive	値段が高い	形容詞	\N	\N	\N	255	\N
134	Yeah	そうだね	副詞	\N	\N	\N	256	\N
360	right	正しい	形容詞	\N	\N	\N	256	\N
361	hmm	う～ん	間投詞	\N	\N	\N	257	\N
362	this	これ	指示詞	\N	\N	\N	257	\N
363	difficult	むずかしい	形容詞	\N	\N	\N	257	\N
364	could	～してもいい	助動詞	\N	\N	\N	258	\N
365	give	あげる	動詞	\N	\N	\N	258	\N
141	origami paper	折り紙	複合名詞	\N	\N	\N	258	\N
366	Isnt it?	そうでしょう？	実用表現	\N	\N	\N	260	\N
364	can	～できる、してもいい	助動詞	\N	\N	\N	261	\N
367	teach	教える	動詞	\N	\N	\N	261	\N
368	how to	～の仕方	実用表現	\N	\N	\N	261	\N
99	make	つくる	動詞	\N	\N	\N	261	\N
143	things	物	名詞	\N	\N	\N	261	\N
158	’ll	～だろう	助動詞	\N	\N	\N	262	\N
95	like	好きだ、気に入る	動詞	\N	\N	\N	262	\N
369	Ooo	うう、げえ	間投詞	\N	\N	\N	263	\N
370	natto	納豆	名詞	\N	\N	\N	263	\N
371	still	いまだに、まだ	副詞	\N	\N	\N	264	\N
357	can’t	～できない	否定形	\N	\N	\N	264	\N
372	get used to	～に慣れる	動詞句	\N	\N	\N	264	\N
373	smell	におい	名詞	\N	\N	\N	264	\N
374	’ve come to	～ようになった	動詞句	\N	\N	\N	265	\N
95	like	好きである	動詞	\N	\N	\N	265	\N
312	Japanese food	日本の食べ物、和食	複合名詞	\N	\N	\N	265	\N
188	a lot	とても	副詞句	\N	\N	\N	265	\N
375	true	真実だ	形容詞	\N	\N	\N	266	\N
376	For example	例えば	実用表現	\N	\N	\N	267	\N
150	now	今は	副詞	\N	\N	\N	267	\N
377	nori	のり	名詞	\N	\N	\N	267	\N
378	weird	妙な感じ、変な気分	形容詞	\N	\N	\N	268	\N
379	eating	食べる	動詞	\N	\N	\N	268	\N
380	black	黒い	形容詞	\N	\N	\N	268	\N
381	paper	紙	名詞	\N	\N	\N	268	\N
6	also	～も	副詞	\N	\N	\N	269	\N
382	shirasu	しらす	名詞	\N	\N	\N	269	\N
383	You ... , don’t you?	あなたは～でしょう。（確認）	実用表現	\N	\N	\N	269	\N
112	but	でも	接続詞	\N	\N	\N	270	\N
345	scary	こわい	形容詞	\N	\N	\N	270	\N
384	when	～のとき	接続詞	\N	\N	\N	270	\N
385	at first	初めは	形容詞句	\N	\N	\N	270	\N
162	saw	見る	動詞	\N	\N	\N	270	\N
362	these	これらの	指示詞	\N	\N	\N	270	\N
386	tiny	ちっちゃな	形容詞	\N	\N	\N	270	\N
387	eyes	目	名詞	\N	\N	\N	270	\N
349	What	なに	疑問詞	\N	\N	\N	271	\N
388	favorite	一番好きな	形容詞	\N	\N	\N	271	\N
361	hmm	うーん、えーと	間投詞	\N	\N	\N	272	\N
389	maybe	もしかしたら、～かな	副詞	\N	\N	\N	272	\N
390	yokan	ようかん	名詞	\N	\N	\N	272	\N
391	love	大好きだ	動詞	\N	\N	\N	273	\N
392	Yuck	げえっ	間投詞	\N	\N	\N	274	\N
393	hate	きらいだ	動詞	\N	\N	\N	275	\N
394	sweets	甘いもの	名詞	\N	\N	\N	275	\N
95	like	好きだ	動詞	\N	\N	\N	276	\N
395	that	あれ	指示詞	\N	\N	\N	276	\N
46	too	～も	副詞	\N	\N	\N	276	\N
396	Excuse me	え、何ですか。	実用表現	\N	\N	\N	277	\N
397	comic book	マンガ本	複合名詞	\N	\N	\N	278	\N
101	good	いい、よくできている	形容詞	\N	\N	\N	279	\N
7	reading	読む	動詞	\N	\N	\N	280	\N
398	American	アメリカの	形容詞	\N	\N	\N	280	\N
399	It’s ... , isn’t it?	それは～ですよね。（確認）	実用表現	\N	\N	\N	281	\N
195	fun	おもしろい、楽しい	形容詞	\N	\N	\N	281	\N
303	English	英語の	形容詞	\N	\N	\N	282	\N
400	practice	練習	名詞	\N	\N	\N	282	\N
46	too	～でもある	副詞	\N	\N	\N	282	\N
401	studying	勉強する	動詞	\N	\N	\N	283	\N
402	glad	よかったと思う	形容詞	\N	\N	\N	284	\N
176	about	～について	形容詞	\N	\N	\N	285	\N
97	baseball	野球	名詞	\N	\N	\N	285	\N
403	team	チーム	名詞	\N	\N	\N	285	\N
404	playing baseball	野球をする	動詞句	\N	\N	\N	286	\N
44	really	ほんとう、そう	副詞	\N	\N	\N	287	\N
405	I’ve ... played	～したことがある	実用表現	\N	\N	\N	288	\N
406	never	一度も～ない	副詞	\N	\N	\N	288	\N
112	but	でも	接続詞	\N	\N	\N	288	\N
407	watching	見る	動詞	\N	\N	\N	288	\N
144	pretty	けっこう、わりと	副詞	\N	\N	\N	289	\N
260	alright	いいよ	副詞	\N	\N	\N	290	\N
132	Let’s	～しましょう	動詞句	\N	\N	\N	291	\N
408	begin	始める	動詞	\N	\N	\N	291	\N
409	First	最初に	副詞	\N	\N	\N	292	\N
410	put	入れる	動詞	\N	\N	\N	292	\N
411	pancake mix	ホットケーキミックス	複合名詞	\N	\N	\N	292	\N
412	in	～の中に	前置詞	\N	\N	\N	292	\N
413	bowl	ボール	名詞	\N	\N	\N	292	\N
273	OK	オーケー、いいよ	副詞	\N	\N	\N	293	\N
72	then	それから	副詞	\N	\N	\N	294	\N
349	what	何	疑問詞	\N	\N	\N	294	\N
414	two	２個	形容詞	\N	\N	\N	295	\N
415	eggs	卵	名詞	\N	\N	\N	295	\N
172	and	そして	接続詞	\N	\N	\N	295	\N
321	some	いくらかの	形容詞	\N	\N	\N	295	\N
416	milk	ミルク	名詞	\N	\N	\N	295	\N
417	Done	やる	動詞	\N	\N	\N	296	\N
418	after	～のあと	前置詞	\N	\N	\N	297	\N
395	that	それ	指示詞	\N	\N	\N	297	\N
419	mix	混ぜる	動詞	\N	\N	\N	298	\N
325	all	すべて	副詞	\N	\N	\N	298	\N
420	together	一緒に	形容詞	\N	\N	\N	298	\N
421	got it	了解する、わかる	実用表現	\N	\N	\N	299	\N
417	do	する	動詞	\N	\N	\N	300	\N
422	Next	次に	副詞	\N	\N	\N	301	\N
423	pan	フライパン	名詞	\N	\N	\N	301	\N
424	flip	ひっくり返す	動詞	\N	\N	\N	301	\N
425	few	２，３の	形容詞	\N	\N	\N	301	\N
237	minutes	分	名詞	\N	\N	\N	301	\N
426				\N	\N	\N	302	\N
427	Finally	最後に	副詞	\N	\N	\N	303	\N
202	just	ただ、～だけ	副詞	\N	\N	\N	303	\N
67	wait	待つ	動詞	\N	\N	\N	303	\N
428	until	～するまで	副詞	\N	\N	\N	303	\N
429	ready	出来上がる	形容詞	\N	\N	\N	303	\N
215	sounds	～のように聞こえる、～そうだ	動詞	\N	\N	\N	304	\N
101	good	良い	形容詞	\N	\N	\N	304	\N
373	smells	においがする	動詞	\N	\N	\N	305	\N
135	great	すばらしい、とてもいい	形容詞	\N	\N	\N	305	\N
110	So	それで	接続詞	\N	\N	\N	306	\N
430	how	どうか、元気か	副詞	\N	\N	\N	306	\N
431	parents	親	名詞	\N	\N	\N	306	\N
112	but	でも	接続詞	\N	\N	\N	307	\N
44	really	本当に	副詞	\N	\N	\N	307	\N
432	busy	いそがしい	形容詞	\N	\N	\N	307	\N
433	brother	兄、弟	名詞	\N	\N	\N	308	\N
434	how is ... doing?	～はどうしている？	実用表現	\N	\N	\N	308	\N
273	OK	大丈夫、まあまあ	副詞	\N	\N	\N	309	\N
435	working	働く	動詞	\N	\N	\N	310	\N
338	at	～で	前置詞	\N	\N	\N	310	\N
436	bank	銀行	名詞	\N	\N	\N	310	\N
215	sounds	～そう、～のように聞こえる	動詞	\N	\N	\N	311	\N
437	boring	つまらない	形容詞	\N	\N	\N	311	\N
134	Yeah	うん	間投詞	\N	\N	\N	312	\N
95	likes	好きである	動詞	\N	\N	\N	312	\N
438	how about ... ?	～についてはどう？	実用表現	\N	\N	\N	313	\N
439	sister	妹、姉	名詞	\N	\N	\N	313	\N
426				\N	\N	\N	314	\N
440	doing well	元気にしている	実用表現	\N	\N	\N	315	\N
149	going	行く	名詞	\N	\N	\N	316	\N
441	to	～へ	前置詞	\N	\N	\N	316	\N
442	summer	夏	名詞	\N	\N	\N	316	\N
443	camp	キャンプ	名詞	\N	\N	\N	316	\N
150	now	今	副詞	\N	\N	\N	316	\N
395	That	それ	指示詞	\N	\N	\N	317	\N
341	cool	いい、かっこいい	形容詞	\N	\N	\N	317	\N
444	Billy	ビリー	固有名詞	\N	\N	\N	318	\N
445	dog	犬	名詞	\N	\N	\N	319	\N
101	good	元気、良い	形容詞	\N	\N	\N	320	\N
45	misses	いなくてさみしく思う	動詞	\N	\N	\N	320	\N
446	Are ... excited about	～を楽しみにしている	動詞句	\N	\N	\N	321	\N
447	picnic	ピクニック	名詞	\N	\N	\N	321	\N
362	this	この、今週の	指示詞	\N	\N	\N	321	\N
448	Saturday	土曜日	名詞	\N	\N	\N	321	\N
112	but	でも	接続詞	\N	\N	\N	322	\N
449	weather	天気	名詞	\N	\N	\N	322	\N
450	might	～かもしれない	助動詞	\N	\N	\N	322	\N
37	nice	良い	形容詞	\N	\N	\N	322	\N
451	Oh, no.	ええー、困ったなあ。	間投詞句	\N	\N	\N	323	\N
349	What	何	疑問詞	\N	\N	\N	324	\N
344	want to	～したい	動詞句	\N	\N	\N	324	\N
452	if	もし	接続詞	\N	\N	\N	324	\N
453	bad	悪い	形容詞	\N	\N	\N	324	\N
202	just	ただ、単に	副詞	\N	\N	\N	325	\N
454	cloudy	くもり	形容詞	\N	\N	\N	325	\N
455	should	～すべきだ	助動詞	\N	\N	\N	325	\N
371	still	それでもまだ	副詞	\N	\N	\N	325	\N
456	have the picnic	ピクニックをする	実用表現	\N	\N	\N	325	\N
457	What about ～ ?	～はどう？	実用表現	\N	\N	\N	326	\N
458	rains	雨が降る	動詞	\N	\N	\N	326	\N
132	let's	～しよう	動詞句	\N	\N	\N	327	\N
417	do	する	動詞	\N	\N	\N	327	\N
265	something	何か	形容詞	\N	\N	\N	327	\N
459	else	他に、それ以外の	副詞	\N	\N	\N	327	\N
95	like	例えば、～のような	形容詞	\N	\N	\N	328	\N
349	what	何	疑問詞	\N	\N	\N	328	\N
361	Hmm	うーんと	間投詞	\N	\N	\N	329	\N
87	Well	ええと、そうだなあ	間投詞	\N	\N	\N	329	\N
364	could	～してもいい	助動詞	\N	\N	\N	329	\N
162	see	見る	動詞	\N	\N	\N	329	\N
460	movie	映画	名詞	\N	\N	\N	329	\N
395	that	それ	指示詞	\N	\N	\N	330	\N
158	would	～だろう	助動詞	\N	\N	\N	330	\N
273	OK	オーケー、いい	副詞	\N	\N	\N	330	\N
461	I'd rather～	私はむしろ～したい。	実用表現	\N	\N	\N	331	\N
462	worry	心配する	動詞	\N	\N	\N	332	\N
260	alright	大丈夫	副詞	\N	\N	\N	333	\N
349	what	何	疑問詞	\N	\N	\N	334	\N
417	doing	する	動詞	\N	\N	\N	334	\N
98	drawing	描く	動詞	\N	\N	\N	335	\N
41	picture	絵	名詞	\N	\N	\N	335	\N
463	superhero	スーパーヒーロー	複合名詞	\N	\N	\N	336	\N
44	Really	本当に	副詞	\N	\N	\N	337	\N
464	Why	なぜ	疑問詞	\N	\N	\N	338	\N
110	so	そんなに、とても	副詞	\N	\N	\N	338	\N
465	super	すごい	形容詞	\N	\N	\N	338	\N
87	Well	えーと	間投詞	\N	\N	\N	339	\N
466	stronger	強い	形容詞	\N	\N	\N	339	\N
467	than	～よりも	接続詞	\N	\N	\N	339	\N
330	elephant	ゾウ	名詞	\N	\N	\N	339	\N
112	but	でも	接続詞	\N	\N	\N	340	\N
178	looks	～のように見える	動詞	\N	\N	\N	340	\N
27	small	小さい	形容詞	\N	\N	\N	340	\N
134	Yeah	うん、そうなんだ	副詞	\N	\N	\N	341	\N
468	human	人間	名詞	\N	\N	\N	341	\N
469	faster	速い	形容詞	\N	\N	\N	342	\N
46	too	～も	副詞	\N	\N	\N	342	\N
470	jet	ジェット機	名詞	\N	\N	\N	342	\N
471	smart	頭がいい	形容詞	\N	\N	\N	343	\N
29	sure	もちろん	副詞	\N	\N	\N	344	\N
472	computer	コンピューター	名詞	\N	\N	\N	345	\N
95	like	好き	動詞	\N	\N	\N	346	\N
473	clothes	服	名詞	\N	\N	\N	346	\N
341	coolest	かっこいい	形容詞	\N	\N	\N	347	\N
474	ever	今までに	副詞	\N	\N	\N	347	\N
162	seen	見る	動詞	\N	\N	\N	347	\N
475	Yep	うん、そうだ	副詞	\N	\N	\N	348	\N
101	best	良い	形容詞	\N	\N	\N	348	\N
132	Let's	～しましょう	動詞句	\N	\N	\N	349	\N
149	go	行く	動詞	\N	\N	\N	349	\N
476	mountains	山	名詞	\N	\N	\N	349	\N
362	this	この	指示詞	\N	\N	\N	349	\N
477	weekend	週末	名詞	\N	\N	\N	349	\N
478	don't know	どうしようかな、わからない。	実用表現	\N	\N	\N	350	\N
479	Come on.	行こうよ	慣用表現	\N	\N	\N	351	\N
480	It'll be～	～だろう	助動詞句	\N	\N	\N	352	\N
195	fun	楽しい	形容詞	\N	\N	\N	352	\N
364	can	～できる、してもいい	助動詞	\N	\N	\N	353	\N
481	go hiking	ハイキングをする	動詞句	\N	\N	\N	353	\N
134	Yeah	うん	副詞	\N	\N	\N	354	\N
112	but	でも	接続詞	\N	\N	\N	354	\N
44	really	ほんとうに	副詞	\N	\N	\N	354	\N
482	hot	暑い	形容詞	\N	\N	\N	354	\N
483	How about ―ing ?	～するのはどう？	実用表現	\N	\N	\N	355	\N
484	beach	ビーチ	名詞	\N	\N	\N	355	\N
395	That	それ	指示詞	\N	\N	\N	356	\N
215	sounds	聞こえる、～そうだ	動詞	\N	\N	\N	356	\N
95	like	～のようだ	副詞	\N	\N	\N	356	\N
273	OK	オーケー、いいよ	副詞	\N	\N	\N	357	\N
485	on	～に	前置詞	\N	\N	\N	358	\N
448	Saturday	土曜日	名詞	\N	\N	\N	358	\N
486	What about ーing ?	～するのはどう？	実用表現	\N	\N	\N	359	\N
487	Sunday	日曜日	名詞	\N	\N	\N	359	\N
488	Isn't there ... ?	～じゃない？	実用表現	\N	\N	\N	360	\N
489	festival	祭り	名詞	\N	\N	\N	360	\N
33	Oh	あっ	間投詞	\N	\N	\N	361	\N
267	forgot	忘れる	動詞	\N	\N	\N	362	\N
490	is going to	～だろう	助動詞	\N	\N	\N	363	\N
135	great	すばらしい	形容詞	\N	\N	\N	363	\N
216	can't	～できない	助動詞	\N	\N	\N	364	\N
67	wait	待つ	動詞	\N	\N	\N	364	\N
491	Let's	～しよう	動詞句	\N	\N	\N	365	\N
149	go	行く	動詞	\N	\N	\N	365	\N
492	outside	外に	副詞	\N	\N	\N	365	\N
172	and	そして	接続詞	\N	\N	\N	365	\N
493	play	遊ぶ	動詞	\N	\N	\N	365	\N
494	No	いいえ	間投詞	\N	\N	\N	366	\N
495	feel like	～する気分である	動詞句	\N	\N	\N	366	\N
496	Why not?	どうして？	成句	\N	\N	\N	367	\N
16	Because	～だから	接続詞	\N	\N	\N	368	\N
407	watching	見る	動詞	\N	\N	\N	368	\N
362	this	この	指示詞	\N	\N	\N	368	\N
497	video 	ビデオ	名詞	\N	\N	\N	368	\N
498	already	既に	副詞	\N	\N	\N	369	\N
162	seen	見る	動詞	\N	\N	\N	369	\N
499	a few	２，３の	形容詞句	\N	\N	\N	369	\N
187	times	～回	名詞	\N	\N	\N	369	\N
464	Why	なぜ	疑問詞	\N	\N	\N	370	\N
160	again	また	副詞	\N	\N	\N	370	\N
500	my 	私の	代名詞	\N	\N	\N	371	\N
388	favorite	お気に入りの	形容詞	\N	\N	\N	371	\N
398	American 	アメリカの	形容詞	\N	\N	\N	371	\N
460	movie	映画	名詞	\N	\N	\N	371	\N
101	good	良い	形容詞	\N	\N	\N	371	\N
303	English	英語の	形容詞	\N	\N	\N	371	\N
400	practice	練習	名詞	\N	\N	\N	371	\N
87	Well	それならば	間投詞	\N	\N	\N	372	\N
492	outside	外で	副詞	\N	\N	\N	372	\N
501	Why	なぜ	疑問詞	\N	\N	\N	373	\N
502	want to	～したい	動詞句	\N	\N	\N	373	\N
37	nice	良い	形容詞	\N	\N	\N	374	\N
503	sunny 	晴れた	形容詞	\N	\N	\N	374	\N
504	day	日	名詞	\N	\N	\N	374	\N
505	come on	ねえ、ほら	実用表現	\N	\N	\N	375	\N
506	go	行く	動詞	\N	\N	\N	376	\N
260	Alright	わかった	間投詞	\N	\N	\N	377	\N
202	Just	～だけ	副詞	\N	\N	\N	378	\N
507	wait a second	少し待って	実用表現	\N	\N	\N	378	\N
508	part	部分	名詞	\N	\N	\N	379	\N
135	great	すばらしい	形容詞	\N	\N	\N	379	\N
509	These	これらの	形容詞	\N	\N	\N	380	\N
510	scissors	はさみ	名詞	\N	\N	\N	380	\N
511	cut	切る	動詞	\N	\N	\N	380	\N
110	so	とても	副詞	\N	\N	\N	380	\N
87	well	よく	副詞	\N	\N	\N	380	\N
512	Can you ～?	～してくれる？	実用表現	\N	\N	\N	381	\N
513	lend	かす	動詞	\N	\N	\N	381	\N
514	me	私に	代名詞	\N	\N	\N	381	\N
395	those	それ	形容詞	\N	\N	\N	381	\N
515	Just a second.	ちょっと待って	実用表現	\N	\N	\N	382	\N
62	OK	オーケー、いいよ	間投詞	\N	\N	\N	383	\N
516	here you go.	どうぞ	実用表現	\N	\N	\N	383	\N
136	Thanks.	ありがとう	動詞	\N	\N	\N	384	\N
274	No problem.	問題ないよ、どういたしまして	実用表現	\N	\N	\N	385	\N
517	Will you～?	～してくれますか。	実用表現	\N	\N	\N	386	\N
518	pass	渡す	動詞	\N	\N	\N	386	\N
519	glue	のり	名詞	\N	\N	\N	386	\N
29	Sure	もちろん	副詞	\N	\N	\N	387	\N
520	Here you are.	どうぞ	実用表現	\N	\N	\N	388	\N
38	thank you	ありがとう	実用表現	\N	\N	\N	389	\N
521	Oh no!	しまった	実用表現	\N	\N	\N	390	\N
46	too	～しすぎ	副詞	\N	\N	\N	391	\N
232	far	遠い 	副詞	\N	\N	\N	391	\N
110	so 	それほど	副詞	\N	\N	\N	392	\N
453	bad	悪い	形容詞	\N	\N	\N	392	\N
389	maybe	もしかしたら	副詞	\N	\N	\N	393	\N
365	give	与える	動詞	\N	\N	\N	394	\N
522	tape	セロテープ	名詞	\N	\N	\N	394	\N
29	Sure	もちろん	間投詞	\N	\N	\N	395	\N
112	but	しかし	接続詞	\N	\N	\N	395	\N
357	can't	できない	助動詞	\N	\N	\N	395	\N
523	find	見つける	動詞	\N	\N	\N	395	\N
524	here it is.	ここにある	成句	\N	\N	\N	396	\N
349	What	何	疑問詞	\N	\N	\N	397	\N
525	kind	種類	名詞	\N	\N	\N	397	\N
526	store	店	名詞	\N	\N	\N	397	\N
395	that	あれ	指示詞	\N	\N	\N	397	\N
527	sell	売る	動詞	\N	\N	\N	399	\N
528	futon	ふとん	名詞	\N	\N	\N	399	\N
163	there	そこで	副詞	\N	\N	\N	399	\N
529	That's right.	その通り。	実用表現	\N	\N	\N	401	\N
314	other	他の	形容詞	\N	\N	\N	402	\N
46	too	～も	副詞	\N	\N	\N	402	\N
376	for example	たとえば	実用表現	\N	\N	\N	402	\N
530	sheets	シーツ	名詞	\N	\N	\N	402	\N
531	blankets	毛布	名詞	\N	\N	\N	402	\N
532	pillows	枕	名詞	\N	\N	\N	402	\N
172	And	そして	接続詞	\N	\N	\N	403	\N
533	what about～?	～はどう？	実用表現	\N	\N	\N	403	\N
395	that	あの	形容詞	\N	\N	\N	403	\N
526	store	店	名詞	\N	\N	\N	403	\N
534	What 	何を	疑問詞	\N	\N	\N	405	\N
527	sell	売る	動詞	\N	\N	\N	405	\N
527	sell	売る	動詞	\N	\N	\N	406	\N
535	lots of	たくさんの	形容詞句	\N	\N	\N	406	\N
143	things	もの	名詞	\N	\N	\N	406	\N
95	like	～のような	前置詞	\N	\N	\N	406	\N
536	buckets	バケツ	名詞	\N	\N	\N	406	\N
537	knives	ナイフ	名詞	\N	\N	\N	406	\N
538	tools	工具	名詞	\N	\N	\N	406	\N
539	ladders	はしご	名詞	\N	\N	\N	406	\N
110	so	それならば	接続詞	\N	\N	\N	407	\N
540	hardware	金物	名詞	\N	\N	\N	407	\N
526	store	店	名詞	\N	\N	\N	407	\N
541	kind of	～のような	熟語	\N	\N	\N	408	\N
395	That	あの	形容詞	\N	\N	\N	409	\N
542	rollercoaster	ジェットコースター	名詞	\N	\N	\N	409	\N
135	great	すごい	形容詞	\N	\N	\N	409	\N
543	Let's	～しよう	動詞句	\N	\N	\N	410	\N
544	go on	～に乗る	動詞句	\N	\N	\N	410	\N
160	again	また	副詞	\N	\N	\N	410	\N
452	If	もし	接続詞	\N	\N	\N	411	\N
545	we	私たち	代名詞	\N	\N	\N	411	\N
450	might	～かも	助動詞	\N	\N	\N	411	\N
34	get	～になる	動詞	\N	\N	\N	411	\N
546	sick	気持ち悪い	形容詞	\N	\N	\N	411	\N
349	what	何	疑問詞	\N	\N	\N	412	\N
344	want to	～したい	動詞句	\N	\N	\N	412	\N
72	then	それならば	接続詞	\N	\N	\N	412	\N
547	ride	乗る	動詞	\N	\N	\N	413	\N
548	Ferris Wheel	大観覧車	名詞	\N	\N	\N	413	\N
548	Ferris Wheel	大観覧車	名詞	\N	\N	\N	414	\N
418	after	~のあとで	前置詞	\N	\N	\N	414	\N
44	really	ほんとうに	副詞	\N	\N	\N	415	\N
3	fine	わかった	形容詞	\N	\N	\N	416	\N
326	big	大きな	形容詞	\N	\N	\N	416	\N
549	slide	すべり台	名詞	\N	\N	\N	416	\N
550	I guess so.	わかった。	実用表現	\N	\N	\N	417	\N
112	But	しかし	接続詞	\N	\N	\N	418	\N
551	only if	～の場合のみ	副詞句	\N	\N	\N	418	\N
34	get	～を手に入れる	動詞	\N	\N	\N	418	\N
552	ice cream	アイスクリーム	名詞	\N	\N	\N	418	\N
409	first	まず	副詞	\N	\N	\N	418	\N
553	It's a deal	交渉成立	実用表現	\N	\N	\N	419	\N
135	Great	やったー。	形容詞	\N	\N	\N	420	\N
149	go	行く	動詞	\N	\N	\N	421	\N
260	alright	良い	形容詞	\N	\N	\N	422	\N
452	if	もし	接続詞	\N	\N	\N	422	\N
554	change	替える	動詞	\N	\N	\N	422	\N
555	report	レポート	名詞	\N	\N	\N	422	\N
556	topic	題、トピック	名詞	\N	\N	\N	422	\N
557	dinosaurs	恐竜	名詞	\N	\N	\N	422	\N
558	pirates	海ぞく	名詞	\N	\N	\N	422	\N
29	Sure	もちろん	形容詞	\N	\N	\N	423	\N
344	want to	～したい	動詞句	\N	\N	\N	424	\N
559	go ahead	どうぞ	実用表現	\N	\N	\N	424	\N
560	May I～?	～してもいいか	実用表現	\N	\N	\N	425	\N
561	borrow	借りる	動詞	\N	\N	\N	425	\N
395	that	あの	指示詞	\N	\N	\N	425	\N
174	book	本	名詞	\N	\N	\N	425	\N
72	then	それならば	副詞	\N	\N	\N	425	\N
62	OK	オーケー	間投詞	\N	\N	\N	426	\N
562	make sure to～	～するように	実用表現	\N	\N	\N	426	\N
563	give back	返す	動詞句	\N	\N	\N	426	\N
274	No problem	心配しないで、問題ない	実用表現	\N	\N	\N	427	\N
564	enough～to...	...するのに十分な～	実用表現	\N	\N	\N	428	\N
187	time	時間	名詞	\N	\N	\N	428	\N
276	finish	終える	動詞	\N	\N	\N	428	\N
77	new	新しい	形容詞	\N	\N	\N	428	\N
565	I don't know.	わからない、どうかな	実用表現	\N	\N	\N	429	\N
566	Could I～?	～してもいいか？	実用表現	\N	\N	\N	430	\N
567	turn in	提出する	動詞句	\N	\N	\N	430	\N
418	after	～のあと	前置詞	\N	\N	\N	430	\N
568	summer	夏	名詞	\N	\N	\N	430	\N
219	vacation	休み	名詞	\N	\N	\N	430	\N
550	I guess so.	そうね	実用表現	\N	\N	\N	431	\N
265	something	何か	代名詞	\N	\N	\N	432	\N
569	matter	問題	名詞	\N	\N	\N	432	\N
44	really	本当に	副詞	\N	\N	\N	433	\N
112	but	でも	接続詞	\N	\N	\N	433	\N
149	go	行く	動詞	\N	\N	\N	433	\N
570	bathroom	手洗い	名詞	\N	\N	\N	433	\N
571	Of course	もちろん	熟語	\N	\N	\N	434	\N
500	My	私の	代名詞	\N	\N	\N	435	\N
100	friend	友達	名詞	\N	\N	\N	435	\N
572	invited	招待する	動詞	\N	\N	\N	435	\N
514	me	私を	代名詞	\N	\N	\N	435	\N
573	over	～に	前置詞	\N	\N	\N	435	\N
137	for	～のために	前置詞	\N	\N	\N	435	\N
574	dinner	夕食	名詞	\N	\N	\N	435	\N
112	but	でも	接続詞	\N	\N	\N	435	\N
29	sure	確か	副詞	\N	\N	\N	435	\N
312	Japanese	日本の	形容詞	\N	\N	\N	435	\N
575	manners	マナー	名詞	\N	\N	\N	435	\N
95	Like	～のような	前置詞	\N	\N	\N	436	\N
349	what	何	疑問詞	\N	\N	\N	436	\N
576	For instance	たとえば	実用表現	\N	\N	\N	437	\N
225	should	～べき	助動詞	\N	\N	\N	437	\N
577	bring	持っていく	動詞	\N	\N	\N	437	\N
265	something	何か	代名詞	\N	\N	\N	437	\N
578	Hmm	えーとね	間投詞	\N	\N	\N	438	\N
579	probably	たぶん	副詞	\N	\N	\N	438	\N
27	small	小さな	形容詞	\N	\N	\N	438	\N
95	like	～のような	前置詞	\N	\N	\N	438	\N
580	sweets	お菓子	名詞	\N	\N	\N	438	\N
349	What	何	疑問詞	\N	\N	\N	439	\N
581	need to～	～する必要がある	助動詞句	\N	\N	\N	439	\N
316	say	言う	動詞	\N	\N	\N	439	\N
384	when	～の時	接続詞	\N	\N	\N	439	\N
582	meet	会う	動詞	\N	\N	\N	439	\N
583	his	彼の	代名詞	\N	\N	\N	439	\N
431	parents	親	名詞	\N	\N	\N	439	\N
149	go	行く	動詞	\N	\N	\N	440	\N
584	into	～の中へ	前置詞	\N	\N	\N	440	\N
583	his 	彼の	代名詞	\N	\N	\N	440	\N
236	house	家	名詞	\N	\N	\N	440	\N
585	have to	～しなければならない	助動詞	\N	\N	\N	440	\N
533	What about～?	～はどうですか	実用表現	\N	\N	\N	441	\N
586	table manners	テーブルマナー	複合名詞	\N	\N	\N	441	\N
280	use	使う	動詞	\N	\N	\N	442	\N
587	chopsticks	はし	名詞	\N	\N	\N	442	\N
588	try to	～しようとする	動詞句	\N	\N	\N	443	\N
589	them 	それらを	代名詞	\N	\N	\N	443	\N
62	OK	わかった	間投詞	\N	\N	\N	444	\N
590	try	挑戦する	動詞	\N	\N	\N	444	\N
591	polite	礼儀正しい	形容詞	\N	\N	\N	445	\N
87	Well	まあね	間投詞	\N	\N	\N	446	\N
452	if	もし	接続詞	\N	\N	\N	446	\N
592	really	本当に	副詞	\N	\N	\N	446	\N
593	before	～の前に	前置詞	\N	\N	\N	446	\N
379	eat	食べる	動詞	\N	\N	\N	446	\N
500	My	私の	代名詞	\N	\N	\N	447	\N
431	parents	親	名詞	\N	\N	\N	447	\N
499	a few	２，３の	形容詞句	\N	\N	\N	447	\N
594	house rules	家での規則	複合名詞	\N	\N	\N	447	\N
349	What	何	疑問詞	\N	\N	\N	448	\N
409	first	まず	副詞	\N	\N	\N	449	\N
595	mustn't	～してはいけない	助動詞句	\N	\N	\N	449	\N
596	wear	はく	動詞	\N	\N	\N	449	\N
597	shoes	靴	名詞	\N	\N	\N	449	\N
236	house	家	名詞	\N	\N	\N	449	\N
115	know	知る	動詞	\N	\N	\N	450	\N
395	that	それ	代名詞	\N	\N	\N	450	\N
6	Also	それから	副詞	\N	\N	\N	451	\N
216	can't	～できない	助動詞句	\N	\N	\N	451	\N
407	watch	見る	動詞	\N	\N	\N	451	\N
598	TV	テレビ	名詞	\N	\N	\N	451	\N
418	after	～のあと	前置詞	\N	\N	\N	451	\N
260	Alright	わかった	間投詞	\N	\N	\N	452	\N
172	And	そして	接続詞	\N	\N	\N	453	\N
46	too	～すぎる	副詞	\N	\N	\N	453	\N
599	noisy	うるさい	形容詞	\N	\N	\N	453	\N
600	night	夜	名詞	\N	\N	\N	453	\N
601	Is that it?	それで終わり	実用表現	\N	\N	\N	454	\N
203	think	思う	動詞	\N	\N	\N	455	\N
110	so	そう	形容詞	\N	\N	\N	455	\N
602	strict	厳しい	形容詞	\N	\N	\N	456	\N
15	Not really	それほどでもない	実用表現	\N	\N	\N	457	\N
453	worse 	悪い	形容詞	\N	\N	\N	458	\N
33	Oh	おお、あっ	間投詞	\N	\N	\N	459	\N
362	this	これ	指示詞	\N	\N	\N	459	\N
77	new	新しい	形容詞	\N	\N	\N	459	\N
603	level	レベル	名詞	\N	\N	\N	459	\N
83	Tell	教える	動詞	\N	\N	\N	460	\N
604	what to do	すること	実用表現	\N	\N	\N	460	\N
62	OK	いいよ	間投詞	\N	\N	\N	461	\N
409	First	はじめに	副詞	\N	\N	\N	462	\N
605	press	押す	動詞	\N	\N	\N	462	\N
294	red	赤い	形容詞	\N	\N	\N	462	\N
606	button	ボタン	名詞	\N	\N	\N	462	\N
607	run	走る	動詞	\N	\N	\N	462	\N
608	over there	向こうに	前置詞句	\N	\N	\N	462	\N
421	Got it.	わかる	実用表現	\N	\N	\N	463	\N
72	Then	それから	接続詞	\N	\N	\N	464	\N
349	what	何	疑問詞	\N	\N	\N	464	\N
87	Well	えっと	間投詞	\N	\N	\N	465	\N
248	Let me see.	ちょっと待って。	実用表現	\N	\N	\N	465	\N
609	Oh yeah	そうそう	実用表現	\N	\N	\N	466	\N
610	Jump 	とぶ	動詞	\N	\N	\N	467	\N
584	into	～の中に	前置詞	\N	\N	\N	467	\N
395	that	あの	形容詞	\N	\N	\N	467	\N
611	airplane	飛行機	名詞	\N	\N	\N	467	\N
181	Where	どこに	疑問詞	\N	\N	\N	468	\N
149	go	行く	動詞	\N	\N	\N	468	\N
612	Fly	飛ぶ	動詞	\N	\N	\N	469	\N
613	up	上へ	副詞	\N	\N	\N	469	\N
163	there	そこ	副詞	\N	\N	\N	469	\N
614	toward	～に向かって	前置詞	\N	\N	\N	469	\N
615	castle	城	名詞	\N	\N	\N	469	\N
260	Alright	わかった	間投詞	\N	\N	\N	470	\N
362	This	これ	形容詞	\N	\N	\N	471	\N
616	easy	簡単	形容詞	\N	\N	\N	471	\N
112	But	しかし	接続詞	\N	\N	\N	472	\N
120	careful	注意する	形容詞	\N	\N	\N	472	\N
172	And	それから	接続詞	\N	\N	\N	473	\N
617	stay away from	～をよける	実用表現	\N	\N	\N	473	\N
380	black	黒い	形容詞	\N	\N	\N	473	\N
618	planes	飛行機	名詞	\N	\N	\N	473	\N
146	Wow	ええー	間投詞	\N	\N	\N	474	\N
619	There're	～がある、いる	実用表現	\N	\N	\N	475	\N
110	so	そんなにも	副詞	\N	\N	\N	475	\N
620	many	たくさんの	形容詞	\N	\N	\N	475	\N
621	Oh, no	おっと、いけない	実用表現	\N	\N	\N	476	\N
622	dead	死んだ	形容詞	\N	\N	\N	477	\N
623	Don't worry.	心配しないで	実用表現	\N	\N	\N	478	\N
202	Just	ただ	副詞	\N	\N	\N	479	\N
624	start over	最初からやり直す	実用表現	\N	\N	\N	479	\N
625	Yes	はい	間投詞	\N	\N	\N	481	\N
626	Would you mind not～ing?	～しないでもらえますか	実用表現	\N	\N	\N	482	\N
627	making noise	うるさくする	動詞句	\N	\N	\N	482	\N
110	so	そんなに	副詞	\N	\N	\N	482	\N
628	much	たくさんの	形容詞	\N	\N	\N	482	\N
29	Sure	もちろん	副詞	\N	\N	\N	483	\N
629	sorry about that	それはごめんなさい	実用表現	\N	\N	\N	483	\N
172	And	そして	接続詞	\N	\N	\N	484	\N
225	should	～べき	助動詞	\N	\N	\N	484	\N
493	play	遊ぶ	動詞	\N	\N	\N	484	\N
412	in	～(の中)で	前置詞	\N	\N	\N	484	\N
630	hall	ろうか	名詞	\N	\N	\N	484	\N
59	only	～だけ	副詞	\N	\N	\N	485	\N
631	kicking	ける	動詞	\N	\N	\N	485	\N
632	ball	ボール	名詞	\N	\N	\N	485	\N
633	around	あちこちに	副詞	\N	\N	\N	485	\N
634	It doesn't matter.	関係ない。そういうことではない。	実用表現	\N	\N	\N	486	\N
635	Don't	～するな	助動詞句	\N	\N	\N	487	\N
493	play	遊ぶ	動詞	\N	\N	\N	487	\N
636	school building	校舎	複合名詞	\N	\N	\N	487	\N
112	But	しかし	接続詞	\N	\N	\N	488	\N
458	raining	雨が降る	動詞	\N	\N	\N	488	\N
492	outside	外で	副詞	\N	\N	\N	488	\N
72	 Then 	それならば	接続詞	\N	\N	\N	489	\N
149	go	行く	動詞	\N	\N	\N	489	\N
441	to	～へ	前置詞	\N	\N	\N	489	\N
637	gym	体育館	名詞	\N	\N	\N	489	\N
395	that	その	形容詞	\N	\N	\N	490	\N
62	OK	わかった	間投詞	\N	\N	\N	491	\N
638	won't	～しません	助動詞句	\N	\N	\N	492	\N
639	I'm sorry.	ごめんなさい	実用表現	\N	\N	\N	493	\N
225	Should	～べき	助動詞	\N	\N	\N	494	\N
107	take	持って行く	動詞	\N	\N	\N	494	\N
640	dishes	食器	名詞	\N	\N	\N	494	\N
641	kitchen 	台所	名詞	\N	\N	\N	494	\N
494	No	いいえ	間投詞	\N	\N	\N	495	\N
642	don't have to	～しなくていい	助動詞句	\N	\N	\N	495	\N
417	do	する	動詞	\N	\N	\N	496	\N
643	Are you sure?	ほんとうに？	実用表現	\N	\N	\N	497	\N
644	'd like to	～したい	動詞句	\N	\N	\N	498	\N
645	help out	手伝う	動詞句	\N	\N	\N	498	\N
646	Don't worry about it.	気にしないで。	実用表現	\N	\N	\N	499	\N
647	our	私たちの	代名詞	\N	\N	\N	500	\N
648	guest	客	名詞	\N	\N	\N	500	\N
533	What about～?	～はどう？	実用表現	\N	\N	\N	501	\N
314	other	他の	形容詞	\N	\N	\N	501	\N
143	things	こと	名詞	\N	\N	\N	501	\N
649	 Like 	～ような	前置詞	\N	\N	\N	502	\N
650	what	何	疑問詞	\N	\N	\N	502	\N
87	Well	ええと、そうねえ	間投詞	\N	\N	\N	503	\N
500	my	私の	代名詞	\N	\N	\N	503	\N
651	laundry 	洗濯物	名詞	\N	\N	\N	503	\N
585	have to	～しなければならない	助動詞句	\N	\N	\N	504	\N
652	wash	洗う	動詞	\N	\N	\N	504	\N
653	own	自分の	形容詞	\N	\N	\N	504	\N
473	clothes	洋服	名詞	\N	\N	\N	504	\N
494	No	いいえ	間投詞	\N	\N	\N	505	\N
654	mom	お母さん	名詞	\N	\N	\N	506	\N
655	need to	～する必要がある	助動詞句	\N	\N	\N	507	\N
656	clean up	掃除する	動詞句	\N	\N	\N	507	\N
657	room	部屋	名詞	\N	\N	\N	507	\N
242	everyday	毎日	形容詞	\N	\N	\N	507	\N
494	No	いいえ	間投詞	\N	\N	\N	508	\N
658	don't need to	～する必要はない	助動詞句	\N	\N	\N	508	\N
112	But	しかし	接続詞	\N	\N	\N	509	\N
659	must 	～しなければならない	助動詞	\N	\N	\N	509	\N
660	make your bed 	ベッドを整える	実用表現	\N	\N	\N	509	\N
661	That's it.	それだけ	実用表現	\N	\N	\N	510	\N
500	My	私の	代名詞	\N	\N	\N	511	\N
431	parents	親	名詞	\N	\N	\N	511	\N
662	wondering	考える	動詞	\N	\N	\N	511	\N
625	Yes	はい	間投詞	\N	\N	\N	512	\N
663	Would like to ~?	～したいですか	実用表現	\N	\N	\N	513	\N
664	your	あなたの	代名詞	\N	\N	\N	513	\N
157	family	家族	名詞	\N	\N	\N	513	\N
211	come	来る、行く	動詞	\N	\N	\N	513	\N
441	to	～に	前置詞	\N	\N	\N	513	\N
22	Japan	日本	固有名詞	\N	\N	\N	513	\N
362	this	この	形容詞	\N	\N	\N	513	\N
568	summer	夏	名詞	\N	\N	\N	513	\N
33	Oh	わあ	間投詞	\N	\N	\N	514	\N
104	I'm sorry.	ごめんなさい。	実用表現	\N	\N	\N	514	\N
112	but	しかし	接続詞	\N	\N	\N	514	\N
203	think	～だと思う	動詞	\N	\N	\N	514	\N
364	can	～できる	助動詞	\N	\N	\N	514	\N
665	That's too bad.	それは残念。	実用表現	\N	\N	\N	515	\N
666	 It is, isn't it? 	そうだよね。	実用表現	\N	\N	\N	516	\N
667	 terribly 	ひどく	副詞	\N	\N	\N	517	\N
668	 busy 	忙しい	形容詞	\N	\N	\N	517	\N
87	Well	それでは	間投詞	\N	\N	\N	518	\N
218	what about ~?	～はどう？	熟語	\N	\N	\N	518	\N
669	you	あなた	代名詞	\N	\N	\N	518	\N
344	want to	～したい	動詞句	\N	\N	\N	519	\N
514	Me	私	代名詞	\N	\N	\N	520	\N
670	'd love to 	ぜひ～	実用表現	\N	\N	\N	521	\N
173	How about ~?	～はどう？	実用表現	\N	\N	\N	522	\N
211	coming	来る、行く	動詞	\N	\N	\N	522	\N
412	in	～に	前置詞	\N	\N	\N	522	\N
671	July	7月	名詞	\N	\N	\N	522	\N
180	have 	～がある	動詞	\N	\N	\N	523	\N
672	holidays	休み	名詞	\N	\N	\N	523	\N
26	then	その時	副詞	\N	\N	\N	523	\N
673	That sounds good.	それはいいね	実用表現	\N	\N	\N	524	\N
674	but 	でも	接続詞	\N	\N	\N	524	\N
675	have to 	～しなければならない	助動詞	\N	\N	\N	524	\N
676	ask	訊く	動詞	\N	\N	\N	524	\N
409	first	まず	副詞	\N	\N	\N	524	\N
500	My	私の	代名詞	\N	\N	\N	525	\N
677	aunt	おば	名詞	\N	\N	\N	525	\N
172	and	と,そして	接続詞	\N	\N	\N	525	\N
678	cousin	いとこ	名詞	\N	\N	\N	525	\N
211	coming	来る	動詞	\N	\N	\N	525	\N
159	visit	訪れる	動詞	\N	\N	\N	525	\N
362	this	この	代名詞	\N	\N	\N	525	\N
679	fall	秋	名詞	\N	\N	\N	525	\N
37	nice	良い	形容詞	\N	\N	\N	526	\N
349	What	何を	疑問詞	\N	\N	\N	527	\N
669	you	あなた	代名詞	\N	\N	\N	527	\N
490	are going to	～するつもりだ	動詞句	\N	\N	\N	527	\N
417	do	する	動詞	\N	\N	\N	527	\N
210	with	～と一緒に	前置詞	\N	\N	\N	527	\N
589	them	彼ら	代名詞	\N	\N	\N	527	\N
680	I'm not too sure.	私はよく分からない。	実用表現	\N	\N	\N	528	\N
681	They	彼ら	代名詞	\N	\N	\N	529	\N
344	want to	～したい	動詞句	\N	\N	\N	529	\N
682	travel around	旅をして回る	動詞句	\N	\N	\N	529	\N
22	Japan	日本	固有名詞	\N	\N	\N	529	\N
669	You	あなた	代名詞	\N	\N	\N	530	\N
225	should	～べき	助動詞	\N	\N	\N	530	\N
149	go	行く	動詞	\N	\N	\N	530	\N
441	to	～へ	前置詞	\N	\N	\N	530	\N
683	Kyoto	京都	固有名詞	\N	\N	\N	530	\N
42	beautiful	きれい	形容詞	\N	\N	\N	531	\N
163	there	そこで	副詞	\N	\N	\N	531	\N
412	in	～に	前置詞	\N	\N	\N	531	\N
679	fall	秋	名詞	\N	\N	\N	531	\N
406	never	かつて～ない	副詞	\N	\N	\N	532	\N
684	fantastic	すばらしい	形容詞	\N	\N	\N	533	\N
452	if	もし	接続詞	\N	\N	\N	534	\N
163	there	そこに	副詞	\N	\N	\N	534	\N
620	many	たくさんの	形容詞	\N	\N	\N	534	\N
685	temples	寺	名詞	\N	\N	\N	534	\N
686	shrines	神社	名詞	\N	\N	\N	534	\N
158	would	～だろう	助動詞	\N	\N	\N	535	\N
95	like	好きだ	動詞	\N	\N	\N	535	\N
395	that	それ	代名詞	\N	\N	\N	535	\N
112	But	しかし	接続詞	\N	\N	\N	536	\N
452	if	もし	接続詞	\N	\N	\N	536	\N
72	then	その時	副詞	\N	\N	\N	536	\N
664	your	あなたの	代名詞	\N	\N	\N	536	\N
157	family	家族	名詞	\N	\N	\N	536	\N
687	had better	～べきだ	助動詞句	\N	\N	\N	536	\N
688	make reservations	予約する	実用表現	\N	\N	\N	536	\N
150	now	今	副詞	\N	\N	\N	536	\N
464	Why	どうして	疑問詞	\N	\N	\N	537	\N
689	crowded	混んでいる	形容詞	\N	\N	\N	538	\N
134	Yeah	そうだよ	間投詞	\N	\N	\N	539	\N
619	there are	～がある、いる	実用表現	\N	\N	\N	539	\N
690	a lot of	たくさんの	形容詞句	\N	\N	\N	539	\N
691	tourists	観光客	名詞	\N	\N	\N	539	\N
110	so	だから	接続詞	\N	\N	\N	539	\N
692	make sure	確認する、必ず～する	実用表現	\N	\N	\N	539	\N
207	plan	計画する	動詞	\N	\N	\N	539	\N
693	ahead	前もって	助動詞	\N	\N	\N	539	\N
669	Your	あなたの	代名詞	\N	\N	\N	540	\N
694	desk	机	名詞	\N	\N	\N	540	\N
695	mess	散らかっている	名詞	\N	\N	\N	540	\N
696	that ~	そんなに～ではない。	実用表現	\N	\N	\N	541	\N
697	messy	ぐちゃぐちゃ	形容詞	\N	\N	\N	541	\N
172	And	そして	接続詞	\N	\N	\N	543	\N
84	class	授業	名詞	\N	\N	\N	543	\N
698	is about to	～するところ	実用表現	\N	\N	\N	543	\N
699	start	始まる	動詞	\N	\N	\N	543	\N
82	Please	どうか	間投詞	\N	\N	\N	544	\N
656	clean up	片付ける	動詞句	\N	\N	\N	544	\N
664	your	あなたの	代名詞	\N	\N	\N	544	\N
700	right away	今すぐに	副詞句	\N	\N	\N	544	\N
158	will	～する	動詞	\N	\N	\N	545	\N
409	First	まず	副詞	\N	\N	\N	546	\N
701	want･･･to ~	―にをして欲しい	熟語	\N	\N	\N	546	\N
702	throw away	捨てる	動詞句	\N	\N	\N	546	\N
395	that	その	指示詞	\N	\N	\N	546	\N
381	paper	紙	名詞	\N	\N	\N	546	\N
62	OK	はい	間投詞	\N	\N	\N	547	\N
703	just a second	ちょっと待って	実用表現	\N	\N	\N	547	\N
172	And	そして	接続詞	\N	\N	\N	548	\N
704	after that	そのあと	副詞	\N	\N	\N	548	\N
705	put away	片付ける	動詞句	\N	\N	\N	548	\N
395	those	それ	指示詞	\N	\N	\N	548	\N
706	colored pencils	色鉛筆	複合名詞	\N	\N	\N	548	\N
260	Alright	わかった	間投詞	\N	\N	\N	549	\N
707	stop	やめる	動詞	\N	\N	\N	550	\N
708	working on	取り組む	動詞句	\N	\N	\N	550	\N
669	your	あなたの	代名詞	\N	\N	\N	550	\N
709	project	プロジェクト、課題	名詞	\N	\N	\N	550	\N
62	OK	はい	間投詞	\N	\N	\N	551	\N
60	Sorry	すみません	間投詞	\N	\N	\N	552	\N
349	What	何	疑問詞	\N	\N	\N	553	\N
344	want to	～したい	動詞句	\N	\N	\N	553	\N
417	do	する	動詞	\N	\N	\N	553	\N
384	when	～の時	副詞	\N	\N	\N	553	\N
710	grow up	大人になる	動詞句	\N	\N	\N	553	\N
265	something	何か	名詞	\N	\N	\N	554	\N
711	creative	創造的な	形容詞	\N	\N	\N	554	\N
712	Oh yeah?	本当に？	実用表現	\N	\N	\N	555	\N
134	Yeah	うん	感嘆詞	\N	\N	\N	556	\N
644	'd like to	～したい	動詞句	\N	\N	\N	556	\N
713	become	～になる	動詞	\N	\N	\N	556	\N
714	artist	芸術家	名詞	\N	\N	\N	556	\N
715	What kind of?	どんな？	実用表現	\N	\N	\N	557	\N
716	be	～になる	動詞	\N	\N	\N	558	\N
717	writer	作家	名詞	\N	\N	\N	558	\N
718	or	か、または	接続詞	\N	\N	\N	558	\N
719	painter	画家	名詞	\N	\N	\N	558	\N
464	Why	なぜ	疑問詞 	\N	\N	\N	559	\N
682	travel around	旅して回る	動詞句	\N	\N	\N	561	\N
28	world	世界	名詞	\N	\N	\N	561	\N
395	That	それ	代名詞	\N	\N	\N	562	\N
720	sounds	～ように聞こえる	動詞	\N	\N	\N	562	\N
721	exciting 	わくわくする	形容詞	\N	\N	\N	562	\N
134	Yeah	でしょ	間投詞	\N	\N	\N	563	\N
110	so	だから	接続詞	\N	\N	\N	563	\N
722	pilot	パイロット	 名詞	\N	\N	\N	563	\N
135	great	すごい	形容詞	\N	\N	\N	564	\N
723	dream	夢	名詞	\N	\N	\N	564	\N
724	this ~	～（二人）です	実用表現	\N	\N	\N	565	\N
500	my 	私の	代名詞	\N	\N	\N	565	\N
100	friend	友達	名詞	\N	\N	\N	565	\N
725	's from 	～出身だ	実用表現	\N	\N	\N	566	\N
318	Switzerland	スイス	固有名詞	\N	\N	\N	566	\N
81	Nice to meet you	お会いできて光栄です。	実用表現	\N	\N	\N	567	\N
46	too	～も	副詞	\N	\N	\N	568	\N
78	student	学生	名詞	\N	\N	\N	569	\N
338	at	～で	前置詞	\N	\N	\N	569	\N
726	International School	インターナショナル･スクール	固有名詞	\N	\N	\N	569	\N
727	came	来る	動詞	\N	\N	\N	569	\N
441	to	～に、へ	前置詞	\N	\N	\N	569	\N
22	Japan	日本	固有名詞	\N	\N	\N	570	\N
412	in	～に	前置詞	\N	\N	\N	570	\N
728	april	4月	名詞	\N	\N	\N	570	\N
500	my	私の	代名詞	\N	\N	\N	571	\N
303	English	英語の	形容詞	\N	\N	\N	571	\N
729	teacher	先生	名詞	\N	\N	\N	571	\N
730	England	イングランド	固有名詞	\N	\N	\N	572	\N
395	That	それは	形容詞	\N	\N	\N	573	\N
37	nice	すてきな	形容詞	\N	\N	\N	573	\N
135	great	すばらしい	形容詞	\N	\N	\N	574	\N
87	Well	まあ	間投詞	\N	\N	\N	575	\N
38	thank you	ありがとう	実用表現	\N	\N	\N	575	\N
731	It was nice to meet you	会えてよかったです	実用表現	\N	\N	\N	576	\N
46	too 	も	副詞	\N	\N	\N	577	\N
1039		\N		\N	\N	\N	172	\N
1038		\N		\N	\N	\N	424	\N
1165		\N		\N	\N	\N	369	\N
1113		\N		\N	\N	\N	570	\N
844		\N		\N	\N	\N	524	\N
1052		\N		\N	\N	\N	525	\N
1020		\N		\N	\N	\N	324	\N
932		\N		\N	\N	\N	310	\N
1241		\N		\N	\N	\N	556	\N
825		\N		\N	\N	\N	509	\N
1244		\N		\N	\N	\N	543	\N
1229		\N		\N	\N	\N	196	\N
786		\N		\N	\N	\N	425	\N
1026		\N		\N	\N	\N	311	\N
783		\N		\N	\N	\N	425	\N
1041		\N		\N	\N	\N	308	\N
1053		\N		\N	\N	\N	308	\N
968		\N		\N	\N	\N	487	\N
780		\N		\N	\N	\N	517	\N
915		\N		\N	\N	\N	442	\N
855		\N		\N	\N	\N	49	\N
867		\N		\N	\N	\N	543	\N
1070		\N		\N	\N	\N	346	\N
1199		\N		\N	\N	\N	325	\N
1105		\N		\N	\N	\N	345	\N
1040		\N		\N	\N	\N	525	\N
1055		\N		\N	\N	\N	150	\N
820		\N		\N	\N	\N	540	\N
870		\N		\N	\N	\N	257	\N
1088		\N		\N	\N	\N	435	\N
1095		\N		\N	\N	\N	435	\N
1083		\N		\N	\N	\N	494	\N
874		\N		\N	\N	\N	471	\N
922		\N		\N	\N	\N	268	\N
922		\N		\N	\N	\N	446	\N
1090		\N		\N	\N	\N	295	\N
733		\N		\N	\N	\N	283	\N
794		\N		\N	\N	\N	255	\N
1079		\N		\N	\N	\N	270	\N
1142		\N		\N	\N	\N	531	\N
811		\N		\N	\N	\N	104	\N
1003		\N		\N	\N	\N	155	\N
756		\N		\N	\N	\N	342	\N
1049		\N		\N	\N	\N	156	\N
1249		\N		\N	\N	\N	307	\N
929		\N		\N	\N	\N	271	\N
737		\N		\N	\N	\N	220	\N
854		\N		\N	\N	\N	7	\N
732		\N		\N	\N	\N	98	\N
829		\N		\N	\N	\N	176	\N
750		\N		\N	\N	\N	208	\N
1013		\N		\N	\N	\N	207	\N
1237		\N		\N	\N	\N	198	\N
759		\N		\N	\N	\N	275	\N
837		\N		\N	\N	\N	57	\N
815		\N		\N	\N	\N	150	\N
1189		\N		\N	\N	\N	354	\N
816		\N		\N	\N	\N	449	\N
989		\N		\N	\N	\N	355	\N
989		\N		\N	\N	\N	306	\N
796		\N		\N	\N	\N	111	\N
980		\N		\N	\N	\N	241	\N
1028		\N		\N	\N	\N	449	\N
1017		\N		\N	\N	\N	116	\N
739		\N		\N	\N	\N	221	\N
1119		\N		\N	\N	\N	522	\N
969		\N		\N	\N	\N	494	\N
1206		\N		\N	\N	\N	215	\N
1124		\N		\N	\N	\N	51	\N
1019		\N		\N	\N	\N	6	\N
952		\N		\N	\N	\N	381	\N
945		\N		\N	\N	\N	19	\N
749		\N		\N	\N	\N	53	\N
1186		\N		\N	\N	\N	262	\N
972		\N		\N	\N	\N	211	\N
748		\N		\N	\N	\N	273	\N
1021		\N		\N	\N	\N	534	\N
835		\N		\N	\N	\N	111	\N
742		\N		\N	\N	\N	48	\N
906		\N		\N	\N	\N	295	\N
1056		\N		\N	\N	\N	506	\N
1179		\N		\N	\N	\N	329	\N
828		\N		\N	\N	\N	47	\N
842		\N		\N	\N	\N	231	\N
1006		\N		\N	\N	\N	459	\N
843		\N		\N	\N	\N	227	\N
1161		\N		\N	\N	\N	453	\N
935		\N		\N	\N	\N	505	\N
993		\N		\N	\N	\N	49	\N
898		\N		\N	\N	\N	84	\N
1240		\N		\N	\N	\N	546	\N
1048		\N		\N	\N	\N	456	\N
1100		\N		\N	\N	\N	548	\N
1184		\N		\N	\N	\N	335	\N
1185		\N		\N	\N	\N	23	\N
746		\N		\N	\N	\N	365	\N
963		\N		\N	\N	\N	49	\N
873		\N		\N	\N	\N	282	\N
875		\N		\N	\N	\N	372	\N
1251		\N		\N	\N	\N	438	\N
912		\N		\N	\N	\N	295	\N
1194		\N		\N	\N	\N	329	\N
785		\N		\N	\N	\N	280	\N
1236		\N		\N	\N	\N	462	\N
822		\N		\N	\N	\N	35	\N
1137		\N		\N	\N	\N	360	\N
1203		\N		\N	\N	\N	439	\N
858		\N		\N	\N	\N	248	\N
965		\N		\N	\N	\N	399	\N
948		\N		\N	\N	\N	189	\N
955		\N		\N	\N	\N	449	\N
1050		\N		\N	\N	\N	313	\N
1054		\N		\N	\N	\N	313	\N
1007		\N		\N	\N	\N	341	\N
994		\N		\N	\N	\N	193	\N
1252		\N		\N	\N	\N	107	\N
1209		\N		\N	\N	\N	215	\N
793		\N		\N	\N	\N	397	\N
1016		\N		\N	\N	\N	339	\N
859		\N		\N	\N	\N	569	\N
860		\N		\N	\N	\N	283	\N
992		\N		\N	\N	\N	11	\N
1145		\N		\N	\N	\N	519	\N
863		\N		\N	\N	\N	523	\N
1131		\N		\N	\N	\N	359	\N
1089		\N		\N	\N	\N	438	\N
831		\N		\N	\N	\N	441	\N
1211		\N		\N	\N	\N	73	\N
871		\N		\N	\N	\N	261	\N
864		\N		\N	\N	\N	571	\N
988		\N		\N	\N	\N	467	\N
1250		\N		\N	\N	\N	44	\N
838		\N		\N	\N	\N	237	\N
839		\N		\N	\N	\N	171	\N
979		\N		\N	\N	\N	529	\N
987		\N		\N	\N	\N	81	\N
987		\N		\N	\N	\N	233	\N
1155		\N		\N	\N	\N	165	\N
1153		\N		\N	\N	\N	46	\N
901		\N		\N	\N	\N	61	\N
744		\N		\N	\N	\N	529	\N
745		\N		\N	\N	\N	561	\N
832		\N		\N	\N	\N	451	\N
1037		\N		\N	\N	\N	469	\N
809		\N		\N	\N	\N	504	\N
824		\N		\N	\N	\N	504	\N
981		\N		\N	\N	\N	26	\N
1196		\N		\N	\N	\N	333	\N
1138		\N		\N	\N	\N	142	\N
991		\N		\N	\N	\N	557	\N
840		\N		\N	\N	\N	468	\N
1228		\N		\N	\N	\N	206	\N
779		\N		\N	\N	\N	310	\N
1204		\N		\N	\N	\N	178	\N
1141		\N		\N	\N	\N	211	\N
1234		\N		\N	\N	\N	201	\N
936		\N		\N	\N	\N	270	\N
985		\N		\N	\N	\N	412	\N
985		\N		\N	\N	\N	26	\N
986		\N		\N	\N	\N	577	\N
1096		\N		\N	\N	\N	578	\N
1215		\N		\N	\N	\N	579	\N
1152		\N		\N	\N	\N	580	\N
916		\N		\N	\N	\N	581	\N
878		\N		\N	\N	\N	582	\N
976		\N		\N	\N	\N	583	\N
1073		\N		\N	\N	\N	584	\N
940		\N		\N	\N	\N	585	\N
1175		\N		\N	\N	\N	587	\N
1112		\N		\N	\N	\N	588	\N
847		\N		\N	\N	\N	589	\N
923		\N		\N	\N	\N	590	\N
964		\N		\N	\N	\N	591	\N
950		\N		\N	\N	\N	592	\N
950		\N		\N	\N	\N	593	\N
1111		\N		\N	\N	\N	594	\N
967		\N		\N	\N	\N	595	\N
791		\N		\N	\N	\N	596	\N
762		\N		\N	\N	\N	597	\N
998		\N		\N	\N	\N	598	\N
1235		\N		\N	\N	\N	599	\N
1074		\N		\N	\N	\N	600	\N
819		\N		\N	\N	\N	601	\N
1221		\N		\N	\N	\N	602	\N
924		\N		\N	\N	\N	603	\N
1091		\N		\N	\N	\N	604	\N
1042		\N		\N	\N	\N	605	\N
1230		\N		\N	\N	\N	606	\N
761		\N		\N	\N	\N	607	\N
1011		\N		\N	\N	\N	608	\N
1084		\N		\N	\N	\N	609	\N
953		\N		\N	\N	\N	599	\N
836		\N		\N	\N	\N	610	\N
1098		\N		\N	\N	\N	611	\N
1086		\N		\N	\N	\N	612	\N
954		\N		\N	\N	\N	613	\N
769		\N		\N	\N	\N	614	\N
821		\N		\N	\N	\N	615	\N
792		\N		\N	\N	\N	616	\N
921		\N		\N	\N	\N	617	\N
801		\N		\N	\N	\N	618	\N
1218		\N		\N	\N	\N	619	\N
1178		\N		\N	\N	\N	587	\N
856		\N		\N	\N	\N	620	\N
810		\N		\N	\N	\N	621	\N
817		\N		\N	\N	\N	622	\N
1018		\N		\N	\N	\N	623	\N
1190		\N		\N	\N	\N	624	\N
1104		\N		\N	\N	\N	625	\N
894		\N		\N	\N	\N	626	\N
960		\N		\N	\N	\N	627	\N
903		\N		\N	\N	\N	628	\N
904		\N		\N	\N	\N	629	\N
886		\N		\N	\N	\N	630	\N
1192		\N		\N	\N	\N	631	\N
1200		\N		\N	\N	\N	632	\N
1232		\N		\N	\N	\N	633	\N
773		\N		\N	\N	\N	634	\N
1238		\N		\N	\N	\N	635	\N
807		\N		\N	\N	\N	636	\N
1191		\N		\N	\N	\N	637	\N
787		\N		\N	\N	\N	638	\N
788		\N		\N	\N	\N	639	\N
857		\N		\N	\N	\N	640	\N
741		\N		\N	\N	\N	641	\N
1217		\N		\N	\N	\N	642	\N
763		\N		\N	\N	\N	643	\N
908		\N		\N	\N	\N	644	\N
930		\N		\N	\N	\N	645	\N
845		\N		\N	\N	\N	646	\N
1022		\N		\N	\N	\N	647	\N
1233		\N		\N	\N	\N	648	\N
1116		\N		\N	\N	\N	649	\N
782		\N		\N	\N	\N	601	\N
889		\N		\N	\N	\N	650	\N
917		\N		\N	\N	\N	651	\N
958		\N		\N	\N	\N	652	\N
885		\N		\N	\N	\N	653	\N
927		\N		\N	\N	\N	654	\N
1025		\N		\N	\N	\N	655	\N
881		\N		\N	\N	\N	656	\N
974		\N		\N	\N	\N	626	\N
1107		\N		\N	\N	\N	626	\N
1035		\N		\N	\N	\N	657	\N
1071		\N		\N	\N	\N	658	\N
914		\N		\N	\N	\N	614	\N
902		\N		\N	\N	\N	659	\N
775		\N		\N	\N	\N	660	\N
1080		\N		\N	\N	\N	661	\N
1030		\N		\N	\N	\N	662	\N
890		\N		\N	\N	\N	663	\N
818		\N		\N	\N	\N	647	\N
1181		\N		\N	\N	\N	602	\N
795		\N		\N	\N	\N	605	\N
918		\N		\N	\N	\N	646	\N
1223		\N		\N	\N	\N	606	\N
747		\N		\N	\N	\N	664	\N
933		\N		\N	\N	\N	665	\N
944		\N		\N	\N	\N	666	\N
1101		\N		\N	\N	\N	667	\N
868		\N		\N	\N	\N	668	\N
1157		\N		\N	\N	\N	669	\N
1162		\N		\N	\N	\N	670	\N
1115		\N		\N	\N	\N	671	\N
1130		\N		\N	\N	\N	672	\N
1144		\N		\N	\N	\N	673	\N
1227		\N		\N	\N	\N	674	\N
939		\N		\N	\N	\N	675	\N
1075		\N		\N	\N	\N	676	\N
1248		\N		\N	\N	\N	677	\N
1242		\N		\N	\N	\N	678	\N
1117		\N		\N	\N	\N	679	\N
1024		\N		\N	\N	\N	680	\N
1106		\N		\N	\N	\N	681	\N
1188		\N		\N	\N	\N	682	\N
799		\N		\N	\N	\N	683	\N
957		\N		\N	\N	\N	684	\N
1081		\N		\N	\N	\N	685	\N
735		\N		\N	\N	\N	686	\N
862		\N		\N	\N	\N	687	\N
736		\N		\N	\N	\N	688	\N
920		\N		\N	\N	\N	689	\N
1110		\N		\N	\N	\N	690	\N
1140		\N		\N	\N	\N	691	\N
823		\N		\N	\N	\N	692	\N
848		\N		\N	\N	\N	693	\N
797		\N		\N	\N	\N	694	\N
813		\N		\N	\N	\N	695	\N
1108		\N		\N	\N	\N	696	\N
1201		\N		\N	\N	\N	697	\N
892		\N		\N	\N	\N	698	\N
897		\N		\N	\N	\N	699	\N
830		\N		\N	\N	\N	700	\N
1224		\N		\N	\N	\N	701	\N
911		\N		\N	\N	\N	702	\N
740		\N		\N	\N	\N	703	\N
808		\N		\N	\N	\N	704	\N
1044		\N		\N	\N	\N	673	\N
1043		\N		\N	\N	\N	676	\N
909		\N		\N	\N	\N	677	\N
977		\N		\N	\N	\N	705	\N
804		\N		\N	\N	\N	706	\N
1077		\N		\N	\N	\N	707	\N
1064		\N		\N	\N	\N	706	\N
1060		\N		\N	\N	\N	708	\N
1010		\N		\N	\N	\N	709	\N
887		\N		\N	\N	\N	710	\N
1004		\N		\N	\N	\N	711	\N
1031		\N		\N	\N	\N	712	\N
1213		\N		\N	\N	\N	713	\N
812		\N		\N	\N	\N	714	\N
869		\N		\N	\N	\N	715	\N
882		\N		\N	\N	\N	693	\N
925		\N		\N	\N	\N	716	\N
738		\N		\N	\N	\N	717	\N
879		\N		\N	\N	\N	718	\N
1225		\N		\N	\N	\N	719	\N
883		\N		\N	\N	\N	674	\N
966		\N		\N	\N	\N	705	\N
1118		\N		\N	\N	\N	720	\N
757		\N		\N	\N	\N	721	\N
1120		\N		\N	\N	\N	722	\N
1245		\N		\N	\N	\N	723	\N
1202		\N		\N	\N	\N	713	\N
1214		\N		\N	\N	\N	713	\N
1207		\N		\N	\N	\N	724	\N
1139		\N		\N	\N	\N	725	\N
1147		\N		\N	\N	\N	726	\N
850		\N		\N	\N	\N	727	\N
1076		\N		\N	\N	\N	728	\N
905		\N		\N	\N	\N	683	\N
1032		\N		\N	\N	\N	729	\N
781		\N		\N	\N	\N	693	\N
1002		\N		\N	\N	\N	730	\N
1014		\N		\N	\N	\N	731	\N
1231		\N		\N	\N	\N	732	\N
851		\N		\N	\N	\N	733	\N
1012		\N		\N	\N	\N	734	\N
1087		\N		\N	\N	\N	723	\N
789		\N		\N	\N	\N	735	\N
941		\N		\N	\N	\N	696	\N
1216		\N		\N	\N	\N	725	\N
1123		\N		\N	\N	\N	736	\N
1122		\N		\N	\N	\N	737	\N
1212		\N		\N	\N	\N	738	\N
802		\N		\N	\N	\N	692	\N
884		\N		\N	\N	\N	739	\N
1134		\N		\N	\N	\N	740	\N
931		\N		\N	\N	\N	741	\N
1128		\N		\N	\N	\N	742	\N
1183		\N		\N	\N	\N	701	\N
996		\N		\N	\N	\N	665	\N
784		\N		\N	\N	\N	743	\N
1121		\N		\N	\N	\N	735	\N
1133		\N		\N	\N	\N	744	\N
1148		\N		\N	\N	\N	745	\N
1246		\N		\N	\N	\N	746	\N
1160		\N		\N	\N	\N	747	\N
1033		\N		\N	\N	\N	748	\N
1078		\N		\N	\N	\N	749	\N
866		\N		\N	\N	\N	750	\N
1125		\N		\N	\N	\N	751	\N
1126		\N		\N	\N	\N	752	\N
833		\N		\N	\N	\N	753	\N
1009		\N		\N	\N	\N	754	\N
1029		\N		\N	\N	\N	365	\N
1239		\N		\N	\N	\N	725	\N
1182		\N		\N	\N	\N	602	\N
938		\N		\N	\N	\N	675	\N
834		\N		\N	\N	\N	745	\N
946		\N		\N	\N	\N	629	\N
876		\N		\N	\N	\N	582	\N
827		\N		\N	\N	\N	754	\N
751		\N		\N	\N	\N	640	\N
1127		\N		\N	\N	\N	719	\N
956		\N		\N	\N	\N	704	\N
1051		\N		\N	\N	\N	605	\N
852		\N		\N	\N	\N	615	\N
937		\N		\N	\N	\N	33	\N
1149		\N		\N	\N	\N	695	\N
895		\N		\N	\N	\N	753	\N
907		\N		\N	\N	\N	628	\N
1169		\N		\N	\N	\N	741	\N
1154		\N		\N	\N	\N	697	\N
880		\N		\N	\N	\N	718	\N
770		\N		\N	\N	\N	727	\N
1066		\N		\N	\N	\N	730	\N
1047		\N		\N	\N	\N	652	\N
865		\N		\N	\N	\N	687	\N
766		\N		\N	\N	\N	703	\N
803		\N		\N	\N	\N	632	\N
990		\N		\N	\N	\N	694	\N
983		\N		\N	\N	\N	702	\N
1045		\N		\N	\N	\N	726	\N
1219		\N		\N	\N	\N	726	\N
1220		\N		\N	\N	\N	714	\N
1208		\N		\N	\N	\N	738	\N
1156		\N		\N	\N	\N	663	\N
1102		\N		\N	\N	\N	755	\N
806		\N		\N	\N	\N	756	\N
1008		\N		\N	\N	\N	757	\N
1172		\N		\N	\N	\N	758	\N
961		\N		\N	\N	\N	759	\N
973		\N		\N	\N	\N	760	\N
1222		\N		\N	\N	\N	761	\N
1226		\N		\N	\N	\N	761	\N
777		\N		\N	\N	\N	762	\N
734		\N		\N	\N	\N	763	\N
1067		\N		\N	\N	\N	764	\N
841		\N		\N	\N	\N	765	\N
765		\N		\N	\N	\N	760	\N
760		\N		\N	\N	\N	766	\N
753		\N		\N	\N	\N	767	\N
800		\N		\N	\N	\N	768	\N
942		\N		\N	\N	\N	769	\N
942		\N		\N	\N	\N	770	\N
877		\N		\N	\N	\N	771	\N
1243		\N		\N	\N	\N	772	\N
1097		\N		\N	\N	\N	773	\N
1062		\N		\N	\N	\N	774	\N
1063		\N		\N	\N	\N	775	\N
826		\N		\N	\N	\N	776	\N
1195		\N		\N	\N	\N	777	\N
1180		\N		\N	\N	\N	778	\N
743		\N		\N	\N	\N	779	\N
926		\N		\N	\N	\N	760	\N
899		\N		\N	\N	\N	780	\N
947		\N		\N	\N	\N	781	\N
1092		\N		\N	\N	\N	782	\N
1085		\N		\N	\N	\N	783	\N
849		\N		\N	\N	\N	784	\N
767		\N		\N	\N	\N	785	\N
764		\N		\N	\N	\N	786	\N
1094		\N		\N	\N	\N	787	\N
1058		\N		\N	\N	\N	788	\N
772		\N		\N	\N	\N	789	\N
846		\N		\N	\N	\N	790	\N
970		\N		\N	\N	\N	791	\N
1027		\N		\N	\N	\N	792	\N
959		\N		\N	\N	\N	790	\N
1065		\N		\N	\N	\N	793	\N
752		\N		\N	\N	\N	794	\N
776		\N		\N	\N	\N	795	\N
1193		\N		\N	\N	\N	786	\N
1061		\N		\N	\N	\N	796	\N
1057		\N		\N	\N	\N	759	\N
982		\N		\N	\N	\N	797	\N
1171		\N		\N	\N	\N	798	\N
1176		\N		\N	\N	\N	776	\N
1174		\N		\N	\N	\N	799	\N
1036		\N		\N	\N	\N	800	\N
1093		\N		\N	\N	\N	797	\N
919		\N		\N	\N	\N	802	\N
758		\N		\N	\N	\N	803	\N
893		\N		\N	\N	\N	804	\N
949		\N		\N	\N	\N	769	\N
853		\N		\N	\N	\N	805	\N
943		\N		\N	\N	\N	769	\N
888		\N		\N	\N	\N	806	\N
1082		\N		\N	\N	\N	806	\N
1099		\N		\N	\N	\N	807	\N
861		\N		\N	\N	\N	808	\N
860		\N		\N	\N	\N	809	\N
896		\N		\N	\N	\N	810	\N
755		\N		\N	\N	\N	785	\N
913		\N		\N	\N	\N	811	\N
962		\N		\N	\N	\N	812	\N
774		\N		\N	\N	\N	813	\N
975		\N		\N	\N	\N	814	\N
1059		\N		\N	\N	\N	788	\N
1103		\N		\N	\N	\N	815	\N
768		\N		\N	\N	\N	810	\N
910		\N		\N	\N	\N	644	\N
872		\N		\N	\N	\N	816	\N
1163		\N		\N	\N	\N	801	\N
1205		\N		\N	\N	\N	817	\N
1163		\N		\N	\N	\N	817	\N
1164		\N		\N	\N	\N	776	\N
1150		\N		\N	\N	\N	809	\N
1151		\N		\N	\N	\N	818	\N
995		\N		\N	\N	\N	755	\N
999		\N		\N	\N	\N	819	\N
997		\N		\N	\N	\N	820	\N
1005		\N		\N	\N	\N	821	\N
1129		\N		\N	\N	\N	816	\N
1143		\N		\N	\N	\N	822	\N
1132		\N		\N	\N	\N	813	\N
891		\N		\N	\N	\N	823	\N
771		\N		\N	\N	\N	599	\N
744		\N		\N	\N	\N	818	\N
1037		\N		\N	\N	\N	824	\N
798		\N		\N	\N	\N	825	\N
805		\N		\N	\N	\N	784	\N
1187		\N		\N	\N	\N	826	\N
1177		\N		\N	\N	\N	826	\N
754		\N		\N	\N	\N	794	\N
1068		\N		\N	\N	\N	827	\N
1197		\N		\N	\N	\N	807	\N
814		\N		\N	\N	\N	828	\N
1015		\N		\N	\N	\N	829	\N
1069		\N		\N	\N	\N	830	\N
1136		\N		\N	\N	\N	781	\N
1034		\N		\N	\N	\N	831	\N
1170		\N		\N	\N	\N	832	\N
1166		\N		\N	\N	\N	833	\N
984		\N		\N	\N	\N	819	\N
1168		\N		\N	\N	\N	834	\N
1198		\N		\N	\N	\N	834	\N
971		\N		\N	\N	\N	835	\N
1210		\N		\N	\N	\N	836	\N
1000		\N		\N	\N	\N	790	\N
1167		\N		\N	\N	\N	814	\N
978		\N		\N	\N	\N	636	\N
978		\N		\N	\N	\N	253	\N
934		\N		\N	\N	\N	615	\N
934		\N		\N	\N	\N	22	\N
778		\N		\N	\N	\N	837	\N
900		\N		\N	\N	\N	838	\N
928		\N		\N	\N	\N	811	\N
1001		\N		\N	\N	\N	839	\N
1023		\N		\N	\N	\N	840	\N
1046		\N		\N	\N	\N	690	\N
1072		\N		\N	\N	\N	841	\N
1109		\N		\N	\N	\N	842	\N
1114		\N		\N	\N	\N	843	\N
1135		\N		\N	\N	\N	837	\N
1146		\N		\N	\N	\N	786	\N
1159		\N		\N	\N	\N	700	\N
1158		\N		\N	\N	\N	844	\N
1173		\N		\N	\N	\N	428	\N
1247		\N		\N	\N	\N	845	\N
1254		\N		\N	\N	\N	633	\N
1253		\N		\N	\N	\N	846	\N
1255		\N		\N	\N	\N	794	\N
1256		\N		\N	\N	\N	22	\N
775		\N		\N	\N	\N	715	\N
990		\N		\N	\N	\N	699	\N
834		\N		\N	\N	\N	805	\N
814		\N		\N	\N	\N	847	\N
817		\N		\N	\N	\N	848	\N
853		\N		\N	\N	\N	849	\N
765		\N		\N	\N	\N	850	\N
973		\N		\N	\N	\N	839	\N
966		\N		\N	\N	\N	851	\N
819		\N		\N	\N	\N	852	\N
999		\N		\N	\N	\N	755	\N
1150		\N		\N	\N	\N	853	\N
999		\N		\N	\N	\N	854	\N
744		\N		\N	\N	\N	855	\N
771		\N		\N	\N	\N	856	\N
1164		\N		\N	\N	\N	857	\N
914		\N		\N	\N	\N	858	\N
946		\N		\N	\N	\N	859	\N
1009		\N		\N	\N	\N	860	\N
1045		\N		\N	\N	\N	861	\N
1064		\N		\N	\N	\N	862	\N
1121		\N		\N	\N	\N	863	\N
1198		\N		\N	\N	\N	864	\N
1227		\N		\N	\N	\N	865	\N
769		\N		\N	\N	\N	653	\N
1062		\N		\N	\N	\N	866	\N
781		\N		\N	\N	\N	867	\N
848		\N		\N	\N	\N	868	\N
902		\N		\N	\N	\N	869	\N
1167		\N		\N	\N	\N	870	\N
1235		\N		\N	\N	\N	871	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: en
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

