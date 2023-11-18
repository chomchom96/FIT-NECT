package com.ssafy.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.UserDetail;
import com.ssafy.board.model.dto.UserSchedule;
import com.ssafy.board.model.service.ProductService;
import com.ssafy.board.model.service.TrainerService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/api")
@Api(tags="서비스 컨트롤러(매칭, 스케줄)")
@CrossOrigin("*")
public class ProductRestController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private TrainerService trainerService;
	
	@PostMapping("/product")
	@ApiOperation(value="사용자 정보 입력받고 매칭")
	public ResponseEntity<?> startService(@RequestBody UserDetail userDetail){
		productService.registDetail(userDetail);
		List<Trainer> trainerList = trainerService.getTrainerList();
		Trainer trainer = productService.matchTrainer(trainerList, userDetail);
		return new ResponseEntity<Trainer>(trainer, HttpStatus.OK);
	}
	
	@GetMapping("/product/{userId}")
	@ApiOperation(value="게시글 상세조회")
	public ResponseEntity<String> getTrainer(@PathVariable String userId){
		String trainerId = productService.getTrainerId(userId);
		if (trainerId != null)
			return new ResponseEntity<String>(trainerId, HttpStatus.OK);
		return new ResponseEntity<String>("Internal Error", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping("/product/schedule/{userId}")
	@ApiOperation(value="유저에 스케줄 등록")
	public ResponseEntity<?> writeSchedule(@RequestBody UserSchedule schedule, @PathVariable String userId){
		schedule.setUserId(userId);
		productService.writeSchedule(schedule);
		return new ResponseEntity<Void>(HttpStatus.CREATED);
	}
	
	@PutMapping("/product/update/{userId}")
	@ApiOperation(value="유저 스케줄 업데이트")
	public ResponseEntity<?> updateSchedule(@RequestBody UserSchedule schedule){
		productService.updateSchedule(schedule);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
}
