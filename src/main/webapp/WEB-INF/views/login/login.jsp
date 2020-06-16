<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Invesume STS | Login</title>

<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Custom Login Form Styling</title>
<meta name="description" content="Custom Login Form Styling with CSS3" />
<meta name="keywords" content="css3, login, form, custom, input, submit, button, html5, placeholder" />
<meta name="author" content="Codrops" />

<link rel="stylesheet" type="text/css" href="/dist/css/login_style.css" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/index.css" />
</head>

<style>
@media (min-width: 992px) {
	.col-lg-3 {
		flex: 0 0 25%;
		max-width: 25%;
	}
}

* { color: #666 }
body { overflow: auto }

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
	padding-bottom: 0;
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
.tab-content { border-top: 3px solid #117a8b }


ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: #FFF;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #117a8b;
	border-radius: .25rem .25rem 0 0;
	color: #FFF;
	font-weight: bold;
}

.tab-content{
	display: none;
	background: #FFF;
	padding: 15px;
}

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
	margin-top: 20px;
	text-align: center;
}
.result_pw .info_text { margin: 10px 0 20px 0 }
</style>

<body>
<div class="row">
		<!-- Codrops top bar -->
		<div class="codrops-top col-lg-12">
			<span class="right">
				<a href="javascript:;" style="cursor: text">
					<strong>Admin invesume Service Technology Support</strong>
				</a>
			</span>
		</div>

	<div class="container col-lg-12 row">
		<!--/ Codrops top bar -->

		<header>
			<h1>
				<strong>Invesume</strong> STS Login
			</h1>
		</header>

		<section class="main col-lg-12">
			<form class="" name="frm" action="/sign/login" method="post">
			
				<div class="form-1">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<p class="field">
						<input type="text" id="user_id" name="username" value="lee" placeholder="UserId"> <i class="icon-user icon-large"></i>
					</p>
					<p class="field">
						<input type="password" id="user_passwd" name="password" value="1234" placeholder="Password"> <i class="icon-lock icon-large"></i>
					</p>			
				</div>

				<div class="modal-footer btn_div">
					<button type="button" class="btn btn-default purple" id="findId">내 계정 찾기</button>
					<button type="button" class="btn btn-default purple" onclick="location.href='/signup/addForm.ivs'">회원가입</button>
					<button type="submit" class="btn btn-default purple" name="submit">로그인</button>
				</div>
			</form>
		</section>


		<!-- 아이디 / 비밀번호 변경 -->
		<!-- 아이디 찾기 모달창1 - 입력부분 -->
		<div class="modal fade">
		  <div class="modal-dialog">
		    <div class="modal-content">
			   <!-- <h4 class="tab-toolbar" id="findUserInfo">계정찾기</h4> -->
			   
			   <div id="input_div" class="col-12">
					<div class="callout callout-info row ">
						<div class="col-6">
							<h5>계정찾기</h5>
						</div>
						<div class="col-6">
							<!-- <span class="float-right  "><a href="/main/index">Home</a> / 계정찾기</span> -->
						</div>
					</div>
				</div>
			   
		        <div class="modal-body">
				 	<ul class="tabs">
						<li class="tab-link current" data-tab="tab-1">아이디 찾기</li>
						<li class="tab-link" data-tab="tab-2">비밀번호 변경</li>
					</ul>
					<div id="tab-1" class="tab-content current">
						<div id="content_searchId" class="row">

							<div class="col-lg-12">
								<div class="form-group row">
									<label for="inputEmail3" class="col-lg-3 ">이름</label>
									<div class="col-lg-9">
										<input type="text" class="form-control" placeholder="이름" id="user_nm" name="user_nm" value="이영은">
									</div>
								</div>
							</div>
							
							<div class="col-lg-12">
								<div class="form-group row">
									<label for="inputEmail3" class="col-lg-3 ">사업자 번호</label>
									<div class="col-lg-9 tel_div">
										<input type="text" class="form-control filter col-lg-3 inputs" id ="bizno1" name="bizno1" maxlength ="3" value="111">
										<span class="col-lg-1"> - </span> 
										<input type="text" class="form-control filter col-lg-3 inputs" id ="bizno2" name="bizno2" maxlength ="2" value="11">
										<span class="col-lg-1"> - </span> 
										<input type="text" class="form-control filter col-lg-3 inputs" id ="bizno3" name="bizno3" maxlength ="5" value="11123">
									</div>

								</div>
							</div>
							
							<div class="col-lg-12">
								<div class="form-group row">
									<label for="inputEmail3" class="col-lg-3 ">메일</label>
									<div class="col-lg-9">
										<input type="email" class="form-control form-control-sm" id ="user_email" name="user_email" placeholder ="메일" value="bono6315@gmail.com">
									</div>
								</div>
							</div>
						</div>


						<!-- 아이디 검색 결과 부분  -->
		     		  	 <div id="resultId" class="row">

		     		  	 	<div class="col-lg-12">
								<div class="form-group row">
									<label for="inputEmail3" class="col-lg-3 ">아이디</label>
									<div class="col-lg-9">
										<div id="result_id" class="form-control"> ${result} </div>
									</div>
								</div>
							</div>

		     		  	 	<p class="info_text">고객님의 정보와 일치하는 아이디 입니다</p>

							<div align ="right" class="modal-footer modal-footer-result btn_div">
						  		<button id="close_modal" type="button" class="btn btn-info purple" data-dismiss="modal">확인</button>			        
							</div>
						</div>	
					<div id="modal-button" class="modal-footer btn_div">
			       		<button type="button" class="btn btn-info purple" onClick ="findID()">확인 </button>  		
			       		<button type="button" class="btn gray" data-dismiss="modal">취소</button>			        
		      	   </div>
			</div>
			
		<!-- 비밀번호 찾기 모달창1 - 입력부분 -->
			<div id="tab-2" class="tab-content">
				<div id="content_searchPw" class="row">

					<div class="col-lg-12">
						<div class="form-group row">
							<label for="inputEmail3" class="col-lg-3 ">아이디</label>
							<div class="col-lg-9">
								<input type="text" class="form-control form-control-sm" id ="user_id_p" name="user_id_p" placeholder ="아이디" value ="lee">
							</div>
						</div>
					</div>
					
					<div class="col-lg-12">
						<div class="form-group row">
							<label for="inputEmail3" class="col-lg-3 ">이름</label>
							<div class="col-lg-9">
								<input type="text" class="form-control form-control-sm" id ="user_nm_p" name="user_nm_p" placeholder ="이름" value ="이영은">
							</div>
						</div>
					</div>
					
					<div class="col-lg-12">
						<div class="form-group row">
							<label for="inputEmail3" class="col-lg-3 ">이메일</label>
							<div class="col-lg-9">
								<input type="text" class="form-control form-control-sm" id ="user_email_p" name="user_email_p" placeholder ="이메일" value="bono6315@gmail.com" >
							</div>
						</div>
					</div>

					<p class="info_text"> 등록되어있는 이메일로 임시 비밀번호를 보내드립니다.</p>
				      <div class="modal-footer btn_div">
				        <button type="button" class="btn btn-info purple" onClick ="findPw()">확인 </button>
				        <button type="button" class="btn gray" data-dismiss="modal">취소</button>
				    </div>
			  </div> 
			  
			  <!-- 비밀번호 찾기 -->
			  <div class ="result_pw" id="resultPw">
				<p class="info_text"> 등록된 메일로 임시 비밀번호를 전송 하였습니다. 로그인 후 재설정 하시기 바랍니다.</p>
				<div class="modal-footer modal-footer-result btn_div">
			  		<button id="close_modal_pw" type="button" class="btn btn-info purple" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>

	</div>
			
	    </div>
	  </div>
	</div>
	<!-- Button trigger modal -->

	</div>
