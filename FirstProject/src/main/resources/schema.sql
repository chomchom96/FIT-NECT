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
	user_id VARCHAR(20) NOT NULL PRIMARY KEY ,
	user_profile_pic VARCHAR(2000),
	# user detail
	user_gender TINYINT, # 0 : 남
	user_age INT,
	user_height NUMERIC,
	user_current_weight NUMERIC,
    user_target_weight NUMERIC,
	user_preferred_place VARCHAR(10),
	user_extra VARCHAR(50)
)ENGINE = InnoDB;

CREATE TABLE trainer_detail(
	trainer_seq INT NOT NULL PRIMARY KEY ,
    trainer_id VARCHAR(20) NOT NULL,
    trainer_name VARCHAR(20) NOT NULL,
	trainer_profile_pic VARCHAR(2000),
	# trainer detail
    trainer_experience VARCHAR(30), 
	trainer_extra VARCHAR(50),
	FOREIGN KEY (trainer_seq) REFERENCES trainer (trainer_seq)
)ENGINE = InnoDB;

CREATE TABLE matched(
	trainer_id VARCHAR(20) NOT NULL,
    user_id VARCHAR(20) NOT NULL,
	PRIMARY KEY(user_id, trainer_id)
)ENGINE = InnoDB;

insert into matched values ("trainer_1", "ssafy");
CREATE TABLE user_schedule(
	user_id VARCHAR(20) NOT NULL PRIMARY KEY,
	user_schedule TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user (user_id)
)ENGINE = InnoDB;

CREATE TABLE video (
	video_id INT NOT NULL AUTO_INCREMENT unique PRIMARY KEY,
	video_title VARCHAR(100) NOT NULL,
	video_url VARCHAR(100) NOT NULL,
	video_part VARCHAR(100) NOT NULL,
    video_created_at DATETIME DEFAULT NOW(),
    video_view_cnt INT DEFAULT 0,
    video_channel_name VARCHAR(100) NOT NULL
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
    board_created_at TIMESTAMP NOT NULL DEFAULT  CURRENT_TIMESTAMP,
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
    REFERENCES user(user_id)
    ON DELETE NO ACTION
	ON UPDATE CASCADE,
    CONSTRAINT fk_video_id_bookmarks
	FOREIGN KEY (video_id) 
    REFERENCES video(video_id)
    ON DELETE NO ACTION
	ON UPDATE CASCADE
)ENGINE = InnoDB;

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
insert into trainer_detail (trainer_seq, trainer_id, trainer_name, trainer_profile_pic, trainer_experience, trainer_extra) values 
  (1,"trainer_1","성아름", "/src/assets/trainer1.png", "ㅇㅇ대학교 체육학과 졸업", "건강관리운동 전문");
insert into trainer_detail (trainer_seq, trainer_id,trainer_name,trainer_profile_pic, trainer_experience, trainer_extra) values 
  (2, "trainer_2","이민아","/src/assets/trainer2.png", "역삼 싸피피트니스 수석 트레이너", "원하는 몸, 만들어드립니다");
insert into trainer_detail (trainer_seq, trainer_id,trainer_name,trainer_profile_pic, trainer_experience, trainer_extra) values 
  (3, "trainer_3","김민성","/src/assets/trainer3.png", "생활체육관리사 자격증 유", "실생활운동을 가르쳐드립니다");
insert into trainer_detail (trainer_seq,trainer_id,trainer_name, trainer_profile_pic, trainer_experience, trainer_extra) values 
  (4, "trainer_4","박임박","/src/assets/trainer4.png", "강남 자바짐 5년 경력 트레이너", "바디 프로필 전문");
insert into trainer_detail (trainer_seq, trainer_id,trainer_name,trainer_profile_pic, trainer_experience, trainer_extra) values 
  (5, "trainer_5","조박살","/src/assets/trainer5.png", "요가/필라테스 강사 2년 경력", "요가/필라테스 전문");
  
select * from trainer_detail; 

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
insert into user (user_id, user_email, user_nickname, is_kakao) values 
  ("kakao1", "kakao1@kakao.com", "카카오연동1", 1);  

select * from user;


-- user_detail
insert into user_detail (user_id, user_profile_pic, user_gender, user_age, user_height, user_current_weight, user_target_weight, user_preferred_place, user_extra) values 
  ("admin", null, 1, 28, 180, 75, 80, "헬스장", "운동을 즐겨합니다!");
insert into user_detail (user_id, user_profile_pic, user_gender, user_age, user_height, user_current_weight, user_target_weight, user_preferred_place, user_extra) values 
  ("ssafy", "프로필_사진_링크", 2, 25, 162, 48, 40, "집", "홈트레이닝 선호");


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



-- video

INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ("근육 활성도가 가장 높은 등 운동은!? (등 운동 부위별 딱 '1가지'만 하면 어깨깡패 될 수 있습니다)", '등 운동(광배근, 승모근, 능형근)', 'https://www.youtube.com/watch?v=lgNHsARFp_c', '헬린이 탈출을 위한 운동정보');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('체지방 확실히 태워주는 논스톱 30분 유산소 운동 - 다이어트 홈트레이닝', '유산소 운동', 'https://www.youtube.com/watch?v=2W-ir1eZqkU', '빅씨스 Bigsis');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('[ENG] (층간소음 X) 진짜 역대급 20분 루틴ㅣ전신올인원 I 힙으뜸 유산소 운동', '유산소 운동', 'https://www.youtube.com/watch?v=46vQnzaZ6aU', '힙으뜸');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ("가슴근육을 키우려면 당신은 '이 운동'을 해야합니다!", '가슴 운동(대흉근)', 'https://www.youtube.com/watch?v=_is-VfJW44Y', '보통사람을 위한 운동채널');

INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('제발 상체운동좀 하세요!! ’여자 상체운동 5가지‘ | 윗가슴,중간가슴,안쪽가슴', '가슴 운동(대흉근)', 'https://www.youtube.com/watch?v=MVEHN4MIOA4', '핏블리 FITVELY');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ("푸쉬업 '제발' 이렇게만 하세요! 가슴자극 200%높이는 방법!?(팔굽혀펴기 정자세,대흉근 운동)", '가슴 운동(대흉근)', 'https://www.youtube.com/watch?v=8txh_smTqPA', '보통사람을 위한 운동채널');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('어깨뽕을 가장 빠르게 키워주는 운동 1위는?(사레레 vs 프레스)', '어깨 운동(삼각근)', 'https://www.youtube.com/watch?v=wluK0T1ajtk', '보통사람을 위한 운동채널');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('근육 결대로 조지는.. 김강민 선수의 전면/측면/후면 어깨운동 3가지 방법!!', '어깨 운동(삼각근)', 'https://www.youtube.com/watch?v=H16Z_Uv4qvc', '핏블리 FITVELY');
  

INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ("근육 활성도 연구로 밝혀낸 최고의 '삼각근' 어깨 운동법 (전면, 측면, 후면)", '어깨 운동(삼각근)', 'https://www.youtube.com/watch?v=EK3zK4OPSUY', '헬마드 (헬스 건강 정보)');

INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('11자복근 복부 최고의 운동 [복근 핵매운맛]', '복부 운동(복직근, 내복사근, 외복사근)', 'https://www.youtube.com/watch?v=PjGcOP-TQPE', 'Thankyou BUBU');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('[ENG] (층간소음X, 설명O) 🔥짧고 굵게🔥 복근만들기 2주 챌린지', '복부 운동(복직근, 내복사근, 외복사근)', 'https://www.youtube.com/watch?v=QSZ0mUGO_CA', '힙으뜸');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('(Sub)누워서하는 5분 복부운동!! 효과보장! (매일 2주만 해보세요!)', '복부 운동(복직근, 내복사근, 외복사근)', 'https://www.youtube.com/watch?v=7TLk7pscICk', '소미핏 SOMIFIT');

INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('‘넓은 어깨’와 ‘광배근’을 동시에 넓히는 방법!? [등 운동 루틴 초보]', '등 운동(광배근, 승모근, 능형근)', 'https://www.youtube.com/watch?v=F7XhxhpSInQ', '쇠질연구소');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('이게 사람 등이야?? 나바1위 선수의 광배근 넓히는 등운동 루틴 feat.정대진', '등 운동(광배근, 승모근, 능형근)', 'https://www.youtube.com/watch?v=L_6uy4uWweQ', '핏블리 FITVELY');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('"광배근 하부"를 키우는 최고의 방법 3가지!?', '등 운동(광배근, 승모근, 능형근)', 'https://www.youtube.com/watch?v=2nzM-gLf64k', '보통사람을 위한 운동채널');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('팔이 두꺼워지기 위해서는 이 근육을 꼭! 키워야 합니다.', '윗팔 운동/상완운동(상완이두근,상완삼두근)', 'https://www.youtube.com/watch?v=XmCvIBBnDGo', '세계적으로 유명한 운동 정보');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('팔근육(알통)을 가장 빠르게 키워주는 운동 1위는!? (덤벨컬vs바벨컬vs해머컬)', '윗팔 운동/상완운동(상완이두근,상완삼두근)', 'https://www.youtube.com/watch?v=EPO1iJiRNZ4', '보통사람을 위한 운동채널');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('"팔 근육" 을 가장 빠르게 키우는 팔 운동 슈퍼세트 루틴!? (이두 삼두 운동 루틴, 팔 두꺼워 지는 운동)', '윗팔 운동/상완운동(상완이두근,상완삼두근)', 'https://www.youtube.com/watch?v=upTkK5GvNvY', '쇠질사전');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('이거 두개만 하시면 커집니다. 단... | 제가 가장 효과를 본 전완근 운동', '아랫팔 운동/전완운동(전완 굴곡근, 전완 신전근)', 'https://www.youtube.com/watch?v=L-SfEPBlFCM', '강경원');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('일반인이 팔뚝(전완근)을 가장 빠르게 키우는 방법?', '아랫팔 운동/전완운동(전완 굴곡근, 전완 신전근)', 'https://www.youtube.com/watch?v=Z5tIB3EsAyw', '운동 루틴 가이드');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('전완근(악력)을 키우는 가장 효과적인 방법', '아랫팔 운동/전완운동(전완 굴곡근, 전완 신전근)', 'https://www.youtube.com/watch?v=HL84Ma8zKFw', '바쁜 현대인을 위한 운동정보');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('‘무릎을 보호’하는 가장 중요한 근육, "대퇴사두근"을 집에서 간단히 운동하는 법 - 송영민의 바른자세만들기 #66 - 대퇴사두근 운동', '허벅지 운동(대퇴부,슬굴곡근)', 'https://www.youtube.com/watch?v=lqus_wBtcgg', '굿라이프');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('하체운동 딱"3가지"만 하면 허벅지 쫙쫙 갈라집니다!!! (하체 필수 운동루틴)', '허벅지 운동(대퇴부,슬굴곡근)', 'https://www.youtube.com/watch?v=9_AiWMlH87U', '헬린이 탈출을 위한 운동정보');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('"스쿼트"를 하지 않고 하체 근육을 키우는 가장 빠른방법!? (feat.허벅지/엉덩이)', '허벅지 운동(대퇴부,슬굴곡근)', 'https://www.youtube.com/watch?v=3TyTGxBNwic', '보통사람을 위한 운동채널');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('얇은 종아리를 극복하는 최고의 운동 2가지!? (feat. 비복근, 카프레이즈)', '종아리 운동(비복근, 가자미근)', 'https://www.youtube.com/watch?v=OHp56zqYn6U', '보통사람을 위한 운동채널');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('과학적으로 밝혀진 "종아리 근육"을 키우는 가장 빠른 방법!? (feat. 종아리 근육 강화, 종아리 스트레칭)', '종아리 운동(비복근, 가자미근)', 'https://www.youtube.com/watch?v=-azhxuWVYCM', '쇠질연구소');
  
