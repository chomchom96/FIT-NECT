package com.ssafy.board.model.dao;

import java.util.List;

import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.TrainerDetail;
import com.ssafy.board.model.dto.User;
import com.ssafy.board.model.dto.UserSchedule;

public interface TrainerDao {
	
	//트레이너 목록 전체 보기
	List<Trainer> selectAll();
	
	//트레이너 등록
	void insertTrainer(Trainer trainer);
	
	//트레이너 기본정보 수정
	void updateTrainer(Trainer trainer);
	
	//트레이너 삭제 
	void deleteTrainer(String trainerId); 

	//트레이너 id로 가져오기
	Trainer selectTrainer(String trainerId);

	// 트레이너 세부 정보 목록 조회
	List<TrainerDetail> getTrainerDetailList();

	// 트레이너가 본인에게 할당된 사용자 목록 조회
	List<String> getUserList(String trainerId);
	
}