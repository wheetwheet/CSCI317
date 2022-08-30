
SET ECHO OFF
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Experiment:     4.2
   Title:          How to investigate the dynamic performance views (V$ views) ?
   Script name:    showpio.sql
   Task:           To list object input output operations
   Created by:     Janusz R. Getta
   Created on:	   31 May 2014
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

SET ECHO 		OFF
SET FEEDBACK		OFF
SET LINESIZE		100
SET PAGESIZE 		300
COLUMN			OBJECT_NAME FORMAT A20 HEADING "Object name"
COLUMN			OWNER FORMAT A20 HEADING "Owner"
COLUMN 			STATISTIC_NAME FORMAT A25 HEADING "Statistic name"
COLUMN INCR 		FORMAT 9,999,999,999 HEADING "Statistic value"
ACCEPT SCRIPT		CHAR PROMPT 'Script name>'
SET TERMOUT		OFF

CONNECT SYSTEM/oracle
TRUNCATE TABLE OPSTAT_TABLE;

INSERT INTO OPSTAT_TABLE (
	SELECT	OWNER,
 		OBJECT_NAME,
 		STATISTIC_NAME,
 		VALUE,
		SYSTIMESTAMP
	FROM  	V$SEGMENT_STATISTICS
	WHERE 	OWNER = 'TPCHR' AND
		STATISTIC_NAME IN ('logical reads',
				   'physical reads',
				   'physical writes',
			  	   'physical reads direct',
			   	   'physical writes direct') );
COMMIT;

CONNECT tpchr/oracle
@&SCRIPT

SET TERMOUT		ON

CONNECT system/oracle
SELECT	V$SEGMENT_STATISTICS.OWNER,
 	V$SEGMENT_STATISTICS.OBJECT_NAME,
 	V$SEGMENT_STATISTICS.STATISTIC_NAME,
 	V$SEGMENT_STATISTICS.VALUE - NVL(OPSTAT_TABLE.VALUE,0) INCR
FROM  	V$SEGMENT_STATISTICS LEFT OUTER JOIN OPSTAT_TABLE
	ON V$SEGMENT_STATISTICS.OWNER = OPSTAT_TABLE.OWNER AND
	   V$SEGMENT_STATISTICS.OBJECT_NAME = OPSTAT_TABLE.OBJECT_NAME AND
	   V$SEGMENT_STATISTICS.STATISTIC_NAME = OPSTAT_TABLE.STATISTIC_NAME
WHERE 	V$SEGMENT_STATISTICS.OWNER = 'TPCHR' AND
 	( V$SEGMENT_STATISTICS.VALUE - NVL(OPSTAT_TABLE.VALUE,0) ) <> 0 AND
	V$SEGMENT_STATISTICS.OBJECT_NAME <> 'PLAN_TABLE' AND 
	V$SEGMENT_STATISTICS.STATISTIC_NAME IN ('logical reads',
			 			'physical reads',
			   			'physical writes',
			   		 	'physical reads direct',
			   			'physical writes direct')
ORDER BY V$SEGMENT_STATISTICS.OBJECT_NAME, V$SEGMENT_STATISTICS.STATISTIC_NAME;

SET FEEDBACK 		ON
SET ECHO 		ON;
prompt Done.
