<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<body>
	<form id="frm" name="frm" method="post">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title"></h3>
					</div>

					<div class="card-body card-primary card-outline">

						<div class="form-group">
							<label for="title" class="col-form-label">Title</label> <span
								class="form-control">${result.title}</span>
						</div>
						
						<div class="form-group">
							<label for="title" class="col-form-label">등록일</label> <span
								class="form-control"><fmt:formatDate value="${result.registerdate}" pattern="yyyy-MM-dd" /></span>
						</div>
						
						<div class="form-group">
							<label for="title" class="col-form-label">조회수</label> <span
								class="form-control">${result.readcnt}</span>
						</div>

						<div class="form-group">
							<label for="writerId" class="col-form-label">ID</label> <span
								class="form-control">${result.users.userid}</span>
						</div>

						<div class="form-group">
							<label for="writerName" class="col-form-label">이름</label> <span
								class="form-control">${result.users.username}</span>
						</div>
						<div class="form-group">
							<label for="contents" class="col-form-label">상세내용</label> <span
								class="form-control contents">${result.contents }</span>
						</div>
						
						<div class="form-group">
							<label for="contents" class="col-form-label">태그</label> <span
								class="form-control contents">${result.tagno }</span>
						</div>
						
						<div class="form-group">
							<label for="writerName" class="col-form-label"><a href="#" onclick="fnLike('${result.questionno}','${result.userno}','Q','${result.vote.likes }')">like</a></label> <span
								class="form-control"><div id="like">${result.vote.likes }</div></span>
						</div>
						<div class="form-group">
							<label for="writerName" class="col-form-label"><a href="#" onclick="fnDisLike('${result.questionno}','${result.userno}','Q','${result.vote.dislikes }')">dislike</a></label> <span
								class="form-control"><div id="dislike">${result.vote.dislikes }</div></span>
						</div>

					</div>
					<div class="card-footer cont_btn_div">
					<c:if test="${(result.editauth eq 1 or result.userno eq user.userno)}">
						<a href="/questions/edit/${result.questionno}" class="btn btn-primary purple">수정</a>
						</c:if>
						<button type="button" class="btn btn-primary gray"
							onclick="location.href='/questions/list'">목록</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<script type="text/javascript">
		$(function() {
			//승인 버튼
			$("#btnConsent").on("click", fnConsent);
			$("#btnUpdate").on("click", fnUpdate);
			$("#btnSale").on("click", fnSale);
		});

		function fnUpdate() {
			document.frm.action = "save.ivs";
			document.frm.submit();
		}

		function fnLike(p,su,s,l){
			var like = l;
			console.log("like==="+like);
			$.ajax({ 
				//type: "POST", 
				contentType: "application/json", 
				url: "/vote/like", 
				data: {pno : p, section : s, userno : su , likes : 1}, 
				//dataType: 'json', 
				success: function (data) { 
					console.log(data);
					if (data == "FAIL"){
						alert("이미 투표하셨습니다.");
						/* $(".like").each(function(index, item){ 
							alert($(".like").eq(index).attr('value'));
						}) */
						}else if(data == "LOGIN"){
							alert("로그인 후 투표해주세요.");
							location.href = "/";
							}else{
							alert("투표하였습니다.");
							++l;
							$("#like").html(l);
						}
					}, 
					error: function (e) { 
						alert("fail"); 
					} 
					});

			}
		function fnDisLike(p,su,s,l){

			$.ajax({ 
				//type: "POST", 
				contentType: "application/json", 
				url: "/vote/dislike", 
				data: {pno : p, section : s, userno : su , dislikes : 1}, 
				//dataType: 'json', 
				success: function (data) { 
					console.log(data);
					if (data == "FAIL"){
						alert("이미 투표하셨습니다.");
						}else{
							alert("투표하였습니다.");
							++l;
							$("#dislike").html(l);
							}
					}, 
					error: function (e) { 
						alert("fail"); 
					} 
					});

			}
	</script>
</body>
</html>