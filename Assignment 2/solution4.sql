SPOOL solution4.lst
SET ECHO ON
SET FEEDBACK ON
SET LINESIZE 300
SET PAGESIZE 300

-- Whitney Chng Yia Qing
-- 6956865
-- Assignment 2 Task 4

conn tpchr/oracle


-- Original Queries
EXPLAIN PLAN FOR
SELECT COUNT(DISTINCT O_TOTALPRICE)
FROM ORDERS;
@showplan.sql

EXPLAIN PLAN FOR
SELECT *
FROM CUSTOMER JOIN ORDERS
ON CUSTOMER.C_CUSTKEY = ORDERS.O_CUSTKEY
WHERE C_ACCTBAL = 1000 AND O_TOTALPRICE = 1000;
@showplan.sql

EXPLAIN PLAN FOR
SELECT *
FROM ORDERS JOIN LINEITEM
ON ORDERS.O_ORDERKEY = LINEITEM.L_ORDERKEY
WHERE O_ORDERDATE = '09-SEP-2021' OR L_QUANTITY = 500;
@showplan.sql

EXPLAIN PLAN FOR
SELECT *
FROM LINEITEM JOIN PART
ON LINEITEM.L_PARTKEY = PART.P_PARTKEY
WHERE L_QUANTITY = 100 AND P_NAME = 'bolt';
@showplan.sql

EXPLAIN PLAN FOR
SELECT COUNT(PS_AVAILQTY)
FROM PARTSUPP JOIN LINEITEM
ON PARTSUPP.PS_PARTKEY = LINEITEM.L_PARTKEY
JOIN ORDERS
ON LINEITEM.L_ORDERKEY = ORDERS.O_ORDERKEY
WHERE O_ORDERSTATUS = 'F' AND L_QUANTITY >200 AND PS_SUPPLYCOST >100;
@showplan.sql

/* Potential Indexes
CREATE INDEX order_index ON ORDERS(O_TOTALPRICE, O_ORDERDATE, O_ORDERSTATUS);
CREATE INDEX cust_index ON CUSTOMER(C_ACCTBAL);
CREATE INDEX part_index ON PART(P_NAME);
CREATE INDEX lineitem_index ON LINEITEM(L_QUANTITY);
CREATE INDEX partsupp_index ON PARTSUPP(PS_SUPPLYCOS,PS_AVAILQTY);*/

-- (2)
-- Smallest No. of Index Found
CREATE INDEX order_index ON ORDERS(O_TOTALPRICE, O_ORDERDATE, O_ORDERSTATUS);
CREATE INDEX lineitem_index ON LINEITEM(L_QUANTITY);

-- Size of Indexes
connect sys/oracle as sysdba

SELECT SEGMENT_NAME, SEGMENT_TYPE, BYTES, BLOCKS
FROM DBA_SEGMENTS
WHERE SEGMENT_NAME in ('order_index','lineitem_index');

-- (3) Query Processing Plan

-- Improved Queries
connect tpchr/oracle
-- Query 1
EXPLAIN PLAN FOR
SELECT COUNT(DISTINCT O_TOTALPRICE)
FROM ORDERS;
@showplan.sql

-- Query 2
EXPLAIN PLAN FOR
SELECT *
FROM CUSTOMER JOIN ORDERS
ON CUSTOMER.C_CUSTKEY = ORDERS.O_CUSTKEY
WHERE C_ACCTBAL = 1000 AND O_TOTALPRICE = 1000;
@showplan.sql

-- Query 3
EXPLAIN PLAN FOR
SELECT *
FROM ORDERS JOIN LINEITEM
ON ORDERS.O_ORDERKEY = LINEITEM.L_ORDERKEY
WHERE O_ORDERDATE = '09-SEP-2021' OR L_QUANTITY = 500;
@showplan.sql

-- Query 4
EXPLAIN PLAN FOR
SELECT *
FROM LINEITEM JOIN PART
ON LINEITEM.L_PARTKEY = PART.P_PARTKEY
WHERE L_QUANTITY = 100 AND P_NAME = 'bolt';
@showplan.sql

-- Query 5
EXPLAIN PLAN FOR
SELECT COUNT(PS_AVAILQTY)
FROM PARTSUPP JOIN LINEITEM
ON PARTSUPP.PS_PARTKEY = LINEITEM.L_PARTKEY
JOIN ORDERS
ON LINEITEM.L_ORDERKEY = ORDERS.O_ORDERKEY
WHERE O_ORDERSTATUS = 'F' AND L_QUANTITY >200 AND PS_SUPPLYCOST >100;
@showplan.sql

-- (4) Drop Indexes
DROP INDEX order_index;
DROP INDEX lineitem_index;

SPOOL OFF