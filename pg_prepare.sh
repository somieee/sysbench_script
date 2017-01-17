#SYSBENCH PREPARE FOR POSTGRES
#TEST SET = { common.lua, delete.lua, insert.lua, oltp.lua, oltp_simple.lua, select.lua, select_random_points.lua, select_random_ranges.lua, update_index.lua, update_non_index.lau }

#SELECT="select.lua \
#		select_random_points.lua \
#		select_random_ranges.lua"

NUM_THREAD=16
SYSBENCH_DIR=${HOME}/sysbench
TEST_DIR=${SYSBENCH_DIR}/sysbench/tests/db
OLTP_TEST=${TEST_DIR}/oltp_pgsql.lua
#SELECT_TEST=${TEST_DIR}/select.lua
#SELECT_TEST=${TEST_DIR}/select_random_ranges.lua
#SELECT_TEST=${TEST_DIR}/select_random_points.lua

TEST=${OLTP_TEST}

sysbench \
	--test=${TEST} \
	--pgsql-user=som \
	--pgsql-db=sysbench \
	--db-driver=pgsql \
	--oltp-table-size=10000000 \
	--num-thread=${NUM_THREADS} \
	--oltp-read-only=off \
	prepare
	
#--oltp-dist-type=uniform \
#--oltp-read-only=on \
#--oltp-tables-count=16 \

