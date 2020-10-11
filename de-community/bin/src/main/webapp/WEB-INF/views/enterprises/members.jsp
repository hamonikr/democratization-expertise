<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<head>
<style type="text/css">
.dash-list { height: 25px }
.dash-list > a { margin-left: 8px }
.dash-list .tagSpan { 
	margin-left: 0;
	margin-right: 5px;
	margin-bottom: 5px; 
}

.enterprise-list { margin: 0 }
.enterprise-list-card { 
	border: 1px solid #ddd;
	margin: 0; 
}
.enterprise-list-card p { margin: 0 }
.enterprise-list-card .title { font-weight: bold }
.enterprise-list-card .position {  }
.enterprise-list-card .reputation {  }
</style>
</head>

<body>
	<form id="frm" name="frm" method="post">
		<input type="hidden" name="_csrf" value="${_csrf.token}">
		<input type="hidden" name="_csrf_header" value="${_csrf.headerName}"/>
		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<a href="/enterprises/activity/${enterpriseno}" class="btn btn-primary">활동정보</a>
				<a href="/enterprises/profile/${enterpriseno}" class="btn btn-primary">프로필</a>
				<a href="/enterprises/members/${enterpriseno}" class="btn btn-primary">사람들</a>
			</div>
			
			<div class="col-12">
				<div class="card card-primary" style="width: 100%;">

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
	</form>

<!-- FLOT CHARTS -->
<script src="../../plugins/flot/jquery.flot.js"></script>
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


$(function() {
	
	/*
	 * LINE CHART
	 * ----------
	 */
	//LINE randomly generated data
	var sin = [],
	    cos = []
	for (var i = 0; i < 14; i += 0.5) {
	  sin.push([i, Math.sin(i)])
	  cos.push([i, Math.cos(i)])
	}
	
	var line_data1 = {
	  data : sin,
	  color: '#3c8dbc'
	}
	var line_data2 = {
	  data : cos,
	  color: '#00c0ef'
	}
	$.plot('#line-chart', [line_data1, line_data2], {
	  grid  : {
	    hoverable  : true,
	    borderColor: '#f3f3f3',
	    borderWidth: 1,
	    tickColor  : '#f3f3f3'
	  },
	  series: {
	    shadowSize: 0,
	    lines     : {
	      show: true
	    },
	    points    : {
	      show: true
	    }
	  },
	  lines : {
	    fill : false,
	    color: ['#42A5F5', '#f56954']
	  },
	  yaxis : {
	    show: true
	  },
	  xaxis : {
	    show: true
	  }
	})
	//Initialize tooltip on hover
	$('<div class="tooltip-inner" id="line-chart-tooltip"></div>').css({
	  position: 'absolute',
	  display : 'none',
	  opacity : 0.8
	}).appendTo('body')
	$('#line-chart').bind('plothover', function (event, pos, item) {
	
	  if (item) {
	    var x = item.datapoint[0].toFixed(2),
	        y = item.datapoint[1].toFixed(2)
	
	    $('#line-chart-tooltip').html(item.series.label + ' of ' + x + ' = ' + y)
	      .css({
	        top : item.pageY + 5,
	        left: item.pageX + 5
	      })
	      .fadeIn(200)
	  } else {
	    $('#line-chart-tooltip').hide()
	  }
	
	});
});
/* END LINE CHART */
</script>
</body>
</html>