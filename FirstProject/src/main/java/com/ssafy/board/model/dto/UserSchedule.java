package com.ssafy.board.model.dto;

public class UserSchedule {
	private String userId;
	private String jsonSchedule;
	
	public UserSchedule() {}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getJsonSchedule() {
		return jsonSchedule;
	}

	public void setJsonSchedule(String jsonSchedule) {
		this.jsonSchedule = jsonSchedule;
	}

	@Override
	public String toString() {
		return "Schedule [userId=" + userId + ", jsonSchedule=" + jsonSchedule + "]";
	};
	
	
	
}