</div>
</body>

<script>
	var tmp =0;
	$(function(){
	    $("#findId").click(function(){
	        $('div.modal').modal({
			});
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

function findID(){
		 var user_nm = $("#user_nm").val();
		 var bizno =  $("#bizno1").val()+ $("#bizno2").val()+ $("#bizno3").val();
		 var user_email = $("#user_email").val();
		 
     		if(user_nm == "" | user_email == "" | bizno == ""){
     			alert("정보를 모두 입력해주세요");     		
			} else {
				if(confirm("아이디를 확인하시겠습니까?")==true){
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
                                   	 alert("입력하신 사업자번호 정보가 올바르지 않습니다. 확인부탁드립니다.");
                                   	 		
                               	 }else if(result=="searched_fail")
                                   	 alert("입력하신 이름/이메일 정보가 올바르지 않습니다. 확인부탁드립니다.");
                            	 
                       	 }else{
								alert("입력한 정보가 올바르지 않습니다. 확인하고 입력해주세요.");
                           	 }
                       	 }
         			  	});
					}     
				}
			
	}

	$("#close_modal").click(function(){
			location.reload();    	          		   	     	          						
		})
	
	function findPw(){
	console.log("aa");
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
	});
    
	//사업자 번호 숫자만 입력받도록 
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
</script>
</html>