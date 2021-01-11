<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui chart -->
<link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" />
<!-- <link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" /> -->

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />


<style>
.profile-info .graph2 {
    border: 1px solid #e3ebf4;
    border-radius: 3px;
    /* padding: 15px; */
    /* width: 50%; */
    height: 220px;
    margin-right: 20px;
}
.nav-tabs .nav-link.active {
	font-weight: 500;
    background: #2d096a;
    color: #fff;
    border: 1px solid #2d096a;
    border-radius: 20px;
}

.nav-tabs .nav-link {
    border-radius: 20px;
}
.nav-tabs {
    border-bottom: 0;
}
 input[type=submit] {
    width: 4em;  height: 2em;
    cursor:pointer;
    background-color: Transparent;
    background-repeat:no-repeat;
    border: none;
}
</style>	

<div class="content-center">
	<h2>커뮤니티 참여기업 </h2>

	<ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-home" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">Activity</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="custom-tabs-three-profile-tab" data-toggle="pill" href="#custom-tabs-three-profile" role="tab" aria-controls="custom-tabs-three-profile" aria-selected="false">Profile</a>
		</li>
		<li class="nav-item">
		   	<a class="nav-link" id="custom-tabs-three-members-tab" data-toggle="pill" href="#custom-tabs-three-members" role="tab" aria-controls="custom-tabs-three-members" aria-selected="false">Members</a>
		</li>
	</ul>
	
	
<div class="tab-content" id="custom-tabs-three-tabContent">

	<div class=" tab-pane fade active show con-box" id="custom-tabs-three-home" role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
		<div class="profile-con">
			<div class="profile-photo">
				<c:if test="${enterprise.enterpriseimg != null && enterprise.enterpriseimg != ''}">
					<img alt="profile" src="/upload/enterprises/${enterprise.enterpriseimg}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<%-- <c:if test="${enterprise.enterpriseimg == null || enterprise.enterpriseimg == ''}">
					<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
				</c:if> --%>
									
	            <span class="level"><img src="/img/level_gold.png" alt=""></span>
	            <span class="url">홈페이지:<a href="${enterprise.enterpriseurl }" target="_blank">${enterprise.enterpriseurl }</a></span>
			</div>
	            
	        <div class="profile-info">
	        	<p class="myname">${enterprise.enterprisename}</p>
	            <p class="myintro">${enterprise.enterpriseabout}</p>
				<ul class="info-detail">
	            	<li class="graph2"><div id="chart-area"></div></li>
	                <li>
		            	<p class="score">평판 : <span>${ score }</span></p>
		                <p class="myinfo">현재레벨 : <span>1등</span> <br> 다음레벨 : <span>2등</span></p>
		                <p class="myinfo"><span>+9999</span> <br> <span>-250</span> </p>
		                <p class="myinfo">질문 : <span>${ qCnt }</span> <br> 답변 : <span>${ aCnt }</span></p>
					</li>
				</ul>
			</div>
	            
	        <div class="mywrit-con">
			<!-- // 질문 -->
            	<div class="mywrit">
                	<div class="mytitle">
                    	질문 (${ qCnt })
                    	<span class="more">
                    	<c:if test="${ qCnt > 5 }">
							<form action="/questions/myListEnter">
								<input type="hidden" name="userno" value="${ enterprise.enterpriseno }">
								<input type="hidden" name="section" value="Q">
								<!--<button type="submit" class="btn-primary btn-xs" >+더보기</button> -->
								<input type="submit" id="search" value="+더보기" class="" />
							</form>
						</c:if>
                    	</span>
                  	</div>
                  	<ul>
                  		<c:forEach var="list" items="${ qList }" varStatus="status">
						<li>
							<span class="up"><i class="mdi"></i>Q.</span>
								<a href="/questions/view/${ list.questionno }">${ list.title }</a>
						</li>
						</c:forEach>
					</ul>
				</div>

				<!-- // 답변 -->
                <div class="mywrit other">
                	<div class="mytitle">
                    	답변 (${ aCnt })
                    	<span class="more">
                    		<c:if test="${ aCnt > 5 }">
							<form action="/questions/myListEnter">
								<input type="hidden" name="userno" value="${ enterprise.enterpriseno }">
								<input type="hidden" name="section" value="A">
