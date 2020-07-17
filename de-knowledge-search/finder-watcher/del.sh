#!/bin/bash

rm -fr *.txt

curl -XDELETE http://192.168.0.56:9200/5a8ufnn5k35w2dm6k35w2dm5
echo ""
sleep 1

rm db/*
echo ""

rm -fr /home/ivsryans/.config/hamonikr_finder/indexingFile
rm -fr /home/ivsryans/.config/hamonikr_finder/finder_config
rm -fr /home/ivsryans/.config/hamonikr_finder/pr_finder_config
rm -fr /home/ivsryans/.config/hamonikr_finder/public_indexingFile

sleep 1

#node app.js
#echo ""

