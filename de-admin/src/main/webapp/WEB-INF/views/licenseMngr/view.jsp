<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<body>
<form id="frm" name="frm" method="post">
<input type="hidden" name="seq" value="${result.seq }" />
<input type="hidden" name="pageNo" value="" />
<input type="hidden" name="business_code" value="${result.license_cd }" />
<input type="hidden" name="bizcd" value="${result.bizcd }" />
<%-- <input type="hidden" name="consent" value="${result.consent }" />
<input type="hidden" name="request" value="${result.request }" />
<c:if test="${result ne null }">
<input type="hidden" name="bizcd" id="bizcd" value="${result.bizcd}" />
<input type="hidden" name="seq" id="seq" value="${result.seq}" />
<input type="hidden" name="writer_id" id="writer_id" value="${result.writer_id }"/>
<input type="hidden" name="writer_name" id="writer_name" value="${result.writer_name }"/>
</c:if>
<c:if test="${params ne null }">
<!-- 저장필수값 -->
<input type="hidden" name="bizcd" id="bizcd" value="" />
<input type="hidden" name="writer_id" id="writer_id" value=""/>
<input type="hidden" name="writer_name" id="writer_name" value=""/>
<input type="hidden" name="business_code" id="business_code" value=""/>
</c:if> --%>
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>라이센스 상세정보</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 비즈니스 / 라이센스 상세정보</span>
			</div>
		</div>
	</div>
	

<!-- general form elements -->
	<div class="col-12">
		<div class="card card-primary">
			
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>라이센스 상세정보</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약명</label>
						<span class="form-control"><c:out value="${result.contract}"/></span>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">공급사</label>
						<span class="form-control"><c:out value="${result.supply_name}"/></span>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약기간</label>
						<span class="form-control"><c:out value="${result.license_period}"/></span>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">수요사</label>
						<span class="form-control"><c:out value="${result.demand_name}"/></span>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">라이센스 개수</label>
						<span class="form-control"><c:out value="${result.license_count}"/></span>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약번호</label>
						<span class="form-control"><c:out value="${result.license_cd}"/></span>
					</div>
				</div>
				
				<div class="col-lg-12">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">라이센스</label>
						<a href="#" onclick="fnExcel('${result.license_cd}')" class="form-control">
							<i class="fa fa-save"></i> 라이센스 다운로드
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="col-12">
	<div class="card">
	  	
	  	<div class="row mb-2">
			<div class="col-sm-4">
				<h5>라이센스 상세정보</h5>
			</div>
	  	
	    <!-- <h3 class="card-title"></h3> -->
	    <div class="col-sm-8">
	      <div class="input-group input-group-sm float-right" style="width: 150px;">
	        <input type="text" name="table_search" class="form-control float-right" placeholder="Search">
	        <div class="input-group-append">
	          <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
	        </div>
	      </div>
	    </div>
	  </div>
	  
	  <%-- <p><strong>총 <span class="total"><c:out value="${paginationInfo.totalRecordCount}"/></span>건중, 현재페이지 <i class="min">${paginationInfo.currentPageNo}</i>/<i class="max">${paginationInfo.totalPageCount}</i></strong></p> --%>
	  <!-- /.card-header -->
	  <div class="card-body table-responsive p-0">
	    <table class="table table-hover text-nowrap">
	    	<colgroup>
	    		<col width="10%" />
	    		<col width="45%" />
	    		<col width="25%" />
	    		<col width="10%" />
	    		<col width="10%" />
	    	</colgroup>
	      <thead>
	        <tr>
	          <th>번호</th>
	          <th>라이센스 번호</th>
	          <th>라이센스 기간</th>
	          <th>사용여부</th>
	          <th>라이센스 등록일</th>
	        </tr>
	      </thead>
	      <tbody>
	        <c:forEach var="list" items="${list}" varStatus="status">
				<tr>
				  <th scope="row">${paginationInfo.totalRecordCount - ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage + status.index) }</th>
				<td>${list.license_no }</td>
				<td>${list.license_pd_st } ~ ${list.license_pd_ed }</td>
				<c:if test="${not empty list.used}">
				<td>사용중</td>
				<td>${list.used }</td>
				</c:if>
				<c:if test="${empty list.used}">
				<td>-</td>
				<td><%-- <fmt:formatDate value="${list.reg_date}" pattern="yyyy-MM-dd" /> --%></td>
				</c:if>
				</tr>
			</c:forEach>
			<c:if test="${empty list}"> <!-- 게시물이 없을 경우 -->
				<tr>
					<td colspan="5"><p class="nodata">결과가 없습니다.</p></td>
				</tr>
			</c:if>
	      </tbody>
	    </table>
	  </div>
	  <!-- /.card-body -->
	  
		<div class="card-footer row">
			<!-- page number -->
			<ul class="pagination justify-content-left m-0 col-6">
				<ui:pagination paginationInfo = "${paginationInfo}" type="text" jsFunction="linkPage"/>
			</ul>
			<div class="col-6 cont_btn_div tbl_list">
			</div>
		</div>
	</div>
	
	<!-- /.card -->
	</div>
</div>
</form>

<%-- 
<div class="card-footer">
    <c:if test="${result.request eq 1 and result.consent eq 0}">
    	 <button type="button" id="btnConsent" class="btn btn-primary"> 승인</button>
    	 <button type="button" id="btnRequest" class="btn btn-primary"> 반려</button>
    	 </c:if>
    	 <c:if test="${result.consent eq 1}">
    	 <button type="button" id="btnConsent" class="btn btn-primary"> 승인취소</button>
    	 <!-- <button type="button" id="btnSale" class="btn btn-primary"> 판매 계획서 작성</button> -->
    	 </c:if>
    	 <c:if test="${result.consent eq 0}">
       <!-- <button type="button" id="btnUpdate" class="btn btn-primary"> 수정</button> -->
       </c:if>
       <button type="button" class="btn btn-primary" onclick="location.href='list.ivs'"> 목록</button>
</div>
--%>
<script type="text/javascript">

   function linkPage(pageNo){
	   document.frm.pageNo.value=pageNo;
	   document.frm.action = "view.ivs";
		document.frm.submit();
		//location.href = "view.ivs?pageNo="+pageNo;
	}
$(function() {
	//승인 버튼
	 $("#btnConsent").on("click",fnConsent);	
    $("#btnRequest").on("click",fnRequest);	
    $("#btnContract").on("click",fnContract);
    $("#btnUpdate").on("click",fnUpdate);
		//숫자 콤마
    $("#total_price").text(numberWithCommas("${total_price}")+" 원");
    $("#price").text(numberWithCommas("${price}")+" 원");
    $("#sale_qy").text(numberWithCommas("${sale_qy}")+" 대");
    $("#contract_amount").text(numberWithCommas("${contract_amount}")+" 원");
});
//승인
function fnConsent() {
	document.frm.action = "updateConsent.proc";
	document.frm.submit();
}
//반려
function fnRequest() {
	document.frm.request.value=0;
	document.frm.action = "updateRequest.proc";
	document.frm.submit();
}
function fnUpdate() {
	document.frm.action = "save.ivs";
	document.frm.submit();
}
function fnContract() {
	document.frm.action = "/contract/save.ivs";
	document.frm.submit();
}
//엑셀다운로드
function fnExcel(x){
	document.frm.business_code.value=x;
	document.frm.action = "/delivery/excel.proc";
	document.frm.submit();
}	
</script>
</body>
</html>