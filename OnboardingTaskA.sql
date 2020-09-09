-- avoid text merge get NULL when there is a NULL value  
SET concat_null_yields_null OFF 

SELECT o.ownerid                       AS "Owner Id", 
       ps.firstname + ' ' + ps.middlename + ' ' 
       + ps.lastname                   AS "Owner Name", 
       p.id                            AS "Property Id", 
       p.NAME                          AS "Property Name", 
       Phv.value                       AS "Home Value", 
       p.targetrent                    AS "Target Rent", 
       TRT.[name]                      AS "Frequency", 
       -- calculate how many days between start and end date. 
       (SELECT ( Datediff(day, TP.startdate, TP.enddate) / 
       CASE 
           WHEN 
                 (SELECT id  FROM   targetrenttype t WHERE  t.id = tp.paymentfrequencyid) = '1' THEN 7 
           WHEN 
                 (SELECT id  FROM   targetrenttype t WHERE  t.id = tp.paymentfrequencyid) = '2' THEN 14 
           ELSE 30 
        END ) * 
		TP.paymentamount FROM   [dbo].[tenantproperty] TP WHERE  TP.[propertyid] = p.id) AS "Total payment", 
       pf.yield                        AS "Yield", 
       p2.firstname + ' ' + p2.middlename + ' ' + p2.lastname AS "Tenant name" 
FROM   [dbo].[property] p 
       INNER JOIN [dbo].[ownerproperty] o 
               ON o.propertyid = p.id 
       INNER JOIN [dbo].[person] ps 
               ON ps.id = o.ownerid 
       INNER JOIN [dbo].[propertyhomevalue] Phv 
               ON Phv.propertyid = p.id 
       INNER JOIN [dbo].[propertyfinance] pf 
               ON pf.propertyid = p.id 
       INNER JOIN [dbo].[tenantproperty] TP 
               ON tp.propertyid = p.id 
       INNER JOIN [dbo].[person] p2 
               ON p2.id = tp.tenantid 
       INNER JOIN [dbo].[targetrenttype] TRT 
               ON p.targetrenttypeid = TRT.id 
WHERE  o.ownerid = 1426 
       AND phv.isactive = 1 -- checked property is still active