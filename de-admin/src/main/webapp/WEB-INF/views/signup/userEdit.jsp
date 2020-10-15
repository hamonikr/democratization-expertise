<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- AdminLTE App -->
<script src="/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="/dist/js/demo.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

<link rel="stylesheet" href="/css/popup.css">
<style>
/* popup */
.popup_layer {
	background: #fff;
	border-radius: .5em;
	box-shadow: 0 0 10px rgba(0, 0, 0, .5), 0 1px 3px rgba(0, 0, 0, .2);
	display: none;
	left: 50%;
	margin-left: -190px;
	padding: 1em;
	position: absolute;
	top: 15%;
	width: 380px;
	z-index: 1;
}

.popup_layer .cont_btn_div {
	flex: none;
	max-width: 100%;
	padding: 0;
	text-align: center;
}

.popup_layer .cont_btn_div button:first-child {
	margin: 0
}

/* popup footer*/
.popup_layer .card-footer.row {
	padding-bottom: 2em
}

/* banner*/
.banner {
	background-image: url(/img/insert_banner_bg.png)
}

/* 목록 */
#memberTable a {
	cursor: pointer
}
</style>

<body>

	<!-- 레이어팝업 입력 부분 : 추가 담당자 추가  -->
<form id="add_frm" action="" autocomplete="off">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="dim-layer">
		<div class="dimBg"></div>
		<div id="layer2" class="card pop-layer">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>추가 담당자 정보</h5>
				</div>
			</div>
			
					
			<div class="card-body">
				<div class="form-group">
					<label for="inputEmail3">
						아이디<span class="important">*</span>
					</label>
					<input type="text" class="form-control addUser_id idInputFormOnly" placeholder="아이디" id="addUser_id" name="addUser_id" value="" maxlength="10">
				</div>

				<div class="form-group">
					<label for="inputPassword3">
						비밀번호<span class="important">*</span>
					</label>
					<input type="password" placeholder="비밀번호" id="addUser_passwd" class="form-control" maxlength="30">
				</div>

				<div class="form-group">
					<label for="inputEmail3">
						이름<span class="important">*</span>
					</label>
					<input type="text" placeholder="이름" id="addUser_nm" name="addUser_nm" class="form-control" maxlength="30">
				</div>

				<div class="form-group">
					<label for="inputEmail3">부서</label>
					<input type="text" placeholder="부서" name="addUser_dept" id="addUser_dept" class="form-control" maxlength="20">
				</div>

				<div class="form-group">
					<label for="inputEmail3">직급</label>
					<input type="text" placeholder="직급" id="addUser_rank" name="addUser_rank" class="form-control" maxlength="20">
				</div>

				<div class="form-group">
					<label for="inputEmail3">
						이메일<span class="important">*</span>
					</label>
					<input type="email" placeholder="메일" id="addUser_email" name="addUser_email" class="form-control" maxlength="20">
				</div>
			</div>
					
			<div class="card-footer row">
				<div class="col-12 cont_btn_div">
					<button type="submit" name="button" class="btn btn-primary purple">등록</button>
					<button type="button" class="btn btn-primary gray btn-layerClose">취소</button>
				</div>
			</div>
					<!--// content-->
		</div>
	</div>
</form>



	<!-- 레이어팝업 입력 부분 : 추가 담당자 수정 -->