<!-- 								<button type="submit" class="btn-primary btn-xs" >+더보기</button> -->
								<input type="submit" id="search" value="+더보기" class="" />
							</form>
							</c:if>
                    	</span>
                  	</div>
					<ul>
               			<c:forEach var="list" items="${ aList }" varStatus="status">
						<li>
							<span class="up"><i class="mdi"></i>A.</span>
							<a href="/questions/view/${ list.questionno }">
								${fn:substring(list.contents.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""), 0, 150)}
							</a>
						</li>
						</c:forEach>
                  	</ul>
				</div>

				<!-- // Tags -->
                <div class="mywrit">
                	<div class="mytitle">
                    	Tags (${ tCnt })
                    	<c:if test="${ tCnt > 5 }">
						<form action="/questions/myList">
							<input type="hidden" name="userno" value="${ user.userno }">
							<input type="hidden" name="type" value="A">
<!-- 							<button type="submit" class="btn" >+더보기</button> -->
							<input type="submit" id="search" value="+더보기" class="" />
						</form>
						</c:if>
                  	</div>
					<span class="ques-tag">
						<c:forEach var="list" items="${ tList }" varStatus="status">
							<a href="/wiki/view/${ list.wikino }" >${ list.title }</a>
						</c:forEach>
					</span>
				</div>


				<!-- // wiki -->
                <div class="mywrit other">
                	<div class="mytitle">
                    	Wiki (${ wCnt })
                    	<span class="more">
                    		<c:if test="${ wCnt > 5 }">
								<form action="/questions/myList">
									<input type="hidden" name="userno" value="${ user.userno }">
									<input type="hidden" name="type" value="A">
