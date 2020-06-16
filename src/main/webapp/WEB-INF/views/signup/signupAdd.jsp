<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- c.tld의 uri -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="author" content="">
<title></title>
<!-- Font Awesome -->
<link rel="stylesheet" href="/plugins/fontawesome-free/css/all.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="/dist/css/adminlte.min.css">
<link rel="stylesheet" href="/css/index.css">
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
</head>
<style>
.btn.btn-primary.btn-xs {
	background-color: #6610f2;
	border-color: 6610f2;
}
</style>

<body>
	<div>
<form name="frm" id="frm" action="/signup/addForm.proc" method="POST">
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<div class="row" id="content">

	<div class="col-lg-12">
		<div class="banner">
			<h2>기술지원 회원가입</h2>
			<span>기업 정보 및 담당자 정보를 입력 후 최종 승인이 완료되어야 사용이 가능하십니다.</span>
		</div>
	</div>

	<div class="col-12">
		<div class="card card-primary">
			<div class="card-header">
				<h3 class="card-title">기업정보</h3>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">업체명(한글)</label>
	                    <div class="col-lg-8">
	                      <input type="text" placeholder="업체명(한글)" id="biznm" name="biznm" class="form-control koreanOnly" maxlength="50"/>
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">업체명(영문)</label>
	                    <div class="col-lg-8">
	                      <input type="text" placeholder="업체명(영문)" id="biznm_en" name="biznm_en" class="form-control englishOnly" maxlength="50"/>
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">업종</label>
	                    <div class="col-lg-8">
	                    	<input type="text" placeholder="업종" id="biztype" name="biztype" class="form-control" maxlength="20">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">업태</label>
	                    <div class="col-lg-8">
	                    	<input type="text" placeholder="업태" id="bizkind" name="bizkind" class="form-control" maxlength="20">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">사업자번호</label>
	                    <div class="col-lg-8 tel_div">
	                    	<input type="tel" class="form-control filter col-lg-3 numberOnly" id="bizno1" placeholder="" name="bizno1" maxlength="3" >
	                    	<input type="tel" class="form-control filter col-lg-2 numberOnly" id="bizno2" placeholder="" name="bizno2" maxlength="2" >	
							<input type="tel" class="form-control filter col-lg-3 numberOnly" id="bizno3" placeholder="" name="bizno3" maxlength="5" >		
							<input type="button" class="form-control filter col-lg-3" name="bizno" value="확인 " id="biznoCheck" onclick="fn_bizNoCheck();">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">사업자구분</label>
	                    <div class="col-lg-8">
	                      <select id="biz_auth_role" name="biz_auth_role" class="form-control">
								<option>선택</option>
								<option value="1">총판사</option>
								<option value="2">파트너사</option>
								<option value="3">일반</option>
							</select>
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">대표자명</label>
	                    <div class="col-lg-8">
	                      <input type="text" placeholder="대표자명" id="rprsnt_nm" name="rprsnt_nm" class="form-control" maxlength="20"> 
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label"></label>
	                    <div class="col-lg-8">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">주소</label>
	                    <div class="col-lg-8">
	                    	<input type="text" placeholder="주소" id="addr1" name="addr1" class="form-control" maxlength="80">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">상세주소</label>
	                    <div class="col-lg-8">
	                    	<input type="text" placeholder="상세주소" id="addr2" name="addr2" class="form-control" maxlength="30">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">전화번호</label>
	                    <div class="col-lg-8 tel_div">
	                    	<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="tele1" name="tele1" maxlength="3">
							<span class="col-lg-1"> - </span>
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="tele2" name="tele2" maxlength="4">
							<span class="col-lg-1"> - </span>
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="tele3" name="tele3" maxlength="4">
	                    </div>
	                  </div>
                  </div>
                  
                  <div class="col-lg-6">
					<div class="form-group row">
	                    <label for="inputEmail3" class="col-lg-4 col-form-label">팩스</label>
	                   <div class="col-lg-8 tel_div">
	                   	<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="fax1" name="fax1" maxlength="3">
							<span class="col-lg-1"> - </span>
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="fax2" name="fax2" maxlength="4">
							<span class="col-lg-1"> - </span>
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" id="fax3" name="fax3" maxlength="4">
					</div>
				</div>
			</div>
		</div>
	</div>


		<div class="card card-primary">
			<div class="card-header">
				<h3 class="card-title">담당자 정보</h3>
			</div>
			
			<div class="card-body card-primary card-outline row">
	
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">담당자명</label>
						<div class="col-lg-8">
							<input type="text" placeholder="담당자명" class="form-control" id="user_nm" name="user_nm" maxlength="30">
						</div>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">담당자 ID</label>
						<div class="input-group col-lg-8">
							<input type="text" placeholder="담당자 ID" class="form-control idInputFormOnly" id="user_id" name="user_id" maxlength ="10">
							<div class="input-group-append">
								<input type="button" name="addUser_id" class="btn btn-primary btn-xs" value="중복확인" onclick="fn_userIDCheck()">
							</div>
						</div>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">비밀번호</label>
						<div class="col-lg-8">
							<input type="password"  placeholder="비밀번호" class="form-control" id="user_passwd1" name="user_passwd1" required maxlength="30">
						</div>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">비밀번호 재입력</label>
						<div class="col-lg-8">
							<input type="password" placeholder="비밀번호 재입력" class="form-control" id="user_passwd2" name="user_passwd2" required maxlength="30">
						</div>
							<div class="error invalid-feedback" id="alert-danger" style="text-align: center">비밀번호가 일치하지 않습니다.</div>
					</div>
					
				</div>
				
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">부서</label>
						<div class="col-lg-8">
							<input type="text" placeholder="부서" class="form-control" id="user_dept" name="user_dept" maxlength="20">
						</div>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">직급</label>
						<div class="col-lg-8">
							<input type="text" placeholder="직급" class="form-control" id="user_rank" name="user_rank" maxlength="20">
						</div>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">전화번호</label>
						<div class="col-lg-8 tel_div">
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" placeholder="" id="user_hp1" name="user_hp1" maxlength="3">
							<span class="col-lg-1"> - </span>
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" placeholder="" id="user_hp2" name="user_hp2" maxlength="4">
							<span class="col-lg-1"> - </span>
							<input type="tel" class="form-control filter col-lg-3 inputs numberOnly" placeholder="" id="user_hp3" name="user_hp3" maxlength="4">
	                    </div>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group row">
						<label for="inputEmail3" class="col-lg-4 col-form-label">메일</label>
						<div class="col-lg-8">
							<input type="email" placeholder="메일" class="form-control" id="user_email" name="user_email" style="width: 100%;" maxlength="30">
						</div>
					</div>
				</div>
			</div>
			
			<div class="card-footer row">
				<!-- page number -->
				<ul class="pagination justify-content-left m-0 col-6"></ul>
				<div class="col-6 cont_btn_div">
					<button type="submit" class="btn btn-info purple" >가입신청</button>
				 	<button type="button" class="btn btn-info gray" onclick="cancelConfirm();" >취소</button>
			 	</div>
			</div>
		</div>
	</div>
