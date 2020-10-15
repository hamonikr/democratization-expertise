<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Invesume STS | 로그인</title>

<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Custom Login Form Styling with CSS3" />
<meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
<meta name="author" content="Codrops" />

<link rel="stylesheet" type="text/css" href="/dist/css/login_style.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/index.css" />

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

</head>

<style>
@media (min-width: 992px) {
	.col-lg-2 {
		-ms-flex: 0 0 16.666667%;
		flex: 0 0 16.666667%;
		max-width: 16.666667%;
	}
	.col-lg-3 {
		-ms-flex: 0 0 25%;
		flex: 0 0 25%;
		max-width: 25%;
	}
	.col-lg-4 {
		-ms-flex: 0 0 33.333333%;
		flex: 0 0 33.333333%;
		max-width: 33.333333%;
	}
}

a { color: #6610f2 }
body { 
	background: #F0F5FB;
	overflow: auto; 
}

.form { 
	background-color: #FFF;
	border-radius: .25em;
	box-shadow: 0 0 10px rgba(0,0,0,.25);
	margin: auto;
	margin-top: 10%;
	max-width: 350px;
	padding: 30px; 
	text-align: center;
}
.frm2, .frm3 { text-align: left }
.login_content { padding: 25px 0 0 }
.login_content form { position: relative }

.login_content h1.title {
	font: normal 25px nanumgothic;
	letter-spacing: -0.05em;
	line-height: 20px;
	margin: 10px 0 35px;
	position: relative;
}
h1.title:before,
h1.title:after {
	content: "";
	position: absolute;
	top: 10px;
	height: 1px;
	width: 20%;
} 
h1.title:before {
	background: linear-gradient(to left, #7e7e7e 0%, #fff 100%);
	left: 0;
}
h1.title:after {
	background: linear-gradient(to right, #7e7e7e 0%, #fff 100%);
	right: 0;
}

.login_content form.frm input { margin: 0 0 15px }
.login_content form  input { margin: 0 }

.form-control:focus {
	border-color: #6610f2;
	-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 16, 242,.25);
	box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(102, 16, 242,.25);
}

.separator {
	border-top: 1px solid #D8D8D8;
	margin-top: 10px;
	padding-top: 10px;
}
.separator p { font-size: 12px }
.separator .login_link { text-align: left }
.separator .login_link a:last-child { float: right }

.login_content .btn_div .btn {
	margin: 10px 0; 
	width: 100%; 
}



.codrops-top.col-lg-12 { background: linear-gradient(to right, #8056D6, #373C4F) }
.codrops-top.col-lg-12 a:hover { background: none }
.codrops-top.col-lg-12 strong { color: #95959F }

body > .row,
.container.row { margin: 0 }

.container.row { width:  100% }

.form-1 { margin-bottom: 15px }
.container > header { margin: 130px 0 }
.form-1 > p:hover > i { color: #6610f2 }


.btn_div { 
	border: 0;
	padding: 0;
	text-align: center; 
}

.btn_div button {
	background-color: rgba(0,0,0,0);
	background-image: none;
	border-radius: 25px;
	box-shadow: none;
	font-size: .75em;
	margin: 0;
	padding: 5px 25px;
	width: auto;
}
.btn_div button.purple { 
	border: 2px solid #6610f2; 
	color: #6610f2;
}
.btn_div button.purple:hover {
	background-color: #6610f2;
	border: 2px solid #6610f2;
	color: #fff;
}
.btn_div button.purple:focus {
	background-color: #6610f2 !important;
	border: 2px solid #6610f2;
	color: #fff;
}

.btn_div button.gray { 
	border: 2px solid #343a40; 
	color: #343a40;
}
.btn_div button.gray:hover {
	background-color: #343a40;
	border: 2px solid #343a40;
	color: #fff;
}
.btn_div button.gray:focus {
	background-color: #343a40 !important;
	border: 2px solid #343a40;
	color: #fff;
}


/* find window */
.modal-dialog { margin: 8em auto }
.tab-toolbar { 
	margin-top: 34px;
	padding: 0 1em; 
}

.modal-content { background: #F0F5FB }
.modal-content > .col-12 {
	margin-top: 15px;
	padding: 0 22px;
}

.callout.callout-info.row {
	border-radius: .25rem;
	box-shadow: 0 1px 3px rgba(0,0,0,.12), 0 1px 2px rgba(0,0,0,.24);
	background-color: #fff;
	border-left: 5px solid #e9ecef;
	margin-bottom: 1rem;
	padding: 1rem;
	border-left-color: #117a8b;
	margin-right: -7.5px;
	margin-left: -7.5px;
	display: flex;
}
.callout.callout-info.row > .col-6 {
	padding-left: 7.5px;
	padding-right: 7.5px;
	position: relative;
	flex: 0 0 50%;
	max-width: 50%;
	width: 100%;
}
.callout.callout-info.row > .col-6 h5 {
	font-size: 20px;
	line-height: 24px;
	padding-top: 5px;
}
.callout.callout-info.row > .col-6 .float-right { float: right }

ul.tabs{
	border-top: 1px solid #D8D8D8;
	list-style: none;
	margin: 0px;
	margin-top: 10px;
	padding: 0px;
	padding-top: 10px;
}
ul.tabs li { 
	color: #6610f2;
	cursor: pointer;
	display: inline-block; 
	font-size: 12px;
}
ul.tabs li:hover { color: #2a6496 }
ul.tabs li.current { display: none }

.tab-content { display: none }
.tab-content.current{ display: inherit }

#resultId{ display: none }

.result_pw{
display: none;
font-family: Georgia;
font-size: 15px;
text-indent:10px;
word-wrap: break-word;
}

.info_text {
	font-size: 13px;
	margin: 40px 0 20px 0;
	text-align: center;
}
.result_pw .info_text { margin: 10px 0 20px 0 }
</style>

<body>
<div class="bg_div"></div>

<div class="row">

<!-- 로그인 -->
<div class="animate form">
	<section class="login_content">
		<form class="frm" name="frm" action="/sign/login" method="post" autocomplete="off">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<h1 class="title"><b>INVESUME</b> STS</h1>
			
			<div>
				<input type="text" id="user_id" class="form-control" name="username" placeholder="아이디">
				<!-- <i class="icon-user icon-large"></i> -->
			</div>
			<div>
				<input type="password" id="user_passwd" class="form-control" name="password" placeholder="비밀번호">
				<!-- <i class="icon-lock icon-large"></i> -->
			</div>
			<div class="btn_div">
				<button type="submit" class="btn btn-default purple" name="submit">로그인</button>
			</div>
			
			<div class="separator">
				<p class="login_link">
					<a href="/signup/addForm.ivs">회원가입</a>
					<a href="#" id="findId">내 계정 찾기</a>
				</p>
				<div class="clearfix"></div>
				<br>
				<div>
					<p>Copyright © 2020 Invesume. All rights reserved.</p>
				</div>
			</div>
		</form>
	</section>
</div>


<!-- 계정 찾기 -->
<div class="modal fade">
	<div class="animate form">
		<section class="login_content">

			<!-- 아이디 찾기 -->
			<div id="tab-1" class="tab-content current">
				<h1 class="title"><b>아이디 찾기</b></h1>
				
				<div id="content_searchId">
					<form class="frm2" name="frm2" id="frm2" action="" method="post" autocomplete="off">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						<div class="form-group">
							<label for="inputEmail3" class="col-form-label ">이름</label>
							<input type="text" class="form-control" placeholder="이름" id="user_nm" name="user_nm" maxlength="20">
						</div>
					
						<div class="form-group">
							<label for="inputEmail3" class="col-form-label">사업자 번호</label>
							<div class="tel_div row">
								<input type="text" class="form-control filter col-lg-4 inputs numberOnly" id ="bizno1" name="bizno1" maxlength ="3">
								<span class="col-lg-1 disable_sm"> - </span> 
								<input type="text" class="form-control filter col-lg-2 inputs numberOnly" id ="bizno2" name="bizno2" maxlength ="2" >
								<span class="col-lg-1 disable_sm"> - </span> 
								<input type="text" class="form-control filter col-lg-4 inputs numberOnly" id ="bizno3" name="bizno3" maxlength ="5">
							</div>
						</div>
						
						<div class="form-group">
							<label for="inputEmail3" class="col-form-label">메일</label>
							<input type="text" class="form-control form-control-sm" id ="user_email" name="user_email" placeholder ="메일"  maxlength="30" >
						</div>
						
						<p class="info_text">이름, 사업자 번호, 메일로 계정을 찾습니다.</p>
						
						<div id="modal-button" class="modal-footer btn_div">
				       		<button type="submit" class="btn btn-info purple" style="width: 49%">확인 </button>  		
				       		<button type="button" class="btn gray" style="width: 49%" data-dismiss="modal">취소</button>			        
			      	   </div>
						
					</form>
				</div>
				
				<!-- 아이디 검색 결과  -->
				<div id="resultId">
					<h1 id="result_id"> ${result} </h1>				

     		  	 	<p class="info_text">고객님의 정보와 일치하는 아이디 입니다</p>

					<div align ="right" class="modal-footer modal-footer-result btn_div">
				  		<button id="close_modal" type="button" class="btn btn-info purple" data-dismiss="modal">확인</button>			        
					</div>
				</div>
			</div>
			
			
			<!-- 비밀번호 변경하기 -->
			<div id="tab-2" class="tab-content">
				<h1 class="title"><b>비밀번호 찾기</b></h1>
				
				<!-- 비밀번호 변경 입력 -->
				<div id="content_searchPw">
					<form class="frm3" name="frm3" id="frm3" action="" method="post" autocomplete="off">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						
						<div class="form-group">
							<label for="inputEmail3" class="col-form-label">아이디</label>
							<input type="text" class="form-control form-control-sm" id ="user_id_p" name="user_id_p" placeholder ="아이디" maxlength="20">
						</div>
						
						<div class="form-group">
							<label for="inputEmail3" class="col-form-label">이름</label>
							<input type="text" class="form-control form-control-sm" id ="user_nm_p" name="user_nm_p" placeholder ="이름" maxlength="20">
						</div>
						
						<div class="form-group">
							<label for="inputEmail3" class="col-form-label">이메일</label>
							<input type="email" class="form-control form-control-sm" id ="user_email_p" name="user_email_p" placeholder ="이메일" maxlength="30">
						</div>
						
						<p class="info_text">등록된 메일로 임시 비밀번호를 보내 드립니다.</p>
						
						<div class="modal-footer btn_div">
					        <button type="submit" class="btn btn-info purple" style="width: 49%">확인 </button>
					        <button type="button" class="btn gray" style="width: 49%" data-dismiss="modal">취소</button>
					    </div>
						
					</form>
				</div>
				
				<!-- 비밀번호 찾기 결과 -->
				<div id="resultPw" class ="result_pw">
					<p class="info_text"> 등록된 메일로 임시 비밀번호를 전송 하였습니다. 로그인 후 재설정 하시기 바랍니다.</p>
					<div class="modal-footer modal-footer-result btn_div">
				  		<button id="close_modal_pw" type="button" class="btn btn-info purple" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
			
			
			<!-- 하단 메뉴 링크 -->
			<ul class="tabs">
				<li class="tab-link current" data-tab="tab-1">아이디 찾기</li>
				<li class="tab-link" data-tab="tab-2">비밀번호 찾기</li>
			</ul>
			
		</section>
	</div>
</div>

</div>
</body>

<script>
function reset_ipts(){
	// 계정찾기 입력창 초기화 - ID
    var tab_1ipts = $('#tab-1 input');
    for(i=0;i<tab_1ipts.length;++i){
        if( tab_1ipts.eq(i).attr('name') != '_csrf'){
        	tab_1ipts.eq(i).val('');
        }
    }

 // 계정찾기 입력창 초기화 - PW
    var tab_2ipts = $('#tab-2 input');
    for(i=0;i<tab_2ipts.length;++i){
        if( tab_2ipts.eq(i).attr('name') != '_csrf'){
        	tab_2ipts.eq(i).val('');
        }
    }
}

var tmp =0;
$(function(){
    $("#findId").click(function(){
        $('div.modal').modal({
		});
//	        reset_ipts();
	})
})


$(document).ready(function(){
	
	$('ul.tabs li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
	})

})


$('#frm2').validate({
	 rules: {
	 		 bizno1:{
			required:true
 	 	    },
 	 	  bizno2:{
				required:true
	 	    },   
	 		 bizno3:{
				required:true
 	 		    },

		   // 유저 이메일 
	    user_email:{
			email:true,
			required:true
	 		    },
		user_nm:{
			required:true
	 		    }

	 	    }, messages: {
	 	    	 bizno1:{
					required:""
		 	 	    },
		 	 	  bizno2:{
						required:""
			 	    },  
	 	 		 bizno3:{
				required:"사업자 번호를 확인해주세요"
	 		    },
	 	 	    // 유저 이메일
				user_email: {
					email : "이메일 형식을 확인해주세요", 
					required:"이메일을 입력해주세요"
					},
					user_nm: {
					required : "이름을 입력해주세요"
		 		   }
	 	    
		  }, errorElement: 'span',
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
	 	     submitHandler: function(){

				var user_nm = $("#user_nm").val();
				var bizno =  $("#bizno1").val()+ $("#bizno2").val()+ $("#bizno3").val();
			 	var user_email = $("#user_email").val();
	
	     		if(user_nm == "" | user_email == "" | bizno == ""){
	     			alert("정보를 모두 입력해주세요");     		
				} else {
		        		 $.ajax({
	          				 data : {user_nm, bizno, user_email},
	                   	 url : "/search/searchId.proc",
	                   	 success : function(result) {
	                       	 if(result!=null){
	                           	 	if(result !="biz_problem" && result !="searched_fail"){
	                        				$("#content_searchId").css("display","none");
	                        	 			$("#modal-button").css("display","none");                       	
	                        				$("#resultId").css("display","block");
	                        				$("#result_id").html(result);
	                           			console.log("아이디 정상조회");
	
	                           		 }else if(result=="biz_problem"){
	                                   	 alert("입력하신 사업자번호 정보가 올바르지 않습니다. 확인후 다시 시도해 주시기 바랍니다.");
	                                   	 		
	                               	 }else if(result=="searched_fail")
	                                   	 alert("입력하신 이름/이메일 정보가 올바르지 않습니다. 확인후 다시 시도해 주시기 바랍니다.");
	                            	 
	                       	 }else{
									alert("입력한 정보가 올바르지 않습니다. 확인후 다시 시도해 주시기 바랍니다.");
	                           	 }
	                       	 }
						});
				}
		}
});
	
$("#close_modal").click(function(){
	location.reload();
})

	
$('#frm3').validate({
	 rules: {
	 	  // 유저 이메일 
	    user_email_p:{
			email:true,
			required:true
	 		    },
		user_id_p:{
			required:true
	 		    },
		user_nm_p:{
			required:true
	 		    }
		    }, messages: {
	 	    	// 유저 이메일
				user_email_p: {
					email : "이메일 형식을 확인해주세요", 
					required:"이메일을 입력해주세요"
					},
				user_id_p: {
				required : "아이디를 입력해주세요"
	 		   },
	 		  user_nm_p: {
					required : "이름을 입력해주세요"
		 		   },
	 	    
		  }, errorElement: 'span',
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
	 	     submitHandler: function(){
			
				var user_id = $("#user_id_p").val();
				var user_nm = $("#user_nm_p").val();
				var user_email = $("#user_email_p").val();
				 
		    	if(user_nm == "" | user_email == "" | user_id ==""){
		    			alert("정보를 모두 입력해주세요");     		
					} else {
						if(confirm("비밀번호를 변경하시겠습니까?")==true){
			        		 $.ajax({
		         				 data : {user_id, user_nm, user_email},
		                  	 url : "/search/searchPw.proc",
		                  	 success : function(up_result) {  
									if(up_result ==1){
		                      	 $("#content_searchPw").css("display","none");
		               	    	 $("#modal-pw-button").css("display","none");                       	
		                 	  		 $("#resultPw").css("display","block");
		                  	 	 console.log("비밀번호 정상조회" + up_result);
									} else{
										alert("회원정보를 잘못 입력하셨습니다. 확인부탁드립니다.");
										console.log("비밀번호 조회 실패"+up_result);
												}
		                     	 }
		                       	});
							}     
						}
				}
});

$("#close_modal_pw").click(function(){
	location.reload();    	          		   	     	          						
})
	
// 인풋박스 커서 자동이동  
$(function() {
    $(".inputs").keyup (function () {
        var charLimit = $(this).attr("maxlength");
        if (this.value.length >= charLimit) {
            $(this).next().next('.inputs').focus();
            return false;
        }
    });


	//사업자 번호 숫자만 입력받도록 
	$(".numberOnly").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});


	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일 정규식
		 
	$("#alert-success").hide(); 
 	$("#alert-danger").hide(); 
 	 	
 	$("#user_email").keyup(function(){
		 if((!emailRule.test($("input[id='EMAIL']").val()))){ 
	 		 $("#alert-success").show();
	 		 $("#alert-danger").hide(); 
	 		 //$("#submit").removeAttr("disabled"); 
	 	 }else{
	 	 	  $("#alert-success").hide(); 
	 	 	  $("#alert-danger").show(); 
	 	 	//  $("#subenglishOnlymit").attr("disabled", "disabled"); 
	 	 	  }
	});

 	$("#user_email_p").keyup(function(){
	 	 	 
 	 		 if((!emailRule.test($("input[id='EMAIL']").val()))){ 
 	 	 		 $("#alert-success").show();
 	 	 		 $("#alert-danger").hide(); 
 	 	 		 //$("#submit").removeAttr("disabled"); 
 	 	 	 }else{
 	 	 	 	  $("#alert-success").hide(); 
 	 	 	 	  $("#alert-danger").show(); 
 	 	 	 	//  $("#subenglishOnlymit").attr("disabled", "disabled"); 
 	 	 	 	  }
	});
});
</script>
</html>