<!-- 									<button type="submit" class="btn" >더보기</button> -->
									<input type="submit" id="search" value="+더보기" class="" />
								</form>
							</c:if>
                    	</span>
                  	</div>
                  	<ul>
                  		<c:forEach var="list" items="${ wList }" varStatus="status">
							<li><a href="/wiki/view/${ list.wikino }">${ list.title }</a></li>
						</c:forEach>
                  	</ul>
                </div>
			</div>
              
		</div>
		<div class="mywrite-com"></div>
		
	</div>
	
	<div class="tab-pane fade con-box" id="custom-tabs-three-profile" role="tabpanel" aria-labelledby="custom-tabs-three-profile-tab">
		<div class="profile-con">
			<form id="frm" name="frm" method="post">
				<input type="hidden" name="_csrf" value="${_csrf.token}">
				<input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
				<input type="hidden" name="enterpriseno" value="${enterprise.enterpriseno}">
                <div class="profile-photo">
                	<c:if test="${enterprise.enterpriseimg != null && enterprise.enterpriseimg != ''}">
						<img alt="profile" src="/upload/enterprises/${enterprise.enterpriseimg}" id="profileImg" class="img" width="100%"><br/>
					</c:if>
					<c:if test="${enterprise.enterpriseimg == null || enterprise.enterpriseimg == ''}">
						<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
					</c:if>
					<c:if test="${ isMypage }">
						<label class="leftbtn" >
							<input type="hidden" name="userprofileimg" value="${enterprise.enterpriseimg}">
							<input id="iptProfileImg" name="profileImg" type="file" onchange="fnProfileImg()" style="display: none;">
							<span style="cursor: pointer"><i class="mdi mdi-camera"></i>사진첨부</span><br/>
						</label>
						<a href="javascript:fnPopupPw();" class="leftbtn" id="btnPw"> <i class="mdi mdi-key"></i>비밀번호 변경</a>
					</c:if>
                </div>

                <ul class="my-modify">
                	<li>
                		<label>상호명</label>
                		<c:if test="${ isMypage }">
							<input class="input-type1" id="enterprisename" name="enterprisename" value="${enterprise.enterprisename}" autocomplete="off">
						</c:if>
						<c:if test="${ ! isMypage }">
							<input class="input-type1" id="enterprisename" name="enterprisename" value="${enterprise.enterprisename}" autocomplete="off" disabled="disabled">
						</c:if>
					</li>
                  	<li>
                  		<label>E-mail 주소</label>
                  		<c:if test="${ isMypage }">
							<input class="input-type1" id="enterpriseemail" name="enterpriseemail" value="${enterprise.enterpriseemail}" autocomplete="off">
						</c:if>
						<c:if test="${ ! isMypage }">
							<input class="input-type1" id="enterpriseemail" name="enterpriseemail" value="${enterprise.enterpriseemail}" autocomplete="off" disabled="disabled">
						</c:if>
                  	</li>
                  
                  	<li>
                  		<label>Url</label>
                  		<c:if test="${ isMypage }">
							<input class="input-type1" id="enterpriseurl" name="enterpriseurl" value="${enterprise.enterpriseurl}" autocomplete="off">
						</c:if>
						<c:if test="${ ! isMypage }">
							<input class="input-type1" id="enterpriseurl" name="enterpriseurl" value="${enterprise.enterpriseurl}" autocomplete="off" disabled="disabled">
						</c:if>
					</li>
                  	<li>
                  		<label>지역</label>
                  		<c:if test="${ isMypage }">
							<input class="input-type1" id="enterprisearea" name="enterprisearea" value="${enterprise.enterprisearea}" autocomplete="off">
						</c:if>
						<c:if test="${ !isMypage }">
							<input class="input-type1" id="enterprisearea" name="enterprisearea" value="${enterprise.enterprisearea}" autocomplete="off" disabled="disabled">
						</c:if>
                  	</li>
                  	<li>
                    	<label>사업자번호</label>
                      	<c:if test="${ isMypage }">
							<input class="input-type1" id="enterprisebizno" name="enterprisebizno" value="${enterprise.enterprisebizno}" autocomplete="off">
						</c:if>
						<c:if test="${ ! isMypage }">
							<input class="input-type1" id="enterprisebizno" name="enterprisebizno" value="${enterprise.enterprisebizno}" autocomplete="off" disabled="disabled">
						</c:if>
                  	</li>
                  	<li>
                  		<label>기업홍보</label>
                    	<div class="de-editro">
							<c:if test="${ isMypage }">
								<input type="hidden" class="form-control contents" id="enterpriseabout" name="enterpriseabout" value="${enterprise.enterpriseabout}" autocomplete="off">
								<div class="code-html">
									<div id="editSection">${enterprise.enterpriseabout}</div> 
								</div>
								<script class="code-js">
									var editor = new toastui.Editor( { //new tui.Editor({
										el: document.querySelector('#editSection')
										, previewStyle: 'vertical'
										, height: '250px'
									});
								</script>
							</c:if>
							<c:if test="${ ! isMypage }">
								<div class="code-html">
									<div id="viewAbout">${enterprise.enterpriseabout}</div> 
								</div>
								<script class="code-js">
									var editor = new toastui.Editor.factory( {
					                	el : document.querySelector( '#viewAbout' ),
					                	initialEditType : 'wysiwyg',
					                	previewStyle : 'vertical',
					                	height : '250px',
					                	viewer : true
					                	} );
 				            	</script>
							</c:if> 
                    	</div>
                  	</li>
				</ul>
				
				<c:if test="${ isMypage }">
					<div class="mT30 txt-center">
						<button type="button" id="btnUpdate" class="btn-blue">수정하기</button>
					</div>
				</c:if> 
                
			</form>
		</div>
	</div>
	
	<div class="tab-pane fade con-box" id="custom-tabs-three-members" role="tabpanel" aria-labelledby="custom-tabs-three-members-tab">
		<div class="con-box">
	    	<div class="mytitle"> 활동중인 사람들</div>
    			<ul class="company-user">
					<c:forEach var="useratCompy" items="${ usersAtStatus }" varStatus="status">
         				<c:if test="${ useratCompy.usersDetail.userat == 1 }">
         				<li>
                  			<a href="/users/activity/${useratCompy.userno}">
								<c:if test="${ useratCompy.userprofileimg != null}">
									<img alt="profile" src="/upload/users/${useratCompy.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<c:if test="${useratCompy.userprofileimg == null and useratCompy.picture == null}">
									<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<c:if test="${useratCompy.userprofileimg == null and useratCompy.picture != null}">
									<img alt="profile" src="${useratCompy.picture}" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<span class="name"><a href="/users/activity/${useratCompy.userno}">${useratCompy.username}</a></span>
                  				<span class="reputation">평판</span>
	<%--                   <span>${useratCompy.representat }ss</span> --%>
								</a>
							<c:if test="${isMypage == true}">
								<div class="active">
									<c:if test="${ useratCompy.usersDetail.activeat == 0 }">
	                    				<a href="javascript:fnt_activeatUser('userat','${useratCompy.userno}');">활성</a>
	                    				<a href="javascript:fnt_activeatUser('not','${useratCompy.userno}');" class="off">비활성</a>
									</c:if>
									<c:if test="${ useratCompy.usersDetail.activeat == 1 }">
	                    				<a href="javascript:fnt_activeatUser('userat','${useratCompy.userno}');" class="off">활성</a>
	                    				<a href="javascript:fnt_activeatUser('not','${useratCompy.userno}');" >비활성</a>
									</c:if>
								</div>
							</c:if>
						</li>
         				</c:if>
					</c:forEach>	            
		      	</ul>
		      	<div class="mT30">
		      		<c:if test="${isMypage == true}">
		      		<div class="mytitle"> 요청한 사람들</div>
              		<ul class="company-user">
              			<c:forEach var="useratCompy" items="${ usersAtStatus }" varStatus="status">
         					<c:if test="${ useratCompy.usersDetail.userat == 0 }">
         					<li>
                  				<a href="/users/activity/${useratCompy.userno}">
									<c:if test="${ useratCompy.userprofileimg != null}">
										<img alt="profile" src="/upload/users/${useratCompy.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
									</c:if>
									<c:if test="${useratCompy.userprofileimg == null and useratCompy.picture == null}">
										<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
									</c:if>
									<c:if test="${useratCompy.userprofileimg == null and useratCompy.picture != null}">
										<img alt="profile" src="${useratCompy.picture}" id="profileImg" class="img" width="100%"><br/>
									</c:if>
									<span class="name"><a href="/users/activity/${useratCompy.userno}">${useratCompy.username}</a></span>
                  					<span class="reputation">평판</span>
								</a>
								<div class="active">
									<c:if test="${ useratCompy.usersDetail.activeat == 0 }">
				                    	<a href="javascript:fnt_activeatUser('userat','${useratCompy.userno}');">승인</a>
				                    	<a href="javascript:fnt_activeatUser('not','${useratCompy.userno}');" class="off">거절</a>
									</c:if>
									<c:if test="${ useratCompy.usersDetail.activeat == 1 }">
				                    	<a href="javascript:fnt_activeatUser('userat','${useratCompy.userno}');" class="off">승인</a>
				                    	<a href="javascript:fnt_activeatUser('not','${useratCompy.userno}');" >거절</a>
									</c:if>
                  				</div>
							</li>
         				</c:if>
					</c:forEach>	 
				</ul>
				</c:if>
			  </div>
			</div>
		</div>