<form id="edit_frm" action="" autocomplete="off">
 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 	<div class="dim-layer">
	 	<div class="dimBg"></div>
		<div id="editPop" class="card popup_layer">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>추가 담당자 정보</h5>
				</div>
			</div>
	
			<div class="card-body">
				<div class="form-group">
					<label for="inputEmail3">
						아이디<span class="important">*</span>
					</label>
					<input type="text" placeholder="아이디" name="addUser_id2" id="addUser_id2" class="form-control" readonly maxlength="30">
				</div>
	
				<div class="form-group">
					<label for="inputPassword3">
						비밀번호 <span class="important">*</span>
					</label>
					<input type="password" placeholder="비밀번호" name="addUser_passwd2" id="addUser_passwd2" class="form-control" maxlength="30">
				</div>
	
				<div class="form-group">
					<label for="inputEmail3">
						이름<span class="important">*</span>
					</label>
					<input type="text" placeholder="이름" name="addUser_nm2" id="addUser_nm2" class="form-control" maxlength="30">
				</div>
	
				<div class="form-group">
					<label for="inputEmail3">부서</label>
					<input type="text" placeholder="부서" name="addUser_dept2" id="addUser_dept2" class="form-control" maxlength="30">
				</div>
	
				<div class="form-group">
					<label for="inputEmail3">직급</label>
					<input type="text" placeholder="직급" name="addUser_rank2" id="addUser_rank2" class="form-control" maxlength="30">
				</div>
	
				<div class="form-group">
					<label for="inputEmail3">
						이메일 <span class="important">*</span>
					</label>
					<input type="email" placeholder="이메일" name="addUser_email2" id="addUser_email2" class="form-control" maxlength="30">
				</div>
			</div>
	
			<div class="card-footer row">
				<div class="col-6 cont_btn_div">
					<button type="submit" name="button" class="btn btn-primary purple">수정</button>
					<button type="button" class="btn btn-primary red" onClick="deleteAddUserInfo()">삭제</button>
					<button type="button" class="btn btn-primary gray" onClick="close_edit_pop()">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- 대표 담당자 정보 수정 부분  -->
	<!--content 입력 부분  -->
	<form name="frm" id="frm" method="POST" autocomplete="off">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<div class="row" id="content">
			<div id="input_div" class="col-12 " style="margin-top:.75rem;">
				<div class="callout callout-info row ">
					<div class="col-6">
						<h5> 담당자 정보 관리</h5>
					</div>
					<div class="col-6">
						<span class="float-right  "><a href="/main/index">Home</a> / 회원정보관리 / 담당자 정보관리</span>
					</div>
				</div>
			</div>

 
			<div id="input_div" class="col-12">
				<div class="card">
					
					<div class="row mb-2">
						<div class="col-sm-12">
							<h5>대표 담당자 정보</h5>
						</div>
					</div>
					
					<div class="card-body row">
						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3">담당자</label>
								<input type="text" class="form-control" placeholder="담당자" id="user_nm" name="user_nm" value="${userResult.user_nm}" maxlength="20">
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3">부서</label>
								<input type="text" class="form-control" placeholder="부서" id="user_dept" name="user_dept" value="${userResult.user_dept}" maxlength="20">
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3">연락처</label>
								<div class="tel_div row">
									<input type="tel" class="inputs form-control filter col-lg-2 numberOnly" id="user_hp1" name="user_hp1" value="${userResult.user_hp1}" maxlength=3> 
									<span class="col-lg-1"> - </span> 
									<input type="tel" class="inputs form-control filter col-lg-4 numberOnly" id="user_hp2" name="user_hp2" value="${userResult.user_hp2}" maxlength=4 > 
									<span class="col-lg-1"> - </span> 
									<input type="tel" class="inputs form-control filter col-lg-4 numberOnly" id="user_hp3" name="user_hp3" value="${userResult.user_hp3}" maxlength=4>
								</div>
							</div>
						</div>
						
						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3">직급</label>
								<input type="text" class="form-control" placeholder="직급" id="user_rank" name="user_rank" value="${userResult.user_rank}" maxlength="30">
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3">Email</label>
								<input type="email" class="form-control" id="user_email" name="user_email" value="${userResult.user_email}" maxlength="30">
							</div>
						</div>

						<div class="col-lg-6">
							<div class="form-group">
								<label for="inputEmail3">비밀번호</label>
								<input type="password" class="form-control" placeholder="비밀번호" id="user_passwd" name="user_passwd"  maxlength="50">
							</div>
						</div>

					</div>

					<div class="card-footer row">
						<!-- page number -->
						<ul class="pagination justify-content-left m-0 col-6">
						</ul>
						<div class="col-6 cont_btn_div">
							<button type="submit" class="btn btn-primary purple">저장</button>
						</div>
					</div>

				</div>
			</div>

			
			<div id="memberTable_div" class="col-12">
				<div class="card">
					
					<div class="row mb-2">
						<div class="col-sm-12">
							<h5>추가 담당자 정보</h5>
						</div>
					</div>
					
					<div class="card-body table-responsive p-0">
						<table id="memberTable" class="table table-hover text-nowrap">
							<thead>
								<tr>
									<th>아이디</th>
									<th>이름</th>
									<th>부서</th>
									<th>직급</th>
									<th>E-mail</th>
									<th style="text-align: center;">활성 여부</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${addList}" var="user">
									<tr>
										<td>
											<a onClick="ViewEditLayer('${user.user_id}','${user.user_nm}','${user.user_dept}','${user.user_rank}','${user.user_email}')">${user.user_id}</a>
										</td>
										<td>${user.user_nm}</td>
										<td>${user.user_dept}</td>
										<td>${user.user_rank}</td>
										<td>${user.user_email}</td>
										<td style="text-align: center;">
											<c:choose>
												<c:when test="${user.active_status == 'A'}">
													<label class="switch">
														<input type="checkbox" id="active_status_ck" name="active_status_ck" checked="checked" onClick="active_chk('${user.user_id}','${user.active_status}')"> <span class="slider round"></span>
													</label>
												</c:when>
												<c:otherwise>
													<label class="switch">
														<input type="checkbox" id="active_status_ck" name="active_status_ck" onClick="active_chk('${user.user_id}','${user.active_status}')"> <span class="slider round"></span>
													</label>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<div class="card-footer row">
						<!-- page number -->
						<ul class="pagination justify-content-left m-0 col-6">
						</ul>
						<div class="col-6 cont_btn_div">
							<button type="button" class="btn btn-primary purple" onclick="ViewLayer()">추가</button>
						</div>
					</div>

				</div>
			</div>
		</div>
	</form>

