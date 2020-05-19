/*
 Navicat Premium Data Transfer

 Source Server         : hr
 Source Server Type    : Oracle
 Source Server Version : 110200
 Source Host           : localhost:1521
 Source Schema         : HR

 Target Server Type    : Oracle
 Target Server Version : 110200
 File Encoding         : 65001

 Date: 20/01/2020 11:35:35
*/


-- ----------------------------
-- Table structure for COUNTRIES
-- ----------------------------
DROP TABLE "HR"."COUNTRIES";
CREATE TABLE "HR"."COUNTRIES" (
  "COUNTRY_ID" CHAR(2 BYTE) NOT NULL ,
  "COUNTRY_NAME" VARCHAR2(40 BYTE) ,
  "REGION_ID" NUMBER 
)
ORGANIZATION INDEX
TABLESPACE "USERS"
LOGGING
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
DISABLE ROW MOVEMENT
PCTTHRESHOLD 50

;
COMMENT ON COLUMN "HR"."COUNTRIES"."COUNTRY_ID" IS 'Primary key of countries table.';
COMMENT ON COLUMN "HR"."COUNTRIES"."COUNTRY_NAME" IS 'Country name';
COMMENT ON COLUMN "HR"."COUNTRIES"."REGION_ID" IS 'Region ID for the country. Foreign key to region_id column in the departments table.';
COMMENT ON TABLE "HR"."COUNTRIES" IS 'country table. Contains 25 rows. References with locations table.';

