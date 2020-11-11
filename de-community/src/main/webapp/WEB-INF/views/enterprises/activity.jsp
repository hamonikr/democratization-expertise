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
           		<c:if test="${ isMypage }">
			   	<a class="nav-link" id="custom-tabs-three-members-tab" data-toggle="pill" href="#custom-tabs-three-members" role="tab" aria-controls="custom-tabs-three-members" aria-selected="false">Members</a>
			</c:if>
           	</li>
	</ul>
	
	
<div class="tab-content" id="custom-tabs-three-tabContent">

	<div class=" tab-pane fade active show con-box" id="custom-tabs-three-home" role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
		<div class="profile-con">
		
			<form id="frm" name="frm" method="post">
				<input type="hidden" name="_csrf" value="${_csrf.token}">
				<input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
				<input type="hidden" name="enterpriseno" value="${enterprise.enterpriseno}">
			
			
				<div class="profile-photo">
					<c:if test="${user.userprofileimg != null}">
						<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
					</c:if>
					<c:if test="${user.userprofileimg == null}">
						<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
					</c:if>
									
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
		                   <p class="myinfo">질문 : <span>456</span> <br> 답변 : <span>89</span></p>
	                 	</li>
					</ul>
				</div>
	            
	            
	            <!--  list -->
	             <div class="mywrit-con">

                <div class="mywrit">
                  <div class="mytitle">
                    질문 (${ qCnt })
                    <span class="more">
                    	<c:if test="${ qCnt > 5 }">
							<form action="/questions/myList">
								<input type="hidden" name="userno" value="${ user.userno }">
								<input type="hidden" name="section" value="Q">
								<button type="submit" class="btn-primary btn-xs" >+더보기</button>
							</form>
						</c:if>
                    </span>
                  </div>
                  				<c:forEach var="list" items="${ qList }" varStatus="status">
									<div class="dash-list">
										<a href="/questions/view/${ list.questionno }">${ list.title }</a>
									</div>
								</c:forEach>
								
								
								
                  <ul>
                  <c:forEach var="list" items="${ qList }" varStatus="status">
									<li>
										<span class="up"><i class="mdi"></i>Q.</span>
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
								<button type="submit" class="btn-primary btn-xs" >+더보기</button>
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
                </div><!-- // 답변 -->

                <div class="mywrit">
                  <div class="mytitle">
                    Tags (${ tCnt })
                    <c:if test="${ tCnt > 5 }">
						<form action="/questions/myList">
							<input type="hidden" name="userno" value="${ user.userno }">
							<input type="hidden" name="type" value="A">
							<button type="submit" class="btn-primary btn-xs" >더보기</button>
						</form>
					</c:if>
                  </div>
                   <span class="ques-tag">
						<c:forEach var="list" items="${ tList }" varStatus="status">
							<a href="/wiki/view/${ list.wikino }" class="float-left badge bg-primary tagSpan">${ list.title }</span>
						</c:forEach>
					</span>
                </div><!-- // Tags -->

                <div class="mywrit other">
                  <div class="mytitle">
                    Wiki (569)
                    <span class="more"><a href="#">+더보기</a></span>
                  </div>
                  <ul>
                    <li>
                      <a href="#">wiki 문서 제목나옵니다.</a>
                    </li>
                  </ul>
                </div><!-- // wiki -->
              </div>
              
              
              
			</form>             
		</div>
	</div>
