```
parquet-tools schema filename.parquet
parquet-tools cat -j filename.parquet
parquet-tools cat -j filename.parquet | jq .key1.key2
parquet-tools cat -j filename.parquet | jq '.value'
parquet-tools cat -j filename.parquet | jq -r '.value' | jq '.whatever' (the -r argument changes strings to json)
parquet-tools cat -j filename.parquet | jq -r '.value' | jq '.whatever' (the -r argument changes strings to json)
```

