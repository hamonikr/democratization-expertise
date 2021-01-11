<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui chart -->
<link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" />

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<!-- jquery-validation -->
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!-- <script src="/plugins/jquery-validation/additional-methods.min.js"></script> -->
<!-- <script src="/plugins/jquery-validation/jquery.validate.min.js"></script>  -->


<!-- <link rel="stylesheet" href="/css/popup.css"> -->

<style type="text/css">
/* .pop-layer .card-header { padding: 1em 1.5em } */
/* .pop-layer .card-body { height: 220px } */
/* .card-footer { text-align: center } */

/* .profileLeftDiv { text-align: center; } */

/* .newslatrDiv span{ vertical-align: middle } */
/* .ck_newslater {  */
/* 	vertical-align: middle; */
/* 	height: 20px; */
/* 	width: 20px;  */
/* } */

/* .pop-layer { */
/* 	position: absolute; */
/* 	top: 20%; */
/* 	min-width: 380px; */
/* 	width: 380px; */
/* } */
/* .profile-info .graph2 { */
/*     border: 1px solid #e3ebf4; */
/*     border-radius: 3px; */
/*     height: 220px; */
/*     margin-right: 20px; */
/* } */

/* #popupPwAlter {  */
/* 	width: 100%; */
/* 	margin-top: -0.25rem; */
/* 	font-size: 80%; */
/* 	color: #da542e; */
/* } */
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
.my-modify  .enterpriseListDiv {
    max-height: 200px;
    overflow-y: auto;
    overflow-x: hidden;
    padding-right: 20px;
    width: calc(100% - 140px); 
    background: #fff;
    border-radius: 0 0 6px 6px;
    padding: 20px;
    border: 1px solid #e5ecf2;
    box-shadow: 0 2px 3px 0 rgba(0,1,3,.07);
    margin-left: 135px;
}

@media screen and (max-width: 1280px){
.my-modify  .enterpriseListDiv {
   margin-left: 1px !important;
				width: 100%;
  }
}
.my-modify  .enterpriseListDiv > p:hover {
width: 100%; 
    cursor: pointer;
    box-sizing: border-box;
    background: #f2f2f2;
    border:1px solid #ccc;
    white-space: nowrap;
    &:nth-child(even) {
       background: #eee;
    }
    &:hover {
       opacity: 0.25
    }
}

</style>		


		
<div class="content-center">
	<h2>커뮤니티 사람들</h2>

	<ul class="nav nav-tabs " id="custom-tabs-three-tab" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-home" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">Activity</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" id="custom-tabs-three-profile-tab" data-toggle="pill" href="#custom-tabs-three-profile" role="tab" aria-controls="custom-tabs-three-profile" aria-selected="false">Profile</a>
		</li>
	</ul>

