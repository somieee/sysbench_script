#SYSBENCH PREPARE FOR POSTGRES
#TEST SET = { common.lua, delete.lua, insert.lua, oltp.lua, oltp_simple.lua, select.lua, select_random_points.lua, select_random_ranges.lua, update_index.lua, update_non_index.lau }

#SELECT="select.lua \
#		select_random_points.lua \
#		select_random_ranges.lua"

NUM_THREADS=8
SYSBENCH_DIR=${HOME}/sysbench
TEST_DIR=${SYSBENCH_DIR}/sysbench/tests/db
PREPARE=${TEST_DIR}/parallel_prepare.lua
#OLTP_TEST=${TEST_DIR}/oltp.lua
#SELECT_TEST=${TEST_DIR}/select.lua
#SELECT_TEST=${TEST_DIR}/select_random_ranges.lua
#SELECT_TEST=${TEST_DIR}/select_random_points.lua

TEST=${OLTP_TEST}

#mysqld_safe --defaults-file=/home/som/my.cnf.example &

sysbench \
	--test=sysbench/tests/db/parallel_prepare.lua \
	--db-driver=pgsql \
	--pgsql-db=sysbench \
	--max-requests=0 \
	--oltp-tables-count=8 \
	--oltp-table-size=4000000 \
	--pgsql-user=som \
	--num-threads=${NUM_THREADS} \
	run



#	--num-thread=${NUM_THREADS} \
#	--oltp-dist-type=uniform \

#--oltp-read-only=on \