</body>

<!-- 스크립트 함수 정의 부분 -->

<script type="text/javascript">    
$(document).ready(function() { 
	
	const chkProcVal = $("#procVal").val();
	if( chkProcVal == 'Y' ){
		alert("정보수정이 완료되었습니다.");
	}else if( chkProcVal == 'YD' ){
		alert("담당자 정보 삭제 완료되었습니다.");
	}else if( chkProcVal == 'YN' ){
		alert("담당자 정보 삭제중 오류가 발생했습니다. 다시 시도후 같은 오류가 발생할 경우 관리자에게 문의바랍니다.");
	}else if( chkProcVal == 'N' ){
		alert("정보수정중 오류가 발생했습니다. 다시 시도후 같은 오류가 발생할 경우 관리자에게 문의바랍니다..");
	}
});





/* 부모 페이지 관련 함수 정의 부 */

//대표 담당자 정보 수정한 값 저장하기       
function saveEditConfirm(){
	if(confirm("저장 하시겠습니까?")==true){
		document.frm.action = "/signup/userEditForm.proc";
		document.frm.submit();
		//alert("저장이 완료되었습니다!");
		//location.reload();
	} else
		 return;
}

      
//입력정보 초기화하기 >>> 입력취소 
function cancelEditConfirm(){
	if(confirm("취소 하시겠습니까?")==true){
   	location.reload();
   } else "error";  			
}

