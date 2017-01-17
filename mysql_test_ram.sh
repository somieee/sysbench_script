############   INTORO   ###############
# SYSBENCH FOR MYSQL_IBUF EXPERIMETS  #
# BUFFER SIZE : 10 ~ 5 % OF DATA SIZE #
# USER : CPU CORE * 2 or 4            #
# TIME SHOULD INCLUDE "WARM-UP"       #
#######################################

#TEST SET = { common.lua, delete.lua, insert.lua, oltp.lua, oltp_simple.lua, select.lua, select_random_points.lua, select_random_ranges.lua, update_index.lua, update_non_index.lau }

#SELECT="select.lua \
#		select_random_points.lua \
#		select_random_ranges.lua"

NUM_THREADS=8
SYSBENCH_DIR=/home/som/sysbench
TEST_DIR=${SYSBENCH_DIR}/sysbench/tests/db
OLTP_TEST=${TEST_DIR}/oltp.lua
#SELECT_TEST=${TEST_DIR}/select.lua
#SELECT_TEST=${TEST_DIR}/select_random_ranges.lua
#SELECT_TEST=${TEST_DIR}/select_random_points.lua
TEST=${OLTP_TEST}

sudo blktrace -d /dev/sdb1 -o mysql/blk/${1}_blk_ram &

#SET THOSE VARIABLES FOR INFORMATION SCHEMA
mysql -u root -e 'set global innodb_monitor_disable = all;'
mysql -u root -e 'set global innodb_monitor_reset_all = all;'
mysql -u root -e 'set global innodb_monitor_enable = all;'

#SET THE PROPER CONFIG AND CHECK IBUF CONFIG
if [ $1 -eq 1 ]; then
	echo $1
	mysql -u root -e 'set global innodb_change_buffering=all;'
	mysql -u root -e 'show variables like "%buffering";' > ./mysql/ibuf_stat/ibuf_on
else
	echo $1
	mysql -u root -e 'set global innodb_change_buffering=none;'
	mysql -u root -e 'show variables like "%buffering";' > ./mysql/ibuf_stat/ibuf_off
fi

#RUN SYSBENCH
sysbench \
	--test=${TEST} \
	--db-driver=mysql \
	--max-time=900 \
	--max-requests=0 \
	--mysql-table-engine=InnoDB \
	--oltp-table-size=10000000 \
	--mysql-user=root \
	--mysql-engine-trx=yes \
	--num-threads=${NUM_THREADS} \
	run

sleep 1
sudo killall -15 blktrace
sleep 1
#sudo mv *_blk* ./mysql/blk/

#GATHER IBUF_STAT INFO
mysql -u root -e 'use information_schema;'

if [ $1 -eq 1 ]; then
	echo $1
	mysql -u root -e 'select name, subsystem, count, avg_count from information_schema.innodb_metrics;' > ./mysql/ibuf_stat/ibuf_on_ram
else
	echo $1
	mysql -u root -e 'select name, subsystem, count, avg_count from information_schema.innodb_metrics;' > ./mysql/ibuf_stat/ibuf_off
fi

cd mysql/blk
sudo blkparse -i ${1}_blk_ram.blktrace.0 -o ram_blk

#mysql -u root -e 'SHOW ENGINE INNODB STATUS \G' > /home/som/mysql_out/Ibuf_ON
#	--num-threads=${NUM_THREADS} \
#	--oltp-dist-type=uniform \

#--oltp-read-only=on \

