package com.ssafy.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.ssafy.board.model.dao.ProductDao;
import com.ssafy.board.model.dto.UserSchedule;
import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.UserDetail;

public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDao productDao;

	@Override
	public void registDetail(UserDetail userDetail) {
		productDao.registDetail(userDetail);
	}

	@Override
	public Trainer matchTrainer(List<Trainer> trainerList, UserDetail userDetail) {
		return null;
	}

	@Override
	public String getTrainerId(String userId) {
		return productDao.getTrainerId(userId);
	}

	@Override
	public void writeSchedule(UserSchedule schedule) {
		productDao.writeSchedule(schedule);
	}

	@Override
	public void updateSchedule(UserSchedule schedule) {
		productDao.updateSchedule(schedule);
	}
	
	
	
}
