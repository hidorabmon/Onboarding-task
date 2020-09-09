SELECT o.ownerid                                  AS "Owner Id", 
       ps.firstname + ps.middlename + ps.lastname AS "Owner Name", 
       p.id                                       AS "Property Id", 
       p.NAME                                     AS "Property Name", 
       Phv.value                                  AS "Home Value" 
FROM   [dbo].[property] p 
       INNER JOIN [dbo].[ownerproperty] o 
               ON o.propertyid = p.id 
       INNER JOIN [dbo].[person] ps 
               ON ps.id = o.ownerid 
       INNER JOIN [dbo].[propertyhomevalue] Phv 
               ON Phv.propertyid = p.id 
WHERE  o.ownerid = 1426 
       AND phv.isactive = 1