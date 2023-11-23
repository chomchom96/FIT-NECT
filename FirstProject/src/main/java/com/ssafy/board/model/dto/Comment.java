package com.ssafy.board.model.dto;

public class Comment {
	private int commentSeq;
	private int boardId;
	private String userId;
	private String comment; 
	private String createdAt;
	
	
	public Comment() {
	}

	
	
	public int getCommentSeq() {
		return commentSeq;
	}


	public void setCommentSeq(int commentSeq) {
		this.commentSeq = commentSeq;
	}


	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}



	@Override
	public String toString() {
		return "Comment [commentSeq=" + commentSeq + ", boardId=" + boardId + ", userId=" + userId + ", comment="
				+ comment + ", createdAt=" + createdAt + "]";
	}

	
	
	

}
