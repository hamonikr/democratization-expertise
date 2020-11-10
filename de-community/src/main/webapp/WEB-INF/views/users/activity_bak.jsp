<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<!-- tui chart -->
<link rel="stylesheet" type="text/css" href="/tui-chart/tui-chart.css" />

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<!-- jquery-validation -->
<script src="/plugins/jquery-validation/jquery.validate.min.js"></script>
<script src="/plugins/jquery-validation/additional-methods.min.js"></script>

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

		
		
		
	<section class="content" style="padding: 2px 12px 6px 19px;">
		
	
	<div class="col-12">
		<div class=" card-primary card-outline card-outline-tabs" style="border-top: 0px solid #007bff;">
			<div class="card-header p-0 border-bottom-0">
				<ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
					<li class="nav-item">
						<a class="nav-link active" id="custom-tabs-three-home-tab" data-toggle="pill" href="#custom-tabs-three-home" role="tab" aria-controls="custom-tabs-three-home" aria-selected="true">Activity</a>
					</li>
                <li class="nav-item">
                	<a class="nav-link" id="custom-tabs-three-profile-tab" data-toggle="pill" href="#custom-tabs-three-profile" role="tab" aria-controls="custom-tabs-three-profile" aria-selected="false">Profile</a>
					</li>
				</ul>
			</div>
			
			<div class="col-12">
				<div class="tab-content" id="custom-tabs-three-tabContent">
					<div class="tab-pane fade active show" id="custom-tabs-three-home" role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
                     
						<div class="card-body card-primary row" style="width: 100%;">
							<div class="col-8 row">
								<div class="col-12"><h2><b>${user.username}</b></h2><%-- <p>${user.aboutme}</p> --%></div>
								<div class="col-3"><h4>평판</h4><span>${score}</span></div>
								<div class="col-9"><div id="chart-area"></div></div>
							</div>
	
							<div class="col-4 profileLeftDiv">
								<c:if test="${ user.userprofileimg.length() != 0 }">
