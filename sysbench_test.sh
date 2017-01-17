NUM_THREADS=16
SYSBENCH_DIR=${HOME}/sysbench
TEST_DIR=${SYSBENCH_DIR}/sysbench/tests/db
OLTP_TEST=${TEST_DIR}/oltp.lua
#SELECT_TEST=${TEST_DIR}/select.lua
#SELECT_TEST=${TEST_DIR}/select_random_ranges.lua
#SELECT_TEST=${TEST_DIR}/select_random_points.lua
TEST=${OLTP_TEST}

#RUN SYSBENCH
sysbench \
	--test=${TEST} \
	--db-driver=mysql \
	--max-time=600 \
	--max-requests=0 \
	--mysql-table-engine=InnoDB \
	--oltp-table-size=10000000 \
	--mysql-user=root \
	--mysql-engine-trx=yes \
	--num-threads=${NUM_THREADS} \
	run

