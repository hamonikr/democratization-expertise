<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui chart -->
<link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" />
<!-- <link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" /> -->

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<!-- <script src=”https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js”></script> -->


<link rel="stylesheet" href="/css/popup.css">

<style type="text/css">
.pop-layer .card-header { padding: 1em 1.5em }
.pop-layer .card-body { height: 220px }
.card-footer { text-align: center }

.profileLeftDiv { text-align: center; }

.newslatrDiv span{ vertical-align: middle }
.ck_newslater { 
	vertical-align: middle;
	height: 20px;
	width: 20px; 
}

.pop-layer {
	position: absolute;
	top: 20%;
	min-width: 380px;
	width: 380px;
}
</style>
<body>

<style>
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
</style>		
		
<div class="content-center">
	<h2>커뮤니티 사람들</h2>

	<ul class="nav nav-tabs user-tab" id="custom-tabs-three-tab" role="tablist">
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
				<c:if test="${ user.userprofileimg.length() != 0 }">
					<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.userprofileimg.length() == 0 and user.userprofileimg == null and user.picture == null}">
					<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.picture != null and user.userprofileimg == null}">
					<img alt="profile" src="${user.picture}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				
				<span class="level"><img src="/img/level_gold.png" alt=""></span>
				<span class="url">홈페이지:<a href="${user.userurl}" target="_blank">${user.userurl}</a></span>
			</div>

            <div class="profile-info">
            	<p class="myname">${user.username}</p>
                <p class="myintro">${user.aboutme}</p>
                <ul class="info-detail">
                	<li class="graph"><div id="chart-area"></div></li>
                    <li>
                    	<p class="score">평판 : <span>${score}</span></p>
                      	<p class="myinfo">현재레벨 : <span>1등</span> <br> 다음레벨 : <span>2등</span></p>
                      	<p class="myinfo"><span>+9999</span> <br> <span>-250</span> </p>
                      	<p class="myinfo">질문 : <span>456</span> <br> 답변 : <span>89</span></p>
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
								<button type="submit" class="btn-primary btn-xs" >더보기</button>
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
								<button type="submit" class="btn-primary btn-xs" >더보기</button>
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
								<button type="submit" class="btn-primary btn-xs" >더보기</button>
							</form>
						</c:if>
					</span>
				</div>
	            <span class="ques-tag" >
<!-- 	             <ul style="height: 100px;"> -->
	            	<c:forEach var="list" items="${ tList }" varStatus="status">