// validation check
$(function(){ 
	 	// id 영문, 숫자, 특수기호 허용
	 	$(".idInputFormOnly").on("keyup", function() {
 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}]+$/gi,""));
 		});

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

		
 	 	$.validator.setDefaults({
 	 	    submitHandler: function () {
 	 	    	saveEditConfirm();
 	 	    }
 	 	  }); 
	 	  
	 	
 	$('#frm').validate({
	 	   rules: {
             // 유저 이메일 
			    user_email:{
					email:true
	 	 		    }

	 	    }, messages: {
	 	   		// 유저 이메일
				user_email: {
					email : "이메일 형식을 확인해주세요",
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



	$('#add_frm').validate({
		  rules: {
             // 유저 아이 
			    addUser_id:{
					required:true
	 	 	    },
 	 		  // 유저 비밀번호 
			    addUser_passwd:{
					required:true
	 	 	    },
	 	 	  // 유저 이름 
			    addUser_nm:{
					required:true
	 	 	    }, 
	 	 		  addUser_email:{
					email:true,
					required:true
			 	}
	 
	 	    }, messages: {
	 	    	addUser_id:{
					required:"아이디를 입력해주세요"
	 	 		    },
	 	 		// 유저 이메일 
				    addUser_passwd:{
						required:"비밀번호를 입력해주세요"
		 	 	    },
		 	 	  // 유저 이름 
				    addUser_nm:{
						required:"이름을 입력해주세요"
		 	 	    }, 
		 	 			    
	 	   		// 유저 이메일
				addUser_email: {
					email : "이메일 형식을 확인해주세요",
					required:"이메일을 입력해주세요"
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

	    		 var user_nm = $("#addUser_nm").val();
	    		 var user_dept = $("#addUser_dept").val();
	    		 var user_rank = $("#addUser_rank").val();
	    		 var user_email = $("#addUser_email").val();
	    		 var user_id = $("#addUser_id").val();
	    		 var user_passwd1 = $("#addUser_passwd").val();
	    		 
	     		 if(userIDCk == 1){ 
	         		if(user_id == "" | user_passwd1 == "" | user_nm == "" | user_email == ""){
	             		
	         			alert("필수 값들을 입력해주세요");
	             		} else{ 
	                 		alert("아이디 중복체크를 해주세요");
	             		}
					} else {

						
						if(confirm("저장하시겠습니까?")==true){	

			        		 $.ajax({
		          				 data : {user_id , user_passwd1, user_nm, user_dept, user_rank, user_email},
		                   	 	url : "/signup/addSubUserProc.proc",
		                   	 	dataType : "json",
		                    	contentType: "application/json; charset=UTF-8",
		                    	success : function(result) {
				         			alert(result.msg);   	
		     	          			location.reload();    	          		   	     	          			
		     	                }
		         			  });
							}     
						}
	

			 	   }
		
	 });



	$('#edit_frm').validate({
		  rules: {
           // 유저 아이 
			    addUser_id2:{
					required:true
	 	 	    },
	 		   // 유저 이름 
			    addUser_nm2:{
					required:true
	 	 	    }, 
	 	 		  addUser_email2:{
					email:true,
					required:true
			 	}
	 
	 	    }, messages: {
	 	    	addUser_id2:{
					required:"아이디를 입력해주세요"
	 	 		    },
		 	 	  // 유저 이름 
				    addUser_nm2:{
						required:"이름을 입력해주세요"
		 	 	    }, 
		 	 			    
	 	   		// 유저 이메일
				addUser_email2: {
					email : "이메일 형식을 확인해주세요",
					required:"이메일을 입력해주세요"
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

			if(confirm("수정하시겠습니까?")==true){
					
					var user_nmField = document.createElement("input");
					user_nmField.setAttribute("type", "hidden");
					user_nmField.setAttribute("name", "user_nm");
					user_nmField.setAttribute("value", $("#addUser_nm2").val());
			        document.userMngrFrm.appendChild(user_nmField);
			        
			        var user_deptField = document.createElement("input");
			        user_deptField.setAttribute("type", "hidden");
					user_deptField.setAttribute("name", "user_dept");
					user_deptField.setAttribute("value", $("#addUser_dept2").val());
			        document.userMngrFrm.appendChild(user_deptField);
			        
			        var user_rankField = document.createElement("input");
			        user_rankField.setAttribute("type", "hidden");
					user_rankField.setAttribute("name", "user_rank");
					user_rankField.setAttribute("value", $("#addUser_rank2").val());
			        document.userMngrFrm.appendChild(user_rankField);
			        
			        var user_emailField = document.createElement("input");
			        user_emailField.setAttribute("type", "hidden");
					user_emailField.setAttribute("name", "user_email");
					user_emailField.setAttribute("value", $("#addUser_email2").val());
			        document.userMngrFrm.appendChild(user_emailField);
			        
			        var user_idField = document.createElement("input");
			        user_idField.setAttribute("type", "hidden");
					user_idField.setAttribute("name", "user_id");
					user_idField.setAttribute("value", $("#addUser_id2").val());
			        document.userMngrFrm.appendChild(user_idField);
			        
			        var user_passwdField = document.createElement("input");
			        user_passwdField.setAttribute("type", "hidden");
					user_passwdField.setAttribute("name", "user_passwd");
					user_passwdField.setAttribute("value", $("#addUser_passwd2").val());
			        document.userMngrFrm.appendChild(user_passwdField);
			         

					document.userMngrFrm.action = "updateAddUserInfo.proc";
					document.userMngrFrm.submit();
	        	
				}
		     }
		
	 });

	 
 });

	

 /* 팝업 관련 함수 정의 부 */

 //담당자 정보 수정 레이어팝업 설정 함수
 function ViewEditLayer(id, name, dept, rank, email){
	console.log(id);
	document.getElementById("addUser_id2").value=id;
	document.getElementById("addUser_nm2").value=name;
	document.getElementById("addUser_dept2").value=dept;
	document.getElementById("addUser_rank2").value=rank;
	document.getElementById("addUser_email2").value=email;

	document.getElementById("editPop").style.display='block';

	var isDim = $('#editPop').prev().hasClass('dimBg');

    isDim ? $('#editPop').parent('.dim-layer').fadeIn() : $('#editPop').fadeIn();
  }

 	//담당자 정보 추가 팝업 닫기 함수   
	function close_edit_pop(){
 		document.getElementById("editPop").style.display='none';

 		var isDim = $('#editPop').prev().hasClass('dimBg');
 		isDim ? $('.dim-layer').fadeOut() : $('#editPop').fadeOut();
	}
 
   	 //유저 아이디 체크하기
   	var userIDCk = 1;
	function fn_addUserIDCheck(){
    	var user_id = $("#addUser_id").val();

    	if(user_id == "undefinded" || user_id == "" || user_id == null || user_id == " " ){
				alert("아이디를 입력해주세요");		
			} else{
			    	$.ajax({
		    		data : {user_id},
		        	url : "/signup/addUserIDCheck.proc",
		        	dataType : "json",
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
			            if (data.cnt ==1) {
			            	alert(user_id + "는 이미 존재합니다. 다른 아이디를 입력해주세요.");
			                userIDCk = 1;
			                $("#addUser_id").val("");
			                $("#addUser_passwd").val("");
						} else if(data.cnt == 0){
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
						alert("ERORR : " + error);
					}
				});
			}
	} 
               	 
   		 // 추가 관리자 입력정보 DB로 저장
 /*    	function saveAddUserConfirm(){

    		 var user_nm = $("#addUser_nm").val();
    		 var user_dept = $("#addUser_dept").val();
    		 var user_rank = $("#addUser_rank").val();
    		 var user_email = $("#addUser_email").val();
    		 var user_id = $("#addUser_id").val();
    		 var user_passwd1 = $("#addUser_passwd").val();
    		 
     		 if(userIDCk == 1){ 
         		if(user_id == "" | user_passwd1 == "" | user_nm == "" | user_email == ""){
             		
         			alert("필수 값들을 입력해주세요");
             		} else{ 
                 		alert("아이디 중복체크를 해주세요");
             		}
				} else {

					
					if(confirm("저장하시겠습니까?")==true){	

		        		 $.ajax({
	          				 data : {user_id , user_passwd1, user_nm, user_dept, user_rank, user_email},
	                   	 	url : "/signup/addSubUserProc.proc",
	                   	 	dataType : "json",
	                    	contentType: "application/json; charset=UTF-8",
	                    	success : function(result) {
			         			alert(result.msg);   	
	     	          			location.reload();    	          		   	     	          			
	     	                }
	         			  });
						}     
					}
	    		} 
 */
		//추가 담당자 정보 업데이트 함수
/*     	function updateAddUserInfo(){

		 				
				if(confirm("수정하시겠습니까?")==true){
					
					var user_nmField = document.createElement("input");
					user_nmField.setAttribute("type", "hidden");
					user_nmField.setAttribute("name", "user_nm");
					user_nmField.setAttribute("value", $("#addUser_nm2").val());
			        document.userMngrFrm.appendChild(user_nmField);
			        
			        var user_deptField = document.createElement("input");
			        user_deptField.setAttribute("type", "hidden");
					user_deptField.setAttribute("name", "user_dept");
					user_deptField.setAttribute("value", $("#addUser_dept2").val());
			        document.userMngrFrm.appendChild(user_deptField);
			        
			        var user_rankField = document.createElement("input");
			        user_rankField.setAttribute("type", "hidden");
					user_rankField.setAttribute("name", "user_rank");
					user_rankField.setAttribute("value", $("#addUser_rank2").val());
			        document.userMngrFrm.appendChild(user_rankField);
			        
			        var user_emailField = document.createElement("input");
			        user_emailField.setAttribute("type", "hidden");
					user_emailField.setAttribute("name", "user_email");
					user_emailField.setAttribute("value", $("#addUser_email2").val());
			        document.userMngrFrm.appendChild(user_emailField);
			        
			        var user_idField = document.createElement("input");
			        user_idField.setAttribute("type", "hidden");
					user_idField.setAttribute("name", "user_id");
					user_idField.setAttribute("value", $("#addUser_id2").val());
			        document.userMngrFrm.appendChild(user_idField);
			        
			        var user_passwdField = document.createElement("input");
			        user_passwdField.setAttribute("type", "hidden");
					user_passwdField.setAttribute("name", "user_passwd");
					user_passwdField.setAttribute("value", $("#addUser_passwd2").val());
			        document.userMngrFrm.appendChild(user_passwdField);
			         

					document.userMngrFrm.action = "updateAddUserInfo.proc";
					document.userMngrFrm.submit();
					
	        	
				}  
			}  */

    	function deleteAddUserInfo(){
    		var user_id = $("#addUser_id2").val();

 		    if(confirm("삭제하시겠습니까?")==true){
 		    	  var delField = document.createElement("input");
 		    	 	delField.setAttribute("type", "hidden");
 		    		delField.setAttribute("name", "user_id");
 		    		delField.setAttribute("value", $("#addUser_id2").val());
			        document.userMngrFrm.appendChild(delField);

					document.userMngrFrm.action = "deleteAddUserInfo.proc";
					document.userMngrFrm.submit();
					
	       	}  
    	}

		// 활성여부 체크 함수 A -> IA / IA -> A 상태로 변화할때 DB 업데이트   
		function active_chk(id, status){
			if(confirm("활성 여부를 변경하시겠습니까?") == true){
      			 $.ajax({
	       		data : {"user_id" : id , "active_status" : status},
           	 	url : "/signup/updateUserActiveStatus.proc",
           		contentType: "application/json; charset=UTF-8",
            	 	success :function(result){
						console.log(result);
            	 		if(result == 1){
            	 			alert( id + "의 상태가 변경되었습니다!");
            	 			location.reload();
					} else{
						alert("변경 실패!!");
        	 			location.reload();						
						}
           	 		}
	           	});
			}
		}

		// 추가 담당자 중복아이디 체크
		let blurChild = document.querySelector("#addUser_id");
		blurChild.addEventListener("focusout", e => {
			if( $("#addUser_id").val().length != 0){
				fn_addUserIDCheck();
			}
		}); 

		function ViewLayer(){
			layer_popup("#layer2");	
			$("#addUser_id").val("");
		    $("#addUser_passwd").val("");
		}
		
	    function layer_popup(el){

	        var $el = $(el);        //레이어의 id를 $el 변수에 저장
	        var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

	        isDim ? $el.parent('.dim-layer').fadeIn() : $el.fadeIn();

	        var $elWidth = ~~($el.outerWidth()),
	            $elHeight = ~~($el.outerHeight()),
	            docWidth = $(document).width(),
	            docHeight = $(document).height();

	        // 화면의 중앙에 레이어를 띄운다.
	        if ($elHeight < docHeight || $elWidth < docWidth) {
	            $el.css({
	                marginTop: -$elHeight /2,
	                marginLeft: -$elWidth/2
	            })
	        } else {
	            $el.css({top: 0, left: 0});
	        }

	        $el.find('button.btn-layerClose').click(function(){
	            isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
	            return false;
	        });

	        $('.layer .dimBg').click(function(){
	            $('.dim-layer').fadeOut();
	            return false;
	        });

	    }
</script>

<form name="userMngrFrm" id="userMngrFrm" method="POST"  autocomplete="off">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>