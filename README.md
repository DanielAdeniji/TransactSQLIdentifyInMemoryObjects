
|File Name                                | Description                                                      | DMV                      |
|---------------------------------------- | -----------------------------------------------------------------| ------------------------ |
|identifyIMObjectsVia.sqlmodules.sql      | Identify In-Memory Programmable Objects ( Stored Procedures & Functions)  | sys.sql_modules |
|identifyIMObjectsViaOSLoadedModules.sql  | Identify In-Memory Objects based on reviewing OS Loaded Modules  | sys.dm_os_loaded_modules |
|identifyIMTablesAndIndexesViaIMFileGroups.sql | Identify In-Memory Tables and Indexes based on File Group Memberships | sys.filegroups type_desc = MEMORY_OPTIMIZED_DATA_FILEGROUP |
|identifyIMTablesViaIMFileGroups.sql | Identify In-Memory Tables and Indexes based on File Group Memberships | sys.filegroups type_desc = MEMORY_OPTIMIZED_DATA_FILEGROUP |
