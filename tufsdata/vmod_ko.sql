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
-- Name: t_bunrui; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_bunrui (
    bunrui_no text NOT NULL,
    chukoumoku text
);


ALTER TABLE public.t_bunrui OWNER TO ko;

--
-- Name: t_index_char; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_index_char (
    id integer NOT NULL,
    index_char text
);


ALTER TABLE public.t_index_char OWNER TO ko;

--
-- Name: t_inst_photo; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_inst_photo (
    id integer NOT NULL,
    usage_inst_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_inst_photo OWNER TO ko;

--
-- Name: t_instance; Type: TABLE; Schema: public; Owner: ko
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


ALTER TABLE public.t_instance OWNER TO ko;

--
-- Name: t_scene; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_scene (
    id integer NOT NULL,
    explanation text,
    s_type integer
);


ALTER TABLE public.t_scene OWNER TO ko;

--
-- Name: t_usage; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_usage (
    usage_id integer NOT NULL,
    word_id integer,
    explanation text,
    disp_priority integer,
    selected integer
);


ALTER TABLE public.t_usage OWNER TO ko;

--
-- Name: t_usage_classified_rel; Type: TABLE; Schema: public; Owner: ko
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


ALTER TABLE public.t_usage_classified_rel OWNER TO ko;

--
-- Name: t_usage_inst_rel; Type: TABLE; Schema: public; Owner: ko
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


ALTER TABLE public.t_usage_inst_rel OWNER TO ko;

--
-- Name: t_usage_photo; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_usage_photo (
    id integer NOT NULL,
    usage_id integer,
    file_name text,
    infomation text,
    explanation text
);


ALTER TABLE public.t_usage_photo OWNER TO ko;

--
-- Name: t_usage_scene_rel; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_usage_scene_rel (
    usage_id integer NOT NULL,
    scene_id integer NOT NULL
);


ALTER TABLE public.t_usage_scene_rel OWNER TO ko;

--
-- Name: t_word; Type: TABLE; Schema: public; Owner: ko
--

CREATE TABLE t_word (
    id integer NOT NULL,
    basic text NOT NULL,
    selected integer,
    index_char text,
    sort_order integer
);


ALTER TABLE public.t_word OWNER TO ko;

--
-- Name: t_word_inst_rel; Type: TABLE; Schema: public; Owner: ko
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


ALTER TABLE public.t_word_inst_rel OWNER TO ko;

--
-- Name: v_bunruilist; Type: VIEW; Schema: public; Owner: ko
--

CREATE VIEW v_bunruilist AS
    SELECT b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no AS linkcheck FROM (t_bunrui b LEFT JOIN (SELECT ucr.chukoumoku_no FROM (t_usage tu JOIN t_usage_classified_rel ucr ON ((tu.usage_id = ucr.usage_id))) WHERE (tu.selected = 1) GROUP BY ucr.chukoumoku_no ORDER BY ucr.chukoumoku_no) ucr ON ((b.bunrui_no = ucr.chukoumoku_no))) GROUP BY b.bunrui_no, b.chukoumoku, ucr.chukoumoku_no ORDER BY b.bunrui_no;


ALTER TABLE public.v_bunruilist OWNER TO ko;

--
-- Name: v_scene; Type: VIEW; Schema: public; Owner: ko
--

CREATE VIEW v_scene AS
    SELECT tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id FROM (((t_scene tsn LEFT JOIN t_usage_scene_rel usr ON ((tsn.id = usr.scene_id))) LEFT JOIN t_usage tu ON ((usr.usage_id = tu.usage_id))) LEFT JOIN t_word tw ON ((tu.word_id = tw.id))) WHERE ((tw.selected = 1) AND (tu.selected = 1)) GROUP BY tsn.id, tsn.explanation, tw.basic, tsn.s_type, tu.word_id ORDER BY tsn.s_type, tsn.id, tu.word_id;


ALTER TABLE public.v_scene OWNER TO ko;

--
-- Data for Name: t_bunrui; Type: TABLE DATA; Schema: public; Owner: ko
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
-- Data for Name: t_index_char; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_index_char (id, index_char) FROM stdin;
1	
2	ㄱ
3	ㄴ
4	ㄷ
5	ㄸ
6	ㄹ
7	ㅁ
8	ㅂ
9	ㅃ
10	ㅅ
11	ㅆ
12	ㅇ
13	ㅈ
14	ㅉ
15	ㅊ
16	ㅋ
17	ㅌ
18	ㅍ
19	ㅎ
\.


--
-- Data for Name: t_inst_photo; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_inst_photo (id, usage_inst_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_instance; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_instance (id, targetlanguage, trans, function, pronun, explanation, module_id, xml_file_name, xpath, web_url, usage_id_rel, selected) FROM stdin;
43	최영욱 씨는요?	チェ　ヨンウクさんは?			\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
221	어떻게 하죠?	どうしたらいいでしょう?			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
402	아뇨.	いいえ.	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
441	모르겠어요.	わかりません.	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
1	어! 김지영 씨, 안녕하십니까?	あ! キム ジヨンさん, こんにちは.	挨拶する		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
2	안녕하세요?	こんにちは.	挨拶をする		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
3	잘 지내세요?	元気ですか？	挨拶をする		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
4	네.	ええ．	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
5	지영 씨는요?	ジヨンさんは?	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
6	예, 저도 잘 지내요.	ええ，私も元気です．	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
7	어제 백화점에서 이걸 샀는데요.	昨日デパートでこれを買ったんですけど.	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
8	그게 뭐에요?	それは何ですか？	情報を求める(属性)		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
9	계산기 아닙니까?	電卓じゃないですか?	特徴についてたずねる		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
10	아니에요.	ちがいます.	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
11	전자 사전이에요.	電子辞典です.	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
809	우리 같이 노래해요.	いっしょに歌を歌いましょう．	\N		\N	vmod	\N	\N	\N	0	1
71	하나 드릴까요?	一つ差し上げましょうか?	人にものをあげる		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
259	정말요?	本当ですか?			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
378	네?	えっ?	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
396	아뇨, 저 책장에 좀 꽂아 주세요.	いえ，あの本棚に入れてください.	指示する		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
448	네.	ええ.	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
512	그림 그리는 것을 좋아해요	絵を描くのが好きです．	\N		\N	vmod	\N	\N	\N	0	1
659	술 약한 편이에요?	お酒に弱いほうですか？	\N		\N	vmod	\N	\N	\N	0	1
705	이가 시리세요?	歯が痛みますか？	\N		\N	vmod	\N	\N	\N	0	1
747	무슨 차 드실래요?	どのお茶を召し上がりますか？	\N		\N	vmod	\N	\N	\N	0	1
487	가을 하늘은 언제 봐도 예뻐요.	秋の空はいつ見てもきれいです．	\N		\N	vmod	\N	\N	\N	0	1
488	가정이 있는 사람이 어떻게 그럴 수가 있어요?	家庭のある人がどうしてそんなことができるんですか？	\N		\N	vmod	\N	\N	\N	0	1
489	주말엔 주로 가족하고 시간을 보내는 편이에요.	週末には主に家族と過ごすほうです．	\N		\N	vmod	\N	\N	\N	0	1
490	지금 제일 가지고 싶은 게 뭐죠?	今いちばん欲しいものは何ですか？	\N		\N	vmod	\N	\N	\N	0	1
491	일본요리는 간장을 많이 쓰는 것 같아요.	日本の料理は醤油を多く使うようです．	\N		\N	vmod	\N	\N	\N	0	1
492	갈색으로 염색했어요.	茶色に染めました．	\N		\N	vmod	\N	\N	\N	0	1
493	이 지역을 흐르는 강의 이름이 뭐죠?	この地域を流れる川の名前は何ですか？	\N		\N	vmod	\N	\N	\N	0	1
494	뭐든지 빌린 건 빨리 갚는 게 좋아요.	何であれ借りたものは早く返すのがいいです．	\N		\N	vmod	\N	\N	\N	0	1
495	비가 그치면 곧 갤 거에요.	雨がやんだらすぐ晴れるでしょう．	\N		\N	vmod	\N	\N	\N	0	1
496	우리 할머니는 90살이신데 아직 건강하세요.	うちの祖母は90歳なのに，まだお元気です．	\N		\N	vmod	\N	\N	\N	0	1
497	몇 년 된 건물이에요?	何年経った建物ですか？	\N		\N	vmod	\N	\N	\N	0	1
498	여기서 걸어서 5분밖에 안 걸려요.	ここから歩いて5分しかかかりません．	\N		\N	vmod	\N	\N	\N	0	1
573	이혼하는 부부들이 매년 늘고 있대요.	離婚する夫婦が毎年増えているそうです．	\N		\N	vmod	\N	\N	\N	0	1
12	한일 사전입니까?	韓日辞典ですか?	情報を求める(属性)		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
13	네, 그래요.	はい，そうです．	機能		\N	dmod	ko01.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
14	최영욱 씨, 안녕하세요?	チェ　ヨンウクさん，こんにちは．	挨拶をする		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
15	어, 김지영 씨, 안녕하세요?	あ，キム　ジヨンさん，こんにちは．	挨拶をする		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
16	어디 가세요?	どちらへいらっしゃるんですか?	機能		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
17	학교 가는 길입니다.	学校に行くところです．	自分の行動について述べる		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
823	이 아이 몇 살이죠?	この子何歳ですか？	\N		\N	vmod	\N	\N	\N	0	1
18	짐이 많네요.	荷物が多いですね．	意見を述べる		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
19	뭘 샀어요?	何を買ったんですか？	機能		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
20	책을 샀어요.	本を買いました．			\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
21	하나 주세요.	一つ下さい．	特徴についてたずねる		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
22	제가 들어 드릴게요.	私がお持ちしますから．	機能		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
23	고맙습니다.	ありがとうございます．	感謝する		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
24	고맙기는요.	どういたしまして．	感謝に応対する		\N	dmod	ko02.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
25	여기요!	すみません！	注意をひく		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
26	예, 잠깐만요.	はい，少々お待ちください．	機能		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
27	여기요!!	すみません!!	注意をひく		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
28	예, 예, 지금 갑니다.	はい，はい，今うかがいます．	機能		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
29	먼저 메뉴판 좀 주세요.	まずメニューを見せて下さい．	要求する		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
30	네, 여기 있습니다.	はい，どうぞ. 	何かをあげる		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
31	뭘 주문하시겠습니까?	何になさいますか?	機能		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	\N
32	뭐가 맛있어요?	何がおいしいですか?	機能		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
33	다 맛있어요.	みんなおいしいですよ．	機能		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
34	응…그럼 돌솥 비빔밥 주세요.	うーん…じゃあ石焼ビビンバ下さい．	要求する		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
35	네, 알겠습니다.	はい，かしこまりました．	機能		\N	dmod	ko03.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
36	처음 뵙겠습니다.	はじめまして．	自己紹介する		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
37	저는 최영욱이라고 합니다.	私はチェ　ヨンウクと申します．	自己紹介する		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
38	처음 뵙겠습니다.	はじめまして．	自己紹介する		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
39	저는 야마다입니다.	私は山田です．	自己紹介する		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
40	만나서 반갑습니다.	お会いできてうれしいです．			\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
41	야마다 씨는 학생이세요?	山田さんは学生ですか?			\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
42	예.	はい．			\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
44	저도 학생이에요.	私も学生です．			\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
45	저…실례지만 나이가 어떻게 되세요?	あの…失礼ですが，歳はおいくつですか?			\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
46	스무 살이에요.	二十歳です．	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
47	아, 그래요?	あ，そうですか?	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
48	동갑이네요.	同い年ですね．	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
49	최영욱 씨는 전공이 뭐에요?	チェ　ヨンウクさんの専攻は何ですか?	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
50	경제학이에요.	経済学です．	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
51	야마다 씨는요?	山田さんは?	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
52	저요?	私ですか? 	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
53	저는 문학이에요.	私は文学です．	機能		\N	dmod	ko04.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
54	저…영완 씨.	あの…ヨンワンさん．	注意を引く		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
55	왜요?	なんですか？	理由を尋ねる		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
56	무슨 일이에요?	何かありましたか？	情報を求める(状況)		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
57	저…영완 씨 우산 말인데요.	あの…ヨンワンさんの傘なんですが．	話題を提示する		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
58	내 우산?	ぼくの傘？	聞き返す		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
59	아, 검은 우산 말이죠?	あ，黒い傘のことでしょ？	情報を確認する		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
60	예, 지난 주 제가 빌려 갔는데요, 지하철에서 잃어 버렸거든요.	ええ，先週私が借りて行ったんですけど，地下鉄で忘れてきてしまったんですよ．	事情を説明する		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
61	아, 그래요?	ああ，そうですか．	あいづちをうつ		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
62	미안해요, 영완 씨.	ごめんなさい，ヨンワンさん．	あやまる		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
63	아니, 괜찮아요.	いや，いいですよ．	機能		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
64	그래두…	でも…	機能		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
65	싼 우산이니까 괜찮아요.	安い傘だから大丈夫ですよ．	機能		\N	dmod	ko05.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
66	지영 씨, 이게 뭐에요?	ジヨンさん，これは何ですか?	特徴についてたずねる		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
67	이거요?	これですか?			\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
68	이건 한국 탈이에요.	これは韓国のお面です．			\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
69	재미있네요.	面白いですね．	く		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
70	처음 봤어요.	初めて見ました．	機能		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
72	아니, 그런 뜻이 아니라…	いえ，そういう意味じゃなくて…	機能		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
73	집에 많이 있으니까 하나 줄게요.	家にたくさんあるから，一つあげますよ．	人にものをあげる		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
74	그래요? 	そうですか?	機能		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
75	그럼 받을게요.	じゃ，いただきます．	機能		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
76	고마워요.	ありがとうございます．	感謝する		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
77	일본에도 탈이 있죠? 	日本にもお面があるでしょう? 	情報を求める(存在と場所)		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
78	한국 것과 똑같애요?	韓国のとそっくりですか?			\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
79	아뇨, 아주 달라요.	いいえ，すごく違います．	機能		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
80	그래요? 	そうですか?	機能		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
81	한번 보고 싶네요.	一度見たいですね．	希望を述べる		\N	dmod	ko06.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
82	박영완 씨, 오늘 초대해 주셔서 정말 감사합니다.	パク　ヨンワンさん，今日は招待して下さって本当にありがとうございました．	感謝する		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
83	별로 차린 것도 없는데 와 주셔서 고마워요.	特別に準備したものもないのに，おいで下さってありがとうございました．	感謝する		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
84	별 말씀을요. 	とんでもありません．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
85	그럼 이만 가 보겠습니다.	では，これで失礼します．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
86	음식이 아직 많이 남았는데 다 드시고 가세요.	食べ物がまだたくさん残っていますから，全部召し上がって行って下さい．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
87	아니에요.	いいえ．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
88	너무 많이 먹어서 배가 불러요.	たくさん食べ過ぎてお腹が一杯です．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
89	박영완 씨도 다음엔 꼭 우리 집에 놀러 오세요.	パク ヨンワンさんも今度はぜひ私の家に遊びにいらして下さい．	招待する		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
90	예, 고맙습니다.	はい，ありがとうございます．	感謝する		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
91	꼭 갈게요.	ぜひお伺いします．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
92	오늘 정말로 맛있게 잘 먹었어요.	今日は本当にごちそうさまでした．	機能		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
93	안녕히 계세요.	さようなら．	さよならを言う(居残る人に対して)		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
94	네, 안녕히 가세요.	ええ，さようなら．	さよならを言う(立ち去る人に対して)		\N	dmod	ko07.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
95	어머 영욱 씨, 무슨 짐이 그렇게 많아요?	あら，ヨンウクさん，荷物が多いですね，何ですか?			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
96	저기 저 벼룩 시장에서 싼 물건을 많이 샀거든요.	あそこのフリーマーケットで安いのをたくさん買ったんですよ．			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
97	옷도 있고 구두도 있고… 지우개까지 있네요.	服もあるし，靴もあるし… 消しゴムまでありますね．			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
98	지우개는 십원 씩이었어요.	消しゴムは一つ10ウォンでした．			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
99	와, 정말 싸다!	わぁ，本当に安い！			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
100	이 옷은 얼마에요?	この服はいくらですか?	情報を求める		\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
101	그 옷은 오천원이에요.	その服は5000ウォンです．			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
102	그럼 이 구두는 얼마에요?	じゃあ，この靴はいくらですか?	情報を求める		\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
103	그건 한 켤레에 만원이에요.	それは一足10000ウォンです．			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
104	진짜 싸네요.	本当に安いですね．			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
105	같이 한번 가 볼래요?	一度いっしょに行ってみますか?			\N	dmod	ko08.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
106	사토 씨는 한국에 가 본 적 있어요?	佐藤さんは韓国に行ったことがありますか?	情報を求める(経験)		\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
107	네, 작년에 한 번 가 봤어요.	ええ，去年一度行きました．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
108	한국 어땠어요?	韓国はどうでしたか?			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
109	재미있었어요?	楽しかったですか?			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
110	아주 재미있었어요.	とても楽しかったです．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
111	거리도 깨끗하고 사람들도 참 친절했어요.	通りもきれいだし，人もとても親切でした．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
112	그래요?	そうですか?			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
113	음식은 어떤 걸 먹어 봤어요?	食べ物はどんなものを食べましたか?	情報を求める(経験)		\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
114	한정식을 먹었는데 반찬이 그렇게 많이 나오는 건 처음 봤어요.	韓定食を食べたんですが，おかずがあんなにたくさん出て来るのは初めて見ました．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
115	갈비도 먹어 봤어요?	カルビも食べてみましたか?	情報を求める(経験)		\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
116	아뇨.	いいえ．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
117	시간이 없어서 못 먹었어요.	時間がなくて食べられませんでした．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
118	그럼, 내가 동경에 맛있는 갈비집을 하나 아는데, 같이 안 갈래요?	じゃあ，私が東京においしいカルビのお店を一軒知っているんですけど，いっしょに行きませんか?	提案する		\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
119	네, 좋아요.	ええ，いいですね．			\N	dmod	ko09.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
120	지영 씨, 내일 어디 가요?	ジヨンさん，明日どこに行きますか?			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
121	도서관에 갈 예정인데, 왜요?	図書館に行くつもりですが，どうしてですか?	予定を言う		\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
122	내일 백화점에서 세일을 하는데 같이 갈까 해서요.	明日デパートでセールをするんですけど，一緒に行こうかと思って．	予定を述べる		\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
123	그 세일은 언제까지 하는데요?	そのセールはいつまでですか?			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
124	내일까지요	明日までです．			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
125	그럼 나도 같이 갈게요.	じゃあ私もいっしょに行きますよ．	予定を述べる		\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
126	도서관은 안 가도 괜찮아요?	図書館は行かなくてもいいんですか?			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
127	공부할 생각 아니었어요?	勉強するつもりじゃなかったんですか?			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
128	아니에요.	違います．			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
129	책을 반납하러 가는 것뿐이었어요.	本を返しに行くだけだったんです．	予定を述べる		\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
130	그래요?	そうですか．			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
131	그럼, 몇 시에 만날까요?	じゃあ，何時に会いましょうか?			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
132	아홉 시 반에 백화점 정문 앞에서 만나요.	9時半にデパートの正面入り口の前で会いましょう．			\N	dmod	ko10.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
133	청호 씨는 어떤 스포츠를 좋아하세요?	チョンホさんはどんなスポーツがお好きですか?	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
134	저는 테니스를 좋아해요.	私はテニスが好きです．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
135	아, 그러세요?	あ，そうですか?			\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
136	요즘도 자주 하세요?	このごろもよくなさるんですか?	程度についてたずねる		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
137	요샌 시간이 없어서 한 달에 두 번 정도 밖에 못해요.	最近は時間がなくて，月に２回ぐらいしかできません．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
138	민희 씨는요?	ミニさんは?	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
139	저는 야구를 좋아해요.	私は野球が好きです．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
140	야구를 해요?	野球をするんですか?	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
141	아뇨.	いいえ．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
142	보는 걸 좋아해요.	見るのが好きなんです．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
143	야구장에 보러 갈 때도 있어요.	野球場に見に行くこともあります．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	1
144	한 달에 몇 번 정도 야구장에 가는데요?	ひと月に何回ぐらい野球場に行きますか?	情報を求める(程度)		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
145	서너 번은 가요.	３，４回は行きます．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
146	많이 가네요.	ずいぶん行くんですね．	機能		\N	dmod	ko11.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
147	오늘 참 재미있었어요.	今日はとても楽しかったですね．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
148	네, 오랜만에 술도 마시고 정말 재미있었어요.	ええ，久しぶりにお酒も飲んだし，本当に楽しかったです．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
188	대단하네요.	すごいですね．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
149	근데 지금 몇 시에요?	ところで今，何時ですか？	情報を求める(時間)		\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
150	잠깐만요…	ええと…			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
151	10시 55분이에요.	10時55分です．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
152	정말요?	本当に？			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
153	큰일났다.	大変だ．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
154	왜요?	どうしたんですか？			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
155	제가 타는 버스는 일찍 끊기거든요.	僕が乗るバスは早くなくなっちゃうんです．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
156	버스 막차가 몇 신데요?	終バスは何時なんですか？	情報を求める(時間)		\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
157	아마 11시쯤일 거에요.	たぶん11時ごろだと思います．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
158	그럼, 빨리 가세요.	じゃあ早く行ってください．			\N	dmod	ko12.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
159	연구회 준비 다 됐어요?	研究会の準備は終わりましたか?	程度についてたずねる		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
160	네, 거의 다 끝났어요.	ええ，ほとんど終わりました．	機能		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
161	그런데 연구회에는 몇 명 정도 올 것 같애요?	ところで研究会には何人ぐらい来そうですか?	情報を求める(数字)		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
162	삼십 명 정도가 아닐까요?	30人ぐらいじゃないですか?	機能		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
163	그럼, 발표 원고는 삼십 부 정도 준비했는데 이걸로 괜찮겠죠?	じゃあ，発表原稿は30部くらい用意したんですが，これでいいですよね?	機能		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
164	혹시 더 많이 올지도 모르니까 오십 부 정도 준비하는 게 좋을 거에요.	ひょっとしてもっとたくさん来るかも知れませんから，50部ぐらい用意したほうがいいと思いますよ．	意見を述べる		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
165	오십 부요?	50部ですね．	機能		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
166	네, 알겠습니다.	はい，わかりました．	機能		\N	dmod	ko13.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
167	여기 학생 식당은 어떻게 이용하는 거에요?	ここの学生食堂はどのように利用するんですか?	何でどのようにするかを言う		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
168	여기서는 현금은 못 쓰고 이 카드로 다 처리합니다.	ここでは現金は使えなくて，このカードですべて処理します．	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
169	카드로요?	カードでですか?	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
170	어떻게 쓰는데요?	どう使うんですか?	何でどのようにするかを言う		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
171	먼저 요리 코너에 가서 먹고 싶은 요리를 고르세요.	まず料理コーナーに行って，食べたい料理を選んでください．	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
172	저 요리 코너 말이죠?	あの料理コーナーのことですね?	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
173	네, 맞아요.	はい，そうです．	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
174	그 다음엔 요리 코너에 있는 센서에 이 카드를 대면 돼요.	次に料理コーナーにあるセンサーにこのカードを当てればおしまいです．	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
175	아주 편하네요.	とても楽ですね．	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
176	앞으로 많이 먹으러 올 것 같애요.	これからたびたび食べに来そうですよ．	機能		\N	dmod	ko14.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
177	혜진 씨, 뭐 해요?	ヘジンさん，何をしているんですか？			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
178	아, 스즈키 씨.	あ，鈴木さん．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
179	지금 일본어 잡지를 보고 있었어요.	今，日本語の雑誌を見ていたんです．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
180	일본어 할 줄 알아요?	日本語ができるんですか？	技能と能力についてたずねる		\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
181	아뇨, 사실은 하나도 못해요.	いいえ，実は全然できないんです．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
182	그냥 사진만 보고 있는 거에요.	ただ写真だけ見ているんですよ．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
183	아, 그렇군요.	あ，そうですか．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
184	스즈키 씨는 외국어 좀 할 줄 알아요?	鈴木さんは外国語ができますか？	技能と能力についてたずねる		\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
185	영어는 조금 해요.	英語は少しできます．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
186	옛날에 러시아어도 배웠는데 다 잊어 버렸어요.	昔，ロシア語も習ったけれど，みんな忘れてしまいました．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
187	어머, 러시아어도 배웠어요?	あら，ロシア語も習ったんですか？			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
589	밝은 파랑으로 주세요.	明るい青のやつをください．	\N		\N	vmod	\N	\N	\N	0	1
189	근데 다 잊어 버렸어요.	でも全部忘れちゃいましたよ．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
190	저는 많이 배워도 금방 잊어 버리거든요.	僕はたくさん習ってもすぐに忘れてしまうので．			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
191	그럼 한국어도 언젠가 잊어 버리는 거 아니에요?	じゃあ，韓国語もいつか忘れちゃうんじゃないですか？			\N	dmod	ko15.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
192	저기요, 사전을 찾고 있는데요.	あのう，辞書を探しているんですが．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
193	네, 무슨 사전을 찾으세요?	はい，何の辞書をお探しですか？			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
194	일한사전인데요, ‘아리랑출판사’에서 새로 나온 거 있어요?	日韓辞典なんですけど，「アリラン出版社」から新しく出たもの，ありますか？	情報を求める(存在と場所)		\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
195	잠시만요.	少々お待ちください．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
196	검색해 볼게요. 	検索してみましょう．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
197	예, 있습니다.	はい，ございます．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[3]	\N	\N	\N
198	어디 있어요?	どこにありますか？	情報を求める(存在と場所)		\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
199	여기로 죽 가시면 오른쪽에 사전 코너가 있거든요.	こちらへずっと行きますと，右側に辞書コーナーがございます．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
200	거기 있어요.	そこにあります．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
201	네, 알겠습니다.	はい，わかりました．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
202	아, 그런데 화장실은 어디에요?	あ，ところでトイレはどこですか？	情報を求める(存在と場所)		\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
203	2층으로 올라가세요.	２階にお上がりください．	指示する 		\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
204	계단 바로 옆에 있어요.	階段のすぐ横にございます．			\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
205	고맙습니다.	ありがとうございました.	感謝する		\N	dmod	ko16.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
206	한국 요리는 처음이세요?	韓国料理は初めてですか?			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
207	네, 뭘 고르면 좋을지 모르겠어요.	ええ，何を選んだらいいかわかりません．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
208	이건 뭐에요?	これは何ですか?			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
209	그건 된장찌개에요.	それは味噌鍋です．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
210	맛이 어때요?	味はどうですか?	情報を求める(属性)		\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
211	일본 사람에겐 좀 짤 거에요.	日本人にはちょっと塩辛いと思いますよ．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
212	그러면 이건 어때요?	ではこれはどうですか?			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
213	맛있게 보이는데.	おいしそうに見えますけど．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
214	비빔국수요?	ビビンククスですか?			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
215	그건 너무 매워요.	それはすごく辛いですよ．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
216	저는 매운 건 괜찮아요.	私は辛いのは大丈夫です．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
217	그냥 이걸로 할게요.	それじゃこれにします．			\N	dmod	ko17.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
218	청호 씨, 지금 얘기 좀 할 수 있어요?	チョンホさん，今ちょっといいですか?			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
219	네, 괜찮은데, 왜요?	ええ，かまわないけど，どうしたんですか?			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
220	이거 김 선배 책인데요, 제가 커필 엎질러 버렸어요.	これ，キム先輩の本なんですけど，私コーヒーをこぼしちゃったんです．			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
222	솔직히 얘기하는 게 낫겠죠.	正直に話したほうがいいですよ．	意見を述べる		\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
223	근데 너무 무서운 선배라서…	でもすごく怖い先輩だから…			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
224	그럴 땐 솔직하게 고백하고 사과하는 게 좋아요.	そんなときは正直に告白して謝るのがいいですよ．	意見を述べる		\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
225	아! 참，김 선배 술 좋아하죠?	あ! そうだ，キム先輩，お酒好きでしょう?			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
226	네, 그런데요.	ええ，そうですけど．			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
227	저한테 좋은 와인이 한 병 있으니까 그걸 같이 가져가 보세요.	僕のところにいいワインが一本あるから，それをいっしょに持って行ってください．			\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
228	와! 청호 씨，정말 고마워요.	わぁ！チョンホさん，本当にありがとう．	感謝する		\N	dmod	ko18.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
229	사과 더 드세요.	りんご，もっと召し上がってください．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
230	아뇨, 많이 먹었어요.	いえ，たくさんいただきました（もうけっこうです）．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
231	왜요?	どうしてですか?			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
232	사과를 별로 안 좋아하세요?	りんごはあまりお好きじゃないんですか？			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
233	네, 저 사실 과일을 별로 안 먹는 편이에요.	ええ，あのう，実は果物はあまり食べないほうなんです．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
234	그래요?	そうなんですか?			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
235	귤이나 바나나도 안 먹어요?	みかんやバナナも食べないんですか?			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
236	예, 저는 과일보다 야채를 더 좋아해요.	ええ，私は果物より野菜のほうが好きです．	好きなものについて述べる		\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
237	그러면 토마토는 잘 먹어요?	ではトマトはよく食べますか?			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
238	아뇨.	いいえ．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
239	토마토도 과일이잖아요.	トマトも果物じゃないですか．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
240	아니에요.	違いますよ．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
241	토마토는 야채에요.	トマトは野菜です．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
242	그래요?	そうですか?			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
243	그러면 앞으로 많이 먹도록 해야겠네요.	それじゃこれからたくさん食べるようにしなければいけませんね．			\N	dmod	ko19.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
244	다음 일요일에 스케이트장에 가는 건 어때요?	次の日曜日にスケートに行きませんか?			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
245	스케이트요?	スケートですか?			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
246	저는 스케이트는 좀…	私，スケートはちょっと…			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
247	왜요?	どうしてですか? 			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
248	스케이트 싫어해요?	スケート，嫌いですか?			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
249	구경하는 건 괜찮은데 타는 건 별로에요.	見るのはかまわないけど，するのはあまり．			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
250	그럼, 볼링은 어때요?	では，ボーリングはどうですか?			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
251	볼링도 좀…	ボーリングもちょっと…			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
252	실은 제가 운동을 싫어하거든요.	実は私，スポーツが嫌いなんですよ．	好きな行動について述べる		\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
253	그러면 뭘 하는 걸 좋아해요?	じゃあ何をするのが好きなんですか?			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
254	카페에서 커피 마시면서 책 읽는 걸 좋아해요.	カフェでコーヒーを飲みながら本を読むのが好きです．	好きな行動について述べる		\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
255	우린 취미가 너무 다르네요.	僕たちは趣味がずいぶん違いますね．			\N	dmod	ko20.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
256	지영 씨, 지하철 표는 어떻게 사요?	ジヨンさん, 地下鉄の切符はどうやって買うんですか?			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
257	돈을 아무리 넣어도 돈이 다시 나와요.	お金をいくら入れてもお金がまた戻ってくるんですよ．			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	1
258	지하철 표를 살 때 한국은 일본하고 반대거든요.	地下鉄の切符を買うとき，韓国は日本と反対なんですよ．	理由を述べる		\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
260	먼저 금액 버튼을 누르고 그 다음에 돈을 넣는 거에요.	まず金額ボタンを押して，その次にお金を入れるんです．	順序について述べる		\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
261	아，그렇구나.	あ，そうなんだ．			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
262	처음 알았어요.	初めて知りました．			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
263	고마워요.	ありがとうございます．	感謝する		\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	\N
264	아니에요.	いいえ．			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
265	저도 일본에서 처음 지하철 표를 살 때 너무 헷갈렸어요.	私も日本ではじめて地下鉄の切符を買ったとき，すごく迷いましたよ．			\N	dmod	ko21.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
266	여보세요?	もしもし?			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
267	철호 씨, 계세요?	チョルホさん，いらっしゃいますか?			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[2]	\N	\N	\N
268	전데요.	私ですが．			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
269	철호 씨! 저에요.	チョルホさん! 私です．			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
270	민희에요.	ミニです.			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
271	어! 민희 씨! 오래간만입니다.	あ! ミニさん! 久しぶりです．			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
590	밥 잘 챙겨 먹어요.	ごはんきちんと食べてくださいね．	\N		\N	vmod	\N	\N	\N	0	1
272	예! 진짜 오래간만이네요.	ええ! 本当に久しぶりですよね．			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
273	그 동안 어떻게 지냈어요?	これまでどうしてたんですか?	状況についてたずねる		\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
274	저는 학교 공부 때문에 바쁘게 지냈어요.	私は学校の勉強で忙しかったんです.			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
275	민희 씨는 어땠어요?	ミニさんはどうでしたか?			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
276	잘 지냈어요?	元気でいましたか?	どうしているのかをたずねる		\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[3]	\N	\N	\N
277	저도 시험 때문에 정신이 없었어요.	私も試験のために，てんてこ舞いでした．			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
278	시험은 언제 끝나요?	試験はいつ終わりますか?			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
279	오늘 끝났어요.	今日終わりました．			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
280	그래요?	そうですか?			\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
281	그러면 오래간만에 식사라도 같이 할까요?	じゃあ久しぶりに，一緒に食事でもしましょうか?	提案する		\N	dmod	ko22.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
282	내일은 아침 일곱시에 출발할 건데 괜찮겠어요?	明日は朝7時に出発しますが，大丈夫ですか?	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
283	네.	ええ.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
284	근데 만약에 제가 늦어지면 어떡하죠?	 でも, もし私が遅刻したらどうしましょう?	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
285	삼십 분 정도라면 기다릴 수 있어요.	30分ぐらいなら待てますよ.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
286	사실 저는 아침에 잘 못 일어나거든요.	実は私は朝起きられないんですよ.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
287	오늘 밤에 빨리 자면 되죠.	今晩早く寝たらいいでしょう.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
288	그래도 자신이 없어요.	でも自信がありません.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
289	만약에 너무 늦어지면 어떻게 하죠?	もしすごく遅くなったらどうしましょうか?	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
290	그렇게 되면 저한테 꼭 전화하세요.	そうなったら私に必ず電話して下さい.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
291	너무 늦으면 먼저 출발할지도 몰라요.	あまりにも遅かったら先に出発するかもしれません.	機能		\N	dmod	ko23.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
292	서울에서 제일 큰 서점이 어디에요?	ソウルで一番大きな本屋はどこですか．	比べて述べる（比較と最上級）		\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
293	교보문고에요.	教保文庫です．			\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
294	많이 주문하면 무료로 배달도 해 주나요?	たくさん注文すれば無料で配達もしてくれますか?			\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
295	글쎄요…	そうですね…			\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
296	그냥 서점보다 인터넷서점에서 사는 게 더 좋을 것 같은데…	普通の本屋よりインターネット書店で買った方がいいと思いますけど…	比べる		\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
297	인터넷서점은 어디가 제일 유명한데요?	インターネット書店はどこが一番有名ですか?	比べて述べる（比較と最上級）		\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
298	‘알라딘’이라는 사이트가 가장 유명한데, 저는 ‘아마존’을 주로 이용하고 있어요.	「アラジン」というサイトが一番有名ですけど，私は「アマゾン」を主に利用しています．	比べる		\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
299	아, 그래요?	ああ，そうですか．			\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
300	그럼 저도 한 번 ‘아마존’을 검색해 볼게요.	じゃあ私も一度「アマゾン」を検索してみます．			\N	dmod	ko24.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
301	배가 고픈데요.	おなかがすいたんですが．			\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
302	아, 벌써 점심 시간이에요?	あ，もう昼食の時間ですか?			\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
303	같이 식사할까요?	一緒に食事しましょうか?	提案する		\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
304	예, 그럽시다.	ええ，そうしましょう．			\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
305	뭘 먹을까요?	何を食べましょうか?			\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
306	칼국수 어때요?	手打ちうどん，どうですか?	提案する		\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
307	예, 좋아요.	ええ，いいですね．			\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
308	전 칼국수 너무 좋아해요.	私は手打ちうどんがすごく好きです．	好きなものについて述べる		\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
309	그럼, 내가 아는 식당으로 갑시다.	じゃあ，僕が知っている食堂に行きましょう．			\N	dmod	ko25.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
310	야마다 씨, 어제 왜 결석했어요?	山田さん，昨日どうして欠席したんですか?	 		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
311	감기 때문에 못 왔어요.	風邪のせいで来られなかったんです．	理由を述べる		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
312	어머, 그래요?	まあ，そうですか．	 		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
313	오늘은 괜찮아요?	今日は大丈夫ですか?	 		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
314	약을 먹었더니 금방 나았어요.	薬を飲んだらすぐ治りました．	理由を述べる		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
315	다행이네요.	よかったですね．	 		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
316	네, 걱정해 줘서 고마워요.	ええ，心配してくれてありがとうございます.	感謝する 		\N	dmod	ko26.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
317	영철 씨, 부탁이 하나 있는데요.	ヨンチョルさん, お願いが一つあるんですが.			\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
318	민희 씨 부탁이라면 뭐든지 괜찮아요.	ミニさんの頼みならなんでもいいですよ.	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
319	뭔데요?	何ですか?	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
320	점심 때 시간 있어요?	お昼に時間がありますか?	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
321	물론 있죠.	もちろんありますよ.	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
322	‘밀크’라는 카페 알아요?	「ミルク」というカフェ，知ってますか?	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
323	물론 알죠.	もちろん知ってますよ.	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
324	거기 가서 커피하고 케이크 하나만 사다 줄래요?	そこに行ってコーヒーとケーキを一つ買って来てくれますか?	依頼する		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
325	민희 씨도 참!	ミニさんもまったく!	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
326	그냥 같이 가면 안돼요?	いっしょに行ったらいいじゃないですか?	意見を言う		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
327	미안해요.	ごめんなさい.	あやまる		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
328	제가 숙제를 해야 되기 때문에 밖에 나갈 시간이 없거든요.	私，宿題をしなくちゃいけないから外に出る時間がないんですよ.	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
329	알았어요.	わかりましたよ.	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
330	민희 씨 부탁이니까 할 수 없죠, 뭐.	ミニさんの頼みだから仕方ないですよ, もう.	 		\N	dmod	ko27.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
331	영욱 씨 생일 때 뭘 주면 좋을지 모르겠어요.	ヨンウクさんの誕生日のときに何をあげたらいいかわからないんです.	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
332	일본에서는 보통 어떤 선물을 해요?	日本では普通どんな贈り物をするんですか?	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
333	글쎄요.	そうですね.	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
334	그렇게 비싸지 않은 걸로 하는데요.	そんなに高くないものにしますけどね.	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
335	예를 들면 어떤 거요?	例えばどんなものですか?	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
336	머그컵이라든가 펜 같은 거요.	マグカップだとかペンのようなものです.	例をあげて述べる		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
337	한국에서는 오히려 비싼 물건을 주는 경우가 많아요.	韓国ではかえって高いものをあげる場合が多いですよ.	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
338	그래요?	そうですか?	 		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
339	예를 들어서 옷이나 향수나…  아니면 반지를 주는 사람도 있어요.	例えば服とか香水とか…　あるいは指輪をあげる人もいます.	例をあげて述べる		\N	dmod	ko28.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
340	선생님, 이 보고서 말인데요, 마감이 내일까지죠?	先生，この報告書のことなんですが，締め切りが明日までですよね?	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
341	네, 그런데요.	ええ，そうですけど.	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
342	다음 주까지 연장할 수는 없을까요?	来週まで延ばすことはできないでしょうか?	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
343	다음 주까지요?	来週までですか?	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
344	좀 곤란한데…	ちょっと困るんだけど…	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
345	수업도 많고 너무 바빠서 내일까지는 도저히 무리에요.	授業も多いし，すごく忙しくて明日までは到底無理ですよ.	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
346	보고서는 어느 정도 완성됐는데요?	報告書はどのぐらい出来たんですか?	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
347	칠십 프로 정도에요.	70パーセントぐらいです.	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
348	그러면 일단 마무리 부분을 쓰고 모레까지 제출하세요.	では，いったんまとめの部分を書いてあさってまでに提出してください.	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
349	그렇게 해도 돼요?	そうしてもいいですか?	 		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
591	식빵에 버터를 발라 먹어요.	食パンにバターを塗って食べます．	\N		\N	vmod	\N	\N	\N	0	1
350	네, 남은 부분은 다음 주에 제출해도 돼요.	ええ，残った部分は来週提出してもいいですよ.	妥協する		\N	dmod	ko29.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	1
351	이거 청호 씨 앨범이에요?	これ，チョンホさんのアルバムですか?	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
352	네, 그래요.	ええ，そうです.	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
353	제가 좀 봐도 돼요?	ちょっと見てもいいですか?	許可を求める		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
354	그럼요.	もちろんですよ.	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
355	어머!	まあ!	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	\N
356	귀엽다.	かわいい.	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	\N
357	몇 살 때 사진이에요?	何歳のときの写真ですか?	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[3]	\N	\N	1
358	다섯 살 때 찍은 사진이에요.	五歳のときに撮った写真です.	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
359	어머머!	あらあら!	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
360	이거 여자 친구 사진 아니에요?	これ，ガールフレンドの写真じゃありませんか?	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
361	이름 물어 봐도 돼요?	名前を聞いてもいいですか?	許可を求める		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
362	그건 여자 친구가 아니구요, 제 누나 사진이에요.	それはガールフレンドの写真じゃなくて，私の姉の写真です.	 		\N	dmod	ko30.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
363	이 식당은 처음이에요?	この食堂は初めてですか?	機能		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
364	네.	ええ.	機能		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
365	여긴 셀프 서비스에요.	ここはセルフサービスですよ.	機能		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
366	그럼 요리를 직접 자기 자리로 가져가야 돼요?	では料理を直接自分の席に持って行かなくてはいけませんか?	義務を確認する/肯定する		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
367	네, 그래요.	ええ, そうです.	義務を確認する/肯定する		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
368	그럼 먹고 나서도 직접 그릇을 카운터에 반납해야 되는 거에요?	じゃ食べてからも直接食器をカウンターに返さなければいけないんですか?	義務を確認する/肯定する		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
369	네, 그렇죠.	ええ, そうですよ.	機能		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
370	좀 귀찮겠네요.	ちょっと面倒くさいですね.	機能		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
371	그래도 다른 가게보다 훨씬 싸요.	でも他のお店よりずっと安いですよ.	機能		\N	dmod	ko31.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
372	한국에서 박물관에 온 건 처음이에요. 	韓国で博物館に来たのは初めてです.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
373	그래요?  	そうですか.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
374	여기엔 한국 역사에 관한 게 많아요.	ここには韓国の歴史に関するものが多いんです. 	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
375	네, 참 신기한 게 많네요. 	ええ，本当に珍しいものが多いですね.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
376	이거 만져 봐도 돼요?	これ，触ってみてもいいですか.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
377	아! 만지지 마세요. 	あ！触らないでください.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
379	"손으로 만지지 마세요"라고 그 앞에 적혀 있잖아요.	｢手で触らないでください｣とその前に書いてあるじゃないですか.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
380	어, 정말요?	あ，本当ですか.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
381	미안해요. 	すみません.	あやまる		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
382	못 봤어요. 	わかりませんでした.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[3]	\N	\N	\N
383	그럼, 사진은 찍어도 돼요?	では，写真は撮ってもいいですか.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[4]	\N	\N	1
384	아뇨, 사진도 찍으면 안돼요.	いいえ，写真も撮ってはいけません.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
385	어머, 그래요? 	あら，そうですか.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
386	유감이네요. 	残念ですね.	機能		\N	dmod	ko32.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
387	이 컴퓨터 어디에 둘까?	このコンピューター，どこに置こうか？	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
388	아, 선배, 그건 책상 위에 놔 주세요.	あ，先輩．それは机の上に置いて下さい.	指示する		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
389	그럼, 저 옷장은?	じゃ，あのたんすは？	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
390	글쎄요… 어디에 놓으면 좋을까?	そうですね… どこに置けばいいかなあ？	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
391	우선, 침대 옆에 놔 주시겠어요?	とりあえず，ベッドの横に置いてもらえますか？	依頼する		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
392	침대 오른쪽? 왼쪽?	ベッドの右，左？	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
393	음… 왼쪽에 좀 놔 주세요.	うーん…左にちょっと置いてください.	指示する		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
394	알았어. 	わかった.	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
395	이 책들은 책상 위에 두면 돼?	この本は机の上に置けばいい？	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
397	책상 위엔 프린터를 놓을 거거든요.	机の上にはプリンタを置くつもりなんですよ.	理由を述べる		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
398	네, 네, 알겠습니다!	はい，はい，わかりました！	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
399	선배, 정말 고마워요. 	先輩，本当にありがとうございます.	感謝する		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
400	오늘 내가 한턱 낼게요. 	今日は私がおごりますから.	機能		\N	dmod	ko33.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
401	숙제 다 끝났어요?	宿題，全部終わりましたか?	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
403	아직 멀었어요.	まだです.	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
404	어느 정도 남았어요?	どのくらい残りましたか?	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	1
405	이제 한 페이지만 하면 되는데 마지막 문제가 너무 어려워요.	もう1ページだけやればいいんですが，最後の問題がとても難しいです.	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
406	곧 수업이니까 빨리 하세요.	もうすぐ授業ですから早くやって下さい.	要求する		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
407	저 기다리지 마세요.	私を待たないで下さい．	非行為を依頼する		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
408	시간이 좀 걸릴 것 같으니까.	時間がちょっとかかりそうですから.	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
409	기다릴 테니까 같이 가요.	待ってるから一緒に行こうよ.	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
410	그래요?	そうですか?	 		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
411	고마워요.	ありがとう．	感謝する		\N	dmod	ko34.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	\N
412	다음 주 모임 말인데요, 회원들에게 편지로 알려 주면 될까요?	来週の集まりのことなんですが，会員に手紙でお知らせしたらいいでしょうか?	義務を確認する/否定する		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
413	아뇨, 이메일로 보내세요.	いえ，eメールで送って下さい.	義務を確認する/否定する		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
414	근데 이메일을 안 보는 회원도 있는데요.	でもeメールを見ない会員もいるんですが.	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
415	왜요?	なぜですか?	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	\N
416	너무 바빠서요?	とても忙しすぎるからですかね?	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
417	아뇨, 아예 이메일을 이용하지도 않는 것 같애요.	いいえ，初めからeメールを利用もしないようですよ.	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
418	그럼 좀 문제네요.	そうなるとちょっと問題ですね.	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
419	역시 편지로 연락하는 게 좋을까요?	やはり手紙で連絡するのがいいでしょうか?	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
420	글쎄요.	そうですね.	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
421	그럼, 그 편지에 다음부터는 이메일로 연락하겠다고 쓰면 어때요?	では，その手紙に次からはeメールで連絡すると書いたらどうですか?	 		\N	dmod	ko35.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
422	여보세요?	もしもし.	機能		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	\N
423	여보세요?	もしもし.	機能		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
424	안녕하세요?	こんにちは.	挨拶をする		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
425	저 이노우엔데요.	私，井上ですが.			\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[3]	\N	\N	1
426	아, 안녕하세요?	あ，こんにちは.	挨拶をする		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
427	오랜만이네요. 	久しぶりですね.	挨拶をする		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	\N
428	네, 그렇네요.	ええ，そうですね.	機能		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
429	근데 민호 오빠, 혹시 다음 주 일요일에 시간 있으세요?　	ところでミノさん，もしかして来週の日曜日に時間ありますか？			\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	1
430	음… 시간은 있는데, 왜요?	うん…時間はあるけど，どうしてですか?	機能		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
431	실은 제가 어제 이사를 했거든요.	実は私，昨日引越しをしたんですよ.	指示する		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
432	그래서 다음 주 일요일에 집들이를 하려고 하는데 민호 오빠도 오실 수 있으세요?	それで来週の日曜日に引越しパーティをしようと思っているんですが，ミノさんも来られますか？	招待する		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
433	물론 갈 수 있죠.	もちろん行けますよ.	機能		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
434	몇 신데요?	何時からですか？	情報を求める(時間)		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	\N
435	저녁 6시부터에요.	夕方6時からです.			\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
436	꼭 갈게요. 	必ず行きますよ.	機能		\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
437	그럼 그 때 봐요.	ではその時会いましょう.			\N	dmod	ko36.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	1
438	청호 씨, 왜 그렇게 기운이 없어요?	チョンホさん, どうしてそんなに元気がないんですか?	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
439	아, 민희 씨…실은 요새 식욕도 없구, 공부도 하기 싫구…	あ，ミニさん…実はこのごろ食欲もないし，勉強もやりたくないし…	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
440	피곤해서 그런 거 아니에요?	疲れてるからではありませんか?	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
442	요즘은 아르바이트도 안 하니까 피곤하지는 않은데…	このごろはアルバイトもしないから疲れてはいないんですが…	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[2]	\N	\N	\N
443	그럴 땐 오히려 몸을 움직이는 게 좋아요.	そんな時はかえって体を動かすのがいいですよ.	助言する		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
444	다 귀찮아요.	すごくめんどくさいですよ.	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
445	그런 소리 하지 말고 먼저 방 청소부터 해 보세요.	そんなこと言わないで，まず部屋掃除からやってみて下さい.	助言する		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
446	방 청소는 반 년 이상 해 본 적이 없어요.	部屋掃除は半年以上，やったことがありません.	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
447	방이 지저분하면 기운도 없어지기 마련이에요.	部屋が汚いと元気もなくなるものです.	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	1
449	그럼 한번 해 볼게요.	では一度やってみます.	 		\N	dmod	ko37.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	1
450	아저씨, 이 귤 맛있어요?	おじさん，このミカンおいしいですか?	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
451	그럼요.	もちろんですよ.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
452	맛있죠	おいしいですよ	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	1
453	그래요?	そうですか?	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
454	그럼 열 개만 주세요.	では10個ほど下さい.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
455	네, 삼천원입니다.	はい，3000ウォンです.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
456	어, 너무 비싸요.	あら，ずいぶん高いですね.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
457	아저씨, 좀 깎아 주세요.	おじさん，ちょっとまけて下さい.	要求する		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
458	글쎄, 우린 다른 가게보다 싼 편이에요.	そうだね，うちは他の店より安い方ですよ.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
459	다음에도 꼭 살 테니까 조금만 깎아 주세요.	次も必ず買いますから，少しだけまけて下さいよ.	要求する		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	1
460	알았어요.	わかりました.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	\N
461	그럼 이천 오백원으로 하죠.	では2500ウォンにしましょう.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[2]	\N	\N	1
462	고마워요.	ありがとうございます.	感謝する		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[1]	\N	\N	\N
463	다음에도 꼭 올게요.	次も必ず来ますからね.	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[9]/sentence[2]	\N	\N	\N
464	감사합니다.	ありがとうございます．	 		\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[1]	\N	\N	\N
465	또 오세요.	またおいでください．			\N	dmod	ko38.xml	/dmodule[1]/body[1]/dialogue[1]/line[10]/sentence[2]	\N	\N	\N
466	학교 졸업하면 뭐 할 거에요?	学校を卒業したら何をするつもりなんですか?	 		\N	dmod	ko39.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
467	전 대학원에 가고 싶어요.	私は大学院に行きたいですね.	希望を述べる		\N	dmod	ko39.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	1
468	대학원에선 뭘 전공하고 싶은데요?	大学院では何を専攻したいですか?	 		\N	dmod	ko39.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
469	아직 확실하진 않은데요, 문학을 공부하고 싶어요.	まだはっきりしていないんですが，文学が勉強したいです.	希望を述べる		\N	dmod	ko39.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
470	특히 좋아하는 작품 있어요?	特に好きな作品がありますか?	 		\N	dmod	ko39.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
471	네, “소나기” 같은 단편소설을 좋아해요.	ええ，“ソナギ(にわか雨)”のような短編小説が好きです.	 		\N	dmod	ko39.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	1
472	박진철 씨, 이쪽은 학교 친구 사토 씨에요.	パク ジンチョルさん，こちらは学校の友人の佐藤さんです．	人を紹介する		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[1]/sentence[1]	\N	\N	1
473	처음 뵙겠습니다.	はじめまして.	自己紹介する		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[1]	\N	\N	\N
474	박진철입니다.	パク ジンチョルです.	自己紹介する		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[2]/sentence[2]	\N	\N	\N
475	사토입니다.	佐藤です.	自己紹介する		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[1]	\N	\N	\N
476	말씀 많이 들었습니다.	お話はよく伺っております.			\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[3]/sentence[2]	\N	\N	1
477	사토 씨는 전공이 일본 경제라서 한국 경제에도 관심이 많습니다.	佐藤さんは専攻が日本経済ですので，韓国経済にも大変関心があります.	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[4]/sentence[1]	\N	\N	1
478	그렇습니까?	そうですか?	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[1]	\N	\N	1
479	저는 한국 경제가 전공이에요.	私は韓国経済が専攻です.	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[5]/sentence[2]	\N	\N	1
480	어, 그러세요?	まあ，そうですか?	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[1]	\N	\N	\N
481	많이 가르쳐 주세요.	たくさん教えてください.	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[6]/sentence[2]	\N	\N	1
482	저야말로요.	こちらこそ.	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[1]	\N	\N	\N
483	저도 일본 경제에 대해 알고 싶은 게 많습니다.	私も日本の経済について知りたいことが多いんですよ.	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[7]/sentence[2]	\N	\N	1
484	그러면 이따가 저하고 얘기 좀 하실까요?	では後ほど，私とお話ししましょうか?	 		\N	dmod	ko40.xml	/dmodule[1]/body[1]/dialogue[1]/line[8]/sentence[1]	\N	\N	1
485	제일 가까운 슈퍼가 어디죠?	いちばん近いスーパーはどこですか？	\N		\N	vmod	\N	\N	\N	0	1
486	십년 전일인데 아직도 가끔 생각 나요.	10年前のことなのに，まだときどき思い出します．	\N		\N	vmod	\N	\N	\N	0	1
499	이 시계는 어디에 걸까요?	この時計はどこにかけましょうか？	\N		\N	vmod	\N	\N	\N	0	1
500	추위를 많이 타서 겨울은 싫어요.	寒さにとても弱いので，冬は嫌いです．	\N		\N	vmod	\N	\N	\N	0	1
501	저기 서 있는 경찰 아저씨한테 한 번 물어 보세요.	あそこに立っているお巡りさんに一度聞いてみてください．	\N		\N	vmod	\N	\N	\N	0	1
502	경찰관들이 많이 보이는데, 여기 무슨 일 있어요?	警官がたくさん見えますけど，ここで何かあるんですか？	\N		\N	vmod	\N	\N	\N	0	1
503	계란은 다 익혀 주세요.	卵は全部火を通してください．	\N		\N	vmod	\N	\N	\N	0	1
504	한국사람들은 무슨 고기를 많이 먹어요?	韓国の人たちは何の肉をたくさん食べますか？	\N		\N	vmod	\N	\N	\N	0	1
505	고모는 아직 미혼이에요.	(父方の)おばはまだ未婚です．	\N		\N	vmod	\N	\N	\N	0	1
506	점심 싸서 가까운 공원에 놀러 가요.	お弁当を作って近くの公園に遊びに行きます．	\N		\N	vmod	\N	\N	\N	0	1
507	교실 안에서는 뛰지 말 것.	教室の中では走らないこと．	\N		\N	vmod	\N	\N	\N	0	1
508	이 숟가락은 구부러져서 버려야겠어요.	このスプーンは曲がっているので捨てなきゃならないだろうね．	\N		\N	vmod	\N	\N	\N	0	1
509	구월 초까지는 더워요.	9月初めまでは暑いです．	\N		\N	vmod	\N	\N	\N	0	1
510	귀에 물이 들어갔어요.	耳に水が入りました．	\N		\N	vmod	\N	\N	\N	0	1
511	그녀는 이 세상에 없지만 그는 슬퍼하지 않았다.	彼女はこの世にいないが，彼は悲しまなかった．	\N		\N	vmod	\N	\N	\N	0	1
513	그저께 내가 빌려준 책 다 읽었어？	おととい貸した本，全部読んだ？	\N		\N	vmod	\N	\N	\N	0	1
514	이 근처에 큰 슈퍼가 있어요?	この近くに大きなスーパーはありますか？	\N		\N	vmod	\N	\N	\N	0	1
515	글로 어떻게 표현해야 할지 모르겠어요.	文章でどう表現すればいいか，分かりません．	\N		\N	vmod	\N	\N	\N	0	1
516	저는 금요일이 제일 좋아요.	私は金曜日がいちばんいいです．	\N		\N	vmod	\N	\N	\N	0	1
517	기타 칠 줄 아세요?	ギター弾けますか？	\N		\N	vmod	\N	\N	\N	0	1
518	길을 잘 몰라서 헤맸어요.	道がよく分からなくて迷いましたよ．	\N		\N	vmod	\N	\N	\N	0	1
519	여름은 낮이 길고 밤이 짧아요.	夏は昼が長くて夜が短いです．	\N		\N	vmod	\N	\N	\N	0	1
520	나라마다 습관이 다르니까 책을 좀 읽고 가는 게 좋을 거에요.	国ごとに習慣が違うから，本をちょっと読んでいくのがいいと思います．	\N		\N	vmod	\N	\N	\N	0	1
521	나쁜 사람은 아니에요.	悪い人ではないです．	\N		\N	vmod	\N	\N	\N	0	1
522	테이블 위에 나이프하고 포크 좀 놔 줄래요?	テーブルの上に，ナイフとフォークをちょっと置いてもらえますか？	\N		\N	vmod	\N	\N	\N	0	1
523	난로에 너무 가깝게 앉지 마세요.	ストーブにあまり近づいて座らないでください．	\N		\N	vmod	\N	\N	\N	0	1
524	날씨가 너무 좋아서 놀러 가려고요.	天気がすごくいいので遊びに行こうと思って．	\N		\N	vmod	\N	\N	\N	0	1
525	남자아이보다는 여자아이가 더 좋은데...	男の子より女の子の方がいいんだけど…．	\N		\N	vmod	\N	\N	\N	0	1
526	남편은 오늘 출장 가고 없어요.	夫は今日出張に出ていません．	\N		\N	vmod	\N	\N	\N	0	1
527	내일 낮에 같이 점심 먹으러 가요.	明日の昼，いっしょに昼ご飯食べに行きましょう．	\N		\N	vmod	\N	\N	\N	0	1
528	내년부터 시험유형이 바뀐다면서요?	来年から試験のタイプが変わるんですってね．	\N		\N	vmod	\N	\N	\N	0	1
529	여기 오시려면 시청역에서 내려서 5분쯤 걸으셔야 해요.	こちらにいらっしゃるなら，市庁駅で降りて5分くらい歩いていただかなければなりません．	\N		\N	vmod	\N	\N	\N	0	1
530	날씨가 더우니까 가능한 빨리 냉장고에 넣으세요.	暑いからできるだけ早く冷蔵庫に入れてください．	\N		\N	vmod	\N	\N	\N	0	1
531	요리라면 너보단 내가 낫지.	料理ならきみより私のほうが上さ．	\N		\N	vmod	\N	\N	\N	0	1
532	주말에는 넥타이를 안 매고 출근해요.	週末はネクタイを締めないで出勤します．	\N		\N	vmod	\N	\N	\N	0	1
533	노래는 잘 못 하는데, 듣는 건 좋아해요.	歌は下手ですけど，聴くのは好きです．	\N		\N	vmod	\N	\N	\N	0	1
534	노트를 깜박하고 안 갖고 왔어요.	ノートをうっかり忘れて持ってきませんでした．	\N		\N	vmod	\N	\N	\N	0	1
535	학교 칠판은 주로 진한 녹색이 많죠.	学校の黒板は主に濃い緑が多いですよ．	\N		\N	vmod	\N	\N	\N	0	1
536	수업시간에 녹음기를 사용해도 괜찮아요?	授業の時間にテープレコーダーを使っても大丈夫ですか？	\N		\N	vmod	\N	\N	\N	0	1
537	63빌딩은 높이가 어느 정도 돼요?	63ビルは高さがどれくらいになりますか？	\N		\N	vmod	\N	\N	\N	0	1
538	여긴 누구 소개로 오셨어요?	ここには誰の紹介でいらっしゃいましたか？	\N		\N	vmod	\N	\N	\N	0	1
539	죄송하지만 전화하신 분은 누구시죠?	すみませんが電話なさった方はどなたですか？	\N		\N	vmod	\N	\N	\N	0	1
540	누군가가 뒤를 따라오는 느낌이 들었다.	誰かがあとをついてくる感じがした．	\N		\N	vmod	\N	\N	\N	0	1
541	아기 눈이 너무 맑아요.	赤ん坊の目がとてもきれいです．	\N		\N	vmod	\N	\N	\N	0	1
542	눈이 내려서 길이 미끄러워요.	雪が降って道が滑ります．	\N		\N	vmod	\N	\N	\N	0	1
543	종일 서 있었더니 다리가 퉁퉁 부었어요.	一日中立っていたら，脚がぱんぱんにはれました．	\N		\N	vmod	\N	\N	\N	0	1
544	다음 달부터는 좀 한가해요.	来月からはちょっと暇です．	\N		\N	vmod	\N	\N	\N	0	1
545	창문 좀 닫아 주실래요?	窓をちょっと閉めてくださいますか？	\N		\N	vmod	\N	\N	\N	0	1
546	피곤할 땐 단 게 먹고 싶어져요.	疲れているときは甘いものが食べたくなります．	\N		\N	vmod	\N	\N	\N	0	1
547	잘 달리다가 넘어져서 그만 일등을 놓쳤어요.	よく走ったけど転んで1等賞を逃しました．	\N		\N	vmod	\N	\N	\N	0	1
548	닭고기는 값도 싸고 영양가도 높아요.	鶏肉は値段も安いし，栄養価も高いです．	\N		\N	vmod	\N	\N	\N	0	1
549	요즘은 담배 끊는 사람이 늘고 있어요.	この頃はたばこをやめる人が増えています．	\N		\N	vmod	\N	\N	\N	0	1
550	대답하기 싫으면 안 해도 돼요.	答えたくなければ答えなくてもいいですよ．	\N		\N	vmod	\N	\N	\N	0	1
551	대문이 열려 있네요.	門が開いてますね．	\N		\N	vmod	\N	\N	\N	0	1
552	한국 대사관은 더 가야 됩니까?	韓国大使館はもっと行かなければいけませんか？	\N		\N	vmod	\N	\N	\N	0	1
553	여긴 대학교도 많고 고등학교도 많아요.	ここは大学も多いし高校も多いです．	\N		\N	vmod	\N	\N	\N	0	1
554	너무 더워서 입맛이 없어요.	暑すぎて食欲がありません．	\N		\N	vmod	\N	\N	\N	0	1
555	오늘은 기온이 36도까지 올라간대요.	今日は気温が36度まで上がるそうです．	\N		\N	vmod	\N	\N	\N	0	1
556	도착하자마자 전화해.	着いたらすぐに電話してね．	\N		\N	vmod	\N	\N	\N	0	1
557	고향에 돌아가도 반겨줄 사람이 없어요.	ふるさとに帰っても喜んでくれる人がいないんです．	\N		\N	vmod	\N	\N	\N	0	1
558	해는 동쪽에서 뜹니다.	日は東から昇ります．	\N		\N	vmod	\N	\N	\N	0	1
559	돼지고기 반 근만 주실래요?	豚肉半斤だけいただけますか？	\N		\N	vmod	\N	\N	\N	0	1
560	자켓 안에는 두꺼운 스웨터보다는 얇은 셔츠가 나아요.	ジャケットの中は厚いセーターより薄いシャツの方がいいですよ．	\N		\N	vmod	\N	\N	\N	0	1
561	뒤에 앉아 있던 사람, 친구에요?	後ろに座ってた人，友達ですか？	\N		\N	vmod	\N	\N	\N	0	1
562	빨리 따뜻한 봄이 왔으면 좋겠어요.	早く暖かい春がくればいいです．	\N		\N	vmod	\N	\N	\N	0	1
563	라디오를 켜 놓고 잠들어 버렸어요.	ラジオをつけたまま寝てしまいました．	\N		\N	vmod	\N	\N	\N	0	1
564	그 테이프， 라디오카세트에 들어 있어.	あのテープ，ラジカセに入ってるよ．	\N		\N	vmod	\N	\N	\N	0	1
565	레몬은 비타민이 많은 과일이에요.	レモンはビタミンが多い果物です．	\N		\N	vmod	\N	\N	\N	0	1
566	레스토랑은 예약했어?	レストランは予約した？	\N		\N	vmod	\N	\N	\N	0	1
567	아이들이 많으니까 마당이 있는 집이 좋아요.	子供が多いから庭のある家がいいです．	\N		\N	vmod	\N	\N	\N	0	1
568	마침 시간이 나서요, 같이 밥이나 먹어요.	ちょうど時間があいたんで，いっしょにご飯でも食べましょう．	\N		\N	vmod	\N	\N	\N	0	1
569	요즘 만년필을 쓰는 사람은 별로 없는 것 같아요.	最近万年筆を使う人は特にいないようです．	\N		\N	vmod	\N	\N	\N	0	1
570	말이 너무 어려워서 못 읽겠어요.	ことばが難しすぎて読めなさそうです．	\N		\N	vmod	\N	\N	\N	0	1
571	한국말 할 줄 아세요?	韓国語おできになりますか？	\N		\N	vmod	\N	\N	\N	0	1
572	비싼 거 치고는 맛이 없네요.	高いものにしてはまずいですね．	\N		\N	vmod	\N	\N	\N	0	1
574	매월 셋째주 수요일에는 회의가 있어요.	毎月第3週の水曜日には会議があります．	\N		\N	vmod	\N	\N	\N	0	1
575	매주 목요일 아르바이트가 있어요.	毎週木曜日にアルバイトがあります．	\N		\N	vmod	\N	\N	\N	0	1
576	집은 여기서 멀어요?	家はここから遠いですか？	\N		\N	vmod	\N	\N	\N	0	1
577	모두 다 도와 주셔서 감사합니다.	皆さん助けてくださってありがとうございます．	\N		\N	vmod	\N	\N	\N	0	1
578	저기 빨간 모자 쓴 사람이 우리 오빠에요.	あそこの，赤い帽子をかぶった人がうちの兄です．	\N		\N	vmod	\N	\N	\N	0	1
579	목소리가 낮은 사람이 좋아요.	声の低い人が好きです．	\N		\N	vmod	\N	\N	\N	0	1
580	일주일 중 목요일이 제일 피곤한 것 같아요.	一週間で木曜日がいちばん疲れる気がします．	\N		\N	vmod	\N	\N	\N	0	1
581	새벽엔 연못 주위를 산책하는 사람들로 붐벼요.	早朝には池の周りを散歩する人でいっぱいです．	\N		\N	vmod	\N	\N	\N	0	1
582	문을 좀 살짝 닫아 주세요.	ドアをちょっと静かに閉めてください．	\N		\N	vmod	\N	\N	\N	0	1
583	문이 닫혀 있어서 못 들어갔어요.	戸が閉まっていて入れませんでした．	\N		\N	vmod	\N	\N	\N	0	1
584	오늘은 바람이 세네요.	今日は風が強いですね．	\N		\N	vmod	\N	\N	\N	0	1
585	바지 단을 좀 줄이고 싶은데요.	ズボンのすそをちょっと詰めたいんですけど．	\N		\N	vmod	\N	\N	\N	0	1
586	민희하고 같은 반 친구 지영인데요.	ミニと同じクラスの友達のジヨンですけど．	\N		\N	vmod	\N	\N	\N	0	1
587	양쪽 발 사이즈가 틀려요.	両方の足のサイズが違います．	\N		\N	vmod	\N	\N	\N	0	1
588	조명이 너무 밝아서 눈이 부셔요.	照明が明るすぎてまぶしいです．	\N		\N	vmod	\N	\N	\N	0	1
592	비에 다 젖었으니까 빨리 벗고 갈아 입어요.	雨にすっかり濡れたから，早く脱いで着替えなさい．	\N		\N	vmod	\N	\N	\N	0	1
593	병원에 갔는데 무슨 병인지 잘 모른대요.	病院に行ったんだけど，何の病気か分からないそうです．	\N		\N	vmod	\N	\N	\N	0	1
594	이 근처에는 병원은 많은데 안과는 없어요.	この近くに病院は多いのに，眼科はありません．	\N		\N	vmod	\N	\N	\N	0	1
595	화장실은 복도 제일 끝에 있어요.	トイレは廊下のいちばん端にあります．	\N		\N	vmod	\N	\N	\N	0	1
596	복사를 좀 하고 싶은데, 몇 층에 가면 되죠?	ちょっとコピーをとりたいんですけど，何階に行けばいいですか？	\N		\N	vmod	\N	\N	\N	0	1
597	복사하려면 여기 이 신청서를 쓰셔야 해요.	コピーするなら，この申請書を書いてくださらなければなりません．	\N		\N	vmod	\N	\N	\N	0	1
598	이름은 연필 말고 볼펜으로 써 주세요.	名前は鉛筆ではなくボールペンで書いてください．	\N		\N	vmod	\N	\N	\N	0	1
599	봄이 되니 자꾸 졸려요.	春なので眠いです．	\N		\N	vmod	\N	\N	\N	0	1
600	봉투에 보내시는 분 주소도 적으셨어요?	封筒に，送り主の住所も書きましたか？	\N		\N	vmod	\N	\N	\N	0	1
601	부모님 결혼 기념일은 언제에요?	ご両親の結婚記念日はいつですか？	\N		\N	vmod	\N	\N	\N	0	1
602	아이를 낳지 않는 부부들이 늘고 있대요.	子供を産まない夫婦が増えているそうです．	\N		\N	vmod	\N	\N	\N	0	1
603	집은 넓은데 부엌이 좁은 게 흠이에요.	家は広いけど台所が狭いのが玉にキズです．	\N		\N	vmod	\N	\N	\N	0	1
604	부인이 참 미인이시네요.	奥さんがほんとにきれいでいらっしゃいますね．	\N		\N	vmod	\N	\N	\N	0	1
605	북쪽 출구에서 만나요.	北側の出口で会いましょう．	\N		\N	vmod	\N	\N	\N	0	1
606	손님, 여기 우표를 안 붙이셨네요.	お客さん，ここ切手を貼ってらっしゃいませんね．	\N		\N	vmod	\N	\N	\N	0	1
607	비가 오는 날은 좀 더 일찍 나가야 돼요.	雨の降る日は少し早く出なければなりません．	\N		\N	vmod	\N	\N	\N	0	1
608	그러다간 비행기 시간에 늦겠어요.	そんなでは飛行機の時間に遅れますよ．	\N		\N	vmod	\N	\N	\N	0	1
609	볼펜 좀 빌려주실래요?	ボールペンちょっと貸していただけますか？	\N		\N	vmod	\N	\N	\N	0	1
610	장미는 역시 빨강이 제일 예뻐요.	バラはやっぱり赤がいちばんきれいです．	\N		\N	vmod	\N	\N	\N	0	1
611	이 청소기는 먼지를 아주 잘 빨아 들여요.	この掃除機はほこりをとてもよく吸い込みます．	\N		\N	vmod	\N	\N	\N	0	1
612	일주일 내내 비가 와서 빨래가 많이 밀렸어요.	一週間ずっと雨が降ったので，洗濯がたくさんたまっています．	\N		\N	vmod	\N	\N	\N	0	1
613	주말에는 빨래하고 청소하느라 아무데도 못 가요.	週末は洗濯して掃除するのでどこにも行けません．	\N		\N	vmod	\N	\N	\N	0	1
614	아침에는 빵을 주로 먹어요.	朝は主にパンを食べます．	\N		\N	vmod	\N	\N	\N	0	1
615	저기 보이는 사거리에서 우회전 하세요.	あそこに見える交差点で右に曲がってください．	\N		\N	vmod	\N	\N	\N	0	1
616	일본에서는 사월에 입학식이 있어요.	日本では4月に入学式があります．	\N		\N	vmod	\N	\N	\N	0	1
617	제 사촌 동생이에요.	私のいとこです．	\N		\N	vmod	\N	\N	\N	0	1
618	우리 애는 사탕을 너무 좋아해서 큰일이에요.	うちの子は飴が大好きで大変です．	\N		\N	vmod	\N	\N	\N	0	1
619	힘드시더라도 가끔 산책 정도는 하세요.	お疲れでもときどき散歩くらいはなさってください．	\N		\N	vmod	\N	\N	\N	0	1
620	여긴 쇼핑할 데가 많아서 살기 편해요.	ここは買い物するところが多くて住みやすいです．	\N		\N	vmod	\N	\N	\N	0	1
621	한국은 입학식이 삼월이고, 졸업식은 이월이에요.	韓国は入学式が3月で，卒業式は2月です．	\N		\N	vmod	\N	\N	\N	0	1
622	삼촌하고는 자주 못 만나요.	おじとはしょっちゅうは会えません．	\N		\N	vmod	\N	\N	\N	0	1
623	무슨 색깔이 제일 좋아요?	何色がいちばん好きですか？	\N		\N	vmod	\N	\N	\N	0	1
624	그 백화점, 생선 코너가 없어졌던데요.	あのデパート，魚(鮮魚)コーナーがなくなってましたよ．	\N		\N	vmod	\N	\N	\N	0	1
625	샤워를 하고 있어서 전화벨 소리가 안 들렸어요.	シャワーをしていて電話のベルが聞こえませんでした．	\N		\N	vmod	\N	\N	\N	0	1
626	아침 저녁으로는 선선하네요.	朝晩は涼しいですね．	\N		\N	vmod	\N	\N	\N	0	1
627	그렇게 서 있지 말고 좀 앉으세요.	そんな風に立ってないで，お座りください．	\N		\N	vmod	\N	\N	\N	0	1
628	여기에서 서쪽은 어디가 되나요?	ここから西は，どっちになりますか？	\N		\N	vmod	\N	\N	\N	0	1
629	저는 설탕 한 스푼, 프림 두 스푼 넣어 주세요.	私は砂糖ひとさじ，クリームふたさじ入れてください．	\N		\N	vmod	\N	\N	\N	0	1
630	세로로 써 있는 것은 잘 못 읽겠어요.	縦に書いてあるのはうまく読めなさそうです．	\N		\N	vmod	\N	\N	\N	0	1
631	셔츠는 흰 색이 제일 잘 나가요.	シャツは白がいちばんよく売れます．	\N		\N	vmod	\N	\N	\N	0	1
632	준호 씨는 밝은 색 셔츠가 어울리는 것 같아요.	ジュノさんは明るい色のシャツが似合うと思います．	\N		\N	vmod	\N	\N	\N	0	1
633	수박에 소금을 뿌려 먹는 것은 처음 봤어요.	スイカに塩をふって食べるのは，初めて見ました．	\N		\N	vmod	\N	\N	\N	0	1
634	손수건을 선물하는 것은 정말 헤어진다는 의미인가요?	ハンカチをプレゼントするのは，本当に別れるという意味ですか？	\N		\N	vmod	\N	\N	\N	0	1
635	쇠고기 국을 끓이려면 뭐가 필요하죠?	牛肉のスープを作るのに，何が必要ですか？	\N		\N	vmod	\N	\N	\N	0	1
636	스트레스가 쌓이면 쇼핑을 하거나 영화를 봐요.	ストレスがたまると，買い物をしたり映画を見ます．	\N		\N	vmod	\N	\N	\N	0	1
637	더운데 수영장이나 갈까요?	暑いからプールでも行きましょうか？	\N		\N	vmod	\N	\N	\N	0	1
638	한국사람들은 숟가락하고 젓가락으로 밥을 먹어요.	韓国人はスプーンと箸でご飯を食べます．	\N		\N	vmod	\N	\N	\N	0	1
791	단어를 외우는 것이 가장 중요해요.	単語を覚えるのがいちばん重要です．	\N		\N	vmod	\N	\N	\N	0	1
639	한국어는 문법은 쉬운데 발음이 좀 어려워요.	韓国語は文法は易しいけど発音がちょっと難しいです．	\N		\N	vmod	\N	\N	\N	0	1
640	스웨터는 따뜻해서 한 장만 입어도 돼요.	セーターは暖かいので，1枚だけ着ても大丈夫です．	\N		\N	vmod	\N	\N	\N	0	1
641	바닥이 차가우니 슬리퍼를 신고 들어 오세요.	床が冷たいので，スリッパを履いてお入りください．	\N		\N	vmod	\N	\N	\N	0	1
642	이 시계 좀 빠르네요.	この時計，ちょっと進んでますね．	\N		\N	vmod	\N	\N	\N	0	1
643	시월에는 여러가지 과일을 많이 먹을 수 있어요.	10月にはいろいろな果物をたくさん食べられます．	\N		\N	vmod	\N	\N	\N	0	1
644	이제 곧 공연이 시작됩니다.	もうすぐ公演が始まります．	\N		\N	vmod	\N	\N	\N	0	1
645	오늘 신문 못 봤어?	今日新聞見てないの？	\N		\N	vmod	\N	\N	\N	0	1
646	벌써 십이월.. 올해도 한 달밖에 안 남았네요.	もう12月…今年もひと月しか残ってないですねえ．	\N		\N	vmod	\N	\N	\N	0	1
647	십일월에는 첫눈이 올지도 몰라요.	11月には初雪が降るかもしれませんよ．	\N		\N	vmod	\N	\N	\N	0	1
648	컴퓨터를 쓰니 요즘은 잘 안 쓰게 돼요.	コンピュータを使うので，最近はあまり書かなくなりました．	\N		\N	vmod	\N	\N	\N	0	1
649	햇볕이 강해서 모자라도 써야겠어요.	日差しが強いから，帽子でもかぶらなければいけませんね．	\N		\N	vmod	\N	\N	\N	0	1
650	아내는 어디 가고 혼자 왔어요?	奥さんはおいて一人で来たんですか？	\N		\N	vmod	\N	\N	\N	0	1
651	친구네 집 아래 층에 살아요.	友達の家の下の階に住んでます．	\N		\N	vmod	\N	\N	\N	0	1
652	아버지는 등산을 좋아하세요.	父は登山が好きです．	\N		\N	vmod	\N	\N	\N	0	1
653	아침은 거의 못 먹는 날이 많아요.	朝ごはんはほとんど食べられない日が多いです．	\N		\N	vmod	\N	\N	\N	0	1
654	몇 층짜리 아파트에요?	何階建てのアパートですか？	\N		\N	vmod	\N	\N	\N	0	1
655	머리가 아파서 소파에서 좀 쉬었어요.	頭が痛いのでソファで少し休みました．	\N		\N	vmod	\N	\N	\N	0	1
656	주머니 안에서 돈이 나왔어요.	ポケットの中からお金が出てきました．	\N		\N	vmod	\N	\N	\N	0	1
657	안경을 안 쓰면 하나도 안 보여요.	メガネをかけないと何にも見えません．	\N		\N	vmod	\N	\N	\N	0	1
658	여기 앉아서 잠시 쉬고 가요.	ここに座ってしばらく休んでいきましょう．	\N		\N	vmod	\N	\N	\N	0	1
660	이 종이는 너무 얇아서 잘 찢어져요.	この紙は薄すぎてよく破れます．	\N		\N	vmod	\N	\N	\N	0	1
661	양말 한 쪽이 없어졌어요.	靴下の片方がなくなりました．	\N		\N	vmod	\N	\N	\N	0	1
662	나가는 길에 양복 좀 세탁소에 맡겨 줄래?	出かける途中で背広をちょっとクリーニングに出してくれる？	\N		\N	vmod	\N	\N	\N	0	1
663	방이 너무 어둡네요.	部屋がすごく暗いですね．	\N		\N	vmod	\N	\N	\N	0	1
664	어른이면 어른답게 행동해야지요.	大人なら大人らしく行動しないと．	\N		\N	vmod	\N	\N	\N	0	1
665	저는 어머니하고 꼭 닮았어요.	私，母とそっくりなんです．	\N		\N	vmod	\N	\N	\N	0	1
666	어젯밤에 꿈을 꿨는데 잘 기억은 안 나요.	夕べ夢を見たんだけどよく思い出せません．	\N		\N	vmod	\N	\N	\N	0	1
667	저는 금방 얼굴이 빨개져요.	私はすぐに顔が赤くなります．	\N		\N	vmod	\N	\N	\N	0	1
668	짐이 많으니까 엘리베이터로 가죠?	荷物が重いからエレベーターで行きましょう．	\N		\N	vmod	\N	\N	\N	0	1
669	각국에서 여러 사람들이 모여 왔어요.	各国から大勢が集まってきました．	\N		\N	vmod	\N	\N	\N	0	1
670	여름 방학을 이용해 수화를 배우고 싶어요.	夏休みを使って手話を習いたいです．	\N		\N	vmod	\N	\N	\N	0	1
671	올 여름에는 바다로 놀러 가고 싶어요.	この夏は海に遊びに行きたいです．	\N		\N	vmod	\N	\N	\N	0	1
672	여자라고 무시하지 마세요.	女だからって無視しないでください．	\N		\N	vmod	\N	\N	\N	0	1
673	여자아이들 옷이 얼마나 예쁜 게 많은지 다 사고 싶었어요.	女の子の服がかわいいのがどれほど多いって，全部買いたかったですよ．	\N		\N	vmod	\N	\N	\N	0	1
674	어릴 때는 여행을 많이 데리고 다녀야 된대요.	小さいときには旅行にたくさん連れて行かなければならないそうです．	\N		\N	vmod	\N	\N	\N	0	1
675	우리 집은 살기는 편하데 역에서 너무 멀어요.	うちは住みやすいけど駅からとても遠いです．	\N		\N	vmod	\N	\N	\N	0	1
676	그런데 연습 시간은 몇 분이죠?	ところで練習時間は何分ですか？	\N		\N	vmod	\N	\N	\N	0	1
677	연습하면 누구나 다 잘할 수 있어요.	練習すれば誰でも上手にできます．	\N		\N	vmod	\N	\N	\N	0	1
678	오랜만에 연필로 글씨 써 보네요.	鉛筆で字を書くのは久しぶりですね．	\N		\N	vmod	\N	\N	\N	0	1
679	사람들이 계속 들어오니까 문을 그냥 열어 두세요.	人が続けて入ってくるから，ドアをそのまま開けておいてください．	\N		\N	vmod	\N	\N	\N	0	1
680	저...여기 열쇄 복사도 해요?	あの…，ここは鍵のコピーもやってますか？	\N		\N	vmod	\N	\N	\N	0	1
681	요즘 재미있는 영화 뭐 있어요?	最近面白い映画何かあります？	\N		\N	vmod	\N	\N	\N	0	1
682	얼굴만 예쁘면 뭐 해요.	顔だけきれいだからって何ですか．	\N		\N	vmod	\N	\N	\N	0	1
683	오월은 연휴가 많아서 좋아요.	5月は連休が多くていいです．	\N		\N	vmod	\N	\N	\N	0	1
684	오전 10시요?	午前10時ですか？	\N		\N	vmod	\N	\N	\N	0	1
685	수업은 대개 오후에 있어요.	授業はだいたい午後にあります．	\N		\N	vmod	\N	\N	\N	0	1
686	벌써 온 학교에 소문이 다 퍼졌어요.	もう学校中にうわさが広まっています．	\N		\N	vmod	\N	\N	\N	0	1
687	올해는 유난히 더운 것 같아요.	今年はとりわけ暑い気がします．	\N		\N	vmod	\N	\N	\N	0	1
688	외국은 어디어디 가 보셨어요?	外国はどちらにいらっしゃったことがありますか？	\N		\N	vmod	\N	\N	\N	0	1
689	여권이 있으면 외국인도 들어갈 수 있어요?	パスポートがあれば外国人も入れますか？	\N		\N	vmod	\N	\N	\N	0	1
846	마음은 아직 젊어요.	気分はまだ若いです．	\N		\N	vmod	\N	\N	\N	0	1
690	날씨가 좀 쌀쌀한데 외투를 걸치고 계세요.	ちょっと肌寒いからコートを羽織っていてください．	\N		\N	vmod	\N	\N	\N	0	1
691	욕실에서 나올 때 불 끄는 걸 깜박했어요.	ふろから出るときに電気を消すのを忘れてしまいました．	\N		\N	vmod	\N	\N	\N	0	1
692	커피에 우유를 좀 넣으실래요?	コーヒーに牛乳をちょっと入れますか？	\N		\N	vmod	\N	\N	\N	0	1
693	우체국에 들렀다 갈게요.	郵便局に寄っていきますよ．	\N		\N	vmod	\N	\N	\N	0	1
694	이 엽서 회사 가는 길에 우체통에 좀 넣어 주세요.	このはがき，会社に行く途中でポストに入れてください．	\N		\N	vmod	\N	\N	\N	0	1
695	시외는 얼마짜리 우표를 붙여야 되죠?	市外はいくらの切手を貼らなきゃいけませんか？	\N		\N	vmod	\N	\N	\N	0	1
696	월요일 아침은 일어나기 힘들어요.	月曜の朝は起きるのがつらいです．	\N		\N	vmod	\N	\N	\N	0	1
697	유월이 되니까 더워지기 시작하네요.	6月になると暑くなり始めますね．	\N		\N	vmod	\N	\N	\N	0	1
698	이 장학금 유학생도 신청할 수 있어요?	この奨学金，留学生も申し込めますか？	\N		\N	vmod	\N	\N	\N	0	1
699	은행에 좀 볼일이 있어 갔다 올게요.	銀行にちょっと用があるので，行ってきます．	\N		\N	vmod	\N	\N	\N	0	1
700	음료수 캔은 어디에 버려요?	飲み物の缶はどこに捨てますか？	\N		\N	vmod	\N	\N	\N	0	1
701	5년만에 새 음반을 냈습니다.	5年ぶりに新しいレコードを出しました．	\N		\N	vmod	\N	\N	\N	0	1
702	음악 소리가 너무 커요?	音楽の音が大きすぎますか？	\N		\N	vmod	\N	\N	\N	0	1
703	그 분은 외과 의사에요.	あの方は外科医です．	\N		\N	vmod	\N	\N	\N	0	1
704	이 의자 너무 편하겠다.	この椅子すごく楽そうね．	\N		\N	vmod	\N	\N	\N	0	1
706	살다가 이런 경우는 처음이에요.	生きてきてこんなことは初めてです．	\N		\N	vmod	\N	\N	\N	0	1
707	이번 달은 너무 바빠서 못 만나겠어요.	今月は忙しすぎて会えなさそうです．	\N		\N	vmod	\N	\N	\N	0	1
708	이번 주는 시험기간이라 수업이 없어요.	今週は試験期間で授業がありません．	\N		\N	vmod	\N	\N	\N	0	1
709	이월까지는 많이 추워요. 	2月まではかなり寒いです．	\N		\N	vmod	\N	\N	\N	0	1
710	일이 아무리 바빠도 일주일에 두번은 부모님께 전화합니다.	仕事がどんなに忙しくても，一週間に2回は両親に電話します．	\N		\N	vmod	\N	\N	\N	0	1
711	일월에는 여러가지 계획을 많이 세웠었지요.	1月にはいろいろ計画をたくさん立てましたよ．	\N		\N	vmod	\N	\N	\N	0	1
712	일본은 일하는 여성들이 많아요.	日本は働く女性が多いです．	\N		\N	vmod	\N	\N	\N	0	1
713	입구 쪽에서 기다리고 있을게요.	入り口の方で待ってますね．	\N		\N	vmod	\N	\N	\N	0	1
714	이 청바지 한 번 입어 봐도 돼요?	このジーンズ，いちど履いてみてもいいですか？	\N		\N	vmod	\N	\N	\N	0	1
715	입어 봤는데 잘 안 어울려서 바꾸려고요.	着てみたんだけど，あまり合わないのでとりかえようと思って．	\N		\N	vmod	\N	\N	\N	0	1
716	저기 검정 바지 입은 사람 어디서 본 적 없어요?	あそこの黒いズボンはいた人，どこかで見たことないですか？	\N		\N	vmod	\N	\N	\N	0	1
717	여긴 자동차 소음이 너무 심해요.	ここは車の騒音がひどすぎます．	\N		\N	vmod	\N	\N	\N	0	1
718	더우니까 짧게 잘라 주세요.	暑いから短く切ってください．	\N		\N	vmod	\N	\N	\N	0	1
719	자매인데 하나도 안 닯았어요.	姉妹なのにぜんぜん似ていません．	\N		\N	vmod	\N	\N	\N	0	1
720	여긴 자전거 타는 사람이 거의 없네요.	ここは自転車に乗る人がほとんどいませんね．	\N		\N	vmod	\N	\N	\N	0	1
721	그 바지, 자켓하고 잘 어울리는데요.	そのズボン，上着とよく合ってますね．	\N		\N	vmod	\N	\N	\N	0	1
722	작년에 일본에 와서 아직 1년이 안 됐어요.	去年日本に来て，まだ1年になっていません．	\N		\N	vmod	\N	\N	\N	0	1
723	작문 숙제는 어려워서 시간이 많이 걸려요.	作文の宿題は難しいので時間がかかります．	\N		\N	vmod	\N	\N	\N	0	1
724	저 노래도 잘해요.	私，歌も上手です．	\N		\N	vmod	\N	\N	\N	0	1
725	A4용지 20장 이내로 써서 보내 주세요.	A4の紙20枚以内で書いて，送ってください．	\N		\N	vmod	\N	\N	\N	0	1
726	저기, 재떨이 좀 주세요.	あの，ちょっと灰皿ください．	\N		\N	vmod	\N	\N	\N	0	1
727	생각보다는 별로 재미없어요.	思ったよりつまらないです．	\N		\N	vmod	\N	\N	\N	0	1
728	재작년까지는 전화도 오고 했는데, 요즘은 통 소식이 없네요.	おととしまでは電話もきたりしたんだけど，最近はぜんぜん連絡がないですね．	\N		\N	vmod	\N	\N	\N	0	1
729	살이 쪄서 저녁은 샐러드만 먹으려고요.	太ったんで夕食はサラダだけ食べようと思って．	\N		\N	vmod	\N	\N	\N	0	1
730	저녁은 어디서 먹을까요?	夕食はどこで食べましょうか？	\N		\N	vmod	\N	\N	\N	0	1
731	반을 만들기에는 학생 수가 좀 적은데요.	クラスを作るには学生の数がちょっと少ないんですが．	\N		\N	vmod	\N	\N	\N	0	1
732	주말은 길이 많이 막히니까 전철로 가는 게 좋겠어요.	週末は道がかなり混むから，電車で行くのがいいですよ．	\N		\N	vmod	\N	\N	\N	0	1
733	접시 닦는 아르바이트죠.	皿を拭くアルバイトですよ．	\N		\N	vmod	\N	\N	\N	0	1
734	우동은 나무 젓가락으로 먹는 게 편해요.	うどんは木の箸で食べるのが楽です．	\N		\N	vmod	\N	\N	\N	0	1
735	오늘은 유난히 조용하네요.	今日はひときわ静かですね．	\N		\N	vmod	\N	\N	\N	0	1
736	이마가 좁아서 인상이 별로 안 좋아요.	額が狭いので人相がそれほどよくありません．	\N		\N	vmod	\N	\N	\N	0	1
737	종이를 반으로 접어서 사용해 주세요.	紙を半分に折って使ってください．	\N		\N	vmod	\N	\N	\N	0	1
738	어머, 주머니에 구멍이 나 있었어요.	あら，ポケットに穴があいてましたよ．	\N		\N	vmod	\N	\N	\N	0	1
739	즐거운 시간 되세요.	楽しい時間をお過ごしください．	\N		\N	vmod	\N	\N	\N	0	1
740	덕분에 많이 즐거웠어요．	おかげでとても楽しかったです．	\N		\N	vmod	\N	\N	\N	0	1
741	지난 달부터 일을 시작해서 아직 많이 서툴러요. 	先月から仕事を始めたので，まだ慣れていません．	\N		\N	vmod	\N	\N	\N	0	1
742	우리가 갈 여행지를 지도에서도 한 번 확인해 보죠?	これから行く旅行先を地図でも一度確認してみましょうよ．	\N		\N	vmod	\N	\N	\N	0	1
743	연필로 쓰면 지울 수 있어서 좋아요.	鉛筆で書けば消せるのでいいですよ．	\N		\N	vmod	\N	\N	\N	0	1
744	질문이 있으신 분은 손을 들고 질문해 주세요.	質問がおありの方は手を挙げて質問なさってください．	\N		\N	vmod	\N	\N	\N	0	1
745	너무 짙은 색 옷만 입으면 사람이 어두워 보여요.	あまり濃い色の服ばかり着ると，人が暗く見えますよ．	\N		\N	vmod	\N	\N	\N	0	1
746	짧은 치마가 유행이에요.	短いスカートが流行です．	\N		\N	vmod	\N	\N	\N	0	1
748	침대는 창문 쪽에 두는 게 좋겠죠?	ベッドは窓の方におくのがいいでしょう？	\N		\N	vmod	\N	\N	\N	0	1
749	그 야채 가게는 시장보다 비싸서 잘 안 가요.	その八百屋は市場より高いのであまり行きません．	\N		\N	vmod	\N	\N	\N	0	1
750	천천히 준비하세요.	ゆっくり準備してください．	\N		\N	vmod	\N	\N	\N	0	1
751	집이 넓어서 청소하는 데 시간이 많이 걸려요.	家が広くて，掃除するのに時間がかなりかかります．	\N		\N	vmod	\N	\N	\N	0	1
752	저기요, 일본대사관에 가려면 몇 번 출구로 나가야 돼요?	あの，日本大使館に行くには何番出口に行けばいいですか？	\N		\N	vmod	\N	\N	\N	0	1
753	너무 추워서 잠을 못 자겠어요.	寒すぎて寝られなさそうです．	\N		\N	vmod	\N	\N	\N	0	1
754	어릴 때부터 피아노를 쳤어요.	子供の頃からピアノを弾きました．	\N		\N	vmod	\N	\N	\N	0	1
755	바지보다 치마가 더 잘 어울려요.	ズボンよりスカートの方がよく似合いますよ．	\N		\N	vmod	\N	\N	\N	0	1
756	치즈도 발효식품이에요.	チーズも発酵食品です．	\N		\N	vmod	\N	\N	\N	0	1
757	칠월은 장마라서 맑은 날이 별로 없어요.	7月は梅雨で天気のいい日があまりありません．	\N		\N	vmod	\N	\N	\N	0	1
758	주말엔 카레라이스나 해 먹죠?	週末はカレーでも作って食べましょうよ．	\N		\N	vmod	\N	\N	\N	0	1
759	요즘은 주로 디지털 카메라를 쓰죠.	最近は主にデジタルカメラを使いますよ．	\N		\N	vmod	\N	\N	\N	0	1
760	코가 참 오똑하네요.	ほんとに鼻が高いですね．	\N		\N	vmod	\N	\N	\N	0	1
761	택시 정류장에 가시면 대기하고 있는 택시가 많아요.	タクシー乗り場に行けば，待っているタクシーが多いですよ．	\N		\N	vmod	\N	\N	\N	0	1
762	테이블 위에 올려 놨는데.	テーブルの上に置いておいたんだけど．	\N		\N	vmod	\N	\N	\N	0	1
763	이 텔레비젼 몇 인치에요?	このテレビ，何インチですか？	\N		\N	vmod	\N	\N	\N	0	1
764	토요일에 명동을 갔는데 사람이 너무 많아서 아무것도 못 했어요.	土曜日に明洞に行ったんですが，人が多すぎて何もできませんでしたよ．	\N		\N	vmod	\N	\N	\N	0	1
765	파랑이라 시원해 보여요.	青だからさっぱりして見えます．	\N		\N	vmod	\N	\N	\N	0	1
766	지갑을 잃어버렸는데, 파출소에 신고하는 게 좋을까요?	財布をなくしちゃったんですけど，交番に届け出るのがいいでしょうかね？	\N		\N	vmod	\N	\N	\N	0	1
767	우리 다 같이 크리스마스 파티 해요.	みんなでクリスマスパーティーしましょうよ．	\N		\N	vmod	\N	\N	\N	0	1
768	아기를 안고 있었더니 팔이 아파요.	子供を抱っこしていたので，腕が痛いです．	\N		\N	vmod	\N	\N	\N	0	1
769	팔월에 휴가 가는 사람이 제일 많아요.	8月に休暇をとって出かける人がいちばん多いです．	\N		\N	vmod	\N	\N	\N	0	1
770	고기가 너무 큰데 나이프하고 포크 좀 주실래요?	肉がすごく大きいので，ナイフとフォークをもらえますか？	\N		\N	vmod	\N	\N	\N	0	1
771	아니에요, 프랑스어는 아직 서툴러요.	いいえ，フランス語はまだうまくありません．	\N		\N	vmod	\N	\N	\N	0	1
772	필름 한 통에 얼마에요?	フィルム1本いくらですか？	\N		\N	vmod	\N	\N	\N	0	1
773	올 여름 원피스는 하양이 유행이에요.	この夏のワンピースは白が流行です．	\N		\N	vmod	\N	\N	\N	0	1
774	한자를 공부하는 사람들이 점점 줄고 있어요.	漢字を勉強する人がだんだん減っています．	\N		\N	vmod	\N	\N	\N	0	1
775	할머니는 따로 사세요.	おばあさんは別に住んでいます．	\N		\N	vmod	\N	\N	\N	0	1
776	할아버지는 먼저 돌아가셨어요.	おじいさんはもうなくなりました．	\N		\N	vmod	\N	\N	\N	0	1
777	헤엄쳐서 가기엔 좀 먼 것 같은데.	泳いでいくにはちょっと遠いと思うけど．	\N		\N	vmod	\N	\N	\N	0	1
778	현관에서 신을 벋고 들어 오세요.	玄関で靴を脱いで入ってきてください．	\N		\N	vmod	\N	\N	\N	0	1
779	형님은 건강하세요?	お兄さんはお元気ですか？	\N		\N	vmod	\N	\N	\N	0	1
780	형하고는 두 살 차이에요.	兄とは二つ違いです．	\N		\N	vmod	\N	\N	\N	0	1
781	형제가 어떻게 돼요?	兄弟は何人ですか？	\N		\N	vmod	\N	\N	\N	0	1
782	호텔 예약은 하셨어요?	ホテルの予約はなさいましたか？	\N		\N	vmod	\N	\N	\N	0	1
783	홍차도 좋아하지만 커피를 더 좋아해요.	紅茶も好きですが，コーヒーの方がもっと好きです．	\N		\N	vmod	\N	\N	\N	0	1
784	저기 화요일에는 시간 되시나요?	あの，火曜日はお時間よろしいでしょうか？	\N		\N	vmod	\N	\N	\N	0	1
785	회사에 갈 땐 넥타이를 매지만 평소에는 셔츠차림이에요.	会社に行くときはネクタイを締めますけど，いつもはシャツです．	\N		\N	vmod	\N	\N	\N	0	1
786	휴일엔 주로 가족들하고 외식을 해요.	休日は主に家族と外食します．	\N		\N	vmod	\N	\N	\N	0	1
787	아침에는 흐렸는데, 금방 개였어요.	朝は曇っていましたが，すぐに晴れました．	\N		\N	vmod	\N	\N	\N	0	1
788	일기예보를 보니 종일 흐림이에요.	天気予報を見たら，一日中曇りです．	\N		\N	vmod	\N	\N	\N	0	1
789	그녀는 이 세상에 없지만 그는 슬퍼하지 않았다.	彼女はこの世にいないが，彼は悲しまなかった．	\N		\N	vmod	\N	\N	\N	0	1
790	저, 이 가방 좀 받아 주실래요?	あの、このかばんちょっと持っていただけませんか？	\N		\N	vmod	\N	\N	\N	0	1
792	사과는 몇 개 드릴까요?	リンゴはいくつ差し上げましょうか？	\N		\N	vmod	\N	\N	\N	0	1
793	이 길로 쭉 가세요.	この道をまっすぐ行ってください．	\N		\N	vmod	\N	\N	\N	0	1
794	책상을 붙여 놓으세요.	机をくっつけておいてください．	\N		\N	vmod	\N	\N	\N	0	1
795	이 신 너무 낡아서 버려야겠어요.	この靴古すぎて捨てなければいけませんね．	\N		\N	vmod	\N	\N	\N	0	1
796	머리가 가늘어서 금방 상해요.	髪が細いので，すぐ傷みます．	\N		\N	vmod	\N	\N	\N	0	1
797	이 가방은 가벼워서 좋아요.	このかばんは軽くていいです．	\N		\N	vmod	\N	\N	\N	0	1
798	선생님께 이 편지 좀 건네 주세요．	先生にこの手紙ちょっと渡してください．	\N		\N	vmod	\N	\N	\N	0	1
799	어떤 과자 좋아해요?	どんなお菓子が好きですか？	\N		\N	vmod	\N	\N	\N	0	1
800	목이 굵어서 맞는 옷이 없어요.	首が太くて合う服がありません．	\N		\N	vmod	\N	\N	\N	0	1
801	집에 책이 몇 권 정도 있어요?	家に本が何冊くらいありますか？	\N		\N	vmod	\N	\N	\N	0	1
802	그 사람들은 뭐하는 사람들이에요?	彼らは何をする人たちですか？	\N		\N	vmod	\N	\N	\N	0	1
803	집까지 날아서 갔으면 좋겠어요.	家まで飛んでいけたらいいですよ．	\N		\N	vmod	\N	\N	\N	0	1
804	남자 선생님이 너무 부족해요.	男の先生がぜんぜん足りません．	\N		\N	vmod	\N	\N	\N	0	1
805	남쪽에는 예쁜 섬들이 많아요.	南にはきれいな島が多いです．	\N		\N	vmod	\N	\N	\N	0	1
806	점수가 너무 낮아요．	点数が低すぎます．	\N		\N	vmod	\N	\N	\N	0	1
807	전 창이 넓은 집이 좋아요.	私は窓の広い家がいいです．	\N		\N	vmod	\N	\N	\N	0	1
808	전 노란 색 꽃이 좋아요.	私は黄色い花が好きです．	\N		\N	vmod	\N	\N	\N	0	1
810	다음다음 해에는 볼 수 있겠죠?	再来年には会えるでしょう？	\N		\N	vmod	\N	\N	\N	0	1
811	줄 맨 뒤에 섰다.	列の一番後ろに立った．	\N		\N	vmod	\N	\N	\N	0	1
812	가족들이 다 모여서 집이 떠들썩해요.	家族がみんな集まって，家がにぎやかです．	\N		\N	vmod	\N	\N	\N	0	1
813	그런 것은 좀 더 빨리 말해 줘야죠.	そういうことはもう少し早く言ってくれないと．	\N		\N	vmod	\N	\N	\N	0	1
814	거기 이야기하고 있는 두 사람， 좀 조용히 해 주세요．	そこの話している二人，ちょっと静かにしてください．	\N		\N	vmod	\N	\N	\N	0	1
815	대통령은 기자회견에서 경제 계획에 대해 구체적으로 말했다.	大統領は記者会見で，経済計画について具体的に語った．	\N		\N	vmod	\N	\N	\N	0	1
816	술을 마셔서 머리가 아파요.	お酒を飲んだので頭が痛いです．	\N		\N	vmod	\N	\N	\N	0	1
817	너무 무거워서 혼자는 못 들겠어요.	重すぎて一人では持てなさそうです．	\N		\N	vmod	\N	\N	\N	0	1
818	방이 더러워서 청소 좀 하려고요.	部屋が汚いのでちょっと掃除しようと思って．	\N		\N	vmod	\N	\N	\N	0	1
819	봄에는 새로운 상품이 많이 나와요.	春には新しい商品がたくさん出ます．	\N		\N	vmod	\N	\N	\N	0	1
820	그 사람 몸집은 작아도 힘은 아주 세요.	あの人，体つきは小さいけど力はすごく強いですよ．	\N		\N	vmod	\N	\N	\N	0	1
821	밥 먹기 전에는 깨끗히 손을 씻으세요.	ご飯を食べる前にはきれいに手を洗ってください．	\N		\N	vmod	\N	\N	\N	0	1
822	아빠는 회사에 가고 안 계세요.	お父さんは会社に行っていません．	\N		\N	vmod	\N	\N	\N	0	1
824	얘는 엄마를 많이 닮았네요.	この子はお母さんによく似てますねえ．	\N		\N	vmod	\N	\N	\N	0	1
825	여행할 때 많이 쓰는 한국어를 공부하고 있어요.	旅行するときよく使う韓国語を勉強しています．	\N		\N	vmod	\N	\N	\N	0	1
826	어제 한국에 있는 친구들에게 엽서를 보냈어요.	昨日韓国にいる友達にはがきを送りました．	\N		\N	vmod	\N	\N	\N	0	1
827	이모가 두 분 계시죠.	おば(母方の)が二人います．	\N		\N	vmod	\N	\N	\N	0	1
828	입을 크게 벌리세요.	口を大きく開いてください．	\N		\N	vmod	\N	\N	\N	0	1
829	이거보다 좀 더 작은 가방 없어요?	これよりもうちょっと小さいかばんはありませんか？	\N		\N	vmod	\N	\N	\N	0	1
830	저희 회사는 서비스에 많은 노력을 기울이고 있습니다.	私どもの会社はサービスに多くの努力を傾けております．	\N		\N	vmod	\N	\N	\N	0	1
831	벨트를 너무 졸라 매서 숨 쉬기가 힘들어요.	ベルトを締めすぎて息をするのが大変です．	\N		\N	vmod	\N	\N	\N	0	1
832	주문하신 제품은 일주일 후에 도착할 겁니다.	ご注文の製品は1週間後に到着する予定です．	\N		\N	vmod	\N	\N	\N	0	1
833	이번 사고로 많은 사람이 다치고 죽었대요.	今度の事故で，たくさんの人が怪我して亡くなったそうです．	\N		\N	vmod	\N	\N	\N	0	1
834	지갑을 깜박 잊고 안 갖고 왔어요.	財布をうっかり忘れて持ってきませんでした．	\N		\N	vmod	\N	\N	\N	0	1
835	저기, 찬 물은 없어요?	あの，冷たい水はないですか？	\N		\N	vmod	\N	\N	\N	0	1
836	설거지하다가 그만 컵을 깨뜨렸어요.	洗い物をしていてコップを割ってしまいました．	\N		\N	vmod	\N	\N	\N	0	1
837	그 백화점에서 파는 음식은 다 신선해요.	あのデパートで売っている食べ物はみんな新鮮です．	\N		\N	vmod	\N	\N	\N	0	1
838	여행할 때 지도를 가지고 다니면 편리해요.	旅行するとき地図を持っていくと便利です．	\N		\N	vmod	\N	\N	\N	0	1
839	날씨: 흐림	天気：曇り．	\N		\N	vmod	\N	\N	\N	0	1
840	이 앞에 아파트가 생긴다면서.	この先にアパートができるんだって？	\N		\N	vmod	\N	\N	\N	0	1
841	아이들의 울음소리가 슬픔을 더했다.	子供らの泣き声が，悲しみを加えた．	\N		\N	vmod	\N	\N	\N	0	1
842	2에 2를 더하면 뭐가 되죠?	2に2を足すといくつになりますか？	\N		\N	vmod	\N	\N	\N	0	1
843	아니에요, 프랑스어는 아직 서툴러요.	いいえ，フランス語はまだ下手ですよ．	\N		\N	vmod	\N	\N	\N	0	1
844	죄송합니다만, 논문 좀 체크해 주실래요?	すみませんが，論文をちょっとチェックしていただけますか？	\N		\N	vmod	\N	\N	\N	0	1
845	늦어서 죄송합니다.	遅くなってすみません．	\N		\N	vmod	\N	\N	\N	0	1
847	세계적으로 한국말을 배우는 사람이 늘어나고 있다.	韓国語を学ぶ人が世界的に増えている．	\N		\N	vmod	\N	\N	\N	0	1
848	비가 내려서인지 허리가 아파요.	雨が降るせいか腰が痛いです．	\N		\N	vmod	\N	\N	\N	0	1
\.


--
-- Data for Name: t_scene; Type: TABLE DATA; Schema: public; Owner: ko
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
-- Data for Name: t_usage; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_usage (usage_id, word_id, explanation, disp_priority, selected) FROM stdin;
1	487	行く	1	1
2	488	英語	1	1
3	489	飛行機	1	1
4	490	外国	1	1
5	491	外国人	1	1
6	492	フランス語	1	1
7	493	ホテル	1	1
8	494	日本語	1	1
9	495	出掛ける	1	1
10	496	国（くに）	1	1
11	497	会う	1	1
12	498	休み	1	1
13	499	旅行	1	1
14	500	旅行する	1	1
15	501	遊ぶ	1	1
16	502	大使館	1	1
17	503	大好き	1	1
18	504	好き	1	1
19	505	上手（じょうず）	1	1
20	506	走る	1	1
21	507	ゆっくり	1	1
22	508	下手（へた）	1	1
23	509	歩く	1	1
24	510	泳ぐ	1	1
25	511	速い［スピードが～］	1	1
26	512	飛ぶ	1	1
27	513	スポーツ	1	1
28	514	嫌い	1	1
29	515	プール	1	1
30	516	バス	1	1
31	517	自転車	1	1
32	518	交差点	1	1
33	519	道（みち）	1	1
34	520	池	1	1
35	521	散歩	1	1
36	522	かわ（川・河）	1	1
37	523	タクシー	1	1
38	524	自動車，車（くるま）	1	1
39	525	曲がる	1	1
40	526	ネクタイ	1	1
41	527	ワイシャツ	1	1
42	528	会社	1	1
43	529	背広	1	1
44	530	やる	1	1
45	531	吸う	1	1
46	532	電話	1	1
47	533	仕事	1	1
48	534	働く・勤める	1	1
49	535	忙しい	1	1
50	536	図書館	1	1
51	537	辞書，字引	1	1
52	538	借りる	1	1
53	539	新聞	1	1
54	540	読む	1	1
55	541	本	1	1
56	542	コピー	1	1
57	543	コピーする	1	1
58	544	雑誌	1	1
59	545	冊	1	1
60	546	牛肉	1	1
61	547	安い	1	1
62	548	店	1	1
63	549	高い	1	1
64	550	いくつ	1	1
65	551	いくら	1	1
66	552	果物	1	1
67	553	野菜	1	1
68	554	魚	1	1
69	555	豚肉	1	1
70	556	鳥肉	1	1
71	557	肉	1	1
72	558	欲しい	1	1
73	559	渡す	1	1
74	560	八百屋	1	1
75	561	かぎ（鍵）	1	1
76	562	料理	1	1
77	563	買い物する	1	1
78	564	洗濯する	1	1
79	565	掃除する	1	1
80	566	家族	1	1
81	567	家庭	1	1
82	568	庭（にわ）	1	1
83	569	洗濯	1	1
84	570	うち（家）	1	1
85	571	家（いえ）	1	1
86	572	掃除	1	1
87	573	かえる（帰・返）	1	1
88	574	本棚	1	1
89	575	机	1	1
90	576	椅子（いす）	1	1
91	577	部屋	1	1
92	578	冷蔵庫	1	1
93	579	洗う	1	1
94	580	ベッド	1	1
95	581	ラジオ	1	1
96	582	ラジカセ	1	1
97	583	～という名前です	1	1
98	584	寝る	1	1
99	585	起きる	1	1
100	586	テーブル	1	1
101	587	テレビ	1	1
102	588	お巡りさん	1	1
103	589	警官	1	1
104	590	地図	1	1
105	591	そば	1	1
106	592	ここ,こちら, こっち	1	1
107	593	そこ,そちら, そっち	1	1
108	594	あちら, あっち，あそこ	1	1
109	595	どこ,どちら,どっち	1	1
110	596	交番	1	1
111	597	近く	1	1
112	598	隣	1	1
113	599	きく	1	1
114	600	切る	1	1
115	601	短い	1	1
116	602	後ろ	1	1
117	603	前	1	1
118	604	右	1	1
119	605	左	1	1
120	606	長い	1	1
121	607	座る	1	1
122	608	立つ	1	1
123	609	友達	1	1
124	610	クラス	1	1
125	611	教室	1	1
126	612	廊下	1	1
127	613	学校	1	1
128	614	生徒	1	1
129	615	勉強	1	1
130	616	学生	1	1
131	617	留学生	1	1
132	618	夏休み	1	1
133	619	先生	1	1
134	620	大学	1	1
135	621	ノート	1	1
136	622	授業	1	1
137	623	作文	1	1
138	624	宿題	1	1
139	625	難しい	1	1
140	626	教える	1	1
141	627	テスト	1	1
142	628	練習	1	1
143	629	易しい	1	1
144	630	練習する	1	1
145	631	質問	1	1
146	632	問題	1	1
147	633	答える	1	1
148	634	痛い	1	1
149	635	歯	1	1
150	636	医者	1	1
151	637	病院	1	1
152	638	病気	1	1
153	639	薬（くすり）	1	1
154	640	死ぬ	1	1
155	641	風邪（かぜ）	1	1
156	642	頭（あたま）	1	1
157	643	お腹	1	1
158	644	度（ど）	1	1
159	645	エレベーター	1	1
160	646	切符	1	1
161	647	おりる	1	1
162	648	階段	1	1
163	649	閉める	1	1
164	650	駅	1	1
165	651	地下鉄	1	1
166	652	乗る	1	1
167	653	開ける	1	1
168	654	お手洗い	1	1
169	655	トイレ	1	1
170	656	電車	1	1
171	657	飲み物	1	1
172	658	コーヒー	1	1
173	659	喫茶店	1	1
174	660	レモン	1	1
175	661	牛乳	1	1
176	662	砂糖	1	1
177	663	カップ	1	1
178	664	お茶	1	1
179	665	紅茶	1	1
180	666	コップ	1	1
181	667	入れる	1	1
182	668	甘い	1	1
183	669	飲む	1	1
184	670	はし	1	1
185	671	酒	1	1
186	672	おいしい	1	1
187	673	ナイフ	1	1
188	674	スプーン	1	1
189	675	フォーク	1	1
190	676	チーズ	1	1
191	677	食べる	1	1
192	678	まずい	1	1
193	679	パン	1	1
194	680	辛い	1	1
195	681	レストラン	1	1
196	682	食堂	1	1
197	683	酒・ワイン	1	1
198	684	食べ物	1	1
199	685	カレー	1	1
200	686	お金	1	1
201	687	銀行	1	1
202	688	入り口	1	1
203	689	どうぞ,どういたしまして	1	1
204	690	いいえ	1	1
205	691	ええ	1	1
206	692	すみません	1	1
207	693	どうぞ	1	1
208	694	出口	1	1
209	695	着く	1	1
210	696	ポスト	1	1
211	697	はがき	1	1
212	698	張る	1	1
213	699	封筒	1	1
214	700	手紙	1	1
215	701	郵便局	1	1
216	702	返す	1	1
217	703	出す	1	1
218	704	切手	1	1
219	705	荷物	1	1
220	706	枚	1	1
221	707	貸す	1	1
222	708	買う	1	1
223	709	帽子	1	1
224	710	靴	1	1
225	711	買い物	1	1
226	712	階	1	1
227	713	デパート	1	1
228	714	スカート	1	1
229	715	コート	1	1
230	716	ズボン	1	1
231	717	セーター	1	1
232	718	…てください	1	1
233	719	かばん	1	1
234	720	売る	1	1
235	721	上着	1	1
236	722	ふろ	1	1
237	723	建物	1	1
238	724	台所	1	1
239	725	シャワー	1	1
240	726	窓	1	1
241	727	住む	1	1
242	728	公園	1	1
243	729	ドア	1	1
244	730	浴びる［一風呂～］	1	1
245	731	アパート	1	1
246	732	玄関	1	1
247	733	彼，彼女	1	1
248	734	彼ら，彼女たち	1	1
249	735	私（わたし）	1	1
250	736	私たち	1	1
251	737	だれか	1	1
252	738	だれ	1	1
253	739	どなた	1	1
254	740	きみ	1	1
255	741	あなた	1	1
256	742	この	1	1
257	743	その，あの	1	1
258	744	いかが，どう	1	1
259	745	どの	1	1
260	746	どんな	1	1
261	747	こんな	1	1
262	748	自分	1	1
263	749	そう	1	1
264	750	厚い	1	1
265	751	狭い	1	1
266	752	細い	1	1
267	753	大きい	1	1
268	754	太い	1	1
269	755	若い	1	1
270	756	広い	1	1
271	757	軽い	1	1
272	758	遠い	1	1
273	759	重い	1	1
274	760	薄い	1	1
275	761	新しい	1	1
276	762	小さい	1	1
277	763	近い	1	1
278	764	古い	1	1
279	765	楽しい	1	1
280	766	にぎやか	1	1
281	767	低い	1	1
282	768	よい	1	1
283	769	明るい	1	1
284	770	弱い	1	1
285	771	強い	1	1
286	772	おもしろい	1	1
287	773	きれい	1	1
288	774	遅い	1	1
289	775	悪い	1	1
290	776	多い	1	1
291	777	暗い	1	1
292	778	静か	1	1
293	779	少ない	1	1
294	780	汚い	1	1
295	781	つまらない	1	1
296	782	横	1	1
297	783	中（なか）	1	1
298	784	外（そと）	1	1
299	785	東（ひがし）	1	1
300	786	高さ	1	1
301	787	縦	1	1
302	788	北（きた）	1	1
303	789	西（にし）	1	1
304	790	下（した）	1	1
305	791	南（みなみ）	1	1
306	792	上（うえ）	1	1
307	793	先（さき）	1	1
308	794	後（あと）	1	1
309	795	いとこ	1	1
310	796	兄	1	1
311	797	兄弟（きょうだい）	1	1
312	798	おばあさん	1	1
313	799	おじいさん	1	1
314	800	奥さん	1	1
315	801	母	1	1
316	802	叔父，伯父	1	1
317	803	両親	1	1
318	804	父	1	1
319	805	姉	1	1
320	806	姉妹	1	1
321	807	叔母，伯母(父方のおば)	1	1
322	808	お兄さん	1	1
323	809	お姉さん	1	1
324	810	お父さん	1	1
325	811	お母さん	1	1
326	812	靴下	1	1
327	813	シャツ	1	1
328	814	脱ぐ	1	1
329	815	架ける	1	1
330	816	は（穿）く［ズボンを～］	1	1
331	817	着る	1	1
332	818	かぶる	1	1
333	819	ハンカチ	1	1
334	820	スリッパ	1	1
335	821	傘	1	1
336	822	ポケット	1	1
337	823	財布	1	1
338	824	着ている	1	1
339	825	服	1	1
340	826	洋服	1	1
341	827	口	1	1
342	828	腕（うで）	1	1
343	829	体（からだ）	1	1
344	830	顔	1	1
345	831	脚（あし）	1	1
346	832	手（て）	1	1
347	833	鼻	1	1
348	834	目（め）	1	1
349	835	耳	1	1
350	836	足（あし）	1	1
351	837	おなか	1	1
352	838	皿（さら）	1	1
353	839	バター	1	1
354	840	茶わん	1	1
355	841	あめ	1	1
356	842	昼御飯	1	1
357	843	夕飯（ゆうはん）	1	1
358	844	お菓子	1	1
359	845	卵	1	1
360	846	朝御飯	1	1
361	847	御飯（ごはん）	1	1
362	848	醤油	1	1
363	849	塩（しお）	1	1
364	850	晩御飯	1	1
365	851	くわえる	1	1
366	852	つける	1	1
367	853	カメラ	1	1
368	854	ストーブ	1	1
369	855	鉛筆	1	1
370	856	消す	1	1
371	857	眼鏡（めがね）	1	1
372	858	テープレコーダー	1	1
373	859	時計	1	1
374	860	コンピュータ	1	1
375	861	フィルム	1	1
376	862	戸（と）	1	1
377	863	門（もん）	1	1
378	864	ペン	1	1
379	865	万年筆	1	1
380	866	ボールペン	1	1
381	867	八月	1	1
382	868	四月	1	1
383	869	今月	1	1
384	870	毎月（まいつき）	1	1
385	871	十二月	1	1
386	872	二月	1	1
387	873	一月	1	1
388	874	七月	1	1
389	875	六月	1	1
390	876	来月	1	1
391	877	五月	1	1
392	878	三月	1	1
393	879	先月	1	1
394	880	十一月	1	1
395	881	十月	1	1
396	882	九月	1	1
397	883	ひとつき	1	1
398	884	今週	1	1
399	885	毎週	1	1
400	886	日曜日	1	1
401	887	木曜日	1	1
402	888	来週	1	1
403	889	月曜日	1	1
404	890	火曜日	1	1
405	891	水曜日	1	1
406	892	土曜日	1	1
407	893	週間	1	1
408	894	先週	1	1
409	895	金曜日	1	1
410	896	年（ねん）	1	1
411	897	秋	1	1
412	898	今年（ことし）	1	1
413	899	毎年（まいとし）	1	1
414	900	夏（なつ）	1	1
415	901	冬	1	1
416	902	去年	1	1
417	903	来年	1	1
418	904	春	1	1
419	905	再来年	1	1
420	906	おととし	1	1
421	907	午後	1	1
422	908	今日（きょう）	1	1
423	909	明日（あした）	1	1
424	910	時（じ）	1	1
425	911	昨日（きのう）	1	1
426	912	夕べ	1	1
427	913	午前	1	1
428	914	朝	1	1
429	915	昼	1	1
430	916	夜（よる）	1	1
431	917	夕方	1	1
432	918	あさって	1	1
433	919	おととい	1	1
434	920	もう	1	1
435	921	ながら	1	1
436	922	まだ	1	1
437	923	中(ちゅう)	1	1
438	924	時（とき）	1	1
439	925	いつ	1	1
440	926	ときどき	1	1
441	927	しばしば	1	1
442	928	時間	1	1
443	929	すぐ	1	1
444	930	灰皿	1	1
445	931	歌（うた）	1	1
446	932	歌う	1	1
447	933	たばこ	1	1
448	934	映画	1	1
449	935	レコード	1	1
450	936	ギター	1	1
451	937	弾く	1	1
452	938	音楽	1	1
453	939	絵（え）	1	1
454	940	写真	1	1
455	941	好き，気に入る	1	1
456	942	声	1	1
457	943	晴れ	1	1
458	944	暑い	1	1
459	945	晴れる	1	1
460	946	涼しい	1	1
461	947	寒い	1	1
462	948	雪（ゆき）	1	1
463	949	雨が降る	1	1
464	950	雨（あめ）	1	1
465	951	天気	1	1
466	952	あたたかい（暖・温）	1	1
467	953	風（かぜ）	1	1
468	954	曇り	1	1
469	955	冷たい	1	1
470	956	曇る	1	1
471	957	漢字	1	1
472	958	言う	1	1
473	959	書く	1	1
474	960	話（はなし）	1	1
475	961	言葉	1	1
476	962	～語	1	1
477	963	語（ご）	1	1
478	964	話す	1	1
479	965	文章	1	1
480	966	語る	1	1
481	967	意味	1	1
482	968	平仮名	1	1
483	969	片仮名	1	1
484	970	大人（おとな）	1	1
485	971	大勢	1	1
486	972	夫婦	1	1
487	973	子供	1	1
488	974	妻	1	1
489	975	女（おんな）	1	1
490	976	男の子	1	1
491	977	人（ひと）	1	1
492	978	男（おとこ）	1	1
493	979	女の子	1	1
494	980	夫	1	1
495	981	人	1	1
496	982	みんな	1	1
497	983	白（しろ），白い	1	1
498	984	青，青い	1	1
499	985	茶色	1	1
500	986	明るい，淡い	1	1
501	987	色（いろ）	1	1
502	988	濃い，暗い	1	1
503	989	黄色（きいろ），黄色い	1	1
504	990	黒（くろ），黒い	1	1
505	991	赤，赤い	1	1
506	992	緑	1	1
507	993	便利	1	1
508	994	パーティー	1	1
509	995	紙	1	1
510	996	～になる	1	1
511	997	締める	1	1
512	998	押す	1	1
513	999	始まる	1	1
514	1000	ちょうど	1	1
515	1001	ない	1	1
516	1002	まっすぐ	1	1
517	1003	有名	1	1
518	1004	元気	1	1
519	1005	じゃあ	1	1
520	1006	多分	1	1
521	1007	では	1	1
522	1008	韓国語	1	1
523	242	韓国語	1	1
524	1009	叔母，伯母(母方のおば)	1	1
525	122	靴	1	1
526	1010	いいえ	1	1
527	1011	すみません	1	1
\.


--
-- Data for Name: t_usage_classified_rel; Type: TABLE DATA; Schema: public; Owner: ko
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
524	16869	1.215	1.21	体	主体	家族	親戚	伯母・叔母（おば）	伯母・叔母	おば
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
522	30586	1.3101	1.31	体	活動	言語	言語	フランス語	フランス語	ふらんすご
523	30586	1.3101	1.31	体	活動	言語	言語	フランス語	フランス語	ふらんすご
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
284	92363	3.1400001	3.14	相	関係	力	力	弱い	弱い	よわい
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
525	50246	1.426	1.42	体	生産物	衣料	履き物	靴	靴	くつ
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
527	100468	4.3010001	4.30	他		感動	間投	あの	あの	あの
520	100538	4.3099999	4.31	他		判断	判断	多分	多分	たぶん
203	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
207	100772	4.3200002	4.32	他		呼び掛け	呼び掛け・指図	どうぞ	どうぞ	どうぞ
205	100800	4.3210001	4.32	他		呼び掛け	応答	ええ	ええ	ええ
204	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
526	100827	4.3210001	4.32	他		呼び掛け	応答	いいえ	いいえ	いいえ
521	100928	4.3309999	4.33	他		挨拶	挨拶語	では	では	では
\.


--
-- Data for Name: t_usage_inst_rel; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_usage_inst_rel (id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index) FROM stdin;
1	62	371	0	\N	0	\N	\N
2	62	458	0	\N	0	\N	\N
3	155	311	0	\N	0	\N	\N
4	1	16	0	\N	0	\N	\N
5	1	17	0	\N	0	\N	\N
6	1	85	0	\N	0	\N	\N
7	1	86	0	\N	0	\N	\N
8	1	94	0	\N	0	\N	\N
9	1	105	0	\N	0	\N	\N
10	1	106	0	\N	0	\N	\N
11	1	107	0	\N	0	\N	\N
12	1	118	0	\N	0	\N	\N
13	1	120	0	\N	0	\N	\N
14	1	126	0	\N	0	\N	\N
15	1	129	0	\N	0	\N	\N
16	1	144	0	\N	0	\N	\N
17	1	145	0	\N	0	\N	\N
18	1	146	0	\N	0	\N	\N
19	1	158	0	\N	0	\N	\N
20	1	171	0	\N	0	\N	\N
21	1	244	0	\N	0	\N	\N
22	1	309	0	\N	0	\N	\N
23	1	326	0	\N	0	\N	\N
24	1	409	0	\N	0	\N	\N
25	1	467	0	\N	0	\N	\N
26	1	28	0	\N	0	\N	\N
27	140	481	0	\N	0	\N	\N
28	107	200	0	\N	0	\N	\N
29	107	324	0	\N	0	\N	\N
30	1	91	0	\N	0	\N	\N
31	1	121	0	\N	0	\N	\N
32	1	122	0	\N	0	\N	\N
33	1	125	0	\N	0	\N	\N
34	1	143	0	\N	0	\N	\N
35	1	433	0	\N	0	\N	\N
36	1	436	0	\N	0	\N	\N
37	504	59	0	\N	0	\N	\N
38	162	204	0	\N	0	\N	\N
39	129	127	0	\N	0	\N	\N
40	129	274	0	\N	0	\N	\N
41	129	439	0	\N	0	\N	\N
42	129	469	0	\N	0	\N	\N
43	66	233	0	\N	0	\N	\N
44	66	236	0	\N	0	\N	\N
45	66	239	0	\N	0	\N	\N
46	257	101	0	\N	0	\N	\N
47	257	123	0	\N	0	\N	\N
48	257	174	0	\N	0	\N	\N
49	257	260	0	\N	0	\N	\N
51	257	379	0	\N	0	\N	\N
52	257	421	0	\N	0	\N	\N
53	257	437	0	\N	0	\N	\N
54	519	34	0	\N	0	\N	\N
55	519	75	0	\N	0	\N	\N
56	519	85	0	\N	0	\N	\N
57	519	102	0	\N	0	\N	\N
58	519	118	0	\N	0	\N	\N
59	519	125	0	\N	0	\N	\N
60	519	131	0	\N	0	\N	\N
61	519	158	0	\N	0	\N	\N
62	519	163	0	\N	0	\N	\N
63	519	191	0	\N	0	\N	\N
64	519	250	0	\N	0	\N	\N
65	519	300	0	\N	0	\N	\N
66	519	309	0	\N	0	\N	\N
67	519	366	0	\N	0	\N	\N
68	519	368	0	\N	0	\N	\N
69	519	383	0	\N	0	\N	\N
70	519	389	0	\N	0	\N	\N
71	519	418	0	\N	0	\N	\N
72	519	421	0	\N	0	\N	\N
73	519	437	0	\N	0	\N	\N
74	519	449	0	\N	0	\N	\N
75	519	454	0	\N	0	\N	\N
76	519	461	0	\N	0	\N	\N
77	521	34	0	\N	0	\N	\N
78	521	75	0	\N	0	\N	\N
79	521	85	0	\N	0	\N	\N
80	521	102	0	\N	0	\N	\N
81	521	118	0	\N	0	\N	\N
82	521	125	0	\N	0	\N	\N
83	521	131	0	\N	0	\N	\N
84	521	158	0	\N	0	\N	\N
85	521	163	0	\N	0	\N	\N
86	521	191	0	\N	0	\N	\N
87	521	250	0	\N	0	\N	\N
88	521	300	0	\N	0	\N	\N
89	521	309	0	\N	0	\N	\N
90	521	366	0	\N	0	\N	\N
91	521	368	0	\N	0	\N	\N
92	521	383	0	\N	0	\N	\N
93	521	389	0	\N	0	\N	\N
94	521	418	0	\N	0	\N	\N
95	521	421	0	\N	0	\N	\N
96	521	437	0	\N	0	\N	\N
97	521	449	0	\N	0	\N	\N
98	521	454	0	\N	0	\N	\N
99	521	461	0	\N	0	\N	\N
100	263	95	0	\N	0	\N	\N
102	263	183	0	\N	0	\N	\N
103	263	261	0	\N	0	\N	\N
104	263	290	0	\N	0	\N	\N
105	263	334	0	\N	0	\N	\N
106	263	349	0	\N	0	\N	\N
107	263	369	0	\N	0	\N	\N
108	263	428	0	\N	0	\N	\N
109	263	438	0	\N	0	\N	\N
110	263	478	0	\N	0	\N	\N
111	263	224	0	\N	0	\N	\N
112	263	443	0	\N	0	\N	\N
113	263	72	0	\N	0	\N	\N
114	263	226	0	\N	0	\N	\N
115	263	341	0	\N	0	\N	\N
116	263	445	0	\N	0	\N	\N
117	354	368	0	\N	0	\N	\N
118	443	190	0	\N	0	\N	\N
119	443	314	0	\N	0	\N	\N
120	9	328	0	\N	0	\N	\N
121	217	400	0	\N	0	\N	\N
122	423	120	0	\N	0	\N	\N
123	423	122	0	\N	0	\N	\N
124	423	124	0	\N	0	\N	\N
125	423	282	0	\N	0	\N	\N
126	423	340	0	\N	0	\N	\N
127	423	345	0	\N	0	\N	\N
128	181	257	0	\N	0	\N	\N
129	181	260	0	\N	0	\N	\N
130	205	4	0	\N	0	\N	\N
131	205	13	0	\N	0	\N	\N
132	205	30	0	\N	0	\N	\N
133	205	35	0	\N	0	\N	\N
134	205	94	0	\N	0	\N	\N
135	205	107	0	\N	0	\N	\N
136	205	119	0	\N	0	\N	\N
137	205	148	0	\N	0	\N	\N
138	205	160	0	\N	0	\N	\N
139	205	166	0	\N	0	\N	\N
140	205	173	0	\N	0	\N	\N
141	205	193	0	\N	0	\N	\N
142	205	201	0	\N	0	\N	\N
143	205	207	0	\N	0	\N	\N
144	205	219	0	\N	0	\N	\N
145	205	226	0	\N	0	\N	\N
146	205	233	0	\N	0	\N	\N
147	205	283	0	\N	0	\N	\N
148	205	316	0	\N	0	\N	\N
149	205	341	0	\N	0	\N	\N
150	205	350	0	\N	0	\N	\N
151	205	352	0	\N	0	\N	\N
152	205	364	0	\N	0	\N	\N
153	205	367	0	\N	0	\N	\N
154	205	369	0	\N	0	\N	\N
155	205	375	0	\N	0	\N	\N
156	205	398	0	\N	0	\N	\N
157	205	428	0	\N	0	\N	\N
158	205	448	0	\N	0	\N	\N
159	205	455	0	\N	0	\N	\N
160	205	471	0	\N	0	\N	\N
161	410	446	0	\N	0	\N	\N
162	15	89	0	\N	0	\N	\N
163	319	362	0	\N	0	\N	\N
164	323	362	0	\N	0	\N	\N
165	512	260	0	\N	0	\N	\N
166	288	291	0	\N	0	\N	\N
167	510	45	0	\N	0	\N	\N
168	510	290	0	\N	0	\N	\N
169	402	342	0	\N	0	\N	\N
170	402	343	0	\N	0	\N	\N
171	402	350	0	\N	0	\N	\N
172	402	412	0	\N	0	\N	\N
173	402	429	0	\N	0	\N	\N
174	402	432	0	\N	0	\N	\N
175	50	121	0	\N	0	\N	\N
176	50	126	0	\N	0	\N	\N
177	200	257	0	\N	0	\N	\N
178	200	260	0	\N	0	\N	\N
179	113	476	0	\N	0	\N	\N
180	481	72	0	\N	0	\N	\N
181	97	37	0	\N	0	\N	\N
186	435	254	0	\N	0	\N	\N
187	183	148	0	\N	0	\N	\N
188	183	254	0	\N	0	\N	\N
189	11	40	0	\N	0	\N	\N
190	11	132	0	\N	0	\N	\N
191	11	131	0	\N	0	\N	\N
192	290	18	0	\N	0	\N	\N
193	290	73	0	\N	0	\N	\N
194	290	86	0	\N	0	\N	\N
195	290	88	0	\N	0	\N	\N
196	290	95	0	\N	0	\N	\N
197	290	96	0	\N	0	\N	\N
198	290	114	0	\N	0	\N	\N
199	290	146	0	\N	0	\N	\N
200	290	164	0	\N	0	\N	\N
201	290	176	0	\N	0	\N	\N
202	290	190	0	\N	0	\N	\N
203	290	230	0	\N	0	\N	\N
204	290	243	0	\N	0	\N	\N
205	290	294	0	\N	0	\N	\N
206	290	337	0	\N	0	\N	\N
207	290	345	0	\N	0	\N	\N
208	290	374	0	\N	0	\N	\N
209	290	375	0	\N	0	\N	\N
210	290	476	0	\N	0	\N	\N
211	290	477	0	\N	0	\N	\N
212	290	481	0	\N	0	\N	\N
213	290	483	0	\N	0	\N	\N
214	17	308	0	\N	0	\N	\N
215	186	32	0	\N	0	\N	\N
216	186	33	0	\N	0	\N	\N
217	186	92	0	\N	0	\N	\N
218	186	118	0	\N	0	\N	\N
219	186	213	0	\N	0	\N	\N
220	186	450	0	\N	0	\N	\N
221	186	452	0	\N	0	\N	\N
222	194	216	0	\N	0	\N	\N
223	194	215	0	\N	0	\N	\N
224	191	88	0	\N	0	\N	\N
225	191	92	0	\N	0	\N	\N
226	191	113	0	\N	0	\N	\N
227	191	114	0	\N	0	\N	\N
228	191	115	0	\N	0	\N	\N
229	191	117	0	\N	0	\N	\N
230	191	171	0	\N	0	\N	\N
231	191	176	0	\N	0	\N	\N
232	191	230	0	\N	0	\N	\N
233	191	233	0	\N	0	\N	\N
234	191	235	0	\N	0	\N	\N
235	191	237	0	\N	0	\N	\N
236	191	243	0	\N	0	\N	\N
237	191	305	0	\N	0	\N	\N
238	191	368	0	\N	0	\N	\N
239	432	348	0	\N	0	\N	\N
240	343	443	0	\N	0	\N	\N
241	146	405	0	\N	0	\N	\N
242	146	418	0	\N	0	\N	\N
243	49	274	0	\N	0	\N	\N
244	49	345	0	\N	0	\N	\N
245	49	416	0	\N	0	\N	\N
246	298	328	0	\N	0	\N	\N
247	430	287	0	\N	0	\N	\N
248	91	445	0	\N	0	\N	\N
249	91	446	0	\N	0	\N	\N
250	91	447	0	\N	0	\N	\N
251	157	88	0	\N	0	\N	\N
252	157	301	0	\N	0	\N	\N
253	351	88	0	\N	0	\N	\N
254	351	301	0	\N	0	\N	\N
255	227	7	0	\N	0	\N	\N
256	227	122	0	\N	0	\N	\N
257	227	132	0	\N	0	\N	\N
258	30	155	0	\N	0	\N	\N
259	30	156	0	\N	0	\N	\N
260	434	302	0	\N	0	\N	\N
261	63	334	0	\N	0	\N	\N
262	63	456	0	\N	0	\N	\N
263	63	337	0	\N	0	\N	\N
264	52	60	0	\N	0	\N	\N
265	25	158	0	\N	0	\N	\N
267	25	406	0	\N	0	\N	\N
268	222	324	0	\N	0	\N	\N
269	222	296	0	\N	0	\N	\N
270	222	258	0	\N	0	\N	\N
271	222	265	0	\N	0	\N	\N
272	222	459	0	\N	0	\N	\N
273	222	7	0	\N	0	\N	\N
274	222	19	0	\N	0	\N	\N
275	222	20	0	\N	0	\N	\N
276	222	96	0	\N	0	\N	\N
277	491	111	0	\N	0	\N	\N
278	491	211	0	\N	0	\N	\N
279	491	339	0	\N	0	\N	\N
280	495	111	0	\N	0	\N	\N
281	495	211	0	\N	0	\N	\N
282	495	339	0	\N	0	\N	\N
283	51	11	0	\N	0	\N	\N
284	51	12	0	\N	0	\N	\N
285	51	192	0	\N	0	\N	\N
286	51	193	0	\N	0	\N	\N
287	51	194	0	\N	0	\N	\N
288	51	199	0	\N	0	\N	\N
289	454	182	0	\N	0	\N	\N
290	454	357	0	\N	0	\N	\N
291	454	358	0	\N	0	\N	\N
292	454	360	0	\N	0	\N	\N
293	454	362	0	\N	0	\N	\N
294	454	383	0	\N	0	\N	\N
295	454	384	0	\N	0	\N	\N
296	133	340	0	\N	0	\N	\N
297	346	379	0	\N	0	\N	\N
298	136	345	0	\N	0	\N	\N
299	136	406	0	\N	0	\N	\N
300	138	328	0	\N	0	\N	\N
301	138	401	0	\N	0	\N	\N
302	185	148	0	\N	0	\N	\N
303	185	225	0	\N	0	\N	\N
304	27	133	0	\N	0	\N	\N
305	27	252	0	\N	0	\N	\N
306	424	131	0	\N	0	\N	\N
307	424	132	0	\N	0	\N	\N
308	424	149	0	\N	0	\N	\N
309	424	151	0	\N	0	\N	\N
310	424	157	0	\N	0	\N	\N
311	424	282	0	\N	0	\N	\N
312	424	435	0	\N	0	\N	\N
313	438	117	0	\N	0	\N	\N
314	438	137	0	\N	0	\N	\N
315	438	302	0	\N	0	\N	\N
316	438	320	0	\N	0	\N	\N
317	438	328	0	\N	0	\N	\N
318	438	408	0	\N	0	\N	\N
319	438	429	0	\N	0	\N	\N
320	438	430	0	\N	0	\N	\N
321	442	117	0	\N	0	\N	\N
322	442	137	0	\N	0	\N	\N
323	442	302	0	\N	0	\N	\N
324	442	320	0	\N	0	\N	\N
325	442	328	0	\N	0	\N	\N
326	442	408	0	\N	0	\N	\N
327	442	429	0	\N	0	\N	\N
328	442	430	0	\N	0	\N	\N
329	141	277	0	\N	0	\N	\N
330	141	278	0	\N	0	\N	\N
331	196	167	0	\N	0	\N	\N
332	196	309	0	\N	0	\N	\N
333	196	363	0	\N	0	\N	\N
336	28	248	0	\N	0	\N	\N
337	28	252	0	\N	0	\N	\N
338	61	99	0	\N	0	\N	\N
339	61	104	0	\N	0	\N	\N
340	61	371	0	\N	0	\N	\N
341	61	65	0	\N	0	\N	\N
342	61	96	0	\N	0	\N	\N
343	61	458	0	\N	0	\N	\N
344	232	29	0	\N	0	\N	\N
345	232	388	0	\N	0	\N	\N
346	232	393	0	\N	0	\N	\N
347	232	396	0	\N	0	\N	\N
348	232	457	0	\N	0	\N	\N
349	232	459	0	\N	0	\N	\N
350	232	481	0	\N	0	\N	\N
351	232	316	0	\N	0	\N	\N
352	232	391	0	\N	0	\N	\N
353	204	79	0	\N	0	\N	\N
354	204	116	0	\N	0	\N	\N
355	204	141	0	\N	0	\N	\N
356	204	181	0	\N	0	\N	\N
357	204	230	0	\N	0	\N	\N
358	204	238	0	\N	0	\N	\N
359	204	384	0	\N	0	\N	\N
360	204	396	0	\N	0	\N	\N
361	204	402	0	\N	0	\N	\N
362	204	413	0	\N	0	\N	\N
363	204	417	0	\N	0	\N	\N
366	520	157	0	\N	0	\N	\N
367	436	86	0	\N	0	\N	\N
368	436	403	0	\N	0	\N	\N
369	436	469	0	\N	0	\N	\N
370	428	282	0	\N	0	\N	\N
371	428	286	0	\N	0	\N	\N
372	117	132	0	\N	0	\N	\N
373	117	379	0	\N	0	\N	\N
374	67	236	0	\N	0	\N	\N
375	67	241	0	\N	0	\N	\N
376	153	314	0	\N	0	\N	\N
377	259	346	0	\N	0	\N	\N
378	259	404	0	\N	0	\N	\N
379	109	16	0	\N	0	\N	\N
380	109	120	0	\N	0	\N	\N
381	109	198	0	\N	0	\N	\N
382	109	202	0	\N	0	\N	\N
383	109	292	0	\N	0	\N	\N
384	109	297	0	\N	0	\N	\N
385	109	387	0	\N	0	\N	\N
386	109	390	0	\N	0	\N	\N
387	260	113	0	\N	0	\N	\N
388	260	133	0	\N	0	\N	\N
389	260	332	0	\N	0	\N	\N
390	260	335	0	\N	0	\N	\N
391	258	45	0	\N	0	\N	\N
392	258	167	0	\N	0	\N	\N
393	258	170	0	\N	0	\N	\N
394	258	221	0	\N	0	\N	\N
395	258	256	0	\N	0	\N	\N
396	258	273	0	\N	0	\N	\N
397	258	289	0	\N	0	\N	\N
398	258	210	0	\N	0	\N	\N
399	258	212	0	\N	0	\N	\N
400	258	244	0	\N	0	\N	\N
401	258	250	0	\N	0	\N	\N
402	258	306	0	\N	0	\N	\N
403	258	421	0	\N	0	\N	\N
404	258	108	0	\N	0	\N	\N
405	258	275	0	\N	0	\N	\N
406	139	405	0	\N	0	\N	\N
407	425	7	0	\N	0	\N	\N
408	425	310	0	\N	0	\N	\N
409	425	431	0	\N	0	\N	\N
410	439	123	0	\N	0	\N	\N
411	439	278	0	\N	0	\N	\N
412	65	100	0	\N	0	\N	\N
413	65	102	0	\N	0	\N	\N
414	515	83	0	\N	0	\N	\N
415	515	117	0	\N	0	\N	\N
416	515	137	0	\N	0	\N	\N
417	515	288	0	\N	0	\N	\N
418	515	328	0	\N	0	\N	\N
419	515	438	0	\N	0	\N	\N
420	515	439	0	\N	0	\N	\N
421	515	446	0	\N	0	\N	\N
422	515	447	0	\N	0	\N	\N
423	106	167	0	\N	0	\N	\N
424	106	168	0	\N	0	\N	\N
425	106	199	0	\N	0	\N	\N
426	106	374	0	\N	0	\N	\N
427	106	472	0	\N	0	\N	\N
428	2	185	0	\N	0	\N	\N
429	112	204	0	\N	0	\N	\N
430	112	391	0	\N	0	\N	\N
431	296	204	0	\N	0	\N	\N
432	296	391	0	\N	0	\N	\N
433	422	82	0	\N	0	\N	\N
434	422	92	0	\N	0	\N	\N
435	422	147	0	\N	0	\N	\N
436	422	279	0	\N	0	\N	\N
437	422	287	0	\N	0	\N	\N
438	422	313	0	\N	0	\N	\N
439	422	400	0	\N	0	\N	\N
440	118	199	0	\N	0	\N	\N
441	118	392	0	\N	0	\N	\N
442	339	97	0	\N	0	\N	\N
443	339	100	0	\N	0	\N	\N
444	339	101	0	\N	0	\N	\N
445	339	339	0	\N	0	\N	\N
446	340	97	0	\N	0	\N	\N
447	340	100	0	\N	0	\N	\N
448	340	101	0	\N	0	\N	\N
449	340	339	0	\N	0	\N	\N
450	197	227	0	\N	0	\N	\N
451	119	392	0	\N	0	\N	\N
452	119	393	0	\N	0	\N	\N
453	76	171	0	\N	0	\N	\N
454	76	172	0	\N	0	\N	\N
455	76	174	0	\N	0	\N	\N
456	76	206	0	\N	0	\N	\N
457	76	366	0	\N	0	\N	\N
458	335	57	0	\N	0	\N	\N
459	335	58	0	\N	0	\N	\N
460	335	59	0	\N	0	\N	\N
461	335	65	0	\N	0	\N	\N
462	306	388	0	\N	0	\N	\N
463	306	395	0	\N	0	\N	\N
464	306	397	0	\N	0	\N	\N
465	517	297	0	\N	0	\N	\N
466	517	298	0	\N	0	\N	\N
467	198	86	0	\N	0	\N	\N
468	198	113	0	\N	0	\N	\N
469	256	100	0	\N	0	\N	\N
470	256	102	0	\N	0	\N	\N
471	256	168	0	\N	0	\N	\N
472	256	174	0	\N	0	\N	\N
473	256	340	0	\N	0	\N	\N
474	256	363	0	\N	0	\N	\N
475	256	387	0	\N	0	\N	\N
476	256	395	0	\N	0	\N	\N
477	256	450	0	\N	0	\N	\N
478	474	218	0	\N	0	\N	\N
479	474	484	0	\N	0	\N	\N
481	8	179	0	\N	0	\N	\N
482	8	180	0	\N	0	\N	\N
483	99	286	0	\N	0	\N	\N
484	400	244	0	\N	0	\N	\N
485	400	429	0	\N	0	\N	\N
486	400	432	0	\N	0	\N	\N
487	54	254	0	\N	0	\N	\N
488	262	366	0	\N	0	\N	\N
489	98	287	0	\N	0	\N	\N
490	441	136	0	\N	0	\N	\N
492	58	179	0	\N	0	\N	\N
493	286	69	0	\N	0	\N	\N
494	286	109	0	\N	0	\N	\N
495	286	110	0	\N	0	\N	\N
496	286	147	0	\N	0	\N	\N
497	286	148	0	\N	0	\N	\N
498	249	6	0	\N	0	\N	\N
499	249	37	0	\N	0	\N	\N
500	249	39	0	\N	0	\N	\N
501	249	44	0	\N	0	\N	\N
502	249	52	0	\N	0	\N	\N
503	249	53	0	\N	0	\N	\N
504	249	134	0	\N	0	\N	\N
505	249	139	0	\N	0	\N	\N
506	249	190	0	\N	0	\N	\N
507	249	216	0	\N	0	\N	\N
508	249	227	0	\N	0	\N	\N
509	249	236	0	\N	0	\N	\N
510	249	246	0	\N	0	\N	\N
511	249	265	0	\N	0	\N	\N
512	249	269	0	\N	0	\N	\N
513	249	274	0	\N	0	\N	\N
514	249	277	0	\N	0	\N	\N
515	249	286	0	\N	0	\N	\N
516	249	290	0	\N	0	\N	\N
517	249	298	0	\N	0	\N	\N
518	249	300	0	\N	0	\N	\N
519	249	407	0	\N	0	\N	\N
520	249	425	0	\N	0	\N	\N
521	249	479	0	\N	0	\N	\N
522	249	483	0	\N	0	\N	\N
523	249	484	0	\N	0	\N	\N
524	249	268	0	\N	0	\N	\N
525	249	308	0	\N	0	\N	\N
526	249	467	0	\N	0	\N	\N
527	249	22	0	\N	0	\N	\N
528	249	60	0	\N	0	\N	\N
529	249	155	0	\N	0	\N	\N
530	249	220	0	\N	0	\N	\N
531	249	252	0	\N	0	\N	\N
532	249	284	0	\N	0	\N	\N
533	249	328	0	\N	0	\N	\N
534	249	353	0	\N	0	\N	\N
535	249	362	0	\N	0	\N	\N
536	249	431	0	\N	0	\N	\N
537	108	96	0	\N	0	\N	\N
538	431	435	0	\N	0	\N	\N
539	46	290	0	\N	0	\N	\N
540	356	302	0	\N	0	\N	\N
541	356	320	0	\N	0	\N	\N
542	282	119	0	\N	0	\N	\N
543	282	164	0	\N	0	\N	\N
544	282	207	0	\N	0	\N	\N
545	282	224	0	\N	0	\N	\N
546	282	227	0	\N	0	\N	\N
547	282	296	0	\N	0	\N	\N
548	282	307	0	\N	0	\N	\N
549	282	331	0	\N	0	\N	\N
550	282	390	0	\N	0	\N	\N
551	282	419	0	\N	0	\N	\N
552	282	443	0	\N	0	\N	\N
553	455	133	0	\N	0	\N	\N
554	455	134	0	\N	0	\N	\N
555	455	139	0	\N	0	\N	\N
556	455	142	0	\N	0	\N	\N
557	455	225	0	\N	0	\N	\N
558	455	232	0	\N	0	\N	\N
559	455	236	0	\N	0	\N	\N
560	455	253	0	\N	0	\N	\N
561	455	254	0	\N	0	\N	\N
562	455	308	0	\N	0	\N	\N
563	455	470	0	\N	0	\N	\N
564	455	471	0	\N	0	\N	\N
565	18	133	0	\N	0	\N	\N
566	18	134	0	\N	0	\N	\N
567	18	139	0	\N	0	\N	\N
568	18	142	0	\N	0	\N	\N
569	18	225	0	\N	0	\N	\N
570	18	232	0	\N	0	\N	\N
571	18	236	0	\N	0	\N	\N
572	18	253	0	\N	0	\N	\N
573	18	254	0	\N	0	\N	\N
574	18	308	0	\N	0	\N	\N
575	18	470	0	\N	0	\N	\N
576	18	471	0	\N	0	\N	\N
583	408	60	0	\N	0	\N	\N
584	165	60	0	\N	0	\N	\N
585	165	256	0	\N	0	\N	\N
586	165	258	0	\N	0	\N	\N
587	165	265	0	\N	0	\N	\N
588	219	18	0	\N	0	\N	\N
589	219	95	0	\N	0	\N	\N
590	84	73	0	\N	0	\N	\N
591	84	89	0	\N	0	\N	\N
592	85	73	0	\N	0	\N	\N
593	85	89	0	\N	0	\N	\N
594	55	20	0	\N	0	\N	\N
595	55	129	0	\N	0	\N	\N
596	55	220	0	\N	0	\N	\N
597	55	254	0	\N	0	\N	\N
598	55	395	0	\N	0	\N	\N
599	89	388	0	\N	0	\N	\N
600	89	395	0	\N	0	\N	\N
601	89	397	0	\N	0	\N	\N
602	88	396	0	\N	0	\N	\N
603	86	445	0	\N	0	\N	\N
604	86	446	0	\N	0	\N	\N
605	226	203	0	\N	0	\N	\N
606	123	472	0	\N	0	\N	\N
607	94	391	0	\N	0	\N	\N
608	94	392	0	\N	0	\N	\N
609	173	254	0	\N	0	\N	\N
610	173	322	0	\N	0	\N	\N
611	172	254	0	\N	0	\N	\N
612	172	324	0	\N	0	\N	\N
613	374	387	0	\N	0	\N	\N
614	177	336	0	\N	0	\N	\N
615	267	292	0	\N	0	\N	\N
616	166	155	0	\N	0	\N	\N
617	166	249	0	\N	0	\N	\N
618	378	336	0	\N	0	\N	\N
619	214	412	0	\N	0	\N	\N
620	214	419	0	\N	0	\N	\N
621	214	421	0	\N	0	\N	\N
622	160	256	0	\N	0	\N	\N
623	160	258	0	\N	0	\N	\N
624	160	265	0	\N	0	\N	\N
625	44	122	0	\N	0	\N	\N
626	44	140	0	\N	0	\N	\N
627	44	177	0	\N	0	\N	\N
628	44	185	0	\N	0	\N	\N
629	44	253	0	\N	0	\N	\N
630	44	349	0	\N	0	\N	\N
631	44	446	0	\N	0	\N	\N
632	44	449	0	\N	0	\N	\N
633	44	431	0	\N	0	\N	\N
634	44	405	0	\N	0	\N	\N
635	44	217	0	\N	0	\N	\N
636	44	281	0	\N	0	\N	\N
637	44	466	0	\N	0	\N	\N
638	44	123	0	\N	0	\N	\N
639	44	136	0	\N	0	\N	\N
640	44	221	0	\N	0	\N	\N
641	44	289	0	\N	0	\N	\N
642	44	294	0	\N	0	\N	\N
643	44	439	0	\N	0	\N	\N
644	44	445	0	\N	0	\N	\N
645	44	461	0	\N	0	\N	\N
646	44	484	0	\N	0	\N	\N
647	127	17	0	\N	0	\N	\N
648	127	274	0	\N	0	\N	\N
649	127	466	0	\N	0	\N	\N
650	127	472	0	\N	0	\N	\N
651	128	41	0	\N	0	\N	\N
652	128	44	0	\N	0	\N	\N
653	128	167	0	\N	0	\N	\N
654	130	41	0	\N	0	\N	\N
655	130	44	0	\N	0	\N	\N
656	130	167	0	\N	0	\N	\N
657	397	137	0	\N	0	\N	\N
658	397	144	0	\N	0	\N	\N
659	168	202	0	\N	0	\N	\N
660	169	202	0	\N	0	\N	\N
661	523	191	0	한국어도	0	\N	\N
662	525	97	0	구두도	0	\N	\N
663	525	102	0	구두는	0	\N	\N
664	526	10	0	\N	0	\N	\N
665	526	87	0	\N	0	\N	\N
666	526	128	0	\N	0	\N	\N
667	526	240	0	\N	0	\N	\N
668	526	264	0	\N	0	\N	\N
669	527	62	0	\N	0	\N	\N
670	527	327	0	\N	0	\N	\N
671	527	381	0	\N	0	\N	\N
672	277	485	1		0	\N	\N
673	440	486	1		0	\N	\N
674	411	487	1		0	\N	\N
675	81	488	1		0	\N	\N
676	80	489	1		0	\N	\N
677	72	490	1		0	\N	\N
678	362	491	1		0	\N	\N
679	499	492	1		0	\N	\N
680	36	493	1		0	\N	\N
681	216	494	1		0	\N	\N
682	459	495	1		0	\N	\N
683	518	496	1		0	\N	\N
684	237	497	1		0	\N	\N
685	23	498	1		0	\N	\N
686	329	499	1		0	\N	\N
687	415	500	1		0	\N	\N
688	102	501	1		0	\N	\N
689	103	502	1		0	\N	\N
690	359	503	1		0	\N	\N
691	71	504	1		0	\N	\N
692	321	505	1		0	\N	\N
693	242	506	1		0	\N	\N
694	125	507	1		0	\N	\N
695	39	508	1		0	\N	\N
696	396	509	1		0	\N	\N
697	349	510	1		0	\N	\N
699	453	512	1		0	\N	\N
700	433	513	1		0	\N	\N
701	111	514	1		0	\N	\N
702	479	515	1		0	\N	\N
703	409	516	1		0	\N	\N
704	450	517	1		0	\N	\N
705	33	518	1		0	\N	\N
706	120	519	1		0	\N	\N
707	10	520	1		0	\N	\N
708	289	521	1		0	\N	\N
709	187	522	1		0	\N	\N
710	368	523	1		0	\N	\N
711	465	524	1		0	\N	\N
712	490	525	1		0	\N	\N
713	494	526	1		0	\N	\N
714	429	527	1		0	\N	\N
715	417	528	1		0	\N	\N
716	161	529	1		0	\N	\N
717	92	530	1		0	\N	\N
718	254	531	1		0	\N	\N
719	40	532	1		0	\N	\N
720	445	533	1		0	\N	\N
721	135	534	1		0	\N	\N
722	506	535	1		0	\N	\N
723	372	536	1		0	\N	\N
724	300	537	1		0	\N	\N
725	252	538	1		0	\N	\N
726	253	539	1		0	\N	\N
727	251	540	1		0	\N	\N
728	348	541	1		0	\N	\N
729	462	542	1		0	\N	\N
730	345	543	1		0	\N	\N
731	390	544	1		0	\N	\N
732	163	545	1		0	\N	\N
733	182	546	1		0	\N	\N
734	20	547	1		0	\N	\N
735	70	548	1		0	\N	\N
736	447	549	1		0	\N	\N
737	147	550	1		0	\N	\N
738	377	551	1		0	\N	\N
739	16	552	1		0	\N	\N
740	134	553	1		0	\N	\N
741	458	554	1		0	\N	\N
742	158	555	1		0	\N	\N
743	209	556	1		0	\N	\N
744	87	557	1		0	\N	\N
745	299	558	1		0	\N	\N
746	69	559	1		0	\N	\N
747	264	560	1		0	\N	\N
748	116	561	1		0	\N	\N
749	466	562	1		0	\N	\N
750	95	563	1		0	\N	\N
751	96	564	1		0	\N	\N
752	174	565	1		0	\N	\N
753	195	566	1		0	\N	\N
754	82	567	1		0	\N	\N
755	514	568	1		0	\N	\N
756	379	569	1		0	\N	\N
757	475	570	1		0	\N	\N
758	476	571	1		0	\N	\N
759	192	572	1		0	\N	\N
760	413	573	1		0	\N	\N
761	384	574	1		0	\N	\N
762	399	575	1		0	\N	\N
763	272	576	1		0	\N	\N
764	496	577	1		0	\N	\N
765	223	578	1		0	\N	\N
766	456	579	1		0	\N	\N
767	401	580	1		0	\N	\N
768	34	581	1		0	\N	\N
769	243	582	1		0	\N	\N
770	376	583	1		0	\N	\N
771	467	584	1		0	\N	\N
772	230	585	1		0	\N	\N
773	124	586	1		0	\N	\N
774	350	587	1		0	\N	\N
775	283	588	1		0	\N	\N
776	500	589	1		0	\N	\N
777	361	590	1		0	\N	\N
778	353	591	1		0	\N	\N
779	328	592	1		0	\N	\N
780	152	593	1		0	\N	\N
781	151	594	1		0	\N	\N
782	126	595	1		0	\N	\N
783	56	596	1		0	\N	\N
784	57	597	1		0	\N	\N
785	380	598	1		0	\N	\N
786	418	599	1		0	\N	\N
787	213	600	1		0	\N	\N
788	317	601	1		0	\N	\N
789	486	602	1		0	\N	\N
790	238	603	1		0	\N	\N
791	314	604	1		0	\N	\N
792	302	605	1		0	\N	\N
793	212	606	1		0	\N	\N
794	464	607	1		0	\N	\N
795	3	608	1		0	\N	\N
796	221	609	1		0	\N	\N
797	505	610	1		0	\N	\N
798	45	611	1		0	\N	\N
799	83	612	1		0	\N	\N
800	78	613	1		0	\N	\N
801	193	614	1		0	\N	\N
802	32	615	1		0	\N	\N
803	382	616	1		0	\N	\N
804	309	617	1		0	\N	\N
805	355	618	1		0	\N	\N
806	35	619	1		0	\N	\N
807	241	620	1		0	\N	\N
808	392	621	1		0	\N	\N
810	316	622	1		0	\N	\N
811	501	623	1		0	\N	\N
812	68	624	1		0	\N	\N
813	244	625	1		0	\N	\N
814	460	626	1		0	\N	\N
815	122	627	1		0	\N	\N
816	303	628	1		0	\N	\N
817	176	629	1		0	\N	\N
818	301	630	1		0	\N	\N
819	41	631	1		0	\N	\N
820	327	632	1		0	\N	\N
821	363	633	1		0	\N	\N
822	333	634	1		0	\N	\N
823	60	635	1		0	\N	\N
824	225	636	1		0	\N	\N
825	225	620	0	\N	0	\N	\N
826	327	631	0	\N	0	\N	\N
827	327	560	0	\N	0	\N	\N
828	35	581	0	\N	0	\N	\N
829	193	591	0	\N	0	\N	\N
830	464	612	0	\N	0	\N	\N
831	464	495	0	\N	0	\N	\N
832	464	592	0	\N	0	\N	\N
833	418	562	0	\N	0	\N	\N
834	380	609	0	\N	0	\N	\N
835	77	620	0	\N	0	\N	\N
836	77	636	0	\N	0	\N	\N
837	29	637	1		0	\N	\N
838	405	574	0	\N	0	\N	\N
840	188	508	1	\N	0	\N	\N
841	188	638	2		0	\N	\N
842	143	639	1		0	\N	\N
844	231	560	1	\N	0	\N	\N
845	231	640	2		0	\N	\N
846	334	641	1		0	\N	\N
847	373	642	1		0	\N	\N
848	373	499	0	\N	0	\N	\N
849	395	643	1		0	\N	\N
850	513	644	1		0	\N	\N
851	53	645	1		0	\N	\N
852	385	646	1		0	\N	\N
853	394	647	1		0	\N	\N
854	473	648	1		0	\N	\N
855	332	649	1		0	\N	\N
856	488	650	1		0	\N	\N
857	304	651	1		0	\N	\N
858	318	652	1		0	\N	\N
859	360	653	1		0	\N	\N
860	245	654	1		0	\N	\N
861	148	655	1		0	\N	\N
862	297	656	1		0	\N	\N
863	371	657	1		0	\N	\N
864	121	658	1		0	\N	\N
865	284	659	1		0	\N	\N
866	274	660	1		0	\N	\N
867	326	661	1		0	\N	\N
868	43	662	1		0	\N	\N
869	291	663	1		0	\N	\N
870	484	664	1		0	\N	\N
871	315	665	1		0	\N	\N
872	426	666	1		0	\N	\N
873	344	667	1		0	\N	\N
874	159	668	1		0	\N	\N
875	485	669	1		0	\N	\N
876	132	670	1		0	\N	\N
877	414	671	1		0	\N	\N
878	489	672	1		0	\N	\N
879	493	673	1		0	\N	\N
880	13	674	1		0	\N	\N
881	164	675	1		0	\N	\N
882	142	676	1		0	\N	\N
883	144	677	1		0	\N	\N
884	369	678	1		0	\N	\N
885	369	598	0	\N	0	\N	\N
886	167	679	1		0	\N	\N
887	75	680	1		0	\N	\N
888	448	681	1		0	\N	\N
889	448	636	0	\N	0	\N	\N
890	287	682	1		0	\N	\N
891	391	683	1		0	\N	\N
892	427	684	1		0	\N	\N
893	421	685	1		0	\N	\N
894	437	686	1		0	\N	\N
895	412	687	1		0	\N	\N
896	412	646	0	\N	0	\N	\N
897	4	688	1		0	\N	\N
898	5	689	1		0	\N	\N
899	229	690	1		0	\N	\N
900	236	691	1		0	\N	\N
901	175	692	1		0	\N	\N
902	215	693	1		0	\N	\N
903	210	694	1		0	\N	\N
904	218	695	1		0	\N	\N
905	403	696	1		0	\N	\N
906	428	614	0	\N	0	\N	\N
907	428	626	0	\N	0	\N	\N
908	428	696	0	\N	0	\N	\N
909	218	606	0	\N	0	\N	\N
910	389	697	1		0	\N	\N
911	306	522	0	\N	0	\N	\N
912	131	698	1		0	\N	\N
913	201	699	1		0	\N	\N
914	171	700	1		0	\N	\N
915	449	701	1		0	\N	\N
916	452	702	1		0	\N	\N
917	150	703	1		0	\N	\N
918	90	704	1		0	\N	\N
919	149	705	1		0	\N	\N
920	261	706	1		0	\N	\N
921	383	707	1		0	\N	\N
922	398	708	1		0	\N	\N
923	386	621	1	\N	0	\N	\N
924	386	709	2		0	\N	\N
925	47	710	1		0	\N	\N
926	387	711	1		0	\N	\N
927	48	712	1		0	\N	\N
928	202	713	1		0	\N	\N
929	330	714	1		0	\N	\N
930	331	715	1		0	\N	\N
931	338	716	1		0	\N	\N
932	38	717	1		0	\N	\N
933	114	718	1		0	\N	\N
934	320	719	1		0	\N	\N
935	31	720	1		0	\N	\N
936	235	721	1		0	\N	\N
937	416	107	1	\N	0	\N	\N
938	416	722	2		0	\N	\N
939	235	560	0	\N	0	\N	\N
940	137	723	1		0	\N	\N
941	19	724	1		0	\N	\N
942	220	725	1		0	\N	\N
943	444	726	1		0	\N	\N
944	295	727	1		0	\N	\N
945	420	728	1		0	\N	\N
946	357	729	1		0	\N	\N
947	364	730	1		0	\N	\N
948	357	730	0	\N	0	\N	\N
949	364	729	0	\N	0	\N	\N
950	293	731	1		0	\N	\N
951	170	732	1		0	\N	\N
952	352	733	1		0	\N	\N
953	184	734	1		0	\N	\N
954	292	735	1		0	\N	\N
955	265	736	1		0	\N	\N
956	509	737	1		0	\N	\N
957	336	738	1		0	\N	\N
958	336	656	0	\N	0	\N	\N
961	279	740	2		0	\N	\N
962	393	741	1		0	\N	\N
963	104	742	1		0	\N	\N
964	370	743	1		0	\N	\N
965	145	744	1		0	\N	\N
966	502	745	1		0	\N	\N
967	115	746	1		0	\N	\N
968	178	747	1		0	\N	\N
969	240	748	1		0	\N	\N
970	74	749	1		0	\N	\N
971	21	750	1		0	\N	\N
972	79	751	1		0	\N	\N
973	208	752	1		0	\N	\N
974	208	605	0	\N	0	\N	\N
975	461	753	1		0	\N	\N
976	461	709	0	\N	0	\N	\N
977	451	754	1		0	\N	\N
978	228	755	1		0	\N	\N
979	190	756	1		0	\N	\N
980	388	757	1		0	\N	\N
981	199	758	1		0	\N	\N
982	367	759	1		0	\N	\N
983	347	760	1		0	\N	\N
984	37	761	1		0	\N	\N
985	100	762	1		0	\N	\N
986	100	522	0	\N	0	\N	\N
987	306	762	0	\N	0	\N	\N
988	101	763	1		0	\N	\N
989	406	764	1		0	\N	\N
990	498	765	1		0	\N	\N
991	110	766	1		0	\N	\N
992	508	767	1		0	\N	\N
993	342	768	1		0	\N	\N
994	381	769	1		0	\N	\N
995	189	770	1		0	\N	\N
996	6	771	1		0	\N	\N
997	375	772	1		0	\N	\N
998	497	773	1		0	\N	\N
999	471	774	1		0	\N	\N
1000	312	775	1		0	\N	\N
1001	313	776	1		0	\N	\N
1002	24	777	1		0	\N	\N
1003	246	778	1		0	\N	\N
1004	322	779	1		0	\N	\N
1005	310	780	1		0	\N	\N
1006	310	779	0	\N	0	\N	\N
1007	322	780	0	\N	0	\N	\N
1008	311	781	1		0	\N	\N
1009	7	782	1		0	\N	\N
1010	179	783	1		0	\N	\N
1011	404	784	1		0	\N	\N
1012	42	785	1		0	\N	\N
1013	12	786	1		0	\N	\N
1014	470	787	1		0	\N	\N
1016	459	787	0	\N	0	\N	\N
1017	518	779	0	\N	0	\N	\N
1018	71	770	0	\N	0	\N	\N
1019	277	506	0	\N	0	\N	\N
1020	257	624	0	\N	0	\N	\N
1021	257	703	0	\N	0	\N	\N
1022	257	721	0	\N	0	\N	\N
1023	257	749	0	\N	0	\N	\N
1024	257	564	0	\N	0	\N	\N
1025	247	511	1		0	\N	\N
1026	247	789	2		0	\N	\N
1027	105	514	0	\N	0	\N	\N
1028	105	594	0	\N	0	\N	\N
1029	111	594	0	\N	0	\N	\N
1030	443	667	0	\N	0	\N	\N
1031	443	787	0	\N	0	\N	\N
1032	33	542	0	\N	0	\N	\N
1033	33	732	0	\N	0	\N	\N
1034	233	790	1		0	\N	\N
1035	477	791	1		0	\N	\N
1036	64	792	1		0	\N	\N
1037	516	793	1		0	\N	\N
1038	366	794	1		0	\N	\N
1039	239	625	0	\N	0	\N	\N
1040	278	795	1		0	\N	\N
1041	80	786	0	\N	0	\N	\N
1042	266	796	1		0	\N	\N
1043	271	797	1		0	\N	\N
1044	233	797	0	\N	0	\N	\N
1045	73	798	1		0	\N	\N
1046	358	799	1		0	\N	\N
1047	268	800	1		0	\N	\N
1048	59	801	1		0	\N	\N
1049	248	802	1		0	\N	\N
1050	26	803	1		0	\N	\N
1051	492	804	1		0	\N	\N
1052	305	805	1		0	\N	\N
1053	287	673	0	\N	0	\N	\N
1054	287	805	0	\N	0	\N	\N
1055	281	806	1		0	\N	\N
1056	270	807	1		0	\N	\N
1057	503	808	1		0	\N	\N
1058	446	809	1		0	\N	\N
1059	419	810	1		0	\N	\N
1061	308	811	1		0	\N	\N
1062	280	812	1		0	\N	\N
1063	472	813	1		0	\N	\N
1064	478	814	1		0	\N	\N
1065	480	815	1		0	\N	\N
1066	156	816	1		0	\N	\N
1067	273	817	1		0	\N	\N
1068	294	818	1		0	\N	\N
1069	275	819	1		0	\N	\N
1070	285	820	1		0	\N	\N
1071	93	821	1		0	\N	\N
1072	324	822	1		0	\N	\N
1073	487	823	1		0	\N	\N
1074	325	824	1		0	\N	\N
1075	14	825	1		0	\N	\N
1076	211	826	1		0	\N	\N
1077	524	827	1		0	\N	\N
1078	341	828	1		0	\N	\N
1079	276	829	1		0	\N	\N
1080	250	830	1		0	\N	\N
1081	511	831	1		0	\N	\N
1082	407	832	1		0	\N	\N
1083	154	833	1		0	\N	\N
1084	337	834	1		0	\N	\N
1085	469	835	1		0	\N	\N
1086	180	836	1		0	\N	\N
1087	234	837	1		0	\N	\N
1088	507	838	1		0	\N	\N
1089	468	788	1		0	\N	\N
1090	468	839	2		0	\N	\N
1091	307	840	1		0	\N	\N
1092	365	841	1		0	\N	\N
1093	365	842	2		0	\N	\N
1094	22	843	1		0	\N	\N
1096	206	844	1		0	\N	\N
1097	206	845	2		0	\N	\N
1098	269	846	1		0	\N	\N
1099	522	847	1		0	\N	\N
1100	463	848	1		0	\N	\N
\.


--
-- Data for Name: t_usage_photo; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_usage_photo (id, usage_id, file_name, infomation, explanation) FROM stdin;
\.


--
-- Data for Name: t_usage_scene_rel; Type: TABLE DATA; Schema: public; Owner: ko
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
522	1
523	1
524	25
525	19
526	17
527	17
\.


--
-- Data for Name: t_word; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_word (id, basic, selected, index_char, sort_order) FROM stdin;
335	인터넷서점	\N	\N	\N
360	생일	\N	\N	\N
646	표	1	ㅍ	\N
647	내리다	1	ㄴ	\N
1	어	\N	\N	\N
2	씨	\N	\N	\N
3	안녕하다	\N	\N	\N
4	잘	\N	\N	\N
5	지내다	\N	\N	\N
6	네	\N	\N	\N
7	예	\N	\N	\N
8	저	\N	\N	\N
9	어제	\N	\N	\N
10	백화점	\N	\N	\N
11	이것	\N	\N	\N
12	사다	\N	\N	\N
13	그것	\N	\N	\N
14	무엇	\N	\N	\N
15	계산기	\N	\N	\N
16	아니다	\N	\N	\N
17	전자 사전	\N	\N	\N
18	한일 사전	\N	\N	\N
19	그렇다	\N	\N	\N
20	어디	\N	\N	\N
21	가다	\N	\N	\N
22	학교	\N	\N	\N
23	길	\N	\N	\N
24	짐	\N	\N	\N
917	저녁	1	ㅈ	\N
918	모레	1	ㅁ	\N
957	한자	1	ㅎ	\N
958	말하다	1	ㅁ	\N
959	쓰다	1	ㅆ	\N
960	이야기	1	ㅇ	\N
961	말	1	ㅁ	\N
962	말	1	ㅁ	\N
963	단어	1	ㄷ	\N
964	이야기하다	1	ㅇ	\N
965	글	1	ㄱ	\N
966	말하다	1	ㅁ	\N
967	뜻	1	ㄸ	\N
970	어른	1	ㅇ	\N
971	여러 사람	1	ㅇ	\N
972	부부	1	ㅂ	\N
973	아이	1	ㅇ	\N
974	아내	1	ㅇ	\N
975	여자	1	ㅇ	\N
976	남자 아이	1	ㄴ	\N
977	사람	1	ㅅ	\N
978	남자	1	ㄴ	\N
979	여자 아이	1	ㅇ	\N
980	남편	1	ㄴ	\N
981	사람	1	ㅅ	\N
982	모두	1	ㅁ	\N
983	하양, 하얗다	1	ㅎ	\N
689		0		\N
650	역	1	ㅇ	\N
25	많다	\N	\N	\N
26	책	\N	\N	\N
27	하나	\N	\N	\N
28	주다	\N	\N	\N
29	들다	\N	\N	\N
30	고맙다	\N	\N	\N
31	여기	\N	\N	\N
32	잠깐	\N	\N	\N
33	지금	\N	\N	\N
34	먼저	\N	\N	\N
35	메뉴판	\N	\N	\N
36	좀	\N	\N	\N
37	주문하다	\N	\N	\N
38	맛있다	\N	\N	\N
39	다	\N	\N	\N
40	응	\N	\N	\N
41	그럼	\N	\N	\N
42	돌솥 비빔밥	\N	\N	\N
43	알다	\N	\N	\N
44	처음	\N	\N	\N
45	뵙다	\N	\N	\N
46	만나다	\N	\N	\N
47	반갑다	\N	\N	\N
48	학생	\N	\N	\N
49	실례	\N	\N	\N
50	나이	\N	\N	\N
51	어떻다	\N	\N	\N
52	되다	\N	\N	\N
53	스무	\N	\N	\N
54	살	\N	\N	\N
55	아	\N	\N	\N
56	동갑	\N	\N	\N
57	전공	\N	\N	\N
58	뭐	\N	\N	\N
59	경제학	\N	\N	\N
60	문학	\N	\N	\N
61	왜	\N	\N	\N
62	무슨	\N	\N	\N
63	일	\N	\N	\N
64	우산	\N	\N	\N
65	말	\N	\N	\N
66	검다	\N	\N	\N
67	지난 주	\N	\N	\N
68	빌리다	\N	\N	\N
69	지하철	\N	\N	\N
70	잃다	\N	\N	\N
71	미안하다	\N	\N	\N
72	아니	\N	\N	\N
73	괜찮다	\N	\N	\N
74	그래도	\N	\N	\N
75	싸다	\N	\N	\N
76	한국	\N	\N	\N
77	탈	\N	\N	\N
78	재미	\N	\N	\N
79	보다	\N	\N	\N
80	드리다	\N	\N	\N
81	뜻	\N	\N	\N
82	집	\N	\N	\N
83	많이	\N	\N	\N
84	있다	\N	\N	\N
85	받다	\N	\N	\N
86	일본	\N	\N	\N
87	것	\N	\N	\N
88	똑같다	\N	\N	\N
89	아주	\N	\N	\N
90	다르다	\N	\N	\N
91	한번	\N	\N	\N
92	오늘	\N	\N	\N
93	초대하다	\N	\N	\N
94	정말	\N	\N	\N
95	감사하다	\N	\N	\N
96	별로	\N	\N	\N
97	차리다	\N	\N	\N
98	없다	\N	\N	\N
99	오다	\N	\N	\N
100	별 말씀	\N	\N	\N
101	이만	\N	\N	\N
102	음식	\N	\N	\N
103	아직	\N	\N	\N
104	드시다	\N	\N	\N
105	너무	\N	\N	\N
106	먹다	\N	\N	\N
107	배	\N	\N	\N
108	부르다	\N	\N	\N
109	다음	\N	\N	\N
110	꼭	\N	\N	\N
111	우리	\N	\N	\N
112	놀다	\N	\N	\N
113	정말로	\N	\N	\N
114	맛있게	\N	\N	\N
115	안녕히	\N	\N	\N
116	계시다	\N	\N	\N
117	어머	\N	\N	\N
118	저기	\N	\N	\N
119	벼룩 시장	\N	\N	\N
120	물건	\N	\N	\N
121	옷	\N	\N	\N
122	구두	1	ㄱ	\N
123	지우개	\N	\N	\N
124	원	\N	\N	\N
125	와	\N	\N	\N
126	얼마	\N	\N	\N
127	그	\N	\N	\N
128	오천	\N	\N	\N
129	한	\N	\N	\N
130	켤레	\N	\N	\N
131	만	\N	\N	\N
132	진짜	\N	\N	\N
133	같이	\N	\N	\N
134	적	\N	\N	\N
135	작년	\N	\N	\N
136	거리	\N	\N	\N
137	깨끗하다	\N	\N	\N
138	사람	\N	\N	\N
139	참	\N	\N	\N
140	친절하다	\N	\N	\N
141	한정식	\N	\N	\N
142	반찬	\N	\N	\N
143	나오다	\N	\N	\N
144	갈비	\N	\N	\N
145	시간	\N	\N	\N
146	못	\N	\N	\N
147	나	\N	\N	\N
148	동경	\N	\N	\N
149	갈비집	\N	\N	\N
150	안	\N	\N	\N
151	좋다	\N	\N	\N
152	내일	\N	\N	\N
153	도서관	\N	\N	\N
154	예정	\N	\N	\N
155	세일	\N	\N	\N
156	하다	\N	\N	\N
157	언제	\N	\N	\N
158	공부하다	\N	\N	\N
159	생각	\N	\N	\N
160	반납하다	\N	\N	\N
161	몇	\N	\N	\N
162	시	\N	\N	\N
163	아홉	\N	\N	\N
164	반	\N	\N	\N
165	정문	\N	\N	\N
166	앞	\N	\N	\N
167	스포츠	\N	\N	\N
168	좋아하다	\N	\N	\N
169	테니스	\N	\N	\N
170	요즘	\N	\N	\N
171	자주	\N	\N	\N
172	요새	\N	\N	\N
173	둘	\N	\N	\N
174	번	\N	\N	\N
175	정도	\N	\N	\N
176	못하다	\N	\N	\N
177	야구	\N	\N	\N
178	야구장	\N	\N	\N
179	때	\N	\N	\N
180	서너	\N	\N	\N
181	오랜만	\N	\N	\N
182	술	\N	\N	\N
183	마시다	\N	\N	\N
184	근데	\N	\N	\N
185	10	\N	\N	\N
186	55	\N	\N	\N
187	분	\N	\N	\N
188	큰일	\N	\N	\N
189	타다	\N	\N	\N
190	버스	\N	\N	\N
191	일찍	\N	\N	\N
192	끊기다	\N	\N	\N
193	막차	\N	\N	\N
194	아마	\N	\N	\N
195	11	\N	\N	\N
196	빨리	\N	\N	\N
197	연구회	\N	\N	\N
198	준비	\N	\N	\N
199	거의	\N	\N	\N
200	끝나다	\N	\N	\N
201	그런데	\N	\N	\N
202	명	\N	\N	\N
203	같다	\N	\N	\N
204	삼십	\N	\N	\N
205	발표	\N	\N	\N
206	원고	\N	\N	\N
207	부	\N	\N	\N
208	준비하다	\N	\N	\N
209	혹시	\N	\N	\N
210	더	\N	\N	\N
211	모르다	\N	\N	\N
212	오십	\N	\N	\N
213	학생 식당	\N	\N	\N
214	이용하다	\N	\N	\N
215	현금	\N	\N	\N
216	쓰다	\N	\N	\N
217	카드	\N	\N	\N
218	처리하다	\N	\N	\N
219	요리	\N	\N	\N
220	코너	\N	\N	\N
221	고르다	\N	\N	\N
222	맞다	\N	\N	\N
223	요리 코너	\N	\N	\N
224	센서	\N	\N	\N
225	대다	\N	\N	\N
226	편하다	\N	\N	\N
227	일본어	\N	\N	\N
228	잡지	\N	\N	\N
229	줄	\N	\N	\N
230	그냥	\N	\N	\N
231	사진	\N	\N	\N
232	보고 있는	\N	\N	\N
233	외국어	\N	\N	\N
234	영어	\N	\N	\N
235	조금	\N	\N	\N
236	옛날	\N	\N	\N
237	러시아어	\N	\N	\N
238	배우다	\N	\N	\N
239	잊다	\N	\N	\N
240	대단하다	\N	\N	\N
241	금방	\N	\N	\N
242	한국어	1	ㅎ	\N
243	사전	\N	\N	\N
244	찾다	\N	\N	\N
245	일한사전	\N	\N	\N
246	\n\t\t\t\t\t\t\t	\N	\N	\N
247	새로	\N	\N	\N
248	잠시	\N	\N	\N
249	검색하다	\N	\N	\N
250	죽	\N	\N	\N
251	오른쪽	\N	\N	\N
252	거기	\N	\N	\N
253	화장실	\N	\N	\N
254	2	\N	\N	\N
255	층	\N	\N	\N
256	올라가다	\N	\N	\N
257	계단	\N	\N	\N
258	바로	\N	\N	\N
259	옆	\N	\N	\N
260	한국 요리	\N	\N	\N
261	된장찌개	\N	\N	\N
262	맛	\N	\N	\N
263	일본 사람	\N	\N	\N
264	짜다	\N	\N	\N
265	그러면	\N	\N	\N
266	보이다	\N	\N	\N
267	비빔국수	\N	\N	\N
268	맵다	\N	\N	\N
269	얘기	\N	\N	\N
270	수	\N	\N	\N
271	선배	\N	\N	\N
272	커피	\N	\N	\N
273	엎지르다	\N	\N	\N
274	솔직하다	\N	\N	\N
275	얘기하다	\N	\N	\N
276	무섭다	\N	\N	\N
277	고백하다	\N	\N	\N
278	사과하다	\N	\N	\N
279	와인	\N	\N	\N
280	병	\N	\N	\N
281	가지다	\N	\N	\N
282	사과	\N	\N	\N
283	과일	\N	\N	\N
284	편	\N	\N	\N
285	바나나	\N	\N	\N
286	야채	\N	\N	\N
287	토마토	\N	\N	\N
288	일요일	\N	\N	\N
289	스케이트장	\N	\N	\N
290	스케이트	\N	\N	\N
291	싫어하다	\N	\N	\N
292	구경하다	\N	\N	\N
293	볼링	\N	\N	\N
294	실은	\N	\N	\N
295	제	\N	\N	\N
296	운동	\N	\N	\N
297	카페	\N	\N	\N
298	읽다	\N	\N	\N
299	취미	\N	\N	\N
300	표	\N	\N	\N
301	돈	\N	\N	\N
302	아무리	\N	\N	\N
303	넣다	\N	\N	\N
304	다시	\N	\N	\N
305	반대	\N	\N	\N
306	금액	\N	\N	\N
307	누르다	\N	\N	\N
308	헷갈리다	\N	\N	\N
309	여보세요	\N	\N	\N
310	오래간만	\N	\N	\N
311	동안	\N	\N	\N
312	공부	\N	\N	\N
313	때문	\N	\N	\N
314	바쁘다	\N	\N	\N
315	시험	\N	\N	\N
316	정신	\N	\N	\N
317	식사	\N	\N	\N
318	아침	\N	\N	\N
319	일곱	\N	\N	\N
320	출발하다	\N	\N	\N
321	만약	\N	\N	\N
322	늦어지다	\N	\N	\N
323	어떡하다	\N	\N	\N
324	기다리다	\N	\N	\N
325	일어나다	\N	\N	\N
326	자다	\N	\N	\N
327	전화하다	\N	\N	\N
328	서울	\N	\N	\N
329	제일	\N	\N	\N
330	크다	\N	\N	\N
331	서점	\N	\N	\N
332	무료	\N	\N	\N
333	배달	\N	\N	\N
334	글쎄	\N	\N	\N
336	유명하다	\N	\N	\N
337	사이트	\N	\N	\N
338	가장	\N	\N	\N
339	주로	\N	\N	\N
340	고프다	\N	\N	\N
341	벌써	\N	\N	\N
342	점심	\N	\N	\N
343	식사하다	\N	\N	\N
344	그러다	\N	\N	\N
345	칼국수	\N	\N	\N
346	식당	\N	\N	\N
347	결석하다	\N	\N	\N
348	감기	\N	\N	\N
349	약	\N	\N	\N
350	다행	\N	\N	\N
351	걱정하다	\N	\N	\N
352	부탁	\N	\N	\N
353	물론	\N	\N	\N
354	 	\N	\N	\N
355	케이크	\N	\N	\N
356	안되다	\N	\N	\N
357	숙제	\N	\N	\N
358	밖	\N	\N	\N
359	나가다	\N	\N	\N
361	보통	\N	\N	\N
362	선물	\N	\N	\N
363	그렇게	\N	\N	\N
364	비싸다	\N	\N	\N
365	머그컵	\N	\N	\N
366	오히려	\N	\N	\N
367	경우	\N	\N	\N
368	향수	\N	\N	\N
369	반지	\N	\N	\N
370	선생님	\N	\N	\N
371	보고서	\N	\N	\N
372	마감	\N	\N	\N
373	다음 주	\N	\N	\N
374	연장하다	\N	\N	\N
375	곤란하다	\N	\N	\N
376	수업	\N	\N	\N
377	도저히	\N	\N	\N
378	무리	\N	\N	\N
379	어느	\N	\N	\N
380	완성되다	\N	\N	\N
381	칠십	\N	\N	\N
382	프로	\N	\N	\N
383	일단	\N	\N	\N
384	마무리	\N	\N	\N
385	부분	\N	\N	\N
386	모레	\N	\N	\N
387	제출하다	\N	\N	\N
388	앨범	\N	\N	\N
389	귀엽다	\N	\N	\N
390	다섯	\N	\N	\N
391	찍다	\N	\N	\N
392	여자 친구	\N	\N	\N
393	이름	\N	\N	\N
394	묻다	\N	\N	\N
395	누나	\N	\N	\N
396	셀프 서비스	\N	\N	\N
397	직접	\N	\N	\N
398	자기	\N	\N	\N
399	자리	\N	\N	\N
400	그릇	\N	\N	\N
401	카운터	\N	\N	\N
402	귀찮다	\N	\N	\N
403	가게	\N	\N	\N
404	훨씬	\N	\N	\N
405	박물관	\N	\N	\N
406	역사	\N	\N	\N
407	관하여	\N	\N	\N
408	신기하다	\N	\N	\N
409	만지다	\N	\N	\N
410	손	\N	\N	\N
411	적히다	\N	\N	\N
412	유감	\N	\N	\N
413	컴퓨터	\N	\N	\N
414	두다	\N	\N	\N
415	책상	\N	\N	\N
416	위	\N	\N	\N
417	놓다	\N	\N	\N
418	옷장	\N	\N	\N
419	우선	\N	\N	\N
420	침대	\N	\N	\N
421	왼쪽	\N	\N	\N
422	음	\N	\N	\N
423	두다 	\N	\N	\N
424	되다 	\N	\N	\N
425	책장	\N	\N	\N
426	꽂다	\N	\N	\N
427	프린터	\N	\N	\N
428	한턱	\N	\N	\N
429	멀다	\N	\N	\N
430	이제	\N	\N	\N
431	페이지	\N	\N	\N
432	마지막	\N	\N	\N
433	문제	\N	\N	\N
434	어렵다	\N	\N	\N
435	곧	\N	\N	\N
436	걸리다	\N	\N	\N
437	모임	\N	\N	\N
438	회원	\N	\N	\N
439	편지	\N	\N	\N
440	알리다	\N	\N	\N
441	이메일	\N	\N	\N
442	보내다	\N	\N	\N
443	아예	\N	\N	\N
444	역시	\N	\N	\N
445	연락하다	\N	\N	\N
446	오빠	\N	\N	\N
447	실은 	\N	\N	\N
448	이사	\N	\N	\N
449	그래서	\N	\N	\N
450	집들이	\N	\N	\N
451	저녁	\N	\N	\N
452	～시	\N	\N	\N
453	기운	\N	\N	\N
454	식욕	\N	\N	\N
455	피곤하다	\N	\N	\N
456	아르바이트	\N	\N	\N
457	움직이다	\N	\N	\N
458	소리	\N	\N	\N
459	청소	\N	\N	\N
460	년	\N	\N	\N
461	이상	\N	\N	\N
462	지저분하다	\N	\N	\N
463	아저씨	\N	\N	\N
464	열	\N	\N	\N
465	개	\N	\N	\N
466	삼천	\N	\N	\N
467	깎다	\N	\N	\N
468	이천 오백	\N	\N	\N
469	또	\N	\N	\N
470	졸업하다	\N	\N	\N
471	대학원	\N	\N	\N
472	전공하다	\N	\N	\N
473	확실하다	\N	\N	\N
474	특히	\N	\N	\N
475	작품	\N	\N	\N
476	단편소설	\N	\N	\N
477	이쪽	\N	\N	\N
478	친구	\N	\N	\N
479	말씀	\N	\N	\N
480	듣다	\N	\N	\N
481	경제	\N	\N	\N
482	관심	\N	\N	\N
483	가르치다	\N	\N	\N
484	대하여	\N	\N	\N
485	이따가	\N	\N	\N
486	이야기	\N	\N	\N
487	가다	1	ㄱ	\N
488	영어	1	ㅇ	\N
489	비행기	1	ㅂ	\N
490	외국	1	ㅇ	\N
491	외국인	1	ㅇ	\N
492	프랑스어	1	ㅍ	\N
493	호텔	1	ㅎ	\N
494	일본어	1	ㅇ	\N
495	나가다	1	ㄴ	\N
496	나라	1	ㄴ	\N
497	만나다	1	ㅁ	\N
498	휴일	1	ㅎ	\N
499	여행	1	ㅇ	\N
500	여행하다	1	ㅇ	\N
501	놀다	1	ㄴ	\N
502	대사관	1	ㄷ	\N
503	많이 좋아하다	1	ㅁ	\N
504	좋아하다	1	ㅈ	\N
505	잘하다	1	ㅈ	\N
506	달리다	1	ㄷ	\N
507	천천히	1	ㅊ	\N
508	서투르다	1	ㅅ	\N
509	걷다	1	ㄱ	\N
510	헤엄치다	1	ㅎ	\N
511	빠르다	1	ㅃ	\N
512	날다	1	ㄴ	\N
513	스포츠	1	ㅅ	\N
514	싫어하다	1	ㅅ	\N
515	수영장	1	ㅅ	\N
516	버스	1	ㅂ	\N
517	자전거	1	ㅈ	\N
518	사거리	1	ㅅ	\N
519	길	1	ㄱ	\N
520	못	1	ㅁ	\N
521	산책	1	ㅅ	\N
522	강	1	ㄱ	\N
523	택시	1	ㅌ	\N
524	자동차	1	ㅈ	\N
525	구부러지다	1	ㄱ	\N
526	넥타이	1	ㄴ	\N
527	셔츠	1	ㅅ	\N
528	회사	1	ㅎ	\N
529	양복	1	ㅇ	\N
530	하다	1	ㅎ	\N
531	빨다	1	ㅃ	\N
532	전화	1	ㅈ	\N
533	일	1	ㅇ	\N
534	일하다	1	ㅇ	\N
535	바쁘다	1	ㅂ	\N
536	도서관	1	ㄷ	\N
537	사전	1	ㅅ	\N
538	빌리다	1	ㅂ	\N
539	신문	1	ㅅ	\N
540	읽다	1	ㅇ	\N
541	책	1	ㅊ	\N
542	복사	1	ㅂ	\N
543	복사하다	1	ㅂ	\N
544	잡지	1	ㅈ	\N
545	권	1	ㄱ	\N
546	쇠고기	1	ㅅ	\N
547	싸다	1	ㅆ	\N
548	가게	1	ㄱ	\N
549	비싸다	1	ㅂ	\N
550	몇 개	1	ㅁ	\N
551	얼마	1	ㅇ	\N
552	과일	1	ㄱ	\N
553	야채	1	ㅇ	\N
554	생선	1	ㅅ	\N
555	돼지고기	1	ㄷ	\N
556	닭고기	1	ㄷ	\N
557	고기	1	ㄱ	\N
558	가지고 싶다	1	ㄱ	\N
559	건네다	1	ㄱ	\N
560	야채 가게	1	ㅇ	\N
561	열쇄	1	ㅇ	\N
562	요리	1	ㅇ	\N
563	쇼핑하다	1	ㅅ	\N
564	빨래하다	1	ㅃ	\N
565	청소하다	1	ㅊ	\N
566	가족	1	ㄱ	\N
567	가정	1	ㄱ	\N
568	마당	1	ㅁ	\N
569	빨래	1	ㅃ	\N
570	집	1	ㅈ	\N
571	집	1	ㅈ	\N
572	청소	1	ㅊ	\N
573	돌아가다	1	ㄷ	\N
574	책장	1	ㅊ	\N
575	책상	1	ㅊ	\N
576	의자	1	ㅇ	\N
577	방	1	ㅂ	\N
578	냉장고	1	ㄴ	\N
579	씻다	1	ㅆ	\N
580	침대	1	ㅊ	\N
581	라디오	1	ㄹ	\N
582	라디오카세트	1	ㄹ	\N
583	~(이)라고 합니다	1	ㄹ	\N
584	자다	1	ㅈ	\N
585	일어나다	1	ㅇ	\N
586	테이블	1	ㅌ	\N
587	텔레비젼	1	ㅌ	\N
588	경찰 아저씨	1	ㄱ	\N
589	경찰관	1	ㄱ	\N
590	지도	1	ㅈ	\N
591	근처	1	ㄱ	\N
592	여기, 이쪽	1	ㅇ	\N
593	거기, 그쪽	1	ㄱ	\N
594	저기, 저쪽	1	ㅈ	\N
595	어디, 어느 쪽	1	ㅇ	\N
596	파출소	1	ㅍ	\N
597	근처	1	ㄱ	\N
598	옆	1	ㅇ	\N
599	듣다	1	ㄷ	\N
600	자르다	1	ㅈ	\N
601	짧다	1	ㅉ	\N
602	뒤	1	ㄷ	\N
603	앞	1	ㅇ	\N
604	오른쪽	1	ㅇ	\N
605	왼쪽	1	ㅇ	\N
606	길다	1	ㄱ	\N
607	앉다	1	ㅇ	\N
608	서다	1	ㅅ	\N
609	친구	1	ㅊ	\N
610	반	1	ㅂ	\N
611	교실	1	ㄱ	\N
612	복도	1	ㅂ	\N
613	학교	1	ㅎ	\N
614	학생	1	ㅎ	\N
615	공부	1	ㄱ	\N
616	학생	1	ㅎ	\N
617	유학생	1	ㅇ	\N
618	여름 방학	1	ㅇ	\N
619	선생님	1	ㅅ	\N
620	대학교	1	ㄷ	\N
621	노트	1	ㄴ	\N
622	수업	1	ㅅ	\N
623	작문	1	ㅈ	\N
624	숙제	1	ㅅ	\N
625	어렵다	1	ㅇ	\N
626	가르치다	1	ㄱ	\N
627	시험	1	ㅅ	\N
628	연습	1	ㅇ	\N
629	쉽다	1	ㅅ	\N
630	연습하다	1	ㅇ	\N
631	질문	1	ㅈ	\N
632	문제	1	ㅁ	\N
633	대답하다	1	ㄷ	\N
634	아프다	1	ㅇ	\N
635	이	1	ㅇ	\N
636	의사	1	ㅇ	\N
637	병원	1	ㅂ	\N
638	병	1	ㅂ	\N
639	약	1	ㅇ	\N
640	죽다	1	ㅈ	\N
641	감기	1	ㄱ	\N
642	머리	1	ㅁ	\N
643	배	1	ㅂ	\N
644	도	1	ㄷ	\N
645	엘리베이터	1	ㅇ	\N
648	계단	1	ㄱ	\N
649	닫다	1	ㄷ	\N
651	지하철	1	ㅈ	\N
652	타다	1	ㅌ	\N
653	열다	1	ㅇ	\N
654	화장실	1	ㅎ	\N
655	화장실	1	ㅎ	\N
656	전철	1	ㅈ	\N
657	음료수	1	ㅇ	\N
658	커피	1	ㅋ	\N
659	카페	1	ㅋ	\N
660	레몬	1	ㄹ	\N
661	우유	1	ㅇ	\N
662	설탕	1	ㅅ	\N
663	컵	1	ㅋ	\N
664	차	1	ㅊ	\N
665	홍차	1	ㅎ	\N
666	컵	1	ㅋ	\N
667	넣다	1	ㄴ	\N
668	달다	1	ㄷ	\N
669	마시다	1	ㅁ	\N
670	젓가락	1	ㅈ	\N
671	술	1	ㅅ	\N
672	맛(이)있다	1	ㅁ	\N
673	나이프	1	ㄴ	\N
674	숟가락	1	ㅅ	\N
675	포크	1	ㅍ	\N
676	치즈	1	ㅊ	\N
677	먹다	1	ㅁ	\N
678	맛(이)없다	1	ㅁ	\N
679	빵	1	ㅃ	\N
680	맵다	1	ㅁ	\N
681	레스토랑	1	ㄹ	\N
682	식당	1	ㅅ	\N
683	와인	1	ㅇ	\N
684	음식	1	ㅇ	\N
685	카레라이스	1	ㅋ	\N
686	돈	1	ㄷ	\N
687	은행	1	ㅇ	\N
688	입구	1	ㅇ	\N
690	아뇨	1	ㅇ	\N
691	네	1	ㄴ	\N
692	죄송합니다	1	ㅈ	\N
694	출구	1	ㅊ	\N
695	도착하다	1	ㄷ	\N
696	우체통	1	ㅇ	\N
697	엽서	1	ㅇ	\N
698	붙이다	1	ㅂ	\N
699	봉투	1	ㅂ	\N
700	편지	1	ㅍ	\N
701	우체국	1	ㅇ	\N
702	갚다	1	ㄱ	\N
703	내다	1	ㄴ	\N
704	우표	1	ㅇ	\N
705	짐	1	ㅈ	\N
706	장	1	ㅈ	\N
707	빌려주다	1	ㅂ	\N
708	사다	1	ㅅ	\N
709	모자	1	ㅁ	\N
711	쇼핑	1	ㅅ	\N
712	층	1	ㅊ	\N
713	백화점	1	ㅂ	\N
714	치마	1	ㅊ	\N
715	외투	1	ㅇ	\N
716	바지	1	ㅂ	\N
717	스웨터	1	ㅅ	\N
718	~아/어 주세요	1	ㅇ	\N
719	가방	1	ㄱ	\N
720	팔다	1	ㅍ	\N
721	자켓	1	ㅈ	\N
722	욕실	1	ㅇ	\N
723	건물	1	ㄱ	\N
724	부엌	1	ㅂ	\N
725	샤워	1	ㅅ	\N
726	창문	1	ㅊ	\N
727	살다	1	ㅅ	\N
728	공원	1	ㄱ	\N
729	문	1	ㅁ	\N
730	샤워(를) 하다	1	ㅅ	\N
731	아파트	1	ㅇ	\N
732	현관	1	ㅎ	\N
733	그, 그녀	1	ㄱ	\N
734	그 사람들	1	ㄱ	\N
735	저	1	ㅈ	\N
736	저희	1	ㅈ	\N
737	누군가	1	ㄴ	\N
738	누구	1	ㄴ	\N
739	누구	1	ㄴ	\N
740	너	1	ㄴ	\N
742	이	1	ㅇ	\N
743	그	1	ㄱ	\N
744	어떻다	1	ㅇ	\N
745	어느	1	ㅇ	\N
746	어떤	1	ㅇ	\N
747	이런	1	ㅇ	\N
748	자기	1	ㅈ	\N
749	그렇다	1	ㄱ	\N
750	두껍다	1	ㄷ	\N
751	좁다	1	ㅈ	\N
752	가늘다	1	ㄱ	\N
753	크다	1	ㅋ	\N
754	굵다	1	ㄱ	\N
755	젊다	1	ㅈ	\N
756	넓다	1	ㄴ	\N
757	가볍다	1	ㄱ	\N
758	멀다	1	ㅁ	\N
759	무겁다	1	ㅁ	\N
760	얇다	1	ㅇ	\N
761	새롭다	1	ㅅ	\N
762	작다	1	ㅈ	\N
763	가깝다	1	ㄱ	\N
764	낡다	1	ㄴ	\N
765	즐겁다	1	ㅈ	\N
766	떠들썩하다	1	ㄸ	\N
767	낮다	1	ㄴ	\N
768	좋다	1	ㅈ	\N
769	밝다	1	ㅂ	\N
770	약하다	1	ㅇ	\N
771	세다	1	ㅅ	\N
772	재미있다	1	ㅈ	\N
773	예쁘다	1	ㅇ	\N
774	늦다	1	ㄴ	\N
775	나쁘다	1	ㄴ	\N
776	많다	1	ㅁ	\N
777	어둡다	1	ㅇ	\N
778	조용하다	1	ㅈ	\N
779	적다	1	ㅈ	\N
780	더럽다	1	ㄷ	\N
781	재미없다	1	ㅈ	\N
782	옆	1	ㅇ	\N
783	안	1	ㅇ	\N
784	밖	1	ㅂ	\N
785	동쪽	1	ㄷ	\N
786	높이	1	ㄴ	\N
787	세로	1	ㅅ	\N
788	북쪽	1	ㅂ	\N
789	서쪽	1	ㅅ	\N
790	아래	1	ㅇ	\N
791	남쪽	1	ㄴ	\N
792	위	1	ㅇ	\N
793	앞	1	ㅇ	\N
794	뒤	1	ㄷ	\N
795	사촌	1	ㅅ	\N
796	형	1	ㅎ	\N
797	형제	1	ㅎ	\N
798	할머니	1	ㅎ	\N
799	할아버지	1	ㅎ	\N
800	부인	1	ㅂ	\N
801	어머니	1	ㅇ	\N
802	삼촌	1	ㅅ	\N
803	부모	1	ㅂ	\N
804	아버지	1	ㅇ	\N
805	누나	1	ㄴ	\N
806	자매	1	ㅈ	\N
807	고모	1	ㄱ	\N
808	형	1	ㅎ	\N
809	누나	1	ㄴ	\N
810	아빠	1	ㅇ	\N
811	엄마	1	ㅇ	\N
812	양말	1	ㅇ	\N
813	셔츠	1	ㅅ	\N
814	벗다	1	ㅂ	\N
815	걸다	1	ㄱ	\N
816	입다	1	ㅇ	\N
817	입다	1	ㅇ	\N
818	쓰다	1	ㅆ	\N
819	손수건	1	ㅅ	\N
820	슬리퍼	1	ㅅ	\N
821	우산	1	ㅇ	\N
822	주머니	1	ㅈ	\N
823	지갑	1	ㅈ	\N
824	입은	1	ㅇ	\N
825	옷	1	ㅇ	\N
826	옷	1	ㅇ	\N
827	입	1	ㅇ	\N
828	팔	1	ㅍ	\N
829	몸	1	ㅁ	\N
830	얼굴	1	ㅇ	\N
831	다리	1	ㄷ	\N
832	손	1	ㅅ	\N
833	코	1	ㅋ	\N
834	눈	1	ㄴ	\N
835	귀	1	ㄱ	\N
836	발	1	ㅂ	\N
837	배	1	ㅂ	\N
838	접시	1	ㅈ	\N
839	버터	1	ㅂ	\N
840	그릇	1	ㄱ	\N
841	사탕	1	ㅅ	\N
842	점심	1	ㅈ	\N
843	저녁	1	ㅈ	\N
844	과자	1	ㄱ	\N
845	계란	1	ㄱ	\N
846	아침	1	ㅇ	\N
847	밥	1	ㅂ	\N
848	간장	1	ㄱ	\N
849	소금	1	ㅅ	\N
850	저녁	1	ㅈ	\N
851	더하다	1	ㄷ	\N
852	붙이다	1	ㅂ	\N
853	카메라	1	ㅋ	\N
854	난로	1	ㄴ	\N
855	연필	1	ㅇ	\N
856	지우다	1	ㅈ	\N
857	안경	1	ㅇ	\N
858	녹음기	1	ㄴ	\N
859	시계	1	ㅅ	\N
860	컴퓨터	1	ㅋ	\N
861	필름	1	ㅍ	\N
862	문	1	ㅁ	\N
863	대문	1	ㄷ	\N
864	펜	1	ㅍ	\N
865	만년필	1	ㅁ	\N
866	볼펜	1	ㅂ	\N
867	팔월	1	ㅍ	\N
868	사월	1	ㅅ	\N
869	이번 달	1	ㅇ	\N
870	매월	1	ㅁ	\N
871	십이월	1	ㅅ	\N
872	이월	1	ㅇ	\N
873	일월	1	ㅇ	\N
874	칠월	1	ㅊ	\N
875	유월	1	ㅇ	\N
876	다음 달	1	ㄷ	\N
877	오월	1	ㅇ	\N
878	삼월	1	ㅅ	\N
879	지난달	1	ㅈ	\N
880	십일월	1	ㅅ	\N
881	시월	1	ㅅ	\N
882	구월	1	ㄱ	\N
883	한 달	1	ㅎ	\N
884	이번 주	1	ㅇ	\N
885	매주	1	ㅁ	\N
886	일요일	1	ㅇ	\N
887	목요일	1	ㅁ	\N
888	다음 주	1	ㄷ	\N
889	월요일	1	ㅇ	\N
890	화요일	1	ㅎ	\N
891	수요일	1	ㅅ	\N
892	토요일	1	ㅌ	\N
893	주일	1	ㅈ	\N
894	지난주	1	ㅈ	\N
895	금요일	1	ㄱ	\N
896	년	1	ㄴ	\N
897	가을	1	ㄱ	\N
898	올해	1	ㅇ	\N
899	매년	1	ㅁ	\N
900	여름	1	ㅇ	\N
901	겨울	1	ㄱ	\N
902	작년	1	ㅈ	\N
903	내년	1	ㄴ	\N
904	봄	1	ㅂ	\N
905	다음다음 해	1	ㄷ	\N
906	재작년	1	ㅈ	\N
907	오후	1	ㅇ	\N
908	오늘	1	ㅇ	\N
909	내일	1	ㄴ	\N
910	시	1	ㅅ	\N
911	어제	1	ㅇ	\N
912	어젯밤	1	ㅇ	\N
913	오전	1	ㅇ	\N
914	아침	1	ㅇ	\N
915	낮	1	ㄴ	\N
916	밤	1	ㅂ	\N
919	그저께	1	ㄱ	\N
920	벌써	1	ㅂ	\N
921	…면서	1	ㅁ	\N
922	아직	1	ㅇ	\N
923	온 …	1	ㅇ	\N
924	시간	1	ㅅ	\N
925	언제	1	ㅇ	\N
926	가끔	1	ㄱ	\N
927	자주	1	ㅈ	\N
928	시간	1	ㅅ	\N
929	금방	1	ㄱ	\N
930	재떨이	1	ㅈ	\N
931	노래	1	ㄴ	\N
932	노래하다	1	ㄴ	\N
933	담배	1	ㄷ	\N
934	영화	1	ㅇ	\N
935	음반	1	ㅇ	\N
936	기타	1	ㄱ	\N
937	치다	1	ㅊ	\N
938	음악	1	ㅇ	\N
939	그림	1	ㄱ	\N
940	사진	1	ㅅ	\N
941	좋아하다	1	ㅈ	\N
942	목소리	1	ㅁ	\N
944	덥다	1	ㄷ	\N
945	개다	1	ㄱ	\N
946	선선하다	1	ㅅ	\N
947	춥다	1	ㅊ	\N
948	눈	1	ㄴ	\N
949	비가 내리다	1	ㅂ	\N
950	비	1	ㅂ	\N
951	날씨	1	ㄴ	\N
952	따뜻하다	1	ㄸ	\N
953	바람	1	ㅂ	\N
954	흐림	1	ㅎ	\N
955	차다	1	ㅊ	\N
956	흐리다	1	ㅎ	\N
984	파랑, 파랗다	1	ㅍ	\N
985	갈색	1	ㄱ	\N
986	밝다, 엷다	1	ㅂ	\N
987	색깔	1	ㅅ	\N
988	짙다, 어둡다	1	ㅈ	\N
989	노랑, 노랗다	1	ㄴ	\N
990	검정, 검다	1	ㄱ	\N
991	빨강, 붉다	1	ㅃ	\N
992	녹색	1	ㄴ	\N
993	편리하다	1	ㅍ	\N
994	파티	1	ㅍ	\N
995	종이	1	ㅈ	\N
996	(…이/가) 되다	1	ㄷ	\N
997	조르다	1	ㅈ	\N
998	누르다	1	ㄴ	\N
999	시작되다	1	ㅅ	\N
1000	마침	1	ㅁ	\N
1001	없다	1	ㅇ	\N
1002	쭉	1	ㅉ	\N
1003	유명하다	1	ㅇ	\N
1004	건강하다	1	ㄱ	\N
1005	그럼	1	ㄱ	\N
1006	아마	1	ㅇ	\N
1007	그럼	1	ㄱ	\N
1008	한국말	1	ㅎ	\N
1009	이모	1	ㅇ	\N
1010	아니에요	1	ㅇ	\N
1011	미안합니다	1	ㅁ	\N
693		0		\N
710	신발	0	ㅅ	\N
741		0		\N
943		0		\N
968		0		\N
969		0		\N
\.


--
-- Data for Name: t_word_inst_rel; Type: TABLE DATA; Schema: public; Owner: ko
--

COPY t_word_inst_rel (word_id, token, sense, pos, cform, reading, pronunciation, inst_id, ptoken) FROM stdin;
1	어	あ	間投詞	\N	\N	\N	1	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	1	\N
3	안녕하십니까	こんにちは	形容詞	\N	\N	\N	1	\N
3	안녕하세요	こんにちは	形容詞	\N	\N	\N	2	\N
4	잘	元気に	副詞	\N	\N	\N	3	\N
5	지내세요	お過ごしですか	動詞	\N	\N	\N	3	\N
6	네	ええ	間投詞	\N	\N	\N	4	\N
2	～씨는요	～さんは	不完全名詞	\N	\N	\N	5	\N
7	예	ええ	間投詞	\N	\N	\N	6	\N
8	저도	私も	代名詞	\N	\N	\N	6	\N
4	잘	元気に	副詞	\N	\N	\N	6	\N
5	지내요	過ごしています	動詞	\N	\N	\N	6	\N
9	어제	昨日	名詞	\N	\N	\N	7	\N
10	백화점에서	デパートで	名詞	\N	\N	\N	7	\N
11	이걸	これを	代名詞	\N	\N	\N	7	\N
12	샀는데요	買ったんですけど	動詞	\N	\N	\N	7	\N
13	그게	それは	代名詞	\N	\N	\N	8	\N
14	뭐에요	何ですか	代名詞	\N	\N	\N	8	\N
15	계산기	電卓	名詞	\N	\N	\N	9	\N
16	아닙니까	～ではありませんか	指定詞	\N	\N	\N	9	\N
16	아니에요	ちがいます	指定詞	\N	\N	\N	10	\N
17	전자 사전이에요	電子辞典です	名詞	\N	\N	\N	11	\N
18	한일 사전입니까	韓日辞典ですか	名詞	\N	\N	\N	12	\N
6	네	はい	間投詞 	\N	\N	\N	13	\N
19	그렇습니다	そうです	形容詞	\N	\N	\N	13	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	14	\N
3	안녕하세요	こんにちは	形容詞	\N	\N	\N	14	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	15	\N
3	안녕하세요	こんにちは	形容詞	\N	\N	\N	15	\N
20	어디	どちらへ	疑問詞	\N	\N	\N	16	\N
21	가세요	いらっしゃるんですか	動詞	\N	\N	\N	16	\N
22	학교	学校に	名詞	\N	\N	\N	17	\N
21	가는	行く	動詞	\N	\N	\N	17	\N
23	길입니다	(～する)ところです	名詞	\N	\N	\N	17	\N
24	짐이	荷物が	名詞	\N	\N	\N	18	\N
25	많네요	多いですね	形容詞	\N	\N	\N	18	\N
14	뭘	何を	代名詞	\N	\N	\N	19	\N
12	샀어요	お買いになりましたか	動詞	\N	\N	\N	19	\N
26	책을	本を	名詞	\N	\N	\N	20	\N
12	샀어요	買いました	動詞	\N	\N	\N	20	\N
27	하나	ひとつ	数詞	\N	\N	\N	21	\N
28	주세요	下さい	動詞	\N	\N	\N	21	\N
8	제가	私が	代名詞	\N	\N	\N	22	\N
29	들어 줄게요	お持ちしますから	動詞	\N	\N	\N	22	\N
30	고맙습니다	ありがとうございます	形容詞	\N	\N	\N	23	\N
30	고맙기는요	どういたしまして	形容詞	\N	\N	\N	24	\N
31	여기요	すみません	代名詞	\N	\N	\N	25	\N
32	잠깐만요	少々お待ちください	副詞	\N	\N	\N	26	\N
31	여기요	すみません	代名詞 	\N	\N	\N	27	\N
7	예	はい	間投詞	\N	\N	\N	28	\N
33	지금	今	名詞	\N	\N	\N	28	\N
21	갑니다	うかがいます	動詞	\N	\N	\N	28	\N
34	먼저	まず	副詞	\N	\N	\N	29	\N
35	메뉴판	メニュー	名詞	\N	\N	\N	29	\N
36	좀	ちょっと	副詞	\N	\N	\N	29	\N
28	주세요	下さい	動詞	\N	\N	\N	29	\N
6	네	はい	間投詞	\N	\N	\N	30	\N
31	여기 있습니다	どうぞ	代名詞	\N	\N	\N	30	\N
14	뭘	何を	代名詞	\N	\N	\N	31	\N
37	주문하시겠습니까	注文なさいますか	動詞	\N	\N	\N	31	\N
14	뭐가	何が	代名詞	\N	\N	\N	32	\N
38	맛있어요	おいしいですか	形容詞	\N	\N	\N	32	\N
39	다	みんな	副詞	\N	\N	\N	33	\N
38	맛있어요	おいしいです	形容詞	\N	\N	\N	33	\N
40	응	ウーン	間投詞	\N	\N	\N	34	\N
41	그럼	それじゃ	副詞	\N	\N	\N	34	\N
42	돌솥 비빔밥	石焼ビビンバ	名詞	\N	\N	\N	34	\N
28	주세요	下さい	動詞	\N	\N	\N	34	\N
6	네	はい	間投詞	\N	\N	\N	35	\N
43	알겠습니다	かしこまりました	動詞	\N	\N	\N	35	\N
44	처음	はじめて	副詞	\N	\N	\N	36	\N
45	뵙겠습니다	お目にかかります	動詞	\N	\N	\N	36	\N
8	저는	私は	代名詞	\N	\N	\N	37	\N
44	처음	はじめて	副詞	\N	\N	\N	38	\N
45	뵙겠습니다	お目にかかります	動詞	\N	\N	\N	38	\N
8	저는	私は	代名詞	\N	\N	\N	39	\N
46	만나서	お会いできて	動詞	\N	\N	\N	40	\N
47	반갑습니다	うれしいです	形容詞	\N	\N	\N	40	\N
2	~씨는	~さんは	不完全名詞	\N	\N	\N	41	\N
48	학생이세요	学生ですか	名詞	\N	\N	\N	41	\N
7	예	はい	間投詞	\N	\N	\N	42	\N
2	~씨는요	~さんは	不完全名詞	\N	\N	\N	43	\N
8	저도	私も	代名詞	\N	\N	\N	44	\N
48	학생이에요	学生です	名詞	\N	\N	\N	44	\N
8	저	あの	間投詞	\N	\N	\N	45	\N
49	실례지만	失礼ですが	名詞	\N	\N	\N	45	\N
50	나이가	年が	名詞	\N	\N	\N	45	\N
51	어떻게	どう	形容詞	\N	\N	\N	45	\N
52	되세요	なりますか	動詞	\N	\N	\N	45	\N
53	스무	二十	数詞	\N	\N	\N	46	\N
54	살이에요	歳です	名数詞	\N	\N	\N	46	\N
55	아	あ	間投詞	\N	\N	\N	47	\N
19	그래요	そうですか	形容詞	\N	\N	\N	47	\N
56	동갑이네요	同い年ですね	名詞	\N	\N	\N	48	\N
2	~씨는	~さんは	不完全名詞	\N	\N	\N	49	\N
57	전공이	専攻は	名詞	\N	\N	\N	49	\N
58	뭐에요	何ですか	代名詞	\N	\N	\N	49	\N
59	경제학이에요	経済学です	名詞	\N	\N	\N	50	\N
2	~씨는요	~さんは	不完全名詞	\N	\N	\N	51	\N
8	저요	私ですか	代名詞	\N	\N	\N	52	\N
8	저는	私は	代名詞	\N	\N	\N	53	\N
60	문학이에요	文学です	名詞	\N	\N	\N	53	\N
8	저	あのう	間投詞	\N	\N	\N	54	\N
2	씨	～さん	不完全名詞	\N	\N	\N	54	\N
61	왜요	なんですか	副詞	\N	\N	\N	55	\N
62	무슨	何の	冠形詞	\N	\N	\N	56	\N
63	일이에요	ことですか	名詞	\N	\N	\N	56	\N
8	저	あのう	間投詞	\N	\N	\N	57	\N
2	씨	～さんの	不完全名詞	\N	\N	\N	57	\N
64	우산	傘の	名詞	\N	\N	\N	57	\N
65	말인데요	ことなんですが	名詞	\N	\N	\N	57	\N
54	내	ぼくの	代名詞	\N	\N	\N	58	\N
64	우산	傘	名詞	\N	\N	\N	58	\N
66	검은	黒い	形容詞	\N	\N	\N	59	\N
64	우산	傘の	名詞	\N	\N	\N	59	\N
65	말이죠	ことでしょう	名詞	\N	\N	\N	59	\N
7	예	ええ，はい	間投詞	\N	\N	\N	60	\N
67	지난 주	先週	副詞	\N	\N	\N	60	\N
8	제가	私が	代名詞	\N	\N	\N	60	\N
68	빌려	借りて	動詞	\N	\N	\N	60	\N
21	갔는데요	行ったんですけど	動詞	\N	\N	\N	60	\N
69	지하철에서	地下鉄で	名詞	\N	\N	\N	60	\N
70	잃어 버렸거든요	なくしてしまったんですよ	動詞	\N	\N	\N	60	\N
19	그래요	そうですか	形容詞	\N	\N	\N	61	\N
71	미안해요	ごめんなさい	形容詞	\N	\N	\N	62	\N
2	씨	～さん	不完全名詞	\N	\N	\N	62	\N
72	아니	いや，いえ	間投詞	\N	\N	\N	63	\N
73	괜찮아요	いいですよ，大丈夫ですよ	形容詞	\N	\N	\N	63	\N
74	그래두	でも	接続詞	\N	\N	\N	64	\N
75	싼	安い	形容詞	\N	\N	\N	65	\N
64	우산이니까	傘だから	名詞	\N	\N	\N	65	\N
73	괜찮아요	大丈夫ですよ	形容詞	\N	\N	\N	65	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	66	\N
11	이게	これは	代名詞	\N	\N	\N	66	\N
14	뭐에요	何ですか	疑問代名詞	\N	\N	\N	66	\N
11	이거요	これですか	代名詞	\N	\N	\N	67	\N
11	이건	これは	代名詞	\N	\N	\N	68	\N
76	한국	韓国	名詞	\N	\N	\N	68	\N
77	탈이에요	お面です	名詞	\N	\N	\N	68	\N
78	재미있네요	面白いですね	名詞	\N	\N	\N	69	\N
44	처음	始めて	副詞	\N	\N	\N	70	\N
79	봤어요	見ましたよ	動詞	\N	\N	\N	70	\N
27	하나	一つ	数詞	\N	\N	\N	71	\N
80	드릴까요	差し上げましょうか	動詞	\N	\N	\N	71	\N
72	아니	いえ	間投詞	\N	\N	\N	72	\N
19	그런	そんな	形容詞	\N	\N	\N	72	\N
81	뜻이 아니라	意味じゃなくて	名詞	\N	\N	\N	72	\N
82	집에	家に	名詞	\N	\N	\N	73	\N
83	많이	たくさん	副詞	\N	\N	\N	73	\N
84	있으니까	ありますから	動詞	\N	\N	\N	73	\N
27	하나	一つ	数詞	\N	\N	\N	73	\N
28	줄게요	あげます	動詞	\N	\N	\N	73	\N
19	그래요	そうですか	形容詞	\N	\N	\N	74	\N
41	그럼	じゃ	接続詞	\N	\N	\N	75	\N
85	받을게요	いただきます	動詞	\N	\N	\N	75	\N
30	고마워요	ありがとうございます	形容詞	\N	\N	\N	76	\N
86	일본에도	日本にも	名詞	\N	\N	\N	77	\N
77	탈이	お面が	名詞	\N	\N	\N	77	\N
84	있죠	あるでしょう	存在詞	\N	\N	\N	77	\N
76	한국	韓国	名詞	\N	\N	\N	78	\N
87	것과	~のと	不完全名詞	\N	\N	\N	78	\N
88	똑같애요	そっくりですか	形容詞	\N	\N	\N	78	\N
72	아뇨	いいえ 	間投詞	\N	\N	\N	79	\N
89	아주	とても	副詞	\N	\N	\N	79	\N
90	달라요	違います	形容詞	\N	\N	\N	79	\N
19	그래요	そうですか	形容詞	\N	\N	\N	80	\N
91	한번	一度	副詞	\N	\N	\N	81	\N
79	보고 싶네요	見たいですね 	動詞	\N	\N	\N	81	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	82	\N
92	오늘	今日は	名詞	\N	\N	\N	82	\N
93	초대해 주셔서	招待して下さって	動詞	\N	\N	\N	82	\N
94	정말	本当に	副詞	\N	\N	\N	82	\N
95	감사합니다	ありがとうございました	形容詞	\N	\N	\N	82	\N
96	별로	特別に	副詞	\N	\N	\N	83	\N
97	차린	準備した	動詞	\N	\N	\N	83	\N
87	것도	~ものも	不完全名詞	\N	\N	\N	83	\N
98	없는데	ないのに	存在詞	\N	\N	\N	83	\N
99	와 주셔서	おいで下さって	動詞	\N	\N	\N	83	\N
30	고마워요	ありがとうございました	形容詞	\N	\N	\N	83	\N
100	별 말씀을요	とんでもありません	名詞	\N	\N	\N	84	\N
41	그럼	では	接続詞	\N	\N	\N	85	\N
101	이만	これで	副詞	\N	\N	\N	85	\N
21	가 보겠습니다	失礼します	動詞	\N	\N	\N	85	\N
102	음식이	食べ物が	名詞	\N	\N	\N	86	\N
103	아직	まだ	副詞	\N	\N	\N	86	\N
83	많이	たくさん	副詞	\N	\N	\N	86	\N
12	남았는데	残っていますから	動詞	\N	\N	\N	86	\N
39	다	全部	副詞	\N	\N	\N	86	\N
104	드시고	召し上がって	動詞	\N	\N	\N	86	\N
21	가세요	行って下さい	動詞	\N	\N	\N	86	\N
16	아니에요	いいえ	指定詞	\N	\N	\N	87	\N
105	너무	あまりにも	副詞	\N	\N	\N	88	\N
83	많이	たくさん	副詞	\N	\N	\N	88	\N
106	먹어서	食べて	動詞	\N	\N	\N	88	\N
107	배가	おなかが	名詞	\N	\N	\N	88	\N
108	불러요	いっぱいです	形容詞	\N	\N	\N	88	\N
2	～씨도	～さんも	不完全名詞	\N	\N	\N	89	\N
109	다음엔	今度は	名詞	\N	\N	\N	89	\N
110	꼭	ぜひ	副詞	\N	\N	\N	89	\N
111	우리	私たちの	代名詞	\N	\N	\N	89	\N
82	집에	家に	名詞	\N	\N	\N	89	\N
112	놀러	遊びに	動詞	\N	\N	\N	89	\N
99	오세요	おいで下さい	動詞	\N	\N	\N	89	\N
7	예	ええ	間投詞	\N	\N	\N	90	\N
30	고맙습니다	ありがとうございます	形容詞	\N	\N	\N	90	\N
110	꼭	ぜひ	副詞	\N	\N	\N	91	\N
21	갈게요	お伺いします	動詞	\N	\N	\N	91	\N
92	오늘	今日は	名詞	\N	\N	\N	92	\N
113	정말로	本当に	副詞	\N	\N	\N	92	\N
114	맛있게	おいしく	副詞	\N	\N	\N	92	\N
4	잘	よく	副詞	\N	\N	\N	92	\N
106	먹었어요	食べました	動詞	\N	\N	\N	92	\N
115	안녕히	お元気に	副詞	\N	\N	\N	93	\N
116	계세요	いらっしゃってください	存在詞	\N	\N	\N	93	\N
6	네	ええ	間投詞	\N	\N	\N	94	\N
115	안녕히	気をつけて	副詞	\N	\N	\N	94	\N
21	가세요	お行きください	動詞	\N	\N	\N	94	\N
117	어머	あら	間投詞	\N	\N	\N	95	\N
2	~씨	~さん	不完全名詞	\N	\N	\N	95	\N
62	무슨	何の	冠形詞	\N	\N	\N	95	\N
24	짐이	荷物が	名詞	\N	\N	\N	95	\N
19	그렇게	そんなに	形容詞	\N	\N	\N	95	\N
25	많아요	多いですね	形容詞	\N	\N	\N	95	\N
118	저기	あそこ	代名詞	\N	\N	\N	96	\N
8	저	あの	冠形詞	\N	\N	\N	96	\N
119	벼룩 시장에서	フリーマーケットで	名詞	\N	\N	\N	96	\N
75	싼	安い	形容詞	\N	\N	\N	96	\N
120	물건을	ものを	名詞	\N	\N	\N	96	\N
83	많이	たくさん	副詞	\N	\N	\N	96	\N
12	샀거든요	買ったんですよ	動詞	\N	\N	\N	96	\N
121	옷도	服も	名詞	\N	\N	\N	97	\N
84	있고	あるし	存在詞	\N	\N	\N	97	\N
122	구두도	靴も	名詞	\N	\N	\N	97	\N
123	지우개까지	消しゴムまで	名詞	\N	\N	\N	97	\N
123	지우개는	消しゴムは	名詞	\N	\N	\N	98	\N
39	십	10	数詞	\N	\N	\N	98	\N
124	원씩이었어요	一つ~ウォンでした	名数詞	\N	\N	\N	98	\N
125	와	ワ	間投詞	\N	\N	\N	99	\N
94	정말	本当に	副詞	\N	\N	\N	99	\N
75	싸다	安い	形容詞	\N	\N	\N	99	\N
63	이	この	冠形詞	\N	\N	\N	100	\N
121	옷은	服は	名詞	\N	\N	\N	100	\N
126	얼마에요	いくらですか	名詞	\N	\N	\N	100	\N
127	그	その	冠形詞	\N	\N	\N	101	\N
121	옷은	服は	名詞	\N	\N	\N	101	\N
128	오천	5000	数詞	\N	\N	\N	101	\N
124	원이에요	ウォンです	名数詞	\N	\N	\N	101	\N
41	그럼	じゃあ	接続詞	\N	\N	\N	102	\N
63	이	この	冠形詞	\N	\N	\N	102	\N
122	구두는	靴は	名詞	\N	\N	\N	102	\N
126	얼마에요	いくらですか	名詞	\N	\N	\N	102	\N
13	그건	それは	代名詞	\N	\N	\N	103	\N
129	한	一	数詞	\N	\N	\N	103	\N
130	켤레에	足で	名数詞	\N	\N	\N	103	\N
131	만	10000	数詞	\N	\N	\N	103	\N
124	원이에요	ウォンです	名数詞	\N	\N	\N	103	\N
132	진짜	本当に	副詞	\N	\N	\N	104	\N
75	싸네요	安いですね	形容詞	\N	\N	\N	104	\N
133	같이	いっしょに	副詞	\N	\N	\N	105	\N
91	한번	一度	副詞	\N	\N	\N	105	\N
21	가 볼래요	行ってみますか	動詞	\N	\N	\N	105	\N
2	～씨는	～さんは	不完全名詞	\N	\N	\N	106	\N
76	한국에	韓国に	固有名詞	\N	\N	\N	106	\N
21	가 본	行ってみた	動詞	\N	\N	\N	106	\N
134	적	~こと	不完全名詞	\N	\N	\N	106	\N
84	있어요	ありますか	存在詞	\N	\N	\N	106	\N
6	네	ええ	間投詞	\N	\N	\N	107	\N
135	작년에	去年	名詞	\N	\N	\N	107	\N
27	한 번	一度	数詞	\N	\N	\N	107	\N
21	가 봤어요	行ってみました	動詞	\N	\N	\N	107	\N
76	한국	韓国	固有名詞	\N	\N	\N	108	\N
51	어땠어요	どうでしたか	形容詞	\N	\N	\N	108	\N
78	재미있었어요	面白かったですか	名詞	\N	\N	\N	109	\N
89	아주	とても	副詞	\N	\N	\N	110	\N
78	재미있었어요	面白かったです	名詞	\N	\N	\N	110	\N
136	거리도	通りも	名詞	\N	\N	\N	111	\N
137	깨끗하고	きれいだし	形容詞	\N	\N	\N	111	\N
138	사람들도	人々も	名詞	\N	\N	\N	111	\N
139	참	とても	副詞	\N	\N	\N	111	\N
140	친절했어요	親切でした	形容詞	\N	\N	\N	111	\N
19	그래요	そうですか	形容詞	\N	\N	\N	112	\N
102	음식은	食べ物は	名詞	\N	\N	\N	113	\N
51	어떤 	どんな	形容詞	\N	\N	\N	113	\N
87	걸	~ものを	不完全名詞	\N	\N	\N	113	\N
106	먹어 봤어요	食べてみましたか	動詞	\N	\N	\N	113	\N
141	한정식을	韓定食を	名詞	\N	\N	\N	114	\N
106	먹었는데	食べたんですが	動詞	\N	\N	\N	114	\N
142	반찬이	おかずが	名詞	\N	\N	\N	114	\N
19	그렇게	あんなに	形容詞	\N	\N	\N	114	\N
83	많이	たくさん	副詞	\N	\N	\N	114	\N
143	나오는	出て来る	動詞	\N	\N	\N	114	\N
87	건	～のは	不完全名詞	\N	\N	\N	114	\N
44	처음	初めて	副詞	\N	\N	\N	114	\N
79	봤어요	見ました	動詞	\N	\N	\N	114	\N
144	갈비도	カルビも	名詞	\N	\N	\N	115	\N
106	먹어 봤어요	食べてみましたか	動詞	\N	\N	\N	115	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	116	\N
145	시간이	時間が	名詞	\N	\N	\N	117	\N
98	없어서	なくて	存在詞	\N	\N	\N	117	\N
146	못	できない	副詞	\N	\N	\N	117	\N
106	먹었어요	食べました	動詞	\N	\N	\N	117	\N
41	그럼	では	接続詞	\N	\N	\N	118	\N
147	내가	私が	代名詞	\N	\N	\N	118	\N
148	동경에	東京に	固有名詞	\N	\N	\N	118	\N
38	맛있는	おいしい	形容詞	\N	\N	\N	118	\N
149	갈비집을	カルビのお店を	名詞	\N	\N	\N	118	\N
27	하나	一軒	数詞	\N	\N	\N	118	\N
182	술도	お酒も	名詞	\N	\N	\N	148	\N
43	아는데	知っているんですが	動詞	\N	\N	\N	118	\N
133	같이	いっしょに	副詞	\N	\N	\N	118	\N
150	안	ない	副詞	\N	\N	\N	118	\N
21	갈래요	行きますか	動詞	\N	\N	\N	118	\N
6	네	ええ	間投詞	\N	\N	\N	119	\N
151	좋아요	いいですよ	形容詞	\N	\N	\N	119	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	120	\N
152	내일	明日	名詞	\N	\N	\N	120	\N
20	어디	どこに	代名詞 	\N	\N	\N	120	\N
21	가요	行きますか	動詞	\N	\N	\N	120	\N
153	도서관에	図書館に	名詞	\N	\N	\N	121	\N
21	갈	行く	動詞	\N	\N	\N	121	\N
154	예정인데	つもりですが	名詞	\N	\N	\N	121	\N
61	왜요	どうしてですか	副詞	\N	\N	\N	121	\N
152	내일	明日	名詞	\N	\N	\N	122	\N
10	백화점에서	デパートで	名詞	\N	\N	\N	122	\N
155	세일을	セールを	名詞	\N	\N	\N	122	\N
156	하는데	するんですが	動詞	\N	\N	\N	122	\N
133	같이	いっしょに	副詞	\N	\N	\N	122	\N
21	갈까	行こうかと	動詞	\N	\N	\N	122	\N
127	그	その	冠形詞	\N	\N	\N	123	\N
155	세일은	セールは	名詞	\N	\N	\N	123	\N
157	언제까지	いつまで	代名詞	\N	\N	\N	123	\N
156	하는데요	するんですか	動詞	\N	\N	\N	123	\N
152	내일까지요	明日までです	名詞	\N	\N	\N	124	\N
41	그럼	では	接続詞	\N	\N	\N	125	\N
147	나도	私も	代名詞	\N	\N	\N	125	\N
133	같이	いっしょに	副詞	\N	\N	\N	125	\N
21	갈게요	行きますよ	動詞	\N	\N	\N	125	\N
153	도서관은	図書館は	名詞	\N	\N	\N	126	\N
150	안	ない	副詞	\N	\N	\N	126	\N
21	가도	行っても	動詞	\N	\N	\N	126	\N
73	괜찮아요	いいんですか	形容詞	\N	\N	\N	126	\N
158	공부할	勉強する	動詞	\N	\N	\N	127	\N
159	생각	つもり	名詞	\N	\N	\N	127	\N
16	아니었어요	なかったんですか	指定詞	\N	\N	\N	127	\N
16	아니에요	違います	指定詞	\N	\N	\N	128	\N
26	책을	本を	名詞	\N	\N	\N	129	\N
160	반납하러	返しに	動詞	\N	\N	\N	129	\N
21	가는	行く	動詞	\N	\N	\N	129	\N
87	것뿐이었어요	~だけだったんですよ	不完全名詞	\N	\N	\N	129	\N
19	그래요	そうですか	形容詞	\N	\N	\N	130	\N
41	그럼	じゃ	接続詞	\N	\N	\N	131	\N
161	몇	何	数詞	\N	\N	\N	131	\N
162	시에	時に	名数詞	\N	\N	\N	131	\N
46	만날까요	会いましょうか	動詞	\N	\N	\N	131	\N
163	아홉	9	数詞	\N	\N	\N	132	\N
162	시	時	名数詞	\N	\N	\N	132	\N
164	반에	半に	数詞	\N	\N	\N	132	\N
10	백화점	デパート	名詞	\N	\N	\N	132	\N
165	정문	正面入り口	名詞	\N	\N	\N	132	\N
166	앞에서	前で	名詞	\N	\N	\N	132	\N
46	만나요	会いましょう	動詞	\N	\N	\N	132	\N
2	～씨는	～さんは	不完全名詞	\N	\N	\N	133	\N
51	어떤	どんな	形容詞	\N	\N	\N	133	\N
167	스포츠를	スポーツが	名詞	\N	\N	\N	133	\N
168	좋아하세요	お好きですか	動詞	\N	\N	\N	133	\N
8	저는	私は	代名詞	\N	\N	\N	134	\N
169	테니스를	テニスが	名詞	\N	\N	\N	134	\N
168	좋아해요	好きです	動詞	\N	\N	\N	134	\N
55	아	あ	間投詞	\N	\N	\N	135	\N
19	그러세요	そうですか	形容詞	\N	\N	\N	135	\N
170	요즘도	このごろも	名詞	\N	\N	\N	136	\N
171	자주	よく	副詞	\N	\N	\N	136	\N
156	하세요	なさいますか	動詞	\N	\N	\N	136	\N
172	요샌	最近は	名詞	\N	\N	\N	137	\N
145	시간이	時間が	名詞	\N	\N	\N	137	\N
98	없어서	なくて	存在詞	\N	\N	\N	137	\N
27	한	ひと	数詞	\N	\N	\N	137	\N
39	달에	月に	名詞	\N	\N	\N	137	\N
173	두	二	数詞	\N	\N	\N	137	\N
174	번	回	名数詞	\N	\N	\N	137	\N
175	정도 밖에	くらいしか	名詞	\N	\N	\N	137	\N
176	못해요	できません	動詞	\N	\N	\N	137	\N
2	～씨는요	～さんは	不完全名詞	\N	\N	\N	138	\N
8	저는	私は	代名詞	\N	\N	\N	139	\N
177	야구를	野球が	名詞	\N	\N	\N	139	\N
168	좋아해요	好きです	動詞	\N	\N	\N	139	\N
177	야구를	野球を	名詞	\N	\N	\N	140	\N
156	해요	しますか	動詞	\N	\N	\N	140	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	141	\N
79	보는	見る	動詞	\N	\N	\N	142	\N
87	걸	~ことが	不完全名詞	\N	\N	\N	142	\N
168	좋아해요	好きです	動詞	\N	\N	\N	142	\N
178	야구장에	野球場に	名詞	\N	\N	\N	143	\N
79	보러	見に	動詞	\N	\N	\N	143	\N
21	갈	行く	動詞	\N	\N	\N	143	\N
179	때도	ことも	名詞	\N	\N	\N	143	\N
84	있어요	あります	存在詞	\N	\N	\N	143	\N
27	한	ひと	数詞	\N	\N	\N	144	\N
39	달에	月に	名詞	\N	\N	\N	144	\N
161	몇	何	数詞	\N	\N	\N	144	\N
174	번	回	名数詞	\N	\N	\N	144	\N
175	정도	くらい	名詞	\N	\N	\N	144	\N
178	야구장에	野球場に	名詞	\N	\N	\N	144	\N
21	가는데요	行きますか	動詞	\N	\N	\N	144	\N
180	서너	三，四	数詞	\N	\N	\N	145	\N
174	번은	回	名数詞	\N	\N	\N	145	\N
21	가요	行きます	動詞	\N	\N	\N	145	\N
83	많이	ずいぶん	副詞	\N	\N	\N	146	\N
21	가네요	行きますね	動詞	\N	\N	\N	146	\N
92	오늘	今日	名詞	\N	\N	\N	147	\N
139	참	とても	副詞	\N	\N	\N	147	\N
78	재미있었어요	楽しかったですね	名詞	\N	\N	\N	147	\N
6	네	ええ	間投詞	\N	\N	\N	148	\N
181	오랜만에	久しぶりに	名詞	\N	\N	\N	148	\N
183	마시고	飲んだし	動詞	\N	\N	\N	148	\N
94	정말	本当に	副詞	\N	\N	\N	148	\N
78	재미있었어요	楽しかったです	名詞	\N	\N	\N	148	\N
184	근데	ところで	接続詞	\N	\N	\N	149	\N
33	지금	今	名詞	\N	\N	\N	149	\N
161	몇	何	数詞	\N	\N	\N	149	\N
162	시에요	時ですか	名数詞	\N	\N	\N	149	\N
32	잠깐만요	ええと	副詞	\N	\N	\N	150	\N
185	10	10	数詞	\N	\N	\N	151	\N
162	시	時	名数詞	\N	\N	\N	151	\N
186	55	55	数詞	\N	\N	\N	151	\N
187	분이에요	分です	名数詞	\N	\N	\N	151	\N
94	정말요	本当に	副詞	\N	\N	\N	152	\N
188	큰일났다	大変だ	名詞	\N	\N	\N	153	\N
61	왜요	どうしたんですか	副詞	\N	\N	\N	154	\N
8	제가	僕が	代名詞	\N	\N	\N	155	\N
189	타는	乗る	動詞	\N	\N	\N	155	\N
190	버스는	バスは	名詞	\N	\N	\N	155	\N
191	일찍	早く	副詞	\N	\N	\N	155	\N
192	끊기거든요	なくなっちゃうんです	動詞	\N	\N	\N	155	\N
190	버스	バス	名詞	\N	\N	\N	156	\N
193	막차가	終車は	名詞	\N	\N	\N	156	\N
161	몇	何	数詞	\N	\N	\N	156	\N
162	신데요	時なんですか	名数詞	\N	\N	\N	156	\N
194	아마	たぶん	副詞	\N	\N	\N	157	\N
195	11	11	数詞	\N	\N	\N	157	\N
162	시쯤일	時ごろ	名数詞	\N	\N	\N	157	\N
87	거에요	~と思います	不完全名詞詞	\N	\N	\N	157	\N
41	그럼	じゃあ	接続詞	\N	\N	\N	158	\N
196	빨리	早く	副詞	\N	\N	\N	158	\N
21	가세요	行ってください	動詞	\N	\N	\N	158	\N
197	연구회	研究会	名詞	\N	\N	\N	159	\N
198	준비	準備	名詞	\N	\N	\N	159	\N
39	다	全部	副詞	\N	\N	\N	159	\N
52	됐어요	できましたか	動詞	\N	\N	\N	159	\N
6	네	ええ	間投詞	\N	\N	\N	160	\N
199	거의	ほとんど	副詞	\N	\N	\N	160	\N
39	다	全部	副詞	\N	\N	\N	160	\N
200	끝났어요	終わりました	動詞	\N	\N	\N	160	\N
201	그런데	ところで	接続詞	\N	\N	\N	161	\N
197	연구회에는	研究会には	名詞	\N	\N	\N	161	\N
161	몇	何	数詞	\N	\N	\N	161	\N
202	명	人	名数詞	\N	\N	\N	161	\N
175	정도	くらい	名詞	\N	\N	\N	161	\N
99	올	来る	動詞	\N	\N	\N	161	\N
87	것	~こと	不完全名詞	\N	\N	\N	161	\N
203	같애요	ようですか	形容詞	\N	\N	\N	161	\N
204	삼십	30	数詞	\N	\N	\N	162	\N
202	명	人	名数詞	\N	\N	\N	162	\N
175	정도가	くらいじゃ	名詞	\N	\N	\N	162	\N
16	아닐까요	ないですか	指定詞	\N	\N	\N	162	\N
41	그럼	では	接続詞	\N	\N	\N	163	\N
205	발표	発表	名詞	\N	\N	\N	163	\N
206	원고는	原稿は	名詞	\N	\N	\N	163	\N
204	삼십	30	数詞	\N	\N	\N	163	\N
207	부	部	名数詞	\N	\N	\N	163	\N
175	정도	くらい	名詞	\N	\N	\N	163	\N
208	준비했는데	用意したんですが	動詞	\N	\N	\N	163	\N
11	이걸로	これで	代名詞	\N	\N	\N	163	\N
73	괜찮겠죠	いいですよね	形容詞	\N	\N	\N	163	\N
209	혹시	ひょっとして	副詞	\N	\N	\N	164	\N
210	더	もっと	副詞	\N	\N	\N	164	\N
83	많이	たくさん	副詞	\N	\N	\N	164	\N
99	올지도	来るかも	動詞	\N	\N	\N	164	\N
211	모르니까	知れませんから	動詞	\N	\N	\N	164	\N
212	오십	50	数詞	\N	\N	\N	164	\N
207	부	部	名数詞	\N	\N	\N	164	\N
175	정도	くらい	名詞	\N	\N	\N	164	\N
208	준비하는	用意する	動詞	\N	\N	\N	164	\N
87	게	～のが	不完全名詞	\N	\N	\N	164	\N
151	좋을	いい	形容詞	\N	\N	\N	164	\N
212	오십	50	数詞	\N	\N	\N	165	\N
207	부요	部ですね	名数詞	\N	\N	\N	165	\N
6	네	はい	間投詞	\N	\N	\N	166	\N
43	알겠습니다	わかりました	平叙文	\N	\N	\N	166	\N
31	여기	ここ	代名詞	\N	\N	\N	167	\N
213	학생 식당은	学生食堂は	名詞	\N	\N	\N	167	\N
51	어떻게	どのように	形容詞	\N	\N	\N	167	\N
214	이용하는	利用する	動詞	\N	\N	\N	167	\N
87	거에요	～んですか	不完全名詞	\N	\N	\N	167	\N
31	여기서는	ここでは	代名詞	\N	\N	\N	168	\N
215	현금은	現金は	名詞	\N	\N	\N	168	\N
146	못	できない	副詞	\N	\N	\N	168	\N
216	쓰고	使って	動詞	\N	\N	\N	168	\N
63	이	この	冠形詞	\N	\N	\N	168	\N
217	카드로	カードで	名詞	\N	\N	\N	168	\N
39	다	すべて	副詞	\N	\N	\N	168	\N
218	처리합니다	処理します	動詞	\N	\N	\N	168	\N
217	카드로요	カードでですか	名詞	\N	\N	\N	169	\N
51	어떻게	どう	形容詞	\N	\N	\N	170	\N
216	쓰는데요	使うんですか	動詞	\N	\N	\N	170	\N
34	먼저	まず	副詞	\N	\N	\N	171	\N
219	요리	料理	名詞	\N	\N	\N	171	\N
220	코너에	コーナーに	名詞	\N	\N	\N	171	\N
21	가서	行って	動詞	\N	\N	\N	171	\N
106	먹고 싶은	食べたい	動詞	\N	\N	\N	171	\N
221	고르세요	選んでください	動詞	\N	\N	\N	171	\N
8	저	あの	冠形詞	\N	\N	\N	172	\N
219	요리	料理	名詞	\N	\N	\N	172	\N
220	코너	コーナー	名詞	\N	\N	\N	172	\N
65	말이죠	ことですね	名詞	\N	\N	\N	172	\N
6	네	はい	間投詞	\N	\N	\N	173	\N
222	맞아요	そうです	形容詞	\N	\N	\N	173	\N
127	그	その	冠形詞	\N	\N	\N	174	\N
109	다음엔	次には	名詞	\N	\N	\N	174	\N
223	요리 코너에	料理コーナーに	名詞	\N	\N	\N	174	\N
84	있는	ある	存在詞	\N	\N	\N	174	\N
224	센서에	センサーに	名詞	\N	\N	\N	174	\N
63	이	この	冠形詞	\N	\N	\N	174	\N
217	카드를	カードを	名詞	\N	\N	\N	174	\N
225	대면	当てれば	動詞	\N	\N	\N	174	\N
52	돼요	おしまいです	動詞	\N	\N	\N	174	\N
89	아주	とても	副詞	\N	\N	\N	175	\N
226	편하네요	楽ですね	形容詞	\N	\N	\N	175	\N
166	앞으로	これから	名詞	\N	\N	\N	176	\N
83	많이	たびたび	副詞	\N	\N	\N	176	\N
106	먹으러	食べに	動詞	\N	\N	\N	176	\N
99	올	来る	動詞	\N	\N	\N	176	\N
87	것	~こと	不完全名詞	\N	\N	\N	176	\N
203	같애요	ようですよ	形容詞	\N	\N	\N	176	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	177	\N
14	뭐	何を	代名詞	\N	\N	\N	177	\N
156	해요	しているんですか	動詞	\N	\N	\N	177	\N
55	아	あ	間投詞	\N	\N	\N	178	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	178	\N
33	지금	今	名詞	\N	\N	\N	179	\N
227	일본어	日本語	名詞	\N	\N	\N	179	\N
228	잡지를	雑誌を	名詞	\N	\N	\N	179	\N
79	보고 있었어요	見ていたんです	動詞	\N	\N	\N	179	\N
227	일본어	日本語	名詞	\N	\N	\N	180	\N
156	할	する	動詞	\N	\N	\N	180	\N
229	줄	～すべが	不完全名詞	\N	\N	\N	180	\N
43	알아요	わかるんですか	動詞	\N	\N	\N	180	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	181	\N
12	사실은	実は	副詞	\N	\N	\N	181	\N
27	하나도	全然	数詞	\N	\N	\N	181	\N
176	못해요	できません	動詞	\N	\N	\N	181	\N
230	그냥	ただ	副詞	\N	\N	\N	182	\N
231	사진만	写真だけ	名詞	\N	\N	\N	182	\N
232	보고 있는	見ている	動詞	\N	\N	\N	182	\N
87	거에요	～んですよ	不完全名詞	\N	\N	\N	182	\N
55	아	あ	間投詞	\N	\N	\N	183	\N
19	그렇군요	そうですか	形容詞	\N	\N	\N	183	\N
2	～씨는	～さんは	不完全名詞	\N	\N	\N	184	\N
233	외국어	外国語	名詞	\N	\N	\N	184	\N
36	좀	ちょっと	副詞	\N	\N	\N	184	\N
156	할	する	動詞	\N	\N	\N	184	\N
229	줄	～すべが	不完全名詞	\N	\N	\N	184	\N
43	알아요	わかりますか	動詞	\N	\N	\N	184	\N
234	영어는	英語は	名詞	\N	\N	\N	185	\N
235	조금	少し	副詞	\N	\N	\N	185	\N
156	해요	できます	動詞	\N	\N	\N	185	\N
236	옛날에	昔	名詞	\N	\N	\N	186	\N
237	러시아어도	ロシア語も	名詞	\N	\N	\N	186	\N
238	배웠는데	習ったけれど	動詞	\N	\N	\N	186	\N
39	다	みんな	副詞	\N	\N	\N	186	\N
239	잊어 버렸어요	忘れてしまいました	動詞	\N	\N	\N	186	\N
117	어머	あら	間投詞	\N	\N	\N	187	\N
237	러시아어도	ロシア語も	名詞	\N	\N	\N	187	\N
238	배웠어요	習ったんですか	動詞	\N	\N	\N	187	\N
240	대단하네요	すごいですね	形容詞	\N	\N	\N	188	\N
184	근데	でも	接続詞	\N	\N	\N	189	\N
39	다	全部	副詞	\N	\N	\N	189	\N
239	잊어 버렸어요	忘れたんですよ	動詞	\N	\N	\N	189	\N
8	저는	私は	代名詞	\N	\N	\N	190	\N
83	많이	たくさん	副詞	\N	\N	\N	190	\N
238	배워도	習っても	動詞	\N	\N	\N	190	\N
241	금방	すぐに	副詞	\N	\N	\N	190	\N
239	잊어 버리거든요	忘れてしまうので	動詞	\N	\N	\N	190	\N
41	그럼	じゃあ	接続詞	\N	\N	\N	191	\N
242	한국어도	韓国語も	名詞	\N	\N	\N	191	\N
157	언젠가	いつか	代名詞	\N	\N	\N	191	\N
239	잊어 버리는	忘れちゃう	動詞	\N	\N	\N	191	\N
87	거	~んじゃ	不完全名詞	\N	\N	\N	191	\N
16	아니에요	ないですか	指定詞	\N	\N	\N	191	\N
118	저기요	あのう	間投詞	\N	\N	\N	192	\N
243	사전을	辞書を	名詞	\N	\N	\N	192	\N
244	찾고 있는데요	探しているんですが	動詞	\N	\N	\N	192	\N
6	네	はい	間投詞	\N	\N	\N	193	\N
62	무슨	何の	冠形詞	\N	\N	\N	193	\N
243	사전을	辞書を	名詞	\N	\N	\N	193	\N
244	찾으세요	お探しですか	動詞	\N	\N	\N	193	\N
245	일한사전인데요	日韓辞典なんですけど	名詞	\N	\N	\N	194	\N
246	‘아리랑출판사’에서	「アリラン出版社」から	固有名詞	\N	\N	\N	194	\N
247	새로	新しく	副詞	\N	\N	\N	194	\N
143	나온	出た	動詞	\N	\N	\N	194	\N
87	거	~もの	不完全名詞	\N	\N	\N	194	\N
84	있어요	ありますか	存在詞	\N	\N	\N	194	\N
248	잠시만요	少々お待ちください	副詞	\N	\N	\N	195	\N
249	검색해 볼게요	検索してみましょう	動詞	\N	\N	\N	196	\N
7	예	はい	間投詞	\N	\N	\N	197	\N
84	있습니다	ございます	存在詞	\N	\N	\N	197	\N
20	어디	どこに	代名詞	\N	\N	\N	198	\N
84	있어요	ありますか	存在詞	\N	\N	\N	198	\N
31	여기로	こちらへ	代名詞	\N	\N	\N	199	\N
250	죽	ずっと	副詞	\N	\N	\N	199	\N
21	가시면	行きますと	動詞	\N	\N	\N	199	\N
251	오른쪽에	右側に	名詞	\N	\N	\N	199	\N
243	사전	辞書	名詞	\N	\N	\N	199	\N
220	코너가	コーナーが	名詞	\N	\N	\N	199	\N
84	있거든요	ございます	存在詞	\N	\N	\N	199	\N
252	거기	そこ	代名詞	\N	\N	\N	200	\N
84	있어요	あります	存在詞	\N	\N	\N	200	\N
6	네	はい	間投詞	\N	\N	\N	201	\N
43	알겠습니다	わかりました	動詞	\N	\N	\N	201	\N
55	아	あ	間投詞	\N	\N	\N	202	\N
201	그런데	ところで	接続詞	\N	\N	\N	202	\N
253	화장실은	トイレは	名詞	\N	\N	\N	202	\N
20	어디에요	どこですか	代名詞	\N	\N	\N	202	\N
254	2 	2	数詞	\N	\N	\N	203	\N
255	층으로	階に	名数詞	\N	\N	\N	203	\N
256	올라가세요	お上がりください	動詞	\N	\N	\N	203	\N
257	계단	階段	名詞	\N	\N	\N	204	\N
258	바로	すぐ	副詞	\N	\N	\N	204	\N
259	옆에	横に	名詞	\N	\N	\N	204	\N
84	있어요	ございます	存在詞	\N	\N	\N	204	\N
30	고맙습니다	ありがとうございました	形容詞	\N	\N	\N	205	\N
260	한국 요리는	韓国料理は	名詞	\N	\N	\N	206	\N
44	처음이세요	初めてですか	名詞	\N	\N	\N	206	\N
6	네	ええ	間投詞	\N	\N	\N	207	\N
14	뭘	何を	代名詞	\N	\N	\N	207	\N
221	고르면	選べば	動詞	\N	\N	\N	207	\N
151	좋을지	いいか	形容詞	\N	\N	\N	207	\N
211	모르겠어요	分かりませんね	動詞	\N	\N	\N	207	\N
11	이건	これは	代名詞	\N	\N	\N	208	\N
14	뭐에요	何ですか	代名詞	\N	\N	\N	208	\N
13	그건	それは	代名詞	\N	\N	\N	209	\N
261	된장찌개에요	味噌鍋です	名詞	\N	\N	\N	209	\N
262	맛이	味は	名詞	\N	\N	\N	210	\N
51	어때요	どうですか	形容詞	\N	\N	\N	210	\N
263	일본 사람에겐	日本人には	名詞	\N	\N	\N	211	\N
36	좀	ちょっと	副詞	\N	\N	\N	211	\N
264	짤	しょっぱい	形容詞	\N	\N	\N	211	\N
87	거에요	~と思いますよ	不完全名詞	\N	\N	\N	211	\N
265	그러면	では	接続詞	\N	\N	\N	212	\N
11	이건	これは	代名詞	\N	\N	\N	212	\N
51	어때요	どうですか	形容詞	\N	\N	\N	212	\N
38	맛있게	おいしそうに	存在詞	\N	\N	\N	213	\N
266	보이는데	見えますけど	動詞	\N	\N	\N	213	\N
267	비빔국수요	ビビンククスですか	名詞	\N	\N	\N	214	\N
13	그건	それは	代名詞	\N	\N	\N	215	\N
105	너무	すごく	副詞	\N	\N	\N	215	\N
268	매워요	辛いですよ	形容詞	\N	\N	\N	215	\N
8	저는	私は	代名詞	\N	\N	\N	216	\N
268	매운	辛い	形容詞	\N	\N	\N	216	\N
87	건	~のは	不完全名詞	\N	\N	\N	216	\N
73	괜찮아요	大丈夫です	形容詞	\N	\N	\N	216	\N
230	그냥	じゃあ	副詞	\N	\N	\N	217	\N
11	이걸로	これに	代名詞	\N	\N	\N	217	\N
156	할게요	しますよ	動詞	\N	\N	\N	217	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	218	\N
33	지금	今	名詞	\N	\N	\N	218	\N
269	얘기	話し	名詞	\N	\N	\N	218	\N
36	좀	ちょっと	副詞	\N	\N	\N	218	\N
156	할	する	動詞	\N	\N	\N	218	\N
270	수	すべ	名詞	\N	\N	\N	218	\N
84	있어요	ありますか	存在詞	\N	\N	\N	218	\N
6	네	ええ	間投詞	\N	\N	\N	219	\N
73	괜찮은데	かまわないけど	形容詞	\N	\N	\N	219	\N
61	왜요	どうしたんですか	副詞	\N	\N	\N	219	\N
11	이거	これ	代名詞	\N	\N	\N	220	\N
271	선배	先輩	名詞	\N	\N	\N	220	\N
26	책인데요	本なんですけど	名詞	\N	\N	\N	220	\N
8	제가	私が	代名詞	\N	\N	\N	220	\N
272	커필	コーヒーを	名詞	\N	\N	\N	220	\N
273	엎질러 버렸어요	こぼしちゃったんです	動詞	\N	\N	\N	220	\N
51	어떻게	どう	形容詞	\N	\N	\N	221	\N
156	하죠	しましょうか	動詞	\N	\N	\N	221	\N
274	솔직히	正直に	形容詞	\N	\N	\N	222	\N
275	얘기하는	話す	動詞	\N	\N	\N	222	\N
87	게	~のが	不完全名詞	\N	\N	\N	222	\N
12	낫겠죠	いいですよ	形容詞	\N	\N	\N	222	\N
184	근데	だけど	接続詞	\N	\N	\N	223	\N
105	너무	とても	副詞	\N	\N	\N	223	\N
276	무서운	怖い	形容詞	\N	\N	\N	223	\N
271	선배라서	先輩だから	名詞	\N	\N	\N	223	\N
19	그럴	そんな	形容詞	\N	\N	\N	224	\N
179	땐	ときは	名詞	\N	\N	\N	224	\N
274	솔직하게	正直に	形容詞	\N	\N	\N	224	\N
277	고백하고	告白して	動詞	\N	\N	\N	224	\N
278	사과하는	謝る	動詞	\N	\N	\N	224	\N
87	게	~のが	不完全名詞	\N	\N	\N	224	\N
151	좋아요	いいですよ	形容詞	\N	\N	\N	224	\N
55	아	あ	間投詞	\N	\N	\N	225	\N
139	참	そうだ	間投詞	\N	\N	\N	225	\N
271	선배	先輩	名詞	\N	\N	\N	225	\N
182	술	お酒	名詞	\N	\N	\N	225	\N
168	좋아하죠	好きでしょう	動詞	\N	\N	\N	225	\N
6	네	ええ	間投詞	\N	\N	\N	226	\N
19	그런데요	そうですけど	形容詞	\N	\N	\N	226	\N
8	저한테	私に	代名詞	\N	\N	\N	227	\N
151	좋은	いい	形容詞	\N	\N	\N	227	\N
279	와인이	ワインが	名詞	\N	\N	\N	227	\N
156	한	一	数詞	\N	\N	\N	227	\N
280	병	本	名数詞	\N	\N	\N	227	\N
84	있으니까	ありますから	指定詞	\N	\N	\N	227	\N
13	그걸	それを	代名詞	\N	\N	\N	227	\N
133	같이	いっしょに	副詞	\N	\N	\N	227	\N
281	가져가 보세요	持って行ってください	動詞	\N	\N	\N	227	\N
125	와	ワ	間投詞	\N	\N	\N	228	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	228	\N
94	정말	本当に	副詞	\N	\N	\N	228	\N
30	고마워요	ありがとうございます	形容詞	\N	\N	\N	228	\N
282	사과	りんご	名詞	\N	\N	\N	229	\N
210	더	もっと	副詞	\N	\N	\N	229	\N
29	드세요	召し上がってください	動詞	\N	\N	\N	229	\N
72	아뇨	いえ	間投詞	\N	\N	\N	230	\N
83	많이	たくさん	副詞	\N	\N	\N	230	\N
106	먹었어요	いただきました	動詞	\N	\N	\N	230	\N
61	왜요	どうしてですか	副詞	\N	\N	\N	231	\N
282	사과를	りんごが	名詞	\N	\N	\N	232	\N
96	별로	あまり	副詞	\N	\N	\N	232	\N
150	안	～ではありませんか	副詞	\N	\N	\N	232	\N
168	좋아하세요	好き	動詞	\N	\N	\N	232	\N
7	예	ええ	間投詞	\N	\N	\N	233	\N
8	저	あのう	間投詞	\N	\N	\N	233	\N
12	사실	実は	副詞	\N	\N	\N	233	\N
283	과일을	果物を	名詞	\N	\N	\N	233	\N
96	별로	あまり	副詞	\N	\N	\N	233	\N
150	안	～ない	副詞	\N	\N	\N	233	\N
106	먹는	食べる	動詞	\N	\N	\N	233	\N
284	편이에요	ほうです 	名詞	\N	\N	\N	233	\N
19	그래요	そうですか	形容詞	\N	\N	\N	234	\N
127	귤이나	みかんや	名詞	\N	\N	\N	235	\N
285	바나나도	バナナも	名詞	\N	\N	\N	235	\N
150	안	～ません	副詞	\N	\N	\N	235	\N
106	먹어요	食べる	動詞	\N	\N	\N	235	\N
7	예	ええ	間投詞	\N	\N	\N	236	\N
8	저는	私は	代名詞	\N	\N	\N	236	\N
283	과일보다	果物より	名詞	\N	\N	\N	236	\N
286	야채를	野菜が	名詞	\N	\N	\N	236	\N
210	더	もっと	副詞	\N	\N	\N	236	\N
168	좋아해요	好きです	動詞	\N	\N	\N	236	\N
265	그러면	では	接続詞	\N	\N	\N	237	\N
287	토마토는	トマトは	名詞	\N	\N	\N	237	\N
4	잘	よく	副詞	\N	\N	\N	237	\N
106	먹어요	食べますか	動詞	\N	\N	\N	237	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	238	\N
287	토마토도	トマトも	名詞	\N	\N	\N	239	\N
283	과일이잖아요	果物じゃないですか	名詞	\N	\N	\N	239	\N
16	아니에요	違いますよ	指定詞	\N	\N	\N	240	\N
287	토마토도	トマトも	名詞	\N	\N	\N	241	\N
286	야채에요	野菜です	名詞	\N	\N	\N	241	\N
19	그래요	そうですか	形容詞	\N	\N	\N	242	\N
265	그러면	では	接続詞	\N	\N	\N	243	\N
166	앞으로	これから	名詞	\N	\N	\N	243	\N
83	많이	たくさん	副詞	\N	\N	\N	243	\N
106	먹도록	食べるように	動詞	\N	\N	\N	243	\N
156	해야겠네요	しなければいけませんね	動詞	\N	\N	\N	243	\N
109	다음	次の	名詞	\N	\N	\N	244	\N
288	일요일에	日曜日に	名詞	\N	\N	\N	244	\N
289	스케이트장에	スケート場に	名詞	\N	\N	\N	244	\N
21	가는	行く	動詞	\N	\N	\N	244	\N
87	건	~のは	不完全名詞	\N	\N	\N	244	\N
51	어때요	どうですか	形容詞	\N	\N	\N	244	\N
290	스케이트요	スケートですか	名詞	\N	\N	\N	245	\N
8	저는	私は	代名詞	\N	\N	\N	246	\N
290	스케이트는	スケートは	名詞	\N	\N	\N	246	\N
36	좀	ちょっと	副詞	\N	\N	\N	246	\N
61	왜요	どうしてですか	副詞	\N	\N	\N	247	\N
290	스케이트	スケート	名詞	\N	\N	\N	248	\N
291	싫어해요	嫌いですか	動詞	\N	\N	\N	248	\N
292	구경하는 	見る	動詞	\N	\N	\N	249	\N
87	건	~のは	不完全名詞	\N	\N	\N	249	\N
73	괜찮은데	かまわないけど	形容詞 	\N	\N	\N	249	\N
189	타는	(スケートを)する	動詞	\N	\N	\N	249	\N
96	별로에요	あまり	副詞	\N	\N	\N	249	\N
41	그럼	では	接続詞	\N	\N	\N	250	\N
293	볼링은	ボーリングは	名詞	\N	\N	\N	250	\N
51	어때요	どうですか	形容詞	\N	\N	\N	250	\N
293	볼링도	ボーリングも	名詞	\N	\N	\N	251	\N
36	좀	ちょっと	副詞	\N	\N	\N	251	\N
294	실은	実は	副詞	\N	\N	\N	252	\N
295	제가	私	代名詞	\N	\N	\N	252	\N
296	운동을	スポーツが	名詞	\N	\N	\N	252	\N
291	싫어하거든요	嫌いなんですよ	動詞	\N	\N	\N	252	\N
265	그러면	では	接続詞	\N	\N	\N	253	\N
14	뭘	何を	代名詞	\N	\N	\N	253	\N
156	하는	する	動詞	\N	\N	\N	253	\N
87	걸	~のが	不完全名詞	\N	\N	\N	253	\N
168	좋아해요	好きですか	動詞	\N	\N	\N	253	\N
297	카페에서	カフェで	名詞	\N	\N	\N	254	\N
272	커피	コーヒーを	名詞	\N	\N	\N	254	\N
183	마시면서	飲みながら	動詞	\N	\N	\N	254	\N
26	책	本を	名詞	\N	\N	\N	254	\N
298	읽는	読む	動詞	\N	\N	\N	254	\N
87	걸	~のが	不完全名詞	\N	\N	\N	254	\N
168	좋아해요	好きです	動詞	\N	\N	\N	254	\N
111	우린	私たちは	代名詞	\N	\N	\N	255	\N
299	취미가	趣味が	名詞	\N	\N	\N	255	\N
105	너무	とても	副詞	\N	\N	\N	255	\N
90	다르네요	違いますね	形容詞	\N	\N	\N	255	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	256	\N
69	지하철	地下鉄	名詞	\N	\N	\N	256	\N
300	표는	切符は	名詞	\N	\N	\N	256	\N
51	어떻게	どうやって	形容詞	\N	\N	\N	256	\N
12	사요	買うんですか	動詞	\N	\N	\N	256	\N
301	돈을	お金を	名詞	\N	\N	\N	257	\N
302	아무리	いくら	副詞	\N	\N	\N	257	\N
303	넣어도	入れても	動詞	\N	\N	\N	257	\N
304	다시	また	副詞	\N	\N	\N	257	\N
143	나와요	戻ってきます	動詞	\N	\N	\N	257	\N
69	지하철	地下鉄	名詞	\N	\N	\N	258	\N
300	표를	切符を	名詞	\N	\N	\N	258	\N
12	살	買う	動詞	\N	\N	\N	258	\N
179	때	とき	名詞	\N	\N	\N	258	\N
76	한국은	韓国は	固有名詞	\N	\N	\N	258	\N
86	일본하고	日本と	固有名詞	\N	\N	\N	258	\N
305	반대거든요	反対なんですよ	名詞	\N	\N	\N	258	\N
94	정말요	本当ですか	副詞	\N	\N	\N	259	\N
34	먼저	まず	副詞	\N	\N	\N	260	\N
306	금액	金額	名詞	\N	\N	\N	260	\N
190	버튼을	ボタンを	名詞	\N	\N	\N	260	\N
307	누르고	押して	動詞	\N	\N	\N	260	\N
127	그	その	冠形詞	\N	\N	\N	260	\N
109	다음에	次に	名詞	\N	\N	\N	260	\N
301	돈을	お金を	名詞	\N	\N	\N	260	\N
303	넣는	入れる	動詞	\N	\N	\N	260	\N
87	거에요	~んです	不完全名詞	\N	\N	\N	260	\N
55	아	あ	間投詞	\N	\N	\N	261	\N
19	그렇구나	そうなんだ	形容詞	\N	\N	\N	261	\N
44	처음	初めて	副詞	\N	\N	\N	262	\N
43	알았어요	知りました	動詞	\N	\N	\N	262	\N
30	고마워요	ありがとうございます	形容詞	\N	\N	\N	263	\N
16	아니에요	いいえ	指定詞	\N	\N	\N	264	\N
8	저도	私も	代名詞	\N	\N	\N	265	\N
86	일본에서	日本で	固有名詞	\N	\N	\N	265	\N
44	처음	はじめて	副詞	\N	\N	\N	265	\N
69	지하철	地下鉄	名詞	\N	\N	\N	265	\N
300	표를	切符を	名詞	\N	\N	\N	265	\N
12	살	買う	動詞	\N	\N	\N	265	\N
179	때	とき	名詞	\N	\N	\N	265	\N
105	너무	とても	副詞	\N	\N	\N	265	\N
308	헷갈렸어요	迷いました（こんがらがりました）	動詞	\N	\N	\N	265	\N
309	여보세요	もしもし	間投詞	\N	\N	\N	266	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	267	\N
116	계세요	いらっしゃいますか	存在詞	\N	\N	\N	267	\N
8	전데요	私ですが	代名詞	\N	\N	\N	268	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	269	\N
8	저에요	私です	代名詞	\N	\N	\N	269	\N
246	민희에요	ミニです	固有名詞	\N	\N	\N	270	\N
1	어	オ	間投詞	\N	\N	\N	271	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	271	\N
310	오래간만입니다	久しぶりです	名詞	\N	\N	\N	271	\N
7	예	ええ	間投詞	\N	\N	\N	272	\N
132	진짜	本当に	副詞	\N	\N	\N	272	\N
310	오래간만이네요	久しぶりですよね	名詞	\N	\N	\N	272	\N
127	그	その	冠形詞	\N	\N	\N	273	\N
311	동안	間	名詞	\N	\N	\N	273	\N
51	어떻게	どう	形容詞	\N	\N	\N	273	\N
5	지냈어요	過ごしてたんですか	動詞	\N	\N	\N	273	\N
8	저는	私は	代名詞	\N	\N	\N	274	\N
22	학교	学校	名詞	\N	\N	\N	274	\N
312	공부	勉強	名詞	\N	\N	\N	274	\N
313	때문에	~せいで	不完全名詞	\N	\N	\N	274	\N
314	바쁘게	忙しく	形容詞	\N	\N	\N	274	\N
5	지냈어요	過ごしていました	動詞	\N	\N	\N	274	\N
2	～씨는	～さんは	不完全名詞	\N	\N	\N	275	\N
51	어땠어요	どうでしたか	形容詞	\N	\N	\N	275	\N
4	잘	元気で	副詞	\N	\N	\N	276	\N
5	지냈어요	過ごしましたか	動詞	\N	\N	\N	276	\N
8	저도	私も	代名詞	\N	\N	\N	277	\N
315	시험	試験	名詞	\N	\N	\N	277	\N
313	때문에	~ために	不完全名詞	\N	\N	\N	277	\N
316	정신이 없었어요	てんてこ舞いでした	名詞	\N	\N	\N	277	\N
315	시험은	試験は	名詞	\N	\N	\N	278	\N
157	언제	いつ	代名詞	\N	\N	\N	278	\N
200	끝나요	終わりますか	動詞	\N	\N	\N	278	\N
92	오늘	今日	名詞	\N	\N	\N	279	\N
200	끝났어요	終わりました	動詞	\N	\N	\N	279	\N
19	그래요	そうですか	形容詞	\N	\N	\N	280	\N
265	그러면	では	接続詞	\N	\N	\N	281	\N
310	오래간만에	久しぶりに	名詞	\N	\N	\N	281	\N
317	식사라도	食事でも	名詞	\N	\N	\N	281	\N
133	같이	一緒に	副詞	\N	\N	\N	281	\N
156	할까요	しましょうか	動詞	\N	\N	\N	281	\N
152	내일은	明日	名詞	\N	\N	\N	282	\N
318	아침	朝	名詞	\N	\N	\N	282	\N
319	일곱	7	数詞	\N	\N	\N	282	\N
162	시에	時に	名数詞	\N	\N	\N	282	\N
320	출발할	出発する	動詞	\N	\N	\N	282	\N
87	건데	~のだが	不完全名詞	\N	\N	\N	282	\N
73	괜찮겠어요	大丈夫ですか	形容詞	\N	\N	\N	282	\N
6	네	ええ	間投詞	\N	\N	\N	283	\N
184	근데	でも	接続詞	\N	\N	\N	284	\N
321	만약에	もし	副詞	\N	\N	\N	284	\N
8	제가	私が	代名詞	\N	\N	\N	284	\N
322	늦어지면	遅刻したら	動詞	\N	\N	\N	284	\N
323	어떡하죠	どうしましょう	動詞	\N	\N	\N	284	\N
204	삼십	30	数詞	\N	\N	\N	285	\N
187	분	分	名数詞	\N	\N	\N	285	\N
175	정도라면	ぐらいなら	名詞	\N	\N	\N	285	\N
324	기다릴	待つ	動詞	\N	\N	\N	285	\N
270	수	すべ	名詞	\N	\N	\N	285	\N
84	있어요	あります	存在詞	\N	\N	\N	285	\N
12	사실	実は	副詞	\N	\N	\N	286	\N
8	저는	私は	代名詞	\N	\N	\N	286	\N
318	아침에	朝	名詞	\N	\N	\N	286	\N
4	잘	よく	副詞	\N	\N	\N	286	\N
146	못	できない	副詞	\N	\N	\N	286	\N
325	일어나거든요	起きるんですよ	動詞	\N	\N	\N	286	\N
92	오늘	今日	名詞	\N	\N	\N	287	\N
107	밤에	夜	名詞	\N	\N	\N	287	\N
196	빨리	早く	副詞	\N	\N	\N	287	\N
326	자면	寝たら	動詞	\N	\N	\N	287	\N
52	되죠	いいでしょう	動詞	\N	\N	\N	287	\N
19	그래도	でも	形容詞	\N	\N	\N	288	\N
326	자신이	自信が	名詞	\N	\N	\N	288	\N
98	없어요	ありません	存在詞	\N	\N	\N	288	\N
321	만약에	もし	副詞	\N	\N	\N	289	\N
105	너무	とても	副詞	\N	\N	\N	289	\N
322	늦어지면	遅くなったら	動詞	\N	\N	\N	289	\N
51	어떻게	どう	形容詞	\N	\N	\N	289	\N
156	하죠	しましょうか	動詞	\N	\N	\N	289	\N
19	그렇게	そう	形容詞	\N	\N	\N	290	\N
52	되면	なったら	動詞	\N	\N	\N	290	\N
8	저한테	私に	代名詞	\N	\N	\N	290	\N
110	꼭	必ず	副詞	\N	\N	\N	290	\N
327	전화하세요	電話して下さい	動詞	\N	\N	\N	290	\N
105	너무	あまり	副詞	\N	\N	\N	291	\N
322	늦어지면	遅くなったら	動詞	\N	\N	\N	291	\N
34	먼저	先に	副詞	\N	\N	\N	291	\N
320	출발할지도	出発するかも	動詞	\N	\N	\N	291	\N
211	몰라요	知れません	動詞	\N	\N	\N	291	\N
328	서울에서	ソウルで	固有名詞	\N	\N	\N	292	\N
329	제일	一番	副詞	\N	\N	\N	292	\N
330	큰	大きな	形容詞	\N	\N	\N	292	\N
331	서점이	本屋は	名詞	\N	\N	\N	292	\N
20	어디에요	どこですか	代名詞	\N	\N	\N	292	\N
246	교보문고에요	教保文庫です	固有名詞	\N	\N	\N	293	\N
83	많이	たくさん	副詞	\N	\N	\N	294	\N
37	주문하면	注文すれば	動詞	\N	\N	\N	294	\N
332	무료로	無料で	名詞	\N	\N	\N	294	\N
333	배달도	配達も	名詞	\N	\N	\N	294	\N
156	해 주나요	してくれますか	動詞	\N	\N	\N	294	\N
334	글쎄요	そうですね	間投詞	\N	\N	\N	295	\N
230	그냥	普通の	副詞	\N	\N	\N	296	\N
331	서점보다	本屋より	名詞	\N	\N	\N	296	\N
335	인터넷서점에서	インターネット書店で	名詞	\N	\N	\N	296	\N
12	사는	買う	動詞	\N	\N	\N	296	\N
87	게	~のが	不完全名詞	\N	\N	\N	296	\N
210	더	もっと	副詞	\N	\N	\N	296	\N
151	좋을	いい	形容詞	\N	\N	\N	296	\N
203	같은데	ようですけど	形容詞	\N	\N	\N	296	\N
335	인터넷서점은	インターネット書店は	名詞	\N	\N	\N	297	\N
20	어디가	どこが	代名詞	\N	\N	\N	297	\N
329	제일	一番	副詞	\N	\N	\N	297	\N
336	유명한데요	有名ですか	形容詞	\N	\N	\N	297	\N
246	‘알라딘’이라는	「アラジン」という	固有名詞	\N	\N	\N	298	\N
337	사이트가	サイトが	名詞	\N	\N	\N	298	\N
338	가장	最も	副詞	\N	\N	\N	298	\N
336	유명한데	有名ですが	形容詞	\N	\N	\N	298	\N
8	저는	私は	代名詞	\N	\N	\N	298	\N
339	주로	主に	副詞	\N	\N	\N	298	\N
214	이용하고 있어요	利用しています	動詞	\N	\N	\N	298	\N
55	아	ああ	間投詞	\N	\N	\N	299	\N
19	그래요	そうですか	形容詞	\N	\N	\N	299	\N
41	그럼	では	接続詞	\N	\N	\N	300	\N
8	저도	私も	代名詞	\N	\N	\N	300	\N
27	한	一	数詞	\N	\N	\N	300	\N
174	번	度	名数詞	\N	\N	\N	300	\N
246	‘아마존’을	「アマゾン」を	固有名詞	\N	\N	\N	300	\N
249	검색해 볼게요	検索してみます	動詞	\N	\N	\N	300	\N
107	배가	おなかが	名詞	\N	\N	\N	301	\N
340	고픈데요	すきました	形容詞	\N	\N	\N	301	\N
55	아	あ	間投詞	\N	\N	\N	302	\N
341	벌써	もう	副詞	\N	\N	\N	302	\N
342	점심	昼食	名詞	\N	\N	\N	302	\N
145	시간이에요	時間ですか	名詞	\N	\N	\N	302	\N
133	같이	一緒に	副詞	\N	\N	\N	303	\N
343	식사할까요	食事しましょうか	動詞	\N	\N	\N	303	\N
7	예	ええ	間投詞	\N	\N	\N	304	\N
344	그럽시다	そうしましょう	動詞	\N	\N	\N	304	\N
14	뭘	何を	代名詞	\N	\N	\N	305	\N
106	먹을까요	食べましょうか	動詞	\N	\N	\N	305	\N
345	칼국수	手打ちうどん	名詞	\N	\N	\N	306	\N
51	어때요	どうですか	形容詞	\N	\N	\N	306	\N
7	예	ええ	間投詞	\N	\N	\N	307	\N
151	좋아요	いいですね	形容詞	\N	\N	\N	307	\N
8	전	私は	代名詞	\N	\N	\N	308	\N
345	칼국수	手打ちうどん	名詞	\N	\N	\N	308	\N
105	너무	とても	副詞	\N	\N	\N	308	\N
168	좋아해요	好きです	動詞	\N	\N	\N	308	\N
41	그럼	では	接続詞	\N	\N	\N	309	\N
147	내가	僕が	代名詞	\N	\N	\N	309	\N
43	아는	知っている	動詞	\N	\N	\N	309	\N
346	식당으로	食堂に	名詞	\N	\N	\N	309	\N
21	갑시다	行きましょう	動詞	\N	\N	\N	309	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	310	\N
9	어제	昨日	名詞	\N	\N	\N	310	\N
61	왜	どうして	副詞	\N	\N	\N	310	\N
347	결석했어요	欠席したんですか	動詞	\N	\N	\N	310	\N
348	감기	風邪	名詞	\N	\N	\N	311	\N
313	때문에	~せいで	不完全名詞	\N	\N	\N	311	\N
146	못	できない	副詞	\N	\N	\N	311	\N
99	왔어요	来たんです	動詞	\N	\N	\N	311	\N
117	어머	まあ	間投詞	\N	\N	\N	312	\N
19	그래요	そうですか	形容詞	\N	\N	\N	312	\N
92	오늘은	今日は	名詞	\N	\N	\N	313	\N
73	괜찮아요	大丈夫ですか	形容詞	\N	\N	\N	313	\N
349	약을	薬を	名詞	\N	\N	\N	314	\N
106	먹었더니	飲んだら	動詞	\N	\N	\N	314	\N
241	금방	すぐ	副詞	\N	\N	\N	314	\N
12	나았어요	治りました	動詞	\N	\N	\N	314	\N
350	다행이네요	よかったですね	名詞	\N	\N	\N	315	\N
6	네	ええ	間投詞	\N	\N	\N	316	\N
351	걱정해 줘서	心配してくれて	動詞	\N	\N	\N	316	\N
30	고마워요	ありがとうございます	形容詞	\N	\N	\N	316	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	317	\N
352	부탁이	お願いが	名詞	\N	\N	\N	317	\N
27	하나	一つ	数詞	\N	\N	\N	317	\N
84	있는데요	あるんですが	存在詞	\N	\N	\N	317	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	318	\N
352	부탁이라면	頼みなら	名詞	\N	\N	\N	318	\N
14	뭐든지	なんでも	代名詞	\N	\N	\N	318	\N
73	괜찮아요	いいですよ	形容詞	\N	\N	\N	318	\N
14	뭔데요	何ですか	代名詞	\N	\N	\N	319	\N
342	점심	お昼	名詞	\N	\N	\N	320	\N
179	때	とき	名詞	\N	\N	\N	320	\N
145	시간	時間	名詞	\N	\N	\N	320	\N
84	있어요	ありますか	存在詞	\N	\N	\N	320	\N
353	물론	もちろん	副詞	\N	\N	\N	321	\N
84	있죠	ありますよ	存在詞	\N	\N	\N	321	\N
354	‘밀크’라는	「ミルク」という	固有名詞	\N	\N	\N	322	\N
297	카페	カフェ	名詞	\N	\N	\N	322	\N
43	알아요	知ってますか	動詞	\N	\N	\N	322	\N
353	물론	もちろん	副詞	\N	\N	\N	323	\N
127	그	その	代名詞	\N	\N	\N	379	\N
43	알죠	知ってますよ	動詞	\N	\N	\N	323	\N
252	거기	そこに	代名詞	\N	\N	\N	324	\N
21	가서	行って	動詞	\N	\N	\N	324	\N
272	커피하고	コーヒーと	名詞	\N	\N	\N	324	\N
355	케이크	ケーキ	名詞	\N	\N	\N	324	\N
27	하나만	一つほど	数詞	\N	\N	\N	324	\N
12	사다	買って来て	動詞	\N	\N	\N	324	\N
28	줄래요	くれますか	動詞	\N	\N	\N	324	\N
2	～씨도	～さんも	不完全名詞	\N	\N	\N	325	\N
139	참	まったく	間投詞	\N	\N	\N	325	\N
230	그냥	ただ	副詞	\N	\N	\N	326	\N
133	같이	いっしょに	副詞	\N	\N	\N	326	\N
21	가면	行ったら	動詞	\N	\N	\N	326	\N
356	안돼요	いいじゃないですか	動詞	\N	\N	\N	326	\N
71	미안해요	ごめんなさい	形容詞	\N	\N	\N	327	\N
8	제가	私	代名詞	\N	\N	\N	328	\N
357	숙제를	宿題を	名詞	\N	\N	\N	328	\N
156	해야 되기	しなくちゃいけない	動詞	\N	\N	\N	328	\N
313	때문에	~から	不完全名詞	\N	\N	\N	328	\N
358	밖에	外に	名詞	\N	\N	\N	328	\N
359	나갈	出る	動詞	\N	\N	\N	328	\N
145	시간이	時間が	名詞	\N	\N	\N	328	\N
98	없거든요	ないんですよ	存在詞	\N	\N	\N	328	\N
43	알았어요	わかりましたよ	動詞	\N	\N	\N	329	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	330	\N
352	부탁이니까	頼みだから	名詞	\N	\N	\N	330	\N
156	할	する	動詞	\N	\N	\N	330	\N
270	수	すべ	名詞	\N	\N	\N	330	\N
98	없죠	ないですよ	存在詞	\N	\N	\N	330	\N
58	뭐	もう	間投詞	\N	\N	\N	330	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	331	\N
360	생일	誕生日	名詞	\N	\N	\N	331	\N
179	때	とき	名詞	\N	\N	\N	331	\N
14	뭘	何を	代名詞	\N	\N	\N	331	\N
28	주면	あげたら	動詞	\N	\N	\N	331	\N
151	좋을지	いいか	形容詞	\N	\N	\N	331	\N
211	모르겠어요	わからないんです	動詞	\N	\N	\N	331	\N
86	일본에서는	日本では	固有名詞	\N	\N	\N	332	\N
361	보통	普通	副詞	\N	\N	\N	332	\N
51	어떤	どんな	形容詞	\N	\N	\N	332	\N
362	선물을	贈り物を	名詞	\N	\N	\N	332	\N
156	해요	するんですか	動詞	\N	\N	\N	332	\N
334	글쎄요	そうですね.	間投詞	\N	\N	\N	333	\N
363	그렇게	そんなに	副詞	\N	\N	\N	334	\N
364	비싸지 않은	高くない	形容詞	\N	\N	\N	334	\N
87	걸로	~ものに	不完全名詞	\N	\N	\N	334	\N
156	하는데요	しますけどね	動詞	\N	\N	\N	334	\N
7	예를	例を	名詞	\N	\N	\N	335	\N
29	들면	あげれば	動詞	\N	\N	\N	335	\N
51	어떤	どんな	形容詞	\N	\N	\N	335	\N
87	거요	~ものですか	不完全名詞	\N	\N	\N	335	\N
365	머그컵이라든가	マグカップだとか	名詞	\N	\N	\N	336	\N
295	펜	ペン	名詞	\N	\N	\N	336	\N
203	같은	ような	形容詞	\N	\N	\N	336	\N
87	거요	~ものです	不完全名詞	\N	\N	\N	336	\N
76	한국에서는	韓国では	固有名詞	\N	\N	\N	337	\N
366	오히려	かえって	副詞	\N	\N	\N	337	\N
364	비싼	高い	形容詞	\N	\N	\N	337	\N
120	물건을	ものを	名詞	\N	\N	\N	337	\N
28	주는	あげる	動詞	\N	\N	\N	337	\N
367	경우가	場合が	動詞	\N	\N	\N	337	\N
25	많아요	多いですよ	形容詞	\N	\N	\N	337	\N
19	그래요	そうですか	形容詞	\N	\N	\N	338	\N
7	예를	例を	名詞	\N	\N	\N	339	\N
29	들어서	あげて	動詞	\N	\N	\N	339	\N
121	옷이나	服とか	名詞	\N	\N	\N	339	\N
368	향수나	香水とか	名詞	\N	\N	\N	339	\N
16	아니면	あるいは	指定詞	\N	\N	\N	339	\N
369	반지를	指輪を	名詞	\N	\N	\N	339	\N
28	주는	あげる	動詞	\N	\N	\N	339	\N
138	사람도	人も	名詞	\N	\N	\N	339	\N
84	있어요	います	存在詞	\N	\N	\N	339	\N
370	선생님	先生	名詞	\N	\N	\N	340	\N
63	이	この	冠形詞	\N	\N	\N	340	\N
371	보고서	報告書	名詞	\N	\N	\N	340	\N
65	말인데요	ことなんですが	名詞	\N	\N	\N	340	\N
372	마감이	締め切りが	名詞	\N	\N	\N	340	\N
152	내일까지죠	明日までですよね	名詞	\N	\N	\N	340	\N
6	네	ええ	形容詞	\N	\N	\N	341	\N
19	그런데요	そうですけど	形容詞	\N	\N	\N	341	\N
373	다음 주까지	来週まで	名詞	\N	\N	\N	342	\N
374	연장할	延ばす	動詞	\N	\N	\N	342	\N
270	수는	~ことは	不完全名詞	\N	\N	\N	342	\N
98	없을까요	できないでしょうか	存在詞	\N	\N	\N	342	\N
373	다음 주까지요	来週までですか	名詞	\N	\N	\N	343	\N
36	좀	ちょっと	副詞	\N	\N	\N	344	\N
375	곤란한데	困るんだけど	形容詞	\N	\N	\N	344	\N
376	수업도	授業も	名詞	\N	\N	\N	345	\N
25	많고	多いし	形容詞	\N	\N	\N	345	\N
105	너무	すごく	副詞	\N	\N	\N	345	\N
314	바빠서	忙しくて	形容詞	\N	\N	\N	345	\N
152	내일까지는	明日までは	名詞	\N	\N	\N	345	\N
377	도저히	到底	副詞	\N	\N	\N	345	\N
378	무리에요	無理ですよ	名詞	\N	\N	\N	345	\N
371	보고서는	報告書は	名詞	\N	\N	\N	346	\N
379	어느	どの	冠形詞	\N	\N	\N	346	\N
175	정도	ぐらい	名詞	\N	\N	\N	346	\N
380	완성됐는데요	出来たんですか	動詞	\N	\N	\N	346	\N
381	칠십	70	数詞	\N	\N	\N	347	\N
382	프로	パーセント	名数詞	\N	\N	\N	347	\N
175	정도에요	ぐらいです	名詞	\N	\N	\N	347	\N
265	그러면	では	接続詞	\N	\N	\N	348	\N
383	일단	いったん	副詞	\N	\N	\N	348	\N
384	마무리	まとめ	名詞	\N	\N	\N	348	\N
385	부분을	部分を	名詞	\N	\N	\N	348	\N
216	쓰고	書いて	動詞	\N	\N	\N	348	\N
386	모레까지	あさってまでに	名詞	\N	\N	\N	348	\N
387	제출하세요	提出してください	動詞	\N	\N	\N	348	\N
19	그렇게	そう	形容詞	\N	\N	\N	349	\N
156	해도	しても	動詞	\N	\N	\N	349	\N
52	돼요	いいですか	動詞	\N	\N	\N	349	\N
6	네	ええ	間投詞	\N	\N	\N	350	\N
12	남은	残った	動詞	\N	\N	\N	350	\N
385	부분은	部分は	名詞	\N	\N	\N	350	\N
373	다음 주에	来週	名詞	\N	\N	\N	350	\N
387	제출해도	提出しても	動詞	\N	\N	\N	350	\N
52	돼요	いいですよ	動詞	\N	\N	\N	350	\N
11	이거	これ	代名詞	\N	\N	\N	351	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	351	\N
388	앨범이에요	アルバムですか	名詞	\N	\N	\N	351	\N
6	네	ええ	間投詞	\N	\N	\N	352	\N
19	그래요	そうです	形容詞	\N	\N	\N	352	\N
8	제가	私が	代名詞	\N	\N	\N	353	\N
36	좀	ちょっと	副詞	\N	\N	\N	353	\N
79	봐도	見ても	動詞	\N	\N	\N	353	\N
52	돼요	いいですか	動詞	\N	\N	\N	353	\N
41	그럼요	もちろんですよ	間投詞	\N	\N	\N	354	\N
117	어머	まあ	間投詞	\N	\N	\N	355	\N
389	귀엽다	かわいい	形容詞	\N	\N	\N	356	\N
161	몇	何	数詞	\N	\N	\N	357	\N
54	살	歳	名数詞	\N	\N	\N	357	\N
179	때	とき	名詞	\N	\N	\N	357	\N
231	사진이에요	写真ですか	名詞	\N	\N	\N	357	\N
390	다섯	五	数詞	\N	\N	\N	358	\N
54	살	歳	名数詞	\N	\N	\N	358	\N
179	때	とき	名詞	\N	\N	\N	358	\N
391	찍은	撮った	動詞	\N	\N	\N	358	\N
231	사진이에요	写真です	名詞	\N	\N	\N	358	\N
117	어머머	あらあら	間投詞	\N	\N	\N	359	\N
11	이거	これ	代名詞	\N	\N	\N	360	\N
392	여자 친구	ガールフレンド	名詞	\N	\N	\N	360	\N
231	사진	写真	名詞	\N	\N	\N	360	\N
16	아니에요	ありませんか	指定詞	\N	\N	\N	360	\N
393	이름	名前	名詞	\N	\N	\N	361	\N
394	물어 봐도	聞いても	動詞	\N	\N	\N	361	\N
52	돼요	いいですか	動詞	\N	\N	\N	361	\N
13	그건	それは	代名詞	\N	\N	\N	362	\N
392	여자 친구가	ガールフレンドじゃ	名詞	\N	\N	\N	362	\N
16	아니구요	なくて	指定詞	\N	\N	\N	362	\N
8	제	私の	代名詞	\N	\N	\N	362	\N
395	누나	姉	名詞	\N	\N	\N	362	\N
231	사진이에요	写真です	名詞	\N	\N	\N	362	\N
63	이	この	冠形詞	\N	\N	\N	363	\N
346	식당은	食堂は	名詞	\N	\N	\N	363	\N
44	처음이에요	初めてですか	名詞	\N	\N	\N	363	\N
6	네	ええ	間投詞	\N	\N	\N	364	\N
31	여긴	ここは	代名詞	\N	\N	\N	365	\N
396	셀프 서비스에요	セルフサービスですよ	名詞	\N	\N	\N	365	\N
41	그럼	では	接続詞	\N	\N	\N	366	\N
219	요리를	料理を	名詞	\N	\N	\N	366	\N
397	직접	直接	副詞	\N	\N	\N	366	\N
398	자기	自分の	名詞	\N	\N	\N	366	\N
399	자리로	席に	名詞	\N	\N	\N	366	\N
281	가져	持って	動詞	\N	\N	\N	366	\N
21	가야 돼요	行かなくてはいけませんか	動詞	\N	\N	\N	366	\N
6	네	ええ	間投詞	\N	\N	\N	367	\N
19	그래요	そうです	形容詞	\N	\N	\N	367	\N
41	그럼	じゃ	接続詞	\N	\N	\N	368	\N
106	먹고 나서도	食べてからも	動詞	\N	\N	\N	368	\N
397	직접	直接	直接	\N	\N	\N	368	\N
400	그릇을	食器を	名詞	\N	\N	\N	368	\N
401	카운터에	カウンターに	名詞	\N	\N	\N	368	\N
160	반납해야 되는	返さなければいけない	動詞	\N	\N	\N	368	\N
87	거에요	~んですか	不完全名詞	\N	\N	\N	368	\N
6	네	ええ	間投詞	\N	\N	\N	369	\N
19	그렇죠	そうですよ	形容詞	\N	\N	\N	369	\N
36	좀	ちょっと	副詞	\N	\N	\N	370	\N
402	귀찮겠네요	面倒くさいですね	形容詞	\N	\N	\N	370	\N
74	그래도	でも	接続詞	\N	\N	\N	371	\N
90	다른	他の	形容詞	\N	\N	\N	371	\N
403	가게보다	お店より	名詞	\N	\N	\N	371	\N
404	훨씬	ずっと	副詞	\N	\N	\N	371	\N
75	싸요	安いですよ	形容詞	\N	\N	\N	371	\N
76	한국에서	韓国で	名詞	\N	\N	\N	372	\N
405	박물관에	博物館に	名詞	\N	\N	\N	372	\N
99	온	来た	動詞	\N	\N	\N	372	\N
87	건	~のは	不完全名詞	\N	\N	\N	372	\N
44	처음이에요	初めてです	名詞	\N	\N	\N	372	\N
19	그래요	そうですか	形容詞	\N	\N	\N	373	\N
31	여기엔	ここには	代名詞	\N	\N	\N	374	\N
76	한국	韓国	名詞	\N	\N	\N	374	\N
406	역사에	歴史に	名詞	\N	\N	\N	374	\N
407	관한	関する	後置詞	\N	\N	\N	374	\N
87	게	~ものが	不完全名詞	\N	\N	\N	374	\N
25	많아요	多いんです	形容詞	\N	\N	\N	374	\N
6	네	ええ	間投詞	\N	\N	\N	375	\N
139	참	本当に	副詞	\N	\N	\N	375	\N
408	신기한	珍しい	形容詞	\N	\N	\N	375	\N
87	게	~ものが	不完全名詞	\N	\N	\N	375	\N
25	많네요	多いですね	形容詞	\N	\N	\N	375	\N
11	이거	これ	代名詞	\N	\N	\N	376	\N
409	만져봐도	触ってみても	動詞	\N	\N	\N	376	\N
52	돼요	いいですか	動詞	\N	\N	\N	376	\N
55	아	あ	間投詞	\N	\N	\N	377	\N
409	만지지 마세요	触らないでください	動詞	\N	\N	\N	377	\N
6	네	えっ	間投詞	\N	\N	\N	378	\N
410	"손으로	｢手で	名詞	\N	\N	\N	379	\N
409	만지지 마세요"라고	触らないでください｣と	動詞	\N	\N	\N	379	\N
166	앞에	前に	名詞	\N	\N	\N	379	\N
411	적혀 있잖아요	書いてあるじゃないですか	動詞	\N	\N	\N	379	\N
1	어	あ	間投詞	\N	\N	\N	380	\N
94	정말요	本当ですか	副詞	\N	\N	\N	380	\N
71	미안해요	すみません	形容詞	\N	\N	\N	381	\N
146	못	できない	副詞	\N	\N	\N	382	\N
79	봤어요	見ました	動詞	\N	\N	\N	382	\N
41	그럼	では	接続詞	\N	\N	\N	383	\N
231	사진은	写真は	名詞	\N	\N	\N	383	\N
391	찍어도	撮っても	動詞	\N	\N	\N	383	\N
52	돼요	いいですか	動詞	\N	\N	\N	383	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	384	\N
231	사진도	写真も	名詞	\N	\N	\N	384	\N
391	찍으면 	撮っては	動詞	\N	\N	\N	384	\N
356	안돼요	いけません	動詞	\N	\N	\N	384	\N
117	어머	あら	間投詞	\N	\N	\N	385	\N
19	그래요	そうですか	形容詞	\N	\N	\N	385	\N
412	유감이네요	残念ですね	名詞	\N	\N	\N	386	\N
63	이	この	冠形詞	\N	\N	\N	387	\N
413	컴퓨터	コンピューター	名詞	\N	\N	\N	387	\N
20	어디에	どこに	代名詞	\N	\N	\N	387	\N
414	둘까	置こうか	動詞	\N	\N	\N	387	\N
55	아	あ	間投詞	\N	\N	\N	388	\N
271	선배	先輩	名詞	\N	\N	\N	388	\N
13	그건	それは	代名詞	\N	\N	\N	388	\N
415	책상	机	名詞	\N	\N	\N	388	\N
416	위에	上に	名詞	\N	\N	\N	388	\N
417	놔 주세요	置いて下さい	動詞	\N	\N	\N	388	\N
41	그럼	じゃ	接続詞	\N	\N	\N	389	\N
63	이	この	冠形詞	\N	\N	\N	389	\N
418	옷장은	たんすは	名詞	\N	\N	\N	389	\N
334	글쎄요	そうですね	間投詞	\N	\N	\N	390	\N
20	어디에	どこに	代名詞	\N	\N	\N	390	\N
417	놓으면	置けば	動詞	\N	\N	\N	390	\N
151	좋을까	いいかなあ	形容詞	\N	\N	\N	390	\N
419	우선	とりあえず	副詞	\N	\N	\N	391	\N
420	침대	ベッド	名詞	\N	\N	\N	391	\N
259	옆에	横に	名詞	\N	\N	\N	391	\N
417	놔 주시겠어요	置いてもらえますか	動詞	\N	\N	\N	391	\N
420	침대	ベッド	名詞	\N	\N	\N	392	\N
251	오른쪽	右	名詞	\N	\N	\N	392	\N
421	왼쪽	左	名詞	\N	\N	\N	392	\N
422	음	うーん	間投詞	\N	\N	\N	393	\N
421	왼쪽에	左に	名詞	\N	\N	\N	393	\N
36	좀	ちょっと	副詞	\N	\N	\N	393	\N
417	놔 주세요	置いてください	動詞	\N	\N	\N	393	\N
43	알았어	わかった	動詞	\N	\N	\N	394	\N
63	이	この	冠形詞	\N	\N	\N	395	\N
26	책들은	本は	名詞	\N	\N	\N	395	\N
415	책상	机	名詞	\N	\N	\N	395	\N
416	위에	上に	名詞	\N	\N	\N	395	\N
423	두면	置けば	動詞	\N	\N	\N	395	\N
424	 돼	いい	動詞	\N	\N	\N	395	\N
72	아뇨	いえ	間投詞	\N	\N	\N	396	\N
8	저	あの	冠形詞	\N	\N	\N	396	\N
425	책장에	本棚に	名詞	\N	\N	\N	396	\N
36	좀	ちょっと	副詞	\N	\N	\N	396	\N
426	꽂아 주세요	入れてください	動詞	\N	\N	\N	396	\N
415	책상	机	名詞	\N	\N	\N	397	\N
416	위엔	上には	名詞	\N	\N	\N	397	\N
427	프린터를	プリンタを	名詞	\N	\N	\N	397	\N
417	놓을	置く	動詞	\N	\N	\N	397	\N
87	거거든요	~つもりなんですよ	不完全名詞	\N	\N	\N	397	\N
6	네	はい	間投詞	\N	\N	\N	398	\N
43	알겠습니다	わかりました	動詞	\N	\N	\N	398	\N
271	선배	先輩	名詞	\N	\N	\N	399	\N
94	정말	本当に	副詞	\N	\N	\N	399	\N
30	고마워요	ありがとうございます	形容詞	\N	\N	\N	399	\N
92	오늘	今日	名詞	\N	\N	\N	400	\N
147	내가	私が	代名詞	\N	\N	\N	400	\N
428	한턱 낼게요	おごりますから	名詞	\N	\N	\N	400	\N
357	숙제	宿題	名詞	\N	\N	\N	401	\N
39	다	全部	副詞	\N	\N	\N	401	\N
200	끝났어요	終わりましたか	動詞	\N	\N	\N	401	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	402	\N
103	아직	まだ	副詞	\N	\N	\N	403	\N
429	멀었어요	及びませんでした	形容詞	\N	\N	\N	403	\N
379	어느	どの	冠形詞	\N	\N	\N	404	\N
175	정도	くらい	名詞	\N	\N	\N	404	\N
12	남았어요	残りましたか	動詞	\N	\N	\N	404	\N
430	이제	もう	副詞	\N	\N	\N	405	\N
27	한	1	数詞	\N	\N	\N	405	\N
431	페이지만	ページだけ	名数詞	\N	\N	\N	405	\N
156	하면	やれば	動詞	\N	\N	\N	405	\N
52	되는데	いいんですが	動詞	\N	\N	\N	405	\N
432	마지막	最後	名詞	\N	\N	\N	405	\N
433	문제가	問題が	名詞	\N	\N	\N	405	\N
105	너무	とても	副詞	\N	\N	\N	405	\N
434	어려워요	難しいです	形容詞	\N	\N	\N	405	\N
435	곧	もうすぐ	副詞	\N	\N	\N	406	\N
376	수업이니까	授業ですから	名詞	\N	\N	\N	406	\N
196	빨리	早く	副詞	\N	\N	\N	406	\N
156	하세요	やって下さい	動詞	\N	\N	\N	406	\N
8	저	私	代名詞	\N	\N	\N	407	\N
324	기다리지 마세요	待たないで下さい	動詞	\N	\N	\N	407	\N
145	시간이	時間が	名詞	\N	\N	\N	408	\N
36	좀	ちょっと	副詞	\N	\N	\N	408	\N
436	걸릴	かかる	動詞	\N	\N	\N	408	\N
87	것	~こと	不完全名詞	\N	\N	\N	408	\N
203	같으니까	ようですから	形容詞	\N	\N	\N	408	\N
324	기다릴	待ってる	動詞	\N	\N	\N	409	\N
6	테니까	~から	不完全名詞	\N	\N	\N	409	\N
133	같이	一緒に	副詞	\N	\N	\N	409	\N
21	가요	行こうよ	動詞	\N	\N	\N	409	\N
19	그래요	そうですか	形容詞	\N	\N	\N	410	\N
30	고마워요	ありがとう	形容詞	\N	\N	\N	411	\N
373	다음 주	来週	名詞	\N	\N	\N	412	\N
437	모임	集まり	名詞	\N	\N	\N	412	\N
65	말인데요	ことなんですが	名詞	\N	\N	\N	412	\N
438	회원들에게	会員に	名詞	\N	\N	\N	412	\N
439	편지로	手紙で	名詞	\N	\N	\N	412	\N
440	알려 주면	お知らせしたら	動詞	\N	\N	\N	412	\N
52	될까요	いいでしょうか	動詞	\N	\N	\N	412	\N
72	아뇨	いえ	間投詞	\N	\N	\N	413	\N
441	이메일로	eメールで	名詞	\N	\N	\N	413	\N
442	보내세요	送って下さい	動詞	\N	\N	\N	413	\N
184	근데	でも	接続詞	\N	\N	\N	414	\N
441	이메일을	eメールを	名詞	\N	\N	\N	414	\N
150	안	ない	副詞	\N	\N	\N	414	\N
79	보는	見る	動詞	\N	\N	\N	414	\N
438	회원도	会員も	名詞	\N	\N	\N	414	\N
84	있는데요	いるんですが	存在詞	\N	\N	\N	414	\N
61	왜요	なぜですか	副詞	\N	\N	\N	415	\N
105	너무	とても	副詞	\N	\N	\N	416	\N
314	바빠서요	忙しすぎるからですかね	形容詞	\N	\N	\N	416	\N
72	아뇨	いいえ	間投詞	\N	\N	\N	417	\N
443	아예	初めから	副詞	\N	\N	\N	417	\N
441	이메일을	eメールを	名詞	\N	\N	\N	417	\N
214	이용하지도 않는	利用もしない	動詞	\N	\N	\N	417	\N
87	것	~こと	不完全名詞	\N	\N	\N	417	\N
203	같애요	ようですよ	形容詞	\N	\N	\N	417	\N
41	그럼	そうなると	接続詞	\N	\N	\N	418	\N
36	좀	ちょっと	副詞	\N	\N	\N	418	\N
433	문제네요	問題ですね	名詞	\N	\N	\N	418	\N
444	역시	やはり	副詞	\N	\N	\N	419	\N
439	편지로	手紙で	名詞	\N	\N	\N	419	\N
445	연락하는	連絡する	動詞	\N	\N	\N	419	\N
87	게	~のが	不完全名詞	\N	\N	\N	419	\N
151	좋을까요	いいでしょうか	形容詞	\N	\N	\N	419	\N
334	글쎄요	そうですね	間投詞	\N	\N	\N	420	\N
41	그럼	では	接続詞	\N	\N	\N	421	\N
127	그	その	冠形詞	\N	\N	\N	421	\N
439	편지에	手紙に	名詞	\N	\N	\N	421	\N
109	다음부터는	次からは	名詞	\N	\N	\N	421	\N
441	이메일로	eメールで	名詞	\N	\N	\N	421	\N
445	연락하겠다고	連絡すると	動詞	\N	\N	\N	421	\N
216	쓰면	書いたら	動詞	\N	\N	\N	421	\N
51	어때요	どうですか	形容詞	\N	\N	\N	421	\N
309	여보세요	もしもし	間投詞	\N	\N	\N	422	\N
309	여보세요	もしもし	間投詞	\N	\N	\N	423	\N
3	안녕하세요	こんにちは	形容詞	\N	\N	\N	424	\N
8	저	私	名詞	\N	\N	\N	425	\N
55	아	あ	間投詞	\N	\N	\N	426	\N
3	안녕하세요 	こんにちは	形容詞	\N	\N	\N	426	\N
181	오랜만이네요	久しぶりですね	名詞	\N	\N	\N	427	\N
6	네	ええ	間投詞	\N	\N	\N	428	\N
19	그렇네요	そうですね	形容詞	\N	\N	\N	428	\N
184	근데	ところで	接続詞	\N	\N	\N	429	\N
446	오빠	(女性から見て)お兄さん	名詞	\N	\N	\N	429	\N
209	혹시	もしかして	副詞	\N	\N	\N	429	\N
373	다음 주	来週	名詞	\N	\N	\N	429	\N
288	일요일에	日曜日に	名詞	\N	\N	\N	429	\N
145	시간	時間	名詞	\N	\N	\N	429	\N
84	있으세요	ありますか	存在詞	\N	\N	\N	429	\N
422	음	うん	間投詞	\N	\N	\N	430	\N
145	시간은	時間は	名詞	\N	\N	\N	430	\N
84	있는데	あるけど	存在詞	\N	\N	\N	430	\N
61	왜요	どうしてですか	副詞	\N	\N	\N	430	\N
447	실은 	実は	副詞	\N	\N	\N	431	\N
8	제가	私が	名詞	\N	\N	\N	431	\N
9	어제	昨日	名詞	\N	\N	\N	431	\N
448	이사를	引っ越しを	名詞	\N	\N	\N	431	\N
156	했거든요	したんですよ	動詞	\N	\N	\N	431	\N
449	그래서 	それで	接続詞	\N	\N	\N	432	\N
373	다음 주	来週	名詞	\N	\N	\N	432	\N
288	일요일에	日曜日に	名詞	\N	\N	\N	432	\N
450	집들이를	引っ越しパーティを	名詞	\N	\N	\N	432	\N
156	하려고 하는데	しようと思ってるんですが	動詞	\N	\N	\N	432	\N
446	오빠도	(女性から見て)お兄さんも	名詞	\N	\N	\N	432	\N
99	오실	いらっしゃる	動詞	\N	\N	\N	432	\N
270	수	すべ	名詞	\N	\N	\N	432	\N
84	있으세요	ございますか	存在詞	\N	\N	\N	432	\N
353	물론	もちろん	副詞	\N	\N	\N	433	\N
21	갈	行く	動詞	\N	\N	\N	433	\N
270	수	すべ	名詞	\N	\N	\N	433	\N
84	있죠	ありますよ	存在詞	\N	\N	\N	433	\N
161	몇	何	疑問詞	\N	\N	\N	434	\N
162	신데요	時ですか	名数詞	\N	\N	\N	434	\N
451	저녁	夕方	名詞	\N	\N	\N	435	\N
452	6시부터에요	6時からです	名数詞	\N	\N	\N	435	\N
110	꼭	必ず	副詞	\N	\N	\N	436	\N
21	갈게요	行きますよ	動詞	\N	\N	\N	436	\N
41	그럼	では	接続詞	\N	\N	\N	437	\N
127	그	その	冠形詞	\N	\N	\N	437	\N
179	때	時	名詞	\N	\N	\N	437	\N
79	봐요	会いましょう	動詞	\N	\N	\N	437	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	438	\N
61	왜	どうして	副詞	\N	\N	\N	438	\N
19	그렇게	そんなに	形容詞	\N	\N	\N	438	\N
453	기운이	元気が	名詞	\N	\N	\N	438	\N
98	없어요	ないんですか	存在詞	\N	\N	\N	438	\N
55	아	あ	間投詞	\N	\N	\N	439	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	439	\N
294	실은	実は	副詞	\N	\N	\N	439	\N
172	요새	このごろ	名詞	\N	\N	\N	439	\N
454	식욕도	食欲も	名詞	\N	\N	\N	439	\N
98	없구	ないし	存在詞	\N	\N	\N	439	\N
312	공부도	勉強も	名詞	\N	\N	\N	439	\N
156	하기 싫구	やりたくないし	動詞	\N	\N	\N	439	\N
455	피곤해서	疲れてるから	形容詞	\N	\N	\N	440	\N
19	그런	そのような	形容詞	\N	\N	\N	440	\N
87	거	~こと	不完全名詞	\N	\N	\N	440	\N
16	아니에요	ありませんか	指定詞	\N	\N	\N	440	\N
211	모르겠어요	わかりません	動詞	\N	\N	\N	441	\N
170	요즘은	このごろは	名詞	\N	\N	\N	442	\N
456	아르바이트도	アルバイトも	名詞	\N	\N	\N	442	\N
150	안	ない	副詞	\N	\N	\N	442	\N
156	하니까	するから	動詞	\N	\N	\N	442	\N
455	피곤하지는 않은데	疲れてはいないんですが	形容詞	\N	\N	\N	442	\N
19	그럴	そんな	形容詞	\N	\N	\N	443	\N
179	땐	時は	名詞	\N	\N	\N	443	\N
366	오히려	かえって	副詞	\N	\N	\N	443	\N
146	몸을	体を	名詞	\N	\N	\N	443	\N
457	움직이는	動かす	動詞	\N	\N	\N	443	\N
87	게	~のが	不完全名詞	\N	\N	\N	443	\N
151	좋아요	いいですよ	形容詞	\N	\N	\N	443	\N
39	다	すべて	副詞	\N	\N	\N	444	\N
402	귀찮아요	めんどくさいですよ	形容詞	\N	\N	\N	444	\N
19	그런	そんな	形容詞	\N	\N	\N	445	\N
458	소리	話し	名詞	\N	\N	\N	445	\N
156	하지 말고	しないで	動詞	\N	\N	\N	445	\N
34	먼저	まず	副詞	\N	\N	\N	445	\N
107	방	部屋	名詞	\N	\N	\N	445	\N
459	청소부터	掃除から	名詞	\N	\N	\N	445	\N
107	방	部屋	名詞	\N	\N	\N	446	\N
459	청소는	掃除は	名詞	\N	\N	\N	446	\N
164	반	半	数詞	\N	\N	\N	446	\N
460	년	年	名数詞	\N	\N	\N	446	\N
461	이상	以上	名詞	\N	\N	\N	446	\N
156	해 본	やった	動詞	\N	\N	\N	446	\N
134	적이	~ことが	不完全名詞	\N	\N	\N	446	\N
98	없어요	ありません	存在詞	\N	\N	\N	446	\N
107	방이	部屋が	名詞	\N	\N	\N	447	\N
462	지저분하면	汚いと	形容詞	\N	\N	\N	447	\N
453	기운도	元気も	名詞	\N	\N	\N	447	\N
98	없어지기 마련이에요	なくなるものです	存在詞	\N	\N	\N	447	\N
6	네	ええ	間投詞	\N	\N	\N	448	\N
41	그럼	では	接続詞	\N	\N	\N	449	\N
91	한번	一度	副詞	\N	\N	\N	449	\N
156	해 볼게요	してみます	動詞	\N	\N	\N	449	\N
463	아저씨	おじさん	名詞	\N	\N	\N	450	\N
63	이	この	冠形詞	\N	\N	\N	450	\N
127	귤	ミカン	名詞	\N	\N	\N	450	\N
38	맛있어요	おいしいですか	存在詞	\N	\N	\N	450	\N
41	그럼요	もちろんですよ	間投詞	\N	\N	\N	451	\N
38	맛있죠	おいしいですよ	存在詞	\N	\N	\N	452	\N
19	그래요	そうですか	形容詞	\N	\N	\N	453	\N
41	그럼	では	接続詞	\N	\N	\N	454	\N
464	열	10	数詞	\N	\N	\N	454	\N
465	개만	個ほど	名数詞	\N	\N	\N	454	\N
28	주세요	下さい	動詞	\N	\N	\N	454	\N
6	네	はい	間投詞	\N	\N	\N	455	\N
466	삼천	3000	数詞	\N	\N	\N	455	\N
124	원입니다	ウォンです	名数詞	\N	\N	\N	455	\N
1	어	あら	間投詞	\N	\N	\N	456	\N
105	너무	ずいぶん	副詞	\N	\N	\N	456	\N
364	비싸요	高いですね	形容詞	\N	\N	\N	456	\N
463	아저씨	おじさん	名詞	\N	\N	\N	457	\N
36	좀	ちょっと	副詞	\N	\N	\N	457	\N
467	깎아 주세요	まけて下さい	動詞	\N	\N	\N	457	\N
334	글쎄	そうだね	間投詞	\N	\N	\N	458	\N
111	우린	うちは	代名詞	\N	\N	\N	458	\N
90	다른	他の	形容詞	\N	\N	\N	458	\N
403	가게보다	店より	名詞	\N	\N	\N	458	\N
75	싼	安い	形容詞	\N	\N	\N	458	\N
284	편이에요	方ですよ	名詞	\N	\N	\N	458	\N
109	다음에도	次も	名詞	\N	\N	\N	459	\N
110	꼭	必ず	副詞	\N	\N	\N	459	\N
12	살	買う	動詞	\N	\N	\N	459	\N
6	테니까	~から	不完全名詞	\N	\N	\N	459	\N
235	조금만	少しだけ	副詞	\N	\N	\N	459	\N
467	깎아 주세요	まけて下さいよ	動詞	\N	\N	\N	459	\N
43	알았어요	わかりました	動詞	\N	\N	\N	460	\N
41	그럼	では	間投詞	\N	\N	\N	461	\N
468	이천 오백	2500	数詞	\N	\N	\N	461	\N
124	원으로	ウォンに	名数詞	\N	\N	\N	461	\N
156	하죠	しましょう	動詞	\N	\N	\N	461	\N
30	고마워요	ありがとうございます	形容詞	\N	\N	\N	462	\N
109	다음에도	次も	名詞	\N	\N	\N	463	\N
110	꼭	必ず	副詞	\N	\N	\N	463	\N
99	올게요	来ますからね	動詞	\N	\N	\N	463	\N
95	감사합니다	ありがとうございます	形容詞	\N	\N	\N	464	\N
469	또	また	副詞	\N	\N	\N	465	\N
99	오세요	おいでください	動詞	\N	\N	\N	465	\N
22	학교	学校	名詞	\N	\N	\N	466	\N
470	졸업하면	卒業したら	動詞	\N	\N	\N	466	\N
14	뭐	何を	代名詞	\N	\N	\N	466	\N
156	할	する	動詞	\N	\N	\N	466	\N
87	거에요	~んですか	不完全名詞	\N	\N	\N	466	\N
8	전	私は	代名詞	\N	\N	\N	467	\N
471	대학원에	大学院に	名詞	\N	\N	\N	467	\N
21	가고 싶어요	行きたいですね	動詞	\N	\N	\N	467	\N
471	대학원에선	大学院では	名詞	\N	\N	\N	468	\N
14	뭘	何を	代名詞	\N	\N	\N	468	\N
472	전공하고 싶은데요	専攻したいですか	動詞	\N	\N	\N	468	\N
103	아직	まだ	副詞	\N	\N	\N	469	\N
473	확실하진 않은데요	はっきりしていないんですが	形容詞	\N	\N	\N	469	\N
60	문학을	文学が	名詞	\N	\N	\N	469	\N
158	공부하고 싶어요	勉強したいです	動詞	\N	\N	\N	469	\N
474	특히	特に	副詞	\N	\N	\N	470	\N
168	좋아하는	好きな	動詞	\N	\N	\N	470	\N
475	작품	作品	名詞	\N	\N	\N	470	\N
84	있어요	ありますか	存在詞	\N	\N	\N	470	\N
6	네	ええ	間投詞	\N	\N	\N	471	\N
354	“소나기”	“ソナギ(にわか雨)”	固有名詞(書名)	\N	\N	\N	471	\N
203	같은	ような	形容詞	\N	\N	\N	471	\N
476	단편소설을	短編小説が	名詞	\N	\N	\N	471	\N
168	좋아해요	好きです	動詞	\N	\N	\N	471	\N
2	～씨	～さん	不完全名詞	\N	\N	\N	472	\N
477	이쪽은	こちらは	代名詞	\N	\N	\N	472	\N
22	학교	学校	名詞	\N	\N	\N	472	\N
478	친구	友人	名詞	\N	\N	\N	472	\N
44	처음	はじめて	副詞	\N	\N	\N	473	\N
45	뵙겠습니다	お目にかかります	動詞	\N	\N	\N	473	\N
479	말씀	お話	名詞	\N	\N	\N	476	\N
83	많이	よく	副詞	\N	\N	\N	476	\N
480	들었습니다	伺っております	動詞	\N	\N	\N	476	\N
2	～씨는	～さんは	不完全名詞	\N	\N	\N	477	\N
57	전공이	専攻が	名詞	\N	\N	\N	477	\N
86	일본	日本	固有名詞	\N	\N	\N	477	\N
481	경제라서	経済ですので	名詞	\N	\N	\N	477	\N
76	한국	韓国	固有名詞	\N	\N	\N	477	\N
482	관심이	関心が	名詞	\N	\N	\N	477	\N
25	많습니다	多いです	形容詞	\N	\N	\N	477	\N
19	그렇습니까	そうですか	形容詞	\N	\N	\N	478	\N
8	저는	私は	代名詞	\N	\N	\N	479	\N
76	한국	韓国	固有名詞	\N	\N	\N	479	\N
481	경제가	経済が	名詞	\N	\N	\N	479	\N
57	전공이에요	専攻です	名詞	\N	\N	\N	479	\N
1	어	まあ	間投詞	\N	\N	\N	480	\N
19	그러세요	そうですか	形容詞	\N	\N	\N	480	\N
83	많이	たくさん	副詞	\N	\N	\N	481	\N
483	가르쳐 주세요	教えてください	動詞	\N	\N	\N	481	\N
8	저야말로요	こちらこそ	代名詞	\N	\N	\N	482	\N
8	저도	私も	代名詞	\N	\N	\N	483	\N
86	일본	日本	固有名詞	\N	\N	\N	483	\N
481	경제에	経済に	経済	\N	\N	\N	483	\N
484	대해	ついて	後置詞	\N	\N	\N	483	\N
43	알고 싶은	知りたい	動詞	\N	\N	\N	483	\N
87	게	~ことが	不完全名詞	\N	\N	\N	483	\N
25	많습니다	多いんですよ	形容詞	\N	\N	\N	483	\N
265	그러면	では	接続詞	\N	\N	\N	484	\N
485	이따가	後ほど	副詞	\N	\N	\N	484	\N
8	저하고	私と	代名詞	\N	\N	\N	484	\N
486	얘기	お話し	名詞	\N	\N	\N	484	\N
36	좀	ちょっと	副詞	\N	\N	\N	484	\N
156	하실까요	しましょうか	動詞	\N	\N	\N	484	\N
548		\N		\N	\N	\N	371	\N
548		\N		\N	\N	\N	458	\N
641		\N		\N	\N	\N	311	\N
487		\N		\N	\N	\N	16	\N
487		\N		\N	\N	\N	17	\N
487		\N		\N	\N	\N	85	\N
487		\N		\N	\N	\N	86	\N
487		\N		\N	\N	\N	94	\N
487		\N		\N	\N	\N	105	\N
487		\N		\N	\N	\N	106	\N
487		\N		\N	\N	\N	107	\N
487		\N		\N	\N	\N	118	\N
487		\N		\N	\N	\N	120	\N
487		\N		\N	\N	\N	126	\N
487		\N		\N	\N	\N	129	\N
487		\N		\N	\N	\N	144	\N
487		\N		\N	\N	\N	145	\N
487		\N		\N	\N	\N	146	\N
487		\N		\N	\N	\N	158	\N
487		\N		\N	\N	\N	171	\N
487		\N		\N	\N	\N	244	\N
487		\N		\N	\N	\N	309	\N
487		\N		\N	\N	\N	326	\N
487		\N		\N	\N	\N	409	\N
487		\N		\N	\N	\N	467	\N
487		\N		\N	\N	\N	28	\N
626		\N		\N	\N	\N	481	\N
593		\N		\N	\N	\N	200	\N
593		\N		\N	\N	\N	324	\N
487		\N		\N	\N	\N	91	\N
487		\N		\N	\N	\N	121	\N
487		\N		\N	\N	\N	122	\N
487		\N		\N	\N	\N	125	\N
487		\N		\N	\N	\N	143	\N
487		\N		\N	\N	\N	433	\N
487		\N		\N	\N	\N	436	\N
990		\N		\N	\N	\N	59	\N
648		\N		\N	\N	\N	204	\N
615		\N		\N	\N	\N	127	\N
615		\N		\N	\N	\N	274	\N
615		\N		\N	\N	\N	439	\N
615		\N		\N	\N	\N	469	\N
552		\N		\N	\N	\N	233	\N
552		\N		\N	\N	\N	236	\N
552		\N		\N	\N	\N	239	\N
743		\N		\N	\N	\N	101	\N
743		\N		\N	\N	\N	123	\N
743		\N		\N	\N	\N	174	\N
743		\N		\N	\N	\N	260	\N
743		\N		\N	\N	\N	273	\N
743		\N		\N	\N	\N	379	\N
743		\N		\N	\N	\N	421	\N
743		\N		\N	\N	\N	437	\N
1005		\N		\N	\N	\N	34	\N
1005		\N		\N	\N	\N	75	\N
1005		\N		\N	\N	\N	85	\N
1005		\N		\N	\N	\N	102	\N
1005		\N		\N	\N	\N	118	\N
1005		\N		\N	\N	\N	125	\N
1005		\N		\N	\N	\N	131	\N
1005		\N		\N	\N	\N	158	\N
1005		\N		\N	\N	\N	163	\N
1005		\N		\N	\N	\N	191	\N
1005		\N		\N	\N	\N	250	\N
1005		\N		\N	\N	\N	300	\N
1005		\N		\N	\N	\N	309	\N
1005		\N		\N	\N	\N	366	\N
1005		\N		\N	\N	\N	368	\N
1005		\N		\N	\N	\N	383	\N
1005		\N		\N	\N	\N	389	\N
1005		\N		\N	\N	\N	418	\N
1005		\N		\N	\N	\N	421	\N
1005		\N		\N	\N	\N	437	\N
1005		\N		\N	\N	\N	449	\N
1005		\N		\N	\N	\N	454	\N
1005		\N		\N	\N	\N	461	\N
1007		\N		\N	\N	\N	34	\N
1007		\N		\N	\N	\N	75	\N
1007		\N		\N	\N	\N	85	\N
1007		\N		\N	\N	\N	102	\N
1007		\N		\N	\N	\N	118	\N
1007		\N		\N	\N	\N	125	\N
1007		\N		\N	\N	\N	131	\N
1007		\N		\N	\N	\N	158	\N
1007		\N		\N	\N	\N	163	\N
1007		\N		\N	\N	\N	191	\N
1007		\N		\N	\N	\N	250	\N
1007		\N		\N	\N	\N	300	\N
1007		\N		\N	\N	\N	309	\N
1007		\N		\N	\N	\N	366	\N
1007		\N		\N	\N	\N	368	\N
1007		\N		\N	\N	\N	383	\N
1007		\N		\N	\N	\N	389	\N
1007		\N		\N	\N	\N	418	\N
1007		\N		\N	\N	\N	421	\N
1007		\N		\N	\N	\N	437	\N
1007		\N		\N	\N	\N	449	\N
1007		\N		\N	\N	\N	454	\N
1007		\N		\N	\N	\N	461	\N
749		\N		\N	\N	\N	95	\N
749		\N		\N	\N	\N	183	\N
749		\N		\N	\N	\N	261	\N
749		\N		\N	\N	\N	290	\N
749		\N		\N	\N	\N	334	\N
749		\N		\N	\N	\N	349	\N
749		\N		\N	\N	\N	369	\N
749		\N		\N	\N	\N	428	\N
749		\N		\N	\N	\N	438	\N
749		\N		\N	\N	\N	478	\N
749		\N		\N	\N	\N	224	\N
749		\N		\N	\N	\N	443	\N
749		\N		\N	\N	\N	72	\N
749		\N		\N	\N	\N	226	\N
749		\N		\N	\N	\N	341	\N
749		\N		\N	\N	\N	445	\N
840		\N		\N	\N	\N	368	\N
929		\N		\N	\N	\N	190	\N
929		\N		\N	\N	\N	314	\N
495		\N		\N	\N	\N	328	\N
703		\N		\N	\N	\N	400	\N
909		\N		\N	\N	\N	120	\N
909		\N		\N	\N	\N	122	\N
909		\N		\N	\N	\N	124	\N
909		\N		\N	\N	\N	282	\N
909		\N		\N	\N	\N	340	\N
909		\N		\N	\N	\N	345	\N
667		\N		\N	\N	\N	257	\N
667		\N		\N	\N	\N	260	\N
691		\N		\N	\N	\N	4	\N
691		\N		\N	\N	\N	13	\N
691		\N		\N	\N	\N	30	\N
691		\N		\N	\N	\N	35	\N
691		\N		\N	\N	\N	94	\N
691		\N		\N	\N	\N	107	\N
691		\N		\N	\N	\N	119	\N
691		\N		\N	\N	\N	148	\N
691		\N		\N	\N	\N	160	\N
691		\N		\N	\N	\N	166	\N
691		\N		\N	\N	\N	173	\N
691		\N		\N	\N	\N	193	\N
691		\N		\N	\N	\N	201	\N
691		\N		\N	\N	\N	207	\N
691		\N		\N	\N	\N	219	\N
691		\N		\N	\N	\N	226	\N
691		\N		\N	\N	\N	233	\N
691		\N		\N	\N	\N	283	\N
691		\N		\N	\N	\N	316	\N
691		\N		\N	\N	\N	341	\N
691		\N		\N	\N	\N	350	\N
691		\N		\N	\N	\N	352	\N
691		\N		\N	\N	\N	364	\N
691		\N		\N	\N	\N	367	\N
691		\N		\N	\N	\N	369	\N
691		\N		\N	\N	\N	375	\N
691		\N		\N	\N	\N	398	\N
691		\N		\N	\N	\N	428	\N
691		\N		\N	\N	\N	448	\N
691		\N		\N	\N	\N	455	\N
691		\N		\N	\N	\N	471	\N
896		\N		\N	\N	\N	446	\N
501		\N		\N	\N	\N	89	\N
805		\N		\N	\N	\N	362	\N
809		\N		\N	\N	\N	362	\N
998		\N		\N	\N	\N	260	\N
774		\N		\N	\N	\N	291	\N
996		\N		\N	\N	\N	45	\N
996		\N		\N	\N	\N	290	\N
888		\N		\N	\N	\N	342	\N
888		\N		\N	\N	\N	343	\N
888		\N		\N	\N	\N	350	\N
888		\N		\N	\N	\N	412	\N
888		\N		\N	\N	\N	429	\N
888		\N		\N	\N	\N	432	\N
536		\N		\N	\N	\N	121	\N
536		\N		\N	\N	\N	126	\N
686		\N		\N	\N	\N	257	\N
686		\N		\N	\N	\N	260	\N
599		\N		\N	\N	\N	476	\N
967		\N		\N	\N	\N	72	\N
583		\N		\N	\N	\N	37	\N
681		\N		\N	\N	\N	167	\N
681		\N		\N	\N	\N	309	\N
681		\N		\N	\N	\N	363	\N
508		\N		\N	\N	\N	181	\N
921		\N		\N	\N	\N	254	\N
669		\N		\N	\N	\N	148	\N
669		\N		\N	\N	\N	254	\N
497		\N		\N	\N	\N	40	\N
497		\N		\N	\N	\N	132	\N
497		\N		\N	\N	\N	131	\N
776		\N		\N	\N	\N	18	\N
776		\N		\N	\N	\N	73	\N
776		\N		\N	\N	\N	86	\N
776		\N		\N	\N	\N	88	\N
776		\N		\N	\N	\N	95	\N
776		\N		\N	\N	\N	96	\N
776		\N		\N	\N	\N	114	\N
776		\N		\N	\N	\N	146	\N
776		\N		\N	\N	\N	164	\N
776		\N		\N	\N	\N	176	\N
776		\N		\N	\N	\N	190	\N
776		\N		\N	\N	\N	230	\N
776		\N		\N	\N	\N	243	\N
776		\N		\N	\N	\N	294	\N
776		\N		\N	\N	\N	337	\N
776		\N		\N	\N	\N	345	\N
776		\N		\N	\N	\N	374	\N
776		\N		\N	\N	\N	375	\N
776		\N		\N	\N	\N	476	\N
776		\N		\N	\N	\N	477	\N
776		\N		\N	\N	\N	481	\N
776		\N		\N	\N	\N	483	\N
503		\N		\N	\N	\N	308	\N
672		\N		\N	\N	\N	32	\N
672		\N		\N	\N	\N	33	\N
672		\N		\N	\N	\N	92	\N
672		\N		\N	\N	\N	118	\N
672		\N		\N	\N	\N	213	\N
672		\N		\N	\N	\N	450	\N
672		\N		\N	\N	\N	452	\N
680		\N		\N	\N	\N	216	\N
680		\N		\N	\N	\N	215	\N
677		\N		\N	\N	\N	88	\N
677		\N		\N	\N	\N	92	\N
677		\N		\N	\N	\N	113	\N
677		\N		\N	\N	\N	114	\N
677		\N		\N	\N	\N	115	\N
677		\N		\N	\N	\N	117	\N
677		\N		\N	\N	\N	171	\N
677		\N		\N	\N	\N	176	\N
677		\N		\N	\N	\N	230	\N
677		\N		\N	\N	\N	233	\N
677		\N		\N	\N	\N	235	\N
677		\N		\N	\N	\N	237	\N
677		\N		\N	\N	\N	243	\N
677		\N		\N	\N	\N	305	\N
677		\N		\N	\N	\N	368	\N
918		\N		\N	\N	\N	348	\N
829		\N		\N	\N	\N	443	\N
632		\N		\N	\N	\N	405	\N
632		\N		\N	\N	\N	418	\N
535		\N		\N	\N	\N	274	\N
535		\N		\N	\N	\N	345	\N
535		\N		\N	\N	\N	416	\N
784		\N		\N	\N	\N	328	\N
916		\N		\N	\N	\N	287	\N
577		\N		\N	\N	\N	445	\N
577		\N		\N	\N	\N	446	\N
577		\N		\N	\N	\N	447	\N
643		\N		\N	\N	\N	88	\N
643		\N		\N	\N	\N	301	\N
837		\N		\N	\N	\N	88	\N
837		\N		\N	\N	\N	301	\N
713		\N		\N	\N	\N	7	\N
713		\N		\N	\N	\N	122	\N
713		\N		\N	\N	\N	132	\N
516		\N		\N	\N	\N	155	\N
516		\N		\N	\N	\N	156	\N
920		\N		\N	\N	\N	302	\N
549		\N		\N	\N	\N	334	\N
549		\N		\N	\N	\N	456	\N
549		\N		\N	\N	\N	337	\N
538		\N		\N	\N	\N	60	\N
511		\N		\N	\N	\N	158	\N
511		\N		\N	\N	\N	406	\N
708		\N		\N	\N	\N	324	\N
708		\N		\N	\N	\N	296	\N
708		\N		\N	\N	\N	258	\N
708		\N		\N	\N	\N	265	\N
708		\N		\N	\N	\N	459	\N
708		\N		\N	\N	\N	7	\N
708		\N		\N	\N	\N	19	\N
708		\N		\N	\N	\N	20	\N
708		\N		\N	\N	\N	96	\N
977		\N		\N	\N	\N	111	\N
977		\N		\N	\N	\N	211	\N
977		\N		\N	\N	\N	339	\N
981		\N		\N	\N	\N	111	\N
981		\N		\N	\N	\N	211	\N
981		\N		\N	\N	\N	339	\N
537		\N		\N	\N	\N	11	\N
537		\N		\N	\N	\N	12	\N
537		\N		\N	\N	\N	192	\N
537		\N		\N	\N	\N	193	\N
537		\N		\N	\N	\N	194	\N
537		\N		\N	\N	\N	199	\N
940		\N		\N	\N	\N	182	\N
940		\N		\N	\N	\N	357	\N
940		\N		\N	\N	\N	358	\N
940		\N		\N	\N	\N	360	\N
940		\N		\N	\N	\N	362	\N
940		\N		\N	\N	\N	383	\N
940		\N		\N	\N	\N	384	\N
619		\N		\N	\N	\N	340	\N
832		\N		\N	\N	\N	379	\N
622		\N		\N	\N	\N	345	\N
622		\N		\N	\N	\N	406	\N
624		\N		\N	\N	\N	328	\N
624		\N		\N	\N	\N	401	\N
671		\N		\N	\N	\N	148	\N
671		\N		\N	\N	\N	225	\N
513		\N		\N	\N	\N	133	\N
513		\N		\N	\N	\N	252	\N
910		\N		\N	\N	\N	131	\N
910		\N		\N	\N	\N	132	\N
910		\N		\N	\N	\N	149	\N
910		\N		\N	\N	\N	151	\N
910		\N		\N	\N	\N	157	\N
910		\N		\N	\N	\N	282	\N
910		\N		\N	\N	\N	435	\N
924		\N		\N	\N	\N	117	\N
924		\N		\N	\N	\N	137	\N
924		\N		\N	\N	\N	302	\N
924		\N		\N	\N	\N	320	\N
924		\N		\N	\N	\N	328	\N
924		\N		\N	\N	\N	408	\N
924		\N		\N	\N	\N	429	\N
924		\N		\N	\N	\N	430	\N
928		\N		\N	\N	\N	117	\N
928		\N		\N	\N	\N	137	\N
928		\N		\N	\N	\N	302	\N
928		\N		\N	\N	\N	320	\N
928		\N		\N	\N	\N	328	\N
928		\N		\N	\N	\N	408	\N
928		\N		\N	\N	\N	429	\N
928		\N		\N	\N	\N	430	\N
627		\N		\N	\N	\N	277	\N
627		\N		\N	\N	\N	278	\N
682		\N		\N	\N	\N	167	\N
682		\N		\N	\N	\N	309	\N
682		\N		\N	\N	\N	363	\N
710		\N		\N	\N	\N	97	\N
710		\N		\N	\N	\N	102	\N
514		\N		\N	\N	\N	248	\N
514		\N		\N	\N	\N	252	\N
547		\N		\N	\N	\N	99	\N
547		\N		\N	\N	\N	104	\N
547		\N		\N	\N	\N	371	\N
547		\N		\N	\N	\N	65	\N
547		\N		\N	\N	\N	96	\N
547		\N		\N	\N	\N	458	\N
718		\N		\N	\N	\N	29	\N
718		\N		\N	\N	\N	388	\N
718		\N		\N	\N	\N	393	\N
718		\N		\N	\N	\N	396	\N
718		\N		\N	\N	\N	457	\N
718		\N		\N	\N	\N	459	\N
718		\N		\N	\N	\N	481	\N
718		\N		\N	\N	\N	316	\N
718		\N		\N	\N	\N	391	\N
690		\N		\N	\N	\N	79	\N
690		\N		\N	\N	\N	116	\N
690		\N		\N	\N	\N	141	\N
690		\N		\N	\N	\N	181	\N
690		\N		\N	\N	\N	230	\N
690		\N		\N	\N	\N	238	\N
690		\N		\N	\N	\N	384	\N
690		\N		\N	\N	\N	396	\N
690		\N		\N	\N	\N	402	\N
690		\N		\N	\N	\N	413	\N
690		\N		\N	\N	\N	417	\N
1006		\N		\N	\N	\N	157	\N
922		\N		\N	\N	\N	86	\N
922		\N		\N	\N	\N	403	\N
922		\N		\N	\N	\N	469	\N
914		\N		\N	\N	\N	282	\N
914		\N		\N	\N	\N	286	\N
603		\N		\N	\N	\N	132	\N
603		\N		\N	\N	\N	379	\N
553		\N		\N	\N	\N	236	\N
553		\N		\N	\N	\N	241	\N
639		\N		\N	\N	\N	314	\N
745		\N		\N	\N	\N	346	\N
745		\N		\N	\N	\N	404	\N
595		\N		\N	\N	\N	16	\N
595		\N		\N	\N	\N	120	\N
595		\N		\N	\N	\N	198	\N
595		\N		\N	\N	\N	202	\N
595		\N		\N	\N	\N	292	\N
595		\N		\N	\N	\N	297	\N
595		\N		\N	\N	\N	387	\N
595		\N		\N	\N	\N	390	\N
746		\N		\N	\N	\N	113	\N
746		\N		\N	\N	\N	133	\N
746		\N		\N	\N	\N	332	\N
746		\N		\N	\N	\N	335	\N
744		\N		\N	\N	\N	45	\N
744		\N		\N	\N	\N	167	\N
744		\N		\N	\N	\N	170	\N
744		\N		\N	\N	\N	221	\N
744		\N		\N	\N	\N	256	\N
744		\N		\N	\N	\N	273	\N
744		\N		\N	\N	\N	289	\N
744		\N		\N	\N	\N	210	\N
744		\N		\N	\N	\N	212	\N
744		\N		\N	\N	\N	244	\N
744		\N		\N	\N	\N	250	\N
744		\N		\N	\N	\N	306	\N
744		\N		\N	\N	\N	421	\N
744		\N		\N	\N	\N	108	\N
744		\N		\N	\N	\N	275	\N
625		\N		\N	\N	\N	405	\N
911		\N		\N	\N	\N	7	\N
911		\N		\N	\N	\N	310	\N
911		\N		\N	\N	\N	431	\N
925		\N		\N	\N	\N	123	\N
925		\N		\N	\N	\N	278	\N
551		\N		\N	\N	\N	100	\N
551		\N		\N	\N	\N	102	\N
1001		\N		\N	\N	\N	83	\N
1001		\N		\N	\N	\N	117	\N
1001		\N		\N	\N	\N	137	\N
1001		\N		\N	\N	\N	288	\N
1001		\N		\N	\N	\N	328	\N
1001		\N		\N	\N	\N	438	\N
1001		\N		\N	\N	\N	439	\N
1001		\N		\N	\N	\N	446	\N
1001		\N		\N	\N	\N	447	\N
592		\N		\N	\N	\N	167	\N
592		\N		\N	\N	\N	168	\N
592		\N		\N	\N	\N	199	\N
592		\N		\N	\N	\N	374	\N
592		\N		\N	\N	\N	472	\N
488		\N		\N	\N	\N	185	\N
598		\N		\N	\N	\N	204	\N
598		\N		\N	\N	\N	391	\N
782		\N		\N	\N	\N	204	\N
782		\N		\N	\N	\N	391	\N
908		\N		\N	\N	\N	82	\N
908		\N		\N	\N	\N	92	\N
908		\N		\N	\N	\N	147	\N
908		\N		\N	\N	\N	279	\N
908		\N		\N	\N	\N	287	\N
908		\N		\N	\N	\N	313	\N
908		\N		\N	\N	\N	400	\N
604		\N		\N	\N	\N	199	\N
604		\N		\N	\N	\N	392	\N
825		\N		\N	\N	\N	97	\N
825		\N		\N	\N	\N	100	\N
825		\N		\N	\N	\N	101	\N
825		\N		\N	\N	\N	339	\N
826		\N		\N	\N	\N	97	\N
826		\N		\N	\N	\N	100	\N
826		\N		\N	\N	\N	101	\N
826		\N		\N	\N	\N	339	\N
683		\N		\N	\N	\N	227	\N
605		\N		\N	\N	\N	392	\N
605		\N		\N	\N	\N	393	\N
562		\N		\N	\N	\N	171	\N
562		\N		\N	\N	\N	172	\N
562		\N		\N	\N	\N	174	\N
562		\N		\N	\N	\N	206	\N
562		\N		\N	\N	\N	366	\N
821		\N		\N	\N	\N	57	\N
821		\N		\N	\N	\N	58	\N
821		\N		\N	\N	\N	59	\N
821		\N		\N	\N	\N	65	\N
792		\N		\N	\N	\N	388	\N
792		\N		\N	\N	\N	395	\N
792		\N		\N	\N	\N	397	\N
1003		\N		\N	\N	\N	297	\N
1003		\N		\N	\N	\N	298	\N
684		\N		\N	\N	\N	86	\N
684		\N		\N	\N	\N	113	\N
742		\N		\N	\N	\N	100	\N
742		\N		\N	\N	\N	102	\N
742		\N		\N	\N	\N	168	\N
742		\N		\N	\N	\N	174	\N
742		\N		\N	\N	\N	340	\N
742		\N		\N	\N	\N	363	\N
742		\N		\N	\N	\N	387	\N
742		\N		\N	\N	\N	395	\N
742		\N		\N	\N	\N	450	\N
960		\N		\N	\N	\N	218	\N
960		\N		\N	\N	\N	484	\N
494		\N		\N	\N	\N	179	\N
494		\N		\N	\N	\N	180	\N
585		\N		\N	\N	\N	286	\N
886		\N		\N	\N	\N	244	\N
886		\N		\N	\N	\N	429	\N
886		\N		\N	\N	\N	432	\N
540		\N		\N	\N	\N	254	\N
748		\N		\N	\N	\N	366	\N
584		\N		\N	\N	\N	287	\N
927		\N		\N	\N	\N	136	\N
902		\N		\N	\N	\N	107	\N
544		\N		\N	\N	\N	179	\N
772		\N		\N	\N	\N	69	\N
772		\N		\N	\N	\N	109	\N
772		\N		\N	\N	\N	110	\N
772		\N		\N	\N	\N	147	\N
772		\N		\N	\N	\N	148	\N
735		\N		\N	\N	\N	6	\N
735		\N		\N	\N	\N	37	\N
735		\N		\N	\N	\N	39	\N
735		\N		\N	\N	\N	44	\N
735		\N		\N	\N	\N	52	\N
735		\N		\N	\N	\N	53	\N
735		\N		\N	\N	\N	134	\N
735		\N		\N	\N	\N	139	\N
735		\N		\N	\N	\N	190	\N
735		\N		\N	\N	\N	216	\N
735		\N		\N	\N	\N	227	\N
735		\N		\N	\N	\N	236	\N
735		\N		\N	\N	\N	246	\N
735		\N		\N	\N	\N	265	\N
735		\N		\N	\N	\N	269	\N
735		\N		\N	\N	\N	274	\N
735		\N		\N	\N	\N	277	\N
735		\N		\N	\N	\N	286	\N
735		\N		\N	\N	\N	290	\N
735		\N		\N	\N	\N	298	\N
735		\N		\N	\N	\N	300	\N
735		\N		\N	\N	\N	407	\N
735		\N		\N	\N	\N	425	\N
735		\N		\N	\N	\N	479	\N
735		\N		\N	\N	\N	483	\N
735		\N		\N	\N	\N	484	\N
735		\N		\N	\N	\N	268	\N
735		\N		\N	\N	\N	308	\N
735		\N		\N	\N	\N	467	\N
735		\N		\N	\N	\N	22	\N
735		\N		\N	\N	\N	60	\N
735		\N		\N	\N	\N	155	\N
735		\N		\N	\N	\N	220	\N
735		\N		\N	\N	\N	252	\N
735		\N		\N	\N	\N	284	\N
735		\N		\N	\N	\N	328	\N
735		\N		\N	\N	\N	353	\N
735		\N		\N	\N	\N	362	\N
735		\N		\N	\N	\N	431	\N
594		\N		\N	\N	\N	96	\N
917		\N		\N	\N	\N	435	\N
532		\N		\N	\N	\N	290	\N
842		\N		\N	\N	\N	302	\N
842		\N		\N	\N	\N	320	\N
768		\N		\N	\N	\N	119	\N
768		\N		\N	\N	\N	164	\N
768		\N		\N	\N	\N	207	\N
768		\N		\N	\N	\N	224	\N
768		\N		\N	\N	\N	227	\N
768		\N		\N	\N	\N	296	\N
768		\N		\N	\N	\N	307	\N
768		\N		\N	\N	\N	331	\N
768		\N		\N	\N	\N	390	\N
768		\N		\N	\N	\N	419	\N
768		\N		\N	\N	\N	443	\N
941		\N		\N	\N	\N	133	\N
941		\N		\N	\N	\N	134	\N
941		\N		\N	\N	\N	139	\N
941		\N		\N	\N	\N	142	\N
941		\N		\N	\N	\N	225	\N
941		\N		\N	\N	\N	232	\N
941		\N		\N	\N	\N	236	\N
941		\N		\N	\N	\N	253	\N
941		\N		\N	\N	\N	254	\N
941		\N		\N	\N	\N	308	\N
941		\N		\N	\N	\N	470	\N
941		\N		\N	\N	\N	471	\N
504		\N		\N	\N	\N	133	\N
504		\N		\N	\N	\N	134	\N
504		\N		\N	\N	\N	139	\N
504		\N		\N	\N	\N	142	\N
504		\N		\N	\N	\N	225	\N
504		\N		\N	\N	\N	232	\N
504		\N		\N	\N	\N	236	\N
504		\N		\N	\N	\N	253	\N
504		\N		\N	\N	\N	254	\N
504		\N		\N	\N	\N	308	\N
504		\N		\N	\N	\N	470	\N
504		\N		\N	\N	\N	471	\N
894		\N		\N	\N	\N	60	\N
651		\N		\N	\N	\N	60	\N
651		\N		\N	\N	\N	256	\N
651		\N		\N	\N	\N	258	\N
651		\N		\N	\N	\N	265	\N
705		\N		\N	\N	\N	18	\N
705		\N		\N	\N	\N	95	\N
570		\N		\N	\N	\N	73	\N
570		\N		\N	\N	\N	89	\N
571		\N		\N	\N	\N	73	\N
571		\N		\N	\N	\N	89	\N
541		\N		\N	\N	\N	20	\N
541		\N		\N	\N	\N	129	\N
541		\N		\N	\N	\N	220	\N
541		\N		\N	\N	\N	254	\N
541		\N		\N	\N	\N	395	\N
575		\N		\N	\N	\N	388	\N
575		\N		\N	\N	\N	395	\N
575		\N		\N	\N	\N	397	\N
574		\N		\N	\N	\N	396	\N
572		\N		\N	\N	\N	445	\N
572		\N		\N	\N	\N	446	\N
712		\N		\N	\N	\N	203	\N
609		\N		\N	\N	\N	472	\N
580		\N		\N	\N	\N	391	\N
580		\N		\N	\N	\N	392	\N
659		\N		\N	\N	\N	254	\N
659		\N		\N	\N	\N	322	\N
658		\N		\N	\N	\N	254	\N
658		\N		\N	\N	\N	324	\N
860		\N		\N	\N	\N	387	\N
663		\N		\N	\N	\N	336	\N
753		\N		\N	\N	\N	292	\N
652		\N		\N	\N	\N	155	\N
652		\N		\N	\N	\N	249	\N
864		\N		\N	\N	\N	336	\N
700		\N		\N	\N	\N	412	\N
700		\N		\N	\N	\N	419	\N
700		\N		\N	\N	\N	421	\N
646		\N		\N	\N	\N	256	\N
646		\N		\N	\N	\N	258	\N
646		\N		\N	\N	\N	265	\N
530		\N		\N	\N	\N	122	\N
530		\N		\N	\N	\N	140	\N
530		\N		\N	\N	\N	177	\N
530		\N		\N	\N	\N	185	\N
530		\N		\N	\N	\N	253	\N
530		\N		\N	\N	\N	349	\N
530		\N		\N	\N	\N	446	\N
530		\N		\N	\N	\N	449	\N
530		\N		\N	\N	\N	431	\N
530		\N		\N	\N	\N	405	\N
530		\N		\N	\N	\N	217	\N
530		\N		\N	\N	\N	281	\N
530		\N		\N	\N	\N	466	\N
530		\N		\N	\N	\N	123	\N
530		\N		\N	\N	\N	136	\N
530		\N		\N	\N	\N	221	\N
530		\N		\N	\N	\N	289	\N
530		\N		\N	\N	\N	294	\N
530		\N		\N	\N	\N	439	\N
530		\N		\N	\N	\N	445	\N
530		\N		\N	\N	\N	461	\N
530		\N		\N	\N	\N	484	\N
613		\N		\N	\N	\N	17	\N
613		\N		\N	\N	\N	274	\N
613		\N		\N	\N	\N	466	\N
613		\N		\N	\N	\N	472	\N
614		\N		\N	\N	\N	41	\N
614		\N		\N	\N	\N	44	\N
614		\N		\N	\N	\N	167	\N
616		\N		\N	\N	\N	41	\N
616		\N		\N	\N	\N	44	\N
616		\N		\N	\N	\N	167	\N
883		\N		\N	\N	\N	137	\N
883		\N		\N	\N	\N	144	\N
654		\N		\N	\N	\N	202	\N
655		\N		\N	\N	\N	202	\N
1010		\N		\N	\N	\N	10	\N
1010		\N		\N	\N	\N	87	\N
1010		\N		\N	\N	\N	128	\N
1010		\N		\N	\N	\N	240	\N
1010		\N		\N	\N	\N	264	\N
1011		\N		\N	\N	\N	62	\N
1011		\N		\N	\N	\N	327	\N
1011		\N		\N	\N	\N	381	\N
763		\N		\N	\N	\N	485	\N
926		\N		\N	\N	\N	486	\N
897		\N		\N	\N	\N	487	\N
567		\N		\N	\N	\N	488	\N
566		\N		\N	\N	\N	489	\N
558		\N		\N	\N	\N	490	\N
848		\N		\N	\N	\N	491	\N
985		\N		\N	\N	\N	492	\N
522		\N		\N	\N	\N	493	\N
702		\N		\N	\N	\N	494	\N
945		\N		\N	\N	\N	495	\N
1004		\N		\N	\N	\N	496	\N
723		\N		\N	\N	\N	497	\N
509		\N		\N	\N	\N	498	\N
815		\N		\N	\N	\N	499	\N
901		\N		\N	\N	\N	500	\N
588		\N		\N	\N	\N	501	\N
589		\N		\N	\N	\N	502	\N
845		\N		\N	\N	\N	503	\N
557		\N		\N	\N	\N	504	\N
807		\N		\N	\N	\N	505	\N
728		\N		\N	\N	\N	506	\N
611		\N		\N	\N	\N	507	\N
525		\N		\N	\N	\N	508	\N
882		\N		\N	\N	\N	509	\N
835		\N		\N	\N	\N	510	\N
733		\N		\N	\N	\N	511	\N
939		\N		\N	\N	\N	512	\N
919		\N		\N	\N	\N	513	\N
597		\N		\N	\N	\N	514	\N
965		\N		\N	\N	\N	515	\N
895		\N		\N	\N	\N	516	\N
936		\N		\N	\N	\N	517	\N
519		\N		\N	\N	\N	518	\N
606		\N		\N	\N	\N	519	\N
496		\N		\N	\N	\N	520	\N
775		\N		\N	\N	\N	521	\N
673		\N		\N	\N	\N	522	\N
854		\N		\N	\N	\N	523	\N
951		\N		\N	\N	\N	524	\N
976		\N		\N	\N	\N	525	\N
980		\N		\N	\N	\N	526	\N
915		\N		\N	\N	\N	527	\N
903		\N		\N	\N	\N	528	\N
647		\N		\N	\N	\N	529	\N
578		\N		\N	\N	\N	530	\N
740		\N		\N	\N	\N	531	\N
526		\N		\N	\N	\N	532	\N
931		\N		\N	\N	\N	533	\N
621		\N		\N	\N	\N	534	\N
992		\N		\N	\N	\N	535	\N
858		\N		\N	\N	\N	536	\N
786		\N		\N	\N	\N	537	\N
738		\N		\N	\N	\N	538	\N
739		\N		\N	\N	\N	539	\N
737		\N		\N	\N	\N	540	\N
834		\N		\N	\N	\N	541	\N
948		\N		\N	\N	\N	542	\N
831		\N		\N	\N	\N	543	\N
876		\N		\N	\N	\N	544	\N
649		\N		\N	\N	\N	545	\N
668		\N		\N	\N	\N	546	\N
506		\N		\N	\N	\N	547	\N
556		\N		\N	\N	\N	548	\N
933		\N		\N	\N	\N	549	\N
633		\N		\N	\N	\N	550	\N
863		\N		\N	\N	\N	551	\N
502		\N		\N	\N	\N	552	\N
620		\N		\N	\N	\N	553	\N
944		\N		\N	\N	\N	554	\N
644		\N		\N	\N	\N	555	\N
695		\N		\N	\N	\N	556	\N
573		\N		\N	\N	\N	557	\N
785		\N		\N	\N	\N	558	\N
555		\N		\N	\N	\N	559	\N
750		\N		\N	\N	\N	560	\N
602		\N		\N	\N	\N	561	\N
952		\N		\N	\N	\N	562	\N
581		\N		\N	\N	\N	563	\N
582		\N		\N	\N	\N	564	\N
660		\N		\N	\N	\N	565	\N
681		\N		\N	\N	\N	566	\N
568		\N		\N	\N	\N	567	\N
1000		\N		\N	\N	\N	568	\N
865		\N		\N	\N	\N	569	\N
961		\N		\N	\N	\N	570	\N
962		\N		\N	\N	\N	571	\N
678		\N		\N	\N	\N	572	\N
899		\N		\N	\N	\N	573	\N
870		\N		\N	\N	\N	574	\N
885		\N		\N	\N	\N	575	\N
758		\N		\N	\N	\N	576	\N
982		\N		\N	\N	\N	577	\N
709		\N		\N	\N	\N	578	\N
942		\N		\N	\N	\N	579	\N
887		\N		\N	\N	\N	580	\N
520		\N		\N	\N	\N	581	\N
729		\N		\N	\N	\N	582	\N
862		\N		\N	\N	\N	583	\N
953		\N		\N	\N	\N	584	\N
716		\N		\N	\N	\N	585	\N
610		\N		\N	\N	\N	586	\N
836		\N		\N	\N	\N	587	\N
769		\N		\N	\N	\N	588	\N
986		\N		\N	\N	\N	589	\N
847		\N		\N	\N	\N	590	\N
839		\N		\N	\N	\N	591	\N
814		\N		\N	\N	\N	592	\N
638		\N		\N	\N	\N	593	\N
637		\N		\N	\N	\N	594	\N
612		\N		\N	\N	\N	595	\N
542		\N		\N	\N	\N	596	\N
543		\N		\N	\N	\N	597	\N
866		\N		\N	\N	\N	598	\N
904		\N		\N	\N	\N	599	\N
699		\N		\N	\N	\N	600	\N
803		\N		\N	\N	\N	601	\N
972		\N		\N	\N	\N	602	\N
724		\N		\N	\N	\N	603	\N
800		\N		\N	\N	\N	604	\N
788		\N		\N	\N	\N	605	\N
698		\N		\N	\N	\N	606	\N
950		\N		\N	\N	\N	607	\N
489		\N		\N	\N	\N	608	\N
707		\N		\N	\N	\N	609	\N
991		\N		\N	\N	\N	610	\N
531		\N		\N	\N	\N	611	\N
569		\N		\N	\N	\N	612	\N
564		\N		\N	\N	\N	613	\N
679		\N		\N	\N	\N	614	\N
518		\N		\N	\N	\N	615	\N
868		\N		\N	\N	\N	616	\N
795		\N		\N	\N	\N	617	\N
841		\N		\N	\N	\N	618	\N
521		\N		\N	\N	\N	619	\N
727		\N		\N	\N	\N	620	\N
878		\N		\N	\N	\N	621	\N
872		\N		\N	\N	\N	621	\N
802		\N		\N	\N	\N	622	\N
987		\N		\N	\N	\N	623	\N
554		\N		\N	\N	\N	624	\N
730		\N		\N	\N	\N	625	\N
946		\N		\N	\N	\N	626	\N
608		\N		\N	\N	\N	627	\N
789		\N		\N	\N	\N	628	\N
662		\N		\N	\N	\N	629	\N
787		\N		\N	\N	\N	630	\N
527		\N		\N	\N	\N	631	\N
813		\N		\N	\N	\N	632	\N
849		\N		\N	\N	\N	633	\N
819		\N		\N	\N	\N	634	\N
546		\N		\N	\N	\N	635	\N
711		\N		\N	\N	\N	636	\N
711		\N		\N	\N	\N	620	\N
813		\N		\N	\N	\N	631	\N
813		\N		\N	\N	\N	560	\N
521		\N		\N	\N	\N	581	\N
679		\N		\N	\N	\N	591	\N
950		\N		\N	\N	\N	612	\N
950		\N		\N	\N	\N	495	\N
950		\N		\N	\N	\N	592	\N
904		\N		\N	\N	\N	562	\N
866		\N		\N	\N	\N	609	\N
563		\N		\N	\N	\N	620	\N
563		\N		\N	\N	\N	636	\N
515		\N		\N	\N	\N	637	\N
891		\N		\N	\N	\N	574	\N
674		\N		\N	\N	\N	508	\N
674		\N		\N	\N	\N	638	\N
629		\N		\N	\N	\N	639	\N
717		\N		\N	\N	\N	560	\N
717		\N		\N	\N	\N	640	\N
820		\N		\N	\N	\N	641	\N
859		\N		\N	\N	\N	642	\N
859		\N		\N	\N	\N	499	\N
881		\N		\N	\N	\N	643	\N
999		\N		\N	\N	\N	644	\N
539		\N		\N	\N	\N	645	\N
871		\N		\N	\N	\N	646	\N
880		\N		\N	\N	\N	647	\N
959		\N		\N	\N	\N	648	\N
818		\N		\N	\N	\N	649	\N
974		\N		\N	\N	\N	650	\N
790		\N		\N	\N	\N	651	\N
804		\N		\N	\N	\N	652	\N
846		\N		\N	\N	\N	653	\N
731		\N		\N	\N	\N	654	\N
634		\N		\N	\N	\N	655	\N
783		\N		\N	\N	\N	656	\N
857		\N		\N	\N	\N	657	\N
607		\N		\N	\N	\N	658	\N
770		\N		\N	\N	\N	659	\N
760		\N		\N	\N	\N	660	\N
812		\N		\N	\N	\N	661	\N
529		\N		\N	\N	\N	662	\N
777		\N		\N	\N	\N	663	\N
970		\N		\N	\N	\N	664	\N
801		\N		\N	\N	\N	665	\N
912		\N		\N	\N	\N	666	\N
830		\N		\N	\N	\N	667	\N
645		\N		\N	\N	\N	668	\N
971		\N		\N	\N	\N	669	\N
618		\N		\N	\N	\N	670	\N
900		\N		\N	\N	\N	671	\N
975		\N		\N	\N	\N	672	\N
979		\N		\N	\N	\N	673	\N
499		\N		\N	\N	\N	674	\N
650		\N		\N	\N	\N	675	\N
628		\N		\N	\N	\N	676	\N
630		\N		\N	\N	\N	677	\N
855		\N		\N	\N	\N	678	\N
855		\N		\N	\N	\N	598	\N
653		\N		\N	\N	\N	679	\N
561		\N		\N	\N	\N	680	\N
934		\N		\N	\N	\N	681	\N
934		\N		\N	\N	\N	636	\N
773		\N		\N	\N	\N	682	\N
877		\N		\N	\N	\N	683	\N
913		\N		\N	\N	\N	684	\N
907		\N		\N	\N	\N	685	\N
923		\N		\N	\N	\N	686	\N
898		\N		\N	\N	\N	687	\N
898		\N		\N	\N	\N	646	\N
490		\N		\N	\N	\N	688	\N
491		\N		\N	\N	\N	689	\N
715		\N		\N	\N	\N	690	\N
722		\N		\N	\N	\N	691	\N
661		\N		\N	\N	\N	692	\N
701		\N		\N	\N	\N	693	\N
696		\N		\N	\N	\N	694	\N
704		\N		\N	\N	\N	695	\N
889		\N		\N	\N	\N	696	\N
914		\N		\N	\N	\N	614	\N
914		\N		\N	\N	\N	626	\N
914		\N		\N	\N	\N	696	\N
704		\N		\N	\N	\N	606	\N
875		\N		\N	\N	\N	697	\N
792		\N		\N	\N	\N	522	\N
617		\N		\N	\N	\N	698	\N
687		\N		\N	\N	\N	699	\N
657		\N		\N	\N	\N	700	\N
935		\N		\N	\N	\N	701	\N
938		\N		\N	\N	\N	702	\N
636		\N		\N	\N	\N	703	\N
576		\N		\N	\N	\N	704	\N
635		\N		\N	\N	\N	705	\N
747		\N		\N	\N	\N	706	\N
869		\N		\N	\N	\N	707	\N
884		\N		\N	\N	\N	708	\N
872		\N		\N	\N	\N	709	\N
533		\N		\N	\N	\N	710	\N
873		\N		\N	\N	\N	711	\N
534		\N		\N	\N	\N	712	\N
688		\N		\N	\N	\N	713	\N
816		\N		\N	\N	\N	714	\N
817		\N		\N	\N	\N	715	\N
824		\N		\N	\N	\N	716	\N
524		\N		\N	\N	\N	717	\N
600		\N		\N	\N	\N	718	\N
806		\N		\N	\N	\N	719	\N
517		\N		\N	\N	\N	720	\N
721		\N		\N	\N	\N	721	\N
902		\N		\N	\N	\N	722	\N
721		\N		\N	\N	\N	560	\N
623		\N		\N	\N	\N	723	\N
505		\N		\N	\N	\N	724	\N
706		\N		\N	\N	\N	725	\N
930		\N		\N	\N	\N	726	\N
781		\N		\N	\N	\N	727	\N
906		\N		\N	\N	\N	728	\N
843		\N		\N	\N	\N	729	\N
850		\N		\N	\N	\N	730	\N
843		\N		\N	\N	\N	730	\N
850		\N		\N	\N	\N	729	\N
779		\N		\N	\N	\N	731	\N
656		\N		\N	\N	\N	732	\N
838		\N		\N	\N	\N	733	\N
670		\N		\N	\N	\N	734	\N
778		\N		\N	\N	\N	735	\N
751		\N		\N	\N	\N	736	\N
995		\N		\N	\N	\N	737	\N
822		\N		\N	\N	\N	738	\N
822		\N		\N	\N	\N	656	\N
765		\N		\N	\N	\N	739	\N
765		\N		\N	\N	\N	740	\N
879		\N		\N	\N	\N	741	\N
590		\N		\N	\N	\N	742	\N
856		\N		\N	\N	\N	743	\N
631		\N		\N	\N	\N	744	\N
988		\N		\N	\N	\N	745	\N
601		\N		\N	\N	\N	746	\N
664		\N		\N	\N	\N	747	\N
726		\N		\N	\N	\N	748	\N
560		\N		\N	\N	\N	749	\N
507		\N		\N	\N	\N	750	\N
565		\N		\N	\N	\N	751	\N
694		\N		\N	\N	\N	752	\N
694		\N		\N	\N	\N	605	\N
947		\N		\N	\N	\N	753	\N
947		\N		\N	\N	\N	709	\N
937		\N		\N	\N	\N	754	\N
714		\N		\N	\N	\N	755	\N
676		\N		\N	\N	\N	756	\N
874		\N		\N	\N	\N	757	\N
685		\N		\N	\N	\N	758	\N
853		\N		\N	\N	\N	759	\N
833		\N		\N	\N	\N	760	\N
523		\N		\N	\N	\N	761	\N
586		\N		\N	\N	\N	762	\N
586		\N		\N	\N	\N	522	\N
792		\N		\N	\N	\N	762	\N
587		\N		\N	\N	\N	763	\N
892		\N		\N	\N	\N	764	\N
984		\N		\N	\N	\N	765	\N
596		\N		\N	\N	\N	766	\N
994		\N		\N	\N	\N	767	\N
828		\N		\N	\N	\N	768	\N
867		\N		\N	\N	\N	769	\N
675		\N		\N	\N	\N	770	\N
492		\N		\N	\N	\N	771	\N
861		\N		\N	\N	\N	772	\N
983		\N		\N	\N	\N	773	\N
957		\N		\N	\N	\N	774	\N
798		\N		\N	\N	\N	775	\N
799		\N		\N	\N	\N	776	\N
510		\N		\N	\N	\N	777	\N
732		\N		\N	\N	\N	778	\N
808		\N		\N	\N	\N	779	\N
796		\N		\N	\N	\N	780	\N
796		\N		\N	\N	\N	779	\N
808		\N		\N	\N	\N	780	\N
797		\N		\N	\N	\N	781	\N
493		\N		\N	\N	\N	782	\N
665		\N		\N	\N	\N	783	\N
890		\N		\N	\N	\N	784	\N
528		\N		\N	\N	\N	785	\N
498		\N		\N	\N	\N	786	\N
956		\N		\N	\N	\N	787	\N
954		\N		\N	\N	\N	788	\N
945		\N		\N	\N	\N	787	\N
1004		\N		\N	\N	\N	779	\N
557		\N		\N	\N	\N	770	\N
763		\N		\N	\N	\N	506	\N
743		\N		\N	\N	\N	624	\N
743		\N		\N	\N	\N	703	\N
743		\N		\N	\N	\N	721	\N
743		\N		\N	\N	\N	749	\N
743		\N		\N	\N	\N	564	\N
733		\N		\N	\N	\N	789	\N
591		\N		\N	\N	\N	514	\N
591		\N		\N	\N	\N	594	\N
597		\N		\N	\N	\N	594	\N
929		\N		\N	\N	\N	667	\N
929		\N		\N	\N	\N	787	\N
519		\N		\N	\N	\N	542	\N
519		\N		\N	\N	\N	732	\N
719		\N		\N	\N	\N	790	\N
963		\N		\N	\N	\N	791	\N
550		\N		\N	\N	\N	792	\N
1002		\N		\N	\N	\N	793	\N
852		\N		\N	\N	\N	794	\N
725		\N		\N	\N	\N	625	\N
764		\N		\N	\N	\N	795	\N
566		\N		\N	\N	\N	786	\N
752		\N		\N	\N	\N	796	\N
757		\N		\N	\N	\N	797	\N
719		\N		\N	\N	\N	797	\N
559		\N		\N	\N	\N	798	\N
844		\N		\N	\N	\N	799	\N
754		\N		\N	\N	\N	800	\N
545		\N		\N	\N	\N	801	\N
734		\N		\N	\N	\N	802	\N
512		\N		\N	\N	\N	803	\N
978		\N		\N	\N	\N	804	\N
791		\N		\N	\N	\N	805	\N
773		\N		\N	\N	\N	673	\N
773		\N		\N	\N	\N	805	\N
767		\N		\N	\N	\N	806	\N
756		\N		\N	\N	\N	807	\N
989		\N		\N	\N	\N	808	\N
932		\N		\N	\N	\N	809	\N
905		\N		\N	\N	\N	810	\N
794		\N		\N	\N	\N	811	\N
766		\N		\N	\N	\N	812	\N
958		\N		\N	\N	\N	813	\N
964		\N		\N	\N	\N	814	\N
966		\N		\N	\N	\N	815	\N
642		\N		\N	\N	\N	816	\N
759		\N		\N	\N	\N	817	\N
780		\N		\N	\N	\N	818	\N
761		\N		\N	\N	\N	819	\N
771		\N		\N	\N	\N	820	\N
579		\N		\N	\N	\N	821	\N
810		\N		\N	\N	\N	822	\N
973		\N		\N	\N	\N	823	\N
811		\N		\N	\N	\N	824	\N
500		\N		\N	\N	\N	825	\N
697		\N		\N	\N	\N	826	\N
1009		\N		\N	\N	\N	827	\N
827		\N		\N	\N	\N	828	\N
762		\N		\N	\N	\N	829	\N
736		\N		\N	\N	\N	830	\N
997		\N		\N	\N	\N	831	\N
893		\N		\N	\N	\N	832	\N
640		\N		\N	\N	\N	833	\N
823		\N		\N	\N	\N	834	\N
955		\N		\N	\N	\N	835	\N
666		\N		\N	\N	\N	836	\N
720		\N		\N	\N	\N	837	\N
993		\N		\N	\N	\N	838	\N
954		\N		\N	\N	\N	839	\N
793		\N		\N	\N	\N	840	\N
851		\N		\N	\N	\N	841	\N
851		\N		\N	\N	\N	842	\N
508		\N		\N	\N	\N	843	\N
692		\N		\N	\N	\N	844	\N
692		\N		\N	\N	\N	845	\N
755		\N		\N	\N	\N	846	\N
1008		\N		\N	\N	\N	847	\N
949		\N		\N	\N	\N	848	\N
\.


--
-- Name: t_bunrui_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_bunrui
    ADD CONSTRAINT t_bunrui_pkey PRIMARY KEY (bunrui_no);


--
-- Name: t_index_char_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_index_char
    ADD CONSTRAINT t_index_char_pkey PRIMARY KEY (id);


--
-- Name: t_inst_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_inst_photo
    ADD CONSTRAINT t_inst_photo_pkey PRIMARY KEY (id);


--
-- Name: t_instance_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_instance
    ADD CONSTRAINT t_instance_pkey PRIMARY KEY (id);


--
-- Name: t_scene_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_scene
    ADD CONSTRAINT t_scene_pkey PRIMARY KEY (id);


--
-- Name: t_usage_classified_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT t_usage_classified_rel_pkey PRIMARY KEY (usage_id, classified_id);


--
-- Name: t_usage_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_pkey PRIMARY KEY (id);


--
-- Name: t_usage_inst_rel_usage_id_key; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel_usage_id_key UNIQUE (usage_id, inst_id);


--
-- Name: t_usage_photo_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_photo
    ADD CONSTRAINT t_usage_photo_pkey PRIMARY KEY (id);


--
-- Name: t_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage
    ADD CONSTRAINT t_usage_pkey PRIMARY KEY (usage_id);


--
-- Name: t_usage_scene_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT t_usage_scene_rel_pkey PRIMARY KEY (usage_id, scene_id);


--
-- Name: t_word_inst_rel_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_word_inst_rel_pkey PRIMARY KEY (word_id, token, pos, inst_id);


--
-- Name: t_word_pkey; Type: CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_word
    ADD CONSTRAINT t_word_pkey PRIMARY KEY (id);


--
-- Name: inst_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT inst_usage_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: scene_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT scene_usage_rel FOREIGN KEY (scene_id) REFERENCES t_scene(id);


--
-- Name: t_instance_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT t_instance_rel FOREIGN KEY (inst_id) REFERENCES t_instance(id);


--
-- Name: t_usage_inst_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_inst_rel
    ADD CONSTRAINT t_usage_inst_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_class_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_classified_rel
    ADD CONSTRAINT usage_class_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: usage_scene_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_usage_scene_rel
    ADD CONSTRAINT usage_scene_rel FOREIGN KEY (usage_id) REFERENCES t_usage(usage_id);


--
-- Name: word_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
--

ALTER TABLE ONLY t_word_inst_rel
    ADD CONSTRAINT word_rel FOREIGN KEY (word_id) REFERENCES t_word(id);


--
-- Name: word_usage_rel; Type: FK CONSTRAINT; Schema: public; Owner: ko
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

