<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>

<style>
.card.bg-light { 
	box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2); 
	overflow: hidden;
	padding: 30px;
}
.card.bg-light .card-body { background: none }

.card-header { padding: .75rem 1.25rem }

.card-body { border-top: 0 }
.card-body .lead { margin: 1em 0 .5em 0 }
.card-body .lead b { 
	 display: block;
	text-decoration: none;
	color: #333;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}
.card-body ul { margin: 0 !important }

.card-footer.row { margin: 0 }
.card-footer button.btn-sm { 
	font-size: .75em; 
	margin: 0;
}
</style>

<body>
<form id="frm" name="frm" method="post">
<input type="hidden" name="seq" value="${result.seq }" />
<input type="hidden" name="consent" value="${result.consent }" />
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
</c:if>
<!-- 스프링 시큐리티 form에 추가 해줘야함. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

<div class="row">

	<div id="input_div" class="col-12 " style="margin-top: .75rem;">
		<div class="callout callout-info row ">
			<div class="col-6">
				<h5>계약주요 사항</h5>
			</div>
			<div class="col-6">
				<span class="float-right  "><a href="/main/index">Home</a> / 비즈니스 / 계약주요 사항</span>
			</div>
		</div>
	</div>


<!-- general form elements -->
	<div class="col-12">

		<div class="card card-primary">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약주요 사항</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약명</label>
						<span  class="form-control"><c:out value="${result.contract}"/></span>
					 </div>
				 </div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">총금액</label>
						<c:set value="${result.contract_amount}" var="contract_amount" />
						<span  class="form-control" id="contract_amount"></span>
					 </div>
				 </div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약기간</label>
						<span  class="form-control"><c:out value="${result.contract_period}"/></span>
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">계약체결일</label>
						<span  class="form-control"><c:out value="${result.contract_date}"/></span>
					 </div>
				 </div>
				 
			</div>
		</div>


		<div class="card card-primary">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약당사자</h5>
				</div>
			</div>

			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
		              <div class="card bg-light">
		                <!-- <div class="card-header text-muted border-bottom-0"><b>수요자</b></div> -->
			                <div class="card-body pt-0">
			                  <div class="row">

									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">수요자 상호</label>
											<span  class="form-control"><c:out value="${result.demand_name}"/></span>
										 </div>
									 </div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">주소</label>
											<span  class="form-control"><c:out value="${result.demand_addr}"/></span>
										 </div>
									 </div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">사업자번호</label>
											<span  class="form-control"><c:out value="${result.demand_bizno}"/></span>
										 </div>
									 </div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">대표이사</label>
											<span  class="form-control"><c:out value="${result.demand_cxfc}"/></span>
										 </div>
									 </div>
								 </div>
							 </div>
						 </div>
					 </div>


					<div class="col-lg-6">
		              <div class="card bg-light">
		                <!-- <div class="card-header text-muted border-bottom-0"><b>공급자</b></div> -->
			                <div class="card-body pt-0">
			                  <div class="row">
			                  
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">공급자 상호</label>
											<span  class="form-control"><c:out value="${result.supply_name}"/></span>
										 </div>
									 </div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">주소</label>
											<span  class="form-control"><c:out value="${result.supply_addr}"/></span>
										 </div>
									 </div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">사업자번호</label>
											<span  class="form-control"><c:out value="${result.supply_bizno}"/></span>
										 </div>
									 </div>
									
									<div class="col-lg-12">
										<div class="form-group">
											<label for="inputEmail3" class="col-form-label">대표이사</label>
											<span  class="form-control"><c:out value="${result.supply_cxfc}"/></span>
										 </div>
									 </div>
								 </div>
							 </div>
						 </div>
					 </div>
				 
			</div>
		</div>


		<div class="card card-primary">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약품목</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline row">

				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">아이템코드</label>
						<span  class="form-control"><c:out value="${result.product_section}"/></span>
					 </div>
				 </div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">납품일</label>
						<span  class="form-control"><c:out value="${result.offer_date}"/></span>
					 </div>
				 </div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">품명</label>
						<span  class="form-control"><c:out value="${result.product_name}"/></span>
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">단가</label>
						<c:set value="${result.price}" var="price" />
						<span  class="form-control" id="price"></span>
					</div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">수량</label>
						<c:set value="${result.sale_qy}" var="sale_qy" />
						<span  class="form-control" id="sale_qy"></span>
					 </div>
				</div>
				
				<div class="col-lg-6">
					<div class="form-group">
						<label for="inputEmail3" class="col-form-label">금액</label>
						<c:set value="${result.price * result.sale_qy}" var="total_price" />
						<span  class="form-control" id="total_price"></span>
					 </div>
				</div>
				 
			</div>
		</div>


		<div class="card card-primary">
			<div class="row mb-2">
				<div class="col-sm-12">
					<h5>계약조건 및 특약사항</h5>
				</div>
			</div>
			
			<div class="card-body card-primary card-outline">

				<div class="form-group">
					<label for="inputEmail3" class="col-form-label">계약조건</label>
					<span  class="form-control contents">${result.contract_cnd }</span>
				 </div>

				<div class="form-group">
					<label for="inputEmail3" class="col-form-label">특약사항</label>
					<span  class="form-control contents">${result.special_contract }</span>
				 </div>
			
				<div class="form-group" style="margin-bottom: 0">
					<label for="inputEmail3" class="col-form-label">계약서 첨부</label>
					<span  class="form-control contents" style="border: 0">
						<c:forEach items="${file }" var="item" varStatus="status">
							<a href="/fileDownload?fm=${item.filemakename}&fom=${item.filerealname}">${item.filerealname}</a>
						</c:forEach>
					</span>
				 </div>
			</div>
			
			<c:if test="${not empty comment}">
<div class="card-body table-responsive p-0">
                <table class="table table-hover text-nowrap" id="example2">
                  <thead>
                    <tr>
                      <th>구분</th>
                      <th>사유</th>
                      <th>등록일</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="item" items="${comment}" varStatus="status">
						    <tr>
						    <c:if test="${item.request eq 2}">
						    <td>반려</td>
						    </c:if>
						    <c:if test="${item.consent eq 2}">
						    <td>승인취소</td>
						    </c:if>
						    <c:if test="${empty item.request and empty item.consent}">
						    <td>-</td>
						    </c:if>
						    <c:if test="${not empty item.comment}"><td>${item.comment}</td></c:if>
						    <c:if test="${empty item.comment}"><td>-</td></c:if>
						      <td>
						      <c:if test="${not empty item.registerDate}">${item.registerDate}</c:if>
						      <c:if test="${empty item.registerDate}">-</c:if>
						      </td>
						    </tr>
						</c:forEach>
                  </tbody>
                </table>
              </div>
              </c:if>
			
			<div class="card-footer cont_btn_div">
				<c:if test="${result.consent eq 1 and result.request eq 0}">
					<button type="button" id="btnContract" class="btn btn-primary purple">계약서 상세 등록</button>
				</c:if>
				<c:if test="${result.consent ne 1 and result.request ne 1}">
					<button type="button" id="btnUpdate" class="btn btn-primary purple"> 수정</button>
					<button type="button" id="btnRequest" class="btn btn-primary purple" value="1">승인요청</button>
				</c:if>
				<c:if test="${result.request eq 1 and result.consent eq 0}">
					<button type="button" id="btnRequest" class="btn btn-primary red" value="0">승인요청취소</button>
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
    $("#btnRequest").on("click",fnRequest);	
    $("#btnContract").on("click",fnContract);
    $("#btnUpdate").on("click",fnUpdate);
		//숫자 콤마
    $("#total_price").text(numberWithCommas("${total_price}")+" 원");
    $("#price").text(numberWithCommas("${price}")+" 원");
    $("#sale_qy").text(numberWithCommas("${sale_qy}")+" 대");
    $("#contract_amount").text(numberWithCommas("${contract_amount}")+" 원");
    
});

function fnRequest() {
	var vv = $("#btnRequest").val();
	document.frm.request.value=vv;
	document.frm.action = "updateReqeust.proc";
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
</script>
</body>
</html>