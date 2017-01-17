#SYSBENCH CLEAN UP

TEST_DIR=${HOME}/sysbench/sysbench/tests/db

#sysbench --test=${TEST_DIR}/select_random_ranges.lua --pgsql-socket=/tmp --pgsql-user=som --pgsql-db=sysbench --db-driver=pgsql cleanup
sysbench --test=${TEST_DIR}/oltp.lua --mysql-user=root --mysql-db=sbtest --db-driver=mysql --oltp-tables-count=20 cleanup

#mysqladmin shutdown -uroot
sudo sysctl -w vm.drop_caches=3

#--mysql-socket=/tmp
