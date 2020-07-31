package com.de.security;

import java.io.Serializable;

import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class SessionUser implements Serializable {
	    private String name;
	    private String password;

	    public SessionUser(User user) {
	        this.name = user.getUsername();
	        this.password = user.getPassword();
	    }
	}

