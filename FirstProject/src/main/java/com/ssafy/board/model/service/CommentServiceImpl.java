package com.ssafy.board.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.board.model.dao.CommentDao;
import com.ssafy.board.model.dto.Comment;
import com.ssafy.board.model.dto.SearchCondition;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;
	
	@Override
	public List<Comment> getList() {
		return commentDao.selectAll();
	}

	@Override
	public void writeComment(Comment comment) {
		commentDao.insertComment(comment);
	}

	@Override
    public Comment getComment(int commentSeq) {
        return commentDao.selectOne(commentSeq);
    }

	@Override
	public void modifyComment(Comment comment) {
		commentDao.updateComment(comment);
	}

	@Override
	public void removeComment(int commentSeq) {
		commentDao.deleteComment(commentSeq); 
	}

	

	@Override
	public List<Comment> search(SearchCondition condition) {
		return commentDao.search(condition);
	}


	@Override
	public List<Comment> getCommentbyUser(String userId) {
		return commentDao.commentByUser(userId);
	}

	@Override
	public List<Comment> getCommentbyBoard(int boardId) {
		return commentDao.commentByBoard(boardId);
	}



}
