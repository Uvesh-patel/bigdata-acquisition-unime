# Big Data Acquisition - Course Notes

> **Master's Degree in Data Science**  
> **University of Messina - Academic Year 2024-25**

---

## Topic 1: What Is Big Data?

### Simple Definition

**Big Data** refers to data that is **too large, too fast, or too complex** to be handled by traditional data processing systems (like Excel, or even basic SQL databases).

It's not just about size — it's about **how much**, **how fast**, and **how complex** the data is.

### The 5 Vs of Big Data

| V | Name | Meaning | Example |
|---|------|---------|---------|
| 1️⃣ | **Volume** | Huge size of data | Netflix logs millions of watch hours per day |
| 2️⃣ | **Velocity** | Speed of incoming data | Twitter gets ~6,000 tweets/second |
| 3️⃣ | **Variety** | Different types of data | Text, images, video, logs, sensor data |
| 4️⃣ | **Veracity** | Trustworthiness of data | Fake reviews, typos, duplicates |
| 5️⃣ | **Value** | Can you gain insight from it? | Knowing what customers like = higher sales |

### The Big Data Pipeline

```
Data Source → Ingestion → Storage → Processing → Visualization
     ↓           ↓          ↓          ↓            ↓
  (Logs,      (Kafka,    (HDFS,    (Spark,      (Grafana,
   APIs)      Flume)     NoSQL)    Hadoop)      Dashboards)
```

---

## Topic 2: Big Data Architectures

### Architecture Types

#### A. Batch Architecture
- Processes large chunks of data at intervals
- Good for reports, historical trends
- Tools: **Hadoop MapReduce**, **Spark (batch mode)**

#### B. Stream Architecture
- Processes data in real-time as it arrives
- Good for fraud detection, live alerts
- Tools: **Spark Streaming**, **Flink**, **Kafka Streams**

#### C. Lambda Architecture (Batch + Stream)
Combines both for accuracy AND speed:

| Layer | Purpose | Tools |
|-------|---------|-------|
| Batch | Master data accuracy | Spark, Hadoop |
| Speed | Real-time insights | Spark Streaming, Kafka |
| Serving | Query results | Hive, Impala |

---

## Topic 3: Batch vs Stream Processing

### Key Differences

| Feature | Batch | Stream |
|---------|-------|--------|
| Latency | High (minutes to hours) | Low (ms to seconds) |
| Data arrival | At intervals | Continuous |
| Fault tolerance | Easy with retries | Complex, requires checkpointing |
| Tool Examples | Hadoop, Spark (batch) | Spark Streaming, Flink |

### When to Use Each

| Goal | Recommendation |
|------|----------------|
| Historical analytics | ✅ Batch |
| Real-time insights | ✅ Stream |
| Both | ✅ Lambda Architecture |

---

## Topic 4: Apache Spark – Core Concepts

### What is Apache Spark?

**Apache Spark** is a fast and general-purpose big data processing engine. Unlike Hadoop (disk-based), **Spark keeps data in memory (RAM)** — making it up to **100x faster**.

### Core Components
1. **Spark Core** – the engine behind all operations
2. **Spark SQL** – query structured data with SQL
3. **Spark Streaming** – real-time processing
4. **MLlib** – machine learning library
5. **GraphX** – graph analytics

### Key Concepts

#### RDD (Resilient Distributed Dataset)
- Basic data unit in Spark
- **Immutable**, **fault-tolerant**, **distributed**
- Like a giant spreadsheet shared across many computers

#### DAG (Directed Acyclic Graph)
- Internal execution plan Spark builds from your code
- Spark doesn't run immediately — it builds a DAG first

#### Lazy Evaluation
- Spark **doesn't process data until it absolutely has to**
- Only **Actions** trigger execution

| Type | Examples | Triggers execution? |
|------|----------|---------------------|
| **Transformations** | map, filter, flatMap | ❌ No |
| **Actions** | collect, count, saveAsTextFile | ✅ Yes |

---

## Topic 5: Spark DataFrames

### What Is a DataFrame?
A **DataFrame** is a distributed collection of data organized into **columns** — like SQL tables or Excel spreadsheets.

### Creating a DataFrame

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("MyApp").getOrCreate()

# From CSV
df = spark.read.csv("myfile.csv", header=True, inferSchema=True)