INSERT INTO video (video_title, video_part, video_url, video_channel_name)
VALUES ('종아리 근육 키우는 방법', '종아리 운동(비복근, 가자미근)', 'https://www.youtube.com/watch?v=l1x14PamFOc', '세계적으로 유명한 운동 정보');

-- review (video에 다는 리뷰)
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (1, 'admin', '좋아요', '운동하면서 기분이 좋아지는 영상입니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (2, 'ssafy', '효과만점', '이 영상 덕분에 몸이 탄탄해지고 있어요!');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (3, 'samsung', '재미있어요', '운동하면서 웃음이 나오는 영상이라 좋아합니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (4, 'baek', '감동적', '운동을 시작하게끔 동기부여가 되는 영상이에요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (5, 'kakao', '꿀팁 감사해요', '영상 속 팁들이 정말 도움이 돼서 감사합니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (6, 'admin', '다양한 운동', '다양한 운동 종목이 나와서 지루하지 않아 좋아요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (7, 'ssafy', '계속 시청 중', '매일매일 보면서 운동 습관이 생겼어요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (8, 'samsung', '추천', '이 영상을 보고 나서 체력이 개선된 느낌이에요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (9, 'baek', '무엇을 할지 고민하다가', '이 영상 덕분에 운동이 즐거워졌습니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (10, 'kakao', '짧지만 강렬함', '짧은 시간에 효과적인 운동이라 좋습니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (11, 'admin', '운동하면서 공부', '운동하면서 영상 속 정보도 같이 얻을 수 있어 좋아요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (12, 'ssafy', '다리운동 최고', '다리 운동에 특히 도움이 많이 되는 영상이에요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (13, 'samsung', '무릎 아프지 않아', '영상 속 운동은 무릎에 부담이 덜 가는 것 같아 좋아요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (14, 'baek', '최고의 선택', '운동하기 전에 이 영상을 보면 기분이 좋아져서 좋아합니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (15, 'kakao', '일상에 피로감을', '매일 하루를 시작할 때 이 영상으로 피로감을 날려버리고 있어요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (16, 'admin', '효과를 봤어요', '이 영상을 보면서 꾸준한 운동으로 몸이 조금씩 탄탄해지고 있어요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (17, 'ssafy', '운동 입문자에게', '운동을 시작하려는 분들께 이 영상을 추천합니다.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (18, 'samsung', '재밌게 하고 있어요', '운동이 즐겁게 느껴지는 영상이에요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (19, 'baek', '건강을 생각하는', '건강을 생각하며 이 영상을 보면서 운동하고 있어요.');
INSERT INTO review (video_id, user_id, review_title, review_content) VALUES (20, 'kakao', '계속해서 지켜보겠습니다', '앞으로도 이 영상 계속해서 시청할 예정입니다.');



-- bookmarks
insert into bookmarks (user_id, video_id) values ("admin", 1);
insert into bookmarks (user_id, video_id) values ("admin", 2);
insert into bookmarks (user_id, video_id) values ("ssafy", 1);
-- delete from bookmarks where (user_id, video_id) = ("admin", 1);
select * from bookmarks;
select video_id videoId from bookmarks where user_id="admin";

