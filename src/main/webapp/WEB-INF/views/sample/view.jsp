<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<body>
	<form id="frm" name="frm" method="post">
		<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
		<%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>

		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">sample view</h3>
					</div>

					<div class="card-body card-primary card-outline">

						<div class="form-group">
							<label for="title" class="col-form-label">Title</label> <span
								class="form-control">${result.title}</span>
						</div>

						<div class="form-group">
							<label for="writerId" class="col-form-label">ID</label> <span
								class="form-control">${result.userId}</span>
						</div>

						<div class="form-group">
							<label for="writerName" class="col-form-label">이름</label> <span
								class="form-control">${result.userName}</span>
						</div>
						<div class="form-group">
							<label for="contents" class="col-form-label">상세내용</label> <span
								class="form-control contents">${result.contents }</span>
						</div>

					</div>
					<div class="card-footer cont_btn_div">
						<a href="/sample/edit/${result.seq}" class="btn btn-primary purple">수정</a>
						<button type="button" class="btn btn-primary gray"
							onclick="location.href='/sample/list'">목록</button>
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
	</script>
</body>
</html>