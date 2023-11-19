package com.ssafy.board.model.service;

import java.util.List;

import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.TrainerDetail;
import com.ssafy.board.model.dto.User;
import com.ssafy.board.model.dto.UserSchedule;

public interface TrainerService {

	List<Trainer> getTrainerList();

	void signup(Trainer trainer);
	
	void updateTrainer(Trainer trainer);
	
	void deleteTrainer(String trainerId); 

	Trainer login(Trainer trainer);
		
	Trainer selectTrainer(String trainerId);

	List<TrainerDetail> getTrainerDetailList();

	List<String> getUserList(String trainerId);

	
	
}