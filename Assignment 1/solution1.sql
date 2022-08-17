SPOOL solution1.lst
SET ECHO ON
SET FEEDBACK ON
SET LINESIZE 300
SET PAGESIZE 300

-- Whitney Chng Yia Qing
-- 6956865
-- Assignment 1 Task 1

-- (1) 
connect system/oracle

select v$instance.instance_name,
v$instance.host_name,
v$instance.startup_time,
v$instance.database_status
from v$instance;

-- (2)
connect tpchr/oracle

analyze table REGION compute statistics;
analyze table NATION compute statistics;
analyze table PART compute statistics;
analyze table SUPPLIER compute statistics;
analyze table PARTSUPP compute statistics;
analyze table CUSTOMER compute statistics;
analyze table ORDERS compute statistics;
analyze table LINEITEM compute statistics;

-- (3)
connect sys/oracle as sysdba

-- (4i)
select systimestamp from dual;

-- (4ii)
column SEGMENT_NAME format A30

select a.segment_name as table_name,b.num_rows as total_rows, a.blocks as total_blocks, a.extents total_extents, a.bytes as total_bytes
from dba_segments a, dba_tables b
where a.SEGMENT_name = b.table_name
and a.tablespace_name = 'TPCHR';

-- (4iii)
select a.segment_name as index_name,a.blocks as total_blocks, a.extents total_extents, a.bytes as total_bytes
from dba_segments a
where a.segment_name in ('REGION_PKEY','NATION_PKEY','PART_PEKEY','SUPPLIER_PKEY','PARTSUPP_PKEY','CUSTOMER_PKEY','ORDERS_PKEY','LINEITEM_PKEY');




SPOOL OFF





