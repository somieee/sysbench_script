#SYSBENCH RUN FOR POSTGRES
#TEST SET = { common.lua, delete.lua, insert.lua, oltp.lua, oltp_simple.lua, select.lua, select_random_points.lua, select_random_ranges.lua, update_index.lua, update_non_index.lau }

#SELECT_TEST="select.lua \
#			   select_random_points.lua \
#			   select_random_ranges.lua"
			   
NUM_THREADS=16
TEST_DIR=${HOME}/sysbench/sysbench/tests/db

sysbench \
		--test=${TEST_DIR}/select_random_ranges.lua \
		--oltp-table-size=10000000\
		--max-time=600 \
		--max-request=0 \
		--db-driver=pgsql \
		--pgsql_user=som \
		--pgsql_db=sysbench \
		--num-threads=${NUM_THREADS} \
		run
