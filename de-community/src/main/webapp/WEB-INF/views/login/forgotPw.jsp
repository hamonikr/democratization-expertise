<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<div class="content-center">
	
	<div class="con-box" style="height:100%">
		 <div class="login bg1">
		 <form id ="frm" name="frm" method="post">      
   			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		 	<div class="join-info">
		    	<font class="blue bold">ASKOS 접속 정보가 기억이 안나시면,</font> 
		        이메일 주소로 임시 비밀 번호를 발송해 드리겠습니다.
			</div>
              <ul class="login-in">
              	<li><label>아이디</label><div class="form-group"><input type="text" id="userid" name="userid" value="" placeholder="아이디를 입력해주세요" maxlength="20" class="input-type1"></div></li>
                <li><label>이메일</label><div class="form-group"><input type="text" id="useremail" name="useremail" value="" placeholder="이메일을 입력해주세요" maxlength="20" class="input-type1"></div></li>
                <li><button type="submit" class="btn-blue">확인</button></li>
              </ul>
		</form>
		</div>
	</div>
	
</div>	
	
	

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 

 $(document).ready(function() {

	// 영문, 숫자, 공백, 특수문자
		$(".englishOnly").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
		});	
	 
	 $('#frm').validate({
		 rules: {
		 	 userid:{ required: true }
		 	 	,
		 	  useremail:{ required: true, email: true }
		    		  }, 
		  messages:{
			  userid: {
		 			required : "아이디 필수값 입니다.",
		 			},
		 								
			  useremail: {
		 			required : "이메일은 필수값 입니다.",
		 			email : "이메일 형식을 확인해주세요"
		 			}
		 	 },
		    errorElement: 'span',
		    errorPlacement: function (error, element) {
		   	  		error.addClass('invalid-feedback');
		       	element.closest('.form-group').append(error);
		 	},
		 	highlight: function (element, errorClass, validClass) {
		 	        $(element).addClass('is-invalid');
		 	},
		 	unhighlight: function (element, errorClass, validClass) {
		 	   	     $(element).removeClass('is-invalid');
		 	},
		 	submitHandler: function (frm) {
		 		sendRecoveryEmail();
		       }
		 });

 });
 
function sendRecoveryEmail(){
		document.frm.action = "/accountRecovery/sendRecoveryEmail.proc";
		document.frm.submit();

} 

</script>