-- ----------------------------
-- Records of "COUNTRIES"
-- ----------------------------
INSERT INTO "HR"."COUNTRIES" VALUES ('AR', 'Argentina', '2');
INSERT INTO "HR"."COUNTRIES" VALUES ('AU', 'Australia', '3');
INSERT INTO "HR"."COUNTRIES" VALUES ('BE', 'Belgium', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('BR', 'Brazil', '2');
INSERT INTO "HR"."COUNTRIES" VALUES ('CA', 'Canada', '2');
INSERT INTO "HR"."COUNTRIES" VALUES ('CH', 'Switzerland', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('CN', 'China', '3');
INSERT INTO "HR"."COUNTRIES" VALUES ('DE', 'Germany', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('DK', 'Denmark', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('EG', 'Egypt', '4');
INSERT INTO "HR"."COUNTRIES" VALUES ('FR', 'France', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('IL', 'Israel', '4');
INSERT INTO "HR"."COUNTRIES" VALUES ('IN', 'India', '3');
INSERT INTO "HR"."COUNTRIES" VALUES ('IT', 'Italy', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('JP', 'Japan', '3');
INSERT INTO "HR"."COUNTRIES" VALUES ('KW', 'Kuwait', '4');
INSERT INTO "HR"."COUNTRIES" VALUES ('ML', 'Malaysia', '3');
INSERT INTO "HR"."COUNTRIES" VALUES ('MX', 'Mexico', '2');
INSERT INTO "HR"."COUNTRIES" VALUES ('NG', 'Nigeria', '4');
INSERT INTO "HR"."COUNTRIES" VALUES ('NL', 'Netherlands', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('SG', 'Singapore', '3');
INSERT INTO "HR"."COUNTRIES" VALUES ('UK', 'United Kingdom', '1');
INSERT INTO "HR"."COUNTRIES" VALUES ('US', 'United States of America', '2');
INSERT INTO "HR"."COUNTRIES" VALUES ('ZM', 'Zambia', '4');
INSERT INTO "HR"."COUNTRIES" VALUES ('ZW', 'Zimbabwe', '4');

-- ----------------------------
-- Table structure for DEPARTMENTS
-- ----------------------------
DROP TABLE "HR"."DEPARTMENTS";
CREATE TABLE "HR"."DEPARTMENTS" (
  "DEPARTMENT_ID" NUMBER(4) NOT NULL ,
  "DEPARTMENT_NAME" VARCHAR2(30 BYTE) NOT NULL ,
  "MANAGER_ID" NUMBER(6) ,
  "LOCATION_ID" NUMBER(4) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "HR"."DEPARTMENTS"."DEPARTMENT_ID" IS 'Primary key column of departments table.';
COMMENT ON COLUMN "HR"."DEPARTMENTS"."DEPARTMENT_NAME" IS 'A not null column that shows name of a department. Administration,
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public
Relations, Sales, Finance, and Accounting. ';
COMMENT ON COLUMN "HR"."DEPARTMENTS"."MANAGER_ID" IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';
COMMENT ON COLUMN "HR"."DEPARTMENTS"."LOCATION_ID" IS 'Location id where a department is located. Foreign key to location_id column of locations table.';
COMMENT ON TABLE "HR"."DEPARTMENTS" IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';

-- ----------------------------
-- Records of "DEPARTMENTS"
-- ----------------------------
INSERT INTO "HR"."DEPARTMENTS" VALUES ('10', 'Administration', '200', '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('20', 'Marketing', '201', '1800');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('30', 'Purchasing', '114', '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('40', 'Human Resources', '203', '2400');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('50', 'Shipping', '121', '1500');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('60', 'IT', '103', '1400');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('70', 'Public Relations', '204', '2700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('80', 'Sales', '145', '2500');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('90', 'Executive', '100', '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('100', 'Finance', '108', '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('110', 'Accounting', '205', '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('120', 'Treasury', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('130', 'Corporate Tax', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('140', 'Control And Credit', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('150', 'Shareholder Services', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('160', 'Benefits', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('170', 'Manufacturing', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('180', 'Construction', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('190', 'Contracting', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('200', 'Operations', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('210', 'IT Support', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('220', 'NOC', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('230', 'IT Helpdesk', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('240', 'Government Sales', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('250', 'Retail Sales', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('260', 'Recruiting', NULL, '1700');
INSERT INTO "HR"."DEPARTMENTS" VALUES ('270', 'Payroll', NULL, '1700');

-- ----------------------------
-- Table structure for EMPLOYEES
-- ----------------------------
DROP TABLE "HR"."EMPLOYEES";
CREATE TABLE "HR"."EMPLOYEES" (
  "EMPLOYEE_ID" NUMBER(6) NOT NULL ,
  "FIRST_NAME" VARCHAR2(20 BYTE) ,
  "LAST_NAME" VARCHAR2(25 BYTE) NOT NULL ,
  "EMAIL" VARCHAR2(25 BYTE) NOT NULL ,
  "PHONE_NUMBER" VARCHAR2(20 BYTE) ,
  "HIRE_DATE" DATE NOT NULL ,
  "JOB_ID" VARCHAR2(10 BYTE) NOT NULL ,
  "SALARY" NUMBER(8,2) ,
  "COMMISSION_PCT" NUMBER(2,2) ,
  "MANAGER_ID" NUMBER(6) ,
  "DEPARTMENT_ID" NUMBER(4) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "HR"."EMPLOYEES"."EMPLOYEE_ID" IS 'Primary key of employees table.';
COMMENT ON COLUMN "HR"."EMPLOYEES"."FIRST_NAME" IS 'First name of the employee. A not null column.';
COMMENT ON COLUMN "HR"."EMPLOYEES"."LAST_NAME" IS 'Last name of the employee. A not null column.';
COMMENT ON COLUMN "HR"."EMPLOYEES"."EMAIL" IS 'Email id of the employee';
COMMENT ON COLUMN "HR"."EMPLOYEES"."PHONE_NUMBER" IS 'Phone number of the employee; includes country code and area code';
COMMENT ON COLUMN "HR"."EMPLOYEES"."HIRE_DATE" IS 'Date when the employee started on this job. A not null column.';
COMMENT ON COLUMN "HR"."EMPLOYEES"."JOB_ID" IS 'Current job of the employee; foreign key to job_id column of the
jobs table. A not null column.';
COMMENT ON COLUMN "HR"."EMPLOYEES"."SALARY" IS 'Monthly salary of the employee. Must be greater
than zero (enforced by constraint emp_salary_min)';
COMMENT ON COLUMN "HR"."EMPLOYEES"."COMMISSION_PCT" IS 'Commission percentage of the employee; Only employees in sales
department elgible for commission percentage';
COMMENT ON COLUMN "HR"."EMPLOYEES"."MANAGER_ID" IS 'Manager id of the employee; has same domain as manager_id in
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';
COMMENT ON COLUMN "HR"."EMPLOYEES"."DEPARTMENT_ID" IS 'Department id where employee works; foreign key to department_id
column of the departments table';
COMMENT ON TABLE "HR"."EMPLOYEES" IS 'employees table. Contains 107 rows. References with departments,
jobs, job_history tables. Contains a self reference.';

-- ----------------------------
-- Records of "EMPLOYEES"
-- ----------------------------
INSERT INTO "HR"."EMPLOYEES" VALUES ('100', 'Steven', 'King', 'SKING', '515.123.4567', TO_DATE('2003-06-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AD_PRES', '24000', NULL, NULL, '90');
INSERT INTO "HR"."EMPLOYEES" VALUES ('101', 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', TO_DATE('2005-09-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AD_VP', '17000', NULL, '100', '90');
INSERT INTO "HR"."EMPLOYEES" VALUES ('102', 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', TO_DATE('2001-01-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AD_VP', '17000', NULL, '100', '90');
INSERT INTO "HR"."EMPLOYEES" VALUES ('103', 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', TO_DATE('2006-01-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'IT_PROG', '9000', NULL, '102', '60');
INSERT INTO "HR"."EMPLOYEES" VALUES ('104', 'Bruce', 'Ernst', 'BERNST', '590.423.4568', TO_DATE('2007-05-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'IT_PROG', '6000', NULL, '103', '60');
INSERT INTO "HR"."EMPLOYEES" VALUES ('105', 'David', 'Austin', 'DAUSTIN', '590.423.4569', TO_DATE('2005-06-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'IT_PROG', '4800', NULL, '103', '60');
INSERT INTO "HR"."EMPLOYEES" VALUES ('106', 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', TO_DATE('2006-02-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'IT_PROG', '4800', NULL, '103', '60');
INSERT INTO "HR"."EMPLOYEES" VALUES ('107', 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', TO_DATE('2007-02-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'IT_PROG', '4200', NULL, '103', '60');
INSERT INTO "HR"."EMPLOYEES" VALUES ('108', 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', TO_DATE('2002-08-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FI_MGR', '12008', NULL, '101', '100');
INSERT INTO "HR"."EMPLOYEES" VALUES ('109', 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', TO_DATE('2002-08-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FI_ACCOUNT', '9000', NULL, '108', '100');
INSERT INTO "HR"."EMPLOYEES" VALUES ('110', 'John', 'Chen', 'JCHEN', '515.124.4269', TO_DATE('2005-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FI_ACCOUNT', '8200', NULL, '108', '100');
INSERT INTO "HR"."EMPLOYEES" VALUES ('111', 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', TO_DATE('2005-09-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FI_ACCOUNT', '7700', NULL, '108', '100');
INSERT INTO "HR"."EMPLOYEES" VALUES ('112', 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', TO_DATE('2006-03-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FI_ACCOUNT', '7800', NULL, '108', '100');
INSERT INTO "HR"."EMPLOYEES" VALUES ('113', 'Luis', 'Popp', 'LPOPP', '515.124.4567', TO_DATE('2007-12-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FI_ACCOUNT', '6900', NULL, '108', '100');
INSERT INTO "HR"."EMPLOYEES" VALUES ('114', 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', TO_DATE('2002-12-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PU_MAN', '11000', NULL, '100', '30');
INSERT INTO "HR"."EMPLOYEES" VALUES ('115', 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', TO_DATE('2003-05-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PU_CLERK', '3100', NULL, '114', '30');
INSERT INTO "HR"."EMPLOYEES" VALUES ('116', 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', TO_DATE('2005-12-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PU_CLERK', '2900', NULL, '114', '30');
INSERT INTO "HR"."EMPLOYEES" VALUES ('117', 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', TO_DATE('2005-07-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PU_CLERK', '2800', NULL, '114', '30');
INSERT INTO "HR"."EMPLOYEES" VALUES ('118', 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', TO_DATE('2006-11-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PU_CLERK', '2600', NULL, '114', '30');
INSERT INTO "HR"."EMPLOYEES" VALUES ('119', 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', TO_DATE('2007-08-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PU_CLERK', '2500', NULL, '114', '30');
INSERT INTO "HR"."EMPLOYEES" VALUES ('120', 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', TO_DATE('2004-07-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_MAN', '8000', NULL, '100', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('121', 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', TO_DATE('2005-04-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_MAN', '8200', NULL, '100', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('122', 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', TO_DATE('2003-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_MAN', '7900', NULL, '100', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('123', 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', TO_DATE('2005-10-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_MAN', '6500', NULL, '100', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('124', 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', TO_DATE('2007-11-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_MAN', '5800', NULL, '100', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('125', 'Julia', 'Nayer', 'JNAYER', '650.124.1214', TO_DATE('2005-07-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3200', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('126', 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', TO_DATE('2006-09-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2700', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('127', 'James', 'Landry', 'JLANDRY', '650.124.1334', TO_DATE('2007-01-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2400', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('128', 'Steven', 'Markle', 'SMARKLE', '650.124.1434', TO_DATE('2008-03-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2200', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('129', 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', TO_DATE('2005-08-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3300', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('130', 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', TO_DATE('2005-10-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2800', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('131', 'James', 'Marlow', 'JAMRLOW', '650.124.7234', TO_DATE('2005-02-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2500', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('132', 'TJ', 'Olson', 'TJOLSON', '650.124.8234', TO_DATE('2007-04-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2100', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('133', 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', TO_DATE('2004-06-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3300', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('134', 'Michael', 'Rogers', 'MROGERS', '650.127.1834', TO_DATE('2006-08-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2900', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('135', 'Ki', 'Gee', 'KGEE', '650.127.1734', TO_DATE('2007-12-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2400', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('136', 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', TO_DATE('2008-02-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2200', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('137', 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', TO_DATE('2003-07-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3600', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('138', 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', TO_DATE('2005-10-26 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3200', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('139', 'John', 'Seo', 'JSEO', '650.121.2019', TO_DATE('2006-02-12 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2700', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('140', 'Joshua', 'Patel', 'JPATEL', '650.121.1834', TO_DATE('2006-04-06 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2500', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('141', 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', TO_DATE('2003-10-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3500', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('142', 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', TO_DATE('2005-01-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '3100', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('143', 'Randall', 'Matos', 'RMATOS', '650.121.2874', TO_DATE('2006-03-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2600', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('144', 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', TO_DATE('2006-07-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '2500', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('145', 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', TO_DATE('2004-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_MAN', '14000', '0.4', '100', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('146', 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', TO_DATE('2005-01-05 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_MAN', '13500', '0.3', '100', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('147', 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', TO_DATE('2005-03-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_MAN', '12000', '0.3', '100', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('148', 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', TO_DATE('2007-10-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_MAN', '11000', '0.3', '100', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('149', 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', TO_DATE('2008-01-29 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_MAN', '10500', '0.2', '100', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('150', 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', TO_DATE('2005-01-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '10000', '0.3', '145', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('151', 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', TO_DATE('2005-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '9500', '0.25', '145', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('152', 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', TO_DATE('2005-08-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '9000', '0.25', '145', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('153', 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', TO_DATE('2006-03-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '8000', '0.2', '145', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('154', 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', TO_DATE('2006-12-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7500', '0.2', '145', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('155', 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', TO_DATE('2007-11-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7000', '0.15', '145', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('156', 'Janette', 'King', 'JKING', '011.44.1345.429268', TO_DATE('2004-01-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '10000', '0.35', '146', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('157', 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', TO_DATE('2004-03-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '9500', '0.35', '146', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('158', 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', TO_DATE('2004-08-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '9000', '0.35', '146', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('159', 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', TO_DATE('2005-03-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '8000', '0.3', '146', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('160', 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', TO_DATE('2005-12-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7500', '0.3', '146', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('161', 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', TO_DATE('2006-11-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7000', '0.25', '146', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('162', 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', TO_DATE('2005-11-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '10500', '0.25', '147', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('163', 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', TO_DATE('2007-03-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '9500', '0.15', '147', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('164', 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', TO_DATE('2008-01-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7200', '0.1', '147', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('165', 'David', 'Lee', 'DLEE', '011.44.1346.529268', TO_DATE('2008-02-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '6800', '0.1', '147', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('166', 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', TO_DATE('2008-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '6400', '0.1', '147', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('167', 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', TO_DATE('2008-04-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '6200', '0.1', '147', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('168', 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', TO_DATE('2005-03-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '11500', '0.25', '148', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('169', 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', TO_DATE('2006-03-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '10000', '0.2', '148', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('170', 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', TO_DATE('2006-01-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '9600', '0.2', '148', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('171', 'William', 'Smith', 'WSMITH', '011.44.1343.629268', TO_DATE('2007-02-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7400', '0.15', '148', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('172', 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', TO_DATE('2007-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7300', '0.15', '148', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('173', 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', TO_DATE('2008-04-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '6100', '0.1', '148', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('174', 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', TO_DATE('2004-05-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '11000', '0.3', '149', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('175', 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', TO_DATE('2005-03-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '8800', '0.25', '149', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('176', 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', TO_DATE('2006-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '8600', '0.2', '149', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('177', 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', TO_DATE('2006-04-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '8400', '0.2', '149', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('178', 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', TO_DATE('2007-05-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '7000', '0.15', '149', NULL);
INSERT INTO "HR"."EMPLOYEES" VALUES ('179', 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', TO_DATE('2008-01-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '6200', '0.1', '149', '80');
INSERT INTO "HR"."EMPLOYEES" VALUES ('180', 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', TO_DATE('2006-01-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3200', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('181', 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', TO_DATE('2006-02-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3100', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('182', 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', TO_DATE('2007-06-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2500', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('183', 'Girard', 'Geoni', 'GGEONI', '650.507.9879', TO_DATE('2008-02-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2800', NULL, '120', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('184', 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', TO_DATE('2004-01-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '4200', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('185', 'Alexis', 'Bull', 'ABULL', '650.509.2876', TO_DATE('2005-02-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '4100', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('186', 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', TO_DATE('2006-06-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3400', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('187', 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', TO_DATE('2007-02-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3000', NULL, '121', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('188', 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', TO_DATE('2005-06-14 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3800', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('189', 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', TO_DATE('2005-08-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3600', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('190', 'Timothy', 'Gates', 'TGATES', '650.505.3876', TO_DATE('2006-07-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2900', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('191', 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', TO_DATE('2007-12-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2500', NULL, '122', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('192', 'Sarah', 'Bell', 'SBELL', '650.501.1876', TO_DATE('2004-02-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '4000', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('193', 'Britney', 'Everett', 'BEVERETT', '650.501.2876', TO_DATE('2005-03-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3900', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('194', 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', TO_DATE('2006-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3200', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('195', 'Vance', 'Jones', 'VJONES', '650.501.4876', TO_DATE('2007-03-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2800', NULL, '123', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('196', 'Alana', 'Walsh', 'AWALSH', '650.507.9811', TO_DATE('2006-04-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3100', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('197', 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', TO_DATE('2006-05-23 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '3000', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('198', 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', TO_DATE('2007-06-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2600', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('199', 'Douglas', 'Grant', 'DGRANT', '650.507.9844', TO_DATE('2008-01-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SH_CLERK', '2600', NULL, '124', '50');
INSERT INTO "HR"."EMPLOYEES" VALUES ('200', 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', TO_DATE('2003-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AD_ASST', '4400', NULL, '101', '10');
INSERT INTO "HR"."EMPLOYEES" VALUES ('201', 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', TO_DATE('2004-02-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'MK_MAN', '13000', NULL, '100', '20');
INSERT INTO "HR"."EMPLOYEES" VALUES ('202', 'Pat', 'Fay', 'PFAY', '603.123.6666', TO_DATE('2005-08-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'MK_REP', '6000', NULL, '201', '20');
INSERT INTO "HR"."EMPLOYEES" VALUES ('203', 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', TO_DATE('2002-06-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'HR_REP', '6500', NULL, '101', '40');
INSERT INTO "HR"."EMPLOYEES" VALUES ('204', 'Hermann', 'Baer', 'HBAER', '515.123.8888', TO_DATE('2002-06-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'PR_REP', '10000', NULL, '101', '70');
INSERT INTO "HR"."EMPLOYEES" VALUES ('205', 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', TO_DATE('2002-06-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AC_MGR', '12008', NULL, '101', '110');
INSERT INTO "HR"."EMPLOYEES" VALUES ('206', 'William', 'Gietz', 'WGIETZ', '515.123.8181', TO_DATE('2002-06-07 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AC_ACCOUNT', '8300', NULL, '205', '110');

-- ----------------------------
-- Table structure for JOBS
-- ----------------------------
DROP TABLE "HR"."JOBS";
CREATE TABLE "HR"."JOBS" (
  "JOB_ID" VARCHAR2(10 BYTE) NOT NULL ,
  "JOB_TITLE" VARCHAR2(35 BYTE) NOT NULL ,
  "MIN_SALARY" NUMBER(6) ,
  "MAX_SALARY" NUMBER(6) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "HR"."JOBS"."JOB_ID" IS 'Primary key of jobs table.';
COMMENT ON COLUMN "HR"."JOBS"."JOB_TITLE" IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';
COMMENT ON COLUMN "HR"."JOBS"."MIN_SALARY" IS 'Minimum salary for a job title.';
COMMENT ON COLUMN "HR"."JOBS"."MAX_SALARY" IS 'Maximum salary for a job title';
COMMENT ON TABLE "HR"."JOBS" IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

-- ----------------------------
-- Records of "JOBS"
-- ----------------------------
INSERT INTO "HR"."JOBS" VALUES ('AD_PRES', 'President', '20080', '40000');
INSERT INTO "HR"."JOBS" VALUES ('AD_VP', 'Administration Vice President', '15000', '30000');
INSERT INTO "HR"."JOBS" VALUES ('AD_ASST', 'Administration Assistant', '3000', '6000');
INSERT INTO "HR"."JOBS" VALUES ('FI_MGR', 'Finance Manager', '8200', '16000');
INSERT INTO "HR"."JOBS" VALUES ('FI_ACCOUNT', 'Accountant', '4200', '9000');
INSERT INTO "HR"."JOBS" VALUES ('AC_MGR', 'Accounting Manager', '8200', '16000');
INSERT INTO "HR"."JOBS" VALUES ('AC_ACCOUNT', 'Public Accountant', '4200', '9000');
INSERT INTO "HR"."JOBS" VALUES ('SA_MAN', 'Sales Manager', '10000', '20080');
INSERT INTO "HR"."JOBS" VALUES ('SA_REP', 'Sales Representative', '6000', '12008');
INSERT INTO "HR"."JOBS" VALUES ('PU_MAN', 'Purchasing Manager', '8000', '15000');
INSERT INTO "HR"."JOBS" VALUES ('PU_CLERK', 'Purchasing Clerk', '2500', '5500');
INSERT INTO "HR"."JOBS" VALUES ('ST_MAN', 'Stock Manager', '5500', '8500');
INSERT INTO "HR"."JOBS" VALUES ('ST_CLERK', 'Stock Clerk', '2008', '5000');
INSERT INTO "HR"."JOBS" VALUES ('SH_CLERK', 'Shipping Clerk', '2500', '5500');
INSERT INTO "HR"."JOBS" VALUES ('IT_PROG', 'Programmer', '4000', '10000');
INSERT INTO "HR"."JOBS" VALUES ('MK_MAN', 'Marketing Manager', '9000', '15000');
INSERT INTO "HR"."JOBS" VALUES ('MK_REP', 'Marketing Representative', '4000', '9000');
INSERT INTO "HR"."JOBS" VALUES ('HR_REP', 'Human Resources Representative', '4000', '9000');
INSERT INTO "HR"."JOBS" VALUES ('PR_REP', 'Public Relations Representative', '4500', '10500');

-- ----------------------------
-- Table structure for JOB_HISTORY
-- ----------------------------
DROP TABLE "HR"."JOB_HISTORY";
CREATE TABLE "HR"."JOB_HISTORY" (
  "EMPLOYEE_ID" NUMBER(6) NOT NULL ,
  "START_DATE" DATE NOT NULL ,
  "END_DATE" DATE NOT NULL ,
  "JOB_ID" VARCHAR2(10 BYTE) NOT NULL ,
  "DEPARTMENT_ID" NUMBER(4) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "HR"."JOB_HISTORY"."EMPLOYEE_ID" IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';
COMMENT ON COLUMN "HR"."JOB_HISTORY"."START_DATE" IS 'A not null column in the complex primary key employee_id+start_date.
Must be less than the end_date of the job_history table. (enforced by
constraint jhist_date_interval)';
COMMENT ON COLUMN "HR"."JOB_HISTORY"."END_DATE" IS 'Last day of the employee in this job role. A not null column. Must be
greater than the start_date of the job_history table.
(enforced by constraint jhist_date_interval)';
COMMENT ON COLUMN "HR"."JOB_HISTORY"."JOB_ID" IS 'Job role in which the employee worked in the past; foreign key to
job_id column in the jobs table. A not null column.';
COMMENT ON COLUMN "HR"."JOB_HISTORY"."DEPARTMENT_ID" IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';
COMMENT ON TABLE "HR"."JOB_HISTORY" IS 'Table that stores job history of the employees. If an employee
changes departments within the job or changes jobs within the department,
new rows get inserted into this table with old job information of the
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

-- ----------------------------
-- Records of "JOB_HISTORY"
-- ----------------------------
INSERT INTO "HR"."JOB_HISTORY" VALUES ('102', TO_DATE('2001-01-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2006-07-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'IT_PROG', '60');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('101', TO_DATE('1997-09-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2001-10-27 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AC_ACCOUNT', '110');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('101', TO_DATE('2001-10-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2005-03-15 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AC_MGR', '110');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('201', TO_DATE('2004-02-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2007-12-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'MK_REP', '20');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('114', TO_DATE('2006-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2007-12-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '50');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('122', TO_DATE('2007-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2007-12-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ST_CLERK', '50');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('200', TO_DATE('1995-09-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2001-06-17 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AD_ASST', '90');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('176', TO_DATE('2006-03-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2006-12-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_REP', '80');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('176', TO_DATE('2007-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2007-12-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'SA_MAN', '80');
INSERT INTO "HR"."JOB_HISTORY" VALUES ('200', TO_DATE('2002-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2006-12-31 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'AC_ACCOUNT', '90');

-- ----------------------------
-- Table structure for LOCATIONS
-- ----------------------------
DROP TABLE "HR"."LOCATIONS";
CREATE TABLE "HR"."LOCATIONS" (
  "LOCATION_ID" NUMBER(4) NOT NULL ,
  "STREET_ADDRESS" VARCHAR2(40 BYTE) ,
  "POSTAL_CODE" VARCHAR2(12 BYTE) ,
  "CITY" VARCHAR2(30 BYTE) NOT NULL ,
  "STATE_PROVINCE" VARCHAR2(25 BYTE) ,
  "COUNTRY_ID" CHAR(2 BYTE) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "HR"."LOCATIONS"."LOCATION_ID" IS 'Primary key of locations table';
COMMENT ON COLUMN "HR"."LOCATIONS"."STREET_ADDRESS" IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';
COMMENT ON COLUMN "HR"."LOCATIONS"."POSTAL_CODE" IS 'Postal code of the location of an office, warehouse, or production site
of a company. ';
COMMENT ON COLUMN "HR"."LOCATIONS"."CITY" IS 'A not null column that shows city where an office, warehouse, or
production site of a company is located. ';
COMMENT ON COLUMN "HR"."LOCATIONS"."STATE_PROVINCE" IS 'State or Province where an office, warehouse, or production site of a
company is located.';
COMMENT ON COLUMN "HR"."LOCATIONS"."COUNTRY_ID" IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';
COMMENT ON TABLE "HR"."LOCATIONS" IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

-- ----------------------------
-- Records of "LOCATIONS"
-- ----------------------------
INSERT INTO "HR"."LOCATIONS" VALUES ('1000', '1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT');
INSERT INTO "HR"."LOCATIONS" VALUES ('1100', '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT');
INSERT INTO "HR"."LOCATIONS" VALUES ('1200', '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP');
INSERT INTO "HR"."LOCATIONS" VALUES ('1300', '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP');
INSERT INTO "HR"."LOCATIONS" VALUES ('1400', '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO "HR"."LOCATIONS" VALUES ('1500', '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO "HR"."LOCATIONS" VALUES ('1600', '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO "HR"."LOCATIONS" VALUES ('1700', '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO "HR"."LOCATIONS" VALUES ('1800', '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO "HR"."LOCATIONS" VALUES ('1900', '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO "HR"."LOCATIONS" VALUES ('2000', '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN');
INSERT INTO "HR"."LOCATIONS" VALUES ('2100', '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN');
INSERT INTO "HR"."LOCATIONS" VALUES ('2200', '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU');
INSERT INTO "HR"."LOCATIONS" VALUES ('2300', '198 Clementi North', '540198', 'Singapore', NULL, 'SG');
INSERT INTO "HR"."LOCATIONS" VALUES ('2400', '8204 Arthur St', NULL, 'London', NULL, 'UK');
INSERT INTO "HR"."LOCATIONS" VALUES ('2500', 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK');
INSERT INTO "HR"."LOCATIONS" VALUES ('2600', '9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK');
INSERT INTO "HR"."LOCATIONS" VALUES ('2700', 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE');
INSERT INTO "HR"."LOCATIONS" VALUES ('2800', 'Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR');
INSERT INTO "HR"."LOCATIONS" VALUES ('2900', '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH');
INSERT INTO "HR"."LOCATIONS" VALUES ('3000', 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH');
INSERT INTO "HR"."LOCATIONS" VALUES ('3100', 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL');
INSERT INTO "HR"."LOCATIONS" VALUES ('3200', 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX');

-- ----------------------------
-- Table structure for MONTH_SALARY
-- ----------------------------
DROP TABLE "HR"."MONTH_SALARY";
CREATE TABLE "HR"."MONTH_SALARY" (
  "MAGAM_DATE" DATE NOT NULL ,
  "DEPARTMENT_ID" NUMBER ,
  "EMP_COUNT" NUMBER ,
  "TOTAL_SALARY" NUMBER(9,2) ,
  "AVERAGE_SALARY" NUMBER(9,2) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of "MONTH_SALARY"
-- ----------------------------
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '100', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '30', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), NULL, NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '90', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '20', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '70', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '110', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '50', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '80', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '40', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '60', NULL, NULL, NULL);
INSERT INTO "HR"."MONTH_SALARY" VALUES (TO_DATE('2020-01-31 12:06:01', 'SYYYY-MM-DD HH24:MI:SS'), '10', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for REGIONS
-- ----------------------------
DROP TABLE "HR"."REGIONS";
CREATE TABLE "HR"."REGIONS" (
  "REGION_ID" NUMBER NOT NULL ,
  "REGION_NAME" VARCHAR2(25 BYTE) 
)
TABLESPACE "USERS"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of "REGIONS"
-- ----------------------------
INSERT INTO "HR"."REGIONS" VALUES ('1', 'Europe');
INSERT INTO "HR"."REGIONS" VALUES ('2', 'Americas');
INSERT INTO "HR"."REGIONS" VALUES ('3', 'Asia');
INSERT INTO "HR"."REGIONS" VALUES ('4', 'Middle East and Africa');

-- ----------------------------
-- View structure for EMP_DETAILS_VIEW
-- ----------------------------
CREATE OR REPLACE VIEW "HR"."EMP_DETAILS_VIEW" AS SELECT
  e.employee_id,
  e.job_id,
  e.manager_id,
  e.department_id,
  d.location_id,
  l.country_id,
  e.first_name,
  e.last_name,
  e.salary,
  e.commission_pct,
  d.department_name,
  j.job_title,
  l.city,
  l.state_province,
  c.country_name,
  r.region_name
FROM
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id
  AND l.country_id = c.country_id
  AND c.region_id = r.region_id
  AND j.job_id = e.job_id WITH READ ONLY CONSTRAINTS "SYS_C004102";

-- ----------------------------
-- Function structure for ADD_JOB_HISTORY
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "HR"."ADD_JOB_HISTORY" AS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date,
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/

-- ----------------------------
-- Function structure for SECURE_DML
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "HR"."SECURE_DML" AS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205,
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;
/

-- ----------------------------
-- Sequence structure for DEPARTMENTS_SEQ
-- ----------------------------
DROP SEQUENCE "HR"."DEPARTMENTS_SEQ";
CREATE SEQUENCE "HR"."DEPARTMENTS_SEQ" MINVALUE 1 MAXVALUE 9990 INCREMENT BY 10 NOCACHE;

-- ----------------------------
-- Sequence structure for EMPLOYEES_SEQ
-- ----------------------------
DROP SEQUENCE "HR"."EMPLOYEES_SEQ";
CREATE SEQUENCE "HR"."EMPLOYEES_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 NOCACHE;

-- ----------------------------
-- Sequence structure for LOCATIONS_SEQ
-- ----------------------------
DROP SEQUENCE "HR"."LOCATIONS_SEQ";
CREATE SEQUENCE "HR"."LOCATIONS_SEQ" MINVALUE 1 MAXVALUE 9900 INCREMENT BY 100 NOCACHE;

-- ----------------------------
-- Primary Key structure for table COUNTRIES
-- ----------------------------
ALTER TABLE "HR"."COUNTRIES" ADD CONSTRAINT "COUNTRY_C_ID_PK" PRIMARY KEY ("COUNTRY_ID");

-- ----------------------------
-- Checks structure for table COUNTRIES
-- ----------------------------
ALTER TABLE "HR"."COUNTRIES" ADD CONSTRAINT "COUNTRY_ID_NN" CHECK ("COUNTRY_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table DEPARTMENTS
-- ----------------------------
ALTER TABLE "HR"."DEPARTMENTS" ADD CONSTRAINT "DEPT_ID_PK" PRIMARY KEY ("DEPARTMENT_ID");

-- ----------------------------
-- Checks structure for table DEPARTMENTS
-- ----------------------------
ALTER TABLE "HR"."DEPARTMENTS" ADD CONSTRAINT "DEPT_NAME_NN" CHECK ("DEPARTMENT_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table DEPARTMENTS
-- ----------------------------
CREATE INDEX "HR"."DEPT_LOCATION_IX"
  ON "HR"."DEPARTMENTS" ("LOCATION_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table EMPLOYEES
-- ----------------------------
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_EMP_ID_PK" PRIMARY KEY ("EMPLOYEE_ID");

-- ----------------------------
-- Uniques structure for table EMPLOYEES
-- ----------------------------
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_UK" UNIQUE ("EMAIL") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table EMPLOYEES
-- ----------------------------
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_EMAIL_NN" CHECK ("EMAIL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_HIRE_DATE_NN" CHECK ("HIRE_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_JOB_NN" CHECK ("JOB_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_LAST_NAME_NN" CHECK ("LAST_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_SALARY_MIN" CHECK (salary > 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table EMPLOYEES
-- ----------------------------
CREATE INDEX "HR"."EMP_DEPARTMENT_IX"
  ON "HR"."EMPLOYEES" ("DEPARTMENT_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."EMP_JOB_IX"
  ON "HR"."EMPLOYEES" ("JOB_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."EMP_MANAGER_IX"
  ON "HR"."EMPLOYEES" ("MANAGER_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."EMP_NAME_IX"
  ON "HR"."EMPLOYEES" ("LAST_NAME" ASC, "FIRST_NAME" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Triggers structure for table EMPLOYEES
-- ----------------------------
CREATE TRIGGER "HR"."SECURE_EMPLOYEES" BEFORE DELETE OR INSERT OR UPDATE ON "HR"."EMPLOYEES" REFERENCING OLD AS "OLD" NEW AS "NEW" DISABLE 
BEGIN
  secure_dml;
END secure_employees;
/
CREATE TRIGGER "HR"."UPDATE_JOB_HISTORY" AFTER UPDATE OF "DEPARTMENT_ID", "JOB_ID" ON "HR"."EMPLOYEES" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate,
                  :old.job_id, :old.department_id);
END;
/

-- ----------------------------
-- Primary Key structure for table JOBS
-- ----------------------------
ALTER TABLE "HR"."JOBS" ADD CONSTRAINT "JOB_ID_PK" PRIMARY KEY ("JOB_ID");

-- ----------------------------
-- Checks structure for table JOBS
-- ----------------------------
ALTER TABLE "HR"."JOBS" ADD CONSTRAINT "JOB_TITLE_NN" CHECK ("JOB_TITLE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table JOB_HISTORY
-- ----------------------------
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_ID_ST_DATE_PK" PRIMARY KEY ("EMPLOYEE_ID", "START_DATE");

-- ----------------------------
-- Checks structure for table JOB_HISTORY
-- ----------------------------
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_DATE_INTERVAL" CHECK (end_date > start_date) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_EMPLOYEE_NN" CHECK ("EMPLOYEE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_END_DATE_NN" CHECK ("END_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_NN" CHECK ("JOB_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_START_DATE_NN" CHECK ("START_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table JOB_HISTORY
-- ----------------------------
CREATE INDEX "HR"."JHIST_DEPARTMENT_IX"
  ON "HR"."JOB_HISTORY" ("DEPARTMENT_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."JHIST_EMPLOYEE_IX"
  ON "HR"."JOB_HISTORY" ("EMPLOYEE_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."JHIST_JOB_IX"
  ON "HR"."JOB_HISTORY" ("JOB_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table LOCATIONS
-- ----------------------------
ALTER TABLE "HR"."LOCATIONS" ADD CONSTRAINT "LOC_ID_PK" PRIMARY KEY ("LOCATION_ID");

-- ----------------------------
-- Checks structure for table LOCATIONS
-- ----------------------------
ALTER TABLE "HR"."LOCATIONS" ADD CONSTRAINT "LOC_CITY_NN" CHECK ("CITY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table LOCATIONS
-- ----------------------------
CREATE INDEX "HR"."LOC_CITY_IX"
  ON "HR"."LOCATIONS" ("CITY" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."LOC_COUNTRY_IX"
  ON "HR"."LOCATIONS" ("COUNTRY_ID" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);
CREATE INDEX "HR"."LOC_STATE_PROVINCE_IX"
  ON "HR"."LOCATIONS" ("STATE_PROVINCE" ASC)
  LOGGING
  TABLESPACE "USERS"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Checks structure for table MONTH_SALARY
-- ----------------------------
ALTER TABLE "HR"."MONTH_SALARY" ADD CONSTRAINT "SYS_C007040" CHECK ("MAGAM_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table REGIONS
-- ----------------------------
ALTER TABLE "HR"."REGIONS" ADD CONSTRAINT "REG_ID_PK" PRIMARY KEY ("REGION_ID");

-- ----------------------------
-- Checks structure for table REGIONS
-- ----------------------------
ALTER TABLE "HR"."REGIONS" ADD CONSTRAINT "REGION_ID_NN" CHECK ("REGION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table COUNTRIES
-- ----------------------------
ALTER TABLE "HR"."COUNTRIES" ADD CONSTRAINT "COUNTR_REG_FK" FOREIGN KEY ("REGION_ID") REFERENCES "REGIONS" ("REGION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table DEPARTMENTS
-- ----------------------------
ALTER TABLE "HR"."DEPARTMENTS" ADD CONSTRAINT "DEPT_LOC_FK" FOREIGN KEY ("LOCATION_ID") REFERENCES "LOCATIONS" ("LOCATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."DEPARTMENTS" ADD CONSTRAINT "DEPT_MGR_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table EMPLOYEES
-- ----------------------------
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES "JOBS" ("JOB_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."EMPLOYEES" ADD CONSTRAINT "EMP_MANAGER_FK" FOREIGN KEY ("MANAGER_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table JOB_HISTORY
-- ----------------------------
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_DEPT_FK" FOREIGN KEY ("DEPARTMENT_ID") REFERENCES "DEPARTMENTS" ("DEPARTMENT_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_EMP_FK" FOREIGN KEY ("EMPLOYEE_ID") REFERENCES "EMPLOYEES" ("EMPLOYEE_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "HR"."JOB_HISTORY" ADD CONSTRAINT "JHIST_JOB_FK" FOREIGN KEY ("JOB_ID") REFERENCES "JOBS" ("JOB_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table LOCATIONS
-- ----------------------------
ALTER TABLE "HR"."LOCATIONS" ADD CONSTRAINT "LOC_C_ID_FK" FOREIGN KEY ("COUNTRY_ID") REFERENCES "COUNTRIES" ("COUNTRY_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
