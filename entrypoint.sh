#!/bin/bash

/usr/bin/python /opt/jinja-snorby-conf.py > /var/www/html/snorby/config/database.yml

if [ "$DELETEDB" != "false" ]; then
   if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ] && [ -n "$MYSQL_HOST" ] && [ -n "$MYSQL_DBNAME" ]; then
	$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "drop database $MYSQL_DBNAME;")
	echo "drop database $MYSQL_DBNAME DONE"
	exit 0
   else
	echo "Deleting DB FAILED : ENV VARIABLE MISSING :
	Please check if you have the following ENV setup : 
	- --env DELETEDB 
	- --env MYSQL_USER
	- --env MYSQL_PASSWORD 
	- --env MYSQL_HOST 
	- --env MYSQL_DBNAME"
   fi
	
fi
if [ "$ADD_DBUSER" != "false" ]; then
   if [ -n "$MYSQL_ADMIN" ] && [ -n "$MYSQL_ADMINPASS" ] && [ -n "$MYSQL_HOST" ] && [ -n "$MYSQL_DBNAME" ] && [ -n "$MYSQL_PASSWORD" ] && [ -n "$MYSQL_USER" ]; then
	$(/usr/bin/mysql -u$MYSQL_ADMIN -p$MYSQL_ADMINPASS -h $MYSQL_HOST -e "create database $MYSQL_DBNAME;")
	$(/usr/bin/mysql -u$MYSQL_ADMIN -p$MYSQL_ADMINPASS -h $MYSQL_HOST -e "GRANT ALL PRIVILEGES ON $MYSQL_DBNAME.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';")
	$(/usr/bin/mysql -u$MYSQL_ADMIN -p$MYSQL_ADMINPASS -h $MYSQL_HOST -e "FLUSH PRIVILEGES;")
	echo "create database $MYSQL_DBNAME and GRANT ALL PRIVILEGES TO '$MYSQL_USER' DONE"
	exit 0
   else
	echo "Add privilege user FAILED : ENV VARIABLE MISSING :
	Please check if you have the following ENV setup : 
	- --env ADD_DBUSER
	- --env MYSQL_ADMIM 
	- --env MYSQL_ADMINPASS 
	- --env MYSQL_HOST 
	- --env MYSQL_DBNAME 
	- --env MYSQL_PASSWORD 
	- --env MYSQL_USER"
   fi

fi

if [ "$INSTALLDB" != "false" ]; then
   if [ -n "$MYSQL_HOST" ] && [ -n "$MYSQL_DBNAME" ] && [ -n "$MYSQL_PASSWORD" ] && [ -n "$MYSQL_USER" ]; then
	bundle exec rake snorby:setup
	rails runner "Snorby::Jobs::GeoipUpdatedbJob.new(true).perform"
	apache2ctl -D FOREGROUND
	exit 0
   else
	echo "Creating DB FAILED : ENV VARIABLE MISSING :
	Please check if you have the following ENV setup : 
	- --env INSTALLDB
	- --env MYSQL_HOST 
	- --env MYSQL_DBNAME 
	- --env MYSQL_PASSWORD 
	- --env MYSQL_USER"
   fi

fi


if [ "$RESETDB" != "false" ]; then
   if [ -n "$MYSQL_HOST" ] && [ -n "$MYSQL_DBNAME" ] && [ -n "$MYSQL_PASSWORD" ] && [ -n "$MYSQL_USER" ]; then
        $(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.agent_asset_names;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop view $MYSQL_DBNAME.aggregated_events;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.asset_names;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.caches;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.classifications;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.data;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.delayed_jobs;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.detail;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.encoding;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.event;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop view $MYSQL_DBNAME.events_with_join;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.favorites;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.icmphdr;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.iphdr;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.lookups;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.notes;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.notifications;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.opt;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.reference;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.reference_system;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.schema;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.search;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.sensor;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.settings;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.severities;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.sig_class;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.sig_reference;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.signature;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.tcphdr;")
$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -D $MYSQL_DBNAME -e "drop table $MYSQL_DBNAME.udphdr;")
	bundle exec rake snorby:setup
	rails runner "Snorby::Jobs::GeoipUpdatedbJob.new(true).perform"
        #$(/usr/bin/mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h $MYSQL_HOST -e "drop table $MYSQL_DBNAME.$MYSQL_DBNAME.agent_asset_names; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.aggregated_events; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.asset_names; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.caches; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.classifications; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.data; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.delayed_jobs; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.detail; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.encoding; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.event; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.events_with_join; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.favorites; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.icmphdr; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.iphdr; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.lookups; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.notes; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.notifications; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.opt; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.reference; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.reference_system; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.schema; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.search; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.sensor; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.settings; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.severities; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.sig_class; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.sig_reference; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.signature; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.tcphdr; drop table $MYSQL_DBNAME.$MYSQL_DBNAME.udphdr;")
   else
        echo "Resetting DB FAILED : ENV VARIABLE MISSING :
        Please check if you have the following ENV setup :
        - --env RESETDB
        - --env MYSQL_HOST
        - --env MYSQL_DBNAME
        - --env MYSQL_PASSWORD
        - --env MYSQL_USER"
   fi


fi
#rails runner "Snorby::Worker.restart;Snorby::Jobs::SensorCacheJob.new(true).perform;Snorby::Jobs::DailyCacheJob.new(true).perform;Snorby::Jobs.clear_cache;Snorby::Jobs.run_now!"
rails runner "Snorby::Worker.restart"
rails runner "Snorby::Jobs::SensorCacheJob.new(true).perform"
#rails runner "Snorby::Jobs::DailyCacheJob.new(true).perform"
rails runner "Snorby::Jobs::GeoipUpdatedbJob.new(true).perform"
rails runner "Snorby::Jobs.clear_cache"
rails runner "Snorby::Jobs.run_now!"

/usr/sbin/apache2 -DFOREGROUND
