CREATE TABLE "MEMBER"(
	MEM_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
	MEM_ID VARCHAR2(30) NOT NULL,
	MEM_PW VARCHAR2(30) NOT NULL,
	MEM_NM VARCHAR2(30) NOT NULL,
	MEM_GENDER CHAR(1) CONSTRAINT GENDER_CHK CHECK(MEM_GENDER IN('M','F')),
	ENROLL_DT DATE DEFAULT SYSDATE NOT NULL,
	UNREGISTER_FL CHAR(1) DEFAULT 'N'
	CONSTRAINT UNREGISTER_CHECK CHECK(UNREGISTER_FL IN('Y','N'))
);


COMMENT ON COLUMN "MEMBER".MEM_NO IS '회원번호(시퀀스 SEQ_MEMBER_NO)';
COMMENT ON COLUMN "MEMBER".MEM_ID IS '회원 아이디';
COMMENT ON COLUMN "MEMBER".MEM_PW IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER".MEM_NM IS '회원 이름';
COMMENT ON COLUMN "MEMBER".MEM_GENDER IS '성별(M/F)';
COMMENT ON COLUMN "MEMBER".ENROLL_DT IS '가입일';
COMMENT ON COLUMN "MEMBER".UNREGISTER_FL  IS '탈퇴여부(Y/N)';



-- 게시판(BOARD) 테이블
CREATE TABLE "BOARD" (
	"B_NO"	NUMBER		NOT NULL,
	"B_TITLE"	VARCHAR2(600)		NOT NULL,
	"B_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"CREATE_DT"	DATE	DEFAULT SYSDATE	NULL,
	"READ_COUNT"	NUMBER	DEFAULT 0	NOT NULL,
	"DELETE_FL"	CHAR(1)	DEFAULT 'N'	CHECK("DELETE_FL" IN ('Y','N')),
	"MEM_NO"	NUMBER	NOT NULL,
	CONSTRAINT BOARD_MEMBER_FK
	FOREIGN KEY("MEM_NO") REFERENCES "MEMBER"(MEM_NO)
);


COMMENT ON COLUMN "BOARD"."B_NO" IS '게시글 번호 (시퀀스 SEQ_BOARD_NO)';
COMMENT ON COLUMN "BOARD"."B_TITLE" IS '게시글 제목';
COMMENT ON COLUMN "BOARD"."B_CONTENT" IS '게시글 내용';
COMMENT ON COLUMN "BOARD"."CREATE_DT" IS '작성일';
COMMENT ON COLUMN "BOARD"."READ_COUNT" IS '조회수';
COMMENT ON COLUMN "BOARD"."DELETE_FL" IS '삭제여부(Y/N)';
COMMENT ON COLUMN "BOARD"."MEM_NO" IS '회원번호(FK)';

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"B_NO"
);




-- 댓글(COMMENT) 테이블
CREATE TABLE "COMMENT" (
	"COM_NO"	NUMBER		NOT NULL,
	"COM_CONTENT"	VARCHAR2(2000)		NOT NULL,
	"CREATE_DT"	DATE	DEFAULT SYSDATE	NULL,
	"DELETE_FL"	CHAR(1)	DEFAULT 'N'	CHECK("DELETE_FL" IN ('Y','N')),
	"MEM_NO"	NUMBER	NOT NULL 
	CONSTRAINT COMMENT_MEMBER_FK REFERENCES "MEMBER"(MEM_NO),
	"B_NO"	NUMBER	NOT NULL
	CONSTRAINT COMMENT_BOARD_FK REFERENCES "BOARD"(B_NO)
);

COMMENT ON COLUMN "COMMENT"."COM_NO" IS '댓글 번호 (시퀀스 SEQ_COMMENT_NO)';
COMMENT ON COLUMN "COMMENT"."COM_CONTENT" IS '댓글 내용';
COMMENT ON COLUMN "COMMENT"."CREATE_DT" IS '댓글 작성일';
COMMENT ON COLUMN "COMMENT"."DELETE_FL" IS '삭제여부(Y/N)';
COMMENT ON COLUMN "COMMENT"."MEM_NO" IS '회원번호(FK)';
COMMENT ON COLUMN "COMMENT"."B_NO" IS '게시글번호(FK)';

ALTER TABLE "COMMENT" ADD CONSTRAINT "PK_COMMENT" PRIMARY KEY (
	"COM_NO"
);



-- SEQUENCE 생성(MEMBER, BOARD, COMMENT)
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;

