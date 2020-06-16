<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<body>
<form id="frm" name="frm" method="post">
<input type="hidden" name="seq" value="${result.seq }" />
<input type="hidden" name="price" value="${result.price }" />
<input type="hidden" name="consent" value="${result.consent }" />
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>견적관리</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 견적관리</span>
			</div>
		</div>
	</div>
	
	<section class="content-header" style="padding: 2px .5rem;margin-top: 34px;">
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>견적관리</h5>
				</div>
			</div>
		</div>
	</section>

    <!-- Content Header (Page header) -->
    <div class="col-lg-12">
		<div class="card card-primary">
		
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">제목</label>
						<span  class="form-control">${result.subject}</span>
					 </div>
				 </div>
				
				<div class="col-lg-4">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">요청가격</label>
						<span  class="form-control">${result.price} 원</span>
					 </div>
				 </div>
				
				<div class="col-lg-4">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">ID</label>
						<span  class="form-control">${result.writer_id}</span>
					 </div>
				 </div>
				
				<div class="col-lg-4">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">이름</label>
						<span  class="form-control">${result.writer_name}</span>
					 </div>
				 </div>
				
				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">상세내용</label>
						<span  class="form-control contents">${result.content }</span>
					 </div>
				 </div>

			</div>


			<div class="card-footer cont_btn_div">
				<c:if test="${result.consent eq 1}">
					<button type="button" id="btnSale" class="btn btn-primary purple"> 판매 계획서 작성</button>
				</c:if>
				<c:if test="${result.consent eq 0 or result.consent eq 2}">
					<button type="button" id="btnUpdate" class="btn btn-primary purple"> 수정</button>
				</c:if>
				<button type="button" class="btn btn-primary gray" onclick="location.href='list.ivs'"> 목록</button>
			</div>
		</div>
	</div>
</div>
</form>

<script type="text/javascript">
$(function() {
	//승인 버튼
    $("#btnConsent").on("click",fnConsent);	
    $("#btnUpdate").on("click",fnUpdate);	
    $("#btnSale").on("click",fnSale);	
});

function fnConsent() {
	document.frm.action = "updateConsent.proc";
	document.frm.submit();
}

function fnUpdate() {
	document.frm.action = "save.ivs";
	document.frm.submit();
}

function fnSale() {
	//document.getElementById("seq").value="";
	//document.frm.seq.value="";
	document.frm.action = "/saleplan/save.ivs";
	document.frm.submit();
	//location.href = "/saleplan/save.ivs?price=${result.price}";
}
</script>
</body>
</html>