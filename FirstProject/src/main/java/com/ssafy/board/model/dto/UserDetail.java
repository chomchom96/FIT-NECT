package com.ssafy.board.model.dto;

public class UserDetail {
	private String userId;
	private String userProfilePic;
	private boolean userGender;
	private int userAge;
	private int userHeight;
	private int userCurrentWeight;
	private int userTargetWeight;
	private String userPreferredPlace;
	private String userExtra;
	
	private UserDetail() {}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserProfilePic() {
		return userProfilePic;
	}

	public void setUserProfilePic(String profilePic) {
		this.userProfilePic = profilePic;
	}

	public boolean isUserGender() {
		return userGender;
	}

	public void setUserGender(boolean userGender) {
		this.userGender = userGender;
	}

	public int getUserAge() {
		return userAge;
	}

	public void setUserAge(int userAge) {
		this.userAge = userAge;
	}

	public int getUserHeight() {
		return userHeight;
	}

	public void setUserHeight(int userHeight) {
		this.userHeight = userHeight;
	}

	

	public int getUserCurrentWeight() {
		return userCurrentWeight;
	}

	public void setUserCurrentWeight(int userCurrentWeight) {
		this.userCurrentWeight = userCurrentWeight;
	}

	public int getUserTargetWeight() {
		return userTargetWeight;
	}

	public void setUserTargetWeight(int userTargetWeight) {
		this.userTargetWeight = userTargetWeight;
	}

	public String getUserPreferredPlace() {
		return userPreferredPlace;
	}

	public void setUserPreferredPlace(String userPreferredPlace) {
		this.userPreferredPlace = userPreferredPlace;
	}

	public String getUserExtra() {
		return userExtra;
	}

	public void setUserExtra(String userExtra) {
		this.userExtra = userExtra;
	}

}
