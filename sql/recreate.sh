DBNAME=warepubs
SCHEMA='./pub-schema.sql'

echo "Creating $DBNAME"
mysqladmin drop -f $DBNAME
mysqladmin create $DBNAME

echo "Loading $SCHEMA"
mysql $DBNAME < $SCHEMA

echo "Loading data"
perl ./insert.pl pub.txt $DBNAME

#./script/warepubs_create.pl model DB DBIC::Schema WarePubs::Schema create=static dbi:mysql:warepubs kclark 'g0p3rl!'
