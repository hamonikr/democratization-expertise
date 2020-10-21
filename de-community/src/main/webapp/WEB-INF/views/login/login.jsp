<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>


<link rel="stylesheet" href="/dist/css/adminlte.min.css">



	<section class="content" style="padding: 2px 12px 6px 19px;">

			<div class="container-fluid">

			<div class="col-8" style="margin-top:20%;">
				<div class="row">
					<div class="col-5"></div>
					
					<div class="card card-outline card-primary col-7">
						<div class="login-card-body">
						   		<div class="login-logo">
							  	<font class="" style="height:56px; cursor: pointer;" onclick="javascript:location.href='/';">
							      <img src="/img/HamoniKR_logo600.png"
							           alt="AdminLTE Logo"
							           class="brand-image img-circle elevation-3"
							           style="opacity: .8"
							           width="50px;">
							     <a href="/"><b>DE</b> COMMUNITY</a>
							    </font>
							  </div>
						   
						   <form id="frm" name="frm" method="post" autocomplete="off" style="width:95%;">
						  		<input type ="hidden" th:name="${_csrf.parameterName}" th:value="${_csrf.token}"/> 
								<div class="row"><div class="input-group mb-3"><div class="col-8"></div></div></div>
								<div class="row"><div class="input-group mb-3"></div></div>
						     	
						     	<div class=" form-group col-8" style="margin-bottom:10px;"><span> 아이디 </span></div>
						      <div class="form-group col-12"> 	    
								  	<input type="text" class="form-control" id="username" name="username" value="jullee" placeholder="아이디를 입력해주세요" maxlength="20">             	
								</div>
						      <br>
						       
						      <div class="row">
						       	<div class="form-group col-4"><span>비밀번호</span></div>
						         <div class="form-group col-8"><a class="float-right" href="/accountRecovery/sendRecoveryEmail">비밀번호를 잊으셨습니까?</a></div>
								</div>
						      <div class="form-group col-12">
						      		<input type="password" class="form-control" id="password" name="password"  value="lee1234" placeholder="비밀번호를 입력해주세요" maxlength="20">
						      </div>
						      
						      <br>
								
								<!-- 로그인 버튼  -->
						         <div class="row-8" style="margin-left:10px;">
						            <button type="submit" name = "submit" class="col-12 btn btn-primary btn-block">로그인</button>
						          </div>
						      </form>
						      
						      
						      <div class="social-auth-links text-center mb-3" style="margin:60px;">
						      <br> <p>- SNS 계정으로 로그인 -</p>
						        <div class="row" align="center" >
						        
						        <!-- 깃헙 -->
						          <div class="col-2">
							         <a href="/login/github" class="btn_social" data-social="github">  
										<img src="/img/logo.png" style="height:30px;margin-left:0px;">
								      </a>
							       </div>
							       
							       <!-- 구글 -->
								<div class="col-2" style="margin-left:20px;">     	           
								 	<!-- <a href="javascript:;" class="g-signin2 btn_social" data-width="32" data-height="32" data-social="google"></a> --> 
								 	<a href="/login/google" class="btn_social"> <img src="/img/google-plus.png" style="height:30px;"></a>
						 	    </div>
						
							        <!-- 네이버 -->
							        <!-- <div class="col-2" style="margin-left:20px;">	        	
							       	<a href="javascript:;" class="btn_social" data-social="naver">
											<img src="/img/naver_login.png" style="height:30px;">
										</a>		
							        </div>
							        
							        카카오
							        <div class="col-2" style="margin-left:20px;">
								      <a href="javascript:;" class="btn_social" data-social="kakao">
										<img src="/img/kakaolink_btn_medium_ov.png" style="height:30px;">	
										</a>
							        </div> -->
						      	</div>
						    </div>
						      <!-- /.social-auth-links -->
						
								<!-- sign up part -->
								<div class="row" align="center">
							      <p class="col">계정이 없으십니까?
							        <a href="/signup/signup" class="text-center">회원가입</a>
							  	  </p>
						      </div>
						      
						    </div>
							</div>
						</div>
				</div>
			</div>
	
	</section>






 <script type="text/javascript">
	// 일반 로그인 
 	let socials = document.getElementsByClassName("btn_social"); 

   for(let social of socials) {
		social.addEventListener('click', function(){ 
			let socialType = this.getAttribute('data-social'); 
    		location.href="/oauth2/authorization/" + socialType; 
    	})
	}


   

  </script> 


</html>
