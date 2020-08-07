package com.de.security;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name="tb_users")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private String userId;
	
	private String userName;
	private String userPassword;
	private String role;
	
	@Builder
	public UserEntity(String username, String password, String role) {
		this.userName = username;
		this.userPassword = password;
		this.role = role;
	}
}
