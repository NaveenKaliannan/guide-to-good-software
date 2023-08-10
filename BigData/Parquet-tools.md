# Parquet 
### Visualizing parquet file via Parquet-tools
```
parquet-tools schema filename.parquet
parquet-tools cat -j filename.parquet
parquet-tools cat -j filename.parquet | jq .key1.key2
parquet-tools cat -j filename.parquet | jq '.value'
parquet-tools cat -j filename.parquet | jq -r '.value' | jq '.whatever' (the -r argument changes strings to json)
parquet-tools cat -j filename.parquet | jq -r '.value' | jq '.whatever' (the -r argument changes strings to json)
```
### Parquet to Json
```
pt cat -json *.parquet >> filename.json (easy for handling in python)
pt cat --json filename.snappy.parquet | jq | tee filename.json
```
Converting all the parquet files in folder into a single json file
```
for i in *.parquet ; do pt cat -json $i | jq >> filename.json ; done
```
Select numbers in the lines and sort them
```
cat  filename  | tr '\n' ' ' | sed -e 's/[^0-9]/ /g' -e 's/^ *//g' -e 's/ *$//g' | tr -s ' ' | sed 's/ /\n/g' |sort
```
### Rosbag visualization
```
import bagpy
from bagpy import bagreader
import numpy as np
import pandas as pd
b = bagreader('filename.bag')
print(b.topic_table)
print(b.bagfile)
LASER_MSG = b.message_by_topic('topic')
LASER_MSG
df_laser = pd.read_csv(LASER_MSG)
print(df_laser)
```
### Parquet to Parquet via Python Pandas (Breaks schema)
```
import pandas as pd
import pyarrow
import fastparquet
from IPython.display import display
pd.set_option('display.max_columns', None)  # or 1000
pd.set_option('display.max_rows', None)  # or 1000
pd.set_option('display.max_colwidth', None)  # or 199
parquet_file = "part-00000-e847b0d0-27b2-41ef-a0f7-5bba23e39277-c000.snappy.parquet"
df = pd.read_parquet(parquet_file, engine='pyarrow')
for i in range(4):
    df.drop(index=df.index[0], axis=0, inplace=True)
df.to_parquet('6-dataframes.parquet')
```
### Parquet to Parquet via PySpark (Schema is conserved)
```
from pyspark.sql import SparkSession
import pyspark.sql.functions as F
spark = SparkSession \
    .builder \
    .appName("Parquet to Parquet") \
    .config("spark.some.config.option", "some-value") \
    .getOrCreate()
# read csv
df = spark.read.parquet("filename.snappy.parquet")
# Displays the content of the DataFrame to stdout
df.show()
df1 = df.limit(3)
df.write.parquet("test.parquet")
#print(df.columns)
#df = df.dropDuplicates()
#df.write.parquet("test.parquet")
```
### Json to Parquet (Breaks schema)
```
from pyspark.sql import SparkSession

spark = SparkSession \
    .builder \
    .appName("JsonToParquetPysparkExample") \
    .getOrCreate()

#json_df = spark.read.json("test/*.json", multiLine=True,) 
json_df = spark.read.option("multiline","true").json("test/*.json")
json_df.printSchema()
json_df.show()
json_df.repartition(1).write.mode("append").parquet("output.parquet")
```
