visualizing parquet file in json format
```
parquet-tools schema filename.parquet
parquet-tools cat -j filename.parquet
parquet-tools cat -j filename.parquet | jq .key1.key2
parquet-tools cat -j filename.parquet | jq '.value'
parquet-tools cat -j filename.parquet | jq -r '.value' | jq '.whatever' (the -r argument changes strings to json)
parquet-tools cat -j filename.parquet | jq -r '.value' | jq '.whatever' (the -r argument changes strings to json)
```
Converting parquet to json file
```
pt cat --json filename.snappy.parquet | jq | tee filename.json
```
Converting all the parquet files in folder into a single json file
```
for i in * ; do pt cat -json $i | jq >> filename.json ; done
```
Select numbers in the lines and sort them
```
cat  filename  | tr '\n' ' ' | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g' | tr -s ' ' | sed 's/ /\n/g' |sort
```
