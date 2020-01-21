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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO pb;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO pb;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO pb;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: pb
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


ALTER TABLE public.t_instance OWNER TO pb;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO pb;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO pb;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: pb
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


ALTER TABLE public.t_usage_classified_rel OWNER TO pb;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: pb
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


ALTER TABLE public.t_usage_inst_rel OWNER TO pb;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO pb;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO pb;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: pb
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO pb;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: pb
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


ALTER TABLE public.t_word_inst_rel OWNER TO pb;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: pb
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO pb;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: pb
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO pb;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: pb
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: pb
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
23	X
24	Z
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
8	Não.	ううん。	否定する		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
9	Por quê?	どうして？	理由を訊ねる		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
10	Porque eu quero ir ao cinema.	映画に行きたいと思って。	理由を述べる		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
11	Você quer ir?	君も行かない？	招待する		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
12	Quero, sim.	行きたいわ。	意見を言う		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
13	Qual é o filme?	何の映画？	情報を求める（属性）		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
14	Não sei.	わからない。	情報を伝える		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
15	Você escolhe.	君が選んで。	指示する		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
16	Eu vou ler o jornal e te falo depois.\n	新聞を見てから、言うわね。	予定を言う		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
17	Então, você me liga. 	じゃあ、電話してくれる？	指示する		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
18	Quando?	いつ？	情報を求める（時間）		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
19	Amanhã de manhã. 	明日の朝。	予定を言う		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
20	Posso convidar um amigo?	友達を誘ってもいいかしら？	許可を求める		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
21	Oi, Cláudia. 	ああ、クラウヂア。	挨拶をする		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
22	Olha o que eu trouxe pra você.	ほら、君のために持ってきたんだけど。	何かをあげる		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
23	Um presente?	プレゼント？	聞き返す		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
24	É. 	うん。	肯定する		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
25	Eu comprei na viagem que fiz a Gramado na semana passada. 	先週、グラマードへ行った旅行で買ってきたんだ。	情報を伝える		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
26	Tome. 	さぁ、どうぞ。	何かをあげる		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
27	Muito obrigada.	ありがとう。	感謝する		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
28	Você é muito gentil. 	やさしいのね。	感謝する		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
29	Abre o presente.	プレゼントを開けてみて	指示する		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
30	Oh, que delícia, uma caixa de bombons!	わあ、素敵！　ボンボンチョコレートの箱だわ！	感嘆する		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
31	De nada. 	どういたしまして。	お礼に答える		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
32	Você gosta?	（ボンボンは）好き？	嗜好について訊ねる		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
33	Adoro.	大好きよ。	嗜好について述べる（もの）		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
34	Vou comer tudo sozinha.	全部、私一人で食べるわ。	意志を述べる		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
35	Mas não vai dar nenhum pra mim?	じゃあ、ぼくにはひとつもくれないの？	意志を訊ねる		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
36	Vou pensar...	そうねえ、どうしようかしら……。	ためらいを表す		\N	dmod	pb02.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
37	Que bela vista! 	わあ、きれいな景色！	感動を表わす		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
38	Olha ali, minha filha. 	ほらみてごらん。	注意をひく		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
39	Em cima do muro.	塀の上だよ。	場所を言う		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
40	O que o senhor está vendo?	何が見えるの？	情報を求める（行動）		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
41	Uma abelha. 	蜂だよ。	情報を伝える		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
42	Não está vendo?	見えないかい？	情報を求める		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
43	Agora sim, bem perto do portão.	ああ、見えた。門のすぐ近くね。	情報を伝える（行動）、場所を言う		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
44	Olha, está vindo um passarinho!	ほら、小鳥が来るよ！	注意をひく		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
45	Ele vai pegar a abelha.	蜂を捕まえちゃう。	行動を描写する		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
46	Sim, pegou.	本当だ。捕まえた。	行動を描写する		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
47	Que triste, pai!	お父さん、なにか悲しいね！	感情を表す		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
48	Assim é a vida, minha filha.	人生なんてそんなものなんだよ。	意見を言う		\N	dmod	pb03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
49	Bom dia.	おはようございます。	挨拶をする		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
50	Bom dia, qual é o seu nome?	おはようございます。お名前は？	情報を求める（属性）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
51	O meu nome é Cláudia Soares de Souza.	クラウヂア・ソアレス・ヂ・ソウザと申します。	自己紹介する		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
52	Qual a sua idade?	お年は？	情報を求める（属性）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
53	Eu tenho 22 anos.	私は２２歳です。	情報を伝える（属性）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
54	Qual é a sua formação?	専攻は？	情報を求める（属性）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
55	Eu sou formada em computação.	コンピューターを専攻しました。	情報を伝える（属性）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
56	Sabe alguma língua?	語学はできますか？	情報を求める（能力）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
57	Eu sei francês.	フランスができます。	情報を伝える（能力）		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
58	Mas nós precisamos de alguém com domínio de inglês...	でも、こちらで必要なのは英語ができる方なんですよ……。	希望を述べる		\N	dmod	pb04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
59	Eu queria te pedir desculpas, pois ontem eu não pude vir.	昨日来られなかったこと、謝りたいと思って。	あやまる		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
60	Por quê?	どうしたの？	理由を訊ねる		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
61	Eu tive um problema em casa.	家でちょっとトラブルがあってね。	情報を伝える（行動）		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
62	Algo sério?	大変なこと？	情報を求める（属性）		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
63	Minha filha ficou doente e eu a levei ao médico.	娘が病気になっちゃって、医者に連れていったのよ。	情報を伝える（行動）		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
64	E ela agora já está bem?	で、もう今は大丈夫なの？	情報を求める（状態）		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
65	Sim, já está melhor.	うん、もうよくなったわ。	情報を伝える（状態）		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
66	Que bom!	そりゃ、良かった。	感情を表す		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
67	Mas eu queria te pedir desculpa por isso.	でも、そのことを謝りたかったの。	あやまる		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
68	Está bem.	いいよ。	許す		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
69	Está desculpada. 	大丈夫だよ。	許す		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
70	Mas da próxima vez, se possível, telefone avisando.	でも、今度そういうことがあったら、できれば電話して知らせてね。	要求する		\N	dmod	pb05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
71	Márcia, eu preciso que você me ajude.	マルシア、助けて欲しいんだ。	希望を述べる		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
72	Ajudar?	助ける？	聞き返す		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
73	Em quê?	何を？	情報を求める		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
74	Eu queria dar um presente de aniversário para a Cláudia.	クラウヂアに誕生日のプレゼントをあげたいんだよ。	希望を述べる		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
75	Uma roupa?	洋服？			\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
76	Uma bijuteria? 	アクセサリー？			\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
77	Um livro?	本？			\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
78	Um CD?	ＣＤ？			\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
79	Não sei...	わからないんだ……。	情報を伝える		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
80	Dê uma opinião.	お知恵拝借。	要求する		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
81	Bem... 	そうね……。	即答を避ける		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
83	Flores, não. 	花はだめだよ。	意見を言う		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
84	Morrem muito rápido.	すぐに枯れちゃうから。	情報を伝える（性質）		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
85	Então, por que você não compra um anel ou um colar para ela?	じゃあ、指輪かネックレスでも買ってあげたら？	提案する		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
86	Você vai comigo a uma joalheria? 	一緒にアクセサリー屋さんに行ってくれる？	依頼する		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
87	Eu não sei escolher.	ぼくには選べないよ。	情報を伝える（能力）		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
88	Claro que sim. 	もちろんいいわよ。	承諾する		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
89	Pode ser amanhã?	明日でもいい？	提案する		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
90	A festa tá muito boa, mas eu tenho que ir embora.	とっても楽しいパーティなんだけど、もう帰らなきゃならないんだ。	さよならを言う		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
91	Ah, não.	あら、そんなこと言わないで。	否定する		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
92	Fica mais um pouco.	もう少しいて。	引き止める		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
93	Mas eu tenho que ir.	でも、もう行かなきゃ。	さよならを言う		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
94	Mas não são nem onze horas.	でも、まだ１１時にもなってないじゃない。	情報を伝える（時間）		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
95	Mas eu tenho muito trabalho amanhã e tenho que estar no centro da cidade bem cedo.	でも、明日、仕事があるし、朝早く都心に行かなきゃならないんだ。	予定を言う		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
96	Ah, fica mais um pouquinho.	あら、もう少しだけいてよ。	引き止める		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
97	Não dá. 	だめなんだよ。	断る		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
98	Eu tenho que ir.	行かなきゃ。	さよならを言う		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
99	Já está ficando tarde.	もう遅いから。			\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
100	Você dorme com as galinhas.	あなたったら鶏と一緒に寝るの？	からかう		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
101	Não é isso. 	そんなことはないけど。	否定する		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
102	Eu tenho que ir, me desculpe. 	行かなきゃ。ごめん。	さよならを言う		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
103	Depois eu te telefono.	あとで電話するから。	予定を言う		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	1
104	Então, está bom. 	じゃあ、いいわ。	承諾する		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
105	Mas da próxima vez, vê se fica mais tempo.	でも、次回はもう少しいられるようにしてよ。	要求する		\N	dmod	pb07.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
106	Quanto custa esta camisa?	このシャツはいくらですか？	情報を求める（金額）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
107	Custa 50 reais.	５０レイスです。	情報を伝える（金額）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
108	Tudo isto?	そんなに？	聞き返す		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
109	Mas ela é de seda.	だって、絹ですよ。	情報を伝える（属性）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
110	Mas eu encontrei uma camisa também de seda numa outra loja perto daqui e era bem mais barata.	でも、この近くの店でやっぱり絹のシャツをみつけたけど、もっと安かったわよ。	情報を伝える（行動）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
112	E era como esta daqui. 	それで、これと同じだったわよ。	情報を伝える（属性）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
113	Se você fizer pelo mesmo preço, eu levo.	同じ値段にしてくれたら、いただくわ。	ある条件での行動を言う		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
114	Eu faço por 40. 	４０ならできますけど。	情報を伝える（金額）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
115	Pode ser?	それでいいですかね？	了承を求める		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
116	Então, tá. 	わかりました。	妥協する		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
117	É sua.	どうぞお持ち下さい。			\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
118	Eu fui convidado para trabalhar no Japão, mas eu nem imagino como é lá.	日本で働かないかって誘いが来たんだけど、そこがどんなところか想像もつかないんだ。	情報を伝える（行動）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
119	Você já foi ao Japão?	日本に行ったことある？	情報を求める（経験）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
120	Já. 	うん。			\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
121	O Japão é muito interessante.	日本はとても面白いわよ。	情報を伝える（属性）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
122	Principalmente Tóquio.	特に東京はね。	情報を伝える（経験）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
123	Me conte como é.	どんなところか教えて。	依頼する		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
124	As casas são muito pequenas, mas confortáveis.	家はとっても小さいけど、住み心地はいいわよ。	情報を伝える(属性)		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
125	E a alimentação?	じゃあ、食事は？	情報を求める		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
126	Eu comia em restaurantes ou fazia comida em casa. 	私はレストランで食べたり家で作ったりしてたわ。	情報を伝える（経験）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
127	Mas supermercados têm de tudo.	でも、スーパーに行けば何でもあるわよ。	情報を伝える		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
128	E a viagem?	行き帰りの飛行機は？	情報を求める		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
129	É muito cansativa, pois leva mais ou menos 25 horas de vôo.\n	とってもしんどいわよ。だって２５時間ぐらいかかるんだもの。	情報を伝える（時間）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
130	E o trabalho? 	じゃあ、仕事は？	情報を求める		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
131	Você trabalhava muito?	たくさん働いていたの？	情報を求める（経験）		\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
132	Como qualquer japonês.	まあ、日本人と同じようなものよ。			\N	dmod	pb09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
133	Atenção. 	聞いてください。	注意をひく		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
134	Hoje nós vamos visitar algumas igrejas e museus de Ouro Preto.	今日はこれからオウロ・プレットの教会と博物館にいくつか行きます。	予定を言う		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
597	O garçom abriu uma lata de azeitonas.	ウエイターは、オリーブの缶を開けた。	\N		\N	vmod	\N	\N	\N	0	1
135	Qual é a programação?	予定はどうなっていますか？	予定を訊ねる		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
136	A programação é: primeiro, nós vamos de manhã, às 9 horas, ao Museu da Inconfidência.	予定はですね、まず午前９時にインコンフィデンシア博物館に行きます。	予定を言う		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
137	Quanto tempo ficaremos lá?	どのくらいそこにいる予定ですか？	予定を訊ねる		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
138	O museu é muito grande. 	博物館はとても大きいんですよ。	情報を伝える（属性）		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
139	Umas duas horas, no mínimo.	最低２時間ですね。	予定を言う		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
140	E depois?	その後は？	予定を訊ねる		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
141	Vamos para a Igreja de São Francisco de Assis. 	聖フランシスコ教会に行きます。	予定を言う		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
142	Talvez a mais importante da cidade.	おそらくこれが町で一番重要な教会でしょうね。	情報を伝える		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
143	E, então?	それから？	予定を訊ねる		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
144	Aí nós vamos almoçar e depois vamos à Igreja do Pilar. 	それから昼食をとって、ピラール教会へ行きます。	予定を言う		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
145	Se sobrar tempo, vamos ao Museu do Oratório.	時間が余ったら、それからオラトリオ博物館へ行きましょう。	予定を言う		\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
147	Podemos continuar amanhã?	明日も続けられますよね。			\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
148	Boa noite. 	こんばんは。	挨拶する		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
149	O que a senhora deseja?	何にいたしましょうか？	希望を聞く		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
150	Não sei exatamente. 	よくわからないんですが。	情報を伝える		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
151	Qual a especialidade da casa?	ここのおすすめは何ですか？	情報を求める(属性)		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
152	Nós servimos massas e carnes.	パスタ類と肉がございますが。	情報を伝える		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
153	Qual carne o senhor tem?	肉は何がありますか？	情報を求める（種類）		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
154	Nós temos picanha, cupim e costela.	ピカーニャとクピンとリブがあります。	情報を伝える（種類）		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
155	Eu quero picanha.	ピカーニャをお願いします。	希望を述べる		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
156	Como a senhora prefere: mal passada, bem passada ou ao ponto?	レア、ウェルダン、ミディアムのうち、どのようになさいますか？	情報を求める（程度）		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
157	Muito bem passada.	十分焼いたの(をお願いします)。	希望を述べる		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
158	Meia picanha ou inteira?	量は１人前にしましょうか。それとも半皿にしましょうか？	情報を求める（程度）		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
159	Meia picanha.	半皿のピカーニャ(をお願いします)。	希望を述べる		\N	dmod	pb11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
160	Bom dia. 	おはようございます。	挨拶する		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
161	A que horas sai o ônibus para Mariana?	マリアーナへのバスは何時に出ますか？	情報を求める（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
162	Aqui do Rio não tem ônibus direto para Mariana.	ここリオからマリアーナへの直行便はありませんね。	情報を伝える(手段)		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
163	Então, como eu faço?	じゃあ、どうしたらいいですか？	情報を求める（手段）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
164	O senhor tem que pegar um ônibus para Ouro Preto.	まずオウロ・プレット行きのバスに乗らなければなりませんね。	手順と順序について述べる		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
165	A que horas ele sai? 	それは何時に出ますか？	情報を求める（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
166	E a que horas chega lá?	そして、到着するのは何時ですか？	情報を求める（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
167	Ele sai às 23:30 e chega às 6:30 mais ou menos.	午後１１時半に出て、だいたい６時半に着きます。	情報を伝える（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
168	E lá eu consigo ir rapidamente para Mariana?	そこからマリアーナへはすぐに行けますか？	情報を求める（手段）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
169	Tem ônibus de meia em meia hora. 	バスは３０分毎にあります。	情報を伝える(時間)		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
170	Ele pára em frente à rodoviária.	バスターミナルのすぐ前に止まりますよ。	情報を伝える（場所）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
171	E quanto tempo demora até Mariana?	じゃあ、マリアーナまではどのくらいかかりますか？	情報を求める（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
172	Cerca de meia hora. 	だいたい３０分ぐらいです。	情報を伝える（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
173	Mas de táxi leva só 15 minutos.	でも、タクシーなら１５分しかかかりませんよ。	情報を伝える（時間）		\N	dmod	pb12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
174	Eu preciso ir à casa da Cláudia. 	クラウヂアの家に行かなければならないんだ。	義務を確認する／肯定する		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
175	Você tem o endereço?	住所持ってる？	情報を求める（行動）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
176	Espera aí. 	ちょっと待って。	指示する		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
177	Vou olhar na minha agenda.	手帳見てみるからね。	情報を伝える（行動）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
178	Eu sei que ela mora na Avenida Rio Branco.	リオ・ブランコ通りに住んでいることは知っているんだけど。	情報を伝える（知識）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
179	Isso mesmo. 	そう、そのとおりよ。	同意する		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
180	O número do prédio é 512 (quinhentos e doze), apartamento 703 (setecentos e três).	建物の番地は５１２で、部屋は７０３号室よ。	情報を伝える（数字）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
181	E qual o número do ônibus?	で、バスの番号は？	情報を求める（数字）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
182	O ônibus é 162 (um, meia, dois).	バスは１６２。	情報を伝える（数字）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
183	Mas esse dá muita volta. 	でも、それはずいぶん大回りするよね。	確認する		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
184	Tem algum direto?	直通はないの？	情報を求める		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
185	Ah! 	あっ!	驚きを表す		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
186	É mesmo. 	本当ね。	同意する		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
187	Tem, sim. 	あるわ。	確認する		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
188	É o 274 (dois, sete, quatro).	２７４よ。	情報を伝える（数字）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[4]	\N	\N	\N
189	Me dá o número do telefone dela, caso eu me perca.	迷ったときのために、彼女の電話番号をもらえないかな。	情報を求める（数字）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
190	O número do telefone é 2221- 7020 (dois, dois, dois, um, setenta, vinte)	電話番号は２２２１－７０２０よ。	情報を伝える（数字）		\N	dmod	pb13.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
191	Como se faz caipirinha?	カイピリーニャはどうやって作るの？	情報を求める（方法）		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
192	Primeiro você tem que reunir os ingredientes.	まず材料を集めないとね。	何でどのようにするか言う		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
193	Quais?	何を？	情報を求める（種類）		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
194	Cachaça, água, gelo, limão e açúcar.	ピンガ、水、氷、レモン、それから砂糖。			\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
195	E aí?	それから？	情報を求める（手順）		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
196	Você corta o limão inteiro em oito pedaços. 	レモン１つを８つに切る。	何でどのようにするか言う		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
197	Põe num copo e soca com um pilão.	コップに入れて、乳棒でつぶすんだ。	何でどのようにするか言う		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
198	E depois?	それから？	情報を求める（手順）		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
199	Você acrescenta o açúcar, um pouco de água, gelo picado e um pouco de cachaça. 	砂糖、少量の水、砕いた氷、それから少量のピンガを入れる。	何でどのようにするか言う		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
200	Aí, você balança bem.	そして、よく振る。	何でどのようにするか言う		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
201	E como eu sirvo?	で、どうやって出せばいいの？	情報を求める（方法）		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
202	Passe para um copo limpo e o decore com uma rodela de limão.	きれいなコップに移し替えて、レモンの輪切りで飾るんだ。	何でどのようにするか言う		\N	dmod	pb14.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
203	Bom dia.	おはようございます。	挨拶する		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
204	Eu vi um anúncio de jornal. 	新聞の広告を見てきたんですが。	来歴を告げる		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
205	É aqui que estão precisando de uma empregada?	お手伝いさんを募集しているのはこちらですよね？	確認する		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
206	Sim. 	そうです。	肯定する		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
207	Mas precisamos de uma empregada que saiba fazer de tudo.	でも、何でもできるお手伝いさんが欲しいんですよ。	希望条件を述べる		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
208	Como assim?	と、おっしゃいますと？	聞き返す		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
209	Você sabe cozinhar?	お料理はできますか？	技能と能力についてたずねる		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
210	Sei, sim...	はい、できます。	肯定する		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
211	Gosto de lavar os pés num riacho.\n	小川で足を洗うのが好きだ。\n	技能と能力についてたずねる		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
212	Claro que sim.	もちろんできます。	肯定する		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
214	Ora, isto é muito simples para mim.	ああ、それは私にとっては簡単なことです。	情報を伝える		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
215	Então está contratada por um período de experiência de 30 dias.	じゃあ、まずは３０日間の試用期間をおいてお願いすることにしましょう。	契約する		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
216	Por favor, aqui tem um museu nacional?	すみません、ここに国立博物館はありますか？	情報を求める（存在と場所）		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
217	Sim, mas é complicado chegar lá. 	はい、ただ、行くのはややこしいですよ。	情報を伝える（場所）		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
218	Vou tentar te explicar.	ご説明してみましょう。	意図を告げる		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
219	Espere um minuto, que vou tomar nota.	ちょっと待っていただけますか。メモしますから。	依頼する		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
220	Você vai em frente e vira à direita no segundo sinal.	まっすぐに行って、２番目の信号を右に曲がってください。	手順と順序について述べる		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
221	O.k.	わかりました。	了解する		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
222	E depois?	それから？	手順を訊ねる		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
223	Aí, você segue toda vida até encontrar uma praça.	それから、ずっとずっと公園があるところまでまっすぐに行ってください。	情報を伝える（場所）		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
224	E então?	それから？	手順を訊ねる		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
225	Nesta praça, você entra na primeira rua à esquerda.	公園のところで、最初の通りを左に入ってください。	情報を伝える（場所）		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
226	Aí eu chego?	そうしたら着くわけですか？	情報を求める（存在と場所）		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
227	Não. 	いえ。	否定する		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
228	Dobre na terceira rua à esquerda, ande uns 100 metros e estará na porta do museu.	３番目の道を左に曲がって、100メートルぐらい歩くと、博物館の玄関に着きます。	情報を伝える（場所）		\N	dmod	pb16.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
229	Oi, Carla. 	おお、カルラ。	挨拶する		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
230	Eu ontem arrumei uma namorada.	昨日恋人ができたんだよ。	情報を伝える（行動）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
231	Ah, me conta como ela é.	へえ、どんな子か教えてよ。	情報を求める（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
232	Ela é baixa, magra e tem os olhos azuis.	小さくて、痩せていて、青い目をしてるんだ。	情報を伝える（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
233	Como é o cabelo dela?	彼女の髪はどんな感じ？	情報を求める（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
234	É encaracolado e castanho. 	カールしていてね、栗色なんだ。	情報を伝える（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
235	Bem comprido.	すごく長いんだよ。	情報を伝える（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
236	Ela é legal?	すてきな子かい？	情報を求める（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
237	Acho que sim. 	だと思うけど。	肯定する		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
238	Nós ainda estamos nos conhecendo.	まだ知り合っている段階だからね。	情報を伝える（行動）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
239	Mas que tipo de pessoa ela é?	で、どんな感じの子なんだい？	情報を求める（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
240	Ah, ela é muito simples, franca, carinhosa e atenciosa.	ああ、純朴で、正直で、やさしくて、よく気のつく子なんだ。	情報を伝える（属性）		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
241	Então, ela deve ser muito interessante.	じゃあ、なかなかいけそうだね。	意見を言う		\N	dmod	pb17.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
242	Vamos à seção de roupas? 	洋服売場に行かない？	提案する		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
243	Eu preciso comprar uma roupa para ir a uma festa.	パーティに着てゆく洋服を買わなきゃならないのよ。	義務を確認する／肯定する		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
244	O.k.	いいよ。	承諾する		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
245	Vamos lá.	行こう。	承諾する		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
246	Você acha que eu devo usar um vestido ou uma saia?	ドレスを着ていくべきだと思う？　それともスカートかしら？	意見を求める		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
247	Acho que você deve comprar um vestido.	ドレスを買うべきじゃないかな。	意見を言う		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
248	Curto ou longo?	短いの？　それとも長いの？	選択させる		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
249	Depende.	場合によりけりだけど。	判断を留保する		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
287	Aí você digita sua senha. 	それから暗証番号を入力する。	手順と順序について述べる		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
250	Se a festa for muito sofisticada, é melhor você usar um vestido longo.	もしきちんとしたパーティならば、長いドレスを着た方がいいんじゃない？	ある条件での行動を言う		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
251	Mas de que cor?	じゃあ、どんな色？	情報を求める(属性)		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
252	Acho melhor que você use cores escuras, como preto, azul-marinho ou marrom.\n	黒っぽい色を着た方がいいと思うわ。黒とか、紺色とか茶色とか。	意見を言う		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
253	E o que eu devo calçar?	じゃあ、何を履けばいいかしら？	意見を求める		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
254	É lógico que um sapato de salto bem alto e meia fina.	もちろんかかとが割と高い靴とストッキングでしょ。	意見を言う		\N	dmod	pb18.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
255	Que tipo de filme você prefere?	どんな映画が好き？	嗜好についてたずねる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
256	Eu prefiro ficção científica e aventura.	ＳＦとか冒険物がいいな。	嗜好について述べる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
257	Você não gosta de filme de faroeste?	西部劇とかは好きじゃないの？	嗜好についてたずねる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
258	Não, não gosto. 	いや、好きじゃない。	嗜好について述べる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
259	E gosto também de filme policial e de terror.	推理物とかテラー映画もいいな。	嗜好について述べる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
260	E você gosta de musical?	じゃあ、ミュージカルは好き？	嗜好についてたずねる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
261	Não, não gosto de nada. 	いや、全然好きじゃない。	嗜好について述べる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
262	Acho muito chato.	非常につまらないもの。	嗜好について述べる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
263	Ah, depende do musical. 	あら、それは映画によるんじゃない。	意見を言う		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
264	Hair, por exemplo, é um filme muito interessante.	例えば「ヘア」なんてとっても面白いと思うわ。	批評する		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
265	Você tem razão. 	たしかにそうだね。	同意する		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
266	É uma exceção. 	それは例外かな。			\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
267	E você gosta de desenho animado?	で、君はアニメなんかは好き？	嗜好についてたずねる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[3]	\N	\N	\N
268	Adoro!	大好き！	嗜好について述べる（もの）		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
269	Eu também gosto.	ぼくも好きなんだ	好みを言う		\N	dmod	pb19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
270	O que você gosta de fazer no fim de semana?	週末は何をするのが好きなの？	嗜好についてたずねる（行動）		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
271	Eu gosto de fazer compras.	買い物をしたりするのが好き。	嗜好について述べる（行動）		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
272	Que tipo de compras?	買い物って、どんな？	情報を求める（種類）		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
273	Ah, não sei. 	そうね、どんなのかしらね。	答えを留保する		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
274	Eu entro num shopping center e vou passando por todas as seções. 	ショッピングセンターに入って、あらゆる売場を回るの。	行動について述べる		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
275	Aí eu escolho. 	それから選ぶのよ。	行動について述べる		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
276	E você? 	あなたは？	聞き返す		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[4]	\N	\N	\N
277	Eu gosto de ficar em casa dormindo, vendo TV, lendo livros...	ぼくは家でごろごろ寝て、テレビを見て、本を読んで……。	嗜好について述べる（行動）		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
278	Sempre isto?	いつもそうなの？	情報を求める（行動）		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
279	Não. 	いや。	否定する		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
280	Às vezes, eu gosto de ir num cinema ou numa peça de teatro.	ときどきは映画に行ったり、劇を見に行ったりもするけど。	嗜好について述べる（行動）		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
281	Então, é muito difícil nós passarmos um fim de semana juntos.	じゃあ、私たちが一緒に週末を過ごすのは非常に難しいわね。	意見を言う		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
282	Por quê?	どうして？	理由をたずねる		\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
283	Ora, nossos gostos não combinam.	だって、私たちは好みが合わないもの。			\N	dmod	pb20.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
284	Como eu faço para sacar dinheiro no caixa automático?	 ATMでお金を下ろすにはどうしたらいいの？	情報を求める（手順）		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
285	Primeiro você insere o cartão e depois...	まずカードを差し込んで、それから……。	手順と順序について述べる		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
286	E depois?	それから？	情報を求める（手順）		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
288	Cuidado para ninguém ver você digitando os números.	番号を押してるところを人に見られないように気をつけてね。	注意する		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
289	E então?	それで？	情報を求める（手順）		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
290	Depois você digita o valor que você quer retirar.	それから引き出したい金額を入力する。	手順と順序について述べる		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
291	É só?	それだけ？	確認する		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
292	Não, você tem que apertar a tecla que confirma a operação.	いや、手続きを確認するキーを押さなきゃいけない。	手順と順序について述べる		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
293	E o que mais?	その他には？	情報を求める（手順）		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
294	O caixa, então, devolverá primeiro o seu cartão e, em seguida, imprimirá e soltará o extrato bancário, além do dinheiro.	そしたらまずカードが機械から出てきて、その次にお金と一緒に利用明細書が印刷されて出てくる。	手順と順序について述べる		\N	dmod	pb21.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
295	Oi, como está você?	やあ、元気？	どうしているかたずねる		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
296	Tudo bem.	元気だよ。	挨拶をする		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
297	E sua família?	家族のみんなは？	どうしているかたずねる		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
298	A minha mãe vai bem, mas meu pai não está muito bem de saúde.	母は元気だけど、父は調子が良くないんだ。	情報を伝える（健康）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
299	Mas o que é que ele tem?	どうしたの？	情報を求める（健康）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
300	Ainda não sabemos. 	まだわからない。			\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
301	Ele está fazendo mil exames.	ものすごい数の検査をしてるんだけど。	情報を伝える（行動）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
302	E ele tem tido acompanhamento médico sistemático?	今までずっとお医者さんにきちんと診てもらってきているんでしょ？	情報を求める（行動）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
303	Claro que sim, ainda que ele não goste de ir a médicos.	もちろん、お父さんは病院に行くのが嫌いなんだけどね。	情報を伝える（行動）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
304	E o que vocês fazem?	それであなたたちはどうするの？	情報を求める（行動）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
305	Bem, nós tentamos conversar com ele e convencê-lo a não deixar de ir a nenhuma consulta.	うん、よく話をして、診察を一度も欠かすことのないように説得しようとしているんだ。	情報を述べる（行動）		\N	dmod	pb22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
306	Se você fosse presidente da República, o que você faria?	もしあなたが共和国大統領だったら何をする？	ある条件での行動をたずねる		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
307	Antes de qualquer coisa, eu tentaria aumentar o salário mínimo.	何よりもまず、最低賃金を引き上げるね。	ある条件での行動を言う		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
308	Mas se você aumentar o salário, os preços vão disparar...	でも賃金を上げちゃったら物価が釣り上がるわ。	ある条件での行動を言う		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
309	Não, pois eu iria controlar a inflação, estabelecendo limites para os juros.	そんなことはないよ、だって利子の上限を設定してインフレは防ぐから。	ある条件での行動を言う		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
310	E o que mais você faria?	他には何をする？	ある条件での行動をたずねる		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
311	Eu cuidaria da educação, para acabar de vez com o analfabetismo.	教育のことを考えるな、文盲を完全になくすように。	ある条件での行動を言う		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
312	Como?	どうやって？	方法をたずねる		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
313	Construindo escolas, dando melhores salários para os professores, e também melhorando a merenda escolar.\n	学校を作って、先生たちにはより高い給料を与えて、給食も改善する。	方法について述べる		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
314	E o que mais?	他には？	追加事項をたずねる		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
315	Algo muito importante: eu faria uma reforma agrária.	とても重要なこと。つまり、農業改革をするよ。	ある条件での行動を言う		\N	dmod	pb23.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
316	Quais são as diferenças que você vê entre o Brasil e o Japão?	あなたから見て、ブラジルと日本の違いって何？	違いをたずねる		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
317	Antes de tudo, o Brasil é muito maior do que o Japão.	何よりもまず、ブラジルは日本よりずっと大きい。	比べて述べる		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
318	Será que o Brasil é o maior país do mundo?	もしかしたらブラジルって世界一大きい国なのかしら？	比べて問う		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
319	Não, é o quinto maior. 	いや、五番目だね。	比べて述べる		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
320	Mas é o maior país da América do Sul.	でも南アメリカでは一番だよ。	比べて述べる		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
392	Nós concedemos esta mudança. 	その変更は妥協しましょう。	妥協する		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
321	Mas é muito mais jovem do que o Japão.	でも日本よりずっと新しい国なのよね。	比べて述べる		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
322	Sem dúvida, o Brasil tem só 500 anos de existência.	確かにブラジルができてから５００年しか経っていない。	情報を伝える（属性）		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
323	E tem muitas riquezas naturais.	自然資源はとても豊かね。			\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
324	É mesmo, o Japão tem muito poucas.	そうだね、日本には少ししかない。			\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
325	E as semelhanças?	似ているところは？	比べてたずねる		\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
326	A profunda americanização desses países hoje.	どっちも今では深くアメリカナイズされてるところかな。			\N	dmod	pb24.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
327	Nós precisamos salvar nossa empresa. 	私達は会社を救わなければなりません。	意見を言う		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
328	Ela está passando por uma fase muito difícil.	実に厳しい局面を迎えています。	情報を伝える（行動）		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
329	Não sei o que fazer. 	何をすればいいのかわかりません。	意見を言う		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
330	Diga lá sua proposta.	あなたからの提案は？	提案を求める		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
331	Eu proponho reaplicar nossas ações.	私たちの株の再投資をしてはどうでしょうか。	提案する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
332	Talvez devêssemos demitir alguns funcionários. 	おそらく従業員を何人か解雇しなければならないでしょう。	提案する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
333	O que acha disto?	どう思われますか？	意見を求める		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
334	Acho problemático, pois não será bom para a imagem da empresa.	それは問題含みだと思います、会社のイメージを傷つけますから。	意見を言う		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
335	Então, podemos pensar em férias coletivas.	では、レイオフを考えてみてもいいですね。	提案する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
336	Sim, é uma alternativa. 	ええ、それも一つの案ですね。	意見を言う		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
337	Mas acho que também devemos apostar numa publicidade mais agressiva.	しかし、より積極的な広報活動に賭けてみることも考えなければならないでしょう。	提案する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
338	Mas temos que ter muito cuidado com isto para o feitiço não virar contra o feiticeiro.	しかし、ミイラ取りがミイラになるようなことにならないよう十分気をつけなければなりません。	注意を喚起する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
339	Podemos também promover uma liqüidação em parte de nossos produtos.	我が社の製品の一部のバーゲンセールを推進することもできますね。	提案する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
340	E talvez abrir algumas filiais nos novos shoppings da cidade.	それにたぶん、街の新しいショッピングセンターに支店を出すことも。	提案する		\N	dmod	pb25.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
341	Por que você se separou dele?	どうして彼と別れたの？	理由をたずねる		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
342	Ah, por muitos motivos.	ああ、たくさん理由があったのよ。	理由を述べる		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
343	Diga-me, então.	じゃあ、言ってごらんよ。	依頼する		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
344	Antes de mais nada, porque ele não era carinhoso.	何よりもまず、優しくなかったから。	理由を述べる		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
345	Ora, mas era o jeito dele.	でも、それが彼のスタイルだったんでしょ。	批評する		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
346	Também nunca chegava na hora, ou então, nem telefonava dizendo que não vinha.	それに遅刻ばっかりしてたし、来なければ来ないで、それを電話で知らせることすらしてくれなかったのよ。	理由を述べる		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
347	Mas ele é uma pessoa muito ocupada.	彼はすごく忙しい人なんだよ。	批評する		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
348	Mas eu também sou, e sempre avisava.	私だってそうだけど、連絡はいつもしてたわ。	情報を伝える（行動）		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
349	Você está sendo muito exigente. 	君は注文が多いね。	意見を言う		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
350	Vai ficar sozinha.	一人になっちゃうよ。	意見を言う		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
351	Eu prefiro ficar sozinha do que ser tratada sem cuidados.	優しくされないよりは一人の方がましよ。	嗜好について述べる（行動）		\N	dmod	pb26.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
353	Eu tenho que sair hoje à noite. 	僕、今夜、でかけなきゃならないんだ。	予定を言う		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
354	Você poderia ficar com os meninos para mim?	子供たちの面倒を見てくれないかな？	依頼する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
355	Claro que sim, Carlos. 	もちろんよ、カルロス。	承諾する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
356	O que eu tenho que fazer?	何をすればいいの？	義務をたずねる		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
755	O sol nasce no leste.\n	太陽は東から昇る。\n	\N		\N	vmod	\N	\N	\N	0	1
357	Você tem que dar comida para eles às 7 horas da noite. 	夜七時に夕食を食べさせる。	義務を確認する／肯定する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
358	Eu já deixei a comida pronta. 	食事は用意しておいたから。	情報を伝える（行動）		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
359	Se você conseguisse cuidar disto...	もし君にその世話をしていただければ……。	依頼する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[3]	\N	\N	\N
360	Claro. 	もちろん。	承諾する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
361	E o que mais?	それで他には？	義務をたずねる		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
362	Você pode deixar eles verem TV, mas só até às 10 horas da noite.	子供たちにテレビを見せてもいいけど、１０時までだけにしてね。	義務を確認する／肯定する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
363	E se eles quiserem brincar lá fora?	で、外で遊びたがったら？	ある条件での行動をたずねる		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
364	Só se for em frente da casa.	家の前でならいいよ。	ある条件での行動を言う		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
365	Você pode ficar com eles lá fora?	君が外でついていてやってくれるかな？	依頼する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
366	Sim, eu fico.	いいわよ、ついているわ。	承諾する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
367	Será que você podia também colocar a pijama neles e levá-los para a cama?\n	それに、パジャマを着せて、ベッドに連れていってくれたりもするかな？	依頼する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
368	Sem dúvida, Carlos.	もちろんよ、カルロス。	承諾する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
369	Não se preocupe. 	心配しないで。	安心させる		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
370	Vá se divertir com seus amigos.	友達と楽しんでいらっしゃいよ。	行動を促す		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
371	Paulo, o que significa o provérbio “Casa de ferreiro, espeto de pau”?	ねえパウロ、「鍛冶屋の家に木製の串」（紺屋の白袴）ってことわざ、どういう意味？	意味をたずねる		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
372	Significa que onde nós mais esperamos que haja alguma coisa, lá nós não a encontramos.	ある物が最もありそうだと思えるところにそれがない、ってことだよ。	意味を説明する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
373	Você pode me explicar de outro jeito?	他の方法で説明してもらえる？	依頼する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
374	Pense na casa de um médico que não tenha remédios.	薬がない医者の家を考えてごらんよ。	指示する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
375	Como assim? 	どういうこと？	聞き返す		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
376	Pode me dar outros exemplos?	他の例を出してくれる？	例示を求める		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
377	Por exemplo, um professor de línguas que não tenha dicionários.	たとえば、辞書を持ってない語学教師とか。	例をあげて述べる		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
378	Mas ele tem que ter dicionários!	でも、そういう人なら辞書は持っていなきゃ！	驚きを示す		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
379	Exatamente por isto é surpreendente tal fato.	だからこそ、そういうことが驚くべきことなんだよ。	説明する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
380	Explique-me melhor as palavras do provérbio.	このことわざの言葉をもっとよく説明して。	依頼する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
381	Ferreiro é aquele que fabrica objetos de ferro.	鍛冶屋っていうのは鉄の物を作る人のこと。	意味を説明する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
382	Ora, na casa dele o espeto é de pau. 	でもその人の家では、串が木製なんだよ。	説明する		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
383	Espeto, por exemplo, para fazer churrasco. 	串ってたとえばシュラスコを作るときのね。	例をあげて述べる		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[3]	\N	\N	\N
384	Ora, o espeto tinha que ser de ferro também.	だから串だって鉄製じゃないといけないでしょ。	ある条件での行動を言う		\N	dmod	pb28.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[4]	\N	\N	\N
385	O partido situacionista quer fazer uma reforma tributária.	与党は税制改革をしようとしています。	情報を伝える（行動）		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
386	Mas o partido de oposição não concorda com a redação da legislação proposta.	しかし野党は提出された法案の草稿には同意しません。	非同意を示す		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
387	Mas se nós alterarmos a redação?	しかし、もしわれわれが案の草稿を変更したら（いかがですか）？	ある条件での行動をたずねる		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
388	Só se no texto da legislação estiver previsto que os latifundiários paguem mais imposto.	大地主が税金をもっと多く払うよう法文で規定されればの話ですね。	ある条件での行動を言う		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
389	Mas qual o percentual que você acha justo?	では、どれくらいの税率が妥当だと思われますか？	情報を求める（程度）		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
390	No mínimo, 10% de sua renda anual.	最低でも年収の１０％ですね。	情報を言う（程度）		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
391	O.k. 	わかりました。	承諾する		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
393	Mas vocês aceitam votar a reforma imediatamente?	ではそれで、あなた方は直ちに改革に投票して下さいますか？	同意の是非をたずねる		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
394	Tudo bem, nós concordamos. 	わかりました、同意しましょう。	同意する		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
395	Mas só se vocês permitirem que nós participemos da redação do texto final.	しかし私たちが最終的な法文の起草に加わることをあなた方が認めれば、の話です。	ある条件での行動を言う		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
396	Nós admitimos a presença de vocês.	あなた方が加わることを承認しましょう。	承認する		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
397	Então, está combinado.	では、そういうことにしましょう。	同意する		\N	dmod	pb29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
398	Mãe, a senhora permite que eu saia com seu carro hoje à noite?	お母さん、今夜、お母さんの車で出かけるの許してくれない？	許可を求める		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
399	Depende.	場合によるわね。	留保する		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
400	Com quem você vai sair?	誰と出かけるの？	情報を求める（人）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
401	Com minha namorada.	彼女とね。	情報を伝える（人）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
402	E aonde vocês vão?	それで、どこに行くの。	情報を求める（存在と場所）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
403	Vamos numa discoteca.	ディスコに行くんだ。	情報を伝える（場所）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
404	E vão beber?	お酒は飲むの？	情報を求める（行動）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
405	Ah, mãe, um pouquinho.	お母さん、少しだけだよ。	情報を伝える（程度）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
406	Mas não se pode beber e dirigir. 	でも、飲んで運転するのはいけませんね。	禁止する		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
407	E a que horas o senhor pensa em voltar?	それで一体何時にお帰りですか？	情報を求める（時間）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
408	Eu volto até as 2 horas da manhã.	午前２時までには帰るよ。	情報を伝える（時間）		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
409	Mas que é isto? 	何ですって？	驚きを示す		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
410	Só permito se voltar à meia-noite.	１２時に帰ってくるんなら許してあげる。	ある条件での行動を言う		\N	dmod	pb30.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
411	Senhor Antônio, eu já telefonei para o Sr. Carlos. 	アントニオさん、カルロスさんにはもう電話いたしました。 	過去の行動を報告する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
412	E ele pode vir à reunião? 	で、彼は会議に来られるの？ 	可能性をたずねる		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
413	Sim, ele confirmou sua presença. 	はい、出席を確認してくださいました	予定を確認する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
414	E o Sr. Paulo, a senhora se lembrou de ligar para ele? 	それからパウロさんについては、忘れないで電話してくれましたか？ 	義務を確認する／肯定する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
415	Claro que sim, ele também vai vir. 	もちろんですとも、（彼は）いらっしゃいます。 	予定を言う		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
416	Eu sei quais são as minhas obrigações. 	私、自分のすべきことはちゃんとわかっていますもの。 	義務を確認する／肯定する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
417	A senhora tem que redigir a ata da reunião anterior. 	（あなたは）前回の会議の議事録も書いてくれないとね。 	義務を確認する／肯定する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
418	Estou quase acabando, seu Antônio. 	もうほぼ終わりかけています、アントニオさん。 	経過を報告する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
419	E logo vou passá-la para o senhor corrigir. 	で、すぐに見ていただくために（あなたに）お渡しします。 	予定を言う		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
420	E a senhora preparou a pauta da reunião que vamos fazer? 	それから（あなたは）これから（私たちが）やる会議の議題は用意しましたか？ 	過去の行動をたずねる 		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
421	Sim, está aqui, Sr. Antônio. 	はい、ここにあります、アントニオさん。 	注意をひく		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
422	Muito obrigado, Dona Fátima. 	どうもありがとう、ファチマさん。 	感謝する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
423	A senhora é uma ótima secretária.	（あなたは）最高の秘書ですね	人を描写する		\N	dmod	pb31.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
424	A sua saia tem de cobrir o joelho. 	あなたのスカートは膝が隠れるくらいじゃないといけませんよ。 	義務を確認する／肯定する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
425	Mas é muito comprida! 	でも、あまりに長すぎますよ。 	描写する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
426	Mas tem de ser. 	でも、そうでなくちゃね	義務を確認／肯定する 		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
427	E você não pode pintar as unhas. 	それに、爪を塗るのはだめだよ。	禁止する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
428	Nossa! 	ええっ！ 	驚きを表わす		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
429	Mas meus pais permitem... 	でも、私の両親は許してくれますよ……。			\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
430	E nem usar maquiagem. 	それに化粧だってだめだよ。 	禁止する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
431	Então, o que eu posso fazer? 	じゃあ、どうすればいいんですか？	指示を仰ぐ		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
432	Você também não pode pintar o cabelo. 	あと髪の毛も染めちゃいけないよ。	禁止する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
433	Tá bom!	わかりました！	承諾する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
434	E você tem que usar o uniforme completo. 	それから制服も全部きちんと着なきゃだめだよ。 	義務を確認する／肯定する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
435	O.k. 	わかりました。	承諾する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
436	Eu já comprei. 	（私は）もう買いました。	過去の事実を報告する		\N	dmod	pb32.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
437	Como eu devo proceder para estudar a literatura brasileira?	ブラジル文学を勉強するには何から始めればいいんでしょうか？	アドバイスを求める		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
438	Você já viu os livros na biblioteca?\n	図書館の本は見た？	情報を求める（経験）		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
439	Não, ainda não.	いえ、まだです。	経験を否定する		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
440	E você já consultou as obras de referência: dicionários, enciclopédias?	で、辞書とか百科事典みたいな参考図書は？	情報を求める(経験)		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
441	Já olhei algumas.	いくつかは見ました。	情報を伝える(経験)		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
442	A literatura brasileira é um assunto amplo demais!	ブラジル文学っていうのは広すぎるテーマだなあ。	意見を言う		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
443	Eu sei.	わかってます。	相づちを打つ		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
444	O que eu devo fazer?	何をしたらいいんですか？	アドバイスを求める		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
445	Você deve ler alguns manuais e escolher estudar um período ou um autor.	入門書を読んで、ある時代の研究をするのか、ある作家の研究をするのか、選ぶことだね。	指示する		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
446	Mas isso não é muito pouco?	でもそれってとても少なくないですか？	意見を言う		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
447	Claro que não, pois a partir de um autor você pode chegar a muitos outros assuntos.	もちろん少なくないよ、一人の作家から出発しても他のたくさんのテーマにたどり着けるからね。	理由を述べる		\N	dmod	pb33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
448	Senhores passageiros, solicitamos que não fumem durante todo o vôo. 	ご搭乗のみなさま、フライトのあいだは喫煙をご遠慮下さるようお願いします。	非行為を依頼する		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
449	Nossa!	何だって！	嘆く		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
450	Vou ter que ficar sem fumar.	ずっと煙草を吸えないんだって！	未来の義務を言う		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
451	Solicitamos também que não deixem seus assentos enquanto as luzes estiverem acesas.	またライトがついているあいだは座席をお立ちにならないようお願いします。	非行為を依頼する		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
452	Isso pode demorar muito tempo.	まだまだ時間がかかりそうだなあ。	可能性を言う		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
453	Solicitamos ainda que não usem laptops até a permissão da cabina de comando.	また、操縦室からの許可がおりるまでは、ノートパソコンをご使用なさらないようお願いします。	非行為を依頼する		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
454	Que bom!	よかった！	喜ぶ		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
455	Ao menos poderei trabalhar durante o vôo.	少なくても飛行中は仕事ができるってことだ。	未来の可能性を言う		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
456	Solicitamos que não usem telefones celulares durante toda a viagem.	全行程中、携帯電話をご使用にならないようお願いします。	非行為を依頼する		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
457	Tudo bem.	オーケー。	了解する		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
458	Ligações durante o vôo ficam muito caras.	フライト中の通話はすごく高いからね。			\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
459	Socilitamos que os senhores passageiros não abram a mesa nas costas do assento da frente durante a decolagem.\n	ご搭乗の皆様、離陸のあいだは前方座席後ろのテーブルをお出しになさらないようお願いします。	非行為を依頼する		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
460	Quanta proibição!	禁止ばっかりだ！	嘆く		\N	dmod	pb34.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
461	Você já foi ao banco?	銀行に行ってくれた？	義務の履行を確認する		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
462	Isso não é minha obrigação.	それは私がすることじゃないでしょ。	義務を否定する		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
464	Mas eu não tenho tempo!	でも俺には時間がないんだよ。	言い訳をする		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
465	Mas eu não vou.	でも私は行かないわよ。			\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
466	Já tenho que cuidar da casa e das crianças.	家事もしなきゃなんないし、子供の面倒もみなきゃいけないんだから。	理由を述べる		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
467	Você já fez compras?	買い物は済んだ？	義務の履行を確認する		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
468	Isso também não é minha obrigação.	それも私のすることじゃないわ。	義務を否定する		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
469	Nós tínhamos combinado que você faria as compras todo mês.	買い物は毎月あなたがするって決めたじゃない。			\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
470	Mas eu ando completamente sem tempo!	でも俺は全く暇がないんだよ。	言い訳をする		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
471	Muito trabalho na firma.	会社に仕事がいっぱいあるんだ。			\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
472	Quer trocar?	じゃあ代わる？	提案する		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
473	Eu vou para a firma e você fica aqui cuidando da casa e das crianças.	私が会社に行って、あなたがここで家事をして子供の面倒を見る。	提案する		\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
475	Não, eu estou falando sério.	いいえ、本気よ！			\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
476	Oi, Cláudia.	やあ、クラウヂア。	挨拶をする		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
477	Estou ligando para te convidar para vir à minha casa.	君を我が家に誘おうと思って電話したんだ。	招待する		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
478	Vou dar uma festa no sábado à noite.	土曜日の夜にパーティをやるんだ。	予定を言う		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	1
479	Você quer vir?	君も来る？	招待する		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[4]	\N	\N	\N
480	Mas qual o motivo desta festa?	でも何のためのパーティ？	理由をたずねる		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
481	Não tem nenhum motivo especial.	特に何も。			\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
482	Quero apenas reunir os amigos.	友達を集めたいだけだよ。	希望を述べる		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
483	Não tenho certeza se vou, tenho que pensar.	行くかどうかわからないわ、考えてみなきゃ。	あいまいな返事をする		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
484	Ah, venha, por favor.	ああ、お願いだから来てよ。	依頼する		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
485	Eu posso te dar a resposta amanhã?	明日返事してもいい？	許可を求める		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
487	Mas se você não puder vir, quer ir comigo ao cinema no domingo?	でも来れないんなら、日曜に映画見に行かない？	招待する		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
488	Está passando Tom e Jerry.	トムとジェリーをやってるんだけど。	情報を伝える		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
489	Tom e Jerry?	トムとジェリー？	聞き返す		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
490	Mas é muito infantil.	子供っぽすぎるわよ。	批評する		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
491	Mas você não disse que gostava de desenho animado?	でもアニメ好きだって言ってなかった？			\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
492	Você conhece MacLaren?	マクラーレンって知ってる？	知識を問う		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
493	Oi, Paulo.	あらパウロ。	挨拶する		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
494	Eu vou para o interior.	私内陸の方に行くのよ。	予定を言う		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
495	Para a fazenda de uma amiga.	友達の女の子のところの農場に。			\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[3]	\N	\N	\N
496	Nós vamos juntas no meu carro.	私の車で一緒に行くの。	予定を言う		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[4]	\N	\N	1
497	Eu queria te dar um conselho.	アドバイスしてもいいかな。	希望を言う		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
498	Você já fez verificação geral do carro?	君はもう車の総点検はした？	過去の行動を確認する		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
499	Como assim?	というと？	聞き返す		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
500	Eu acho que você tem que checar os pneus, se estão calibrados.	タイヤは調べるべきだよ、空気圧が調整されているかどうかね。	助言する		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
501	E se seu estepe está em boas condições.	それに替えのタイヤがいい状態にあるかどうかもね。			\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
502	O.k.	わかった。			\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
503	Isto eu faço.	それは私がやるわ。			\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
504	É necessário também verificar o óleo e, se for necessário, trocá-lo.	オイル確認して、それでもし必要なら取り替えなきゃね。	助言する		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
505	Isto eu vou num posto aqui perto de casa e eles olham pra mim.	それは家の近くのスタンドに行って見てもらうわ。	予定を言う		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
540	É uma pessoa fantástica, muito bonita e inteligente.	すごくすばらしい人なんだ、美人だし頭もいい。	批評する		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
756	Com licença.	すみません。	\N		\N	vmod	\N	\N	\N	0	1
506	É bom que os vidros estejam bem limpos e que você confira se os faróis, faroletes e setas estão funcionando bem.	ガラスはきれいにしておいた方がいいし、ヘッドライトとテールライトとウィンカーがちゃんと作動するかも点検した方がいいよ。	助言する		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
507	Isto eu mesma faço.	それは私が自分でやるわ。	予定を言う		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
508	Não seria melhor você ter uma companhia masculina nesta viagem?	男性の連れが一人いた方がいいんじゃない？	提案する		\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
509	Homens entendem muito de carro.	男は車に詳しいからね。			\N	dmod	pb37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
510	Sr. Carlos, eu vim aqui hoje para receber meu salário. 	カルロスさん、今日はお給料をいただきに来ました。	目的を話す		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
511	Maria, hoje eu estou sem dinheiro.	マリア、今日はお金持ってないんだ。	現在の状態を述べる		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
512	Mas Sr. Carlos, o pagamento já está atrasado há uma semana.	でもカルロスさん、もう一週間も遅れてるんですよ。	現在の継続状態を言う		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
513	Eu sei, Maria, mas não é possível você esperar mais uns dias?	わかってるよマリア、でももう何日か待ってもらえないかな？	可能性をたずねる		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
514	Seu Carlos, eu já esperei demais e também tenho que pagar minhas contas como o senhor.	カルロスさん、もう十分待ちましたし、あなたと同じように私にも支払いがあるんです。	義務を確認する/肯定する		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
515	Vamos fazer um trato?	じゃあ、こういう風にしない？	提案する		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
516	Eu te dou metade amanhã e a outra metade na semana que vem.	半分は明日渡すから残りの半分は来週ということにね。	提案する		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
517	Impossível, seu Carlos.	無理です、カルロスさん。	否定する		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
518	Metade não dá para pagar minhas contas, e eles já estão quase cortando a luz e a água lá de casa.	半分じゃ支払いに足りません、それにもう家の電気も水も止められそうなんです。			\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
519	Mas, Maria, o que é que eu posso fazer?	でもマリア、じゃあぼくはどうすればいいんだい？	手順をたずねる		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
520	Ué?	ええ？	驚く		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
521	Me pagar.	私に払ってくれればいいんですよ。			\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
522	Eu exijo que o senhor me pague o quanto antes!	できる限り早く私に支払って欲しいんですよ。	要求する		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[3]	\N	\N	\N
523	Tá bem, Maria.	わかったよ、マリア。	承諾する		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
524	Eu vou agora ao banco fazer um empréstimo.	今から銀行へ行って借りてくるよ。	予定を言う		\N	dmod	pb38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
525	Bom dia.	おはようございます。	挨拶をする		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
526	Aí é uma agência de casamentos, não é mesmo?	そちらは結婚相談所ですよね？	確認する		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
527	É, sim, senhor.	そうです。	肯定する		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
528	O que deseja?	どうなさいました？	希望をたずねる		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
529	Bem, eu vivo muito sozinho e queria arrumar uma companhia.	ええと、私はずっと一人で暮らしてきたので、連れがほしいんです。	希望を述べる		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
530	Que tipo de companhia o senhor quer?	どんなタイプがお望みですか？	嗜好についてたずねる		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
531	Eu gosto de mulheres que queiram passar o fim de semana comigo em minha casa.	週末を私と一緒に家ですごしてくれるような女性が好みです。	嗜好について述べる（人)		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
532	Hoje em dia, isto é muito difícil.	今の時代、それは非常に難しいですね。	説明する		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
533	Eu sei, mas não custa tentar.	わかってます、でもやるだけやってみるのに難はないでしょう。	食い下がる		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
534	Gostaria também que ela tivesse mais ou menos a minha idade, 30 anos.	それから私と同じ３０歳くらいの方がいいです。	希望を言う		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
535	Esta faixa etária também é difícil.	この年代も難しいですよね。	批評をする		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
536	E que saiba cozinhar muito bem.	それに料理が上手で。	希望を言う		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
537	Assim o senhor nunca vai arranjar uma companhia.	そんな風では連れは絶対に見つかりませんよ。	意見を言う		\N	dmod	pb39.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
538	Oi, Cláudia, eu queria te apresentar uma pessoa no próximo fim de semana.	やあ、クラウヂア、来週末、紹介したい人がいるんだ。	人を紹介する		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
539	Quem?	誰？	情報を求める(人)		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
541	Onde você a conheceu?	どこで彼女と知り合ったの？	情報を求める（存在と場所)		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
542	Por aí, na rua.	その辺の街でね。	場所を説明する		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
543	E vocês se tornaram amigos?	で、友達になったのね？			\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
544	Não exatamente.	というわけでもないんだ。	否定する		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
545	Como assim?	どういうこと？	聞き返す		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
546	Ela é minha namorada, Cláudia.	彼女はぼくの恋人なんだ、クラウヂア。			\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
547	Oh!	えっ！	驚く		\N	dmod	pb40.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
548	Campos do Jordão teve ontem o dia mais frio para um mês de abril nos últimos vinte anos.	昨日カンポス・ド・ジョルダンでは、4月としてはこの20年で最も寒い日となりました。	\N		\N	vmod	\N	\N	\N	0	1
549	A vida social dos adultos é muito complexa.	成人の社会生活は実に込み入っている。	\N		\N	vmod	\N	\N	\N	0	1
550	Avise o pessoal que o almoço vai atrasar.	昼食が遅くなると皆に伝えてください。	\N		\N	vmod	\N	\N	\N	0	1
551	Aquela torre tem mais de quinze metros de altura.\n	あの塔は15メートル以上の高さがある。	\N		\N	vmod	\N	\N	\N	0	1
552	Fui o primeiro aluno a chegar na sala de aula.	私は教室に最初に到着した生徒だった。	\N		\N	vmod	\N	\N	\N	0	1
554	O escritório fica no quinto andar.	事務所は5階にあります。	\N		\N	vmod	\N	\N	\N	0	1
555	Andamos bastante, pois o acampamento ficava bem longe da cidade.	キャンプ地が街から非常に遠かったので、私たちは沢山歩きました。	\N		\N	vmod	\N	\N	\N	0	1
556	A festa estava muito animada.	パーティーはとてもにぎやかでした。	\N		\N	vmod	\N	\N	\N	0	1
557	Compramos uma pequena casa no ano passado.	私たちは昨年小さな家を購入しました。	\N		\N	vmod	\N	\N	\N	0	1
558	Liguei o aquecedor pois estava com frio.\n\n	寒かったのでストーブをつけた。\n	\N		\N	vmod	\N	\N	\N	0	1
559	O carro dele vem atrás daquele táxi.\n	彼の車はあのタクシーの後ろから来ます。\n	\N		\N	vmod	\N	\N	\N	0	1
560	Ele pegou gripe e faltou a aula.\n	彼の車はあのタクシーの後ろから来ます。\n	\N		\N	vmod	\N	\N	\N	0	1
561	Ele pegou gripe e faltou a aula.\n	彼は風邪を引いて授業を休んだ。\n	\N		\N	vmod	\N	\N	\N	0	1
562	Vou ao Brasil de avião.\n	私はブラジルへ飛行機で行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
563	Minha avó tem oitenta anos.\n	私の祖母は80歳です。\n	\N		\N	vmod	\N	\N	\N	0	1
564	Meu avô vai fazer setenta e três anos no mês que vem.\n	私の祖父は来月で73歳になります。\n	\N		\N	vmod	\N	\N	\N	0	1
565	O céu estava azul e os pássaros cantavam alegremente.\n	空は青く、鳥たちは陽気に歌っていた。\n	\N		\N	vmod	\N	\N	\N	0	1
566	Qual é a sua bagagem?\n	あなたの荷物はどれですか？\n	\N		\N	vmod	\N	\N	\N	0	1
567	Aceita uma bala de gengibre?\n	生姜の飴をひとついかがですか？\n	\N		\N	vmod	\N	\N	\N	0	1
568	Moça, sua bolsa está aberta.\n	お嬢さん、かばんが開いていますよ。\n	\N		\N	vmod	\N	\N	\N	0	1
569	Onde fica o banheiro?\n	お手洗いはどこですか？\n	\N		\N	vmod	\N	\N	\N	0	1
570	Tomo banho antes de dormir.\n	私は眠る前にお風呂に入ります。\n	\N		\N	vmod	\N	\N	\N	0	1
571	Estou com dor de barriga.\n	腹痛がします。\n	\N		\N	vmod	\N	\N	\N	0	1
572	Tem bebida sem álcool?\n	アルコール抜きの飲み物はありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
573	Não servimos bebidas alcoólicas.\n	お酒はお出ししていません。\n	\N		\N	vmod	\N	\N	\N	0	1
574	Sempre vou à faculdade de bicicleta.\n	私はいつも大学へ自転車で行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
575	Ele andava com as mãos nos bolsos.\n	彼はポケットに手を入れて歩いていた。\n	\N		\N	vmod	\N	\N	\N	0	1
576	Faz bom tempo hoje.\n	今日はいい天気だ。\n	\N		\N	vmod	\N	\N	\N	0	1
577	Minha mãe me deu um anel bonito.\n	母は私にきれいな指輪をくれた。\n	\N		\N	vmod	\N	\N	\N	0	1
578	Quero um remédio para dor de cabeça.\n	頭痛の薬が欲しい。\n	\N		\N	vmod	\N	\N	\N	0	1
579	Comprei uma linda cadeira na loja de móveis.\n\n	家具屋で素敵な椅子を買いました。\n	\N		\N	vmod	\N	\N	\N	0	1
580	Não poderiam estar faltando essas folhas no meu caderno!\n	私のノートのそこのページが欠けているなんてありえない！\n	\N		\N	vmod	\N	\N	\N	0	1
581	Tomamos um café depois do almoço.\n	昼食後に私たちはコーヒーを飲みました。\n	\N		\N	vmod	\N	\N	\N	0	1
582	A diária desse hotel é cento e vinte reais com café da manhã incluído.\n\n	このホテルの宿泊料は朝食付きで120レアルです。\n	\N		\N	vmod	\N	\N	\N	0	1
583	Ele usa calças brancas.\n	彼は白いズボンをはいている。\n	\N		\N	vmod	\N	\N	\N	0	1
584	Qual você prefere, carne de vaca ou de porco?\n	牛肉と豚肉、あなたはどっちが好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
585	Recebi a sua carta anteontem.\n	一昨日あなたからの手紙を受け取りました。\n	\N		\N	vmod	\N	\N	\N	0	1
586	No exato momento em que bateu meia-noite, a luz se apagou.\n	真夜中になったちょうどその時、電気が消えた。	\N		\N	vmod	\N	\N	\N	0	1
587	A atriz disse que respondia a todas as cartas.\n	その女優は、全ての手紙に返事をすると言った。\n	\N		\N	vmod	\N	\N	\N	0	1
588	Essa carteira custa só trinta reais?\n	その財布はたったの30レアルなの？\n	\N		\N	vmod	\N	\N	\N	0	1
589	O casaco que eu queria é igual ao que vi na exposição.\n	私は、展覧会で見たのと同じコートが欲しかった。\n	\N		\N	vmod	\N	\N	\N	0	1
590	Eu queria um casaco igual ao que vi na exposição.\n\n	私が欲しかったのは、展示会で見たのと同じコートだ。\n	\N		\N	vmod	\N	\N	\N	0	1
591	O casal foi embora para Curitiba.\n\n	夫婦はクリチバに帰った。\n	\N		\N	vmod	\N	\N	\N	0	1
592	Quer tomar café ou chá?\n	コーヒーとお茶、どちらがいいですか？\n	\N		\N	vmod	\N	\N	\N	0	1
593	Prefiro chá preto a café.\n	コーヒーより紅茶が好きです。\n	\N		\N	vmod	\N	\N	\N	0	1
595	Ele tirou o chapéu na sala de aula.\n	彼は教室で帽子を脱いだ。\n	\N		\N	vmod	\N	\N	\N	0	1
596	Onde foi que deixei as minhas chaves?\n	私、鍵をいったいどこに置いたかしら？\n	\N		\N	vmod	\N	\N	\N	0	1
598	Fui ao balcão trazendo bilhete e passaporte.\n	切符とパスポートを持ってカウンターへ行った。	\N		\N	vmod	\N	\N	\N	0	1
599	Minha namorada me deu um beijo na boca.	私の彼女は私に口づけをした。	\N		\N	vmod	\N	\N	\N	0	1
600	Fiquei assustado quando ele me tocou no braço.	彼が私の腕に触れた時、びっくりした。	\N		\N	vmod	\N	\N	\N	0	1
601	O ator do filme tinha os dentes brancos.\n	映画の中の俳優は、白い歯をしていた。	\N		\N	vmod	\N	\N	\N	0	1
602	Botei um cartão na caixa de correio.	ポストに手紙を入れた。	\N		\N	vmod	\N	\N	\N	0	1
603	Ele pôs uma caneta-tinteiro e um lenço de seda no bolso de baixo do casaco.\n	彼は万年筆とシルクのハンカチを、上着の下のポケットに入れた。	\N		\N	vmod	\N	\N	\N	0	1
604	Meu companheiro experimentou a especialidade da casa, caril de lagosta.	私の連れはそのレストランの名物料理、伊勢海老のカレーを味わった。	\N		\N	vmod	\N	\N	\N	0	1
605	Os visitantes tiram sapatos na entrada e usam chinelos lá dentro.	訪問客は入り口で靴を脱いで、中ではスリッパを履くのよ。	\N		\N	vmod	\N	\N	\N	0	1
606	Ele atravessou o quarto nu e entrou no chuveiro.\n	彼は裸で寝室を横切って、シャワー室に入った。	\N		\N	vmod	\N	\N	\N	0	1
607	Na classe, enquanto o professor dava aula, eu fazia um desenho dele.	クラスで、先生が授業をしている間、私は彼の似顔絵を書いていた。	\N		\N	vmod	\N	\N	\N	0	1
608	Parece que vai chover hoje à noite.\n	今夜は雨が降りそうです。\n	\N		\N	vmod	\N	\N	\N	0	1
609	Adicione sal e pimenta a gosto.\n	お好みにより塩と胡椒を加えてください。\n	\N		\N	vmod	\N	\N	\N	0	1
610	Meu aniversário é no dia 15 de agosto.	私の誕生日は8月15日です。\n	\N		\N	vmod	\N	\N	\N	0	1
611	Quem é aquele homem de óculos?\n	眼鏡をかけたあの男性は誰ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
612	Essas aves voam muito baixo.\n	それらの鳥は低空を飛びます。\n	\N		\N	vmod	\N	\N	\N	0	1
613	Prata é mais barata que ouro.\n	銀は金よりも安い。\n	\N		\N	vmod	\N	\N	\N	0	1
614	Meu professor tem muitos livros.\n	私の先生は多数の本を所有している。\n	\N		\N	vmod	\N	\N	\N	0	1
615	Nesta universidade tem muitos estudantes estrangeiros.\n	この大学には留学生が大勢いる。\n	\N		\N	vmod	\N	\N	\N	0	1
616	Vamos nos encontrar no café perto da estação.\n	駅のそばの喫茶店で会いましょう。\n	\N		\N	vmod	\N	\N	\N	0	1
617	Meu chefe sempre usa a camisa limpa.\n	私の上司はいつも清潔なワイシャツを身につけている。\n	\N		\N	vmod	\N	\N	\N	0	1
618	De qual canção você gosta mais?\n	あなたの一番好きな歌は何ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
619	Me empresta sua caneta.\n	あなたのペンを貸して。\n	\N		\N	vmod	\N	\N	\N	0	1
620	Esqueci de trazer  a caneta.\n	ペンを持ってくるのを忘れちゃった。\n	\N		\N	vmod	\N	\N	\N	0	1
621	Frango com quiabo é um dos pratos típicos da comida mineira.\n	鶏肉とオクラの煮込みはミナス料理の代表的な一品のひとつです。\n	\N		\N	vmod	\N	\N	\N	0	1
622	Acho o custo de vida  no Japão muito caro.\n	日本の生活費は実に高いと思うよ。\n	\N		\N	vmod	\N	\N	\N	0	1
623	Comprei um cartão postal no Rio de Janeiro.\n	リオ・デ・ジャネイロで絵葉書を一枚買いました。\n	\N		\N	vmod	\N	\N	\N	0	1
624	Os visitantes tiram os sapatos na entrada e usam sandálias dentro do hospital.\n	病院の訪問客は、入り口で靴を脱いで、中ではスリッパを履くんですよ。\n	\N		\N	vmod	\N	\N	\N	0	1
625	Ela gosta dos dias de chuva.\n	彼女は雨の日が好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
626	Ele fuma um maço de cigarros por dia.\n	彼は一日に一箱のタバコを吸う。\n	\N		\N	vmod	\N	\N	\N	0	1
627	O sal está em cima da mesa.\n	お塩はテーブルの上にありますよ。\n	\N		\N	vmod	\N	\N	\N	0	1
628	Garçom, traga um cinzeiro, por favor.\n	ウェイターさん、灰皿を持ってきてください。\n	\N		\N	vmod	\N	\N	\N	0	1
629	Acendi a luz e ficou claro.\n	電気をつけると明るくなった。\n	\N		\N	vmod	\N	\N	\N	0	1
630	Ele está vestindo um suéter de cor clara.\n	彼は明るい色のセーターを着ています。\n	\N		\N	vmod	\N	\N	\N	0	1
631	O gado se adaptou bem ao clima brasileiro.\n	家畜はブラジルの気候によく順応した。\n	\N		\N	vmod	\N	\N	\N	0	1
632	Os estudantes colaram cartazes nos muros.\n	学生たちは壁にポスターを貼った。\n	\N		\N	vmod	\N	\N	\N	0	1
633	Lúcia fez uma pausa enquanto pegava a sopa com a colher.\n	ルシアはスプーンでスープをすくったまま一休みした。\n	\N		\N	vmod	\N	\N	\N	0	1
634	A aula começa às nove da manhã.\n	授業は朝9時に始まる。\n	\N		\N	vmod	\N	\N	\N	0	1
635	Eu comia em restaurantes ou fazia comida em casa. \n	私はレストランで食べたり家で作ったりしてたわ。\n	\N		\N	vmod	\N	\N	\N	0	1
636	Você gosta de comida japonesa?\n	あなたは日本食が好きですか？\n	\N		\N	vmod	\N	\N	\N	0	1
637	Ela tem cabelo grosso e comprido.\n	彼女の髪は太くて長い。\n	\N		\N	vmod	\N	\N	\N	0	1
638	Quero aprender a usar o computador.\n	コンピューターの使い方を習いたいんです。\n	\N		\N	vmod	\N	\N	\N	0	1
639	A vida em Tokyo está cada vez mais conveniente.\n	東京での暮らしはますます便利になるばかりです。\n	\N		\N	vmod	\N	\N	\N	0	1
640	Tenho a cópia do passaporte.\n	パスポートのコピーを持っています。\n	\N		\N	vmod	\N	\N	\N	0	1
641	Ele tirou a roupa e reparou que estava magro.\n	服を脱ぐと、彼は体が痩せたことに気付いた。\n	\N		\N	vmod	\N	\N	\N	0	1
642	Tem uma saída de emergência no fundo do corredor.\n	廊下の奥に非常出口があります。\n	\N		\N	vmod	\N	\N	\N	0	1
643	O correio central fica na praça  São Bento.\n	中央郵便局はサン・ベント広場にあります。\n	\N		\N	vmod	\N	\N	\N	0	1
644	As crianças correram pelo campo.\n	子供たちは野原をかけまわった。\n	\N		\N	vmod	\N	\N	\N	0	1
645	Você corta o limão em oito pedaços. \n	レモン１つを８つに切る。\n	\N		\N	vmod	\N	\N	\N	0	1
646	Não admitia que alguém comesse na cozinha.\n	誰かが台所で食べることを許可しなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
647	A cozinha é mesmo uma atividade criativa.\n	料理とは、まさに創造的な活動だ。\n	\N		\N	vmod	\N	\N	\N	0	1
648	Conversamos no cruzamento da Santo Antônio com a Aurora.\n	私たちはサント・アントニオ通りとオーロラ通りの交差点で話をした。\n	\N		\N	vmod	\N	\N	\N	0	1
649	Não consegui tirar uma só cópia.\n	一枚のコピーも取れなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
650	A Copa do Mundo será realizada daqui a dois anos.\n	ワールド・カップは再来年開催されます。\n	\N		\N	vmod	\N	\N	\N	0	1
652	Faço um café delicioso.\n	私はおいしいコーヒーを入れますよ。\n	\N		\N	vmod	\N	\N	\N	0	1
653	Um adulto tem trinta e dois dentes.\n	成人は32本の歯がある。\n	\N		\N	vmod	\N	\N	\N	0	1
654	Dentro da sala estava muito quente.\n	部屋の中はとても暑かった。\n	\N		\N	vmod	\N	\N	\N	0	1
655	Vou para a casa dele depois de amanhã.	あさって、彼の家に行きます。	\N		\N	vmod	\N	\N	\N	0	1
656	Desceu de elevador do déximo andar.\n	10階からエレベーターで降りた。\n	\N		\N	vmod	\N	\N	\N	0	1
657	Ela fala devagar para que todos a entendam.\n	彼女は皆にわかるようにゆっくり話した。\n	\N		\N	vmod	\N	\N	\N	0	1
658	Mandei uma carta para ele, mas foi devolvida.\n	彼に手紙を出したんだけど、戻ってきちゃった。\n	\N		\N	vmod	\N	\N	\N	0	1
659	Volto para o Japão em dezembro do ano que vem.\n	私は来年の12月に日本に帰ります。\n	\N		\N	vmod	\N	\N	\N	0	1
660	A recepção funciona só durante o dia.\n	受付は日中しかやってないのよ。\n	\N		\N	vmod	\N	\N	\N	0	1
661	Ao ouvir este disco, você vai se lembrar do Brasil.\n	このレコードを聴くと、あなたはブラジルのことを思い出すでしょう。\n	\N		\N	vmod	\N	\N	\N	0	1
662	Passei um dia divertido com meus amigos.\n	私は友人たちと楽しい一日を過ごした。\n	\N		\N	vmod	\N	\N	\N	0	1
663	Não quer provar este doce?\n	このお菓子を試食してみませんか？\n	\N		\N	vmod	\N	\N	\N	0	1
664	Os bolos do Brasil são muito doces para mim.\n	ブラジルのケーキは私には甘すぎる。\n	\N		\N	vmod	\N	\N	\N	0	1
665	Você já pegou alguma doença grave?\n	何か重い病気にかかったことはありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
666	Meus pés doem porque os sapatos estão muito apertados.\n	靴が窮屈なので、足が痛みます。\n	\N		\N	vmod	\N	\N	\N	0	1
667	Fui à Alemaha no ano retrasado.\n	おととし私はドイツに行きました。\n	\N		\N	vmod	\N	\N	\N	0	1
668	O elevador está em manutenção.\n	エレベーターは点検中です。\n	\N		\N	vmod	\N	\N	\N	0	1
669	A embaixada do Brasil fica perto da estação de metrô Gaien-mae.\n	ブラジル大使館は地下鉄外苑前駅の近くにあります。\n	\N		\N	vmod	\N	\N	\N	0	1
670	O gato se escondeu embaixo da mesa.\n	猫は机の下に隠れた。\n	\N		\N	vmod	\N	\N	\N	0	1
671	Embarquei num caminhão superlotado.\n	ぎゅうづめのトラックに乗り込んだ。\n	\N		\N	vmod	\N	\N	\N	0	1
672	Paulo, me empresta um dinheiro?\n	パウロ、僕にお金を貸してもらえる？\n	\N		\N	vmod	\N	\N	\N	0	1
673	Empurrou a porta e entrou.\n	ドアを押して入ってきた。\n	\N		\N	vmod	\N	\N	\N	0	1
674	Me encontrei com Paulo no refeitório.\n	食堂でパウロと出くわした。\n	\N		\N	vmod	\N	\N	\N	0	1
675	Lúcia fez uma pausa enquanto pegava a sopa com a colher.\n	ルシアはスプーンでスープをすくったまま一休みした。\n	\N		\N	vmod	\N	\N	\N	0	1
676	A professora ensinou ao rapaz a forma correta de se falar em público.\n	教師は青年に、公衆の面前での正しい話し方を教えた。\n	\N		\N	vmod	\N	\N	\N	0	1
677	Os visitantes tiram sapatos na entrada e usam chinelos lá dentro.\n	訪問者は入り口で靴を脱ぎ、中ではスリッパを履きます。\n	\N		\N	vmod	\N	\N	\N	0	1
678	Entreguei  os documentos ao meu chefe.\n	私は上司に書類を手渡した。\n	\N		\N	vmod	\N	\N	\N	0	1
679	Parece que não cabe neste envelope.\n	この封筒には入らないみたい。\n	\N		\N	vmod	\N	\N	\N	0	1
680	No Natal deste ano, não enviei cartões.\n	今年のクリスマス、私はカードを出さなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
681	Precisamos subir até o quarto andar pela escada.\n	４階まで階段で昇らなければなりません。\n	\N		\N	vmod	\N	\N	\N	0	1
682	As crianças já aprenderam a escrever as vogais.\n	子供たちはもう母音字の書き方を習いました。\n	\N		\N	vmod	\N	\N	\N	0	1
683	Achei a pasta na gaveta da escrivaninha.\n	勉強机の引き出しでファイルを見つけた。\n	\N		\N	vmod	\N	\N	\N	0	1
684	Quando chegamos no Rio de Janeiro, ainda estava escuro.\n	リオ・デ・ジャネイロに着いたとき、まだ暗かった。\n	\N		\N	vmod	\N	\N	\N	0	1
685	Você pratica algum esporte?\n	あなたは何かスポーツをしますか？\n	\N		\N	vmod	\N	\N	\N	0	1
686	A esposa dele é dois anos mais nova que ele.\n	彼の奥さんは、彼より２つ年下です。\n	\N		\N	vmod	\N	\N	\N	0	1
687	Minha esposa é brasileira.\n	私の妻はブラジル人です。\n	\N		\N	vmod	\N	\N	\N	0	1
688	Estava muito ocupado nesta semana.\n	今週はとっても忙しかった。\n	\N		\N	vmod	\N	\N	\N	0	1
689	A embaixada do Brasil fica perto da estação de metrô Gaien-mae.\n	ブラジル大使館は、地下鉄外苑前駅の近くにあります。\n	\N		\N	vmod	\N	\N	\N	0	1
690	Será que vão caber todos esses livros na estante?\n	この本が全部本棚に収まるかしら？\n	\N		\N	vmod	\N	\N	\N	0	1
691	O senhor está bem?\n	あなたはお元気ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
692	Este ano está passando rápido.\n	今年はあっという間に過ぎていく。\n	\N		\N	vmod	\N	\N	\N	0	1
693	As despesas deste mês foram maiores que de costume.\n	今月の出費はいつもより多かった。\n	\N		\N	vmod	\N	\N	\N	0	1
694	A maior parte dos estrangeiros que moram em Gunma é de brasileiros.\n	群馬県在住の外国人の大半はブラジル人です。\n	\N		\N	vmod	\N	\N	\N	0	1
695	Não consigo estacionar o carro porque a rua é estreita demais.\n	通りが狭すぎて、車を駐車できない。\n	\N		\N	vmod	\N	\N	\N	0	1
696	Sou estudante de química.\n	私は化学専攻の学生です。\n	\N		\N	vmod	\N	\N	\N	0	1
697	Como estão indo seus estudos na faculdade?\n	大学での勉強はどんな具合ですか？\n	\N		\N	vmod	\N	\N	\N	0	1
698	Façam os exercícios de verbos da página quinze.\n	15ページの動詞の練習問題をやりなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
699	Peguei emprestados três livros da biblioteca.\n	図書館から3冊本を借りた。\n	\N		\N	vmod	\N	\N	\N	0	1
700	Tem gente que come Sushi com garfo e faca?\n	お寿司をフォークとナイフで食べる人もいる？\n	\N		\N	vmod	\N	\N	\N	0	1
701	A prova foi fácil.\n	テストは簡単だった。\n	\N		\N	vmod	\N	\N	\N	0	1
702	Este restaurante é famoso por sua pizza.\n	このレストランはピザで有名なんだ。\n	\N		\N	vmod	\N	\N	\N	0	1
703	Faz um bom tempo hoje.\n	今日は天気が良い。\n	\N		\N	vmod	\N	\N	\N	0	1
704	O vento fechou as janelas.\n	風で窓が閉まった。\n	\N		\N	vmod	\N	\N	\N	0	1
705	Passei as últimas férias em Campos do Jordão.\n	直近の休暇はカンポス・ド・ジョルダンで過ごしました。\n	\N		\N	vmod	\N	\N	\N	0	1
706	Você tem algum plano para as férias de verão?\n	あなたは何か夏休みの計画がありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
707	Na maioria das vezes, o Carnaval cai em fevereiro.\n	たいてい、カーニバルは２月に行われる。\n	\N		\N	vmod	\N	\N	\N	0	1
708	Tem filme nesta câmera?\n	このカメラにはフィルムが入ってる？\n	\N		\N	vmod	\N	\N	\N	0	1
709	Esta blusa é muito fina.\n	このシャツはとても薄手です。\n	\N		\N	vmod	\N	\N	\N	0	1
710	O cabelo dela é fino.\n	彼女の髪の毛は細い。\n	\N		\N	vmod	\N	\N	\N	0	1
711	Passe na papelaria e compre cem folhas de papel almaço.\n	文具屋に寄って、罫線入りの紙を100枚買ってきて。\n	\N		\N	vmod	\N	\N	\N	0	1
712	Camarões será um forte candidato à vaga.\n	カメルーンが、空きポストへの有力候補だ。\n	\N		\N	vmod	\N	\N	\N	0	1
713	Ele tirou uma foto minha com sua nova câmera.\n	彼は、新しいカメラで私の写真を一枚撮った。\n	\N		\N	vmod	\N	\N	\N	0	1
714	Como ele tem oitenta anos, já está fraco.\n	彼は８０歳名だけに、もう弱々しい。\n	\N		\N	vmod	\N	\N	\N	0	1
715	Esta frase, cujo autor eu desconheço, é antiga.\n	この文章の作者は知りませんが、古いものです。\n	\N		\N	vmod	\N	\N	\N	0	1
716	O ponto de ônibus fica mais a frente.\n	バス停はもっと先にあります。\n	\N		\N	vmod	\N	\N	\N	0	1
717	Meu filho me telefona freqüentemente.\n	私の息子はしばしば電話をかけてきます。\n	\N		\N	vmod	\N	\N	\N	0	1
718	O vento é fresco e os pombos passeiam no telhado.\n	風は涼しくて、鳩たちは屋根の上でくつろいでいた。\n	\N		\N	vmod	\N	\N	\N	0	1
719	Você quer chá quente ou frio?\n	温かいお茶と冷たいお茶、どっちが良い？\n	\N		\N	vmod	\N	\N	\N	0	1
720	No Brasil, tem regiões que fazem frio como Hokkaido?\n	ブラジルでも、北海道と同じくらい寒い地域がある？\n	\N		\N	vmod	\N	\N	\N	0	1
721	No norte do Brasil você encontra frutas diferentes.\n	ブラジルの北部では、変わった果物にめぐり会えます。\n	\N		\N	vmod	\N	\N	\N	0	1
722	Entre, por favor.\n	どうぞお入りください。\n	\N		\N	vmod	\N	\N	\N	0	1
723	Ela retirou a comida da geladeira.\n	彼女は冷蔵庫から食べ物を取り出した。\n	\N		\N	vmod	\N	\N	\N	0	1
724	O povo brasileiro gosta muito de futebol.\n	ブラジルの人々はサッカーが大好きだ。\n	\N		\N	vmod	\N	\N	\N	0	1
725	Em poucas regiões do Brasil chega a zero graus.\n	ブラジルでは、わずかな地域でしか気温0度にならない。\n	\N		\N	vmod	\N	\N	\N	0	1
726	Você ainda usa esse gravador de fita cassete?\n	君はまだその古いテープレコーダーを使ってるの？\n	\N		\N	vmod	\N	\N	\N	0	1
727	Hoje ele está usando uma gravata listrada.\n	今日彼はストライプのネクタイをしている。\n	\N		\N	vmod	\N	\N	\N	0	1
728	Este livro grosso é um dicionário.\n	この分厚い本は辞書です。	\N		\N	vmod	\N	\N	\N	0	1
729	Você trouxe o seu guarda-chuva?\n	あなた、傘を持ってきましたか？\n\n	\N		\N	vmod	\N	\N	\N	0	1
730	Que piada sem graça!\n	なんてつまらないジョークなんだ！\n	\N		\N	vmod	\N	\N	\N	0	1
731	Essa é uma pessoa em quem confiamos.\n	この人を私たちは信頼している。\n	\N		\N	vmod	\N	\N	\N	0	1
732	O motorista ainda está no hospital e não pode dar informações sobre o acidente.\n	運転手はまだ病院にいるので事故に関する情報を提供できない。\n	\N		\N	vmod	\N	\N	\N	0	1
733	Saímos do hotel logo depois do café da manhã.	朝食後すぐに私たちはホテルを出た。\n	\N		\N	vmod	\N	\N	\N	0	1
734	O bem-te-vi não passou fome no inverno, porque economizou no verão.\n	タイランチョウは、夏に節制するので、冬に飢えることはない。\n	\N		\N	vmod	\N	\N	\N	0	1
735	Maria, qual é a idade da sua irmã?\n	マリア、あなたのお姉さんの年はいくつですか？\n	\N		\N	vmod	\N	\N	\N	0	1
737	Você tem irmãos?\n	あなた、兄弟はいますか？\n	\N		\N	vmod	\N	\N	\N	0	1
738	Você tem irmãs?\n	あなた、姉妹はいますか？\n	\N		\N	vmod	\N	\N	\N	0	1
739	A praia fervilhava de gente como nos domingos de janeiro.\n	ビーチは、1月の日曜日のように人々で大いに賑わっていた。\n	\N		\N	vmod	\N	\N	\N	0	1
740	A janela da sala dá para a lagoa.\n	部屋の窓は湖に面している。\n	\N		\N	vmod	\N	\N	\N	0	1
741	Você comprou alguma coisa para o jantar?\n	あなた、夕食用に何か買った？\n	\N		\N	vmod	\N	\N	\N	0	1
742	Eu sei falar japonês.	私は日本語が話せます。	\N		\N	vmod	\N	\N	\N	0	1
743	Pedro e o filho caçula jogavam futebol no jardim.\n	ペドロと末の息子は庭でサッカーをしていた。\n	\N		\N	vmod	\N	\N	\N	0	1
744	Qual é o jornal mais lido no Japão?\n	日本で一番読まれている新聞はどれですか？\n	\N		\N	vmod	\N	\N	\N	0	1
745	O primeiro semestre termina no final de julho.\n	１学期は７月末で終わります。\n	\N		\N	vmod	\N	\N	\N	0	1
746	Chove muito no mês de junho.\n	６月は雨が多い。\n	\N		\N	vmod	\N	\N	\N	0	1
747	Com licença.	すみません。	\N		\N	vmod	\N	\N	\N	0	1
748	Sentou-se na poltrona ao meu lado.\n	（彼/彼女は）私の隣の座席に座った。\n	\N		\N	vmod	\N	\N	\N	0	1
749	Façam a redação a lápis.\n	鉛筆で作文を書きなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
750	A rua onde ela mora é larga e arborizada.\n	彼女が住んでいる通りは広くて、木々が植えてある。\n	\N		\N	vmod	\N	\N	\N	0	1
751	Recomenda-se a lavagem a seco para tecidos delicados.\n	デリケートな生地にはドライクリーニングをお勧めします。\n	\N		\N	vmod	\N	\N	\N	0	1
752	O novo modelo da máquina de lavar roupas usa menos sabão em pó.\n	新しいモデルの洗濯機は、少ない粉洗剤で服が洗えます。\n	\N		\N	vmod	\N	\N	\N	0	1
753	Eu vou pedir uma salada de legumes e depois carne com batatas fritas.\n	私は野菜サラダと、その後でフライドポテト添えの肉を注文します。\n	\N		\N	vmod	\N	\N	\N	0	1
754	Ele toma um litro de leite por dia.\n	彼は一日に1リットルの牛乳を飲む。\n	\N		\N	vmod	\N	\N	\N	0	1
757	Os japoneses aprendem a escrever caracteres chineses desde pequeno.\n	日本人は小さい頃から漢字の書き方を学びます。\n	\N		\N	vmod	\N	\N	\N	0	1
758	O pai limpou a boca com guardanapo e se levantou.\n	父はナプキンで口をぬぐうと立ち上がった。\n	\N		\N	vmod	\N	\N	\N	0	1
759	Ela não tem mais febre e já se levantou.\n	彼女は熱もおさまり、もう起き上がった。\n	\N		\N	vmod	\N	\N	\N	0	1
760	Como minha mala está leve, posso carregá-la sozinho.\n	私のスーツケースは軽いので、一人で運べます。\n	\N		\N	vmod	\N	\N	\N	0	1
761	Eu ia fazer a lição de casa mas acabei dormindo.\n	宿題をやろうと思ったのに寝てしまった。\n	\N		\N	vmod	\N	\N	\N	0	1
762	Nossa empregada limpa a casa todos os dias.\n	お手伝いさんが毎日家を掃除してくれます。\n	\N		\N	vmod	\N	\N	\N	0	1
763	Não gosto de fazer limpeza.\n	掃除をするのは好きじゃない。\n	\N		\N	vmod	\N	\N	\N	0	1
764			\N		\N	vmod	\N	\N	\N	0	1
765	Pediu a palavra ao diretor.\n	校長先生にお言葉を頂戴した。\n	\N		\N	vmod	\N	\N	\N	0	1
766	Ele vai chegar logo.\n	彼はすぐに到着します。\n	\N		\N	vmod	\N	\N	\N	0	1
767	As lojas no centro da cidade fecham aos domingos.\n	中心街の店は日曜日には閉店する。\n	\N		\N	vmod	\N	\N	\N	0	1
768	Aquela loja de departamentos tem cinco andares.\n	あのデパートは5階建てだ。\n	\N		\N	vmod	\N	\N	\N	0	1
769	Comprei cebolas naquela quitanda.\n	あの八百屋さんで玉ねぎをいくつか買いました。\n	\N		\N	vmod	\N	\N	\N	0	1
770	É longe daqui?\n	ここから遠いですか？\n	\N		\N	vmod	\N	\N	\N	0	1
771	O hospital fica na rua 13 de maio.\n	病院は５月１３日通りにあります。\n	\N		\N	vmod	\N	\N	\N	0	1
772	Eu jogo boliche muito mal.\n	私はボーリングが下手です。\n	\N		\N	vmod	\N	\N	\N	0	1
773	Para fazer o bolo, é melhor usar manteiga sem sal.\n	ケーキを作るには、無塩バターを使うほうがいい。\n	\N		\N	vmod	\N	\N	\N	0	1
774	Ele andava com as mãos nos bolsos.\n	彼はポケットに手を入れたまま歩いていた。\n	\N		\N	vmod	\N	\N	\N	0	1
775	Sem este mapa, me sinto perdido.\n	この地図がないと迷子になった気がします。\n	\N		\N	vmod	\N	\N	\N	0	1
776	Ele tirou uma foto minha com sua nova máquina.\n	彼は新しいカメラで私を写真に撮った。\n	\N		\N	vmod	\N	\N	\N	0	1
777	Conhece a canção que se chama "Águas de março" ?\n	「三月の雨」という曲を知っていますか？\n	\N		\N	vmod	\N	\N	\N	0	1
778	O marido dela é músico.\n	彼女の夫はミュージシャンです。\n	\N		\N	vmod	\N	\N	\N	0	1
779	Comprei um casaco marrom que está na moda.\n	流行の茶色いコートを買いました。\n	\N		\N	vmod	\N	\N	\N	0	1
780	Os maus funcionários podem causar danos irreparáveis.\n	質の悪い従業員は、取り返しのつかない損害を起こしうる。\n	\N		\N	vmod	\N	\N	\N	0	1
781	Falta um botão na minha camisa e a meia está furada.\n	私のシャツはボタンがひとつ取れており、靴下には穴が開いている。\n	\N		\N	vmod	\N	\N	\N	0	1
782	A menina sempre foi a alegria da família.\n	少女はいつでも家族の喜びの元だった。\n	\N		\N	vmod	\N	\N	\N	0	1
783	Os meninos estão jogando bola perto da calçada. \n	少年たちは歩道の近くでボール遊びをしている。\n	\N		\N	vmod	\N	\N	\N	0	1
784	No mês passado ela me ligou de Londres.\n	先月彼女はロンドンから電話をくれた。\n	\N		\N	vmod	\N	\N	\N	0	1
785			\N		\N	vmod	\N	\N	\N	0	1
786	Gosto de comer abacate com molho de soja.\n	アボカドをお醤油で食べるのが好き。\n	\N		\N	vmod	\N	\N	\N	0	1
787	Meu pai morava em cima de uma quitanda.\n	私の父はかつて八百屋の上に住んでいた。\n	\N		\N	vmod	\N	\N	\N	0	1
788	Qualquer ser humano vai morrer um dia.\n	全ての人間はいつか死ぬ。\n	\N		\N	vmod	\N	\N	\N	0	1
789	Muitas pessoas sairam para ver o desfile na rua.\n	大勢の人がパレードを見に通りに出た。\n	\N		\N	vmod	\N	\N	\N	0	1
790	Mulheres gostam de ganhar jóias ou flores.\n	女性というのは、宝石や花をもらうのが好きなものだ。\n	\N		\N	vmod	\N	\N	\N	0	1
791	Música e cinema são bons passatempos.\n	音楽と映画はいい趣味だ。\n	\N		\N	vmod	\N	\N	\N	0	1
792	O menino já sabe nadar bem.\n	その男の子はもう上手に泳ぐことができる。\n	\N		\N	vmod	\N	\N	\N	0	1
794	A casa estava coberta de neve.\n	その家には雪が降り積もっていた。\n	\N		\N	vmod	\N	\N	\N	0	1
795	15 de novembro é o dia da Proclamação da República.\n	１１月１５日は共和国宣言記念日だ。\n	\N		\N	vmod	\N	\N	\N	0	1
796	Ganhei a nova edição do dicionário de português.\n	私はポルトガル語辞書の新版をもらった。\n	\N		\N	vmod	\N	\N	\N	0	1
797	Ele é dois anos mais novo que eu.\n	彼は私より2歳若い。\n	\N		\N	vmod	\N	\N	\N	0	1
799	As nuvens se deslocaram para oeste.\n	雲は西のほうへ移動した。\n	\N		\N	vmod	\N	\N	\N	0	1
800	Ontem à noite no canal nove passou um filme sobre o Rio São Francisco.\n	昨夜、9チャンネルでサンフランシスコ河に関する番組を放送した。\n	\N		\N	vmod	\N	\N	\N	0	1
801	Ela tem dois furos em cada orelha.\n	彼女はそれぞれの耳に２つずつ(ピアスの)穴がある。\n	\N		\N	vmod	\N	\N	\N	0	1
802	Como fizeram manhãs bonitas neste outono!\n	今年の秋はなんて朝がきれいなんだ！\n	\N		\N	vmod	\N	\N	\N	0	1
803	No dia 12 de outubro, se festeja o dia de Nossa Senhora Aparecida.\n	１０月１２日は、聖母アパレシーダを祝福する日だ。\n	\N		\N	vmod	\N	\N	\N	0	1
804	Carlos era a esperança dos pais.\n	カルロスは、両親の希望だった。\n	\N		\N	vmod	\N	\N	\N	0	1
805	O Brasil é o quinto maior país do mundo.\n	ブラジルは世界で５番目に大きな国だ。\n	\N		\N	vmod	\N	\N	\N	0	1
806	Você já foi a algum país estrangeiro?\n	あなたはどこか外国に行ったことがありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
807	Faço pão de queijo em casa.\n	家でチーズパンを作りますよ。\n	\N		\N	vmod	\N	\N	\N	0	1
808	Daqui ao parque são mais de dois quilômetros.\n	ここから公園までは2キロ以上あります。\n	\N		\N	vmod	\N	\N	\N	0	1
809	As professoras levam as crianças para dar um passeio.\n	先生方は、子供たちを散歩に連れて行く。\n	\N		\N	vmod	\N	\N	\N	0	1
810	Você sabe comer com pauzinhos muito bem.\n	お箸で食べるのがとてもお上手ですね。\n	\N		\N	vmod	\N	\N	\N	0	1
811	Estou preparando um peixe assado ao molho de camarão.\n	私は魚のグリルの海老ソース添えを作っているところです。\n	\N		\N	vmod	\N	\N	\N	0	1
812	Ele viu a moça pendurando toalhas no varal.\n	彼は、女性がタオルを干し竿に架けているところを見た。\n	\N		\N	vmod	\N	\N	\N	0	1
813	Compramos uma casa pequena no ano passado.\n	昨年、私たちは小さな家を購入しました。\n	\N		\N	vmod	\N	\N	\N	0	1
814	Tem alguma pergunta?\n	何か質問はありますか？\n	\N		\N	vmod	\N	\N	\N	0	1
815	O policial perguntou às testemunhas sobre as circunstâncias do crime.\n	警官は、目撃者たちに犯行の状況を尋ねた。\n	\N		\N	vmod	\N	\N	\N	0	1
816	Meu irmão quebrou a perna esquerda no acidente.\n	僕の弟は、事故で右足を骨折しました。\n	\N		\N	vmod	\N	\N	\N	0	1
817	A caixa é muito pesada para ela carregar.\n	彼女が運ぶのには箱が重すぎるだろう。\n	\N		\N	vmod	\N	\N	\N	0	1
818	Toda vez que como comidas picantes, meu rosto fica quente e vermelho.\n	僕は辛い食べ物を食べるといつも顔が熱く、そして赤くなるよ。\n	\N		\N	vmod	\N	\N	\N	0	1
819	Fui a uma exosição de pinturas em Ueno.\n	上野に絵画展を見に行った。\n	\N		\N	vmod	\N	\N	\N	0	1
820	Ela nada na piscina todos os dias.\n	彼女は毎日プールで泳いでいる。\n	\N		\N	vmod	\N	\N	\N	0	1
821	Ele pôs o chapéu e saiu.\n	彼は帽子をかぶると出て行った。\n	\N		\N	vmod	\N	\N	\N	0	1
822	Por que é que a porta ficou aberta?\n	なんでドアが開けっ放しなの？\n	\N		\N	vmod	\N	\N	\N	0	1
823	O posto policial atende à noite?\n	交番は夜でも対応してくれる？\n	\N		\N	vmod	\N	\N	\N	0	1
824	Depois de pronto o bolo, vire-o ainda quente num prato de vidro.\n	ケーキが準備できたら、熱いうちにガラスのお皿にひっくり返します。\n	\N		\N	vmod	\N	\N	\N	0	1
825	Ainda faltava pouco mais de um mês para a primavera.\n	春までにはまだひと月と少しあります。\n	\N		\N	vmod	\N	\N	\N	0	1
826	Meu primo vai para a Itália na próxima semana.\n	僕の従兄弟は来週イタリアに行きます。\n	\N		\N	vmod	\N	\N	\N	0	1
827	Ele próprio entregou os convites.\n	彼自身が招待状を持ってきた。\n	\N		\N	vmod	\N	\N	\N	0	1
828	A aula vai começar na semana que vem.\n	授業は来週始まります。\n	\N		\N	vmod	\N	\N	\N	0	1
829	Estou pensando em viajar pelo Brasil no ano que vem.\n	私は来年、ブラジル国内を旅行してみようかと考えています。\n	\N		\N	vmod	\N	\N	\N	0	1
830	Quanto custa esta camisa?\n	このシャツはいくらですか？\n	\N		\N	vmod	\N	\N	\N	0	1
831	Quantos anos você tem?\n	あなたはいくつですか？\n	\N		\N	vmod	\N	\N	\N	0	1
832	Hoje é quarta-feira. Vamos comer feijoada!\n	今日は水曜日ね、フェイジョアーダを食べましょう！\n	\N		\N	vmod	\N	\N	\N	0	1
833	Que tipo de filme você prefere?\n	どんな映画が好き？\n	\N		\N	vmod	\N	\N	\N	0	1
834	Quem é?	どなたですか？	\N		\N	vmod	\N	\N	\N	0	1
835	Hoje está muito quente, não é?\n	今日はとても暑いですね？\n	\N		\N	vmod	\N	\N	\N	0	1
836	O quarto estava quente.	部屋は暖かかった。	\N		\N	vmod	\N	\N	\N	0	1
837	O aluno respondeu a cada questão corretamente.\n	その生徒は、それぞれの質問に正しく答えた。\n	\N		\N	vmod	\N	\N	\N	0	1
838	É preciso ficar calmo e quieto.\n	落ち着いて、静かにしていなきゃ。\n	\N		\N	vmod	\N	\N	\N	0	1
839	Na quinta-feira passada me encontrei com João.\n	先週の木曜日、ジョアンに会ったよ。\n	\N		\N	vmod	\N	\N	\N	0	1
840	Clara aumentou o volume do rádio.\n	クラーラはラジオのボリュームを上げた。\n	\N		\N	vmod	\N	\N	\N	0	1
841	Doutor, o melhor é tomar os comprimidos antes, durante ou depois das refeições?\n	先生、錠剤を飲むのは食前、食事中、食後のどれが一番いいですか？\n	\N		\N	vmod	\N	\N	\N	0	1
842	Deu nove horas no relógio.\n	時計は9時を刻んだ。\n	\N		\N	vmod	\N	\N	\N	0	1
843	Eu estou um pouco resfriado.\n	私はやや風邪気味です。\n	\N		\N	vmod	\N	\N	\N	0	1
844	Respirava a plenos pulmões o ar da montanha.\n	肺いっぱいに山の空気を吸い込んだ。\n	\N		\N	vmod	\N	\N	\N	0	1
845	Vai reto e você vai ver o banco na sua direita.\n	まっすぐ行くと、右手に銀行が見えますよ。\n	\N		\N	vmod	\N	\N	\N	0	1
846	A revista a que me refiro foi imprensada em Lisboa.\n	私が言及した雑誌は、リスボンで発行された。\n	\N		\N	vmod	\N	\N	\N	0	1
847	O Rio Amazonas tem mais de 6000 km de comprimento.\n	アマゾン川は、延長６０００キロ以上もある。\n	\N		\N	vmod	\N	\N	\N	0	1
848	Comprei uma roupa nova.	新しい服を買った。\n	\N		\N	vmod	\N	\N	\N	0	1
849	Dizem que a comida daquele restaurante é muito ruim.\n	あのレストランの食事はまずいらしいよ。\n	\N		\N	vmod	\N	\N	\N	0	1
850	A secretária saiu de casa cedo com receio de perder o horário da entrevista.\n	秘書は、会見の時間に遅れないように早めに家を出た。\n	\N		\N	vmod	\N	\N	\N	0	1
851	As crianças pularam de alegria.\n	子供たちは喜んで飛び跳ねた。\n	\N		\N	vmod	\N	\N	\N	0	1
852	Oficialmente, o carnaval dura três dias: domingo, segunda-feira e terça-feira.\n	公式には、カーニバルは日曜、月曜、火曜の3日間続きます。\n	\N		\N	vmod	\N	\N	\N	0	1
853	Colou os selos no envelope.\n	封筒に切手を貼った。\n	\N		\N	vmod	\N	\N	\N	0	1
854	No dia sete de setembro de 1822, D. Pedro proclamou a independência.\n	1822年の9月7日、ドン・ペドロは独立を宣言した。\n	\N		\N	vmod	\N	\N	\N	0	1
855	O restaurante funciona de segunda a sexta-feira.\n	レストランは月曜から金曜まで営業している。\n	\N		\N	vmod	\N	\N	\N	0	1
856	O professor explicou o sentido da palavra.\n	教師は単語の意味を説明した。\n	\N		\N	vmod	\N	\N	\N	0	1
857	Estou muito suado e sujo.\n	僕は凄く汗をかいて、汚れてるよ。\n	\N		\N	vmod	\N	\N	\N	0	1
858	Deveria ter muitas razões para tal atitude.\n	こんな態度にはいろいろな事情があったに違いない。\n	\N		\N	vmod	\N	\N	\N	0	1
859	Talvez seja a igreja mais importante da cidade.\n	おそらくこれが町で一番重要な教会でしょうね。\n	\N		\N	vmod	\N	\N	\N	0	1
860	Pelo sol, devem ser umas quatro horas da tarde.\n	太陽の様子からしてだいたい夕方の4時くらいだろう。\n	\N		\N	vmod	\N	\N	\N	0	1
861	Onde você estava ontem à tarde?\n	昨日の午後、あなたはどこにいましたか？\n	\N		\N	vmod	\N	\N	\N	0	1
862	Os 40% restante dos brasileiros viram o jogo na televisão.\n	残りの40％のブラジル人は、テレビで試合を見ました。\n	\N		\N	vmod	\N	\N	\N	0	1
863	O céu continua nublado.\n	空は相変わらず曇りだ。\n	\N		\N	vmod	\N	\N	\N	0	1
864	Nas terças-feiras, só tenho aula de tarde.\n	火曜日は、午後しか授業がない。\n	\N		\N	vmod	\N	\N	\N	0	1
865	Fábio tirou uma poeira do terno com a escova.\n	ファビオはブラシで背広の埃を払った。\n	\N		\N	vmod	\N	\N	\N	0	1
866	Minha tia mora em Brasília.	叔母はブラジリアに住んでいます。	\N		\N	vmod	\N	\N	\N	0	1
867	Minha mãe comprou uma tigela antiga na feira.\n	母は市場で古い茶碗を買いました。\n	\N		\N	vmod	\N	\N	\N	0	1
868	Meu tio visita Kyoto todos os anos.\n	私のおじは毎年京都を訪れます。\n	\N		\N	vmod	\N	\N	\N	0	1
869	Ela toca piano com muito sentimento.\n	彼女は実に感情を込めてピアノを弾く。\n	\N		\N	vmod	\N	\N	\N	0	1
870	Recebo sua carta todas as semanas.\n	毎週あなたの手紙を受け取っています。\n	\N		\N	vmod	\N	\N	\N	0	1
871	Toda a cidade estava envolvida na festa.\n	町中がお祭りで包まれた。\n	\N		\N	vmod	\N	\N	\N	0	1
872	Todo mundo gosta dela.\n	皆彼女のことが好きです。\n	\N		\N	vmod	\N	\N	\N	0	1
873	Todos os meses, recebo meu salário no dia 20.\n	毎月、私は２０日に給料を受け取ります。\n	\N		\N	vmod	\N	\N	\N	0	1
874	Ela vai tomar banho antes de dormir.\n	彼女は寝る前にお風呂に入ります。\n	\N		\N	vmod	\N	\N	\N	0	1
875	Depois daquela briga, ela se tornou minha grande amiga.\n	あの喧嘩の後、彼女は私の親友になった。\n	\N		\N	vmod	\N	\N	\N	0	1
876	O trem sai à meia-noite.\n	電車は深夜に出発する。\n	\N		\N	vmod	\N	\N	\N	0	1
877	Menos de um mês será suficiente para a conclusão das obras.\n	作品を仕上げるのにひと月未満で十分です。\n	\N		\N	vmod	\N	\N	\N	0	1
878	Lembro bem das ruas pelas quais passávamos indo à universidade.	大学に通うのに僕らが通った道を良く覚えているよ。\n	\N		\N	vmod	\N	\N	\N	0	1
879	Às vezes, eu gosto de ir ao cinema ou ao teatro.\n	ときどきは映画に行ったり、劇を見に行ったりもするけど。\n	\N		\N	vmod	\N	\N	\N	0	1
880	Achei um rádio toca-fitas velho no armário.\n	押入れで、古いラジカセを見つけました。\n	\N		\N	vmod	\N	\N	\N	0	1
881	Foram vendidos ingressos além da capacidade do estádio, logo só podia dar em confusão.\n	スタジアムの収容人数を越える券が売られたので、まもなく混乱を生じるだろう。\n	\N		\N	vmod	\N	\N	\N	0	1
82	Mulheres gostam de ganhar bijuterias ou flores.	もらうとしたら女性はアクセサリーかお花が好きね。	意見を言う		\N	dmod	pb06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
352	Oi, Marta, tudo bem? 	やあ、マルタ、元気？	挨拶する		\N	dmod	pb27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
463	É tua.	あなたよ。			\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
486	Tá bom.	いいよ。	承諾する		\N	dmod	pb36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
553	Amarelo é a cor do ouro ou da gema do ovo.	黄色は金ないしは卵の黄身の色だ。	\N		\N	vmod	\N	\N	\N	0	1
651	O cachorro deitou-se aos meus pés.\n	犬が私の足元に寝そべった。\n	\N		\N	vmod	\N	\N	\N	0	1
798	O céu ficou nublado.\n	空が曇った。\n	\N		\N	vmod	\N	\N	\N	0	1
1	Bom dia, Cláudia.	クラウヂア、おはよう。	挨拶する		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
2	Como vai você?	元気？	挨拶をする		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
3	Bom dia, Paulo.	おはよう、パウロ。	挨拶をする		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
4	Tudo bem.	元気よ	挨拶をする		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
5	E você?	あなたは？	聞き返す		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	\N
6	Tudo bem.	元気だよ。	挨拶をする		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
7	Você tem compromisso no fim de semana?	この週末、予定ある？	予定を訊ねる		\N	dmod	pb01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
897			\N		\N	vmod	\N	\N	\N	0	1
111	Quanto eles tavam pedindo?	いくらだって言ってた？	情報を求める（金額）		\N	dmod	pb08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
146	Só isso?	それだけですか			\N	dmod	pb10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
213	Você também faz compras no supermercado?	スーパーで買い物はできる？	技能や能力についてたずねる		\N	dmod	pb15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
474	Você está brincando.	冗談だろ。			\N	dmod	pb35.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
594	Como você se chama？\n\n	あなたのお名前は？\n\n	\N		\N	vmod	\N	\N	\N	0	1
736	Meu irmão mais velho tem trinta anos.\n	私の一番上の兄は30歳だ。\n	\N		\N	vmod	\N	\N	\N	0	1
793	Ele coçou o nariz.\n	彼は鼻を引っかいた。\n	\N		\N	vmod	\N	\N	\N	0	1
882	As janelas meio abertas, deixavam passar o vento.\n	半ば開いた窓から風が入ってきた。\n	\N		\N	vmod	\N	\N	\N	0	1
883	Quantos graus faz por aqui no verão?\n	この辺りは夏になると何度くらいになりますか？\n	\N		\N	vmod	\N	\N	\N	0	1
884	Ela vestia um suéter verde.\n	彼女は緑色のセーターを着ていた。\n	\N		\N	vmod	\N	\N	\N	0	1
885	O motorista não respeitou o sinal vermelho.\n	運転手は赤信号に従わなかった。\n	\N		\N	vmod	\N	\N	\N	0	1
886	Passando pelo centro da vertical, trace outra linha perpendicular.\n	縦線の中央を通る別の垂直線を引きなさい。\n	\N		\N	vmod	\N	\N	\N	0	1
887	Ele está vestindo de pretro.\n	彼は黒い服を着ている。\n	\N		\N	vmod	\N	\N	\N	0	1
888	Ele vestiu a camisa da seleção brasileira.\n	彼はブラジル代表のシャツを着た。\n	\N		\N	vmod	\N	\N	\N	0	1
889	Ela não gosta de viagem de ônibus.\n	彼女はバス旅行が嫌いだ。\n	\N		\N	vmod	\N	\N	\N	0	1
890	Um dia, queria viajar para a África.\n	いつか、アフリカを旅行したい。\n	\N		\N	vmod	\N	\N	\N	0	1
891	Prefiro vinho tinto um pouco encorpado.\n	やや渋めの赤ワインが好みです。\n	\N		\N	vmod	\N	\N	\N	0	1
892	Foi ele que me ensinou a tocar violão.\n	彼が私にギターのひき方を教えてくれた。\n	\N		\N	vmod	\N	\N	\N	0	1
893	Você vai em frente e vira à direita no segundo sinal.\n	まっすぐに行って、２番目の信号を右に曲がってください。\n	\N		\N	vmod	\N	\N	\N	0	1
894	Meu vizinho vendeu caro a sua casa.\n	私の隣人は高値で家を売った。\n	\N		\N	vmod	\N	\N	\N	0	1
895	A voz dela é suave.\n	彼女の声は心地よい。\n	\N		\N	vmod	\N	\N	\N	0	1
896	Tomou um gole de leite daquela xícara.\n	ボウルから牛乳を一口飲んだ。\n	\N		\N	vmod	\N	\N	\N	0	1
898	Por favor, apertem o cinto de segurança.	セーフティー・ベルトをお締めください。	\N		\N	vmod	\N	\N	\N	0	1
899	O céu está limpo hoje.	今日は晴れだ。	\N		\N	vmod	\N	\N	\N	0	1
900	Os japoneses aprendem a escrever ideogramas desde criança.	日本人は小さい頃から漢字の書き方を学びます。	\N		\N	vmod	\N	\N	\N	0	1
901	Minha mãe me deu um anel bonito.	母は私に素敵なプレゼントをくれた。	\N		\N	vmod	\N	\N	\N	0	1
902	Minha mãe me deu um belo presente.	母は私に素敵なプレゼントをくれた。	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: pb
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	5	行く	1	1
2	885	英語	1	1
3	886	飛行機	1	1
4	887	外国	1	1
5	888	外国人	1	1
6	889	フランス語	1	1
7	890	ホテル	1	1
8	891	日本語	1	1
9	280	出掛ける	1	1
10	892	国（くに）	1	1
11	205	会う	1	1
12	893	休み	1	1
13	54	旅行	1	1
14	894	旅行する	1	1
15	576	遊ぶ	1	1
16	895	大使館	1	1
17	896	大好き	1	1
18	70	好き	1	1
19	9	上手（じょうず）	1	1
20	897	走る	1	1
21	898	ゆっくり	1	1
22	276	下手（へた）	1	1
23	378	歩く	1	1
24	899	泳ぐ	1	1
25	168	速い［スピードが～］	1	1
26	900	飛ぶ	1	1
27	901	スポーツ	1	1
29	903	プール	1	1
30	904	バス	1	1
31	905	自転車	1	1
32	906	交差点	1	1
33	373	道（みち）	1	1
34	907	池	1	1
35	908	散歩	1	1
36	284	かわ（川・河）	1	1
37	909	タクシー	1	1
38	636	自動車，車（くるま）	1	1
39	363	曲がる	1	1
40	910	ネクタイ	1	1
41	200	ワイシャツ	1	1
42	533	会社	1	1
43	911	背広	1	1
44	55	やる	1	1
45	912	吸う	1	1
46	316	電話	1	1
47	185	仕事	1	1
48	218	働く・勤める	1	1
49	567	忙しい	1	1
50	716	図書館	1	1
51	720	辞書，字引	1	1
52	913	借りる	1	1
53	33	新聞	1	1
54	443	読む	1	1
55	160	本	1	1
56	914	コピー	1	1
58	916	雑誌	1	1
59	917	冊	1	1
60	918	牛肉	1	1
61	211	安い	1	1
62	209	店	1	1
63	758	高い	1	1
64	197	いくつ	1	1
65	197	いくら	1	1
66	919	果物	1	1
67	920	野菜	1	1
68	921	魚	1	1
69	922	豚肉	1	1
70	923	鳥肉	1	1
71	271	肉	1	1
72	22	欲しい	1	1
73	924	渡す	1	1
74	925	八百屋	1	1
75	926	かぎ（鍵）	1	1
76	927	料理	1	1
77	928	買い物する	1	1
78	929	洗濯する	1	1
79	930	掃除する	1	1
80	931	家族、家庭	1	1
82	932	庭（にわ）	1	1
83	933	洗濯	1	1
84	131	うち（家）	1	1
85	131	家（いえ）	1	1
86	934	掃除	1	1
87	642	かえる（帰・返）	1	1
88	935	本棚	1	1
89	936	机	1	1
90	937	椅子（いす）	1	1
91	938	部屋	1	1
92	939	冷蔵庫	1	1
93	348	洗う	1	1
94	581	ベッド	1	1
95	940	ラジオ	1	1
96	941	～という名前です	1	1
97	942	寝る	1	1
98	943	起きる	1	1
99	760	テーブル	1	1
100	944	テレビ	1	1
102	431	警官、お巡りさん	1	1
103	945	地図	1	1
105	283	ここ,こちら, こっち	1	1
106	856	そこ	1	1
107	81	あちら, あっち，あそこ	1	1
108	589	どこ,どちら,どっち	1	1
109	947	交番	1	1
110	95	近く、そば	1	1
111	948	隣	1	1
112	949	きく	1	1
113	329	切る	1	1
114	409	短い	1	1
115	950	後ろ	1	1
116	293	前	1	1
117	364	右	1	1
118	375	左	1	1
119	392	長い	1	1
120	951	座る	1	1
121	943	立つ	1	1
122	46	友達	1	1
123	952	クラス	1	1
124	953	教室	1	1
125	954	廊下	1	1
126	506	学校	1	1
127	955	生徒	1	1
128	956	勉強	1	1
129	957	学生	1	1
130	958	留学生	1	1
131	959	夏休み	1	1
132	508	先生	1	1
133	960	大学	1	1
134	961	ノート	1	1
135	962	授業	1	1
136	963	作文	1	1
137	964	宿題	1	1
138	965	難しい	1	1
139	966	教える	1	1
140	967	テスト	1	1
141	968	練習	1	1
142	969	易しい	1	1
143	970	練習する	1	1
144	971	質問	1	1
145	972	問題	1	1
146	973	答える	1	1
147	974	痛い	1	1
148	975	歯	1	1
149	137	医者	1	1
150	976	病院	1	1
151	977	病気	1	1
152	978	薬（くすり）	1	1
153	167	死ぬ	1	1
154	979	風邪（かぜ）	1	1
155	980	頭（あたま）	1	1
156	981	お腹	1	1
157	982	度（ど）	1	1
158	983	エレベーター	1	1
159	984	切符	1	1
160	985	おりる	1	1
161	986	階段	1	1
162	987	閉める	1	1
163	988	駅	1	1
164	989	地下鉄	1	1
165	990	乗る	1	1
166	63	開ける	1	1
168	991	トイレ	1	1
169	992	電車	1	1
170	993	飲み物	1	1
171	994	コーヒー	1	1
172	994	喫茶店	1	1
173	995	レモン	1	1
174	996	牛乳	1	1
175	997	砂糖	1	1
176	998	カップ	1	1
177	999	お茶	1	1
178	1000	紅茶	1	1
179	334	コップ	1	1
180	332	入れる	1	1
181	1001	甘い	1	1
182	640	飲む	1	1
183	1002	はし	1	1
184	1003	酒	1	1
185	1004	おいしい	1	1
186	1005	ナイフ	1	1
187	1006	スプーン	1	1
188	1007	フォーク	1	1
189	1008	チーズ	1	1
190	72	食べる	1	1
191	1009	まずい	1	1
192	1010	パン	1	1
193	1011	辛い	1	1
194	229	レストラン	1	1
195	1012	食堂	1	1
196	1013	酒・ワイン	1	1
197	230	食べ物	1	1
198	1014	カレー	1	1
199	453	お金	1	1
200	764	銀行	1	1
201	1015	入り口、玄関	1	1
202	1016	どうぞ	1	1
203	129	いいえ	1	1
204	25	ええ	1	1
206	1018	どうぞ	2	1
207	1019	出口	1	1
208	287	着く	1	1
209	1020	ポスト	1	1
210	1021	はがき	1	1
211	171	張る	1	1
212	1022	封筒	1	1
213	1023	手紙	1	1
214	1024	郵便局	1	1
215	468	返す	1	1
216	1025	出す	1	1
217	1026	切手	1	1
218	1027	荷物	1	1
219	1028	枚	1	1
220	1029	貸す	1	1
221	52	買う	1	1
222	1030	帽子	1	1
223	1031	靴	1	1
224	350	買い物	1	1
225	378	階	1	1
226	1032	デパート	1	1
227	408	スカート	1	1
228	1033	コート	1	1
229	1034	ズボン	1	1
230	1035	セーター	1	1
231	1018	…てください	1	1
232	1036	かばん	1	1
233	1037	売る	1	1
234	1033	上着	1	1
235	1038	ふろ	1	1
236	1039	建物	1	1
237	927	台所	1	1
238	1040	シャワー	1	1
239	1041	窓	1	1
240	305	住む	1	1
241	1042	公園	1	1
243	59	浴びる［一風呂～］	1	1
244	1043	アパート	1	1
246	1044	彼	1	1
247	1045	彼ら	1	1
248	21	私（わたし）	1	1
249	768	私たち	1	1
250	1046	だれか	1	1
251	637	だれ	1	1
252	637	どなた	1	1
253	6	きみ	1	1
254	6	あなた	1	1
255	1047	この	1	1
256	1048	その	1	1
257	4	いかが，どう	1	1
258	26	どの	1	1
259	48	どんな	1	1
260	595	こんな	1	1
261	1049	自分	1	1
262	103	そう	1	1
263	1050	厚い	1	1
264	1051	狭い	1	1
265	425	細い	1	1
266	250	大きい	1	1
267	1050	太い	1	1
268	560	若い	1	1
269	1052	広い	1	1
270	1053	軽い	1	1
271	1054	遠い	1	1
272	1055	重い	1	1
273	425	薄い	1	1
274	560	新しい	1	1
275	226	小さい	1	1
277	1056	古い	1	1
278	1057	楽しい	1	1
279	440	にぎやか	1	1
280	385	低い	1	1
281	1	よい	1	1
282	174	明るい	1	1
283	1058	弱い	1	1
284	1059	強い	1	1
285	222	おもしろい	1	1
286	882	きれい	1	1
287	192	遅い	1	1
289	1060	多い	1	1
290	415	暗い	1	1
291	1061	静か	1	1
292	181	少ない	1	1
293	1062	汚い	1	1
294	1063	つまらない	1	1
295	946	横	1	1
296	1064	中（なか）	1	1
297	577	外（そと）	1	1
298	1065	東（ひがし）	1	1
299	1066	高さ	1	1
300	1067	縦	1	1
301	1068	北（きた）	1	1
302	1069	西（にし）	1	1
304	1070	南（みなみ）	1	1
305	85	上（うえ）	1	1
306	293	先（さき）	1	1
307	34	後（あと）	1	1
308	1071	いとこ	1	1
309	1072	兄、お兄さん	1	1
310	1073	兄弟（きょうだい）	1	1
311	1074	おばあさん	1	1
312	1075	おじいさん	1	1
313	1076	奥さん	1	1
315	1078	叔父，伯父	1	1
316	1079	両親	1	1
318	1080	姉、お姉さん	1	1
319	1081	姉妹	1	1
320	1082	叔母，伯母	1	1
323	102	お父さん、父	1	1
324	1077	お母さん、母	1	1
325	1083	靴下	1	1
326	200	シャツ	1	1
327	1084	脱ぐ	1	1
328	1085	架ける	1	1
329	1086	は（穿）く［ズボンを～］	1	1
330	1087	着る	1	1
331	332	かぶる	1	1
332	1088	ハンカチ	1	1
333	1089	スリッパ	1	1
334	1090	傘	1	1
335	1091	ポケット	1	1
336	1092	財布	1	1
337	407	着ている	1	1
338	1093	服	1	1
339	158	洋服、服	1	1
340	1094	口	1	1
341	1095	腕（うで）	1	1
342	1096	体（からだ）	1	1
343	1097	顔	1	1
344	1098	脚（あし）	1	1
345	1099	手（て）	1	1
346	1100	鼻	1	1
347	387	目（め）	1	1
348	1101	耳	1	1
349	1102	足（あし）	1	1
351	1103	皿（さら）	1	1
352	1104	バター	1	1
353	1105	茶わん	1	1
354	1106	あめ	1	1
355	1107	昼御飯	1	1
357	1001	お菓子	1	1
358	1109	卵	1	1
359	1110	朝御飯	1	1
360	1111	御飯（ごはん）	1	1
361	1112	醤油	1	1
362	1113	塩（しお）	1	1
363	1108	晩御飯、夕飯	1	1
364	1114	くわえる	1	1
365	578	つける	1	1
366	1115	カメラ	1	1
367	1116	ストーブ	1	1
368	1117	鉛筆	1	1
369	1118	消す	1	1
370	1119	眼鏡（めがね）	1	1
371	1120	テープレコーダー	1	1
372	1121	時計	1	1
373	1122	コンピュータ	1	1
374	29	フィルム	1	1
375	381	戸（と）、ドア	1	1
376	1123	門（もん）	1	1
377	1124	ペン	1	1
378	1125	万年筆	1	1
379	1124	ボールペン	1	1
380	1126	八月	1	1
381	1127	四月	1	1
382	1128	今月	1	1
383	1129	毎月（まいつき）	1	1
384	1130	十二月	1	1
385	1131	二月	1	1
386	1132	一月	1	1
387	1133	七月	1	1
388	1134	六月	1	1
389	1135	来月	1	1
390	1136	五月	1	1
391	1137	三月	1	1
392	1138	先月	1	1
393	1139	十一月	1	1
394	1140	十月	1	1
395	1141	九月	1	1
396	1142	ひとつき	1	1
397	1143	今週	1	1
398	1144	毎週	1	1
399	792	日曜日	1	1
400	1145	木曜日	1	1
401	1146	来週	1	1
402	1147	月曜日	1	1
403	1148	火曜日	1	1
404	1149	水曜日	1	1
405	781	土曜日	1	1
406	17	週間	1	1
407	1150	先週	1	1
408	1151	金曜日	1	1
409	112	年（ねん）	1	1
410	1152	秋	1	1
411	1153	今年（ことし）	1	1
412	1154	毎年（まいとし）	1	1
413	1155	夏（なつ）	1	1
414	1156	冬	1	1
415	1157	去年	1	1
416	1158	来年	1	1
417	1159	春	1	1
418	1160	再来年	1	1
419	1161	おととし	1	1
420	192	午後	1	1
421	239	今日（きょう）	1	1
422	264	明日（あした）	1	1
423	184	時（じ）	1	1
424	128	昨日（きのう）	1	1
425	1162	夕べ	1	1
426	1163	午前	1	1
427	1163	朝	1	1
428	2	昼	1	1
429	265	夜（よる）	1	1
430	192	夕方	1	1
431	1164	あさって	1	1
432	1165	おととい	1	1
433	139	もう	1	1
434	1166	ながら	1	1
435	395	まだ	1	1
436	369	中(ちゅう)	1	1
437	196	時（とき）	1	1
438	40	いつ	1	1
439	1167	ときどき	1	1
440	1168	しばしば	1	1
441	184	時間	1	1
442	678	すぐ	1	1
443	1169	灰皿	1	1
444	1170	歌（うた）	1	1
445	1171	歌う	1	1
446	1172	たばこ	1	1
447	29	映画	1	1
448	1173	レコード	1	1
449	1174	ギター	1	1
450	1175	弾く	1	1
451	1176	音楽	1	1
452	1177	絵（え）	1	1
453	1178	写真	1	1
454	70	好き，気に入る	1	1
455	1179	声	1	1
456	1180	晴れ	1	1
457	1181	暑い	1	1
458	1182	晴れる	1	1
459	1183	涼しい	1	1
460	1184	寒い	1	1
461	1185	雪（ゆき）	1	1
462	1186	雨が降る	1	1
463	1187	雨（あめ）	1	1
464	1188	天気	1	1
465	1189	あたたかい（暖・温）	1	1
466	1190	風（かぜ）	1	1
467	1191	曇り	1	1
468	1184	冷たい	1	1
469	1192	曇る	1	1
470	1193	漢字	1	1
471	535	言う	1	1
472	1194	書く	1	1
473	1195	話（はなし）	1	1
474	1196	言葉	1	1
475	1197	～語	1	1
476	597	言葉	1	1
477	36	話す	1	1
478	1198	文章	1	1
479	225	語る	1	1
480	1199	意味	1	1
481	1200	大人（おとな）	1	1
482	1201	大勢	1	1
483	1202	夫婦	1	1
484	767	子供	1	1
485	1076	妻	1	1
486	163	女（おんな）	1	1
487	571	男の子	1	1
489	827	男（おとこ）	1	1
490	1203	女の子	1	1
491	1204	夫	1	1
492	399	人（ひと）	1	1
493	1205	みんな	1	1
494	1206	白（しろ），白い	1	1
495	388	青，青い	1	1
496	1207	茶色	1	1
497	174	明るい，淡い	1	1
498	413	色（いろ）	1	1
499	415	濃い，暗い	1	1
500	1208	黄色（きいろ），黄色い	1	1
501	416	黒（くろ），黒い	1	1
502	1209	赤，赤い	1	1
503	1210	緑	1	1
504	1211	便利	1	1
505	175	パーティー	1	1
506	1212	紙	1	1
507	1213	～になる	1	1
508	464	締める	1	1
509	1214	押す	1	1
510	1215	始まる	1	1
511	214	ちょうど	1	1
512	1216	ない	1	1
513	1217	まっすぐ	1	1
514	1218	有名	1	1
515	1219	元気	1	1
516	217	じゃあ	1	1
517	254	多分	1	1
518	217	では	1	1
519	598	あの	1	1
520	69	どういたしまして	1	1
521	138	彼女	1	1
522	1220	彼女ら	1	1
524	1221	下（した）	1	1
525	60	多い	1	1
526	1222	留学生	1	1
527	1223	鳥肉	1	1
528	1224	スリッパ	1	1
530	1225	おととし	1	1
531	1226	借りる	1	1
533	1016	・・・てください	1	1
535	1017	すみません	1	1
539	1228	八百屋	1	1
540	1229	悪い	1	1
542	1230	大勢	1	1
543	1231	曇る	1	1
544	1232	来週	1	1
545	1233	来年	1	1
546	1234	来月	1	1
547	1235	飛ぶ	1	1
549	1236	ときどき	1	1
550	1237	カメラ	1	1
551	1238	晴れ	1	1
552	1239	曇り	1	1
553	1240	漢字	1	1
554	1241	意味	1	1
555	79	きれい	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: pb
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
96	79593	2.3102	2.31	用	活動	言語	名	名のる	名のる	なのる
97	82694	2.3390999	2.33	用	活動	生活	立ち居	寝る	寝る	ねる
98	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
99	53468	1.447	1.44	体	生産物	住居	家具	テーブル	テーブル	てえぶる
100	55994	1.462	1.46	体	生産物	機械	電気器具・部品	テレビ	テレビ	てれび
102	20056	1.2417001	1.24	体	主体	成員	保安サービス	警官	警官	けいかん
103	32060	1.3115	1.31	体	活動	言語	表・図・譜・式	地図	地図	ちず
105	10765	1.173	1.17	体	関係	空間	方向・方角	こちら	こちら	こちら
106	9986	1.17	1.17	体	関係	空間	空間・場所	そちら	そちら	そちら
107	9997	1.17	1.17	体	関係	空間	空間・場所	あっち	あっち	あっち
108	10006	1.17	1.17	体	関係	空間	空間・場所	どちら	どちら	どちら
109	23216	1.266	1.26	体	主体	社会	教室・兵営など	交番	交番	こうばん
110	11706	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	近く	近く	ちかく
111	11678	1.178	1.17	体	関係	空間	ふち・そば・まわり・沿い	隣	隣	となり
112	80087	2.3132	2.31	用	活動	言語	問答	きく（聞・聴）	きく	きく
113	73645	2.1571	2.15	用	関係	作用	切断	切る	切る	きる
114	94005	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	短い	短い	みじかい
115	10983	1.174	1.17	体	関係	空間	左右・前後・たてよこ	後ろ	後ろ	うしろ
116	10981	1.174	1.17	体	関係	空間	左右・前後・たてよこ	前（まえ）	前	まえ
117	10956	1.174	1.17	体	関係	空間	左右・前後・たてよこ	右（みぎ）	右	みぎ
118	10954	1.174	1.17	体	関係	空間	左右・前後・たてよこ	左（ひだり）	左	ひだり
119	94000	3.1910999	3.19	相	関係	量	長短・高低・深浅・厚薄・遠近	長い	長い	ながい
120	82724	2.3390999	2.33	用	活動	生活	立ち居	座る	座る	すわる
121	82608	2.3390999	2.33	用	活動	生活	立ち居	立つ	立つ	たつ
122	17007	1.221	1.22	体	主体	仲間	友・なじみ	友達	友達	ともだち
123	23913	1.276	1.27	体	主体	機関	同盟・団体	クラス	クラス	くらす
124	22500	1.263	1.26	体	主体	社会	社寺・学校	教室	教室	きょうしつ
125	53080	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	廊下	廊下	ろうか
126	22471	1.263	1.26	体	主体	社会	社寺・学校	学校	学校	がっこう
127	20241	1.2419	1.24	体	主体	成員	学徒	生徒	生徒	せいと
128	26775	1.3049999	1.30	体	活動	心	学習・習慣・記憶	勉強	勉強	べんきょう
129	20240	1.2419	1.24	体	主体	成員	学徒	学生	学生	がくせい
130	20281	1.2419	1.24	体	主体	成員	学徒	留学生	留学生	りゅうがくせい
131	36595	1.332	1.33	体	活動	生活	労働・作業・休暇	夏休み	夏休み	なつやすみ
132	19186	1.2410001	1.24	体	主体	成員	専門的・技術的職業	先生	先生	せんせい
133	22517	1.263	1.26	体	主体	社会	社寺・学校	大学	大学	だいがく
134	55740	1.459	1.45	体	生産物	道具	札・帳など	ノート	ノート	のおと
135	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
136	30813	1.3103	1.31	体	活動	言語	表現	作文	作文	さくぶん
137	28288	1.307	1.30	体	活動	心	意味・問題・趣旨など	宿題	宿題	しゅくだい
138	92156	3.1345999	3.13	相	関係	様相	難易・安危	難（むずか）しい	難しい	むずかしい
139	85608	2.3640001	2.36	用	活動	待遇	教育・養成	教える	教える	おしえる
140	27779	1.3065	1.30	体	活動	心	研究・試験・調査・検査など	テスト	テスト	てすと
141	26691	1.3049999	1.30	体	活動	心	学習・習慣・記憶	練習	練習	れんしゅう
142	92207	3.1345999	3.13	相	関係	様相	難易・安危	易しい	易しい	やさしい
143	77118	2.3050001	2.30	用	活動	心	学習・習慣・記憶	練習する	練習する	れんしゅうする
144	32755	1.3132	1.31	体	活動	言語	問答	質問	質問	しつもん
145	32796	1.3132	1.31	体	活動	言語	問答	問題	問題	もんだい
146	80142	2.3132	2.31	用	活動	言語	問答	答える	答える	こたえる
147	95091	3.3001001	3.30	相	活動	心	感覚	痛い	痛い	いたい
148	65338	1.5606	1.56	体	自然	身体	骨・歯・爪・角・甲	歯	歯	は
149	19217	1.2410001	1.24	体	主体	成員	専門的・技術的職業	医者	医者	いしゃ
150	23103	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	病院	病院	びょういん
151	66408	1.5721	1.57	体	自然	生命	病気・体調	病気	病気	びょうき
152	51929	1.436	1.43	体	生産物	食料	薬剤・薬品	薬（くすり）	薬	くすり
153	90096	2.5702	2.57	用	自然	生命	死	死ぬ	死ぬ	しぬ
154	66730	1.5721	1.57	体	自然	生命	病気・体調	風邪（かぜ）	風邪	かぜ
155	64318	1.5601	1.56	体	自然	身体	頭・目鼻・顔	頭（あたま）	頭	あたま
156	64638	1.5602	1.56	体	自然	身体	胸・背・腹	おなか	おなか	おなか
157	15048	1.1962	1.19	体	関係	量	助数接辞	度（ど）	度	ど
158	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
159	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
160	71949	2.154	2.15	用	関係	作用	上がり・下がり	おりる（下・降）	おりる	おりる
161	53094	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	階段	階段	かいだん
162	72672	2.1552999	2.15	用	関係	作用	開閉・封	閉める	閉める	しめる
163	22785	1.2640001	1.26	体	主体	社会	事務所・市場・駅など	駅	駅	えき
164	56688	1.465	1.46	体	生産物	機械	乗り物（陸上）	地下鉄	地下鉄	ちかてつ
165	72074	2.1540999	2.15	用	関係	作用	乗り降り・浮き沈み	乗る	乗る	のる
166	72635	2.1552999	2.15	用	関係	作用	開閉・封	開ける	開ける	あける
168	53060	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	トイレ	トイレ	といれ
169	56645	1.465	1.46	体	生産物	機械	乗り物（陸上）	電車	電車	でんしゃ
170	51732	1.4349999	1.43	体	生産物	食料	飲料・たばこ	飲み物	飲み物	のみもの
171	51777	1.4349999	1.43	体	生産物	食料	飲料・たばこ	コーヒー	コーヒー	こおひい
172	22917	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	喫茶店	喫茶店	きっさてん
173	61891	1.5401	1.54	体	自然	植物	木本	レモン	レモン	れもん
174	65461	1.5607001	1.56	体	自然	身体	体液・分泌物	牛乳	牛乳	ぎゅうにゅう
175	51376	1.433	1.43	体	生産物	食料	調味料・こうじなど	砂糖	砂糖	さとう
176	54102	1.452	1.45	体	生産物	道具	食器・調理器具	カップ	カップ	かっぷ
177	51744	1.4349999	1.43	体	生産物	食料	飲料・たばこ	お茶	お茶	おちゃ
178	51748	1.4349999	1.43	体	生産物	食料	飲料・たばこ	紅茶	紅茶	こうちゃ
179	54101	1.452	1.45	体	生産物	道具	食器・調理器具	コップ	コップ	こっぷ
180	71458	2.1531999	2.15	用	関係	作用	入り・入れ	入れる	入れる	いれる
181	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
182	83154	2.3392999	2.33	用	活動	生活	口・鼻・目の動作	飲む	飲む	のむ
183	54175	1.452	1.45	体	生産物	道具	食器・調理器具	はし	はし	はし
184	51821	1.4349999	1.43	体	生産物	食料	飲料・たばこ	酒（さけ）	酒	さけ
185	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
186	54781	1.455	1.45	体	生産物	道具	刃物	ナイフ	ナイフ	ないふ
187	54192	1.452	1.45	体	生産物	道具	食器・調理器具	スプーン	スプーン	すぷうん
188	54190	1.452	1.45	体	生産物	道具	食器・調理器具	フォーク	フォーク	ふぉおく
189	51478	1.433	1.43	体	生産物	食料	調味料・こうじなど	チーズ	チーズ	ちいず
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
243	82121	2.3334	2.33	用	活動	生活	保健・衛生	浴びる［一風呂～］	浴びる	あびる
244	52878	1.443	1.44	体	生産物	住居	部屋・床・廊下・階段など	部屋	部屋	へや
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
315	16866	1.215	1.21	体	主体	家族	親戚	伯父・叔父（おじ）	伯父・叔父	おじ
316	16488	1.212	1.21	体	主体	家族	親・先祖	両親	両親	りょうしん
318	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
319	16799	1.214	1.21	体	主体	家族	兄弟	姉	姉	あね
320	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
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
351	54077	1.452	1.45	体	生産物	道具	食器・調理器具	皿（さら）	皿	さら
352	51476	1.433	1.43	体	生産物	食料	調味料・こうじなど	バター	バター	ばたあ
353	54092	1.452	1.45	体	生産物	道具	食器・調理器具	茶わん	茶わん	ちゃわん
354	51586	1.434	1.43	体	生産物	食料	菓子	あめ	あめ	あめ
355	36936	1.3331	1.33	体	活動	生活	食生活	昼御飯	昼御飯	ひるごはん
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
367	53573	1.447	1.44	体	生産物	住居	家具	ストーブ	ストーブ	すとおぶ
368	54236	1.4529999	1.45	体	生産物	道具	文具	鉛筆	鉛筆	えんぴつ
369	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
370	55889	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	眼鏡（めがね）	眼鏡	めがね
371	56004	1.462	1.46	体	生産物	機械	電気器具・部品	テープレコーダー	テープレコーダー	てえぷれこおだあ
372	56398	1.464	1.46	体	生産物	機械	計器	時計	時計	とけい
373	56126	1.462	1.46	体	生産物	機械	電気器具・部品	コンピューター	コンピューター	こんぴゅうたあ
374	55946	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	フィルム	フィルム	ふぃるむ
375	53346	1.446	1.44	体	生産物	住居	戸・カーテン・敷物・畳など	戸（と）	戸	と
376	52812	1.442	1.44	体	生産物	住居	門・塀	門（もん）	門	もん
377	54250	1.4529999	1.45	体	生産物	道具	文具	ペン	ペン	ぺん
378	54238	1.4529999	1.45	体	生産物	道具	文具	万年筆	万年筆	まんねんひつ
379	54239	1.4529999	1.45	体	生産物	道具	文具	ボールペン	ボールペン	ぼおるぺん
380	14681	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	八月	八月	はちがつ
381	14677	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	四月	四月	しがつ
382	9022	1.1641001	1.16	体	関係	時間	現在	今月	今月	こんげつ
383	7865	1.1612	1.16	体	関係	時間	毎日・毎度	毎月（まいつき）	毎月	まいつき
384	14685	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十二月	十二月	じゅうにがつ
385	14675	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	二月	二月	にがつ
386	14674	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	一月	一月	いちがつ
387	14680	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	七月	七月	しちがつ
388	14679	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	六月	六月	ろくがつ
389	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
390	8510	1.1631	1.16	体	関係	時間	月	五月（さつき）	五月	さつき
391	14676	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	三月	三月	さんがつ
392	9112	1.1641999	1.16	体	関係	時間	過去	先月	先月	せんげつ
393	14684	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十一月	十一月	じゅういちがつ
394	14683	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	十月	十月	じゅうがつ
395	14682	1.1961	1.19	体	関係	量	順位記号（甲乙丙）	九月	九月	くがつ
396	14623	1.196	1.19	体	関係	量	数記号（一二三）	ひとつき	ひとつき	ひとつき
397	9025	1.1641001	1.16	体	関係	時間	現在	今週	今週	こんしゅう
398	7864	1.1612	1.16	体	関係	時間	毎日・毎度	毎週	毎週	まいしゅう
399	8561	1.1632	1.16	体	関係	時間	週・週日	日曜日	日曜日	にちようび
400	8558	1.1632	1.16	体	関係	時間	週・週日	木曜日	木曜日	もくようび
401	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
402	8555	1.1632	1.16	体	関係	時間	週・週日	月曜日	月曜日	げつようび
403	8556	1.1632	1.16	体	関係	時間	週・週日	火曜日	火曜日	かようび
404	8557	1.1632	1.16	体	関係	時間	週・週日	水曜日	水曜日	すいようび
405	8560	1.1632	1.16	体	関係	時間	週・週日	土曜日	土曜日	どようび
406	14890	1.1962	1.19	体	関係	量	助数接辞	週間	週間	しゅうかん
407	9116	1.1641999	1.16	体	関係	時間	過去	先週	先週	せんしゅう
408	8559	1.1632	1.16	体	関係	時間	週・週日	金曜日	金曜日	きんようび
409	14871	1.1962	1.19	体	関係	量	助数接辞	年（ねん）	年	ねん
410	8389	1.1624	1.16	体	関係	時間	季節	秋	秋	あき
411	9013	1.1641001	1.16	体	関係	時間	現在	今年（ことし）	今年	ことし
412	7870	1.1612	1.16	体	関係	時間	毎日・毎度	毎年（まいとし）	毎年	まいとし
413	8375	1.1624	1.16	体	関係	時間	季節	夏（なつ）	夏	なつ
414	8403	1.1624	1.16	体	関係	時間	季節	冬	冬	ふゆ
415	9103	1.1641999	1.16	体	関係	時間	過去	去年	去年	きょねん
416	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
417	8361	1.1624	1.16	体	関係	時間	季節	春	春	はる
418	9201	1.1643	1.16	体	関係	時間	未来	再来年	再来年	さらいねん
419	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
420	8824	1.1635	1.16	体	関係	時間	朝晩	午後	午後	ごご
421	9026	1.1641001	1.16	体	関係	時間	現在	今日（きょう）	今日	きょう
422	9211	1.1643	1.16	体	関係	時間	未来	明日（あした）	明日	あした
423	14900	1.1962	1.19	体	関係	量	助数接辞	時（じ）	時	じ
424	9118	1.1641999	1.16	体	関係	時間	過去	昨日（きのう）	昨日	きのう
425	9127	1.1641999	1.16	体	関係	時間	過去	夕べ	夕べ	ゆうべ
426	8822	1.1635	1.16	体	関係	時間	朝晩	午前	午前	ごぜん
427	8856	1.1635	1.16	体	関係	時間	朝晩	朝	朝	あさ
428	8873	1.1635	1.16	体	関係	時間	朝晩	昼	昼	ひる
429	8908	1.1635	1.16	体	関係	時間	朝晩	夜（よる）	夜	よる
430	8891	1.1635	1.16	体	関係	時間	朝晩	夕方	夕方	ゆうがた
431	9219	1.1643	1.16	体	関係	時間	未来	あさって	あさって	あさって
432	9122	1.1641999	1.16	体	関係	時間	過去	おととい	おととい	おととい
433	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
434	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
435	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
436	94851	3.194	3.19	相	関係	量	一般・全体・部分	－中（じゅう）［町～・一日～］	－中	じゅう
437	7449	1.16	1.16	体	関係	時間	時間	時（とき）	時	とき
438	7603	1.1611	1.16	体	関係	時間	時機・時刻	いつ	いつ	いつ
439	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
440	93175	3.1612	3.16	相	関係	時間	毎日・毎度	よく	よく	よく
441	14901	1.1962	1.19	体	関係	量	助数接辞	時間	時間	じかん
442	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
443	53826	1.4511	1.45	体	生産物	道具	瓶・筒・つぼ・膳など	灰皿	灰皿	はいざら
444	34792	1.321	1.32	体	活動	芸術	文芸	歌（うた）	歌	うた
445	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
446	51920	1.4349999	1.43	体	生産物	食料	飲料・たばこ	たばこ	たばこ	たばこ
447	35701	1.324	1.32	体	活動	芸術	演劇・映画	映画	映画	えいが
448	55164	1.456	1.45	体	生産物	道具	楽器・レコードなど	レコード	レコード	れこおど
449	55090	1.456	1.45	体	生産物	道具	楽器・レコードなど	ギター	ギター	ぎたあ
450	81068	2.323	2.32	用	活動	芸術	音楽	弾く	弾く	ひく
451	35232	1.323	1.32	体	活動	芸術	音楽	音楽	音楽	おんがく
452	35036	1.322	1.32	体	活動	芸術	芸術・美術	絵（え）	絵	え
453	35159	1.322	1.32	体	活動	芸術	芸術・美術	写真	写真	しゃしん
454	95586	3.302	3.30	相	活動	心	好悪・愛憎	好き	好き	すき
455	25605	1.3031	1.30	体	活動	心	声	声	声	こえ
456	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
457	94344	3.1914999	3.19	相	関係	量	寒暖	暑い	暑い	あつい
458	89542	2.5153999	2.51	用	自然	物質	天気	晴れる	晴れる	はれる
459	94363	3.1914999	3.19	相	関係	量	寒暖	涼しい	涼しい	すずしい
460	94373	3.1914999	3.19	相	関係	量	寒暖	寒い	寒い	さむい
461	59878	1.5153	1.51	体	自然	物質	雨・雪	雪（ゆき）	雪	ゆき
462	72062	2.154	2.15	用	関係	作用	上がり・下がり	降る	降る	ふる
463	59793	1.5153	1.51	体	自然	物質	雨・雪	雨（あめ）	雨	あめ
464	59928	1.5154001	1.51	体	自然	物質	天気	天気	天気	てんき
465	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
466	59611	1.5151	1.51	体	自然	物質	風	風（かぜ）	風	かぜ
467	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
468	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
469	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
470	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
471	79279	2.3099999	2.31	用	活動	言語	言語活動	言う	言う	いう
472	80727	2.3151	2.31	用	活動	言語	書き	書く	書く	かく
473	32575	1.3131	1.31	体	活動	言語	話・談話	話（はなし）	話	はなし
474	30264	1.3099999	1.31	体	活動	言語	言語活動	言葉	言葉	ことば
475	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
476	30521	1.3101	1.31	体	活動	言語	言語	語（ご）	語	ご
477	80000	2.3131001	2.31	用	活動	言語	話・談話	話す	話す	はなす
478	33734	1.3154	1.31	体	活動	言語	文章	文章	文章	ぶんしょう
479	80001	2.3131001	2.31	用	活動	言語	話・談話	語る	語る	かたる
480	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
481	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
482	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
483	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
484	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
485	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
486	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
487	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
489	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
490	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
491	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
492	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
493	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
494	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
495	58059	1.502	1.50	体	自然	自然	色	青	青	あお
496	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
497	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
498	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
499	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
500	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
501	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
502	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
503	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
504	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
505	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
506	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
507	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
508	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
509	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
510	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
511	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
512	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
513	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
514	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
515	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
516	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
517	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
518	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
519	90814	3.1010001	3.10	相	関係	真偽	こそあど・他	あの	あの	あの
520	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
521	15578	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼女	彼女	かのじょ
522	15579	1.201	1.20	体	主体	人間	われ・なれ・かれ	彼ら	彼ら	かれら
524	11060	1.1741	1.17	体	関係	空間	上下	上下（うえした）	上下	うえした
525	93826	3.191	3.19	相	関係	量	多少	多い	多い	おおい
526	20238	1.2419	1.24	体	主体	成員	学徒	学徒	学徒	がくと
527	51294	1.4323	1.43	体	生産物	食料	魚・肉	鳥肉	鳥肉	とりにく
528	50294	1.426	1.42	体	生産物	衣料	履き物	スリッパ	スリッパ	すりっぱ
530	9108	1.1641999	1.16	体	関係	時間	過去	おととし	おととし	おととし
531	87585	2.378	2.37	用	活動	経済	貸借	借りる	借りる	かりる
533	85910	2.3659999	2.36	用	活動	待遇	請求・依頼	…てください	…てください	てください
535	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
539	22952	1.265	1.26	体	主体	社会	店・旅館・病院・劇場など	八百屋	八百屋	やおや
540	91682	3.1331999	3.13	相	関係	様相	良不良・適不適	悪い	悪い	わるい
542	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
543	89503	2.5151999	2.51	用	自然	物質	雲	曇る	曇る	くもる
544	9208	1.1643	1.16	体	関係	時間	未来	来週	来週	らいしゅう
545	9196	1.1643	1.16	体	関係	時間	未来	来年	来年	らいねん
546	9206	1.1643	1.16	体	関係	時間	未来	来月	来月	らいげつ
547	70316	2.1522	2.15	用	関係	作用	走り・飛び・流れなど	飛ぶ	飛ぶ	とぶ
549	93190	3.1612	3.16	相	関係	時間	毎日・毎度	時時	時時	ときどき
550	55928	1.461	1.46	体	生産物	機械	鏡・レンズ・カメラ	カメラ	カメラ	かめら
551	59957	1.5154001	1.51	体	自然	物質	天気	晴れ	晴れ	はれ
552	59985	1.5154001	1.51	体	自然	物質	天気	曇り	曇り	くもり
553	31526	1.3113	1.31	体	活動	言語	文字	漢字	漢字	かんじ
554	28234	1.307	1.30	体	活動	心	意味・問題・趣旨など	意味	意味	いみ
555	92053	3.1345	3.13	相	関係	様相	美醜	きれい	きれい	きれい
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
2	381	548	1		0	\N	\N
3	481	549	1		0	\N	\N
4	355	550	1		0	\N	\N
5	299	551	1		0	\N	\N
8	500	553	1		0	\N	\N
9	122	20	0		0	\N	\N
10	225	554	1		0	\N	\N
11	23	555	1		0	\N	\N
13	409	53	0		0	\N	\N
14	175	199	0		0	\N	\N
16	106	526	0		0	\N	\N
17	435	300	0		0	\N	\N
18	250	58	0		0	\N	\N
19	107	38	0		0	\N	\N
21	415	557	1		0	\N	\N
22	367	558	1		0	\N	\N
23	115	559	1		0	\N	\N
25	135	561	1		0	\N	\N
26	3	562	1		0	\N	\N
27	311	563	1		0	\N	\N
28	312	564	1		0	\N	\N
29	495	565	1		0	\N	\N
30	218	566	1		0	\N	\N
31	354	567	1		0	\N	\N
32	232	568	1		0	\N	\N
34	235	570	1		0	\N	\N
35	156	571	1		0	\N	\N
36	170	572	1		0	\N	\N
37	184	573	1		0	\N	\N
38	31	574	1		0	\N	\N
39	335	575	1		0	\N	\N
40	456	576	1		0	\N	\N
41	286	577	1		0	\N	\N
44	134	580	1		0	\N	\N
46	359	582	1		0	\N	\N
48	445	565	0		0	\N	\N
49	60	584	1		0	\N	\N
50	69	584	0		0	\N	\N
51	71	152	0		0	\N	\N
52	432	585	1		0	\N	\N
53	369	586	1		0	\N	\N
54	244	180	0		0	\N	\N
55	105	421	0		0	\N	\N
56	262	48	0		0	\N	\N
57	200	461	0		0	\N	\N
59	19	536	0		0	\N	\N
61	281	104	0		0	\N	\N
62	15	363	0		0	\N	\N
63	329	253	0		0	\N	\N
65	326	106	0		0	\N	\N
66	38	496	0		0	\N	\N
69	213	587	1		0	\N	\N
70	336	588	1		0	\N	\N
71	228	590	1		0	\N	\N
73	177	592	1		0	\N	\N
74	178	593	1		0	\N	\N
75	96	594	1		0	\N	\N
76	222	595	1		0	\N	\N
77	75	596	1		0	\N	\N
78	208	217	0		0	\N	\N
79	166	597	1		0	\N	\N
80	159	598	1		0	\N	\N
81	340	599	1		0	\N	\N
82	341	600	1		0	\N	\N
84	209	602	1		0	\N	\N
86	198	604	1		0	\N	\N
87	333	605	1		0	\N	\N
88	238	606	1		0	\N	\N
89	123	607	1		0	\N	\N
90	234	603	0		0	\N	\N
91	462	608	1		0	\N	\N
92	364	609	1		0	\N	\N
93	380	610	1		0	\N	\N
95	279	556	1		0	\N	\N
96	422	485	1		0	\N	\N
97	127	552	1		0	\N	\N
98	519	611	1		0	\N	\N
99	280	612	1		0	\N	\N
100	168	569	0		0	\N	\N
101	61	613	1		0	\N	\N
103	182	406	1		0	\N	\N
104	50	438	1		0	\N	\N
105	526	615	1		0	\N	\N
106	494	601	1		0	\N	\N
107	155	578	1		0	\N	\N
108	90	579	1		0	\N	\N
109	172	616	1		0	\N	\N
110	171	581	1		0	\N	\N
111	229	583	1		0		\N
112	94	367	1		0	\N	\N
113	41	617	1		0	\N	\N
114	444	618	1		0	\N	\N
115	379	619	1		0	\N	\N
116	377	620	1		0	\N	\N
117	378	603	1		0	\N	\N
118	527	621	1		0	\N	\N
119	63	622	1		0	\N	\N
120	210	623	1		0	\N	\N
123	84	277	1		0	\N	\N
124	85	174	1		0	\N	\N
125	483	591	1		0	\N	\N
126	528	624	1		0	\N	\N
127	463	625	1		0	\N	\N
128	446	626	1		0	\N	\N
130	305	627	1		0	\N	\N
131	443	628	1		0	\N	\N
136	497	630	1		0	\N	\N
137	282	629	1		0	\N	\N
138	464	631	1		0	\N	\N
139	211	632	1		0	\N	\N
141	187	633	1		0	\N	\N
142	510	634	1		0	\N	\N
144	197	636	1		0	\N	\N
146	257	163	1		0	\N	\N
148	224	271	1		0	\N	\N
150	221	243	1		0	\N	\N
151	119	637	1		0	\N	\N
152	373	638	1		0	\N	\N
154	479	231	1		0	\N	\N
155	504	639	1		0	\N	\N
156	56	640	1		0	\N	\N
158	179	197	1		0	\N	\N
159	498	251	0		0	\N	\N
160	342	641	1		0	\N	\N
161	125	642	1		0	\N	\N
162	214	643	1		0	\N	\N
163	20	644	1		0	\N	\N
164	113	645	1		0	\N	\N
165	237	646	1		0	\N	\N
166	76	647	1		0	\N	\N
167	484	644	0		0	\N	\N
168	32	648	1		0	\N	\N
169	114	248	0		0	\N	\N
171	418	650	1		0	\N	\N
172	97	651	1		0	\N	\N
173	185	652	1		0	\N	\N
174	148	653	1		0	\N	\N
175	296	654	1		0	\N	\N
177	307	103	1		0	\N	\N
178	431	655	1		0	\N	\N
179	160	656	1		0	\N	\N
180	21	657	1		0	\N	\N
181	215	658	1		0	\N	\N
182	384	659	1		0	\N	\N
183	428	660	1		0	\N	\N
184	51	440	0		0	\N	\N
185	138	532	0		0	\N	\N
186	199	284	0		0	\N	\N
187	117	220	0		0	\N	\N
188	448	661	1		0	\N	\N
189	278	662	1		0	\N	\N
190	471	491	0		0	\N	\N
191	357	663	1		0	\N	\N
192	181	664	1		0	\N	\N
193	151	665	1		0	\N	\N
194	147	666	1		0	\N	\N
195	530	667	1		0	\N	\N
196	399	487	0		0	\N	\N
197	521	240	0		0	\N	\N
198	246	412	0		0	\N	\N
199	158	668	1		0	\N	\N
200	16	669	1		0	\N	\N
201	524	670	1		0	\N	\N
202	165	671	1		0	\N	\N
203	42	334	0		0	\N	\N
204	220	672	1		0	\N	\N
205	509	673	1		0	\N	\N
206	11	674	1		0	\N	\N
207	434	675	1		0	\N	\N
208	139	676	1		0	\N	\N
209	518	397	0		0	\N	\N
210	516	163	0		0	\N	\N
212	73	678	1		0	\N	\N
213	212	679	1		0	\N	\N
214	216	680	1		0	\N	\N
215	161	681	1		0	\N	\N
216	126	313	0		0	\N	\N
217	472	682	1		0	\N	\N
218	89	683	1		0	\N	\N
219	499	252	0		0	\N	\N
220	290	684	1		0	\N	\N
221	27	685	1		0	\N	\N
222	313	686	1		0	\N	\N
223	485	687	1		0	\N	\N
224	118	225	0		0	\N	\N
225	256	612	0		0	\N	\N
226	397	688	1		0	\N	\N
227	163	689	1		0	\N	\N
228	88	690	1		0	\N	\N
229	515	691	1		0	\N	\N
230	255	661	0		0	\N	\N
231	411	692	1		0	\N	\N
232	382	693	1		0	\N	\N
233	5	694	1		0	\N	\N
234	264	695	1		0	\N	\N
235	129	696	1		0	\N	\N
236	128	697	1		0	\N	\N
237	248	53	0		0	\N	\N
238	141	698	1		0	\N	\N
239	531	699	1		0	\N	\N
240	186	700	1		0	\N	\N
241	142	701	1		0	\N	\N
242	477	16	0		0	\N	\N
244	80	297	1		0	\N	\N
245	514	702	1		0	\N	\N
246	44	270	0		0	\N	\N
247	458	703	1		0	\N	\N
248	77	271	0		0	\N	\N
249	143	698	0		0	\N	\N
250	162	704	1		0	\N	\N
251	12	705	1		0	\N	\N
252	131	706	1		0	\N	\N
253	505	478	0		0	\N	\N
254	385	707	1		0	\N	\N
255	447	255	0		0	\N	\N
256	374	708	1		0	\N	\N
257	273	709	1		0	\N	\N
258	265	710	1		0	\N	\N
259	219	711	1		0	\N	\N
260	297	363	0		0	\N	\N
261	284	712	1		0	\N	\N
262	453	713	1		0	\N	\N
263	283	714	1		0	\N	\N
264	6	57	0		0	\N	\N
265	478	715	1		0	\N	\N
266	306	716	1		0	\N	\N
267	116	170	0		0	\N	\N
268	440	717	1		0	\N	\N
269	459	718	1		0	\N	\N
270	468	719	1		0	\N	\N
271	460	720	1		0	\N	\N
272	66	721	1		0	\N	\N
273	533	628	0		0	\N	\N
274	202	722	1		0	\N	\N
275	188	700	0		0	\N	\N
276	92	723	1		0	\N	\N
278	454	259	0		0	\N	\N
279	18	271	0		0	\N	\N
280	17	724	1		0	\N	\N
281	266	138	0		0	\N	\N
282	157	725	1		0	\N	\N
283	371	726	1		0	\N	\N
284	40	727	1		0	\N	\N
285	267	637	0		0	\N	\N
286	263	728	1		0	\N	\N
287	334	729	1		0	\N	\N
289	294	730	1		0	\N	\N
290	421	134	0		0	\N	\N
291	489	611	0		0	\N	\N
292	492	731	1		0	\N	\N
293	441	129	0		0	\N	\N
294	423	161	0		0	\N	\N
295	150	732	1		0	\N	\N
296	7	733	1		0	\N	\N
297	2	58	0		0	\N	\N
298	285	121	0		0	\N	\N
299	414	734	1		0		\N
300	1	11	0		0	\N	\N
301	318	735	1		0	\N	\N
302	309	736	1		0	\N	\N
303	310	737	1		0	\N	\N
304	319	738	1		0	\N	\N
305	433	436	0		0	\N	\N
306	386	739	1		0	\N	\N
307	239	740	1		0	\N	\N
308	363	741	1		0	\N	\N
309	8	742	1		0	\N	\N
310	82	743	1		0	\N	\N
311	53	744	1		0	\N	\N
312	387	745	1		0	\N	\N
313	388	746	1		0	\N	\N
315	110	689	0		0	\N	\N
316	295	748	1		0	\N	\N
317	34	740	0		0	\N	\N
318	368	749	1		0	\N	\N
319	269	750	1		0	\N	\N
320	83	751	1		0	\N	\N
321	93	211	0		0	\N	\N
322	78	752	1		0	\N	\N
323	67	753	1		0	\N	\N
324	174	754	1		0	\N	\N
325	332	603	0		0	\N	\N
326	54	16	0		0	\N	\N
327	298	755	1		0	\N	\N
328	535	756	1		0	\N	\N
329	470	757	1		0	\N	\N
330	121	758	1		0	\N	\N
331	98	759	1		0	\N	\N
332	270	760	1		0	\N	\N
333	137	761	1		0	\N	\N
334	173	645	0		0	\N	\N
335	79	762	1		0	\N	\N
336	86	763	1		0	\N	\N
337	475	56	0		0	\N	\N
339	476	765	1		0	\N	\N
340	55	438	0		0	\N	\N
341	442	766	1		0	\N	\N
342	62	767	1		0	\N	\N
343	226	768	1		0	\N	\N
344	539	769	1		0	\N	\N
345	271	770	1		0	\N	\N
346	324	398	0		0	\N	\N
347	390	771	1		0	\N	\N
348	22	772	1		0	\N	\N
349	427	19	0		0	\N	\N
350	426	408	0		0	\N	\N
351	352	773	1		0	\N	\N
352	345	774	1		0	\N	\N
353	103	775	1		0	\N	\N
354	366	776	1		0	\N	\N
355	391	777	1		0	\N	\N
356	491	778	1		0	\N	\N
357	496	779	1		0	\N	\N
358	540	780	1		0	\N	\N
359	149	63	0		0	\N	\N
360	325	781	1		0	\N	\N
361	490	782	1		0	\N	\N
362	487	783	1		0	\N	\N
363	392	784	1		0	\N	\N
364	99	459	0		0	\N	\N
365	511	179	0		0	\N	\N
367	164	669	0		0	\N	\N
368	361	786	1		0	\N	\N
369	240	787	1		0	\N	\N
370	153	788	1		0	\N	\N
371	525	614	1		0	\N	\N
372	542	789	1		0	\N	\N
373	486	790	1		0	\N	\N
374	451	791	1		0	\N	\N
375	520	31	0		0	\N	\N
376	24	792	1		0	\N	\N
377	203	227	0		0	\N	\N
378	346	793	1		0	\N	\N
379	461	794	1		0	\N	\N
380	429	353	0		0	\N	\N
381	301	721	0		0	\N	\N
382	249	281	0		0	\N	\N
383	393	795	1		0	\N	\N
384	274	796	1		0	\N	\N
385	268	797	1		0	\N	\N
386	543	798	1		0	\N	\N
387	370	611	0		0	\N	\N
388	49	688	0		0	\N	\N
389	302	799	1		0	\N	\N
390	347	232	0		0	\N	\N
391	108	541	0		0	\N	\N
392	30	164	0		0	\N	\N
393	424	59	0		0	\N	\N
394	425	800	1		0	\N	\N
395	348	801	1		0	\N	\N
396	410	802	1		0	\N	\N
397	394	803	1		0	\N	\N
398	358	553	0		0	\N	\N
399	323	298	0		0	\N	\N
400	316	804	1		0	\N	\N
401	10	805	1		0	\N	\N
402	4	806	1		0	\N	\N
403	192	807	1		0	\N	\N
404	506	711	0		0	\N	\N
405	241	808	1		0	\N	\N
406	35	809	1		0		\N
407	183	810	1		0	\N	\N
408	349	666	0		0	\N	\N
409	68	811	1		0	\N	\N
410	328	812	1		0	\N	\N
412	144	814	1		0	\N	\N
413	112	815	1		0	\N	\N
414	344	816	1		0	\N	\N
415	272	817	1		0	\N	\N
416	193	818	1		0	\N	\N
417	452	819	1		0	\N	\N
418	29	820	1		0	\N	\N
419	102	815	0		0	\N	\N
420	331	821	1		0	\N	\N
421	180	197	0		0	\N	\N
422	375	822	1		0	\N	\N
423	376	43	0		0	\N	\N
424	109	823	1		0	\N	\N
425	292	199	0		0	\N	\N
426	351	824	1		0	\N	\N
427	236	180	0		0	\N	\N
428	501	252	0		0	\N	\N
429	417	825	1		0	\N	\N
430	308	826	1		0	\N	\N
433	132	607	0		0	\N	\N
435	140	701	0		0	\N	\N
436	544	828	1		0	\N	\N
437	545	829	1		0	\N	\N
438	546	564	0		0	\N	\N
439	258	50	0		0	\N	\N
440	438	18	0		0	\N	\N
441	65	830	1		0	\N	\N
442	64	831	1		0	\N	\N
443	404	832	1		0	\N	\N
444	259	833	1		0	\N	\N
445	189	807	0		0	\N	\N
447	252	834	1		0	\N	\N
448	251	400	0		0	\N	\N
449	457	835	1		0	\N	\N
451	72	155	0		0	\N	\N
452	145	837	1		0	\N	\N
453	291	838	1		0	\N	\N
454	400	839	1		0	\N	\N
455	95	840	1		0	\N	\N
456	25	692	0		0	\N	\N
457	136	749	0		0	\N	\N
458	360	841	1		0	\N	\N
459	195	674	0		0	\N	\N
460	372	842	1		0	\N	\N
461	152	578	0		0	\N	\N
462	154	843	1		0	\N	\N
463	45	844	1		0	\N	\N
464	146	837	0		0	\N	\N
465	194	702	0		0	\N	\N
466	513	845	1		0	\N	\N
467	58	846	1		0	\N	\N
468	36	847	1		0	\N	\N
469	343	818	0		0	\N	\N
470	339	243	0		0	\N	\N
471	338	848	1		0	\N	\N
472	33	225	0		0	\N	\N
473	191	849	1		0	\N	\N
474	405	478	0		0	\N	\N
475	227	246	0		0	\N	\N
476	207	642	0		0	\N	\N
477	9	850	1		0	\N	\N
478	362	609	0		0	\N	\N
479	91	740	0		0	\N	\N
480	124	552	0		0	\N	\N
481	547	851	1		0	\N	\N
484	402	852	1		0	\N	\N
485	217	853	1		0	\N	\N
486	406	512	0		0	\N	\N
487	407	25	0		0	\N	\N
488	120	748	0		0	\N	\N
489	395	854	1		0		\N
490	408	855	1		0	\N	\N
491	480	856	1		0	\N	\N
492	204	206	0		0	\N	\N
493	230	630	0		0	\N	\N
494	293	857	1		0	\N	\N
495	304	320	0		0	\N	\N
496	512	162	0		0	\N	\N
497	260	858	1		0	\N	\N
498	517	859	1		0	\N	\N
499	430	860	1		0	\N	\N
500	420	861	1		0	\N	\N
501	287	99	0		0	\N	\N
502	37	173	0		0	\N	\N
503	46	190	0		0	\N	\N
504	100	862	1		0	\N	\N
505	437	464	0		0	\N	\N
506	467	863	1		0	\N	\N
507	403	864	1		0	\N	\N
508	43	865	1		0	\N	\N
509	320	866	1		0	\N	\N
510	353	867	1		0	\N	\N
511	315	868	1		0	\N	\N
512	327	641	0		0	\N	\N
513	450	869	1		0	\N	\N
514	398	870	1		0	\N	\N
515	436	871	1		0	\N	\N
516	493	872	1		0	\N	\N
517	412	868	0		0	\N	\N
518	383	873	1		0	\N	\N
519	243	874	1		0	\N	\N
520	507	875	1		0	\N	\N
521	48	118	0		0	\N	\N
522	47	95	0		0	\N	\N
523	169	876	1		0	\N	\N
524	396	877	1		0	\N	\N
525	133	878	1		0	\N	\N
526	549	879	1		0	\N	\N
527	277	880	1		0	\N	\N
528	233	881	1		0	\N	\N
529	466	882	1		0	\N	\N
530	413	883	1		0	\N	\N
531	503	884	1		0	\N	\N
532	502	885	1		0	\N	\N
533	300	886	1		0	\N	\N
534	337	887	1		0	\N	\N
535	330	888	1		0	\N	\N
536	13	889	1		0	\N	\N
537	14	890	1		0	\N	\N
538	196	891	1		0	\N	\N
539	449	892	1		0	\N	\N
540	39	893	1		0	\N	\N
541	111	894	1		0	\N	\N
542	254	306	0		0	\N	\N
543	253	22	0		0	\N	\N
544	87	408	0		0	\N	\N
545	455	895	1		0	\N	\N
546	176	896	1		0	\N	\N
547	508	898	1		0	\N	0
548	551	899	1		0	\N	0
550	223	666	1		0	\N	0
551	201	624	0		0	\N	0
552	550	713	0		0	\N	0
553	553	900	1		0	\N	0
554	190	810	0		0	\N	0
555	275	557	0		0	\N	0
556	554	856	0		0	\N	0
557	552	863	0		0	\N	0
558	555	902	0		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: pb
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
102	9
103	9
105	9
106	9
107	9
108	9
109	9
110	9
111	9
112	9
113	10
114	10
115	10
116	10
117	10
118	10
119	10
120	10
121	10
122	11
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
147	13
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
158	14
159	14
160	14
161	14
162	14
163	14
164	14
165	14
166	14
168	14
169	14
170	15
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
183	16
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
243	20
244	20
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
315	25
316	25
318	25
319	25
320	25
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
351	28
352	28
353	28
354	28
355	28
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
379	29
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
408	31
409	30
410	32
411	32
412	32
413	32
414	32
415	32
416	32
417	32
418	32
419	32
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
432	33
433	34
434	34
435	34
436	34
437	34
438	34
439	34
440	34
441	34
442	34
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
455	35
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
480	37
481	38
482	38
483	38
484	38
485	38
486	38
487	38
489	38
490	38
491	38
492	38
493	38
494	39
495	39
496	39
497	39
498	39
499	39
500	39
501	39
502	39
503	39
519	21
520	17
521	21
522	21
524	24
525	23
526	11
527	6
528	26
530	32
531	5
533	19
535	17
539	6
540	23
542	38
543	37
544	31
545	32
546	30
547	2
549	34
550	29
551	36
552	36
553	37
554	37
555	23
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
49	trazer	\N	O	\N
50	pra	\N	B	\N
51	presente	\N	D	\N
52	comprar	1	C	\N
53	na	\N	J	\N
54	viagem	1	V	\N
55	fazer	1	F	\N
56	a	\N	F	\N
57	Gramado	\N	T	\N
58	passado	\N	R	\N
59	tomar	1	T	\N
60	muito	1	M	\N
61	obrigado	\N	B	\N
62	gentil	\N	L	\N
63	abrir	1	A	\N
64	oh	\N	Q	\N
65	 delícia 	\N	Q	\N
66	uma	\N	F	\N
67	caixa	\N	L	\N
68	bombom	\N	P	\N
69	de nada	1	N	\N
70	gostar	1	G	\N
71	adorar	\N	C	\N
72	comer	1	C	\N
73	sozinho	\N	E	\N
74	mas	\N	Q	\N
75	dar	\N	C	\N
76	nenhum	\N	C	\N
77	mim	\N	C	\N
78	pensar	\N	L	\N
79	belo	1	B	\N
80	vista	\N	F	\N
81	ali	1	A	\N
82	minha	\N	\N	\N
83	filha	\N	\N	\N
84	em	\N	\N	\N
85	cima	1	C	\N
86	do	\N	\N	\N
87	muro	\N	\N	\N
88	o que	\N	\N	\N
89	o senhor	\N	\N	\N
90	estar	\N	\N	\N
91	ver	\N	\N	\N
92	abelha	\N	\N	\N
93	 estar 	\N	\N	\N
94	agora	\N	\N	\N
95	perto	1	P	\N
96	 portão 	\N	\N	\N
97	vir	\N	\N	\N
98	passarinho	\N	\N	\N
99	ele	\N	\N	\N
100	pegar	\N	\N	\N
101	triste	\N	\N	\N
102	pai	1	P	\N
103	assim	1	A	\N
104	vida	\N	\N	\N
105	seu	\N	\N	\N
106	nome	\N	\N	\N
107	meu	\N	\N	\N
108	 Cláudia Soares de Souza 	\N	\N	\N
109	sua	\N	\N	\N
110	idade	\N	\N	\N
111	vinte e dois	\N	\N	\N
112	ano	1	A	\N
113	 formação	\N	\N	\N
114	formado	\N	\N	\N
115	 computação	\N	\N	\N
116	algum	\N	\N	\N
117	 língua	\N	\N	\N
118	 francês	\N	\N	\N
119	 nós 	\N	\N	\N
120	precisar	\N	\N	\N
121	 alguém 	\N	\N	\N
122	com	\N	\N	\N
123	 domínio 	\N	\N	\N
124	 inglês 	\N	\N	\N
125	pedir	\N	\N	\N
126	desculpa	\N	\N	\N
127	pois	\N	\N	\N
128	ontem	1	O	\N
129	não	1	N	\N
130	problema	\N	\N	\N
131	casa	1	C	\N
132	algo	\N	\N	\N
133	sério	\N	\N	\N
134	ficar	\N	\N	\N
135	doente	\N	\N	\N
136	levar	\N	\N	\N
137	médico	1	M	\N
138	ela	1	E	\N
139	já	1	J	\N
140	melhor	\N	\N	\N
141	por	\N	\N	\N
142	isso	\N	\N	\N
143	desculpar	\N	\N	\N
144	da	\N	\N	\N
145	próximo	\N	\N	\N
146	vez	\N	\N	\N
147	se	\N	\N	\N
148	possível	\N	\N	\N
149	telefonar	\N	\N	\N
150	avisar	\N	\N	\N
151	 Márcia 	\N	\N	\N
152	 me 	\N	\N	\N
153	ajudar	\N	\N	\N
154	 quê 	\N	\N	\N
155	 aniversário 	\N	\N	\N
156	para	\N	\N	\N
157	 Cláudia 	\N	\N	\N
158	roupa	1	R	\N
159	bijuteria	\N	\N	\N
160	livro	1	L	\N
161	CD	\N	\N	\N
162	opinião	\N	\N	\N
163	mulher	1	M	\N
164	ganhar	\N	\N	\N
165	ou	\N	\N	\N
166	flor	\N	\N	\N
167	morrer	1	M	\N
168	rápido	1	R	\N
169	por que	\N	\N	\N
170	anel	\N	\N	\N
171	colar	1	C	\N
172	comigo	\N	\N	\N
173	joalheria	\N	\N	\N
174	claro	1	C	\N
175	festa	1	F	\N
176	boa	\N	\N	\N
177	ter que	\N	\N	\N
178	embora	\N	\N	\N
179	ah	\N	\N	\N
180	mais	\N	\N	\N
181	pouco	1	P	\N
182	nem	\N	\N	\N
183	onze	\N	\N	\N
184	hora	1	H	\N
185	trabalho	1	T	\N
186	centro	\N	\N	\N
187	cidade	\N	\N	\N
188	cedo	\N	\N	\N
189	um 	\N	\N	\N
190	pouco 	\N	\N	\N
191	 já 	\N	\N	\N
192	tarde	1	T	\N
193	dormir	\N	\N	\N
194	galinha	\N	\N	\N
195	 próximo 	\N	\N	\N
196	tempo	1	T	\N
197	quanto	1	Q	\N
198	custar	\N	\N	\N
199	esta	\N	\N	\N
200	camisa	1	C	\N
201	cinqüenta	\N	\N	\N
202	real	\N	\N	\N
203	isto	\N	\N	\N
204	seda	\N	\N	\N
205	encontrar	1	E	\N
206	também	\N	\N	\N
207	numa	\N	\N	\N
208	outro	\N	\N	\N
209	loja	1	L	\N
210	daqui	\N	\N	\N
211	barato	1	B	\N
212	como	\N	\N	\N
213	pelo	\N	\N	\N
214	mesmo	1	M	\N
215	preço	\N	\N	\N
216	quarenta	\N	\N	\N
217	então	1	E	\N
218	trabalhar	1	T	\N
219	 Japão 	\N	\N	\N
220	imaginar	\N	\N	\N
221	 lá 	\N	\N	\N
222	interessante	1	I	\N
223	principalmente	\N	\N	\N
224	Tóquio	\N	\N	\N
225	contar	1	C	\N
226	pequeno	1	P	\N
227	 confortável	\N	\N	\N
228	 alimentação 	\N	\N	\N
229	restaurante	1	R	\N
230	comida	1	C	\N
231	supermercado	\N	\N	\N
232	cansativo	\N	\N	\N
233	menos	\N	\N	\N
234	vinte e cinco	\N	\N	\N
235	 vôo 	\N	\N	\N
236	qualquer	\N	\N	\N
237	 japonês 	\N	\N	\N
238	 atenção 	\N	\N	\N
239	hoje	1	H	\N
240	visitar	\N	\N	\N
241	igreja	\N	\N	\N
242	museu	\N	\N	\N
243	Ouro Preto	\N	\N	\N
244	 programação 	\N	\N	\N
245	 programação	\N	\N	\N
246	primeiro	\N	\N	\N
247	à	\N	\N	\N
248	nove	\N	\N	\N
249	 Museu da Inconfidência 	\N	\N	\N
250	grande	1	G	\N
251	duas	\N	\N	\N
252	 mínimo 	\N	\N	\N
253	 Igreja de São Francisco de Assis 	\N	\N	\N
254	talvez	1	T	\N
255	importante	\N	\N	\N
256	 aí 	\N	\N	\N
257	 almoçar 	\N	\N	\N
258	 à	\N	\N	\N
259	 Igreja do Pilar 	\N	\N	\N
260	sobrar	\N	\N	\N
261	 Museu do Oratório 	\N	\N	\N
262	só	\N	\N	\N
263	continuar	\N	\N	\N
264	amanhã	1	A	\N
265	noite	1	N	\N
266	desejar	\N	\N	\N
267	exatamente	\N	\N	\N
268	especialidade	\N	\N	\N
269	servir	\N	\N	\N
270	massa	\N	\N	\N
271	carne	1	C	\N
272	picanha	\N	\N	\N
273	cupim	\N	\N	\N
274	costela	\N	\N	\N
275	preferer	\N	\N	\N
276	mal	1	M	\N
277	ponto	\N	\N	\N
279	inteiro	\N	\N	\N
280	sair	1	S	\N
281	 ônibus 	\N	\N	\N
282	Mariana	\N	\N	\N
283	aqui	1	A	\N
284	rio	1	R	\N
285	direto	\N	\N	\N
286	 Ouro Preto 	\N	\N	\N
287	chegar	1	C	\N
288	vinte e três e trinta 	\N	\N	\N
289	seis e trinta 	\N	\N	\N
290	conseguir	\N	\N	\N
291	rapidamente	\N	\N	\N
292	parar	\N	\N	\N
293	frente	1	F	\N
294	 rodoviária 	\N	\N	\N
295	demorar	\N	\N	\N
296	 até 	\N	\N	\N
297	cerca	\N	\N	\N
298	 táxi 	\N	\N	\N
299	 só 	\N	\N	\N
300	quinze	\N	\N	\N
301	minuto	\N	\N	\N
302	 endereço 	\N	\N	\N
303	esperar	\N	\N	\N
304	agenda	\N	\N	\N
305	morar	1	M	\N
306	 Avenida Rio Branco 	\N	\N	\N
307	 número 	\N	\N	\N
308	 prédio 	\N	\N	\N
309	quinhentos e doze	\N	\N	\N
310	 apartamento 	\N	\N	\N
311	setecentos e três	\N	\N	\N
312	um, meia, dois	\N	\N	\N
313	esse	\N	\N	\N
314	volta	\N	\N	\N
315	dois, sete, quatro	\N	\N	\N
316	telefone	1	T	\N
317	dela	\N	\N	\N
318	caso	\N	\N	\N
319	perder	\N	\N	\N
320	dois, dois, dois, um, setenta, vinte	\N	\N	\N
321	caipirinha	\N	\N	\N
322	reunir	\N	\N	\N
323	ingrediente	\N	\N	\N
324	 cachaça 	\N	\N	\N
325	 água 	\N	\N	\N
326	gelo	\N	\N	\N
327	 limão 	\N	\N	\N
328	 açúcar 	\N	\N	\N
329	cortar	1	C	\N
330	oito	\N	\N	\N
331	 pedaço 	\N	\N	\N
332	pôr	1	P	\N
333	num	\N	\N	\N
334	copo	1	C	\N
335	socar	\N	\N	\N
336	 pilão 	\N	\N	\N
337	acrescentar	\N	\N	\N
338	 de+água 	\N	\N	\N
339	picado	\N	\N	\N
340	 balançar	\N	\N	\N
341	passar	\N	\N	\N
342	limpo	\N	\N	\N
343	decorar	\N	\N	\N
344	rodela	\N	\N	\N
345	 anúncio 	\N	\N	\N
346	empregada	\N	\N	\N
347	cozinhar	\N	\N	\N
348	lavar	1	L	\N
349	 também 	\N	\N	\N
350	compra	1	C	\N
351	ora	\N	\N	\N
352	simples	\N	\N	\N
353	contratar	\N	\N	\N
354	 período 	\N	\N	\N
355	 experiência 	\N	\N	\N
356	trinta	\N	\N	\N
357	favor	\N	\N	\N
358	nacional	\N	\N	\N
359	complicado	\N	\N	\N
360	tentar	\N	\N	\N
361	explicar	\N	\N	\N
362	nota	\N	\N	\N
363	virar	1	V	\N
364	direita	1	D	\N
365	segundo	\N	\N	\N
366	sinal	\N	\N	\N
367	O.k.	\N	\N	\N
368	seguir	\N	\N	\N
369	todo	1	T	\N
370	 praça 	\N	\N	\N
371	nesta	\N	\N	\N
372	entrar	\N	\N	\N
373	rua	1	R	\N
374	 à 	\N	\N	\N
375	esquerda	1	E	\N
376	dobrar	\N	\N	\N
377	terceiro	\N	\N	\N
378	andar	1	A	\N
379	cem	\N	\N	\N
380	metro	\N	\N	\N
381	porta	1	P	\N
382	Carla	\N	\N	\N
383	arrumar	\N	\N	\N
384	namorado	\N	\N	\N
385	baixo	1	B	\N
386	magro	\N	\N	\N
387	olho	1	O	\N
388	azul	1	A	\N
389	cabelo	\N	\N	\N
390	 encaracolado 	\N	\N	\N
391	castanho	\N	\N	\N
392	comprido	1	C	\N
393	legal	\N	\N	\N
394	achar	\N	\N	\N
395	ainda	1	A	\N
396	nos	\N	\N	\N
397	conhecer	\N	\N	\N
398	tipo	\N	\N	\N
399	pessoa	1	P	\N
400	franco	\N	\N	\N
401	carinhoso	\N	\N	\N
402	atencioso	\N	\N	\N
403	dever	\N	\N	\N
404	 seção 	\N	\N	\N
405	 lá	\N	\N	\N
406	usar	\N	\N	\N
407	vestido	1	V	\N
408	saia	1	S	\N
409	curto	1	C	\N
410	longo	\N	\N	\N
411	depender	\N	\N	\N
412	sofisticado	\N	\N	\N
413	cor	1	C	\N
414	 preferível 	\N	\N	\N
415	escuro	1	E	\N
416	preto	1	P	\N
417	azul-marinho	\N	\N	\N
418	marrom	\N	\N	\N
419	 calçar 	\N	\N	\N
420	 lógico 	\N	\N	\N
421	sapato	\N	\N	\N
422	salto	\N	\N	\N
423	alto	\N	\N	\N
424	meia	\N	\N	\N
425	fino	1	F	\N
426	preferir	\N	\N	\N
427	 ficção 	\N	\N	\N
428	 científico 	\N	\N	\N
429	aventura	\N	\N	\N
430	faroeste	\N	\N	\N
431	policial	1	P	\N
432	terror	\N	\N	\N
433	musical	\N	\N	\N
434	chato	\N	\N	\N
435	\n\t\t\t\t\t\t\t\t Hair\n\t\t\t\t\t\t\t	\N	\N	\N
436	exemplo	\N	\N	\N
437	razão	\N	\N	\N
438	 exceção 	\N	\N	\N
439	desenho	\N	\N	\N
440	animado	1	A	\N
441	\n\t\t\t\t\t\t\t\tshopping center\n\t\t\t\t\t\t\t	\N	\N	\N
442	TV	\N	\N	\N
443	ler	1	L	\N
444	sempre	\N	\N	\N
445	 peça 	\N	\N	\N
446	teatro	\N	\N	\N
447	 difícil 	\N	\N	\N
448	junto	\N	\N	\N
449	nosso	\N	\N	\N
450	gosto	\N	\N	\N
451	combinar	\N	\N	\N
452	sacar	\N	\N	\N
453	dinheiro	1	D	\N
454	 automático 	\N	\N	\N
455	inserir	\N	\N	\N
456	 cartão 	\N	\N	\N
457	digitar	\N	\N	\N
458	senha	\N	\N	\N
459	cuidado	\N	\N	\N
460	 ninguém 	\N	\N	\N
461	 número	\N	\N	\N
462	valor	\N	\N	\N
463	retirar	\N	\N	\N
464	apertar	1	A	\N
465	tecla	\N	\N	\N
466	confirmar	\N	\N	\N
467	 operação 	\N	\N	\N
468	devolver	1	D	\N
469	 seguida 	\N	\N	\N
470	imprimir	\N	\N	\N
471	soltar	\N	\N	\N
472	extrato	\N	\N	\N
473	 bancário 	\N	\N	\N
474	 além 	\N	\N	\N
475	 família 	\N	\N	\N
476	 mãe 	\N	\N	\N
477	 saúde 	\N	\N	\N
478	mil	\N	\N	\N
479	exame	\N	\N	\N
480	acompanhamento	\N	\N	\N
481	 médico 	\N	\N	\N
482	 sistemático 	\N	\N	\N
483	 médico	\N	\N	\N
484	conversar	\N	\N	\N
485	 convencer+o 	\N	\N	\N
486	deixar	\N	\N	\N
487	consulta	\N	\N	\N
488	presidente	\N	\N	\N
489	 república 	\N	\N	\N
490	antes	\N	\N	\N
491	coisa	\N	\N	\N
492	aumentar	\N	\N	\N
493	 salário 	\N	\N	\N
494	 preço 	\N	\N	\N
495	disparar	\N	\N	\N
496	controlar	\N	\N	\N
497	 inflação 	\N	\N	\N
498	estabelecer	\N	\N	\N
499	limite	\N	\N	\N
500	juro	\N	\N	\N
501	cuidar	\N	\N	\N
502	 educação 	\N	\N	\N
503	acabar	\N	\N	\N
504	analfabetismo	\N	\N	\N
505	construir	\N	\N	\N
506	escola	1	E	\N
507	 salário	\N	\N	\N
508	professor	1	P	\N
509	merenda	\N	\N	\N
510	escolar	\N	\N	\N
511	reforma	\N	\N	\N
512	 agrário 	\N	\N	\N
513	 diferença 	\N	\N	\N
514	entre	\N	\N	\N
515	Brasil	\N	\N	\N
516	maior	\N	\N	\N
517	 país 	\N	\N	\N
518	mundo	\N	\N	\N
519	quinto	\N	\N	\N
520	 América do Sul 	\N	\N	\N
521	jovem	\N	\N	\N
522	sem	\N	\N	\N
523	 dúvida 	\N	\N	\N
524	quinhentos	\N	\N	\N
526	riqueza	\N	\N	\N
527	natural	\N	\N	\N
528	 semelhança 	\N	\N	\N
529	profundo	\N	\N	\N
530	 americanização 	\N	\N	\N
531	desse	\N	\N	\N
532	salvar	\N	\N	\N
533	empresa	1	E	\N
534	fase	\N	\N	\N
535	dizer	1	D	\N
536	proposta	\N	\N	\N
537	propor	\N	\N	\N
538	reaplicar	\N	\N	\N
539	 ação 	\N	\N	\N
540	demitir	\N	\N	\N
541	 funcionário 	\N	\N	\N
542	disto	\N	\N	\N
543	 problemático 	\N	\N	\N
544	 ser	\N	\N	\N
545	imagem	\N	\N	\N
546	 férias 	\N	\N	\N
547	coletivo	\N	\N	\N
548	altenativa	\N	\N	\N
549	apostar	\N	\N	\N
550	publicidade	\N	\N	\N
551	agressivo	\N	\N	\N
552	 feitiço 	\N	\N	\N
553	contra	\N	\N	\N
554	 feiticeiro 	\N	\N	\N
555	promover	\N	\N	\N
556	 liqüidação 	\N	\N	\N
557	parte	\N	\N	\N
558	produto	\N	\N	\N
559	filial	\N	\N	\N
560	novo	1	N	\N
561	\n\t\t\t\t\t\t\t\tshopping \n\t\t\t\t\t\t\t	\N	\N	\N
562	separar	\N	\N	\N
563	dele	\N	\N	\N
564	motivo	\N	\N	\N
565	jeito	\N	\N	\N
566	nunca	\N	\N	\N
567	ocupado	1	O	\N
568	exigente	\N	\N	\N
569	tratar	\N	\N	\N
570	Marta	\N	\N	\N
571	menino	1	M	\N
572	Carlos	\N	\N	\N
573	sete	\N	\N	\N
574	pronto	\N	\N	\N
575	dez	\N	\N	\N
576	brincar	1	B	\N
577	fora	1	F	\N
579	nele	\N	\N	\N
580	levar+o	\N	\N	\N
581	cama	1	C	\N
582	preocupar	\N	\N	\N
583	divertir	\N	\N	\N
584	significar	\N	\N	\N
585	 provérbio 	\N	\N	\N
586	ferreiro	\N	\N	\N
587	espeto	\N	\N	\N
588	pau	\N	\N	\N
589	onde	1	O	\N
590	haver	\N	\N	\N
591	 remédio	\N	\N	\N
592	 língua 	\N	\N	\N
593	 dicionário 	\N	\N	\N
594	surpreendente	\N	\N	\N
595	tal	1	T	\N
596	fato	\N	\N	\N
597	palavra	1	P	\N
598	aquele	1	A	\N
599	fabricar	\N	\N	\N
600	objeto	\N	\N	\N
601	ferro	\N	\N	\N
602	churrasco	\N	\N	\N
603	partido	\N	\N	\N
604	situacionista	\N	\N	\N
605	 tributário 	\N	\N	\N
606	 oposição 	\N	\N	\N
607	concordar	\N	\N	\N
608	 redação 	\N	\N	\N
609	 legislação 	\N	\N	\N
610	proposto	\N	\N	\N
611	alterar	\N	\N	\N
612	texto	\N	\N	\N
613	previsto	\N	\N	\N
614	 latifundiário 	\N	\N	\N
615	pagar	\N	\N	\N
616	imposto	\N	\N	\N
617	percentual	\N	\N	\N
618	justo	\N	\N	\N
619	dez por cento 	\N	\N	\N
620	renda	\N	\N	\N
621	anual	\N	\N	\N
622	 o.k. 	\N	\N	\N
623	conceder	\N	\N	\N
624	 mudança 	\N	\N	\N
625	aceitar	\N	\N	\N
626	votar	\N	\N	\N
627	imediatamente	\N	\N	\N
628	permitir	\N	\N	\N
629	participar	\N	\N	\N
630	final	\N	\N	\N
631	admitir	\N	\N	\N
632	 presença 	\N	\N	\N
633	 estar	\N	\N	\N
634	 combinado 	\N	\N	\N
635	o senhor 	\N	\N	\N
636	carro	1	C	\N
637	quem	1	Q	\N
638	aonde	\N	\N	\N
639	discoteca	\N	\N	\N
640	beber	1	B	\N
641	dirigir	\N	\N	\N
642	voltar	1	V	\N
643	meia-noite	\N	\N	\N
644	senhor 	\N	\N	\N
645	Antônio	\N	\N	\N
646	eu 	\N	\N	\N
647	telefonar 	\N	\N	\N
648	para 	\N	\N	\N
649	Sr.	\N	\N	\N
650	e 	\N	\N	\N
651	ele 	\N	\N	\N
652	poder 	\N	\N	\N
653	vir 	\N	\N	\N
654	 reunião 	\N	\N	\N
655	sim 	\N	\N	\N
656	confirmar 	\N	\N	\N
657	sua 	\N	\N	\N
658	o 	\N	\N	\N
659	 se 	\N	\N	\N
660	 lembrar 	\N	\N	\N
661	 de 	\N	\N	\N
662	ligar 	\N	\N	\N
663	claro 	\N	\N	\N
664	que 	\N	\N	\N
665	ir 	\N	\N	\N
666	saber 	\N	\N	\N
667	a 	\N	\N	\N
668	minha 	\N	\N	\N
669	obrigação 	\N	\N	\N
670	redigir 	\N	\N	\N
671	ata 	\N	\N	\N
672	da 	\N	\N	\N
673	anterior 	\N	\N	\N
674	estar 	\N	\N	\N
675	quase 	\N	\N	\N
676	acabar 	\N	\N	\N
677	seu 	\N	\N	\N
678	logo 	1	L	\N
679	 passar + a	\N	\N	\N
680	corrigir 	\N	\N	\N
681	preparar 	\N	\N	\N
682	pauta 	\N	\N	\N
683	aqui 	\N	\N	\N
684	muito 	\N	\N	\N
685	obrigado 	\N	\N	\N
686	dona	\N	\N	\N
687	Fátima	\N	\N	\N
688	ser 	\N	\N	\N
689	uma 	\N	\N	\N
690	ótimo 	\N	\N	\N
691	 secretária 	\N	\N	\N
692	saia 	\N	\N	\N
693	ter de 	\N	\N	\N
694	cobrir 	\N	\N	\N
695	joelho 	\N	\N	\N
696	mas 	\N	\N	\N
697	comprido 	\N	\N	\N
698	ter de	\N	\N	\N
699	não 	\N	\N	\N
700	pintar 	\N	\N	\N
701	unha 	\N	\N	\N
702	nossa 	\N	\N	\N
703	permitir 	\N	\N	\N
704	usar 	\N	\N	\N
705	maquiagem 	\N	\N	\N
706	 também	\N	\N	\N
707	cabelo 	\N	\N	\N
708	ter que 	\N	\N	\N
709	uniforme 	\N	\N	\N
710	completo 	\N	\N	\N
711	o.k. 	\N	\N	\N
712	 proceder 	\N	\N	\N
713	estudar	\N	\N	\N
714	literatura	\N	\N	\N
715	brasileiro	\N	\N	\N
716	biblioteca	1	B	\N
717	consultar	\N	\N	\N
718	obra	\N	\N	\N
719	referência	\N	\N	\N
720	dicionário	1	D	\N
721	enciclopédia	\N	\N	\N
722	 brasileiro 	\N	\N	\N
723	assunto	\N	\N	\N
724	 amplo 	\N	\N	\N
725	 demais 	\N	\N	\N
726	 fazer 	\N	\N	\N
727	manual	\N	\N	\N
728	 escolher 	\N	\N	\N
729	 estudar 	\N	\N	\N
730	período	\N	\N	\N
731	autor	\N	\N	\N
732	 pouco 	\N	\N	\N
733	 pois 	\N	\N	\N
734	 partir	\N	\N	\N
735	 chegar 	\N	\N	\N
736	senhor	\N	\N	\N
737	passageiro	\N	\N	\N
738	solicitar	\N	\N	\N
739	fumar	\N	\N	\N
740	 durante 	\N	\N	\N
741	vôo	\N	\N	\N
742	nossa	\N	\N	\N
743	 ficar 	\N	\N	\N
744	 fumar 	\N	\N	\N
745	assento	\N	\N	\N
746	 enquanto 	\N	\N	\N
747	luz	\N	\N	\N
748	aceso	\N	\N	\N
749	 demorar 	\N	\N	\N
750	laptop	\N	\N	\N
751	permissão	\N	\N	\N
752	cabina	\N	\N	\N
753	comando	\N	\N	\N
754	 trabalhar 	\N	\N	\N
755	celular	\N	\N	\N
756	ligação	\N	\N	\N
757	 muito 	\N	\N	\N
758	caro	1	C	\N
759	 por 	\N	\N	\N
760	mesa	1	M	\N
761	 costas 	\N	\N	\N
762	decolagem	\N	\N	\N
763	proibição	\N	\N	\N
764	banco	1	B	\N
765	obrigação	\N	\N	\N
766	tua	\N	\N	\N
767	criança	1	C	\N
768	nós	1	N	\N
769	 combinar 	\N	\N	\N
770	mês	\N	\N	\N
771	completamente	\N	\N	\N
772	firma	\N	\N	\N
773	 trocar 	\N	\N	\N
774	 para 	\N	\N	\N
775	 aqui 	\N	\N	\N
776	 cuidar 	\N	\N	\N
777	 brincar 	\N	\N	\N
778	 sério 	\N	\N	\N
779	 convidar 	\N	\N	\N
780	 vir 	\N	\N	\N
781	sábado	1	S	\N
782	 qual 	\N	\N	\N
783	desta	\N	\N	\N
784	 especial 	\N	\N	\N
785	 apenas 	\N	\N	\N
786	 reunir 	\N	\N	\N
787	certeza	\N	\N	\N
788	 pensar 	\N	\N	\N
789	resposta	\N	\N	\N
790	 bom 	\N	\N	\N
791	 comigo 	\N	\N	\N
792	domingo	1	D	\N
793	\n\t\t\t\t\t\t\t\tTom e Jerry\n\t\t\t\t\t\t\t	\N	\N	\N
794	 infantil 	\N	\N	\N
795	gostar de	\N	\N	\N
796	 animado 	\N	\N	\N
797	 MacLaren 	\N	\N	\N
798	interior	\N	\N	\N
799	fazenda	\N	\N	\N
800	conselho	\N	\N	\N
801	verificação	\N	\N	\N
802	 geral 	\N	\N	\N
803	 carro 	\N	\N	\N
804	 assim 	\N	\N	\N
805	 checar 	\N	\N	\N
806	pneu	\N	\N	\N
807	calibrado	\N	\N	\N
808	estepe	\N	\N	\N
809	condição	\N	\N	\N
810	o.k.	\N	\N	\N
811	 necessário 	\N	\N	\N
812	 verificar 	\N	\N	\N
813	óleo	\N	\N	\N
814	trocar+o	\N	\N	\N
815	posto	\N	\N	\N
816	 perto 	\N	\N	\N
817	vidro	\N	\N	\N
818	 conferir 	\N	\N	\N
819	farol	\N	\N	\N
820	farolete	\N	\N	\N
821	seta	\N	\N	\N
822	funcionar	\N	\N	\N
823	 mesmo 	\N	\N	\N
824	 melhor 	\N	\N	\N
825	companhia	\N	\N	\N
826	masculino	\N	\N	\N
827	homem	1	H	\N
828	entender	\N	\N	\N
829	 Sr. 	\N	\N	\N
830	 Carlos 	\N	\N	\N
831	 hoje 	\N	\N	\N
832	 receber 	\N	\N	\N
833	Maria	\N	\N	\N
834	 dinheiro 	\N	\N	\N
835	 Sr.	\N	\N	\N
836	 Carlos	\N	\N	\N
837	 pagamento 	\N	\N	\N
838	 atrasado 	\N	\N	\N
839	 semana 	\N	\N	\N
840	 possível 	\N	\N	\N
841	 esperar 	\N	\N	\N
842	conta	\N	\N	\N
843	 trato 	\N	\N	\N
844	 metade 	\N	\N	\N
845	metade	\N	\N	\N
846	 impossível 	\N	\N	\N
847	 quase 	\N	\N	\N
848	ué	\N	\N	\N
849	 pagar 	\N	\N	\N
857	 agência 	\N	\N	\N
858	casamento	\N	\N	\N
859	viver	\N	\N	\N
860	 sozinho 	\N	\N	\N
861	 arrumar 	\N	\N	\N
862	 companhia 	\N	\N	\N
863	 passar 	\N	\N	\N
864	 minha 	\N	\N	\N
865	 isto 	\N	\N	\N
866	 custar	\N	\N	\N
867	 tentar 	\N	\N	\N
868	 mais 	\N	\N	\N
869	 menos 	\N	\N	\N
870	 idade 	\N	\N	\N
871	 trinta 	\N	\N	\N
872	 ano 	\N	\N	\N
873	 faixa 	\N	\N	\N
874	 etário 	\N	\N	\N
875	 cozinhar 	\N	\N	\N
876	 nunca 	\N	\N	\N
877	 arranjar 	\N	\N	\N
878	 apresentar 	\N	\N	\N
879	 pessoa 	\N	\N	\N
880	 quem	\N	\N	\N
881	fantástico	\N	\N	\N
882	bonito	0	B	\N
883	 inteligente 	\N	\N	\N
884	tornar	\N	\N	\N
885	inglês	1	I	\N
886	avião	1	A	\N
887	país estrangeiro	1	P	\N
888	estrangeiro	1	E	\N
889	francês	1	F	\N
890	hotel	1	H	\N
891	japonês	1	J	\N
892	país 	1	P	\N
893	férias	1	F	\N
894	viajar	1	V	\N
895	embaixada	1	E	\N
896	gostar muito 	1	G	\N
897	correr	1	C	\N
898	devagar	1	D	\N
899	nadar	1	N	\N
901	esporte	1	E	\N
902	não gostar 	0	N	\N
903	piscina	1	P	\N
904	ônibus	1	O	\N
905	bicicleta	1	B	\N
906	cruzamento	1	C	\N
907	lagoa	1	L	\N
908	passeio	1	P	\N
909	táxi	1	T	\N
910	gravata	1	G	\N
911	terno	1	T	\N
912	respirar	1	R	\N
914	cópia	1	C	\N
915	tirar cópia	0	T	\N
916	revista	1	R	\N
918	carne de vaca	1	C	\N
919	fruta	1	F	\N
920	legume	1	L	\N
921	peixe	1	P	\N
922	carne de porco	1	C	\N
924	entregar	1	E	\N
926	chave	1	C	\N
927	cozinha	1	C	\N
928	fazer compras	1	F	\N
929	lavar roupas	1	L	\N
930	limpar	1	L	\N
931	família	1	F	\N
932	jardim	1	J	\N
933	lavagem	1	L	\N
934	limpeza	1	L	\N
935	estante	1	E	\N
936	escrivainha	1	E	\N
937	cadeira	1	C	\N
938	sala	1	S	\N
939	geladeira	1	G	\N
940	rádio	1	R	\N
941	chamar-se	1	C	\N
942	deitar-se	1	D	\N
943	levantar-se	1	L	\N
944	televisão	1	T	\N
945	mapa	1	M	\N
946	lado	1	L	\N
947	posto de polícia	1	P	\N
948	vizinho	1	V	\N
949	perguntar	1	P	\N
950	atrás	1	A	\N
951	sentar-se	1	S	\N
952	classe	1	C	\N
953	sala de aula	1	S	\N
954	corredor	1	C	\N
955	aluno	1	A	\N
956	estudo	1	E	\N
957	estudante	1	E	\N
959	férias de verão	1	F	\N
960	universidade	1	U	\N
961	caderno	1	C	\N
962	aula	1	A	\N
963	redação	1	R	\N
964	lição de casa	1	L	\N
965	difícil	1	D	\N
966	ensinar	1	E	\N
967	prova	1	P	\N
968	exercício	1	E	\N
969	fácil	1	F	\N
970	fazer exercício	1	F	\N
971	pergunta	1	P	\N
972	questão	1	Q	\N
973	responder	1	R	\N
974	doer	1	D	\N
975	dente	1	D	\N
976	hospital	1	H	\N
977	doença	1	D	\N
978	remédio	1	R	\N
979	resfriado	1	R	\N
980	cabeça	1	C	\N
981	barriga	1	B	\N
982	grau	1	G	\N
983	elevador	1	E	\N
984	bilhete	1	B	\N
985	descer	1	D	\N
986	escada	1	E	\N
987	fechar	1	F	\N
988	estação	1	E	\N
993	bebida	1	B	\N
994	café	1	C	\N
995	limão	1	L	\N
996	leite	1	L	\N
997	açúcar	1	A	\N
998	xícara	1	X	\N
999	chá	1	C	\N
1000	chá preto	1	C	\N
1001	doce	1	D	\N
1002	pauzinhos	1	P	\N
1003	bebidas alcoólicas	1	B	\N
1004	delicioso	1	D	\N
1005	faca	1	F	\N
1006	colher	1	C	\N
1007	garfo	1	G	\N
1008	queijo	1	Q	\N
1009	ruim	1	R	\N
1010	pão	1	P	\N
1011	picante	1	P	\N
1012	refeitório	1	R	\N
1013	vinho	1	V	\N
1014	caril	0	C	\N
1015	entrada	1	E	\N
1016	por favor	1	P	\N
1017	com licença	1	C	\N
1019	saída	1	S	\N
1020	caixa de correio	1	C	\N
1021	cartão postal	1	C	\N
1022	envelope	1	E	\N
1023	carta	1	C	\N
1024	correio	1	C	\N
1025	enviar	1	E	\N
1026	selo	1	S	\N
1027	bagagem	1	B	\N
1028	folha	1	F	\N
1029	emprestar	1	E	\N
1030	chapéu	1	C	\N
1031	sapato(s)	1	S	\N
1032	loja de departamentos	1	L	\N
1033	casaco	1	C	\N
1034	calça	1	C	\N
1035	suéter	1	S	\N
1036	bolsa	1	B	\N
1037	vender	1	V	\N
1038	banho	1	B	\N
1039	prédio	1	P	\N
1040	chuveiro	1	C	\N
1041	janela	1	J	\N
1042	parque	1	P	\N
1043	apartamento	1	A	\N
1044	ele	1	E	\N
1046	alguém	1	A	\N
1047	este	1	E	\N
1048	esse	1	E	\N
1050	grosso	1	G	\N
1051	estreito	1	E	\N
1052	largo	1	L	\N
1053	leve	1	L	\N
1054	longe	1	L	\N
1055	pesado	1	P	\N
1056	velho	1	V	\N
1057	divertido	1	D	\N
1058	fraco	1	F	\N
1059	forte	1	F	\N
1061	quieto	1	Q	\N
1062	sujo	1	S	\N
1063	sem graça	0	S	\N
1064	dentro	1	D	\N
1065	leste	1	L	\N
1066	altura	1	A	\N
1067	vertical	1	V	\N
1068	norte	1	N	\N
1069	oeste	1	O	\N
1070	sul	1	S	\N
1071	primo	1	P	\N
1072	irmão	1	I	\N
1073	irmãos	1	I	\N
1074	avó	1	A	\N
1075	avô	1	A	\N
1076	esposa	1	E	\N
1077	mãe	1	M	\N
1078	tio	1	T	\N
1079	pais	1	P	\N
1080	irmã	1	I	\N
1081	irmãs	1	I	\N
1082	tia	1	T	\N
1083	meia(s)	1	M	\N
1084	tirar	1	T	\N
1085	pendurar	1	P	\N
1086	calçar	1	C	\N
1087	vestir	1	V	\N
1088	lenço	1	L	\N
1089	chinelo(s)	0	C	\N
1090	guarda-chuva	1	G	\N
1091	bolso	1	B	\N
1092	carteira	1	C	\N
1093	roupa	0	R	\N
1094	boca	1	B	\N
1095	braço	1	B	\N
1096	corpo	1	C	\N
1097	rosto	1	R	\N
1098	perna	1	P	\N
1099	mão	1	M	\N
1100	nariz	1	N	\N
1101	orelha	1	O	\N
1102	pé	1	P	\N
1103	prato	1	P	\N
1104	manteiga	1	M	\N
1105	tigela	1	T	\N
1106	bala	1	B	\N
1107	almoço	1	A	\N
1108	jantar	1	J	\N
1109	ovo	1	O	\N
1110	café da manhã	1	C	\N
1111	refeição	1	R	\N
1112	molho de soja	1	M	\N
1113	sal	1	S	\N
1114	adicionar	1	A	\N
1115	máquina (fotográfica)	0	M	\N
1116	aquecedor	1	A	\N
1117	lápis	1	L	\N
1118	apagar	1	A	\N
1119	óculos	1	O	\N
1120	gravador de fita cassete	1	G	\N
1121	relógio	1	R	\N
1122	computador	1	C	\N
1123	portão	1	P	\N
1125	caneta-tinteiro	1	C	\N
1126	agosto	1	A	\N
1127	abril	1	A	\N
1128	este mês	1	E	\N
1129	todos os meses	1	T	\N
1130	dezembro	1	D	\N
1131	fevereiro	1	F	\N
1132	janeiro	1	J	\N
1133	julho	1	J	\N
1134	junho	1	J	\N
1136	maio	1	M	\N
1137	março	1	M	\N
1138	mês passado	1	M	\N
1139	novembro	1	N	\N
1140	outubro	1	O	\N
1141	setembro	1	S	\N
1142	um mês	1	U	\N
1143	esta semana	1	E	\N
1144	todas as semanas	1	T	\N
1145	quinta-feira	1	Q	\N
1147	segunda-feira	1	S	\N
1148	terça-feira	1	T	\N
1149	quarta-feira	1	Q	\N
1150	semana passada	1	S	\N
1151	sexta-feira	1	S	\N
1152	outono	1	O	\N
1153	este ano	1	E	\N
1154	todos os anos	1	T	\N
1155	verão	1	V	\N
1156	inverno	1	I	\N
1157	ano passado	1	A	\N
1159	primavera	1	P	\N
1160	daqui a dois anos	1	D	\N
1162	ontem à noite	1	O	\N
1163	manhã	1	M	\N
1164	depois de amanhã	1	D	\N
1165	anteontem	1	A	\N
1166	enquanto	1	E	\N
1168	freqüentemente	1	F	\N
1169	cinzeiro	1	C	\N
1170	canção	1	C	\N
1171	cantar	1	C	\N
1172	cigarro	1	C	\N
1173	disco	1	D	\N
1174	violão	1	V	\N
1175	tocar	1	T	\N
1176	música	1	M	\N
1177	pintura	1	P	\N
1178	foto	1	F	\N
1179	voz	1	V	\N
1180	bom tempo	0	B	\N
1181	quente	1	Q	\N
1182	fazer bom tempo	1	F	\N
1183	fresco	1	F	\N
1184	frio	1	F	\N
1185	neve	1	N	\N
1186	chover	1	C	\N
1187	chuva	1	C	\N
1188	clima	1	C	\N
1190	vento	1	V	\N
1191	tempo nublado	0	T	\N
1193	letra chinesa	0	L	\N
1194	escrever	1	E	\N
1197	língua	1	L	\N
1198	frase	1	F	\N
1199	significado	0	S	\N
1200	adulto	1	A	\N
1202	casal	1	C	\N
1203	menina	1	M	\N
1204	marido	1	M	\N
1205	todo mundo	1	T	\N
1206	branco	1	B	\N
1207	marrom	1	M	\N
1208	amarelo	1	A	\N
1209	vermelho	1	V	\N
1210	verde	1	V	\N
1211	conveniência	1	C	\N
1212	papel	1	P	\N
1213	tornar-se	1	T	\N
1214	empurrar	1	E	\N
1215	começar	1	C	\N
1216	não ter	1	T	\N
1217	reto	1	R	\N
1218	famoso	1	F	\N
1219	estar bem	1	E	\N
1221	embaixo	1	E	\N
1222	estudante estrangeiro	1	E	\N
1223	frango	1	F	\N
1224	sandália(s)	1	S	\N
1225	ano retrasado	1	A	\N
1226	pegar emprestado	1	P	\N
1227	carateres chineses	0	C	\N
1228	quitanda	1	Q	\N
1229	mau	1	M	\N
1230	muitas pessoas	1	M	\N
1231	ficar nublado	1	F	\N
1232	semana que vem	1	S	\N
1233	ano que vem	1	A	\N
1234	mês que vem	1	M	\N
1235	pular	1	P	\N
1236	às vezes	1	A	\N
1237	câmera	1	C	0
1238	céu limpo	1	C	0
1239	céu nublado	1	C	0
1240	ideograma	1	I	0
1241	sentido	1	S	0
900	saltar	0	S	\N
913	levar emprestado	0	E	\N
917	volume	0	V	\N
923	carne de frango	0	C	\N
925	loja de verduras	0	L	\N
958	bolsista	0	B	\N
1018	por favor	0	F	\N
1045	eles	0	E	\N
1049	próprio	0	P	\N
1060	bastante	0	B	\N
578	colocar	0	C	\N
278	meio	\N	\N	\N
1	bom	1	B	\N
2	dia	1	D	\N
3	Cláudia	\N	A	\N
4	como 	1	C	\N
5	ir	1	I	\N
6	você	1	V	\N
7	Paulo	\N	H	\N
8	tudo	\N	J	\N
9	bem	1	B	\N
10	e	\N	P	\N
11	 você 	\N	E	\N
12	ter	\N	F	\N
13	compromisso	\N	V	\N
14	no	\N	V	\N
15	fim	\N	B	\N
16	de	\N	E	\N
17	semana	1	S	\N
18	 não 	\N	G	\N
19	por quê	\N	H	\N
20	porque	\N	C	\N
21	eu	1	E	\N
22	querer	1	Q	\N
23	ao	\N	A	\N
24	cinema	\N	N	\N
25	sim	1	S	\N
26	qual	1	Q	\N
27	ser	\N	D	\N
28	o	\N	D	\N
29	filme	1	F	\N
30	saber	\N	A	\N
31	escolher	\N	B	\N
32	olhar	\N	C	\N
33	jornal	1	J	\N
34	depois	1	D	\N
35	te	\N	P	\N
36	falar	1	F	\N
37	 então 	\N	T	\N
38	me	\N	C	\N
39	ligar	\N	V	\N
40	quando	1	Q	\N
41	 amanhã 	\N	C	\N
42	 manhã 	\N	E	\N
43	poder	\N	C	\N
44	convidar	\N	F	\N
45	um	\N	R	\N
46	amigo	1	A	\N
47	oi	\N	T	\N
48	que	1	Q	\N
525	 existência 	\N	\N	\N
850	exigir	\N	\N	\N
851	 quanto 	\N	\N	\N
852	 antes 	\N	\N	\N
853	 agora 	\N	\N	\N
854	 banco 	\N	\N	\N
855	 empréstimo 	\N	\N	\N
856	aí	1	A	\N
989	metrô	1	M	\N
990	embarcar	1	E	\N
991	banheiro	1	B	\N
992	trem	1	T	\N
1124	caneta	1	C	\N
1135	próximo mês	0	P	\N
1146	próxima semana	0	P	\N
1158	próximo ano	0	P	\N
1161	dois anos atrás	0	D	\N
1167	às vezes	0	V	\N
1189	mole	0	M	\N
1192	nublar-se	0	N	\N
1195	fala	0	F	\N
1196	linguagem	0	L	\N
1201	multidão	0	M	\N
1220	elas	0	E	\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: pb
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, ptoken, inst_id) FROM stdin;
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: pb
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

