Data here is made as follows:

mkdir tufsdata
cd tufsdata
wget -nd -i http://www.coelang.tufs.ac.jp/mt/vmod/ index.html
unzip '*.zip'
for f in *.dump; do pg_restore ${f} > `basename ${f} .dump`.sql; done
rm *.dump *.zip