</div>
		
		
								
</div>

    
<div id="popupPw" class="popup popa "  style="display: none;">
    <div class="pop-content">
      
      <form id="frm1" name="frm1" method="post">
      	<input type="password" class="form-control" name="enterprisepassword" placeholder="기존 비밀번호">
      	<input type="password" class="form-control" name="enterprisepasswordnew" placeholder="새 비밀번호">
      	<input type="password" class="form-control" name="enterprisepasswordnew2" placeholder="새 비밀번호 확인">

	      <div class="mT30 txt-center">
	        <button type="button"  id="btnUpdatePw"  class="btn-blue">수정</button>
	        <button type="button" id="btnUpdatePWCancle" class="btn-gray">취소</button>
	      </div>
      </form>
      
    </div>
  </div>
  <div id="bg_fix" style="display: none;" class="popup "></div>
  


<script type="text/javascript">
$(function() {
	// 수정 버튼
	$("#btnUpdate").on("click", fnUpdate);

	// 비밀번호 변경
	$('#btnUpdatePw').on('click', fnUpdatePw);
	
	// 비밀번호 팝업 열기/닫기
// 	$('#btnPw').on('click', fnPopupPw);
	$('#btnUpdatePWCancle').on('click', fnPopupPw);
});

//비밀번호 팝업 열기/닫기
function fnPopupPw(){
	if('none' == $('#popupPw').css('display')) {
	  $('#popupPw').css('display', 'block');
	  $('#bg_fix').css('display', 'block');
	}else if('block' == $('.popupPw').css('display')) {
	  $('#popupPw').css('display', 'none');
	  $('#bg_fix').css('display', 'none');
	  
	}


	$('input[name=enterprisepassword]').val('');
	$('input[name=enterprisepasswordnew]').val('');
	$('input[name=enterprisepasswordnew2]').val('');
}

