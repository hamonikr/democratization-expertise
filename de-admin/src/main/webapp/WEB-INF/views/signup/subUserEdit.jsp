<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>

<body>
<form name="frm" id="frm" action="/signup/subUserEditForm.proc" method="POST" autocomplete="off">
	<input type="hidden" name="user_id" id="user_id" value="${userResult.user_id}"/>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

	<div class="row" id="content">
		<div id="input_div" class="col-12 " style="margin-top: .75rem;">
			<div class="callout callout-info row ">
				<div class="col-6">
					<h5>회원 정보 관리</h5>
				</div>
				<div class="col-6">
					<span class="float-right  "><a href="/main/index">Home</a> / 회원정보관리 / 회원 정보 관리</span>
				</div>
			</div>
		</div>


		<div id="input_div" class="col-12">
			<div class="card">
				
				<div class="row mb-2">
					<div class="col-sm-12">
						<h5>기업정보</h5>
					</div>
				</div>

				<div class="card-body row">
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="biznm" class="col-form-label">
								업체명(한글) <span class="important">*</span>
							</label>
							<input type="text" placeholder="업체명(한글)" class="form-control" id="biznm" name="biznm" value="${bizResult.biznm}" readonly>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="biznm_en" class="col-form-label">
								업체명(영문) <span class="important">*</span>
							</label>
							<input type="text" placeholder="업체명(영문)" class="form-control" id="biznm_en" name="biznm_en" value="${bizResult.biznm_en}" readonly>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="bizno" class="col-form-label">
								사업자번호 <span class="important">*</span>
							</label>
							<input type="text" placeholder="사업자번호" class="form-control" id="bizno" name="bizno" value="${bizResult.bizno}" readonly>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="biztype" class="col-form-label">업종</label>
							<input type="text" placeholder="업종" class="form-control" id="biztype" name="biztype" value="${bizResult.biztype}" maxlength="50" readonly>
						</div>
					</div>

					<div class="col-lg-4">
						<div class="form-group">
							<label for="bizkind" class="col-form-label">업태</label>
							<input type="text" placeholder="업태" class="form-control" id="bizkind" name="bizkind" value="${bizResult.bizkind}" maxlength="50" readonly>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="selected_biz_auth_role" class="col-form-label">사업자구분</label>
							<select id="biz_auth_role" name="selected_biz_auth_role" class="form-control" readonly>
								<option value='1' disabled <c:if test="${bizResult.biz_auth_role eq '1' }"> selected </c:if>>총판사</option>
								<option value='2' disabled <c:if test="${bizResult.biz_auth_role eq '2' }"> selected </c:if>>파트너사</option>
								<option value='3' disabled <c:if test="${bizResult.biz_auth_role eq '3' }"> selected </c:if>>일반</option>
							</select>
						</div>
					</div>

					<div class="col-lg-4">
						<div class="form-group">
							<label for="rprsnt_nm" class="col-form-label">대표자명</label>
							<input type="text" placeholder="대표자명" class="form-control" id="rprsnt_nm" name="rprsnt_nm" value="${bizResult.rprsnt_nm}" maxlength="30" readonly>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="tele1" class="col-form-label">전화번호</label>
							<div class="tel_div row">
								<input type="tel" class="form-control filter col-lg-3 inputs" placeholder="000" id="tele1" name="tele1" value="${bizResult.tele1}" maxlength=3 readonly>
								<span class="col-lg-1" > - </span> 
								<input type="tel" class="form-control filter col-lg-3_5 inputs" placeholder="0000" id="tele2" name="tele2" value="${bizResult.tele2}" maxlength=4 readonly>
								<span class="col-lg-1"> - </span> 
								<input type="tel" class="form-control filter col-lg-3_5" placeholder="0000" id="tele3" name="tele3" value="${bizResult.tele3}" maxlength=4 readonly>
							</div>
						</div>
					</div>
					
					<div class="col-lg-4">
						<div class="form-group">
							<label for="fax1" class="col-form-label">팩스</label>
							<div class="tel_div row">
								<input type="tel" class="form-control filter col-lg-3 inputs" placeholder="000"  id="fax1" name="fax1" value="${bizResult.fax1}" maxlength=3 readonly>
								<span class="col-lg-1"> - </span> 
								<input type="tel" class="form-control filter col-lg-3_5 inputs" placeholder="0000" id="fax2" name="fax2" value="${bizResult.fax2}" maxlength=4 readonly>
								<span class="col-lg-1"> - </span> 
								<input type="tel" class="form-control filter col-lg-3_5 inputs" placeholder="0000" id="fax3" name="fax3" value="${bizResult.fax3}" maxlength=4 readonly>
							</div>
						</div>
					</div>
					
					<div class="col-lg-6">
						<div class="form-group">
							<label for="addr1" class="col-form-label">주소</label>
							<input type="text" placeholder="주소" class="form-control" id="addr1" name="addr1" value="${bizResult.addr1}" maxlength="80" readonly>
						</div>
					</div>

					<div class="col-lg-6">
						<div class="form-group">
							<label for="addr2" class="col-form-label">상세주소</label>
							<input type="text" placeholder="상세주소" class="form-control" id="addr2" name="addr2" value="${bizResult.addr2}" maxlength="30" readonly>
						</div>
					</div>
				</div>
				
			</div>
		</div>


		<!-- 담당자 정보 -->
		<div id="input_div" class="col-12">
			<div class="card">
				
				<div class="row mb-2">
					<div class="col-sm-12">
						<h5>대표 담당자 정보</h5>
					</div>
				</div>
			
				<div class="card-body row">
					
					<div class="col-lg-12">
						<div class="form-group">
							<label for="none">아이디</label>
							<input type="text"  class="form-control" value="${userResult.user_id}" maxlength="30" readonly>
						</div>
					</div>
				
					<div class="col-lg-6">
						<div class="form-group">
							<label for="user_nm">담당자</label>
							<input type="text" class="form-control" placeholder="담당자" id="user_nm" name="user_nm" value="${userResult.user_nm}" maxlength="20">
						</div>
					</div>
					
					<div class="col-lg-6">
						<div class="form-group">
							<label for="user_dept">부서</label>
							<input type="text" class="form-control" placeholder="부서" id="user_dept" name="user_dept" value="${userResult.user_dept}" maxlength="20">
						</div>
					</div>
					
					<div class="col-lg-6">
						<div class="form-group">
							<label for="user_hp1">연락처</label>
							<div class="tel_div row">
								<input type="tel" class="inputs form-control filter col-lg-3 numberOnly" id="user_hp1" name="user_hp1" value="${userResult.user_hp1}" maxlength=3 placeholder="000">
								<span class="col-lg-1"> - </span> 
								<input type="tel" class="inputs form-control filter col-lg-3_5 numberOnly" id="user_hp2" name="user_hp2" value="${userResult.user_hp2}" maxlength=4  placeholder="0000">
								<span class="col-lg-1"> - </span> 
								<input type="tel" class="inputs form-control filter col-lg-3_5 numberOnly" id="user_hp3" name="user_hp3" value="${userResult.user_hp3}" maxlength=4 placeholder="0000">
							</div>
						</div>
					</div>
					
					<div class="col-lg-6">
						<div class="form-group">
							<label for="user_rank">직급</label>
							<input type="text" class="form-control" placeholder="직급" id="user_rank" name="user_rank" value="${userResult.user_rank}" maxlength="20">
						</div>
					</div>
					
					<div class="col-lg-6">
						<div class="form-group">
							<label for="user_email">메일</label>
							<input type="email" class="form-control" id="user_email" name="user_email" value="${userResult.user_email}" maxlength="30" placeholder="메일">
						</div>
					</div>

					<div class="col-lg-6">
						<div class="form-group">
							<label for="user_passwd">비밀번호</label>
							<input type="password" class="form-control" placeholder="비밀번호" id="user_passwd" name="user_passwd"  maxlength="20">
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

	</div>
