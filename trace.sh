#!/bin/sh

set -x
files="ram"
trace_dir=/home/som/sysbench/
plotting=1
j=128

if [ ! -d ${trace_dir}plot_timestamp ]
then
    mkdir ${trace_dir}plot_timestamp
fi
if [ ! -d ${trace_dir}plot_seq ]
then
    mkdir ${trace_dir}plot_seq
fi

seq=0;

for file in ${files}
do 
for i in 1 #1 2 3 4 5 6 7 8 9 10 50 #4 8 16 32 64 128
do
echo $file
#cp ${file} ${file}_temp;
        # blkparse -i ${trace_dir}${file} -o temp;
        # awk format = <R|W, lsn, sect_cnt, timestamp, sequence_num>
        egrep '(D[[:space:]]+W|D[[:space:]]+R)' ${trace_dir}${file} | awk '{printf "%d,%d\n",$8, $10}' > ${trace_dir}${file}_RW;
        grep "R" ${trace_dir}${file}_RW > ${trace_dir}${file}_R
        grep "W" ${trace_dir}${file}_RW > ${trace_dir}${file}_W
done
done
