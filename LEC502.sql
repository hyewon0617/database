/*
 Navicat Premium Data Transfer

 Source Server         : lec502
 Source Server Type    : Oracle
 Source Server Version : 110200
 Source Host           : localhost:1521
 Source Schema         : LEC502

 Target Server Type    : Oracle
 Target Server Version : 110200
 File Encoding         : 65001

 Date: 20/01/2020 14:39:27
*/


-- ----------------------------
-- Table structure for EMPLOYEE
-- ----------------------------
DROP TABLE "LEC502"."EMPLOYEE";
CREATE TABLE "LEC502"."EMPLOYEE" (
  "EMPLOYEE_ID" NUMBER(5) NOT NULL ,
  "PASSWORD" VARCHAR2(12 BYTE) NOT NULL ,
  "EMPLOYEE_NAME" VARCHAR2(20 BYTE) NOT NULL 
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."EMPLOYEE"."EMPLOYEE_ID" IS '사원번호';
COMMENT ON COLUMN "LEC502"."EMPLOYEE"."PASSWORD" IS '사원비밀번호';
COMMENT ON COLUMN "LEC502"."EMPLOYEE"."EMPLOYEE_NAME" IS '사원번호';

-- ----------------------------
-- Table structure for ITEM_BALANCE
-- ----------------------------
DROP TABLE "LEC502"."ITEM_BALANCE";
CREATE TABLE "LEC502"."ITEM_BALANCE" (
  "ITEM_CODE" VARCHAR2(10 BYTE) NOT NULL ,
  "WH_CODE" CHAR(2 BYTE) NOT NULL ,
  "BEF_BALANCE" NUMBER(5) DEFAULT 0  ,
  "RECEIPT_QTY" NUMBER(5) DEFAULT 0  ,
  "ISSUE_QTY" NUMBER(5) DEFAULT 0  
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."ITEM_BALANCE"."ITEM_CODE" IS '품목번호';
COMMENT ON COLUMN "LEC502"."ITEM_BALANCE"."BEF_BALANCE" IS '전월재고';
COMMENT ON COLUMN "LEC502"."ITEM_BALANCE"."RECEIPT_QTY" IS '입고수량';
COMMENT ON COLUMN "LEC502"."ITEM_BALANCE"."ISSUE_QTY" IS '출고수량';

-- ----------------------------
-- Table structure for ITEM_MASTER
-- ----------------------------
DROP TABLE "LEC502"."ITEM_MASTER";
CREATE TABLE "LEC502"."ITEM_MASTER" (
  "ITEM_CODE" VARCHAR2(10 BYTE) NOT NULL ,
  "ITEM_NAME" VARCHAR2(100 BYTE) NOT NULL 
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."ITEM_MASTER"."ITEM_CODE" IS '품목코드';
COMMENT ON COLUMN "LEC502"."ITEM_MASTER"."ITEM_NAME" IS '픔목이름';

-- ----------------------------
-- Table structure for ITEM_PRICE
-- ----------------------------
DROP TABLE "LEC502"."ITEM_PRICE";
CREATE TABLE "LEC502"."ITEM_PRICE" (
  "ITEM_CODE" VARCHAR2(10 BYTE) NOT NULL ,
  "APPLY_DATE" VARCHAR2(8 BYTE) NOT NULL ,
  "PRICE" NUMBER(5) DEFAULT 0  
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."ITEM_PRICE"."ITEM_CODE" IS '품목코드';
COMMENT ON COLUMN "LEC502"."ITEM_PRICE"."APPLY_DATE" IS '가격적용일자';

-- ----------------------------
-- Table structure for ITEM_TRANSACTION
-- ----------------------------
DROP TABLE "LEC502"."ITEM_TRANSACTION";
CREATE TABLE "LEC502"."ITEM_TRANSACTION" (
  "ITEM_CODE" VARCHAR2(10 BYTE) ,
  "WH_CODE" CHAR(2 BYTE) ,
  "TR_TYPE" CHAR(1 BYTE) ,
  "TR_DATE" DATE DEFAULT SYSDATE  ,
  "TR_QTY" NUMBER DEFAULT 0  
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."ITEM_TRANSACTION"."TR_TYPE" IS '입출고구분(R=입고, i=출고)';
COMMENT ON COLUMN "LEC502"."ITEM_TRANSACTION"."TR_DATE" IS '입출고일자';
COMMENT ON COLUMN "LEC502"."ITEM_TRANSACTION"."TR_QTY" IS '입출고수량';

-- ----------------------------
-- Table structure for LOCATION
-- ----------------------------
DROP TABLE "LEC502"."LOCATION";
CREATE TABLE "LEC502"."LOCATION" (
  "LOC_CODE" VARCHAR2(4 BYTE) NOT NULL ,
  "LOCATION" VARCHAR2(100 BYTE) 
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."LOCATION"."LOC_CODE" IS '위치코드';
COMMENT ON COLUMN "LEC502"."LOCATION"."LOCATION" IS '위치이름';

-- ----------------------------
-- Table structure for TR_CODE
-- ----------------------------
DROP TABLE "LEC502"."TR_CODE";
CREATE TABLE "LEC502"."TR_CODE" (
  "TR_TYPE" CHAR(2 BYTE) ,
  "TR_DESC" VARCHAR2(100 BYTE) 
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."TR_CODE"."TR_TYPE" IS '입출고유형';
COMMENT ON COLUMN "LEC502"."TR_CODE"."TR_DESC" IS '입출고설명';

-- ----------------------------
-- Table structure for WHAREHOUSE
-- ----------------------------
DROP TABLE "LEC502"."WHAREHOUSE";
CREATE TABLE "LEC502"."WHAREHOUSE" (
  "WH_CODE" CHAR(2 BYTE) NOT NULL ,
  "WH_NAME" VARCHAR2(50 BYTE) NOT NULL ,
  "LOC_CODE" VARCHAR2(4 BYTE) 
)
TABLESPACE "SYSTEM"
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;
COMMENT ON COLUMN "LEC502"."WHAREHOUSE"."WH_CODE" IS '창고코드';
COMMENT ON COLUMN "LEC502"."WHAREHOUSE"."WH_NAME" IS '창고이름';
COMMENT ON COLUMN "LEC502"."WHAREHOUSE"."LOC_CODE" IS '창고위치';

-- ----------------------------
-- Primary Key structure for table EMPLOYEE
-- ----------------------------
ALTER TABLE "LEC502"."EMPLOYEE" ADD CONSTRAINT "SYS_C007133" PRIMARY KEY ("EMPLOYEE_ID");

-- ----------------------------
-- Checks structure for table EMPLOYEE
-- ----------------------------
ALTER TABLE "LEC502"."EMPLOYEE" ADD CONSTRAINT "SYS_C007130" CHECK ("EMPLOYEE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."EMPLOYEE" ADD CONSTRAINT "SYS_C007131" CHECK ("PASSWORD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."EMPLOYEE" ADD CONSTRAINT "SYS_C007132" CHECK ("EMPLOYEE_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table ITEM_BALANCE
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_BALANCE" ADD CONSTRAINT "SYS_C007142" PRIMARY KEY ("ITEM_CODE", "WH_CODE");

-- ----------------------------
-- Checks structure for table ITEM_BALANCE
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_BALANCE" ADD CONSTRAINT "SYS_C007140" CHECK ("ITEM_CODE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."ITEM_BALANCE" ADD CONSTRAINT "SYS_C007141" CHECK ("WH_CODE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table ITEM_MASTER
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_MASTER" ADD CONSTRAINT "SYS_C007136" PRIMARY KEY ("ITEM_CODE");

-- ----------------------------
-- Checks structure for table ITEM_MASTER
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_MASTER" ADD CONSTRAINT "SYS_C007134" CHECK ("ITEM_CODE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."ITEM_MASTER" ADD CONSTRAINT "SYS_C007135" CHECK ("ITEM_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table ITEM_PRICE
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_PRICE" ADD CONSTRAINT "SYS_C007139" PRIMARY KEY ("ITEM_CODE", "APPLY_DATE");

-- ----------------------------
-- Checks structure for table ITEM_PRICE
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_PRICE" ADD CONSTRAINT "SYS_C007137" CHECK ("ITEM_CODE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."ITEM_PRICE" ADD CONSTRAINT "SYS_C007138" CHECK ("APPLY_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table ITEM_TRANSACTION
-- ----------------------------
CREATE INDEX "LEC502"."IDX_ITEM_BALANCE"
  ON "LEC502"."ITEM_TRANSACTION" (""TR_DATE"" DESC, "WH_CODE" ASC, "ITEM_CODE" ASC, "TR_TYPE" ASC)
  LOGGING
  TABLESPACE "SYSTEM"
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  FREELISTS 1
  FREELIST GROUPS 1
  BUFFER_POOL DEFAULT
);

-- ----------------------------
-- Primary Key structure for table LOCATION
-- ----------------------------
ALTER TABLE "LEC502"."LOCATION" ADD CONSTRAINT "SYS_C007147" PRIMARY KEY ("LOC_CODE");

-- ----------------------------
-- Checks structure for table LOCATION
-- ----------------------------
ALTER TABLE "LEC502"."LOCATION" ADD CONSTRAINT "SYS_C007146" CHECK ("LOC_CODE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table WHAREHOUSE
-- ----------------------------
ALTER TABLE "LEC502"."WHAREHOUSE" ADD CONSTRAINT "SYS_C007145" PRIMARY KEY ("WH_CODE");

-- ----------------------------
-- Checks structure for table WHAREHOUSE
-- ----------------------------
ALTER TABLE "LEC502"."WHAREHOUSE" ADD CONSTRAINT "SYS_C007143" CHECK ("WH_CODE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."WHAREHOUSE" ADD CONSTRAINT "SYS_C007144" CHECK ("WH_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ITEM_BALANCE
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_BALANCE" ADD CONSTRAINT "FK_ITEM_BALANCE_ITEM_MASTER_1" FOREIGN KEY ("ITEM_CODE") REFERENCES "ITEM_MASTER" ("ITEM_CODE") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "LEC502"."ITEM_BALANCE" ADD CONSTRAINT "FK_ITEM_BALANCE_WHAREHOUSE_1" FOREIGN KEY ("WH_CODE") REFERENCES "WHAREHOUSE" ("WH_CODE") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ITEM_PRICE
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_PRICE" ADD CONSTRAINT "FK_ITEM_PRICE_ITEM_MASTER_1" FOREIGN KEY ("ITEM_CODE") REFERENCES "ITEM_MASTER" ("ITEM_CODE") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ITEM_TRANSACTION
-- ----------------------------
ALTER TABLE "LEC502"."ITEM_TRANSACTION" ADD CONSTRAINT "SYS_C007152" FOREIGN KEY ("ITEM_CODE", "WH_CODE") REFERENCES "ITEM_BALANCE" ("ITEM_CODE", "WH_CODE") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table WHAREHOUSE
-- ----------------------------
ALTER TABLE "LEC502"."WHAREHOUSE" ADD CONSTRAINT "FK_WHAREHOUSE_LOCATION_1" FOREIGN KEY ("LOC_CODE") REFERENCES "LOCATION" ("LOC_CODE") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;