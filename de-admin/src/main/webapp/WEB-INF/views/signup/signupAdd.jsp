<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- c.tld의 uri -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<title>Invesume STS | 회원가입</title>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">

<!-- Font Awesome -->
<link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/adminlte.min.css">
<!-- Google Font: Source Sans Pro -->
<link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
<!-- jQuery -->
<script src="/plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>


<!-- CSS Files -->
<link href="/paper-bw/assets/css/themify-icons.css" rel="stylesheet">
<link href="/paper-bw/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="/paper-bw/assets/css/paper-bootstrap-wizard.css" rel="stylesheet" />

<link rel="stylesheet" href="/css/index.css">

<style>
hr.col-lg-12 { 
	margin: 10px 0 20px 0;
	padding: 0; 
}

body { background-color: #F0F5FB }
.bg_div { 
	background: #F0F5FB url(/img/bg.jpg);
	background-position: center right;
	background-size: cover;
    opacity: .5;
    position: absolute;
	top: 0;
    height:100%;
    width:100%;
    z-index:-1;
}

.wizard-card {
	background-color: #FFF;
	border-radius: .25em;
	box-shadow: 0 0 10px rgba(0,0,0,.25);
	margin: auto;
	margin-top: 20px;
	margin-bottom: 20px;
	max-width: 700px;
	padding: 30px;
	text-align: center;
}

.wizard-card form { padding: 25px 0 0 }

.wizard-header h1.title {
	font: normal 35px nanumgothic;
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
	left: 13%;
}
h1.title:after {
	background: linear-gradient(to right, #7e7e7e 0%, #fff 100%);
	right: 13%;
}

.wizard-navigation {
	margin: auto;
	width: 85%;
}

.wizard-card .tab-content { min-height: auto }
.tab-content .card { 
	background: none; 
	padding: 0;
	margin: 0;
	box-shadow: none;
}
.card-body { 
	text-align: left; 
	border-top: none;
}

.form-control { 
	background-color: #FFF; 
	border: 1px solid #ccc;
}

.btn_div { width: 100% }
.btn_div button { 
	margin: 10px 0;
	width: 100%;
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


ul.tabs {
	border-top: 1px solid #D8D8D8;
	list-style: none;
	margin: 0px;
	margin-top: 10px;
	padding: 0px;
	padding-top: 10px;
}

ul.tabs li {
	display: inline-block;
	font-size: 12px;
}

ul.tabs li a { 
	color: #6610f2; 
	cursor: pointer;
}


h5.info-text { 
	margin: 130px 0 0 0;
	padding: 0;
}
span.info-text {
	display: block;
	margin: 0 0 130px 0;
	text-align: center;
	width: 100%;
}

@media (min-width: 991px){
	.tel_div.bizno .form-control { padding: 7px 10px }
	.tel_div.bizno #biznoCheck { border-radius: 0 4px 4px 0 }
	
	.tel_div.user_nm  .form-control { border-radius: 4px 0 0 4px }
	.tel_div.user_nm  .btn { border-radius: 0 4px 4px 0 }
	
	.tel_div.user_nm
}

</style>
</head>

<body>
<div class="bg_div"></div>

<div class="card wizard-card" data-color="blue">
<form name="frm" id="frm" action="/signup/addForm.proc" method="POST" autocomplete="off">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

	<div class="wizard-header text-center">
		<h1 class="title"><b>회 원 가 입</b></h1>
	</div>
	
	<div class="wizard-navigation">
		<div class="progress-with-circle">
		     <div class="progress-bar" role="progressbar" aria-valuenow="1" aria-valuemin="1" aria-valuemax="3" style="width: 21%;"></div>
		</div>
		<ul>
			<li>
				<a href="#about" data-toggle="tab">
					<div class="icon-circle"><i class="ti-briefcase"></i></div>
					기업정보
				</a>
			</li>
			<li>
				<a href="#account" data-toggle="tab">
					<div class="icon-circle"><i class="ti-user"></i></div>
					담당자정보
				</a>
			</li>
			<li>
				<a href="#address" data-toggle="tab">
					<div class="icon-circle"><i class="ti-map"></i></div>
					회원가입
				</a>
			</li>
		</ul>
	</div>


	<div class="tab-content">
	
		<!-- 기업정보 -->
		<div class="tab-pane row" id="about">
		
			<div class="col-12">
				<div class="card">
					
					<div class="card-body row" style="padding: 1rem !important">

						<div class="col-lg-6">
							<div class="form-group">
			                    <label for="biznm" class="col-form-label">업체명(한글)</label>
								<input type="text" placeholder="업체명(한글)" id="biznm" name="biznm" class="form-control koreanOnly" minlength="2" maxlength="50"/>
			                  </div>
		                  </div>
		                  
		                  <div class="col-lg-6">
							<div class="form-group">
			                    <label for="biznm_en" class="col-form-label">업체명(영문)</label>
		                      <input type="text" placeholder="업체명(영문)" id="biznm_en" name="biznm_en" class="form-control englishOnly" minlength="3" maxlength="50"/>
			                  </div>
		                  </div>
						
		                  <div class="col-lg-6">
							<div class="form-group">
			                    <label for="bizno1" class="col-form-label">사업자 번호</label>
			                    <div class="tel_div bizno row">
			                    	<input type="tel" class="form-control filter col-lg-3 numberOnly" id="bizno1" placeholder="000"  name="bizno1" maxlength="3" >
			                    	<span class="col-lg-1 disable_sm"> - </span>
			                    	<input type="tel" class="form-control filter col-lg-2 numberOnly" id="bizno2" placeholder="00" name="bizno2" maxlength="2" >
			                    	<span class="col-lg-1 disable_sm"> - </span>	
									<input type="tel" class="form-control filter col-lg-3 numberOnly" id="bizno3" placeholder="00000" name="bizno3" maxlength="5" style="border-radius: 4px 0 0 4px">
									<input type="button" class="btn btn-primary btn-xs col-lg-2" name="bizno" value="확인 " id="biznoCheck" onclick="fn_bizNoCheck();">
			                    </div>
			                  </div>
		                  </div>

		                  <div class="col-lg-6">
							<div class="form-group">
			                    <label for="rprsnt_nm" class="col-form-label">대표자명</label>
		                      <input type="text" placeholder="대표자명" id="rprsnt_nm" name="rprsnt_nm" class="form-control" maxlength="20"> 
			                  </div>
		                  </div>
		                  
		                  <hr class="col-lg-12"/>
		                  
		                  <div class="col-lg-6">
							<div class="form-group">
			                    <label for="biztype" class="col-form-label">업종</label>
		                    	<input type="text" placeholder="업종" id="biztype" name="biztype" class="form-control" maxlength="20">
			                  </div>
		                  </div>
		                  
		                  <div class="col-lg-6">
							<div class="form-group">
			                    <label for="bizkind" class="col-form-label">업태</label>
		                    	<input type="text" placeholder="업태" id="bizkind" name="bizkind" class="form-control" maxlength="20">
			                  </div>
		                  </div>
		                  
						<div class="col-lg-6">
							<div class="form-group">
			                    <label for="biz_auth_role" class="col-form-label">사업자구분</label>
			                      <select id="biz_auth_role" name="biz_auth_role" class="form-control">
										<option>선택</option>
										<option value="1">총판사</option>
										<option value="2">파트너사</option>
										<option value="3">일반</option>
									</select>
			                  </div>
		                  </div>
		                  
		                  <hr class="col-lg-12"/>
		                  
		                  <div class="col-lg-6">
							<div class="form-group">
			                    <label for="tele1" class="col-form-label">전화번호</label>
			                    <div class="tel_div row">
			                    	<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="tele1" name="tele1" maxlength="3" placeholder="000">
									<span class="col-lg-1 disable_sm"> - </span>
									<input type="tel" class="form-control filter col-lg-3_5 inputs numberOnly" id="tele2" name="tele2" maxlength="4" placeholder="0000">
									<span class="col-lg-1 disable_sm"> - </span>
									<input type="tel" class="form-control filter col-lg-3_5 inputs numberOnly" id="tele3" name="tele3" maxlength="4" placeholder="0000">
			                    </div>
			                  </div>
		                  </div>
			                  
		                  <div class="col-lg-6">
								<div class="form-group">
				                    <label for="fax1" class="col-form-label">팩스</label>
				                   <div class="tel_div row">
				                   	<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="fax1" name="fax1" maxlength="3" placeholder="000">
										<span class="col-lg-1 disable_sm"> - </span>
										<input type="tel" class="form-control filter col-lg-3_5 inputs numberOnly" id="fax2" name="fax2" maxlength="4" placeholder="0000">
										<span class="col-lg-1 disable_sm"> - </span>
										<input type="tel" class="form-control filter col-lg-3_5 inputs numberOnly" id="fax3" name="fax3" maxlength="4" placeholder="0000">
								</div>
							</div>
						</div>
		                  
	                  <hr class="col-lg-12"/>
	                  
	                  <div class="col-lg-12">
						<div class="form-group">
		                    <label for="addr1" class="col-form-label">주소</label>
	                    	<input type="text" placeholder="주소" id="addr1" name="addr1" class="form-control" maxlength="80">
		                  </div>
	                  </div>
		                  
	                  <div class="col-lg-12">
						<div class="form-group">
		                    <label for="addr2" class="col-form-label">상세주소</label>
	                    	<input type="text" placeholder="상세주소" id="addr2" name="addr2" class="form-control" maxlength="30">
		                  </div>
	                  </div>
		                  
	                  
					</div>
				</div>
			</div>
		</div>


		<!-- 담당자정보 -->
		<div class="tab-pane row" id="account">
		
			<div class="col-12">
				<div class="card">
				
					<div class="card-body row" style="padding: 1rem !important">
			
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_nm" class="col-form-label">담당자명</label>
								<input type="text" placeholder="담당자명" class="form-control" id="user_nm" name="user_nm" maxlength="30">
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_id" class="col-form-label">담당자 아이디</label>
								<div class="tel_div user_nm row">
									<input type="text" placeholder="담당자 아이디" class="form-control idInputFormOnly col-lg-9" id="user_id" name="user_id" minlength="3" maxlength ="10">
									<input type="button" name="addUser_id" class="btn btn-primary btn-xs col-lg-3" value="중복확인" onclick="fn_userIDCheck()">
								</div>
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_passwd1" class="col-form-label">비밀번호</label>
								<input type="password"  placeholder="비밀번호" class="form-control" id="user_passwd1" name="user_passwd1" required maxlength="30">
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_passwd2" class="col-form-label">비밀번호 재입력</label>
								<input type="password" placeholder="비밀번호 재입력" class="form-control" id="user_passwd2" name="user_passwd2" required maxlength="30">
								<div class="error invalid-feedback" id="alert-danger" style="text-align: center">비밀번호가 일치하지 않습니다.</div>
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_email" class="col-form-label">메일</label>
								<input type="email" placeholder="메일" class="form-control" id="user_email" name="user_email" style="width: 100%;" maxlength="30">
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_hp1" class="col-form-label">전화번호</label>
								<div class="tel_div row">
									<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="user_hp1" name="user_hp1" maxlength="3" placeholder="000">
									<span class="col-lg-1 disable_sm"> - </span>
									<input type="tel" class="form-control filter col-lg-3_5 inputs numberOnly" id="user_hp2" name="user_hp2" maxlength="4" placeholder="0000">
									<span class="col-lg-1 disable_sm"> - </span>
									<input type="tel" class="form-control filter col-lg-3_5 inputs numberOnly" id="user_hp3" name="user_hp3" maxlength="4" placeholder="0000">
			                    </div>
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_dept" class="col-form-label">부서</label>
								<input type="text" placeholder="부서" class="form-control" id="user_dept" name="user_dept" maxlength="20">
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="user_rank" class="col-form-label">직급</label>
								<input type="text" placeholder="직급" class="form-control" id="user_rank" name="user_rank" maxlength="20">
							</div>
						</div>
						
					</div>
				</div>
	
			</div>
		</div>


		<!-- 회원가입 -->
		<div class="tab-pane" id="address">
			<div class="col-lg-12">
				<div class="card">
				
					<div class="card-body row" style="padding: 1rem !important">
						<h5 class="info-text col-lg-12" style="margin: 130px 0 0 0; padding: 0;">가입신청 하시겠습니까?</h5>
						<span class="info-text">가입승인 이후 사용하실 수 있습니다.</span>
					</div>
				</div>
			</div>
			
		</div>
	</div>
	
	<div class="wizard-footer row">
		<div class="pull-left btn_div col-lg-6">
		    <button type='button' class='btn btn-previous gray' name='previous'>이전</button>
		</div>
		
		<div class="pull-right btn_div col-lg-6">
		    <button type='button' class='btn btn-next purple' name='next'>다음</button>
		    <button type="submit" class="btn btn-finish purple" name='finish'>가입신청</button>
		</div>
		
		<div class="clearfix"></div>
		
		<ul class="tabs col-lg-12">
			<li class="tab-link">이미 회원이십니까? <a href="/sign/login">로그인</a></li>
		</ul>
	</div>

</form>

</div>

<!--   Core JS Files   -->
<script src="/paper-bw/assets/js/jquery-2.2.4.min.js" type="text/javascript"></script>
<script src="/paper-bw/assets/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/paper-bw/assets/js/jquery.bootstrap.wizard.js" type="text/javascript"></script>

<!--  Plugin for the Wizard -->
<!-- <script src="/paper-bw/assets/js/paper-bootstrap-wizard.js" type="text/javascript"></script> -->

<!--  More information about jquery.validate here: https://jqueryvalidation.org/	 -->
<script src="/paper-bw/assets/js/jquery.validate.min.js" type="text/javascript"></script>

<script>
	searchVisible = 0;
	transparent = true;

	// 입력정보 DB로 저장
	function saveConfirm(){
		var tele = ($("#tele1").val() + $("#tele2").val() + $("#tele3").val());
		var fax = ($("#fax1").val() + $("#fax2").val() + $("#fax3").val());
		var user_hp = ($("#user_hp1").val() + $("#user_hp2").val() + $("#user_hp3").val());

		if(confirm("제출 하시겠습니까?")==true){
			if((userIDCk || biznoCk)== 1){
				if (biznoCk==1){
					alert('[기업정보] 사업자번호 중복체크를 해주세요');
					$('.nav.nav-pills a[href="#about"]').trigger('click')
				}
				else if (userIDCk==1){
					alert('[담당자정보] 담당자 아이디 중복체크를 해주세요');
					$('.nav.nav-pills a[href="#account"]').trigger('click')
				}
			}
			else{
					document.frm.submit();
					alert("제출이 완료되었습니다. 관리자의 승인 완료시까지 대기부탁드립니다!");
					location.replace('/sign/login');
			}
		}else return;
	}

	 //입력정보  초기화하기 >>> 입력취소 
	function cancelConfirm(){
		if(confirm("취소 하시겠습니까?")==true){
			location.replace('/sign/login');
		}
	}
	// 사업자 번호 유효성 체크
	function checkBizNo(bizno){
		// 넘어온 값의 정수만 추츨하여 문자열의 배열로 만들고 10자리 숫자인지 확인합니다.
		if ((bizno = (bizno+'').match(/\d{1}/g)).length != 10) { 
			return false; 
		}
	
		// 합 / 체크키
		var sum = 0, key = [1, 3, 7, 1, 3, 7, 1, 3, 5];
	
		// 0 ~ 8 까지 9개의 숫자를 체크키와 곱하여 합에더합니다.
		for (var i = 0 ; i < 9 ; i++) {
			 sum += (key[i] * Number(bizno[i]));
		 }
	
		// 각 8번배열의 값을 곱한 후 10으로 나누고 내림하여 기존 합에 더합니다.
		// 다시 10의 나머지를 구한후 그 값을 10에서 빼면 이것이 검증번호 이며 기존 검증번호와 비교하면됩니다.
		return (10 - ((sum + Math.floor(key[8] * Number(bizno[8]) / 10)) % 10)) == Number(bizno[9]);
	}
	

	  
	//사업자번호 체크여부 확인 (아이디 중복일 경우 = 0 , 중복이 아닐경우 = 1 )
	var biznoCk = 1;
	function fn_bizNoCheck(){
	 	 	
	 	var bizno = ($("#bizno1").val() + $("#bizno2").val() + $("#bizno3").val());
		//alert(bizno);
		
		if(bizno == "undefinded" || bizno == "" ){
			alert("사업자 번호를 입력해주세요");
				
		} else{
			//alert("일단 undefinded가 아니야");
			var chkbiz = checkBizNo(bizno);
										
			if(chkbiz == true){
				console.log("유효한 사업자 번호이다 --> "+chkbiz);		
				//alert("유효한 사업자 번호이다 --> "+chkbiz);
							
				$.ajax({
	             data : {'bizno':bizno},
	             url : "/signup/biznoCheck.proc",
	             dataType : "json",
	             contentType: "application/json; charset=UTF-8",
	             success : function(cnt) {
	            	 var cnt = cnt.cnt;
	            	   if (cnt == 1) {                       
	                       alert("사업자 번호가 이미 존재합니다. 번호를 확인해주세요.");
	                       biznoCk = 1;
	                    		
	                   } else if(cnt == 0 ){
	                       	if(biznoCk != ""){
		                       	alert("사용가능한 사업자 번호입니다.");
		                      	biznoCk = 0;
	
	                       		} else{
	                       		 	alert("사업자 번호를 입력해주세요");
		  	                      	biznoCk = 1;
								}
						}
					},
					error : function(error) {
						alert("ERORR T_T: " + error);
					}
				});
			} else{
				alert("유효하지 않은 사업자번호입니다. 확인후 다시 입력해주세요");
			}
		}
	}

	//유저 아이디 체크하기
	var userIDCk = 1;
	function fn_userIDCheck(){
		 	
		var user_id = $("#user_id").val();
	
		if(user_id == "undefinded" || user_id == "" ){
			alert("아이디를 입력해주세요");
				
		} else{ 	
	 		  $.ajax({
	 			 data : {'user_id':user_id},
	             url : "/signup/userIDCheck.proc",
	             dataType : "json",
	             contentType: "application/json; charset=UTF-8",
	             success : function(data) {
	              	   if (data.cnt == 1) {
	              		 alert( user_id + "는 이미 존재합니다. 다른 아이디를 입력해주세요.");
	                      userIDCk = 1;
	
	                     } else if(data.cnt == 0) {
	                  	 		if(user_id != ""){
	                          	 alert("사용가능한 아이디입니다.");
	                       		 userIDCk = 0;
	                           	
	                           } else {
	                           	alert("아이디를 입력해주세요");
	                        	  	userIDCk = 1;
	                           	}
	                     }
	                 },
	                 error : function(error) {
	                     alert("ERORR t_t: " + error);
	                 }
	          });
		 } 
	 }

   // 비밀번호 재입력 확인
	$(function(){
		$("#alert-success").hide(); 
		$("#alert-danger").hide(); 
		$("#user_passwd2").keyup(function(){ 
			var user_passwd1=$("#user_passwd1").val();
			var user_passwd2=$("#user_passwd2").val(); 
			if(user_passwd1 != "" || user_passwd2 != ""){
				if(user_passwd1 == user_passwd2){ 
					$("#alert-success").show();
					$("#alert-danger").hide(); 
					$("#submit").removeAttr("disabled"); 
				}else{
					$("#alert-success").hide(); 
					$("#alert-danger").show(); 
					$("#subenglishOnlymit").attr("disabled", "disabled"); 
				}
			}
		});
/* 
 	 	$(".inputs").on("keyup",function () {
	        var charLimit =
	        	charLimit = $(this).attr("maxlength");
	        if (this.value.length >= charLimit.size) {
		        console.log($(this).length);
		        $(this).next(".inputs").focus();
	            return false;
	        }
	    }); */
	    
	    // 숫자만
 		$(".numberOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^0-9]/g,""));
 		});

 		// 국문, 숫자, 공백, 특수문자
 		$(".koreanOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^ㄱ-ㅎ가-힣\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
 		});
 		
		// 영문, 숫자, 공백, 특수문자
 		$(".englishOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
 		});

 		// id 영문, 숫자, 특수기호 허용
	 	$(".idInputFormOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{},.]+$/gi,""));
 		});
 		
 	 	$.validator.setDefaults({
 	 	    submitHandler: function () {
	 	    	saveConfirm();
 	 	    }
		}); 

 	 	
		$(document).ready(function(){
			/*  Activate the tooltips      */
			$('[rel="tooltip"]').tooltip();
			var $validator = $('#frm').validate({
				rules: {
					biznm: { // 업체명(한글)
						required : true
					},
					biznm_en: { // 업체명(영문)
						required : true
					},
//					rprsnt_nm: { // 대표자명
//						required : true
//					},
					user_id: { //유저 아이디
						required : true
					},
					user_passwd1: { //유저 비밀번호1
						required : true
					},
					user_passwd1: { //유저 비밀번호1
						required : true
					},
	 	 	  		bizno1: { //사업자 번호1
						required: true
					},
	 	 	 	   	bizno2: { //사업자 번호2
	 	 	 	   		required: true	 		        
					},
					bizno3: { //사업자 번호3
						required: true
					},
	 	 		    user_email:{ // 메일
						email:true
					}
				}, messages: {
					biznm: { // 업체명(한글)
						required : "회사명을 입력해주세요",
						minlength : $.validator.format( "{0}자 이상 입력하세요." ),
					},
					biznm_en: { // 업체명(영문)
						required : "회사명을 입력해주세요",
						minlength : $.validator.format( "{0}자 이상 입력하세요." ),
					},
					rprsnt_nm: { // 대표자명
						required : "대표자명을 입력해주세요",
					},
					user_id: { //유저 아이디
						required : "아이디를 입력해주세요. 영문, 숫자, 특수문자 가능",
						minlength : $.validator.format( "{0}자 이상 입력하세요." ),
					},
					user_passwd1: { //유저 비밀번호1
						required : "비밀번호를 입력해주세요"
					},
					user_passwd2: { //유저 비밀번호2
						required : "  "
					},
	 	 	    	bizno1: { //사업자 번호1
						required: "사업자 번호를 입력 해주세요.",
					},
					bizno2: { //사업자 번호2
						required: "",
					},
	 	 	       bizno3: { //사업자 번호3
						required: ""
					},
					user_email:{ // 메일
						email:"이메일 형식을 확인해주세요"
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
	 	 	    }
			});
	
			
			// Wizard Initialization
			$('.wizard-card').bootstrapWizard({
				'tabClass': 'nav nav-pills',
	            'nextSelector': '.btn-next',
	            'previousSelector': '.btn-previous',
	
	            onNext: function(tab, navigation, index) {
	            	var $valid = $('.wizard-card form').valid();
	            	if(!$valid) {
	            		$validator.focusInvalid();
	            		return false;
	            	}
				},
	
	            onInit : function(tab, navigation, index){
	              //check number of tabs and fill the entire row
	              var $total = navigation.find('li').length;
	              $width = 100/$total;
	
	              navigation.find('li').css('width',$width + '%');
	            },
	
	            onTabClick : function(tab, navigation, index){
	                var $valid = $('.wizard-card form').valid();
	
	                if(!$valid){
	                    return false;
	                } else{
	                    return true;
	                }
	            },
	
	            onTabShow: function(tab, navigation, index) {
	                var $total = navigation.find('li').length;
	                var $current = index+1;
	
	                var $wizard = navigation.closest('.wizard-card');
	
	                // If it's the last tab then hide the last button and show the finish instead
	                if($current >= $total) {
	                    $($wizard).find('.btn-next').hide();
	                    $($wizard).find('.btn-finish').show();
	                } else {
	                    $($wizard).find('.btn-next').show();
	                    $($wizard).find('.btn-finish').hide();
	                }
	
	                //update progress
	                var move_distance = 100 / $total;
	                move_distance = move_distance * (index) + move_distance / 2;
	
	                $wizard.find($('.progress-bar')).css({width: move_distance + '%'});
	                //e.relatedTarget // previous tab
	
	                $wizard.find($('.wizard-card .nav-pills li.active a .icon-circle')).addClass('checked');
	
				}
			});
	
	
			// Prepare the preview for profile picture
			$("#wizard-picture").change(function(){
				readURL(this);
			});
	
			$('[data-toggle="wizard-radio"]').click(function(){
	                wizard = $(this).closest('.wizard-card');
	                wizard.find('[data-toggle="wizard-radio"]').removeClass('active');
	                $(this).addClass('active');
	                $(wizard).find('[type="radio"]').removeAttr('checked');
	                $(this).find('[type="radio"]').attr('checked','true');
			});
	
			$('[data-toggle="wizard-checkbox"]').click(function(){
	                if( $(this).hasClass('active')){
	                    $(this).removeClass('active');
	                    $(this).find('[type="checkbox"]').removeAttr('checked');
	                } else {
	                    $(this).addClass('active');
	                    $(this).find('[type="checkbox"]').attr('checked','true');
	                }
			});
	
			$('.set-full-height').css('height', 'auto');
	
		});
	
	
	
		//Function to show image before upload
	
		function readURL(input) {
	        if (input.files && input.files[0]) {
	            var reader = new FileReader();
	
	            reader.onload = function (e) {
	                $('#wizardPicturePreview').attr('src', e.target.result).fadeIn('slow');
	            }
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
	
	
	    function debounce(func, wait, immediate) {
	    	var timeout;
	    	return function() {
	    		var context = this, args = arguments;
	    		clearTimeout(timeout);
	    		timeout = setTimeout(function() {
	    			timeout = null;
	    			if (!immediate) func.apply(context, args);
	    		}, wait);
	    		if (immediate && !timeout) func.apply(context, args);
	    	};
	    };
	});

	$(window).load(function(){
		// background height setting
		$('.bg_div').css('height', $('html').css('height').split('px')[0]);
	});

	$(window).resize(function(){
		// background height setting
		$('.bg_div').css('height', $('html').css('height').split('px')[0]);
	});
</script>
</body>
</body>