<!-- 						<li> -->
						<a href="/wiki/view/${ list.wikino }" class="float-left ">${ list.title }</a>
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
								<button type="submit" class="btn-primary btn-xs" >더보기</button>
							</form>
						</c:if>
					</span>
				</div>
	        
		        <ul style="height: 100px;">
		        	<c:forEach var="list" items="${ wList }" varStatus="status">
						<li>
							<a href="/wiki/view/${ list.wikino }">${ list.title }</a>
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
            	<c:if test="${user.userprofileimg != null && user.userprofileimg != ''}">
					<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${user.userprofileimg == null || user.userprofileimg == ''}">
					<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
				</c:if>
				<c:if test="${ isMypage }">
					<label class="leftbtn" >
						<input type="hidden" name="userprofileimg" value="${user.userprofileimg}">
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
						<input class="input-type1" id="userName" name="username" value="${user.username}" autocomplete="off" disabled="disabled">
					</c:if>
            	</li>
                <li><label>E-mail 주소</label>
                	<c:if test="${ isMypage }">
						<input class="input-type1" id="userEmail" name="useremail" value="${user.useremail}" autocomplete="off">
					</c:if>
					<c:if test="${ ! isMypage }">
						<input class="input-type1" id="userEmail" name="useremail" value="${user.useremail}" autocomplete="off" disabled="disabled">
					</c:if>
                </li>
                <li><label>Url</label>
                	<c:if test="${ isMypage }">
						<input class="input-type1" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off">
					</c:if>
					<c:if test="${ ! isMypage }">
						<input class="input-type1" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off" disabled="disabled">
					</c:if>
                </li>
                
                <li><label>회사</label>
                	<c:if test="${ isMypage }">
						<c:choose>
							<c:when test="${enterprise.userat == 1}">
								<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
								<input type="text" class="input-type1" id="enterpriseNameSearch" value="${enterprise.enterprisename}" autocomplete="off">
									<div id="enterpriseListDiv"></div>			
							</c:when>		
							<c:otherwise>
							<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
								<input type="text" class="input-type1" id="enterpriseNameSearch" value="" autocomplete="off">	
									<div id="enterpriseListDiv"></div>									
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="${ ! isMypage }">
						<c:choose>
							<c:when test="${enterprise.userat == 1}">
								<input class="input-type1" value="${enterprise.enterprisename}" autocomplete="off" disabled="disabled">
							</c:when>
							<c:otherwise>
								<input class="input-type1" value="" autocomplete="off" disabled="disabled">	
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
							<input type="hidden" name="newslater" value="${ user.newslater }">
							<c:choose>
								<c:when test="${user.newslater eq 'Y'}">
									<input type="checkbox" class="" checked>
								</c:when>
								<c:otherwise>
									<input type="checkbox" class="">
								</c:otherwise>
							</c:choose>
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


          
<!-- 비밀번호 변경 팝업 -->
<div id="popupPw" class="card card-primary pop-layer" style="display: none;">
	<form id="frm1" name="frm1" method="post">
		<div class="dim-layer">
			<div class="dimBg"></div>
		</div>
		
		<div class="card-header">
			<h3 class="card-title">비밀번호 변경</h3>
		</div>

		<div class="card-body" style="width:100%;">
			<div class="input-group mb-3">
				<input type="password" class="form-control" name="userpassword" placeholder="기존 비밀번호">
			</div>
			<div class="input-group mb-3">
				<input type="password" class="form-control" name="userpasswordnew" placeholder="새 비밀번호">
			</div>
			<div class="input-group mb-3">
				<input type="password" class="form-control" name="userpasswordnew2" placeholder="새 비밀번호 확인">
			</div>
			<p id="popupPwAlter" class="popupPwAlter"></p>
		</div>
		
		<div class="card-footer cont_btn_div">
			<button type="button" id="btnUpdatePw" class="btn btn-primary purple">수정</button>
			<button type="button" id="btnUpdatePWCancle" class="btn btn-primary purple">취소</button>
		</div>
	</form>
</div>


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


$('#enterpriseNameSearch').on("propertychange change keyup paste input", function(){
 //alert(oldEnterName);
//회사명 실시간 검색 기능
//function fn_searchEnterpriseName() {
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
// 		beforeSend : function(xhr) {
// 			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 		},
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
});


//비밀번호 팝업 열기/닫기
function fnPopupPw(){
	//alert(1);
	if('none' == $('#popupPw').css('display')) $('#popupPw').css('display', 'block');
	else if('block' == $('#popupPw').css('display')) $('#popupPw').css('display', 'none');

	$('input[name=userpassword]').val('');
	$('input[name=userpasswordnew]').val('');
	$('input[name=userpasswordnew2]').val('');
}

//사용자 정보 변경
function fnUpdate() {
	if($('.newslater').eq(0).is(':checked')){
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
	var uPw = $('input[name=userpassword]');
	var uPwNew = $('input[name=userpasswordnew]');
	var uPwNew2 = $('input[name=userpasswordnew2]');
	var uPwVal = $.trim($(uPw).val());
	var uPwNewVal = $.trim($(uPwNew).val());
	var uPwNew2Val = $.trim($(uPwNew2).val());
	
	$('#popupPwAlter').text('');
	
	// 유효성 검사
	if(uPwVal.length == 0){
		$('#popupPwAlter').text('비밀번호를 입력해 주세요.');
		$(uPw).focus();
		return;
	}else if(uPwNewVal.length == 0){
		$('#popupPwAlter').text('새 비밀번호를 입력해 주세요.');
		$(uPwNew).focus();
		return;
	}else if(uPwNew2Val.length == 0){
		$('#popupPwAlter').text('새 비밀번호 확인을 입력해 주세요.');
		$(uPwNew2).focus();
		return;
	}else if(uPwNewVal != uPwNew2Val){
		$('#popupPwAlter').text('비밀번호가 일치하지 않습니다.');
		$(uPwNew2).focus();
		return;
	}

	$.ajax({
		url			: '/users/modifyPw',
		data		: $("#frm1").serialize(),
		type		: 'post',
		success	: function(data){
			alert(data.message);
			if(data.updateVal) location.reload(true);
		},
		error		: function(xhr, status, error){
			console.log(xhr, status, error);
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
        width: 360,
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
<script src='/tui-chart/example.js'></script>
</body>
</html>