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
where Owner in ('CCS','EVS','FEDRULES','GCTRACK_AUDIT','GCTRACK_PL','HCD',
                'MYLOCATOR','USORG') and O.object_name not like '%$%'
order by Name, Owner, Object_type, object_name  */

INSERT INTO tracker.migrinventory(dbname, schname, objtype, srtorder, objname,   extractdate, pg_name, pg_type) Values


SELECT 'VALUES '|| LOWER( '(''' || S.NAME || ''', ''' || O.Owner || ''', ''package'', 5.1, ''' || O.NAME  
 || ''', ''' || current_date  || ''', ''' || O.NAME || '_'  || Substr(ltrim(text),10) || ''',''' || TRIM(SUBSTR(LTRIM(TEXT),1,9) ) ||  ''' ); ')  
from DBA_source O, v$services S   
where O.owner in ('CCS','EVS','FEDRULES','GCTRACK_AUDIT','GCTRACK_PL','HCD',
                'MYLOCATOR','USORG')
  AND TYPE = 'PACKAGE'
  AND (LTRIM(TEXT) like  'function%'or LTRIM(TEXT) like 'procedure%')
  order by O.Owner, O.Name, O.Line
 
 SELECT 'VALUES '|| o.liNE || LOWER( '(''' || S.NAME || ''', ''' || O.Owner || ''', ''package'', 5.1, ''' || O.NAME  
 || ''', ''' || current_date  || ''', ''' || O.NAME || '_'  || Substr(ltrim(text),10) || ''',''' || TRIM(SUBSTR(LTRIM(TEXT),1,9) ) ||  ''' ); ')  
from DBA_source O, v$services S   
where O.owner in ('CCS','EVS','FEDRULES','GCTRACK_AUDIT','GCTRACK_PL','HCD',
                'MYLOCATOR','USORG')
  AND TYPE in ( 'PACKAGE', 'TRIGGER','FUNCTION','PROCEDURE')
 -- AND (LTRIM(TEXT) like  'function%'or LTRIM(TEXT) like 'procedure%')
  order by O.Owner, O.Name, O.Line
 
 sELECT * FROM DBA_SOURCE o where O.owner in ('CCS','EVS','FEDRULES','GCTRACK_AUDIT','GCTRACK_PL','HCD',
                'MYLOCATOR','USORG')
  AND ((TYPE in ( 'TRIGGER','FUNCTION','PROCEDURE')  AND line = 1) OR (TYPE='PACKAGE' AND    (LTRIM(TEXT) like  'function%'or LTRIM(TEXT) like 'procedure%')) )
  order by O.Owner, O.Name, O.Line
 
 
 
 select * from DBA_SOURCE