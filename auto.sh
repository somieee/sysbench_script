#To go to dorm, auto script / Between 30th June and 1st July

#cp -r -p /home/som/ibuf_test_db/data/sbtest_bk/ /home/som/ibuf_test_db/data/sbtest
cp -r -p /home/som/ibuf_hdd_data/data/sbtest_bk/ /home/som/ibuf_test_db/data/sbtest

sleep 1

./mysql_pure_test.sh 1
