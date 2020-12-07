<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <!-- jquery-validation -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 

 



<div class="content-center">
<!-- 	<h2>뉴스레터</h2> -->
	<div class="con-box">
  <form id ="frm" name="frm" method="post">   
		<div class="news">
                <font class="title">ASKOS 뉴스레터 구독하기</font>
                <p>ASKOS 커뮤니티에서는 읽어볼만한 소식을 보내드립니다.<br>
                  주변에 관심있는 사람들에게 이 뉴스레터를 공유해주세요!
                  </p>

                <ul class="news-in">
                  <li><label>이름</label><div class="form-group"><input type="text" id="name" name="name"  class="input-type1 " placeholder="이름을 입력해주세요"></div></li>
                  <li><label>E-mail 주소</label><div class="form-group"><input type="text" id="email" name="email"  placeholder="이메일을 입력해주세요" class="input-type1 englishOnly"></div></li>
<!--                   <li> <input type="submit" value="구독하기" class="btn btn-primary btn-block blue"></li> -->
                  <li><button type="submit" class="btn-blue">구독 신청하기</button></li>
                </ul>
              </div>
              </form>
	</div>
</div>













<!-- /.login-box -->

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 

 $(document).ready(function() {
	 
		// 영문, 숫자, 공백, 특수문자
// 		$(".englishOnly").on("keyup", function() {
// 		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
// 		});	
		
	 //공백체크
    $.validator.addMethod("trimCheck",  function( value, element ) {
		   return this.optional(element) ||  $.trim(value);
		});
	 $('#frm').validate({
		 rules: {
		 	 
		 	 email:{ required: true, email: true,trimCheck: true },
		 	 name:{ required: true ,trimCheck: true}
		    		  }, 
		  messages:{
		 								
			  email: {
		 			required : "이메일은 필수값 입니다.",
		 			email : "이메일 형식을 확인해주세요",
		 			trimCheck : "공백만 입력 할 수 없습니다."
		 			},
 			  name: {
		 			required : "이름을 입력해주세요.",
		 			trimCheck : "공백만 입력 할 수 없습니다."
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
		 	//	saveSubscriber();
		 		var email = $("#email").val();
		 		var name = $("#name").val();
								 		
		 		 $.ajax({
		 	          url: '/newsletters/subscribe.proc',
		 	          type: 'post',
		 	          data: {'email':email, 'name' :name},
		 	          success: function(chkDup) {
		 	        	  if(chkDup >= 1){
		 	        			alert("이미 뉴스레터 구독신청을 한 이메일입니다."+ chkDup);		
		 	        			} else {
		 	        				alert("구독신청이 완료되었습니다."+ chkDup);	
		 	        				location.reload(true);		 	    					
		 	            			}
		 	              	}
		 	      }); 

			       }
		 });

 });
 
function saveSubscriber(){
/* 		document.frm.action = "/newsletters/subscribe.proc";
		document.frm.submit(); */
	

} 

</script>