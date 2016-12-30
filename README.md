
|File Name                                | Description                                                      | DMV                      |
|---------------------------------------- | -----------------------------------------------------------------| ------------------------ |
|identifyIMObjectsVia.sqlmodules.sql      | Identify In-Memory Programmable Objects ( Stored Procedures & Functions)  | sys.sql_modules |
|identifyIMObjectsViaOSLoadedModules.sql  | Identify In-Memory Objects based on reviewing OS Loaded Modules  | sys.dm_os_loaded_modules |
|identifyIMTablesAndIndexesViaIMFileGroups.sql | Identify In-Memory Tables and Indexes based on File Group Memberships | sys.filegroups type_desc = MEMORY_OPTIMIZED_DATA_FILEGROUP |
|identifyIMTablesViaIMFileGroups.sql | Identify In-Memory Tables and Indexes based on File Group Memberships | sys.filegroups type_desc = MEMORY_OPTIMIZED_DATA_FILEGROUP |
|identifyIMTablesViaSysTables.sql | Identify In-Memory Tables via sys.tables | sys.tables :- is_memory_optimized = 1 |
|memoryConsumedByIMIndexes.sql | Calculate memory consumed by Indexes| sys.dm_db_xtp_memory_consumers |
|memoryConsumedByIMTables.sql |  Calculate memory consumed by Tables| sys.dm_db_xtp_memory_consumers |
