<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- <head>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
html, div, body, h3 {
	margin: 0;
	padding: 0;
}

h3 {
	display: inline-block;
	padding: 0.6em;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		var name = ${result}.response.name;
		var email = ${result}.response.email;
		//$("#name").html("환영합니다. "+name+"님");
		$("#email").html(email);
	  });
</script>
</head>
<body>
	<div
		style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
		<h3>Naver_Login Success</h3>
	</div>
	<br>
	<h2 style="text-align: center" id="userId"></h2>
	<h4 style="text-align: center" id="userEmail"></h4>

</body> -->

<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>

<body>

<div class="row">
 <div class="col-8" align="center" style="text-align: center;margin:50px;">	        	
	가입이 완료되었습니다.
 </div>
</div>

<div class="row">
 <div class="col-8" align="center" style="margin:50px;">	        	
	<input type="button" value="확인" onClick="closeWin();">
 </div>	
</div>

 	<script type="text/javascript">
	  var naver_id_login = new naver_id_login("PX4mWV3F_bqII3KVAVsl", "http://localhost:8080/login/personalInfo");
	  // 접근 토큰 값 출력
	  var access_token = naver_id_login.oauthParams.access_token;
	  // 네이버 사용자 프로필 조회
	  naver_id_login.get_naver_userprofile("naverSignInCallback()");
	  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	 
	  function naverSignInCallback() {
	    $.ajax({
             url: '/login/personalInfo',
             type: 'post',
             dataType: 'jason',
             data: {access_token: naver_id_login.oauthParams.access_token, userId: naver_id_login.getProfileData('id'),userEmail : naver_id_login.getProfileData('email'),userName: naver_id_login.getProfileData('name')},
             success: function(retVal) {
                 if(retVal =="aaa" ){    	
                 alert("데이터 전송 확인");
                 } else{
						alert("데이터 전송 실패");
                     }
			  }
 	     });
	       	
	  }

   function closeWin(){
	   window.opener='Self';
		window.open('','_parent','');
		window.close();
	  }
  
	</script>
</body>
</html>