<div class="tab-content" id="custom-tabs-three-tabContent">

	<div class=" tab-pane fade active show con-box" id="custom-tabs-three-home" role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
		<div class="profile-con">
			<div class="profile-photo">
				<c:if test="${ user.userprofileimg != null and user.userprofileimg != ''}">
					<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.userprofileimg == null and user.picture == null}">
					<img alt="profile" src="/img/profile_01.png" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.userprofileimg == null and user.picture != null}">
					<img alt="profile" src="${user.picture}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<%@ include file="/WEB-INF/views/users/level.jsp" %>
				<span class="url">홈페이지:<a href="${user.userurl}" target="_blank">${user.userurl}</a></span>
			</div>

            <div class="profile-info">
            	<p class="myname"> ${user.username}</p>
				<p class="myintro">${user.aboutme}</p>
                <ul class="info-detail">
                	<li class="graph2"><div id="chart-area"></div></li>
                    <li>
                    	<p class="score">평판 : <span>${score}</span> <a href="/wiki/helpview/140/h"><i class="mdi mdi-information"></i></a></p>
                      	<!-- <p class="myinfo">현재레벨 : <span>1등</span> <br> 다음레벨 : <span>2등</span></p> -->
                      	<p class="myinfo">좋아요 : <br> 싫어요 : </p>
                      	<p class="myinfo"><span>+${user.vote.likes}</span> <br> <span>-${user.vote.dislikes}</span> </p>
                      	<p class="myinfo">질문 : <span>${ qCnt }</span> <br> 답변 : <span>${ aCnt }</span></p>
                      	<p class="myicon">
                      	<%@ include file="/WEB-INF/views/users/logindays.jsp" %>
                      	<%@ include file="/WEB-INF/views/users/questioncount.jsp" %>
						<%@ include file="/WEB-INF/views/users/answercount.jsp" %>
						<%@ include file="/WEB-INF/views/users/selectedanswercount.jsp" %>
                      	</p>
                    </li>
				</ul>
			</div>
		</div><!-- //profile-con -->

		<div class="mywrit-con">
			<div class="mywrit">
				<div class="mytitle">
					질문 (${ qCnt })
					<span class="more">
						<c:if test="${ qCnt > 5 }">
							<form action="/questions/myList">
								<input type="hidden" name="userno" value="${ user.userno }">
								<input type="hidden" name="section" value="Q">
<!-- 								<button type="submit" class="btn-primary" >더보기</button> -->
								<input type="submit" id="search" value="+더보기" class="" />
							</form>
						</c:if>
					</span>
				</div>
	                   
	            <ul style="height: 100px;">
	            	<c:forEach var="list" items="${ qList }" varStatus="status">
					<li>
						<span class="up" style="width: 30px;"><i class="mdi " ></i>Q.</span>
	<!-- 							<span class="up"><i class="mdi mdi-arrow-up"></i>90</span> -->
						<a href="/questions/view/${ list.questionno }">${ list.title }</a>
					</li>
					</c:forEach>
				</ul>
			</div><!-- // 질문 -->
	                
	                
	        <div class="mywrit other">
	        	<div class="mytitle">
	        		답변 (${ aCnt })
	                <span class="more">
	                	<c:if test="${ aCnt > 5 }">
	                		<form action="/questions/myList">
								<input type="hidden" name="userno" value="${ user.userno }">
								<input type="hidden" name="section" value="A">
<!-- 								<button type="submit" class="btn-primary " >더보기</button> -->
								<input type="submit" id="search" value="+더보기" class="" />
							</form>
						</c:if>
					</span>
				</div>
	            <ul style="height: 100px;">
	            	<c:forEach var="list" items="${ aList }" varStatus="status">
	            		<li>
							<span class="up" style="width: 30px;"><i class="mdi"></i>A.</span>
							<a href="/questions/view/${ list.questionno }">
									${fn:substring(list.contents.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""), 0, 150)}
							</a>
						</li> 
					</c:forEach>
				</ul>
			</div><!-- // 답변 -->
	                
	                
	        <div class="mywrit">
				<div class="mytitle">
	            	Tags (${ tCnt })
	                <span class="more">
						<c:if test="${ tCnt > 5 }">
							<form action="/questions/myList">
								<input type="hidden" name="userno" value="${ user.userno }">
								<input type="hidden" name="type" value="A">
<!-- 								<button type="submit" class="btn-primary btn-xs" >더보기</button> -->
								<input type="submit" id="search" value="+더보기" class="" />
							</form>
						</c:if>
					</span>
				</div>
	            <span class="ques-tag" >
<!-- 	             <ul style="height: 100px;"> -->
	            	<c:forEach var="list" items="${ tList }" varStatus="status">
<!-- 						<li> -->
						<a href="/wiki/view/${ list.wikino }/t" class="float-left ">${ list.title }</a>
<!-- 						</li> -->
					</c:forEach>
