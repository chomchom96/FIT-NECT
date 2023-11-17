DROP DATABASE IF EXISTS ssafit;
CREATE DATABASE ssafit;
USE ssafit;

CREATE TABLE user(
	user_seq INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id VARCHAR(20) UNIQUE NOT NULL,
	user_password VARCHAR(20),
    user_email VARCHAR(50) UNIQUE,
    user_nickname VARCHAR(20) UNIQUE,
    is_kakao SMALLINT DEFAULT 0
)ENGINE = InnoDB;

CREATE TABLE trainer(
	trainer_seq INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	trainer_id VARCHAR(20) UNIQUE NOT NULL,
	trainer_password VARCHAR(20) NOT NULL,
    trainer_email VARCHAR(50) UNIQUE,
    trainer_nickname VARCHAR(20) UNIQUE
)ENGINE = InnoDB;

CREATE TABLE user_detail(
	user_seq INT NOT NULL PRIMARY KEY ,
	user_profile_pic VARCHAR(2000),
	# user detail
	user_gender TINYINT, # 0 : 남
	user_age INT,
	user_height NUMERIC,
	user_weight NUMERIC,
	user_preferred_place VARCHAR(10),
	user_extra VARCHAR(50),
    trainer_id VARCHAR(20),
	FOREIGN KEY (user_seq) REFERENCES user (user_seq)
)ENGINE = InnoDB;

CREATE TABLE trainer_detail(
	trainer_seq INT NOT NULL PRIMARY KEY ,
	trainer_profile_pic VARCHAR(2000),
	# trainer detail
    trainer_experience VARCHAR(30), 
	trainer_extra VARCHAR(50),
    user_id VARCHAR(20),
	FOREIGN KEY (trainer_seq) REFERENCES trainer (trainer_seq)
)ENGINE = InnoDB;


CREATE TABLE user_schedule(
	user_seq INT NOT NULL PRIMARY KEY,
	user_schedule TEXT NOT NULL,
	CONSTRAINT fk_user_seq_schedule
		FOREIGN KEY (user_seq) 
		REFERENCES User (user_seq)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
)ENGINE = InnoDB;

CREATE TABLE video (
	video_id INT NOT NULL AUTO_INCREMENT unique PRIMARY KEY,
	video_title VARCHAR(100) NOT NULL,
	video_url VARCHAR(100) NOT NULL,
	video_part VARCHAR(20) NOT NULL,
    video_created_at DATETIME DEFAULT NOW(),
    video_view_cnt INT DEFAULT 0
)ENGINE = InnoDB;

CREATE TABLE review (
	review_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	video_id INT NOT NULL,
	user_id VARCHAR(20) NOT NULL,
	review_created_at DATETIME DEFAULT NOW(),
	review_title VARCHAR(100),
	review_content VARCHAR(255)
) ENGINE = InnoDB;

CREATE TABLE board(
	board_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	board_title VARCHAR(200) NOT NULL,
	board_user_id VARCHAR(20) NOT NULL, #user Id -> 데이터 인서트 할때 외부 테이블 (user)에서 가져와야함
	board_content VARCHAR(1000) NOT NULL,
	board_file VARCHAR(100),
    board_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    board_view_cnt INT NOT NULL DEFAULT 0, 
    CONSTRAINT fk_user_seq_board
	FOREIGN KEY (board_user_id) 
    REFERENCES user (user_id)
    ON DELETE NO ACTION
	ON UPDATE CASCADE
)ENGINE = InnoDB;

CREATE TABLE followings (
	user_id VARCHAR(20) NOT NULL UNIQUE,
	following_id VARCHAR(20) NOT NULL UNIQUE,
	PRIMARY KEY (user_id, following_id)
	
)ENGINE = InnoDB;

CREATE TABLE bookmarks (
	user_id VARCHAR(20) NOT NULL,
	video_id INT NOT NULL,
	PRIMARY KEY(user_id, video_id),
    CONSTRAINT fk_user_id_bookmarks
	FOREIGN KEY (user_id) 
    REFERENCES user(user_id),
    CONSTRAINT fk_video_id_bookmarks
	FOREIGN KEY (video_id) 
    REFERENCES video(video_id)
    
)ENGINE = InnoDB;



