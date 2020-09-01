package com.de.findAccount.service;


import java.net.InetAddress;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import com.de.findAccount.Account;
import com.de.findAccount.service.MailAuthenticator;


public class PostMail {

	public static String inviteMail(Account vo) {

		// 인증키 만들기
		long time = System.currentTimeMillis();
		//UUID authkey = UUID.randomUUID();

		String host = "smtp.gmail.com";
		String subject = "[DE-COMMUNITY] 임시비밀번호를 발급해드렸습니다."; // 제목
		String from = "ivsnoti@gmail.com"; // 보내는 메일
		String fromName = "decoummunity-support"; // 보낸 사람 표기
		String toMail = vo.getUseremail();
		
		System.out.println("email check=====> " +vo.getUseremail());
		
		try {

			InetAddress local = InetAddress.getLocalHost();

			String content = "";


			content +="<div width=\"100%\" style=\"margin:0;padding:0!important;background:#f3f3f5\">\n" + 
					"	<center style=\"width:100%;background:#f3f3f5\">\n" + 
					"	\n" + 
					"		<div lang=\"en\" class=\"m_8620233955104042548email-container\" style=\"max-width:680px;margin:0 auto\">\n" + 
					"			\n" + 
					"			<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"max-width:680px;width:100%\">\n" + 
					"				<tbody>\n" + 
					"            <tr>\n" + 
					"              <td style=\"padding:20px 30px;text-align:left\">\n" + 
					"                <a href=\"http://localhost:8080\" target=\"_blank\" data-saferedirecturl=\"https://www.google.com/url?http://localhost:8080\">\n" + 
					"        			<img src=\"https://i.ibb.co/LJFGhB4/Hamoni-KR-logo600.png\" alt=\"DE-COMMUNITY\" border=\"0\" style=\"font-family:arial,sans-serif;font-size:15px;line-height:15px;\" height=\"30\" width=\"30\"> \n" + 					         
					"					<img src=\"https://i.ibb.co/vD8NWMB/DE-COMMUNITY.png\" alt=\"DE-COMMUNITY-1\" border=\"0\" width=\"180\" height=\"25\">\n"+
					"                </a>\n" + 
					"            </td>\n" + 
					"          </tr>\n" + 
					"				\n" + 
					"          <tr>\n" + 
					"            <td style=\"padding:30px;background-color:#ffffff;font-family:arial,sans-serif;font-size:15px;line-height:21px;text-align:left\" >\n" + 
					"              <p style=\"margin:0 0 24px 0\">\n" + 
					"               비밀번호 재설정\n" + 
					"              </p>\n" + 
					              
					"              <p style=\"margin:0 0 15px 0\">" + 
					              "<strong style=\"font-size:20px\">"+ vo.getUserid()+"</strong>" +"님, 안녕하세요.\n" + 
					"                임시비밀번호를 발급해드렸습니다. \n" + 
					"              </p>\n" + 
					"              <p style=\"margin:0 0 15px 0\">\n" + 
									"<strong style=\"margin:0 0px 20px 0; font-size:24px\">"+ vo.getUserpassword() + "</strong>"+ 
					"              </p>\n" + 
					"            \n" + 
					"             <p style=\"margin:0 0 15px 0\">\n" + 
					"                로그인후에 프로필에 방문해서 비밀번호를 재설정해주세요."+ 
					"            \n" + 
					"             <p style=\"margin:0 0 15px 0\">\n" + 
					"               비밀번호 재설정 요청을 하지 않으신 경우, 최근 접속 기록에서 의심스러운 로그인 기록이 있는지 확인하세요.<br>\n" + 
					"               질문이 있거나 도움이 필요한 경우 이메일로 문의해 주세요."+
					" 				\n"+ 				
					" 				\n"+ 	
					"				<p style=\"margin:0 0 15px 0\">" +
				    "				– DE-COMMUNITY 드림\n" + 										 
					"         	    </p>\n" +	
					"             </p>\n" + 
				
					"				\n" + 
					"            </td>\n" + 
					"          </tr>\n" + 
					"				\n" + 
					"          <tr>\n" + 
					"              <td style=\"font-size:12px;line-height:15px;font-family:arial,sans-serif;color:#93999f;text-align:left\">\n" + 
					"              </td>\n" + 
					"            </tr>\n" + 
					"            <tr>\n" + 
					"              <td style=\"padding:20px 0\" width=\"100%\">\n" + 
					"                <table aria-hidden=\"true\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" role=\"presentation\" style=\"width:100%\">\n" + 
					"                  <tbody>\n" + 
					"                    <tr>\n" + 
					"                      <td height=\"1\" width=\"100%\" style=\"font-size:0px;line-height:0px;border-top:1px solid #d6d8db\">&nbsp;                      \n" + 
					"                      </td>\n" + 
					"                    </tr>\n" + 
					"                  </tbody>\n" + 
					"                </table>\n" + 
					"              </td>\n" + 
					"            </tr>\n" + 
					"            <tr>\n" + 
					"              <td style=\"padding-bottom:5px;text-align:left\">\n" + 
					"                <img src=\"https://i.ibb.co/LJFGhB4/Hamoni-KR-logo600.png\" alt=\"DE-COMMUNITY\" border=\"0\" width=\"20\" height=\"20\">" + 
					"					<img src=\"https://i.ibb.co/vD8NWMB/DE-COMMUNITY.png\" alt=\"DE-COMMUNITY-1\" border=\"0\" width=\"90\" height=\"12\">\n"+
					"              </td>\n" + 
					"              </tr>\n" + 
					"            <tr>\n" + 
					"              <td style=\"padding-bottom:5px;font-size:12px;line-height:15px;font-family:arial,sans-serif;color:#93999f;text-align:left\">\n" + 
					"                <strong>Invesume&nbsp;</strong>,\n" + 
					"                <span>\n" + 
					"                  Suite 201, Saimdang-ro 8 Gil 17, Seocho-gu, Seoul\n" + 
					"                  </span>\n" + 
					"              </td>\n" + 
					"            </tr>							\n" + 
					"            </tbody>\n" + 
					"            </table>\n" + 
					"            </td>\n" + 
					"          </tr>\n" + 
					"			 </tbody>\n" + 
					"      </table>\n" + 
					"	 </div>\n" + 
					"	\n" + 
					"	</center>\n" + 
					"  </div> ";
			
			
			// Properties 값 인스턴스 생성과 기본 세션 (SMTP 서버 호스트 지정)
			Properties props = new Properties();

			// worksmobile SMTP 사용 시 적용되는 Properties
			props.put("mail.smtp.starttls.enable", "true"); // tls 사용 여부
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", host);
			props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");

			MailAuthenticator auth = new MailAuthenticator("ivsnoti@gmail.com", "exitem08");

			Session mailSession = Session.getInstance(props, auth);

			Message msg = new MimeMessage(mailSession);

			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));

			String address = toMail;
			InternetAddress[] iAdressArray = InternetAddress.parse(address);
			msg.setRecipients(Message.RecipientType.CC, iAdressArray);

			msg.setSubject(subject); // 제목 설정
			msg.setSentDate(new java.util.Date()); // 보내는 날짜 설정
			msg.setContent(content, "text/html;charset=utf-8"); // 내용 설정(HTML형식)

			Transport.send(msg); // SEND MAIL!!

			System.out.println("메일 발송을 완료하였습니다.");

		} catch (Exception e) {
			System.out.println("error : " + e.getMessage());
		}

		return "" + time;

	}

}
