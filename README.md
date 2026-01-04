# Big Data Acquisition

Course materials for the **Big Data Acquisition** module, part of the Master's Degree in **Data Science** at the **University of Messina**, Italy.

> **Academic Year: 2024-25**

---

## About the Course

Big Data Acquisition covers the fundamentals of collecting, storing, and processing large-scale data using modern distributed systems. The course focuses on the Hadoop ecosystem, Apache Spark, and real-time data streaming technologies.

### Prerequisites
- Basic knowledge of Python programming
- Understanding of SQL and databases
- Familiarity with command line operations

### Key Technologies Covered
- **Apache Hadoop** (HDFS, MapReduce, YARN)
- **Apache Spark** (Core, SQL, Streaming)
- **Apache Kafka** (Real-time messaging)
- **Apache Sqoop** (Database integration)
- **Apache Flume** (Log collection)
- **Docker** (Containerized big data environments)

---

## Repository Structure

```
├── Course-Notes.md                      # Complete study guide (12 topics)
├── Project-Reddit-BigData-Analysis.pdf  # Project report with benchmarks
├── Lectures/                            # Lecture slides (PDF)
│   ├── 01_Intro.pdf
│   ├── 02_Intro.pdf
│   ├── 03_Spark.pdf
│   ├── 04_Syntax.pdf
│   ├── 05 Data_Models.pdf
│   ├── 06 ETL VS ELT and YARN.pdf
│   ├── 07 Kafka.pdf
│   ├── 08 Sqoop.pdf
│   ├── 10 Flume.pdf
│   └── 11 Hadoop_File_Formats.pdf
└── Labs/                   # Lab materials and exercises
    ├── 02 MapReduce/       # Hadoop MapReduce with Python
    ├── 09 Sqoop on Docker/ # Sqoop Docker setup
    └── 09 Sqoop Docker Lab/# Additional Sqoop materials
```

---

## Topics Covered

1. **Introduction to Big Data** - The 5 Vs, pipelines, and challenges
2. **Big Data Architectures** - Batch, Stream, and Lambda architectures
3. **Batch vs Stream Processing** - When to use each approach
4. **Apache Spark Core** - RDDs, DAGs, lazy evaluation
5. **Spark DataFrames & SQL** - Structured data processing
6. **Data Models** - Structured, semi-structured, unstructured
7. **ETL vs ELT** - Data transformation strategies
8. **YARN** - Resource management in Hadoop
9. **Apache Kafka** - Real-time data streaming
10. **Apache Sqoop** - Database-Hadoop integration
11. **Apache Flume** - Log data collection
12. **Hadoop File Formats** - CSV, JSON, Parquet, Avro, ORC

---

## Lab Exercises

### MapReduce Labs
- **Word Count** - Classic distributed word counting
- **Inverted Index** - Building a search engine index
- **Average Temperature** - Time-series aggregation
- **Hadoop Streaming with Python** - Using Python for MapReduce jobs

### Docker Labs
- Setting up a Hadoop cluster with Docker Compose
- Running Sqoop in containerized environments
- HDFS and YARN web interfaces

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| **HDFS** | Distributed file storage |
| **Spark** | Fast batch and stream processing |
| **Kafka** | Real-time messaging and streaming |
| **Sqoop** | Database ↔ Hadoop data transfer |
| **Flume** | Log data collection |
| **Hive** | SQL queries on Hadoop |
| **YARN** | Cluster resource management |
| **Docker** | Containerized development environments |

---

## University Information

**University of Messina (Università degli Studi di Messina)**  
Piazza Pugliatti, 1 - 98122 Messina, Italy

---

## Disclaimer

These materials are shared for educational purposes. All rights belong to their respective authors and the University of Messina.

---

## License

This repository is for personal educational use only. Please respect copyright and intellectual property rights.
