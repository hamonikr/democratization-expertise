<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<head>
<!-- tui-editor 사용 -->
<script src='/tui-editor/markdown-it/dist/markdown-it.js'></script>
<script src="/tui-editor/to-mark/dist/to-mark.js"></script>
<script src="/tui-editor/tui-code-snippet/dist/tui-code-snippet.js"></script>
<script src="/tui-editor/codemirror/lib/codemirror.js"></script>
<script src="/tui-editor/highlightjs/highlight.pack.js"></script>
<script src="/tui-editor/squire-rte/build/squire-raw.js"></script>
<script src="/tui-editor/tui-editor/dist/tui-editor-Editor.js"></script>
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor.css">
<link rel="stylesheet" href="/tui-editor/tui-editor/dist/tui-editor-contents.css"> 
<link rel="stylesheet" href="/tui-editor/codemirror/lib/codemirror.css">
<link rel="stylesheet" href="/tui-editor/highlightjs/styles/github.css">

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
</head>

<body>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="userno" value="${user.userno}">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>

		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<a href="/users/dashboard/${user.userno}" class="btn btn-primary">활동정보</a>
				<a href="/users/view/${user.userno}" class="btn btn-primary">프로필</a>
			</div>
			
			<div class="col-12">
				<div class="card card-primary" style="width: 100%;">
					<div class="card-header">
						<h3 class="card-title">회원정보 수정</h3>
					</div>

					<div class="card-body card-primary card-outline row" style="width: 100%;">

						<div class="col-3 profileLeftDiv">
							<c:if test="${user.userprofileimg != null && user.userprofileimg != ''}">
								<img alt="profile" src="/upload/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
							</c:if>
							<c:if test="${user.userprofileimg == null || user.userprofileimg == ''}">
								<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
							</c:if>
							
							<c:if test="${ isMypage }">
								<label class="btn btn-primary" >
									<input type="hidden" name="userprofileimg" value="${user.userprofileimg}">
									<input id="iptProfileImg" name="profileImg" type="file" onchange="fnProfileImg()" style="display: none;">
									<span>사진변경</span><br/>
								</label>
								<input type="button" id="btnPw" class="btn btn-primary" value="비밀번호 변경"><br/>
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
						</div>
						
						<div class="col-12">
							<div class="form-group">
								<label for="aboutMe" class="col-form-label">자기소개</label>
								<c:if test="${ isMypage }">
									<input type="hidden" class="form-control contents" id="aboutMe" name="aboutme" value="${user.aboutme}" autocomplete="off">
									<div class="code-html">
										<div id="editSection">${user.aboutme}</div> 
									</div>
									<script class="code-js">
										var editor = new tui.Editor({
											el: document.querySelector('#editSection'),
											initialEditType: 'wysiwyg',
											previewStyle: 'vertical',
											height: '400px'
										});
						            </script>
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control contents" id="aboutMe" name="aboutme" value="${user.aboutme}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>
						
						<div class="col-6">
							<div class="form-group">
								<label for="userUrl" class="col-form-label">홈페이지</label>
								<c:if test="${ isMypage }">
									<input class="form-control" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off">
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" id="userUrl" name="userurl" value="${user.userurl}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>
						
						<div class="col-6">
							<div class="form-group">
								<label for="enterpriseName" class="col-form-label">회사명</label>
								<c:if test="${ isMypage }">
									<input type="hidden" name="enterpriseno" id="enterpriseNo" value="${enterprise.enterpriseno}" autocomplete="off">
									<input type="text" class="form-control" id="enterpriseNameSearch" value="${enterprise.enterprisename}" autocomplete="off">
									<div id="enterpriseListDiv"></div>
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" value="${enterprise.enterprisename}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>

						<c:if test="${ isMypage }">
							<div class="col-12 newslatrDiv">
								<label>
									<input type="hidden" name="newslater" value="${ user.newslater }">
									<c:if test="${ user.newslater == 'Y' }">
										<input type="checkbox" class="newslater" checked>
									</c:if>
									<c:if test="${ user.newslater == 'N' }">
										<input type="checkbox" class="newslater">
									</c:if>
									<span>뉴스레터 구독</span>
								</label>
							</div>
						</c:if>
					</div>
					
					<c:if test="${ isMypage }">
						<div class="card-footer cont_btn_div">
							<button type="button" id="btnUpdate" class="btn btn-primary purple">수정</button>
						</div>
					</c:if>
				</div>
			</div>
			
		</div>
	</form>

	<!-- 비밀번호 변경 팝업 -->
	<div id="popupPw" class="card card-primary pop-layer" style="display: none;">
		<form id="frm1" name="frm1" method="post">
			<div class="dim-layer">
				<div class="dimBg"></div>
			</div>
			
			<div class="card-header">
				<h3 class="card-title">비밀번호 변경</h3>
			</div>
	
			<div class="card-body">
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

// 회사명 입력창
var oldEnterName = $('#enterpriseNameSearch').val();
$('#enterpriseNameSearch').on("propertychange change keyup paste input", fn_searchEnterpriseName);

// 회사명 실시간 검색 기능
function fn_searchEnterpriseName() {
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
		data	: { 'entername' : enterpriseNameSearch },
		type	: 'post',
		async	: false,
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
}

// 회사명 선택시
$('#enterpriseListDiv').on('click', '.entElement', function(){
	$('#enterpriseNameSearch').val($(this).html());
	$('#enterpriseNo').val($(this).data('value'));
	$('#enterpriseListDiv').html('');
});


// 비밀번호 팝업 열기/닫기
function fnPopupPw(){
	if('none' == $('#popupPw').css('display')) $('#popupPw').css('display', 'block');
	else if('block' == $('#popupPw').css('display')) $('#popupPw').css('display', 'none');

	$('input[name=userpassword]').val('');
	$('input[name=userpasswordnew]').val('');
	$('input[name=userpasswordnew2]').val('');
}

// 사용자 정보 변경
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

// 사용자 비밀번호 변경
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

// 사용자 프로필 변경
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

// popup resize
function fnPopupResize(){
	$('.pop-layer').css('left', $(window).width() / 2 - 190 + 'px');
}

fnPopupResize();
$(window).resize(function(){
	fnPopupResize();	// 팝업 위치 및 크기 조정
});
</script>
</body>
</html>