package com.de.notification;

import com.google.gson.annotations.SerializedName;
import org.springframework.util.StringUtils;

public class SlackMessage { 
	
	@SerializedName("text") 
	private String text; 
	
	@SerializedName("channel") 
	private String channel; 
	
	@SerializedName("username") 
	private String botName;
	
	@SerializedName("icon_emoji") 
	private String iconEmoji;
	
	@SerializedName("icon_url") 
	private String iconUrl; 
	
	public SlackMessage(String text, String channel, String botName, String iconEmoji, String iconUrl) { 
		this.text = text; 
		this.channel = channel; 
		this.botName = botName; 
		
		if (!StringUtils.isEmpty(iconEmoji)) { 
			this.iconEmoji = iconEmoji; 
		} 
		
		if (!StringUtils.isEmpty(iconUrl)) { 
			this.iconUrl = iconUrl; 
		}
	}
	
	
	public String getText() {
		return text;
	} 
	
	public void setText(String text) {
		this.text = text; 
	}
	
	public String getChannel() { 
		return channel; 
	}
	
	public void setChannel(String channel) { 
		this.channel = channel;
	} 
	
	public String getBotName() { 
		return botName; 
	} 
	
	public void setBotName(String botName) { 
		this.botName = botName; 
	} 
	
	public String getIconEmoji() { 
		return iconEmoji; 
	} 
	
	public void setIconEmoji(String iconEmoji) {
		this.iconEmoji = iconEmoji; 
	} 
	
	public String getIconUrl() { 
		return iconUrl; 
	}
	
	public void setIconUrl(String iconUrl) {
		this.iconUrl = iconUrl; 		
	}

}