<!-- 					</ul> -->
				</span>
			</div><!-- // Tags -->
	                
	        <div class="mywrit other">
	        	<div class="mytitle">
		            Wiki (${ wCnt })
		            <span class="more">
		            	<c:if test="${ wCnt > 5 }">
		            		<form action="/questions/myList">
								<input type="hidden" name="userno" value="${ user.userno }">
								<input type="hidden" name="type" value="A">
<!-- 								<button type="submit" class="btn-primary btn-xs" >더보기</button> -->
								<input type="submit" id="search" value="+더보기" class="" />
							</form>
						</c:if>
					</span>
				</div>
	        
		        <ul style="height: 100px;">
		        	<c:forEach var="list" items="${ wList }" varStatus="status">
						<li>
							<a href="/wiki/view/${ list.wikino }/w">${ list.title }</a>
						</li>
					</c:forEach>
				</ul>
			</div><!-- // 답변 -->
		</div>
	</div><!-- Activity End -->
            
            
	<!--  profile layer  -->
	<div class="tab-pane fade con-box" id="custom-tabs-three-profile" role="tabpanel" aria-labelledby="custom-tabs-three-profile-tab">
		<div class="profile-con">
		<form id="frm" name="frm" method="post">
			<input type="hidden" name="_csrf" value="${_csrf.token}">
			<input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
			<input type="hidden" name="userno" value="${user.userno}">
            
            <div class="profile-photo">
            	<c:if test="${ user.userprofileimg != null}">
					<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.userprofileimg == null and user.picture == null}">
					<img alt="profile" src="/img/profile_01.png" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.userprofileimg == null and user.picture != null}">
					<img alt="profile" src="${user.picture}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<!-- sns로그인 사용자는 프로필 사진 및 비밀번호 변경 불가 -->
				<c:if test="${ isMypage and user.role ne 2}">
					<label class="leftbtn" >
						<%-- <input type="hidden" name="userprofileimg" value="${user.userprofileimg}"> --%>
						<input id="iptProfileImg" name="profileImg" type="file" onchange="fnProfileImg()" style="display: none;">
						<span style="cursor: pointer"><i class="mdi mdi-camera"></i>사진첨부</span><br/>
					</label>
					<a href="#" class="leftbtn" id="btnPw"> <i class="mdi mdi-key"></i>비밀번호 변경</a>
				</c:if>
			</div>

            <ul class="my-modify">
            	<li><label>이름</label>
            		<c:if test="${ isMypage }">
						<input class="input-type1" id="userName" name="username" value="${user.username}" autocomplete="off">
					</c:if>
					<c:if test="${ ! isMypage }">
					${user.username}
					</c:if>
            	</li>
                <li><label>E-mail 주소</label>
                	<c:if test="${ isMypage }">
						<input class="input-type1" id="userEmail" name="useremail" value="${user.useremail}" autocomplete="off">
					</c:if>
					<c:if test="${ ! isMypage }">
						${user.useremail}
					</c:if>
                </li>
                <li><label>Url</label>
                	<c:if test="${ isMypage }">
						<input class="input-type1" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off">
					</c:if>
					<c:if test="${ ! isMypage }">
						${user.userurl}
					</c:if>
                </li>
                
                <li><label>회사</label>
                	<c:if test="${ isMypage }">
						<c:choose>
							<c:when test="${enterprise.userat == 1}">
								<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
								<input type="text" class="input-type1" id="enterpriseNameSearch" value="${enterprise.enterprisename}" autocomplete="off">
									<div id="enterpriseListDiv" class="enterpriseListDiv"></div>			
							</c:when>		
							<c:otherwise>
							<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
								<input type="text" class="input-type1" id="enterpriseNameSearch" value="" autocomplete="off">	
									<div id="enterpriseListDiv" class="enterpriseListDiv"></div>									
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${ ! isMypage }">
						<c:choose>
							<c:when test="${enterprise.userat == 1}">
								${enterprise.enterprisename}
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</c:if>
                </li>
                
                <li>
                	<label>나에대한 설명</label>
					<div class="de-editro">
					
                      <c:if test="${ isMypage }">
							<input type="hidden" class="form-control contents" id="aboutMe" name="aboutme" value="" autocomplete="off">
							<div class="code-html">
								<div id="editSection">${user.aboutme}</div> 
							</div>
							<script class="code-js">
								var editor = new toastui.Editor( { 
									el: document.querySelector('#editSection'),
									initialEditType: 'wysiwyg',
									previewStyle: 'vertical',
									height: '250px'
								});
				            </script>
						</c:if>
						<c:if test="${ ! isMypage }">
							<div id="viewer">${user.aboutme}</div> 
							<script>
								var viewer = new toastui.Editor.factory( { 
									el: document.querySelector('#viewer'),
									viewer: true
								});
				            </script>
						</c:if>
                    </div>
				</li>
                <li>
                	<label class="control control-checkbox">
	                    뉴스레터 구독하기
	                    <c:if test="${ isMypage }">
							<input type="hidden" name="newslater" value="">
							<input type="checkbox" name="newsCheck" class="" <c:if test="${user.newslater eq 'Y'}">checked</c:if>>
						</c:if>