</div>
		
		
		
		
		
		
					
					
						<div class="card-body card-primary row" style="width: 100%;">
						
							<div class="col-6">
								
							</div>
						
							<div class="col-6">
								
							</div>
						</div>
					
					
						<div class="card-body card-primary row" style="width: 100%;">
						
							<div class="col-6 row">
								<div class="col-12">태그()</div>
								<hr/>
								
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
						
						<div class="card-body card-primary card-outline row" style="width: 100%;">

							<div class="col-3 profileLeftDiv">
								<c:if test="${enterprise.enterpriseimg != null && enterprise.enterpriseimg != ''}">
									<img alt="profile" src="/upload/enterprise/${enterprise.enterpriseimg}" id="profileImg" class="img" width="100%"><br/>
								</c:if>
								<c:if test="${enterprise.enterpriseimg == null || enterprise.enterpriseimg == ''}">
									<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
								</c:if>
				
								<c:if test="${ isMypage }">
									<label class="btn btn-block btn-outline-primary" >
										<input type="hidden" name="userprofileimg" value="${enterprise.enterpriseimg}">
										<input id="iptProfileImg" name="profileImg" type="file" onchange="fnProfileImg()" style="display: none;">
										<span>사진변경</span><br/>
									</label>
									<button type="button" id="btnPw" class="btn btn-block btn-outline-primary">비밀번호 변경</button>
								</c:if>
							</div>

							<div class="col-9 profileRightDiv">
								<div class="form-group">
									<label for="userName" class="col-form-label">상호명</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="enterprisename" name="enterprisename" value="${enterprise.enterprisename}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="enterprisename" name="enterprisename" value="${enterprise.enterprisename}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>

								<div class="form-group">
									<label for="userEmail" class="col-form-label">메일</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="enterpriseemail" name="enterpriseemail" value="${enterprise.enterpriseemail}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="enterpriseemail" name="enterpriseemail" value="${enterprise.enterpriseemail}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
								
								<div class="form-group">
									<label for="userUrl" class="col-form-label">홈페이지</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="enterpriseurl" name="enterpriseurl" value="${enterprise.enterpriseurl}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="enterpriseurl" name="enterpriseurl" value="${enterprise.enterpriseurl}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
								
								<div class="form-group">
									<label for="enterprisearea" class="col-form-label">지역</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="enterprisearea" name="enterprisearea" value="${enterprise.enterprisearea}" autocomplete="off">
									</c:if>
									<c:if test="${ !isMypage }">
										<input class="form-control" id="enterprisearea" name="enterprisearea" value="${enterprise.enterprisearea}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
								
								<div class="form-group">
									<label for="enterpriseName" class="col-form-label">사업자번호</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="enterprisebizno" name="enterprisebizno" value="${enterprise.enterprisebizno}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="enterprisebizno" name="enterprisebizno" value="${enterprise.enterprisebizno}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
							</div>
						
							<div class="col-12">
								<div class="form-group">
									<label for="aboutMe" class="col-form-label">기업홍보</label>
									<c:if test="${ isMypage }">
										<input type="hidden" class="form-control contents" id="enterpriseabout" name="enterpriseabout" value="${enterprise.enterpriseabout}" autocomplete="off">
										<div class="code-html">
											<div id="editSection">${enterprise.enterpriseabout}</div> 
										</div>
										
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control contents" id="enterpriseabout" name="enterpriseabout" value="${enterprise.enterpriseabout}" autocomplete="off" disabled="disabled">
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
					
					
					<div class="tab-pane fade" id="custom-tabs-three-members" role="tabpanel" aria-labelledby="custom-tabs-three-members-tab">
						
						<div class="card-body card-primary row" style="width: 100%;">
						<!-- 승인된 유저 -->
						<div class="col-12">
							<div>활동중인 사람들</div>
							<hr/>
							<div class="enterprise-list row">
								
								<c:if test="${ atusers.size() == 0 }">
									<p>활동중인 사람이 없습니다.</p>
								</c:if>
								
								<c:if test="${ atusers.size() != 0 }">
									<c:forEach var="mem" items="${ atusers }" varStatus="status">
										<c:if test="${ mem.usersDetail != null && mem.usersDetail.userat !=0 }">
											
											<div class="enterprise-list-card col-6 row">
												<div class="col-4">
													<a href="/users/activity/${mem.userno}">
														<c:if test="${ mem.userprofileimg != null && mem.userprofileimg != ''}">
															<img alt="profile" src="/upload/users/${mem.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
														</c:if>
														<c:if test="${ mem.userprofileimg == null || mem.userprofileimg == ''}">
															<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
														</c:if>
													</a>
												</div>
												
												<div class="col-4">
													<p class="title">
														<a href="/users/activity/${mem.userno}">${mem.username}</a>
													</p>
													<p class="position">CEO</p>
													<p class="reputation">평판 300</p>
												</div>
												
												<div class="col-4">
													
													<!-- 활성 -->
													<c:if test="${ mem.usersDetail.userat == 1 }">
														<input disabled type="button" class="btn btn-primary active" onclick="fnt_activeatUser('userat','${mem.userno}');" value="활성"><br/>
														<input type="button" class="btn btn-primary" onclick="fnt_activeatUser('not','${mem.userno}');" value="비활성">
													</c:if>
													
													<!-- 비활성 -->
													<c:if test="${ mem.usersDetail.userat == 3 }">
														<input type="button" class="btn btn-primary" onclick="fnt_activeatUser('userat','${mem.userno}');" value="활성"><br/>
