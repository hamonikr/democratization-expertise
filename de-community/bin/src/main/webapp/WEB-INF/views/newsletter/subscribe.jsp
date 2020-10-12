<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>구독하기</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- jquery-validation -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="/plugins/jquery-validation/additional-methods.min.js"></script>
  <script src="/plugins/jquery-validation/jquery.validate.min.js"></script> 

 
</head>
<style>
.card{
    background: #fff;
    border-top: 0;
    color: #666;
    padding: 20px
}


.algin-center{
	margin : 10% 10% 10% 10%;
}

strong{
	margin-left:5%;
	font-weight:20px;
	font-weight:bold;
}
</style>

<body>
<!-- contents -->
<div class="hold-transition login-page">
<!-- 입력 박스 -->
<div class="col-3">
<div class="card">
 <div class="login-card-body" >
  <form id ="frm" name="frm" method="post">      
	<div class="row">
     <div class="col-4">
     </div>
     	<h4 style="margin-left:25px;">
     		<p>  DE COMMUNITY 뉴스레터 구독하기</p>
     	</h4>
     	<h6 style="margin-left:25px;">
		 읽어볼만한 소식을 보내드립니다. 주변에 관심있는 사람들에게 이 뉴스레터를 공유해주세요!
		</h6>
     </div>
	<br>
	<!-- 이메일 -->  
     <div class="row">
     <div class="col-8">
     	<h6><strong>Email 주소</strong></h6>
     </div>
     	<div class="form-group col-12"> 	    
		      	<input type="email" class="form-control englishOnly" id="email" name="email" value="bono6315@gmail.com" style="margin-left: 10px" placeholder="이메일을 입력해주세요">             	
		   </div>
        </div>
       <br>
     
	<!-- 이름 -->  
     <div class="row">
     <div class="col-8">
     	<h6><strong>이름</strong></h6>
     </div>
     	<div class="form-group col-12"> 	    
		      	<input type="text" class="form-control" id="name" name="name" value="이영은" style="margin-left: 10px" placeholder="이름을 입력해주세요">             	
		   </div>
        </div>
		<br><br>
        <!-- button -->
		  <div class="row">
       	 <div class="col">
       		  <input type="submit" value="구독하기" class="btn btn-primary btn-block blue">
			</div>	
		  </div><br><br>
        
      </form>
    </div>
  </div>
  </div>
 </div>

<!-- /.login-box -->
</body>

<!-- 스크립트 함수 정의 부분 -->

 <script type="text/javascript"> 

 $(document).ready(function() {
	 
		// 영문, 숫자, 공백, 특수문자
		$(".englishOnly").on("keyup", function() {
		    $(this).val($(this).val().replace(/[^a-zA-Z\s|^0-9|^~!@#$%^&*()_+|<>?:{}(.),]+$/gi,""));
		});	
	 
	 $('#frm').validate({
		 rules: {
		 	 
		 	 email:{ required: true, email: true },
		 	 name:{ required: true }
		    		  }, 
		  messages:{
		 								
			  email: {
		 			required : "이메일은 필수값 입니다.",
		 			email : "이메일 형식을 확인해주세요"
		 			},
 			  name: {
		 			required : "이름을 입력해주세요."
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