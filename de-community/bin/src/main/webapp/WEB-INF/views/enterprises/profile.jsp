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
		<input type="hidden" name="_csrf" value="${_csrf.token}">
		<input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
		<input type="hidden" name="enterpriseno" value="${enter.enterpriseno}">

		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<a href="/enterprises/activity/${enter.enterpriseno}" class="btn btn-primary">활동정보</a>
				<a href="/enterprises/profile/${enter.enterpriseno}" class="btn btn-primary">프로필</a>
				<a href="/enterprises/members/${enter.enterpriseno}" class="btn btn-primary">사람들</a>
			</div>
			
			<div class="col-12">
				<div class="card card-primary" style="width: 100%;">
					<div class="card-header">
						<h3 class="card-title">회원정보 수정</h3>
					</div>

					<div class="card-body card-primary card-outline row" style="width: 100%;">

						<div class="col-3 profileLeftDiv">
							<c:if test="${enter.enterpriseimg != null && enter.enterpriseimg != ''}">
								<img alt="profile" src="/upload/enterprises/${enter.enterpriseimg}" id="profileImg" class="img" width="100%"><br/>
							</c:if>
							<c:if test="${enter.enterpriseimg == null || enter.enterpriseimg == ''}">
								<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
							</c:if>
							
							<c:if test="${ isMypage }">
								<label class="btn btn-primary" >
									<input type="hidden" name="enterpriseimg" value="${enter.enterpriseimg}">
									<input id="iptProfileImg" name="profileImg" type="file" onchange="fnProfileImg()" style="display: none;">
									<span>사진변경</span><br/>
								</label>
								<input type="button" id="btnPw" class="btn btn-primary" value="비밀번호 변경"><br/>
							</c:if>
						</div>

						<div class="col-9 profileRightDiv">
							<div class="form-group">
								<label for="enterprisename" class="col-form-label">회사명</label>
								<c:if test="${ isMypage }">
									<input class="form-control" id="enterprisename" name="enterprisename" value="${enter.enterprisename}" autocomplete="off">
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" id="enterprisename" name="enterprisename" value="${enter.enterprisename}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>

							<div class="form-group">
								<label for="enterpriseemail" class="col-form-label">메일</label>
								<c:if test="${ isMypage }">
									<input class="form-control" id="enterpriseemail" name="enterpriseemail" value="${enter.enterpriseemail}" autocomplete="off">
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" id="enterpriseemail" name="enterpriseemail" value="${enter.enterpriseemail}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
							
							<div class="form-group">
								<label for="enterprisebizno" class="col-form-label">사업자번호</label>
								<c:if test="${ isMypage }">
									<input class="form-control" id="enterprisebizno" name="enterprisebizno" value="${enter.enterprisebizno}" autocomplete="off">
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" id="enterprisebizno" name="enterprisebizno" value="${enter.enterprisebizno}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>
						
						<div class="col-6">
							<div class="form-group">
								<label for="enterpriseurl" class="col-form-label">홈페이지</label>
								<c:if test="${ isMypage }">
									<input class="form-control" id="enterpriseurl" name="enterpriseurl" value="${enter.enterpriseurl}" autocomplete="off">
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" id="enterpriseurl" name="enterpriseurl" value="${enter.enterpriseurl}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>
				
						<div class="col-6">
							<div class="form-group">
								<label for="enterprisearea" class="col-form-label">지역</label>
								<c:if test="${ isMypage }">
									<input class="form-control" id="enterprisearea" name="enterprisearea" value="${enter.enterprisearea}" autocomplete="off">
								</c:if>
								<c:if test="${ ! isMypage }">
									<input class="form-control" id="enterprisearea" name="enterprisearea" value="${enter.enterprisearea}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>
						
						<div class="col-12">
							<div class="form-group">
								<label for="enterpriseabout" class="col-form-label">기업홍보</label>
								<c:if test="${ isMypage }">
									<input type="hidden" class="form-control contents" id="enterpriseabout" name="enterpriseabout" value="${enter.enterpriseabout}" autocomplete="off">
									<div class="code-html">
										<div id="editSection">${enter.enterpriseabout}</div> 
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
									<input class="form-control contents" id="enterpriseabout" name="enterpriseabout" value="${enter.enterpriseabout}" autocomplete="off" disabled="disabled">
								</c:if>
							</div>
						</div>
						
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
					<input type="password" class="form-control" name="enterprisepassword" placeholder="기존 비밀번호">
				</div>
				<div class="input-group mb-3">
					<input type="password" class="form-control" name="enterprisepasswordnew" placeholder="새 비밀번호">
				</div>
				<div class="input-group mb-3">
					<input type="password" class="form-control" name="enterprisepasswordnew2" placeholder="새 비밀번호 확인">
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

// 비밀번호 팝업 열기/닫기
function fnPopupPw(){
	if('none' == $('#popupPw').css('display')) $('#popupPw').css('display', 'block');
	else if('block' == $('#popupPw').css('display')) $('#popupPw').css('display', 'none');

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
	
	$.ajax({
		enctype	: 'multipart/form-data',
		url			: '/enterprises/upload',
		data		: fileData,
		type		: 'post',
		processData: false, 
		contentType: false,
		cache		: false,
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
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
</script>
</body>
</html>