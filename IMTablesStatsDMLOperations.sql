
SELECT
      [object]
        = quoteName(tblS.[name])
           + '.'
           + quoteName(tblO.[name])
 
        , tblXTPOS.*
 
FROM sys.dm_db_xtp_object_stats tblXTPOS
 
INNER JOIN sys.objects tblO
 
    ON tblXTPOS.object_id = tblO.object_id
 
INNER JOIN sys.schemas tblS
 
    ON tblO.schema_id = tblS.schema_id