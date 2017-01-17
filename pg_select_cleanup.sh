#SYSBENCH CLEAN UP

TEST_DIR=${HOME}/sysbench/sysbench/tests/db

sysbench --test=${TEST_DIR}/select.lua --pgsql-socket=/tmp --pgsql-user=som --pgsql-db=sysbench --db-driver=pgsql cleanup