</form>

</body>

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript">       
 $(document).ready(function() { 
		//inputs 
	    $(".inputs").keyup (function () {
   	        var charLimit = $(this).attr("maxlength");
   	        if (this.value.length >= charLimit) {
   	            $(this).next('.inputs').focus();
   	            return false;
   	        }
   	    });

       	//숫자만 입력받도록 
       	$(".numberOnly").on("keyup", function() {
       	    $(this).val($(this).val().replace(/[^0-9]/g,""));
       	});

    	 	var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//이메일 정규식
  	 
	   		$("#alert-success").hide(); 
     	 	$("#alert-danger").hide(); 
     	 	$("#user_email").keyup(function(){ 
 	 	 		 if((!emailRule.test($("#user_email").val()))){ 
 	 	 	 		 $("#alert-success").show();
 	 	 	 		 $("#alert-danger").hide(); 
 	 	 	 	 }else{
 	 	 	 	 	  $("#alert-success").hide(); 
 	 	 	 	 	  $("#alert-danger").show(); 
 	 	 	 	 	  } 	   
				});
     	 	
   	 	$('#frm').validate({
   	 	 	   rules: {
					// 연락처
					user_hp1:{
						required: true
							},
					user_hp2:{
	   					required : true
							},
					user_hp3:{
	   					required : true
							},  	   	 	 	   		
   					// 업체명(영문)
   					biznm_en: {
   						required : true
   						},
   	 	 		   //유저 아이디
   					user_id: {
   						required : true
   						},
					// 유저 이메일
   	    		   user_email:{
   	    				required : true,
   						email:true
   	 	 	 		    }
   	 	 	   }, message:{
					// 연락처
					user_hp1:{
 						required : "연락 가능한 번호를 입력해주세요."
							},
					user_hp2:{
 						required : ""
							},
					user_hp3:{
 						required : ""
							},
   	 	 		   //유저 이메일
 					user_email: {
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
      		    }
 		   	}); 

 	 	$.validator.setDefaults({
 	 	    submitHandler: function () {
 	 	    	updateAddUserInfo();
 	 	    }
 	 	  }); 
       });
 

 //추가 담당자 정보 업데이트 함수
   	function updateAddUserInfo(){
   		if(confirm("회원정보를 변경하시겠습니까?")){
			document.frm.action = "/signup/subUserEditForm.proc";
			document.frm.submit();
   		}
	} 
</script>