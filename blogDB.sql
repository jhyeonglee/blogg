--------------------------------------------------------
--  파일이 생성됨 - 월요일-1월-20-2020   
--------------------------------------------------------
DROP SEQUENCE "BLOG_SEQ";
DROP SEQUENCE "MENT_SEQ";
DROP SEQUENCE "P_SEQ";
DROP SEQUENCE "M_SEQ";
DROP TABLE "BLOG" cascade constraints;
DROP TABLE "MENT" cascade constraints;
DROP TABLE "MEMBER" cascade constraints;
DROP TABLE "POST" cascade constraints;
--------------------------------------------------------
--  DDL for Sequence BLOG_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "BLOG_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence MENT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "MENT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 81 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence P_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "P_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence M_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "M_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BLOG
--------------------------------------------------------

  CREATE TABLE "BLOG" 
   (	"BLOG_NO" NUMBER, 
	"BLOG_NM" VARCHAR2(200), 
	"BLOG_DT" DATE DEFAULT SYSDATE, 
	"BLOG_NUM" NUMBER DEFAULT 1, 
	"M_NO" NUMBER
   ) ;
--------------------------------------------------------
--  DDL for Table MENT
--------------------------------------------------------

  CREATE TABLE "MENT" 
   (	"MENT_NO" NUMBER, 
	"MENT_CON" VARCHAR2(200), 
	"M_NO" NUMBER, 
	"P_NO" NUMBER, 
	"MENT_TM" DATE DEFAULT SYSDATE
   ) ;
--------------------------------------------------------
--  DDL for Table MEMBER
--------------------------------------------------------

  CREATE TABLE "MEMBER" 
   (	"M_NO" NUMBER, 
	"M_ID" VARCHAR2(100), 
	"M_PW" VARCHAR2(100), 
	"M_NM" VARCHAR2(100)
   ) ;
--------------------------------------------------------
--  DDL for Table POST
--------------------------------------------------------

  CREATE TABLE "POST" 
   (	"P_NO" NUMBER, 
	"P_TITLE" VARCHAR2(100), 
	"P_DATE" DATE DEFAULT SYSDATE, 
	"P_HIT" NUMBER DEFAULT 0, 
	"P_CON" VARCHAR2(300), 
	"M_NO" NUMBER
   ) ;
REM INSERTING into BLOG
SET DEFINE OFF;
Insert into BLOG (BLOG_NO,BLOG_NM,BLOG_DT,BLOG_NUM,M_NO) values (8,'123123123',to_date('19/12/30','RR/MM/DD'),1,7);
Insert into BLOG (BLOG_NO,BLOG_NM,BLOG_DT,BLOG_NUM,M_NO) values (6,'LOGgggggg',to_date('19/12/30','RR/MM/DD'),1,5);
Insert into BLOG (BLOG_NO,BLOG_NM,BLOG_DT,BLOG_NUM,M_NO) values (9,'789',to_date('19/12/30','RR/MM/DD'),1,7);
Insert into BLOG (BLOG_NO,BLOG_NM,BLOG_DT,BLOG_NUM,M_NO) values (10,'123',to_date('19/12/31','RR/MM/DD'),1,7);
Insert into BLOG (BLOG_NO,BLOG_NM,BLOG_DT,BLOG_NUM,M_NO) values (11,'안녕하세요',to_date('19/12/31','RR/MM/DD'),1,8);
REM INSERTING into MENT
SET DEFINE OFF;
Insert into MENT (MENT_NO,MENT_CON,M_NO,P_NO,MENT_TM) values (47,'ㄷㄷㄷㄷㄷㄷㄷㄷㄷㄷ',9,25,to_date('20/01/06','RR/MM/DD'));
Insert into MENT (MENT_NO,MENT_CON,M_NO,P_NO,MENT_TM) values (45,'맥도날드',7,24,to_date('20/01/06','RR/MM/DD'));
Insert into MENT (MENT_NO,MENT_CON,M_NO,P_NO,MENT_TM) values (46,'맘스터치',8,24,to_date('20/01/06','RR/MM/DD'));
Insert into MENT (MENT_NO,MENT_CON,M_NO,P_NO,MENT_TM) values (44,'반갑습니다',7,23,to_date('20/01/06','RR/MM/DD'));
Insert into MENT (MENT_NO,MENT_CON,M_NO,P_NO,MENT_TM) values (43,'댓글등록',8,23,to_date('20/01/06','RR/MM/DD'));
REM INSERTING into MEMBER
SET DEFINE OFF;
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (13,'wwww1','7OuoBPncP9zRCS3U5ivR4g==','1333');
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (12,'ssss1','fqAcrS1aSTLgjJHkz5YWVQ==','987');
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (5,'asdzxc1','SF2gRTl5dCxE3DzUh+fBiw==','이름');
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (11,'asdasd','1','22223333');
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (7,'qwe1','12','이름수정');
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (8,'asdf12','0IEFSgdDlcL6K4cFt8VhFg==','아메리카노');
Insert into MEMBER (M_NO,M_ID,M_PW,M_NM) values (9,'zxcv1','0IEFSgdDlcL6K4cFt8VhFg==','이재형');
REM INSERTING into POST
SET DEFINE OFF;
Insert into POST (P_NO,P_TITLE,P_DATE,P_HIT,P_CON,M_NO) values (22,'안녕하세요',to_date('20/01/06','RR/MM/DD'),0,'어서오세요',9);
Insert into POST (P_NO,P_TITLE,P_DATE,P_HIT,P_CON,M_NO) values (25,'pc카톡 막힘',to_date('20/01/06','RR/MM/DD'),0,'ㅋ',9);
Insert into POST (P_NO,P_TITLE,P_DATE,P_HIT,P_CON,M_NO) values (27,'ffff',to_date('20/01/08','RR/MM/DD'),0,'<img alt="" src="resources/upload/202001081203083350741.png" style="height:269px; width:477px" />',9);
Insert into POST (P_NO,P_TITLE,P_DATE,P_HIT,P_CON,M_NO) values (26,'댓글확인',to_date('20/01/08','RR/MM/DD'),0,'4',9);
Insert into POST (P_NO,P_TITLE,P_DATE,P_HIT,P_CON,M_NO) values (24,'점심은 햄버거',to_date('20/01/06','RR/MM/DD'),0,'햄버거',9);
Insert into POST (P_NO,P_TITLE,P_DATE,P_HIT,P_CON,M_NO) values (23,'오늘은 월요일',to_date('20/01/06','RR/MM/DD'),0,'<img alt="" src="resources/upload/202001061157520346337.jpg" style="height:338px; width:550px" />',9);
--------------------------------------------------------
--  DDL for Index BLOG_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BLOG_PK" ON "BLOG" ("BLOG_NO") 
  ;
