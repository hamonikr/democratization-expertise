<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<head>
<style type="text/css">

</style>
</head>

<body>
	<form id="frm" name="frm" method="post">
		<div class="row">
			<!-- Content Header (Page header) -->
			<div class="col-12">
				<a href="/users/dashboard/${result.userNo}" class="btn btn-primary">활동정보</a>
				<a href="/users/view/${result.userNo}" class="btn btn-primary">프로필</a>
			</div>
			
			<div class="col-12">
				<div class="card card-primary">
					<div class="card-header">
						<h3 class="card-title">활동정보</h3>
					</div>

					<div>
						<img alt="profile" src="/img/HamoniKR_logo600.png" class="img"><br/>
						<input type="button" id="" class="btn btn-primary" value="사진변경"><br/>
						<input type="button" id="" class="btn btn-primary" value="비밀번호 변경"><br/>
					</div>

					<div class="card-body card-primary card-outline">

						<div class="form-group">
							<label for="title" class="col-form-label">Title</label> <span
								class="form-control">${result}</span>
						</div>

						<div class="form-group">
							<label for="writerId" class="col-form-label">ID</label> <span
								class="form-control">${result}</span>
						</div>

						<div class="form-group">
							<label for="writerName" class="col-form-label">이름</label> <span
								class="form-control">${result}</span>
						</div>
						<div class="form-group">
							<label for="contents" class="col-form-label">상세내용</label> <span
								class="form-control contents">${result }</span>
						</div>

					</div>
					
						<div class="card-footer cont_btn_div">
						<a href="/sample/edit/${result}" class="btn btn-primary purple">수정</a>
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