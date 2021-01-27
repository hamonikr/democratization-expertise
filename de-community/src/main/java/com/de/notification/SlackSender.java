package com.de.notification;

import java.nio.charset.Charset;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.google.gson.Gson;



@Service
public class SlackSender {

	private Logger logger = LoggerFactory.getLogger(SlackSender.class); 
	
	@Value("${notification.slack.enabled}") 
	private boolean slackEnabled; 
	
	@Value("${notification.slack.webhook.url}") 
	private String webhookUrl; 
	
	@Value("${notification.slack.channel}") 
	private String channel; 
	
	@Value("${notification.slack.botName}") 
	private String botName; 
	
	@Value("${notification.slack.icon.emoji}") 
	private String iconEmoji; 
	
	@Value("${notification.slack.icon.url}") 
	private String iconUrl; 
	
	public void sendSlack(String contents) { 
		
		System.out.println("========aaSlackSender working=======");
		System.out.println("contents : \n"+ contents);

			if (slackEnabled) { 
				try {
					System.out.println("=======bbbSlackSender working=======");
//					String payload = "{\"channel\": \"#askos_alarm\", \"username\": \"webhookbot\", \"text\": \"This is posted to #askos_alarm and comes from a bot named webhookbot.\", \"icon_emoji\": \":ghost:\"}";
					String url = "https://hooks.slack.com/services/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";
//					
					// create slack Message
					SlackMessage slackMessage = new SlackMessage(contents, channel, botName, iconEmoji, iconUrl); 
					String payload = new Gson().toJson(slackMessage); 
					
					System.out.println("payload >> \n"+payload);
					
					RestTemplate restTemplate = new RestTemplate(); 
					HttpHeaders headers = new HttpHeaders();
					headers.set("Content-Type", MediaType.APPLICATION_JSON_VALUE); 
					
					// send the post request 
					HttpEntity<String> entity = new HttpEntity<>(payload, headers); 
					
					restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));

					System.out.println("======= restTemplate =======\n"+restTemplate.toString());	

					
					restTemplate.postForEntity(url, entity, String.class); 

				} catch (Exception e) { 
						logger.error("Unhandled Exception occurred while send slack. [Reason] : ", e); 
					} 
				} 
			}
		}
	