# From list of dicts
data = [{"name": "Alice", "age": 23}, {"name": "Bob", "age": 30}]
df = spark.createDataFrame(data)
```

### Common Operations

| Operation | Example |
|-----------|---------|
| Show | `df.show(5)` |
| Filter | `df.filter(df.age > 25)` |
| Select | `df.select("name", "age")` |
| Group + agg | `df.groupBy("age").count()` |
| SQL | `spark.sql("SELECT * FROM table")` |

---

## Topic 6: Data Models in Spark

| Type | Example | Schema? | Tools |
|------|---------|---------|-------|
| Structured | CSV, SQL | Fixed | DataFrames, SQL |
| Semi-structured | JSON, XML | Flexible | Spark SQL, UDFs |
| Unstructured | Text, Audio | No | NLP, ML pipelines |

---

## Topic 7: ETL vs ELT + YARN

### ETL vs ELT

| Feature | ETL | ELT |
|---------|-----|-----|
| Transform Location | Before loading | After loading |
| Storage Required | Less | More (stores raw data) |
| Use Case | Small to medium datasets | Big Data, Cloud, Data Lakes |

### YARN (Yet Another Resource Negotiator)

YARN is like an **operating system for a Hadoop cluster** — managing resources (RAM, CPU) for different tasks.

| Component | Role |
|-----------|------|
| ResourceManager | Master — assigns jobs & tracks usage |
| NodeManager | On every worker node — executes tasks |
| ApplicationMaster | Manages each Spark or Hadoop job |

---

## Topic 8: Apache Kafka

**Apache Kafka** is a distributed messaging system for **high-throughput, real-time data streaming**.

### Workflow
```
Producer → Kafka Broker → Consumer
```

### Key Concepts

| Term | Meaning |
|------|---------|
| **Topic** | Named stream/channel (e.g. "reddit_comments") |
| **Partition** | Topic split across servers (parallelism) |
| **Offset** | Each message has a unique number |
| **Broker** | A single Kafka server |

### Kafka + Spark Streaming

```python
df = spark.readStream \
    .format("kafka") \
    .option("subscribe", "reddit_comments") \
    .load()
```

---

## Topic 9: Apache Sqoop

**Apache Sqoop** transfers data between **relational databases** (MySQL, PostgreSQL) and **Big Data systems** (HDFS, Hive).

### Import (RDBMS → Hadoop)

```bash
sqoop import \
--connect jdbc:mysql://localhost/sales \
--username root --password 123 \
--table orders \
--target-dir /data/orders \
--as-parquetfile
```

### Export (Hadoop → RDBMS)

```bash
sqoop export \
--connect jdbc:mysql://localhost/sales \
--table summary \
--export-dir /data/cleaned_summary
```

---

## Topic 10: Hadoop MapReduce

### What is MapReduce?

A programming model for processing large datasets in a distributed way:

1. **Map**: Split data and assign chunks to workers
2. **Shuffle & Sort**: Group same keys together
3. **Reduce**: Combine values

### Word Count Example

**mapper.py**
```python
import sys
for line in sys.stdin:
    for word in line.strip().split():
        print(f"{word}\t1")
```

**reducer.py**
```python
import sys
from collections import defaultdict

counts = defaultdict(int)
for line in sys.stdin:
    word, count = line.strip().split('\t')
    counts[word] += int(count)

for word, count in counts.items():
    print(f"{word}\t{count}")
```

### Running with Hadoop Streaming

```bash
hadoop jar /path/to/hadoop-streaming.jar \
  -input /user/input \
  -output /user/output \
  -mapper mapper.py \
  -reducer reducer.py
```

---

## Topic 11: Apache Flume

**Apache Flume** is designed for collecting and moving large amounts of **log data** into Hadoop.

### Architecture
```
Source → Channel → Sink
```

| Component | Role |
|-----------|------|
| **Source** | Where data comes from (e.g., web server logs) |
| **Channel** | Temporary buffer (memory or file) |
| **Sink** | Where data goes (e.g., HDFS) |

---

## Topic 12: Hadoop File Formats

| Format | Type | Best For |
|--------|------|----------|
| **CSV** | Row-based | Simple data exchange |
| **JSON** | Semi-structured | APIs, nested data |
| **Parquet** | Columnar | Analytics, Spark |
| **Avro** | Row-based + schema | Streaming, Kafka |
| **ORC** | Columnar | Hive optimization |

### Why Parquet?
- **Columnar storage** — reads only needed columns
- **Compression** — smaller file size
- **Fast analytics** — optimized for Spark queries

---

## Summary: Big Data Tools Ecosystem

| Tool | Purpose |
|------|---------|
| **HDFS** | Distributed storage |
| **Spark** | Fast processing (batch + stream) |
| **Kafka** | Real-time messaging |
| **Sqoop** | Database ↔ Hadoop transfer |
| **Flume** | Log collection |
| **Hive** | SQL on Hadoop |
| **YARN** | Resource management |

---

## Lab Exercises Summary

### 1. Word Count (MapReduce)
Classic example demonstrating distributed computation.

### 2. Inverted Index
Build a search engine index: `word → list_of_documents`

### 3. Average Temperature
Aggregate time-series data by year.

### 4. Docker Hadoop Setup
Run a complete Hadoop cluster locally using Docker Compose.

---

*These notes consolidate key concepts from the Big Data Acquisition course for exam preparation.*