-- user
select * from user;

insert into user (user_id, user_password, user_email, user_nickname, is_kakao) values 
  ("admin", "1234", "admin@naver.com", "관리자", 0);
insert into user (user_id, user_password, user_email, user_nickname, is_kakao) values 
  ("ssafy", "ssafy", "ssafy@naver.com", "싸피", 0);
insert into user (user_id, user_password, user_email, user_nickname, is_kakao) values 
  ("samsung", "joosik", "samsung@naver.com", "삼성", 0);
insert into user (user_id, user_password, user_email, user_nickname, is_kakao) values 
  ("baek", "ju", "kakakopachip@gmail.com", "치킨", 0);
insert into user (user_id, user_email, user_nickname, is_kakao) values 
  ("kakao", "kakao@kakao.com", "카카오연동", 1);

select * from user;


-- user_detail
insert into user_detail (user_seq, user_profile_pic, user_gender, user_age, user_height, user_weight, user_preferred_place, user_extra, trainer_id) values 
  (1, null, 1, 28, 180, 75, "헬스장", "운동을 즐겨합니다!", "trainer_1");
insert into user_detail (user_seq, user_profile_pic, user_gender, user_age, user_height, user_weight, user_preferred_place, user_extra, trainer_id) values 
  (2, "프로필_사진_링크", 2, 25, 162, 48, "집", "홈트레이닝 선호", "trainer_2");
insert into user_detail (user_seq, user_profile_pic, user_gender, user_age, user_height, user_weight, user_preferred_place, user_extra, trainer_id) values 
  (3, "프로필_사진_링크", 2, 38, 177, 65, "실외", "런데이 같은 유산소운동 선호", "trainer_3");
insert into user_detail (user_seq, user_profile_pic, user_gender, user_age, user_height, user_weight, user_preferred_place, user_extra, trainer_id) values 
  (4, "프로필_사진_링크", 1, 32, 173, 70, "실외", "운동 동호회를 하고 있음", "trainer_4");
insert into user_detail (user_seq, user_profile_pic, user_gender, user_age, user_height, user_weight, user_preferred_place, user_extra, trainer_id) values 
  (5, "프로필_사진_링크", 1, 29, 198, 102, "헬스장", "싸피의 대표헬창", "trainer_5");

select * from user_detail;

  
-- board
insert into board (board_title, board_user_id, board_content) values ("공지사항", "admin", "떠들지 마시오");
insert into board (board_title, board_user_id, board_content, board_file) values ("운동 재밌음?", "ssafy", "나도 ㅎㅎ", null);
insert into board (board_title, board_user_id, board_content) values 
("여기 아무도 관리안하나요?", "baek", "관리자 일 안함?");
insert into board (board_title, board_user_id, board_content) values 
("오늘도 운동 완료", "samsung", "운동 마치고 플젝하러갑니다");
insert into board (board_title, board_user_id, board_content) values 
("다들 목표가 어떻게 되세요?", "kakao", "저는 싸피를 대표하는 헬창이 되고 싶습니다");
select * from board;


-- followings
insert into followings values ("admin", "ssafy");
insert into followings values ("ssafy", "admin"); -- 맞팔
insert into followings values ("samsung", "baek");
-- delete from followings where (user_id, following_id) =("admin", "ssafy");
-- select * from followings;
select following_id followId from followings where user_id= "admin";

-- trainer
insert into trainer (trainer_id, trainer_password, trainer_email, trainer_nickname) values 
  ("trainer_1", "1234", "trainer1@naver.com", "체대생");
insert into trainer (trainer_id, trainer_password, trainer_email, trainer_nickname) values 
  ("trainer_2", "1234", "trainer2@example.com", "싸피헬스");
insert into trainer (trainer_id, trainer_password, trainer_email, trainer_nickname) values 
  ("trainer_3", "1234", "trainer3@example.com", "이지트레이닝");
