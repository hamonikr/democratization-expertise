<!DOCTYPE html>
<head>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
  <title>Forgot PW</title>

  <!-- jquery-validation -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 


  <!-- CSS  -->
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://cdn.sstatic.net/Shared/stacks.css?v=f81d4e78efb6">
	<link rel="stylesheet" type="text/css" href="https://cdn.sstatic.net/Sites/stackoverflow/primary.css?v=905b10e527f0">
	<link rel="stylesheet" type="text/css" href="https://cdn.sstatic.net/Sites/stackoverflow/secondary.css?v=ba3a2252a2fd">
</head>

<body>
<div class="hold-transition login-page">
	<div class="grid grid__center snippet-hidden">
		<div class="grid--cell"> 
			<div class="wmx3 p24 bg-white bar-lg auth-shadow">
			<p>
			계정 암호를 잊어버렸거나 로그인하는 데 문제가 있으십니까?<br> 이메일 주소를 입력하면 임시비밀번호를 보내드리겠습니다.
			</p>
			<form id ="frm" class="login-card-body">
	   		   <div class="login-box-msg">
	   				<div class="grid fd-column gs4 gsy js-auth-item">
	   					<label class="grid--cell s-label" for="email">Email</label>
	   					<div class="grid ps-relative">
	   					  <input class="grid--cell input" type="text" name="userEmail" id="userEmail">
	   					</div>	
	   					<button type="submit" class="grid--cell btn btn__primary" id="submit-button" onClick="submitButton();">
		                     이메일 확인
		              </button>
	   				</div>
	   		   </div>
			</form>
			</div>
		</div>
	</div>
</div>
</body>

<script>

$(document).ready(function() {

function submitButton(){
	document.frm.action="/sendRecoveryEmail";	
	document.frm.submit();
	
}

	
$('#frm').validate({
	 rules: {
	 	  userEmail:{ required: true, email: true }
	      }, 
	  messages:{
	 	   userEmail: {
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


		}
		
	});
});
</script>
