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

}