</div>
		</form>
	</div>
</body>
<script>
  // 입력정보 DB로 저장
	function saveConfirm(){
		var tele = ($("#tele1").val() + $("#tele2").val() + $("#tele3").val());
		var fax = ($("#fax1").val() + $("#fax2").val() + $("#fax3").val());
		var user_hp = ($("#user_hp1").val() + $("#user_hp2").val() + $("#user_hp3").val());

		
		if(confirm("제출 하시겠습니까?")==true){
				if((userIDCk && biznoCk)== 1){ 
					 if (biznoCk==1)
						 alert('사업자번호 중복체크를 해주세요');
					 else if (userIDCk==1)
						 alert('아이디 중복체크를 해주세요');
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
				alert(chkbiz);
									
				if(chkbiz == true){
					console.log("유효한 사업자 번호이다 --> "+chkbiz);		
					//alert("유효한 사업자 번호이다 --> "+chkbiz);
						
					$.ajax({
		             data : {'bizno':bizno},
		             url : "/signup/biznoCheck.proc",
		             dataType : "json",
		             contentType: "application/json; charset=UTF-8",
		             success : function(cnt) {
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
				alert("유효하지 않은 사업자번호입니다. 다시 입력해주세요");
	
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

 		// 국문, 숫자, 공백
 		$(".koreanOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^ㄱ-ㅎ가-힣\s|^0-9]+$/gi,""));
 		});
 		
		// 영문, 숫자, 공백
 		$(".englishOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9]+$/gi,""));
 		});

 		// id 영문, 숫자, 특수기호 허용
	 	$(".idInputFormOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}]+$/gi,""));
 		});
 		
 	 	$.validator.setDefaults({
 	 	    submitHandler: function () {
	 	    	saveConfirm();
 	 	    }
 	 	  }); 
	 	  
 	 	$('#frm').validate({
 	 	   rules: {
				// 업체명(영문)
				biznm_en: {
				required : true
					},
 	 		   //유저 아이디
				user_id: {
					required : true
					},
				//유저 비밀번호1
				user_passwd1: {
					required : true
					},
				//유저 비밀번호1
				user_passwd1: {
					required : true
				},
			 	 	 	   
 	 	 	   //사업자 번호
 	 	  		bizno1: {
	 		        required: true
	 		      },
 	 	 	   	bizno2: {
 	 	 	   	required: true	 		        
 	 		      },
 	 		      bizno3: {
 	 		    	required: true
 	 		      },
 	 		    user_email:{
					email:true
 	 	 		    }
 	 		    
 	 	    }, messages: {
 	 	   		// 업체명(영문  )
				biznm_en: {
					required : "회사명을 입력해주세요",
					},
				//유저 아이디
				user_id: {
					required : "아이디를 입력해주세요. 영문, 숫자, 특수문자 가능",
					},
				//유저 비밀번호1
				user_passwd1: {
					required : "비밀번호를 입력해주세요"
				},
				//유저 비밀번호1
				user_passwd2: {
					required : "  "
				},
							
 	 	 	    //사업자 번호
 	 	    	bizno1: {
 	 		        required: "사업자 번호를 입력 해주세요.",
 	 	          },
 	 	 	    	bizno2: {
 	 	 		        required: "",
 	 	 	          },
 	 	 	       bizno3: {
 	 	 	    		required: ""
	 	 	          },
 	 	 		    user_email:{
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
 	     });


</script>
</body>