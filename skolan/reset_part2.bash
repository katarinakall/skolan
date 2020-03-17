#!/usr/bin/env bash
#
# Recreate and reset the database to be as after part I.
#
echo ">>> Reset skolan to after part 2"
echo ">>> Recreate the database (as root)"
mysql -uroot -p skolan < setup.sql > /dev/null

file="ddl.sql"
echo ">>> Create tables ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="dml_insert.sql"
echo ">>> Insert into larare ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="ddl_migrate.sql"
echo ">>> Alter table larare ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="dml_update.sql"
echo ">>> Förbered lönerevision, grundlön larare ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="ddl_copy.sql"
echo ">>> Kopierar tabellen inför lönerevision ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="dml_update_lonerevision.sql"
echo ">>> Utför lönerevision ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="dml_view.sql"
echo ">>> Skapar vyer för larare ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

file="dml_join.sql"
echo ">>> Slår samman den gamla tabellen med den nya ($file)"
mysql -uuser -ppass skolan < $file > /dev/null

echo ">>> Check larare_pre: Lönesumman = 305000, Kompetens = 8."
mysql -uuser -ppass skolan -e "SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare_pre;"

echo ">>> Check Lönesumman = 330242, Kompetens = 19."
mysql -uuser -ppass skolan -e "SELECT SUM(lon) AS 'Lönesumma', SUM(kompetens) AS Kompetens FROM larare;"
