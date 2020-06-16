<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

<style type="text/css">

input.none {border:none;}
input.zero {border:0;}
.inputs{

    width: 100%;
    height: 34px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 10px;
}

</style>

<body>
<!--content 입력 부분  -->
	<div>
		관리자 홈 > 회원정보관리 > 담당자 정보 관리
	</div>
   <div>
		<h3>&nbsp;&nbsp;◈&nbsp;회원정보 수정</h3>
		<form name="frm" id="frm" action="/signup/subUserEditForm.proc" method="POST">
		<input type="hidden" name="user_id" id="user_id" value="${userResult.user_id}"/>
		  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <figure>
                        <figcaption>
                            <p>◆ 기업정보</p>
                    </figure>
                    <table border="1" width="99%">
                        <colgroup>
                            <col style="background: #eee;">
                        </colgroup>
                            <tr>                            
                                <th>업체명(한글) *</th>
                                <td><input type="text" id="biznm" name="biznm" value = "${bizResult.biznm}" style="width: 100%;" class = "none" readonly></td>
                                <th>업체명(영문) *</th>
                                <td width="50%"><input type="text" id="biznm_en" name ="biznm_en" value = "${bizResult.biznm_en}" style= "width: 100%;" class = "none" readonly></td>
                            </tr>
                            <tr>
                                <th>업종</th>
                                <td><input type="text" id="biztype" name = "biztype" value = "${bizResult.biztype}" class="none" style="width: 100%;" readonly></td>
                                <th>업태</th>
                                <td><input type="text" id="bizkind" name ="bizkind" value = "${bizResult.bizkind}" class="none" style="width: 100%;" readonly></td>
                            </tr>
                            <tr>
                                <th>사업자번호 *</th>
                                <td>
                                    <input type="text" id="bizno" name = "bizno" value = "${bizResult.bizno}" class="none" style="width:100%;" readonly>
                                </td>
                                <th>사업자구분</th>
                                    <td>                                 
                                        <label class="reg" for="biz_auth_role_select">
                                            <select id ="biz_auth_role" name ="selected_biz_auth_role">
                                                <option value='1' disabled<c:if test="${bizResult.biz_auth_role eq '1' }"> selected </c:if>>총판사</option>
                                                <option value='2' disabled<c:if test="${bizResult.biz_auth_role eq '2' }"> selected </c:if>>파트너사</option>
                                                <option value='3' disabled<c:if test="${bizResult.biz_auth_role eq '3' }"> selected </c:if>>일반</option>
                                            </select>
                                        </label>
                                    </td>
                            </tr>
                            <tr>
                                <th>대표자명</th>
                                <td><input type="text" id="rprsnt_nm" name="rprsnt_nm" value="${bizResult.rprsnt_nm}" class="none" style="width: 100%;" readonly></td>
                                <th></th>
                                <td></td>
                            </tr>
                            <tr>
                                <th>주소</th>
                                    <td>
                                        <input type="text" id="addr1" name="addr1" value="${bizResult.addr1}" class="none" style="width: 100%;" readonly>
                                    </td>

                                <th>상세주소</th>
                                    <td>
                                        <input type="text" id="addr2" name="addr2" value="${bizResult.addr2}" class="none" style="width: 100%;" readonly>
                                    </td>
                            </tr>
                            <tr>
                                <th>전화번호</th>
                                <td>
									    <input type="text" id="tele1" name="tele1" value="${bizResult.tele1}" style="width: 10%;" class="none" readonly> -
                                    <input type="text" id="tele2" name="tele2" value="${bizResult.tele2}" style="width: 20%;" class="none" readonly> -
                                    <input type="text" id="tele3" name="tele3" value="${bizResult.tele3}" style="width: 20%;" class="none" readonly>	 
                                </td> 
                                <th>팩스</th>
                                <td>
                                    <input type="text" id="fax1" name="fax1" value="${bizResult.fax1}" style="width: 10%;" class="none" readonly>  - 
                                    <input type="text" id="fax2" name="fax2" value="${bizResult.fax2}" style="width: 20%;" class="none" readonly>  -
                                    <input type="text" id="fax3" name="fax3" value="${bizResult.fax3}" style="width: 20%;" class="none" readonly>
                                </td>
                            </tr>
                    </table>
					<!-- 담당자 정보 수정 부분 -->
                   <figure>
                        <figcaption>
                            <br>
                            <p>◆ 회원 정보 수정</p>
                        </figcaption>
                    </figure>
                        <table border="1" width="99%">
                            <colgroup>
                                <col style="background: #eee;">
                            </colgroup>
                            <tr>
                                <th>담당자명 </th>
                                    <td><input type="text" id="user_nm" name ="user_nm" value="${userResult.user_nm}" style="width: 100%;" maxlength="20"></td>
                                 <th>부서</th>
                                    <td  width="50%"><input type="text" id="user_dept" name="user_dept" value="${userResult.user_dept}" style="width: 100%;" maxlength="20"></td>
                            </tr>
                            <tr>
                                <th>핸드폰 번호 </th>
                                    <td>
                                    	<input type="tel" id="user_hp1" name="user_hp1" value="${userResult.user_hp1}" maxlength = "3" class="inputs numberOnly" style="width: 25%;"> - 
                                   	<input type="tel" id="user_hp2" name="user_hp2" value="${userResult.user_hp2}" maxlength = "4" class="inputs numberOnly" style="width: 30%;"> -
                                   	<input type="tel" id="user_hp3" name="user_hp3" value="${userResult.user_hp3}" maxlength = "4" class="inputs numberOnly" style="width: 30%;">
                                   </td>
                                <th>직급 </th>                               
                                    <td><input type="text" id="user_rank" name="user_rank"  value="${userResult.user_rank}"  maxlength="20" style="width: 100%;"></td>
                            </tr>
                        			<tr>	
                        			<th>아이디 </th>
										<td><input type="text"  class="none" readonly value="${userResult.user_id}" style="width: 100%;"  maxlength="30"></td>
										<th>E-mail </th>
                                    <td><div class="form-group row">
                                    <input type="text" id="user_email" name="user_email"  value="${userResult.user_email}" style="width: 100%;"  maxlength="30"></div></td>
									</tr>
								<tr>		
										<th>비밀번호</th>
											<td><input type="password" id="user_passwd" name="user_passwd" style="width: 100%;" maxlength="20">
