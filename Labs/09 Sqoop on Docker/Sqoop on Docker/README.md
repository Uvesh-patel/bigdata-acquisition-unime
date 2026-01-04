Here’s an improved and better-formatted version of your guide:

---

# **Sqoop on Docker with Hadoop and MySQL**

A short guide on running Sqoop on Docker.

---

## **Requirements**

- **Docker**
- **JDBC Driver for MySQL**: [Download the MySQL JDBC Driver](https://dev.mysql.com/downloads/connector/j/?os=26)

---

## **Steps**

### **1. Save the `docker-compose.yaml` file**

Create a `docker-compose.yaml` file with the following content:

```yaml
version: '3.7'

services:
  db:
    image: mysql:latest
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_DATABASE: test
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - ./mysql_data:/var/lib/mysql
    ports:
      - "3306:3306"
    networks:
      - app_network

  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    restart: always
    depends_on:
      - db
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: password
    ports:
      - "8080:80"
    networks:
      - app_network

networks:
  app_network:
    driver: bridge
```

> Feel free to modify the MySQL user, database, and password, but ensure you update all references in subsequent steps. Note that is important to create a database. For reference import via PhpMyAdmin the `employees.sql` file.

---

### **2. Download the MySQL JDBC Driver**

Download the JDBC driver for MySQL and save it to a local folder. You’ll mount this folder to the Sqoop container later.

---

### **3. Run the `docker-compose`**

Navigate to the folder where you saved the `docker-compose.yaml` file and execute:

```bash
docker compose up -d
```

- The `-d` flag runs the containers in detached mode.
- The services `db` (MySQL) and `phpmyadmin` (optional) are now running.

---

### **4. Run Sqoop with the JDBC Driver**

Use the following command to run a Sqoop container with the JDBC driver mounted:

```bash
docker run -v /path/to/jdbc:/jdbc --network <app_network_name> -it dvoros/sqoop:latest
```

- Replace `/path/to/jdbc` with the folder containing the downloaded JDBC driver.
- Replace `<app_network_name>` with `app_network` (or the name defined in your `docker-compose.yaml`).

---

### **5. Access the Sqoop container**

To enter the Sqoop container, run:

```bash
docker exec -it <sqoop_container_id> bash
```

You can now execute Sqoop commands within the container.

---

### **6. Import a table from MySQL to HDFS**

To import a table using Sqoop, run:

```bash
sqoop import \
  --connect jdbc:mysql://db/test \
  --table <table_name> \
  --username <username> \
  --password <password> \
  --target-dir /path/to/tableName
```

#### Example:
```bash
sqoop import \
  --connect jdbc:mysql://db/test \
  --table employees \
  --username user \
  --password password
```

> The target directory will be created automatically with the same name as the table.

---

### **7. Check the imported data on HDFS**

To list the contents of the HDFS directory:

```bash
hdfs dfs -ls /path/to/tableName
```

---

### **8. Export a table from HDFS to MySQL**

To export data from HDFS back to MySQL:

```bash
sqoop export \
  --connect jdbc:mysql://db/test \
  --table <table_name> \
  --username <username> \
  --password <password> \
  --export-dir /path/to/tableName
```

#### Example:
```bash
sqoop export \
  --connect jdbc:mysql://db/test \
  --table employees \
  --username user \
  --password password \
  --export-dir /employees
```

---

### **9. Verify the MySQL database**

Check the MySQL database to ensure the table was successfully imported or exported.

You can use `phpMyAdmin` (running at `http://localhost:8080`) or any MySQL client to verify the data.

---

### **10. Stop the containers**

To stop the running containers:

```bash
docker compose down
```

If you want to remove the associated volumes as well, add the `-v` flag:

```bash
docker compose down -v
```

---

### **Notes**

- Ensure the JDBC driver is compatible with your MySQL version.
- Use the proper permissions for the MySQL user to allow access from the Sqoop container.

This setup lets you seamlessly transfer data between MySQL and HDFS using Sqoop on Docker!