#SYSBENCH CLEAN UP

TEST_DIR=${HOME}/sysbench/sysbench/tests/db

#sysbench --test=${TEST_DIR}/select_random_ranges.lua --pgsql-socket=/tmp --pgsql-user=som --pgsql-db=sysbench --db-driver=pgsql cleanup
sysbench --test=${TEST_DIR}/oltp_pgsql.lua --pgsql-socket=/tmp --pgsql-user=som --pgsql-db=sysbench --db-driver=pgsql cleanup
