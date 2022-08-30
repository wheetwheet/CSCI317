
SET ECHO OFF
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   Experiment:     4.2
   Title:          How to investigate the dynamic performance views (V$ views) ?
   Script name:    creapstat.sql
   Task:           To create OPSTAT_TABLE
   Created by:     Janusz R. Getta
   Created on:	   31 May 2014
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */

SET ECHO ON
SET VERIFY ON
SET LINESIZE 100
SET PAGESIZE 100
CREATE TABLE OPSTAT_TABLE(
OWNER		VARCHAR(30)	NOT NULL,
OBJECT_NAME	VARCHAR(30)	NOT NULL,
STATISTIC_NAME	VARCHAR(64)	NOT NULL,
VALUE		NUMBER		NOT NULL,
TS		TIMESTAMP	NOT NULL,
  CONSTRAINT OPSTAT_TABLE_PKEY 
	PRIMARY KEY(TS,OWNER,OBJECT_NAME,STATISTIC_NAME) );
prompt Done.
