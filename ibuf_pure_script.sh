#######SYSBENCH_MYSQL _ Auto excution script###############
# Not need the prepare phase and clean up phase each time.#
###########################################################


#./mysql_prepare.sh
#sleep 1

for i in 1 2 3 4
do

if [ 1 -eq 0 ]; then
if [ ! -d /home/som/ibuf_test_db/data/sbtest ]; then
echo copy clean data
#cd /home/som/ibuf_test_db/data_pure
#cp -r ../bk/sbtest_bk/ ./sbtest
cd /home/som/ibuf_hdd_data/
cp -r sbtest/ /home/som/ibuf_test_db/data/
echo copy done
fi

#phase 2 : check if log dir is empty or not
if [ -e /home/som/pgdata2/SSD/mysql_log/ib_logfile0 ]; then
	rm /home/som/pgdata2/SSD/mysql_log/*
	echo delete log file
fi
fi

echo try to turn on server
#cd ~/work_git/som_git/ibuf/pure_build/bin
if [[ ${i} -eq 1 || ${1} -eq 3 ]]; then
mysqld_safe &
else
cd /home/som/workspace/mysql/bin
mysqld_safe --defaults-file=../my_2.cnf &
fi

while [ ! -S "/tmp/mysql.sock" ]
do
echo "Socket file is not exists wait until server start"
sleep 1
done

echo turn on

cd ~/sysbench
./mysql_pure_test.sh ${i}

sleep 1

#cd ~/work_git/som_git/ibuf/pure_build/bin
mysqladmin shutdown -u root
sleep 1
sudo sysctl -w vm.drop_caches=3
sleep 1

echo ${i} trial


#remove logfile
#rm /home/som/pgdata2/SSD/mysql_log/*

if [ 1 -eq 0 ]; then
echo clean data
cd /home/som/ibuf_test_db/data
rm -r sbtest/
#cp -r sbtest_bk/ ./sbtest
echo clean done
fi

done
#./mysql_cleanup.sh

