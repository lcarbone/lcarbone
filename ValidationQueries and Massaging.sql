/*
select  'Missing view from PostgreSQL: ' || objname from tracker.migrinventory where schname = 'usorg' and objtype in ('view', 'synonym')
and objname not in (select table_name from information_schema.views where table_schema='usorg')
union
select  'Missing view from Oracle: ' || table_name  from information_schema.views where table_schema='usorg'
and table_name not in (select objname from tracker.migrinventory where schname = 'usorg'and objtype in ('view', 'synonym'))

 
-- VIEWS in Oracle and not in PostgreSQL
select  Objname  from tracker.migrinventory where schname = 'usorg' and objtype in ('view', 'synonym')  
and   objname  Not in (select    table_name  from information_schema.views where table_schema='usorg')
---
---
-- Count of views in PostgreSQL
Select count (table_name) from information_schema.views where table_schema = 'usorg'
---
---   
--- Tables
select  Objname  from tracker.migrinventory where schname = 'usorg' and objtype in ('table')  
and   objname  Not in (select table_name from information_schema.tables where table_type ='BASE TABLE' and table_schema = 'usorg')*/

-- Functions - Procedures, packages and triggers (need more work)
select Schname, objname, pg_name,objtype, pg_type from tracker.migrinventory 
where objtype in ('function', 'trigger') or pg_type = 'function' 
order by schname, objname

SELECT routines.specific_schema, routines.routine_name,routines.routine_type, parameters.data_type, parameters.ordinal_position
FROM information_schema.routines
    LEFT JOIN information_schema.parameters ON routines.specific_name=parameters.specific_name
WHERE routines.specific_schema in('hcd','usorg','mylocator','evs','fedrules','gctrack_pl','gctrack_audit')
and (ordinal_position = 1 or ordinal_position is null)
ORDER BY routines.routine_name, parameters.ordinal_position;
----
--- Indexes
select objname from tracker.migrinventory where schname = 'usorg' and objtype in ('index')
and   objname  Not in (select indexname from pg_indexes where schemaname = 'usorg')
 
 
Select distinct objtype from tracker.migrinventory order by objtype 
	

select * from information_schema.routines

Select   PG_NAMe, position('(' in pg_name)  from tracker.migrinventory where pg_type = 'function'

----- Cleanup function name from Package
UPDATE tracker.migrinventory
Set pg_name = substring(pg_name from 1 for position('(' in pg_name)-1)  
 where pg_type = 'function' and  position('(' in pg_name)-1 > 0


--- Sequences  Queries purposely not equating all schemas to show dropouts
select  Schname|| '.'|| objname "Missing in Postgres"
from tracker.migrinventory 
where objtype = 'sequence' --and schname  in ('hcd', 'evs' )
and schname||objname not in (select sequence_schema || sequence_name
							   from information_schema.sequences
							 where sequence_schema in ('hcd', 'evs', 'anon') )
 
Select sequence_schema ||'.'|| sequence_name "Missing from Oracle"
from information_schema.sequences
where sequence_schema in ('hcd', 'evs', 'anon')
and sequence_schema || sequence_name  NOT IN (select  Schname|| objname 
											  from tracker.migrinventory 
											  where objtype = 'sequence' 
											  and schname  in ('hcd','evs'))