insert into trainer (trainer_id, trainer_password, trainer_email, trainer_nickname) values 
  ("trainer_4", "1234", "trainer4@example.com", "완벽한몸");
insert into trainer (trainer_id, trainer_password, trainer_email, trainer_nickname) values 
  ("trainer_5", "1234", "trainer5@example.com", "요가의신");
  
select * from trainer;

-- trainer_detail 
insert into trainer_detail (trainer_seq, trainer_profile_pic, trainer_experience, trainer_extra, user_id) values 
  (1, "트레이너_프로필이미지_링크", "ㅇㅇ대학교 체육학과 졸업", "건강관리운동 전문", "admin");
insert into trainer_detail (trainer_seq, trainer_profile_pic, trainer_experience, trainer_extra, user_id) values 
  (2, "트레이너_프로필이미지_링크", "역삼 싸피피트니스 수석 트레이너", "원하는 몸, 만들어드립니다", "ssafy");
insert into trainer_detail (trainer_seq, trainer_profile_pic, trainer_experience, trainer_extra, user_id) values 
  (3, "트레이너_프로필이미지_링크", "생활체육관리사 자격증 유", "실생활운동을 가르쳐드립니다", "baek");
insert into trainer_detail (trainer_seq, trainer_profile_pic, trainer_experience, trainer_extra, user_id) values 
  (4, "트레이너_프로필이미지_링크", "강남 자바짐 5년 경력 트레이너", "바디 프로필 전문", "samsung");
insert into trainer_detail (trainer_seq, trainer_profile_pic, trainer_experience, trainer_extra, user_id) values 
  (5, "트레이너_프로필이미지_링크", "요가/필라테스 강사 2년 경력", "요가/필라테스 전문", "kakao");
  
select * from trainer_detail; 

-- video
insert into video (video_title, video_url, video_part) values ("집에서 칼로리 불태우는 최고의 유산소운동 [칼소폭 매운맛]", "https://www.youtube.com/watch?v=lKwZ2DU4P-A", "유산소"); 
insert into video (video_title, video_url, video_part) values ("뱃살 아랫뱃살 최고의 운동", "https://www.youtube.com/watch?v=0L5gAT1fJaM", "복부"); 
insert into video (video_title, video_url, video_part) values ("허벅지살 다리살 최고의 운동", "https://www.youtube.com/watch?v=LK9e6mg4cmQ", "다리"); 


-- review (video에 다는 리뷰)
insert into review (video_id, user_id, review_title, review_content) values (1, "admin", "재미없네", "노잼");
insert into review (video_id, user_id, review_title, review_content) values (1, "ssafy", "어려워용", "나만그럼?");
insert into review (video_id, user_id, review_title, review_content) values (1, "samsung", "삭제해라", "애송이");
insert into review (video_id, user_id, review_title, review_content) values (1, "baek", "백천주", "운동마스터");

insert into review (video_id, user_id, review_title, review_content) values (2, "admin", "넘빡셈", "어케함;;");
insert into review (video_id, user_id, review_title, review_content) values 
  (2, "ssafy", "힘들어요", "이걸 대체 어떻게 따라하라고?");
  
insert into review (video_id, user_id, review_title, review_content) values (3, "kakao", "대박", "이걸로 15kg뺌");
insert into review (video_id, user_id, review_title, review_content) values 
  (3, "admin", "강추합니다", "관리자인 제가 강추하는 운동");
  
insert into review (video_id, user_id, review_title, review_content) values (4, "samsung", "이 운동은", "싸피 정규 커리큘럼에 넣어야함");
insert into review (video_id, user_id, review_title, review_content) values 
  (4, "baek", "힘들지만", "목표 몸무게를 위해서!");

select * from review;


-- bookmarks
insert into bookmarks (user_id, video_id) values ("admin", 1);
insert into bookmarks (user_id, video_id) values ("admin", 2);
insert into bookmarks (user_id, video_id) values ("ssafy", 1);
-- delete from bookmarks where (user_id, video_id) = ("admin", 1);
select * from bookmarks;
select video_id videoId from bookmarks where user_id="admin";
