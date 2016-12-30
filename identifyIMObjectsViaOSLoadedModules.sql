; with cteOSLM
(
	  [modulename]
	, [description]
    , [base_address]
	, [filenameFull]
	, [filename]
	, [filenameMassaged]
)
as
(

	SELECT
			  [name]

			, [description]

			, [base_address]

			, [filenameFull] = tblOSLM.[name]

			, [filename]
				= reverse(left(reverse(tblOSLM.[name]),
                    charindex('\',reverse(tblOSLM.[name]), 1) - 1))

			, [filenameMassaged]
				= replace(
							replace(
									 reverse(left(reverse(tblOSLM.[name]),
										charindex('\',reverse(tblOSLM.[name]), 1) - 1))
										, '_'
									, '.'
									)
							, '.dll'
							, ''
						)				

	
	FROM   sys.dm_os_loaded_modules tblOSLM 

	WHERE  tblOSLM.[description] = 'XTP Native DLL'

	
)

, cteOSLMObject
(
	  [modulename]
	, [description]
    , [base_address]
	, [filenameFull]
	, [filename]
	, [filenameMassaged]

	, [objectID] 
	, [databaseID] 
	, [objectType]

)
as
(

	SELECT 

		  	  [modulename]
			, [description]
			, [base_address]
			, [filenameFull]
			, [filename]
			, [filenameMassaged]


			, [objectID] 
				= PARSENAME([filenameMassaged], 1)

			, [databaseID] 
				= PARSENAME([filenameMassaged], 2)
			
			, [objectType]
				= case PARSENAME([filenameMassaged], 3)
						when 't' then 'Table'
						when 'p' then 'Procedure'
						when 'f' then 'Function'
						else PARSENAME([filenameMassaged], 3)
				  end 

	from   cteOSLM

)
, cteVirtualAddress
(
	  [region_allocation_base_address]
	, [regionSizeInBytes]
)
as
(
	select 
			  tblOSVAD.[region_allocation_base_address]
			, [regionSizeInBytes]
				= sum(tblOSVAD.region_size_in_bytes)
	
	from   sys.dm_os_virtual_address_dump tblOSVAD
	
	group by
	 
			tblOSVAD.[region_allocation_base_address]

)	 
SELECT 

		  tblOSLM.[description]

		, tblOSLM.[modulename]

		, tblOSLM.[filename]


		, [database]
			= case
				when tblOSLM.[databaseID] = 32767 then 'Resource DB'
				else db_name(tblOSLM.[databaseID])
			   end

		, [objectName]
			= quoteName
				(
				    object_schema_name
					(
					  tblOSLM.objectID
					, tblOSLM.databaseID
					)
				)
				+ '.'
				+ quoteName
				(
					object_name
					(
					   tblOSLM.objectID
					 , tblOSLM.databaseID
					)
				)

		, tblOSLM.[objectType]

		, [sizeInKB]
			= (tblOSVAD.[regionSizeInBytes])
				/ ( 1024 )

FROM   cteOSLMObject tblOSLM 

INNER JOIN cteVirtualAddress tblOSVAD

		on tblOSLM.[base_address] = tblOSVAD.[region_allocation_base_address]

order by

			  [database]
			, [objectName]
