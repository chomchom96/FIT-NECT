package com.ssafy.board.model.dao;

import com.ssafy.board.model.dto.UserSchedule;
import com.ssafy.board.model.dto.UserDetail;

public interface ProductDao {
	
	public void registDetail(UserDetail userDetail);
	
	public void matchTrainer(String userId, String trainerId);

	public String getTrainerId(String userId);

	public void writeSchedule(UserSchedule schedule);

	public void updateSchedule(UserSchedule schedule);
	
}
