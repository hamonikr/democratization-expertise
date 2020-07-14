<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Naver LoginTest</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
 
  <style type="text/css">
  html, div, body,h3{
  	margin: 0;
  	padding: 0;
  }
  h3{
  	display: inline-block;
  	padding: 0.6em;
  }
  </style>
</head>
<body>
	<div style="background-color:#15a181; width: 100%; height: 50px;text-align: center; color: white; ">
		<h3>Naver Login</h3>
	</div>
<br>
<!-- 네이버 로그인 화면으로 이동 시키는 URL -->
<!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
<div id="naver_id_login" style="text-align:center">
	<a href="/login/naverCallback"><img width="223" src="${pageContext.request.contextPath}/img/naver_login.png"/></a>
</div>
<br>
</body>


<head>
  <meta charset="utf-8">
  <title>네이버 로그인</title>
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
<!-- 	네이버 로그인 성공 
		<script type="text/javascript">
		var naver_id_login = new naver_id_login("PX4mWV3F_bqII3KVAVsl", "http://localhost:8080/login/naver");
	  // 접근 토큰 값 출력
	  alert(naver_id_login.oauthParams.access_token);
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	  function naverSignInCallback() {
	    /* alert(naver_id_login.getProfileData('id'));
	    alert(naver_id_login.getProfileData('email'));
	    alert(naver_id_login.getProfileData('name')); */
	    var userId = naver_id_login.getProfileData('id');
	    var userEmail = naver_id_login.getProfileData('email');
	    var userName = naver_id_login.getProfileData('name');
	    
	     $.ajax({
             url: '/login/naverCallback',
             type: 'post',
             data: {userId,userEmail,userName
        		     },
             success: function(data) {    	
		    
			  }
         });
         }
	</script>
 -->
 	네이버 로그인 성공 
	<script type="text/javascript">
		var naver_id_login = new naver_id_login("PX4mWV3F_bqII3KVAVsl", "http://localhost:8080/login/naverCallback");

	 // 접근 토큰 값 출력
	  alert(naver_id_login.oauthParams.access_token);
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	  function naverSignInCallback() {
	    alert(naver_id_login.getProfileData('id'));
	    alert(naver_id_login.getProfileData('email'));
	    alert(naver_id_login.getProfileData('name'));

	    /* 
	    var userId = naver_id_login.getProfileData('id');
	    var userEmail = naver_id_login.getProfileData('email');
	    var userName = naver_id_login.getProfileData('name');
	    
 	     $.ajax({
             url: '/login/naverCallback',
             type: 'post',
             data: {userId,userEmail,userName},
             success: function(data) {    	
		    	alert("확인");
			  }
         });
 */
	    	  }
	</script>
  </body>
</html> --%>