<!-- 						<input type="checkbox" class="" checked> -->
<!-- 	                    <input type="checkbox" checked="checked" name="" id=""> -->
	                    <div class="control-indicator"></div>
                    </label>
				</li>
			</ul>
			
			
			<c:if test="${ isMypage }">
				<div class="mT30 txt-center">
					<button type="button" id="btnUpdate" class="btn-blue">수정</button>
				</div>
			</c:if> 
			
        </form>
		</div>
	</div>
	
	
</div>
</div>


<div id="popupPw" class="popup  pop-layer" style="display: none;">
    <div class="pop-content">
      
      <form id="frm1" name="frm1" method="post">
      	<input type="password" class="form-control" name="userpassword" placeholder="기존 비밀번호">
      	<input type="password" class="form-control" name="userpasswordnew" placeholder="새 비밀번호">
      	<input type="password" class="form-control" name="userpasswordnew2" placeholder="새 비밀번호 확인">
<p id="popupPwAlter" class="popupPwAlter"></p>
	      <div class="mT30 txt-center">
	        <button type="button"  id="btnUpdatePw"  class="btn-blue">수정</button>
	        <button type="button" id="btnUpdatePWCancle" class="btn-gray">취소</button>
	      </div>
      </form>
      
    </div>
</div>
<div id="bg_fix" style="display: none;" class="popup "></div>
  

          


<!-- FLOT CHARTS -->
<script type="text/javascript">
$(function() {
	// 수정 버튼
	$("#btnUpdate").on("click", fnUpdate);

	// 비밀번호 변경
	$('#btnUpdatePw').on('click', fnUpdatePw);
	
	// 비밀번호 팝업 열기/닫기
	$('#btnPw').on('click', fnPopupPw);
	$('#btnUpdatePWCancle').on('click', fnPopupPw);
	
});


//회사명 입력창
var oldEnterName = $('#enterpriseNameSearch').val();
//$('#enterpriseNameSearch').on("propertychange change keyup paste input", fn_searchEnterpriseName);

$('#enterpriseListDiv').hide();
$('#enterpriseNameSearch').on("propertychange change keyup paste input", function(){ //,enter명 실시간 검색 기능
  
  $('#enterpriseListDiv').show();
  
	var enterpriseNameSearch = $('#enterpriseNameSearch').val();
	if(enterpriseNameSearch == null) enterpriseNameSearch ='';
	enterpriseNameSearch = $.trim(enterpriseNameSearch);
	
	if(enterpriseNameSearch.length == 0) {
		$('#enterpriseListDiv').html('');
		$('#enterpriseNo').val('');
		oldEnterName = '';
		return;
	}
	if(enterpriseNameSearch == oldEnterName) {
		return;
	}

	oldEnterName = enterpriseNameSearch;

	$('#enterpriseListDiv').html('');
	
	$.ajax({
		url		: '/users/getEnterList',
		data	: { 'enterName' : enterpriseNameSearch },
		type	: 'post',
		async	: false,
 		 beforeSend : function(xhr) {
 			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
 		}, 
		success: function(data){
			for(var i=0; i < data.list.length ; ++i){
				$('#enterpriseListDiv').append('<p class="entElement" data-value="' + data.list[i].enterpriseno + '">' + data.list[i].enterprisename + '</p>');
			}
			if(data.list.length == undefined || data.list.length == 0){
				$('#enterpriseListDiv').html('<p class="entNotElement">등록된 정보가 없습니다.</p>');
			}
		},
		error		: function(xhr, status, error){
			console.log(xhr, status, error);
		}
	});
});