--------------------------------------------------------
--  DDL for Index MEMBER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MEMBER_PK" ON "MEMBER" ("M_NO") 
  ;
--------------------------------------------------------
--  DDL for Index MENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "MENT_PK" ON "MENT" ("MENT_NO") 
  ;
--------------------------------------------------------
--  DDL for Index POST_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "POST_PK" ON "POST" ("P_NO") 
  ;
--------------------------------------------------------
--  Constraints for Table BLOG
--------------------------------------------------------

  ALTER TABLE "BLOG" MODIFY ("M_NO" NOT NULL ENABLE);
  ALTER TABLE "BLOG" MODIFY ("BLOG_NUM" NOT NULL ENABLE);
  ALTER TABLE "BLOG" MODIFY ("BLOG_DT" NOT NULL ENABLE);
  ALTER TABLE "BLOG" ADD CONSTRAINT "BLOG_PK" PRIMARY KEY ("BLOG_NO") ENABLE;
  ALTER TABLE "BLOG" MODIFY ("BLOG_NM" NOT NULL ENABLE);
  ALTER TABLE "BLOG" MODIFY ("BLOG_NO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MENT
--------------------------------------------------------

  ALTER TABLE "MENT" MODIFY ("MENT_TM" NOT NULL ENABLE);
  ALTER TABLE "MENT" ADD CONSTRAINT "MENT_PK" PRIMARY KEY ("MENT_NO") ENABLE;
  ALTER TABLE "MENT" MODIFY ("P_NO" NOT NULL ENABLE);
  ALTER TABLE "MENT" MODIFY ("M_NO" NOT NULL ENABLE);
  ALTER TABLE "MENT" MODIFY ("MENT_CON" NOT NULL ENABLE);
  ALTER TABLE "MENT" MODIFY ("MENT_NO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MEMBER
--------------------------------------------------------

  ALTER TABLE "MEMBER" ADD CONSTRAINT "MEMBER_PK" PRIMARY KEY ("M_NO") ENABLE;
  ALTER TABLE "MEMBER" MODIFY ("M_NM" NOT NULL ENABLE);
  ALTER TABLE "MEMBER" MODIFY ("M_PW" NOT NULL ENABLE);
  ALTER TABLE "MEMBER" MODIFY ("M_ID" NOT NULL ENABLE);
  ALTER TABLE "MEMBER" MODIFY ("M_NO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table POST
--------------------------------------------------------

  ALTER TABLE "POST" MODIFY ("M_NO" NOT NULL ENABLE);
  ALTER TABLE "POST" MODIFY ("P_HIT" NOT NULL ENABLE);
  ALTER TABLE "POST" MODIFY ("P_DATE" NOT NULL ENABLE);
  ALTER TABLE "POST" MODIFY ("P_TITLE" NOT NULL ENABLE);
  ALTER TABLE "POST" MODIFY ("P_CON" NOT NULL ENABLE);
  ALTER TABLE "POST" ADD CONSTRAINT "POST_PK" PRIMARY KEY ("P_NO") ENABLE;
  ALTER TABLE "POST" MODIFY ("P_NO" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table BLOG
--------------------------------------------------------

  ALTER TABLE "BLOG" ADD CONSTRAINT "BLOG_FK1" FOREIGN KEY ("M_NO")
	  REFERENCES "MEMBER" ("M_NO") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MENT
--------------------------------------------------------

  ALTER TABLE "MENT" ADD CONSTRAINT "MENT_FK1" FOREIGN KEY ("P_NO")
	  REFERENCES "POST" ("P_NO") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MENT" ADD CONSTRAINT "MENT_FK3" FOREIGN KEY ("M_NO")
	  REFERENCES "MEMBER" ("M_NO") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table POST
--------------------------------------------------------

  ALTER TABLE "POST" ADD CONSTRAINT "POST_FK1" FOREIGN KEY ("M_NO")
	  REFERENCES "MEMBER" ("M_NO") ON DELETE CASCADE ENABLE;
