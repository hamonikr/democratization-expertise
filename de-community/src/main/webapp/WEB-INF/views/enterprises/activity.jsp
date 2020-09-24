<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<head>


<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.48.4/codemirror.min.css"/>
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />


<style type="text/css">
/* .dash-list { height: 25px } */
/* .dash-list > a { margin-left: 8px } */
/* .dash-list .tagSpan {  */
/* 	margin-left: 0; */
/* 	margin-right: 5px; */
/* 	margin-bottom: 5px;  */
/* } */

/* .enterprise-list-card { border: 1px solid #ddd } */
/* .enterprise-list-card p { margin: 0 } */
/* .enterprise-list-card .title { font-weight: bold } */
/* .enterprise-list-card .position {  } */
/* .enterprise-list-card .reputation {  } */
</style>
</head>

<body>




		
	<section class="content" style="padding: 2px 12px 6px 19px;">
		
	
	<div class="col-12">
		<div class=" card-primary card-outline card-outline-tabs">
			<div class="card-header p-0 border-bottom-0">
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
			</div>
			
			<div class="col-12">
				<div class="tab-content" id="custom-tabs-three-tabContent">
					<div class="tab-pane fade active show" id="custom-tabs-three-home" role="tabpanel" aria-labelledby="custom-tabs-three-home-tab">
                     
						<div class="card-body card-primary row" style="width: 100%;">
							<div class="col-8 row">
								<div class="col-12"><h2><b>${enterprise.enterprisename}</b></h2><p>aboutme</p></div>
								<div class="col-6"><h4>평판</h4><span>123,456</span></div>
								<div class="col-6"><div id="line-chart" style="height: 300px;"></div></div>
							</div>
	
							<div class="col-4 profileLeftDiv">
<%-- 								<c:if test="${user.userprofileimg != null}"> --%>
<%-- 									<img alt="profile" src="/upload/users/${user.userprofileimg}" id="profileImg" class="img" width="100%"><br/> --%>
<%-- 								</c:if> --%>
<%-- 								<c:if test="${user.userprofileimg == null}"> --%>
									<img alt="profile" src="/img/user_over.png" id="profileImg" class="img" width="100%"><br/>
<%-- 								</c:if> --%>
								<span>배지 : </span>
								<span>홈페이지 : </span> <%-- <a href="${user.userurl}" target="_blank">${user.userurl}</a> --%>
							</div>
						</div>
					
					
						<div class="card-body card-primary row" style="width: 100%;">
						
							<div class="col-6">
								<div>질문()</div>
								<hr/>
								
							</div>
						
							<div class="col-6">
								<div>답변()</div>
								<hr/>
							</div>
						</div>
					
					
						<div class="card-body card-primary row" style="width: 100%;">
						
							<div class="col-6 row">
								<div class="col-12">태그()</div>
								<hr/>
								<div class="dash-list col-12">
								</div>
							</div>
						
							<div class="col-6">
								<div>위키()</div>
								<hr/>
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
										<input class="form-control" id="userName" name="username" value="${enterprise.enterprisename}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="userName" name="username" value="${enterprise.enterprisename}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>

								<div class="form-group">
									<label for="userEmail" class="col-form-label">메일</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="userEmail" name="useremail" value="${enterprise.enterpriseemail}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="userEmail" name="useremail" value="${enterprise.enterpriseemail}" autocomplete="off" disabled="disabled">
									</c:if>
								</div>
								
								<div class="form-group">
									<label for="userUrl" class="col-form-label">홈페이지</label>
									<c:if test="${ isMypage }">
										<input class="form-control" id="userUrl" name="userurl" value="${enterprise.enterpriseurl}" autocomplete="off">
									</c:if>
									<c:if test="${ ! isMypage }">
										<input class="form-control" id="userUrl" name="userurl" value="${enterprise.enterpriseurl}" autocomplete="off" disabled="disabled">
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
									<label for="aboutMe" class="col-form-label">자기소개</label>
									<c:if test="${ isMypage }">
										<input type="hidden" class="form-control contents" id="aboutMe" name="aboutme" value="${enterprise.enterpriseabout}" autocomplete="off">
										<div class="code-html">
											<div id="editSection">${enterprise.enterpriseabout}</div> 
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
										<input class="form-control contents" id="aboutMe" name="aboutme" value="${enterprise.enterpriseabout}" autocomplete="off" disabled="disabled">
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





<!-- FLOT CHARTS -->
<!-- <script src="../../plugins/flot/jquery.flot.js"></script> -->
<script type="text/javascript">
</script>

<script type="text/javascript">
// 승인/거절
function fnt_useratUser(type,uno){
	if(type == 'not') type = 2;
	else if(type == 'userat') type = 1;
	else return;
	
	$.ajax({
		url			: '/enterprises/updateUserat',
		data		: { 'userat' : type , 'userno' : uno},
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

//활성/비활성
function fnt_activeatUser(type,uno){
	if(type == 'not') type = 3;
	else if(type == 'userat') type = 1;
	else return;
	
	$.ajax({
		url			: '/enterprises/updateUserat',
		data		: { 'userat' : type , 'userno' : uno},
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


</script>

</body>
</html>