package com.hamonize.search.service;


import java.net.InetAddress;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import com.hamonize.search.service.vo.UserInfoVO;


public class PostMail {

	public static String inviteMail(UserInfoVO vo) {

		// 인증키 만들기
		long time = System.currentTimeMillis();
		//UUID authkey = UUID.randomUUID();

		String host = "smtp.gmail.com";
		String subject = "[ivs-portal] 임시비밀번호를 발급해드렸습니다."; // 제목
		String from = "ivsnoti@gmail.com"; // 보내는 메일
		String fromName = "인베슘"; // 보낸 사람 표기
		String toMail = vo.getUser_email();
		
		System.out.println("email check=====> " +vo.getUser_email());
		
		try {

			InetAddress local = InetAddress.getLocalHost();

			String content = "";
			content += "<table><tr><th>임시 비밀번호 입니다.</th><th>로그인 후 재설정해주세요</th></tr>"+" <tr>"+vo.getUser_passwd() +" </tr>";

			
			// Properties 값 인스턴스 생성과 기본 세션 (SMTP 서버 호스트 지정)
			Properties props = new Properties();

			// worksmobile SMTP 사용 시 적용되는 Properties
			props.put("mail.smtp.starttls.enable", "true"); // tls 사용 여부
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host", host);
			props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");

			MailAuthenticator auth = new MailAuthenticator("kg1942@invesume.com", "exitem08");

			Session mailSession = Session.getInstance(props, auth);

			Message msg = new MimeMessage(mailSession);

			msg.setFrom(new InternetAddress(from, MimeUtility.encodeText(fromName, "UTF-8", "B")));
//			InternetAddress[] address = { new InternetAddress(toMail) };
//			msg.setRecipients(Message.RecipientType.TO, address); // 받는 사람설정

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