// 사용자 정보 변경
function fnUpdate() {
	document.frm.enterpriseabout.value = editor.getHtml();
	document.frm.action = "/enterprises/modify";
	document.frm.submit();
}

// 사용자 비밀번호 변경
function fnUpdatePw(){
	var ePw = $('input[name=enterprisepassword]');
	var ePwNew = $('input[name=enterprisepasswordnew]');
	var ePwNew2 = $('input[name=enterprisepasswordnew2]');
	var ePwVal = $.trim($(ePw).val());
	var ePwNewVal = $.trim($(ePwNew).val());
	var ePwNew2Val = $.trim($(ePwNew2).val());
	
	$('#popupPwAlter').text('');
	
	// 유효성 검사
	if(ePwVal.length == 0){
		$('#popupPwAlter').text('비밀번호를 입력해 주세요.');
		$(ePw).focus();
		return;
	}else if(ePwNewVal.length == 0){
		$('#popupPwAlter').text('새 비밀번호를 입력해 주세요.');
		$(ePwNew).focus();
		return;
	}else if(ePwNew2Val.length == 0){
		$('#popupPwAlter').text('새 비밀번호 확인을 입력해 주세요.');
		$(ePwNew2).focus();
		return;
	}else if(ePwNewVal != ePwNew2Val){
		$('#popupPwAlter').text('비밀번호가 일치하지 않습니다.');
		$(ePwNew2).focus();
		return;
	}

	$.ajax({
		url			: '/enterprises/modifyPw',
		data		: $("#frm1").serialize(),
		type		: 'post',
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success	: function(data){
			alert(data.message);
			if(data.updateVal) location.reload(true);
		},
		error		: function(xhr, status, error){
			console.log(xhr, status, error);
		}
	});
}

// 기업회원 프로필 변경
function fnProfileImg(){
	var form = $('<form></form>');
	var img = $('#iptProfileImg').clone();

	form.attr('method', 'post');
	form.attr('enctype', 'multipart/form-data');
	form.append(img);

	var fileData = new FormData($(form)[0]);
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	
	$.ajax({
		enctype	: 'multipart/form-data',
		url			: '/enterprises/upload',
		data		: fileData,
		type		: 'post',
		processData: false, 
		contentType: false,
		cache		: false,
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success	: function(data){
			alert(data.message);
			if(data.result) location.reload(true);
		},
		error		: function(xhr, status, error){
			console.log(xhr, status, error);
		}
	});
}

