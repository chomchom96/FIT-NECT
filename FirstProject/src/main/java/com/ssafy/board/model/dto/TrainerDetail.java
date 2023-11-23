package com.ssafy.board.model.dto;

public class TrainerDetail {
	private int trainerSeq;
	private String trainerId;
	private String trainerName;
	private String trainerProfilePic;
	private String trainerExperience; 
	private String trainerExtra;
	
	private TrainerDetail() {}

	
	public int getTrainerSeq() {
		return trainerSeq;
	}

	public String getTrainerId() {
		return trainerId;
	}


	public void setTrainerId(String trainerId) {
		this.trainerId = trainerId;
	}


	public String getTrainerName() {
		return trainerName;
	}


	public void setTrainerName(String trainerName) {
		this.trainerName = trainerName;
	}


	public void setTrainerSeq(int trainerSeq) {
		this.trainerSeq = trainerSeq;
	}


	public String getTrainerProfilePic() {
		return trainerProfilePic;
	}

	public void setTrainerProfilePic(String trainerProfilePic) {
		this.trainerProfilePic = trainerProfilePic;
	}

	public String getTrainerExtra() {
		return trainerExtra;
	}

	public void setTrainerExtra(String trainerExtra) {
		this.trainerExtra = trainerExtra;
	}

	public String getTrainerExperience() {
		return trainerExperience;
	}

	public void setTrainerExperience(String trainerExperience) {
		this.trainerExperience = trainerExperience;
	}


	@Override
	public String toString() {
		return "TrainerDetail [trainerSeq=" + trainerSeq + ", trainerProfilePic=" + trainerProfilePic
				+ ", trainerExperience=" + trainerExperience + ", trainerExtra=" + trainerExtra
				+ "]";
	}
	
}
