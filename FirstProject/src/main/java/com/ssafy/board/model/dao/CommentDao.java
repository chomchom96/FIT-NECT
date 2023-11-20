package com.ssafy.board.model.dao;

import java.util.List;

import com.ssafy.board.model.dto.Comment;
import com.ssafy.board.model.dto.SearchCondition;

public interface CommentDao {
	
	public List<Comment> selectAll();

	// ID에 해당하는 댓글하나 가져오기
	public Comment selectOne(int commentSeq);
	
	//한 유저가 쓴 댓글 전부 가져오기
	public List<Comment> commentByUser(int userId); 

	// 게시글 등록
	public void insertComment(Comment comment);

	// 게시글 삭제
	public void deleteComment(int commentSeq);

	// 게시글 수정
	public void updateComment(Comment comment);

	// 검색 기능
	public List<Comment> search(SearchCondition condition);





}