<%-- 								<c:if test="${user.userprofileimg != null || user.userprofileimg.length() eq 0 }"> --%>
									<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<c:if test="${user.userprofileimg == null and user.picture == null}">
									<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<c:if test="${user.picture != null and user.userprofileimg == null}">
									<img alt="profile" src="${user.picture}" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<span>배지 : </span><br/>
								<span>홈페이지 : </span><a href="${user.userurl}" target="_blank">${user.userurl}</a>
							</div>
						</div>
					
					
						<div class="card-body card-primary row" style="width: 100%;">
						
							<div class="col-6">
								<div>질문(${ qCnt })</div>
								<hr/>
								<c:forEach var="list" items="${ qList }" varStatus="status">
									<div class="dash-list">
										<a href="/questions/view/${ list.questionno }">${ list.title }</a>
									</div>
								</c:forEach>
								
								<c:if test="${ qCnt > 5 }">
									<form action="/questions/myList">
										<input type="hidden" name="userno" value="${ user.userno }">
										<input type="hidden" name="section" value="Q">
										<button type="submit" class="btn-primary btn-xs" >더보기</button>
									</form>
								</c:if>
							</div>
						
							<div class="col-6">
								<div>답변(${ aCnt })</div>
								<hr/>
								<c:forEach var="list" items="${ aList }" varStatus="status">
									<div class="dash-list">
										<a href="/questions/view/${ list.questionno }">
											${fn:substring(list.contents.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""), 0, 150)}
										</a>
									</div>
								</c:forEach>
								
								<c:if test="${ aCnt > 5 }">
									<form action="/questions/myList">
										<input type="hidden" name="userno" value="${ user.userno }">
										<input type="hidden" name="section" value="A">
										<button type="submit" class="btn-primary btn-xs" >더보기</button>
									</form>
								</c:if>
							</div>
						</div>
					
					
						<div class="card-body card-primary row" style="width: 100%;">
						
							<div class="col-6 row">
								<div class="col-12">태그(${ tCnt })</div>
								<hr/>
								<div class="dash-list col-12">
									<c:forEach var="list" items="${ tList }" varStatus="status">
										<a href="/wiki/view/${ list.wikino }" class="float-left badge bg-primary tagSpan">${ list.title }</a>
									</c:forEach>
								</div>
								
								<c:if test="${ tCnt > 5 }">
									<form action="/questions/myList">
										<input type="hidden" name="userno" value="${ user.userno }">
										<input type="hidden" name="type" value="A">
										<button type="submit" class="btn-primary btn-xs" >더보기</button>
									</form>
								</c:if>
							</div>
						
							<div class="col-6">
								<div>위키(${ wCnt })</div>
								<hr/>
								<c:forEach var="list" items="${ wList }" varStatus="status">
									<div class="dash-list">
										<a href="/wiki/view/${ list.wikino }">${ list.title }</a>
									</div>
								</c:forEach>
								
								<c:if test="${ wCnt > 5 }">
									<form action="/questions/myList">
										<input type="hidden" name="userno" value="${ user.userno }">
										<input type="hidden" name="type" value="A">
										<button type="submit" class="btn-primary btn-xs" >더보기</button>
									</form>
								</c:if>
							</div>
						</div>
					</div>
					
					
					<!--  profile layer  -->
					<div class="tab-pane fade" id="custom-tabs-three-profile" role="tabpanel" aria-labelledby="custom-tabs-three-profile-tab">
						
						<form id="frm" name="frm" method="post">
						<input type="hidden" name="_csrf" value="${_csrf.token}">
						<input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
						<input type="hidden" name="userno" value="${user.userno}">
						<div class="card-body card-primary card-outline row" style="width: 100%;">

							<div class="col-3 profileLeftDiv">
								<c:if test="${user.userprofileimg != null && user.userprofileimg != ''}">
									<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<c:if test="${user.userprofileimg == null || user.userprofileimg == ''}">
									<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
								</c:if>
				
								<c:if test="${ isMypage }">
									<label class="btn btn-block btn-outline-primary" >
										<input type="hidden" name="userprofileimg" value="${user.userprofileimg}">
										<input id="iptProfileImg" name="profileImg" type="file" onchange="fnProfileImg()" style="display: none;">
										<span>사진변경</span><br/>
									</label>
									<button type="button" id="btnPw" class="btn btn-block btn-outline-primary">비밀번호 변경</button>
								</c:if>
							</div>

							<div class="col-9 profileRightDiv">
								<div class="form-group">
									<label for="userName" class="col-form-label">이름</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="userName" name="username" value="${user.username}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="userName" name="username" value="${user.username}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>

								<div class="form-group">
									<label for="userEmail" class="col-form-label">메일</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="userEmail" name="useremail" value="${user.useremail}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="userEmail" name="useremail" value="${user.useremail}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
								
								<div class="form-group">
									<label for="userUrl" class="col-form-label">홈페이지</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
						
								<div class="form-group">
									<label for="enterpriseName" class="col-form-label">회사명</label>
									<c:if test="${ isMypage }">
										<c:choose>
											<c:when test="${enterprise.userat == 1}">
												<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
												<input type="text" class="form-control" id="enterpriseNameSearch" value="${enterprise.enterprisename}" autocomplete="off">
													<div id="enterpriseListDiv"></div>			
											</c:when>		
											<c:otherwise>
											<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
												<input type="text" class="form-control" id="enterpriseNameSearch" value="" autocomplete="off">	
													<div id="enterpriseListDiv"></div>									
											</c:otherwise>
										</c:choose>
										
									</c:if>
									<c:if test="${ ! isMypage }">
										<c:choose>
											<c:when test="${enterprise.userat == 1}">
												<input class="form-control" value="${enterprise.enterprisename}" autocomplete="off" disabled="disabled">
											</c:when>
											<c:otherwise>
												<input class="form-control" value="" autocomplete="off" disabled="disabled">	
											</c:otherwise>
										</c:choose>
									</c:if>
								</div>
								<c:if test="${ isMypage }">
									<div class="form-group newslatrDiv">
										<label>
											<input type="hidden" name="newslater" value="${ user.newslater }">
											<c:choose>
												<c:when test="${user.newslater eq 'Y'}">
													<input type="checkbox" class="newslater" checked>
												</c:when>
												<c:otherwise>
													<input type="checkbox" class="newslater">
												</c:otherwise>
											</c:choose>
											<span>뉴스레터 구독</span>
										</label>
									</div>
								</c:if>
							</div>
						
							<div class="col-12">
								<div class="form-group">
									<label for="aboutMe" class="col-form-label">자기소개</label>
									<c:if test="${ isMypage }">
										<input type="hidden" class="form-control contents" id="aboutMe" name="aboutme" value="" autocomplete="off">
										<div class="code-html">
											<div id="editSection">${user.aboutme}</div> 
										</div>
										<script class="code-js">
											var editor = new toastui.Editor( { //new tui.Editor({
												el: document.querySelector('#editSection'),
												initialEditType: 'wysiwyg',
												previewStyle: 'vertical',
												height: '400px'
											});
							            </script>
									</c:if>
									<c:if test="${ ! isMypage }">
										<div id="viewer">${user.aboutme}</div> 
										<script>
											var viewer = new toastui.Editor.factory( { //new tui.Editor({
												el: document.querySelector('#viewer'),
												viewer: true
											});
							            </script>
										
										<%-- <input class="form-control contents" id="aboutMe" name="aboutme" value="${user.aboutme}" autocomplete="off" disabled="disabled"> --%>
									</c:if>
								</div>
							</div>
							
						</div>
					
						<c:if test="${ isMypage }">
							<div class="card-footer cont_btn_div">
								<button type="button" id="btnUpdate" class="btn btn-primary purple">수정</button>
							</div>
						</c:if> 
					</form>
					</div>
					<!--  end profile  -->
				</div>
			</div>
		</div>
	</div>
	
	</section>
       
          
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

$.ajax({
	url			: '/users/getScoregraph',
	data		: {'userno' : userno},
	type		: 'post',
	async		: false,
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
        height: 240,
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