<!-- 												<div class="error invalid-feedback" id="alert-danger" style="text-align: center">비밀번호가 일치하지 않습니다.</div>	
 -->											</td>
											<td></td><td></td>
											
								</tr> 						
                       </table>
                    <div align="right">
                    		<br>
                        <input type="button" class="btn btn-info" value="저장"  onclick="updateAddUserInfo()">
<!--                         <input type="button" class="btn btn-info" value="취소"  onclick="cancelEditConfirm()" >
 -->                    </div>
	    </form>
	</div>
</body>

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript">       

 $(document).ready(function() { 
/* 		
		const chkProcVal = $("#procVal").val();

		if(chkProcVal == 'S' ){
			alert("정보수정이 완료되었습니다.");
		}else if( chkProcVal == 'F' ){
			alert("정보수정중 오류가 발생했습니다. 다시 시도후 같은 오류가 발생할 경우 관리자에게 문의바랍니다..");
		}
 */


   	    $(".inputs").keyup (function () {required
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

    	 	$.validator.setDefaults({
    	 	    submitHandler: function () {
    	 	    	updateAddUserInfo();
    	 	    }
    	 	  });

    		$("#alert-success").hide(); 
     	 	$("#alert-danger").hide(); 
     	 	$("#user_passwd").keyup(function(){ 

     	 	 		if(user_passwd1 != "" || user_passwd != ""){
     	 	 	 		 if(user_passwd1 == user_passwd){ 
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
					// 유저 이메일
   	    		   user_email:{
   						email:true
   	 	 	 		    }
   	 	 	   }, message:{

   	 	 			//유저 이메일
 					user_email: {
 						email : "이메일 형식을 확인해주세요"
 						},
  					//유저 비밀번호1
  					user_passwd1: {
  						required : "비밀번호를 입력해주세요"
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


 //추가 담당자 정보 업데이트 함수
   	function updateAddUserInfo(){
   		alert("회원정보를 변경하시겠습니까?")
		document.frm.action = "/signup/subUserEditForm.proc";
		document.frm.submit();
	} 


    	   
</script>