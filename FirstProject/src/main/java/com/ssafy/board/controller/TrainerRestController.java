package com.ssafy.board.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.board.model.dto.Trainer;
import com.ssafy.board.model.dto.TrainerDetail;
import com.ssafy.board.model.service.TrainerService;
import com.ssafy.board.util.JwtUtil;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/api")
@Api(tags = "트레이너 컨트롤러")
@CrossOrigin("*")
public class TrainerRestController {
	
	@Autowired
	private TrainerService trainerService;
	
	@Autowired
	private JwtUtil jwtUtil;
	
	@GetMapping("trainers")
	@ApiOperation(value="전체 트레이너 조회")
	public ResponseEntity<?> list(){
		List<Trainer> list = trainerService.getTrainerList();
		if(list == null || list.size() == 0)
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
		return new ResponseEntity<List<Trainer>>(list, HttpStatus.OK);
	}
	
	@GetMapping("trainers/detail")
	@ApiOperation(value="트레이너 세부정보 목록 조회")
	public ResponseEntity<?> detailLIst() {
		List<TrainerDetail> list = trainerService.getTrainerDetailList();
		if(list == null || list.size() == 0)
			return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
		return new ResponseEntity<List<TrainerDetail>>(list, HttpStatus.OK);
	}
	
	@PostMapping("trainers/signup")
	@ApiOperation(value="트레이너 회원가입")
	public ResponseEntity<Trainer> signup(@RequestBody Trainer trainer) {
		trainerService.signup(trainer);
		return new ResponseEntity<Trainer>(trainer, HttpStatus.CREATED);
	}
	
	@DeleteMapping("/trainers/{trainerId}")
	@ApiOperation(value="트레이너 삭제")
	public ResponseEntity<Void> delete(@PathVariable String trainerId) {
		trainerService.deleteTrainer(trainerId);
		
		return new ResponseEntity<Void>(HttpStatus.OK); 
	}
	
	
	@PutMapping("/trainers")
	@ApiOperation(value="트레이너 기본정보 수정")
	public ResponseEntity<Void> update(@RequestBody Trainer trainer){
		trainerService.updateTrainer(trainer);
		
		return new ResponseEntity<Void>(HttpStatus.OK); 
	}
	
	
	@GetMapping("trainers/{trainerId}")
	@ApiOperation(value="trainerId에 해당하는 trainer 조회")
	public ResponseEntity<?> getTrainer(@PathVariable String trainerId){

		System.out.println(trainerId);
		Trainer trainer = trainerService.selectTrainer(trainerId);
		if (trainer != null) return new ResponseEntity<Trainer>(trainer, HttpStatus.OK);
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}
	
	
	@PostMapping("trainers/login")
	@ApiOperation(value="트레이너 로그인")
	public ResponseEntity<Map<String, Object>> login(@RequestBody Trainer trainer) {
		Map<String, Object> result = new HashMap<String, Object>();
		HttpStatus status = null;
		
		Trainer tmp = trainerService.login(trainer);
		
		try {
			if (tmp != null) {
				result.put("access-token", jwtUtil.createToken("id", tmp.getTrainerId()));
				result.put("message", "LOGIN SUCCESS");
				status = HttpStatus.ACCEPTED;
			}else {
				result.put("message", "BAD REQUEST");
				status = HttpStatus.NO_CONTENT;
			}
		} catch (UnsupportedEncodingException e) {
			result.put("message", "INTERNAL SERVER ERROR");
			status = HttpStatus.INTERNAL_SERVER_ERROR;
		}
		
		return new ResponseEntity<Map<String,Object>>(result, status);
	}
	
	@GetMapping("trainers/logout")
	@ApiOperation(value="트레이너 로그아웃")
	public ResponseEntity<Void> logout(HttpSession session) {
		session.invalidate();
		return new ResponseEntity<Void>(HttpStatus.OK);
	}
	
	@GetMapping("trainers/userlist/{trainerId}")
	@ApiOperation(value="트레이너 할당된 사용자 확인")
	public ResponseEntity<?> trainerUserCheck(@PathVariable String trainerId){
		List<String> list = trainerService.getUserList(trainerId);
		if (list != null) 
			return new ResponseEntity<List<String>>(list, HttpStatus.OK);
		return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
	}
	
}