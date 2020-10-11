package com.de.login.service;

import java.io.Serializable;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class GoogleUser implements Serializable{
	@JsonProperty("email")
    private String email;
    @JsonProperty("name")
    private String name;
    @JsonProperty("picture")
    private String picture;
    
    @JsonProperty("login")
    private String login;
    @JsonProperty("id")
    private String id;
    @JsonProperty("avatar_url")
    private String avatar_url;
    @JsonProperty("html_url")
    private String html_url;
    
    private int userno;
    private int role;
    private String userid;

}
