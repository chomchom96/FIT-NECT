package com.ssafy.board.model.service;

import java.util.List;

import com.ssafy.board.model.dto.UserSchedule;
import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.UserDetail;

public interface ProductService {

	public void registDetail(UserDetail userDetail);

	public Trainer matchTrainer(List<Trainer> trainerList, UserDetail userDetail);

	public String getTrainerId(String userId);

	public void writeSchedule(UserSchedule schedule);

	public void updateSchedule(UserSchedule schedule);
	
	
}
