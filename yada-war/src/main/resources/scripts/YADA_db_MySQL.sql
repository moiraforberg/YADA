CREATE DATABASE IF NOT EXISTS YADA;		
GRANT ALL ON YADA.* TO 'yada'@'localhost' IDENTIFIED BY 'yada' WITH GRANT OPTION;

DROP TABLE IF EXISTS YADA.YADA_QUERY;
CREATE TABLE IF NOT EXISTS YADA.YADA_QUERY
(	
	QNAME        VARCHAR(255)  NOT NULL, 
	QUERY        VARCHAR(4000) NOT NULL, 
	APP          VARCHAR(20), 
	CREATED      TIMESTAMP,
	MODIFIED     TIMESTAMP, 
	CREATED_BY   VARCHAR(20), 
	MODIFIED_BY  VARCHAR(20), 
	LAST_ACCESS  TIMESTAMP, 
	ACCESS_COUNT INT DEFAULT 0,
	COMMENTS     VARCHAR(4000)
);

DROP TABLE IF EXISTS YADA.YADA_QUERY_CONF;
CREATE TABLE IF NOT EXISTS YADA.YADA_QUERY_CONF 
(	
	APP     VARCHAR(20)   NOT NULL, 
	NAME    VARCHAR(20),
    DESCR   VARCHAR(400),
	SOURCE  VARCHAR(4000), 
	CONF    VARCHAR(4000),
	ACTIVE  INT DEFAULT 1
);

DROP TABLE IF EXISTS YADA.YADA_PARAM;
CREATE TABLE IF NOT EXISTS YADA.YADA_PARAM 
(	
  ID     VARCHAR(255),
	TARGET VARCHAR(255)   NOT NULL, 
	NAME   VARCHAR(20)   NOT NULL, 
	VALUE  VARCHAR(4000) NOT NULL, 
	RULE   VARCHAR(1)    DEFAULT 1
);

DROP TABLE IF EXISTS YADA.YADA_A11N;
CREATE TABLE IF NOT EXISTS YADA.YADA_A11N 
( 
  TARGET VARCHAR(500), 
  POLICY VARCHAR(1), 
  QNAME  VARCHAR(2000), 
  TYPE   VARCHAR(9)
);
   
DROP TABLE IF EXISTS YADA.YADA_TEST;
CREATE TABLE IF NOT EXISTS YADA.YADA_TEST 
(	
	COL1 VARCHAR(3), 
	COL2 INT,
	COL3 DOUBLE(2,1), 
	COL4 DATE,
	COL5 TIMESTAMP,
	TOKEN VARCHAR(8) DEFAULT 'YADA'
);

DROP TABLE IF EXISTS YADA.YADA_PROP;
CREATE TABLE IF NOT EXISTS YADA.YADA_PROP
( 
  TARGET VARCHAR(500), 
  NAME VARCHAR(500),
  VALUE VARCHAR(4000)
);

-- YADA_UG is a whitelist table for the yada-admin webapp
DROP TABLE IF EXISTS YADA.YADA_UG;
CREATE TABLE IF NOT EXISTS YADA.YADA_UG
(
  APP VARCHAR(20) NOT NULL,
  UID VARCHAR(255) NOT NULL,
  ROLE VARCHAR(20) NOT NULL
);

-- INSERT YADA INDEX QUERY CONF
DELETE from YADA_QUERY_CONF where app = 'YADA' and source = 'java:comp/env/jdbc/yada';
INSERT into YADA_QUERY_CONF (APP,SOURCE,CONF) values ('YADA','java:comp/env/jdbc/yada',null);
INSERT into YADA_QUERY_CONF (APP,SOURCE,CONF) values ('YADATEST','java:comp/env/jdbc/yada',null);
INSERT into YADA_QUERY_CONF (APP,SOURCE,CONF) values ('QGO',null,'http://www.ebi.ac.uk/QuickGO/GTerm?');
INSERT into YADA_QUERY_CONF (APP,SOURCE,CONF) values ('YADAFSIN',null,'file:///io/in');
INSERT into YADA_QUERY (qname,query,created_by,app) VALUES ('YADA default','select ''YADA is alive''','YADABOT','YADA');
-- THESE LINES DON'T WORK IN WORKBENCH, BUT MAYBE ON CLI
-- source YADA_query_essentials.sql;
-- source YADA_query_tests.sql;
