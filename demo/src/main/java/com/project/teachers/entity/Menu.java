package com.project.teachers.entity;

public class Menu {

	private int idx;
	private String memID;
	private String title;
	
	
	
	
	public Menu() {
		super();
	}


	public Menu(int idx, String memID, String title) {
		super();
		this.idx = idx;
		this.memID = memID;
		this.title = title;
	}


	public int getIdx() {
		return idx;
	}


	public void setIdx(int idx) {
		this.idx = idx;
	}


	public String getMemID() {
		return memID;
	}


	public void setMemID(String memID) {
		this.memID = memID;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}

	
	
}