<%-- 														<input type="button" class="btn btn-primary active" onclick="fnt_activeatUser('not','${mem.userno}');" value="비활성">
 --%>													</c:if>
													
												</div>
											</div>
											
										</c:if>
									</c:forEach>
								</c:if>
									<c:if test="${ unatusers.size() != 0 }">
									<c:forEach var="mem" items="${ unatusers }" varStatus="status">
										<c:if test="${ mem.usersDetail != null && mem.usersDetail.userat !=0 }">
											
											<div class="enterprise-list-card col-6 row">
												<div class="col-4">
													<a href="/users/activity/${mem.userno}">
														<c:if test="${ mem.userprofileimg != null && mem.userprofileimg != ''}">
															<img alt="profile" src="/upload/users/${mem.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
														</c:if>
														<c:if test="${ mem.userprofileimg == null || mem.userprofileimg == ''}">
															<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
														</c:if>
													</a>
												</div>
												
												<div class="col-4">
													<p class="title">
														<a href="/users/activity/${mem.userno}">${mem.username}</a>
													</p>
													<p class="position">CEO</p>
													<p class="reputation">평판 300</p>
												</div>
												
												<div class="col-4">
													
													<!-- 활성 -->
													<c:if test="${ mem.usersDetail.userat == 1 }">
													<input disabled type="button" class="btn btn-primary" onclick="fnt_activeatUser('userat','${mem.userno}');" value="활성"><br/>
 													<input disabled type="button" class="btn btn-primary active" onclick="fnt_activeatUser('not','${mem.userno}');" value="비활성">
													</c:if>
													
													<!-- 비활성 -->
													<c:if test="${ mem.usersDetail.userat == 3 }">
														<input type="button" class="btn btn-primary" onclick="fnt_activeatUser('userat','${mem.userno}');" value="활성"><br/>
 														<input disabled type="button" class="btn btn-primary active" onclick="fnt_activeatUser('not','${mem.userno}');" value="비활성">
												</c:if>
													
												</div>
											</div>
											
										</c:if>
									</c:forEach>
								</c:if>
								
							</div>
						</div>

						
						<div class="col-12">
							<div>요청한 사람들</div>
							<hr/>
							<div class="enterprise-list row">
								<c:if test="${ users.size() == 0 }">
									<p>요청한 사람이 없습니다.</p>
								</c:if>
								
								<c:if test="${ users.size() != 0 }">
									<c:forEach var="mem" items="${ users }" varStatus="status">
										<c:if test="${ mem.usersDetail != null && mem.usersDetail.userat == 0 }">
											
											<div class="enterprise-list-card col-6 row">
												<div class="col-4">
													<a href="/users/activity/${mem.userno}">
														<c:if test="${ mem.userprofileimg != null && mem.userprofileimg != ''}">
															<img alt="profile" src="/upload/users/${mem.userprofileimg}" id="profileImg" class="img" width="100%"><br/>
														</c:if>
														<c:if test="${ mem.userprofileimg == null || mem.userprofileimg == ''}">
															<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
														</c:if>
													</a>
												</div>
												
												<div class="col-4">
													<p class="title">
														<a href="/users/activity/${mem.userno}">${mem.username}</a>
													</p>
													<p class="reputation">평판 300</p>
												</div>
												
												<div class="col-4">
												<%-- 	<c:if test="${ isMypage }">
														<input type="button" class="btn btn-primary" onclick="fnt_useratUser('userat','${mem.userno}');" value="승인"><br/>
														<input type="button" class="btn btn-primary" onclick="fnt_useratUser('not','${mem.userno}');" value="거절">
													</c:if> --%>
													<input type="button" class="btn btn-primary" onclick="fnt_useratUser('userat','${mem.userno}');" value="승인"><br> 
													<input type="button" class="btn btn-primary" onclick="fnt_useratUser('not','${mem.userno}');" value="거절">													
												</div>
											</div>
											
										</c:if>
									</c:forEach>
								</c:if>
								
							</div>
						</div>
						
					</div>
						
						
					</div>
					
					
				</div>
			</div>
		</div>
	</div>
	
	</section>


</div>


<!-- FLOT CHARTS -->
<!-- <script src="../../plugins/flot/jquery.flot.js"></script> -->
<script type="text/javascript">
</script>

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

//비밀번호 팝업 열기/닫기
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

// 승인1/거절2
function fnt_useratUser(type,uno){
	if(type == 'not') type = 2;
	else if(type == 'userat') type = 1;
	else return;
	alert(type);
	$.ajax({
		url			: '/enterprises/updateUserat',
		data		: { 'userat' : type , 'userno' : uno},
		type		: 'post',
		/* beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		}, */
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
	
	$.ajax({
		url			: '/enterprises/updateUserat',
		data		: { 'userat' : type , 'userno' : uno},
		type		: 'post',
		/* beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		}, */
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

</body>
</html>