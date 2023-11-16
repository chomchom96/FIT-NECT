package com.ssafy.board.model.service;

import java.util.List;

import com.ssafy.board.model.dto.Trainer;

public interface TrainerService {

	List<Trainer> getTrainerList();

	void signup(Trainer trainer);
	
	void updateTrainer(Trainer trainer);
	
	void deleteTrainer(String trainerId); 

	Trainer login(Trainer trainer);
		
	Trainer selectTrainer(String trainerId);
	
	
}