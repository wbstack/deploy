## General use

### Find wiki name from db name

```
SELECT dbs.name, wikis.domain
FROM wiki_dbs as dbs
LEFT JOIN wikis ON wiki_id = wikis.id
WHERE name = 'mwdb_f54ee1d8d6'
LIMIT 50
```

## Cleanup

### Queries to, Truncate all wb_changes tables with rows

```
SELECT
CONCAT('TRUNCATE TABLE ', CONCAT( TABLE_SCHEMA , ".", TABLE_NAME),';') AS command
FROM information_schema.tables
WHERE TABLE_SCHEMA LIKE 'mwdb_%'
AND TABLE_NAME LIKE '%_wb_changes'
AND TABLE_ROWS != 0
ORDER BY TABLE_ROWS DESC
```
### Queries to, Optimize all wb_changes tables

```
SELECT
CONCAT('OPTIMIZE TABLE ', CONCAT( TABLE_SCHEMA , ".", TABLE_NAME),';') AS command
FROM information_schema.tables
WHERE TABLE_SCHEMA LIKE 'mwdb_%'
AND TABLE_NAME LIKE '%_wb_changes'
ORDER BY TABLE_ROWS DESC
```

### Generate queries to, Delete all SQL object cache entries that have expired

WARNING: Large deletes may cause replag...

```
SELECT
CONCAT('DELETE FROM ', CONCAT( TABLE_SCHEMA , ".", TABLE_NAME),' WHERE exptime < NOW()' ,';') AS command
FROM information_schema.tables
WHERE TABLE_SCHEMA LIKE 'mwdb_%'
AND TABLE_NAME LIKE '%_objectcache'
AND TABLE_ROWS != 0
ORDER BY TABLE_ROWS DESC
```

### Generate queries to, Optimize all _objectcache tables

```
SELECT
CONCAT('OPTIMIZE TABLE ', CONCAT( TABLE_SCHEMA , ".", TABLE_NAME),';') AS command
FROM information_schema.tables
WHERE TABLE_SCHEMA LIKE 'mwdb_%'
AND TABLE_NAME LIKE '%_objectcache'
ORDER BY TABLE_ROWS DESC
```

### Generate queries to, Optimize all _job tables

```
SELECT
CONCAT('OPTIMIZE TABLE ', CONCAT( TABLE_SCHEMA , ".", TABLE_NAME),';') AS command
FROM information_schema.tables
WHERE TABLE_SCHEMA LIKE 'mwdb_%'
AND TABLE_NAME LIKE '%_job'
ORDER BY TABLE_ROWS DESC
```
