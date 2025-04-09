package com.project.teachers.dto;

public class TokenRequest {

	private String imp_key;
    private String imp_secret;
	
    public TokenRequest(String imp_key, String imp_secret) {
		super();
		this.imp_key = imp_key;
		this.imp_secret = imp_secret;
	}

	public String getImp_key() {
		return imp_key;
	}

	public void setImp_key(String imp_key) {
		this.imp_key = imp_key;
	}

	public String getImp_secret() {
		return imp_secret;
	}

	public void setImp_secret(String imp_secret) {
		this.imp_secret = imp_secret;
	}

    
	
}
