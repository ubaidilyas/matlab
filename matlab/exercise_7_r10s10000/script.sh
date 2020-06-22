#!/bin/sh
total_mean=0;
total_users=0;



while IFS=, read -r run repetition module name count sumweights mean stddev min max; do
	echo ${mean} >> total_mean_${repetition}.txt
done <throughput.csv

total_users= `wc -l total_mean_0a.txt | grep -Eo '[0-9]{1,4}' | head -n 1` 


while IFS= read -r mean ; do
	echo ${mean} >> total_mean_${repetition}.txt
total_users_${repetition}=$((total_users+1));
done <throughput.csv