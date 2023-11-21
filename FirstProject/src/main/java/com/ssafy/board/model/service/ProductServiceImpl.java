package com.ssafy.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.board.model.dao.ProductDao;
import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.UserDetail;
import com.ssafy.board.model.dto.UserSchedule;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDao productDao;

	@Override
	public void registDetail(UserDetail userDetail) {
		productDao.registDetail(userDetail);
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

	@Override
	public void matchTrainer(String trainerId, String userId) {
		productDao.matchTrainer(userId, trainerId);
	}

	@Override
	public UserSchedule getSchedule(String userId) {
		return productDao.getSchedule(userId);
	}

	@Override
	public void deleteSchedule(String userId) {
		productDao.deleteSchedule(userId);
	}

}
