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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO pt;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO pt;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO pt;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: pt
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


ALTER TABLE public.t_instance OWNER TO pt;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO pt;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO pt;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: pt
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


ALTER TABLE public.t_usage_classified_rel OWNER TO pt;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: pt
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


ALTER TABLE public.t_usage_inst_rel OWNER TO pt;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO pt;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO pt;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO pt;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: pt
--

CREATE TABLE t_word_inst_rel (
    word_id integer NOT NULL,
    token text NOT NULL,
    sense text,
    pos text,
    cform text,
    reading text,
    pronunciation text,
    inst_id integer NOT NULL,
    ptoken text
);


ALTER TABLE public.t_word_inst_rel OWNER TO pt;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: pt
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO pt;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: pt
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO pt;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: pt
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_index_char (id, index_char) FROM stdin;
1	A
2	B
3	B・V
4	C
5	D
6	E
7	F
8	G
9	H
10	I
11	J
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
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
1	Vou a Portugal	私はポルトガルへ行く。	\N		\N	vmod	\N	\N	\N	0	1
5	Hoje em dia vivem  muitos estrangeiros no Japão.	こんにち、日本にはたくさんの外国人が住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
6	Ele fala muito bem português.	彼はとても上手にポルトガル語を話す。	\N		\N	vmod	\N	\N	\N	0	1
7	Tenho que reservar o hotel.	私はホテルを予約しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
8	Aprender japonês é mais difícil do que outras línguas.	日本語を学ぶのは、他の言語（を学ぶ）より難しい。	\N		\N	vmod	\N	\N	\N	0	1
10	Portugal é o país da saudade.	ポルトガルはサウダーデの国だ。	\N		\N	vmod	\N	\N	\N	0	1
11	Nunca encontrei ninguém conhecido no metro.	地下鉄の中で知っている人に会うことは全くなかった。	\N		\N	vmod	\N	\N	\N	0	1
12	As férias de Páscoa estão à porta.	パスコアの休みはもうすぐだ。	\N		\N	vmod	\N	\N	\N	0	1
13	Boa viagem!	良い旅を！	\N		\N	vmod	\N	\N	\N	0	1
14	Um dia será possível viajar até à Lua.	いつの日か月まで旅行することが可能になるだろう。	\N		\N	vmod	\N	\N	\N	0	1
15	Os meninos brincavam ao esconde-esconde.	男の子達はかくれんぼをして遊んでいた。	\N		\N	vmod	\N	\N	\N	0	1
16	Onde fica a Embaixada do Japão?	日本国大使館はどこですか？	\N		\N	vmod	\N	\N	\N	0	1
17	Gosto muito de jogar futebol.	私はサッカーをするのが大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
18	Ele gosta de ver os jogos na televisão.	彼はテレビでスポーツ観戦するのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
19	Ela é habil a manejar o arco e a flecha.	彼女は弓と矢を操るのが上手だ。	\N		\N	vmod	\N	\N	\N	0	1
20	Ｏ meu filho corre mais rápido do que outros na minha família.	私の息子は家族の中で一番速く走る。	\N		\N	vmod	\N	\N	\N	0	1
21	Ele anda devagar.	彼はゆっくりと歩く。	\N		\N	vmod	\N	\N	\N	0	1
22	Revelou-se inábil na condução do negócio.	（彼は）商売下手であることがわかった。	\N		\N	vmod	\N	\N	\N	0	1
23	Tens que andar mais rápido	もっと早く歩かなくちゃいけないよ。	\N		\N	vmod	\N	\N	\N	0	1
24	Ela sabe nadar.	彼女は泳げる。	\N		\N	vmod	\N	\N	\N	0	1
25	Ele corre mais rápido do que eu.	彼は僕よりも早く走る。	\N		\N	vmod	\N	\N	\N	0	1
26	As aves voam.	鳥は（空を）飛ぶ。	\N		\N	vmod	\N	\N	\N	0	1
27	Gosto de todos os tipos de desporto.	私はスポーツ全般が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
28	Detesto aqueles que digam mentiras.	私は嘘をつくような人は嫌いだ。	\N		\N	vmod	\N	\N	\N	0	1
29	Ele nada todos os dias na piscina.	彼は毎日プールで泳ぐ。	\N		\N	vmod	\N	\N	\N	0	1
30	Tenho que apanhar o autocarro para ir ao centro da cidade.	市街地に行くのに、（私は）バスに乗らなければならない。	\N		\N	vmod	\N	\N	\N	0	1
31	Se quiseres, emprestar-te-ei a minha bicicleta.	よかったら君に僕の自転車を貸すよ。	\N		\N	vmod	\N	\N	\N	0	1
32	Naquele cruzamento, acontecem muitos acidentes.	あの交差点では、事故がよく起こる。	\N		\N	vmod	\N	\N	\N	0	1
33	Perguntei pelo nome da rua.	私は道の名前を尋ねた。	\N		\N	vmod	\N	\N	\N	0	1
34	As lagoas da Serra da Estrela são muito bonitas.	エストレーラ山脈の湖（たち）はとても美しい。	\N		\N	vmod	\N	\N	\N	0	1
35	As mães levaram as crianças a dar um passeio.	母親達は、子供達を散歩に連れ出した。	\N		\N	vmod	\N	\N	\N	0	1
36	O Tejo é o maior rio em Portugal.	テージョ河はポルトガルで一番大きな河だ。	\N		\N	vmod	\N	\N	\N	0	1
37	Apanhe um táxi.	タクシーをつかまえなよ。	\N		\N	vmod	\N	\N	\N	0	1
38	Vou de carro.	私は（自動）車で行く。	\N		\N	vmod	\N	\N	\N	0	1
39	Vire à direita na próxima esquina, faz favor.	次の曲がり角を右に曲がって下さい。	\N		\N	vmod	\N	\N	\N	0	1
40	Esta gravata fica muito bem contigo..	このネクタイは君に良く似合う。	\N		\N	vmod	\N	\N	\N	0	1
41	Muitos empregados no escritório vestem a camisa branca.	事務所の職員の多くは、白いワイシャツを着ている。	\N		\N	vmod	\N	\N	\N	0	1
42	O governo apóia a criação de novas empresas.	政府は新しい会社の設立を支持している。	\N		\N	vmod	\N	\N	\N	0	1
43	Este casaco fica bem contigo.	この背広は、君に似合っているよ。	\N		\N	vmod	\N	\N	\N	0	1
44	Faça o que quiser.	好きなことをおやりください。	\N		\N	vmod	\N	\N	\N	0	1
45	Queria respirar o ar puro.	新鮮な空気を吸いたいな。	\N		\N	vmod	\N	\N	\N	0	1
46	O telefone tocou cinco vezes mas ninguém atendeu.	電話は５回鳴ったが、誰も出なかった。	\N		\N	vmod	\N	\N	\N	0	1
47	O trabalho e lazer, ambos são importantes para as pessoas.	仕事と余暇はともに人間にとって大切である。	\N		\N	vmod	\N	\N	\N	0	1
48	Ela trabalha aqui há cinco anos.	彼女はここで５年間働いている。	\N		\N	vmod	\N	\N	\N	0	1
49	Ele é um homem sempre ocupado.	彼はいつも忙しい人間（男）だ。	\N		\N	vmod	\N	\N	\N	0	1
50	A biblioteca está fechada nas segundas-feiras.	図書館は月曜日閉館だ。	\N		\N	vmod	\N	\N	\N	0	1
51	Ele consultou vários dicionários de língua portuguesa.	彼は様々なポルトガル語の辞書にあたった。	\N		\N	vmod	\N	\N	\N	0	1
52	Ele pediu-me dinheiro emprestado.	彼は私に金を貸してくれと頼んだ。	\N		\N	vmod	\N	\N	\N	0	1
53	O único jornal que comprava era um jornal de futebol.	（私・彼・彼女が）買っていた唯一の新聞は、サッカー新聞であった。	\N		\N	vmod	\N	\N	\N	0	1
54	Ontem li um artigo sobre esse tema.	私は昨日このテーマについて記事を読んだ。	\N		\N	vmod	\N	\N	\N	0	1
55	Ele tem muitos livros.	彼は本をたくさん持っている。	\N		\N	vmod	\N	\N	\N	0	1
56	As fotocópias a cores são mais caras.	カラーコピーはより高い。	\N		\N	vmod	\N	\N	\N	0	1
57	Mandou-me tirar duas fotocópias do relatório.	（彼・彼女は）私にレポートのコピーを2枚取るように命じた。	\N		\N	vmod	\N	\N	\N	0	1
58	Esta revista sai todos os meses.	この雑誌は毎月出る（月刊だ）。	\N		\N	vmod	\N	\N	\N	0	1
59	Um volume de versos.	1冊の詩（の本）。	\N		\N	vmod	\N	\N	\N	0	1
60	Os híndus não comem carne de vaca.	ヒンドゥー教徒は、牛肉を食べない。	\N		\N	vmod	\N	\N	\N	0	1
61	O mito da energia nuclear ser mais económica já totalmente se destruiu há muito tempo.	原子力発電が安いという神話は、もうずいぶん前に崩れた。	\N		\N	vmod	\N	\N	\N	0	1
62	Esta loja está fechada nos domingos.	この店は日曜は閉まっている。	\N		\N	vmod	\N	\N	\N	0	1
63	Que caro!	高いねえ！	\N		\N	vmod	\N	\N	\N	0	1
64	Quantas é que o senhor queria?	おいくつお望みですか？（いくつ欲しいですか？）	\N		\N	vmod	\N	\N	\N	0	1
65	Quanto custa?	いくらですか？	\N		\N	vmod	\N	\N	\N	0	1
66	A maçã é uma fruta que eu gosto.	リンゴは私が好きな果物だ（好物だ）。	\N		\N	vmod	\N	\N	\N	0	1
67	Tens que comer mais legumes.	（君は）もっと野菜を食べなければならないよ。	\N		\N	vmod	\N	\N	\N	0	1
68	Prefiro peixe a carne.	私は肉よりも魚が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
69	Os judeus e os muçulmanos não comem carne de porco.	ユダヤ人とイスラム人は、豚肉を食べない。	\N		\N	vmod	\N	\N	\N	0	1
70	O almoço foi frango assado com batatas fritas.	昼食は、グリルドチキンとフライドポテトだった。	\N		\N	vmod	\N	\N	\N	0	1
71	Ele é vegetariano, por isso não come carne.	彼は菜食主義者だから肉を食べない。	\N		\N	vmod	\N	\N	\N	0	1
72	Queria um café.	コーヒーを一杯下さい。	\N		\N	vmod	\N	\N	\N	0	1
73	Já lhe entregaste o livro ?	（君は）もう彼に本を渡したかい？	\N		\N	vmod	\N	\N	\N	0	1
74	Naquele tempo, ao longo da rua abriam-se as quitandas às portas.	あの頃は、通りに沿って八百屋が店を広げていたものだ。	\N		\N	vmod	\N	\N	\N	0	1
75	Esta chave é tua?	この鍵は君の？	\N		\N	vmod	\N	\N	\N	0	1
76	Gosto muito de cozinha portuguesa.	私はポルトガル料理が大好きです。	\N		\N	vmod	\N	\N	\N	0	1
77	Tenho que comprar as prendas do Natal.	（私は）クリスマスのプレゼントを買わなきゃ。	\N		\N	vmod	\N	\N	\N	0	1
78	A empregada lava as minhas roupas.	女中が私の服を洗濯する。	\N		\N	vmod	\N	\N	\N	0	1
79	Minha mãe limpa a casa todos os dias.	（私の）母は、毎日家を掃除する。	\N		\N	vmod	\N	\N	\N	0	1
80	Minha família é de cinco pessoas.	私の家族は5人です。	\N		\N	vmod	\N	\N	\N	0	1
81	Ele queria ter um lar.	彼は家庭を持ちたがっている。	\N		\N	vmod	\N	\N	\N	0	1
82	Atrás da minha casa, havia uns cavalos.	私の家の裏には、（昔）馬が居た。	\N		\N	vmod	\N	\N	\N	0	1
83	Aconselha-se a lavagem a seco de tecidos delicados.	デリケート素材につき、ドライクリーニングをお勧めします。	\N		\N	vmod	\N	\N	\N	0	1
84	Vamos para casa.	家へ行こう（帰ろう）。	\N		\N	vmod	\N	\N	\N	0	1
85	Esta casa foi construída há cem anos.	この家は、100年前に建てられました。	\N		\N	vmod	\N	\N	\N	0	1
86	Não gosto de fazer limpeza.	私は掃除が好きではない。	\N		\N	vmod	\N	\N	\N	0	1
87	Voltou à aldeia passados quinze anos.	（彼・彼女は）15年ぶりに村に帰ってきた。	\N		\N	vmod	\N	\N	\N	0	1
88	Ele tirou um livro da estante e começou a ler.	彼は本棚から本を取り、読み始めた。	\N		\N	vmod	\N	\N	\N	0	1
89	Passe-me o livro que está em cima da mesa.	テーブルの上の本を取って下さい。	\N		\N	vmod	\N	\N	\N	0	1
90	Senta-te nesta cadeira.	この椅子に座って。	\N		\N	vmod	\N	\N	\N	0	1
91	Prefiro ficar sozinha no meu quarto.	私は自分の部屋に一人で居るほうがいい。	\N		\N	vmod	\N	\N	\N	0	1
92	Há sumo de maçã no frigorífico.	冷蔵庫の中にりんごジュースがある。	\N		\N	vmod	\N	\N	\N	0	1
93	Já lavei os dentes.	私はもう歯を磨いた（洗った）。	\N		\N	vmod	\N	\N	\N	0	1
94	Estou com sono. Vou para a cama.	（私は）眠い、ベッドに行きます（寝ます）。	\N		\N	vmod	\N	\N	\N	0	1
95	O rádio é uma companhia agradável enquanto estudo.	勉強している間は、ラジオが心地よい（同伴者だ）。	\N		\N	vmod	\N	\N	\N	0	1
96	O professor sempre trouxe o rádio-cassete para a aula.	先生はいつもラジカセを授業に持ってきていた。	\N		\N	vmod	\N	\N	\N	0	1
97	Chamo-me Fernando de Castro.	私はフェルナンド・デ・カストロといいます。	\N		\N	vmod	\N	\N	\N	0	1
98	Eu durmo oito horas todos os dias.	私は毎日8時間寝る。	\N		\N	vmod	\N	\N	\N	0	1
99	Acordo às sete todas as manhãs.	私は毎朝7時に起きる。	\N		\N	vmod	\N	\N	\N	0	1
100	Passe-me o sal que está na mesa.	テーブルにある塩を取って下さい。	\N		\N	vmod	\N	\N	\N	0	1
101	Ele comprou uma televisão e um vídeo.	彼はテレビとビデオを買った。	\N		\N	vmod	\N	\N	\N	0	1
102	É melhor perguntar ao polícia	お巡りさんに聞いた方がいいですよ。	\N		\N	vmod	\N	\N	\N	0	1
103	O polícia prendeu os suspeitos.	警官は容疑者達を逮捕した。	\N		\N	vmod	\N	\N	\N	0	1
104	Você tem o mapa de Lisboa?	あなたはリスボンの地図を持っていますか？	\N		\N	vmod	\N	\N	\N	0	1
105	A escola fica perto da minha casa.	学校は私の家の近くにある。	\N		\N	vmod	\N	\N	\N	0	1
106	O autocarro não passa por aqui.	バスはここを通りません。	\N		\N	vmod	\N	\N	\N	0	1
107	Ele foi ao estrangeiro e aí  ficou para sempre.	彼は外国に行き、そこに居着いてしまった（ずっとそこに居た）。	\N		\N	vmod	\N	\N	\N	0	1
108	Vi uma ponte e fui por ali.	私は橋を見て、その辺りに行った。	\N		\N	vmod	\N	\N	\N	0	1
109	Desculpe, onde fica a casa de banho?	すみません、トイレはどこですか？	\N		\N	vmod	\N	\N	\N	0	1
110	Com licença, tem o posto policial perto daqui?	すみません、この近くに交番はありますか？	\N		\N	vmod	\N	\N	\N	0	1
111	Estas duas cadeiras estão demasiado próximas.	この二つの椅子は、(互いに）近くに寄りすぎている。	\N		\N	vmod	\N	\N	\N	0	1
112	A casa dele é contígua à minha.	彼の家は、私の家の隣りだ。	\N		\N	vmod	\N	\N	\N	0	1
113	Ele perguntou-me pelo caminho para o aeroporto.　	彼は私に空港までの道を尋ねた。	\N		\N	vmod	\N	\N	\N	0	1
114	Queria cortar o cabelo.	（私は）髪を切りたい。	\N		\N	vmod	\N	\N	\N	0	1
115	Ele tem o cabelo curto.	彼は短髪だ（短い髪を持っている）。	\N		\N	vmod	\N	\N	\N	0	1
116	O marido vai na frente e ela atrás.	夫が前を行き、彼女は後ろを行く。	\N		\N	vmod	\N	\N	\N	0	1
117	Vamos encontrar-nos em frente da estação.	〔我々は）駅の前で会おう。	\N		\N	vmod	\N	\N	\N	0	1
118	Só consigo escrever com a mão direita.	私は右手でしか書けません。	\N		\N	vmod	\N	\N	\N	0	1
119	Vire na segunda esquina à esquerda	次の角を左に曲がって下さい。	\N		\N	vmod	\N	\N	\N	0	1
120	Ela tem o cabelo comprido.	彼女は長髪だ(長い髪を持っている）。	\N		\N	vmod	\N	\N	\N	0	1
121	Sente-se, por favor.	どうぞお座り下さい。	\N		\N	vmod	\N	\N	\N	0	1
122	Eles levantaram-se.	彼らは立ち上がった。	\N		\N	vmod	\N	\N	\N	0	1
123	Ele é bom e velho amigo.	彼は古き良き友だ。	\N		\N	vmod	\N	\N	\N	0	1
124	Nesta escola há cinco turmas do quinto ano.	この学校の5学年は、5クラスある。	\N		\N	vmod	\N	\N	\N	0	1
125	Todos os estudantes já entraram na sala.	生徒たちはすでに全員教室に入った。	\N		\N	vmod	\N	\N	\N	0	1
126	Os meninos corriam, saltavam e brincavam no corredor da escola.	子供達は、学校の廊下で走ったり、飛び跳ねたり、遊んだりしていた。	\N		\N	vmod	\N	\N	\N	0	1
127	Ele anda naquela escola desde os seis anos.	彼はあの学校に6才から通っている。	\N		\N	vmod	\N	\N	\N	0	1
128	Ele é bom aluno.	彼は良い生徒だ。	\N		\N	vmod	\N	\N	\N	0	1
129	Tenho que dedicar-me ao estudo.	(私は）勉強に身を入れなければならない。	\N		\N	vmod	\N	\N	\N	0	1
130	Houve uma manifestação de estudantes em frente do Ministério da Educação.	教育省の前で、学生のデモがあった。	\N		\N	vmod	\N	\N	\N	0	1
131	Na minha universidade há muitos estudantes estrangeiros.	私の大学には、多くの留学生が居います。	\N		\N	vmod	\N	\N	\N	0	1
132	Muitos estudantes regressam à terra natal nas férias de verão.	多くの学生が、夏休みには故郷に帰る。	\N		\N	vmod	\N	\N	\N	0	1
133	Ela aprendeu canto com um professor muito famoso.	彼女は、とても有名な先生について声楽を学んだ。	\N		\N	vmod	\N	\N	\N	0	1
134	Frequento a universidade todos os dias.	私は毎日大学へ通う。	\N		\N	vmod	\N	\N	\N	0	1
135	Deixei o caderno na sala de aula.	（私は）ノートを教室に忘れてきてしまった（置いてきてしまった）。	\N		\N	vmod	\N	\N	\N	0	1
136	Ele faltou à aula ontem.	彼は昨日授業を欠席した。	\N		\N	vmod	\N	\N	\N	0	1
137	O trabalho de casa foi uma composição de tema livre.	宿題は、自由テーマの作文だった。	\N		\N	vmod	\N	\N	\N	0	1
138	Ontem o professor deu aos alunos muitos trabalhos de casa.	昨日先生は生徒達にたくさんの宿題を出した。	\N		\N	vmod	\N	\N	\N	0	1
139	É bastante difícil para ele falar em público.	彼にとって人前で話すのはかなり難しい。	\N		\N	vmod	\N	\N	\N	0	1
140	O professor ensina e os alunos aprendem.	先生は教え、生徒達は学ぶ。	\N		\N	vmod	\N	\N	\N	0	1
141	Temos que fazer exame para entrar na universidade.	（我々は）大学にはいるためには試験を受けねばならない。	\N		\N	vmod	\N	\N	\N	0	1
142	Tenho que ｆazer prática.	私は練習しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
143	O exame foi fácil.	試験は易しかった。	\N		\N	vmod	\N	\N	\N	0	1
144	Ela pratica piano  todos os dias.	彼女は毎日ピアノを練習する。	\N		\N	vmod	\N	\N	\N	0	1
145	Poderia fazer uma pergunta?	質問していいですか？	\N		\N	vmod	\N	\N	\N	0	1
146	Pôs-lhe uma questão tão estranha que ela hesitou antes de responder.	とても変な質問だったので、彼女は答えるのに躊躇した。	\N		\N	vmod	\N	\N	\N	0	1
147	O menino respondeu-lhe que não tinha estudado a lição.	その子は学課を勉強してこなかったと答えた。	\N		\N	vmod	\N	\N	\N	0	1
148	Dói-me a cabeça.	（私は）頭痛がする。	\N		\N	vmod	\N	\N	\N	0	1
149	Um adulto tem trinta e dois dentes.	大人は32本の歯を持つ。	\N		\N	vmod	\N	\N	\N	0	1
150	É melhor consultar o médico.	医者にかかった方が良い。	\N		\N	vmod	\N	\N	\N	0	1
151	Meu avô foi internado no hospital.	私の祖父は（病院に）入院した。	\N		\N	vmod	\N	\N	\N	0	1
152	Ele apanhou uma doença grave.	彼は重い病気にかかった。	\N		\N	vmod	\N	\N	\N	0	1
153	A enfermeira receitou-me um remédio.	看護婦が私に薬を処方した。	\N		\N	vmod	\N	\N	\N	0	1
154	Queria morrer pela pátria.	私は祖国のために死にたい。	\N		\N	vmod	\N	\N	\N	0	1
155	Apanhei uma constipação forte neste inverno.	私は今年の冬、ひどい風邪を引いた。	\N		\N	vmod	\N	\N	\N	0	1
156	Estou com dor de cabeça.	（私は）頭が痛い（頭痛がする）。	\N		\N	vmod	\N	\N	\N	0	1
157	Tenho dor de barriga.	(私は）おなかが痛い。	\N		\N	vmod	\N	\N	\N	0	1
158	A criança está  com quarenta graus de febre.	その子供は40度の熱がある。	\N		\N	vmod	\N	\N	\N	0	1
159	Eu subi ao quinto andar num elevador.	(私は）エレベーターで4階に上がる。※ポルトガルでの1階(primeiro andar)は、日本の2階。	\N		\N	vmod	\N	\N	\N	0	1
160	Os bilhetes para o concerto esgotaram-se rapidamente.	コンサートの切符（チケット）は、瞬く間に売り切れてしまった。	\N		\N	vmod	\N	\N	\N	0	1
162	Tivemos de subir até ao quinto andar pela escada, já que o elevador estava avariado.	エレベーターが壊れていたので、6階まで階段で昇らねばならなかった。※ポルトガルでの5階は、日本の6階。	\N		\N	vmod	\N	\N	\N	0	1
163	Não se importa de fechar a porta?	恐れ入りますがドアを閉めて頂けますか？	\N		\N	vmod	\N	\N	\N	0	1
164	Este comboio pára em todas as estações.	この電車は全ての駅に停まります。	\N		\N	vmod	\N	\N	\N	0	1
165	A fábrica está em greve.	工場はストライキ中だ。	\N		\N	vmod	\N	\N	\N	0	1
166	Vamos correr para apanhar aquele autocarro.	あのバスに乗るために走ろう。	\N		\N	vmod	\N	\N	\N	0	1
167	O guarda abriu o portão com a sua chave.	守衛はその鍵で門を開けた。	\N		\N	vmod	\N	\N	\N	0	1
168	Onde fica a casa de banho?	お手洗いはどこですか？	\N		\N	vmod	\N	\N	\N	0	1
169	Eu queria ir à casa de banho.	（私は）トイレに行きたいのですが。	\N		\N	vmod	\N	\N	\N	0	1
170	Para onde vai este comboio?	この電車はどこに行くのですか？	\N		\N	vmod	\N	\N	\N	0	1
171	Pedi  uma bebida fresca e deram-me uma limonada com vàrios cubos de gelo.	（私が）冷たい飲み物を頼んだら、氷がたくさん入ったレモネードが持ってこられた。	\N		\N	vmod	\N	\N	\N	0	1
172	Ele pediu um café depois da refeição.	彼は食事の後にコーヒーを頼んだ。	\N		\N	vmod	\N	\N	\N	0	1
173	Lisboa tem muitos cafés.	リスボンには喫茶店がたくさんある。	\N		\N	vmod	\N	\N	\N	0	1
174	O sumo de limão é muito rico em vitamina.	レモンジュースにはビタミンが豊富だ。	\N		\N	vmod	\N	\N	\N	0	1
175	Costumo beber o leite todos os dias antes de dormir.	私は毎日寝る前に牛乳を飲む習慣だ。	\N		\N	vmod	\N	\N	\N	0	1
176	Ele pôs duas colheres de açúcar no café.	彼はコーヒーに砂糖を2杯入れた。	\N		\N	vmod	\N	\N	\N	0	1
177	Comprei um serviço de chá com cinco chávenas e cinco pires.	私は、カップ5個ソーサー5個というティーセット一式を買った。	\N		\N	vmod	\N	\N	\N	0	1
178	O chá cultiva-se na Ilha de São Miguel, nos Açores.	お茶は、アソーレス諸島のサン・ミゲル島で栽培されている。	\N		\N	vmod	\N	\N	\N	0	1
179	Os ingleses gostam muito de chá preto.	イギリス人は紅茶が大好きだ。	\N		\N	vmod	\N	\N	\N	0	1
180	Dá-me um copo de água.	コップに水を一杯くれ。	\N		\N	vmod	\N	\N	\N	0	1
181	Pus a água no copo.	私はコップに水を注いだ（入れた）。	\N		\N	vmod	\N	\N	\N	0	1
182	O sumo de pêssego é bastante doce.	ピーチジュースはかなり甘い。	\N		\N	vmod	\N	\N	\N	0	1
183	Encheu o copo de leite e bebeu.	（彼・彼女は）コップに牛乳を満たし（一杯入れ）、飲んだ。	\N		\N	vmod	\N	\N	\N	0	1
184	Você sabe muito bem comer com pauzinhos.	あなたは箸で食べるのが上手ですね。	\N		\N	vmod	\N	\N	\N	0	1
185	O álcool deve ser bebido com moderação.	お酒は節度を持って飲むべきだ。	\N		\N	vmod	\N	\N	\N	0	1
186	Este prato foi bom!	この料理はおいしかった！	\N		\N	vmod	\N	\N	\N	0	1
187	Aquela loja tem uma enorme colecção de facas.	あの店は、膨大な数のナイフのコレクションを置いている。	\N		\N	vmod	\N	\N	\N	0	1
188	Ela ofereceu-me uma linda colher de prata.	彼女は私に素敵な銀のスプーンをくれた。	\N		\N	vmod	\N	\N	\N	0	1
189	Não gosto de comer com garfo e faca, prefiro com pauzinhos.	ナイフとフォークを使って食べたくない、お箸がいいな。	\N		\N	vmod	\N	\N	\N	0	1
190	A França é um dos países da Europa que produz maior variedade de queijos.	フランスは、ヨーロッパの中でも様々な種類のチーズを作る国の一つです。	\N		\N	vmod	\N	\N	\N	0	1
191	Não consigo comer porque estou com dor de dentes.	私は歯が痛くて食べられない。	\N		\N	vmod	\N	\N	\N	0	1
192	Falando a verdade, o prato que ela cozinhou foi mau.	実を言うと、彼女の作った料理はまずかった。	\N		\N	vmod	\N	\N	\N	0	1
193	O pão é a base da alimentação de muitos povos.	パンは多くの人びとにとって基本的な食べ物である。	\N		\N	vmod	\N	\N	\N	0	1
194	A gastronomia tailandesa é muito picante.	タイ料理はとても辛い。	\N		\N	vmod	\N	\N	\N	0	1
195	Ele levou-a a jantar num restaurante italiano, no dia do aniversário dela.	彼は彼女の誕生日に、（彼女を）イタリアンレストランに連れて行った。	\N		\N	vmod	\N	\N	\N	0	1
196	Os professores também almoçam na cantina da escola.	先生達も学食（学校の食堂）で昼食をとる。	\N		\N	vmod	\N	\N	\N	0	1
197	Vendem-se bebidas alcoólicas	酒、あります（売っています）。	\N		\N	vmod	\N	\N	\N	0	1
198	Ela sempre pensa em comida.	彼女はいつも食べ物のことを考えている。	\N		\N	vmod	\N	\N	\N	0	1
199	Ele fez um óptimo caril de frango.	彼はとてもおいしいチキンカレーを作った。	\N		\N	vmod	\N	\N	\N	0	1
200	Tenho que arranjar dinheiro.	私はお金を工面しなければならない。	\N		\N	vmod	\N	\N	\N	0	1
201	Ele trabalha no banco.	彼は銀行で働いている。	\N		\N	vmod	\N	\N	\N	0	1
202	Além da porta da frente, tinha também uma entrada nas traseiras.	正面の扉だけでなく、裏にも入り口があった。	\N		\N	vmod	\N	\N	\N	0	1
203	"Tome isto, por favor.""Muito obrigado.""De nada."	「これ、どうぞ」「どうもありがとう」「どういたしまして」	\N		\N	vmod	\N	\N	\N	0	1
204	"Queres comer alguma coisa?""Não, não quero nada."	「なにか食べる？」「いいえ、何も欲しくない」	\N		\N	vmod	\N	\N	\N	0	1
205	"Gostou do vinho?""Sim, foi óptimo!"	「ワインはおいしかったですか？」「ええ、とても！」	\N		\N	vmod	\N	\N	\N	0	1
206	"Com licença, poderia dizer-me onde fica o correio central?"	「すみません、中央郵便局はどこにありますか？」	\N		\N	vmod	\N	\N	\N	0	1
207	"Posso sentar-me aqui?""Faça favor."	「ここに座って良いですか？」「どうぞ」	\N		\N	vmod	\N	\N	\N	0	1
208	Uma das saídas da rotunda leva ao centro da cidade e a outra à autoestrada.	ロータリーの出口の、一つは市街地へ、もう一つは高速道路へと通じている。	\N		\N	vmod	\N	\N	\N	0	1
210	Perto da minha casa há uma caixa do correio.	我が家の近くには郵便ポストがある。	\N		\N	vmod	\N	\N	\N	0	1
211	Recebi ontem o cartão postal do meu namorado que está agora na França.	私は昨日、今フランスにいる恋人からはがきを受け取った。	\N		\N	vmod	\N	\N	\N	0	1
212	Tem que colar o selo de oitenta ienes no envelope.	封筒に80円切手を貼らねばなりません。	\N		\N	vmod	\N	\N	\N	0	1
213	Escrevi a morada no envelope.	私は封筒に住所を書いた。	\N		\N	vmod	\N	\N	\N	0	1
214	Tenho aqui duas cartas para pôr no correio.	ここに投函する手紙2通があります（持っています）。	\N		\N	vmod	\N	\N	\N	0	1
215	Mandei-lhe os livros pelo correio.	私は彼・彼女に郵便で本を送った（本を郵送した）。	\N		\N	vmod	\N	\N	\N	0	1
216	Como a morada estava incompleta, a carta foi devolvida.	住所（宛先）が不備だったので、手紙は返されてしまった。	\N		\N	vmod	\N	\N	\N	0	1
217	Enviei uma carta ao amigo.	私は友人に手紙を出した。	\N		\N	vmod	\N	\N	\N	0	1
218	Colei o selo de cinquenta ienes no cartão postal.	私ははがきに50円切手を貼った。	\N		\N	vmod	\N	\N	\N	0	1
219	Perdi a minha bagagem no aeroporto.	私は空港で荷物をなくした。	\N		\N	vmod	\N	\N	\N	0	1
220	Apanhou uma folha de papel para tomar notas.	（彼・彼女は）メモをとるために紙を一枚つかんだ（とった）。	\N		\N	vmod	\N	\N	\N	0	1
221	Emprestou muito dinheiro ao velho amigo.	（彼・彼女は）旧友に多額の金を貸した。	\N		\N	vmod	\N	\N	\N	0	1
483	Muitas pessoas correram ao banco.	大勢の人が銀行へ走った。	\N		\N	vmod	\N	\N	\N	0	1
222	Eu compro o jornal no quiosque todas as manhãs.	私は毎朝キオスクで新聞を買う。	\N		\N	vmod	\N	\N	\N	0	1
223	Ela tirou o chapéu.	彼女は帽子をとった（脱いだ）。	\N		\N	vmod	\N	\N	\N	0	1
224	Preciso de comprar um par de sapatos novos.	（私は）新しい靴を一足買わねばならない。	\N		\N	vmod	\N	\N	\N	0	1
225	Fiz uma boa compra.	(私は）いい買い物をしたわ。	\N		\N	vmod	\N	\N	\N	0	1
226	Vocês moram no rés-do-chão, e nós no segundo andar.	あなた方は1階に住んでいて、我々は３階に住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
227	Vamos ao centro comercial récem-inaugurado.	最近オープンしたデパート（ショッピングセンター）に行きましょう。	\N		\N	vmod	\N	\N	\N	0	1
228	Comprei uma saia azul.	私は青いスカートを買った。	\N		\N	vmod	\N	\N	\N	0	1
229	Queria um casaco novo.	（私は）新しいコートが欲しいわ。	\N		\N	vmod	\N	\N	\N	0	1
230	Prefiro estar com calça de ganga.	私はジーンズで居るのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
231	Vestiu uma camisola de lã grossa porque estava frio.	寒かったので、（彼・彼女は）分厚いウールのセーターを着た。	\N		\N	vmod	\N	\N	\N	0	1
232	Poderia abrir a janela?	窓を開けて下さいませんか？	\N		\N	vmod	\N	\N	\N	0	1
233	A sua bagagem foi constituída por três malas e uma mochila, não foi?	あなたの荷物は、カバンが３つとリュックが１つでしたね？	\N		\N	vmod	\N	\N	\N	0	1
234	Venderam tudo o que havia no armazém.	（彼らは）倉庫にあったものすべてを売った。	\N		\N	vmod	\N	\N	\N	0	1
235	Este casaco deve ser lavado a seco.	この上着はドライクリーニングしなければならない。	\N		\N	vmod	\N	\N	\N	0	1
236	Ele estava a tomar banho.	彼は風呂に入っていた（入浴中だった）。	\N		\N	vmod	\N	\N	\N	0	1
237	O edifício do Teatro devia ser demolido por causa do incêndio.	劇場の建物は、火事にあったため取り壊されねばならなかった。	\N		\N	vmod	\N	\N	\N	0	1
238	Passava horas na cozinha a experimentar receitas novas.	（私・彼・彼女は）台所で新しいレシピを試しながら数時間過ごした。	\N		\N	vmod	\N	\N	\N	0	1
239	Meteu-se debaixo do chuveiro e abriu a torneira.	（彼・彼女は）シャワーの下に行き、蛇口をひねった。	\N		\N	vmod	\N	\N	\N	0	1
240	A casa tem muita luz, todas as divisões têm grandes janelas.	全ての部分（部屋）に大きな窓があり、家（の中）はとても明るい。	\N		\N	vmod	\N	\N	\N	0	1
241	Onde é que você mora?	あなたはどこに住んでいるのですか？	\N		\N	vmod	\N	\N	\N	0	1
242	Os parques nacionais africanos atraem muitos turistas.	アフリカの国立公園は多くの旅行者を惹きつける。	\N		\N	vmod	\N	\N	\N	0	1
243	Poderia abrir a porta, por favor.	ドアを開けて下さい。	\N		\N	vmod	\N	\N	\N	0	1
244	Ela lia a revista enquanto tomava banho.	彼女は風呂に入っている間雑誌を読んでいた。	\N		\N	vmod	\N	\N	\N	0	1
245	Queria alugar um apartamento perto do escritório.	事務所の近くにアパートを借りたい。	\N		\N	vmod	\N	\N	\N	0	1
246	Eles estavam a conversar na entrada da casa.	彼らは家の玄関で話しこんでいた。	\N		\N	vmod	\N	\N	\N	0	1
247	Ela fala mais do que ele.	彼女は彼よりも（たくさん）話す。	\N		\N	vmod	\N	\N	\N	0	1
248	Ele quis sair com elas.	彼は彼女らと出かけたかった。	\N		\N	vmod	\N	\N	\N	0	1
249	Eu sou japonês.	僕・私（男性）は日本人です。	\N		\N	vmod	\N	\N	\N	0	1
250	Nós, os japoneses, gostamos muito de futebol.	我々日本人は、サッカーが大好きです。	\N		\N	vmod	\N	\N	\N	0	1
251	Alguém passou pela minha casa?	誰か家に来なかった（寄らなかった）？	\N		\N	vmod	\N	\N	\N	0	1
252	Quem é que telefonou?	誰からの電話？	\N		\N	vmod	\N	\N	\N	0	1
253	Quem é?	どなたですか？	\N		\N	vmod	\N	\N	\N	0	1
254	Tu estás interessada no projecto?	君はこのプロジェクトに興味があるのか？	\N		\N	vmod	\N	\N	\N	0	1
255	Você tem de descansar.	あなたは休まなければなりません。	\N		\N	vmod	\N	\N	\N	0	1
256	Gosto de gatos; considero estes animais bons companheiros.	私は猫が好きだ、というのもこの動物は良きパートナーと思うからだ。	\N		\N	vmod	\N	\N	\N	0	1
257	Aquele livro é mais interessante do que esse.	あの本は、これ（この本）よりも面白い。	\N		\N	vmod	\N	\N	\N	0	1
258	Como foi o filme?	映画はどうだった？	\N		\N	vmod	\N	\N	\N	0	1
259	Qual dos livros recomendas?	(君は）どの（どちらの）本がお勧めだい？	\N		\N	vmod	\N	\N	\N	0	1
260	Como é que aconteceu o desastre?	その災害・惨事は一体どうやって起こったのだ？	\N		\N	vmod	\N	\N	\N	0	1
261	Mesmo assim é que eu gosto!	私はまさにこんなのが好きだ！	\N		\N	vmod	\N	\N	\N	0	1
262	Eu sou estudante.	私は学生です。	\N		\N	vmod	\N	\N	\N	0	1
263	Porque dizes assim?	（君は）どうしてそんなふうに言うの？	\N		\N	vmod	\N	\N	\N	0	1
264	Cortei o pão em fatias grossas.	私はパンをぶ厚くスライスした。	\N		\N	vmod	\N	\N	\N	0	1
265	Os turistas passearam pelas ruas estreitas de Alfama.	旅行者達はアルファマの狭い通りを散策した。	\N		\N	vmod	\N	\N	\N	0	1
266	Ela tem as pernas finas.	彼女は細い足をしている。	\N		\N	vmod	\N	\N	\N	0	1
267	Um dia eu queria visitar as grandes florestas do Brasil.	いつの日か私はブラジルの大森林に行ってみたい。	\N		\N	vmod	\N	\N	\N	0	1
268	Encontrou-se um tronco grosso de árvore.	木の太い幹があった（に出くわした）。	\N		\N	vmod	\N	\N	\N	0	1
269	Ele tem um ano mais novo do que eu.	彼は私より1才若い。	\N		\N	vmod	\N	\N	\N	0	1
270	A casa fica numa rua larga e cheia de sol.	家は日当たりの良い広い通りにある。	\N		\N	vmod	\N	\N	\N	0	1
271	A mala estava tão leve que era fácil transportá-la.	カバンは軽かったので持ち運びが楽だった。	\N		\N	vmod	\N	\N	\N	0	1
272	Atirou a bola para muito longe.	彼・彼女は、ボールをとても遠くに投げた。	\N		\N	vmod	\N	\N	\N	0	1
273	O saco está tão pesado que ela não pode levá-lo.	袋は重すぎて彼女には無理だ（持てない）。	\N		\N	vmod	\N	\N	\N	0	1
274	Comprei um livro fino.	私は薄い本を一冊買った。	\N		\N	vmod	\N	\N	\N	0	1
275	"Que há de novo?""Nada de novo, continua tudo na mesma."	「何か新しいことはありますか？」「何も、全て同じですよ」	\N		\N	vmod	\N	\N	\N	0	1
276	Prefiro ter um carro pequeno para circular na cidade.	街なかで乗り回すには小さな車の方がよい。	\N		\N	vmod	\N	\N	\N	0	1
277	A estação é perto daqui.	駅はこの近くです。	\N		\N	vmod	\N	\N	\N	0	1
278	Ele ama o seu carro velho.	彼は自分の古い車を愛している。	\N		\N	vmod	\N	\N	\N	0	1
279	Ele é uma pessoa muito alegre.	彼はとても楽しい人です。	\N		\N	vmod	\N	\N	\N	0	1
280	Foi uma festa muito animada.	とてもにぎやかなパーティーだった。	\N		\N	vmod	\N	\N	\N	0	1
281	Ele é mais baixo do que a sua namorada.	彼は自分の恋人よりも背が低い。	\N		\N	vmod	\N	\N	\N	0	1
282	Precisa-se de uma faca boa, porque esta não corta bem.	いいナイフが要る、これ（このナイフ）はよく切れないから。	\N		\N	vmod	\N	\N	\N	0	1
283	Esta sala é clara.	この部屋（広間）は明るい。	\N		\N	vmod	\N	\N	\N	0	1
284	Há dois dias que ela quase não comia nada e sentiu-se fraca e cansada.	この2日間ほとんど食べなかったので、彼女は弱っていて疲れているのを感じた。	\N		\N	vmod	\N	\N	\N	0	1
285	Além de ser bonito, ele é um rapaz alto e forte.	かっこいい上に、彼は背が高く強い少年である。	\N		\N	vmod	\N	\N	\N	0	1
286	O filme foi interessante?	映画は面白かった？	\N		\N	vmod	\N	\N	\N	0	1
287	A casa dos meus avós tem um jardim muito bonito.	私の祖父母の家には、とても美しい庭がある。	\N		\N	vmod	\N	\N	\N	0	1
288	Ela anda muito devagar.	彼女はとてもゆっくりと（遅く）歩く。	\N		\N	vmod	\N	\N	\N	0	1
289	Fui devagar porque a estrada estava má.	道路の状態が悪かったので、私はゆっくり行った。	\N		\N	vmod	\N	\N	\N	0	1
290	Muita gente sonha com prémios da lotaria.	多くの人が宝くじに当たることを夢見る。	\N		\N	vmod	\N	\N	\N	0	1
291	O túnel estava escuro como breu.	トンネル（の中）は、タールのように暗かった（真っ暗闇だった）。	\N		\N	vmod	\N	\N	\N	0	1
292	Era um jardim silencioso longe dos barulhos da cidade.	街の喧噪から離れた、静かな庭（庭園）だった。	\N		\N	vmod	\N	\N	\N	0	1
293	Só posso comer muito pouco.	（私は）とても少ししか食べられない。	\N		\N	vmod	\N	\N	\N	0	1
294	A rua está suja de óleo por causa do trânsito automóvel.	車が通るので、この道はオイルで汚れている。	\N		\N	vmod	\N	\N	\N	0	1
295	O filme foi chato.	映画はつまらなかった。	\N		\N	vmod	\N	\N	\N	0	1
296	A rapariga sentou-se ao meu lado no comboio.	電車の中で、少女が私の横（となり）に座った。	\N		\N	vmod	\N	\N	\N	0	1
297	Vamos para dentro porque está frio.	寒いから、中に入りましょう。	\N		\N	vmod	\N	\N	\N	0	1
298	Vamos almoçar fora.	外で昼食をとりましょう。	\N		\N	vmod	\N	\N	\N	0	1
299	O navio partiu para o leste.	船は東に向けて出発した。	\N		\N	vmod	\N	\N	\N	0	1
300	Este prédio tem vinte metros de altura.	この建物は高さ20メートルある。	\N		\N	vmod	\N	\N	\N	0	1
301	Atenção, soldados!, todos na vertical!	聞け、兵士達よ、全員縦に（列べ）！	\N		\N	vmod	\N	\N	\N	0	1
302	O ponteiro indica o norte.	(方位磁石の）針は北を指している。	\N		\N	vmod	\N	\N	\N	0	1
303	O vento soprava do oeste.	風は西から吹いていた。	\N		\N	vmod	\N	\N	\N	0	1
304	Ela mora no quinto andar e a sua filha mora no andar em baixo.	彼女は6階に住んでいて、娘はその下に住んでいる。	\N		\N	vmod	\N	\N	\N	0	1
305	Ele vem do sul.	彼は南から来た（南の人間・出身だ）。	\N		\N	vmod	\N	\N	\N	0	1
306	Deitou-se de barriga para cima.	彼・彼女は、仰向け（腹を上にして横）になった。	\N		\N	vmod	\N	\N	\N	0	1
307	Ia na frente do cortejo com uma bandeira.	私・彼・彼女は、旗を掲げながら行列の先を行った。	\N		\N	vmod	\N	\N	\N	0	1
308	Chegaram todos senão ele que devia vir atrás.　	みんなは到着したが、彼は後から来ることにした。	\N		\N	vmod	\N	\N	\N	0	1
309	Ele deu-se muito bem com os primos.	彼はいとこたちととても仲が良かった。	\N		\N	vmod	\N	\N	\N	0	1
310	Meu irmão mais velho chama-se Ronaldo.	私の兄はロナウドといいます。	\N		\N	vmod	\N	\N	\N	0	1
311	Não tenho irmãos. Sou filho único.	私には兄弟がいません、一人っ子です。	\N		\N	vmod	\N	\N	\N	0	1
312	Minha avó cozinha muito bem.	私のおばあさんは料理が上手です。	\N		\N	vmod	\N	\N	\N	0	1
313	Meu avô paterno morreu na Segunda Guerra Mundial.	私の父方のおじいさんは、第二次世界大戦で死にました。	\N		\N	vmod	\N	\N	\N	0	1
314	Até ontem ela era noiva, mas a partir de hoje é esposa.	昨日まで彼女は婚約者だったが、今日からは妻である。	\N		\N	vmod	\N	\N	\N	0	1
315	Normalmente um agregado familiar compõe-se de pai, mãe e dois filhos.	一家族は(通常）、父、母、子供二人で構成される。	\N		\N	vmod	\N	\N	\N	0	1
316	O tio comprou os brinquedos aos sobrinhos.	伯父（叔父）は甥っ子達におもちゃを買った。	\N		\N	vmod	\N	\N	\N	0	1
317	Nas férias de inverno vou regressar à casa dos meus pais.	冬休みは両親の家に帰るつもりです。	\N		\N	vmod	\N	\N	\N	0	1
318	Ele tornou-se orfão de pai quando era miúdo.	彼は幼い頃に父を亡くしている。	\N		\N	vmod	\N	\N	\N	0	1
319	Ela tem duas irmãs mais velhas.	彼女には姉が2人いる。	\N		\N	vmod	\N	\N	\N	0	1
320	Você tem irmãs?	あなたには姉妹がいますか？	\N		\N	vmod	\N	\N	\N	0	1
321	Minha tia vai casar neste ano.	私のおば（叔母・伯母）は、今年結婚する。	\N		\N	vmod	\N	\N	\N	0	1
322	Meu irmão mais velho comprou um carro novo.	私のお兄さんは新車を買った。	\N		\N	vmod	\N	\N	\N	0	1
323	Saí ontem com minha irmã mais velha.	昨日私はお姉さんと出かけた。	\N		\N	vmod	\N	\N	\N	0	1
324	Papá, vamos ao parque!	パパ、公園に行こうよ！	\N		\N	vmod	\N	\N	\N	0	1
325	Mamã, faz o bolo-rei!	ママ、ボーロ・デ・レイ（クリスマスのケーキ）を作ってよ！	\N		\N	vmod	\N	\N	\N	0	1
326	Não podia calçar meias de lã com aqueles sapatos, pois eram demasiado grossas.	あの靴にはこのウールの靴下はぶ厚過ぎてはけなかった。	\N		\N	vmod	\N	\N	\N	0	1
327	Quando era estudante, ela andava sempre de calças de ganga e camisa comprida.	学生時代、彼女はいつもジーンズに長いシャツを着ていた。	\N		\N	vmod	\N	\N	\N	0	1
328	Ele despiu o casaco e pendurou-o no cabide.	彼はコート・上着を脱ぎ、洋服掛けに掛けた。	\N		\N	vmod	\N	\N	\N	0	1
329	Ela pendurou o quadro na parede.	彼女は絵を壁に掛けた。	\N		\N	vmod	\N	\N	\N	0	1
330	Calçou uma calça muito curta pela primeira vez.	彼女は初めてとても短いズボンをはいた。	\N		\N	vmod	\N	\N	\N	0	1
331	Vestiu uma camisola, porque estava frio.	彼・彼女は寒かったのでセーターを着た。	\N		\N	vmod	\N	\N	\N	0	1
332	Ele cobriu-se com um chapéu.	彼は帽子をかぶった。	\N		\N	vmod	\N	\N	\N	0	1
333	Ela enxugou as lágrimas com um lenço.	彼女はハンカチで涙を拭いた。	\N		\N	vmod	\N	\N	\N	0	1
334	Mal chegou a casa, ele calçou os chinelos.	家に着くやいなや、彼はスリッパを履いた。	\N		\N	vmod	\N	\N	\N	0	1
335	Vocês trouxeram guarda-chuva?	あなた方は傘を持ってきましたか？	\N		\N	vmod	\N	\N	\N	0	1
336	Ele andava com as mãos nos bolsos.	彼はポケットに手を入れて歩いていた。	\N		\N	vmod	\N	\N	\N	0	1
337	Roubaram-me a  carteira no metro.	私は地下鉄で財布を盗まれた。	\N		\N	vmod	\N	\N	\N	0	1
338	Hoje ele está bem vestido.	彼は今日はきちんとした身なりをしている（きちんとした服を着ている）。	\N		\N	vmod	\N	\N	\N	0	1
339	Deitou a criança e vestiu-lhe a roupa.	子供を寝かせて（横にならせて）、服を着せた。	\N		\N	vmod	\N	\N	\N	0	1
340	Queria comprar uma nova roupa.	新しい洋服を買いたい。	\N		\N	vmod	\N	\N	\N	0	1
341	Ele deu-lhe um beijo na boca.	彼は彼・彼女の口にキスをした。	\N		\N	vmod	\N	\N	\N	0	1
342	Ela teve de puxar a filha por um braço para que não ficasse para trás.	彼女は、娘が遅れないように（後ろに来ないように）彼女の腕を引っ張らねばならなかった。	\N		\N	vmod	\N	\N	\N	0	1
343	O corpo humano é formado por cabeça, tronco e membros.	人間の体は、頭、胴体、そして手足から成る。	\N		\N	vmod	\N	\N	\N	0	1
344	Tenho a cara redonda.	私は丸顔だ（丸い顔を持っている）。	\N		\N	vmod	\N	\N	\N	0	1
345	Partiu uma perna e por isso anda de muletas.	彼・彼女は足を骨折してしまったので、松葉杖で歩いている。	\N		\N	vmod	\N	\N	\N	0	1
346	Agarrou na caneta com a mão direita e começou a escrever.	彼・彼女は右手にペンをつかみ、書き始めた。	\N		\N	vmod	\N	\N	\N	0	1
347	Inspire pelo nariz e expire lentamente pela boca	鼻から息を吸い、口からゆっくり吐きなさい。	\N		\N	vmod	\N	\N	\N	0	1
348	Tinha uns olhos grandes e expressivos.	彼・彼女は、大きく表情豊かな目をしていた（持っていた）。	\N		\N	vmod	\N	\N	\N	0	1
349	Ele usa um brinco na orelha direita.	彼は右の耳にイヤリングをしている。	\N		\N	vmod	\N	\N	\N	0	1
350	Aqueles sapatos apertavam-me os pés, mal conseguia andar.	あの靴は足にきつくて（足を締め付けるので）、私はほとんど歩けなかった。	\N		\N	vmod	\N	\N	\N	0	1
351	O bebé, depois de ter a barriga cheia, ficou sorridente.	赤ちゃんは、お腹が一杯になってしまうと、にこにことなった。	\N		\N	vmod	\N	\N	\N	0	1
353	Comprei um pacote de manteiga.	私はバターを一箱買った。	\N		\N	vmod	\N	\N	\N	0	1
354	Ela preferia beber café com leite com grande tigela.	彼女はカフェオーレを大きな茶碗で飲むのが好きだった。	\N		\N	vmod	\N	\N	\N	0	1
355	Comprei numa farmácia um pacote de rebuçados contra a tosse.	私は薬局で咳止めの飴を一箱買った。	\N		\N	vmod	\N	\N	\N	0	1
356	O que vai comer ao almoço?	昼食に何を食べますか？	\N		\N	vmod	\N	\N	\N	0	1
357	Ela preparou um jantar num instante.	彼女はあっという間に夕食の準備をした。	\N		\N	vmod	\N	\N	\N	0	1
358	Aquela pastelaria tem doces regionais	あのお菓子屋さんには、土地のお菓子がある。	\N		\N	vmod	\N	\N	\N	0	1
359	Baｔeu ovos para fazer uma omelete de queijo.	彼・彼女は、チーズオムレツを作るために卵をかき混ぜた。	\N		\N	vmod	\N	\N	\N	0	1
360	Não costumo tomar o pequeno almoço.	私はいつも朝食を食べない。	\N		\N	vmod	\N	\N	\N	0	1
361	Aquele café oferece refeição leve.	あそこの喫茶店には軽食がある。	\N		\N	vmod	\N	\N	\N	0	1
362	Tenho saudade do sabor do molho de soja.	醤油の味が懐かしい。	\N		\N	vmod	\N	\N	\N	0	1
363	Faça o favor de passar-me o sal.	塩を取ってくれませんか？	\N		\N	vmod	\N	\N	\N	0	1
364	Ele convidou-nos para o jantar.	彼は我々を夕食に招待した。	\N		\N	vmod	\N	\N	\N	0	1
365	Juntou água no vinho.	彼・彼女はワインに水を加えた。	\N		\N	vmod	\N	\N	\N	0	1
366	Vamos ver se conseguimos colar a asa da chávena.	カップの取っ手を付けられるかどうかやってみようよ。	\N		\N	vmod	\N	\N	\N	0	1
367	Levei a máquina fotográfica.	私はカメラを持って行った。	\N		\N	vmod	\N	\N	\N	0	1
368	Ele ligou o aquecedor.	彼は暖房をつけた。	\N		\N	vmod	\N	\N	\N	0	1
369	Ofereceu à criança uma caixa de lápis de cor.	(彼・彼女は)子供に色鉛筆を一箱をプレゼントした。	\N		\N	vmod	\N	\N	\N	0	1
370	Apaguei os sublinhados a lápis no texto.	私は、テキストに引いた鉛筆の線を消した。	\N		\N	vmod	\N	\N	\N	0	1
371	Comecei a ter que semicerrar os olhos para ver: vou precisar de usar óculos.	私は目を細めて見なくてはならなくなり始めたので、眼鏡を使う必要が出てくるだろう。	\N		\N	vmod	\N	\N	\N	0	1
372	Ele ainda usa o gravador de fita velho.	彼はまだ古いテープレコーダーを使っている。	\N		\N	vmod	\N	\N	\N	0	1
373	O relógio da cozinha anda 3 minutos atrasado.	台所の時計は3分遅れている。	\N		\N	vmod	\N	\N	\N	0	1
374	Ele introduziu dados no computador.	彼はコンピューターにデータを入力した。	\N		\N	vmod	\N	\N	\N	0	1
375	Tenho que comprar um rolo de filme fotográfico.	（私は）写真のフィルムを買わねばならない。	\N		\N	vmod	\N	\N	\N	0	1
376	Alguém bateu à porta.　	誰かが戸を叩いた。	\N		\N	vmod	\N	\N	\N	0	1
377	Os guardas abriram o portão.	門番達は門を開けた。	\N		\N	vmod	\N	\N	\N	0	1
378	Poderia emprestar-me uma caneta?	私にペンを貸して下さいませんか？	\N		\N	vmod	\N	\N	\N	0	1
379	Ele ofereceu ao filho uma caneta-tinteiro quando entrou na universidade.	彼は息子が大学に入った時、万年筆を贈った。	\N		\N	vmod	\N	\N	\N	0	1
380	Prefiro escrever a lápis à caneta.	私はペンで書くよりも鉛筆で書く方を好む。	\N		\N	vmod	\N	\N	\N	0	1
381	A maior parte dos portugueses têm férias em Agosto.	たいていのポルトガル人は8月に休暇を取る。	\N		\N	vmod	\N	\N	\N	0	1
382	O dia 25 de Abril é feriado em Portugal.	4月25日はポルトガルの祝祭日だ。	\N		\N	vmod	\N	\N	\N	0	1
383	Ainda não recebi o ordenado deste mês.	私はまだ今月の給料をもらってない。	\N		\N	vmod	\N	\N	\N	0	1
384	Todos os meses vou ao cabeleireiro.	私は毎月美容院に行く。	\N		\N	vmod	\N	\N	\N	0	1
385	O primeiro dia de Dezembro, dia da Restauração da Independência, é feriado nacional.	12月1日は独立回復記念日であり、祝祭日だ。	\N		\N	vmod	\N	\N	\N	0	1
386	O Carnaval é em Fevereiro.	カーニバルは多くの場合2月中だ。	\N		\N	vmod	\N	\N	\N	0	1
387	Janeiro é o mês do meu aniversário.	１月は、私の誕生月だ。	\N		\N	vmod	\N	\N	\N	0	1
388	Este ano vamos de férias em Julho.	今年は7月に（夏）休みをとろうよ。	\N		\N	vmod	\N	\N	\N	0	1
389	O dia 10 de Junho, que é o dia de Portugal e de Camões, é feriado nacional.	6月10日は、ポルトガルの日、カモンエスの日であり、祝祭日である。	\N		\N	vmod	\N	\N	\N	0	1
390	Vai ser aberta uma nova loja no próximo mês.	来月新しい店が1軒オープンする。	\N		\N	vmod	\N	\N	\N	0	1
391	O primeiro dia de Maio, Dia Internacional do Trabalhador, é feriado.	5月1日はメーデーであり休日だ。	\N		\N	vmod	\N	\N	\N	0	1
392	A primavera começa a 21 de Março e termina a 20 de Junho.	春は3月21日に始まり、6月20日に終わる。	\N		\N	vmod	\N	\N	\N	0	1
393	Houve aqui um acidente de trânsito no mês passado.	先月ここで交通事故があった。	\N		\N	vmod	\N	\N	\N	0	1
394	O primeiro dia de Novembro, dia de Todos os Santos, é feriado.	11月1日は万聖節であり、休日だ。	\N		\N	vmod	\N	\N	\N	0	1
395	O dia 5 de Outubro é o dia da Implantação da República em Portugal.	10月5日はポルトガルの共和国樹立日だ。	\N		\N	vmod	\N	\N	\N	0	1
396	Setembro é o mês das vindimas.	9月は葡萄の収穫月だ。	\N		\N	vmod	\N	\N	\N	0	1
397	Fiz uma dieta durante um mês.	私は一ヶ月間ダイエットした。	\N		\N	vmod	\N	\N	\N	0	1
398	Teremos uma festa na casa dele na sexta-feira desta semana.	今週金曜日、我々は彼の家でパーティーを開く。	\N		\N	vmod	\N	\N	\N	0	1
399	Frequento o hospital todas as semanas.	私は毎週病院に通っている。	\N		\N	vmod	\N	\N	\N	0	1
400	Eles têm o costume de passar juntos os domingos em família.	彼らは、日曜は家族そろって過ごす習慣である。	\N		\N	vmod	\N	\N	\N	0	1
401	Há aulas de música às quintas-feiras à tarde.	毎週木曜午後には音楽の授業がある。	\N		\N	vmod	\N	\N	\N	0	1
402	Na próxima semana vou fazer 20 anos	来週私は20歳になる。	\N		\N	vmod	\N	\N	\N	0	1
403	Segunda-feira passada foi feriado.	先週月曜は休日だった。	\N		\N	vmod	\N	\N	\N	0	1
404	Tem lições de piano às terças-feiras.　	毎週火曜日にピアノのレッスンがある。	\N		\N	vmod	\N	\N	\N	0	1
405	Tem uma consulta marcada para a próxima quarta-feira.	次の水曜に診察の予約がある。	\N		\N	vmod	\N	\N	\N	0	1
406	Tiveram um fim-de-semana divertido: foram à praia no sábado e tiveram a festa no domingo.	彼ら・彼女らは、土曜は海に日曜はパーティーと、楽しい週末を過ごした。	\N		\N	vmod	\N	\N	\N	0	1
407	Daqui a duas semanas tenho de dar a resposta.	2週間後に回答を出さねばならない。	\N		\N	vmod	\N	\N	\N	0	1
408	Na semana passada fiz um exame.	先週試験を受けた。	\N		\N	vmod	\N	\N	\N	0	1
409	Costumam sair com os amigos sexta-feira à noite.	彼らは、いつも金曜の夜は友達とくり出す。	\N		\N	vmod	\N	\N	\N	0	1
410	Um ano tem normalmente 365 dias.	一年は通常365日ある。	\N		\N	vmod	\N	\N	\N	0	1
411	As vindimas começam no início do Outono.	ブドウの収穫は初秋に始まる。	\N		\N	vmod	\N	\N	\N	0	1
412	Este ano é o ano bissexto.	今年は閏年だ。	\N		\N	vmod	\N	\N	\N	0	1
413	Eles visitam a Itália todos os anos.	彼らは毎年イタリアを訪れている。	\N		\N	vmod	\N	\N	\N	0	1
414	Ela costuma passar o verão à beira-mar.	彼女は、夏を海の近くで過ごすことにしている。	\N		\N	vmod	\N	\N	\N	0	1
415	Anoitece muito cedo no Inverno.	冬には早く日が暮れる（夜になる）。	\N		\N	vmod	\N	\N	\N	0	1
416	Apanhei uma doença grave no ano passado, mas agora fico bem.	私は去年重病にかかったが、今は良くなっている。	\N		\N	vmod	\N	\N	\N	0	1
417	No próximo ano eles vão casar-se.	来年彼らは結婚する。	\N		\N	vmod	\N	\N	\N	0	1
418	As andorinhas chegam na Primavera.	つばめは春にやってくる。	\N		\N	vmod	\N	\N	\N	0	1
419	Daqui a dois anos vai ser construída aqui uma estação nova.	再来年（2年後）にはここに新しい駅が出来る。	\N		\N	vmod	\N	\N	\N	0	1
420	Meu avô morreu há dois anos.　	私の祖父は一昨年（2年前）亡くなった。	\N		\N	vmod	\N	\N	\N	0	1
421	Volto a ligar à tarde.	午後にもう一度電話します。	\N		\N	vmod	\N	\N	\N	0	1
422	Não deixes para amanhã o que podes fazer hoje.	(君は）今日できることを明日に延ばすな。	\N		\N	vmod	\N	\N	\N	0	1
423	Eles vão partir amanhã de manhã.	彼らは明日朝発つ。	\N		\N	vmod	\N	\N	\N	0	1
424	São dez horas da manhã.	午前（朝の）10時です。	\N		\N	vmod	\N	\N	\N	0	1
425	Ela fez vinte anos ontem.	彼女は昨日20歳を迎えた。	\N		\N	vmod	\N	\N	\N	0	1
426	Tivemos uma festa ontem à noite na casa dela.	我々は夕べ（昨夜）彼女の家でパーティーをした。	\N		\N	vmod	\N	\N	\N	0	1
427	Chegou a casa muito tarde por volta das 3 da manhã.	彼・彼女はとても遅くに、午前3時くらいに帰宅した。	\N		\N	vmod	\N	\N	\N	0	1
428	Ele trabalha de manhã até à noite.	彼は朝から晩まで働く。	\N		\N	vmod	\N	\N	\N	0	1
429	Ele trabalha de noite e descansa de dia.	彼は夜働き、昼休む。	\N		\N	vmod	\N	\N	\N	0	1
430	Passaram todos a noite em claro.	全員夜中起きていた。	\N		\N	vmod	\N	\N	\N	0	1
482	Ele não acreditava no que os adultos lhe contaram.	彼は大人達が語ったことを信じなかった。	\N		\N	vmod	\N	\N	\N	0	1
431	Eles iam sempre para a praia à tardinha e ficavam para ver o pôr-de-sol no mar.	彼らは夕方いつも浜辺に行き、海に沈む夕日を見ていたものだった。	\N		\N	vmod	\N	\N	\N	0	1
432	Tenho um encontro com ele depois de amanhã.	明後日私は彼と会う約束をしている。	\N		\N	vmod	\N	\N	\N	0	1
433	Anteontem encontrei-o por acaso na Baixa . 	おととい下町で彼に偶然会った。	\N		\N	vmod	\N	\N	\N	0	1
434	Já comeste tudo?	もう全部食べた？	\N		\N	vmod	\N	\N	\N	0	1
435	Não coma andando.	歩きながら食べるな。	\N		\N	vmod	\N	\N	\N	0	1
436	Ainda não fiz nada.	(私は）まだ何もしていない。	\N		\N	vmod	\N	\N	\N	0	1
437	Ele trabalha todo o dia.	彼は一日中働く。	\N		\N	vmod	\N	\N	\N	0	1
438	À hora de saída do trabalho, o trânsito é infernal.	会社を出る時（時間）には、ひどいラッシュだ（交通は恐ろしい状態だ）。	\N		\N	vmod	\N	\N	\N	0	1
439	Quando é que parte este autocarro?	このバスはいつ発車しますか？	\N		\N	vmod	\N	\N	\N	0	1
440	Faltei à aula às vezes.	私はときどき授業を欠席した。	\N		\N	vmod	\N	\N	\N	0	1
441	Eles muitas vezes faltaram à aula.	彼ら・彼女らはしばしば授業を欠席した。	\N		\N	vmod	\N	\N	\N	0	1
442	A visita ao museu durou uma hora e meia.	美術館を観るのに1時間半かかった。	\N		\N	vmod	\N	\N	\N	0	1
443	Vou já aí.	（私は）今・すぐそちらに行くよ。	\N		\N	vmod	\N	\N	\N	0	1
444	Podia trazer o cinzeiro?	灰皿を持ってきてください。	\N		\N	vmod	\N	\N	\N	0	1
445	A criança aprendeu rapidamente as letras da canção.	その子供はあっというまに歌の歌詞を覚えてしまった。	\N		\N	vmod	\N	\N	\N	0	1
446	Ela canta muito bem.	彼女は歌がうまい。	\N		\N	vmod	\N	\N	\N	0	1
447	Ele fuma um maço de cigarros por dia.	彼は一日一箱タバコを吸う。	\N		\N	vmod	\N	\N	\N	0	1
448	Esse filme está em exibição em vários cinemas de Lisboa.	この映画はリスボンの多くの映画館で上映されています。	\N		\N	vmod	\N	\N	\N	0	1
2	Não sei falar inglês	私は英語が話せない。	\N		\N	vmod	\N	\N	\N	0	1
3	Viajo de avião	私は飛行機で旅行する。	\N		\N	vmod	\N	\N	\N	0	1
4	Gostaria de visitar os paises estrangeiros.	私は外国に行ってみたい。	\N		\N	vmod	\N	\N	\N	0	1
449	Ele tem as colecções dos discos preciosos.	彼は貴重なレコードのコレクションを持っている。	\N		\N	vmod	\N	\N	\N	0	1
450	Existem vários tipos de guitarra.	様々な種類のギターがある。	\N		\N	vmod	\N	\N	\N	0	1
451	Ela toca piano muito bem.	彼女はとても上手にピアノを弾く。	\N		\N	vmod	\N	\N	\N	0	1
452	Entre todas as artes, a música era o que mais o atraía.	全ての芸術の中で、音楽が一番彼を惹きつけた。	\N		\N	vmod	\N	\N	\N	0	1
453	Comprei um livro sobre hístoria da pintura.	私は絵画（絵）の歴史についての本を一冊買った。	\N		\N	vmod	\N	\N	\N	0	1
454	Tirou bastantes fotografias na viagem.	彼・彼女は旅行でとてもたくさんの写真を撮った。	\N		\N	vmod	\N	\N	\N	0	1
456	De repente, ouviu uma voz a chamá-la.	突然彼女は自分を呼ぶ声を耳にした。	\N		\N	vmod	\N	\N	\N	0	1
457	Está bom tempo hoje.	今日は晴れ（良い天気）だ。	\N		\N	vmod	\N	\N	\N	0	1
458	Em Portugal, Julho e Agosto são os meses de maior calor.	ポルトガルでは、7月8月が一番暑い月だ。	\N		\N	vmod	\N	\N	\N	0	1
459	Hoje faz bom tempo.	今日は晴れている。	\N		\N	vmod	\N	\N	\N	0	1
460	Na Primavera, ainda há manhãs muito frescas.	春には、まだとても涼しい朝がある。	\N		\N	vmod	\N	\N	\N	0	1
461	Hoje está muito frio.	今日はとても寒い。	\N		\N	vmod	\N	\N	\N	0	1
462	Prevê-se para amanhã queda de neve nas terras altas do interior.	明日内陸部の標高の高い地域では降雪が予想されます。	\N		\N	vmod	\N	\N	\N	0	1
463	O céu cobre-se de nuvens escuras. Talvez chova amanhã.	空が黒い雲に覆われている、おそらく明日は雨だろう。	\N		\N	vmod	\N	\N	\N	0	1
464	Deixei a janela aberta, porque não imaginava que a chuva entrasse. Mas o chão  está todo molhado.	まさか雨が吹き込むとは思わなかったので、窓を開け放しにしてしまい、床はびしょぬれだ。	\N		\N	vmod	\N	\N	\N	0	1
465	A amenidade do clima e a beleza das paisagens fazem desta ilha um paraíso.	素晴らしい天気(気候）と美しい風景が、この島を天国のようにしている。	\N		\N	vmod	\N	\N	\N	0	1
466	Quando o tempo está frio vestem-se roupas quentes.	寒い（天気）の時には、暖かい服を着る。	\N		\N	vmod	\N	\N	\N	0	1
467	Soprou um vento quente.	あたたかい風が吹いた。	\N		\N	vmod	\N	\N	\N	0	1
468	O céu apresenta-se muito nublado e a chuva não tarda.	空はとても曇っていて（どんよりとしていて）、まもなく雨が降る。	\N		\N	vmod	\N	\N	\N	0	1
469	No Inverno , a comida fica fria num instante.	冬には、食べ物がすぐ冷たくなってしまう。	\N		\N	vmod	\N	\N	\N	0	1
470	O céu nublou-se ao fim da tarde.	夕方になると、空は曇った。	\N		\N	vmod	\N	\N	\N	0	1
471	Ele sabe muita quantidade de caracteres chineses.	彼は膨大な数の漢字を知っている。	\N		\N	vmod	\N	\N	\N	0	1
472	Disse obrigado e saiu.	彼はありがとうを言って出て行った。	\N		\N	vmod	\N	\N	\N	0	1
473	Como é que se escreve o seu nome?	あなたの名前はどう書くのですか？	\N		\N	vmod	\N	\N	\N	0	1
474	Ela sentiu-se sozinha e veio falar com alguém.	寂しくなったので、彼女は誰かと話をしにやって来た。	\N		\N	vmod	\N	\N	\N	0	1
475	Leu cuidadosamente cada palavra.	彼・彼女は注意深くそれぞれの言葉を読んだ。	\N		\N	vmod	\N	\N	\N	0	1
476	A língua portuguesa é a terceira língua europeia mais falada.	ポルトガル語は3番目に多く話されているヨーロッパの言語だ。	\N		\N	vmod	\N	\N	\N	0	1
477	Ninguém sabe a origem desta língua.	この言語の起源は誰も知らない。	\N		\N	vmod	\N	\N	\N	0	1
478	Ensinou o papagaio a falar.	彼・彼女はオウムに話すことを教えた。	\N		\N	vmod	\N	\N	\N	0	1
479	Escreveu um texto.	彼・彼女は文章を一つ書いた。	\N		\N	vmod	\N	\N	\N	0	1
480	Contou uma história de um homem riquíssimo.	彼・彼女は大金持ちの男の話を語った。	\N		\N	vmod	\N	\N	\N	0	1
481	Qual é o sentido desta palavra?	この語の意味は何ですか？	\N		\N	vmod	\N	\N	\N	0	1
484	No parque estava sentado um casal velho num banco.	公園のベンチに、一組の年老いた夫婦が座っていた。	\N		\N	vmod	\N	\N	\N	0	1
485	As crianças brincavam alegremente no jardim.	子供達は庭で楽しそうに遊んでいた。	\N		\N	vmod	\N	\N	\N	0	1
486	É a minha esposa.	（彼女は）私の妻です。	\N		\N	vmod	\N	\N	\N	0	1
487	As mulheres ficam em casa a cozinhar.	女たちは家にいて料理をしている。	\N		\N	vmod	\N	\N	\N	0	1
488	Os meninos gostam de brincar fora.	男の子達は外で遊ぶのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
489	Ele é pessoa de confiança.	彼は信用出来る人だ。	\N		\N	vmod	\N	\N	\N	0	1
490	Os homens jogam as cartas no café.	男たちはカフェでカードゲームをしている。	\N		\N	vmod	\N	\N	\N	0	1
520	Se calhar amanhã vai chover.	多分明日は雨が降るだろう。	\N	\N	\N		\N	\N	\N	0	1
521	"Eu não posso sair.""Então vou eu aí."	「僕は出られないな」「では僕がそちらに行こう」	\N	\N	\N		\N	\N	\N	0	1
9	Vou sair amanhã de manhã.	私は明日朝出掛ける。	\N		\N	vmod	\N	\N	\N	0	1
161	Em que estação é que desce?	どこの駅で降りるのですか？	\N		\N	vmod	\N	\N	\N	0	1
209	Chegou a casa tarde ontem à noite.	彼・彼女は昨晩遅くに帰宅した。	\N		\N	vmod	\N	\N	\N	0	1
352	Ele partiu os pratos de porcelana.	彼は磁器の皿を割ってしまった。	\N		\N	vmod	\N	\N	\N	0	1
455	Ela gosta de gatos.	彼女は猫が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
491	As meninas gostam de brincar em casa.	女の子達は家の中で遊ぶのが好きだ。	\N		\N	vmod	\N	\N	\N	0	1
492	O marido dela é muito simpático.	彼女の夫はとても感じが良い。	\N		\N	vmod	\N	\N	\N	0	1
493	As pessoas que viram o acidente disseram que a culpa era dele.	事故を目撃した人はみな、悪いのは彼だと言った。	\N		\N	vmod	\N	\N	\N	0	1
494	Todas as pessoas gostam dela.	みんな彼女が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
495	Ele tem os dentes brancos, porque não costuma fumar.	彼は（ふだん）タバコを吸わないので、白い歯を持っている（している）。	\N		\N	vmod	\N	\N	\N	0	1
496	A saia azul fica-lhe bem.	青いスカートは彼女によく似合う。	\N		\N	vmod	\N	\N	\N	0	1
497	Ele tem os olhos castanhos.	彼は茶色の瞳を持っている（している）。	\N		\N	vmod	\N	\N	\N	0	1
498	Este vestido claro ficará-lhe bem.	この明るい色の服は彼・彼女に似合うだろう。	\N		\N	vmod	\N	\N	\N	0	1
499	O vermelho e o branco são as cores nacionais japonesas.	赤と白は日本の国旗の色だ。	\N		\N	vmod	\N	\N	\N	0	1
500	Gosto da cor azul-escuro.	私は濃い青色（ダークブルー）が好きだ。	\N		\N	vmod	\N	\N	\N	0	1
501	Comprei as flores de cor de amarelo, mas não sei o nome.	私は黄色の花を買った。でも、（その花の）名前はわからない。	\N		\N	vmod	\N	\N	\N	0	1
502	Ele escreveu a carta a tinta preta.	彼は黒インクで手紙を書いた。	\N		\N	vmod	\N	\N	\N	0	1
503	Ela ficou vermelha com vergonha.	彼女は恥ずかしさに赤くなった。	\N		\N	vmod	\N	\N	\N	0	1
504	A cor verde significa esperança.	緑色は希望を意味する。	\N		\N	vmod	\N	\N	\N	0	1
505	Os transportes em Lisboa tornaram-se convenientes.	リスボンの交通は便利になった。	\N		\N	vmod	\N	\N	\N	0	1
506	Ele convidou-me à festa.	彼は私をパーティーに誘った。	\N		\N	vmod	\N	\N	\N	0	1
507	Ele apanhou duas folhas de papéis.	彼は紙を2枚つかんだ。	\N		\N	vmod	\N	\N	\N	0	1
508	A situação tornou-se difícil.	状況は困難になった。	\N		\N	vmod	\N	\N	\N	0	1
509	Apertem o cinto de segurança.	シートベルトを締めて下さい。	\N		\N	vmod	\N	\N	\N	0	1
510	Ele empurrou a porta da entrada.	彼は入り口の戸を押した。	\N		\N	vmod	\N	\N	\N	0	1
511	A época moderna começa com o descobrimento da América.	近代はアメリカの発見と共に始まる。	\N		\N	vmod	\N	\N	\N	0	1
512	A universidade fica mesmo no fim da alameda.	大学は並木道のちょうど終りにあります。	\N		\N	vmod	\N	\N	\N	0	1
513	Não há para comer.　	何も食べるものがない。	\N		\N	vmod	\N	\N	\N	0	1
514	Vamos pelo caminho mais directo.	もっとまっすぐな道を行こう。	\N		\N	vmod	\N	\N	\N	0	1
515	O Douro é uma região famosa pelo seu vinho.	ドウロはワインで有名な地方だ。	\N		\N	vmod	\N	\N	\N	0	1
516	Estou muito bem.	私はとても元気です。	\N		\N	vmod	\N	\N	\N	0	1
517	Então até amanhã.	じゃあまた明日。	\N		\N	vmod	\N	\N	\N	0	1
518	Se calhar amanhã choverá.	多分明日は雨が降るだろう。	\N		\N	vmod	\N	\N	\N	0	1
519	"Eu não posso sair.""Então vou eu aí."	「僕は出られないな」「では僕がそちらに行こう」	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: pt
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	1	行く	1	1
2	2	英語	1	1
3	3	飛行機	1	1
4	4	外国	1	1
5	5	外国人	1	1
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
19	19	上手（じょうず）	1	1
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
41	41	ワイシャツ	1	1
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
65	65	いくら	1	1
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
77	77	買い物する	1	1
78	78	洗濯する	1	1
79	79	掃除する	1	1
80	80	家族	1	1
81	81	家庭	1	1
82	82	庭（にわ）	1	1
83	83	洗濯	1	1
84	84	うち（家）	1	1
85	84	家（いえ）	1	1
86	85	掃除	1	1
87	86	かえる（帰・返）	1	1
88	87	本棚	1	1
89	88	机	1	1
90	89	椅子（いす）	1	1
91	90	部屋	1	1
92	91	冷蔵庫	1	1
93	78	洗う	1	1
94	92	ベッド	1	1
95	93	ラジオ	1	1
96	94	ラジカセ	1	1
97	95	～という名前です	1	1
98	96	寝る	1	1
99	97	起きる	1	1
100	98	テーブル	1	1
101	99	テレビ	1	1
102	100	お巡りさん	1	1
103	101	警官	1	1
104	102	地図	1	1
105	103	そば	1	1
106	104	ここ,こちら, こっち	1	1
107	105	そこ,そちら, そっち	1	1
108	106	あちら, あっち，あそこ	1	1
109	107	どこ,どちら,どっち	1	1
110	108	交番	1	1
111	109	近く	1	1
112	110	隣	1	1
113	111	きく	1	1
114	112	切る	1	1
115	113	短い	1	1
116	114	後ろ	1	1
117	115	前	1	1
118	116	右	1	1
119	117	左	1	1
120	118	長い	1	1
121	119	座る	1	1
122	120	立つ	1	1
123	121	友達	1	1
124	122	クラス	1	1
125	123	教室	1	1
126	124	廊下	1	1
127	125	学校	1	1
128	126	生徒	1	1
129	127	勉強	1	1
130	128	学生	1	1
131	129	留学生	1	1
132	130	夏休み	1	1
133	131	先生	1	1
134	132	大学	1	1
135	133	ノート	1	1
136	134	授業	1	1
137	135	作文	1	1
138	136	宿題	1	1
139	137	難しい	1	1
140	138	教える	1	1
141	139	テスト	1	1
142	140	練習	1	1
143	141	易しい	1	1
144	142	練習する	1	1
145	143	質問	1	1
146	144	問題	1	1
147	145	答える	1	1
148	146	痛い	1	1
149	147	歯	1	1
150	148	医者	1	1
151	149	病院	1	1
152	150	病気	1	1
153	151	薬（くすり）	1	1
154	152	死ぬ	1	1
155	153	風邪（かぜ）	1	1
156	154	頭（あたま）	1	1
157	155	お腹	1	1
158	156	度（ど）	1	1
159	157	エレベーター	1	1
160	158	切符	1	1
161	159	おりる	1	1
162	160	階段	1	1
163	161	閉める	1	1
164	162	駅	1	1
165	163	地下鉄	1	1
166	164	乗る	1	1
167	165	開ける	1	1
168	166	お手洗い	1	1
169	166	トイレ	1	1
170	167	電車	1	1
171	168	飲み物	1	1
172	169	コーヒー	1	1
173	169	喫茶店	1	1
174	170	レモン	1	1
175	171	牛乳	1	1
176	172	砂糖	1	1
177	173	カップ	1	1
178	174	お茶	1	1
179	175	紅茶	1	1
180	176	コップ	1	1
181	177	入れる	1	1
182	178	甘い	1	1
183	179	飲む	1	1
184	180	はし	1	1
185	181	酒	1	1
186	182	おいしい	1	1
187	183	ナイフ	1	1
188	184	スプーン	1	1
189	185	フォーク	1	1
190	186	チーズ	1	1
191	187	食べる	1	1
192	188	まずい	1	1
193	189	パン	1	1
194	190	辛い	1	1
195	191	レストラン	1	1
196	192	食堂	1	1
197	193	酒・ワイン	1	1
198	194	食べ物	1	1
199	195	カレー	1	1
200	196	お金	1	1
201	197	銀行	1	1
202	198	入り口	1	1
203	199	どうぞ,どういたしまして	1	1
204	200	いいえ	1	1
205	201	ええ	1	1
206	202	すみません	1	1
207	203	どうぞ	1	1
208	204	出口	1	1
209	205	着く	1	1
210	206	ポスト	1	1
211	207	はがき	1	1
212	208	張る	1	1
213	209	封筒	1	1
214	210	手紙	1	1
215	211	郵便局	1	1
216	212	返す	1	1
217	213	出す	1	1
218	214	切手	1	1
219	215	荷物	1	1
220	216	枚	1	1
221	217	貸す	1	1
222	77	買う	1	1
223	218	帽子	1	1
224	219	靴	1	1
225	220	買い物	1	1
226	23	階	1	1
227	221	デパート	1	1
228	222	スカート	1	1
229	43	コート	1	1
230	223	ズボン	1	1
231	224	セーター	1	1
232	225	…てください	1	1
233	226	かばん	1	1
234	227	売る	1	1
235	43	上着	1	1
236	228	ふろ	1	1
237	229	建物	1	1
238	76	台所	1	1
239	230	シャワー	1	1
240	231	窓	1	1
241	232	住む	1	1
242	233	公園	1	1
243	234	ドア	1	1
244	235	浴びる［一風呂～］	1	1
245	236	アパート	1	1
246	198	玄関	1	1
247	237	彼，彼女	1	1
248	238	彼ら，彼女たち	1	1
249	239	私（わたし）	1	1
250	240	私たち	1	1
251	241	だれか	1	1
252	242	だれ	1	1
253	242	どなた	1	1
254	243	きみ	1	1
255	244	あなた	1	1
256	245	この	1	1
257	246	その，あの	1	1
258	247	いかが，どう	1	1
259	248	どの	1	1
260	247	どんな	1	1
261	249	こんな	1	1
262	239	自分	1	1
263	249	そう	1	1
264	250	厚い	1	1
265	251	狭い	1	1
266	252	細い	1	1
267	253	大きい	1	1
268	250	太い	1	1
269	254	若い	1	1
270	255	広い	1	1
271	256	軽い	1	1
272	257	遠い	1	1
273	258	重い	1	1
274	252	薄い	1	1
275	254	新しい	1	1
276	259	小さい	1	1
277	103	近い	1	1
278	260	古い	1	1
279	261	楽しい	1	1
280	262	にぎやか	1	1
281	263	低い	1	1
282	264	よい	1	1
283	265	明るい	1	1
284	266	弱い	1	1
285	267	強い	1	1
286	268	おもしろい	1	1
287	269	きれい	1	1
288	21	遅い	1	1
289	270	悪い	1	1
290	271	多い	1	1
291	272	暗い	1	1
292	273	静か	1	1
293	274	少ない	1	1
294	275	汚い	1	1
295	276	つまらない	1	1
296	277	横	1	1
297	278	中（なか）	1	1
298	279	外（そと）	1	1
299	280	東（ひがし）	1	1
300	281	高さ	1	1
301	282	縦	1	1
302	283	北（きた）	1	1
303	284	西（にし）	1	1
304	263	下（した）	1	1
305	285	南（みなみ）	1	1
306	286	上（うえ）	1	1
307	115	先（さき）	1	1
308	114	後（あと）	1	1
309	287	いとこ	1	1
310	288	兄	1	1
311	289	兄弟（きょうだい）	1	1
312	290	おばあさん	1	1
313	291	おじいさん	1	1
314	292	奥さん	1	1
315	293	母	1	1
316	294	叔父，伯父	1	1
317	295	両親	1	1
318	296	父	1	1
319	297	姉	1	1
320	298	姉妹	1	1
321	299	叔母，伯母	1	1
322	288	お兄さん	1	1
323	297	お姉さん	1	1
324	300	お父さん	1	1
325	301	お母さん	1	1
326	302	靴下	1	1
327	41	シャツ	1	1
328	303	脱ぐ	1	1
329	304	架ける	1	1
330	305	は（穿）く［ズボンを～］	1	1
331	306	着る	1	1
332	307	かぶる	1	1
333	308	ハンカチ	1	1
334	309	スリッパ	1	1
335	310	傘	1	1
336	311	ポケット	1	1
337	312	財布	1	1
338	313	着ている	1	1
339	314	服	1	1
340	314	洋服	1	1
341	315	口	1	1
342	316	腕（うで）	1	1
343	317	体（からだ）	1	1
344	318	顔	1	1
345	319	脚（あし）	1	1
346	320	手（て）	1	1
347	321	鼻	1	1
348	322	目（め）	1	1
349	323	耳	1	1
350	324	足（あし）	1	1
351	155	おなか	1	1
352	325	皿（さら）	1	1
353	326	バター	1	1
354	327	茶わん	1	1
355	328	あめ	1	1
356	329	昼御飯	1	1
357	330	夕飯（ゆうはん）	1	1
358	178	お菓子	1	1
359	331	卵	1	1
360	332	朝御飯	1	1
361	333	御飯（ごはん）	1	1
362	334	醤油	1	1
363	335	塩（しお）	1	1
364	330	晩御飯	1	1
365	336	くわえる	1	1
366	208	つける	1	1
367	337	カメラ	1	1
368	338	ストーブ	1	1
369	339	鉛筆	1	1
370	340	消す	1	1
371	341	眼鏡（めがね）	1	1
372	342	テープレコーダー	1	1
373	343	時計	1	1
374	344	コンピュータ	1	1
375	345	フィルム	1	1
376	234	戸（と）	1	1
377	346	門（もん）	1	1
378	347	ペン	1	1
379	348	万年筆	1	1
380	347	ボールペン	1	1
381	349	八月	1	1
382	350	四月	1	1
383	351	今月	1	1
384	352	毎月（まいつき）	1	1
385	353	十二月	1	1
386	354	二月	1	1
387	355	一月	1	1
388	356	七月	1	1
389	357	六月	1	1
390	358	来月	1	1
391	359	五月	1	1
392	360	三月	1	1
393	361	先月	1	1
394	362	十一月	1	1
395	363	十月	1	1
396	364	九月	1	1
397	365	ひとつき	1	1
398	366	今週	1	1
399	367	毎週	1	1
400	368	日曜日	1	1
401	369	木曜日	1	1
402	370	来週	1	1
403	371	月曜日	1	1
404	372	火曜日	1	1
405	373	水曜日	1	1
406	374	土曜日	1	1
407	375	週間	1	1
408	376	先週	1	1
409	377	金曜日	1	1
410	378	年（ねん）	1	1
411	379	秋	1	1
412	380	今年（ことし）	1	1
413	381	毎年（まいとし）	1	1
414	382	夏（なつ）	1	1
415	383	冬	1	1
416	384	去年	1	1
417	385	来年	1	1
418	386	春	1	1
419	387	再来年	1	1
420	388	おととし	1	1
421	389	午後	1	1
422	390	今日（きょう）	1	1
423	391	明日（あした）	1	1
424	392	時（じ）	1	1
425	393	昨日（きのう）	1	1
426	394	夕べ	1	1
427	395	午前	1	1
428	395	朝	1	1
429	396	昼	1	1
430	397	夜（よる）	1	1
431	398	夕方	1	1
432	399	あさって	1	1
433	400	おととい	1	1
434	401	もう	1	1
435	402	ながら	1	1
436	403	まだ	1	1
437	404	中(ちゅう)	1	1
438	392	時（とき）	1	1
439	405	いつ	1	1
440	406	ときどき	1	1
441	407	しばしば	1	1
442	392	時間	1	1
443	401	すぐ	1	1
444	408	灰皿	1	1
445	409	歌（うた）	1	1
446	410	歌う	1	1
447	411	たばこ	1	1
448	412	映画	1	1
449	413	レコード	1	1
450	414	ギター	1	1
451	415	弾く	1	1
452	416	音楽	1	1
453	417	絵（え）	1	1
454	418	写真	1	1
455	419	好き，気に入る	1	1
456	420	声	1	1
457	421	晴れ	1	1
458	422	暑い	1	1
459	423	晴れる	1	1
460	424	涼しい	1	1
461	425	寒い	1	1
462	426	雪（ゆき）	1	1
463	427	雨が降る	1	1
464	428	雨（あめ）	1	1
465	429	天気	1	1
466	430	あたたかい（暖・温）	1	1
467	431	風（かぜ）	1	1
468	432	曇り	1	1
469	425	冷たい	1	1
470	433	曇る	1	1
471	434	漢字	1	1
472	435	言う	1	1
473	436	書く	1	1
474	437	話（はなし）	1	1
475	438	言葉	1	1
476	439	～語	1	1
477	440	語（ご）	1	1
478	441	話す	1	1
479	442	文章	1	1
480	443	語る	1	1
481	444	意味	1	1
482	445	大人（おとな）	1	1
483	446	大勢	1	1
484	447	夫婦	1	1
485	448	子供	1	1
486	292	妻	1	1
487	449	女（おんな）	1	1
488	450	男の子	1	1
489	451	人（ひと）	1	1
490	452	男（おとこ）	1	1
491	453	女の子	1	1
492	454	夫	1	1
493	451	人	1	1
494	455	みんな	1	1
495	456	白（しろ），白い	1	1
496	457	青，青い	1	1
497	458	茶色	1	1
498	265	明るい，淡い	1	1
499	459	色（いろ）	1	1
500	272	濃い，暗い	1	1
501	460	黄色（きいろ），黄色い	1	1
502	461	黒（くろ），黒い	1	1
503	462	赤，赤い	1	1
504	463	緑	1	1
505	464	便利	1	1
506	465	パーティー	1	1
507	466	紙	1	1
508	467	～になる	1	1
509	468	締める	1	1
510	469	押す	1	1
511	470	始まる	1	1
512	471	ちょうど	1	1
513	472	ない	1	1
514	473	まっすぐ	1	1
515	474	有名	1	1
516	475	元気	1	1
517	476	じゃあ	1	1
518	477	多分	1	1
519	476	では	1	1
6	6	ポルトガル語	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_usage_classified_rel (usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi) FROM stdin;
505	3472	1.1346	1.13	体	関係	様相	難易・安危	便利	便利	べんり
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
483	13006	1.191	1.19	体	関係	量	多少	大勢（おおぜい）	大勢	おおぜい
300	13195	1.1911	1.19	体	関係	量	長短・高低・深浅・厚薄・遠近	高さ	高さ	たかさ
494	14011	1.194	1.19	体	関係	量	一般・全体・部分	みんな	みんな	みんな
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
489	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
493	15353	1.2	1.20	体	主体	人間	人間	人（ひと）	人	ひと
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
490	15939	1.204	1.20	体	主体	人間	男女	男（おとこ）	男	おとこ
488	15944	1.204	1.20	体	主体	人間	男女	男の子	男の子	おとこのこ
487	15965	1.204	1.20	体	主体	人間	男女	女（おんな）	女	おんな
491	16081	1.205	1.20	体	主体	人間	老少	女の子	女の子	おんなのこ
485	16114	1.205	1.20	体	主体	人間	老少	子供	子供	こども
482	16184	1.205	1.20	体	主体	人間	老少	大人（おとな）	大人	おとな
313	16223	1.205	1.20	体	主体	人間	老少	おじいさん	おじいさん	おじいさん
312	16229	1.205	1.20	体	主体	人間	老少	おばあさん	おばあさん	おばあさん
80	16247	1.21	1.21	体	主体	家族	家族	家族	家族	かぞく
484	16331	1.211	1.21	体	主体	家族	夫婦	夫婦	夫婦	ふうふ
492	16343	1.211	1.21	体	主体	家族	夫婦	夫（おっと）	夫	おっと
486	16364	1.211	1.21	体	主体	家族	夫婦	妻（つま）	妻	つま
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
506	40795	1.351	1.35	体	活動	交わり	集会	パーティー	パーティー	ぱあてぃい
136	42954	1.364	1.36	体	活動	待遇	教育・養成	授業	授業	じゅぎょう
225	45301	1.3760999	1.37	体	活動	経済	売買	買い物	買い物	かいもの
83	47235	1.3841	1.38	体	活動	事業	染色・洗濯など	洗濯	洗濯	せんたく
86	47401	1.3843	1.38	体	活動	事業	掃除など	掃除	掃除	そうじ
219	48148	1.403	1.40	体	生産物	物品	荷・包み	荷物	荷物	にもつ
200	48177	1.404	1.40	体	生産物	物品	貨幣・切符・証券	お金	お金	おかね
160	48231	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切符	切符	きっぷ
218	48275	1.404	1.40	体	生産物	物品	貨幣・切符・証券	切手	切手	きって
507	48362	1.411	1.41	体	生産物	資材	紙	紙（かみ）	紙	かみ
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
159	56712	1.465	1.46	体	生産物	機械	乗り物（陸上）	エレベーター	エレベーター	えれべえたあ
3	56868	1.467	1.46	体	生産物	機械	乗り物（空中・宇宙）	飛行機	飛行機	ひこうき
82	57040	1.47	1.47	体	生産物	土地利用	地類（土地利用）	庭（にわ）	庭	にわ
33	57152	1.471	1.47	体	生産物	土地利用	道路・橋	道（みち）	道	みち
32	57316	1.471	1.47	体	生産物	土地利用	道路・橋	交差点	交差点	こうさてん
499	57861	1.502	1.50	体	自然	自然	色	色（いろ）	色	いろ
502	57943	1.502	1.50	体	自然	自然	色	黒（くろ）	黒	くろ
503	57967	1.502	1.50	体	自然	自然	色	赤	赤	あか
497	58007	1.502	1.50	体	自然	自然	色	茶色	茶色	ちゃいろ
501	58033	1.502	1.50	体	自然	自然	色	黄色（きいろ）	黄色	きいろ
504	58041	1.502	1.50	体	自然	自然	色	緑	緑	みどり
496	58059	1.502	1.50	体	自然	自然	色	青	青	あお
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
508	67104	2.1112001	2.11	用	関係	類	因果	なる［…に～・…ことに～］	なる	なる
217	67613	2.1210001	2.12	用	関係	存在	出没	出す	出す	だす
99	67762	2.1210999	2.12	用	関係	存在	発生・復活	起きる	起きる	おきる
370	68092	2.125	2.12	用	関係	存在	消滅	消す	消す	けす
509	68583	2.1341	2.13	用	関係	様相	弛緩・粗密・繁簡	しめる（締・絞）	しめる	しめる
510	68797	2.1400001	2.14	用	関係	力	力	押す	押す	おす
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
511	74751	2.1651001	2.16	用	関係	時間	終始	始まる	始まる	はじまる
446	76527	2.3031001	2.30	用	活動	心	声	歌う	歌う	うたう
436	93503	3.1670001	3.16	相	関係	時間	時間的前後	まだ	まだ	まだ
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
512	91162	3.1129999	3.11	相	関係	類	異同・類似	ちょうど	ちょうど	ちょうど
513	91248	3.1199999	3.12	相	関係	存在	存在	ない	ない	ない
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
434	93515	3.1670001	3.16	相	関係	時間	時間的前後	もう	もう	もう
443	93581	3.1671	3.16	相	関係	時間	即時	すぐ	すぐ	すぐ
435	93640	3.1671	3.16	相	関係	時間	即時	－ながら	－ながら	ながら
514	93723	3.1800001	3.18	相	関係	形	形	まっすぐ	まっすぐ	まっすぐ
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
515	97137	3.3141999	3.31	相	活動	言語	評判	有名	有名	ゆうめい
49	97485	3.332	3.33	相	活動	生活	労働・作業・休暇	忙（いそが）しい	忙しい	いそがしい
516	98390	3.3429999	3.34	相	活動	行為	行為・活動	元気	元気	げんき
61	98904	3.3710001	3.37	相	活動	経済	経済・収支	安い	安い	やすい
283	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
498	98991	3.5009999	3.50	相	自然	自然	光	明るい	明るい	あかるい
291	99001	3.5009999	3.50	相	自然	自然	光	暗い	暗い	くらい
495	99105	3.5020001	3.50	相	自然	自然	色	白い	白い	しろい
292	99157	3.503	3.50	相	自然	自然	音	静か	静か	しずか
280	99217	3.503	3.50	相	自然	自然	音	にぎやか	にぎやか	にぎやか
186	99489	3.5050001	3.50	相	自然	自然	味	おいしい	おいしい	おいしい
192	99491	3.5050001	3.50	相	自然	自然	味	まずい	まずい	まずい
182	99501	3.5050001	3.50	相	自然	自然	味	甘い	甘い	あまい
194	99511	3.5050001	3.50	相	自然	自然	味	辛（から）い	辛い	からい
500	99575	3.506	3.50	相	自然	自然	材質	濃い	濃い	こい
469	99848	3.517	3.51	相	自然	物質	熱	冷たい	冷たい	つめたい
466	99853	3.517	3.51	相	自然	物質	熱	あたたかい（暖・温）	あたたかい	あたたかい
517	100235	4.112	4.11	他		接続	展開	じゃあ	じゃあ	じゃあ
206	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
518	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
207	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
519	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	1	1	0		0	\N	0
2	2	2	0		0	\N	0
3	3	3	0		0	\N	0
4	4	4	0		0	\N	0
5	5	5	0		0	\N	0
6	6	6	0		0	\N	0
7	7	7	0		0	\N	0
8	8	8	0		0	\N	0
9	9	9	0		0	\N	0
10	10	10	0		0	\N	0
11	11	11	0		0	\N	0
12	12	12	0		0	\N	0
13	13	13	0		0	\N	0
14	14	14	0		0	\N	0
15	15	15	0		0	\N	0
16	16	16	0		0	\N	0
17	17	17	0		0	\N	0
18	18	18	0		0	\N	0
19	19	19	0		0	\N	0
20	20	20	0		0		0
21	21	21	0		0	\N	0
22	22	22	0		0		0
23	23	23	0		0	\N	0
24	24	24	0		0	\N	0
25	25	25	0		0	\N	0
26	26	26	0		0	\N	0
27	27	27	0		0	\N	0
28	28	28	0		0		0
29	29	29	0		0	\N	0
30	30	30	0		0	\N	0
31	31	31	0		0	\N	0
32	32	32	0		0	\N	0
33	33	33	0		0	\N	0
34	34	34	0		0	\N	0
35	35	35	0		0	\N	0
36	36	36	0		0	\N	0
37	37	37	0		0	\N	0
38	38	38	0		0	\N	0
39	39	39	0		0	\N	0
40	40	40	0		0	\N	0
41	41	41	0		0	\N	0
42	42	42	0		0	\N	0
43	43	43	0		0	\N	0
44	44	44	0		0	\N	0
45	45	45	0		0	\N	0
46	46	46	0		0	\N	0
47	47	47	0		0	\N	0
48	48	48	0		0	\N	0
49	49	49	0		0	\N	0
50	50	50	0		0	\N	0
51	51	51	0		0	\N	0
52	52	52	0		0	\N	0
53	53	53	0		0	\N	0
54	54	54	0		0	\N	0
55	55	55	0		0	\N	0
56	56	56	0		0	\N	0
57	57	57	0		0	\N	0
58	58	58	0		0	\N	0
59	59	59	0		0	\N	0
60	60	60	0		0	\N	0
61	61	61	0		0		0
62	62	62	0		0	\N	0
63	63	63	0		0	\N	0
64	64	64	0		0	\N	0
65	65	65	0		0	\N	0
66	66	66	0		0	\N	0
67	67	67	0		0	\N	0
68	68	68	0		0	\N	0
69	69	69	0		0	\N	0
70	70	70	0		0	\N	0
71	71	71	0		0		0
72	72	72	0		0	\N	0
73	73	73	0		0	\N	0
74	74	74	0		0	\N	0
75	75	75	0		0	\N	0
76	76	76	0		0	\N	0
77	77	77	0		0	\N	0
78	78	78	0		0	\N	0
79	79	79	0		0	\N	0
80	80	80	0		0	\N	0
81	81	81	0		0	\N	0
82	82	82	0		0	\N	0
83	83	83	0		0	\N	0
84	84	84	0		0	\N	0
85	85	85	0		0	\N	0
86	86	86	0		0	\N	0
87	87	87	0		0	\N	0
88	88	88	0		0	\N	0
89	89	89	0		0	\N	0
90	90	90	0		0	\N	0
91	91	91	0		0	\N	0
92	92	92	0		0	\N	0
93	93	93	0		0	\N	0
94	94	94	0		0		0
95	95	95	0		0	\N	0
96	96	96	0		0		0
97	97	97	0		0	\N	0
98	98	98	0		0	\N	0
99	99	99	0		0		0
100	100	100	0		0	\N	0
101	101	101	0		0	\N	0
102	102	102	0		0	\N	0
103	103	103	0		0	\N	0
104	104	104	0		0	\N	0
105	105	105	0		0	\N	0
106	106	106	0		0	\N	0
107	107	107	0		0	\N	0
108	108	108	0		0	\N	0
109	109	109	0		0	\N	0
110	110	110	0		0	\N	0
111	111	111	0		0	\N	0
112	112	112	0		0	\N	0
113	113	113	0		0	\N	0
114	114	114	0		0	\N	0
115	115	115	0		0	\N	0
116	116	116	0		0	\N	0
117	117	117	0		0	\N	0
118	118	118	0		0	\N	0
119	119	119	0		0	\N	0
120	120	120	0		0	\N	0
121	121	121	0		0	\N	0
122	122	122	0		0	\N	0
123	123	123	0		0	\N	0
124	124	124	0		0	\N	0
125	125	125	0		0	\N	0
126	126	126	0		0	\N	0
127	127	127	0		0	\N	0
128	128	128	0		0	\N	0
129	129	129	0		0	\N	0
130	130	130	0		0	\N	0
131	131	131	0		0	\N	0
132	132	132	0		0	\N	0
133	133	133	0		0	\N	0
134	134	134	0		0	\N	0
135	135	135	0		0	\N	0
136	136	136	0		0	\N	0
137	137	137	0		0	\N	0
138	138	138	0		0		0
139	139	139	0		0	\N	0
140	140	140	0		0	\N	0
141	141	141	0		0	\N	0
142	142	142	0		0	\N	0
143	143	143	0		0	\N	0
144	144	144	0		0		0
145	145	145	0		0	\N	0
146	146	146	0		0	\N	0
147	147	147	0		0	\N	0
148	148	148	0		0	\N	0
149	149	149	0		0		0
150	150	150	0		0		0
151	151	151	0		0	\N	0
152	152	152	0		0	\N	0
153	153	153	0		0	\N	0
154	154	154	0		0	\N	0
155	155	155	0		0	\N	0
156	156	156	0		0	\N	0
157	157	157	0		0	\N	0
158	158	158	0		0	\N	0
159	159	159	0		0	\N	0
160	160	160	0		0	\N	0
161	161	161	0		0	\N	0
162	162	162	0		0	\N	0
163	163	163	0		0	\N	0
164	164	164	0		0	\N	0
165	165	165	0		0	\N	0
166	166	166	0		0	\N	0
167	167	167	0		0	\N	0
168	168	168	0		0	\N	0
169	169	169	0		0	\N	0
170	170	170	0		0	\N	0
171	171	171	0		0	\N	0
172	172	172	0		0	\N	0
173	173	173	0		0	\N	0
174	174	174	0		0	\N	0
175	175	175	0		0		0
176	176	176	0		0	\N	0
177	177	177	0		0	\N	0
178	178	178	0		0	\N	0
179	179	179	0		0	\N	0
180	180	180	0		0	\N	0
181	181	181	0		0	\N	0
182	182	182	0		0	\N	0
183	183	183	0		0	\N	0
184	184	184	0		0	\N	0
185	185	185	0		0	\N	0
186	186	186	0		0	\N	0
187	187	187	0		0		0
188	188	188	0		0	\N	0
189	189	189	0		0	\N	0
190	190	190	0		0	\N	0
191	191	191	0		0	\N	0
192	192	192	0		0	\N	0
193	193	193	0		0	\N	0
194	194	194	0		0		0
195	195	195	0		0	\N	0
196	196	196	0		0	\N	0
197	197	197	0		0		0
198	198	198	0		0		0
199	199	199	0		0	\N	0
200	200	200	0		0	\N	0
201	201	201	0		0	\N	0
202	202	202	0		0		0
203	203	203	0		0	\N	0
204	204	204	0		0	\N	0
205	205	205	0		0	\N	0
206	206	206	0		0		0
207	207	207	0		0		0
208	208	208	0		0	\N	0
209	209	209	0		0	\N	0
210	210	210	0		0	\N	0
211	211	211	0		0		0
212	212	212	0		0	\N	0
213	213	213	0		0	\N	0
214	214	214	0		0	\N	0
215	215	215	0		0	\N	0
216	216	216	0		0	\N	0
217	217	217	0		0	\N	0
218	218	218	0		0		0
219	219	219	0		0	\N	0
220	220	220	0		0		0
221	221	221	0		0	\N	0
222	222	222	0		0		0
223	223	223	0		0	\N	0
224	224	224	0		0	\N	0
225	225	225	0		0	\N	0
226	226	226	0		0	\N	0
227	227	227	0		0		0
228	228	228	0		0	\N	0
229	229	229	0		0	\N	0
230	230	230	0		0	\N	0
231	231	231	0		0	\N	0
232	232	232	0		0	\N	0
233	233	233	0		0	\N	0
234	234	234	0		0	\N	0
235	235	235	0		0	\N	0
236	236	236	0		0	\N	0
237	237	237	0		0	\N	0
238	238	238	0		0	\N	0
239	239	239	0		0	\N	0
240	240	240	0		0	\N	0
241	241	241	0		0	\N	0
242	242	242	0		0	\N	0
243	243	243	0		0		0
244	244	244	0		0	\N	0
245	245	245	0		0	\N	0
246	246	246	0		0	\N	0
247	247	247	0		0	\N	0
248	248	248	0		0	\N	0
249	249	249	0		0	\N	0
250	250	250	0		0	\N	0
251	251	251	0		0	\N	0
252	252	252	0		0	\N	0
253	253	253	0		0	\N	0
254	254	254	0		0	\N	0
255	255	255	0		0	\N	0
256	256	256	0		0	\N	0
257	257	257	0		0	\N	0
258	258	258	0		0	\N	0
259	259	259	0		0	\N	0
260	260	260	0		0	\N	0
261	261	261	0		0	\N	0
262	262	262	0		0	\N	0
263	263	263	0		0	\N	0
264	264	264	0		0	\N	0
265	265	265	0		0	\N	0
266	266	266	0		0	\N	0
267	267	267	0		0	\N	0
268	268	268	0		0	\N	0
269	269	269	0		0	\N	0
270	270	270	0		0	\N	0
271	271	271	0		0	\N	0
272	272	272	0		0	\N	0
273	273	273	0		0	\N	0
274	274	274	0		0	\N	0
275	275	275	0		0	\N	0
276	276	276	0		0	\N	0
277	277	277	0		0	\N	0
278	278	278	0		0	\N	0
279	279	279	0		0	\N	0
280	280	280	0		0	\N	0
281	281	281	0		0	\N	0
282	282	282	0		0	\N	0
283	283	283	0		0	\N	0
284	284	284	0		0	\N	0
285	285	285	0		0	\N	0
286	286	286	0		0	\N	0
287	287	287	0		0	\N	0
288	288	288	0		0	\N	0
289	289	289	0		0	\N	0
290	290	290	0		0	\N	0
291	291	291	0		0	\N	0
292	292	292	0		0	\N	0
293	293	293	0		0	\N	0
294	294	294	0		0	\N	0
295	295	295	0		0	\N	0
296	296	296	0		0	\N	0
297	297	297	0		0	\N	0
298	298	298	0		0	\N	0
299	299	299	0		0	\N	0
300	300	300	0		0	\N	0
301	301	301	0		0	\N	0
302	302	302	0		0	\N	0
303	303	303	0		0	\N	0
304	304	304	0		0	\N	0
305	305	305	0		0	\N	0
306	306	306	0		0	\N	0
307	307	307	0		0	\N	0
308	308	308	0		0	\N	0
309	309	309	0		0	\N	0
310	310	310	0		0	\N	0
311	311	311	0		0		0
312	312	312	0		0	\N	0
313	313	313	0		0	\N	0
314	314	314	0		0	\N	0
315	315	315	0		0	\N	0
316	316	316	0		0	\N	0
317	317	317	0		0	\N	0
318	318	318	0		0	\N	0
319	319	319	0		0	\N	0
320	320	320	0		0	\N	0
321	321	321	0		0	\N	0
322	322	322	0		0	\N	0
323	323	323	0		0	\N	0
324	324	324	0		0	\N	0
325	325	325	0		0		0
326	326	326	0		0	\N	0
327	327	327	0		0	\N	0
328	328	328	0		0	\N	0
329	329	329	0		0	\N	0
330	330	330	0		0	\N	0
331	331	331	0		0	\N	0
332	332	332	0		0	\N	0
333	333	333	0		0	\N	0
334	334	334	0		0	\N	0
335	335	335	0		0	\N	0
336	336	336	0		0	\N	0
337	337	337	0		0	\N	0
338	338	338	0		0	\N	0
339	339	339	0		0	\N	0
340	340	340	0		0	\N	0
341	341	341	0		0	\N	0
342	342	342	0		0	\N	0
343	343	343	0		0	\N	0
344	344	344	0		0	\N	0
345	345	345	0		0	\N	0
346	346	346	0		0	\N	0
347	347	347	0		0	\N	0
348	348	348	0		0	\N	0
349	349	349	0		0	\N	0
350	350	350	0		0	\N	0
351	351	351	0		0	\N	0
352	352	352	0		0	\N	0
353	353	353	0		0	\N	0
354	354	354	0		0	\N	0
355	355	355	0		0		0
356	356	356	0		0	\N	0
357	357	357	0		0	\N	0
358	358	358	0		0	\N	0
359	359	359	0		0		0
360	360	360	0		0		0
361	361	361	0		0	\N	0
362	362	362	0		0	\N	0
363	363	363	0		0		0
364	364	364	0		0	\N	0
365	365	365	0		0	\N	0
366	366	366	0		0	\N	0
367	367	367	0		0	\N	0
368	368	368	0		0	\N	0
369	369	369	0		0	\N	0
370	370	370	0		0	\N	0
371	371	371	0		0		0
372	372	372	0		0	\N	0
373	373	373	0		0	\N	0
374	374	374	0		0		0
375	375	375	0		0	\N	0
376	376	376	0		0	\N	0
377	377	377	0		0	\N	0
378	378	378	0		0	\N	0
379	379	379	0		0	\N	0
380	380	380	0		0	\N	0
381	381	381	0		0		0
382	382	382	0		0	\N	0
383	383	383	0		0	\N	0
384	384	384	0		0	\N	0
385	385	385	0		0	\N	0
386	386	386	0		0		0
387	387	387	0		0	\N	0
388	388	388	0		0	\N	0
389	389	389	0		0	\N	0
390	390	390	0		0	\N	0
391	391	391	0		0	\N	0
392	392	392	0		0	\N	0
393	393	393	0		0		0
394	394	394	0		0	\N	0
395	395	395	0		0	\N	0
396	396	396	0		0	\N	0
397	397	397	0		0	\N	0
398	398	398	0		0	\N	0
399	399	399	0		0	\N	0
400	400	400	0		0		0
401	401	401	0		0	\N	0
402	402	402	0		0	\N	0
403	403	403	0		0	\N	0
404	404	404	0		0	\N	0
405	405	405	0		0	\N	0
406	406	406	0		0		0
407	407	407	0		0	\N	0
408	408	408	0		0	\N	0
409	409	409	0		0	\N	0
410	410	410	0		0	\N	0
411	411	411	0		0	\N	0
412	412	412	0		0	\N	0
413	413	413	0		0	\N	0
414	414	414	0		0	\N	0
415	415	415	0		0	\N	0
416	416	416	0		0	\N	0
417	417	417	0		0	\N	0
418	418	418	0		0	\N	0
419	419	419	0		0	\N	0
420	420	420	0		0	\N	0
421	421	421	0		0	\N	0
422	422	422	0		0	\N	0
423	423	423	0		0	\N	0
424	424	424	0		0	\N	0
425	425	425	0		0	\N	0
426	426	426	0		0	\N	0
427	427	427	0		0	\N	0
428	428	428	0		0	\N	0
429	429	429	0		0	\N	0
430	430	430	0		0	\N	0
431	431	431	0		0	\N	0
432	432	432	0		0	\N	0
433	433	433	0		0	\N	0
434	434	434	0		0	\N	0
435	435	435	0		0	\N	0
436	436	436	0		0	\N	0
437	437	437	0		0	\N	0
438	438	438	0		0	\N	0
439	439	439	0		0	\N	0
440	440	440	0		0	\N	0
441	441	441	0		0	\N	0
442	442	442	0		0	\N	0
443	443	443	0		0	\N	0
444	444	444	0		0	\N	0
445	445	445	0		0	\N	0
446	446	446	0		0	\N	0
447	447	447	0		0	\N	0
448	448	448	0		0	\N	0
449	449	449	0		0	\N	0
450	450	450	0		0	\N	0
451	451	451	0		0	\N	0
452	452	452	0		0	\N	0
453	453	453	0		0	\N	0
454	454	454	0		0		0
455	455	455	0		0	\N	0
456	456	456	0		0	\N	0
457	457	457	0		0	\N	0
458	458	458	0		0	\N	0
459	459	459	0		0	\N	0
460	460	460	0		0	\N	0
461	461	461	0		0	\N	0
462	462	462	0		0	\N	0
463	463	463	0		0	\N	0
464	464	464	0		0	\N	0
465	465	465	0		0	\N	0
466	466	466	0		0	\N	0
467	467	467	0		0	\N	0
468	468	468	0		0	\N	0
469	469	469	0		0	\N	0
470	470	470	0		0	\N	0
471	471	471	0		0	\N	0
472	472	472	0		0	\N	0
473	473	473	0		0	\N	0
474	474	474	0		0	\N	0
475	475	475	0		0	\N	0
476	476	476	0		0	\N	0
477	477	477	0		0	\N	0
478	478	478	0		0	\N	0
479	479	479	0		0	\N	0
480	480	480	0		0	\N	0
481	481	481	0		0	\N	0
482	482	482	0		0	\N	0
483	483	483	0		0	\N	0
484	484	484	0		0	\N	0
485	485	485	0		0	\N	0
486	486	486	0		0	\N	0
487	487	487	0		0	\N	0
488	488	488	0		0	\N	0
489	489	489	0		0	\N	0
490	490	490	0		0	\N	0
491	491	491	0		0	\N	0
492	492	492	0		0	\N	0
493	493	493	0		0		0
494	494	494	0		0	\N	0
495	495	495	0		0	\N	0
496	496	496	0		0	\N	0
497	497	497	0		0	\N	0
498	498	498	0		0	\N	0
499	499	499	0		0	\N	0
500	500	500	0		0	\N	0
501	501	501	0		0	\N	0
502	502	502	0		0		0
503	503	503	0		0	\N	0
504	504	504	0		0	\N	0
505	505	505	0		0	\N	0
506	506	506	0		0	\N	0
507	507	507	0		0	\N	0
508	508	508	0		0	\N	0
509	509	509	0		0	\N	0
510	510	510	0		0		0
511	511	511	0		0	\N	0
512	512	512	0		0	\N	0
513	513	513	0		0	\N	0
514	514	514	0		0	\N	0
515	515	515	0		0		0
516	516	516	0		0	\N	0
517	517	517	0		0	\N	0
518	518	518	0		0	\N	0
519	519	519	0		0	\N	0
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: pt
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
493	38
494	38
495	39
496	39
497	39
498	39
499	39
500	39
501	39
502	39
503	39
504	39
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
56	fotocópia	1	F	0
57	tirar fotocópia	1	T	0
58	revista	1	R	0
59	volume	1	V	0
60	carne de vaca	1	C	0
61	barato	1	B	0
62	loja	1	L	0
63	caro	1	C	0
64	quanto	1	Q	0
65	quanto custa	1	Q	0
66	fruta	1	F	0
67	legume	1	L	0
68	peixe	1	P	0
69	carne de porco	1	C	0
70	frango	1	F	0
71	carne	1	C	0
72	querer	1	Q	0
73	entregar	1	E	0
74	quitanda	1	Q	0
75	chave	1	C	0
76	cozinha	1	C	0
77	comprar	1	C	0
78	lavar	1	L	0
79	limpar	1	L	0
80	família	1	F	0
81	lar	1	L	0
82	jardim 	1	J	0
83	lavagem	1	L	0
84	casa	1	C	0
85	limpeza	1	L	0
86	voltar	1	V	0
87	estante	1	E	0
88	escritório	1	E	0
89	cadeira	1	C	0
90	quarto	1	Q	0
91	frigorífico	1	F	0
92	cama	1	C	0
93	rádio	1	R	0
94	rádio-cassete	1	R	0
95	chamar-se	1	C	0
96	dormir	1	D	0
97	acordar	1	A	0
98	mesa	1	M	0
99	televisão	1	T	0
100	polícia	1	P	0
101	policial	1	P	0
102	mapa	1	M	0
103	perto	1	P	0
104	aqui	1	A	0
105	aí　	1	A	0
106	ali	1	A	0
107	onde	1	O	0
108	posto policial	1	P	0
109	próximo	1	P	0
110	contíguo	1	C	0
111	perguntar	1	P	0
112	cortar	1	C	0
113	curto	1	C	0
114	atrás	1	A	0
115	frente	1	F	0
116	direita	1	D	0
117	esquerda	1	E	0
118	comprido	1	C	0
119	sentar-se	1	S	0
120	levantar-se	1	L	0
121	amigo	1	A	0
122	turma	1	T	0
123	sala (de aula)	1	S	0
124	corredor	1	C	0
125	escola	1	E	0
126	aluno	1	A	0
127	estudo	1	E	0
128	estudante	1	E	0
129	estudante estrangeiro	1	E	0
130	férias no verão	1	F	0
131	professor	1	P	0
132	universidade	1	U	0
133	caderno	1	C	0
134	aula	1	A	0
135	composição	1	C	0
136	trabalho de casa	1	T	0
137	difícil	1	D	0
138	ensinar	1	E	0
139	exame	1	E	0
140	prática	1	P	0
141	fácil	1	F	0
142	praticar	1	P	0
143	pergunta	1	P	0
144	questão	1	Q	0
145	responder	1	R	0
146	doer-se	1	D	0
147	dente	1	D	0
148	médico	1	M	0
149	hospital	1	H	0
150	doença	1	D	0
151	remédio	1	R	0
152	morrer	1	M	0
153	constipação	1	C	0
154	cabeça	1	C	0
155	barriga	1	B	0
156	grau	1	G	0
157	elevador	1	E	0
158	bilhete	1	B	0
159	descer	1	D	0
160	escada	1	E	0
161	fechar	1	F	0
162	estação	1	E	0
163	metro	1	M	0
164	apanhar	1	A	0
165	abrir	1	A	0
166	casa de banho	1	C	0
167	comboio	1	C	0
168	bebida	1	B	0
169	café	1	C	0
170	limão	1	L	0
171	leite	1	L	0
172	açúcar	1	A	0
173	chávena	1	C	0
174	chá　	1	C	0
175	chá preto	1	C	0
176	copo	1	C	0
177	pôr　	1	P	0
178	doce	1	D	0
179	beber	1	B	0
180	pauzinhos	1	P	0
181	álcool	1	A	0
182	bom	1	B	0
183	faca	1	F	0
184	colher	1	C	0
185	garfo	1	G	0
186	queijo	1	Q	0
187	comer	1	C	0
188	mau	1	M	0
189	pão	1	P	0
190	picante	1	P	0
191	restaurante	1	R	0
192	cantina	1	C	0
193	bebida alcoólica	1	B	0
194	comida	1	C	0
195	caril	1	C	0
196	dinheiro	1	D	0
197	banco	1	B	0
198	entrada	1	E	0
199	por favor, de nada	1	P	0
200	não	1	N	0
201	sim	1	S	0
202	com licença	1	C	0
203	faça favor	1	F	0
204	saída	1	S	0
205	chegar	1	C	0
206	caixa do correiro	1	C	0
207	cartão postal	1	C	0
208	colar	1	C	0
209	envelope	1	E	0
210	carta	1	C	0
211	correio	1	C	0
212	devolver	1	D	0
213	enviar	1	E	0
214	selo	1	S	0
215	bagagem	1	B	0
216	folha	1	F	0
217	emprestar	1	E	0
218	chapéu	1	C	0
219	sapato(s)	1	S	0
220	compra	1	C	0
221	centro comercial	1	C	0
222	saia	1	S	0
223	calça	1	C	0
224	camisola	1	C	0
225	poderia (fazer) …	1	P	0
226	mala	1	M	0
227	vender	1	V	0
228	banho	1	B	0
229	edifício	1	E	0
230	chuveiro	1	C	0
231	janela	1	J	0
232	morar	1	M	0
233	parque	1	P	0
234	porta	1	P	0
235	tomar banho	1	T	0
236	apartamento	1	A	0
237	ele, ela	1	E	0
238	eles, elas	1	E	0
239	eu	1	E	0
240	nós	1	N	0
241	alguém	1	A	0
242	quem	1	Q	0
243	tu	1	T	0
244	você	1	V	0
245	este	1	E	0
246	aquele	1	A	0
247	como	1	C	0
248	qual	1	Q	0
249	assim	1	A	0
250	grosso	1	G	0
251	estreito	1	E	0
252	fino	1	F	0
253	grande	1	G	0
254	novo	1	N	0
255	largo	1	L	0
256	leve	1	L	0
257	longe	1	L	0
258	pesado	1	P	0
259	pequeno	1	P	0
260	velho	1	V	0
261	alegre	1	A	0
262	animado	1	A	0
263	baixo	1	B	0
264	bom・boa	1	B	0
265	claro	1	C	0
266	fraco	1	F	0
267	forte	1	F	0
268	interessante	1	I	0
269	bonito	1	B	0
270	mau・má	1	M	0
271	muito	1	M	0
272	escuro	1	E	0
273	silencioso	1	S	0
274	pouco	1	P	0
275	sujo	1	S	0
276	chato	1	C	0
277	lado	1	L	0
278	dentro	1	D	0
279	fora	1	F	0
280	leste	1	L	0
281	altura	1	A	0
282	vertical	1	V	0
283	norte	1	N	0
284	oeste	1	O	0
285	sul	1	S	0
286	cima	1	C	0
287	primo	1	P	0
288	irmão mais velho	1	I	0
289	irmão	1	I	0
290	avó	1	A	0
291	avô　	1	A	0
292	esposa	1	E	0
293	mãe	1	M	0
294	tio	1	T	0
295	meus pais	1	M	0
296	pai	1	P	0
297	irmã mais velha	1	I	0
298	irmã	1	I	0
299	tia	1	T	0
300	papá	1	P	0
301	mamã	1	M	0
302	meia(s)	1	M	0
303	despir(-se)	1	D	0
304	pendurar	1	P	0
305	calçar	1	C	0
306	vestir(-se)	1	V	0
307	cobrir-se	1	C	0
308	lenço	1	L	0
309	chinelo(s)	1	C	0
310	guarda-chuva	1	G	0
311	bolso	1	B	0
312	carteira	1	C	0
313	vestido	1	V	0
314	roupa	1	R	0
315	boca	1	B	0
316	braço	1	B	0
317	corpo	1	C	0
318	cara	1	C	0
319	perna(s)	1	P	0
320	mão(s)	1	M	0
321	nariz	1	N	0
322	olho(s)	1	O	0
323	orelha(s)	1	O	0
324	pé(s)	1	P	0
325	prato	1	P	0
326	manteiga	1	M	0
327	tigela	1	T	0
328	rebuçados	1	R	0
329	almoço	1	A	0
330	jantar	1	J	0
331	ovo	1	O	0
332	pequeno almoço	1	P	0
333	refeição  	1	R	0
334	molho de soja	1	M	0
335	sal	1	S	0
336	juntar	1	J	0
337	máquina fotográfica	1	M	0
338	aquecedor	1	A	0
339	lápis	1	L	0
340	apagar	1	A	0
341	óculo(s)	1	O	0
342	gravador de fita	1	G	0
343	relógio	1	R	0
344	computador	1	C	0
345	filme	1	F	0
346	portão	1	P	0
347	caneta	1	C	0
348	caneta-tinteiro	1	C	0
349	agosto	1	A	0
350	abril	1	A	0
351	este mês	1	E	0
352	todos os meses	1	T	0
353	dezembro	1	D	0
354	fevereiro	1	F	0
355	janeiro	1	J	0
356	julho	1	J	0
357	junho	1	J	0
358	próximo mês	1	P	0
359	maio	1	M	0
360	março	1	M	0
361	mês passado	1	M	0
362	novembro	1	N	0
363	outubro	1	O	0
364	setembro	1	S	0
365	um mês	1	U	0
366	esta semana	1	E	0
367	todas as semanas	1	T	0
368	domingo	1	D	0
369	quinta-feira	1	Q	0
370	próxima semana	1	P	0
371	segunda-feira	1	S	0
372	terça-feira	1	T	0
373	quarta-feira	1	Q	0
374	sábado	1	S	0
375	semana	1	S	0
376	semana passada	1	S	0
377	sexta-feira	1	S	0
378	ano	1	A	0
379	outono	1	O	0
380	este ano	1	E	0
381	todos os anos	1	T	0
382	verão	1	V	0
383	inverno	1	I	0
384	ano passado	1	A	0
385	próximo ano	1	P	0
386	primavera	1	P	0
387	daqui a dois anos	1	D	0
388	há dois anos　	1	H	0
389	tarde	1	T	0
390	hoje	1	H	0
391	amanhã	1	A	0
392	hora	1	H	0
393	ontem	1	O	0
394	ontem à noite	1	O	0
395	manhã	1	M	0
396	dia	1	D	0
397	noite	1	N	0
398	tardinha	1	T	0
399	depois de amanhã	1	D	0
400	anteontem	1	A	0
401	já　	1	J	0
402	 ～ndo	1	N	0
403	ainda	1	A	0
404	todo ～	1	T	0
405	quando	1	Q	0
406	às vezes	1	A	0
407	muitas vezes	1	M	0
408	cinzeiro	1	C	0
409	canção  	1	C	0
410	cantar	1	C	0
411	cigarro	1	C	0
412	fílme	1	F	0
413	disco	1	D	0
414	guitarra	1	G	0
415	tocar	1	T	0
416	música	1	M	0
417	pintura	1	P	0
418	fotografia	1	F	0
419	gostar de	1	G	0
420	voz	1	V	0
421	tempo bom	1	T	0
422	calor	1	C	0
423	fazer bom tempo	1	F	0
424	fresco	1	F	0
425	frio	1	F	0
426	neve	1	N	0
427	chover	1	C	0
428	chuva	1	C	0
429	clima	1	C	0
430	quente	1	Q	0
431	vento	1	V	0
432	nublado	1	N	0
433	nublar-se	1	N	0
434	caracter chinês	1	C	0
435	dizer	1	D	0
436	escrever	1	E	0
437	fala	1	F	0
438	palavra	1	P	0
439	língua ～	1	L	0
440	língua	1	L	0
441	falar	1	F	0
442	texto	1	T	0
443	contar	1	C	0
444	sentido	1	S	0
445	adulto	1	A	0
446	muitas pessoas	1	M	0
447	casal	1	C	0
448	criança	1	C	0
1	ir	1	I	0
2	inglês	1	I	0
3	avião	1	A	0
4	país estrangeiro	1	P	0
5	estrangeiro	1	E	0
6	português	1	P	0
7	hotel	1	H	0
8	japonês	1	J	0
9	sair	1	S	0
10	país	1	P	0
11	encontrar	1	E	0
12	férias	1	F	0
13	viagem	1	V	0
14	viajar	1	V	0
15	brincar	1	B	0
16	embaixada	1	E	0
17	gostar muito	1	G	0
18	gostar  	1	G	0
19	hábil	1	H	0
20	correr	1	C	0
21	devagar	1	D	0
22	inábil	1	I	0
23	andar	1	A	0
24	nadar	1	N	0
25	rápido	1	R	0
26	voar	1	V	0
27	desporto	1	D	0
28	detestar	1	D	0
29	piscina	1	P	0
30	autocarro	1	A	0
31	bicicleta	1	B	0
32	cruzamento	1	C	0
33	rua	1	R	0
34	lagoa	1	L	0
35	passeio	1	P	0
36	rio	1	R	0
37	táxi	1	T	0
38	carro	1	C	0
39	virar	1	V	0
40	gravata	1	G	0
41	camisa	1	C	0
42	empresa	1	E	0
43	casaco	1	C	0
44	fazer	1	F	0
45	respirar	1	R	0
46	telefone	1	T	0
47	trabalho	1	T	0
48	trabalhar	1	T	0
49	ocupado	1	O	0
50	biblioteca	1	B	0
51	dicionário	1	D	0
52	pedir emprestado	1	P	0
53	jornal	1	J	0
54	ler	1	L	0
55	livro	1	L	0
449	mulher	1	M	0
450	menino	1	M	0
451	pessoa	1	P	0
452	homem	1	H	0
453	menina	1	M	0
454	marido	1	M	0
455	todas as pessoas	1	T	0
456	branco	1	B	0
457	azul	1	A	0
458	castanho	1	C	0
459	cor	1	C	0
460	amarelo	1	A	0
461	preto	1	P	0
462	vermelho	1	V	0
463	verde	1	V	0
464	conveniente	1	C	0
465	festa	1	F	0
466	papel	1	P	0
467	tornar-se	1	T	0
468	apertar	1	A	0
469	empurrar	1	E	0
470	começar	1	C	0
471	mesmo	1	M	0
472	não haver	1	N	0
473	directo	1	D	0
474	famoso	1	F	0
475	estar bem	1	E	0
476	então	1	E	0
477	se calhar	1	S	0
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: pt
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: pt
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