//회사명 선택시
$('#enterpriseListDiv').on('click', '.entElement', function(){
	$('#enterpriseNameSearch').val($(this).html());
	$('#enterpriseNo').val($(this).data('value'));
	$('#enterpriseListDiv').html('');
	$('#enterpriseListDiv').hide();
});


//비밀번호 팝업 열기/닫기
function fnPopupPw(){
	if('none' == $('#popupPw').css('display')){
	  $('#popupPw').css('display', 'block');
	  $('#bg_fix').css('display', 'block');
	}else if('block' == $('#popupPw').css('display')) {
	  $('#popupPw').css('display', 'none');
	  $('#bg_fix').css('display', 'none');
	}

	$('input[name=userpassword]').val('');
	$('input[name=userpasswordnew]').val('');
	$('input[name=userpasswordnew2]').val('');
}

//사용자 정보 변경
function fnUpdate() {
	if ($( 'input:checkbox[name="newsCheck"]' ).is( ":checked" ) == true){
		$('input[name=newslater]').val('Y');
	}else{
		$('input[name=newslater]').val('N');
	}
	document.frm.aboutMe.value = editor.getHtml();
	document.frm.action = "/users/modify";
	document.frm.submit();
}

//사용자 비밀번호 변경
function fnUpdatePw(){
  
 	$('#popupPwAlter').text('');
	// 비밀번호는 영문+숫자 조합으로
	 $.validator.addMethod("passwordCk",  function( value, element ) {
		   return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z]).*$/.test(value);
		}, "Format invalide"
	);

var ePw = $('input[name=userpassword]');
var ePwNew = $('input[name=userpasswordnew]');
var ePwNew2 = $('input[name=userpasswordnew2]');
var ePwVal = $.trim($(ePw).val());
var ePwNewVal = $.trim($(ePwNew).val());
var ePwNew2Val = $.trim($(ePwNew2).val());

//유효성 검사
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


			// 유효성 검사
			$.ajax({
				url			: '/users/modifyPw',
				data		: $("#frm1").serialize(),
				type		: 'post',
				beforeSend : function(xhr) {
					xhr.setRequestHeader(header, token);
				},
				success	: function(data){
					alert(data.message);
					if(data.updateVal) location.reload(true);
				}
			});
	}

//사용자 프로필 변경
function fnProfileImg(){
	var form = $('<form></form>');
	var img = $('#iptProfileImg').clone();

	form.attr('method', 'post');
	form.attr('enctype', 'multipart/form-data');
	form.append(img);

	var fileData = new FormData($(form)[0]);
	
	$.ajax({
		enctype	: 'multipart/form-data',
		url			: '/users/upload',
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

//popup resize
function fnPopupResize(){
	$('.pop-layer').css('left', $(window).width() / 2 - 190 + 'px');
}

fnPopupResize();
$(window).resize(function(){
	fnPopupResize();	// 팝업 위치 및 크기 조정
});
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
var userno = $('form[name=frm] input[name=userno]').val();
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$.ajax({
	url			: '/users/getScoregraph',
	data		: {'userno' : userno},
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
        width: 350,
        height: 200,
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
<!-- <script src='/tui-chart/example.js'></script> -->