-- 회원 샘플 3개 INSERT 
INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'redsea_in', 'redsea', 
	 '홍해인', 'F', DEFAULT, DEFAULT);
	
INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, O, '100_hwoo', 
	 '백현우', 'M', DEFAULT, DEFAULT);
	
INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'm3ajung', 'na', 
	 '나아정', 'F', DEFAULT, DEFAULT);
	
INSERT INTO "MEMBER"
VALUES(SEQ_MEMBER_NO.NEXTVAL, 'easy_han', 'easy', 
	 '이지한', 'M', DEFAULT, DEFAULT);	
	
	
-- 삽입 확인
SELECT * FROM "MEMBER";

COMMIT;


-- BOARD 테이블 샘플데이터 3개 삽입
INSERT INTO "BOARD"
VALUES(SEQ_BOARD_NO.NEXTVAL, '아이유 홀씨', '걔는 홀씨가 됐다구 날 따라,\ngonna go to win 날 따라,
														\n날아가 꼭대기루\nYou say 후\nI may fly\nYou say 후\nThen i fly',
					DEFAULT, DEFAULT, DEFAULT, 7);

INSERT INTO "BOARD"
VALUES(SEQ_BOARD_NO.NEXTVAL, '백현우씨', '아, 그렇게 공사 구분이 확실해서\n내가 삼진아웃 시키려고 벼르는 매장 점주한테 위반 사항 미리 귀띔해주고,
														\n살아남게 도와주고 그랬구나?', DEFAULT, DEFAULT, DEFAULT, 5);

INSERT INTO "BOARD"
VALUES(SEQ_BOARD_NO.NEXTVAL, '샘플 제목 3', '다친대도 길을 걸어 kiss me\n쉽지 않음 내가 쉽게 easy\nStage 위엔 불이 튀어, 내 body\n
							Pull up and I rip it up like ballet\nDamn, I really make it look easy\nYuh know that I make it look easy',
				DEFAULT, DEFAULT, DEFAULT, 8);

-- 삽입 확인
SELECT * FROM "BOARD";
COMMIT;


-- 댓글 샘플 데이터 3개 삽입 댓글번호/댓글내용/작성일/삭제여부/회원번호/게시글번호
INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '아이유 컴백했나요?', DEFAULT, DEFAULT,
		6, 4);

INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '그 점주님은 우리 백화점 오픈 때부터 같이 하신 분이야.\n지금도 누구보다도 열심히 하고 계시고.', DEFAULT, DEFAULT,
		6, 5);
	
INSERT INTO "COMMENT"
VALUES(SEQ_COMMENT_NO.NEXTVAL, '정말 easy한이네..', DEFAULT, DEFAULT,
		7, 6);
	
	
SELECT * FROM "COMMENT";
COMMIT;



  


COMMENT ON COLUMN "MEMBER".FOLLOWER IS '팔로워';
COMMENT ON COLUMN "MEMBER"."FOLLOWING" IS '팔로잉';
COMMIT;

SELECT * FROM "COMMENT";
SELECT * FROM "BOARD";
SELECT * FROM "MEMBER";
SELECT * FROM "FOLLOWERS";

CREATE TABLE FOLLOWERS (
	
	MEM_NO NUMBER REFERENCES "MEMBER"(MEM_NO),
	FOLLOWER_ID VARCHAR2(30),
	FOLLOWER_NAME VARCHAR2(30)
	
);

INSERT INTO FOLLOWERS VALUES(5, '100_hwooo', '백현우');
INSERT INTO FOLLOWERS VALUES(5, 'm3ajung', '나아정');
INSERT INTO FOLLOWERS VALUES(5, 'jjincomplete', '진이수');
INSERT INTO FOLLOWERS VALUES(5, 'easy_han', '이지한');
INSERT INTO FOLLOWERS VALUES(6, 'redsea_in', '홍해인');
INSERT INTO FOLLOWERS VALUES(7, 'easy_han', '이지한');
INSERT INTO FOLLOWERS VALUES(8, 'm3ajung', '나아정');
INSERT INTO FOLLOWERS VALUES(8, '100_hwooo', '백현우');
INSERT INTO FOLLOWERS VALUES(8, 'redsea_in', '홍해인');
INSERT INTO FOLLOWERS VALUES(9, 'strong_hyun', '이강현');
INSERT INTO FOLLOWERS VALUES(10, 'jjincomplete', '진이수');


COMMIT ;



SELECT FOLLOWER_ID, FOLLOWER_NAME
FROM FOLLOWERS
WHERE MEM_NO = 5;


