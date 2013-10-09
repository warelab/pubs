DBNAME=warepubs
SCHEMA='./pub-schema.sql'
DBHOST=cabot

echo "Creating $DBNAME"
mysqladmin drop -f -h $DBHOST $DBNAME
mysqladmin create -h $DBHOST $DBNAME

echo "Loading $SCHEMA"
mysql -h $DBHOST $DBNAME < $SCHEMA

echo "Loading data"
perl ./insert.pl pub.txt $DBNAME

#echo "Making DB model"
#../script/warepubs_create.pl model DB DBIC::Schema WarePubs::Schema create=static dbi:mysql:warepubs kclark 'g0p3rl!'
#
#rm ../lib/WarePubs/Model/DB.pm.new
#
#echo "Making ER diagram"
#sqlt-graph --color -d MySQL $SCHEMA > pub-schema.png
#
#echo "All done!"
