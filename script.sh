#!/bin/sh


while IFS=: read -r id; do
curl --header "X-Nomad-Token: 4d67205e-b898-00c6-63ce-6ee324da5a74" http://172.21.38.9:4646/v1/node/$id > $id.json
tr , '\n' <$id.json > $id.txt
if [ `grep '"dc":"GT-DC3"' $id.txt` ]; then
azwe=$((azwe-1))
fi
rm $id.*
done <test_unique_nodes.txt