package com.de.notification;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component; 

    @Component 
    public class NotificationManager { 
    	private Logger logger = LoggerFactory.getLogger(NotificationManager.class);

    	private final SlackSender slackSender;  
    
    public NotificationManager(SlackSender slackSender) { 
        this.slackSender = slackSender;
     }

    public void sendNotification(NoticeUser vo) {
        logger.info("\n#### send slack Notification. ####");
   
        // generated Message 
        String contents = generatedMessage(vo); 
        
        System.out.println("---- sendNotification contents ----\n" +contents);
        
        // send slack 
        slackSender.sendSlack(contents); 
        
    } 
     
      /** 
      * generated Message. 
      * * @return 
      */ 
    private String generatedMessage(NoticeUser vo) {
          StringBuilder sb = new StringBuilder();
          
          sb.append(vo.getUsername()).append("님이 ").append("새글을 등록했습니다")
          .append(System.getProperty("line.separator")).append("<").append(vo.getUrl()).append("|").append(vo.getTitle()).append(">"); 
         
         return sb.toString(); 
       }
     }

