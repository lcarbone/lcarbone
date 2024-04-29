/* select LOWER( '(''' || S.NAME || ''', ''' ||  O.Owner || ''', ''' || O.Object_type|| ''', ' ||
       CASE OBJECT_TYPE
         WHEN 'DATABASE LINK' Then 1
         WHEN 'TABLE'         Then 2
         WHEN 'MATERIALIZED VIEW' then 3
         WHEN 'VIEW'          Then 4
         WHEN 'PACKAGE'       Then 5
         WHEN 'PROCEDURE'     Then 6
         WHEN 'FUNCTION'      Then 7
         WHEN 'TRIGGER'       THEN 8
         WHEN 'JOB'           THEN 20
         WHEN 'INDEX'         THEN 50
         WHEN 'LOB'           THEN 150
         WHEN 'SYNONYM'       THEN 8
         WHEN 'SEQUENCE'      THEN 9
         WHEN 'TYPE'          THEN 12
         ELSE 99  END
|| ', ''' ||  O.Object_name || ''', ''' || O.Status  || ''', ''' ||current_date
   || ''', ''' ||  O.Object_name  || ''', ''' || O.Object_type||  '''); ')  as str 
 FROM v$services S, DBA_OBJECTS O
where Owner in ('Replace with desired Schemas') 
  and O.object_name not like '%$%'  --Ignore certain tables
order by Name, Owner, Object_type, object_name  */

I 
