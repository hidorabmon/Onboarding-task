SELECT o.ownerid                                  AS "Owner Id", 
       ps.firstname + ps.middlename + ps.lastname AS "Owner Name", 
       p.id                                       AS "Property Id", 
       p.NAME                                     AS "Property Name" 
FROM   [dbo].[property] p 
       INNER JOIN [dbo].[ownerproperty] o 
               ON o.propertyid = p.id 
       INNER JOIN [dbo].[person] ps 
               ON ps.id = o.ownerid 
WHERE  o.ownerid = 1426