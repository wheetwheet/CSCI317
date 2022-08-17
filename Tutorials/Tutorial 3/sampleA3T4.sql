CREATE TABLE PART_NBT(
	P_PARTKEY NUMBER(12) NOT NULL,
	P_NAME VARCHAR(55) NOT NULL,
	P_BRAND CHAR(10) NOT NULL,
	P_TYPE VARCHAR(25) NOT NULL,
CONSTRAINT PART_NBT_PKEY PRIMARY KEY (P_PARTKEY),
CONSTRAINT PART_NBT_FKEY FOREIGN KEY (P_PARTKEY)
REFERENCES PART(P_PARTKEY),
CONSTRAINT PART_NBT_CHECK CHECK(P_PARTKEY >= 0) );

CREATE TABLE PART_COMMENTS(
	P_PARTKEY NUMBER(12) NOT NULL,
	P_COMMENT VARCHAR(23) NOT NULL,
CONSTRAINT PART_COMMENTS_PKEY PRIMARY KEY (P_PARTKEY),
CONSTRAINT PART_COMMENTS_FKEY FOREIGN KEY (P_PARTKEY)
REFERENCES PART(P_PARTKEY) );

CREATE TABLE PART_OTHERS(
	P_PARTKEY NUMBER(12) NOT NULL,
	P_MFGR VARCHAR(25) NOT NULL,
	P_SIZE NUMBER(12) NOT NULL,
	P_CONTAINER CHAR(10) NOT NULL,
	P_RETAILPRICE NUMBER(12,2) NOT NULL,
CONSTRAINT PART_OTHERS_PKEY PRIMARY KEY (P_PARTKEY),
CONSTRAINT PART_OTHERS_FKEY FOREIGN KEY (P_PARTKEY)
REFERENCES PART(P_PARTKEY),
CONSTRAINT PART_OTHERS_CHECK1 CHECK(P_PARTKEY >= 0),
CONSTRAINT PART_OTHERS_CHECK2 CHECK(P_SIZE >= 0),
CONSTRAINT PART_OTHERS_CHECK3 CHECK(P_RETAILPRICE >= 0) );

set autotrace on
set autotrace traceonly

INSERT ALL
INTO PART_NBT
	VALUES (P_PARTKEY, P_NAME, P_BRAND, P_TYPE)
INTO PART_COMMENTS
	VALUES (P_PARTKEY, P_COMMENT)
INTO PART_OTHERS
	VALUES(P_PARTKEY, P_MFGR, P_SIZE, P_CONTAINER, P_RETAILPRICE)
(SELECT *
FROM PART
WHERE P_PARTKEY IN (SELECT PS_PARTKEY FROM PARTSUPP);

DROP TABLE PART_NBT CASCADE CONSTRAINTS PURGE;
DROP TABLE PART_COMMENTS CASCADE CONSTRAINTS PURGE;
DROP TABLE PART_OTHERS CASCADE CONSTRAINTS PURGE;