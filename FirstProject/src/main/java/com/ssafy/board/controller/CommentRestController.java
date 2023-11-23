package com.ssafy.board.controller;

import java.util.List;

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

import com.ssafy.board.model.dto.Board;
import com.ssafy.board.model.dto.Comment;
import com.ssafy.board.model.dto.SearchCondition;
import com.ssafy.board.model.service.CommentService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

@RestController
@RequestMapping("/api")
@Api(tags="게시판 댓글 컨트롤러")
@CrossOrigin("*")
public class CommentRestController {

	@Autowired
	private CommentService commentService;

//		@GetMapping("/board")
//		@ApiOperation(value="전체 게시글 조회")
//		public ResponseEntity<?> list(){
//			List<Board> list = boardService.getList(); //전체 조회
//			if(list == null || list.size() == 0)
//				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
//			return new ResponseEntity<List<Board>>(list, HttpStatus.OK);
//		}

		@GetMapping("/comment")
		@ApiOperation(value="검색조건 댓글 조회")
		public ResponseEntity<?> list(SearchCondition condition){
			List<Comment> list = commentService.search(condition); 
			if(list == null || list.size() == 0)
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			return new ResponseEntity<List<Comment>>(list, HttpStatus.OK);
		}

		@GetMapping("/comment/detail/{commentSeq}")
		@ApiOperation(value="댓글 상세조회")
		public ResponseEntity<Comment> detail(@PathVariable int commentSeq){
			Comment comment = commentService.getComment(commentSeq);
			return new ResponseEntity<Comment>(comment, HttpStatus.OK);
		}
		
		@GetMapping("/comment/user/{userId}")
		@ApiOperation(value="한 유저의 댓글 전부 조회")
		public ResponseEntity<?> userComment(@PathVariable String userId){
			List<Comment> list = commentService.getCommentbyUser(userId);
			if(list == null || list.size() == 0)
				return new ResponseEntity<Void>(HttpStatus.NO_CONTENT);
			return new ResponseEntity<List<Comment>>(list, HttpStatus.OK);
		}
		
		@GetMapping("/comment/board/{boardId}")
		@ApiOperation(value="한 게시글의 댓글 전부 조회")
		public ResponseEntity<?> boardComment(@PathVariable int boardId){
			List<Comment> list = commentService.getCommentbyBoard(boardId);
			return new ResponseEntity<List<Comment>>(list, HttpStatus.OK);
		}

		@PostMapping("/comment")
		@ApiOperation(value="댓글 작성")
		public ResponseEntity<Comment> write(@RequestBody Comment comment){
			commentService.writeComment(comment);
	
			return new ResponseEntity<Comment>(comment, HttpStatus.CREATED);
		}

		@DeleteMapping("/comment/{commentSeq}")
		@ApiOperation(value="댓글 삭제")
		public ResponseEntity<Void> delete(@PathVariable int commentSeq){
			commentService.removeComment(commentSeq);
			
			return new ResponseEntity<Void>(HttpStatus.OK);
		}

	
		@PutMapping("/comment")
		@ApiOperation(value="댓글 수정인데 구현할까말까")
		public ResponseEntity<Void> update(@RequestBody Comment comment){
			commentService.modifyComment(comment);
			
			return new ResponseEntity<Void>(HttpStatus.OK);
		}
		
	
}
