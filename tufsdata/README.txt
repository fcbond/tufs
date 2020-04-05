Data here is made as follows:

SQL files:

mkdir tufsdata
cd tufsdata
wget -nd -i http://www.coelang.tufs.ac.jp/mt/vmod/ index.html
unzip '*.zip'
for f in *.dump; do pg_restore ${f} > `basename ${f} .dump`.sql; done
rm *.dump *.zip


License for the data is CC-BY 4.0 (see
http://www.coelang.tufs.ac.jp/mt/vmod/).
Accessed 2020-01-21


bunrui_names.tsv contains names for the level two of the bunrui
thesaurus, in Englihs, Malay, Myanmar and Japanese
(extracted from the TUFS data)

Code	en	ms	my	ja
1.10	Matters	Hal	အကြောင်း	事柄
1.11	Classification	Penggolongan	အမျိုးအစား	類