// popup resize
function fnPopupResize(){
	$('.pop-layer').css('left', $(window).width() / 2 - 190 + 'px');
}

fnPopupResize();
$(window).resize(function(){
	fnPopupResize();	// 팝업 위치 및 크기 조정
});

// 승인1/거절2
function fnt_useratUser(type,uno){
	if(type == 'not') type = 2;
	else if(type == 'userat') type = 1;
	else return;
	alert(type);

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	$.ajax({
		url			: '/enterprises/updateUserat',
		data		: { 'userat' : type , 'userno' : uno},
		type		: 'post',
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success	: function(data){
			alert(data.message);
			if(data.updateVal) location.reload(true);
		},
		error		: function(xhr, status, error){
			console.log(xhr, status, error);
		}
	});
}

//활성1/비활성3
function fnt_activeatUser(type,uno){
	if(type == 'not') type = 3;
	else if(type == 'userat') type = 1;
	else return;

	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({
		url			: '/enterprises/updateUserat',
		data		: { 'userat' : type , 'userno' : uno},
		type		: 'post',
		beforeSend : function(xhr) {
			xhr.setRequestHeader(header, token);
		},
		success	: function(data){
			alert(data.message);
			if(data.updateVal) location.reload(true);
		},
		error		: function(xhr, status, error){
			console.log(xhr, status, error);
		}
	});
}


</script>

<!-- chart -->
<script type='text/javascript' src='https://uicdn.toast.com/tui.chart/latest/raphael.js'></script>
<script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/core-js/2.5.7/core.js'></script>
<script src='/tui-chart/tui-chart.js'></script>
<script class='code-js' id='code-js'>
var today = new Date();   
var month = today.getMonth() + 1;
var monthArr = [];

for(var i=0; i<6 ;++i){
	monthArr.push(month-i + ' 월');
}

var monthList = [''];
var score = [];
var list = '';
var enterpriseno = $('form[name=frm] input[name=enterpriseno]').val();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$.ajax({
	url			: '/enterprises/getScoregraph',
	data		: {'enterpriseno' : enterpriseno},
	type		: 'post',
	async		: false,
	beforeSend : function(xhr) {
		xhr.setRequestHeader(header, token);
	},
	success	: function(data){
		list = data.list.split(',');
		for (var i = 0; i < 6; ++i) {
			score.push(list[5-i]); // [month, value]
		}
	},
	error		: function(xhr, status, error){
		console.log(xhr, status, error);
	}
});

var container = document.getElementById('chart-area');
var data = {
    categories: monthArr.reverse(),
    series: [
        {
            name: 'Score',
            data: score
        }
    ]
};
var options = {
    chart: {
        width: 300,
        height: 220,
        format: '1,000'
    },
    yAxis: {
        title: 'Score',
        min: 0
    },
    xAxis: { title: 'Month' },
	legend: { align: 'top' }
};
var theme = {
    series: {
        colors: [
            '#83b14e', '#458a3f', '#295ba0', '#2a4175', '#289399',
            '#289399', '#617178', '#8a9a9a', '#516f7d', '#dddddd'
        ]
    }
};
// For apply theme
// tui.chart.registerTheme('myTheme', theme);
// options.theme = 'myTheme';
tui.chart.columnChart(container, data, options);
</script>

<!--For tutorial page-->
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/codemirror.js'></script>
<script src='//ajax.aspnetcdn.com/ajax/jshint/r07/jshint.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/edit/matchbrackets.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/selection/active-line.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/mode/javascript/javascript.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/lint.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.43.0/addon/lint/javascript-lint.js'></script>
<script src='/tui-chart/example.js'></script>

