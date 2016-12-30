use [ppsivr]
go


/*
	exec sp_help 'dbo.oe_emp'

	exec sp_help 'dbo.oe_dep'

	exec sp_depends 'dbo.oe_emp'

*/
select
 
          [object]
            = tblSS.[name]
                + '.'
                + tblSO.[name]
 
        , [objectType]
            = tblSO.[type_desc]
 
 		, [numberofRecords]
			= tblSP.[rows]

        , [fileGroup]
            = tblSFG.[name]
 
        , [fileGroupType]
            = tblSFG.[type_desc]
 
from   sys.objects tblSO
 
INNER JOIN sys.schemas tblSS
 
    ON tblSO.schema_id = tblSS.schema_id
 
inner join sys.indexes tblSI
 
    on tblSO.object_id = tblSI.object_id
 
inner join sys.partitions tblSP
 
    on  tblSI.object_id = tblSP.object_id
    and tblSI.index_id = tblSP.index_id
 
         
INNER JOIN sys.allocation_units tblSAU
 
    on tblSAU.container_id = tblSP.hobt_id
          
INNER JOIN sys.filegroups tblSFG
  
    ON tblSFG.data_space_id = tblSAU.data_space_id 
 
where tblSFG.[type] = 'FX'

and   tblSI.is_primary_key = 1
